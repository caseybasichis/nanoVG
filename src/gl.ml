open Ctypes
open PosixTypes
open Foreign

let glViewport =
  foreign "glViewport" (int @-> int @-> int @-> int @-> returning void)

let glClearColor =
  foreign "glClearColor" (float @-> float @-> float @-> float @-> returning void)

let glClear =
  foreign "glClear" (uint @-> returning void)

let gl_cull_face            = 0x0b44      |> Unsigned.UInt.of_int
let gl_depth_test           = 0x0b71      |> Unsigned.UInt.of_int
let gl_blend                = 0x0be2      |> Unsigned.UInt.of_int
let gl_src_alpha            = 0x0302      |> Unsigned.UInt.of_int
let gl_one_minus_src_alpha  = 0x0303      |> Unsigned.UInt.of_int
let gl_depth_buffer_bit     = 0x00000100  |> Unsigned.UInt.of_int
let gl_stencil_buffer_bit   = 0x00000400  |> Unsigned.UInt.of_int
let gl_color_buffer_bit     = 0x00004000  |> Unsigned.UInt.of_int

let glEnable =
  foreign "glEnable" (uint @-> returning void)

let glDisable =
  foreign "glDisable" (uint @-> returning void)

let glBlendFunc =
  foreign "glBlendFunc" (uint @-> uint @-> returning void)
