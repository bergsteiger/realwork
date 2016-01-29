# Microsoft Developer Studio Project File - Name="Breeder32" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Static Library" 0x0104

CFG=Breeder32 - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "Breeder32.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "Breeder32.mak" CFG="Breeder32 - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "Breeder32 - Win32 Release" (based on "Win32 (x86) Static Library")
!MESSAGE "Breeder32 - Win32 Debug" (based on "Win32 (x86) Static Library")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=xicl6.exe
RSC=rc.exe

!IF  "$(CFG)" == "Breeder32 - Win32 Release"

# PROP BASE Use_MFC 2
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release"
# PROP BASE Intermediate_Dir "Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 2
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "ReleaseLib"
# PROP Intermediate_Dir "ReleaseLib"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_AFXDLL" /YX /FD /c
# ADD CPP /nologo /Zp1 /MD /W3 /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/GPersn/src" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR /YX /FD /c
# ADD BASE RSC /l 0x3009 /d "NDEBUG" /d "_AFXDLL"
# ADD RSC /l 0x3009 /d "NDEBUG" /d "_AFXDLL"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LIB32=xilink6.exe -lib
# ADD BASE LIB32 /nologo
# ADD LIB32 /nologo

!ELSEIF  "$(CFG)" == "Breeder32 - Win32 Debug"

# PROP BASE Use_MFC 2
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug"
# PROP BASE Intermediate_Dir "Debug"
# PROP BASE Target_Dir ""
# PROP Use_MFC 2
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "DebugLib"
# PROP Intermediate_Dir "DebugLib"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_AFXDLL" /YX /FD /GZ /c
# ADD CPP /nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/GPersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /FR /YX /FD /GZ /c
# ADD BASE RSC /l 0x3009 /d "_DEBUG" /d "_AFXDLL"
# ADD RSC /l 0x3009 /d "_DEBUG" /d "_AFXDLL"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LIB32=xilink6.exe -lib
# ADD BASE LIB32 /nologo
# ADD LIB32 /nologo

!ENDIF 

# Begin Target

# Name "Breeder32 - Win32 Release"
# Name "Breeder32 - Win32 Debug"
# Begin Group "Source Files"

# PROP Default_Filter "cpp;c;cxx;rc;def;r;odl;idl;hpj;bat"
# Begin Source File

SOURCE=..\..\..\tools\gsplit\src\attr_index.c
# End Source File
# Begin Source File

SOURCE=..\..\..\tools\gsplit\src\aux_index.c
# End Source File
# Begin Source File

SOURCE=..\..\..\tools\gsplit\src\blob_index.c
# End Source File
# Begin Source File

SOURCE=..\..\..\tools\gsplit\src\cmdline.c
# End Source File
# Begin Source File

SOURCE=..\..\..\tools\gsplit\src\cr_index.c
# End Source File
# Begin Source File

SOURCE=..\..\..\tools\gsplit\src\doc_index.c
# End Source File
# Begin Source File

SOURCE=..\..\..\tools\gsplit\src\doclist.c
# End Source File
# Begin Source File

SOURCE=..\..\..\tools\gctools\src\glproc.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\tools\gsplit\src\hc_index.c
# End Source File
# Begin Source File

SOURCE=..\..\..\tools\gsplit\src\hier_index.c
# End Source File
# Begin Source File

SOURCE=..\..\..\tools\gsplit\src\hind_collect.c
# End Source File
# Begin Source File

SOURCE=..\..\..\tools\gsplit\src\indhlp.c
# End Source File
# Begin Source File

SOURCE=..\..\..\tools\gsplit\src\msg_tbl.c
# End Source File
# Begin Source File

SOURCE=..\..\..\tools\gsplit\src\segfile.c
# End Source File
# Begin Source File

SOURCE=..\..\..\tools\gsplit\src\split_index.c
# End Source File
# Begin Source File

SOURCE=..\..\..\tools\gsplit\src\subname.c
# End Source File
# Begin Source File

SOURCE=..\..\..\tools\gsplit\src\usage.c
# End Source File
# End Group
# Begin Group "Header Files"

# PROP Default_Filter "h;hpp;hxx;hm;inl"
# End Group
# Begin Group "GKDB"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\gkdb\src\adler32.c
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\base.cpp
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\basemask.cpp
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\btiter.cpp
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\btree.cpp
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\collect.cpp
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\crc32.c
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\deflate.c
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\doccol.cpp
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\dociter.cpp
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\document.cpp
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\dummies.cpp
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\fltiter.cpp
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\garutils.cpp
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\hindex.cpp
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\index.cpp
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\indices.cpp
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\infblock.c
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\infcodes.c
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\inffast.c
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\inflate.c
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\inftrees.c
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\infutil.c
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\ncpf.cpp
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\newdoc.cpp
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\osdummy.c
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\pack.c
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\pagefile.cpp
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\pl_crypt.c
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\privbase.cpp
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\refcol.cpp
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\rev.cpp
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\stdbase.cpp
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\store.cpp
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\streams.cpp
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\trees.c
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\unzip.c
# End Source File
# Begin Source File

SOURCE=..\..\gkdb\src\zutil.c
# End Source File
# End Group
# Begin Group "MRG_Lib"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\mrglib\src\bfind.c
# End Source File
# Begin Source File

SOURCE=..\..\mrglib\src\cmpfunc.c
# End Source File
# Begin Source File

SOURCE=..\..\mrglib\src\flog.c
# End Source File
# Begin Source File

SOURCE=..\..\mrglib\src\gbase.c
# End Source File
# Begin Source File

SOURCE=..\..\mrglib\src\gberr.c
# End Source File
# Begin Source File

SOURCE=..\..\mrglib\src\globals.c
# End Source File
# Begin Source File

SOURCE=..\..\mrglib\src\iter.c
# End Source File
# Begin Source File

SOURCE=..\..\mrglib\src\keyfile.c
# End Source File
# Begin Source File

SOURCE=..\..\mrglib\src\pgfile.c
# End Source File
# Begin Source File

SOURCE=..\..\mrglib\src\profile.c
# End Source File
# Begin Source File

SOURCE=..\..\mrglib\src\sets.c
# End Source File
# Begin Source File

SOURCE=..\..\mrglib\src\ssets.c
# End Source File
# Begin Source File

SOURCE=..\..\mrglib\src\strcache.c
# End Source File
# Begin Source File

SOURCE=..\..\mrglib\src\unifname.c
# End Source File
# End Group
# Begin Group "GSSCREEN_Lib"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\gsscreen\src\face.c
# End Source File
# Begin Source File

SOURCE=..\..\gsscreen\src\gsscreen.cpp
# End Source File
# Begin Source File

SOURCE=..\..\gsscreen\src\pscreen.cpp
# End Source File
# Begin Source File

SOURCE=..\..\gsscreen\src\screen.c
# End Source File
# End Group
# Begin Group "CCHLP_Lib"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\cchlp\src\advlog.cpp
# End Source File
# Begin Source File

SOURCE=..\..\cchlp\src\clTreeNode.Set.cpp
# End Source File
# Begin Source File

SOURCE=..\..\cchlp\src\clTreeNode.SplayNode.cpp
# End Source File
# Begin Source File

SOURCE=..\..\cchlp\src\clTreeNode.SplaySet.cpp
# End Source File
# Begin Source File

SOURCE=..\..\cchlp\src\date.Set.cpp
# End Source File
# Begin Source File

SOURCE=..\..\cchlp\src\date.SplayNode.cpp
# End Source File
# Begin Source File

SOURCE=..\..\cchlp\src\date.SplaySet.cpp
# End Source File
# Begin Source File

SOURCE=..\..\cchlp\src\errhandler.cpp
# End Source File
# Begin Source File

SOURCE=..\..\cchlp\src\FString.caddr_t.Map.cpp
# End Source File
# Begin Source File

SOURCE=..\..\cchlp\src\FString.caddr_t.SplayMap.cpp
# End Source File
# Begin Source File

SOURCE=..\..\cchlp\src\fstring.cpp
# End Source File
# Begin Source File

SOURCE=..\..\cchlp\src\FString.FString.Map.cpp
# End Source File
# Begin Source File

SOURCE=..\..\cchlp\src\FString.FString.SplayMap.cpp
# End Source File
# Begin Source File

SOURCE=..\..\cchlp\src\FString.long.Map.cpp
# End Source File
# Begin Source File

SOURCE=..\..\cchlp\src\FString.long.SplayMap.cpp
# End Source File
# Begin Source File

SOURCE=..\..\cchlp\src\FString.long.VHMap.cpp
# End Source File
# Begin Source File

SOURCE=..\..\cchlp\src\FString.Set.cpp
# End Source File
# Begin Source File

SOURCE=..\..\cchlp\src\FString.SplayNode.cpp
# End Source File
# Begin Source File

SOURCE=..\..\cchlp\src\FString.SplaySet.cpp
# End Source File
# Begin Source File

SOURCE=..\..\cchlp\src\FString.VHSet.cpp
# End Source File
# Begin Source File

SOURCE=..\..\cchlp\src\hidxhlp.cpp
# End Source File
# Begin Source File

SOURCE=..\..\cchlp\src\hnode.cpp
# End Source File
# Begin Source File

SOURCE=..\..\cchlp\src\Logger.cpp
# End Source File
# Begin Source File

SOURCE=..\..\cchlp\src\long.caddr_t.Map.cpp
# End Source File
# Begin Source File

SOURCE=..\..\cchlp\src\long.caddr_t.SplayMap.cpp
# End Source File
# Begin Source File

SOURCE=..\..\cchlp\src\long.long.Map.cpp
# End Source File
# Begin Source File

SOURCE=..\..\cchlp\src\long.long.SplayMap.cpp
# End Source File
# Begin Source File

SOURCE=..\..\cchlp\src\long.long.VHMap.cpp
# End Source File
# Begin Source File

SOURCE=..\..\cchlp\src\long.longSplaySet.Map.cpp
# End Source File
# Begin Source File

SOURCE=..\..\cchlp\src\long.longSplaySet.SplayMap.cpp
# End Source File
# Begin Source File

SOURCE=..\..\cchlp\src\long.Set.cpp
# End Source File
# Begin Source File

SOURCE=..\..\cchlp\src\long.SplayNode.cpp
# End Source File
# Begin Source File

SOURCE=..\..\cchlp\src\long.SplaySet.cpp
# End Source File
# Begin Source File

SOURCE=..\..\cchlp\src\long.VHSet.cpp
# End Source File
# Begin Source File

SOURCE=..\..\cchlp\src\recode.cpp
# End Source File
# Begin Source File

SOURCE=..\..\cchlp\src\Regex.cpp
# End Source File
# Begin Source File

SOURCE=..\..\cchlp\src\rx.c
# End Source File
# Begin Source File

SOURCE=..\..\cchlp\src\stringz.cpp
# End Source File
# Begin Source File

SOURCE=..\..\cchlp\src\u_int32_t.caddr_t.Map.cpp
# End Source File
# Begin Source File

SOURCE=..\..\cchlp\src\u_int32_t.caddr_t.SplayMap.cpp
# End Source File
# Begin Source File

SOURCE=..\..\cchlp\src\u_int32_t.FString.Map.cpp
# End Source File
# Begin Source File

SOURCE=..\..\cchlp\src\u_int32_t.FString.SplayMap.cpp
# End Source File
# Begin Source File

SOURCE=..\..\cchlp\src\u_int32_t.FString.VHMap.cpp
# End Source File
# Begin Source File

SOURCE=..\..\cchlp\src\u_int32_t.Set.cpp
# End Source File
# Begin Source File

SOURCE=..\..\cchlp\src\u_int32_t.SplayNode.cpp
# End Source File
# Begin Source File

SOURCE=..\..\cchlp\src\u_int32_t.SplaySet.cpp
# End Source File
# Begin Source File

SOURCE=..\..\cchlp\src\u_int32_t.VHSet.cpp
# End Source File
# Begin Source File

SOURCE=..\..\cchlp\src\u_int64_t.Set.cpp
# End Source File
# Begin Source File

SOURCE=..\..\cchlp\src\u_int64_t.SplayNode.cpp
# End Source File
# Begin Source File

SOURCE=..\..\cchlp\src\u_int64_t.SplaySet.cpp
# End Source File
# Begin Source File

SOURCE=..\..\cchlp\src\u_int64_t.u_int16_t.Map.cpp
# End Source File
# Begin Source File

SOURCE=..\..\cchlp\src\u_int64_t.u_int16_t.SplayMap.cpp
# End Source File
# Begin Source File

SOURCE=..\..\cchlp\src\u_int64_t.VHSet.cpp
# End Source File
# End Group
# End Target
# End Project
