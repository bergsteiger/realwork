unit kwEntityOperation;

interface

uses
 l3IntfUses
 , kwEntityOperationPrim
 , vcmBaseEntitiesCollectionItem
 , vcmBaseOperationsCollectionItem
 , tfwScriptingInterfaces
 , vcmExternalInterfaces
;

type
 TkwEntityOperation = class(TkwEntityOperationPrim)
  procedure Register(anEn: TvcmBaseEntitiesCollectionItem;
   anOp: TvcmBaseOperationsCollectionItem);
  procedure DoOp(const aCtx: TtfwContext;
   const anOp: TvcmOPID);
 end;//TkwEntityOperation
 
implementation

uses
 l3ImplUses
 , vcmBase
 , vcmRepOperationsCollectionItem
 , vcmInterfaces
 , kwEntityOperationTest
 , kwString
 , kwOperationsRegistrar
 , SysUtils
 , StrUtils
 , l3Except
;

end.
