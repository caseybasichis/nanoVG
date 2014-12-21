let prefix = "nanovg_stub"

let prologue = "#define GLFW_INCLUDE_ES3
#include <GLFW/glfw3.h>
#include \"../../lib/nanovg/src/nanovg.h\"
#define NANOVG_GLES3_IMPLEMENTATION
#include \"../../lib/nanovg/src/nanovg_gl.h\"
#include \"../../lib/nanovg/src/nanovg_gl_utils.h\"

#include <ctypes/cstubs_internals.h>
"

let () =
  let generate_ml, generate_c = ref false, ref false in
  let () =
    Arg.(parse [ ("-ml", Set generate_ml, "Generate ML");
                 ("-c", Set generate_c, "Generate C") ])
      (fun _ -> failwith "unexpected anonymous argument")
      "stubgen [-ml|-c]"
  in
  match !generate_ml, !generate_c with
  | false, false
  | true, true ->
    failwith "Exactly one of -ml and -c must be specified"
  | true, false ->
    Cstubs.write_ml Format.std_formatter ~prefix (module Ffi_bindings.Bindings)
  | false, true ->
    print_endline prologue;
    Cstubs.write_c Format.std_formatter ~prefix (module Ffi_bindings.Bindings)
