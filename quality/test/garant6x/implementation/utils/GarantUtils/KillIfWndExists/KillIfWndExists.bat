cls
@echo off
:://////////////////////////////////////////////
set WNDCLASS=#32770
set WNDNAME=Мастер установки данных (15%%
set PROCNAME=F1DataSetup.run

rem set WNDCLASS=TLoginForm
rem set WNDNAME=Вход в систему ГАРАНТ
rem set PROCNAME=F1Shell.run
:://////////////////////////////////////////////
echo Waiting for "%WNDCLASS%"\"%WNDNAME%"...

:begin
	KillIfWndExists.exe "%WNDCLASS%" "%WNDNAME%" "%PROCNAME%"
	if ERRORLEVEL 1 echo Continue waiting for "%WNDCLASS%"\"%WNDNAME%"...
rem для завершения работы программы, после 1ого срубания процесса раскомментируйте строку ниже
rem	if ERRORLEVEL 1 exit
goto begin
exit
