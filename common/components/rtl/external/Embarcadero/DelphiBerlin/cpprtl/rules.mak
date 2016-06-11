#############################################################################
# In order to make a suite, define one or more of the following             #
#                                                                           #
#    DEBUG - Used to build a debuggable version of the RTL.                 #
#                                                                           #
#      DLL - Used to build the DLL version of the RTL.                      #
#                                                                           #
#       MT - Used to include multiple thread support.  This is only allowed #
#            for WIN32.                                                     #
#                                                                           #
# TARGET_OS- Used to indicate the OS.  The default is WIN32.  It should be  #
#            one of the following:                                          #
#              WIN32  = 32 bit Windows on 32 bit Windows                    #
#              WIN64  = 64 bit Windows on 32 or 64 bit Windows              #
#                                                                           #
#      PCH - Used to turn on precompiled headers                            #
#                                                                           #
#############################################################################

#############################################################################
# Setup some reasonable defaults.                                           #
#############################################################################
!if !$d(TARGET_OS)
!if $d(WIN64)
    TARGET_OS=WIN64
!else
    TARGET_OS=WIN32
!endif
!endif

!if $d(RTLSOURCE)
! if !$d(BCB) && $d(BDS)
     BCB = $(BDS)
! endif
! if !$d(BCB)
     BCB = $(MAKEDIR)\..
! endif
! if !$d(RTLROOT)
     RTLROOT = $(BCB)\source\cpprtl
! endif
!else
! if !$d(RTLROOT)
!  if !$d(RTLHOME)
!   error RTLHOME is not defined!!!
!  else
     RTLROOT = $(RTLHOME)
!  endif
! endif
!endif
#############################################################################
# Setup some useful directories.                                            #
#############################################################################
SRCBASE   = $(RTLROOT)\source
!if $d(ELF)
OBJBASE   = $(RTLROOT)\obj\$(TARGET_OS)elf
!else
!if $d(CLANG32)
OBJBASE   = $(RTLROOT)\obj\$(TARGET_OS)c
!else
OBJBASE   = $(RTLROOT)\obj\$(TARGET_OS)
!endif
!endif
!if $d(WIN64)
LIBDIR    = $(RTLROOT)\lib64
DNKSUFFIX = 64
!else
!if $d(CLANG32)
LIBDIR    = $(RTLROOT)\lib32
DNKSUFFIX = 64
!else
LIBDIR    = $(RTLROOT)\lib
!endif
!endif
PSDKDIR   = $(LIBDIR)\psdk
!if $d(RTLSOURCE)
BCINCL    = "$(BCB)\include\windows\crtl";"$(BCB)\include\windows\sdk";"$(BCB)\include\windows\vcl"
INCLBASE  = $(RTLROOT)
!else
INCLBASE  = $(RTLROOT)\include
!endif
!if $d(RTLSOURCE)
EXTDIR    = "$(BCB)\lib\$(TARGET_OS)\release"
!else
EXTDIR    = $(RTLROOT)\external
!endif
!if $d(DINKUMWARE)
!  if $d(INTERNAL_BUILD)
DINKSRCBASE = $(RTLROOT)\dinkumware$(DNKSUFFIX)\source
DINKSRCTR1BASE = $(RTLROOT)\dinkumware$(DNKSUFFIX)\source\tr1
DINKSRCC11BASE = $(RTLROOT)\dinkumware$(DNKSUFFIX)\source\Dinkum
!  else
    DINKSRCBASE = $(SRCBASE)\dinkumware$(DNKSUFFIX)\source
    DINKSRCTR1BASE = $(SRCBASE)\dinkumware$(DNKSUFFIX)\source\tr1
!   if $(RTLSOURCE)
      BCINCL      = $(BCINCL);"$(BCB)\include\dinkumware$(DNKSUFFIX)"
!   endif
!  endif
!endif

#############################################################################
# Guard against illegal variable combinations and obtain the operating      #
# platform specific build rules.                                            #
#############################################################################
!if "$(TARGET_OS)" == "WIN32" || "$(TARGET_OS)" == "WIN64"
TARGET_OS_MAKEFILE = windows.mak
!else
!  error Unknown TARGET_OS
!endif

!include $(TARGET_OS_MAKEFILE)

#############################################################################
# Configure the output paths.                                               #
#############################################################################
!if $d(ELF)
.PATH.o   = $(OBJDIR)
#.PATH.obj = $(OBJDIR)
!else
.PATH.obj = $(OBJDIR)
!endif
.PATH.lib = $(LIBDIR)
.PATH.res = $(OBJDIR)
.PATH.fst = $(OBJDIR)

#############################################################################
# Adjust switches accordingly.                                              #
#############################################################################
!if $d(DEBUG)
!if $d(WIN64)
    CC   = $(CC) -g -D__DEBUG__
!else
    CC   = $(CC) -v -vi -D__DEBUG__
!endif
!if !$d(ELF)
    ASM  = $(ASM) -zi /D__DEBUG__
!endif
    LINK = $(LINK) -v
!endif

#############################################################################
# Implicit source rules.                                                    #
#############################################################################
!if $d(ELF)
!if $d(WIN64)
.nasm.o :
    $(ASM) $(AFLAGS) $? -o $(OBJDIR)\$&.o

!else
.nasm.obj :
    $(ASM) $(AFLAGS) $? -o $(OBJDIR)\$&.o
!endif
!else
.asm.obj :
    $(ASM) $(ASMFLAGS) $*,$(OBJDIR)\;
!endif

!if $d(EDG)
.c.obj :
    $(CC) -D__syscall=__cdecl $<

.cas.obj :
    $(CC) $<

.cpp.obj :
    $(CC) $<

!elif $d(WIN64)
.c.o :
!if $d(DEBUG)
    $(CC) {$< }
!else
    $(CC) -O2 {$< }
!endif

.cpp.o :
    $(CC) -fno-use-cxa-atexit -std=c++11 {$< }

!if $d(DINKUMWARE)
.cx.o :
    $(CC) -fno-use-cxa-atexit -x c++ -std=c++11 {$< }
!endif

.def.imp:
    mkeio $@ $<
    $(TLIB) $(PSDKDIR)\$&.a /u $@

!else
.c.obj :
    $(CC) {$< }

!if $d(DINKUMWARE)
.cx.obj :
    $(CC) -P {$< }
!endif

.cas.obj :
    $(CC) {$< }

.cpp.obj :
    $(CC) {$< }

.cc.obj :
    $(CC) {$< }

.cxx.obj :
    $(CC) {$< }

.c.i :
!if $d(CPP32_Sr)
    $(CPP) -Sr -P- -n. {$< }
!else
    $(CPP) -Sk -Ss -Sd -P -n. {$< }
!endif

.cpp.i :
!if $d(CPP32_Sr)
    $(CPP) -Sr -P- -n. {$< }
!else
    $(CPP) -Sk -Ss -Sd -P -n. {$< }
!endif
!endif

.def.fst:
    $(IMPLIB) $(OBJDIR)\$&.lib $&.def
    fastlib $(OBJDIR)\$&.lib $(OBJDIR)\$&.fst
    copy $(OBJDIR)\$&.fst $(PSDKDIR)\$&.lib
    del $(OBJDIR)\$&.lib

.rc.res :
    $(BRCC) @&&|
    -i$(INCLUDES) -fo$(OBJDIR)\$& $<
|

#############################################################################
# The rules for the compiler and assembler configuration files.             #
#############################################################################
CFG = rtl.cfg

$(OBJDIR)\rtl.cfg : $(RTLROOT)\makefile $(RTLROOT)\rules.mak $(RTLROOT)\$(TARGET_OS_MAKEFILE)
    copy &&|o
	 $(CFLAGS)
|   $@

tasm.cfg :
    copy &&|
	 $(AFLAGS)
|   $@

delcfg :
!if $d(KEEP_TASM_CFG)
    @if exist tasm.cfg echo KEEP_TASM_CFG specified and TASM.CFG found.
!else
    if exist tasm.cfg del tasm.cfg
!endif

cfg : $(OBJDIR)\rtl.cfg

#############################################################################
# The rule for building a response file for library creation.               #
#############################################################################
!if $d(ELF) && !$d(WIN64)
librsp :
    makersp "$(OBJDIR:\=\\)\\!s\n" &&|
	    $(OBJS)
|   >> $(LIBDIR)\ar.rsp
!else
librsp :
    makersp "$(OBJDIR:\=\\)\\!s &\n" &&|
!if $d(WIN64)
	    $(OBJS:.obj=.o)
!else
	    $(OBJS)
!endif
|   >> $(LIBDIR)\tlib.rsp
!endif

#############################################################################
# The rule for building the static RTL.                                     #
#############################################################################
!if $d(WIN64)
lib : librsp
    $(TLIB) $(LIBDIR)\$(LIBNAME)$(MTSUFFIX).a /u @tlib.rsp,temp.lst
!elif $d(ELF)
!if $d(WIN64)
RENAME=--norename
!endif
lib : librsp
    python $(RTLROOT)\tools\makelib.py $(RENAME) --library $(LIBDIR)\$(LIBNAME)$(MTSUFFIX) --objlist $(LIBDIR)\ar.rsp
!else
lib : librsp
    $(TLIB) $(LIBDIR)\$(LIBNAME)$(MTSUFFIX).lib /u @tlib.rsp,temp.lst
# The TLIB_NO_PURGE statement is a temp. workaround for a TASM32 bug which will
# be fixed later.
    $(TLIB_NO_PURGE) $(LIBDIR)\$(LIBNAME)$(MTSUFFIX).lib /u $(OBJDIR)\xx.obj
    $(PUBTOOL) $(RTLROOT)\external\$(PUBNAME) $(LIBDIR)\$(LIBNAME)$(MTSUFFIX).lib $(PUBTOOL_OPTS)
    if exist $(LIBDIR)\$(LIBNAME)$(MTSUFFIX).bak del $(LIBDIR)\$(LIBNAME)$(MTSUFFIX).bak
    del temp.lst
!endif

#############################################################################
# The rules for building response files for RTLDLL and import library       #
# creation                                                                  #
#############################################################################

#
# build the rsp file for linking the RTLDLL
#
dllrsp :
   makersp "$(OBJDIR:\=\\)\\!s+\n" &&|
   $(OBJS)
|  >> $(LIBDIR)\dll.rsp

#
# build the rsp file for CW32I and the CP32MTI version of CC32xxMT.DLL
#
importrsp :
   makersp "$(OBJDIR:\=\\)\\!s &\n" &&|
   $(IMPOBJS) $(IMPOBJS_P_ONLY)
|  >> $(LIBDIR)\import.rsp
#   @echo IMPOBJS = $(IMPOBJS)
#   @echo IMPOBJS_P_ONLY = $(IMPOBJS_P_ONLY)

#
# build the rsp file for the CW32MTI version of CC32xxMT.DLL
#
importrsp_w :
   makersp "$(OBJDIR:\=\\)\\!s &\n" &&|
   $(IMPOBJS) $(IMPOBJS_W_ONLY)
|  >> $(LIBDIR)\import_w.rsp
#   @echo IMPOBJS = $(IMPOBJS)
#   @echo IMPOBJS_W_ONLY = $(IMPOBJS_W_ONLY)


#############################################################################
# The rule for building the RTL DLL and it's import librarie(s)             #
#############################################################################
!if $d(WIN64)
dll : $(LIBDIR)\dll.rsp $(LIBDIR)\import.rsp $(OBJDIR)\version.res
    - $(LINK) $(LINKEROPTS) -j$(EXTDIR) $(RESPATH) @dll.rsp,$(DLLNAME),,$(IMPORT) $(EXTLIB),,$(OBJDIR)\version
    mkexp -e $(DLLNAME).eio $(DLLNAME).dll
    python munge_exports.py $(DLLNAME)
    $(TLIB) $(IMPLIBNAME) /u @import.rsp,nul
    $(TLIB) $(IMPLIBNAME) /u $(DLLNAME)exp.o
!else
dll : $(LIBDIR)\dll.rsp $(LIBDIR)\import.rsp $(OBJDIR)\version.res
    $(LINK) $(LINKEROPTS) -j$(EXTDIR) $(RESPATH) @dll.rsp,$(DLLNAME),,$(IMPORT) $(EXTLIB),,$(OBJDIR)\version
    $(IMPLIB) $(LIBNAME)$(MTSUFFIX)$(DLLSUFFIX).lib $(DLLNAME).dll
    fastlib $(LIBNAME)$(MTSUFFIX)$(DLLSUFFIX).lib $(LIBNAME)$(MTSUFFIX)$(DLLSUFFIX).fst
#------------------------------------------------------------------------------
# The import libs for the RTLDLL are now created in the following order:
#   First, the IMPOBJS files are TLIBed in (so the linker will see them first)
#   Then the impdefs for the DLLs' exports are added.  This is the reverse of
#   the way they used to be inserted into the import libs prior to BCB 3.0.
    $(TLIB) $(IMPLIBNAME) /u @import.rsp,nul
    $(TLIB) $(IMPLIBNAME) /u $(LIBNAME)$(MTSUFFIX)$(DLLSUFFIX).fst
#------------------------------------------------------------------------------
!if $d(MAGIC)
    $(TLIB) $(IMPLIBNAME_W) /u @import_w.rsp,nul
    $(TLIB) $(IMPLIBNAME_W) /u $(LIBNAME)$(MTSUFFIX)$(DLLSUFFIX).fst
    $(PUBTOOL) $(RTLROOT)\external\$(PUBNAME) $(IMPLIBNAME_W).lib $(PUBTOOL_OPTS)
!endif
#------------------------------------------------------------------------------
    $(PUBTOOL) $(RTLROOT)\external\$(PUBNAME) $(IMPLIBNAME).lib $(PUBTOOL_OPTS)
    del $(LIBNAME)$(MTSUFFIX)$(DLLSUFFIX).lib
    del $(LIBNAME)$(MTSUFFIX)$(DLLSUFFIX).fst
    if exist $(IMPLIBNAME).bak del $(IMPLIBNAME).bak
    if exist $(IMPLIBNAME_W).bak del $(IMPLIBNAME_W).bak
!endif

#############################################################################
# The crux of the build process is to build the required response files for #
# either the static or dynamic RTLs.  As the process scans each directory,  #
# the needed objs are built and placed into $(OBJDIR).  The rule below      #
# makes this possible.                                                      #
#############################################################################
RTLCFG = $(OBJDIR)\rtl.cfg

ALL = rtl_cfg

# Here would be a good place to swap extensions but our make doesn't let you assign back correctly
#OBJS = $(OBJS:.obj=.o)

!if $d(OBJS)
    ALL = $(ALL) $(OBJS)
!   if $d(DLL)
	ALL = $(ALL) dllrsp
!   else
	ALL = $(ALL) librsp
!   endif
!endif

!if $d(MISC)
    ALL = $(ALL) $(MISC)
!endif

!if $d(DLL)
!    if $d(RES)
	 ALL = $(ALL) $(RES)
!    endif
!    if $d(IMPOBJS)
	 ALL = $(ALL) $(IMPOBJS)
!    endif
!    if $d(IMPOBJS_W_ONLY)
	 ALL = $(ALL) $(IMPOBJS_W_ONLY)
!    endif
!    if $d(IMPOBJS_P_ONLY)
	 ALL = $(ALL) $(IMPOBJS_P_ONLY)
!    endif
!    if $d(IMPOBJS) || $d(IMPOBJS_P_ONLY)
	 ALL = $(ALL) importrsp
!    endif
!    if $d(MAGIC)
	 ALL = $(ALL) importrsp_w
!    endif
!endif

!if $d(TASMCFG) && !$d(WIN64)
    ALL = tasm.cfg $(ALL) delcfg
!endif

objs : $(ALL)

rtl_cfg: $(RTLCFG)
