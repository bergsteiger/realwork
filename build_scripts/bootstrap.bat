@echo off& setlocal

:main
	:main.begin

		echo.

		subst "W:" "C:\USERS\%USERNAME%\PROJECTS" 1>nul 2>&1
			pushd "%~dp0"
				:: bootstrap {
					pushd "bootstrap"
						if exist "bootstrap.buildScriptsUpdater.bat" (call "bootstrap.buildScriptsUpdater.bat")
					popd
				:: } bootstrap
			popd
		subst "W:" /d

		goto :main.end

	:main.end

@endlocal& exit /b
