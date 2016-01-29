# Microsoft Developer Studio Project File - Name="gc" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Console Application" 0x0103

CFG=GC - WIN32 RELEASE61
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "gc.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "gc.mak" CFG="GC - WIN32 RELEASE61"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "gc - Win32 Release" (based on "Win32 (x86) Console Application")
!MESSAGE "gc - Win32 Debug" (based on "Win32 (x86) Console Application")
!MESSAGE "gc - Win32 Release56x" (based on "Win32 (x86) Console Application")
!MESSAGE "gc - Win32 Release61" (based on "Win32 (x86) Console Application")
!MESSAGE "gc - Win32 Release62" (based on "Win32 (x86) Console Application")
!MESSAGE "gc - Win32 Release63" (based on "Win32 (x86) Console Application")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
RSC=rc.exe

!IF  "$(CFG)" == "gc - Win32 Release"

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
# ADD CPP /nologo /Zp1 /MT /Gi /GX /O2 /I "..\..\..\include" /I "..\..\..\include\win32" /I "..\..\..\libs\cchlp\src" /I "..\..\..\libs\gc\src" /I "..\..\..\libs\gkdb\src" /I "..\..\..\libs\gctx\src" /I "..\..\..\libs\gsscreen\src" /I "..\..\..\libs\lex\include" /I "..\..\..\libs\gchange\include" /I "..\..\..\tools\gctools\src" /D "NDEBUG" /D "WIN32" /D "_CONSOLE" /D "_MBCS" /D "WITH_DBL_THREAD" /D "OPT_PACK" /D "MULTI_INDEX_STREAM_FILE" /D "PL_REPLCTR_FUNC" /D "MAKE_HDD" /D "NO_GSSCREEN" /D "VERSION56" /D "NEWNODOC" /D "DOC_ONLY" /D "FLUSH56" /D "KERNEL_NOT_USE_CONTEXT" /FD /c
# SUBTRACT CPP /WX /Fr /YX
# ADD BASE RSC /l 0x419 /d "NDEBUG"
# ADD RSC /l 0x419 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 /nologo /subsystem:console /machine:I386 /pdbtype:sept /fixed:no
# ADD LINK32 /nologo /stack:0x2000000,0x2000000 /subsystem:console /machine:I386 /FORCE:MULTIPLE /fixed:no
# SUBTRACT LINK32 /pdb:none /debug /nodefaultlib

!ELSEIF  "$(CFG)" == "gc - Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug"
# PROP BASE Intermediate_Dir "Debug"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "Debug_GC"
# PROP Intermediate_Dir "Debug_GC"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /GX /Od /D "WIN32" /D "_DEBUG" /D "_CONSOLE" /D "_MBCS" /YX /FD /GZ /c
# ADD CPP /nologo /G6 /Zp1 /MTd /w /W0 /WX /Gi /GX /Zi /Od /I "..\..\..\include" /I "..\..\..\include\win32" /I "..\..\..\libs\cchlp\src" /I "..\..\..\libs\gc\src" /I "..\..\..\libs\gkdb\src" /I "..\..\..\libs\gctx\src" /I "..\..\..\libs\gsscreen\src" /I "..\..\..\libs\lex\include" /I "..\..\..\libs\gchange\include" /I "..\..\..\tools\gctools\src" /D "_DEBUG" /D "WIN32" /D "_CONSOLE" /D "_MBCS" /D "WITH_DBL_THREAD" /D "OPT_PACK" /D "NO_GSSCREEN" /D "NEWNODOC" /D "DOC_ONLY" /D "BLOCKSINHERIT" /D "VERSION56" /D "FLUSH56" /D "MULTI_INDEX_STREAM_FILE" /D "PL_REPLCTR_FUNC" /D "MAKE_HDD" /Fr /FD /GZ /c
# SUBTRACT CPP /YX
# ADD BASE RSC /l 0x419 /d "_DEBUG"
# ADD RSC /l 0x419 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 /nologo /subsystem:console /debug /machine:I386 /pdbtype:sept /fixed:no
# ADD LINK32 /nologo /stack:0x4000000,0x4000000 /subsystem:console /incremental:no /debug /machine:I386 /pdbtype:sept /FORCE:MULTIPLE /fixed:no
# SUBTRACT LINK32 /profile /pdb:none /nodefaultlib

!ELSEIF  "$(CFG)" == "gc - Win32 Release56x"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "gc___Win32_Release56x"
# PROP BASE Intermediate_Dir "gc___Win32_Release56x"
# PROP BASE Ignore_Export_Lib 0
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release56x"
# PROP Intermediate_Dir "Release56x"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /Zp1 /MT /W3 /Gi /GX /Zi /Od /I "..\..\..\include" /I "..\..\..\include\win32" /I "..\..\..\libs\cchlp\src" /I "..\..\..\libs\gc\src" /I "..\..\..\libs\gkdb\src" /I "..\..\..\libs\gctx\src" /I "..\..\..\libs\gsscreen\src" /I "..\..\..\libs\lex\include" /I "..\..\..\libs\gchange\include" /I "..\..\..\tools\gctools\src" /D "NDEBUG" /D "WIN32" /D "_CONSOLE" /D "_MBCS" /D "WITH_DBL_THREAD" /D "OPT_PACK" /D "MULTI_INDEX_STREAM_FILE" /D "PL_REPLCTR_FUNC" /D "MAKE_HDD" /D "NO_GSSCREEN" /D "VERSION56" /Fr /FD /c
# SUBTRACT BASE CPP /WX /YX
# ADD CPP /nologo /Zp1 /MT /Gi /GX /O2 /I "..\..\..\include" /I "..\..\..\include\win32" /I "..\..\..\libs\cchlp\src" /I "..\..\..\libs\gc\src" /I "..\..\..\libs\gkdb\src" /I "..\..\..\libs\gctx\src" /I "..\..\..\libs\gsscreen\src" /I "..\..\..\libs\lex\include" /I "..\..\..\libs\gchange\include" /I "..\..\..\tools\gctools\src" /D "NDEBUG" /D "WIN32" /D "_CONSOLE" /D "_MBCS" /D "WITH_DBL_THREAD" /D "OPT_PACK" /D "MULTI_INDEX_STREAM_FILE" /D "PL_REPLCTR_FUNC" /D "MAKE_HDD" /D "NO_GSSCREEN" /D "VERSION56" /D "NEWNODOC" /D "DOC_ONLY" /D "FLUSH56" /D "KERNEL_NOT_USE_CONTEXT" /D "BLOCKSINHERIT" /FD /c
# SUBTRACT CPP /WX /Fr /YX
# ADD BASE RSC /l 0x419 /d "NDEBUG"
# ADD RSC /l 0x419 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 /nologo /stack:0x2000000,0x2000000 /subsystem:console /debug /machine:I386 /FORCE:MULTIPLE /fixed:no
# SUBTRACT BASE LINK32 /pdb:none /nodefaultlib
# ADD LINK32 /nologo /stack:0x2000000,0x2000000 /subsystem:console /machine:I386 /FORCE:MULTIPLE /fixed:no
# SUBTRACT LINK32 /pdb:none /debug /nodefaultlib

!ELSEIF  "$(CFG)" == "gc - Win32 Release61"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "gc___Win32_Release61"
# PROP BASE Intermediate_Dir "gc___Win32_Release61"
# PROP BASE Ignore_Export_Lib 0
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release61"
# PROP Intermediate_Dir "Release61"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /Zp1 /MT /Gi /GX /O2 /I "..\..\..\include" /I "..\..\..\include\win32" /I "..\..\..\libs\cchlp\src" /I "..\..\..\libs\gc\src" /I "..\..\..\libs\gkdb\src" /I "..\..\..\libs\gctx\src" /I "..\..\..\libs\gsscreen\src" /I "..\..\..\libs\lex\include" /I "..\..\..\libs\gchange\include" /I "..\..\..\tools\gctools\src" /D "NDEBUG" /D "WIN32" /D "_CONSOLE" /D "_MBCS" /D "WITH_DBL_THREAD" /D "OPT_PACK" /D "MULTI_INDEX_STREAM_FILE" /D "PL_REPLCTR_FUNC" /D "MAKE_HDD" /D "NO_GSSCREEN" /D "VERSION56" /D "NEWNODOC" /D "DOC_ONLY" /D "FLUSH56" /D "KERNEL_NOT_USE_CONTEXT" /D "VERSION61" /D "WINENCODE" /FD /c
# SUBTRACT BASE CPP /WX /Fr /YX
# ADD CPP /nologo /Zp1 /MT /w /W0 /Gi /GX /O2 /I "..\..\..\include" /I "..\..\..\include\win32" /I "..\..\..\libs\cchlp\src" /I "..\..\..\libs\gc\src" /I "..\..\..\libs\gkdb\src" /I "..\..\..\libs\gctx\src" /I "..\..\..\libs\gsscreen\src" /I "..\..\..\libs\lex\include" /I "..\..\..\libs\gchange\include" /I "..\..\..\tools\gctools\src" /D "NDEBUG" /D "WIN32" /D "_CONSOLE" /D "_MBCS" /D "WITH_DBL_THREAD" /D "OPT_PACK" /D "MULTI_INDEX_STREAM_FILE" /D "PL_REPLCTR_FUNC" /D "MAKE_HDD" /D "NO_GSSCREEN" /D "VERSION56" /D "NEWNODOC" /D "DOC_ONLY" /D "FLUSH56" /D "KERNEL_NOT_USE_CONTEXT" /D "VERSION61" /D "WINENCODE" /FD /c
# SUBTRACT CPP /WX /Fr /YX
# ADD BASE RSC /l 0x419 /d "NDEBUG"
# ADD RSC /l 0x419 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 /nologo /stack:0x2000000,0x2000000 /subsystem:console /machine:I386 /FORCE:MULTIPLE /fixed:no
# SUBTRACT BASE LINK32 /pdb:none /debug /nodefaultlib
# ADD LINK32 /nologo /stack:0x2000000,0x2000000 /subsystem:console /machine:I386 /FORCE:MULTIPLE /fixed:no
# SUBTRACT LINK32 /pdb:none /debug /nodefaultlib

!ELSEIF  "$(CFG)" == "gc - Win32 Release62"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "gc___Win32_Release62"
# PROP BASE Intermediate_Dir "gc___Win32_Release62"
# PROP BASE Ignore_Export_Lib 0
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release62"
# PROP Intermediate_Dir "Release62"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /Zp1 /MT /w /W0 /Gi /GX /Zi /Od /I "..\..\..\include" /I "..\..\..\include\win32" /I "..\..\..\libs\cchlp\src" /I "..\..\..\libs\gc\src" /I "..\..\..\libs\gkdb\src" /I "..\..\..\libs\gctx\src" /I "..\..\..\libs\gsscreen\src" /I "..\..\..\libs\lex\include" /I "..\..\..\libs\gchange\include" /I "..\..\..\tools\gctools\src" /D "NDEBUG" /D "WIN32" /D "_CONSOLE" /D "_MBCS" /D "WITH_DBL_THREAD" /D "OPT_PACK" /D "MULTI_INDEX_STREAM_FILE" /D "PL_REPLCTR_FUNC" /D "MAKE_HDD" /D "NO_GSSCREEN" /D "VERSION56" /D "NEWNODOC" /D "DOC_ONLY" /D "FLUSH56" /D "KERNEL_NOT_USE_CONTEXT" /D "VERSION61" /D "WINENCODE" /Fr /FD /c
# SUBTRACT BASE CPP /WX /YX
# ADD CPP /nologo /Zp1 /MT /w /W0 /Gi /GX /O2 /I "..\..\..\include" /I "..\..\..\include\win32" /I "..\..\..\libs\cchlp\src" /I "..\..\..\libs\gc\src" /I "..\..\..\libs\gkdb\src" /I "..\..\..\libs\gctx\src" /I "..\..\..\libs\gsscreen\src" /I "..\..\..\libs\lex\include" /I "..\..\..\libs\gchange\include" /I "..\..\..\tools\gctools\src" /D "NDEBUG" /D "WIN32" /D "_CONSOLE" /D "_MBCS" /D "WITH_DBL_THREAD" /D "OPT_PACK" /D "MULTI_INDEX_STREAM_FILE" /D "PL_REPLCTR_FUNC" /D "MAKE_HDD" /D "NO_GSSCREEN" /D "VERSION56" /D "NEWNODOC" /D "DOC_ONLY" /D "FLUSH56" /D "KERNEL_NOT_USE_CONTEXT" /D "VERSION61" /D "WINENCODE" /D "VERSION62" /D "BLOCKSINHERIT" /FD /c
# SUBTRACT CPP /WX /Fr /YX
# ADD BASE RSC /l 0x419 /d "NDEBUG"
# ADD RSC /l 0x419 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 /nologo /stack:0x2000000,0x2000000 /subsystem:console /debug /machine:I386 /FORCE:MULTIPLE /fixed:no
# SUBTRACT BASE LINK32 /pdb:none /nodefaultlib
# ADD LINK32 /nologo /stack:0x2000000,0x2000000 /subsystem:console /machine:I386 /FORCE:MULTIPLE /fixed:no
# SUBTRACT LINK32 /pdb:none /debug /nodefaultlib

!ELSEIF  "$(CFG)" == "gc - Win32 Release63"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "gc___Win32_Release63"
# PROP BASE Intermediate_Dir "gc___Win32_Release63"
# PROP BASE Ignore_Export_Lib 0
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release63"
# PROP Intermediate_Dir "Release63"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /Zp1 /MT /w /W0 /Gi /GX /O2 /I "..\..\..\include" /I "..\..\..\include\win32" /I "..\..\..\libs\cchlp\src" /I "..\..\..\libs\gc\src" /I "..\..\..\libs\gkdb\src" /I "..\..\..\libs\gctx\src" /I "..\..\..\libs\gsscreen\src" /I "..\..\..\libs\lex\include" /I "..\..\..\libs\gchange\include" /I "..\..\..\tools\gctools\src" /D "NDEBUG" /D "WIN32" /D "_CONSOLE" /D "_MBCS" /D "WITH_DBL_THREAD" /D "OPT_PACK" /D "MULTI_INDEX_STREAM_FILE" /D "PL_REPLCTR_FUNC" /D "MAKE_HDD" /D "NO_GSSCREEN" /D "VERSION56" /D "NEWNODOC" /D "DOC_ONLY" /D "FLUSH56" /D "KERNEL_NOT_USE_CONTEXT" /D "VERSION61" /D "WINENCODE" /D "VERSION62" /D "BLOCKSINHERIT" /FD /c
# SUBTRACT BASE CPP /WX /Fr /YX
# ADD CPP /nologo /Zp1 /MT /w /W0 /Gi /GX /O2 /I "..\..\..\include" /I "..\..\..\include\win32" /I "..\..\..\libs\cchlp\src" /I "..\..\..\libs\gc\src" /I "..\..\..\libs\gkdb\src" /I "..\..\..\libs\gctx\src" /I "..\..\..\libs\gsscreen\src" /I "..\..\..\libs\lex\include" /I "..\..\..\libs\gchange\include" /I "..\..\..\tools\gctools\src" /D "NDEBUG" /D "WIN32" /D "_CONSOLE" /D "_MBCS" /D "WITH_DBL_THREAD" /D "OPT_PACK" /D "MULTI_INDEX_STREAM_FILE" /D "PL_REPLCTR_FUNC" /D "MAKE_HDD" /D "NO_GSSCREEN" /D "VERSION56" /D "NEWNODOC" /D "DOC_ONLY" /D "FLUSH56" /D "KERNEL_NOT_USE_CONTEXT" /D "VERSION61" /D "WINENCODE" /D "VERSION62" /D "BLOCKSINHERIT" /D "GCTX" /D "VERSION63" /FD /c
# SUBTRACT CPP /WX /Fr /YX
# ADD BASE RSC /l 0x419 /d "NDEBUG"
# ADD RSC /l 0x419 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 /nologo /stack:0x2000000,0x2000000 /subsystem:console /machine:I386 /FORCE:MULTIPLE /fixed:no
# SUBTRACT BASE LINK32 /pdb:none /debug /nodefaultlib
# ADD LINK32 /nologo /stack:0x2000000,0x2000000 /subsystem:console /machine:I386 /FORCE:MULTIPLE /fixed:no
# SUBTRACT LINK32 /pdb:none /debug /nodefaultlib

!ENDIF 

# Begin Target

# Name "gc - Win32 Release"
# Name "gc - Win32 Debug"
# Name "gc - Win32 Release56x"
# Name "gc - Win32 Release61"
# Name "gc - Win32 Release62"
# Name "gc - Win32 Release63"
# Begin Group "flex"

# PROP Default_Filter "flex"
# Begin Source File

SOURCE=..\..\gctools\src\belongs.flex
# End Source File
# Begin Source File

SOURCE=..\..\gctools\src\blobtable.flex
# End Source File
# Begin Source File

SOURCE=..\..\gctools\src\classes.flex
# End Source File
# Begin Source File

SOURCE=..\..\gctools\src\complect.flex
# End Source File
# Begin Source File

SOURCE=..\..\gctools\src\gcini.flex
# End Source File
# Begin Source File

SOURCE=..\..\gctools\src\kwfile.flex
# End Source File
# Begin Source File

SOURCE=..\..\gctools\src\loadStringMap.flex
# End Source File
# Begin Source File

SOURCE=..\..\gctools\src\normfile.flex
# End Source File
# Begin Source File

SOURCE=..\..\gctools\src\sources.flex
# End Source File
# Begin Source File

SOURCE=..\..\gctools\src\sttop.flex
# End Source File
# End Group
# Begin Group "libs"

# PROP Default_Filter "h;c;cpp"
# Begin Group "cchlp"

# PROP Default_Filter "h;c;cpp"
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\advlog.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\date.set.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\date.splayset.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\errhandler.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\fstring.caddr_t.map.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\fstring.caddr_t.splaymap.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\fstring.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\fstring.fstring.map.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\fstring.fstring.splaymap.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\fstring.long.map.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\fstring.long.splaymap.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\fstring.set.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\fstring.splayset.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\hidxhlp.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\hnode.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\long.longsplayset.map.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\long.longsplayset.splaymap.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\long.set.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\long.splayset.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\long.vhset.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\recode.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\u_int32_t.caddr_t.map.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\u_int32_t.caddr_t.splaymap.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\u_int32_t.fstring.map.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\u_int32_t.fstring.splaymap.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\u_int32_t.fstring.vhmap.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\u_int32_t.set.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\u_int32_t.splayset.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\u_int32_t.vhset.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\u_int64_t.set.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\u_int64_t.splayset.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\u_int64_t.vhset.cpp
# End Source File
# End Group
# Begin Group "gc"

# PROP Default_Filter "h;c;cpp"
# Begin Source File

SOURCE=..\..\..\libs\gc\src\dbproc.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gc\src\dbproc.mf.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gc\src\gclog.cpp
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

SOURCE=..\..\..\libs\gkdb\src\dummies.cpp
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

SOURCE=..\..\..\libs\gkdb\src\refcol.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\refcol.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\rev.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\stdbase.cpp
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
# Begin Group "gsscreen"

# PROP Default_Filter "h;c;cpp"
# Begin Source File

SOURCE=..\..\..\libs\gsscreen\src\face.c
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gsscreen\src\gsscreen.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gsscreen\src\screen.c
# End Source File
# End Group
# Begin Group "gchange"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\..\libs\gchange\src\context.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gchange\src\parser.cpp
# End Source File
# End Group
# Begin Group "lex"

# PROP Default_Filter "h;c;cpp"
# Begin Source File

SOURCE=..\..\..\libs\lex\src\lex_basis.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\lex\src\lex_operator.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\lex\src\lex_parser.cpp
# End Source File
# End Group
# End Group
# Begin Source File

SOURCE=..\..\gctools\src\belongs.cpp
# End Source File
# Begin Source File

SOURCE=..\..\gctools\src\blobtable.cpp
# End Source File
# Begin Source File

SOURCE=..\..\gctools\src\cacheIndex.cpp
# End Source File
# Begin Source File

SOURCE=..\..\gctools\src\classes.cpp
# End Source File
# Begin Source File

SOURCE=..\..\gctools\src\complect.cpp
# End Source File
# Begin Source File

SOURCE="..\..\gctools\src\dbproc.m-reader.cpp"
# End Source File
# Begin Source File

SOURCE="..\..\gctools\src\dbproc.m-to-gkdb.cpp"
# End Source File
# Begin Source File

SOURCE="..\..\gctools\src\dbproc.m-writer.cpp"
# End Source File
# Begin Source File

SOURCE=..\..\gctools\src\fstringer.cpp
# End Source File
# Begin Source File

SOURCE=..\src\garcomp.cpp
# End Source File
# Begin Source File

SOURCE=..\..\gctools\src\gcini.cpp
# End Source File
# Begin Source File

SOURCE=..\..\gctools\src\gcpass1.cpp
# End Source File
# Begin Source File

SOURCE=..\..\gctools\src\kwfile.cpp
# End Source File
# Begin Source File

SOURCE=..\..\gctools\src\loadstringmap.cpp
# End Source File
# Begin Source File

SOURCE=..\..\gctools\src\MyPipe.c
# End Source File
# Begin Source File

SOURCE=..\..\gctools\src\normfile.cpp
# End Source File
# Begin Source File

SOURCE=..\..\gctools\src\nsrcheck.cpp

!IF  "$(CFG)" == "gc - Win32 Release"

# PROP Exclude_From_Build 1

!ELSEIF  "$(CFG)" == "gc - Win32 Debug"

# PROP Exclude_From_Build 1

!ELSEIF  "$(CFG)" == "gc - Win32 Release56x"

# PROP BASE Exclude_From_Build 1
# PROP Exclude_From_Build 1

!ELSEIF  "$(CFG)" == "gc - Win32 Release61"

# PROP BASE Exclude_From_Build 1
# PROP Exclude_From_Build 1

!ELSEIF  "$(CFG)" == "gc - Win32 Release62"

# PROP BASE Exclude_From_Build 1
# PROP Exclude_From_Build 1

!ELSEIF  "$(CFG)" == "gc - Win32 Release63"

# PROP BASE Exclude_From_Build 1
# PROP Exclude_From_Build 1

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\gctools\src\nsrcparser.cpp
# End Source File
# Begin Source File

SOURCE=..\..\gctools\src\publish.cpp
# End Source File
# Begin Source File

SOURCE=..\..\gctools\src\sources.cpp
# End Source File
# Begin Source File

SOURCE=..\..\gctools\src\sttop.cpp
# End Source File
# End Target
# End Project
