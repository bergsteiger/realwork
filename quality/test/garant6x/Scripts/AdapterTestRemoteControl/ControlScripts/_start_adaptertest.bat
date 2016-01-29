@echo off
call vars.bat
call _works_with_comps.bat

echo %COMPS_LIST%
rem Проверяем входные параметры
	rem Сколько всего клиентов запускать
set TOT_CLIENT_COUNT=%1
if "%TOT_CLIENT_COUNT%" equ "" goto USAGE
	rem Сколько клиентов будут работать одновременно
set SIM_CLIENT_COUNT=%2
if "%SIM_CLIENT_COUNT%" equ "" set SIM_CLIENT_COUNT=%TOT_CLIENT_COUNT%

if %SIM_CLIENT_COUNT% gtr %TOT_CLIENT_COUNT% (
	echo Количество одновременно работающих клиентов не может превышать их общее количество^^!
	exit 1
)

rem
set /a SUM_RANK=0
%FOR_ALL_COMPS_DO%
	if !SUM_RANK! lss %SIM_CLIENT_COUNT% set /a SUM_RANK=SUM_RANK+!COMP_RANK!
%END_FOR_ALL_COMPS_DO%

rem Определяем сколько одновременных клиентов на каждой машине запускать (пропорционально уровню машины)
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

rem Определяем сколько клиентов на каждой машине запускать (пропорционально одновременно работающим клиентам)
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

rem Говорим где и сколько запускать
echo Клиенты будут запущены следующим образом:
echo Машина ^| Всего ^| Одновременно
set /a COUNTER=0
%FOR_ALL_COMPS_DO%
	set /a COUNTER=COUNTER+1
	set /a _SCC=SIM_CLIENT_COUNT_!COUNTER!
	set /a _TCC=TOT_CLIENT_COUNT_!COUNTER!
	echo !COMP_NAME! ^| !_TCC! ^| !_SCC!
%END_FOR_ALL_COMPS_DO%

rem Теперь запускаем
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
echo Использование: %~n0 всего_клиентов <не_более_чем_столько_одновременно>
exit 1

