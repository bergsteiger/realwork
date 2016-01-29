unit k2TagByIntegerSearcher.imp;

interface

uses
 l3IntfUses
 , l3Types
;

type
 _k2TagByIntegerSearcher_ = class(_l3Searcher_)
  function CompareItemWithData(const anItem: _ItemType_;
   const aData: _FindDataType_;
   aSortIndex: Tl3SortIndex;
   aList: _l3Searcher_): Integer;
   {* Сравнивает существующий элемент с искомым. }
 end;//_k2TagByIntegerSearcher_
 
implementation

uses
 l3ImplUses
;

end.
