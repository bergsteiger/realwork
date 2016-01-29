REM CommandInterpreter: $(ComSpec)
if defined ProgramFiles(x86) (
copy ..\Lib\RADXE2\Win64\gtDocEng*.bpl %windir%\SysWow64 > nul
) else (
if not "%OS%"=="Windows_NT" goto win9x
:winNT
copy ..\Lib\RADXE2\Win32\gtDocEng*.bpl %windir%\System32 > nul
goto finish
:win9x
copy ..\Lib\RADXE2\Win32\gtDocEng*.bpl %windir%\System > nul
:finish
rem MOVE /Y *.hpp ..\Lib\RADXE > nul
rem MOVE /Y *.lib ..\Lib\RADXE > nul
rem MOVE /Y *.bpi ..\Lib\RADXE > nul