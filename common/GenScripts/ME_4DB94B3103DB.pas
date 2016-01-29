unit kwWasWait;

interface

uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwWasWait = class(TtfwRegisterableWord)
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwWasWait
 
implementation

uses
 l3ImplUses
 , l3BatchService
 , Controls
;

end.
