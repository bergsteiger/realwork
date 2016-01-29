@echo off& setlocal

:main
	:main.begin

		echo.

		pushd "%~dp0"
			pushd "scriptset"
				net use "N:" /delete /y 1>nul 2>&1
				net use "N:" "\\10.0.1.155\garant-nemesis" 1>nul 2>&1
					pushd "N:\deployment"
						echo !!! BUILD STARTED: don't use shared build targets while build not ended !!! > "!daily.build-script-schedule.lock"
					popd
				net use "N:" /delete /y 1>nul 2>&1
  
::				:: MDProcess {
::					pushd "MDProcess"
::						:: HEAD {
::							if exist "MDProcess.bat" (call "MDProcess.bat")
::						:: } HEAD
::					popd
::				:: } MDProcess

				:: garantF1 {
					pushd "garantF1"
						:: garantF1-7.11 {
							if exist "garantF1-7.11.bat" (call "garantF1-7.11.bat")
							if exist "garantF1-7.11-tests.bat" (call "garantF1-7.11-tests.bat")

							if exist "garantF1-7.11-xback.bat" (call "garantF1-7.11-xback.bat")
						:: } garantF1-7.11

						:: garantF1-7.12 {
							if exist "garantF1-7.12.bat" (call "garantF1-7.12.bat")
							if exist "garantF1-7.12-tests.bat" (call "garantF1-7.12-tests.bat")

							if exist "garantF1-7.12-xback.bat" (call "garantF1-7.12-xback.bat")
						:: } garantF1-7.12
					popd
				:: } garantF1

				:: garantInternet {
					pushd "garantInternet"
						:: garantInternet-2.00 {
							if exist "garantInternet-2.02.bat" (call "garantInternet-2.02.bat")

							if exist "garantInternet-2.02-xback.bat" (call "garantInternet-2.02-xback.bat")
						:: } garantInternet-2.00
					popd
				:: } garantInternet

				net use "N:" /delete /y 1>nul 2>&1
				net use "N:" "\\10.0.1.155\garant-nemesis" 1>nul 2>&1
					pushd "N:\deployment"
						if exist "!daily.build-script-schedule.lock" (del /f /q "!daily.build-script-schedule.lock" 1>nul 2>&1)
					popd
				net use "N:" /delete /y 1>nul 2>&1
			popd
		popd

		goto :main.end

	:main.end

@endlocal& exit /b
