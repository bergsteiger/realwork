SETLOCAL ENABLEDELAYEDEXPANSION
set tools=r:\develop.781\builds\%date%
set tools_bash=r:/develop.781/builds/%date%
set oldsup=E:\compile78\oldsuper
set newsup=E:\compile78\newsuper
set maxpath=E:\compile78

cd /D c:\Etalon\maximum\

echo Y | del delta\*.*

echo %date% %time% makedelta: gdlt -prepack start >> logs\time
%tools%\gdlt %oldsup% %newsup% -l:logs -d:delta -T:1 -i -cache -prepack
echo %date% %time% makedelta: gdlt -pack start >> logs\time
%tools%\gdlt %oldsup% %newsup% -l:logs -d:delta -T:1 -i -cachero -pack -n+
:: -threads:4

echo %date% %time% makedelta: gdm start >> logs\time
set LIST=
for %%i in (delta\*.D*) do (
	set LIST=!LIST! %%i
)
%tools%\gdm %maxpath%\MX %LIST%

for %%i in (%maxpath%\MX.D*) do (
	echo %date% %time% makedelta: gu start >> logs\time
	%tools%\gu %oldsup% %%i
)
echo %date% %time% makedelta: gl start >> logs\time
%tools%\gl -nofat %oldsup%
echo %date% %time% makedelta: gkdbcmp start >> logs\time
C:\cygwin\bin\bash --login C:\Etalon\scripts\gkdbcmp.sh %oldsup% %newsup% %maxpath%\cmp.res %tools_bash%

echo %date% %time% makedelta: finish >> logs\time
