unit Controls;

// Модуль: "w:\common\components\rtl\external\NotFinished\Borland\Delphi\Vcl\Controls.pas"
// Стереотип: "UtilityPack"

interface

{$If NOT Defined(NoVCL)}
uses
 l3IntfUses
 , Classes
 , ActnList
 , Messages
 , Types
 , Windows
;

const
 {* VCL control message IDs }
 CM_BASE = $B000;
 CM_TEXTCHANGED = CM_BASE + 18;
 mrCancel = idCancel;
 mrNone = 0;

type
 TControlActionLinkClass = class of ;

 TControlClass = class of TControl;

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

 TControl = class(TComponent)
  {* Визуальный контрол. }
 end;//TControl

 TWinControl = class(TControl)
  {* TWinControl is the base class for all controls that are wrappers for Microsoft Windows screen objects. }
 end;//TWinControl

 IDockManager = interface
  ['{EE5DA38F-F9CC-4AEA-A17B-235182923210}']
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
  private
   f_Align: TAlign;
    {* Поле для свойства Align }
  protected
   function Get_Align: TAlign;
   procedure Set_Align(aValue: TAlign);
   procedure MouseUp(Button: TMouseButton;
    Shift: TShiftState;
    X: Integer;
    Y: Integer); virtual;
   procedure SetParent(AParent: TWinControl); overload; virtual;
   function GetActionLinkClass: TControlActionLinkClass; virtual;
   procedure Click; virtual;
   procedure DblClick; virtual;
   procedure MouseDown(Button: TMouseButton;
    Shift: TShiftState;
    X: Integer;
    Y: Integer); virtual;
   procedure SetBounds(ALeft: Integer;
    ATop: Integer;
    AWidth: Integer;
    AHeight: Integer); virtual;
   procedure RequestAlign; virtual;
   procedure ActionChange(Sender: TObject;
    CheckDefaults: Boolean); virtual;
   procedure PositionDockRect(DragDockObject: TDragDockObject); virtual;
   {$If Defined(l3HackedVCL) AND NOT Defined(DesignTimeLibrary)}
   function HintChanged(const aHint: AnsiString): Boolean; virtual;
   {$IfEnd} // Defined(l3HackedVCL) AND NOT Defined(DesignTimeLibrary)
   procedure SetZOrder(TopMost: Boolean); virtual;
   procedure WndProc(var Message: TMessage); virtual;
   procedure DoContextPopup(MousePos: TPoint;
    var Handled: Boolean); virtual;
    {* OnContextPopup event dispatcher }
   procedure MouseMove(Shift: TShiftState;
    X: Integer;
    Y: Integer); virtual;
   procedure SetParent(AParent: TWinControl); overload; virtual;
   procedure Resize; virtual;
   procedure VisibleChanging; virtual;
  public
   procedure InitiateAction; virtual;
   procedure MouseWheelHandler(var Message: TMessage); virtual;
   procedure Invalidate; virtual;
    {* Completely repaint control }
  public
   property Align: TAlign
    read Get_Align
    write Set_Align
    default alNone;
 end;//TControl

 TWinControl = class(TControl)
  {* TWinControl is the base class for all controls that are wrappers for Microsoft Windows screen objects. }
  protected
   {$If Defined(l3HackedVCL) AND NOT Defined(DesignTimeLibrary)}
   procedure SelectNext(CurControl: TWinControl;
    GoForward: Boolean;
    CheckTabStop: Boolean); virtual;
   {$IfEnd} // Defined(l3HackedVCL) AND NOT Defined(DesignTimeLibrary)
   {$If Defined(l3HackedVCL) AND NOT Defined(DesignTimeLibrary)}
   procedure ForceWMSize(aWidth: Integer;
    aHeight: Integer); virtual;
   {$IfEnd} // Defined(l3HackedVCL) AND NOT Defined(DesignTimeLibrary)
   procedure AlignControls(AControl: TControl;
    var Rect: TRect); virtual;
   procedure AdjustClientRect(var Rect: TRect); virtual;
   procedure SetParentBackground(Value: Boolean); virtual;
   procedure DockOver(Source: TDragDockObject;
    X: Integer;
    Y: Integer;
    State: TDragState;
    var Accept: Boolean); virtual;
   procedure GetSiteInfo(Client: TControl;
    var InfluenceRect: TRect;
    MousePos: TPoint;
    var CanDock: Boolean); virtual;
   procedure DoEnter; virtual;
   procedure KeyDown(var Key: Word;
    Shift: TShiftState); virtual;
   procedure KeyPress(var Key: Char); virtual;
   procedure CreateWindowHandle(const Params: TCreateParams); virtual;
    {* Creates a Windows control to represent the control }
   procedure DestroyWindowHandle; virtual;
    {* Destroys the window created in the CreateWindowHandle method }
   procedure PaintWindow(DC: hDC); virtual;
    {* Renders the image of a windowed control }
   procedure CreateParams(var Params: TCreateParams); virtual;
   {$If Defined(l3HackedVCL)}
   function LockPainting: Boolean; virtual;
   {$IfEnd} // Defined(l3HackedVCL)
   procedure CreateWnd; virtual;
   procedure DestroyWnd; virtual;
  public
   function CanFocus: Boolean; virtual;
   procedure DockDrop(Source: TDragDockObject;
    X: Integer;
    Y: Integer); virtual;
 end;//TWinControl

 TCustomControl = class(TWinControl)
  {* Base class for controls that wrap Windows screen objects but perform their own rendering. }
  protected
   procedure Paint; virtual;
 end;//TCustomControl

 TCMDialogKey = TWMKey;

 TImageList = class
 end;//TImageList

 THintWindow = class(TCustomControl)
  public
   procedure ActivateHint(Rect: TRect;
    const AHint: String); virtual;
   function IsHintMsg(var Msg: TMsg): Boolean; virtual;
 end;//THintWindow

 TBevelWidth =  .. ;

 TBorderWidth =  .. ;

 TGraphicControl = class(TControl)
  protected
   procedure Paint; virtual;
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

 TBevelKind = (
 );//TBevelKind

procedure FindControl;
{$IfEnd} // NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoVCL)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , WinControlsProcessingPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , ControlsProcessingPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , ScrollingWinControlWordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , ScrollInfoProcessingPack
 {$IfEnd} // NOT Defined(NoScripts)
;

procedure FindControl;
//#UC START# *4AAF9CFA0263_47E11FC3021E_var*
//#UC END# *4AAF9CFA0263_47E11FC3021E_var*
begin
//#UC START# *4AAF9CFA0263_47E11FC3021E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AAF9CFA0263_47E11FC3021E_impl*
end;//FindControl

function TControl.Get_Align: TAlign;
//#UC START# *4F2FEC7002E4_47E1201703C3get_var*
//#UC END# *4F2FEC7002E4_47E1201703C3get_var*
begin
//#UC START# *4F2FEC7002E4_47E1201703C3get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F2FEC7002E4_47E1201703C3get_impl*
end;//TControl.Get_Align

procedure TControl.Set_Align(aValue: TAlign);
//#UC START# *4F2FEC7002E4_47E1201703C3set_var*
//#UC END# *4F2FEC7002E4_47E1201703C3set_var*
begin
//#UC START# *4F2FEC7002E4_47E1201703C3set_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F2FEC7002E4_47E1201703C3set_impl*
end;//TControl.Set_Align

procedure TControl.MouseUp(Button: TMouseButton;
 Shift: TShiftState;
 X: Integer;
 Y: Integer);
//#UC START# *4E7896270076_47E1201703C3_var*
//#UC END# *4E7896270076_47E1201703C3_var*
begin
//#UC START# *4E7896270076_47E1201703C3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E7896270076_47E1201703C3_impl*
end;//TControl.MouseUp

procedure TControl.SetParent(AParent: TWinControl);
//#UC START# *4F71E1460089_47E1201703C3_var*
//#UC END# *4F71E1460089_47E1201703C3_var*
begin
//#UC START# *4F71E1460089_47E1201703C3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F71E1460089_47E1201703C3_impl*
end;//TControl.SetParent

function TControl.GetActionLinkClass: TControlActionLinkClass;
//#UC START# *4F8845840032_47E1201703C3_var*
//#UC END# *4F8845840032_47E1201703C3_var*
begin
//#UC START# *4F8845840032_47E1201703C3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F8845840032_47E1201703C3_impl*
end;//TControl.GetActionLinkClass

procedure TControl.Click;
//#UC START# *4F88469E0021_47E1201703C3_var*
//#UC END# *4F88469E0021_47E1201703C3_var*
begin
//#UC START# *4F88469E0021_47E1201703C3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F88469E0021_47E1201703C3_impl*
end;//TControl.Click

procedure TControl.DblClick;
//#UC START# *4F8846EE022A_47E1201703C3_var*
//#UC END# *4F8846EE022A_47E1201703C3_var*
begin
//#UC START# *4F8846EE022A_47E1201703C3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F8846EE022A_47E1201703C3_impl*
end;//TControl.DblClick

procedure TControl.MouseDown(Button: TMouseButton;
 Shift: TShiftState;
 X: Integer;
 Y: Integer);
//#UC START# *4F88473B03CD_47E1201703C3_var*
//#UC END# *4F88473B03CD_47E1201703C3_var*
begin
//#UC START# *4F88473B03CD_47E1201703C3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F88473B03CD_47E1201703C3_impl*
end;//TControl.MouseDown

procedure TControl.SetBounds(ALeft: Integer;
 ATop: Integer;
 AWidth: Integer;
 AHeight: Integer);
//#UC START# *4F2A599E0283_47E1201703C3_var*
//#UC END# *4F2A599E0283_47E1201703C3_var*
begin
//#UC START# *4F2A599E0283_47E1201703C3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F2A599E0283_47E1201703C3_impl*
end;//TControl.SetBounds

procedure TControl.InitiateAction;
//#UC START# *4F884F39020F_47E1201703C3_var*
//#UC END# *4F884F39020F_47E1201703C3_var*
begin
//#UC START# *4F884F39020F_47E1201703C3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F884F39020F_47E1201703C3_impl*
end;//TControl.InitiateAction

procedure TControl.RequestAlign;
//#UC START# *5022104B03A6_47E1201703C3_var*
//#UC END# *5022104B03A6_47E1201703C3_var*
begin
//#UC START# *5022104B03A6_47E1201703C3_impl*
 !!! Needs to be implemented !!!
//#UC END# *5022104B03A6_47E1201703C3_impl*
end;//TControl.RequestAlign

procedure TControl.MouseWheelHandler(var Message: TMessage);
//#UC START# *515317860183_47E1201703C3_var*
//#UC END# *515317860183_47E1201703C3_var*
begin
//#UC START# *515317860183_47E1201703C3_impl*
 !!! Needs to be implemented !!!
//#UC END# *515317860183_47E1201703C3_impl*
end;//TControl.MouseWheelHandler

procedure TControl.ActionChange(Sender: TObject;
 CheckDefaults: Boolean);
//#UC START# *52A9A8710199_47E1201703C3_var*
//#UC END# *52A9A8710199_47E1201703C3_var*
begin
//#UC START# *52A9A8710199_47E1201703C3_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A9A8710199_47E1201703C3_impl*
end;//TControl.ActionChange

procedure TControl.PositionDockRect(DragDockObject: TDragDockObject);
//#UC START# *52BC260803B0_47E1201703C3_var*
//#UC END# *52BC260803B0_47E1201703C3_var*
begin
//#UC START# *52BC260803B0_47E1201703C3_impl*
 !!! Needs to be implemented !!!
//#UC END# *52BC260803B0_47E1201703C3_impl*
end;//TControl.PositionDockRect

{$If Defined(l3HackedVCL) AND NOT Defined(DesignTimeLibrary)}
function TControl.HintChanged(const aHint: AnsiString): Boolean;
//#UC START# *53F34DE200C9_47E1201703C3_var*
//#UC END# *53F34DE200C9_47E1201703C3_var*
begin
//#UC START# *53F34DE200C9_47E1201703C3_impl*
 !!! Needs to be implemented !!!
//#UC END# *53F34DE200C9_47E1201703C3_impl*
end;//TControl.HintChanged
{$IfEnd} // Defined(l3HackedVCL) AND NOT Defined(DesignTimeLibrary)

procedure TControl.SetZOrder(TopMost: Boolean);
//#UC START# *550ABB5E00AE_47E1201703C3_var*
//#UC END# *550ABB5E00AE_47E1201703C3_var*
begin
//#UC START# *550ABB5E00AE_47E1201703C3_impl*
 !!! Needs to be implemented !!!
//#UC END# *550ABB5E00AE_47E1201703C3_impl*
end;//TControl.SetZOrder

procedure TControl.WndProc(var Message: TMessage);
//#UC START# *47E136A80191_47E1201703C3_var*
//#UC END# *47E136A80191_47E1201703C3_var*
begin
//#UC START# *47E136A80191_47E1201703C3_impl*
 !!! Needs to be implemented !!!
//#UC END# *47E136A80191_47E1201703C3_impl*
end;//TControl.WndProc

procedure TControl.Invalidate;
 {* Completely repaint control }
//#UC START# *48C6CC4A0395_47E1201703C3_var*
//#UC END# *48C6CC4A0395_47E1201703C3_var*
begin
//#UC START# *48C6CC4A0395_47E1201703C3_impl*
 !!! Needs to be implemented !!!
//#UC END# *48C6CC4A0395_47E1201703C3_impl*
end;//TControl.Invalidate

procedure TControl.DoContextPopup(MousePos: TPoint;
 var Handled: Boolean);
 {* OnContextPopup event dispatcher }
//#UC START# *48E22A6B00BE_47E1201703C3_var*
//#UC END# *48E22A6B00BE_47E1201703C3_var*
begin
//#UC START# *48E22A6B00BE_47E1201703C3_impl*
 !!! Needs to be implemented !!!
//#UC END# *48E22A6B00BE_47E1201703C3_impl*
end;//TControl.DoContextPopup

procedure TControl.MouseMove(Shift: TShiftState;
 X: Integer;
 Y: Integer);
//#UC START# *48E22B250241_47E1201703C3_var*
//#UC END# *48E22B250241_47E1201703C3_var*
begin
//#UC START# *48E22B250241_47E1201703C3_impl*
 !!! Needs to be implemented !!!
//#UC END# *48E22B250241_47E1201703C3_impl*
end;//TControl.MouseMove

procedure TControl.SetParent(AParent: TWinControl);
//#UC START# *4A97E78202FC_47E1201703C3_var*
//#UC END# *4A97E78202FC_47E1201703C3_var*
begin
//#UC START# *4A97E78202FC_47E1201703C3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A97E78202FC_47E1201703C3_impl*
end;//TControl.SetParent

procedure TControl.Resize;
//#UC START# *4CC8417A0288_47E1201703C3_var*
//#UC END# *4CC8417A0288_47E1201703C3_var*
begin
//#UC START# *4CC8417A0288_47E1201703C3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4CC8417A0288_47E1201703C3_impl*
end;//TControl.Resize

procedure TControl.VisibleChanging;
//#UC START# *4CC8658C017B_47E1201703C3_var*
//#UC END# *4CC8658C017B_47E1201703C3_var*
begin
//#UC START# *4CC8658C017B_47E1201703C3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4CC8658C017B_47E1201703C3_impl*
end;//TControl.VisibleChanging

{$If Defined(l3HackedVCL) AND NOT Defined(DesignTimeLibrary)}
procedure TWinControl.SelectNext(CurControl: TWinControl;
 GoForward: Boolean;
 CheckTabStop: Boolean);
//#UC START# *4D5D1505007A_47E124E90272_var*
//#UC END# *4D5D1505007A_47E124E90272_var*
begin
//#UC START# *4D5D1505007A_47E124E90272_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D5D1505007A_47E124E90272_impl*
end;//TWinControl.SelectNext
{$IfEnd} // Defined(l3HackedVCL) AND NOT Defined(DesignTimeLibrary)

function TWinControl.CanFocus: Boolean;
//#UC START# *4E1350DE0094_47E124E90272_var*
//#UC END# *4E1350DE0094_47E124E90272_var*
begin
//#UC START# *4E1350DE0094_47E124E90272_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E1350DE0094_47E124E90272_impl*
end;//TWinControl.CanFocus

{$If Defined(l3HackedVCL) AND NOT Defined(DesignTimeLibrary)}
procedure TWinControl.ForceWMSize(aWidth: Integer;
 aHeight: Integer);
//#UC START# *4E955E8F0237_47E124E90272_var*
//#UC END# *4E955E8F0237_47E124E90272_var*
begin
//#UC START# *4E955E8F0237_47E124E90272_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E955E8F0237_47E124E90272_impl*
end;//TWinControl.ForceWMSize
{$IfEnd} // Defined(l3HackedVCL) AND NOT Defined(DesignTimeLibrary)

procedure TWinControl.DockDrop(Source: TDragDockObject;
 X: Integer;
 Y: Integer);
//#UC START# *4F8851380274_47E124E90272_var*
//#UC END# *4F8851380274_47E124E90272_var*
begin
//#UC START# *4F8851380274_47E124E90272_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F8851380274_47E124E90272_impl*
end;//TWinControl.DockDrop

procedure TWinControl.AlignControls(AControl: TControl;
 var Rect: TRect);
//#UC START# *5028E66702B0_47E124E90272_var*
//#UC END# *5028E66702B0_47E124E90272_var*
begin
//#UC START# *5028E66702B0_47E124E90272_impl*
 !!! Needs to be implemented !!!
//#UC END# *5028E66702B0_47E124E90272_impl*
end;//TWinControl.AlignControls

procedure TWinControl.AdjustClientRect(var Rect: TRect);
//#UC START# *508F957E0283_47E124E90272_var*
//#UC END# *508F957E0283_47E124E90272_var*
begin
//#UC START# *508F957E0283_47E124E90272_impl*
 !!! Needs to be implemented !!!
//#UC END# *508F957E0283_47E124E90272_impl*
end;//TWinControl.AdjustClientRect

procedure TWinControl.SetParentBackground(Value: Boolean);
//#UC START# *50FD31EE009B_47E124E90272_var*
//#UC END# *50FD31EE009B_47E124E90272_var*
begin
//#UC START# *50FD31EE009B_47E124E90272_impl*
 !!! Needs to be implemented !!!
//#UC END# *50FD31EE009B_47E124E90272_impl*
end;//TWinControl.SetParentBackground

procedure TWinControl.DockOver(Source: TDragDockObject;
 X: Integer;
 Y: Integer;
 State: TDragState;
 var Accept: Boolean);
//#UC START# *50FD32F103CA_47E124E90272_var*
//#UC END# *50FD32F103CA_47E124E90272_var*
begin
//#UC START# *50FD32F103CA_47E124E90272_impl*
 !!! Needs to be implemented !!!
//#UC END# *50FD32F103CA_47E124E90272_impl*
end;//TWinControl.DockOver

procedure TWinControl.GetSiteInfo(Client: TControl;
 var InfluenceRect: TRect;
 MousePos: TPoint;
 var CanDock: Boolean);
//#UC START# *52B9A6A80336_47E124E90272_var*
//#UC END# *52B9A6A80336_47E124E90272_var*
begin
//#UC START# *52B9A6A80336_47E124E90272_impl*
 !!! Needs to be implemented !!!
//#UC END# *52B9A6A80336_47E124E90272_impl*
end;//TWinControl.GetSiteInfo

procedure TWinControl.DoEnter;
//#UC START# *53F45A560187_47E124E90272_var*
//#UC END# *53F45A560187_47E124E90272_var*
begin
//#UC START# *53F45A560187_47E124E90272_impl*
 !!! Needs to be implemented !!!
//#UC END# *53F45A560187_47E124E90272_impl*
end;//TWinControl.DoEnter

procedure TWinControl.KeyDown(var Key: Word;
 Shift: TShiftState);
//#UC START# *554CABC100AC_47E124E90272_var*
//#UC END# *554CABC100AC_47E124E90272_var*
begin
//#UC START# *554CABC100AC_47E124E90272_impl*
 !!! Needs to be implemented !!!
//#UC END# *554CABC100AC_47E124E90272_impl*
end;//TWinControl.KeyDown

procedure TWinControl.KeyPress(var Key: Char);
//#UC START# *482C4E0E01E4_47E124E90272_var*
//#UC END# *482C4E0E01E4_47E124E90272_var*
begin
//#UC START# *482C4E0E01E4_47E124E90272_impl*
 !!! Needs to be implemented !!!
//#UC END# *482C4E0E01E4_47E124E90272_impl*
end;//TWinControl.KeyPress

procedure TWinControl.CreateWindowHandle(const Params: TCreateParams);
 {* Creates a Windows control to represent the control }
//#UC START# *48C67EB000EE_47E124E90272_var*
//#UC END# *48C67EB000EE_47E124E90272_var*
begin
//#UC START# *48C67EB000EE_47E124E90272_impl*
 !!! Needs to be implemented !!!
//#UC END# *48C67EB000EE_47E124E90272_impl*
end;//TWinControl.CreateWindowHandle

procedure TWinControl.DestroyWindowHandle;
 {* Destroys the window created in the CreateWindowHandle method }
//#UC START# *48C67EDF01C8_47E124E90272_var*
//#UC END# *48C67EDF01C8_47E124E90272_var*
begin
//#UC START# *48C67EDF01C8_47E124E90272_impl*
 !!! Needs to be implemented !!!
//#UC END# *48C67EDF01C8_47E124E90272_impl*
end;//TWinControl.DestroyWindowHandle

procedure TWinControl.PaintWindow(DC: hDC);
 {* Renders the image of a windowed control }
//#UC START# *48C6BFF80313_47E124E90272_var*
//#UC END# *48C6BFF80313_47E124E90272_var*
begin
//#UC START# *48C6BFF80313_47E124E90272_impl*
 !!! Needs to be implemented !!!
//#UC END# *48C6BFF80313_47E124E90272_impl*
end;//TWinControl.PaintWindow

procedure TWinControl.CreateParams(var Params: TCreateParams);
//#UC START# *48C7925A02E5_47E124E90272_var*
//#UC END# *48C7925A02E5_47E124E90272_var*
begin
//#UC START# *48C7925A02E5_47E124E90272_impl*
 !!! Needs to be implemented !!!
//#UC END# *48C7925A02E5_47E124E90272_impl*
end;//TWinControl.CreateParams

{$If Defined(l3HackedVCL)}
function TWinControl.LockPainting: Boolean;
//#UC START# *49CB9A6403B5_47E124E90272_var*
//#UC END# *49CB9A6403B5_47E124E90272_var*
begin
//#UC START# *49CB9A6403B5_47E124E90272_impl*
 !!! Needs to be implemented !!!
//#UC END# *49CB9A6403B5_47E124E90272_impl*
end;//TWinControl.LockPainting
{$IfEnd} // Defined(l3HackedVCL)

procedure TWinControl.CreateWnd;
//#UC START# *4CC8414403B8_47E124E90272_var*
//#UC END# *4CC8414403B8_47E124E90272_var*
begin
//#UC START# *4CC8414403B8_47E124E90272_impl*
 !!! Needs to be implemented !!!
//#UC END# *4CC8414403B8_47E124E90272_impl*
end;//TWinControl.CreateWnd

procedure TWinControl.DestroyWnd;
//#UC START# *4CC841540158_47E124E90272_var*
//#UC END# *4CC841540158_47E124E90272_var*
begin
//#UC START# *4CC841540158_47E124E90272_impl*
 !!! Needs to be implemented !!!
//#UC END# *4CC841540158_47E124E90272_impl*
end;//TWinControl.DestroyWnd

procedure TCustomControl.Paint;
//#UC START# *5028A60300AD_47E1388A03A7_var*
//#UC END# *5028A60300AD_47E1388A03A7_var*
begin
//#UC START# *5028A60300AD_47E1388A03A7_impl*
 !!! Needs to be implemented !!!
//#UC END# *5028A60300AD_47E1388A03A7_impl*
end;//TCustomControl.Paint

procedure THintWindow.ActivateHint(Rect: TRect;
 const AHint: String);
//#UC START# *50C61BA40123_50C61B670302_var*
//#UC END# *50C61BA40123_50C61B670302_var*
begin
//#UC START# *50C61BA40123_50C61B670302_impl*
 !!! Needs to be implemented !!!
//#UC END# *50C61BA40123_50C61B670302_impl*
end;//THintWindow.ActivateHint

function THintWindow.IsHintMsg(var Msg: TMsg): Boolean;
//#UC START# *50C61BD700BF_50C61B670302_var*
//#UC END# *50C61BD700BF_50C61B670302_var*
begin
//#UC START# *50C61BD700BF_50C61B670302_impl*
 !!! Needs to be implemented !!!
//#UC END# *50C61BD700BF_50C61B670302_impl*
end;//THintWindow.IsHintMsg

procedure TGraphicControl.Paint;
//#UC START# *4F2A5B6A02A5_4F2A5AA1012C_var*
//#UC END# *4F2A5B6A02A5_4F2A5AA1012C_var*
begin
//#UC START# *4F2A5B6A02A5_4F2A5AA1012C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F2A5B6A02A5_4F2A5AA1012C_impl*
end;//TGraphicControl.Paint

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TControl);
 {* Регистрация TControl }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TWinControl);
 {* Регистрация TWinControl }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TCustomControl);
 {* Регистрация TCustomControl }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(THintWindow);
 {* Регистрация THintWindow }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TGraphicControl);
 {* Регистрация TGraphicControl }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCL)

end.
