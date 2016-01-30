unit tfwDictionaryListIterator;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryListIterator.pas"
// Стереотип: "SimpleClass"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwDictionaryList
 , tfwIteratableParent
 , tfwScriptingInterfaces
;

type
 _ListType_ = TtfwDictionaryList;
 {$Include tfwDictionaryListIterator.imp.pas}
 TtfwDictionaryListIterator = class(_tfwDictionaryListIterator_)
 end;//TtfwDictionaryListIterator
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
 , tfwDictionary
;

{$Include tfwDictionaryListIterator.imp.pas}
{$IfEnd} // NOT Defined(NoScripts)

end.
