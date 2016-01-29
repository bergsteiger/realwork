# Microsoft Developer Studio Project File - Name="Update" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Application" 0x0101

CFG=Update - Win32 Debug56x
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "Update.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "Update.mak" CFG="Update - Win32 Debug56x"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "Update - Win32 Release" (based on "Win32 (x86) Application")
!MESSAGE "Update - Win32 Debug" (based on "Win32 (x86) Application")
!MESSAGE "Update - Win32 Pilot Debug" (based on "Win32 (x86) Application")
!MESSAGE "Update - Win32 Pilot Release" (based on "Win32 (x86) Application")
!MESSAGE "Update - Win32 Release56x" (based on "Win32 (x86) Application")
!MESSAGE "Update - Win32 Debug56x" (based on "Win32 (x86) Application")
!MESSAGE "Update - Win32 Client_Debug" (based on "Win32 (x86) Application")
!MESSAGE "Update - Win32 Client_Purify" (based on "Win32 (x86) Application")
!MESSAGE "Update - Win32 Client_Release" (based on "Win32 (x86) Application")
!MESSAGE "Update - Win32 Client_Final" (based on "Win32 (x86) Application")
!MESSAGE "Update - Win32 Client_Debug_Static" (based on "Win32 (x86) Application")
!MESSAGE "Update - Win32 Client_Purify_Static" (based on "Win32 (x86) Application")
!MESSAGE "Update - Win32 Client_Release_Static" (based on "Win32 (x86) Application")
!MESSAGE "Update - Win32 Client_Final_Static" (based on "Win32 (x86) Application")
!MESSAGE "Update - Win32 Release61" (based on "Win32 (x86) Application")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
MTL=midl.exe
RSC=rc.exe

!IF  "$(CFG)" == "Update - Win32 Release"

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
# ADD CPP /nologo /Zp1 /MD /W3 /GX /O2 /I "." /I "..\..\libs\cchlp\src" /I "..\..\libs\gc\src" /I "..\..\tools\gctools\src" /I "..\..\libs\gkdb\src" /I "..\..\include" /I "..\..\tools\delta\src" /I "..\..\include\win32" /I "..\..\libs\delta\src" /I "..\..\libs\gsscreen\src" /I "..\..\libs\gctx\src" /I "..\..\libs\inifile\src" /I "W:\common\components\corba" /I "W:\common\components\corba\GCD\cpp" /D "NDEBUG" /D "UPDATE_FACE" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "_EXTERN_MAIN" /D "RUNGLDLL" /D "_AFXDLL" /FR /FD /c
# SUBTRACT CPP /YX /Yc /Yu
# ADD BASE MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x419 /d "NDEBUG" /d "_AFXDLL"
# ADD RSC /l 0x419 /d "NDEBUG" /d "_AFXDLL"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 /nologo /subsystem:windows /machine:I386
# ADD LINK32 /nologo /stack:0xa00000,0x100000 /subsystem:windows /machine:I386
# Begin Special Build Tool
SOURCE="$(InputPath)"
PostBuild_Cmds=makehelp.bat
# End Special Build Tool

!ELSEIF  "$(CFG)" == "Update - Win32 Debug"

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
# ADD CPP /nologo /Zp1 /MDd /W3 /Gm /GX /ZI /Od /Oy /I "." /I "..\..\libs\cchlp\src" /I "..\..\libs\gc\src" /I "..\..\tools\gctools\src" /I "..\..\libs\gkdb\src" /I "..\..\include" /I "..\..\tools\delta\src" /I "..\..\include\win32" /I "..\..\libs\delta\src" /I "..\..\libs\gsscreen\src" /I "..\..\libs\gctx\src" /I "..\..\libs\inifile\src" /I "W:\common\components\corba" /I "W:\common\components\corba\GCD\cpp" /D "_DEBUG" /D "_AFXDLL" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "_EXTERN_MAIN" /D "GUDLL_EXPORTS" /D "RUNGLDLL" /D "UPDATE_FACE" /FR /FD /GZ /c
# SUBTRACT CPP /YX /Yc /Yu
# ADD BASE MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x419 /d "_DEBUG" /d "_AFXDLL"
# ADD RSC /l 0x419 /d "_DEBUG" /d "_AFXDLL"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 /nologo /subsystem:windows /debug /machine:I386 /pdbtype:sept
# ADD LINK32 /nologo /stack:0xa00000,0xa00000 /subsystem:windows /debug /machine:I386 /nodefaultlib:"msvcrt.lib" /nodefaultlib:"libc" /out:"d:\temp\dict.new\tools\update.exe" /pdbtype:sept
# SUBTRACT LINK32 /pdb:none

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Debug"

# PROP BASE Use_MFC 6
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Update___Win32_Pilot_Debug"
# PROP BASE Intermediate_Dir "Update___Win32_Pilot_Debug"
# PROP BASE Ignore_Export_Lib 0
# PROP BASE Target_Dir ""
# PROP Use_MFC 6
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "Update___Win32_Pilot_Debug"
# PROP Intermediate_Dir "Update___Win32_Pilot_Debug"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MDd /W3 /Gm /GX /ZI /Od /I "." /I "..\..\libs\cchlp\src" /I "..\..\libs\gc\src" /I "..\..\tools\gctools\src" /I "..\..\libs\gkdb\src" /I "..\..\include" /I "..\..\tools\delta\src" /I "..\..\include\win32" /I "..\..\libs\delta\src" /I "..\..\libs\gsscreen\src" /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_MBCS" /D "_AFXDLL" /D "ACE_HAS_MFC" /D "PILOT" /FR /FD /GZ /c
# SUBTRACT BASE CPP /YX /Yc /Yu
# ADD CPP /nologo /MDd /W3 /Gm /GX /ZI /Od /I "." /I "..\..\libs\cchlp\src" /I "..\..\libs\gc\src" /I "..\..\tools\gctools\src" /I "..\..\libs\gkdb\src" /I "..\..\include" /I "..\..\tools\delta\src" /I "..\..\include\win32" /I "..\..\libs\delta\src" /I "..\..\libs\gsscreen\src" /I "..\..\libs\gctx\src" /I "..\..\libs\inifile\src" /I "W:\common\components\corba" /I "W:\common\components\corba\GCD\cpp" /D "_DEBUG" /D "ACE_HAS_MFC" /D "PILOT" /D "_AFXDLL" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "_EXTERN_MAIN" /FR /FD /GZ /c
# SUBTRACT CPP /YX /Yc /Yu
# ADD BASE MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x419 /d "_DEBUG" /d "_AFXDLL"
# ADD RSC /l 0x419 /d "_DEBUG" /d "_AFXDLL"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 acemfcd.lib TAOmfcd.lib TAO_PortableServermfcd.lib TAO_CosNamingmfcd.lib TAO_RTEventmfcd.lib TAO_CosPropertymfcd.lib TAO_DsLogAdminmfcd.lib TAO_Svc_Utilsmfcd.lib TAO_CosTimemfcd.lib /nologo /stack:0xa00000,0x100000 /subsystem:windows /debug /machine:I386 /nodefaultlib:"msvcrt.lib" /nodefaultlib:"libc" /pdbtype:sept
# SUBTRACT BASE LINK32 /pdb:none
# ADD LINK32 acemfcd.lib TAOmfcd.lib TAO_PortableServermfcd.lib TAO_CosNamingmfcd.lib TAO_RTEventmfcd.lib TAO_CosPropertymfcd.lib TAO_DsLogAdminmfcd.lib TAO_Svc_Utilsmfcd.lib TAO_CosTimemfcd.lib TAO_CosNotificationmfcd.lib /nologo /stack:0xa00000,0x100000 /subsystem:windows /debug /machine:I386 /out:"Update___Win32_Pilot_Debug/GblPilotServerUpdate.exe" /pdbtype:sept
# SUBTRACT LINK32 /pdb:none /incremental:no

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Release"

# PROP BASE Use_MFC 5
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Update___Win32_Pilot_Release0"
# PROP BASE Intermediate_Dir "Update___Win32_Pilot_Release0"
# PROP BASE Ignore_Export_Lib 0
# PROP BASE Target_Dir ""
# PROP Use_MFC 6
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Update___Win32_Pilot_Release"
# PROP Intermediate_Dir "Update___Win32_Pilot_Release"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /Zp1 /MT /W3 /GX /O2 /I "." /I "..\..\libs\cchlp\src" /I "..\..\libs\gc\src" /I "..\..\tools\gctools\src" /I "..\..\libs\gkdb\src" /I "..\..\include" /I "..\..\tools\delta\src" /I "..\..\include\win32" /I "..\..\libs\delta\src" /I "..\..\libs\gsscreen\src" /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_MBCS" /D "UPDATE_FACE" /FR /FD /c
# SUBTRACT BASE CPP /YX /Yc /Yu
# ADD CPP /nologo /MD /W3 /GX /O2 /I "." /I "..\..\libs\cchlp\src" /I "..\..\libs\gc\src" /I "..\..\tools\gctools\src" /I "..\..\libs\gkdb\src" /I "..\..\include" /I "..\..\tools\delta\src" /I "..\..\include\win32" /I "..\..\libs\delta\src" /I "..\..\libs\gsscreen\src" /I "..\..\libs\gctx\src" /I "..\..\libs\inifile\src" /I "W:\common\components\corba" /I "W:\common\components\corba\GCD\cpp" /D "NDEBUG" /D "UPDATE_FACE" /D "ACE_HAS_MFC" /D "PILOT" /D "_AFXDLL" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "_EXTERN_MAIN" /FR /FD /c
# SUBTRACT CPP /YX /Yc /Yu
# ADD BASE MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x419 /d "NDEBUG"
# ADD RSC /l 0x419 /d "NDEBUG" /d "_AFXDLL"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 /nologo /stack:0xa00000,0x100000 /subsystem:windows /machine:I386
# ADD LINK32 acemfc.lib TAOmfc.lib TAO_PortableServermfc.lib TAO_CosNamingmfc.lib TAO_RTEventmfc.lib TAO_CosPropertymfc.lib TAO_DsLogAdminmfc.lib TAO_Svc_Utilsmfc.lib TAO_CosTimemfc.lib TAO_CosNotificationmfc.lib /nologo /stack:0xa00000,0x100000 /subsystem:windows /pdb:none /machine:I386 /out:"Update___Win32_Pilot_Release/GblPilotServerUpdate.exe"
# Begin Special Build Tool
SOURCE="$(InputPath)"
PostBuild_Cmds=makehelpb.bat
# End Special Build Tool

!ELSEIF  "$(CFG)" == "Update - Win32 Release56x"

# PROP BASE Use_MFC 5
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Update___Win32_Release56x"
# PROP BASE Intermediate_Dir "Update___Win32_Release56x"
# PROP BASE Ignore_Export_Lib 0
# PROP BASE Target_Dir ""
# PROP Use_MFC 6
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release56x"
# PROP Intermediate_Dir "Release56x"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /Zp1 /MT /W3 /GX /O2 /I "." /I "..\..\libs\cchlp\src" /I "..\..\libs\gc\src" /I "..\..\tools\gctools\src" /I "..\..\libs\gkdb\src" /I "..\..\include" /I "..\..\tools\delta\src" /I "..\..\include\win32" /I "..\..\libs\delta\src" /I "..\..\libs\gsscreen\src" /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_MBCS" /D "UPDATE_FACE" /FR /FD /c
# SUBTRACT BASE CPP /YX /Yc /Yu
# ADD CPP /nologo /Zp1 /MD /W3 /GX /Zi /Od /I "." /I "..\..\libs\cchlp\src" /I "..\..\libs\gc\src" /I "..\..\tools\gctools\src" /I "..\..\libs\gkdb\src" /I "..\..\include" /I "..\..\tools\delta\src" /I "..\..\include\win32" /I "..\..\libs\delta\src" /I "..\..\libs\gsscreen\src" /I "..\..\libs\gctx\src" /I "..\..\libs\inifile\src" /I "W:\common\components\corba" /I "W:\common\components\corba\GCD\cpp" /D "NDEBUG" /D "UPDATE_FACE" /D "MULTI_INDEX_STREAM_FILE" /D "INSTLL_CIB" /D "OPT_PACK" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "_EXTERN_MAIN" /D "_AFXDLL" /D "VERSION56" /FR /FD /c
# SUBTRACT CPP /YX /Yc /Yu
# ADD BASE MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x419 /d "NDEBUG"
# ADD RSC /l 0x419 /d "NDEBUG" /d "_AFXDLL"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 /nologo /stack:0xa00000,0x100000 /subsystem:windows /machine:I386
# ADD LINK32 /nologo /stack:0xa00000,0x100000 /subsystem:windows /debug /machine:I386
# Begin Special Build Tool
SOURCE="$(InputPath)"
PostBuild_Cmds=makehelp.bat
# End Special Build Tool

!ELSEIF  "$(CFG)" == "Update - Win32 Debug56x"

# PROP BASE Use_MFC 6
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Update___Win32_Debug56x"
# PROP BASE Intermediate_Dir "Update___Win32_Debug56x"
# PROP BASE Ignore_Export_Lib 0
# PROP BASE Target_Dir ""
# PROP Use_MFC 6
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "Debug56x"
# PROP Intermediate_Dir "Debug56x"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MDd /W3 /Gm /GX /ZI /Od /I "." /I "..\..\libs\cchlp\src" /I "..\..\libs\gc\src" /I "..\..\tools\gctools\src" /I "..\..\libs\gkdb\src" /I "..\..\include" /I "..\..\tools\delta\src" /I "..\..\include\win32" /I "..\..\libs\delta\src" /I "..\..\libs\gsscreen\src" /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_MBCS" /D "_AFXDLL" /FR /FD /GZ /c
# SUBTRACT BASE CPP /YX /Yc /Yu
# ADD CPP /nologo /G4 /Zp1 /MDd /W3 /Gm /GX /ZI /Od /I "." /I "..\..\libs\cchlp\src" /I "..\..\libs\gc\src" /I "..\..\tools\gctools\src" /I "..\..\libs\gkdb\src" /I "..\..\include" /I "..\..\tools\delta\src" /I "..\..\include\win32" /I "..\..\libs\delta\src" /I "..\..\libs\gsscreen\src" /I "..\..\libs\gctx\src" /I "..\..\libs\inifile\src" /I "W:\common\components\corba" /I "W:\common\components\corba\GCD\cpp" /D "_DEBUG" /D "_AFXDLL" /D "MULTI_INDEX_STREAM_FILE" /D "INSTLL_CIB" /D "OPT_PACK" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "_EXTERN_MAIN" /D "GUDLL_EXPORTS" /FR /FD /GZ /c
# SUBTRACT CPP /YX /Yc /Yu
# ADD BASE MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x419 /d "_DEBUG" /d "_AFXDLL"
# ADD RSC /l 0x419 /d "_DEBUG" /d "_AFXDLL"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 /nologo /stack:0xa00000,0x100000 /subsystem:windows /debug /machine:I386 /nodefaultlib:"msvcrt.lib" /nodefaultlib:"libc" /pdbtype:sept
# SUBTRACT BASE LINK32 /pdb:none
# ADD LINK32 /nologo /stack:0xa00000,0x100000 /subsystem:windows /debug /machine:I386 /nodefaultlib:"msvcrt.lib" /nodefaultlib:"libc" /out:"h:\new\tools\Update.exe" /pdbtype:sept
# SUBTRACT LINK32 /pdb:none

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug"

# PROP BASE Use_MFC 6
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "W:\build\bin\Client_Debug"
# PROP BASE Intermediate_Dir "W:\build\temp\Client_Debug\GbaUpdater"
# PROP BASE Ignore_Export_Lib 0
# PROP BASE Target_Dir ""
# PROP Use_MFC 6
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "W:\build\bin\Client_Debug"
# PROP Intermediate_Dir "W:\build\temp\Client_Debug\GbaUpdater"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MDd /W3 /GR /GX /Zi /Od /Oy /I "." /I "..\..\libs\cchlp\src" /I "..\..\libs\gc\src" /I "..\..\tools\gctools\src" /I "..\..\libs\gkdb\src" /I "..\..\include" /I "..\..\tools\delta\src" /I "..\..\include\win32" /I "..\..\libs\delta\src" /I "..\..\libs\gsscreen\src" /I "..\..\libs\gctx\src" /I "..\..\libs\inifile\src" /I "W:\common\components\corba" /I "W:\common\components\corba\GCD\cpp" /D "_DEBUG" /D "_AFXDLL" /D "_MBCS" /D "WIN32" /D "_WINDOWS" /D "_GCD_CLIENT" /D "INSTLL_CIB" /D "MULTI_INDEX_STREAM_FILE" /D "RUNGLDLL" /D "UPDATE_FACE" /D "VERSION56" /D "VERSION61" /D "VERSION62" /D "WINENCODE" /Fr /FD /GZ /c
# ADD CPP /nologo /MDd /W3 /GR /GX /Zi /Od /Oy /I "." /I "..\..\libs\cchlp\src" /I "..\..\libs\gc\src" /I "..\..\tools\gctools\src" /I "..\..\libs\gkdb\src" /I "..\..\include" /I "..\..\tools\delta\src" /I "..\..\include\win32" /I "..\..\libs\delta\src" /I "..\..\libs\gsscreen\src" /I "..\..\libs\gctx\src" /I "..\..\libs\inifile\src" /I "W:\common\components\corba" /I "W:\common\components\corba\GCD\cpp" /D "_DEBUG" /D "_AFXDLL" /D "_MBCS" /D "WIN32" /D "_WINDOWS" /D "_GCD_CLIENT" /D "INSTLL_CIB" /D "MULTI_INDEX_STREAM_FILE" /D "RUNGLDLL" /D "UPDATE_FACE" /D "VERSION56" /D "VERSION61" /D "VERSION62" /D "WINENCODE" /Fr /FD /GZ /c
# ADD BASE MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x419 /fo"W:\build\temp\Client_Debug\GbaUpdater\GbaUpdater.res" /d "_DEBUG" /d "_AFXDLL" /d "_GCD_CLIENT"
# ADD RSC /l 0x419 /fo"W:\build\temp\Client_Debug\GbaUpdater\GbaUpdater.res" /d "_DEBUG" /d "_AFXDLL" /d "_GCD_CLIENT"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo /o"W:\build\bin\Client_Debug\GbaUpdater.bsc"
# ADD BSC32 /nologo /o"W:\build\bin\Client_Debug\GbaUpdater.bsc"
LINK32=link.exe
# ADD BASE LINK32 htmlhelp.lib ACEd.lib TAOd.lib TAO_CosNamingd.lib TAO_Messagingd.lib TAO_PortableServerd.lib TAO_RTEventd.lib TAO_Svc_Utilsd.lib /nologo /version:6.0 /stack:0x1000000,0x100000 /subsystem:windows /debug /machine:I386 /out:"W:\build\bin\Client_Debug\GbaUpdater.exe"
# ADD LINK32 htmlhelp.lib ACEd.lib TAOd.lib TAO_CosNamingd.lib TAO_Messagingd.lib TAO_PortableServerd.lib TAO_RTEventd.lib TAO_Svc_Utilsd.lib /nologo /version:6.0 /stack:0x1000000,0x100000 /subsystem:windows /debug /machine:I386 /out:"W:\build\bin\Client_Debug\GbaUpdater.exe"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify"

# PROP BASE Use_MFC 6
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "W:\build\bin\Client_Purify"
# PROP BASE Intermediate_Dir "W:\build\temp\Client_Purify\GbaUpdater"
# PROP BASE Ignore_Export_Lib 0
# PROP BASE Target_Dir ""
# PROP Use_MFC 6
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "W:\build\bin\Client_Purify"
# PROP Intermediate_Dir "W:\build\temp\Client_Purify\GbaUpdater"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MD /W3 /GR /GX /Zi /Od /Oy /I "." /I "..\..\libs\cchlp\src" /I "..\..\libs\gc\src" /I "..\..\tools\gctools\src" /I "..\..\libs\gkdb\src" /I "..\..\include" /I "..\..\tools\delta\src" /I "..\..\include\win32" /I "..\..\libs\delta\src" /I "..\..\libs\gsscreen\src" /I "..\..\libs\gctx\src" /I "..\..\libs\inifile\src" /I "W:\common\components\corba" /I "W:\common\components\corba\GCD\cpp" /D "NDEBUG" /D "_AFXDLL" /D "_MBCS" /D "WIN32" /D "_WINDOWS" /D "_GCD_CLIENT" /D "INSTLL_CIB" /D "MULTI_INDEX_STREAM_FILE" /D "RUNGLDLL" /D "UPDATE_FACE" /D "VERSION56" /D "VERSION61" /D "VERSION62" /D "WINENCODE" /Fr /FD /GZ /c
# ADD CPP /nologo /MD /W3 /GR /GX /Zi /Od /Oy /I "." /I "..\..\libs\cchlp\src" /I "..\..\libs\gc\src" /I "..\..\tools\gctools\src" /I "..\..\libs\gkdb\src" /I "..\..\include" /I "..\..\tools\delta\src" /I "..\..\include\win32" /I "..\..\libs\delta\src" /I "..\..\libs\gsscreen\src" /I "..\..\libs\gctx\src" /I "..\..\libs\inifile\src" /I "W:\common\components\corba" /I "W:\common\components\corba\GCD\cpp" /D "NDEBUG" /D "_AFXDLL" /D "_MBCS" /D "WIN32" /D "_WINDOWS" /D "_GCD_CLIENT" /D "INSTLL_CIB" /D "MULTI_INDEX_STREAM_FILE" /D "RUNGLDLL" /D "UPDATE_FACE" /D "VERSION56" /D "VERSION61" /D "VERSION62" /D "WINENCODE" /Fr /FD /GZ /c
# ADD BASE MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x419 /fo"W:\build\temp\Client_Purify\GbaUpdater\GbaUpdater.res" /d "NDEBUG" /d "_AFXDLL" /d "_GCD_CLIENT"
# ADD RSC /l 0x419 /fo"W:\build\temp\Client_Purify\GbaUpdater\GbaUpdater.res" /d "NDEBUG" /d "_AFXDLL" /d "_GCD_CLIENT"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo /o"W:\build\bin\Client_Purify\GbaUpdater.bsc"
# ADD BSC32 /nologo /o"W:\build\bin\Client_Purify\GbaUpdater.bsc"
LINK32=link.exe
# ADD BASE LINK32 htmlhelp.lib ACE.lib TAO.lib TAO_CosNaming.lib TAO_Messaging.lib TAO_PortableServer.lib TAO_RTEvent.lib TAO_Svc_Utils.lib /nologo /version:6.0 /stack:0x1000000,0x100000 /subsystem:windows /debug /machine:I386 /out:"W:\build\bin\Client_Purify\GbaUpdater.exe"
# ADD LINK32 htmlhelp.lib ACE.lib TAO.lib TAO_CosNaming.lib TAO_Messaging.lib TAO_PortableServer.lib TAO_RTEvent.lib TAO_Svc_Utils.lib /nologo /version:6.0 /stack:0x1000000,0x100000 /subsystem:windows /debug /machine:I386 /out:"W:\build\bin\Client_Purify\GbaUpdater.exe"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release"

# PROP BASE Use_MFC 6
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "W:\build\bin\Client_Release"
# PROP BASE Intermediate_Dir "W:\build\temp\Client_Release\GbaUpdater"
# PROP BASE Ignore_Export_Lib 0
# PROP BASE Target_Dir ""
# PROP Use_MFC 6
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "W:\build\bin\Client_Release"
# PROP Intermediate_Dir "W:\build\temp\Client_Release\GbaUpdater"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MD /W3 /GR /GX /O2 /I "." /I "..\..\libs\cchlp\src" /I "..\..\libs\gc\src" /I "..\..\tools\gctools\src" /I "..\..\libs\gkdb\src" /I "..\..\include" /I "..\..\tools\delta\src" /I "..\..\include\win32" /I "..\..\libs\delta\src" /I "..\..\libs\gsscreen\src" /I "..\..\libs\gctx\src" /I "..\..\libs\inifile\src" /I "W:\common\components\corba" /I "W:\common\components\corba\GCD\cpp" /D "NDEBUG" /D "_AFXDLL" /D "_MBCS" /D "WIN32" /D "_WINDOWS" /D "_GCD_CLIENT" /D "INSTLL_CIB" /D "MULTI_INDEX_STREAM_FILE" /D "RUNGLDLL" /D "UPDATE_FACE" /D "VERSION56" /D "VERSION61" /D "VERSION62" /D "WINENCODE" /Fr /FD /GZ /c
# ADD CPP /nologo /MD /W3 /GR /GX /O2 /I "." /I "..\..\libs\cchlp\src" /I "..\..\libs\gc\src" /I "..\..\tools\gctools\src" /I "..\..\libs\gkdb\src" /I "..\..\include" /I "..\..\tools\delta\src" /I "..\..\include\win32" /I "..\..\libs\delta\src" /I "..\..\libs\gsscreen\src" /I "..\..\libs\gctx\src" /I "..\..\libs\inifile\src" /I "W:\common\components\corba" /I "W:\common\components\corba\GCD\cpp" /D "NDEBUG" /D "_AFXDLL" /D "_MBCS" /D "WIN32" /D "_WINDOWS" /D "_GCD_CLIENT" /D "INSTLL_CIB" /D "MULTI_INDEX_STREAM_FILE" /D "RUNGLDLL" /D "UPDATE_FACE" /D "VERSION56" /D "VERSION61" /D "VERSION62" /D "WINENCODE" /Fr /FD /GZ /c
# ADD BASE MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x419 /fo"W:\build\temp\Client_Release\GbaUpdater\GbaUpdater.res" /d "NDEBUG" /d "_AFXDLL" /d "_GCD_CLIENT"
# ADD RSC /l 0x419 /fo"W:\build\temp\Client_Release\GbaUpdater\GbaUpdater.res" /d "NDEBUG" /d "_AFXDLL" /d "_GCD_CLIENT"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo /o"W:\build\bin\Client_Release\GbaUpdater.bsc"
# ADD BSC32 /nologo /o"W:\build\bin\Client_Release\GbaUpdater.bsc"
LINK32=link.exe
# ADD BASE LINK32 htmlhelp.lib ACE.lib TAO.lib TAO_CosNaming.lib TAO_Messaging.lib TAO_PortableServer.lib TAO_RTEvent.lib TAO_Svc_Utils.lib /nologo /version:6.0 /stack:0x1000000,0x100000 /subsystem:windows /pdb:none /machine:I386 /out:"W:\build\bin\Client_Release\GbaUpdater.exe"
# ADD LINK32 htmlhelp.lib ACE.lib TAO.lib TAO_CosNaming.lib TAO_Messaging.lib TAO_PortableServer.lib TAO_RTEvent.lib TAO_Svc_Utils.lib /nologo /version:6.0 /stack:0x1000000,0x100000 /subsystem:windows /pdb:none /machine:I386 /out:"W:\build\bin\Client_Release\GbaUpdater.exe"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final"

# PROP BASE Use_MFC 6
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "W:\build\bin\Client_Final"
# PROP BASE Intermediate_Dir "W:\build\temp\Client_Final\GbaUpdater"
# PROP BASE Ignore_Export_Lib 0
# PROP BASE Target_Dir ""
# PROP Use_MFC 6
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "W:\build\bin\Client_Final"
# PROP Intermediate_Dir "W:\build\temp\Client_Final\GbaUpdater"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MD /W3 /GR /GX /O2 /I "." /I "..\..\libs\cchlp\src" /I "..\..\libs\gc\src" /I "..\..\tools\gctools\src" /I "..\..\libs\gkdb\src" /I "..\..\include" /I "..\..\tools\delta\src" /I "..\..\include\win32" /I "..\..\libs\delta\src" /I "..\..\libs\gsscreen\src" /I "..\..\libs\gctx\src" /I "..\..\libs\inifile\src" /I "W:\common\components\corba" /I "W:\common\components\corba\GCD\cpp" /D "NDEBUG" /D "_AFXDLL" /D "_MBCS" /D "WIN32" /D "_WINDOWS" /D "_GCD_CLIENT" /D "GCL_NLOG_DEBUG" /D "INSTLL_CIB" /D "MULTI_INDEX_STREAM_FILE" /D "RUNGLDLL" /D "UPDATE_FACE" /D "VERSION56" /D "VERSION61" /D "VERSION62" /D "WINENCODE" /Fr /FD /GZ /c
# ADD CPP /nologo /MD /W3 /GR /GX /O2 /I "." /I "..\..\libs\cchlp\src" /I "..\..\libs\gc\src" /I "..\..\tools\gctools\src" /I "..\..\libs\gkdb\src" /I "..\..\include" /I "..\..\tools\delta\src" /I "..\..\include\win32" /I "..\..\libs\delta\src" /I "..\..\libs\gsscreen\src" /I "..\..\libs\gctx\src" /I "..\..\libs\inifile\src" /I "W:\common\components\corba" /I "W:\common\components\corba\GCD\cpp" /D "NDEBUG" /D "_AFXDLL" /D "_MBCS" /D "WIN32" /D "_WINDOWS" /D "_GCD_CLIENT" /D "GCL_NLOG_DEBUG" /D "INSTLL_CIB" /D "MULTI_INDEX_STREAM_FILE" /D "RUNGLDLL" /D "UPDATE_FACE" /D "VERSION56" /D "VERSION61" /D "VERSION62" /D "WINENCODE" /Fr /FD /GZ /c
# ADD BASE MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x419 /fo"W:\build\temp\Client_Final\GbaUpdater\GbaUpdater.res" /d "NDEBUG" /d "_AFXDLL" /d "_GCD_CLIENT"
# ADD RSC /l 0x419 /fo"W:\build\temp\Client_Final\GbaUpdater\GbaUpdater.res" /d "NDEBUG" /d "_AFXDLL" /d "_GCD_CLIENT"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo /o"W:\build\bin\Client_Final\GbaUpdater.bsc"
# ADD BSC32 /nologo /o"W:\build\bin\Client_Final\GbaUpdater.bsc"
LINK32=link.exe
# ADD BASE LINK32 htmlhelp.lib ACE.lib TAO.lib TAO_CosNaming.lib TAO_Messaging.lib TAO_PortableServer.lib TAO_RTEvent.lib TAO_Svc_Utils.lib /nologo /version:6.0 /stack:0x1000000,0x100000 /subsystem:windows /pdb:none /machine:I386 /out:"W:\build\bin\Client_Final\GbaUpdater.exe"
# ADD LINK32 htmlhelp.lib ACE.lib TAO.lib TAO_CosNaming.lib TAO_Messaging.lib TAO_PortableServer.lib TAO_RTEvent.lib TAO_Svc_Utils.lib /nologo /version:6.0 /stack:0x1000000,0x100000 /subsystem:windows /pdb:none /machine:I386 /out:"W:\build\bin\Client_Final\GbaUpdater.exe"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug_Static"

# PROP BASE Use_MFC 5
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "W:\build\bin\Client_Debug_Static"
# PROP BASE Intermediate_Dir "W:\build\temp\Client_Debug_Static\GbaUpdater"
# PROP BASE Ignore_Export_Lib 0
# PROP BASE Target_Dir ""
# PROP Use_MFC 5
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "W:\build\bin\Client_Debug_Static"
# PROP Intermediate_Dir "W:\build\temp\Client_Debug_Static\GbaUpdater"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MTd /W3 /GR /GX /Zi /Od /Oy /I "." /I "..\..\libs\cchlp\src" /I "..\..\libs\gc\src" /I "..\..\tools\gctools\src" /I "..\..\libs\gkdb\src" /I "..\..\include" /I "..\..\tools\delta\src" /I "..\..\include\win32" /I "..\..\libs\delta\src" /I "..\..\libs\gsscreen\src" /I "..\..\libs\gctx\src" /I "..\..\libs\inifile\src" /I "W:\common\components\corba" /I "W:\common\components\corba\GCD\cpp" /D "_DEBUG" /D "_MBCS" /D "WIN32" /D "_WINDOWS" /D "_GCD_CLIENT" /D "_GCD_STATIC" /D "ACE_AS_STATIC_LIBS" /D "TAO_AS_STATIC_LIBS" /D "INSTLL_CIB" /D "MULTI_INDEX_STREAM_FILE" /D "RUNGLDLL" /D "UPDATE_FACE" /D "VERSION56" /D "VERSION61" /D "VERSION62" /D "WINENCODE" /Fr /FD /GZ /c
# ADD CPP /nologo /MTd /W3 /GR /GX /Zi /Od /Oy /I "." /I "..\..\libs\cchlp\src" /I "..\..\libs\gc\src" /I "..\..\tools\gctools\src" /I "..\..\libs\gkdb\src" /I "..\..\include" /I "..\..\tools\delta\src" /I "..\..\include\win32" /I "..\..\libs\delta\src" /I "..\..\libs\gsscreen\src" /I "..\..\libs\gctx\src" /I "..\..\libs\inifile\src" /I "W:\common\components\corba" /I "W:\common\components\corba\GCD\cpp" /D "_DEBUG" /D "_MBCS" /D "WIN32" /D "_WINDOWS" /D "_GCD_CLIENT" /D "_GCD_STATIC" /D "ACE_AS_STATIC_LIBS" /D "TAO_AS_STATIC_LIBS" /D "INSTLL_CIB" /D "MULTI_INDEX_STREAM_FILE" /D "RUNGLDLL" /D "UPDATE_FACE" /D "VERSION56" /D "VERSION61" /D "VERSION62" /D "WINENCODE" /Fr /FD /GZ /c
# ADD BASE MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x419 /fo"W:\build\temp\Client_Debug_Static\GbaUpdater\GbaUpdater.res" /d "_DEBUG" /d "_GCD_CLIENT" /d "_GCD_STATIC" /d "ACE_AS_STATIC_LIBS" /d "TAO_AS_STATIC_LIBS"
# ADD RSC /l 0x419 /fo"W:\build\temp\Client_Debug_Static\GbaUpdater\GbaUpdater.res" /d "_DEBUG" /d "_GCD_CLIENT" /d "_GCD_STATIC" /d "ACE_AS_STATIC_LIBS" /d "TAO_AS_STATIC_LIBS"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo /o"W:\build\bin\Client_Debug_Static\GbaUpdater.bsc"
# ADD BSC32 /nologo /o"W:\build\bin\Client_Debug_Static\GbaUpdater.bsc"
LINK32=link.exe
# ADD BASE LINK32 nafxcwd.lib libcmtd.lib htmlhelp.lib ACEsd.lib TAOsd.lib TAO_CosNamingsd.lib TAO_Messagingsd.lib TAO_PortableServersd.lib TAO_RTEventsd.lib TAO_Svc_Utilssd.lib /nologo /version:6.0 /stack:0x1000000,0x100000 /subsystem:windows /debug /machine:I386 /nodefaultlib:"nafxcwd.lib libcmtd.lib" /out:"W:\build\bin\Client_Debug_Static\GbaUpdater.exe"
# ADD LINK32 nafxcwd.lib libcmtd.lib htmlhelp.lib ACEsd.lib TAOsd.lib TAO_CosNamingsd.lib TAO_Messagingsd.lib TAO_PortableServersd.lib TAO_RTEventsd.lib TAO_Svc_Utilssd.lib /nologo /version:6.0 /stack:0x1000000,0x100000 /subsystem:windows /debug /machine:I386 /nodefaultlib:"nafxcwd.lib libcmtd.lib" /out:"W:\build\bin\Client_Debug_Static\GbaUpdater.exe"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify_Static"

# PROP BASE Use_MFC 5
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "W:\build\bin\Client_Purify_Static"
# PROP BASE Intermediate_Dir "W:\build\temp\Client_Purify_Static\GbaUpdater"
# PROP BASE Ignore_Export_Lib 0
# PROP BASE Target_Dir ""
# PROP Use_MFC 5
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "W:\build\bin\Client_Purify_Static"
# PROP Intermediate_Dir "W:\build\temp\Client_Purify_Static\GbaUpdater"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MT /W3 /GR /GX /Zi /Od /Oy /I "." /I "..\..\libs\cchlp\src" /I "..\..\libs\gc\src" /I "..\..\tools\gctools\src" /I "..\..\libs\gkdb\src" /I "..\..\include" /I "..\..\tools\delta\src" /I "..\..\include\win32" /I "..\..\libs\delta\src" /I "..\..\libs\gsscreen\src" /I "..\..\libs\gctx\src" /I "..\..\libs\inifile\src" /I "W:\common\components\corba" /I "W:\common\components\corba\GCD\cpp" /D "NDEBUG" /D "_MBCS" /D "WIN32" /D "_WINDOWS" /D "_GCD_CLIENT" /D "_GCD_STATIC" /D "ACE_AS_STATIC_LIBS" /D "TAO_AS_STATIC_LIBS" /D "INSTLL_CIB" /D "MULTI_INDEX_STREAM_FILE" /D "RUNGLDLL" /D "UPDATE_FACE" /D "VERSION56" /D "VERSION61" /D "VERSION62" /D "WINENCODE" /Fr /FD /GZ /c
# ADD CPP /nologo /MT /W3 /GR /GX /Zi /Od /Oy /I "." /I "..\..\libs\cchlp\src" /I "..\..\libs\gc\src" /I "..\..\tools\gctools\src" /I "..\..\libs\gkdb\src" /I "..\..\include" /I "..\..\tools\delta\src" /I "..\..\include\win32" /I "..\..\libs\delta\src" /I "..\..\libs\gsscreen\src" /I "..\..\libs\gctx\src" /I "..\..\libs\inifile\src" /I "W:\common\components\corba" /I "W:\common\components\corba\GCD\cpp" /D "NDEBUG" /D "_MBCS" /D "WIN32" /D "_WINDOWS" /D "_GCD_CLIENT" /D "_GCD_STATIC" /D "ACE_AS_STATIC_LIBS" /D "TAO_AS_STATIC_LIBS" /D "INSTLL_CIB" /D "MULTI_INDEX_STREAM_FILE" /D "RUNGLDLL" /D "UPDATE_FACE" /D "VERSION56" /D "VERSION61" /D "VERSION62" /D "WINENCODE" /Fr /FD /GZ /c
# ADD BASE MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x419 /fo"W:\build\temp\Client_Purify_Static\GbaUpdater\GbaUpdater.res" /d "NDEBUG" /d "_GCD_CLIENT" /d "_GCD_STATIC" /d "ACE_AS_STATIC_LIBS" /d "TAO_AS_STATIC_LIBS"
# ADD RSC /l 0x419 /fo"W:\build\temp\Client_Purify_Static\GbaUpdater\GbaUpdater.res" /d "NDEBUG" /d "_GCD_CLIENT" /d "_GCD_STATIC" /d "ACE_AS_STATIC_LIBS" /d "TAO_AS_STATIC_LIBS"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo /o"W:\build\bin\Client_Purify_Static\GbaUpdater.bsc"
# ADD BSC32 /nologo /o"W:\build\bin\Client_Purify_Static\GbaUpdater.bsc"
LINK32=link.exe
# ADD BASE LINK32 nafxcw.lib libcmt.lib htmlhelp.lib ACEs.lib TAOs.lib TAO_CosNamings.lib TAO_Messagings.lib TAO_PortableServers.lib TAO_RTEvents.lib TAO_Svc_Utilss.lib /nologo /version:6.0 /stack:0x1000000,0x100000 /subsystem:windows /debug /machine:I386 /nodefaultlib:"nafxcw.lib libcmt.lib" /out:"W:\build\bin\Client_Purify_Static\GbaUpdater.exe"
# ADD LINK32 nafxcw.lib libcmt.lib htmlhelp.lib ACEs.lib TAOs.lib TAO_CosNamings.lib TAO_Messagings.lib TAO_PortableServers.lib TAO_RTEvents.lib TAO_Svc_Utilss.lib /nologo /version:6.0 /stack:0x1000000,0x100000 /subsystem:windows /debug /machine:I386 /nodefaultlib:"nafxcw.lib libcmt.lib" /out:"W:\build\bin\Client_Purify_Static\GbaUpdater.exe"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release_Static"

# PROP BASE Use_MFC 5
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "W:\build\bin\Client_Release_Static"
# PROP BASE Intermediate_Dir "W:\build\temp\Client_Release_Static\GbaUpdater"
# PROP BASE Ignore_Export_Lib 0
# PROP BASE Target_Dir ""
# PROP Use_MFC 5
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "W:\build\bin\Client_Release_Static"
# PROP Intermediate_Dir "W:\build\temp\Client_Release_Static\GbaUpdater"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MT /W3 /GR /GX /O2 /I "." /I "..\..\libs\cchlp\src" /I "..\..\libs\gc\src" /I "..\..\tools\gctools\src" /I "..\..\libs\gkdb\src" /I "..\..\include" /I "..\..\tools\delta\src" /I "..\..\include\win32" /I "..\..\libs\delta\src" /I "..\..\libs\gsscreen\src" /I "..\..\libs\gctx\src" /I "..\..\libs\inifile\src" /I "W:\common\components\corba" /I "W:\common\components\corba\GCD\cpp" /D "NDEBUG" /D "_MBCS" /D "WIN32" /D "_WINDOWS" /D "_GCD_CLIENT" /D "_GCD_STATIC" /D "ACE_AS_STATIC_LIBS" /D "TAO_AS_STATIC_LIBS" /D "INSTLL_CIB" /D "MULTI_INDEX_STREAM_FILE" /D "RUNGLDLL" /D "UPDATE_FACE" /D "VERSION56" /D "VERSION61" /D "VERSION62" /D "WINENCODE" /Fr /FD /GZ /c
# ADD CPP /nologo /MT /W3 /GR /GX /O2 /I "." /I "..\..\libs\cchlp\src" /I "..\..\libs\gc\src" /I "..\..\tools\gctools\src" /I "..\..\libs\gkdb\src" /I "..\..\include" /I "..\..\tools\delta\src" /I "..\..\include\win32" /I "..\..\libs\delta\src" /I "..\..\libs\gsscreen\src" /I "..\..\libs\gctx\src" /I "..\..\libs\inifile\src" /I "W:\common\components\corba" /I "W:\common\components\corba\GCD\cpp" /D "NDEBUG" /D "_MBCS" /D "WIN32" /D "_WINDOWS" /D "_GCD_CLIENT" /D "_GCD_STATIC" /D "ACE_AS_STATIC_LIBS" /D "TAO_AS_STATIC_LIBS" /D "INSTLL_CIB" /D "MULTI_INDEX_STREAM_FILE" /D "RUNGLDLL" /D "UPDATE_FACE" /D "VERSION56" /D "VERSION61" /D "VERSION62" /D "WINENCODE" /Fr /FD /GZ /c
# ADD BASE MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x419 /fo"W:\build\temp\Client_Release_Static\GbaUpdater\GbaUpdater.res" /d "NDEBUG" /d "_GCD_CLIENT" /d "_GCD_STATIC" /d "ACE_AS_STATIC_LIBS" /d "TAO_AS_STATIC_LIBS"
# ADD RSC /l 0x419 /fo"W:\build\temp\Client_Release_Static\GbaUpdater\GbaUpdater.res" /d "NDEBUG" /d "_GCD_CLIENT" /d "_GCD_STATIC" /d "ACE_AS_STATIC_LIBS" /d "TAO_AS_STATIC_LIBS"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo /o"W:\build\bin\Client_Release_Static\GbaUpdater.bsc"
# ADD BSC32 /nologo /o"W:\build\bin\Client_Release_Static\GbaUpdater.bsc"
LINK32=link.exe
# ADD BASE LINK32 nafxcw.lib libcmt.lib htmlhelp.lib ACEs.lib TAOs.lib TAO_CosNamings.lib TAO_Messagings.lib TAO_PortableServers.lib TAO_RTEvents.lib TAO_Svc_Utilss.lib /nologo /version:6.0 /stack:0x1000000,0x100000 /subsystem:windows /pdb:none /machine:I386 /nodefaultlib:"nafxcw.lib libcmt.lib" /out:"W:\build\bin\Client_Release_Static\GbaUpdater.exe"
# ADD LINK32 nafxcw.lib libcmt.lib htmlhelp.lib ACEs.lib TAOs.lib TAO_CosNamings.lib TAO_Messagings.lib TAO_PortableServers.lib TAO_RTEvents.lib TAO_Svc_Utilss.lib /nologo /version:6.0 /stack:0x1000000,0x100000 /subsystem:windows /pdb:none /machine:I386 /nodefaultlib:"nafxcw.lib libcmt.lib" /out:"W:\build\bin\Client_Release_Static\GbaUpdater.exe"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final_Static"

# PROP BASE Use_MFC 5
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "W:\build\bin\Client_Final_Static"
# PROP BASE Intermediate_Dir "W:\build\temp\Client_Final_Static\GbaUpdater"
# PROP BASE Ignore_Export_Lib 0
# PROP BASE Target_Dir ""
# PROP Use_MFC 5
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "W:\build\bin\Client_Final_Static"
# PROP Intermediate_Dir "W:\build\temp\Client_Final_Static\GbaUpdater"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MT /W3 /GR /GX /O2 /I "." /I "..\..\libs\cchlp\src" /I "..\..\libs\gc\src" /I "..\..\tools\gctools\src" /I "..\..\libs\gkdb\src" /I "..\..\include" /I "..\..\tools\delta\src" /I "..\..\include\win32" /I "..\..\libs\delta\src" /I "..\..\libs\gsscreen\src" /I "..\..\libs\gctx\src" /I "..\..\libs\inifile\src" /I "W:\common\components\corba" /I "W:\common\components\corba\GCD\cpp" /D "NDEBUG" /D "_MBCS" /D "WIN32" /D "_WINDOWS" /D "_GCD_CLIENT" /D "GCL_NLOG_DEBUG" /D "_GCD_STATIC" /D "ACE_AS_STATIC_LIBS" /D "TAO_AS_STATIC_LIBS" /D "INSTLL_CIB" /D "MULTI_INDEX_STREAM_FILE" /D "RUNGLDLL" /D "UPDATE_FACE" /D "VERSION56" /D "VERSION61" /D "VERSION62" /D "WINENCODE" /Fr /FD /GZ /c
# ADD CPP /nologo /MT /W3 /GR /GX /Zi /Od /I "." /I "..\..\libs\cchlp\src" /I "..\..\libs\gc\src" /I "..\..\tools\gctools\src" /I "..\..\libs\gkdb\src" /I "..\..\include" /I "..\..\tools\delta\src" /I "..\..\include\win32" /I "..\..\libs\delta\src" /I "..\..\libs\gsscreen\src" /I "..\..\libs\gctx\src" /I "..\..\libs\inifile\src" /I "W:\common\components\corba" /I "W:\common\components\corba\GCD\cpp" /D "NDEBUG" /D "_MBCS" /D "WIN32" /D "_WINDOWS" /D "_GCD_CLIENT" /D "GCL_NLOG_DEBUG" /D "_GCD_STATIC" /D "ACE_AS_STATIC_LIBS" /D "TAO_AS_STATIC_LIBS" /D "INSTLL_CIB" /D "MULTI_INDEX_STREAM_FILE" /D "RUNGLDLL" /D "UPDATE_FACE" /D "VERSION56" /D "VERSION61" /D "VERSION62" /D "WINENCODE" /Fr /FD /GZ /c
# ADD BASE MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x419 /fo"W:\build\temp\Client_Final_Static\GbaUpdater\GbaUpdater.res" /d "NDEBUG" /d "_GCD_CLIENT" /d "_GCD_STATIC" /d "ACE_AS_STATIC_LIBS" /d "TAO_AS_STATIC_LIBS"
# ADD RSC /l 0x419 /fo"W:\build\temp\Client_Final_Static\GbaUpdater\GbaUpdater.res" /d "NDEBUG" /d "_GCD_CLIENT" /d "_GCD_STATIC" /d "ACE_AS_STATIC_LIBS" /d "TAO_AS_STATIC_LIBS"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo /o"W:\build\bin\Client_Final_Static\GbaUpdater.bsc"
# ADD BSC32 /nologo /o"W:\build\bin\Client_Final_Static\GbaUpdater.bsc"
LINK32=link.exe
# ADD BASE LINK32 nafxcw.lib libcmt.lib htmlhelp.lib ACEs.lib TAOs.lib TAO_CosNamings.lib TAO_Messagings.lib TAO_PortableServers.lib TAO_RTEvents.lib TAO_Svc_Utilss.lib /nologo /version:6.0 /stack:0x1000000,0x100000 /subsystem:windows /pdb:none /machine:I386 /nodefaultlib:"nafxcw.lib libcmt.lib" /out:"W:\build\bin\Client_Final_Static\GbaUpdater.exe"
# ADD LINK32 nafxcw.lib libcmt.lib htmlhelp.lib ACEs.lib TAOs.lib TAO_CosNamings.lib TAO_Messagings.lib TAO_PortableServers.lib TAO_RTEvents.lib TAO_Svc_Utilss.lib /nologo /version:6.0 /stack:0x1000000,0x100000 /subsystem:windows /pdb:none /debug /machine:I386 /nodefaultlib:"nafxcw.lib libcmt.lib" /out:"W:\build\bin\Client_Final_Static\GbaUpdater.exe"

!ELSEIF  "$(CFG)" == "Update - Win32 Release61"

# PROP BASE Use_MFC 6
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Update___Win32_Release61"
# PROP BASE Intermediate_Dir "Update___Win32_Release61"
# PROP BASE Ignore_Export_Lib 0
# PROP BASE Target_Dir ""
# PROP Use_MFC 6
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release61"
# PROP Intermediate_Dir "Release61"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /Zp1 /MD /W3 /GX /O2 /I "." /I "..\..\libs\cchlp\src" /I "..\..\libs\gc\src" /I "..\..\tools\gctools\src" /I "..\..\libs\gkdb\src" /I "..\..\include" /I "..\..\tools\delta\src" /I "..\..\include\win32" /I "..\..\libs\delta\src" /I "..\..\libs\gsscreen\src" /I "..\..\libs\gctx\src" /I "..\..\libs\inifile\src" /I "W:\common\components\corba" /I "W:\common\components\corba\GCD\cpp" /D "NDEBUG" /D "UPDATE_FACE" /D "MULTI_INDEX_STREAM_FILE" /D "INSTLL_CIB" /D "OPT_PACK" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "_EXTERN_MAIN" /D "_AFXDLL" /D "VERSION56" /FR /FD /c
# SUBTRACT BASE CPP /YX /Yc /Yu
# ADD CPP /nologo /Zp1 /MD /W3 /GX /O2 /I "." /I "..\..\libs\cchlp\src" /I "..\..\libs\gc\src" /I "..\..\tools\gctools\src" /I "..\..\libs\gkdb\src" /I "..\..\include" /I "..\..\tools\delta\src" /I "..\..\include\win32" /I "..\..\libs\delta\src" /I "..\..\libs\gsscreen\src" /I "..\..\libs\gctx\src" /I "..\..\libs\inifile\src" /I "W:\common\components\corba" /I "W:\common\components\corba\GCD\cpp" /D "NDEBUG" /D "UPDATE_FACE" /D "MULTI_INDEX_STREAM_FILE" /D "INSTLL_CIB" /D "OPT_PACK" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "_EXTERN_MAIN" /D "_AFXDLL" /D "VERSION56" /D "NEMESIS" /D "VERSION61" /FD /c
# SUBTRACT CPP /Fr /YX /Yc /Yu
# ADD BASE MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x419 /d "NDEBUG" /d "_AFXDLL"
# ADD RSC /l 0x419 /d "NDEBUG" /d "_AFXDLL"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 /nologo /stack:0xa00000,0x100000 /subsystem:windows /machine:I386
# ADD LINK32 /nologo /stack:0x1000000 /subsystem:windows /machine:I386
# Begin Special Build Tool
SOURCE="$(InputPath)"
PostBuild_Cmds=makehelp.bat
# End Special Build Tool

!ENDIF 

# Begin Target

# Name "Update - Win32 Release"
# Name "Update - Win32 Debug"
# Name "Update - Win32 Pilot Debug"
# Name "Update - Win32 Pilot Release"
# Name "Update - Win32 Release56x"
# Name "Update - Win32 Debug56x"
# Name "Update - Win32 Client_Debug"
# Name "Update - Win32 Client_Purify"
# Name "Update - Win32 Client_Release"
# Name "Update - Win32 Client_Final"
# Name "Update - Win32 Client_Debug_Static"
# Name "Update - Win32 Client_Purify_Static"
# Name "Update - Win32 Client_Release_Static"
# Name "Update - Win32 Client_Final_Static"
# Name "Update - Win32 Release61"
# Begin Group "Source Files"

# PROP Default_Filter "cpp;c;cxx;rc;def;r;odl;idl;hpj;bat"
# Begin Group "GL"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\libs\cchlp\src\advlog.cpp
# End Source File
# Begin Source File

SOURCE=..\..\libs\cchlp\src\clTreeNode.Set.cpp
# End Source File
# Begin Source File

SOURCE=..\..\libs\cchlp\src\clTreeNode.SplaySet.cpp
# End Source File
# Begin Source File

SOURCE=..\..\libs\cchlp\src\errhandler.cpp
# End Source File
# Begin Source File

SOURCE=..\..\libs\cchlp\src\FString.caddr_t.Map.cpp
# End Source File
# Begin Source File

SOURCE=..\..\libs\cchlp\src\FString.caddr_t.SplayMap.cpp
# End Source File
# Begin Source File

SOURCE=..\gctools\src\glproc.cpp
# End Source File
# Begin Source File

SOURCE=..\..\libs\cchlp\src\hidxhlp.cpp
# End Source File
# Begin Source File

SOURCE=..\..\libs\cchlp\src\long.caddr_t.Map.cpp
# End Source File
# Begin Source File

SOURCE=..\..\libs\cchlp\src\long.caddr_t.SplayMap.cpp
# End Source File
# Begin Source File

SOURCE=..\..\libs\cchlp\src\long.long.Map.cpp
# End Source File
# Begin Source File

SOURCE=..\..\libs\cchlp\src\long.long.SplayMap.cpp
# End Source File
# Begin Source File

SOURCE=..\..\libs\cchlp\src\long.Set.cpp
# End Source File
# Begin Source File

SOURCE=..\..\libs\cchlp\src\long.SplaySet.cpp
# End Source File
# Begin Source File

SOURCE=..\..\libs\cchlp\src\u_int32_t.caddr_t.Map.cpp
# End Source File
# Begin Source File

SOURCE=..\..\libs\cchlp\src\u_int32_t.caddr_t.SplayMap.cpp
# End Source File
# Begin Source File

SOURCE=..\..\libs\cchlp\src\u_int32_t.Set.cpp
# End Source File
# Begin Source File

SOURCE=..\..\libs\cchlp\src\u_int32_t.SplaySet.cpp
# End Source File
# Begin Source File

SOURCE=..\..\libs\cchlp\src\u_int64_t.Set.cpp
# End Source File
# Begin Source File

SOURCE=..\..\libs\cchlp\src\u_int64_t.SplaySet.cpp
# End Source File
# End Group
# Begin Source File

SOURCE=.\AnimateDlgIcon.cpp
# End Source File
# Begin Source File

SOURCE=.\BadDeltasDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\CantUpdateDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\Collection.cpp
# End Source File
# Begin Source File

SOURCE=.\CollectParts.cpp
# End Source File
# Begin Source File

SOURCE=.\Confirm.cpp
# End Source File
# Begin Source File

SOURCE=.\CopyFiles.cpp
# End Source File
# Begin Source File

SOURCE=.\FatalError.cpp
# End Source File
# Begin Source File

SOURCE=.\FullUpdate.cpp
# End Source File
# Begin Source File

SOURCE=.\InfoZip\InfoZip.cpp
# End Source File
# Begin Source File

SOURCE=.\LoginDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\PartUpdate.cpp
# End Source File
# Begin Source File

SOURCE=.\Protection.cpp
# End Source File
# Begin Source File

SOURCE=.\RunGUGLProgress.cpp
# End Source File
# Begin Source File

SOURCE=.\SelectBackupFolder.cpp
# End Source File
# Begin Source File

SOURCE=.\SelectBaseFolder.cpp
# End Source File
# Begin Source File

SOURCE=.\SelectBaseFolderEx.cpp
# End Source File
# Begin Source File

SOURCE=.\SelectDeltasFolder.cpp
# End Source File
# Begin Source File

SOURCE=.\SelectMethod.cpp
# End Source File
# Begin Source File

SOURCE=.\SelectRemoteType.cpp
# End Source File
# Begin Source File

SOURCE=.\SelectRemoteUpdateType.cpp
# End Source File
# Begin Source File

SOURCE=.\SelectServerUpdateType.cpp
# End Source File
# Begin Source File

SOURCE=.\StdAfx.cpp

!IF  "$(CFG)" == "Update - Win32 Release"

# ADD CPP /Yc"stdafx.h"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug"

# SUBTRACT CPP /YX /Yc

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Debug"

# SUBTRACT BASE CPP /YX /Yc
# SUBTRACT CPP /YX /Yc

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Release"

# ADD BASE CPP /Yc"stdafx.h"
# ADD CPP /Yc"stdafx.h"

!ELSEIF  "$(CFG)" == "Update - Win32 Release56x"

# ADD BASE CPP /Yc"stdafx.h"
# ADD CPP /Yc"stdafx.h"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug56x"

# SUBTRACT BASE CPP /YX /Yc
# SUBTRACT CPP /YX /Yc

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Release61"

# ADD BASE CPP /Yc"stdafx.h"
# ADD CPP /Yc"stdafx.h"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\TryToOpenBases.cpp
# End Source File
# Begin Source File

SOURCE=.\UnzipDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\Update.cpp
# End Source File
# Begin Source File

SOURCE=.\Update.rc
# End Source File
# Begin Source File

SOURCE=.\UpdateDHReader.cpp
# End Source File
# Begin Source File

SOURCE=.\Utils.cpp
# End Source File
# Begin Source File

SOURCE=.\WaitServer2Dialog.cpp
# End Source File
# Begin Source File

SOURCE=.\WaitServerDialog.cpp
# End Source File
# Begin Source File

SOURCE=.\WelcomeDlg.cpp
# End Source File
# End Group
# Begin Group "Header Files"

# PROP Default_Filter "h;hpp;hxx;hm;inl"
# Begin Source File

SOURCE=.\AnimateDlgIcon.h
# End Source File
# Begin Source File

SOURCE=.\BadDeltasDlg.h
# End Source File
# Begin Source File

SOURCE=.\CantUpdateDlg.h
# End Source File
# Begin Source File

SOURCE=.\Collection.h
# End Source File
# Begin Source File

SOURCE=.\CollectParts.h
# End Source File
# Begin Source File

SOURCE=.\Confirm.h
# End Source File
# Begin Source File

SOURCE=.\CopyFiles.h
# End Source File
# Begin Source File

SOURCE=.\FatalError.h
# End Source File
# Begin Source File

SOURCE=.\FullUpdate.h
# End Source File
# Begin Source File

SOURCE=.\InfoZip\InfoZip.h
# End Source File
# Begin Source File

SOURCE=.\LoginDlg.h
# End Source File
# Begin Source File

SOURCE=.\PartUpdate.h
# End Source File
# Begin Source File

SOURCE=.\Protection.h
# End Source File
# Begin Source File

SOURCE=.\Resource.h
# End Source File
# Begin Source File

SOURCE=.\RunGUGLProgress.h
# End Source File
# Begin Source File

SOURCE=.\SelectBackupFolder.h
# End Source File
# Begin Source File

SOURCE=.\SelectBaseFolder.h
# End Source File
# Begin Source File

SOURCE=.\SelectDeltasFolder.h
# End Source File
# Begin Source File

SOURCE=.\SelectMethod.h
# End Source File
# Begin Source File

SOURCE=.\SelectRemoteUpdateType.h
# End Source File
# Begin Source File

SOURCE=.\StdAfx.h
# End Source File
# Begin Source File

SOURCE=.\TryToOpenBases.h
# End Source File
# Begin Source File

SOURCE=.\UnzipDlg.h
# End Source File
# Begin Source File

SOURCE=.\InfoZip\UnzipDLL.h
# End Source File
# Begin Source File

SOURCE=.\Update.h
# End Source File
# Begin Source File

SOURCE=.\UpdateDHReader.h
# End Source File
# Begin Source File

SOURCE=.\Utils.h
# End Source File
# Begin Source File

SOURCE=.\WaitServerDialog.h
# End Source File
# Begin Source File

SOURCE=.\WelcomeDlg.h
# End Source File
# Begin Source File

SOURCE=.\InfoZip\ZCallBck.h
# End Source File
# Begin Source File

SOURCE=.\InfoZip\ZipDLL.h
# End Source File
# End Group
# Begin Group "Resource Files"

# PROP Default_Filter "ico;cur;bmp;dlg;rc2;rct;bin;rgs;gif;jpg;jpeg;jpe"
# Begin Source File

SOURCE=.\res\2060.bmp
# End Source File
# Begin Source File

SOURCE=.\res\2061.bmp
# End Source File
# Begin Source File

SOURCE=.\res\bitmap1.bmp
# End Source File
# Begin Source File

SOURCE=.\res\e.ico
# End Source File
# Begin Source File

SOURCE=.\res\garant.bmp
# End Source File
# Begin Source File

SOURCE=.\res\ico00001.ico
# End Source File
# Begin Source File

SOURCE=.\res\ico00002.ico
# End Source File
# Begin Source File

SOURCE=.\res\ico00003.ico
# End Source File
# Begin Source File

SOURCE=.\res\icon1.ico
# End Source File
# Begin Source File

SOURCE=.\res\Progress.bmp
# End Source File
# Begin Source File

SOURCE=.\res\Update.ico
# End Source File
# Begin Source File

SOURCE=.\res\Update.rc2
# End Source File
# End Group
# Begin Group "GKDB"

# PROP Default_Filter "c,cpp"
# Begin Source File

SOURCE=..\..\libs\gkdb\src\adler32.c

!IF  "$(CFG)" == "Update - Win32 Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Debug"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Release56x"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug56x"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Release61"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\base.cpp

!IF  "$(CFG)" == "Update - Win32 Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Debug"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Release56x"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug56x"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Release61"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\basemask.cpp

!IF  "$(CFG)" == "Update - Win32 Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Debug"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Release56x"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug56x"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Release61"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\btiter.cpp

!IF  "$(CFG)" == "Update - Win32 Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Debug"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Release56x"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug56x"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Release61"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\btree.cpp

!IF  "$(CFG)" == "Update - Win32 Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Debug"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Release56x"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug56x"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Release61"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\collect.cpp

!IF  "$(CFG)" == "Update - Win32 Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Debug"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Release56x"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug56x"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Release61"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\crc32.c

!IF  "$(CFG)" == "Update - Win32 Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Debug"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Release56x"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug56x"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Release61"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\deflate.c

!IF  "$(CFG)" == "Update - Win32 Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Debug"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Release56x"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug56x"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Release61"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\docblock.cpp
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\doccol.cpp

!IF  "$(CFG)" == "Update - Win32 Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Debug"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Release56x"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug56x"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Release61"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\dociter.cpp

!IF  "$(CFG)" == "Update - Win32 Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Debug"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Release56x"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug56x"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Release61"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\document.cpp

!IF  "$(CFG)" == "Update - Win32 Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Debug"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Release56x"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug56x"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Release61"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\dummies.cpp

!IF  "$(CFG)" == "Update - Win32 Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Debug"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Release56x"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug56x"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Release61"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\fltiter.cpp

!IF  "$(CFG)" == "Update - Win32 Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Debug"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Release56x"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug56x"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Release61"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\garutils.cpp

!IF  "$(CFG)" == "Update - Win32 Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Debug"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Release56x"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug56x"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Release61"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\hindex.cpp

!IF  "$(CFG)" == "Update - Win32 Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Debug"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Release56x"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug56x"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Release61"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\index.cpp

!IF  "$(CFG)" == "Update - Win32 Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Debug"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Release56x"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug56x"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Release61"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\indices.cpp

!IF  "$(CFG)" == "Update - Win32 Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Debug"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Release56x"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug56x"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Release61"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\infblock.c

!IF  "$(CFG)" == "Update - Win32 Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Debug"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Release56x"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug56x"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Release61"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\infcodes.c

!IF  "$(CFG)" == "Update - Win32 Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Debug"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Release56x"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug56x"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Release61"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\inffast.c

!IF  "$(CFG)" == "Update - Win32 Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Debug"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Release56x"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug56x"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Release61"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\inflate.c

!IF  "$(CFG)" == "Update - Win32 Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Debug"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Release56x"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug56x"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Release61"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\inftrees.c

!IF  "$(CFG)" == "Update - Win32 Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Debug"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Release56x"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug56x"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Release61"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\infutil.c

!IF  "$(CFG)" == "Update - Win32 Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Debug"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Release56x"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug56x"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Release61"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\ncpf.cpp

!IF  "$(CFG)" == "Update - Win32 Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Debug"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Release56x"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug56x"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Release61"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\newdoc.cpp

!IF  "$(CFG)" == "Update - Win32 Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Debug"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Release56x"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug56x"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Release61"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\osdummy.c

!IF  "$(CFG)" == "Update - Win32 Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Debug"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Release56x"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug56x"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Release61"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\pack.c

!IF  "$(CFG)" == "Update - Win32 Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Debug"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Release56x"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug56x"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Release61"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\pagefile.cpp

!IF  "$(CFG)" == "Update - Win32 Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Debug"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Release56x"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug56x"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Release61"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\paracol.cpp
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\pl_crypt.c
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\privbase.cpp

!IF  "$(CFG)" == "Update - Win32 Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Debug"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Release56x"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug56x"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Release61"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\refcol.cpp

!IF  "$(CFG)" == "Update - Win32 Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Debug"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Release56x"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug56x"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Release61"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\rev.cpp

!IF  "$(CFG)" == "Update - Win32 Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Debug"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Release56x"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug56x"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Release61"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\stdbase.cpp

!IF  "$(CFG)" == "Update - Win32 Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Debug"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Release56x"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug56x"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Release61"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\store.cpp

!IF  "$(CFG)" == "Update - Win32 Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Debug"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Release56x"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug56x"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Release61"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\streams.cpp

!IF  "$(CFG)" == "Update - Win32 Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Debug"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Release56x"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug56x"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Release61"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\trees.c

!IF  "$(CFG)" == "Update - Win32 Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Debug"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Release56x"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug56x"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Release61"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\unzip.c

!IF  "$(CFG)" == "Update - Win32 Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Debug"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Release56x"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug56x"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Release61"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\zutil.c

!IF  "$(CFG)" == "Update - Win32 Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Debug"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Release56x"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug56x"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Release61"

!ENDIF 

# End Source File
# End Group
# Begin Group "DHReader"

# PROP Default_Filter "c,cpp"
# Begin Source File

SOURCE=..\..\libs\delta\src\dhreader.cpp

!IF  "$(CFG)" == "Update - Win32 Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Debug"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Release56x"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug56x"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Release61"

!ENDIF 

# End Source File
# End Group
# Begin Group "GSScreen"

# PROP Default_Filter "cpp,h"
# Begin Source File

SOURCE=..\..\libs\gsscreen\src\face.c

!IF  "$(CFG)" == "Update - Win32 Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Debug"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Release56x"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug56x"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Release61"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\libs\gsscreen\src\gsscreen.cpp

!IF  "$(CFG)" == "Update - Win32 Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Debug"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Release56x"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug56x"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Release61"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\libs\gsscreen\src\pscreen.cpp

!IF  "$(CFG)" == "Update - Win32 Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Debug"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Release56x"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug56x"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Release61"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\libs\gsscreen\src\pscreen.h
# End Source File
# Begin Source File

SOURCE=..\..\libs\gsscreen\src\screen.c

!IF  "$(CFG)" == "Update - Win32 Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Debug"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Release56x"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug56x"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Release61"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\libs\gsscreen\src\toys.h
# End Source File
# End Group
# Begin Group "Recode"

# PROP Default_Filter "c,cpp,h"
# Begin Source File

SOURCE=..\..\libs\cchlp\src\recode.cpp

!IF  "$(CFG)" == "Update - Win32 Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Debug"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Pilot Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Release56x"

!ELSEIF  "$(CFG)" == "Update - Win32 Debug56x"

# SUBTRACT BASE CPP /YX /Yc /Yu
# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Debug_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Purify_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Release_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Client_Final_Static"

!ELSEIF  "$(CFG)" == "Update - Win32 Release61"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\libs\cchlp\src\recode.h
# End Source File
# End Group
# Begin Group "gctx"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\libs\gctx\src\ctxLongSet.h
# End Source File
# Begin Source File

SOURCE=..\..\libs\gctx\src\ctxwords.cpp
# End Source File
# Begin Source File

SOURCE=..\..\libs\gctx\src\gctx_func.cpp
# End Source File
# Begin Source File

SOURCE=..\..\libs\gctx\src\u_int64_t.CtxLongSet.Map.cpp
# End Source File
# Begin Source File

SOURCE=..\..\libs\gctx\src\u_int64_t.CtxLongSet.SplayMap.cpp
# End Source File
# End Group
# End Target
# End Project
