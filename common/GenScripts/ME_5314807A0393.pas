unit l3FontManagerPrim;

interface

uses
 l3IntfUses
 , l3FontManagerPrimPrim
 , l3LogFont
 , l3Interfaces
;

type
 Tl3FontManagerPrim = class(Tl3FontManagerPrimPrim)
  function ItemToWStr(const anItem: _ItemType_): Tl3WString;
 end;//Tl3FontManagerPrim
 
implementation

uses
 l3ImplUses
 , l3String
;

end.
