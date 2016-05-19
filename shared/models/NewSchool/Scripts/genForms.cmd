del forms.script.list
findstr /M /C:"Stereotype st_VCMForm" *.pas.ms.script>> forms.script.list
findstr /M /C:"Stereotype st_VCMFinalForm" *.pas.ms.script>> forms.script.list
findstr /M /C:"Stereotype st_VCMContainer" *.pas.ms.script>> forms.script.list
findstr /M /C:"Stereotype st_VCMFinalContainer" *.pas.ms.script>> forms.script.list
findstr /M /C:"Stereotype st_VCMMainForm" *.pas.ms.script>> forms.script.list
findstr /M /C:"Stereotype st_VCMFinalMainForm" *.pas.ms.script>> forms.script.list
del formstorun.script.list
for /f %%i in (forms.script.list) do echo %%i.runner>> formstorun.script.list
call cal.cmd -list:formstorun.script.list