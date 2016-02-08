unit k2DictionaryIDIndex;

// Модуль: "w:\common\components\rtl\Garant\K2\k2DictionaryIDIndex.pas"
// Стереотип: "SimpleClass"

{$Include k2Define.inc}

interface

uses
 l3IntfUses
 , k2DictionaryIDIndexPrim
 , l3Types
;

type
 _FindDataType_ = Integer;
 _l3Searcher_Parent_ = Tk2DictionaryIDIndexPrim;
 {$Include l3Searcher.imp.pas}
 Tk2DictionaryIDIndex = class(_l3Searcher_)
 end;//Tk2DictionaryIDIndex

implementation

uses
 l3ImplUses
 , k2Tags
;

function CompareItemWithData(const anItem: _ItemType_;
 const aData: _FindDataType_;
 aSortIndex: Tl3SortIndex;
 aList: _l3Searcher_): Integer;
 {* Сравнивает существующий элемент с искомым. }
//#UC START# *47B9BAFD01F4_5304CAB003D1_var*
//#UC END# *47B9BAFD01F4_5304CAB003D1_var*
begin
//#UC START# *47B9BAFD01F4_5304CAB003D1_impl*
 Result := anItem.IntA[k2_tiHandle] - aData;
//#UC END# *47B9BAFD01F4_5304CAB003D1_impl*
end;//CompareItemWithData

type _Instance_R_ = Tk2DictionaryIDIndex;

{$Include l3Searcher.imp.pas}

end.
