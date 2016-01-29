@echo off& setlocal

:main
	:main.begin

		echo.

		pushd "%~dp0"
			net use "N:" /delete /y 1>nul 2>&1
			net use "N:" "\\10.0.1.155\garant-nemesis" 1>nul 2>&1
				pushd "N:\deployment"
					ren "!daily" "!daily-UNKNOWN-X.XXX" 1>nul 2>&1& ren "!daily-GARANT_INTERNET-2_02" "!daily" 1>nul 2>&1
				popd

				call "..\..\updatever.bat" "N:\deployment\!daily\!cvs_tag"
			net use "N:" /delete /y 1>nul 2>&1
			net use "N:" "\\10.14.3.205\garant-nemesis" 1>nul 2>&1
				pushd "N:\deployment"
					ren "!daily" "!daily-UNKNOWN-X.XXX" 1>nul 2>&1& ren "!daily-GARANT_INTERNET-2_02" "!daily" 1>nul 2>&1
				popd
			net use "N:" /delete /y 1>nul 2>&1

			call "..\..\syncbuild.bat" "garantInternet-X.XX-current"

			call "..\..\syncbuild.bat" "garantInternet-X.XX-daily"

			net use "N:" /delete /y 1>nul 2>&1
			net use "N:" "\\10.14.3.205\garant-nemesis" 1>nul 2>&1
				pushd "N:\deployment"
					ren "!daily" "!daily-GARANT_INTERNET-2_02" 1>nul 2>&1& ren "!daily-UNKNOWN-X.XXX" "!daily" 1>nul 2>&1
				popd
			net use "N:" /delete /y 1>nul 2>&1
			net use "N:" "\\10.0.1.155\garant-nemesis" 1>nul 2>&1
				pushd "N:\deployment"
					ren "!daily" "!daily-GARANT_INTERNET-2_02" 1>nul 2>&1& ren "!daily-UNKNOWN-X.XXX" "!daily" 1>nul 2>&1
				popd
			net use "N:" /delete /y 1>nul 2>&1
		popd

		goto :main.end

	:main.end

@endlocal& exit /b
