for /f "tokens=1-2 delims=:" %%B in ('TIME /T') do (
	set HOUR=%%B
	set MINUTE=%%C
)

rem Определяем, это виста или нет
SET VER_OUTPUT=%TEMP%\ver_output.txt
del /Q %VER_OUTPUT%
ver | find "6." > %VER_OUTPUT%

for %%A in (%VER_OUTPUT%) do SET VO_SIZE=%%~zA

if %VO_SIZE%==0 (
	set VISTA=NO
) else (
	set VISTA=YES
)

if %VISTA%==YES (
	set ADD_PARAMS=/IT
) else (
	set ADD_PARAMS=
)

schtasks /delete /tn start_tcreas /f
schtasks /create /tn start_tcreas /tr "%~dp0start_tcreas.bat" /sc ONCE /st %HOUR%:%MINUTE%:00 /s %COMPUTERNAME% -ru qc -rp 22222 %ADD_PARAMS%
schtasks /run /tn start_tcreas
rem schtasks /delete /tn start_tcreas /f