open Glfw3
open GLFW
open Tgles2

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
  let data = Ctypes.make Demo.demo_data in
  let fps = Ctypes.make Perf.perf_graph in
  let prevt = ref 0.0 in

  if glfwInit () = false then begin
    Printf.printf("Failed to init GLFW.\n");
    exit (-1)
  end;

  Perf.init_graph (Ctypes.addr fps) Perf.GRAPH_RENDER_FPS "Frame Time" |> ignore;

  glfwSetErrorCallback errorcb |> ignore;

  glfwWindowHint GLFW.client_api GLFW.opengl_es_api;
  glfwWindowHint GLFW.context_version_major 2;
  glfwWindowHint GLFW.context_version_minor 0;

  let window =
    glfwCreateWindow 1000 600 "NanoVG"
      (Ctypes.from_voidp GLFW.monitor Ctypes.null)
      (Ctypes.from_voidp GLFW.window Ctypes.null) in

  match window with
  | None -> (glfwTerminate (); exit (-1))
  | Some window -> begin
      glfwSetKeyCallback window key |> ignore;
      glfwMakeContextCurrent window;
      let vg =
        let open Nanovg.Create_flags in
        try Nanovg.create_gles2 (antialias lor stencil_strokes lor debug)
        with Nanovg.Memory_error -> begin
            Printf.printf "Could not init nanovg.\n%!";
            exit (-1)
          end in
      if not (Demo.load_demo_data vg (Ctypes.addr data))
      then exit (-1);

      glfwSwapInterval 0;
      glfwSetTime 0.0;
      prevt := glfwGetTime ();

      while not (glfwWindowShouldClose window) do
        let pxRatio, t, dt = ref 0.0, ref 0.0, ref 0.0 in
        let mx = Ctypes.allocate Ctypes.double 0.0 in
        let my = Ctypes.allocate Ctypes.double 0.0 in
        let winWidth = Ctypes.allocate Ctypes.int 0 in
        let winHeight = Ctypes.allocate Ctypes.int 0 in
        let fbWidth = Ctypes.allocate Ctypes.int 0 in
        let fbHeight = Ctypes.allocate Ctypes.int 0 in

        t := glfwGetTime ();
        dt := !t -. !prevt;
        prevt := !t;
        Perf.update_graph (Ctypes.addr fps) !dt;

        glfwGetCursorPos window mx my;
        glfwGetWindowSize window winWidth winHeight;
        glfwGetFramebufferSize window fbWidth fbHeight;
        (* Calculate pixel ration for hi-dpi devices. *)
        pxRatio := Ctypes.((float_of_int !@fbWidth) /. (float_of_int !@fbHeight));

        (* Update and render *)
        Ctypes.(Gl.viewport 0 0 !@fbWidth !@fbHeight);
        let () =
          if !premult
          then Gl.clear_color 0. 0. 0. 0.
          else Gl.clear_color 0.3 0.3 0.32 1.0 in
        Gl.(
          clear (color_buffer_bit lor depth_buffer_bit lor stencil_buffer_bit)
        );

        Gl.enable Gl.blend;
        Gl.blend_func Gl.src_alpha Gl.one_minus_src_alpha;
        Gl.enable Gl.cull_face_enum;
        Gl.disable Gl.depth_test;

        Ctypes.(Nanovg.begin_frame vg !@winWidth !@winHeight !pxRatio);

        Ctypes.(
          Demo.render_demo vg !@mx !@my (float_of_int !@winWidth) (float_of_int !@winHeight) !t (Glfw3.int_of_bool !blowup) (addr data)
        );
        Perf.render_graph vg 5. 5. (Ctypes.addr fps);

        Nanovg.end_frame vg;

        Gl.enable Gl.depth_test;

        if !screenshot then begin
          screenshot := false;
          Ctypes.(Demo.save_screen_shot !@fbWidth !@fbHeight !premult "dump.png");
        end;

        glfwSwapBuffers window;
        glfwPollEvents ();
      done;

      Demo.free_demo_data vg (Ctypes.addr data);

      Nanovg.delete_gles2 vg;

      glfwTerminate ();
    end
