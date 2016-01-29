unit l3RecList;

interface

uses
 l3IntfUses
 , l3BaseRecList
;

type
 Tl3RecList = class(Tl3BaseRecList)
  procedure Create(anItemSize: Integer);
  function ItemSize: Integer;
 end;//Tl3RecList
 
implementation

uses
 l3ImplUses
;

end.
