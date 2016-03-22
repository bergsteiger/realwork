REM @ECHO OFF

REM Затираем старые с подкаталогами
rd /q /s \\archi2-2008\archi\DAILY_MANUALS\WebHelp

REM --------------- Start of Assembly ---------------
ECHO Сборка документации началась %DATE% в %TIME% > \\archi2-2008\archi\DAILY_MANUALS\ManualWeblBuild.log.txt
ECHO. >> \\archi2-2008\archi\DAILY_MANUALS\ManualWeblBuild.log.txt

REM --------------- Variables for the build process ---------------
	REM Assign a variable to specify the version HELPMAN.EXE
	SET hm_numer_version=6

	REM Assign a variable to specify HELPMAN.EXE
	SET hm_compile="C:\Program Files (x86)\EC Software\HelpAndManual%hm_numer_version%\HELPMAN.EXE"

REM ----------- We are starting the Assembly of project documents -----------

REM ADDIMG
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\AddImg.AdminGuide.hmxz "/tsk=Recent Publishes:AddImg.AdminGuide(web)_!DAILY"

REM ADJUSTTOPAGE
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\AdjustToPage.AdminGuide.hmxz "/tsk=Recent Publishes:AdjustToPage.AdminGuide(web)_!DAYLY"

REM ADMINISTRATOR
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Administrator.AdminGuide.hmxz "/tsk=Recent Publishes:Administrator.AdminGuide(web)_!DAILY"

REM ARCHIVARIUS.APPOSITIONBD
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Archivarius.AppositionBD.hmxz "/tsk=Recent Publishes:Archivarius.AppositionBD.AdminGuide(web)_!DAILY"

REM ARCHIVARIUS.AUTOLINK
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Archivarius.AutoLink.AdminGuide.hmxz /tsk=ARCHIWEB:Archivarius.AutoLink.AdminGuide(web)_!DAILY

REM ARCHIVARIUS.INTRODUCTIONOPERATION
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Archivarius.IntroductionOperation.hmxz "/tsk=Recent Publishes:Archivarius.IntroductionOperation(web)_!DAILY"

REM RELEASENOTES
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Archivarius.ReleaseNotes.hmxz /tsk=CustomBuild:ReleaseNotes.AddImg(web)_!DAILY /tsk=CustomBuild:ReleaseNotes.Adjust2page(web)_!DAILY /tsk=CustomBuild:ReleaseNotes.Dbupdate(web)_!DAILY /tsk=CustomBuild:ReleaseNotes.Dictsync(web)_!DAILY /tsk=CustomBuild:ReleaseNotes.Listimport(web)_!DAILY /tsk=CustomBuild:ReleaseNotes.Nsrplus2nsr(web)_!DAILY /tsk=CustomBuild:ReleaseNotes.Pipeout2(web)_!DAILY /tsk=CustomBuild:ReleaseNotes.Regiontool(web)_!DAILY /tsk=CustomBuild:ReleaseNotes.Admin2(web)_!DAILY /tsk=CustomBuild:ReleaseNotes.Archivarius(web)_!DAILY /tsk=CustomBuild:ReleaseNotes.BaseVersion(web)_!DAILY /tsk=CustomBuild:ReleaseNotes.Autopipeserver(web)_!DAILY /tsk=CustomBuild:ReleaseNotes.Nsrcspy(web)_!DAILY /tsk=CustomBuild:ReleaseNotes.Everest(web)_!DAILY /tsk=CustomBuild:ReleaseNotes.DBUtil(web)_!DAILY
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Archivarius.ReleaseNotes.hmxz "/tsk=Recent Publishes:Archivarius.ReleaseNotes(web)_!DAILY"

REM ARCHIVARIUS.SETTING
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Archivarius.SETting.AdminGuide.hmxz "/tsk=Recent Publishes:Archivarius.SETting.AdminGuide(web)_!DAILY"

REM ARCHIVARIUS
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Archivarius.UserGuide.hmxz /tsk=FullBuild:Archivarius.UserGuide(web)_!DAILY

REM AUTOPIPESERVER
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Autopipeserver.AdminGuide.hmxz /tsk=ALCUWEB:AutoPipeServer.AdminGuide(r_web)_!DAILY /tsk=ALCUWEB:AutoPipeServer.AdminGuide(f_web)_!DAILY /tsk=ALCUWEB:AutoPipeServer.AdminGuide(luk_web)_!DAILY /tsk=ALCUWEB:AutoPipeServer.AdminGuide(alink_web)_!DAILY

REM ClearClass
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Clearclass.AdminGuide.hmxz /tsk=RegionTool:Clearclass.AdminGuide(web)_!DAILY

REM DBUTIL
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\DbUtil.AdminGuide.hmxz /tsk=FullBuild:DbUtil.AdminGuide(web)_!DAILY

REM DELPREFIX
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Delprefix.AdminGuide.hmxz /tsk=DelPrefixBuild:Delprefix.AdminGuide(web)_!DAILY

REM DESCRIPTION OF THE PROCESS OF THE TECHNICAL PROCESSING THE DOCUMENT
%hm_compile% "D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Description of the process of the technical processing the document.hmxz" "/tsk=Recent Publishes:TechDocument(web)_!DAILY"

REM DICTSYNC
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Dictsync.AdminGuide.hmxz "/tsk=Recent Publishes:DictSync.AdminGuide(web)_!DAILY"

REM FAQ
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\FAQ.UserGuide.hmxz /tsk=FAQ_Task:FAQ.UserGuide(web)_!DAILY

REM GZPRJ
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\gzPrj.AdminGuide.hmxz "/tsk=Recent Publishes:gzPrj.AdminGuide(web)_!DAILY"

REM HYTECH.CORRECTIONTABLE
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\HyTech.CorrectionTable.AdminGuide.hmxz "/tsk=Recent Publishes:HyTech.CorrectionTable.AdminGuide(web)_!DAILY"

REM HYTECHAPI.CODELIST
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\HyTechAPI.CodeList.hmxz "/tsk=Recent Publishes:HyTech API.CodeList.AdminGuide(web)_!DAILY"

REM KILLTR
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\KILLTR.UserGuide.hmxz "/tsk=Recent Publishes:KILLTR.UserGuide(web)_!DAILY"

REM LISTIMPORT
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\ListImport.AdminGuide.hmxz "/tsk=Recent Publishes:ListImport.AdminGuide(web)_!DAILY"

REM NSRCSPY
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Nsrcspy.AdminGuide.hmxz /tsk=NSRCSWEB:NSRCSpy.AdminGuide(r)_!DAILY /tsk=NSRCSWEB:NSRCSpy.AdminGuide(en)_!DAILY

REM NSRPLUS2NSR
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Nsrplus2nsr.AdminGuide.hmxz "/tsk=Recent Publishes:NSRplus2nsr.AdminGuide(web)_!DAILY"

REM PIPEOUT2
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\PipeOut2.AdminGuide.hmxz "/tsk=Recent Publishes:PipeOut2.AdminGuide(web)_!DAILY"

REM PROCEDURE FOR MAKING PROOFREADING
%hm_compile% "D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Procedure for making proofreading.hmxz" "/tsk=Recent Publishes:ProceduREMakingProofreading(web)_!DAILY"

REM REGIONTOOL
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\RegionTool.AdminGuide.hmxz /tsk=RegionTool:RegionTool.AdminGuide(web)_!DAILY

REM THE SEQUENCE OF ACTIONS WHEN ENTERING NEW DOCUMENTS
%hm_compile% "D:\MANUAL(CVS)\archi\source\DOCUMENTATION\The sequence of actions when entering new documents.hmxz" "/tsk=Recent Publishes:SequenceActionsEnteringNewDocuments(web)_!DAILY"

REM ARHIVARIUS.COMPLEKS
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Archivarius.Compleks.hmxz /tsk=Common:Archivarius.Compleks(web)_!DAILY

ECHO. >> \\archi2-2008\archi\DAILY_MANUALS\ManualWeblBuild.log.txt
ECHO Сборка документации завершена %DATE% в %TIME% >> \\archi2-2008\archi\DAILY_MANUALS\ManualWeblBuild.log.txt
