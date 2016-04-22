unit DailyTest_Diff_TestUnit;

// Модуль: "w:\common\components\rtl\Garant\Daily\DailyTest_Diff_TestUnit.pas"
// Стереотип: "TestUnit"
// Элемент модели: "Diff" MUID: (564452A801FA)

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
 , DiffTest
;
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
