
build:
	dune build

install: build
	opam install ./gamekit.opam
