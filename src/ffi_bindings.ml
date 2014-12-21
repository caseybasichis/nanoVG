module Bindings(F : Cstubs.FOREIGN) =
struct
  let foreign = F.foreign

  type context
  let context : context Ctypes.structure Ctypes.typ = Ctypes.structure "NVGcontext"

  let createGLES3 = foreign "nvgCreateGLES3"
      Ctypes.(int @-> returning (ptr_opt context))
end
