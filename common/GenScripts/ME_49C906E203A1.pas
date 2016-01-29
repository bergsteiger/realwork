unit k2TransparentTag;

interface

uses
 l3IntfUses
 , k2SpecialTag
 , k2Base
 , l3Variant
 , l3Interfaces
;

type
 Tk2TransparentTag = class(Tk2SpecialTag)
  {* Прозрачное значение тега }
  procedure Create(aType: Tk2Type);
 end;//Tk2TransparentTag
 
implementation

uses
 l3ImplUses
 , l3String
 , k2Strings
 , k2Const
 , l3Const
 , k2NullTagImpl
 , k2Tags
;

end.
