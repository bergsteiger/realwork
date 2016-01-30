program DailyTest;
 {* Ежедневные тесты нашей библиотеки компонент }

// Модуль: "w:\common\components\DailyTest\DailyTest.dpr"
// Стереотип: "TestTarget"

{$Include DailyTest.inc}

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
;
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
