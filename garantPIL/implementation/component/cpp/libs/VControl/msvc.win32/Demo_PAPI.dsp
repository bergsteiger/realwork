# Microsoft Developer Studio Project File - Name="Demo_PAPI" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Console Application" 0x0103

CFG=Demo_PAPI - Win32 Debug_5_3
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "Demo_PAPI.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "Demo_PAPI.mak" CFG="Demo_PAPI - Win32 Debug_5_3"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "Demo_PAPI - Win32 Release" (based on "Win32 (x86) Console Application")
!MESSAGE "Demo_PAPI - Win32 Debug" (based on "Win32 (x86) Console Application")
!MESSAGE "Demo_PAPI - Win32 Debug_5_3" (based on "Win32 (x86) Console Application")
!MESSAGE "Demo_PAPI - Win32 Release_5_5" (based on "Win32 (x86) Console Application")
!MESSAGE "Demo_PAPI - Win32 Release_5_5_SO" (based on "Win32 (x86) Console Application")
!MESSAGE "Demo_PAPI - Win32 Release_5_4" (based on "Win32 (x86) Console Application")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
RSC=rc.exe

!IF  "$(CFG)" == "Demo_PAPI - Win32 Release"

# PROP BASE Use_MFC 2
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release"
# PROP BASE Intermediate_Dir "Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 2
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release"
# PROP Intermediate_Dir "Release"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS" /D "_AFXDLL" /Yu"stdafx.h" /FD /c
# ADD CPP /nologo /Zp1 /MD /W3 /GX /Zi /Od /I "../../../libs/GPersn/src" /I "../../../include" /I "../../../include/msvc32" /D "NDEBUG" /D "MAKE_HDD" /D "WIN32" /D "_CONSOLE" /D "_MBCS" /D "_AFXDLL" /D "INC_DONGLE_DLL" /D "RD_AS_ETALON" /D "PL_REPLCTR_FUNC" /FR /Yu"stdafx.h" /FD /c
# ADD BASE RSC /l 0x3009 /d "NDEBUG" /d "_AFXDLL"
# ADD RSC /l 0x3009 /d "NDEBUG" /d "_AFXDLL"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /machine:I386
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /debug /machine:I386

!ELSEIF  "$(CFG)" == "Demo_PAPI - Win32 Debug"

# PROP BASE Use_MFC 2
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug"
# PROP BASE Intermediate_Dir "Debug"
# PROP BASE Target_Dir ""
# PROP Use_MFC 2
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "Debug"
# PROP Intermediate_Dir "Debug"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_CONSOLE" /D "_MBCS" /D "_AFXDLL" /Yu"stdafx.h" /FD /GZ /c
# ADD CPP /nologo /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../libs/GPersn/src" /I "../../../include" /I "../../../include/msvc32" /D "_DEBUG" /D "WIN32" /D "_CONSOLE" /D "_MBCS" /D "_AFXDLL" /D "MAKE_HDD" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /D "TEST_MAKE_HDD" /FR /Yu"stdafx.h" /FD /GZ /c
# ADD BASE RSC /l 0x3009 /d "_DEBUG" /d "_AFXDLL"
# ADD RSC /l 0x3009 /d "_DEBUG" /d "_AFXDLL"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /debug /machine:I386 /pdbtype:sept
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /debug /machine:I386 /pdbtype:sept /FORCE:MULTIPLE
# SUBTRACT LINK32 /pdb:none

!ELSEIF  "$(CFG)" == "Demo_PAPI - Win32 Debug_5_3"

# PROP BASE Use_MFC 2
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Demo_PAPI___Win32_Debug_5_3"
# PROP BASE Intermediate_Dir "Demo_PAPI___Win32_Debug_5_3"
# PROP BASE Ignore_Export_Lib 0
# PROP BASE Target_Dir ""
# PROP Use_MFC 2
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "Debug_5_3"
# PROP Intermediate_Dir "Debug_5_3"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../libs/GPersn/src" /I "../../../include" /I "../../../include/msvc32" /D "_DEBUG" /D "WIN32" /D "_CONSOLE" /D "_MBCS" /D "_AFXDLL" /D "MAKE_HDD" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /D "TEST_MAKE_HDD" /FR /Yu"stdafx.h" /FD /GZ /c
# ADD CPP /nologo /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../libs/GPersn/src" /I "../../../include" /I "../../../include/msvc32" /D "_DEBUG" /D "WIN32" /D "_CONSOLE" /D "_MBCS" /D "_AFXDLL" /D "MAKE_HDD" /D "TEST_MAKE_HDD" /D "NOT_RD" /D "INC_DONGLE_DLL" /FR /Yu"stdafx.h" /FD /GZ /c
# ADD BASE RSC /l 0x3009 /d "_DEBUG" /d "_AFXDLL"
# ADD RSC /l 0x3009 /d "_DEBUG" /d "_AFXDLL"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /debug /machine:I386 /pdbtype:sept /FORCE:MULTIPLE
# SUBTRACT BASE LINK32 /pdb:none
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /debug /machine:I386 /pdbtype:sept /FORCE:MULTIPLE
# SUBTRACT LINK32 /pdb:none

!ELSEIF  "$(CFG)" == "Demo_PAPI - Win32 Release_5_5"

# PROP BASE Use_MFC 2
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Demo_PAPI___Win32_Release_5_5"
# PROP BASE Intermediate_Dir "Demo_PAPI___Win32_Release_5_5"
# PROP BASE Ignore_Export_Lib 0
# PROP BASE Target_Dir ""
# PROP Use_MFC 2
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release_5_5"
# PROP Intermediate_Dir "Release_5_5"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /Zp1 /MD /W3 /GX /O2 /I "../../../libs/GPersn/src" /I "../../../include" /I "../../../include/msvc32" /D "NDEBUG" /D "MAKE_HDD" /D "WIN32" /D "_CONSOLE" /D "_MBCS" /D "_AFXDLL" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR /Yu"stdafx.h" /FD /c
# ADD CPP /nologo /Zp1 /MD /W3 /GX /ZI /Od /I "../../../libs/GPersn/src" /I "../../../include" /I "../../../include/msvc32" /D "NDEBUG" /D "MAKE_HDD" /D "WIN32" /D "_CONSOLE" /D "_MBCS" /D "_AFXDLL" /D "INC_DONGLE_DLL" /D "MULTI_INDEX_STREAM_FILE" /D "PL_REPLCTR_FUNC" /FR /Yu"stdafx.h" /FD /c
# ADD BASE RSC /l 0x3009 /d "NDEBUG" /d "_AFXDLL"
# ADD RSC /l 0x3009 /d "NDEBUG" /d "_AFXDLL"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /machine:I386
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /debug /machine:I386

!ELSEIF  "$(CFG)" == "Demo_PAPI - Win32 Release_5_5_SO"

# PROP BASE Use_MFC 2
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Demo_PAPI___Win32_Release_5_5_SO"
# PROP BASE Intermediate_Dir "Demo_PAPI___Win32_Release_5_5_SO"
# PROP BASE Ignore_Export_Lib 0
# PROP BASE Target_Dir ""
# PROP Use_MFC 2
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release_5_5_SO"
# PROP Intermediate_Dir "Release_5_5_SO"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /Zp1 /MD /W3 /GX /Zi /Od /I "../../../libs/GPersn/src" /I "../../../include" /I "../../../include/msvc32" /D "NDEBUG" /D "MAKE_HDD" /D "WIN32" /D "_CONSOLE" /D "_MBCS" /D "_AFXDLL" /D "INC_DONGLE_DLL" /D "MULTI_INDEX_STREAM_FILE" /D "PL_REPLCTR_FUNC" /D "NOT_RD" /FR /Yu"stdafx.h" /FD /c
# ADD CPP /nologo /Zp1 /MD /W3 /GX /Zi /Od /I "../../../libs/GPersn/src" /I "../../../include" /I "../../../include/msvc32" /D "NDEBUG" /D "MAKE_HDD" /D "WIN32" /D "_CONSOLE" /D "_MBCS" /D "_AFXDLL" /D "INC_DONGLE_DLL" /D "MULTI_INDEX_STREAM_FILE" /D "NOT_RD" /FR /Yu"stdafx.h" /FD /c
# ADD BASE RSC /l 0x3009 /d "NDEBUG" /d "_AFXDLL"
# ADD RSC /l 0x3009 /d "NDEBUG" /d "_AFXDLL"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /debug /machine:I386
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /debug /machine:I386

!ELSEIF  "$(CFG)" == "Demo_PAPI - Win32 Release_5_4"

# PROP BASE Use_MFC 2
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Demo_PAPI___Win32_Release_5_4"
# PROP BASE Intermediate_Dir "Demo_PAPI___Win32_Release_5_4"
# PROP BASE Ignore_Export_Lib 0
# PROP BASE Target_Dir ""
# PROP Use_MFC 2
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release_5_4"
# PROP Intermediate_Dir "Release_5_4"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /Zp1 /MD /W3 /GX /ZI /Od /I "../../../libs/GPersn/src" /I "../../../include" /I "../../../include/msvc32" /D "NDEBUG" /D "MAKE_HDD" /D "WIN32" /D "_CONSOLE" /D "_MBCS" /D "_AFXDLL" /D "INC_DONGLE_DLL" /D "MULTI_INDEX_STREAM_FILE" /D "NOT_RD" /FR /Yu"stdafx.h" /FD /c
# ADD CPP /nologo /Zp1 /MD /W3 /GX /ZI /Od /I "../../../libs/GPersn/src" /I "../../../include" /I "../../../include/msvc32" /D "NDEBUG" /D "MAKE_HDD" /D "WIN32" /D "_CONSOLE" /D "_MBCS" /D "_AFXDLL" /D "INC_DONGLE_DLL" /D "NOT_RD" /D "PL_REPLCTR_FUNC" /FR /Yu"stdafx.h" /FD /c
# ADD BASE RSC /l 0x3009 /d "NDEBUG" /d "_AFXDLL"
# ADD RSC /l 0x3009 /d "NDEBUG" /d "_AFXDLL"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /debug /machine:I386
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /debug /machine:I386

!ENDIF 

# Begin Target

# Name "Demo_PAPI - Win32 Release"
# Name "Demo_PAPI - Win32 Debug"
# Name "Demo_PAPI - Win32 Debug_5_3"
# Name "Demo_PAPI - Win32 Release_5_5"
# Name "Demo_PAPI - Win32 Release_5_5_SO"
# Name "Demo_PAPI - Win32 Release_5_4"
# Begin Group "Source Files"

# PROP Default_Filter "cpp;c;cxx;rc;def;r;odl;idl;hpj;bat"
# Begin Source File

SOURCE=.\Demo_PAPI.cpp
# End Source File
# Begin Source File

SOURCE=.\Demo_PAPI.rc
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\pl_crypt.c

!IF  "$(CFG)" == "Demo_PAPI - Win32 Release"

!ELSEIF  "$(CFG)" == "Demo_PAPI - Win32 Debug"

!ELSEIF  "$(CFG)" == "Demo_PAPI - Win32 Debug_5_3"

!ELSEIF  "$(CFG)" == "Demo_PAPI - Win32 Release_5_5"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Demo_PAPI - Win32 Release_5_5_SO"

!ELSEIF  "$(CFG)" == "Demo_PAPI - Win32 Release_5_4"

# SUBTRACT CPP /YX /Yc /Yu

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\StdAfx.cpp
# ADD CPP /Yc"stdafx.h"
# End Source File
# End Group
# Begin Group "Header Files"

# PROP Default_Filter "h;hpp;hxx;hm;inl"
# Begin Source File

SOURCE=.\Demo_PAPI.h
# End Source File
# Begin Source File

SOURCE=.\Resource.h
# End Source File
# Begin Source File

SOURCE=.\StdAfx.h
# End Source File
# End Group
# Begin Group "Resource Files"

# PROP Default_Filter "ico;cur;bmp;dlg;rc2;rct;bin;rgs;gif;jpg;jpeg;jpe"
# Begin Source File

SOURCE=.\res\TestBreeder32.ico
# End Source File
# End Group
# Begin Source File

SOURCE=.\ReadMe.txt
# End Source File
# End Target
# End Project
