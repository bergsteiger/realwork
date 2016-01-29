@echo off
rem **********************
rem   .BAT file to compile Lex/Yacc with Borland Pascal 7.0 or earlier.
rem   Output is a 16-bit real mode program.
rem   Assumes Borland's Pascal command-line compiler 'tpc' is in your path.
rem **********************
tpc -m -l -$R- -$S- -$I- lex
tpc -m -l -$R- -$S- -$I- lexlib
tpc -m -l -$R- -$S- -$I- yacc
