del %~1.script.list
findstr /M /C:"CONST Name '%~1'" *.pas.ms.script>> %~1.script.list
findstr /M /C:"CONST extprop:pas:TypeName '%~1'" *.pas.ms.script>> %~1.script.list
findstr /M /C:"CONST UID '%~1'" *.pas.ms.script>> %~1.script.list
rem grep -l+ "'%~1'" *.pas.ms.script > %~1.script.list
del run%~1.script.list
for /f %%i in (%~1.script.list) do echo %%i.runner>> run%~1.script.list
call cal.cmd -list:run%~1.script.list