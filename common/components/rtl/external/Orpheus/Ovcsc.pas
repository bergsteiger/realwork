{$I OVC.INC}

{$B-} {Complete Boolean Evaluation}
{$I+} {Input/Output-Checking}
{$P+} {Open Parameters}
{$T-} {Typed @ Operator}
{$W-} {Windows Stack Frame}
{$X+} {Extended Syntax}

{$IFNDEF Win32}
{$G+} {286 Instructions}
{$N+} {Numeric Coprocessor}

{$C MOVEABLE,DEMANDLOAD,DISCARDABLE}
{$ENDIF}

{*********************************************************}
{*                    OVCSC.PAS 2.17                     *}
{*     Copyright (c) 1995-98 TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}


unit OvcSC;
  {-Spin controls}

interface

uses
  {$IFDEF Win32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF}
  Buttons, Classes, Controls, Forms, Graphics, Messages,
  OvcBase, OvcConst, OvcData, OvcEf, OvcMisc, OvcExcpt;

{!!.10} {added attached control support}

type
  TDirection = (dUp, dDown, dRight, dLeft);

  {position of spinner when attached to a control}
  TPosition   = (scRight, scLeft, scTop, scBottom);

  TSpinOrientation = (soVertical, soHorizontal);

  TSpinState = (ssNone,
                ssNormal,
                ssUpBtn,
                ssDownBtn,
                ssLeftBtn,
                ssRightBtn,
                ssCenterBtn);

  TSpinClickEvent = procedure(Sender : TObject; State : TSpinState;
                              Delta : Double; Wrap : Boolean)
                    of object;

const
  scDefAcceleration    = 5;
  scDefAttachTwoWay    = False;
  scDefAutoRepeat      = True;
  scDefDelayTime       = 500;
  scDefDelta           = 1;
  scDefDrawStarBorder  = False;
  scDefForceOddSize    = False;
  scDefForceSquare     = False;
  scDefHeight          = 25;
  scDefMinSize         = 13;
  scDefOrientation     = soVertical;
  scDefSeparation      = 1;
  scDefShowArrows      = True;
  scDefSize            = 25;
  scDefPosition        = scRight;
  scDefStyle           = bsAutoDetect;
  scDefWidth           = 16;
  scDefWrapMode        = True;

type
  TOvcBaseSpinner = class(TOvcBase)
  {.Z+}
  protected {private}
    {property variables}
    FAcceleration    : Byte;          {value used to determine acceleration}
    FAttachedControl : TWinControl;
    FAttachTwoWay    : Boolean;
    FAutoRepeat      : Boolean;       {repeat if button held}
    FDelta           : Double;        {amount to change by}
    FFocusedControl  : TWinControl;   {the control to give the focus to}
    FForceOddSize    : Boolean;       {force height to odd value}
    FPosition        : TPosition;
    FSeparation      : Integer;
    FShowArrows      : Boolean;
    FStyle           : TButtonStyle;  {determines how buttons look}
    FWrapMode        : Boolean;       {wrap at field bounderies}

    {events}
    FOnClick         : TSpinClickEvent;    {method to call on click events}

    {private instance variables}
    scCurrentState   : TSpinState;
    scLButton        : Byte;
    scMouseOverBtn   : Boolean;
    scNewWndProc     : Pointer;
    scNextMsgTime    : LongInt;
    scPrevState      : TSpinState;
    scPrevWndProc    : Pointer;
    scRepeatCount    : LongInt;
    scSizing         : Boolean;

    {property methods}
    procedure SetAcceleration(Value : Byte);
    procedure SetAttachedControl(Value : TWinControl);
    procedure SetAttachTwoWay(Value : Boolean);
    procedure SetForceOddSize(Value : Boolean);
    procedure SetPosition(Value : TPosition);
    procedure SetSeparation(Value : Integer);
    procedure SetShowArrows(Value : Boolean);
    procedure SetStyle(Value : TButtonStyle);

    {internal methods}
    procedure scDrawArrow(R: TRect; Pressed: Boolean; Direction: TDirection);
    procedure scHookControl;
    procedure scSetSpinnerBounds(CR : TRect);
    procedure scSetControlBounds;
    procedure scUnHookControl;
    procedure scWndProc(var Msg : TMessage);

    {windows message handling methods}
    procedure WMGetDlgCode(var Msg : TWMGetDlgCode);
      message WM_GETDLGCODE;
    procedure WMLButtonDown(var Msg : TWMLButtonDown);
      message WM_LBUTTONDOWN;

    {private message response methods}
    procedure OMRecreateWnd(var Msg : TMessage);
      message om_RecreateWnd;

  protected
    procedure CreateParams(var Params : TCreateParams);
      override;
    procedure CreateWnd;
      override;
    procedure Notification(AComponent : TComponent; Operation : TOperation);
      override;

    procedure scDoMouseDown(XPos, YPos: Integer);
      virtual; abstract;
      {-perform mouse down notification}
    procedure scDoMouseUp;
      virtual; abstract;
      {-perform mouse up actions}
    procedure scUpdateSizes;
      virtual; abstract;
      {-update spin button region sizes}

  public
    constructor Create(AOwner : TComponent);
      override;
    destructor Destroy;
      override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight : Integer);       {!!.D4}
      override;
  {.Z-}

  published
    {properties}
    property Acceleration : Byte
      read FAcceleration
      write SetAcceleration
      default scDefAcceleration;

    property AttachedControl : TWinControl
      read FAttachedControl
      write SetAttachedControl;

    property AttachTwoWay : Boolean
      read FAttachTwoWay
      write SetAttachTwoWay
      default scDefAttachTwoWay;

    property AutoRepeat : Boolean
      read FAutoRepeat
      write FAutoRepeat
      default scDefAutoRepeat;

    property Delta : Double
      read FDelta
      write FDelta;

    property FocusedControl : TWinControl
      read FFocusedControl
      write FFocusedControl;

    property ForceOddSize : Boolean
      read FForceOddSize
      write SetForceOddSize
      default scDefForceOddSize;

    property Position : TPosition
      read FPosition
      write SetPosition
      default scDefPosition;

    property Separation : Integer
      read FSeparation
      write SetSeparation
      default scDefSeparation;

    property WrapMode : Boolean
      read FWrapMode
      write FWrapMode
      default scDefWrapMode;

    {inherited properties}
    property Enabled;
    property ParentShowHint;
    property ShowHint;
    property Visible;

    {events}
    property OnClick : TSpinClickEvent
      read FOnClick
      write FOnClick;

    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
  end;

type
  TOvcSpinner = class(TOvcBaseSpinner)
  {.Z+}
  protected {private}
    {property variable}
    FOrientation   : TSpinOrientation;

    {internal variables}
    scCurrentRect  : TRect;
    scDownRect     : TRect;
    scFullRect     : TRect;
    scHeight       : Integer;      {Height of client area}
    scMinBtnSize   : TPoint;
    scUpRect       : TRect;
    scWidth        : Integer;      {Width of client area}

    {internal methods}
    function scCheckMousePos : TSpinState;
    procedure scDoAutoRepeat;
    procedure scDrawButton;

    {property method}
    procedure SetOrientation(Value : TSpinOrientation);

    {windows message handling methods}
    procedure WMLButtonUp(var Msg : TWMLButtonUp);
      message WM_LBUTTONUP;
    procedure WMSize(var Msg : TWMSize);
      message WM_SIZE;

  protected
    procedure Paint;
      override;

    {dynamic event wrappers}
    procedure DoOnClick(State : TSpinState);
      dynamic;

    procedure scDoMouseDown(XPos, YPos: Integer);
      override;
    procedure scDoMouseUp;
      override;
    procedure scUpdateSizes;
      override;
  public                                                               {!!.D4}
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer);        {!!.D4}
      override;
  {.Z-}

  published
    property Orientation : TSpinOrientation
      read FOrientation
      write SetOrientation
      default scDefOrientation;

    property ShowArrows : Boolean
      read FShowArrows
      write SetShowArrows
      default scDefShowArrows;

    property Style : TButtonStyle
      read FStyle
      write SetStyle
      default scDefStyle;

  end;

type
  TOvcFourWaySpinner = class(TOvcBaseSpinner)
  {.Z+}
  protected {private}
    {property variables}
    FForceSquare   : Boolean;       {true to resize forcing square}

    {regions for the four spin button sections}
    scUpRgn        : hRgn;
    scDownRgn      : hRgn;
    scLeftRgn      : hRgn;
    scRightRgn     : hRgn;

    {property methods}
    procedure SetForceSquare(Value : Boolean);
      {-sets the ForceSquare property}

    {internal methods}
    function scCheckMousePos : TSpinState;
    procedure scDeleteRegions;
    procedure scDoAutoRepeat;
    procedure scDrawButton(Redraw : Boolean);

    {windows message handling methods}
    procedure WMLButtonUp(var Msg : TWMLButtonUp);
      message WM_LBUTTONUP;
    procedure WMSize(var Msg : TWMSize);
      message WM_SIZE;

  protected
    procedure Paint;
      override;

    {dynamic event wrappers}
    procedure DoOnClick(State : TSpinState);
      dynamic;

    procedure scDoMouseDown(XPos, YPos: Integer);
      override;
    procedure scDoMouseUp;
      override;
    procedure scUpdateSizes;
      override;

  public
    constructor Create(AOwner : TComponent);
      override;
    destructor Destroy;
      override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer);        {!!.D4}
      override;
  {.Z-}

  published
    {properties}
    property ForceSquare : Boolean
      read FForceSquare
      write SetForceSquare
      default scDefForceSquare;

    property ShowArrows : Boolean
      read FShowArrows
      write SetShowArrows
      default scDefShowArrows;

    property Style : TButtonStyle
      read FStyle
      write SetStyle
      default scDefStyle;

  end;

type
  TOvcStarSpinner = class(TOvcBaseSpinner)
  {.Z+}
  protected {private}
    {property variables}
    FDrawStarBorder: Boolean;       {true to draw a border around the star}
    FForceSquare   : Boolean;       {true to resize forcing square}

    {regions for the five spin button sections}
    scUpRgn        : hRgn;
    scDownRgn      : hRgn;
    scLeftRgn      : hRgn;
    scRightRgn     : hRgn;
    scCenterRgn    : hRgn;

    {property methods}
    procedure SetDrawStarBorder(Value : Boolean);
      {-set mthe DrawStarBorder property}
    procedure SetForceSquare(Value : Boolean);
      {-set the ForceSquare property}

    {internal methods}
    function scCheckMousePos : TSpinState;
    procedure scDeleteRegions;
    procedure scDoAutoRepeat;
    procedure scDrawButton;
    procedure scInvalidateButton(State : TSpinState);

    {windows message handling methods}
    procedure WMSize(var Msg : TWMSize);
      message WM_SIZE;

  protected
    procedure Paint;
      override;

    {dynamic event wrappers}
    procedure DoOnClick(State : TSpinState);
      dynamic;

    procedure scDoMouseDown(XPos, YPos: Integer);
      override;
    procedure scDoMouseUp;
      override;
    procedure scUpdateSizes;
      override;

  public
    constructor Create(AOwner : TComponent);
      override;
    destructor Destroy;
      override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
      override;
  {.Z-}

  published
    {properties}
    property DrawStarBorder : Boolean
      read FDrawStarBorder
      write SetDrawStarBorder
      default scDefDrawStarBorder;

    property ForceSquare : Boolean
      read FForceSquare
      write SetForceSquare
      default scDefForceSquare;
  end;


implementation

{$IFDEF TRIALRUN}
uses OrTrial;
{$I ORTRIALF.INC}
{$ENDIF}

{*** TOvcSpinnerBase ***}

constructor TOvcBaseSpinner.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);

  {$IFDEF Win32}
  ControlStyle := ControlStyle + [csReplicatable];
  {$ENDIF}

  {create a callable window proc pointer}
  scNewWndProc   := MakeObjectInstance(scWndProc);

  {defaults}
  Width          := scDefWidth;
  Height         := scDefHeight;
  TabStop        := False;

  {initialize property variables}
  FAcceleration  := scDefAcceleration;
  FAttachTwoWay  := scDefAttachTwoWay;
  FAutoRepeat    := scDefAutoRepeat;
  FDelta         := scDefDelta;
  FForceOddSize  := scDefForceOddSize;
  FShowArrows    := scDefShowArrows;
  FStyle         := scDefStyle;
  FPosition      := scDefPosition;
  FSeparation    := scDefSeparation;
  FWrapMode      := scDefWrapMode;

  scCurrentState := ssNormal;
  scPrevState    := ssNone;
  scMouseOverBtn := False;
end;

procedure TOvcBaseSpinner.CreateParams(var Params : TCreateParams);
begin
  inherited CreateParams(Params);
  ControlStyle := ControlStyle + [csOpaque] - [csFramed];

  if not (csDesigning in ComponentState) then
    ControlStyle := ControlStyle - [csDoubleClicks];
end;

procedure TOvcBaseSpinner.CreateWnd;
{$IFDEF TRIALRUN}
var
  X : Integer;
{$ENDIF}
begin
  inherited CreateWnd;

  {update sizes of control and button regions}
  scUpdateSizes;

  {hook into attached control's window procedure}
  if csDesigning in ComponentState then                                {!!.13}
  scHookControl;

  {adjust our position and size}
  if (AttachedControl <> nil) and AttachedControl.HandleAllocated then
    scSetSpinnerBounds(AttachedControl.BoundsRect);

{$IFDEF TRIALRUN}
  X := _CC_;
  if (X < ccRangeLow) or (X > ccRangeHigh) then Halt;
  X := _VC_;
  if (X < ccRangeLow) or (X > ccRangeHigh) then Halt;
{$ENDIF}
end;

destructor TOvcBaseSpinner.Destroy;
begin
  {unhook from attached control's window procedure}
  if csDesigning in ComponentState then                                {!!.13}
  scUnHookControl;
  FAttachedControl := nil;

  FreeObjectInstance(scNewWndProc);
  scNewWndProc := nil;

  inherited Destroy;
end;

procedure TOvcBaseSpinner.Notification(AComponent : TComponent; Operation : TOperation);
begin
  inherited Notification(AComponent, Operation);

  if (AComponent = FFocusedControl) and (Operation = opRemove) then
    FocusedControl := nil;

  if (AComponent = AttachedControl) and (Operation = opRemove) then
    AttachedControl := nil;
end;

procedure TOvcBaseSpinner.OMRecreateWnd(var Msg : TMessage);
begin
  RecreateWnd;
end;

{$IFDEF Win32}
function GetArrowWidth(Width, Height : Integer) : Integer; register;
asm
  cmp  eax, edx
  jle  @@1
  mov  eax, edx
@@1:
  shr  eax, 1
  or   eax, 1
end;
{$ELSE}
function GetArrowWidth(Width, Height : Integer) : Integer; assembler;
asm
  mov  ax, Width
  mov  dx, Height
  cmp  ax, dx
  jle  @@1
  mov  ax, dx
@@1:
  shr  ax, 1
  or   ax, 1
end;
{$ENDIF}

procedure TOvcBaseSpinner.scDrawArrow(R: TRect; Pressed: Boolean;
  Direction: TDirection);
var
  ArrowWidth, ArrowHeight : Integer;
  X, Y : Integer;
  LeftPoint, RightPoint, PointPoint : TPoint;
  PLeftPoint, PRightPoint, PPointPoint : TPoint;
begin
  with Canvas do begin
    ArrowWidth := GetArrowWidth(R.Right-R.Left, R.Bottom-R.Top);
    ArrowHeight := (ArrowWidth + 1) div 2;
    if Direction in [dUp, dDown] then begin
      X := (R.Right-R.Left-ArrowWidth) div 2;
      Y := (R.Bottom-R.Top-ArrowHeight) div 2;
    end else begin
      X := (R.Right-R.Left-ArrowHeight) div 2;
      Y := (R.Bottom-R.Top-ArrowWidth) div 2;
    end;
    case Direction of
      dUp :
        begin
          LeftPoint  := Point(X, Y + ArrowHeight + R.Top - 1);
          RightPoint := Point(X + ArrowWidth - 1, Y + ArrowHeight + R.Top -1 );
          PointPoint := Point(X + (ArrowWidth div 2), Y + R.Top);
        end;
      dDown :
        begin
          LeftPoint  := Point(X, Y + R.Top);
          RightPoint := Point(X + ArrowWidth - 1 , Y + R.Top);
          PointPoint := Point(X + (ArrowWidth div 2), Y + ArrowHeight + R.Top - 1);
        end;
      dRight :
        begin
          LeftPoint  := Point(R.Left + X, Y);
          RightPoint := Point(R.Left + X, Y + ArrowWidth - 1);
          PointPoint := Point(R.Left + X + ArrowHeight - 1, Y + (ArrowWidth div 2));
        end;
      dLeft  :
        begin
          LeftPoint  := Point(R.Left + X + ArrowHeight - 1, Y);
          RightPoint := Point(R.Left + X + ArrowHeight - 1, Y + ArrowWidth - 1);
          PointPoint := Point(R.Left + X, Y + (ArrowWidth div 2));
        end;
    end;
    PLeftPoint.X := LeftPoint.X + 1;
    PLeftPoint.Y := LeftPoint.Y + 1;
    PRightPoint.X := RightPoint.X + 1;
    PRightPoint.Y := RightPoint.Y + 1;
    PPointPoint.X := PointPoint.X + 1;
    PPointPoint.Y := PointPoint.Y + 1;
    if Pressed then begin
      Pen.Color := clBtnFace;
      Brush.Color := clBtnFace;
      Polygon([LeftPoint, RightPoint, PointPoint]);
      Pen.Color := clBtnText;
      Brush.Color := clBtnText;
      Polygon([PLeftPoint, PRightPoint, PPointPoint]);
    end else begin
      Pen.Color := clBtnFace;
      Brush.Color := clBtnFace;
      Polygon([PLeftPoint, PRightPoint, PPointPoint]);
      Pen.Color := clBtnText;
      Brush.Color := clBtnText;
      Polygon([LeftPoint, RightPoint, PointPoint]);
    end;
  end;
end;

procedure TOvcBaseSpinner.scHookControl;
var
  P : Pointer;
begin
  {hook into attached control's window procedure}
  if (AttachedControl <> nil) then begin
    AttachedControl.HandleNeeded;

    {save original window procedure if not already saved}
    P := Pointer(GetWindowLong(AttachedControl.Handle, GWL_WNDPROC));

    if (P <> scNewWndProc) then begin
      scPrevWndProc := Pointer(GetWindowLong(AttachedControl.Handle, GWL_WNDPROC));

      {change to ours}
      SetWindowLong(AttachedControl.Handle, GWL_WNDPROC, LongInt(scNewWndProc));
    end;
  end;
end;

procedure TOvcBaseSpinner.scSetSpinnerBounds(CR : TRect);
begin
  if scSizing then
    Exit;

  scSizing := True;
  try
    case FPosition of
      scRight  : SetBounds(CR.Right + Separation, CR.Top, Width, CR.Bottom-CR.Top);
      scLeft   : SetBounds(CR.Left - Width - Separation, CR.Top, Width, CR.Bottom-CR.Top);
      scTop    : SetBounds(CR.Left, CR.Top-Height - Separation, CR.Right-CR.Left, Height);
      scBottom : SetBounds(CR.Left, CR.Bottom + Separation, CR.Right-CR.Left, Height);
    end;
  finally
    scSizing := False;
  end;
end;

procedure TOvcBaseSpinner.scSetControlBounds;
var
  acW : Integer;
  acH : Integer;
begin
  if scSizing then
    Exit;

  if (AttachedControl = nil) then
    Exit;

  if not FAttachTwoWay then
    Exit;

  scSizing := True;
  try
    acW := AttachedControl.Width;
    acH := AttachedControl.Height;
    case FPosition of
      scRight  : AttachedControl.SetBounds(Left-acW-Separation, Top, acW, Height);
      scLeft   : AttachedControl.SetBounds(Left+Width+Separation, Top, acW, Height);
      scTop    : AttachedControl.SetBounds(Left, Top+Height+Separation, Width, acH);
      scBottom : AttachedControl.SetBounds(Left, Top-acH-Separation, Width, acH);
    end;
  finally
    scSizing := False;
  end;
end;

procedure TOvcBaseSpinner.scUnHookControl;
begin
  if (AttachedControl <> nil) then begin
    if Assigned(scPrevWndProc) and AttachedControl.HandleAllocated then
      SetWindowLong(AttachedControl.Handle, GWL_WNDPROC, LongInt(scPrevWndProc));
  end;
  scPrevWndProc := nil;
end;

procedure TOvcBaseSpinner.scWndProc(var Msg : TMessage);
begin
  with Msg do begin
    if (AttachedControl <> nil) then begin
      try
        case Msg of
          WM_SIZE, WM_MOVE :
            scSetSpinnerBounds(AttachedControl.BoundsRect);
        end;
      except
        Application.HandleException(Self);
      end
    end;

    if Assigned(scPrevWndProc) then
      Result := CallWindowProc(scPrevWndProc, AttachedControl.Handle, Msg, wParam, lParam)
    else
      Result := CallWindowProc(DefWndProc, AttachedControl.Handle, Msg, wParam, lParam);

    if Msg = WM_DESTROY then begin
      {the window handle for the attached control has been destroyed}
      {we need to un-attach and then re-attach (if possible)}
      scUnHookControl;
      if not (csDestroying in ComponentState) then
        PostMessage(Handle, om_RecreateWnd, 0, 0);
    end;

    {if we get this message, we must be attached -- return self}
    if Msg = om_IsAttached then
      Result := LongInt(Self);
  end;
end;

procedure TOvcBaseSpinner.SetAcceleration(Value : Byte);
  {-set the acceleration property}
begin
  if {(Value >= 0) and} (Value <= 10) then                             {!!.D4}
    FAcceleration := Value;
end;

procedure TOvcBaseSpinner.SetAttachedControl(Value : TWinControl);
var
  WC : TWinControl;
begin
  if Value <> FAttachedControl then begin

    {unhook from attached control's window procedure}
    scUnHookControl;

    {insure that we are the only one to hook to this control}
    if not (csLoading in ComponentState) and Assigned(Value) then begin
      {send message asking if this control is attached to anything}
      {the control itself won't be able to respond unless it is attached}
      {in which case, it will be our hook into the window procedure that}
      {is actually responding}

      if Value.HandleAllocated then begin
        WC := TWinControl(SendMessage(Value.Handle, om_IsAttached, 0, 0));
        if Assigned(WC) then
          raise EOvcException.CreateFmt(GetOrphStr(SCControlAttached), [WC.Name]);
      end;
    end;

    FAttachedControl := Value;

    if (not Assigned(FFocusedControl)) and not (csLoading in ComponentState) then
      FFocusedControl := FAttachedControl;

    FForceOddSize := False;
    RecreateWnd;
  end;
end;

procedure TOvcBaseSpinner.SetAttachTwoWay(Value : Boolean);
begin
  if (Value <> FAttachTwoWay) then begin
    FAttachTwoWay := Value;
  end;
end;

procedure TOvcBaseSpinner.SetBounds(ALeft, ATop, AWidth, AHeight : Integer);
var
  L, T, H, W : Integer;
begin
  {if anything changes, may need to adjust attached control}
  L := Left;
  T := Top;
  H := Height;
  W := Width;

  inherited SetBounds(ALeft, ATop, AWidth, AHeight);

  if (L <> Left) or (T <> Top) or (H <> Height) or (W <> Width) then
    scSetControlBounds;
end;

procedure TOvcBaseSpinner.SetForceOddSize(Value : Boolean);
begin
  if Value <> FForceOddSize then begin
    FForceOddSize := Value;
    if FForceOddSize then
      SetBounds(Left, Top, Width, Height);  {force resize}
  end;
end;

procedure TOvcBaseSpinner.SetPosition(Value : TPosition);
begin
  if (Value <> FPosition) then begin
    FPosition := Value;
    if not (csLoading in ComponentState) then
      if (AttachedControl <> nil) then
        scSetSpinnerBounds(AttachedControl.BoundsRect);
  end;
end;

procedure TOvcBaseSpinner.SetSeparation(Value : Integer);
begin
  if (Value <> FSeparation) then begin
    FSeparation := Value;
    if not (csLoading in ComponentState) then
      if (AttachedControl <> nil) then
        scSetSpinnerBounds(AttachedControl.BoundsRect);
  end;
end;

procedure TOvcBaseSpinner.SetShowArrows(Value : Boolean);
begin
  if Value <> FShowArrows then begin
    FShowArrows := Value;
    Refresh;
  end;
end;

procedure TOvcBaseSpinner.SetStyle(Value : TButtonStyle);
begin
  if Value <> FStyle then begin
    FStyle := Value;
    Refresh;
  end;
end;

procedure TOvcBaseSpinner.WMGetDlgCode(var Msg : TWMGetDlgCode);
begin
  {tell windows we are a static control to avoid receiving the focus}
  Msg.Result := DLGC_STATIC;
end;

procedure TOvcBaseSpinner.WMLButtonDown(var Msg : TWMLButtonDown);
begin
  inherited;

  if Assigned(FFocusedControl) then begin
    if GetFocus <> FFocusedControl.Handle then begin
      {set focus to ourself to force entry field validation}
      SetFocus;

      {allow message processing}
      Application.ProcessMessages;

      {if we didn't keep the focus, something must have happened--exit}
      if (GetFocus <> Handle) then
        Exit;
    end;

    if GetFocus <> FFocusedControl.Handle then
      if FFocusedControl.CanFocus then
        FFocusedControl.SetFocus;
  end;

  try
    scDoMouseDown(Msg.XPos, Msg.YPos);
  except
    scDoMouseUp;
    raise;
  end;
end;


{*** TOvcSpinner ***}

procedure TOvcSpinner.DoOnClick(State: TSpinState);
begin
  if Assigned(FOnClick) or (Assigned(FFocusedControl) and
     (FFocusedControl is TOvcBaseEntryField)) then begin
    if scMouseOverBtn then begin
      if LongInt(GetTickCount) > scNextMsgTime then begin              {!!.D4}

        {call OnClick event handler}
        if Assigned(FOnClick) then
          FOnClick(Self, State, Delta, FWrapMode);

        {auto link with Orpheus entry fields}
        if Assigned(FFocusedControl) and
           (FFocusedControl is TOvcBaseEntryField) then
          case State of
            ssUpBtn : TOvcBaseEntryField(FFocusedControl).IncreaseValue(FWrapMode, Delta);
            ssDownBtn : TOvcBaseEntryField(FFocusedControl).DecreaseValue(FWrapMode, Delta);
            ssLeftBtn : TOvcBaseEntryField(FFocusedControl).MoveCaret(-1);
            ssRightBtn : TOvcBaseEntryField(FFocusedControl).MoveCaret(+1);
          end;

        {setup for next time}
        scNextMsgTime := LongInt(GetTickCount) + scDefDelayTime -      {!!.D4}
                         Acceleration*10*scRepeatCount;                {!!.D4}
        Inc(scRepeatCount);
      end;
    end;
  end;
end;

procedure TOvcSpinner.Paint;
begin
  scDrawButton;
end;

function TOvcSpinner.scCheckMousePos : TSpinState;
var
  P           : TPoint;
begin
  GetCursorPos(P);
  P := ScreenToClient(P);

  {see which button the mouse is over}
  Result := ssNone;
  if PtInRect(ClientRect, P) then begin
    if not (csClicked in ControlState) then
      Result := ssNormal
    else if PtInRect(scUpRect, P) then
      if FOrientation = soVertical then
        Result := ssUpBtn
      else
        Result := ssRightBtn
    else if PtInRect(scDownRect, P) then
      if FOrientation = soVertical then
        Result := ssDownBtn
      else
        Result := ssLeftBtn
    else
      Result := ssNormal;
  end;
end;

procedure TOvcSpinner.scDoAutoRepeat;
var
  NewState : TSpinState;
begin
  DoOnClick(scCurrentState);
  {repeat until left button released}
  repeat
    if AutoRepeat then
      DoOnClick(scCurrentState);

    {allow other messages}
    Application.ProcessMessages;

    {get new button/mouse state}
    NewState := scCheckMousePos;

    {has anything changed}
    if NewState <> scCurrentState then begin
      {the mouse is not over a button or its over a new one}
      scPrevState := scCurrentState;
      scCurrentState := NewState;
      case scCurrentState of
        ssUpBtn : scCurrentRect := scUpRect;
        ssDownBtn : scCurrentRect := scDownRect;
        ssRightBtn : scCurrentRect := scUpRect;
        ssLeftBtn : scCurrentRect := scDownRect;
      end;
      scMouseOverBtn := scCurrentState in [ssUpBtn, ssDownBtn, ssRightBtn, ssLeftBtn];
      scDrawButton;
    end;

    {until the mouse button is released}
  until (GetAsyncKeyState(scLButton) and $8000) = 0;
end;

procedure TOvcSpinner.scDoMouseDown(XPos, YPos: Integer);
begin
  scPrevState := scCurrentState;

  {find which button was clicked}
  if FOrientation = soVertical then
    if (YPos > scHeight div 2) and (YPos < scHeight) then begin
      scCurrentState := ssDownBtn;
      scCurrentRect := scDownRect;
    end else begin
      scCurrentState := ssUpBtn;
      scCurrentRect := scUpRect;
    end
  else
    if (XPos > scWidth div 2) and (XPos < scWidth) then begin
      scCurrentState := ssRightBtn;
      scCurrentRect := scUpRect;
    end else begin
      scCurrentState := ssLeftBtn;
      scCurrentRect := scDownRect;
    end;
  scMouseOverBtn := True;
  scDrawButton;

  scRepeatCount := 0;
  scLButton := GetLeftButton;
  scNextMsgTime := GetTickCount-1;
  scDoAutoRepeat;
end;

procedure TOvcSpinner.scDoMouseUp;
begin
  scPrevState := scCurrentState;
  scCurrentState := ssNormal;
  scMouseOverBtn := False;
  scDrawButton;
end;

procedure TOvcSpinner.scDrawButton;
  {-draw the spin button in the current state}
var
  TopPressed    : Boolean;
  BottomPressed : Boolean;

begin
  if (csClicked in ControlState) and scMouseOverBtn then begin
    TopPressed := (scCurrentState in [ssUpBtn, ssRightBtn]);
    BottomPressed := (scCurrentState in [ssDownBtn, ssLeftBtn]);
  end else begin
    TopPressed := False;
    BottomPressed := False;
  end;
  DrawButtonFace(Canvas, scUpRect, 1, FStyle, False, TopPressed, False);
  DrawButtonFace(Canvas, scDownRect, 1, FStyle, False, BottomPressed, False);
  if FShowArrows then begin
    if FOrientation = soVertical then begin
      scDrawArrow(scUpRect, TopPressed, dUp);
      scDrawArrow(scDownRect, BottomPressed, dDown);
    end else begin
      scDrawArrow(scUpRect, TopPressed, dRight);
      scDrawArrow(scDownRect, BottomPressed, dLeft);
    end;
  end;
end;

procedure TOvcSpinner.scUpdateSizes;
begin
  {get size of client area}
  scWidth := ClientWidth;
  scHeight := ClientHeight;

  {setup the TRect structures with new sizes}
  scFullRect := Rect(0, 0, scWidth, scHeight);
  if FOrientation = soVertical then begin
    scUpRect := Rect(0, 0, scWidth, scHeight div 2);
    scDownRect := Rect(0, scHeight div 2, scWidth, scHeight);
  end else begin
    scUpRect := Rect(scWidth div 2, 0, scWidth, scHeight);
    scDownRect := Rect(0, 0, scWidth div 2, scHeight);
  end;
end;

procedure TOvcSpinner.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  {limit smallest size}
  if AWidth < scMinBtnSize.X then
    AWidth := scMinBtnSize.X;
  if AHeight < scMinBtnSize.Y then
    AHeight := scMinBtnSize.Y;

  {force height to odd value}
  if ForceOddSize then
    if not Odd(AHeight) then
      AHeight := Succ(AHeight);

  inherited SetBounds(ALeft, ATop, AWidth, AHeight);

  {update sizes of control and button regions}
  if HandleAllocated then
    scUpdateSizes;
end;

procedure TOvcSpinner.SetOrientation(Value: TSpinOrientation);
var
  Temp: Integer;
begin
  if Value <> FOrientation then
  begin
    FOrientation := Value;
    if not (csReading in ComponentState) then begin
      Temp := Height;
      Height := Width;
      Width := Temp;
      RecreateWnd;
    end;
  end;
end;

procedure TOvcSpinner.WMLButtonUp(var Msg : TWMLButtonUp);
begin
  inherited;
  scDoMouseUp;
end;

procedure TOvcSpinner.WMSize(var Msg : TWMSize);
begin
  inherited;
  if csDesigning in ComponentState then
    scDrawButton;
end;


{*** TOvcFourWaySpinner ***}

constructor TOvcFourWaySpinner.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csFramed, csOpaque];

  {defaults}
  Width          := scDefHeight;
  Height         := scDefHeight;
  FForceSquare   := scDefForceSquare;
end;

destructor TOvcFourWaySpinner.Destroy;
begin
  scDeleteRegions;
  inherited Destroy;
end;

procedure TOvcFourWaySpinner.DoOnClick(State: TSpinState);
begin
  if Assigned(FOnClick) or (Assigned(FFocusedControl) and
     (FFocusedControl is TOvcBaseEntryField)) then begin
    if scMouseOverBtn then begin
      if LongInt(GetTickCount) > scNextMsgTime then begin              {!!.D4}

        {call OnClick event handler}
        if Assigned(FOnClick) then
          FOnClick(Self, State, Delta, FWrapMode);

        {auto link with Orpheus entry fields}
        if Assigned(FFocusedControl) and
           (FFocusedControl is TOvcBaseEntryField) then
          case State of
            ssUpBtn : TOvcBaseEntryField(FFocusedControl).IncreaseValue(FWrapMode, Delta);
            ssDownBtn : TOvcBaseEntryField(FFocusedControl).DecreaseValue(FWrapMode, Delta);
            ssLeftBtn : TOvcBaseEntryField(FFocusedControl).MoveCaret(-1);
            ssRightBtn : TOvcBaseEntryField(FFocusedControl).MoveCaret(+1);
          end;

        {setup for next time}
        scNextMsgTime := LongInt(GetTickCount) + scDefDelayTime -      {!!.D4}
                         Acceleration*10*scRepeatCount;                {!!.D4}
        Inc(scRepeatCount);
      end;
    end;
  end;
end;

procedure TOvcFourWaySpinner.Paint;
begin
  scDrawButton(True);
end;

function TOvcFourWaySpinner.scCheckMousePos : TSpinState;
var
  P           : TPoint;
begin
  GetCursorPos(P);
  P := ScreenToClient(P);

  {see which button the mouse is over}
  Result := ssNone;
  if PtInRect(ClientRect, P) then begin
    if not (csClicked in ControlState) then
      Result := ssNormal

      {mouse is over one of the buttons, which one?}
    else if PtInRegion(scUpRgn, P.X, P.Y) then
      Result := ssUpBtn
    else if PtInRegion(scDownRgn, P.X, P.Y) then
      Result := ssDownBtn
    else if PtInRegion(scLeftRgn, P.X, P.Y) then
      Result := ssLeftBtn
    else if PtInRegion(scRightRgn, P.X, P.Y) then
      Result := ssRightBtn
    else
      Result := ssNormal;
  end;
end;

procedure TOvcFourWaySpinner.scDeleteRegions;
begin
  if scUpRgn <> 0 then DeleteObject(scUpRgn);
  if scDownRgn <> 0 then DeleteObject(scDownRgn);
  if scLeftRgn <> 0 then DeleteObject(scLeftRgn);
  if scRightRgn <> 0 then DeleteObject(scRightRgn);
end;

procedure TOvcFourWaySpinner.scDoAutoRepeat;
var
  NewState : TSpinState;
begin
  DoOnClick(scCurrentState);

  {repeat until left button released}
  repeat
    if AutoRepeat then
      DoOnClick(scCurrentState);

    {allow other messages}
    Application.ProcessMessages;

    {get new button/mouse state}
    NewState := scCheckMousePos;

    {has anything changed}
    if NewState <> scCurrentState then begin
      {the mouse is not over a button or its over a new one}
      scPrevState := scCurrentState;
      scCurrentState := NewState;
      scMouseOverBtn := not (scCurrentState in [ssNone, ssNormal]);
      scDrawButton(False);
    end;

    {until the mouse button is released}
  until (GetAsyncKeyState(scLButton) and $8000) = 0;
end;

procedure TOvcFourWaySpinner.scDoMouseDown(XPos, YPos: Integer);
begin
  scPrevState := scCurrentState;

  {find which button was clicked}
  scCurrentState := scCheckMousePos;
  scMouseOverBtn := True;
  scDrawButton(False);

  {initialize and start repeating}
  scRepeatCount := 0;
  scLButton := GetLeftButton;
  scNextMsgTime := GetTickCount-1;
  scDoAutoRepeat;
end;

procedure TOvcFourWaySpinner.scDoMouseUp;
begin
  {save last state and redraw}
  scPrevState := scCurrentState;
  scCurrentState := ssNormal;
  scMouseOverBtn := False;
  scDrawButton(False);
end;

procedure TOvcFourWaySpinner.scDrawButton(Redraw : Boolean);
  {-draw the spin button in the current state}
var
  W, H     : Integer;
  W2, H2   : Integer;
  NewStyle : Boolean;

  procedure DrawBasicShape;
  begin
    with Canvas do begin
      Brush.Color := clBtnFace;
      Brush.Style := bsSolid;
      if NewStyle then begin
        Pen.Color := clBtnFace;
        Rectangle(0, 0, W, H);
        Pen.Color := clBtnHighlight;
        PolyLine([Point(0,H-2), Point(0,0), Point(W-1,0)]);
        Pen.Color := clWindowFrame;
        PolyLine([Point(0,H-1), Point(W-1,H-1), Point(W-1,-1)]);
        PolyLine([Point(1, 1), Point(W-1, H-1)]);
        PolyLine([Point(1, H-2), Point(W-1, 0)]);
      end else begin
        Pen.Color := clWindowFrame;

        {face area}
        Rectangle(0, 0, W, H);

        {cross bars}
        PolyLine([Point(0, 0), Point(W, H)]);
        PolyLine([Point(0, H-1), Point(W-1, 0)]);
      end;
    end;
  end;

  procedure DrawFace(State : TSpinState; Up : Boolean);
  const
    BtnColor : array[Boolean, 0..4] of TColor = (
      (clBtnShadow, clBtnShadow, clBtnFace, clBtnHighlight, clWindowFrame),
      (clBtnHighlight, clBtnFace, clBtnShadow, clWindowFrame, clBtnHighlight));
  begin
    with Canvas do begin
      case State of
        ssUpBtn : begin
          if FShowArrows then
            scDrawArrow(Rect(0, 0, Width, (Height div 3)), not(Up), dUp);
          if NewStyle then begin
            Pen.Color := BtnColor[Up, 1];
            PolyLine([Point(2,1), Point(W-2,1)]);
            Pen.Color := BtnColor[Up, 4];
            PolyLine([Point(0,0), Point(W-1,0)]);             {top edge}
            if Up then begin
              Pen.Color := clWindowFrame;
              PolyLine([Point(W2+1, H2-1), Point(W-1, 0)]);   {bottom diagonal}
              Pen.Color := clBtnFace;
              PolyLine([Point(W2, H2-1), Point(W-3, 1)]);     {bottom diagonal}
            end else begin
              Pen.Color := clBtnHighlight;
              PolyLine([Point(W2+1,H2-1), Point(W-2,1)]);     {bottom diagonal}
              PolyLine([Point(W2,H2-1), Point(W-3,1)]);       {bottom diagonal}
              Pen.Color := clBtnShadow;
              PolyLine([Point(W-2,1), Point(W-2,0)]);
            end;
          end else begin
            Pen.Color := btnColor[Up, 0];
            PolyLine([Point(3,1), Point(W-4, 1)]);            {top edge}
            PolyLine([Point(3,2), Point(W2, H2-1)]);          {left diagonal}
            Pen.Color := BtnColor[Up, 1];
            PolyLine([Point(W2, H2-1), Point(W-2, 0)]);       {right diagonal}
          end;
        end;
        ssDownBtn  :
          if NewStyle then begin
            Pen.Color := BtnColor[Up, 3];
            PolyLine([Point(0,H-1), Point(W-1,H-1)]);         {bottom edge}
            Pen.Color := BtnColor[Up, 2];
            if Up then begin
              if FShowArrows then
                scDrawArrow(Rect(0, Height - (Height div 3), Width, Height),
                  not(Up), dDown);
              Pen.Color := clBtnFace;
              PolyLine([Point(3, H-3), Point(W2+1,H2)]);
              PolyLine([Point(4, H-3), Point(W2+1,H2+1)]);
              Pen.Color := clBtnShadow;
              PolyLine([Point(2,H-2), Point(W-2,H-2)]);
            end else begin
              Pen.Color := clBtnFace;
              PolyLine([Point(2,H-2), Point(W-2,H-2)]);
              Pen.Color := clWindowFrame;
              PolyLine([Point(1, H-1), Point(W2+1,H2)]);
              PolyLine([Point(0, H-1), Point(0, H)]);
              Pen.Color := clBtnShadow;
              PolyLine([Point(2, H-1), Point(W2+1,H2+1)]);
              if FShowArrows then
                scDrawArrow(Rect(0, Height - (Height div 3), Width, Height),
                  not(Up), dDown);
            end;
          end else begin
            Pen.Color := btnColor[Up, 0];
            PolyLine([Point(4,H-4), Point(W2,H2+1)]);         {left diagonal}
            Pen.Color := btnColor[Up, 1];
            PolyLine([Point(2,H-2), Point(W-2,H-2)]);         {bottom edge}
            PolyLine([Point(W2,H2+1), Point(W-2,H-1)]);       {right diagonal}
            if FShowArrows then
              scDrawArrow(Rect(0, Height - (Height div 3), Width, Height),
                not(Up), dDown);
          end;
        ssLeftBtn : begin
          if FShowArrows then
            scDrawArrow(Rect(0, 0, (Width div 3), Height), not(Up), dLeft);
          if NewStyle then begin
            Pen.Color := btnColor[Up, 4];
            PolyLine([Point(0, 0), Point(0, H-1)]);           {left edge}
            Pen.Color := BtnColor[Up, 1];
            PolyLine([Point(1, 2), Point(1, H-2)]);
            if Up then begin
              Pen.Color := clWindowFrame;
              PolyLine([Point(1, H-2), Point(W2, H2)]);       {bottom diagonal}
              Pen.Color := clBtnFace;
              PolyLine([Point(2, H-4), Point(W2, H2-1)]);     {bottom diagonal}
            end else begin
              Pen.Color := clBtnHighlight;
              PolyLine([Point(2, H-3), Point(W2, H2)]);       {bottom diagonal}
              PolyLine([Point(2, H-4), Point(W2, H2-1)]);     {bottom diagonal}
              Pen.Color := clBtnShadow;
              PolyLine([Point(1, H-2), Point(1, H-1)]);
            end;
          end else begin
            Pen.Color := btnColor[Up, 0];
            PolyLine([Point(1, 4), Point(1, H-4)]);           {left edge}
            Pen.Color := btnColor[Up, 1];
            PolyLine([Point(1, 2), Point(W2, H2+1)]);         {top diagonal}
            PolyLine([Point(1, H-3), Point(W2, H2-1)]);       {bottom diagonal}
          end;
        end;
        ssRightBtn :
          if NewStyle then begin
            Pen.Color := BtnColor[Up, 2];
            PolyLine([Point(W-2, 2), Point(W-2, H-2)]);       {right edge}
            Pen.Color := BtnColor[Up, 3];
            PolyLine([Point(W-1, 0), Point(W-1, H)]);
            if Up then begin
              if FShowArrows then
                scDrawArrow(Rect(Width - (Width div 3), 0, Width, Height),
                  not (Up), dRight);
              Pen.Color := clBtnFace;
              PolyLine([Point(W2+1, H2), Point(W-2,2)]);
              PolyLine([Point(W2+2, H2), Point(W-2,3)]);
              Pen.Color := clBtnShadow;
              PolyLine([Point(W-2, 2), Point(W-2, H-2)]);     {right edge}
            end else begin
              Pen.Color := clBtnFace;
              PolyLine([Point(W-2, 2), Point(W-2, H-2)]);     {right edge}
              Pen.Color := clWindowFrame;
              PolyLine([Point(W2+1, H2), Point(W, 0)]);
              PolyLine([Point(W-1, 0), Point(W, 0)]);
              PolyLine([Point(W-1, H-1), Point(W, H)]);
              Pen.Color := clBtnShadow;
              PolyLine([Point(W2+2, H2), Point(W,1)]);
              if FShowArrows then
                scDrawArrow(Rect(Width - (Width div 3), 0, Width, Height),
                  not(Up), dRight);
            end;
          end else begin
            Pen.Color := btnColor[Up, 0];
            PolyLine([Point(W2+1, H2), Point(W-3, 3)]);       {top diagonal}
            PolyLine([Point(W2+1, H2), Point(W-3,H-4)]);      {bottom diagonal}
            Pen.Color := btnColor[Up, 1];
            PolyLine([Point(W-2, 2), Point(W-2, H-2)]);       {right edge}
            if FShowArrows then
              scDrawArrow(Rect(Width - (Width div 3), 0, Width, Height),
                not(Up), dRight);
          end;
      end;
    end;
  end;

begin
  {get values for drawing}
  W := Width;
  H := Height;
  W2 := Width div 2;
  H2 := Height div 2;

  NewStyle := (FStyle = bsNew) or ((FStyle = bsAutoDetect) and NewStyleControls);

  with Canvas do begin
    if Redraw then begin
      {first time drawn}
      DrawBasicShape;
      DrawFace(ssUpBtn, True);
      DrawFace(ssDownBtn, True);
      DrawFace(ssLeftBtn, True);
      DrawFace(ssRightBtn, True);
    end;

    if scPrevState <> scCurrentState then
      DrawFace(scPrevState, True);
    if scMouseOverBtn then
      DrawFace(scCurrentState, False);

    if NewStyle then begin
      Pen.Color := clBtnFace;
      PolyLine([Point(0,0), Point(0,1)]);         {T/L}
    end else begin
      Pen.Color := clBtnShadow;

      {draw shadow in corners}
      PolyLine([Point(1,2),     Point(3,1)]);     {T/L}
      PolyLine([Point(1,H-3),   Point(3,H-1)]);   {B/L}
      PolyLine([Point(W-3,1),   Point(W-1,3)]);   {T/R}
      PolyLine([Point(W-3,H-2), Point(W-1,H-3)]); {B/R}
    end;

  end;
end;

procedure TOvcFourWaySpinner.scUpdateSizes;
var
  Points : array[0..2] of TPoint;
begin
  {store info about button locations}
  scDeleteRegions;

  Points[0] := Point(0, 0);
  Points[1] := Point(Width, 0);
  Points[2] := Point(Width div 2, Height div 2);
  scUpRgn := CreatePolygonRgn(Points, 3, ALTERNATE);

  Points[0] := Point(0, Height);
  Points[1] := Point(Width div 2, Height div 2);
  Points[2] := Point(Width, Height);
  scDownRgn := CreatePolygonRgn(Points, 3, ALTERNATE);

  Points[0] := Point(0, 0);
  Points[1] := Point(Width div 2, Height div 2);
  Points[2] := Point(0, Height);
  scLeftRgn := CreatePolygonRgn(Points, 3, ALTERNATE);

  Points[0] := Point(Width, 0);
  Points[1] := Point(Width div 2, Height div 2);
  Points[2] := Point(Width, Height);
  scRightRgn := CreatePolygonRgn(Points, 3, ALTERNATE);
end;

procedure TOvcFourWaySpinner.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  if (csDesigning in ComponentState) and not (csLoading in ComponentState) then begin

    {limit smallest size}
    if AWidth < scDefMinSize then
      AWidth := scDefMinSize ;
    if AHeight < scDefMinSize then
      AHeight := scDefMinSize ;

    {force size to odd value}
    if ForceOddSize then begin
      if not Odd(AHeight) then
        AHeight := Succ(AHeight);
      if not Odd(AWidth) then
        AWidth := Succ(AWidth);
    end;

    {force to a square shape}
    if FForceSquare then
      if AWidth < AHeight then
        AHeight := AWidth
      else
        AWidth := AHeight;
  end;

  inherited SetBounds(ALeft, ATop, AWidth, AHeight);

  {update sizes of control and button regions}
  if HandleAllocated then
    scUpdateSizes;
end;

procedure TOvcFourWaySpinner.SetForceSquare(Value : Boolean);
begin
  if Value <> FForceSquare then begin
    FForceSquare := Value;
    if FForceSquare and not (csLoading in ComponentState) then
      SetBounds(Left, Top, Width, Height);  {force resize}
  end;
end;

procedure TOvcFourWaySpinner.WMLButtonUp(var Msg: TWMLButtonUp);
begin
  inherited;
  scDoMouseUp;
end;

procedure TOvcFourWaySpinner.WMSize(var Msg : TWMSize);
begin
  inherited;
  if csDesigning in ComponentState then
    scDrawButton(True);
end;


{*** TOvcStarSpinner ***}

constructor TOvcStarSpinner.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csFramed, csOpaque];

  {defaults}
  Width           := scDefHeight;
  Height          := scDefHeight;
  FDrawStarBorder := scDefDrawStarBorder;
  FForceSquare    := scDefForceSquare;
end;

destructor TOvcStarSpinner.Destroy;
begin
  scDeleteRegions;
  inherited Destroy;
end;

procedure TOvcStarSpinner.DoOnClick(State : TSpinState);
begin
  if Assigned(FOnClick) or (Assigned(FFocusedControl) and
     (FFocusedControl is TOvcBaseEntryField)) then begin
    if scMouseOverBtn then begin
      if LongInt(GetTickCount) > scNextMsgTime then begin              {!!.D4}

        {auto link with Orpheus entry fields}
        if Assigned(FFocusedControl) and
           (FFocusedControl is TOvcBaseEntryField) then begin
          case State of
            ssUpBtn : TOvcBaseEntryField(FFocusedControl).IncreaseValue(FWrapMode, Delta);
            ssDownBtn : TOvcBaseEntryField(FFocusedControl).DecreaseValue(FWrapMode, Delta);
            ssLeftBtn : TOvcBaseEntryField(FFocusedControl).MoveCaret(-1);
            ssRightBtn : TOvcBaseEntryField(FFocusedControl).MoveCaret(+1);
          end;
        end;

        {call OnClick event handler, if assigned}
        if Assigned(FOnClick) then
          FOnClick(Self, State, Delta, FWrapMode);

        {setup for next time}
        scNextMsgTime := LongInt(GetTickCount) + scDefDelayTime -      {!!.D4}
                         Acceleration*10*scRepeatCount;                {!!.D4}
        Inc(scRepeatCount);
      end;
    end;
  end;
end;

procedure TOvcStarSpinner.Paint;
begin
  scDrawButton;
end;

function TOvcStarSpinner.scCheckMousePos : TSpinState;
var
  P           : TPoint;
begin
  GetCursorPos(P);
  P := ScreenToClient(P);

  {see which button the mouse is over}
  Result := ssNone;
  if PtInRect(ClientRect, P) then begin
    if not (csClicked in ControlState) then
      Result := ssNormal

    {mouse is over one of the buttons, which one?}
    else if PtInRegion(scUpRgn, P.X, P.Y) then
      Result := ssUpBtn
    else if PtInRegion(scDownRgn, P.X, P.Y) then
      Result := ssDownBtn
    else if PtInRegion(scLeftRgn, P.X, P.Y) then
      Result := ssLeftBtn
    else if PtInRegion(scRightRgn, P.X, P.Y) then
      Result := ssRightBtn
    else if PtInRegion(scCenterRgn, P.X, P.Y) then
      Result := ssCenterBtn
    else
      Result := ssNormal;
  end;
end;

procedure TOvcStarSpinner.scDeleteRegions;
begin
  if scUpRgn <> 0 then DeleteObject(scUpRgn);
  if scDownRgn <> 0 then DeleteObject(scDownRgn);
  if scLeftRgn <> 0 then DeleteObject(scLeftRgn);
  if scRightRgn <> 0 then DeleteObject(scRightRgn);
  if scCenterRgn <> 0 then DeleteObject(scCenterRgn);
end;

procedure TOvcStarSpinner.scDoAutoRepeat;
var
  NewState : TSpinState;
begin
  DoOnClick(scCurrentState);

  {don't auto-repeat for center button}
  if (scCurrentState = ssCenterBtn) or (not AutoRepeat) then begin
    repeat
      {allow other messages}
      Application.ProcessMessages;

      {until the mouse button is released}
    until (GetAsyncKeyState(scLButton) and $8000) = 0;
    scDoMouseUp;
    Exit;
  end;

  {repeat until left button released}
  repeat
    if AutoRepeat then
      DoOnClick(scCurrentState);

    {allow other messages}
    Application.ProcessMessages;

    {get new button/mouse state}
    NewState := scCheckMousePos;

    {has anything changed}
    if NewState <> scCurrentState then begin
      {the mouse is not over a button or its over a new one}
      scPrevState := scCurrentState;
      scCurrentState := NewState;

      {don't depress the center button if the mouse moves over it}
      if NewState = ssCenterBtn then
        scCurrentState := ssNormal;

      scMouseOverBtn := not (scCurrentState in [ssNone, ssNormal]);

      scInvalidateButton(scPrevState);
      scInvalidateButton(scCurrentState);
    end;

    {until the mouse button is released}
  until (GetAsyncKeyState(scLButton) and $8000) = 0;
  scDoMouseUp;
end;

procedure TOvcStarSpinner.scDoMouseDown(XPos, YPos: Integer);
begin
  scPrevState := scCurrentState;

  {find which button was clicked}
  scCurrentState := scCheckMousePos;
  scMouseOverBtn := True;

  scInvalidateButton(scPrevState);
  scInvalidateButton(scCurrentState);

  {initialize and start repeating}
  scRepeatCount := 0;
  scLButton := GetLeftButton;
  scNextMsgTime := GetTickCount-1;
  scDoAutoRepeat;
end;

procedure TOvcStarSpinner.scDoMouseUp;
begin
  {save last state and redraw}
  scPrevState := scCurrentState;
  scCurrentState := ssNormal;
  scMouseOverBtn := False;

  scInvalidateButton(scPrevState);
  scInvalidateButton(scCurrentState);
end;

procedure TOvcStarSpinner.scDrawButton;
  {-draw the spin button in the current state}
var
  W, H   : Integer;
  W2, H2 : Integer;
  W3, H3 : Integer;
  PC     : TColor;

  procedure DrawBasicShape;
  begin
    with Canvas do begin
      Pen.Color := clWindowFrame;
      Brush.Color := PC;
      Brush.Style := bsSolid;
      Rectangle(0, 0, W, H);
      if DrawStarBorder then begin
        PolyLine([Point(W2-1,0), Point(W3-1,H3-1), Point(0,H2-1)]); {tl}
        PolyLine([Point(W2+1,0), Point(W-W3+1,H3), Point(W,H2-1)]); {tr}
        PolyLine([Point(W,H2+1), Point(W-W3+1,H-H3+1), Point(W2+1,H)]); {br}
        PolyLine([Point(W2-1,H), Point(W3-1,H-H3+1), Point(0,H2+1)]); {bl}
      end;
    end;
  end;

  procedure DrawFace(State : TSpinState; Up : Boolean);
  const
    BtnColor : array[Boolean, 0..1] of TColor = (
      (clBtnShadow, clBtnFace), (clBtnHighlight, clBtnShadow));
  begin
    with Canvas do begin
      case State of
        ssUpBtn    :
          begin
            Pen.Color := BtnColor[Up, 1];
            PolyLine([Point(W2,1), Point(W-W3,H3)]);
            PolyLine([Point(W-W3,H3), Point(W3,H3)]);
            Pen.Color := BtnColor[Up, 0];
            PolyLine([Point(W3,H3), Point(W2,1)]);
          end;
        ssDownBtn  :
          begin
            Pen.Color := BtnColor[Up, 0];
            PolyLine([Point(W2,H-2), Point(W3,H-H3)]);
            PolyLine([Point(W3,H-H3), Point(W-W3,H-H3)]);
            Pen.Color := BtnColor[Up, 1];
            PolyLine([Point(W-W3,H-H3), Point(W2,H-2)]);
          end;
        ssLeftBtn  :
          begin
            Pen.Color := BtnColor[Up, 0];
            PolyLine([Point(1,H2), Point(W3,H3)]);
            Pen.Color := BtnColor[Up, 1];
            PolyLine([Point(W3,H3), Point(W3, H-H3)]);
            PolyLine([Point(W3,H-H3), Point(1,H2)]);
          end;
        ssRightBtn :
          begin
            Pen.Color := BtnColor[Up, 0];
            PolyLine([Point(W-W3,H-H3), Point(W-W3,H3)]);
            Pen.Color := BtnColor[Up, 1];
            PolyLine([Point(W-2,H2), Point(W-W3,H-H3)]);
            PolyLine([Point(W-W3,H3), Point(W-2, H2)]);
          end;
        ssCenterBtn :
          begin
            Pen.Color := BtnColor[Up, 0];
            PolyLine([Point(W3+1,H-H3-1), Point(W3+1,H3+1)]); {left}
            PolyLine([Point(W3+1,H3+1), Point(W-W3-1,H3+1)]); {top}
            Pen.Color := BtnColor[Up, 1];
            PolyLine([Point(W-W3-1,H3+1), Point(W-W3-1,H-H3-1)]);{right}
            PolyLine([Point(W-W3-1,H-H3-1), Point(W3+1,H-H3-1)]);{bottom}
          end;
      end;
    end;
  end;

begin
  {get values for drawing}
  W := Width;
  H := Height;
  W2 := W div 2;
  H2 := H div 2;
  W3 := W div 3;
  H3 := H div 3;

  {get current parent color}
  if Parent is TForm then
    PC := TForm(Parent).Color
  else
    PC := Color;

  with Canvas do begin
    DrawBasicShape;

    DrawFace(ssUpBtn, True);
    DrawFace(ssDownBtn, True);
    DrawFace(ssLeftBtn, True);
    DrawFace(ssRightBtn, True);
    DrawFace(ssCenterBtn, True);

    if scPrevState <> scCurrentState then
      DrawFace(scPrevState, True);
    if scMouseOverBtn then
      DrawFace(scCurrentState, False);
  end;
end;

procedure TOvcStarSpinner.scInvalidateButton(State : TSpinState);
begin
  case State of
    ssUpBtn     : InvalidateRgn(Handle, scUpRgn, False);
    ssDownBtn   : InvalidateRgn(Handle, scDownRgn, False);
    ssLeftBtn   : InvalidateRgn(Handle, scLeftRgn, False);
    ssRightBtn  : InvalidateRgn(Handle, scRightRgn, False);
    ssCenterBtn : InvalidateRgn(Handle, scCenterRgn, False);
  end;
end;

procedure TOvcStarSpinner.scUpdateSizes;
var
  Points : array[0..3] of TPoint;
begin
  {store info about button locations}
  scDeleteRegions;

  {up}
  Points[0] := Point(Width div 2, 0);
  Points[1] := Point(Width - (Width div 3), Height div 3);
  Points[2] := Point(Width div 3, Height div 3);
  scUpRgn := CreatePolygonRgn(Points, 3, ALTERNATE);

  {down}
  Points[0] := Point(Width div 2, Height);
  Points[1] := Point(Width div 3, Height - (Height div 3));
  Points[2] := Point(Width - (Width div 3), Height - (Height div 3));
  scDownRgn := CreatePolygonRgn(Points, 3, ALTERNATE);

  {left}
  Points[0] := Point(0, Height div 2);
  Points[1] := Point(Width div 3, Height div 3);
  Points[2] := Point(Width div 3, Height - (Height div 3));
  scLeftRgn := CreatePolygonRgn(Points, 3, ALTERNATE);

  {right}
  Points[0] := Point(Width, Height div 2);
  Points[1] := Point(Width - (Width div 3), Height - (Height div 3));
  Points[2] := Point(Width - (Width div 3), Height div 3);
  scRightRgn := CreatePolygonRgn(Points, 3, ALTERNATE);

  {center}
  Points[0] := Point(Width div 3, Height div 3);
  Points[1] := Point(Width - (Width div 3), Height div 3);
  Points[2] := Point(Width - (Width div 3), Height - (Height div 3));
  Points[3] := Point(Width div 3, Height - (Height div 3));
  scCenterRgn := CreatePolygonRgn(Points, 4, ALTERNATE);
end;

procedure TOvcStarSpinner.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  if (csDesigning in ComponentState) and not (csLoading in ComponentState) then begin
    {limit smallest size}
    if AWidth < scDefMinSize then
      AWidth := scDefMinSize ;
    if AHeight < scDefMinSize then
      AHeight := scDefMinSize ;

    {force size to odd value}
    if ForceOddSize then begin
      if not Odd(AHeight) then
        AHeight := Succ(AHeight);
      if not Odd(AWidth) then
        AWidth := Succ(AWidth);
    end;

    {force to a square shape}
    if FForceSquare then
      if AWidth < AHeight then
        AHeight := AWidth
      else
        AWidth := AHeight;
  end;

  inherited SetBounds(ALeft, ATop, AWidth, AHeight);

  {update sizes of control and button regions}
  if HandleAllocated then
    scUpdateSizes;
end;

procedure TOvcStarSpinner.SetDrawStarBorder(Value : Boolean);
  {-set the DrawStarBorder property}
begin
  if Value <> FDrawStarBorder then begin
    FDrawStarBorder := Value;
    Repaint;
  end;
end;

procedure TOvcStarSpinner.SetForceSquare(Value : Boolean);
begin
  if Value <> FForceSquare then begin
    FForceSquare := Value;
    if FForceSquare and not (csLoading in ComponentState) then
      SetBounds(Left, Top, Width, Height);  {force resize}
  end;
end;

procedure TOvcStarSpinner.WMSize(var Msg : TWMSize);
begin
  inherited;
  if csDesigning in ComponentState then
    scDrawButton;
end;



end.