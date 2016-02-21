unit ddAnnoKindStatisticList;

// Модуль: "w:\common\components\rtl\Garant\dd\PipeOut\ddAnnoKindStatisticList.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , ddAnnoKindStatisticListPrim
 , l3Types
;

type
 _FindDataType_ = Integer;
 _l3Searcher_Parent_ = TddAnnoKindStatisticListPrim;
 {$Include w:\common\components\rtl\Garant\L3\l3Searcher.imp.pas}
 TddAnnoKindStatisticList = class(_l3Searcher_)
 end;//TddAnnoKindStatisticList

implementation

uses
 l3ImplUses
 , l3String
 , ddPipeOutInterfaces
;

{$If not Declared(_ItemType_)}type _ItemType_ = IddAnnoKindSortItem;{$IfEnd}

function CompareItemWithData(const anItem: _ItemType_;
 const aData: _FindDataType_;
 aSortIndex: Tl3SortIndex;
 aList: _l3Searcher_): Integer;
 {* Сравнивает существующий элемент с искомым. }
//#UC START# *47B9BAFD01F4_564C6BCB02EF_var*
//#UC END# *47B9BAFD01F4_564C6BCB02EF_var*
begin
//#UC START# *47B9BAFD01F4_564C6BCB02EF_impl*
 Result := anItem.ID - aData;
//#UC END# *47B9BAFD01F4_564C6BCB02EF_impl*
end;//CompareItemWithData

type _Instance_R_ = TddAnnoKindStatisticList;

{$Include w:\common\components\rtl\Garant\L3\l3Searcher.imp.pas}

end.
