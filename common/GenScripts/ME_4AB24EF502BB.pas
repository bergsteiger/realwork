unit vcmBaseMenuManager;

interface

uses
 l3IntfUses
 , l3StringIDEx
 , vcmBase
 , vcmBaseOperationsCollectionItem
 , vcmRepOperationsCollectionItem
 , vcmInterfaces
 , vcmBaseTypes
 , vcmExternalInterfaces
 , l3ProtoObjectRefList
 , vcmModule
 , vcmBaseEntities
 , vcmStringCollection
 , vcmModulesCollection
 , vcmFormsCollection
 , vcmMessagesCollection
 , ImgList
 , vcmPopupMenuPrim
 , ToolsAPI
 , vcmMenuItemClickListenerList
 , vcmUserControls
 , vcmEntityForm
 , Menus
 , vcmRepEntitiesCollectionItem
 , vcmBaseCollectionItem
 , ActnList
 , afwInterfaces
 , vcmMenuManagerTypes
 , vcmMenus
 , Classes
 , vcmBaseCollection
 , Types
 , l3ProtoObject
 , l3PopupMenuHelper
 , Controls
;

type
 TvcmOperationManager = class(TvcmCacheableBase)
  {* �������� ��������. ������������� �������� OnTest � OnExecute ��������, ��� ���������� ������ }
  procedure Create(const aForm: IvcmEntityForm;
   aFormActivate: TvcmFormActivate;
   aOperation: TvcmBaseOperationsCollectionItem);
  procedure DoTest(const aParams: IvcmTestParamsPrim;
   aHandler: TvcmTestEvent);
   {* ��������� ������� � ���������� ����� }
  procedure DoExecute(const aParams: IvcmExecuteParams;
   aHandler: TvcmExecuteEvent);
   {* �������� ����� ���� �������, ��� ���������� }
  procedure OnTest(const aParams: IvcmTestParamsPrim);
   {* ��������� ������� � ���������� ����� }
  procedure OnExecute(const aParams: IvcmExecuteParams);
   {* �������� ����� ���� �������, ��� ���������� }
  procedure OnContextTest(const aParams: IvcmTestParamsPrim);
   {* ��������� ������� � ���������� ����� }
  procedure OnContextExecute(const aParams: IvcmExecuteParams);
   {* �������� ����� ���� �������, ��� ���������� }
  function FindForm(const aParams: IvcmContainer;
   theForm: PIvcmEntityForm): Boolean;
   {* ���� ����� � ���������� ��������� ���������� ���� FormActivate }
 end;//TvcmOperationManager
 
 TvcmOperationManagers = class(TvcmCacheableBase)
  {* ������ ���������� �������� }
  procedure Create;
  procedure Add(aManager: TvcmOperationManager);
  procedure Delete(const aForm: IvcmEntityForm);
 end;//TvcmOperationManagers
 
 TvcmFormActivateOperations = class(TvcmCacheableBase)
  {* ������ �������� ������� � ��������� ���������� �� ���������� ������ (FormActivate <> '') }
  procedure Create;
  function GetFormActivate(aOperation: TvcmBaseOperationsCollectionItem): TvcmFormActivate;
   {* ���������� FormActivate, ���� �������� �������� �� ���������� ������ }
  procedure AddOperation(aOperation: TvcmRepOperationsCollectionItem);
   {* ��������� � ������ �������� ���������� �� ���������� ������ }
  procedure LoadOperations;
 end;//TvcmFormActivateOperations
 
 TvcmFormActivateManager = class(TvcmCacheableBase)
  {* ���������� ���������� ����������� ���� }
  procedure Create;
  procedure AddForm(const aForm: IvcmEntityForm);
   {* ������������ �������� ��������� }
  procedure RemoveForm(const aForm: IvcmEntityForm);
   {* ��� �������� ����� ������� ��������� TvcmOperationManager-� }
  procedure AddModule(aModule: TvcmModule);
   {* ������������ �������� ������ }
  procedure RegOperation(aOperation: TvcmBaseOperationsCollectionItem;
   const aForm: IvcmEntityForm);
   {* ���� ������ �������� �������� �� ���������� ������, �� �������� FormActivate � TvcmFormActivateOperations � ������ TvcmOperationManager }
 end;//TvcmFormActivateManager
 
 TvcmInitCommandsEvent = procedure(aSender: TObject;
  aCommands: TObject) of object;
 
 TvcmOperationExecuteNotify = procedure(aType: TvcmOperationCallType;
  const anOperation: IvcmOperationDef) of object;
  {* ��������� ������� � ��������� �������� }
 
 TvcmBaseMenuManagerPrim = class(TvcmBaseEntities, IvcmResources)
  procedure WriteRes;
  procedure RegisterEntities;
  function DoShortCutCommand(aCommand: Word): Boolean;
  function GetModulesCollectionClass: RvcmModulesCollection;
  procedure OperationExecuteNotify(aType: TvcmOperationCallType;
   const anOperation: IvcmOperationDef);
   {* ����������� � ��������� ��������. ���������� ����� ���������� ��������. ��� ������ ShortCut, anAction �� �����������, ���������� ��������������� ��������. ���� ����� ���������� ����������� �������� ��� ��������, �� �������� anAction ����� ����� ���������� �������� �� IvcmOperationDef }
  procedure RegisterKeywords;
  procedure RegisterModuleInMenu(aForm: TvcmEntityForm;
   const aModuleDef: IvcmModuleDef);
   {* ������������ ������ � ����, toolbar'��, etc. ��� ���������� � ��������. }
  procedure MainCreated(aForm: TvcmEntityForm);
  procedure RegisterMainInMenu(aForm: TvcmEntityForm);
   {* ������������ �������� ����� � ����, toolbar'��, etc. ��� ���������� � ��������. }
  procedure RegisterChildInMenu(aForm: TvcmEntityForm);
   {* ������������ �������� ����� � ����, toolbar'��, etc. ��� ���������� � ��������. }
  function GetPopupMenu: TPopupMenu;
  function GetOperationableObjectByID(anID: Integer): TvcmRepEntitiesCollectionItem;
  function GetOperationableObjectByName(const aName: AnsiString;
   aModule: Boolean): TvcmRepEntitiesCollectionItem;
  procedure RegisterOperation(const aControl: IvcmIdentifiedUserFriendlyControl;
   const anOp: IvcmOperationDef;
   anUFHolder: TObject;
   anOpHolder: TObject);
  procedure AddForm(const aForm: IvcmEntityForm);
  procedure RemoveForm(const aForm: IvcmEntityForm);
  procedure ReloadToolbars(const aForm: IvcmEntityForm);
  procedure ReloadAllToolbars;
  procedure PostBuild(aForm: TvcmEntityForm;
   aFollowDocks: Boolean);
  procedure LoadShortcuts(aResetToDefault: Boolean);
  function MergedToMainForm(aForm: TvcmEntityForm): Boolean;
  procedure AddModule(aModule: TvcmModule);
  procedure BackupOpStatus;
  procedure RestoreOpStatus;
  procedure BeginOp;
  function GetOpLock: Boolean;
  procedure EndOp;
  procedure FastenToolbars;
  function GetFastenMode: Boolean;
  function BuildVirtualForm(aFormClass: RvcmEntityForm;
   out NeedFreeForm: Boolean;
   aUserType: TvcmUserType): TvcmEntityForm;
  function ObjectByType(anObject: TvcmObject;
   const anObjectName: AnsiString;
   const aSubName: AnsiString;
   ForceCreate: Boolean): TvcmBaseCollectionItem;
  procedure DefineObjectProp(anObject: TvcmObject;
   const anObjectName: AnsiString;
   const aSubName: AnsiString;
   const aProp: AnsiString;
   const aValue: AnsiString);
  function OpDefBySelector(const anOp: TvcmOpSelector): IvcmOperationDef;
  function BuildAction(const anOp: TvcmOpSelector;
   aDefaultAction: TCustomAction): TCustomAction;
  function UnlockInProgress: Boolean;
  procedure AddControlForUnlockPostBuild(const aControl: IafwMenuUnlockedPostBuild);
  procedure ListenerControlDestroying(const aControl: IafwMenuUnlockedPostBuild);
  procedure SubscribeMenuItemClickListener(const aListener: IvcmMenuItemClickListener);
  procedure UnsubscribeMenuItemClickListener(const aListener: IvcmMenuItemClickListener);
  procedure NotifyMenuItemClick(aMenuItem: TvcmMenuItem);
  procedure NotifyMenuItemClickListeners(aMenuItem: TvcmMenuItem);
  procedure Define(const aName: AnsiString;
   const aRus: AnsiString;
   const anAlien: AnsiString);
 end;//TvcmBaseMenuManagerPrim
 
 TvcmPopupMenuHelper = class(Tl3ProtoObject, Il3PopupMenuHelper)
  function CheckPopup(const anEntityDef: IvcmEntityDef): IvcmEntity;
  function Exists: Boolean;
   {* ��������� ������ ��������� ���������� ��� ��� }
  function GetPopupMenu(aControl: TComponent;
   const aPoint: TPoint): TMenuItem;
  procedure GetPopupMenuForComponentInfo(aControl: TComponent;
   const aPoint: TPoint;
   aCallback: Tl3PopupMenuHelperCallback);
 end;//TvcmPopupMenuHelper
 
 TvcmBaseMenuManager = class(TvcmBaseMenuManagerPrim)
  function FillPopupMenu(const aPopupPoint: TPoint;
   aPopupComponent: TComponent): TvcmPopupMenuPrim;
 end;//TvcmBaseMenuManager
 
implementation

uses
 l3ImplUses
 , vtUtils
 , vcmBaseMenuManagerRes
 , l3ConstStrings
 , vcmExportConst
 , StrUtils
 , SysUtils
 , Forms
 , vcmContentConst
 , vcmOVCCommands
 , vcmModulesCollectionItem
 , l3InterfacesMisc
 , vcmRepEntitiesCollection
 , vcmBaseEntitiesCollectionItem
 , vcmBaseEntitiesCollection
 , afwFacade
 , vcmModuleDef
 , l3Interfaces
 , OvcController
 , vcmSettings
 , vcmMainForm
 , vcmFormsCollectionItem
 , l3String
 , TypInfo
 , vcmModuleAction
 , vcmEntityAction
 , vcmOperationsManager
 , l3Base
 , vcmCustomHelpers
 , vcmOperationsCollectionItem
 , vcmEntitiesCollectionItem
 , vcmUtils
 , kwEntityOperation
 , kwOperationsRegistrar
 , VCMWordsPack
 , vcmEntitiesDefIteratorForContextMenu
;

type
 TControlFriend = class(TControl)
  {* ���� ��� TControl }
 end;//TControlFriend
 
end.
