unit l3ObjectByHandleSearcher.imp;

interface

uses
 l3IntfUses
 , l3Types
;

type
 _l3ObjectByHandleSearcher_ = class(_l3Searcher_)
  function CompareItemWithData(const anItem: _ItemType_;
   const aData: _FindDataType_;
   aSortIndex: Tl3SortIndex;
   aList: _l3Searcher_): Integer;
   {* Сравнивает существующий элемент с искомым. }
 end;//_l3ObjectByHandleSearcher_
 
implementation

uses
 l3ImplUses
;

end.
