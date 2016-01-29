@echo off
rem **********************
rem   .BAT file to compile Lex/Yacc with Free Pascal 0.99.5 or later.
rem   Output is a 32-bit executable.
rem   Assumes Free Pascal compiler 'ppc386' is in your path.
rem **********************
ppc386 -Sg -vi lex
ppc386 -Sg -vi lexlib
ppc386 -Sg -vi yacc
