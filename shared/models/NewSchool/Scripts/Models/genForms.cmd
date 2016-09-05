del forms.script.list
findstr /M /C:"Stereotype st_VCMForm" *.ms.model.script>> forms.script.list
findstr /M /C:"Stereotype st_VCMFinalForm" *.ms.model.script>> forms.script.list
findstr /M /C:"Stereotype st_VCMContainer" *.ms.model.script>> forms.script.list
findstr /M /C:"Stereotype st_VCMFinalContainer" *.ms.model.script>> forms.script.list
findstr /M /C:"Stereotype st_VCMMainForm" *.ms.model.script>> forms.script.list
findstr /M /C:"Stereotype st_VCMFinalMainForm" *.ms.model.script>> forms.script.list
del formstorun.script.list
for /f %%i in (forms.script.list) do echo %%i.runner>> formstorun.script.list
call cal.cmd -list:formstorun.script.list