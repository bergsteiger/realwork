ECHO %DATE% %TIME%
rem %1 �㪢� �⥢��� ��᪠
SET NETWORK_DRIVE=%1
SET PATH=%PATH%;%NETWORK_DRIVE%\.EXTERNAL\Perl\bin
rem %2 ���� � 䠩�� TestComplete\Execute
SET TC_PATH=%2
rem %3 ��� ��� �� ���ன ��⠭����� �ࢥ�
SET SERVER_HOST=%3
rem %4 ��� ��⠫��� ᡮન � ��室������
SET BUILD_NAME=%4
rem %5 ���� � �⠫������ ini 䠩��
SET ETALON_PATH=Etalon.ini
rem %6 ���� c xml 䠩�� � १���⠬� ��� ����७��
SET XML_FILE=%6


SET JOURNAL_FILE=journal.%COMPUTERNAME%.test
SET CONSOLE_JOURNAL_FILE=journal_console.%COMPUTERNAME%.test
SET GUI_JOURNAL_FILE=journal_gui.%COMPUTERNAME%.test
SET GUITestCount=11
SET ConsoleTestCount=6

rem ��ࠬ���� �ࢨ� � ����� �ਫ������
rem ��� �����
SET SERVER_PROCESS_NAME=F1Server
rem ��� �ࢨ�
SET SERVER_SERVICE_NAME=Garant.Application.Server

rem ������⢮ ���権 �������� ��⠭���� �ࢥ�
SET WAIT_COUNT=10
rem �६� �������� �� ᫥��饩 �஢�ન ����⢮����� �����
SET WAIT_TIMEOUT=10


if not exist "%JOURNAL_FILE%" exit /b

rem - �᭮���� *.bat 䠩� ��� ����᪠ ��⮬���᪮�� ���஢����

rem - ��।��塞 ��騥 ��६���� ��� ��� *.bat 䠩���

rem %1 ���� � ����ਡ�⨢�
SET DISTRIB_PATH=\\lin-store\garant-nemesis\deployment
rem SET DISTRIB_PATH=\\P3SINGLE05\works\NEMESIS\T_GARANTF1-7_09_0_130
rem %2 ���� � ��⠫��� � �⨫�⠬� �������� pstools
SET PS_TOOLS_PATH=%NETWORK_DRIVE%\.EXTERNAL\pstools_sleep
rem %3 ���� � ��⠫��� � �⨫�⮩ sleep.exe
SET SLEEP_PATH=%PS_TOOLS_PATH%
rem %4 ���� � ��⠫��� � �ࢥ஬
SET SERVER_PATH=T:\

rem %6 ���� � ��⠫��� � �⨫�⮩ blat.exe ��� ���뫪� ���⮢�� ᮮ�饭��
SET BLAT_PATH=%NETWORK_DRIVE%\.EXTERNAL\blat


rem %8 ���� � ��⠫��� c 䠩���� �஥�� TestComplete
rem // MY STUB
SET TC_PROJECT_PATH=%NETWORK_DRIVE%\PERF.7.10\implementation\projects\GUI_Perfomance_speed\GUI_Perfomance_speed
SET BUILD_PATH=%DISTRIB_PATH%\%BUILD_NAME%


SET HSDX_PATH=%NETWORK_DRIVE%\.EXTERNAL\HySnapDX

rem %10 ��ࠬ���� ���뫪� �����
SET MAIL_TO=qc@garant.ru
SET MAIL_FROM=AutoTest@garant.ru
SET SMTP_SRV=smtp.garant.ru

rem ���� � 䠩��\䫠�� �믮������ �᭮���� ��⮢ �� �ந�����⥫쭮���
SET LOC_FILE=perfomance.%COMPUTERNAME%.loc

rem ��� � १���⠬� ��⮢
IF NOT EXIST %NETWORK_DRIVE%\PERF.7.10\[%COMPUTERNAME%]  mkdir %NETWORK_DRIVE%\PERF.7.10\[%COMPUTERNAME%]
SET LOG_DIR=%NETWORK_DRIVE%\PERF.7.10\[%COMPUTERNAME%]

rem ����塞 �� ������, ����� ����� ������� �� �।���� ����᪮�
call common.find_kill_no_snap.bat hsdx
call common.find_kill.bat TestComplete.ex
call common.find_kill.bat drwtsn32
call common.find_kill.bat f1shell

rem - ���� ᡮન ����ਡ�⨢�

rem - !!! ��� 㤠������� ����㯠 � ��㣨� �� (���ଥ� � �ᯮ�짮������ �⨫�� pstools) 
rem   �㤥� �ᯮ�짮������ �����\��஫� = qc\22222


REM ���⠢�塞 䫠� ��� ��㣨� �ᯨᠭ��, �� ��砫��� �믮������ ��⮢ �� �ந�����⥫쭮���
echo waiting 4 distrib comilation > "%LOC_FILE%"

:loop
if exist "%DISTRIB_PATH%\!daily.build-script-schedule.lock" %SLEEP_PATH%\sleep 600 & goto :loop

rem ��।��塞 ��६����� � ⥪�饩 ���ᨥ�
SET VERSION=UNKNOWN
for /F %%i IN ('findstr "T_GARANTF1.*" %BUILD_PATH%\!cvs_tag') DO SET VERSION=%%i

echo '%VERSION%' >> "%LOC_FILE%"

rem - ��᫥����⥫쭮� �믮������ ��⮬���᪨� ��⮢



rem �஢��塞 १���� ���᪠
for /F %%i IN ('findstr "START_TEST" %JOURNAL_FILE%') DO (
	@echo First start

	rem ��⠭���� �ࢥ� � �஢�ઠ ���� ��। �����������
	call common.stop_service_remote.bat %SERVER_PROCESS_NAME% %SERVER_HOST% qc "22222" %SERVER_SERVICE_NAME%
	%SLEEP_PATH%\sleep 33
	perl check_log.pl -f "%SERVER_PATH%\logs\gar_srv.log" -s "User database damage!!!"

	call common.update_server.bat

	rem - ���塞 ᥪ�� ॥��� [HKEY_CURRENT_USER\Software\Garant.F1]
	rem ⠪�� ��ࠧ��, �⮡� �� ����᪥ ������ �ᯮ�짮����� ini 䠩� T:\garant.ini

	call redirect_client.bat

	@echo %ConsoleTestCount% >%CONSOLE_JOURNAL_FILE%
	@echo %GUITestCount% >%GUI_JOURNAL_FILE%
	@echo GO >"%JOURNAL_FILE%"
	del /q/ /f 00.Main_Run_All_Autotest.%COMPUTERNAME%.78.log
)

REM for /F  %%j in (%CONSOLE_JOURNAL_FILE%) do (
REM 	@echo Console=%%j >>1.txt 
REM 	SET ConsoleCount=%%j
REM 	call 01.Run_Console_Tests.bat
REM )
del /q /f "%CONSOLE_JOURNAL_FILE%"

for /F  %%k in (%GUI_JOURNAL_FILE%) do (
	@echo GUI=%%k >>1.txt 
	SET GUICount=%%k
	call 02.Run_GUI_Perf_Tests_speed.bat
)
del /q /f "%GUI_JOURNAL_FILE%"


REM ����塞 䫠� �믮������ ��⮢ �ந�����⥫쭮��
del /q /f "%LOC_FILE%"
del /q /f "%JOURNAL_FILE%"

exit /b 0