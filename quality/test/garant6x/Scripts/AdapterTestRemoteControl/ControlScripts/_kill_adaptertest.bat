call vars.bat
call _works_with_comps.bat

%FOR_ALL_COMPS_DO%
	%START% %START_PARAMS% "Kill %TEST_NAME% on %%A" "%PSTOOLS_PATH%\pskill.exe" \\!COMP_NAME! -u %USER_NAME% -p %PASSWORD% %PSTOOLS_COMMON_PARAMS% %TEST_NAME%
%END_FOR_ALL_COMPS_DO%
