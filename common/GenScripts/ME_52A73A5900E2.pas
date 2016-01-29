unit vcmOperationsManager;

interface

uses
 l3IntfUses
 , vcmBaseEntitiesCollectionItem
 , vcmBaseOperationsCollectionItem
;

type
 IvcmOperationsRegistrar = interface
  procedure Register(anEn: TvcmBaseEntitiesCollectionItem;
   anOp: TvcmBaseOperationsCollectionItem);
 end;//IvcmOperationsRegistrar
 
 TvcmOperationsManager = class
  procedure Register(anEn: TvcmBaseEntitiesCollectionItem;
   anOp: TvcmBaseOperationsCollectionItem);
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
 end;//TvcmOperationsManager
 
implementation

uses
 l3ImplUses
;

end.
