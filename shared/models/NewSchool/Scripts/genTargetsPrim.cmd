del targets.script.list
findstr /M /C:"Stereotype st_ExeTarget" *.pas.ms.script>> targets.script.list
findstr /M /C:"Stereotype st_AdapterTarget" *.pas.ms.script>> targets.script.list
findstr /M /C:"Stereotype st_TestTarget" *.pas.ms.script>> targets.script.list
findstr /M /C:"Stereotype st_VCMTestTarget" *.pas.ms.script>> targets.script.list
findstr /M /C:"Stereotype st_VCMGUI" *.pas.ms.script>> targets.script.list
del targetstorun.script.list
for /f %%i in (targets.script.list) do echo %%i.runner>> targetstorun.script.list
call cal.cmd -list:targetstorun.script.list
