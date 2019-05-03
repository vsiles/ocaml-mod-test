# ocaml-mod-test
Minimal code to test ocaml build issue between 4.05 and 4.07.1

To reproduce:
```
$ opam switch my-4.05-switch
$ eval $(opam env)
$ make all # should build normally
$ opam switch my-4.07.1-switch
$ eval $(opam env)
$ make all # fail to build with inconsitent assumptions
```
