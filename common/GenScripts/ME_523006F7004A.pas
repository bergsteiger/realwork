unit kwEntityOperationPrim;

interface

uses
 l3IntfUses
 , tfwRegisterableWordPrim
 , vcmBaseOperationsCollectionItem
 , vcmBaseEntitiesCollectionItem
 , tfwScriptingInterfaces
 , vcmExternalInterfaces
;

type
 TkwEntityOperationPrim = class(TtfwRegisterableWordPrim)
  procedure Create(anEn: TvcmBaseEntitiesCollectionItem;
   anOp: TvcmBaseOperationsCollectionItem);
  procedure DoOp(const aCtx: TtfwContext;
   const anOp: TvcmOPID);
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwEntityOperationPrim
 
implementation

uses
 l3ImplUses
;

end.
