unit l3BaseWithLargeIDList;

// Модуль: "w:\common\components\rtl\Garant\L3\l3BaseWithLargeIDList.pas"
// Стереотип: "SimpleClass"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
 , l3BaseWithLargeIDListPrim
 , l3Types
;

type
 _FindDataType_ = Integer;
 _l3Searcher_Parent_ = Tl3BaseWithLargeIDListPrim;
 {$Include l3Searcher.imp.pas}
 Tl3BaseWithLargeIDList = class(_l3Searcher_)
 end;//Tl3BaseWithLargeIDList

implementation

uses
 l3ImplUses
;

function CompareItemWithData(const anItem: _ItemType_;
 const aData: _FindDataType_;
 aSortIndex: Tl3SortIndex;
 aList: _l3Searcher_): Integer;
 {* Сравнивает существующий элемент с искомым. }
//#UC START# *47B9BAFD01F4_47BDA81C0188_var*
//#UC END# *47B9BAFD01F4_47BDA81C0188_var*
begin
//#UC START# *47B9BAFD01F4_47BDA81C0188_impl*
 Assert(aSortIndex = l3_siNative);
 if (anItem.ID > aData) then
  Result := +1
 else
 if (anItem.ID < aData) then
  Result := -1
 else
  Result := 0;
//#UC END# *47B9BAFD01F4_47BDA81C0188_impl*
end;//CompareItemWithData

type _Instance_R_ = Tl3BaseWithLargeIDList;

{$Include l3Searcher.imp.pas}

end.
