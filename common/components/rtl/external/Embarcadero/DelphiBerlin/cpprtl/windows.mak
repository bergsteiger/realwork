#############################################################################
# Configure the tools appropriately.                                        #
#############################################################################
!if $d(DLL)

# This is the major file version # of the RTL DLL.
DLLMAJOR        = 24
DLLMAJORX       = 18

# The version number of the product in which this C++ RTL appears
DLLPRODVERSTR   = 24.0

# BETA is defined only prior to RTM and indicates the current milestone.
#BETA            = alpha

# A proper copyright string
DLLCOPYRIGHTSTR = Copyright © 1994-2016 Embarcadero Technologies, Inc.

# The name of the product in which this C++ RTL appears
DLLPRODNAMESTR  = Embarcadero RAD Studio

# The DLLs numeric file version value.
DLLNUMERICFILEVERSION = 0x0$(DLLMAJORX)00000

# DLLVER is the file version number of the RTL *.DLL files: the xx (c?[32|64]xx*.dll)
# DLLVERSTR is a string representation of the same number for VERSION.RC
  DLLVER        = $(DLLMAJOR)0
  DLLVERSTR     = $(DLLMAJOR).0
!if $d(MT)
!if $d(MAGIC)
  DLLDESCSTR    = Embarcadero RAD Studio C++ Multi-thread RTL (WIN/VCL MT)
!else
  DLLDESCSTR    = Embarcadero RAD Studio C++ Multi-thread RTL (WIN MT)
!endif # MAGIC
!else
  DLLDESCSTR    = Embarcadero RAD Studio C++ Single-thread RTL (WIN ST)
!endif # MT

!if "$(TARGET_OS)" == "WIN32" || "$(TARGET_OS)" == "WIN64"
# -b:0x32X00000 for base address - X should be only the major version num.
#               ie: 4 for 40 & 45, 5 for 50, 6 for 60, 7 for 70...
LINKER_DLL_BASE_SWITCH=-b:0x32$(DLLMAJORX)0000
!endif # TARGET_OS

!endif # DLL

!if $d(WIN64)
BITS=64
ELF=1
!else
BITS=32
!endif # WIN64

!if $d(MAGIC) && $d(DLL)
!  if $d(RTLSOURCE)
!    if $d(WIN64)
       EXTLIB="$(BCB)\lib\$(TARGET_OS)\release\rtl.a"
!    else
       EXTLIB="$(BCB)\lib\$(TARGET_OS)\release\rtl.lib"
!    endif 
!  else
!  if $d(WIN64)
     EXTLIB=$(EXTDIR)\vclexternal\lib\rtl.a
     # HACK
     EXTLIB=$(EXTDIR)\vclexternal\lib\prtl.a 
     # EXTLIB=
     RESPATH=-L$(EXTDIR)\vclexternal\lib
!  else
     EXTLIB=$(EXTDIR)\vclexternal\lib\rtl.lib
     RESPATH=-L$(EXTDIR)\vclexternal\lib
!    endif
!  endif
!endif

!if !$d(ELF)
   ASM      = tasm32
!  if $d(RTLSOURCE)
     AFLAGS   = /kh30000 -t -m -D__WIN32__ -I$(INCLBASE)\rtlinc -I$(BCINCL:;= -I)
!  else
     AFLAGS   = /kh30000 -t -m -D__WIN32__ -I$(INCLBASE)\rtlinc -I$(INCLBASE)
!  endif
!  if $d(TASM_CASE_SENSITIVE)
     AFLAGS   = -ml $(AFLAGS)
!  else
     AFLAGS   = -mx $(AFLAGS)
!  endif
!  if $d(CLANG32)
     AFLAGS = $(AFLAGS) -DCLANG32 -DNOXX
!  endif
!else
   # If generating ELF use NASM
   ASM      = nasm
!  if $d(WIN64)
     AFLAGS   = -t -felf64
!  else
     AFLAGS   = -t -felf
!  endif
!endif

BRCC     = brcc32
!if $d(MT)
  BRCC   = $(BRCC) -d__MT__
!endif
!if $d(MAGIC)
  BRCC   = $(BRCC) -dMAGIC
!endif


!if $d(ELF)
!if $d(WIN64)
CC       = bcc64 $(CLANG_OPTS) $(CFLAGS) $(XTRAFLAGS) $(CCXTRAFLAGS) -fmath-errno
CPP      = bcc64 $(CLANG_OPTS) $(CFLAGS) $(XTRAFLAGS) $(CPPXTRAFLAGS)

# quiet down includes until cleaned up
CFLAGS   = -c -isystem $(INCLUDES:;= -isystem ) -n$(OBJDIR) 
#CFLAGS   = -c -I $(INCLUDES:;= -I )

# why do winnt.h and winbase.h use this extra define?
CFLAGS   = $(CFLAGS) -D_X86AMD64_

!else
CC       = bccx $(CFLAGS) $(XTRAFLAGS) $(CCXTRAFLAGS)
CPP      = bccx $(CFLAGS) $(XTRAFLAGS) $(CPPXTRAFLAGS)
CFLAGS   = -c -n$(OBJDIR) -I$(INCLUDES:;= -I)
!endif
!else

CFLAGS   = -c -X -n$(OBJDIR) -I$(INCLUDES:;= -I) -j3 -jb -w 

!if !$d(CLANG32)
CFLAGS = $(CFLAGS) -ff- -w-sig -V? -Q
!endif

!if $d(CLANG32)
CC       = bcc32c +$(OBJDIR)\$(CFG) -isystem $(INCLBASE)\windows $(XTRAFLAGS) $(CCXTRAFLAGS)
# Needed until driver is fixed
CFLAGS   = $(CFLAGS) -Xdriver -fno-short-enums -Xdriver -fmath-error
!else
CC       = bcc32 +$(OBJDIR)\$(CFG) $(XTRAFLAGS) $(CCXTRAFLAGS)
!endif
CPP      = cpp32 +$(OBJDIR)\$(CFG) $(XTRAFLAGS) $(CPPXTRAFLAGS)
!endif

CFLAGS   = $(CFLAGS) -D__RTL_BUILD__ -DNO_STRICT -D__USELOCALES__

!if $d(DINKUMWARE)
CFLAGS = $(CFLAGS) -D_DINKUMWARE
!if !$d(CLANG)
CFLAGS = $(CFLAGS) -w-8076
!endif

!if !$d(DEBUG)
CFLAGS = $(CFLAGS)
!if !$d(WIN64)
CFLAGS = $(CFLAGS) -w-inl
!endif
!endif

!if !$d(MT)
    CFLAGS = $(CFLAGS) -D_NO_MT
!endif

!if $d(DLL)
    CFLAGS = $(CFLAGS) -D__FORCE_INSTANCE
!endif

!endif

!if $d(MINIRTL)
CFLAGS   = $(CFLAGS) -DMINIRTL -DELF
!endif

!if $d(CREATE_ALLSTL)
CFLAGS   = $(CFLAGS) -Jgi -w- -D__CREATE_ALLSTL__
!endif
IMPLIB   = implib -i -c -f
!if $d(RTLSOURCE)
INCLUDES = $(BCINCL);$(INCLBASE)\rtlinc
!else
INCLUDES = $(INCLBASE);$(INCLBASE)\windows;$(INCLBASE)\rtlinc;$(EXTDIR)\vclexternal\include
!endif
!if $d(DINKUMWARE)
INCLUDES = $(INCLUDES);$(INCLBASE)\dinkumware$(DNKSUFFIX)
!endif
!if $d(DLL)
LINK     = ilink$(BITS)
LINKEROPTS=$(LINKEROPTS) -s -c -Tpd -Gn -Gm -M $(LINKER_DLL_BASE_SWITCH)
LINKEROPTS=$(LINKEROPTS) -D"$(DLLDESCSTR)"
!if $d(WIN64)
# FIXME: remove -Gk when unresolved symbols are fixed
LINKEROPTS=$(LINKEROPTS) -Gk
!endif
!if $d(RTLSOURCE)
LINKEROPTS=$(LINKEROPTS) -L"$(BCB)\lib\$(TARGET_OS)\release"
!endif
!endif

#
# The RTLDLL now has the prefix CC always.  The CC32xxMT.DLL supports
# both the standard Win32 RTL (the old CW32...) and the VCL compatible RTL
# (the old CP32...). The import libraries will still have the same names:
# cw32i, cw32mti, cp32mti
#
DLLBASENAME  = cc$(BITS)
LIBNAME      = cw$(BITS)

!if $d(MAGIC)
LIBNAME      = cp$(BITS)
LIBNAME_W    = cw$(BITS)
!endif

!if $d(CLANG32)
DLLBASENAME  = cc$(BITS)c
!endif

OBJDIR = $(OBJBASE)\obj$(MAGICSUFFIX)$(MTSUFFIX)$(DLLSUFFIX)

PUBTOOL = pubdup.exe
PUBNAME = names$(BITS).pub
PUBTOOL_OPTS = -q

!if $d(WIN64)
    TLIB = tlib64 /A /Q
!if $d(DEBUG)
    CFLAGS = $(CFLAGS) -g
!else
    CFLAGS = $(CFLAGS) # issue in __cxa_throw with -O2
!endif
!else # !WIN64
!if $d(DEBUG)
    TLIB = tlib /C /P512 /Q
    TLIB_NO_PURGE = tlib /C /P512 /Q
!if !$d(ELF)
    CFLAGS = $(CFLAGS) -x
!if !$d(CLANG)
    CFLAGS = $(CFLAGS) -xp
!endif    
!else
    CFLAGS = $(CFLAGS) -v
!endif
!else
    TLIB = tlib /C /0 /P512 /Q
    TLIB_NO_PURGE = tlib /C /P512 /Q
    CFLAGS = $(CFLAGS) -O2
!endif
!endif # WIN64

!if $d(MAGIC)
    CFLAGS = $(CFLAGS) -DMAGIC
    AFLAGS = $(AFLAGS) -DMAGIC
    MAGICSUFFIX = mg
!endif

# Select the DEBUGGER exception hooks, see include\rtlinc\xxdbg.h
CFLAGS = $(CFLAGS) -DDEBUGGER_EXCEPTION_HOOKS

!if $d(MT)
    AFLAGS = $(AFLAGS) -D_MT
!if !$d(ELF)
    CFLAGS = $(CFLAGS) -WM
!else
    CFLAGS = $(CFLAGS) -D_MT -D__MT__
!endif
    MTSUFFIX = mt
!else
!if !$d(ELF)
    CFLAGS = $(CFLAGS) -WM-
!endif
!endif

!if $d(BETA)
    CFLAGS = $(CFLAGS) "-D__RTL_BETA=$(BETA)"
!endif

!if $d(MBCS)
    CFLAGS = $(CFLAGS) -D_MBCS -D_MBC_USE_MACROS
    AFLAGS = $(AFLAGS) -D_MBCS -D_MBC_USE_MACROS
!endif

!if $d(DLL)
    AFLAGS = $(AFLAGS) -D_BUILDRTLDLL

    BRCC = $(BRCC) "-D__RTLDLLVERSTR=\"$(DLLVERSTR)\0\""
    BRCC = $(BRCC) "-D__RTLDLLNUMERICFILEVER=$(DLLNUMERICFILEVERSION)"
    BRCC = $(BRCC) "-D__RTLDLLPRODNAMESTR=\"$(DLLPRODNAMESTR)\0\""
    BRCC = $(BRCC) "-D__RTLDLLPRODVERSTR=\"$(DLLPRODVERSTR)\0\""
    BRCC = $(BRCC) "-D__RTLDLLDESCSTR=\"$(DLLDESCSTR)\0\""
    BRCC = $(BRCC) "-D__RTLDLLCOPYRIGHTSTR=\"$(DLLCOPYRIGHTSTR)\0\""
!if $d(BETA)
    BRCC = $(BRCC) "-D__RTLDLLBETASTR=\"[pre-release version: $(BETA)]\0\""
!endif
    DLLC0 = c0d$(BITS)
    DLLNAME = $(DLLBASENAME)$(DLLVER)$(MTSUFFIX)$(DLLUSERSUFFIX)
    DLLSUFFIX = x
    IMPLIBNAME = $(LIBNAME)$(MTSUFFIX)i
    IMPORT = import$(BITS)
!if $d(MAGIC)
    IMPORT = $(IMPORT)
    IMPLIBNAME_W = $(LIBNAME_W)$(MTSUFFIX)i
# Don't force in the VCL memory manager any more
#$(EXTDIR)\memmgr.lib
!endif

CFLAGS = $(CFLAGS) -D_BUILDRTLDLL -D__RTLDLLNAME=$(DLLNAME).dll

!else
!if !$d(ELF)
    CFLAGS = $(CFLAGS) -W
!endif
!endif

#############################################################################
# $(CFG) is created only once for each build.  In order to modify compiler  #
# options on a source directory basis, CC should be modified instead of     #
# CFLAGS.                                                                   #
#############################################################################
!if $d(PCH)
    CC = $(CC) -H -Hc -Hs- -H=$(OBJBASE).csm
!endif

#############################################################################
# The source directories.                                                   #
#############################################################################

#----------------------------------------------------------------------------
# Note: The following dirs must be built in this order for the RTL to work
#----------------------------------------------------------------------------

SRCDIRS =                                     \
          $(DINKSRCBASE)                      \
          $(DINKSRCTR1BASE)                   \
          $(SRCBASE)\memory                   \
          $(SRCBASE)\vcl                      \
          $(SRCBASE)\conio                    \
          $(SRCBASE)\cstrings                 \
          $(SRCBASE)\io                       \
          $(SRCBASE)\locale                   \
          $(SRCBASE)\math                     \
          $(SRCBASE)\mbcs                     \
          $(SRCBASE)\misc                     \
          $(SRCBASE)\process                  \
          $(SRCBASE)\startup                  \
          $(SRCBASE)\threads                  \
          $(SRCBASE)\time

!if !$d(WIN64)
SRCDIRS = $(SRCDIRS)                          \
          $(SRCBASE)\except                   \
          $(SRCBASE)\pcre
!else
SRCDIRS = $(SRCDIRS)                          \
	  $(SRCBASE)\libcxxabi\win64\src      \
	  $(SRCBASE)\libcxxabi\win64\seh_unwind\src
!endif

!if $d(CLANG32)
SRCDIRS = $(SRCDIRS)                          \
	  $(SRCBASE)\libcxxabi\win64\src      \
	  $(SRCBASE)\libcxxabi\win64\seh_unwind\src
!endif

!if $d(WIN64) || $d(CLANG32)
SRCDIRS = $(SRCDIRS)                          \
          $(DINKSRCC11BASE)
!endif

#!if !$d(DLL) && (!$d(MT) || $d(MAGIC))
SRCDIRS = $(SRCDIRS)                \
          $(SRCBASE)\defs
#!endif
