REM CommandInterpreter: $(COMSPEC)
if defined ProgramFiles(x86) (
copy ..\..\Lib\C6\gtAdvGridExp*.bpl %windir%\SysWow64 > nul
) else (
if not "%OS%"=="Windows_NT" goto win9x
:winNT
copy ..\..\Lib\C6\gtAdvGridExp*.bpl %windir%\System32 > nul
goto finish
:win9x
copy ..\..\Lib\C6\gtAdvGridExp*.bpl %windir%\System > nul
:finish
echo ""
)