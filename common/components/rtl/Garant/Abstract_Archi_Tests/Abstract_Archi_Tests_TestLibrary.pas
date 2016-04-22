unit Abstract_Archi_Tests_TestLibrary;

// Модуль: "w:\common\components\rtl\Garant\Abstract_Archi_Tests\Abstract_Archi_Tests_TestLibrary.pas"
// Стереотип: "TestLibrary"
// Элемент модели: "Abstract Archi Tests" MUID: (4D53DDBE00EE)

{$Include w:\common\components\rtl\Garant\Abstract_Archi_Tests\TestDefine.inc.pas}

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
 , Abstract_Archi_Tests_Filters_TestUnit
 , Abstract_Archi_Tests_Storage_TestUnit
 , Abstract_Archi_Tests_DataBase_TestUnit
 , DailyTest_TestLibrary
;
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
