REM CommandInterpreter: $(ComSpec)
if defined ProgramFiles(x86) (
copy ..\..\Lib\BDS2006\gtDocProd*.bpl %windir%\SysWow64 > nul
) else (
if not "%OS%"=="Windows_NT" goto win9x
:winNT
copy ..\..\Lib\BDS2006\gtDocProd*.bpl %windir%\System32 > nul
goto finish
:win9x
copy ..\..\Lib\BDS2006\gtDocProd*.bpl %windir%\System > nul
:finish
echo ""
)