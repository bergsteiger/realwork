REM CommandInterpreter: $(ComSpec)
if not "%OS%"=="Windows_NT" goto win9x
:winNT
copy ..\Lib\C5\gtDocEng*.bpl %windir%\System32 > nul
goto finish
:win9x
copy ..\Lib\C5\gtDocEng*.bpl %windir%\System > nul
:finish

MOVE /y *.obj ..\Lib\C5
MOVE /y *.hpp ..\Lib\C5
ren gtDocEngD5.dpk.lib gtDocEngD5.lib 
ren DCLgtDocEngD5.dpk.lib DCLgtDocEngD5.lib 
ren gtDocEngD5.dpk.lsp gtDocEngD5.lsp
ren DCLgtDocEngD5.dpk.lsp DCLgtDocEngD5.lsp 
MOVE /y *.lib ..\Lib\C5
MOVE /y *.lsp ..\Lib\C5
