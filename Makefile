.PHONY: build install clean

build:
	dune build

install: build
	opam install ./gamekit.opam

clean:
	dune clean
