set BAT_DIR=%~d0%~p0
set QCPLUGIN_PATH=%BAT_DIR%..\TestCompletePlugin\bin\qcplugin.pls

xcopy /Y "%QCPLUGIN_PATH%" "%PROGRAMFILES%\Automated QA\TestComplete 6\Bin\Extensions\"
xcopy /Y "%QCPLUGIN_PATH%" "%PROGRAMFILES%\Automated QA\TestExecute 6\Bin\Extensions\"

if not exist "%PROGRAMFILES(X86)%" exit
xcopy /Y "%QCPLUGIN_PATH%" "%PROGRAMFILES(X86)%\Automated QA\TestComplete 6\Bin\Extensions\"
xcopy /Y "%QCPLUGIN_PATH%" "%PROGRAMFILES(X86)%\Automated QA\TestExecute 6\Bin\Extensions\"
