unit evSearcherAndReplacerPairList;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , nevTools
;

type
 TevSearcherAndReplacerPair = object
 end;//TevSearcherAndReplacerPair
 
 {$Define l3Items_NoSort}
 
 TevSearcherAndReplacerPairList = class(Tl3ProtoDataContainer)
  {* [RequestLink:280009855] }
  function IsSameItems(const A: _ItemType_;
   const B: _ItemType_): Boolean;
   {* Сравнивает элементы списка }
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//TevSearcherAndReplacerPairList
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
