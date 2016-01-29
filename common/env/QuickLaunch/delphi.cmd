if exist "C:\Program Files (x86)\Borland\Delphi7\Bin\delphi32.exe" (
start "" "C:\Program Files (x86)\Borland\Delphi7\Bin\delphi32.exe"
) else (
if "%ProgramFiles(x86)%"=="" (
start "" "C:\Program Files\Borland\Delphi7\Bin\delphi32.exe"
) else (
start "" "D:\Program Files\Borland\Delphi7\Bin\delphi32.exe"
) )