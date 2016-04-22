unit ScriptTestLibrary_TestLibrary;

// Модуль: "w:\common\components\rtl\Garant\ScriptTestLibrary\ScriptTestLibrary_TestLibrary.pas"
// Стереотип: "TestLibrary"
// Элемент модели: "ScriptTestLibrary" MUID: (4DC3D1BC0060)

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
 , ScriptTestLibrary_ScriptTestUnit_TestUnit
;
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
