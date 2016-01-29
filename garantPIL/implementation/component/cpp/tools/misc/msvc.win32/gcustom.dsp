# Microsoft Developer Studio Project File - Name="gcustom" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Console Application" 0x0103

CFG=gcustom - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "gcustom.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "gcustom.mak" CFG="gcustom - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "gcustom - Win32 Release" (based on "Win32 (x86) Console Application")
!MESSAGE "gcustom - Win32 Debug" (based on "Win32 (x86) Console Application")
!MESSAGE "gcustom - Win32 Release56x" (based on "Win32 (x86) Console Application")
!MESSAGE "gcustom - Win32 Release61" (based on "Win32 (x86) Console Application")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
RSC=rc.exe

!IF  "$(CFG)" == "gcustom - Win32 Release"

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
# ADD CPP /nologo /W3 /WX /Gi /GX /O2 /I "..\..\..\include" /I "..\..\..\include\win32" /I "..\..\..\libs\cchlp\src" /I "..\..\..\libs\gkdb\src" /I "..\..\..\libs\gsscreen\src" /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS" /D "VERSION56" /FD /c
# SUBTRACT CPP /YX
# ADD BASE RSC /l 0x419 /d "NDEBUG"
# ADD RSC /l 0x419 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 /nologo /subsystem:console /machine:I386 /pdbtype:sept /fixed:no
# ADD LINK32 oldnames.lib kernel32.lib libc.lib /nologo /stack:0xa00000,0x100000 /subsystem:console /machine:I386 /nodefaultlib /fixed:no
# SUBTRACT LINK32 /pdb:none /incremental:yes /map /debug

!ELSEIF  "$(CFG)" == "gcustom - Win32 Debug"

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
# ADD CPP /nologo /G6 /W3 /Gi /GX /Zi /Od /I "..\..\..\include" /I "..\..\..\include\win32" /I "..\..\..\libs\cchlp\src" /I "..\..\..\libs\gkdb\src" /I "..\..\..\libs\gsscreen\src" /D "WIN32" /D "_DEBUG" /D "_CONSOLE" /D "_MBCS" /D "VERSION56" /D "MULTI_INDEX_STREAM_FILE" /D "INSTLL_CIB" /FD /GZ /c
# SUBTRACT CPP /WX /Fr /YX
# ADD BASE RSC /l 0x419 /d "_DEBUG"
# ADD RSC /l 0x419 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 /nologo /subsystem:console /debug /machine:I386 /pdbtype:sept /fixed:no
# ADD LINK32 oldnames.lib kernel32.lib libcd.lib /nologo /stack:0xa00000,0x100000 /subsystem:console /incremental:no /debug /machine:I386 /pdbtype:sept /fixed:no
# SUBTRACT LINK32 /profile /pdb:none /map /nodefaultlib

!ELSEIF  "$(CFG)" == "gcustom - Win32 Release56x"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "gcustom___Win32_Release56x"
# PROP BASE Intermediate_Dir "gcustom___Win32_Release56x"
# PROP BASE Ignore_Export_Lib 0
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release56x"
# PROP Intermediate_Dir "Release56x"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /WX /Gi /GX /O2 /I "..\..\..\include" /I "..\..\..\include\win32" /I "..\..\..\libs\cchlp\src" /I "..\..\..\libs\gkdb\src" /I "..\..\..\libs\gsscreen\src" /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS" /FD /c
# SUBTRACT BASE CPP /YX
# ADD CPP /nologo /W3 /WX /Gi /GX /ZI /Od /I "..\..\..\include" /I "..\..\..\include\win32" /I "..\..\..\libs\cchlp\src" /I "..\..\..\libs\gkdb\src" /I "..\..\..\libs\gsscreen\src" /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS" /D "INSTLL_CIB" /D "MULTI_INDEX_STREAM_FILE" /D "VERSION56" /Fr /FD /c
# SUBTRACT CPP /YX
# ADD BASE RSC /l 0x419 /d "NDEBUG"
# ADD RSC /l 0x419 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 oldnames.lib kernel32.lib libc.lib /nologo /stack:0xa00000,0x100000 /subsystem:console /machine:I386 /nodefaultlib /fixed:no
# SUBTRACT BASE LINK32 /pdb:none /incremental:yes /map /debug
# ADD LINK32 oldnames.lib kernel32.lib libc.lib /nologo /stack:0xa00000,0x100000 /subsystem:console /debug /machine:I386 /fixed:no
# SUBTRACT LINK32 /pdb:none /incremental:yes /map /nodefaultlib

!ELSEIF  "$(CFG)" == "gcustom - Win32 Release61"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "gcustom___Win32_Release61"
# PROP BASE Intermediate_Dir "gcustom___Win32_Release61"
# PROP BASE Ignore_Export_Lib 0
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release61"
# PROP Intermediate_Dir "Release61"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /WX /Gi /GX /ZI /Od /I "..\..\..\include" /I "..\..\..\include\win32" /I "..\..\..\libs\cchlp\src" /I "..\..\..\libs\gkdb\src" /I "..\..\..\libs\gsscreen\src" /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS" /D "INSTLL_CIB" /D "MULTI_INDEX_STREAM_FILE" /D "VERSION56" /Fr /FD /c
# SUBTRACT BASE CPP /YX
# ADD CPP /nologo /W3 /WX /Gi /GX /Zi /Od /I "..\..\..\include" /I "..\..\..\include\win32" /I "..\..\..\libs\cchlp\src" /I "..\..\..\libs\gkdb\src" /I "..\..\..\libs\gsscreen\src" /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS" /D "INSTLL_CIB" /D "MULTI_INDEX_STREAM_FILE" /D "VERSION56" /D "VERSION61" /D "KERNEL_NOT_USE_CONTEXT" /Fr /FD /c
# SUBTRACT CPP /YX
# ADD BASE RSC /l 0x419 /d "NDEBUG"
# ADD RSC /l 0x419 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 oldnames.lib kernel32.lib libc.lib /nologo /stack:0xa00000,0x100000 /subsystem:console /debug /machine:I386 /fixed:no
# SUBTRACT BASE LINK32 /pdb:none /incremental:yes /map /nodefaultlib
# ADD LINK32 oldnames.lib kernel32.lib libc.lib libcp.lib /nologo /stack:0xa00000,0x100000 /subsystem:console /debug /machine:I386 /fixed:no
# SUBTRACT LINK32 /pdb:none /incremental:yes /map /nodefaultlib

!ENDIF 

# Begin Target

# Name "gcustom - Win32 Release"
# Name "gcustom - Win32 Debug"
# Name "gcustom - Win32 Release56x"
# Name "gcustom - Win32 Release61"
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
# Begin Group "cchlp"

# PROP Default_Filter "h;c;cpp"
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\errhandler.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\fstring.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\logger.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\logger.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\long.long.Map.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\long.long.SplayMap.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\map.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\recode.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\recode.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\set.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\SharedData.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\splaymap.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\splayset.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\storablesplayset.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\stringz.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\stringz.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\typecmp.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\u_int32_t.caddr_t.Map.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\u_int32_t.caddr_t.SplayMap.cpp
# End Source File
# End Group
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

SOURCE=..\..\..\libs\gkdb\src\fltiter.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\gardefs.cpp
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

SOURCE=..\..\..\libs\gsscreen\src\gsscreen.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gsscreen\src\gsscreen.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gsscreen\src\iscreen.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gsscreen\src\pscreen.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gsscreen\src\screen.c
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gsscreen\src\toys.h
# End Source File
# End Group
# Begin Group "vcontrol"

# PROP Default_Filter "h;c;cpp"
# Begin Source File

SOURCE=..\..\..\libs\vcontrol\src\vapi.c
# End Source File
# End Group
# Begin Group "gctx"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\..\libs\gctx\src\ctxwords.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gctx\src\gctx_func.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gctx\src\u_int64_t.CtxLongSet.Map.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gctx\src\u_int64_t.CtxLongSet.SplayMap.cpp
# End Source File
# End Group
# End Group
# Begin Source File

SOURCE=..\src\gcustom.cpp
# End Source File
# End Target
# End Project
