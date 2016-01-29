# Microsoft Developer Studio Project File - Name="ggrev" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Console Application" 0x0103

CFG=ggrev - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "ggrev.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "ggrev.mak" CFG="ggrev - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "ggrev - Win32 Release" (based on "Win32 (x86) Console Application")
!MESSAGE "ggrev - Win32 Debug" (based on "Win32 (x86) Console Application")
!MESSAGE "ggrev - Win32 Release56x" (based on "Win32 (x86) Console Application")
!MESSAGE "ggrev - Win32 Release61" (based on "Win32 (x86) Console Application")
!MESSAGE "ggrev - Win32 Release62" (based on "Win32 (x86) Console Application")
!MESSAGE "ggrev - Win32 Release63" (based on "Win32 (x86) Console Application")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName "ggrev"
# PROP Scc_LocalPath "."
CPP=cl.exe
RSC=rc.exe

!IF  "$(CFG)" == "ggrev - Win32 Release"

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
# ADD CPP /nologo /Zp1 /W3 /GX /Ox /I "..\..\..\libs\gctx\src" /I "..\..\..\libs\gkdb\src" /I "..\..\..\libs\inifile\src" /I "..\..\..\libs\cchlp\src" /I "..\..\..\include" /I "..\..\..\include\win32" /I "..\..\..\libs\delta\src" /I "..\..\..\libs\gsscreen\src" /D "NDEBUG" /D "WIN32" /D "__x86__" /D "__WIN32__" /D "_WINDOWS" /D "_CONSOLE" /D "_MBCS" /D "CODETYPE_DOS" /D "VERSION56" /YX /FD /Gs /c
# SUBTRACT CPP /Ot /Ow /Og /Oi /Fr
# ADD BASE RSC /l 0x419 /d "NDEBUG"
# ADD RSC /l 0x419 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /machine:I386
# ADD LINK32 /nologo /stack:0xa00000,0x100000 /subsystem:console /machine:I386 /out:"Release/grev.exe"

!ELSEIF  "$(CFG)" == "ggrev - Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug"
# PROP BASE Intermediate_Dir "Debug"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "Debug"
# PROP Intermediate_Dir "Debug"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_CONSOLE" /D "_MBCS" /YX /FD /GZ /c
# ADD CPP /nologo /Zp1 /W3 /Gm /GX /ZI /Od /I "..\..\..\libs\gctx\src" /I "..\..\..\libs\gkdb\src" /I "..\..\..\libs\inifile\src" /I "..\..\..\libs\cchlp\src" /I "..\..\..\include" /I "..\..\..\include\win32" /I "..\..\..\libs\delta\src" /I "..\..\..\libs\gsscreen\src" /D "_DEBUG" /D "WIN32" /D "__x86__" /D "__WIN32__" /D "_WINDOWS" /D "_CONSOLE" /D "_MBCS" /D "CODETYPE_DOS" /D "VERSION56" /D "BLOCKSINHERIT" /FR /YX /FD /GZ /c
# ADD BASE RSC /l 0x419 /d "_DEBUG"
# ADD RSC /l 0x419 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /debug /machine:I386 /pdbtype:sept
# ADD LINK32 /nologo /stack:0xa00000,0x100000 /subsystem:console /debug /machine:I386 /pdbtype:sept

!ELSEIF  "$(CFG)" == "ggrev - Win32 Release56x"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "ggrev___Win32_Release56x"
# PROP BASE Intermediate_Dir "ggrev___Win32_Release56x"
# PROP BASE Ignore_Export_Lib 0
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release56x"
# PROP Intermediate_Dir "Release56x"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /Zp1 /W3 /GX /Ox /I "..\..\..\libs\gctx\src" /I "..\..\..\libs\gkdb\src" /I "..\..\..\libs\inifile\src" /I "..\..\..\libs\cchlp\src" /I "..\..\..\include" /I "..\..\..\include\win32" /I "..\..\..\libs\delta\src" /I "..\..\..\libs\gsscreen\src" /D "NDEBUG" /D "WIN32" /D "__x86__" /D "__WIN32__" /D "_WINDOWS" /D "_CONSOLE" /D "_MBCS" /D "CODETYPE_DOS" /YX /FD /Gs /c
# SUBTRACT BASE CPP /Ot /Ow /Og /Oi /Fr
# ADD CPP /nologo /Zp1 /W3 /GX /Ox /I "..\..\..\libs\gctx\src" /I "..\..\..\libs\gkdb\src" /I "..\..\..\libs\inifile\src" /I "..\..\..\libs\cchlp\src" /I "..\..\..\include" /I "..\..\..\include\win32" /I "..\..\..\libs\delta\src" /I "..\..\..\libs\gsscreen\src" /D "NDEBUG" /D "WIN32" /D "__x86__" /D "__WIN32__" /D "_WINDOWS" /D "_CONSOLE" /D "_MBCS" /D "CODETYPE_DOS" /D "MULTI_INDEX_STREAM_FILE" /D "INSTLL_CIB" /D "VERSION56" /YX /FD /Gs /c
# SUBTRACT CPP /Ot /Ow /Og /Oi /Fr
# ADD BASE RSC /l 0x419 /d "NDEBUG"
# ADD RSC /l 0x419 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 /nologo /stack:0xa00000,0x100000 /subsystem:console /machine:I386 /out:"Release/grev.exe"
# ADD LINK32 /nologo /stack:0xa00000,0x100000 /subsystem:console /machine:I386 /out:"Release56x/grev.exe"

!ELSEIF  "$(CFG)" == "ggrev - Win32 Release61"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "ggrev___Win32_Release61"
# PROP BASE Intermediate_Dir "ggrev___Win32_Release61"
# PROP BASE Ignore_Export_Lib 0
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release61"
# PROP Intermediate_Dir "Release61"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /Zp1 /W3 /GX /Ox /I "..\..\..\libs\gctx\src" /I "..\..\..\libs\gkdb\src" /I "..\..\..\libs\inifile\src" /I "..\..\..\libs\cchlp\src" /I "..\..\..\include" /I "..\..\..\include\win32" /I "..\..\..\libs\delta\src" /I "..\..\..\libs\gsscreen\src" /D "NDEBUG" /D "WIN32" /D "__x86__" /D "__WIN32__" /D "_WINDOWS" /D "_CONSOLE" /D "_MBCS" /D "CODETYPE_DOS" /D "MULTI_INDEX_STREAM_FILE" /D "INSTLL_CIB" /D "VERSION56" /YX /FD /Gs /c
# SUBTRACT BASE CPP /Ot /Ow /Og /Oi /Fr
# ADD CPP /nologo /Zp1 /w /W0 /GX /O2 /I "..\..\..\libs\gctx\src" /I "..\..\..\libs\gkdb\src" /I "..\..\..\libs\inifile\src" /I "..\..\..\libs\cchlp\src" /I "..\..\..\include" /I "..\..\..\include\win32" /I "..\..\..\libs\delta\src" /I "..\..\..\libs\gsscreen\src" /D "NDEBUG" /D "WIN32" /D "__x86__" /D "__WIN32__" /D "_WINDOWS" /D "_CONSOLE" /D "_MBCS" /D "CODETYPE_DOS" /D "VERSION61" /D "NEMESIS" /D "MULTI_INDEX_STREAM_FILE" /D "INSTLL_CIB" /D "VERSION56" /YX /FD /Gs /c
# SUBTRACT CPP /Fr
# ADD BASE RSC /l 0x419 /d "NDEBUG"
# ADD RSC /l 0x419 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 /nologo /stack:0xa00000,0x100000 /subsystem:console /machine:I386 /out:"Release56x/grev.exe"
# ADD LINK32 /nologo /stack:0xa00000,0x100000 /subsystem:console /machine:I386 /nodefaultlib:"libcmt" /out:"Release61/grev.exe"
# SUBTRACT LINK32 /pdb:none /debug

!ELSEIF  "$(CFG)" == "ggrev - Win32 Release62"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "ggrev___Win32_Release62"
# PROP BASE Intermediate_Dir "ggrev___Win32_Release62"
# PROP BASE Ignore_Export_Lib 0
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release62"
# PROP Intermediate_Dir "Release62"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /Zp1 /w /W0 /GX /O2 /I "..\..\..\libs\gctx\src" /I "..\..\..\libs\gkdb\src" /I "..\..\..\libs\inifile\src" /I "..\..\..\libs\cchlp\src" /I "..\..\..\include" /I "..\..\..\include\win32" /I "..\..\..\libs\delta\src" /I "..\..\..\libs\gsscreen\src" /D "NDEBUG" /D "WIN32" /D "__x86__" /D "__WIN32__" /D "_WINDOWS" /D "_CONSOLE" /D "_MBCS" /D "CODETYPE_DOS" /D "VERSION61" /D "NEMESIS" /D "MULTI_INDEX_STREAM_FILE" /D "INSTLL_CIB" /D "VERSION56" /YX /FD /Gs /c
# SUBTRACT BASE CPP /Fr
# ADD CPP /nologo /Zp1 /w /W0 /GX /O2 /I "..\..\..\libs\gctx\src" /I "..\..\..\libs\gkdb\src" /I "..\..\..\libs\inifile\src" /I "..\..\..\libs\cchlp\src" /I "..\..\..\include" /I "..\..\..\include\win32" /I "..\..\..\libs\delta\src" /I "..\..\..\libs\gsscreen\src" /D "NDEBUG" /D "WIN32" /D "__x86__" /D "__WIN32__" /D "_WINDOWS" /D "_CONSOLE" /D "_MBCS" /D "CODETYPE_DOS" /D "VERSION61" /D "NEMESIS" /D "MULTI_INDEX_STREAM_FILE" /D "INSTLL_CIB" /D "VERSION56" /D "VERSION62" /YX /FD /Gs /c
# SUBTRACT CPP /Fr
# ADD BASE RSC /l 0x419 /d "NDEBUG"
# ADD RSC /l 0x419 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 /nologo /stack:0xa00000,0x100000 /subsystem:console /machine:I386 /nodefaultlib:"libcmt" /out:"Release61/grev.exe"
# SUBTRACT BASE LINK32 /pdb:none /debug
# ADD LINK32 /nologo /stack:0xa00000,0x100000 /subsystem:console /machine:I386 /nodefaultlib:"libcmt" /out:"Release62/grev.exe"
# SUBTRACT LINK32 /pdb:none /debug

!ELSEIF  "$(CFG)" == "ggrev - Win32 Release63"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "ggrev___Win32_Release63"
# PROP BASE Intermediate_Dir "ggrev___Win32_Release63"
# PROP BASE Ignore_Export_Lib 0
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release63"
# PROP Intermediate_Dir "Release63"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /Zp1 /w /W0 /GX /O2 /I "..\..\..\libs\gctx\src" /I "..\..\..\libs\gkdb\src" /I "..\..\..\libs\inifile\src" /I "..\..\..\libs\cchlp\src" /I "..\..\..\include" /I "..\..\..\include\win32" /I "..\..\..\libs\delta\src" /I "..\..\..\libs\gsscreen\src" /D "NDEBUG" /D "WIN32" /D "__x86__" /D "__WIN32__" /D "_WINDOWS" /D "_CONSOLE" /D "_MBCS" /D "CODETYPE_DOS" /D "VERSION61" /D "NEMESIS" /D "MULTI_INDEX_STREAM_FILE" /D "INSTLL_CIB" /D "VERSION56" /D "VERSION62" /YX /FD /Gs /c
# SUBTRACT BASE CPP /Fr
# ADD CPP /nologo /Zp1 /w /W0 /GX /O2 /I "..\..\..\libs\gctx\src" /I "..\..\..\libs\gkdb\src" /I "..\..\..\libs\inifile\src" /I "..\..\..\libs\cchlp\src" /I "..\..\..\include" /I "..\..\..\include\win32" /I "..\..\..\libs\delta\src" /I "..\..\..\libs\gsscreen\src" /D "NDEBUG" /D "WIN32" /D "__x86__" /D "__WIN32__" /D "_WINDOWS" /D "_CONSOLE" /D "_MBCS" /D "CODETYPE_DOS" /D "VERSION61" /D "NEMESIS" /D "MULTI_INDEX_STREAM_FILE" /D "INSTLL_CIB" /D "VERSION56" /D "VERSION62" /D "VERSION63" /YX /FD /Gs /c
# SUBTRACT CPP /Fr
# ADD BASE RSC /l 0x419 /d "NDEBUG"
# ADD RSC /l 0x419 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 /nologo /stack:0xa00000,0x100000 /subsystem:console /machine:I386 /nodefaultlib:"libcmt" /out:"Release62/grev.exe"
# SUBTRACT BASE LINK32 /pdb:none /debug
# ADD LINK32 /nologo /stack:0xa00000,0x100000 /subsystem:console /machine:I386 /nodefaultlib:"libcmt" /out:"Release63/grev.exe"
# SUBTRACT LINK32 /pdb:none /debug

!ENDIF 

# Begin Target

# Name "ggrev - Win32 Release"
# Name "ggrev - Win32 Debug"
# Name "ggrev - Win32 Release56x"
# Name "ggrev - Win32 Release61"
# Name "ggrev - Win32 Release62"
# Name "ggrev - Win32 Release63"
# Begin Group "Source Files"

# PROP Default_Filter "cpp;c;cxx;rc;def;r;odl;idl;hpj;bat"
# Begin Group "mrglib"

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
# Begin Group "64Map"

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
# Begin Source File

SOURCE=..\src\reviser.cpp
# End Source File
# Begin Source File

SOURCE=..\src\setrev.cpp
# End Source File
# End Group
# Begin Group "Header Files"

# PROP Default_Filter "h;hpp;hxx;hm;inl"
# Begin Source File

SOURCE=..\..\..\libs\delta\src\adds.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\base.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\basemask.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\basemsgs.h
# End Source File
# Begin Source File

SOURCE="C:\Program Files\Microsoft Visual Studio\VC98\Include\BASETSD.H"
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\bmsk_ver.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\btiter.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\btree.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\cchlp_ver.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\check.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\collect.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\delta\src\delt_ver.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\delta\src\deltadef.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\delta\src\dhr_ver.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\delta\src\dltcomon.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\doccol.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\dociter.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\document.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\gardefs.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\garutils.h
# End Source File
# Begin Source File

SOURCE=..\..\..\include\garver.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gctx\src\gctxl_ver.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\gkdb_ver.h
# End Source File
# Begin Source File

SOURCE=..\src\grev_ver.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gsscreen\src\gsscreen.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\hindex.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\index.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\indices.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\Logger.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\Map.h
# End Source File
# Begin Source File

SOURCE=..\..\..\include\osdep.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\pagefile.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gsscreen\src\pscreen.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\recode.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\refcol.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\rev.h
# End Source File
# Begin Source File

SOURCE=..\src\reviser.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\Set.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\SharedData.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\SplayMap.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\SplaySet.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\stdbase.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\StorableSplaySet.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\store.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\streams.h
# End Source File
# Begin Source File

SOURCE=..\..\..\include\win32\strings.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\stringz.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\typecmp.h
# End Source File
# Begin Source File

SOURCE=..\..\..\include\win32\unistd.h
# End Source File
# End Group
# Begin Group "Resource Files"

# PROP Default_Filter "ico;cur;bmp;dlg;rc2;rct;bin;rgs;gif;jpg;jpeg;jpe"
# End Group
# End Target
# End Project
