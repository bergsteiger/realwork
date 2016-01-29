unit kwWaitChoice;

interface

uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwWaitChoice = class(TtfwRegisterableWord)
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwWaitChoice
 
implementation

uses
 l3ImplUses
 , l3BatchService
 , Controls
;

end.
