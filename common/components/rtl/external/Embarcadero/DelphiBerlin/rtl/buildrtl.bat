@echo off
setlocal

if "%1"=="" goto Help
set ARG=%1

set TARGET=default
set CONFIG=debug
set VERBOSITY=normal
set CONLOGPARAMS=/clp:NoItemAndPropertyList;NoSummary;DisableMPLogging

if not "%BDS%"=="" goto :BdsIsSet
if EXIST ..\..\bin\rsvars.bat call ..\..\bin\rsvars.bat
if not exist "%BDS%\bin\bds.exe" goto RunRSVars

:BdsIsSet
if not EXIST %FRAMEWORKDIR%\MSBuild.exe goto NoMSBuild
if "%ARG%"=="clean" set TARGET=clean;cleanextras
if "%ARG%"=="release" set CONFIG=release

set PLATFORM=Win32
set PROJECT=BuildWinRTL.dproj
call :DoBuild||exit /b 1

set PLATFORM=Win64
set PROJECT=BuildWinRTL.dproj
call :DoBuild||exit /b 1

set PLATFORM=OSX32
set PROJECT=BuildOsxRTL.dproj
call :DoBuild||exit /b 1

goto end

:DoBuild
call %FRAMEWORKDIR%\msbuild.exe /v:%VERBOSITY% /t:%TARGET% /p:Platform=%PLATFORM% %PROPERTIES% %CONLOGPARAMS% %LOGGER% %PROJECT%
if errorlevel 1 exit /b 1
exit /b

:BuildError
echo *** Build Failed ***
goto end

:RunRSVars
echo Error: Command Prompt is not setup to build IDE projects.
echo        Ensure RSVARS.bat, located in the RAD Studio bin directory, has been run.
goto end

:NoMSBuild
echo Error: MSBuild %FRAMEWORKDIR% was not found on this system. Ensure that you have the Version %FRAMEWORKDIR% .NET Framework installed (via Windows Update).
goto end

:Help

echo.
echo           Batch file to build the RTL
echo ------------------------------------------------
echo.
echo Standard targets:
echo 	debug                Build debug configuration
echo 	release              Build release configuration
echo 	clean                Clean target
echo ------------------------------------------------

:end
endlocal