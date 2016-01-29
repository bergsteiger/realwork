REM CommandInterpreter: $(ComSpec)
if not "%OS%"=="Windows_NT" goto win9x
:winNT
copy ..\Lib\RAD2007\gt*.bpl %windir%\System32 > nul
goto finish
:win9x
copy ..\Lib\RAD2007\gt*.bpl %windir%\System > nul
:finish
rem copy Rtl\*.hpp ..\Lib\RAD2007
rem copy PDFFontProcessor\*.hpp ..\Lib\RAD2007
rem copy Compression\*.hpp ..\Lib\RAD2007
rem copy Filters\*.hpp ..\Lib\RAD2007
rem copy PDFCrypt\*.hpp ..\Lib\RAD2007