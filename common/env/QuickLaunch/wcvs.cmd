if exist "C:\Program Files (x86)\GNU\WinCvs 2.0\wincvs.exe" (
 start "" "C:\Program Files (x86)\GNU\WinCvs 2.0\wincvs.exe"
) else (
if exist "C:\Program Files (x86)\GNU\WinCvs\" (
start "" "C:\Program Files (x86)\GNU\WinCvs\wincvs.exe"
) else (
if "%ProgramFiles(x86)%"=="" (
start "" "C:\Program Files\GNU\WinCvs 2.0\wincvs.exe"
) else (
start "" "D:\Program Files\GNU\WinCvs 2.0\wincvs.exe"
) ) )