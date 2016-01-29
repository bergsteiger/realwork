unit kwVcmHistoryClear;

interface

uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwVcmHistoryClear = class(TtfwRegisterableWord)
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVcmHistoryClear
 
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
