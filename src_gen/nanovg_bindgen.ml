let prefix = "caml_nanovg"

let with_formatter file fn =
  let chan = open_out file in
  let fmt = Format.formatter_of_out_channel chan in
  fn fmt;
  close_out chan

let () =
  with_formatter "src/nanovg_generated.ml" (fun fmt ->
    Cstubs.write_ml fmt ~prefix (module Nanovg_bindings.C));

  with_formatter "src/nanovg_stubs.c" (fun fmt ->
    Format.pp_print_string fmt "\
      #include <GL/gl.h>\n\
      #define NANOVG_GL3_IMPLEMENTATION\n\
      #include <nanovg.h>\n\
      #include <nanovg_gl.h>\n\
      #include <nanovg_gl_utils.h>\n\
    ";
    Cstubs.write_c fmt ~prefix (module Nanovg_bindings.C))
