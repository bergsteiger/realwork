call clear.cmd
del *.out
for %%i in ( *.ms.script ) do call c.cmd %%i
call clearempty.cmd