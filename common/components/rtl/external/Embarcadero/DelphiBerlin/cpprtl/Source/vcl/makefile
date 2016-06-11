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
# $Revision: 35715 $                                                       #
#                                                                           #
#############################################################################

!include defines.mak

#############################################################################
# Build the object module lists.                                            #
#############################################################################

CRTLSTUB_OBJS =      \
        crtlst_i$(OBJ) \
        crtlst_e$(OBJ) \
        crtlst_l$(OBJ) \
	$(EMPTY)

!if $d(WIN64) || $d(CLANG32)
CRTLSTUB_OBJS = $(CRTLSTUB_OBJS) \
	crtlst_excpt$(OBJ)
!endif

!if $d(MAGIC)
!if !$d(DLL)
OBJS = $(OBJS)	     \
        need_vcl$(OBJ) \
        crtlvcl$(OBJ)  \
        crtl_thd$(OBJ) \
        gthpstat$(OBJ) \
        hook8087$(OBJ) \
        vlibstub$(OBJ) \
        vclinit$(OBJ)

!if $d(WIN64)
OBJS = $(OBJS) \
	package$(OBJ)
!endif

!else  # !DLL
OBJS = $(OBJS)	      \
        gthpstat$(OBJ)  \
        crtl_thd$(OBJ)  \
        hook8087$(OBJ) \
        vclinit$(OBJ) \
        $(CRTLSTUB_OBJS)

!endif # !DLL
!else  # MAGIC
OBJS = $(OBJS)       \
       $(CRTLSTUB_OBJS)

!endif # MAGIC

!if $d(MAGIC)
!if $d(DLL)

IMPOBJS_P_ONLY=$(IMPOBJS_P_ONLY)  \
        need_vcl$(OBJ) \
        crtlvcl$(OBJ)  \
        vlibstub$(OBJ) \
        vclshmem$(OBJ) \
        syshook$(OBJ)

!if $d(WIN64)
IMPOBJS_P_ONLY=$(IMPOBJS_P_ONLY) \
	package$(OBJ)
!endif

IMPOBJS_W_ONLY=$(IMPOBJS_W_ONLY)  \
        $(CRTLSTUB_OBJS)

OBJS =  $(OBJS)      \
        vclshmem$(OBJ)

!endif # DLL

OBJS =  $(OBJS)      \
        syshook$(OBJ)

!else  # MAGIC
  IMPOBJS= $(IMPOBJS) $(CRTLSTUB_OBJS)
!endif # MAGIC

!if $d(MAGIC) && !$d(DLL) && !$d(WIN64)
MISC = $(MISC)              \
        $(LIBDIR)\vcllink.lib   \
        $(LIBDIR)\vclstd.lib

VCLLIBOBJS = vcllib$(OBJ)
VCLSTDLIBOBJS = vclstd$(OBJ)
!endif # MAGIC && !DLL

#############################################################################
# Configure the environment appropriately.                                  #
#############################################################################
!include rules.mak

#############################################################################
# MISC explicit rules.                                                      #
#############################################################################
!if $d(MAGIC) && !$d(DLL) && !$d(WIN64)

#
# Rules for creating the small VCLLINK.LIB and VCLSTD.LIB (standard SKU version)
#
# NOTE: Don't use the $(TLIB) macro since that includes the /0 switch that
#       will remove the pragma comment (lib, "...") entries.
#

$(LIBDIR)\vcllink.lib: $(VCLLIBOBJS)
    makersp "-+!s &\n" &&|
        $?
|   > $&.rsp
    tlib /C $< @$&.rsp, temp.lst
    del *.rsp
    del temp.lst
    if exist $*.bak del $*.bak

$(LIBDIR)\vclstd.lib: $(VCLSTDLIBOBJS)
    makersp "-+!s &\n" &&|
        $?
|   > $&.rsp
    tlib /C $< @$&.rsp, temp.lst
    del *.rsp
    del temp.lst
    if exist $*.bak del $*.bak

!endif
