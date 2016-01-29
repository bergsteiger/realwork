@echo off& setlocal

	pushd "%~dp0"
		echo.
		call :main "%~0" %*
	popd

@endlocal& exit /b

:main
	:main.begin

		set DIR_MASK=*.mwc.
			for /f "usebackq tokens=*" %%a in (`dir /b "%DIR_MASK%"`) do (
				call :mwc "%%a"
			)
		set DIR_MASK=

		goto :main.end
		
	:main.end
exit /b

:mwc
	:mwc.begin

		set MWC_DEPENDENCY_COMBINED_STATIC_LIBRARY=1

		set MWC=%ACE_ROOT%\MPC\mwc.pl

		set MWC_TYPE=vc9

		perl "%MWC%" -ti lib_exe:GDiff.mwc -type %MWC_TYPE% "%~1"
		if errorlevel 1 (
			pause
		)

		goto :mwc.end

	:mwc.end
exit /b
