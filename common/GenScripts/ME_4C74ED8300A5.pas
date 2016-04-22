unit DailyTest_GZip_TestUnit;

// Модуль: "w:\common\components\rtl\Garant\Daily\DailyTest_GZip_TestUnit.pas"
// Стереотип: "TestUnit"
// Элемент модели: "GZip" MUID: (4C74ED8300A5)

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
 , GZipUnzipTest
;
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
