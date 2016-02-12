program ReleaseDailyTest;
 {* Ежедневные тесты нашей библиотеки компонент (релизный вариант) }

// Модуль: "w:\common\components\DailyTest\ReleaseDailyTest.dpr"
// Стереотип: "TestTarget"

{$Include w:\common\components\DailyTest\DailyTest.inc}

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
