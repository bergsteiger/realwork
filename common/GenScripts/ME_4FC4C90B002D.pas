unit kwVcmHistoryGetBackCount;

interface

uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwVcmHistoryGetBackCount = class(TtfwRegisterableWord)
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVcmHistoryGetBackCount
 
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
