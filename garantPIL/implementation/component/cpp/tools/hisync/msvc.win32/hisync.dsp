# Microsoft Developer Studio Project File - Name="hisync" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Console Application" 0x0103

CFG=hisync - Win32 Debug56x
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "hisync.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "hisync.mak" CFG="hisync - Win32 Debug56x"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "hisync - Win32 Release" (based on "Win32 (x86) Console Application")
!MESSAGE "hisync - Win32 Debug" (based on "Win32 (x86) Console Application")
!MESSAGE "hisync - Win32 Release56x" (based on "Win32 (x86) Console Application")
!MESSAGE "hisync - Win32 Debug56x" (based on "Win32 (x86) Console Application")
!MESSAGE "hisync - Win32 Release61" (based on "Win32 (x86) Console Application")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
RSC=rc.exe

!IF  "$(CFG)" == "hisync - Win32 Release"

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
# ADD CPP /nologo /G4 /Zp1 /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS" /YX /FD /c
# ADD BASE RSC /l 0x419 /d "NDEBUG"
# ADD RSC /l 0x419 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /machine:I386
# ADD LINK32 /nologo /subsystem:console /machine:I386

!ELSEIF  "$(CFG)" == "hisync - Win32 Debug"

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
# ADD BASE CPP /nologo /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_CONSOLE" /D "_MBCS" /YX /FD /GZ /c
# ADD CPP /nologo /G5 /Zp1 /ML /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /D "WIN32" /D "_DEBUG" /D "_CONSOLE" /D "_MBCS" /FR /YX /FD /GZ /c
# ADD BASE RSC /l 0x419 /d "_DEBUG"
# ADD RSC /l 0x419 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /debug /machine:I386 /pdbtype:sept
# ADD LINK32 oldnames.lib kernel32.lib libcd.lib /nologo /subsystem:console /debug /machine:I386 /nodefaultlib:"libc.lib" /nodefaultlib /pdbtype:sept

!ELSEIF  "$(CFG)" == "hisync - Win32 Release56x"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "hisync___Win32_Release56x"
# PROP BASE Intermediate_Dir "hisync___Win32_Release56x"
# PROP BASE Ignore_Export_Lib 0
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release56x"
# PROP Intermediate_Dir "Release56x"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /G4 /Zp1 /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS" /YX /FD /c
# ADD CPP /nologo /G4 /Zp1 /w /W0 /Gi /GX /Zi /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS" /D "OPT_PACK" /D "MULTI_INDEX_STREAM_FILE" /D "INSTLL_CIB" /FR /YX /FD /c
# ADD BASE RSC /l 0x419 /d "NDEBUG"
# ADD RSC /l 0x419 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 /nologo /subsystem:console /machine:I386
# ADD LINK32 /nologo /subsystem:console /debug /machine:I386

!ELSEIF  "$(CFG)" == "hisync - Win32 Debug56x"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "hisync___Win32_Debug56x"
# PROP BASE Intermediate_Dir "hisync___Win32_Debug56x"
# PROP BASE Ignore_Export_Lib 0
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "Debug56x"
# PROP Intermediate_Dir "Debug56x"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /G5 /Zp1 /ML /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /D "WIN32" /D "_DEBUG" /D "_CONSOLE" /D "_MBCS" /FR /YX /FD /GZ /c
# ADD CPP /nologo /G5 /Zp1 /ML /w /W0 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /D "WIN32" /D "_DEBUG" /D "_CONSOLE" /D "_MBCS" /D "OPT_PACK" /D "MULTI_INDEX_STREAM_FILE" /D "INSTLL_CIB" /FR /YX /FD /GZ /c
# ADD BASE RSC /l 0x419 /d "_DEBUG"
# ADD RSC /l 0x419 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 oldnames.lib kernel32.lib libcd.lib /nologo /subsystem:console /debug /machine:I386 /nodefaultlib:"libc.lib" /nodefaultlib /pdbtype:sept
# ADD LINK32 oldnames.lib kernel32.lib libcd.lib /nologo /subsystem:console /debug /machine:I386 /nodefaultlib:"libc.lib" /pdbtype:sept
# SUBTRACT LINK32 /nodefaultlib

!ELSEIF  "$(CFG)" == "hisync - Win32 Release61"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "hisync___Win32_Release61"
# PROP BASE Intermediate_Dir "hisync___Win32_Release61"
# PROP BASE Ignore_Export_Lib 0
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release61"
# PROP Intermediate_Dir "Release61"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /G4 /Zp1 /w /W0 /Gi /GX /Zi /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS" /D "OPT_PACK" /D "MULTI_INDEX_STREAM_FILE" /D "INSTLL_CIB" /FR /YX /FD /c
# ADD CPP /nologo /G4 /Zp1 /w /W0 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS" /D "OPT_PACK" /D "MULTI_INDEX_STREAM_FILE" /D "INSTLL_CIB" /D "VERSION61" /YX /FD /c
# SUBTRACT CPP /Z<none> /Fr
# ADD BASE RSC /l 0x419 /d "NDEBUG"
# ADD RSC /l 0x419 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 /nologo /subsystem:console /debug /machine:I386
# ADD LINK32 /nologo /subsystem:console /machine:I386
# SUBTRACT LINK32 /debug

!ENDIF 

# Begin Target

# Name "hisync - Win32 Release"
# Name "hisync - Win32 Debug"
# Name "hisync - Win32 Release56x"
# Name "hisync - Win32 Debug56x"
# Name "hisync - Win32 Release61"
# Begin Group "Source Files"

# PROP Default_Filter "cpp;c;cxx;rc;def;r;odl;idl;hpj;bat"
# Begin Source File

SOURCE=..\src\cmdline.c
# End Source File
# Begin Source File

SOURCE=..\src\hisync.c
# End Source File
# Begin Source File

SOURCE=..\src\main.c
# End Source File
# Begin Source File

SOURCE=..\src\ready.cpp
# End Source File
# Begin Source File

SOURCE=..\src\synchind.c
# End Source File
# End Group
# Begin Group "Header Files"

# PROP Default_Filter "h;hpp;hxx;hm;inl"
# End Group
# Begin Group "Resource Files"

# PROP Default_Filter "ico;cur;bmp;dlg;rc2;rct;bin;rgs;gif;jpg;jpeg;jpe"
# End Group
# Begin Group "cchlp"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\advlog.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\advlog.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\casestring.defs.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\cchlp_ver.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\cltreenode.defs.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\cltreenode.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\clTreeNode.Set.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\cltreenode.set.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\cltreenode.splaynode.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\clTreeNode.SplaySet.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\cltreenode.splayset.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\errhandler.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\errhandler.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\FString.caddr_t.Map.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\fstring.caddr_t.map.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\FString.caddr_t.SplayMap.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\fstring.caddr_t.splaymap.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\fstring.defs.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\fstring.fstring.map.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\fstring.fstring.splaymap.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\fstring.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\fstring.long.map.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\fstring.long.splaymap.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\fstring.set.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\fstring.splaynode.h
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

SOURCE=..\..\..\libs\cchlp\src\long.caddr_t.Map.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\long.caddr_t.map.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\long.caddr_t.SplayMap.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\long.caddr_t.splaymap.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\long.defs.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\long.long.Map.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\long.long.map.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\long.long.SplayMap.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\long.long.splaymap.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\long.Set.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\long.set.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\long.splaynode.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\long.SplaySet.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\long.splayset.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\pix.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\recode.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\recode.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\u_int32_t.caddr_t.map.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\u_int32_t.caddr_t.splaymap.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\u_int32_t.defs.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\u_int32_t.Set.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\u_int32_t.set.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\u_int32_t.splaynode.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\u_int32_t.SplaySet.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\u_int32_t.splayset.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\u_int64_t.defs.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\u_int64_t.Set.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\u_int64_t.set.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\u_int64_t.splaynode.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\u_int64_t.SplaySet.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\u_int64_t.splayset.h
# End Source File
# End Group
# Begin Group "VControl"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\..\libs\VControl\src\vapi.c
# End Source File
# End Group
# Begin Group "GSSCREEN_Lib"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\..\libs\gsscreen\src\face.c
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gsscreen\src\gsscreen.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gsscreen\src\pscreen.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gsscreen\src\screen.c
# End Source File
# End Group
# Begin Group "MRG_Lib"

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
# Begin Group "GKDB"

# PROP Default_Filter ""
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
# End Target
# End Project
