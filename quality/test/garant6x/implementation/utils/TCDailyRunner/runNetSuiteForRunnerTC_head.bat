@echo off
"D:\QC\PSTools\pskill.exe" testcomplete
"D:\QC\PSTools\sleep.exe" 5
"D:\QC\PSTools\pskill.exe" testcomplete
"D:\QC\PSTools\sleep.exe" 5

call "D:\QC\!TC_DailyRunner\updatescriptsforrunnertc_head.bat"
call "D:\QC\!TC_DailyRunner\runInstallAndRunForTC.bat"
exit
