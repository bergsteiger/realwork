REM CommandInterpreter: $(ComSpec)
if defined ProgramFiles(x86) (
copy ..\..\Lib\RAD2009\gtQRExp*.bpl %windir%\SysWow64 > nul
) else (
if not "%OS%"=="Windows_NT" goto win9x
:winNT
copy ..\..\Lib\RAD2009\gtQRExp*.bpl %windir%\System32 > nul
goto finish
:win9x
copy ..\..\Lib\RAD2009\gtQRExp*.bpl %windir%\System > nul
:finish
echo ""
)
Move *.hpp ..\..\Lib\RAD2009 > nul
MOVE /Y *.lib ..\Lib\RAD2009 > nul
MOVE /Y *.bpi ..\Lib\RAD2009 > nul