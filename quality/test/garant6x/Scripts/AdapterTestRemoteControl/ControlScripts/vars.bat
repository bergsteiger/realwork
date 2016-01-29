@echo off

rem ��ࠢ���騥
	rem ��⮢� ०��
set IS_TEST_MODE=OFF
	rem ����᪠�� ���� ᭠砫� �� ����� ��設�, ��⥬ �� ��㣮� � �.�. ��� ��ࠫ���쭮
set IS_START_COMP_BY_COMP=OFF
	rem ��� 䠩�� � �業�ਥ� ��� ��⮢
set SCENARIO_FILE_NAME=scenario2.xml
	rem ����প� ����� ����᪮� �����⮢ �� 㤠������ ��設��
set SLEEP_TIME=0&
	rem ��� 䠩�� � ᯨ᪮� 㤠������ ��設
set COMPS_LIST=comps.lst

rem ��騥
	rem ��� ���짮��⥫�, � ����� �㤥� ��������� �� 㤠����� ��設�
set USER_NAME=qc
	rem ��஫� ���짮��⥫�, � ������ ���ண� �㤥� ���������� �� 㤠����� ��設�
set PASSWORD=22222
	rem ���� � �⨫�⠬ pstools
set PSTOOLS_PATH=\\strelka\qc\RemoteAdapterTest\PsTools
	rem �⥢�� ���� � ��୥��� ����� � ��⠬� � ��⭨����
set NETWORK_PATH=\\strelka.garant.ru\qc\RemoteAdapterTest
	rem ��ࠬ����, � ����묨 �㤥� ����᪠���� ������� start, ����᪠��� psexec/pstools/pslist/����
set START_PARAMS=/MIN /BELOWNORMAL

rem �ᯮ����⥫��
	rem ���� � ����� � �ࠢ���騬� ��⭨���� (����� ��⭨��)
set CONTROL_NETWORK_PATH=%NETWORK_PATH%\ControlScripts
	rem ���� � ����� � ��⠬�
set AT_NETWORK_PATH=%NETWORK_PATH%\AdapterTest
	rem ���� � 䠩�� � �業�ਥ�
set SCENARIO_FILE_PATH=%AT_NETWORK_PATH%\%SCENARIO_FILE_NAME%
	rem ���� � �⨫�� sleep.exe
set SLEEP_EXE=%AT_NETWORK_PATH%\sleep.exe
	rem ��騥 ��ࠬ���� ��� ��� �⨫�� pstool
set PSTOOLS_COMMON_PARAMS=-accepteula&
	rem ��� 䠩�� ���᮫쭮�� ��� ��� ���७��
set TEST_NAME=F1AdapterTest&


if not exist "%SCENARIO_FILE_PATH%" (
	echo ���� �業��� �� �������!
	exit 1
)


if "%IS_TEST_MODE%" equ "ON" (
	set START=echo
) else if "%IS_TEST_MODE%" equ "OFF" (
	set START=start
) else (
	echo �������⭮� ���祭�� IS_TEST_MODE ^(%IS_TEST_MODE%^)
	exit 1
)


if "%IS_START_COMP_BY_COMP%" equ "ON" (
	set START_WAIT_PARAM=/WAIT
) else if "%IS_START_COMP_BY_COMP%" equ "OFF" (
	set START_WAIT_PARAM=
) else (
	echo �������⭮� ���祭�� IS_START_COMP_BY_COMP ^(%IS_START_COMP_BY_COMP%^)
	exit 1
)