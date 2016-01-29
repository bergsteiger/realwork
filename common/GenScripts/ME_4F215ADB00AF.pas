unit kwVcmFindForm;

interface

uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwVcmFindForm = class(TtfwRegisterableWord)
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwVcmFindForm
 
implementation

uses
 l3ImplUses
 , vcmInterfaces
 , vcmForm
 , Controls
 , StdRes
 , vcmBase
 , afwAnswer
;

end.
