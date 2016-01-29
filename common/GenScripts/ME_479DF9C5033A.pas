unit l3ProtoPtrRecListPrim;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , l3Memory
;

 {$Define l3Items_NeedsBeforeFreeItem}
 
 {$Define l3Items_HasChanging}
 
 {$Define l3Items_IsProto}
 
type
 Tl3ProtoPtrRecListPrim = class(Tl3ProtoDataContainer)
 end;//Tl3ProtoPtrRecListPrim
 
implementation

uses
 l3ImplUses
 , SysUtils
 , RTLConsts
 , l3Base
 , l3MinMax
;

end.
