.PHONY: build install clean uninstall update

build:
	dune build

install:
	opam install ./gamekit.opam

uninstall:
	opam remove gamekit

clean:
	dune clean
