@echo off& setlocal

:main
	:main.begin

		echo.

		pushd "%~dp0"
			set FULLNAME=%~dpn0
			set FULLNAME=%FULLNAME:_ru-ru=%

			set MAINNAME=%~n0
			set MAINNAME=%MAINNAME:_ru-ru=%

			set CODEPAGE=1251
			set LANGUAGE=ru-ru

			set WIX_ROOT=C:\EXECUTE\SHAREDEV\WIX

			set WIX_LIB=wixui.wixlib
			set WIX_LOC=wixui_%LANGUAGE%.wxl

			set PRJ_LOC=%FULLNAME%_%LANGUAGE%.wxl

			if exist "%FULLNAME%.wxs" (
				if exist "%FULLNAME%.msi" (del "%FULLNAME%.msi" 1>nul 2>&1)
				if exist "%FULLNAME%.wixobj" (del "%FULLNAME%.wixobj" 1>nul 2>&1)

				candle.exe "%FULLNAME%.wxs" -nologo -out "%FULLNAME%.wixobj" -dLocaleCodePage="%CODEPAGE%" -dLocaleLanguage="%LANGUAGE%"& if errorlevel 1 (pause& goto :main.exit)

				if exist "%FULLNAME%.wixobj" (
					light.exe "%FULLNAME%.wixobj" -nologo -out "%MAINNAME%_%LANGUAGE%.msi" "%WIX_ROOT%\%WIX_LIB%" -loc "%WIX_ROOT%\%WIX_LOC%" -loc "%PRJ_LOC%"& if errorlevel 1 (pause)

					del "%FULLNAME%.wixobj" 1>nul 2>&1
				)
			)

			:main.exit
		popd

		goto :main.end

	:main.end

@endlocal& exit /b
