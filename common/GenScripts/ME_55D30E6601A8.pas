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
  {* ��������� �������� }
  function NeedToBeStored: Boolean;
  procedure Operation(aControl: TComponent;
   const aTarget: IUnknown;
   anOperationID: TvcmControlID;
   aMode: TvcmOperationMode;
   const aParams: IvcmParams);
   {* ��������� �������� �������� }
  procedure GetOperations(anOperations: TvcmOperationDefList);
   {* ���������� ������ ���������� �������� }
  procedure RegisterInRep;
  procedure PublishOp(aControl: TComponent;
   const anOperation: TvcmString;
   anExecute: TvcmControlExecuteEvent;
   aTest: TvcmControlTestEvent;
   aGetState: TvcmControlGetStateEvent);
   {* ������������ �������� }
  procedure PublishOpWithResult(aControl: TComponent;
   const anOperation: TvcmString;
   anExecute: TvcmExecuteEvent;
   aTest: TvcmControlTestEvent;
   aGetState: TvcmControlGetStateEvent);
   {* ������������ �������� }
  procedure UnlinkControl(aControl: TComponent);
   {* �������� ������� }
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
