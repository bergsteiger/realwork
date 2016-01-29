unit UnrefcountedListPrim.imp;

interface

uses
 l3IntfUses
;

 {$Define l3Items_IsUnrefcounted}
 
type
 _UnrefcountedListPrim_ = class(_List_)
  {* Список значений без какого то бы ни было подсчёта ссылок }
  function IsSame(const A: _ItemType_;
   const B: _ItemType_): Boolean;
 end;//_UnrefcountedListPrim_
 
implementation

uses
 l3ImplUses
 , RTLConsts
 , l3MemorySizeUtils
;

end.
