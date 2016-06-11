#############################################################################
# The make process relies on the creation of DLL and library response file  #
# creation.  To control the location of object modules the following should #
# be defined:                                                               #
#                                                                           #
#     IMPOBJS - A list of object modules that should appear in the DLL      #
#               import library.                                             #
#                                                                           #
#        OBJS - If a DLL is build, this is a list of the object modules     #
#               that are linked into the DLL.  If building a library, this  #
#               is the list of object modules that goes into the library.   #
#                                                                           #
# The building of miscellaneous object modules and libraries is controlled  #
# by the list of files in the MISC variable.                                #
#                                                                           #
# $Revision: 34776 $	                                                    #
#                                                                           #
#############################################################################

!include defines.mak

#############################################################################
# Build the object module lists.                                            #
#############################################################################
OBJS =	             \
	dllmain$(OBJ)  \
	dllentry$(OBJ) \
	fmxmain$(OBJ)  \
	globals$(OBJ)  \
	initexit$(OBJ) \
	libmain$(OBJ)  \
	startup$(OBJ)  \
	wstartup$(OBJ) \
	startupd$(OBJ) \
	wstrtupd$(OBJ)

!if !$d(WIN64) # FIXME
OBJS = $(OBJS) \
	rawdll$(OBJ)
!endif

!if !$d(NOXX)
!if !$d(WIN64)
OBJS = $(OBJS) \
	dllx$(OBJ)
!endif
!endif

!if $d(DLL)
IMPOBJS =            \
	dllmain$(OBJ)  \
        dllentry$(OBJ) \
	libmain$(OBJ)  \
        fmxmain$(OBJ)  \
        rawdll$(OBJ)

!if !$d(WIN64)
MISC =  $(LIBDIR)\c0d32x$(OBJ)
!endif

!endif

!if $d(WIN64)
    MISC =  $(MISC)                  \
            $(LIBDIR)\c0d64$(OBJ)    \
            $(LIBDIR)\c0w64$(OBJ)    \
            $(LIBDIR)\c0x64$(OBJ)    \
            $(LIBDIR)\c0fmx64$(OBJ)  \
            $(LIBDIR)\c0fmx64w$(OBJ) \
            $(LIBDIR)\c0d64w$(OBJ)   \
            $(LIBDIR)\c0w64w$(OBJ)   \
            $(LIBDIR)\c0x64w$(OBJ)
!else
    MISC =  $(MISC)                \
            $(LIBDIR)\c0d32$(OBJ)    \
            $(LIBDIR)\c0w32$(OBJ)    \
            $(LIBDIR)\c0fmx32$(OBJ)  \
            $(LIBDIR)\c0fmx32w$(OBJ) \
            $(LIBDIR)\c0x32$(OBJ)    \
            $(LIBDIR)\c0d32w$(OBJ)   \
            $(LIBDIR)\c0w32w$(OBJ)   \
            $(LIBDIR)\c0x32w$(OBJ)   \
            $(LIBDIR)\c0s32$(OBJ)
!endif

!if $d(MAGIC)
!if !$d(WIN64)
    MISC =  $(MISC)                \
            $(LIBDIR)\c0pkg32$(OBJ)  \
            $(LIBDIR)\c0pkg32w$(OBJ)
!else
    MISC =  $(MISC)                \
            $(LIBDIR)\c0pkg64$(OBJ)  \
            $(LIBDIR)\c0pkg64w$(OBJ)
!endif
!endif


!if $d(DLL)
# if building the RTLDLL, add in dllstub$(OBJ) & rtldll$(OBJ) for the RTLDLL to
# find and use for itself.

    OBJS  =                      \
            dllstub$(OBJ)          \
            rtldll$(OBJ)           \
            $(OBJS)

!if !$d(WIN64)
# then add dlllock$(OBJ) to the import library so that the target DLL links with
# this one instead.

    IMPOBJS = $(IMPOBJS)           \
            dlllock$(OBJ)
!endif

!else
    OBJS    = $(OBJS)              \
            dllstub$(OBJ)

!endif

#############################################################################
# Configure the environment appropriately.                                  #
#############################################################################
TASMCFG = 1        # Force tasm.cfg creation
TASM_CASE_SENSITIVE = 1

!include rules.mak

#############################################################################
# MISC explicit rules.                                                      #
#############################################################################
#
# Here we compile the startup code to the LIBDIR directly so that the
# dependancies are invoked and all the files are built only the first time.
#
#$(LIBDIR)\c0w32.o : c0w32.c
#    $(CC) -m -D__syscall=__cdecl -o$< $?

$(LIBDIR)\c0w32.o : c0w32.nasm
  $(ASM) $(AFLAGS) $? -o $<

$(LIBDIR)\c0x32.o : c0x32.nasm c0w32.nasm
  $(ASM) $(AFLAGS) c0x32.nasm -o $<

!if $d(CLANG32) # FIXME: no exception support
$(LIBDIR)\c0x32.obj : c0ntx.asm     c0nt.asm
  $(ASM) $(ASMFLAGS) c0ntx.asm,$<;
!else
$(LIBDIR)\c0x32.obj : c0nt.asm     c0nt.asm
  $(ASM) $(ASMFLAGS) c0nt.asm,$<;
!endif

$(LIBDIR)\c0x32w.obj : wc0nt.asm   c0nt.asm
  $(ASM) $(ASMFLAGS) wc0nt.asm,$<;

$(LIBDIR)\c0w32.obj : c0ntw.asm    c0nt.asm
  $(ASM) $(ASMFLAGS) c0ntw.asm,$<;

$(LIBDIR)\c0w32w.obj : wc0ntw.asm  c0nt.asm
  $(ASM) $(ASMFLAGS) wc0ntw.asm,$<;

$(LIBDIR)\c0d32.obj : c0ntd.asm    c0nt.asm
  $(ASM) $(ASMFLAGS) c0ntd.asm,$<;

$(LIBDIR)\c0d32w.obj : wc0ntd.asm  c0nt.asm
  $(ASM) $(ASMFLAGS) wc0ntd.asm,$<;

$(LIBDIR)\c0d32x.obj: c0ntdx.asm   c0nt.asm
  $(ASM) $(ASMFLAGS) c0ntdx.asm,$<;

$(LIBDIR)\c0pkg32.obj: c0ntpkg.asm c0nt.asm
  $(ASM) $(ASMFLAGS) c0ntpkg.asm,$<;

$(LIBDIR)\c0pkg32w.obj: wc0ntpkg.asm c0nt.asm
  $(ASM) $(ASMFLAGS) wc0ntpkg.asm,$<;

$(LIBDIR)\c0fmx32.obj : c0ntfmx.asm    c0nt.asm
  $(ASM) $(ASMFLAGS) c0ntfmx.asm,$<;

$(LIBDIR)\c0fmx32w.obj : wc0ntfmx.asm    c0nt.asm
  $(ASM) $(ASMFLAGS) wc0ntfmx.asm,$<;

$(LIBDIR)\c0s32.obj : c0ntds.asm   c0nt.asm
  $(ASM) $(ASMFLAGS) c0ntds.asm,$<;

$(LIBDIR)\c0w32mini.obj : c0wmini.asm    c0nt.asm
  $(ASM) $(ASMFLAGS) c0wmini.asm,$<;

$(LIBDIR)\c0x32mini.obj : c0nt.asm     c0nt.asm
  $(ASM) $(ASMFLAGS) c0xmini.asm,$<;

# Win64 startup

$(LIBDIR)\c0w64.o : c0nt64.nasm
  $(ASM) $(AFLAGS) $? -o $<

$(LIBDIR)\c0x64.o : c0nt64.nasm
  $(ASM) $(AFLAGS) -DCONSOLE $? -o $<

$(LIBDIR)\c0d64.o : c0nt64.nasm
  $(ASM) $(AFLAGS) -DDLL $? -o $<

$(LIBDIR)\c0w64w.o : c0nt64.nasm
  $(ASM) $(AFLAGS) -D_UNICODE $? -o $<

$(LIBDIR)\c0x64w.o : c0nt64.nasm
  $(ASM) $(AFLAGS) -D_UNICODE -DCONSOLE $? -o $<

$(LIBDIR)\c0d64w.o : c0nt64.nasm
  $(ASM) $(AFLAGS) -D_UNICODE -DDLL $? -o $<

$(LIBDIR)\c0fmx64.o : c0nt64.nasm
  $(ASM) $(AFLAGS) -DFMX $? -o $<

$(LIBDIR)\c0fmx64w.o : c0nt64.nasm
  $(ASM) $(AFLAGS) -DFMX -D_UNICODE $? -o $<

$(LIBDIR)\c0pkg64.o : c0nt64.nasm
  $(ASM) $(AFLAGS) -DDLL -DPACKAGE $? -o $<

$(LIBDIR)\c0pkg64w.o : c0nt64.nasm
  $(ASM) $(AFLAGS) -DDLL -DPACKAGE -D_UNICODE $? -o $<

wstartup$(OBJ) : startup.c

wstrtupd$(OBJ) : startupd.c
