REM CommandInterpreter: $(ComSpec)
if not "%OS%"=="Windows_NT" goto win9x
:winNT
copy ..\Lib\D7\gtDocEng*.bpl %windir%\System32 > nul
goto finish
:win9x
copy ..\Lib\D7\gtDocEng*.bpl %windir%\System > nul
:finish

MOVE /y *.obj ..\Lib\D7
MOVE /y *.hpp ..\Lib\D7
ren gtDocEngD7.dpk.lib gtDocEngD7.lib 
ren DCLgtDocEngD7.dpk.lib DCLgtDocEngD7.lib 
ren gtDocEngD7.dpk.lsp gtDocEngD7.lsp
ren DCLgtDocEngD7.dpk.lsp DCLgtDocEngD7.lsp 
MOVE /y *.lib ..\Lib\D7
MOVE /y *.lsp ..\Lib\D7
