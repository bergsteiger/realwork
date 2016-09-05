unit tfwDictionaryPtrListIterator;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryPtrListIterator.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TtfwDictionaryPtrListIterator" MUID: (55AE649000FB)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

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
 //#UC START# *55AE649000FBimpl_uses*
 //#UC END# *55AE649000FBimpl_uses*
;

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
