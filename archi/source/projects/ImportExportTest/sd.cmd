if EXIST "%4sdiff.exe" (
 if EXIST "%4diff.exe" (
  echo "%4" >%3
  "%4sdiff" "--diff-program=%4diff.exe" %1 %2 >>%3 2>&1
 ) else (
  echo "%4diff.exe" не найдено >%3
 )  
) else (
 echo "%4sdiff.exe" не найдено >%3
)