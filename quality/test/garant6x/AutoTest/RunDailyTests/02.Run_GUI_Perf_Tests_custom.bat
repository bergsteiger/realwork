ECHO OFF

REM Пример *.bat файла для запска расписания.
REM Ключ <perf_op> может принимать следующие значения:
REM Запуск_Регистрация
REM Открытие_вкладки_СКР
REM Контекст_в_документе
REM Поиск_контекста_через_КЗ_ППР

ECHO ON

rem определяем каталог для файлов с логами и текущую дату
SET LOG_DIR=c:\!perf_logs
SET CUR_DATE=%DATE%
SET CYCLE_COUNT=1

rem Останавливаем сервер; ждем 40 сек.; берем чистые настройки; ждем 5 сек.; запускаем сервер
REM call common.stop_service_remote.bat %SERVER_PROCESS_NAME% %SERVER_HOST% qc "22222" %SERVER_SERVICE_NAME%
REM %SLEEP_PATH%\sleep.exe 40
REM call common.get_clean_settings.bat
REM %SLEEP_PATH%\sleep.exe 5
call common.do_clean_settings.bat 

call common.find_kill_no_snap.bat hsdx
call common.find_kill.bat TestComplete.ex
REM %PS_TOOLS_PATH%\psservice.exe %SERVER_HOST% -u qc -p "22222" start GarantF1Server
rem Регистрируем пользователя "perf" и выставляем необходимые наситройки, после этого оболочка закрывается.
%TC_PATH% /RunAndExit %TC_PROJECT_PATH%\Prepare_GUI_Shell.mds gui_login=perf gui_password=perf log_dir=%LOG_DIR% cur_date="%CUR_DATE%"
call common.find_kill.bat drwtsn32
call common.find_kill.bat f1shell
call common.find_kill_no_snap.bat hsdx

rem Выполнение автоматических тестов

REM Параметры проекта "reboot_delay=140000" "ps_tools_path=%PS_TOOLS_PATH%" теперь не используются

for /L %%i in (1,1,%CYCLE_COUNT%) do (
	call common.find_kill_no_snap.bat hsdx
  call common.find_kill.bat TestComplete.ex
  call common.reboot_server.bat
  %TC_PATH% /RunAndExit %TC_PROJECT_PATH%\GUI_Custom.mds log_dir=%LOG_DIR% cur_date="%CUR_DATE%"
  call common.find_kill.bat drwtsn32
  call common.find_kill.bat f1shell
	call common.find_kill_no_snap.bat hsdx
)

for /L %%i in (1,1,%CYCLE_COUNT%) do (
	call common.find_kill_no_snap.bat hsdx
  call common.find_kill.bat TestComplete.ex
  call common.reboot_server.bat
  %TC_PATH% /RunAndExit %TC_PROJECT_PATH%\GUI_Custom.mds log_dir=%LOG_DIR% cur_date="%CUR_DATE%"
  call common.find_kill.bat drwtsn32
  call common.find_kill.bat f1shell
	call common.find_kill_no_snap.bat hsdx
)

for /L %%i in (1,1,%CYCLE_COUNT%) do (
	call common.find_kill_no_snap.bat hsdx
  call common.find_kill.bat TestComplete.ex
  call common.reboot_server.bat
  %TC_PATH% /RunAndExit %TC_PROJECT_PATH%\GUI_Custom.mds log_dir=%LOG_DIR% cur_date="%CUR_DATE%"
  call common.find_kill.bat drwtsn32
  call common.find_kill.bat f1shell
	call common.find_kill_no_snap.bat hsdx
)
rem Высылаем лог результатов производительности после вычисления среднего времени задержки
REM perl report2_custom.pl "%LOG_DIR%\%DATE%.log"
REM %BLAT_PATH%\blat -install %SMTP_SRV% %MAIL_FROM%
REM %BLAT_PATH%\blat "%LOG_DIR%\%DATE%.log" -subject "AutoTest: Context Search 6.4 (WITH synm)" -to %MAIL_TO% -charset windows-1251