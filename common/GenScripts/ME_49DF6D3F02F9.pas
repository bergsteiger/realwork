unit evSolidParaCursor;

interface

uses
 l3IntfUses
 , evLeafParaCursor
 , nevBase
 , nevTools
;

type
 TevSolidParaCursor = class(TevLeafParaCursor)
  function GetY: Integer;
  procedure SetY(aValue: Integer);
 end;//TevSolidParaCursor
 
implementation

uses
 l3ImplUses
 , nevFacade
 , evCursorConst
 , l3MinMax
;

end.
