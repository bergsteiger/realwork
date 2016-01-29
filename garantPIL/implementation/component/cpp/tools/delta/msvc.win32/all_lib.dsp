# Microsoft Developer Studio Project File - Name="all_lib" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Static Library" 0x0104

CFG=all_lib - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "all_lib.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "all_lib.mak" CFG="all_lib - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "all_lib - Win32 Release" (based on "Win32 (x86) Static Library")
!MESSAGE "all_lib - Win32 Debug" (based on "Win32 (x86) Static Library")
!MESSAGE "all_lib - Win32 Release56x" (based on "Win32 (x86) Static Library")
!MESSAGE "all_lib - Win32 Release61" (based on "Win32 (x86) Static Library")
!MESSAGE "all_lib - Win32 Release62" (based on "Win32 (x86) Static Library")
!MESSAGE "all_lib - Win32 Release63" (based on "Win32 (x86) Static Library")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName "all_lib"
# PROP Scc_LocalPath "."
CPP=cl.exe
RSC=rc.exe

!IF  "$(CFG)" == "all_lib - Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release"
# PROP BASE Intermediate_Dir "Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release"
# PROP Intermediate_Dir "Release"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_MBCS" /D "_LIB" /YX /FD /c
# ADD CPP /nologo /Zp1 /W3 /GX /Ox /I "..\..\..\libs\gctx\src" /I "..\..\..\libs\gkdb\src" /I "..\..\..\libs\inifile\src" /I "..\..\..\libs\cchlp\src" /I "..\..\..\include" /I "..\..\..\include\win32" /I "..\..\..\libs\delta\src" /I "..\..\..\libs\gsscreen\src" /D "NDEBUG" /D "WIN32" /D "__x86__" /D "__WIN32__" /D "_WINDOWS" /D "_CONSOLE" /D "_MBCS" /D "_LIB" /D "CODETYPE_DOS" /D "VERSION56" /YX /FD /c
# ADD BASE RSC /l 0x419 /d "NDEBUG"
# ADD RSC /l 0x419 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LIB32=link.exe -lib
# ADD BASE LIB32 /nologo
# ADD LIB32 /nologo

!ELSEIF  "$(CFG)" == "all_lib - Win32 Debug"

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
# ADD BASE CPP /nologo /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_MBCS" /D "_LIB" /YX /FD /GZ /c
# ADD CPP /nologo /Zp1 /W3 /Gm /GX /ZI /Od /I "..\..\..\libs\gctx\src" /I "..\..\..\libs\gkdb\src" /I "..\..\..\libs\inifile\src" /I "..\..\..\libs\cchlp\src" /I "..\..\..\include" /I "..\..\..\include\win32" /I "..\..\..\libs\delta\src" /I "..\..\..\libs\gsscreen\src" /D "_DEBUG" /D "WIN32" /D "__x86__" /D "__WIN32__" /D "_WINDOWS" /D "_CONSOLE" /D "_MBCS" /D "_LIB" /D "CODETYPE_DOS" /D "VERSION56" /D "BLOCKSINHERIT" /FR /FD /GZ /c
# SUBTRACT CPP /YX
# ADD BASE RSC /l 0x419 /d "_DEBUG"
# ADD RSC /l 0x419 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LIB32=link.exe -lib
# ADD BASE LIB32 /nologo
# ADD LIB32 /nologo

!ELSEIF  "$(CFG)" == "all_lib - Win32 Release56x"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "all_lib___Win32_Release56x"
# PROP BASE Intermediate_Dir "all_lib___Win32_Release56x"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release56x"
# PROP Intermediate_Dir "Release56x"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /Zp1 /W3 /GX /Ox /I "..\..\..\libs\gctx\src" /I "..\..\..\libs\gkdb\src" /I "..\..\..\libs\inifile\src" /I "..\..\..\libs\cchlp\src" /I "..\..\..\include" /I "..\..\..\include\win32" /I "..\..\..\libs\delta\src" /I "..\..\..\libs\gsscreen\src" /D "NDEBUG" /D "WIN32" /D "__x86__" /D "__WIN32__" /D "_WINDOWS" /D "_CONSOLE" /D "_MBCS" /D "_LIB" /D "CODETYPE_DOS" /YX /FD /c
# ADD CPP /nologo /Zp1 /W3 /GX /O2 /I "..\..\..\libs\gctx\src" /I "..\..\..\libs\gkdb\src" /I "..\..\..\libs\inifile\src" /I "..\..\..\libs\cchlp\src" /I "..\..\..\include" /I "..\..\..\include\win32" /I "..\..\..\libs\delta\src" /I "..\..\..\libs\gsscreen\src" /D "NDEBUG" /D "WIN32" /D "__x86__" /D "__WIN32__" /D "_WINDOWS" /D "_CONSOLE" /D "_MBCS" /D "CODETYPE_DOS" /D "MULTI_INDEX_STREAM_FILE" /D "INSTLL_CIB" /D "QUICK_NEW_DOC" /D "STORE_FORM_N" /D "ONLY_NORM_INDEX" /D "VERSION56" /D "BLOCKSINHERIT" /YX /FD /c
# SUBTRACT CPP /Fr
# ADD BASE RSC /l 0x419 /d "NDEBUG"
# ADD RSC /l 0x419 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LIB32=link.exe -lib
# ADD BASE LIB32 /nologo
# ADD LIB32 /nologo

!ELSEIF  "$(CFG)" == "all_lib - Win32 Release61"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "all_lib___Win32_Release61"
# PROP BASE Intermediate_Dir "all_lib___Win32_Release61"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release61"
# PROP Intermediate_Dir "Release61"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /Zp1 /W3 /GX /O2 /I "..\..\..\libs\gctx\src" /I "..\..\..\libs\gkdb\src" /I "..\..\..\libs\inifile\src" /I "..\..\..\libs\cchlp\src" /I "..\..\..\include" /I "..\..\..\include\win32" /I "..\..\..\libs\delta\src" /I "..\..\..\libs\gsscreen\src" /D "NDEBUG" /D "WIN32" /D "__x86__" /D "__WIN32__" /D "_WINDOWS" /D "_CONSOLE" /D "_MBCS" /D "CODETYPE_DOS" /D "MULTI_INDEX_STREAM_FILE" /D "INSTLL_CIB" /D "QUICK_NEW_DOC" /D "STORE_FORM_N" /D "ONLY_NORM_INDEX" /D "VERSION56" /D "BLOCKSINHERIT" /D "NEMESIS" /YX /FD /c
# SUBTRACT BASE CPP /Fr
# ADD CPP /nologo /Zp1 /w /W0 /GX /O2 /I "..\..\..\libs\gctx\src" /I "..\..\..\libs\gkdb\src" /I "..\..\..\libs\inifile\src" /I "..\..\..\libs\cchlp\src" /I "..\..\..\include" /I "..\..\..\include\win32" /I "..\..\..\libs\delta\src" /I "..\..\..\libs\gsscreen\src" /D "NDEBUG" /D "WIN32" /D "__x86__" /D "__WIN32__" /D "_WINDOWS" /D "_CONSOLE" /D "_MBCS" /D "CODETYPE_DOS" /D "MULTI_INDEX_STREAM_FILE" /D "INSTLL_CIB" /D "QUICK_NEW_DOC" /D "STORE_FORM_N" /D "ONLY_NORM_INDEX" /D "VERSION56" /D "BLOCKSINHERIT" /D "NEMESIS" /D "VERSION61" /D "WINENCODE" /YX /FD /c
# SUBTRACT CPP /Fr
# ADD BASE RSC /l 0x419 /d "NDEBUG"
# ADD RSC /l 0x419 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LIB32=link.exe -lib
# ADD BASE LIB32 /nologo
# ADD LIB32 /nologo

!ELSEIF  "$(CFG)" == "all_lib - Win32 Release62"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "all_lib___Win32_Release62"
# PROP BASE Intermediate_Dir "all_lib___Win32_Release62"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release62"
# PROP Intermediate_Dir "Release62"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /Zp1 /w /W0 /GX /Zi /Od /I "..\..\..\libs\gctx\src" /I "..\..\..\libs\gkdb\src" /I "..\..\..\libs\inifile\src" /I "..\..\..\libs\cchlp\src" /I "..\..\..\include" /I "..\..\..\include\win32" /I "..\..\..\libs\delta\src" /I "..\..\..\libs\gsscreen\src" /D "NDEBUG" /D "WIN32" /D "__x86__" /D "__WIN32__" /D "_WINDOWS" /D "_CONSOLE" /D "_MBCS" /D "CODETYPE_DOS" /D "MULTI_INDEX_STREAM_FILE" /D "INSTLL_CIB" /D "QUICK_NEW_DOC" /D "STORE_FORM_N" /D "ONLY_NORM_INDEX" /D "VERSION56" /D "BLOCKSINHERIT" /D "NEMESIS" /D "VERSION61" /D "WINENCODE" /Fr /YX /FD /c
# ADD CPP /nologo /Zp1 /w /W0 /GX /O2 /I "..\..\..\libs\gctx\src" /I "..\..\..\libs\gkdb\src" /I "..\..\..\libs\inifile\src" /I "..\..\..\libs\cchlp\src" /I "..\..\..\include" /I "..\..\..\include\win32" /I "..\..\..\libs\delta\src" /I "..\..\..\libs\gsscreen\src" /D "NDEBUG" /D "WIN32" /D "__x86__" /D "__WIN32__" /D "_WINDOWS" /D "_CONSOLE" /D "_MBCS" /D "CODETYPE_DOS" /D "MULTI_INDEX_STREAM_FILE" /D "INSTLL_CIB" /D "QUICK_NEW_DOC" /D "STORE_FORM_N" /D "ONLY_NORM_INDEX" /D "VERSION56" /D "BLOCKSINHERIT" /D "NEMESIS" /D "VERSION61" /D "WINENCODE" /D "VERSION62" /YX /FD /c
# SUBTRACT CPP /Fr
# ADD BASE RSC /l 0x419 /d "NDEBUG"
# ADD RSC /l 0x419 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LIB32=link.exe -lib
# ADD BASE LIB32 /nologo
# ADD LIB32 /nologo

!ELSEIF  "$(CFG)" == "all_lib - Win32 Release63"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "all_lib___Win32_Release63"
# PROP BASE Intermediate_Dir "all_lib___Win32_Release63"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release63"
# PROP Intermediate_Dir "Release63"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /Zp1 /w /W0 /GX /O2 /I "..\..\..\libs\gctx\src" /I "..\..\..\libs\gkdb\src" /I "..\..\..\libs\inifile\src" /I "..\..\..\libs\cchlp\src" /I "..\..\..\include" /I "..\..\..\include\win32" /I "..\..\..\libs\delta\src" /I "..\..\..\libs\gsscreen\src" /D "NDEBUG" /D "WIN32" /D "__x86__" /D "__WIN32__" /D "_WINDOWS" /D "_CONSOLE" /D "_MBCS" /D "CODETYPE_DOS" /D "VERSION61" /D "NEMESIS" /D "MULTI_INDEX_STREAM_FILE" /D "INSTLL_CIB" /D "VERSION56" /D "VERSION62" /YX /FD /c
# SUBTRACT BASE CPP /Fr
# ADD CPP /nologo /Zp1 /w /W0 /GX /O2 /I "..\..\..\libs\gctx\src" /I "..\..\..\libs\gkdb\src" /I "..\..\..\libs\inifile\src" /I "..\..\..\libs\cchlp\src" /I "..\..\..\include" /I "..\..\..\include\win32" /I "..\..\..\libs\delta\src" /I "..\..\..\libs\gsscreen\src" /D "NDEBUG" /D "WIN32" /D "__x86__" /D "__WIN32__" /D "_WINDOWS" /D "_CONSOLE" /D "_MBCS" /D "CODETYPE_DOS" /D "MULTI_INDEX_STREAM_FILE" /D "INSTLL_CIB" /D "QUICK_NEW_DOC" /D "STORE_FORM_N" /D "ONLY_NORM_INDEX" /D "VERSION56" /D "BLOCKSINHERIT" /D "NEMESIS" /D "VERSION61" /D "WINENCODE" /D "VERSION62" /D "VERSION63" /YX /FD /c
# SUBTRACT CPP /Fr
# ADD BASE RSC /l 0x419 /d "NDEBUG"
# ADD RSC /l 0x419 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LIB32=link.exe -lib
# ADD BASE LIB32 /nologo
# ADD LIB32 /nologo

!ENDIF 

# Begin Target

# Name "all_lib - Win32 Release"
# Name "all_lib - Win32 Debug"
# Name "all_lib - Win32 Release56x"
# Name "all_lib - Win32 Release61"
# Name "all_lib - Win32 Release62"
# Name "all_lib - Win32 Release63"
# Begin Group "Source Files"

# PROP Default_Filter "cpp;c;cxx;rc;def;r;odl;idl;hpj;bat"
# Begin Group "vcontrol"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\..\libs\VControl\src\vapi.c
# End Source File
# End Group
# Begin Group "gsscreen"

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
# Begin Group "gctx"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\..\libs\gctx\src\ctxwords.cpp
# End Source File
# End Group
# Begin Group "cchlp"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\clTreeNode.Set.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\clTreeNode.SplayNode.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\clTreeNode.SplaySet.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\date.Set.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\date.SplayNode.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\date.SplaySet.cpp
# End Source File
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

SOURCE=..\..\..\libs\cchlp\src\fstring.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\FString.FString.Map.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\FString.FString.SplayMap.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\FString.long.Map.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\FString.long.SplayMap.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\FString.long.VHMap.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\FString.Set.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\FString.SplayNode.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\FString.SplaySet.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\FString.VHSet.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\hidxhlp.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\hnode.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\Logger.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\long.caddr_t.Map.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\long.caddr_t.SplayMap.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\long.long.Map.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\long.long.SplayMap.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\long.long.VHMap.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\long.longSplaySet.Map.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\long.longSplaySet.SplayMap.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\long.Set.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\long.SplayNode.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\long.SplaySet.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\long.VHSet.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\recode.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\Regex.cpp
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

SOURCE=..\..\..\libs\cchlp\src\u_int32_t.FString.Map.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\u_int32_t.FString.SplayMap.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\u_int32_t.FString.VHMap.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\u_int32_t.Set.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\u_int32_t.SplayNode.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\u_int32_t.SplaySet.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\u_int32_t.VHSet.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\u_int64_t.Set.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\u_int64_t.SplayNode.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\u_int64_t.SplaySet.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\u_int64_t.u_int16_t.Map.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\u_int64_t.u_int16_t.SplayMap.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\u_int64_t.VHSet.cpp
# End Source File
# End Group
# Begin Group "inifile"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\..\libs\inifile\src\inifile.cpp
# End Source File
# End Group
# Begin Group "gkdb"

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
# Begin Group "delta"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\..\libs\delta\src\adds.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\delta\src\dhreader.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\delta\src\elems.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\delta\src\hendlers.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\delta\src\tempdoc.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\delta\src\wordcol.cpp
# End Source File
# End Group
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

SOURCE=..\..\..\libs\cchlp\src\CaseString.defs.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\check.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\collect.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gctx\src\ctxwords.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\deflate.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\delta\src\deltadef.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\delta\src\dhr_ver.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\delta\src\dhreader.h
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

SOURCE=..\..\..\libs\delta\src\elems.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\errhandler.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\fltiter.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\FString.caddr_t.Map.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\FString.caddr_t.SplayMap.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\FString.defs.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\FString.FString.Map.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\FString.FString.SplayMap.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\fstring.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\FString.long.Map.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\FString.long.SplayMap.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\FString.Set.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\FString.SplayNode.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\FString.SplaySet.h
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

SOURCE=..\..\..\libs\gkdb\src\gkdb_ver.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gsscreen\src\gsscreen.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\delta\src\hendlers.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\hindex.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\hnode.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\index.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\indices.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\infblock.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\infcodes.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\inffast.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\inftrees.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\infutil.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\inifile\src\inifile.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gsscreen\src\iscreen.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\Logger.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\Map.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\ncpf.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\newdoc.h
# End Source File
# Begin Source File

SOURCE=..\..\..\include\osdep.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\pack.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\pagefile.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\Pix.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\privbase.h
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

SOURCE=..\..\..\libs\delta\src\tempdoc.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gsscreen\src\toys.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\typecmp.h
# End Source File
# Begin Source File

SOURCE=..\..\..\include\win32\unistd.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\inifile\src\wdefs.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\delta\src\wordcol.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\zconf.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\zlib.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\zutil.h
# End Source File
# End Group
# End Target
# End Project
