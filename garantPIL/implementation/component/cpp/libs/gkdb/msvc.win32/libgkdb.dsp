# Microsoft Developer Studio Project File - Name="libgkdb" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Static Library" 0x0104

CFG=libgkdb - Win32 Debug56x
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "libgkdb.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "libgkdb.mak" CFG="libgkdb - Win32 Debug56x"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "libgkdb - Win32 Release" (based on "Win32 (x86) Static Library")
!MESSAGE "libgkdb - Win32 Debug" (based on "Win32 (x86) Static Library")
!MESSAGE "libgkdb - Win32 Release56x" (based on "Win32 (x86) Static Library")
!MESSAGE "libgkdb - Win32 Debug56x" (based on "Win32 (x86) Static Library")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName "libgkdb"
# PROP Scc_LocalPath ".."
CPP=cl.exe
RSC=rc.exe

!IF  "$(CFG)" == "libgkdb - Win32 Release"

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
# ADD CPP /nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /D "WIN32" /D "NDEBUG" /D "_MBCS" /D "_LIB" /D "_WINDOWS" /D "OPT_PACK" /YX /FD /c
# ADD BASE RSC /l 0x419 /d "NDEBUG"
# ADD RSC /l 0x419 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LIB32=link.exe -lib
# ADD BASE LIB32 /nologo
# ADD LIB32 /nologo /out:".\libgkdb.lib"

!ELSEIF  "$(CFG)" == "libgkdb - Win32 Debug"

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
# ADD CPP /nologo /G4 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /D "WIN32" /D "_DEBUG" /D "_MBCS" /D "_LIB" /D "_WINDOWS" /FR /YX /FD /GZ /c
# ADD BASE RSC /l 0x419 /d "_DEBUG"
# ADD RSC /l 0x419 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LIB32=link.exe -lib
# ADD BASE LIB32 /nologo
# ADD LIB32 /nologo /out:".\libgkdb.lib"

!ELSEIF  "$(CFG)" == "libgkdb - Win32 Release56x"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "libgkdb___Win32_Release56x"
# PROP BASE Intermediate_Dir "libgkdb___Win32_Release56x"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release56x"
# PROP Intermediate_Dir "Release56x"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /D "WIN32" /D "NDEBUG" /D "_MBCS" /D "_LIB" /D "_WINDOWS" /D "MULTI_INDEX_STREAM_FILE" /D "INSTLL_CIB" /D "OPT_PACK" /YX /FD /c
# ADD CPP /nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /D "WIN32" /D "NDEBUG" /D "_MBCS" /D "_LIB" /D "_WINDOWS" /D "MULTI_INDEX_STREAM_FILE" /D "INSTLL_CIB" /D "OPT_PACK" /YX /FD /c
# ADD BASE RSC /l 0x419 /d "NDEBUG"
# ADD RSC /l 0x419 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LIB32=link.exe -lib
# ADD BASE LIB32 /nologo /out:".\libgkdb.lib"
# ADD LIB32 /nologo /out:".\libgkdb.lib"

!ELSEIF  "$(CFG)" == "libgkdb - Win32 Debug56x"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "libgkdb___Win32_Debug56x"
# PROP BASE Intermediate_Dir "libgkdb___Win32_Debug56x"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "Debug56x"
# PROP Intermediate_Dir "Debug56x"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /G4 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /D "WIN32" /D "_DEBUG" /D "_MBCS" /D "_LIB" /D "_WINDOWS" /FR /YX /FD /GZ /c
# ADD CPP /nologo /G4 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /D "WIN32" /D "_DEBUG" /D "_MBCS" /D "_LIB" /D "_WINDOWS" /D "MULTI_INDEX_STREAM_FILE" /D "INSTLL_CIB" /D "OPT_PACK" /FR /YX /FD /GZ /c
# ADD BASE RSC /l 0x419 /d "_DEBUG"
# ADD RSC /l 0x419 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LIB32=link.exe -lib
# ADD BASE LIB32 /nologo /out:".\libgkdb.lib"
# ADD LIB32 /nologo /out:".\libgkdb.lib"

!ENDIF 

# Begin Target

# Name "libgkdb - Win32 Release"
# Name "libgkdb - Win32 Debug"
# Name "libgkdb - Win32 Release56x"
# Name "libgkdb - Win32 Debug56x"
# Begin Group "Source Files"

# PROP Default_Filter "cpp;c;cxx;rc;def;r;odl;idl;hpj;bat"
# Begin Source File

SOURCE=..\src\adler32.c
# End Source File
# Begin Source File

SOURCE=..\src\base.cpp
# End Source File
# Begin Source File

SOURCE=..\src\basemask.cpp
# End Source File
# Begin Source File

SOURCE=..\src\btiter.cpp
# End Source File
# Begin Source File

SOURCE=..\src\btree.cpp
# End Source File
# Begin Source File

SOURCE=..\src\collect.cpp
# End Source File
# Begin Source File

SOURCE=..\src\crc32.c
# End Source File
# Begin Source File

SOURCE=..\src\deflate.c
# End Source File
# Begin Source File

SOURCE=..\src\docblock.cpp
# End Source File
# Begin Source File

SOURCE=..\src\doccol.cpp
# End Source File
# Begin Source File

SOURCE=..\src\dociter.cpp
# End Source File
# Begin Source File

SOURCE=..\src\document.cpp
# End Source File
# Begin Source File

SOURCE=..\src\dummies.cpp
# End Source File
# Begin Source File

SOURCE=..\src\fltiter.cpp
# End Source File
# Begin Source File

SOURCE=..\src\garutils.cpp
# End Source File
# Begin Source File

SOURCE=..\src\hindex.cpp
# End Source File
# Begin Source File

SOURCE=..\src\index.cpp
# End Source File
# Begin Source File

SOURCE=..\src\indices.cpp
# End Source File
# Begin Source File

SOURCE=..\src\infblock.c
# End Source File
# Begin Source File

SOURCE=..\src\infcodes.c
# End Source File
# Begin Source File

SOURCE=..\src\inffast.c
# End Source File
# Begin Source File

SOURCE=..\src\inflate.c
# End Source File
# Begin Source File

SOURCE=..\src\inftrees.c
# End Source File
# Begin Source File

SOURCE=..\src\infutil.c
# End Source File
# Begin Source File

SOURCE=..\src\maps.cpp
# End Source File
# Begin Source File

SOURCE=..\src\ncpf.cpp
# End Source File
# Begin Source File

SOURCE=..\src\newdoc.cpp
# End Source File
# Begin Source File

SOURCE=..\src\osdummy.c
# End Source File
# Begin Source File

SOURCE=..\src\pack.c
# End Source File
# Begin Source File

SOURCE=..\src\pagefile.cpp
# End Source File
# Begin Source File

SOURCE=..\src\pl_crypt.c
# End Source File
# Begin Source File

SOURCE=..\src\privbase.cpp
# End Source File
# Begin Source File

SOURCE=..\src\refcol.cpp
# End Source File
# Begin Source File

SOURCE=..\src\rev.cpp
# End Source File
# Begin Source File

SOURCE=..\src\stdbase.cpp
# End Source File
# Begin Source File

SOURCE=..\src\store.cpp
# End Source File
# Begin Source File

SOURCE=..\src\streams.cpp
# End Source File
# Begin Source File

SOURCE=..\src\trees.c
# End Source File
# Begin Source File

SOURCE=..\src\unzip.c
# End Source File
# Begin Source File

SOURCE=..\src\zutil.c
# End Source File
# End Group
# Begin Group "Header Files"

# PROP Default_Filter "h;hpp;hxx;hm;inl"
# Begin Source File

SOURCE=..\src\base.h
# End Source File
# Begin Source File

SOURCE=..\src\basemask.h
# End Source File
# Begin Source File

SOURCE=..\src\basemsgs.h
# End Source File
# Begin Source File

SOURCE=..\src\bmsk_ver.h
# End Source File
# Begin Source File

SOURCE=..\src\btiter.h
# End Source File
# Begin Source File

SOURCE=..\src\btree.h
# End Source File
# Begin Source File

SOURCE=..\src\check.h
# End Source File
# Begin Source File

SOURCE=..\src\clsindex.h
# End Source File
# Begin Source File

SOURCE=..\src\collect.h
# End Source File
# Begin Source File

SOURCE=..\src\deflate.h
# End Source File
# Begin Source File

SOURCE=..\src\doccol.h
# End Source File
# Begin Source File

SOURCE=..\src\dociter.h
# End Source File
# Begin Source File

SOURCE=..\src\document.h
# End Source File
# Begin Source File

SOURCE=..\src\fltiter.h
# End Source File
# Begin Source File

SOURCE=..\src\gardefs.h
# End Source File
# Begin Source File

SOURCE=..\src\garutils.h
# End Source File
# Begin Source File

SOURCE=..\src\gkdb_ver.h
# End Source File
# Begin Source File

SOURCE=..\src\hindex.h
# End Source File
# Begin Source File

SOURCE=..\src\index.h
# End Source File
# Begin Source File

SOURCE=..\src\indices.h
# End Source File
# Begin Source File

SOURCE=..\src\infblock.h
# End Source File
# Begin Source File

SOURCE=..\src\infcodes.h
# End Source File
# Begin Source File

SOURCE=..\src\inffast.h
# End Source File
# Begin Source File

SOURCE=..\src\inftrees.h
# End Source File
# Begin Source File

SOURCE=..\src\infutil.h
# End Source File
# Begin Source File

SOURCE=..\src\maps.h
# End Source File
# Begin Source File

SOURCE=..\src\ncpf.h
# End Source File
# Begin Source File

SOURCE=..\src\newdoc.h
# End Source File
# Begin Source File

SOURCE=..\src\pack.h
# End Source File
# Begin Source File

SOURCE=..\src\pagefile.h
# End Source File
# Begin Source File

SOURCE=..\src\privbase.h
# End Source File
# Begin Source File

SOURCE=..\src\refcol.h
# End Source File
# Begin Source File

SOURCE=..\src\rev.h
# End Source File
# Begin Source File

SOURCE=..\src\stdbase.h
# End Source File
# Begin Source File

SOURCE=..\src\store.h
# End Source File
# Begin Source File

SOURCE=..\src\streams.h
# End Source File
# Begin Source File

SOURCE=..\src\zconf.h
# End Source File
# Begin Source File

SOURCE=..\src\zip.h
# End Source File
# Begin Source File

SOURCE=..\src\zlib.h
# End Source File
# Begin Source File

SOURCE=..\src\zutil.h
# End Source File
# End Group
# End Target
# End Project
