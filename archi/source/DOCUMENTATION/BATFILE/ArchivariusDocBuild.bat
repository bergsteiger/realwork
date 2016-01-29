rem @echo off
rem Начало сборки
echo Сборка документации началась %DATE% в %TIME% > \\archi2-2008\archi\DAILY_MANUALS\ManualDocBuild.txt
echo. >> \\archi2-2008\archi\DAILY_MANUALS\ManualDocBuild.txt

rem Назначаем переменную для указания HELPMAN.EXE
set hm_compile="C:\Program Files (x86)\EC Software\HelpAndManual7\HELPMAN.EXE"

rem ADDIMG
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\AddImg.AdminGuide.hmxz "/tsk=Recent Publishes:AddImg.AdminGuide" "/tsk=Recent Publishes:AddImg.AdminGuide_!DAILY"

rem ADJUSTTOPAGE
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\AdjustToPage.AdminGuide.hmxz "/tsk=Recent Publishes:AdjustToPage.AdminGuide" "/tsk=Recent Publishes:AdjustToPage.AdminGuide_!DAYLY"

rem ADMINISTRATOR
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Administrator.AdminGuide.hmxz "/tsk=Recent Publishes:Administrator.AdminGuide" "/tsk=Recent Publishes:Administrator.AdminGuide_!DAILY"

rem ARCHIVARIUS.APPOSITIONBD
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Archivarius.AppositionBD.hmxz "/tsk=Recent Publishes:Archivarius.AppositionBD.AdminGuide" "/tsk=Recent Publishes:Archivarius.AppositionBD.AdminGuide_!DAILY"

rem ARCHIVARIUS.INTRODUCTIONOPERATION
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Archivarius.IntroductionOperation.hmxz "/tsk=Recent Publishes:Archivarius.IntroductionOperation" "/tsk=Recent Publishes:Archivarius.IntroductionOperation_!DAILY"

rem RELEASENOTES
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Archivarius.ReleaseNotes.hmxz /tsk=CustomBuild:ReleaseNotes.AddImg /tsk=CustomBuild:ReleaseNotes.Adjust2page /tsk=CustomBuild:ReleaseNotes.Dbupdate /tsk=CustomBuild:ReleaseNotes.DBUtil /tsk=CustomBuild:ReleaseNotes.Dictsync /tsk=CustomBuild:ReleaseNotes.Listimport /tsk=CustomBuild:ReleaseNotes.Nsrplus2nsr /tsk=CustomBuild:ReleaseNotes.Pipeout2 /tsk=CustomBuild:ReleaseNotes.Regiontool /tsk=CustomBuild:ReleaseNotes.Admin2 /tsk=CustomBuild:ReleaseNotes.Archivarius /tsk=CustomBuild:ReleaseNotes.BaseVersion /tsk=CustomBuild:ReleaseNotes.Autopipeserver /tsk=CustomBuild:ReleaseNotes.Nsrcspy /tsk=CustomBuild:ReleaseNotes.AddImg_!DAILY /tsk=CustomBuild:ReleaseNotes.Adjust2page_!DAILY /tsk=CustomBuild:ReleaseNotes.Dbupdate_!DAILY /tsk=CustomBuild:ReleaseNotes.DBUtil_!DAILY /tsk=CustomBuild:ReleaseNotes.Dictsync_!DAILY /tsk=CustomBuild:ReleaseNotes.Listimport_!DAILY /tsk=CustomBuild:ReleaseNotes.Nsrplus2nsr_!DAILY /tsk=CustomBuild:ReleaseNotes.Pipeout2_!DAILY /tsk=CustomBuild:ReleaseNotes.Regiontool_!DAILY /tsk=CustomBuild:ReleaseNotes.Admin2_!DAILY /tsk=CustomBuild:ReleaseNotes.Archivarius_!DAILY /tsk=CustomBuild:ReleaseNotes.BaseVersion_!DAILY /tsk=CustomBuild:ReleaseNotes.Autopipeserver_!DAILY /tsk=CustomBuild:ReleaseNotes.Nsrcspy_!DAILY /tsk=CustomBuild:ReleaseNotes.Everest /tsk=CustomBuild:ReleaseNotes.Everest_!DAILY
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Archivarius.ReleaseNotes.hmxz "/tsk=Recent Publishes:Archivarius.ReleaseNotes_!DAILY" "/tsk=Recent Publishes:Archivarius.ReleaseNotes"

rem ARCHIVARIUS.SETTING
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Archivarius.Setting.AdminGuide.hmxz "/tsk=Recent Publishes:Archivarius.Setting.AdminGuide" "/tsk=Recent Publishes:Archivarius.Setting.AdminGuide_!DAILY"

rem ARCHIVARIUS
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Archivarius.UserGuide.hmxz /tsk=FullBuild:Archivarius.UserGuide(f) /tsk=FullBuild:Archivarius.UserGuide(r)_!DAILY /tsk=FullBuild:Archivarius.UserGuide(r)

rem AUTOPIPESERVER
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Autopipeserver.AdminGuide.hmxz /tsk=FullBuild:AutoPipeServer.AdminGuide(f) /tsk=FullBuild:AutoPipeServer.AdminGuide(r) /tsk=FullBuild:AutoPipeServer.AdminGuide(r)_!DAILY

rem ClearClass
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Clearclass.AdminGuide.hmxz /tsk=RegionTool:Clearclass.AdminGuide /tsk=RegionTool:Clearclass.AdminGuide_!DAILY

rem DBUTIL
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\DbUtil.AdminGuide.hmxz /tsk=FullBuild:DbUtil.AdminGuide /tsk=FullBuild:DbUtil.AdminGuide_!DAILY
rem Delprefix
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Delprefix.AdminGuide.hmxz /tsk=DelPrefixBuild:Delprefix.AdminGuide /tsk=DelPrefixBuild:Delprefix.AdminGuide_!DAILY

rem DESCRIPTION OF THE PROCESS OF THE TECHNICAL PROCESSING THE DOCUMENT
%hm_compile% "D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Description of the process of the technical processing the document.hmxz" "/tsk=Recent Publishes:TechDocument" "/tsk=Recent Publishes:TechDocument_!DAILY"

rem DICTSYNC
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Dictsync.AdmingGuide.hmxz "/tsk=Recent Publishes:Dictsync.AdmingGuide" "/tsk=Recent Publishes:DictSync.AdminGuide_!DAILY"

rem FAQ
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\FAQ.hmxz /tsk=FAQ_Task:FAQ.AdminGuide /tsk=FAQ_Task:FAQ.AdminGuide_!DAILY

rem GZPRJ
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\gzPrj.AdminGuide.hmxz "/tsk=Recent Publishes:gzPrj.AdminGuide" "/tsk=Recent Publishes:gzPrj.AdminGuide_!DAILY"

rem HYTECH.CORRECTIONTABLE
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\HyTech.CorrectionTable.AdminGuide.hmxz "/tsk=Recent Publishes:HyTech.CorrectionTable.AdminGuide" "/tsk=Recent Publishes:HyTech.CorrectionTable.AdminGuide_!DAILY"

rem HYTECHAPI.CODELIST
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\HyTechAPI.CodeList.hmxz "/tsk=Recent Publishes:HyTech API.CodeList.AdminGuide" "/tsk=Recent Publishes:HyTech API.CodeList.AdminGuide_!DAILY"

rem KILLTR
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\KILLTR.UserGuide.hmxz "/tsk=Recent Publishes:KILLTR.UserGuide" "/tsk=Recent Publishes:KILLTR.UserGuide_!DAILY"

rem LISTIMPORT
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\ListImport.AdminGuide.hmxz "/tsk=Recent Publishes:ListImport.AdminGuide" "/tsk=Recent Publishes:ListImport.AdminGuide_!DAILY"

rem NSRCSPY
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Nsrcspy.AdminGuide.hmxz /tsk=FullManual:NSRCSpy.AdminGuide(rPDF) /tsk=FullManual:NSRCSpy.AdminGuide(enPDF) /tsk=FullManual:NSRCSpy.AdminGuide(rPDF)_!DAILY /tsk=FullManual:NSRCSpy.AdminGuide(enPDF)_!DAILY

rem NSRPLUS2NSR
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Nsrplus2nsr.AdminGuide.hmxz "/tsk=Recent Publishes:NSRplus2nsr.AdminGuide" "/tsk=Recent Publishes:NSRplus2nsr.AdminGuide_!DAILY"

rem PIPEOUT2
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\PipeOut2.AdminGuide.hmxz "/tsk=Recent Publishes:PipeOut2.AdminGuide" "/tsk=Recent Publishes:PipeOut2.AdminGuide_!DAILY"

rem PROCEDURE FOR MAKING PROOFREADING
%hm_compile% "D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Procedure for making proofreading.hmxz" "/tsk=Recent Publishes:ProcedureMakingProofreading" "/tsk=Recent Publishes:ProcedureMakingProofreading_!DAILY"

rem REGIONTOOL
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\RegionTool.AdminGuide.hmxz /tsk=RegionTool:RegionTool.AdminGuide /tsk=RegionTool:RegionTool.AdminGuide_!DAILY

rem THE SEQUENCE OF ACTIONS WHEN ENTERING NEW DOCUMENTS
%hm_compile% "D:\MANUAL(CVS)\archi\source\DOCUMENTATION\The sequence of actions when entering new documents.hmxz" "/tsk=Recent Publishes:SequenceActionsEnteringNewDocuments" "/tsk=Recent Publishes:SequenceActionsEnteringNewDocuments_!DAILY"

rem ARHIVARIUS.KOMPLEKS
%hm_compile% D:\MANUAL(CVS)\archi\source\DOCUMENTATION\Arhivarius.Kompleks.hmxz /tsk=Common:Arhivarius.Kompleks /tsk=Common:Arhivarius.Kompleks_!DAILY

echo. >> \\archi2-2008\archi\DAILY_MANUALS\ManualDocBuild.txt
echo Сборка документации завершена %DATE% в %TIME% >> \\archi2-2008\archi\DAILY_MANUALS\ManualDocBuild.txt
