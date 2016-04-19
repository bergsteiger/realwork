unit Abstract_Tests_TestLibrary;
 {* Абстрактные тесты }

// Модуль: "w:\common\components\rtl\Garant\Abstract_Tests\Abstract_Tests_TestLibrary.pas"
// Стереотип: "TestLibrary"
// Элемент модели: "Abstract Tests" MUID: (4D02561D01C8)

{$Include w:\common\components\rtl\Garant\Abstract_Tests\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
;
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , TestFormsTest_TestLibrary
 {$IfEnd} // NOT Defined(NoVCM)
 , ScriptTestLibrary_TestLibrary
;
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
