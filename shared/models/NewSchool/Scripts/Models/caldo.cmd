call clearbackup.cmd
call clear.cmd
start "" /WAIT W:\common\env\QuickLaunch\msgen.exe "%~1" "%~2"
rem call clearempty.cmd
call saychanged.cmd
W:\common\env\QuickLaunch\FilesChanged.exe C:\Temp\changed.lst C:\Temp\GenBackup W: C:\Temp\msgen.log W:\common\env\QuickLaunch\afc.cmd 
exit