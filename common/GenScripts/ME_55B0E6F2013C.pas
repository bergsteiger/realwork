unit tfwDictionaryListPrim.imp;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
;

 {$Define l3Items_NoChanging}
 
 {$Undef l3Items_NeedsBeforeFreeItem}
 
type
 _tfwDictionaryListPrim_ = class(Tl3ProtoDataContainer)
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
 end;//_tfwDictionaryListPrim_
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
