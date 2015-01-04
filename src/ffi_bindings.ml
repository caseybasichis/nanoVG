module Bindings(F : Cstubs.FOREIGN) =
struct
  let foreign = F.foreign

  type context
  let context : context Ctypes.structure Ctypes.typ = Ctypes.structure "NVGcontext"

  let createGLES3 = foreign "nvgCreateGLES3"
      Ctypes.(int @-> returning (ptr_opt context))

  let beginFrame = foreign "nvgBeginFrame"
      Ctypes.(ptr context @-> int @-> int @-> float @-> returning void)

  let deleteGLES3 = foreign "nvgDeleteGLES3"
      Ctypes.(ptr context @-> returning void)

  let endFrame = foreign "nvgEndFrame"
      Ctypes.(ptr context @-> returning void)
end
