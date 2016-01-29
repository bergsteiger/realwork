@echo off& setlocal

:main
	:main.begin

		echo.

		pushd "%~dp0"
			set BIN=%CD%\ru.garant\bin

				set BIN=%BIN:\\=\%
	        	set ORBINITREF=-ORBInitRef "NameService=corbaloc::1.2@mdp.garant.ru:5053/NameService"
				set LOG=C:\makebuild.log

				"%BIN%\makebuild.exe" %ORBINITREF% -event "%~1" -project "%~2" -tag "%~3" -build "%~4" -branch "%~5" -build_path "%~6" -build_log "%~7" -login "builder" -paswd "builder" 1>>%LOG% 2>&1
				echo MakeBuild("%~1", "%~2", "%~3", "%~4", "%~5", "%~6", "%~7"):%ERRORLEVEL% 1>>%LOG% 2>&1

			set BIN=
		popd

		goto :main.end

	:main.end

@endlocal& exit /b
