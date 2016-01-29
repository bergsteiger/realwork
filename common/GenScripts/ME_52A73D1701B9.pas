unit kwOperationsRegistrar;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , vcmOperationsManager
 , vcmBaseEntitiesCollectionItem
 , vcmBaseOperationsCollectionItem
;

type
 TkwOperationsRegistrar = class(Tl3ProtoObject, IvcmOperationsRegistrar)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
  procedure Register(anEn: TvcmBaseEntitiesCollectionItem;
   anOp: TvcmBaseOperationsCollectionItem);
 end;//TkwOperationsRegistrar
 
implementation

uses
 l3ImplUses
 , kwEntityOperation
;

end.
