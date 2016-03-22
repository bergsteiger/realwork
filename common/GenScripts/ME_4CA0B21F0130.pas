program TFWTest;
 {* Тесты для тестирования собственно тестового фреймворка TFW }

// Модуль: "w:\common\components\TFWTest\TFWTest.dpr"
// Стереотип: "TestTarget"
// Элемент модели: "TFW" MUID: (4CA0B21F0130)

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
