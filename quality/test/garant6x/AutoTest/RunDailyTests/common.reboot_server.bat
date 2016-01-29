rem Батник для перезагрузки хоста

rem файл-флаг, говорящий о том, что сервер перегрузился
SET FLAG_REBOOT=%SERVER_PATH%\reboot.%COMPUTERNAME%.flag

rem создаем файл-флаг
echo reboot flag > "%FLAG_REBOOT%"
rem Останавливаем сервер перед перезагрузкой
call common.stop_service_remote.bat %SERVER_PROCESS_NAME% %SERVER_HOST% qc "11111" %SERVER_SERVICE_NAME%

rem Посылаем сообщение серверу перегрузиться
%PS_TOOLS_PATH%\psshutdown.exe "%SERVER_HOST%" -u qc -p "22222" -r -f -t 33

:reboot_loop
if exist "%FLAG_REBOOT%" %SLEEP_PATH%\sleep.exe 10 & goto :reboot_loop
:wait_loop
if not exist "%FLAG_REBOOT%" %SLEEP_PATH%\sleep.exe 10 & goto :wait_loop
%SLEEP_PATH%\sleep.exe 30
perl check_log.pl -f "%SERVER_PATH%\logs\garant.log" -s "User database damage!!!"