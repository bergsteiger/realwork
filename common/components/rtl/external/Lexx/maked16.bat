@echo off
rem **********************
rem   .BAT file to compile Lex/Yacc with Delphi 1.XX.
rem   Output is a 16-bit Windows program.
rem   Assumes Delphi's 16-bit dcc compiler is in your path.
rem **********************
del *.dcu
dcc -$R- -$Q- -$S- lex
dcc -$R- -$Q- -$S- lexlib
dcc -$R- -$Q- -$S- yacc
