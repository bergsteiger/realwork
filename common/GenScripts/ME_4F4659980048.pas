unit tfwDictionaryPrim;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryPrim.pas"
// Стереотип: "SimpleClass"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwDictionaryPrimPrim
 , l3Interfaces
 , l3Variant
 , l3Types
;

type
 _FindDataType_ = Tl3WString;
 _ItemType_ = Tl3PrimString;
 _l3Searcher_Parent_ = TtfwDictionaryPrimPrim;
 {$Include w:\common\components\rtl\Garant\L3\l3Searcher.imp.pas}
 TtfwDictionaryPrim = {abstract} class(_l3Searcher_)
 end;//TtfwDictionaryPrim
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , l3String
;

function CompareItemWithData(const anItem: _ItemType_;
 const aData: _FindDataType_;
 aSortIndex: Tl3SortIndex;
 aList: _l3Searcher_): Integer;
 {* Сравнивает существующий элемент с искомым. }
//#UC START# *47B9BAFD01F4_4F4659980048_var*
//#UC END# *47B9BAFD01F4_4F4659980048_var*
begin
//#UC START# *47B9BAFD01F4_4F4659980048_impl*
 Result := l3Compare(anItem.AsWStr, aData, aSortIndex);
//#UC END# *47B9BAFD01F4_4F4659980048_impl*
end;//CompareItemWithData

type _Instance_R_ = TtfwDictionaryPrim;

{$Include w:\common\components\rtl\Garant\L3\l3Searcher.imp.pas}
{$IfEnd} // NOT Defined(NoScripts)

end.
