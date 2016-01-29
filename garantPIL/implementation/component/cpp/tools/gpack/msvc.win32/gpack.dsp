# Microsoft Developer Studio Project File - Name="gpack" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Console Application" 0x0103

CFG=gpack - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "gpack.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "gpack.mak" CFG="gpack - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "gpack - Win32 Release" (based on "Win32 (x86) Console Application")
!MESSAGE "gpack - Win32 Debug" (based on "Win32 (x86) Console Application")
!MESSAGE "gpack - Win32 Release56x" (based on "Win32 (x86) Console Application")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
RSC=rc.exe

!IF  "$(CFG)" == "gpack - Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release"
# PROP BASE Intermediate_Dir "Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release"
# PROP Intermediate_Dir "Release"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS" /YX /FD /c
# ADD CPP /nologo /W3 /WX /Gi /GX /O2 /I "..\..\..\include" /I "..\..\..\include\win32" /I "..\..\..\libs\cchlp\src" /I "..\..\..\libs\gkdb\src" /I "..\..\..\libs\gsscreen\src" /D "NDEBUG" /D "__STD_C" /D "LACKS_UNISTD_H" /D "WIN32" /D "_CONSOLE" /D "_MBCS" /D "OPT_PACK" /D "SKIP_CALL" /D "_USE_STDOUT" /FR /FD /c
# SUBTRACT CPP /YX
# ADD BASE RSC /l 0x419 /d "NDEBUG"
# ADD RSC /l 0x419 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 /nologo /subsystem:console /machine:I386 /pdbtype:sept /fixed:no
# ADD LINK32 winmm.lib /nologo /stack:0xa00000,0x100000 /subsystem:console /machine:I386 /fixed:no
# SUBTRACT LINK32 /pdb:none /incremental:yes /map /debug /nodefaultlib

!ELSEIF  "$(CFG)" == "gpack - Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug"
# PROP BASE Intermediate_Dir "Debug"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "Debug"
# PROP Intermediate_Dir "Debug"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /GX /Od /D "WIN32" /D "_DEBUG" /D "_CONSOLE" /D "_MBCS" /YX /FD /GZ /c
# ADD CPP /nologo /G5 /Zp1 /W3 /Gi /GX /Zi /Od /I "..\..\..\include" /I "..\..\..\include\win32" /I "..\..\..\libs\cchlp\src" /I "..\..\..\libs\gkdb\src" /I "..\..\..\libs\gsscreen\src" /D "_DEBUG" /D "WIN32" /D "_CONSOLE" /D "_MBCS" /D "OPT_PACK" /D "SKIP_CALL" /Fr /FD /GZ /c
# SUBTRACT CPP /WX /YX
# ADD BASE RSC /l 0x419 /d "_DEBUG"
# ADD RSC /l 0x419 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 /nologo /subsystem:console /debug /machine:I386 /pdbtype:sept /fixed:no
# ADD LINK32 winmm.lib /nologo /subsystem:console /profile /debug /machine:I386 /fixed:no
# SUBTRACT LINK32 /nodefaultlib

!ELSEIF  "$(CFG)" == "gpack - Win32 Release56x"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "gpack___Win32_Release56x"
# PROP BASE Intermediate_Dir "gpack___Win32_Release56x"
# PROP BASE Ignore_Export_Lib 0
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release56x"
# PROP Intermediate_Dir "Release56x"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /WX /Gi /GX /O2 /I "..\..\..\include" /I "..\..\..\include\win32" /I "..\..\..\libs\cchlp\src" /I "..\..\..\libs\gkdb\src" /I "..\..\..\libs\gsscreen\src" /D "NDEBUG" /D "__STD_C" /D "LACKS_UNISTD_H" /D "WIN32" /D "_CONSOLE" /D "_MBCS" /D "OPT_PACK" /D "SKIP_CALL" /D "_USE_STDOUT" /FR /FD /c
# SUBTRACT BASE CPP /YX
# ADD CPP /nologo /W3 /WX /Gi /GX /Zi /Od /I "..\..\..\include" /I "..\..\..\include\win32" /I "..\..\..\libs\cchlp\src" /I "..\..\..\libs\gkdb\src" /I "..\..\..\libs\gsscreen\src" /D "NDEBUG" /D "WIN32" /D "__x86__" /D "__WIN32__" /D "_WINDOWS" /D "_CONSOLE" /D "_MBCS" /D "CODETYPE_DOS" /D "MULTI_INDEX_STREAM_FILE" /D "INSTLL_CIB" /D "QUICK_NEW_DOC" /D "STORE_FORM_N" /D "ONLY_NORM_INDEX" /D "VERSION56" /D "BLOCKSINHERIT" /D "NEMESIS" /D "VERSION61" /D "WINENCODE" /D "OPT_PACK" /FR /FD /c
# SUBTRACT CPP /YX
# ADD BASE RSC /l 0x419 /d "NDEBUG"
# ADD RSC /l 0x419 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 winmm.lib /nologo /stack:0xa00000,0x100000 /subsystem:console /machine:I386 /fixed:no
# SUBTRACT BASE LINK32 /pdb:none /incremental:yes /map /debug /nodefaultlib
# ADD LINK32 winmm.lib /nologo /stack:0xa00000,0x100000 /subsystem:console /incremental:yes /debug /machine:I386 /fixed:no
# SUBTRACT LINK32 /pdb:none /map /nodefaultlib

!ENDIF 

# Begin Target

# Name "gpack - Win32 Release"
# Name "gpack - Win32 Debug"
# Name "gpack - Win32 Release56x"
# Begin Group "include"

# PROP Default_Filter "h;c;cpp"
# Begin Group "win32"

# PROP Default_Filter "h;c;cpp"
# Begin Source File

SOURCE=..\..\..\include\win32\strings.h
# End Source File
# Begin Source File

SOURCE=..\..\..\include\win32\unistd.h
# End Source File
# End Group
# Begin Source File

SOURCE=..\..\..\include\garver.h
# End Source File
# Begin Source File

SOURCE=..\..\..\include\osdep.h
# End Source File
# End Group
# Begin Group "libs"

# PROP Default_Filter "h;c;cpp"
# Begin Group "gkdb"

# PROP Default_Filter "h;c;cpp"
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\adler32.c
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\base.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\basemask.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\btiter.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\btree.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\collect.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\crc32.c
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\deflate.c
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\docblock.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\doccol.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\dociter.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\document.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\dummies.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\fltiter.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\garutils.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\hindex.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\index.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\indices.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\infblock.c
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\infcodes.c
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\inffast.c
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\inflate.c
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\inftrees.c
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\infutil.c
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\ncpf.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\newdoc.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\osdummy.c
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\pack.c
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\pagefile.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\paracol.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\pl_crypt.c
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\privbase.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\refcol.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\rev.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\stdbase.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\store.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\streams.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\trees.c
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\unzip.c
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\zutil.c
# End Source File
# End Group
# Begin Group "gsscreen"

# PROP Default_Filter "h;c;cpp"
# Begin Source File

SOURCE=..\..\..\libs\gsscreen\src\face.c
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gsscreen\src\screen.c
# End Source File
# End Group
# Begin Group "vcontrol"

# PROP Default_Filter "h;c;cpp"
# Begin Source File

SOURCE=..\..\..\libs\VControl\src\vapi.c
# End Source File
# End Group
# Begin Group "MRGLib"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\..\libs\mrglib\src\bfind.c
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\mrglib\src\btree_.c
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\mrglib\src\cmpfunc.c
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\mrglib\src\flog.c
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\mrglib\src\gbase.c
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\mrglib\src\gberr.c
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\mrglib\src\globals.c
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\mrglib\src\index_.c
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\mrglib\src\iter.c
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\mrglib\src\keyfile.c
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\mrglib\src\mlhooks.c
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\mrglib\src\pgfile.c
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\mrglib\src\profile.c
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\mrglib\src\sets.c
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\mrglib\src\ssets.c
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\mrglib\src\strcache.c
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\mrglib\src\streams_.c
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\mrglib\src\unifname.c
# End Source File
# End Group
# Begin Group "cchlp"

# PROP Default_Filter "h;c;cpp"
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\errhandler.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\Logger.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\recode.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gctx\src\u_int64_t.CtxLongSet.Map.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gctx\src\u_int64_t.CtxLongSet.SplayMap.cpp
# End Source File
# End Group
# Begin Source File

SOURCE=..\..\..\libs\gctx\src\ctxwords.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gctx\src\gctx_func.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\delta\src\tempdoc.cpp
# End Source File
# End Group
# Begin Source File

SOURCE=..\src\gpack.cpp
# End Source File
# End Target
# End Project
