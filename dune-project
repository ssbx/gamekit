(lang dune 3.15)

(name gamekit)
(version 1.0)

(generate_opam_files true)

(source
 (github username/reponame))

(authors "Author Name")

(maintainers "Maintainer Name")

(license LICENSE)

(documentation https://url/to/documentation)

(package
 (name gamekit)
 (synopsis "A short synopsis")
 (description "A longer description")
 (depends
   ocaml
   dune
   (caml-sdl2  (= 1.0))
   (caml-sdl2-mixer (= 1.0))
   (caml-sdl2-ttf (= 1.0))
 )
 (tags
  (topics "to describe" your project)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/dune-files.html#dune-project
