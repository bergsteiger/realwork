unit kwMouseRightUp;

interface

uses
 l3IntfUses
 , kwMouseUpDownSupport
;

type
 TkwMouseRightUp = class(TkwMouseUpDownSupport)
  function GetMouseEventFlag: Integer;
 end;//TkwMouseRightUp
 
implementation

uses
 l3ImplUses
;

end.
