regedit -s "W:\quality\test\garant6x\Scripts\clear_autologin.reg"
echo %USERDOMAIN%%USERNAME%>"C:\username.txt"
"C:\Program Files\Rational\Rational Test\rtmanager.exe" Server_Test /runsuite /user admin /project "W:\quality\test\garant6x\ra\nemesis.rsp" /computers Local /build "Build 1" /logfolder Default /log ServerTestLog_%USERDOMAIN%_%USERNAME% /overwritelog