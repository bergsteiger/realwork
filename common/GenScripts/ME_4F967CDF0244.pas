unit kwMouseMiddleUp;

interface

uses
 l3IntfUses
 , kwMouseUpDownSupport
;

type
 TkwMouseMiddleUp = class(TkwMouseUpDownSupport)
  function GetMouseEventFlag: Integer;
 end;//TkwMouseMiddleUp
 
implementation

uses
 l3ImplUses
;

end.
