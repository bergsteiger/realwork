if "%ProgramFiles(x86)%"=="" (
start "" "C:\Program Files\Microsoft Office\OFFICE12\WINWORD.EXE" %1 %2
) else (
start "" "%ProgramFiles(x86)%\Microsoft Office\OFFICE12\WINWORD.EXE" %1 %2
)
rem start "" "C:\Program Files\OpenOffice.org 2.3\program\swriter.exe" %1 %2