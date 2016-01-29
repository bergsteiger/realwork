# Microsoft Developer Studio Generated NMAKE File, Based on mf2gardb.dsp
!IF "$(CFG)" == ""
CFG=mf2gardb - Win32 Debug
!MESSAGE No configuration specified. Defaulting to mf2gardb - Win32 Debug.
!ENDIF 

!IF "$(CFG)" != "mf2gardb - Win32 Release" && "$(CFG)" != "mf2gardb - Win32 Debug"
!MESSAGE Invalid configuration "$(CFG)" specified.
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "mf2gardb.mak" CFG="mf2gardb - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "mf2gardb - Win32 Release" (based on "Win32 (x86) Console Application")
!MESSAGE "mf2gardb - Win32 Debug" (based on "Win32 (x86) Console Application")
!MESSAGE 
!ERROR An invalid configuration is specified.
!ENDIF 

!IF "$(OS)" == "Windows_NT"
NULL=
!ELSE 
NULL=nul
!ENDIF 

CPP=xicl6.exe
RSC=rc.exe

!IF  "$(CFG)" == "mf2gardb - Win32 Release"

OUTDIR=.\Release
INTDIR=.\Release
# Begin Custom Macros
OutDir=.\Release
# End Custom Macros

ALL : "$(OUTDIR)\mf2gardb.exe"


CLEAN :
	-@erase "$(INTDIR)\adler32.obj"
	-@erase "$(INTDIR)\base.obj"
	-@erase "$(INTDIR)\basemask.obj"
	-@erase "$(INTDIR)\btiter.obj"
	-@erase "$(INTDIR)\btree.obj"
	-@erase "$(INTDIR)\cacheIndex.obj"
	-@erase "$(INTDIR)\collect.obj"
	-@erase "$(INTDIR)\context.obj"
	-@erase "$(INTDIR)\dbproc.m-reader.obj"
	-@erase "$(INTDIR)\dbproc.m-to-gkdb.obj"
	-@erase "$(INTDIR)\dbproc.mf.obj"
	-@erase "$(INTDIR)\dbproc.obj"
	-@erase "$(INTDIR)\deflate.obj"
	-@erase "$(INTDIR)\doccol.obj"
	-@erase "$(INTDIR)\document.obj"
	-@erase "$(INTDIR)\dummies.obj"
	-@erase "$(INTDIR)\errhandler.obj"
	-@erase "$(INTDIR)\face.obj"
	-@erase "$(INTDIR)\fstring.caddr_t.map.obj"
	-@erase "$(INTDIR)\fstring.caddr_t.splaymap.obj"
	-@erase "$(INTDIR)\fstring.set.obj"
	-@erase "$(INTDIR)\fstring.splayset.obj"
	-@erase "$(INTDIR)\garutils.obj"
	-@erase "$(INTDIR)\gsscreen.obj"
	-@erase "$(INTDIR)\hidxhlp.obj"
	-@erase "$(INTDIR)\hindex.obj"
	-@erase "$(INTDIR)\index.obj"
	-@erase "$(INTDIR)\indices.obj"
	-@erase "$(INTDIR)\infblock.obj"
	-@erase "$(INTDIR)\infcodes.obj"
	-@erase "$(INTDIR)\inffast.obj"
	-@erase "$(INTDIR)\inflate.obj"
	-@erase "$(INTDIR)\inftrees.obj"
	-@erase "$(INTDIR)\infutil.obj"
	-@erase "$(INTDIR)\lex_basis.obj"
	-@erase "$(INTDIR)\lex_operator.obj"
	-@erase "$(INTDIR)\lex_parser.obj"
	-@erase "$(INTDIR)\mf2gardb.obj"
	-@erase "$(INTDIR)\ncpf.obj"
	-@erase "$(INTDIR)\newdoc.obj"
	-@erase "$(INTDIR)\osdummy.obj"
	-@erase "$(INTDIR)\pack.obj"
	-@erase "$(INTDIR)\pagefile.obj"
	-@erase "$(INTDIR)\parser.obj"
	-@erase "$(INTDIR)\refcol.obj"
	-@erase "$(INTDIR)\screen.obj"
	-@erase "$(INTDIR)\stdbase.obj"
	-@erase "$(INTDIR)\streams.obj"
	-@erase "$(INTDIR)\trees.obj"
	-@erase "$(INTDIR)\u_int32_t.caddr_t.map.obj"
	-@erase "$(INTDIR)\u_int32_t.caddr_t.splaymap.obj"
	-@erase "$(INTDIR)\u_int32_t.set.obj"
	-@erase "$(INTDIR)\u_int32_t.splayset.obj"
	-@erase "$(INTDIR)\unzip.obj"
	-@erase "$(INTDIR)\vapi.obj"
	-@erase "$(INTDIR)\vc60.idb"
	-@erase "$(INTDIR)\zutil.obj"
	-@erase "$(OUTDIR)\mf2gardb.exe"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP_PROJ=/nologo /ML /W3 /WX /Gi /GX /O2 /I "..\..\..\include" /I "..\..\..\include\win32" /I "..\..\..\libs\cchlp\src" /I "..\..\..\libs\gc\src" /I "..\..\..\libs\gchange\include" /I "..\..\..\libs\gkdb\src" /I "..\..\..\libs\gsscreen\src" /I "..\..\..\libs\lex\include" /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\mf2gardb.bsc" 
BSC32_SBRS= \
	
LINK32=xilink6.exe
LINK32_FLAGS=oldnames.lib kernel32.lib libc.lib libcp.lib /nologo /stack:0xa00000,0x100000 /subsystem:console /incremental:no /pdb:"$(OUTDIR)\mf2gardb.pdb" /machine:I386 /nodefaultlib /out:"$(OUTDIR)\mf2gardb.exe" /fixed:no 
LINK32_OBJS= \
	"$(INTDIR)\errhandler.obj" \
	"$(INTDIR)\fstring.caddr_t.map.obj" \
	"$(INTDIR)\fstring.caddr_t.splaymap.obj" \
	"$(INTDIR)\fstring.set.obj" \
	"$(INTDIR)\fstring.splayset.obj" \
	"$(INTDIR)\hidxhlp.obj" \
	"$(INTDIR)\u_int32_t.caddr_t.map.obj" \
	"$(INTDIR)\u_int32_t.caddr_t.splaymap.obj" \
	"$(INTDIR)\u_int32_t.set.obj" \
	"$(INTDIR)\u_int32_t.splayset.obj" \
	"$(INTDIR)\dbproc.obj" \
	"$(INTDIR)\dbproc.mf.obj" \
	"$(INTDIR)\context.obj" \
	"$(INTDIR)\parser.obj" \
	"$(INTDIR)\adler32.obj" \
	"$(INTDIR)\base.obj" \
	"$(INTDIR)\basemask.obj" \
	"$(INTDIR)\btiter.obj" \
	"$(INTDIR)\btree.obj" \
	"$(INTDIR)\collect.obj" \
	"$(INTDIR)\deflate.obj" \
	"$(INTDIR)\doccol.obj" \
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
	"$(INTDIR)\face.obj" \
	"$(INTDIR)\gsscreen.obj" \
	"$(INTDIR)\screen.obj" \
	"$(INTDIR)\lex_basis.obj" \
	"$(INTDIR)\lex_operator.obj" \
	"$(INTDIR)\lex_parser.obj" \
	"$(INTDIR)\vapi.obj" \
	"$(INTDIR)\cacheIndex.obj" \
	"$(INTDIR)\dbproc.m-reader.obj" \
	"$(INTDIR)\dbproc.m-to-gkdb.obj" \
	"$(INTDIR)\mf2gardb.obj"

"$(OUTDIR)\mf2gardb.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ELSEIF  "$(CFG)" == "mf2gardb - Win32 Debug"

OUTDIR=.\Debug
INTDIR=.\Debug
# Begin Custom Macros
OutDir=.\Debug
# End Custom Macros

ALL : "$(OUTDIR)\mf2gardb.exe"


CLEAN :
	-@erase "$(INTDIR)\adler32.obj"
	-@erase "$(INTDIR)\base.obj"
	-@erase "$(INTDIR)\basemask.obj"
	-@erase "$(INTDIR)\btiter.obj"
	-@erase "$(INTDIR)\btree.obj"
	-@erase "$(INTDIR)\cacheIndex.obj"
	-@erase "$(INTDIR)\collect.obj"
	-@erase "$(INTDIR)\context.obj"
	-@erase "$(INTDIR)\dbproc.m-reader.obj"
	-@erase "$(INTDIR)\dbproc.m-to-gkdb.obj"
	-@erase "$(INTDIR)\dbproc.mf.obj"
	-@erase "$(INTDIR)\dbproc.obj"
	-@erase "$(INTDIR)\deflate.obj"
	-@erase "$(INTDIR)\doccol.obj"
	-@erase "$(INTDIR)\document.obj"
	-@erase "$(INTDIR)\dummies.obj"
	-@erase "$(INTDIR)\errhandler.obj"
	-@erase "$(INTDIR)\face.obj"
	-@erase "$(INTDIR)\fstring.caddr_t.map.obj"
	-@erase "$(INTDIR)\fstring.caddr_t.splaymap.obj"
	-@erase "$(INTDIR)\fstring.set.obj"
	-@erase "$(INTDIR)\fstring.splayset.obj"
	-@erase "$(INTDIR)\garutils.obj"
	-@erase "$(INTDIR)\gsscreen.obj"
	-@erase "$(INTDIR)\hidxhlp.obj"
	-@erase "$(INTDIR)\hindex.obj"
	-@erase "$(INTDIR)\index.obj"
	-@erase "$(INTDIR)\indices.obj"
	-@erase "$(INTDIR)\infblock.obj"
	-@erase "$(INTDIR)\infcodes.obj"
	-@erase "$(INTDIR)\inffast.obj"
	-@erase "$(INTDIR)\inflate.obj"
	-@erase "$(INTDIR)\inftrees.obj"
	-@erase "$(INTDIR)\infutil.obj"
	-@erase "$(INTDIR)\lex_basis.obj"
	-@erase "$(INTDIR)\lex_operator.obj"
	-@erase "$(INTDIR)\lex_parser.obj"
	-@erase "$(INTDIR)\mf2gardb.obj"
	-@erase "$(INTDIR)\ncpf.obj"
	-@erase "$(INTDIR)\newdoc.obj"
	-@erase "$(INTDIR)\osdummy.obj"
	-@erase "$(INTDIR)\pack.obj"
	-@erase "$(INTDIR)\pagefile.obj"
	-@erase "$(INTDIR)\parser.obj"
	-@erase "$(INTDIR)\refcol.obj"
	-@erase "$(INTDIR)\screen.obj"
	-@erase "$(INTDIR)\stdbase.obj"
	-@erase "$(INTDIR)\streams.obj"
	-@erase "$(INTDIR)\trees.obj"
	-@erase "$(INTDIR)\u_int32_t.caddr_t.map.obj"
	-@erase "$(INTDIR)\u_int32_t.caddr_t.splaymap.obj"
	-@erase "$(INTDIR)\u_int32_t.set.obj"
	-@erase "$(INTDIR)\u_int32_t.splayset.obj"
	-@erase "$(INTDIR)\unzip.obj"
	-@erase "$(INTDIR)\vapi.obj"
	-@erase "$(INTDIR)\vc60.idb"
	-@erase "$(INTDIR)\vc60.pdb"
	-@erase "$(INTDIR)\zutil.obj"
	-@erase "$(OUTDIR)\mf2gardb.exe"
	-@erase "$(OUTDIR)\mf2gardb.pdb"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP_PROJ=/nologo /G6 /MLd /W3 /Gi /GX /Zi /Od /I "..\..\..\include" /I "..\..\..\include\win32" /I "..\..\..\libs\cchlp\src" /I "..\..\..\libs\gc\src" /I "..\..\..\libs\gchange\include" /I "..\..\..\libs\gkdb\src" /I "..\..\..\libs\gsscreen\src" /I "..\..\..\libs\lex\include" /D "WIN32" /D "_DEBUG" /D "_CONSOLE" /D "_MBCS" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\mf2gardb.bsc" 
BSC32_SBRS= \
	
LINK32=xilink6.exe
LINK32_FLAGS=oldnames.lib kernel32.lib libcd.lib libcpd.lib /nologo /stack:0xa00000,0x100000 /subsystem:console /incremental:no /pdb:"$(OUTDIR)\mf2gardb.pdb" /debug /machine:I386 /nodefaultlib /out:"$(OUTDIR)\mf2gardb.exe" /pdbtype:sept /fixed:no 
LINK32_OBJS= \
	"$(INTDIR)\errhandler.obj" \
	"$(INTDIR)\fstring.caddr_t.map.obj" \
	"$(INTDIR)\fstring.caddr_t.splaymap.obj" \
	"$(INTDIR)\fstring.set.obj" \
	"$(INTDIR)\fstring.splayset.obj" \
	"$(INTDIR)\hidxhlp.obj" \
	"$(INTDIR)\u_int32_t.caddr_t.map.obj" \
	"$(INTDIR)\u_int32_t.caddr_t.splaymap.obj" \
	"$(INTDIR)\u_int32_t.set.obj" \
	"$(INTDIR)\u_int32_t.splayset.obj" \
	"$(INTDIR)\dbproc.obj" \
	"$(INTDIR)\dbproc.mf.obj" \
	"$(INTDIR)\context.obj" \
	"$(INTDIR)\parser.obj" \
	"$(INTDIR)\adler32.obj" \
	"$(INTDIR)\base.obj" \
	"$(INTDIR)\basemask.obj" \
	"$(INTDIR)\btiter.obj" \
	"$(INTDIR)\btree.obj" \
	"$(INTDIR)\collect.obj" \
	"$(INTDIR)\deflate.obj" \
	"$(INTDIR)\doccol.obj" \
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
	"$(INTDIR)\face.obj" \
	"$(INTDIR)\gsscreen.obj" \
	"$(INTDIR)\screen.obj" \
	"$(INTDIR)\lex_basis.obj" \
	"$(INTDIR)\lex_operator.obj" \
	"$(INTDIR)\lex_parser.obj" \
	"$(INTDIR)\vapi.obj" \
	"$(INTDIR)\cacheIndex.obj" \
	"$(INTDIR)\dbproc.m-reader.obj" \
	"$(INTDIR)\dbproc.m-to-gkdb.obj" \
	"$(INTDIR)\mf2gardb.obj"

"$(OUTDIR)\mf2gardb.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ENDIF 

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


!IF "$(NO_EXTERNAL_DEPS)" != "1"
!IF EXISTS("mf2gardb.dep")
!INCLUDE "mf2gardb.dep"
!ELSE 
!MESSAGE Warning: cannot find "mf2gardb.dep"
!ENDIF 
!ENDIF 


!IF "$(CFG)" == "mf2gardb - Win32 Release" || "$(CFG)" == "mf2gardb - Win32 Debug"
SOURCE=..\..\..\libs\cchlp\src\errhandler.cpp

"$(INTDIR)\errhandler.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\cchlp\src\fstring.caddr_t.map.cpp

"$(INTDIR)\fstring.caddr_t.map.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\cchlp\src\fstring.caddr_t.splaymap.cpp

"$(INTDIR)\fstring.caddr_t.splaymap.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\cchlp\src\fstring.set.cpp

"$(INTDIR)\fstring.set.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\cchlp\src\fstring.splayset.cpp

"$(INTDIR)\fstring.splayset.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\cchlp\src\hidxhlp.cpp

"$(INTDIR)\hidxhlp.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\cchlp\src\u_int32_t.caddr_t.map.cpp

"$(INTDIR)\u_int32_t.caddr_t.map.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\cchlp\src\u_int32_t.caddr_t.splaymap.cpp

"$(INTDIR)\u_int32_t.caddr_t.splaymap.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\cchlp\src\u_int32_t.set.cpp

"$(INTDIR)\u_int32_t.set.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\cchlp\src\u_int32_t.splayset.cpp

"$(INTDIR)\u_int32_t.splayset.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gc\src\dbproc.cpp

"$(INTDIR)\dbproc.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gc\src\dbproc.mf.cpp

"$(INTDIR)\dbproc.mf.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gchange\src\context.cpp

"$(INTDIR)\context.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gchange\src\parser.cpp

"$(INTDIR)\parser.obj" : $(SOURCE) "$(INTDIR)"
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


SOURCE=..\..\..\libs\gkdb\src\deflate.c

"$(INTDIR)\deflate.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gkdb\src\doccol.cpp

"$(INTDIR)\doccol.obj" : $(SOURCE) "$(INTDIR)"
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


SOURCE=..\..\..\libs\gsscreen\src\face.c

"$(INTDIR)\face.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gsscreen\src\gsscreen.cpp

"$(INTDIR)\gsscreen.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gsscreen\src\screen.c

"$(INTDIR)\screen.obj" : $(SOURCE) "$(INTDIR)"
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


SOURCE=..\..\..\libs\vcontrol\src\vapi.c

"$(INTDIR)\vapi.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\src\cacheIndex.cpp

"$(INTDIR)\cacheIndex.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE="..\src\dbproc.m-reader.cpp"

"$(INTDIR)\dbproc.m-reader.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE="..\src\dbproc.m-to-gkdb.cpp"

"$(INTDIR)\dbproc.m-to-gkdb.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\src\mf2gardb.cpp

"$(INTDIR)\mf2gardb.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)



!ENDIF 

