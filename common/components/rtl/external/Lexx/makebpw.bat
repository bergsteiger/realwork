@echo off
rem **********************
rem   .BAT file to compile Lex/Yacc with Borland Pascal 7.0 or
rem   Borland Pascal for Windows 1.X.
rem   Output is a 16-bit protected mode Windows program.
rem   Assumes Borland's Pascal command-line compiler 'bpc' is in your path.
rem **********************
bpc -cw -m -$R- -$Q- -$S- -$I- lex
bpc -cw -m -$R- -$Q- -$S- -$I- lexlib
bpc -cw -m -$R- -$Q- -$S- -$I- yacc
