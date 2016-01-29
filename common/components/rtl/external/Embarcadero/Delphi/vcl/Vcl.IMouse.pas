{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Vcl.IMouse;

interface

uses
  Vcl.Controls, Vcl.ExtCtrls, Vcl.Graphics, System.Classes,
  Winapi.Messages, Winapi.Windows;

                                                                                  

const
  crPanAll       = TCursor(-50);
  crPanDown      = TCursor(-51);
  crPanDownLeft  = TCursor(-52);
  crPanDownRight = TCursor(-53);
  crPanLeft      = TCursor(-54);
  crPanLeftRight = TCursor(-55);
  crPanRight     = TCursor(-56);
  crPanUp        = TCursor(-57);
  crPanUpDown    = TCursor(-58);
  crPanUpLeft    = TCursor(-59);
  crPanUpRight   = TCursor(-60);

type
  TPanDirection = (pdUp, pdDown, pdLeft, pdRight);
  TPanDirections = set of TPanDirection;

  TPanOption = (poVertical, poHorizontal);
  TPanOptions = set of TPanOption; 

  TUpdateEvent = procedure (Sender: TObject; var Delta: TPoint;
      var CursorDirection: TPanDirections) of object;

  TPanningWindow = class(TCustomPanningWindow)
  private
    FTimer: TTimer;
    FOrg: TPoint;
    FLastPos: TPoint;
    FPanOptions: TPanOptions;
    FPanning: Boolean;
    FImg: TIcon;
    FOldCursor: TCursor;
    FDirection: TPanDirections;
    FImgWidth: Integer;
    FImgHeight: Integer;
    FOnUpdate: TUpdateEvent;
    FPanControl: TControl;
    procedure DoWheelTimer(Sender: TObject);
    procedure MakeImageRegion;
    procedure UpdateCursor(var Pt: TPoint);
    function GetPanInterval: Integer;
    procedure SetPanInterval(const Value: Integer);
    function GetPanControl: TControl;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure DoUpdate(var Delta: TPoint; var CursorDirection: TPanDirections); dynamic;
    function GetPanOptions: TPanOptions; virtual;
    procedure MouseMove(Shift: TShiftState; X: Integer; Y: Integer); override;
    procedure Paint; override;
    procedure SetPanCursor(ADirection: TPanDirections); virtual;
    procedure UpdateScroll(Pt: TPoint); virtual;
    procedure WndProc(var Msg: TMessage); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetIsPanning: Boolean; override;
    function StartPanning(AHandle: THandle; AControl: TControl): Boolean; override;
    procedure StopPanning; override;
    property IsPanning: Boolean read GetIsPanning;
    property PanControl: TControl read GetPanControl;
    property PanInterval: Integer read GetPanInterval write SetPanInterval;
    property PanOptions: TPanOptions read GetPanOptions;
    property OnUpdate: TUpdateEvent read FOnUpdate write FOnUpdate;
  end;

function StartPan(WndHandle: THandle; AControl: TControl): Boolean;

implementation

uses
{$IF DEFINED(CLR)}
  Types, System.Reflection, WinUtils, System.Security.Permissions;
{$ELSE !CLR}
  Vcl.Forms, System.Types;
{$ENDIF CLR}

[UIPermission(SecurityAction.LinkDemand, Window=UIPermissionWindow.AllWindows)]
function StartPan(WndHandle: THandle; AControl: TControl): Boolean;
var
  Panner: TCustomPanningWindow;
begin
  Result := False;
  Panner := Mouse.CreatePanningWindow;
  if Assigned(Panner) then
    Result := Panner.StartPanning(WndHandle, AControl);
end;

procedure StopPan;
begin
  if Assigned(Mouse.PanningWindow) then
    Mouse.PanningWindow := nil;
end;

{$R *.res}

const
  cBound = 8;

{ TPanningWindow }

constructor TPanningWindow.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csOpaque] - [csPannable];
  Brush.Style := bsClear;
  FTimer := TTimer.Create(Self);
  FTimer.Interval := 40;
  FTimer.Enabled := False;
  FImg := TIcon.Create;
end;

destructor TPanningWindow.Destroy;
begin
  StopPanning;
  FTimer.Free;
  FImg.Free;
  inherited Destroy;
end;

procedure TPanningWindow.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    X := 0;
    Y := 0;
    Width := 1;
    Height := 1;
    Style := WS_POPUP;
    if NewStyleControls then
      ExStyle := WS_EX_TOOLWINDOW or WS_EX_LAYERED;
  end;
end;

procedure TPanningWindow.DoUpdate(var Delta: TPoint; var CursorDirection: TPanDirections);
begin
  if Assigned(FOnUpdate) then
    FOnUpdate(Self, Delta, CursorDirection)
  else
  begin
    Delta.X := Delta.X div 2;
    Delta.Y := Delta.Y div 2;
  end;
end;

procedure TPanningWindow.DoWheelTimer(Sender: TObject);
var
  Pt: TPoint;
begin
  Pt := Mouse.CursorPos;
  Winapi.Windows.ScreenToClient(ParentWindow, Pt);

  Dec(Pt.Y, FOrg.Y);
  Dec(Pt.X, FOrg.X);

  UpdateScroll(Pt);
end;

function TPanningWindow.GetIsPanning: Boolean;
begin
  Result := FPanning;
end;

function TPanningWindow.GetPanInterval: Integer;
begin
  Result := FTimer.Interval;
end;

function TPanningWindow.GetPanOptions: TPanOptions;
var
  Style: Longint;
begin
  Result := [];
  Style := GetWindowLong(ParentWindow, GWL_STYLE);
  if Style and WS_HSCROLL <> 0 then
    Include(Result, poHorizontal);
  if Style and WS_VSCROLL <> 0 then
    Include(Result, poVertical);
end;

procedure TPanningWindow.MakeImageRegion;
var
  Rgn: HRGN;
begin
  if Assigned(Vcl.Forms.SetLayeredWindowAttributes) then
    Vcl.Forms.SetLayeredWindowAttributes(Handle, clBlack, 0, LWA_COLORKEY)
  else
  begin
    Rgn := CreateEllipticRgn(3, 3, FImgWidth-1, FImgHeight-1);
    SetWindowRgn(Handle, Rgn, False);
  end;
end;

procedure TPanningWindow.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  Pt: TPoint;
begin
  inherited MouseMove(Shift, X, Y);

  Pt := Mouse.CursorPos;
  Winapi.Windows.ScreenToClient(ParentWindow, Pt);

  Dec(Pt.Y, FOrg.Y);
  Dec(Pt.X, FOrg.X);

  UpdateCursor(Pt);
end;

procedure TPanningWindow.Paint;
begin
  Canvas.Draw(0, 0, FImg);
end;

procedure TPanningWindow.SetPanCursor(ADirection: TPanDirections);
var
  Code: TCursor;
begin
  if FDirection <> ADirection then
  begin
    FDirection := ADirection;
    if ADirection * [pdRight] = [pdRight] then
    begin
      Code := crPanRight;
      if ADirection * [pdUp] = [pdUp] then
      begin
        Code := crPanUpRight;
        if ADirection * [pdLeft, pdDown] = [pdLeft, pdDown] then
          Code := crPanAll;
      end
      else if ADirection * [pdDown] = [pdDown] then
        Code := crPanDownRight
      else if ADirection * [pdLeft] = [pdLeft] then
        Code := crPanLeftRight;
    end
    else if ADirection * [pdLeft] = [pdLeft] then
    begin
      Code := crPanLeft;
      if ADirection * [pdUp] = [pdUp] then
        Code := crPanUpLeft
      else if ADirection * [pdDown] = [pdDown] then
        Code := crPanDownLeft;
    end
    else if ADirection * [pdUp] = [pdUp] then
    begin
      Code := crPanUp;
      if ADirection * [pdDown] = [pdDown] then
        Code := crPanUpDown;
    end
    else if ADirection * [pdDown] = [pdDown] then
      Code := crPanDown
    else
      Exit;

    Winapi.Windows.SetCursor(Screen.Cursors[Code]);
  end;
end;

procedure TPanningWindow.SetPanInterval(const Value: Integer);
begin
  FTimer.Interval := Value;
end;

[UIPermission(SecurityAction.LinkDemand, Window=UIPermissionWindow.AllWindows)]
function TPanningWindow.StartPanning(AHandle: THandle; AControl: TControl): Boolean;
var
  Org: TPoint;
  LRect: TRect;
  Direction: TPanDirections;
  TempPt: TPoint;
begin
  Result := False;
  FPanOptions := [];
  ParentWindow := AHandle;

  FPanControl := AControl;

  FPanOptions := GetPanOptions;
  if FPanOptions = [] then
    Exit;

  Org := Mouse.CursorPos;
  Winapi.Windows.ScreenToClient(ParentWindow, Org);
  FOrg := Org;
  FLastPos := Point(0, 0);

  FTimer.OnTimer := DoWheelTimer;
  FTimer.Enabled := True;
  FOldCursor := Screen.Cursor;
  FDirection := [];

  if not (poVertical in FPanOptions) then
  begin
    FImg.Handle := LoadIcon(hInstance, 'VCL_EW');
    Direction := [pdLeft, pdRight];
  end
  else if not (poHorizontal in FPanOptions) then
  begin
    FImg.Handle := LoadIcon(hInstance, 'VCL_NS');
    Direction := [pdUp, pdDown];
  end
  else
  begin
    FImg.Handle := LoadIcon(hInstance, 'VCL_NESW');
    Direction := [pdLeft, pdRight, pdUp, pdDown];
  end;

  FImgWidth := FImg.Width;
  FImgHeight := FImg.Height;

  LRect := Rect(Org.X-(FImgWidth div 2), Org.Y-(FImgHeight div 2),
	Org.X+(FImgWidth div 2), Org.Y+(FImgHeight div 2));
  TempPt := LRect.TopLeft;
  Winapi.Windows.ClientToScreen(ParentWindow, TempPt);
  LRect.TopLeft := TempPt;
  TempPt := LRect.BottomRight;
  Winapi.Windows.ClientToScreen(ParentWindow, TempPt);
  LRect.BottomRight := TempPt;
  Self.BoundsRect := LRect;

  MakeImageRegion;
  SetPanCursor(Direction);
  SetCaptureControl(Self);
  FPanning := True;
  if Assigned(PanControl) then
    PanControl.ControlState := PanControl.ControlState + [csPanning];
  Visible := True;
  Result := True;
end;

procedure TPanningWindow.StopPanning;
begin
  if FPanning then
  begin
    FPanning := False;
    FTimer.Enabled := False;
    SetCaptureControl(nil);
    Screen.Cursor := FOldCursor;
    if Assigned(PanControl) then
      PanControl.ControlState := PanControl.ControlState - [csPanning];
    Visible := False;
    DestroyHandle;
  end;
end;

procedure TPanningWindow.UpdateCursor(var Pt: TPoint);
var
  Direction: TPanDirections;
  Temp: TPoint;
begin
  Direction := [];

  if not (poVertical in PanOptions) then
    Pt.Y := 0;
  if not (poHorizontal in PanOptions) then
    Pt.X := 0;

  if (Abs(Pt.X) < cBound) and (Abs(Pt.Y) < cBound) then
  begin
    if not (poVertical in PanOptions) then
      Direction := [pdLeft, pdRight]
    else if not (poHorizontal in PanOptions) then
      Direction := [pdUp, pdDown]
    else
      Direction := [pdLeft, pdRight, pdUp, pdDown];
  end
  else
  begin
    if poHorizontal in PanOptions then
    begin
      if Pt.X < -cBound then
        Include(Direction, pdLeft)
      else if Pt.X > cBound then
        Include(Direction, pdRight);
    end;
    if poVertical in PanOptions then
    begin
      if Pt.Y < -cBound then
        Include(Direction, pdUp)
      else if Pt.Y > cBound then
        Include(Direction, pdDown);
    end;
  end;

  Temp := Pt;
  DoUpdate(Pt, Direction);
  FLastPos := Temp;

  if Abs(Pt.X) < Mouse.DragThreshold then
    Pt.X := 0;
  if Abs(Pt.Y) < Mouse.DragThreshold then
    Pt.Y := 0;

  SetPanCursor(Direction);
end;

procedure TPanningWindow.UpdateScroll(Pt: TPoint);
const
  cHorzCode: array [Boolean] of Integer = (SB_LINERIGHT, SB_LINELEFT);
  cVertCode: array [Boolean] of Integer = (SB_LINEDOWN, SB_LINEUP);
var
  I: Integer;
  Code: Integer;
begin
  UpdateCursor(Pt);
  if (poHorizontal in PanOptions) and (Pt.X <> 0) then
  begin
    Code := cHorzCode[Pt.X <= 0];
    for I := 0 to (Abs(Pt.X) div Mouse.DragThreshold) - 1 do
      SendMessage(ParentWindow, WM_HSCROLL, MakeWParam(Code, 0), 0);
  end;

  if (poVertical in PanOptions) and (Pt.Y <> 0) then
  begin
    Code := cVertCode[Pt.Y <= 0];
    for I := 0 to (Abs(Pt.Y) div Mouse.DragThreshold) - 1 do
      SendMessage(ParentWindow, WM_VSCROLL, MakeWParam(Code, 0), 0);
  end;
end;

const
  IDC_PAN_ALL = 'PAN_ALL';
  IDC_PAN_DOWN = 'PAN_DOWN';
  IDC_PAN_DOWNLEFT = 'PAN_DOWNLEFT';
  IDC_PAN_DOWNRIGHT = 'PAN_DOWNRIGHT';
  IDC_PAN_LEFT = 'PAN_LEFT';
  IDC_PAN_LEFTRIGHT = 'PAN_LEFTRIGHT';
  IDC_PAN_RIGHT = 'PAN_RIGHT';
  IDC_PAN_UP = 'PAN_UP';
  IDC_PAN_UPDOWN = 'PAN_UPDOWN';
  IDC_PAN_UPLEFT = 'PAN_UPLEFT';
  IDC_PAN_UPRIGHT = 'PAN_UPRIGHT';

  cCursor: array[0..10] of TIdentMapEntry = (
    (Value: crPanAll;      Name: IDC_PAN_ALL),
    (Value: crPanDown;     Name: IDC_PAN_DOWN),
    (Value: crPanDownLeft; Name: IDC_PAN_DOWNLEFT),
    (Value: crPanDownRight;Name: IDC_PAN_DOWNRIGHT),
    (Value: crPanLeft;     Name: IDC_PAN_LEFT),
    (Value: crPanLeftRight;Name: IDC_PAN_LEFTRIGHT),
    (Value: crPanRight;    Name: IDC_PAN_RIGHT),
    (Value: crPanUp;       Name: IDC_PAN_UP),
    (Value: crPanUpDown;   Name: IDC_PAN_UPDOWN),
    (Value: crPanUpLeft;   Name: IDC_PAN_UPLEFT),
    (Value: crPanUpRight;  Name: IDC_PAN_UPRIGHT)
  );

  cIdentCursor: array[Low(cCursor)..High(cCursor)] of TIdentMapEntry = (
    (Value: crPanAll;      Name: 'crPanAll'),
    (Value: crPanDown;     Name: 'crPanDown'),
    (Value: crPanDownLeft; Name: 'crPanDownLeft'),
    (Value: crPanDownRight;Name: 'crPanDownRight'),
    (Value: crPanLeft;     Name: 'crPanLeft'),
    (Value: crPanLeftRight;Name: 'crPanLeftRight'),
    (Value: crPanRight;    Name: 'crPanRight'),
    (Value: crPanUp;       Name: 'crPanUp'),
    (Value: crPanUpDown;   Name: 'crPanUpDown'),
    (Value: crPanUpLeft;   Name: 'crPanUpLeft'),
    (Value: crPanUpRight;  Name: 'crPanUpRight')
  );

function CursorToIdent(Cursor: Longint; var Ident: string): Boolean;
begin
  Result := IntToIdent(Cursor, Ident, cIdentCursor);
end;

function IdentToCursor(const Ident: string; var Cursor: Longint): Boolean;
begin
  Result := IdentToInt(Ident, Cursor, cIdentCursor);
end;

procedure LoadCursors;
var
  I: Integer;
begin
  for I := Low(cCursor) to High(cCursor) do
    Screen.Cursors[cCursor[I].Value] := LoadCursor(HInstance, cCursor[I].Name);
//  RegisterIntegerConsts(TypeInfo(TCursor), IdentToCursor, CursorToIdent);
end;

procedure DestroyCursors;
{$IF NOT DEFINED(CLR)}
var
  I: Integer;
{$ENDIF}
begin
{$IF NOT DEFINED(CLR)}
  for I := Low(cCursor) to High(cCursor) do
    Screen.Cursors[cCursor[I].Value] := 0;
{$ENDIF}
//  UnregisterIntegerConsts(TypeInfo(TCursor), IdentToCursor, CursorToIdent);
end;

[SecurityPermission(SecurityAction.InheritanceDemand, UnmanagedCode=True)]
procedure TPanningWindow.WndProc(var Msg: TMessage);
begin
  case Msg.Msg of
    CM_CANCELMODE,
    CM_MOUSEWHEEL,
    WM_KILLFOCUS,
    WM_CAPTURECHANGED,
    WM_MBUTTONDOWN,
    WM_LBUTTONDOWN,
    WM_RBUTTONDOWN,
    WM_MOUSEWHEEL,
    WM_CANCELMODE:
    begin
      StopPanning;
      Exit;
    end;
  end;
  inherited WndProc(Msg);
end;

[UIPermission(SecurityAction.LinkDemand, Window=UIPermissionWindow.AllWindows)]
function TPanningWindow.GetPanControl: TControl;
begin
  Result := FPanControl;
end;

initialization
  LoadCursors;
  Vcl.Controls.Mouse.PanningWindowClass := TPanningWindow;

finalization
  DestroyCursors;

end.
