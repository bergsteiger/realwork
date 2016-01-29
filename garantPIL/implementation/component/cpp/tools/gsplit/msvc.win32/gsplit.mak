# Microsoft Developer Studio Generated NMAKE File, Based on gsplit.dsp
!IF "$(CFG)" == ""
CFG=gsplit - Win32 Debug
!MESSAGE No configuration specified. Defaulting to gsplit - Win32 Debug.
!ENDIF 

!IF "$(CFG)" != "gsplit - Win32 Release" && "$(CFG)" != "gsplit - Win32 Debug"
!MESSAGE Invalid configuration "$(CFG)" specified.
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "gsplit.mak" CFG="gsplit - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "gsplit - Win32 Release" (based on "Win32 (x86) Console Application")
!MESSAGE "gsplit - Win32 Debug" (based on "Win32 (x86) Console Application")
!MESSAGE 
!ERROR An invalid configuration is specified.
!ENDIF 

!IF "$(OS)" == "Windows_NT"
NULL=
!ELSE 
NULL=nul
!ENDIF 

!IF  "$(CFG)" == "gsplit - Win32 Release"

OUTDIR=.\Release
INTDIR=.\Release
# Begin Custom Macros
OutDir=.\Release
# End Custom Macros

ALL : "$(OUTDIR)\gsplit.exe" "$(OUTDIR)\gsplit.bsc"


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
	-@erase "$(INTDIR)\sets.obj"
	-@erase "$(INTDIR)\sets.sbr"
	-@erase "$(INTDIR)\split_index.obj"
	-@erase "$(INTDIR)\split_index.sbr"
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
	-@erase "$(INTDIR)\subname.obj"
	-@erase "$(INTDIR)\subname.sbr"
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
	-@erase "$(INTDIR)\usage.obj"
	-@erase "$(INTDIR)\usage.sbr"
	-@erase "$(INTDIR)\vapi.obj"
	-@erase "$(INTDIR)\vapi.sbr"
	-@erase "$(INTDIR)\vc60.idb"
	-@erase "$(INTDIR)\zutil.obj"
	-@erase "$(INTDIR)\zutil.sbr"
	-@erase "$(OUTDIR)\gsplit.bsc"
	-@erase "$(OUTDIR)\gsplit.exe"
	-@erase "$(OUTDIR)\gsplit.ilk"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP=cl.exe
CPP_PROJ=/G4 /Zp1 /ML /W3 /Gi /GX /O2 /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /D "WIN32" /D "NDEBUG" /D "_CONSOLE" /D "_MBCS" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /c 

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
BSC32_FLAGS=/nologo /o"$(OUTDIR)\gsplit.bsc" 
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
	"$(INTDIR)\main.sbr" \
	"$(INTDIR)\msg_tbl.sbr" \
	"$(INTDIR)\ready.sbr" \
	"$(INTDIR)\segfile.sbr" \
	"$(INTDIR)\split_index.sbr" \
	"$(INTDIR)\subname.sbr" \
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

"$(OUTDIR)\gsplit.bsc" : "$(OUTDIR)" $(BSC32_SBRS)
    $(BSC32) @<<
  $(BSC32_FLAGS) $(BSC32_SBRS)
<<

LINK32=link.exe
LINK32_FLAGS=/nologo /subsystem:console /incremental:yes /pdb:"$(OUTDIR)\gsplit.pdb" /machine:I386 /out:"$(OUTDIR)\gsplit.exe" 
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
	"$(INTDIR)\main.obj" \
	"$(INTDIR)\msg_tbl.obj" \
	"$(INTDIR)\ready.obj" \
	"$(INTDIR)\segfile.obj" \
	"$(INTDIR)\split_index.obj" \
	"$(INTDIR)\subname.obj" \
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
	"$(INTDIR)\u_int64_t.SplaySet.obj"

"$(OUTDIR)\gsplit.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ELSEIF  "$(CFG)" == "gsplit - Win32 Debug"

OUTDIR=.\Debug
INTDIR=.\Debug
# Begin Custom Macros
OutDir=.\Debug
# End Custom Macros

ALL : "$(OUTDIR)\gsplit.exe" "$(OUTDIR)\gsplit.bsc"


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
	-@erase "$(INTDIR)\sets.obj"
	-@erase "$(INTDIR)\sets.sbr"
	-@erase "$(INTDIR)\split_index.obj"
	-@erase "$(INTDIR)\split_index.sbr"
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
	-@erase "$(INTDIR)\subname.obj"
	-@erase "$(INTDIR)\subname.sbr"
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
	-@erase "$(INTDIR)\usage.obj"
	-@erase "$(INTDIR)\usage.sbr"
	-@erase "$(INTDIR)\vapi.obj"
	-@erase "$(INTDIR)\vapi.sbr"
	-@erase "$(INTDIR)\vc60.idb"
	-@erase "$(INTDIR)\vc60.pdb"
	-@erase "$(INTDIR)\zutil.obj"
	-@erase "$(INTDIR)\zutil.sbr"
	-@erase "$(OUTDIR)\gsplit.bsc"
	-@erase "$(OUTDIR)\gsplit.exe"
	-@erase "$(OUTDIR)\gsplit.ilk"
	-@erase "$(OUTDIR)\gsplit.pdb"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP=cl.exe
CPP_PROJ=/G5 /Zp1 /ML /W3 /Gm /Gi /GX /ZI /Od /I "../../../include/msvc32" /I "../../../include" /I "../../../libs/gkdb/src" /I "../../../libs/mrglib/src" /I "../../../libs/gsscreen/src" /I "../../../libs/cchlp/src" /I "../../../libs/gc/src" /D "WIN32" /D "_DEBUG" /D "_CONSOLE" /D "_MBCS" /FR"$(INTDIR)\\" /Fo"$(INTDIR)\\" /Fd"$(INTDIR)\\" /FD /GZ /c 

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
BSC32_FLAGS=/nologo /o"$(OUTDIR)\gsplit.bsc" 
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
	"$(INTDIR)\main.sbr" \
	"$(INTDIR)\msg_tbl.sbr" \
	"$(INTDIR)\ready.sbr" \
	"$(INTDIR)\segfile.sbr" \
	"$(INTDIR)\split_index.sbr" \
	"$(INTDIR)\subname.sbr" \
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

"$(OUTDIR)\gsplit.bsc" : "$(OUTDIR)" $(BSC32_SBRS)
    $(BSC32) @<<
  $(BSC32_FLAGS) $(BSC32_SBRS)
<<

LINK32=link.exe
LINK32_FLAGS=oldnames.lib kernel32.lib libcd.lib /nologo /stack:0x64,0xa /subsystem:console /incremental:yes /pdb:"$(OUTDIR)\gsplit.pdb" /debug /machine:I386 /nodefaultlib:"libc.lib" /nodefaultlib /out:"$(OUTDIR)\gsplit.exe" 
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
	"$(INTDIR)\main.obj" \
	"$(INTDIR)\msg_tbl.obj" \
	"$(INTDIR)\ready.obj" \
	"$(INTDIR)\segfile.obj" \
	"$(INTDIR)\split_index.obj" \
	"$(INTDIR)\subname.obj" \
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
	"$(INTDIR)\u_int64_t.SplaySet.obj"

"$(OUTDIR)\gsplit.exe" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ENDIF 


!IF "$(NO_EXTERNAL_DEPS)" != "1"
!IF EXISTS("gsplit.dep")
!INCLUDE "gsplit.dep"
!ELSE 
!MESSAGE Warning: cannot find "gsplit.dep"
!ENDIF 
!ENDIF 


!IF "$(CFG)" == "gsplit - Win32 Release" || "$(CFG)" == "gsplit - Win32 Debug"
SOURCE=..\src\attr_index.c

"$(INTDIR)\attr_index.obj"	"$(INTDIR)\attr_index.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\src\aux_index.c

"$(INTDIR)\aux_index.obj"	"$(INTDIR)\aux_index.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\src\blob_index.c

"$(INTDIR)\blob_index.obj"	"$(INTDIR)\blob_index.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\src\cmdline.c

"$(INTDIR)\cmdline.obj"	"$(INTDIR)\cmdline.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\src\cr_index.c

"$(INTDIR)\cr_index.obj"	"$(INTDIR)\cr_index.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\src\doc_index.c

"$(INTDIR)\doc_index.obj"	"$(INTDIR)\doc_index.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\src\doclist.c

"$(INTDIR)\doclist.obj"	"$(INTDIR)\doclist.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\gctools\src\glproc.cpp

"$(INTDIR)\glproc.obj"	"$(INTDIR)\glproc.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\src\hc_index.c

"$(INTDIR)\hc_index.obj"	"$(INTDIR)\hc_index.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\src\hier_index.c

"$(INTDIR)\hier_index.obj"	"$(INTDIR)\hier_index.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\src\hind_collect.c

"$(INTDIR)\hind_collect.obj"	"$(INTDIR)\hind_collect.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\src\indhlp.c

"$(INTDIR)\indhlp.obj"	"$(INTDIR)\indhlp.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\src\main.c

"$(INTDIR)\main.obj"	"$(INTDIR)\main.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\src\msg_tbl.c

"$(INTDIR)\msg_tbl.obj"	"$(INTDIR)\msg_tbl.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\src\ready.cpp

"$(INTDIR)\ready.obj"	"$(INTDIR)\ready.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\src\segfile.c

"$(INTDIR)\segfile.obj"	"$(INTDIR)\segfile.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\src\split_index.c

"$(INTDIR)\split_index.obj"	"$(INTDIR)\split_index.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\src\subname.c

"$(INTDIR)\subname.obj"	"$(INTDIR)\subname.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\src\usage.c

"$(INTDIR)\usage.obj"	"$(INTDIR)\usage.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gkdb\src\adler32.c

"$(INTDIR)\adler32.obj"	"$(INTDIR)\adler32.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gkdb\src\base.cpp

"$(INTDIR)\base.obj"	"$(INTDIR)\base.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gkdb\src\basemask.cpp

"$(INTDIR)\basemask.obj"	"$(INTDIR)\basemask.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gkdb\src\btiter.cpp

"$(INTDIR)\btiter.obj"	"$(INTDIR)\btiter.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gkdb\src\btree.cpp

"$(INTDIR)\btree.obj"	"$(INTDIR)\btree.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gkdb\src\collect.cpp

"$(INTDIR)\collect.obj"	"$(INTDIR)\collect.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gkdb\src\crc32.c

"$(INTDIR)\crc32.obj"	"$(INTDIR)\crc32.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gkdb\src\deflate.c

"$(INTDIR)\deflate.obj"	"$(INTDIR)\deflate.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gkdb\src\doccol.cpp

"$(INTDIR)\doccol.obj"	"$(INTDIR)\doccol.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gkdb\src\dociter.cpp

"$(INTDIR)\dociter.obj"	"$(INTDIR)\dociter.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gkdb\src\document.cpp

"$(INTDIR)\document.obj"	"$(INTDIR)\document.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gkdb\src\dummies.cpp

"$(INTDIR)\dummies.obj"	"$(INTDIR)\dummies.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gkdb\src\fltiter.cpp

"$(INTDIR)\fltiter.obj"	"$(INTDIR)\fltiter.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gkdb\src\garutils.cpp

"$(INTDIR)\garutils.obj"	"$(INTDIR)\garutils.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gkdb\src\hindex.cpp

"$(INTDIR)\hindex.obj"	"$(INTDIR)\hindex.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gkdb\src\index.cpp

"$(INTDIR)\index.obj"	"$(INTDIR)\index.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gkdb\src\indices.cpp

"$(INTDIR)\indices.obj"	"$(INTDIR)\indices.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gkdb\src\infblock.c

"$(INTDIR)\infblock.obj"	"$(INTDIR)\infblock.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gkdb\src\infcodes.c

"$(INTDIR)\infcodes.obj"	"$(INTDIR)\infcodes.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gkdb\src\inffast.c

"$(INTDIR)\inffast.obj"	"$(INTDIR)\inffast.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gkdb\src\inflate.c

"$(INTDIR)\inflate.obj"	"$(INTDIR)\inflate.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gkdb\src\inftrees.c

"$(INTDIR)\inftrees.obj"	"$(INTDIR)\inftrees.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gkdb\src\infutil.c

"$(INTDIR)\infutil.obj"	"$(INTDIR)\infutil.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gkdb\src\ncpf.cpp

"$(INTDIR)\ncpf.obj"	"$(INTDIR)\ncpf.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gkdb\src\newdoc.cpp

"$(INTDIR)\newdoc.obj"	"$(INTDIR)\newdoc.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gkdb\src\osdummy.c

"$(INTDIR)\osdummy.obj"	"$(INTDIR)\osdummy.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gkdb\src\pack.c

"$(INTDIR)\pack.obj"	"$(INTDIR)\pack.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gkdb\src\pagefile.cpp

"$(INTDIR)\pagefile.obj"	"$(INTDIR)\pagefile.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gkdb\src\pl_crypt.c

"$(INTDIR)\pl_crypt.obj"	"$(INTDIR)\pl_crypt.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gkdb\src\privbase.cpp

"$(INTDIR)\privbase.obj"	"$(INTDIR)\privbase.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gkdb\src\refcol.cpp

"$(INTDIR)\refcol.obj"	"$(INTDIR)\refcol.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gkdb\src\rev.cpp

"$(INTDIR)\rev.obj"	"$(INTDIR)\rev.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gkdb\src\stdbase.cpp

"$(INTDIR)\stdbase.obj"	"$(INTDIR)\stdbase.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gkdb\src\store.cpp

"$(INTDIR)\store.obj"	"$(INTDIR)\store.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gkdb\src\streams.cpp

"$(INTDIR)\streams.obj"	"$(INTDIR)\streams.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gkdb\src\trees.c

"$(INTDIR)\trees.obj"	"$(INTDIR)\trees.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gkdb\src\unzip.c

"$(INTDIR)\unzip.obj"	"$(INTDIR)\unzip.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gkdb\src\zutil.c

"$(INTDIR)\zutil.obj"	"$(INTDIR)\zutil.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\mrglib\src\bfind.c

"$(INTDIR)\bfind.obj"	"$(INTDIR)\bfind.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\mrglib\src\btree_.c

"$(INTDIR)\btree_.obj"	"$(INTDIR)\btree_.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\mrglib\src\cmpfunc.c

"$(INTDIR)\cmpfunc.obj"	"$(INTDIR)\cmpfunc.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\mrglib\src\flog.c

"$(INTDIR)\flog.obj"	"$(INTDIR)\flog.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\mrglib\src\gbase.c

"$(INTDIR)\gbase.obj"	"$(INTDIR)\gbase.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\mrglib\src\gberr.c

"$(INTDIR)\gberr.obj"	"$(INTDIR)\gberr.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\mrglib\src\globals.c

"$(INTDIR)\globals.obj"	"$(INTDIR)\globals.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\mrglib\src\index_.c

"$(INTDIR)\index_.obj"	"$(INTDIR)\index_.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\mrglib\src\iter.c

"$(INTDIR)\iter.obj"	"$(INTDIR)\iter.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\mrglib\src\keyfile.c

"$(INTDIR)\keyfile.obj"	"$(INTDIR)\keyfile.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\mrglib\src\pgfile.c

"$(INTDIR)\pgfile.obj"	"$(INTDIR)\pgfile.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\mrglib\src\profile.c

"$(INTDIR)\profile.obj"	"$(INTDIR)\profile.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\mrglib\src\sets.c

"$(INTDIR)\sets.obj"	"$(INTDIR)\sets.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\mrglib\src\ssets.c

"$(INTDIR)\ssets.obj"	"$(INTDIR)\ssets.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\mrglib\src\strcache.c

"$(INTDIR)\strcache.obj"	"$(INTDIR)\strcache.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\mrglib\src\streams_.c

"$(INTDIR)\streams_.obj"	"$(INTDIR)\streams_.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\mrglib\src\unifname.c

"$(INTDIR)\unifname.obj"	"$(INTDIR)\unifname.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gsscreen\src\face.c

"$(INTDIR)\face.obj"	"$(INTDIR)\face.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gsscreen\src\gsscreen.cpp

"$(INTDIR)\gsscreen.obj"	"$(INTDIR)\gsscreen.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gsscreen\src\pscreen.cpp

"$(INTDIR)\pscreen.obj"	"$(INTDIR)\pscreen.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\gsscreen\src\screen.c

"$(INTDIR)\screen.obj"	"$(INTDIR)\screen.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\VControl\src\vapi.c

"$(INTDIR)\vapi.obj"	"$(INTDIR)\vapi.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\cchlp\src\advlog.cpp

"$(INTDIR)\advlog.obj"	"$(INTDIR)\advlog.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\cchlp\src\clTreeNode.Set.cpp

"$(INTDIR)\clTreeNode.Set.obj"	"$(INTDIR)\clTreeNode.Set.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\cchlp\src\clTreeNode.SplaySet.cpp

"$(INTDIR)\clTreeNode.SplaySet.obj"	"$(INTDIR)\clTreeNode.SplaySet.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\cchlp\src\errhandler.cpp

"$(INTDIR)\errhandler.obj"	"$(INTDIR)\errhandler.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\cchlp\src\FString.caddr_t.Map.cpp

"$(INTDIR)\FString.caddr_t.Map.obj"	"$(INTDIR)\FString.caddr_t.Map.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\cchlp\src\FString.caddr_t.SplayMap.cpp

"$(INTDIR)\FString.caddr_t.SplayMap.obj"	"$(INTDIR)\FString.caddr_t.SplayMap.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\cchlp\src\hidxhlp.cpp

"$(INTDIR)\hidxhlp.obj"	"$(INTDIR)\hidxhlp.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\cchlp\src\long.caddr_t.Map.cpp

"$(INTDIR)\long.caddr_t.Map.obj"	"$(INTDIR)\long.caddr_t.Map.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\cchlp\src\long.caddr_t.SplayMap.cpp

"$(INTDIR)\long.caddr_t.SplayMap.obj"	"$(INTDIR)\long.caddr_t.SplayMap.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\cchlp\src\long.long.Map.cpp

"$(INTDIR)\long.long.Map.obj"	"$(INTDIR)\long.long.Map.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\cchlp\src\long.long.SplayMap.cpp

"$(INTDIR)\long.long.SplayMap.obj"	"$(INTDIR)\long.long.SplayMap.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\cchlp\src\long.Set.cpp

"$(INTDIR)\long.Set.obj"	"$(INTDIR)\long.Set.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\cchlp\src\long.SplaySet.cpp

"$(INTDIR)\long.SplaySet.obj"	"$(INTDIR)\long.SplaySet.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\cchlp\src\recode.cpp

"$(INTDIR)\recode.obj"	"$(INTDIR)\recode.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\cchlp\src\u_int32_t.Set.cpp

"$(INTDIR)\u_int32_t.Set.obj"	"$(INTDIR)\u_int32_t.Set.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\cchlp\src\u_int32_t.SplaySet.cpp

"$(INTDIR)\u_int32_t.SplaySet.obj"	"$(INTDIR)\u_int32_t.SplaySet.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\cchlp\src\u_int64_t.Set.cpp

"$(INTDIR)\u_int64_t.Set.obj"	"$(INTDIR)\u_int64_t.Set.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)


SOURCE=..\..\..\libs\cchlp\src\u_int64_t.SplaySet.cpp

"$(INTDIR)\u_int64_t.SplaySet.obj"	"$(INTDIR)\u_int64_t.SplaySet.sbr" : $(SOURCE) "$(INTDIR)"
	$(CPP) $(CPP_PROJ) $(SOURCE)



!ENDIF 

