# Microsoft Developer Studio Project File - Name="gdm_serv" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Console Application" 0x0103

CFG=gdm_serv - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "gdm_serv.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "gdm_serv.mak" CFG="gdm_serv - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "gdm_serv - Win32 Release" (based on "Win32 (x86) Console Application")
!MESSAGE "gdm_serv - Win32 Debug" (based on "Win32 (x86) Console Application")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
RSC=rc.exe

!IF  "$(CFG)" == "gdm_serv - Win32 Release"

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
# ADD CPP /nologo /MD /W3 /GX /Ox /I "..\..\..\libs\gctx\src" /I "..\..\..\libs\gkdb\src" /I "..\..\..\libs\inifile\src" /I "..\..\..\libs\cchlp\src" /I "..\..\..\include" /I "..\..\..\include\win32" /I "..\..\..\libs\delta\src" /I "..\..\..\libs\gsscreen\src" /I "..\..\..\tools\gdm_serv\src" /D "NDEBUG" /D "_WINDOWS" /D "WIN32" /D "__x86__" /D "__WIN32__" /D "_CONSOLE" /D "_MBCS" /D "CODETYPE_DOS" /D "__NT__" /D __OSVERSION__=4 /D "_USE_CORBA_CONVERTS" /FD /Gs /c
# SUBTRACT CPP /Ot /Og /Oi /Fr
# ADD BASE RSC /l 0x419 /d "NDEBUG"
# ADD RSC /l 0x419 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /machine:I386
# ADD LINK32 wsock32.lib advapi32.lib omniORB302_rt.lib omnithread2_rt.lib omniDynamic302_rt.lib /nologo /subsystem:console /machine:I386 /nodefaultlib:"libcmt.lib" /nodefaultlib:"libcmtd.lib"

!ELSEIF  "$(CFG)" == "gdm_serv - Win32 Debug"

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
# ADD CPP /nologo /MDd /W3 /Gm /GX /ZI /Od /I "..\..\..\tools\gdm_serv\src" /I "..\..\..\libs\gctx\src" /I "..\..\..\libs\gkdb\src" /I "..\..\..\libs\inifile\src" /I "..\..\..\libs\cchlp\src" /I "..\..\..\include" /I "..\..\..\include\win32" /I "..\..\..\libs\delta\src" /I "..\..\..\libs\gsscreen\src" /D "_DEBUG" /D "_WINDOWS" /D "WIN32" /D "__x86__" /D "__WIN32__" /D "_CONSOLE" /D "CODETYPE_DOS" /D "__NT__" /D __OSVERSION__=4 /D "_USE_CORBA_CONVERTS" /FR /FD /D /GZ /c
# ADD BASE RSC /l 0x419 /d "_DEBUG"
# ADD RSC /l 0x419 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:console /debug /machine:I386 /pdbtype:sept
# ADD LINK32 omniORB303_rtd.lib omnithread2_rtd.lib omniDynamic303_rtd.lib wsock32.lib advapi32.lib /nologo /subsystem:console /debug /machine:I386 /nodefaultlib:"libcmt.lib" /nodefaultlib:"libcmtd.lib" /pdbtype:sept
# SUBTRACT LINK32 /nodefaultlib

!ENDIF 

# Begin Target

# Name "gdm_serv - Win32 Release"
# Name "gdm_serv - Win32 Debug"
# Begin Group "Source Files"

# PROP Default_Filter "cpp;c;cxx;rc;def;r;odl;idl;hpj;bat"
# Begin Group "gdm_serv"

# PROP Default_Filter "cpp"
# Begin Source File

SOURCE=..\src\gdm_serv.cpp
# End Source File
# Begin Source File

SOURCE=..\src\merger_i.cpp
# End Source File
# Begin Source File

SOURCE=..\src\OrbServer.cpp
# End Source File
# End Group
# Begin Group "idl"

# PROP Default_Filter ""
# Begin Group "generated"

# PROP Default_Filter "cpp"
# Begin Source File

SOURCE=..\src\killerSK.cpp

!IF  "$(CFG)" == "gdm_serv - Win32 Release"

!ELSEIF  "$(CFG)" == "gdm_serv - Win32 Debug"

# ADD CPP /MTd /ZI /Od

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\src\mergerSK.cpp

!IF  "$(CFG)" == "gdm_serv - Win32 Release"

!ELSEIF  "$(CFG)" == "gdm_serv - Win32 Debug"

# ADD CPP /MTd /ZI /Od

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\src\strings_structDynSK.cpp

!IF  "$(CFG)" == "gdm_serv - Win32 Release"

!ELSEIF  "$(CFG)" == "gdm_serv - Win32 Debug"

# ADD CPP /MTd /ZI /Od

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\src\strings_structSK.cpp

!IF  "$(CFG)" == "gdm_serv - Win32 Release"

!ELSEIF  "$(CFG)" == "gdm_serv - Win32 Debug"

# ADD CPP /MTd /ZI /Od

!ENDIF 

# End Source File
# End Group
# Begin Source File

SOURCE=..\src\killer.idl

!IF  "$(CFG)" == "gdm_serv - Win32 Release"

!ELSEIF  "$(CFG)" == "gdm_serv - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build - IDL compile on $(InputPath)
InputPath=..\src\killer.idl
InputName=killer

"..\\src\\$(InputName)SK.cpp" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	d:\omni\bin\x86_win32\omniidl.exe -C..\\src -I..\\src -bcxx -Wbh=.h -Wbs=SK.cpp ..\\src\\$(InputName).idl

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\src\merger.idl

!IF  "$(CFG)" == "gdm_serv - Win32 Release"

!ELSEIF  "$(CFG)" == "gdm_serv - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build - IDL compile on $(InputPath)
InputPath=..\src\merger.idl
InputName=merger

"..\\src\\$(InputName)SK.cpp" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	d:\omni\bin\x86_win32\omniidl.exe -C..\\src -I..\\src -bcxx -Wbh=.h -Wbs=SK.cpp ..\\src\\$(InputName).idl

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\src\strings_struct.idl

!IF  "$(CFG)" == "gdm_serv - Win32 Release"

!ELSEIF  "$(CFG)" == "gdm_serv - Win32 Debug"

# PROP Ignore_Default_Tool 1
# Begin Custom Build - IDL compile (with Dyn support) on $(InputPath)
InputPath=..\src\strings_struct.idl
InputName=strings_struct

"..\\src\\$(InputName)SK.cpp" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	d:\omni\bin\x86_win32\omniidl.exe -C..\\src -I..\\src -bcxx -Wba -Wbh=.h -Wbs=SK.cpp -Wbd=DynSK.cpp ..\\src\\$(InputName).idl

# End Custom Build

!ENDIF 

# End Source File
# End Group
# Begin Group "delta"

# PROP Default_Filter "cpp"
# Begin Source File

SOURCE=..\..\..\libs\delta\src\dhreader.cpp
# End Source File
# End Group
# Begin Group "gkdb"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\indices.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\osdummy.c
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\gkdb\src\rev.cpp
# End Source File
# End Group
# Begin Group "cchlp"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\Logger.cpp
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\recode.cpp
# End Source File
# End Group
# Begin Source File

SOURCE=..\src\deltamerger.cpp
# End Source File
# End Group
# Begin Group "Header Files"

# PROP Default_Filter "h;hpp;hxx;hm;inl"
# Begin Source File

SOURCE=..\..\..\libs\delta\src\adds.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\advlog.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\AutoMutex.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\CaseString.defs.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\cchlp_ver.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\clTreeNode.defs.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\clTreeNode.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\clTreeNode.Set.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\clTreeNode.SplayNode.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\clTreeNode.SplaySet.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\date.defs.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\date.Set.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\date.SplayNode.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\date.SplaySet.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\delta\src\delt_ver.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\delta\src\deltadef.h
# End Source File
# Begin Source File

SOURCE=..\src\deltamerger.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\delta\src\dhr_ver.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\delta\src\dhreader.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\delta\src\dltcomon.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\delta\src\elems.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\errhandler.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\FString.caddr_t.Map.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\FString.caddr_t.SplayMap.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\FString.defs.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\FString.FString.Map.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\FString.FString.SplayMap.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\fstring.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\FString.long.Map.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\FString.long.SplayMap.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\FString.long.VHMap.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\FString.Set.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\FString.SplayNode.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\FString.SplaySet.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\FString.VHSet.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\delta\src\hendlers.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\hidxhlp.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\hnode.h
# End Source File
# Begin Source File

SOURCE=..\src\killer.h
# End Source File
# Begin Source File

SOURCE=..\src\killer_i.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\ListSet.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\Logger.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\long.caddr_t.Map.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\long.caddr_t.SplayMap.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\long.defs.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\long.long.Map.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\long.long.SplayMap.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\long.long.VHMap.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\long.longSplaySet.Map.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\long.longSplaySet.SplayMap.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\long.Set.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\long.SplayNode.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\long.SplaySet.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\long.VHSet.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\Map.h
# End Source File
# Begin Source File

SOURCE=..\src\merger.h
# End Source File
# Begin Source File

SOURCE=..\src\merger_i.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\delta\src\n_malloc.h
# End Source File
# Begin Source File

SOURCE=..\src\OrbServer.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\Pix.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\recode.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\Regex.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\rx.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\Set.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\SharedData.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\SplayMap.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\SplaySet.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\StorableSplaySet.h
# End Source File
# Begin Source File

SOURCE=..\src\strings_struct.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\stringz.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\delta\src\tempdoc.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\delta\src\timer.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\typecmp.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\u_int32_t.caddr_t.Map.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\u_int32_t.caddr_t.SplayMap.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\u_int32_t.defs.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\u_int32_t.FString.Map.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\u_int32_t.FString.SplayMap.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\u_int32_t.FString.VHMap.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\u_int32_t.Set.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\u_int32_t.SplayNode.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\u_int32_t.SplaySet.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\u_int32_t.VHSet.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\u_int64_t.defs.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\u_int64_t.Set.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\u_int64_t.SplayNode.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\u_int64_t.SplaySet.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\u_int64_t.u_int16_t.Map.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\u_int64_t.u_int16_t.SplayMap.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\cchlp\src\u_int64_t.VHSet.h
# End Source File
# Begin Source File

SOURCE=..\..\..\libs\delta\src\wordcol.h
# End Source File
# End Group
# Begin Group "Resource Files"

# PROP Default_Filter "ico;cur;bmp;dlg;rc2;rct;bin;rgs;gif;jpg;jpeg;jpe"
# End Group
# End Target
# End Project
