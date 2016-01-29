rem ��⠭���� �ࢨ�
rem � ��砥, �᫨ �� 㤠���� ��⠭����� ������ pskill

rem ��� �����, ���� ���� 㡨��
SET SSR_PROCESS_NAME=%1
rem �������� ��, �� ���஬ ࠡ�⠥� �����
SET SSR_TARGET_HOST=%2
rem ����� ��� 㤠������� ��
SET SSR_LOGIN=%3
rem ��஫� ��� 㤠������� ��
SET SSR_PWD=%4
rem ��� ��⠭���������� �㦡�
SET SSR_SERVICE_NAME=%5

rem 䠩� � १���⠬� ���᪠ �����
SET OUT_FILE=find_stop.%COMPUTERNAME%.log
rem 䠩� � १���⠬� ��⠭���� �����
SET CANT_STOP_FILE=cant_stop.%COMPUTERNAME%.log

SET COUNTER=%WAIT_COUNT%

rem ��⠭�������� �����
%PS_TOOLS_PATH%\psservice.exe "%SSR_TARGET_HOST%" -u %SSR_LOGIN% -p %SSR_PWD% stop "%SSR_SERVICE_NAME%"
rem ���� 45 ᥪ. ��⠭���� �ࢥ�
%SLEEP_PATH%\sleep.exe 45

rem �஢��塞 ��⠭������ �� �ࢥ� � �祭�� WAIT_COUNT ��१ ����� WAIT_TIMEOUT
rem �᫨ �� ��⠭������, ��⠥��� 㡨�� ���

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

rem ���뫠�� ���쬮 � ⮬ �� �ࢨ� ���४⭮ �� ��⠭�����
:send_mail

%BLAT_PATH%\blat -install %SMTP_SRV% %MAIL_FROM%
SET /A WAITING_TIME=WAIT_COUNT*WAIT_TIMEOUT
%BLAT_PATH%\blat "%OUT_FILE%" -subject "Can't STOP process %PROCESS_NAME%, through %WAITING_TIME% sec, going 2 kill" -to %MAIL_TO%
%BLAT_PATH%\blat - -body "Can't STOP service %SSR_SERVICE_NAME%, going 2 kill" -subject "Can't STOP service %SSR_SERVICE_NAME%, on %SSR_TARGET_HOST%" -to %MAIL_TO%

rem ��⠥��� 㡨�� �����
call common.find_kill_remote.bat %SSR_PROCESS_NAME% %SSR_TARGET_HOST% %SSR_LOGIN% %SSR_PWD%

:end