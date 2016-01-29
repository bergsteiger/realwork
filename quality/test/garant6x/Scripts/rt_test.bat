regedit -s "W:\quality\test\garant6x\Scripts\clear_autologin.reg"
rem net use \\tom-w\pub /u:kir lazarus
rem echo %USERDOMAIN%%USERNAME%>"C:\username.txt"

"%RATL_RTHOME%\rtmanager.exe" StressServer /runsuite /user admin /project "W:\quality\test\garant6x\ra\nemesis.rsp" /computers Local /build "Build 1" /logfolder Default /log ServerTestLog_%USERDOMAIN%_%USERNAME% /overwritelog
