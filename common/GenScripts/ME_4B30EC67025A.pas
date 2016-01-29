unit vcmMenuManager;

interface

uses
 l3IntfUses
 , tb97vt
 , vcmPopupMenuPrim
 , Messages
 , vcmUserControls
 , vtComboTree
 , TB97ExtInterfaces
 , Classes
 , ExtCtrls
 , evButton
 , vcmExternalInterfaces
 , Controls
 , vcmInterfaces
 , vcmToolbarMenuRes
 , vcmOperationAction
 , vcmWinControlActionLink
 , vcmBaseMenuManager
 , ImgList
 , ActnList
 , vcmMenuItemsCollection
 , vcmUserTypeDefList
 , l3ProtoObjectRefList
 , vcmBase
 , IafwMenuUnlockedPostBuildPtrList
 , vcmEntityForm
 , Forms
 , tb97Ctls
 , TB97Tlbr
 , vcmToolbar
 , TB97
 , Menus
 , vcmBaseCollectionItem
 , afwInterfaces
 , Types
 , l3ProtoObject
 , l3Interfaces
 , vtDblClickDateEdit
 , Windows
 , l3MenuManagerHelper
 , l3DispatcherHelper
 , l3ProtoDataContainer
;

type
 TvcmPopupMenu = class(TvcmPopupMenuPrim)
  procedure ClearInPopup;
 end;//TvcmPopupMenu
 
 TvcmButtonDef = record
 end;//TvcmButtonDef
 
 TvcmFakeBox = class(TvtComboTree, ITB97Ctrl)
  {* общая функциональность необходимая vcm при использовании TFakeBox }
  function FullWidth: Integer;
   {* обычный размер компонента, для вычисления и размещения компонентов }
  function IsSizeable: Boolean;
   {* компонент может изменять размеры }
  function MinWidth: Integer;
   {* минимальный размер до которого может сжиматься компонент }
  procedure DoFitToWidth(aWidth: Integer);
  procedure DoUnFitToWidth(aWidth: Integer);
  procedure Expand;
 end;//TvcmFakeBox
 
 TvcmDockContainer = class(TPanel)
  {* Панель используемая для размещения главной панели инструментов формы. }
 end;//TvcmDockContainer
 
 TvcmButtonDefs = array of TvcmButtonDef;
 
 TvcmMenuOption = (
  vcm_moEntitiesInMainMenu
  , vcm_moEntitiesInTopMainMenu
  , vcm_moEntitiesInChildMenu
  , vcm_moEntitesInContextMenu
 );//TvcmMenuOption
 
 TvcmToolButtonDefActionLink = class(TevCustomButtonActionLink, IvcmActionLink)
  procedure ParamsChanged(const anAction: IvcmAction);
  procedure ParamsChanging(const anAction: IvcmAction);
 end;//TvcmToolButtonDefActionLink
 
 TvcmToolButtonDef = class(TevButton)
  function IsIconText: Boolean;
 end;//TvcmToolButtonDef
 
 TvcmToolbarOption = (
  vcm_toModulesInMainToolbar
  , vcm_toEntitiesInMainToolbar
  , vcm_toEntitiesInChildToolbar
 );//TvcmToolbarOption
 
 TvcmIconTextType = (
  vcm_itDefault
  , vcm_itIcon
  , vcm_itIconText
 );//TvcmIconTextType
 
 TvcmGlyphColordepth = (
  vcm_gcAuto
  , vcm_gc16
  , vcm_gc256
  , vcm_gcTrueColor
 );//TvcmGlyphColordepth
 
 TvcmToolbarDefForMenuManager = record
 end;//TvcmToolbarDefForMenuManager
 
 TvcmButtonPopupMenu = class(TvcmPopupMenuPrim)
 end;//TvcmButtonPopupMenu
 
 // TvcmToolbarDefsForMenuManager
 
 TvcmMenuOptions = set of TvcmMenuOption;
 
 TvcmComboBoxActionLink = class(TvcmWinControlActionLink)
 end;//TvcmComboBoxActionLink
 
 TvcmComboBox = class(TvcmFakeBox)
  procedure SetCaptionFromAction(anAction: TvcmOperationAction;
   anUpdateIndex: Boolean);
  function SetStringsFromAction(const anAction: IvcmAction): Boolean;
  procedure CMTBMouseQuery(var Msg: TMessage);
  procedure CMTBCheckControl(var Msg: TMessage);
 end;//TvcmComboBox
 
 TvcmToolbarOptions = set of TvcmToolbarOption;
 
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
 
 TvcmToolbarGlyphService = class(Tl3ProtoObject)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
  function GetGlyphSize: TvcmGlyphSize;
  procedure SetGlyphColorDepth(aValue: TvcmGlyphColordepth);
  function GetGlyphColorDepth: TvcmGlyphColordepth;
  procedure SetGlyphSize(aValue: TvcmGlyphSize);
 end;//TvcmToolbarGlyphService
 
 TvcmCustomMenuManager = class(TvcmBaseMenuManager)
  procedure OverridePopupMenu(aForm: TCustomForm);
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
  function BuildToolbar(aForm: TvcmEntityForm;
   const aDef: IvcmOperationalIdentifiedUserFriendlyControl;
   anIndex: Integer): TvcmToolbarDef; overload;
   {* anIndex - порядковый номер Toolbar'а (для огранизации нескольких Toolbar'ов в одном доке) }
  procedure FillToolbar(aForm: TvcmEntityForm;
   var aToolBar: TvcmToolbarDef;
   const aHolder: IvcmOperationalIdentifiedUserFriendlyControl;
   const anOperations: IvcmOperationsDefIterator;
   anOptions: TvcmOperationOptions);
  procedure CheckToolbar(var aToolBar: TvcmToolbarDef);
  function MakeToolbar(aForm: TvcmEntityForm;
   const aHolder: IvcmOperationalIdentifiedUserFriendlyControl;
   anOptions: TvcmOperationOptions;
   anExcludePoses: TvcmEffectiveToolBarPoses): Boolean;
  procedure BuildEntitiesToolbars(aForm: TvcmEntityForm;
   const anEntities: IvcmEntitiesDefIterator;
   anOptions: TvcmOperationOptions;
   anExcludePoses: TvcmEffectiveToolBarPoses);
  function LoadButtonsFromSettings(const aUserType: IvcmUserTypeDef;
   const aToolbar: AnsiString;
   AddUnsavedButton: Boolean;
   var theButton: TvcmButtonDef;
   var theButtons: TvcmButtonDefs): Boolean;
  procedure MakeToolbarFromSettings(aForm: TvcmEntityForm;
   const aToolbarName: AnsiString;
   aPos: TvcmEffectiveToolBarPos;
   anOptions: TvcmOperationOptions;
   const theButtons: TvcmButtonDefs);
  procedure MakeMainToolbarFromSettings(aForm: TvcmEntityForm);
  procedure BuildFormToolbars(aForm: TvcmEntityForm;
   anOptions: TvcmOperationOptions);
  procedure BuildMainToolbars(aForm: TvcmEntityForm;
   const aModuleDef: IvcmModuleDef);
   {* создает Toolbar'ы основной формы }
  procedure CheckUserTypes;
  procedure BuildUserTypes(const aModuleDef: IvcmModuleDef);
  procedure ToolbarsGetSiteInfo(Sender: TObject;
   DockClient: TCustomToolWindow97;
   var CanDock: Boolean);
  function BuildButton(aForm: TvcmEntityForm;
   aToolBar: TvcmToolbarDef;
   const aModuleDef: IvcmModuleDef;
   const anEntityDef: IvcmEntityDef;
   const anOp: IvcmOperationDef;
   anOptions: TvcmOperationOptions;
   anIconText: TvcmIconTextType): TControl; overload;
  function BuildButton(aForm: TvcmEntityForm;
   aToolBar: TvcmToolbarDef;
   const aModuleDef: IvcmModuleDef;
   const anEntityDef: IvcmEntityDef;
   const anOp: IvcmOperationDef;
   anOpOptions: TvcmOperationOptions;
   anOptions: TvcmOperationOptions;
   anIconText: TvcmIconTextType): TControl; overload;
  function BuildButton(aForm: TvcmEntityForm;
   aToolBar: TvcmToolbarDef;
   const aHolder: IvcmOperationalIdentifiedUserFriendlyControl;
   const anOp: IvcmOperationDef;
   anOpOptions: TvcmOperationOptions;
   anOptions: TvcmOperationOptions;
   anIconText: TvcmIconTextType): TControl; overload;
  function BuildButton(aForm: TvcmEntityForm;
   aToolBar: TvcmToolbarDef;
   const aHolder: IvcmOperationalIdentifiedUserFriendlyControl;
   const anOp: IvcmOperationDef;
   anOptions: TvcmOperationOptions;
   anIconText: TvcmIconTextType): TControl; overload;
  function BuildAction(const aModuleDef: IvcmModuleDef;
   const anOpDef: IvcmOperationDef): TCustomAction; overload;
  function BuildAction(anOwner: TComponent;
   const anEntity: IvcmEntity;
   const anEntityDef: IvcmEntityDef;
   const anOpDef: IvcmOperationDef;
   anOptions: TvcmOperationOptions): TCustomAction; overload;
  function BuildSeparator(aToolBar: TvcmToolbarDef): TControl;
  function UserTypeByCaption(const aCaption: AnsiString;
   aFormClass: TClass): IvcmUserTypeDef;
  function GetOneToolbarPerFormName(aForm: TvcmEntityForm;
   aPos: TvcmEffectiveToolBarPos;
   anIndex: Integer): AnsiString;
  function BuildToolbar(aForm: TvcmEntityForm;
   const aName: AnsiString;
   const aCaption: IvcmCString;
   aPos: TvcmEffectiveToolBarPos): TvcmToolbarDef; overload;
  function BuildToolbar(aForm: TvcmEntityForm;
   aPos: TvcmEffectiveToolBarPos): TvcmToolbarDef; overload;
  procedure CleanupSaveDockList(anItem: TvcmDockDef);
  function GetDockParent(aForm: TCustomForm): TWinControl;
  procedure LoadGlyphSize(aDefault: Boolean);
  procedure LoadGlyphColorDepth(aDefault: Boolean);
  procedure UnlockDocks;
  procedure LockDocks;
  procedure StoreGlyphSize;
  procedure RestoreGlyphSize;
  procedure StoreGlyphColordepth;
  procedure RestoreGlyphColordepth;
  procedure InitToolbarMetrics(aForm: TCustomForm);
   {* определить метрики панели инструментов. Компоненты, которые могут быть помещены в панель, могут иметь разные размеры, чтобы высота панелей была одинаковой, считаем максимальную высоту и используем её для всех панелей. }
 end;//TvcmCustomMenuManager
 
 TvcmEditActionLink = class(TvcmWinControlActionLink)
 end;//TvcmEditActionLink
 
 TvcmEdit = class(TvcmFakeBox)
 end;//TvcmEdit
 
 TvcmDateEditActionLink = class(TvcmWinControlActionLink)
 end;//TvcmDateEditActionLink
 
 TvcmDateEdit = class(TvtDblClickDateEdit)
  procedure CMTextChanged(var Message: TMessage);
 end;//TvcmDateEdit
 
 TvcmMenuManagerHelper = class(Tl3ProtoObject, Il3MenuManagerHelper)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
  function CreateManager: Boolean;
  procedure FreeManager;
 end;//TvcmMenuManagerHelper
 
 TvcmDispatcherHelper = class(Tl3ProtoObject, Il3DispatcherHelper)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
  procedure ClearHistory;
 end;//TvcmDispatcherHelper
 
 TvcmToolbarDefList = class(Tl3ProtoDataContainer)
 end;//TvcmToolbarDefList
 
 TvcmMenuManager = class(TvcmCustomMenuManager)
 end;//TvcmMenuManager
 
implementation

uses
 l3ImplUses
 , vcmEntitiesDefIteratorForContextMenu
 , vcmMenuManagerUtils
 , vcmMessages
 , l3InternalInterfaces
 , l3ScreenIC
 , TypInfo
 , SysUtils
 , StdCtrls
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
 , TtfwClassRef_Proxy
 , VCMApllicationSettingsPack
 , RTLConsts
;

type
 TvcmGlyphSizeMap = array [TvcmGlyphSize] of Cardinal;
 
 TvcmTBPosStringArray = array [TvcmEffectiveToolBarPos] of AnsiString;
 
 THackWinControl = class(TWinControl)
 end;//THackWinControl
 
 THackControl = class(TControl)
 end;//THackControl
 
 THackPopupMenu = class(TMenu)
 end;//THackPopupMenu
 
end.
