unit Low_Level_Tests_TaskSaveLoad_TestUnit;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoad\Low_Level_Tests_TaskSaveLoad_TestUnit.pas"
// Стереотип: "TestUnit"
// Элемент модели: "TaskSaveLoad" MUID: (531FF6280311)

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
;
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

end.
