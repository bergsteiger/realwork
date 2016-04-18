del %~1.script.list
findstr /M /C:"Stereotype st_%~1" *.pas.ms.script>> %~1.script.list
rem grep -l+ "Stereotype st_%~1" *.pas.ms.script>> %~1.script.list
del run%~1.script.list
for /f %%i in (%~1.script.list) do echo %%i.runner>> run%~1.script.list
call cal.cmd -list:run%~1.script.list