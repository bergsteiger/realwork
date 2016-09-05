unit NOT_FINISHED_tfwScriptDebugger;

// Модуль: "w:\common\components\rtl\Garant\DUnitTuning\NOT_FINISHED_tfwScriptDebugger.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "tfwScriptDebugger" MUID: (4DB1629901E8)

{$Include w:\common\components\rtl\Garant\DUnitTuning\tfwDefine.inc}

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
 //#UC START# *4DB1629901E8impl_uses*
 //#UC END# *4DB1629901E8impl_uses*
;
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NotTunedDUnit) AND NOT Defined(NoScripts)

end.
