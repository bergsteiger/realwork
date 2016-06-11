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
# $Revision: 34070 $                                                                #
#                                                                           #
#############################################################################

!include defines.mak

#############################################################################
# Build the object module lists.                                            #
#############################################################################
!if $d(MINIRTL)
OBJS =               \
	tlsstat$(OBJ)
!else
OBJS =          \
	tls$(OBJ)
!if $d(WIN64)
OBJS = $(OBJS) \
	tlsend$(OBJ) \
	tlssize$(OBJ)

IMPOBJS = $(IMPOBJS) \
	tlsend$(OBJ) \
	tlssize$(OBJ)
!endif
!endif

!if $d(DLL)
!if $d(WIN64)
    OBJS =  $(OBJS)      \
	    tlsstat$(OBJ)

    IMPOBJS =  $(IMPOBJS) \
	    tlsstat$(OBJ)
!else
    OBJS =  $(OBJS)      \
	    tlsdyn$(OBJ)
!endif
!else
    OBJS =  $(OBJS)      \
	    tlsstat$(OBJ)
!endif # DLL

!if $d(MT)
    OBJS =  $(OBJS)      \
	    thrdbuf$(OBJ)  \
	    thrddata$(OBJ) \
	    thread$(OBJ)   \
	    fiber$(BITS)$(OBJ)    \
	    _lock$(OBJ)

!if !$d(WIN64)
    OBJS =  $(OBJS)      \
	    threadid$(OBJ)
!else
    OBJS =  $(OBJS)      \
	    c_threadid$(OBJ)
!endif

    IMPOBJS =  $(IMPOBJS) \
	    fasttls$(OBJ)

!if $d(WIN64)
    IMPOBJS = $(IMPOBJS) \
	    fiber$(BITS)$(OBJ)
!endif

    TASMCFG = 1        # Force tasm.cfg creation

!endif # MT

#############################################################################
# Configure the environment apprpriately.                                   #
#############################################################################
!include rules.mak

!if $d(WIN64)
tlssize.o: tlssize.c
    $(CC) -O0 -o $@ $?
!endif
