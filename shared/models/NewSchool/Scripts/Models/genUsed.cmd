del C:\Temp\%~1Used.script.list
findstr /M /C:"CONST Name '%~1'" *.ms.model.script>> C:\Temp\%~1Used.script.list
findstr /M /C:"CONST extprop:pas:TypeName '%~1'" *.ms.model.script>> C:\Temp\%~1Used.script.list
findstr /M /C:"CONST UID '%~1'" *.ms.model.script>> C:\Temp\%~1Used.script.list
findstr /M /C:"MEPROP Name '%~1'" *.ms.model.script>> C:\Temp\%~1Used.script.list
findstr /M /C:"MEPROP extprop:pas:TypeName '%~1'" *.ms.model.script>> C:\Temp\%~1Used.script.list
findstr /M /C:"MEPROP UID '%~1'" *.ms.model.script>> C:\Temp\%~1Used.script.list
findstr /M /C:"// %~1" *.ms.model.script>> C:\Temp\%~1Used.script.list
findstr /M /C:"%~1.ms.model.script" *.ms.model.script>> C:\Temp\%~1Used.script.list
del C:\Temp\run%~1Used.script.list
for /f %%i in (C:\Temp\%~1Used.script.list) do echo %%i.runner>> C:\Temp\run%~1Used.script.list
call cal.cmd -list:C:\Temp\run%~1Used.script.list