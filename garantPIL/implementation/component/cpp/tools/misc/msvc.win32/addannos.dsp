# Microsoft Developer Studio Project File - Name="addannos" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Console Application" 0x0103

CFG=addannos - Win32 Release62
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "addannos.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "addannos.mak" CFG="addannos - Win32 Release62"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "addannos - Win32 Release62" (based on "Win32 (x86) Console Application")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
RSC=rc.exe
# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "addannos___Win32_Release62"
# PROP BASE Intermediate_Dir "addannos___Win32_Release62"
# PROP BASE Ignore_Export_Lib 0
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release62"
# PROP Intermediate_Dir "Release62"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /WX /Gi /GX /O2 /I "..\..\..\include" /I "..\..\..\include\win32" /I "..\..\..\libs\cchlp\src" /I "..\..\..\libs\gkdb\src" /I "..\..\..\libs\gsscreen\src" /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS" /D "INSTLL_CIB" /D "MULTI_INDEX_STREAM_FILE" /D "VERSION56" /D "VERSION61" /D "KERNEL_NOT_USE_CONTEXT" /FD /c
# SUBTRACT BASE CPP /Fr /YX
# ADD CPP /nologo /W3 /WX /Gi /GX /O2 /I "..\..\..\include" /I "..\..\..\include\win32" /I "..\..\..\libs\cchlp\src" /I "..\..\..\libs\gkdb\src" /I "..\..\..\libs\gsscreen\src" /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS" /D "INSTLL_CIB" /D "MULTI_INDEX_STREAM_FILE" /D "VERSION56" /D "VERSION61" /D "KERNEL_NOT_USE_CONTEXT" /D "VERSION62" /D "WINENCODE" /FD /c
# SUBTRACT CPP /Z<none> /Fr /YX
# ADD BASE RSC /l 0x419 /d "NDEBUG"
# ADD RSC /l 0x419 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 oldnames.lib kernel32.lib libc.lib /nologo /stack:0xa00000,0x100000 /subsystem:console /machine:I386 /fixed:no
# SUBTRACT BASE LINK32 /pdb:none /incremental:yes /map /debug /nodefaultlib
# ADD LINK32 oldnames.lib kernel32.lib libc.lib /nologo /stack:0xa00000,0x100000 /subsystem:console /machine:I386 /fixed:no
# SUBTRACT LINK32 /pdb:none /incremental:yes /map /debug /nodefaultlib
# Begin Target

# Name "addannos - Win32 Release62"
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

SOURCE=..\..\..\libs\cchlp\src\FString.caddr_t.Map.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\FString.caddr_t.SplayMap.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\FString.Set.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\FString.SplaySet.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\hidxhlp.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\logger.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\recode.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\stringz.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\u_int32_t.caddr_t.Map.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\u_int32_t.caddr_t.SplayMap.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\u_int32_t.Set.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\u_int32_t.SplaySet.cpp
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

SOURCE=..\src\addannos.cpp
# End Source File
# End Target
# End Project
