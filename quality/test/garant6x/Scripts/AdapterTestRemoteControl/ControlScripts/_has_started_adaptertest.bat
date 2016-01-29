call vars.bat
call _works_with_comps.bat

set EVALVAR_RESULT_FILE=set RESULT_FILE=%TEMP%\^^!COMP_NAME^^!.result_file12345^^&
set EVALVAR_COMPLETE_FILE=set COMPLETE_FILE=%TEMP%\^^!COMP_NAME^^!.complete_file12345^^&

rem Запрашиваем информацию о запущенных тестах
%FOR_ALL_COMPS_DO%
	%EVALVAR_RESULT_FILE%
	%EVALVAR_COMPLETE_FILE%
	if exist "!COMPLETE_FILE!" del /q "!COMPLETE_FILE!"
	%START% %START_PARAMS% cmd.exe /V:ON /C _get_adaptertest_count.bat !COMP_NAME! %USER_NAME% %PASSWORD% "!RESULT_FILE!" "!COMPLETE_FILE!"
%END_FOR_ALL_COMPS_DO%

rem Ждем пока вся информация будет получена
:wait_for_get_info
%FOR_ALL_COMPS_DO%
	%EVALVAR_COMPLETE_FILE%
	if not exist "!COMPLETE_FILE!" (
		"%SLEEP_EXE%" 1
		goto wait_for_get_info
	)
%END_FOR_ALL_COMPS_DO%

rem Теперь вся информация получена
set /a TOTAL_RUNNING_TEST_COUNT=0
%FOR_ALL_COMPS_DO%
	%EVALVAR_RESULT_FILE%
	if exist "!RESULT_FILE!" (
		for /f %%B in (!RESULT_FILE!) do set CURR_RUNNING_TEST_COUNT=%%B
		echo На машине !COMP_NAME! еще работает !CURR_RUNNING_TEST_COUNT! тестов
		set /a TOTAL_RUNNING_TEST_COUNT+=!CURR_RUNNING_TEST_COUNT!
	)
%END_FOR_ALL_COMPS_DO%
if %TOTAL_RUNNING_TEST_COUNT% == 0 (
	echo Ни одного теста не запущено!
) else (
	echo Всего тестов запущено: %TOTAL_RUNNING_TEST_COUNT%
)
