unit kwTryFocusOnForm;

interface

uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwTryFocusOnForm = class(TtfwRegisterableWord)
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwTryFocusOnForm
 
implementation

uses
 l3ImplUses
 , vcmInterfaces
 , afwFacade
 , SysUtils
 , Forms
 , vcmEntityForm
 , Windows
 , vcmForm
 , Controls
 , StdRes
 , vcmBase
 , afwAnswer
;

end.
