set TCREG_DIR=%~d0%~p0
set TCREGFILE_PATH=%TCREG_DIR%ProductSharedOptions.bin

xcopy /Y "%TCREGFILE_PATH%" "%ALLUSERSPROFILE%\Application Data\AutomatedQA\TestComplete\6.0\"
xcopy /Y "%TCREGFILE_PATH%" "%ALLUSERSPROFILE%\Application Data\AutomatedQA\TestExecute\6.0\"
