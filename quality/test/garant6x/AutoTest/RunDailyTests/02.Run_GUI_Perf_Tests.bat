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
SET CYCLE_COUNT=5

rem Останавливаем сервер; ждем 40 сек.; берем чистые настройки; ждем 5 сек.; запускаем сервер
REM call common.stop_service_remote.bat %SERVER_PROCESS_NAME% %SERVER_HOST% qc "22222" %SERVER_SERVICE_NAME%
REM %SLEEP_PATH%\sleep.exe 40
REM call common.get_clean_settings.bat
REM %SLEEP_PATH%\sleep.exe 5
call common.do_clean_settings.bat

call common.find_kill.bat TestComplete.ex
REM %PS_TOOLS_PATH%\psservice.exe %SERVER_HOST% -u qc -p "22222" start GarantF1Server
rem Регистрируем пользователя "perf" и выставляем необходимые наситройки, после этого оболочка закрывается.
%TC_PATH% /run /project:GUI_Perfomance /unit:GUI_Perfomance /routine:Prepare_GUI_Shell /exit /SilentMode "%TC_PROJECT_PATH%\GUI_Perfomance.mds" gui_login=perf gui_password=perf log_dir=%LOG_DIR% cur_date="%CUR_DATE%"
call common.find_kill.bat drwtsn32
call common.find_kill.bat f1shell

rem Выполнение автоматических тестов

REM Параметры проекта "reboot_delay=140000" "ps_tools_path=%PS_TOOLS_PATH%" теперь не используются

for /L %%i in (1,1,%CYCLE_COUNT%) do (
  call common.find_kill.bat hsdx.ex
  call common.find_kill.bat TestComplete.ex
  call common.reboot_server.bat
  %TC_PATH% /run /project:GUI_Perfomance /unit:GUI_Perfomance /routine:RunPerfomanceTests /exit /SilentMode "%TC_PROJECT_PATH%\GUI_Perfomance.mds" perf_op=Запуск_Регистрация max_itr=1 log_dir=%LOG_DIR% cur_date="%CUR_DATE%"
  call common.find_kill.bat drwtsn32
  call common.find_kill.bat f1shell
  call common.find_kill.bat hsdx.ex
)

for /L %%i in (1,1,%CYCLE_COUNT%) do (
  call common.find_kill.bat hsdx.ex
  call common.find_kill.bat TestComplete.ex
  call common.reboot_server.bat 
  %TC_PATH% /run /project:GUI_Perfomance /unit:GUI_Perfomance /routine:RunPerfomanceTests /exit /SilentMode "%TC_PROJECT_PATH%\GUI_Perfomance.mds" perf_op=Контекст_в_документе max_itr=1 log_dir=%LOG_DIR% cur_date="%CUR_DATE%"
  call common.find_kill.bat drwtsn32
  call common.find_kill.bat f1shell
  call common.find_kill.bat hsdx.ex
)

for /L %%i in (1,1,%CYCLE_COUNT%) do (
  call common.find_kill.bat hsdx.ex
  call common.find_kill.bat TestComplete.ex
  call common.reboot_server.bat 
  %TC_PATH% /run /project:GUI_Perfomance /unit:GUI_Perfomance /routine:RunPerfomanceTests /exit /SilentMode "%TC_PROJECT_PATH%\GUI_Perfomance.mds" perf_op=Контекст_в_списке max_itr=1 log_dir=%LOG_DIR% cur_date="%CUR_DATE%"
  call common.find_kill.bat drwtsn32
  call common.find_kill.bat f1shell
  call common.find_kill.bat hsdx.ex
)


for /L %%i in (1,1,%CYCLE_COUNT%) do (
  call common.find_kill.bat hsdx.ex
  call common.find_kill.bat TestComplete.ex
  call common.reboot_server.bat 
  %TC_PATH% /run /project:GUI_Perfomance /unit:GUI_Perfomance /routine:RunPerfomanceTests /exit /SilentMode "%TC_PROJECT_PATH%\GUI_Perfomance.mds" perf_op=Поиск_контекста_через_КЗ_ППР max_itr=1 log_dir=%LOG_DIR% cur_date="%CUR_DATE%"
  call common.find_kill.bat drwtsn32
  call common.find_kill.bat f1shell
  call common.find_kill.bat hsdx.ex
)


for /L %%i in (1,1,%CYCLE_COUNT%) do (
  call common.find_kill.bat hsdx.ex
  call common.find_kill.bat TestComplete.ex
  call common.reboot_server.bat 
  %TC_PATH% /run /project:GUI_Perfomance /unit:GUI_Perfomance /routine:RunPerfomanceTests /exit /SilentMode "%TC_PROJECT_PATH%\GUI_Perfomance.mds" perf_op=Открытие_вкладки_СКР max_itr=1 log_dir=%LOG_DIR% cur_date="%CUR_DATE%"
  call common.find_kill.bat drwtsn32
  call common.find_kill.bat f1shell
  call common.find_kill.bat hsdx.ex
)

rem Высылаем лог результатов производительности после вычисления среднего времени задержки
perl report2.pl "%LOG_DIR%\%DATE%.log"
%BLAT_PATH%\blat -install %SMTP_SRV% %MAIL_FROM%
%BLAT_PATH%\blat "%LOG_DIR%\%DATE%.log" -subject "AutoTest: Result of GUI Perfomance test" -to %MAIL_TO% -charset windows-1251
