REM CommandInterpreter: $(ComSpec)
if not "%OS%"=="Windows_NT" goto win9x
:winNT
copy ..\Lib\D2005\gtDocEng*.bpl %windir%\System32 > nul
goto finish
:win9x
copy ..\Lib\D2005\gtDocEng*.bpl %windir%\System > nul
:finish

MOVE /y *.obj ..\Lib\D2005
MOVE /y *.hpp ..\Lib\D2005
ren gtDocEngD9.dpk.lib gtDocEngD9.lib 
ren DCLgtDocEngD9.dpk.lib DCLgtDocEngD9.lib 
ren gtDocEngD9.dpk.lsp gtDocEngD9.lsp
ren DCLgtDocEngD9.dpk.lsp DCLgtDocEngD9.lsp 
MOVE /y *.lib ..\Lib\D2005
MOVE /y *.lsp ..\Lib\D2005
