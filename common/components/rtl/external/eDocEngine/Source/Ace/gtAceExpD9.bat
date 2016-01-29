REM CommandInterpreter: $(ComSpec)
if defined ProgramFiles(x86) (
copy ..\..\Lib\D2005\gtAceExp*.bpl %windir%\SysWow64 > nul
) else (
if not "%OS%"=="Windows_NT" goto win9x
:winNT
copy ..\..\Lib\D2005\gtAceExp*.bpl %windir%\System32 > nul
goto finish
:win9x
copy ..\..\Lib\D2005\gtAceExp*.bpl %windir%\System > nul
:finish
echo ""
)
