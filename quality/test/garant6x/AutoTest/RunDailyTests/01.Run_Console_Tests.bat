if "%OS%"=="Windows_NT" SET WIN_VER=Winnt
if "%OS%"=="" SET WIN_VER=Win9x

if %ConsoleCount% LEQ 0 goto end

:begin
	SET /A NEW_CONSOLE_COUNT=ConsoleCount-1
	@echo %NEW_CONSOLE_COUNT% >%CONSOLE_JOURNAL_FILE%	
	
	if "%ConsoleCount%" EQU "%ConsoleTestCount%" goto first_iter	
	:start_iter
		@echo Start console test iteration
		REM RESTART SERVER !!!
		call common.reboot_server.bat

		call common.do_clean_settings.bat 

		if NOT exist "%SERVER_PATH%\reports" mkdir "%SERVER_PATH%\reports"
		if NOT exist "%SERVER_PATH%\reports\%DATE%" mkdir "%SERVER_PATH%\reports\%DATE%"

		SET /A ITERATION=%ConsoleTestCount%-%ConsoleCount%
		%SERVER_PATH%\apps\%WIN_VER%\timetest.exe -log "%SERVER_PATH%\reports\%DATE%\result_%ConsoleCount%.log" -result_file "%CD%\result.csv"
		@echo End console test iteration
	:end_iter

	if "%NEW_CONSOLE_COUNT%" EQU "0" goto last_iter

	call common.reboot_client.bat

:end
	goto finish

:first_iter
	@copy /y /b "%BUILD_PATH%\support\test\client\%WIN_VER%\timetest.exe" "%SERVER_PATH%\apps\%WIN_VER%\timetest.exe"
	echo ***************Start %COUNT_EXECUTE% tests (%DATE%::%TIME%)**************** >>"%CD%\result.csv"
	type %BUILD_PATH%\!cvs_tag >>"%CD%\result.csv"
	
	call common.reboot_client.bat
	goto end

:last_iter
	perl calculate_average.pl -res_file "%CD%\result.csv" -log_file console_cmp.log -etalon_file "%ETALON_PATH%"

	@echo on
	echo ***************End %COUNT_EXECUTE% tests (%DATE%::%TIME%)**************** >>"%CD%\result.csv"
	@echo off

	%BLAT_PATH%\blat -install %SMTP_SRV% %MAIL_FROM%
	%BLAT_PATH%\blat "%CD%\result.csv" -subject "AutoTest: Result of time test %VERSION%" -to %MAIL_TO%
	if exist console_cmp.log %BLAT_PATH%\blat console_cmp.log -subject "AutoTest: Etalon dif of Concole Perfomance test %VERSION%" -to %MAIL_TO% -charset windows-1251
	goto end

:finish
	exit /b 0