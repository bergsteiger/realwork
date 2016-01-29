@echo off
rem - �᭮���� *.bat 䠩� ��� ����᪠ ��⮬���᪮�� ���஢����

rem - ��।��塞 ��騥 ��६���� ��� ��� *.bat 䠩���

rem ��ࠬ���� �ࢨ� � ����� �ਫ������
rem ��� �����
SET SERVER_PROCESS_NAME=F1Server
rem ��� �ࢨ�
SET SERVER_SERVICE_NAME=GarantF1Server

rem ������⢮ ���権 �������� ��⠭���� �ࢥ�
SET WAIT_COUNT=10
rem �६� �������� �� ᫥��饩 �஢�ન ����⢮����� �����
SET WAIT_TIMEOUT=10

rem %1 ���� � ����ਡ�⨢�
SET DISTRIB_PATH=\\p3single05\works\T_NEMESIS_6_4_0_129
rem %2 ���� � ��⠫��� � �⨫�⠬� �������� pstools
SET PS_TOOLS_PATH=c:\pstools
rem %3 ���� � ��⠫��� � �⨫�⮩ sleep.exe
SET SLEEP_PATH=%PS_TOOLS_PATH%
rem %4 ���� � ��⠫��� � �ࢥ஬
SET SERVER_PATH=H:
rem %5 ��� ��� �� ���ன ��⠭����� �ࢥ�
SET SERVER_HOST=\\p4single10
rem %6 ���� � ��⠫��� � �⨫�⮩ blat.exe ��� ���뫪� ���⮢�� ᮮ�饭��
SET BLAT_PATH=%PS_TOOLS_PATH%
rem %7 ���� � ��⠫��� TestComplete
SET TC_PATH="F:\Program Files\Automated QA\TestComplete 3\TestComplete.exe"
rem %8 ���� � ��⠫��� c 䠩���� �஥�� TestComplete
SET TC_PROJECT_PATH=f:\cvs\quality\test\garant6x\implementation\main
SET BUILD_PATH=%DISTRIB_PATH%\!daily

rem %9 ��ࠬ���� ���뫪� �����
SET MAIL_TO=qc@garant.ru
SET MAIL_FROM=AutoTest@garant.ru
SET SMTP_SRV=smtp.garant.ru


rem - ���� ᡮન ����ਡ�⨢�

rem - !!! ��� 㤠������� ����㯠 � ��㣨� �� (���ଥ� � �ᯮ�짮������ �⨫�� pstools) 
rem   �㤥� �ᯮ�짮������ �����\��஫� = qc\22222

REM :loop
REM if exist "%DISTRIB_PATH%\!daily.build-script-schedule.lock" %SLEEP_PATH%\sleep 600 & goto :loop

REM call common.update_server.bat

rem - ���塞 ᥪ�� ॥��� [HKEY_CURRENT_USER\Software\Garant.F1]
rem ⠪�� ��ࠧ��, �⮡� �� ����᪥ ������ �ᯮ�짮����� ini 䠩� T:\garant.ini

REM call redirect_client.bat

rem - ��᫥����⥫쭮� �믮������ ��⮬���᪨� ��⮢

rem  ����� ���᮫��� (�++) �����⮢ ��� ���஢���� �ந�����⥫쭮��
REM call 01.Run_Console_Tests.bat

rem  ����� GUI �ਯ⮢ ��� ����� �ந�����⥫쭮� �� ������
call 02.Run_GUI_Perf_Tests_custom.bat
REM call stop.bat

rem  ����� GUI �ਯ⮢ ��� ����� ���ॡ����� ����� �� ������ � �ࢥ�
REM call 03.Run_GUI_Mem_Tests.bat