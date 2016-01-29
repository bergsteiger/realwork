unit kwVcmOpCaption;

interface

uses
 l3IntfUses
 , kwOperationParamWordPrim
 , vcmInterfaces
 , tfwScriptingInterfaces
;

type
 TkwVcmOpCaption = class(TkwOperationParamWordPrim)
  procedure DoParams(const aParams: IvcmTestParams;
   const aCtx: TtfwContext);
 end;//TkwVcmOpCaption
 
implementation

uses
 l3ImplUses
;

end.
