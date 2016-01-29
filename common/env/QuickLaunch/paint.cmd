if exist "C:\Program Files\Paint.NET\PaintDotNet.exe" (
start "" "C:\Program Files\Paint.NET\PaintDotNet.exe"  %1 %2
) else (
if "%ProgramFiles(x86)%"=="" (
start "" "C:\Program Files\Paint.NET\PaintDotNet.exe"  %1 %2
) else (
start "" "D:\Program Files\Paint.NET\PaintDotNet.exe"  %1 %2
) )
rem start "" "C:\Program Files\OpenOffice.org 2.3\program\swriter.exe" %1 %2