pushd W:\common\components\callMSS\Scripts
call ..\clear.cmd
Q:\callMSS.exe W:\common\components\callMSS\Scripts\*.script
popd
rem for /R W:\common\components\callMSS\Scripts\ %%i in (*.script) do call W:\common\components\callMSS\c.cmd %%i %%~di%%~pi