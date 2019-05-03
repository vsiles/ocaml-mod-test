# ocaml-mod-test
Minimal code to test ocaml build issue between 4.05 and 4.07.1

Main idea:
- be able to build util/ without providing an implementation for injector.ml
- provide default/injector.ml or test/injector.ml only when building the final binaries

The idea is to avoid compiling util/ twice. This is an minimal project based on what Buck does during the build. I know dune has virtual libraries for this exact purpose :)

To reproduce:
```
$ opam switch my-4.05-switch
$ eval $(opam env)
$ make all # should build normally
$ opam switch my-4.07.1-switch
$ eval $(opam env)
$ make all # fail to build with inconsitent assumptions
```
