unit SandBoxTest_Core_TestUnit;

// Модуль: "w:\common\components\SandBox\SandBoxTest_Core_TestUnit.pas"
// Стереотип: "TestUnit"
// Элемент модели: "Core" MUID: (5161390500C1)

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
 , RefcountedTest
 , myInterfacedObjectTest
 , myReferenceCountGuardTest
 , ServiceTest
;
{$IfEnd} // Defined(nsTest)

end.
