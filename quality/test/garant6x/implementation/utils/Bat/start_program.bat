rem echo off&setlocal

set COMPNAME=%1
set USERNAME=%2
set PASSWORD=%3

if "%COMPNAME%" == "" (
	echo Usage: %~n0%~x0 ^<compName^> ^<userName^> ^<password^> ^<path_to_program^> [program params...]
	exit
)

rem Получаем имя приложения, которое будем запускать
set PROGRAM="%~4"
set PROGRAM_EXT=%~x4
set TASKNAME=%~n4
if not exist %PROGRAM% (
	echo Не могу найти файл %PROGRAM%
	exit
)

rem Получаем параметры приложения
set PARAMS=
:loop
shift
if "%4"=="" goto end_of_loop
set PARAMS=%PARAMS% %4
goto loop
:end_of_loop


rem Создаем запускающий батник
set BAT_FILE_NAME="%TEMP%\%TASKNAME%%RANDOM%.bat"
if /i "%PROGRAM_EXT%" EQU ".bat" (
	echo call %PROGRAM% %PARAMS% > %BAT_FILE_NAME%
) else (
	echo %PROGRAM% %PARAMS% > %BAT_FILE_NAME%
)
echo del /Q %BAT_FILE_NAME% >> %BAT_FILE_NAME%

echo Будем запускать программу: %PROGRAM%
echo С параметрами: %PARAMS%

for /f "tokens=1-2 delims=:" %%B in ('TIME /T') do (
	set HOUR=%%B
	set MINUTE=%%C
)

rem Определяем, это виста или нет
set VER_OUTPUT=%TEMP%\ver_output.txt
del /Q %VER_OUTPUT%
ver | find "6." > %VER_OUTPUT%
for %%A in (%VER_OUTPUT%) do SET VO_SIZE=%%~zA
del /Q %VER_OUTPUT%

if %VO_SIZE%==0 (
	set VISTA=NO
) else (
	set VISTA=YES
)

if %VISTA%==YES (
	set ADD_PARAMS=/IT
) else (
	set ADD_PARAMS=
)

schtasks /delete /tn %TASKNAME% /f
schtasks /create /tn %TASKNAME% /tr %BAT_FILE_NAME% /sc ONCE /st %HOUR%:%MINUTE%:00 /s %COMPNAME% /ru %USERNAME% /rp %PASSWORD% %ADD_PARAMS%
schtasks /run /tn %TASKNAME%
