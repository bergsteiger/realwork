unit kwMouseWheelUp;

interface

uses
 l3IntfUses
 , kwMouseWheelSupport
 , tfwScriptingInterfaces
;

type
 TkwMouseWheelUp = class(TkwMouseWheelSupport)
  function GetLineCount(const aCtx: TtfwContext): Integer;
 end;//TkwMouseWheelUp
 
implementation

uses
 l3ImplUses
;

end.
