unit tfwStandardDictionaryList;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwStandardDictionaryList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TtfwStandardDictionaryList" MUID: (55B0EFA300D1)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwStandardDictionaryListPrim
 , l3Interfaces
 , l3Types
;

type
 _FindDataType_ = Tl3WString;
 _l3Searcher_Parent_ = TtfwStandardDictionaryListPrim;
 {$Include w:\common\components\rtl\Garant\L3\l3Searcher.imp.pas}
 TtfwStandardDictionaryList = class(_l3Searcher_)
 end;//TtfwStandardDictionaryList
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , l3String
 , tfwStandardDictionary
 //#UC START# *55B0EFA300D1impl_uses*
 //#UC END# *55B0EFA300D1impl_uses*
;

{$If not Declared(_ItemType_)}type _ItemType_ = TtfwStandardDictionary;{$IfEnd}

function CompareItemWithData(const anItem: _ItemType_;
 const aData: _FindDataType_;
 aSortIndex: Tl3SortIndex;
 aList: _l3Searcher_): Integer;
 {* Сравнивает существующий элемент с искомым. }
//#UC START# *47B9BAFD01F4_55B0EFA300D1_var*
//#UC END# *47B9BAFD01F4_55B0EFA300D1_var*
begin
//#UC START# *47B9BAFD01F4_55B0EFA300D1_impl*
 Result := l3Compare(l3PCharLen(anItem.FileName), aData, l3_siCaseUnsensitive);
//#UC END# *47B9BAFD01F4_55B0EFA300D1_impl*
end;//CompareItemWithData

type _Instance_R_ = TtfwStandardDictionaryList;

{$Include w:\common\components\rtl\Garant\L3\l3Searcher.imp.pas}
{$IfEnd} // NOT Defined(NoScripts)

end.
