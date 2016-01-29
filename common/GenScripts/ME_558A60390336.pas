unit kwVcmDispatcherUnlockInOp;

interface

uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwVcmDispatcherUnlockInOp = class(TtfwRegisterableWord)
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVcmDispatcherUnlockInOp
 
implementation

uses
 l3ImplUses
 , vcmForm
 , Controls
 , StdRes
 , vcmBase
 , afwAnswer
;

end.
