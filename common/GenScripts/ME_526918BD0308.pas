unit k2AtomicTagRefList;

// Модуль: "w:\common\components\rtl\Garant\K2\k2AtomicTagRefList.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

interface

uses
 l3IntfUses
 , k2AtomicTagRefListPrim
 , l3Types
;

type
 _FindDataType_ = Integer;
 _l3Searcher_Parent_ = Tk2AtomicTagRefListPrim;
 {$Include w:\common\components\rtl\Garant\L3\l3Searcher.imp.pas}
 Tk2AtomicTagRefList = class(_l3Searcher_)
 end;//Tk2AtomicTagRefList

implementation

uses
 l3ImplUses
 , k2AtomicTag
 , l3Memory
;

{$If not Declared(_ItemType_)}type _ItemType_ = Tk2AtomicTag;{$IfEnd}

{$If not Declared(_DataType_)}type _DataType_ = Tl3Ptr;{$IfEnd}

function CompareItemWithData(const anItem: _ItemType_;
 const aData: _FindDataType_;
 aSortIndex: Tl3SortIndex;
 aList: _l3Searcher_): Integer;
 {* Сравнивает существующий элемент с искомым. }
//#UC START# *47B9BAFD01F4_526918BD0308_var*
var
 l_I : Integer;
//#UC END# *47B9BAFD01F4_526918BD0308_var*
begin
//#UC START# *47B9BAFD01F4_526918BD0308_impl*
 Assert(aSortIndex = l3_siNative);
 l_I := anItem.AsLong;
 if (l_I < aData) then
  Result := -1
 else
 if (l_I > aData) then
  Result := +1
 else
  Result := 0;
//#UC END# *47B9BAFD01F4_526918BD0308_impl*
end;//CompareItemWithData

type _Instance_R_ = Tk2AtomicTagRefList;

{$Include w:\common\components\rtl\Garant\L3\l3Searcher.imp.pas}

end.
