unit vtNavigator;

interface

uses
 l3IntfUses
 , ElPgCtlConsts
 , l3StringIDEx
 , l3ProtoObject
 , afwCustomCommonControl
 , vtCustomCommonPanel
 , vcmExternalInterfaces
 , Classes
 , ElPgCtl
 , Controls
 , Messages
 , Types
 , tb97Ctls
 , Forms
 , afwInterfaces
 , l3TabbedContainersDispatcher
 , ImgList
 , l3ObjectList
 , Windows
 , ExtCtrls
 , l3WinControlCanvas
 , Graphics
 , l3Forms
;

type
 TnpObject = class(Tl3ProtoObject)
 end;//TnpObject
 
 TNavigatorState = (
  nsNormal
  , nsMinimized
  , nsAutoHide
 );//TNavigatorState
 
 TnpDrawSplitterType = (
  dstErase
  , dstPaint
 );//TnpDrawSplitterType
 
 TnpDrawSplitterTypes = set of TnpDrawSplitterType;
 
 TnpCustomControl = class(TafwCustomCommonControl)
 end;//TnpCustomControl
 
 TnpCustomPanel = class(TvtCustomCommonPanel, IvcmDockType)
  function ControlIsPanel: Boolean;
 end;//TnpCustomPanel
 
 TnpHideDirect = (
  {* направление скрытия навигатора в режиме nsAutoHide }
  hdNone
  , hdHide
  , hdShow
 );//TnpHideDirect
 
 TnpChangeLink = class(TnpObject)
  {* используется для уведомления об изменении состояния навигатора (nsAutoHide, nsNormal, nsMinimized) }
 end;//TnpChangeLink
 
 TOnSaveSizeNavigator = procedure(Sender: TObject;
  aSize: Integer) of object;
  {* возникает при уничтожении навигатора, чтобы клиент мог сохранить размеры навигатора }
 
 TOnLoadSizeNavigator = procedure(Sender: TObject;
  var aSize: Integer) of object;
 
 TnpFloatWindowState = (
  fwsNormal
  , fwsMinimized
 );//TnpFloatWindowState
 
 TvtNavigatorPrim = class;
 
 TnpPageControl = class(TElCustomPageControl)
  {* pagecontrol используемый в навигаторе }
  function IsHandledShortcut(var Msg: TWMKeyDown): Boolean;
  procedure CMDockNotification(var Message: TCMDockNotification);
   {* при изменении видимости первого пристыковыванного компонента показываем навигатор }
  procedure PMIsActiveControl(var Message: TMessage);
   {* определяет активен ли компонент. Если навигатор находится в свернутом состоянии, то компонент в любом случае не активен }
  procedure PMSetActivePageWithControl(var Message: TMessage);
   {* при активации закладки, если навигатор был свернут, то он разворачивается }
  procedure WMKeyDown(var Msg: TWMKeyDown);
  procedure WMSysKeyDown(var Msg: TWMSysKeyDown);
  procedure WMEraseBkgnd(var Message: TMessage);
 end;//TnpPageControl
 
 RnpPageControl = class of TnpPageControl;
 
 TnpButtonType = (
  {* Тип кнопки }
  nbtAutoHide
  , nbtMinimize
  , nbtClose
 );//TnpButtonType
 
 TnpButton = class(TCustomToolbarButton97)
  {* кнопки использующиеся в TvtNavigator }
  procedure Create(aOwner: TComponent;
   aNavigator: TvtNavigatorPrim;
   aBtnType: TnpButtonType);
  function MakeHint: AnsiString;
  procedure CMHintShow(var Message: TCMHintShow);
  procedure WMMouseMove(var Message: TWMMouseMove);
 end;//TnpButton
 
 TnpSurface = class;
 
 TnpHeaderPrim = class;
 
 TnpFloatingWindow = class;
 
 TvtNavigatorPrim = class(TnpCustomPanel, IvcmState, IvcmToolbarNotifier, IafwTabSheetControl, IvcmFormHandlersPublisher, Il3SelectedTabDependent)
  function CorrectSize(aSizeNormal: Integer): Integer;
   {* откорректировать размер }
  function RelativeAlign: TAlign;
   {* выравнивание навигатора - соседа }
  function FindRelative(aAlign: TAlign): TvtNavigatorPrim;
   {* найти навигатор на той же форме с указанным выравниванием. Делаем допущение, что на форме может быть только один навигатор с указанным типом выравнивания }
  function CalcBounds(aSizeNormal: Integer): TRect;
   {* вычислить новые границы с указанным нормальным размером }
  function CalcSize(const aBounds: TRect): Integer;
   {* вычисляет размер }
  function CorrectBounds(const aBounds: TRect): TRect;
   {* корректирует новые размеры навигатора. Необходимо при перетаскивании навигатора и при сплиттинге }
  procedure UpdateSize;
  procedure AutoUpdateSize;
  procedure ResetDragInfo;
   {* сбрасывает флаги используемые при перетаскивании }
  function IsUndockByUser: Boolean;
   {* True, если закладки отстыкованы пользователем }
  procedure OnDblClickUndock(var CanUnDock: Boolean;
   aControl: TControl);
   {* не разрешаем отстыковывать закладку, пристыковываем её на форму }
  procedure CreateSurface;
  procedure CreateHeader;
  procedure CreatePageControl;
  procedure InitMainForm(aOwner: TComponent);
  procedure RecalcSize;
  procedure SetSize(aValue: Integer;
   aControl: TControl);
   {* устанавливает размер навигатора в зависимости от Align }
  procedure UpdateState;
   {* действует используя State }
  procedure PlaceSurface;
  procedure AttachSurface;
  procedure DetachSurface;
  procedure SetSizeMini;
  procedure DoAutoHide;
   {* подготавливает компоненты при включении режима автоскрытия }
  function CalcNewFloatBounds: TRect;
  procedure SetDockRect(DragDockObject: TDragDockObject);
  procedure InitDrag(aControl: TControl);
  function CheckControl(aControl: TControl): Boolean;
  function DoLoadSize: Integer;
  function FindFloatNavigator: TnpFloatingWindow;
   {* возвращает плавающий навигатор, если он не создан, то nil }
  procedure UpdateCloseButton;
  function GetNewBoundsFromPoint(X: Integer;
   Y: Integer): TRect;
  procedure AddNavigator(P: TnpFloatingWindow);
  procedure AutoHideUpdate;
  procedure CloseDelay;
  procedure DelNavigator(P: TnpFloatingWindow);
  function DockToFloatNavigator(aControl: TControl): TnpFloatingWindow;
   {* если клиент компонента не пристыкован ни к одному навигатору, то он автоматически пристыковывается к плавающему навигатору }
  procedure Minimized;
  procedure DoSaveSize;
  procedure DrawSplit(const aRect: TRect);
  procedure InitDockDrop;
  procedure ModeAutoUpdate;
  procedure ModeHide;
  procedure ModeNormalUpdate;
  procedure ModeStateUpdate;
   {* скрывает (если ничего не пристыковано) / показывает PageControl }
  procedure ModeStateUpdateAfter;
   {* посылает сообщение CM_npAfterUndock }
  procedure MovePagesToNavigator(var Value: TvtNavigatorPrim;
   DockControl: TControl);
  procedure OpenDelay;
  procedure PaintSpliter(X: Integer;
   Y: Integer;
   aDrawSplitterType: TnpDrawSplitterTypes);
  procedure OnEndDockControl(Sender: TObject;
   Target: TObject;
   X: Integer;
   Y: Integer);
  procedure OnTabSheetClick(Sender: TObject;
   Page: TElTabSheet);
  procedure OnHide(Sender: TObject);
  procedure OnAutoHide(Sender: TObject);
  procedure OnPageControlResize(Sender: TObject);
  procedure OnPageControlChange(Sender: TObject);
  procedure OnTimerFloat(Sender: TObject);
  procedure OnTimerDelay(Sender: TObject);
  procedure OnPageControlUnDock(Sender: TObject;
   Client: TControl;
   NewTarget: TWinControl;
   var Allow: Boolean);
  procedure OnStartDragControl(Sender: TObject;
   aDragControl: TControl);
  procedure OnFormPositionDockRect(Sender: TObject;
   DragDockObject: TDragDockObject);
  procedure SetSelfSize(aSize: Integer);
  procedure DoSplit;
  procedure SetUndockSize;
  function GetNavigatorSizeNormal(aControl: TControl): Integer;
  function GetDockRect(aDockSize: Integer): TRect;
  procedure DoStateChanged(aNavigatorState: Boolean);
  function GetPageControlClass: RnpPageControl;
  function GetFloatingWindowClass: RnpFloatingWindow;
  procedure RegisterStateChanged(aLink: TnpChangeLink);
   {* подписать клиента на нотификацию об изменении состояния навигатора }
  procedure UnRegisterStateChanged(aLink: TnpChangeLink);
   {* отписать клиента от нотификации об изменении состояния навигатора }
  function IsActiveControl(aControl: TControl): Boolean;
  function MinBtnHint: AnsiString;
  procedure AssignNav(aDest: TvtNavigatorPrim);
  procedure hCBT(Code: Integer;
   WParam: WPARAM;
   LParam: LPARAM);
   {* сообщение получаемое от WH_CBT }
  procedure hGetMessage(aMessage: PMsg);
  procedure NormalUpdateSize;
  procedure ModeShow;
  procedure UpdateMainForm(aNewMainForm: TCustomForm);
  procedure DoActivate(aActive: Boolean);
  procedure CMnpChangeActivate(var Message: TMessage);
  procedure CMAfterUndock(var Message: TMessage);
  procedure CMDelNavFromList(var Message: TMessage);
  procedure CMNPDoActionWithFormControls(var Message: TMessage);
  procedure CMnpDockToFloatWindow(var Message: TMessage);
  procedure WMEraseBkgnd(var Message: TWMEraseBkgnd);
  function AutoHideOffHintStored: Boolean;
   {* "Функция определяющая, что свойство AutoHideOffHint сохраняется" }
  function AutoHideOnHintStored: Boolean;
   {* "Функция определяющая, что свойство AutoHideOnHint сохраняется" }
  function MinimizedOnHintStored: Boolean;
   {* "Функция определяющая, что свойство MinimizedOnHint сохраняется" }
  function MinimizedOffHintStored: Boolean;
   {* "Функция определяющая, что свойство MinimizedOffHint сохраняется" }
  function CloseHintStored: Boolean;
   {* "Функция определяющая, что свойство CloseHint сохраняется" }
  function SaveState(out theState: IUnknown;
   aStateType: TvcmStateType): Boolean;
  function LoadState(const theState: IUnknown;
   aStateType: TvcmStateType): Boolean;
  procedure PageInactive;
   {* активная закладка стала не активной. }
  procedure PageActive;
   {* закладка стала активной. }
  function Weight: Integer;
   {* вес компонента, учитывается при размещении закладок. }
  procedure SmallToolbarSize(aValue: Integer);
  procedure Publish(const aCloseHandler: IvcmFormHandler);
  procedure TabBecomeActive;
  procedure TabBecomeInactive;
 end;//TvtNavigatorPrim
 
 TnpHeaderPrim = class(TnpCustomControl)
  {* панель отображающаяся в навигаторе. Содержит кнопки включения(отключения автоскрытия) и скрытия панели до размеров вкладки. Событие OnMouseDown инициализирует перетаскиваение активного компонента. }
  procedure HideCloseButton;
  procedure ShowCloseButton(const aHandler: IvcmFormHandler);
  procedure CloseButtonVisible(aValue: Boolean);
   {* изменить видимость кнопки закрыть, установить кнопку видимой без установленного обработчика OnClick нельзя }
  procedure UpdateImages;
  procedure UpdateSize;
  procedure UpdatePositions;
  procedure UpdateHideImage;
  procedure UpdateCloseImage;
  procedure UpdateAutoHideImage;
  function GetRectLines: TRect;
  procedure DoStateChanged;
  procedure OnStateChanged(Sender: TObject);
  procedure WMEraseBkgnd(var Message: TWMEraseBkgnd);
 end;//TnpHeaderPrim
 
 TnpContainerSurface = class;
 
 TnpSplitter = class;
 
 TnpSurface = class(TnpCustomControl)
  {* Подложка. На подложке лежат TnpHeader (заголовок ) и PageControl }
  procedure InitAutoHidePosition;
   {* обновить Left окна }
  procedure OnStateChanged(Sender: TObject);
  procedure SetSizeMini;
  procedure DefineSplitterAlign;
  procedure WMEraseBkgnd(var Message: TMessage);
 end;//TnpSurface
 
 TnpContainerSurface = class(TnpCustomControl)
  function Make(aSurface: TnpSurface): TnpContainerSurface;
  procedure WMEraseBkgnd(var Message: TWMEraseBkgnd);
   {* иначе границы toolbar-ов не прорисовываются }
 end;//TnpContainerSurface
 
 TnpSplitter = class(TnpCustomControl)
  {* сплиттер используемый в навигаторе }
  procedure splShowHint(X: Integer;
   Y: Integer);
  procedure splHideHint;
  function CreateButtonHint: THintWindow;
  procedure UpdateCursor(aButton: Boolean);
  procedure DrawButton(aCanvas: TCanvas);
  function GetButtonRect: TRect;
   {* определяет прямоугольник для кнопки }
  procedure SetSizeCursor;
   {* устанавливает курсор для изменения размеров }
  function IsHandledShortcut(var Msg: TWMKeyDown): Boolean;
  procedure WMKeyDown(var Msg: TWMKeyDown);
  procedure WMSysKeyDown(var Msg: TWMSysKeyDown);
  procedure CNKeyDown(var Msg: TWMKeyDown);
  procedure CNSysKeyDown(var Msg: TWMSysKeyDown);
  procedure WMMouseLeave(var Msg: TMessage);
 end;//TnpSplitter
 
 TnpFloatingWindow = class(Tl3Form, IafwFloatingWindow)
  {* плавающая форма содержащая плавающий навигатор. Форма создается если NewTarget отстыкованного компонента = nil. Форму можно перемещать за TnpHeader. При этом вызывается метод IsDragBegining первого компонента активной вкладки f_PageControl.ActivePage.Controls[0], если компонент не был пристыкован, то форма перемещается в место где была отпущена рамка. }
  function GetGripperRect: TRect;
  function GetGripperHeight: Integer;
  function CheckGripperCursor: Boolean;
  procedure UpdateFloatWindowsBounds;
  procedure OnChangeState(Sender: TObject);
  procedure OnCloseWindow(Sender: TObject);
  procedure FormOnResize(Sender: TObject);
  procedure FormClose(Sender: TObject;
   var Action: TCloseAction);
  procedure OnTabSheetClick(Sender: TObject;
   Page: TElTabSheet);
  procedure OnDockDrop(Sender: TObject;
   Source: TDragDockObject;
   X: Integer;
   Y: Integer);
  function GetNavigatorClass: RvtNavigator;
  procedure WMNCCalcSize(var Message: TWMNCCalcSize);
  procedure WMNCPaint(var Message: TMessage);
  procedure WMNCHitTest(var Message: TWMNCHitTest);
  procedure WMEraseBkgnd(var Message: TWMEraseBkgnd);
  procedure DisableClose;
  procedure DisableReactivate;
 end;//TnpFloatingWindow
 
 RnpFloatingWindow = class of TnpFloatingWindow;
 
 RvtNavigator = class of TvtNavigatorPrim;
 
 TnpHeader = class(TnpHeaderPrim)
 end;//TnpHeader
 
 TvtNavigator = class(TvtNavigatorPrim)
  {* - управляет стыковкой(отстыковкой) закладок;
- управляет режимом автоскрытия; минимизирует навигатор;
- изменяет размер навигатора; }
 end;//TvtNavigator
 
implementation

uses
 l3ImplUses
 , vtNavigatorFormList
 , vtNavigatorRes
 , npControlsList
 , npNavigatorList
 , vtNavigatorUtils
 , OvcController
 , OvcConst
 , l3Base
 , Math
 , l3MinMax
 , l3String
 , SysUtils
 , l3CustomControlCanvas
 , l3Defaults
 , vtNavigatorFormListPrim
 , vtNavigatorForm
 , vcmForm
 , vcmEntityForm
 , vcmUtils
 , l3PopupControlService
 , l3MessageID
 , TtfwClassRef_Proxy
;

type
 TnpDoActionWithFormControl = (
  {* Действие, которое надо выполнить с компонентом на форме, который никуда не привязан }
  acRedraw
   {* компонент нужно перерисовать. Используется после отпускания и перерисовки splitter-а навигатора, иначе на компонентах с Align = alNone, оставалась полоса от сплиттера, т.к. их никто не перерисовывал (cq: 00015856). }
  , acUpInZOrder
   {* поднять по оси, чтобы после пристыковки навигатора, на заслонить лежащий в этом месте компонент }
 );//TnpDoActionWithFormControl
 
end.
