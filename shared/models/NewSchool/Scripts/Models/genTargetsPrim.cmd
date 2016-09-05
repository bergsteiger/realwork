del targets.script.list
findstr /M /C:"Stereotype st_ExeTarget" *.ms.model.script>> targets.script.list
findstr /M /C:"Stereotype st_AdapterTarget" *.ms.model.script>> targets.script.list
findstr /M /C:"Stereotype st_TestTarget" *.ms.model.script>> targets.script.list
findstr /M /C:"Stereotype st_VCMTestTarget" *.ms.model.script>> targets.script.list
findstr /M /C:"Stereotype st_VCMGUI" *.ms.model.script>> targets.script.list
del targetstorun.script.list
for /f %%i in (targets.script.list) do echo %%i.runner>> targetstorun.script.list
call cal.cmd -list:targetstorun.script.list
