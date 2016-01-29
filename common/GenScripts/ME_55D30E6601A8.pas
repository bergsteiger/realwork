unit vcmBaseOperationsCollection;

interface

uses
 l3IntfUses
 , vcmBaseCollection
 , Classes
 , vcmExternalInterfaces
 , vcmUserControls
 , vcmInterfaces
 , vcmOperationDefList
 , vcmBase
;

type
 TvcmBaseOperationsCollection = class(TvcmBaseCollection)
  {* Коллекция операций }
  function NeedToBeStored: Boolean;
  procedure Operation(aControl: TComponent;
   const aTarget: IUnknown;
   anOperationID: TvcmControlID;
   aMode: TvcmOperationMode;
   const aParams: IvcmParams);
   {* выполняет операцию сущности }
  procedure GetOperations(anOperations: TvcmOperationDefList);
   {* возвращает список описателей операций }
  procedure RegisterInRep;
  procedure PublishOp(aControl: TComponent;
   const anOperation: TvcmString;
   anExecute: TvcmControlExecuteEvent;
   aTest: TvcmControlTestEvent;
   aGetState: TvcmControlGetStateEvent);
   {* опубликовать операцию }
  procedure PublishOpWithResult(aControl: TComponent;
   const anOperation: TvcmString;
   anExecute: TvcmExecuteEvent;
   aTest: TvcmControlTestEvent;
   aGetState: TvcmControlGetStateEvent);
   {* опубликовать операцию }
  procedure UnlinkControl(aControl: TComponent);
   {* отвязать контрол }
 end;//TvcmBaseOperationsCollection
 
implementation

uses
 l3ImplUses
 , TypInfo
 , SysUtils
 , vcmBaseOperationsCollectionItem
 , vcmOperationsCollectionItem
 , vcmModule
 , Menus
 , TtfwClassRef_Proxy
;

end.
