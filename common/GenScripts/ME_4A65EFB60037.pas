unit k2BaseStruct;

interface

uses
 l3IntfUses
 , k2Prim
 , k2Interfaces
 , l3Variant
;

type
 _PropInPrim_ = object
 end;//_PropInPrim_
 
 _PropIn_ = object(_PropInPrim_)
 end;//_PropIn_
 
 _PropLoc_ = object(_PropInPrim_)
 end;//_PropLoc_
 
 Tk2Values = object
  {* —труктура, содержаща€ информацию дл€ изменени€ значени€ атрибута тега }
 end;//Tk2Values
 
implementation

uses
 l3ImplUses
 , k2Base
 , l3Types
 , l3_String
 , SysUtils
;

end.
