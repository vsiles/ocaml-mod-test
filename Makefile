buck:
	rm -rf mybuild
	mkdir -p mybuild
	ocamlopt.opt -c -o mybuild/injector.cmi -I util            injector/injector.mli
	ocamlopt.opt -c -o mybuild/default.cmx -I util -I injector util/default.ml
	ocamlopt.opt -c -o mybuild/test.cmx -I util -I injector    util/test.ml
	ocamlopt.opt -c -o mybuild/util_S.cmx -I util -I injector  util/util_S.ml
	ocamlopt.opt -c -o mybuild/util.cmx -I util -I injector -I mybuild -w -58 util/util.ml
	ocamlopt.opt -a -o mybuild/libutil.cmxa mybuild/default.cmx mybuild/test.cmx mybuild/util_S.cmx mybuild/util.cmx
	ocamlopt.opt -c -o mybuild/injector.cmx -intf-suffix .ml -I mybuild -I injector/default -I injector injector/default/injector.ml
	ocamlopt.opt -a -o mybuild/libinjector.cmxa mybuild/injector.cmx 
	ocamlopt.opt -c -o mybuild/main.cmx -I mybuild main.ml
	ocamlopt.opt -o mybuild/main.opt mybuild/libinjector.cmxa mybuild/libutil.cmxa mybuild/main.cmx

dune:
	rm -rf mybuild.dune
	mkdir -p mybuild.dune
	ocamlopt.opt -o mybuild.dune/injector.cmi -c injector/injector.mli
	ocamlopt.opt -I mybuild.dune -o mybuild.dune/injector.cmx -c injector/default/injector.ml
	ocamlopt.opt -I mybuild.dune -o mybuild.dune/default.cmx -c util/default.ml
	ocamlopt.opt -o mybuild.dune/test.cmx -c util/test.ml
	ocamlopt.opt -o mybuild.dune/util_S.cmx -c util/util_S.ml
	ocamlopt.opt -I mybuild.dune -o mybuild.dune/util.cmx -c util/util.ml
	ocamlopt.opt -a -o mybuild.dune/default_injector.cmxa mybuild.dune/injector.cmx mybuild.dune/default.cmx
	ocamlopt.opt -a -o mybuild.dune/util.cmxa mybuild.dune/default.cmx mybuild.dune/test.cmx mybuild.dune/util_S.cmx mybuild.dune/util.cmx
	ocamlopt.opt -I mybuild.dune -o mybuild.dune/main.cmx -c main.ml
	ocamlopt.opt -o mybuild.dune/main.exe mybuild.dune/default_injector.cmxa mybuild.dune/util.cmxa mybuild.dune/main.cmx

clean:
	rm -rf _build
	rm -rf mybuild
	rm -rf mybuild.dune

.PHONY: buck dune clean


