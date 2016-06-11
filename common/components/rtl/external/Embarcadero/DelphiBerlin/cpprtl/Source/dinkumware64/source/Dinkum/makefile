!include defines.mak

OBJS = \
	xtime$(OBJ)   \
	$(EMPTY)

!if $d(MT)
OBJS =  $(OBJS)       \
	cond$(OBJ)    \
	cthread$(OBJ) \
	mutex$(OBJ)   \
	once$(OBJ)    \
	threadexc$(OBJ) \
	tss$(OBJ)     \
	xnotify$(OBJ)   \
	$(EMPTY)
#	threadgrp$(OBJ) \
#	threadcall$(OBJ) \

!endif

!include rules.mak
