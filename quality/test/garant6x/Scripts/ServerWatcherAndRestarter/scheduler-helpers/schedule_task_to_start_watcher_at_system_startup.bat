rem Создает задачу шедулера, которая перезапускает сервер в полночь

call "%~d0%~p0_vars.bat"
set CURR_PATH=%~d0%~p0&

rem if not exist "%WINDIR%\system32\schtasks.exe" SET PATH_TO_SCHTASKS=%CURR_PATH%schtasks\&
if not exist "%WINDIR%\system32\schtasks.exe" (
	echo Утилита schtasks.exe не найдена.
	exit 1
)

set TASK_NAME=Запуск следилки за сервером ГАРАНТ&

"%PATH_TO_SCHTASKS%schtasks.exe" /delete /tn "%TASK_NAME%" /f
"%PATH_TO_SCHTASKS%schtasks.exe" /create /ru SYSTEM /tr "wscript.exe //B //JOB:StartWatcher \"%PATH_TO_CODE%jobs.wsf\"" /tn "%TASK_NAME%" /sc ONSTART

