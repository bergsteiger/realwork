if EXIST "%4diff.exe" (
 %4diff.exe %1 %2 1>%3 2>&1
) else (
 echo "%4diff.exe" не найдено >%3
)