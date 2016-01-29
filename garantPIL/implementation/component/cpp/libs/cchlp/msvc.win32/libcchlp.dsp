# Microsoft Developer Studio Project File - Name="libcchlp" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Static Library" 0x0104

CFG=libcchlp - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "libcchlp.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "libcchlp.mak" CFG="libcchlp - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "libcchlp - Win32 Release" (based on "Win32 (x86) Static Library")
!MESSAGE "libcchlp - Win32 Debug" (based on "Win32 (x86) Static Library")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
RSC=rc.exe

!IF  "$(CFG)" == "libcchlp - Win32 Release"

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
# ADD LIB32 /nologo /out:".\libcchlp.lib"

!ELSEIF  "$(CFG)" == "libcchlp - Win32 Debug"

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
# ADD CPP /nologo /G4 /Zp1 /ML /W3 /Gm /Gi /GX /ZI /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /D "WIN32" /D "_DEBUG" /D "_MBCS" /D "_LIB" /FR /YX /FD /GZ /c
# ADD BASE RSC /l 0x419 /d "_DEBUG"
# ADD RSC /l 0x419 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LIB32=link.exe -lib
# ADD BASE LIB32 /nologo
# ADD LIB32 /nologo /out:".\libcchlp.lib"

!ENDIF 

# Begin Target

# Name "libcchlp - Win32 Release"
# Name "libcchlp - Win32 Debug"
# Begin Group "Source Files"

# PROP Default_Filter "cpp;c;cxx;rc;def;r;odl;idl;hpj;bat"
# Begin Source File

SOURCE=..\src\advlog.cpp
# End Source File
# Begin Source File

SOURCE=..\src\clTreeNode.Set.cpp
# End Source File
# Begin Source File

SOURCE=..\src\clTreeNode.SplayNode.cpp
# End Source File
# Begin Source File

SOURCE=..\src\clTreeNode.SplaySet.cpp
# End Source File
# Begin Source File

SOURCE=..\src\date.Set.cpp
# End Source File
# Begin Source File

SOURCE=..\src\date.SplayNode.cpp
# End Source File
# Begin Source File

SOURCE=..\src\date.SplaySet.cpp
# End Source File
# Begin Source File

SOURCE=..\src\errhandler.cpp
# End Source File
# Begin Source File

SOURCE=..\src\FString.caddr_t.Map.cpp
# End Source File
# Begin Source File

SOURCE=..\src\FString.caddr_t.SplayMap.cpp
# End Source File
# Begin Source File

SOURCE=..\src\fstring.cpp
# End Source File
# Begin Source File

SOURCE=..\src\FString.FString.Map.cpp
# End Source File
# Begin Source File

SOURCE=..\src\FString.FString.SplayMap.cpp
# End Source File
# Begin Source File

SOURCE=..\src\FString.long.Map.cpp
# End Source File
# Begin Source File

SOURCE=..\src\FString.long.SplayMap.cpp
# End Source File
# Begin Source File

SOURCE=..\src\FString.long.VHMap.cpp
# End Source File
# Begin Source File

SOURCE=..\src\FString.Set.cpp
# End Source File
# Begin Source File

SOURCE=..\src\FString.SplayNode.cpp
# End Source File
# Begin Source File

SOURCE=..\src\FString.SplaySet.cpp
# End Source File
# Begin Source File

SOURCE=..\src\FString.VHSet.cpp
# End Source File
# Begin Source File

SOURCE=..\src\hidxhlp.cpp
# End Source File
# Begin Source File

SOURCE=..\src\hnode.cpp
# End Source File
# Begin Source File

SOURCE=..\src\Logger.cpp
# End Source File
# Begin Source File

SOURCE=..\src\long.caddr_t.Map.cpp
# End Source File
# Begin Source File

SOURCE=..\src\long.caddr_t.SplayMap.cpp
# End Source File
# Begin Source File

SOURCE=..\src\long.long.Map.cpp
# End Source File
# Begin Source File

SOURCE=..\src\long.long.SplayMap.cpp
# End Source File
# Begin Source File

SOURCE=..\src\long.long.VHMap.cpp
# End Source File
# Begin Source File

SOURCE=..\src\long.longSplaySet.Map.cpp
# End Source File
# Begin Source File

SOURCE=..\src\long.longSplaySet.SplayMap.cpp
# End Source File
# Begin Source File

SOURCE=..\src\long.Set.cpp
# End Source File
# Begin Source File

SOURCE=..\src\long.SplayNode.cpp
# End Source File
# Begin Source File

SOURCE=..\src\long.SplaySet.cpp
# End Source File
# Begin Source File

SOURCE=..\src\long.VHSet.cpp
# End Source File
# Begin Source File

SOURCE=..\src\recode.cpp
# End Source File
# Begin Source File

SOURCE=..\src\Regex.cpp
# End Source File
# Begin Source File

SOURCE=..\src\rx.c
# End Source File
# Begin Source File

SOURCE=..\src\stringz.cpp
# End Source File
# Begin Source File

SOURCE=..\src\u_int32_t.caddr_t.Map.cpp
# End Source File
# Begin Source File

SOURCE=..\src\u_int32_t.caddr_t.SplayMap.cpp
# End Source File
# Begin Source File

SOURCE=..\src\u_int32_t.FString.Map.cpp
# End Source File
# Begin Source File

SOURCE=..\src\u_int32_t.FString.SplayMap.cpp
# End Source File
# Begin Source File

SOURCE=..\src\u_int32_t.FString.VHMap.cpp
# End Source File
# Begin Source File

SOURCE=..\src\u_int32_t.Set.cpp
# End Source File
# Begin Source File

SOURCE=..\src\u_int32_t.SplayNode.cpp
# End Source File
# Begin Source File

SOURCE=..\src\u_int32_t.SplaySet.cpp
# End Source File
# Begin Source File

SOURCE=..\src\u_int32_t.VHSet.cpp
# End Source File
# Begin Source File

SOURCE=..\src\u_int64_t.Set.cpp
# End Source File
# Begin Source File

SOURCE=..\src\u_int64_t.SplayNode.cpp
# End Source File
# Begin Source File

SOURCE=..\src\u_int64_t.SplaySet.cpp
# End Source File
# Begin Source File

SOURCE=..\src\u_int64_t.u_int16_t.Map.cpp
# End Source File
# Begin Source File

SOURCE=..\src\u_int64_t.u_int16_t.SplayMap.cpp
# End Source File
# Begin Source File

SOURCE=..\src\u_int64_t.VHSet.cpp
# End Source File
# End Group
# Begin Group "Header Files"

# PROP Default_Filter "h;hpp;hxx;hm;inl"
# End Group
# End Target
# End Project
