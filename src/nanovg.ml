include Nanovg_bindings.C(Nanovg_generated)

(* TODO: how to bind constants? *)
let antialias       = 1 lsl 0
let stencil_strokes = 1 lsl 1
let debug           = 1 lsl 2

exception Memory_error

let create_gles2 flags =
  match create_gles2 flags with
  | Some x -> x
  | None -> raise Memory_error
