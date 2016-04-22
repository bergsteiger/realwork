unit DailyTest_SandBoxTests_TestUnit;
 {* Экспериментальные тесты. }

// Модуль: "w:\common\components\rtl\Garant\Daily\DailyTest_SandBoxTests_TestUnit.pas"
// Стереотип: "TestUnit"
// Элемент модели: "SandBoxTests" MUID: (51B1AE3E038C)

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
 , K460262716
;
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
