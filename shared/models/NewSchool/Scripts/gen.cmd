del found.script.list
findstr /M /C:"CONST Name '%~1'" *.pas.ms.script>> found.script.list
findstr /M /C:"CONST extprop:pas:TypeName '%~1'" *.pas.ms.script>> found.script.list
findstr /M /C:"CONST UID '%~1'" *.pas.ms.script>> found.script.list
rem grep -l+ "'%~1'" *.pas.ms.script > found.script.list
del torun.script.list
for /f %%i in (found.script.list) do echo %%i.runner>> torun.script.list
call cal.cmd -list:torun.script.list