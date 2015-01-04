module Bindings = Ffi_bindings.Bindings(Ffi_generated)

module Nvg =
struct
  exception Memory_error

  (* TODO: how to bind constants? *)
  let antialias       = 1 lsl 0
  let stencil_strokes = 1 lsl 1
  let debug           = 1 lsl 2

  type context = Bindings.context
  let context = Bindings.context

  let createGLES3 flags =
    match Bindings.createGLES3 flags with
    | Some x -> x
    | None -> raise Memory_error

  let deleteGLES3 = Bindings.deleteGLES3

  let beginFrame = Bindings.beginFrame

  let endFrame = Bindings.endFrame
end

include Nvg
