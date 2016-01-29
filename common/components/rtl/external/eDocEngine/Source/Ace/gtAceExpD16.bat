REM CommandInterpreter: $(ComSpec)
if defined ProgramFiles(x86) (
copy ..\..\Lib\RADXE2\Win64\gtAceExp*.bpl %windir%\SysWow64 > nul
) else (
if not "%OS%"=="Windows_NT" goto win9x
:winNT
copy ..\..\Lib\RADXE2\Win32\gtAceExp*.bpl %windir%\System32 > nul
goto finish
:win9x
copy ..\..\Lib\RADXE2\Win32\gtAceExp*.bpl %windir%\System > nul
:finish
echo ""
)

