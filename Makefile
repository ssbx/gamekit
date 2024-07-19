.PHONY: build install clean uninstall update


build:
	dune build

uninstall:
	opam remove gamekit

clean:
	dune clean

test:
	dune runtest -f

fmt:
	dune build @fmt
	@echo 'run "dune promote" to update files'

doc:
	dune build @doc && $(BROWSER) _build/default/_doc/_html/Gamekit/index.html

dev_update:
	opam install -v --working-dir ./gamekit.opam
