@echo off& setlocal

:main
	:main.begin

		for /L %%a in (1,1,10) do (start "W:\build\bin\Client_Debug_Static\TimeTest.exe" -login %%a -pass %%a -DocNumerList "ALL")

		goto :main.end

	:main.end

@endlocal& exit /b
