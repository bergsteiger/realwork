del C:\Temp\%~1.script.list
findstr /M /C:"Stereotype st_%~1" *.ms.model.script>> C:\Temp\%~1.script.list
del C:\Temp\run%~1.script.list
for /f %%i in (C:\Temp\%~1.script.list) do echo %%i.runner>> C:\Temp\run%~1.script.list
call cal.cmd -list:C:\Temp\run%~1.script.list "%~2"