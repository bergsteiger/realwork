@echo off& setlocal

REM ѕример батника дл€ запуска утилиты тестировани€

:main
	:main.begin
		regedit -s "set_ORBEndPoint.reg"
		for /L %%a in (1,1,10) do (start PayLoadTest.exe -login %%a -pass %%a -if_need_other_test -count_doc_open 100)

		goto :main.end

	:main.end

@endlocal& exit /b
