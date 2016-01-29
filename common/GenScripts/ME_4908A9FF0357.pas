unit l3ItemsStorage;

interface

uses
 l3IntfUses
 , l3ProtoPersistentDataContainer
 , l3Types
;

type
 Tl3ItemsStorage = class(_l3LockedChange_)
  function DoCompareItems(const A: _ItemType_;
   const B: _ItemType_;
   aSortIndex: Tl3SortIndex;
   aList: _l3Sortable_): Integer;
  procedure Swap(var I1: _ItemType_;
   var I2: _ItemType_);
   {* Меняет элементы хранилища местами. Не проверяет валидность индексов. }
 end;//Tl3ItemsStorage
 
implementation

uses
 l3ImplUses
 , l3Interfaces
 , l3Base
 , SysUtils
;

end.
