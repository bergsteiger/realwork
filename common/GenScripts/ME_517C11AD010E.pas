unit SandBoxTest_Rounded_TestUnit;

// Модуль: "w:\common\components\SandBox\SandBoxTest_Rounded_TestUnit.pas"
// Стереотип: "TestUnit"
// Элемент модели: "Rounded" MUID: (517C11AD010E)

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
 , RoundedControlsTest
;
{$IfEnd} // Defined(nsTest)

end.
