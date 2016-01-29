@echo off& setlocal

:main
	:main.begin

		echo.

		pushd "%~dp0"
			set BUILDFILE=%~0.xml
			set BUILDFILE=%BUILDFILE:\\=\%

			set LOGFILE=%TEMP%\%~nx0.log
			set LOGFILE=%LOGFILE:\\=\%

			set LOGGER=org.apache.tools.ant.NoBannerLogger

			if exist "%LOGFILE%" (del /f /q "%LOGFILE%" 1>nul 2>&1)

			if exist "%BUILDFILE%" (
				call "ant.bat" -buildfile "%BUILDFILE%" -logfile "%LOGFILE%" -logger "%LOGGER%" -nouserlib %*

				if errorlevel 1 (
					call "..\buildmail.bat" "BOOTSTRAP BUILD SCRIPTS UPDATE [FAILURE]" "%LOGFILE%"

					if exist "%LOGFILE%" (del /f /q "%LOGFILE%" 1>nul 2>&1)

					goto :main.end
				)
			)

			if exist "%LOGFILE%" (del /f /q "%LOGFILE%" 1>nul 2>&1)

			pushd "W:\build_scripts"
				if exist "scriptset.bat" (call "scriptset.bat")
			popd
		popd

		goto :main.end

	:main.end

@endlocal& exit /b
