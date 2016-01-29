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
{*                  OVCSPLIT.PAS 2.17                    *}
{*     Copyright 1995-98 (c) TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}


unit OvcSplit;
  {-Splitter component}


interface

uses
  {$IFDEF Win32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF}
  SysUtils, Messages, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, ExtCtrls,
  OvcBase, OvcData;

type
  TSplitterOrientation = (soVertical, soHorizontal);

const
  spDefAllowResize   = True;
  spDefAutoUpdate    = False;
  spDefBorderStyle   = bsNone;
  spDefCtl3D         = True;
  spDefHeight        = 100;
  spDefMargin        = 0;
  spDefOrientation   = soVertical;
  spDefPosition      = 100;
  spDefSectionColor  = clBtnFace;
  spDefSplitterColor = clWindowText;
  spDefSplitterSize  = 3;
  spDefWidth         = 200;

type
  TOvcSection = class;
  TOvcSplitter = class;

  {.Z+}
  TOvcSectionInfo = class(TPersistent)
  protected {private}
    FSplitter : TOvcSplitter;
    FTag      : Integer;
    function GetColor : TColor;
    procedure SetColor(Value : TColor);
  protected
  public
    constructor Create(ASplitter : TOvcSplitter; ATag : Integer);
      virtual;
  published
    property Color : TColor
      read GetColor
      write  SetColor
      stored False;
  end;
  {.Z-}

  TOvcSplitter = class(TOvcBase)
  {.Z+}
  protected {private}
    {property variables}
    FAllowResize   : Boolean;
    FAutoUpdate    : Boolean;
    FBorderStyle   : TBorderStyle;
    FMargin        : Integer;
    FOrientation   : TSplitterOrientation;
    FPosition      : Integer;
    FSection       : array[0..1] of TOvcSection;
    FSection1Info  : TOvcSectionInfo;
    FSection2Info  : TOvcSectionInfo;
    FSplitterColor : TColor;
    FSplitterSize  : Integer;

    {event variables}
    FOnOwnerDraw   : TNotifyEvent;
    FOnResize      : TNotifyEvent;

    {internal variables}
    sCanResize     : Boolean;
    sPos           : TPoint;

    {property methods}
    function GetSection(Index : Integer) : TOvcSection;
    procedure SetAutoUpdate(Value : Boolean);
    procedure SetBorderStyle(Value : TBorderStyle);
    procedure SetMargin(Value : Integer);
    procedure SetOrientation(Value : TSplitterOrientation);
    procedure SetPosition(Value : Integer);
    procedure SetSplitterColor(Value : TColor);
    procedure SetSplitterSize(Value : Integer);

    {internal methods}
    procedure sDrawSplitter(X, Y : Integer);
    procedure sInvalidateSplitter;
    procedure sSetPositionPrim(Value : Integer);
    procedure sSetSectionInfo;

    {VCL control methods}
    procedure CMCtl3DChanged(var Msg : TMessage);
      message CM_CTL3DCHANGED;
    procedure CMDesignHitTest(var Msg : TCMDesignHitTest);
      message CM_DESIGNHITTEST;

    {windows message response methods}
    procedure WMEraseBkGnd(var Msg : TWMEraseBkGnd);
      message WM_ERASEBKGND;
    procedure WMSetCursor(var Msg : TWMSetCursor);
      message WM_SETCURSOR;

  protected
    procedure CreateParams(var Params : TCreateParams);
      override;
    procedure CreateWnd;
      override;
    procedure DoOnResize;
      dynamic;
    procedure DoOnOwnerDraw;
      virtual;
    {$IFDEF Win32}
    function GetChildOwner : TComponent;
      override;
    procedure GetChildren(Proc : TGetChildProc
              {$IFDEF VERSION3}; Root : TComponent {$ENDIF});
      override;
    {$ENDIF}
    procedure MouseDown(Button : TMouseButton; Shift : TShiftState; X, Y : Integer);
      override;
    procedure MouseMove(Shift : TShiftState; X, Y : Integer);
      override;
    procedure MouseUp(Button : TMouseButton; Shift : TShiftState; X, Y : Integer);
      override;
    procedure Paint;
      override;
    procedure ReadState(Reader : TReader);
      override;
    {$IFNDEF Win32}
    procedure WriteComponents(Writer : TWriter);
      override;
    {$ENDIF}

  public
    constructor Create(AOwner : TComponent);
      override;
    destructor Destroy;
      override;
  {.Z-}

    {public methods}
    procedure Center;
      {-position the splitter bar in the middle of the region}

    {public properties}
    property Section[Index : Integer] : TOvcSection
      read GetSection;

  published
    {properties}
    property AllowResize : Boolean
      read FAllowResize
      write FAllowResize
      default spDefAllowResize;

    property AutoUpdate : Boolean
      read FAutoUpdate
      write SetAutoUpdate
      default spDefAutoUpdate;

    property BorderStyle : TBorderStyle
      read FBorderStyle
      write SetBorderStyle
      default spDefBorderStyle;

    property Margin : Integer
      read FMargin
      write SetMargin
      default spDefMargin;

    property Orientation : TSplitterOrientation
      read FOrientation
      write SetOrientation
      default spDefOrientation;

    property Position : Integer
      read FPosition
      write SetPosition;

    property Section1Info  : TOvcSectionInfo
      read FSection1Info
      write FSection1Info;

    property Section2Info  : TOvcSectionInfo
      read FSection2Info
      write FSection2Info;

    property SplitterColor : TColor
      read FSplitterColor
      write SetSplitterColor
      default spDefSplitterColor;

    property SplitterSize : Integer
      read FSplitterSize
      write SetSplitterSize
      default spDefSplitterSize;

    {events}
    property OnOwnerDraw : TNotifyEvent
      read FOnOwnerDraw
      write FOnOwnerDraw;

    property OnResize : TNotifyEvent
      read FOnResize
      write FOnResize;

    {inherited properties}
    property Align;
    property Color;
    property Ctl3D default spDefCtl3D;
    property Enabled;
    property ParentCtl3D;
    property ParentShowHint;
    property ShowHint;
    property Visible;
  end;

  {section to act as parent for components}
  TOvcSection = class(TWinControl)
  {.Z+}
  protected {private}
    {windows message response methods}
    procedure WMNCHitTest(var Msg : TWMNCHitTest);
      message WM_NCHITTEST;
  protected
    procedure ReadState(Reader : TReader);
      override;
  public
    constructor Create(AOwner : TComponent);
      override;
  {.Z-}
  published
    property Color default spDefSectionColor;
    property Height stored False;
    property Left stored False;
    property Top stored False;
    property Width stored False;
  end;



implementation


{*** TOvcSectionInfo ***}

constructor TOvcSectionInfo.Create(ASplitter : TOvcSplitter; ATag : Integer);
begin
  inherited Create;

  FTag := ATag;
  FSplitter := ASplitter;
end;

function TOvcSectionInfo.GetColor : TColor;
begin
  Result := FSplitter.FSection[FTag-1].Color;
end;

procedure TOvcSectionInfo.SetColor(Value : TColor);
begin
  FSplitter.FSection[FTag-1].Color := Value;
end;


{*** TOvcSection ***}

constructor TOvcSection.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);

  ControlStyle := ControlStyle + [csAcceptsControls];

  Color := spDefSectionColor;
end;

procedure TOvcSection.ReadState(Reader : TReader);
var
{$IFNDEF Win32}
  OldOwner : TComponent;
{$ENDIF}
  S        : TOvcSplitter;
begin
  {$IFDEF Win32}
  inherited ReadState(Reader);
  {$ELSE}
  {change reader so the parent form is the owner of the contained controls}
  OldOwner := Reader.Owner;
  Reader.Owner := Reader.Root;
  try
    inherited ReadState(Reader);
  finally
    Reader.Owner := OldOwner;
  end;
  {$ENDIF}

  if Reader.Parent is TOvcSplitter then begin
    S := TOvcSplitter(Reader.Parent);
    if Assigned(S.FSection[Tag-1]) then
      S.FSection[Tag-1].Free;
    S.FSection[Tag-1] := Self;
  end;
end;

procedure TOvcSection.WMNCHitTest(var Msg : TWMNCHitTest);
begin
  if not (csDesigning in ComponentState) then
    Msg.Result := HTTRANSPARENT
  else
    inherited;
end;


{*** TOvcSplitter ***}

procedure TOvcSplitter.Center;
begin
  case Orientation of
    soHorizontal : Position := (ClientHeight - SplitterSize) div 2;
    soVertical   : Position := (ClientWidth - SplitterSize) div 2;
  end;
end;

procedure TOvcSplitter.CMCtl3DChanged(var Msg : TMessage);
begin
  inherited;

  if (csLoading in ComponentState) then
    Exit;

  {update section size and position}
  sSetSectionInfo;

  Refresh;
end;

procedure TOvcSplitter.CMDesignHitTest(var Msg : TCMDesignHitTest);
begin
  if sCanResize then
    Msg.Result := 1
  else
    inherited;
end;

constructor TOvcSplitter.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Ctl3D  := spDefCtl3D;
  Height := spDefHeight;
  Width  := spDefWidth;

  {$IFDEF Win32}                                                       {!!.12}
  Exclude(FComponentStyle, csInheritable);                             {!!.12}
  {$ENDIF}                                                             {!!.12}

  if Classes.GetClass(TOvcSection.ClassName) = nil then
    Classes.RegisterClass(TOvcSection);

  FSection[0] := TOvcSection.Create(Self);
  FSection[0].Tag := 1;
  FSection[0].ParentCtl3D := True;
  FSection[0].Color := spDefSectionColor;
  FSection[0].Parent := Self;
  FSection1Info := TOvcSectionInfo.Create(Self, 1);

  FSection[1] := TOvcSection.Create(Self);
  FSection[1].Tag := 2;
  FSection[1].ParentCtl3D := True;
  FSection[1].Color := spDefSectionColor;
  FSection[1].Parent := Self;
  FSection2Info := TOvcSectionInfo.Create(Self, 2);

  FAllowResize   := spDefAllowResize;
  FAutoUpdate    := spDefAutoUpdate;
  FBorderStyle   := spDefBorderStyle;
  FMargin        := spDefMargin;
  FOrientation   := spDefOrientation;
  FPosition      := spDefWidth div 2;
  FSplitterColor := spDefSplitterColor;
  FSplitterSize  := spDefSplitterSize;

  sPos.X := -1;
  sPos.Y := -1;
end;

procedure TOvcSplitter.CreateParams(var Params : TCreateParams);
begin
  inherited CreateParams(Params);

  Params.Style := LongInt(Params.Style) or BorderStyles[FBorderStyle]; {!!.D4}
end;

procedure TOvcSplitter.CreateWnd;
begin
  inherited CreateWnd;

  {update section size and position}
  sSetSectionInfo;
end;

destructor TOvcSplitter.Destroy;
var
  I : Integer;
begin
  for I := 0 to 1 do begin
    FSection[I].Free;
    Fsection[I] := nil;
  end;

  FSection1Info.Free;
  FSection1Info := nil;
  FSection2Info.Free;
  FSection1Info := nil;

  inherited Destroy;
end;

procedure TOvcSplitter.DoOnOwnerDraw;
begin
  if Assigned(FOnOwnerDraw) then
    FOnOwnerDraw(Self);
end;

procedure TOvcSplitter.DoOnResize;
begin
  if Assigned(FOnResize) then
    FOnResize(Self);
end;

{$IFDEF Win32}
function TOvcSplitter.GetChildOwner : TComponent;
begin
  Result := Self;
end;

procedure TOvcSplitter.GetChildren(Proc : TGetChildProc
          {$IFDEF VERSION3}; Root : TComponent {$ENDIF});
var
  I : Integer;
begin
  for I := 0 to 1 do
    Proc(TControl(FSection[I]));
end;
{$ENDIF}

function TOvcSplitter.GetSection(Index : Integer) : TOvcSection;
begin
  case Index of
    0 : Result := FSection[0];
    1 : Result := FSection[1];
  else
    Result := nil;
  end;
end;

procedure TOvcSplitter.MouseDown(Button : TMouseButton; Shift : TShiftState; X, Y : Integer);
begin
  inherited MouseDown(Button, Shift, X, Y);

  if sCanResize then begin
    if (Button = mbLeft) then begin
      SetCapture(Handle);
      sDrawSplitter(X, Y);
    end;
  end;
end;

procedure TOvcSplitter.MouseMove(Shift : TShiftState; X, Y : Integer);
begin
  inherited MouseMove(Shift, X, Y);

  case Orientation of
    soHorizontal :
      if (Y < Margin) or (Y > ClientHeight - Margin) or (Y = Position) then
        Exit;
    soVertical   :
      if (X < Margin) or (X > ClientWidth - Margin) or (X = Position) then
        Exit;
  end;

  if (GetCapture = Handle) and sCanResize then begin
    sDrawSplitter(X, Y);

    if AutoUpdate then
      {update section size and position}
      sSetSectionInfo;
  end;
end;

procedure TOvcSplitter.MouseUp(Button : TMouseButton; Shift : TShiftState; X, Y : Integer);
begin
  if sCanResize then begin
    ReleaseCapture;
    sCanResize := False;
    sDrawSplitter(-1, -1); {erase}

    {update Section size and position}
    sSetSectionInfo;
    Refresh;

    DoOnResize;
  end;

  inherited MouseUp(Button, Shift, X, Y);
end;

procedure TOvcSplitter.Paint;
var
  M      : Integer;
  P, P1  : Integer;
  S, S1  : Integer;
  CW, CH : Integer;
begin
  {update section size and position}
  sSetSectionInfo;

  if Assigned(FOnOwnerDraw) then begin
    DoOnOwnerDraw;
    Exit;
  end;

  M  := Margin;
  P  := Position;
  P1 := Position-1;
  CW := ClientWidth;
  CH := ClientHeight;
  S  := SplitterSize;
  S1 := SplitterSize-1;

  {erase margin area}
  if Margin > 0 then begin
    Canvas.Brush.Color := Color;
    Canvas.FillRect(Rect(0, 0, M, CH)); {left}
    Canvas.FillRect(Rect(M, 0, CW-M, M)); {top}
    Canvas.FillRect(Rect(CW-M, 0, CW, CH)); {right}
    Canvas.FillRect(Rect(M, CH-M, CW-M, CH)); {bottom}
  end;

  if not Ctl3D then begin
    Canvas.Pen.Color := SplitterColor;
    Canvas.Brush.Color := SplitterColor;
    case Orientation of
      soHorizontal : Canvas.Rectangle(M, P, CW-M, P+S);
      soVertical   : Canvas.Rectangle(P, M, P+S, CH-M);
    end;
    Exit;
  end;

  Canvas.Brush.Color := Color;

  {draw highlight border (right and bottom of each section)}
  Canvas.Pen.Color := clBtnHighlight;
  case Orientation of
    soHorizontal :
      begin
        Canvas.PolyLine([Point(M, P1),
                         Point(CW-M-1, P1),
                         Point(CW-M-1, M-1)]);
        Canvas.PolyLine([Point(M, CH-M-1),
                         Point(CW-M-1, CH-M-1),
                         Point(CW-M-1, P+S1)]);
      end;
    soVertical   :
      begin
        Canvas.PolyLine([Point(M, CH-M-1),
                         Point(P1, CH-M-1),
                         Point(P1, M-1)]);
        Canvas.PolyLine([Point(P+S1, CH-M-1),
                         Point(CW-M-1, CH-M-1),
                         Point(CW-M-1, M-1)]);
      end;
  end;

  {draw shadow border (left and top of each section)}
  Canvas.Pen.Color := clBtnShadow;
  case Orientation of
    soHorizontal :
      begin
        Canvas.PolyLine([Point(M, P1-1),
                         Point(M, M),
                         Point(CW-M-1, M)]);
        Canvas.PolyLine([Point(M, CH-M-2),
                         Point(M, P+S),
                         Point(CW-M-1, P+S)]);
      end;
    soVertical   :
      begin
        Canvas.PolyLine([Point(M, CH-M-2),
                         Point(M, M),
                         Point(P1, M)]);
        Canvas.PolyLine([Point(P+S, CH-M-2),
                         Point(P+S, M),
                         Point(CW-M-1, M)]);
      end;
  end;

  {draw border (left and top of each section)}
  Canvas.Pen.Color := clBlack;
  case Orientation of
    soHorizontal :
      begin
        Canvas.PolyLine([Point(M+1, P1-1),
                         Point(M+1, M+1),
                         Point(CW-M-1, M+1)]);
        Canvas.PolyLine([Point(M+1, CH-M-2),
                         Point(M+1, P+S+1),
                         Point(CW-M-1, P+S+1)]);
      end;
    soVertical   :
      begin
        Canvas.PolyLine([Point(M+1, CH-M-2),
                         Point(M+1, M+1),
                         Point(P-1, M+1)]);
        Canvas.PolyLine([Point(P+S+1, CH-M-2),
                         Point(P+S+1, M+1),
                         Point(CW-M-1, M+1)]);
      end;
  end;

  Canvas.Pen.Color := Color;
  Canvas.Brush.Color := Color;
  case Orientation of
    soHorizontal : Canvas.Rectangle(M, P, CW-M, P+S);
    soVertical   : Canvas.Rectangle(P, M, P+S, CH-M);
  end;
end;

procedure TOvcSplitter.ReadState(Reader : TReader);
{$IFNDEF Win32}
var
  OldOwner : TComponent;
{$ENDIF}
begin
  {$IFDEF Win32}
  inherited ReadState(Reader);
  {$ELSE}
  {change reader owner so the sections are owned by the splitter}
  OldOwner := Reader.Owner;
  Reader.Owner := Self;
  try
    inherited ReadState(Reader);
  finally
    Reader.Owner := OldOwner;
  end;
  {$ENDIF}
end;

procedure TOvcSplitter.sDrawSplitter(X, Y : Integer);
begin
  if AutoUpdate and (X > -1) and (Y > -1) then begin
    sInvalidateSplitter;
    case Orientation of
      soHorizontal : sSetPositionPrim(Y);
      soVertical   : sSetPositionPrim(X);
    end;
    sInvalidateSplitter;
    Exit;
  end;

  {do we need to erase first?}
  if (sPos.X > -1) or (sPos.Y > -1) then begin
    case Orientation of
      soHorizontal :
        PatBlt(Canvas.Handle, Margin, sPos.Y, ClientWidth-2*Margin, SplitterSize, DSTINVERT);
      soVertical   :
        PatBlt(Canvas.Handle, sPos.X, Margin, SplitterSize, ClientHeight-2*Margin, DSTINVERT);
    end;
  end;

  {record new position}
  sPos.X := X;
  sPos.Y := Y;

  if not sCanResize then
    Exit;

  case Orientation of
    soHorizontal :
      begin
        sSetPositionPrim(sPos.Y);
        sPos.Y := Position;
        PatBlt(Canvas.Handle, Margin, Position, ClientWidth-2*Margin, SplitterSize, DSTINVERT);
      end;
    soVertical   :
      begin
        sSetPositionPrim(sPos.X);
        sPos.X := Position;
        PatBlt(Canvas.Handle, Position, Margin, SplitterSize, ClientHeight-2*Margin, DSTINVERT);
      end;
  end;
end;

procedure TOvcSplitter.sInvalidateSplitter;
var
  R : TRect;
begin
  case Orientation of
    soHorizontal : R := Rect(Margin, Position-2, Margin+ClientWidth-2*Margin, Position+SplitterSize+2);
    soVertical   : R := Rect(Position-2, Margin, Position+SplitterSize+2, Margin+ClientHeight-2*Margin);
  end;
  InvalidateRect(Handle, @R, True);
  if Handle <> 0 then {};
end;

procedure TOvcSplitter.SetAutoUpdate(Value : Boolean);
begin
  if (Value <> FAutoUpdate) then
    FAutoUpdate := Value;
end;

procedure TOvcSplitter.SetBorderStyle(Value : TBorderStyle);
begin
  if (Value <> FBorderStyle) then begin
    FBorderStyle := Value;
    RecreateWnd;
  end;
end;

procedure TOvcSplitter.SetMargin(Value : Integer);
begin
  if (Value <> FMargin) and (Value >= 0) then begin
    if (csLoading in ComponentState) then begin
      FMargin := Value;
      Exit;
    end;

    if not HandleAllocated then
      Exit;

    case Orientation of
      soHorizontal :
        if 2*Value > ClientHeight - SplitterSize -2 then
          Exit;
      soVertical   :
        if 2*Value > ClientWidth - SplitterSize -2 then
          Exit;
    end;

    FMargin := Value;

    {force position to readjust}
    sSetPositionPrim(FPosition);

    {update Section size and position}
    sSetSectionInfo;
    Refresh;
  end;
end;

procedure TOvcSplitter.SetOrientation(Value : TSplitterOrientation);
begin
  if (Value <> FOrientation) then begin
    FOrientation := Value;

    if (csLoading in ComponentState) then
      Exit;

    if not HandleAllocated then
      Exit;

    {force position to readjust}
    sSetPositionPrim(FPosition);

    {update Section size and position}
    sSetSectionInfo;
    Refresh;
  end;
end;

procedure TOvcSplitter.SetPosition(Value : Integer);
begin
  if (csLoading in ComponentState) then begin
    FPosition := Value;
    Exit;
  end;

  if not HandleAllocated then
    Exit;

  sSetPositionPrim(Value);
  Refresh;

  DoOnResize;
end;

procedure TOvcSplitter.SetSplitterColor(Value : TColor);
begin
  {color to use if not Ctl3D}
  if (Value <> FSplitterColor) then begin
    FSplitterColor := Value;
    Refresh;
  end;
end;

procedure TOvcSplitter.SetSplitterSize(Value : Integer);
begin
  if (Value <> FSplitterSize) then begin
    FSplitterSize := Value;

    if (csLoading in ComponentState) then
      Exit;

    if not HandleAllocated then
      Exit;

    {update Section size and position}
    sSetSectionInfo;
    Refresh;
  end;
end;

procedure TOvcSplitter.sSetPositionPrim(Value : Integer);
var
  MinPos : Integer;
  MaxPos : Integer;
  PF     : TForm;
begin
  MinPos := Margin + 2;
  case Orientation of
    soHorizontal :
      begin
        MaxPos := ClientHeight - Margin - SplitterSize - 2;
        if Value < MinPos then
          Value := MinPos;
        if Value > MaxPos then
          Value := MaxPos;
        FPosition := Value;
      end;
    soVertical :
      begin
        MaxPos := ClientWidth - Margin - SplitterSize - 2;
        if Value < MinPos then
          Value := MinPos;
        if Value > MaxPos then
          Value := MaxPos;
        FPosition := Value;
      end;
  end;

  {notify the designer of the change}
  if csDesigning in ComponentState then begin
    PF := TForm(GetParentForm(Self));
    if Assigned(PF) and (PF.Designer <> nil) then
      PF.Designer.Modified;
  end;
end;

procedure TOvcSplitter.sSetSectionInfo;
var
  M      : Integer;
  P      : Integer;
  S      : Integer;
  CW, CH : Integer;
begin
  if (csLoading in ComponentState) then
    Exit;

  if not HandleAllocated then
    Exit;

  M  := Margin;
  P  := Position;
  CW := ClientWidth;
  CH := ClientHeight;
  S  := SplitterSize;

  if Ctl3D then begin
    case Orientation of
      soHorizontal :
        begin
          FSection[0].SetBounds(M+2, M+2, CW-2*M-3, P-M-3);
          FSection[1].SetBounds(M+2, P+S+2, CW-2*M-3, CH-P-S-M-3);
        end;
      soVertical :
        begin
          FSection[0].SetBounds(M+2, M+2, P-M-3, CH-2*M-3);
          FSection[1].SetBounds(P+S+2, M+2, CW-P-S-M-3, CH-2*M-3);
        end;
    end;
  end else begin
    case Orientation of
      soHorizontal :
        begin
          FSection[0].SetBounds(M, M, CW-2*M, P-M);
          FSection[1].SetBounds(M, P+S, CW-2*M, CH-P-S-M);
        end;
      soVertical :
        begin
          FSection[0].SetBounds(M, M, P-M, CH-2*M);
          FSection[1].SetBounds(P+S, M, CW-P-S-M, CH-2*M);
        end;
    end;
  end;
end;

procedure TOvcSplitter.WMEraseBkGnd(var Msg : TWMEraseBkGnd);
begin
  Msg.Result := 1  {don't erase background}
end;

{!!.12} {revised}
procedure TOvcSplitter.WMSetCursor(var Msg : TWMSetCursor);
var
  Cur : hCursor;
  P   : TPoint;
begin
  Cur := 0;

  if Msg.HitTest = HTCLIENT then begin
    GetCursorPos(P);
    P := ScreenToClient(P);
    {are we over the split region?}
    case Orientation of
      soHorizontal : if Abs(Position - P.Y) <= SplitterSize then
        Cur := Screen.Cursors[crVSplit];
      soVertical   : if Abs(Position - P.X) <= SplitterSize then
        Cur := Screen.Cursors[crHSplit];
    end;
  end;

  sCanResize := (FAllowResize or (csDesigning in ComponentState)) and (Cur <> 0);
  if sCanResize then
    SetCursor(Cur)
  else
    inherited;
end;

{$IFNDEF Win32}
procedure TOvcSplitter.WriteComponents(Writer : TWriter);
var
  I : Integer;
begin
  for I := 0 to 1 do
    Writer.WriteComponent(FSection[I]);
end;
{$ENDIF}



end.