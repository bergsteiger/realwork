SETLOCAL ENABLEDELAYEDEXPANSION
set tools=r:\develop.781\builds\%date%
set newsup=E:\compile78\newsuper
set tools_bash=r:/develop.781/builds/%date%
set maxpath=E:\compile78

cd /D c:\Etalon\maximum\

echo %date% %time% supers: gkdbcmp start >> logs\time
C:\cygwin\bin\bash --login C:\Etalon\scripts\gkdbcmp_new.sh E:\compile78\newsuper E:\compile78\etalon\newsuper E:\compile78\cmp_new.res %tools_bash%

echo %date% %time% supers: finish >> logs\time
