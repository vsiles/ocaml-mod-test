include (val (if Injector.flag
  then (module Default : Util_S.S)
  else (module Test : Util_S.S)
))
