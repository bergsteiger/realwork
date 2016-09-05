unit l3BaseWithIDList;

// Модуль: "w:\common\components\rtl\Garant\L3\l3BaseWithIDList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tl3BaseWithIDList" MUID: (47BD8675002D)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3BaseWithIDListPrim
 , l3Types
;

type
 _FindDataType_ = Integer;
 _l3Searcher_Parent_ = Tl3BaseWithIDListPrim;
 {$Include w:\common\components\rtl\Garant\L3\l3Searcher.imp.pas}
 Tl3BaseWithIDList = class(_l3Searcher_)
 end;//Tl3BaseWithIDList

implementation

uses
 l3ImplUses
 , l3BaseWithID
 , l3Memory
 //#UC START# *47BD8675002Dimpl_uses*
 //#UC END# *47BD8675002Dimpl_uses*
;

{$If not Declared(_ItemType_)}type _ItemType_ = Tl3BaseWithID;{$IfEnd}

{$If not Declared(_DataType_)}type _DataType_ = Tl3Ptr;{$IfEnd}

function CompareItemWithData(const anItem: _ItemType_;
 const aData: _FindDataType_;
 aSortIndex: Tl3SortIndex;
 aList: _l3Searcher_): Integer;
 {* Сравнивает существующий элемент с искомым. }
//#UC START# *47B9BAFD01F4_47BD8675002D_var*
//#UC END# *47B9BAFD01F4_47BD8675002D_var*
begin
//#UC START# *47B9BAFD01F4_47BD8675002D_impl*
 Assert(aSortIndex = l3_siNative);
 Result := anItem.ID - aData;
//#UC END# *47B9BAFD01F4_47BD8675002D_impl*
end;//CompareItemWithData

type _Instance_R_ = Tl3BaseWithIDList;

{$Include w:\common\components\rtl\Garant\L3\l3Searcher.imp.pas}

end.
