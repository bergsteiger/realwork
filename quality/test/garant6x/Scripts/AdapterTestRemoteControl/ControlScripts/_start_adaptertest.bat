@echo off
call vars.bat
call _works_with_comps.bat

echo %COMPS_LIST%
rem �஢��塞 �室�� ��ࠬ����
	rem ����쪮 �ᥣ� �����⮢ ����᪠��
set TOT_CLIENT_COUNT=%1
if "%TOT_CLIENT_COUNT%" equ "" goto USAGE
	rem ����쪮 �����⮢ ���� ࠡ���� �����६����
set SIM_CLIENT_COUNT=%2
if "%SIM_CLIENT_COUNT%" equ "" set SIM_CLIENT_COUNT=%TOT_CLIENT_COUNT%

if %SIM_CLIENT_COUNT% gtr %TOT_CLIENT_COUNT% (
	echo ������⢮ �����६���� ࠡ����� �����⮢ �� ����� �ॢ���� �� ��饥 ������⢮^^!
	exit 1
)

rem
set /a SUM_RANK=0
%FOR_ALL_COMPS_DO%
	if !SUM_RANK! lss %SIM_CLIENT_COUNT% set /a SUM_RANK=SUM_RANK+!COMP_RANK!
%END_FOR_ALL_COMPS_DO%

rem ��।��塞 ᪮�쪮 �����६����� �����⮢ �� ������ ��設� ����᪠�� (�ய��樮���쭮 �஢�� ��設�)
set /a COUNTER=0
set /a _SIM_CLIENTS_REST=SIM_CLIENT_COUNT
%FOR_ALL_COMPS_DO%
	if !_SIM_CLIENTS_REST! gtr 0 (
		set /a COUNTER=COUNTER+1
		set /a SIM_CLIENT_COUNT_!COUNTER!=!COMP_RANK!*SIM_CLIENT_COUNT/!SUM_RANK!
		set /a _SIM_CLIENTS_REST=_SIM_CLIENTS_REST-SIM_CLIENT_COUNT_!COUNTER!
	)
%END_FOR_ALL_COMPS_DO%
for /l %%A in (1,1,%_SIM_CLIENTS_REST%) do set /a SIM_CLIENT_COUNT_%%A=SIM_CLIENT_COUNT_%%A+1

rem ��।��塞 ᪮�쪮 �����⮢ �� ������ ��設� ����᪠�� (�ய��樮���쭮 �����६���� ࠡ���騬 �����⠬)
set /a COUNTER=0
set /a _TOT_CLIENTS_REST=TOT_CLIENT_COUNT
%FOR_ALL_COMPS_DO%
	set /a COUNTER=COUNTER+1
	set /a _SCC=SIM_CLIENT_COUNT_!COUNTER!
	if !_TOT_CLIENTS_REST! gtr 0 if !_SCC! gtr 0 (
		set /a TOT_CLIENT_COUNT_!COUNTER!=TOT_CLIENT_COUNT*SIM_CLIENT_COUNT_!COUNTER!/SIM_CLIENT_COUNT
		set /a _TOT_CLIENTS_REST=_TOT_CLIENTS_REST-TOT_CLIENT_COUNT_!COUNTER!
	)
%END_FOR_ALL_COMPS_DO%
for /l %%A in (1,1,%_TOT_CLIENTS_REST%) do set /a TOT_CLIENT_COUNT_%%A=TOT_CLIENT_COUNT_%%A+1

rem ����ਬ ��� � ᪮�쪮 ����᪠��
echo ������� ���� ����饭� ᫥���騬 ��ࠧ��:
echo ��設� ^| �ᥣ� ^| �����६����
set /a COUNTER=0
%FOR_ALL_COMPS_DO%
	set /a COUNTER=COUNTER+1
	set /a _SCC=SIM_CLIENT_COUNT_!COUNTER!
	set /a _TCC=TOT_CLIENT_COUNT_!COUNTER!
	echo !COMP_NAME! ^| !_TCC! ^| !_SCC!
%END_FOR_ALL_COMPS_DO%

rem ������ ����᪠��
set COUNTER=0
%FOR_ALL_COMPS_DO%
	set /a COUNTER=COUNTER+1
	set /a _TCC=TOT_CLIENT_COUNT_!COUNTER!
	set /a _SCC=SIM_CLIENT_COUNT_!COUNTER!
	if !_TCC! neq 0 (	
		%START% %START_PARAMS% %START_WAIT_PARAM% "!COMP_NAME!" "%PSTOOLS_PATH%\psexec.exe" \\!COMP_NAME! -u %USER_NAME% -p %PASSWORD% -i 0 %PSTOOLS_COMMON_PARAMS% cmd.exe /C "%CONTROL_NETWORK_PATH%\_start_at.bat" !_TCC! !_SCC! %SLEEP_TIME%
	)
%END_FOR_ALL_COMPS_DO%

exit /b

:USAGE
echo �ᯮ�짮�����: %~n0 �ᥣ�_�����⮢ <��_�����_祬_�⮫쪮_�����६����>
exit 1

