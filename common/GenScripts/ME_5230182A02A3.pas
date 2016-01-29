unit kwOperationParamWordPrim;

interface

uses
 l3IntfUses
 , tfwRegisterableWord
 , vcmInterfaces
 , tfwScriptingInterfaces
;

type
 TkwOperationParamWordPrim = class(TtfwRegisterableWord)
  procedure DoParams(const aParams: IvcmTestParams;
   const aCtx: TtfwContext);
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwOperationParamWordPrim
 
implementation

uses
 l3ImplUses
;

end.
