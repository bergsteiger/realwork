!if $d(ELF) || $d(WIN64)
LIB=.a
OBJ=.o
!else
LIB=.lib
OBJ=.obj
!endif