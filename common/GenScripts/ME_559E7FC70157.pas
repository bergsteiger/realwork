unit tfwDictionaryStack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryStack.pas"
// Стереотип: "SimpleClass"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwDictionaryListPrim
;

type
 TtfwDictionaryStack = class(TtfwDictionaryListPrim)
 end;//TtfwDictionaryStack
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(NoScripts)

end.
