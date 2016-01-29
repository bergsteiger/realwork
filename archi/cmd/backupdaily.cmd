set dt=%~t1
set fn=daily-%dt:~6,4%-%dt:~3,2%-%dt:~0,2%-%dt:~11,2%-%dt:~14,2%.zip
if NOT EXIST S:\!DAILY_BACKUP (
 mkdir S:\!DAILY_BACKUP
)

rem Удаляем старьё
forfiles /d -7 /m S:\!DAILY_BACKUP\*.zip /c "del @file" > delbackup.log

rem Архивируем предыдущую сборку
echo %dt%
echo %fn%
7z a -tzip -r S:\!DAILY_BACKUP\%fn% %1\*.*