REM CommandInterpreter: $(ComSpec)
if defined ProgramFiles(x86) (
copy ..\..\Lib\RADXE\gtRaveExp*.bpl %windir%\SysWow64 > nul
) else (
if not "%OS%"=="Windows_NT" goto win9x
:winNT
copy ..\..\Lib\RADXE\gtRaveExp*.bpl %windir%\System32 > nul
goto finish
:win9x
copy ..\..\Lib\RADXE\gtRaveExp*.bpl %windir%\System > nul
:finish
echo ""
)