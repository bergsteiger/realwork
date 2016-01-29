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
  {* менеждер операции. Перехватывает операции OnTest и OnExecute операции, для управления формой }
  procedure Create(const aForm: IvcmEntityForm;
   aFormActivate: TvcmFormActivate;
   aOperation: TvcmBaseOperationsCollectionItem);
  procedure DoTest(const aParams: IvcmTestParamsPrim;
   aHandler: TvcmTestEvent);
   {* проверяет наличие и активность формы }
  procedure DoExecute(const aParams: IvcmExecuteParams;
   aHandler: TvcmExecuteEvent);
   {* скрывает форму если активна, или активирует }
  procedure OnTest(const aParams: IvcmTestParamsPrim);
   {* проверяет наличие и активность формы }
  procedure OnExecute(const aParams: IvcmExecuteParams);
   {* скрывает форму если активна, или активирует }
  procedure OnContextTest(const aParams: IvcmTestParamsPrim);
   {* проверяет наличие и активность формы }
  procedure OnContextExecute(const aParams: IvcmExecuteParams);
   {* скрывает форму если активна, или активирует }
  function FindForm(const aParams: IvcmContainer;
   theForm: PIvcmEntityForm): Boolean;
   {* ищет форму в приложении используя информацию поля FormActivate }
 end;//TvcmOperationManager
 
 TvcmOperationManagers = class(TvcmCacheableBase)
  {* список менеджеров операции }
  procedure Create;
  procedure Add(aManager: TvcmOperationManager);
  procedure Delete(const aForm: IvcmEntityForm);
 end;//TvcmOperationManagers
 
 TvcmFormActivateOperations = class(TvcmCacheableBase)
  {* список операций модулей и сущностей заявленных на управление формой (FormActivate <> '') }
  procedure Create;
  function GetFormActivate(aOperation: TvcmBaseOperationsCollectionItem): TvcmFormActivate;
   {* возвращает FormActivate, если операция заявлена на управление формой }
  procedure AddOperation(aOperation: TvcmRepOperationsCollectionItem);
   {* добавляет в список операцию заявленную на управление формой }
  procedure LoadOperations;
 end;//TvcmFormActivateOperations
 
 TvcmFormActivateManager = class(TvcmCacheableBase)
  {* координтор управления активностью форм }
  procedure Create;
  procedure AddForm(const aForm: IvcmEntityForm);
   {* регистрирует операции сущностей }
  procedure RemoveForm(const aForm: IvcmEntityForm);
   {* при удалении формы удаляет созданные TvcmOperationManager-ы }
  procedure AddModule(aModule: TvcmModule);
   {* регистрирует операции модуля }
  procedure RegOperation(aOperation: TvcmBaseOperationsCollectionItem;
   const aForm: IvcmEntityForm);
   {* если данная операция заявлена на управление формой, то получает FormActivate у TvcmFormActivateOperations и создаёт TvcmOperationManager }
 end;//TvcmFormActivateManager
 
 TvcmInitCommandsEvent = procedure(aSender: TObject;
  aCommands: TObject) of object;
 
 TvcmOperationExecuteNotify = procedure(aType: TvcmOperationCallType;
  const anOperation: IvcmOperationDef) of object;
  {* сигнатура события о выполении операции }
 
 TvcmBaseMenuManagerPrim = class(TvcmBaseEntities, IvcmResources)
  procedure WriteRes;
  procedure RegisterEntities;
  function DoShortCutCommand(aCommand: Word): Boolean;
  function GetModulesCollectionClass: RvcmModulesCollection;
  procedure OperationExecuteNotify(aType: TvcmOperationCallType;
   const anOperation: IvcmOperationDef);
   {* нотификация о выполении операции. Вызывается перед выполением операции. При вызове ShortCut, anAction не заполняется, вызывается непосредственно операция. Если будет необходимо обязательно получать имя операции, то параметр anAction нужно будет переделать например на IvcmOperationDef }
  procedure RegisterKeywords;
  procedure RegisterModuleInMenu(aForm: TvcmEntityForm;
   const aModuleDef: IvcmModuleDef);
   {* регистрирует модуль в меню, toolbar'ах, etc. Для перекрытия в потомках. }
  procedure MainCreated(aForm: TvcmEntityForm);
  procedure RegisterMainInMenu(aForm: TvcmEntityForm);
   {* регистрирует основную форму в меню, toolbar'ах, etc. Для перекрытия в потомках. }
  procedure RegisterChildInMenu(aForm: TvcmEntityForm);
   {* регистрирует дочернюю форму в меню, toolbar'ах, etc. Для перекрытия в потомках. }
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
   {* Проверяет создан экземпляр синглетона или нет }
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
  {* Друг для TControl }
 end;//TControlFriend
 
end.
