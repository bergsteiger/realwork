REM @ECHO OFF

REM --------------- Start of Assembly ---------------
ECHO —борка документации началась %DATE% в %TIME% > \\archi2-2008\archi\DAILY_MANUALS\ManualDocBuild.log.txt
ECHO. >> \\archi2-2008\archi\DAILY_MANUALS\ManualDocBuild.log.txt

REM --------------- Variables for the build process ---------------
	REM Assign a variable to specify the version HELPMAN.EXE
	SET HM_NUMER_VERSION=7

	REM Assign a variable to specify HELPMAN.EXE
	SET HM_COMPILE="C:\Program Files (x86)\EC Software\HelpAndManual%HM_NUMER_VERSION%\HELPMAN.EXE"

REM ----------- We are starting the Assembly of project documents -----------

REM ADDIMG
%HM_COMPILE% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\AddImg.AdminGuide.hmxz "/tsk=Recent Publishes:AddImg.AdminGuide" "/tsk=Recent Publishes:AddImg.AdminGuide_!DAILY"

REM ADJUSTTOPAGE
%HM_COMPILE% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\AdjustToPage.AdminGuide.hmxz "/tsk=Recent Publishes:AdjustToPage.AdminGuide" "/tsk=Recent Publishes:AdjustToPage.AdminGuide_!DAYLY"

REM ADMINISTRATOR
%HM_COMPILE% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Administrator.AdminGuide.hmxz "/tsk=Recent Publishes:Administrator.AdminGuide" "/tsk=Recent Publishes:Administrator.AdminGuide_!DAILY"

REM ARCHIVARIUS.APPOSITIONBD
%HM_COMPILE% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Archivarius.AppositionBD.hmxz "/tsk=Recent Publishes:Archivarius.AppositionBD.AdminGuide" "/tsk=Recent Publishes:Archivarius.AppositionBD.AdminGuide_!DAILY"

REM ARCHIVARIUS.AUTOLINK
%HM_COMPILE% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Archivarius.AutoLink.AdminGuide.hmxz /tsk=ARCHIDOC:Archivarius.AutoLink.AdminGuide /tsk=ARCHIDOC:Archivarius.AutoLink.AdminGuide_!DAILY

REM ARCHIVARIUS.INTRODUCTIONOPERATION
%HM_COMPILE% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Archivarius.IntroductionOperation.hmxz "/tsk=Recent Publishes:Archivarius.IntroductionOperation" "/tsk=Recent Publishes:Archivarius.IntroductionOperation_!DAILY"

REM RELEASENOTES
%HM_COMPILE% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Archivarius.ReleaseNotes.hmxz /tsk=CustomBuild:ReleaseNotes.AddImg /tsk=CustomBuild:ReleaseNotes.Adjust2page /tsk=CustomBuild:ReleaseNotes.Dbupdate /tsk=CustomBuild:ReleaseNotes.DBUtil /tsk=CustomBuild:ReleaseNotes.Dictsync /tsk=CustomBuild:ReleaseNotes.Listimport /tsk=CustomBuild:ReleaseNotes.Nsrplus2nsr /tsk=CustomBuild:ReleaseNotes.Pipeout2 /tsk=CustomBuild:ReleaseNotes.Regiontool /tsk=CustomBuild:ReleaseNotes.Admin2 /tsk=CustomBuild:ReleaseNotes.Archivarius /tsk=CustomBuild:ReleaseNotes.BaseVersion /tsk=CustomBuild:ReleaseNotes.Autopipeserver /tsk=CustomBuild:ReleaseNotes.Nsrcspy /tsk=CustomBuild:ReleaseNotes.AddImg_!DAILY /tsk=CustomBuild:ReleaseNotes.Adjust2page_!DAILY /tsk=CustomBuild:ReleaseNotes.Dbupdate_!DAILY /tsk=CustomBuild:ReleaseNotes.DBUtil_!DAILY /tsk=CustomBuild:ReleaseNotes.Dictsync_!DAILY /tsk=CustomBuild:ReleaseNotes.Listimport_!DAILY /tsk=CustomBuild:ReleaseNotes.Nsrplus2nsr_!DAILY /tsk=CustomBuild:ReleaseNotes.Pipeout2_!DAILY /tsk=CustomBuild:ReleaseNotes.Regiontool_!DAILY /tsk=CustomBuild:ReleaseNotes.Admin2_!DAILY /tsk=CustomBuild:ReleaseNotes.Archivarius_!DAILY /tsk=CustomBuild:ReleaseNotes.BaseVersion_!DAILY /tsk=CustomBuild:ReleaseNotes.Autopipeserver_!DAILY /tsk=CustomBuild:ReleaseNotes.Nsrcspy_!DAILY /tsk=CustomBuild:ReleaseNotes.Everest /tsk=CustomBuild:ReleaseNotes.Everest_!DAILY
%HM_COMPILE% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Archivarius.ReleaseNotes.hmxz "/tsk=Recent Publishes:Archivarius.ReleaseNotes_!DAILY" "/tsk=Recent Publishes:Archivarius.ReleaseNotes"

REM ARCHIVARIUS.SETTING
%HM_COMPILE% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Archivarius.SETting.AdminGuide.hmxz "/tsk=Recent Publishes:Archivarius.SETting.AdminGuide" "/tsk=Recent Publishes:Archivarius.SETting.AdminGuide_!DAILY"

REM ARCHIVARIUS
%HM_COMPILE% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Archivarius.UserGuide.hmxz /tsk=FullBuild:Archivarius.UserGuide(f) /tsk=FullBuild:Archivarius.UserGuide(r)_!DAILY /tsk=FullBuild:Archivarius.UserGuide(r)

REM AUTOPIPESERVER
%HM_COMPILE% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Autopipeserver.AdminGuide.hmxz /tsk=ALCUDOC:AutoPipeServer.AdminGuide(r) /tsk=ALCUDOC:AutoPipeServer.AdminGuide(f) /tsk=ALCUDOC:AutoPipeServer.AdminGuide(luk) /tsk=ALCUDOC:AutoPipeServer.AdminGuide(r)_!DAILY /tsk=ALCUDOC:AutoPipeServer.AdminGuide(f)_!DAILY /tsk=ALCUDOC:AutoPipeServer.AdminGuide(alink) /tsk=ALCUDOC:AutoPipeServer.AdminGuide(luk)_!DAILY /tsk=ALCUDOC:AutoPipeServer.AdminGuide(alink)_!DAILY

REM CLEARCLASS
%HM_COMPILE% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Clearclass.AdminGuide.hmxz /tsk=RegionTool:Clearclass.AdminGuide /tsk=RegionTool:Clearclass.AdminGuide_!DAILY

REM DBUTIL
%HM_COMPILE% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\DbUtil.AdminGuide.hmxz /tsk=FullBuild:DbUtil.AdminGuide /tsk=FullBuild:DbUtil.AdminGuide_!DAILY
REM Delprefix
%HM_COMPILE% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Delprefix.AdminGuide.hmxz /tsk=DelPrefixBuild:Delprefix.AdminGuide /tsk=DelPrefixBuild:Delprefix.AdminGuide_!DAILY

REM DESCRIPTION OF THE PROCESS OF THE TECHNICAL PROCESSING THE DOCUMENT
%HM_COMPILE% "D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Description of the process of the technical processing the document.hmxz" "/tsk=Recent Publishes:TechDocument" "/tsk=Recent Publishes:TechDocument_!DAILY"

REM DICTSYNC
%HM_COMPILE% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Dictsync.AdminGuide.hmxz "/tsk=Recent Publishes:Dictsync.AdminGuide" "/tsk=Recent Publishes:DictSync.AdminGuide_!DAILY"

REM FAQ
%HM_COMPILE% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\FAQ.UserGuide.hmxz /tsk=FAQ_Task:FAQ.UserGuide /tsk=FAQ_Task:FAQ.UserGuide_!DAILY

REM GZPRJ
%HM_COMPILE% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\gzPrj.AdminGuide.hmxz "/tsk=Recent Publishes:gzPrj.AdminGuide" "/tsk=Recent Publishes:gzPrj.AdminGuide_!DAILY"

REM HYTECH.CORRECTIONTABLE
%HM_COMPILE% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\HyTech.CorrectionTable.AdminGuide.hmxz "/tsk=Recent Publishes:HyTech.CorrectionTable.AdminGuide" "/tsk=Recent Publishes:HyTech.CorrectionTable.AdminGuide_!DAILY"

REM HYTECHAPI.CODELIST
%HM_COMPILE% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\HyTechAPI.CodeList.hmxz "/tsk=Recent Publishes:HyTech API.CodeList.AdminGuide" "/tsk=Recent Publishes:HyTech API.CodeList.AdminGuide_!DAILY"

REM KILLTR
%HM_COMPILE% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\KILLTR.UserGuide.hmxz "/tsk=Recent Publishes:KILLTR.UserGuide" "/tsk=Recent Publishes:KILLTR.UserGuide_!DAILY"

REM LISTIMPORT
%HM_COMPILE% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\ListImport.AdminGuide.hmxz "/tsk=Recent Publishes:ListImport.AdminGuide" "/tsk=Recent Publishes:ListImport.AdminGuide_!DAILY"

REM NSRCSPY
%HM_COMPILE% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Nsrcspy.AdminGuide.hmxz /tsk=NSRCSDOC:NSRCSpy.AdminGuide(r) /tsk=NSRCSDOC:NSRCSpy.AdminGuide(en) /tsk=NSRCSDOC:NSRCSpy.AdminGuide(r)_!DAILY /tsk=NSRCSDOC:NSRCSpy.AdminGuide(en)_!DAILY

REM NSRPLUS2NSR
%HM_COMPILE% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Nsrplus2nsr.AdminGuide.hmxz "/tsk=Recent Publishes:NSRplus2nsr.AdminGuide" "/tsk=Recent Publishes:NSRplus2nsr.AdminGuide_!DAILY"

REM PIPEOUT2
%HM_COMPILE% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\PipeOut2.AdminGuide.hmxz "/tsk=Recent Publishes:PipeOut2.AdminGuide" "/tsk=Recent Publishes:PipeOut2.AdminGuide_!DAILY"

REM PROCEDURE FOR MAKING PROOFREADING
%HM_COMPILE% "D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Procedure for making proofreading.hmxz" "/tsk=Recent Publishes:ProceduREMakingProofreading" "/tsk=Recent Publishes:ProceduREMakingProofreading_!DAILY"

REM REGIONTOOL
%HM_COMPILE% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\RegionTool.AdminGuide.hmxz /tsk=RegionTool:RegionTool.AdminGuide /tsk=RegionTool:RegionTool.AdminGuide_!DAILY

REM SETTING.SYNCHRONIZATION.GARDOC
%HM_COMPILE% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\GarDoc.Setting.Synchronization.AdminGuide.hmxz /tsk=SYNCDOC:Setting.Synchronization.GarDoc /tsk=SYNCDOC:Setting.Synchronization.GarDoc_!DAILY

REM THE SEQUENCE OF ACTIONS WHEN ENTERING NEW DOCUMENTS
%HM_COMPILE% "D:\MANUAL(CVS)\archi\source\DOCUMENTATION\The sequence of actions when entering new documents.hmxz" "/tsk=Recent Publishes:SequenceActionsEnteringNewDocuments" "/tsk=Recent Publishes:SequenceActionsEnteringNewDocuments_!DAILY"

REM ARHIVARIUS.COMPLEKS
%HM_COMPILE% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Archivarius.Compleks.hmxz /tsk=Common:Archivarius.Compleks /tsk=Common:Archivarius.Compleks_!DAILY

ECHO. >> \\archi2-2008\archi\DAILY_MANUALS\ManualDocBuild.log.txt
ECHO —борка документации завершена %DATE% в %TIME% >> \\archi2-2008\archi\DAILY_MANUALS\ManualDocBuild.log.txt