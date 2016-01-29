unit l3DictionaryPrim;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
;

 {$Define l3Items_NeedsBeforeFreeItem}
 
 {$Undef l3Items_NoSort}
 
 {$Define l3Items_CaseUnsensitive}
 
 {$Define l3Items_NeedsAssignItem}
 
type
 Tl3DictionaryPrim = class(Tl3ProtoDataContainer)
 end;//Tl3DictionaryPrim
 
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
