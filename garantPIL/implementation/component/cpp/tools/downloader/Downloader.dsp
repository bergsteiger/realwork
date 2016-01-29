# Microsoft Developer Studio Project File - Name="Downloader" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Application" 0x0101

CFG=Downloader - Win32 Release
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "Downloader.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "Downloader.mak" CFG="Downloader - Win32 Release"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "Downloader - Win32 Release" (based on "Win32 (x86) Application")
!MESSAGE "Downloader - Win32 Debug" (based on "Win32 (x86) Application")
!MESSAGE "Downloader - Win32 Release56x" (based on "Win32 (x86) Application")
!MESSAGE "Downloader - Win32 Pilot Debug" (based on "Win32 (x86) Application")
!MESSAGE "Downloader - Win32 Pilot Release" (based on "Win32 (x86) Application")
!MESSAGE "Downloader - Win32 Client_Debug" (based on "Win32 (x86) Application")
!MESSAGE "Downloader - Win32 Client_Purify" (based on "Win32 (x86) Application")
!MESSAGE "Downloader - Win32 Client_Release" (based on "Win32 (x86) Application")
!MESSAGE "Downloader - Win32 Client_Final" (based on "Win32 (x86) Application")
!MESSAGE "Downloader - Win32 Client_Debug_Static" (based on "Win32 (x86) Application")
!MESSAGE "Downloader - Win32 Client_Purify_Static" (based on "Win32 (x86) Application")
!MESSAGE "Downloader - Win32 Client_Release_Static" (based on "Win32 (x86) Application")
!MESSAGE "Downloader - Win32 Client_Final_Static" (based on "Win32 (x86) Application")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
MTL=midl.exe
RSC=rc.exe

!IF  "$(CFG)" == "Downloader - Win32 Release"

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
# ADD CPP /nologo /MD /W3 /GX /O2 /I "." /I "..\..\libs\cchlp\src" /I "..\..\libs\gc\src" /I "..\..\tools\gctools\src" /I "..\..\libs\gkdb\src" /I "..\..\include" /I "..\..\tools\delta\src" /I "..\..\include\win32" /I "..\..\libs\delta\src" /I "..\..\libs\gsscreen\src" /I "..\..\libs\protect\src" /I "W:\common\components\corba" /I "W:\common\components\corba\GCD\cpp" /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_MBCS" /D "_AFXDLL" /Fr /Yu"stdafx.h" /FD /c
# ADD BASE MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x419 /d "NDEBUG" /d "_AFXDLL"
# ADD RSC /l 0x419 /d "NDEBUG" /d "_AFXDLL"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 /nologo /subsystem:windows /machine:I386
# ADD LINK32 WSOCK32.LIB WININET.LIB /nologo /subsystem:windows /machine:I386 /out:"Release/Download.exe"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Debug"

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
# ADD CPP /nologo /MDd /W3 /Gm /GX /ZI /Od /I "." /I "..\..\libs\cchlp\src" /I "..\..\libs\gc\src" /I "..\..\tools\gctools\src" /I "..\..\libs\gkdb\src" /I "..\..\include" /I "..\..\tools\delta\src" /I "..\..\include\win32" /I "..\..\libs\delta\src" /I "..\..\libs\gsscreen\src" /I "..\..\libs\protect\src" /I "W:\common\components\corba" /I "W:\common\components\corba\GCD\cpp" /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_MBCS" /D "_AFXDLL" /D "VERSION56" /D "MULTI_INDEX_STREAM_FILE" /D "INSTLL_CIB" /FR /FD /GZ /c
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
# ADD LINK32 wininet.lib wsock32.LIB /nologo /subsystem:windows /debug /machine:I386 /out:"c:/garant.srv/tools/Download.exe"
# SUBTRACT LINK32 /profile

!ELSEIF  "$(CFG)" == "Downloader - Win32 Release56x"

# PROP BASE Use_MFC 6
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Downloader___Win32_Release56x"
# PROP BASE Intermediate_Dir "Downloader___Win32_Release56x"
# PROP BASE Ignore_Export_Lib 0
# PROP BASE Target_Dir ""
# PROP Use_MFC 6
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release56x"
# PROP Intermediate_Dir "Release56x"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MD /W3 /GX /O2 /I "." /I "..\..\libs\cchlp\src" /I "..\..\libs\gc\src" /I "..\..\tools\gctools\src" /I "..\..\libs\gkdb\src" /I "..\..\include" /I "..\..\tools\delta\src" /I "..\..\include\win32" /I "..\..\libs\delta\src" /I "..\..\libs\gsscreen\src" /I "..\..\libs\protect\src" /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_MBCS" /D "_AFXDLL" /Fr /Yu"stdafx.h" /FD /c
# ADD CPP /nologo /MD /W3 /GX /O2 /I "." /I "..\..\libs\cchlp\src" /I "..\..\libs\gc\src" /I "..\..\tools\gctools\src" /I "..\..\libs\gkdb\src" /I "..\..\include" /I "..\..\tools\delta\src" /I "..\..\include\win32" /I "..\..\libs\delta\src" /I "..\..\libs\gsscreen\src" /I "..\..\libs\protect\src" /I "W:\common\components\corba" /I "W:\common\components\corba\GCD\cpp" /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_MBCS" /D "_AFXDLL" /D "OPT_PACK" /D "MULTI_INDEX_STREAM_FILE" /D "INSTLL_CIB" /D "VERSION56" /Fr /Yu"stdafx.h" /FD /c
# ADD BASE MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x419 /d "NDEBUG" /d "_AFXDLL"
# ADD RSC /l 0x419 /d "NDEBUG" /d "_AFXDLL"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 WSOCK32.LIB WININET.LIB /nologo /subsystem:windows /machine:I386
# ADD LINK32 WSOCK32.LIB WININET.LIB /nologo /subsystem:windows /machine:I386 /out:"Release56x/Download.exe"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Pilot Debug"

# PROP BASE Use_MFC 6
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Downloader___Win32_Pilot_Debug"
# PROP BASE Intermediate_Dir "Downloader___Win32_Pilot_Debug"
# PROP BASE Ignore_Export_Lib 0
# PROP BASE Target_Dir ""
# PROP Use_MFC 6
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "Downloader___Win32_Pilot_Debug"
# PROP Intermediate_Dir "Downloader___Win32_Pilot_Debug"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MDd /W3 /Gm /GX /ZI /Od /I "." /I "..\..\libs\cchlp\src" /I "..\..\libs\gc\src" /I "..\..\tools\gctools\src" /I "..\..\libs\gkdb\src" /I "..\..\include" /I "..\..\tools\delta\src" /I "..\..\include\win32" /I "..\..\libs\delta\src" /I "..\..\libs\gsscreen\src" /I "..\..\libs\protect\src" /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_MBCS" /D "_AFXDLL" /FR /Yu"stdafx.h" /FD /GZ /c
# ADD CPP /nologo /MDd /W3 /Gm /GX /ZI /Od /I "." /I "..\..\libs\cchlp\src" /I "..\..\libs\gc\src" /I "..\..\tools\gctools\src" /I "..\..\libs\gkdb\src" /I "..\..\include" /I "..\..\tools\delta\src" /I "..\..\include\win32" /I "..\..\libs\delta\src" /I "..\..\libs\gsscreen\src" /I "..\..\libs\protect\src" /I "W:\common\components\corba" /I "W:\common\components\corba\GCD\cpp" /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_MBCS" /D "ACE_HAS_MFC" /D "PILOT" /D "_AFXDLL" /FR /Yu"stdafx.h" /FD /GZ /c
# ADD BASE MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x419 /d "_DEBUG" /d "_AFXDLL"
# ADD RSC /l 0x419 /d "_DEBUG" /d "_AFXDLL"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 WSOCK32.LIB /nologo /subsystem:windows /profile /debug /machine:I386
# ADD LINK32 WSOCK32.LIB aced.lib TAOd.lib TAO_PortableServerd.lib TAO_CosNamingd.lib TAO_CosPropertyd.lib TAO_DsLogAdmind.lib TAO_Svc_Utilsd.lib TAO_CosTimed.lib TAO_CosNotificationd.lib TAO_CosEventd.lib /nologo /subsystem:windows /debug /machine:I386 /out:"Downloader___Win32_Pilot_Debug/GblPilotServerDownld.exe"
# SUBTRACT LINK32 /profile /incremental:no

!ELSEIF  "$(CFG)" == "Downloader - Win32 Pilot Release"

# PROP BASE Use_MFC 6
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Downloader___Win32_Pilot_Release"
# PROP BASE Intermediate_Dir "Downloader___Win32_Pilot_Release"
# PROP BASE Ignore_Export_Lib 0
# PROP BASE Target_Dir ""
# PROP Use_MFC 6
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Downloader___Win32_Pilot_Release"
# PROP Intermediate_Dir "Downloader___Win32_Pilot_Release"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MD /W3 /GX /O2 /I "." /I "..\..\libs\cchlp\src" /I "..\..\libs\gc\src" /I "..\..\tools\gctools\src" /I "..\..\libs\gkdb\src" /I "..\..\include" /I "..\..\tools\delta\src" /I "..\..\include\win32" /I "..\..\libs\delta\src" /I "..\..\libs\gsscreen\src" /I "..\..\libs\protect\src" /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_MBCS" /D "_AFXDLL" /Fr /Yu"stdafx.h" /FD /c
# ADD CPP /nologo /MD /W3 /GX /O2 /I "." /I "..\..\libs\cchlp\src" /I "..\..\libs\gc\src" /I "..\..\tools\gctools\src" /I "..\..\libs\gkdb\src" /I "..\..\include" /I "..\..\tools\delta\src" /I "..\..\include\win32" /I "..\..\libs\delta\src" /I "..\..\libs\gsscreen\src" /I "..\..\libs\protect\src" /I "W:\common\components\corba" /I "W:\common\components\corba\GCD\cpp" /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_MBCS" /D "UPDATE_FACE" /D "ACE_HAS_MFC" /D _WIN32_WINNT=0x0400 /D "PILOT" /D "_AFXDLL" /D "VERSION56" /D "MULTI_INDEX_STREAM_FILE" /D "INSTLL_CIB" /Fr /FD /c
# SUBTRACT CPP /YX /Yc /Yu
# ADD BASE MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x419 /d "NDEBUG" /d "_AFXDLL"
# ADD RSC /l 0x419 /d "NDEBUG" /d "_AFXDLL"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 WSOCK32.LIB WININET.LIB /nologo /subsystem:windows /machine:I386
# ADD LINK32 WSOCK32.LIB WININET.LIB acemfc.lib TAOmfc.lib TAO_PortableServermfc.lib TAO_CosNamingmfc.lib TAO_RTEventmfc.lib TAO_CosPropertymfc.lib TAO_DsLogAdminmfc.lib TAO_Svc_Utilsmfc.lib TAO_CosTimemfc.lib TAO_CosNotificationmfc.lib /nologo /subsystem:windows /machine:I386 /out:"Downloader___Win32_Pilot_Release/GblPilotServerDownld.exe"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Client_Debug"

# PROP BASE Use_MFC 6
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "W:\build\bin\Client_Debug"
# PROP BASE Intermediate_Dir "W:\build\temp\Client_Debug\GbaDownloader"
# PROP BASE Ignore_Export_Lib 0
# PROP BASE Target_Dir ""
# PROP Use_MFC 6
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "W:\build\bin\Client_Debug"
# PROP Intermediate_Dir "W:\build\temp\Client_Debug\GbaDownloader"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MDd /W3 /GR /GX /Zi /Od /Oy /I "." /I "..\..\libs\cchlp\src" /I "..\..\libs\gc\src" /I "..\..\tools\gctools\src" /I "..\..\libs\gkdb\src" /I "..\..\include" /I "..\..\tools\delta\src" /I "..\..\include\win32" /I "..\..\libs\delta\src" /I "..\..\libs\gsscreen\src" /I "..\..\libs\protect\src" /I "W:\common\components\corba" /I "W:\common\components\corba\GCD\cpp" /D "_DEBUG" /D "_AFXDLL" /D "_MBCS" /D "WIN32" /D "_WINDOWS" /D "_GCD_CLIENT" /D "INSTLL_CIB" /D "MULTI_INDEX_STREAM_FILE" /D "VERSION56" /D "VERSION61" /D "WINENCODE" /Fr /FD /GZ /c
# ADD CPP /nologo /MDd /W3 /GR /GX /Zi /Od /Oy /I "." /I "..\..\libs\cchlp\src" /I "..\..\libs\gc\src" /I "..\..\tools\gctools\src" /I "..\..\libs\gkdb\src" /I "..\..\include" /I "..\..\tools\delta\src" /I "..\..\include\win32" /I "..\..\libs\delta\src" /I "..\..\libs\gsscreen\src" /I "..\..\libs\protect\src" /I "W:\common\components\corba" /I "W:\common\components\corba\GCD\cpp" /D "_DEBUG" /D "_AFXDLL" /D "_MBCS" /D "WIN32" /D "_WINDOWS" /D "_GCD_CLIENT" /D "INSTLL_CIB" /D "MULTI_INDEX_STREAM_FILE" /D "VERSION56" /D "VERSION61" /D "WINENCODE" /Fr /FD /GZ /c
# ADD BASE MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x419 /fo"W:\build\temp\Client_Debug\GbaDownloader\GbaDownloader.res" /d "_DEBUG" /d "_AFXDLL" /d "_GCD_CLIENT"
# ADD RSC /l 0x419 /fo"W:\build\temp\Client_Debug\GbaDownloader\GbaDownloader.res" /d "_DEBUG" /d "_AFXDLL" /d "_GCD_CLIENT"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo /o"W:\build\bin\Client_Debug\GbaDownloader.bsc"
# ADD BSC32 /nologo /o"W:\build\bin\Client_Debug\GbaDownloader.bsc"
LINK32=link.exe
# ADD BASE LINK32 htmlhelp.lib wininet.lib wsock32.lib ACEd.lib TAOd.lib TAO_CosNamingd.lib TAO_Messagingd.lib TAO_PortableServerd.lib TAO_RTEventd.lib TAO_Svc_Utilsd.lib /nologo /version:6.0 /stack:0x1000000,0x100000 /subsystem:windows /debug /machine:I386 /out:"W:\build\bin\Client_Debug\GbaDownloader.exe"
# ADD LINK32 htmlhelp.lib wininet.lib wsock32.lib ACEd.lib TAOd.lib TAO_CosNamingd.lib TAO_Messagingd.lib TAO_PortableServerd.lib TAO_RTEventd.lib TAO_Svc_Utilsd.lib /nologo /version:6.0 /stack:0x1000000,0x100000 /subsystem:windows /debug /machine:I386 /out:"W:\build\bin\Client_Debug\GbaDownloader.exe"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Client_Purify"

# PROP BASE Use_MFC 6
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "W:\build\bin\Client_Purify"
# PROP BASE Intermediate_Dir "W:\build\temp\Client_Purify\GbaDownloader"
# PROP BASE Ignore_Export_Lib 0
# PROP BASE Target_Dir ""
# PROP Use_MFC 6
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "W:\build\bin\Client_Purify"
# PROP Intermediate_Dir "W:\build\temp\Client_Purify\GbaDownloader"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MD /W3 /GR /GX /Zi /Od /Oy /I "." /I "..\..\libs\cchlp\src" /I "..\..\libs\gc\src" /I "..\..\tools\gctools\src" /I "..\..\libs\gkdb\src" /I "..\..\include" /I "..\..\tools\delta\src" /I "..\..\include\win32" /I "..\..\libs\delta\src" /I "..\..\libs\gsscreen\src" /I "..\..\libs\protect\src" /I "W:\common\components\corba" /I "W:\common\components\corba\GCD\cpp" /D "NDEBUG" /D "_AFXDLL" /D "_MBCS" /D "WIN32" /D "_WINDOWS" /D "_GCD_CLIENT" /D "INSTLL_CIB" /D "MULTI_INDEX_STREAM_FILE" /D "VERSION56" /D "VERSION61" /D "WINENCODE" /Fr /FD /GZ /c
# ADD CPP /nologo /MD /W3 /GR /GX /Zi /Od /Oy /I "." /I "..\..\libs\cchlp\src" /I "..\..\libs\gc\src" /I "..\..\tools\gctools\src" /I "..\..\libs\gkdb\src" /I "..\..\include" /I "..\..\tools\delta\src" /I "..\..\include\win32" /I "..\..\libs\delta\src" /I "..\..\libs\gsscreen\src" /I "..\..\libs\protect\src" /I "W:\common\components\corba" /I "W:\common\components\corba\GCD\cpp" /D "NDEBUG" /D "_AFXDLL" /D "_MBCS" /D "WIN32" /D "_WINDOWS" /D "_GCD_CLIENT" /D "INSTLL_CIB" /D "MULTI_INDEX_STREAM_FILE" /D "VERSION56" /D "VERSION61" /D "WINENCODE" /Fr /FD /GZ /c
# ADD BASE MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x419 /fo"W:\build\temp\Client_Purify\GbaDownloader\GbaDownloader.res" /d "NDEBUG" /d "_AFXDLL" /d "_GCD_CLIENT"
# ADD RSC /l 0x419 /fo"W:\build\temp\Client_Purify\GbaDownloader\GbaDownloader.res" /d "NDEBUG" /d "_AFXDLL" /d "_GCD_CLIENT"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo /o"W:\build\bin\Client_Purify\GbaDownloader.bsc"
# ADD BSC32 /nologo /o"W:\build\bin\Client_Purify\GbaDownloader.bsc"
LINK32=link.exe
# ADD BASE LINK32 htmlhelp.lib wininet.lib wsock32.lib ACE.lib TAO.lib TAO_CosNaming.lib TAO_Messaging.lib TAO_PortableServer.lib TAO_RTEvent.lib TAO_Svc_Utils.lib /nologo /version:6.0 /stack:0x1000000,0x100000 /subsystem:windows /debug /machine:I386 /out:"W:\build\bin\Client_Purify\GbaDownloader.exe"
# ADD LINK32 htmlhelp.lib wininet.lib wsock32.lib ACE.lib TAO.lib TAO_CosNaming.lib TAO_Messaging.lib TAO_PortableServer.lib TAO_RTEvent.lib TAO_Svc_Utils.lib /nologo /version:6.0 /stack:0x1000000,0x100000 /subsystem:windows /debug /machine:I386 /out:"W:\build\bin\Client_Purify\GbaDownloader.exe"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Client_Release"

# PROP BASE Use_MFC 6
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "W:\build\bin\Client_Release"
# PROP BASE Intermediate_Dir "W:\build\temp\Client_Release\GbaDownloader"
# PROP BASE Ignore_Export_Lib 0
# PROP BASE Target_Dir ""
# PROP Use_MFC 6
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "W:\build\bin\Client_Release"
# PROP Intermediate_Dir "W:\build\temp\Client_Release\GbaDownloader"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MD /W3 /GR /GX /O2 /I "." /I "..\..\libs\cchlp\src" /I "..\..\libs\gc\src" /I "..\..\tools\gctools\src" /I "..\..\libs\gkdb\src" /I "..\..\include" /I "..\..\tools\delta\src" /I "..\..\include\win32" /I "..\..\libs\delta\src" /I "..\..\libs\gsscreen\src" /I "..\..\libs\protect\src" /I "W:\common\components\corba" /I "W:\common\components\corba\GCD\cpp" /D "NDEBUG" /D "_AFXDLL" /D "_MBCS" /D "WIN32" /D "_WINDOWS" /D "_GCD_CLIENT" /D "INSTLL_CIB" /D "MULTI_INDEX_STREAM_FILE" /D "VERSION56" /D "VERSION61" /D "WINENCODE" /Fr /FD /GZ /c
# ADD CPP /nologo /MD /W3 /GR /GX /O2 /I "." /I "..\..\libs\cchlp\src" /I "..\..\libs\gc\src" /I "..\..\tools\gctools\src" /I "..\..\libs\gkdb\src" /I "..\..\include" /I "..\..\tools\delta\src" /I "..\..\include\win32" /I "..\..\libs\delta\src" /I "..\..\libs\gsscreen\src" /I "..\..\libs\protect\src" /I "W:\common\components\corba" /I "W:\common\components\corba\GCD\cpp" /D "NDEBUG" /D "_AFXDLL" /D "_MBCS" /D "WIN32" /D "_WINDOWS" /D "_GCD_CLIENT" /D "INSTLL_CIB" /D "MULTI_INDEX_STREAM_FILE" /D "VERSION56" /D "VERSION61" /D "WINENCODE" /Fr /FD /GZ /c
# ADD BASE MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x419 /fo"W:\build\temp\Client_Release\GbaDownloader\GbaDownloader.res" /d "NDEBUG" /d "_AFXDLL" /d "_GCD_CLIENT"
# ADD RSC /l 0x419 /fo"W:\build\temp\Client_Release\GbaDownloader\GbaDownloader.res" /d "NDEBUG" /d "_AFXDLL" /d "_GCD_CLIENT"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo /o"W:\build\bin\Client_Release\GbaDownloader.bsc"
# ADD BSC32 /nologo /o"W:\build\bin\Client_Release\GbaDownloader.bsc"
LINK32=link.exe
# ADD BASE LINK32 htmlhelp.lib wininet.lib wsock32.lib ACE.lib TAO.lib TAO_CosNaming.lib TAO_Messaging.lib TAO_PortableServer.lib TAO_RTEvent.lib TAO_Svc_Utils.lib /nologo /version:6.0 /stack:0x1000000,0x100000 /subsystem:windows /pdb:none /machine:I386 /out:"W:\build\bin\Client_Release\GbaDownloader.exe"
# ADD LINK32 htmlhelp.lib wininet.lib wsock32.lib ACE.lib TAO.lib TAO_CosNaming.lib TAO_Messaging.lib TAO_PortableServer.lib TAO_RTEvent.lib TAO_Svc_Utils.lib /nologo /version:6.0 /stack:0x1000000,0x100000 /subsystem:windows /pdb:none /machine:I386 /out:"W:\build\bin\Client_Release\GbaDownloader.exe"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Client_Final"

# PROP BASE Use_MFC 6
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "W:\build\bin\Client_Final"
# PROP BASE Intermediate_Dir "W:\build\temp\Client_Final\GbaDownloader"
# PROP BASE Ignore_Export_Lib 0
# PROP BASE Target_Dir ""
# PROP Use_MFC 6
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "W:\build\bin\Client_Final"
# PROP Intermediate_Dir "W:\build\temp\Client_Final\GbaDownloader"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MD /W3 /GR /GX /O2 /I "." /I "..\..\libs\cchlp\src" /I "..\..\libs\gc\src" /I "..\..\tools\gctools\src" /I "..\..\libs\gkdb\src" /I "..\..\include" /I "..\..\tools\delta\src" /I "..\..\include\win32" /I "..\..\libs\delta\src" /I "..\..\libs\gsscreen\src" /I "..\..\libs\protect\src" /I "W:\common\components\corba" /I "W:\common\components\corba\GCD\cpp" /D "NDEBUG" /D "_AFXDLL" /D "_MBCS" /D "WIN32" /D "_WINDOWS" /D "_GCD_CLIENT" /D "GCL_NLOG_DEBUG" /D "INSTLL_CIB" /D "MULTI_INDEX_STREAM_FILE" /D "VERSION56" /D "VERSION61" /D "WINENCODE" /Fr /FD /GZ /c
# ADD CPP /nologo /MD /W3 /GR /GX /O2 /I "." /I "..\..\libs\cchlp\src" /I "..\..\libs\gc\src" /I "..\..\tools\gctools\src" /I "..\..\libs\gkdb\src" /I "..\..\include" /I "..\..\tools\delta\src" /I "..\..\include\win32" /I "..\..\libs\delta\src" /I "..\..\libs\gsscreen\src" /I "..\..\libs\protect\src" /I "W:\common\components\corba" /I "W:\common\components\corba\GCD\cpp" /D "NDEBUG" /D "_AFXDLL" /D "_MBCS" /D "WIN32" /D "_WINDOWS" /D "_GCD_CLIENT" /D "GCL_NLOG_DEBUG" /D "INSTLL_CIB" /D "MULTI_INDEX_STREAM_FILE" /D "VERSION56" /D "VERSION61" /D "WINENCODE" /Fr /FD /GZ /c
# ADD BASE MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x419 /fo"W:\build\temp\Client_Final\GbaDownloader\GbaDownloader.res" /d "NDEBUG" /d "_AFXDLL" /d "_GCD_CLIENT"
# ADD RSC /l 0x419 /fo"W:\build\temp\Client_Final\GbaDownloader\GbaDownloader.res" /d "NDEBUG" /d "_AFXDLL" /d "_GCD_CLIENT"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo /o"W:\build\bin\Client_Final\GbaDownloader.bsc"
# ADD BSC32 /nologo /o"W:\build\bin\Client_Final\GbaDownloader.bsc"
LINK32=link.exe
# ADD BASE LINK32 htmlhelp.lib wininet.lib wsock32.lib ACE.lib TAO.lib TAO_CosNaming.lib TAO_Messaging.lib TAO_PortableServer.lib TAO_RTEvent.lib TAO_Svc_Utils.lib /nologo /version:6.0 /stack:0x1000000,0x100000 /subsystem:windows /pdb:none /machine:I386 /out:"W:\build\bin\Client_Final\GbaDownloader.exe"
# ADD LINK32 htmlhelp.lib wininet.lib wsock32.lib ACE.lib TAO.lib TAO_CosNaming.lib TAO_Messaging.lib TAO_PortableServer.lib TAO_RTEvent.lib TAO_Svc_Utils.lib /nologo /version:6.0 /stack:0x1000000,0x100000 /subsystem:windows /pdb:none /machine:I386 /out:"W:\build\bin\Client_Final\GbaDownloader.exe"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Client_Debug_Static"

# PROP BASE Use_MFC 5
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "W:\build\bin\Client_Debug_Static"
# PROP BASE Intermediate_Dir "W:\build\temp\Client_Debug_Static\GbaDownloader"
# PROP BASE Ignore_Export_Lib 0
# PROP BASE Target_Dir ""
# PROP Use_MFC 5
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "W:\build\bin\Client_Debug_Static"
# PROP Intermediate_Dir "W:\build\temp\Client_Debug_Static\GbaDownloader"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MTd /W3 /GR /GX /Zi /Od /Oy /I "." /I "..\..\libs\cchlp\src" /I "..\..\libs\gc\src" /I "..\..\tools\gctools\src" /I "..\..\libs\gkdb\src" /I "..\..\include" /I "..\..\tools\delta\src" /I "..\..\include\win32" /I "..\..\libs\delta\src" /I "..\..\libs\gsscreen\src" /I "..\..\libs\protect\src" /I "W:\common\components\corba" /I "W:\common\components\corba\GCD\cpp" /D "_DEBUG" /D "_MBCS" /D "WIN32" /D "_WINDOWS" /D "_GCD_CLIENT" /D "_GCD_STATIC" /D "ACE_AS_STATIC_LIBS" /D "TAO_AS_STATIC_LIBS" /D "INSTLL_CIB" /D "MULTI_INDEX_STREAM_FILE" /D "VERSION56" /D "VERSION61" /D "WINENCODE" /Fr /FD /GZ /c
# ADD CPP /nologo /MTd /W3 /GR /GX /Zi /Od /Oy /I "." /I "..\..\libs\cchlp\src" /I "..\..\libs\gc\src" /I "..\..\tools\gctools\src" /I "..\..\libs\gkdb\src" /I "..\..\include" /I "..\..\tools\delta\src" /I "..\..\include\win32" /I "..\..\libs\delta\src" /I "..\..\libs\gsscreen\src" /I "..\..\libs\protect\src" /I "W:\common\components\corba" /I "W:\common\components\corba\GCD\cpp" /D "_DEBUG" /D "_MBCS" /D "WIN32" /D "_WINDOWS" /D "_GCD_CLIENT" /D "_GCD_STATIC" /D "ACE_AS_STATIC_LIBS" /D "TAO_AS_STATIC_LIBS" /D "INSTLL_CIB" /D "MULTI_INDEX_STREAM_FILE" /D "VERSION56" /D "VERSION61" /D "WINENCODE" /Fr /FD /GZ /c
# ADD BASE MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x419 /fo"W:\build\temp\Client_Debug_Static\GbaDownloader\GbaDownloader.res" /d "_DEBUG" /d "_GCD_CLIENT" /d "_GCD_STATIC" /d "ACE_AS_STATIC_LIBS" /d "TAO_AS_STATIC_LIBS"
# ADD RSC /l 0x419 /fo"W:\build\temp\Client_Debug_Static\GbaDownloader\GbaDownloader.res" /d "_DEBUG" /d "_GCD_CLIENT" /d "_GCD_STATIC" /d "ACE_AS_STATIC_LIBS" /d "TAO_AS_STATIC_LIBS"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo /o"W:\build\bin\Client_Debug_Static\GbaDownloader.bsc"
# ADD BSC32 /nologo /o"W:\build\bin\Client_Debug_Static\GbaDownloader.bsc"
LINK32=link.exe
# ADD BASE LINK32 nafxcwd.lib libcmtd.lib htmlhelp.lib wininet.lib wsock32.lib ACEsd.lib TAOsd.lib TAO_CosNamingsd.lib TAO_Messagingsd.lib TAO_PortableServersd.lib TAO_RTEventsd.lib TAO_Svc_Utilssd.lib /nologo /version:6.0 /stack:0x1000000,0x100000 /subsystem:windows /debug /machine:I386 /nodefaultlib:"nafxcwd.lib libcmtd.lib" /out:"W:\build\bin\Client_Debug_Static\GbaDownloader.exe"
# ADD LINK32 nafxcwd.lib libcmtd.lib htmlhelp.lib wininet.lib wsock32.lib ACEsd.lib TAOsd.lib TAO_CosNamingsd.lib TAO_Messagingsd.lib TAO_PortableServersd.lib TAO_RTEventsd.lib TAO_Svc_Utilssd.lib /nologo /version:6.0 /stack:0x1000000,0x100000 /subsystem:windows /debug /machine:I386 /nodefaultlib:"nafxcwd.lib libcmtd.lib" /out:"W:\build\bin\Client_Debug_Static\GbaDownloader.exe"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Client_Purify_Static"

# PROP BASE Use_MFC 5
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "W:\build\bin\Client_Purify_Static"
# PROP BASE Intermediate_Dir "W:\build\temp\Client_Purify_Static\GbaDownloader"
# PROP BASE Ignore_Export_Lib 0
# PROP BASE Target_Dir ""
# PROP Use_MFC 5
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "W:\build\bin\Client_Purify_Static"
# PROP Intermediate_Dir "W:\build\temp\Client_Purify_Static\GbaDownloader"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MT /W3 /GR /GX /Zi /Od /Oy /I "." /I "..\..\libs\cchlp\src" /I "..\..\libs\gc\src" /I "..\..\tools\gctools\src" /I "..\..\libs\gkdb\src" /I "..\..\include" /I "..\..\tools\delta\src" /I "..\..\include\win32" /I "..\..\libs\delta\src" /I "..\..\libs\gsscreen\src" /I "..\..\libs\protect\src" /I "W:\common\components\corba" /I "W:\common\components\corba\GCD\cpp" /D "NDEBUG" /D "_MBCS" /D "WIN32" /D "_WINDOWS" /D "_GCD_CLIENT" /D "_GCD_STATIC" /D "ACE_AS_STATIC_LIBS" /D "TAO_AS_STATIC_LIBS" /D "INSTLL_CIB" /D "MULTI_INDEX_STREAM_FILE" /D "VERSION56" /D "VERSION61" /D "WINENCODE" /Fr /FD /GZ /c
# ADD CPP /nologo /MT /W3 /GR /GX /Zi /Od /Oy /I "." /I "..\..\libs\cchlp\src" /I "..\..\libs\gc\src" /I "..\..\tools\gctools\src" /I "..\..\libs\gkdb\src" /I "..\..\include" /I "..\..\tools\delta\src" /I "..\..\include\win32" /I "..\..\libs\delta\src" /I "..\..\libs\gsscreen\src" /I "..\..\libs\protect\src" /I "W:\common\components\corba" /I "W:\common\components\corba\GCD\cpp" /D "NDEBUG" /D "_MBCS" /D "WIN32" /D "_WINDOWS" /D "_GCD_CLIENT" /D "_GCD_STATIC" /D "ACE_AS_STATIC_LIBS" /D "TAO_AS_STATIC_LIBS" /D "INSTLL_CIB" /D "MULTI_INDEX_STREAM_FILE" /D "VERSION56" /D "VERSION61" /D "WINENCODE" /Fr /FD /GZ /c
# ADD BASE MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x419 /fo"W:\build\temp\Client_Purify_Static\GbaDownloader\GbaDownloader.res" /d "NDEBUG" /d "_GCD_CLIENT" /d "_GCD_STATIC" /d "ACE_AS_STATIC_LIBS" /d "TAO_AS_STATIC_LIBS"
# ADD RSC /l 0x419 /fo"W:\build\temp\Client_Purify_Static\GbaDownloader\GbaDownloader.res" /d "NDEBUG" /d "_GCD_CLIENT" /d "_GCD_STATIC" /d "ACE_AS_STATIC_LIBS" /d "TAO_AS_STATIC_LIBS"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo /o"W:\build\bin\Client_Purify_Static\GbaDownloader.bsc"
# ADD BSC32 /nologo /o"W:\build\bin\Client_Purify_Static\GbaDownloader.bsc"
LINK32=link.exe
# ADD BASE LINK32 nafxcw.lib libcmt.lib htmlhelp.lib wininet.lib wsock32.lib ACEs.lib TAOs.lib TAO_CosNamings.lib TAO_Messagings.lib TAO_PortableServers.lib TAO_RTEvents.lib TAO_Svc_Utilss.lib /nologo /version:6.0 /stack:0x1000000,0x100000 /subsystem:windows /debug /machine:I386 /nodefaultlib:"nafxcw.lib libcmt.lib" /out:"W:\build\bin\Client_Purify_Static\GbaDownloader.exe"
# ADD LINK32 nafxcw.lib libcmt.lib htmlhelp.lib wininet.lib wsock32.lib ACEs.lib TAOs.lib TAO_CosNamings.lib TAO_Messagings.lib TAO_PortableServers.lib TAO_RTEvents.lib TAO_Svc_Utilss.lib /nologo /version:6.0 /stack:0x1000000,0x100000 /subsystem:windows /debug /machine:I386 /nodefaultlib:"nafxcw.lib libcmt.lib" /out:"W:\build\bin\Client_Purify_Static\GbaDownloader.exe"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Client_Release_Static"

# PROP BASE Use_MFC 5
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "W:\build\bin\Client_Release_Static"
# PROP BASE Intermediate_Dir "W:\build\temp\Client_Release_Static\GbaDownloader"
# PROP BASE Ignore_Export_Lib 0
# PROP BASE Target_Dir ""
# PROP Use_MFC 5
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "W:\build\bin\Client_Release_Static"
# PROP Intermediate_Dir "W:\build\temp\Client_Release_Static\GbaDownloader"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MT /W3 /GR /GX /O2 /I "." /I "..\..\libs\cchlp\src" /I "..\..\libs\gc\src" /I "..\..\tools\gctools\src" /I "..\..\libs\gkdb\src" /I "..\..\include" /I "..\..\tools\delta\src" /I "..\..\include\win32" /I "..\..\libs\delta\src" /I "..\..\libs\gsscreen\src" /I "..\..\libs\protect\src" /I "W:\common\components\corba" /I "W:\common\components\corba\GCD\cpp" /D "NDEBUG" /D "_MBCS" /D "WIN32" /D "_WINDOWS" /D "_GCD_CLIENT" /D "_GCD_STATIC" /D "ACE_AS_STATIC_LIBS" /D "TAO_AS_STATIC_LIBS" /D "INSTLL_CIB" /D "MULTI_INDEX_STREAM_FILE" /D "VERSION56" /D "VERSION61" /D "WINENCODE" /Fr /FD /GZ /c
# ADD CPP /nologo /MT /W3 /GR /GX /O2 /I "." /I "..\..\libs\cchlp\src" /I "..\..\libs\gc\src" /I "..\..\tools\gctools\src" /I "..\..\libs\gkdb\src" /I "..\..\include" /I "..\..\tools\delta\src" /I "..\..\include\win32" /I "..\..\libs\delta\src" /I "..\..\libs\gsscreen\src" /I "..\..\libs\protect\src" /I "W:\common\components\corba" /I "W:\common\components\corba\GCD\cpp" /D "NDEBUG" /D "_MBCS" /D "WIN32" /D "_WINDOWS" /D "_GCD_CLIENT" /D "_GCD_STATIC" /D "ACE_AS_STATIC_LIBS" /D "TAO_AS_STATIC_LIBS" /D "INSTLL_CIB" /D "MULTI_INDEX_STREAM_FILE" /D "VERSION56" /D "VERSION61" /D "WINENCODE" /Fr /FD /GZ /c
# ADD BASE MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x419 /fo"W:\build\temp\Client_Release_Static\GbaDownloader\GbaDownloader.res" /d "NDEBUG" /d "_GCD_CLIENT" /d "_GCD_STATIC" /d "ACE_AS_STATIC_LIBS" /d "TAO_AS_STATIC_LIBS"
# ADD RSC /l 0x419 /fo"W:\build\temp\Client_Release_Static\GbaDownloader\GbaDownloader.res" /d "NDEBUG" /d "_GCD_CLIENT" /d "_GCD_STATIC" /d "ACE_AS_STATIC_LIBS" /d "TAO_AS_STATIC_LIBS"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo /o"W:\build\bin\Client_Release_Static\GbaDownloader.bsc"
# ADD BSC32 /nologo /o"W:\build\bin\Client_Release_Static\GbaDownloader.bsc"
LINK32=link.exe
# ADD BASE LINK32 nafxcw.lib libcmt.lib htmlhelp.lib wininet.lib wsock32.lib ACEs.lib TAOs.lib TAO_CosNamings.lib TAO_Messagings.lib TAO_PortableServers.lib TAO_RTEvents.lib TAO_Svc_Utilss.lib /nologo /version:6.0 /stack:0x1000000,0x100000 /subsystem:windows /pdb:none /machine:I386 /nodefaultlib:"nafxcw.lib libcmt.lib" /out:"W:\build\bin\Client_Release_Static\GbaDownloader.exe"
# ADD LINK32 nafxcw.lib libcmt.lib htmlhelp.lib wininet.lib wsock32.lib ACEs.lib TAOs.lib TAO_CosNamings.lib TAO_Messagings.lib TAO_PortableServers.lib TAO_RTEvents.lib TAO_Svc_Utilss.lib /nologo /version:6.0 /stack:0x1000000,0x100000 /subsystem:windows /pdb:none /machine:I386 /nodefaultlib:"nafxcw.lib libcmt.lib" /out:"W:\build\bin\Client_Release_Static\GbaDownloader.exe"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Client_Final_Static"

# PROP BASE Use_MFC 5
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "W:\build\bin\Client_Final_Static"
# PROP BASE Intermediate_Dir "W:\build\temp\Client_Final_Static\GbaDownloader"
# PROP BASE Ignore_Export_Lib 0
# PROP BASE Target_Dir ""
# PROP Use_MFC 5
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "W:\build\bin\Client_Final_Static"
# PROP Intermediate_Dir "W:\build\temp\Client_Final_Static\GbaDownloader"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MT /W3 /GR /GX /O2 /I "." /I "..\..\libs\cchlp\src" /I "..\..\libs\gc\src" /I "..\..\tools\gctools\src" /I "..\..\libs\gkdb\src" /I "..\..\include" /I "..\..\tools\delta\src" /I "..\..\include\win32" /I "..\..\libs\delta\src" /I "..\..\libs\gsscreen\src" /I "..\..\libs\protect\src" /I "W:\common\components\corba" /I "W:\common\components\corba\GCD\cpp" /D "NDEBUG" /D "_MBCS" /D "WIN32" /D "_WINDOWS" /D "_GCD_CLIENT" /D "_GCD_STATIC" /D "GCL_NLOG_DEBUG" /D "ACE_AS_STATIC_LIBS" /D "TAO_AS_STATIC_LIBS" /D "INSTLL_CIB" /D "MULTI_INDEX_STREAM_FILE" /D "VERSION56" /D "VERSION61" /D "WINENCODE" /Fr /FD /GZ /c
# ADD CPP /nologo /MT /W3 /GR /GX /O2 /I "." /I "..\..\libs\cchlp\src" /I "..\..\libs\gc\src" /I "..\..\tools\gctools\src" /I "..\..\libs\gkdb\src" /I "..\..\include" /I "..\..\tools\delta\src" /I "..\..\include\win32" /I "..\..\libs\delta\src" /I "..\..\libs\gsscreen\src" /I "..\..\libs\protect\src" /I "W:\common\components\corba" /I "W:\common\components\corba\GCD\cpp" /D "NDEBUG" /D "_MBCS" /D "WIN32" /D "_WINDOWS" /D "_GCD_CLIENT" /D "_GCD_STATIC" /D "GCL_NLOG_DEBUG" /D "ACE_AS_STATIC_LIBS" /D "TAO_AS_STATIC_LIBS" /D "INSTLL_CIB" /D "MULTI_INDEX_STREAM_FILE" /D "VERSION56" /D "VERSION61" /D "WINENCODE" /Fr /FD /GZ /c
# ADD BASE MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x419 /fo"W:\build\temp\Client_Final_Static\GbaDownloader\GbaDownloader.res" /d "NDEBUG" /d "_GCD_CLIENT" /d "_GCD_STATIC" /d "ACE_AS_STATIC_LIBS" /d "TAO_AS_STATIC_LIBS"
# ADD RSC /l 0x419 /fo"W:\build\temp\Client_Final_Static\GbaDownloader\GbaDownloader.res" /d "NDEBUG" /d "_GCD_CLIENT" /d "_GCD_STATIC" /d "ACE_AS_STATIC_LIBS" /d "TAO_AS_STATIC_LIBS"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo /o"W:\build\bin\Client_Final_Static\GbaDownloader.bsc"
# ADD BSC32 /nologo /o"W:\build\bin\Client_Final_Static\GbaDownloader.bsc"
LINK32=link.exe
# ADD BASE LINK32 nafxcw.lib libcmt.lib htmlhelp.lib wininet.lib wsock32.lib ACEs.lib TAOs.lib TAO_CosNamings.lib TAO_Messagings.lib TAO_PortableServers.lib TAO_RTEvents.lib TAO_Svc_Utilss.lib /nologo /version:6.0 /stack:0x1000000,0x100000 /subsystem:windows /pdb:none /machine:I386 /nodefaultlib:"nafxcw.lib libcmt.lib" /out:"W:\build\bin\Client_Final_Static\GbaDownloader.exe"
# ADD LINK32 nafxcw.lib libcmt.lib htmlhelp.lib wininet.lib wsock32.lib ACEs.lib TAOs.lib TAO_CosNamings.lib TAO_Messagings.lib TAO_PortableServers.lib TAO_RTEvents.lib TAO_Svc_Utilss.lib /nologo /version:6.0 /stack:0x1000000,0x100000 /subsystem:windows /pdb:none /machine:I386 /nodefaultlib:"nafxcw.lib libcmt.lib" /out:"W:\build\bin\Client_Final_Static\GbaDownloader.exe"

!ENDIF 

# Begin Target

# Name "Downloader - Win32 Release"
# Name "Downloader - Win32 Debug"
# Name "Downloader - Win32 Release56x"
# Name "Downloader - Win32 Pilot Debug"
# Name "Downloader - Win32 Pilot Release"
# Name "Downloader - Win32 Client_Debug"
# Name "Downloader - Win32 Client_Purify"
# Name "Downloader - Win32 Client_Release"
# Name "Downloader - Win32 Client_Final"
# Name "Downloader - Win32 Client_Debug_Static"
# Name "Downloader - Win32 Client_Purify_Static"
# Name "Downloader - Win32 Client_Release_Static"
# Name "Downloader - Win32 Client_Final_Static"
# Begin Group "Source Files"

# PROP Default_Filter "cpp;c;cxx;rc;def;r;odl;idl;hpj;bat"
# Begin Source File

SOURCE=.\AboutDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\AnimateDlgIcon.cpp
# End Source File
# Begin Source File

SOURCE=.\Common.cpp
# End Source File
# Begin Source File

SOURCE=.\ComplectsCombo.cpp
# End Source File
# Begin Source File

SOURCE=.\DataBaseProc.cpp
# End Source File
# Begin Source File

SOURCE=.\Downloader.cpp
# End Source File
# Begin Source File

SOURCE=.\Downloader.rc
# End Source File
# Begin Source File

SOURCE=.\DownloaderDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\DownloadParams.cpp
# End Source File
# Begin Source File

SOURCE=.\DownloadProcess.cpp
# End Source File
# Begin Source File

SOURCE=.\DownloadWndThread.cpp
# End Source File
# Begin Source File

SOURCE=.\EndDownloadDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\ErrorsProc.cpp
# End Source File
# Begin Source File

SOURCE=.\HttpReader.cpp
# End Source File
# Begin Source File

SOURCE=.\InetAccessSettings.cpp
# End Source File
# Begin Source File

SOURCE=.\InetProc.cpp
# End Source File
# Begin Source File

SOURCE=.\InternetFileDownload.cpp
# End Source File
# Begin Source File

SOURCE=.\LogFile.cpp
# End Source File
# Begin Source File

SOURCE=.\LoginDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\OLEDateTimeEx.cpp
# End Source File
# Begin Source File

SOURCE=.\PilotLoginDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\Ping.cpp
# End Source File
# Begin Source File

SOURCE=.\ProxyInfo.cpp
# End Source File
# Begin Source File

SOURCE=.\ServerConnect.cpp
# End Source File
# Begin Source File

SOURCE=.\StatusProcessDlg.cpp
# End Source File
# Begin Source File

SOURCE=.\StdAfx.cpp
# ADD CPP /Yc"stdafx.h"
# End Source File
# End Group
# Begin Group "Header Files"

# PROP Default_Filter "h;hpp;hxx;hm;inl"
# Begin Source File

SOURCE=.\AboutDlg.h
# End Source File
# Begin Source File

SOURCE=.\AggressiveOptimize.h
# End Source File
# Begin Source File

SOURCE=.\AnimateDlgIcon.h
# End Source File
# Begin Source File

SOURCE=.\Common.h
# End Source File
# Begin Source File

SOURCE=.\Complect.h
# End Source File
# Begin Source File

SOURCE=.\ComplectsCombo.h
# End Source File
# Begin Source File

SOURCE=.\DataBaseProc.h
# End Source File
# Begin Source File

SOURCE=.\Downloader.h
# End Source File
# Begin Source File

SOURCE=.\DownloaderDlg.h
# End Source File
# Begin Source File

SOURCE=.\DownloadParams.h
# End Source File
# Begin Source File

SOURCE=.\DownloadProcess.h
# End Source File
# Begin Source File

SOURCE=.\DownloadWndThread.h
# End Source File
# Begin Source File

SOURCE=.\EndDownloadDlg.h
# End Source File
# Begin Source File

SOURCE=.\ErrorsProc.h
# End Source File
# Begin Source File

SOURCE=.\HttpReader.h
# End Source File
# Begin Source File

SOURCE=.\InetAccessSettings.h
# End Source File
# Begin Source File

SOURCE=.\InetProc.h
# End Source File
# Begin Source File

SOURCE=.\InternetFileDownload.h
# End Source File
# Begin Source File

SOURCE=.\LogFile.h
# End Source File
# Begin Source File

SOURCE=.\LoginDlg.h
# End Source File
# Begin Source File

SOURCE=.\OLEDateTimeEx.h
# End Source File
# Begin Source File

SOURCE=.\PilotLoginDlg.h
# End Source File
# Begin Source File

SOURCE=.\Ping.h
# End Source File
# Begin Source File

SOURCE=.\ProxyInfo.h
# End Source File
# Begin Source File

SOURCE=.\Resource.h
# End Source File
# Begin Source File

SOURCE=.\ServerConnect.h
# End Source File
# Begin Source File

SOURCE=.\StatusProcessDlg.h
# End Source File
# Begin Source File

SOURCE=.\StdAfx.h
# End Source File
# End Group
# Begin Group "Resource Files"

# PROP Default_Filter "ico;cur;bmp;dlg;rc2;rct;bin;rgs;gif;jpg;jpeg;jpe"
# Begin Source File

SOURCE=.\res\1507.ICO
# End Source File
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

SOURCE=.\res\bmp00001.bmp
# End Source File
# Begin Source File

SOURCE=.\res\Downloader.ico
# End Source File
# Begin Source File

SOURCE=.\res\Downloader.rc2
# End Source File
# Begin Source File

SOURCE=.\res\garant.bmp
# End Source File
# Begin Source File

SOURCE=.\res\icon1.ico
# End Source File
# Begin Source File

SOURCE=.\res\Progress.bmp
# End Source File
# End Group
# Begin Group "gkdb"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\libs\gkdb\src\adler32.c
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\base.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\base.h
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\basemask.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\basemask.h
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\basemsgs.h
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\bmsk_ver.h
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\btiter.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\btiter.h
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\btree.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\btree.h
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\check.h
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\collect.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\collect.h
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\crc32.c
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\deflate.c
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\deflate.h
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\docblock.cpp

!IF  "$(CFG)" == "Downloader - Win32 Release"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Downloader - Win32 Debug"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Downloader - Win32 Release56x"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Downloader - Win32 Pilot Debug"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Pilot Release"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Downloader - Win32 Client_Debug"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Client_Purify"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Client_Release"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Client_Final"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Client_Debug_Static"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Client_Purify_Static"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Client_Release_Static"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Client_Final_Static"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\doccol.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\doccol.h
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\dociter.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\dociter.h
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\document.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\document.h
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\dummies.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\fltiter.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\fltiter.h
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\gardefs.h
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\garutils.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\garutils.h
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\gkdb_ver.h
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\hindex.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\hindex.h
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\index.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\index.h
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\indices.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\indices.h
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\infblock.c
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\infblock.h
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\infcodes.c
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\infcodes.h
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\inffast.c
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\inffast.h
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\inflate.c
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\inftrees.c
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\inftrees.h
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\infutil.c
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\infutil.h
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\ncpf.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\ncpf.h
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\newdoc.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\newdoc.h
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\osdummy.c
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\pack.c
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\pack.h
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\pagefile.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\pagefile.h
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\paracol.cpp

!IF  "$(CFG)" == "Downloader - Win32 Release"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Debug"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Release56x"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Downloader - Win32 Pilot Debug"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Pilot Release"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Client_Debug"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Client_Purify"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Client_Release"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Client_Final"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Client_Debug_Static"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Client_Purify_Static"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Client_Release_Static"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Client_Final_Static"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\pl_crypt.c
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\privbase.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\privbase.h
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\refcol.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\refcol.h
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\rev.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\rev.h
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\stdbase.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\stdbase.h
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\store.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\store.h
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\streams.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\streams.h
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\trees.c
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\unzip.c
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\zconf.h
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\zip.h
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\zlib.h
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\zutil.c
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\libs\gkdb\src\zutil.h
# End Source File
# End Group
# Begin Group "gsscreen"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\libs\gsscreen\src\face.c
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\libs\gsscreen\src\gsscreen.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\libs\gsscreen\src\gsscreen.h
# End Source File
# Begin Source File

SOURCE=..\..\libs\gsscreen\src\gsscreen_ver.h
# End Source File
# Begin Source File

SOURCE=..\..\libs\gsscreen\src\iscreen.h
# End Source File
# Begin Source File

SOURCE=..\..\libs\gsscreen\src\pscreen.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\libs\gsscreen\src\pscreen.h
# End Source File
# Begin Source File

SOURCE=..\..\libs\gsscreen\src\screen.c
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\libs\gsscreen\src\toys.h
# End Source File
# End Group
# Begin Group "gc"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\libs\cchlp\src\recode.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\..\libs\cchlp\src\recode.h
# End Source File
# End Group
# Begin Group "protect"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\update\Protection.cpp
# SUBTRACT CPP /YX /Yc /Yu
# End Source File
# Begin Source File

SOURCE=..\update\Protection.h
# End Source File
# End Group
# Begin Group "gctx"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\libs\gctx\src\ctxwords.cpp

!IF  "$(CFG)" == "Downloader - Win32 Release"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Debug"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Release56x"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Downloader - Win32 Pilot Debug"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Pilot Release"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Client_Debug"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Client_Purify"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Client_Release"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Client_Final"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Client_Debug_Static"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Client_Purify_Static"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Client_Release_Static"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Client_Final_Static"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\libs\gctx\src\gctx_func.cpp

!IF  "$(CFG)" == "Downloader - Win32 Release"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Debug"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Release56x"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Downloader - Win32 Pilot Debug"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Pilot Release"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Client_Debug"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Client_Purify"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Client_Release"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Client_Final"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Client_Debug_Static"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Client_Purify_Static"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Client_Release_Static"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Client_Final_Static"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\libs\gctx\src\u_int64_t.CtxLongSet.Map.cpp

!IF  "$(CFG)" == "Downloader - Win32 Release"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Debug"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Release56x"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Downloader - Win32 Pilot Debug"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Pilot Release"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Client_Debug"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Client_Purify"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Client_Release"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Client_Final"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Client_Debug_Static"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Client_Purify_Static"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Client_Release_Static"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Client_Final_Static"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\libs\gctx\src\u_int64_t.CtxLongSet.SplayMap.cpp

!IF  "$(CFG)" == "Downloader - Win32 Release"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Debug"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Release56x"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Downloader - Win32 Pilot Debug"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Pilot Release"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Client_Debug"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Client_Purify"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Client_Release"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Client_Final"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Client_Debug_Static"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Client_Purify_Static"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Client_Release_Static"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Client_Final_Static"

!ENDIF 

# End Source File
# End Group
# Begin Group "cchlp"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\libs\cchlp\src\errhandler.cpp

!IF  "$(CFG)" == "Downloader - Win32 Release"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Debug"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Release56x"

# SUBTRACT CPP /YX /Yc /Yu

!ELSEIF  "$(CFG)" == "Downloader - Win32 Pilot Debug"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Pilot Release"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Client_Debug"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Client_Purify"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Client_Release"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Client_Final"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Client_Debug_Static"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Client_Purify_Static"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Client_Release_Static"

!ELSEIF  "$(CFG)" == "Downloader - Win32 Client_Final_Static"

!ENDIF 

# End Source File
# End Group
# Begin Source File

SOURCE=.\ReadMe.txt
# End Source File
# End Target
# End Project
