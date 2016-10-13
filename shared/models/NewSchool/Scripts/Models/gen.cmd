del C:\Temp\%~1.script.list
findstr /M /C:"CONST Name '%~1'" *.ms.model.script>> C:\Temp\%~1.script.list
findstr /M /C:"CONST OriginalName '%~1'" *.ms.model.script>> C:\Temp\%~1.script.list
findstr /M /C:"CONST extprop:pas:TypeName '%~1'" *.ms.model.script>> C:\Temp\%~1.script.list
findstr /M /C:"CONST UID '%~1'" *.ms.model.script>> C:\Temp\%~1.script.list
findstr /M /C:"MEPROP Name '%~1'" *.ms.model.script>> C:\Temp\%~1.script.list
findstr /M /C:"MEPROP OriginalName '%~1'" *.ms.model.script>> C:\Temp\%~1.script.list
findstr /M /C:"MEPROP extprop:pas:TypeName '%~1'" *.ms.model.script>> C:\Temp\%~1.script.list
findstr /M /C:"MEPROP UID '%~1'" *.ms.model.script>> C:\Temp\%~1.script.list
del C:\Temp\run%~1.script.list
for /f %%i in (C:\Temp\%~1.script.list) do echo %%i.runner>> C:\Temp\run%~1.script.list
call cal.cmd -list:C:\Temp\run%~1.script.list "%~2"