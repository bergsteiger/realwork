unit kwCheckOutputWithInput;

interface

uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwCheckOutputWithInput = class(TtfwRegisterableWord)
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCheckOutputWithInput
 
implementation

uses
 l3ImplUses
;

end.
