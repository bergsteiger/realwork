# Microsoft Developer Studio Generated NMAKE File, Based on gc_chk.dsp
!IF "$(CFG)" == ""
CFG=gc_chk - Win32 Debug
!MESSAGE No configuration specified. Defaulting to gc_chk - Win32 Debug.
!ENDIF 

!IF "$(CFG)" != "gc_chk - Win32 Release" && "$(CFG)" != "gc_chk - Win32 Debug"
!MESSAGE Invalid configuration "$(CFG)" specified.
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "gc_chk.mak" CFG="gc_chk - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "gc_chk - Win32 Release" (based on "Win32 (x86) Console Application")
!MESSAGE "gc_chk - Win32 Debug" (based on "Win32 (x86) Console Application")
!MESSAGE 
!ERROR An invalid configuration is specified.
!ENDIF 

!IF "$(OS)" == "Windows_NT"
NULL=
!ELSE 
NULL=nul
!ENDIF 

!IF  "$(CFG)" == "gc_chk - Win32 Release"

OUTDIR=.\Release
INTDIR=.\Release
# Begin Custom Macros
OutDir=.\Release
# End Custom Macros

ALL : "$(OUTDIR)\gc_chk.exe"


CLEAN :
	-@erase "$(INTDIR)\adler32.obj"
	-@erase "$(INTDIR)\advlog.obj"
	-@erase "$(INTDIR)\base.obj"
	-@erase "$(INTDIR)\basemask.obj"
	-@erase "$(INTDIR)\belongs.obj"
	-@erase "$(INTDIR)\blobtable.obj"
	-@erase "$(INTDIR)\btiter.obj"
	-@erase "$(INTDIR)\btree.obj"
	-@erase "$(INTDIR)\classes.obj"
	-@erase "$(INTDIR)\collect.obj"
	-@erase "$(INTDIR)\complect.obj"
	-@erase "$(INTDIR)\context.obj"
	-@erase "$(INTDIR)\crc32.obj"
	-@erase "$(INTDIR)\ctxwords.obj"
	-@erase "$(INTDIR)\date.Set.obj"
	-@erase "$(INTDIR)\date.SplaySet.obj"
	-@erase "$(INTDIR)\dbproc.m-writer.obj"
	-@erase "$(INTDIR)\dbproc.mf.obj"
	-@erase "$(INTDIR)\dbproc.obj"
	-@erase "$(INTDIR)\deflate.obj"
	-@erase "$(INTDIR)\doccol.obj"
	-@erase "$(INTDIR)\dociter.obj"
	-@erase "$(INTDIR)\document.obj"
	-@erase "$(INTDIR)\dummies.obj"
	-@erase "$(INTDIR)\errhandler.obj"
	-@erase "$(INTDIR)\face.obj"
	-@erase "$(INTDIR)\FString.caddr_t.Map.obj"
	-@erase "$(INTDIR)\FString.caddr_t.SplayMap.obj"
	-@erase "$(INTDIR)\FString.FString.Map.obj"
	-@erase "$(INTDIR)\FString.FString.SplayMap.obj"
	-@erase "$(INTDIR)\FString.long.Map.obj"
	-@erase "$(INTDIR)\FString.long.SplayMap.obj"
	-@erase "$(INTDIR)\fstring.obj"
	-@erase "$(INTDIR)\FString.Set.obj"
	-@erase "$(INTDIR)\FString.SplaySet.obj"
	-@erase "$(INTDIR)\fstringer.obj"
	-@erase "$(INTDIR)\garutils.obj"
	-@erase "$(INTDIR)\gcini.obj"
	-@erase "$(INTDIR)\gclog.obj"
	-@erase "$(INTDIR)\gcpass1.obj"
	-@erase "$(INTDIR)\gsscreen.obj"
	-@erase "$(INTDIR)\hidxhlp.obj"
	-@erase "$(INTDIR)\hindex.obj"
	-@erase "$(INTDIR)\hnode.obj"
	-@erase "$(INTDIR)\index.obj"
	-@erase "$(INTDIR)\indices.obj"
	-@erase "$(INTDIR)\infblock.obj"
	-@erase "$(INTDIR)\infcodes.obj"
	-@erase "$(INTDIR)\inffast.obj"
	-@erase "$(INTDIR)\inflate.obj"
	-@erase "$(INTDIR)\inftrees.obj"
	-@erase "$(INTDIR)\infutil.obj"
	-@erase "$(INTDIR)\kwfile.obj"
	-@erase "$(INTDIR)\lex_basis.obj"
	-@erase "$(INTDIR)\lex_operator.obj"
	-@erase "$(INTDIR)\lex_parser.obj"
	-@erase "$(INTDIR)\loadstringmap.obj"
	-@erase "$(INTDIR)\long.longSplaySet.Map.obj"
	-@erase "$(INTDIR)\long.longSplaySet.SplayMap.obj"
	-@erase "$(INTDIR)\long.Set.obj"
	-@erase "$(INTDIR)\long.SplaySet.obj"
	-@erase "$(INTDIR)\long.VHSet.obj"
	-@erase "$(INTDIR)\ncpf.obj"
	-@erase "$(INTDIR)\newdoc.obj"
	-@erase "$(INTDIR)\normfile.obj"
	-@erase "$(INTDIR)\nsrcheck.obj"
	-@erase "$(INTDIR)\nsrcparser.obj"
	-@erase "$(INTDIR)\osdummy.obj"
	-@erase "$(INTDIR)\pack.obj"
	-@erase "$(INTDIR)\pagefile.obj"
	-@erase "$(INTDIR)\parser.obj"
	-@erase "$(INTDIR)\publish.obj"
	-@erase "$(INTDIR)\refcol.obj"
	-@erase "$(INTDIR)\screen.obj"
	-@erase "$(INTDIR)\sources.obj"
	-@erase "$(INTDIR)\stdbase.obj"
	-@erase "$(INTDIR)\streams.obj"
	-@erase "$(INTDIR)\sttop.obj"
	-@erase "$(INTDIR)\trees.obj"
	-@erase "$(INTDIR)\u_int32_t.caddr_t.Map.obj"
	-@erase "$(INTDIR)\u_int32_t.caddr_t.SplayMap.obj"
	-@erase "$(INTDIR)\u_int32_t.FString.Map.obj"
	-@erase "$(INTDIR)\u_int32_t.FString.SplayMap.obj"
	-@erase "$(INTDIR)\u_int32_t.FString.VHMap.obj"
	-@erase "$(INTDIR)\u_int32_t.Set.obj"
	-@erase "$(INTDIR)\u_int32_t.SplaySet.obj"
	-@erase "$(INTDIR)\u_int32_t.VHSet.obj"
	-@erase "$(INTDIR)\u_int64_t.CtxLongSet.Map.obj"
	-@erase "$(INTDIR)\u_int64_t.CtxLongSet.SplayMap.obj"
	-@erase "$(INTDIR)\u_int64_t.Set.obj"
	-@erase "$(INTDIR)\u_int64_t.SplaySet.obj"
	-@erase "$(INTDIR)\u_int64_t.VHSet.obj"
	-@erase "$(INTDIR)\unzip.obj"
	-@erase "$(INTDIR)\vapi.obj"
	-@erase "$(INTDIR)\vc60.idb"
	-@erase "$(INTDIR)\zutil.obj"
	-@erase "$(OUTDIR)\gc_chk.exe"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP=cl.exe
CPP_PROJ=/nologo /Zp1 /ML /W3 /WX /Gi /GX /O2 /I "..\..\..\include" /I "..\..\..\include\win32" /I "..\..\..\libs\cchlp\src" /I "..\..\..\libs\gc\src" /I "..\..\..\libs\gkdb\src" /I "..\..\..\libs\gctx\src" /I "..\..\..\libs\gsscreen\src" /I "..\..\..\libs\lex\include" /I "..\..\..\libs\gchange\include" /I "..\..\..\tools\gctools\src" /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS" /D "OPT_PACK" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

.c{$(INTDIR)}.obj::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cpp{$(INTDIR)}.obj::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cxx{$(INTDIR)}.obj::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.c{$(INTDIR)}.sbr::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cpp{$(INTDIR)}.sbr::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cxx{$(INTDIR)}.sbr::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

RSC=rc.exe
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\gc_chk.bsc" 
BSC32_SBRS= \
	
LINK32=link.exe
LINK32_FLAGS=/nologo /stack:0xa00000,0x100000 /subsystem:console /incremental:no /pdb:"$(OUTDIR)\gc_chk.pdb" /machine:I386 /out:"$(OUTDIR)\gc_chk.exe" /fixed:no 
LINK32_OBJS= \
	"$(INTDIR)\advlog.obj" \
	"$(INTDIR)\date.Set.obj" \
	"$(INTDIR)\date.SplaySet.obj" \
	"$(INTDIR)\errhandler.obj" \
	"$(INTDIR)\FString.caddr_t.Map.obj" \
	"$(INTDIR)\FString.caddr_t.SplayMap.obj" \
	"$(INTDIR)\fstring.obj" \
	"$(INTDIR)\FString.FString.Map.obj" \
	"$(INTDIR)\FString.FString.SplayMap.obj" \
	"$(INTDIR)\FString.long.Map.obj" \
	"$(INTDIR)\FString.long.SplayMap.obj" \
	"$(INTDIR)\FString.Set.obj" \
	"$(INTDIR)\FString.SplaySet.obj" \
	"$(INTDIR)\hidxhlp.obj" \
	"$(INTDIR)\hnode.obj" \
	"$(INTDIR)\long.longSplaySet.Map.obj" \
	"$(INTDIR)\long.longSplaySet.SplayMap.obj" \
	"$(INTDIR)\long.Set.obj" \
	"$(INTDIR)\long.SplaySet.obj" \
	"$(INTDIR)\long.VHSet.obj" \
	"$(INTDIR)\u_int32_t.caddr_t.Map.obj" \
	"$(INTDIR)\u_int32_t.caddr_t.SplayMap.obj" \
	"$(INTDIR)\u_int32_t.FString.Map.obj" \
	"$(INTDIR)\u_int32_t.FString.SplayMap.obj" \
	"$(INTDIR)\u_int32_t.FString.VHMap.obj" \
	"$(INTDIR)\u_int32_t.Set.obj" \
	"$(INTDIR)\u_int32_t.SplaySet.obj" \
	"$(INTDIR)\u_int32_t.VHSet.obj" \
	"$(INTDIR)\u_int64_t.Set.obj" \
	"$(INTDIR)\u_int64_t.SplaySet.obj" \
	"$(INTDIR)\u_int64_t.VHSet.obj" \
	"$(INTDIR)\dbproc.obj" \
	"$(INTDIR)\dbproc.mf.obj" \
	"$(INTDIR)\gclog.obj" \
	"$(INTDIR)\adler32.obj" \
	"$(INTDIR)\base.obj" \
	"$(INTDIR)\basemask.obj" \
	"$(INTDIR)\btiter.obj" \
	"$(INTDIR)\btree.obj" \
	"$(INTDIR)\collect.obj" \
	"$(INTDIR)\crc32.obj" \
	"$(INTDIR)\deflate.obj" \
	"$(INTDIR)\doccol.obj" \
	"$(INTDIR)\dociter.obj" \
	"$(INTDIR)\document.obj" \
	"$(INTDIR)\dummies.obj" \
	"$(INTDIR)\garutils.obj" \
	"$(INTDIR)\hindex.obj" \
	"$(INTDIR)\index.obj" \
	"$(INTDIR)\indices.obj" \
	"$(INTDIR)\infblock.obj" \
	"$(INTDIR)\infcodes.obj" \
	"$(INTDIR)\inffast.obj" \
	"$(INTDIR)\inflate.obj" \
	"$(INTDIR)\inftrees.obj" \
	"$(INTDIR)\infutil.obj" \
	"$(INTDIR)\ncpf.obj" \
	"$(INTDIR)\newdoc.obj" \
	"$(INTDIR)\osdummy.obj" \
	"$(INTDIR)\pack.obj" \
	"$(INTDIR)\pagefile.obj" \
	"$(INTDIR)\refcol.obj" \
	"$(INTDIR)\stdbase.obj" \
	"$(INTDIR)\streams.obj" \
	"$(INTDIR)\trees.obj" \
	"$(INTDIR)\unzip.obj" \
	"$(INTDIR)\zutil.obj" \
	"$(INTDIR)\vapi.obj" \
	"$(INTDIR)\ctxwords.obj" \
	"$(INTDIR)\u_int64_t.CtxLongSet.Map.obj" \
	"$(INTDIR)\u_int64_t.CtxLongSet.SplayMap.obj" \
	"$(INTDIR)\face.obj" \
	"$(INTDIR)\gsscreen.obj" \
	"$(INTDIR)\screen.obj" \
	"$(INTDIR)\context.obj" \
	"$(INTDIR)\parser.obj" \
	"$(INTDIR)\lex_basis.obj" \
	"$(INTDIR)\lex_operator.obj" \
	"$(INTDIR)\lex_parser.obj" \
	"$(INTDIR)\belongs.obj" \
	"$(INTDIR)\blobtable.obj" \
	"$(INTDIR)\classes.obj" \
	"$(INTDIR)\complect.obj" \
	"$(INTDIR)\dbproc.m-writer.obj" \
	"$(INTDIR)\fstringer.obj" \
	"$(INTDIR)\gcini.obj" \
	"$(INTDIR)\gcpass1.obj" \
	"$(INTDIR)\kwfile.obj" \
	"$(INTDIR)\loadstringmap.obj" \
	"$(INTDIR)\normfile.obj" \
	"$(INTDIR)\nsrcheck.obj" \
	"$(INTDIR)\nsrcparser.obj" \
	"$(INTDIR)\publish.obj" \
	"$(INTDIR)\sources.obj" \
	"$(INTDIR)\sttop.obj"

"$(OUTDIR)\gc_chk.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ELSEIF  "$(CFG)" == "gc_chk - Win32 Debug"

OUTDIR=.\Debug
INTDIR=.\Debug
# Begin Custom Macros
OutDir=.\Debug
# End Custom Macros

ALL : "$(OUTDIR)\gc_chk.exe"


CLEAN :
	-@erase "$(INTDIR)\adler32.obj"
	-@erase "$(INTDIR)\advlog.obj"
	-@erase "$(INTDIR)\base.obj"
	-@erase "$(INTDIR)\basemask.obj"
	-@erase "$(INTDIR)\belongs.obj"
	-@erase "$(INTDIR)\blobtable.obj"
	-@erase "$(INTDIR)\btiter.obj"
	-@erase "$(INTDIR)\btree.obj"
	-@erase "$(INTDIR)\classes.obj"
	-@erase "$(INTDIR)\collect.obj"
	-@erase "$(INTDIR)\complect.obj"
	-@erase "$(INTDIR)\context.obj"
	-@erase "$(INTDIR)\crc32.obj"
	-@erase "$(INTDIR)\ctxwords.obj"
	-@erase "$(INTDIR)\date.Set.obj"
	-@erase "$(INTDIR)\date.SplaySet.obj"
	-@erase "$(INTDIR)\dbproc.m-writer.obj"
	-@erase "$(INTDIR)\dbproc.mf.obj"
	-@erase "$(INTDIR)\dbproc.obj"
	-@erase "$(INTDIR)\deflate.obj"
	-@erase "$(INTDIR)\doccol.obj"
	-@erase "$(INTDIR)\dociter.obj"
	-@erase "$(INTDIR)\document.obj"
	-@erase "$(INTDIR)\dummies.obj"
	-@erase "$(INTDIR)\errhandler.obj"
	-@erase "$(INTDIR)\face.obj"
	-@erase "$(INTDIR)\FString.caddr_t.Map.obj"
	-@erase "$(INTDIR)\FString.caddr_t.SplayMap.obj"
	-@erase "$(INTDIR)\FString.FString.Map.obj"
	-@erase "$(INTDIR)\FString.FString.SplayMap.obj"
	-@erase "$(INTDIR)\FString.long.Map.obj"
	-@erase "$(INTDIR)\FString.long.SplayMap.obj"
	-@erase "$(INTDIR)\fstring.obj"
	-@erase "$(INTDIR)\FString.Set.obj"
	-@erase "$(INTDIR)\FString.SplaySet.obj"
	-@erase "$(INTDIR)\fstringer.obj"
	-@erase "$(INTDIR)\garutils.obj"
	-@erase "$(INTDIR)\gcini.obj"
	-@erase "$(INTDIR)\gclog.obj"
	-@erase "$(INTDIR)\gcpass1.obj"
	-@erase "$(INTDIR)\gsscreen.obj"
	-@erase "$(INTDIR)\hidxhlp.obj"
	-@erase "$(INTDIR)\hindex.obj"
	-@erase "$(INTDIR)\hnode.obj"
	-@erase "$(INTDIR)\index.obj"
	-@erase "$(INTDIR)\indices.obj"
	-@erase "$(INTDIR)\infblock.obj"
	-@erase "$(INTDIR)\infcodes.obj"
	-@erase "$(INTDIR)\inffast.obj"
	-@erase "$(INTDIR)\inflate.obj"
	-@erase "$(INTDIR)\inftrees.obj"
	-@erase "$(INTDIR)\infutil.obj"
	-@erase "$(INTDIR)\kwfile.obj"
	-@erase "$(INTDIR)\lex_basis.obj"
	-@erase "$(INTDIR)\lex_operator.obj"
	-@erase "$(INTDIR)\lex_parser.obj"
	-@erase "$(INTDIR)\loadstringmap.obj"
	-@erase "$(INTDIR)\long.longSplaySet.Map.obj"
	-@erase "$(INTDIR)\long.longSplaySet.SplayMap.obj"
	-@erase "$(INTDIR)\long.Set.obj"
	-@erase "$(INTDIR)\long.SplaySet.obj"
	-@erase "$(INTDIR)\long.VHSet.obj"
	-@erase "$(INTDIR)\ncpf.obj"
	-@erase "$(INTDIR)\newdoc.obj"
	-@erase "$(INTDIR)\normfile.obj"
	-@erase "$(INTDIR)\nsrcheck.obj"
	-@erase "$(INTDIR)\nsrcparser.obj"
	-@erase "$(INTDIR)\osdummy.obj"
	-@erase "$(INTDIR)\pack.obj"
	-@erase "$(INTDIR)\pagefile.obj"
	-@erase "$(INTDIR)\parser.obj"
	-@erase "$(INTDIR)\publish.obj"
	-@erase "$(INTDIR)\refcol.obj"
	-@erase "$(INTDIR)\screen.obj"
	-@erase "$(INTDIR)\sources.obj"
	-@erase "$(INTDIR)\stdbase.obj"
	-@erase "$(INTDIR)\streams.obj"
	-@erase "$(INTDIR)\sttop.obj"
	-@erase "$(INTDIR)\trees.obj"
	-@erase "$(INTDIR)\u_int32_t.caddr_t.Map.obj"
	-@erase "$(INTDIR)\u_int32_t.caddr_t.SplayMap.obj"
	-@erase "$(INTDIR)\u_int32_t.FString.Map.obj"
	-@erase "$(INTDIR)\u_int32_t.FString.SplayMap.obj"
	-@erase "$(INTDIR)\u_int32_t.FString.VHMap.obj"
	-@erase "$(INTDIR)\u_int32_t.Set.obj"
	-@erase "$(INTDIR)\u_int32_t.SplaySet.obj"
	-@erase "$(INTDIR)\u_int32_t.VHSet.obj"
	-@erase "$(INTDIR)\u_int64_t.CtxLongSet.Map.obj"
	-@erase "$(INTDIR)\u_int64_t.CtxLongSet.SplayMap.obj"
	-@erase "$(INTDIR)\u_int64_t.Set.obj"
	-@erase "$(INTDIR)\u_int64_t.SplaySet.obj"
	-@erase "$(INTDIR)\u_int64_t.VHSet.obj"
	-@erase "$(INTDIR)\unzip.obj"
	-@erase "$(INTDIR)\vapi.obj"
	-@erase "$(INTDIR)\vc60.idb"
	-@erase "$(INTDIR)\vc60.pdb"
	-@erase "$(INTDIR)\zutil.obj"
	-@erase "$(OUTDIR)\gc_chk.exe"
	-@erase "$(OUTDIR)\gc_chk.pdb"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP=cl.exe
CPP_PROJ=/nologo /G6 /Zp1 /MLd /W3 /Gi /GX /Zi /Od /I "..\..\..\include" /I "..\..\..\include\win32" /I "..\..\..\libs\cchlp\src" /I "..\..\..\libs\gc\src" /I "..\..\..\libs\gkdb\src" /I "..\..\..\libs\gctx\src" /I "..\..\..\libs\gsscreen\src" /I "..\..\..\libs\lex\include" /I "..\..\..\libs\gchange\include" /I "..\..\..\tools\gctools\src" /D "WIN32" /D "_DEBUG" /D "_CONSOLE" /D "_MBCS" /D "OPT_PACK" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

.c{$(INTDIR)}.obj::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cpp{$(INTDIR)}.obj::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cxx{$(INTDIR)}.obj::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.c{$(INTDIR)}.sbr::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cpp{$(INTDIR)}.sbr::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cxx{$(INTDIR)}.sbr::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

RSC=rc.exe
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\gc_chk.bsc" 
BSC32_SBRS= \
	
LINK32=link.exe
LINK32_FLAGS=/nologo /stack:0xa00000,0x100000 /subsystem:console /incremental:no /pdb:"$(OUTDIR)\gc_chk.pdb" /debug /machine:I386 /out:"$(OUTDIR)\gc_chk.exe" /pdbtype:sept /FORCE:MULTIPLE /fixed:no 
LINK32_OBJS= \
	"$(INTDIR)\advlog.obj" \
	"$(INTDIR)\date.Set.obj" \
	"$(INTDIR)\date.SplaySet.obj" \
	"$(INTDIR)\errhandler.obj" \
	"$(INTDIR)\FString.caddr_t.Map.obj" \
	"$(INTDIR)\FString.caddr_t.SplayMap.obj" \
	"$(INTDIR)\fstring.obj" \
	"$(INTDIR)\FString.FString.Map.obj" \
	"$(INTDIR)\FString.FString.SplayMap.obj" \
	"$(INTDIR)\FString.long.Map.obj" \
	"$(INTDIR)\FString.long.SplayMap.obj" \
	"$(INTDIR)\FString.Set.obj" \
	"$(INTDIR)\FString.SplaySet.obj" \
	"$(INTDIR)\hidxhlp.obj" \
	"$(INTDIR)\hnode.obj" \
	"$(INTDIR)\long.longSplaySet.Map.obj" \
	"$(INTDIR)\long.longSplaySet.SplayMap.obj" \
	"$(INTDIR)\long.Set.obj" \
	"$(INTDIR)\long.SplaySet.obj" \
	"$(INTDIR)\long.VHSet.obj" \
	"$(INTDIR)\u_int32_t.caddr_t.Map.obj" \
	"$(INTDIR)\u_int32_t.caddr_t.SplayMap.obj" \
	"$(INTDIR)\u_int32_t.FString.Map.obj" \
	"$(INTDIR)\u_int32_t.FString.SplayMap.obj" \
	"$(INTDIR)\u_int32_t.FString.VHMap.obj" \
	"$(INTDIR)\u_int32_t.Set.obj" \
	"$(INTDIR)\u_int32_t.SplaySet.obj" \
	"$(INTDIR)\u_int32_t.VHSet.obj" \
	"$(INTDIR)\u_int64_t.Set.obj" \
	"$(INTDIR)\u_int64_t.SplaySet.obj" \
	"$(INTDIR)\u_int64_t.VHSet.obj" \
	"$(INTDIR)\dbproc.obj" \
	"$(INTDIR)\dbproc.mf.obj" \
	"$(INTDIR)\gclog.obj" \
	"$(INTDIR)\adler32.obj" \
	"$(INTDIR)\base.obj" \
	"$(INTDIR)\basemask.obj" \
	"$(INTDIR)\btiter.obj" \
	"$(INTDIR)\btree.obj" \
	"$(INTDIR)\collect.obj" \
	"$(INTDIR)\crc32.obj" \
	"$(INTDIR)\deflate.obj" \
	"$(INTDIR)\doccol.obj" \
	"$(INTDIR)\dociter.obj" \
	"$(INTDIR)\document.obj" \
	"$(INTDIR)\dummies.obj" \
	"$(INTDIR)\garutils.obj" \
	"$(INTDIR)\hindex.obj" \
	"$(INTDIR)\index.obj" \
	"$(INTDIR)\indices.obj" \
	"$(INTDIR)\infblock.obj" \
	"$(INTDIR)\infcodes.obj" \
	"$(INTDIR)\inffast.obj" \
	"$(INTDIR)\inflate.obj" \
	"$(INTDIR)\inftrees.obj" \
	"$(INTDIR)\infutil.obj" \
	"$(INTDIR)\ncpf.obj" \
	"$(INTDIR)\newdoc.obj" \
	"$(INTDIR)\osdummy.obj" \
	"$(INTDIR)\pack.obj" \
	"$(INTDIR)\pagefile.obj" \
	"$(INTDIR)\refcol.obj" \
	"$(INTDIR)\stdbase.obj" \
	"$(INTDIR)\streams.obj" \
	"$(INTDIR)\trees.obj" \
	"$(INTDIR)\unzip.obj" \
	"$(INTDIR)\zutil.obj" \
	"$(INTDIR)\vapi.obj" \
	"$(INTDIR)\ctxwords.obj" \
	"$(INTDIR)\u_int64_t.CtxLongSet.Map.obj" \
	"$(INTDIR)\u_int64_t.CtxLongSet.SplayMap.obj" \
	"$(INTDIR)\face.obj" \
	"$(INTDIR)\gsscreen.obj" \
	"$(INTDIR)\screen.obj" \
	"$(INTDIR)\context.obj" \
	"$(INTDIR)\parser.obj" \
	"$(INTDIR)\lex_basis.obj" \
	"$(INTDIR)\lex_operator.obj" \
	"$(INTDIR)\lex_parser.obj" \
	"$(INTDIR)\belongs.obj" \
	"$(INTDIR)\blobtable.obj" \
	"$(INTDIR)\classes.obj" \
	"$(INTDIR)\complect.obj" \
	"$(INTDIR)\dbproc.m-writer.obj" \
	"$(INTDIR)\fstringer.obj" \
	"$(INTDIR)\gcini.obj" \
	"$(INTDIR)\gcpass1.obj" \
	"$(INTDIR)\kwfile.obj" \
	"$(INTDIR)\loadstringmap.obj" \
	"$(INTDIR)\normfile.obj" \
	"$(INTDIR)\nsrcheck.obj" \
	"$(INTDIR)\nsrcparser.obj" \
	"$(INTDIR)\publish.obj" \
	"$(INTDIR)\sources.obj" \
	"$(INTDIR)\sttop.obj"

"$(OUTDIR)\gc_chk.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ENDIF 


!IF "$(NO_EXTERNAL_DEPS)" != "1"
!IF EXISTS("gc_chk.dep")
!INCLUDE "gc_chk.dep"
!ELSE 
!MESSAGE Warning: cannot find "gc_chk.dep"
!ENDIF 
!ENDIF 


!IF "$(CFG)" == "gc_chk - Win32 Release" || "$(CFG)" == "gc_chk - Win32 Debug"
SOURCE=..\..\..\libs\cchlp\src\advlog.cpp

"$(INTDIR)\advlog.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\cchlp\src\date.Set.cpp

"$(INTDIR)\date.Set.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\cchlp\src\date.SplaySet.cpp

"$(INTDIR)\date.SplaySet.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\cchlp\src\errhandler.cpp

"$(INTDIR)\errhandler.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\cchlp\src\FString.caddr_t.Map.cpp

"$(INTDIR)\FString.caddr_t.Map.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\cchlp\src\FString.caddr_t.SplayMap.cpp

"$(INTDIR)\FString.caddr_t.SplayMap.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\cchlp\src\fstring.cpp

"$(INTDIR)\fstring.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\cchlp\src\FString.FString.Map.cpp

"$(INTDIR)\FString.FString.Map.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\cchlp\src\FString.FString.SplayMap.cpp

"$(INTDIR)\FString.FString.SplayMap.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\cchlp\src\FString.long.Map.cpp

"$(INTDIR)\FString.long.Map.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\cchlp\src\FString.long.SplayMap.cpp

"$(INTDIR)\FString.long.SplayMap.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\cchlp\src\FString.Set.cpp

"$(INTDIR)\FString.Set.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\cchlp\src\FString.SplaySet.cpp

"$(INTDIR)\FString.SplaySet.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\cchlp\src\hidxhlp.cpp

"$(INTDIR)\hidxhlp.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\cchlp\src\hnode.cpp

"$(INTDIR)\hnode.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\cchlp\src\long.longSplaySet.Map.cpp

"$(INTDIR)\long.longSplaySet.Map.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\cchlp\src\long.longSplaySet.SplayMap.cpp

"$(INTDIR)\long.longSplaySet.SplayMap.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\cchlp\src\long.Set.cpp

"$(INTDIR)\long.Set.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\cchlp\src\long.SplaySet.cpp

"$(INTDIR)\long.SplaySet.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\cchlp\src\long.VHSet.cpp

"$(INTDIR)\long.VHSet.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\cchlp\src\u_int32_t.caddr_t.Map.cpp

"$(INTDIR)\u_int32_t.caddr_t.Map.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\cchlp\src\u_int32_t.caddr_t.SplayMap.cpp

"$(INTDIR)\u_int32_t.caddr_t.SplayMap.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\cchlp\src\u_int32_t.FString.Map.cpp

"$(INTDIR)\u_int32_t.FString.Map.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\cchlp\src\u_int32_t.FString.SplayMap.cpp

"$(INTDIR)\u_int32_t.FString.SplayMap.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\cchlp\src\u_int32_t.FString.VHMap.cpp

"$(INTDIR)\u_int32_t.FString.VHMap.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\cchlp\src\u_int32_t.Set.cpp

"$(INTDIR)\u_int32_t.Set.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\cchlp\src\u_int32_t.SplaySet.cpp

"$(INTDIR)\u_int32_t.SplaySet.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\cchlp\src\u_int32_t.VHSet.cpp

"$(INTDIR)\u_int32_t.VHSet.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\cchlp\src\u_int64_t.Set.cpp

"$(INTDIR)\u_int64_t.Set.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\cchlp\src\u_int64_t.SplaySet.cpp

"$(INTDIR)\u_int64_t.SplaySet.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\cchlp\src\u_int64_t.VHSet.cpp

"$(INTDIR)\u_int64_t.VHSet.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gc\src\dbproc.cpp

"$(INTDIR)\dbproc.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gc\src\dbproc.mf.cpp

"$(INTDIR)\dbproc.mf.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gc\src\gclog.cpp

"$(INTDIR)\gclog.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gkdb\src\adler32.c

"$(INTDIR)\adler32.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gkdb\src\base.cpp

"$(INTDIR)\base.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gkdb\src\basemask.cpp

"$(INTDIR)\basemask.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gkdb\src\btiter.cpp

"$(INTDIR)\btiter.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gkdb\src\btree.cpp

"$(INTDIR)\btree.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gkdb\src\collect.cpp

"$(INTDIR)\collect.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gkdb\src\crc32.c

"$(INTDIR)\crc32.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gkdb\src\deflate.c

"$(INTDIR)\deflate.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gkdb\src\doccol.cpp

"$(INTDIR)\doccol.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gkdb\src\dociter.cpp

"$(INTDIR)\dociter.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gkdb\src\document.cpp

"$(INTDIR)\document.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gkdb\src\dummies.cpp

"$(INTDIR)\dummies.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gkdb\src\garutils.cpp

"$(INTDIR)\garutils.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gkdb\src\hindex.cpp

"$(INTDIR)\hindex.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gkdb\src\index.cpp

"$(INTDIR)\index.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gkdb\src\indices.cpp

"$(INTDIR)\indices.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gkdb\src\infblock.c

"$(INTDIR)\infblock.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gkdb\src\infcodes.c

"$(INTDIR)\infcodes.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gkdb\src\inffast.c

"$(INTDIR)\inffast.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gkdb\src\inflate.c

"$(INTDIR)\inflate.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gkdb\src\inftrees.c

"$(INTDIR)\inftrees.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gkdb\src\infutil.c

"$(INTDIR)\infutil.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gkdb\src\ncpf.cpp

"$(INTDIR)\ncpf.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gkdb\src\newdoc.cpp

"$(INTDIR)\newdoc.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gkdb\src\osdummy.c

"$(INTDIR)\osdummy.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gkdb\src\pack.c

"$(INTDIR)\pack.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gkdb\src\pagefile.cpp

"$(INTDIR)\pagefile.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gkdb\src\refcol.cpp

"$(INTDIR)\refcol.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gkdb\src\stdbase.cpp

"$(INTDIR)\stdbase.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gkdb\src\streams.cpp

"$(INTDIR)\streams.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gkdb\src\trees.c

"$(INTDIR)\trees.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gkdb\src\unzip.c

"$(INTDIR)\unzip.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gkdb\src\zutil.c

"$(INTDIR)\zutil.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\VControl\src\vapi.c

"$(INTDIR)\vapi.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gctx\src\ctxwords.cpp

"$(INTDIR)\ctxwords.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gctx\src\u_int64_t.CtxLongSet.Map.cpp

"$(INTDIR)\u_int64_t.CtxLongSet.Map.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gctx\src\u_int64_t.CtxLongSet.SplayMap.cpp

"$(INTDIR)\u_int64_t.CtxLongSet.SplayMap.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gsscreen\src\face.c

"$(INTDIR)\face.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gsscreen\src\gsscreen.cpp

"$(INTDIR)\gsscreen.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gsscreen\src\screen.c

"$(INTDIR)\screen.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gchange\src\context.cpp

"$(INTDIR)\context.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gchange\src\parser.cpp

"$(INTDIR)\parser.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\lex\src\lex_basis.cpp

"$(INTDIR)\lex_basis.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\lex\src\lex_operator.cpp

"$(INTDIR)\lex_operator.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\lex\src\lex_parser.cpp

"$(INTDIR)\lex_parser.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\src\belongs.cpp

"$(INTDIR)\belongs.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\src\blobtable.cpp

"$(INTDIR)\blobtable.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\src\classes.cpp

"$(INTDIR)\classes.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\src\complect.cpp

"$(INTDIR)\complect.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE="..\src\dbproc.m-writer.cpp"

"$(INTDIR)\dbproc.m-writer.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\src\fstringer.cpp

"$(INTDIR)\fstringer.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\src\gcini.cpp

"$(INTDIR)\gcini.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\src\gcpass1.cpp

"$(INTDIR)\gcpass1.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\src\kwfile.cpp

"$(INTDIR)\kwfile.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\src\loadstringmap.cpp

"$(INTDIR)\loadstringmap.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\src\normfile.cpp

"$(INTDIR)\normfile.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\src\nsrcheck.cpp

"$(INTDIR)\nsrcheck.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\src\nsrcparser.cpp

"$(INTDIR)\nsrcparser.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\src\publish.cpp

"$(INTDIR)\publish.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\src\sources.cpp

"$(INTDIR)\sources.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\src\sttop.cpp

"$(INTDIR)\sttop.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)



!ENDIF 

