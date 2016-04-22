unit Archi_Tests_TestLibrary;

// Модуль: "w:\common\components\rtl\Garant\Archi_Tests\Archi_Tests_TestLibrary.pas"
// Стереотип: "TestLibrary"
// Элемент модели: "Archi Tests" MUID: (4D53DEED0062)

{$Include w:\common\components\rtl\Garant\Archi_Tests\TestDefine.inc.pas}

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
 , Archi_Tests_Tags_TestUnit
 , Archi_Tests_Filters_TestUnit
 , Archi_Tests_DBTests_TestUnit
 , Archi_Tests_Storage_TestUnit
 {$If NOT Defined(NoVCM)}
 , TestFormsTest_TestLibrary
 {$IfEnd} // NOT Defined(NoVCM)
 , Abstract_Tests_TestLibrary
 , Abstract_Archi_Tests_TestLibrary
;
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
