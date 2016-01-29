REM CommandInterpreter: $(ComSpec)
if defined ProgramFiles(x86) (
copy ..\..\Lib\RADXE\gtXPressExp*.bpl %windir%\SysWOW64 > nul
) else (
if not "%OS%"=="Windows_NT" goto win9x
:winNT
copy ..\..\Lib\RADXE\gtXPressExp*.bpl %windir%\System32 > nul
goto finish
:win9x
copy ..\..\Lib\RADXE\gtXPressExp*.bpl %windir%\System > nul
:finish
echo ""
)
