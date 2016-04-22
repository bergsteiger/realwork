unit Low_Level_Tests_TasksProcessing_TestUnit;
 {* Обработка очереди заданий }

// Модуль: "w:\archi\source\projects\PipeInAuto\Tests\Tasks\Processing\Low_Level_Tests_TasksProcessing_TestUnit.pas"
// Стереотип: "TestUnit"
// Элемент модели: "TasksProcessing" MUID: (52F27605004A)

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
;
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

end.
