@echo off

:begin
"D:\QC\PSTools\pskill.exe" testcomplete
"D:\QC\PSTools\sleep.exe" 3
"D:\QC\PSTools\pskill.exe" testcomplete
"D:\QC\PSTools\sleep.exe" 3
"D:\QC\PSTools\pskill.exe" testcomplete
"D:\QC\PSTools\sleep.exe" 3

::Запускаем проект TC
start "TestComplete" "C:\Program Files\Automated QA\TestComplete 6\Bin\testcomplete.exe" "\\strelka\qc\for_RunnerTC6\Scripts\implementation\projects\netSuiteTest\netSuiteTest.pjs"  /run /project:netSuiteTest /unit:netSuiteTest /routine:InstallAndRun /exit /SilentMode

::Ошибка в виде незакрываемого окна для отправки отчета
::CVS\quality\test\garant6x\implementation\utils\GarantUtils\SendCloseWnd
"D:\QC\PSTools\sleep.exe" 60
"D:\QC\PSTools\send_close.exe" /close #32770 TestComplete
if errorlevel 1 goto begin

::Виндовая ошибка (может появиться через 10-15 мин после запуска)
"D:\QC\PSTools\sleep.exe" 1000
"D:\QC\PSTools\send_close.exe" /close #32770 "TestComplete.exe - Application Error"
if errorlevel 1 goto begin

:end
exit
