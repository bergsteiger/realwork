@echo off& setlocal

:main
	:main.begin

		echo.

		pushd "%~dp0"

			set DIR_PATERN=F1*SetupRus_??-??.bat.

			if exist "%DIR_PATERN%" (
				for /f "usebackq tokens=*" %%a in (`dir /b "%DIR_PATERN%"`) do (
					call "%%a"
				)
			)

			set DIR_PATERN=F1*SetupEng_??-??.bat.

			if exist "%DIR_PATERN%" (
				for /f "usebackq tokens=*" %%a in (`dir /b "%DIR_PATERN%"`) do (
					call "%%a"
				)
			)
		popd

		goto :main.end

	:main.end

@endlocal& exit /b
