REM CommandInterpreter: $(ComSpec)
if not "%OS%"=="Windows_NT" goto win9x
:winNT
copy ..\Lib\D6\gtDocEng*.bpl %windir%\System32 > nul
goto finish
:win9x
copy ..\Lib\D6\gtDocEng*.bpl %windir%\System > nul
:finish

MOVE /y *.obj ..\Lib\D6
MOVE /y *.hpp ..\Lib\D6
ren gtDocEngD6.dpk.lib gtDocEngD6.lib 
ren DCLgtDocEngD6.dpk.lib DCLgtDocEngD6.lib 
ren gtDocEngD6.dpk.lsp gtDocEngD6.lsp
ren DCLgtDocEngD6.dpk.lsp DCLgtDocEngD6.lsp 
MOVE /y *.lib ..\Lib\D6
MOVE /y *.lsp ..\Lib\D6
