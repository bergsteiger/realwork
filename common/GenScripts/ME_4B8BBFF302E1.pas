unit l3StringMapPrim;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
;

 {$Define l3Items_NeedsBeforeFreeItem}
 
 {$Undef l3Items_NoSort}
 
type
 Tl3StringMapPrim = class(Tl3ProtoDataContainer)
 end;//Tl3StringMapPrim
 
implementation

uses
 l3ImplUses
 , l3String
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
