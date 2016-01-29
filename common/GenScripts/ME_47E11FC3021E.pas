unit Controls;

interface

uses
 l3IntfUses
 , Classes
 , ActnList
 , Messages
 , Types
 , Windows
;

type
 TAlign = (
  alNone
  , alTop
  , alBottom
  , alLeft
  , alRight
  , alClient
  , alCustom
 );//TAlign
 
 _TControlStyle = (
 );//_TControlStyle
 
 _TControlState = (
 );//_TControlState
 
 TControlState = set of _TControlState;
 
 TControlStyle = set of _TControlStyle;
 
 TWndMethod = Classes.TWndMethod;
 
 TControlActionLink = class(TActionLink)
 end;//TControlActionLink
 
 TCreateParams = record
  {* TCreateParams is the window-creation parameter record used to specify the type of window to create for a windowed control }
 end;//TCreateParams
 
 TDragMode = (
 );//TDragMode
 
 TAnchorKind = (
  akLeft
  , akTop
  , akRight
  , akBottom
 );//TAnchorKind
 
 TAnchors = set of TAnchorKind;
 
 TAlignSet = set of TAlign;
 
 TMouseButton = (
 );//TMouseButton
 
 TModalResult = ShortInt;
 
 TControlActionLinkClass = class of ;
 
 TDragImageList = class
 end;//TDragImageList
 
 TDragDockObject = class
 end;//TDragDockObject
 
 TBevelCut = (
  {* TPanelBevel specifies a bevel’s cut }
  bvNone
  , bvLowered
  , bvRaised
  , bvSpace
 );//TBevelCut
 
 TCMCancelMode = record
 end;//TCMCancelMode
 
 // TControl
 
 // TWinControl
 
 IDockManager = interface
 end;//IDockManager
 
 TDate = type TDateTime;
 
 TCMEnter = record
 end;//TCMEnter
 
 TCMExit = record
 end;//TCMExit
 
 TDragState = (
 );//TDragState
 
 TCursor = (
 );//TCursor
 
 TWinControl = class;
 
 TControl = class(TComponent)
  {* TControl is the base class for all components that are visible at runtime. }
  procedure MouseUp(Button: TMouseButton;
   Shift: TShiftState;
   X: Integer;
   Y: Integer);
  procedure SetParent(AParent: TWinControl); overload;
  function GetActionLinkClass: TControlActionLinkClass;
  procedure Click;
  procedure DblClick;
  procedure MouseDown(Button: TMouseButton;
   Shift: TShiftState;
   X: Integer;
   Y: Integer);
  procedure SetBounds(ALeft: Integer;
   ATop: Integer;
   AWidth: Integer;
   AHeight: Integer);
  procedure InitiateAction;
  procedure RequestAlign;
  procedure MouseWheelHandler(var Message: TMessage);
  procedure ActionChange(Sender: TObject;
   CheckDefaults: Boolean);
  procedure PositionDockRect(DragDockObject: TDragDockObject);
  function HintChanged(const aHint: AnsiString): Boolean;
  procedure SetZOrder(TopMost: Boolean);
  procedure WndProc(var Message: TMessage);
  procedure Invalidate;
   {* Completely repaint control }
  procedure DoContextPopup(MousePos: TPoint;
   var Handled: Boolean);
   {* OnContextPopup event dispatcher }
  procedure MouseMove(Shift: TShiftState;
   X: Integer;
   Y: Integer);
  procedure SetParent(AParent: TWinControl); overload;
  procedure Resize;
  procedure VisibleChanging;
 end;//TControl
 
 TWinControl = class(TControl)
  {* TWinControl is the base class for all controls that are wrappers for Microsoft Windows screen objects. }
  procedure SelectNext(CurControl: TWinControl;
   GoForward: Boolean;
   CheckTabStop: Boolean);
  function CanFocus: Boolean;
  procedure ForceWMSize(aWidth: Integer;
   aHeight: Integer);
  procedure DockDrop(Source: TDragDockObject;
   X: Integer;
   Y: Integer);
  procedure AlignControls(AControl: TControl;
   var Rect: TRect);
  procedure AdjustClientRect(var Rect: TRect);
  procedure SetParentBackground(Value: Boolean);
  procedure DockOver(Source: TDragDockObject;
   X: Integer;
   Y: Integer;
   State: TDragState;
   var Accept: Boolean);
  procedure GetSiteInfo(Client: TControl;
   var InfluenceRect: TRect;
   MousePos: TPoint;
   var CanDock: Boolean);
  procedure DoEnter;
  procedure KeyDown(var Key: Word;
   Shift: TShiftState);
  procedure KeyPress(var Key: Char);
  procedure CreateWindowHandle(const Params: TCreateParams);
   {* Creates a Windows control to represent the control }
  procedure DestroyWindowHandle;
   {* Destroys the window created in the CreateWindowHandle method }
  procedure PaintWindow(DC: hDC);
   {* Renders the image of a windowed control }
  procedure CreateParams(var Params: TCreateParams);
  function LockPainting: Boolean;
  procedure CreateWnd;
  procedure DestroyWnd;
 end;//TWinControl
 
 TCustomControl = class(TWinControl)
  {* Base class for controls that wrap Windows screen objects but perform their own rendering. }
  procedure Paint;
 end;//TCustomControl
 
 TCMDialogKey = TWMKey;
 
 TImageList = class
 end;//TImageList
 
 THintWindow = class(TCustomControl)
  procedure ActivateHint(Rect: TRect;
   const AHint: String);
  function IsHintMsg(var Msg: TMsg): Boolean;
 end;//THintWindow
 
 // TBevelWidth
 
 // TBorderWidth
 
 TGraphicControl = class(TControl)
  procedure Paint;
 end;//TGraphicControl
 
 TMouseEvent = procedure(Sender: TObject;
  Button: TMouseButton;
  Shift: TShiftState;
  X: Integer;
  Y: Integer) of object;
 
 TKeyEvent = procedure(Sender: TObject;
  var Key: Word;
  Shift: TShiftState) of object;
 
 TWinControlActionLink = class(TControlActionLink)
 end;//TWinControlActionLink
 
 TCMDockNotification = record
 end;//TCMDockNotification
 
 TControlClass = class of TControl;
 
 TBevelKind = (
 );//TBevelKind
 
implementation

uses
 l3ImplUses
 , TtfwClassRef_Proxy
 , WinControlsProcessingPack
 , ControlsProcessingPack
 , ScrollingWinControlWordsPack
 , ScrollInfoProcessingPack
;

end.
