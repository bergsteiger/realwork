if EXIST "C:\Program Files\Araxis\Araxis Merge\Compare.exe" (
 start "" "C:\Program Files\Araxis\Araxis Merge\Compare.exe " %1 %2 
) else (
if EXIST "C:\Program Files (x86)\WinMerge\WinMergeU.exe" (
 start "" "C:\Program Files (x86)\WinMerge\WinMergeU.exe " %1 %2
) else (
if "%ProgramFiles(x86)%"=="" (
 if EXIST "C:\Program Files\Araxis\Araxis Merge\Compare.exe" (
  start "" "C:\Program Files\Araxis\Araxis Merge\Compare.exe " %1 %2
 ) else (
  sdiff --diff-program=diff.exe %1 %2 | more
 ) 
) else (
 if EXIST "D:\Program Files\Araxis\Araxis Merge\Compare.exe" (
  start "" "D:\Program Files\Araxis\Araxis Merge\Compare.exe " %1 %2
 ) else (
  sdiff --diff-program=diff.exe %1 %2 | more
 ) 
)
)
)
rem start "" "C:\Programs\Araxis Merge\Compare.exe " %1 %2