REM CommandInterpreter: $(ComSpec)
if defined ProgramFiles(x86) (
copy ..\..\Lib\RADXE2\Win64\gtRaveExp*.bpl %windir%\SysWow64 > nul
) else (
if not "%OS%"=="Windows_NT" goto win9x
:winNT
copy ..\..\Lib\RADXE2\Win32\gtRaveExp*.bpl %windir%\System32 > nul
goto finish
:win9x
copy ..\..\Lib\RADXE2\Win32\gtRaveExp*.bpl %windir%\System > nul
:finish
echo ""
)