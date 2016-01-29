unit k2Layer;

interface

uses
 l3IntfUses
 , k2List
 , l3Variant
 , Classes
 , k2Base
 , k2BaseStruct
;

type
 Tk2Layer = class(Tk2List)
  {* Список тегов, с идентификатором. }
 end;//Tk2Layer
 
implementation

uses
 l3ImplUses
 , k2Tags
 , SysUtils
;

end.
