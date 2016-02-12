unit evDefaultStylesFontSizesPrim1;

// Модуль: "w:\common\components\gui\Garant\Everest\evDefaultStylesFontSizesPrim1.pas"
// Стереотип: "SimpleClass"

{$Include evDefine.inc}

interface

uses
 l3IntfUses
 , evDefaultStylesFontSizesPrim
 , l3Types
;

type
 _FindDataType_ = Integer;
 _l3Searcher_Parent_ = TevDefaultStylesFontSizesPrim;
 {$Include w:\common\components\rtl\Garant\L3\l3Searcher.imp.pas}
 TevDefaultStylesFontSizesPrim1 = class(_l3Searcher_)
 end;//TevDefaultStylesFontSizesPrim1

implementation

uses
 l3ImplUses
 , l3Memory
;

{$If not Declared(_ItemType_)}type _ItemType_ = TevDefaultStyleFontSize;{$IfEnd}

{$If not Declared(_DataType_)}type _DataType_ = Tl3Ptr;{$IfEnd}

function CompareItemWithData(const anItem: _ItemType_;
 const aData: _FindDataType_;
 aSortIndex: Tl3SortIndex;
 aList: _l3Searcher_): Integer;
 {* Сравнивает существующий элемент с искомым. }
//#UC START# *47B9BAFD01F4_4E317AC802F4_var*
//#UC END# *47B9BAFD01F4_4E317AC802F4_var*
begin
//#UC START# *47B9BAFD01F4_4E317AC802F4_impl*
 Result := anItem.rStyleID - aData;
//#UC END# *47B9BAFD01F4_4E317AC802F4_impl*
end;//CompareItemWithData

type _Instance_R_ = TevDefaultStylesFontSizesPrim1;

{$Include w:\common\components\rtl\Garant\L3\l3Searcher.imp.pas}

end.
