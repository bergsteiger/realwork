unit l3StringPtr;

interface

uses
 l3IntfUses
 , l3Variant
 , l3Interfaces
 , l3Types
;

type
 Tl3StringPtr = class(Tl3PrimString)
  {* Строка, не владеющая своими данными }
  procedure Create(const aStr: Tl3WString);
 end;//Tl3StringPtr
 
implementation

uses
 l3ImplUses
 , l3String
;

end.
