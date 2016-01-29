@echo off& setlocal

:main
	:main.begin

		echo.

		pushd "%~dp0"
			set PROJECT=SHARED DELPHI TESTS

			set PROJECT_MAJOR=1
			set PROJECT_MINOR=0
			set PROJECT_SUFFIX=%PROJECT%-%PROJECT_MAJOR%_%PROJECT_MINOR%
			set VERSION_MAJOR=0
			set VERSION_MINOR=001

			set SUBINFO=MAIN-PART

			set LOGFILE=%TEMP%\%~nx0.log
			set LOGFILE=%LOGFILE:\\=\%

			set LOGGER=org.apache.tools.ant.NoBannerLogger

			set BUILDFILE=%~0.xml
			set BUILDFILE=%BUILDFILE:\\=\%

			set BUILD_SHARE=DailyTest
			set BUILDARGS=-buildfile "%BUILDFILE%" -logfile "%LOGFILE%" -logger "%LOGGER%" -nouserlib -Dproperties.delphi.suffix=%PROJECT% -Denable-cppFinalBuild=1

			pushd "W:\"
				ren "Shared Delphi Tests" "Shared Delphi Tests-UNKNOWN-X.XXX" 1>nul 2>&1& ren "Shared Delphi Tests-%PROJECT%" "Shared Delphi Tests" 1>nul 2>&1
			popd

			net use "N:" /delete /y 1>nul 2>&1
			net use "N:" "\\10.0.1.155\%BUILD_SHARE%" 1>nul 2>&1
				pushd "N:\deployment"
					ren "!daily"           "!daily-UNKNOWN-X.XXX"           1>nul 2>&1& ren "!daily-%PROJECT%"           "!daily"           1>nul 2>&1
					ren "!daily-installer" "!daily-UNKNOWN-X.XXX-installer" 1>nul 2>&1& ren "!daily-%PROJECT%-installer" "!daily-installer" 1>nul 2>&1
					
					rmdir "!daily-installer%SN" /S/Q 1nul 2&1
					rmdir "!daily_new" /S/Q 1nul 2&1& mkdir "!daily_new"
					copy /Y "!daily\!cvs_tag" "!daily_new\!cvs_tag"
					copy /Y "!daily\!success" "!daily_new\!success"
					rmdir "!daily" /S/Q 1>nul 2>&1
					ren "!daily_new" "!daily" 1>nul 2>&1
				popd
				
				call "..\..\updatever.bat" "N:\deployment\!daily\!cvs_tag"
			net use "N:" /delete /y 1>nul 2>&1

			set BUILD_PATH=\\10.0.1.155\%BUILD_SHARE%\deployment\!daily-%PROJECT%
			set CVS_TAG=T_%PROJECT_SUFFIX%_%VERSION_MAJOR%_%VERSION_MINOR%
			set VERSION=%VERSION_MAJOR%.%VERSION_MINOR%
			
			if exist "%LOGFILE%" (del /f /q "%LOGFILE%" 1>nul 2>&1)

				call "..\..\buildmail.bat" "BUILD STARTED [%PROJECT_SUFFIX%: %SUBINFO%], CVS TAG [%CVS_TAG%]: don't use shared build targets while build not ended"
				call "..\..\confbuild.bat" "start" "SHD" "%CVS_TAG%" "%VERSION_MINOR%" "%VERSION_MAJOR%" "%BUILD_PATH%"
				
				call "ant.bat" %BUILDARGS% -Dru.garant.extensions.properties.cvs_tag=%CVS_TAG% -Dru.garant.extensions.properties.version=%PROJECT_MAJOR%.%PROJECT_MINOR%.%VERSION% %*
				
				set ANT_SUCCESS=0
				if errorlevel 1 (
					set ANT_SUCCESS=0
				) else (
					set ANT_SUCCESS=1
				)

			net use "N:" /delete /y 1>nul 2>&1
			net use "N:" "\\10.0.1.155\%BUILD_SHARE%" 1>nul 2>&1
				pushd "N:\deployment"
					ren "!daily-installer" "!daily-%PROJECT%-installer" 1>nul 2>&1& ren "!daily-UNKNOWN-X.XXX-installer" "!daily-installer" 1>nul 2>&1
					ren "!daily"           "!daily-%PROJECT%"           1>nul 2>&1& ren "!daily-UNKNOWN-X.XXX"           "!daily"           1>nul 2>&1
				popd
			net use "N:" /delete /y 1>nul 2>&1
			
			if "%ANT_SUCCESS%" == "0" (
				call "..\..\buildmail.bat" "BUILD FAILURE [%PROJECT_SUFFIX%: %SUBINFO%], CVS TAG [%CVS_TAG%]" "%LOGFILE%"
				call "..\..\confbuild.bat" "failure" "SHD" "%CVS_TAG%" "%VERSION_MINOR%" "%VERSION_MAJOR%" "%BUILD_PATH%" "%LOGFILE%"
			) else (
				call "..\..\buildmail.bat" "BUILD SUCCESS [%PROJECT_SUFFIX%: %SUBINFO%], CVS TAG [%CVS_TAG%]" "%LOGFILE%"
				call "..\..\confbuild.bat" "done" "SHD" "%CVS_TAG%" "%VERSION_MINOR%" "%VERSION_MAJOR%" "%BUILD_PATH%"
			)
			
			if exist "%LOGFILE%" (del /f /q "%LOGFILE%" 1>nul 2>&1)
			
			pushd "W:\"
				ren "Shared Delphi Tests" "Shared Delphi Tests-%PROJECT%" 1>nul 2>&1& ren "Shared Delphi Tests-UNKNOWN-X.XXX" "Shared Delphi Tests" 1>nul 2>&1
			popd
		popd

		goto :main.end

	:main.end

@endlocal& exit /b