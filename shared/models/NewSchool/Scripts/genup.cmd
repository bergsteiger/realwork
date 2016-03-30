del found.script.list
findstr /M /R /C:"CONST .%~1. %~2" *.pas.ms.script>> found.script.list
rem grep -l+ "Stereotype st_%~1" *.pas.ms.script>> found.script.list
del torun.script.list
for /f %%i in (found.script.list) do echo %%i.runner>> torun.script.list
call cal.cmd -list:torun.script.list