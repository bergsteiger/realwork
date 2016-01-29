@echo off

:begin
"D:\QC\PSTools\pskill.exe" testcomplete
"D:\QC\PSTools\sleep.exe" 5
"D:\QC\PSTools\pskill.exe" testcomplete
"D:\QC\PSTools\sleep.exe" 5

::Запускаем проект TC
start "TestComplete" "C:\Program Files\Automated QA\TestComplete 6\Bin\testcomplete.exe" "\\strelka\qc\for_RunnerTC6\Scripts\implementation\projects\netSuiteTest\netSuiteTest.pjs"  /run /project:netSuiteTest /unit:netSuiteTest /routine:StartDailyTests /exit /SilentMode

::Ошибка в виде незакрываемого окна для отправки отчета
::CVS\quality\test\garant6x\implementation\utils\GarantUtils\SendCloseWnd
"D:\QC\PSTools\sleep.exe" 60
"D:\QC\PSTools\send_close.exe" /close #32770 TestComplete
if errorlevel 1 goto begin

::Проверяем запустился ли TC, если вдруг закрылся - сообщаем об ошибке
"D:\QC\PSTools\sleep.exe" 100
tasklist /fi "imagename eq testcomplete.exe" | find ":" > nul
if errorlevel 1 goto next
cls
echo TestComplete running error at %DATE%%TIME%! TestComplete was unexpectedly closed!
echo Please check your sources or configuration.
pause
goto end
:next

::Виндовая ошибка (может появиться через 10-15 мин после запуска)
"D:\QC\PSTools\sleep.exe" 1000
"D:\QC\PSTools\send_close.exe" /close #32770 "TestComplete.exe - Application Error"
if errorlevel 1 goto begin

:end
exit
