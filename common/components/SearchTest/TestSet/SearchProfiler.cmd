del %1\*.ctx /s
del %1\*.oth /s
del %1\*.rt /s
del %1\doneMark.tmp
start "" /W %1\SearchProfiler.exe -ini %1\SearchProfiler.ini
echo done > %1\doneMark.tmp