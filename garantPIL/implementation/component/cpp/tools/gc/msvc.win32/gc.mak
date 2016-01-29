# Microsoft Developer Studio Generated NMAKE File, Based on gc.dsp
!IF "$(CFG)" == ""
CFG=gc - Win32 DebugP
!MESSAGE No configuration specified. Defaulting to gc - Win32 DebugP.
!ENDIF 

!IF "$(CFG)" != "gc - Win32 Release" && "$(CFG)" != "gc - Win32 Debug" && "$(CFG)" != "gc - Win32 Debug_Old" && "$(CFG)" != "gc - Win32 Release_Old" && "$(CFG)" != "gc - Win32 DebugP" && "$(CFG)" != "gc - Win32 ReleaseP"
!MESSAGE Invalid configuration "$(CFG)" specified.
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "gc.mak" CFG="gc - Win32 DebugP"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "gc - Win32 Release" (based on "Win32 (x86) Console Application")
!MESSAGE "gc - Win32 Debug" (based on "Win32 (x86) Console Application")
!MESSAGE "gc - Win32 Debug_Old" (based on "Win32 (x86) Console Application")
!MESSAGE "gc - Win32 Release_Old" (based on "Win32 (x86) Console Application")
!MESSAGE "gc - Win32 DebugP" (based on "Win32 (x86) Console Application")
!MESSAGE "gc - Win32 ReleaseP" (based on "Win32 (x86) Console Application")
!MESSAGE 
!ERROR An invalid configuration is specified.
!ENDIF 

!IF "$(OS)" == "Windows_NT"
NULL=
!ELSE 
NULL=nul
!ENDIF 

!IF  "$(CFG)" == "gc - Win32 Release"

OUTDIR=.\Release
INTDIR=.\Release
# Begin Custom Macros
OutDir=.\Release
# End Custom Macros

ALL : "$(OUTDIR)\gc.exe"


CLEAN :
	-@erase "$(INTDIR)\adler32.obj"
	-@erase "$(INTDIR)\advlog.obj"
	-@erase "$(INTDIR)\base.obj"
	-@erase "$(INTDIR)\basemask.obj"
	-@erase "$(INTDIR)\belongs.obj"
	-@erase "$(INTDIR)\blobtable.obj"
	-@erase "$(INTDIR)\btiter.obj"
	-@erase "$(INTDIR)\btree.obj"
	-@erase "$(INTDIR)\cacheIndex.obj"
	-@erase "$(INTDIR)\classes.obj"
	-@erase "$(INTDIR)\collect.obj"
	-@erase "$(INTDIR)\complect.obj"
	-@erase "$(INTDIR)\context.obj"
	-@erase "$(INTDIR)\crc32.obj"
	-@erase "$(INTDIR)\ctxwords.obj"
	-@erase "$(INTDIR)\date.set.obj"
	-@erase "$(INTDIR)\date.splayset.obj"
	-@erase "$(INTDIR)\dbproc.m-reader.obj"
	-@erase "$(INTDIR)\dbproc.m-to-gkdb.obj"
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
	-@erase "$(INTDIR)\fstring.caddr_t.map.obj"
	-@erase "$(INTDIR)\fstring.caddr_t.splaymap.obj"
	-@erase "$(INTDIR)\fstring.fstring.map.obj"
	-@erase "$(INTDIR)\fstring.fstring.splaymap.obj"
	-@erase "$(INTDIR)\fstring.long.map.obj"
	-@erase "$(INTDIR)\fstring.long.splaymap.obj"
	-@erase "$(INTDIR)\fstring.obj"
	-@erase "$(INTDIR)\fstring.set.obj"
	-@erase "$(INTDIR)\fstring.splayset.obj"
	-@erase "$(INTDIR)\fstringer.obj"
	-@erase "$(INTDIR)\garcomp.obj"
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
	-@erase "$(INTDIR)\long.longsplayset.map.obj"
	-@erase "$(INTDIR)\long.longsplayset.splaymap.obj"
	-@erase "$(INTDIR)\long.set.obj"
	-@erase "$(INTDIR)\long.splayset.obj"
	-@erase "$(INTDIR)\long.vhset.obj"
	-@erase "$(INTDIR)\MyPipe.obj"
	-@erase "$(INTDIR)\ncpf.obj"
	-@erase "$(INTDIR)\newdoc.obj"
	-@erase "$(INTDIR)\normfile.obj"
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
	-@erase "$(INTDIR)\u_int32_t.caddr_t.map.obj"
	-@erase "$(INTDIR)\u_int32_t.caddr_t.splaymap.obj"
	-@erase "$(INTDIR)\u_int32_t.fstring.map.obj"
	-@erase "$(INTDIR)\u_int32_t.fstring.splaymap.obj"
	-@erase "$(INTDIR)\u_int32_t.fstring.vhmap.obj"
	-@erase "$(INTDIR)\u_int32_t.set.obj"
	-@erase "$(INTDIR)\u_int32_t.splayset.obj"
	-@erase "$(INTDIR)\u_int32_t.vhset.obj"
	-@erase "$(INTDIR)\u_int64_t.CtxLongSet.Map.obj"
	-@erase "$(INTDIR)\u_int64_t.CtxLongSet.SplayMap.obj"
	-@erase "$(INTDIR)\u_int64_t.set.obj"
	-@erase "$(INTDIR)\u_int64_t.splayset.obj"
	-@erase "$(INTDIR)\u_int64_t.vhset.obj"
	-@erase "$(INTDIR)\unzip.obj"
	-@erase "$(INTDIR)\vapi.obj"
	-@erase "$(INTDIR)\vc60.idb"
	-@erase "$(INTDIR)\zutil.obj"
	-@erase "$(OUTDIR)\gc.exe"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP=cl.exe
CPP_PROJ=/nologo /Zp1 /MT /W3 /Gi /GX /O2 /I "..\..\..\include" /I "..\..\..\include\win32" /I "..\..\..\libs\cchlp\src" /I "..\..\..\libs\gc\src" /I "..\..\..\libs\gkdb\src" /I "..\..\..\libs\gctx\src" /I "..\..\..\libs\gsscreen\src" /I "..\..\..\libs\lex\include" /I "..\..\..\libs\gchange\include" /I "..\..\..\tools\gctools\src" /D "NDEBUG" /D "WIN32" /D "_CONSOLE" /D "_MBCS" /D "WITH_DBL_THREAD" /D "OPT_PACK" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

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
BSC32_FLAGS=/nologo /o"$(OUTDIR)\gc.bsc" 
BSC32_SBRS= \
	
LINK32=link.exe
LINK32_FLAGS=/nologo /stack:0x2000000,0x2000000 /subsystem:console /incremental:no /pdb:"$(OUTDIR)\gc.pdb" /machine:I386 /out:"$(OUTDIR)\gc.exe" /FORCE:MULTIPLE /fixed:no 
LINK32_OBJS= \
	"$(INTDIR)\advlog.obj" \
	"$(INTDIR)\date.set.obj" \
	"$(INTDIR)\date.splayset.obj" \
	"$(INTDIR)\errhandler.obj" \
	"$(INTDIR)\fstring.caddr_t.map.obj" \
	"$(INTDIR)\fstring.caddr_t.splaymap.obj" \
	"$(INTDIR)\fstring.obj" \
	"$(INTDIR)\fstring.fstring.map.obj" \
	"$(INTDIR)\fstring.fstring.splaymap.obj" \
	"$(INTDIR)\fstring.long.map.obj" \
	"$(INTDIR)\fstring.long.splaymap.obj" \
	"$(INTDIR)\fstring.set.obj" \
	"$(INTDIR)\fstring.splayset.obj" \
	"$(INTDIR)\hidxhlp.obj" \
	"$(INTDIR)\hnode.obj" \
	"$(INTDIR)\long.longsplayset.map.obj" \
	"$(INTDIR)\long.longsplayset.splaymap.obj" \
	"$(INTDIR)\long.set.obj" \
	"$(INTDIR)\long.splayset.obj" \
	"$(INTDIR)\long.vhset.obj" \
	"$(INTDIR)\u_int32_t.caddr_t.map.obj" \
	"$(INTDIR)\u_int32_t.caddr_t.splaymap.obj" \
	"$(INTDIR)\u_int32_t.fstring.map.obj" \
	"$(INTDIR)\u_int32_t.fstring.splaymap.obj" \
	"$(INTDIR)\u_int32_t.fstring.vhmap.obj" \
	"$(INTDIR)\u_int32_t.set.obj" \
	"$(INTDIR)\u_int32_t.splayset.obj" \
	"$(INTDIR)\u_int32_t.vhset.obj" \
	"$(INTDIR)\u_int64_t.set.obj" \
	"$(INTDIR)\u_int64_t.splayset.obj" \
	"$(INTDIR)\u_int64_t.vhset.obj" \
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
	"$(INTDIR)\cacheIndex.obj" \
	"$(INTDIR)\classes.obj" \
	"$(INTDIR)\complect.obj" \
	"$(INTDIR)\dbproc.m-reader.obj" \
	"$(INTDIR)\dbproc.m-to-gkdb.obj" \
	"$(INTDIR)\dbproc.m-writer.obj" \
	"$(INTDIR)\fstringer.obj" \
	"$(INTDIR)\garcomp.obj" \
	"$(INTDIR)\gcini.obj" \
	"$(INTDIR)\gcpass1.obj" \
	"$(INTDIR)\kwfile.obj" \
	"$(INTDIR)\loadstringmap.obj" \
	"$(INTDIR)\MyPipe.obj" \
	"$(INTDIR)\normfile.obj" \
	"$(INTDIR)\nsrcparser.obj" \
	"$(INTDIR)\publish.obj" \
	"$(INTDIR)\sources.obj" \
	"$(INTDIR)\sttop.obj"

"$(OUTDIR)\gc.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ELSEIF  "$(CFG)" == "gc - Win32 Debug"

OUTDIR=.\Debug_GC
INTDIR=.\Debug_GC
# Begin Custom Macros
OutDir=.\Debug_GC
# End Custom Macros

ALL : "$(OUTDIR)\gc.exe" "$(OUTDIR)\gc.bsc"


CLEAN :
	-@erase "$(INTDIR)\adler32.obj"
	-@erase "$(INTDIR)\adler32.sbr"
	-@erase "$(INTDIR)\advlog.obj"
	-@erase "$(INTDIR)\advlog.sbr"
	-@erase "$(INTDIR)\base.obj"
	-@erase "$(INTDIR)\base.sbr"
	-@erase "$(INTDIR)\basemask.obj"
	-@erase "$(INTDIR)\basemask.sbr"
	-@erase "$(INTDIR)\belongs.obj"
	-@erase "$(INTDIR)\belongs.sbr"
	-@erase "$(INTDIR)\blobtable.obj"
	-@erase "$(INTDIR)\blobtable.sbr"
	-@erase "$(INTDIR)\btiter.obj"
	-@erase "$(INTDIR)\btiter.sbr"
	-@erase "$(INTDIR)\btree.obj"
	-@erase "$(INTDIR)\btree.sbr"
	-@erase "$(INTDIR)\cacheIndex.obj"
	-@erase "$(INTDIR)\cacheIndex.sbr"
	-@erase "$(INTDIR)\classes.obj"
	-@erase "$(INTDIR)\classes.sbr"
	-@erase "$(INTDIR)\collect.obj"
	-@erase "$(INTDIR)\collect.sbr"
	-@erase "$(INTDIR)\complect.obj"
	-@erase "$(INTDIR)\complect.sbr"
	-@erase "$(INTDIR)\context.obj"
	-@erase "$(INTDIR)\context.sbr"
	-@erase "$(INTDIR)\crc32.obj"
	-@erase "$(INTDIR)\crc32.sbr"
	-@erase "$(INTDIR)\ctxwords.obj"
	-@erase "$(INTDIR)\ctxwords.sbr"
	-@erase "$(INTDIR)\date.set.obj"
	-@erase "$(INTDIR)\date.set.sbr"
	-@erase "$(INTDIR)\date.splayset.obj"
	-@erase "$(INTDIR)\date.splayset.sbr"
	-@erase "$(INTDIR)\dbproc.m-reader.obj"
	-@erase "$(INTDIR)\dbproc.m-reader.sbr"
	-@erase "$(INTDIR)\dbproc.m-to-gkdb.obj"
	-@erase "$(INTDIR)\dbproc.m-to-gkdb.sbr"
	-@erase "$(INTDIR)\dbproc.m-writer.obj"
	-@erase "$(INTDIR)\dbproc.m-writer.sbr"
	-@erase "$(INTDIR)\dbproc.mf.obj"
	-@erase "$(INTDIR)\dbproc.mf.sbr"
	-@erase "$(INTDIR)\dbproc.obj"
	-@erase "$(INTDIR)\dbproc.sbr"
	-@erase "$(INTDIR)\deflate.obj"
	-@erase "$(INTDIR)\deflate.sbr"
	-@erase "$(INTDIR)\doccol.obj"
	-@erase "$(INTDIR)\doccol.sbr"
	-@erase "$(INTDIR)\dociter.obj"
	-@erase "$(INTDIR)\dociter.sbr"
	-@erase "$(INTDIR)\document.obj"
	-@erase "$(INTDIR)\document.sbr"
	-@erase "$(INTDIR)\dummies.obj"
	-@erase "$(INTDIR)\dummies.sbr"
	-@erase "$(INTDIR)\errhandler.obj"
	-@erase "$(INTDIR)\errhandler.sbr"
	-@erase "$(INTDIR)\face.obj"
	-@erase "$(INTDIR)\face.sbr"
	-@erase "$(INTDIR)\fstring.caddr_t.map.obj"
	-@erase "$(INTDIR)\fstring.caddr_t.map.sbr"
	-@erase "$(INTDIR)\fstring.caddr_t.splaymap.obj"
	-@erase "$(INTDIR)\fstring.caddr_t.splaymap.sbr"
	-@erase "$(INTDIR)\fstring.fstring.map.obj"
	-@erase "$(INTDIR)\fstring.fstring.map.sbr"
	-@erase "$(INTDIR)\fstring.fstring.splaymap.obj"
	-@erase "$(INTDIR)\fstring.fstring.splaymap.sbr"
	-@erase "$(INTDIR)\fstring.long.map.obj"
	-@erase "$(INTDIR)\fstring.long.map.sbr"
	-@erase "$(INTDIR)\fstring.long.splaymap.obj"
	-@erase "$(INTDIR)\fstring.long.splaymap.sbr"
	-@erase "$(INTDIR)\fstring.obj"
	-@erase "$(INTDIR)\fstring.sbr"
	-@erase "$(INTDIR)\fstring.set.obj"
	-@erase "$(INTDIR)\fstring.set.sbr"
	-@erase "$(INTDIR)\fstring.splayset.obj"
	-@erase "$(INTDIR)\fstring.splayset.sbr"
	-@erase "$(INTDIR)\fstringer.obj"
	-@erase "$(INTDIR)\fstringer.sbr"
	-@erase "$(INTDIR)\garcomp.obj"
	-@erase "$(INTDIR)\garcomp.sbr"
	-@erase "$(INTDIR)\garutils.obj"
	-@erase "$(INTDIR)\garutils.sbr"
	-@erase "$(INTDIR)\gcini.obj"
	-@erase "$(INTDIR)\gcini.sbr"
	-@erase "$(INTDIR)\gclog.obj"
	-@erase "$(INTDIR)\gclog.sbr"
	-@erase "$(INTDIR)\gcpass1.obj"
	-@erase "$(INTDIR)\gcpass1.sbr"
	-@erase "$(INTDIR)\gsscreen.obj"
	-@erase "$(INTDIR)\gsscreen.sbr"
	-@erase "$(INTDIR)\hidxhlp.obj"
	-@erase "$(INTDIR)\hidxhlp.sbr"
	-@erase "$(INTDIR)\hindex.obj"
	-@erase "$(INTDIR)\hindex.sbr"
	-@erase "$(INTDIR)\hnode.obj"
	-@erase "$(INTDIR)\hnode.sbr"
	-@erase "$(INTDIR)\index.obj"
	-@erase "$(INTDIR)\index.sbr"
	-@erase "$(INTDIR)\indices.obj"
	-@erase "$(INTDIR)\indices.sbr"
	-@erase "$(INTDIR)\infblock.obj"
	-@erase "$(INTDIR)\infblock.sbr"
	-@erase "$(INTDIR)\infcodes.obj"
	-@erase "$(INTDIR)\infcodes.sbr"
	-@erase "$(INTDIR)\inffast.obj"
	-@erase "$(INTDIR)\inffast.sbr"
	-@erase "$(INTDIR)\inflate.obj"
	-@erase "$(INTDIR)\inflate.sbr"
	-@erase "$(INTDIR)\inftrees.obj"
	-@erase "$(INTDIR)\inftrees.sbr"
	-@erase "$(INTDIR)\infutil.obj"
	-@erase "$(INTDIR)\infutil.sbr"
	-@erase "$(INTDIR)\kwfile.obj"
	-@erase "$(INTDIR)\kwfile.sbr"
	-@erase "$(INTDIR)\lex_basis.obj"
	-@erase "$(INTDIR)\lex_basis.sbr"
	-@erase "$(INTDIR)\lex_operator.obj"
	-@erase "$(INTDIR)\lex_operator.sbr"
	-@erase "$(INTDIR)\lex_parser.obj"
	-@erase "$(INTDIR)\lex_parser.sbr"
	-@erase "$(INTDIR)\loadstringmap.obj"
	-@erase "$(INTDIR)\loadstringmap.sbr"
	-@erase "$(INTDIR)\long.longsplayset.map.obj"
	-@erase "$(INTDIR)\long.longsplayset.map.sbr"
	-@erase "$(INTDIR)\long.longsplayset.splaymap.obj"
	-@erase "$(INTDIR)\long.longsplayset.splaymap.sbr"
	-@erase "$(INTDIR)\long.set.obj"
	-@erase "$(INTDIR)\long.set.sbr"
	-@erase "$(INTDIR)\long.splayset.obj"
	-@erase "$(INTDIR)\long.splayset.sbr"
	-@erase "$(INTDIR)\long.vhset.obj"
	-@erase "$(INTDIR)\long.vhset.sbr"
	-@erase "$(INTDIR)\MyPipe.obj"
	-@erase "$(INTDIR)\MyPipe.sbr"
	-@erase "$(INTDIR)\ncpf.obj"
	-@erase "$(INTDIR)\ncpf.sbr"
	-@erase "$(INTDIR)\newdoc.obj"
	-@erase "$(INTDIR)\newdoc.sbr"
	-@erase "$(INTDIR)\normfile.obj"
	-@erase "$(INTDIR)\normfile.sbr"
	-@erase "$(INTDIR)\nsrcparser.obj"
	-@erase "$(INTDIR)\nsrcparser.sbr"
	-@erase "$(INTDIR)\osdummy.obj"
	-@erase "$(INTDIR)\osdummy.sbr"
	-@erase "$(INTDIR)\pack.obj"
	-@erase "$(INTDIR)\pack.sbr"
	-@erase "$(INTDIR)\pagefile.obj"
	-@erase "$(INTDIR)\pagefile.sbr"
	-@erase "$(INTDIR)\parser.obj"
	-@erase "$(INTDIR)\parser.sbr"
	-@erase "$(INTDIR)\publish.obj"
	-@erase "$(INTDIR)\publish.sbr"
	-@erase "$(INTDIR)\refcol.obj"
	-@erase "$(INTDIR)\refcol.sbr"
	-@erase "$(INTDIR)\screen.obj"
	-@erase "$(INTDIR)\screen.sbr"
	-@erase "$(INTDIR)\sources.obj"
	-@erase "$(INTDIR)\sources.sbr"
	-@erase "$(INTDIR)\stdbase.obj"
	-@erase "$(INTDIR)\stdbase.sbr"
	-@erase "$(INTDIR)\streams.obj"
	-@erase "$(INTDIR)\streams.sbr"
	-@erase "$(INTDIR)\sttop.obj"
	-@erase "$(INTDIR)\sttop.sbr"
	-@erase "$(INTDIR)\trees.obj"
	-@erase "$(INTDIR)\trees.sbr"
	-@erase "$(INTDIR)\u_int32_t.caddr_t.map.obj"
	-@erase "$(INTDIR)\u_int32_t.caddr_t.map.sbr"
	-@erase "$(INTDIR)\u_int32_t.caddr_t.splaymap.obj"
	-@erase "$(INTDIR)\u_int32_t.caddr_t.splaymap.sbr"
	-@erase "$(INTDIR)\u_int32_t.fstring.map.obj"
	-@erase "$(INTDIR)\u_int32_t.fstring.map.sbr"
	-@erase "$(INTDIR)\u_int32_t.fstring.splaymap.obj"
	-@erase "$(INTDIR)\u_int32_t.fstring.splaymap.sbr"
	-@erase "$(INTDIR)\u_int32_t.fstring.vhmap.obj"
	-@erase "$(INTDIR)\u_int32_t.fstring.vhmap.sbr"
	-@erase "$(INTDIR)\u_int32_t.set.obj"
	-@erase "$(INTDIR)\u_int32_t.set.sbr"
	-@erase "$(INTDIR)\u_int32_t.splayset.obj"
	-@erase "$(INTDIR)\u_int32_t.splayset.sbr"
	-@erase "$(INTDIR)\u_int32_t.vhset.obj"
	-@erase "$(INTDIR)\u_int32_t.vhset.sbr"
	-@erase "$(INTDIR)\u_int64_t.CtxLongSet.Map.obj"
	-@erase "$(INTDIR)\u_int64_t.CtxLongSet.Map.sbr"
	-@erase "$(INTDIR)\u_int64_t.CtxLongSet.SplayMap.obj"
	-@erase "$(INTDIR)\u_int64_t.CtxLongSet.SplayMap.sbr"
	-@erase "$(INTDIR)\u_int64_t.set.obj"
	-@erase "$(INTDIR)\u_int64_t.set.sbr"
	-@erase "$(INTDIR)\u_int64_t.splayset.obj"
	-@erase "$(INTDIR)\u_int64_t.splayset.sbr"
	-@erase "$(INTDIR)\u_int64_t.vhset.obj"
	-@erase "$(INTDIR)\u_int64_t.vhset.sbr"
	-@erase "$(INTDIR)\unzip.obj"
	-@erase "$(INTDIR)\unzip.sbr"
	-@erase "$(INTDIR)\vapi.obj"
	-@erase "$(INTDIR)\vapi.sbr"
	-@erase "$(INTDIR)\vc60.idb"
	-@erase "$(INTDIR)\vc60.pdb"
	-@erase "$(INTDIR)\zutil.obj"
	-@erase "$(INTDIR)\zutil.sbr"
	-@erase "$(OUTDIR)\gc.bsc"
	-@erase "$(OUTDIR)\gc.exe"
	-@erase "$(OUTDIR)\gc.pdb"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP=cl.exe
CPP_PROJ=/nologo /G6 /Zp1 /MTd /W3 /Gi /GX /Zi /Od /I "..\..\..\include" /I "..\..\..\include\win32" /I "..\..\..\libs\cchlp\src" /I "..\..\..\libs\gc\src" /I "..\..\..\libs\gkdb\src" /I "..\..\..\libs\gctx\src" /I "..\..\..\libs\gsscreen\src" /I "..\..\..\libs\lex\include" /I "..\..\..\libs\gchange\include" /I "..\..\..\tools\gctools\src" /D "_DEBUG" /D "WIN32" /D "_CONSOLE" /D "_MBCS" /D "WITH_DBL_THREAD" /D "OPT_PACK" /Fr"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

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
BSC32_FLAGS=/nologo /o"$(OUTDIR)\gc.bsc" 
BSC32_SBRS= \
	"$(INTDIR)\advlog.sbr" \
	"$(INTDIR)\date.set.sbr" \
	"$(INTDIR)\date.splayset.sbr" \
	"$(INTDIR)\errhandler.sbr" \
	"$(INTDIR)\fstring.caddr_t.map.sbr" \
	"$(INTDIR)\fstring.caddr_t.splaymap.sbr" \
	"$(INTDIR)\fstring.sbr" \
	"$(INTDIR)\fstring.fstring.map.sbr" \
	"$(INTDIR)\fstring.fstring.splaymap.sbr" \
	"$(INTDIR)\fstring.long.map.sbr" \
	"$(INTDIR)\fstring.long.splaymap.sbr" \
	"$(INTDIR)\fstring.set.sbr" \
	"$(INTDIR)\fstring.splayset.sbr" \
	"$(INTDIR)\hidxhlp.sbr" \
	"$(INTDIR)\hnode.sbr" \
	"$(INTDIR)\long.longsplayset.map.sbr" \
	"$(INTDIR)\long.longsplayset.splaymap.sbr" \
	"$(INTDIR)\long.set.sbr" \
	"$(INTDIR)\long.splayset.sbr" \
	"$(INTDIR)\long.vhset.sbr" \
	"$(INTDIR)\u_int32_t.caddr_t.map.sbr" \
	"$(INTDIR)\u_int32_t.caddr_t.splaymap.sbr" \
	"$(INTDIR)\u_int32_t.fstring.map.sbr" \
	"$(INTDIR)\u_int32_t.fstring.splaymap.sbr" \
	"$(INTDIR)\u_int32_t.fstring.vhmap.sbr" \
	"$(INTDIR)\u_int32_t.set.sbr" \
	"$(INTDIR)\u_int32_t.splayset.sbr" \
	"$(INTDIR)\u_int32_t.vhset.sbr" \
	"$(INTDIR)\u_int64_t.set.sbr" \
	"$(INTDIR)\u_int64_t.splayset.sbr" \
	"$(INTDIR)\u_int64_t.vhset.sbr" \
	"$(INTDIR)\dbproc.sbr" \
	"$(INTDIR)\dbproc.mf.sbr" \
	"$(INTDIR)\gclog.sbr" \
	"$(INTDIR)\adler32.sbr" \
	"$(INTDIR)\base.sbr" \
	"$(INTDIR)\basemask.sbr" \
	"$(INTDIR)\btiter.sbr" \
	"$(INTDIR)\btree.sbr" \
	"$(INTDIR)\collect.sbr" \
	"$(INTDIR)\crc32.sbr" \
	"$(INTDIR)\deflate.sbr" \
	"$(INTDIR)\doccol.sbr" \
	"$(INTDIR)\dociter.sbr" \
	"$(INTDIR)\document.sbr" \
	"$(INTDIR)\dummies.sbr" \
	"$(INTDIR)\garutils.sbr" \
	"$(INTDIR)\hindex.sbr" \
	"$(INTDIR)\index.sbr" \
	"$(INTDIR)\indices.sbr" \
	"$(INTDIR)\infblock.sbr" \
	"$(INTDIR)\infcodes.sbr" \
	"$(INTDIR)\inffast.sbr" \
	"$(INTDIR)\inflate.sbr" \
	"$(INTDIR)\inftrees.sbr" \
	"$(INTDIR)\infutil.sbr" \
	"$(INTDIR)\ncpf.sbr" \
	"$(INTDIR)\newdoc.sbr" \
	"$(INTDIR)\osdummy.sbr" \
	"$(INTDIR)\pack.sbr" \
	"$(INTDIR)\pagefile.sbr" \
	"$(INTDIR)\refcol.sbr" \
	"$(INTDIR)\stdbase.sbr" \
	"$(INTDIR)\streams.sbr" \
	"$(INTDIR)\trees.sbr" \
	"$(INTDIR)\unzip.sbr" \
	"$(INTDIR)\zutil.sbr" \
	"$(INTDIR)\vapi.sbr" \
	"$(INTDIR)\ctxwords.sbr" \
	"$(INTDIR)\u_int64_t.CtxLongSet.Map.sbr" \
	"$(INTDIR)\u_int64_t.CtxLongSet.SplayMap.sbr" \
	"$(INTDIR)\face.sbr" \
	"$(INTDIR)\gsscreen.sbr" \
	"$(INTDIR)\screen.sbr" \
	"$(INTDIR)\context.sbr" \
	"$(INTDIR)\parser.sbr" \
	"$(INTDIR)\lex_basis.sbr" \
	"$(INTDIR)\lex_operator.sbr" \
	"$(INTDIR)\lex_parser.sbr" \
	"$(INTDIR)\belongs.sbr" \
	"$(INTDIR)\blobtable.sbr" \
	"$(INTDIR)\cacheIndex.sbr" \
	"$(INTDIR)\classes.sbr" \
	"$(INTDIR)\complect.sbr" \
	"$(INTDIR)\dbproc.m-reader.sbr" \
	"$(INTDIR)\dbproc.m-to-gkdb.sbr" \
	"$(INTDIR)\dbproc.m-writer.sbr" \
	"$(INTDIR)\fstringer.sbr" \
	"$(INTDIR)\garcomp.sbr" \
	"$(INTDIR)\gcini.sbr" \
	"$(INTDIR)\gcpass1.sbr" \
	"$(INTDIR)\kwfile.sbr" \
	"$(INTDIR)\loadstringmap.sbr" \
	"$(INTDIR)\MyPipe.sbr" \
	"$(INTDIR)\normfile.sbr" \
	"$(INTDIR)\nsrcparser.sbr" \
	"$(INTDIR)\publish.sbr" \
	"$(INTDIR)\sources.sbr" \
	"$(INTDIR)\sttop.sbr"

"$(OUTDIR)\gc.bsc" : "$(OUTDIR)" $(BSC32_SBRS)
    $(BSC32) @<<
  $(BSC32_FLAGS) $(BSC32_SBRS)
<<

LINK32=link.exe
LINK32_FLAGS=/nologo /stack:0x4000000,0x4000000 /subsystem:console /incremental:no /pdb:"$(OUTDIR)\gc.pdb" /debug /machine:I386 /out:"$(OUTDIR)\gc.exe" /pdbtype:sept /FORCE:MULTIPLE /fixed:no 
LINK32_OBJS= \
	"$(INTDIR)\advlog.obj" \
	"$(INTDIR)\date.set.obj" \
	"$(INTDIR)\date.splayset.obj" \
	"$(INTDIR)\errhandler.obj" \
	"$(INTDIR)\fstring.caddr_t.map.obj" \
	"$(INTDIR)\fstring.caddr_t.splaymap.obj" \
	"$(INTDIR)\fstring.obj" \
	"$(INTDIR)\fstring.fstring.map.obj" \
	"$(INTDIR)\fstring.fstring.splaymap.obj" \
	"$(INTDIR)\fstring.long.map.obj" \
	"$(INTDIR)\fstring.long.splaymap.obj" \
	"$(INTDIR)\fstring.set.obj" \
	"$(INTDIR)\fstring.splayset.obj" \
	"$(INTDIR)\hidxhlp.obj" \
	"$(INTDIR)\hnode.obj" \
	"$(INTDIR)\long.longsplayset.map.obj" \
	"$(INTDIR)\long.longsplayset.splaymap.obj" \
	"$(INTDIR)\long.set.obj" \
	"$(INTDIR)\long.splayset.obj" \
	"$(INTDIR)\long.vhset.obj" \
	"$(INTDIR)\u_int32_t.caddr_t.map.obj" \
	"$(INTDIR)\u_int32_t.caddr_t.splaymap.obj" \
	"$(INTDIR)\u_int32_t.fstring.map.obj" \
	"$(INTDIR)\u_int32_t.fstring.splaymap.obj" \
	"$(INTDIR)\u_int32_t.fstring.vhmap.obj" \
	"$(INTDIR)\u_int32_t.set.obj" \
	"$(INTDIR)\u_int32_t.splayset.obj" \
	"$(INTDIR)\u_int32_t.vhset.obj" \
	"$(INTDIR)\u_int64_t.set.obj" \
	"$(INTDIR)\u_int64_t.splayset.obj" \
	"$(INTDIR)\u_int64_t.vhset.obj" \
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
	"$(INTDIR)\cacheIndex.obj" \
	"$(INTDIR)\classes.obj" \
	"$(INTDIR)\complect.obj" \
	"$(INTDIR)\dbproc.m-reader.obj" \
	"$(INTDIR)\dbproc.m-to-gkdb.obj" \
	"$(INTDIR)\dbproc.m-writer.obj" \
	"$(INTDIR)\fstringer.obj" \
	"$(INTDIR)\garcomp.obj" \
	"$(INTDIR)\gcini.obj" \
	"$(INTDIR)\gcpass1.obj" \
	"$(INTDIR)\kwfile.obj" \
	"$(INTDIR)\loadstringmap.obj" \
	"$(INTDIR)\MyPipe.obj" \
	"$(INTDIR)\normfile.obj" \
	"$(INTDIR)\nsrcparser.obj" \
	"$(INTDIR)\publish.obj" \
	"$(INTDIR)\sources.obj" \
	"$(INTDIR)\sttop.obj"

"$(OUTDIR)\gc.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"

OUTDIR=.\Debug_Old
INTDIR=.\Debug_Old
# Begin Custom Macros
OutDir=.\Debug_Old
# End Custom Macros

ALL : "$(OUTDIR)\gc.exe" "$(OUTDIR)\gc.bsc"


CLEAN :
	-@erase "$(INTDIR)\adler32.obj"
	-@erase "$(INTDIR)\adler32.sbr"
	-@erase "$(INTDIR)\advlog.obj"
	-@erase "$(INTDIR)\advlog.sbr"
	-@erase "$(INTDIR)\base.obj"
	-@erase "$(INTDIR)\base.sbr"
	-@erase "$(INTDIR)\basemask.obj"
	-@erase "$(INTDIR)\basemask.sbr"
	-@erase "$(INTDIR)\belongs.obj"
	-@erase "$(INTDIR)\belongs.sbr"
	-@erase "$(INTDIR)\blobtable.obj"
	-@erase "$(INTDIR)\blobtable.sbr"
	-@erase "$(INTDIR)\btiter.obj"
	-@erase "$(INTDIR)\btiter.sbr"
	-@erase "$(INTDIR)\btree.obj"
	-@erase "$(INTDIR)\btree.sbr"
	-@erase "$(INTDIR)\cacheIndex.obj"
	-@erase "$(INTDIR)\cacheIndex.sbr"
	-@erase "$(INTDIR)\classes.obj"
	-@erase "$(INTDIR)\classes.sbr"
	-@erase "$(INTDIR)\collect.obj"
	-@erase "$(INTDIR)\collect.sbr"
	-@erase "$(INTDIR)\complect.obj"
	-@erase "$(INTDIR)\complect.sbr"
	-@erase "$(INTDIR)\context.obj"
	-@erase "$(INTDIR)\context.sbr"
	-@erase "$(INTDIR)\crc32.obj"
	-@erase "$(INTDIR)\crc32.sbr"
	-@erase "$(INTDIR)\ctxwords.obj"
	-@erase "$(INTDIR)\ctxwords.sbr"
	-@erase "$(INTDIR)\date.set.obj"
	-@erase "$(INTDIR)\date.set.sbr"
	-@erase "$(INTDIR)\date.splayset.obj"
	-@erase "$(INTDIR)\date.splayset.sbr"
	-@erase "$(INTDIR)\dbproc.m-reader.obj"
	-@erase "$(INTDIR)\dbproc.m-reader.sbr"
	-@erase "$(INTDIR)\dbproc.m-to-gkdb.obj"
	-@erase "$(INTDIR)\dbproc.m-to-gkdb.sbr"
	-@erase "$(INTDIR)\dbproc.m-writer.obj"
	-@erase "$(INTDIR)\dbproc.m-writer.sbr"
	-@erase "$(INTDIR)\dbproc.mf.obj"
	-@erase "$(INTDIR)\dbproc.mf.sbr"
	-@erase "$(INTDIR)\dbproc.obj"
	-@erase "$(INTDIR)\dbproc.sbr"
	-@erase "$(INTDIR)\deflate.obj"
	-@erase "$(INTDIR)\deflate.sbr"
	-@erase "$(INTDIR)\doccol.obj"
	-@erase "$(INTDIR)\doccol.sbr"
	-@erase "$(INTDIR)\dociter.obj"
	-@erase "$(INTDIR)\dociter.sbr"
	-@erase "$(INTDIR)\document.obj"
	-@erase "$(INTDIR)\document.sbr"
	-@erase "$(INTDIR)\dummies.obj"
	-@erase "$(INTDIR)\dummies.sbr"
	-@erase "$(INTDIR)\errhandler.obj"
	-@erase "$(INTDIR)\errhandler.sbr"
	-@erase "$(INTDIR)\face.obj"
	-@erase "$(INTDIR)\face.sbr"
	-@erase "$(INTDIR)\fstring.caddr_t.map.obj"
	-@erase "$(INTDIR)\fstring.caddr_t.map.sbr"
	-@erase "$(INTDIR)\fstring.caddr_t.splaymap.obj"
	-@erase "$(INTDIR)\fstring.caddr_t.splaymap.sbr"
	-@erase "$(INTDIR)\fstring.fstring.map.obj"
	-@erase "$(INTDIR)\fstring.fstring.map.sbr"
	-@erase "$(INTDIR)\fstring.fstring.splaymap.obj"
	-@erase "$(INTDIR)\fstring.fstring.splaymap.sbr"
	-@erase "$(INTDIR)\fstring.long.map.obj"
	-@erase "$(INTDIR)\fstring.long.map.sbr"
	-@erase "$(INTDIR)\fstring.long.splaymap.obj"
	-@erase "$(INTDIR)\fstring.long.splaymap.sbr"
	-@erase "$(INTDIR)\fstring.obj"
	-@erase "$(INTDIR)\fstring.sbr"
	-@erase "$(INTDIR)\fstring.set.obj"
	-@erase "$(INTDIR)\fstring.set.sbr"
	-@erase "$(INTDIR)\fstring.splayset.obj"
	-@erase "$(INTDIR)\fstring.splayset.sbr"
	-@erase "$(INTDIR)\fstringer.obj"
	-@erase "$(INTDIR)\fstringer.sbr"
	-@erase "$(INTDIR)\garcomp.obj"
	-@erase "$(INTDIR)\garcomp.sbr"
	-@erase "$(INTDIR)\garutils.obj"
	-@erase "$(INTDIR)\garutils.sbr"
	-@erase "$(INTDIR)\gcini.obj"
	-@erase "$(INTDIR)\gcini.sbr"
	-@erase "$(INTDIR)\gclog.obj"
	-@erase "$(INTDIR)\gclog.sbr"
	-@erase "$(INTDIR)\gcpass1.obj"
	-@erase "$(INTDIR)\gcpass1.sbr"
	-@erase "$(INTDIR)\gsscreen.obj"
	-@erase "$(INTDIR)\gsscreen.sbr"
	-@erase "$(INTDIR)\hidxhlp.obj"
	-@erase "$(INTDIR)\hidxhlp.sbr"
	-@erase "$(INTDIR)\hindex.obj"
	-@erase "$(INTDIR)\hindex.sbr"
	-@erase "$(INTDIR)\hnode.obj"
	-@erase "$(INTDIR)\hnode.sbr"
	-@erase "$(INTDIR)\index.obj"
	-@erase "$(INTDIR)\index.sbr"
	-@erase "$(INTDIR)\indices.obj"
	-@erase "$(INTDIR)\indices.sbr"
	-@erase "$(INTDIR)\infblock.obj"
	-@erase "$(INTDIR)\infblock.sbr"
	-@erase "$(INTDIR)\infcodes.obj"
	-@erase "$(INTDIR)\infcodes.sbr"
	-@erase "$(INTDIR)\inffast.obj"
	-@erase "$(INTDIR)\inffast.sbr"
	-@erase "$(INTDIR)\inflate.obj"
	-@erase "$(INTDIR)\inflate.sbr"
	-@erase "$(INTDIR)\inftrees.obj"
	-@erase "$(INTDIR)\inftrees.sbr"
	-@erase "$(INTDIR)\infutil.obj"
	-@erase "$(INTDIR)\infutil.sbr"
	-@erase "$(INTDIR)\kwfile.obj"
	-@erase "$(INTDIR)\kwfile.sbr"
	-@erase "$(INTDIR)\lex_basis.obj"
	-@erase "$(INTDIR)\lex_basis.sbr"
	-@erase "$(INTDIR)\lex_operator.obj"
	-@erase "$(INTDIR)\lex_operator.sbr"
	-@erase "$(INTDIR)\lex_parser.obj"
	-@erase "$(INTDIR)\lex_parser.sbr"
	-@erase "$(INTDIR)\loadstringmap.obj"
	-@erase "$(INTDIR)\loadstringmap.sbr"
	-@erase "$(INTDIR)\long.longsplayset.map.obj"
	-@erase "$(INTDIR)\long.longsplayset.map.sbr"
	-@erase "$(INTDIR)\long.longsplayset.splaymap.obj"
	-@erase "$(INTDIR)\long.longsplayset.splaymap.sbr"
	-@erase "$(INTDIR)\long.set.obj"
	-@erase "$(INTDIR)\long.set.sbr"
	-@erase "$(INTDIR)\long.splayset.obj"
	-@erase "$(INTDIR)\long.splayset.sbr"
	-@erase "$(INTDIR)\long.vhset.obj"
	-@erase "$(INTDIR)\long.vhset.sbr"
	-@erase "$(INTDIR)\MyPipe.obj"
	-@erase "$(INTDIR)\MyPipe.sbr"
	-@erase "$(INTDIR)\ncpf.obj"
	-@erase "$(INTDIR)\ncpf.sbr"
	-@erase "$(INTDIR)\newdoc.obj"
	-@erase "$(INTDIR)\newdoc.sbr"
	-@erase "$(INTDIR)\normfile.obj"
	-@erase "$(INTDIR)\normfile.sbr"
	-@erase "$(INTDIR)\nsrcparser.obj"
	-@erase "$(INTDIR)\nsrcparser.sbr"
	-@erase "$(INTDIR)\osdummy.obj"
	-@erase "$(INTDIR)\osdummy.sbr"
	-@erase "$(INTDIR)\pack.obj"
	-@erase "$(INTDIR)\pack.sbr"
	-@erase "$(INTDIR)\pagefile.obj"
	-@erase "$(INTDIR)\pagefile.sbr"
	-@erase "$(INTDIR)\parser.obj"
	-@erase "$(INTDIR)\parser.sbr"
	-@erase "$(INTDIR)\publish.obj"
	-@erase "$(INTDIR)\publish.sbr"
	-@erase "$(INTDIR)\refcol.obj"
	-@erase "$(INTDIR)\refcol.sbr"
	-@erase "$(INTDIR)\screen.obj"
	-@erase "$(INTDIR)\screen.sbr"
	-@erase "$(INTDIR)\sources.obj"
	-@erase "$(INTDIR)\sources.sbr"
	-@erase "$(INTDIR)\stdbase.obj"
	-@erase "$(INTDIR)\stdbase.sbr"
	-@erase "$(INTDIR)\streams.obj"
	-@erase "$(INTDIR)\streams.sbr"
	-@erase "$(INTDIR)\sttop.obj"
	-@erase "$(INTDIR)\sttop.sbr"
	-@erase "$(INTDIR)\trees.obj"
	-@erase "$(INTDIR)\trees.sbr"
	-@erase "$(INTDIR)\u_int32_t.caddr_t.map.obj"
	-@erase "$(INTDIR)\u_int32_t.caddr_t.map.sbr"
	-@erase "$(INTDIR)\u_int32_t.caddr_t.splaymap.obj"
	-@erase "$(INTDIR)\u_int32_t.caddr_t.splaymap.sbr"
	-@erase "$(INTDIR)\u_int32_t.fstring.map.obj"
	-@erase "$(INTDIR)\u_int32_t.fstring.map.sbr"
	-@erase "$(INTDIR)\u_int32_t.fstring.splaymap.obj"
	-@erase "$(INTDIR)\u_int32_t.fstring.splaymap.sbr"
	-@erase "$(INTDIR)\u_int32_t.fstring.vhmap.obj"
	-@erase "$(INTDIR)\u_int32_t.fstring.vhmap.sbr"
	-@erase "$(INTDIR)\u_int32_t.set.obj"
	-@erase "$(INTDIR)\u_int32_t.set.sbr"
	-@erase "$(INTDIR)\u_int32_t.splayset.obj"
	-@erase "$(INTDIR)\u_int32_t.splayset.sbr"
	-@erase "$(INTDIR)\u_int32_t.vhset.obj"
	-@erase "$(INTDIR)\u_int32_t.vhset.sbr"
	-@erase "$(INTDIR)\u_int64_t.CtxLongSet.Map.obj"
	-@erase "$(INTDIR)\u_int64_t.CtxLongSet.Map.sbr"
	-@erase "$(INTDIR)\u_int64_t.CtxLongSet.SplayMap.obj"
	-@erase "$(INTDIR)\u_int64_t.CtxLongSet.SplayMap.sbr"
	-@erase "$(INTDIR)\u_int64_t.set.obj"
	-@erase "$(INTDIR)\u_int64_t.set.sbr"
	-@erase "$(INTDIR)\u_int64_t.splayset.obj"
	-@erase "$(INTDIR)\u_int64_t.splayset.sbr"
	-@erase "$(INTDIR)\u_int64_t.vhset.obj"
	-@erase "$(INTDIR)\u_int64_t.vhset.sbr"
	-@erase "$(INTDIR)\unzip.obj"
	-@erase "$(INTDIR)\unzip.sbr"
	-@erase "$(INTDIR)\vapi.obj"
	-@erase "$(INTDIR)\vapi.sbr"
	-@erase "$(INTDIR)\vc60.idb"
	-@erase "$(INTDIR)\vc60.pdb"
	-@erase "$(INTDIR)\zutil.obj"
	-@erase "$(INTDIR)\zutil.sbr"
	-@erase "$(OUTDIR)\gc.bsc"
	-@erase "$(OUTDIR)\gc.exe"
	-@erase "$(OUTDIR)\gc.ilk"
	-@erase "$(OUTDIR)\gc.pdb"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP=cl.exe
CPP_PROJ=/nologo /G5 /MLd /W3 /Gi /GX /Zi /Od /I "..\..\..\include" /I "..\..\..\include\win32" /I "..\..\..\libs\cchlp\src" /I "..\..\..\libs\gc\src" /I "..\..\..\libs\gkdb\src" /I "..\..\..\libs\gctx\src" /I "..\..\..\libs\gsscreen\src" /I "..\..\..\libs\lex\include" /I "..\..\..\libs\gchange\include" /I "..\..\..\tools\gctools\src" /D "_DEBUG" /D "WIN32" /D "_CONSOLE" /D "_MBCS" /D "INC_GCTX" /D "OPT_META" /Fr"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

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
BSC32_FLAGS=/nologo /o"$(OUTDIR)\gc.bsc" 
BSC32_SBRS= \
	"$(INTDIR)\advlog.sbr" \
	"$(INTDIR)\date.set.sbr" \
	"$(INTDIR)\date.splayset.sbr" \
	"$(INTDIR)\errhandler.sbr" \
	"$(INTDIR)\fstring.caddr_t.map.sbr" \
	"$(INTDIR)\fstring.caddr_t.splaymap.sbr" \
	"$(INTDIR)\fstring.sbr" \
	"$(INTDIR)\fstring.fstring.map.sbr" \
	"$(INTDIR)\fstring.fstring.splaymap.sbr" \
	"$(INTDIR)\fstring.long.map.sbr" \
	"$(INTDIR)\fstring.long.splaymap.sbr" \
	"$(INTDIR)\fstring.set.sbr" \
	"$(INTDIR)\fstring.splayset.sbr" \
	"$(INTDIR)\hidxhlp.sbr" \
	"$(INTDIR)\hnode.sbr" \
	"$(INTDIR)\long.longsplayset.map.sbr" \
	"$(INTDIR)\long.longsplayset.splaymap.sbr" \
	"$(INTDIR)\long.set.sbr" \
	"$(INTDIR)\long.splayset.sbr" \
	"$(INTDIR)\long.vhset.sbr" \
	"$(INTDIR)\u_int32_t.caddr_t.map.sbr" \
	"$(INTDIR)\u_int32_t.caddr_t.splaymap.sbr" \
	"$(INTDIR)\u_int32_t.fstring.map.sbr" \
	"$(INTDIR)\u_int32_t.fstring.splaymap.sbr" \
	"$(INTDIR)\u_int32_t.fstring.vhmap.sbr" \
	"$(INTDIR)\u_int32_t.set.sbr" \
	"$(INTDIR)\u_int32_t.splayset.sbr" \
	"$(INTDIR)\u_int32_t.vhset.sbr" \
	"$(INTDIR)\u_int64_t.set.sbr" \
	"$(INTDIR)\u_int64_t.splayset.sbr" \
	"$(INTDIR)\u_int64_t.vhset.sbr" \
	"$(INTDIR)\dbproc.sbr" \
	"$(INTDIR)\dbproc.mf.sbr" \
	"$(INTDIR)\gclog.sbr" \
	"$(INTDIR)\adler32.sbr" \
	"$(INTDIR)\base.sbr" \
	"$(INTDIR)\basemask.sbr" \
	"$(INTDIR)\btiter.sbr" \
	"$(INTDIR)\btree.sbr" \
	"$(INTDIR)\collect.sbr" \
	"$(INTDIR)\crc32.sbr" \
	"$(INTDIR)\deflate.sbr" \
	"$(INTDIR)\doccol.sbr" \
	"$(INTDIR)\dociter.sbr" \
	"$(INTDIR)\document.sbr" \
	"$(INTDIR)\dummies.sbr" \
	"$(INTDIR)\garutils.sbr" \
	"$(INTDIR)\hindex.sbr" \
	"$(INTDIR)\index.sbr" \
	"$(INTDIR)\indices.sbr" \
	"$(INTDIR)\infblock.sbr" \
	"$(INTDIR)\infcodes.sbr" \
	"$(INTDIR)\inffast.sbr" \
	"$(INTDIR)\inflate.sbr" \
	"$(INTDIR)\inftrees.sbr" \
	"$(INTDIR)\infutil.sbr" \
	"$(INTDIR)\ncpf.sbr" \
	"$(INTDIR)\newdoc.sbr" \
	"$(INTDIR)\osdummy.sbr" \
	"$(INTDIR)\pack.sbr" \
	"$(INTDIR)\pagefile.sbr" \
	"$(INTDIR)\refcol.sbr" \
	"$(INTDIR)\stdbase.sbr" \
	"$(INTDIR)\streams.sbr" \
	"$(INTDIR)\trees.sbr" \
	"$(INTDIR)\unzip.sbr" \
	"$(INTDIR)\zutil.sbr" \
	"$(INTDIR)\vapi.sbr" \
	"$(INTDIR)\ctxwords.sbr" \
	"$(INTDIR)\u_int64_t.CtxLongSet.Map.sbr" \
	"$(INTDIR)\u_int64_t.CtxLongSet.SplayMap.sbr" \
	"$(INTDIR)\face.sbr" \
	"$(INTDIR)\gsscreen.sbr" \
	"$(INTDIR)\screen.sbr" \
	"$(INTDIR)\context.sbr" \
	"$(INTDIR)\parser.sbr" \
	"$(INTDIR)\lex_basis.sbr" \
	"$(INTDIR)\lex_operator.sbr" \
	"$(INTDIR)\lex_parser.sbr" \
	"$(INTDIR)\belongs.sbr" \
	"$(INTDIR)\blobtable.sbr" \
	"$(INTDIR)\cacheIndex.sbr" \
	"$(INTDIR)\classes.sbr" \
	"$(INTDIR)\complect.sbr" \
	"$(INTDIR)\dbproc.m-reader.sbr" \
	"$(INTDIR)\dbproc.m-to-gkdb.sbr" \
	"$(INTDIR)\dbproc.m-writer.sbr" \
	"$(INTDIR)\fstringer.sbr" \
	"$(INTDIR)\garcomp.sbr" \
	"$(INTDIR)\gcini.sbr" \
	"$(INTDIR)\gcpass1.sbr" \
	"$(INTDIR)\kwfile.sbr" \
	"$(INTDIR)\loadstringmap.sbr" \
	"$(INTDIR)\MyPipe.sbr" \
	"$(INTDIR)\normfile.sbr" \
	"$(INTDIR)\nsrcparser.sbr" \
	"$(INTDIR)\publish.sbr" \
	"$(INTDIR)\sources.sbr" \
	"$(INTDIR)\sttop.sbr"

"$(OUTDIR)\gc.bsc" : "$(OUTDIR)" $(BSC32_SBRS)
    $(BSC32) @<<
  $(BSC32_FLAGS) $(BSC32_SBRS)
<<

LINK32=link.exe
LINK32_FLAGS=/nologo /stack:0xa00000,0x100000 /subsystem:console /incremental:yes /pdb:"$(OUTDIR)\gc.pdb" /debug /machine:I386 /out:"$(OUTDIR)\gc.exe" /pdbtype:sept /fixed:no 
LINK32_OBJS= \
	"$(INTDIR)\advlog.obj" \
	"$(INTDIR)\date.set.obj" \
	"$(INTDIR)\date.splayset.obj" \
	"$(INTDIR)\errhandler.obj" \
	"$(INTDIR)\fstring.caddr_t.map.obj" \
	"$(INTDIR)\fstring.caddr_t.splaymap.obj" \
	"$(INTDIR)\fstring.obj" \
	"$(INTDIR)\fstring.fstring.map.obj" \
	"$(INTDIR)\fstring.fstring.splaymap.obj" \
	"$(INTDIR)\fstring.long.map.obj" \
	"$(INTDIR)\fstring.long.splaymap.obj" \
	"$(INTDIR)\fstring.set.obj" \
	"$(INTDIR)\fstring.splayset.obj" \
	"$(INTDIR)\hidxhlp.obj" \
	"$(INTDIR)\hnode.obj" \
	"$(INTDIR)\long.longsplayset.map.obj" \
	"$(INTDIR)\long.longsplayset.splaymap.obj" \
	"$(INTDIR)\long.set.obj" \
	"$(INTDIR)\long.splayset.obj" \
	"$(INTDIR)\long.vhset.obj" \
	"$(INTDIR)\u_int32_t.caddr_t.map.obj" \
	"$(INTDIR)\u_int32_t.caddr_t.splaymap.obj" \
	"$(INTDIR)\u_int32_t.fstring.map.obj" \
	"$(INTDIR)\u_int32_t.fstring.splaymap.obj" \
	"$(INTDIR)\u_int32_t.fstring.vhmap.obj" \
	"$(INTDIR)\u_int32_t.set.obj" \
	"$(INTDIR)\u_int32_t.splayset.obj" \
	"$(INTDIR)\u_int32_t.vhset.obj" \
	"$(INTDIR)\u_int64_t.set.obj" \
	"$(INTDIR)\u_int64_t.splayset.obj" \
	"$(INTDIR)\u_int64_t.vhset.obj" \
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
	"$(INTDIR)\cacheIndex.obj" \
	"$(INTDIR)\classes.obj" \
	"$(INTDIR)\complect.obj" \
	"$(INTDIR)\dbproc.m-reader.obj" \
	"$(INTDIR)\dbproc.m-to-gkdb.obj" \
	"$(INTDIR)\dbproc.m-writer.obj" \
	"$(INTDIR)\fstringer.obj" \
	"$(INTDIR)\garcomp.obj" \
	"$(INTDIR)\gcini.obj" \
	"$(INTDIR)\gcpass1.obj" \
	"$(INTDIR)\kwfile.obj" \
	"$(INTDIR)\loadstringmap.obj" \
	"$(INTDIR)\MyPipe.obj" \
	"$(INTDIR)\normfile.obj" \
	"$(INTDIR)\nsrcparser.obj" \
	"$(INTDIR)\publish.obj" \
	"$(INTDIR)\sources.obj" \
	"$(INTDIR)\sttop.obj"

"$(OUTDIR)\gc.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"

OUTDIR=.\Release_Old
INTDIR=.\Release_Old
# Begin Custom Macros
OutDir=.\Release_Old
# End Custom Macros

ALL : "$(OUTDIR)\gc.exe" "$(OUTDIR)\gc.bsc"


CLEAN :
	-@erase "$(INTDIR)\adler32.obj"
	-@erase "$(INTDIR)\adler32.sbr"
	-@erase "$(INTDIR)\advlog.obj"
	-@erase "$(INTDIR)\advlog.sbr"
	-@erase "$(INTDIR)\base.obj"
	-@erase "$(INTDIR)\base.sbr"
	-@erase "$(INTDIR)\basemask.obj"
	-@erase "$(INTDIR)\basemask.sbr"
	-@erase "$(INTDIR)\belongs.obj"
	-@erase "$(INTDIR)\belongs.sbr"
	-@erase "$(INTDIR)\blobtable.obj"
	-@erase "$(INTDIR)\blobtable.sbr"
	-@erase "$(INTDIR)\btiter.obj"
	-@erase "$(INTDIR)\btiter.sbr"
	-@erase "$(INTDIR)\btree.obj"
	-@erase "$(INTDIR)\btree.sbr"
	-@erase "$(INTDIR)\cacheIndex.obj"
	-@erase "$(INTDIR)\cacheIndex.sbr"
	-@erase "$(INTDIR)\classes.obj"
	-@erase "$(INTDIR)\classes.sbr"
	-@erase "$(INTDIR)\collect.obj"
	-@erase "$(INTDIR)\collect.sbr"
	-@erase "$(INTDIR)\complect.obj"
	-@erase "$(INTDIR)\complect.sbr"
	-@erase "$(INTDIR)\context.obj"
	-@erase "$(INTDIR)\context.sbr"
	-@erase "$(INTDIR)\crc32.obj"
	-@erase "$(INTDIR)\crc32.sbr"
	-@erase "$(INTDIR)\ctxwords.obj"
	-@erase "$(INTDIR)\ctxwords.sbr"
	-@erase "$(INTDIR)\date.set.obj"
	-@erase "$(INTDIR)\date.set.sbr"
	-@erase "$(INTDIR)\date.splayset.obj"
	-@erase "$(INTDIR)\date.splayset.sbr"
	-@erase "$(INTDIR)\dbproc.m-reader.obj"
	-@erase "$(INTDIR)\dbproc.m-reader.sbr"
	-@erase "$(INTDIR)\dbproc.m-to-gkdb.obj"
	-@erase "$(INTDIR)\dbproc.m-to-gkdb.sbr"
	-@erase "$(INTDIR)\dbproc.m-writer.obj"
	-@erase "$(INTDIR)\dbproc.m-writer.sbr"
	-@erase "$(INTDIR)\dbproc.mf.obj"
	-@erase "$(INTDIR)\dbproc.mf.sbr"
	-@erase "$(INTDIR)\dbproc.obj"
	-@erase "$(INTDIR)\dbproc.sbr"
	-@erase "$(INTDIR)\deflate.obj"
	-@erase "$(INTDIR)\deflate.sbr"
	-@erase "$(INTDIR)\doccol.obj"
	-@erase "$(INTDIR)\doccol.sbr"
	-@erase "$(INTDIR)\dociter.obj"
	-@erase "$(INTDIR)\dociter.sbr"
	-@erase "$(INTDIR)\document.obj"
	-@erase "$(INTDIR)\document.sbr"
	-@erase "$(INTDIR)\dummies.obj"
	-@erase "$(INTDIR)\dummies.sbr"
	-@erase "$(INTDIR)\errhandler.obj"
	-@erase "$(INTDIR)\errhandler.sbr"
	-@erase "$(INTDIR)\face.obj"
	-@erase "$(INTDIR)\face.sbr"
	-@erase "$(INTDIR)\fstring.caddr_t.map.obj"
	-@erase "$(INTDIR)\fstring.caddr_t.map.sbr"
	-@erase "$(INTDIR)\fstring.caddr_t.splaymap.obj"
	-@erase "$(INTDIR)\fstring.caddr_t.splaymap.sbr"
	-@erase "$(INTDIR)\fstring.fstring.map.obj"
	-@erase "$(INTDIR)\fstring.fstring.map.sbr"
	-@erase "$(INTDIR)\fstring.fstring.splaymap.obj"
	-@erase "$(INTDIR)\fstring.fstring.splaymap.sbr"
	-@erase "$(INTDIR)\fstring.long.map.obj"
	-@erase "$(INTDIR)\fstring.long.map.sbr"
	-@erase "$(INTDIR)\fstring.long.splaymap.obj"
	-@erase "$(INTDIR)\fstring.long.splaymap.sbr"
	-@erase "$(INTDIR)\fstring.obj"
	-@erase "$(INTDIR)\fstring.sbr"
	-@erase "$(INTDIR)\fstring.set.obj"
	-@erase "$(INTDIR)\fstring.set.sbr"
	-@erase "$(INTDIR)\fstring.splayset.obj"
	-@erase "$(INTDIR)\fstring.splayset.sbr"
	-@erase "$(INTDIR)\fstringer.obj"
	-@erase "$(INTDIR)\fstringer.sbr"
	-@erase "$(INTDIR)\garcomp.obj"
	-@erase "$(INTDIR)\garcomp.sbr"
	-@erase "$(INTDIR)\garutils.obj"
	-@erase "$(INTDIR)\garutils.sbr"
	-@erase "$(INTDIR)\gcini.obj"
	-@erase "$(INTDIR)\gcini.sbr"
	-@erase "$(INTDIR)\gclog.obj"
	-@erase "$(INTDIR)\gclog.sbr"
	-@erase "$(INTDIR)\gcpass1.obj"
	-@erase "$(INTDIR)\gcpass1.sbr"
	-@erase "$(INTDIR)\gsscreen.obj"
	-@erase "$(INTDIR)\gsscreen.sbr"
	-@erase "$(INTDIR)\hidxhlp.obj"
	-@erase "$(INTDIR)\hidxhlp.sbr"
	-@erase "$(INTDIR)\hindex.obj"
	-@erase "$(INTDIR)\hindex.sbr"
	-@erase "$(INTDIR)\hnode.obj"
	-@erase "$(INTDIR)\hnode.sbr"
	-@erase "$(INTDIR)\index.obj"
	-@erase "$(INTDIR)\index.sbr"
	-@erase "$(INTDIR)\indices.obj"
	-@erase "$(INTDIR)\indices.sbr"
	-@erase "$(INTDIR)\infblock.obj"
	-@erase "$(INTDIR)\infblock.sbr"
	-@erase "$(INTDIR)\infcodes.obj"
	-@erase "$(INTDIR)\infcodes.sbr"
	-@erase "$(INTDIR)\inffast.obj"
	-@erase "$(INTDIR)\inffast.sbr"
	-@erase "$(INTDIR)\inflate.obj"
	-@erase "$(INTDIR)\inflate.sbr"
	-@erase "$(INTDIR)\inftrees.obj"
	-@erase "$(INTDIR)\inftrees.sbr"
	-@erase "$(INTDIR)\infutil.obj"
	-@erase "$(INTDIR)\infutil.sbr"
	-@erase "$(INTDIR)\kwfile.obj"
	-@erase "$(INTDIR)\kwfile.sbr"
	-@erase "$(INTDIR)\lex_basis.obj"
	-@erase "$(INTDIR)\lex_basis.sbr"
	-@erase "$(INTDIR)\lex_operator.obj"
	-@erase "$(INTDIR)\lex_operator.sbr"
	-@erase "$(INTDIR)\lex_parser.obj"
	-@erase "$(INTDIR)\lex_parser.sbr"
	-@erase "$(INTDIR)\loadstringmap.obj"
	-@erase "$(INTDIR)\loadstringmap.sbr"
	-@erase "$(INTDIR)\long.longsplayset.map.obj"
	-@erase "$(INTDIR)\long.longsplayset.map.sbr"
	-@erase "$(INTDIR)\long.longsplayset.splaymap.obj"
	-@erase "$(INTDIR)\long.longsplayset.splaymap.sbr"
	-@erase "$(INTDIR)\long.set.obj"
	-@erase "$(INTDIR)\long.set.sbr"
	-@erase "$(INTDIR)\long.splayset.obj"
	-@erase "$(INTDIR)\long.splayset.sbr"
	-@erase "$(INTDIR)\long.vhset.obj"
	-@erase "$(INTDIR)\long.vhset.sbr"
	-@erase "$(INTDIR)\MyPipe.obj"
	-@erase "$(INTDIR)\MyPipe.sbr"
	-@erase "$(INTDIR)\ncpf.obj"
	-@erase "$(INTDIR)\ncpf.sbr"
	-@erase "$(INTDIR)\newdoc.obj"
	-@erase "$(INTDIR)\newdoc.sbr"
	-@erase "$(INTDIR)\normfile.obj"
	-@erase "$(INTDIR)\normfile.sbr"
	-@erase "$(INTDIR)\nsrcparser.obj"
	-@erase "$(INTDIR)\nsrcparser.sbr"
	-@erase "$(INTDIR)\osdummy.obj"
	-@erase "$(INTDIR)\osdummy.sbr"
	-@erase "$(INTDIR)\pack.obj"
	-@erase "$(INTDIR)\pack.sbr"
	-@erase "$(INTDIR)\pagefile.obj"
	-@erase "$(INTDIR)\pagefile.sbr"
	-@erase "$(INTDIR)\parser.obj"
	-@erase "$(INTDIR)\parser.sbr"
	-@erase "$(INTDIR)\publish.obj"
	-@erase "$(INTDIR)\publish.sbr"
	-@erase "$(INTDIR)\refcol.obj"
	-@erase "$(INTDIR)\refcol.sbr"
	-@erase "$(INTDIR)\screen.obj"
	-@erase "$(INTDIR)\screen.sbr"
	-@erase "$(INTDIR)\sources.obj"
	-@erase "$(INTDIR)\sources.sbr"
	-@erase "$(INTDIR)\stdbase.obj"
	-@erase "$(INTDIR)\stdbase.sbr"
	-@erase "$(INTDIR)\streams.obj"
	-@erase "$(INTDIR)\streams.sbr"
	-@erase "$(INTDIR)\sttop.obj"
	-@erase "$(INTDIR)\sttop.sbr"
	-@erase "$(INTDIR)\trees.obj"
	-@erase "$(INTDIR)\trees.sbr"
	-@erase "$(INTDIR)\u_int32_t.caddr_t.map.obj"
	-@erase "$(INTDIR)\u_int32_t.caddr_t.map.sbr"
	-@erase "$(INTDIR)\u_int32_t.caddr_t.splaymap.obj"
	-@erase "$(INTDIR)\u_int32_t.caddr_t.splaymap.sbr"
	-@erase "$(INTDIR)\u_int32_t.fstring.map.obj"
	-@erase "$(INTDIR)\u_int32_t.fstring.map.sbr"
	-@erase "$(INTDIR)\u_int32_t.fstring.splaymap.obj"
	-@erase "$(INTDIR)\u_int32_t.fstring.splaymap.sbr"
	-@erase "$(INTDIR)\u_int32_t.fstring.vhmap.obj"
	-@erase "$(INTDIR)\u_int32_t.fstring.vhmap.sbr"
	-@erase "$(INTDIR)\u_int32_t.set.obj"
	-@erase "$(INTDIR)\u_int32_t.set.sbr"
	-@erase "$(INTDIR)\u_int32_t.splayset.obj"
	-@erase "$(INTDIR)\u_int32_t.splayset.sbr"
	-@erase "$(INTDIR)\u_int32_t.vhset.obj"
	-@erase "$(INTDIR)\u_int32_t.vhset.sbr"
	-@erase "$(INTDIR)\u_int64_t.CtxLongSet.Map.obj"
	-@erase "$(INTDIR)\u_int64_t.CtxLongSet.Map.sbr"
	-@erase "$(INTDIR)\u_int64_t.CtxLongSet.SplayMap.obj"
	-@erase "$(INTDIR)\u_int64_t.CtxLongSet.SplayMap.sbr"
	-@erase "$(INTDIR)\u_int64_t.set.obj"
	-@erase "$(INTDIR)\u_int64_t.set.sbr"
	-@erase "$(INTDIR)\u_int64_t.splayset.obj"
	-@erase "$(INTDIR)\u_int64_t.splayset.sbr"
	-@erase "$(INTDIR)\u_int64_t.vhset.obj"
	-@erase "$(INTDIR)\u_int64_t.vhset.sbr"
	-@erase "$(INTDIR)\unzip.obj"
	-@erase "$(INTDIR)\unzip.sbr"
	-@erase "$(INTDIR)\vapi.obj"
	-@erase "$(INTDIR)\vapi.sbr"
	-@erase "$(INTDIR)\vc60.idb"
	-@erase "$(INTDIR)\zutil.obj"
	-@erase "$(INTDIR)\zutil.sbr"
	-@erase "$(OUTDIR)\gc.bsc"
	-@erase "$(OUTDIR)\gc.exe"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP=cl.exe
CPP_PROJ=/nologo /G6 /ML /W3 /Gi /GX /O2 /I "..\..\..\include" /I "..\..\..\include\win32" /I "..\..\..\libs\cchlp\src" /I "..\..\..\libs\gc\src" /I "..\..\..\libs\gkdb\src" /I "..\..\..\libs\gctx\src" /I "..\..\..\libs\gsscreen\src" /I "..\..\..\libs\lex\include" /I "..\..\..\libs\gchange\include" /I "..\..\..\tools\gctools\src" /D "NDEBUG" /D "WIN32" /D "_CONSOLE" /D "_MBCS" /D "INC_GCTX" /D "OPT_META" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

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
BSC32_FLAGS=/nologo /o"$(OUTDIR)\gc.bsc" 
BSC32_SBRS= \
	"$(INTDIR)\advlog.sbr" \
	"$(INTDIR)\date.set.sbr" \
	"$(INTDIR)\date.splayset.sbr" \
	"$(INTDIR)\errhandler.sbr" \
	"$(INTDIR)\fstring.caddr_t.map.sbr" \
	"$(INTDIR)\fstring.caddr_t.splaymap.sbr" \
	"$(INTDIR)\fstring.sbr" \
	"$(INTDIR)\fstring.fstring.map.sbr" \
	"$(INTDIR)\fstring.fstring.splaymap.sbr" \
	"$(INTDIR)\fstring.long.map.sbr" \
	"$(INTDIR)\fstring.long.splaymap.sbr" \
	"$(INTDIR)\fstring.set.sbr" \
	"$(INTDIR)\fstring.splayset.sbr" \
	"$(INTDIR)\hidxhlp.sbr" \
	"$(INTDIR)\hnode.sbr" \
	"$(INTDIR)\long.longsplayset.map.sbr" \
	"$(INTDIR)\long.longsplayset.splaymap.sbr" \
	"$(INTDIR)\long.set.sbr" \
	"$(INTDIR)\long.splayset.sbr" \
	"$(INTDIR)\long.vhset.sbr" \
	"$(INTDIR)\u_int32_t.caddr_t.map.sbr" \
	"$(INTDIR)\u_int32_t.caddr_t.splaymap.sbr" \
	"$(INTDIR)\u_int32_t.fstring.map.sbr" \
	"$(INTDIR)\u_int32_t.fstring.splaymap.sbr" \
	"$(INTDIR)\u_int32_t.fstring.vhmap.sbr" \
	"$(INTDIR)\u_int32_t.set.sbr" \
	"$(INTDIR)\u_int32_t.splayset.sbr" \
	"$(INTDIR)\u_int32_t.vhset.sbr" \
	"$(INTDIR)\u_int64_t.set.sbr" \
	"$(INTDIR)\u_int64_t.splayset.sbr" \
	"$(INTDIR)\u_int64_t.vhset.sbr" \
	"$(INTDIR)\dbproc.sbr" \
	"$(INTDIR)\dbproc.mf.sbr" \
	"$(INTDIR)\gclog.sbr" \
	"$(INTDIR)\adler32.sbr" \
	"$(INTDIR)\base.sbr" \
	"$(INTDIR)\basemask.sbr" \
	"$(INTDIR)\btiter.sbr" \
	"$(INTDIR)\btree.sbr" \
	"$(INTDIR)\collect.sbr" \
	"$(INTDIR)\crc32.sbr" \
	"$(INTDIR)\deflate.sbr" \
	"$(INTDIR)\doccol.sbr" \
	"$(INTDIR)\dociter.sbr" \
	"$(INTDIR)\document.sbr" \
	"$(INTDIR)\dummies.sbr" \
	"$(INTDIR)\garutils.sbr" \
	"$(INTDIR)\hindex.sbr" \
	"$(INTDIR)\index.sbr" \
	"$(INTDIR)\indices.sbr" \
	"$(INTDIR)\infblock.sbr" \
	"$(INTDIR)\infcodes.sbr" \
	"$(INTDIR)\inffast.sbr" \
	"$(INTDIR)\inflate.sbr" \
	"$(INTDIR)\inftrees.sbr" \
	"$(INTDIR)\infutil.sbr" \
	"$(INTDIR)\ncpf.sbr" \
	"$(INTDIR)\newdoc.sbr" \
	"$(INTDIR)\osdummy.sbr" \
	"$(INTDIR)\pack.sbr" \
	"$(INTDIR)\pagefile.sbr" \
	"$(INTDIR)\refcol.sbr" \
	"$(INTDIR)\stdbase.sbr" \
	"$(INTDIR)\streams.sbr" \
	"$(INTDIR)\trees.sbr" \
	"$(INTDIR)\unzip.sbr" \
	"$(INTDIR)\zutil.sbr" \
	"$(INTDIR)\vapi.sbr" \
	"$(INTDIR)\ctxwords.sbr" \
	"$(INTDIR)\u_int64_t.CtxLongSet.Map.sbr" \
	"$(INTDIR)\u_int64_t.CtxLongSet.SplayMap.sbr" \
	"$(INTDIR)\face.sbr" \
	"$(INTDIR)\gsscreen.sbr" \
	"$(INTDIR)\screen.sbr" \
	"$(INTDIR)\context.sbr" \
	"$(INTDIR)\parser.sbr" \
	"$(INTDIR)\lex_basis.sbr" \
	"$(INTDIR)\lex_operator.sbr" \
	"$(INTDIR)\lex_parser.sbr" \
	"$(INTDIR)\belongs.sbr" \
	"$(INTDIR)\blobtable.sbr" \
	"$(INTDIR)\cacheIndex.sbr" \
	"$(INTDIR)\classes.sbr" \
	"$(INTDIR)\complect.sbr" \
	"$(INTDIR)\dbproc.m-reader.sbr" \
	"$(INTDIR)\dbproc.m-to-gkdb.sbr" \
	"$(INTDIR)\dbproc.m-writer.sbr" \
	"$(INTDIR)\fstringer.sbr" \
	"$(INTDIR)\garcomp.sbr" \
	"$(INTDIR)\gcini.sbr" \
	"$(INTDIR)\gcpass1.sbr" \
	"$(INTDIR)\kwfile.sbr" \
	"$(INTDIR)\loadstringmap.sbr" \
	"$(INTDIR)\MyPipe.sbr" \
	"$(INTDIR)\normfile.sbr" \
	"$(INTDIR)\nsrcparser.sbr" \
	"$(INTDIR)\publish.sbr" \
	"$(INTDIR)\sources.sbr" \
	"$(INTDIR)\sttop.sbr"

"$(OUTDIR)\gc.bsc" : "$(OUTDIR)" $(BSC32_SBRS)
    $(BSC32) @<<
  $(BSC32_FLAGS) $(BSC32_SBRS)
<<

LINK32=link.exe
LINK32_FLAGS=/nologo /stack:0xa00000,0x100000 /subsystem:console /incremental:no /pdb:"$(OUTDIR)\gc.pdb" /machine:I386 /out:"$(OUTDIR)\gc.exe" /fixed:no 
LINK32_OBJS= \
	"$(INTDIR)\advlog.obj" \
	"$(INTDIR)\date.set.obj" \
	"$(INTDIR)\date.splayset.obj" \
	"$(INTDIR)\errhandler.obj" \
	"$(INTDIR)\fstring.caddr_t.map.obj" \
	"$(INTDIR)\fstring.caddr_t.splaymap.obj" \
	"$(INTDIR)\fstring.obj" \
	"$(INTDIR)\fstring.fstring.map.obj" \
	"$(INTDIR)\fstring.fstring.splaymap.obj" \
	"$(INTDIR)\fstring.long.map.obj" \
	"$(INTDIR)\fstring.long.splaymap.obj" \
	"$(INTDIR)\fstring.set.obj" \
	"$(INTDIR)\fstring.splayset.obj" \
	"$(INTDIR)\hidxhlp.obj" \
	"$(INTDIR)\hnode.obj" \
	"$(INTDIR)\long.longsplayset.map.obj" \
	"$(INTDIR)\long.longsplayset.splaymap.obj" \
	"$(INTDIR)\long.set.obj" \
	"$(INTDIR)\long.splayset.obj" \
	"$(INTDIR)\long.vhset.obj" \
	"$(INTDIR)\u_int32_t.caddr_t.map.obj" \
	"$(INTDIR)\u_int32_t.caddr_t.splaymap.obj" \
	"$(INTDIR)\u_int32_t.fstring.map.obj" \
	"$(INTDIR)\u_int32_t.fstring.splaymap.obj" \
	"$(INTDIR)\u_int32_t.fstring.vhmap.obj" \
	"$(INTDIR)\u_int32_t.set.obj" \
	"$(INTDIR)\u_int32_t.splayset.obj" \
	"$(INTDIR)\u_int32_t.vhset.obj" \
	"$(INTDIR)\u_int64_t.set.obj" \
	"$(INTDIR)\u_int64_t.splayset.obj" \
	"$(INTDIR)\u_int64_t.vhset.obj" \
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
	"$(INTDIR)\cacheIndex.obj" \
	"$(INTDIR)\classes.obj" \
	"$(INTDIR)\complect.obj" \
	"$(INTDIR)\dbproc.m-reader.obj" \
	"$(INTDIR)\dbproc.m-to-gkdb.obj" \
	"$(INTDIR)\dbproc.m-writer.obj" \
	"$(INTDIR)\fstringer.obj" \
	"$(INTDIR)\garcomp.obj" \
	"$(INTDIR)\gcini.obj" \
	"$(INTDIR)\gcpass1.obj" \
	"$(INTDIR)\kwfile.obj" \
	"$(INTDIR)\loadstringmap.obj" \
	"$(INTDIR)\MyPipe.obj" \
	"$(INTDIR)\normfile.obj" \
	"$(INTDIR)\nsrcparser.obj" \
	"$(INTDIR)\publish.obj" \
	"$(INTDIR)\sources.obj" \
	"$(INTDIR)\sttop.obj"

"$(OUTDIR)\gc.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"

OUTDIR=.\gcDebugP
INTDIR=.\gcDebugP
# Begin Custom Macros
OutDir=.\gcDebugP
# End Custom Macros

ALL : "$(OUTDIR)\gc.exe" "$(OUTDIR)\gc.bsc"


CLEAN :
	-@erase "$(INTDIR)\adler32.obj"
	-@erase "$(INTDIR)\adler32.sbr"
	-@erase "$(INTDIR)\advlog.obj"
	-@erase "$(INTDIR)\advlog.sbr"
	-@erase "$(INTDIR)\base.obj"
	-@erase "$(INTDIR)\base.sbr"
	-@erase "$(INTDIR)\basemask.obj"
	-@erase "$(INTDIR)\basemask.sbr"
	-@erase "$(INTDIR)\belongs.obj"
	-@erase "$(INTDIR)\belongs.sbr"
	-@erase "$(INTDIR)\blobtable.obj"
	-@erase "$(INTDIR)\blobtable.sbr"
	-@erase "$(INTDIR)\btiter.obj"
	-@erase "$(INTDIR)\btiter.sbr"
	-@erase "$(INTDIR)\btree.obj"
	-@erase "$(INTDIR)\btree.sbr"
	-@erase "$(INTDIR)\cacheIndex.obj"
	-@erase "$(INTDIR)\cacheIndex.sbr"
	-@erase "$(INTDIR)\classes.obj"
	-@erase "$(INTDIR)\classes.sbr"
	-@erase "$(INTDIR)\collect.obj"
	-@erase "$(INTDIR)\collect.sbr"
	-@erase "$(INTDIR)\complect.obj"
	-@erase "$(INTDIR)\complect.sbr"
	-@erase "$(INTDIR)\context.obj"
	-@erase "$(INTDIR)\context.sbr"
	-@erase "$(INTDIR)\crc32.obj"
	-@erase "$(INTDIR)\crc32.sbr"
	-@erase "$(INTDIR)\ctxwords.obj"
	-@erase "$(INTDIR)\ctxwords.sbr"
	-@erase "$(INTDIR)\date.set.obj"
	-@erase "$(INTDIR)\date.set.sbr"
	-@erase "$(INTDIR)\date.splayset.obj"
	-@erase "$(INTDIR)\date.splayset.sbr"
	-@erase "$(INTDIR)\dbproc.m-reader.obj"
	-@erase "$(INTDIR)\dbproc.m-reader.sbr"
	-@erase "$(INTDIR)\dbproc.m-to-gkdb.obj"
	-@erase "$(INTDIR)\dbproc.m-to-gkdb.sbr"
	-@erase "$(INTDIR)\dbproc.m-writer.obj"
	-@erase "$(INTDIR)\dbproc.m-writer.sbr"
	-@erase "$(INTDIR)\dbproc.mf.obj"
	-@erase "$(INTDIR)\dbproc.mf.sbr"
	-@erase "$(INTDIR)\dbproc.obj"
	-@erase "$(INTDIR)\dbproc.sbr"
	-@erase "$(INTDIR)\deflate.obj"
	-@erase "$(INTDIR)\deflate.sbr"
	-@erase "$(INTDIR)\doccol.obj"
	-@erase "$(INTDIR)\doccol.sbr"
	-@erase "$(INTDIR)\dociter.obj"
	-@erase "$(INTDIR)\dociter.sbr"
	-@erase "$(INTDIR)\document.obj"
	-@erase "$(INTDIR)\document.sbr"
	-@erase "$(INTDIR)\dummies.obj"
	-@erase "$(INTDIR)\dummies.sbr"
	-@erase "$(INTDIR)\errhandler.obj"
	-@erase "$(INTDIR)\errhandler.sbr"
	-@erase "$(INTDIR)\face.obj"
	-@erase "$(INTDIR)\face.sbr"
	-@erase "$(INTDIR)\fstring.caddr_t.map.obj"
	-@erase "$(INTDIR)\fstring.caddr_t.map.sbr"
	-@erase "$(INTDIR)\fstring.caddr_t.splaymap.obj"
	-@erase "$(INTDIR)\fstring.caddr_t.splaymap.sbr"
	-@erase "$(INTDIR)\fstring.fstring.map.obj"
	-@erase "$(INTDIR)\fstring.fstring.map.sbr"
	-@erase "$(INTDIR)\fstring.fstring.splaymap.obj"
	-@erase "$(INTDIR)\fstring.fstring.splaymap.sbr"
	-@erase "$(INTDIR)\fstring.long.map.obj"
	-@erase "$(INTDIR)\fstring.long.map.sbr"
	-@erase "$(INTDIR)\fstring.long.splaymap.obj"
	-@erase "$(INTDIR)\fstring.long.splaymap.sbr"
	-@erase "$(INTDIR)\fstring.obj"
	-@erase "$(INTDIR)\fstring.sbr"
	-@erase "$(INTDIR)\fstring.set.obj"
	-@erase "$(INTDIR)\fstring.set.sbr"
	-@erase "$(INTDIR)\fstring.splayset.obj"
	-@erase "$(INTDIR)\fstring.splayset.sbr"
	-@erase "$(INTDIR)\fstringer.obj"
	-@erase "$(INTDIR)\fstringer.sbr"
	-@erase "$(INTDIR)\garcomp.obj"
	-@erase "$(INTDIR)\garcomp.sbr"
	-@erase "$(INTDIR)\garutils.obj"
	-@erase "$(INTDIR)\garutils.sbr"
	-@erase "$(INTDIR)\gcini.obj"
	-@erase "$(INTDIR)\gcini.sbr"
	-@erase "$(INTDIR)\gclog.obj"
	-@erase "$(INTDIR)\gclog.sbr"
	-@erase "$(INTDIR)\gcpass1.obj"
	-@erase "$(INTDIR)\gcpass1.sbr"
	-@erase "$(INTDIR)\gsscreen.obj"
	-@erase "$(INTDIR)\gsscreen.sbr"
	-@erase "$(INTDIR)\hidxhlp.obj"
	-@erase "$(INTDIR)\hidxhlp.sbr"
	-@erase "$(INTDIR)\hindex.obj"
	-@erase "$(INTDIR)\hindex.sbr"
	-@erase "$(INTDIR)\hnode.obj"
	-@erase "$(INTDIR)\hnode.sbr"
	-@erase "$(INTDIR)\index.obj"
	-@erase "$(INTDIR)\index.sbr"
	-@erase "$(INTDIR)\indices.obj"
	-@erase "$(INTDIR)\indices.sbr"
	-@erase "$(INTDIR)\infblock.obj"
	-@erase "$(INTDIR)\infblock.sbr"
	-@erase "$(INTDIR)\infcodes.obj"
	-@erase "$(INTDIR)\infcodes.sbr"
	-@erase "$(INTDIR)\inffast.obj"
	-@erase "$(INTDIR)\inffast.sbr"
	-@erase "$(INTDIR)\inflate.obj"
	-@erase "$(INTDIR)\inflate.sbr"
	-@erase "$(INTDIR)\inftrees.obj"
	-@erase "$(INTDIR)\inftrees.sbr"
	-@erase "$(INTDIR)\infutil.obj"
	-@erase "$(INTDIR)\infutil.sbr"
	-@erase "$(INTDIR)\kwfile.obj"
	-@erase "$(INTDIR)\kwfile.sbr"
	-@erase "$(INTDIR)\lex_basis.obj"
	-@erase "$(INTDIR)\lex_basis.sbr"
	-@erase "$(INTDIR)\lex_operator.obj"
	-@erase "$(INTDIR)\lex_operator.sbr"
	-@erase "$(INTDIR)\lex_parser.obj"
	-@erase "$(INTDIR)\lex_parser.sbr"
	-@erase "$(INTDIR)\loadstringmap.obj"
	-@erase "$(INTDIR)\loadstringmap.sbr"
	-@erase "$(INTDIR)\long.longsplayset.map.obj"
	-@erase "$(INTDIR)\long.longsplayset.map.sbr"
	-@erase "$(INTDIR)\long.longsplayset.splaymap.obj"
	-@erase "$(INTDIR)\long.longsplayset.splaymap.sbr"
	-@erase "$(INTDIR)\long.set.obj"
	-@erase "$(INTDIR)\long.set.sbr"
	-@erase "$(INTDIR)\long.splayset.obj"
	-@erase "$(INTDIR)\long.splayset.sbr"
	-@erase "$(INTDIR)\long.vhset.obj"
	-@erase "$(INTDIR)\long.vhset.sbr"
	-@erase "$(INTDIR)\MyPipe.obj"
	-@erase "$(INTDIR)\MyPipe.sbr"
	-@erase "$(INTDIR)\ncpf.obj"
	-@erase "$(INTDIR)\ncpf.sbr"
	-@erase "$(INTDIR)\newdoc.obj"
	-@erase "$(INTDIR)\newdoc.sbr"
	-@erase "$(INTDIR)\normfile.obj"
	-@erase "$(INTDIR)\normfile.sbr"
	-@erase "$(INTDIR)\nsrcparser.obj"
	-@erase "$(INTDIR)\nsrcparser.sbr"
	-@erase "$(INTDIR)\osdummy.obj"
	-@erase "$(INTDIR)\osdummy.sbr"
	-@erase "$(INTDIR)\pack.obj"
	-@erase "$(INTDIR)\pack.sbr"
	-@erase "$(INTDIR)\pagefile.obj"
	-@erase "$(INTDIR)\pagefile.sbr"
	-@erase "$(INTDIR)\parser.obj"
	-@erase "$(INTDIR)\parser.sbr"
	-@erase "$(INTDIR)\publish.obj"
	-@erase "$(INTDIR)\publish.sbr"
	-@erase "$(INTDIR)\refcol.obj"
	-@erase "$(INTDIR)\refcol.sbr"
	-@erase "$(INTDIR)\screen.obj"
	-@erase "$(INTDIR)\screen.sbr"
	-@erase "$(INTDIR)\sources.obj"
	-@erase "$(INTDIR)\sources.sbr"
	-@erase "$(INTDIR)\stdbase.obj"
	-@erase "$(INTDIR)\stdbase.sbr"
	-@erase "$(INTDIR)\streams.obj"
	-@erase "$(INTDIR)\streams.sbr"
	-@erase "$(INTDIR)\sttop.obj"
	-@erase "$(INTDIR)\sttop.sbr"
	-@erase "$(INTDIR)\trees.obj"
	-@erase "$(INTDIR)\trees.sbr"
	-@erase "$(INTDIR)\u_int32_t.caddr_t.map.obj"
	-@erase "$(INTDIR)\u_int32_t.caddr_t.map.sbr"
	-@erase "$(INTDIR)\u_int32_t.caddr_t.splaymap.obj"
	-@erase "$(INTDIR)\u_int32_t.caddr_t.splaymap.sbr"
	-@erase "$(INTDIR)\u_int32_t.fstring.map.obj"
	-@erase "$(INTDIR)\u_int32_t.fstring.map.sbr"
	-@erase "$(INTDIR)\u_int32_t.fstring.splaymap.obj"
	-@erase "$(INTDIR)\u_int32_t.fstring.splaymap.sbr"
	-@erase "$(INTDIR)\u_int32_t.fstring.vhmap.obj"
	-@erase "$(INTDIR)\u_int32_t.fstring.vhmap.sbr"
	-@erase "$(INTDIR)\u_int32_t.set.obj"
	-@erase "$(INTDIR)\u_int32_t.set.sbr"
	-@erase "$(INTDIR)\u_int32_t.splayset.obj"
	-@erase "$(INTDIR)\u_int32_t.splayset.sbr"
	-@erase "$(INTDIR)\u_int32_t.vhset.obj"
	-@erase "$(INTDIR)\u_int32_t.vhset.sbr"
	-@erase "$(INTDIR)\u_int64_t.CtxLongSet.Map.obj"
	-@erase "$(INTDIR)\u_int64_t.CtxLongSet.Map.sbr"
	-@erase "$(INTDIR)\u_int64_t.CtxLongSet.SplayMap.obj"
	-@erase "$(INTDIR)\u_int64_t.CtxLongSet.SplayMap.sbr"
	-@erase "$(INTDIR)\u_int64_t.set.obj"
	-@erase "$(INTDIR)\u_int64_t.set.sbr"
	-@erase "$(INTDIR)\u_int64_t.splayset.obj"
	-@erase "$(INTDIR)\u_int64_t.splayset.sbr"
	-@erase "$(INTDIR)\u_int64_t.vhset.obj"
	-@erase "$(INTDIR)\u_int64_t.vhset.sbr"
	-@erase "$(INTDIR)\unzip.obj"
	-@erase "$(INTDIR)\unzip.sbr"
	-@erase "$(INTDIR)\vapi.obj"
	-@erase "$(INTDIR)\vapi.sbr"
	-@erase "$(INTDIR)\vc60.idb"
	-@erase "$(INTDIR)\vc60.pdb"
	-@erase "$(INTDIR)\zutil.obj"
	-@erase "$(INTDIR)\zutil.sbr"
	-@erase "$(OUTDIR)\gc.bsc"
	-@erase "$(OUTDIR)\gc.exe"
	-@erase "$(OUTDIR)\gc.ilk"
	-@erase "$(OUTDIR)\gc.pdb"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP=cl.exe
CPP_PROJ=/nologo /G5 /MLd /W3 /Gi /GX /Zi /Od /I "..\..\..\include" /I "..\..\..\include\win32" /I "..\..\..\libs\cchlp\src" /I "..\..\..\libs\gc\src" /I "..\..\..\libs\gkdb\src" /I "..\..\..\libs\gctx\src" /I "..\..\..\libs\gsscreen\src" /I "..\..\..\libs\lex\include" /I "..\..\..\libs\gchange\include" /I "..\..\..\tools\gctools\src" /D "_DEBUG" /D "WIN32" /D "_CONSOLE" /D "_MBCS" /D "WITH_DBL_THREAD" /D "INC_GCTX" /D "AS_PROCESS" /Fr"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

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
BSC32_FLAGS=/nologo /o"$(OUTDIR)\gc.bsc" 
BSC32_SBRS= \
	"$(INTDIR)\advlog.sbr" \
	"$(INTDIR)\date.set.sbr" \
	"$(INTDIR)\date.splayset.sbr" \
	"$(INTDIR)\errhandler.sbr" \
	"$(INTDIR)\fstring.caddr_t.map.sbr" \
	"$(INTDIR)\fstring.caddr_t.splaymap.sbr" \
	"$(INTDIR)\fstring.sbr" \
	"$(INTDIR)\fstring.fstring.map.sbr" \
	"$(INTDIR)\fstring.fstring.splaymap.sbr" \
	"$(INTDIR)\fstring.long.map.sbr" \
	"$(INTDIR)\fstring.long.splaymap.sbr" \
	"$(INTDIR)\fstring.set.sbr" \
	"$(INTDIR)\fstring.splayset.sbr" \
	"$(INTDIR)\hidxhlp.sbr" \
	"$(INTDIR)\hnode.sbr" \
	"$(INTDIR)\long.longsplayset.map.sbr" \
	"$(INTDIR)\long.longsplayset.splaymap.sbr" \
	"$(INTDIR)\long.set.sbr" \
	"$(INTDIR)\long.splayset.sbr" \
	"$(INTDIR)\long.vhset.sbr" \
	"$(INTDIR)\u_int32_t.caddr_t.map.sbr" \
	"$(INTDIR)\u_int32_t.caddr_t.splaymap.sbr" \
	"$(INTDIR)\u_int32_t.fstring.map.sbr" \
	"$(INTDIR)\u_int32_t.fstring.splaymap.sbr" \
	"$(INTDIR)\u_int32_t.fstring.vhmap.sbr" \
	"$(INTDIR)\u_int32_t.set.sbr" \
	"$(INTDIR)\u_int32_t.splayset.sbr" \
	"$(INTDIR)\u_int32_t.vhset.sbr" \
	"$(INTDIR)\u_int64_t.set.sbr" \
	"$(INTDIR)\u_int64_t.splayset.sbr" \
	"$(INTDIR)\u_int64_t.vhset.sbr" \
	"$(INTDIR)\dbproc.sbr" \
	"$(INTDIR)\dbproc.mf.sbr" \
	"$(INTDIR)\gclog.sbr" \
	"$(INTDIR)\adler32.sbr" \
	"$(INTDIR)\base.sbr" \
	"$(INTDIR)\basemask.sbr" \
	"$(INTDIR)\btiter.sbr" \
	"$(INTDIR)\btree.sbr" \
	"$(INTDIR)\collect.sbr" \
	"$(INTDIR)\crc32.sbr" \
	"$(INTDIR)\deflate.sbr" \
	"$(INTDIR)\doccol.sbr" \
	"$(INTDIR)\dociter.sbr" \
	"$(INTDIR)\document.sbr" \
	"$(INTDIR)\dummies.sbr" \
	"$(INTDIR)\garutils.sbr" \
	"$(INTDIR)\hindex.sbr" \
	"$(INTDIR)\index.sbr" \
	"$(INTDIR)\indices.sbr" \
	"$(INTDIR)\infblock.sbr" \
	"$(INTDIR)\infcodes.sbr" \
	"$(INTDIR)\inffast.sbr" \
	"$(INTDIR)\inflate.sbr" \
	"$(INTDIR)\inftrees.sbr" \
	"$(INTDIR)\infutil.sbr" \
	"$(INTDIR)\ncpf.sbr" \
	"$(INTDIR)\newdoc.sbr" \
	"$(INTDIR)\osdummy.sbr" \
	"$(INTDIR)\pack.sbr" \
	"$(INTDIR)\pagefile.sbr" \
	"$(INTDIR)\refcol.sbr" \
	"$(INTDIR)\stdbase.sbr" \
	"$(INTDIR)\streams.sbr" \
	"$(INTDIR)\trees.sbr" \
	"$(INTDIR)\unzip.sbr" \
	"$(INTDIR)\zutil.sbr" \
	"$(INTDIR)\vapi.sbr" \
	"$(INTDIR)\ctxwords.sbr" \
	"$(INTDIR)\u_int64_t.CtxLongSet.Map.sbr" \
	"$(INTDIR)\u_int64_t.CtxLongSet.SplayMap.sbr" \
	"$(INTDIR)\face.sbr" \
	"$(INTDIR)\gsscreen.sbr" \
	"$(INTDIR)\screen.sbr" \
	"$(INTDIR)\context.sbr" \
	"$(INTDIR)\parser.sbr" \
	"$(INTDIR)\lex_basis.sbr" \
	"$(INTDIR)\lex_operator.sbr" \
	"$(INTDIR)\lex_parser.sbr" \
	"$(INTDIR)\belongs.sbr" \
	"$(INTDIR)\blobtable.sbr" \
	"$(INTDIR)\cacheIndex.sbr" \
	"$(INTDIR)\classes.sbr" \
	"$(INTDIR)\complect.sbr" \
	"$(INTDIR)\dbproc.m-reader.sbr" \
	"$(INTDIR)\dbproc.m-to-gkdb.sbr" \
	"$(INTDIR)\dbproc.m-writer.sbr" \
	"$(INTDIR)\fstringer.sbr" \
	"$(INTDIR)\garcomp.sbr" \
	"$(INTDIR)\gcini.sbr" \
	"$(INTDIR)\gcpass1.sbr" \
	"$(INTDIR)\kwfile.sbr" \
	"$(INTDIR)\loadstringmap.sbr" \
	"$(INTDIR)\MyPipe.sbr" \
	"$(INTDIR)\normfile.sbr" \
	"$(INTDIR)\nsrcparser.sbr" \
	"$(INTDIR)\publish.sbr" \
	"$(INTDIR)\sources.sbr" \
	"$(INTDIR)\sttop.sbr"

"$(OUTDIR)\gc.bsc" : "$(OUTDIR)" $(BSC32_SBRS)
    $(BSC32) @<<
  $(BSC32_FLAGS) $(BSC32_SBRS)
<<

LINK32=link.exe
LINK32_FLAGS=advapi32.lib /nologo /stack:0x2000000,0x2000000 /subsystem:console /incremental:yes /pdb:"$(OUTDIR)\gc.pdb" /debug /machine:I386 /out:"$(OUTDIR)\gc.exe" /pdbtype:sept /fixed:no 
LINK32_OBJS= \
	"$(INTDIR)\advlog.obj" \
	"$(INTDIR)\date.set.obj" \
	"$(INTDIR)\date.splayset.obj" \
	"$(INTDIR)\errhandler.obj" \
	"$(INTDIR)\fstring.caddr_t.map.obj" \
	"$(INTDIR)\fstring.caddr_t.splaymap.obj" \
	"$(INTDIR)\fstring.obj" \
	"$(INTDIR)\fstring.fstring.map.obj" \
	"$(INTDIR)\fstring.fstring.splaymap.obj" \
	"$(INTDIR)\fstring.long.map.obj" \
	"$(INTDIR)\fstring.long.splaymap.obj" \
	"$(INTDIR)\fstring.set.obj" \
	"$(INTDIR)\fstring.splayset.obj" \
	"$(INTDIR)\hidxhlp.obj" \
	"$(INTDIR)\hnode.obj" \
	"$(INTDIR)\long.longsplayset.map.obj" \
	"$(INTDIR)\long.longsplayset.splaymap.obj" \
	"$(INTDIR)\long.set.obj" \
	"$(INTDIR)\long.splayset.obj" \
	"$(INTDIR)\long.vhset.obj" \
	"$(INTDIR)\u_int32_t.caddr_t.map.obj" \
	"$(INTDIR)\u_int32_t.caddr_t.splaymap.obj" \
	"$(INTDIR)\u_int32_t.fstring.map.obj" \
	"$(INTDIR)\u_int32_t.fstring.splaymap.obj" \
	"$(INTDIR)\u_int32_t.fstring.vhmap.obj" \
	"$(INTDIR)\u_int32_t.set.obj" \
	"$(INTDIR)\u_int32_t.splayset.obj" \
	"$(INTDIR)\u_int32_t.vhset.obj" \
	"$(INTDIR)\u_int64_t.set.obj" \
	"$(INTDIR)\u_int64_t.splayset.obj" \
	"$(INTDIR)\u_int64_t.vhset.obj" \
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
	"$(INTDIR)\cacheIndex.obj" \
	"$(INTDIR)\classes.obj" \
	"$(INTDIR)\complect.obj" \
	"$(INTDIR)\dbproc.m-reader.obj" \
	"$(INTDIR)\dbproc.m-to-gkdb.obj" \
	"$(INTDIR)\dbproc.m-writer.obj" \
	"$(INTDIR)\fstringer.obj" \
	"$(INTDIR)\garcomp.obj" \
	"$(INTDIR)\gcini.obj" \
	"$(INTDIR)\gcpass1.obj" \
	"$(INTDIR)\kwfile.obj" \
	"$(INTDIR)\loadstringmap.obj" \
	"$(INTDIR)\MyPipe.obj" \
	"$(INTDIR)\normfile.obj" \
	"$(INTDIR)\nsrcparser.obj" \
	"$(INTDIR)\publish.obj" \
	"$(INTDIR)\sources.obj" \
	"$(INTDIR)\sttop.obj"

"$(OUTDIR)\gc.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"

OUTDIR=.\gcReleaseP
INTDIR=.\gcReleaseP
# Begin Custom Macros
OutDir=.\gcReleaseP
# End Custom Macros

ALL : "$(OUTDIR)\gc.exe" "$(OUTDIR)\gc.bsc"


CLEAN :
	-@erase "$(INTDIR)\adler32.obj"
	-@erase "$(INTDIR)\adler32.sbr"
	-@erase "$(INTDIR)\advlog.obj"
	-@erase "$(INTDIR)\advlog.sbr"
	-@erase "$(INTDIR)\base.obj"
	-@erase "$(INTDIR)\base.sbr"
	-@erase "$(INTDIR)\basemask.obj"
	-@erase "$(INTDIR)\basemask.sbr"
	-@erase "$(INTDIR)\belongs.obj"
	-@erase "$(INTDIR)\belongs.sbr"
	-@erase "$(INTDIR)\blobtable.obj"
	-@erase "$(INTDIR)\blobtable.sbr"
	-@erase "$(INTDIR)\btiter.obj"
	-@erase "$(INTDIR)\btiter.sbr"
	-@erase "$(INTDIR)\btree.obj"
	-@erase "$(INTDIR)\btree.sbr"
	-@erase "$(INTDIR)\cacheIndex.obj"
	-@erase "$(INTDIR)\cacheIndex.sbr"
	-@erase "$(INTDIR)\classes.obj"
	-@erase "$(INTDIR)\classes.sbr"
	-@erase "$(INTDIR)\collect.obj"
	-@erase "$(INTDIR)\collect.sbr"
	-@erase "$(INTDIR)\complect.obj"
	-@erase "$(INTDIR)\complect.sbr"
	-@erase "$(INTDIR)\context.obj"
	-@erase "$(INTDIR)\context.sbr"
	-@erase "$(INTDIR)\crc32.obj"
	-@erase "$(INTDIR)\crc32.sbr"
	-@erase "$(INTDIR)\ctxwords.obj"
	-@erase "$(INTDIR)\ctxwords.sbr"
	-@erase "$(INTDIR)\date.set.obj"
	-@erase "$(INTDIR)\date.set.sbr"
	-@erase "$(INTDIR)\date.splayset.obj"
	-@erase "$(INTDIR)\date.splayset.sbr"
	-@erase "$(INTDIR)\dbproc.m-reader.obj"
	-@erase "$(INTDIR)\dbproc.m-reader.sbr"
	-@erase "$(INTDIR)\dbproc.m-to-gkdb.obj"
	-@erase "$(INTDIR)\dbproc.m-to-gkdb.sbr"
	-@erase "$(INTDIR)\dbproc.m-writer.obj"
	-@erase "$(INTDIR)\dbproc.m-writer.sbr"
	-@erase "$(INTDIR)\dbproc.mf.obj"
	-@erase "$(INTDIR)\dbproc.mf.sbr"
	-@erase "$(INTDIR)\dbproc.obj"
	-@erase "$(INTDIR)\dbproc.sbr"
	-@erase "$(INTDIR)\deflate.obj"
	-@erase "$(INTDIR)\deflate.sbr"
	-@erase "$(INTDIR)\doccol.obj"
	-@erase "$(INTDIR)\doccol.sbr"
	-@erase "$(INTDIR)\dociter.obj"
	-@erase "$(INTDIR)\dociter.sbr"
	-@erase "$(INTDIR)\document.obj"
	-@erase "$(INTDIR)\document.sbr"
	-@erase "$(INTDIR)\dummies.obj"
	-@erase "$(INTDIR)\dummies.sbr"
	-@erase "$(INTDIR)\errhandler.obj"
	-@erase "$(INTDIR)\errhandler.sbr"
	-@erase "$(INTDIR)\face.obj"
	-@erase "$(INTDIR)\face.sbr"
	-@erase "$(INTDIR)\fstring.caddr_t.map.obj"
	-@erase "$(INTDIR)\fstring.caddr_t.map.sbr"
	-@erase "$(INTDIR)\fstring.caddr_t.splaymap.obj"
	-@erase "$(INTDIR)\fstring.caddr_t.splaymap.sbr"
	-@erase "$(INTDIR)\fstring.fstring.map.obj"
	-@erase "$(INTDIR)\fstring.fstring.map.sbr"
	-@erase "$(INTDIR)\fstring.fstring.splaymap.obj"
	-@erase "$(INTDIR)\fstring.fstring.splaymap.sbr"
	-@erase "$(INTDIR)\fstring.long.map.obj"
	-@erase "$(INTDIR)\fstring.long.map.sbr"
	-@erase "$(INTDIR)\fstring.long.splaymap.obj"
	-@erase "$(INTDIR)\fstring.long.splaymap.sbr"
	-@erase "$(INTDIR)\fstring.obj"
	-@erase "$(INTDIR)\fstring.sbr"
	-@erase "$(INTDIR)\fstring.set.obj"
	-@erase "$(INTDIR)\fstring.set.sbr"
	-@erase "$(INTDIR)\fstring.splayset.obj"
	-@erase "$(INTDIR)\fstring.splayset.sbr"
	-@erase "$(INTDIR)\fstringer.obj"
	-@erase "$(INTDIR)\fstringer.sbr"
	-@erase "$(INTDIR)\garcomp.obj"
	-@erase "$(INTDIR)\garcomp.sbr"
	-@erase "$(INTDIR)\garutils.obj"
	-@erase "$(INTDIR)\garutils.sbr"
	-@erase "$(INTDIR)\gcini.obj"
	-@erase "$(INTDIR)\gcini.sbr"
	-@erase "$(INTDIR)\gclog.obj"
	-@erase "$(INTDIR)\gclog.sbr"
	-@erase "$(INTDIR)\gcpass1.obj"
	-@erase "$(INTDIR)\gcpass1.sbr"
	-@erase "$(INTDIR)\gsscreen.obj"
	-@erase "$(INTDIR)\gsscreen.sbr"
	-@erase "$(INTDIR)\hidxhlp.obj"
	-@erase "$(INTDIR)\hidxhlp.sbr"
	-@erase "$(INTDIR)\hindex.obj"
	-@erase "$(INTDIR)\hindex.sbr"
	-@erase "$(INTDIR)\hnode.obj"
	-@erase "$(INTDIR)\hnode.sbr"
	-@erase "$(INTDIR)\index.obj"
	-@erase "$(INTDIR)\index.sbr"
	-@erase "$(INTDIR)\indices.obj"
	-@erase "$(INTDIR)\indices.sbr"
	-@erase "$(INTDIR)\infblock.obj"
	-@erase "$(INTDIR)\infblock.sbr"
	-@erase "$(INTDIR)\infcodes.obj"
	-@erase "$(INTDIR)\infcodes.sbr"
	-@erase "$(INTDIR)\inffast.obj"
	-@erase "$(INTDIR)\inffast.sbr"
	-@erase "$(INTDIR)\inflate.obj"
	-@erase "$(INTDIR)\inflate.sbr"
	-@erase "$(INTDIR)\inftrees.obj"
	-@erase "$(INTDIR)\inftrees.sbr"
	-@erase "$(INTDIR)\infutil.obj"
	-@erase "$(INTDIR)\infutil.sbr"
	-@erase "$(INTDIR)\kwfile.obj"
	-@erase "$(INTDIR)\kwfile.sbr"
	-@erase "$(INTDIR)\lex_basis.obj"
	-@erase "$(INTDIR)\lex_basis.sbr"
	-@erase "$(INTDIR)\lex_operator.obj"
	-@erase "$(INTDIR)\lex_operator.sbr"
	-@erase "$(INTDIR)\lex_parser.obj"
	-@erase "$(INTDIR)\lex_parser.sbr"
	-@erase "$(INTDIR)\loadstringmap.obj"
	-@erase "$(INTDIR)\loadstringmap.sbr"
	-@erase "$(INTDIR)\long.longsplayset.map.obj"
	-@erase "$(INTDIR)\long.longsplayset.map.sbr"
	-@erase "$(INTDIR)\long.longsplayset.splaymap.obj"
	-@erase "$(INTDIR)\long.longsplayset.splaymap.sbr"
	-@erase "$(INTDIR)\long.set.obj"
	-@erase "$(INTDIR)\long.set.sbr"
	-@erase "$(INTDIR)\long.splayset.obj"
	-@erase "$(INTDIR)\long.splayset.sbr"
	-@erase "$(INTDIR)\long.vhset.obj"
	-@erase "$(INTDIR)\long.vhset.sbr"
	-@erase "$(INTDIR)\MyPipe.obj"
	-@erase "$(INTDIR)\MyPipe.sbr"
	-@erase "$(INTDIR)\ncpf.obj"
	-@erase "$(INTDIR)\ncpf.sbr"
	-@erase "$(INTDIR)\newdoc.obj"
	-@erase "$(INTDIR)\newdoc.sbr"
	-@erase "$(INTDIR)\normfile.obj"
	-@erase "$(INTDIR)\normfile.sbr"
	-@erase "$(INTDIR)\nsrcparser.obj"
	-@erase "$(INTDIR)\nsrcparser.sbr"
	-@erase "$(INTDIR)\osdummy.obj"
	-@erase "$(INTDIR)\osdummy.sbr"
	-@erase "$(INTDIR)\pack.obj"
	-@erase "$(INTDIR)\pack.sbr"
	-@erase "$(INTDIR)\pagefile.obj"
	-@erase "$(INTDIR)\pagefile.sbr"
	-@erase "$(INTDIR)\parser.obj"
	-@erase "$(INTDIR)\parser.sbr"
	-@erase "$(INTDIR)\publish.obj"
	-@erase "$(INTDIR)\publish.sbr"
	-@erase "$(INTDIR)\refcol.obj"
	-@erase "$(INTDIR)\refcol.sbr"
	-@erase "$(INTDIR)\screen.obj"
	-@erase "$(INTDIR)\screen.sbr"
	-@erase "$(INTDIR)\sources.obj"
	-@erase "$(INTDIR)\sources.sbr"
	-@erase "$(INTDIR)\stdbase.obj"
	-@erase "$(INTDIR)\stdbase.sbr"
	-@erase "$(INTDIR)\streams.obj"
	-@erase "$(INTDIR)\streams.sbr"
	-@erase "$(INTDIR)\sttop.obj"
	-@erase "$(INTDIR)\sttop.sbr"
	-@erase "$(INTDIR)\trees.obj"
	-@erase "$(INTDIR)\trees.sbr"
	-@erase "$(INTDIR)\u_int32_t.caddr_t.map.obj"
	-@erase "$(INTDIR)\u_int32_t.caddr_t.map.sbr"
	-@erase "$(INTDIR)\u_int32_t.caddr_t.splaymap.obj"
	-@erase "$(INTDIR)\u_int32_t.caddr_t.splaymap.sbr"
	-@erase "$(INTDIR)\u_int32_t.fstring.map.obj"
	-@erase "$(INTDIR)\u_int32_t.fstring.map.sbr"
	-@erase "$(INTDIR)\u_int32_t.fstring.splaymap.obj"
	-@erase "$(INTDIR)\u_int32_t.fstring.splaymap.sbr"
	-@erase "$(INTDIR)\u_int32_t.fstring.vhmap.obj"
	-@erase "$(INTDIR)\u_int32_t.fstring.vhmap.sbr"
	-@erase "$(INTDIR)\u_int32_t.set.obj"
	-@erase "$(INTDIR)\u_int32_t.set.sbr"
	-@erase "$(INTDIR)\u_int32_t.splayset.obj"
	-@erase "$(INTDIR)\u_int32_t.splayset.sbr"
	-@erase "$(INTDIR)\u_int32_t.vhset.obj"
	-@erase "$(INTDIR)\u_int32_t.vhset.sbr"
	-@erase "$(INTDIR)\u_int64_t.CtxLongSet.Map.obj"
	-@erase "$(INTDIR)\u_int64_t.CtxLongSet.Map.sbr"
	-@erase "$(INTDIR)\u_int64_t.CtxLongSet.SplayMap.obj"
	-@erase "$(INTDIR)\u_int64_t.CtxLongSet.SplayMap.sbr"
	-@erase "$(INTDIR)\u_int64_t.set.obj"
	-@erase "$(INTDIR)\u_int64_t.set.sbr"
	-@erase "$(INTDIR)\u_int64_t.splayset.obj"
	-@erase "$(INTDIR)\u_int64_t.splayset.sbr"
	-@erase "$(INTDIR)\u_int64_t.vhset.obj"
	-@erase "$(INTDIR)\u_int64_t.vhset.sbr"
	-@erase "$(INTDIR)\unzip.obj"
	-@erase "$(INTDIR)\unzip.sbr"
	-@erase "$(INTDIR)\vapi.obj"
	-@erase "$(INTDIR)\vapi.sbr"
	-@erase "$(INTDIR)\vc60.idb"
	-@erase "$(INTDIR)\zutil.obj"
	-@erase "$(INTDIR)\zutil.sbr"
	-@erase "$(OUTDIR)\gc.bsc"
	-@erase "$(OUTDIR)\gc.exe"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP=cl.exe
CPP_PROJ=/nologo /G5 /ML /W3 /Gi /GX /O2 /I "..\..\..\include" /I "..\..\..\include\win32" /I "..\..\..\libs\cchlp\src" /I "..\..\..\libs\gc\src" /I "..\..\..\libs\gkdb\src" /I "..\..\..\libs\gctx\src" /I "..\..\..\libs\gsscreen\src" /I "..\..\..\libs\lex\include" /I "..\..\..\libs\gchange\include" /I "..\..\..\tools\gctools\src" /D "NDEBUG" /D "WIN32" /D "_CONSOLE" /D "_MBCS" /D "WITH_DBL_THREAD" /D "INC_GCTX" /D "AS_PROCESS" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

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
BSC32_FLAGS=/nologo /o"$(OUTDIR)\gc.bsc" 
BSC32_SBRS= \
	"$(INTDIR)\advlog.sbr" \
	"$(INTDIR)\date.set.sbr" \
	"$(INTDIR)\date.splayset.sbr" \
	"$(INTDIR)\errhandler.sbr" \
	"$(INTDIR)\fstring.caddr_t.map.sbr" \
	"$(INTDIR)\fstring.caddr_t.splaymap.sbr" \
	"$(INTDIR)\fstring.sbr" \
	"$(INTDIR)\fstring.fstring.map.sbr" \
	"$(INTDIR)\fstring.fstring.splaymap.sbr" \
	"$(INTDIR)\fstring.long.map.sbr" \
	"$(INTDIR)\fstring.long.splaymap.sbr" \
	"$(INTDIR)\fstring.set.sbr" \
	"$(INTDIR)\fstring.splayset.sbr" \
	"$(INTDIR)\hidxhlp.sbr" \
	"$(INTDIR)\hnode.sbr" \
	"$(INTDIR)\long.longsplayset.map.sbr" \
	"$(INTDIR)\long.longsplayset.splaymap.sbr" \
	"$(INTDIR)\long.set.sbr" \
	"$(INTDIR)\long.splayset.sbr" \
	"$(INTDIR)\long.vhset.sbr" \
	"$(INTDIR)\u_int32_t.caddr_t.map.sbr" \
	"$(INTDIR)\u_int32_t.caddr_t.splaymap.sbr" \
	"$(INTDIR)\u_int32_t.fstring.map.sbr" \
	"$(INTDIR)\u_int32_t.fstring.splaymap.sbr" \
	"$(INTDIR)\u_int32_t.fstring.vhmap.sbr" \
	"$(INTDIR)\u_int32_t.set.sbr" \
	"$(INTDIR)\u_int32_t.splayset.sbr" \
	"$(INTDIR)\u_int32_t.vhset.sbr" \
	"$(INTDIR)\u_int64_t.set.sbr" \
	"$(INTDIR)\u_int64_t.splayset.sbr" \
	"$(INTDIR)\u_int64_t.vhset.sbr" \
	"$(INTDIR)\dbproc.sbr" \
	"$(INTDIR)\dbproc.mf.sbr" \
	"$(INTDIR)\gclog.sbr" \
	"$(INTDIR)\adler32.sbr" \
	"$(INTDIR)\base.sbr" \
	"$(INTDIR)\basemask.sbr" \
	"$(INTDIR)\btiter.sbr" \
	"$(INTDIR)\btree.sbr" \
	"$(INTDIR)\collect.sbr" \
	"$(INTDIR)\crc32.sbr" \
	"$(INTDIR)\deflate.sbr" \
	"$(INTDIR)\doccol.sbr" \
	"$(INTDIR)\dociter.sbr" \
	"$(INTDIR)\document.sbr" \
	"$(INTDIR)\dummies.sbr" \
	"$(INTDIR)\garutils.sbr" \
	"$(INTDIR)\hindex.sbr" \
	"$(INTDIR)\index.sbr" \
	"$(INTDIR)\indices.sbr" \
	"$(INTDIR)\infblock.sbr" \
	"$(INTDIR)\infcodes.sbr" \
	"$(INTDIR)\inffast.sbr" \
	"$(INTDIR)\inflate.sbr" \
	"$(INTDIR)\inftrees.sbr" \
	"$(INTDIR)\infutil.sbr" \
	"$(INTDIR)\ncpf.sbr" \
	"$(INTDIR)\newdoc.sbr" \
	"$(INTDIR)\osdummy.sbr" \
	"$(INTDIR)\pack.sbr" \
	"$(INTDIR)\pagefile.sbr" \
	"$(INTDIR)\refcol.sbr" \
	"$(INTDIR)\stdbase.sbr" \
	"$(INTDIR)\streams.sbr" \
	"$(INTDIR)\trees.sbr" \
	"$(INTDIR)\unzip.sbr" \
	"$(INTDIR)\zutil.sbr" \
	"$(INTDIR)\vapi.sbr" \
	"$(INTDIR)\ctxwords.sbr" \
	"$(INTDIR)\u_int64_t.CtxLongSet.Map.sbr" \
	"$(INTDIR)\u_int64_t.CtxLongSet.SplayMap.sbr" \
	"$(INTDIR)\face.sbr" \
	"$(INTDIR)\gsscreen.sbr" \
	"$(INTDIR)\screen.sbr" \
	"$(INTDIR)\context.sbr" \
	"$(INTDIR)\parser.sbr" \
	"$(INTDIR)\lex_basis.sbr" \
	"$(INTDIR)\lex_operator.sbr" \
	"$(INTDIR)\lex_parser.sbr" \
	"$(INTDIR)\belongs.sbr" \
	"$(INTDIR)\blobtable.sbr" \
	"$(INTDIR)\cacheIndex.sbr" \
	"$(INTDIR)\classes.sbr" \
	"$(INTDIR)\complect.sbr" \
	"$(INTDIR)\dbproc.m-reader.sbr" \
	"$(INTDIR)\dbproc.m-to-gkdb.sbr" \
	"$(INTDIR)\dbproc.m-writer.sbr" \
	"$(INTDIR)\fstringer.sbr" \
	"$(INTDIR)\garcomp.sbr" \
	"$(INTDIR)\gcini.sbr" \
	"$(INTDIR)\gcpass1.sbr" \
	"$(INTDIR)\kwfile.sbr" \
	"$(INTDIR)\loadstringmap.sbr" \
	"$(INTDIR)\MyPipe.sbr" \
	"$(INTDIR)\normfile.sbr" \
	"$(INTDIR)\nsrcparser.sbr" \
	"$(INTDIR)\publish.sbr" \
	"$(INTDIR)\sources.sbr" \
	"$(INTDIR)\sttop.sbr"

"$(OUTDIR)\gc.bsc" : "$(OUTDIR)" $(BSC32_SBRS)
    $(BSC32) @<<
  $(BSC32_FLAGS) $(BSC32_SBRS)
<<

LINK32=link.exe
LINK32_FLAGS=advapi32.lib /nologo /stack:0x2000000,0x2000000 /subsystem:console /incremental:no /pdb:"$(OUTDIR)\gc.pdb" /machine:I386 /out:"$(OUTDIR)\gc.exe" /fixed:no 
LINK32_OBJS= \
	"$(INTDIR)\advlog.obj" \
	"$(INTDIR)\date.set.obj" \
	"$(INTDIR)\date.splayset.obj" \
	"$(INTDIR)\errhandler.obj" \
	"$(INTDIR)\fstring.caddr_t.map.obj" \
	"$(INTDIR)\fstring.caddr_t.splaymap.obj" \
	"$(INTDIR)\fstring.obj" \
	"$(INTDIR)\fstring.fstring.map.obj" \
	"$(INTDIR)\fstring.fstring.splaymap.obj" \
	"$(INTDIR)\fstring.long.map.obj" \
	"$(INTDIR)\fstring.long.splaymap.obj" \
	"$(INTDIR)\fstring.set.obj" \
	"$(INTDIR)\fstring.splayset.obj" \
	"$(INTDIR)\hidxhlp.obj" \
	"$(INTDIR)\hnode.obj" \
	"$(INTDIR)\long.longsplayset.map.obj" \
	"$(INTDIR)\long.longsplayset.splaymap.obj" \
	"$(INTDIR)\long.set.obj" \
	"$(INTDIR)\long.splayset.obj" \
	"$(INTDIR)\long.vhset.obj" \
	"$(INTDIR)\u_int32_t.caddr_t.map.obj" \
	"$(INTDIR)\u_int32_t.caddr_t.splaymap.obj" \
	"$(INTDIR)\u_int32_t.fstring.map.obj" \
	"$(INTDIR)\u_int32_t.fstring.splaymap.obj" \
	"$(INTDIR)\u_int32_t.fstring.vhmap.obj" \
	"$(INTDIR)\u_int32_t.set.obj" \
	"$(INTDIR)\u_int32_t.splayset.obj" \
	"$(INTDIR)\u_int32_t.vhset.obj" \
	"$(INTDIR)\u_int64_t.set.obj" \
	"$(INTDIR)\u_int64_t.splayset.obj" \
	"$(INTDIR)\u_int64_t.vhset.obj" \
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
	"$(INTDIR)\cacheIndex.obj" \
	"$(INTDIR)\classes.obj" \
	"$(INTDIR)\complect.obj" \
	"$(INTDIR)\dbproc.m-reader.obj" \
	"$(INTDIR)\dbproc.m-to-gkdb.obj" \
	"$(INTDIR)\dbproc.m-writer.obj" \
	"$(INTDIR)\fstringer.obj" \
	"$(INTDIR)\garcomp.obj" \
	"$(INTDIR)\gcini.obj" \
	"$(INTDIR)\gcpass1.obj" \
	"$(INTDIR)\kwfile.obj" \
	"$(INTDIR)\loadstringmap.obj" \
	"$(INTDIR)\MyPipe.obj" \
	"$(INTDIR)\normfile.obj" \
	"$(INTDIR)\nsrcparser.obj" \
	"$(INTDIR)\publish.obj" \
	"$(INTDIR)\sources.obj" \
	"$(INTDIR)\sttop.obj"

"$(OUTDIR)\gc.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ENDIF 


!IF "$(NO_EXTERNAL_DEPS)" != "1"
!IF EXISTS("gc.dep")
!INCLUDE "gc.dep"
!ELSE 
!MESSAGE Warning: cannot find "gc.dep"
!ENDIF 
!ENDIF 


!IF "$(CFG)" == "gc - Win32 Release" || "$(CFG)" == "gc - Win32 Debug" || "$(CFG)" == "gc - Win32 Debug_Old" || "$(CFG)" == "gc - Win32 Release_Old" || "$(CFG)" == "gc - Win32 DebugP" || "$(CFG)" == "gc - Win32 ReleaseP"
SOURCE=..\..\..\libs\cchlp\src\advlog.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\advlog.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\advlog.obj"	"$(INTDIR)\advlog.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\advlog.obj"	"$(INTDIR)\advlog.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\advlog.obj"	"$(INTDIR)\advlog.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\advlog.obj"	"$(INTDIR)\advlog.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\advlog.obj"	"$(INTDIR)\advlog.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\cchlp\src\date.set.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\date.set.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\date.set.obj"	"$(INTDIR)\date.set.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\date.set.obj"	"$(INTDIR)\date.set.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\date.set.obj"	"$(INTDIR)\date.set.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\date.set.obj"	"$(INTDIR)\date.set.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\date.set.obj"	"$(INTDIR)\date.set.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\cchlp\src\date.splayset.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\date.splayset.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\date.splayset.obj"	"$(INTDIR)\date.splayset.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\date.splayset.obj"	"$(INTDIR)\date.splayset.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\date.splayset.obj"	"$(INTDIR)\date.splayset.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\date.splayset.obj"	"$(INTDIR)\date.splayset.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\date.splayset.obj"	"$(INTDIR)\date.splayset.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\cchlp\src\errhandler.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\errhandler.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\errhandler.obj"	"$(INTDIR)\errhandler.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\errhandler.obj"	"$(INTDIR)\errhandler.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\errhandler.obj"	"$(INTDIR)\errhandler.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\errhandler.obj"	"$(INTDIR)\errhandler.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\errhandler.obj"	"$(INTDIR)\errhandler.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\cchlp\src\fstring.caddr_t.map.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\fstring.caddr_t.map.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\fstring.caddr_t.map.obj"	"$(INTDIR)\fstring.caddr_t.map.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\fstring.caddr_t.map.obj"	"$(INTDIR)\fstring.caddr_t.map.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\fstring.caddr_t.map.obj"	"$(INTDIR)\fstring.caddr_t.map.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\fstring.caddr_t.map.obj"	"$(INTDIR)\fstring.caddr_t.map.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\fstring.caddr_t.map.obj"	"$(INTDIR)\fstring.caddr_t.map.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\cchlp\src\fstring.caddr_t.splaymap.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\fstring.caddr_t.splaymap.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\fstring.caddr_t.splaymap.obj"	"$(INTDIR)\fstring.caddr_t.splaymap.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\fstring.caddr_t.splaymap.obj"	"$(INTDIR)\fstring.caddr_t.splaymap.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\fstring.caddr_t.splaymap.obj"	"$(INTDIR)\fstring.caddr_t.splaymap.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\fstring.caddr_t.splaymap.obj"	"$(INTDIR)\fstring.caddr_t.splaymap.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\fstring.caddr_t.splaymap.obj"	"$(INTDIR)\fstring.caddr_t.splaymap.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\cchlp\src\fstring.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\fstring.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\fstring.obj"	"$(INTDIR)\fstring.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\fstring.obj"	"$(INTDIR)\fstring.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\fstring.obj"	"$(INTDIR)\fstring.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\fstring.obj"	"$(INTDIR)\fstring.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\fstring.obj"	"$(INTDIR)\fstring.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\cchlp\src\fstring.fstring.map.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\fstring.fstring.map.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\fstring.fstring.map.obj"	"$(INTDIR)\fstring.fstring.map.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\fstring.fstring.map.obj"	"$(INTDIR)\fstring.fstring.map.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\fstring.fstring.map.obj"	"$(INTDIR)\fstring.fstring.map.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\fstring.fstring.map.obj"	"$(INTDIR)\fstring.fstring.map.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\fstring.fstring.map.obj"	"$(INTDIR)\fstring.fstring.map.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\cchlp\src\fstring.fstring.splaymap.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\fstring.fstring.splaymap.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\fstring.fstring.splaymap.obj"	"$(INTDIR)\fstring.fstring.splaymap.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\fstring.fstring.splaymap.obj"	"$(INTDIR)\fstring.fstring.splaymap.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\fstring.fstring.splaymap.obj"	"$(INTDIR)\fstring.fstring.splaymap.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\fstring.fstring.splaymap.obj"	"$(INTDIR)\fstring.fstring.splaymap.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\fstring.fstring.splaymap.obj"	"$(INTDIR)\fstring.fstring.splaymap.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\cchlp\src\fstring.long.map.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\fstring.long.map.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\fstring.long.map.obj"	"$(INTDIR)\fstring.long.map.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\fstring.long.map.obj"	"$(INTDIR)\fstring.long.map.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\fstring.long.map.obj"	"$(INTDIR)\fstring.long.map.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\fstring.long.map.obj"	"$(INTDIR)\fstring.long.map.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\fstring.long.map.obj"	"$(INTDIR)\fstring.long.map.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\cchlp\src\fstring.long.splaymap.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\fstring.long.splaymap.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\fstring.long.splaymap.obj"	"$(INTDIR)\fstring.long.splaymap.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\fstring.long.splaymap.obj"	"$(INTDIR)\fstring.long.splaymap.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\fstring.long.splaymap.obj"	"$(INTDIR)\fstring.long.splaymap.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\fstring.long.splaymap.obj"	"$(INTDIR)\fstring.long.splaymap.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\fstring.long.splaymap.obj"	"$(INTDIR)\fstring.long.splaymap.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\cchlp\src\fstring.set.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\fstring.set.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\fstring.set.obj"	"$(INTDIR)\fstring.set.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\fstring.set.obj"	"$(INTDIR)\fstring.set.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\fstring.set.obj"	"$(INTDIR)\fstring.set.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\fstring.set.obj"	"$(INTDIR)\fstring.set.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\fstring.set.obj"	"$(INTDIR)\fstring.set.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\cchlp\src\fstring.splayset.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\fstring.splayset.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\fstring.splayset.obj"	"$(INTDIR)\fstring.splayset.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\fstring.splayset.obj"	"$(INTDIR)\fstring.splayset.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\fstring.splayset.obj"	"$(INTDIR)\fstring.splayset.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\fstring.splayset.obj"	"$(INTDIR)\fstring.splayset.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\fstring.splayset.obj"	"$(INTDIR)\fstring.splayset.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\cchlp\src\hidxhlp.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\hidxhlp.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\hidxhlp.obj"	"$(INTDIR)\hidxhlp.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\hidxhlp.obj"	"$(INTDIR)\hidxhlp.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\hidxhlp.obj"	"$(INTDIR)\hidxhlp.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\hidxhlp.obj"	"$(INTDIR)\hidxhlp.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\hidxhlp.obj"	"$(INTDIR)\hidxhlp.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\cchlp\src\hnode.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\hnode.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\hnode.obj"	"$(INTDIR)\hnode.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\hnode.obj"	"$(INTDIR)\hnode.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\hnode.obj"	"$(INTDIR)\hnode.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\hnode.obj"	"$(INTDIR)\hnode.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\hnode.obj"	"$(INTDIR)\hnode.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\cchlp\src\long.longsplayset.map.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\long.longsplayset.map.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\long.longsplayset.map.obj"	"$(INTDIR)\long.longsplayset.map.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\long.longsplayset.map.obj"	"$(INTDIR)\long.longsplayset.map.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\long.longsplayset.map.obj"	"$(INTDIR)\long.longsplayset.map.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\long.longsplayset.map.obj"	"$(INTDIR)\long.longsplayset.map.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\long.longsplayset.map.obj"	"$(INTDIR)\long.longsplayset.map.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\cchlp\src\long.longsplayset.splaymap.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\long.longsplayset.splaymap.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\long.longsplayset.splaymap.obj"	"$(INTDIR)\long.longsplayset.splaymap.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\long.longsplayset.splaymap.obj"	"$(INTDIR)\long.longsplayset.splaymap.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\long.longsplayset.splaymap.obj"	"$(INTDIR)\long.longsplayset.splaymap.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\long.longsplayset.splaymap.obj"	"$(INTDIR)\long.longsplayset.splaymap.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\long.longsplayset.splaymap.obj"	"$(INTDIR)\long.longsplayset.splaymap.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\cchlp\src\long.set.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\long.set.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\long.set.obj"	"$(INTDIR)\long.set.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\long.set.obj"	"$(INTDIR)\long.set.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\long.set.obj"	"$(INTDIR)\long.set.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\long.set.obj"	"$(INTDIR)\long.set.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\long.set.obj"	"$(INTDIR)\long.set.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\cchlp\src\long.splayset.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\long.splayset.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\long.splayset.obj"	"$(INTDIR)\long.splayset.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\long.splayset.obj"	"$(INTDIR)\long.splayset.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\long.splayset.obj"	"$(INTDIR)\long.splayset.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\long.splayset.obj"	"$(INTDIR)\long.splayset.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\long.splayset.obj"	"$(INTDIR)\long.splayset.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\cchlp\src\long.vhset.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\long.vhset.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\long.vhset.obj"	"$(INTDIR)\long.vhset.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\long.vhset.obj"	"$(INTDIR)\long.vhset.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\long.vhset.obj"	"$(INTDIR)\long.vhset.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\long.vhset.obj"	"$(INTDIR)\long.vhset.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\long.vhset.obj"	"$(INTDIR)\long.vhset.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\cchlp\src\u_int32_t.caddr_t.map.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\u_int32_t.caddr_t.map.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\u_int32_t.caddr_t.map.obj"	"$(INTDIR)\u_int32_t.caddr_t.map.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\u_int32_t.caddr_t.map.obj"	"$(INTDIR)\u_int32_t.caddr_t.map.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\u_int32_t.caddr_t.map.obj"	"$(INTDIR)\u_int32_t.caddr_t.map.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\u_int32_t.caddr_t.map.obj"	"$(INTDIR)\u_int32_t.caddr_t.map.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\u_int32_t.caddr_t.map.obj"	"$(INTDIR)\u_int32_t.caddr_t.map.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\cchlp\src\u_int32_t.caddr_t.splaymap.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\u_int32_t.caddr_t.splaymap.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\u_int32_t.caddr_t.splaymap.obj"	"$(INTDIR)\u_int32_t.caddr_t.splaymap.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\u_int32_t.caddr_t.splaymap.obj"	"$(INTDIR)\u_int32_t.caddr_t.splaymap.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\u_int32_t.caddr_t.splaymap.obj"	"$(INTDIR)\u_int32_t.caddr_t.splaymap.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\u_int32_t.caddr_t.splaymap.obj"	"$(INTDIR)\u_int32_t.caddr_t.splaymap.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\u_int32_t.caddr_t.splaymap.obj"	"$(INTDIR)\u_int32_t.caddr_t.splaymap.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\cchlp\src\u_int32_t.fstring.map.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\u_int32_t.fstring.map.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\u_int32_t.fstring.map.obj"	"$(INTDIR)\u_int32_t.fstring.map.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\u_int32_t.fstring.map.obj"	"$(INTDIR)\u_int32_t.fstring.map.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\u_int32_t.fstring.map.obj"	"$(INTDIR)\u_int32_t.fstring.map.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\u_int32_t.fstring.map.obj"	"$(INTDIR)\u_int32_t.fstring.map.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\u_int32_t.fstring.map.obj"	"$(INTDIR)\u_int32_t.fstring.map.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\cchlp\src\u_int32_t.fstring.splaymap.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\u_int32_t.fstring.splaymap.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\u_int32_t.fstring.splaymap.obj"	"$(INTDIR)\u_int32_t.fstring.splaymap.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\u_int32_t.fstring.splaymap.obj"	"$(INTDIR)\u_int32_t.fstring.splaymap.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\u_int32_t.fstring.splaymap.obj"	"$(INTDIR)\u_int32_t.fstring.splaymap.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\u_int32_t.fstring.splaymap.obj"	"$(INTDIR)\u_int32_t.fstring.splaymap.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\u_int32_t.fstring.splaymap.obj"	"$(INTDIR)\u_int32_t.fstring.splaymap.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\cchlp\src\u_int32_t.fstring.vhmap.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\u_int32_t.fstring.vhmap.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\u_int32_t.fstring.vhmap.obj"	"$(INTDIR)\u_int32_t.fstring.vhmap.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\u_int32_t.fstring.vhmap.obj"	"$(INTDIR)\u_int32_t.fstring.vhmap.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\u_int32_t.fstring.vhmap.obj"	"$(INTDIR)\u_int32_t.fstring.vhmap.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\u_int32_t.fstring.vhmap.obj"	"$(INTDIR)\u_int32_t.fstring.vhmap.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\u_int32_t.fstring.vhmap.obj"	"$(INTDIR)\u_int32_t.fstring.vhmap.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\cchlp\src\u_int32_t.set.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\u_int32_t.set.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\u_int32_t.set.obj"	"$(INTDIR)\u_int32_t.set.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\u_int32_t.set.obj"	"$(INTDIR)\u_int32_t.set.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\u_int32_t.set.obj"	"$(INTDIR)\u_int32_t.set.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\u_int32_t.set.obj"	"$(INTDIR)\u_int32_t.set.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\u_int32_t.set.obj"	"$(INTDIR)\u_int32_t.set.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\cchlp\src\u_int32_t.splayset.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\u_int32_t.splayset.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\u_int32_t.splayset.obj"	"$(INTDIR)\u_int32_t.splayset.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\u_int32_t.splayset.obj"	"$(INTDIR)\u_int32_t.splayset.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\u_int32_t.splayset.obj"	"$(INTDIR)\u_int32_t.splayset.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\u_int32_t.splayset.obj"	"$(INTDIR)\u_int32_t.splayset.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\u_int32_t.splayset.obj"	"$(INTDIR)\u_int32_t.splayset.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\cchlp\src\u_int32_t.vhset.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\u_int32_t.vhset.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\u_int32_t.vhset.obj"	"$(INTDIR)\u_int32_t.vhset.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\u_int32_t.vhset.obj"	"$(INTDIR)\u_int32_t.vhset.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\u_int32_t.vhset.obj"	"$(INTDIR)\u_int32_t.vhset.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\u_int32_t.vhset.obj"	"$(INTDIR)\u_int32_t.vhset.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\u_int32_t.vhset.obj"	"$(INTDIR)\u_int32_t.vhset.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\cchlp\src\u_int64_t.set.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\u_int64_t.set.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\u_int64_t.set.obj"	"$(INTDIR)\u_int64_t.set.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\u_int64_t.set.obj"	"$(INTDIR)\u_int64_t.set.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\u_int64_t.set.obj"	"$(INTDIR)\u_int64_t.set.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\u_int64_t.set.obj"	"$(INTDIR)\u_int64_t.set.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\u_int64_t.set.obj"	"$(INTDIR)\u_int64_t.set.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\cchlp\src\u_int64_t.splayset.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\u_int64_t.splayset.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\u_int64_t.splayset.obj"	"$(INTDIR)\u_int64_t.splayset.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\u_int64_t.splayset.obj"	"$(INTDIR)\u_int64_t.splayset.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\u_int64_t.splayset.obj"	"$(INTDIR)\u_int64_t.splayset.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\u_int64_t.splayset.obj"	"$(INTDIR)\u_int64_t.splayset.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\u_int64_t.splayset.obj"	"$(INTDIR)\u_int64_t.splayset.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\cchlp\src\u_int64_t.vhset.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\u_int64_t.vhset.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\u_int64_t.vhset.obj"	"$(INTDIR)\u_int64_t.vhset.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\u_int64_t.vhset.obj"	"$(INTDIR)\u_int64_t.vhset.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\u_int64_t.vhset.obj"	"$(INTDIR)\u_int64_t.vhset.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\u_int64_t.vhset.obj"	"$(INTDIR)\u_int64_t.vhset.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\u_int64_t.vhset.obj"	"$(INTDIR)\u_int64_t.vhset.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gc\src\dbproc.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\dbproc.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\dbproc.obj"	"$(INTDIR)\dbproc.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\dbproc.obj"	"$(INTDIR)\dbproc.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\dbproc.obj"	"$(INTDIR)\dbproc.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\dbproc.obj"	"$(INTDIR)\dbproc.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\dbproc.obj"	"$(INTDIR)\dbproc.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gc\src\dbproc.mf.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\dbproc.mf.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\dbproc.mf.obj"	"$(INTDIR)\dbproc.mf.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\dbproc.mf.obj"	"$(INTDIR)\dbproc.mf.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\dbproc.mf.obj"	"$(INTDIR)\dbproc.mf.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\dbproc.mf.obj"	"$(INTDIR)\dbproc.mf.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\dbproc.mf.obj"	"$(INTDIR)\dbproc.mf.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gc\src\gclog.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\gclog.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\gclog.obj"	"$(INTDIR)\gclog.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\gclog.obj"	"$(INTDIR)\gclog.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\gclog.obj"	"$(INTDIR)\gclog.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\gclog.obj"	"$(INTDIR)\gclog.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\gclog.obj"	"$(INTDIR)\gclog.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\adler32.c

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\adler32.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\adler32.obj"	"$(INTDIR)\adler32.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\adler32.obj"	"$(INTDIR)\adler32.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\adler32.obj"	"$(INTDIR)\adler32.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\adler32.obj"	"$(INTDIR)\adler32.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\adler32.obj"	"$(INTDIR)\adler32.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\base.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\base.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\base.obj"	"$(INTDIR)\base.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\base.obj"	"$(INTDIR)\base.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\base.obj"	"$(INTDIR)\base.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\base.obj"	"$(INTDIR)\base.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\base.obj"	"$(INTDIR)\base.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\basemask.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\basemask.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\basemask.obj"	"$(INTDIR)\basemask.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\basemask.obj"	"$(INTDIR)\basemask.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\basemask.obj"	"$(INTDIR)\basemask.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\basemask.obj"	"$(INTDIR)\basemask.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\basemask.obj"	"$(INTDIR)\basemask.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\btiter.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\btiter.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\btiter.obj"	"$(INTDIR)\btiter.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\btiter.obj"	"$(INTDIR)\btiter.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\btiter.obj"	"$(INTDIR)\btiter.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\btiter.obj"	"$(INTDIR)\btiter.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\btiter.obj"	"$(INTDIR)\btiter.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\btree.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\btree.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\btree.obj"	"$(INTDIR)\btree.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\btree.obj"	"$(INTDIR)\btree.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\btree.obj"	"$(INTDIR)\btree.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\btree.obj"	"$(INTDIR)\btree.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\btree.obj"	"$(INTDIR)\btree.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\collect.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\collect.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\collect.obj"	"$(INTDIR)\collect.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\collect.obj"	"$(INTDIR)\collect.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\collect.obj"	"$(INTDIR)\collect.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\collect.obj"	"$(INTDIR)\collect.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\collect.obj"	"$(INTDIR)\collect.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\crc32.c

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\crc32.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\crc32.obj"	"$(INTDIR)\crc32.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\crc32.obj"	"$(INTDIR)\crc32.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\crc32.obj"	"$(INTDIR)\crc32.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\crc32.obj"	"$(INTDIR)\crc32.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\crc32.obj"	"$(INTDIR)\crc32.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\deflate.c

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\deflate.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\deflate.obj"	"$(INTDIR)\deflate.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\deflate.obj"	"$(INTDIR)\deflate.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\deflate.obj"	"$(INTDIR)\deflate.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\deflate.obj"	"$(INTDIR)\deflate.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\deflate.obj"	"$(INTDIR)\deflate.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\doccol.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\doccol.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\doccol.obj"	"$(INTDIR)\doccol.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\doccol.obj"	"$(INTDIR)\doccol.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\doccol.obj"	"$(INTDIR)\doccol.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\doccol.obj"	"$(INTDIR)\doccol.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\doccol.obj"	"$(INTDIR)\doccol.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\dociter.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\dociter.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\dociter.obj"	"$(INTDIR)\dociter.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\dociter.obj"	"$(INTDIR)\dociter.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\dociter.obj"	"$(INTDIR)\dociter.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\dociter.obj"	"$(INTDIR)\dociter.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\dociter.obj"	"$(INTDIR)\dociter.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\document.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\document.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\document.obj"	"$(INTDIR)\document.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\document.obj"	"$(INTDIR)\document.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\document.obj"	"$(INTDIR)\document.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\document.obj"	"$(INTDIR)\document.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\document.obj"	"$(INTDIR)\document.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\dummies.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\dummies.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\dummies.obj"	"$(INTDIR)\dummies.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\dummies.obj"	"$(INTDIR)\dummies.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\dummies.obj"	"$(INTDIR)\dummies.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\dummies.obj"	"$(INTDIR)\dummies.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\dummies.obj"	"$(INTDIR)\dummies.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\garutils.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\garutils.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\garutils.obj"	"$(INTDIR)\garutils.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\garutils.obj"	"$(INTDIR)\garutils.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\garutils.obj"	"$(INTDIR)\garutils.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\garutils.obj"	"$(INTDIR)\garutils.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\garutils.obj"	"$(INTDIR)\garutils.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\hindex.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\hindex.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\hindex.obj"	"$(INTDIR)\hindex.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\hindex.obj"	"$(INTDIR)\hindex.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\hindex.obj"	"$(INTDIR)\hindex.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\hindex.obj"	"$(INTDIR)\hindex.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\hindex.obj"	"$(INTDIR)\hindex.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\index.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\index.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\index.obj"	"$(INTDIR)\index.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\index.obj"	"$(INTDIR)\index.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\index.obj"	"$(INTDIR)\index.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\index.obj"	"$(INTDIR)\index.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\index.obj"	"$(INTDIR)\index.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\indices.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\indices.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\indices.obj"	"$(INTDIR)\indices.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\indices.obj"	"$(INTDIR)\indices.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\indices.obj"	"$(INTDIR)\indices.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\indices.obj"	"$(INTDIR)\indices.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\indices.obj"	"$(INTDIR)\indices.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\infblock.c

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\infblock.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\infblock.obj"	"$(INTDIR)\infblock.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\infblock.obj"	"$(INTDIR)\infblock.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\infblock.obj"	"$(INTDIR)\infblock.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\infblock.obj"	"$(INTDIR)\infblock.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\infblock.obj"	"$(INTDIR)\infblock.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\infcodes.c

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\infcodes.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\infcodes.obj"	"$(INTDIR)\infcodes.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\infcodes.obj"	"$(INTDIR)\infcodes.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\infcodes.obj"	"$(INTDIR)\infcodes.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\infcodes.obj"	"$(INTDIR)\infcodes.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\infcodes.obj"	"$(INTDIR)\infcodes.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\inffast.c

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\inffast.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\inffast.obj"	"$(INTDIR)\inffast.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\inffast.obj"	"$(INTDIR)\inffast.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\inffast.obj"	"$(INTDIR)\inffast.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\inffast.obj"	"$(INTDIR)\inffast.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\inffast.obj"	"$(INTDIR)\inffast.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\inflate.c

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\inflate.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\inflate.obj"	"$(INTDIR)\inflate.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\inflate.obj"	"$(INTDIR)\inflate.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\inflate.obj"	"$(INTDIR)\inflate.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\inflate.obj"	"$(INTDIR)\inflate.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\inflate.obj"	"$(INTDIR)\inflate.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\inftrees.c

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\inftrees.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\inftrees.obj"	"$(INTDIR)\inftrees.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\inftrees.obj"	"$(INTDIR)\inftrees.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\inftrees.obj"	"$(INTDIR)\inftrees.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\inftrees.obj"	"$(INTDIR)\inftrees.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\inftrees.obj"	"$(INTDIR)\inftrees.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\infutil.c

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\infutil.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\infutil.obj"	"$(INTDIR)\infutil.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\infutil.obj"	"$(INTDIR)\infutil.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\infutil.obj"	"$(INTDIR)\infutil.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\infutil.obj"	"$(INTDIR)\infutil.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\infutil.obj"	"$(INTDIR)\infutil.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\ncpf.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\ncpf.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\ncpf.obj"	"$(INTDIR)\ncpf.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\ncpf.obj"	"$(INTDIR)\ncpf.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\ncpf.obj"	"$(INTDIR)\ncpf.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\ncpf.obj"	"$(INTDIR)\ncpf.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\ncpf.obj"	"$(INTDIR)\ncpf.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\newdoc.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\newdoc.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\newdoc.obj"	"$(INTDIR)\newdoc.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\newdoc.obj"	"$(INTDIR)\newdoc.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\newdoc.obj"	"$(INTDIR)\newdoc.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\newdoc.obj"	"$(INTDIR)\newdoc.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\newdoc.obj"	"$(INTDIR)\newdoc.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\osdummy.c

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\osdummy.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\osdummy.obj"	"$(INTDIR)\osdummy.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\osdummy.obj"	"$(INTDIR)\osdummy.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\osdummy.obj"	"$(INTDIR)\osdummy.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\osdummy.obj"	"$(INTDIR)\osdummy.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\osdummy.obj"	"$(INTDIR)\osdummy.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\pack.c

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\pack.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\pack.obj"	"$(INTDIR)\pack.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\pack.obj"	"$(INTDIR)\pack.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\pack.obj"	"$(INTDIR)\pack.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\pack.obj"	"$(INTDIR)\pack.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\pack.obj"	"$(INTDIR)\pack.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\pagefile.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\pagefile.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\pagefile.obj"	"$(INTDIR)\pagefile.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\pagefile.obj"	"$(INTDIR)\pagefile.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\pagefile.obj"	"$(INTDIR)\pagefile.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\pagefile.obj"	"$(INTDIR)\pagefile.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\pagefile.obj"	"$(INTDIR)\pagefile.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\refcol.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\refcol.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\refcol.obj"	"$(INTDIR)\refcol.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\refcol.obj"	"$(INTDIR)\refcol.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\refcol.obj"	"$(INTDIR)\refcol.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\refcol.obj"	"$(INTDIR)\refcol.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\refcol.obj"	"$(INTDIR)\refcol.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\stdbase.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\stdbase.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\stdbase.obj"	"$(INTDIR)\stdbase.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\stdbase.obj"	"$(INTDIR)\stdbase.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\stdbase.obj"	"$(INTDIR)\stdbase.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\stdbase.obj"	"$(INTDIR)\stdbase.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\stdbase.obj"	"$(INTDIR)\stdbase.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\streams.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\streams.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\streams.obj"	"$(INTDIR)\streams.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\streams.obj"	"$(INTDIR)\streams.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\streams.obj"	"$(INTDIR)\streams.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\streams.obj"	"$(INTDIR)\streams.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\streams.obj"	"$(INTDIR)\streams.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\trees.c

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\trees.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\trees.obj"	"$(INTDIR)\trees.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\trees.obj"	"$(INTDIR)\trees.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\trees.obj"	"$(INTDIR)\trees.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\trees.obj"	"$(INTDIR)\trees.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\trees.obj"	"$(INTDIR)\trees.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\unzip.c

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\unzip.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\unzip.obj"	"$(INTDIR)\unzip.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\unzip.obj"	"$(INTDIR)\unzip.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\unzip.obj"	"$(INTDIR)\unzip.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\unzip.obj"	"$(INTDIR)\unzip.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\unzip.obj"	"$(INTDIR)\unzip.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\zutil.c

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\zutil.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\zutil.obj"	"$(INTDIR)\zutil.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\zutil.obj"	"$(INTDIR)\zutil.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\zutil.obj"	"$(INTDIR)\zutil.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\zutil.obj"	"$(INTDIR)\zutil.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\zutil.obj"	"$(INTDIR)\zutil.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\vcontrol\src\vapi.c

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\vapi.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\vapi.obj"	"$(INTDIR)\vapi.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\vapi.obj"	"$(INTDIR)\vapi.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\vapi.obj"	"$(INTDIR)\vapi.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\vapi.obj"	"$(INTDIR)\vapi.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\vapi.obj"	"$(INTDIR)\vapi.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gctx\src\ctxwords.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\ctxwords.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\ctxwords.obj"	"$(INTDIR)\ctxwords.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\ctxwords.obj"	"$(INTDIR)\ctxwords.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\ctxwords.obj"	"$(INTDIR)\ctxwords.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\ctxwords.obj"	"$(INTDIR)\ctxwords.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\ctxwords.obj"	"$(INTDIR)\ctxwords.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gctx\src\u_int64_t.CtxLongSet.Map.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\u_int64_t.CtxLongSet.Map.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\u_int64_t.CtxLongSet.Map.obj"	"$(INTDIR)\u_int64_t.CtxLongSet.Map.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\u_int64_t.CtxLongSet.Map.obj"	"$(INTDIR)\u_int64_t.CtxLongSet.Map.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\u_int64_t.CtxLongSet.Map.obj"	"$(INTDIR)\u_int64_t.CtxLongSet.Map.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\u_int64_t.CtxLongSet.Map.obj"	"$(INTDIR)\u_int64_t.CtxLongSet.Map.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\u_int64_t.CtxLongSet.Map.obj"	"$(INTDIR)\u_int64_t.CtxLongSet.Map.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gctx\src\u_int64_t.CtxLongSet.SplayMap.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\u_int64_t.CtxLongSet.SplayMap.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\u_int64_t.CtxLongSet.SplayMap.obj"	"$(INTDIR)\u_int64_t.CtxLongSet.SplayMap.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\u_int64_t.CtxLongSet.SplayMap.obj"	"$(INTDIR)\u_int64_t.CtxLongSet.SplayMap.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\u_int64_t.CtxLongSet.SplayMap.obj"	"$(INTDIR)\u_int64_t.CtxLongSet.SplayMap.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\u_int64_t.CtxLongSet.SplayMap.obj"	"$(INTDIR)\u_int64_t.CtxLongSet.SplayMap.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\u_int64_t.CtxLongSet.SplayMap.obj"	"$(INTDIR)\u_int64_t.CtxLongSet.SplayMap.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gsscreen\src\face.c

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\face.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\face.obj"	"$(INTDIR)\face.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\face.obj"	"$(INTDIR)\face.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\face.obj"	"$(INTDIR)\face.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\face.obj"	"$(INTDIR)\face.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\face.obj"	"$(INTDIR)\face.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gsscreen\src\gsscreen.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\gsscreen.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\gsscreen.obj"	"$(INTDIR)\gsscreen.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\gsscreen.obj"	"$(INTDIR)\gsscreen.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\gsscreen.obj"	"$(INTDIR)\gsscreen.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\gsscreen.obj"	"$(INTDIR)\gsscreen.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\gsscreen.obj"	"$(INTDIR)\gsscreen.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gsscreen\src\screen.c

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\screen.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\screen.obj"	"$(INTDIR)\screen.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\screen.obj"	"$(INTDIR)\screen.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\screen.obj"	"$(INTDIR)\screen.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\screen.obj"	"$(INTDIR)\screen.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\screen.obj"	"$(INTDIR)\screen.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gchange\src\context.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\context.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\context.obj"	"$(INTDIR)\context.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\context.obj"	"$(INTDIR)\context.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\context.obj"	"$(INTDIR)\context.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\context.obj"	"$(INTDIR)\context.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\context.obj"	"$(INTDIR)\context.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gchange\src\parser.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\parser.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\parser.obj"	"$(INTDIR)\parser.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\parser.obj"	"$(INTDIR)\parser.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\parser.obj"	"$(INTDIR)\parser.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\parser.obj"	"$(INTDIR)\parser.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\parser.obj"	"$(INTDIR)\parser.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\lex\src\lex_basis.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\lex_basis.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\lex_basis.obj"	"$(INTDIR)\lex_basis.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\lex_basis.obj"	"$(INTDIR)\lex_basis.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\lex_basis.obj"	"$(INTDIR)\lex_basis.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\lex_basis.obj"	"$(INTDIR)\lex_basis.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\lex_basis.obj"	"$(INTDIR)\lex_basis.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\lex\src\lex_operator.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\lex_operator.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\lex_operator.obj"	"$(INTDIR)\lex_operator.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\lex_operator.obj"	"$(INTDIR)\lex_operator.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\lex_operator.obj"	"$(INTDIR)\lex_operator.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\lex_operator.obj"	"$(INTDIR)\lex_operator.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\lex_operator.obj"	"$(INTDIR)\lex_operator.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\lex\src\lex_parser.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\lex_parser.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\lex_parser.obj"	"$(INTDIR)\lex_parser.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\lex_parser.obj"	"$(INTDIR)\lex_parser.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\lex_parser.obj"	"$(INTDIR)\lex_parser.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\lex_parser.obj"	"$(INTDIR)\lex_parser.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\lex_parser.obj"	"$(INTDIR)\lex_parser.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\gctools\src\belongs.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\belongs.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\belongs.obj"	"$(INTDIR)\belongs.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\belongs.obj"	"$(INTDIR)\belongs.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\belongs.obj"	"$(INTDIR)\belongs.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\belongs.obj"	"$(INTDIR)\belongs.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\belongs.obj"	"$(INTDIR)\belongs.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\gctools\src\blobtable.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\blobtable.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\blobtable.obj"	"$(INTDIR)\blobtable.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\blobtable.obj"	"$(INTDIR)\blobtable.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\blobtable.obj"	"$(INTDIR)\blobtable.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\blobtable.obj"	"$(INTDIR)\blobtable.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\blobtable.obj"	"$(INTDIR)\blobtable.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\gctools\src\cacheIndex.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\cacheIndex.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\cacheIndex.obj"	"$(INTDIR)\cacheIndex.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\cacheIndex.obj"	"$(INTDIR)\cacheIndex.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\cacheIndex.obj"	"$(INTDIR)\cacheIndex.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\cacheIndex.obj"	"$(INTDIR)\cacheIndex.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\cacheIndex.obj"	"$(INTDIR)\cacheIndex.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\gctools\src\classes.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\classes.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\classes.obj"	"$(INTDIR)\classes.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\classes.obj"	"$(INTDIR)\classes.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\classes.obj"	"$(INTDIR)\classes.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\classes.obj"	"$(INTDIR)\classes.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\classes.obj"	"$(INTDIR)\classes.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\gctools\src\complect.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\complect.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\complect.obj"	"$(INTDIR)\complect.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\complect.obj"	"$(INTDIR)\complect.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\complect.obj"	"$(INTDIR)\complect.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\complect.obj"	"$(INTDIR)\complect.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\complect.obj"	"$(INTDIR)\complect.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE="..\..\gctools\src\dbproc.m-reader.cpp"

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\dbproc.m-reader.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\dbproc.m-reader.obj"	"$(INTDIR)\dbproc.m-reader.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\dbproc.m-reader.obj"	"$(INTDIR)\dbproc.m-reader.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\dbproc.m-reader.obj"	"$(INTDIR)\dbproc.m-reader.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\dbproc.m-reader.obj"	"$(INTDIR)\dbproc.m-reader.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\dbproc.m-reader.obj"	"$(INTDIR)\dbproc.m-reader.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE="..\..\gctools\src\dbproc.m-to-gkdb.cpp"

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\dbproc.m-to-gkdb.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\dbproc.m-to-gkdb.obj"	"$(INTDIR)\dbproc.m-to-gkdb.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\dbproc.m-to-gkdb.obj"	"$(INTDIR)\dbproc.m-to-gkdb.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\dbproc.m-to-gkdb.obj"	"$(INTDIR)\dbproc.m-to-gkdb.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\dbproc.m-to-gkdb.obj"	"$(INTDIR)\dbproc.m-to-gkdb.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\dbproc.m-to-gkdb.obj"	"$(INTDIR)\dbproc.m-to-gkdb.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE="..\..\gctools\src\dbproc.m-writer.cpp"

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\dbproc.m-writer.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\dbproc.m-writer.obj"	"$(INTDIR)\dbproc.m-writer.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\dbproc.m-writer.obj"	"$(INTDIR)\dbproc.m-writer.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\dbproc.m-writer.obj"	"$(INTDIR)\dbproc.m-writer.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\dbproc.m-writer.obj"	"$(INTDIR)\dbproc.m-writer.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\dbproc.m-writer.obj"	"$(INTDIR)\dbproc.m-writer.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\gctools\src\fstringer.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\fstringer.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\fstringer.obj"	"$(INTDIR)\fstringer.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\fstringer.obj"	"$(INTDIR)\fstringer.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\fstringer.obj"	"$(INTDIR)\fstringer.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\fstringer.obj"	"$(INTDIR)\fstringer.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\fstringer.obj"	"$(INTDIR)\fstringer.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\src\garcomp.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\garcomp.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\garcomp.obj"	"$(INTDIR)\garcomp.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\garcomp.obj"	"$(INTDIR)\garcomp.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\garcomp.obj"	"$(INTDIR)\garcomp.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\garcomp.obj"	"$(INTDIR)\garcomp.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\garcomp.obj"	"$(INTDIR)\garcomp.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\gctools\src\gcini.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\gcini.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\gcini.obj"	"$(INTDIR)\gcini.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\gcini.obj"	"$(INTDIR)\gcini.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\gcini.obj"	"$(INTDIR)\gcini.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\gcini.obj"	"$(INTDIR)\gcini.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\gcini.obj"	"$(INTDIR)\gcini.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\gctools\src\gcpass1.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\gcpass1.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\gcpass1.obj"	"$(INTDIR)\gcpass1.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\gcpass1.obj"	"$(INTDIR)\gcpass1.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\gcpass1.obj"	"$(INTDIR)\gcpass1.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\gcpass1.obj"	"$(INTDIR)\gcpass1.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\gcpass1.obj"	"$(INTDIR)\gcpass1.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\gctools\src\kwfile.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\kwfile.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\kwfile.obj"	"$(INTDIR)\kwfile.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\kwfile.obj"	"$(INTDIR)\kwfile.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\kwfile.obj"	"$(INTDIR)\kwfile.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\kwfile.obj"	"$(INTDIR)\kwfile.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\kwfile.obj"	"$(INTDIR)\kwfile.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\gctools\src\loadstringmap.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\loadstringmap.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\loadstringmap.obj"	"$(INTDIR)\loadstringmap.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\loadstringmap.obj"	"$(INTDIR)\loadstringmap.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\loadstringmap.obj"	"$(INTDIR)\loadstringmap.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\loadstringmap.obj"	"$(INTDIR)\loadstringmap.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\loadstringmap.obj"	"$(INTDIR)\loadstringmap.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\gctools\src\MyPipe.c

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\MyPipe.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\MyPipe.obj"	"$(INTDIR)\MyPipe.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\MyPipe.obj"	"$(INTDIR)\MyPipe.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\MyPipe.obj"	"$(INTDIR)\MyPipe.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\MyPipe.obj"	"$(INTDIR)\MyPipe.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\MyPipe.obj"	"$(INTDIR)\MyPipe.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\gctools\src\normfile.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\normfile.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\normfile.obj"	"$(INTDIR)\normfile.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\normfile.obj"	"$(INTDIR)\normfile.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\normfile.obj"	"$(INTDIR)\normfile.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\normfile.obj"	"$(INTDIR)\normfile.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\normfile.obj"	"$(INTDIR)\normfile.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\gctools\src\nsrcheck.cpp
SOURCE=..\..\gctools\src\nsrcparser.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\nsrcparser.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\nsrcparser.obj"	"$(INTDIR)\nsrcparser.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\nsrcparser.obj"	"$(INTDIR)\nsrcparser.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\nsrcparser.obj"	"$(INTDIR)\nsrcparser.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\nsrcparser.obj"	"$(INTDIR)\nsrcparser.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\nsrcparser.obj"	"$(INTDIR)\nsrcparser.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\gctools\src\publish.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\publish.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\publish.obj"	"$(INTDIR)\publish.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\publish.obj"	"$(INTDIR)\publish.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\publish.obj"	"$(INTDIR)\publish.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\publish.obj"	"$(INTDIR)\publish.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\publish.obj"	"$(INTDIR)\publish.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\gctools\src\sources.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\sources.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\sources.obj"	"$(INTDIR)\sources.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\sources.obj"	"$(INTDIR)\sources.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\sources.obj"	"$(INTDIR)\sources.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\sources.obj"	"$(INTDIR)\sources.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\sources.obj"	"$(INTDIR)\sources.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\gctools\src\sttop.cpp

!IF  "$(CFG)" == "gc - Win32 Release"


"$(INTDIR)\sttop.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug"


"$(INTDIR)\sttop.obj"	"$(INTDIR)\sttop.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Debug_Old"


"$(INTDIR)\sttop.obj"	"$(INTDIR)\sttop.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 Release_Old"


"$(INTDIR)\sttop.obj"	"$(INTDIR)\sttop.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 DebugP"


"$(INTDIR)\sttop.obj"	"$(INTDIR)\sttop.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gc - Win32 ReleaseP"


"$(INTDIR)\sttop.obj"	"$(INTDIR)\sttop.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 


!ENDIF 

