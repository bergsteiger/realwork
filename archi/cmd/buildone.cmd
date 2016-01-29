set PROJNAME=%1
set PROJDIR=%2
if "%3"=="" (
 set BUILDNAME=%1
) else (
 set BUILDNAME=%3
) 
set DEFINES=%4

copy /Y W:\archi\cmd\_cfg\%PROJNAME%.cfg %PROJDIR% >nul
pushd %PROJDIR%
rem echo %DEFINES%

echo.
echo Compiling %BUILDNAME% OldHT...
mkdir M:\out\exe\OldHT\%BUILDNAME%
IF "%DEFINES%"=="" (
 dcc32 -Q -B -U%BUILDROOT%\delphi -R%BUILDROOT%\delphi -DNBUILD -EM:\out\exe\OldHT\%BUILDNAME% %PROJNAME%.dpr > M:\out\exe\OldHT\%BUILDNAME%\%BUILDNAME%.OldHT.build.log
) ELSE (
 dcc32 -Q -B -U%BUILDROOT%\delphi -R%BUILDROOT%\delphi -DNBUILD;%DEFINES% -EM:\out\exe\OldHT\%BUILDNAME% %PROJNAME%.dpr > M:\out\exe\OldHT\%BUILDNAME%\%BUILDNAME%.OldHT.build.log
) 

if ERRORLEVEL 1 (
 echo Compile ERROR!
 echo ERROR: %BUILDNAME% OldHT >> M:\out\exe\build.log
 if NOT EXIST M:\out\errors.txt (
  echo —борка завершилась с ошибками! > M:\out\errors.txt
  echo. >> M:\out\errors.txt
  echo —ледующие проекты собрать не удалось: >> M:\out\errors.txt
 )
 echo %BUILDNAME% OldHT >> M:\out\errors.txt
 echo -attacht "M:\\out\\exe\\OldHT\\%BUILDNAME%\\%BUILDNAME%.OldHT.build.log" >> M:\out\mailopt.txt
 rem лог дл€ Confluence
 echo. >> M:\out\conf_log.txt
 echo %BUILDNAME% OldHT >> M:\out\conf_log.txt
 echo =================== >> M:\out\conf_log.txt
 type M:\out\exe\OldHT\%BUILDNAME%\%BUILDNAME%.OldHT.build.log >> M:\out\conf_log.txt
) else (
 echo Success!
 echo OK: %BUILDNAME% OldHT >> M:\out\exe\build.log
) 

echo.
echo Compiling %BUILDNAME% NewHT...
mkdir M:\out\exe\NewHT\%BUILDNAME%
IF "%DEFINES%"=="" (
 dcc32 -Q -B -U%BUILDROOT%\delphi -R%BUILDROOT%\delphi -DNBUILD;HT_NEWDLL -EM:\out\exe\NewHT\%BUILDNAME% %PROJNAME%.dpr > M:\out\exe\NewHT\%BUILDNAME%\%BUILDNAME%.NewHT.build.log
) ELSE (
 dcc32 -Q -B -U%BUILDROOT%\delphi -R%BUILDROOT%\delphi -DNBUILD;HT_NEWDLL;%DEFINES% -EM:\out\exe\NewHT\%BUILDNAME% %PROJNAME%.dpr > M:\out\exe\NewHT\%BUILDNAME%\%BUILDNAME%.NewHT.build.log
) 

if ERRORLEVEL 1 (
 echo Compile ERROR!
 echo ERROR: %BUILDNAME% NewHT >> M:\out\exe\build.log
 if NOT EXIST M:\out\errors.txt (
  echo —борка завершилась с ошибками! > M:\out\errors.txt
  echo. >> M:\out\errors.txt
  echo —ледующие проекты собрать не удалось: >> M:\out\errors.txt
 )
 echo %BUILDNAME% NewHT >> M:\out\errors.txt
 echo -attacht "M:\\out\\exe\\NewHT\\%BUILDNAME%\\%BUILDNAME%.NewHT.build.log" >> M:\out\mailopt.txt
 rem лог дл€ Confluence
 echo. >> M:\out\conf_log.txt
 echo %BUILDNAME% NewHT >> M:\out\conf_log.txt
 echo =================== >> M:\out\conf_log.txt
 type M:\out\exe\NewHT\%BUILDNAME%\%BUILDNAME%.NewHT.build.log >> M:\out\conf_log.txt
) else (
 echo Success!
 echo OK: %BUILDNAME% NewHT >> M:\out\exe\build.log
) 

popd