unit SandBoxTest_ContainersTests_TestUnit;

// Модуль: "w:\common\components\SandBox\SandBoxTest_ContainersTests_TestUnit.pas"
// Стереотип: "TestUnit"
// Элемент модели: "ContainersTests" MUID: (5155CA0E009F)

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
 , IntStackTest
 , StringStackTest
 , IntStackTestViaMixIn
 , StringStackTestViaMixIn
;
{$IfEnd} // Defined(nsTest)

end.
