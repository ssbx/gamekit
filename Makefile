.PHONY: build install clean uninstall update

build:
	dune build

install:
	opam install ./gamekit.opam

uninstall:
	opam remove gamekit

update:
	if [ -n $(GAMEDEVDIR) ]; then cp -r $(GAMEDEVDIR)/libs/gamekit/* . ; fi

clean:
	dune clean
