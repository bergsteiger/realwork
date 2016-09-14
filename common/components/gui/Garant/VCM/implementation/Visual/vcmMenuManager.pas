unit vcmMenuManager;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Visual\vcmMenuManager.pas"
// Стереотип: "GuiControl"
// Элемент модели: "TvcmMenuManager" MUID: (4B30EC67025A)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 {$If NOT Defined(NoTB97)}
 , tb97vt
 {$IfEnd} // NOT Defined(NoTB97)
 , vcmPopupMenuPrim
 , Messages
 , vcmUserControls
 , vtComboTree
 {$If NOT Defined(NoTB97)}
 , TB97ExtInterfaces
 {$IfEnd} // NOT Defined(NoTB97)
 , Classes
 {$If NOT Defined(NoVCL)}
 , ExtCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 , evButton
 , vcmExternalInterfaces
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , vcmInterfaces
 , vcmBaseMenuManager
 {$If NOT Defined(NoVCL)}
 , ImgList
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , ActnList
 {$IfEnd} // NOT Defined(NoVCL)
 , vcmToolbarMenuRes
 , vcmMenuItemsCollection
 , vcmUserTypeDefList
 , l3ProtoObjectRefList
 , vcmBase
 , IafwMenuUnlockedPostBuildPtrList
 , vcmEntityForm
 , vcmMenuManagerTypes
 , vcmToolbar
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoTB97)}
 , tb97Ctls
 {$IfEnd} // NOT Defined(NoTB97)
 {$If NOT Defined(NoTB97)}
 , TB97Tlbr
 {$IfEnd} // NOT Defined(NoTB97)
 {$If NOT Defined(NoTB97)}
 , TB97
 {$IfEnd} // NOT Defined(NoTB97)
 {$If NOT Defined(NoVCL)}
 , Menus
 {$IfEnd} // NOT Defined(NoVCL)
 , vcmBaseCollectionItem
 , afwInterfaces
 , Types
 , vcmOperationAction
 , l3Interfaces
 , vtDblClickDateEdit
 , l3ProtoObject
 , l3MenuManagerHelper
 , l3DispatcherHelper
 , l3ProtoDataContainer
 , l3Memory
 , l3Types
 , l3Core
 , l3Except
 , vcmWinControlActionLink
 //#UC START# *4B30EC67025Aintf_uses*
 //#UC END# *4B30EC67025Aintf_uses*
;

const
 {* Алиасы для значений vcmMenuManagerTypes.TvcmMenuOption }
 vcm_moEntitiesInMainMenu = vcmMenuManagerTypes.vcm_moEntitiesInMainMenu;
 vcm_moEntitiesInTopMainMenu = vcmMenuManagerTypes.vcm_moEntitiesInTopMainMenu;
 vcm_moEntitiesInChildMenu = vcmMenuManagerTypes.vcm_moEntitiesInChildMenu;
 vcm_moEntitesInContextMenu = vcmMenuManagerTypes.vcm_moEntitesInContextMenu;
 {* Алиасы для значений vcmMenuManagerTypes.TvcmToolbarOption }
 vcm_toModulesInMainToolbar = vcmMenuManagerTypes.vcm_toModulesInMainToolbar;
 vcm_toEntitiesInMainToolbar = vcmMenuManagerTypes.vcm_toEntitiesInMainToolbar;
 vcm_toEntitiesInChildToolbar = vcmMenuManagerTypes.vcm_toEntitiesInChildToolbar;
 vcm_DefaultMenuOptions = [vcm_moEntitiesInMainMenu, vcm_moEntitiesInTopMainMenu];
 vcm_DefaultToolbarOptions = [vcm_toModulesInMainToolbar, vcm_toEntitiesInMainToolbar];
 CM_TBMOUSEQUERY = tb97vt.CM_TBMOUSEQUERY;
 CM_TBCHECKCONTROL = tb97vt.CM_TBCHECKCONTROL;

type
 TvcmPopupMenu = class(TvcmPopupMenuPrim)
  private
   f_InPopup: Boolean;
  public
   procedure ClearInPopup;
   {$If NOT Defined(NoVCL)}
   function IsShortCut(var Message: TWMKey): Boolean; override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   procedure Popup(X: Integer;
    Y: Integer); override;
   {$IfEnd} // NOT Defined(NoVCL)
 end;//TvcmPopupMenu

{$If Defined(vcmUseSettings)}
 TvcmButtonDef = record
  rPos: Cardinal;
  rEn: IvcmOperationalIdentifiedUserFriendlyControl;
  rOp: IvcmOperationDef;
  rOptions: TvcmOperationOptions;
  rNeedSep: Boolean;
  rIconText: Boolean;
  rLoaded: Boolean;
 end;//TvcmButtonDef
{$IfEnd} // Defined(vcmUseSettings)

 TvcmFakeBox = class(TvtComboTree{$If NOT Defined(NoTB97)}
 , ITB97Ctrl
 {$IfEnd} // NOT Defined(NoTB97)
 )
  {* общая функциональность необходимая vcm при использовании TFakeBox }
  private
   f_MinWidth: Integer;
  protected
   {$If NOT Defined(NoTB97)}
   function Get_FullWidth: Integer;
   {$IfEnd} // NOT Defined(NoTB97)
   {$If NOT Defined(NoTB97)}
   function Get_IsSizeable: Boolean;
   {$IfEnd} // NOT Defined(NoTB97)
   {$If NOT Defined(NoTB97)}
   function Get_MinWidth: Integer;
   {$IfEnd} // NOT Defined(NoTB97)
   {$If NOT Defined(NoTB97)}
   procedure DoFitToWidth(aWidth: Integer);
   {$IfEnd} // NOT Defined(NoTB97)
   {$If NOT Defined(NoTB97)}
   procedure DoUnFitToWidth(aWidth: Integer);
   {$IfEnd} // NOT Defined(NoTB97)
   {$If NOT Defined(NoTB97)}
   procedure Expand;
   {$IfEnd} // NOT Defined(NoTB97)
  public
   constructor Create(AOwner: TComponent); override;
 end;//TvcmFakeBox

 TvcmDockContainer = class({$If NOT Defined(NoVCL)}
 TPanel
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Панель используемая для размещения главной панели инструментов формы. }
  public
   constructor Create(AOwner: TComponent); override;
 end;//TvcmDockContainer

{$If Defined(vcmUseSettings)}
 TvcmButtonDefs = array of TvcmButtonDef;
{$IfEnd} // Defined(vcmUseSettings)

 TvcmIconTextType = (
  vcm_itDefault
  , vcm_itIcon
  , vcm_itIconText
 );//TvcmIconTextType

 TvcmToolButtonDefActionLink = class(TevCustomButtonActionLink, IvcmActionLink)
  protected
   procedure ParamsChanged(const anAction: IvcmAction);
   procedure ParamsChanging(const anAction: IvcmAction);
 end;//TvcmToolButtonDefActionLink

 TvcmToolButtonDef = class(TevButton)
  protected
   {$If NOT Defined(NoVCL)}
   function GetActionLinkClass: TControlActionLinkClass; override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoTB97)}
   function NeedAutoDown: Boolean; override;
   {$IfEnd} // NOT Defined(NoTB97)
   function HackCheck: Boolean; override;
   {$If NOT Defined(NoTB97)}
   function AutoAllUp: Boolean; override;
   {$IfEnd} // NOT Defined(NoTB97)
  public
   function IsIconText: Boolean;
 end;//TvcmToolButtonDef

 TvcmGlyphColordepth = (
  vcm_gcAuto
  , vcm_gc16
  , vcm_gc256
  , vcm_gcTrueColor
 );//TvcmGlyphColordepth

{$If Defined(vcmUseSettings)}
 TvcmToolbarDefForMenuManager = record
  rVisibleLoaded: Boolean;
  rVisible: Boolean;
  rButtons: TvcmButtonDefs;
  rUserType: IvcmUserTypeDef;
  rToolbarName: AnsiString;
 end;//TvcmToolbarDefForMenuManager
{$IfEnd} // Defined(vcmUseSettings)

 TvcmButtonPopupMenu = class(TvcmPopupMenuPrim)
 end;//TvcmButtonPopupMenu

{$If Defined(vcmUseSettings)}
 TvcmToolbarDefsForMenuManager = array [TvcmEffectiveToolBarPos] of TvcmToolbarDefForMenuManager;
{$IfEnd} // Defined(vcmUseSettings)

 (*
 MvcmToolbarGlyphService = interface
  {* Контракт сервиса TvcmToolbarGlyphService }
  procedure SetGlyphSize(aValue: TvcmGlyphSize);
  function GetGlyphSize: TvcmGlyphSize;
  function GetGlyphColorDepth: TvcmGlyphColordepth;
  procedure SetGlyphColorDepth(aValue: TvcmGlyphColordepth);
 end;//MvcmToolbarGlyphService
 *)

 IvcmToolbarGlyphService = interface
  {* Интерфейс сервиса TvcmToolbarGlyphService }
  procedure SetGlyphSize(aValue: TvcmGlyphSize);
  function GetGlyphSize: TvcmGlyphSize;
  function GetGlyphColorDepth: TvcmGlyphColordepth;
  procedure SetGlyphColorDepth(aValue: TvcmGlyphColordepth);
 end;//IvcmToolbarGlyphService

 TvcmToolbarGlyphService = {final} class(Tl3ProtoObject)
  private
   f_Alien: IvcmToolbarGlyphService;
    {* Внешняя реализация сервиса IvcmToolbarGlyphService }
  protected
   procedure pm_SetAlien(const aValue: IvcmToolbarGlyphService);
   procedure ClearFields; override;
  public
   procedure SetGlyphSize(aValue: TvcmGlyphSize);
   function GetGlyphSize: TvcmGlyphSize;
   function GetGlyphColorDepth: TvcmGlyphColordepth;
   procedure SetGlyphColorDepth(aValue: TvcmGlyphColordepth);
   class function Instance: TvcmToolbarGlyphService;
    {* Метод получения экземпляра синглетона TvcmToolbarGlyphService }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
  public
   property Alien: IvcmToolbarGlyphService
    write pm_SetAlien;
    {* Внешняя реализация сервиса IvcmToolbarGlyphService }
 end;//TvcmToolbarGlyphService

 TvcmCustomMenuManager = class(TvcmBaseMenuManager)
  private
   f_FocusControl: TWinControl;
   f_InEnter: Boolean;
   f_WasDrop: Boolean;
   f_TickCount: Cardinal;
    {* можно избавиться? }
   f_UserTypesLoaded: Boolean;
   f_IsUnlockExecute: Boolean;
   f_SaveDockList: Tl3ProtoObjectRefList;
   f_SaveLockCounter: TvcmLongintList;
   f_LockCounter: Integer;
   f_UnlockInProgress: Integer;
   f_FastenToolbars: Integer;
   f_ButtonHeight: Integer;
   f_LockList: TIafwMenuUnlockedPostBuildPtrList;
   {$If Defined(vcmUseSettings)}
   f_MainToolbarDefs: TvcmToolbarDefsForMenuManager;
   {$IfEnd} // Defined(vcmUseSettings)
   f_Popup: TvcmPopupMenu;
   f_PopupForm: TvcmEntityForm;
   f_DockButtonsImageList: TCustomImageList;
    {* imagelist используемый для кнопок области dock-а }
   f_BtnCloseImageIndex: TImageIndex;
   f_BtnOpenImageIndex: TImageIndex;
   f_BtnOpenNewWindowImageIndex: TImageIndex;
   f_Actions: TCustomActionList;
   f_GlyphSize: TvcmGlyphSize;
   f_GlyphColordepth: TvcmGlyphColordepth;
   f_MainMenuItems: TvcmMenuItemsCollection;
   f_UserTypes: TvcmUserTypeDefList;
   f_SmallToolbarSize: Integer;
    {* размер toolbar-а в котором находятся кнопки с маленькими иконками, компонентами TvcmEdit и TvcmDateEdit }
   f_MaxControlToolbarSize: Integer;
    {* максимальная высота компонента находящегося в toolbar-е }
   f_OneToolbarPerForm: Boolean;
   f_OnGlyphSizeChanged: TNotifyEvent;
   f_OnGlyphColordepthChanged: TNotifyEvent;
   f_MenuOptions: TvcmMenuOptions;
   f_ToolbarOptions: TvcmToolbarOptions;
  private
   procedure OverridePopupMenu(aForm: TCustomForm);
  protected
   procedure pm_SetDockButtonsImageList(aValue: TCustomImageList);
   procedure pm_SetActions(aValue: TCustomActionList);
   procedure pm_SetGlyphSize(aValue: TvcmGlyphSize);
   procedure pm_SetGlyphColordepth(aValue: TvcmGlyphColordepth);
   procedure pm_SetMainMenuItems(aValue: TvcmMenuItemsCollection);
   function ToolbarButtonSize(aToolbarButton: TCustomToolbarButton97;
    var aSize: Integer): Boolean; overload;
   procedure ToolbarButtonSize(aToolbarButton: TCustomToolbarButton97); overload;
    {* устанавливает ширину и высоту кнопки }
   procedure ToolbarSize(aToolbar: TCustomToolbar97;
    var aSize: Integer);
    {* определяет размер toolbar-а }
   procedure RefocusEntity;
   procedure RestoreControlText(Sender: TObject);
   procedure ChangeEntityText(Sender: TObject);
   procedure ChangeTyperText(Sender: TObject);
   procedure ControlKeyDown(Sender: TObject;
    var Key: Word;
    Shift: TShiftState);
   procedure ControlEnter(Sender: TObject);
   procedure ControlExit(Sender: TObject);
   procedure ControlDown(Sender: TObject);
   procedure DateDown(Sender: TObject);
   procedure ComboDown(Sender: TObject);
   procedure ControlSelect(Sender: TObject);
   procedure FormChange(Sender: TObject);
   procedure DoPopup(Sender: TObject);
   function CheckPopup(const anEntityDef: IvcmEntityDef): IvcmEntity;
   function GetToolbarName(aForm: TvcmEntityForm;
    const aDef: IvcmOperationalIdentifiedUserFriendlyControl;
    anIndex: Integer): AnsiString;
   {$If NOT Defined(DesignTimeLibrary)}
   function BuildToolbar(aForm: TvcmEntityForm;
    const aDef: IvcmOperationalIdentifiedUserFriendlyControl;
    anIndex: Integer): TvcmToolbarDef; overload;
    {* anIndex - порядковый номер Toolbar'а (для огранизации нескольких Toolbar'ов в одном доке) }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   procedure FillToolbar(aForm: TvcmEntityForm;
    var aToolBar: TvcmToolbarDef;
    const aHolder: IvcmOperationalIdentifiedUserFriendlyControl;
    const anOperations: IvcmOperationsDefIterator;
    anOptions: TvcmOperationOptions);
   procedure CheckToolbar(var aToolBar: TvcmToolbarDef);
   {$If NOT Defined(DesignTimeLibrary)}
   function MakeToolbar(aForm: TvcmEntityForm;
    const aHolder: IvcmOperationalIdentifiedUserFriendlyControl;
    anOptions: TvcmOperationOptions;
    anExcludePoses: TvcmEffectiveToolBarPoses): Boolean;
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   {$If NOT Defined(DesignTimeLibrary)}
   procedure BuildEntitiesToolbars(aForm: TvcmEntityForm;
    const anEntities: IvcmEntitiesDefIterator;
    anOptions: TvcmOperationOptions;
    anExcludePoses: TvcmEffectiveToolBarPoses);
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   {$If Defined(vcmUseSettings)}
   function LoadButtonsFromSettings(const aUserType: IvcmUserTypeDef;
    const aToolbar: AnsiString;
    AddUnsavedButton: Boolean;
    var theButton: TvcmButtonDef;
    var theButtons: TvcmButtonDefs): Boolean;
   {$IfEnd} // Defined(vcmUseSettings)
   {$If Defined(vcmUseSettings)}
   procedure MakeToolbarFromSettings(aForm: TvcmEntityForm;
    const aToolbarName: AnsiString;
    aPos: TvcmEffectiveToolBarPos;
    anOptions: TvcmOperationOptions;
    const theButtons: TvcmButtonDefs);
   {$IfEnd} // Defined(vcmUseSettings)
   {$If Defined(vcmUseSettings)}
   procedure MakeMainToolbarFromSettings(aForm: TvcmEntityForm);
   {$IfEnd} // Defined(vcmUseSettings)
   {$If NOT Defined(DesignTimeLibrary)}
   procedure BuildFormToolbars(aForm: TvcmEntityForm;
    anOptions: TvcmOperationOptions);
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   {$If NOT Defined(DesignTimeLibrary)}
   procedure BuildMainToolbars(aForm: TvcmEntityForm;
    const aModuleDef: IvcmModuleDef);
    {* создает Toolbar'ы основной формы }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   procedure CheckUserTypes;
   procedure BuildUserTypes(const aModuleDef: IvcmModuleDef);
   procedure ToolbarsGetSiteInfo(Sender: TObject;
    DockClient: TCustomToolWindow97;
    var CanDock: Boolean);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   function BuildButton(aForm: TvcmEntityForm;
    aToolBar: TvcmToolbarDef;
    const aModuleDef: IvcmModuleDef;
    const anEntityDef: IvcmEntityDef;
    const anOp: IvcmOperationDef;
    anOptions: TvcmOperationOptions;
    anIconText: TvcmIconTextType = vcm_itDefault): TControl; overload;
   function BuildButton(aForm: TvcmEntityForm;
    aToolBar: TvcmToolbarDef;
    const aModuleDef: IvcmModuleDef;
    const anEntityDef: IvcmEntityDef;
    const anOp: IvcmOperationDef;
    anOpOptions: TvcmOperationOptions;
    anOptions: TvcmOperationOptions;
    anIconText: TvcmIconTextType = vcm_itDefault): TControl; overload;
   function BuildButton(aForm: TvcmEntityForm;
    aToolBar: TvcmToolbarDef;
    const aHolder: IvcmOperationalIdentifiedUserFriendlyControl;
    const anOp: IvcmOperationDef;
    anOpOptions: TvcmOperationOptions;
    anOptions: TvcmOperationOptions;
    anIconText: TvcmIconTextType = vcm_itDefault): TControl; overload;
   function BuildButton(aForm: TvcmEntityForm;
    aToolBar: TvcmToolbarDef;
    const aHolder: IvcmOperationalIdentifiedUserFriendlyControl;
    const anOp: IvcmOperationDef;
    anOptions: TvcmOperationOptions;
    anIconText: TvcmIconTextType = vcm_itDefault): TControl; overload;
   function BuildAction(const aModuleDef: IvcmModuleDef;
    const anOpDef: IvcmOperationDef): TCustomAction; overload;
   function BuildAction(anOwner: TComponent;
    const anEntity: IvcmEntity;
    const anEntityDef: IvcmEntityDef;
    const anOpDef: IvcmOperationDef;
    anOptions: TvcmOperationOptions): TCustomAction; overload;
   function BuildSeparator(aToolBar: TvcmToolbarDef): TControl;
   function UserTypeByCaption(const aCaption: AnsiString;
    aFormClass: TClass = nil): IvcmUserTypeDef;
   function GetOneToolbarPerFormName(aForm: TvcmEntityForm;
    aPos: TvcmEffectiveToolBarPos;
    anIndex: Integer): AnsiString;
   {$If NOT Defined(DesignTimeLibrary)}
   function BuildToolbar(aForm: TvcmEntityForm;
    const aName: AnsiString;
    const aCaption: IvcmCString;
    aPos: TvcmEffectiveToolBarPos): TvcmToolbarDef; overload;
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   {$If NOT Defined(DesignTimeLibrary)}
   function BuildToolbar(aForm: TvcmEntityForm;
    aPos: TvcmEffectiveToolBarPos): TvcmToolbarDef; overload;
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   procedure CleanupSaveDockList(anItem: TvcmDockDef);
   function GetDockParent(aForm: TCustomForm): TWinControl;
   procedure LoadGlyphSize(aDefault: Boolean = False);
   procedure LoadGlyphColorDepth(aDefault: Boolean = False);
   procedure UnlockDocks;
   procedure LockDocks;
   procedure StoreGlyphSize;
   procedure RestoreGlyphSize;
   procedure StoreGlyphColordepth;
   procedure RestoreGlyphColordepth;
   procedure InitToolbarMetrics(aForm: TCustomForm);
    {* определить метрики панели инструментов. Компоненты, которые могут быть помещены в панель, могут иметь разные размеры, чтобы высота панелей была одинаковой, считаем максимальную высоту и используем её для всех панелей. }
   constructor Create(AOwner: TComponent); override;
   {$If NOT Defined(DesignTimeLibrary)}
   procedure RegisterModuleInMenu(aForm: TvcmEntityForm;
    const aModuleDef: IvcmModuleDef); override;
    {* регистрирует модуль в меню, toolbar'ах, etc. Для перекрытия в потомках. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   {$If NOT Defined(DesignTimeLibrary)}
   procedure MainCreated(aForm: TvcmEntityForm); override;
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   procedure RegisterMainInMenu(aForm: TvcmEntityForm); override;
    {* регистрирует основную форму в меню, toolbar'ах, etc. Для перекрытия в потомках. }
   {$If NOT Defined(DesignTimeLibrary)}
   procedure RegisterChildInMenu(aForm: TvcmEntityForm); override;
    {* регистрирует дочернюю форму в меню, toolbar'ах, etc. Для перекрытия в потомках. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   function GetPopupMenu: TPopupMenu; override;
   procedure ReloadToolbars(const aForm: IvcmEntityForm); override;
   procedure PostBuild(aForm: TvcmEntityForm;
    aFollowDocks: Boolean = False); override;
   procedure BackupOpStatus; override;
   procedure RestoreOpStatus; override;
   procedure BeginOp; override;
   function GetOpLock: Boolean; override;
   procedure EndOp; override;
   procedure FastenToolbars; override;
   function GetFastenMode: Boolean; override;
   function ObjectByType(anObject: TvcmObject;
    const anObjectName: AnsiString;
    const aSubName: AnsiString = '';
    ForceCreate: Boolean = False): TvcmBaseCollectionItem; override;
   function UnlockInProgress: Boolean; override;
   procedure AddControlForUnlockPostBuild(const aControl: IafwMenuUnlockedPostBuild); override;
   procedure ListenerControlDestroying(const aControl: IafwMenuUnlockedPostBuild); override;
   function FillPopupMenu(const aPopupPoint: TPoint;
    aPopupComponent: TComponent): TvcmPopupMenuPrim; override;
  public
   property DockButtonsImageList: TCustomImageList
    read f_DockButtonsImageList
    write pm_SetDockButtonsImageList;
    {* imagelist используемый для кнопок области dock-а }
   property BtnCloseImageIndex: TImageIndex
    read f_BtnCloseImageIndex
    write f_BtnCloseImageIndex;
   property BtnOpenImageIndex: TImageIndex
    read f_BtnOpenImageIndex
    write f_BtnOpenImageIndex;
   property BtnOpenNewWindowImageIndex: TImageIndex
    read f_BtnOpenNewWindowImageIndex
    write f_BtnOpenNewWindowImageIndex;
   property Actions: TCustomActionList
    read f_Actions
    write pm_SetActions;
   property GlyphSize: TvcmGlyphSize
    read f_GlyphSize
    write pm_SetGlyphSize;
   property GlyphColordepth: TvcmGlyphColordepth
    read f_GlyphColordepth
    write pm_SetGlyphColordepth;
   property MainMenuItems: TvcmMenuItemsCollection
    read f_MainMenuItems
    write pm_SetMainMenuItems;
   property UserTypes: TvcmUserTypeDefList
    read f_UserTypes;
   property SmallToolbarSize: Integer
    read f_SmallToolbarSize;
    {* размер toolbar-а в котором находятся кнопки с маленькими иконками, компонентами TvcmEdit и TvcmDateEdit }
   property MaxControlToolbarSize: Integer
    read f_MaxControlToolbarSize;
    {* максимальная высота компонента находящегося в toolbar-е }
   property OneToolbarPerForm: Boolean
    read f_OneToolbarPerForm
    write f_OneToolbarPerForm;
   property OnGlyphSizeChanged: TNotifyEvent
    read f_OnGlyphSizeChanged
    write f_OnGlyphSizeChanged;
   property OnGlyphColordepthChanged: TNotifyEvent
    read f_OnGlyphColordepthChanged
    write f_OnGlyphColordepthChanged;
   property MenuOptions: TvcmMenuOptions
    read f_MenuOptions
    write f_MenuOptions;
   property ToolbarOptions: TvcmToolbarOptions
    read f_ToolbarOptions
    write f_ToolbarOptions;
 end;//TvcmCustomMenuManager

 TvcmComboBoxActionLink = class(TvcmWinControlActionLink)
  protected
   {$If NOT Defined(NoVCL)}
   procedure SetCaption(const Value: String); override;
   {$IfEnd} // NOT Defined(NoVCL)
   procedure DoParamsChanged(const anAction: IvcmAction); override;
   procedure DoParamsChanging(const anAction: IvcmAction); override;
 end;//TvcmComboBoxActionLink

 TvcmComboBox = class(TvcmFakeBox)
  private
   f_InUpdateCation: Boolean;
  private
   procedure CMTBMouseQuery(var Msg: TMessage); message CM_TBMOUSEQUERY;
   procedure CMTBCheckControl(var Msg: TMessage); message CM_TBCHECKCONTROL;
  protected
   procedure SetCaptionFromAction(anAction: TvcmOperationAction;
    anUpdateIndex: Boolean);
   function SetStringsFromAction(const anAction: IvcmAction): Boolean;
   {$If NOT Defined(NoVCL)}
   function GetActionLinkClass: TControlActionLinkClass; override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   procedure ActionChange(Sender: TObject;
    CheckDefaults: Boolean); override;
   {$IfEnd} // NOT Defined(NoVCL)
   procedure DropDown; override;
   procedure ActionExecuteHandler; override;
   procedure LocalUpdateAction; override;
  public
   constructor Create(AOwner: TComponent); override;
 end;//TvcmComboBox

 TvcmEditActionLink = class(TvcmWinControlActionLink)
 end;//TvcmEditActionLink

 TvcmEdit = class(TvcmFakeBox)
  protected
   function DoProcessCommand(Cmd: Tl3OperationCode;
    aForce: Boolean;
    aCount: Integer): Boolean; override;
   {$If NOT Defined(NoVCL)}
   function GetActionLinkClass: TControlActionLinkClass; override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   procedure ActionChange(Sender: TObject;
    CheckDefaults: Boolean); override;
   {$IfEnd} // NOT Defined(NoVCL)
  public
   constructor Create(AOwner: TComponent); override;
 end;//TvcmEdit

 TvcmDateEditActionLink = class(TvcmWinControlActionLink)
  protected
   {$If NOT Defined(NoVCL)}
   function IsCaptionLinked: Boolean; override;
   {$IfEnd} // NOT Defined(NoVCL)
   procedure DoParamsChanged(const anAction: IvcmAction); override;
 end;//TvcmDateEditActionLink

 TvcmDateEdit = class(TvtDblClickDateEdit)
  private
   f_OnSelectDate: TNotifyEvent;
  private
   procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
  protected
   {$If NOT Defined(NoVCL)}
   function GetActionLinkClass: TControlActionLinkClass; override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   procedure ActionChange(Sender: TObject;
    CheckDefaults: Boolean); override;
   {$IfEnd} // NOT Defined(NoVCL)
   procedure DoCloseUp(Accept: Boolean); override;
  public
   constructor Create(AOwner: TComponent); override;
  public
   property OnSelectDate: TNotifyEvent
    read f_OnSelectDate
    write f_OnSelectDate;
 end;//TvcmDateEdit

 TvcmMenuManagerHelper = {final} class(Tl3ProtoObject, Il3MenuManagerHelper)
  public
   function CreateManager: Boolean;
   procedure FreeManager;
   class function Instance: TvcmMenuManagerHelper;
    {* Метод получения экземпляра синглетона TvcmMenuManagerHelper }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TvcmMenuManagerHelper

 TvcmDispatcherHelper = {final} class(Tl3ProtoObject, Il3DispatcherHelper)
  public
   procedure ClearHistory;
   class function Instance: TvcmDispatcherHelper;
    {* Метод получения экземпляра синглетона TvcmDispatcherHelper }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TvcmDispatcherHelper

 _ItemType_ = TvcmToolbarDef;
 _l3ObjectPtrList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3ObjectPtrList.imp.pas}
 TvcmToolbarDefList = class(_l3ObjectPtrList_)
 end;//TvcmToolbarDefList

 TvcmMenuOption = vcmMenuManagerTypes.TvcmMenuOption;

 TvcmToolbarOption = vcmMenuManagerTypes.TvcmToolbarOption;

 TvcmMenuOptions = vcmMenuManagerTypes.TvcmMenuOptions;

 TvcmToolbarOptions = vcmMenuManagerTypes.TvcmToolbarOptions;

 //#UC START# *4B30EC67025Aci*
 //#UC END# *4B30EC67025Aci*
 //#UC START# *4B30EC67025Acit*
 //#UC END# *4B30EC67025Acit*
 TvcmMenuManager = {final} class(TvcmCustomMenuManager)
 //#UC START# *4B30EC67025Apubl*
  published
   property Strings; 
   property DockButtonsImageList;
   property BtnCloseImageIndex;
   property BtnOpenImageIndex;
   property BtnOpenNewWindowImageIndex;
   property HistoryZones;
   property SaveFormZones;
   property Actions;
   property SmallImages;
   property LargeImages;
   property MainMenuItems;
   property MenuOptions default vcm_DefaultMenuOptions;
   property ToolbarOptions default vcm_DefaultToolbarOptions;
   property Modules;
   property Entities;
   property Messages;
   property OneToolbarPerForm;
   property OnInitCommands;
   property OnGlyphSizeChanged;
   property OnGlyphColordepthChanged;
   property OnOperationExecuteNotify;
 //#UC END# *4B30EC67025Apubl*
 end;//TvcmMenuManager
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , Windows
 , vcmEntitiesDefIteratorForContextMenu
 , vcmMenuManagerUtils
 , vcmMessages
 , l3InternalInterfaces
 , l3ScreenIC
 , TypInfo
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , StdCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 , l3String
 , ctTypes
 , OvcConst
 , vcmMenus
 , vcmAction
 , afwFacade
 , vcmInternalConst
 , l3Base
 , l3MinMax
 , vcmToolbarUtils
 , vcmSettings
 , vcmMainForm
 , vcmUtils
 , vcmModuleAction
 , vcmEntityAction
 , vcmFormHandler
 , vcmMenuManagerRes
 , vcmMenuItemsCollectionItem
 , vcmMainMenuAction
 , vcmChromeLikeTypes
 , vcmMainMenuBuilder
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , VCMApllicationSettingsPack
 {$IfEnd} // NOT Defined(NoScripts)
 , Graphics
 , RTLConsts
 //#UC START# *4B30EC67025Aimpl_uses*
 {$IfDef XE}
 , System.Actions
 {$EndIf}
 , vcmDispatcher
 //#UC END# *4B30EC67025Aimpl_uses*
;

type
 TvcmGlyphSizeMap = array [TvcmGlyphSize] of Cardinal;

 TvcmTBPosStringArray = array [TvcmEffectiveToolBarPos] of AnsiString;

 THackWinControl = class({$If NOT Defined(NoVCL)}
 TWinControl
 {$IfEnd} // NOT Defined(NoVCL)
 )
 end;//THackWinControl

 THackControl = class({$If NOT Defined(NoVCL)}
 TControl
 {$IfEnd} // NOT Defined(NoVCL)
 )
 end;//THackControl

 THackPopupMenu = class({$If NOT Defined(NoVCL)}
 TMenu
 {$IfEnd} // NOT Defined(NoVCL)
 )
  private
   FPopupPoint: TPoint;
 end;//THackPopupMenu

var g_TvcmToolbarGlyphService: TvcmToolbarGlyphService = nil;
 {* Экземпляр синглетона TvcmToolbarGlyphService }
var g_TvcmMenuManagerHelper: TvcmMenuManagerHelper = nil;
 {* Экземпляр синглетона TvcmMenuManagerHelper }
var g_TvcmDispatcherHelper: TvcmDispatcherHelper = nil;
 {* Экземпляр синглетона TvcmDispatcherHelper }
var g_InternalButton: TvcmToolButtonDef;

const
 c_vcmCloseBmpName = 'CLOSEBTN_DOCK97';
 c_vcmMaximizedBmpName = 'MAXIMIZEDBTN_DOCK97';
 c_vcmOpenBmpName = 'OPENBTN_DOCK97';
 c_vcmCloseImageIndex = 0;
 c_vcmMaximizedImageIndex = 1;
 c_vcmOpenImageIndex = 2;
 c_vcmDockContainerName = 'vcmDockContainer';
 c_GlyphSizeMap: TvcmGlyphSizeMap = (2, 0, 3, 1);
  {* c_GlyphSizeMap: array [TvcmGlyphSize] of Cardinal = (
   2, // vcm_gsAutomatic
   0, // vcm_gs16x16
   3, // vcm_gs24x24
   1 // vcm_gs32x32
  ); }
 cTBName: TvcmTBPosStringArray = ('Top', 'Bottom', 'Left', 'Right');

procedure TvcmToolbarGlyphServiceFree;
 {* Метод освобождения экземпляра синглетона TvcmToolbarGlyphService }
begin
 l3Free(g_TvcmToolbarGlyphService);
end;//TvcmToolbarGlyphServiceFree

procedure TvcmMenuManagerHelperFree;
 {* Метод освобождения экземпляра синглетона TvcmMenuManagerHelper }
begin
 l3Free(g_TvcmMenuManagerHelper);
end;//TvcmMenuManagerHelperFree

procedure TvcmDispatcherHelperFree;
 {* Метод освобождения экземпляра синглетона TvcmDispatcherHelper }
begin
 l3Free(g_TvcmDispatcherHelper);
end;//TvcmDispatcherHelperFree

procedure TvcmPopupMenu.ClearInPopup;
//#UC START# *52A091000334_51ED01600060_var*
//#UC END# *52A091000334_51ED01600060_var*
begin
//#UC START# *52A091000334_51ED01600060_impl*
 f_InPopup := False;
//#UC END# *52A091000334_51ED01600060_impl*
end;//TvcmPopupMenu.ClearInPopup

{$If NOT Defined(NoVCL)}
function TvcmPopupMenu.IsShortCut(var Message: TWMKey): Boolean;
//#UC START# *52A0905E002D_51ED01600060_var*
//#UC END# *52A0905E002D_51ED01600060_var*
begin
//#UC START# *52A0905E002D_51ED01600060_impl*
 if f_InPopup then
  Result := inherited IsShortCut(Message)
 else
 begin
  Result := False;
  RequestClearPopup(Self);
 end;//f_InPopup 
//#UC END# *52A0905E002D_51ED01600060_impl*
end;//TvcmPopupMenu.IsShortCut
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCL)}
procedure TvcmPopupMenu.Popup(X: Integer;
 Y: Integer);
//#UC START# *52A090A90317_51ED01600060_var*
//#UC END# *52A090A90317_51ED01600060_var*
begin
//#UC START# *52A090A90317_51ED01600060_impl*
 f_InPopup := True;
 inherited;
 RequestClearPopup(Self);
//#UC END# *52A090A90317_51ED01600060_impl*
end;//TvcmPopupMenu.Popup
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoTB97)}
function TvcmFakeBox.Get_FullWidth: Integer;
//#UC START# *52A8447101AF_52A8430201C5get_var*
//#UC END# *52A8447101AF_52A8430201C5get_var*
begin
//#UC START# *52A8447101AF_52A8430201C5get_impl*
 Result := FullWidth;
//#UC END# *52A8447101AF_52A8430201C5get_impl*
end;//TvcmFakeBox.Get_FullWidth
{$IfEnd} // NOT Defined(NoTB97)

{$If NOT Defined(NoTB97)}
function TvcmFakeBox.Get_IsSizeable: Boolean;
//#UC START# *52A8448E0050_52A8430201C5get_var*
//#UC END# *52A8448E0050_52A8430201C5get_var*
begin
//#UC START# *52A8448E0050_52A8430201C5get_impl*
 Result := True;
//#UC END# *52A8448E0050_52A8430201C5get_impl*
end;//TvcmFakeBox.Get_IsSizeable
{$IfEnd} // NOT Defined(NoTB97)

{$If NOT Defined(NoTB97)}
function TvcmFakeBox.Get_MinWidth: Integer;
//#UC START# *52A844A300F5_52A8430201C5get_var*
var
 l_CN: Il3InfoCanvas;
//#UC END# *52A844A300F5_52A8430201C5get_var*
begin
//#UC START# *52A844A300F5_52A8430201C5get_impl*
 if f_MinWidth < 0 then
 begin
  l_CN := l3CrtIC;
  l_CN.Font.AssignFont(Font);
  f_MinWidth := ButtonWidth + l_CN.LP2DP(l_CN.TextExtent(vcmWStr('WWW'))).X;
 end;
 Result := f_MinWidth;
//#UC END# *52A844A300F5_52A8430201C5get_impl*
end;//TvcmFakeBox.Get_MinWidth
{$IfEnd} // NOT Defined(NoTB97)

{$If NOT Defined(NoTB97)}
procedure TvcmFakeBox.DoFitToWidth(aWidth: Integer);
//#UC START# *52A844D303D9_52A8430201C5_var*
//#UC END# *52A844D303D9_52A8430201C5_var*
begin
//#UC START# *52A844D303D9_52A8430201C5_impl*
 Width := aWidth;
//#UC END# *52A844D303D9_52A8430201C5_impl*
end;//TvcmFakeBox.DoFitToWidth
{$IfEnd} // NOT Defined(NoTB97)

{$If NOT Defined(NoTB97)}
procedure TvcmFakeBox.DoUnFitToWidth(aWidth: Integer);
//#UC START# *52A844E6012E_52A8430201C5_var*
//#UC END# *52A844E6012E_52A8430201C5_var*
begin
//#UC START# *52A844E6012E_52A8430201C5_impl*
 Width := aWidth;
//#UC END# *52A844E6012E_52A8430201C5_impl*
end;//TvcmFakeBox.DoUnFitToWidth
{$IfEnd} // NOT Defined(NoTB97)

{$If NOT Defined(NoTB97)}
procedure TvcmFakeBox.Expand;
//#UC START# *52A844F600E6_52A8430201C5_var*
//#UC END# *52A844F600E6_52A8430201C5_var*
begin
//#UC START# *52A844F600E6_52A8430201C5_impl*
 Width := Get_FullWidth;
//#UC END# *52A844F600E6_52A8430201C5_impl*
end;//TvcmFakeBox.Expand
{$IfEnd} // NOT Defined(NoTB97)

constructor TvcmFakeBox.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_52A8430201C5_var*
//#UC END# *47D1602000C6_52A8430201C5_var*
begin
//#UC START# *47D1602000C6_52A8430201C5_impl*
 inherited;
 f_MinWidth := -1;
 SmartOnResize := False;
 SetToBeginOnTreeSelect := True;
//#UC END# *47D1602000C6_52A8430201C5_impl*
end;//TvcmFakeBox.Create

constructor TvcmDockContainer.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_52A0812B00B7_var*
//#UC END# *47D1602000C6_52A0812B00B7_var*
begin
//#UC START# *47D1602000C6_52A0812B00B7_impl*
 inherited Create(AOwner);
 Assert(AOwner.FindComponent(c_vcmDockContainerName) = nil, Format('В ''%s'' уже есть компонент с именем ''%s'';', [AOwner.Name, c_vcmDockContainerName]));
 Name := c_vcmDockContainerName;
 Caption := '';
 BevelInner := bvNone;
 BevelOuter := bvNone;
//#UC END# *47D1602000C6_52A0812B00B7_impl*
end;//TvcmDockContainer.Create

procedure TvcmToolButtonDefActionLink.ParamsChanged(const anAction: IvcmAction);
//#UC START# *476961930017_52A087CA0218_var*
 procedure DoButtonPopup(aButton: TvcmToolButtonDef);
   { - }
 var
  l_Popup : TPopupMenu;
 begin
  with aButton do
  begin
   l_Popup := DropdownMenu;
   if not anAction.HasInfoForCombo then
   begin
    if (l_Popup <> nil) then
    begin
     DropdownMenu := nil;
     if (l_Popup.Owner <> nil) then
      l_Popup.Owner.RemoveComponent(l_Popup);
     RequestClearPopup(l_Popup);
    end;//l_Popup <> nil
    Exit;
   end;//not anAction.HasInfoForCombo
   if (l_Popup = nil) then
   begin
    l_Popup := TvcmButtonPopupMenu.Create(aButton);
    {$IfNDef DesignTimeLibrary}
    {$IfDef l3HackedVCL}
    l_Popup.DrawGraphicChecks := True;
    {$EndIf l3HackedVCL}
    {$EndIf DesignTimeLibrary}
    DropdownMenu := l_Popup;
   end;//l_Popup = nil
  end;//with aButton
  l_Popup.Items.Clear;
  vcmMakeComboMenu(TvcmAction(Action), l_Popup.Items);
 end;

var
 l_Form : TafwCustomForm;
 l_MF   : IvcmEntityForm;
 l_ToolBar: TComponent;
//#UC END# *476961930017_52A087CA0218_var*
begin
//#UC START# *476961930017_52A087CA0218_impl*
 if not TvcmDispatcher.Instance.As_IvcmDispatcher.InOp(True) and
    (Action is TvcmOperationAction) and
    (TvcmOperationAction(Action).OpDef.OperationType in vcm_ComboOperations) and
    (Action.ActionComponent = nil) then
 begin
  l_Form := afw.GetTopParentForm(FClient);
  if (l_Form <> nil) then
  begin
   l_MF := TvcmDispatcher.Instance.FormDispatcher.CurrentMainForm;
   if (l_MF.VCLWinControl <> l_Form) then // 595975850
   begin
    l_ToolBar := FClient.Owner;
    Assert(l_Toolbar is TCustomToolbar97);
    Assert(l_ToolBar.Owner is TvcmEntityForm);
    l_Form := afw.GetTopParentForm(l_ToolBar.Owner);
   end; // 595975850
   if (l_MF.VCLWinControl = l_Form) then
   try
    DoButtonPopup(FClient as TvcmToolButtonDef);
   except
    FClient := nil;
    try
     l3System.Msg2Log('TvcmToolButtonDefActionLink.ParamsChanged fail');
     l3System.Msg2Log(TvcmOperationAction(Self.Action).Caption);
     l3System.Msg2Log(Self.Action.Name);
    except
     l3System.Msg2Log('TvcmToolButtonDefActionLink.ParamsChanged info fail');
    end;//try..except
   end;//try..except
  end;//l_Form <> nil
 end;//not vcmDispatcher.InOp(True)
//#UC END# *476961930017_52A087CA0218_impl*
end;//TvcmToolButtonDefActionLink.ParamsChanged

procedure TvcmToolButtonDefActionLink.ParamsChanging(const anAction: IvcmAction);
//#UC START# *476961A40369_52A087CA0218_var*
//#UC END# *476961A40369_52A087CA0218_var*
begin
//#UC START# *476961A40369_52A087CA0218_impl*
//#UC END# *476961A40369_52A087CA0218_impl*
end;//TvcmToolButtonDefActionLink.ParamsChanging

function TvcmToolButtonDef.IsIconText: Boolean;
//#UC START# *52A08B7F0082_52A08A9E0275_var*
//#UC END# *52A08B7F0082_52A08A9E0275_var*
begin
//#UC START# *52A08B7F0082_52A08A9E0275_impl*
 Result := DisplayMode = dmBoth;
//#UC END# *52A08B7F0082_52A08A9E0275_impl*
end;//TvcmToolButtonDef.IsIconText

{$If NOT Defined(NoVCL)}
function TvcmToolButtonDef.GetActionLinkClass: TControlActionLinkClass;
//#UC START# *4F8845840032_52A08A9E0275_var*
//#UC END# *4F8845840032_52A08A9E0275_var*
begin
//#UC START# *4F8845840032_52A08A9E0275_impl*
 Result := TvcmToolButtonDefActionLink;
//#UC END# *4F8845840032_52A08A9E0275_impl*
end;//TvcmToolButtonDef.GetActionLinkClass
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoTB97)}
function TvcmToolButtonDef.NeedAutoDown: Boolean;
//#UC START# *50477A430157_52A08A9E0275_var*
//#UC END# *50477A430157_52A08A9E0275_var*
begin
//#UC START# *50477A430157_52A08A9E0275_impl*
 Result := False;
//#UC END# *50477A430157_52A08A9E0275_impl*
end;//TvcmToolButtonDef.NeedAutoDown
{$IfEnd} // NOT Defined(NoTB97)

function TvcmToolButtonDef.HackCheck: Boolean;
//#UC START# *52A08AF5004B_52A08A9E0275_var*
//#UC END# *52A08AF5004B_52A08A9E0275_var*
begin
//#UC START# *52A08AF5004B_52A08A9E0275_impl*
 Result := False;
//#UC END# *52A08AF5004B_52A08A9E0275_impl*
end;//TvcmToolButtonDef.HackCheck

{$If NOT Defined(NoTB97)}
function TvcmToolButtonDef.AutoAllUp: Boolean;
//#UC START# *52A08B2C0001_52A08A9E0275_var*
//#UC END# *52A08B2C0001_52A08A9E0275_var*
begin
//#UC START# *52A08B2C0001_52A08A9E0275_impl*
 Result := True;
//#UC END# *52A08B2C0001_52A08A9E0275_impl*
end;//TvcmToolButtonDef.AutoAllUp
{$IfEnd} // NOT Defined(NoTB97)

procedure TvcmToolbarGlyphService.pm_SetAlien(const aValue: IvcmToolbarGlyphService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TvcmToolbarGlyphService.pm_SetAlien

procedure TvcmToolbarGlyphService.SetGlyphSize(aValue: TvcmGlyphSize);
//#UC START# *E8ADA32D143E_552BADA90096_var*
//#UC END# *E8ADA32D143E_552BADA90096_var*
begin
//#UC START# *E8ADA32D143E_552BADA90096_impl*
 if (f_Alien <> nil) then
  f_Alien.SetGlyphSize(aValue)
 else
 begin
  (g_MenuManager as TvcmCustomMenuManager).GlyphSize := aValue;
  (g_MenuManager as TvcmCustomMenuManager).StoreGlyphSize;
 end;//f_Alien <> nil
//#UC END# *E8ADA32D143E_552BADA90096_impl*
end;//TvcmToolbarGlyphService.SetGlyphSize

function TvcmToolbarGlyphService.GetGlyphSize: TvcmGlyphSize;
//#UC START# *9DEC90563B75_552BADA90096_var*
//#UC END# *9DEC90563B75_552BADA90096_var*
begin
//#UC START# *9DEC90563B75_552BADA90096_impl*
 if (f_Alien <> nil) then
  Result := f_Alien.GetGlyphSize
 else
  Result := (g_MenuManager as TvcmCustomMenuManager).GlyphSize;
//#UC END# *9DEC90563B75_552BADA90096_impl*
end;//TvcmToolbarGlyphService.GetGlyphSize

function TvcmToolbarGlyphService.GetGlyphColorDepth: TvcmGlyphColordepth;
//#UC START# *BC663849408C_552BADA90096_var*
//#UC END# *BC663849408C_552BADA90096_var*
begin
//#UC START# *BC663849408C_552BADA90096_impl*
 if (f_Alien <> nil) then
  Result := f_Alien.GetGlyphColordepth
 else
  Result := (g_MenuManager as TvcmCustomMenuManager).GlyphColordepth;
//#UC END# *BC663849408C_552BADA90096_impl*
end;//TvcmToolbarGlyphService.GetGlyphColorDepth

procedure TvcmToolbarGlyphService.SetGlyphColorDepth(aValue: TvcmGlyphColordepth);
//#UC START# *B8089BE16F42_552BADA90096_var*
//#UC END# *B8089BE16F42_552BADA90096_var*
begin
//#UC START# *B8089BE16F42_552BADA90096_impl*
 if (f_Alien <> nil) then
  f_Alien.SetGlyphColorDepth(aValue)
 else
 begin
  (g_MenuManager as TvcmCustomMenuManager).GlyphColorDepth := aValue;
  (g_MenuManager as TvcmCustomMenuManager).StoreGlyphColorDepth;
 end;//f_Alien <> nil
//#UC END# *B8089BE16F42_552BADA90096_impl*
end;//TvcmToolbarGlyphService.SetGlyphColorDepth

class function TvcmToolbarGlyphService.Instance: TvcmToolbarGlyphService;
 {* Метод получения экземпляра синглетона TvcmToolbarGlyphService }
begin
 if (g_TvcmToolbarGlyphService = nil) then
 begin
  l3System.AddExitProc(TvcmToolbarGlyphServiceFree);
  g_TvcmToolbarGlyphService := Create;
 end;
 Result := g_TvcmToolbarGlyphService;
end;//TvcmToolbarGlyphService.Instance

class function TvcmToolbarGlyphService.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TvcmToolbarGlyphService <> nil;
end;//TvcmToolbarGlyphService.Exists

procedure TvcmToolbarGlyphService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//TvcmToolbarGlyphService.ClearFields

procedure TvcmCustomMenuManager.pm_SetDockButtonsImageList(aValue: TCustomImageList);
//#UC START# *52A822880118_4B30EC81021Aset_var*
//#UC END# *52A822880118_4B30EC81021Aset_var*
begin
//#UC START# *52A822880118_4B30EC81021Aset_impl*
 f_DockButtonsImageList := aValue;
//#UC END# *52A822880118_4B30EC81021Aset_impl*
end;//TvcmCustomMenuManager.pm_SetDockButtonsImageList

procedure TvcmCustomMenuManager.pm_SetActions(aValue: TCustomActionList);
//#UC START# *52A823910334_4B30EC81021Aset_var*
//#UC END# *52A823910334_4B30EC81021Aset_var*
begin
//#UC START# *52A823910334_4B30EC81021Aset_impl*
 if (f_Actions <> aValue) then
 begin
  f_Actions := aValue;
  vcmMenus.vcmSetActionList(f_Actions);
 end;//f_Actions <> anActions
//#UC END# *52A823910334_4B30EC81021Aset_impl*
end;//TvcmCustomMenuManager.pm_SetActions

procedure TvcmCustomMenuManager.pm_SetGlyphSize(aValue: TvcmGlyphSize);
//#UC START# *52A823D2029C_4B30EC81021Aset_var*
//#UC END# *52A823D2029C_4B30EC81021Aset_var*
begin
//#UC START# *52A823D2029C_4B30EC81021Aset_impl*
 if f_GlyphSize <> aValue then
 begin
  f_GlyphSize := aValue;
  if Assigned(f_OnGlyphSizeChanged) then
   f_OnGlyphSizeChanged(Self);
 end;
//#UC END# *52A823D2029C_4B30EC81021Aset_impl*
end;//TvcmCustomMenuManager.pm_SetGlyphSize

procedure TvcmCustomMenuManager.pm_SetGlyphColordepth(aValue: TvcmGlyphColordepth);
//#UC START# *52A824150341_4B30EC81021Aset_var*
//#UC END# *52A824150341_4B30EC81021Aset_var*
begin
//#UC START# *52A824150341_4B30EC81021Aset_impl*
 // Присваиваем всегда. Это делается для того, чтобы работало автоопределение.
 f_GlyphColordepth := aValue;
 if Assigned(f_OnGlyphColordepthChanged) then
  f_OnGlyphColordepthChanged(Self);
//#UC END# *52A824150341_4B30EC81021Aset_impl*
end;//TvcmCustomMenuManager.pm_SetGlyphColordepth

procedure TvcmCustomMenuManager.pm_SetMainMenuItems(aValue: TvcmMenuItemsCollection);
//#UC START# *52A8246C022D_4B30EC81021Aset_var*
//#UC END# *52A8246C022D_4B30EC81021Aset_var*
begin
//#UC START# *52A8246C022D_4B30EC81021Aset_impl*
 f_MainMenuItems.Assign(aValue);
//#UC END# *52A8246C022D_4B30EC81021Aset_impl*
end;//TvcmCustomMenuManager.pm_SetMainMenuItems

procedure TvcmCustomMenuManager.OverridePopupMenu(aForm: TCustomForm);
//#UC START# *52A83208018D_4B30EC81021A_var*
 procedure lp_SetComponentPopup(aComponent: TComponent);
 var
  l_PropInfo : PPropInfo;
 begin//SetComponentPopup
  l_PropInfo := GetPropInfo(aComponent, 'PopupMenu');
  if (l_PropInfo <> nil) then
  begin
   if (GetObjectProp(aComponent, l_PropInfo) = nil) then
   begin
    // - не затираем чужое меню
    if (f_Popup  = nil) then
    begin
     f_Popup := TvcmPopupMenu.Create(Self);
     f_Popup.AutoHotkeys := maManual;
     {$IfNDef DesignTimeLibrary}
     {$IfDef l3HackedVCL}
     f_Popup.DrawGraphicChecks := True;
     {$EndIf l3HackedVCL}
     {$EndIf DesignTimeLibrary}
     f_Popup.OnPopup := DoPopup;
     f_Popup.AutoLineReduction := maAutomatic;
     if (Self.SmallImages <> nil) then
      f_Popup.Images := Self.SmallImages
     else
     if (Actions <> nil) then
      f_Popup.Images := Actions.Images;
    end;//f_Popup  = nil
    SetObjectProp(aComponent, l_PropInfo, f_Popup);
    l_PropInfo := GetPropInfo(aComponent, 'AutoPopup');
    if (l_PropInfo <> nil) then
     SetOrdProp(aComponent, l_PropInfo, Ord(True));
   end;//GetObjectProp(aComponent, l_PropInfo) = nil
  end;//l_PropInfo <> nil
 end;//SetComponentPopup

var
 l_Index, I: Integer;
 l_ComponentContainer: IvcmComponentContainer;
//#UC END# *52A83208018D_4B30EC81021A_var*
begin
//#UC START# *52A83208018D_4B30EC81021A_impl*
 with aForm do
  for l_Index := 0 to Pred(ComponentCount) do
  begin
   lp_SetComponentPopup(Components[l_Index]);
   if Supports(Components[l_Index], IvcmComponentContainer, l_ComponentContainer) then
    for I := 0 to l_ComponentContainer.Count - 1 do
     lp_SetComponentPopup(l_ComponentContainer.OwnedComponent[I])
  end;
//#UC END# *52A83208018D_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.OverridePopupMenu

function TvcmCustomMenuManager.ToolbarButtonSize(aToolbarButton: TCustomToolbarButton97;
 var aSize: Integer): Boolean;
//#UC START# *52A8329D033C_4B30EC81021A_var*
//#UC END# *52A8329D033C_4B30EC81021A_var*
begin
//#UC START# *52A8329D033C_4B30EC81021A_impl*
 Result := False;
 with aToolbarButton do
 begin
  if Assigned(Images) then
   if Images.Height > 16 then
   begin
    aSize := Max(aSize, Height);
    Result := aToolbarButton.DisplayMode = dmBoth;
   end;
 end;
//#UC END# *52A8329D033C_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.ToolbarButtonSize

procedure TvcmCustomMenuManager.ToolbarButtonSize(aToolbarButton: TCustomToolbarButton97);
 {* устанавливает ширину и высоту кнопки }
//#UC START# *52A832CD000B_4B30EC81021A_var*
var
 l_Size: Integer;
//#UC END# *52A832CD000B_4B30EC81021A_var*
begin
//#UC START# *52A832CD000B_4B30EC81021A_impl*
 l_Size := f_MaxControlToolbarSize;
 ToolbarButtonSize(aToolbarButton, l_Size);
 aToolbarButton.Height := l_Size;
 aToolbarButton.Width := Max(l_Size, aToolbarButton.Width);
//#UC END# *52A832CD000B_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.ToolbarButtonSize

procedure TvcmCustomMenuManager.ToolbarSize(aToolbar: TCustomToolbar97;
 var aSize: Integer);
 {* определяет размер toolbar-а }
//#UC START# *52A833300250_4B30EC81021A_var*
var
 l_Index: Integer;
//#UC END# *52A833300250_4B30EC81021A_var*
begin
//#UC START# *52A833300250_4B30EC81021A_impl*
 aSize := f_MaxControlToolbarSize;
 for l_Index := 0 to Pred(aToolbar.ControlCount) do
  if aToolbar.Controls[l_Index] is TCustomToolbarButton97 then
   (* выходим, максимальный размер получен *)
   if ToolbarButtonSize(TCustomToolbarButton97(aToolbar.Controls[l_Index]), aSize) then
    Break;
//#UC END# *52A833300250_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.ToolbarSize

procedure TvcmCustomMenuManager.RefocusEntity;
//#UC START# *52A83386032D_4B30EC81021A_var*
//#UC END# *52A83386032D_4B30EC81021A_var*
begin
//#UC START# *52A83386032D_4B30EC81021A_impl*
 if (f_FocusControl <> nil) and (Application.MainForm <> nil) then
  f_InEnter := False;
//#UC END# *52A83386032D_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.RefocusEntity

procedure TvcmCustomMenuManager.RestoreControlText(Sender: TObject);
//#UC START# *52A833C103E0_4B30EC81021A_var*
var
 l_Control: TWinControl;
 l_TC: IafwTextControl;
 l_Action : IvcmAction;
//#UC END# *52A833C103E0_4B30EC81021A_var*
begin
//#UC START# *52A833C103E0_4B30EC81021A_impl*
 l_Control := (Sender as TWinControl);
 if Supports(l_Control.Action, IvcmAction, l_Action) then
 try
  if Supports(l_Control, IafwTextControl, l_TC) then
   l_TC.CCaption := l_Action.Caption
  else
   THackWinControl(l_Control).Text := vcmStr(l_Action.Caption);
 finally
  l_Action := nil;
 end;//try..finally
//#UC END# *52A833C103E0_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.RestoreControlText

procedure TvcmCustomMenuManager.ChangeEntityText(Sender: TObject);
//#UC START# *52A833D5007C_4B30EC81021A_var*
var
 l_Control: TWinControl;
 l_TC: IafwTextControl;
 l_Action: IvcmAction;
//#UC END# *52A833D5007C_4B30EC81021A_var*
begin
//#UC START# *52A833D5007C_4B30EC81021A_impl*
 l_Control := Sender as TWinControl;
 if Supports(l_Control.Action, IvcmAction, l_Action) then
 try
  with l_Action do
  begin
   if Supports(l_Control, IafwTextControl, l_TC) then
    SelectedString := l_TC.CCaption
   else
    SelectedString := vcmCStr(THackWinControl(l_Control).Text);
   LockUpdate;
   try
    if (f_FocusControl = l_Control) then
    begin
     UnlockExecute;
     f_IsUnlockExecute := True;
    end;
    l_Control.Action.Execute;
   finally
    UnLockUpdate;
   end;//try..finally
  end;//with TCustomAction(l_Control.Action)
 finally
  l_Action := nil;
 end;//try..finally
//#UC END# *52A833D5007C_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.ChangeEntityText

procedure TvcmCustomMenuManager.ChangeTyperText(Sender: TObject);
//#UC START# *52A8343B0397_4B30EC81021A_var*
var
 l_TickCount: Cardinal;
//#UC END# *52A8343B0397_4B30EC81021A_var*
begin
//#UC START# *52A8343B0397_4B30EC81021A_impl*
 l_TickCount := GetTickCount;
// if (f_TickCount = Cardinal(-1)) or (l_TickCount - f_TickCount >= 300) then
  ChangeEntityText(Sender);
 f_TickCount := l_TickCount;
//#UC END# *52A8343B0397_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.ChangeTyperText

procedure TvcmCustomMenuManager.ControlKeyDown(Sender: TObject;
 var Key: Word;
 Shift: TShiftState);
//#UC START# *52A835090368_4B30EC81021A_var*
//#UC END# *52A835090368_4B30EC81021A_var*
begin
//#UC START# *52A835090368_4B30EC81021A_impl*
 if (Shift = []) then 
 case Key of
  vk_Escape:
   begin
    RestoreControlText(Sender);
    RefocusEntity;
    Key := 0;
   end;
  vk_Return:
   begin
    ChangeEntityText(Sender);
    RefocusEntity;
    Key := 0;
   end;//Key = vk_Enter
 end;
//#UC END# *52A835090368_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.ControlKeyDown

procedure TvcmCustomMenuManager.ControlEnter(Sender: TObject);
//#UC START# *52A835400086_4B30EC81021A_var*
var
 l_Action: IvcmAction;
//#UC END# *52A835400086_4B30EC81021A_var*
begin
//#UC START# *52A835400086_4B30EC81021A_impl*
 if not (Sender is TvcmComboBox) then
  f_WasDrop := False;
 f_InEnter := True;
 f_FocusControl := (Sender as TWinControl);
 if Supports(f_FocusControl.Action, IvcmAction, l_Action) then
 try
  (* при входе в обязательном порядке вызываем OnTest *)
  // TvcmAction(f_FocusControl.Action).Update;
  if not (f_FocusControl is TvtComboTree) then

    (* Нет необходимости защищать Execute, потому что по TControl.Click
       TAction.Execute не вызывается.

       Предыстория:

         1. Находимся в дереве;
         2. Нажимаем клавиши, включается быстрый поиск;
         3. В TvcmEdit на toolbar - е передаётся текст;
         4. Устанавливаем фокус в TvcmEdit, получается что выполнение
            TAction.Execute запрещено;
         5. Нажимаем Enter, который транслируется в команду и обрабатывается в
            TvcmEdit.ProcessCommand в обход ControlKeyDown (в котором
            сбрасывается UnlockExecute) и ничего не происходит; *)
         
   l_Action.LockExecute;
     (* Это нужно сделать потому, что при входе в компонент по TControl.Click
        вызовется TAction.Execute, а в компоненте может быть не валидная
        информация *)
  f_IsUnlockExecute := False;
    (* Устанавливаем флаг чтобы по выходу сбросить блокировку если мы ничего не
       вызывали *)
 finally
  l_Action := nil;
 end;//try..finally
//#UC END# *52A835400086_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.ControlEnter

procedure TvcmCustomMenuManager.ControlExit(Sender: TObject);
//#UC START# *52A8357200BD_4B30EC81021A_var*
var
 l_TC: IafwTextControl;
 l_Action: IvcmAction;
//#UC END# *52A8357200BD_4B30EC81021A_var*
begin
//#UC START# *52A8357200BD_4B30EC81021A_impl*
 if not f_IsUnlockExecute then
 begin
  f_FocusControl := TWinControl(Sender);
  if Supports(f_FocusControl.Action, IvcmAction, l_Action) then
  try
   // если пользователь поредактировал и вышел без нажатия на Enter, то
   // возвращаем предыдущее значение
   if Supports(f_FocusControl, IafwTextControl, l_TC) then
   begin
    if not vcmSame(l_TC.CCaption, l_Action.Caption) then
     l_TC.CCaption := l_Action.Caption;
   end//Supports(f_FocusControl, IafwTextControl, l_TC)
   else
    with THackWinControl(f_FocusControl) do
     if not vcmSame(Text, l_Action.SelectedString) then
      Text := vcmStr(l_Action.SelectedString);
   l_Action.UnlockExecute;
  finally
   l_Action := nil;
  end;//f_FocusControl.Action is TvcmAction
 end;//not f_IsUnlockExecute
// RefocusEntity; //приходим сюда во время обработки WM_SETFOCUS другого
// контрола; RefocusEntity приводила к повторному WM_SETFOCUS;
// это приводило к тому, что фокус до контрола не доходил;
//#UC END# *52A8357200BD_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.ControlExit

procedure TvcmCustomMenuManager.ControlDown(Sender: TObject);
//#UC START# *52A835800363_4B30EC81021A_var*
//#UC END# *52A835800363_4B30EC81021A_var*
begin
//#UC START# *52A835800363_4B30EC81021A_impl*
 f_WasDrop := True;
 f_InEnter := True;
 f_FocusControl := Sender as TWinControl;
//#UC END# *52A835800363_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.ControlDown

procedure TvcmCustomMenuManager.DateDown(Sender: TObject);
//#UC START# *52A835BC02D8_4B30EC81021A_var*
//#UC END# *52A835BC02D8_4B30EC81021A_var*
begin
//#UC START# *52A835BC02D8_4B30EC81021A_impl*
 ControlDown(Sender);
//#UC END# *52A835BC02D8_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.DateDown

procedure TvcmCustomMenuManager.ComboDown(Sender: TObject);
//#UC START# *52A835EC002D_4B30EC81021A_var*
//#UC END# *52A835EC002D_4B30EC81021A_var*
begin
//#UC START# *52A835EC002D_4B30EC81021A_impl*
 ControlDown(Sender);
//#UC END# *52A835EC002D_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.ComboDown

procedure TvcmCustomMenuManager.ControlSelect(Sender: TObject);
//#UC START# *52A835F8034A_4B30EC81021A_var*
//#UC END# *52A835F8034A_4B30EC81021A_var*
begin
//#UC START# *52A835F8034A_4B30EC81021A_impl*
 if f_WasDrop then
 begin
  f_WasDrop := False;
  ChangeEntityText(Sender);
  RefocusEntity;
 end;//f_WasDrop
//#UC END# *52A835F8034A_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.ControlSelect

procedure TvcmCustomMenuManager.FormChange(Sender: TObject);
//#UC START# *52A8360602D0_4B30EC81021A_var*
//#UC END# *52A8360602D0_4B30EC81021A_var*
begin
//#UC START# *52A8360602D0_4B30EC81021A_impl*
 if f_InEnter then
  f_InEnter := False
 else
  RefocusEntity;
//#UC END# *52A8360602D0_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.FormChange

procedure TvcmCustomMenuManager.DoPopup(Sender: TObject);
//#UC START# *52A8362B00B7_4B30EC81021A_var*
var
 l_Form: TCustomForm;
//#UC END# *52A8362B00B7_4B30EC81021A_var*
begin
//#UC START# *52A8362B00B7_4B30EC81021A_impl*
 l_Form := afw.GetParentForm(f_Popup.PopupComponent);
 if l_Form is TvcmEntityForm then
 begin
  f_PopupForm := TvcmEntityForm(l_Form);
  f_Popup.Items.Clear;
  if (f_PopupForm.GetEntitiesDefIterator <> nil) then
   vcmMakeEntitiesMenus(f_Popup.Items,
                        TvcmEntitiesDefIteratorForContextMenu.Make(f_PopupForm.GetEntitiesDefIterator),
                        [vcm_ooShowInContextMenu],
                        not (vcm_moEntitesInContextMenu in MenuOptions),
                        vcm_icExternal,
                        nil,
                        CheckPopup);
 end;//l_Form is TvcmEntityForm
//#UC END# *52A8362B00B7_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.DoPopup

function TvcmCustomMenuManager.CheckPopup(const anEntityDef: IvcmEntityDef): IvcmEntity;
//#UC START# *52A8367B01FC_4B30EC81021A_var*
//#UC END# *52A8367B01FC_4B30EC81021A_var*
begin
//#UC START# *52A8367B01FC_4B30EC81021A_impl*
 with f_Popup, f_PopupForm do
  if (PopupComponent is TControl) then
   with TControl(PopupComponent).ScreenToClient(PopupPoint) do
    Result := GetInnerForControl(anEntityDef.ID, PopupComponent, X, Y)
  else
   Result := GetInnerForControl(anEntityDef.ID, PopupComponent);
//#UC END# *52A8367B01FC_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.CheckPopup

function TvcmCustomMenuManager.GetToolbarName(aForm: TvcmEntityForm;
 const aDef: IvcmOperationalIdentifiedUserFriendlyControl;
 anIndex: Integer): AnsiString;
//#UC START# *52A836E4024C_4B30EC81021A_var*
//#UC END# *52A836E4024C_4B30EC81021A_var*
begin
//#UC START# *52A836E4024C_4B30EC81021A_impl*
 if OneToolbarPerForm then
  Result := GetOneToolbarPerFormName(aForm, aDef.ToolbarPos, anIndex)
 else
 begin
  Result := aDef.Name;
  Result := 'tb' + Result + cTBName[aDef.ToolBarPos];
  if (anIndex > 0) then
   Result := Result + IntToStr(anIndex);
 end;//OneToolbarPerForm
//#UC END# *52A836E4024C_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.GetToolbarName

{$If NOT Defined(DesignTimeLibrary)}
function TvcmCustomMenuManager.BuildToolbar(aForm: TvcmEntityForm;
 const aDef: IvcmOperationalIdentifiedUserFriendlyControl;
 anIndex: Integer): TvcmToolbarDef;
 {* anIndex - порядковый номер Toolbar'а (для огранизации нескольких Toolbar'ов в одном доке) }
//#UC START# *52A83799024A_4B30EC81021A_var*
var
 l_ToolbarName: AnsiString;
 l_Pos: TvcmEffectiveToolBarPos;
 l_Caption: IvcmCString;
//#UC END# *52A83799024A_4B30EC81021A_var*
begin
//#UC START# *52A83799024A_4B30EC81021A_impl*
 if (aDef = nil) then
  Result := nil
 else
 begin
  l_Pos := aDef.ToolbarPos;
  l_ToolbarName := GetToolbarName(aForm, aDef, anIndex);
  if OneToolbarPerForm then
  begin
   if (aForm.UserTypes <> nil) and
      (aForm.UserTypes.Count > 0) then
    l_Caption := vcmCStr(aForm.CurUserType.Caption)
   else
    l_Caption := aForm.CCaption;
  end//OneToolbarPerForm
  else
   l_Caption := aDef.Caption;
  Result := BuildToolbar(aForm, l_ToolbarName, l_Caption, l_Pos);
 end;//aDef = nil
//#UC END# *52A83799024A_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.BuildToolbar
{$IfEnd} // NOT Defined(DesignTimeLibrary)

procedure TvcmCustomMenuManager.FillToolbar(aForm: TvcmEntityForm;
 var aToolBar: TvcmToolbarDef;
 const aHolder: IvcmOperationalIdentifiedUserFriendlyControl;
 const anOperations: IvcmOperationsDefIterator;
 anOptions: TvcmOperationOptions);
//#UC START# *52A838180205_4B30EC81021A_var*
//#UC END# *52A838180205_4B30EC81021A_var*
begin
//#UC START# *52A838180205_4B30EC81021A_impl*
 if (aToolBar <> nil) then
 begin
  if OneToolbarPerForm then
   BuildSeparator(aToolbar);
  aToolbar.BeginUpdate;
  try
   while (BuildButton(aForm, aToolbar, aHolder, anOperations.Next, anOptions) <> nil) do ;
  finally
   aToolbar.EndUpdate;                                                                             
  end;//try..finally
  CheckToolbar(aToolbar);
 end;//aToolBar <> nil
//#UC END# *52A838180205_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.FillToolbar

procedure TvcmCustomMenuManager.CheckToolbar(var aToolBar: TvcmToolbarDef);
//#UC START# *52A8391000A9_4B30EC81021A_var*
//#UC END# *52A8391000A9_4B30EC81021A_var*
begin
//#UC START# *52A8391000A9_4B30EC81021A_impl*
 with aToolbar do
  vcmDeleteLastIfSeparator;
 // - удаляем лишний разделитель
 if (aToolBar.ButtonCount <= 0) then
  vcmFree(aToolBar);
//#UC END# *52A8391000A9_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.CheckToolbar

{$If NOT Defined(DesignTimeLibrary)}
function TvcmCustomMenuManager.MakeToolbar(aForm: TvcmEntityForm;
 const aHolder: IvcmOperationalIdentifiedUserFriendlyControl;
 anOptions: TvcmOperationOptions;
 anExcludePoses: TvcmEffectiveToolBarPoses): Boolean;
//#UC START# *52A8393D0073_4B30EC81021A_var*
var
 l_Toolbar: TvcmToolbarDef;
 l_Operations: IvcmOperationsDefIterator;
//#UC END# *52A8393D0073_4B30EC81021A_var*
begin
//#UC START# *52A8393D0073_4B30EC81021A_impl*
 LockDocks;
 try
  if (aHolder = nil) then
   Result := False
  else
  begin
   //Assert(aForm.CurUserType <> nil);
   // - http://mdp.garant.ru/pages/viewpage.action?pageId=378550015
   if (aForm.CurUserType <> nil) and
      not aForm.CurUserType.CanHaveToolbars then
   begin
    Result := False;
    Exit;
   end;//not aForm.CurUserType.VisibleToUser
   Result := True;
   // - видимо где - то здесь можно "приструячить" цикл по Toolbar'ам формы
   l_Operations := aHolder.OperationsDefIterator;
   if (l_Operations <> nil) then
   begin
    l_Toolbar := BuildToolbar(aForm, aHolder, 0);
    if GetOpLock and (l_Toolbar <> nil) and (l_Toolbar.DockedTo <> nil) then
     begin
     if TvcmToolbarDockListManager.Instance.DockList.IndexOf(l_Toolbar.DockedTo) < 0 then
     begin
      TvcmToolbarDockListManager.Instance.DockList.Add(l_Toolbar.DockedTo);
      l_Toolbar.DockedTo.BeginUpdate;
     end;
     l_Toolbar.DockedTo.SmartAlign := True;
    end;
    if (l_Toolbar <> nil) and not (l_Toolbar.Pos in anExcludePoses) then
     FillToolbar(aForm, l_Toolbar, aHolder, l_Operations, anOptions);
   end;//l_Operations <> nil
  end;//aHolder = nil
 finally
  UnlockDocks;
 end;//try..finally
//#UC END# *52A8393D0073_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.MakeToolbar
{$IfEnd} // NOT Defined(DesignTimeLibrary)

{$If NOT Defined(DesignTimeLibrary)}
procedure TvcmCustomMenuManager.BuildEntitiesToolbars(aForm: TvcmEntityForm;
 const anEntities: IvcmEntitiesDefIterator;
 anOptions: TvcmOperationOptions;
 anExcludePoses: TvcmEffectiveToolBarPoses);
//#UC START# *52A8398C01D1_4B30EC81021A_var*
//#UC END# *52A8398C01D1_4B30EC81021A_var*
begin
//#UC START# *52A8398C01D1_4B30EC81021A_impl*
 if (anEntities <> nil) then
  while MakeToolbar(aForm, anEntities.Next, anOptions, anExcludePoses) do
//#UC END# *52A8398C01D1_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.BuildEntitiesToolbars
{$IfEnd} // NOT Defined(DesignTimeLibrary)

{$If Defined(vcmUseSettings)}
function TvcmCustomMenuManager.LoadButtonsFromSettings(const aUserType: IvcmUserTypeDef;
 const aToolbar: AnsiString;
 AddUnsavedButton: Boolean;
 var theButton: TvcmButtonDef;
 var theButtons: TvcmButtonDefs): Boolean;
//#UC START# *52A839C302A6_4B30EC81021A_var*
 procedure l_AddButton;
 var
  l_Len: Integer;
  procedure l_InsertButton(anIndex: Integer);
  var
   l_Index: Integer;
   l_NewButtons: TvcmButtonDefs;
   l_MaxPos: Integer;
  begin//l_InsertButton
   if not theButtons[anIndex].rLoaded then
    l_MaxPos := theButton.rPos
   else
    l_MaxPos := -1;

   SetLength(l_NewButtons, Succ(l_Len));
   for l_Index := 0 to Pred(anIndex) do
    l_NewButtons[l_Index] := theButtons[l_Index];

   for l_Index := anIndex to Pred(l_Len) do
   begin
    l_NewButtons[l_Index + 1] := theButtons[l_Index];
    if l_MaxPos > -1 then
     l_NewButtons[l_Index + 1].rPos := l_MaxPos + l_Index - anIndex + 1;
   end;
   l_NewButtons[anIndex] := theButton;   
   theButtons := l_NewButtons;
  end;//l_InsertButton

 var
  l_Index: Integer;
 begin//l_AddButton
  l_Len := Length(theButtons);
  if theButton.rLoaded then
   for l_Index := 0 to Pred(l_Len) do
    if (theButtons[l_Index].rPos > theButton.rPos) or
       (not theButtons[l_Index].rLoaded) then
    begin
     l_InsertButton(l_Index);
     Exit;
    end;//theButtons[l_Index].rPos > theButton.rPos
  SetLength(theButtons, Succ(l_Len));
  theButtons[l_Len] := theButton;
  if (not theButton.rLoaded) and
     (l_Len > 0) then
   theButtons[l_Len].rPos := theButtons[l_Len - 1].rPos + 1;   
 end;//l_AddButton

var
 l_Operations: IvcmOperationsDefIterator;
 l_Bt: TvcmButtonParams;
 l_NotLoadedNeedSep: Boolean;
//#UC END# *52A839C302A6_4B30EC81021A_var*
begin
//#UC START# *52A839C302A6_4B30EC81021A_impl*
 if (theButton.rEn = nil) then
  Result := False
 else
 begin
  Result := True;
  l_NotLoadedNeedSep := True;

  theButton.rNeedSep := True;
  theButton.rIconText := False;
  // - каждая сущность по умолчанию открывает группу
  l_Operations := theButton.rEn.OperationsDefIterator;
  if (l_Operations <> nil) then
  begin
   while True do
   begin
    theButton.rOp := l_Operations.Next;
    if (theButton.rOp = nil) then
     Break;
    if (theButton.rOp.OperationType in vcmToolbarOpTypes) then
    begin
     if vcmLoadButtonParams(aUserType.Name, aToolbar, theButton.rEn.Name, theButton.rOp.Name, l_Bt) then
     begin
      if l_Bt.rVisible then
      begin
       if (l_Bt.rPos = High(Cardinal)) then
        theButton.rPos := Succ(theButton.rPos)
       else
        theButton.rPos := l_Bt.rPos;
       theButton.rOptions := vcm_AllOperationOptions;
       // - показываем независимо от настроек по умолчанию
       theButton.rNeedSep := l_Bt.rNeedSep;
       theButton.rIconText := l_Bt.rIconText;
       theButton.rLoaded := True;
       // - это тоже надо из настроек читать
      end//l_Bt.rVisible
      else
       continue;
      end//vcmLoadButtonParams
     else
     begin
      if not AddUnsavedButton then
       Continue;
      if l_NotLoadedNeedSep then
      begin
       theButton.rNeedSep := True;      
       l_NotLoadedNeedSep := False;
      end;
      theButton.rPos := Succ(theButton.rPos);
      theButton.rOptions := theButton.rOp.Options;
      theButton.rIconText := theButton.rOp.OperationType = vcm_otTextButton;
      theButton.rLoaded := False;
     end;//vcmLoadButtonParams
     l_AddButton;
     theButton.rNeedSep := False;
     // - скидываем флаг по умолчанию
    end;//theButton.rOp.OperationType in vcmToolbarOpTypes
   end;//while True
  end;//l_Operations <> nil
 end;//theButton.rEn = nil
//#UC END# *52A839C302A6_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.LoadButtonsFromSettings
{$IfEnd} // Defined(vcmUseSettings)

{$If Defined(vcmUseSettings)}
procedure TvcmCustomMenuManager.MakeToolbarFromSettings(aForm: TvcmEntityForm;
 const aToolbarName: AnsiString;
 aPos: TvcmEffectiveToolBarPos;
 anOptions: TvcmOperationOptions;
 const theButtons: TvcmButtonDefs);
//#UC START# *52A83A050068_4B30EC81021A_var*
var
 l_Index: Integer;
 l_Toolbar: TvcmToolbarDef;
//#UC END# *52A83A050068_4B30EC81021A_var*
begin
//#UC START# *52A83A050068_4B30EC81021A_impl*
 if (Length(theButtons) > 0) then
 // http://mdp.garant.ru/pages/viewpage.action?pageId=235876230&focusedCommentId=236718542#comment - 236718542
 begin
  l_Toolbar := BuildToolbar(aForm, aToolbarName, aForm.CurUserTypeDef.Caption, aPos);
  if (l_Toolbar <> nil) and
     (l_Toolbar.DockedTo <> nil) and
     GetOpLock and
     (TvcmToolbarDockListManager.Instance.DockList.IndexOf(l_Toolbar.DockedTo) < 0) then
  begin
   TvcmToolbarDockListManager.Instance.DockList.Add(l_Toolbar.DockedTo);
   l_Toolbar.DockedTo.BeginUpdate;
  end;

  for l_Index := Low(theButtons) to High(theButtons) do
  begin
   with theButtons[l_Index] do
   begin
    if rNeedSep then
     BuildSeparator(l_Toolbar);
    if rIconText then
     BuildButton(aForm, l_Toolbar, rEn, rOp, rOptions, anOptions, vcm_itIconText)
    else
     BuildButton(aForm, l_Toolbar, rEn, rOp, rOptions, anOptions, vcm_itIcon)
   end;//with theButtons[l_Index]
  end;//for l_Index
  CheckToolbar(l_Toolbar);
 end;//Length(l_BtDefs) > 0
//#UC END# *52A83A050068_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.MakeToolbarFromSettings
{$IfEnd} // Defined(vcmUseSettings)

{$If Defined(vcmUseSettings)}
procedure TvcmCustomMenuManager.MakeMainToolbarFromSettings(aForm: TvcmEntityForm);
//#UC START# *52A83A37024D_4B30EC81021A_var*
var
 l_Pos: TvcmEffectiveToolBarPos;
//#UC END# *52A83A37024D_4B30EC81021A_var*
begin
//#UC START# *52A83A37024D_4B30EC81021A_impl*
 for l_Pos := Low(TvcmEffectiveToolBarPos) to High(TvcmEffectiveToolBarPos) do
  with f_MainToolbarDefs[l_Pos] do
   if rVisible and (rButtons <> nil) then
   begin
    MakeToolbarFromSettings(aForm, rToolbarName, l_Pos,
                            [vcm_ooShowInMainToolbar], rButtons);
    rButtons := nil;
   end;//rButtons <> nil
//#UC END# *52A83A37024D_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.MakeMainToolbarFromSettings
{$IfEnd} // Defined(vcmUseSettings)

{$If NOT Defined(DesignTimeLibrary)}
procedure TvcmCustomMenuManager.BuildFormToolbars(aForm: TvcmEntityForm;
 anOptions: TvcmOperationOptions);
//#UC START# *52A83A6903B7_4B30EC81021A_var*
var
 l_ExcludePoses: TvcmEffectiveToolBarPoses;
{$IfDef vcmUseSettings}
 l_ToolbarName: AnsiString;
 l_UserType: IvcmUserTypeDef;
 l_Pos: TvcmEffectiveToolBarPos;
 l_Entities: IvcmEntitiesDefIterator;
 l_BtDef: TvcmButtonDef;
 l_BtDefs: TvcmButtonDefs;
 l_ToolbarVis: Boolean;
{$EndIf vcmUseSettings}
//#UC END# *52A83A6903B7_4B30EC81021A_var*
begin
//#UC START# *52A83A6903B7_4B30EC81021A_impl*
 LockDocks;
 try
  l_ExcludePoses := [];
  {$IfDef vcmUseSettings}
  if OneToolbarPerForm then
  begin
   // - проверка бредовая, просто я пока не понимаю как грузить несколько Toolbar'ов
   l_UserType := aForm.CurUseToolbarOfUserType;
   if (l_UserType <> nil) then
   begin
    if not vcmIsNil(l_UserType.Caption) then
    begin
     //l_Poses := aForm.Toolbars;
     for l_Pos := Low(TvcmEffectiveToolBarPos) to High(TvcmEffectiveToolBarPos) do
     begin
      if (aForm is TvcmMainForm) then
      begin
       with f_MainToolbarDefs[l_Pos] do
       begin
        rVisibleLoaded := False;
        rVisible := False;
        rUserType := l_UserType;
       end;//with f_MainToolbarDefs[l_Pos]
      end;
      if True{(l_Pos in l_Poses)} then
      begin
       l_ToolbarName := GetOneToolbarPerFormName(aForm, l_Pos, 0);
       if (aForm is TvcmMainForm) then
       begin
        with f_MainToolbarDefs[l_Pos] do
        begin
         rToolbarName := l_ToolbarName;
        end;//with f_MainToolbarDefs[l_Pos]
       end;//aForm is TvcmMainForm
       if vcmLoadToolbarVisible(l_UserType.Name, l_ToolbarName, l_ToolbarVis) then
       begin
        if (aForm is TvcmMainForm) then
        begin
         with f_MainToolbarDefs[l_Pos] do
         begin
          rVisibleLoaded := True;
          rVisible := l_ToolbarVis;
         end;//with f_MainToolbarDefs[l_Pos]
        end;//aForm is TvcmMainForm
        Include(l_ExcludePoses, l_Pos);
        if l_ToolbarVis then
        begin
         l_BtDef.rPos := 0;
         l_Entities := aForm.GetEntitiesDefIterator;
         if (l_Entities <> nil) then
         begin
          while True do
          begin
           l_BtDef.rEn := l_Entities.Next;
           if not LoadButtonsFromSettings(l_UserType,
                                          l_ToolbarName,
                                          Assigned(l_BtDef.rEn) and (l_Pos = l_BtDef.rEn.ToolBarPos),
                                          l_BtDef,
                                          l_BtDefs) then
            Break;
          end;//while True
          if (aForm is TvcmMainForm) then
           f_MainToolbarDefs[l_Pos].rButtons := l_BtDefs
          else
           MakeToolbarFromSettings(aForm, l_ToolbarName, l_Pos, anOptions, l_BtDefs);
          l_BtDefs := nil;
         end;//l_Entities <> nil
        end;//l_ToolbarVis
       end;//vcmToolbarVisible
      end;//l_Pos in l_Poses
     end;//for l_Pos
    end;//not vcmIsNil(l_UserType.Caption)
   end;//l_UserType <> nil
  end;//OneToolbarPerForm
  {$EndIf vcmUseSettings}
  BuildEntitiesToolbars(aForm, aForm.GetEntitiesDefIterator, anOptions, l_ExcludePoses);
 finally
  UnlockDocks;
 end;//try..finally
//#UC END# *52A83A6903B7_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.BuildFormToolbars
{$IfEnd} // NOT Defined(DesignTimeLibrary)

{$If NOT Defined(DesignTimeLibrary)}
procedure TvcmCustomMenuManager.BuildMainToolbars(aForm: TvcmEntityForm;
 const aModuleDef: IvcmModuleDef);
 {* создает Toolbar'ы основной формы }
//#UC START# *52A83AA6033F_4B30EC81021A_var*
var
 l_ExcludePoses: TvcmEffectiveToolBarPoses;
{$IfDef vcmUseSettings}
 l_Len: Integer;
 l_Pos: TvcmEffectiveToolBarPos;
 l_BtDef: TvcmButtonDef;
{$EndIf vcmUseSettings}
//#UC END# *52A83AA6033F_4B30EC81021A_var*
begin
//#UC START# *52A83AA6033F_4B30EC81021A_impl*
 l_ExcludePoses := [];
 {$IfDef vcmUseSettings}
 if OneToolbarPerForm and (vcm_toModulesInMainToolbar in ToolbarOptions)then
  for l_Pos := Low(TvcmEffectiveToolBarPos) to High(TvcmEffectiveToolBarPos) do
   with f_MainToolbarDefs[l_Pos] do
    if rVisibleLoaded then
    begin
     Include(l_ExcludePoses, l_Pos);
     if rVisible then
     begin
      l_Len := Length(rButtons);
      if (l_Len = 0) then
       l_BtDef.rPos := 0
      else
       l_BtDef.rPos := rButtons[Pred(l_Len)].rPos;
      l_BtDef.rEn := aModuleDef;
      LoadButtonsFromSettings(rUserType, rToolbarName, True, l_BtDef, rButtons);
     end;//rVisible
    end;//rVisibleLoaded
 {$EndIf vcmUseSettings}
 if (vcm_toModulesInMainToolbar in ToolbarOptions) then
  MakeToolbar(aForm, aModuleDef, [vcm_ooShowInMainToolbar], l_ExcludePoses);
 if (vcm_toEntitiesInMainToolbar in ToolbarOptions) then
  BuildEntitiesToolbars(aForm, aModuleDef.EntitiesDefIterator, [vcm_ooShowInMainToolbar], l_ExcludePoses);
//#UC END# *52A83AA6033F_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.BuildMainToolbars
{$IfEnd} // NOT Defined(DesignTimeLibrary)

procedure TvcmCustomMenuManager.CheckUserTypes;
//#UC START# *52A83AE7029B_4B30EC81021A_var*
//#UC END# *52A83AE7029B_4B30EC81021A_var*
begin
//#UC START# *52A83AE7029B_4B30EC81021A_impl*
 if (f_UserTypes = nil) then
  f_UserTypes := TvcmUserTypeDefList.Make;
//#UC END# *52A83AE7029B_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.CheckUserTypes

procedure TvcmCustomMenuManager.BuildUserTypes(const aModuleDef: IvcmModuleDef);
//#UC START# *52A83AF900CF_4B30EC81021A_var*
var
 l_UserTypes: IvcmUserTypesIterator;
 l_UserType: IvcmUserTypeDef;
//#UC END# *52A83AF900CF_4B30EC81021A_var*
begin
//#UC START# *52A83AF900CF_4B30EC81021A_impl*
 if not f_UserTypesLoaded then
 begin
  l_UserTypes := aModuleDef.UserTypesIterator;
  if (l_UserTypes <> nil) then
  begin
   CheckUserTypes;
   while True do
   begin
    l_UserType := l_UserTypes.Next;
    if (l_UserType = nil) then
     Break;
    f_UserTypes.Add(l_UserType);
   end;//while True
 //  while DoEntity(l_Entities.Next) do ;
  end;//l_UserTypes <> nil
 end;//not f_UserTypesLoaded
//#UC END# *52A83AF900CF_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.BuildUserTypes

procedure TvcmCustomMenuManager.ToolbarsGetSiteInfo(Sender: TObject;
 DockClient: TCustomToolWindow97;
 var CanDock: Boolean);
//#UC START# *52A83B1102D4_4B30EC81021A_var*
//#UC END# *52A83B1102D4_4B30EC81021A_var*
begin
//#UC START# *52A83B1102D4_4B30EC81021A_impl*
 if not (DockClient is TvcmToolbar) or not (Sender is TvcmDockDef) then
  CanDock := False
 else
  if (TvcmDockDef(Sender).Parent <> TvcmToolbar(DockClient).DockDef.Parent) then
   CanDock := False;
//#UC END# *52A83B1102D4_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.ToolbarsGetSiteInfo

function TvcmCustomMenuManager.BuildButton(aForm: TvcmEntityForm;
 aToolBar: TvcmToolbarDef;
 const aModuleDef: IvcmModuleDef;
 const anEntityDef: IvcmEntityDef;
 const anOp: IvcmOperationDef;
 anOptions: TvcmOperationOptions;
 anIconText: TvcmIconTextType = vcm_itDefault): TControl;
//#UC START# *52A83EA20222_4B30EC81021A_var*
//#UC END# *52A83EA20222_4B30EC81021A_var*
begin
//#UC START# *52A83EA20222_4B30EC81021A_impl*
 if (anOp = nil)
  then Result := nil
  else Result := BuildButton(aForm, aToolbar, aModuleDef, anEntityDef, anOp, anOp.Options, anOptions, anIconText);
//#UC END# *52A83EA20222_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.BuildButton

function TvcmCustomMenuManager.BuildButton(aForm: TvcmEntityForm;
 aToolBar: TvcmToolbarDef;
 const aModuleDef: IvcmModuleDef;
 const anEntityDef: IvcmEntityDef;
 const anOp: IvcmOperationDef;
 anOpOptions: TvcmOperationOptions;
 anOptions: TvcmOperationOptions;
 anIconText: TvcmIconTextType = vcm_itDefault): TControl;
//#UC START# *52A83EDA006E_4B30EC81021A_var*
 function lp_Images: TCustomImageList;
  function lp_MakeImages(const aSize: TvcmImageSize): TCustomImageList;
  begin
   Result := nil;
   case aSize of
    isSmall:
     Result := SmallImages;
    isLarge:
     Result := LargeImages;
   end;//case aSize of
  end;//lp_MakeImage
 begin
  Result := nil;
  with aForm.Style.Toolbars do
   case aToolbar.Pos of
    vcm_tbpTop:
     Result := lp_MakeImages(Top.ImageSize);
    vcm_tbpBottom:
     Result := lp_MakeImages(Bottom.ImageSize);
    vcm_tbpLeft:
     Result := lp_MakeImages(Left.ImageSize);
    vcm_tbpRight:
     Result := lp_MakeImages(Right.ImageSize);
   end;//case aToolbar.DockPos of
 end;//lp_Image
var
 l_ButtonName: AnsiString;
 l_EntityName: AnsiString;
 l_Entity: IvcmEntity;
//#UC END# *52A83EDA006E_4B30EC81021A_var*
begin
//#UC START# *52A83EDA006E_4B30EC81021A_impl*
 Result := nil;
 if (anOp <> nil) then
 begin
  if (anOp.OperationType in vcm_HiddenOperations) or
     (anOpOptions * anOptions = []) or
     ((aForm is TvcmEntityForm) and
      (TvcmEntityForm(aForm).UserType in anOp.ExcludeUserTypes)) then
   Result := g_InternalButton
  else
  begin
   // Имя формируется из сущности + имя операции
   if Assigned(aModuleDef) then
    l_EntityName := aModuleDef.Name
   else
    if Assigned(anEntityDef) then
     l_EntityName := anEntityDef.Name;
   // Сформируем имя. Отрежем префикс "op" у операции
   l_ButtonName := 'bt_' + l_EntityName + '_' + anOp.Name;
   Result := aToolBar.FindComponent(l_ButtonName) as TControl;
   if (Result = nil) then
   begin
    case anOp.OperationType of
     vcm_otButton,
     vcm_otButtonCombo,
     vcm_otMenuButtonCombo,
     vcm_otButtonPopup,
     vcm_otTextButton,
     vcm_otCheck,
     vcm_otRadio :
     begin
      Result := TvcmToolButtonDef.Create(aToolBar);
      TvcmToolButtonDef(Result).DropdownCombo := (anOp.OperationType in
       [vcm_otButtonCombo, vcm_otMenuButtonCombo]);
      if (anOp.OperationType in [vcm_otButtonPopup]) then
       TvcmToolButtonDef(Result).DropDownAlways := True;
     end;//vcm_otRadio
     vcm_otCombo,
     vcm_otEditCombo : begin
      Result := TvcmComboBox.Create(aToolbar);
      if (anOp.OperationType = vcm_otEditCombo) then
       TvcmComboBox(Result).Style := csDropDown
      else
       TvcmComboBox(Result).Style := csDropDownList;
      TvcmComboBox(Result).OnEnter := ControlEnter;
      TvcmComboBox(Result).OnExit := ControlExit;
      TvcmComboBox(Result).OnDropDown := ComboDown;
      TvcmComboBox(Result).OnSelect := ControlSelect;
      TvcmComboBox(Result).OnKeyDown := ControlKeyDown;
      {$IfDef vcmUseSettings}
      TvcmEdit(Result).PopupMenu := Self.ToolbarPopup;
      {$EndIf vcmUseSettings}
     end;//vcm_otCombo
     vcm_otEdit,
     vcm_otTyper :
     begin
      Result := TvcmEdit.Create(aToolbar);
      TvcmEdit(Result).OnEnter := ControlEnter;
      TvcmEdit(Result).OnExit := ControlExit;
      TvcmEdit(Result).OnKeyDown := ControlKeyDown;
      TvcmEdit(Result).ComboStyle := ct_cbEdit;
      TvcmEdit(Result).CEmptyHint := anOp.Hint;
      {$IfDef vcmUseSettings}
      TvcmEdit(Result).PopupMenu := Self.ToolbarPopup;
      {$EndIf vcmUseSettings}
      if (anOp.OperationType = vcm_otTyper) then
       TvcmEdit(Result).OnChange := ChangeTyperText;
     end;//vcm_otEdit
     vcm_otDate : begin
      Result := TvcmDateEdit.Create(aToolbar);
      TvcmDateEdit(Result).Width := TvcmDateEdit(Result).Width div 2;
      TvcmDateEdit(Result).OnEnter := ControlEnter;
      TvcmDateEdit(Result).OnExit := ControlExit;
      TvcmDateEdit(Result).OnKeyDown := ControlKeyDown;
      { ElDateTimePicker }
      { TDateTimePicker }
      TvcmDateEdit(Result).OnSelectDate := ControlSelect;
      TvcmDateEdit(Result).OnDropDown := DateDown;
     end;//vcm_otDate
     else begin
      Result := g_InternalButton;
      Exit;
     end;//else
    end;//case anOpOperationType
    Result.Parent := aToolbar;
    Result.Name := l_ButtonName;
    if Result is TvcmDateEdit then
     with TvcmDateEdit(Result) do
      AutoResize;

    { проблема в том, что нельзя сделать это(присвоение Constraint)
      до присвоения Parent (Handle не существует) }
//    case anOp.OperationType of
//     vcm_otCombo, vcm_otEditCombo :
//       TvcmComboBox(Result).Constraints.MaxWidth:=200;
//    end;

    if (aModuleDef <> nil) then
     Result.Action := BuildAction(aModuleDef, anOp)
    else
     if (anEntityDef <> nil) then
     begin
      Supports(aToolBar.Owner, IvcmEntity, l_Entity);
      try
       Result.Action := BuildAction(Result,
                                    l_Entity,
                                    anEntityDef,
                                    anOp,
                                    anOptions);
      finally
       l_Entity := nil;
      end;//try..finally
     end;//anEntityDef <> nil
    // Сформируем уникальное название компоненту, т.к. в разных сущностях
    // могут быть операции с одинаковыми названиями. Например форма "Список":
    // Печать..., Печать...(Документы), Печать...(Выделенные документы)
    with Result do
     if vcmSame(anOp.Hint, anOp.Caption) then
      Result.Hint := vcmStr(vcmMakeCaption(anEntityDef, anOp));
    Result.ShowHint := true;
    if (Result is TvcmToolButtonDef) then
    begin
     if (Result.Action <> nil) then
     begin
      with TvcmToolButtonDef(Result) do
      begin
       Images := lp_Images;
       if Images = nil then
        Images := ((Result.Action as TContainedAction).Actionlist as TCustomActionList).Images;
      end;//with TvcmToolButtonDef(Result) do
     end;//if (Result.Action <> nil) then
     if ((anOp.OperationType = vcm_otTextButton) and (anIconText = vcm_itDefault)) or
        (anIconText = vcm_itIconText) then
     begin
      TvcmToolButtonDef(Result).DisplayMode := dmBoth;
      TvcmToolButtonDef(Result).WordWrap := true;
     end//anOp.OperationType = vcm_otTextButton
     else
     if (anOp.ImageIndex >= 0) then
     // раньше был dmGlyph, но из - за http://mdp.garant.ru/pages/viewpage.action?pageId=287214455
     // пришлось добавить новый тип dmGlyphAndFakeText, чтобы в других проектах не отъехал dmGlyph
      TvcmToolButtonDef(Result).DisplayMode := dmGlyphAndFakeText
     else
     begin
      TvcmToolButtonDef(Result).DisplayMode := dmTextOnly;
      TvcmToolButtonDef(Result).WordWrap := true;
     end;//anOp.ImageIndex >= 0
     TvcmToolButtonDef(Result).AutoSize := true;
     TvcmToolButtonDef(Result).Opaque := false;
    end;//Result is TvcmToolButtonDef
    aToolBar.Width := aToolBar.Width + Result.Width;
   end;//Result = nil
  end;//anOp.OperationType in vcm_HiddenOperations..
 end;//anOp <> nil
//#UC END# *52A83EDA006E_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.BuildButton

function TvcmCustomMenuManager.BuildButton(aForm: TvcmEntityForm;
 aToolBar: TvcmToolbarDef;
 const aHolder: IvcmOperationalIdentifiedUserFriendlyControl;
 const anOp: IvcmOperationDef;
 anOpOptions: TvcmOperationOptions;
 anOptions: TvcmOperationOptions;
 anIconText: TvcmIconTextType = vcm_itDefault): TControl;
//#UC START# *52A83F1203DA_4B30EC81021A_var*
var
 l_Module: IvcmModuleDef;
 l_Entity: IvcmEntityDef;
//#UC END# *52A83F1203DA_4B30EC81021A_var*
begin
//#UC START# *52A83F1203DA_4B30EC81021A_impl*
 Supports(aHolder, IvcmModuleDef, l_Module);
 Supports(aHolder, IvcmEntityDef, l_Entity);
 Result := BuildButton(aForm, aToolbar, l_Module, l_Entity, anOp, anOpOptions, anOptions, anIconText)
//#UC END# *52A83F1203DA_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.BuildButton

function TvcmCustomMenuManager.BuildButton(aForm: TvcmEntityForm;
 aToolBar: TvcmToolbarDef;
 const aHolder: IvcmOperationalIdentifiedUserFriendlyControl;
 const anOp: IvcmOperationDef;
 anOptions: TvcmOperationOptions;
 anIconText: TvcmIconTextType = vcm_itDefault): TControl;
//#UC START# *52A83F4001DE_4B30EC81021A_var*
//#UC END# *52A83F4001DE_4B30EC81021A_var*
begin
//#UC START# *52A83F4001DE_4B30EC81021A_impl*
 if (anOp = nil)
  then Result := nil
  else Result := BuildButton(aForm, aToolbar, aHolder, anOp, anOp.Options, anOptions, anIconText)
//#UC END# *52A83F4001DE_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.BuildButton

function TvcmCustomMenuManager.BuildAction(const aModuleDef: IvcmModuleDef;
 const anOpDef: IvcmOperationDef): TCustomAction;
//#UC START# *52A83F6002D5_4B30EC81021A_var*
//#UC END# *52A83F6002D5_4B30EC81021A_var*
begin
//#UC START# *52A83F6002D5_4B30EC81021A_impl*
 Assert(aModuleDef <> nil);
 Assert(anOpDef <> nil);
 Result := TvcmModuleAction.Make(aModuleDef, anOpDef);
//#UC END# *52A83F6002D5_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.BuildAction

function TvcmCustomMenuManager.BuildAction(anOwner: TComponent;
 const anEntity: IvcmEntity;
 const anEntityDef: IvcmEntityDef;
 const anOpDef: IvcmOperationDef;
 anOptions: TvcmOperationOptions): TCustomAction;
//#UC START# *52A83F7C010F_4B30EC81021A_var*
var
 l_Form: IafwMainForm;
//#UC END# *52A83F7C010F_4B30EC81021A_var*
begin
//#UC START# *52A83F7C010F_4B30EC81021A_impl*
 Assert(anEntityDef <> nil);
 Assert(anOpDef <> nil);
 if (vcm_ooShowInChildToolbar in anOptions) or (
     (vcm_ooShowInMainToolbar in anOptions) and 
     (anEntity <> nil) and 
     Supports(anEntity, IafwMainForm, l_Form))
       //or: http://mdp.garant.ru/pages/viewpage.action?pageId=296098743
       // Actions главной формы не зависят от фокуса
 then
 begin
  if anEntity <> nil then
   Result := TvcmActiveEntityActionEx.Create(anOwner, anEntity, anEntityDef, anOpDef)
  else
   Result := nil;
 end
 else
  Result := TvcmEntityAction.Make(anEntityDef, anOpDef);
//#UC END# *52A83F7C010F_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.BuildAction

function TvcmCustomMenuManager.BuildSeparator(aToolBar: TvcmToolbarDef): TControl;
//#UC START# *52A83FA901D2_4B30EC81021A_var*
//#UC END# *52A83FA901D2_4B30EC81021A_var*
begin
//#UC START# *52A83FA901D2_4B30EC81021A_impl*
 if aToolbar.CanAddSeparator then
 begin
  Result := TvcmSeparatorDef.Create(aToolbar);
  Result.Parent := aToolbar;
 end//aToolbar.CanAddSeparator
 else
  Result := nil;
//#UC END# *52A83FA901D2_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.BuildSeparator

function TvcmCustomMenuManager.UserTypeByCaption(const aCaption: AnsiString;
 aFormClass: TClass = nil): IvcmUserTypeDef;
//#UC START# *52A840050220_4B30EC81021A_var*
var
 l_Index: Integer;
 l_UserType: IvcmUserTypeDef;
 l_UTCaption: IvcmCString;
//#UC END# *52A840050220_4B30EC81021A_var*
begin
//#UC START# *52A840050220_4B30EC81021A_impl*
 Result := nil;
 if (f_UserTypes <> nil) then
  with f_UserTypes do
   for l_Index := Lo to Hi do
   begin
    l_UserType := Items[l_Index];
    l_UTCaption := vcmCStr(l_UserType.SettingsCaption);
    if vcmSame(l_UTCaption, aCaption, true) and
    // http://mdp.garant.ru/pages/viewpage.action?pageId=471774401
     ((l_UserType.FormClass = aFormClass) or (aFormClass = nil)) then
     if TvcmUserTypeInfo.AllowCustomizeToolbars(l_UserType) then
     begin
      Result := l_UserType;
      break;
     end;//ANSISameText
   end;//for l_Index
//#UC END# *52A840050220_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.UserTypeByCaption

function TvcmCustomMenuManager.GetOneToolbarPerFormName(aForm: TvcmEntityForm;
 aPos: TvcmEffectiveToolBarPos;
 anIndex: Integer): AnsiString;
//#UC START# *52A840210281_4B30EC81021A_var*
//#UC END# *52A840210281_4B30EC81021A_var*
begin
//#UC START# *52A840210281_4B30EC81021A_impl*
 Result := 'tb' + aForm.FormID.rName + cTBName[aPos];
 if (anIndex > 0) then
  Result := Result + IntToStr(anIndex);
//#UC END# *52A840210281_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.GetOneToolbarPerFormName

{$If NOT Defined(DesignTimeLibrary)}
function TvcmCustomMenuManager.BuildToolbar(aForm: TvcmEntityForm;
 const aName: AnsiString;
 const aCaption: IvcmCString;
 aPos: TvcmEffectiveToolBarPos): TvcmToolbarDef;
//#UC START# *52A84049016E_4B30EC81021A_var*
var
 l_lnkMaximized,
 l_lnkOpen,
 l_lnkClose: IvcmFormHandler;

 function lp_GetParentForDock(aForm: TvcmEntityForm): TvcmEntityForm;

  function lp_DockButton(var aFormHandler : IvcmFormHandler;
                         const aForm      : TvcmEntityForm;
                         const aHandler   : TNotifyEvent;
                         const aHint      : Il3CString): Boolean;
  begin
   if Assigned(aHandler) then
   begin
    aFormHandler := TvcmFormHandler.Make(aForm, aHandler, aHint);
    Result := True;
   end//Assigned(aHandler)
   else
    Result := False;
  end;//lp_DockButton

 begin//lp_GetParentForDock
  Result := aForm.DefineDockContainer(aPos);
  // Определим обработчики кнопок dock - а формы:
  if not (aForm.ZoneType = vcm_ztForToolbarsInfo) then
  begin
   with TvcmEntityForm(Result) do
   begin
    // Close:
    if (CanClose = vcm_ccEnable) then
    begin
     lp_DockButton(l_lnkClose, Result, DefaultQueryClose,
      str_vcmCloseHint.AsCStr);
    end;//CanClose = vcm_ccEnable
    // Maximized:
    if not lp_DockButton(l_lnkMaximized, Result, OnQueryMaximized,
      str_vcmMaximizedHint.AsCStr) and
      (TvcmEntityForm(Result) <> aForm) then
     lp_DockButton(l_lnkMaximized, aForm, aForm.OnQueryMaximized,
      str_vcmMaximizedHint.AsCStr);
    // Open:
    if not lp_DockButton(l_lnkOpen, Result, OnQueryOpen,
     str_vcmOpenHint.AsCStr) and
      (TvcmEntityForm(Result) <> aForm) then
     lp_DockButton(l_lnkOpen, aForm, aForm.OnQueryOpen,
      str_vcmOpenHint.AsCStr);
   end;//with TvcmEntityForm(Result) do
  end;//if not (aForm.ZoneType = vcm_ztForToolbarsInfo) then
 end;//lp_GetParentForDock

 function GetFormWeight(aForm : TvcmEntityForm): Integer;
 begin//GetFormWeight
  if not (aForm is TvcmMainForm) then
   Result := 1
  else
   Result := 0;
 end;//GetFormWeight

 function lp_FindHandlersPublisher(const aControl: TWinControl): IvcmFormHandlersPublisher;
 var
  l_Parent: TWinControl;
 begin
  Result := nil;
  l_Parent := aControl;
  while (l_Parent <> nil) and
    not Supports(l_Parent, IvcmFormHandlersPublisher, Result) do
   l_Parent := l_Parent.Parent;
 end;//lp_FindHandlersPublisher

 function lp_FindHandlerWatcher(const aControl: TWinControl): IvcmCloseFormHandlerWatcher;
 var
  l_Parent: TWinControl;
 begin
  Result := nil;
  l_Parent := aControl;
  while (l_Parent <> nil) and
    not Supports(l_Parent, IvcmCloseFormHandlerWatcher, Result) do
   l_Parent := l_Parent.Parent;
 end;//lp_FindHandlerWatcher

var
 l_DockName: AnsiString;
 l_Dock: TvcmDockDef;
 l_NewDock: TvcmDockDef;
 l_ParentForm: TCustomForm;
 l_Index: TvcmEffectiveToolbarPos;
 l_DockParent: TWinControl;
 l_HandlersPublisher: IvcmFormHandlersPublisher;
 l_HandlerWatcher: IvcmCloseFormHandlerWatcher;
//#UC END# *52A84049016E_4B30EC81021A_var*
begin
//#UC START# *52A84049016E_4B30EC81021A_impl*
 l_lnkMaximized := nil;
 l_lnkOpen := nil;
 l_lnkClose := nil;
 l_ParentForm := lp_GetParentForDock(aForm);
 Result := aForm.FindComponent(aName) as TvcmToolbarDef;
 if (Result = nil) then
 begin
  l_Dock := nil;
  { Получим родителя для Dock }
  l_DockParent := GetDockParent(l_ParentForm);
  for l_Index := Low(TvcmEffectiveToolbarPos) to High(TvcmEffectiveToolbarPos) do
  begin
   if true{(l_Index in l_Poses)} then
   begin
    l_DockName := cTBName[l_Index] + 'Dock';
    l_NewDock := l_DockParent.FindComponent(l_DockName) as TvcmDockDef;
    if (l_NewDock = nil) then
    begin
     l_NewDock := TvcmDockDef.Make(l_DockParent, l_DockName, l_Index);
     l_NewDock.SetFasten(GetFastenMode);
       {$IfDef vcmUseSettings}
      //{$IfDef vcmCustomizeDock} чьё? зачем?
       l_NewDock.PopupMenu := Self.ToolbarPopup;
      //{$EndIf vcmCustomizeDock}
       {$EndIf vcmUseSettings}
        //l_NewDock.OnRequestDock := ToolbarsGetSiteInfo;
     aForm.AddDock(l_NewDock);
    end;//l_NewDock = nil
    if (aPos = l_Index) then
     l_Dock := l_NewDock;
   end;//l_Index in l_Poses
  end;//for l_Index

  if (l_Dock <> nil) then
  begin
   // Установим обработчики кнопок для Dock - а, в случае если не предусмотрен
   // публикатор кнопок:
   if (l_Dock.Align = alTop) then
   begin
    l_HandlersPublisher := lp_FindHandlersPublisher(l_DockParent);
    if (l_HandlersPublisher = nil) then
     l_Dock.SetHandlers(l_lnkMaximized, l_lnkOpen, l_lnkClose)
    else
    if (l_lnkClose <> nil) then
    begin
     Assert((l_lnkMaximized = nil) and (l_lnkOpen = nil));
     l_HandlersPublisher.Publish(l_lnkClose);
    end;//l_lnkClose <> nil
    if Assigned(l_lnkClose) then
    begin
     l_HandlerWatcher := lp_FindHandlerWatcher(l_DockParent);
     if Assigned(l_HandlerWatcher) then
      l_HandlerWatcher.SetWatch(l_lnkClose);
    end;//Assigned(l_lnkClose)
   end;//if (l_Dock.Align = alTop) then
   l_Dock.BeginUpdate;
   try
    Result := TvcmToolbar.Create(aForm, l_Dock);
    with Result do
    begin
     if not (aForm.ZoneType = vcm_ztForToolbarsInfo) then
      Parent := l_Dock; // может ещё что - то не нужно делать при "виртуальном" создании?
     Name := aName;
     Caption := vcmStr(aCaption);
      Weight := GetFormWeight(aForm);
      CloseMode := cmBackOnToolbar;
      DockGroup := Integer(l_DockParent);
      Collapsible := true;
      HideExtraSeparators := true;
      NearestParent := true;
      //{$IfNDef vcmCustomizeDock}
       {$IfDef vcmUseSettings}
       PopupMenu := Self.ToolbarPopup;
       {$EndIf vcmUseSettings}
      //{$EndIf  vcmCustomizeDock}
      //AutoSize := true;
     DragKind := dkDock;
     DragMode := dmManual;
    end;//with Result
   finally
    l_Dock.EndUpdate;
   end;//try..finally
  end;//l_Dock <> nil
 end;//l_Toolbar = nil
//#UC END# *52A84049016E_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.BuildToolbar
{$IfEnd} // NOT Defined(DesignTimeLibrary)

{$If NOT Defined(DesignTimeLibrary)}
function TvcmCustomMenuManager.BuildToolbar(aForm: TvcmEntityForm;
 aPos: TvcmEffectiveToolBarPos): TvcmToolbarDef;
//#UC START# *52A84071026E_4B30EC81021A_var*
var
 l_ToolbarName: AnsiString;
//#UC END# *52A84071026E_4B30EC81021A_var*
begin
//#UC START# *52A84071026E_4B30EC81021A_impl*
 Assert(OneToolbarPerForm);
 Assert(aForm.CurUserTypeDef <> nil);
 if True{(aPos in aForm.Toolbars)} then
 begin
  l_ToolbarName := GetOneToolbarPerFormName(aForm, aPos, 0);
  Result := BuildToolbar(aForm, l_ToolbarName, aForm.CurUserTypeDef.Caption, aPos) ;
 end//aPos in aForm.Toolbars
 else
  Result := nil;
//#UC END# *52A84071026E_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.BuildToolbar
{$IfEnd} // NOT Defined(DesignTimeLibrary)

procedure TvcmCustomMenuManager.CleanupSaveDockList(anItem: TvcmDockDef);
//#UC START# *52A840E30329_4B30EC81021A_var*
var
 I: Integer;
 l_List: TvcmObjectList;
//#UC END# *52A840E30329_4B30EC81021A_var*
begin
//#UC START# *52A840E30329_4B30EC81021A_impl*
 for I := 0 to f_SaveDockList.Count - 1 do
  if f_SaveDockList[I] is TvcmObjectList then
  begin
   l_List := TvcmObjectList(f_SaveDockList[I]);
   l_List.Remove(anItem);
  end;
//#UC END# *52A840E30329_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.CleanupSaveDockList

function TvcmCustomMenuManager.GetDockParent(aForm: TCustomForm): TWinControl;
//#UC START# *52A840F6027C_4B30EC81021A_var*
 function lp_FindDockContainer: TvcmDockContainer;
 var
  l_Component: TComponent;
 begin
  l_Component := aForm.FindComponent(c_vcmDockContainerName);
  if l_Component <> nil then
  begin
   Assert(l_Component is TvcmDockContainer);
   Result := TvcmDockContainer(l_Component);
  end//if Assigned(l_Component) then
  else
   Result := nil;
 end;//lp_FindDockContainer

 {$IfDef vcmUseMainToolbarPanel}
 function lp_MakeMainFormDockParent: TWinControl;
 var
  l_Index       : Integer;
  l_FormControl : TWinControl;
 begin
  Result := lp_FindDockContainer;
  if Result <> nil then
   Exit;
  for l_Index := 0 to Pred(aForm.ControlCount) do
  begin
   if aForm.Controls[l_Index] is TWinControl then
   begin
    l_FormControl := TWinControl(aForm.Controls[l_Index]);
    if l_FormControl.Align = alClient then
    begin
     Result := TvcmDockContainer.Create(aForm);
     Result.Parent := aForm;
     l_FormControl.Parent := Result;
     Result.Align := alClient;
     Break;
    end;//if (l_Component is TWinControl)
   end;//if aForm.Controls[l_Index] is TWinControl then
  end;//for l_Index := 0 to Pred(aForm.ComponentCount) do
 end;//lp_MakeMainFormDockParent
 {$EndIf vcmUseMainToolbarPanel}

 function lp_HasAlwaysOnTopControl: Boolean;
 var
  l_Index     : Integer;
 begin
  Result := True;
  for l_Index := Pred(aForm.ControlCount) downto 0 do
   if Supports(aForm.Controls[l_Index], IafwAlwaysOnTopControl) then
    Exit;
  Result := False;
 end;

 function lp_MakeDockContainer: TWinControl;
 var
  l_Index     : Integer;
  l_Control   : TControl;
 begin
  Result := nil;
  if (aForm is TvcmEntityForm) and lp_HasAlwaysOnTopControl then
  begin
   Result := lp_FindDockContainer;
   if Result = nil then
   begin
    Result := TvcmDockContainer.Create(aForm);
    Result.Parent := aForm;
    for l_Index := Pred(aForm.ControlCount) downto 0 do
    begin
     l_Control := aForm.Controls[l_Index];
     if (l_Control <> Result) and not Supports(l_Control, IafwAlwaysOnTopControl) then
      l_Control.Parent := Result;
    end;//for l_Index :=
    Result.Align := alClient;
   end;//if Result = nil then
  end;//if (aForm is TvcmEntityForm) and
 end;//lp_MakeDockContainer
//#UC END# *52A840F6027C_4B30EC81021A_var*
begin
//#UC START# *52A840F6027C_4B30EC81021A_impl*
 {$IfDef vcmUseMainToolbarPanel}
  if aForm is TvcmMainForm then
  begin
   Result := lp_MakeMainFormDockParent;
   // Если контейнер для доков не был создан, то проверим наличие строки
   // состояния и создадим контейнер при необходимости:
   if Result = nil then
    Result := lp_MakeDockContainer;
  end;//if aForm is TvcmMainForm then
 {$Else vcmUseMainToolbarPanel}
  Result := lp_MakeDockContainer;
 {$EndIf vcmUseMainToolbarPanel}
 if Result = nil then
  Result := aForm;
//#UC END# *52A840F6027C_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.GetDockParent

procedure TvcmCustomMenuManager.LoadGlyphSize(aDefault: Boolean = False);
//#UC START# *52A8410A0048_4B30EC81021A_var*
{$IfDef vcmUseSettings}
var
 l_Size: Cardinal;
 l_IDX: TvcmGlyphSize;
{$EndIf}
//#UC END# *52A8410A0048_4B30EC81021A_var*
begin
//#UC START# *52A8410A0048_4B30EC81021A_impl*
 {$IfDef vcmUseSettings}
 if vcmLoadCardinalParam([vcmPathPair('GlyphSize')], l_Size, aDefault) then
  for l_IDX := Low(TvcmGlyphSize) to High(TvcmGlyphSize) do
   if c_GlyphSizeMap[l_IDX] = l_Size then
   begin
    GlyphSize := l_IDX;
    Break;
   end;
 {$EndIf}
//#UC END# *52A8410A0048_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.LoadGlyphSize

procedure TvcmCustomMenuManager.LoadGlyphColorDepth(aDefault: Boolean = False);
//#UC START# *52A8411D0360_4B30EC81021A_var*
{$IfDef vcmUseSettings}
var
 l_Size: Cardinal;
{$EndIf}
//#UC END# *52A8411D0360_4B30EC81021A_var*
begin
//#UC START# *52A8411D0360_4B30EC81021A_impl*
 {$IfDef vcmUseSettings}
 if vcmLoadCardinalParam([vcmPathPair('GlyphColordepth')], l_Size, aDefault) then
  GlyphColordepth := TvcmGlyphColordepth(l_Size);
 {$EndIf}
//#UC END# *52A8411D0360_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.LoadGlyphColorDepth

procedure TvcmCustomMenuManager.UnlockDocks;
//#UC START# *52A8413B028B_4B30EC81021A_var*
var
 l_Index: Integer;
 l_Dock: TvcmDockDef;
 l_DockList: TvcmObjectList;
//#UC END# *52A8413B028B_4B30EC81021A_var*
begin
//#UC START# *52A8413B028B_4B30EC81021A_impl*
 Dec(f_LockCounter);
 Assert(f_LockCounter >= 0);
 if TvcmToolbarDockListManager.Exists
  then l_DockList := TvcmToolbarDockListManager.Instance.DockList
  else l_DockList := nil;
 if Assigned(l_DockList) and (l_DockList.Count > 0) and (f_LockCounter = 0) and (f_UnlockInProgress = 0) then
 begin
  Inc(f_UnlockInProgress);
  try
   for l_Index := l_DockList.Count - 1 downto 0 do
   begin
    l_Dock := TvcmDockDef(l_DockList[l_Index]);
    l_Dock.EndUpdate;
    l_Dock.SmartAlign := False;
   end;//for l_Index
   l_DockList.Clear;
  finally
   Dec(f_UnlockInProgress);
  end;
  if (f_UnlockInProgress = 0) and Assigned(f_LockList) then
  begin
   for l_Index := f_LockList.Count - 1 downto 0 do
    f_LockList[l_Index].MenuUnlockedFixUp;
   f_LockList.Clear;
  end;
 end;
//#UC END# *52A8413B028B_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.UnlockDocks

procedure TvcmCustomMenuManager.LockDocks;
//#UC START# *52A841470203_4B30EC81021A_var*
//#UC END# *52A841470203_4B30EC81021A_var*
begin
//#UC START# *52A841470203_4B30EC81021A_impl*
 Inc(f_LockCounter);
//#UC END# *52A841470203_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.LockDocks

procedure TvcmCustomMenuManager.StoreGlyphSize;
//#UC START# *52A8415303B8_4B30EC81021A_var*
//#UC END# *52A8415303B8_4B30EC81021A_var*
begin
//#UC START# *52A8415303B8_4B30EC81021A_impl*
 {$IfDef vcmUseSettings}
 vcmSaveCardinalParam([vcmPathPair('GlyphSize')], c_GlyphSizeMap[GlyphSize]);
 {$EndIf}
//#UC END# *52A8415303B8_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.StoreGlyphSize

procedure TvcmCustomMenuManager.RestoreGlyphSize;
//#UC START# *52A8416200DA_4B30EC81021A_var*
//#UC END# *52A8416200DA_4B30EC81021A_var*
begin
//#UC START# *52A8416200DA_4B30EC81021A_impl*
 LoadGlyphSize(True);
//#UC END# *52A8416200DA_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.RestoreGlyphSize

procedure TvcmCustomMenuManager.StoreGlyphColordepth;
//#UC START# *52A8416F01AC_4B30EC81021A_var*
//#UC END# *52A8416F01AC_4B30EC81021A_var*
begin
//#UC START# *52A8416F01AC_4B30EC81021A_impl*
 {$IfDef vcmUseSettings}
 vcmSaveCardinalParam([vcmPathPair('GlyphColordepth')], Ord(GlyphColordepth));
 {$EndIf}
//#UC END# *52A8416F01AC_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.StoreGlyphColordepth

procedure TvcmCustomMenuManager.RestoreGlyphColordepth;
//#UC START# *52A8417A02AD_4B30EC81021A_var*
//#UC END# *52A8417A02AD_4B30EC81021A_var*
begin
//#UC START# *52A8417A02AD_4B30EC81021A_impl*
 LoadGlyphColordepth(True);
//#UC END# *52A8417A02AD_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.RestoreGlyphColordepth

procedure TvcmCustomMenuManager.InitToolbarMetrics(aForm: TCustomForm);
 {* определить метрики панели инструментов. Компоненты, которые могут быть помещены в панель, могут иметь разные размеры, чтобы высота панелей была одинаковой, считаем максимальную высоту и используем её для всех панелей. }
//#UC START# *52A8418F0245_4B30EC81021A_var*
var
 l_Toolbar: TvcmToolbar;
 l_Dock: TvcmDockDef;
 l_Button: TToolbarButton97;
 l_Date: TvcmDateEdit;
 l_Edit: TvcmEdit;
//#UC END# *52A8418F0245_4B30EC81021A_var*
begin
//#UC START# *52A8418F0245_4B30EC81021A_impl*
 if (f_MaxControlToolbarSize = 0) and Assigned(SmallImages) and (SmallImages.Count > 0) then
 begin
  l_Dock := TvcmDockDef.Create(aForm);
  try
   l_Dock.Parent := aForm;
   l_Toolbar := TvcmToolbar.Create(l_Dock, l_Dock);
   try
    l_Toolbar.Parent := l_Dock;
    l_Toolbar.BevelEdges := [beBottom, beLeft, beRight, beTop];
    // TToolbarButton97:
    l_Button := TToolbarButton97.Create(l_Toolbar);
    with l_Button do
    begin
     Parent := l_Toolbar;
     Images := SmallImages;
     ImageIndex := 0;
    end;//with l_Button do
    // TvcmEdit:
    l_Date := TvcmDateEdit.Create(l_Toolbar);
    l_Date.Parent := l_Toolbar;
    // TvcmDateEdit:
    l_Edit := TvcmEdit.Create(l_Toolbar);
    l_Edit.Parent := l_Toolbar;
    // Вычислим:
    l_Dock.ArrangeToolbars(False);
    // f_MaxControlToolbarSize:
    f_ButtonHeight := l_Button.Height;
    f_MaxControlToolbarSize := Max(l_Button.Height, f_MaxControlToolbarSize);
    f_MaxControlToolbarSize := Max(l_Date.Height, f_MaxControlToolbarSize);
    f_MaxControlToolbarSize := Max(l_Edit.Height, f_MaxControlToolbarSize);
    // f_SmallToolbarSize:
    f_SmallToolbarSize := l_Toolbar.Height;
    // f_DiffSize:
    //f_DiffSize := f_SmallToolbarSize - f_MaxControlToolbarSize;
    // Процедура определения размера toolbar - а:
    TB97Tlbr.g_ToolbarSize := ToolbarSize;
    TB97Ctls.g_tbToolbarButtonSize := ToolbarButtonSize;
   finally//l_Toolbar := TvcmToolbar.Create(l_Panel, nil);
    vcmFree(l_Toolbar);
   end;{try..finally}
  finally//l_Dock := TvcmDockDef.Create(l_Panel);
   vcmFree(l_Dock);
  end;{try..finally}
 end;//if (f_MaxControlToolbarSize = 0)
 if aForm is TvcmMainForm then
  TvcmMainForm(aForm).SmallToolbarSize(f_SmallToolbarSize);
//#UC END# *52A8418F0245_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.InitToolbarMetrics

procedure TvcmCustomMenuManager.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4B30EC81021A_var*
var
 l_MyEvent: TNotifyEvent;
 l_MyMethod: TMethod absolute l_MyEvent;
 l_Event: TNotifyEvent;
 l_Method: TMethod absolute l_Event;
//#UC END# *479731C50290_4B30EC81021A_var*
begin
//#UC START# *479731C50290_4B30EC81021A_impl*
 TB97Tlbr.g_ToolbarSize := nil;
 {$IfDef vcmUseSettings}
 Finalize(f_MainToolbarDefs);
 {$EndIf vcmUseSettings}
 if (Screen <> nil) then
 begin
  l_Event := Screen.OnActiveFormChange;
  l_MyEvent := FormChange;
  if (l_Method.Code = l_MyMethod.Code) and (l_Method.Data = l_MyMethod.Data) then
   Screen.OnActiveFormChange := nil;
 end;//Screen <> nil
 vcmFree(f_MainMenuItems);
 vcmFree(f_Popup);
 vcmFree(f_SaveLockCounter);
 vcmFree(f_LockList);

 vcmFree(f_SaveDockList);
 Actions := nil;
 vcmFree(f_UserTypes);
 inherited;
//#UC END# *479731C50290_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.Cleanup

constructor TvcmCustomMenuManager.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_4B30EC81021A_var*
var
 l_Form: TCustomForm;
//#UC END# *47D1602000C6_4B30EC81021A_var*
begin
//#UC START# *47D1602000C6_4B30EC81021A_impl*
 inherited;
 MenuOptions := vcm_DefaultMenuOptions;
 ToolbarOptions := vcm_DefaultToolbarOptions;
 if not (csDesigning in ComponentState) then
 begin
  l_Form := afw.GetParentForm(Self);
  if (l_Form is TForm) then
   if (l_Form is TvcmMainForm) and not TvcmMainForm(l_Form).SDI then
    TForm(l_Form).FormStyle := fsMDIForm;
  Screen.OnActiveFormChange := FormChange;
 end;//not (csDesigning in ComponentState)
 f_MainMenuItems := TvcmMenuItemsCollection.Create(Self);
 f_TickCount := Cardinal(-1);
 OneToolbarPerForm := true;
 f_FastenToolbars := -1;
 f_SaveDockList := Tl3ProtoObjectRefList.Make;
 f_BtnCloseImageIndex := -1;
 f_BtnOpenImageIndex := -1;
 f_BtnOpenNewWindowImageIndex := -1;
 f_SaveLockCounter := TvcmLongintList.Make;
 f_LockCounter := 0;
 f_UnlockInProgress := 0;
 f_GlyphSize := vcm_gs16x16;
 f_SmallToolbarSize := 0;
//#UC END# *47D1602000C6_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.Create

{$If NOT Defined(DesignTimeLibrary)}
procedure TvcmCustomMenuManager.RegisterModuleInMenu(aForm: TvcmEntityForm;
 const aModuleDef: IvcmModuleDef);
 {* регистрирует модуль в меню, toolbar'ах, etc. Для перекрытия в потомках. }
//#UC START# *52A1FC0C0333_4B30EC81021A_var*
var
 l_Main: TMenuItem;
 l_Item: TMenuItem;
//#UC END# *52A1FC0C0333_4B30EC81021A_var*
begin
//#UC START# *52A1FC0C0333_4B30EC81021A_impl*
// if (aForm = Application.MainForm) or (Application.MainForm = nil) then begin
 if (aForm is TvcmMainForm) then
 begin
  TvcmMainMenuBuilder.Instance.RegisterModule(aModuleDef);

  THackWinControl(aForm).DestroyHandle;
  // - это здесь ОБЯЗАТЕЛЬНО нужно иначе окно открывается в РАЗЫ медленнее
  l_Main := vcmGetMainMenu(aForm);
  l_Item := vcmMakeModuleMenu(l_Main, aModuleDef, [vcm_ooShowInMainMenu], true);
  if (vcm_moEntitiesInMainMenu in MenuOptions) then
  begin
   if (vcm_moEntitiesInTopMainMenu in MenuOptions) then
    vcmMakeEntitiesMenus(l_Main, aModuleDef.EntitiesDefIterator, [vcm_ooShowInMainMenu])
   else
    vcmMakeEntitiesMenus(l_Item, aModuleDef.EntitiesDefIterator, [vcm_ooShowInMainMenu]);
  end else
   vcmMakeEntitiesMenus(l_Item, aModuleDef.EntitiesDefIterator, [vcm_ooShowInMainMenu], False, vcm_icSameAsParent);
  if (f_UserTypes = nil) then
  begin
   CheckUserTypes;
   aForm.GetUserTypes(f_UserTypes);
  end;//f_UserTypes = nil
  BuildMainToolbars(aForm, aModuleDef);
  BuildUserTypes(aModuleDef);
 end;//aForm = Application.MainForm
//#UC END# *52A1FC0C0333_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.RegisterModuleInMenu
{$IfEnd} // NOT Defined(DesignTimeLibrary)

{$If NOT Defined(DesignTimeLibrary)}
procedure TvcmCustomMenuManager.MainCreated(aForm: TvcmEntityForm);
//#UC START# *52A1FC3D0231_4B30EC81021A_var*
var
 l_Menu: TMenuItem;
 l_Index: Integer;
 l_MMI: TvcmMenuItemsCollectionItem;
//#UC END# *52A1FC3D0231_4B30EC81021A_var*
begin
//#UC START# *52A1FC3D0231_4B30EC81021A_impl*
 inherited;
 if not (csDesigning in ComponentState) then
 begin
  OverridePopupMenu(aForm);
  if (aForm is TvcmMainForm) and not TvcmMainForm(aForm).SDI then
   TForm(aForm).FormStyle := fsMDIForm;
  l_Menu := vcmGetMainMenu(aForm);
  for l_Index := 0 to Pred(MainMenuItems.Count) do
  begin
   l_MMI := TvcmMenuItemsCollectionItem(MainMenuItems.Items[l_Index]);
   TvcmMainMenuAction.MakeForMenu(vcmAddCategoryItem(l_Menu, l_MMI.Caption), l_MMI.OnTest);
  end;//for l_Index
  if (vcm_toEntitiesInMainToolbar in ToolbarOptions) then
   BuildFormToolbars(aForm, [vcm_ooShowInMainToolbar]);
 end;//not (csDesigning in ComponentState)
//#UC END# *52A1FC3D0231_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.MainCreated
{$IfEnd} // NOT Defined(DesignTimeLibrary)

procedure TvcmCustomMenuManager.RegisterMainInMenu(aForm: TvcmEntityForm);
 {* регистрирует основную форму в меню, toolbar'ах, etc. Для перекрытия в потомках. }
//#UC START# *52A1FC5500AC_4B30EC81021A_var*
var
 l_Item: TMenuItem;
 l_Child: TMenuItem;
 l_Index: Integer;
// l_MenuHolder: IvcmMenuHolder;
 l_NeedBuild: Boolean;
//#UC END# *52A1FC5500AC_4B30EC81021A_var*
begin
//#UC START# *52A1FC5500AC_4B30EC81021A_impl*
 if not (csDesigning in ComponentState) then
 begin
  TvcmMainMenuBuilder.Instance.RegisterForm(aForm);
  l_NeedBuild := True;
  LoadGlyphSize;
  LoadGlyphColordepth;
  l_Item := vcmGetMainMenu(aForm);
  vcmMakeEntitiesMenus(l_Item, aForm.GetEntitiesDefIterator, [vcm_ooShowInMainMenu]);
  l_Index := 0;
  while (l_Index < l_Item.Count) do
  begin
   l_Child := l_Item.Items[l_Index];
   if (l_Child.Count <= 0) then
    l_Item.Remove(l_Child)
   else
    Inc(l_Index);
  end;//while (l_Index < l_Item.Count)
  {$IfDef vcmUseSettings}
  MakeMainToolbarFromSettings(aForm);
  {$EndIf vcmUseSettings}
  f_UserTypesLoaded := true;
 end;//not (csDesigning in ComponentState)
//#UC END# *52A1FC5500AC_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.RegisterMainInMenu

{$If NOT Defined(DesignTimeLibrary)}
procedure TvcmCustomMenuManager.RegisterChildInMenu(aForm: TvcmEntityForm);
 {* регистрирует дочернюю форму в меню, toolbar'ах, etc. Для перекрытия в потомках. }
//#UC START# *52A1FC79004A_4B30EC81021A_var*
 procedure BuildMainMenu;
 var
  l_Item       : TMenuItem;
  l_Main       : TMenuItem;
  l_GroupIndex : Integer;
 begin//BuildMainMenu
  if not (vcm_moEntitiesInMainMenu in MenuOptions) and
    (vcm_moEntitiesInChildMenu in MenuOptions) then
  begin
   l_Main := vcmGetMainMenu(Application.MainForm);
   with l_Main do
    l_GroupIndex := Items[Pred(Count)].GroupIndex;
   l_Item := vcmGetMainMenu(aForm);
   vcmMakeEntitiesMenus(l_Item, aForm.GetEntitiesDefIterator, [vcm_ooShowInChildMenu], False, vcm_icNotFound, l_Main);
   l_Item.Items[0].GroupIndex := Succ(l_GroupIndex);
  end;//not NeedMainEntitiesMenu
 end;//BuildMainMenu
//#UC END# *52A1FC79004A_4B30EC81021A_var*
begin
//#UC START# *52A1FC79004A_4B30EC81021A_impl*
 (* Удаляем windows окно, чтобы во время долгосрочных операций построения меню и
    toolbar - ов окна не прорисовывались. Окно формы восстанавливается в
    TvcmEntityForm.Make *)
// THackWinControl(aForm).DestroyHandle;
 OverridePopupMenu(aForm);
 BuildMainMenu;
 if (vcm_toEntitiesInChildToolbar in ToolbarOptions) then
  BuildFormToolbars(aForm, [vcm_ooShowInChildToolbar]);
//#UC END# *52A1FC79004A_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.RegisterChildInMenu
{$IfEnd} // NOT Defined(DesignTimeLibrary)

function TvcmCustomMenuManager.GetPopupMenu: TPopupMenu;
//#UC START# *52A1FCA20227_4B30EC81021A_var*
//#UC END# *52A1FCA20227_4B30EC81021A_var*
begin
//#UC START# *52A1FCA20227_4B30EC81021A_impl*
 Result := f_Popup;
//#UC END# *52A1FCA20227_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.GetPopupMenu

procedure TvcmCustomMenuManager.ReloadToolbars(const aForm: IvcmEntityForm);
//#UC START# *52A1FD4C002A_4B30EC81021A_var*
var
 l_List: TvcmToolbarDefList;
{$IfDef vcmUseSettings}
 l_Form: TvcmEntityForm;
 l_Index: Integer;
{$EndIf vcmUseSettings}
//#UC END# *52A1FD4C002A_4B30EC81021A_var*
begin
//#UC START# *52A1FD4C002A_4B30EC81021A_impl*
 {$IfDef vcmUseSettings}
 LockDocks;
 try
  LoadGlyphSize;
  LoadGlyphColordepth;
  l_Form := aForm.VCLWinControl as TvcmEntityForm;
  l_List := TvcmToolbarDefList.Create;
  try
   with l_Form do
   begin
    for l_Index := 0 to Pred(ComponentCount) do
     if (Components[l_Index] is TvcmToolbarDef) then
     begin
      TvcmToolbarDef(Components[l_Index]).Hide;
      l_List.Add(TvcmToolbarDef(Components[l_Index]));
     end;
    for l_Index := 0 to l_List.Count - 1 do
    begin
     RemoveComponent(l_List[l_Index]);
     l_List[l_Index].Parent := nil;
     if (Application.MainForm <> nil) and Application.MainForm.HandleAllocated then
      PostMessage(Application.MainForm.Handle, vcm_msgFreeComponent, 0, LParam(l_List[l_Index]))
     else
      l_List[l_Index].Free;
    end;
   end;
  finally
   vcmFree(l_List);
  end;
  if (l_Form is TvcmMainForm) then
  begin
   BuildFormToolbars(l_Form, [vcm_ooShowInMainToolbar]);
   with TvcmDispatcher.Instance do
    for l_Index := 0 to Pred(ModulesCount) do
     BuildMainToolbars(l_Form, Module[l_Index].ModuleDef);
   MakeMainToolbarFromSettings(l_Form);
  end
  else
   BuildFormToolbars(l_Form, [vcm_ooShowInChildToolbar]);
  if aForm.ZoneType <> vcm_ztForToolbarsInfo then
  begin
   PostBuild(l_Form, true);
  end;
 finally
  UnlockDocks;
 end;
 {$EndIf vcmUseSettings}
//#UC END# *52A1FD4C002A_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.ReloadToolbars

procedure TvcmCustomMenuManager.PostBuild(aForm: TvcmEntityForm;
 aFollowDocks: Boolean = False);
//#UC START# *52A1FD7301A8_4B30EC81021A_var*
{$IfDef vcmUseSettings}
var
 l_Index, l_BarIndex: Integer;
 l_Toolbar: TvcmToolbarDef;
 l_Point: TPoint;
 l_FollowToolbar: TvcmToolbarDef;
 l_List: TvcmToolbarDefList;

 function GetDockName(aDockPos: Cardinal): string;
 begin
  Result:='';
  case TDockPosition(aDockPos) of
   dpTop: Result := cTBName[vcm_tbpTop];
   dpBottom: Result := cTBName[vcm_tbpBottom];
   dpLeft: Result := cTBName[vcm_tbpLeft];
   dpRight: Result := cTBName[vcm_tbpRight];
  end;
  Result := Result+'Dock';
 end;

 function LoadAndPlaceToolbar(const aUTName  : String;
                              const aToolbar : TvcmToolbarDef): Boolean;
 var
  l_ToolbarPos : TvcmToolbarPositions;
  l_Dock       : TvcmDockDef;
  l_DockParent : TWinControl;
 begin
  Result := vcmLoadToolbarPos(aUTName, aToolbar.Name, l_ToolbarPos);
  l_DockParent := GetDockParent(aForm.DefineDockContainer(aToolbar.Pos));
  if Result then
  begin
   l_Dock := l_DockParent.FindComponent(GetDockName(l_ToolbarPos.rDock)) as TvcmDockDef;
   if (l_Dock <> nil) then
   begin
    if l_ToolbarPos.rFloating {and not GetFastenMode} then
    begin
     l_Point.X := l_ToolbarPos.rFloatX;
     l_Point.Y := l_ToolbarPos.rFloatY;
     aToolbar.FloatingPosition := l_Point;
     aToolbar.DockPos := l_ToolbarPos.rPos;
     aToolbar.DockRow := l_ToolbarPos.rRow;
     aToolbar.FloatingWidth := l_ToolbarPos.rFloatingWidth;
     aToolbar.Parent := l_Dock;
     aToolbar.DockedTo := nil;
    end//if l_ToolbarPos.rFloating
    else
    begin
     l_Dock.BeginUpdate;
     l_Dock.SmartAlign := False;
     aToolbar.Parent := l_Dock;
     l_Point.X := l_ToolbarPos.rFloatX;
     l_Point.Y := l_ToolbarPos.rFloatY;
     aToolbar.FloatingPosition := l_Point;
     aToolbar.DockPos := l_ToolbarPos.rPos;
     aToolbar.DockRow := l_ToolbarPos.rRow;
     aToolbar.FloatingWidth := l_ToolbarPos.rFloatingWidth;
     l_Dock.EndUpdate;
    end;//if l_ToolbarPos.rFloating
   end;//if (l_Dock <> nil) then
  end;//if Result then
 end;//LoadAndPlaceToolbar
{$EndIf vcmUseSettings}
//#UC END# *52A1FD7301A8_4B30EC81021A_var*
begin
//#UC START# *52A1FD7301A8_4B30EC81021A_impl*
 inherited;
 {$IfDef vcmUseSettings} 
 LockDocks;
 try
  if (aForm.UserTypes.Count > 0) then
  begin
   l_Index := 0;
   while l_Index < aForm.ComponentCount do
   begin
    if aForm.Components[l_Index] is TvcmToolbarDef then
    begin
     l_Toolbar := aForm.Components[l_Index] as TvcmToolbarDef;
     if GetOpLock and (l_Toolbar.DockedTo <> nil) then
      if TvcmToolbarDockListManager.Instance.DockList.IndexOf(l_Toolbar.DockedTo) < 0 then
      begin
       TvcmToolbarDockListManager.Instance.DockList.Add(l_Toolbar.DockedTo);
       l_Toolbar.DockedTo.BeginUpdate;
      end;
     if aFollowDocks and (l_Toolbar.DockedTo <> nil) then
     begin
      //for l_BarIndex := 0 to l_Toolbar.DockedTo.ToolbarCount - 1 do
      //видимо, при установленном BeginUpdate, DockVisibleList(и, как следствие, TOolbarCount)
      //не обновляются.

      // Делаем через временный список, т.к. в Conotols входят и кнопки, которые
      // перекладываются вместе с тулбаром на другой док и изменение ConotolCount
      // может быть более чем на 1...
      l_List := TvcmToolbarDefList.Create;
      try
       for l_BarIndex := l_Toolbar.DockedTo.ControlCount - 1 downto 0 do
        if l_Toolbar.DockedTo.Controls[l_BarIndex] is TvcmToolbarDef then
         l_List.Add(TvcmToolbarDef(l_Toolbar.DockedTo.Controls[l_BarIndex]));
       for l_BarIndex := l_List.Count - 1 downto 0 do
       begin
        l_FollowToolbar := l_List[l_BarIndex];
        if l_FollowToolbar.Owner is TvcmEntityForm and
          (TvcmEntityForm(l_FollowToolbar.Owner).UserTypes.Count > 0) then
         LoadAndPlaceToolbar((l_FollowToolbar.Owner as TvcmEntityForm).
          UserTypes[(l_FollowToolbar.Owner as TvcmEntityForm).UserType].Name,
           l_FollowToolbar);
       end;
      finally
       l_List.Free;
      end;
 {
      //Делаем задом наперед - поскольку тулбар может переехать на другой док
      for l_BarIndex := l_Toolbar.DockedTo.ControlCount - 1 downto 0 do
       if l_Toolbar.DockedTo.Controls[l_BarIndex] is TvcmToolbarDef then
       begin
        l_FollowToolbar := l_Toolbar.DockedTo.Controls[l_BarIndex] as TvcmToolbarDef;
        if l_FollowToolbar.Owner is TvcmEntityForm and
          (TvcmEntityForm(l_FollowToolbar.Owner).UserTypes.Count > 0) then
         LoadAndPlaceToolbar((l_FollowToolbar.Owner as TvcmEntityForm).
          UserTypes[(l_FollowToolbar.Owner as TvcmEntityForm).UserType].Name,
           l_DockParent, l_FollowToolbar);
       end;}
     end
     else
      LoadAndPlaceToolbar(aForm.UserTypes[aForm.UserType].Name, l_Toolbar);
    end;
    Inc(l_Index);
   end;
 (*
    Открутил пока загрузку главного тулбара совместно с текущим
    l_Form := aForm._NativeMainForm.asForm.VCLForm;
    // отсекаем формы, тулбары которых не мержатся в главную форму
    if MergedToMainForm(aForm as TvcmEntityForm) then
    begin
     l_DockParent := GetDockParent(GetParentForDock(l_Form as TvcmEntityForm));
     for l_Index := 0 to l_Form.ComponentCount - 1 do
     begin
      if l_Form.Components[l_Index] is TvcmToolbarDef then
      begin
       l_Toolbar := l_Form.Components[l_Index] as TvcmToolbarDef;

       if not LoadAndPlaceToolbar(aForm.UserTypes[aForm.UserType].Name, l_DockParent, l_Toolbar) then
       begin
       // дефолтное размещение главного тулбара
        l_TopDock := l_DockParent.FindComponent(cTBName[vcm_tbpTop]+'Dock') as TvcmDockDef;
        if l_TopDock <> nil then
        begin
         l_TopDock.BeginUpdate;
         {$EndIf vcmUseTB97}
         l_Toolbar.DockPos := 0;
         l_Toolbar.DockRow := 0;
         l_Toolbar.Parent := l_TopDock;
         {$IfDef vcmUseTB97}
         l_TopDock.EndUpdate;
        end;
       end;
      end;
     end;
    end;
 *)   
  end;

 finally
  UnlockDocks;
 end;
 {$EndIf vcmUseSettings}
//#UC END# *52A1FD7301A8_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.PostBuild

procedure TvcmCustomMenuManager.BackupOpStatus;
//#UC START# *52A1FDD7006C_4B30EC81021A_var*
var
 l_List: TvcmObjectList;
//#UC END# *52A1FDD7006C_4B30EC81021A_var*
begin
//#UC START# *52A1FDD7006C_4B30EC81021A_impl*
 f_SaveLockCounter.Add(f_LockCounter);
 l_List:= TvcmObjectList.Make;
 try
  l_List.JoinWith(TvcmToolbarDockListManager.Instance.DockList);
  f_SaveDockList.Add(l_List);
 finally
  vcmFree(l_List);
 end;//try..finally
 f_LockCounter := 1;
 EndOp;
 inherited;
//#UC END# *52A1FDD7006C_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.BackupOpStatus

procedure TvcmCustomMenuManager.RestoreOpStatus;
//#UC START# *52A1FE020318_4B30EC81021A_var*
var
 l_Index: Integer;
 l_List: TvcmObjectList;
//#UC END# *52A1FE020318_4B30EC81021A_var*
begin
//#UC START# *52A1FE020318_4B30EC81021A_impl*
 inherited;
 BeginOp;
 Assert((f_SaveLockCounter.Count > 0) and (f_SaveDockList.Count > 0));
 f_LockCounter := f_SaveLockCounter[f_SaveLockCounter.Count - 1];
 f_SaveLockCounter.Delete(f_SaveLockCounter.Count - 1);

 l_List := TvcmObjectList(f_SaveDockList[f_SaveDockList.Count - 1]).Use;
 try
  f_SaveDockList.Delete(f_SaveDockList.Count - 1);
  TvcmToolbarDockListManager.Instance.DockList.Clear;
  TvcmToolbarDockListManager.Instance.DockList.JoinWith(l_List);
 finally
  vcmFree(l_List);
 end;//try..finally
 for l_Index := 0 to TvcmToolbarDockListManager.Instance.DockList.Count - 1 do
  TvcmDockDef(TvcmToolbarDockListManager.Instance.DockList[l_Index]).BeginUpdate;
//#UC END# *52A1FE020318_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.RestoreOpStatus

procedure TvcmCustomMenuManager.BeginOp;
//#UC START# *52A1FE1602AA_4B30EC81021A_var*
//#UC END# *52A1FE1602AA_4B30EC81021A_var*
begin
//#UC START# *52A1FE1602AA_4B30EC81021A_impl*
 inherited;
 LockDocks;
//#UC END# *52A1FE1602AA_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.BeginOp

function TvcmCustomMenuManager.GetOpLock: Boolean;
//#UC START# *52A1FE2E0059_4B30EC81021A_var*
//#UC END# *52A1FE2E0059_4B30EC81021A_var*
begin
//#UC START# *52A1FE2E0059_4B30EC81021A_impl*
 Result := f_LockCounter > 0;
//#UC END# *52A1FE2E0059_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.GetOpLock

procedure TvcmCustomMenuManager.EndOp;
//#UC START# *52A1FE4B0329_4B30EC81021A_var*
//#UC END# *52A1FE4B0329_4B30EC81021A_var*
begin
//#UC START# *52A1FE4B0329_4B30EC81021A_impl*
 UnlockDocks;
 inherited;
//#UC END# *52A1FE4B0329_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.EndOp

procedure TvcmCustomMenuManager.FastenToolbars;
//#UC START# *52A1FE58028C_4B30EC81021A_var*
 procedure lp_ChangeToolbarsMode(const aForm      : IvcmEntityForm;
                                 const aCheckMain : Boolean = False);
 var
  l_Count     : Integer;
  l_Index     : Integer;
  l_Container : TvcmDockContainer;
 begin
  //if (aForm.VCLWinControl is TvcmEntityForm) then
   for l_Count := 0 to aForm.VCLWinControl.ComponentCount - 1 do
   begin
    if aForm.VCLWinControl.Components[l_Count] is TvcmDockDef then
     (aForm.VCLWinControl.Components[l_Count] as TvcmDockDef).SetFasten(GetFastenMode)
    else
    if aCheckMain and (aForm.VCLWinControl.Components[l_Count] is TvcmDockContainer) then
    begin
     l_Container := aForm.VCLWinControl.Components[l_Count] as TvcmDockContainer;
     for l_Index := 0 to l_Container.ComponentCount - 1 do
      if l_Container.Components[l_Index] is TvcmDockDef then
       (l_Container.Components[l_Index] as TvcmDockDef).SetFasten(GetFastenMode)
    end;//if aCheckMain
   end;//for l_Count := 0
 end;//lp_ChangeToolbarsMode

 procedure lp_InvertFastenMode;
 begin//lp_InvertFastenMode
  if f_FastenToolbars = - 1 then
   GetFastenMode;
  if f_FastenToolbars = 0 then
   f_FastenToolbars := 1
  else
   f_FastenToolbars := 0;
 end;//lp_InvertFastenMode

var
 l_Index : Integer;
 l_Form  : IvcmEntityForm;
//#UC END# *52A1FE58028C_4B30EC81021A_var*
begin
//#UC START# *52A1FE58028C_4B30EC81021A_impl*
 lp_InvertFastenMode;
 with TvcmDispatcher.Instance do
  for l_Index := 0 to EntitiesCount - 1 do
   if Supports(Entity[l_Index], IvcmEntityForm, l_Form) then
    lp_ChangeToolbarsMode(l_Form);
 with TvcmDispatcher.Instance do
  for l_Index := 0 to FormDispatcher.MainFormsCount - 1 do
   if Supports(FormDispatcher.MainForm[l_Index], IvcmEntityForm, l_Form) then
    lp_ChangeToolbarsMode(l_Form, True);
 {$IfDef vcmUseSettings}
 vcmSaveFastenMode(GetFastenMode);
 {$EndIf vcmUseSettings}
//#UC END# *52A1FE58028C_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.FastenToolbars

function TvcmCustomMenuManager.GetFastenMode: Boolean;
//#UC START# *52A1FE730278_4B30EC81021A_var*
//#UC END# *52A1FE730278_4B30EC81021A_var*
begin
//#UC START# *52A1FE730278_4B30EC81021A_impl*
 Result := False;
 {$IfDef vcmUseSettings}
 if f_FastenToolbars = - 1 then
  vcmLoadFastenMode(Result)
 else
  Result := f_FastenToolbars = 0;
 {$EndIf vcmUseSettings}

 if Result then
  f_FastenToolbars := 0
 else
  f_FastenToolbars := 1;
//#UC END# *52A1FE730278_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.GetFastenMode

function TvcmCustomMenuManager.ObjectByType(anObject: TvcmObject;
 const anObjectName: AnsiString;
 const aSubName: AnsiString = '';
 ForceCreate: Boolean = False): TvcmBaseCollectionItem;
//#UC START# *52A1FF0902CE_4B30EC81021A_var*
//#UC END# *52A1FF0902CE_4B30EC81021A_var*
begin
//#UC START# *52A1FF0902CE_4B30EC81021A_impl*
 Result := nil;
 case anObject of
  vcm_objMainMenuItem :
   if (MainMenuItems <> nil) then
    Result := MainMenuItems.FindItemByName(anObjectName);
  else
   Result := inherited ObjectByType(anObject, anObjectName, aSubName, ForceCreate);
 end;//case anObject
//#UC END# *52A1FF0902CE_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.ObjectByType

function TvcmCustomMenuManager.UnlockInProgress: Boolean;
//#UC START# *52A2008D00DA_4B30EC81021A_var*
//#UC END# *52A2008D00DA_4B30EC81021A_var*
begin
//#UC START# *52A2008D00DA_4B30EC81021A_impl*
 Result := (f_UnlockInProgress > 0);
//#UC END# *52A2008D00DA_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.UnlockInProgress

procedure TvcmCustomMenuManager.AddControlForUnlockPostBuild(const aControl: IafwMenuUnlockedPostBuild);
//#UC START# *52A200A001C8_4B30EC81021A_var*
//#UC END# *52A200A001C8_4B30EC81021A_var*
begin
//#UC START# *52A200A001C8_4B30EC81021A_impl*
 if f_LockList = nil then
  f_LockList := TIafwMenuUnlockedPostBuildPtrList.MakeSorted;
 f_LockList.Add(aControl);
//#UC END# *52A200A001C8_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.AddControlForUnlockPostBuild

procedure TvcmCustomMenuManager.ListenerControlDestroying(const aControl: IafwMenuUnlockedPostBuild);
//#UC START# *52A200C203A4_4B30EC81021A_var*
//#UC END# *52A200C203A4_4B30EC81021A_var*
begin
//#UC START# *52A200C203A4_4B30EC81021A_impl*
 if Assigned(f_LockList) then
  f_LockList.Remove(aCOntrol);
//#UC END# *52A200C203A4_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.ListenerControlDestroying

function TvcmCustomMenuManager.FillPopupMenu(const aPopupPoint: TPoint;
 aPopupComponent: TComponent): TvcmPopupMenuPrim;
//#UC START# *52A841C500C5_4B30EC81021A_var*
var
 l_Point: TPoint;
//#UC END# *52A841C500C5_4B30EC81021A_var*
begin
//#UC START# *52A841C500C5_4B30EC81021A_impl*
 l_Point := aPopupPoint;
 Result := f_Popup;
 if (aPopupComponent is TControl) then
  if PtInRect(TControl(aPopupComponent).ClientRect, l_Point) then
   THackPopupMenu(Result).FPopupPoint := TControl(aPopupComponent).ClientToScreen(l_Point)
  else
  begin
   repeat
    with l_Point, TControl(aPopupComponent) do
    begin
     X := X + Left;
     Y := Y + Top;
     aPopupComponent := Parent;
    end;
   until not Assigned(aPopupComponent) or ((aPopupComponent is TControl) and (THackControl(aPopupComponent).GetPopupMenu <> nil));
   if Assigned(aPopupComponent) then
    FillPopupMenu(l_Point, aPopupComponent);
   Exit;
  end
 else
  THackPopupMenu(Result).FPopupPoint := l_Point;
 f_Popup.PopupComponent := aPopupComponent;
 DoPopup(f_Popup);
 {$IfNDef DesignTimeLibrary}
 {$IfDef l3HackedVCL}
 f_Popup.Items.CallInitiateActions;
 {$EndIf l3HackedVCL}
 {$EndIf  DesignTimeLibrary}
 f_Popup.Items.RethinkHotkeys;
 f_Popup.Items.RethinkLines;
//#UC END# *52A841C500C5_4B30EC81021A_impl*
end;//TvcmCustomMenuManager.FillPopupMenu

{$If NOT Defined(NoVCL)}
procedure TvcmComboBoxActionLink.SetCaption(const Value: String);
//#UC START# *508F991B003B_52A8477B0012_var*
//#UC END# *508F991B003B_52A8477B0012_var*
begin
//#UC START# *508F991B003B_52A8477B0012_impl*
 inherited;
 if (FClient is TvcmComboBox) and (Action is TvcmOperationAction) then
  TvcmComboBox(FClient).SetCaptionFromAction(TvcmOperationAction(Action), True);
//#UC END# *508F991B003B_52A8477B0012_impl*
end;//TvcmComboBoxActionLink.SetCaption
{$IfEnd} // NOT Defined(NoVCL)

procedure TvcmComboBoxActionLink.DoParamsChanged(const anAction: IvcmAction);
//#UC START# *52A8469903AF_52A8477B0012_var*
//#UC END# *52A8469903AF_52A8477B0012_var*
begin
//#UC START# *52A8469903AF_52A8477B0012_impl*
 inherited;
 if (FClient is TvcmComboBox) then
  with TvcmComboBox(FClient) do
  begin
   if (anAction.SubNodes <> nil) then
    ShowRoot := anAction.SubNodes.ShowRoot;
   SetStringsFromAction(anAction);
   {$IfNDef DesignTimeLibrary}
   if (anAction.SubNodes <> nil) then
    vcmSetCurrent(anAction.SubNodes.Current);
   {$EndIf  DesignTimeLibrary} 
   Hint := vcmStr(anAction.Hint);
  end;//with TvcmComboBox(FClient)
//#UC END# *52A8469903AF_52A8477B0012_impl*
end;//TvcmComboBoxActionLink.DoParamsChanged

procedure TvcmComboBoxActionLink.DoParamsChanging(const anAction: IvcmAction);
//#UC START# *52A846AF0108_52A8477B0012_var*
//#UC END# *52A846AF0108_52A8477B0012_var*
begin
//#UC START# *52A846AF0108_52A8477B0012_impl*
 inherited;
 if (FClient is TvcmComboBox) then
  if (anAction.SubNodes <> nil) then
   with anAction.SubNodes do
   begin
    Current := TvcmComboBox(FClient).CurrentNode;
    ShowRoot := TvcmComboBox(FClient).ShowRoot;
   end;//anAction.SubNodes
//#UC END# *52A846AF0108_52A8477B0012_impl*
end;//TvcmComboBoxActionLink.DoParamsChanging

procedure TvcmComboBox.SetCaptionFromAction(anAction: TvcmOperationAction;
 anUpdateIndex: Boolean);
//#UC START# *52A9AA140394_52A045E102E3_var*
var
 l_Action: IvcmAction;
//#UC END# *52A9AA140394_52A045E102E3_var*
begin
//#UC START# *52A9AA140394_52A045E102E3_impl*
 if not f_InUpdateCation and (anAction.OpDef.OperationType = vcm_otCombo) then
 begin
  f_InUpdateCation := True;
  try
   if Supports(anAction, IvcmAction, l_Action) then
   try
    if not SetStringsFromAction(anAction) then
    begin
(*     {$IfNDef vcmUseComboTree}
     Items.Clear;
     Items.Add(vcmStr(l_Action.SelectedString));
     if anUpdateIndex then
      ItemIndex := Items.IndexOf(vcmStr(l_Action.SelectedString));
     {$EndIf vcmUseComboTree}*)
    end;//not SetStringsFromAction(anAction)
   finally
    l_Action := nil;
   end;//try..finally
  finally
   f_InUpdateCation := False;
  end;//try..finally
 end;//not f_InUpdateCation and (anAction.OpDef.OperationType = vcm_otCombo)
//#UC END# *52A9AA140394_52A045E102E3_impl*
end;//TvcmComboBox.SetCaptionFromAction

function TvcmComboBox.SetStringsFromAction(const anAction: IvcmAction): Boolean;
//#UC START# *52A9AA400220_52A045E102E3_var*
var
 l_Strings: IvcmStrings;
//#UC END# *52A9AA400220_52A045E102E3_var*
begin
//#UC START# *52A9AA400220_52A045E102E3_impl*
 Result := False;
 l_Strings := anAction.SubItems;
 if (l_Strings = nil) or (l_Strings.Count = 0) then
 begin
  Result := vcmSetRoot(anAction.SubNodes);
  if (anAction.SubNodes = nil) or (anAction.SubNodes.Count = 0) then
   if anAction.IsSelectedStringChanged then
   //if not l3Same(Text, anAction.SelectedString) then
    Text := anAction.SelectedString;
 end//l_Strings = nil
 else
 begin
  Result := True;
  if (Action is TvcmOperationAction) and
   (TvcmOperationAction(Action).OpDef.OperationType = vcm_otCombo) then
  begin
   Items.Assign(l_Strings.Items);
   if not vcmIsNil(anAction.SelectedString) then
    ItemIndex := Items.IndexOf(anAction.SelectedString);
  end//anAction is TvcmOperationAction
  else
  begin
   Items.Assign(l_Strings.Items);
   if anAction.IsSelectedStringChanged then
   begin
    if not l3Same(Text, anAction.SelectedString) then
    begin
     Text := anAction.SelectedString;
     //AdjustWidth;
     //// ^ http://mdp.garant.ru/pages/viewpage.action?pageId=100958843
     // КОСТЫЛЬ ПЕРЕЕХАЛ В TctButtonEdit.pm_SetText из - за K278854646
    end;//not l3Same(Text, anAction.SelectedString)
   end;//not vcmSame(f_SelectedString, anAction.SelectedString)
  end;//anAction is TvcmOperationAction
 end;//l_Strings = nil..
//#UC END# *52A9AA400220_52A045E102E3_impl*
end;//TvcmComboBox.SetStringsFromAction

procedure TvcmComboBox.CMTBMouseQuery(var Msg: TMessage);
//#UC START# *52A9A42D031B_52A045E102E3_var*
//#UC END# *52A9A42D031B_52A045E102E3_var*
begin
//#UC START# *52A9A42D031B_52A045E102E3_impl*
 if InnerPoint(Point(Integer(Msg.WParam), Integer(Msg.LParam)))
  then Msg.Result := 1
  else Msg.Result := 0;
//#UC END# *52A9A42D031B_52A045E102E3_impl*
end;//TvcmComboBox.CMTBMouseQuery

procedure TvcmComboBox.CMTBCheckControl(var Msg: TMessage);
//#UC START# *52A9A4500057_52A045E102E3_var*
//#UC END# *52A9A4500057_52A045E102E3_var*
begin
//#UC START# *52A9A4500057_52A045E102E3_impl*
 if IsInnerControl(HWND(Msg.WParam))
  then Msg.Result := 1
  else Msg.Result := 0;
//#UC END# *52A9A4500057_52A045E102E3_impl*
end;//TvcmComboBox.CMTBCheckControl

constructor TvcmComboBox.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_52A045E102E3_var*
//#UC END# *47D1602000C6_52A045E102E3_var*
begin
//#UC START# *47D1602000C6_52A045E102E3_impl*
 inherited;
 AutoWidth := awCurrent;
//#UC END# *47D1602000C6_52A045E102E3_impl*
end;//TvcmComboBox.Create

{$If NOT Defined(NoVCL)}
function TvcmComboBox.GetActionLinkClass: TControlActionLinkClass;
//#UC START# *4F8845840032_52A045E102E3_var*
//#UC END# *4F8845840032_52A045E102E3_var*
begin
//#UC START# *4F8845840032_52A045E102E3_impl*
 Result := TvcmComboBoxActionLink;
//#UC END# *4F8845840032_52A045E102E3_impl*
end;//TvcmComboBox.GetActionLinkClass
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCL)}
procedure TvcmComboBox.ActionChange(Sender: TObject;
 CheckDefaults: Boolean);
//#UC START# *52A9A8710199_52A045E102E3_var*
//#UC END# *52A9A8710199_52A045E102E3_var*
begin
//#UC START# *52A9A8710199_52A045E102E3_impl*
 if (Sender is TvcmOperationAction) then
  SetCaptionFromAction(TvcmOperationAction(Sender), False);
 inherited;
//#UC END# *52A9A8710199_52A045E102E3_impl*
end;//TvcmComboBox.ActionChange
{$IfEnd} // NOT Defined(NoVCL)

procedure TvcmComboBox.DropDown;
//#UC START# *52A9A9B802B4_52A045E102E3_var*
var
 l_Action: IvcmAction;
//#UC END# *52A9A9B802B4_52A045E102E3_var*
begin
//#UC START# *52A9A9B802B4_52A045E102E3_impl*
 if Supports(Action, IvcmAction, l_Action) then
 try
  SetStringsFromAction(l_Action);
  inherited;
 finally
  l_Action := nil;
 end//try..finally
 else
  inherited;
//#UC END# *52A9A9B802B4_52A045E102E3_impl*
end;//TvcmComboBox.DropDown

procedure TvcmComboBox.ActionExecuteHandler;
//#UC START# *52A9AADF0289_52A045E102E3_var*
var
 l_LockCount: Integer;
 l_Action: IvcmAction;

 procedure lp_SaveLock;
 begin
  l_LockCount:=0;
  while l_Action.IsExecuteLocked do
  begin
   l_Action.UnlockExecute;
   Inc(l_LockCount);
  end;//while l_Action.IsExecuteLocked do
 end;//lp_SaveLock

 procedure lp_RestoreLock;
 begin
  while l_LockCount > 0 do
  begin
   l_Action.LockExecute;
   Dec(l_LockCount);
  end;//while l_LockCount > 0 do
 end;//lp_RestoreLock
//#UC END# *52A9AADF0289_52A045E102E3_var*
begin
//#UC START# *52A9AADF0289_52A045E102E3_impl*
 if Supports(Action, IvcmAction, l_Action) then
 try
  Action.ActionComponent := Self;
  l_Action.SelectedString := Text;
  l_Action.LockUpdate;
  try
   lp_SaveLock;
   try
    Action.Execute;
   finally
    lp_RestoreLock;
   end;//try..finally
  finally
   l_Action.UnlockUpdate;
  end;//try..finally
 finally
  l_Action := nil;
 end;//try..finally
//#UC END# *52A9AADF0289_52A045E102E3_impl*
end;//TvcmComboBox.ActionExecuteHandler

procedure TvcmComboBox.LocalUpdateAction;
//#UC START# *52A9AAEA0068_52A045E102E3_var*
var
 l_Action: IvcmAction;
//#UC END# *52A9AAEA0068_52A045E102E3_var*
begin
//#UC START# *52A9AAEA0068_52A045E102E3_impl*
 if Supports(Action, IvcmAction, l_Action) then
 try
  l_Action.SelectedString := Text;
 finally
  l_Action := nil;
 end;//try..finally
//#UC END# *52A9AAEA0068_52A045E102E3_impl*
end;//TvcmComboBox.LocalUpdateAction

constructor TvcmEdit.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_52A9AB640217_var*
//#UC END# *47D1602000C6_52A9AB640217_var*
begin
//#UC START# *47D1602000C6_52A9AB640217_impl*
 inherited;
 Width := 121;
 // При установке фокуса выделяем весь текст
 AutoSelect := True;
//#UC END# *47D1602000C6_52A9AB640217_impl*
end;//TvcmEdit.Create

function TvcmEdit.DoProcessCommand(Cmd: Tl3OperationCode;
 aForce: Boolean;
 aCount: Integer): Boolean;
//#UC START# *48BD22E601F2_52A9AB640217_var*
//#UC END# *48BD22E601F2_52A9AB640217_var*
begin
//#UC START# *48BD22E601F2_52A9AB640217_impl*
 Result := inherited DoProcessCommand(Cmd, aForce, aCount);
 if not Result then
 begin
  Tag := 0;
  case Cmd of
   ccNewLine:
    begin
     Tag := Integer(Cmd);
     with Action do
     begin
      ActionComponent := Self;
      Execute;
     end;
     Result := True;
    end;
  end;
 end;
//#UC END# *48BD22E601F2_52A9AB640217_impl*
end;//TvcmEdit.DoProcessCommand

{$If NOT Defined(NoVCL)}
function TvcmEdit.GetActionLinkClass: TControlActionLinkClass;
//#UC START# *4F8845840032_52A9AB640217_var*
//#UC END# *4F8845840032_52A9AB640217_var*
begin
//#UC START# *4F8845840032_52A9AB640217_impl*
 Result := TvcmEditActionLink;
//#UC END# *4F8845840032_52A9AB640217_impl*
end;//TvcmEdit.GetActionLinkClass
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCL)}
procedure TvcmEdit.ActionChange(Sender: TObject;
 CheckDefaults: Boolean);
//#UC START# *52A9A8710199_52A9AB640217_var*
var
 l_Action: IvcmAction;
//#UC END# *52A9A8710199_52A9AB640217_var*
begin
//#UC START# *52A9A8710199_52A9AB640217_impl*
 if Supports(Sender, IvcmAction,  l_Action) then
 try
  l_Action.LockExecute;
  try
   inherited;
  finally
   l_Action.UnlockExecute;
  end;//try..finally
 finally
  l_Action := nil;
 end//try..finally
 else
  inherited;
//#UC END# *52A9A8710199_52A9AB640217_impl*
end;//TvcmEdit.ActionChange
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCL)}
function TvcmDateEditActionLink.IsCaptionLinked: Boolean;
//#UC START# *508F983B0344_52A9AF9703DC_var*
//#UC END# *508F983B0344_52A9AF9703DC_var*
begin
//#UC START# *508F983B0344_52A9AF9703DC_impl*
 Result := False;
  // - реагировать на изменение Caption мы не можем, потому как он может
  //   меняться, значение же хранится в параметре SelectedString (K<50758978>);
//#UC END# *508F983B0344_52A9AF9703DC_impl*
end;//TvcmDateEditActionLink.IsCaptionLinked
{$IfEnd} // NOT Defined(NoVCL)

procedure TvcmDateEditActionLink.DoParamsChanged(const anAction: IvcmAction);
//#UC START# *52A8469903AF_52A9AF9703DC_var*
//#UC END# *52A8469903AF_52A9AF9703DC_var*
begin
//#UC START# *52A8469903AF_52A9AF9703DC_impl*
 inherited;
 if anAction.IsSelectedStringChanged and (FClient is TvcmDateEdit) then
  TvcmDateEdit(FClient).Text := vcmStr(anAction.SelectedString);
//#UC END# *52A8469903AF_52A9AF9703DC_impl*
end;//TvcmDateEditActionLink.DoParamsChanged

procedure TvcmDateEdit.CMTextChanged(var Message: TMessage);
//#UC START# *52A9AC1601B3_52A9ABFF02E0_var*
//#UC END# *52A9AC1601B3_52A9ABFF02E0_var*
begin
//#UC START# *52A9AC1601B3_52A9ABFF02E0_impl*
 inherited;
 { Если маска установлена поле не может быть пустым }
 if (EditMask <> '') and (EditText = '') then
  Clear;
//#UC END# *52A9AC1601B3_52A9ABFF02E0_impl*
end;//TvcmDateEdit.CMTextChanged

constructor TvcmDateEdit.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_52A9ABFF02E0_var*
//#UC END# *47D1602000C6_52A9ABFF02E0_var*
begin
//#UC START# *47D1602000C6_52A9ABFF02E0_impl*
 inherited;
 RestrictInvalidDate := True;
//#UC END# *47D1602000C6_52A9ABFF02E0_impl*
end;//TvcmDateEdit.Create

{$If NOT Defined(NoVCL)}
function TvcmDateEdit.GetActionLinkClass: TControlActionLinkClass;
//#UC START# *4F8845840032_52A9ABFF02E0_var*
//#UC END# *4F8845840032_52A9ABFF02E0_var*
begin
//#UC START# *4F8845840032_52A9ABFF02E0_impl*
 Result := TvcmDateEditActionLink;
//#UC END# *4F8845840032_52A9ABFF02E0_impl*
end;//TvcmDateEdit.GetActionLinkClass
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCL)}
procedure TvcmDateEdit.ActionChange(Sender: TObject;
 CheckDefaults: Boolean);
//#UC START# *52A9A8710199_52A9ABFF02E0_var*
var
 l_Action: IvcmAction;
//#UC END# *52A9A8710199_52A9ABFF02E0_var*
begin
//#UC START# *52A9A8710199_52A9ABFF02E0_impl*
 inherited;
 // После смены Action текст будет равен названию операции поэтому после смены
 // нужно установить текущее значение:
 if Supports(Action, IvcmAction, l_Action) then
 try
  l_Action.LockExecute;
  try
   Text := vcmStr(l_Action.SelectedString);
  finally
   l_Action.UnlockExecute;
  end;//try..finally
 finally
  l_Action := nil;
 end;//try..finally
//#UC END# *52A9A8710199_52A9ABFF02E0_impl*
end;//TvcmDateEdit.ActionChange
{$IfEnd} // NOT Defined(NoVCL)

procedure TvcmDateEdit.DoCloseUp(Accept: Boolean);
//#UC START# *52A9AF500143_52A9ABFF02E0_var*
//#UC END# *52A9AF500143_52A9ABFF02E0_var*
begin
//#UC START# *52A9AF500143_52A9ABFF02E0_impl*
 inherited DoCloseUp(Accept);
 if Assigned(f_OnSelectDate) and Accept then
  f_OnSelectDate(Self);
//#UC END# *52A9AF500143_52A9ABFF02E0_impl*
end;//TvcmDateEdit.DoCloseUp

function TvcmMenuManagerHelper.CreateManager: Boolean;
//#UC START# *9CBAC5378D28_55019B3B011B_var*
//#UC END# *9CBAC5378D28_55019B3B011B_var*
begin
//#UC START# *9CBAC5378D28_55019B3B011B_impl*
 if (g_MenuManager = nil) then
 begin
  Result := true;
  TvcmMenuManager.Create(nil);
 end//g_MenuManager = nil
 else
  Result := false;
//#UC END# *9CBAC5378D28_55019B3B011B_impl*
end;//TvcmMenuManagerHelper.CreateManager

procedure TvcmMenuManagerHelper.FreeManager;
//#UC START# *FFCD4B7E45D8_55019B3B011B_var*
//#UC END# *FFCD4B7E45D8_55019B3B011B_var*
begin
//#UC START# *FFCD4B7E45D8_55019B3B011B_impl*
 FreeAndNil(g_MenuManager);
//#UC END# *FFCD4B7E45D8_55019B3B011B_impl*
end;//TvcmMenuManagerHelper.FreeManager

class function TvcmMenuManagerHelper.Instance: TvcmMenuManagerHelper;
 {* Метод получения экземпляра синглетона TvcmMenuManagerHelper }
begin
 if (g_TvcmMenuManagerHelper = nil) then
 begin
  l3System.AddExitProc(TvcmMenuManagerHelperFree);
  g_TvcmMenuManagerHelper := Create;
 end;
 Result := g_TvcmMenuManagerHelper;
end;//TvcmMenuManagerHelper.Instance

class function TvcmMenuManagerHelper.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TvcmMenuManagerHelper <> nil;
end;//TvcmMenuManagerHelper.Exists

procedure TvcmDispatcherHelper.ClearHistory;
//#UC START# *CA1F3F463873_5501A60D002E_var*
//#UC END# *CA1F3F463873_5501A60D002E_var*
begin
//#UC START# *CA1F3F463873_5501A60D002E_impl*
 if TvcmDispatcher.Exists then
  if (TvcmDispatcher.Instance.History <> nil) then
   TvcmDispatcher.Instance.History.Clear(false);
//#UC END# *CA1F3F463873_5501A60D002E_impl*
end;//TvcmDispatcherHelper.ClearHistory

class function TvcmDispatcherHelper.Instance: TvcmDispatcherHelper;
 {* Метод получения экземпляра синглетона TvcmDispatcherHelper }
begin
 if (g_TvcmDispatcherHelper = nil) then
 begin
  l3System.AddExitProc(TvcmDispatcherHelperFree);
  g_TvcmDispatcherHelper := Create;
 end;
 Result := g_TvcmDispatcherHelper;
end;//TvcmDispatcherHelper.Instance

class function TvcmDispatcherHelper.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TvcmDispatcherHelper <> nil;
end;//TvcmDispatcherHelper.Exists

type _Instance_R_ = TvcmToolbarDefList;

{$Include w:\common\components\rtl\Garant\L3\l3ObjectPtrList.imp.pas}

//#UC START# *4B30EC67025Aimpl*
//#UC END# *4B30EC67025Aimpl*

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvcmPopupMenu);
 {* Регистрация TvcmPopupMenu }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvcmFakeBox);
 {* Регистрация TvcmFakeBox }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvcmDockContainer);
 {* Регистрация TvcmDockContainer }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvcmToolButtonDef);
 {* Регистрация TvcmToolButtonDef }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvcmButtonPopupMenu);
 {* Регистрация TvcmButtonPopupMenu }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvcmCustomMenuManager);
 {* Регистрация TvcmCustomMenuManager }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvcmComboBox);
 {* Регистрация TvcmComboBox }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvcmEdit);
 {* Регистрация TvcmEdit }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvcmDateEdit);
 {* Регистрация TvcmDateEdit }
{$IfEnd} // NOT Defined(NoScripts)
 Tl3MenuManagerHelper.Instance.Alien := TvcmMenuManagerHelper.Instance;
 {* Регистрация TvcmMenuManagerHelper }
 Tl3DispatcherHelper.Instance.Alien := TvcmDispatcherHelper.Instance;
 {* Регистрация TvcmDispatcherHelper }
//#UC START# *52AB0BCD033E*
 g_InternalButton := TvcmToolButtonDef.Create(nil);
//#UC END# *52AB0BCD033E*
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvcmMenuManager);
 {* Регистрация TvcmMenuManager }
{$IfEnd} // NOT Defined(NoScripts)

finalization
//#UC START# *52AB0BD60025*
 vcmFree(g_InternalButton);
//#UC END# *52AB0BD60025*
{$IfEnd} // NOT Defined(NoVCM)

end.
