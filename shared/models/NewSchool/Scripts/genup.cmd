del C:\Temp\found.script.list
findstr /M /R /C:"CONST .%~1. %~2" *.pas.ms.script>> C:\Temp\found.script.list
del C:\Temp\torun.script.list
for /f %%i in (C:\Temp\found.script.list) do echo %%i.runner>> C:\Temp\torun.script.list
call cal.cmd -list:C:\Temp\torun.script.list