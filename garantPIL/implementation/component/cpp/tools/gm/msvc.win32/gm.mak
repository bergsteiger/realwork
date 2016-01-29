# Microsoft Developer Studio Generated NMAKE File, Based on gm.dsp
!IF "$(CFG)" == ""
CFG=gm - Win32 Debug
!MESSAGE No configuration specified. Defaulting to gm - Win32 Debug.
!ENDIF 

!IF "$(CFG)" != "gm - Win32 Release" && "$(CFG)" != "gm - Win32 Debug"
!MESSAGE Invalid configuration "$(CFG)" specified.
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "gm.mak" CFG="gm - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "gm - Win32 Release" (based on "Win32 (x86) Console Application")
!MESSAGE "gm - Win32 Debug" (based on "Win32 (x86) Console Application")
!MESSAGE 
!ERROR An invalid configuration is specified.
!ENDIF 

!IF "$(OS)" == "Windows_NT"
NULL=
!ELSE 
NULL=nul
!ENDIF 

!IF  "$(CFG)" == "gm - Win32 Release"

OUTDIR=.\Release
INTDIR=.\Release
# Begin Custom Macros
OutDir=.\Release
# End Custom Macros

ALL : "$(OUTDIR)\gm.exe"


CLEAN :
	-@erase "$(INTDIR)\adler32.obj"
	-@erase "$(INTDIR)\advlog.obj"
	-@erase "$(INTDIR)\attrs_index.obj"
	-@erase "$(INTDIR)\aux_index.obj"
	-@erase "$(INTDIR)\base.obj"
	-@erase "$(INTDIR)\basemask.obj"
	-@erase "$(INTDIR)\bfind.obj"
	-@erase "$(INTDIR)\blob_index.obj"
	-@erase "$(INTDIR)\btiter.obj"
	-@erase "$(INTDIR)\btree.obj"
	-@erase "$(INTDIR)\btree_.obj"
	-@erase "$(INTDIR)\clTreeNode.Set.obj"
	-@erase "$(INTDIR)\clTreeNode.SplaySet.obj"
	-@erase "$(INTDIR)\cmdline.obj"
	-@erase "$(INTDIR)\cmpfunc.obj"
	-@erase "$(INTDIR)\collect.obj"
	-@erase "$(INTDIR)\crc32.obj"
	-@erase "$(INTDIR)\deflate.obj"
	-@erase "$(INTDIR)\doc_index.obj"
	-@erase "$(INTDIR)\doccol.obj"
	-@erase "$(INTDIR)\dociter.obj"
	-@erase "$(INTDIR)\document.obj"
	-@erase "$(INTDIR)\dummies.obj"
	-@erase "$(INTDIR)\errhandler.obj"
	-@erase "$(INTDIR)\face.obj"
	-@erase "$(INTDIR)\flog.obj"
	-@erase "$(INTDIR)\fltiter.obj"
	-@erase "$(INTDIR)\FString.caddr_t.Map.obj"
	-@erase "$(INTDIR)\FString.caddr_t.SplayMap.obj"
	-@erase "$(INTDIR)\garutils.obj"
	-@erase "$(INTDIR)\gbase.obj"
	-@erase "$(INTDIR)\gberr.obj"
	-@erase "$(INTDIR)\globals.obj"
	-@erase "$(INTDIR)\gmmain.obj"
	-@erase "$(INTDIR)\gsscreen.obj"
	-@erase "$(INTDIR)\hidxhlp.obj"
	-@erase "$(INTDIR)\hier_index.obj"
	-@erase "$(INTDIR)\hindex.obj"
	-@erase "$(INTDIR)\idxmhlp.obj"
	-@erase "$(INTDIR)\ind_merge.obj"
	-@erase "$(INTDIR)\index.obj"
	-@erase "$(INTDIR)\index_.obj"
	-@erase "$(INTDIR)\indices.obj"
	-@erase "$(INTDIR)\infblock.obj"
	-@erase "$(INTDIR)\infcodes.obj"
	-@erase "$(INTDIR)\inffast.obj"
	-@erase "$(INTDIR)\inflate.obj"
	-@erase "$(INTDIR)\inftrees.obj"
	-@erase "$(INTDIR)\infutil.obj"
	-@erase "$(INTDIR)\iter.obj"
	-@erase "$(INTDIR)\keyfile.obj"
	-@erase "$(INTDIR)\long.caddr_t.Map.obj"
	-@erase "$(INTDIR)\long.caddr_t.SplayMap.obj"
	-@erase "$(INTDIR)\long.long.Map.obj"
	-@erase "$(INTDIR)\long.long.SplayMap.obj"
	-@erase "$(INTDIR)\long.Set.obj"
	-@erase "$(INTDIR)\long.SplaySet.obj"
	-@erase "$(INTDIR)\main.obj"
	-@erase "$(INTDIR)\msg_tbl.obj"
	-@erase "$(INTDIR)\ncpf.obj"
	-@erase "$(INTDIR)\newdoc.obj"
	-@erase "$(INTDIR)\osdummy.obj"
	-@erase "$(INTDIR)\pack.obj"
	-@erase "$(INTDIR)\pagefile.obj"
	-@erase "$(INTDIR)\pgfile.obj"
	-@erase "$(INTDIR)\pl_crypt.obj"
	-@erase "$(INTDIR)\privbase.obj"
	-@erase "$(INTDIR)\profile.obj"
	-@erase "$(INTDIR)\progress.obj"
	-@erase "$(INTDIR)\pscreen.obj"
	-@erase "$(INTDIR)\ready.obj"
	-@erase "$(INTDIR)\recode.obj"
	-@erase "$(INTDIR)\refcol.obj"
	-@erase "$(INTDIR)\rev.obj"
	-@erase "$(INTDIR)\screen.obj"
	-@erase "$(INTDIR)\sets.obj"
	-@erase "$(INTDIR)\settings.obj"
	-@erase "$(INTDIR)\ssets.obj"
	-@erase "$(INTDIR)\stdbase.obj"
	-@erase "$(INTDIR)\store.obj"
	-@erase "$(INTDIR)\strcache.obj"
	-@erase "$(INTDIR)\streams.obj"
	-@erase "$(INTDIR)\streams_.obj"
	-@erase "$(INTDIR)\subname_index.obj"
	-@erase "$(INTDIR)\trees.obj"
	-@erase "$(INTDIR)\u_int32_t.Set.obj"
	-@erase "$(INTDIR)\u_int32_t.SplaySet.obj"
	-@erase "$(INTDIR)\u_int64_t.Set.obj"
	-@erase "$(INTDIR)\u_int64_t.SplaySet.obj"
	-@erase "$(INTDIR)\unifname.obj"
	-@erase "$(INTDIR)\unzip.obj"
	-@erase "$(INTDIR)\vapi.obj"
	-@erase "$(INTDIR)\vc60.idb"
	-@erase "$(INTDIR)\zutil.obj"
	-@erase "$(OUTDIR)\gm.exe"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP=xicl6.exe
CPP_PROJ=/nologo /G4 /Zp1 /ML /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS" /Fp"$(INTDIR)\gm.pch" /YX /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

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

RSC=rc.exe
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\gm.bsc" 
BSC32_SBRS= \
	
LINK32=xilink6.exe
LINK32_FLAGS=/nologo /subsystem:console /incremental:no /pdb:"$(OUTDIR)\gm.pdb" /machine:I386 /out:"$(OUTDIR)\gm.exe" 
LINK32_OBJS= \
	"$(INTDIR)\attrs_index.obj" \
	"$(INTDIR)\aux_index.obj" \
	"$(INTDIR)\blob_index.obj" \
	"$(INTDIR)\cmdline.obj" \
	"$(INTDIR)\doc_index.obj" \
	"$(INTDIR)\gmmain.obj" \
	"$(INTDIR)\hier_index.obj" \
	"$(INTDIR)\idxmhlp.obj" \
	"$(INTDIR)\ind_merge.obj" \
	"$(INTDIR)\main.obj" \
	"$(INTDIR)\msg_tbl.obj" \
	"$(INTDIR)\progress.obj" \
	"$(INTDIR)\ready.obj" \
	"$(INTDIR)\settings.obj" \
	"$(INTDIR)\subname_index.obj" \
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
	"$(INTDIR)\u_int64_t.SplaySet.obj"

"$(OUTDIR)\gm.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ELSEIF  "$(CFG)" == "gm - Win32 Debug"

OUTDIR=.\Debug
INTDIR=.\Debug
# Begin Custom Macros
OutDir=.\Debug
# End Custom Macros

ALL : "$(OUTDIR)\gm.exe" "$(OUTDIR)\gm.bsc"


CLEAN :
	-@erase "$(INTDIR)\adler32.obj"
	-@erase "$(INTDIR)\adler32.sbr"
	-@erase "$(INTDIR)\advlog.obj"
	-@erase "$(INTDIR)\advlog.sbr"
	-@erase "$(INTDIR)\attrs_index.obj"
	-@erase "$(INTDIR)\attrs_index.sbr"
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
	-@erase "$(INTDIR)\gmmain.obj"
	-@erase "$(INTDIR)\gmmain.sbr"
	-@erase "$(INTDIR)\gsscreen.obj"
	-@erase "$(INTDIR)\gsscreen.sbr"
	-@erase "$(INTDIR)\hidxhlp.obj"
	-@erase "$(INTDIR)\hidxhlp.sbr"
	-@erase "$(INTDIR)\hier_index.obj"
	-@erase "$(INTDIR)\hier_index.sbr"
	-@erase "$(INTDIR)\hindex.obj"
	-@erase "$(INTDIR)\hindex.sbr"
	-@erase "$(INTDIR)\idxmhlp.obj"
	-@erase "$(INTDIR)\idxmhlp.sbr"
	-@erase "$(INTDIR)\ind_merge.obj"
	-@erase "$(INTDIR)\ind_merge.sbr"
	-@erase "$(INTDIR)\index.obj"
	-@erase "$(INTDIR)\index.sbr"
	-@erase "$(INTDIR)\index_.obj"
	-@erase "$(INTDIR)\index_.sbr"
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
	-@erase "$(INTDIR)\main.obj"
	-@erase "$(INTDIR)\main.sbr"
	-@erase "$(INTDIR)\msg_tbl.obj"
	-@erase "$(INTDIR)\msg_tbl.sbr"
	-@erase "$(INTDIR)\ncpf.obj"
	-@erase "$(INTDIR)\ncpf.sbr"
	-@erase "$(INTDIR)\newdoc.obj"
	-@erase "$(INTDIR)\newdoc.sbr"
	-@erase "$(INTDIR)\osdummy.obj"
	-@erase "$(INTDIR)\osdummy.sbr"
	-@erase "$(INTDIR)\pack.obj"
	-@erase "$(INTDIR)\pack.sbr"
	-@erase "$(INTDIR)\pagefile.obj"
	-@erase "$(INTDIR)\pagefile.sbr"
	-@erase "$(INTDIR)\pgfile.obj"
	-@erase "$(INTDIR)\pgfile.sbr"
	-@erase "$(INTDIR)\pl_crypt.obj"
	-@erase "$(INTDIR)\pl_crypt.sbr"
	-@erase "$(INTDIR)\privbase.obj"
	-@erase "$(INTDIR)\privbase.sbr"
	-@erase "$(INTDIR)\profile.obj"
	-@erase "$(INTDIR)\profile.sbr"
	-@erase "$(INTDIR)\progress.obj"
	-@erase "$(INTDIR)\progress.sbr"
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
	-@erase "$(INTDIR)\sets.obj"
	-@erase "$(INTDIR)\sets.sbr"
	-@erase "$(INTDIR)\settings.obj"
	-@erase "$(INTDIR)\settings.sbr"
	-@erase "$(INTDIR)\ssets.obj"
	-@erase "$(INTDIR)\ssets.sbr"
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
	-@erase "$(INTDIR)\subname_index.obj"
	-@erase "$(INTDIR)\subname_index.sbr"
	-@erase "$(INTDIR)\trees.obj"
	-@erase "$(INTDIR)\trees.sbr"
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
	-@erase "$(INTDIR)\vapi.obj"
	-@erase "$(INTDIR)\vapi.sbr"
	-@erase "$(INTDIR)\vc60.idb"
	-@erase "$(INTDIR)\vc60.pdb"
	-@erase "$(INTDIR)\zutil.obj"
	-@erase "$(INTDIR)\zutil.sbr"
	-@erase "$(OUTDIR)\gm.bsc"
	-@erase "$(OUTDIR)\gm.exe"
	-@erase "$(OUTDIR)\gm.ilk"
	-@erase "$(OUTDIR)\gm.pdb"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP=xicl6.exe
CPP_PROJ=/nologo /G5 /Zp1 /ML /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /D "WIN32" /D "_DEBUG" /D "_CONSOLE" /D "_MBCS" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\gm.pch" /YX /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

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

RSC=rc.exe
BSC32=bscmake.exe
BSC32_FLAGS=/nologo /o"$(OUTDIR)\gm.bsc" 
BSC32_SBRS= \
	"$(INTDIR)\attrs_index.sbr" \
	"$(INTDIR)\aux_index.sbr" \
	"$(INTDIR)\blob_index.sbr" \
	"$(INTDIR)\cmdline.sbr" \
	"$(INTDIR)\doc_index.sbr" \
	"$(INTDIR)\gmmain.sbr" \
	"$(INTDIR)\hier_index.sbr" \
	"$(INTDIR)\idxmhlp.sbr" \
	"$(INTDIR)\ind_merge.sbr" \
	"$(INTDIR)\main.sbr" \
	"$(INTDIR)\msg_tbl.sbr" \
	"$(INTDIR)\progress.sbr" \
	"$(INTDIR)\ready.sbr" \
	"$(INTDIR)\settings.sbr" \
	"$(INTDIR)\subname_index.sbr" \
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

"$(OUTDIR)\gm.bsc" : "$(OUTDIR)" $(BSC32_SBRS)
    $(BSC32) @<<
  $(BSC32_FLAGS) $(BSC32_SBRS)
<<

LINK32=xilink6.exe
LINK32_FLAGS=oldnames.lib kernel32.lib libcd.lib /nologo /subsystem:console /incremental:yes /pdb:"$(OUTDIR)\gm.pdb" /debug /machine:I386 /nodefaultlib:"libc.lib" /nodefaultlib /out:"$(OUTDIR)\gm.exe" /pdbtype:sept 
LINK32_OBJS= \
	"$(INTDIR)\attrs_index.obj" \
	"$(INTDIR)\aux_index.obj" \
	"$(INTDIR)\blob_index.obj" \
	"$(INTDIR)\cmdline.obj" \
	"$(INTDIR)\doc_index.obj" \
	"$(INTDIR)\gmmain.obj" \
	"$(INTDIR)\hier_index.obj" \
	"$(INTDIR)\idxmhlp.obj" \
	"$(INTDIR)\ind_merge.obj" \
	"$(INTDIR)\main.obj" \
	"$(INTDIR)\msg_tbl.obj" \
	"$(INTDIR)\progress.obj" \
	"$(INTDIR)\ready.obj" \
	"$(INTDIR)\settings.obj" \
	"$(INTDIR)\subname_index.obj" \
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
	"$(INTDIR)\u_int64_t.SplaySet.obj"

"$(OUTDIR)\gm.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ENDIF 


!IF "$(NO_EXTERNAL_DEPS)" != "1"
!IF EXISTS("gm.dep")
!INCLUDE "gm.dep"
!ELSE 
!MESSAGE Warning: cannot find "gm.dep"
!ENDIF 
!ENDIF 


!IF "$(CFG)" == "gm - Win32 Release" || "$(CFG)" == "gm - Win32 Debug"
SOURCE=..\src\attrs_index.c

!IF  "$(CFG)" == "gm - Win32 Release"

CPP_SWITCHES=/nologo /G4 /Zp1 /ML /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS" /Fp"$(INTDIR)\gm.pch" /YX /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

"$(INTDIR)\attrs_index.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"

CPP_SWITCHES=/nologo /G5 /Zp1 /ML /Ze /W3 /Gm /Gi- /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "..\..\..\libs\gkdb\src" /I "..\..\..\libs\cchlp\src" /I "..\..\..\libs\gsscreen\src" /D "WIN32" /D "_DEBUG" /D "_CONSOLE" /D "_MBCS" /FR"$(INTDIR)\\" /Fp"$(INTDIR)\gm.pch" /YX /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

"$(INTDIR)\attrs_index.obj"	"$(INTDIR)\attrs_index.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) @<<
  $(CPP_SWITCHES) $(SOURCE)
<<


!ENDIF 

SOURCE=..\src\aux_index.c

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\aux_index.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\aux_index.obj"	"$(INTDIR)\aux_index.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\src\blob_index.c

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\blob_index.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\blob_index.obj"	"$(INTDIR)\blob_index.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\src\cmdline.c

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\cmdline.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\cmdline.obj"	"$(INTDIR)\cmdline.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\src\doc_index.c

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\doc_index.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\doc_index.obj"	"$(INTDIR)\doc_index.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\src\gmmain.c

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\gmmain.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\gmmain.obj"	"$(INTDIR)\gmmain.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\src\hier_index.c

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\hier_index.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\hier_index.obj"	"$(INTDIR)\hier_index.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\src\idxmhlp.c

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\idxmhlp.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\idxmhlp.obj"	"$(INTDIR)\idxmhlp.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\src\ind_merge.c

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\ind_merge.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\ind_merge.obj"	"$(INTDIR)\ind_merge.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\src\main.cpp

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\main.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\main.obj"	"$(INTDIR)\main.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\src\msg_tbl.c

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\msg_tbl.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\msg_tbl.obj"	"$(INTDIR)\msg_tbl.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\src\progress.cpp

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\progress.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\progress.obj"	"$(INTDIR)\progress.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\src\ready.cpp

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\ready.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\ready.obj"	"$(INTDIR)\ready.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\src\settings.c

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\settings.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\settings.obj"	"$(INTDIR)\settings.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\src\subname_index.c

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\subname_index.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\subname_index.obj"	"$(INTDIR)\subname_index.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\adler32.c

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\adler32.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\adler32.obj"	"$(INTDIR)\adler32.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\base.cpp

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\base.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\base.obj"	"$(INTDIR)\base.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\basemask.cpp

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\basemask.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\basemask.obj"	"$(INTDIR)\basemask.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\btiter.cpp

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\btiter.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\btiter.obj"	"$(INTDIR)\btiter.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\btree.cpp

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\btree.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\btree.obj"	"$(INTDIR)\btree.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\collect.cpp

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\collect.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\collect.obj"	"$(INTDIR)\collect.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\crc32.c

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\crc32.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\crc32.obj"	"$(INTDIR)\crc32.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\deflate.c

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\deflate.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\deflate.obj"	"$(INTDIR)\deflate.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\doccol.cpp

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\doccol.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\doccol.obj"	"$(INTDIR)\doccol.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\dociter.cpp

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\dociter.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\dociter.obj"	"$(INTDIR)\dociter.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\document.cpp

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\document.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\document.obj"	"$(INTDIR)\document.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\dummies.cpp

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\dummies.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\dummies.obj"	"$(INTDIR)\dummies.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\fltiter.cpp

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\fltiter.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\fltiter.obj"	"$(INTDIR)\fltiter.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\garutils.cpp

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\garutils.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\garutils.obj"	"$(INTDIR)\garutils.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\hindex.cpp

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\hindex.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\hindex.obj"	"$(INTDIR)\hindex.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\index.cpp

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\index.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\index.obj"	"$(INTDIR)\index.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\indices.cpp

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\indices.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\indices.obj"	"$(INTDIR)\indices.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\infblock.c

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\infblock.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\infblock.obj"	"$(INTDIR)\infblock.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\infcodes.c

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\infcodes.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\infcodes.obj"	"$(INTDIR)\infcodes.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\inffast.c

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\inffast.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\inffast.obj"	"$(INTDIR)\inffast.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\inflate.c

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\inflate.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\inflate.obj"	"$(INTDIR)\inflate.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\inftrees.c

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\inftrees.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\inftrees.obj"	"$(INTDIR)\inftrees.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\infutil.c

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\infutil.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\infutil.obj"	"$(INTDIR)\infutil.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\ncpf.cpp

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\ncpf.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\ncpf.obj"	"$(INTDIR)\ncpf.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\newdoc.cpp

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\newdoc.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\newdoc.obj"	"$(INTDIR)\newdoc.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\osdummy.c

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\osdummy.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\osdummy.obj"	"$(INTDIR)\osdummy.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\pack.c

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\pack.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\pack.obj"	"$(INTDIR)\pack.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\pagefile.cpp

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\pagefile.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\pagefile.obj"	"$(INTDIR)\pagefile.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\pl_crypt.c

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\pl_crypt.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\pl_crypt.obj"	"$(INTDIR)\pl_crypt.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\privbase.cpp

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\privbase.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\privbase.obj"	"$(INTDIR)\privbase.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\refcol.cpp

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\refcol.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\refcol.obj"	"$(INTDIR)\refcol.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\rev.cpp

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\rev.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\rev.obj"	"$(INTDIR)\rev.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\stdbase.cpp

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\stdbase.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\stdbase.obj"	"$(INTDIR)\stdbase.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\store.cpp

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\store.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\store.obj"	"$(INTDIR)\store.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\streams.cpp

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\streams.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\streams.obj"	"$(INTDIR)\streams.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\trees.c

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\trees.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\trees.obj"	"$(INTDIR)\trees.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\unzip.c

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\unzip.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\unzip.obj"	"$(INTDIR)\unzip.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gkdb\src\zutil.c

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\zutil.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\zutil.obj"	"$(INTDIR)\zutil.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\mrglib\src\bfind.c

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\bfind.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\bfind.obj"	"$(INTDIR)\bfind.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\mrglib\src\btree_.c

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\btree_.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\btree_.obj"	"$(INTDIR)\btree_.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\mrglib\src\cmpfunc.c

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\cmpfunc.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\cmpfunc.obj"	"$(INTDIR)\cmpfunc.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\mrglib\src\flog.c

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\flog.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\flog.obj"	"$(INTDIR)\flog.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\mrglib\src\gbase.c

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\gbase.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\gbase.obj"	"$(INTDIR)\gbase.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\mrglib\src\gberr.c

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\gberr.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\gberr.obj"	"$(INTDIR)\gberr.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\mrglib\src\globals.c

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\globals.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\globals.obj"	"$(INTDIR)\globals.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\mrglib\src\index_.c

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\index_.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\index_.obj"	"$(INTDIR)\index_.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\mrglib\src\iter.c

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\iter.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\iter.obj"	"$(INTDIR)\iter.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\mrglib\src\keyfile.c

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\keyfile.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\keyfile.obj"	"$(INTDIR)\keyfile.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\mrglib\src\pgfile.c

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\pgfile.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\pgfile.obj"	"$(INTDIR)\pgfile.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\mrglib\src\profile.c

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\profile.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\profile.obj"	"$(INTDIR)\profile.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\mrglib\src\sets.c

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\sets.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\sets.obj"	"$(INTDIR)\sets.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\mrglib\src\ssets.c

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\ssets.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\ssets.obj"	"$(INTDIR)\ssets.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\mrglib\src\strcache.c

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\strcache.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\strcache.obj"	"$(INTDIR)\strcache.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\mrglib\src\streams_.c

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\streams_.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\streams_.obj"	"$(INTDIR)\streams_.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\mrglib\src\unifname.c

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\unifname.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\unifname.obj"	"$(INTDIR)\unifname.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gsscreen\src\face.c

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\face.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\face.obj"	"$(INTDIR)\face.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gsscreen\src\gsscreen.cpp

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\gsscreen.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\gsscreen.obj"	"$(INTDIR)\gsscreen.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gsscreen\src\pscreen.cpp

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\pscreen.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\pscreen.obj"	"$(INTDIR)\pscreen.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\gsscreen\src\screen.c

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\screen.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\screen.obj"	"$(INTDIR)\screen.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\VControl\src\vapi.c

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\vapi.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\vapi.obj"	"$(INTDIR)\vapi.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\cchlp\src\advlog.cpp

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\advlog.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\advlog.obj"	"$(INTDIR)\advlog.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\cchlp\src\clTreeNode.Set.cpp

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\clTreeNode.Set.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\clTreeNode.Set.obj"	"$(INTDIR)\clTreeNode.Set.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\cchlp\src\clTreeNode.SplaySet.cpp

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\clTreeNode.SplaySet.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\clTreeNode.SplaySet.obj"	"$(INTDIR)\clTreeNode.SplaySet.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\cchlp\src\errhandler.cpp

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\errhandler.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\errhandler.obj"	"$(INTDIR)\errhandler.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\cchlp\src\FString.caddr_t.Map.cpp

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\FString.caddr_t.Map.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\FString.caddr_t.Map.obj"	"$(INTDIR)\FString.caddr_t.Map.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\cchlp\src\FString.caddr_t.SplayMap.cpp

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\FString.caddr_t.SplayMap.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\FString.caddr_t.SplayMap.obj"	"$(INTDIR)\FString.caddr_t.SplayMap.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\cchlp\src\hidxhlp.cpp

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\hidxhlp.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\hidxhlp.obj"	"$(INTDIR)\hidxhlp.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\cchlp\src\long.caddr_t.Map.cpp

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\long.caddr_t.Map.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\long.caddr_t.Map.obj"	"$(INTDIR)\long.caddr_t.Map.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\cchlp\src\long.caddr_t.SplayMap.cpp

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\long.caddr_t.SplayMap.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\long.caddr_t.SplayMap.obj"	"$(INTDIR)\long.caddr_t.SplayMap.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\cchlp\src\long.long.Map.cpp

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\long.long.Map.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\long.long.Map.obj"	"$(INTDIR)\long.long.Map.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\cchlp\src\long.long.SplayMap.cpp

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\long.long.SplayMap.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\long.long.SplayMap.obj"	"$(INTDIR)\long.long.SplayMap.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\cchlp\src\long.Set.cpp

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\long.Set.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\long.Set.obj"	"$(INTDIR)\long.Set.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\cchlp\src\long.SplaySet.cpp

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\long.SplaySet.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\long.SplaySet.obj"	"$(INTDIR)\long.SplaySet.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\cchlp\src\recode.cpp

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\recode.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\recode.obj"	"$(INTDIR)\recode.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\cchlp\src\u_int32_t.Set.cpp

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\u_int32_t.Set.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\u_int32_t.Set.obj"	"$(INTDIR)\u_int32_t.Set.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\cchlp\src\u_int32_t.SplaySet.cpp

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\u_int32_t.SplaySet.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\u_int32_t.SplaySet.obj"	"$(INTDIR)\u_int32_t.SplaySet.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\cchlp\src\u_int64_t.Set.cpp

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\u_int64_t.Set.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\u_int64_t.Set.obj"	"$(INTDIR)\u_int64_t.Set.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 

SOURCE=..\..\..\libs\cchlp\src\u_int64_t.SplaySet.cpp

!IF  "$(CFG)" == "gm - Win32 Release"


"$(INTDIR)\u_int64_t.SplaySet.obj" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ELSEIF  "$(CFG)" == "gm - Win32 Debug"


"$(INTDIR)\u_int64_t.SplaySet.obj"	"$(INTDIR)\u_int64_t.SplaySet.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


!ENDIF 


!ENDIF 

