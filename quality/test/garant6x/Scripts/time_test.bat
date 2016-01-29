regedit -s "W:\quality\test\garant6x\Scripts\clear_autologin.reg"
net use \\developer\garant-nemesis /u:kir lazarus

if "%OS%"=="Windows_NT" SET WIN_VER=Winnt
if "%OS%"=="" SET WIN_VER=Win9x

@echo off
SET SERVER_HOST=\\test-07

psservice.exe "%SERVER_HOST%" -u Administrator -p "" stop GarantF1Server

SET PATH_XML=\\ax222\buffer\Timing\Settings\XML
SET SERVER_PATH=T:
@echo off

if exist "%SERVER_PATH%\settings" del /q /f /s "%SERVER_PATH%\settings"

@copy /b \\developer\garant-nemesis\deployment\!daily\server\settings "%SERVER_PATH%\settings"
@copy /b \\developer\garant-nemesis\deployment\!daily\server\settings\userdata "%SERVER_PATH%\settings\userdata"
@copy /b \\developer\garant-nemesis\deployment\!daily\server\settings\xmltools "%SERVER_PATH%\settings\xmltools"
@copy /b \\developer\garant-nemesis\deployment\!daily\server\settings\xmltools\Win9x "%SERVER_PATH%\settings\xmltools\Win9x"
@copy /b \\developer\garant-nemesis\deployment\!daily\server\settings\xmltools\Winnt "%SERVER_PATH%\settings\xmltools\Winnt"

psservice.exe %SERVER_HOST% -u Administrator -p "" start GarantF1Server

@echo on
echo ***************Start robot tests (%DATE%::%TIME%)**************** >>"C:\timeRobotResult.res"
type \\developer\garant-nemesis\deployment\!daily\!cvs_tag >>"C:\timeRobotResult.res"
@echo off

"%RATL_RTHOME%\rtmanager.exe" Time_Test /runsuite /user admin /project "W:\quality\test\garant6x\ra\nemesis.rsp" /computers Local /build "Build 1" /logfolder Default /log TimeTestLog_%USERDOMAIN%_%USERNAME% /overwritelog /close
@echo on
echo ***************End robot tests (%DATE%::%TIME%)**************** >>"C:\timeRobotResult.res"
@echo off

blat -install smtp.garant.ru timetest@garant.ru
blat "C:\timerobotresult.res" -subject "Result of time test [Robot]" -to qc@garant.ru
