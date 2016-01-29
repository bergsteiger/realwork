rem остановка сервиса
rem в случае, если не удается остановить делаем pskill

rem имя процесса, ктороый надо убить
SET SSR_PROCESS_NAME=%1
rem название ПК, на котором работает процесс
SET SSR_TARGET_HOST=%2
rem логин для удаленного ПК
SET SSR_LOGIN=%3
rem пароль для удаленного ПК
SET SSR_PWD=%4
rem имя останавливаемой службы
SET SSR_SERVICE_NAME=%5

rem файл с результатами поиска процесса
SET OUT_FILE=find_stop.%COMPUTERNAME%.log
rem файл с результатами остановки процесса
SET CANT_STOP_FILE=cant_stop.%COMPUTERNAME%.log

SET COUNTER=%WAIT_COUNT%

rem Останавливаем процесс
%PS_TOOLS_PATH%\psservice.exe "%SSR_TARGET_HOST%" -u %SSR_LOGIN% -p %SSR_PWD% stop "%SSR_SERVICE_NAME%"
rem Ждем 45 сек. остановки сервера
%SLEEP_PATH%\sleep.exe 45

rem Проверяем остановился ли сервер в течение WAIT_COUNT чререз каждые WAIT_TIMEOUT
rem Если не остановился, пытаемся убить его

:begin_of_cycle

if %COUNTER% EQU 0 goto end_of_cycle

	%PS_TOOLS_PATH%\pslist "%SSR_TARGET_HOST%" -u %SSR_LOGIN% -p %SSR_PWD% %SSR_PROCESS_NAME%

	if %ERRORLEVEL% NEQ 0 goto end
	
	%SLEEP_PATH%\sleep.exe %WAIT_TIMEOUT%

	SET /a COUNTER=%COUNTER%-1

goto begin_of_cycle
:end_of_cycle

%PS_TOOLS_PATH%\pslist "%SSR_TARGET_HOST%" -u %SSR_LOGIN% -p %SSR_PWD% %SSR_PROCESS_NAME%
if %ERRORLEVEL% EQU 0 goto send_mail

goto end

rem Отсылаем письмо о том что сервис корректно не остановлен
:send_mail

%BLAT_PATH%\blat -install %SMTP_SRV% %MAIL_FROM%
SET /A WAITING_TIME=WAIT_COUNT*WAIT_TIMEOUT
%BLAT_PATH%\blat "%OUT_FILE%" -subject "Can't STOP process %PROCESS_NAME%, through %WAITING_TIME% sec, going 2 kill" -to %MAIL_TO%
%BLAT_PATH%\blat - -body "Can't STOP service %SSR_SERVICE_NAME%, going 2 kill" -subject "Can't STOP service %SSR_SERVICE_NAME%, on %SSR_TARGET_HOST%" -to %MAIL_TO%

rem пытаемся убить процесс
call common.find_kill_remote.bat %SSR_PROCESS_NAME% %SSR_TARGET_HOST% %SSR_LOGIN% %SSR_PWD%

:end