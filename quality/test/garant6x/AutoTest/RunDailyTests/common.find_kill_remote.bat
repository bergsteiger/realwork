rem имя процесса, ктороый надо убить
SET FK_FK_PROCESS_NAME=%1
rem название ПК, на котором работает процесс
SET FK_TARGET_HOST=%2
rem логин для удаленного ПК
SET FK_LOGIN=%3
rem пароль для удаленного ПК
SET FK_PWD=%4
SET COUNTER=%WAIT_COUNT%

:begin_of_cycle

if %COUNTER% EQU 0 goto end_of_cycle

	%PS_TOOLS_PATH%\pslist "%FK_TARGET_HOST%" -u %FK_LOGIN% -p %FK_PWD% %FK_PROCESS_NAME%

	if %ERRORLEVEL% NEQ 0 goto end
	
	call common.make_snap.bat
	%PS_TOOLS_PATH%\pskill "%FK_TARGET_HOST%" -u %FK_LOGIN% -p %FK_PWD% %FK_PROCESS_NAME%
	echo !!! %FK_PROCESS_NAME% was FOUND and MAY BE KILLED >>"%LOG_DIR%\%DATE%.log"
	%SLEEP_PATH%\sleep.exe %WAIT_TIMEOUT%

	SET /a COUNTER=%COUNTER%-1

goto begin_of_cycle
:end_of_cycle

%PS_TOOLS_PATH%\pslist "%FK_TARGET_HOST%" -u %FK_LOGIN% -p %FK_PWD% %FK_PROCESS_NAME%
if %ERRORLEVEL% EQU 0 goto send_mail

goto end

:send_mail
%BLAT_PATH%\blat -install %SMTP_SRV% %MAIL_FROM%
%BLAT_PATH%\blat - -body "Can't kill process %FK_PROCESS_NAME% on %FK_TARGET_HOST%" -subject "Can't kill process %FK_PROCESS_NAME% on %FK_TARGET_HOST%" -to %MAIL_TO%
echo Test will stop
exit

:end