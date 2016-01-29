set tools=r:\develop.781\builds\%date%
set maxpath=E:\compile78

cd /D c:\Etalon\maximum\

del %maxpath%\tmp.*
del %maxpath%\base.*
del %maxpath%\max\base.*

echo %date% %time% makemax: gc start >> logs\time
%tools%\gc -f gc.ini %maxpath%\base
echo %date% %time% makemax: gl start >> logs\time
%tools%\gl -nofat %maxpath%\base
