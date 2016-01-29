rem "D:\QC\PSTools\sleep.exe" 7200

"D:\QC\PSTools\pskill.exe" testcomplete
"D:\QC\PSTools\sleep.exe" 5
"D:\QC\PSTools\pskill.exe" testcomplete
"D:\QC\PSTools\sleep.exe" 5

start "TestComplete" "C:\Program Files\Automated QA\TestComplete 6\Bin\testcomplete.exe" "\\strelka\qc\for_RunnerTC6\Scripts\implementation\projects\netSuiteTest\netSuiteTest.pjs"  /run /project:netSuiteTest /unit:netSuiteTest /routine:StartRunnerOnly /exit /SilentMode
