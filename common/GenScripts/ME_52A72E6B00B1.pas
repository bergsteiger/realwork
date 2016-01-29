unit vcmBaseEntitiesCollection;

interface

uses
 l3IntfUses
 , vcmBaseCollection
 , vcmExternalInterfaces
 , vcmBaseEntitiesCollectionItem
 , vcmBase
 , vcmBaseOperationsCollectionItem
 , vcmEntitiesDefList
 , Classes
 , vcmBaseCollectionItem
;

type
 TvcmBaseEntitiesCollection = class(TvcmBaseCollection, IvcmOperationsPublisher)
  function PublishFormEntity(const anEntity: TvcmString;
   aGetTarget: TvcmGetTargetEvent): TvcmBaseEntitiesCollectionItem;
   {* опубликовать сущность }
  procedure GroupItemsInContextMenu(const anEntity: TvcmString);
  procedure ToolbarAtBottom(const anEntity: TvcmString);
  procedure ContextMenuWeight(const anEntity: TvcmString;
   aWeight: Integer); overload;
   {* установить вес сущности в контекстном меню }
  procedure ContextMenuWeight(const anEntity: TvcmString;
   const anOperation: TvcmString;
   aWeight: Integer;
   aNoPrefix: Boolean); overload;
   {* установить вес операции в контекстном меню }
  procedure PublishOpWithResult(const anEntity: TvcmString;
   const anOperation: TvcmString;
   anExecute: TvcmExecuteEvent;
   aTest: TvcmControlTestEvent;
   aGetState: TvcmControlGetStateEvent;
   aNoPrefix: Boolean);
   {* опубликовать операцию }
  function GetOperationByName(const anEntity: TvcmString;
   const anOperation: TvcmString;
   aNoPrefix: Boolean): TvcmBaseOperationsCollectionItem;
  procedure ShowInContextMenu(const anEntity: TvcmString;
   const anOperation: TvcmString;
   aValue: Boolean;
   aNoPrefix: Boolean);
  procedure ShowInToolbar(const anEntity: TvcmString;
   const anOperation: TvcmString;
   aValue: Boolean;
   aNoPrefix: Boolean);
  function CheckEntityForControl(const anEntity: TvcmString): TvcmBaseEntitiesCollectionItem;
  procedure GetEntitiesDef(aList: TvcmEntitiesDefList);
   {* возвращает список описателей сущностей }
  procedure LinkControl(aControl: TComponent);
  procedure UnlinkControl(aControl: TComponent);
  procedure RegisterInRep;
  function IsItemCaptionUnique(aItem: TvcmBaseCollectionItem): Boolean;
   {* поиск операции по названию }
  procedure PublishEntity(const anEntity: TvcmString;
   aGetTarget: TvcmControlGetTargetEvent);
   {* опубликовать сущность. }
 end;//TvcmBaseEntitiesCollection
 
implementation

uses
 l3ImplUses
 , vcmInterfaces
 , vcmUserControls
 , vcmEntities
 , SysUtils
 , TtfwClassRef_Proxy
;

end.
