cls
@echo off
:://////////////////////////////////////////////
set WNDCLASS=#32770
set WNDNAME=����� ��⠭���� ������ (15%%
set PROCNAME=F1DataSetup.run

rem set WNDCLASS=TLoginForm
rem set WNDNAME=�室 � ��⥬� ������
rem set PROCNAME=F1Shell.run
:://////////////////////////////////////////////
echo Waiting for "%WNDCLASS%"\"%WNDNAME%"...

:begin
	KillIfWndExists.exe "%WNDCLASS%" "%WNDNAME%" "%PROCNAME%"
	if ERRORLEVEL 1 echo Continue waiting for "%WNDCLASS%"\"%WNDNAME%"...
rem ��� �����襭�� ࠡ��� �ணࠬ��, ��᫥ 1��� ��㡠��� ����� �᪮�������� ��ப� ����
rem	if ERRORLEVEL 1 exit
goto begin
exit
