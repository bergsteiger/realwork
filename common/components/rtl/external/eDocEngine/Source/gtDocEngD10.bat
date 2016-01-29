REM CommandInterpreter: $(ComSpec)
if not "%OS%"=="Windows_NT" goto win9x
:winNT
copy ..\Lib\BDS2006\gtDocEng*.bpl %windir%\System32 > nul
goto finish
:win9x
copy ..\Lib\BDS2006\gtDocEng*.bpl %windir%\System > nul
:finish
