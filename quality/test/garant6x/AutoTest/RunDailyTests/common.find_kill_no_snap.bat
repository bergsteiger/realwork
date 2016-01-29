SET PROCESS_NAME=%1
SET COUNTER=%WAIT_COUNT%

:begin_of_cycle

if %COUNTER% EQU 0 goto end_of_cycle

	%PS_TOOLS_PATH%\pslist %PROCESS_NAME%

	if %ERRORLEVEL% NEQ 0 goto end
	
	%PS_TOOLS_PATH%\pskill %PROCESS_NAME%
	echo !!! %PROCESS_NAME% was FOUND and MAY BE KILLED >>"%LOG_DIR%\%DATE%.log"
	%SLEEP_PATH%\sleep.exe %WAIT_TIMEOUT%

	SET /a COUNTER=%COUNTER%-1

goto begin_of_cycle
:end_of_cycle

%PS_TOOLS_PATH%\pslist %PROCESS_NAME%
if %ERRORLEVEL% EQU 0 goto send_mail

goto end

:send_mail
%BLAT_PATH%\blat -install %SMTP_SRV% %MAIL_FROM%
%BLAT_PATH%\blat - -body "Can't kill process %PROCESS_NAME%" -subject "Can't kill process %PROCESS_NAME%" -to %MAIL_TO%
echo Test will stop
exit

:end