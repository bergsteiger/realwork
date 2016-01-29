call vars.bat

set PROCESS_NAME=%TEST_NAME%

set TARGET_COMP=%1
set USER_NAME=%2
set PASSWORD=%3
set RESULT_FILE=%4
set COMPLETE_FILE=%5

if "%TARGET_COMP%"=="" echo TARGET_COMP не задан! & exit
if "%USER_NAME%"=="" echo USER_NAME не задан! & exit
if "%PASSWORD%"=="" echo PASSWORD не задан! & exit
if "%RESULT_FILE%"=="" echo RESULT_FILE не задан! & exit
if "%COMPLETE_FILE%"=="" echo COMPLETE_FILE не задан! & exit

set TMP_RESULT_FILE=%RESULT_FILE%.tmp_result

del /q "%RESULT_FILE%"
del /q "%TMP_RESULT_FILE%"

rem Выводим в заданный файл количество процессов
"%PSTOOLS_PATH%\pslist.exe" \\%TARGET_COMP% -u %USER_NAME% -p %PASSWORD% %PSTOOLS_COMMON_PARAMS% %PROCESS_NAME% > "%TMP_RESULT_FILE%"
if %ERRORLEVEL% == 0 type "%TMP_RESULT_FILE%" | find /C /I "%PROCESS_NAME%" > "%RESULT_FILE%"
del /q "%TMP_RESULT_FILE%"

rem Создаем файл о завершении
echo a> "%COMPLETE_FILE%"
