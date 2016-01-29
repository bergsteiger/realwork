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
  {* ����������� ������� ���������� � ������ nsAutoHide }
  hdNone
  , hdHide
  , hdShow
 );//TnpHideDirect
 
 TnpChangeLink = class(TnpObject)
  {* ������������ ��� ����������� �� ��������� ��������� ���������� (nsAutoHide, nsNormal, nsMinimized) }
 end;//TnpChangeLink
 
 TOnSaveSizeNavigator = procedure(Sender: TObject;
  aSize: Integer) of object;
  {* ��������� ��� ����������� ����������, ����� ������ ��� ��������� ������� ���������� }
 
 TOnLoadSizeNavigator = procedure(Sender: TObject;
  var aSize: Integer) of object;
 
 TnpFloatWindowState = (
  fwsNormal
  , fwsMinimized
 );//TnpFloatWindowState
 
 TvtNavigatorPrim = class;
 
 TnpPageControl = class(TElCustomPageControl)
  {* pagecontrol ������������ � ���������� }
  function IsHandledShortcut(var Msg: TWMKeyDown): Boolean;
  procedure CMDockNotification(var Message: TCMDockNotification);
   {* ��� ��������� ��������� ������� ����������������� ���������� ���������� ��������� }
  procedure PMIsActiveControl(var Message: TMessage);
   {* ���������� ������� �� ���������. ���� ��������� ��������� � ��������� ���������, �� ��������� � ����� ������ �� ������� }
  procedure PMSetActivePageWithControl(var Message: TMessage);
   {* ��� ��������� ��������, ���� ��������� ��� �������, �� �� ��������������� }
  procedure WMKeyDown(var Msg: TWMKeyDown);
  procedure WMSysKeyDown(var Msg: TWMSysKeyDown);
  procedure WMEraseBkgnd(var Message: TMessage);
 end;//TnpPageControl
 
 RnpPageControl = class of TnpPageControl;
 
 TnpButtonType = (
  {* ��� ������ }
  nbtAutoHide
  , nbtMinimize
  , nbtClose
 );//TnpButtonType
 
 TnpButton = class(TCustomToolbarButton97)
  {* ������ �������������� � TvtNavigator }
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
   {* ���������������� ������ }
  function RelativeAlign: TAlign;
   {* ������������ ���������� - ������ }
  function FindRelative(aAlign: TAlign): TvtNavigatorPrim;
   {* ����� ��������� �� ��� �� ����� � ��������� �������������. ������ ���������, ��� �� ����� ����� ���� ������ ���� ��������� � ��������� ����� ������������ }
  function CalcBounds(aSizeNormal: Integer): TRect;
   {* ��������� ����� ������� � ��������� ���������� �������� }
  function CalcSize(const aBounds: TRect): Integer;
   {* ��������� ������ }
  function CorrectBounds(const aBounds: TRect): TRect;
   {* ������������ ����� ������� ����������. ���������� ��� �������������� ���������� � ��� ���������� }
  procedure UpdateSize;
  procedure AutoUpdateSize;
  procedure ResetDragInfo;
   {* ���������� ����� ������������ ��� �������������� }
  function IsUndockByUser: Boolean;
   {* True, ���� �������� ����������� ������������� }
  procedure OnDblClickUndock(var CanUnDock: Boolean;
   aControl: TControl);
   {* �� ��������� ������������� ��������, �������������� � �� ����� }
  procedure CreateSurface;
  procedure CreateHeader;
  procedure CreatePageControl;
  procedure InitMainForm(aOwner: TComponent);
  procedure RecalcSize;
  procedure SetSize(aValue: Integer;
   aControl: TControl);
   {* ������������� ������ ���������� � ����������� �� Align }
  procedure UpdateState;
   {* ��������� ��������� State }
  procedure PlaceSurface;
  procedure AttachSurface;
  procedure DetachSurface;
  procedure SetSizeMini;
  procedure DoAutoHide;
   {* �������������� ���������� ��� ��������� ������ ����������� }
  function CalcNewFloatBounds: TRect;
  procedure SetDockRect(DragDockObject: TDragDockObject);
  procedure InitDrag(aControl: TControl);
  function CheckControl(aControl: TControl): Boolean;
  function DoLoadSize: Integer;
  function FindFloatNavigator: TnpFloatingWindow;
   {* ���������� ��������� ���������, ���� �� �� ������, �� nil }
  procedure UpdateCloseButton;
  function GetNewBoundsFromPoint(X: Integer;
   Y: Integer): TRect;
  procedure AddNavigator(P: TnpFloatingWindow);
  procedure AutoHideUpdate;
  procedure CloseDelay;
  procedure DelNavigator(P: TnpFloatingWindow);
  function DockToFloatNavigator(aControl: TControl): TnpFloatingWindow;
   {* ���� ������ ���������� �� ����������� �� � ������ ����������, �� �� ������������� ���������������� � ���������� ���������� }
  procedure Minimized;
  procedure DoSaveSize;
  procedure DrawSplit(const aRect: TRect);
  procedure InitDockDrop;
  procedure ModeAutoUpdate;
  procedure ModeHide;
  procedure ModeNormalUpdate;
  procedure ModeStateUpdate;
   {* �������� (���� ������ �� ������������) / ���������� PageControl }
  procedure ModeStateUpdateAfter;
   {* �������� ��������� CM_npAfterUndock }
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
   {* ��������� ������� �� ����������� �� ��������� ��������� ���������� }
  procedure UnRegisterStateChanged(aLink: TnpChangeLink);
   {* �������� ������� �� ����������� �� ��������� ��������� ���������� }
  function IsActiveControl(aControl: TControl): Boolean;
  function MinBtnHint: AnsiString;
  procedure AssignNav(aDest: TvtNavigatorPrim);
  procedure hCBT(Code: Integer;
   WParam: WPARAM;
   LParam: LPARAM);
   {* ��������� ���������� �� WH_CBT }
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
   {* "������� ������������, ��� �������� AutoHideOffHint �����������" }
  function AutoHideOnHintStored: Boolean;
   {* "������� ������������, ��� �������� AutoHideOnHint �����������" }
  function MinimizedOnHintStored: Boolean;
   {* "������� ������������, ��� �������� MinimizedOnHint �����������" }
  function MinimizedOffHintStored: Boolean;
   {* "������� ������������, ��� �������� MinimizedOffHint �����������" }
  function CloseHintStored: Boolean;
   {* "������� ������������, ��� �������� CloseHint �����������" }
  function SaveState(out theState: IUnknown;
   aStateType: TvcmStateType): Boolean;
  function LoadState(const theState: IUnknown;
   aStateType: TvcmStateType): Boolean;
  procedure PageInactive;
   {* �������� �������� ����� �� ��������. }
  procedure PageActive;
   {* �������� ����� ��������. }
  function Weight: Integer;
   {* ��� ����������, ����������� ��� ���������� ��������. }
  procedure SmallToolbarSize(aValue: Integer);
  procedure Publish(const aCloseHandler: IvcmFormHandler);
  procedure TabBecomeActive;
  procedure TabBecomeInactive;
 end;//TvtNavigatorPrim
 
 TnpHeaderPrim = class(TnpCustomControl)
  {* ������ �������������� � ����������. �������� ������ ���������(���������� �����������) � ������� ������ �� �������� �������. ������� OnMouseDown �������������� ��������������� ��������� ����������. }
  procedure HideCloseButton;
  procedure ShowCloseButton(const aHandler: IvcmFormHandler);
  procedure CloseButtonVisible(aValue: Boolean);
   {* �������� ��������� ������ �������, ���������� ������ ������� ��� �������������� ����������� OnClick ������ }
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
  {* ��������. �� �������� ����� TnpHeader (��������� ) � PageControl }
  procedure InitAutoHidePosition;
   {* �������� Left ���� }
  procedure OnStateChanged(Sender: TObject);
  procedure SetSizeMini;
  procedure DefineSplitterAlign;
  procedure WMEraseBkgnd(var Message: TMessage);
 end;//TnpSurface
 
 TnpContainerSurface = class(TnpCustomControl)
  function Make(aSurface: TnpSurface): TnpContainerSurface;
  procedure WMEraseBkgnd(var Message: TWMEraseBkgnd);
   {* ����� ������� toolbar-�� �� ��������������� }
 end;//TnpContainerSurface
 
 TnpSplitter = class(TnpCustomControl)
  {* �������� ������������ � ���������� }
  procedure splShowHint(X: Integer;
   Y: Integer);
  procedure splHideHint;
  function CreateButtonHint: THintWindow;
  procedure UpdateCursor(aButton: Boolean);
  procedure DrawButton(aCanvas: TCanvas);
  function GetButtonRect: TRect;
   {* ���������� ������������� ��� ������ }
  procedure SetSizeCursor;
   {* ������������� ������ ��� ��������� �������� }
  function IsHandledShortcut(var Msg: TWMKeyDown): Boolean;
  procedure WMKeyDown(var Msg: TWMKeyDown);
  procedure WMSysKeyDown(var Msg: TWMSysKeyDown);
  procedure CNKeyDown(var Msg: TWMKeyDown);
  procedure CNSysKeyDown(var Msg: TWMSysKeyDown);
  procedure WMMouseLeave(var Msg: TMessage);
 end;//TnpSplitter
 
 TnpFloatingWindow = class(Tl3Form, IafwFloatingWindow)
  {* ��������� ����� ���������� ��������� ���������. ����� ��������� ���� NewTarget �������������� ���������� = nil. ����� ����� ���������� �� TnpHeader. ��� ���� ���������� ����� IsDragBegining ������� ���������� �������� ������� f_PageControl.ActivePage.Controls[0], ���� ��������� �� ��� �����������, �� ����� ������������ � ����� ��� ���� �������� �����. }
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
  {* - ��������� ���������(�����������) ��������;
- ��������� ������� �����������; ������������ ���������;
- �������� ������ ����������; }
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
  {* ��������, ������� ���� ��������� � ����������� �� �����, ������� ������ �� �������� }
  acRedraw
   {* ��������� ����� ������������. ������������ ����� ���������� � ����������� splitter-� ����������, ����� �� ����������� � Align = alNone, ���������� ������ �� ���������, �.�. �� ����� �� ������������� (cq: 00015856). }
  , acUpInZOrder
   {* ������� �� ���, ����� ����� ����������� ����������, �� ��������� ������� � ���� ����� ��������� }
 );//TnpDoActionWithFormControl
 
end.
