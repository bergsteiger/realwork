@echo off

:begin
"D:\QC\PSTools\pskill.exe" testcomplete
"D:\QC\PSTools\sleep.exe" 3
"D:\QC\PSTools\pskill.exe" testcomplete
"D:\QC\PSTools\sleep.exe" 3
"D:\QC\PSTools\pskill.exe" testcomplete
"D:\QC\PSTools\sleep.exe" 3

::����᪠�� �஥�� TC
start "TestComplete" "C:\Program Files\Automated QA\TestComplete 6\Bin\testcomplete.exe" "\\strelka\qc\for_RunnerTC6\Scripts\implementation\projects\netSuiteTest\netSuiteTest.pjs"  /run /project:netSuiteTest /unit:netSuiteTest /routine:InstallAndRun /exit /SilentMode

::�訡�� � ���� ������뢠����� ���� ��� ��ࠢ�� ����
::CVS\quality\test\garant6x\implementation\utils\GarantUtils\SendCloseWnd
"D:\QC\PSTools\sleep.exe" 60
"D:\QC\PSTools\send_close.exe" /close #32770 TestComplete
if errorlevel 1 goto begin

::�������� �訡�� (����� ������ �१ 10-15 ��� ��᫥ ����᪠)
"D:\QC\PSTools\sleep.exe" 1000
"D:\QC\PSTools\send_close.exe" /close #32770 "TestComplete.exe - Application Error"
if errorlevel 1 goto begin

:end
exit
