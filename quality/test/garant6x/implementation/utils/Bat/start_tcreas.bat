if exist "%PROGRAMFILES%\Automated QA\TestComplete 3\tcrea.exe" (
	start "tcrea" "%PROGRAMFILES%\Automated QA\TestComplete 3\tcrea.exe"
) else (
	if exist "%PROGRAMFILES%\Automated QA\TestExecute 3\tcrea.exe" 	(
		start "tcrea" "%PROGRAMFILES%\Automated QA\TestExecute 3\tcrea.exe"
	)
)

rem Это задержка
ping -n 1 -w 5000 111.111.111.111

if exist "%PROGRAMFILES%\Automated QA\TestComplete 5\Bin\tcrea.exe" (
	start "tcrea" "%PROGRAMFILES%\Automated QA\TestComplete 5\Bin\tcrea.exe"
) else (
	if exist "%PROGRAMFILES%\Automated QA\TestExecute 5\Bin\tcrea.exe" (
		start "tcrea" "%PROGRAMFILES%\Automated QA\TestExecute 5\Bin\tcrea.exe"
	)
)
