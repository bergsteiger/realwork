ECHO %DATE% %TIME%
rem %1 Буква сетевого диска
SET NETWORK_DRIVE=%1
SET PATH=%PATH%;%NETWORK_DRIVE%\.EXTERNAL\Perl\bin
rem %2 Путь к файду TestComplete\Execute
SET TC_PATH=%2
rem %3 Имя хоста на которой установлен сервер
SET SERVER_HOST=%3
rem %4 Имя каталога сборки с исходниками
SET BUILD_NAME=%4
rem %5 Путь к эталонному ini файлу
SET ETALON_PATH=Etalon.ini
rem %6 Путь c xml файлу с результатами всех измерений
SET XML_FILE=%6


SET JOURNAL_FILE=journal.%COMPUTERNAME%.test
SET CONSOLE_JOURNAL_FILE=journal_console.%COMPUTERNAME%.test
SET GUI_JOURNAL_FILE=journal_gui.%COMPUTERNAME%.test
SET GUITestCount=11
SET ConsoleTestCount=6

rem Параметры сервиса и процесса приложения
rem имя процесса
SET SERVER_PROCESS_NAME=F1Server
rem имя сервиса
SET SERVER_SERVICE_NAME=Garant.Application.Server

rem количество итераций ожидания остановки сервера
SET WAIT_COUNT=10
rem время ожидания до следущей проверки существования процесса
SET WAIT_TIMEOUT=10


if not exist "%JOURNAL_FILE%" exit /b

rem - Основной *.bat файл для запуска автоматического тестирования

rem - Определяем общие переменные для всех *.bat файлов

rem %1 Путь к дистрибутиву
SET DISTRIB_PATH=\\lin-store\garant-nemesis\deployment
rem SET DISTRIB_PATH=\\P3SINGLE05\works\NEMESIS\T_GARANTF1-7_09_0_130
rem %2 Путь к каталогу с утилитами комплекта pstools
SET PS_TOOLS_PATH=%NETWORK_DRIVE%\.EXTERNAL\pstools_sleep
rem %3 Путь к каталогу с утилитой sleep.exe
SET SLEEP_PATH=%PS_TOOLS_PATH%
rem %4 Путь к каталогу с сервером
SET SERVER_PATH=T:\

rem %6 Путь к каталогу с утилитой blat.exe для рассылки почтовых сообщений
SET BLAT_PATH=%NETWORK_DRIVE%\.EXTERNAL\blat


rem %8 Путь к каталогу c файлами проекта TestComplete
rem // MY STUB
SET TC_PROJECT_PATH=%NETWORK_DRIVE%\PERF.7.10\implementation\projects\GUI_Perfomance_speed\GUI_Perfomance_speed
SET BUILD_PATH=%DISTRIB_PATH%\%BUILD_NAME%


SET HSDX_PATH=%NETWORK_DRIVE%\.EXTERNAL\HySnapDX

rem %10 Параметры рассылки почты
SET MAIL_TO=qc@garant.ru
SET MAIL_FROM=AutoTest@garant.ru
SET SMTP_SRV=smtp.garant.ru

rem Путь к файлу\флагу выполнения основных тестов на производительность
SET LOC_FILE=perfomance.%COMPUTERNAME%.loc

rem лог с результатами тестов
IF NOT EXIST %NETWORK_DRIVE%\PERF.7.10\[%COMPUTERNAME%]  mkdir %NETWORK_DRIVE%\PERF.7.10\[%COMPUTERNAME%]
SET LOG_DIR=%NETWORK_DRIVE%\PERF.7.10\[%COMPUTERNAME%]

rem Удаляем все процессы, которые могли остаться от предыдущих запусков
call common.find_kill_no_snap.bat hsdx
call common.find_kill.bat TestComplete.ex
call common.find_kill.bat drwtsn32
call common.find_kill.bat f1shell

rem - Ждем сборки дистрибутива

rem - !!! Для удаленного доступа к другим ПК (напрмер с использованием утилит pstools) 
rem   будет использоваться логин\пароль = qc\22222


REM Выставляем флаг для других расписаний, что началось выполнение тестов на производительность
echo waiting 4 distrib comilation > "%LOC_FILE%"

:loop
if exist "%DISTRIB_PATH%\!daily.build-script-schedule.lock" %SLEEP_PATH%\sleep 600 & goto :loop

rem определяем переменную с текущей версией
SET VERSION=UNKNOWN
for /F %%i IN ('findstr "T_GARANTF1.*" %BUILD_PATH%\!cvs_tag') DO SET VERSION=%%i

echo '%VERSION%' >> "%LOC_FILE%"

rem - Последовательное выполнение автоматических тестов



rem проверяем результат поиска
for /F %%i IN ('findstr "START_TEST" %JOURNAL_FILE%') DO (
	@echo First start

	rem Остановка сервера и проверка лога перед обновлением
	call common.stop_service_remote.bat %SERVER_PROCESS_NAME% %SERVER_HOST% qc "22222" %SERVER_SERVICE_NAME%
	%SLEEP_PATH%\sleep 33
	perl check_log.pl -f "%SERVER_PATH%\logs\gar_srv.log" -s "User database damage!!!"

	call common.update_server.bat

	rem - Меняем секцию реестра [HKEY_CURRENT_USER\Software\Garant.F1]
	rem таким образом, чтобы при запуске клиента использовался ini файл T:\garant.ini

	call redirect_client.bat

	@echo %ConsoleTestCount% >%CONSOLE_JOURNAL_FILE%
	@echo %GUITestCount% >%GUI_JOURNAL_FILE%
	@echo GO >"%JOURNAL_FILE%"
	del /q/ /f 00.Main_Run_All_Autotest.%COMPUTERNAME%.78.log
)

REM for /F  %%j in (%CONSOLE_JOURNAL_FILE%) do (
REM 	@echo Console=%%j >>1.txt 
REM 	SET ConsoleCount=%%j
REM 	call 01.Run_Console_Tests.bat
REM )
del /q /f "%CONSOLE_JOURNAL_FILE%"

for /F  %%k in (%GUI_JOURNAL_FILE%) do (
	@echo GUI=%%k >>1.txt 
	SET GUICount=%%k
	call 02.Run_GUI_Perf_Tests_speed.bat
)
del /q /f "%GUI_JOURNAL_FILE%"


REM Удаляем флаг выполнения тестов производительности
del /q /f "%LOC_FILE%"
del /q /f "%JOURNAL_FILE%"

exit /b 0