del %~1Used.script.list
findstr /M /C:"CONST Name '%~1'" *.pas.ms.script>> %~1Used.script.list
findstr /M /C:"CONST extprop:pas:TypeName '%~1'" *.pas.ms.script>> %~1Used.script.list
findstr /M /C:"CONST UID '%~1'" *.pas.ms.script>> %~1Used.script.list
findstr /M /C:"// %~1" *.pas.ms.script>> %~1Used.script.list
rem grep -l+ "'%~1'" *.pas.ms.script > %~1Used.script.list
del run%~1Used.script.list
for /f %%i in (%~1Used.script.list) do echo %%i.runner>> run%~1Used.script.list
call cal.cmd -list:run%~1Used.script.list