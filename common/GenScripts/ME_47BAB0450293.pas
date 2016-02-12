unit k2ChildrenPathList;

// Модуль: "w:\common\components\rtl\Garant\K2\k2ChildrenPathList.pas"
// Стереотип: "SimpleClass"

{$Include k2Define.inc}

interface

uses
 l3IntfUses
 , k2ChildrenPathListPrim
 , l3Types
;

type
 _FindDataType_ = Integer;
 _l3Searcher_Parent_ = Tk2ChildrenPathListPrim;
 {$Include w:\common\components\rtl\Garant\L3\l3Searcher.imp.pas}
 Tk2ChildrenPathList = class(_l3Searcher_)
 end;//Tk2ChildrenPathList

implementation

uses
 l3ImplUses
 , k2ChildrenPath
;

function CompareItemWithData(const anItem: _ItemType_;
 const aData: _FindDataType_;
 aSortIndex: Tl3SortIndex;
 aList: _l3Searcher_): Integer;
 {* Сравнивает существующий элемент с искомым. }
//#UC START# *47B9BAFD01F4_47BAB0450293_var*
//#UC END# *47B9BAFD01F4_47BAB0450293_var*
begin
//#UC START# *47B9BAFD01F4_47BAB0450293_impl*
 Assert(aSortIndex = l3_siNative);
 Result := anItem.TagType - aData;
//#UC END# *47B9BAFD01F4_47BAB0450293_impl*
end;//CompareItemWithData

type _Instance_R_ = Tk2ChildrenPathList;

{$Include w:\common\components\rtl\Garant\L3\l3Searcher.imp.pas}

end.
