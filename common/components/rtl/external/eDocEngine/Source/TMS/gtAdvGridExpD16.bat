REM CommandInterpreter: $(ComSpec)
if defined ProgramFiles(x86) (
copy ..\..\Lib\RADXE2\Win64\gtAdvGridExp*.bpl %windir%\SysWow64 > nul
) else (
if not "%OS%"=="Windows_NT" goto win9x
:winNT
copy ..\..\Lib\RADXE2\Win32\gtAdvGridExp*.bpl %windir%\System32 > nul
goto finish
:win9x
copy ..\..\Lib\RADXE2\Win32\gtAdvGridExp*.bpl %windir%\System > nul
:finish
echo ""
)