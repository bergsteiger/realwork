call clearbackup.cmd
call clear.cmd
start "" /WAIT W:\common\env\QuickLaunch\callMSS.exe "%~1"
rem call clearempty.cmd
call saychanged.cmd
W:\common\env\QuickLaunch\FilesChanged.exe W:\shared\models\NewSchool\Scripts\changed.lst C:\Temp\GenBackup W: W:\shared\models\NewSchool\Scripts\callMSS.log W:\common\env\QuickLaunch\afc.cmd 
exit