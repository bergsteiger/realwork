unit kwWaitNo;

interface

uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwWaitNo = class(TtfwRegisterableWord)
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwWaitNo
 
implementation

uses
 l3ImplUses
 , l3BatchService
 , Controls
;

end.
