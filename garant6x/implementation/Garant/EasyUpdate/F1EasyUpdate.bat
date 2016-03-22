@echo off
	:: (C) SIE "GARANT-SERVICE-UNIVERSITY" LLC, 1990-2016

	set MAIN_ERRORLEVEL=255

	if "%OS%"=="Windows_NT" (pushd "%~dp0"& set $DEBUG=0& call :main "%~0" %*& popd)

	if "%$DEBUG%" neq "" (if "%$DEBUG%" neq "0" (echo Script::INFO: main ErrorLevel = %MAIN_ERRORLEVEL% [%ERRORLEVEL%]))
@exit %MAIN_ERRORLEVEL%


:main
	::
	:: parameters
	::   "%~0" %*
	::

	call F1EasyUpdateSet.bat

	:main.begin

		if "%GARANT%" equ "" (echo Main::ERROR: variable `GARANT` not defined, script aborted& goto :main.end)

		set MAIN_ERRORLEVEL=0

	:main.download

		if "%MAIN_ERRORLEVEL%" equ "0" (if "%DOWNLOAD_ENABLED%" neq "" (if "%DOWNLOAD_ENABLED%" neq "0" (call :download_launcher)))

	:main.update

		if "%MAIN_ERRORLEVEL%" equ "0" (if "%UPDATE_ENABLED%" neq "" (if "%UPDATE_ENABLED%" neq "0" (call :update_launcher)))

	:main.runatend

		if "%MAIN_ERRORLEVEL%" equ "0" (if "%RUN_AT_END_ENABLED%" neq "" (if "%RUN_AT_END_ENABLED%" neq "0" (call :runatend_launcher)))

	:main.end
exit /b


:download_launcher
	::
	:: parameters
	::   none
	::

	:download_launcher.begin

		if "%$DEBUG%" neq "" (if "%$DEBUG%" neq "0" (echo DownloadLauncher::INFO: download call enabled))

		set $DOWNLOAD_NODELTA=0
		set $DOWNLOAD_RETRY_INDEX=1

	:download_launcher.loop

		if "%$DEBUG%" neq "" (if "%$DEBUG%" neq "0" (echo DownloadLauncher::INFO: call download [retry index: %$DOWNLOAD_RETRY_INDEX%]))

		call :download

		if "%$DOWNLOAD_NODELTA%" neq "" (if "%$DOWNLOAD_NODELTA%" neq "0" (if "%DOWNLOAD_RETRY%" neq "" (if "%DOWNLOAD_RETRY%" neq "0" (call :download_retry& if %$DOWNLOAD_RETRY_INDEX% lss %DOWNLOAD_RETRY_COUNT% (goto :download_launcher.loop)))))

		if "%DOWNLOAD_SEND_REPORT%" neq "" (if "%DOWNLOAD_SEND_REPORT%" neq "0" (if "%$DOWNLOAD_ERRORLEVEL%" equ "%DOWNLOAD_ERROR_SUCCESS%" (call :sendmail "GARANT F1: download SUCCESS") else (call :sendmail "GARANT F1: download FAILURE [%$DOWNLOAD_ERRORLEVEL%]")))

	:download_launcher.end
exit /b


:download_retry
	::
	:: parameters
	::   none
	::

	:download_retry.begin

		if "%$DEBUG%" neq "" (if "%$DEBUG%" neq "0" (echo DownloadRetry::INFO: download retry of run enabled))

		call :download_nodelta
			
	:download_retry.end
exit /b

:download_nodelta
	::
	:: parameters
	::   none
	::

	:download_nodelta.begin

		if "%$DEBUG%" neq "" (if "%$DEBUG%" neq "0" (echo DownloadNoDelta::WARNING: download delta not found))

		if "%$DEBUG%" neq "" (if "%$DEBUG%" neq "0" (echo DownloadNoDelta::INFO: download RetryIndex = %$DOWNLOAD_RETRY_INDEX% [of %DOWNLOAD_RETRY_COUNT%]))

		set /a $DOWNLOAD_RETRY_INDEX+=1

		if %$DOWNLOAD_RETRY_INDEX% gtr %DOWNLOAD_RETRY_COUNT% (call :download_too_many_retry& goto :download_nodelta.end)

		if "%$DEBUG%" neq "" (if "%$DEBUG%" neq "0" (echo DownloadNoDelta::INFO: wait 20 minutes...))

		call :wait20minutes

	:download_nodelta.end
exit /b


:download_too_many_retry
	::
	:: parameters
	::   none
	::

	:download_too_many_retry.begin

		if "%$DEBUG%" neq "" (if "%$DEBUG%" neq "0" (echo DownloadTooManyRerty::ERROR: download retry of run not complete, to many attempts [%DOWNLOAD_RETRY_COUNT%]))

		set MAIN_ERRORLEVEL=%$DOWNLOAD_ERRORLEVEL%

		if "%$DEBUG%" neq "" (if "%$DEBUG%" neq "0" (echo DownloadTooManyRerty::INFO: main ErrorLevel = %MAIN_ERRORLEVEL%))

	:download_too_many_retry.end
exit /b


:download
	::
	:: parameters
	::   none
	::

	set $APPLICATION=%GARANT%\download.exe
	set $COMMANDLINE=-WaitForExit -auto -silent

	:download.begin

		set $DOWNLOAD_ERRORLEVEL=255

		if not exist "%$APPLICATION%" (echo Download::ERROR: application "%$APPLICATION%" not exist, call disabled& goto :download.end)

		if "%DOWNLOAD_ID%" neq "" (set $COMMANDLINE=%$COMMANDLINE% -useragent "%DOWNLOAD_ID%")

		if "%DOWNLOAD_PATH%" equ "" (call :download_set_path "%GARANT%\delta")
		set $COMMANDLINE=%$COMMANDLINE% -path "%DOWNLOAD_PATH%"

		if "%DOWNLOAD_RESTORE%" neq "" (if "%DOWNLOAD_RESTORE%" neq "0" (if "%DOWNLOAD_RESTORE_TIME%" equ "" (call :download_set_restore_time "5")))
		if "%DOWNLOAD_RESTORE%" neq "" (if "%DOWNLOAD_RESTORE%" neq "0" (set $COMMANDLINE=%$COMMANDLINE% -dsc "%DOWNLOAD_RESTORE_TIME%"))

		if "%DOWNLOAD_RESUME%" neq "" (if "%DOWNLOAD_RESUME%" neq "0" (set $COMMANDLINE=%$COMMANDLINE% -resume))
		if "%DOWNLOAD_REVISION%" neq "" (if "%DOWNLOAD_REVISION%" neq "0" (set $COMMANDLINE=%$COMMANDLINE% -revision))


		if "%$DEBUG%" neq "" (if "%$DEBUG%" neq "0" (echo Download::INFO: run with params: `start /wait "Download" "%$APPLICATION%" %$COMMANDLINE%`))

		start /wait "Download" "%$APPLICATION%" %$COMMANDLINE%
		set $DOWNLOAD_ERRORLEVEL=%ERRORLEVEL%

		if "%$DEBUG%" neq "" (if "%$DEBUG%" neq "0" (echo Download::INFO: run complete [exit code: %$DOWNLOAD_ERRORLEVEL%]))


		if "%$DOWNLOAD_ERRORLEVEL%" equ "%DOWNLOAD_ERROR_NODELTA%" (set $DOWNLOAD_NODELTA=1& if "%$DEBUG%" neq "" (if "%$DEBUG%" neq "0" (echo Download::INFO: set delta not found))) else (set $DOWNLOAD_NODELTA=0& if "%$DEBUG%" neq "" (if "%$DEBUG%" neq "0" (echo Download::INFO: reset delta not found)))
	:download.end

	set $COMMANDLINE=
	set $APPLICATION=
exit /b


:download_set_path
	::
	:: parameters
	::   %1 - download path
	::

	:download_set_path.begin

		set DOWNLOAD_PATH=%~1

		echo Download::WARNING: variable `DOWNLOAD_PATH` not defined, set it value to `%DOWNLOAD_PATH%`

	:download_set_path.end
exit /b


:download_set_restore_time
	::
	:: parameters
	::   %1 - restore time
	::

	:download_set_restore_time.begin

		set DOWNLOAD_RESTORE_TIME=%~1

		echo Download::WARNING: variable `DOWNLOAD_RESTORE_TIME` not defined, set it value to `%DOWNLOAD_RESTORE_TIME%`

	:download_set_restore_time.end
exit /b


:update_launcher
	::
	:: parameters
	::   none
	::

	:update_launcher.begin

		if "%$DEBUG%" neq "" (if "%$DEBUG%" neq "0" (echo UpdateLauncher::INFO: update call enabled))

		call :update

		if "%UPDATE_SEND_REPORT%" neq "" (if "%UPDATE_SEND_REPORT%" neq "0" (if "%$UPDATE_ERRORLEVEL%" equ "%UPDATE_ERROR_SUCCESS%" (call :sendmail "GARANT F1: update SUCCESS") else (call :sendmail "GARANT F1: update FAILURE [%$UPDATE_ERRORLEVEL%]")))

		set MAIN_ERRORLEVEL=%$UPDATE_ERRORLEVEL%

		if "%$DEBUG%" neq "" (if "%$DEBUG%" neq "0" (echo UpdateLauncher::INFO: main ErrorLevel = %MAIN_ERRORLEVEL%))

	:update_launcher.end
exit /b


:update
	::
	:: parameters
	::   none
	::

	set $APPLICATION=%GARANT%\dataupd.exe
	set $COMMANDLINE=-WaitForExit auto nofinalmessage -silent

	:update.begin

		set $UPDATE_ERRORLEVEL=255

		if not exist "%$APPLICATION%" (echo Update::ERROR: application "%$APPLICATION%" not exist, call disabled& goto :update.end)

		if "%UPDATE_ADMIN_NAME%" neq "" (set $COMMANDLINE=%$COMMANDLINE% -login "%UPDATE_ADMIN_NAME%")
		if "%UPDATE_ADMIN_PASSWORD%" neq "" (set $COMMANDLINE=%$COMMANDLINE% -pwd "%UPDATE_ADMIN_PASSWORD%")
		if "%UPDATE_NO_BACKUP%" neq "" (if "%UPDATE_NO_BACKUP%" neq "0" (set $COMMANDLINE=%$COMMANDLINE% nobackup))
		if "%UPDATE_REMOVE_ARCHIVE%" neq "" (if "%UPDATE_REMOVE_ARCHIVE%" neq "0" (set $COMMANDLINE=%$COMMANDLINE% deletezips))

		if "%UPDATE_PATH%" equ "" (call :update_set_path "%GARANT%\delta")
		set $COMMANDLINE=%$COMMANDLINE% -path "%UPDATE_PATH%"

		if "%UPDATE_SKIP_WARNING%" neq "" (if "%UPDATE_SKIP_WARNING%" neq "0" (set $COMMANDLINE=%$COMMANDLINE% -skipwarning))


		if "%$DEBUG%" neq "" (if "%$DEBUG%" neq "0" (echo Update::INFO: run with params: `start /wait "Update" "%$APPLICATION%" %$COMMANDLINE%`))

		start /wait "Update" "%$APPLICATION%" %$COMMANDLINE%
		set $UPDATE_ERRORLEVEL=%ERRORLEVEL%

		if "%$DEBUG%" neq "" (if "%$DEBUG%" neq "0" (echo Update::INFO: run complete [exit code: %$UPDATE_ERRORLEVEL%]))

	:update.end

	set $COMMANDLINE=
	set $APPLICATION=
exit /b


:update_set_path
	::
	:: parameters
	::   %1 - update path
	::

	:update_set_path.begin

		set UPDATE_PATH=%~1

		echo Update::WARNING: variable `UPDATE_PATH` not defined, set it value to `%UPDATE_PATH%`

	:update_set_path.end
exit /b


:runatend_launcher
	::
	:: parameters
	::   none
	::

	:runatend_launcher.begin

		if "%$DEBUG%" neq "" (if "%$DEBUG%" neq "0" (echo RunAtEndLauncher::INFO: run at end call enabled))

		if exist "%RUN_AT_END_APPLICATION%" (call :runatend) else (if "%$DEBUG%" neq "" (if "%$DEBUG%" neq "0" (echo RunAtEndLauncher::WARNING: application "%RUN_AT_END_APPLICATION%" not exist)))

	:runatend_launcher.end
exit /b

:runatend
	::
	:: parameters
	::   none
	::

	:runatend.begin

		set $RUNATEND_ERRORLEVEL=255

		if "%$DEBUG%" neq "" (if "%$DEBUG%" neq "0" (echo RunAtEnd::INFO: run at end with params: `start /wait "RunAtEnd" "%RUN_AT_END_APPLICATION%" %RUN_AT_END_COMMANDLINE%`))

		start /wait "RunAtEnd" "%RUN_AT_END_APPLICATION%" %RUN_AT_END_COMMANDLINE%
		set $RUNATEND_ERRORLEVEL=%ERRORLEVEL%

		if "%$DEBUG%" neq "" (if "%$DEBUG%" neq "0" (echo RunAtEnd::INFO: run at end complete [exit code: %$RUNATEND_ERRORLEVEL%]))

		set MAIN_ERRORLEVEL=%$RUNATEND_ERRORLEVEL%

		if "%$DEBUG%" neq "" (if "%$DEBUG%" neq "0" (echo RunAtEnd::INFO: main ErrorLevel = %MAIN_ERRORLEVEL%))

	:runatend.end
exit /b


:wait20minutes
	::
	:: parameters
	::   none
	::

	set $APPLICATION=%GARANT%\apps\F1Sleep.exe
	set $COMMANDLINE=20

	:wait20minutes.begin

		set $WAIT20MINUTES_ERRORLEVEL=255

		if not exist "%$APPLICATION%" (echo Wait20Minutes::ERROR: application "%$APPLICATION%" not exist, call disabled& goto :wait20minutes.end)


		if "%$DEBUG%" neq "" (if "%$DEBUG%" neq "0" (echo Wait20Minutes::INFO: run with params: `start /wait "Wait 20 minutes" "%$APPLICATION%" %$COMMANDLINE%`))

		start /wait "Wait 20 minutes" "%$APPLICATION%" %$COMMANDLINE%
		set $WAIT20MINUTES_ERRORLEVEL=%ERRORLEVEL%

		if "%$DEBUG%" neq "" (if "%$DEBUG%" neq "0" (echo Wait20Minutes::INFO: run complete [exit code: %$WAIT20MINUTES_ERRORLEVEL%]))

	:wait20minutes.end

	set $COMMANDLINE=
	set $APPLICATION=
exit /b


:sendmail
	::
	:: parameters
	::   %1 - subject of message
	::   %2 - body of message (if empty == subject of message)
	::   %3 - attach file name (maybe empty, if attach not need)
	::

	set $APPLICATION=%GARANT%\apps\F1SendMail.exe
	set $COMMANDLINE=

	:sendmail.begin

		set $SENDMAIL_ERRORLEVEL=255

		if not exist "%$APPLICATION%" (echo SendMail::ERROR: application "%$APPLICATION%" not exist, call disabled& goto :sendmail.end)

		if "%MAIL_FROM%" equ "" (echo SendMail::ERROR: variable `MAIL_FROM` not defined, mail not sent& goto :sendmail.end)
		set $COMMANDLINE=%$COMMANDLINE% -f "%MAIL_FROM%"

		if "%MAIL_TO%" equ "" (echo SendMail::ERROR: variable `MAIL_TO` not defined, mail not sent& goto :sendmail.end)
		set $COMMANDLINE=%$COMMANDLINE% -to "%MAIL_TO%"

		if "%MAIL_SERVER%" equ "" (echo SendMail::ERROR: variable `MAIL_SERVER` not defined, mail not sent& goto :sendmail.end)
		set $COMMANDLINE=%$COMMANDLINE% -server "%MAIL_SERVER%"

		if "%MAIL_CHARSET%" equ "" (call :sendmail_set_charset "windows-1251")
		set $COMMANDLINE=%$COMMANDLINE% -charset "%MAIL_CHARSET%"

		if "%MAIL_PRIORITY%" equ "" (call :sendmail_set_priority "1")
		set $COMMANDLINE=%$COMMANDLINE% -priority "%MAIL_PRIORITY%"

		if "%MAIL_REPLYTO%" equ "" (call :sendmail_set_replyto "%MAIL_TO%")
		set $COMMANDLINE=%$COMMANDLINE% -replyto "%MAIL_REPLYTO%"

		if "%MAIL_SERVER_USER%" neq "" (set $COMMANDLINE=%$COMMANDLINE% -u "%MAIL_SERVER_USER%")
		if "%MAIL_SERVER_PASS%" neq "" (set $COMMANDLINE=%$COMMANDLINE% -pw "%MAIL_SERVER_PASS%")

		if "%~3" neq "" (set $COMMANDLINE=%$COMMANDLINE% -attach "%~3")
		if "%~2" neq "" (set $COMMANDLINE=%$COMMANDLINE% -body "%~2") else (if "%~1" neq "" (set $COMMANDLINE=%$COMMANDLINE% -body "%~1"))
		if "%~1" neq "" (set $COMMANDLINE=%$COMMANDLINE% -subject "%~1")

		if "%$DEBUG%" neq "" (if "%$DEBUG%" neq "0" (echo SendMail::INFO: run with params: `start /wait "SendMail" "%$APPLICATION%" - %$COMMANDLINE%`))

		start /wait "SendMail" "%$APPLICATION%" - %$COMMANDLINE%
		set $SENDMAIL_ERRORLEVEL=%ERRORLEVEL%

		if "%$DEBUG%" neq "" (if "%$DEBUG%" neq "0" (echo SendMail::INFO: run complete [exit code: %$SENDMAIL_ERRORLEVEL%]))
		
	:sendmail.end

	set $COMMANDLINE=
	set $APPLICATION=
exit /b


:sendmail_set_charset
	::
	:: parameters
	::   %1 - char set
	::

	:sendmail_set_charset.begin

		set MAIL_CHARSET=%~1

		echo SendMail::WARNING: variable `MAIL_CHARSET` not defined, set it value to `%MAIL_CHARSET%`

	:sendmail_set_charset.end
exit /b


:sendmail_set_priority
	::
	:: parameters
	::   %1 - char set
	::

	:sendmail_set_priority.begin

		set MAIL_PRIORITY=%~1

		echo SendMail::WARNING: variable `MAIL_PRIORITY` not defined, set it value to `%MAIL_PRIORITY%`

	:sendmail_set_priority.end
exit /b


:sendmail_set_replyto
	::
	:: parameters
	::   %1 - reply to
	::

	:sendmail_set_replyto.begin

		set MAIL_REPLYTO=%~1

		echo SendMail::WARNING: variable `MAIL_REPLYTO` not defined, set it value to `%MAIL_REPLYTO%`

	:sendmail_set_replyto.end
exit /b
