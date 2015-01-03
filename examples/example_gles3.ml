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
  let fps = Ct.make Perf.perfGraph in
  let prevt = ref 0.0 in

  if glfwInit () = false then begin
    Printf.printf("Failed to init GLFW.\n");
    exit (-1)
  end;

  Perf.initGraph (Ct.addr fps) Perf.GRAPH_RENDER_FPS "Frame Time" |> ignore;

  glfwSetErrorCallback errorcb |> ignore;

  glfwWindowHint GLFW.client_api GLFW.opengl_es_api;
	glfwWindowHint GLFW.context_version_major 3;
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
      let open Nvg in
      let vg =
        try Nvg.createGLES3 (Nvg.antialias lor Nvg.stencil_strokes lor Nvg.debug)
        with Nvg.Memory_error -> begin
            Printf.printf "Could not init nanovg.\n%!";
            exit (-1)
          end in

      Unix.sleep 120;
      Printf.printf "Sono arrivato qui\n%!"
    end
