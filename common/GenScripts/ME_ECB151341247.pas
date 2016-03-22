program ReleaseTFWTest;
 {* Тесты для тестирования собственно тестового фреймворка TFW (релизный вариант) }

// Модуль: "w:\common\components\TFWTest\ReleaseTFWTest.dpr"
// Стереотип: "TestTarget"
// Элемент модели: "ReleaseTFW" MUID: (ECB151341247)

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
