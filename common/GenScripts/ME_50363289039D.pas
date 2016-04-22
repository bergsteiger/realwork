unit DailyTest_XML_TestUnit;

// Модуль: "w:\common\components\rtl\Garant\Daily\DailyTest_XML_TestUnit.pas"
// Стереотип: "TestUnit"
// Элемент модели: "XML" MUID: (50363289039D)

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
 , L3XMLWriterTest
;
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
