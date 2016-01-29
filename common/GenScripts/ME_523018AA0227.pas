unit kwVcmOpImageIndex;

interface

uses
 l3IntfUses
 , kwOperationParamWordPrim
 , vcmInterfaces
 , tfwScriptingInterfaces
;

type
 TkwVcmOpImageIndex = class(TkwOperationParamWordPrim)
  procedure DoParams(const aParams: IvcmTestParams;
   const aCtx: TtfwContext);
 end;//TkwVcmOpImageIndex
 
implementation

uses
 l3ImplUses
;

end.
