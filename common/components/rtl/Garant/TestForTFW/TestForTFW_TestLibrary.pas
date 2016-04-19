unit TestForTFW_TestLibrary;
 {* Тесты для тестирования собственно тестового фреймворка TFW }

// Модуль: "w:\common\components\rtl\Garant\TestForTFW\TestForTFW_TestLibrary.pas"
// Стереотип: "TestLibrary"
// Элемент модели: "TestForTFW" MUID: (4CA0B1CA00A3)

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
 , SuccessTest
 , FailedTest
 , K235868845
;
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
