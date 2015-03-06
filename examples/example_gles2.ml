open Glfw3
open GLFW

module Ct = Ctypes

let errorcb error desc =
  Printf.printf "GLFW error %d: %s\n" error desc

let blowup = ref false
let screenshot = ref false
let premult = ref false


let key window key scancode action mods =
  ignore (scancode, mods);
  if action = GLFW.press then begin
    if key = GLFW.key_escape then glfwSetWindowShouldClose window true
    else if key = GLFW.key_space then blowup := not !blowup
    else if key = GLFW.key_s then screenshot := not !screenshot
    else if key = GLFW.key_p then premult := not !premult
    else ()
  end

let () =
  let data = Ct.make Demo.demoData in
  let fps = Ct.make Perf.perfGraph in
  let prevt = ref 0.0 in

  if glfwInit () = false then begin
    Printf.printf("Failed to init GLFW.\n");
    exit (-1)
  end;

  Perf.initGraph (Ct.addr fps) Perf.GRAPH_RENDER_FPS "Frame Time" |> ignore;

  glfwSetErrorCallback errorcb |> ignore;

  glfwWindowHint GLFW.client_api GLFW.opengl_es_api;
  glfwWindowHint GLFW.context_version_major 2;
  glfwWindowHint GLFW.context_version_minor 0;

  let window =
    glfwCreateWindow 1000 600 "NanoVG"
      (Ct.from_voidp GLFW.monitor Ct.null)
      (Ct.from_voidp GLFW.window Ct.null) in

  match window with
  | None -> (glfwTerminate (); exit (-1))
  | Some window -> begin
      glfwSetKeyCallback window key |> ignore;
      glfwMakeContextCurrent window;
      let vg =
        try Nvg.createGLES2 (Nvg.antialias lor Nvg.stencil_strokes lor Nvg.debug)
        with Nvg.Memory_error -> begin
            Printf.printf "Could not init nanovg.\n%!";
            exit (-1)
          end in
      if not (Demo.loadDemoData vg (Ct.addr data))
      then exit (-1);

      glfwSwapInterval 0;
      glfwSetTime 0.0;
      prevt := glfwGetTime ();

      while not (glfwWindowShouldClose window) do
        let pxRatio, t, dt = ref 0.0, ref 0.0, ref 0.0 in
        let mx = Ct.allocate Ct.double 0.0 in
        let my = Ct.allocate Ct.double 0.0 in
        let winWidth = Ct.allocate Ct.int 0 in
        let winHeight = Ct.allocate Ct.int 0 in
        let fbWidth = Ct.allocate Ct.int 0 in
        let fbHeight = Ct.allocate Ct.int 0 in

        t := glfwGetTime ();
        dt := !t -. !prevt;
        prevt := !t;
        Perf.updateGraph (Ct.addr fps) !dt;

        glfwGetCursorPos window mx my;
        glfwGetWindowSize window winWidth winHeight;
        glfwGetFramebufferSize window fbWidth fbHeight;
        (* Calculate pixel ration for hi-dpi devices. *)
        pxRatio := Ct.((float_of_int !@fbWidth) /. (float_of_int !@fbHeight));

        (* Update and render *)
        Ct.(Gl.glViewport 0 0 !@fbWidth !@fbHeight);
        let () = 
          if !premult
          then Gl.glClearColor 0. 0. 0. 0.
          else Gl.glClearColor 0.3 0.3 0.32 1.0 in
        Gl.(
          let (lor) a b = Unsigned.UInt.logor a b in
          glClear (gl_color_buffer_bit lor gl_depth_buffer_bit lor gl_stencil_buffer_bit)
        );

        Gl.glEnable Gl.gl_blend;
        Gl.glBlendFunc Gl.gl_src_alpha Gl.gl_one_minus_src_alpha;
        Gl.glEnable Gl.gl_cull_face;
        Gl.glDisable Gl.gl_depth_test;

        Ct.(Nvg.beginFrame vg !@winWidth !@winHeight !pxRatio);

        Ct.(
          Demo.renderDemo vg !@mx !@my (float_of_int !@winWidth) (float_of_int !@winHeight) !t (Glfw3.int_of_bool !blowup) (addr data)
        );
        Perf.renderGraph vg 5. 5. (Ct.addr fps);

        Nvg.endFrame vg;

        Gl.glEnable Gl.gl_depth_test;

        if !screenshot then begin
          screenshot := false;
          Ct.(Demo.saveScreenShot !@fbWidth !@fbHeight !premult "dump.png");
        end;

        glfwSwapBuffers window;
        glfwPollEvents ();
      done;

      Demo.freeDemoData vg (Ct.addr data);

      Nvg.deleteGLES2 vg;

      glfwTerminate ();
    end
