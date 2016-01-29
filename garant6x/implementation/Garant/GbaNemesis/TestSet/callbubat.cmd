if "%~1"=="" (
if exist "%ProgramFiles%\Garant-Server\apps\winNT\F1BU.exe" (
if "%OS%"=="Windows_NT" "%ProgramFiles%\Garant-Server\apps\winNT\F1BU.exe" -GCMConfigFile "%ProgramFiles%\Garant-Server\garant.ini"
) else (
if "%OS%"=="Windows_NT" "%ProgramFiles(x86)%\Garant-Server\apps\winNT\F1BU.exe" -GCMConfigFile "%ProgramFiles(x86)%\Garant-Server\garant.ini"
)
) else (
if exist "%ProgramFiles%\Garant-Server\apps\winNT\F1BU.exe" (
if "%OS%"=="Windows_NT" "%ProgramFiles%\Garant-Server\apps\winNT\F1BU.exe" -GCMConfigFile "%ProgramFiles%\Garant-Server\garant.ini" -PathToNewBase "%~1"
) else (
if "%OS%"=="Windows_NT" "%ProgramFiles(x86)%\Garant-Server\apps\winNT\F1BU.exe" -GCMConfigFile "%ProgramFiles(x86)%\Garant-Server\garant.ini" -PathToNewBase "%~1"
)
)