#!/usr/bin/env ocaml
#directory "pkg"
#use "topkg.ml"

let () =
  Pkg.describe "nanovg" ~builder:`OCamlbuild [
    Pkg.lib "pkg/META";
    Pkg.lib ~exts:Exts.library "src/nanovg";
    Pkg.doc "README.md";
    Pkg.doc "NANOVG_LICENSE.txt"; ]
