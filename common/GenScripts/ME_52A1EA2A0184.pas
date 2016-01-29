unit vcmBaseEntities;

interface

uses
 l3IntfUses
 , vcmComponent
 , vcmBaseEntitiesCollection
 , vcmBaseCollection
 , vcmBaseEntitiesCollectionItem
 , vcmEntitiesDefList
 , vcmBaseOperationsCollectionItem
 , vcmExternalInterfaces
 , Classes
;

type
 TvcmBaseEntities = class(TvcmComponent)
  {* Компонент для определения списка сущностей }
  function GetEntitiesCollectionClass: RvcmBaseCollection;
  function GetItemByName(const aName: AnsiString): TvcmBaseEntitiesCollectionItem;
  procedure LinkControls;
  procedure UnlinkControls;
  procedure GetEntitiesDef(aList: TvcmEntitiesDefList);
  function GetOperationByName(const anEntity: TvcmString;
   const anOperation: TvcmString): TvcmBaseOperationsCollectionItem;
  procedure SetTargetGetter(const anEntity: TvcmString;
   anEvent: TvcmGetTargetEvent);
  procedure MakeSupportedByControl(const anEntity: TvcmString;
   aControl: TComponent);
  function EntitiesStored: Boolean;
   {* "Функция определяющая, что свойство Entities сохраняется" }
 end;//TvcmBaseEntities
 
implementation

uses
 l3ImplUses
 , Forms
 , SysUtils
;

end.
