SET TODAY=%DATE%
for /f "tokens=1-2 delims=:" %%B in ('TIME /T') do set NOW_TIME=%%B-%%C
SET FILE_NAME=%TODAY% %NOW_TIME%
%HSDX_PATH%\hsdx.exe -hidden -initfrom:%HSDX_PATH%\my.ini -QuickSave,1000,1,1 -snap -save:jpg "%LOG_DIR%\%FILE_NAME%"