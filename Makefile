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

.PHONY: all
