call "%~d0%~p0_vars.bat"

wscript.exe //B "%PATH_TO_CODE%jobs.wsf" //JOB:StartWatcher
