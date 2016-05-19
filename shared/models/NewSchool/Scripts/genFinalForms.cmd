del finalForms.script.list
findstr /M /C:"Stereotype st_VCMFinalForm" *.pas.ms.script>> finalForms.script.list
findstr /M /C:"Stereotype st_VCMFinalContainer" *.pas.ms.script>> finalForms.script.list
findstr /M /C:"Stereotype st_VCMFinalMainForm" *.pas.ms.script>> finalForms.script.list
del finalFormstorun.script.list
for /f %%i in (finalForms.script.list) do echo %%i.runner>> finalFormstorun.script.list
call cal.cmd -list:finalFormstorun.script.list