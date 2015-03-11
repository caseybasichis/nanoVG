#!/usr/bin/env ocaml
#directory "pkg"
#use "topkg.ml"

let () =
  Pkg.describe "nanovg" ~builder:`OCamlbuild [
    Pkg.lib "pkg/META";
    Pkg.lib ~exts:Exts.module_library "src/nanovg";
    Pkg.lib "src/libnanovg_stubs.a";
    Pkg.lib "src/dllnanovg_stubs.so";
    Pkg.doc "README.md";
    Pkg.doc "NANOVG_LICENSE.txt"; ]
