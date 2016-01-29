@echo off& setlocal

:main
	:main.begin

		echo.

		pushd "%~dp0"
			set MAIL_FROM=buildmail@nemesis-twin.garant.ru
			set MAIL_TO=newdev@garant.ru,qc@garant.ru

			set MAIL_CHARSET=windows-1251
			set MAIL_REPLYTO=%MAIL_TO%
			set MAIL_SERVER=smtp.garant.ru

			if /i "%~2" equ "" (
				"blat.exe" -               -body "%~1."                                -charset "%MAIL_CHARSET%" -f "%MAIL_FROM%" -priority "1" -replyto "%MAIL_REPLYTO%" -server "%MAIL_SERVER%" -subject "%~1" -to "%MAIL_TO%" 1>nul 2>&1
			) else (
				"blat.exe" - -attach "%~2" -body "%~1: see attached file for details." -charset "%MAIL_CHARSET%" -f "%MAIL_FROM%" -priority "1" -replyto "%MAIL_REPLYTO%" -server "%MAIL_SERVER%" -subject "%~1" -to "%MAIL_TO%" 1>nul 2>&1
			)
		popd

		goto :main.end

	:main.end

@endlocal& exit /b
