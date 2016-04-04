call clearbackup.cmd
call clear.cmd
start "" /WAIT W:\common\env\QuickLaunch\callMSS.exe "%~1"
rem call clearempty.cmd
call saychanged.cmd
exit