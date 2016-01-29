# Microsoft Developer Studio Project File - Name="gchange" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Console Application" 0x0103

CFG=gchange - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "gchange.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "gchange.mak" CFG="gchange - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "gchange - Win32 Release" (based on "Win32 (x86) Console Application")
!MESSAGE "gchange - Win32 Debug" (based on "Win32 (x86) Console Application")
!MESSAGE "gchange - Win32 Release56x" (based on "Win32 (x86) Console Application")
!MESSAGE "gchange - Win32 Release61" (based on "Win32 (x86) Console Application")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName "gchange"
# PROP Scc_LocalPath ".."
CPP=cl.exe
RSC=rc.exe

!IF  "$(CFG)" == "gchange - Win32 Release"

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
# ADD CPP /nologo /Zp1 /MD /W3 /GX /O2 /I "../include" /I "../../../include" /I "../../../libs/lex/include" /I "../../../libs/gsscreen/src" /I "../../../libs/gkdb/src" /I "../../../include/win32" /I "../../../libs/gchange/include" /I "../../../libs/cchlp/src" /D "NDEBUG" /D "WIN32" /D "_CONSOLE" /D "_MBCS" /D "_WINDOWS" /YX /FD /c
# ADD BASE RSC /l 0x419 /d "NDEBUG"
# ADD RSC /l 0x419 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /machine:I386
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /incremental:yes /machine:I386

!ELSEIF  "$(CFG)" == "gchange - Win32 Debug"

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
# ADD CPP /nologo /Zp1 /MDd /W2 /Gm /GX /ZI /Od /I "../include" /I "../../../include" /I "../../../libs/lex/include" /I "../../../libs/cchlp/src" /I "../../../libs/gsscreen/src" /I "../../../libs/gkdb/src" /I "../../../include/win32" /I "../../../libs/gchange/include" /D "_DEBUG" /D "WIN32" /D "_CONSOLE" /D "_MBCS" /D "_WINDOWS" /FR /FD /GZ /c
# ADD BASE RSC /l 0x419 /d "_DEBUG"
# ADD RSC /l 0x419 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /debug /machine:I386 /pdbtype:sept
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /debug /machine:I386 /pdbtype:sept
# SUBTRACT LINK32 /nodefaultlib

!ELSEIF  "$(CFG)" == "gchange - Win32 Release56x"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "gchange___Win32_Release56x"
# PROP BASE Intermediate_Dir "gchange___Win32_Release56x"
# PROP BASE Ignore_Export_Lib 0
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release56x"
# PROP Intermediate_Dir "Release56x"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /Zp1 /MD /W3 /GX /O2 /I "../include" /I "../../../include" /I "../../../libs/lex/include" /I "../../../libs/gsscreen/src" /I "../../../libs/gkdb/src" /I "../../../include/win32" /I "../../../libs/gchange/include" /D "NDEBUG" /D "WIN32" /D "_CONSOLE" /D "_MBCS" /D "_WINDOWS" /YX /FD /c
# ADD CPP /nologo /Zp1 /MD /W3 /GX /O2 /I "../include" /I "../../../include" /I "../../../libs/lex/include" /I "../../../libs/gsscreen/src" /I "../../../libs/gkdb/src" /I "../../../include/win32" /I "../../../libs/gchange/include" /I "../../../libs/cchlp/src" /D "NDEBUG" /D "WIN32" /D "_CONSOLE" /D "_MBCS" /D "_WINDOWS" /D "MULTI_INDEX_STREAM_FILE" /D "INSTLL_CIB" /D "OPT_PACK" /D "VERSION56" /YX /FD /c
# ADD BASE RSC /l 0x419 /d "NDEBUG"
# ADD RSC /l 0x419 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /incremental:yes /machine:I386
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /incremental:yes /machine:I386 /nodefaultlib:"libc"

!ELSEIF  "$(CFG)" == "gchange - Win32 Release61"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "gchange___Win32_Release61"
# PROP BASE Intermediate_Dir "gchange___Win32_Release61"
# PROP BASE Ignore_Export_Lib 0
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release61"
# PROP Intermediate_Dir "Release61"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /Zp1 /MD /W3 /GX /O2 /I "../include" /I "../../../include" /I "../../../libs/lex/include" /I "../../../libs/gsscreen/src" /I "../../../libs/gkdb/src" /I "../../../include/win32" /I "../../../libs/gchange/include" /I "../../../libs/cchlp/src" /D "NDEBUG" /D "WIN32" /D "_CONSOLE" /D "_MBCS" /D "_WINDOWS" /D "MULTI_INDEX_STREAM_FILE" /D "INSTLL_CIB" /D "OPT_PACK" /D "VERSION56" /YX /FD /c
# ADD CPP /nologo /Zp1 /MD /W3 /GX /O2 /I "../include" /I "../../../include" /I "../../../libs/lex/include" /I "../../../libs/gsscreen/src" /I "../../../libs/gkdb/src" /I "../../../include/win32" /I "../../../libs/gchange/include" /I "../../../libs/cchlp/src" /D "NDEBUG" /D "WIN32" /D "_CONSOLE" /D "_MBCS" /D "_WINDOWS" /D "MULTI_INDEX_STREAM_FILE" /D "INSTLL_CIB" /D "OPT_PACK" /D "VERSION56" /D "VERSION61" /D "WINENCODE" /YX /FD /c
# ADD BASE RSC /l 0x419 /d "NDEBUG"
# ADD RSC /l 0x419 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /incremental:yes /machine:I386 /nodefaultlib:"libc"
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /incremental:yes /machine:I386 /nodefaultlib:"libc"

!ENDIF 

# Begin Target

# Name "gchange - Win32 Release"
# Name "gchange - Win32 Debug"
# Name "gchange - Win32 Release56x"
# Name "gchange - Win32 Release61"
# Begin Group "Source Files"

# PROP Default_Filter "cpp;c;cxx;rc;def;r;odl;idl;hpj;bat"
# Begin Source File

SOURCE=..\src\gchange.cpp
# End Source File
# End Group
# Begin Group "Header Files"

# PROP Default_Filter "h;hpp;hxx;hm;inl"
# Begin Source File

SOURCE=..\include\gchange.h
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
# Begin Group "lex"

# PROP Default_Filter ""
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
# Begin Group "gchange"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\..\libs\gchange\src\context.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gchange\src\parser.cpp
# End Source File
# End Group
# Begin Group "recode"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\recode.cpp
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
# Begin Group "cchlp"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\errhandler.cpp
# End Source File
# End Group
# End Target
# End Project
