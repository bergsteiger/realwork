unit l3DynamicArrayEx;

interface

uses
 l3IntfUses
 , l3DynamicArray
;

type
 Tl3DynamicArrayEx = class(Tl3DynamicArray)
  procedure Create(anItemSize: Integer);
  function ItemSize: Integer;
 end;//Tl3DynamicArrayEx
 
implementation

uses
 l3ImplUses
;

end.
