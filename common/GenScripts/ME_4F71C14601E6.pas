unit kwMouseLeftUp;

interface

uses
 l3IntfUses
 , kwMouseUpDownSupport
;

type
 TkwMouseLeftUp = class(TkwMouseUpDownSupport)
  function GetMouseEventFlag: Integer;
 end;//TkwMouseLeftUp
 
implementation

uses
 l3ImplUses
;

end.
