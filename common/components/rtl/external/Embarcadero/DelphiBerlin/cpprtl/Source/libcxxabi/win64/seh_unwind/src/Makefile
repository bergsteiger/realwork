!include defines.mak

!if "$(TARGET_OS)" == "WIN64"
OBJS = 	\
	cpp_unwind$(OBJ) \
	debughook$(OBJ) \
	debugger$(OBJ) \
	delphi_support$(OBJ) \
	diag$(OBJ) \
	fallback_malloc$(OBJ) \
	personality$(OBJ) \
	seh_handler$(OBJ) \
	seh_filter$(OBJ) \
	unwind$(OBJ)
!else
# TODO: seh_filter is in nasm code - recode for win32
# TODO: seh_handler needs significant work for win32
OBJS = 	\
	cpp_unwind$(OBJ) \
	debughook$(OBJ) \
	debugger$(OBJ) \
	delphi_support$(OBJ) \
	diag$(OBJ) \
	fallback_malloc$(OBJ) \
	personality$(OBJ) \
	unwind_win32$(OBJ) \
	unwind$(OBJ) \
	hookerr$(OBJ)
!endif

!if "$(TARGET_OS)" == "WIN64"
OBJS = $(OBJS) \
	debug$(OBJ)
!endif

IMPOBJS = \
	debughook$(OBJ)

TASMCFG = 1
!include rules.mak

!if "$(TARGET_OS)" == "WIN32"
!if $d(MT)
# TODO: workaround for command line driver issue with -Dthread_local=
# when this gets fixed, remove the define for NO_THREAD_LOCAL in cpp_unwind.cpp
CCXTRAFLAGS = $(CCXTRAFLAGS) -isystem ../include -D_NOEXCEPT= -DHAS_THREAD_LOCAL -Dthread_local=__declspec(thread)
!else
CCXTRAFLAGS = $(CCXTRAFLAGS) -I..\include -D_NOEXCEPT= -DHAS_THREAD_LOCAL -Dthread_local=NO_THREAD_LOCAL
!endif
!endif

!if $d(MT)
CFLAGS = $(CFLAGS) -isystem ../include -D_NOEXCEPT= -DHAS_THREAD_LOCAL -Dthread_local=__declspec(thread)
!else
!if "$(TARGET_OS)" == "WIN64"
CFLAGS = $(CFLAGS) -isystem ../include -D_NOEXCEPT= -DHAS_THREAD_LOCAL -Dthread_local=
!else
# TODO: workaround for command line driver issue with -Dthread_local=
CFLAGS = $(CFLAGS) -isystem ../include -D_NOEXCEPT= -DHAS_THREAD_LOCAL -Dthread_local=NO_THREAD_LOCAL
!endif
!endif

!if "$(TARGET_OS)" == "WIN32"
# need case insensitive builds for HookERR.asm
ASM = $(ASM) /ml
!endif
