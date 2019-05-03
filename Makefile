all:
	rm -rf mybuild
	mkdir -p mybuild
	ocamlopt.opt -g -noautolink -c -o mybuild/injector.cmi -I util            injector/injector.mli
	ocamlopt.opt -g -noautolink -c -o mybuild/default.cmx -I util -I injector util/default.ml
	ocamlopt.opt -g -noautolink -c -o mybuild/test.cmx -I util -I injector    util/test.ml
	ocamlopt.opt -g -noautolink -c -o mybuild/util_S.cmx -I util -I injector  util/util_S.ml
	ocamlopt.opt -g -noautolink -c -o mybuild/util.cmx -I util -I injector -I mybuild -w -58 util/util.ml
	ocamlopt.opt -g -noautolink -a -o mybuild/libutil.cmxa \
		mybuild/default.cmx mybuild/test.cmx mybuild/util_S.cmx mybuild/util.cmx
	ocamlopt.opt -g -noautolink -c -o mybuild/injector.cmx -I injector/default -I injector \
		injector/default/injector.ml
	ocamlopt.opt -g -noautolink -a -o mybuild/libinjector.cmxa mybuild/injector.cmx 
	ocamlopt.opt -g -noautolink -c -o mybuild/main.cmx -I mybuild main.ml
	ocamlopt.opt -g -noautolink -o mybuild/main.opt mybuild/libinjector.cmxa mybuild/libutil.cmxa \
		mybuild/main.cmx

dune:
	rm -rf mybuild.dune
	mkdir -p mybuild.dune
	ocamlc.opt -strict-sequence -strict-formats -short-paths -keep-locs -g  -no-alias-deps -opaque -o mybuild.dune/injector.cmi -c -intf injector/injector.mli
	ocamlopt.opt -strict-sequence -strict-formats -short-paths -keep-locs -g -intf-suffix .ml -no-alias-deps -opaque -I mybuild.dune -o mybuild.dune/injector.cmx -c -impl injector/default/injector.ml
	ocamlopt.opt -strict-sequence -strict-formats -short-paths -keep-locs -g -no-alias-deps -opaque -I mybuild.dune -o mybuild.dune/default.cmx -c -impl util/default.ml
	ocamlopt.opt -strict-sequence -strict-formats -short-paths -keep-locs -g -no-alias-deps -opaque -o mybuild.dune/default.cmx -c -impl util/default.ml
	ocamlopt.opt -strict-sequence -strict-formats -short-paths -keep-locs -g -no-alias-deps -opaque -o mybuild.dune/test.cmx -c -impl util/test.ml
	ocamlopt.opt -strict-sequence -strict-formats -short-paths -keep-locs -g -no-alias-deps -opaque -o mybuild.dune/util_S.cmx -c -impl util/util_S.ml
	ocamlopt.opt -strict-sequence -strict-formats -short-paths -keep-locs -g -no-alias-deps -opaque -I mybuild.dune -o mybuild.dune/util.cmx -c -impl util/util.ml
	ocamlopt.opt -strict-sequence -strict-formats -short-paths -keep-locs -g -a -o mybuild.dune/default_injector.cmxa mybuild.dune/injector.cmx mybuild.dune/default.cmx
	ocamlopt.opt -strict-sequence -strict-formats -short-paths -keep-locs -g -a -o mybuild.dune/util.cmxa mybuild.dune/default.cmx mybuild.dune/test.cmx mybuild.dune/util_S.cmx mybuild.dune/util.cmx
	ocamlopt.opt -strict-sequence -strict-formats -short-paths -keep-locs -g -no-alias-deps -opaque -I mybuild.dune -o mybuild.dune/main.cmx -c -impl main.ml
	ocamlopt.opt -strict-sequence -strict-formats -short-paths -keep-locs -g -o mybuild.dune/main.exe mybuild.dune/default_injector.cmxa mybuild.dune/util.cmxa mybuild.dune/main.cmx

.PHONY: all dune
