rem ��⭨� ��� ����� ����஥� �� ����

rem ���� � ��⠫��� � ���묨 ����ன����
SET PATH_SETTINGS=%BUILD_PATH%\server\settings

if exist "%SERVER_PATH%\settings" rmdir /q/s "%SERVER_PATH%\settings"
if NOT exist "%SERVER_PATH%\settings" mkdir "%SERVER_PATH%\settings"

rem ******************************copy etalon settings**********************************
xcopy "%PATH_SETTINGS%" "%SERVER_PATH%\settings" /y/e
rem ********************************************************************************