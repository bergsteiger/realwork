unit SandBoxTest_Memory_TestUnit;

// Модуль: "w:\common\components\SandBox\SandBoxTest_Memory_TestUnit.pas"
// Стереотип: "TestUnit"
// Элемент модели: "Memory" MUID: (51DAE6B102EB)

{$Include w:\common\components\SandBox\sbtDefine.inc}

interface

{$If Defined(nsTest)}
uses
 l3IntfUses
;
{$IfEnd} // Defined(nsTest)

implementation

{$If Defined(nsTest)}
uses
 l3ImplUses
 , MemorySizeTest
;
{$IfEnd} // Defined(nsTest)

end.
