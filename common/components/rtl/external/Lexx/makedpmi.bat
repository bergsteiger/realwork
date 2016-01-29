@echo off
rem **********************
rem   .BAT file to compile Lex/Yacc with Borland Pascal 7.0.
rem   Output is a 16-bit protected mode program.
rem   Assumes Borland's Pascal command-line compiler 'bpc' is in your path.
rem **********************
bpc -cp -m -$R- -$Q- -$S- -$I- lex
bpc -cp -m -$R- -$Q- -$S- -$I- lexlib
bpc -cp -m -$R- -$Q- -$S- -$I- yacc
