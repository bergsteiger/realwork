SETLOCAL ENABLEDELAYEDEXPANSION
set tools=r:\develop.781\builds\%date%
set newsup=E:\compile78\newsuper
set tools_bash=r:/develop.781/builds/%date%
set maxpath=E:\compile78

cd /D c:\Etalon\maximum\

del e:\compile78\zr.*

echo %date% %time% zr: gsplit start >> logs\time
%tools%\gsplit -f gsplit.ini %newsup%
echo %date% %time% zr: gl start >> logs\time
%tools%\gl e:\compile78\zr
echo %date% %time% zr: gkdbcmp start >> logs\time
C:\cygwin\bin\bash --login C:\Etalon\scripts\gkdbcmp_zr.sh e:/compile78/zr e:/compile78/etalon/zr %maxpath%\cmp_zr.res %tools_bash%

echo %date% %time% zr: finish >> logs\time
