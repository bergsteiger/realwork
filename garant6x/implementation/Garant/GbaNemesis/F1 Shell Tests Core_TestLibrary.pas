unit F1 Shell Tests Core_TestLibrary;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\F1 Shell Tests Core_TestLibrary.pas"
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
 , ScriptTestLibrary_TestLibrary
 , InsiderOwnScripter
 , F1AutoScripter
 , tc5OpenApp
 , tc6OpenApp
;
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
