unit F1_Shell_Tests_Core_TestLibrary;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\F1_Shell_Tests_Core_TestLibrary.pas"
// Стереотип: "TestLibrary"
// Элемент модели: "F1 Shell Tests Core" MUID: (4E20331F01E4)

{$Include w:\garant6x\implementation\Garant\GbaNemesis\nsDefine.inc}

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
 , F1_Shell_Tests_Core_Core_TestUnit
 , ScriptTestLibrary_TestLibrary
;
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
