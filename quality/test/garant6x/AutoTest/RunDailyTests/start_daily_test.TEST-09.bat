SET NETDRV=R:
SET REPATH=%NETDRV%\.PERFOMANCE\quality\test\garant6x\AutoTest\RunDailyTests
SET PATH=%PATH%;%NETDRV%\.EXTERNAL\Perl\bin

REM Параметры запуска
SET TC_BIN="F:\Program Files\Automated QA\TestComplete 5\Bin\TestComplete.exe"
SET SERVER_NAME=\\test-07
SET BUILD_NAME=!daily-GARANTF1-7_02
SET ETALON_FILE=etalon.%COMPUTERNAME%.ini

rem Параметры рассылки почты
SET BLAT_PATH=%NETDRV%\.EXTERNAL\blat
SET MAIL_TO=qc@garant.ru
SET MAIL_FROM=AutoTest@garant.ru
SET SMTP_SRV=smtp.garant.ru


%NETDRV%
cd %REPATH%

@if "%1" EQU "init" goto init

@if "%1" EQU "autorun" goto autorun

goto sen_mail

:init

@ECHO !!! current path is %~d0%~p0!!!
SET JOURNAL_FILE=journal.%COMPUTERNAME%.test
@echo START_TEST >%JOURNAL_FILE%
@echo Start test (%DATE%:%TIME%) > %REPATH%\00.Main_Run_All_Autotest.%COMPUTERNAME%.log
goto start_main


:autorun
%NETDRV%\.EXTERNAL\pstools_sleep sleep 300
@echo Continue test (%DATE%:%TIME%) >> %REPATH%\00.Main_Run_All_Autotest.%COMPUTERNAME%.log
goto start_main


:start_main
%REPATH%\00.Main_Run_All_Autotest.bat %NETDRV% %TC_BIN% %SERVER_NAME% %BUILD_NAME% %ETALON_FILE% /V:ON 1>>%REPATH%\00.Main_Run_All_Autotest.%COMPUTERNAME%.log 2>>&1
goto end


:send_mail
%BLAT_PATH%\blat -install %SMTP_SRV% %MAIL_FROM%
%BLAT_PATH%\blat - -body "Incorrect parameter $1 on %COMPUTERNAME%" -subject "Incorrect parameter $1 on %COMPUTERNAME%" -to %MAIL_TO%

:end