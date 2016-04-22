unit Low_Level_Tests_TasksSaveLoadWithDefault_TestUnit;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoadWithDefault\Low_Level_Tests_TasksSaveLoadWithDefault_TestUnit.pas"
// Стереотип: "TestUnit"
// Элемент модели: "TasksSaveLoadWithDefault" MUID: (53185EDF0306)

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
;
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

end.
