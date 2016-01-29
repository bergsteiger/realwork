@echo off
rem ----------------------------------------------------------------------------------
rem - '���ਤ��' *.bat 䠩� ����騩 �� 
rem 00.Main_Run_All_Autotest.bat � 02.Run_GUI_Perf_Tests_speed.bat
rem ����᪠���� �� � ��᫥ ��⮢ �� ��⮩稢���� ��� ��।������ ���ﭨ� ������ ࠡ��
rem ��⥬� �� �ந�����⥫쭮���
rem ----------------------------------------------------------------------------------

rem ��������������������� ����䨪��� 00.Main_Run_All_Autotest.bat ���������������������
rem - ��।��塞 ��騥 ��६���� ��� ��� *.bat 䠩���

rem %1 ���� � ����ਡ�⨢�
rem !�� �ᯮ������ SET DISTRIB_PATH=\\developer\garant-nemesis-ro\deployment
rem %2 ���� � ��⠫��� � �⨫�⠬� �������� pstools
SET PS_TOOLS_PATH=c:\pstools
rem %3 ���� � ��⠫��� � �⨫�⮩ sleep.exe
SET SLEEP_PATH=%PS_TOOLS_PATH%
rem %4 ���� � ��⠫��� � �ࢥ஬
SET SERVER_PATH=\\strelka.garant.ru\qc\client
rem %5 ��� ��� �� ���ன ��⠭����� �ࢥ�
rem !�� �ᯮ������ SET SERVER_HOST=\\test-07
rem %6 ���� � ��⠫��� � �⨫�⮩ blat.exe ��� ���뫪� ���⮢�� ᮮ�饭��
SET BLAT_PATH=%PS_TOOLS_PATH%
rem %7 ���� � ��⠫��� TestComplete
SET TC_PATH="F:\Program Files\Automated QA\TestComplete 3\TestComplete.exe"
rem %8 ���� � ��⠫��� c 䠩���� �஥�� TestComplete
SET TC_PROJECT_PATH=f:\cvs\quality\test\garant6x\implementation\main
rem !�� �ᯮ������ SET BUILD_PATH=%DISTRIB_PATH%\!daily
rem %9 ���� � �⠫������ ini 䠩��
SET ETALON_PATH=Etalon.ini


rem %10 ��ࠬ���� ���뫪� �����
SET MAIL_TO=qc@garant.ru
SET MAIL_FROM=AutoTest@garant.ru
SET SMTP_SRV=smtp.garant.ru

rem �஢��塞 ࠡ���� �� �᭮��� ᪨��� �� �ந�����⥫쭮���
:loop 
if exist "%LOC_FILE%"  %SLEEP_PATH%\sleep 600 & goto :loop

rem ���� � 䠩��\䫠�� �믮������ �᭮���� ��⮢ �� �ந�����⥫쭮���
rem !�� �ᯮ������ SET LOC_FILE=perfomance.loc

rem - ���� ᡮન ����ਡ�⨢�

rem - !!! ��� 㤠������� ����㯠 � ��㣨� �� (���ଥ� � �ᯮ�짮������ �⨫�� pstools) 
rem   �㤥� �ᯮ�짮������ �����\��஫� = qc\22222


REM ���⠢�塞 䫠� ��� ��㣨� �ᯨᠭ��, �� ��砫��� �믮������ ��⮢ �� �ந�����⥫쭮���
rem !�� �ᯮ������ echo waiting 4 distrib comilation > "%LOC_FILE%"

rem !�� �ᯮ������ :loop
rem !�� �ᯮ������ if exist "%DISTRIB_PATH%\!daily.build-script-schedule.lock" %SLEEP_PATH%\sleep 600 & goto :loop

rem ��।��塞 ��६����� � ⥪�饩 ���ᨥ�
rem !�� �ᯮ������ SET VERSION=UNKNOWN
rem !�� �ᯮ������ for /F %%i IN ('findstr "T_NEMESIS.*" %BUILD_PATH%\!cvs_tag') DO SET VERSION=!VERSION! %%i

rem !�� �ᯮ������ echo '%VERSION%' >> "%LOC_FILE%"

rem ��⠭���� �ࢥ� � �஢�ઠ ���� ��। �����������
rem !�� �ᯮ������ %PS_TOOLS_PATH%\psservice.exe "%SERVER_HOST%" -u qc -p "22222" stop GarantF1Server
rem !�� �ᯮ������ %SLEEP_PATH%\sleep 33
rem !�� �ᯮ������ perl check_log.pl -f "%SERVER_PATH%\logs\gar_srv.log" -s "User database damage!!!"

rem !�� �ᯮ������ call common.update_server.bat

rem - ���塞 ᥪ�� ॥��� [HKEY_CURRENT_USER\Software\Garant.F1]
rem ⠪�� ��ࠧ��, �⮡� �� ����᪥ ������ �ᯮ�짮����� ini 䠩� T:\garant.ini

call redirect_class_client.bat

rem - ��᫥����⥫쭮� �믮������ ��⮬���᪨� ��⮢

rem  ����� ���᮫��� (�++) �����⮢ ��� ���஢���� �ந�����⥫쭮��
rem !�� �ᯮ������ call 01.Run_Console_Tests.bat

rem  ����� GUI �ਯ⮢ ��� ����� �ந�����⥫쭮� �� ������
rem !�� �ᯮ������ call 02.Run_GUI_Perf_Tests_speed.bat

rem  ����� GUI �ਯ⮢ ��� ����� ���ॡ����� ����� �� ������ � �ࢥ�
REM call 03.Run_GUI_Mem_Tests.bat

REM ����塞 䫠� �믮������ ��⮢ �ந�����⥫쭮��
rem !�� �ᯮ������ del "%LOC_FILE%"
rem ��������������������� >EOF ����䨪��� 00.Main_Run_All_Autotest.bat ���������������������
rem ��������������������� ����䨪��� 02.Run_GUI_Perf_Tests_speed.bat ���������������������

rem ��।��塞 ��⠫�� ��� 䠩��� � ������ � ⥪���� ����
SET LOG_DIR=c:\!perf_logs\class
SET CUR_DATE=%DATE%
SET CYCLE_COUNT=1

rem ��⠭�������� �ࢥ�; ���� 40 ᥪ.; ��६ ���� ����ன��; ���� 5 ᥪ.; ����᪠�� �ࢥ�
rem !�� �ᯮ������ %PS_TOOLS_PATH%\psservice.exe "%SERVER_HOST%" -u qc -p "22222" stop GarantF1Server
rem !�� �ᯮ������ %SLEEP_PATH%\sleep.exe 40
rem !�� �ᯮ������ call common.do_clean_settings.bat 
rem !�� �ᯮ������ %SLEEP_PATH%\sleep.exe 5
call common.find_kill_no_snap.bat hsdx
call common.find_kill.bat TestComplete.ex
rem !�� �ᯮ������ %PS_TOOLS_PATH%\psservice.exe "%SERVER_HOST%" -u qc -p "22222" start GarantF1Server
rem ��������㥬 ���짮��⥫� "perf" � ���⠢�塞 ����室��� ����ன��, ��᫥ �⮣� �����窠 ����뢠����.
%TC_PATH% /RunAndExit %TC_PROJECT_PATH%\Prepare_GUI_Shell.mds gui_login=perf gui_password=perf log_dir=%LOG_DIR% cur_date="%CUR_DATE%"
call common.find_kill.bat drwtsn32
call common.find_kill.bat f1shell
call common.find_kill_no_snap.bat hsdx

rem �믮������ ��⮬���᪨� ��⮢

REM ��ࠬ���� �஥�� "reboot_delay=140000" "ps_tools_path=%PS_TOOLS_PATH%" ⥯��� �� �ᯮ�������

for /L %%i in (1,1,%CYCLE_COUNT%) do (
	call common.find_kill_no_snap.bat hsdx
  call common.find_kill.bat TestComplete.ex
rem !�� �ᯮ������  call common.reboot_server.bat 
  %TC_PATH% /RunAndExit %TC_PROJECT_PATH%\GUI_Perfomance_speed.mds log_dir=%LOG_DIR% cur_date="%CUR_DATE%"
  call common.find_kill.bat drwtsn32
  call common.find_kill.bat f1shell
	call common.find_kill_no_snap.bat hsdx
)

rem ���뫠�� ��� १���⮢ �ந�����⥫쭮�� ��᫥ ���᫥��� �।���� �६��� ����প�
perl report2.pl -res_file "%LOG_DIR%\%DATE%.log" -log_file cmp.log -etalon_file "%ETALON_PATH%"
rem !�� �ᯮ������ type %BUILD_PATH%\!cvs_tag >>"%LOG_DIR%\%DATE%.log"
%BLAT_PATH%\blat -install %SMTP_SRV% %MAIL_FROM%
%BLAT_PATH%\blat "%LOG_DIR%\%DATE%.log" -subject "AutoTest: CLASS ROOM GUI Perfomance"  -to %MAIL_TO% -charset windows-1251
rem !�� �ᯮ������ if exist cmp.log type %BUILD_PATH%\!cvs_tag >>"cmp.log"
rem !�� �ᯮ������ if exist cmp.log %BLAT_PATH%\blat cmp.log -subject "AutoTest: Etalon dif of GUI Perfomance test %VERSION%" -to %MAIL_TO% -charset windows-1251
rem ��������������������� >EOF ����䨪��� 02.Run_GUI_Perf_Tests_speed.bat ���������������������