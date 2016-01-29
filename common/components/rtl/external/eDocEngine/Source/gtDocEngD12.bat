REM CommandInterpreter: $(ComSpec)
if not "%OS%"=="Windows_NT" goto win9x
:winNT
copy ..\Lib\RAD2009\gtDocEng*.bpl %windir%\System32 > nul
goto finish
:win9x
copy ..\Lib\RAD2009\gtDocEng*.bpl %windir%\System > nul
:finish
rem MOVE /Y *.hpp ..\Lib\RAD2009 > nul
rem MOVE /Y *.lib ..\Lib\RAD2009 > nul
rem MOVE /Y *.bpi ..\Lib\RAD2009 > nul