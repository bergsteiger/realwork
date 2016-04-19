unit TestFormsTest_TestLibrary;
 {* Тесты форм }

// Модуль: "w:\common\components\gui\Garant\Daily\TestFormsTest_TestLibrary.pas"
// Стереотип: "TestLibrary"
// Элемент модели: "TestFormsTest" MUID: (4B30C5FF0172)

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
;
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

implementation

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , ScriptTestLibrary_TestLibrary
 {$IfEnd} // NOT Defined(NoScripts)
 , K204114253
 , TextLoad
;
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
