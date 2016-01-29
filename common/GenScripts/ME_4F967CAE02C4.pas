unit kwMouseRightDown;

interface

uses
 l3IntfUses
 , kwMouseUpDownSupport
;

type
 TkwMouseRightDown = class(TkwMouseUpDownSupport)
  function GetMouseEventFlag: Integer;
 end;//TkwMouseRightDown
 
implementation

uses
 l3ImplUses
;

end.
