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
 , Low_Level_Tests_TasksProcessing_TestUnit
 , Low_Level_Tests_TaskSaveLoad_TestUnit
 , Low_Level_Tests_AbstractImportTasks_TestUnit
 , Low_Level_Tests_AbstractTasksSaveLoadWithDefault_TestUnit
 , Low_Level_Tests_ConcreteImportTasks_TestUnit
 , Low_Level_Tests_TasksSaveLoadWithDefault_TestUnit
 , Low_Level_Tests_TasksRegistering_TestUnit
;
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

end.
