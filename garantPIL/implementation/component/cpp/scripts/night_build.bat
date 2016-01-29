echo %time% : night_build start >> c:\night_build.log
echo locked > R:\develop.781\builds\current\current.lock
subst w: /D
subst x: /D
subst x: C:\Disks\X\msvc9\winnt+stlport
mkdir c:\builds\%date%
mkdir r:\develop.781\builds\%date%
mkdir r:\develop.781\builds\%date%\64x
mkdir r:\develop.781\builds\%date%\vs12-64x
mkdir r:\develop.781\builds\%date%\other
copy R:\develop.781\builds\version.rps r:\develop.781\builds\%date%\
subst w: c:\builds\%date%
w:
cd \
echo %time% : cvs co start >> c:\night_build.log
cvs co shared/Adapters
cvs co shared/ChatLibrary 
cvs co shared/ContextSearch 
cvs co shared/Core 
cvs co shared/CoreSrv
cvs co shared/DB
cvs co shared/GCI
cvs co shared/GCL
cvs co shared/GDiff
cvs co shared/GSI
cvs co shared/Internet
cvs co shared/Morpho
cvs co shared/project
cvs co shared/Adapters/mlmaru
cvs co shared/XercesHelpers 
cvs co shared/support/mpc
cvs co garantServer/external
cvs co garantServer/model
cvs co garantServer/projects
cvs co garantServer/src
cvs co garantPIL/implementation/Projects
cvs co garantPIL/implementation/component/cpp/External
cvs co garantPIL/implementation/component/cpp/Garant
cvs co garantPIL/implementation/component/cpp/include
cvs co garantPIL/implementation/component/cpp/libs
cvs co garantPIL/implementation/component/cpp/tools
cvs co garantPIL/implementation/component/cpp/scripts
cvs co garant6x/implementation/Garant/GblAdapterLib 
cvs co garant6x/implementation/Garant/NemesisChatImplementation 
cvs co garant6x/implementation/Garant/project
cvs co common/components/rtl/Garant/EVD
cvs co garantPIL/implementation/component/cpp/garantCore
cvs co shared/jsoncpp
echo %time% : cvs co end >> c:\night_build.log
echo %time% : build win32 >> c:\night_build.log
c:
cd "C:\Program Files (x86)\Microsoft Visual Studio 9.0\Common7\IDE\"
start /wait devenv w:\garantPIL\implementation\Projects\garant_tools.sln /Build "Final|Win32"
echo %time% : copy win32 >> c:\night_build.log
copy w:\build\bin\Final_Static\*.* r:\develop.781\builds\%date%\
del w:\build /q /s
echo %time% : build clone win32 >> c:\night_build.log
start /wait devenv w:\garantPIL\implementation\Projects\GDK_on_NDTClone.sln /Build "Final|Win32" /project T_NSRC_Compiler
start /wait devenv w:\garantPIL\implementation\Projects\GDK_on_NDTClone.sln /Build "Final|Win32" /project T_NDT_ContextBuilder
rename w:\build\bin\Final_Static\gctx.exe gctx_clone.exe 
copy w:\build\bin\Final_Static\*.* r:\develop.781\builds\%date%\
echo %time% : copy clone 32 >> c:\night_build.log
del w:\build /q /s
subst x: /D
subst x: C:\Disks\X\msvc9\win64+stlport
echo %time% : build win64 >> c:\night_build.log
start /wait devenv w:\garantPIL\implementation\Projects\garant_tools.sln /Build "Final|x64" /project T_Gkdbcmp
start /wait devenv w:\garantPIL\implementation\Projects\garant_tools.sln /Build "Final|x64" /project T_Fix_newcorr
start /wait devenv w:\garantPIL\implementation\Projects\garant_tools.sln /Build "Final|x64" /project T_KindCorr_super
start /wait devenv w:\garantPIL\implementation\Projects\garant_tools.sln /Build "Final|x64" /project T_SearchProfiler
start /wait devenv w:\garantPIL\implementation\Projects\garant_tools.sln /Build "Final|x64" /project T_CSAdapter
start /wait devenv w:\garantPIL\implementation\Projects\garant_tools.sln /Build "Final|x64" /project T_Gdm
start /wait devenv w:\garantPIL\implementation\Projects\garant_tools.sln /Build "Final|x64" /project T_GGDlt
start /wait devenv w:\garantPIL\implementation\Projects\garant_tools.sln /Build "Final|x64" /project T_GSplit
start /wait devenv w:\garantPIL\implementation\Projects\garant_tools.sln /Build "Final|x64" /project T_GCCheck
start /wait devenv w:\garantPIL\implementation\Projects\garant_tools.sln /Build "Final|x64" /project T_RelCalculator
start /wait devenv w:\garantPIL\implementation\Projects\garant_tools.sln /Build "Final|x64" /project T_Kindcorr_regpart
start /wait devenv w:\garantPIL\implementation\Projects\garant_tools.sln /Build "Final|x64" /project T_CompareNwcntxtContext
start /wait devenv w:\garantPIL\implementation\Projects\garant_tools.sln /Build "Final|x64" /project T_GGU
start /wait devenv w:\garantPIL\implementation\Projects\garant_tools.sln /Build "Final|x64" /project T_CalcSearchResults
start /wait devenv w:\garantPIL\implementation\Projects\garant_tools.sln /Build "Final|x64" /project T_Fastrev_thr
echo %time% : build samedocs64 >> c:\night_build.log
start /wait devenv w:\garantPIL\implementation\Projects\garant_tools.sln /Build "Final|x64" /project T_Samedocs
echo %time% : copy win64 >> c:\night_build.log
copy w:\build\bin\Final_Static\SearchProfiler.exe r:\develop.781\builds\%date%\64x\
copy w:\build\bin\Final_Static\kindcorr_super.exe r:\develop.781\builds\%date%\64x\
copy w:\build\bin\Final_Static\RelCalculator.exe r:\develop.781\builds\%date%\64x\
copy w:\build\bin\Final_Static\CSAdapter.dll r:\develop.781\builds\%date%\64x\
copy w:\build\bin\Final_Static\samedocs.exe r:\develop.781\builds\%date%\64x\
copy w:\build\bin\Final_Static\gdm.exe r:\develop.781\builds\%date%\64x\
copy w:\build\bin\Final_Static\fix_newcorr.exe r:\develop.781\builds\%date%\64x\
copy w:\build\bin\Final_Static\gdlt.exe r:\develop.781\builds\%date%\64x\
copy w:\build\bin\Final_Static\gu.exe r:\develop.781\builds\%date%\64x\
copy w:\build\bin\Final_Static\gsplit.exe r:\develop.781\builds\%date%\64x\
copy w:\build\bin\Final_Static\gkdbcmp.exe r:\develop.781\builds\%date%\64x\
copy w:\build\bin\Final_Static\gc_check.exe r:\develop.781\builds\%date%\64x\
copy w:\build\bin\Final_Static\kindcorr_regpart.exe r:\develop.781\builds\%date%\64x\
copy w:\build\bin\Final_Static\compare_nwcntxt_context.exe r:\develop.781\builds\%date%\64x\
copy w:\build\bin\Final_Static\fastrev_thr.exe r:\develop.781\builds\%date%\64x\
copy w:\build\bin\Final_Static\calc_searchresults.exe r:\develop.781\builds\%date%\64x\
del w:\build /q /s
echo %time% : build clone 64 >> c:\night_build.log
start /wait devenv w:\garantPIL\implementation\Projects\garant_tools.sln /Build "Final|x64" /project T_GGDlt_clone
copy w:\build\bin\Final_Static\gdlt_clone.exe r:\develop.781\builds\%date%\64x\
del w:\build /q /s
start /wait devenv w:\garantPIL\implementation\Projects\GDK_on_NDTClone.sln /Build "Final|x64" /project T_NSRC_Compiler
start /wait devenv w:\garantPIL\implementation\Projects\GDK_on_NDTClone.sln /Build "Final|x64" /project T_NDT_ContextBuilder
echo %time% : copy clone 64 >> c:\night_build.log
copy w:\build\bin\Final_Static\gc.exe r:\develop.781\builds\%date%\64x\
copy w:\build\bin\Final_Static\gctx.exe r:\develop.781\builds\%date%\64x\
del w:\build /q /s
copy r:\develop.781\tools\win32\mlma32ru.dll r:\develop.781\builds\%date%\
copy r:\develop.781\tools\win64\mlma32ru.dll r:\develop.781\builds\%date%\64x\
move r:\develop.781\builds\%date%\ConnectedContexts.exe r:\develop.781\builds\%date%\other
move r:\develop.781\builds\%date%\InformDict.exe r:\develop.781\builds\%date%\other
move r:\develop.781\builds\%date%\MorphoAnalyzer.exe r:\develop.781\builds\%date%\other
move r:\develop.781\builds\%date%\RelCalculator.exe r:\develop.781\builds\%date%\other
move r:\develop.781\builds\%date%\EntryPointAnalyzer.exe r:\develop.781\builds\%date%\other
move r:\develop.781\builds\%date%\RequestRateAnalyzer.exe r:\develop.781\builds\%date%\other
move r:\develop.781\builds\%date%\RequestTransform.exe r:\develop.781\builds\%date%\other
move r:\develop.781\builds\%date%\SearchProfiler.exe r:\develop.781\builds\%date%\other
move r:\develop.781\builds\%date%\SynMake.exe r:\develop.781\builds\%date%\other
move r:\develop.781\builds\%date%\TypingErrorAnalyzer.exe r:\develop.781\builds\%date%\other
move r:\develop.781\builds\%date%\TypingErrors.exe r:\develop.781\builds\%date%\other
move r:\develop.781\builds\%date%\NormDef.exe r:\develop.781\builds\%date%\other
move r:\develop.781\builds\%date%\RDict.exe r:\develop.781\builds\%date%\other
move r:\develop.781\builds\%date%\search.exe r:\develop.781\builds\%date%\other
move r:\develop.781\builds\%date%\SearchProfiler.exe r:\develop.781\builds\%date%\other
move r:\develop.781\builds\%date%\TopLexemes.exe r:\develop.781\builds\%date%\other
move r:\develop.781\builds\%date%\stats.exe r:\develop.781\builds\%date%\other
ren R:\develop.781\builds\%date%\EndtConvertor.exe convertor.exe
echo %time% : -z >> c:\night_build.log
r:\develop.781\builds\%date%\64x\gc -z
r:\develop.781\builds\%date%\64x\gctx -z
r:\develop.781\builds\%date%\64x\gdlt -z
r:\develop.781\builds\%date%\64x\gu -z
r:\develop.781\builds\%date%\64x\gkdbcmp -z
r:\develop.781\builds\%date%\64x\gsplit -z
r:\develop.781\builds\%date%\64x\gc_check -z
r:\develop.781\builds\%date%\baseinfo -z
r:\develop.781\builds\%date%\gc -z
r:\develop.781\builds\%date%\gc_check -z
r:\develop.781\builds\%date%\gctx -z
r:\develop.781\builds\%date%\gdlt -z
r:\develop.781\builds\%date%\gkdbcmp -z
r:\develop.781\builds\%date%\gkdumpi -z
r:\develop.781\builds\%date%\gkdumpkw -z
r:\develop.781\builds\%date%\gkgetdoc -z
r:\develop.781\builds\%date%\gl -z
r:\develop.781\builds\%date%\gm -z
r:\develop.781\builds\%date%\gopt -z
r:\develop.781\builds\%date%\gpack -z
r:\develop.781\builds\%date%\gready -z
r:\develop.781\builds\%date%\gregtst -z
r:\develop.781\builds\%date%\grev -z
r:\develop.781\builds\%date%\gsetname -z
r:\develop.781\builds\%date%\gsetrev -z
r:\develop.781\builds\%date%\gstatus -z
r:\develop.781\builds\%date%\gsplit -z
r:\develop.781\builds\%date%\gu -z
r:\develop.781\builds\%date%\hisync -z

echo %time% : start vs12 >> c:\night_build.log
subst x: /D
subst x: C:\Disks\X\msvc12\win64
w:
cd \garantPIL\implementation\Projects\
echo %time% : mwc_comp >> c:\night_build.log
start /wait X:\support\bin\mwc_comp.bat garant_tools.mwc
c:
cd "C:\Program Files (x86)\Microsoft Visual Studio 12.0\Common7\IDE\" 
echo %time% : build vs12 >> c:\night_build.log
start /wait devenv w:\garantPIL\implementation\Projects\garant_tools.sln /Build "Final|x64" /project T_SearchProfiler
start /wait devenv w:\garantPIL\implementation\Projects\garant_tools.sln /Build "Final|x64" /project T_CSAdapter
echo %time% : copy vs12 >> c:\night_build.log
copy w:\build\bin\Final_Static\SearchProfiler.exe r:\develop.781\builds\%date%\vs12-64x\
copy w:\build\bin\Final_Static\CSAdapter.dll r:\develop.781\builds\%date%\vs12-64x\
del w:\build /q /s
subst x: /D
subst x: C:\Disks\X\msvc9\winnt+stlport
w:
cd W:\garantPIL\implementation\Projects 
del garant_tools.sln
cvs upd
c:
cd \
subst w: /D

echo %time% : copy to current >> c:\night_build.log
xcopy /S /Y r:\develop.781\builds\%date%\*.* r:\develop.781\builds\current\

echo %time% : copy to crdr >> c:\night_build.log
copy R:\develop.781\builds\current\CSAdapter.dll "T:\CRDR\Test F1\_Tools\" 
copy R:\develop.781\builds\current\mlma32ru.dll "T:\CRDR\Test F1\_Tools\" 
copy R:\develop.781\builds\current\other\SearchProfiler.exe "T:\CRDR\Test F1\_Tools\" 
copy R:\develop.781\builds\current\other\RelCalculator.exe "T:\CRDR\Test F1\_Tools\" 
copy R:\develop.781\builds\current\other\RequestTransform.exe "T:\CRDR\Test F1\_Tools\" 

copy R:\develop.781\builds\current\64x\CSAdapter.dll "T:\CRDR\Test F1\_Tools\64x" 
copy R:\develop.781\builds\current\64x\mlma32ru.dll "T:\CRDR\Test F1\_Tools\64x" 
copy R:\develop.781\builds\current\64x\RelCalculator.exe "T:\CRDR\Test F1\_Tools\64x" 

del R:\develop.781\builds\current\current.lock
echo %time% : night_build end >> c:\night_build.log
:finish
echo ------------------------------ >> c:\night_build.log
