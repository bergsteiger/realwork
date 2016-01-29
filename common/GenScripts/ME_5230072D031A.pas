unit kwEntityOperationTest;

interface

uses
 l3IntfUses
 , kwEntityOperationPrim
 , tfwScriptingInterfaces
 , vcmExternalInterfaces
;

type
 TkwEntityOperationTest = class(TkwEntityOperationPrim)
  procedure DoOp(const aCtx: TtfwContext;
   const anOp: TvcmOPID);
 end;//TkwEntityOperationTest
 
implementation

uses
 l3ImplUses
 , vcmBase
 , vcmInterfaces
;

end.
