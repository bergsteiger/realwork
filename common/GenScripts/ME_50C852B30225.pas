unit kwMouseWheelSupport;

interface

uses
 l3IntfUses
 , kwSendInputSupport
 , tfwScriptingInterfaces
 , Windows
;

type
 TkwMouseWheelSupport = class(TkwSendInputSupport)
  function GetLineCount(const aCtx: TtfwContext): Integer;
  function GetInputStruct(const aCtx: TtfwContext): TInput;
 end;//TkwMouseWheelSupport
 
implementation

uses
 l3ImplUses
 , l3Base
;

end.
