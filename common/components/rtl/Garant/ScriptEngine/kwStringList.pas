unit kwStringList;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwStringList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TkwStringList" MUID: (4F3E476202B8)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwStringListPrim
 , l3Interfaces
 , l3Types
;

type
 _FindDataType_ = Il3CString;
 _l3Searcher_Parent_ = TkwStringListPrim;
 {$Include w:\common\components\rtl\Garant\L3\l3Searcher.imp.pas}
 TkwStringList = class(_l3Searcher_)
 end;//TkwStringList
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , l3String
 , kwString
 , l3Memory
 //#UC START# *4F3E476202B8impl_uses*
 //#UC END# *4F3E476202B8impl_uses*
;

function CompareItemWithData(const anItem: _ItemType_;
 const aData: _FindDataType_;
 aSortIndex: Tl3SortIndex;
 aList: _l3Searcher_): Integer;
 {* Сравнивает существующий элемент с искомым. }
//#UC START# *47B9BAFD01F4_4F3E476202B8_var*
//#UC END# *47B9BAFD01F4_4F3E476202B8_var*
begin
//#UC START# *47B9BAFD01F4_4F3E476202B8_impl*
 Assert(aSortIndex = l3_siNative);
 Result := l3Compare(l3PCharLen(anItem.Value), l3PCharLen(aData));
//#UC END# *47B9BAFD01F4_4F3E476202B8_impl*
end;//CompareItemWithData

type _Instance_R_ = TkwStringList;

{$Include w:\common\components\rtl\Garant\L3\l3Searcher.imp.pas}
{$IfEnd} // NOT Defined(NoScripts)

end.
