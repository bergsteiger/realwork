REM @ECHO OFF

REM --------------- Start of Assembly ---------------
ECHO Сборка документации началась %DATE% в %TIME% > \\archi2-2008\archi\DAILY_MANUALS\ManualCHMlBuild.log.txt
ECHO. >> \\archi2-2008\archi\DAILY_MANUALS\ManualCHMlBuild.log.txt

REM --------------- Variables for the build process ---------------
	REM Assign a variable to specify the version HELPMAN.EXE
	SET HM_NUMER_VERSION=6

	REM Assign a variable to specify HELPMAN.EXE
	SET HM_COMPILE="C:\Program Files (x86)\EC Software\HelpAndManual%HM_NUMER_VERSION%\HELPMAN.EXE"

REM ----------- We are starting the Assembly of project documents -----------

REM AUTOPIPESERVER
%HM_COMPILE% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Autopipeserver.AdminGuide.hmxz /tsk=ALCUCHM:AutoPipeServer.AdminGuide(rCHM) /tsk=ALCUCHM:AutoPipeServer.AdminGuide(fCHM) /tsk=ALCUCHM:AutoPipeServer.AdminGuide(rCHM)_!DAILY /tsk=ALCUCHM:AutoPipeServer.AdminGuide(fCHM)_!DAILY


ECHO AUTOPIPESERVER - ОК >> \\archi2-2008\archi\DAILY_MANUALS\ManualCHMlBuild.log.txt 

REM DESCRIPT
%HM_COMPILE% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Descript.hmxz "/tsk=Recent Publishes:Descript" "/tsk=Recent Publishes:Descript_!DAILY"
ECHO DESCRIPT - ОК >> \\archi2-2008\archi\DAILY_MANUALS\ManualCHMlBuild.log.txt

REM NSRCSPY
%HM_COMPILE% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Nsrcspy.AdminGuide.hmxz /tsk=NSRCSCHM:NSRCSpy.AdminGuide(r) /tsk=NSRCSCHM:NSRCSpy.AdminGuide(en) /tsk=NSRCSCHM:NSRCSpy.AdminGuide(r)_!DAILY /tsk=NSRCSCHM:NSRCSpy.AdminGuide(en)_!DAILY
ECHO NSRCSPY - ОК >> \\archi2-2008\archi\DAILY_MANUALS\ManualCHMlBuild.log.txt

REM ARCHIVARIUS.COMPLEKS
%HM_COMPILE% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Archivarius.Compleks.hmxz /tsk=Common:Archivarius.Compleks(chm)
ECHO ARCHIVARIUS.COMPLEKS - ОК >> \\archi2-2008\archi\DAILY_MANUALS\ManualCHMlBuild.log.txt

ECHO. >> \\archi2-2008\archi\DAILY_MANUALS\ManualCHMlBuild.log.txt
ECHO Сборка документации завершена %DATE% в %TIME% >> \\archi2-2008\archi\DAILY_MANUALS\ManualCHMlBuild.log.txt
