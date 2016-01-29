@echo off& setlocal

:main
	:main.begin

		echo.

		pushd "%~dp0"
			net use "N:" /delete /y 1>nul 2>&1
			net use "N:" "\\10.0.1.155\garant-nemesis" 1>nul 2>&1
				pushd "N:\deployment"
					ren "!daily"           "!daily-UNKNOWN-X.XXX"           1>nul 2>&1& ren "!daily-GARANTF1-7_11"           "!daily"           1>nul 2>&1
					ren "!daily-installer" "!daily-UNKNOWN-X.XXX-installer" 1>nul 2>&1& ren "!daily-GARANTF1-7_11-installer" "!daily-installer" 1>nul 2>&1
				popd

				call "..\..\updatever.bat" "N:\deployment\!daily\!cvs_tag"
			net use "N:" /delete /y 1>nul 2>&1
			net use "N:" "\\10.14.3.205\garant-nemesis" 1>nul 2>&1
				pushd "N:\deployment"
					ren "!daily"           "!daily-UNKNOWN-X.XXX"           1>nul 2>&1& ren "!daily-GARANTF1-7_11"           "!daily"           1>nul 2>&1
					ren "!daily-installer" "!daily-UNKNOWN-X.XXX-installer" 1>nul 2>&1& ren "!daily-GARANTF1-7_11-installer" "!daily-installer" 1>nul 2>&1
				popd
			net use "N:" /delete /y 1>nul 2>&1

			call "..\..\syncbuild.bat" "garantF1-X.XX-current"
			call "..\..\syncbuild.bat" "garantF1-X.XX-support"

			call "..\..\syncbuild.bat" "garantF1-X.XX-daily"
			call "..\..\syncbuild.bat" "garantF1-X.XX-daily-installer"

			net use "N:" /delete /y 1>nul 2>&1
			net use "N:" "\\10.14.3.205\garant-nemesis" 1>nul 2>&1
				pushd "N:\deployment"
					ren "!daily-installer" "!daily-GARANTF1-7_11-installer" 1>nul 2>&1& ren "!daily-UNKNOWN-X.XXX-installer" "!daily-installer" 1>nul 2>&1
					ren "!daily"           "!daily-GARANTF1-7_11"           1>nul 2>&1& ren "!daily-UNKNOWN-X.XXX"           "!daily"           1>nul 2>&1
				popd
			net use "N:" /delete /y 1>nul 2>&1
			net use "N:" "\\10.0.1.155\garant-nemesis" 1>nul 2>&1
				pushd "N:\deployment"
					ren "!daily-installer" "!daily-GARANTF1-7_11-installer" 1>nul 2>&1& ren "!daily-UNKNOWN-X.XXX-installer" "!daily-installer" 1>nul 2>&1
					ren "!daily"           "!daily-GARANTF1-7_11"           1>nul 2>&1& ren "!daily-UNKNOWN-X.XXX"           "!daily"           1>nul 2>&1
				popd
			net use "N:" /delete /y 1>nul 2>&1
		popd

		goto :main.end

	:main.end

@endlocal& exit /b
