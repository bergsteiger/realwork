unit vcmBaseMenuManager;

// ������: "w:\common\components\gui\Garant\VCM\implementation\Visual\vcmBaseMenuManager.pas"
// ���������: "UtilityPack"
// ������� ������: "vcmBaseMenuManager" MUID: (4AB24EF502BB)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
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
 {$If NOT Defined(NoVCL)}
 , ImgList
 {$IfEnd} // NOT Defined(NoVCL)
 , vcmPopupMenuPrim
 {$If NOT Defined(XE)}
 , ToolsAPI
 {$IfEnd} // NOT Defined(XE)
 , vcmMenuItemClickListenerList
 , vcmUserControls
 , vcmEntityForm
 {$If NOT Defined(NoVCL)}
 , Menus
 {$IfEnd} // NOT Defined(NoVCL)
 , vcmRepEntitiesCollectionItem
 , vcmBaseCollectionItem
 {$If NOT Defined(NoVCL)}
 , ActnList
 {$IfEnd} // NOT Defined(NoVCL)
 , afwInterfaces
 , vcmMenuManagerTypes
 , vcmMenus
 , Classes
 , vcmBaseCollection
 , Types
 , l3ProtoObject
 {$If NOT Defined(NoVCL)}
 , l3PopupMenuHelper
 {$IfEnd} // NOT Defined(NoVCL)
;

const
 c_vcmTableName = 'vcmTable';
 c_vcmStopTableName = 'vcmStopTable';
 vcm_HistoryZones = [vcm_ztParent];
  {* ���� � ������� ����� ����������� � ������� }
 vcm_SaveFormZones = [vcm_ztNavigator];
  {* ��������� ����� � ��������� ��� ��������� �������� ���� ��� ��������� � ������������� ����� }

type
 TvcmOperationManager = class(TvcmCacheableBase)
  {* �������� ��������. ������������� �������� OnTest � OnExecute ��������, ��� ���������� ������ }
  private
   f_OldOnTest: TvcmTestEvent;
   f_OldOnContextTest: TvcmTestEvent;
   f_OldOnExecute: TvcmExecuteEvent;
   f_OldOnContextExecute: TvcmExecuteEvent;
   f_FormID: TvcmFormID;
   f_Operation: TvcmBaseOperationsCollectionItem;
   f_FormActivate: TvcmFormActivate;
   f_Form: IvcmEntityForm;
  protected
   procedure pm_SetOperation(aValue: TvcmBaseOperationsCollectionItem);
   procedure pm_SetFormActivate(aValue: TvcmFormActivate);
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
    theForm: PIvcmEntityForm = nil): Boolean;
    {* ���� ����� � ���������� ��������� ���������� ���� FormActivate }
   procedure Cleanup; override;
    {* ������� ������� ����� �������. }
   procedure ClearFields; override;
  public
   constructor Create(const aForm: IvcmEntityForm;
    aFormActivate: TvcmFormActivate;
    aOperation: TvcmBaseOperationsCollectionItem); reintroduce;
  public
   property Operation: TvcmBaseOperationsCollectionItem
    read f_Operation
    write pm_SetOperation;
   property FormActivate: TvcmFormActivate
    read f_FormActivate
    write pm_SetFormActivate;
   property Form: IvcmEntityForm
    read f_Form;
 end;//TvcmOperationManager

 TvcmOperationManagers = class(TvcmCacheableBase)
  {* ������ ���������� �������� }
  private
   {$If NOT Defined(DesignTimeLibrary)}
   f_Managers: Tl3ProtoObjectRefList;
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
  protected
   function pm_GetCount: Integer;
   function pm_GetItems(anIndex: Integer): TvcmOperationManager; virtual;
   procedure Cleanup; override;
    {* ������� ������� ����� �������. }
  public
   constructor Create; reintroduce;
   procedure Add(aManager: TvcmOperationManager);
   procedure Delete(const aForm: IvcmEntityForm);
  public
   property Count: Integer
    read pm_GetCount;
   property Items[anIndex: Integer]: TvcmOperationManager
    read pm_GetItems;
    default;
 end;//TvcmOperationManagers

 TvcmFormActivateOperations = class(TvcmCacheableBase)
  {* ������ �������� ������� � ��������� ���������� �� ���������� ������ (FormActivate <> '') }
  private
   f_IsModulesLoad: Boolean;
   f_IsEntitiesLoad: Boolean;
   f_Operations: TvcmObjectList;
  protected
   function pm_GetCount: Integer;
   function pm_GetItems(anIndex: Integer): TvcmBaseOperationsCollectionItem;
   procedure LoadOperations;
   procedure Cleanup; override;
    {* ������� ������� ����� �������. }
  public
   constructor Create; reintroduce;
   function GetFormActivate(aOperation: TvcmBaseOperationsCollectionItem): TvcmFormActivate;
    {* ���������� FormActivate, ���� �������� �������� �� ���������� ������ }
   procedure AddOperation(aOperation: TvcmRepOperationsCollectionItem);
    {* ��������� � ������ �������� ���������� �� ���������� ������ }
  public
   property Count: Integer
    read pm_GetCount;
   property Items[anIndex: Integer]: TvcmBaseOperationsCollectionItem
    read pm_GetItems;
 end;//TvcmFormActivateOperations

 TvcmFormActivateManager = class(TvcmCacheableBase)
  {* ���������� ���������� ����������� ���� }
  private
   f_Managers: TvcmOperationManagers;
   f_Operations: TvcmFormActivateOperations;
  protected
   function pm_GetItems(anIndex: Integer): TvcmOperationManager;
   function pm_GetCount: Integer;
   procedure RegOperation(aOperation: TvcmBaseOperationsCollectionItem;
    const aForm: IvcmEntityForm);
    {* ���� ������ �������� �������� �� ���������� ������, �� �������� FormActivate � TvcmFormActivateOperations � ������ TvcmOperationManager }
   procedure Cleanup; override;
    {* ������� ������� ����� �������. }
  public
   constructor Create; reintroduce;
   procedure AddForm(const aForm: IvcmEntityForm);
    {* ������������ �������� ��������� }
   procedure RemoveForm(const aForm: IvcmEntityForm);
    {* ��� �������� ����� ������� ��������� TvcmOperationManager-� }
   procedure AddModule(aModule: TvcmModule);
    {* ������������ �������� ������ }
  public
   property Operations: TvcmFormActivateOperations
    read f_Operations;
   property Items[anIndex: Integer]: TvcmOperationManager
    read pm_GetItems;
   property Count: Integer
    read pm_GetCount;
 end;//TvcmFormActivateManager

 TvcmInitCommandsEvent = procedure(aSender: TObject;
  aCommands: TObject) of object;

 TvcmOperationExecuteNotify = procedure(aType: TvcmOperationCallType;
  const anOperation: IvcmOperationDef) of object;
  {* ��������� ������� � ��������� �������� }

 TvcmBaseMenuManagerPrim = class(TvcmBaseEntities, IvcmResources)
  private
   f_KeywordsRegistered: Boolean;
   {$If NOT Defined(DesignTimeLibrary)}
   f_FormActivateManager: TvcmFormActivateManager;
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   f_Strings: TvcmStringCollection;
   f_HistoryZones: TvcmEffectiveZoneTypes;
    {* ����� ���, ������� ����������� � ������� }
   f_SaveFormZones: TvcmEffectiveZoneTypes;
    {* ��������� ����� � ��������� ��� ��������� �������� ���� ��� ��������� � ������������� �����. }
   f_Modules: TvcmModulesCollection;
    {* ��������� ������� }
   f_AppForms: TvcmFormsCollection;
   f_Messages: TvcmMessagesCollection;
   f_SmallImages: TCustomImageList;
   f_LargeImages: TCustomImageList;
   f_ToolbarPopup: TvcmPopupMenuPrim;
   f_OnInitCommands: TvcmInitCommandsEvent;
   f_OnOperationExecuteNotify: TvcmOperationExecuteNotify;
    {* ������� ��������� ����� ���������� �������� }
   f_MenuItemClickListeners: TvcmMenuItemClickListenerList;
  private
   procedure NotifyMenuItemClickListeners(aMenuItem: TvcmMenuItem);
  protected
   procedure pm_SetStrings(aValue: TvcmStringCollection);
   {$If Defined(DesignTimeLibrary)}
   function pm_GetUnitName: AnsiString;
   {$IfEnd} // Defined(DesignTimeLibrary)
   function pm_GetModules: TvcmModulesCollection;
   procedure pm_SetModules(aValue: TvcmModulesCollection);
   procedure pm_SetAppForms(aValue: TvcmFormsCollection);
   procedure pm_SetMessages(aValue: TvcmMessagesCollection);
   procedure pm_SetSmallImages(aValue: TCustomImageList);
   procedure pm_SetLargeImages(aValue: TCustomImageList);
   {$If Defined(DesignTimeLibrary)}
   function pm_GetModule: IOTAModule;
   {$IfEnd} // Defined(DesignTimeLibrary)
   {$If Defined(DesignTimeLibrary)}
   function pm_GetEditor: IOTAEditor;
   {$IfEnd} // Defined(DesignTimeLibrary)
   {$If Defined(DesignTimeLibrary)}
   function pm_GetSourceEditor: IOTASourceEditor;
   {$IfEnd} // Defined(DesignTimeLibrary)
   function pm_GetMenuItemClickListeners: TvcmMenuItemClickListenerList; virtual;
   {$If Defined(DesignTimeLibrary)}
   procedure WriteRes;
   {$IfEnd} // Defined(DesignTimeLibrary)
   {$If Defined(DesignTimeLibrary)}
   procedure RegisterEntities;
   {$IfEnd} // Defined(DesignTimeLibrary)
   function DoShortCutCommand(aCommand: Word): Boolean;
   function GetModulesCollectionClass: RvcmModulesCollection; virtual;
   procedure Define(const aName: AnsiString;
    const aRus: AnsiString;
    const anAlien: AnsiString);
   procedure Cleanup; override;
    {* ������� ������� ����� �������. }
   procedure Loaded; override;
   procedure Notification(AComponent: TComponent;
    Operation: TOperation); override;
   procedure WriteState(Writer: TWriter); override;
  public
   procedure OperationExecuteNotify(aType: TvcmOperationCallType;
    const anOperation: IvcmOperationDef);
    {* ����������� � ��������� ��������. ���������� ����� ���������� ��������. ��� ������ ShortCut, anAction �� �����������, ���������� ��������������� ��������. ���� ����� ���������� ����������� �������� ��� ��������, �� �������� anAction ����� ����� ���������� �������� �� IvcmOperationDef }
   procedure RegisterKeywords;
   {$If NOT Defined(DesignTimeLibrary)}
   procedure RegisterModuleInMenu(aForm: TvcmEntityForm;
    const aModuleDef: IvcmModuleDef); virtual;
    {* ������������ ������ � ����, toolbar'��, etc. ��� ���������� � ��������. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   {$If NOT Defined(DesignTimeLibrary)}
   procedure MainCreated(aForm: TvcmEntityForm); virtual;
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   procedure RegisterMainInMenu(aForm: TvcmEntityForm); virtual;
    {* ������������ �������� ����� � ����, toolbar'��, etc. ��� ���������� � ��������. }
   {$If NOT Defined(DesignTimeLibrary)}
   procedure RegisterChildInMenu(aForm: TvcmEntityForm); virtual;
    {* ������������ �������� ����� � ����, toolbar'��, etc. ��� ���������� � ��������. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   function GetPopupMenu: TPopupMenu; virtual;
   function GetOperationableObjectByID(anID: Integer): TvcmRepEntitiesCollectionItem;
   function GetOperationableObjectByName(const aName: AnsiString;
    aModule: Boolean): TvcmRepEntitiesCollectionItem;
   procedure RegisterOperation(const aControl: IvcmIdentifiedUserFriendlyControl;
    const anOp: IvcmOperationDef;
    anUFHolder: TObject;
    anOpHolder: TObject);
   procedure AddForm(const aForm: IvcmEntityForm);
   procedure RemoveForm(const aForm: IvcmEntityForm);
   procedure ReloadToolbars(const aForm: IvcmEntityForm); virtual;
   procedure ReloadAllToolbars;
   procedure PostBuild(aForm: TvcmEntityForm;
    aFollowDocks: Boolean = False); virtual;
   procedure LoadShortcuts(aResetToDefault: Boolean = False);
   function MergedToMainForm(aForm: TvcmEntityForm): Boolean; virtual;
   procedure AddModule(aModule: TvcmModule);
   procedure BackupOpStatus; virtual;
   procedure RestoreOpStatus; virtual;
   procedure BeginOp; virtual;
   function GetOpLock: Boolean; virtual;
   procedure EndOp; virtual;
   procedure FastenToolbars; virtual;
   function GetFastenMode: Boolean; virtual;
   function BuildVirtualForm(const aFormClass: RvcmEntityForm;
    out NeedFreeForm: Boolean;
    aUserType: TvcmUserType = vcm_utAny): TvcmEntityForm;
   function ObjectByType(anObject: TvcmObject;
    const anObjectName: AnsiString;
    const aSubName: AnsiString = '';
    ForceCreate: Boolean = False): TvcmBaseCollectionItem; virtual;
   procedure DefineObjectProp(anObject: TvcmObject;
    const anObjectName: AnsiString;
    const aSubName: AnsiString;
    const aProp: AnsiString;
    const aValue: AnsiString);
   function OpDefBySelector(const anOp: TvcmOpSelector): IvcmOperationDef;
   function BuildAction(const anOp: TvcmOpSelector;
    aDefaultAction: TCustomAction = nil): TCustomAction;
   function UnlockInProgress: Boolean; virtual;
   procedure AddControlForUnlockPostBuild(const aControl: IafwMenuUnlockedPostBuild); virtual;
   procedure ListenerControlDestroying(const aControl: IafwMenuUnlockedPostBuild); virtual;
   procedure SubscribeMenuItemClickListener(const aListener: IvcmMenuItemClickListener);
   procedure UnsubscribeMenuItemClickListener(const aListener: IvcmMenuItemClickListener);
   procedure NotifyMenuItemClick(aMenuItem: TvcmMenuItem);
   constructor Create(AOwner: TComponent); override;
   class function GetEntitiesCollectionClass: RvcmBaseCollection; override;
  protected
   {$If Defined(DesignTimeLibrary)}
   property Module: IOTAModule
    read pm_GetModule;
   {$IfEnd} // Defined(DesignTimeLibrary)
   {$If Defined(DesignTimeLibrary)}
   property Editor: IOTAEditor
    read pm_GetEditor;
   {$IfEnd} // Defined(DesignTimeLibrary)
   {$If Defined(DesignTimeLibrary)}
   property SourceEditor: IOTASourceEditor
    read pm_GetSourceEditor;
   {$IfEnd} // Defined(DesignTimeLibrary)
   property MenuItemClickListeners: TvcmMenuItemClickListenerList
    read pm_GetMenuItemClickListeners;
  public
   property Strings: TvcmStringCollection
    read f_Strings
    write pm_SetStrings;
   property HistoryZones: TvcmEffectiveZoneTypes
    read f_HistoryZones
    write f_HistoryZones;
    {* ����� ���, ������� ����������� � ������� }
   property SaveFormZones: TvcmEffectiveZoneTypes
    read f_SaveFormZones
    write f_SaveFormZones;
    {* ��������� ����� � ��������� ��� ��������� �������� ���� ��� ��������� � ������������� �����. }
   {$If Defined(DesignTimeLibrary)}
   property UnitName: AnsiString
    read pm_GetUnitName;
   {$IfEnd} // Defined(DesignTimeLibrary)
   property Modules: TvcmModulesCollection
    read pm_GetModules
    write pm_SetModules;
    {* ��������� ������� }
   property AppForms: TvcmFormsCollection
    read f_AppForms
    write pm_SetAppForms;
   property Messages: TvcmMessagesCollection
    read f_Messages
    write pm_SetMessages;
   property SmallImages: TCustomImageList
    read f_SmallImages
    write pm_SetSmallImages;
   property LargeImages: TCustomImageList
    read f_LargeImages
    write pm_SetLargeImages;
   property ToolbarPopup: TvcmPopupMenuPrim
    read f_ToolbarPopup;
   property OnInitCommands: TvcmInitCommandsEvent
    read f_OnInitCommands
    write f_OnInitCommands;
   property OnOperationExecuteNotify: TvcmOperationExecuteNotify
    read f_OnOperationExecuteNotify
    write f_OnOperationExecuteNotify;
    {* ������� ��������� ����� ���������� �������� }
 end;//TvcmBaseMenuManagerPrim

 TvcmPopupMenuHelper = {final} class(Tl3ProtoObject{$If NOT Defined(NoVCL)}
 , Il3PopupMenuHelper
 {$IfEnd} // NOT Defined(NoVCL)
 )
  private
   f_Popup: TPopupMenu;
   f_PopupForm: TvcmEntityForm;
  private
   function CheckPopup(const anEntityDef: IvcmEntityDef): IvcmEntity;
  public
   {$If NOT Defined(NoVCL)}
   function GetPopupMenu(aControl: TComponent;
    const aPoint: TPoint): TMenuItem;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   procedure GetPopupMenuForComponentInfo(aControl: TComponent;
    const aPoint: TPoint;
    aCallback: Tl3PopupMenuHelperCallback);
   {$IfEnd} // NOT Defined(NoVCL)
   class function Instance: TvcmPopupMenuHelper;
    {* ����� ��������� ���������� ���������� TvcmPopupMenuHelper }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TvcmPopupMenuHelper

 //#UC START# *52A1F4A201F9ci*
 //#UC END# *52A1F4A201F9ci*
 //#UC START# *52A1F4A201F9cit*
 //#UC END# *52A1F4A201F9cit*
 TvcmBaseMenuManager = class(TvcmBaseMenuManagerPrim)
  public
   function FillPopupMenu(const aPopupPoint: TPoint;
    aPopupComponent: TComponent): TvcmPopupMenuPrim; virtual;
 //#UC START# *52A1F4A201F9publ*
  public
   property HistoryZones default vcm_HistoryZones;
   property SaveFormZones default vcm_SaveFormZones;
 //#UC END# *52A1F4A201F9publ*
 end;//TvcmBaseMenuManager

procedure _DoInitConstString(var anID: Tl3StringIDEx);
procedure vcmStartupComplete;

var g_MenuManager: TvcmBaseMenuManager;
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , vtUtils
 , vcmBaseMenuManagerRes
 , l3ConstStrings
 , vcmExportConst
 , StrUtils
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
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
 {$If NOT Defined(NoScripts)}
 , kwEntityOperation
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwOperationsRegistrar
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , VCMWordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 , vcmEntitiesDefIteratorForContextMenu
;

{$If NOT Defined(NoVCL)}
type
 TControlFriend = {abstract} class(TControl)
  {* ���� � ������ TControl }
 end;//TControlFriend
{$IfEnd} // NOT Defined(NoVCL)

var g_TvcmPopupMenuHelper: TvcmPopupMenuHelper = nil;
 {* ��������� ���������� TvcmPopupMenuHelper }
var g_ShortcutProcessingEnabled: Boolean;
var g_FirstShortCutLoad: Boolean;

procedure TvcmPopupMenuHelperFree;
 {* ����� ������������ ���������� ���������� TvcmPopupMenuHelper }
begin
 l3Free(g_TvcmPopupMenuHelper);
end;//TvcmPopupMenuHelperFree

procedure ConstStringsToMenuManager;
//#UC START# *52A2012B01A7_4AB24EF502BB_var*
{$IfNDef DesignTimeLibrary}
var
 l_Index : Integer;
{$EndIf  DesignTimeLibrary}
//#UC END# *52A2012B01A7_4AB24EF502BB_var*
begin
//#UC START# *52A2012B01A7_4AB24EF502BB_impl*
 {$IfNDef DesignTimeLibrary}
 if Tl3ConstStrings.Exists then
 begin
  g_l3ConstStringsSealed := true;
  with Tl3ConstStrings.Instance do
  begin
   for l_Index := 0 to Hi do
    _DoInitConstString(Items[l_Index]^);
   Clear;  
  end;//with Tl3ConstStrings.Instance
 end;//Tl3ConstStrings.Exists

(* if (g_ConstStrings <> nil) then
 begin
  g_ConstStringsSealed := true;
  with g_ConstStrings do
   for l_Index := 0 to Hi do
     _DoInitConstString(Items[l_Index]^);
  FreeAndNil(g_ConstStrings);
 end;//g_ConstStrings <> nil*)
 {$EndIf  DesignTimeLibrary}
//#UC END# *52A2012B01A7_4AB24EF502BB_impl*
end;//ConstStringsToMenuManager

procedure _DoInitConstString(var anID: Tl3StringIDEx);
//#UC START# *52A1F94201E8_4AB24EF502BB_var*
{$IfNDef DesignTimeLibrary}
var
 l_Item : TvcmBaseCollectionItem;
{$EndIf  DesignTimeLibrary} 
//#UC END# *52A1F94201E8_4AB24EF502BB_var*
begin
//#UC START# *52A1F94201E8_4AB24EF502BB_impl*
 Assert((l3StrRefCount(anID.rKey) = -1));
 if not anID.rLocalized then
  Assert((l3StrRefCount(anID.rValue) = -1));
 {$IfDef DesignTimeLibrary}
 Assert(anID.rS = -1);
 anID.rS := Integer(@anID.rValue);
 {$Else  DesignTimeLibrary}
 if (g_MenuManager = nil) then
  Exit;
 with g_MenuManager.Strings do
 begin
  l_Item := FindItemByName(anID.rKey);
  if (l_Item = nil) then
  begin
   l_Item := TvcmBaseCollectionItem(Add);
   l_Item.Name := anID.rKey;
   l_Item.Caption := anID.rValue;
  end//l_Item = nil
  else
   Assert(l_Item.Caption = anID.rValue, '������������ ��������� ��������� ' + anID.rKey + ' ���� ������� �� ������');
  Assert((anID.rS = -1) or (anID.rS = l_Item.Index));
  anID.rS := l_Item.Index;
 end;//with g_MenuManager.Strings
 {$EndIf  DesignTimeLibrary}
//#UC END# *52A1F94201E8_4AB24EF502BB_impl*
end;//_DoInitConstString

procedure vcmStartupComplete;
//#UC START# *52A1F95A0358_4AB24EF502BB_var*
//#UC END# *52A1F95A0358_4AB24EF502BB_var*
begin
//#UC START# *52A1F95A0358_4AB24EF502BB_impl*
 g_ShortcutProcessingEnabled := True;
//#UC END# *52A1F95A0358_4AB24EF502BB_impl*
end;//vcmStartupComplete

procedure TvcmOperationManager.pm_SetOperation(aValue: TvcmBaseOperationsCollectionItem);
//#UC START# *52A6FBB20278_52A1D6020217set_var*
//#UC END# *52A6FBB20278_52A1D6020217set_var*
begin
//#UC START# *52A6FBB20278_52A1D6020217set_impl*
 f_Operation := aValue;
 { �������� ������� �������� }
 f_OldOnExecute := aValue.OnExecute;
 f_OldOnTest := aValue.OnTest;
 f_OldOnContextExecute := aValue.OnContextExecute;
 f_OldOnContextTest := aValue.OnContextTest;
 { �������� ����� �������� }
 aValue.OnExecute := OnExecute;
 aValue.OnTest := OnTest;
 aValue.OnContextExecute := OnContextExecute;
 aValue.OnContextTest := OnContextTest;
//#UC END# *52A6FBB20278_52A1D6020217set_impl*
end;//TvcmOperationManager.pm_SetOperation

procedure TvcmOperationManager.pm_SetFormActivate(aValue: TvcmFormActivate);
//#UC START# *52A6FBC9005C_52A1D6020217set_var*
//#UC END# *52A6FBC9005C_52A1D6020217set_var*
begin
//#UC START# *52A6FBC9005C_52A1D6020217set_impl*
 f_FormActivate := aValue;
 f_FormID.rName := aValue.Name;
//#UC END# *52A6FBC9005C_52A1D6020217set_impl*
end;//TvcmOperationManager.pm_SetFormActivate

constructor TvcmOperationManager.Create(const aForm: IvcmEntityForm;
 aFormActivate: TvcmFormActivate;
 aOperation: TvcmBaseOperationsCollectionItem);
//#UC START# *52A1D76D0351_52A1D6020217_var*
//#UC END# *52A1D76D0351_52A1D6020217_var*
begin
//#UC START# *52A1D76D0351_52A1D6020217_impl*
 inherited Create;
 f_Form := aForm;
 FormActivate := aFormActivate;
 Operation := aOperation;
//#UC END# *52A1D76D0351_52A1D6020217_impl*
end;//TvcmOperationManager.Create

procedure TvcmOperationManager.DoTest(const aParams: IvcmTestParamsPrim;
 aHandler: TvcmTestEvent);
 {* ��������� ������� � ���������� ����� }
//#UC START# *52A1D7950232_52A1D6020217_var*
var
 l_Form : IvcmEntityForm;
 l_Caption : IvcmCString;
//#UC END# *52A1D7950232_52A1D6020217_var*
begin
//#UC START# *52A1D7950232_52A1D6020217_impl*
 if not Assigned(aParams) then
  Exit;
 l_Caption := aParams.Op.Caption;
 { � ����� ������ ������� Hint �������� �������� }
 if (f_Form <> nil) and
    (f_Form.ZoneType = vcm_ztNavigator) then
  aParams.Op.Hint := vcmFmt(str_vcmShowTab.AsCStr, [l_Caption]);
 FindForm((aParams as IvcmTestParams).Container, @l_Form);
 if Assigned(l_Form) then
 try
//  �� ���������� �� ������ ����� ����� ������� ��� ��������
//  l_Caption := f_FormActivate.Caption;
//  if l_Form._VCLForm.Caption <> '' then
//   l_Caption := l_Form._VCLForm.Caption;
  aParams.Op.Flag[vcm_ofChecked] := l_Form.IsActiveInParent;

  if (l_Form.ZoneType = vcm_ztNavigator) then
  begin
   if aParams.Op.Flag[vcm_ofChecked] then
    if (l_Form.VCLWinControl as TvcmEntityForm).IsFloatingStateAndParentNotVisible then
     aParams.Op.Flag[vcm_ofChecked] := false;
   // - http://mdp.garant.ru/pages/viewpage.action?pageId=297703519  
   if aParams.Op.Flag[vcm_ofChecked] then
    aParams.Op.Hint := vcmFmt(str_vcmHideTab.AsCStr, [l_Caption])
   else
    aParams.Op.Hint := vcmFmt(str_vcmShowTab.AsCStr, [l_Caption]);
  end;//l_Form.ZoneType = vcm_ztNavigator
 finally
  l_Form := nil;
 end;//try..finally
 if Assigned(aHandler) then
  aHandler(aParams);
//#UC END# *52A1D7950232_52A1D6020217_impl*
end;//TvcmOperationManager.DoTest

procedure TvcmOperationManager.DoExecute(const aParams: IvcmExecuteParams;
 aHandler: TvcmExecuteEvent);
 {* �������� ����� ���� �������, ��� ���������� }
//#UC START# *52A1D7CA00CD_52A1D6020217_var*
var
 l_MenuItem: Boolean;

type
 TActivationResult = (arDontExists, arOpened, arClosed);

 function lp_IsFormFloatingAndParentNotVisible(const aForm: IvcmEntityForm): Boolean;
 begin
  Result := (aForm <> nil) and
            (aForm.VCLWinControl as TvcmEntityForm).IsFloatingStateAndParentNotVisible;
 end;//lp_IsFormFloatingAndParentNotVisible

 procedure lp_MakeFloatingFormVisible(const aForm: IvcmEntityForm);
 begin
  if (aForm <> nil) then
  begin
   (aForm.VCLWinControl as TvcmEntityForm).MakeFloatingParentVisible;
   aForm.SetActiveAndShowInParent;
  end;
 end;//lp_MakeFloatingFormVisible

 function lp_ActivateForm(const anAfterCreate: Boolean = False): TActivationResult;
 var
  l_Form: IvcmEntityForm;
 begin
  Result := arDontExists;
  FindForm(aParams.Container, @l_Form);
  if Assigned(l_Form) then
  try
   Result := arOpened;
   if anAfterCreate then
    l_Form.SetActiveAndShowInParent
   else
   if lp_IsFormFloatingAndParentNotVisible(l_Form) then
    lp_MakeFloatingFormVisible(l_Form)
   else
    if l_MenuItem then
     l_Form.SetActiveInParent
    else
     case f_FormActivate.RepeatedActivationBehaviour of
      { ������ ���������� }
      vcm_rabNone:
       l_Form.SetActiveAndShowInParent;
      { ��������� ���� ������� }
      vcm_rabClose:
       if l_Form.IsActiveInParent then
       begin
         l_Form.CloseInParent;
         Result := arClosed;
       end
       else
        l_Form.SetActiveAndShowInParent;
      vcm_rabInactivate:
       if l_Form.IsActiveInParent then
        l_Form.SetInactiveInParent
       else
        l_Form.SetActiveAndShowInParent;
      { �������� ���� �� �������, ������ ��������� �������� ���� �������}
      //http://mdp.garant.ru/pages/viewpage.action?pageId=515841696 
      vcm_rabJustExecuteIfActive:
       begin
        if not l_Form.IsActiveInParent then
         l_Form.SetActiveAndShowInParent;
        Result := arOpened;
       end;
     end;//case f_FormActivate.RepeatedActivationBehaviour of
   // ��� ��������� �������� ������������� � ��� ����� (CQ: OIT500021234):
   {$IfNDef DesignTimeLibrary}
   if Result = arOpened then
    vtFocusWinControlEx(l_Form.VCLWinControl);
   {$EndIf  DesignTimeLibrary}
  finally
   l_Form := nil;
  end;{try..finally}
 end;//lp_ActivateForm

var
 l_Form: IvcmEntityForm;
//#UC END# *52A1D7CA00CD_52A1D6020217_var*
begin
//#UC START# *52A1D7CA00CD_52A1D6020217_impl*
 // ����� ���������� �� ����������� ���� ������:
 l_MenuItem := (aParams.ItemIndex > 0) or (aParams.CurrentNode <> nil);
 // ���������� ������:
 case lp_ActivateForm of
  arOpened:
   if not f_FormActivate.DoExecuteIfExists and
      not l_MenuItem and
      not (f_FormActivate.RepeatedActivationBehaviour = vcm_rabJustExecuteIfActive) then
    Exit;
  arClosed:
   Exit;
 end;
 // Execute ��������:
 if Assigned(aHandler) then
 begin
  if FindForm(aParams.Container) then
  begin
   lp_ActivateForm(True);
   // - ������� ����������, ������ ��� � aHandler ����� ���� �������
   //   � ������������ ������ ����� � ������� �������� �� ���������;
   aHandler(aParams);
  end//if FindForm(aParams) then
  else
  begin
   aHandler(aParams);

   // - ����� ����� �� ���� ������� �� ����� �������, ����� ������������
   lp_ActivateForm(True);

   if FindForm(aParams.Container, @l_Form) then
   try
    if lp_IsFormFloatingAndParentNotVisible(l_Form) then
     lp_MakeFloatingFormVisible(l_Form);
   finally
    l_Form := nil;
   end;
   // - http://mdp.garant.ru/pages/viewpage.action?pageId=390585459
  end;//if FindForm(aParams) then
 end;//if Assigned(aHandler) then
//#UC END# *52A1D7CA00CD_52A1D6020217_impl*
end;//TvcmOperationManager.DoExecute

procedure TvcmOperationManager.OnTest(const aParams: IvcmTestParamsPrim);
 {* ��������� ������� � ���������� ����� }
//#UC START# *52A1D8080172_52A1D6020217_var*
//#UC END# *52A1D8080172_52A1D6020217_var*
begin
//#UC START# *52A1D8080172_52A1D6020217_impl*
 DoTest(aParams, f_OldOnTest);
//#UC END# *52A1D8080172_52A1D6020217_impl*
end;//TvcmOperationManager.OnTest

procedure TvcmOperationManager.OnExecute(const aParams: IvcmExecuteParams);
 {* �������� ����� ���� �������, ��� ���������� }
//#UC START# *52A1D8460273_52A1D6020217_var*
//#UC END# *52A1D8460273_52A1D6020217_var*
begin
//#UC START# *52A1D8460273_52A1D6020217_impl*
 DoExecute(aParams, f_OldOnExecute);
//#UC END# *52A1D8460273_52A1D6020217_impl*
end;//TvcmOperationManager.OnExecute

procedure TvcmOperationManager.OnContextTest(const aParams: IvcmTestParamsPrim);
 {* ��������� ������� � ���������� ����� }
//#UC START# *52A1D8630372_52A1D6020217_var*
var
 l_OnTestEvent: TvcmTestEvent;
//#UC END# *52A1D8630372_52A1D6020217_var*
begin
//#UC START# *52A1D8630372_52A1D6020217_impl*
 // http://mdp.garant.ru/pages/viewpage.action?pageId=482148811
 l_OnTestEvent := nil;
 if Assigned(f_OldOnContextTest) then
  l_OnTestEvent := f_OldOnContextTest
 else
 if Assigned(f_OldOnTest) then
  l_OnTestEvent := f_OldOnTest;
 DoTest(aParams, l_OnTestEvent);
//#UC END# *52A1D8630372_52A1D6020217_impl*
end;//TvcmOperationManager.OnContextTest

procedure TvcmOperationManager.OnContextExecute(const aParams: IvcmExecuteParams);
 {* �������� ����� ���� �������, ��� ���������� }
//#UC START# *52A1D87D00CD_52A1D6020217_var*
var
 l_OnExecuteEvent: TvcmExecuteEvent;
//#UC END# *52A1D87D00CD_52A1D6020217_var*
begin
//#UC START# *52A1D87D00CD_52A1D6020217_impl*
 // http://mdp.garant.ru/pages/viewpage.action?pageId=482148811
 l_OnExecuteEvent := nil;
 if Assigned(f_OldOnContextExecute) then
  l_OnExecuteEvent := f_OldOnContextExecute
 else
 if Assigned(f_OldOnExecute) then
  l_OnExecuteEvent := f_OldOnExecute;
 DoExecute(aParams, l_OnExecuteEvent);
//#UC END# *52A1D87D00CD_52A1D6020217_impl*
end;//TvcmOperationManager.OnContextExecute

function TvcmOperationManager.FindForm(const aParams: IvcmContainer;
 theForm: PIvcmEntityForm = nil): Boolean;
 {* ���� ����� � ���������� ��������� ���������� ���� FormActivate }
//#UC START# *52A1D8A90263_52A1D6020217_var*
//#UC END# *52A1D8A90263_52A1D6020217_var*
begin
//#UC START# *52A1D8A90263_52A1D6020217_impl*
 if Assigned(theForm) then
  theForm^ := nil;
 Result := False;
 if (aParams <> nil) then
  Result := aParams.NativeMainForm.HasForm(f_FormID,
   f_FormActivate.ZoneType, True, theForm, f_FormActivate.UserType);
//#UC END# *52A1D8A90263_52A1D6020217_impl*
end;//TvcmOperationManager.FindForm

procedure TvcmOperationManager.Cleanup;
 {* ������� ������� ����� �������. }
//#UC START# *479731C50290_52A1D6020217_var*
//#UC END# *479731C50290_52A1D6020217_var*
begin
//#UC START# *479731C50290_52A1D6020217_impl*
 if Assigned(f_Form) then
 begin
  if Assigned(f_Operation.OnTest) then
   f_Operation.OnTest := f_OldOnTest;
  if Assigned(f_Operation.OnExecute) then
   f_Operation.OnExecute := f_OldOnExecute;
  if Assigned(f_Operation.OnContextTest) then
   f_Operation.OnContextTest := f_OldOnContextTest;
  if Assigned(f_Operation.OnContextExecute) then
   f_Operation.OnContextExecute := f_OldOnContextExecute;
  f_Form := nil;
 end;
 inherited;
//#UC END# *479731C50290_52A1D6020217_impl*
end;//TvcmOperationManager.Cleanup

procedure TvcmOperationManager.ClearFields;
begin
 f_Form := nil;
 inherited;
end;//TvcmOperationManager.ClearFields

function TvcmOperationManagers.pm_GetCount: Integer;
//#UC START# *52A6FC8B021D_52A1DD06008Fget_var*
//#UC END# *52A6FC8B021D_52A1DD06008Fget_var*
begin
//#UC START# *52A6FC8B021D_52A1DD06008Fget_impl*
 {$IfNDef DesignTimeLibrary}
 Result := f_Managers.Count;
 {$Else  DesignTimeLibrary}
 Result := 0;
 {$EndIf DesignTimeLibrary}
//#UC END# *52A6FC8B021D_52A1DD06008Fget_impl*
end;//TvcmOperationManagers.pm_GetCount

function TvcmOperationManagers.pm_GetItems(anIndex: Integer): TvcmOperationManager;
//#UC START# *52A6FC9C0200_52A1DD06008Fget_var*
//#UC END# *52A6FC9C0200_52A1DD06008Fget_var*
begin
//#UC START# *52A6FC9C0200_52A1DD06008Fget_impl*
 {$IfNDef DesignTimeLibrary}
 Result := TvcmOperationManager(f_Managers.Items[anIndex]);
 {$Else  DesignTimeLibrary}
 Result := nil;
 {$EndIf DesignTimeLibrary}
//#UC END# *52A6FC9C0200_52A1DD06008Fget_impl*
end;//TvcmOperationManagers.pm_GetItems

constructor TvcmOperationManagers.Create;
//#UC START# *52A1DDD400EE_52A1DD06008F_var*
//#UC END# *52A1DDD400EE_52A1DD06008F_var*
begin
//#UC START# *52A1DDD400EE_52A1DD06008F_impl*
 inherited Create;
 {$IfNDef DesignTimeLibrary}
 f_Managers := Tl3ProtoObjectRefList.Make;
 {$EndIf DesignTimeLibrary}
//#UC END# *52A1DDD400EE_52A1DD06008F_impl*
end;//TvcmOperationManagers.Create

procedure TvcmOperationManagers.Add(aManager: TvcmOperationManager);
//#UC START# *52A6FCF10268_52A1DD06008F_var*
//#UC END# *52A6FCF10268_52A1DD06008F_var*
begin
//#UC START# *52A6FCF10268_52A1DD06008F_impl*
 {$IfNDef DesignTimeLibrary}
 f_Managers.Add(aManager);
 {$EndIf DesignTimeLibrary}
//#UC END# *52A6FCF10268_52A1DD06008F_impl*
end;//TvcmOperationManagers.Add

procedure TvcmOperationManagers.Delete(const aForm: IvcmEntityForm);
//#UC START# *52A6FD0E01FE_52A1DD06008F_var*
var
 l_Index : Integer;
//#UC END# *52A6FD0E01FE_52A1DD06008F_var*
begin
//#UC START# *52A6FD0E01FE_52A1DD06008F_impl*
 {$IfNDef DesignTimeLibrary}
 for l_Index := Pred(f_Managers.Count) downto 0 do
  if Items[l_Index].Form = aForm then
   f_Managers.Delete(l_Index);
 {$EndIf DesignTimeLibrary}
//#UC END# *52A6FD0E01FE_52A1DD06008F_impl*
end;//TvcmOperationManagers.Delete

procedure TvcmOperationManagers.Cleanup;
 {* ������� ������� ����� �������. }
//#UC START# *479731C50290_52A1DD06008F_var*
//#UC END# *479731C50290_52A1DD06008F_var*
begin
//#UC START# *479731C50290_52A1DD06008F_impl*
 {$IfNDef DesignTimeLibrary}
 vcmFree(f_Managers);
 {$EndIf DesignTimeLibrary}
 inherited;
//#UC END# *479731C50290_52A1DD06008F_impl*
end;//TvcmOperationManagers.Cleanup

function TvcmFormActivateOperations.pm_GetCount: Integer;
//#UC START# *52A6FAA300CC_52A1DDF20272get_var*
//#UC END# *52A6FAA300CC_52A1DDF20272get_var*
begin
//#UC START# *52A6FAA300CC_52A1DDF20272get_impl*
 Result := f_Operations.Count;
//#UC END# *52A6FAA300CC_52A1DDF20272get_impl*
end;//TvcmFormActivateOperations.pm_GetCount

function TvcmFormActivateOperations.pm_GetItems(anIndex: Integer): TvcmBaseOperationsCollectionItem;
//#UC START# *52A6FAB70156_52A1DDF20272get_var*
//#UC END# *52A6FAB70156_52A1DDF20272get_var*
begin
//#UC START# *52A6FAB70156_52A1DDF20272get_impl*
 Result := TvcmBaseOperationsCollectionItem(f_Operations[anIndex]);
//#UC END# *52A6FAB70156_52A1DDF20272get_impl*
end;//TvcmFormActivateOperations.pm_GetItems

constructor TvcmFormActivateOperations.Create;
//#UC START# *52A1DE69039A_52A1DDF20272_var*
//#UC END# *52A1DE69039A_52A1DDF20272_var*
begin
//#UC START# *52A1DE69039A_52A1DDF20272_impl*
 inherited Create;
 f_IsEntitiesLoad := False;
 f_IsModulesLoad := False;
 //g_MenuManager := aMenuManager;
 Assert(Assigned(g_MenuManager));
 {$IfNDef DesignTimeLibrary}
 f_Operations := TvcmObjectList.Make;
 {$EndIf DesignTimeLibrary}
//#UC END# *52A1DE69039A_52A1DDF20272_impl*
end;//TvcmFormActivateOperations.Create

function TvcmFormActivateOperations.GetFormActivate(aOperation: TvcmBaseOperationsCollectionItem): TvcmFormActivate;
 {* ���������� FormActivate, ���� �������� �������� �� ���������� ������ }
//#UC START# *52A1DE8F0369_52A1DDF20272_var*

  function CheckOwnersAndNames(aDest, aSource : TvcmBaseOperationsCollectionItem) : Boolean;
  begin//CheckOwnersAndNames
   Result := False;
   { �������� ������ }
   if (aSource.Collection.Owner is TvcmModulesCollectionItem) and
    (TvcmCustomModuleDef(aDest.Collection.Owner).Owner is TvcmModule) then
   begin
    Assert(TvcmCustomModuleDef(aDest.Collection.Owner).Owner Is TvcmModule);
    Result :=
     (TvcmModulesCollectionItem(aSource.Collection.Owner).Name + aSource.Name) =
     (TvcmModule(TvcmCustomModuleDef(aDest.Collection.Owner).Owner).Name + aDest.Name);
   end//aSource.Collection.Owner is TvcmModulesCollectionItem..
   { �������� �������� }
   else
   if (aSource.Collection.Owner is TvcmRepEntitiesCollectionItem) then
   begin
    if (aDest.Collection.Owner Is TvcmCustomModuleDef) then
    begin
     Assert(TvcmCustomModuleDef(aDest.Collection.Owner).Owner Is TvcmModule);
     Result :=
      (TvcmModule(TvcmCustomModuleDef(aDest.Collection.Owner).Owner).Name + aDest.Name) =
      (TvcmRepEntitiesCollectionItem(aSource.Collection.Owner).Name + aSource.Name);
    end//aDest.Collection.Owner Is TvcmCustomModuleDef
    else
    begin
     Assert(aDest.Collection.Owner Is TvcmBaseEntitiesCollectionItem);
     Result :=
      (TvcmBaseEntitiesCollectionItem(aDest.Collection.Owner).Name + aDest.Name) =
      (TvcmRepEntitiesCollectionItem(aSource.Collection.Owner).Name + aSource.Name);
    end;//aDest.Collection.Owner Is TvcmCustomModuleDef
   end;//aSource.Collection.Owner is TvcmRepEntitiesCollectionItem
  end;//CheckOwnersAndNames

var
 l_Index : Integer;
//#UC END# *52A1DE8F0369_52A1DDF20272_var*
begin
//#UC START# *52A1DE8F0369_52A1DDF20272_impl*
 Result := nil;

 { �������� �������� ���� ��� �� ���� ��������� }
 LoadOperations;

 { �������� �������� �� �������� �� ���������� ������ }
 for l_Index := 0 to Pred(f_Operations.Count) do
 begin
  if CheckOwnersAndNames(aOperation,
   TvcmBaseOperationsCollectionItem(f_Operations[l_Index])) then
  begin
   Result := TvcmRepOperationsCollectionItem(f_Operations[l_Index]).FormActivate;
   Break;
  end;//CheckOwnersAndNames(aOperation,..
 end;//for l_Index
//#UC END# *52A1DE8F0369_52A1DDF20272_impl*
end;//TvcmFormActivateOperations.GetFormActivate

procedure TvcmFormActivateOperations.AddOperation(aOperation: TvcmRepOperationsCollectionItem);
 {* ��������� � ������ �������� ���������� �� ���������� ������ }
//#UC START# *52A1DEB300EC_52A1DDF20272_var*
//#UC END# *52A1DEB300EC_52A1DDF20272_var*
begin
//#UC START# *52A1DEB300EC_52A1DDF20272_impl*
 if aOperation.IsFormActivateDefined then
  f_Operations.Add(aOperation);
//#UC END# *52A1DEB300EC_52A1DDF20272_impl*
end;//TvcmFormActivateOperations.AddOperation

procedure TvcmFormActivateOperations.LoadOperations;
//#UC START# *52A1DF8C0277_52A1DDF20272_var*
var
 I, J : Integer;
 l_Module : TvcmBaseEntitiesCollectionItem;
 l_Entity : TvcmBaseEntitiesCollectionItem;
//#UC END# *52A1DF8C0277_52A1DDF20272_var*
begin
//#UC START# *52A1DF8C0277_52A1DDF20272_impl*
 { �������������� �������� ������� }
 if not f_IsModulesLoad then
 begin
  f_IsModulesLoad := (g_MenuManager.Modules.Count > 0);
  for I := 0 to Pred(g_MenuManager.Modules.Count) do
  begin
   l_Module := TvcmBaseEntitiesCollectionItem(g_MenuManager.Modules.Items[I]);
   for J := 0 to Pred(l_Module.Operations.Count) do
    AddOperation(TvcmRepOperationsCollectionItem(l_Module.Operations.Items[J]));
  end;//for I
 end;//not f_IsModulesLoad

 { �������������� �������� ��������� }
 if not f_IsEntitiesLoad then
 begin
  f_IsEntitiesLoad := (g_MenuManager.Entities.Count > 0);
  for I := 0 to Pred(g_MenuManager.Entities.Count) do
  begin
   l_Entity := TvcmBaseEntitiesCollectionItem(g_MenuManager.Entities.Items[I]);
   for J := 0 to Pred(l_Entity.Operations.Count) do
    AddOperation(TvcmRepOperationsCollectionItem(l_Entity.operations.Items[J]));
  end;
 end;
//#UC END# *52A1DF8C0277_52A1DDF20272_impl*
end;//TvcmFormActivateOperations.LoadOperations

procedure TvcmFormActivateOperations.Cleanup;
 {* ������� ������� ����� �������. }
//#UC START# *479731C50290_52A1DDF20272_var*
//#UC END# *479731C50290_52A1DDF20272_var*
begin
//#UC START# *479731C50290_52A1DDF20272_impl*
 vcmFree(f_Operations);
 inherited;
//#UC END# *479731C50290_52A1DDF20272_impl*
end;//TvcmFormActivateOperations.Cleanup

function TvcmFormActivateManager.pm_GetItems(anIndex: Integer): TvcmOperationManager;
//#UC START# *52A6FB31009B_52A1D5F50368get_var*
//#UC END# *52A6FB31009B_52A1D5F50368get_var*
begin
//#UC START# *52A6FB31009B_52A1D5F50368get_impl*
 Result := f_Managers[anIndex];
//#UC END# *52A6FB31009B_52A1D5F50368get_impl*
end;//TvcmFormActivateManager.pm_GetItems

function TvcmFormActivateManager.pm_GetCount: Integer;
//#UC START# *52A6FB4F0160_52A1D5F50368get_var*
//#UC END# *52A6FB4F0160_52A1D5F50368get_var*
begin
//#UC START# *52A6FB4F0160_52A1D5F50368get_impl*
 Result := f_Managers.Count;
//#UC END# *52A6FB4F0160_52A1D5F50368get_impl*
end;//TvcmFormActivateManager.pm_GetCount

constructor TvcmFormActivateManager.Create;
//#UC START# *52A1E4770365_52A1D5F50368_var*
//#UC END# *52A1E4770365_52A1D5F50368_var*
begin
//#UC START# *52A1E4770365_52A1D5F50368_impl*
 inherited Create;
 f_Managers := TvcmOperationManagers.Create;
 f_Operations := TvcmFormActivateOperations.Create;
//#UC END# *52A1E4770365_52A1D5F50368_impl*
end;//TvcmFormActivateManager.Create

procedure TvcmFormActivateManager.AddForm(const aForm: IvcmEntityForm);
 {* ������������ �������� ��������� }
//#UC START# *52A1E48D0308_52A1D5F50368_var*
var
 I, J : Integer;
 l_Entities : TvcmBaseEntitiesCollection;
 l_Entity : TvcmBaseEntitiesCollectionItem;
//#UC END# *52A1E48D0308_52A1D5F50368_var*
begin
//#UC START# *52A1E48D0308_52A1D5F50368_impl*
 l_Entities := (aForm.VCLWinControl as TvcmEntityForm).Entities.Entities;
 { �������� ����� }
 for I := 0 to Pred(l_Entities.Count) do
 begin
  l_Entity := TvcmBaseEntitiesCollectionItem(l_Entities.Items[I]);
  { �������� �������� }
  for J := 0 to Pred(l_Entity.Operations.Count) do
   { ������������� �������� }
   RegOperation(TvcmBaseOperationsCollectionItem(l_Entity.Operations.Items[J]), aForm);
 end;
//#UC END# *52A1E48D0308_52A1D5F50368_impl*
end;//TvcmFormActivateManager.AddForm

procedure TvcmFormActivateManager.RemoveForm(const aForm: IvcmEntityForm);
 {* ��� �������� ����� ������� ��������� TvcmOperationManager-� }
//#UC START# *52A1E4AA035B_52A1D5F50368_var*
//#UC END# *52A1E4AA035B_52A1D5F50368_var*
begin
//#UC START# *52A1E4AA035B_52A1D5F50368_impl*
 f_Managers.Delete(aForm);
//#UC END# *52A1E4AA035B_52A1D5F50368_impl*
end;//TvcmFormActivateManager.RemoveForm

procedure TvcmFormActivateManager.AddModule(aModule: TvcmModule);
 {* ������������ �������� ������ }
//#UC START# *52A1E4DC01BE_52A1D5F50368_var*
var
 l_Index : Integer;
 l_ModuleDef : TvcmCustomModuleDef;
//#UC END# *52A1E4DC01BE_52A1D5F50368_var*
begin
//#UC START# *52A1E4DC01BE_52A1D5F50368_impl*
 l_ModuleDef := aModule.ModuleDef;
 { �������������� �������� ������ }
 if Assigned(l_ModuleDef) then
  for l_Index := 0 to Pred(l_ModuleDef.Operations.Count) do
   RegOperation(TvcmBaseOperationsCollectionItem(l_ModuleDef.Operations.
    Items[l_Index]), nil);
//#UC END# *52A1E4DC01BE_52A1D5F50368_impl*
end;//TvcmFormActivateManager.AddModule

procedure TvcmFormActivateManager.RegOperation(aOperation: TvcmBaseOperationsCollectionItem;
 const aForm: IvcmEntityForm);
 {* ���� ������ �������� �������� �� ���������� ������, �� �������� FormActivate � TvcmFormActivateOperations � ������ TvcmOperationManager }
//#UC START# *52A1E4FC035C_52A1D5F50368_var*
var
 l_Form : TvcmFormActivate;
 l_Mgr : TvcmOperationManager;
//#UC END# *52A1E4FC035C_52A1D5F50368_var*
begin
//#UC START# *52A1E4FC035C_52A1D5F50368_impl*
 {$IfNDef DesignTimeLibrary}
 { ��������� �������� �� ��� �������� �� ���������� ������ }
 l_Form := f_Operations.GetFormActivate(aOperation);
 { ������� ��������� }
 if Assigned(l_Form) then
 begin
  l_Mgr := TvcmOperationManager.Create(aForm, l_Form, aOperation);
  try
   f_Managers.Add(l_Mgr);
  finally
   vcmFree(l_Mgr);
  end;//l_Mgr := TvcmOperationManager.
 end;//Assigned(l_Form)
 {$EndIf DesignTimeLibrary}
//#UC END# *52A1E4FC035C_52A1D5F50368_impl*
end;//TvcmFormActivateManager.RegOperation

procedure TvcmFormActivateManager.Cleanup;
 {* ������� ������� ����� �������. }
//#UC START# *479731C50290_52A1D5F50368_var*
//#UC END# *479731C50290_52A1D5F50368_var*
begin
//#UC START# *479731C50290_52A1D5F50368_impl*
 vcmFree(f_Managers);
 vcmFree(f_Operations);
 inherited;
//#UC END# *479731C50290_52A1D5F50368_impl*
end;//TvcmFormActivateManager.Cleanup

procedure TvcmBaseMenuManagerPrim.pm_SetStrings(aValue: TvcmStringCollection);
//#UC START# *52A6F87B015A_4AD5DBBD0147set_var*
//#UC END# *52A6F87B015A_4AD5DBBD0147set_var*
begin
//#UC START# *52A6F87B015A_4AD5DBBD0147set_impl*
 f_Strings.Assign(aValue);
//#UC END# *52A6F87B015A_4AD5DBBD0147set_impl*
end;//TvcmBaseMenuManagerPrim.pm_SetStrings

{$If Defined(DesignTimeLibrary)}
function TvcmBaseMenuManagerPrim.pm_GetUnitName: AnsiString;
//#UC START# *52A6F8EB0138_4AD5DBBD0147get_var*
var
 l_TI : PTypeData;
//#UC END# *52A6F8EB0138_4AD5DBBD0147get_var*
begin
//#UC START# *52A6F8EB0138_4AD5DBBD0147get_impl*
 if (Owner = nil) then
  Result := ''
 else 
 begin
  l_TI := GetTypeData(Owner.ClassInfo);
  Result := l_TI.UnitName;
 end;//Owner <> nil
//#UC END# *52A6F8EB0138_4AD5DBBD0147get_impl*
end;//TvcmBaseMenuManagerPrim.pm_GetUnitName
{$IfEnd} // Defined(DesignTimeLibrary)

function TvcmBaseMenuManagerPrim.pm_GetModules: TvcmModulesCollection;
//#UC START# *52A6F909022C_4AD5DBBD0147get_var*
//#UC END# *52A6F909022C_4AD5DBBD0147get_var*
begin
//#UC START# *52A6F909022C_4AD5DBBD0147get_impl*
 Result := f_Modules;
//#UC END# *52A6F909022C_4AD5DBBD0147get_impl*
end;//TvcmBaseMenuManagerPrim.pm_GetModules

procedure TvcmBaseMenuManagerPrim.pm_SetModules(aValue: TvcmModulesCollection);
//#UC START# *52A6F909022C_4AD5DBBD0147set_var*
//#UC END# *52A6F909022C_4AD5DBBD0147set_var*
begin
//#UC START# *52A6F909022C_4AD5DBBD0147set_impl*
 f_Modules.Assign(aValue);
//#UC END# *52A6F909022C_4AD5DBBD0147set_impl*
end;//TvcmBaseMenuManagerPrim.pm_SetModules

procedure TvcmBaseMenuManagerPrim.pm_SetAppForms(aValue: TvcmFormsCollection);
//#UC START# *52A6F92B0035_4AD5DBBD0147set_var*
//#UC END# *52A6F92B0035_4AD5DBBD0147set_var*
begin
//#UC START# *52A6F92B0035_4AD5DBBD0147set_impl*
 f_AppForms.Assign(aValue);
//#UC END# *52A6F92B0035_4AD5DBBD0147set_impl*
end;//TvcmBaseMenuManagerPrim.pm_SetAppForms

procedure TvcmBaseMenuManagerPrim.pm_SetMessages(aValue: TvcmMessagesCollection);
//#UC START# *52A6F9410290_4AD5DBBD0147set_var*
//#UC END# *52A6F9410290_4AD5DBBD0147set_var*
begin
//#UC START# *52A6F9410290_4AD5DBBD0147set_impl*
 f_Messages.Assign(aValue);
//#UC END# *52A6F9410290_4AD5DBBD0147set_impl*
end;//TvcmBaseMenuManagerPrim.pm_SetMessages

procedure TvcmBaseMenuManagerPrim.pm_SetSmallImages(aValue: TCustomImageList);
//#UC START# *52A6F96303A9_4AD5DBBD0147set_var*
//#UC END# *52A6F96303A9_4AD5DBBD0147set_var*
begin
//#UC START# *52A6F96303A9_4AD5DBBD0147set_impl*
 if f_SmallImages <> nil then
  f_SmallImages.RemoveFreeNotification(Self);
 f_SmallImages := aValue;
 if f_SmallImages <> nil then
  f_SmallImages.FreeNotification(Self);
//#UC END# *52A6F96303A9_4AD5DBBD0147set_impl*
end;//TvcmBaseMenuManagerPrim.pm_SetSmallImages

procedure TvcmBaseMenuManagerPrim.pm_SetLargeImages(aValue: TCustomImageList);
//#UC START# *52A6F97B01E6_4AD5DBBD0147set_var*
//#UC END# *52A6F97B01E6_4AD5DBBD0147set_var*
begin
//#UC START# *52A6F97B01E6_4AD5DBBD0147set_impl*
 if f_LargeImages <> nil then
  f_LargeImages.RemoveFreeNotification(Self);
 f_LargeImages := aValue;
 if f_LargeImages <> nil then
  f_LargeImages.FreeNotification(Self);
//#UC END# *52A6F97B01E6_4AD5DBBD0147set_impl*
end;//TvcmBaseMenuManagerPrim.pm_SetLargeImages

{$If Defined(DesignTimeLibrary)}
function TvcmBaseMenuManagerPrim.pm_GetModule: IOTAModule;
//#UC START# *52A6F9FB00AD_4AD5DBBD0147get_var*
//#UC END# *52A6F9FB00AD_4AD5DBBD0147get_var*
begin
//#UC START# *52A6F9FB00AD_4AD5DBBD0147get_impl*
 Result := nil;
// Result := f_Modules;
//#UC END# *52A6F9FB00AD_4AD5DBBD0147get_impl*
end;//TvcmBaseMenuManagerPrim.pm_GetModule
{$IfEnd} // Defined(DesignTimeLibrary)

{$If Defined(DesignTimeLibrary)}
function TvcmBaseMenuManagerPrim.pm_GetEditor: IOTAEditor;
//#UC START# *52A6FA110112_4AD5DBBD0147get_var*
var
 l_MS : IOTAModuleServices;
 l_M : IOTAModule;
//#UC END# *52A6FA110112_4AD5DBBD0147get_var*
begin
//#UC START# *52A6FA110112_4AD5DBBD0147get_impl*
 l_MS := vcmGetTAModules;
 if (l_MS <> nil) then
  try
   l_M := l_MS.CurrentModule;
   if (l_M <> nil) then
   begin
    Result := l_M.CurrentEditor;
   end;//l_M <> nil
  finally
   l_MS := nil;
  end;//try..finally
//#UC END# *52A6FA110112_4AD5DBBD0147get_impl*
end;//TvcmBaseMenuManagerPrim.pm_GetEditor
{$IfEnd} // Defined(DesignTimeLibrary)

{$If Defined(DesignTimeLibrary)}
function TvcmBaseMenuManagerPrim.pm_GetSourceEditor: IOTASourceEditor;
//#UC START# *52A6FA2F011A_4AD5DBBD0147get_var*
var
 l_M : IOTAModule;
 l_Index : Integer;
//#UC END# *52A6FA2F011A_4AD5DBBD0147get_var*
begin
//#UC START# *52A6FA2F011A_4AD5DBBD0147get_impl*
 Result := nil;
 l_M := Module;
 if (l_M <> nil) then
 begin
  for l_Index := 0 to Pred(l_M.ModuleFileCount) do
   if Supports(l_M.ModuleFileEditors[l_Index], IOTASourceEditor, Result) then
    Exit;
 end;//l_M <> nil
//#UC END# *52A6FA2F011A_4AD5DBBD0147get_impl*
end;//TvcmBaseMenuManagerPrim.pm_GetSourceEditor
{$IfEnd} // Defined(DesignTimeLibrary)

function TvcmBaseMenuManagerPrim.pm_GetMenuItemClickListeners: TvcmMenuItemClickListenerList;
//#UC START# *53E9DE6F0274_4AD5DBBD0147get_var*
//#UC END# *53E9DE6F0274_4AD5DBBD0147get_var*
begin
//#UC START# *53E9DE6F0274_4AD5DBBD0147get_impl*
 if (f_MenuItemClickListeners = nil) then
  f_MenuItemClickListeners := TvcmMenuItemClickListenerList.Create;
 Result := f_MenuItemClickListeners;
//#UC END# *53E9DE6F0274_4AD5DBBD0147get_impl*
end;//TvcmBaseMenuManagerPrim.pm_GetMenuItemClickListeners

{$If Defined(DesignTimeLibrary)}
procedure TvcmBaseMenuManagerPrim.WriteRes;
//#UC START# *52A1FA92012A_4AD5DBBD0147_var*
const
 c_En = 'en';
 c_Mo = 'mo';
 c_Mo1 = 'mo_';
 c_Op = 'op';
 c_Fs = 'fs';
 c_Fs1 = 'fs_';
 c_ST = 'st';

 function CutPrefix(const aPrefix : AnsiString;
                    const aValue : AnsiString;
                    out   theResult : AnsiString) : Boolean;
 begin
  if AnsiStartsText(aPrefix, aValue) then
   theResult := Copy(aValue, Length(aPrefix) + 1, Length(aValue) - Length(aPrefix))
  else
   theResult := aValue;
  Result := aValue <> theResult;
 end;

 function CEN(const aEN : AnsiString) : AnsiString;
 begin
  CutPrefix(c_En, aEN, Result);
 end;

 function CMo(const aEN: AnsiString): AnsiString;
 begin
  if not CutPrefix(c_Mo1, aEN, Result) then
   CutPrefix(c_Mo, aEN, Result);
 end;

 function COP(const aOP: AnsiString): AnsiString;
 begin
  CutPrefix(c_Op, aOP, Result);
 end;

 function CFS(const aFsf : AnsiString) : AnsiString;
 begin
  if not CutPrefix(c_Fs1, aFsf, Result) then
   CutPrefix(c_Fs, aFsf, Result);
 end;

 function CST(const aSt: AnsiString): AnsiString;
 begin
  CutPrefix(c_St, aSt, Result);
 end;

const
  cVCMStart = 'const // start VCM generated section';
  cImplementation = 'implementation';

var
 l_SE : IOTASourceEditor;

 function MakeFile: TFileName;
 var
  l_F : TFileStream;

  procedure WriteLn(const aText: AnsiString = '');
  const
    cEOL = #13#10;
  begin
   if (aText <> '') then
    l_F.Write(aText[1], Length(aText));
   l_F.Write(cEOL[1], Length(cEOL));
  end;

 const
   cVCMEnd = '// end VCM generated section';

 var
  l_EIndex : Integer;
  l_OIndex : Integer;
  l_SIndex : Integer;
  l_Index : Integer;
  l_En : TvcmRepEntitiesCollectionItem;
  l_EnN : AnsiString;
  l_Op : TvcmRepOperationsCollectionItem;
  l_OpN : AnsiString;
  //l_State : TvcmBaseOperationState;
  l_StateN : AnsiString;
  l_Form : TvcmFormsCollectionItem;
  l_Message : TvcmMessagesCollectionItem;
  l_Str : TvcmBaseCollectionItem;
  l_Pref : AnsiString;
 begin
  Result := ChangeFileExt(l_SE.FileName, '.vcm.tmp');
  l_F := TFileStream.Create(Result, fmCreate);
  try
   WriteLn;
   WriteLn(cVCMStart);
   //WriteLn('{$WriteableConst On}');

(*   for l_EIndex := 0 to Pred(Entities.Count) do
   begin
    l_En := TvcmRepEntitiesCollectionItem(Entities.Items[l_EIndex]);
    l_EnN := CEN(l_En.Name);
    if (l_En.Operations <> nil) then
    begin
     for l_OIndex := 0 to Pred(l_En.Operations.Count) do
     begin
      l_Op := TvcmRepOperationsCollectionItem(l_En.Operations.Items[l_OIndex]);
      l_OpN := COP(l_Op.Name);
      if (l_Op.OperationType in vcm_HiddenOperations) then
       continue
       //WriteLn(Format('  xxCxx_op_%s_%s : TvcmOPID = (rEnID : %d; rOpID : %d);', [l_EnN, l_OpN, Succ(l_EIndex), Succ(l_OIndex)]))
      else
       WriteLn(Format('  xxCxx_op_user_%s_%s : TvcmOPID = (rEnID : %d; rOpID : %d);', [l_EnN, l_OpN, Succ(l_EIndex), Succ(l_OIndex)]));
      WriteLn(Format('   // %s -> %s', [l_En.Caption, l_Op.Caption]));
     end;//for l_OIndex
    end;//l_En.Operations <> nil
   end;//for l_EIndex*)

(*   for l_EIndex := 0 to Pred(Modules.Count) do
   begin
    l_En := TvcmRepEntitiesCollectionItem(Modules.Items[l_EIndex]);
    l_EnN := CMo(l_En.Name);
    if (l_En.Operations <> nil) then
    begin
     for l_OIndex := 0 to Pred(l_En.Operations.Count) do
     begin
      l_Op := TvcmRepOperationsCollectionItem(l_En.Operations.Items[l_OIndex]);
      l_OpN := COP(l_Op.Name);
      if (l_Op.OperationType in vcm_HiddenOperations) then
       WriteLn(Format('  mop_%s_%s : TvcmMOPID = (rMoID : %d; rOpID : %d);', [l_EnN, l_OpN, Succ(l_EIndex), Succ(l_OIndex)]))
      else
       WriteLn(Format('  mop_user_%s_%s : TvcmMOPID = (rMoID : %d; rOpID : %d);', [l_EnN, l_OpN, Succ(l_EIndex), Succ(l_OIndex)]));
      WriteLn(Format('   // %s -> %s', [l_En.Caption, l_Op.Caption]));
     end;//for l_OIndex
    end;//l_En.Operations <> nil
   end;//for l_EIndex*)

(*   for l_EIndex := 0 to Pred(Entities.Count) do
   begin
    l_En := TvcmRepEntitiesCollectionItem(Entities.Items[l_EIndex]);
    l_EnN := CEN(l_En.Name);
    if (l_En.Operations <> nil) then
    begin
     for l_OIndex := 0 to Pred(l_En.Operations.Count) do
     begin
      l_Op := TvcmRepOperationsCollectionItem(l_En.Operations.Items[l_OIndex]);
      l_OpN := COP(l_Op.Name);
      for l_SIndex := 0 to Pred(l_Op.States.Count) do
      begin
       l_State := TvcmBaseOperationState(l_Op.States.Items[l_SIndex]);
       l_StateN := CST(l_State.Name);
       if l_StateN = '' then
        l_StateN := IntToStr(l_SIndex);
       if (l_Op.OperationType in vcm_HiddenOperations) then
        WriteLn(Format('  st_%s_%s_%s : TvcmOperationStateIndex = (_rID : %d);', [l_EnN, l_OpN, l_StateN, l_SIndex]))
       else
        WriteLn(Format('  st_user_%s_%s_%s : TvcmOperationStateIndex = (_rID : %d);', [l_EnN, l_OpN, l_StateN, l_SIndex]));
       WriteLn(Format('   // %s -> %s <-> %s', [l_En.Caption, l_Op.Caption, l_State.Caption]));
      end;//for l_SIndex
     end;//for l_OIndex
    end;//l_En.Operations <> nil
   end;//for l_EIndex

   for l_EIndex := 0 to Pred(Modules.Count) do
   begin
    l_En := TvcmRepEntitiesCollectionItem(Modules.Items[l_EIndex]);
    l_EnN := CMo(l_En.Name);
    if (l_En.Operations <> nil) then
    begin
     for l_OIndex := 0 to Pred(l_En.Operations.Count) do
     begin
      l_Op := TvcmRepOperationsCollectionItem(l_En.Operations.Items[l_OIndex]);
      l_OpN := COP(l_Op.Name);
      for l_SIndex := 0 to Pred(l_Op.States.Count) do
      begin
       l_State := TvcmBaseOperationState(l_Op.States.Items[l_SIndex]);
       l_StateN := CST(l_State.Name);
       if l_StateN = '' then
        l_StateN := IntToStr(l_SIndex);
       if (l_Op.OperationType in vcm_HiddenOperations) then
        WriteLn(Format('  mst_%s_%s_%s : TvcmOperationStateIndex = (_rID : %d)', [l_EnN, l_OpN, l_StateN, l_SIndex]))
       else
        WriteLn(Format('  mst_user_%s_%s_%s : TvcmOperationStateIndex = (_rID : %d)', [l_EnN, l_OpN, l_StateN, l_SIndex]));
       WriteLn(Format('   // %s -> %s <-> %s', [l_En.Caption, l_Op.Caption, l_State.Caption]));
      end;//for l_SIndex
     end;//for l_OIndex
    end;//l_En.Operations <> nil
   end;//for l_EIndex*)

   if (AppForms <> nil) and (AppForms.Count > 0) then
   begin
(*    WriteLn('const // - �������������� ����');
    for l_EIndex := 0 to Pred(AppForms.Count) do
    begin
     l_Form := AppForms.Items[l_EIndex];
     WriteLn(Format('  fm_%s : TvcmFormID = (rName : ''%s''; _rID: %d);', [l_Form.Name, l_Form.Name, Succ(l_EIndex)]));
     WriteLn(Format('   // %s', [l_Form.Caption]));
    end;//for l_EIndex*)
    
(*   if false then
    for l_EIndex := 0 to Pred(AppForms.Count) do
    // - ���������� ���������������� ����
    begin
     l_Form := AppForms.Items[l_EIndex];
     if (l_Form.UserTypes <> nil) then
      with TvcmRepUserTypesCollection(l_Form.UserTypes) do
       if (Count > 1{0}) and not DeprecatedGenerateFromStdRes then
       begin
        WriteLn(Format('type // ���������������� ���� ����� "%s"', [l_Form.Caption]));
        WriteLn(Format('  T%sUT = (', [l_Form.Name]));
        for l_OIndex := 0 to Pred(Count) do
        begin
         with Items[l_OIndex] do
          if (l_OIndex = Pred(Count)) then
           WriteLn(Format('           %s  // %s', [Name, Caption]))
          else
           WriteLn(Format('           %s, // %s', [Name, Caption]));
        end;//for l_OIndex
        WriteLn(Format('  ); //T%sUT', [l_Form.Name]));
       end;//Count > 0
    end;//for l_EIndex*)
   end;//AppForms <> nil

(*   if Assigned(f_FormSetFactories) and (f_FormSetFactories.Count > 0) then
   // ���������� �������������� ������
   begin
    WriteLn('const // - �������������� ������');
    for l_EIndex := 0 to Pred(f_FormSetFactories.Count) do
     with f_FormSetFactories.Items[l_EIndex] do
     begin
      WriteLn(Format('  %s%s : _TvcmFormSetID = (rName : ''%s'');',
       [c_Fs1, CFS(FactoryId.rName), FactoryId.rName]));
      WriteLn(Format('   // ������ ���� "%s"', [Caption]));
     end;
   end;//Assigned(f_FormSetFactories)*)

   if (Messages <> nil) and (Messages.Count > 0) then
   begin
    //WriteLn('const // - �������������� ���������');
    for l_EIndex := 0 to Pred(Messages.Count) do
    begin
     l_Message := TvcmMessagesCollectionItem(Messages.Items[l_EIndex]);
     Case l_Message.DlgType of
      mtWarning:
       l_Pref := 'war';
      mtInformation:
       l_Pref := 'inf';
      mtError:
       l_Pref := 'err';
      mtCustom :
       l_Pref := 'msg';
      mtConfirmation :
       l_Pref := 'qr';
      else
       l_Pref := 'msg';
     end;//Case l_Message.DlgType
     WriteLn(Format('  %s_%s : TvcmMessageID = (rM : %d);', [l_Pref, l_Message.Name, l_EIndex]));
     WriteLn(Format('   // "%s"', [AnsiReplaceStr(
                                   AnsiReplaceStr(
                                                  l_Message.Caption,
                                                  #13, ' '),
                                                  #10, ' ')]));
    end;//for l_EIndex
   end;//Messages <> nil

   if (Strings <> nil) and (Strings.Count > 0) then
   begin
    WriteLn('const // - �������������� ��������� ��������');
    for l_EIndex := 0 to Pred(Strings.Count) do
    begin
     l_Str := Strings.Items[l_EIndex];
     WriteLn(Format('  str_%s : TvcmStringID = (rS : %d);', [l_Str.Name, l_EIndex]));
     WriteLn(Copy(Format('   // "%s"', [AnsiReplaceStr(
                                   AnsiReplaceStr(
                                                  l_Str.Caption,
                                                  #13, ' '),
                                                       #10, ' ')]),
                  1,
                  1020));
    end;//for l_EIndex
   end;//Strings <> nil

   WriteLn(cVCMEnd);
  finally
   FreeAndNil(l_F);
  end;//try..finally
 end;
 
var
 l_V : IOTAEditView;
 l_EB : IOTAEditBlock;
 l_StartRow : Integer;
 l_EndRow : Integer;
 l_EP : IOTAEditPosition;
//#UC END# *52A1FA92012A_4AD5DBBD0147_var*
begin
//#UC START# *52A1FA92012A_4AD5DBBD0147_impl*
 if (Entities <> nil) and (Entities.Count > 0) then
 begin
  l_SE := SourceEditor;
  if (l_SE <> nil) then
  begin
   if (l_SE.EditViewCount > 0) then
   begin
    l_V := l_SE.EditViews[0];
    if (l_V <> nil) then
    begin
     l_EP := l_V.Position;
     l_EB := l_V.Block;
     if (l_EP <> nil) and (l_EB <> nil) then
     begin
      l_StartRow := 0;
      l_EP.Move(1, 1);
      while true do
      begin
       l_EB.BeginBlock;
       l_EP.MoveEOL;
       l_EB.EndBlock;
       if AnsiContainsText(l_EB.Text, cVCMStart) then
       begin
        l_StartRow := l_EP.Row;
       end//cVCMStart
       else
       if AnsiStartsText(cImplementation, TrimLeft(l_EB.Text)) then
       begin
        l_EndRow := l_EP.Row;
        if (l_StartRow <> 0) then
        begin
         l_EP.Move(l_StartRow, 1);
         l_EB.BeginBlock;
         l_EP.Move(l_EndRow, 1);
         l_EB.EndBlock;
         l_EB.Delete;
         l_EP.Move(l_StartRow, 1);
         l_EB.BeginBlock;
         l_EP.MoveEOL;
         l_EB.EndBlock;
         l_EP.Move(l_StartRow -1 , 1);
         l_EP.MoveEOL;
        end//l_StartRow <> 0
        else
        begin
         l_EP.Move(l_EP.Row - 1, 1);
        end;
        l_EP.InsertFile(MakeFile);
        l_SE.Show;
        break;
       end;//cImplementation
       if (l_EP.Row >= l_EP.LastRow) then
        break
       else
       if not l_EP.Move(l_EP.Row + 1, 1) then
        break;
      end;
     end;//l_EP <> nil
    end;//l_V <> nil
   end;//l_SE.EditViewCount > 0
  end;//l_SE <> nil
 end;//Entities <> nil
//#UC END# *52A1FA92012A_4AD5DBBD0147_impl*
end;//TvcmBaseMenuManagerPrim.WriteRes
{$IfEnd} // Defined(DesignTimeLibrary)

{$If Defined(DesignTimeLibrary)}
procedure TvcmBaseMenuManagerPrim.RegisterEntities;
//#UC START# *52A1FAC302BD_4AD5DBBD0147_var*
var
 l_MS : IOTAModuleServices;
 l_M : IOTAModule;
 l_E : IOTAEditor;
 l_FE : IOTAFormEditor;
 l_C : IOTAComponent;
 l_NC : INTAComponent;
 l_RC : TComponent;
 l_MIndex : Integer;
 l_EIndex : Integer;
//#UC END# *52A1FAC302BD_4AD5DBBD0147_var*
begin
//#UC START# *52A1FAC302BD_4AD5DBBD0147_impl*
 l_MS := vcmGetTAModules;
 if (l_MS <> nil) then
 begin
  for l_MIndex := 0 to Pred(l_MS.ModuleCount) do
  begin
   l_M := l_MS.Modules[l_MIndex];
   for l_EIndex := 0 to Pred(l_M.ModuleFileCount) do
   begin
    l_E := l_M.ModuleFileEditors[l_EIndex];
    if Supports(l_E, IOTAFormEditor, l_FE) then
     try
      l_C := l_FE.FindComponent('ENTITIES');
      if Supports(l_C, IOTAComponent, l_NC) then
       try
        l_RC := l_NC.GetComponent;
        if (l_RC is TvcmCustomEntities) then
         TvcmCustomEntities(l_RC).RegisterInRep;
       finally
        l_NC := nil;
       end;//try..finally
      l_C := l_FE.FindComponent('MODULEDEF');
      if Supports(l_C, IOTAComponent, l_NC) then
       try
        l_RC := l_NC.GetComponent;
        if (l_RC is TvcmCustomModuleDef) then
         TvcmCustomModuleDef(l_RC).RegisterInRep;
       finally
        l_NC := nil;
       end;//try..finally
     finally
      l_FE := nil;
     end;//try..finally
   end;//for l_EIndex
  end;//for l_MIndex
 end;//l_MS <> nil
//#UC END# *52A1FAC302BD_4AD5DBBD0147_impl*
end;//TvcmBaseMenuManagerPrim.RegisterEntities
{$IfEnd} // Defined(DesignTimeLibrary)

function TvcmBaseMenuManagerPrim.DoShortCutCommand(aCommand: Word): Boolean;
//#UC START# *52A1FAE000ED_4AD5DBBD0147_var*
var
 l_Params : IvcmParams;
 l_EntityForm : IvcmEntityForm;
 l_Op : TvcmOPID;
 l_MOp : TvcmMOPID;
 l_CustomForm : TCustomForm;
//#UC END# *52A1FAE000ED_4AD5DBBD0147_var*
begin
//#UC START# *52A1FAE000ED_4AD5DBBD0147_impl*
 Result := false;
{$IfNDef DesignTimeLibrary}
 l_CustomForm := Screen.ActiveForm;
 if (l_CustomForm <> nil) then
  if not (l_CustomForm is TvcmEntityForm) and
     (fsModal in l_CustomForm.FormState) then
   Exit;  
 if (vcmDispatcher <> nil) and g_ShortcutProcessingEnabled then
 begin
  with vcmCommandInfo(aCommand) do
   if rIsModule then
   begin
    if l3BQueryInterface(vcmDispatcher.ActiveEntity, IvcmEntityForm, l_EntityForm) then
     try
      if not l_EntityForm.IsModalForm then
      begin
       l_MOp.rMoID := TvcmControlID(rItemID);
       l_MOp.rOpID := TvcmControlID(rOperationID);
       // ����� ��������
       Result := vcmDispatcher.ModuleOperation(l_MOp);
       if Result then
        // ����������� � ������ ������� �������
        OperationExecuteNotify(vcm_octShortCut,
                               TvcmBaseOperationsCollectionItem(
                     TvcmModulesCollectionItem(
                      f_Modules.FindItemByID(l_MOp.rMoID)).
                       Operations.FindItemByID(l_MOp.rOpID)).OperationDef);
      end;//not l_EntityForm.IsModalForm
     finally
      l_EntityForm := nil;
     end;//try..finally
   end//rIsModule
   else
   begin
    l_Op.rEnID := TvcmControlID(rItemID);
    l_Op.rOpID := TvcmControlID(rOperationID);
    // ����� ��������
    Result := vcmDispatcher.EntityOperation(l_Op, vcmParams);
    if Result then
     // ����������� � ������ ������� �������
     OperationExecuteNotify(vcm_octShortCut,
                            TvcmBaseOperationsCollectionItem(
                TvcmBaseEntitiesCollectionItem(
                 Entities.FindItemByID(l_Op.rEnID)).
                  Operations.FindItemByID(l_Op.rOpID)).OperationDef);
   end;//rIsModule
 end;//vcmDispatcher <> nil
{$EndIf  DesignTimeLibrary}
//#UC END# *52A1FAE000ED_4AD5DBBD0147_impl*
end;//TvcmBaseMenuManagerPrim.DoShortCutCommand

function TvcmBaseMenuManagerPrim.GetModulesCollectionClass: RvcmModulesCollection;
//#UC START# *52A1FB7300B9_4AD5DBBD0147_var*
//#UC END# *52A1FB7300B9_4AD5DBBD0147_var*
begin
//#UC START# *52A1FB7300B9_4AD5DBBD0147_impl*
 Result := TvcmModulesCollection;
//#UC END# *52A1FB7300B9_4AD5DBBD0147_impl*
end;//TvcmBaseMenuManagerPrim.GetModulesCollectionClass

procedure TvcmBaseMenuManagerPrim.OperationExecuteNotify(aType: TvcmOperationCallType;
 const anOperation: IvcmOperationDef);
 {* ����������� � ��������� ��������. ���������� ����� ���������� ��������. ��� ������ ShortCut, anAction �� �����������, ���������� ��������������� ��������. ���� ����� ���������� ����������� �������� ��� ��������, �� �������� anAction ����� ����� ���������� �������� �� IvcmOperationDef }
//#UC START# *52A1FB9A0265_4AD5DBBD0147_var*
//#UC END# *52A1FB9A0265_4AD5DBBD0147_var*
begin
//#UC START# *52A1FB9A0265_4AD5DBBD0147_impl*
 if Assigned(f_OnOperationExecuteNotify) then
  f_OnOperationExecuteNotify(aType, anOperation);
//#UC END# *52A1FB9A0265_4AD5DBBD0147_impl*
end;//TvcmBaseMenuManagerPrim.OperationExecuteNotify

procedure TvcmBaseMenuManagerPrim.RegisterKeywords;
//#UC START# *52A1FBE502A6_4AD5DBBD0147_var*
var
 l_I : Integer;
 l_J : Integer;
 l_En : TvcmBaseEntitiesCollectionItem;
//#UC END# *52A1FBE502A6_4AD5DBBD0147_var*
begin
//#UC START# *52A1FBE502A6_4AD5DBBD0147_impl*
{$IfNDef DesignTimeLibrary}
{$IFNDEF Archi}
 if not f_KeywordsRegistered then
 begin
  f_KeywordsRegistered := true;
  for l_I := 0 to Pred(Entities.Count) do
  begin
   l_En := Entities.Items[l_I] as TvcmBaseEntitiesCollectionItem;
   for l_J := 0 to Pred(l_En.Operations.Count) do
   begin
    //TkwEntityOperation.Register(l_En, l_En.Operations.Items[l_J] as TvcmBaseOperationsCollectionItem);
    TvcmOperationsManager.Instance.Register(l_En, l_En.Operations.Items[l_J] as TvcmBaseOperationsCollectionItem);
   end;
  end;//for l_I
 end;//not f_KeywordsRegistered
{$ENDIF Archi}
{$EndIf DesignTimeLibrary}
//#UC END# *52A1FBE502A6_4AD5DBBD0147_impl*
end;//TvcmBaseMenuManagerPrim.RegisterKeywords

{$If NOT Defined(DesignTimeLibrary)}
procedure TvcmBaseMenuManagerPrim.RegisterModuleInMenu(aForm: TvcmEntityForm;
 const aModuleDef: IvcmModuleDef);
 {* ������������ ������ � ����, toolbar'��, etc. ��� ���������� � ��������. }
//#UC START# *52A1FC0C0333_4AD5DBBD0147_var*
//#UC END# *52A1FC0C0333_4AD5DBBD0147_var*
begin
//#UC START# *52A1FC0C0333_4AD5DBBD0147_impl*
//#UC END# *52A1FC0C0333_4AD5DBBD0147_impl*
end;//TvcmBaseMenuManagerPrim.RegisterModuleInMenu
{$IfEnd} // NOT Defined(DesignTimeLibrary)

{$If NOT Defined(DesignTimeLibrary)}
procedure TvcmBaseMenuManagerPrim.MainCreated(aForm: TvcmEntityForm);
//#UC START# *52A1FC3D0231_4AD5DBBD0147_var*
//#UC END# *52A1FC3D0231_4AD5DBBD0147_var*
begin
//#UC START# *52A1FC3D0231_4AD5DBBD0147_impl*
 RegisterKeywords;
//#UC END# *52A1FC3D0231_4AD5DBBD0147_impl*
end;//TvcmBaseMenuManagerPrim.MainCreated
{$IfEnd} // NOT Defined(DesignTimeLibrary)

procedure TvcmBaseMenuManagerPrim.RegisterMainInMenu(aForm: TvcmEntityForm);
 {* ������������ �������� ����� � ����, toolbar'��, etc. ��� ���������� � ��������. }
//#UC START# *52A1FC5500AC_4AD5DBBD0147_var*
//#UC END# *52A1FC5500AC_4AD5DBBD0147_var*
begin
//#UC START# *52A1FC5500AC_4AD5DBBD0147_impl*
//#UC END# *52A1FC5500AC_4AD5DBBD0147_impl*
end;//TvcmBaseMenuManagerPrim.RegisterMainInMenu

{$If NOT Defined(DesignTimeLibrary)}
procedure TvcmBaseMenuManagerPrim.RegisterChildInMenu(aForm: TvcmEntityForm);
 {* ������������ �������� ����� � ����, toolbar'��, etc. ��� ���������� � ��������. }
//#UC START# *52A1FC79004A_4AD5DBBD0147_var*
//#UC END# *52A1FC79004A_4AD5DBBD0147_var*
begin
//#UC START# *52A1FC79004A_4AD5DBBD0147_impl*
//#UC END# *52A1FC79004A_4AD5DBBD0147_impl*
end;//TvcmBaseMenuManagerPrim.RegisterChildInMenu
{$IfEnd} // NOT Defined(DesignTimeLibrary)

function TvcmBaseMenuManagerPrim.GetPopupMenu: TPopupMenu;
//#UC START# *52A1FCA20227_4AD5DBBD0147_var*
//#UC END# *52A1FCA20227_4AD5DBBD0147_var*
begin
//#UC START# *52A1FCA20227_4AD5DBBD0147_impl*
 Result := nil;
//#UC END# *52A1FCA20227_4AD5DBBD0147_impl*
end;//TvcmBaseMenuManagerPrim.GetPopupMenu

function TvcmBaseMenuManagerPrim.GetOperationableObjectByID(anID: Integer): TvcmRepEntitiesCollectionItem;
//#UC START# *52A1FCB70149_4AD5DBBD0147_var*
var
 l_CEn : TvcmRepEntitiesCollection;
//#UC END# *52A1FCB70149_4AD5DBBD0147_var*
begin
//#UC START# *52A1FCB70149_4AD5DBBD0147_impl*
 if (anID < 0) then
  l_CEn := Modules as TvcmRepEntitiesCollection
 else
 if (anID > 0) then
  l_CEn := Entities as TvcmRepEntitiesCollection
 else
 begin
  l_CEn := nil;
  Assert(False);
 end;//anID > 0
 {$IfDef DesignTimeLibrary}
 Result := l_CEn.FindItemByID(Abs(anID)) as TvcmRepEntitiesCollectionItem;
 {$Else  DesignTimeLibrary}
 Result := l_CEn.Items[Abs(anID) - 1] as TvcmRepEntitiesCollectionItem;
 {$EndIf DesignTimeLibrary}
//#UC END# *52A1FCB70149_4AD5DBBD0147_impl*
end;//TvcmBaseMenuManagerPrim.GetOperationableObjectByID

function TvcmBaseMenuManagerPrim.GetOperationableObjectByName(const aName: AnsiString;
 aModule: Boolean): TvcmRepEntitiesCollectionItem;
//#UC START# *52A1FCDB0027_4AD5DBBD0147_var*
var
 l_CEn : TvcmRepEntitiesCollection;
//#UC END# *52A1FCDB0027_4AD5DBBD0147_var*
begin
//#UC START# *52A1FCDB0027_4AD5DBBD0147_impl*
 if aModule then
  l_CEn := Modules as TvcmRepEntitiesCollection
 else
  l_CEn := Entities as TvcmRepEntitiesCollection;
 Result := l_CEn.FindItemByName(aName) as TvcmRepEntitiesCollectionItem;
 {$If Defined(nsTest) and not Defined(InsiderTest)}
 if (Result = nil) then
 begin
  Result := TvcmRepEntitiesCollectionItem(l_CEn.Add);
  Result.Name := aName;
 end;//Result = nil
 {$IfEnd}
//#UC END# *52A1FCDB0027_4AD5DBBD0147_impl*
end;//TvcmBaseMenuManagerPrim.GetOperationableObjectByName

procedure TvcmBaseMenuManagerPrim.RegisterOperation(const aControl: IvcmIdentifiedUserFriendlyControl;
 const anOp: IvcmOperationDef;
 anUFHolder: TObject;
 anOpHolder: TObject);
//#UC START# *52A1FD0300F5_4AD5DBBD0147_var*
var
 l_Mo : IvcmModuleDef;
 l_En : IvcmEntityDef;
 l_CEn : TvcmRepEntitiesCollection;
 l_IEn : TvcmRepEntitiesCollectionItem;
 l_IOp : TvcmRepOperationsCollectionItem;
 {$IfDef DesignTimeLibrary}
 l_M : IOTAModule;
 {$EndIf DesignTimeLibrary}
 l_Form : TCustomForm;
//#UC END# *52A1FD0300F5_4AD5DBBD0147_var*
begin
//#UC START# *52A1FD0300F5_4AD5DBBD0147_impl*
 if (Entities <> nil) and (Modules <> nil) and
    (aControl <> nil) and (anOp <> nil) and
    (anUFHolder <> nil) and (anOpHolder <> nil) and
    (aControl.Name <> '') and (anOp.Name <> '') then
 begin
  if Supports(aControl, IvcmEntityDef, l_En) then
   try
    l_CEn := Entities as TvcmRepEntitiesCollection;
   finally
    l_En := nil;
   end//try..finally
  else
  if Supports(aControl, IvcmModuleDef, l_Mo) then
   try
    l_CEn := Modules as TvcmRepEntitiesCollection;
   finally
    l_Mo := nil;
   end//try..finally
  else
   l_CEn := nil;
  if (l_CEn <> nil) then
  begin
    {$IfDef DesignTimeLibrary}
    if (aControl.ID = 0) then
     l_IEn := l_CEn.FindItemByName(aControl.Name) as TvcmRepEntitiesCollectionItem
    else 
     l_IEn := l_CEn.FindItemByID(aControl.ID) as TvcmRepEntitiesCollectionItem;
    {$Else  DesignTimeLibrary}
    l_IEn := l_CEn.Items[aControl.ID - 1] as TvcmRepEntitiesCollectionItem;
    {$EndIf DesignTimeLibrary}
    if (l_IEn = nil) then
    begin
     l_IEn := TvcmRepEntitiesCollectionItem(l_CEn.Add);
     l_IEn.Name := aControl.Name;
     l_IEn.Caption := vcmStr(aControl.Caption);
    end;//l_IEn = nil
    if (anUFHolder is TvcmEntitiesCollectionItem) then
     l_IEn.AddHolder(anUFHolder as TvcmEntitiesCollectionItem);
    {$IfDef DesignTimeLibrary}
    l_IOp := l_IEn.Operations.FindItemByID(anOp.ID) as TvcmRepOperationsCollectionItem;
    {$Else  DesignTimeLibrary}
    l_IOp := l_IEn.Operations.Items[anOp.ID - 1] as TvcmRepOperationsCollectionItem;
    {$EndIf DesignTimeLibrary}
    if (l_IOp = nil) then
    begin
     l_IOp := TvcmRepOperationsCollectionItem(l_IEn.Operations.Add);
     with l_IOp do
     begin
      Name := anOp.Name;
      Caption := vcmStr(anOp.Caption);
      GroupID := anOp.GroupID;
      OperationType := anOp.OperationType;
      Hint := vcmStr(anOp.Hint);
      LongHint := vcmStr(anOp.LongHint);
      ShortCut := anOp.ShortCut;
      ImageIndex := anOp.ImageIndex;
      //AutoLock := anOp.AutoLock;
      ExcludeUserTypes := anOp.ExcludeUserTypes;
      //OnTest := anOp.OnTest;
      //OnExecute := anOp.OnExecute;
      //OnContextTest := anOp.OnContextTest;
      //OnContextExecute := anOp.OnContextExecute;
      Options := anOp.Options;
     end;//with l_IOp
    end;//l_IOp = nil
    Assert(anOpHolder is TvcmOperationsCollectionItem);
    l_IOp.AddHolder(anOpHolder as TvcmOperationsCollectionItem);
    if (anUFHolder is TPersistent) then
    begin
     l_Form := afw.GetParentForm(TPersistent(anUFHolder));
     if (l_Form is TvcmEntityForm) then
      {$IfDef DesignTimeLibrary}
      AppForms.AddForm(TvcmEntityForm(l_Form));
      {$Else  DesignTimeLibrary}
      AppForms.AddForm(RvcmEntityForm(TvcmEntityForm(l_Form).ClassType));
      {$EndIf DesignTimeLibrary}
    end;//anUFHolder is TPersistent
    {$IfDef DesignTimeLibrary}
    l_M := Module;
    if (l_M <> nil) then
     l_M.MarkModified;
    {$EndIf DesignTimeLibrary} 
  end;//l_CEn <> nil
 end;//aControl <> nil
//#UC END# *52A1FD0300F5_4AD5DBBD0147_impl*
end;//TvcmBaseMenuManagerPrim.RegisterOperation

procedure TvcmBaseMenuManagerPrim.AddForm(const aForm: IvcmEntityForm);
//#UC START# *52A1FD28019A_4AD5DBBD0147_var*
//#UC END# *52A1FD28019A_4AD5DBBD0147_var*
begin
//#UC START# *52A1FD28019A_4AD5DBBD0147_impl*
{$IfNDef DesignTimeLibrary}
 f_FormActivateManager.AddForm(aForm);
{$EndIf DesignTimeLibrary}
//#UC END# *52A1FD28019A_4AD5DBBD0147_impl*
end;//TvcmBaseMenuManagerPrim.AddForm

procedure TvcmBaseMenuManagerPrim.RemoveForm(const aForm: IvcmEntityForm);
//#UC START# *52A1FD3B0252_4AD5DBBD0147_var*
//#UC END# *52A1FD3B0252_4AD5DBBD0147_var*
begin
//#UC START# *52A1FD3B0252_4AD5DBBD0147_impl*
{$IfNDef DesignTimeLibrary}
 f_FormActivateManager.RemoveForm(aForm);
{$EndIf DesignTimeLibrary}
{$IfDef DesignTimeLibrary}
 if (AppForms <> nil) then
 begin
  if (aForm <> nil) then
   AppForms.RemoveForm(aForm.VCLWinControl as TvcmEntityForm);
 end;//AppForms <> nil
{$EndIf DesignTimeLibrary}
//#UC END# *52A1FD3B0252_4AD5DBBD0147_impl*
end;//TvcmBaseMenuManagerPrim.RemoveForm

procedure TvcmBaseMenuManagerPrim.ReloadToolbars(const aForm: IvcmEntityForm);
//#UC START# *52A1FD4C002A_4AD5DBBD0147_var*
//#UC END# *52A1FD4C002A_4AD5DBBD0147_var*
begin
//#UC START# *52A1FD4C002A_4AD5DBBD0147_impl*
//#UC END# *52A1FD4C002A_4AD5DBBD0147_impl*
end;//TvcmBaseMenuManagerPrim.ReloadToolbars

procedure TvcmBaseMenuManagerPrim.ReloadAllToolbars;
//#UC START# *52A1FD5E02DC_4AD5DBBD0147_var*
var
 l_Index: Integer;
 l_Form: IvcmEntityForm;
//#UC END# *52A1FD5E02DC_4AD5DBBD0147_var*
begin
//#UC START# *52A1FD5E02DC_4AD5DBBD0147_impl*
 with vcmDispatcher do
  with FormDispatcher do
  begin
   for l_Index := 0 to MainFormsCount-1 do
   begin
    if Supports(MainForm[l_Index], IvcmEntityForm, l_Form) then
     ReloadToolbars(l_Form);
   end;

   for l_Index := 0 to EntitiesCount-1 do
   begin
    if Supports(Entity[l_Index], IvcmEntityForm, l_Form) then
     ReloadToolbars(l_Form);
   end;//for l_Index

   for l_Index := 0 to MainFormsCount-1 do
   begin
    if Supports(MainForm[l_Index], IvcmEntityForm, l_Form) then
     if (l_Form.VCLWinControl is TvcmEntityForm) then
      PostBuild(l_Form.VCLWinControl as TvcmEntityForm);
   end;//for l_Index

   for l_Index := 0 to EntitiesCount-1 do
   begin
    if Supports(Entity[l_Index], IvcmEntityForm, l_Form) then
     if (l_Form.VCLWinControl is TvcmEntityForm) then
      PostBuild(l_Form.VCLWinControl as TvcmEntityForm);
   end;//for l_Index
  end;//with FormDispatcher
//#UC END# *52A1FD5E02DC_4AD5DBBD0147_impl*
end;//TvcmBaseMenuManagerPrim.ReloadAllToolbars

procedure TvcmBaseMenuManagerPrim.PostBuild(aForm: TvcmEntityForm;
 aFollowDocks: Boolean = False);
//#UC START# *52A1FD7301A8_4AD5DBBD0147_var*
//#UC END# *52A1FD7301A8_4AD5DBBD0147_var*
begin
//#UC START# *52A1FD7301A8_4AD5DBBD0147_impl*
//#UC END# *52A1FD7301A8_4AD5DBBD0147_impl*
end;//TvcmBaseMenuManagerPrim.PostBuild

procedure TvcmBaseMenuManagerPrim.LoadShortcuts(aResetToDefault: Boolean = False);
//#UC START# *52A1FD960246_4AD5DBBD0147_var*
var
 l_Index : Integer;
 l_OpIndex : Integer;
 l_Name : AnsiString;
 l_OpName : AnsiString;
 l_Shortcut : Cardinal;
 l_SecShort : Il3CString;
 l_List : TShortCutList;

 procedure l_FreeShortcut(aShortCut: TShortCut);
 var
  i : Integer;
  l_Key : Word;
  l_Shift : TShiftState;
  l_ByteShift : Byte;
  l_CommandID : Word;
  l_Controller : TOvcController;
 begin//l_FreeShortcut
  l_CommandID := 0;
  if aShortCut <> 0 then
  begin
   ShortCutToKey(aShortCut, l_Key, l_Shift);
   l_ByteShift := vcmByteShift(l_Shift);
   l_CommandID := 0;
   l_Controller := GetDefController;
   if Assigned(l_Controller) then
    with l_Controller.EntryCommands do
     if GetCommandTableIndex(c_vcmTableName) >= 0 then
      with l_Controller.EntryCommands.GetCommandTable(c_vcmTableName) do
       for i := 0 to Count - 1 do
        with Commands[i] do
         if (Key1 = l_Key) and (SS1 = l_ByteShift) then
         begin
          l_CommandID := Cmd;
          Break;
         end;//(Key1 = l_Key) and (SS1 = l_ByteShift)
  end;
  if (l_CommandID <> 0) then
   with vcmCommandInfo(l_CommandID) do
    if rIsModule then
     with g_MenuManager.GetOperationableObjectByID(-rItemID) as TvcmModulesCollectionItem do
      with Operations.FindItemByID(rOperationID) as TvcmRepOperationsCollectionItem do
       RemoveShortCut(aShortCut)
    else
     with g_MenuManager.GetOperationableObjectByID(rItemID) as TvcmBaseEntitiesCollectionItem do
      with Operations.FindItemByID(rOperationID) as TvcmRepOperationsCollectionItem do
       RemoveShortCut(aShortCut);
 end;//l_FreeShortcut

 procedure l_FreeShortcuts(aShortCut: TShortCut; aSecondaryShortCuts: TShortCutList);
 var
  i : Integer;
 begin//l_FreeShortcuts
  l_FreeShortcut(aShortCut);
  if Assigned(aSecondaryShortCuts) then
   for i := 0 to aSecondaryShortCuts.Count - 1 do
    l_FreeShortcut(aSecondaryShortCuts.ShortCuts[i]);
 end;//l_FreeShortcuts
//#UC END# *52A1FD960246_4AD5DBBD0147_var*
begin
//#UC START# *52A1FD960246_4AD5DBBD0147_impl*
 {$IfDef vcmUseSettings}
 l_ShortCut := 0;
 l_List := TShortCutList.Create;
 try

  for l_Index := 0 to g_MenuManager.Entities.Count - 1 do
   with g_MenuManager.Entities.Items[l_Index] as TvcmBaseEntitiesCollectionItem do
   begin
    l_Name := Name;
    for l_OpIndex := 0 to Operations.Count - 1 do
     with Operations.Items[l_OpIndex] as TvcmBaseOperationsCollectionItem do
     begin
      l_OpName := Name;
      if g_FirstShortCutLoad then
       StoreDesignTimeShortcuts;
      if aResetToDefault then
       vcmCleanShortcut(l_Name, l_OpName);
      if vcmLoadShortcut(l_Name, l_OpName, l_Shortcut, l_SecShort) then
       l_List.Text := vcmStr(l_SecShort)
      else
      begin
       l_Shortcut := SaveShortcut;
       l_List.Text := SaveSecondaryShortcuts;
      end;//vcmLoadShortcut..
      l_FreeShortcuts(TShortcut(l_ShortCut), l_List);
      ReplaceShortcuts(TShortcut(l_ShortCut), l_List);
     end;//with Operations.Items[l_OpIndex] as TvcmBaseOperationsCollectionItem
   end;//with g_MenuManager.Entities.Items[l_Index] as TvcmBaseEntitiesCollectionItem

  for l_Index := 0 to g_MenuManager.Modules.Count - 1 do
   with g_MenuManager.Modules.Items[l_Index] as TvcmModulesCollectionItem do
   begin
    l_Name := Name;
    for l_OpIndex := 0 to Operations.Count - 1 do
     with Operations.Items[l_OpIndex] as TvcmBaseOperationsCollectionItem do
     begin
      l_OpName := Name;
      if g_FirstShortCutLoad then
       StoreDesignTimeShortcuts;
      if aResetToDefault then
       vcmCleanShortcut(l_Name, l_OpName);
      if vcmLoadShortCut(l_Name, l_OpName, l_Shortcut, l_SecShort) then
       l_List.Text := vcmStr(l_SecShort)
      else
      begin
       l_Shortcut := SaveShortcut;
       l_List.Text := SaveSecondaryShortcuts;
      end;//vcmLoadShortCut..
      l_FreeShortcuts(TShortcut(l_ShortCut), l_List);
      ReplaceShortcuts(TShortcut(l_ShortCut), l_List);
     end;//with Operations.Items[l_OpIndex] as TvcmBaseOperationsCollectionItem
   end;//g_MenuManager.Modules.Items[l_Index] as TvcmModulesCollectionItem

 finally
  l_List.Free;
  g_FirstShortCutLoad := False;
 end;
 {$EndIf vcmUseSettings}
//#UC END# *52A1FD960246_4AD5DBBD0147_impl*
end;//TvcmBaseMenuManagerPrim.LoadShortcuts

function TvcmBaseMenuManagerPrim.MergedToMainForm(aForm: TvcmEntityForm): Boolean;
//#UC START# *52A1FDAE0139_4AD5DBBD0147_var*
//#UC END# *52A1FDAE0139_4AD5DBBD0147_var*
begin
//#UC START# *52A1FDAE0139_4AD5DBBD0147_impl*
 Result := False;
//#UC END# *52A1FDAE0139_4AD5DBBD0147_impl*
end;//TvcmBaseMenuManagerPrim.MergedToMainForm

procedure TvcmBaseMenuManagerPrim.AddModule(aModule: TvcmModule);
//#UC START# *52A1FDC20289_4AD5DBBD0147_var*
//#UC END# *52A1FDC20289_4AD5DBBD0147_var*
begin
//#UC START# *52A1FDC20289_4AD5DBBD0147_impl*
{$IfNDef DesignTimeLibrary}
 f_FormActivateManager.AddModule(aModule);
{$EndIf DesignTimeLibrary}
//#UC END# *52A1FDC20289_4AD5DBBD0147_impl*
end;//TvcmBaseMenuManagerPrim.AddModule

procedure TvcmBaseMenuManagerPrim.BackupOpStatus;
//#UC START# *52A1FDD7006C_4AD5DBBD0147_var*
//#UC END# *52A1FDD7006C_4AD5DBBD0147_var*
begin
//#UC START# *52A1FDD7006C_4AD5DBBD0147_impl*
//#UC END# *52A1FDD7006C_4AD5DBBD0147_impl*
end;//TvcmBaseMenuManagerPrim.BackupOpStatus

procedure TvcmBaseMenuManagerPrim.RestoreOpStatus;
//#UC START# *52A1FE020318_4AD5DBBD0147_var*
//#UC END# *52A1FE020318_4AD5DBBD0147_var*
begin
//#UC START# *52A1FE020318_4AD5DBBD0147_impl*
//#UC END# *52A1FE020318_4AD5DBBD0147_impl*
end;//TvcmBaseMenuManagerPrim.RestoreOpStatus

procedure TvcmBaseMenuManagerPrim.BeginOp;
//#UC START# *52A1FE1602AA_4AD5DBBD0147_var*
//#UC END# *52A1FE1602AA_4AD5DBBD0147_var*
begin
//#UC START# *52A1FE1602AA_4AD5DBBD0147_impl*
//#UC END# *52A1FE1602AA_4AD5DBBD0147_impl*
end;//TvcmBaseMenuManagerPrim.BeginOp

function TvcmBaseMenuManagerPrim.GetOpLock: Boolean;
//#UC START# *52A1FE2E0059_4AD5DBBD0147_var*
//#UC END# *52A1FE2E0059_4AD5DBBD0147_var*
begin
//#UC START# *52A1FE2E0059_4AD5DBBD0147_impl*
 Result := False;
//#UC END# *52A1FE2E0059_4AD5DBBD0147_impl*
end;//TvcmBaseMenuManagerPrim.GetOpLock

procedure TvcmBaseMenuManagerPrim.EndOp;
//#UC START# *52A1FE4B0329_4AD5DBBD0147_var*
//#UC END# *52A1FE4B0329_4AD5DBBD0147_var*
begin
//#UC START# *52A1FE4B0329_4AD5DBBD0147_impl*
//#UC END# *52A1FE4B0329_4AD5DBBD0147_impl*
end;//TvcmBaseMenuManagerPrim.EndOp

procedure TvcmBaseMenuManagerPrim.FastenToolbars;
//#UC START# *52A1FE58028C_4AD5DBBD0147_var*
//#UC END# *52A1FE58028C_4AD5DBBD0147_var*
begin
//#UC START# *52A1FE58028C_4AD5DBBD0147_impl*
//#UC END# *52A1FE58028C_4AD5DBBD0147_impl*
end;//TvcmBaseMenuManagerPrim.FastenToolbars

function TvcmBaseMenuManagerPrim.GetFastenMode: Boolean;
//#UC START# *52A1FE730278_4AD5DBBD0147_var*
//#UC END# *52A1FE730278_4AD5DBBD0147_var*
begin
//#UC START# *52A1FE730278_4AD5DBBD0147_impl*
 Result := False;
//#UC END# *52A1FE730278_4AD5DBBD0147_impl*
end;//TvcmBaseMenuManagerPrim.GetFastenMode

function TvcmBaseMenuManagerPrim.BuildVirtualForm(const aFormClass: RvcmEntityForm;
 out NeedFreeForm: Boolean;
 aUserType: TvcmUserType = vcm_utAny): TvcmEntityForm;
//#UC START# *52A1FEC30321_4AD5DBBD0147_var*
var
 l_Index : Integer;
//#UC END# *52A1FEC30321_4AD5DBBD0147_var*
begin
//#UC START# *52A1FEC30321_4AD5DBBD0147_impl*
 NeedFreeForm := False;                 
 Result := nil;
 if aFormClass.InheritsFrom(TvcmMainForm) then
  Result := (g_Dispatcher.FormDispatcher.MainForm[0].VCLWinControl as TvcmEntityForm)
 else
  with g_Dispatcher do
   for l_Index := 0 to Pred(EntitiesCount) do
    with Entity[l_Index].AsForm do
     if (aUserType = vcm_utAny) or (UserType = aUserType) and
        VCLWinControl.InheritsFrom(aFormClass) then
     begin
      Result := VCLWinControl as TvcmEntityForm;
      break;
     end;//UserType = l_UserType.ID..

 if (Result = nil) then
 begin
  if (aUserType = vcm_utAny) then
   aUserType := 0;
  Result := RvcmEntityForm(aFormClass).Make(vcmMakeParams,
                                            vcm_ztForToolbarsInfo,
                                            aUserType).VCLWinControl as TvcmEntityForm;
  NeedFreeForm := true;
 end;//l_Form = nil
//#UC END# *52A1FEC30321_4AD5DBBD0147_impl*
end;//TvcmBaseMenuManagerPrim.BuildVirtualForm

function TvcmBaseMenuManagerPrim.ObjectByType(anObject: TvcmObject;
 const anObjectName: AnsiString;
 const aSubName: AnsiString = '';
 ForceCreate: Boolean = False): TvcmBaseCollectionItem;
//#UC START# *52A1FF0902CE_4AD5DBBD0147_var*
var
 l_Item : TvcmBaseEntitiesCollectionItem;
 l_Form : TvcmFormsCollectionItem;
//#UC END# *52A1FF0902CE_4AD5DBBD0147_var*
begin
//#UC START# *52A1FF0902CE_4AD5DBBD0147_impl*
 Result := nil;
 l_Item := nil;
 Case anObject of
  vcm_objModule :
   Result := Modules.FindItemByName(anObjectName);
  vcm_objEntity :
   Result := Entities.FindItemByName(anObjectName);
  vcm_objEntityOperation :
   l_Item := Entities.FindItemByName(anObjectName) as TvcmBaseEntitiesCollectionItem;
  vcm_objModuleOperation :
   l_Item := Modules.FindItemByName(anObjectName) as TvcmBaseEntitiesCollectionItem;
  vcm_objControl:
  begin
   if ForceCreate then
    l_Form := AppForms.CheckItemByName(anObjectName) as TvcmFormsCollectionItem
   else
    l_Form := AppForms.FindItemByName(anObjectName) as TvcmFormsCollectionItem;
   if (l_Form <> nil) then
   begin
    if ForceCreate then
     Result := l_Form.Components.CheckItemByName(aSubName)
    else 
     Result := l_Form.Components.FindItemByName(aSubName);
   end;//l_Form <> nil
  end;//vcm_objControl
  vcm_objMessage :
   Result := Messages.FindItemByName(anObjectName);
  vcm_objForm :
   Result := AppForms.FindItemByName(anObjectName) as TvcmFormsCollectionItem;
  vcm_objFormSetFactory :
  begin
   Result := nil;
   Assert(false);
//   Result := FormSetFactories.FindItemByName(anObjectName) as TvcmFormSetFactoriesCollectionItem;
  end;//vcm_objFormSetFactory
  vcm_objUserType :
  begin
   Result := nil;
(*   l_Form := AppForms.FindItemByName(anObjectName) as TvcmFormsCollectionItem;
   if (l_Form <> nil) then
    Result := l_Form.UserTypes.FindItemByName(aSubName);*)
  end;//vcm_objUserType
  vcm_ObjOperationState :
  begin
   {$IfDef vcmNeedL3}
   Result := ObjectByType(vcm_objEntityOperation, anObjectName, ev_psPrefix(aSubName, c_vcmContentSep));
   if (Result <> nil) then
    Result := (Result as TvcmBaseOperationsCollectionItem).States.FindItemByName(ev_psSuffix(aSubName, c_vcmContentSep));
   {$Else   vcmNeedL3}
   Assert(false);
   {$EndIf  vcmNeedL3}
  end;//vcm_ObjOperationState
  vcm_ObjStrings: Result := Strings.FindItemByName(anObjectName);
 end;//Case anObject
 if (Result = nil) and (l_Item <> nil) then
  Result := l_Item.Operations.FindItemByName(aSubName);
//#UC END# *52A1FF0902CE_4AD5DBBD0147_impl*
end;//TvcmBaseMenuManagerPrim.ObjectByType

procedure TvcmBaseMenuManagerPrim.DefineObjectProp(anObject: TvcmObject;
 const anObjectName: AnsiString;
 const aSubName: AnsiString;
 const aProp: AnsiString;
 const aValue: AnsiString);
//#UC START# *52A1FF9A0004_4AD5DBBD0147_var*
var
 l_Object : TObject;
//#UC END# *52A1FF9A0004_4AD5DBBD0147_var*
begin
//#UC START# *52A1FF9A0004_4AD5DBBD0147_impl*
 l_Object := ObjectByType(anObject, anObjectName, aSubName, true);
 if (l_Object <> nil) then
  if (GetPropInfo(l_Object, aProp) <> nil) then
   SetStrProp(l_Object, aProp, aValue);
//#UC END# *52A1FF9A0004_4AD5DBBD0147_impl*
end;//TvcmBaseMenuManagerPrim.DefineObjectProp

function TvcmBaseMenuManagerPrim.OpDefBySelector(const anOp: TvcmOpSelector): IvcmOperationDef;
//#UC START# *52A2005103CF_4AD5DBBD0147_var*
//#UC END# *52A2005103CF_4AD5DBBD0147_var*
begin
//#UC START# *52A2005103CF_4AD5DBBD0147_impl*
 Case anOp.rKind of
  vcm_okModule :
   Result := g_Dispatcher.GetModuleByID(anOp.rMID.rMoID).GetOperationByID(anOp.rMID.rOpID);
  vcm_okEntity :
   with TvcmBaseEntitiesCollectionItem(Entities.FindItemByID(anOp.rID.rEnID)) do
    Result := TvcmBaseOperationsCollectionItem(Operations.FindItemByID(anOp.rID.rOpID)).OperationDef;
  else
   Result := nil;
 end;//Case anOp.rKind
//#UC END# *52A2005103CF_4AD5DBBD0147_impl*
end;//TvcmBaseMenuManagerPrim.OpDefBySelector

function TvcmBaseMenuManagerPrim.BuildAction(const anOp: TvcmOpSelector;
 aDefaultAction: TCustomAction = nil): TCustomAction;
//#UC START# *52A20071016B_4AD5DBBD0147_var*
//#UC END# *52A20071016B_4AD5DBBD0147_var*
begin
//#UC START# *52A20071016B_4AD5DBBD0147_impl*
 Case anOp.rKind of
  vcm_okModule :
   with g_Dispatcher.GetModuleByID(anOp.rMID.rMoID) do
    Result := TvcmModuleAction.Make(ModuleDef, GetOperationByID(anOp.rMID.rOpID));
  vcm_okEntity :
   with TvcmBaseEntitiesCollectionItem(Entities.FindItemByID(anOp.rID.rEnID)) do
    Result := TvcmEntityAction.Make(EntityDef, TvcmBaseOperationsCollectionItem(Operations.FindItemByID(anOp.rID.rOpID)).OperationDef);
  else
   Result := aDefaultAction;
 end;//Case anOp.rKind
//#UC END# *52A20071016B_4AD5DBBD0147_impl*
end;//TvcmBaseMenuManagerPrim.BuildAction

function TvcmBaseMenuManagerPrim.UnlockInProgress: Boolean;
//#UC START# *52A2008D00DA_4AD5DBBD0147_var*
//#UC END# *52A2008D00DA_4AD5DBBD0147_var*
begin
//#UC START# *52A2008D00DA_4AD5DBBD0147_impl*
 Result := false;
//#UC END# *52A2008D00DA_4AD5DBBD0147_impl*
end;//TvcmBaseMenuManagerPrim.UnlockInProgress

procedure TvcmBaseMenuManagerPrim.AddControlForUnlockPostBuild(const aControl: IafwMenuUnlockedPostBuild);
//#UC START# *52A200A001C8_4AD5DBBD0147_var*
//#UC END# *52A200A001C8_4AD5DBBD0147_var*
begin
//#UC START# *52A200A001C8_4AD5DBBD0147_impl*
//#UC END# *52A200A001C8_4AD5DBBD0147_impl*
end;//TvcmBaseMenuManagerPrim.AddControlForUnlockPostBuild

procedure TvcmBaseMenuManagerPrim.ListenerControlDestroying(const aControl: IafwMenuUnlockedPostBuild);
//#UC START# *52A200C203A4_4AD5DBBD0147_var*
//#UC END# *52A200C203A4_4AD5DBBD0147_var*
begin
//#UC START# *52A200C203A4_4AD5DBBD0147_impl*
//#UC END# *52A200C203A4_4AD5DBBD0147_impl*
end;//TvcmBaseMenuManagerPrim.ListenerControlDestroying

procedure TvcmBaseMenuManagerPrim.SubscribeMenuItemClickListener(const aListener: IvcmMenuItemClickListener);
//#UC START# *53E9DC69036C_4AD5DBBD0147_var*
//#UC END# *53E9DC69036C_4AD5DBBD0147_var*
begin
//#UC START# *53E9DC69036C_4AD5DBBD0147_impl*
 Assert(MenuItemClickListeners.IndexOf(aListener) = -1);
 MenuItemClickListeners.Add(aListener);
//#UC END# *53E9DC69036C_4AD5DBBD0147_impl*
end;//TvcmBaseMenuManagerPrim.SubscribeMenuItemClickListener

procedure TvcmBaseMenuManagerPrim.UnsubscribeMenuItemClickListener(const aListener: IvcmMenuItemClickListener);
//#UC START# *53E9DC960383_4AD5DBBD0147_var*
//#UC END# *53E9DC960383_4AD5DBBD0147_var*
begin
//#UC START# *53E9DC960383_4AD5DBBD0147_impl*
 Assert(MenuItemClickListeners.IndexOf(aListener) <> -1);
 MenuItemClickListeners.Remove(aListener);
//#UC END# *53E9DC960383_4AD5DBBD0147_impl*
end;//TvcmBaseMenuManagerPrim.UnsubscribeMenuItemClickListener

procedure TvcmBaseMenuManagerPrim.NotifyMenuItemClick(aMenuItem: TvcmMenuItem);
//#UC START# *53E9E9BC021D_4AD5DBBD0147_var*
//#UC END# *53E9E9BC021D_4AD5DBBD0147_var*
begin
//#UC START# *53E9E9BC021D_4AD5DBBD0147_impl*
 NotifyMenuItemClickListeners(aMenuItem);
//#UC END# *53E9E9BC021D_4AD5DBBD0147_impl*
end;//TvcmBaseMenuManagerPrim.NotifyMenuItemClick

procedure TvcmBaseMenuManagerPrim.NotifyMenuItemClickListeners(aMenuItem: TvcmMenuItem);
//#UC START# *53E9E9EC013B_4AD5DBBD0147_var*

 function lp_DoNotifyListeners(anItem: PvcmMenuItemClickListener;
                               anIndex: Integer): Boolean;
 var
  l_Listener: IvcmMenuItemClickListener;
 begin
  l_Listener := anItem^;
  Assert(l_Listener <> nil);
  try
   l_Listener.NotifyMenuItemClicked(aMenuItem);
  finally
   l_Listener := nil;
  end;
  Result := True;
 end;//lp_DoNotifyListeners

//#UC END# *53E9E9EC013B_4AD5DBBD0147_var*
begin
//#UC START# *53E9E9EC013B_4AD5DBBD0147_impl*
 MenuItemClickListeners.IterateAllF(l3L2IA(@lp_DoNotifyListeners));
//#UC END# *53E9E9EC013B_4AD5DBBD0147_impl*
end;//TvcmBaseMenuManagerPrim.NotifyMenuItemClickListeners

procedure TvcmBaseMenuManagerPrim.Define(const aName: AnsiString;
 const aRus: AnsiString;
 const anAlien: AnsiString);
//#UC START# *4BB9C06901AE_4AD5DBBD0147_var*
const
 cTypes : array [TvcmObject] of AnsiString =
  (c_vcmModule, c_vcmEntity,
   c_vcmOperation, c_vcmModuleOperation,
   c_vcmControl,
   c_vcmMessage,
   c_vcmForm,
   c_vcmMenuItem,
   c_vcmUserType,
   c_vcmState,
   c_vcmString,
   c_vcmFormSetFactory);
var
 l_Type : TvcmObject;
 l_Name : AnsiString;
 l_Diff : Integer;
 l_Prop : AnsiString;
 l_SubName : AnsiString;
//#UC END# *4BB9C06901AE_4AD5DBBD0147_var*
begin
//#UC START# *4BB9C06901AE_4AD5DBBD0147_impl*
 if anAlien <> '' then
  for l_Type := Low(l_Type) to High(l_Type) do
  begin
   if ANSIStartsText(cTypes[l_Type], aName) then
   begin
    l_Diff := Length(cTypes[l_Type]) + 1;
    l_Name := Copy(aName, l_Diff + 1, Length(aName) - l_Diff);
    l_Diff := Pos(c_vcmContentSep, l_Name);
    l_SubName := Copy(l_Name, l_Diff + 1, Length(l_Name) - l_Diff);
    l_Name := Copy(l_Name, 1, l_Diff - 1);
    l_Diff := Pos(c_vcmContentSep, l_SubName);
    if (l_Diff > 0) then
    begin
     l_Diff := Length(l_SubName) - Pos(c_vcmContentSep, ReverseString(l_SubName)) + 1;
     l_Prop := Copy(l_SubName, l_Diff + 1, Length(l_SubName) - l_Diff);
     l_SubName := Copy(l_SubName, 1, l_Diff - 1);
    end//l_Diff > 0
    else
    begin
     l_Prop := l_SubName;
     l_SubName := '';
    end;//l_Diff > 0
    DefineObjectProp(l_Type, l_Name, l_SubName, l_Prop, anAlien);
    Exit;
   end;//ANSIStartsText(cTypes[l_Type], aName)
  end;//for l_Type
//#UC END# *4BB9C06901AE_4AD5DBBD0147_impl*
end;//TvcmBaseMenuManagerPrim.Define

procedure TvcmBaseMenuManagerPrim.Cleanup;
 {* ������� ������� ����� �������. }
//#UC START# *479731C50290_4AD5DBBD0147_var*
//#UC END# *479731C50290_4AD5DBBD0147_var*
begin
//#UC START# *479731C50290_4AD5DBBD0147_impl*
 FreeAndNil(f_Messages);
 FreeAndNil(f_Modules);
{$IfNDef DesignTimeLibrary}
 vcmFree(f_FormActivateManager);
{$EndIf DesignTimeLibrary}
 g_MenuManager := nil;
 FreeAndNil(f_AppForms);
// FreeAndNil(f_FormSetFactories);
 FreeAndNil(f_MenuItemClickListeners);
 inherited;
 FreeAndNil(f_Strings);
//#UC END# *479731C50290_4AD5DBBD0147_impl*
end;//TvcmBaseMenuManagerPrim.Cleanup

constructor TvcmBaseMenuManagerPrim.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_4AD5DBBD0147_var*
var
 l_Controller : TOvcController;
//#UC END# *47D1602000C6_4AD5DBBD0147_var*
begin
//#UC START# *47D1602000C6_4AD5DBBD0147_impl*
 if (g_MenuManager <> nil) then
  raise Exception.Create('MenuManager � ���������� ����� ���� ������ ����');
 inherited;
 f_SaveFormZones := vcm_SaveFormZones;
 f_HistoryZones := vcm_HistoryZones;
 g_MenuManager := Self as TvcmBaseMenuManager;
 f_Modules := GetModulesCollectionClass.Create(Self);
 f_AppForms := TvcmFormsCollection.Create(Self);
 f_Strings := TvcmStringCollection.Create(Self);
 f_Messages := TvcmMessagesCollection.Create(Self);
 {$IfNDef DesignTimeLibrary}
 f_FormActivateManager := TvcmFormActivateManager.Create;
 {$EndIf DesignTimeLibrary}
 l_Controller := GetDefController;
 if Assigned(l_Controller) then
  with l_Controller.EntryCommands do
  begin
   ExtTableName := c_vcmTableName;
   StopExtTableName := c_vcmStopTableName;
   OnExtCommand := DoShortCutCommand;
   CreateCommandTable(c_vcmStopTableName, true);
  end;//with l_Controller.EntryCommands
 f_ToolbarPopup := TvcmPopupMenuPrim.Create(Self);
//#UC END# *47D1602000C6_4AD5DBBD0147_impl*
end;//TvcmBaseMenuManagerPrim.Create

procedure TvcmBaseMenuManagerPrim.Loaded;
//#UC START# *484516C00214_4AD5DBBD0147_var*
var
 l_Controller : TOvcController;
//#UC END# *484516C00214_4AD5DBBD0147_var*
begin
//#UC START# *484516C00214_4AD5DBBD0147_impl*
 inherited;
 {$IfDef DesignTimeLibrary}
 (* �������� ���������� ����������, ������, ��� ��� ��� RunTime-� ���������, �
    ����� ��������� �������� *)
 f_Messages.Sorted := True;
 f_Strings.Sorted := true;
 RegisterEntities;
 {$Else  DesignTimeLibrary}
 {$EndIf DesignTimeLibrary}
 ConstStringsToMenuManager;
 l_Controller := GetDefController;
 if Assigned(l_Controller) then
  if Assigned(f_OnInitCommands) then
   f_OnInitCommands(Self, l_Controller.EntryCommands);
 {$IfNDef DesignTimeLibrary}
 RegisterKeywords;
 // - http://mdp.garant.ru/pages/viewpage.action?pageId=290266465
 afw.Application.ApplyActiveLanguage(Self);
 {$EndIf  DesignTimeLibrary}
//#UC END# *484516C00214_4AD5DBBD0147_impl*
end;//TvcmBaseMenuManagerPrim.Loaded

procedure TvcmBaseMenuManagerPrim.Notification(AComponent: TComponent;
 Operation: TOperation);
//#UC START# *4F884378016A_4AD5DBBD0147_var*
//#UC END# *4F884378016A_4AD5DBBD0147_var*
begin
//#UC START# *4F884378016A_4AD5DBBD0147_impl*
 inherited Notification(AComponent, Operation);
 if Operation = opRemove then
  if AComponent = SmallImages then
   SmallImages := nil
  else
   if AComponent = LargeImages then
    LargeImages := nil;
//#UC END# *4F884378016A_4AD5DBBD0147_impl*
end;//TvcmBaseMenuManagerPrim.Notification

procedure TvcmBaseMenuManagerPrim.WriteState(Writer: TWriter);
//#UC START# *4FD092040227_4AD5DBBD0147_var*
//#UC END# *4FD092040227_4AD5DBBD0147_var*
begin
//#UC START# *4FD092040227_4AD5DBBD0147_impl*
{$IfDef DesignTimeLibrary}
 WriteRes;
{$EndIf DesignTimeLibrary}
 inherited;
//#UC END# *4FD092040227_4AD5DBBD0147_impl*
end;//TvcmBaseMenuManagerPrim.WriteState

class function TvcmBaseMenuManagerPrim.GetEntitiesCollectionClass: RvcmBaseCollection;
//#UC START# *52A1ED12039D_4AD5DBBD0147_var*
//#UC END# *52A1ED12039D_4AD5DBBD0147_var*
begin
//#UC START# *52A1ED12039D_4AD5DBBD0147_impl*
 Result := TvcmRepEntitiesCollection;
//#UC END# *52A1ED12039D_4AD5DBBD0147_impl*
end;//TvcmBaseMenuManagerPrim.GetEntitiesCollectionClass

{$If NOT Defined(NoVCL)}
{$IfEnd} // NOT Defined(NoVCL)
function TvcmPopupMenuHelper.CheckPopup(const anEntityDef: IvcmEntityDef): IvcmEntity;
//#UC START# *51ED0195036B_55002183037A_var*
var
 l_Comp: TComponent;
//#UC END# *51ED0195036B_55002183037A_var*
begin
//#UC START# *51ED0195036B_55002183037A_impl*
 l_Comp := f_Popup.PopupComponent;
 if (l_Comp is TControl) then
  with TControl(l_Comp).ScreenToClient(f_Popup.PopupPoint) do
   Result := f_PopupForm.GetInnerForControl(anEntityDef.ID, l_Comp, X, Y)
 else
  Result := f_PopupForm.GetInnerForControl(anEntityDef.ID, l_Comp);
//#UC END# *51ED0195036B_55002183037A_impl*
end;//TvcmPopupMenuHelper.CheckPopup

{$If NOT Defined(NoVCL)}
function TvcmPopupMenuHelper.GetPopupMenu(aControl: TComponent;
 const aPoint: TPoint): TMenuItem;
//#UC START# *1FF8AE53688A_55002183037A_var*
var
 l_M : TvcmPopupMenuPrim;
//#UC END# *1FF8AE53688A_55002183037A_var*
begin
//#UC START# *1FF8AE53688A_55002183037A_impl*
 Assert(g_MenuManager <> nil);
 l_M := g_MenuManager.FillPopupMenu(aPoint, aControl);
 if (l_M = nil) then
  Result := nil
 else
  Result := l_M.Items;
//#UC END# *1FF8AE53688A_55002183037A_impl*
end;//TvcmPopupMenuHelper.GetPopupMenu
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCL)}
procedure TvcmPopupMenuHelper.GetPopupMenuForComponentInfo(aControl: TComponent;
 const aPoint: TPoint;
 aCallback: Tl3PopupMenuHelperCallback);
//#UC START# *E1C719B751DC_55002183037A_var*
 procedure GetvcmPopupMenu(aControl: TComponent; aMenu: TMenuItem);
 var
  l_Form: TCustomForm;
 begin
  l_Form := afw.GetParentForm(aControl);
  if l_Form is TvcmEntityForm then
  begin
   f_PopupForm := TvcmEntityForm(l_Form);
   vcmMakeEntitiesMenus(aMenu,
                        TvcmEntitiesDefIteratorForContextMenu.Make(f_PopupForm.GetEntitiesDefIterator),
                        [vcm_ooShowInContextMenu],
                        True,
                        vcm_icExternal,
                        nil,
                        CheckPopup
                        );
  end;
 end;

var
 l_Menu: TPopupMenu;
//#UC END# *E1C719B751DC_55002183037A_var*
begin
//#UC START# *E1C719B751DC_55002183037A_impl*
 l_Menu := nil;
 f_Popup := TvcmPopupMenuPrim.Create(aControl);
 try
  f_Popup.PopupComponent := aControl;
  PPoint(@f_Popup.PopupPoint)^ := aPoint;
  GetvcmPopupMenu(aControl, f_Popup.Items);
  if f_Popup.Items.Count > 0 then
   l_Menu := f_Popup;
  if not Assigned(l_Menu) then
   l_Menu := g_MenuManager.FillPopupMenu(aPoint, aControl);
  if not Assigned(l_Menu) then
   l_Menu := TControlFriend(aControl).PopupMenu;
  if Assigned(l_Menu) then
   aCallback(l_Menu.Items);
 finally
  l3Free(f_Popup);
 end;
//#UC END# *E1C719B751DC_55002183037A_impl*
end;//TvcmPopupMenuHelper.GetPopupMenuForComponentInfo
{$IfEnd} // NOT Defined(NoVCL)

class function TvcmPopupMenuHelper.Instance: TvcmPopupMenuHelper;
 {* ����� ��������� ���������� ���������� TvcmPopupMenuHelper }
begin
 if (g_TvcmPopupMenuHelper = nil) then
 begin
  l3System.AddExitProc(TvcmPopupMenuHelperFree);
  g_TvcmPopupMenuHelper := Create;
 end;
 Result := g_TvcmPopupMenuHelper;
end;//TvcmPopupMenuHelper.Instance

class function TvcmPopupMenuHelper.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TvcmPopupMenuHelper <> nil;
end;//TvcmPopupMenuHelper.Exists

function TvcmBaseMenuManager.FillPopupMenu(const aPopupPoint: TPoint;
 aPopupComponent: TComponent): TvcmPopupMenuPrim;
//#UC START# *52A841C500C5_52A1F4A201F9_var*
//#UC END# *52A841C500C5_52A1F4A201F9_var*
begin
//#UC START# *52A841C500C5_52A1F4A201F9_impl*
 Result := nil;
//#UC END# *52A841C500C5_52A1F4A201F9_impl*
end;//TvcmBaseMenuManager.FillPopupMenu

//#UC START# *52A1F4A201F9impl*
//#UC END# *52A1F4A201F9impl*

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvcmBaseMenuManagerPrim);
 {* ����������� TvcmBaseMenuManagerPrim }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoVCL)}
 Tl3PopupMenuHelper.Instance.Alien := TvcmPopupMenuHelper.Instance;
{$IfEnd} // NOT Defined(NoVCL)
 {* ����������� TvcmPopupMenuHelper }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvcmBaseMenuManager);
 {* ����������� TvcmBaseMenuManager }
{$IfEnd} // NOT Defined(NoScripts)
//#UC START# *52A1F92402C1*
 g_MenuManager := nil;
 g_ShortcutProcessingEnabled := False;
 g_FirstShortCutLoad := True;
//#UC END# *52A1F92402C1*
{$IfEnd} // NOT Defined(NoVCM)

end.
