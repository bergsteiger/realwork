@echo off& setlocal

:main
	:main.begin

		echo.

		pushd "%~dp0"
			set CODEPAGE=1252
			set LANGUAGE=en-us

			set WIX_ROOT=C:\EXECUTE\WIX

			set WIX_LIB=wixui.wixlib
			set WIX_LOC=wixui_%LANGUAGE%.wxl

			set PRJ_LOC=%~dpn0_%LANGUAGE%.wxl

			if exist "%~dpn0.wxs" (
				if exist "%~dpn0.msi" (del "%~dpn0.msi" 1>nul 2>&1)
				if exist "%~dpn0.wixobj" (del "%~dpn0.wixobj" 1>nul 2>&1)

				candle.exe "%~dpn0.wxs" -nologo -out "%~dpn0.wixobj" -dLocaleCodePage="%CODEPAGE%"& if errorlevel 1 (pause& goto :main.exit)

				if exist "%~dpn0.wixobj" (
					light.exe "%~dpn0.wixobj" -nologo -out "%~n0.msi" "%WIX_ROOT%\%WIX_LIB%" -loc "%WIX_ROOT%\%WIX_LOC%" -loc "%PRJ_LOC%"& if errorlevel 1 (pause)

					del "%~dpn0.wixobj" 1>nul 2>&1
				)
			)

			:main.exit
		popd

		goto :main.end

	:main.end

@endlocal& exit /b
