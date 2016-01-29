# Microsoft Developer Studio Generated NMAKE File, Based on TestBreeder32.dsp
!IF "$(CFG)" == ""
CFG=TestBreeder32 - Win32 Debug
!MESSAGE No configuration specified. Defaulting to TestBreeder32 - Win32 Debug.
!ENDIF 

!IF "$(CFG)" != "TestBreeder32 - Win32 Release" && "$(CFG)" != "TestBreeder32 - Win32 Debug" && "$(CFG)" != "TestBreeder32 - Win32 ReleaseEngl"
!MESSAGE Invalid configuration "$(CFG)" specified.
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "TestBreeder32.mak" CFG="TestBreeder32 - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "TestBreeder32 - Win32 Release" (based on "Win32 (x86) Application")
!MESSAGE "TestBreeder32 - Win32 Debug" (based on "Win32 (x86) Application")
!MESSAGE "TestBreeder32 - Win32 ReleaseEngl" (based on "Win32 (x86) Application")
!MESSAGE 
!ERROR An invalid configuration is specified.
!ENDIF 

!IF "$(OS)" == "Windows_NT"
NULL=
!ELSE 
NULL=nul
!ENDIF 

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

OUTDIR=.\Release
INTDIR=.\Release
# Begin Custom Macros
OutDir=.\Release
# End Custom Macros

ALL : "$(OUTDIR)\TestBreeder32.exe" "$(OUTDIR)\TestBreeder32.bsc"


CLEAN :
	-@erase "$(INTDIR)\adler32.obj"
	-@erase "$(INTDIR)\adler32.sbr"
	-@erase "$(INTDIR)\advlog.obj"
	-@erase "$(INTDIR)\advlog.sbr"
	-@erase "$(INTDIR)\attr_index.obj"
	-@erase "$(INTDIR)\attr_index.sbr"
	-@erase "$(INTDIR)\aux_index.obj"
	-@erase "$(INTDIR)\aux_index.sbr"
	-@erase "$(INTDIR)\base.obj"
	-@erase "$(INTDIR)\base.sbr"
	-@erase "$(INTDIR)\basemask.obj"
	-@erase "$(INTDIR)\basemask.sbr"
	-@erase "$(INTDIR)\bfind.obj"
	-@erase "$(INTDIR)\bfind.sbr"
	-@erase "$(INTDIR)\blob_index.obj"
	-@erase "$(INTDIR)\blob_index.sbr"
	-@erase "$(INTDIR)\btiter.obj"
	-@erase "$(INTDIR)\btiter.sbr"
	-@erase "$(INTDIR)\btree.obj"
	-@erase "$(INTDIR)\btree.sbr"
	-@erase "$(INTDIR)\btree_.obj"
	-@erase "$(INTDIR)\btree_.sbr"
	-@erase "$(INTDIR)\clTreeNode.Set.obj"
	-@erase "$(INTDIR)\clTreeNode.Set.sbr"
	-@erase "$(INTDIR)\clTreeNode.SplaySet.obj"
	-@erase "$(INTDIR)\clTreeNode.SplaySet.sbr"
	-@erase "$(INTDIR)\cmdline.obj"
	-@erase "$(INTDIR)\cmdline.sbr"
	-@erase "$(INTDIR)\cmpfunc.obj"
	-@erase "$(INTDIR)\cmpfunc.sbr"
	-@erase "$(INTDIR)\collect.obj"
	-@erase "$(INTDIR)\collect.sbr"
	-@erase "$(INTDIR)\cr_index.obj"
	-@erase "$(INTDIR)\cr_index.sbr"
	-@erase "$(INTDIR)\crc32.obj"
	-@erase "$(INTDIR)\crc32.sbr"
	-@erase "$(INTDIR)\deflate.obj"
	-@erase "$(INTDIR)\deflate.sbr"
	-@erase "$(INTDIR)\doc_index.obj"
	-@erase "$(INTDIR)\doc_index.sbr"
	-@erase "$(INTDIR)\doccol.obj"
	-@erase "$(INTDIR)\doccol.sbr"
	-@erase "$(INTDIR)\dociter.obj"
	-@erase "$(INTDIR)\dociter.sbr"
	-@erase "$(INTDIR)\doclist.obj"
	-@erase "$(INTDIR)\doclist.sbr"
	-@erase "$(INTDIR)\document.obj"
	-@erase "$(INTDIR)\document.sbr"
	-@erase "$(INTDIR)\dummies.obj"
	-@erase "$(INTDIR)\dummies.sbr"
	-@erase "$(INTDIR)\errhandler.obj"
	-@erase "$(INTDIR)\errhandler.sbr"
	-@erase "$(INTDIR)\face.obj"
	-@erase "$(INTDIR)\face.sbr"
	-@erase "$(INTDIR)\flog.obj"
	-@erase "$(INTDIR)\flog.sbr"
	-@erase "$(INTDIR)\fltiter.obj"
	-@erase "$(INTDIR)\fltiter.sbr"
	-@erase "$(INTDIR)\FString.caddr_t.Map.obj"
	-@erase "$(INTDIR)\FString.caddr_t.Map.sbr"
	-@erase "$(INTDIR)\FString.caddr_t.SplayMap.obj"
	-@erase "$(INTDIR)\FString.caddr_t.SplayMap.sbr"
	-@erase "$(INTDIR)\garutils.obj"
	-@erase "$(INTDIR)\garutils.sbr"
	-@erase "$(INTDIR)\gbase.obj"
	-@erase "$(INTDIR)\gbase.sbr"
	-@erase "$(INTDIR)\gberr.obj"
	-@erase "$(INTDIR)\gberr.sbr"
	-@erase "$(INTDIR)\globals.obj"
	-@erase "$(INTDIR)\globals.sbr"
	-@erase "$(INTDIR)\glproc.obj"
	-@erase "$(INTDIR)\glproc.sbr"
	-@erase "$(INTDIR)\gsscreen.obj"
	-@erase "$(INTDIR)\gsscreen.sbr"
	-@erase "$(INTDIR)\hc_index.obj"
	-@erase "$(INTDIR)\hc_index.sbr"
	-@erase "$(INTDIR)\hidxhlp.obj"
	-@erase "$(INTDIR)\hidxhlp.sbr"
	-@erase "$(INTDIR)\hier_index.obj"
	-@erase "$(INTDIR)\hier_index.sbr"
	-@erase "$(INTDIR)\hind_collect.obj"
	-@erase "$(INTDIR)\hind_collect.sbr"
	-@erase "$(INTDIR)\hindex.obj"
	-@erase "$(INTDIR)\hindex.sbr"
	-@erase "$(INTDIR)\index.obj"
	-@erase "$(INTDIR)\index.sbr"
	-@erase "$(INTDIR)\index_.obj"
	-@erase "$(INTDIR)\index_.sbr"
	-@erase "$(INTDIR)\indhlp.obj"
	-@erase "$(INTDIR)\indhlp.sbr"
	-@erase "$(INTDIR)\indices.obj"
	-@erase "$(INTDIR)\indices.sbr"
	-@erase "$(INTDIR)\infblock.obj"
	-@erase "$(INTDIR)\infblock.sbr"
	-@erase "$(INTDIR)\infcodes.obj"
	-@erase "$(INTDIR)\infcodes.sbr"
	-@erase "$(INTDIR)\inffast.obj"
	-@erase "$(INTDIR)\inffast.sbr"
	-@erase "$(INTDIR)\inflate.obj"
	-@erase "$(INTDIR)\inflate.sbr"
	-@erase "$(INTDIR)\inftrees.obj"
	-@erase "$(INTDIR)\inftrees.sbr"
	-@erase "$(INTDIR)\infutil.obj"
	-@erase "$(INTDIR)\infutil.sbr"
	-@erase "$(INTDIR)\iter.obj"
	-@erase "$(INTDIR)\iter.sbr"
	-@erase "$(INTDIR)\keyfile.obj"
	-@erase "$(INTDIR)\keyfile.sbr"
	-@erase "$(INTDIR)\LoginDlg.obj"
	-@erase "$(INTDIR)\LoginDlg.sbr"
	-@erase "$(INTDIR)\long.caddr_t.Map.obj"
	-@erase "$(INTDIR)\long.caddr_t.Map.sbr"
	-@erase "$(INTDIR)\long.caddr_t.SplayMap.obj"
	-@erase "$(INTDIR)\long.caddr_t.SplayMap.sbr"
	-@erase "$(INTDIR)\long.long.Map.obj"
	-@erase "$(INTDIR)\long.long.Map.sbr"
	-@erase "$(INTDIR)\long.long.SplayMap.obj"
	-@erase "$(INTDIR)\long.long.SplayMap.sbr"
	-@erase "$(INTDIR)\long.Set.obj"
	-@erase "$(INTDIR)\long.Set.sbr"
	-@erase "$(INTDIR)\long.SplaySet.obj"
	-@erase "$(INTDIR)\long.SplaySet.sbr"
	-@erase "$(INTDIR)\msg_tbl.obj"
	-@erase "$(INTDIR)\msg_tbl.sbr"
	-@erase "$(INTDIR)\ncpf.obj"
	-@erase "$(INTDIR)\ncpf.sbr"
	-@erase "$(INTDIR)\newdoc.obj"
	-@erase "$(INTDIR)\newdoc.sbr"
	-@erase "$(INTDIR)\osdummy.obj"
	-@erase "$(INTDIR)\osdummy.sbr"
	-@erase "$(INTDIR)\OtherEditCtrl.obj"
	-@erase "$(INTDIR)\OtherEditCtrl.sbr"
	-@erase "$(INTDIR)\pack.obj"
	-@erase "$(INTDIR)\pack.sbr"
	-@erase "$(INTDIR)\pagefile.obj"
	-@erase "$(INTDIR)\pagefile.sbr"
	-@erase "$(INTDIR)\PathMsgDlg.obj"
	-@erase "$(INTDIR)\PathMsgDlg.sbr"
	-@erase "$(INTDIR)\pgfile.obj"
	-@erase "$(INTDIR)\pgfile.sbr"
	-@erase "$(INTDIR)\pl_crypt.obj"
	-@erase "$(INTDIR)\pl_crypt.sbr"
	-@erase "$(INTDIR)\privbase.obj"
	-@erase "$(INTDIR)\privbase.sbr"
	-@erase "$(INTDIR)\profile.obj"
	-@erase "$(INTDIR)\profile.sbr"
	-@erase "$(INTDIR)\pscreen.obj"
	-@erase "$(INTDIR)\pscreen.sbr"
	-@erase "$(INTDIR)\ready.obj"
	-@erase "$(INTDIR)\ready.sbr"
	-@erase "$(INTDIR)\recode.obj"
	-@erase "$(INTDIR)\recode.sbr"
	-@erase "$(INTDIR)\refcol.obj"
	-@erase "$(INTDIR)\refcol.sbr"
	-@erase "$(INTDIR)\rev.obj"
	-@erase "$(INTDIR)\rev.sbr"
	-@erase "$(INTDIR)\screen.obj"
	-@erase "$(INTDIR)\screen.sbr"
	-@erase "$(INTDIR)\segfile.obj"
	-@erase "$(INTDIR)\segfile.sbr"
	-@erase "$(INTDIR)\selcttreectrl.obj"
	-@erase "$(INTDIR)\selcttreectrl.sbr"
	-@erase "$(INTDIR)\sets.obj"
	-@erase "$(INTDIR)\sets.sbr"
	-@erase "$(INTDIR)\split_index.obj"
	-@erase "$(INTDIR)\split_index.sbr"
	-@erase "$(INTDIR)\ssets.obj"
	-@erase "$(INTDIR)\ssets.sbr"
	-@erase "$(INTDIR)\StdAfx.obj"
	-@erase "$(INTDIR)\StdAfx.sbr"
	-@erase "$(INTDIR)\stdbase.obj"
	-@erase "$(INTDIR)\stdbase.sbr"
	-@erase "$(INTDIR)\store.obj"
	-@erase "$(INTDIR)\store.sbr"
	-@erase "$(INTDIR)\strcache.obj"
	-@erase "$(INTDIR)\strcache.sbr"
	-@erase "$(INTDIR)\streams.obj"
	-@erase "$(INTDIR)\streams.sbr"
	-@erase "$(INTDIR)\streams_.obj"
	-@erase "$(INTDIR)\streams_.sbr"
	-@erase "$(INTDIR)\subname.obj"
	-@erase "$(INTDIR)\subname.sbr"
	-@erase "$(INTDIR)\TestBreeder32.obj"
	-@erase "$(INTDIR)\TestBreeder32.pch"
	-@erase "$(INTDIR)\TestBreeder32.res"
	-@erase "$(INTDIR)\TestBreeder32.sbr"
	-@erase "$(INTDIR)\TestBreeder32Dlg.obj"
	-@erase "$(INTDIR)\TestBreeder32Dlg.sbr"
	-@erase "$(INTDIR)\trees.obj"
	-@erase "$(INTDIR)\trees.sbr"
	-@erase "$(INTDIR)\TrialDlg.obj"
	-@erase "$(INTDIR)\TrialDlg.sbr"
	-@erase "$(INTDIR)\u_int32_t.Set.obj"
	-@erase "$(INTDIR)\u_int32_t.Set.sbr"
	-@erase "$(INTDIR)\u_int32_t.SplaySet.obj"
	-@erase "$(INTDIR)\u_int32_t.SplaySet.sbr"
	-@erase "$(INTDIR)\u_int64_t.Set.obj"
	-@erase "$(INTDIR)\u_int64_t.Set.sbr"
	-@erase "$(INTDIR)\u_int64_t.SplaySet.obj"
	-@erase "$(INTDIR)\u_int64_t.SplaySet.sbr"
	-@erase "$(INTDIR)\unifname.obj"
	-@erase "$(INTDIR)\unifname.sbr"
	-@erase "$(INTDIR)\unzip.obj"
	-@erase "$(INTDIR)\unzip.sbr"
	-@erase "$(INTDIR)\usage.obj"
	-@erase "$(INTDIR)\usage.sbr"
	-@erase "$(INTDIR)\vapi.obj"
	-@erase "$(INTDIR)\vapi.sbr"
	-@erase "$(INTDIR)\vc60.idb"
	-@erase "$(INTDIR)\zutil.obj"
	-@erase "$(INTDIR)\zutil.sbr"
	-@erase "$(OUTDIR)\TestBreeder32.bsc"
	-@erase "$(OUTDIR)\TestBreeder32.exe"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP=cl.exe
CPP_PROJ=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\TestBreeder32.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

.c{$(INTDIR)}.obj::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cpp{$(INTDIR)}.obj::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cxx{$(INTDIR)}.obj::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.c{$(INTDIR)}.sbr::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cpp{$(INTDIR)}.sbr::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cxx{$(INTDIR)}.sbr::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

MTL=midl.exe
MTL_PROJ=/nologo /D "NDEBUG" /mktyplib203 /win32 
RSC=rc.exe
RSC_PROJ=/l 0x3009 /fo"$(INTDIR)\TestBreeder32.res" /d "NDEBUG" /d "_AFXDLL" 
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\TestBreeder32.bsc" 
BSC32_SBRS= \
	"$(INTDIR)\attr_index.sbr" \
	"$(INTDIR)\aux_index.sbr" \
	"$(INTDIR)\blob_index.sbr" \
	"$(INTDIR)\cmdline.sbr" \
	"$(INTDIR)\cr_index.sbr" \
	"$(INTDIR)\doc_index.sbr" \
	"$(INTDIR)\doclist.sbr" \
	"$(INTDIR)\glproc.sbr" \
	"$(INTDIR)\hc_index.sbr" \
	"$(INTDIR)\hier_index.sbr" \
	"$(INTDIR)\hind_collect.sbr" \
	"$(INTDIR)\indhlp.sbr" \
	"$(INTDIR)\LoginDlg.sbr" \
	"$(INTDIR)\msg_tbl.sbr" \
	"$(INTDIR)\OtherEditCtrl.sbr" \
	"$(INTDIR)\PathMsgDlg.sbr" \
	"$(INTDIR)\ready.sbr" \
	"$(INTDIR)\segfile.sbr" \
	"$(INTDIR)\selcttreectrl.sbr" \
	"$(INTDIR)\split_index.sbr" \
	"$(INTDIR)\StdAfx.sbr" \
	"$(INTDIR)\subname.sbr" \
	"$(INTDIR)\TestBreeder32.sbr" \
	"$(INTDIR)\TestBreeder32Dlg.sbr" \
	"$(INTDIR)\TrialDlg.sbr" \
	"$(INTDIR)\usage.sbr" \
	"$(INTDIR)\adler32.sbr" \
	"$(INTDIR)\base.sbr" \
	"$(INTDIR)\basemask.sbr" \
	"$(INTDIR)\btiter.sbr" \
	"$(INTDIR)\btree.sbr" \
	"$(INTDIR)\collect.sbr" \
	"$(INTDIR)\crc32.sbr" \
	"$(INTDIR)\deflate.sbr" \
	"$(INTDIR)\doccol.sbr" \
	"$(INTDIR)\dociter.sbr" \
	"$(INTDIR)\document.sbr" \
	"$(INTDIR)\dummies.sbr" \
	"$(INTDIR)\fltiter.sbr" \
	"$(INTDIR)\garutils.sbr" \
	"$(INTDIR)\hindex.sbr" \
	"$(INTDIR)\index.sbr" \
	"$(INTDIR)\indices.sbr" \
	"$(INTDIR)\infblock.sbr" \
	"$(INTDIR)\infcodes.sbr" \
	"$(INTDIR)\inffast.sbr" \
	"$(INTDIR)\inflate.sbr" \
	"$(INTDIR)\inftrees.sbr" \
	"$(INTDIR)\infutil.sbr" \
	"$(INTDIR)\ncpf.sbr" \
	"$(INTDIR)\newdoc.sbr" \
	"$(INTDIR)\osdummy.sbr" \
	"$(INTDIR)\pack.sbr" \
	"$(INTDIR)\pagefile.sbr" \
	"$(INTDIR)\pl_crypt.sbr" \
	"$(INTDIR)\privbase.sbr" \
	"$(INTDIR)\refcol.sbr" \
	"$(INTDIR)\rev.sbr" \
	"$(INTDIR)\stdbase.sbr" \
	"$(INTDIR)\store.sbr" \
	"$(INTDIR)\streams.sbr" \
	"$(INTDIR)\trees.sbr" \
	"$(INTDIR)\unzip.sbr" \
	"$(INTDIR)\zutil.sbr" \
	"$(INTDIR)\bfind.sbr" \
	"$(INTDIR)\btree_.sbr" \
	"$(INTDIR)\cmpfunc.sbr" \
	"$(INTDIR)\flog.sbr" \
	"$(INTDIR)\gbase.sbr" \
	"$(INTDIR)\gberr.sbr" \
	"$(INTDIR)\globals.sbr" \
	"$(INTDIR)\index_.sbr" \
	"$(INTDIR)\iter.sbr" \
	"$(INTDIR)\keyfile.sbr" \
	"$(INTDIR)\pgfile.sbr" \
	"$(INTDIR)\profile.sbr" \
	"$(INTDIR)\sets.sbr" \
	"$(INTDIR)\ssets.sbr" \
	"$(INTDIR)\strcache.sbr" \
	"$(INTDIR)\streams_.sbr" \
	"$(INTDIR)\unifname.sbr" \
	"$(INTDIR)\face.sbr" \
	"$(INTDIR)\gsscreen.sbr" \
	"$(INTDIR)\pscreen.sbr" \
	"$(INTDIR)\screen.sbr" \
	"$(INTDIR)\vapi.sbr" \
	"$(INTDIR)\advlog.sbr" \
	"$(INTDIR)\clTreeNode.Set.sbr" \
	"$(INTDIR)\clTreeNode.SplaySet.sbr" \
	"$(INTDIR)\errhandler.sbr" \
	"$(INTDIR)\FString.caddr_t.Map.sbr" \
	"$(INTDIR)\FString.caddr_t.SplayMap.sbr" \
	"$(INTDIR)\hidxhlp.sbr" \
	"$(INTDIR)\long.caddr_t.Map.sbr" \
	"$(INTDIR)\long.caddr_t.SplayMap.sbr" \
	"$(INTDIR)\long.long.Map.sbr" \
	"$(INTDIR)\long.long.SplayMap.sbr" \
	"$(INTDIR)\long.Set.sbr" \
	"$(INTDIR)\long.SplaySet.sbr" \
	"$(INTDIR)\recode.sbr" \
	"$(INTDIR)\u_int32_t.Set.sbr" \
	"$(INTDIR)\u_int32_t.SplaySet.sbr" \
	"$(INTDIR)\u_int64_t.Set.sbr" \
	"$(INTDIR)\u_int64_t.SplaySet.sbr"

"$(OUTDIR)\TestBreeder32.bsc" : "$(OUTDIR)" $(BSC32_SBRS)
    $(BSC32) @<<
  $(BSC32_FLAGS) $(BSC32_SBRS)
<<

LINK32=link.exe
LINK32_FLAGS=/nologo /stack:0xa00000,0xa00000 /subsystem:windows /incremental:no /pdb:"$(OUTDIR)\TestBreeder32.pdb" /machine:I386 /out:"$(OUTDIR)\TestBreeder32.exe" 
LINK32_OBJS= \
	"$(INTDIR)\attr_index.obj" \
	"$(INTDIR)\aux_index.obj" \
	"$(INTDIR)\blob_index.obj" \
	"$(INTDIR)\cmdline.obj" \
	"$(INTDIR)\cr_index.obj" \
	"$(INTDIR)\doc_index.obj" \
	"$(INTDIR)\doclist.obj" \
	"$(INTDIR)\glproc.obj" \
	"$(INTDIR)\hc_index.obj" \
	"$(INTDIR)\hier_index.obj" \
	"$(INTDIR)\hind_collect.obj" \
	"$(INTDIR)\indhlp.obj" \
	"$(INTDIR)\LoginDlg.obj" \
	"$(INTDIR)\msg_tbl.obj" \
	"$(INTDIR)\OtherEditCtrl.obj" \
	"$(INTDIR)\PathMsgDlg.obj" \
	"$(INTDIR)\ready.obj" \
	"$(INTDIR)\segfile.obj" \
	"$(INTDIR)\selcttreectrl.obj" \
	"$(INTDIR)\split_index.obj" \
	"$(INTDIR)\StdAfx.obj" \
	"$(INTDIR)\subname.obj" \
	"$(INTDIR)\TestBreeder32.obj" \
	"$(INTDIR)\TestBreeder32Dlg.obj" \
	"$(INTDIR)\TrialDlg.obj" \
	"$(INTDIR)\usage.obj" \
	"$(INTDIR)\adler32.obj" \
	"$(INTDIR)\base.obj" \
	"$(INTDIR)\basemask.obj" \
	"$(INTDIR)\btiter.obj" \
	"$(INTDIR)\btree.obj" \
	"$(INTDIR)\collect.obj" \
	"$(INTDIR)\crc32.obj" \
	"$(INTDIR)\deflate.obj" \
	"$(INTDIR)\doccol.obj" \
	"$(INTDIR)\dociter.obj" \
	"$(INTDIR)\document.obj" \
	"$(INTDIR)\dummies.obj" \
	"$(INTDIR)\fltiter.obj" \
	"$(INTDIR)\garutils.obj" \
	"$(INTDIR)\hindex.obj" \
	"$(INTDIR)\index.obj" \
	"$(INTDIR)\indices.obj" \
	"$(INTDIR)\infblock.obj" \
	"$(INTDIR)\infcodes.obj" \
	"$(INTDIR)\inffast.obj" \
	"$(INTDIR)\inflate.obj" \
	"$(INTDIR)\inftrees.obj" \
	"$(INTDIR)\infutil.obj" \
	"$(INTDIR)\ncpf.obj" \
	"$(INTDIR)\newdoc.obj" \
	"$(INTDIR)\osdummy.obj" \
	"$(INTDIR)\pack.obj" \
	"$(INTDIR)\pagefile.obj" \
	"$(INTDIR)\pl_crypt.obj" \
	"$(INTDIR)\privbase.obj" \
	"$(INTDIR)\refcol.obj" \
	"$(INTDIR)\rev.obj" \
	"$(INTDIR)\stdbase.obj" \
	"$(INTDIR)\store.obj" \
	"$(INTDIR)\streams.obj" \
	"$(INTDIR)\trees.obj" \
	"$(INTDIR)\unzip.obj" \
	"$(INTDIR)\zutil.obj" \
	"$(INTDIR)\bfind.obj" \
	"$(INTDIR)\btree_.obj" \
	"$(INTDIR)\cmpfunc.obj" \
	"$(INTDIR)\flog.obj" \
	"$(INTDIR)\gbase.obj" \
	"$(INTDIR)\gberr.obj" \
	"$(INTDIR)\globals.obj" \
	"$(INTDIR)\index_.obj" \
	"$(INTDIR)\iter.obj" \
	"$(INTDIR)\keyfile.obj" \
	"$(INTDIR)\pgfile.obj" \
	"$(INTDIR)\profile.obj" \
	"$(INTDIR)\sets.obj" \
	"$(INTDIR)\ssets.obj" \
	"$(INTDIR)\strcache.obj" \
	"$(INTDIR)\streams_.obj" \
	"$(INTDIR)\unifname.obj" \
	"$(INTDIR)\face.obj" \
	"$(INTDIR)\gsscreen.obj" \
	"$(INTDIR)\pscreen.obj" \
	"$(INTDIR)\screen.obj" \
	"$(INTDIR)\vapi.obj" \
	"$(INTDIR)\advlog.obj" \
	"$(INTDIR)\clTreeNode.Set.obj" \
	"$(INTDIR)\clTreeNode.SplaySet.obj" \
	"$(INTDIR)\errhandler.obj" \
	"$(INTDIR)\FString.caddr_t.Map.obj" \
	"$(INTDIR)\FString.caddr_t.SplayMap.obj" \
	"$(INTDIR)\hidxhlp.obj" \
	"$(INTDIR)\long.caddr_t.Map.obj" \
	"$(INTDIR)\long.caddr_t.SplayMap.obj" \
	"$(INTDIR)\long.long.Map.obj" \
	"$(INTDIR)\long.long.SplayMap.obj" \
	"$(INTDIR)\long.Set.obj" \
	"$(INTDIR)\long.SplaySet.obj" \
	"$(INTDIR)\recode.obj" \
	"$(INTDIR)\u_int32_t.Set.obj" \
	"$(INTDIR)\u_int32_t.SplaySet.obj" \
	"$(INTDIR)\u_int64_t.Set.obj" \
	"$(INTDIR)\u_int64_t.SplaySet.obj" \
	"$(INTDIR)\TestBreeder32.res"

"$(OUTDIR)\TestBreeder32.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

OUTDIR=.\Debug
INTDIR=.\Debug
# Begin Custom Macros
OutDir=.\Debug
# End Custom Macros

ALL : "$(OUTDIR)\TestBreeder32.exe" "$(OUTDIR)\TestBreeder32.bsc"


CLEAN :
	-@erase "$(INTDIR)\adler32.obj"
	-@erase "$(INTDIR)\adler32.sbr"
	-@erase "$(INTDIR)\advlog.obj"
	-@erase "$(INTDIR)\advlog.sbr"
	-@erase "$(INTDIR)\attr_index.obj"
	-@erase "$(INTDIR)\attr_index.sbr"
	-@erase "$(INTDIR)\aux_index.obj"
	-@erase "$(INTDIR)\aux_index.sbr"
	-@erase "$(INTDIR)\base.obj"
	-@erase "$(INTDIR)\base.sbr"
	-@erase "$(INTDIR)\basemask.obj"
	-@erase "$(INTDIR)\basemask.sbr"
	-@erase "$(INTDIR)\bfind.obj"
	-@erase "$(INTDIR)\bfind.sbr"
	-@erase "$(INTDIR)\blob_index.obj"
	-@erase "$(INTDIR)\blob_index.sbr"
	-@erase "$(INTDIR)\btiter.obj"
	-@erase "$(INTDIR)\btiter.sbr"
	-@erase "$(INTDIR)\btree.obj"
	-@erase "$(INTDIR)\btree.sbr"
	-@erase "$(INTDIR)\btree_.obj"
	-@erase "$(INTDIR)\btree_.sbr"
	-@erase "$(INTDIR)\clTreeNode.Set.obj"
	-@erase "$(INTDIR)\clTreeNode.Set.sbr"
	-@erase "$(INTDIR)\clTreeNode.SplaySet.obj"
	-@erase "$(INTDIR)\clTreeNode.SplaySet.sbr"
	-@erase "$(INTDIR)\cmdline.obj"
	-@erase "$(INTDIR)\cmdline.sbr"
	-@erase "$(INTDIR)\cmpfunc.obj"
	-@erase "$(INTDIR)\cmpfunc.sbr"
	-@erase "$(INTDIR)\collect.obj"
	-@erase "$(INTDIR)\collect.sbr"
	-@erase "$(INTDIR)\cr_index.obj"
	-@erase "$(INTDIR)\cr_index.sbr"
	-@erase "$(INTDIR)\crc32.obj"
	-@erase "$(INTDIR)\crc32.sbr"
	-@erase "$(INTDIR)\deflate.obj"
	-@erase "$(INTDIR)\deflate.sbr"
	-@erase "$(INTDIR)\doc_index.obj"
	-@erase "$(INTDIR)\doc_index.sbr"
	-@erase "$(INTDIR)\doccol.obj"
	-@erase "$(INTDIR)\doccol.sbr"
	-@erase "$(INTDIR)\dociter.obj"
	-@erase "$(INTDIR)\dociter.sbr"
	-@erase "$(INTDIR)\doclist.obj"
	-@erase "$(INTDIR)\doclist.sbr"
	-@erase "$(INTDIR)\document.obj"
	-@erase "$(INTDIR)\document.sbr"
	-@erase "$(INTDIR)\dummies.obj"
	-@erase "$(INTDIR)\dummies.sbr"
	-@erase "$(INTDIR)\errhandler.obj"
	-@erase "$(INTDIR)\errhandler.sbr"
	-@erase "$(INTDIR)\face.obj"
	-@erase "$(INTDIR)\face.sbr"
	-@erase "$(INTDIR)\flog.obj"
	-@erase "$(INTDIR)\flog.sbr"
	-@erase "$(INTDIR)\fltiter.obj"
	-@erase "$(INTDIR)\fltiter.sbr"
	-@erase "$(INTDIR)\FString.caddr_t.Map.obj"
	-@erase "$(INTDIR)\FString.caddr_t.Map.sbr"
	-@erase "$(INTDIR)\FString.caddr_t.SplayMap.obj"
	-@erase "$(INTDIR)\FString.caddr_t.SplayMap.sbr"
	-@erase "$(INTDIR)\garutils.obj"
	-@erase "$(INTDIR)\garutils.sbr"
	-@erase "$(INTDIR)\gbase.obj"
	-@erase "$(INTDIR)\gbase.sbr"
	-@erase "$(INTDIR)\gberr.obj"
	-@erase "$(INTDIR)\gberr.sbr"
	-@erase "$(INTDIR)\globals.obj"
	-@erase "$(INTDIR)\globals.sbr"
	-@erase "$(INTDIR)\glproc.obj"
	-@erase "$(INTDIR)\glproc.sbr"
	-@erase "$(INTDIR)\gsscreen.obj"
	-@erase "$(INTDIR)\gsscreen.sbr"
	-@erase "$(INTDIR)\hc_index.obj"
	-@erase "$(INTDIR)\hc_index.sbr"
	-@erase "$(INTDIR)\hidxhlp.obj"
	-@erase "$(INTDIR)\hidxhlp.sbr"
	-@erase "$(INTDIR)\hier_index.obj"
	-@erase "$(INTDIR)\hier_index.sbr"
	-@erase "$(INTDIR)\hind_collect.obj"
	-@erase "$(INTDIR)\hind_collect.sbr"
	-@erase "$(INTDIR)\hindex.obj"
	-@erase "$(INTDIR)\hindex.sbr"
	-@erase "$(INTDIR)\index.obj"
	-@erase "$(INTDIR)\index.sbr"
	-@erase "$(INTDIR)\index_.obj"
	-@erase "$(INTDIR)\index_.sbr"
	-@erase "$(INTDIR)\indhlp.obj"
	-@erase "$(INTDIR)\indhlp.sbr"
	-@erase "$(INTDIR)\indices.obj"
	-@erase "$(INTDIR)\indices.sbr"
	-@erase "$(INTDIR)\infblock.obj"
	-@erase "$(INTDIR)\infblock.sbr"
	-@erase "$(INTDIR)\infcodes.obj"
	-@erase "$(INTDIR)\infcodes.sbr"
	-@erase "$(INTDIR)\inffast.obj"
	-@erase "$(INTDIR)\inffast.sbr"
	-@erase "$(INTDIR)\inflate.obj"
	-@erase "$(INTDIR)\inflate.sbr"
	-@erase "$(INTDIR)\inftrees.obj"
	-@erase "$(INTDIR)\inftrees.sbr"
	-@erase "$(INTDIR)\infutil.obj"
	-@erase "$(INTDIR)\infutil.sbr"
	-@erase "$(INTDIR)\iter.obj"
	-@erase "$(INTDIR)\iter.sbr"
	-@erase "$(INTDIR)\keyfile.obj"
	-@erase "$(INTDIR)\keyfile.sbr"
	-@erase "$(INTDIR)\LoginDlg.obj"
	-@erase "$(INTDIR)\LoginDlg.sbr"
	-@erase "$(INTDIR)\long.caddr_t.Map.obj"
	-@erase "$(INTDIR)\long.caddr_t.Map.sbr"
	-@erase "$(INTDIR)\long.caddr_t.SplayMap.obj"
	-@erase "$(INTDIR)\long.caddr_t.SplayMap.sbr"
	-@erase "$(INTDIR)\long.long.Map.obj"
	-@erase "$(INTDIR)\long.long.Map.sbr"
	-@erase "$(INTDIR)\long.long.SplayMap.obj"
	-@erase "$(INTDIR)\long.long.SplayMap.sbr"
	-@erase "$(INTDIR)\long.Set.obj"
	-@erase "$(INTDIR)\long.Set.sbr"
	-@erase "$(INTDIR)\long.SplaySet.obj"
	-@erase "$(INTDIR)\long.SplaySet.sbr"
	-@erase "$(INTDIR)\msg_tbl.obj"
	-@erase "$(INTDIR)\msg_tbl.sbr"
	-@erase "$(INTDIR)\ncpf.obj"
	-@erase "$(INTDIR)\ncpf.sbr"
	-@erase "$(INTDIR)\newdoc.obj"
	-@erase "$(INTDIR)\newdoc.sbr"
	-@erase "$(INTDIR)\osdummy.obj"
	-@erase "$(INTDIR)\osdummy.sbr"
	-@erase "$(INTDIR)\OtherEditCtrl.obj"
	-@erase "$(INTDIR)\OtherEditCtrl.sbr"
	-@erase "$(INTDIR)\pack.obj"
	-@erase "$(INTDIR)\pack.sbr"
	-@erase "$(INTDIR)\pagefile.obj"
	-@erase "$(INTDIR)\pagefile.sbr"
	-@erase "$(INTDIR)\PathMsgDlg.obj"
	-@erase "$(INTDIR)\PathMsgDlg.sbr"
	-@erase "$(INTDIR)\pgfile.obj"
	-@erase "$(INTDIR)\pgfile.sbr"
	-@erase "$(INTDIR)\pl_crypt.obj"
	-@erase "$(INTDIR)\pl_crypt.sbr"
	-@erase "$(INTDIR)\privbase.obj"
	-@erase "$(INTDIR)\privbase.sbr"
	-@erase "$(INTDIR)\profile.obj"
	-@erase "$(INTDIR)\profile.sbr"
	-@erase "$(INTDIR)\pscreen.obj"
	-@erase "$(INTDIR)\pscreen.sbr"
	-@erase "$(INTDIR)\ready.obj"
	-@erase "$(INTDIR)\ready.sbr"
	-@erase "$(INTDIR)\recode.obj"
	-@erase "$(INTDIR)\recode.sbr"
	-@erase "$(INTDIR)\refcol.obj"
	-@erase "$(INTDIR)\refcol.sbr"
	-@erase "$(INTDIR)\rev.obj"
	-@erase "$(INTDIR)\rev.sbr"
	-@erase "$(INTDIR)\screen.obj"
	-@erase "$(INTDIR)\screen.sbr"
	-@erase "$(INTDIR)\segfile.obj"
	-@erase "$(INTDIR)\segfile.sbr"
	-@erase "$(INTDIR)\selcttreectrl.obj"
	-@erase "$(INTDIR)\selcttreectrl.sbr"
	-@erase "$(INTDIR)\sets.obj"
	-@erase "$(INTDIR)\sets.sbr"
	-@erase "$(INTDIR)\split_index.obj"
	-@erase "$(INTDIR)\split_index.sbr"
	-@erase "$(INTDIR)\ssets.obj"
	-@erase "$(INTDIR)\ssets.sbr"
	-@erase "$(INTDIR)\StdAfx.obj"
	-@erase "$(INTDIR)\StdAfx.sbr"
	-@erase "$(INTDIR)\stdbase.obj"
	-@erase "$(INTDIR)\stdbase.sbr"
	-@erase "$(INTDIR)\store.obj"
	-@erase "$(INTDIR)\store.sbr"
	-@erase "$(INTDIR)\strcache.obj"
	-@erase "$(INTDIR)\strcache.sbr"
	-@erase "$(INTDIR)\streams.obj"
	-@erase "$(INTDIR)\streams.sbr"
	-@erase "$(INTDIR)\streams_.obj"
	-@erase "$(INTDIR)\streams_.sbr"
	-@erase "$(INTDIR)\subname.obj"
	-@erase "$(INTDIR)\subname.sbr"
	-@erase "$(INTDIR)\TestBreeder32.obj"
	-@erase "$(INTDIR)\TestBreeder32.pch"
	-@erase "$(INTDIR)\TestBreeder32.res"
	-@erase "$(INTDIR)\TestBreeder32.sbr"
	-@erase "$(INTDIR)\TestBreeder32Dlg.obj"
	-@erase "$(INTDIR)\TestBreeder32Dlg.sbr"
	-@erase "$(INTDIR)\trees.obj"
	-@erase "$(INTDIR)\trees.sbr"
	-@erase "$(INTDIR)\TrialDlg.obj"
	-@erase "$(INTDIR)\TrialDlg.sbr"
	-@erase "$(INTDIR)\u_int32_t.Set.obj"
	-@erase "$(INTDIR)\u_int32_t.Set.sbr"
	-@erase "$(INTDIR)\u_int32_t.SplaySet.obj"
	-@erase "$(INTDIR)\u_int32_t.SplaySet.sbr"
	-@erase "$(INTDIR)\u_int64_t.Set.obj"
	-@erase "$(INTDIR)\u_int64_t.Set.sbr"
	-@erase "$(INTDIR)\u_int64_t.SplaySet.obj"
	-@erase "$(INTDIR)\u_int64_t.SplaySet.sbr"
	-@erase "$(INTDIR)\unifname.obj"
	-@erase "$(INTDIR)\unifname.sbr"
	-@erase "$(INTDIR)\unzip.obj"
	-@erase "$(INTDIR)\unzip.sbr"
	-@erase "$(INTDIR)\usage.obj"
	-@erase "$(INTDIR)\usage.sbr"
	-@erase "$(INTDIR)\vapi.obj"
	-@erase "$(INTDIR)\vapi.sbr"
	-@erase "$(INTDIR)\vc60.idb"
	-@erase "$(INTDIR)\vc60.pdb"
	-@erase "$(INTDIR)\zutil.obj"
	-@erase "$(INTDIR)\zutil.sbr"
	-@erase "$(OUTDIR)\TestBreeder32.bsc"
	-@erase "$(OUTDIR)\TestBreeder32.exe"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP=cl.exe
CPP_PROJ=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\TestBreeder32.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

.c{$(INTDIR)}.obj::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cpp{$(INTDIR)}.obj::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cxx{$(INTDIR)}.obj::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.c{$(INTDIR)}.sbr::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cpp{$(INTDIR)}.sbr::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cxx{$(INTDIR)}.sbr::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

MTL=midl.exe
MTL_PROJ=/nologo /D "_DEBUG" /mktyplib203 /win32 
RSC=rc.exe
RSC_PROJ=/l 0x3009 /fo"$(INTDIR)\TestBreeder32.res" /d "_DEBUG" /d "_AFXDLL" 
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\TestBreeder32.bsc" 
BSC32_SBRS= \
	"$(INTDIR)\attr_index.sbr" \
	"$(INTDIR)\aux_index.sbr" \
	"$(INTDIR)\blob_index.sbr" \
	"$(INTDIR)\cmdline.sbr" \
	"$(INTDIR)\cr_index.sbr" \
	"$(INTDIR)\doc_index.sbr" \
	"$(INTDIR)\doclist.sbr" \
	"$(INTDIR)\glproc.sbr" \
	"$(INTDIR)\hc_index.sbr" \
	"$(INTDIR)\hier_index.sbr" \
	"$(INTDIR)\hind_collect.sbr" \
	"$(INTDIR)\indhlp.sbr" \
	"$(INTDIR)\LoginDlg.sbr" \
	"$(INTDIR)\msg_tbl.sbr" \
	"$(INTDIR)\OtherEditCtrl.sbr" \
	"$(INTDIR)\PathMsgDlg.sbr" \
	"$(INTDIR)\ready.sbr" \
	"$(INTDIR)\segfile.sbr" \
	"$(INTDIR)\selcttreectrl.sbr" \
	"$(INTDIR)\split_index.sbr" \
	"$(INTDIR)\StdAfx.sbr" \
	"$(INTDIR)\subname.sbr" \
	"$(INTDIR)\TestBreeder32.sbr" \
	"$(INTDIR)\TestBreeder32Dlg.sbr" \
	"$(INTDIR)\TrialDlg.sbr" \
	"$(INTDIR)\usage.sbr" \
	"$(INTDIR)\adler32.sbr" \
	"$(INTDIR)\base.sbr" \
	"$(INTDIR)\basemask.sbr" \
	"$(INTDIR)\btiter.sbr" \
	"$(INTDIR)\btree.sbr" \
	"$(INTDIR)\collect.sbr" \
	"$(INTDIR)\crc32.sbr" \
	"$(INTDIR)\deflate.sbr" \
	"$(INTDIR)\doccol.sbr" \
	"$(INTDIR)\dociter.sbr" \
	"$(INTDIR)\document.sbr" \
	"$(INTDIR)\dummies.sbr" \
	"$(INTDIR)\fltiter.sbr" \
	"$(INTDIR)\garutils.sbr" \
	"$(INTDIR)\hindex.sbr" \
	"$(INTDIR)\index.sbr" \
	"$(INTDIR)\indices.sbr" \
	"$(INTDIR)\infblock.sbr" \
	"$(INTDIR)\infcodes.sbr" \
	"$(INTDIR)\inffast.sbr" \
	"$(INTDIR)\inflate.sbr" \
	"$(INTDIR)\inftrees.sbr" \
	"$(INTDIR)\infutil.sbr" \
	"$(INTDIR)\ncpf.sbr" \
	"$(INTDIR)\newdoc.sbr" \
	"$(INTDIR)\osdummy.sbr" \
	"$(INTDIR)\pack.sbr" \
	"$(INTDIR)\pagefile.sbr" \
	"$(INTDIR)\pl_crypt.sbr" \
	"$(INTDIR)\privbase.sbr" \
	"$(INTDIR)\refcol.sbr" \
	"$(INTDIR)\rev.sbr" \
	"$(INTDIR)\stdbase.sbr" \
	"$(INTDIR)\store.sbr" \
	"$(INTDIR)\streams.sbr" \
	"$(INTDIR)\trees.sbr" \
	"$(INTDIR)\unzip.sbr" \
	"$(INTDIR)\zutil.sbr" \
	"$(INTDIR)\bfind.sbr" \
	"$(INTDIR)\btree_.sbr" \
	"$(INTDIR)\cmpfunc.sbr" \
	"$(INTDIR)\flog.sbr" \
	"$(INTDIR)\gbase.sbr" \
	"$(INTDIR)\gberr.sbr" \
	"$(INTDIR)\globals.sbr" \
	"$(INTDIR)\index_.sbr" \
	"$(INTDIR)\iter.sbr" \
	"$(INTDIR)\keyfile.sbr" \
	"$(INTDIR)\pgfile.sbr" \
	"$(INTDIR)\profile.sbr" \
	"$(INTDIR)\sets.sbr" \
	"$(INTDIR)\ssets.sbr" \
	"$(INTDIR)\strcache.sbr" \
	"$(INTDIR)\streams_.sbr" \
	"$(INTDIR)\unifname.sbr" \
	"$(INTDIR)\face.sbr" \
	"$(INTDIR)\gsscreen.sbr" \
	"$(INTDIR)\pscreen.sbr" \
	"$(INTDIR)\screen.sbr" \
	"$(INTDIR)\vapi.sbr" \
	"$(INTDIR)\advlog.sbr" \
	"$(INTDIR)\clTreeNode.Set.sbr" \
	"$(INTDIR)\clTreeNode.SplaySet.sbr" \
	"$(INTDIR)\errhandler.sbr" \
	"$(INTDIR)\FString.caddr_t.Map.sbr" \
	"$(INTDIR)\FString.caddr_t.SplayMap.sbr" \
	"$(INTDIR)\hidxhlp.sbr" \
	"$(INTDIR)\long.caddr_t.Map.sbr" \
	"$(INTDIR)\long.caddr_t.SplayMap.sbr" \
	"$(INTDIR)\long.long.Map.sbr" \
	"$(INTDIR)\long.long.SplayMap.sbr" \
	"$(INTDIR)\long.Set.sbr" \
	"$(INTDIR)\long.SplaySet.sbr" \
	"$(INTDIR)\recode.sbr" \
	"$(INTDIR)\u_int32_t.Set.sbr" \
	"$(INTDIR)\u_int32_t.SplaySet.sbr" \
	"$(INTDIR)\u_int64_t.Set.sbr" \
	"$(INTDIR)\u_int64_t.SplaySet.sbr"

"$(OUTDIR)\TestBreeder32.bsc" : "$(OUTDIR)" $(BSC32_SBRS)
    $(BSC32) @<<
  $(BSC32_FLAGS) $(BSC32_SBRS)
<<

LINK32=link.exe
LINK32_FLAGS=/nologo /stack:0xa00000,0xa00000 /subsystem:windows /profile /debug /machine:I386 /out:"$(OUTDIR)\TestBreeder32.exe" 
LINK32_OBJS= \
	"$(INTDIR)\attr_index.obj" \
	"$(INTDIR)\aux_index.obj" \
	"$(INTDIR)\blob_index.obj" \
	"$(INTDIR)\cmdline.obj" \
	"$(INTDIR)\cr_index.obj" \
	"$(INTDIR)\doc_index.obj" \
	"$(INTDIR)\doclist.obj" \
	"$(INTDIR)\glproc.obj" \
	"$(INTDIR)\hc_index.obj" \
	"$(INTDIR)\hier_index.obj" \
	"$(INTDIR)\hind_collect.obj" \
	"$(INTDIR)\indhlp.obj" \
	"$(INTDIR)\LoginDlg.obj" \
	"$(INTDIR)\msg_tbl.obj" \
	"$(INTDIR)\OtherEditCtrl.obj" \
	"$(INTDIR)\PathMsgDlg.obj" \
	"$(INTDIR)\ready.obj" \
	"$(INTDIR)\segfile.obj" \
	"$(INTDIR)\selcttreectrl.obj" \
	"$(INTDIR)\split_index.obj" \
	"$(INTDIR)\StdAfx.obj" \
	"$(INTDIR)\subname.obj" \
	"$(INTDIR)\TestBreeder32.obj" \
	"$(INTDIR)\TestBreeder32Dlg.obj" \
	"$(INTDIR)\TrialDlg.obj" \
	"$(INTDIR)\usage.obj" \
	"$(INTDIR)\adler32.obj" \
	"$(INTDIR)\base.obj" \
	"$(INTDIR)\basemask.obj" \
	"$(INTDIR)\btiter.obj" \
	"$(INTDIR)\btree.obj" \
	"$(INTDIR)\collect.obj" \
	"$(INTDIR)\crc32.obj" \
	"$(INTDIR)\deflate.obj" \
	"$(INTDIR)\doccol.obj" \
	"$(INTDIR)\dociter.obj" \
	"$(INTDIR)\document.obj" \
	"$(INTDIR)\dummies.obj" \
	"$(INTDIR)\fltiter.obj" \
	"$(INTDIR)\garutils.obj" \
	"$(INTDIR)\hindex.obj" \
	"$(INTDIR)\index.obj" \
	"$(INTDIR)\indices.obj" \
	"$(INTDIR)\infblock.obj" \
	"$(INTDIR)\infcodes.obj" \
	"$(INTDIR)\inffast.obj" \
	"$(INTDIR)\inflate.obj" \
	"$(INTDIR)\inftrees.obj" \
	"$(INTDIR)\infutil.obj" \
	"$(INTDIR)\ncpf.obj" \
	"$(INTDIR)\newdoc.obj" \
	"$(INTDIR)\osdummy.obj" \
	"$(INTDIR)\pack.obj" \
	"$(INTDIR)\pagefile.obj" \
	"$(INTDIR)\pl_crypt.obj" \
	"$(INTDIR)\privbase.obj" \
	"$(INTDIR)\refcol.obj" \
	"$(INTDIR)\rev.obj" \
	"$(INTDIR)\stdbase.obj" \
	"$(INTDIR)\store.obj" \
	"$(INTDIR)\streams.obj" \
	"$(INTDIR)\trees.obj" \
	"$(INTDIR)\unzip.obj" \
	"$(INTDIR)\zutil.obj" \
	"$(INTDIR)\bfind.obj" \
	"$(INTDIR)\btree_.obj" \
	"$(INTDIR)\cmpfunc.obj" \
	"$(INTDIR)\flog.obj" \
	"$(INTDIR)\gbase.obj" \
	"$(INTDIR)\gberr.obj" \
	"$(INTDIR)\globals.obj" \
	"$(INTDIR)\index_.obj" \
	"$(INTDIR)\iter.obj" \
	"$(INTDIR)\keyfile.obj" \
	"$(INTDIR)\pgfile.obj" \
	"$(INTDIR)\profile.obj" \
	"$(INTDIR)\sets.obj" \
	"$(INTDIR)\ssets.obj" \
	"$(INTDIR)\strcache.obj" \
	"$(INTDIR)\streams_.obj" \
	"$(INTDIR)\unifname.obj" \
	"$(INTDIR)\face.obj" \
	"$(INTDIR)\gsscreen.obj" \
	"$(INTDIR)\pscreen.obj" \
	"$(INTDIR)\screen.obj" \
	"$(INTDIR)\vapi.obj" \
	"$(INTDIR)\advlog.obj" \
	"$(INTDIR)\clTreeNode.Set.obj" \
	"$(INTDIR)\clTreeNode.SplaySet.obj" \
	"$(INTDIR)\errhandler.obj" \
	"$(INTDIR)\FString.caddr_t.Map.obj" \
	"$(INTDIR)\FString.caddr_t.SplayMap.obj" \
	"$(INTDIR)\hidxhlp.obj" \
	"$(INTDIR)\long.caddr_t.Map.obj" \
	"$(INTDIR)\long.caddr_t.SplayMap.obj" \
	"$(INTDIR)\long.long.Map.obj" \
	"$(INTDIR)\long.long.SplayMap.obj" \
	"$(INTDIR)\long.Set.obj" \
	"$(INTDIR)\long.SplaySet.obj" \
	"$(INTDIR)\recode.obj" \
	"$(INTDIR)\u_int32_t.Set.obj" \
	"$(INTDIR)\u_int32_t.SplaySet.obj" \
	"$(INTDIR)\u_int64_t.Set.obj" \
	"$(INTDIR)\u_int64_t.SplaySet.obj" \
	"$(INTDIR)\TestBreeder32.res"

"$(OUTDIR)\TestBreeder32.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

OUTDIR=.\TestBreeder32Engl
INTDIR=.\TestBreeder32Engl
# Begin Custom Macros
OutDir=.\TestBreeder32Engl
# End Custom Macros

ALL : "$(OUTDIR)\TestBreeder32.exe" "$(OUTDIR)\TestBreeder32.bsc"


CLEAN :
	-@erase "$(INTDIR)\adler32.obj"
	-@erase "$(INTDIR)\adler32.sbr"
	-@erase "$(INTDIR)\advlog.obj"
	-@erase "$(INTDIR)\advlog.sbr"
	-@erase "$(INTDIR)\attr_index.obj"
	-@erase "$(INTDIR)\attr_index.sbr"
	-@erase "$(INTDIR)\aux_index.obj"
	-@erase "$(INTDIR)\aux_index.sbr"
	-@erase "$(INTDIR)\base.obj"
	-@erase "$(INTDIR)\base.sbr"
	-@erase "$(INTDIR)\basemask.obj"
	-@erase "$(INTDIR)\basemask.sbr"
	-@erase "$(INTDIR)\bfind.obj"
	-@erase "$(INTDIR)\bfind.sbr"
	-@erase "$(INTDIR)\blob_index.obj"
	-@erase "$(INTDIR)\blob_index.sbr"
	-@erase "$(INTDIR)\btiter.obj"
	-@erase "$(INTDIR)\btiter.sbr"
	-@erase "$(INTDIR)\btree.obj"
	-@erase "$(INTDIR)\btree.sbr"
	-@erase "$(INTDIR)\btree_.obj"
	-@erase "$(INTDIR)\btree_.sbr"
	-@erase "$(INTDIR)\clTreeNode.Set.obj"
	-@erase "$(INTDIR)\clTreeNode.Set.sbr"
	-@erase "$(INTDIR)\clTreeNode.SplaySet.obj"
	-@erase "$(INTDIR)\clTreeNode.SplaySet.sbr"
	-@erase "$(INTDIR)\cmdline.obj"
	-@erase "$(INTDIR)\cmdline.sbr"
	-@erase "$(INTDIR)\cmpfunc.obj"
	-@erase "$(INTDIR)\cmpfunc.sbr"
	-@erase "$(INTDIR)\collect.obj"
	-@erase "$(INTDIR)\collect.sbr"
	-@erase "$(INTDIR)\cr_index.obj"
	-@erase "$(INTDIR)\cr_index.sbr"
	-@erase "$(INTDIR)\crc32.obj"
	-@erase "$(INTDIR)\crc32.sbr"
	-@erase "$(INTDIR)\deflate.obj"
	-@erase "$(INTDIR)\deflate.sbr"
	-@erase "$(INTDIR)\doc_index.obj"
	-@erase "$(INTDIR)\doc_index.sbr"
	-@erase "$(INTDIR)\doccol.obj"
	-@erase "$(INTDIR)\doccol.sbr"
	-@erase "$(INTDIR)\dociter.obj"
	-@erase "$(INTDIR)\dociter.sbr"
	-@erase "$(INTDIR)\doclist.obj"
	-@erase "$(INTDIR)\doclist.sbr"
	-@erase "$(INTDIR)\document.obj"
	-@erase "$(INTDIR)\document.sbr"
	-@erase "$(INTDIR)\dummies.obj"
	-@erase "$(INTDIR)\dummies.sbr"
	-@erase "$(INTDIR)\errhandler.obj"
	-@erase "$(INTDIR)\errhandler.sbr"
	-@erase "$(INTDIR)\face.obj"
	-@erase "$(INTDIR)\face.sbr"
	-@erase "$(INTDIR)\flog.obj"
	-@erase "$(INTDIR)\flog.sbr"
	-@erase "$(INTDIR)\fltiter.obj"
	-@erase "$(INTDIR)\fltiter.sbr"
	-@erase "$(INTDIR)\FString.caddr_t.Map.obj"
	-@erase "$(INTDIR)\FString.caddr_t.Map.sbr"
	-@erase "$(INTDIR)\FString.caddr_t.SplayMap.obj"
	-@erase "$(INTDIR)\FString.caddr_t.SplayMap.sbr"
	-@erase "$(INTDIR)\garutils.obj"
	-@erase "$(INTDIR)\garutils.sbr"
	-@erase "$(INTDIR)\gbase.obj"
	-@erase "$(INTDIR)\gbase.sbr"
	-@erase "$(INTDIR)\gberr.obj"
	-@erase "$(INTDIR)\gberr.sbr"
	-@erase "$(INTDIR)\globals.obj"
	-@erase "$(INTDIR)\globals.sbr"
	-@erase "$(INTDIR)\glproc.obj"
	-@erase "$(INTDIR)\glproc.sbr"
	-@erase "$(INTDIR)\gsscreen.obj"
	-@erase "$(INTDIR)\gsscreen.sbr"
	-@erase "$(INTDIR)\hc_index.obj"
	-@erase "$(INTDIR)\hc_index.sbr"
	-@erase "$(INTDIR)\hidxhlp.obj"
	-@erase "$(INTDIR)\hidxhlp.sbr"
	-@erase "$(INTDIR)\hier_index.obj"
	-@erase "$(INTDIR)\hier_index.sbr"
	-@erase "$(INTDIR)\hind_collect.obj"
	-@erase "$(INTDIR)\hind_collect.sbr"
	-@erase "$(INTDIR)\hindex.obj"
	-@erase "$(INTDIR)\hindex.sbr"
	-@erase "$(INTDIR)\index.obj"
	-@erase "$(INTDIR)\index.sbr"
	-@erase "$(INTDIR)\index_.obj"
	-@erase "$(INTDIR)\index_.sbr"
	-@erase "$(INTDIR)\indhlp.obj"
	-@erase "$(INTDIR)\indhlp.sbr"
	-@erase "$(INTDIR)\indices.obj"
	-@erase "$(INTDIR)\indices.sbr"
	-@erase "$(INTDIR)\infblock.obj"
	-@erase "$(INTDIR)\infblock.sbr"
	-@erase "$(INTDIR)\infcodes.obj"
	-@erase "$(INTDIR)\infcodes.sbr"
	-@erase "$(INTDIR)\inffast.obj"
	-@erase "$(INTDIR)\inffast.sbr"
	-@erase "$(INTDIR)\inflate.obj"
	-@erase "$(INTDIR)\inflate.sbr"
	-@erase "$(INTDIR)\inftrees.obj"
	-@erase "$(INTDIR)\inftrees.sbr"
	-@erase "$(INTDIR)\infutil.obj"
	-@erase "$(INTDIR)\infutil.sbr"
	-@erase "$(INTDIR)\iter.obj"
	-@erase "$(INTDIR)\iter.sbr"
	-@erase "$(INTDIR)\keyfile.obj"
	-@erase "$(INTDIR)\keyfile.sbr"
	-@erase "$(INTDIR)\LoginDlg.obj"
	-@erase "$(INTDIR)\LoginDlg.sbr"
	-@erase "$(INTDIR)\long.caddr_t.Map.obj"
	-@erase "$(INTDIR)\long.caddr_t.Map.sbr"
	-@erase "$(INTDIR)\long.caddr_t.SplayMap.obj"
	-@erase "$(INTDIR)\long.caddr_t.SplayMap.sbr"
	-@erase "$(INTDIR)\long.long.Map.obj"
	-@erase "$(INTDIR)\long.long.Map.sbr"
	-@erase "$(INTDIR)\long.long.SplayMap.obj"
	-@erase "$(INTDIR)\long.long.SplayMap.sbr"
	-@erase "$(INTDIR)\long.Set.obj"
	-@erase "$(INTDIR)\long.Set.sbr"
	-@erase "$(INTDIR)\long.SplaySet.obj"
	-@erase "$(INTDIR)\long.SplaySet.sbr"
	-@erase "$(INTDIR)\msg_tbl.obj"
	-@erase "$(INTDIR)\msg_tbl.sbr"
	-@erase "$(INTDIR)\ncpf.obj"
	-@erase "$(INTDIR)\ncpf.sbr"
	-@erase "$(INTDIR)\newdoc.obj"
	-@erase "$(INTDIR)\newdoc.sbr"
	-@erase "$(INTDIR)\osdummy.obj"
	-@erase "$(INTDIR)\osdummy.sbr"
	-@erase "$(INTDIR)\OtherEditCtrl.obj"
	-@erase "$(INTDIR)\OtherEditCtrl.sbr"
	-@erase "$(INTDIR)\pack.obj"
	-@erase "$(INTDIR)\pack.sbr"
	-@erase "$(INTDIR)\pagefile.obj"
	-@erase "$(INTDIR)\pagefile.sbr"
	-@erase "$(INTDIR)\PathMsgDlg.obj"
	-@erase "$(INTDIR)\PathMsgDlg.sbr"
	-@erase "$(INTDIR)\pgfile.obj"
	-@erase "$(INTDIR)\pgfile.sbr"
	-@erase "$(INTDIR)\pl_crypt.obj"
	-@erase "$(INTDIR)\pl_crypt.sbr"
	-@erase "$(INTDIR)\privbase.obj"
	-@erase "$(INTDIR)\privbase.sbr"
	-@erase "$(INTDIR)\profile.obj"
	-@erase "$(INTDIR)\profile.sbr"
	-@erase "$(INTDIR)\pscreen.obj"
	-@erase "$(INTDIR)\pscreen.sbr"
	-@erase "$(INTDIR)\ready.obj"
	-@erase "$(INTDIR)\ready.sbr"
	-@erase "$(INTDIR)\recode.obj"
	-@erase "$(INTDIR)\recode.sbr"
	-@erase "$(INTDIR)\refcol.obj"
	-@erase "$(INTDIR)\refcol.sbr"
	-@erase "$(INTDIR)\rev.obj"
	-@erase "$(INTDIR)\rev.sbr"
	-@erase "$(INTDIR)\screen.obj"
	-@erase "$(INTDIR)\screen.sbr"
	-@erase "$(INTDIR)\segfile.obj"
	-@erase "$(INTDIR)\segfile.sbr"
	-@erase "$(INTDIR)\selcttreectrl.obj"
	-@erase "$(INTDIR)\selcttreectrl.sbr"
	-@erase "$(INTDIR)\sets.obj"
	-@erase "$(INTDIR)\sets.sbr"
	-@erase "$(INTDIR)\split_index.obj"
	-@erase "$(INTDIR)\split_index.sbr"
	-@erase "$(INTDIR)\ssets.obj"
	-@erase "$(INTDIR)\ssets.sbr"
	-@erase "$(INTDIR)\StdAfx.obj"
	-@erase "$(INTDIR)\StdAfx.sbr"
	-@erase "$(INTDIR)\stdbase.obj"
	-@erase "$(INTDIR)\stdbase.sbr"
	-@erase "$(INTDIR)\store.obj"
	-@erase "$(INTDIR)\store.sbr"
	-@erase "$(INTDIR)\strcache.obj"
	-@erase "$(INTDIR)\strcache.sbr"
	-@erase "$(INTDIR)\streams.obj"
	-@erase "$(INTDIR)\streams.sbr"
	-@erase "$(INTDIR)\streams_.obj"
	-@erase "$(INTDIR)\streams_.sbr"
	-@erase "$(INTDIR)\subname.obj"
	-@erase "$(INTDIR)\subname.sbr"
	-@erase "$(INTDIR)\TestBreeder32.obj"
	-@erase "$(INTDIR)\TestBreeder32.pch"
	-@erase "$(INTDIR)\TestBreeder32.res"
	-@erase "$(INTDIR)\TestBreeder32.sbr"
	-@erase "$(INTDIR)\TestBreeder32Dlg.obj"
	-@erase "$(INTDIR)\TestBreeder32Dlg.sbr"
	-@erase "$(INTDIR)\trees.obj"
	-@erase "$(INTDIR)\trees.sbr"
	-@erase "$(INTDIR)\TrialDlg.obj"
	-@erase "$(INTDIR)\TrialDlg.sbr"
	-@erase "$(INTDIR)\u_int32_t.Set.obj"
	-@erase "$(INTDIR)\u_int32_t.Set.sbr"
	-@erase "$(INTDIR)\u_int32_t.SplaySet.obj"
	-@erase "$(INTDIR)\u_int32_t.SplaySet.sbr"
	-@erase "$(INTDIR)\u_int64_t.Set.obj"
	-@erase "$(INTDIR)\u_int64_t.Set.sbr"
	-@erase "$(INTDIR)\u_int64_t.SplaySet.obj"
	-@erase "$(INTDIR)\u_int64_t.SplaySet.sbr"
	-@erase "$(INTDIR)\unifname.obj"
	-@erase "$(INTDIR)\unifname.sbr"
	-@erase "$(INTDIR)\unzip.obj"
	-@erase "$(INTDIR)\unzip.sbr"
	-@erase "$(INTDIR)\usage.obj"
	-@erase "$(INTDIR)\usage.sbr"
	-@erase "$(INTDIR)\vapi.obj"
	-@erase "$(INTDIR)\vapi.sbr"
	-@erase "$(INTDIR)\vc60.idb"
	-@erase "$(INTDIR)\zutil.obj"
	-@erase "$(INTDIR)\zutil.sbr"
	-@erase "$(OUTDIR)\TestBreeder32.bsc"
	-@erase "$(OUTDIR)\TestBreeder32.exe"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP=cl.exe
CPP_PROJ=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\TestBreeder32.pch" /Yu"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

.c{$(INTDIR)}.obj::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cpp{$(INTDIR)}.obj::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cxx{$(INTDIR)}.obj::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.c{$(INTDIR)}.sbr::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cpp{$(INTDIR)}.sbr::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

.cxx{$(INTDIR)}.sbr::
   $(CPP) @<<
   $(CPP_PROJ) $< 
<<

MTL=midl.exe
MTL_PROJ=/nologo /D "NDEBUG" /mktyplib203 /win32 
RSC=rc.exe
RSC_PROJ=/l 0x3009 /fo"$(INTDIR)\TestBreeder32.res" /d "NDEBUG" /d "_AFXDLL" /d "ENGLISH_DEF_RC" 
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\TestBreeder32.bsc" 
BSC32_SBRS= \
	"$(INTDIR)\attr_index.sbr" \
	"$(INTDIR)\aux_index.sbr" \
	"$(INTDIR)\blob_index.sbr" \
	"$(INTDIR)\cmdline.sbr" \
	"$(INTDIR)\cr_index.sbr" \
	"$(INTDIR)\doc_index.sbr" \
	"$(INTDIR)\doclist.sbr" \
	"$(INTDIR)\glproc.sbr" \
	"$(INTDIR)\hc_index.sbr" \
	"$(INTDIR)\hier_index.sbr" \
	"$(INTDIR)\hind_collect.sbr" \
	"$(INTDIR)\indhlp.sbr" \
	"$(INTDIR)\LoginDlg.sbr" \
	"$(INTDIR)\msg_tbl.sbr" \
	"$(INTDIR)\OtherEditCtrl.sbr" \
	"$(INTDIR)\PathMsgDlg.sbr" \
	"$(INTDIR)\ready.sbr" \
	"$(INTDIR)\segfile.sbr" \
	"$(INTDIR)\selcttreectrl.sbr" \
	"$(INTDIR)\split_index.sbr" \
	"$(INTDIR)\StdAfx.sbr" \
	"$(INTDIR)\subname.sbr" \
	"$(INTDIR)\TestBreeder32.sbr" \
	"$(INTDIR)\TestBreeder32Dlg.sbr" \
	"$(INTDIR)\TrialDlg.sbr" \
	"$(INTDIR)\usage.sbr" \
	"$(INTDIR)\adler32.sbr" \
	"$(INTDIR)\base.sbr" \
	"$(INTDIR)\basemask.sbr" \
	"$(INTDIR)\btiter.sbr" \
	"$(INTDIR)\btree.sbr" \
	"$(INTDIR)\collect.sbr" \
	"$(INTDIR)\crc32.sbr" \
	"$(INTDIR)\deflate.sbr" \
	"$(INTDIR)\doccol.sbr" \
	"$(INTDIR)\dociter.sbr" \
	"$(INTDIR)\document.sbr" \
	"$(INTDIR)\dummies.sbr" \
	"$(INTDIR)\fltiter.sbr" \
	"$(INTDIR)\garutils.sbr" \
	"$(INTDIR)\hindex.sbr" \
	"$(INTDIR)\index.sbr" \
	"$(INTDIR)\indices.sbr" \
	"$(INTDIR)\infblock.sbr" \
	"$(INTDIR)\infcodes.sbr" \
	"$(INTDIR)\inffast.sbr" \
	"$(INTDIR)\inflate.sbr" \
	"$(INTDIR)\inftrees.sbr" \
	"$(INTDIR)\infutil.sbr" \
	"$(INTDIR)\ncpf.sbr" \
	"$(INTDIR)\newdoc.sbr" \
	"$(INTDIR)\osdummy.sbr" \
	"$(INTDIR)\pack.sbr" \
	"$(INTDIR)\pagefile.sbr" \
	"$(INTDIR)\pl_crypt.sbr" \
	"$(INTDIR)\privbase.sbr" \
	"$(INTDIR)\refcol.sbr" \
	"$(INTDIR)\rev.sbr" \
	"$(INTDIR)\stdbase.sbr" \
	"$(INTDIR)\store.sbr" \
	"$(INTDIR)\streams.sbr" \
	"$(INTDIR)\trees.sbr" \
	"$(INTDIR)\unzip.sbr" \
	"$(INTDIR)\zutil.sbr" \
	"$(INTDIR)\bfind.sbr" \
	"$(INTDIR)\btree_.sbr" \
	"$(INTDIR)\cmpfunc.sbr" \
	"$(INTDIR)\flog.sbr" \
	"$(INTDIR)\gbase.sbr" \
	"$(INTDIR)\gberr.sbr" \
	"$(INTDIR)\globals.sbr" \
	"$(INTDIR)\index_.sbr" \
	"$(INTDIR)\iter.sbr" \
	"$(INTDIR)\keyfile.sbr" \
	"$(INTDIR)\pgfile.sbr" \
	"$(INTDIR)\profile.sbr" \
	"$(INTDIR)\sets.sbr" \
	"$(INTDIR)\ssets.sbr" \
	"$(INTDIR)\strcache.sbr" \
	"$(INTDIR)\streams_.sbr" \
	"$(INTDIR)\unifname.sbr" \
	"$(INTDIR)\face.sbr" \
	"$(INTDIR)\gsscreen.sbr" \
	"$(INTDIR)\pscreen.sbr" \
	"$(INTDIR)\screen.sbr" \
	"$(INTDIR)\vapi.sbr" \
	"$(INTDIR)\advlog.sbr" \
	"$(INTDIR)\clTreeNode.Set.sbr" \
	"$(INTDIR)\clTreeNode.SplaySet.sbr" \
	"$(INTDIR)\errhandler.sbr" \
	"$(INTDIR)\FString.caddr_t.Map.sbr" \
	"$(INTDIR)\FString.caddr_t.SplayMap.sbr" \
	"$(INTDIR)\hidxhlp.sbr" \
	"$(INTDIR)\long.caddr_t.Map.sbr" \
	"$(INTDIR)\long.caddr_t.SplayMap.sbr" \
	"$(INTDIR)\long.long.Map.sbr" \
	"$(INTDIR)\long.long.SplayMap.sbr" \
	"$(INTDIR)\long.Set.sbr" \
	"$(INTDIR)\long.SplaySet.sbr" \
	"$(INTDIR)\recode.sbr" \
	"$(INTDIR)\u_int32_t.Set.sbr" \
	"$(INTDIR)\u_int32_t.SplaySet.sbr" \
	"$(INTDIR)\u_int64_t.Set.sbr" \
	"$(INTDIR)\u_int64_t.SplaySet.sbr"

"$(OUTDIR)\TestBreeder32.bsc" : "$(OUTDIR)" $(BSC32_SBRS)
    $(BSC32) @<<
  $(BSC32_FLAGS) $(BSC32_SBRS)
<<

LINK32=link.exe
LINK32_FLAGS=/nologo /stack:0xf00000,0xf00000 /subsystem:windows /incremental:no /pdb:"$(OUTDIR)\TestBreeder32.pdb" /machine:I386 /out:"$(OUTDIR)\TestBreeder32.exe" 
LINK32_OBJS= \
	"$(INTDIR)\attr_index.obj" \
	"$(INTDIR)\aux_index.obj" \
	"$(INTDIR)\blob_index.obj" \
	"$(INTDIR)\cmdline.obj" \
	"$(INTDIR)\cr_index.obj" \
	"$(INTDIR)\doc_index.obj" \
	"$(INTDIR)\doclist.obj" \
	"$(INTDIR)\glproc.obj" \
	"$(INTDIR)\hc_index.obj" \
	"$(INTDIR)\hier_index.obj" \
	"$(INTDIR)\hind_collect.obj" \
	"$(INTDIR)\indhlp.obj" \
	"$(INTDIR)\LoginDlg.obj" \
	"$(INTDIR)\msg_tbl.obj" \
	"$(INTDIR)\OtherEditCtrl.obj" \
	"$(INTDIR)\PathMsgDlg.obj" \
	"$(INTDIR)\ready.obj" \
	"$(INTDIR)\segfile.obj" \
	"$(INTDIR)\selcttreectrl.obj" \
	"$(INTDIR)\split_index.obj" \
	"$(INTDIR)\StdAfx.obj" \
	"$(INTDIR)\subname.obj" \
	"$(INTDIR)\TestBreeder32.obj" \
	"$(INTDIR)\TestBreeder32Dlg.obj" \
	"$(INTDIR)\TrialDlg.obj" \
	"$(INTDIR)\usage.obj" \
	"$(INTDIR)\adler32.obj" \
	"$(INTDIR)\base.obj" \
	"$(INTDIR)\basemask.obj" \
	"$(INTDIR)\btiter.obj" \
	"$(INTDIR)\btree.obj" \
	"$(INTDIR)\collect.obj" \
	"$(INTDIR)\crc32.obj" \
	"$(INTDIR)\deflate.obj" \
	"$(INTDIR)\doccol.obj" \
	"$(INTDIR)\dociter.obj" \
	"$(INTDIR)\document.obj" \
	"$(INTDIR)\dummies.obj" \
	"$(INTDIR)\fltiter.obj" \
	"$(INTDIR)\garutils.obj" \
	"$(INTDIR)\hindex.obj" \
	"$(INTDIR)\index.obj" \
	"$(INTDIR)\indices.obj" \
	"$(INTDIR)\infblock.obj" \
	"$(INTDIR)\infcodes.obj" \
	"$(INTDIR)\inffast.obj" \
	"$(INTDIR)\inflate.obj" \
	"$(INTDIR)\inftrees.obj" \
	"$(INTDIR)\infutil.obj" \
	"$(INTDIR)\ncpf.obj" \
	"$(INTDIR)\newdoc.obj" \
	"$(INTDIR)\osdummy.obj" \
	"$(INTDIR)\pack.obj" \
	"$(INTDIR)\pagefile.obj" \
	"$(INTDIR)\pl_crypt.obj" \
	"$(INTDIR)\privbase.obj" \
	"$(INTDIR)\refcol.obj" \
	"$(INTDIR)\rev.obj" \
	"$(INTDIR)\stdbase.obj" \
	"$(INTDIR)\store.obj" \
	"$(INTDIR)\streams.obj" \
	"$(INTDIR)\trees.obj" \
	"$(INTDIR)\unzip.obj" \
	"$(INTDIR)\zutil.obj" \
	"$(INTDIR)\bfind.obj" \
	"$(INTDIR)\btree_.obj" \
	"$(INTDIR)\cmpfunc.obj" \
	"$(INTDIR)\flog.obj" \
	"$(INTDIR)\gbase.obj" \
	"$(INTDIR)\gberr.obj" \
	"$(INTDIR)\globals.obj" \
	"$(INTDIR)\index_.obj" \
	"$(INTDIR)\iter.obj" \
	"$(INTDIR)\keyfile.obj" \
	"$(INTDIR)\pgfile.obj" \
	"$(INTDIR)\profile.obj" \
	"$(INTDIR)\sets.obj" \
	"$(INTDIR)\ssets.obj" \
	"$(INTDIR)\strcache.obj" \
	"$(INTDIR)\streams_.obj" \
	"$(INTDIR)\unifname.obj" \
	"$(INTDIR)\face.obj" \
	"$(INTDIR)\gsscreen.obj" \
	"$(INTDIR)\pscreen.obj" \
	"$(INTDIR)\screen.obj" \
	"$(INTDIR)\vapi.obj" \
	"$(INTDIR)\advlog.obj" \
	"$(INTDIR)\clTreeNode.Set.obj" \
	"$(INTDIR)\clTreeNode.SplaySet.obj" \
	"$(INTDIR)\errhandler.obj" \
	"$(INTDIR)\FString.caddr_t.Map.obj" \
	"$(INTDIR)\FString.caddr_t.SplayMap.obj" \
	"$(INTDIR)\hidxhlp.obj" \
	"$(INTDIR)\long.caddr_t.Map.obj" \
	"$(INTDIR)\long.caddr_t.SplayMap.obj" \
	"$(INTDIR)\long.long.Map.obj" \
	"$(INTDIR)\long.long.SplayMap.obj" \
	"$(INTDIR)\long.Set.obj" \
	"$(INTDIR)\long.SplaySet.obj" \
	"$(INTDIR)\recode.obj" \
	"$(INTDIR)\u_int32_t.Set.obj" \
	"$(INTDIR)\u_int32_t.SplaySet.obj" \
	"$(INTDIR)\u_int64_t.Set.obj" \
	"$(INTDIR)\u_int64_t.SplaySet.obj" \
	"$(INTDIR)\TestBreeder32.res"

"$(OUTDIR)\TestBreeder32.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ENDIF 


!IF "$(NO_EXTERNAL_DEPS)" != "1"
!IF EXISTS("TestBreeder32.dep")
!INCLUDE "TestBreeder32.dep"
!ELSE 
!MESSAGE Warning: cannot find "TestBreeder32.dep"
!ENDIF 
!ENDIF 


!IF "$(CFG)" == "TestBreeder32 - Win32 Release" || "$(CFG)" == "TestBreeder32 - Win32 Debug" || "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"
SOURCE=..\..\..\tools\gsplit\src\attr_index.c

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\attr_index.obj"	"$(INTDIR)\attr_index.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\attr_index.obj"	"$(INTDIR)\attr_index.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\attr_index.obj"	"$(INTDIR)\attr_index.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\tools\gsplit\src\aux_index.c

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\aux_index.obj"	"$(INTDIR)\aux_index.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\aux_index.obj"	"$(INTDIR)\aux_index.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\aux_index.obj"	"$(INTDIR)\aux_index.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\tools\gsplit\src\blob_index.c

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\blob_index.obj"	"$(INTDIR)\blob_index.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\blob_index.obj"	"$(INTDIR)\blob_index.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\blob_index.obj"	"$(INTDIR)\blob_index.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\tools\gsplit\src\cmdline.c

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\cmdline.obj"	"$(INTDIR)\cmdline.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\cmdline.obj"	"$(INTDIR)\cmdline.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\cmdline.obj"	"$(INTDIR)\cmdline.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\tools\gsplit\src\cr_index.c

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\cr_index.obj"	"$(INTDIR)\cr_index.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\cr_index.obj"	"$(INTDIR)\cr_index.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\cr_index.obj"	"$(INTDIR)\cr_index.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\tools\gsplit\src\doc_index.c

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\doc_index.obj"	"$(INTDIR)\doc_index.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\doc_index.obj"	"$(INTDIR)\doc_index.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\doc_index.obj"	"$(INTDIR)\doc_index.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\tools\gsplit\src\doclist.c

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\doclist.obj"	"$(INTDIR)\doclist.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\doclist.obj"	"$(INTDIR)\doclist.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\doclist.obj"	"$(INTDIR)\doclist.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\tools\gctools\src\glproc.cpp

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\glproc.obj"	"$(INTDIR)\glproc.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\glproc.obj"	"$(INTDIR)\glproc.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\glproc.obj"	"$(INTDIR)\glproc.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\tools\gsplit\src\hc_index.c

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\hc_index.obj"	"$(INTDIR)\hc_index.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\hc_index.obj"	"$(INTDIR)\hc_index.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\hc_index.obj"	"$(INTDIR)\hc_index.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\tools\gsplit\src\hier_index.c

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\hier_index.obj"	"$(INTDIR)\hier_index.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\hier_index.obj"	"$(INTDIR)\hier_index.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\hier_index.obj"	"$(INTDIR)\hier_index.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\tools\gsplit\src\hind_collect.c

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\hind_collect.obj"	"$(INTDIR)\hind_collect.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\hind_collect.obj"	"$(INTDIR)\hind_collect.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\hind_collect.obj"	"$(INTDIR)\hind_collect.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\tools\gsplit\src\indhlp.c

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\indhlp.obj"	"$(INTDIR)\indhlp.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\indhlp.obj"	"$(INTDIR)\indhlp.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\indhlp.obj"	"$(INTDIR)\indhlp.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\LoginDlg.cpp

"$(INTDIR)\LoginDlg.obj"	"$(INTDIR)\LoginDlg.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\TestBreeder32.pch"


SOURCE=..\..\..\tools\gsplit\src\msg_tbl.c

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\msg_tbl.obj"	"$(INTDIR)\msg_tbl.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\msg_tbl.obj"	"$(INTDIR)\msg_tbl.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\msg_tbl.obj"	"$(INTDIR)\msg_tbl.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\OtherEditCtrl.cpp

"$(INTDIR)\OtherEditCtrl.obj"	"$(INTDIR)\OtherEditCtrl.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\TestBreeder32.pch"


SOURCE=.\PathMsgDlg.cpp

"$(INTDIR)\PathMsgDlg.obj"	"$(INTDIR)\PathMsgDlg.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\TestBreeder32.pch"


SOURCE=..\..\..\tools\gsplit\src\ready.cpp

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\ready.obj"	"$(INTDIR)\ready.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\ready.obj"	"$(INTDIR)\ready.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\ready.obj"	"$(INTDIR)\ready.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\tools\gsplit\src\segfile.c

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\segfile.obj"	"$(INTDIR)\segfile.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\segfile.obj"	"$(INTDIR)\segfile.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\segfile.obj"	"$(INTDIR)\segfile.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\selcttreectrl.cpp

"$(INTDIR)\selcttreectrl.obj"	"$(INTDIR)\selcttreectrl.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\TestBreeder32.pch"


SOURCE=..\..\..\tools\gsplit\src\split_index.c

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\split_index.obj"	"$(INTDIR)\split_index.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\split_index.obj"	"$(INTDIR)\split_index.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\split_index.obj"	"$(INTDIR)\split_index.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\StdAfx.cpp

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\TestBreeder32.pch" /Yc"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\StdAfx.obj"	"$(INTDIR)\StdAfx.sbr"	"$(INTDIR)\TestBreeder32.pch" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\TestBreeder32.pch" /Yc"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\StdAfx.obj"	"$(INTDIR)\StdAfx.sbr"	"$(INTDIR)\TestBreeder32.pch" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\TestBreeder32.pch" /Yc"stdafx.h" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\StdAfx.obj"	"$(INTDIR)\StdAfx.sbr"	"$(INTDIR)\TestBreeder32.pch" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\..\tools\gsplit\src\subname.c

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\subname.obj"	"$(INTDIR)\subname.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\subname.obj"	"$(INTDIR)\subname.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\subname.obj"	"$(INTDIR)\subname.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=.\TestBreeder32.cpp

"$(INTDIR)\TestBreeder32.obj"	"$(INTDIR)\TestBreeder32.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\TestBreeder32.pch"


SOURCE=.\TestBreeder32.rc

"$(INTDIR)\TestBreeder32.res" : $(SOURCE) "$(INTDIR)"
	$(RSC) $(RSC_PROJ) $(SOURCE)


SOURCE=.\TestBreeder32Dlg.cpp

"$(INTDIR)\TestBreeder32Dlg.obj"	"$(INTDIR)\TestBreeder32Dlg.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\TestBreeder32.pch"


SOURCE=.\TrialDlg.cpp

"$(INTDIR)\TrialDlg.obj"	"$(INTDIR)\TrialDlg.sbr" : $(SOURCE) "$(INTDIR)" "$(INTDIR)\TestBreeder32.pch"


SOURCE=..\..\..\tools\gsplit\src\usage.c

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\usage.obj"	"$(INTDIR)\usage.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\usage.obj"	"$(INTDIR)\usage.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\usage.obj"	"$(INTDIR)\usage.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\gkdb\src\adler32.c

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\adler32.obj"	"$(INTDIR)\adler32.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\adler32.obj"	"$(INTDIR)\adler32.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\adler32.obj"	"$(INTDIR)\adler32.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\gkdb\src\base.cpp

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\base.obj"	"$(INTDIR)\base.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\base.obj"	"$(INTDIR)\base.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\base.obj"	"$(INTDIR)\base.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\gkdb\src\basemask.cpp

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\basemask.obj"	"$(INTDIR)\basemask.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\basemask.obj"	"$(INTDIR)\basemask.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\basemask.obj"	"$(INTDIR)\basemask.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\gkdb\src\btiter.cpp

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\btiter.obj"	"$(INTDIR)\btiter.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\btiter.obj"	"$(INTDIR)\btiter.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\btiter.obj"	"$(INTDIR)\btiter.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\gkdb\src\btree.cpp

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\btree.obj"	"$(INTDIR)\btree.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\btree.obj"	"$(INTDIR)\btree.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\btree.obj"	"$(INTDIR)\btree.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\gkdb\src\collect.cpp

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\collect.obj"	"$(INTDIR)\collect.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\collect.obj"	"$(INTDIR)\collect.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\collect.obj"	"$(INTDIR)\collect.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\gkdb\src\crc32.c

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\crc32.obj"	"$(INTDIR)\crc32.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\crc32.obj"	"$(INTDIR)\crc32.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\crc32.obj"	"$(INTDIR)\crc32.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\gkdb\src\deflate.c

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\deflate.obj"	"$(INTDIR)\deflate.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\deflate.obj"	"$(INTDIR)\deflate.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\deflate.obj"	"$(INTDIR)\deflate.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\gkdb\src\doccol.cpp

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\doccol.obj"	"$(INTDIR)\doccol.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\doccol.obj"	"$(INTDIR)\doccol.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\doccol.obj"	"$(INTDIR)\doccol.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\gkdb\src\dociter.cpp

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\dociter.obj"	"$(INTDIR)\dociter.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\dociter.obj"	"$(INTDIR)\dociter.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\dociter.obj"	"$(INTDIR)\dociter.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\gkdb\src\document.cpp

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\document.obj"	"$(INTDIR)\document.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\document.obj"	"$(INTDIR)\document.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\document.obj"	"$(INTDIR)\document.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\gkdb\src\dummies.cpp

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\dummies.obj"	"$(INTDIR)\dummies.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\dummies.obj"	"$(INTDIR)\dummies.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\dummies.obj"	"$(INTDIR)\dummies.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\gkdb\src\fltiter.cpp

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\fltiter.obj"	"$(INTDIR)\fltiter.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\fltiter.obj"	"$(INTDIR)\fltiter.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\fltiter.obj"	"$(INTDIR)\fltiter.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\gkdb\src\garutils.cpp

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\garutils.obj"	"$(INTDIR)\garutils.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\garutils.obj"	"$(INTDIR)\garutils.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\garutils.obj"	"$(INTDIR)\garutils.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\gkdb\src\hindex.cpp

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\hindex.obj"	"$(INTDIR)\hindex.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\hindex.obj"	"$(INTDIR)\hindex.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\hindex.obj"	"$(INTDIR)\hindex.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\gkdb\src\index.cpp

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\index.obj"	"$(INTDIR)\index.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\index.obj"	"$(INTDIR)\index.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\index.obj"	"$(INTDIR)\index.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\gkdb\src\indices.cpp

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\indices.obj"	"$(INTDIR)\indices.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\indices.obj"	"$(INTDIR)\indices.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\indices.obj"	"$(INTDIR)\indices.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\gkdb\src\infblock.c

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\infblock.obj"	"$(INTDIR)\infblock.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\infblock.obj"	"$(INTDIR)\infblock.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\infblock.obj"	"$(INTDIR)\infblock.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\gkdb\src\infcodes.c

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\infcodes.obj"	"$(INTDIR)\infcodes.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\infcodes.obj"	"$(INTDIR)\infcodes.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\infcodes.obj"	"$(INTDIR)\infcodes.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\gkdb\src\inffast.c

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\inffast.obj"	"$(INTDIR)\inffast.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\inffast.obj"	"$(INTDIR)\inffast.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\inffast.obj"	"$(INTDIR)\inffast.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\gkdb\src\inflate.c

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\inflate.obj"	"$(INTDIR)\inflate.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\inflate.obj"	"$(INTDIR)\inflate.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\inflate.obj"	"$(INTDIR)\inflate.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\gkdb\src\inftrees.c

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\inftrees.obj"	"$(INTDIR)\inftrees.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\inftrees.obj"	"$(INTDIR)\inftrees.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\inftrees.obj"	"$(INTDIR)\inftrees.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\gkdb\src\infutil.c

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\infutil.obj"	"$(INTDIR)\infutil.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\infutil.obj"	"$(INTDIR)\infutil.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\infutil.obj"	"$(INTDIR)\infutil.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\gkdb\src\ncpf.cpp

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\ncpf.obj"	"$(INTDIR)\ncpf.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\ncpf.obj"	"$(INTDIR)\ncpf.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\ncpf.obj"	"$(INTDIR)\ncpf.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\gkdb\src\newdoc.cpp

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\newdoc.obj"	"$(INTDIR)\newdoc.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\newdoc.obj"	"$(INTDIR)\newdoc.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\newdoc.obj"	"$(INTDIR)\newdoc.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\gkdb\src\osdummy.c

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\osdummy.obj"	"$(INTDIR)\osdummy.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\osdummy.obj"	"$(INTDIR)\osdummy.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\osdummy.obj"	"$(INTDIR)\osdummy.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\gkdb\src\pack.c

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\pack.obj"	"$(INTDIR)\pack.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\pack.obj"	"$(INTDIR)\pack.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\pack.obj"	"$(INTDIR)\pack.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\gkdb\src\pagefile.cpp

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\pagefile.obj"	"$(INTDIR)\pagefile.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\pagefile.obj"	"$(INTDIR)\pagefile.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\pagefile.obj"	"$(INTDIR)\pagefile.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\gkdb\src\pl_crypt.c

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\pl_crypt.obj"	"$(INTDIR)\pl_crypt.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\pl_crypt.obj"	"$(INTDIR)\pl_crypt.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\pl_crypt.obj"	"$(INTDIR)\pl_crypt.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\gkdb\src\privbase.cpp

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\privbase.obj"	"$(INTDIR)\privbase.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\privbase.obj"	"$(INTDIR)\privbase.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\privbase.obj"	"$(INTDIR)\privbase.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\gkdb\src\refcol.cpp

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\refcol.obj"	"$(INTDIR)\refcol.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\refcol.obj"	"$(INTDIR)\refcol.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\refcol.obj"	"$(INTDIR)\refcol.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\gkdb\src\rev.cpp

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\rev.obj"	"$(INTDIR)\rev.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\rev.obj"	"$(INTDIR)\rev.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\rev.obj"	"$(INTDIR)\rev.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\gkdb\src\stdbase.cpp

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\stdbase.obj"	"$(INTDIR)\stdbase.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\stdbase.obj"	"$(INTDIR)\stdbase.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\stdbase.obj"	"$(INTDIR)\stdbase.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\gkdb\src\store.cpp

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\store.obj"	"$(INTDIR)\store.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\store.obj"	"$(INTDIR)\store.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\store.obj"	"$(INTDIR)\store.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\gkdb\src\streams.cpp

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\streams.obj"	"$(INTDIR)\streams.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\streams.obj"	"$(INTDIR)\streams.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\streams.obj"	"$(INTDIR)\streams.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\gkdb\src\trees.c

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\trees.obj"	"$(INTDIR)\trees.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\trees.obj"	"$(INTDIR)\trees.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\trees.obj"	"$(INTDIR)\trees.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\gkdb\src\unzip.c

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\unzip.obj"	"$(INTDIR)\unzip.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\unzip.obj"	"$(INTDIR)\unzip.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\unzip.obj"	"$(INTDIR)\unzip.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\gkdb\src\zutil.c

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\zutil.obj"	"$(INTDIR)\zutil.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\zutil.obj"	"$(INTDIR)\zutil.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\zutil.obj"	"$(INTDIR)\zutil.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\mrglib\src\bfind.c

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\bfind.obj"	"$(INTDIR)\bfind.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\bfind.obj"	"$(INTDIR)\bfind.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\bfind.obj"	"$(INTDIR)\bfind.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\mrglib\src\btree_.c

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\btree_.obj"	"$(INTDIR)\btree_.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\btree_.obj"	"$(INTDIR)\btree_.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\btree_.obj"	"$(INTDIR)\btree_.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\mrglib\src\cmpfunc.c

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\cmpfunc.obj"	"$(INTDIR)\cmpfunc.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\cmpfunc.obj"	"$(INTDIR)\cmpfunc.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\cmpfunc.obj"	"$(INTDIR)\cmpfunc.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\mrglib\src\flog.c

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\flog.obj"	"$(INTDIR)\flog.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\flog.obj"	"$(INTDIR)\flog.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\flog.obj"	"$(INTDIR)\flog.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\mrglib\src\gbase.c

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\gbase.obj"	"$(INTDIR)\gbase.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\gbase.obj"	"$(INTDIR)\gbase.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\gbase.obj"	"$(INTDIR)\gbase.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\mrglib\src\gberr.c

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\gberr.obj"	"$(INTDIR)\gberr.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\gberr.obj"	"$(INTDIR)\gberr.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\gberr.obj"	"$(INTDIR)\gberr.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\mrglib\src\globals.c

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\globals.obj"	"$(INTDIR)\globals.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\globals.obj"	"$(INTDIR)\globals.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\globals.obj"	"$(INTDIR)\globals.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\mrglib\src\index_.c

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\index_.obj"	"$(INTDIR)\index_.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\index_.obj"	"$(INTDIR)\index_.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\index_.obj"	"$(INTDIR)\index_.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\mrglib\src\iter.c

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\iter.obj"	"$(INTDIR)\iter.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\iter.obj"	"$(INTDIR)\iter.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\iter.obj"	"$(INTDIR)\iter.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\mrglib\src\keyfile.c

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\keyfile.obj"	"$(INTDIR)\keyfile.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\keyfile.obj"	"$(INTDIR)\keyfile.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\keyfile.obj"	"$(INTDIR)\keyfile.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\mrglib\src\pgfile.c

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\pgfile.obj"	"$(INTDIR)\pgfile.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\pgfile.obj"	"$(INTDIR)\pgfile.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\pgfile.obj"	"$(INTDIR)\pgfile.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\mrglib\src\profile.c

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\profile.obj"	"$(INTDIR)\profile.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\profile.obj"	"$(INTDIR)\profile.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\profile.obj"	"$(INTDIR)\profile.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\mrglib\src\sets.c

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\sets.obj"	"$(INTDIR)\sets.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\sets.obj"	"$(INTDIR)\sets.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\sets.obj"	"$(INTDIR)\sets.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\mrglib\src\ssets.c

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\ssets.obj"	"$(INTDIR)\ssets.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\ssets.obj"	"$(INTDIR)\ssets.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\ssets.obj"	"$(INTDIR)\ssets.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\mrglib\src\strcache.c

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\strcache.obj"	"$(INTDIR)\strcache.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\strcache.obj"	"$(INTDIR)\strcache.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\strcache.obj"	"$(INTDIR)\strcache.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\mrglib\src\streams_.c

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\streams_.obj"	"$(INTDIR)\streams_.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\streams_.obj"	"$(INTDIR)\streams_.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\streams_.obj"	"$(INTDIR)\streams_.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\mrglib\src\unifname.c

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\unifname.obj"	"$(INTDIR)\unifname.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\unifname.obj"	"$(INTDIR)\unifname.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\unifname.obj"	"$(INTDIR)\unifname.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\gsscreen\src\face.c

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\face.obj"	"$(INTDIR)\face.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\face.obj"	"$(INTDIR)\face.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\face.obj"	"$(INTDIR)\face.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\gsscreen\src\gsscreen.cpp

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\gsscreen.obj"	"$(INTDIR)\gsscreen.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\gsscreen.obj"	"$(INTDIR)\gsscreen.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\gsscreen.obj"	"$(INTDIR)\gsscreen.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\gsscreen\src\pscreen.cpp

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\pscreen.obj"	"$(INTDIR)\pscreen.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\pscreen.obj"	"$(INTDIR)\pscreen.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\pscreen.obj"	"$(INTDIR)\pscreen.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\gsscreen\src\screen.c

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\screen.obj"	"$(INTDIR)\screen.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\screen.obj"	"$(INTDIR)\screen.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\screen.obj"	"$(INTDIR)\screen.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\VControl\src\vapi.c

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\vapi.obj"	"$(INTDIR)\vapi.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\vapi.obj"	"$(INTDIR)\vapi.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\vapi.obj"	"$(INTDIR)\vapi.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\cchlp\src\advlog.cpp

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\advlog.obj"	"$(INTDIR)\advlog.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\advlog.obj"	"$(INTDIR)\advlog.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\advlog.obj"	"$(INTDIR)\advlog.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\cchlp\src\clTreeNode.Set.cpp

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\clTreeNode.Set.obj"	"$(INTDIR)\clTreeNode.Set.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\clTreeNode.Set.obj"	"$(INTDIR)\clTreeNode.Set.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\clTreeNode.Set.obj"	"$(INTDIR)\clTreeNode.Set.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\cchlp\src\clTreeNode.SplaySet.cpp

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\clTreeNode.SplaySet.obj"	"$(INTDIR)\clTreeNode.SplaySet.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\clTreeNode.SplaySet.obj"	"$(INTDIR)\clTreeNode.SplaySet.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\clTreeNode.SplaySet.obj"	"$(INTDIR)\clTreeNode.SplaySet.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\cchlp\src\errhandler.cpp

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\errhandler.obj"	"$(INTDIR)\errhandler.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\errhandler.obj"	"$(INTDIR)\errhandler.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\errhandler.obj"	"$(INTDIR)\errhandler.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\cchlp\src\FString.caddr_t.Map.cpp

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\FString.caddr_t.Map.obj"	"$(INTDIR)\FString.caddr_t.Map.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\FString.caddr_t.Map.obj"	"$(INTDIR)\FString.caddr_t.Map.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\FString.caddr_t.Map.obj"	"$(INTDIR)\FString.caddr_t.Map.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\cchlp\src\FString.caddr_t.SplayMap.cpp

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\FString.caddr_t.SplayMap.obj"	"$(INTDIR)\FString.caddr_t.SplayMap.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\FString.caddr_t.SplayMap.obj"	"$(INTDIR)\FString.caddr_t.SplayMap.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\FString.caddr_t.SplayMap.obj"	"$(INTDIR)\FString.caddr_t.SplayMap.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\cchlp\src\hidxhlp.cpp

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\hidxhlp.obj"	"$(INTDIR)\hidxhlp.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\hidxhlp.obj"	"$(INTDIR)\hidxhlp.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\hidxhlp.obj"	"$(INTDIR)\hidxhlp.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\cchlp\src\long.caddr_t.Map.cpp

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\long.caddr_t.Map.obj"	"$(INTDIR)\long.caddr_t.Map.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\long.caddr_t.Map.obj"	"$(INTDIR)\long.caddr_t.Map.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\long.caddr_t.Map.obj"	"$(INTDIR)\long.caddr_t.Map.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\cchlp\src\long.caddr_t.SplayMap.cpp

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\long.caddr_t.SplayMap.obj"	"$(INTDIR)\long.caddr_t.SplayMap.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\long.caddr_t.SplayMap.obj"	"$(INTDIR)\long.caddr_t.SplayMap.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\long.caddr_t.SplayMap.obj"	"$(INTDIR)\long.caddr_t.SplayMap.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\cchlp\src\long.long.Map.cpp

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\long.long.Map.obj"	"$(INTDIR)\long.long.Map.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\long.long.Map.obj"	"$(INTDIR)\long.long.Map.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\long.long.Map.obj"	"$(INTDIR)\long.long.Map.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\cchlp\src\long.long.SplayMap.cpp

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\long.long.SplayMap.obj"	"$(INTDIR)\long.long.SplayMap.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\long.long.SplayMap.obj"	"$(INTDIR)\long.long.SplayMap.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\long.long.SplayMap.obj"	"$(INTDIR)\long.long.SplayMap.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\cchlp\src\long.Set.cpp

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\long.Set.obj"	"$(INTDIR)\long.Set.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\long.Set.obj"	"$(INTDIR)\long.Set.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\long.Set.obj"	"$(INTDIR)\long.Set.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\cchlp\src\long.SplaySet.cpp

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\long.SplaySet.obj"	"$(INTDIR)\long.SplaySet.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\long.SplaySet.obj"	"$(INTDIR)\long.SplaySet.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\long.SplaySet.obj"	"$(INTDIR)\long.SplaySet.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\cchlp\src\recode.cpp

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\recode.obj"	"$(INTDIR)\recode.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\recode.obj"	"$(INTDIR)\recode.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\recode.obj"	"$(INTDIR)\recode.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\cchlp\src\u_int32_t.Set.cpp

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\u_int32_t.Set.obj"	"$(INTDIR)\u_int32_t.Set.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\u_int32_t.Set.obj"	"$(INTDIR)\u_int32_t.Set.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\u_int32_t.Set.obj"	"$(INTDIR)\u_int32_t.Set.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\cchlp\src\u_int32_t.SplaySet.cpp

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\u_int32_t.SplaySet.obj"	"$(INTDIR)\u_int32_t.SplaySet.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\u_int32_t.SplaySet.obj"	"$(INTDIR)\u_int32_t.SplaySet.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\u_int32_t.SplaySet.obj"	"$(INTDIR)\u_int32_t.SplaySet.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\cchlp\src\u_int64_t.Set.cpp

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\u_int64_t.Set.obj"	"$(INTDIR)\u_int64_t.Set.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\u_int64_t.Set.obj"	"$(INTDIR)\u_int64_t.Set.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\u_int64_t.Set.obj"	"$(INTDIR)\u_int64_t.Set.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\..\cchlp\src\u_int64_t.SplaySet.cpp

!IF  "$(CFG)" == "TestBreeder32 - Win32 Release"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "_AFXDLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\u_int64_t.SplaySet.obj"	"$(INTDIR)\u_int64_t.SplaySet.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /MDd /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "INC_DONGLE_DLL" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\u_int64_t.SplaySet.obj"	"$(INTDIR)\u_int64_t.SplaySet.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "TestBreeder32 - Win32 ReleaseEngl"

CPP_SWITCHES=/nologo /Zp1 /MD /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /I "../../../libs/gpersn/src" /D "INC_DONGLE_DLL" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_AFXDLL" /D "_MBCS" /D "BRDR32" /D "RD_AS_ETALON" /D "ENGLISH_DEF_RC" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\u_int64_t.SplaySet.obj"	"$(INTDIR)\u_int64_t.SplaySet.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 


!ENDIF 

