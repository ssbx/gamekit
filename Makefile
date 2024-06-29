.PHONY: build install clean

build:
	dune build

install:
	opam install ./gamekit.opam

uninstall:
	opam remove gamekit

update:
	if [ -n $(GAMEDEVDIR) ]; then cp $(GAMEDEVDIR)/* . ; fi

clean:
	dune clean
