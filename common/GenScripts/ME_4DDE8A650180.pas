unit kwWaitOk;

interface

uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwWaitOk = class(TtfwRegisterableWord)
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwWaitOk
 
implementation

uses
 l3ImplUses
 , l3BatchService
 , Controls
;

end.
