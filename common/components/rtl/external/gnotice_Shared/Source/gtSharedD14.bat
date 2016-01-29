REM CommandInterpreter: $(ComSpec)
if not "%OS%"=="Windows_NT" goto win9x
:winNT
copy ..\Lib\RAD2010\gt*.bpl %windir%\System32 > nul
goto finish
:win9x
copy ..\Lib\RAD2010\gt*.bpl %windir%\System > nul
:finish
rem copy Rtl\*.hpp ..\Lib\RAD2010
rem copy PDFFontProcessor\*.hpp ..\Lib\RAD2010
rem copy Compression\*.hpp ..\Lib\RAD2010
rem copy Filters\*.hpp ..\Lib\RAD2010
rem copy PDFCrypt\*.hpp ..\Lib\RAD2010
rem copy Rtl\*.lib ..\Lib\RAD2010
rem copy PDFFontProcessor\*.lib ..\Lib\RAD2010
rem copy Compression\*.lib ..\Lib\RAD2010
rem copy Filters\*.lib ..\Lib\RAD2010
rem copy PDFCrypt\*.lib ..\Lib\RAD2010
rem copy Rtl\*.bpi ..\Lib\RAD2010
rem copy PDFFontProcessor\*.bpi ..\Lib\RAD2010
rem copy Compression\*.bpi ..\Lib\RAD2010
rem copy Filters\*.bpi ..\Lib\RAD2010
rem copy PDFCrypt\*.bpi ..\Lib\RAD2010