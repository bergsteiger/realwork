REM @ECHO OFF

REM --------------- Variables for the build process ---------------
	REM Path to "advanced installer"
	SET ADI_COMPILE="C:\Program Files (x86)\Caphyon\Advanced Installer 11.6.2\bin\x86\advinst.exe"
	
	REM Path to the project
	SET ADI_PROJECT_AI=D:\MANUAL(CVS)\archi\source\DISTRIBUTE\Archi.Region\Archi.Distrib.Region.aip
	
	REM Build number for the project
	SET ADI_VERSION=10831

REM ----------- We are starting the Assembly of the distribution -----------

%ADI_COMPILE% /edit %ADI_PROJECT_AI% /SetVersion %ADI_VERSION%
%ADI_COMPILE% /build %ADI_PROJECT_AI%

REM Затираем дистрибутив
rd /q /s D:\MANUAL(CVS)\archi\source\DISTRIBUTE\Archi.Region\ArchiBuild 
