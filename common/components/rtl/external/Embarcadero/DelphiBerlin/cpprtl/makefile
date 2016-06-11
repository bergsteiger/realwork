#############################################################################
# This makefile is used as the driver to build the chosen RTL.  For         #
# appropriate command line switches and environment variables, see          #
# rules.mak                                                                 #
#############################################################################
!include rules.mak

#############################################################################
# Build the command line.  NOTE: The code here is based on rules.mak.  If   #
# rules.mak is enhanced or modified, make the results must be reflected     #
# here as well!!!                                                           #
#############################################################################

CMDLINE = TARGET_OS=$(TARGET_OS) 

!if !$d(MINIRTL)
# Turn off MBCS for now to bootstrap
CMDLINE = $(CMDLINE) -DMBCS
!endif

!if $d(MINIRTL)
CMDLINE = $(CMDLINE) -DMINIRTL
!endif

!if $d(MINIRTL_EDG)
CMDLINE = $(CMDLINE) -DMINIRTL_EDG -DELF -DEDG
!endif

!if $d(INTERNAL_BUILD)
CMDLINE = $(CMDLINE) -DINTERNAL_BUILD
!endif

!if $d(WIN64)
    CMDLINE = $(CMDLINE) -DWIN64
!endif

!if $d(DEBUG)
    CMDLINE = $(CMDLINE) -DDEBUG
!endif

!if $d(DLL)
    CMDLINE = $(CMDLINE) -DDLL
!endif

!if $d(MT)
    CMDLINE = $(CMDLINE) -DMT
!endif

!if $d(MAGIC)
    CMDLINE = $(CMDLINE) -DMAGIC
!endif

!if $d(PCH)
    CMDLINE = $(CMDLINE) -DPCH
!endif

!if $d(MAKEFLAGS)
    CMDLINE = $(CMDLINE) -$(MAKEFLAGS)
!endif

!if $d(RTL_FORCE_FULL_REBUILD)
    CMDLINE = -B $(CMDLINE)
!endif

#############################################################################
# What needs to be built.                                                   #
#############################################################################
!if $d(CLANG32)
BITS_SFX=c
!endif

all : createdir start srcdirs builddir end

createdir:
  if not exist $(PSDKDIR) mkdir $(PSDKDIR)
  if not exist $(RTLROOT)\obj mkdir $(RTLROOT)\obj
  if not exist $(LIBDIR) mkdir $(LIBDIR)
!if $d(CLANG32)
  copy lib\makefile $(LIBDIR)
!endif
  @if not exist $(RTLROOT)\obj\win$(BITS)$(BITS_SFX) mkdir $(RTLROOT)\obj\win$(BITS)$(BITS_SFX)
  @if not exist $(RTLROOT)\obj\win$(BITS)$(BITS_SFX)\obj mkdir $(RTLROOT)\obj\win$(BITS)$(BITS_SFX)\obj
  @if not exist $(RTLROOT)\obj\win$(BITS)$(BITS_SFX)\objx mkdir $(RTLROOT)\obj\win$(BITS)$(BITS_SFX)\objx
  @if not exist $(RTLROOT)\obj\win$(BITS)$(BITS_SFX)\objmt mkdir $(RTLROOT)\obj\win$(BITS)$(BITS_SFX)\objmt
  @if not exist $(RTLROOT)\obj\win$(BITS)$(BITS_SFX)\objmtx mkdir $(RTLROOT)\obj\win$(BITS)$(BITS_SFX)\objmtx
  @if not exist $(RTLROOT)\obj\win$(BITS)$(BITS_SFX)\objmg mkdir $(RTLROOT)\obj\win$(BITS)$(BITS_SFX)\objmg # FIXME
  @if not exist $(RTLROOT)\obj\win$(BITS)$(BITS_SFX)\objmgmt mkdir $(RTLROOT)\obj\win$(BITS)$(BITS_SFX)\objmgmt
  @if not exist $(RTLROOT)\obj\win$(BITS)$(BITS_SFX)\objmgmtx mkdir $(RTLROOT)\obj\win$(BITS)$(BITS_SFX)\objmgmtx

srcdirs : $(SRCDIRS)

BUILDDIR = $(LIBDIR)

builddir : $(BUILDDIR)

#############################################################################
# For each source directory build whatever is necessary.                    #
#############################################################################
$(SRCDIRS) :
    @echo .
    @echo [*************** $* ***************]
    @echo .
    &cd $*
    @echo Processing [$(CMDLINE)] $* >> $(RTLROOT)\progress.txt
    $(MAKE) -I$(RTLROOT) $(CMDLINE) objs

$(BUILDDIR) :
    @echo .
    @echo Processing [$(CMDLINE)] $* >> $(RTLROOT)\progress.txt
    @echo [*************** $* ***************]
    @echo .
    cd $*
!if $d(DLL)
     $(MAKE) -I$(RTLROOT) $(CMDLINE) dll
!else
     $(MAKE) -I$(RTLROOT) $(CMDLINE) objs
     $(MAKE) -I$(RTLROOT) $(CMDLINE) lib
!endif


#############################################################################
# Do whatever is necessary at the start and end of the build.               #
#############################################################################
start :
!if !$d(RTLSOURCE)
    @python -c "import datetime; print datetime.datetime.now()"
    @echo Current path: %PATH%
!endif
    @echo .
    @echo [***************** Borland C++ Run Time Libary *****************]
    @echo .
    @echo Starting RTL Build [$(CMDLINE)] > $(RTLROOT)\progress.txt
!if $d(DLL)
    if exist $(LIBDIR)\dll.rsp del $(LIBDIR)\dll.rsp
    echo $(LIBDIR)\\$(DLLC0)+ > $(LIBDIR)\dll.rsp
    if exist $(LIBDIR)\import.rsp del $(LIBDIR)\import.rsp
    if exist $(LIBDIR)\import_w.rsp del $(LIBDIR)\import_w.rsp
!else
    if exist $(LIBDIR)\tlib.rsp del $(LIBDIR)\tlib.rsp
    if exist $(LIBDIR)\ar.rsp del $(LIBDIR)\ar.rsp
!endif

end :
    @echo Ending RTL Build [$(CMDLINE)] >> $(RTLROOT)\progress.txt
    cd $(RTLROOT)
!if !$d(KEEP_RTL_TEMP_FILES)
!if $d(DLL)
    if exist $(LIBDIR)\dll.rsp del $(LIBDIR)\dll.rsp
    if exist $(LIBDIR)\import.rsp del $(LIBDIR)\import.rsp
    if exist $(LIBDIR)\import_w.rsp del $(LIBDIR)\import_w.rsp
!else
    if exist $(LIBDIR)\tlib.rsp del $(LIBDIR)\tlib.rsp
    if exist $(LIBDIR)\ar.rsp del $(LIBDIR)\ar.rsp
!endif
!endif
!if !$d(RTLSOURCE)
    @python -c "import datetime; print datetime.datetime.now()"
!endif

!if $d(INTERNAL_BUILD)
clean :
    call clean.btm all
!endif

