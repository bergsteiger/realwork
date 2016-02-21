unit tfwHyperlinkScriptCaller;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwHyperlinkScriptCaller.pas"
// Стереотип: "SimpleClass"

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
;
{$IfEnd} // NOT Defined(NoScripts)

end.
