module Bindings = Ffi_bindings.Bindings(Ffi_generated)

module Nvg =
struct
  exception Memory_error

  (* TODO: how to bind constants? *)
  let antialias       = 1 lsl 0
  let stencil_strokes = 1 lsl 1
  let debug           = 1 lsl 2

  let createGLES3 flags =
    match Bindings.createGLES3 flags with
    | Some x -> x
    | None -> raise Memory_error
end
