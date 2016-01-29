rem **********************************************************************
rem ********* Скрипт для ежедневного запуска автоматических тестов *******
rem **********************************************************************
rem Запускается из директории, в которой есть утилита psservice (можно 
rem взять у опопссума - ftp://opossum.garant.ru).
rem запускается с двумя параметрами: run_test.bat -OS_TYPE -COUNT_EXEC
rem где OS_TYPE (обязателен) - тип ОС (WINNT либо WIN9X - РЕГИСТР ВАЖЕН!)
rem COUNT_EXEC (необязателен - по умолчанию равен 5) - 
rem количество раз, которое будет запущен тест time_test.exe
rem **********************************************************************

if "%OS%"=="Windows_NT" SET WIN_VER=Winnt
if "%OS%"=="" SET WIN_VER=Win9x

@echo off
SET SERVER_HOST=\\test-07

psservice.exe "%SERVER_HOST%" -u Administrator -p "" stop GarantF1Server

SET PATH_XML=\\ax222\buffer\Timing\Settings\XML
SET SERVER_PATH=T:


@echo off


if exist "%SERVER_PATH%\apps" del /q /f /s "%SERVER_PATH%\apps"

@copy /b \\developer\garant-nemesis\deployment\!daily\server\apps "%SERVER_PATH%\apps"
@copy /b \\developer\garant-nemesis\deployment\!daily\server\apps\Win9x "%SERVER_PATH%\apps\Win9x"
@copy /b \\developer\garant-nemesis\deployment\!daily\server\apps\WinNt "%SERVER_PATH%\apps\WinNt"

@copy /b "\\developer\garant-nemesis\deployment\!daily\support\test\client\%WIN_VER%\timetest.exe" "%SERVER_PATH%\apps\%WIN_VER%\timetest.exe"
@echo off


psservice.exe %SERVER_HOST% -u Administrator -p "" start GarantF1Server

IF "%1"=="" (
SET COUNT_EXECUTE=5
) ELSE (
SET COUNT_EXECUTE=%1
)

@echo on
echo ***************Start %COUNT_EXECUTE% tests (%DATE%::%TIME%)**************** >>"%CD%\result.csv"
type \\developer\garant-nemesis\deployment\!daily\!cvs_tag >>"%CD%\result.csv"
@echo off


for /L %%a in (1,1,%COUNT_EXECUTE%) do (

psservice.exe %SERVER_HOST% -u Administrator -p "" stop GarantF1Server

if exist "%SERVER_PATH%\settings" del /q /f /s "%SERVER_PATH%\settings"

@copy /b \\developer\garant-nemesis\deployment\!daily\server\settings "%SERVER_PATH%\settings"
@copy /b \\developer\garant-nemesis\deployment\!daily\server\settings\userdata "%SERVER_PATH%\settings\userdata"
@copy /b \\developer\garant-nemesis\deployment\!daily\server\settings\xmltools "%SERVER_PATH%\settings\xmltools"
@copy /b \\developer\garant-nemesis\deployment\!daily\server\settings\xmltools\Win9x "%SERVER_PATH%\settings\xmltools\Win9x"
@copy /b \\developer\garant-nemesis\deployment\!daily\server\settings\xmltools\Winnt "%SERVER_PATH%\settings\xmltools\Winnt"

"%SERVER_PATH%\settings\xmltools\%WIN_VER%\F1UsersLoad.exe" -GCMActiveDataPath 2 -GCMDataPath1 "%SERVER_PATH%\data2" -GCMDataPath2 "%SERVER_PATH%\data2" -GCMSettingsDataPath %PATH_XML% -GCMSettingsPath "%SERVER_PATH%\settings" -ORBDottedDecimalAddresses 1 -ORBUseSharedProfiles 1 -ORBLogFile "%SERVER_PATH%\logs\load.log"

psservice.exe %SERVER_HOST% -u Administrator -p "" start GarantF1Server

if NOT exist "%SERVER_PATH%\reports" mkdir "%SERVER_PATH%\reports"
if NOT exist "%SERVER_PATH%\reports\%DATE%" mkdir "%SERVER_PATH%\reports\%DATE%"


"%SERVER_PATH%\apps\%WIN_VER%\timetest.exe" 1>>"%SERVER_PATH%\reports\%DATE%\result_%%a.log" 2>&1
)

@echo on
echo ***************End %COUNT_EXECUTE% tests (%DATE%::%TIME%)**************** >>"%CD%\result.csv"
@echo off

blat -install smtp.garant.ru pugin@garant.ru
blat "%CD%\result.csv" -subject "Result of time test" -to qc@garant.ru

:end
exit
