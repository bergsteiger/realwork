unit kwMouseMiddleDown;

interface

uses
 l3IntfUses
 , kwMouseUpDownSupport
;

type
 TkwMouseMiddleDown = class(TkwMouseUpDownSupport)
  function GetMouseEventFlag: Integer;
 end;//TkwMouseMiddleDown
 
implementation

uses
 l3ImplUses
;

end.
