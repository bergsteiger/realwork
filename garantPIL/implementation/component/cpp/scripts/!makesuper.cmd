SETLOCAL ENABLEDELAYEDEXPANSION
set tools=r:\develop.781\builds\%date%
set oldsup=E:\compile78\oldsuper
set newsup=E:\compile78\newsuper
set maxpath=E:\compile78
set rev_date=09/02/2013

cd /D c:\Etalon\maximum\

set LIST=
for %%i in (%maxpath%\reg\*.ndt) do (
	set LIST=!LIST! %%~dpni
)

echo %date% %time% makesuper: newrefs2_part start >> logs\time
%tools%\newrefs2_part %maxpath%\reg\bus_law newrefs2_all.pp
echo %date% %time% makesuper: samedocs_part start >> logs\time
%tools%\samedocs_part %maxpath%\reg\bus_law -nocheck samedocs_Apell.final_prev samedocs_Court.final_prev samedocs_QA.final_prev > logs\samedocs_prev.log
echo %date% %time% makesuper: fixclass6 -copy start >> logs\time
%tools%\fixclass6 %oldsup% %maxpath%\reg\bus_law -copy
echo %date% %time% makesuper: fixannos -copy start >> logs\time
%tools%\fixannos -copy %oldsup% %maxpath%\reg\bus_law
echo %date% %time% makesuper: newcorrs2 start >> logs\time
%tools%\newcorrs2 -partswork super.nc %maxpath%\max\base %LIST%
echo %date% %time% makesuper: sort start >> logs\time
C:\cygwin\bin\sort -n < super.nc > super.nc_sorted
echo %date% %time% makesuper: newcorrs2_post start >> logs\time
%tools%\newcorrs2_post -newcorronly %maxpath%\reg\bus_law super.nc_sorted

del %newsup%.*

echo %date% %time% makesuper: hisync start >> logs\time
%tools%\hisync %maxpath%\max\base %LIST%
echo %date% %time% makesuper: gm start >> logs\time
%tools%\gm -o %newsup% %maxpath%\max\base %LIST%
::C:\Etalon\scripts\gdk78\win32\gm.exe -o %newsup% %maxpath%\max\base %LIST%

echo %date% %time% makesuper: addsyns start >> logs\time
for /F "delims=#" %%i in (syns_list1.txt) do (
	%tools%\addsyns %newsup% common.add\%%i
)
for /F "delims=#" %%i in (syns_list2.txt) do (
	%tools%\addsyns %newsup% %%i
)
echo %date% %time% makesuper: gchange start >> logs\time
for %%i in (aux_remove nal_add 233 256 arbbuh 78_197 sud_nal78 evd_78 aak pk_gz) do (
	%tools%\gchange %newsup% common.rul\%%i.rul -g -norecalc logs\gchange_sup_%%i.log
)

echo %date% %time% makesuper: gl start >> logs\time
%tools%\gl -nofat -w -a:50 %newsup%

echo %date% %time% makesuper: gctx start >> logs\time
%tools%\gctx -3 -m 450 %newsup% gctxparalens.txt invisiblelens.txt invisiblereles.txt
echo %date% %time% makesuper: gchange start >> logs\time
for %%i in (demo) do (
	%tools%\gchange %newsup% common.rul\%%i.rul -g -norecalc logs\gchange_sup_%%i.log
)

echo %date% %time% makesuper: kindcorr_regpart start >> logs\time
%tools%\kindcorr_regpart %newsup% > super.kc
echo %date% %time% makesuper: kindcorr_super start >> logs\time
%tools%\kindcorr_super %newsup% super.kc > newrefs2_all.part
echo %date% %time% makesuper: fixnames start >> logs\time
%tools%\fixnames %newsup% > logs\fixnames.log 2>&1
echo %date% %time% makesuper: iddchange start >> logs\time
%tools%\iddchange %newsup% > logs\iddchange.log
echo %date% %time% makesuper: fixannos start >> logs\time
%tools%\fixannos %newsup% -check > logs\fixannos.log 2>&1
echo %date% %time% makesuper: fixclass6 start >> logs\time
%tools%\fixclass6 %oldsup% %newsup%
echo %date% %time% makesuper: newcorrs2 start >> logs\time
%tools%\newcorrs2 %newsup% super.nc 6
echo %date% %time% makesuper: sort start >> logs\time
C:\cygwin\bin\sort -n < super.nc > super.nc_sorted
echo %date% %time% makesuper: newcorrs2_post start >> logs\time
%tools%\newcorrs2_post -infoonly %newsup% super.nc_sorted
echo %date% %time% makesuper: newrefs2_part start >> logs\time
%tools%\newrefs2_part -add newrefs2_all.part > newrefs2_all.pp
%tools%\newrefs2_part %newsup% newrefs2_all.pp > logs\newrefs2_part.log
echo %date% %time% makesuper: fixbases start >> logs\time
%tools%\fixbases %newsup% > logs\fixbases.log 2>&1
echo %date% %time% makesuper: addsyns start >> logs\time
for /F "delims=#" %%i in (syns_list3.txt) do (
	%tools%\addsyns %newsup% %%i
	if errorlevel 1 goto error
)

echo %date% %time% makesuper: samedocs Apell start >> logs\time
::!
::%tools%\samedocs Apell %oldsup% %newsup% 12 > logs\samedocs_A.log
echo %date% %time% makesuper: samedocs Court start >> logs\time
%tools%\samedocs Court %oldsup% %newsup% 6 > logs\samedocs_C.log
echo %date% %time% makesuper: samedocs QA start >> logs\time
%tools%\samedocs QA %oldsup% %newsup% 6 > logs\samedocs_Q.log
echo %date% %time% makesuper: samedocs merge start >> logs\time
%tools%\samedocs Apell-merge %oldsup% %newsup% samedocs_Apell_part0.next_week samedocs_Apell.final > logs\samedocs_A0.log
%tools%\samedocs Court-merge %oldsup% %newsup% samedocs_Court_part0.next_week samedocs_Court.final > logs\samedocs_C0.log
%tools%\samedocs QA-merge %oldsup% %newsup% samedocs_QA_part0.next_week samedocs_QA.final > logs\samedocs_Q0.log
echo %date% %time% makesuper: samedocs_part start >> logs\time
%tools%\samedocs_part %newsup% samedocs_Apell.final samedocs_Court.final samedocs_QA.final -delete > logs\samedocs.log

echo %date% %time% makesuper: gl start >> logs\time
%tools%\gl -nofat %newsup%

echo %date% %time% makesuper: calc_searchresults start >> logs\time
%tools%\calc_searchresults %newsup% common.add\example.txt common.add\mvariants.txt 6 calc.txt
echo %date% %time% makesuper: addsyns start >> logs\time
%tools%\addsyns %newsup% calc.txt CalcSearchResults

echo %date% %time% makesuper: fastrev_thr start >> logs\time
%tools%\fastrev_thr %oldsup% %newsup% -r:%rev_date% 6 > logs\fastrev.log
echo %date% %time% makesuper: fastrev start >> logs\time
%tools%\fastrev -s:%rev_date% %newsup% fastrev_thr.part
echo %date% %time% makesuper: grev -c start >> logs\time
%tools%\grev %oldsup% %newsup% -c:%rev_date%
