unit ncsOneFileDelivererList;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , ncsOneFileDeliverer
;

type
 TncsOneFileDelivererList = class(Tl3ProtoDataContainer)
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//TncsOneFileDelivererList
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
