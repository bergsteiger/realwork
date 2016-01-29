set PROJNAME=%1
set PROJDIR=%2

echo.
echo.
vergen %PROJNAME% %BUILDNO%
rem echo Deleting Old
del versioninfo.res
del %PROJDIR%\versioninfo.res
brcc32 versioninfo.rc
copy /b /y versioninfo.res %PROJDIR%