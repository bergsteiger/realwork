unit tfwInitedDictionariesListIterator;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwInitedDictionariesListIterator.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwInitedDictionariesList
 , tfwIteratableParent
 , tfwScriptingInterfaces
;

type
 _ListType_ = TtfwInitedDictionariesList;
 {$Include w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryListIterator.imp.pas}
 TtfwInitedDictionariesListIterator = class(_tfwDictionaryListIterator_)
 end;//TtfwInitedDictionariesListIterator
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
 , tfwDictionary
;

{$Include w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryListIterator.imp.pas}
{$IfEnd} // NOT Defined(NoScripts)

end.
