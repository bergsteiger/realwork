unit vcmMessageQueuePrim;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , vcmGUI
 , l3Interfaces
;

type
 TvcmMessageQueueItem = record
 end;//TvcmMessageQueueItem
 
 {$Define l3Items_NoSort}
 
 TvcmMessageQueuePrim = class(Tl3ProtoDataContainer)
  function IsSameItems(const A: _ItemType_;
   const B: _ItemType_): Boolean;
   {* Сравнивает элементы списка }
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//TvcmMessageQueuePrim
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
