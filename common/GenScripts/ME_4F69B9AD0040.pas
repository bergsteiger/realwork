unit kwVcmDispatcherUnlock;

interface

uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwVcmDispatcherUnlock = class(TtfwRegisterableWord)
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVcmDispatcherUnlock
 
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
