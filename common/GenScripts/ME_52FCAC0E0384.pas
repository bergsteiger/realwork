unit QueryListPrim;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , SavedQuery
;

 {$Define l3Items_IsProto}
 
 {$Define l3Items_HasChanging}
 
type
 TQueryListPrim = class(Tl3ProtoDataContainer)
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//TQueryListPrim
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 , l3Types
 , l3Interfaces
;

end.
