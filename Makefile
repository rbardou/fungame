LIBNAME_SDL = fungame_sdl
LIBNAME_JS = fungame_js

OCAMLBUILD := ocamlbuild
OCAMLBUILD := $(OCAMLBUILD) -no-links
OCAMLBUILD := $(OCAMLBUILD) -use-ocamlfind
OCAMLBUILD := $(OCAMLBUILD) -I src

FILES_SDL := META
FILES_SDL := $(FILES_SDL) $(wildcard _build/$(LIBNAME_SDL).cma)
FILES_SDL := $(FILES_SDL) $(wildcard _build/$(LIBNAME_SDL).cmxa)
FILES_SDL := $(FILES_SDL) $(wildcard _build/*.a)
FILES_SDL := $(FILES_SDL) $(wildcard _build/src/*.cmi)
FILES_SDL := $(FILES_SDL) $(wildcard _build/src/*.cmx)
FILES_SDL := $(FILES_SDL) $(wildcard _build/src/*.cma)
FILES_SDL := $(FILES_SDL) $(wildcard _build/src/*.cmxa)

default: lib

all: lib example doc

lib: byte native js

byte:
	$(OCAMLBUILD) $(LIBNAME_SDL).cma

native:
	$(OCAMLBUILD) $(LIBNAME_SDL).cmxa

js:
	$(OCAMLBUILD) $(LIBNAME_JS).cma

doc: $(LIBNAME_SDL).odocl
	$(OCAMLBUILD) $(LIBNAME_SDL).docdir/index.html
	ln -s -f _build/$(LIBNAME_SDL).docdir/index.html doc

%.odocl: %.mllib
	cp $*.mllib $*.odocl

example: example_sdl example_js

example_sdl:
	$(OCAMLBUILD) examples/example_sdl.native
	ln -s -f _build/examples/example_sdl.native example_sdl

example_js:
	$(OCAMLBUILD) examples/example_js.byte
	js_of_ocaml _build/examples/example_js.byte \
		-o _build/examples/example_js.js
	ln -s -f examples/example_js.html example_js.html

clean:
	rm -rf _build example_sdl example_js.html doc $(LIBNAME_SDL).odocl

install: lib
	ocamlfind install $(LIBNAME_SDL) $(FILES_SDL)

uninstall remove:
	ocamlfind remove $(LIBNAME_SDL)

reinstall: uninstall install

.PHONY: default all lib byte native example doc clean \
	install uninstall remove reinstall
