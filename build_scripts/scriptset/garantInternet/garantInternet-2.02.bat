@echo off& setlocal

:main
	:main.begin

		echo.

		pushd "%~dp0"
			set PROJECT=GARANT_INTERNET

			set PROJECT_MAJOR=2
			set PROJECT_MINOR=02

			set PROJECT_SUFFIX=%PROJECT%-%PROJECT_MAJOR%_%PROJECT_MINOR%

			set VERSION_MAJOR=0
			set VERSION_MINOR=001

			set SUBINFO=MAIN-PART

			set LOGFILE=%TEMP%\%~nx0.log
			set LOGFILE=%LOGFILE:\\=\%

			set LOGGER=org.apache.tools.ant.NoBannerLogger

			set BUILDFILE=%~0.xml
			set BUILDFILE=%BUILDFILE:\\=\%

			set BUILDARGS=-buildfile "%BUILDFILE%" -logfile "%LOGFILE%" -logger "%LOGGER%" -nouserlib -Dproperties.delphi.suffix=%PROJECT_SUFFIX%

			pushd "W:\"
				ren "common"         "common-UNKNOWN-X.XXX"         1>nul 2>&1& ren "common-%PROJECT_SUFFIX%"         "common"         1>nul 2>&1
				ren "garant6x"       "garant6x-UNKNOWN-X.XXX"       1>nul 2>&1& ren "garant6x-%PROJECT_SUFFIX%"       "garant6x"       1>nul 2>&1
				ren "garantInternet" "garantInternet-UNKNOWN-X.XXX" 1>nul 2>&1& ren "garantInternet-%PROJECT_SUFFIX%" "garantInternet" 1>nul 2>&1
				ren "garantServer"   "garantServer-UNKNOWN-X.XXX"   1>nul 2>&1& ren "garantServer-%PROJECT_SUFFIX%"   "garantServer"   1>nul 2>&1
				ren "garantPIL"      "garantPIL-UNKNOWN-X.XXX"      1>nul 2>&1& ren "garantPIL-%PROJECT_SUFFIX%"      "garantPIL"      1>nul 2>&1
				ren "shared"         "shared-UNKNOWN-X.XXX"         1>nul 2>&1& ren "shared-%PROJECT_SUFFIX%"         "shared"         1>nul 2>&1
			popd

			net use "N:" /delete /y 1>nul 2>&1
			net use "N:" "\\10.0.1.155\garant-nemesis" 1>nul 2>&1
				pushd "N:\deployment"
					ren "!daily" "!daily-UNKNOWN-X.XXX" 1>nul 2>&1& ren "!daily-%PROJECT_SUFFIX%" "!daily" 1>nul 2>&1

					pushd "!daily"
						if exist "!success" (del /f "!success")
					popd
				popd

				call "..\..\updatever.bat" "N:\deployment\!daily\!cvs_tag"
			net use "N:" /delete /y 1>nul 2>&1
			net use "N:" "\\10.14.3.205\garant-nemesis" 1>nul 2>&1
				pushd "N:\deployment"
					ren "!daily" "!daily-UNKNOWN-X.XXX" 1>nul 2>&1& ren "!daily-%PROJECT_SUFFIX%" "!daily" 1>nul 2>&1
				popd

				call "..\..\updatever.bat" "N:\deployment\!daily\!cvs_tag"
			net use "N:" /delete /y 1>nul 2>&1

			set CONF_BRANCH=garantInternet-2.02
			set CONF_BUILD=%VERSION_MINOR%

			set CVS_TAG=T_%PROJECT_SUFFIX%_%VERSION_MAJOR%_%VERSION_MINOR%
			set VERSION=%VERSION_MAJOR%.%VERSION_MINOR%

			if exist "%LOGFILE%" (del /f /q "%LOGFILE%" 1>nul 2>&1)

				call "..\..\buildmail.bat" "build started [%PROJECT_SUFFIX%: %SUBINFO%], CVS TAG [%CVS_TAG%]: don't use shared build targets while build not ended"

				call "..\..\confbuild.bat" "start" "NMS" "%CVS_TAG%" "%CONF_BUILD%" "%CONF_BRANCH%"
				call "..\..\confbuild.bat" "start" "NMSCore" "%CVS_TAG%" "%CONF_BUILD%" "%CONF_BRANCH%"

				call "..\..\confbuild.bat" "start" "SHD" "%CVS_TAG%" "%CONF_BUILD%" "%CONF_BRANCH%"
::				call "..\..\confbuild.bat" "start" "SHR" "%CVS_TAG%" "%CONF_BUILD%" "%CONF_BRANCH%"

				call "ant.bat" %BUILDARGS% -Dru.garant.extensions.properties.cvs_tag=%CVS_TAG% -Dru.garant.extensions.properties.version=%VERSION% -Dru.garant.extensions.properties.full.version=%PROJECT_MAJOR%.%PROJECT_MINOR%.%VERSION% %*

				if errorlevel 1 (
::					call "..\..\confbuild.bat" "failure" "SHR" "%CVS_TAG%" "%CONF_BUILD%" "%CONF_BRANCH%"
					call "..\..\confbuild.bat" "failure" "SHD" "%CVS_TAG%" "%CONF_BUILD%" "%CONF_BRANCH%"

					call "..\..\confbuild.bat" "failure" "NMSCore" "%CVS_TAG%" "%CONF_BUILD%" "%CONF_BRANCH%"
					call "..\..\confbuild.bat" "failure" "NMS" "%CVS_TAG%" "%CONF_BUILD%" "%CONF_BRANCH%" "" "%LOGFILE%"

					call "..\..\buildmail.bat" "build FAILURE [%PROJECT_SUFFIX%: %SUBINFO%], CVS TAG [%CVS_TAG%]" "%LOGFILE%"
				) else (
::					call "..\..\confbuild.bat" "done" "SHR" "%CVS_TAG%" "%CONF_BUILD%" "%CONF_BRANCH%"
					call "..\..\confbuild.bat" "done" "SHD" "%CVS_TAG%" "%CONF_BUILD%" "%CONF_BRANCH%"

					call "..\..\confbuild.bat" "done" "NMSCore" "%CVS_TAG%" "%CONF_BUILD%" "%CONF_BRANCH%"
					call "..\..\confbuild.bat" "done" "NMS" "%CVS_TAG%" "%CONF_BUILD%" "%CONF_BRANCH%"

					call "..\..\buildmail.bat" "build success [%PROJECT_SUFFIX%: %SUBINFO%], CVS TAG [%CVS_TAG%]" "%LOGFILE%"
				)

			if exist "%LOGFILE%" (del /f /q "%LOGFILE%" 1>nul 2>&1)

			net use "N:" /delete /y 1>nul 2>&1
			net use "N:" "\\10.14.3.205\garant-nemesis" 1>nul 2>&1
				pushd "N:\deployment"
					ren "!daily" "!daily-%PROJECT_SUFFIX%" 1>nul 2>&1& ren "!daily-UNKNOWN-X.XXX" "!daily" 1>nul 2>&1
				popd
			net use "N:" /delete /y 1>nul 2>&1
			net use "N:" "\\10.0.1.155\garant-nemesis" 1>nul 2>&1
				pushd "N:\deployment"
					ren "!daily" "!daily-%PROJECT_SUFFIX%" 1>nul 2>&1& ren "!daily-UNKNOWN-X.XXX" "!daily" 1>nul 2>&1
				popd
			net use "N:" /delete /y 1>nul 2>&1

			pushd "W:\"
				ren "shared"         "shared-%PROJECT_SUFFIX%"         1>nul 2>&1& ren "shared-UNKNOWN-X.XXX"         "shared"         1>nul 2>&1
				ren "garantPIL"      "garantPIL-%PROJECT_SUFFIX%"      1>nul 2>&1& ren "garantPIL-UNKNOWN-X.XXX"      "garantPIL"      1>nul 2>&1
				ren "garantServer"   "garantServer-%PROJECT_SUFFIX%"   1>nul 2>&1& ren "garantServer-UNKNOWN-X.XXX"   "garantServer"   1>nul 2>&1
				ren "garantInternet" "garantInternet-%PROJECT_SUFFIX%" 1>nul 2>&1& ren "garantInternet-UNKNOWN-X.XXX" "garantInternet" 1>nul 2>&1
				ren "garant6x"       "garant6x-%PROJECT_SUFFIX%"       1>nul 2>&1& ren "garant6x-UNKNOWN-X.XXX"       "garant6x"       1>nul 2>&1
				ren "common"         "common-%PROJECT_SUFFIX%"         1>nul 2>&1& ren "common-UNKNOWN-X.XXX"         "common"         1>nul 2>&1
			popd
		popd

		goto :main.end

	:main.end

@endlocal& exit /b
