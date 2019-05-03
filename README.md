# ocaml-mod-test
Minimal code to test ocaml build issue between 4.05 and 4.06.0

Main idea:
- be able to build util/ without providing an implementation for injector.ml
- provide default/injector.ml or test/injector.ml only when building the final binaries

The idea is to avoid compiling util/ twice. This is an minimal project based on what Buck does during the build. I know dune has virtual libraries for this exact purpose :)

To reproduce:
```
$ opam switch my-4.05-switch
$ eval $(opam env)
$ make all # should build normally
$ opam switch my-4.06.0-switch
$ eval $(opam env)
$ make all # fail to build with inconsitent assumptions

# ocamlopt.opt -g -noautolink -o mybuild/main.opt mybuild/libinjector.cmxa
# mybuild/libutil.cmxa \
#                 mybuild/main.cmx
# File "_none_", line 1:
# Error: Files mybuild/libutil.cmxa and mybuild/libinjector.cmxa
#        make inconsistent assumptions over interface Injector
# make: *** [all] Error 2
```
