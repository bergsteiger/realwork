# Microsoft Developer Studio Project File - Name="TestSrv" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Console Application" 0x0103

CFG=TestSrv - Win32 Client_Debug_Static
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "TestSrv.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "TestSrv.mak" CFG="TestSrv - Win32 Client_Debug_Static"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "TestSrv - Win32 Release" (based on "Win32 (x86) Console Application")
!MESSAGE "TestSrv - Win32 Client_Debug_Static" (based on "Win32 (x86) Console Application")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
RSC=rc.exe

!IF  "$(CFG)" == "TestSrv - Win32 Release"

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
# ADD BASE CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS" /YX /FD /c
# ADD CPP /nologo /W3 /GX /O2 /I "W:\garantPIL\implementation\component\cpp\include\win32" /I "W:\garantPIL\implementation\component\cpp\include" /I "W:\garantPIL\implementation\component\cpp\libs\rtf\src" /I "W:\garantPIL\implementation\component\cpp\libs\reflist\src" /I "W:\garantPIL\implementation\component\cpp\libs\gkdb\src" /I "W:\garantPIL\implementation\component\cpp\libs\cchlp\src" /I "W:\garantPIL\implementation\component\cpp\libs\gsscreen\src" /I "W:\garantPIL\implementation\component\cpp\libs\GPersn\src" /I "W:\garantPIL\implementation\component\cpp\libs\folders\src" /I "W:\garant6x\implementation" /I "W:\common\components\corba" /I "W:\common\components\corba\GCD\cpp" /I "W:\garant6x\implementation\Garant\GblAdapter" /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS" /FR /YX /FD /c
# ADD BASE RSC /l 0x419 /d "NDEBUG"
# ADD RSC /l 0x419 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /machine:I386
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /machine:I386

!ELSEIF  "$(CFG)" == "TestSrv - Win32 Client_Debug_Static"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Client_Debug_Static"
# PROP BASE Intermediate_Dir "Client_Debug_Static"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "W:\build\bin\Client_Debug_Static"
# PROP Intermediate_Dir "W:\build\bin\Client_Debug_Static"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_CONSOLE" /D "_MBCS" /YX /FD /GZ /c
# ADD CPP /nologo /MTd /W3 /GR /GX /Zi /Od /I "W:\garantPIL\implementation\component\cpp\include\win32" /I "W:\garantPIL\implementation\component\cpp\include" /I "W:\garantPIL\implementation\component\cpp\libs\rtf\src" /I "W:\garantPIL\implementation\component\cpp\libs\reflist\src" /I "W:\garantPIL\implementation\component\cpp\libs\gkdb\src" /I "W:\garantPIL\implementation\component\cpp\libs\cchlp\src" /I "W:\garantPIL\implementation\component\cpp\libs\gsscreen\src" /I "W:\garantPIL\implementation\component\cpp\libs\GPersn\src" /I "W:\garantPIL\implementation\component\cpp\libs\folders\src" /I "W:\garant6x\implementation" /I "W:\common\components\corba" /I "W:\common\components\corba\GCD\cpp" /I "W:\garant6x\implementation\Garant\GblAdapter" /D "_DEBUG" /D "ACE_AS_STATIC_LIBS" /D "TAO_AS_STATIC_LIBS" /D "_GCD_CLIENT" /D "_GCD_STATIC" /D "WIN32" /D "VERSION56" /D "NO_GSSCREEN" /D "USE_CPP_ZIP" /D "USE_ACE" /D "MULTI_INDEX_STREAM_FILE" /D "INSTLL_CIB" /D "BLOCKSINHERIT" /D "STORE_FORM_N" /FD /GZ /c
# SUBTRACT CPP /Fr /YX
# ADD BASE RSC /l 0x419 /d "_DEBUG"
# ADD RSC /l 0x419 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /debug /machine:I386 /pdbtype:sept
# ADD LINK32 advapi32.lib user32.lib xerces-c_2.lib acesd.lib TAOsd.lib TAO_CosEventsd.lib TAO_CosNamingsd.lib TAO_CosNotificationsd.lib TAO_CosTimesd.lib TAO_DsLogAdminsd.lib TAO_DynamicAnysd.lib TAO_ETCLsd.lib TAO_IORTablesd.lib TAO_Messagingsd.lib TAO_PortableServersd.lib TAO_Svc_Utilssd.lib /nologo /subsystem:console /debug /machine:I386 /nodefaultlib:"nafxcwd.lib libcmtd.lib" /force /out:"W:\build\bin\Client_Debug_Static/EtalonTest.exe" /pdbtype:sept

!ENDIF 

# Begin Target

# Name "TestSrv - Win32 Release"
# Name "TestSrv - Win32 Client_Debug_Static"
# Begin Group "Source Files"

# PROP Default_Filter "cpp;c;cxx;rc;def;r;odl;idl;hpj;bat"
# Begin Source File

SOURCE=.\autotest.cpp
# End Source File
# Begin Source File

SOURCE=.\FragmentList_i.cpp
# End Source File
# Begin Source File

SOURCE=.\progress_i.cpp
# End Source File
# Begin Source File

SOURCE=.\TestSrv.cpp
# End Source File
# End Group
# Begin Group "Header Files"

# PROP Default_Filter "h;hpp;hxx;hm;inl"
# Begin Source File

SOURCE=.\autotest.h
# End Source File
# Begin Source File

SOURCE=.\FragmentList_i.h
# End Source File
# Begin Source File

SOURCE=.\progress_i.h
# End Source File
# Begin Source File

SOURCE=.\TestSrv.h
# End Source File
# End Group
# Begin Group "Resource Files"

# PROP Default_Filter "ico;cur;bmp;dlg;rc2;rct;bin;rgs;gif;jpg;jpeg;jpe"
# End Group
# End Target
# End Project
