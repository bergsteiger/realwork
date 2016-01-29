# Microsoft Developer Studio Project File - Name="mrglib" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Static Library" 0x0104

CFG=mrglib - Win32 Debug AFXDLL
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "mrglib.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "mrglib.mak" CFG="mrglib - Win32 Debug AFXDLL"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "mrglib - Win32 Release" (based on "Win32 (x86) Static Library")
!MESSAGE "mrglib - Win32 Debug" (based on "Win32 (x86) Static Library")
!MESSAGE "mrglib - Win32 Debug AFXDLL" (based on "Win32 (x86) Static Library")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
RSC=rc.exe

!IF  "$(CFG)" == "mrglib - Win32 Release"

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
# ADD CPP /nologo /G4 /Zp1 /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /D "WIN32" /D "NDEBUG" /D "_MBCS" /D "_LIB" /YX /FD /c
# ADD BASE RSC /l 0x419 /d "NDEBUG"
# ADD RSC /l 0x419 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LIB32=link.exe -lib
# ADD BASE LIB32 /nologo
# ADD LIB32 /nologo /out:".\mrglib.lib"

!ELSEIF  "$(CFG)" == "mrglib - Win32 Debug"

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
# ADD CPP /nologo /G6 /Zp1 /ML /W3 /Gm /Gi /GX /ZI /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /D "WIN32" /D "_DEBUG" /D "_MBCS" /D "_LIB" /FR /YX /FD /GZ /c
# ADD BASE RSC /l 0x419 /d "_DEBUG"
# ADD RSC /l 0x419 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LIB32=link.exe -lib
# ADD BASE LIB32 /nologo
# ADD LIB32 /nologo /out:".\mrglib.lib"

!ELSEIF  "$(CFG)" == "mrglib - Win32 Debug AFXDLL"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "mrglib___Win32_Debug_AFXDLL"
# PROP BASE Intermediate_Dir "mrglib___Win32_Debug_AFXDLL"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "mrglib___Win32_Debug_AFXDLL"
# PROP Intermediate_Dir "mrglib___Win32_Debug_AFXDLL"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /G6 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /D "WIN32" /D "_DEBUG" /D "_MBCS" /D "_LIB" /FR /YX /FD /GZ /c
# ADD CPP /nologo /G6 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /D "WIN32" /D "_DEBUG" /D "_MBCS" /D "_LIB" /D "_AFXDLL" /FR /YX /FD /GZ /c
# ADD BASE RSC /l 0x419 /d "_DEBUG"
# ADD RSC /l 0x419 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LIB32=link.exe -lib
# ADD BASE LIB32 /nologo /out:".\mrglib.lib"
# ADD LIB32 /nologo /out:".\mrglib.lib"

!ENDIF 

# Begin Target

# Name "mrglib - Win32 Release"
# Name "mrglib - Win32 Debug"
# Name "mrglib - Win32 Debug AFXDLL"
# Begin Group "Source Files"

# PROP Default_Filter "cpp;c;cxx;rc;def;r;odl;idl;hpj;bat"
# Begin Source File

SOURCE=..\src\bfind.c
# End Source File
# Begin Source File

SOURCE=..\src\btree.c
# End Source File
# Begin Source File

SOURCE=..\src\cmpfunc.c
# End Source File
# Begin Source File

SOURCE=..\src\dummies.c
# End Source File
# Begin Source File

SOURCE=..\src\flog.c
# End Source File
# Begin Source File

SOURCE=..\src\gbase.c
# End Source File
# Begin Source File

SOURCE=..\src\gberr.c
# End Source File
# Begin Source File

SOURCE=..\src\globals.c
# End Source File
# Begin Source File

SOURCE=..\src\index.c
# End Source File
# Begin Source File

SOURCE=..\src\iter.c
# End Source File
# Begin Source File

SOURCE=..\src\keyfile.c
# End Source File
# Begin Source File

SOURCE=..\src\pgfile.c
# End Source File
# Begin Source File

SOURCE=..\src\profile.c
# End Source File
# Begin Source File

SOURCE=..\src\sets.c
# End Source File
# Begin Source File

SOURCE=..\src\ssets.c
# End Source File
# Begin Source File

SOURCE=..\src\strcache.c
# End Source File
# Begin Source File

SOURCE=..\src\streams.c
# End Source File
# Begin Source File

SOURCE=..\src\unifname.c
# End Source File
# End Group
# Begin Group "Header Files"

# PROP Default_Filter "h;hpp;hxx;hm;inl"
# End Group
# End Target
# End Project
