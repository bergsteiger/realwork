REM CommandInterpreter: $(ComSpec)
if not "%OS%"=="Windows_NT" goto win9x
:winNT
copy ..\Lib\RADXE\gtDocEng*.bpl %windir%\System32 > nul
goto finish
:win9x
copy ..\Lib\RADXE\gtDocEng*.bpl %windir%\System > nul
:finish
rem MOVE /Y *.hpp ..\Lib\RADXE > nul
rem MOVE /Y *.lib ..\Lib\RADXE > nul
rem MOVE /Y *.bpi ..\Lib\RADXE > nul