# Microsoft Developer Studio Project File - Name="mf2gardb" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Console Application" 0x0103

CFG=mf2gardb - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "mf2gardb.mak".
!MESSAGE 
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

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
RSC=rc.exe

!IF  "$(CFG)" == "mf2gardb - Win32 Release"

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
# ADD CPP /nologo /W3 /WX /Gi /GX /O2 /I "..\..\..\include" /I "..\..\..\include\win32" /I "..\..\..\libs\cchlp\src" /I "..\..\..\libs\gc\src" /I "..\..\..\libs\gchange\include" /I "..\..\..\libs\gkdb\src" /I "..\..\..\libs\gsscreen\src" /I "..\..\..\libs\lex\include" /I "..\..\..\libs\gctx\src" /D "NDEBUG" /D "WIN32" /D "_CONSOLE" /D "_MBCS" /D "INC_GCTX" /FD /c
# SUBTRACT CPP /YX
# ADD BASE RSC /l 0x419 /d "NDEBUG"
# ADD RSC /l 0x419 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 /nologo /subsystem:console /machine:I386 /pdbtype:sept /fixed:no
# ADD LINK32 oldnames.lib kernel32.lib libc.lib libcp.lib /nologo /stack:0xa00000,0x100000 /subsystem:console /machine:I386 /nodefaultlib /fixed:no
# SUBTRACT LINK32 /pdb:none /debug

!ELSEIF  "$(CFG)" == "mf2gardb - Win32 Debug"

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
# ADD CPP /nologo /G5 /W3 /Gi /GX /Zi /Od /I "..\..\..\include" /I "..\..\..\include\win32" /I "..\..\..\libs\cchlp\src" /I "..\..\..\libs\gc\src" /I "..\..\..\libs\gchange\include" /I "..\..\..\libs\gkdb\src" /I "..\..\..\libs\gsscreen\src" /I "..\..\..\libs\lex\include" /I "..\..\..\libs\gctx\src" /D "_DEBUG" /D "WIN32" /D "_CONSOLE" /D "_MBCS" /D "INC_GCTX" /FD /GZ /c
# SUBTRACT CPP /WX /Fr /YX
# ADD BASE RSC /l 0x419 /d "_DEBUG"
# ADD RSC /l 0x419 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 /nologo /subsystem:console /debug /machine:I386 /pdbtype:sept
# ADD LINK32 oldnames.lib kernel32.lib libcd.lib libcpd.lib /nologo /stack:0xa00000,0x100000 /subsystem:console /incremental:no /debug /machine:I386 /nodefaultlib /pdbtype:sept /fixed:no
# SUBTRACT LINK32 /pdb:none

!ENDIF 

# Begin Target

# Name "mf2gardb - Win32 Release"
# Name "mf2gardb - Win32 Debug"
# Begin Group "include"

# PROP Default_Filter "h;c;cpp"
# Begin Group "win32"

# PROP Default_Filter "h;c;cpp"
# Begin Source File

SOURCE=..\..\..\include\win32\getopt.h
# End Source File
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

SOURCE=..\..\..\libs\cchlp\src\errhandler.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\fstring.caddr_t.map.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\fstring.caddr_t.map.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\fstring.caddr_t.splaymap.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\fstring.caddr_t.splaymap.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\fstring.defs.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\fstring.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\fstring.set.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\fstring.set.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\fstring.splaynode.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\fstring.splayset.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\fstring.splayset.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\hidxhlp.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\hidxhlp.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\pix.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\recode.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\u_int32_t.caddr_t.map.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\u_int32_t.caddr_t.map.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\u_int32_t.caddr_t.splaymap.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\u_int32_t.caddr_t.splaymap.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\u_int32_t.defs.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\u_int32_t.set.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\u_int32_t.set.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\u_int32_t.splaynode.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\u_int32_t.splayset.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\u_int32_t.splayset.h
# End Source File
# End Group
# Begin Group "gc"

# PROP Default_Filter "h;c;cpp"
# Begin Source File

SOURCE=..\..\..\libs\gc\src\dbproc.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gc\src\dbproc.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gc\src\dbproc.mf.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gc\src\dbproc.mf.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gc\src\dbproc.mh.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gc\src\topic_t.h
# End Source File
# End Group
# Begin Group "gchange"

# PROP Default_Filter "h;c;cpp"
# Begin Source File

SOURCE=..\..\..\libs\gchange\src\context.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gchange\include\context.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gchange\src\parser.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gchange\include\parser.h
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

SOURCE=..\..\..\libs\gkdb\src\base.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\basemask.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\basemask.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\basemsgs.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\bmsk_ver.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\btiter.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\btiter.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\btree.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\btree.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\check.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\collect.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\collect.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\deflate.c
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\deflate.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\doccol.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\doccol.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\document.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\document.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\dummies.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\gardefs.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\garutils.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\garutils.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\gkdb_ver.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\hindex.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\hindex.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\index.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\index.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\indices.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\indices.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\infblock.c
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\infblock.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\infcodes.c
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\infcodes.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\inffast.c
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\inffast.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\inflate.c
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\inftrees.c
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\inftrees.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\infutil.c
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\infutil.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\ncpf.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\ncpf.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\newdoc.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\newdoc.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\osdummy.c
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\pack.c
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\pack.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\pagefile.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\pagefile.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\refcol.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\refcol.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\stdbase.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\stdbase.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\store.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\streams.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\streams.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\trees.c
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\unzip.c
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\zconf.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\zlib.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\zutil.c
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\zutil.h
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
# Begin Group "lex"

# PROP Default_Filter "h;c;cpp"
# Begin Source File

SOURCE=..\..\..\libs\lex\include\lex.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\lex\src\lex_basis.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\lex\include\lex_basis.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\lex\src\lex_operator.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\lex\include\lex_operator.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\lex\src\lex_parser.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\lex\include\lex_parser.h
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

SOURCE=..\..\..\libs\gctx\src\u_int64_t.CtxLongSet.Map.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gctx\src\u_int64_t.CtxLongSet.SplayMap.cpp
# End Source File
# End Group
# End Group
# Begin Source File

SOURCE=..\src\cacheIndex.cpp
# End Source File
# Begin Source File

SOURCE=..\src\cacheIndex.h
# End Source File
# Begin Source File

SOURCE="..\src\dbproc.m-reader.cpp"
# End Source File
# Begin Source File

SOURCE="..\src\dbproc.m-reader.h"
# End Source File
# Begin Source File

SOURCE="..\src\dbproc.m-to-gkdb.cpp"
# End Source File
# Begin Source File

SOURCE="..\src\dbproc.m-to-gkdb.h"
# End Source File
# Begin Source File

SOURCE=..\src\mf2gardb.cpp
# End Source File
# End Target
# End Project
