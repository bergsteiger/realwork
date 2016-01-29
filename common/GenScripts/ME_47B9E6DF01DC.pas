unit l3ValueMapManagerPrim;

interface

uses
 l3IntfUses
 , l3SimpleDataContainer
 , l3Interfaces
;

 {$Define l3Items_HasCustomSort}
 
type
 Tl3ValueMapManagerPrim = class(_l3InterfaceRefListPrim_)
  function IsSameItems(const A: _ItemType_;
   const B: _ItemType_): Boolean;
   {* Сравнивает элементы списка }
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//Tl3ValueMapManagerPrim
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
