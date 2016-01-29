unit kwWaitCancel;

interface

uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwWaitCancel = class(TtfwRegisterableWord)
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwWaitCancel
 
implementation

uses
 l3ImplUses
 , l3BatchService
 , Controls
;

end.
