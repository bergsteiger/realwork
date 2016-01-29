@echo off& setlocal

:main
	:main.begin

		echo.

		pushd "%~dp0"
			set PROJECT=GARANTF1-7_11

			set CVS_TAG=NONE

			set SUBINFO=TEST-PART

			set LOGFILE=%TEMP%\%~nx0.log
			set LOGFILE=%LOGFILE:\\=\%

			set LOGGER=org.apache.tools.ant.NoBannerLogger

			set BUILDFILE=%~0.xml
			set BUILDFILE=%BUILDFILE:\\=\%

			set BUILDARGS=-buildfile "%BUILDFILE%" -logfile "%LOGFILE%" -logger "%LOGGER%" -nouserlib -Dproperties.delphi.suffix=%PROJECT% -Ddisable-updateCvs=1

			pushd "W:\"
				ren "common"       "common-UNKNOWN-X.XXX"       1>nul 2>&1& ren "common-%PROJECT%"       "common"       1>nul 2>&1
				ren "garant6x"     "garant6x-UNKNOWN-X.XXX"     1>nul 2>&1& ren "garant6x-%PROJECT%"     "garant6x"     1>nul 2>&1
				ren "garantPIL"    "garantPIL-UNKNOWN-X.XXX"    1>nul 2>&1& ren "garantPIL-%PROJECT%"    "garantPIL"    1>nul 2>&1
				ren "garantServer" "garantServer-UNKNOWN-X.XXX" 1>nul 2>&1& ren "garantServer-%PROJECT%" "garantServer" 1>nul 2>&1
				ren "garsock"      "garsock-UNKNOWN-X.XXX"      1>nul 2>&1& ren "garsock-%PROJECT%"      "garsock"      1>nul 2>&1
				ren "quality"      "quality-UNKNOWN-X.XXX"      1>nul 2>&1& ren "quality-%PROJECT%"      "quality"      1>nul 2>&1
				ren "shared"       "shared-UNKNOWN-X.XXX"       1>nul 2>&1& ren "shared-%PROJECT%"       "shared"       1>nul 2>&1
			popd

			net use "N:" /delete /y 1>nul 2>&1
			net use "N:" "\\10.0.1.155\garant-nemesis" 1>nul 2>&1
				pushd "N:\deployment"
					ren "!daily"           "!daily-UNKNOWN-X.XXX"           1>nul 2>&1& ren "!daily-%PROJECT%"           "!daily"           1>nul 2>&1
					ren "!daily-installer" "!daily-UNKNOWN-X.XXX-installer" 1>nul 2>&1& ren "!daily-%PROJECT%-installer" "!daily-installer" 1>nul 2>&1

					pushd "!daily"
						if exist "!success-tests" (del /f "!success-tests")
					popd
				popd
			net use "N:" /delete /y 1>nul 2>&1
			net use "N:" "\\10.14.3.205\garant-nemesis" 1>nul 2>&1
				pushd "N:\deployment"
					ren "!daily"           "!daily-UNKNOWN-X.XXX"           1>nul 2>&1& ren "!daily-%PROJECT%"           "!daily"           1>nul 2>&1
					ren "!daily-installer" "!daily-UNKNOWN-X.XXX-installer" 1>nul 2>&1& ren "!daily-%PROJECT%-installer" "!daily-installer" 1>nul 2>&1
				popd
			net use "N:" /delete /y 1>nul 2>&1

			if exist "%LOGFILE%" (del /f /q "%LOGFILE%" 1>nul 2>&1)

				call "..\..\buildmail.bat" "build started [%PROJECT%: %SUBINFO%], CVS TAG [%CVS_TAG%]: don't use shared build targets while build not ended"

				call "ant.bat" %BUILDARGS% -Dru.garant.extensions.properties.cvs_tag=%CVS_TAG% %*

				if errorlevel 1 (
					call "..\..\buildmail.bat" "build FAILURE [%PROJECT%: %SUBINFO%], CVS TAG [%CVS_TAG%]" "%LOGFILE%"
				) else (
					call "..\..\buildmail.bat" "build success [%PROJECT%: %SUBINFO%], CVS TAG [%CVS_TAG%]" "%LOGFILE%"
				)

			if exist "%LOGFILE%" (del /f /q "%LOGFILE%" 1>nul 2>&1)

			net use "N:" /delete /y 1>nul 2>&1
			net use "N:" "\\10.14.3.205\garant-nemesis" 1>nul 2>&1
				pushd "N:\deployment"
					ren "!daily-installer" "!daily-%PROJECT%-installer" 1>nul 2>&1& ren "!daily-UNKNOWN-X.XXX-installer" "!daily-installer" 1>nul 2>&1
					ren "!daily"           "!daily-%PROJECT%"           1>nul 2>&1& ren "!daily-UNKNOWN-X.XXX"           "!daily"           1>nul 2>&1
				popd
			net use "N:" /delete /y 1>nul 2>&1
			net use "N:" "\\10.0.1.155\garant-nemesis" 1>nul 2>&1
				pushd "N:\deployment"
					ren "!daily-installer" "!daily-%PROJECT%-installer" 1>nul 2>&1& ren "!daily-UNKNOWN-X.XXX-installer" "!daily-installer" 1>nul 2>&1
					ren "!daily"           "!daily-%PROJECT%"           1>nul 2>&1& ren "!daily-UNKNOWN-X.XXX"           "!daily"           1>nul 2>&1
				popd
			net use "N:" /delete /y 1>nul 2>&1

			pushd "W:\"
				ren "shared"       "shared-%PROJECT%"       1>nul 2>&1& ren "shared-UNKNOWN-X.XXX"       "shared"       1>nul 2>&1
				ren "quality"      "quality-%PROJECT%"      1>nul 2>&1& ren "quality-UNKNOWN-X.XXX"      "quality"      1>nul 2>&1
				ren "garsock"      "garsock-%PROJECT%"      1>nul 2>&1& ren "garsock-UNKNOWN-X.XXX"      "garsock"      1>nul 2>&1
				ren "garantServer" "garantServer-%PROJECT%" 1>nul 2>&1& ren "garantServer-UNKNOWN-X.XXX" "garantServer" 1>nul 2>&1
				ren "garantPIL"    "garantPIL-%PROJECT%"    1>nul 2>&1& ren "garantPIL-UNKNOWN-X.XXX"    "garantPIL"    1>nul 2>&1
				ren "garant6x"     "garant6x-%PROJECT%"     1>nul 2>&1& ren "garant6x-UNKNOWN-X.XXX"     "garant6x"     1>nul 2>&1
				ren "common"       "common-%PROJECT%"       1>nul 2>&1& ren "common-UNKNOWN-X.XXX"       "common"       1>nul 2>&1
			popd
		popd

		goto :main.end

	:main.end

@endlocal& exit /b
