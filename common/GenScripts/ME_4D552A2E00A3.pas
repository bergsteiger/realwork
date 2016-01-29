unit vgTypesPrim;

interface

uses
 l3IntfUses
 , vgCustomObject
;

type
 TvgObjectSortCompare = function(item1: TvgCustomObject;
  item2: TvgCustomObject): integer;
 
implementation

uses
 l3ImplUses
;

end.
