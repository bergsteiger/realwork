unit kwVcmOpLongHint;

interface

uses
 l3IntfUses
 , kwOperationParamWordPrim
 , vcmInterfaces
 , tfwScriptingInterfaces
;

type
 TkwVcmOpLongHint = class(TkwOperationParamWordPrim)
  procedure DoParams(const aParams: IvcmTestParams;
   const aCtx: TtfwContext);
 end;//TkwVcmOpLongHint
 
implementation

uses
 l3ImplUses
;

end.
