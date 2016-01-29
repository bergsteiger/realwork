unit kwOperationParamWord;

interface

uses
 l3IntfUses
 , kwOperationParamWordPrim
 , vcmExternalInterfaces
 , vcmInterfaces
 , tfwScriptingInterfaces
;

type
 TkwOperationParamWord = class(TkwOperationParamWordPrim)
  function Flag: TvcmOpFlag;
  procedure DoParams(const aParams: IvcmTestParams;
   const aCtx: TtfwContext);
 end;//TkwOperationParamWord
 
implementation

uses
 l3ImplUses
;

end.
