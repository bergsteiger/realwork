!include defines.mak

OBJS = \
	atomic$(OBJ)    \
	atomic_x86$(OBJ)\
	filesys$(OBJ)   \
	multprec$(OBJ)	\
	regex$(OBJ)     \
	syserror$(OBJ)	\
	xlgamma$(OBJ)	\
	xrngabort$(OBJ) \
	xrngdev$(OBJ)   \
	$(EMPTY)
#	badfunction$(OBJ)\
#	placeholders$(OBJ)\

!if $d(MT)
OBJS =  $(OBJS)       \
	future$(OBJ)   \
	thread0$(OBJ)   \
	xonce$(OBJ)     \
	$(EMPTY)

!endif

IMPOBJS = \
	atomic$(OBJ)    \
	atomic_x86$(OBJ)\
	$(EMPTY)

!include rules.mak
