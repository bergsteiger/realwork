unit kwVcmOpShortcut;

interface

uses
 l3IntfUses
 , kwOperationParamWordPrim
 , vcmInterfaces
 , tfwScriptingInterfaces
;

type
 TkwVcmOpShortcut = class(TkwOperationParamWordPrim)
  procedure DoParams(const aParams: IvcmTestParams;
   const aCtx: TtfwContext);
 end;//TkwVcmOpShortcut
 
implementation

uses
 l3ImplUses
;

end.
