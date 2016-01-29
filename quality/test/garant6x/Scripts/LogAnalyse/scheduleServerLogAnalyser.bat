set CURR_PATH=%~d0%~p0&
if not exist "%WINDIR%\system32\schtasks.exe" SET PATH_TO_SCHTASKS=%~d0%~p0schtasks\&

rem EA - error analyser, LLA - last line analyser
set EA_INT=%1&
set LLA_INT=%2&
set EA_TASK_NAME=Анализ лога на ошибки&
set LLA_TASK_NAME=Проверка лога на изменение последней строки&

rem шедулим проверку лога на ошибки
if ("%EA_INT%" neq "") (
	"%PATH_TO_SCHTASKS%schtasks.exe" /delete /tn "%EA_TASK_NAME%" /f
	"%PATH_TO_SCHTASKS%schtasks.exe" /create /tr "%CURR_PATH%\analyseLogAndSendEMail.wsf" /TN "%EA_TASK_NAME%" /MO %EA_INT% /SC MINUTE
)

rem шедулим проверку последней строки лога
if ("%LLA_INT%" neq "") (
	"%PATH_TO_SCHTASKS%schtasks.exe" /delete /tn "%LLA_TASK_NAME%" /f
	"%PATH_TO_SCHTASKS%schtasks.exe" /create /tr "%CURR_PATH%\checkLastLineAndSendEMail.wsf" /TN "%LLA_TASK_NAME%" /MO %LLA_INT% /SC MINUTE
)
