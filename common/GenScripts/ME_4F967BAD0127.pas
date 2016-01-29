unit kwMouseUpDownSupport;

interface

uses
 l3IntfUses
 , kwSendInputSupport
 , Windows
 , tfwScriptingInterfaces
;

type
 TkwMouseUpDownSupport = class(TkwSendInputSupport)
  function GetMouseEventFlag: Integer;
  function GetInputStruct(const aCtx: TtfwContext): TInput;
 end;//TkwMouseUpDownSupport
 
implementation

uses
 l3ImplUses
 , l3Base
;

end.
