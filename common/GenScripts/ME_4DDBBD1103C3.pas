unit vcmBaseEntitiesCollectionItem;

interface

uses
 l3IntfUses
 , Classes
 , vcmBaseCollectionItem
 , vcmBaseOperationsCollection
 , vcmUserControls
 , vcmTargetedControlsCollection
 , vcmInterfaces
 , vcmRepositoryEx
 , vcmBaseCollection
 , vcmExternalInterfaces
 , vcmBase
;

type
 TvcmGetTargetEvent = function(aControl: TComponent;
  aX: Integer;
  aY: Integer;
  out theTarget: IUnknown): Boolean of object;
 
 TvcmBaseEntitiesCollectionItemPrim = class(TvcmBaseCollectionItem)
  function GetOperationsStored: Boolean;
  function IDRep: TvcmRep;
  function GetOperationsCollectionClass: RvcmBaseCollection;
  function GetEntityForControl(aControl: TComponent;
   aX: Integer;
   aY: Integer): IvcmEntity;
  procedure Operation(aControl: TComponent;
   const aTarget: IUnknown;
   anOperationID: TvcmControlID;
   aMode: TvcmOperationMode;
   const aParams: IvcmParams);
  function IsFormItem: Boolean;
  function SupportedExBy(aControl: TComponent): Integer;
  function HasInternalOperations: Boolean;
  function HasOnlyInternalOperations: Boolean;
  procedure RegisterInRep;
  procedure PublishEntity(aControl: TComponent;
   aGetTarget: TvcmControlGetTargetEvent);
  procedure PublishFormEntity(aGetTarget: TvcmGetTargetEvent);
  procedure PublishOp(aControl: TComponent;
   const anOperation: TvcmString;
   anExecute: TvcmControlExecuteEvent;
   aTest: TvcmControlTestEvent;
   aGetState: TvcmControlGetStateEvent); overload;
  procedure PublishOp(aControl: TComponent;
   const anOperation: TvcmString;
   anExecute: TvcmExecuteEvent;
   aTest: TvcmControlTestEvent;
   aGetState: TvcmControlGetStateEvent); overload;
  function IsItemCaptionUnique(aItem: TvcmBaseCollectionItem): Boolean;
  function OperationsStored: Boolean;
   {* "Функция определяющая, что свойство Operations сохраняется" }
  function ControlsStored: Boolean;
   {* "Функция определяющая, что свойство Controls сохраняется" }
 end;//TvcmBaseEntitiesCollectionItemPrim
 
 TvcmBaseEntitiesCollectionItem = class(TvcmBaseEntitiesCollectionItemPrim)
  {* Не дорисовал из-за ссылки на vcmForm
Потом надо как-то разрулить цикл }
 end;//TvcmBaseEntitiesCollectionItem
 
implementation

uses
 l3ImplUses
 , vcmEntitiesCollectionItemEntity
 , vcmControlsCollectionItem
 , Forms
 , vcmBaseEntityDef
 , vcmOperationableIdentifiedUserFriendly
 , TtfwClassRef_Proxy
;

end.
