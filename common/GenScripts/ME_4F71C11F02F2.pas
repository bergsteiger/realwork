unit kwMouseLeftDown;

interface

uses
 l3IntfUses
 , kwMouseUpDownSupport
;

type
 TkwMouseLeftDown = class(TkwMouseUpDownSupport)
  function GetMouseEventFlag: Integer;
 end;//TkwMouseLeftDown
 
implementation

uses
 l3ImplUses
;

end.
