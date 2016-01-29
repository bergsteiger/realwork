@echo off
rem - Основной *.bat файл для запуска автоматического тестирования

rem - Определяем общие переменные для всех *.bat файлов

rem Параметры сервиса и процесса приложения
rem имя процесса
SET SERVER_PROCESS_NAME=F1Server
rem имя сервиса
SET SERVER_SERVICE_NAME=GarantF1Server

rem количество итераций ожидания остановки сервера
SET WAIT_COUNT=10
rem время ожидания до следущей проверки существования процесса
SET WAIT_TIMEOUT=10

rem %1 Путь к дистрибутиву
SET DISTRIB_PATH=\\p3single05\works\T_NEMESIS_6_4_0_129
rem %2 Путь к каталогу с утилитами комплекта pstools
SET PS_TOOLS_PATH=c:\pstools
rem %3 Путь к каталогу с утилитой sleep.exe
SET SLEEP_PATH=%PS_TOOLS_PATH%
rem %4 Путь к каталогу с сервером
SET SERVER_PATH=H:
rem %5 Имя хоста на которой установлен сервер
SET SERVER_HOST=\\p4single10
rem %6 Путь к каталогу с утилитой blat.exe для рассылки почтовых сообщений
SET BLAT_PATH=%PS_TOOLS_PATH%
rem %7 Путь к каталогу TestComplete
SET TC_PATH="F:\Program Files\Automated QA\TestComplete 3\TestComplete.exe"
rem %8 Путь к каталогу c файлами проекта TestComplete
SET TC_PROJECT_PATH=f:\cvs\quality\test\garant6x\implementation\main
SET BUILD_PATH=%DISTRIB_PATH%\!daily

rem %9 Параметры рассылки почты
SET MAIL_TO=qc@garant.ru
SET MAIL_FROM=AutoTest@garant.ru
SET SMTP_SRV=smtp.garant.ru


rem - Ждем сборки дистрибутива

rem - !!! Для удаленного доступа к другим ПК (напрмер с использованием утилит pstools) 
rem   будет использоваться логин\пароль = qc\22222

REM :loop
REM if exist "%DISTRIB_PATH%\!daily.build-script-schedule.lock" %SLEEP_PATH%\sleep 600 & goto :loop

REM call common.update_server.bat

rem - Меняем секцию реестра [HKEY_CURRENT_USER\Software\Garant.F1]
rem таким образом, чтобы при запуске клиента использовался ini файл T:\garant.ini

REM call redirect_client.bat

rem - Последовательное выполнение автоматических тестов

rem  Запуск консольных (С++) клиентов для тестирования производительности
REM call 01.Run_Console_Tests.bat

rem  Запуск GUI скриптов для замера производительноти на клиенте
call 02.Run_GUI_Perf_Tests_custom.bat
REM call stop.bat

rem  Запуск GUI скриптов для замера потребления памяти на клиенте и сервере
REM call 03.Run_GUI_Mem_Tests.bat