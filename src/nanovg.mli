open Ctypes

exception Memory_error

type context
val context : context structure typ

type color
val color : color structure typ
module Color : sig
  val r : (float, color structure) field
  val g : (float, color structure) field
  val b : (float, color structure) field
  val a : (float, color structure) field
end

type paint
val paint : paint structure typ
module Paint : sig
  val xform : (float carray, paint structure) field
  val extent : (float carray, paint structure) field
  val radius : (float, paint structure) field
  val feather : (float, paint structure) field
  val inner_color : (color structure, paint structure) field
  val outer_color : (color structure, paint structure) field
  val image : (int, paint structure) field
end

type glyph_position
val glyph_position : glyph_position structure typ
module Glyph_position : sig
  val str : (string, glyph_position structure) field
  val x : (float, glyph_position structure) field
end

type text_row
val text_row : text_row structure typ
module Text_row : sig
  val start : (string, text_row structure) field
  val end_ : (string, text_row structure) field
  val next : (string, text_row structure) field
  val width : (float, text_row structure) field
  val minx : (float, text_row structure) field
  val maxx : (float, text_row structure) field
end

module Create_flags : sig
  val antialias : int
  val stencil_strokes : int
  val debug : int
end

val begin_frame :
  context structure ptr -> int -> int -> float -> unit
val cancel_frame :
  context structure ptr -> unit
val end_frame :
  context structure ptr -> unit
val rgb : int -> int -> int -> color structure
val rgbf :
  float -> float -> float -> color structure
val rgba : int -> int -> int -> int -> color structure
val rgbaf :
  float -> float -> float -> float -> color structure
val lerp_rgba :
  color structure ->
   color structure -> float -> color structure
val trans_rgba :
  color structure -> int -> color structure
val trans_rgbaf :
  color structure -> float -> color structure
val hsl :
  float -> float -> float -> color structure
val hsla :
  float -> float -> float -> int -> color structure
val save :
  context structure ptr -> unit
val restore :
  context structure ptr -> unit
val reset :
  context structure ptr -> unit
val stroke_color :
  context structure ptr ->
   color structure -> unit
val stroke_paint :
  context structure ptr ->
   paint structure -> unit
val fill_color :
  context structure ptr ->
   color structure -> unit
val fill_paint :
  context structure ptr ->
   paint structure -> unit
val miter_limit :
  context structure ptr -> float -> unit
val stroke_width :
  context structure ptr -> float -> unit
val line_cap :
  context structure ptr -> int -> unit
val line_join :
  context structure ptr -> int -> unit
val global_alpha :
  context structure ptr -> float -> unit
val reset_transform :
  context structure ptr -> unit
val transform :
  context structure ptr ->
   float -> float -> float -> float -> float -> float -> unit
val translate :
  context structure ptr -> float -> float -> unit
val rotate :
  context structure ptr -> float -> unit
val skew_x :
  context structure ptr -> float -> unit
val skew_y :
  context structure ptr -> float -> unit
val scale :
  context structure ptr -> float -> float -> unit
val current_transform :
  context structure ptr ->
   float ptr -> unit
val transform_identity :
  float ptr -> unit
val transform_translate :
  float ptr -> float -> float -> unit
val transform_scale :
  float ptr -> float -> float -> unit
val transform_rotate :
  float ptr -> float -> unit
val transform_skew_x :
  float ptr -> float -> unit
val transform_skew_y :
  float ptr -> float -> unit
val transform_multiply :
  float ptr -> float ptr -> unit
val transform_premultiply :
  float ptr -> float ptr -> unit
val transform_inverse :
  float ptr -> float ptr -> int
val transform_point :
  float ptr ->
   float ptr ->
   float ptr -> float -> float -> unit
val deg_to_rad : float -> float
val rad_to_deg : float -> float
val create_image :
  context structure ptr -> string -> int -> int
val create_image_mem :
  context structure ptr ->
   int -> Unsigned.uchar ptr -> int -> int
val create_image_rgba :
  context structure ptr ->
   int -> int -> int -> Unsigned.uchar ptr -> int
val update_image :
  context structure ptr ->
   int -> Unsigned.uchar ptr -> unit
val image_size :
  context structure ptr ->
   int -> int ptr -> int ptr -> unit
val delete_image :
  context structure ptr -> int -> unit
val linear_gradient :
  context structure ptr ->
   float ->
   float ->
   float ->
   float ->
   color structure -> color structure -> paint structure
val box_gradient :
  context structure ptr ->
   float ->
   float ->
   float ->
   float ->
   float ->
   float ->
   color structure -> color structure -> paint structure
val radial_gradient :
  context structure ptr ->
   float ->
   float ->
   float ->
   float ->
   color structure -> color structure -> paint structure
val image_pattern :
  context structure ptr ->
   float ->
   float -> float -> float -> float -> int -> float -> paint structure
val scissor :
  context structure ptr ->
   float -> float -> float -> float -> unit
val intersect_scissor :
  context structure ptr ->
   float -> float -> float -> float -> unit
val reset_scissor :
  context structure ptr -> unit
val begin_path :
  context structure ptr -> unit
val move_to :
  context structure ptr -> float -> float -> unit
val line_to :
  context structure ptr -> float -> float -> unit
val bezier_to :
  context structure ptr ->
   float -> float -> float -> float -> float -> float -> unit
val quad_to :
  context structure ptr ->
   float -> float -> float -> float -> unit
val arc_to :
  context structure ptr ->
   float -> float -> float -> float -> float -> unit
val close_path :
  context structure ptr -> unit
val path_winding :
  context structure ptr -> int -> unit
val arc :
  context structure ptr ->
   float -> float -> float -> float -> float -> int -> unit
val rect :
  context structure ptr ->
   float -> float -> float -> float -> unit
val rounded_rect :
  context structure ptr ->
   float -> float -> float -> float -> float -> unit
val ellipse :
  context structure ptr ->
   float -> float -> float -> float -> unit
val circle :
  context structure ptr ->
   float -> float -> float -> unit
val fill :
  context structure ptr -> unit
val stroke :
  context structure ptr -> unit
val create_font :
  context structure ptr -> string -> string -> int
val create_font_mem :
  context structure ptr ->
   string -> Unsigned.uchar ptr -> int -> int -> int
val find_font :
  context structure ptr -> string -> int
val font_size :
  context structure ptr -> float -> unit
val font_blur :
  context structure ptr -> float -> unit
val text_letter_spacing :
  context structure ptr -> float -> unit
val text_line_height :
  context structure ptr -> float -> unit
val text_align :
  context structure ptr -> int -> unit
val font_face_id :
  context structure ptr -> int -> unit
val font_face :
  context structure ptr -> string -> unit
val text :
  context structure ptr ->
   float -> float -> string -> string -> float
val text_box :
  context structure ptr ->
   float -> float -> float -> string -> string -> unit
val text_bounds :
  context structure ptr ->
   float -> float -> string -> string -> float ptr -> float
val text_box_bounds :
  context structure ptr ->
   float ->
   float -> float -> string -> string -> float ptr -> unit
val text_glyph_positions :
  context structure ptr ->
   float ->
   float ->
   string ->
   string -> glyph_position structure ptr -> int -> int
val text_metrics :
  context structure ptr ->
   float ptr ->
   float ptr -> float ptr -> unit
val text_break_lines :
  context structure ptr ->
   string ->
   string ->
   float -> text_row structure ptr -> int -> int
val delete_internal :
  context structure ptr -> unit
val debug_dump_path_cache :
  context structure ptr -> unit
val create_gles2 : int -> context structure ptr
val delete_gles2 :
  context structure ptr -> unit
val gl_create_image_from_handle :
  context structure ptr ->
   Unsigned.uint -> int -> int -> int -> int
val gl_image_handle :
  context structure ptr -> int -> Unsigned.uint
