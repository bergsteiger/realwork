if exist "C:\Program Files\Araxis\Araxis Merge\Compare.exe" (
 start "" "C:\Program Files\Araxis\Araxis Merge\Compare.exe " %1 %2
) else (
 if exist "D:\Program Files\Araxis\Araxis Merge\Compare.exe" (
  start "" "D:\Program Files\Araxis\Araxis Merge\Compare.exe " %1 %2
 ) else (
  if "%ProgramFiles(x86)%"=="" (
   start "" "C:\Program Files\Araxis\Araxis Merge\Compare.exe " %1 %2
  ) else (
   start "" "D:\Program Files\Araxis\Araxis Merge\Compare.exe " %1 %2
  )
 ) 
)
rem start "" "C:\Programs\Araxis Merge\Compare.exe " %1 %2