unit ScriptTestLibrary_TestLibrary;

// ������: "w:\common\components\rtl\Garant\ScriptTestLibrary\ScriptTestLibrary_TestLibrary.pas"
// ���������: "TestLibrary"
// ������� ������: "ScriptTestLibrary" MUID: (4DC3D1BC0060)

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
