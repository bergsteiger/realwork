rem ��⭨� ��� ���������� �ࢥ�

rem ������塞 ini 䠩� � ����ᨬ��� �� ���ᨨ
if exist c:\testing.74.txt goto :update74

if exist c:\testing.73.txt goto :update73

@echo �� ��諨 �� ������ 䫠�� > noflagsupdate.txt

goto end

:update74
copy /b %SERVER_PATH%\garant.74.ini %SERVER_PATH%\garant.ini
goto end


:update73
copy /b %SERVER_PATH%\garant.73.ini %SERVER_PATH%\garant.ini

:end


if exist "%SERVER_PATH%\apps" del /q /f /s "%SERVER_PATH%\apps"

@copy /b %BUILD_PATH%\server\apps "%SERVER_PATH%\apps"
@copy /b %BUILD_PATH%\server\apps\Win9x "%SERVER_PATH%\apps\Win9x"
@copy /b %BUILD_PATH%\server\apps\WinNt "%SERVER_PATH%\apps\WinNt"
@copy /b %BUILD_PATH%\server\apps\WinNt "%SERVER_PATH%\apps\WinNt"