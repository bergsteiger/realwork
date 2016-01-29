unit kwWaitYes;

interface

uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwWaitYes = class(TtfwRegisterableWord)
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwWaitYes
 
implementation

uses
 l3ImplUses
 , l3BatchService
 , Controls
;

end.
