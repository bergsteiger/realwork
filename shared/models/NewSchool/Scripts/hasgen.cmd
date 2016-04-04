del hasgen.tmp
tasklist /FI "IMAGENAME eq callMSS.exe" /FO TABLE /NH >> hasgen.tmp
for /f %%i in (hasgen.tmp) do if /I %%i==callMSS.exe goto got

echo No gen running

goto exit

:got

echo Has gen running

:exit
del hasgen.tmp