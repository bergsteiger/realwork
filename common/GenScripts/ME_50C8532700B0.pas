unit kwMouseWheelDown;

interface

uses
 l3IntfUses
 , kwMouseWheelSupport
 , tfwScriptingInterfaces
;

type
 TkwMouseWheelDown = class(TkwMouseWheelSupport)
  function GetLineCount(const aCtx: TtfwContext): Integer;
 end;//TkwMouseWheelDown
 
implementation

uses
 l3ImplUses
;

end.
