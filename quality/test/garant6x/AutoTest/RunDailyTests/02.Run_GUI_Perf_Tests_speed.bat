rem определяем каталог для файлов с логами и текущую дату
rem SET LOG_DIR=c:\!perf_logs
SET CUR_DATE=%DATE%
SET COMPARE_LOG=cmp.%COMPUTERNAME%.log

if %GUICount% LEQ 0 goto end

:begin
	SET /A NEW_GUI_COUNT=GUICount-1
	@echo %NEW_GUI_COUNT% >%GUI_JOURNAL_FILE%	
	
	if "%GUICount%" EQU "%GUITestCount%" goto first_iter	
	:start_iter
		call common.find_kill_no_snap.bat hsdx
		call common.find_kill.bat TestComplete.ex
		call common.reboot_server.bat
		%TC_PATH% /run /project:GUI_Perfomance_speed /unit:GUI_Perfomance_speed /routine:RunPerfomanceTests_speed /exit /SilentMode "%TC_PROJECT_PATH%\GUI_Perfomance_speed.mds" log_dir=%LOG_DIR% cur_date="%CUR_DATE%"  xml_file=%XML_FILE% build="%VERSION%"
		call common.find_kill.bat drwtsn32
		f1send_close.exe
		call common.find_kill.bat f1shell
		call common.find_kill_no_snap.bat hsdx
	:end_iter

	if "%NEW_GUI_COUNT%" EQU "0" goto last_iter

	call common.reboot_client.bat

:end
	goto finish

:first_iter
	call common.do_clean_settings.bat 
	call common.find_kill_no_snap.bat hsdx
	call common.find_kill.bat TestComplete.ex
	rem Регистрируем пользователя "perf" и выставляем необходимые настройки, после этого оболочка закрывается.
	%TC_PATH% /run /project:GUI_Perfomance_speed /unit:GUI_Perfomance_speed /routine:Prepare_GUI_Shell /exit /SilentMode "%TC_PROJECT_PATH%\GUI_Perfomance_speed.mds" gui_login=perf gui_password=perf log_dir=%LOG_DIR% cur_date="%CUR_DATE%"
	call common.find_kill.bat drwtsn32
	f1send_close.exe
	call common.find_kill.bat f1shell
	call common.find_kill_no_snap.bat hsdx
	
	call common.reboot_client.bat		
	goto end

:last_iter

	rem Высылаем лог результатов производительности после вычисления среднего времени задержки
	perl report2.pl -res_file "%LOG_DIR%\%DATE%.log" -log_file %COMPARE_LOG% -etalon_file "%ETALON_PATH%"
	type %BUILD_PATH%\!cvs_tag >>"%LOG_DIR%\%DATE%.log"
	%BLAT_PATH%\blat -install %SMTP_SRV% %MAIL_FROM%
	%BLAT_PATH%\blat "%LOG_DIR%\%DATE%.log" -subject "AutoTest: !speed Result of GUI Perfomance test %VERSION%" -to %MAIL_TO% -charset windows-1251
	if exist %COMPARE_LOG% type %BUILD_PATH%\!cvs_tag >>"%COMPARE_LOG%"
	if exist %COMPARE_LOG% %BLAT_PATH%\blat %COMPARE_LOG% -subject "AutoTest: Etalon dif of GUI Perfomance test %VERSION%" -to %MAIL_TO% -charset windows-1251

rem Вносим результаты в MDP в зависимости от версии

if exist c:\testing.74.txt goto :commit74

if exist c:\testing.73.txt goto :commit73

@echo НЕ нашли ни одного флага > noflags2commit.txt

goto end_commit

:commit74
	rem Переименовываем лог результатов
	rename "%LOG_DIR%\%DATE%.log" %DATE%.74.log

	call common.CreateKPage.74.bat %VERSION%
	rem Вносим результаты в CVS
	call common.cvs_commit.remote.74.bat
goto end_commit


:commit73
	rem Переименовываем лог результатов
	rename "%LOG_DIR%\%DATE%.log" %DATE%.73.log

	call common.CreateKPage.bat %VERSION%
	rem Вносим результаты в CVS
	call common.cvs_commit.remote.bat

:end_commit
	
	goto end
:finish
	exit /b 0