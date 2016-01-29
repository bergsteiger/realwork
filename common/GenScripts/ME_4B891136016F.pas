unit l3DelphiStringSearcherPrim.imp;

interface

uses
 l3IntfUses
 , l3Interfaces
 , l3Types
;

type
 _l3DelphiStringSearcherPrim_ = class(_l3Searcher_)
  function ItemToWStr(const anItem: _ItemType_): Tl3WString;
  function CompareItemWithData(const anItem: _ItemType_;
   const aData: _FindDataType_;
   aSortIndex: Tl3SortIndex;
   aList: _l3Searcher_): Integer;
   {* Сравнивает существующий элемент с искомым. }
 end;//_l3DelphiStringSearcherPrim_
 
implementation

uses
 l3ImplUses
 , l3String
;

end.
