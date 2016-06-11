#############################################################################
#                                                                           #
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
# $Revision: 34745 $                                                       #
#                                                                           #
#############################################################################

!include defines.mak

#############################################################################
# Build the object module lists.                                            #
#############################################################################
OBJS =  \
        _aligned_malloc$(OBJ) \
        chkstk$(OBJ)   \
        hrdir_b$(OBJ)  \
        hrdir_bh$(OBJ) \
        hrdir_c$(OBJ)  \
        hrdir_g$(OBJ)  \
        hrdir_mf$(OBJ) \
        hrdir_r$(OBJ)  \
        hrdir_s$(OBJ)  \
        hrdir_us$(OBJ) \
        vapp$(OBJ)     \
        vappv$(OBJ)    \
        vdel$(OBJ)     \
	$(EMPTY)

!if !$d(WIN64)
OBJS = 	$(OBJS)        \
        _alloca$(OBJ)  \
        _stkavl$(OBJ)  \
        _stkchk$(OBJ)  \
        alloca$(OBJ)   \
        initstk$(OBJ)  \
        memchk$(OBJ)   \
        setnew$(OBJ)   \
        stkavail$(OBJ) \
        virtmem$(OBJ)  \
	$(EMPTY)
!else
OBJS = $(OBJS)	     \
        malloc$(OBJ) \
	$(EMPTY)
!endif # !WIN64

# bcc32 compiler helpers
!if !$d(CLANG)
OBJS = $(OBJS)       \
        vdelldtc$(OBJ) \
        vnewldtc$(OBJ) \
        vnwvldtc$(OBJ) \
	$(EMPTY)
!endif # !CLANG

# Select memory manager
!if $d(MAGIC) && !$d(DLL)
OBJS = $(OBJS)	     \
        pheap$(OBJ)  \
	$(EMPTY)
!else
OBJS = $(OBJS)	       \
	_fastmm$(OBJ)  \
	_fastmma$(OBJ) \
        heap$(OBJ)     \
        heapchk$(OBJ)  \
        heapchkf$(OBJ) \
        heapchkn$(OBJ) \
        heapfill$(OBJ) \
        heapmin$(OBJ)  \
        heapset$(OBJ)  \
        heapwalk$(OBJ) \
        oheapchk$(OBJ) \
        oheapwlk$(OBJ) \
	realloc$(OBJ)  \
	$(EMPTY)
!endif # memory manager 

!if $d(DLL)

IMPOBJS =            \
        chkstk$(OBJ) \
	$(EMPTY)

!if !$d(WIN64)
IMPOBJS = $(IMPOBJS)  \
        _stkchk$(OBJ) \
        initstk$(OBJ) \
	$(EMPTY)
!endif # !WIN64

# bcc32 compiler helpers
!if !$d(CLANG)
IMPOBJS = $(IMPOBJS)   \
        vdel$(OBJ)     \
        vdelldtc$(OBJ) \
        vnewldtc$(OBJ) \
        vnwvldtc$(OBJ) \
	$(EMPTY)
!endif # !CLANG

!endif # DLL

!if !$d(WIN64)
MISC =	             \
        setnewnx$(OBJ)
!endif # WIN64

!if !$d(MAGIC) && !$d(DLL)
!if  $d(WIN64)
MISC = $(MISC)       \
        $(LIBDIR)\usebormm.a
!else
MISC = $(MISC)       \
        $(LIBDIR)\usebormm.lib
!endif # WIN64
!endif # MAGIC DLL

#############################################################################
# Configure the environment appropriately.                                  #
#############################################################################
TASMCFG = 1        # Force tasm.cfg creation

!include rules.mak

#
# These C++ file must be compiled to generate PUBDEFs since the new & delete
# operators will be smashed into their __org_xxx names by PUBDUP.EXE
# The -V?- switch will prevent COMDEFs and cause PUBDEFs to be generated
#
!if !$d(MINIRTL_EDG) && !defined(MINIRTL) && !defined(WIN64)
XTRAFLAGS=-V?-
!endif

#############################################################################
# MISC explicit rules.                                                      #
#############################################################################
setnewnx$(OBJ) : setnew.cpp
    $(CC) -o$(OBJDIR)\$& -DNOXX $?


!if !$d(MAGIC) && !$d(DLL)

#
# Rule for creating usebormm.lib
#
# NOTE: Don't use the $(TLIB) macro since that includes the /0 switch that
#       will remove the pragma comment (lib, "") entries.
#

!if $d(WIN64)
$(LIBDIR)\usebormm.a: usebormm$(OBJ)
    $(TLIB) $< /u $?

!else
$(LIBDIR)\usebormm.lib: usebormm$(OBJ)
    makersp "-+!s &\n" &&|
        $?
|   > $&.rsp
    tlib /C $< @$&.rsp, temp.lst
    del *.rsp
    del temp.lst
    if exist $*.bak del $*.bak

!endif
!endif
