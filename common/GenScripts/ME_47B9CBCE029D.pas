unit l3StringList2;

// Модуль: "w:\common\components\rtl\Garant\L3\l3StringList2.pas"
// Стереотип: "SimpleClass"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
 , l3StringList1
 , l3Interfaces
 , l3Types
;

type
 _FindDataType_ = Tl3WString;
 _l3Searcher_Parent_ = Tl3StringList1;
 {$Include l3Searcher.imp.pas}
 Tl3StringList2 = class(_l3Searcher_)
 end;//Tl3StringList2

implementation

uses
 l3ImplUses
 , l3String
;

function CompareItemWithData(const anItem: _ItemType_;
 const aData: _FindDataType_;
 aSortIndex: Tl3SortIndex;
 aList: _l3Searcher_): Integer; override;
 {* Сравнивает существующий элемент с искомым. }
//#UC START# *47B9BAFD01F4_47B9CBCE029D_var*
//#UC END# *47B9BAFD01F4_47B9CBCE029D_var*
begin
//#UC START# *47B9BAFD01F4_47B9CBCE029D_impl*
 Result := l3Compare(anItem.AsWStr, aData, aSortIndex);
//#UC END# *47B9BAFD01F4_47B9CBCE029D_impl*
end;//CompareItemWithData

type _Instance_R_ = Tl3StringList2;

{$Include l3Searcher.imp.pas}

end.
