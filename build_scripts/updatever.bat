@echo off

:main
	:main.begin

		echo.

		pushd "%~dp0"

			for /f "usebackq tokens=1,* delims=-" %%a in (`type "%~1"`) do (
				call :parse_project_and_version "%%a" "%%b"
			)

		popd

		goto :main.end

	:main.end

@exit /b

:parse_project_and_version
	:parse_project_and_version.begin

		for /f "usebackq tokens=1,2,3,* delims=_" %%a in (`echo %~2`) do (
			call :parse_version "%%a" "%%b" "%%c" "%%d"
		)

		goto :parse_project_and_version.end

	:parse_project_and_version.end

@exit /b

:parse_version
	:parse_version.begin

		if "%PROJECT_MAJOR%"=="" (
			set PROJECT_MAJOR=%~1
		)

		if "%PROJECT_MINOR%"=="" (
			set PROJECT_MINOR=%~2
		)

		if "%VERSION_MAJOR%"=="" (
			set VERSION_MAJOR=%~3
		)

		if "%VERSION_MINOR%"=="" (
			set VERSION_MINOR=%~4
		)

		set CALCULATOR=%CD%\ru.garant\bin\calcbuild.exe
		set CALCULATOR=%CALCULATOR:\\=\%

		if "%PROJECT_MAJOR%"=="%~1" (
			if "%PROJECT_MINOR%"=="%~2" (
				if "%VERSION_MAJOR%"=="%~3" (
					for /f "usebackq tokens=*" %%a in (`%CALCULATOR% "%%0.3u=%~4+1"`) do (
						call :update_version_minor "%%a"
					)
				)
			)
		)

		goto :parse_version.end

	:parse_version.end

@exit /b

:update_version_minor
	:update_version_minor.begin

		set VERSION_MINOR=%~1

		goto :update_version_minor.end

	:update_version_minor.end

@exit /b
