if "%OS%"=="Windows_NT" SET WIN_VER=Winnt
if "%OS%"=="" SET WIN_VER=Win9x

@echo off
SET PATH_XML=C:\XML
SET SERVER_PATH=T:
SET SETTING_PATH=D:

@echo off



IF "%1"=="" (
SET COUNT_EXECUTE=20
) ELSE (
SET COUNT_EXECUTE=%1
)

for /L %%a in (1,1,%COUNT_EXECUTE%) do (


if exist "%PATH_XML%" del /q /f /s "%PATH_XML%"
if exist "%SERVER_PATH%\logs\save.log" del /q /f /s "%SERVER_PATH%\logs\save.log"
if exist "%SERVER_PATH%\logs\load.log" del /q /f /s "%SERVER_PATH%\logs\load.log"


if not exist "%SETTING_PATH%\settings" goto end
if exist "%SERVER_PATH%\settings" del /q /f /s "%SERVER_PATH%\settings"

@copy /b "%SETTING_PATH%\settings" "%SERVER_PATH%\settings"
@copy /b "%SETTING_PATH%\settings\userdata" "%SERVER_PATH%\settings\userdata"
@copy /b "%SETTING_PATH%\settings\xmltools" "%SERVER_PATH%\settings\xmltools"
@copy /b "%SETTING_PATH%\settings\xmltools\Win9x" "%SERVER_PATH%\settings\xmltools\Win9x"
@copy /b "%SETTING_PATH%\settings\xmltools\Winnt" "%SERVER_PATH%\settings\xmltools\Winnt"


"%SERVER_PATH%\settings\xmltools\%WIN_VER%\F1UsersSave.exe" -GCMActiveDataPath 2 -GCMDataPath1 "%SERVER_PATH%\data2" -GCMDataPath2 "%SERVER_PATH%\data2" -GCMSettingsDataPath %PATH_XML% -GCMSettingsPath "%SERVER_PATH%\settings" -ORBDottedDecimalAddresses 1 -ORBUseSharedProfiles 1 -ORBLogFile "%SERVER_PATH%\logs\save.log"

if exist "%SERVER_PATH%\settings" del /q /f /s "%SERVER_PATH%\settings"

@copy /b \\developer\garant-nemesis\deployment\!daily\server\settings "%SERVER_PATH%\settings"
@copy /b \\developer\garant-nemesis\deployment\!daily\server\settings\userdata "%SERVER_PATH%\settings\userdata"
@copy /b \\developer\garant-nemesis\deployment\!daily\server\settings\xmltools "%SERVER_PATH%\settings\xmltools"
@copy /b \\developer\garant-nemesis\deployment\!daily\server\settings\xmltools\Win9x "%SERVER_PATH%\settings\xmltools\Win9x"
@copy /b \\developer\garant-nemesis\deployment\!daily\server\settings\xmltools\Winnt "%SERVER_PATH%\settings\xmltools\Winnt"

"%SERVER_PATH%\settings\xmltools\%WIN_VER%\F1UsersLoad.exe" -GCMActiveDataPath 2 -GCMDataPath1 "%SERVER_PATH%\data2" -GCMDataPath2 "%SERVER_PATH%\data2" -GCMSettingsDataPath %PATH_XML% -GCMSettingsPath "%SERVER_PATH%\settings" -ORBDottedDecimalAddresses 1 -ORBUseSharedProfiles 1 -ORBLogFile "%SERVER_PATH%\logs\load.log"

)


type "%SERVER_PATH%\logs\save.log" >"%CD%\xml_test.log"
echo ************************************************************************************ >>"%CD%\xml_test.log"
echo ************************************************************************************ >>"%CD%\xml_test.log"
type "%SERVER_PATH%\logs\load.log" >>"%CD%\xml_test.log"

blat -install smtp.garant.ru pugin@garant.ru
blat "%CD%\xml_test.log" -subject "Result of time test" -to qc@garant.ru

del /q /f /s "%SERVER_PATH%\logs\save.log"
del /q /f /s "%SERVER_PATH%\logs\load.log"

:end
exit
