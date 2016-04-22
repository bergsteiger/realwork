unit DailyTest_Containers_TestUnit;

// Модуль: "w:\common\components\rtl\Garant\Daily\DailyTest_Containers_TestUnit.pas"
// Стереотип: "TestUnit"
// Элемент модели: "Containers" MUID: (55784AD301C2)

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

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
 , tfwParserTokenListTest
;
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
