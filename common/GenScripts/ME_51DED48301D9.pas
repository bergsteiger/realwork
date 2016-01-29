unit AtomicList.imp;

interface

uses
 l3IntfUses
;

 {$Define l3Items_IsAtomic}
 
type
 _AtomicList_ = class(_UnrefcountedListPrim_)
  {* Список атомарных значений }
  procedure FreeItem(var thePlace: _ItemType_);
  procedure FillItem(var thePlace: _ItemType_;
   const aFrom: _ItemType_);
 end;//_AtomicList_
 
implementation

uses
 l3ImplUses
 , RTLConsts
 , l3MemorySizeUtils
;

end.
