@echo off
rem ----------------------------------------------------------------------------------
rem - 'Гибридный' *.bat файл состоящий из 
rem 00.Main_Run_All_Autotest.bat и 02.Run_GUI_Perf_Tests_speed.bat
rem запускается до и после тестов на устойчивость для определения влияния долгой рабоы
rem системы на производительность
rem ----------------------------------------------------------------------------------

rem №№№№№№№№№№№№№№№№№№№№№ Модификация 00.Main_Run_All_Autotest.bat №№№№№№№№№№№№№№№№№№№№№
rem - Определяем общие переменные для всех *.bat файлов

rem %1 Путь к дистрибутиву
rem !Не используется SET DISTRIB_PATH=\\developer\garant-nemesis-ro\deployment
rem %2 Путь к каталогу с утилитами комплекта pstools
SET PS_TOOLS_PATH=c:\pstools
rem %3 Путь к каталогу с утилитой sleep.exe
SET SLEEP_PATH=%PS_TOOLS_PATH%
rem %4 Путь к каталогу с сервером
SET SERVER_PATH=\\strelka.garant.ru\qc\client
rem %5 Имя хоста на которой установлен сервер
rem !Не используется SET SERVER_HOST=\\test-07
rem %6 Путь к каталогу с утилитой blat.exe для рассылки почтовых сообщений
SET BLAT_PATH=%PS_TOOLS_PATH%
rem %7 Путь к каталогу TestComplete
SET TC_PATH="F:\Program Files\Automated QA\TestComplete 3\TestComplete.exe"
rem %8 Путь к каталогу c файлами проекта TestComplete
SET TC_PROJECT_PATH=f:\cvs\quality\test\garant6x\implementation\main
rem !Не используется SET BUILD_PATH=%DISTRIB_PATH%\!daily
rem %9 Путь к эталонному ini файлу
SET ETALON_PATH=Etalon.ini


rem %10 Параметры рассылки почты
SET MAIL_TO=qc@garant.ru
SET MAIL_FROM=AutoTest@garant.ru
SET SMTP_SRV=smtp.garant.ru

rem Проверяем работают ли основные скипты на производительность
:loop 
if exist "%LOC_FILE%"  %SLEEP_PATH%\sleep 600 & goto :loop

rem Путь к файлу\флагу выполнения основных тестов на производительность
rem !Не используется SET LOC_FILE=perfomance.loc

rem - Ждем сборки дистрибутива

rem - !!! Для удаленного доступа к другим ПК (напрмер с использованием утилит pstools) 
rem   будет использоваться логин\пароль = qc\22222


REM Выставляем флаг для других расписаний, что началось выполнение тестов на производительность
rem !Не используется echo waiting 4 distrib comilation > "%LOC_FILE%"

rem !Не используется :loop
rem !Не используется if exist "%DISTRIB_PATH%\!daily.build-script-schedule.lock" %SLEEP_PATH%\sleep 600 & goto :loop

rem определяем переменную с текущей версией
rem !Не используется SET VERSION=UNKNOWN
rem !Не используется for /F %%i IN ('findstr "T_NEMESIS.*" %BUILD_PATH%\!cvs_tag') DO SET VERSION=!VERSION! %%i

rem !Не используется echo '%VERSION%' >> "%LOC_FILE%"

rem Остановка сервера и проверка лога перед обновлением
rem !Не используется %PS_TOOLS_PATH%\psservice.exe "%SERVER_HOST%" -u qc -p "22222" stop GarantF1Server
rem !Не используется %SLEEP_PATH%\sleep 33
rem !Не используется perl check_log.pl -f "%SERVER_PATH%\logs\gar_srv.log" -s "User database damage!!!"

rem !Не используется call common.update_server.bat

rem - Меняем секцию реестра [HKEY_CURRENT_USER\Software\Garant.F1]
rem таким образом, чтобы при запуске клиента использовался ini файл T:\garant.ini

call redirect_class_client.bat

rem - Последовательное выполнение автоматических тестов

rem  Запуск консольных (С++) клиентов для тестирования производительности
rem !Не используется call 01.Run_Console_Tests.bat

rem  Запуск GUI скриптов для замера производительноти на клиенте
rem !Не используется call 02.Run_GUI_Perf_Tests_speed.bat

rem  Запуск GUI скриптов для замера потребления памяти на клиенте и сервере
REM call 03.Run_GUI_Mem_Tests.bat

REM Удаляем флаг выполнения тестов производительности
rem !Не используется del "%LOC_FILE%"
rem №№№№№№№№№№№№№№№№№№№№№ >EOF Модификация 00.Main_Run_All_Autotest.bat №№№№№№№№№№№№№№№№№№№№№
rem №№№№№№№№№№№№№№№№№№№№№ Модификация 02.Run_GUI_Perf_Tests_speed.bat №№№№№№№№№№№№№№№№№№№№№

rem определяем каталог для файлов с логами и текущую дату
SET LOG_DIR=c:\!perf_logs\class
SET CUR_DATE=%DATE%
SET CYCLE_COUNT=1

rem Останавливаем сервер; ждем 40 сек.; берем чистые настройки; ждем 5 сек.; запускаем сервер
rem !Не используется %PS_TOOLS_PATH%\psservice.exe "%SERVER_HOST%" -u qc -p "22222" stop GarantF1Server
rem !Не используется %SLEEP_PATH%\sleep.exe 40
rem !Не используется call common.do_clean_settings.bat 
rem !Не используется %SLEEP_PATH%\sleep.exe 5
call common.find_kill_no_snap.bat hsdx
call common.find_kill.bat TestComplete.ex
rem !Не используется %PS_TOOLS_PATH%\psservice.exe "%SERVER_HOST%" -u qc -p "22222" start GarantF1Server
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
rem !Не используется  call common.reboot_server.bat 
  %TC_PATH% /RunAndExit %TC_PROJECT_PATH%\GUI_Perfomance_speed.mds log_dir=%LOG_DIR% cur_date="%CUR_DATE%"
  call common.find_kill.bat drwtsn32
  call common.find_kill.bat f1shell
	call common.find_kill_no_snap.bat hsdx
)

rem Высылаем лог результатов производительности после вычисления среднего времени задержки
perl report2.pl -res_file "%LOG_DIR%\%DATE%.log" -log_file cmp.log -etalon_file "%ETALON_PATH%"
rem !Не используется type %BUILD_PATH%\!cvs_tag >>"%LOG_DIR%\%DATE%.log"
%BLAT_PATH%\blat -install %SMTP_SRV% %MAIL_FROM%
%BLAT_PATH%\blat "%LOG_DIR%\%DATE%.log" -subject "AutoTest: CLASS ROOM GUI Perfomance"  -to %MAIL_TO% -charset windows-1251
rem !Не используется if exist cmp.log type %BUILD_PATH%\!cvs_tag >>"cmp.log"
rem !Не используется if exist cmp.log %BLAT_PATH%\blat cmp.log -subject "AutoTest: Etalon dif of GUI Perfomance test %VERSION%" -to %MAIL_TO% -charset windows-1251
rem №№№№№№№№№№№№№№№№№№№№№ >EOF Модификация 02.Run_GUI_Perf_Tests_speed.bat №№№№№№№№№№№№№№№№№№№№№