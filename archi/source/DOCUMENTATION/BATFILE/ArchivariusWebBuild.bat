rem @echo off
rem Начало сборки
echo Сборка документации началась %DATE% в %TIME% > \\archi2-2008\archi\DAILY_MANUALS\ManualWeblBuild.txt
echo. >> \\archi2-2008\archi\DAILY_MANUALS\ManualWeblBuild.txt

rem Назначаем переменную для указания HELPMAN.EXE
set hm_compile="C:\Program Files (x86)\EC Software\HelpAndManual6\HELPMAN.EXE"

rem ADDIMG
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\AddImg.AdminGuide.hmxz "/tsk=Recent Publishes:AddImg.AdminGuide(web)_!DAILY"

rem ADJUSTTOPAGE
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\AdjustToPage.AdminGuide.hmxz "/tsk=Recent Publishes:AdjustToPage.AdminGuide(web)_!DAYLY"

rem ADMINISTRATOR
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Administrator.AdminGuide.hmxz "/tsk=Recent Publishes:Administrator.AdminGuide(web)_!DAILY"

rem ARCHIVARIUS.APPOSITIONBD
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Archivarius.AppositionBD.hmxz "/tsk=Recent Publishes:Archivarius.AppositionBD.AdminGuide(web)_!DAILY"

rem ARCHIVARIUS.INTRODUCTIONOPERATION
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Archivarius.IntroductionOperation.hmxz "/tsk=Recent Publishes:Archivarius.IntroductionOperation(web)_!DAILY"

rem RELEASENOTES
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Archivarius.ReleaseNotes.hmxz /tsk=CustomBuild:ReleaseNotes.AddImg(web)_!DAILY /tsk=CustomBuild:ReleaseNotes.Adjust2page(web)_!DAILY /tsk=CustomBuild:ReleaseNotes.Dbupdate(web)_!DAILY /tsk=CustomBuild:ReleaseNotes.Dictsync(web)_!DAILY /tsk=CustomBuild:ReleaseNotes.Listimport(web)_!DAILY /tsk=CustomBuild:ReleaseNotes.Nsrplus2nsr(web)_!DAILY /tsk=CustomBuild:ReleaseNotes.Pipeout2(web)_!DAILY /tsk=CustomBuild:ReleaseNotes.Regiontool(web)_!DAILY /tsk=CustomBuild:ReleaseNotes.Admin2(web)_!DAILY /tsk=CustomBuild:ReleaseNotes.Archivarius(web)_!DAILY /tsk=CustomBuild:ReleaseNotes.BaseVersion(web)_!DAILY /tsk=CustomBuild:ReleaseNotes.Autopipeserver(web)_!DAILY /tsk=CustomBuild:ReleaseNotes.Nsrcspy(web)_!DAILY /tsk=CustomBuild:ReleaseNotes.Everest(web)_!DAILY /tsk=CustomBuild:ReleaseNotes.DBUtil(web)_!DAILY
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Archivarius.ReleaseNotes.hmxz "/tsk=Recent Publishes:Archivarius.ReleaseNotes(web)_!DAILY"

rem ARCHIVARIUS.SETTING
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Archivarius.Setting.AdminGuide.hmxz "/tsk=Recent Publishes:Archivarius.Setting.AdminGuide(web)_!DAILY"

rem ARCHIVARIUS
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Archivarius.UserGuide.hmxz /tsk=FullBuild:Archivarius.UserGuide(web)_!DAILY

rem AUTOPIPESERVER
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Autopipeserver.AdminGuide.hmxz /tsk=FullBuild:AutoPipeServer.AdminGuide(web)_!DAILY

rem ClearClass
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Clearclass.AdminGuide.hmxz /tsk=RegionTool:Clearclass.AdminGuide(web)_!DAILY

rem DBUTIL
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\DbUtil.AdminGuide.hmxz /tsk=FullBuild:DbUtil.AdminGuide(web)_!DAILY

rem Delprefix
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Delprefix.AdminGuide.hmxz /tsk=DelPrefixBuild:Delprefix.AdminGuide(web)_!DAILY

rem DESCRIPTION OF THE PROCESS OF THE TECHNICAL PROCESSING THE DOCUMENT
%hm_compile% "D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Description of the process of the technical processing the document.hmxz" "/tsk=Recent Publishes:TechDocument(web)_!DAILY"

rem DICTSYNC
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Dictsync.AdmingGuide.hmxz "/tsk=Recent Publishes:DictSync.AdminGuide(web)_!DAILY"

rem FAQ
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\FAQ.hmxz /tsk=FAQ_Task:FAQ.AdminGuide(web)_!DAILY

rem GZPRJ
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\gzPrj.AdminGuide.hmxz "/tsk=Recent Publishes:gzPrj.AdminGuide(web)_!DAILY"

rem HYTECH.CORRECTIONTABLE
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\HyTech.CorrectionTable.AdminGuide.hmxz "/tsk=Recent Publishes:HyTech.CorrectionTable.AdminGuide(web)_!DAILY"

rem HYTECHAPI.CODELIST
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\HyTechAPI.CodeList.hmxz "/tsk=Recent Publishes:HyTech API.CodeList.AdminGuide(web)_!DAILY"

rem KILLTR
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\KILLTR.UserGuide.hmxz "/tsk=Recent Publishes:KILLTR.UserGuide(web)_!DAILY"

rem LISTIMPORT
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\ListImport.AdminGuide.hmxz "/tsk=Recent Publishes:ListImport.AdminGuide(web)_!DAILY"

rem NSRCSPY
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Nsrcspy.AdminGuide.hmxz /tsk=FullManual:NSRCSpy.AdminGuide(web)_!DAILY

rem NSRPLUS2NSR
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Nsrplus2nsr.AdminGuide.hmxz "/tsk=Recent Publishes:NSRplus2nsr.AdminGuide(web)_!DAILY"

rem PIPEOUT2
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\PipeOut2.AdminGuide.hmxz "/tsk=Recent Publishes:PipeOut2.AdminGuide(web)_!DAILY"

rem PROCEDURE FOR MAKING PROOFREADING
%hm_compile% "D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Procedure for making proofreading.hmxz" "/tsk=Recent Publishes:ProcedureMakingProofreading(web)_!DAILY"

rem REGIONTOOL
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\RegionTool.AdminGuide.hmxz /tsk=RegionTool:RegionTool.AdminGuide(web)_!DAILY

rem THE SEQUENCE OF ACTIONS WHEN ENTERING NEW DOCUMENTS
%hm_compile% "D:\MANUAL(CVS)\archi\source\DOCUMENTATION\The sequence of actions when entering new documents.hmxz" "/tsk=Recent Publishes:SequenceActionsEnteringNewDocuments(web)_!DAILY"

rem ARHIVARIUS.KOMPLEKS
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Arhivarius.Kompleks.hmxz /tsk=Common:Arhivarius.Kompleks(web)_!DAILY

echo. >> \\archi2-2008\archi\DAILY_MANUALS\ManualWeblBuild.txt
echo Сборка документации завершена %DATE% в %TIME% >> \\archi2-2008\archi\DAILY_MANUALS\ManualWeblBuild.txt
