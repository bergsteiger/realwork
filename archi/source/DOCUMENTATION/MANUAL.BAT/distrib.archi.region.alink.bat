REM @ECHO OFF

REM --------------- Start of Assembly ---------------
ECHO Сборка дистрибутива началась %DATE% в %TIME% > \\archi2-2008\archi\DAILY_MANUALS\Distrib.Region.Alink.log.txt
ECHO. >> \\archi2-2008\archi\DAILY_MANUALS\Distrib.Region.Alink.log.txt

REM --------------- Variables for the build process ---------------
	REM Path to "advanced installer"
	SET ADI_COMPILE="C:\Program Files (x86)\Caphyon\Advanced Installer 11.6.2\bin\x86\advinst.exe"
	
	REM Path to the project
	SET ADI_PROJECT_AI=d:\MANUAL(CVS)\archi\source\DISTRIBUTE\DistribArchi.Reg(alink).aip
	
	REM Build number for the project
	SET ADI_VERSION=10854

REM ----------- We are starting the Assembly of the distribution -----------

%ADI_COMPILE% /edit %ADI_PROJECT_AI% /SetVersion %ADI_VERSION%
%ADI_COMPILE% /build %ADI_PROJECT_AI%

ECHO. >> \\archi2-2008\archi\DAILY_MANUALS\Distrib.Region.Alink.log.txt
ECHO Сборка дистрибутива завершена %DATE% в %TIME% >> \\archi2-2008\archi\DAILY_MANUALS\Distrib.Region.Alink.log.txt

REM Затираем дистрибутив
rd /q /s D:\MANUAL(CVS)\archi\source\DISTRIBUTE\DistribRegBuild(al)
rd /q /s D:\MANUAL(CVS)\archi\source\DISTRIBUTE\DistribArchi.Reg(alink)-cache