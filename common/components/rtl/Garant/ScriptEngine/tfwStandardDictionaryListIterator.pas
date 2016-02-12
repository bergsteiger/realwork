unit tfwStandardDictionaryListIterator;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwStandardDictionaryListIterator.pas"
// Стереотип: "SimpleClass"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwStandardDictionaryList
 , tfwIteratableParent
 , tfwScriptingInterfaces
;

type
 _ListType_ = TtfwStandardDictionaryList;
 {$Include w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryListIterator.imp.pas}
 TtfwStandardDictionaryListIterator = class(_tfwDictionaryListIterator_)
 end;//TtfwStandardDictionaryListIterator
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
