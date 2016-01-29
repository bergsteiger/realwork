unit kwSendInputSupport;

interface

uses
 l3IntfUses
 , tfwRegisterableWord
 , Windows
 , tfwScriptingInterfaces
;

type
 TkwSendInputSupport = class(TtfwRegisterableWord)
  function GetInputStruct(const aCtx: TtfwContext): TInput;
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwSendInputSupport
 
implementation

uses
 l3ImplUses
;

end.
