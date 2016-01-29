call vars.bat

set PROCESS_NAME=%TEST_NAME%

set TARGET_COMP=%1
set USER_NAME=%2
set PASSWORD=%3
set RESULT_FILE=%4
set COMPLETE_FILE=%5

if "%TARGET_COMP%"=="" echo TARGET_COMP �� �����! & exit
if "%USER_NAME%"=="" echo USER_NAME �� �����! & exit
if "%PASSWORD%"=="" echo PASSWORD �� �����! & exit
if "%RESULT_FILE%"=="" echo RESULT_FILE �� �����! & exit
if "%COMPLETE_FILE%"=="" echo COMPLETE_FILE �� �����! & exit

set TMP_RESULT_FILE=%RESULT_FILE%.tmp_result

del /q "%RESULT_FILE%"
del /q "%TMP_RESULT_FILE%"

rem �뢮��� � ������� 䠩� ������⢮ ����ᮢ
"%PSTOOLS_PATH%\pslist.exe" \\%TARGET_COMP% -u %USER_NAME% -p %PASSWORD% %PSTOOLS_COMMON_PARAMS% %PROCESS_NAME% > "%TMP_RESULT_FILE%"
if %ERRORLEVEL% == 0 type "%TMP_RESULT_FILE%" | find /C /I "%PROCESS_NAME%" > "%RESULT_FILE%"
del /q "%TMP_RESULT_FILE%"

rem ������� 䠩� � �����襭��
echo a> "%COMPLETE_FILE%"
