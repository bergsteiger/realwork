REM CommandInterpreter: $(ComSpec)
if defined ProgramFiles(x86) (
copy ..\Lib\RADXE3\Win64\gt*.bpl %windir%\SysWow64 > nul
) else (
if not "%OS%"=="Windows_NT" goto win9x
:winNT
copy ..\Lib\RADXE3\Win32\gt*.bpl %windir%\System32 > nul
goto finish
:win9x
copy ..\Lib\RADXE3\Win32\gt*.bpl %windir%\System > nul
:finish
rem copy Rtl\*.hpp ..\Lib\RADXE3
rem copy PDFFontProcessor\*.hpp ..\Lib\RADXE3
rem copy Compression\*.hpp ..\Lib\RADXE3
rem copy Filters\*.hpp ..\Lib\RADXE3
rem copy PDFCrypt\*.hpp ..\Lib\RADXE3
rem copy Rtl\*.lib ..\Lib\RADXE3
rem copy PDFFontProcessor\*.lib ..\Lib\RADXE3
rem copy Compression\*.lib ..\Lib\RADXE3
rem copy Filters\*.lib ..\Lib\RADXE3
rem copy PDFCrypt\*.lib ..\Lib\RADXE3
rem copy Rtl\*.bpi ..\Lib\RADXE3
rem copy PDFFontProcessor\*.bpi ..\Lib\RADXE3
rem copy Compression\*.bpi ..\Lib\RADXE3
rem copy Filters\*.bpi ..\Lib\RADXE3
rem copy PDFCrypt\*.bpi ..\Lib\RADXE3