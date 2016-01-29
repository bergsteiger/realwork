unit ddAnnoKindStatisticListPrim;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , ddPipeOutInterfaces
;

 {$Define l3Items_HasCustomSort}
 
type
 TddAnnoKindStatisticListPrim = class(Tl3ProtoDataContainer)
  function IsSameItems(const A: _ItemType_;
   const B: _ItemType_): Boolean;
   {* Сравнивает элементы списка }
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//TddAnnoKindStatisticListPrim
 
implementation

uses
 l3ImplUses
 , l3String
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
