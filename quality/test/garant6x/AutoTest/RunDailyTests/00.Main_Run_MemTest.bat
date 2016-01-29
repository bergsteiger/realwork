rem @echo off
rem - �᭮���� *.bat 䠩� ��� ����᪠ ��⮬���᪮�� ���஢����

rem - ��।��塞 ��騥 ��६���� ��� ��� *.bat 䠩���

rem ��ࠬ���� �ࢨ� � ����� �ਫ������
rem ��� �����
SET SERVER_PROCESS_NAME=F1Server
rem ��� �ࢨ�
SET SERVER_SERVICE_NAME=Garant.Application.Server

rem ������⢮ ���権 �������� ��⠭���� �ࢥ�
SET WAIT_COUNT=10
rem �६� �������� �� ᫥��饩 �஢�ન ����⢮����� �����
SET WAIT_TIMEOUT=10

rem %1 ���� � ����ਡ�⨢�
SET DISTRIB_PATH=\\developer\garant-nemesis-ro\deployment
rem %2 ���� � ��⠫��� � �⨫�⠬� �������� pstools
SET PS_TOOLS_PATH=c:\pstools
rem %3 ���� � ��⠫��� � �⨫�⮩ sleep.exe
SET SLEEP_PATH=%PS_TOOLS_PATH%
rem %4 ���� � ��⠫��� � �ࢥ஬
SET SERVER_PATH=C:\#MemTest.server
rem %5 ��� ��� �� ���ன ��⠭����� �ࢥ�
SET SERVER_HOST=\\p4core10-vm1
rem %6 ���� � ��⠫��� � �⨫�⮩ blat.exe ��� ���뫪� ���⮢�� ᮮ�饭��
SET BLAT_PATH=%PS_TOOLS_PATH%
rem %7 ���� � ��⠫��� TestComplete
SET TC_PATH="C:\Program Files\Automated QA\TestComplete 5\Bin\TestComplete.exe"
rem %8 ���� � ��⠫��� c 䠩���� �஥�� TestComplete
SET TC_PROJECT_PATH=C:\CVS\quality\test\garant6x\implementation\projects\MemoryUsing\MemoryUsing
SET BUILD_PATH=%DISTRIB_PATH%\!daily-GARANTF1-7_02

rem %9 ��ࠬ���� ���뫪� �����
SET MAIL_TO=qc@garant.ru
SET MAIL_FROM=AutoTest@garant.ru
SET SMTP_SRV=smtp.garant.ru


rem - ���� ᡮન ����ਡ�⨢�

rem - !!! ��� 㤠������� ����㯠 � ��㣨� �� (���ଥ� � �ᯮ�짮������ �⨫�� pstools) 
rem   �㤥� �ᯮ�짮������ �����\��஫� = qc\22222

:loop
if not exist "%BUILD_PATH%\!success" %SLEEP_PATH%\sleep 60 & goto :loop

rem ��⠭���� �ࢥ� � �஢�ઠ ���� ��। �����������
call common.stop_service_remote.bat %SERVER_PROCESS_NAME% %SERVER_HOST% qc "22222" %SERVER_SERVICE_NAME%
%SLEEP_PATH%\sleep 33
perl check_log.pl -f "%SERVER_PATH%\logs\gar_srv.log" -s "User database damage!!!"

call common.update_server.bat

rem - ���塞 ᥪ�� ॥��� [HKEY_CURRENT_USER\Software\Garant.F1]
rem ⠪�� ��ࠧ��, �⮡� �� ����᪥ ������ �ᯮ�짮����� ini 䠩� T:\garant.ini

call redirect_mem_client.bat

rem - ��᫥����⥫쭮� �믮������ ��⮬���᪨� ��⮢

rem  ����� GUI �ਯ⮢ ��� ����� ���ॡ����� ����� �� ������ � �ࢥ�
call 03.Run_GUI_Mem_Tests.bat