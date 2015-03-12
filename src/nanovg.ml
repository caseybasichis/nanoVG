open Ctypes
open Unsigned

include Nanovg_bindings.C(Nanovg_generated)

module Create_flags = struct
  let antialias       = 1 lsl 0
  let stencil_strokes = 1 lsl 1
  let debug           = 1 lsl 2
end

exception Memory_error

let rgb r g b =
  rgb (UChar.of_int r) (UChar.of_int g) (UChar.of_int b)

let rgba r g b a =
  rgba (UChar.of_int r) (UChar.of_int g) (UChar.of_int b) (UChar.of_int a)

let trans_rgba c a =
  trans_rgba c (UChar.of_int a)

let hsla h s l a =
  hsla h s l (UChar.of_int a)

let create_gles2 flags =
  match create_gles2 flags with
  | Some x -> x
  | None -> raise Memory_error
