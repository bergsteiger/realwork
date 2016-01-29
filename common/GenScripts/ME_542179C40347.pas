unit m3AutoAllocList.imp;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
;

 {$Define l3Items_IsProto}
 
 {$Define l3Items_NoSort}
 
type
 _m3AutoAllocList_ = class(Tl3ProtoDataContainer)
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//_m3AutoAllocList_
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
