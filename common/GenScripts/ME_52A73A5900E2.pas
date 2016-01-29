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
   {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TvcmOperationsManager
 
implementation

uses
 l3ImplUses
;

end.
