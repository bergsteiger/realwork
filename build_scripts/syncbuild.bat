@echo off& setlocal

:main
	:main.begin

		echo.

		set SYNC_HOME=%PROGRAMFILES%\Windows Support\FreeFileSync

		set SYNC_APP=%SYNC_HOME%\freefilesync.exe
		set SYNC_JOB=%~1.ffs_batch

			"%SYNC_APP%" "%SYNC_JOB%"

		set SYNC_JOB=
		set SYNC_APP=

		set SYNC_HOME=

		goto :main.end

	:main.end

@endlocal& exit /b
