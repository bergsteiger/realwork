setlocal enabledelayedexpansion

set TOT_CLIENT_COUNT=%1
set SIM_CLIENT_COUNT=%2

set CURR_PATH=%~dp0
call "%CURR_PATH%vars.bat"

rem Делаем, чтобы можно было запускать больше 10 клиентов
reg add "HKEY_CURRENT_USER\Software\Garant.F1" /v "-ORBEndPoint" /t REG_SZ /d "iiop://" /f

rem Добавляем путь к garant.ini
reg add "HKEY_CURRENT_USER\Software\Garant.F1" /v ApplicationAdapterOptions /t REG_SZ  /d "-GCMConfigFile \"%AT_NETWORK_PATH%\garant.ini\" -GPMAdapterConfigSection \"F1Client Params\" -LocalePath \"%AT_NETWORK_PATH%\"" /f

rem Запускаем клиентов
	rem Цикл имитируем с помощью меток, счетик цикла - A
set TEMP_FILE="%TEMP%\%RANDOM%%RANDOM%%RANDOM%%RANDOM%%RANDOM%"&
set PSLIST_OUT="%TEMP%\%RANDOM%%RANDOM%%RANDOM%%RANDOM%%RANDOM%"&
set AT_COUNT=0
set LOGIN=
set F1_LOG_ID=
	rem

set A=1
:CYCLE_BEGIN
  if !A! gtr %TOT_CLIENT_COUNT% goto CYCLE_END
    
  if !AT_COUNT! geq %SIM_CLIENT_COUNT% (
	%SLEEP_EXE% 1
	rem Ждем пока количество запущенных клиентов не станет меньше заданного
	:WAIT_FOR_CLIENT_COUNT
	"%PSTOOLS_PATH%\pslist.exe" %PSTOOLS_COMMON_PARAMS% %TEST_NAME% 1>%PSLIST_OUT% 2>nul
	find /i "was not found" %PSLIST_OUT% 1>nul 2>nul && (set AT_COUNT=0) || (
		type %PSLIST_OUT% | @find /c /i "%TEST_NAME%" 1>%TEMP_FILE%
		set /p AT_COUNT=<%TEMP_FILE%
		del %TEMP_FILE%
	)
	if exist %PSLIST_OUT% del %PSLIST_OUT%

	echo Now running: !AT_COUNT!
	if !AT_COUNT! geq %SIM_CLIENT_COUNT% %SLEEP_EXE% 1 & goto WAIT_FOR_CLIENT_COUNT
  )
	  


  set LOGIN=%COMPUTERNAME%_!A!
	rem Эта переменная может использоваться в ini-файле адаптера для того чтобы каждый клиент писал в свой лог
  set F1_LOG_ID=!LOGIN!
 
  rem Пускаем клиента
  %START% %START_PARAMS% "%TEST_NAME%_!A!" cmd /C "^"%AT_NETWORK_PATH%\%TEST_NAME%.exe^" -login !LOGIN! -password !LOGIN! -scenario_file ^"%SCENARIO_FILE_PATH%^" -log_file ^"%AT_NETWORK_PATH%\logs\!LOGIN!.log^" 1^>^&2 2^>^"%AT_NETWORK_PATH%\logs\!LOGIN!.console_out.log^^""
  if %SLEEP_TIME% gtr 0 "%SLEEP_EXE%" %SLEEP_TIME%
  set /a AT_COUNT=!AT_COUNT!+1

  echo !AT_COUNT!
	 
  rem Увеличиваем счетчик цикла и идем в начало  
  set /a A=!A!+1
  goto CYCLE_BEGIN
:CYCLE_END
