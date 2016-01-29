unit vcmBaseOperationsCollectionItem;

interface

uses
 l3IntfUses
 , vcmExternalInterfaces
 , vcmInterfaces
 , vcmBase
 , vcmOperationParams
 , vcmUserControls
 , vcmBaseOperationStates
 , vcmActiveControlsCollection
 , Classes
 , vcmBaseOperationState
 , vcmAction
 , ActnList
 , Forms
 , Actions
;

type
 TvcmGetStateEvent = procedure(var State: TvcmOperationStateIndex) of object;
 
 TvcmContextTestEvent = TvcmTestEvent;
  {* ���������� � ������ �������� ����������� �������� �� ������������ ���� }
 
 TvcmContextExecuteEvent = TvcmExecuteEvent;
  {* ���������� ��� ���������� �������� �� ������������ ���� }
 
 TvcmHandleType = (
  vcm_htContext
  , vcm_htGlobal
  , vcm_htControl
 );//TvcmHandleType
 
 TvcmHandleTypes = set of TvcmHandleType;
 
 TvcmBaseOperationsCollectionItemPrim = class(TvcmOperationParams)
  function GetDefaultOptions: TvcmOperationOptions;
  function GetGroupIDStored: Boolean;
  function GetOperationTypeStored: Boolean;
  function GetIsDefaultStored: Boolean;
  procedure OnSecondaryShortCutsChange(Sender: TObject);
  function IsHandledToControl: Boolean;
   {* �������� ������������ ����������� }
  function GetLinkedAction: TvcmAction;
   {* Action � �������� ��������� �������� }
  function ControllerCommand: Word;
   {* ������������� ��������-shortcut }
  function ParentID: Integer;
  function IsLinkedToModule: Boolean;
  procedure ResetShortCutHandler(var aValue: TShortCut;
   aCommandID: Word);
  procedure DoFormGetState(var State: TvcmOperationStateIndex);
  procedure DoFormTest(const aParams: IvcmTestParamsPrim);
  procedure DoFormExecute(const aParams: IvcmExecuteParams);
  procedure FakeControlTest(const aParams: IvcmTestParamsPrim);
  procedure ClearOp;
  procedure SetShortCuts(aShortCut: TShortCut;
   aSecondaryShortCuts: TShortCutList);
  function StatesClass: RvcmBaseOperationStates;
  function OwnerUserType: TvcmEffectiveUserType;
   {* ���������� ���������������� ��� "�����" �� ������� ���������� �������� }
  function OwnerForm: TCustomForm;
   {* ���������� "�����" �� ������� ���������� �������� }
  procedure ReplaceShortCuts(aShortCut: TShortCut;
   aSecondaryShortCuts: TCustomShortCutList); overload;
  procedure ReplaceShortCuts(aShortCut: TShortCut;
   aSecondaryShortCuts: TShortCutList); overload;
  procedure StoreDesignTimeShortcuts;
  function SomePropStored: Boolean;
  procedure RemoveShortCut(aShortCut: TShortCut);
  procedure UnlinkControl(aControl: TComponent);
  function Handled(aTypes: TvcmHandleTypes): Boolean;
  procedure Operation(aControl: TComponent;
   const aTarget: IUnknown;
   aMode: TvcmOperationMode;
   const aParams: IvcmParams;
   aForce: Boolean);
   {* ���������� �������� }
  procedure PublishOp(aControl: TComponent;
   anExecute: TvcmControlExecuteEvent;
   aTest: TvcmControlTestEvent;
   aGetState: TvcmControlGetStateEvent); overload;
   {* ������������ �������� }
  procedure PublishOp(aControl: TComponent;
   anExecute: TvcmExecuteEvent;
   aTest: TvcmControlTestEvent;
   aGetState: TvcmControlGetStateEvent); overload;
   {* ������������ �������� }
  function OperationTypeStored: Boolean;
   {* "������� ������������, ��� �������� OperationType �����������" }
  function IsDefaultStored: Boolean;
   {* "������� ������������, ��� �������� IsDefault �����������" }
  function GroupIDStored: Boolean;
   {* "������� ������������, ��� �������� GroupID �����������" }
 end;//TvcmBaseOperationsCollectionItemPrim
 
 TvcmBaseOperationsCollectionItem = class(TvcmBaseOperationsCollectionItemPrim)
 end;//TvcmBaseOperationsCollectionItem
 
implementation

uses
 l3ImplUses
 , vcmInternalConst
 , vcmEntitiesCollectionItem
 , OvcCmd
 , OvcController
 , Menus
 , vcmModulesCollectionItem
 , vcmBaseEntitiesCollectionItem
 , vcmModuleDef
 , vcmOVCCommands
 , vcmModuleAction
 , vcmEntityAction
 , afwFacade
 , l3Types
 , vcmActiveControlsCollectionItem
 , Controls
 , TypInfo
 , vcmBaseOperationDef
 , vcmUtils
 , vcmRepositoryEx
 , vcmModule
 , TtfwClassRef_Proxy
;

end.
