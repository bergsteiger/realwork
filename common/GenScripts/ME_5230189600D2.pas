unit kwVcmOpHint;

interface

uses
 l3IntfUses
 , kwOperationParamWordPrim
 , vcmInterfaces
 , tfwScriptingInterfaces
;

type
 TkwVcmOpHint = class(TkwOperationParamWordPrim)
  procedure DoParams(const aParams: IvcmTestParams;
   const aCtx: TtfwContext);
 end;//TkwVcmOpHint
 
implementation

uses
 l3ImplUses
;

end.
