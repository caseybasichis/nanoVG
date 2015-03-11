library:
	cp pkg/META.in pkg/META
	ocaml pkg/build.ml native=true native-dynlink=true

examples: library
	ocamlbuild -use-ocamlfind src_examples/example_gles2.native

clean:
	ocamlbuild -use-ocamlfind -clean

.PHONY: all clean
