@ECHO OFF

if not exist ..\Lib_r_p (md ..\Lib_r_p)
if not exist ..\Lib_r_p\D7 (md ..\Lib_r_p\D7)
if not exist ..\Lib_r_p\D6 (md ..\Lib_r_p\D6)
if not exist ..\Lib_r_p\D5 (md ..\Lib_r_p\D5)

ECHO.
ECHO Changing INC file to Reg + Pro ...
COPY /Y gtDefines_r_p.inc gtDefines.inc > nul
ECHO Done.

ECHO.
ECHO :: -------------------------------------------- ::
ECHO :: - Building eDocEngine Reg Pro for Delphi 7 - ::
ECHO :: -------------------------------------------- ::
ECHO.

ECHO Compiling Runtime Package gtDocEngD70.dpk ...
E:\Win2K\Borland\Delphi7\Bin\dcc32.exe E:\Win98\V20\RainbowPro\Source\gtDocEngD70.dpk -B -H -W -U..\..\Shared\Lib\D7 -N..\Lib_r_p\D7 -LE..\Lib_r_p\D7 -LN..\Lib_r_p\D7 > nul
ECHO Done.

ECHO.
ECHO Compiling Runtime Package gtDocEngD70Pro.dpk ...
E:\Win2K\Borland\Delphi7\Bin\dcc32.exe E:\Win98\V20\RainbowPro\Source\gtDocEngD70Pro.dpk -B -H -W -U..\..\Shared\Lib\D7 -U..\Lib_r_p\D7 -N..\Lib_r_p\D7 -LE..\Lib_r_p\D7 -LN..\Lib_r_p\D7 > nul
ECHO Done.

ECHO.
ECHO Compiling Designtime Package DCLgtDocEngD70Pro.dpk ...
E:\Win2K\Borland\Delphi7\Bin\dcc32.exe E:\Win98\V20\RainbowPro\Source\DCLgtDocEngD70Pro.dpk -B -H -W -U..\..\Shared\Lib\D7 -U..\Lib_r_p\D7 -N..\Lib_r_p\D7 -LE..\Lib_r_p\D7 -LN..\Lib_r_p\D7 > nul
ECHO Done.

ECHO.
ECHO Copying BPLs to Windows System directory ...
if not "%OS%"=="Windows_NT" goto win9x
:winNT
COPY /Y ..\Lib_r_p\D7\gtDocEng*.bpl %windir%\System32 > nul
goto finish
:win9x
COPY /Y ..\Lib_r_p\D7\gtDocEng*.bpl %windir%\System > nul
:finish
ECHO Done.

ECHO.
ECHO Copying DFMs to LIB directory ...
COPY /Y *.dfm ..\Lib_r_p\D7\*.dfm > nul
ECHO Done.

ECHO.
ECHO :: -------------------------------------------- ::
ECHO :: - Building eDocEngine Reg Pro for Delphi 6 - ::
ECHO :: -------------------------------------------- ::
ECHO.

ECHO Compiling Runtime Package gtDocEngD60.dpk ...
E:\Win2K\Borland\Delphi6\Bin\dcc32.exe E:\Win98\V20\RainbowPro\Source\gtDocEngD60.dpk -B -H -W -U..\..\Shared\Lib\D6 -N..\Lib_r_p\D6 -LE..\Lib_r_p\D6 -LN..\Lib_r_p\D6 > nul 
ECHO Done.

ECHO.
ECHO Compiling Runtime Package gtDocEngD60Pro.dpk ...
E:\Win2K\Borland\Delphi6\Bin\dcc32.exe E:\Win98\V20\RainbowPro\Source\gtDocEngD60Pro.dpk -B -H -W -U..\..\Shared\Lib\D6 -U..\Lib_r_p\D6 -N..\Lib_r_p\D6 -LE..\Lib_r_p\D6 -LN..\Lib_r_p\D6 > nul
ECHO Done.

ECHO.
ECHO Compiling Designtime Package DCLgtDocEngD60Pro.dpk ...
E:\Win2K\Borland\Delphi6\Bin\dcc32.exe E:\Win98\V20\RainbowPro\Source\DCLgtDocEngD60Pro.dpk -B -H -W -U..\..\Shared\Lib\D6 -U..\Lib_r_p\D6 -N..\Lib_r_p\D6 -LE..\Lib_r_p\D6 -LN..\Lib_r_p\D6 > nul
ECHO Done.

ECHO.
ECHO Copying BPLs to Windows System directory ...
if not "%OS%"=="Windows_NT" goto win9x
:winNT
COPY /Y ..\Lib_r_p\D6\gtDocEng*.bpl %windir%\System32 > nul
goto finish
:win9x
COPY /Y ..\Lib_r_p\D6\gtDocEng*.bpl %windir%\System > nul
:finish
ECHO Done.

ECHO.
ECHO Copying DFMs to LIB directory ...
COPY /Y *.dfm ..\Lib_r_p\D6\*.dfm > nul
ECHO Done.

ECHO.
ECHO :: -------------------------------------------- ::
ECHO :: - Building eDocEngine Reg Pro for Delphi 5 - ::
ECHO :: -------------------------------------------- ::
ECHO.

ECHO Compiling Runtime Package gtDocEngD50.dpk ...
E:\Win2K\Borland\Delphi5\Bin\dcc32.exe E:\Win98\V20\RainbowPro\Source\gtDocEngD50.dpk -B -H -W -U..\..\Shared\Lib\D5 -N..\Lib_r_p\D5 -LE..\Lib_r_p\D5 -LN..\Lib_r_p\D5 > nul 
ECHO Done.

ECHO.
ECHO Compiling Runtime Package gtDocEngD50Pro.dpk ...
E:\Win2K\Borland\Delphi5\Bin\dcc32.exe E:\Win98\V20\RainbowPro\Source\gtDocEngD50Pro.dpk -B -H -W -U..\..\Shared\Lib\D5 -U..\Lib_r_p\D5 -N..\Lib_r_p\D5 -LE..\Lib_r_p\D5 -LN..\Lib_r_p\D5 > nul
ECHO Done.

ECHO.
ECHO Compiling Designtime Package DCLgtDocEngD50Pro.dpk ...
E:\Win2K\Borland\Delphi5\Bin\dcc32.exe E:\Win98\V20\RainbowPro\Source\DCLgtDocEngD50Pro.dpk -B -H -W -U..\..\Shared\Lib\D5 -U..\Lib_r_p\D5 -N..\Lib_r_p\D5 -LE..\Lib_r_p\D5 -LN..\Lib_r_p\D5 > nul
ECHO Done.

ECHO.
ECHO Copying BPLs to Windows System directory ...
if not "%OS%"=="Windows_NT" goto win9x
:winNT
COPY /Y ..\Lib_r_p\D5\gtDocEng*.bpl %windir%\System32 > nul 
goto finish
:win9x
COPY /Y ..\Lib_r_p\D5\gtDocEng*.bpl %windir%\System > nul 
:finish
ECHO Done.

ECHO.
ECHO Copying DFMs to LIB directory ...
COPY /Y *.dfm ..\Lib_r_p\D5\*.dfm > nul
ECHO Done.

ECHO ...................................................

if not exist ..\Lib_t_p (md ..\Lib_t_p)
if not exist ..\Lib_t_p\D7 (md ..\Lib_t_p\D7)
if not exist ..\Lib_t_p\D6 (md ..\Lib_t_p\D6)
if not exist ..\Lib_t_p\D5 (md ..\Lib_t_p\D5)

ECHO.
ECHO Changing INC file to Try + Pro ...
COPY /Y gtDefines_t_p.inc gtDefines.inc > nul
ECHO Done.

ECHO.
ECHO :: -------------------------------------------- ::
ECHO :: - Building eDocEngine Try Pro for Delphi 7 - ::
ECHO :: -------------------------------------------- ::
ECHO.

ECHO Compiling Runtime Package gtDocEngD70.dpk ...
E:\Win2K\Borland\Delphi7\Bin\dcc32.exe E:\Win98\V20\RainbowPro\Source\gtDocEngD70.dpk -B -H -W -U..\..\Shared\Lib\D7 -N..\Lib_t_p\D7 -LE..\Lib_t_p\D7 -LN..\Lib_t_p\D7 > nul 
ECHO Done.

ECHO.
ECHO Compiling Runtime Package gtDocEngD70Pro.dpk ...
E:\Win2K\Borland\Delphi7\Bin\dcc32.exe E:\Win98\V20\RainbowPro\Source\gtDocEngD70Pro.dpk -B -H -W -U..\..\Shared\Lib\D7 -U..\Lib_t_p\D7 -N..\Lib_t_p\D7 -LE..\Lib_t_p\D7 -LN..\Lib_t_p\D7 > nul
ECHO Done.

ECHO.
ECHO Compiling Designtime Package DCLgtDocEngD70Pro.dpk ...
E:\Win2K\Borland\Delphi7\Bin\dcc32.exe E:\Win98\V20\RainbowPro\Source\DCLgtDocEngD70Pro.dpk -B -H -W -U..\..\Shared\Lib\D7 -U..\Lib_t_p\D7 -N..\Lib_t_p\D7 -LE..\Lib_t_p\D7 -LN..\Lib_t_p\D7 > nul
ECHO Done.

ECHO.
ECHO Copying BPLs to Windows System directory ...
if not "%OS%"=="Windows_NT" goto win9x
:winNT
COPY /Y ..\Lib_t_p\D7\gtDocEng*.bpl %windir%\System32 > nul
goto finish
:win9x
COPY /Y ..\Lib_t_p\D7\gtDocEng*.bpl %windir%\System > nul
:finish
ECHO Done.

ECHO.
ECHO Copying DFMs to LIB directory ...
COPY /Y *.dfm ..\Lib_t_p\D7\*.dfm > nul
ECHO Done.

ECHO.
ECHO :: -------------------------------------------- ::
ECHO :: - Building eDocEngine Try Pro for Delphi 6 - ::
ECHO :: -------------------------------------------- ::
ECHO.

ECHO Compiling Runtime Package gtDocEngD60.dpk ...
E:\Win2K\Borland\Delphi6\Bin\dcc32.exe E:\Win98\V20\RainbowPro\Source\gtDocEngD60.dpk -B -H -W -U..\..\Shared\Lib\D6 -N..\Lib_t_p\D6 -LE..\Lib_t_p\D6 -LN..\Lib_t_p\D6 > nul 
ECHO Done.

ECHO.
ECHO Compiling Runtime Package gtDocEngD60Pro.dpk ...
E:\Win2K\Borland\Delphi6\Bin\dcc32.exe E:\Win98\V20\RainbowPro\Source\gtDocEngD60Pro.dpk -B -H -W -U..\..\Shared\Lib\D6 -U..\Lib_t_p\D6 -N..\Lib_t_p\D6 -LE..\Lib_t_p\D6 -LN..\Lib_t_p\D6 > nul
ECHO Done.

ECHO.
ECHO Compiling Designtime Package DCLgtDocEngD60Pro.dpk ...
E:\Win2K\Borland\Delphi6\Bin\dcc32.exe E:\Win98\V20\RainbowPro\Source\DCLgtDocEngD60Pro.dpk -B -H -W -U..\..\Shared\Lib\D6 -U..\Lib_t_p\D6 -N..\Lib_t_p\D6 -LE..\Lib_t_p\D6 -LN..\Lib_t_p\D6 > nul
ECHO Done.

ECHO.
ECHO Copying BPLs to Windows System directory ...
if not "%OS%"=="Windows_NT" goto win9x
:winNT
COPY /Y ..\Lib_t_p\D6\gtDocEng*.bpl %windir%\System32 > nul 
goto finish
:win9x
COPY /Y ..\Lib_t_p\D6\gtDocEng*.bpl %windir%\System > nul 
:finish
ECHO Done.

ECHO.
ECHO Copying DFMs to LIB directory ...
COPY /Y *.dfm ..\Lib_t_p\D6\*.dfm > nul
ECHO Done.

ECHO.
ECHO :: -------------------------------------------- ::
ECHO :: - Building eDocEngine Try Pro for Delphi 5 - ::
ECHO :: -------------------------------------------- ::
ECHO.

ECHO Compiling Runtime Package gtDocEngD50.dpk ...
E:\Win2K\Borland\Delphi5\Bin\dcc32.exe E:\Win98\V20\RainbowPro\Source\gtDocEngD50.dpk -B -H -W -U..\..\Shared\Lib\D5 -N..\Lib_t_p\D5 -LE..\Lib_t_p\D5 -LN..\Lib_t_p\D5 > nul 
ECHO Done.

ECHO.
ECHO Compiling Runtime Package gtDocEngD50Pro.dpk ...
E:\Win2K\Borland\Delphi5\Bin\dcc32.exe E:\Win98\V20\RainbowPro\Source\gtDocEngD50Pro.dpk -B -H -W -U..\..\Shared\Lib\D5 -U..\Lib_t_p\D5 -N..\Lib_t_p\D5 -LE..\Lib_t_p\D5 -LN..\Lib_t_p\D5 > nul
ECHO Done.

ECHO.
ECHO Compiling Designtime Package DCLgtDocEngD50Pro.dpk ...
E:\Win2K\Borland\Delphi5\Bin\dcc32.exe E:\Win98\V20\RainbowPro\Source\DCLgtDocEngD50Pro.dpk -B -H -W -U..\..\Shared\Lib\D5 -U..\Lib_t_p\D5 -N..\Lib_t_p\D5 -LE..\Lib_t_p\D5 -LN..\Lib_t_p\D5 > nul
ECHO Done.

ECHO.
ECHO Copying BPLs to Windows System directory ...
if not "%OS%"=="Windows_NT" goto win9x
:winNT
COPY /Y ..\Lib_t_p\D5\gtDocEng*.bpl %windir%\System32 > nul 
goto finish
:win9x
COPY /Y ..\Lib_t_p\D5\gtDocEng*.bpl %windir%\System > nul 
:finish
ECHO Done.

ECHO.
ECHO Copying DFMs to LIB directory ...
COPY /Y *.dfm ..\Lib_t_p\D5\*.dfm > nul
ECHO Done.
