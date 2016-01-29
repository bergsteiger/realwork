@echo off
rem **********************
rem   .BAT file to show how Lex/Yacc should be compiled.
rem   Output is a 32-bit console program.
rem   Assumes Delphi's 32-bit dcc32 compiler is in your path.
rem **********************
del *.dcu
dcc32 -$H- -$R+ -$Q+ -P -cc -H -M lex
dcc32 -$H- -$R+ -$Q+ -P -cc -H -M lexlib
dcc32 -$H- -$R+ -$Q+ -P -cc -H -M yacc
