ECHO OFF

REM �ਬ�� *.bat 䠩�� ��� ���᪠ �ᯨᠭ��.
REM ���� <perf_op> ����� �ਭ����� ᫥���騥 ���祭��:
REM �����_���������
REM ����⨥_�������_���
REM ���⥪��_�_���㬥��
REM ����_���⥪��_�१_��_���

ECHO ON

rem ��।��塞 ��⠫�� ��� 䠩��� � ������ � ⥪���� ����
SET LOG_DIR=c:\!perf_logs
SET CUR_DATE=%DATE%
SET CYCLE_COUNT=5

rem ��⠭�������� �ࢥ�; ���� 40 ᥪ.; ��६ ���� ����ன��; ���� 5 ᥪ.; ����᪠�� �ࢥ�
REM call common.stop_service_remote.bat %SERVER_PROCESS_NAME% %SERVER_HOST% qc "22222" %SERVER_SERVICE_NAME%
REM %SLEEP_PATH%\sleep.exe 40
REM call common.get_clean_settings.bat
REM %SLEEP_PATH%\sleep.exe 5
call common.do_clean_settings.bat

call common.find_kill.bat TestComplete.ex
REM %PS_TOOLS_PATH%\psservice.exe %SERVER_HOST% -u qc -p "22222" start GarantF1Server
rem ��������㥬 ���짮��⥫� "perf" � ���⠢�塞 ����室��� ����ன��, ��᫥ �⮣� �����窠 ����뢠����.
%TC_PATH% /run /project:GUI_Perfomance /unit:GUI_Perfomance /routine:Prepare_GUI_Shell /exit /SilentMode "%TC_PROJECT_PATH%\GUI_Perfomance.mds" gui_login=perf gui_password=perf log_dir=%LOG_DIR% cur_date="%CUR_DATE%"
call common.find_kill.bat drwtsn32
call common.find_kill.bat f1shell

rem �믮������ ��⮬���᪨� ��⮢

REM ��ࠬ���� �஥�� "reboot_delay=140000" "ps_tools_path=%PS_TOOLS_PATH%" ⥯��� �� �ᯮ�������

for /L %%i in (1,1,%CYCLE_COUNT%) do (
  call common.find_kill.bat hsdx.ex
  call common.find_kill.bat TestComplete.ex
  call common.reboot_server.bat
  %TC_PATH% /run /project:GUI_Perfomance /unit:GUI_Perfomance /routine:RunPerfomanceTests /exit /SilentMode "%TC_PROJECT_PATH%\GUI_Perfomance.mds" perf_op=�����_��������� max_itr=1 log_dir=%LOG_DIR% cur_date="%CUR_DATE%"
  call common.find_kill.bat drwtsn32
  call common.find_kill.bat f1shell
  call common.find_kill.bat hsdx.ex
)

for /L %%i in (1,1,%CYCLE_COUNT%) do (
  call common.find_kill.bat hsdx.ex
  call common.find_kill.bat TestComplete.ex
  call common.reboot_server.bat 
  %TC_PATH% /run /project:GUI_Perfomance /unit:GUI_Perfomance /routine:RunPerfomanceTests /exit /SilentMode "%TC_PROJECT_PATH%\GUI_Perfomance.mds" perf_op=���⥪��_�_���㬥�� max_itr=1 log_dir=%LOG_DIR% cur_date="%CUR_DATE%"
  call common.find_kill.bat drwtsn32
  call common.find_kill.bat f1shell
  call common.find_kill.bat hsdx.ex
)

for /L %%i in (1,1,%CYCLE_COUNT%) do (
  call common.find_kill.bat hsdx.ex
  call common.find_kill.bat TestComplete.ex
  call common.reboot_server.bat 
  %TC_PATH% /run /project:GUI_Perfomance /unit:GUI_Perfomance /routine:RunPerfomanceTests /exit /SilentMode "%TC_PROJECT_PATH%\GUI_Perfomance.mds" perf_op=���⥪��_�_ᯨ᪥ max_itr=1 log_dir=%LOG_DIR% cur_date="%CUR_DATE%"
  call common.find_kill.bat drwtsn32
  call common.find_kill.bat f1shell
  call common.find_kill.bat hsdx.ex
)


for /L %%i in (1,1,%CYCLE_COUNT%) do (
  call common.find_kill.bat hsdx.ex
  call common.find_kill.bat TestComplete.ex
  call common.reboot_server.bat 
  %TC_PATH% /run /project:GUI_Perfomance /unit:GUI_Perfomance /routine:RunPerfomanceTests /exit /SilentMode "%TC_PROJECT_PATH%\GUI_Perfomance.mds" perf_op=����_���⥪��_�१_��_��� max_itr=1 log_dir=%LOG_DIR% cur_date="%CUR_DATE%"
  call common.find_kill.bat drwtsn32
  call common.find_kill.bat f1shell
  call common.find_kill.bat hsdx.ex
)


for /L %%i in (1,1,%CYCLE_COUNT%) do (
  call common.find_kill.bat hsdx.ex
  call common.find_kill.bat TestComplete.ex
  call common.reboot_server.bat 
  %TC_PATH% /run /project:GUI_Perfomance /unit:GUI_Perfomance /routine:RunPerfomanceTests /exit /SilentMode "%TC_PROJECT_PATH%\GUI_Perfomance.mds" perf_op=����⨥_�������_��� max_itr=1 log_dir=%LOG_DIR% cur_date="%CUR_DATE%"
  call common.find_kill.bat drwtsn32
  call common.find_kill.bat f1shell
  call common.find_kill.bat hsdx.ex
)

rem ���뫠�� ��� १���⮢ �ந�����⥫쭮�� ��᫥ ���᫥��� �।���� �६��� ����প�
perl report2.pl "%LOG_DIR%\%DATE%.log"
%BLAT_PATH%\blat -install %SMTP_SRV% %MAIL_FROM%
%BLAT_PATH%\blat "%LOG_DIR%\%DATE%.log" -subject "AutoTest: Result of GUI Perfomance test" -to %MAIL_TO% -charset windows-1251
