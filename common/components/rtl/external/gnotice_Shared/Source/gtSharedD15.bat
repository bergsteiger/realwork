REM CommandInterpreter: $(ComSpec)
if not "%OS%"=="Windows_NT" goto win9x
:winNT
copy ..\Lib\RADXE\gt*.bpl %windir%\System32 > nul
goto finish
:win9x
copy ..\Lib\RADXE\gt*.bpl %windir%\System > nul
:finish
rem copy Rtl\*.hpp ..\Lib\RADXE
rem copy PDFFontProcessor\*.hpp ..\Lib\RADXE
rem copy Compression\*.hpp ..\Lib\RADXE
rem copy Filters\*.hpp ..\Lib\RADXE
rem copy PDFCrypt\*.hpp ..\Lib\RADXE
rem copy Rtl\*.lib ..\Lib\RADXE
rem copy PDFFontProcessor\*.lib ..\Lib\RADXE
rem copy Compression\*.lib ..\Lib\RADXE
rem copy Filters\*.lib ..\Lib\RADXE
rem copy PDFCrypt\*.lib ..\Lib\RADXE
rem copy Rtl\*.bpi ..\Lib\RADXE
rem copy PDFFontProcessor\*.bpi ..\Lib\RADXE
rem copy Compression\*.bpi ..\Lib\RADXE
rem copy Filters\*.bpi ..\Lib\RADXE
rem copy PDFCrypt\*.bpi ..\Lib\RADXE