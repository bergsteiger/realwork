call clearbackup.cmd
call clear.cmd
start "" /WAIT W:\common\env\QuickLaunch\callMSS.exe "%~1"
rem call clearempty.cmd
call saychanged.cmd
W:\common\env\QuickLaunch\FilesChanged.exe C:\Temp\changed.lst C:\Temp\GenBackup W: C:\Temp\callMSS.log W:\common\env\QuickLaunch\afc.cmd 
exit