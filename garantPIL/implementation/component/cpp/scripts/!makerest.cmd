set tools=r:\develop.781\builds\%date%
set oldsup=E:\compile78\oldsuper
set newbase=E:\compile78\base
set maxpath=E:\compile78
set rev_date=09/02/2013

cd /D c:\Etalon\maximum\

echo %date% %time% makerest: grev start >> logs\time
%tools%\grev.exe %newbase% -r:%rev_date%
%tools%\gsetrev %newbase%
echo %date% %time% makerest: enumparas start >> logs\time
%tools%\enumparas.exe %oldsup% %newbase% > logs\enumparas.log
echo %date% %time% makerest: newrefs start >> logs\time
%tools%\newrefs.exe %newbase% freebsd
echo %date% %time% makerest: copy start >> logs\time
copy %newbase%.* %maxpath%\tmp.*
echo %date% %time% makerest: convertor start >> logs\time
%tools%\convertor -type all -from %maxpath%\tmp -to %newbase% -editions edition.ref
echo %date% %time% makerest: kind_rules start >> logs\time
%tools%\kind_rules %newbase% common.add\78\kind.txt common.add\78\kind_rules.txt > logs\kind_rules_max.log
echo %date% %time% makerest: newrefs2 start >> logs\time
%tools%\newrefs2 %newbase%
echo %date% %time% makerest: gchange start >> logs\time
for %%r in (227 228 77_220 78_229 231 77_239 glavbuh74 77_237 36 77_29 78_all 78_remove) do (
	%tools%\gchange %newbase% common.rul\%%r.rul -g -norecalc logs\gchange_max_%%r.log
)
echo %date% %time% makerest: addsyns start >> logs\time
%tools%\addsyns %newbase% common.add\78\serv_rus.txt ServiceInfo
echo %date% %time% makerest: gl start >> logs\time
%tools%\gl -nofat %newbase%
echo %date% %time% makerest: move start >> logs\time
mkdir %maxpath%\max\
move %newbase%.* %maxpath%\max\
