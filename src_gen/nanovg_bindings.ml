open Ctypes

module C(Foreign : Cstubs.FOREIGN) =
struct
  open Foreign

  type context
  let context : context structure typ = structure "NVGcontext"

  type color
  let color : color structure typ = structure "NVGcolor"
  module Color = struct
    let r = field color "r" float
    let g = field color "g" float
    let b = field color "b" float
    let a = field color "a" float
  end
  let () = seal color

  type paint
  let paint : paint structure typ = structure "NVGpaint"
  module Paint = struct
    let xform = field paint "xform" (array 6 float)
    let extent = field paint "extent" (array 2 float)
    let radius = field paint "radius" float
    let feather = field paint "feather" float
    let inner_color = field paint "innerColor" color
    let outer_color = field paint "outerColor" color
    let image = field paint "image" int
  end
  let () = seal paint

  type glyph_position
  let glyph_position : glyph_position structure typ = structure "NVGglyphPosition"
  module Glyph_position = struct
    let str = field glyph_position "str" string
    let x = field glyph_position "x" float
    let minx = field glyph_position "minx" float
    let maxx = field glyph_position "maxx" float
  end
  let () = seal glyph_position

  type text_row
  let text_row : text_row structure typ = structure "NVGtextRow"
  module Text_row = struct
    let start = field text_row "start" string
    let end_ = field text_row "end" string
    let next = field text_row "next" string
    let width = field text_row "width" float
    let minx = field text_row "minx" float
    let maxx = field text_row "maxx" float
  end
  let () = seal text_row

  type params
  let params : params structure typ = structure "NVGparams"
  module Params = struct
    let user_ptr = field params "userPtr" (ptr void)
  end
  let () = seal params

  let begin_frame = foreign "nvgBeginFrame"
      (ptr context @-> int @-> int @-> float @-> returning void)

  let cancel_frame = foreign "nvgCancelFrame"
      (ptr context @-> returning void)

  let end_frame = foreign "nvgEndFrame"
      (ptr context @-> returning void)

  let rgb = foreign "nvgRGB"
      (uchar @-> uchar @-> uchar @-> returning color)

  let rgbf = foreign "nvgRGBf"
      (float @-> float @-> float @-> returning color)

  let rgba = foreign "nvgRGBA"
      (uchar @-> uchar @-> uchar @-> uchar @-> returning color)

  let rgbaf = foreign "nvgRGBAf"
      (float @-> float @-> float @-> float @-> returning color)

  let lerp_rgba = foreign "nvgLerpRGBA"
      (color @-> color @-> float @-> returning color)

  let trans_rgba = foreign "nvgTransRGBA"
      (color @-> uchar @-> returning color)

  let trans_rgbaf = foreign "nvgTransRGBAf"
      (color @-> float @-> returning color)

  let hsl = foreign "nvgHSL"
      (float @-> float @-> float @-> returning color)

  let hsla = foreign "nvgHSLA"
      (float @-> float @-> float @-> uchar @-> returning color)

  let save = foreign "nvgSave"
      (ptr context @-> returning void)

  let restore = foreign "nvgRestore"
      (ptr context @-> returning void)

  let reset = foreign "nvgReset"
      (ptr context @-> returning void)

  let stroke_color = foreign "nvgStrokeColor"
      (ptr context @-> color @-> returning void)

  let stroke_paint = foreign "nvgStrokePaint"
      (ptr context @-> paint @-> returning void)

  let fill_color = foreign "nvgFillColor"
      (ptr context @-> color @-> returning void)

  let fill_paint = foreign "nvgFillPaint"
      (ptr context @-> paint @-> returning void)

  let miter_limit = foreign "nvgMiterLimit"
      (ptr context @-> float @-> returning void)

  let stroke_width = foreign "nvgStrokeWidth"
      (ptr context @-> float @-> returning void)

  let line_cap = foreign "nvgLineCap"
      (ptr context @-> int @-> returning void)

  let line_join = foreign "nvgLineJoin"
      (ptr context @-> int @-> returning void)

  let global_alpha = foreign "nvgGlobalAlpha"
      (ptr context @-> float @-> returning void)

  let reset_transform = foreign "nvgResetTransform"
      (ptr context @-> returning void)

  let transform = foreign "nvgTransform"
      (ptr context @-> float @-> float @-> float @-> float @-> float @-> float @-> returning void)

  let translate = foreign "nvgTranslate"
      (ptr context @-> float @-> float @-> returning void)

  let rotate = foreign "nvgRotate"
      (ptr context @-> float @-> returning void)

  let skew_x = foreign "nvgSkewX"
      (ptr context @-> float @-> returning void)

  let skew_y = foreign "nvgSkewY"
      (ptr context @-> float @-> returning void)

  let scale = foreign "nvgScale"
      (ptr context @-> float @-> float @-> returning void)

  let current_transform = foreign "nvgCurrentTransform"
      (ptr context @-> ptr float @-> returning void)

  let transform_identity = foreign "nvgTransformIdentity"
      (ptr float @-> returning void)

  let transform_translate = foreign "nvgTransformTranslate"
      (ptr float @-> float @-> float @-> returning void)

  let transform_scale = foreign "nvgTransformScale"
      (ptr float @-> float @-> float @-> returning void)

  let transform_rotate = foreign "nvgTransformRotate"
      (ptr float @-> float @-> returning void)

  let transform_skew_x = foreign "nvgTransformSkewX"
      (ptr float @-> float @-> returning void)

  let transform_skew_y = foreign "nvgTransformSkewY"
      (ptr float @-> float @-> returning void)

  let transform_multiply = foreign "nvgTransformMultiply"
      (ptr float @-> ptr float @-> returning void)

  let transform_premultiply = foreign "nvgTransformPremultiply"
      (ptr float @-> ptr float @-> returning void)

  let transform_inverse = foreign "nvgTransformInverse"
      (ptr float @-> ptr float @-> returning int)

  let transform_point = foreign "nvgTransformPoint"
      (ptr float @-> ptr float @-> ptr float @-> float @-> float @-> returning void)

  let deg_to_rad = foreign "nvgDegToRad"
      (float @-> returning float)

  let rad_to_deg = foreign "nvgRadToDeg"
      (float @-> returning float)

  let create_image = foreign "nvgCreateImage"
      (ptr context @-> string @-> int @-> returning int)

  let create_image_mem = foreign "nvgCreateImageMem"
      (ptr context @-> int @-> ptr uchar @-> int @-> returning int)

  let create_image_rgba = foreign "nvgCreateImageRGBA"
      (ptr context @-> int @-> int @-> int @-> ptr uchar @-> returning int)

  let update_image = foreign "nvgUpdateImage"
      (ptr context @-> int @-> ptr uchar @-> returning void)

  let image_size = foreign "nvgImageSize"
      (ptr context @-> int @-> ptr int @-> ptr int @-> returning void)

  let delete_image = foreign "nvgDeleteImage"
      (ptr context @-> int @-> returning void)

  let linear_gradient = foreign "nvgLinearGradient"
      (ptr context @-> float @-> float @-> float @-> float @-> color @-> color @-> returning paint)

  let box_gradient = foreign "nvgBoxGradient"
      (ptr context @-> float @-> float @-> float @-> float @-> float @-> float @-> color @-> color @-> returning paint)

  let radial_gradient = foreign "nvgRadialGradient"
      (ptr context @-> float @-> float @-> float @-> float @-> color @-> color @-> returning paint)

  let image_pattern = foreign "nvgImagePattern"
      (ptr context @-> float @-> float @-> float @-> float @-> float @-> int @-> float @-> returning paint)

  let scissor = foreign "nvgScissor"
      (ptr context @-> float @-> float @-> float @-> float @-> returning void)

  let intersect_scissor = foreign "nvgIntersectScissor"
      (ptr context @-> float @-> float @-> float @-> float @-> returning void)

  let reset_scissor = foreign "nvgResetScissor"
      (ptr context @-> returning void)

  let begin_path = foreign "nvgBeginPath"
      (ptr context @-> returning void)

  let move_to = foreign "nvgMoveTo"
      (ptr context @-> float @-> float @-> returning void)

  let line_to = foreign "nvgLineTo"
      (ptr context @-> float @-> float @-> returning void)

  let bezier_to = foreign "nvgBezierTo"
      (ptr context @-> float @-> float @-> float @-> float @-> float @-> float @-> returning void)

  let quad_to = foreign "nvgQuadTo"
      (ptr context @-> float @-> float @-> float @-> float @-> returning void)

  let arc_to = foreign "nvgArcTo"
      (ptr context @-> float @-> float @-> float @-> float @-> float @-> returning void)

  let close_path = foreign "nvgClosePath"
      (ptr context @-> returning void)

  let path_winding = foreign "nvgPathWinding"
      (ptr context @-> int @-> returning void)

  let arc = foreign "nvgArc"
      (ptr context @-> float @-> float @-> float @-> float @-> float @-> int @-> returning void)

  let rect = foreign "nvgRect"
      (ptr context @-> float @-> float @-> float @-> float @-> returning void)

  let rounded_rect = foreign "nvgRoundedRect"
      (ptr context @-> float @-> float @-> float @-> float @-> float @-> returning void)

  let ellipse = foreign "nvgEllipse"
      (ptr context @-> float @-> float @-> float @-> float @-> returning void)

  let circle = foreign "nvgCircle"
      (ptr context @-> float @-> float @-> float @-> returning void)

  let fill = foreign "nvgFill"
      (ptr context @-> returning void)

  let stroke = foreign "nvgStroke"
      (ptr context @-> returning void)

  let create_font = foreign "nvgCreateFont"
      (ptr context @-> string @-> string @-> returning int)

  let create_font_mem = foreign "nvgCreateFontMem"
      (ptr context @-> string @-> ptr uchar @-> int @-> int @-> returning int)

  let find_font = foreign "nvgFindFont"
      (ptr context @-> string @-> returning int)

  let font_size = foreign "nvgFontSize"
      (ptr context @-> float @-> returning void)

  let font_blur = foreign "nvgFontBlur"
      (ptr context @-> float @-> returning void)

  let text_letter_spacing = foreign "nvgTextLetterSpacing"
      (ptr context @-> float @-> returning void)

  let text_line_height = foreign "nvgTextLineHeight"
      (ptr context @-> float @-> returning void)

  let text_align = foreign "nvgTextAlign"
      (ptr context @-> int @-> returning void)

  let font_face_id = foreign "nvgFontFaceId"
      (ptr context @-> int @-> returning void)

  let font_face = foreign "nvgFontFace"
      (ptr context @-> string @-> returning void)

  let text = foreign "nvgText"
      (ptr context @-> float @-> float @-> string @-> string @-> returning float)

  let text_box = foreign "nvgTextBox"
      (ptr context @-> float @-> float @-> float @-> string @-> string @-> returning void)

  let text_bounds = foreign "nvgTextBounds"
      (ptr context @-> float @-> float @-> string @-> string @-> ptr float @-> returning float)

  let text_box_bounds = foreign "nvgTextBoxBounds"
      (ptr context @-> float @-> float @-> float @-> string @-> string @-> ptr float @-> returning void)

  let text_glyph_positions = foreign "nvgTextGlyphPositions"
      (ptr context @-> float @-> float @-> string @-> string @-> ptr glyph_position @-> int @-> returning int)

  let text_metrics = foreign "nvgTextMetrics"
      (ptr context @-> ptr float @-> ptr float @-> ptr float @-> returning void)

  let text_break_lines = foreign "nvgTextBreakLines"
      (ptr context @-> string @-> string @-> float @-> ptr text_row @-> int @-> returning int)

  let create_internal = foreign "nvgCreateInternal"
      (ptr params @-> returning (ptr context))

  let delete_internal = foreign "nvgDeleteInternal"
      (ptr context @-> returning void)

  let internal_params = foreign "nvgInternalParams"
      (ptr context @-> returning (ptr params))

  let debug_dump_path_cache = foreign "nvgDebugDumpPathCache"
      (ptr context @-> returning void)

  let create_gl3 = foreign "nvgCreateGL3"
      (int @-> returning (ptr_opt context))

  let delete_gl3 = foreign "nvgDeleteGL3"
      (ptr context @-> returning void)

  let gl_create_image_from_handle = foreign "nvglCreateImageFromHandle"
      (ptr context @-> uint @-> int @-> int @-> int @-> returning int)

  let gl_image_handle = foreign "nvglImageHandle"
      (ptr context @-> int @-> returning uint)

end
