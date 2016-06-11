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
# $Revision: 35621 $                                                        #
#                                                                           #
#############################################################################

!include defines.mak

#############################################################################
# Build the object module lists.                                            #
#############################################################################
OBJS =           \
    assert$(OBJ)   \
    assertf$(OBJ)  \
    bsearch$(OBJ)  \
    bsearch_s$(OBJ)\
    borutil$(OBJ)  \
    castmptr$(OBJ) \
    constraint$(OBJ)\
    delayhlp$(OBJ) \
    delayhk$(OBJ)  \
    ermsghlp$(OBJ) \
    errno$(OBJ)    \
    ermsghlp$(OBJ) \
    errormsg$(OBJ) \
    getstrm$(OBJ)  \
    lsearch$(OBJ)  \
    match$(OBJ)    \
    platform$(OBJ) \
    pureerr$(OBJ)  \
    qsort$(OBJ)    \
    qsort_s$(OBJ)  \
    regexp$(OBJ)   \
    swab$(OBJ)     \
    version$(OBJ)  \
    seterrmd$(OBJ) \
    unmangle$(OBJ) \
    $(EMPTY)

!if $d(CLANG32)
OBJS = $(OBJS) \
    backpatch$(OBJ)\
    bpvars$(OBJ)   \
    embt_fixunsdfdi$(OBJ) \
    embt_fixunssfdi$(OBJ) \
    embt_fixunsxfdi$(OBJ) \
    $(EMPTY)
!endif

!if !$d(WIN64)
OBJS = $(OBJS)     \
    ddvt$(OBJ)     \
    $(EMPTY)
!else
OBJS = $(OBJS)     \
    backpatch$(OBJ)\
    bpvars$(OBJ)   \
    interlocked$(OBJ) \
    rtlsecurezeromemory$(OBJ) \
    $(EMPTY)
!endif

!if !$d(CLANG32)
OBJS = $(OBJS) \
    debug_wrapper$(OBJ) \
    $(EMPTY)
!endif

!if $d(DLL)
    RES  = version.res

    IMPOBJS = \
        delayhlp$(OBJ) \
        delayhk$(OBJ)  \
        pureerr$(OBJ)  \
	$(EMPTY)

!if !$d(WIN64)
    IMPOBJS = $(IMPOBJS) \
        ddvt$(OBJ) \
	$(EMPTY)

!if !$d(CLANG32)
IMPOBJS = $(IMPOBJS) \
    debug_wrapper$(OBJ) \
    $(EMPTY)
!endif

!if $d(CLANG32)
    IMPOBJS = $(IMPOBJS) \
        backpatch$(OBJ)\
        bpvars$(OBJ) \
        embt_fixunsdfdi$(OBJ) \
        embt_fixunssfdi$(OBJ) \
        embt_fixunsxfdi$(OBJ) \
	$(EMPTY)
!endif
!else
    IMPOBJS = $(IMPOBJS) \
        backpatch$(OBJ)\
        bpvars$(OBJ) \
	interlocked$(OBJ) \
        rtlsecurezeromemory$(OBJ) \
        swab$(OBJ) \
        debug_wrapper$(OBJ) \
	$(EMPTY)
!endif

!else
!if !$d(WIN64)
    MISC = $(LIBDIR)\gp$(OBJ)
!endif
!endif


!if !$d(WIN64)
MISC = $(MISC) $(LIBDIR)\obsolete.lib
!endif

#############################################################################
# Configure the environment appropriately.                                  #
#############################################################################
TASMCFG = 1        # Force tasm.cfg creation

!include rules.mak

#############################################################################
# MISC explicit rules.                                                      #
#############################################################################
$(LIBDIR)\obsolete.lib : obsolete$(OBJ)
    $(TLIB) $(LIBDIR)\$&+$**
    if exist $(LIBDIR)\$&.bak del $(LIBDIR)\$&.bak

$(LIBDIR)\gp$(OBJ) : gp$(OBJ)
    copy $** $(LIBDIR)\$.

bsearch_s$(OBJ): bsearch.c
qsort_s$(OBJ): qsort.c
