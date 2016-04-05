pushd W:\shared\models\NewSchool\Scripts
del hasgen.tmp
tasklist /FI "IMAGENAME eq callMSS.exe" /FO TABLE /NH >> hasgen.tmp
for /f %%i in (hasgen.tmp) do if /I %%i==callMSS.exe goto got

echo No gen running
del changed.lst
echo ~>>changed.lst
del "%~1" /s /q

goto exit

:got

echo Has gen running

:exit
del hasgen.tmp
popd