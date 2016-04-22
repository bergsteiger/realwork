unit Low_Level_Tests_TasksRegistering_TestUnit;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tests\Low_Level_Tests_TasksRegistering_TestUnit.pas"
// Стереотип: "TestUnit"
// Элемент модели: "TasksRegistering" MUID: (53BA8F9B01F5)

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
 , RegisteredRepliesTest
;
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

end.
