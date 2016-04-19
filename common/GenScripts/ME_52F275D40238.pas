unit Low_Level_Tests_TestLibrary;
 {* Нескриптованные тесты сервера автоматизации }

// Модуль: "w:\archi\source\projects\PipeInAuto\Tests\Low_Level_Tests_TestLibrary.pas"
// Стереотип: "TestLibrary"
// Элемент модели: "Low Level Tests" MUID: (52F275D40238)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(AppServerSide) AND Defined(InsiderTest)}
uses
 l3IntfUses
;
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

implementation

{$If Defined(AppServerSide) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , K515862135
 , K578892941
 , K517772970_TddTaskItem
 , K517772970_TddProcessTask
 , K517772970_TddRequestTask
 , K517772970_TddClientMessage
 , K517772970_TddCommonDataRequest
 , K517772970_TddBaseStatusRequest
 , K517772970_TddServerStatusRequest
 , K517772970_TaskRequest
 , K517772970_TddTaskResultRequest
 , K517772970_TddGetTaskRequest
 , K517772970_TcsExportResultRequest
 , K517772970_TcsLineRequest
 , K517772970_TalcuAutoClassTask
 , K517772970_TcsExport
 , K517772970_TcsImportTaskItem
 , K517772970_TalcuRegionAutoExportTask
 , K517772970_TalcuAutoSpellTask
 , K517772970_TddRunCommandTask
 , K517772970_TalcuAnnotationTask
 , K517772970_TUserEditQuery
 , K517772970_TalcuAutoExportTask
 , K517772970_TDeleteDocsQuery
 , K517772970_TDictEditQuery
 , K517772970_TcsAutoAnnoExport
 , K517772970_TddCaseCodeTask
 , K517772970_TalcuExport
 , K517772970_TalcuAnoncedExport
 , K517772970_TalcuHavanskyExportTask
 , K517772970_TGetDictEditQuery
 , K517772970_TalcuImport
 , K517772970_TalcuRelPublishTask
 , K517772970_TcsAACImport
 , K517772970_TcsSpellCorrectTask
 , K517772970_TcsUserDefinedExport
 , K517789752
 , K517772970_TddTaskItemDefault
 , K517772970_TalcuAnnotationTaskDefault
 , K517772970_TalcuAnoncedExportDefault
 , K517772970_TalcuAutoClassTaskDefault
 , K517772970_TalcuExportDefault
 , K517772970_TalcuHavanskyExportTaskDefault
 , K517772970_TalcuImportDefault
 , K517772970_TalcuRelPublishTaskDefault
 , K517772970_TaskRequestDefault
 , K517772970_TcsAACImportDefault
 , K517772970_TcsAutoAnnoExportDefault
 , K517772970_TalcuAutoSpellTaskDefault
 , K517772970_TcsExportDefault
 , K517772970_TcsExportResultRequestDefault
 , K517772970_TcsImportTaskItemDefault
 , K517772970_TcsLineRequestDefault
 , K517772970_TalcuAutoExportTaskDefault
 , K517772970_TddBaseStatusRequestDefault
 , K517772970_TddCaseCodeTaskDefault
 , K517772970_TddClientMessageDefault
 , K517772970_TddCommonDataRequestDefault
 , K517772970_TddGetTaskRequestDefault
 , K517772970_TddProcessTaskDefault
 , K517772970_TalcuRegionAutoExportTaskDefault
 , K517772970_TddRequestTaskDefault
 , K517772970_TddRunCommandTaskDefault
 , K517772970_TddServerStatusRequestDefault
 , K517772970_TddTaskResultRequestDefault
 , K517772970_TDeleteDocsQueryDefault
 , K517772970_TDictEditQueryDefault
 , K517772970_TGetDictEditQueryDefault
 , K517772970_TUserEditQueryDefault
 , K517772970_TcsSpellCorrectTaskDefault
 , K517772970_TcsUserDefinedExportDefault
 , RegisteredRepliesTest
;
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

end.
