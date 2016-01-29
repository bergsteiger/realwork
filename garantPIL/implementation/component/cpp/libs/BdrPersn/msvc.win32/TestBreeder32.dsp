# Microsoft Developer Studio Project File - Name="TestBreeder32" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Application" 0x0101

CFG=TestBreeder32 - Win32 Debug_5_5
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "TestBreeder32.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "TestBreeder32.mak" CFG="TestBreeder32 - Win32 Debug_5_5"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "TestBreeder32 - Win32 Release" (based on "Win32 (x86) Application")
!MESSAGE "TestBreeder32 - Win32 Debug" (based on "Win32 (x86) Application")
!MESSAGE "TestBreeder32 - Win32 ReleaseEngl" (based on "Win32 (x86) Application")
!MESSAGE "TestBreeder32 - Win32 Debug_5_4" (based on "Win32 (x86) Application")
!MESSAGE "TestBreeder32 - Win32 Release_5_4" (based on "Win32 (x86) Application")
!MESSAGE "TestBreeder32 - Win32 Pilot Release" (based on "Win32 (x86) Application")
!MESSAGE "TestBreeder32 - Win32 Pilot Debug" (based on "Win32 (x86) Application")
!MESSAGE "TestBreeder32 - Win32 Debug_5_5" (based on "Win32 (x86) Application")
!MESSAGE "TestBreeder32 - Win32 Release_5_5" (based on "Win32 (x86) Application")
!MESSAGE "TestBreeder32 - Win32 Release_5_4_Dbg" (based on "Win32 (x86) Application")
!MESSAGE "TestBreeder32 - Win32 Client_Debug" (based on "Win32 (x86) Application")
!MESSAGE "TestBreeder32 - Win32 Client_Purify" (based on "Win32 (x86) Application")
!MESSAGE "TestBreeder32 - Win32 Client_Release" (based on "Win32 (x86) Application")
!MESSAGE "TestBreeder32 - Win32 Client_Final" (based on "Win32 (x86) Application")
!MESSAGE "TestBreeder32 - Win32 Client_Debug_Static" (based on "Win32 (x86) Application")
!MESSAGE "TestBreeder32 - Win32 Client_Purify_Static" (based on "Win32 (x86) Application")
!MESSAGE "TestBreeder32 - Win32 Client_Release_Static" (based on "Win32 (x86) Application")
!MESSAGE "TestBreeder32 - Win32 Client_Final_Static" (based on "Win32 (x86) Application")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
MTL=midl.exe
RSC=rc.exe

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

# PROP BASE Use_MFC 6
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release"
# PROP BASE Intermediate_Dir "Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 6
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release"
# PROP Intermediate_Dir "Release"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /Yu"stdafx.h" /FD /c
# ADD CPP /nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /D "OPT_PACK" /Yu"stdafx.h" /FD /c
# SUBTRACT CPP /Fr
# ADD BASE MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x3009 /d "NDEBUG" /d "_AFXDLL"
# ADD RSC /l 0x3009 /d "NDEBUG" /d "_AFXDLL" /d "RD_AS_ETALON"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 /nologo /subsystem:windows /machine:I386
# ADD LINK32 winmm.lib /nologo /stack:0xa00000,0xa00000 /subsystem:windows /machine:I386
# SUBTRACT LINK32 /debug

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

# PROP BASE Use_MFC 6
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug"
# PROP BASE Intermediate_Dir "Debug"
# PROP BASE Target_Dir ""
# PROP Use_MFC 6
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "Debug"
# PROP Intermediate_Dir "Debug"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /Yu"stdafx.h" /FD /GZ /c
# ADD CPP /nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /D "OPT_PACK" /FR /Yu"stdafx.h" /FD /GZ /c
# ADD BASE MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x3009 /d "_DEBUG" /d "_AFXDLL"
# ADD RSC /l 0x3009 /d "_DEBUG" /d "_AFXDLL" /d "RD_AS_ETALON"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 /nologo /subsystem:windows /debug /machine:I386 /pdbtype:sept
# ADD LINK32 winmm.lib /nologo /stack:0xa00000,0xa00000 /subsystem:windows /profile /debug /machine:I386

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

# PROP BASE Use_MFC 6
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "TestBreeder32___Win32_ReleaseEngl"
# PROP BASE Intermediate_Dir "TestBreeder32___Win32_ReleaseEngl"
# PROP BASE Ignore_Export_Lib 0
# PROP BASE Target_Dir ""
# PROP Use_MFC 6
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "TestBreeder32Engl"
# PROP Intermediate_Dir "TestBreeder32Engl"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /FR /Yu"stdafx.h" /FD /c
# ADD CPP /nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "ENGLISH_DEF_RC" /D "_AFXDLL" /D "OPT_PACK" /D "MULTI_INDEX_STREAM_FILE" /D "VERSION56" /D "BLOCKSINHERIT" /D "STORE_FORM_N" /D "NEW_AND_OLD_PASSWORD" /FR /FD /c
# SUBTRACT CPP /YX /Yc /Yu
# ADD BASE MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x3009 /d "NDEBUG" /d "_AFXDLL"
# ADD RSC /l 0x3009 /d "NDEBUG" /d "ENGLISH_DEF_RC" /d "_AFXDLL"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 /nologo /stack:0xf00000,0x100000 /subsystem:windows /machine:I386
# ADD LINK32 winmm.lib /nologo /stack:0xf00000,0xf00000 /subsystem:windows /machine:I386

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug_5_4"

# PROP BASE Use_MFC 6
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "TestBreeder32___Win32_Debug_5_4"
# PROP BASE Intermediate_Dir "TestBreeder32___Win32_Debug_5_4"
# PROP BASE Ignore_Export_Lib 0
# PROP BASE Target_Dir ""
# PROP Use_MFC 6
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "Debug_5_4"
# PROP Intermediate_Dir "Debug_5_4"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /D "OPT_PACK" /FR /Yu"stdafx.h" /FD /GZ /c
# ADD CPP /nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "OPT_PACK" /D "NOT_RD" /D "INC_DONGLE_DLL" /FR /Yu"stdafx.h" /FD /GZ /c
# ADD BASE MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x3009 /d "_DEBUG" /d "_AFXDLL"
# ADD RSC /l 0x3009 /fo".\Debug_5_4\TestBreeder32.res" /d "_DEBUG" /d "_AFXDLL"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo /o".\Debug_5_4\TestBreeder32.bsc"
LINK32=link.exe
# ADD BASE LINK32 winmm.lib /nologo /stack:0xa00000,0xa00000 /subsystem:windows /profile /debug /machine:I386
# ADD LINK32 winmm.lib /nologo /stack:0xa00000,0xa00000 /subsystem:windows /profile /debug /machine:I386 /out:".\Debug_5_4\TestBreeder32.exe"

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Release_5_4"

# PROP BASE Use_MFC 6
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "TestBreeder32___Win32_Release_5_4"
# PROP BASE Intermediate_Dir "TestBreeder32___Win32_Release_5_4"
# PROP BASE Ignore_Export_Lib 0
# PROP BASE Target_Dir ""
# PROP Use_MFC 6
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release_5_4"
# PROP Intermediate_Dir "Release_5_4"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /D "OPT_PACK" /Yu"stdafx.h" /FD /c
# SUBTRACT BASE CPP /Fr
# ADD CPP /nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "_AFXDLL" /D "OPT_PACK" /D "NOT_RD" /Fr /Yu"stdafx.h" /FD /c
# ADD BASE MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x3009 /d "NDEBUG" /d "_AFXDLL" /d "RD_AS_ETALON"
# ADD RSC /l 0x3009 /d "NDEBUG" /d "_AFXDLL"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 winmm.lib /nologo /stack:0xa00000,0xa00000 /subsystem:windows /machine:I386
# SUBTRACT BASE LINK32 /debug
# ADD LINK32 winmm.lib /nologo /stack:0xa00000,0xa00000 /subsystem:windows /machine:I386
# SUBTRACT LINK32 /incremental:yes /debug

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Pilot Release"

# PROP BASE Use_MFC 6
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "TestBreeder32___Win32_Pilot_Release"
# PROP BASE Intermediate_Dir "TestBreeder32___Win32_Pilot_Release"
# PROP BASE Ignore_Export_Lib 0
# PROP BASE Target_Dir ""
# PROP Use_MFC 6
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "TestBreeder32___Win32_Pilot_Release"
# PROP Intermediate_Dir "TestBreeder32___Win32_Pilot_Release"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /D "OPT_PACK" /Yu"stdafx.h" /FD /c
# SUBTRACT BASE CPP /Fr
# ADD CPP /nologo /MD /W3 /Gi /GR /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /I "\CVS\GARANTPIL\IMPLEMENTATION\COMPONENT\CPP\GARANT" /I "\CVS\GARANTPIL\IMPLEMENTATION\COMPONENT\CPP" /I "W:\EXTERNAL\ACE_wrappers" /I "W:\EXTERNAL\ACE_wrappers\TAO\ORBSVCS\ORBSVCS" /I "W:\EXTERNAL\ACE_wrappers\TAO\ORBSVCS" /I "W:\EXTERNAL\ACE_wrappers\TAO" /I "W:\EXTERNAL\ACE_wrappers\TAO\TAO" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "_AFXDLL" /D "OPT_PACK" /D "PILOT" /D ACE_HAS_MFC=1 /D "VERSION56" /D "MULTI_INDEX_STREAM_FILE" /D "BLOCKSINHERIT" /D "STORE_FORM_N" /D "NEW_AND_OLD_PASSWORD" /Yu"stdafx.h" /FD /c
# SUBTRACT CPP /Fr
# ADD BASE MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x3009 /d "NDEBUG" /d "_AFXDLL" /d "RD_AS_ETALON"
# ADD RSC /l 0x3009 /d "NDEBUG" /d "_AFXDLL" /d "RD_AS_ETALON"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 winmm.lib /nologo /stack:0xa00000,0xa00000 /subsystem:windows /machine:I386
# SUBTRACT BASE LINK32 /debug
# ADD LINK32 winmm.lib acemfc.lib TAOmfc.lib TAO_PortableServermfc.lib TAO_CosNamingmfc.lib TAO_RTEventmfc.lib TAO_CosPropertymfc.lib TAO_DsLogAdminmfc.lib TAO_Svc_Utilsmfc.lib TAO_CosTimemfc.lib TAO_CosNotificationmfc.lib /nologo /stack:0xa00000,0xa00000 /subsystem:windows /machine:I386 /out:"TestBreeder32___Win32_Pilot_Release/GblPilotServerBreedr.exe" /libpath:"W:\EXTERNAL\ACE_WRAPPERS\ACE" /libpath:"W:\EXTERNAL\ACE_WRAPPERS\TAO\TAO" /libpath:"W:\EXTERNAL\ACE_WRAPPERS\TAO\TAO\PORTABLESERVER" /libpath:"W:\EXTERNAL\ACE_WRAPPERS\TAO\ORBSVCS\ORBSVCS"
# SUBTRACT LINK32 /debug
# Begin Special Build Tool
SOURCE="$(InputPath)"
PostBuild_Cmds=makehelp.bat "GblPilotServerBreedr.hlp" "GblPilotServerBreedr.gid"
# End Special Build Tool

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Pilot Debug"

# PROP BASE Use_MFC 6
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "TestBreeder32___Win32_Pilot_Debug"
# PROP BASE Intermediate_Dir "TestBreeder32___Win32_Pilot_Debug"
# PROP BASE Ignore_Export_Lib 0
# PROP BASE Target_Dir ""
# PROP Use_MFC 6
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "TestBreeder32___Win32_Pilot_Debug"
# PROP Intermediate_Dir "TestBreeder32___Win32_Pilot_Debug"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /D "OPT_PACK" /FR /Yu"stdafx.h" /FD /GZ /c
# ADD CPP /nologo /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /I "\CVS\GARANTPIL\IMPLEMENTATION\COMPONENT\CPP\GARANT" /I "\CVS\GARANTPIL\IMPLEMENTATION\COMPONENT\CPP" /I "W:\EXTERNAL\ACE_wrappers" /I "W:\EXTERNAL\ACE_wrappers\TAO\ORBSVCS\ORBSVCS" /I "W:\EXTERNAL\ACE_wrappers\TAO\ORBSVCS" /I "W:\EXTERNAL\ACE_wrappers\TAO" /I "W:\EXTERNAL\ACE_wrappers\TAO\TAO" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /D "OPT_PACK" /D "ACE_HAS_MFC" /D "PILOT" /FR /Yu"stdafx.h" /FD /GZ /c
# ADD BASE MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x3009 /d "_DEBUG" /d "_AFXDLL" /d "RD_AS_ETALON"
# ADD RSC /l 0x3009 /d "_DEBUG" /d "_AFXDLL" /d "RD_AS_ETALON"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 winmm.lib /nologo /stack:0xa00000,0xa00000 /subsystem:windows /profile /debug /machine:I386
# ADD LINK32 winmm.lib acemfcd.lib TAOmfcd.lib TAO_PortableServermfcd.lib TAO_CosNamingmfcd.lib TAO_RTEventmfcd.lib TAO_CosPropertymfcd.lib TAO_DsLogAdminmfcd.lib TAO_Svc_Utilsmfcd.lib TAO_CosTimemfcd.lib TAO_CosNotificationmfcd.lib /nologo /stack:0xa00000,0xa00000 /subsystem:windows /profile /debug /machine:I386 /out:"TestBreeder32___Win32_Pilot_Debug/GblPilotServerBreedr.exe" /libpath:"W:\EXTERNAL\ACE_WRAPPERS\ACE" /libpath:"W:\EXTERNAL\ACE_WRAPPERS\TAO\TAO" /libpath:"W:\EXTERNAL\ACE_WRAPPERS\TAO\TAO\PORTABLESERVER" /libpath:"W:\EXTERNAL\ACE_WRAPPERS\TAO\ORBSVCS\ORBSVCS"

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug_5_5"

# PROP BASE Use_MFC 6
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "TestBreeder32___Win32_Debug_5_5"
# PROP BASE Intermediate_Dir "TestBreeder32___Win32_Debug_5_5"
# PROP BASE Ignore_Export_Lib 0
# PROP BASE Target_Dir ""
# PROP Use_MFC 6
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "Debug_5_5"
# PROP Intermediate_Dir "Debug_5_5"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "OPT_PACK" /D "NOT_RD" /D "INC_DONGLE_DLL" /FR /Yu"stdafx.h" /FD /GZ /c
# ADD CPP /nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "OPT_PACK" /D "INC_DONGLE_DLL" /D "MULTI_INDEX_STREAM_FILE" /FR /Yu"stdafx.h" /FD /GZ /c
# ADD BASE MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x3009 /d "_DEBUG" /d "_AFXDLL"
# ADD RSC /l 0x3009 /d "_DEBUG" /d "_AFXDLL"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 winmm.lib /nologo /stack:0xa00000,0xa00000 /subsystem:windows /profile /debug /machine:I386
# ADD LINK32 winmm.lib /nologo /stack:0xa00000,0xa00000 /subsystem:windows /profile /debug /machine:I386

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Release_5_5"

# PROP BASE Use_MFC 6
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "TestBreeder32___Win32_Release_5_5"
# PROP BASE Intermediate_Dir "TestBreeder32___Win32_Release_5_5"
# PROP BASE Ignore_Export_Lib 0
# PROP BASE Target_Dir ""
# PROP Use_MFC 6
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release56x"
# PROP Intermediate_Dir "Release56x"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "_AFXDLL" /D "OPT_PACK" /D "NOT_RD" /Fr /Yu"stdafx.h" /FD /c
# ADD CPP /nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "_AFXDLL" /D "OPT_PACK" /D "MULTI_INDEX_STREAM_FILE" /D "VERSION56" /D "BLOCKSINHERIT" /D "STORE_FORM_N" /D "NEW_AND_OLD_PASSWORD" /FD /c
# SUBTRACT CPP /Fr /YX /Yc /Yu
# ADD BASE MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x3009 /d "NDEBUG" /d "_AFXDLL"
# ADD RSC /l 0x3009 /d "NDEBUG" /d "_AFXDLL"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 winmm.lib /nologo /stack:0xa00000,0xa00000 /subsystem:windows /machine:I386
# SUBTRACT BASE LINK32 /incremental:yes /debug
# ADD LINK32 winmm.lib /nologo /stack:0xa00000,0xa00000 /subsystem:windows /machine:I386 /out:"Release56x\breedr32.exe"
# SUBTRACT LINK32 /incremental:yes /debug

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Release_5_4_Dbg"

# PROP BASE Use_MFC 6
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "TestBreeder32___Win32_Release_5_4_Dbg"
# PROP BASE Intermediate_Dir "TestBreeder32___Win32_Release_5_4_Dbg"
# PROP BASE Ignore_Export_Lib 0
# PROP BASE Target_Dir ""
# PROP Use_MFC 6
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release_5_4_Dbg"
# PROP Intermediate_Dir "Release_5_4_Dbg"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "_AFXDLL" /D "OPT_PACK" /D "NOT_RD" /Fr /Yu"stdafx.h" /FD /c
# ADD CPP /nologo /Zp1 /MD /W3 /Gi /GX /Zi /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "_AFXDLL" /D "OPT_PACK" /D "NOT_RD" /Fr /Yu"stdafx.h" /FD /c
# ADD BASE MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x3009 /d "NDEBUG" /d "_AFXDLL"
# ADD RSC /l 0x3009 /d "NDEBUG" /d "_AFXDLL"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 winmm.lib /nologo /stack:0xa00000,0xa00000 /subsystem:windows /machine:I386
# SUBTRACT BASE LINK32 /incremental:yes /debug
# ADD LINK32 winmm.lib /nologo /stack:0xa00000,0xa00000 /subsystem:windows /debug /machine:I386 /out:"x:/gg/tools/TestBreeder32.exe"
# SUBTRACT LINK32 /incremental:yes

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Client_Debug"

# PROP BASE Use_MFC 6
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "W:\build\bin\Client_Debug"
# PROP BASE Intermediate_Dir "W:\build\temp\Client_Debug\GbaBreeder"
# PROP BASE Ignore_Export_Lib 0
# PROP BASE Target_Dir ""
# PROP Use_MFC 6
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "W:\build\bin\Client_Debug"
# PROP Intermediate_Dir "W:\build\temp\Client_Debug\GbaBreeder"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MDd /W3 /GR /GX /Zi /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /I "W:\common\components\corba" /I "W:\common\components\corba\GCD\cpp" /D "_DEBUG" /D "_AFXDLL" /D "_MBCS" /D "WIN32" /D "_WINDOWS" /D "_GCD_CLIENT" /D "BLOCKSINHERIT" /D "BRDR32" /D "INC_DONGLE_DLL" /D "MULTI_INDEX_STREAM_FILE" /D "NEW_AND_OLD_PASSWORD" /D "OPT_PACK" /D "STORE_FORM_N" /D "VERSION56" /D "VERSION61" /D "VERSION62" /D "WINENCODE" /Fr /FD /GZ /c
# ADD CPP /nologo /MDd /W3 /GR /GX /Zi /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /I "W:\common\components\corba" /I "W:\common\components\corba\GCD\cpp" /D "_DEBUG" /D "_AFXDLL" /D "_MBCS" /D "WIN32" /D "_WINDOWS" /D "_GCD_CLIENT" /D "BLOCKSINHERIT" /D "BRDR32" /D "INC_DONGLE_DLL" /D "MULTI_INDEX_STREAM_FILE" /D "NEW_AND_OLD_PASSWORD" /D "OPT_PACK" /D "STORE_FORM_N" /D "VERSION56" /D "VERSION61" /D "VERSION62" /D "WINENCODE" /Fr /FD /GZ /c
# ADD BASE MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x419 /fo"W:\build\temp\Client_Debug\GbaBreeder\GbaBreeder.res" /d "_DEBUG" /d "_AFXDLL" /d "_GCD_CLIENT"
# ADD RSC /l 0x419 /fo"W:\build\temp\Client_Debug\GbaBreeder\GbaBreeder.res" /d "_DEBUG" /d "_AFXDLL" /d "_GCD_CLIENT"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo /o"W:\build\bin\Client_Debug\GbaBreeder.bsc"
# ADD BSC32 /nologo /o"W:\build\bin\Client_Debug\GbaBreeder.bsc"
LINK32=link.exe
# ADD BASE LINK32 htmlhelp.lib ACEd.lib TAOd.lib TAO_CosNamingd.lib TAO_Messagingd.lib TAO_PortableServerd.lib TAO_RTEventd.lib TAO_Svc_Utilsd.lib /nologo /version:6.0 /stack:0x1000000,0x100000 /subsystem:windows /debug /machine:I386 /out:"W:\build\bin\Client_Debug\GbaBreeder.exe"
# ADD LINK32 htmlhelp.lib ACEd.lib TAOd.lib TAO_CosNamingd.lib TAO_Messagingd.lib TAO_PortableServerd.lib TAO_RTEventd.lib TAO_Svc_Utilsd.lib /nologo /version:6.0 /stack:0x1000000,0x100000 /subsystem:windows /debug /machine:I386 /out:"W:\build\bin\Client_Debug\GbaBreeder.exe"

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Client_Purify"

# PROP BASE Use_MFC 6
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "W:\build\bin\Client_Purify"
# PROP BASE Intermediate_Dir "W:\build\temp\Client_Purify\GbaBreeder"
# PROP BASE Ignore_Export_Lib 0
# PROP BASE Target_Dir ""
# PROP Use_MFC 6
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "W:\build\bin\Client_Purify"
# PROP Intermediate_Dir "W:\build\temp\Client_Purify\GbaBreeder"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MD /W3 /GR /GX /Zi /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /I "W:\common\components\corba" /I "W:\common\components\corba\GCD\cpp" /D "NDEBUG" /D "_AFXDLL" /D "_MBCS" /D "WIN32" /D "_WINDOWS" /D "_GCD_CLIENT" /D "BLOCKSINHERIT" /D "BRDR32" /D "INC_DONGLE_DLL" /D "MULTI_INDEX_STREAM_FILE" /D "NEW_AND_OLD_PASSWORD" /D "OPT_PACK" /D "STORE_FORM_N" /D "VERSION56" /D "VERSION61" /D "VERSION62" /D "WINENCODE" /Fr /FD /GZ /c
# ADD CPP /nologo /MD /W3 /GR /GX /Zi /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /I "W:\common\components\corba" /I "W:\common\components\corba\GCD\cpp" /D "NDEBUG" /D "_AFXDLL" /D "_MBCS" /D "WIN32" /D "_WINDOWS" /D "_GCD_CLIENT" /D "BLOCKSINHERIT" /D "BRDR32" /D "INC_DONGLE_DLL" /D "MULTI_INDEX_STREAM_FILE" /D "NEW_AND_OLD_PASSWORD" /D "OPT_PACK" /D "STORE_FORM_N" /D "VERSION56" /D "VERSION61" /D "VERSION62" /D "WINENCODE" /Fr /FD /GZ /c
# ADD BASE MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x419 /fo"W:\build\temp\Client_Purify\GbaBreeder\GbaBreeder.res" /d "NDEBUG" /d "_AFXDLL" /d "_GCD_CLIENT"
# ADD RSC /l 0x419 /fo"W:\build\temp\Client_Purify\GbaBreeder\GbaBreeder.res" /d "NDEBUG" /d "_AFXDLL" /d "_GCD_CLIENT"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo /o"W:\build\bin\Client_Purify\GbaBreeder.bsc"
# ADD BSC32 /nologo /o"W:\build\bin\Client_Purify\GbaBreeder.bsc"
LINK32=link.exe
# ADD BASE LINK32 htmlhelp.lib ACE.lib TAO.lib TAO_CosNaming.lib TAO_Messaging.lib TAO_PortableServer.lib TAO_RTEvent.lib TAO_Svc_Utils.lib /nologo /version:6.0 /stack:0x1000000,0x100000 /subsystem:windows /debug /machine:I386 /out:"W:\build\bin\Client_Purify\GbaBreeder.exe"
# ADD LINK32 htmlhelp.lib ACE.lib TAO.lib TAO_CosNaming.lib TAO_Messaging.lib TAO_PortableServer.lib TAO_RTEvent.lib TAO_Svc_Utils.lib /nologo /version:6.0 /stack:0x1000000,0x100000 /subsystem:windows /debug /machine:I386 /out:"W:\build\bin\Client_Purify\GbaBreeder.exe"

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Client_Release"

# PROP BASE Use_MFC 6
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "W:\build\bin\Client_Release"
# PROP BASE Intermediate_Dir "W:\build\temp\Client_Release\GbaBreeder"
# PROP BASE Ignore_Export_Lib 0
# PROP BASE Target_Dir ""
# PROP Use_MFC 6
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "W:\build\bin\Client_Release"
# PROP Intermediate_Dir "W:\build\temp\Client_Release\GbaBreeder"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MD /W3 /GR /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /I "W:\common\components\corba" /I "W:\common\components\corba\GCD\cpp" /D "NDEBUG" /D "_AFXDLL" /D "_MBCS" /D "WIN32" /D "_WINDOWS" /D "_GCD_CLIENT" /D "BLOCKSINHERIT" /D "BRDR32" /D "INC_DONGLE_DLL" /D "MULTI_INDEX_STREAM_FILE" /D "NEW_AND_OLD_PASSWORD" /D "OPT_PACK" /D "STORE_FORM_N" /D "VERSION56" /D "VERSION61" /D "VERSION62" /D "WINENCODE" /Fr /FD /GZ /c
# ADD CPP /nologo /MD /W3 /GR /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /I "W:\common\components\corba" /I "W:\common\components\corba\GCD\cpp" /D "NDEBUG" /D "_AFXDLL" /D "_MBCS" /D "WIN32" /D "_WINDOWS" /D "_GCD_CLIENT" /D "BLOCKSINHERIT" /D "BRDR32" /D "INC_DONGLE_DLL" /D "MULTI_INDEX_STREAM_FILE" /D "NEW_AND_OLD_PASSWORD" /D "OPT_PACK" /D "STORE_FORM_N" /D "VERSION56" /D "VERSION61" /D "VERSION62" /D "WINENCODE" /Fr /FD /GZ /c
# ADD BASE MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x419 /fo"W:\build\temp\Client_Release\GbaBreeder\GbaBreeder.res" /d "NDEBUG" /d "_AFXDLL" /d "_GCD_CLIENT"
# ADD RSC /l 0x419 /fo"W:\build\temp\Client_Release\GbaBreeder\GbaBreeder.res" /d "NDEBUG" /d "_AFXDLL" /d "_GCD_CLIENT"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo /o"W:\build\bin\Client_Release\GbaBreeder.bsc"
# ADD BSC32 /nologo /o"W:\build\bin\Client_Release\GbaBreeder.bsc"
LINK32=link.exe
# ADD BASE LINK32 htmlhelp.lib ACE.lib TAO.lib TAO_CosNaming.lib TAO_Messaging.lib TAO_PortableServer.lib TAO_RTEvent.lib TAO_Svc_Utils.lib /nologo /version:6.0 /stack:0x1000000,0x100000 /subsystem:windows /pdb:none /machine:I386 /out:"W:\build\bin\Client_Release\GbaBreeder.exe"
# ADD LINK32 htmlhelp.lib ACE.lib TAO.lib TAO_CosNaming.lib TAO_Messaging.lib TAO_PortableServer.lib TAO_RTEvent.lib TAO_Svc_Utils.lib /nologo /version:6.0 /stack:0x1000000,0x100000 /subsystem:windows /pdb:none /machine:I386 /out:"W:\build\bin\Client_Release\GbaBreeder.exe"

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Client_Final"

# PROP BASE Use_MFC 6
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "W:\build\bin\Client_Final"
# PROP BASE Intermediate_Dir "W:\build\temp\Client_Final\GbaBreeder"
# PROP BASE Ignore_Export_Lib 0
# PROP BASE Target_Dir ""
# PROP Use_MFC 6
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "W:\build\bin\Client_Final"
# PROP Intermediate_Dir "W:\build\temp\Client_Final\GbaBreeder"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MD /W3 /GR /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /I "W:\common\components\corba" /I "W:\common\components\corba\GCD\cpp" /D "NDEBUG" /D "_AFXDLL" /D "_MBCS" /D "WIN32" /D "_WINDOWS" /D "_GCD_CLIENT" /D "GCL_NLOG_DEBUG" /D "BLOCKSINHERIT" /D "BRDR32" /D "INC_DONGLE_DLL" /D "MULTI_INDEX_STREAM_FILE" /D "NEW_AND_OLD_PASSWORD" /D "OPT_PACK" /D "STORE_FORM_N" /D "VERSION56" /D "VERSION61" /D "VERSION62" /D "WINENCODE" /Fr /FD /GZ /c
# ADD CPP /nologo /MD /W3 /GR /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /I "W:\common\components\corba" /I "W:\common\components\corba\GCD\cpp" /D "NDEBUG" /D "_AFXDLL" /D "_MBCS" /D "WIN32" /D "_WINDOWS" /D "_GCD_CLIENT" /D "GCL_NLOG_DEBUG" /D "BLOCKSINHERIT" /D "BRDR32" /D "INC_DONGLE_DLL" /D "MULTI_INDEX_STREAM_FILE" /D "NEW_AND_OLD_PASSWORD" /D "OPT_PACK" /D "STORE_FORM_N" /D "VERSION56" /D "VERSION61" /D "VERSION62" /D "WINENCODE" /Fr /FD /GZ /c
# ADD BASE MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x419 /fo"W:\build\temp\Client_Final\GbaBreeder\GbaBreeder.res" /d "NDEBUG" /d "_AFXDLL" /d "_GCD_CLIENT"
# ADD RSC /l 0x419 /fo"W:\build\temp\Client_Final\GbaBreeder\GbaBreeder.res" /d "NDEBUG" /d "_AFXDLL" /d "_GCD_CLIENT"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo /o"W:\build\bin\Client_Final\GbaBreeder.bsc"
# ADD BSC32 /nologo /o"W:\build\bin\Client_Final\GbaBreeder.bsc"
LINK32=link.exe
# ADD BASE LINK32 htmlhelp.lib ACE.lib TAO.lib TAO_CosNaming.lib TAO_Messaging.lib TAO_PortableServer.lib TAO_RTEvent.lib TAO_Svc_Utils.lib /nologo /version:6.0 /stack:0x1000000,0x100000 /subsystem:windows /pdb:none /machine:I386 /out:"W:\build\bin\Client_Final\GbaBreeder.exe"
# ADD LINK32 htmlhelp.lib ACE.lib TAO.lib TAO_CosNaming.lib TAO_Messaging.lib TAO_PortableServer.lib TAO_RTEvent.lib TAO_Svc_Utils.lib /nologo /version:6.0 /stack:0x1000000,0x100000 /subsystem:windows /pdb:none /machine:I386 /out:"W:\build\bin\Client_Final\GbaBreeder.exe"

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Client_Debug_Static"

# PROP BASE Use_MFC 5
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "W:\build\bin\Client_Debug_Static"
# PROP BASE Intermediate_Dir "W:\build\temp\Client_Debug_Static\GbaBreeder"
# PROP BASE Ignore_Export_Lib 0
# PROP BASE Target_Dir ""
# PROP Use_MFC 5
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "W:\build\bin\Client_Debug_Static"
# PROP Intermediate_Dir "W:\build\temp\Client_Debug_Static\GbaBreeder"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MTd /W3 /GR /GX /Zi /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /I "W:\common\components\corba" /I "W:\common\components\corba\GCD\cpp" /D "_DEBUG" /D "_MBCS" /D "WIN32" /D "_WINDOWS" /D "_GCD_CLIENT" /D "_GCD_STATIC" /D "ACE_AS_STATIC_LIBS" /D "TAO_AS_STATIC_LIBS" /D "BLOCKSINHERIT" /D "BRDR32" /D "INC_DONGLE_DLL" /D "MULTI_INDEX_STREAM_FILE" /D "NEW_AND_OLD_PASSWORD" /D "OPT_PACK" /D "STORE_FORM_N" /D "VERSION56" /D "VERSION61" /D "VERSION62" /D "WINENCODE" /Fr /FD /GZ /c
# ADD CPP /nologo /MTd /W3 /GR /GX /Zi /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /I "W:\common\components\corba" /I "W:\common\components\corba\GCD\cpp" /D "_DEBUG" /D "_MBCS" /D "WIN32" /D "_WINDOWS" /D "_GCD_CLIENT" /D "_GCD_STATIC" /D "ACE_AS_STATIC_LIBS" /D "TAO_AS_STATIC_LIBS" /D "BLOCKSINHERIT" /D "BRDR32" /D "INC_DONGLE_DLL" /D "MULTI_INDEX_STREAM_FILE" /D "NEW_AND_OLD_PASSWORD" /D "OPT_PACK" /D "STORE_FORM_N" /D "VERSION56" /D "VERSION61" /D "VERSION62" /D "WINENCODE" /Fr /FD /GZ /c
# ADD BASE MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x419 /fo"W:\build\temp\Client_Debug_Static\GbaBreeder\GbaBreeder.res" /d "_DEBUG" /d "_GCD_CLIENT" /d "_GCD_STATIC" /d "ACE_AS_STATIC_LIBS" /d "TAO_AS_STATIC_LIBS"
# ADD RSC /l 0x419 /fo"W:\build\temp\Client_Debug_Static\GbaBreeder\GbaBreeder.res" /d "_DEBUG" /d "_GCD_CLIENT" /d "_GCD_STATIC" /d "ACE_AS_STATIC_LIBS" /d "TAO_AS_STATIC_LIBS"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo /o"W:\build\bin\Client_Debug_Static\GbaBreeder.bsc"
# ADD BSC32 /nologo /o"W:\build\bin\Client_Debug_Static\GbaBreeder.bsc"
LINK32=link.exe
# ADD BASE LINK32 nafxcwd.lib libcmtd.lib htmlhelp.lib ACEsd.lib TAOsd.lib TAO_CosNamingsd.lib TAO_Messagingsd.lib TAO_PortableServersd.lib TAO_RTEventsd.lib TAO_Svc_Utilssd.lib /nologo /version:6.0 /stack:0x1000000,0x100000 /subsystem:windows /debug /machine:I386 /nodefaultlib:"nafxcwd.lib libcmtd.lib" /out:"W:\build\bin\Client_Debug_Static\GbaBreeder.exe"
# ADD LINK32 nafxcwd.lib libcmtd.lib htmlhelp.lib ACEsd.lib TAOsd.lib TAO_CosNamingsd.lib TAO_Messagingsd.lib TAO_PortableServersd.lib TAO_RTEventsd.lib TAO_Svc_Utilssd.lib /nologo /version:6.0 /stack:0x1000000,0x100000 /subsystem:windows /debug /machine:I386 /nodefaultlib:"nafxcwd.lib libcmtd.lib" /out:"W:\build\bin\Client_Debug_Static\GbaBreeder.exe"

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Client_Purify_Static"

# PROP BASE Use_MFC 5
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "W:\build\bin\Client_Purify_Static"
# PROP BASE Intermediate_Dir "W:\build\temp\Client_Purify_Static\GbaBreeder"
# PROP BASE Ignore_Export_Lib 0
# PROP BASE Target_Dir ""
# PROP Use_MFC 5
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "W:\build\bin\Client_Purify_Static"
# PROP Intermediate_Dir "W:\build\temp\Client_Purify_Static\GbaBreeder"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MT /W3 /GR /GX /Zi /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /I "W:\common\components\corba" /I "W:\common\components\corba\GCD\cpp" /D "NDEBUG" /D "_MBCS" /D "WIN32" /D "_WINDOWS" /D "_GCD_CLIENT" /D "_GCD_STATIC" /D "ACE_AS_STATIC_LIBS" /D "TAO_AS_STATIC_LIBS" /D "BLOCKSINHERIT" /D "BRDR32" /D "INC_DONGLE_DLL" /D "MULTI_INDEX_STREAM_FILE" /D "NEW_AND_OLD_PASSWORD" /D "OPT_PACK" /D "STORE_FORM_N" /D "VERSION56" /D "VERSION61" /D "VERSION62" /D "WINENCODE" /Fr /FD /GZ /c
# ADD CPP /nologo /MT /W3 /GR /GX /Zi /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /I "W:\common\components\corba" /I "W:\common\components\corba\GCD\cpp" /D "NDEBUG" /D "_MBCS" /D "WIN32" /D "_WINDOWS" /D "_GCD_CLIENT" /D "_GCD_STATIC" /D "ACE_AS_STATIC_LIBS" /D "TAO_AS_STATIC_LIBS" /D "BLOCKSINHERIT" /D "BRDR32" /D "INC_DONGLE_DLL" /D "MULTI_INDEX_STREAM_FILE" /D "NEW_AND_OLD_PASSWORD" /D "OPT_PACK" /D "STORE_FORM_N" /D "VERSION56" /D "VERSION61" /D "VERSION62" /D "WINENCODE" /Fr /FD /GZ /c
# ADD BASE MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x419 /fo"W:\build\temp\Client_Purify_Static\GbaBreeder\GbaBreeder.res" /d "NDEBUG" /d "_GCD_CLIENT" /d "_GCD_STATIC" /d "ACE_AS_STATIC_LIBS" /d "TAO_AS_STATIC_LIBS"
# ADD RSC /l 0x419 /fo"W:\build\temp\Client_Purify_Static\GbaBreeder\GbaBreeder.res" /d "NDEBUG" /d "_GCD_CLIENT" /d "_GCD_STATIC" /d "ACE_AS_STATIC_LIBS" /d "TAO_AS_STATIC_LIBS"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo /o"W:\build\bin\Client_Purify_Static\GbaBreeder.bsc"
# ADD BSC32 /nologo /o"W:\build\bin\Client_Purify_Static\GbaBreeder.bsc"
LINK32=link.exe
# ADD BASE LINK32 nafxcw.lib libcmt.lib htmlhelp.lib ACEs.lib TAOs.lib TAO_CosNamings.lib TAO_Messagings.lib TAO_PortableServers.lib TAO_RTEvents.lib TAO_Svc_Utilss.lib /nologo /version:6.0 /stack:0x1000000,0x100000 /subsystem:windows /debug /machine:I386 /nodefaultlib:"nafxcw.lib libcmt.lib" /out:"W:\build\bin\Client_Purify_Static\GbaBreeder.exe"
# ADD LINK32 nafxcw.lib libcmt.lib htmlhelp.lib ACEs.lib TAOs.lib TAO_CosNamings.lib TAO_Messagings.lib TAO_PortableServers.lib TAO_RTEvents.lib TAO_Svc_Utilss.lib /nologo /version:6.0 /stack:0x1000000,0x100000 /subsystem:windows /debug /machine:I386 /nodefaultlib:"nafxcw.lib libcmt.lib" /out:"W:\build\bin\Client_Purify_Static\GbaBreeder.exe"

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Client_Release_Static"

# PROP BASE Use_MFC 5
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "W:\build\bin\Client_Release_Static"
# PROP BASE Intermediate_Dir "W:\build\temp\Client_Release_Static\GbaBreeder"
# PROP BASE Ignore_Export_Lib 0
# PROP BASE Target_Dir ""
# PROP Use_MFC 5
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "W:\build\bin\Client_Release_Static"
# PROP Intermediate_Dir "W:\build\temp\Client_Release_Static\GbaBreeder"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MT /W3 /GR /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /I "W:\common\components\corba" /I "W:\common\components\corba\GCD\cpp" /D "NDEBUG" /D "_MBCS" /D "WIN32" /D "_WINDOWS" /D "_GCD_CLIENT" /D "_GCD_STATIC" /D "ACE_AS_STATIC_LIBS" /D "TAO_AS_STATIC_LIBS" /D "BLOCKSINHERIT" /D "BRDR32" /D "INC_DONGLE_DLL" /D "MULTI_INDEX_STREAM_FILE" /D "NEW_AND_OLD_PASSWORD" /D "OPT_PACK" /D "STORE_FORM_N" /D "VERSION56" /D "VERSION61" /D "VERSION62" /D "WINENCODE" /Fr /FD /GZ /c
# ADD CPP /nologo /MT /W3 /GR /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /I "W:\common\components\corba" /I "W:\common\components\corba\GCD\cpp" /D "NDEBUG" /D "_MBCS" /D "WIN32" /D "_WINDOWS" /D "_GCD_CLIENT" /D "_GCD_STATIC" /D "ACE_AS_STATIC_LIBS" /D "TAO_AS_STATIC_LIBS" /D "BLOCKSINHERIT" /D "BRDR32" /D "INC_DONGLE_DLL" /D "MULTI_INDEX_STREAM_FILE" /D "NEW_AND_OLD_PASSWORD" /D "OPT_PACK" /D "STORE_FORM_N" /D "VERSION56" /D "VERSION61" /D "VERSION62" /D "WINENCODE" /Fr /FD /GZ /c
# ADD BASE MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x419 /fo"W:\build\temp\Client_Release_Static\GbaBreeder\GbaBreeder.res" /d "NDEBUG" /d "_GCD_CLIENT" /d "_GCD_STATIC" /d "ACE_AS_STATIC_LIBS" /d "TAO_AS_STATIC_LIBS"
# ADD RSC /l 0x419 /fo"W:\build\temp\Client_Release_Static\GbaBreeder\GbaBreeder.res" /d "NDEBUG" /d "_GCD_CLIENT" /d "_GCD_STATIC" /d "ACE_AS_STATIC_LIBS" /d "TAO_AS_STATIC_LIBS"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo /o"W:\build\bin\Client_Release_Static\GbaBreeder.bsc"
# ADD BSC32 /nologo /o"W:\build\bin\Client_Release_Static\GbaBreeder.bsc"
LINK32=link.exe
# ADD BASE LINK32 nafxcw.lib libcmt.lib htmlhelp.lib ACEs.lib TAOs.lib TAO_CosNamings.lib TAO_Messagings.lib TAO_PortableServers.lib TAO_RTEvents.lib TAO_Svc_Utilss.lib /nologo /version:6.0 /stack:0x1000000,0x100000 /subsystem:windows /pdb:none /machine:I386 /nodefaultlib:"nafxcw.lib libcmt.lib" /out:"W:\build\bin\Client_Release_Static\GbaBreeder.exe"
# ADD LINK32 nafxcw.lib libcmt.lib htmlhelp.lib ACEs.lib TAOs.lib TAO_CosNamings.lib TAO_Messagings.lib TAO_PortableServers.lib TAO_RTEvents.lib TAO_Svc_Utilss.lib /nologo /version:6.0 /stack:0x1000000,0x100000 /subsystem:windows /pdb:none /machine:I386 /nodefaultlib:"nafxcw.lib libcmt.lib" /out:"W:\build\bin\Client_Release_Static\GbaBreeder.exe"

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Client_Final_Static"

# PROP BASE Use_MFC 5
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "W:\build\bin\Client_Final_Static"
# PROP BASE Intermediate_Dir "W:\build\temp\Client_Final_Static\GbaBreeder"
# PROP BASE Ignore_Export_Lib 0
# PROP BASE Target_Dir ""
# PROP Use_MFC 5
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "W:\build\bin\Client_Final_Static"
# PROP Intermediate_Dir "W:\build\temp\Client_Final_Static\GbaBreeder"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MT /W3 /GR /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /I "W:\common\components\corba" /I "W:\common\components\corba\GCD\cpp" /D "NDEBUG" /D "_MBCS" /D "WIN32" /D "_WINDOWS" /D "_GCD_CLIENT" /D "_GCD_STATIC" /D "GCL_NLOG_DEBUG" /D "ACE_AS_STATIC_LIBS" /D "TAO_AS_STATIC_LIBS" /D "BLOCKSINHERIT" /D "BRDR32" /D "INC_DONGLE_DLL" /D "MULTI_INDEX_STREAM_FILE" /D "NEW_AND_OLD_PASSWORD" /D "OPT_PACK" /D "STORE_FORM_N" /D "VERSION56" /D "VERSION61" /D "VERSION62" /D "WINENCODE" /Fr /FD /GZ /c
# ADD CPP /nologo /MT /W3 /GR /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /I "W:\common\components\corba" /I "W:\common\components\corba\GCD\cpp" /D "NDEBUG" /D "_MBCS" /D "WIN32" /D "_WINDOWS" /D "_GCD_CLIENT" /D "_GCD_STATIC" /D "GCL_NLOG_DEBUG" /D "ACE_AS_STATIC_LIBS" /D "TAO_AS_STATIC_LIBS" /D "BLOCKSINHERIT" /D "BRDR32" /D "INC_DONGLE_DLL" /D "MULTI_INDEX_STREAM_FILE" /D "NEW_AND_OLD_PASSWORD" /D "OPT_PACK" /D "STORE_FORM_N" /D "VERSION56" /D "VERSION61" /D "VERSION62" /D "WINENCODE" /Fr /FD /GZ /c
# ADD BASE MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x419 /fo"W:\build\temp\Client_Final_Static\GbaBreeder\GbaBreeder.res" /d "NDEBUG" /d "_GCD_CLIENT" /d "_GCD_STATIC" /d "ACE_AS_STATIC_LIBS" /d "TAO_AS_STATIC_LIBS"
# ADD RSC /l 0x419 /fo"W:\build\temp\Client_Final_Static\GbaBreeder\GbaBreeder.res" /d "NDEBUG" /d "_GCD_CLIENT" /d "_GCD_STATIC" /d "ACE_AS_STATIC_LIBS" /d "TAO_AS_STATIC_LIBS"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo /o"W:\build\bin\Client_Final_Static\GbaBreeder.bsc"
# ADD BSC32 /nologo /o"W:\build\bin\Client_Final_Static\GbaBreeder.bsc"
LINK32=link.exe
# ADD BASE LINK32 nafxcw.lib libcmt.lib htmlhelp.lib ACEs.lib TAOs.lib TAO_CosNamings.lib TAO_Messagings.lib TAO_PortableServers.lib TAO_RTEvents.lib TAO_Svc_Utilss.lib /nologo /version:6.0 /stack:0x1000000,0x100000 /subsystem:windows /pdb:none /machine:I386 /nodefaultlib:"nafxcw.lib libcmt.lib" /out:"W:\build\bin\Client_Final_Static\GbaBreeder.exe"
# ADD LINK32 nafxcw.lib libcmt.lib htmlhelp.lib ACEs.lib TAOs.lib TAO_CosNamings.lib TAO_Messagings.lib TAO_PortableServers.lib TAO_RTEvents.lib TAO_Svc_Utilss.lib /nologo /version:6.0 /stack:0x1000000,0x100000 /subsystem:windows /pdb:none /machine:I386 /nodefaultlib:"nafxcw.lib libcmt.lib" /out:"W:\build\bin\Client_Final_Static\GbaBreeder.exe"

!ENDIF 

# Begin Target

# Name "TestBreeder32 - Win32 Release"
# Name "TestBreeder32 - Win32 Debug"
# Name "TestBreeder32 - Win32 ReleaseEngl"
# Name "TestBreeder32 - Win32 Debug_5_4"
# Name "TestBreeder32 - Win32 Release_5_4"
# Name "TestBreeder32 - Win32 Pilot Release"
# Name "TestBreeder32 - Win32 Pilot Debug"
# Name "TestBreeder32 - Win32 Debug_5_5"
# Name "TestBreeder32 - Win32 Release_5_5"
# Name "TestBreeder32 - Win32 Release_5_4_Dbg"
# Name "TestBreeder32 - Win32 Client_Debug"
# Name "TestBreeder32 - Win32 Client_Purify"
# Name "TestBreeder32 - Win32 Client_Release"
# Name "TestBreeder32 - Win32 Client_Final"
# Name "TestBreeder32 - Win32 Client_Debug_Static"
# Name "TestBreeder32 - Win32 Client_Purify_Static"
# Name "TestBreeder32 - Win32 Client_Release_Static"
# Name "TestBreeder32 - Win32 Client_Final_Static"
# Begin Group "Source Files"

# PROP Default_Filter "cpp;c;cxx;rc;def;r;odl;idl;hpj;bat"
# Begin Source File

SOURCE=..\..\..\tools\gsplit\src\attr_index.c
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\tools\gsplit\src\aux_index.c
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\tools\gsplit\src\blob_index.c
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\tools\gsplit\src\cmdline.c
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\tools\gsplit\src\cr_index.c
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\tools\gsplit\src\doc_index.c
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\tools\gsplit\src\doclist.c
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\tools\gctools\src\glproc.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\tools\gsplit\src\hc_index.c
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\tools\gsplit\src\hier_index.c
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\tools\gsplit\src\hind_collect.c
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\..\tools\gsplit\src\indhlp.c
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=.\LoginDlg.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\tools\gsplit\src\msg_tbl.c
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=.\NewName.cpp
# End Source File
# Begin Source File

SOURCE=.\OtherEditCtrl.cpp
# End Source File
# Begin Source File

SOURCE=.\PathMsgDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\PilotLoginDlg.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\tools\gsplit\src\ready.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=.\Scrollinfo.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\tools\gsplit\src\segfile.c
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=.\selcttreectrl.cpp
# End Source File
# Begin Source File

SOURCE=.\SelectBaseFolder.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\tools\gsplit\src\split_index.c
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=.\StdAfx.cpp
# ADD CPP /Yc"stdafx.h"
# End Source File
# Begin Source File

SOURCE=..\..\..\tools\gsplit\src\subname.c
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=.\SyncUpdate.cpp
# End Source File
# Begin Source File

SOURCE=.\TestBreeder32.cpp
# End Source File
# Begin Source File

SOURCE=.\TestBreeder32.rc
# End Source File
# Begin Source File

SOURCE=.\TestBreeder32Dlg.cpp
# End Source File
# Begin Source File

SOURCE=.\TrialDlg.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\tools\gsplit\src\usage.c
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=.\WaitServer.cpp
# End Source File
# End Group
# Begin Group "Header Files"

# PROP Default_Filter "h;hpp;hxx;hm;inl"
# Begin Source File

SOURCE=.\LoginDlg.h
# End Source File
# Begin Source File

SOURCE=.\NewName.h
# End Source File
# Begin Source File

SOURCE=.\OtherEditCtrl.h
# End Source File
# Begin Source File

SOURCE=.\PathMsgDlg.h
# End Source File
# Begin Source File

SOURCE=.\PilotLoginDlg.h
# End Source File
# Begin Source File

SOURCE=.\Resource.h
# End Source File
# Begin Source File

SOURCE=.\selcttreectrl.h
# End Source File
# Begin Source File

SOURCE=.\StdAfx.h
# End Source File
# Begin Source File

SOURCE=.\SyncUpdate.h
# End Source File
# Begin Source File

SOURCE=.\TestBreeder32.h
# End Source File
# Begin Source File

SOURCE=.\TestBreeder32Dlg.h
# End Source File
# Begin Source File

SOURCE=.\TrialDlg.h
# End Source File
# End Group
# Begin Group "Resource Files"

# PROP Default_Filter "ico;cur;bmp;dlg;rc2;rct;bin;rgs;gif;jpg;jpeg;jpe"
# Begin Source File

SOURCE=..\..\..\tools\update\res\2060.bmp
# End Source File
# Begin Source File

SOURCE=.\res\cmplct_s.ico
# End Source File
# Begin Source File

SOURCE=.\res\cmplct_u.ico
# End Source File
# Begin Source File

SOURCE=.\res\cursor1.cur
# End Source File
# Begin Source File

SOURCE=..\..\..\tools\update\res\garant.bmp
# End Source File
# Begin Source File

SOURCE=.\res\icons.bmp
# End Source File
# Begin Source File

SOURCE=.\res\Progress.bmp
# End Source File
# Begin Source File

SOURCE=.\res\sgmnt_sl.ico
# End Source File
# Begin Source File

SOURCE=.\res\sgmnt_un.ico
# End Source File
# Begin Source File

SOURCE=.\res\TestBreeder32.ico
# End Source File
# Begin Source File

SOURCE=.\res\TestBreeder32.rc2
# End Source File
# End Group
# Begin Group "GKDB"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\gkdb\src\adler32.c
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\base.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\basemask.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\btiter.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\btree.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\collect.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\crc32.c
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\deflate.c
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\docblock.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\doccol.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\dociter.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\document.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\dummies.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\fltiter.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\garutils.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\hindex.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\index.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\indices.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\infblock.c
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\infcodes.c
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\inffast.c
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\inflate.c
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\inftrees.c
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\infutil.c
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\ncpf.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\newdoc.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\osdummy.c
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\pack.c
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\pagefile.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\paracol.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\pl_crypt.c
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\privbase.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\refcol.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\rev.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\stdbase.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\store.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\streams.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\trees.c
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\unzip.c
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\zutil.c
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# End Group
# Begin Group "MRG_Lib"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\mrglib\src\bfind.c
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\mrglib\src\btree_.c
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\mrglib\src\cmpfunc.c
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\mrglib\src\flog.c
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\mrglib\src\gbase.c
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\mrglib\src\gberr.c
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\mrglib\src\globals.c
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\mrglib\src\index_.c
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\mrglib\src\iter.c
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\mrglib\src\keyfile.c
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\mrglib\src\pgfile.c
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\mrglib\src\profile.c
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\mrglib\src\sets.c
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\mrglib\src\ssets.c
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\mrglib\src\strcache.c
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\mrglib\src\streams_.c
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\mrglib\src\unifname.c
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# End Group
# Begin Group "GSSCREEN_Lib"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\gsscreen\src\face.c
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\gsscreen\src\gsscreen.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\gsscreen\src\pscreen.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\gsscreen\src\screen.c
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# End Group
# Begin Group "VControl"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\VControl\src\vapi.c
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# End Group
# Begin Group "cchlp"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\cchlp\src\advlog.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\cchlp\src\clTreeNode.Set.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\cchlp\src\clTreeNode.SplaySet.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\cchlp\src\errhandler.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\cchlp\src\FString.caddr_t.Map.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\cchlp\src\FString.caddr_t.SplayMap.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\cchlp\src\hidxhlp.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\cchlp\src\long.caddr_t.Map.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\cchlp\src\long.caddr_t.SplayMap.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\cchlp\src\long.long.Map.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\cchlp\src\long.long.SplayMap.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\cchlp\src\long.Set.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\cchlp\src\long.SplaySet.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\cchlp\src\recode.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\cchlp\src\u_int32_t.caddr_t.Map.cpp
# End Source File
# Begin Source File

SOURCE=..\..\cchlp\src\u_int32_t.caddr_t.SplayMap.cpp
# End Source File
# Begin Source File

SOURCE=..\..\cchlp\src\u_int32_t.Set.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\cchlp\src\u_int32_t.SplaySet.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\cchlp\src\u_int64_t.Set.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\cchlp\src\u_int64_t.SplaySet.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# End Group
# Begin Group "gctx"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\gctx\src\ctxwords.cpp

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug_5_4"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Release_5_4"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Pilot Release"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Pilot Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug_5_5"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Release_5_5"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Release_5_4_Dbg"

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Client_Debug"

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Client_Purify"

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Client_Release"

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Client_Final"

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Client_Debug_Static"

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Client_Purify_Static"

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Client_Release_Static"

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Client_Final_Static"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\gctx\src\gctx_func.cpp

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug_5_4"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Release_5_4"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Pilot Release"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Pilot Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug_5_5"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Release_5_5"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Release_5_4_Dbg"

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Client_Debug"

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Client_Purify"

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Client_Release"

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Client_Final"

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Client_Debug_Static"

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Client_Purify_Static"

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Client_Release_Static"

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Client_Final_Static"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\gctx\src\u_int64_t.CtxLongSet.Map.cpp

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug_5_4"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Release_5_4"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Pilot Release"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Pilot Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug_5_5"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Release_5_5"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Release_5_4_Dbg"

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Client_Debug"

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Client_Purify"

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Client_Release"

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Client_Final"

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Client_Debug_Static"

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Client_Purify_Static"

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Client_Release_Static"

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Client_Final_Static"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\gctx\src\u_int64_t.CtxLongSet.SplayMap.cpp

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug_5_4"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Release_5_4"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Pilot Release"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Pilot Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug_5_5"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Release_5_5"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Release_5_4_Dbg"

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Client_Debug"

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Client_Purify"

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Client_Release"

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Client_Final"

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Client_Debug_Static"

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Client_Purify_Static"

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Client_Release_Static"

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Client_Final_Static"

!ENDIF 

# End Source File
# End Group
# End Target
# End Project
