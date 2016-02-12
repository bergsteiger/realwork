unit tfwDictionaryPtrListIterator;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryPtrListIterator.pas"
// Стереотип: "SimpleClass"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwDictionaryDataIteratorPrim
 , tfwDictionaryPtrList
 , tfwScriptingInterfaces
 , tfwDictionaryEx
;

type
 _ListType_ = TtfwDictionaryPtrList;
 _tfwDictionaryListIteratorPrim_Parent_ = TtfwDictionaryDataIteratorPrim;
 {$Include w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryListIteratorPrim.imp.pas}
 TtfwDictionaryPtrListIterator = {abstract} class(_tfwDictionaryListIteratorPrim_)
  public
   class function Make(aDictionary: TtfwDictionaryEx): ItfwValueList; reintroduce;
 end;//TtfwDictionaryPtrListIterator
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwDictionary
;

{$If not Declared(_ItemType_)}type _ItemType_ = TtfwStackValue;{$IfEnd}

{$Include w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryListIteratorPrim.imp.pas}

class function TtfwDictionaryPtrListIterator.Make(aDictionary: TtfwDictionaryEx): ItfwValueList;
var
 l_Inst : TtfwDictionaryPtrListIterator;
begin
 l_Inst := Create(aDictionary);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TtfwDictionaryPtrListIterator.Make
{$IfEnd} // NOT Defined(NoScripts)

end.
