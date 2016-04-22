unit SandBoxTest_TestLibrary;

// Модуль: "w:\common\components\SandBox\SandBoxTest_TestLibrary.pas"
// Стереотип: "TestLibrary"
// Элемент модели: "SandBoxTest" MUID: (5155865B01B6)

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
 , SandBoxTest_ContainersTestsPrim_TestUnit
 , SandBoxTest_ContainersTests_TestUnit
 , SandBoxTest_Core_TestUnit
 , SandBoxTest_Emba_TestUnit
 , SandBoxTest_Rounded_TestUnit
 , SandBoxTest_Memory_TestUnit
 , SandBoxTest_FinalContainersTests_TestUnit
 {$If NOT Defined(NoScripts)}
 , ScriptTestLibrary_TestLibrary
 {$IfEnd} // NOT Defined(NoScripts)
;
{$IfEnd} // Defined(nsTest)

end.
