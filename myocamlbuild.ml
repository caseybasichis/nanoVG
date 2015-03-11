open Ocamlbuild_plugin

let () =
  dispatch (
    function
    | After_rules ->

      rule "cstubs: nanovg"
        ~prods:["src/nanovg_stubs.c"; "src/nanovg_generated.ml"]
        ~dep:"src_gen/nanovg_bindgen.byte"
        (fun env build ->
          Cmd (A(env "src_gen/nanovg_bindgen.byte")));

      (* http://caml.inria.fr/mantis/view.php?id=6794 *)
      flag ["c"; "compile"; "use_ctypes"] & S[A"-I"; A"+../ctypes"];

      flag ["c"; "compile"; "use_nanovg"] & S[A"-I"; A"src_nanovg"];
      dep ["c"; "compile"; "use_nanovg"] & [
        "src_nanovg/nanovg.h";
        "src_nanovg/nanovg_gl.h";
        "src_nanovg/nanovg_gl_utils.h";
        "src_nanovg/fontstash.h";
        "src_nanovg/stb_image.h";
        "src_nanovg/stb_truetype.h";
      ];

      dep ["ocaml"; "link"; "use_nanovg"] & ["src/libnanovg_stubs.a"];

      (* Examples *)

      flag ["ocaml"; "link"; "use_glfw"] & S[A"-cclib"; A"-lGL -lglfw"];

      flag ["c"; "compile"; "use_nanovg_examples"] & S[A"-I"; A"example"];
      dep ["c"; "compile"; "use_nanovg_examples"] & [
        "example/demo.c";
        "example/demo.h";
        "example/perf.c";
        "example/perf.h";
        "example/stb_image_write.h";
      ];

      flag ["ocaml"; "link"; "use_nanovg_examples"] & S[A"-cclib"; A"-Wl,-E"];
      dep ["ocaml"; "link"; "dont_link_with"; "use_nanovg_examples"] ["example/libnanovg_examples.a"];
      flag ["ocaml"; "link"; "use_nanovg_examples"] &
        S[A"-cclib"; A"-Wl,-E -Wl,--whole-archive example/libnanovg_examples.a -Wl,--no-whole-archive"];

      mark_tag_used "use_nanovg_examples";

    | _ -> ())
