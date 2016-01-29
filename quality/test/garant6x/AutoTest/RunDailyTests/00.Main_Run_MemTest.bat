rem @echo off
rem - Основной *.bat файл для запуска автоматического тестирования

rem - Определяем общие переменные для всех *.bat файлов

rem Параметры сервиса и процесса приложения
rem имя процесса
SET SERVER_PROCESS_NAME=F1Server
rem имя сервиса
SET SERVER_SERVICE_NAME=Garant.Application.Server

rem количество итераций ожидания остановки сервера
SET WAIT_COUNT=10
rem время ожидания до следущей проверки существования процесса
SET WAIT_TIMEOUT=10

rem %1 Путь к дистрибутиву
SET DISTRIB_PATH=\\developer\garant-nemesis-ro\deployment
rem %2 Путь к каталогу с утилитами комплекта pstools
SET PS_TOOLS_PATH=c:\pstools
rem %3 Путь к каталогу с утилитой sleep.exe
SET SLEEP_PATH=%PS_TOOLS_PATH%
rem %4 Путь к каталогу с сервером
SET SERVER_PATH=C:\#MemTest.server
rem %5 Имя хоста на которой установлен сервер
SET SERVER_HOST=\\p4core10-vm1
rem %6 Путь к каталогу с утилитой blat.exe для рассылки почтовых сообщений
SET BLAT_PATH=%PS_TOOLS_PATH%
rem %7 Путь к каталогу TestComplete
SET TC_PATH="C:\Program Files\Automated QA\TestComplete 5\Bin\TestComplete.exe"
rem %8 Путь к каталогу c файлами проекта TestComplete
SET TC_PROJECT_PATH=C:\CVS\quality\test\garant6x\implementation\projects\MemoryUsing\MemoryUsing
SET BUILD_PATH=%DISTRIB_PATH%\!daily-GARANTF1-7_02

rem %9 Параметры рассылки почты
SET MAIL_TO=qc@garant.ru
SET MAIL_FROM=AutoTest@garant.ru
SET SMTP_SRV=smtp.garant.ru


rem - Ждем сборки дистрибутива

rem - !!! Для удаленного доступа к другим ПК (напрмер с использованием утилит pstools) 
rem   будет использоваться логин\пароль = qc\22222

:loop
if not exist "%BUILD_PATH%\!success" %SLEEP_PATH%\sleep 60 & goto :loop

rem Остановка сервера и проверка лога перед обновлением
call common.stop_service_remote.bat %SERVER_PROCESS_NAME% %SERVER_HOST% qc "22222" %SERVER_SERVICE_NAME%
%SLEEP_PATH%\sleep 33
perl check_log.pl -f "%SERVER_PATH%\logs\gar_srv.log" -s "User database damage!!!"

call common.update_server.bat

rem - Меняем секцию реестра [HKEY_CURRENT_USER\Software\Garant.F1]
rem таким образом, чтобы при запуске клиента использовался ini файл T:\garant.ini

call redirect_mem_client.bat

rem - Последовательное выполнение автоматических тестов

rem  Запуск GUI скриптов для замера потребления памяти на клиенте и сервере
call 03.Run_GUI_Mem_Tests.bat