LIBNAME = fungame_sdl

OCAMLBUILD := ocamlbuild
OCAMLBUILD := $(OCAMLBUILD) -no-links
OCAMLBUILD := $(OCAMLBUILD) -use-ocamlfind
OCAMLBUILD := $(OCAMLBUILD) -I src

FILES := META
FILES := $(FILES) $(wildcard _build/$(LIBNAME).cma)
FILES := $(FILES) $(wildcard _build/$(LIBNAME).cmxa)
FILES := $(FILES) $(wildcard _build/src/*.a)
FILES := $(FILES) $(wildcard _build/src/*.cmi)
FILES := $(FILES) $(wildcard _build/src/*.cmx)
FILES := $(FILES) $(wildcard _build/src/*.cma)
FILES := $(FILES) $(wildcard _build/src/*.cmxa)

default: lib

all: lib example doc

lib: byte native

byte:
	$(OCAMLBUILD) $(LIBNAME).cma

native:
	$(OCAMLBUILD) $(LIBNAME).cmxa

doc: $(LIBNAME).odocl
	$(OCAMLBUILD) $(LIBNAME).docdir/index.html
	ln -s -f _build/$(LIBNAME).docdir/index.html doc

%.odocl: %.mllib
	cp $*.mllib $*.odocl

example:
	$(OCAMLBUILD) examples/main.native
	ln -s -f _build/examples/main.native example

clean:
	rm -rf _build example doc $(LIBNAME).odocl

install: lib
	ocamlfind install $(LIBNAME) $(FILES)

uninstall remove:
	ocamlfind remove $(LIBNAME)

reinstall: uninstall install

.PHONY: default all lib byte native example doc clean \
	install uninstall remove reinstall
