unit k2TypedSimpleSortableTagListPrim;

interface

uses
 l3IntfUses
 , k2ListTag
;

 {$Define l3Items_HasCustomSort}
 
type
 Tk2TypedSimpleSortableTagListPrim = class(_k2SimpleTagListPrim_)
 end;//Tk2TypedSimpleSortableTagListPrim
 
implementation

uses
 l3ImplUses
 , k2BaseTypes
 , SysUtils
 , l3Base
 , l3MinMax
 , RTLConsts
;

end.
