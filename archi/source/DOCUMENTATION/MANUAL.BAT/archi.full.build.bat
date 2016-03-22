REM @ECHO OFF

REM Delete old files in a folder
del /q \\archi2-2008\archi\DAILY_MANUALS

REM --------------- Start of Assembly ---------------

ECHO —борка документации началась %DATE% в %TIME% > \\archi2-2008\archi\DAILY_MANUALS\ManualFullBuild.log.txt
ECHO. >> \\archi2-2008\archi\DAILY_MANUALS\ManualFullBuild.log.txt
	CALL archi.doc.build.bat
	CALL archi.chm.build.bat

	CALL distrib.archi.luk.bat	REM COLLECT A DISTRIBUTION FOR LUKOIL
	CALL distrib.archi.region.bat	REM COLLECT A DISTRIBUTION FOR REGION
REM	CALL distrib.archi.region.alink.bat	REM COLLECT A DISTRIBUTION FOR REGION(ALINK)
	
	CALL archi.web.build.bat	
ECHO. >> \\archi2-2008\archi\DAILY_MANUALS\ManualFullBuild.log.txt
ECHO —борка документации завершена %DATE% в %TIME% >> \\archi2-2008\archi\DAILY_MANUALS\ManualFullBuild.log.txt

