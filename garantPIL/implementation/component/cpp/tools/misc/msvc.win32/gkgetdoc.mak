# Microsoft Developer Studio Generated NMAKE File, Based on gkgetdoc.dsp
!IF "$(CFG)" == ""
CFG=gkgetdoc - Win32 Debug
!MESSAGE No configuration specified. Defaulting to gkgetdoc - Win32 Debug.
!ENDIF 

!IF "$(CFG)" != "gkgetdoc - Win32 Release" && "$(CFG)" != "gkgetdoc - Win32 Debug"
!MESSAGE Invalid configuration "$(CFG)" specified.
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "gkgetdoc.mak" CFG="gkgetdoc - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "gkgetdoc - Win32 Release" (based on "Win32 (x86) Console Application")
!MESSAGE "gkgetdoc - Win32 Debug" (based on "Win32 (x86) Console Application")
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

!IF  "$(CFG)" == "gkgetdoc - Win32 Release"

OUTDIR=.\Release
INTDIR=.\Release
# Begin Custom Macros
OutDir=.\Release
# End Custom Macros

ALL : "$(OUTDIR)\gkgetdoc.exe" "$(OUTDIR)\gkgetdoc.bsc"


CLEAN :
	-@erase "$(INTDIR)\adler32.obj"
	-@erase "$(INTDIR)\adler32.sbr"
	-@erase "$(INTDIR)\base.obj"
	-@erase "$(INTDIR)\base.sbr"
	-@erase "$(INTDIR)\basemask.obj"
	-@erase "$(INTDIR)\basemask.sbr"
	-@erase "$(INTDIR)\btiter.obj"
	-@erase "$(INTDIR)\btiter.sbr"
	-@erase "$(INTDIR)\btree.obj"
	-@erase "$(INTDIR)\btree.sbr"
	-@erase "$(INTDIR)\collect.obj"
	-@erase "$(INTDIR)\collect.sbr"
	-@erase "$(INTDIR)\deflate.obj"
	-@erase "$(INTDIR)\deflate.sbr"
	-@erase "$(INTDIR)\doccol.obj"
	-@erase "$(INTDIR)\doccol.sbr"
	-@erase "$(INTDIR)\document.obj"
	-@erase "$(INTDIR)\document.sbr"
	-@erase "$(INTDIR)\dummies.obj"
	-@erase "$(INTDIR)\dummies.sbr"
	-@erase "$(INTDIR)\face.obj"
	-@erase "$(INTDIR)\face.sbr"
	-@erase "$(INTDIR)\garutils.obj"
	-@erase "$(INTDIR)\garutils.sbr"
	-@erase "$(INTDIR)\gkgetdoc.obj"
	-@erase "$(INTDIR)\gkgetdoc.sbr"
	-@erase "$(INTDIR)\gsscreen.obj"
	-@erase "$(INTDIR)\gsscreen.sbr"
	-@erase "$(INTDIR)\hindex.obj"
	-@erase "$(INTDIR)\hindex.sbr"
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
	-@erase "$(INTDIR)\ncpf.obj"
	-@erase "$(INTDIR)\ncpf.sbr"
	-@erase "$(INTDIR)\pack.obj"
	-@erase "$(INTDIR)\pack.sbr"
	-@erase "$(INTDIR)\pagefile.obj"
	-@erase "$(INTDIR)\pagefile.sbr"
	-@erase "$(INTDIR)\refcol.obj"
	-@erase "$(INTDIR)\refcol.sbr"
	-@erase "$(INTDIR)\screen.obj"
	-@erase "$(INTDIR)\screen.sbr"
	-@erase "$(INTDIR)\stdbase.obj"
	-@erase "$(INTDIR)\stdbase.sbr"
	-@erase "$(INTDIR)\streams.obj"
	-@erase "$(INTDIR)\streams.sbr"
	-@erase "$(INTDIR)\trees.obj"
	-@erase "$(INTDIR)\trees.sbr"
	-@erase "$(INTDIR)\unzip.obj"
	-@erase "$(INTDIR)\unzip.sbr"
	-@erase "$(INTDIR)\vapi.obj"
	-@erase "$(INTDIR)\vapi.sbr"
	-@erase "$(INTDIR)\vc60.idb"
	-@erase "$(INTDIR)\zutil.obj"
	-@erase "$(INTDIR)\zutil.sbr"
	-@erase "$(OUTDIR)\gkgetdoc.bsc"
	-@erase "$(OUTDIR)\gkgetdoc.exe"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP_PROJ=/nologo /ML /W3 /WX /Gi /GX /O2 /I "..\..\..\libs\cchlp\src" /I "..\..\..\include" /I "..\..\..\include\win32" /I "..\..\..\libs\gkdb\src" /I "..\..\..\libs\gsscreen\src" /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\gkgetdoc.bsc" 
BSC32_SBRS= \
	"$(INTDIR)\adler32.sbr" \
	"$(INTDIR)\base.sbr" \
	"$(INTDIR)\basemask.sbr" \
	"$(INTDIR)\btiter.sbr" \
	"$(INTDIR)\btree.sbr" \
	"$(INTDIR)\collect.sbr" \
	"$(INTDIR)\deflate.sbr" \
	"$(INTDIR)\doccol.sbr" \
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
	"$(INTDIR)\pack.sbr" \
	"$(INTDIR)\pagefile.sbr" \
	"$(INTDIR)\refcol.sbr" \
	"$(INTDIR)\stdbase.sbr" \
	"$(INTDIR)\streams.sbr" \
	"$(INTDIR)\trees.sbr" \
	"$(INTDIR)\unzip.sbr" \
	"$(INTDIR)\zutil.sbr" \
	"$(INTDIR)\face.sbr" \
	"$(INTDIR)\gsscreen.sbr" \
	"$(INTDIR)\screen.sbr" \
	"$(INTDIR)\vapi.sbr" \
	"$(INTDIR)\gkgetdoc.sbr"

"$(OUTDIR)\gkgetdoc.bsc" : "$(OUTDIR)" $(BSC32_SBRS)
    $(BSC32) @<<
  $(BSC32_FLAGS) $(BSC32_SBRS)
<<

LINK32=xilink6.exe
LINK32_FLAGS=oldnames.lib kernel32.lib libc.lib /nologo /stack:0xa00000,0x100000 /subsystem:console /incremental:no /pdb:"$(OUTDIR)\gkgetdoc.pdb" /machine:I386 /nodefaultlib /out:"$(OUTDIR)\gkgetdoc.exe" /fixed:no 
LINK32_OBJS= \
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
	"$(INTDIR)\vapi.obj" \
	"$(INTDIR)\gkgetdoc.obj"

"$(OUTDIR)\gkgetdoc.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ELSEIF  "$(CFG)" == "gkgetdoc - Win32 Debug"

OUTDIR=.\Debug
INTDIR=.\Debug
# Begin Custom Macros
OutDir=.\Debug
# End Custom Macros

ALL : "$(OUTDIR)\gkgetdoc.exe"


CLEAN :
	-@erase "$(INTDIR)\adler32.obj"
	-@erase "$(INTDIR)\base.obj"
	-@erase "$(INTDIR)\basemask.obj"
	-@erase "$(INTDIR)\btiter.obj"
	-@erase "$(INTDIR)\btree.obj"
	-@erase "$(INTDIR)\collect.obj"
	-@erase "$(INTDIR)\deflate.obj"
	-@erase "$(INTDIR)\doccol.obj"
	-@erase "$(INTDIR)\document.obj"
	-@erase "$(INTDIR)\dummies.obj"
	-@erase "$(INTDIR)\face.obj"
	-@erase "$(INTDIR)\garutils.obj"
	-@erase "$(INTDIR)\gkgetdoc.obj"
	-@erase "$(INTDIR)\gsscreen.obj"
	-@erase "$(INTDIR)\hindex.obj"
	-@erase "$(INTDIR)\index.obj"
	-@erase "$(INTDIR)\indices.obj"
	-@erase "$(INTDIR)\infblock.obj"
	-@erase "$(INTDIR)\infcodes.obj"
	-@erase "$(INTDIR)\inffast.obj"
	-@erase "$(INTDIR)\inflate.obj"
	-@erase "$(INTDIR)\inftrees.obj"
	-@erase "$(INTDIR)\infutil.obj"
	-@erase "$(INTDIR)\ncpf.obj"
	-@erase "$(INTDIR)\pack.obj"
	-@erase "$(INTDIR)\pagefile.obj"
	-@erase "$(INTDIR)\refcol.obj"
	-@erase "$(INTDIR)\screen.obj"
	-@erase "$(INTDIR)\stdbase.obj"
	-@erase "$(INTDIR)\streams.obj"
	-@erase "$(INTDIR)\trees.obj"
	-@erase "$(INTDIR)\unzip.obj"
	-@erase "$(INTDIR)\vapi.obj"
	-@erase "$(INTDIR)\vc60.idb"
	-@erase "$(INTDIR)\vc60.pdb"
	-@erase "$(INTDIR)\zutil.obj"
	-@erase "$(OUTDIR)\gkgetdoc.exe"
	-@erase "$(OUTDIR)\gkgetdoc.pdb"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP_PROJ=/nologo /G6 /MLd /W3 /Gi /GX /Zi /Od /I "..\..\..\include" /I "..\..\..\include\win32" /I "..\..\..\libs\cchlp\src" /I "..\..\..\libs\gkdb\src" /I "..\..\..\libs\gsscreen\src" /D "WIN32" /D "_DEBUG" /D "_CONSOLE" /D "_MBCS" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\gkgetdoc.bsc" 
BSC32_SBRS= \
	
LINK32=xilink6.exe
LINK32_FLAGS=oldnames.lib kernel32.lib libcd.lib /nologo /stack:0xa00000,0x100000 /subsystem:console /incremental:no /pdb:"$(OUTDIR)\gkgetdoc.pdb" /debug /machine:I386 /nodefaultlib /out:"$(OUTDIR)\gkgetdoc.exe" /pdbtype:sept /fixed:no 
LINK32_OBJS= \
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
	"$(INTDIR)\vapi.obj" \
	"$(INTDIR)\gkgetdoc.obj"

"$(OUTDIR)\gkgetdoc.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
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
!IF EXISTS("gkgetdoc.dep")
!INCLUDE "gkgetdoc.dep"
!ELSE 
!MESSAGE Warning: cannot find "gkgetdoc.dep"
!ENDIF 
!ENDIF 


!IF "$(CFG)" == "gkgetdoc - Win32 Release" || "$(CFG)" == "gkgetdoc - Win32 Debug"
SOURCE=..\..\..\libs\gkdb\src\adler32.c

!IF  "$(CFG)" == "gkgetdoc - Win32 Release"


"$(INTDIR)\adler32.obj"	"$(INTDIR)\adler32.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gkgetdoc - Win32 Debug"


"$(INTDIR)\adler32.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\base.cpp

!IF  "$(CFG)" == "gkgetdoc - Win32 Release"


"$(INTDIR)\base.obj"	"$(INTDIR)\base.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gkgetdoc - Win32 Debug"


"$(INTDIR)\base.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\basemask.cpp

!IF  "$(CFG)" == "gkgetdoc - Win32 Release"


"$(INTDIR)\basemask.obj"	"$(INTDIR)\basemask.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gkgetdoc - Win32 Debug"


"$(INTDIR)\basemask.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\btiter.cpp

!IF  "$(CFG)" == "gkgetdoc - Win32 Release"


"$(INTDIR)\btiter.obj"	"$(INTDIR)\btiter.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gkgetdoc - Win32 Debug"


"$(INTDIR)\btiter.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\btree.cpp

!IF  "$(CFG)" == "gkgetdoc - Win32 Release"


"$(INTDIR)\btree.obj"	"$(INTDIR)\btree.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gkgetdoc - Win32 Debug"


"$(INTDIR)\btree.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\collect.cpp

!IF  "$(CFG)" == "gkgetdoc - Win32 Release"


"$(INTDIR)\collect.obj"	"$(INTDIR)\collect.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gkgetdoc - Win32 Debug"


"$(INTDIR)\collect.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\deflate.c

!IF  "$(CFG)" == "gkgetdoc - Win32 Release"


"$(INTDIR)\deflate.obj"	"$(INTDIR)\deflate.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gkgetdoc - Win32 Debug"


"$(INTDIR)\deflate.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\doccol.cpp

!IF  "$(CFG)" == "gkgetdoc - Win32 Release"


"$(INTDIR)\doccol.obj"	"$(INTDIR)\doccol.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gkgetdoc - Win32 Debug"


"$(INTDIR)\doccol.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\document.cpp

!IF  "$(CFG)" == "gkgetdoc - Win32 Release"


"$(INTDIR)\document.obj"	"$(INTDIR)\document.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gkgetdoc - Win32 Debug"


"$(INTDIR)\document.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\dummies.cpp

!IF  "$(CFG)" == "gkgetdoc - Win32 Release"


"$(INTDIR)\dummies.obj"	"$(INTDIR)\dummies.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gkgetdoc - Win32 Debug"


"$(INTDIR)\dummies.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\garutils.cpp

!IF  "$(CFG)" == "gkgetdoc - Win32 Release"


"$(INTDIR)\garutils.obj"	"$(INTDIR)\garutils.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gkgetdoc - Win32 Debug"


"$(INTDIR)\garutils.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\hindex.cpp

!IF  "$(CFG)" == "gkgetdoc - Win32 Release"


"$(INTDIR)\hindex.obj"	"$(INTDIR)\hindex.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gkgetdoc - Win32 Debug"


"$(INTDIR)\hindex.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\index.cpp

!IF  "$(CFG)" == "gkgetdoc - Win32 Release"


"$(INTDIR)\index.obj"	"$(INTDIR)\index.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gkgetdoc - Win32 Debug"


"$(INTDIR)\index.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\indices.cpp

!IF  "$(CFG)" == "gkgetdoc - Win32 Release"


"$(INTDIR)\indices.obj"	"$(INTDIR)\indices.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gkgetdoc - Win32 Debug"


"$(INTDIR)\indices.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\infblock.c

!IF  "$(CFG)" == "gkgetdoc - Win32 Release"


"$(INTDIR)\infblock.obj"	"$(INTDIR)\infblock.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gkgetdoc - Win32 Debug"


"$(INTDIR)\infblock.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\infcodes.c

!IF  "$(CFG)" == "gkgetdoc - Win32 Release"


"$(INTDIR)\infcodes.obj"	"$(INTDIR)\infcodes.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gkgetdoc - Win32 Debug"


"$(INTDIR)\infcodes.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\inffast.c

!IF  "$(CFG)" == "gkgetdoc - Win32 Release"


"$(INTDIR)\inffast.obj"	"$(INTDIR)\inffast.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gkgetdoc - Win32 Debug"


"$(INTDIR)\inffast.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\inflate.c

!IF  "$(CFG)" == "gkgetdoc - Win32 Release"


"$(INTDIR)\inflate.obj"	"$(INTDIR)\inflate.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gkgetdoc - Win32 Debug"


"$(INTDIR)\inflate.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\inftrees.c

!IF  "$(CFG)" == "gkgetdoc - Win32 Release"


"$(INTDIR)\inftrees.obj"	"$(INTDIR)\inftrees.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gkgetdoc - Win32 Debug"


"$(INTDIR)\inftrees.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\infutil.c

!IF  "$(CFG)" == "gkgetdoc - Win32 Release"


"$(INTDIR)\infutil.obj"	"$(INTDIR)\infutil.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gkgetdoc - Win32 Debug"


"$(INTDIR)\infutil.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\ncpf.cpp

!IF  "$(CFG)" == "gkgetdoc - Win32 Release"


"$(INTDIR)\ncpf.obj"	"$(INTDIR)\ncpf.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gkgetdoc - Win32 Debug"


"$(INTDIR)\ncpf.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\pack.c

!IF  "$(CFG)" == "gkgetdoc - Win32 Release"


"$(INTDIR)\pack.obj"	"$(INTDIR)\pack.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gkgetdoc - Win32 Debug"


"$(INTDIR)\pack.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\pagefile.cpp

!IF  "$(CFG)" == "gkgetdoc - Win32 Release"


"$(INTDIR)\pagefile.obj"	"$(INTDIR)\pagefile.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gkgetdoc - Win32 Debug"


"$(INTDIR)\pagefile.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\refcol.cpp

!IF  "$(CFG)" == "gkgetdoc - Win32 Release"


"$(INTDIR)\refcol.obj"	"$(INTDIR)\refcol.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gkgetdoc - Win32 Debug"


"$(INTDIR)\refcol.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\stdbase.cpp

!IF  "$(CFG)" == "gkgetdoc - Win32 Release"


"$(INTDIR)\stdbase.obj"	"$(INTDIR)\stdbase.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gkgetdoc - Win32 Debug"


"$(INTDIR)\stdbase.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\streams.cpp

!IF  "$(CFG)" == "gkgetdoc - Win32 Release"


"$(INTDIR)\streams.obj"	"$(INTDIR)\streams.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gkgetdoc - Win32 Debug"


"$(INTDIR)\streams.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\trees.c

!IF  "$(CFG)" == "gkgetdoc - Win32 Release"


"$(INTDIR)\trees.obj"	"$(INTDIR)\trees.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gkgetdoc - Win32 Debug"


"$(INTDIR)\trees.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\unzip.c

!IF  "$(CFG)" == "gkgetdoc - Win32 Release"


"$(INTDIR)\unzip.obj"	"$(INTDIR)\unzip.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gkgetdoc - Win32 Debug"


"$(INTDIR)\unzip.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\zutil.c

!IF  "$(CFG)" == "gkgetdoc - Win32 Release"


"$(INTDIR)\zutil.obj"	"$(INTDIR)\zutil.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gkgetdoc - Win32 Debug"


"$(INTDIR)\zutil.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gsscreen\src\face.c

!IF  "$(CFG)" == "gkgetdoc - Win32 Release"


"$(INTDIR)\face.obj"	"$(INTDIR)\face.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gkgetdoc - Win32 Debug"


"$(INTDIR)\face.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gsscreen\src\gsscreen.cpp

!IF  "$(CFG)" == "gkgetdoc - Win32 Release"


"$(INTDIR)\gsscreen.obj"	"$(INTDIR)\gsscreen.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gkgetdoc - Win32 Debug"


"$(INTDIR)\gsscreen.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gsscreen\src\screen.c

!IF  "$(CFG)" == "gkgetdoc - Win32 Release"


"$(INTDIR)\screen.obj"	"$(INTDIR)\screen.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gkgetdoc - Win32 Debug"


"$(INTDIR)\screen.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\vcontrol\src\vapi.c

!IF  "$(CFG)" == "gkgetdoc - Win32 Release"


"$(INTDIR)\vapi.obj"	"$(INTDIR)\vapi.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gkgetdoc - Win32 Debug"


"$(INTDIR)\vapi.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\src\gkgetdoc.cpp

!IF  "$(CFG)" == "gkgetdoc - Win32 Release"


"$(INTDIR)\gkgetdoc.obj"	"$(INTDIR)\gkgetdoc.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gkgetdoc - Win32 Debug"


"$(INTDIR)\gkgetdoc.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 


!ENDIF 

