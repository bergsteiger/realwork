unit NOT_FINISHED_tfwScriptDebugger;

// ������: "w:\common\components\rtl\Garant\DUnitTuning\NOT_FINISHED_tfwScriptDebugger.pas"
// ���������: "UtilityPack"

{$Include tfwDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NotTunedDUnit) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
;

type
 TtfwScriptDebugger_Form = class
 end;//TtfwScriptDebugger_Form
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NotTunedDUnit) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NotTunedDUnit) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , vcmInsiderTest
 , tfwScriptEngine
;
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NotTunedDUnit) AND NOT Defined(NoScripts)

end.
