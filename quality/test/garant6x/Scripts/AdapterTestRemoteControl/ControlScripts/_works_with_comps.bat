call vars.bat

set DELIM=:
set FOR_PARAM="tokens=1,2 delims=%DELIM%"

set FOR_ALL_COMPS_DO=for /f %FOR_PARAM% %%A in (^^!AVAILABLE_COMPS_LIST^^!) do ( set COMP_NAME=%%A^^^& set /a COMP_RANK=%%^^^B&
set END_FOR_ALL_COMPS_DO=)
set AVAILABLE_COMPS_LIST=%TEMP%\available_comps_list.2431412341

if "%WORKS_WITH_COMPS_IS_FIRST_CALL%" == "" (
	rem Проверяем, чтобы все машины были доступны и формируем список этих машин
	del /q "%AVAILABLE_COMPS_LIST%"
	for /f %FOR_PARAM% %%A in (%COMPS_LIST%) do if "%%A" neq "" (
		set COMP_NAME=%%A
		set COMP_RANK=%%B
		if "!COMP_RANK!" equ "" set COMP_RANK=1
		ping !COMP_NAME! -n 1 >"%TEMP%\qerqwerqwerwqer"
		if !ERRORLEVEL!==0 echo !COMP_NAME!%DELIM%!COMP_RANK!>> "%AVAILABLE_COMPS_LIST%"
	)
	set WORKS_WITH_COMPS_IS_FIRST_CALL=1
)