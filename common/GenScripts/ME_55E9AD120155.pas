unit tfwInitedDictionariesListIterator;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwInitedDictionariesListIterator.pas"
// Стереотип: "SimpleClass"

{$Include seDefine.inc}

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
 {$Include tfwDictionaryListIterator.imp.pas}
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

{$Include tfwDictionaryListIterator.imp.pas}
{$IfEnd} // NOT Defined(NoScripts)

end.
