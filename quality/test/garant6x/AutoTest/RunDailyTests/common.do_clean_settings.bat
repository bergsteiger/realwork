rem ��⠭���� �ࢨ� � �����饭���
call common.stop_service_remote.bat %SERVER_PROCESS_NAME% %SERVER_HOST% qc "11111" %SERVER_SERVICE_NAME%
rem �஢�ઠ ���� �ࢥ� �� ����稥 �訡�� � ����ன���
perl check_log.pl -f "%SERVER_PATH%\logs\garant.log" -s "User database damage!!!"

call common.get_clean_settings.bat

@ECHO START SERVER PARAMS:
@ECHO Service Name: %SERVER_SERVICE_NAME%

%PS_TOOLS_PATH%\psservice.exe "%SERVER_HOST%" -u qc -p "22222" start %SERVER_SERVICE_NAME%
%SLEEP_PATH%\sleep.exe 30

rem �஢�ઠ ���� �ࢥ� �� ����稥 �訡�� � ����ன���
perl check_log.pl -f "%SERVER_PATH%\logs\garant.log" -s "User database damage!!!"