@echo off

@echo [%date% %time%] Make additional steps. >> logs/%1.log

rem Search manager and machines test

pushd "%~dp0\..\bin"
    F1SearchMachineManager.exe -check
popd

@echo "F1SearchMachineManager.exe -check" exited with error %ERRORLEVEL% >> logs/%1.log

exit %ERRORLEVEL%