unit tfwHyperlinkScriptCaller;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwHyperlinkScriptCaller.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TtfwHyperlinkScriptCaller" MUID: (55D345A40226)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwDefaultScriptCaller
;

type
 TtfwHyperlinkScriptCaller = class(TtfwDefaultScriptCaller)
 end;//TtfwHyperlinkScriptCaller
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 //#UC START# *55D345A40226impl_uses*
 //#UC END# *55D345A40226impl_uses*
;
{$IfEnd} // NOT Defined(NoScripts)

end.
