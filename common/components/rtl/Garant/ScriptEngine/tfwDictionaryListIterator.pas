unit tfwDictionaryListIterator;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryListIterator.pas"
// ���������: "SimpleClass"
// ������� ������: "TtfwDictionaryListIterator" MUID: (55E9ACD10199)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

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
 {$Include w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryListIterator.imp.pas}
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

{$Include w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryListIterator.imp.pas}
{$IfEnd} // NOT Defined(NoScripts)

end.
