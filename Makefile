default:
	ocamlbuild -no-links -use-ocamlfind main.native
	ln -s -f _build/main.native game

clean:
	rm -rf _build game

.PHONY: default clean
