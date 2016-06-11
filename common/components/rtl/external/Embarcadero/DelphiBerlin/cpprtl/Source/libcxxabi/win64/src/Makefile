!include defines.mak

OBJS = 	\
	abort_message$(OBJ) \
	cxa_aux_runtime$(OBJ) \
	cxa_demangle$(OBJ) \
	cxa_virtual$(OBJ) \
	private_typeinfo$(OBJ) \
	typeinfo$(OBJ) \
	guard_stub$(OBJ) \
	$(EMPTY)

IMPOBJS = \
	$(EMPTY)

!if $d(MT)
CCXTRAFLAGS = $(CCXTRAFLAGS) -isystem ../include -DSUPPRESS_NOEXCEPT= -DHAS_THREAD_LOCAL -Dthread_local=__declspec(thread)
!else
CCXTRAFLAGS = $(CCXTRAFLAGS) -I..\include -DSUPPRESS_NOEXCEPT -DHAS_THREAD_LOCAL -Dthread_local=
!endif

!include rules.mak

CFLAGS = $(CFLAGS) -isystem ../include -D_NOEXCEPT=
