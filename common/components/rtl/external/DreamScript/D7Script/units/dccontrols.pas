{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dccontrols;
{$I dc.inc}

interface
uses
  {$IFNDEF CLX}
  windows, forms, controls, graphics, messages, extctrls,
  {$ELSE}
  Types, Qt, QForms, QControls, QGraphics, QExtctrls,
  {$ENDIF}
  classes, dcdreamlib;

type
  THintState = (hsShow, hsHide, hsBeginShow);

  TDCHint = class(TComponent)
  private
    FAutoHide         : boolean;
    FHintWindow       : THintWindow;
    FHintTimer        : TTimer;
    FHintRect         : TRect;
    FBoldFont         : TFont;
    FCaption          : string;
    FHintState        : THintState;
    FTimerDelay       : integer;
    FImmediate        : boolean;
    FHintDelta        : integer;
    FOnVisibleChanged : TNotifyEvent;
    FVersion          : TDCVersion;

    function  GetInterval : integer;
    procedure SetInterval(Value : integer);
    function  GetVisible : boolean;
    procedure SetVisible(Value : boolean);
    procedure SetBoldFont(Value : TFont);
    procedure SetCaption(Value : string);
    procedure OnHintTimer(Sender: TObject);
    procedure HideHintWindow;
    procedure DrawHintWindow;
    procedure FontChanged(Sender : TObject);
  protected
    procedure ExecHintTimer; virtual;
    procedure VisibleChanged; virtual;
    function  IsHintInRect(R : TRect; Point : TPoint) : boolean; virtual;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy;  override;
    procedure ActivateHintAtPos(const Point : TPoint; const S : string);
    procedure ActivateHint(const S : string);
    procedure CancelHint;
    property  HintWindow  : THintWindow read FHintWindow;
    function  GetSize(const S : string) : TSize;
  published
    property AutoHide  : boolean read FAutoHide write FAutoHide default true;
    property Interval  : integer read GetInterval write SetInterval;
    property Immediate : boolean read FImmediate write FImmediate;
    property BoldFont  : TFont read  FBoldFont write SetBoldFont;
    property Visible   : boolean read GetVisible write SetVisible;
    property Caption   : string read FCaption write SetCaption;
    property Version : TDCVersion read FVersion write FVersion stored false;
    property OnVisibleChanged : TNotifyEvent read FOnVisibleChanged write FOnVisibleChanged;
  end;

  TBkgndOption = (boNone, boStretch , boCenter, boTile, boHorzGradient, boVertGradient);

  TControlBackground = class(TPersistent)
  private
    FOwner              : TCustomControl;
    FBackground         : TBitmap;
    FBkgndOption        : TBkgndOption;
    FGradientBeginColor : TColor;
    FGradientEndColor   : TColor;
    FTempBackground     : TBitmap;
    procedure SetBackground(Value : TBitmap);
    procedure SetBkgndOption(Value : TBkgndOption);
    procedure SetGradientBeginColor(Value : TColor);
    procedure SetGradientEndColor(Value : TColor);
  protected
    procedure BackgroundChanged(Sender : TObject);
    function  GetPaintRect : TRect; virtual;
    function  GetPaintBrush : TBrush; virtual;
  public
    function  NeedPaint : boolean;
    procedure Assign(Source : TPersistent); override;
    constructor Create(Owner : TCustomControl);
    destructor Destroy; override;
    procedure PaintBackground; virtual;
    property Owner : TCustomControl read FOwner;
    property  TempBackground : TBitmap read FTempBackground;
  published
    property Background : TBitmap read FBackground write SetBackground;
    property BkgndOption : TBkgndOption read FBkgndOption write SetBkgndOption default boNone;
    property GradientBeginColor : TColor read FGradientBeginColor write SetGradientBeginColor default clBlue;
    property GradientEndColor : TColor read FGradientEndColor write SetGradientEndColor default clBlack;
  end;

  TLeftRightAlign = (lrLeftJustify, lrRightJustify);

function CalcStringSize(Canvas : TCanvas; Font , BoldFont : TFont ; const S : string) : TSize;
function ExtractColumn(const S : string; var Pos: Integer): string;
function GetStringExtent(Canvas : TCanvas; const S : string) : TSize;
function ExtractBoldPos(const S : string; var BoldPos , BoldLen : integer): string;
procedure DrawWithSelection(Canvas : TCanvas; Font , BoldFont : TFont ; Rect : TRect;
          const S : string; BoldPos, BoldLen : integer ; Align : TLeftRightAlign);
procedure FillGradient(Canvas : TCanvas; Width, Height : integer; StartColor, EndColor : TColor; IsVertical : boolean);
procedure PaintExpandCollapse(Canvas : TCanvas; X, Y, ASize, AIndent : integer; Value : boolean);


implementation
type
  TMCanvas = class(TCanvas);
const
  HintSpace = 4;

type

  TDCHintWindow = class(THintWindow)
  private
    FBoldFont       : TFont;
    FDisableUpdate  : Boolean;
    FStrings        : TStrings;
    function  CalcSize(const s : string) : TSize;
    procedure DrawBorder;
  protected
    procedure Paint; override;
    {$IFNDEF CLX}
    procedure CreateWnd; override;
    procedure WMNCPaint(var Message: TMessage); message WM_NCPAINT;
    procedure WMERASEBKGND(var Message: TMessage); message WM_ERASEBKGND;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    {$ELSE}
    procedure TextChanged; override;
    procedure CreateWidget; override;
    {$ENDIF}
    procedure UpdateSize;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure ActivateHint(Rect: TRect; const AHint: string); override;
  end;


{-----------TDCHintWindow--------------------------------------}

constructor TDCHintWindow.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  FBoldFont := TFont.Create;
  FStrings  := TStringList.Create;
end;

{-----------------------------------------------------------}

destructor TDCHintWindow.Destroy;
begin
  FBoldFont.Free;
  FStrings.Free;
  inherited Destroy;
end;

{-----------------------------------------------------------}
{$IFNDEF CLX}
procedure TDCHintWindow.CreateWnd;
begin
  inherited CreateWnd;
  Color := Application.HintColor;
  FBoldFont.Assign(Canvas.Font);
  FBoldFont.Style := [fsBold];
end;

{-----------------------------------------------------------}

procedure TDCHintWindow.WMERASEBKGND(var Message: TMessage);
begin
  inherited;
end;

{-----------------------------------------------------------}

procedure TDCHintWindow.WMNCPaint(var Message: TMessage);
begin
  DrawBorder;
end;

{-----------------------------------------------------------}

procedure TDCHintWindow.CMTextChanged(var Message: TMessage);
begin
  if FDisableUpdate  then
    Exit;
  UpdateSize;
end;
{$ELSE}

{-----------------------------------------------------------}

procedure TDCHintWindow.CreateWidget;
begin
  inherited;
  Color := Application.HintColor;
  FBoldFont.Assign(Canvas.Font);
  FBoldFont.Style := [fsBold];
end;

{-----------------------------------------------------------}

procedure TDCHintWindow.TextChanged;
begin
  inherited;
  if FDisableUpdate  then
    Exit;
  UpdateSize;
end;

{$ENDIF}

{-----------------------------------------------------------}

procedure TDCHintWindow.DrawBorder;
{$IFNDEF CLX}
var
  DC :  HDC;
  R  : TRect;
{$ENDIF}
begin
{$IFNDEF CLX}
  DC := GetWindowDC(Handle);
  try
    R := Rect(0, 0, Width, Height);
    DrawEdge(DC, R, BDR_RAISEDOUTER, BF_RECT);
  finally
    ReleaseDC(Handle, DC);
  end;
{$ENDIF}
end;

{-----------------------------------------------------------}

procedure TDCHintWindow.Paint;
var
  R       : TRect;
  S       : string;
  i       : integer;
  BoldPos : integer;
  BoldLen : integer;
begin
  Canvas.Font.Color := clInfoText;

  with Canvas do
  begin

    R := ClientRect;
    inc(R.Left, 2);
    with FStrings do
      if Count <> 0 then
        for i := 0 to Count - 1 do
        begin
          S := ExtractBoldPos(Strings[i], BoldPos , BoldLen);
          DrawWithSelection(Canvas, Font , FBoldFont, R, S, BoldPos, BoldLen, lrLeftJustify);
          inc(R.Top, integer(Objects[i]));
        end
      else
      begin
        S := ExtractBoldPos(Caption , BoldPos , BoldLen);
        DrawWithSelection(Canvas, Font , FBoldFont, R, S, BoldPos, BoldLen, lrLeftJustify);
      end;
  end;
  DrawBorder;
end;

{-----------------------------------------------------------}

function  TDCHintWindow.CalcSize(const s : string) : TSize;
var
  P    : integer;
  i    : integer;
  R    : TRect;
  Size : TSize;

  {---------------------------------------------}

  function GetStringSize(const s : string) : TSize;
  begin
    result := CalcStringSize(Canvas, Canvas.Font , FBoldFont, s);
    inc(result.cx, HintSpace * 2);
  end;

  {---------------------------------------------}

begin
  P := Pos(SReturn , s);
  FStrings.Clear;
  if P <> 0 then
  begin
    R := Rect(0, 0, 0, 0);
    {$IFNDEF CLX}
    DrawText(Canvas.Handle, PChar(s), Length(s), R, DT_CALCRECT);
    {$ELSE}
    Canvas.TextRect(R, 0, 0, s);
    {$ENDIF}
    result.cy := R.Bottom;
    result.cx := 0;
    with FStrings do
    begin
      Text := s;
      for i := 0 to Count - 1 do
      begin
        Size := GetStringSize(Strings[i]);
        Objects[i] := Pointer(Size.cy);
        result.cx := Max(result.cx, Size.cx);
      end;
    end;
  end
  else
    result := CalcStringSize(Canvas, Canvas.Font , FBoldFont, s);
end;

{-----------------------------------------------------------}

procedure TDCHintWindow.UpdateSize;
var
  Size : TSize;
begin
  if HandleAllocated then
  begin
    Size := CalcSize(Caption);
    Width := Size.cx + 4 ;
    Height := Size.cy + 4;
  end;
end;

{-----------------------------------------------------------}

procedure TDCHintWindow.ActivateHint(Rect: TRect; const AHint: string);
begin
  FDisableUpdate := Caption = AHint;
  try
    Caption := AHint;
    Inc(Rect.Bottom, 4);
    UpdateBoundsRect(Rect);
    if Rect.Top + Height > Screen.Height then
      Rect.Top := Screen.Height - Height;
    if Rect.Left + Width > Screen.Width then
      Rect.Left := Screen.Width - Width;
    if Rect.Left < 0 then
      Rect.Left := 0;
    if Rect.Bottom < 0 then
      Rect.Bottom := 0;
    {$IFNDEF CLX}
    SetWindowPos(Handle, HWND_TOPMOST, Rect.Left, Rect.Top, Width, Height,
                 SWP_SHOWWINDOW or SWP_NOACTIVATE);
    {$ELSE}
    with Rect do
      SetBounds(Left, Top, Right - Left, Bottom - Top);
    {$ENDIF}
//    Invalidate;
  finally
    FDisableUpdate := False;
  end;
end;


{-----------TDCHint-------------------------------------------}

constructor TDCHint.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  FHintTimer := TTimer.Create(self);
  FHintTimer.Enabled  := false;
  FHintTimer.Interval := 50;
  FHintTimer.OnTimer  := OnHintTimer;
  FHintWindow := TDCHintWindow.Create(Self);
  FAutoHide := true;
  FImmediate := true;
  FBoldFont := TFont.Create;
  FBoldFont.Assign(FHintWindow.Canvas.Font);
  FBoldFont.Style := [fsBold];
  FBoldFont.OnChange := FontChanged;
end;

{-----------------------------------------------------------}

destructor TDCHint.Destroy;
begin
  FBoldFont.Free;
  inherited Destroy;
end;

{-----------------------------------------------------------}

function  TDCHint.GetInterval : integer;
begin
  result := FHintTimer.Interval;
end;

{-----------------------------------------------------------}

procedure TDCHint.SetInterval(Value : integer);
begin
  FHintTimer.Interval := Value;
end;

{-----------------------------------------------------------}

procedure TDCHint.ActivateHint(const S : string);
var
  Point : TPoint;
begin
  GetCursorPos(Point);
  ActivateHintAtPos(Point, S);
  FHintDelta := 20;//GetSystemMetrics(SM_CYCURSOR);
end;

{-----------------------------------------------------------}

function  TDCHint.GetVisible : boolean;
begin
  {$IFNDEF CLX}
  result := IsWindowVisible(FHintWindow.Handle);
  {$ELSE}
  result := QWidget_isVisible(FHintWindow.Handle);
  {$ENDIF}
end;

{-----------------------------------------------------------}

procedure TDCHint.SetVisible(Value : boolean);
begin
  if Value <> GetVisible then
    if Value then
      ActivateHint(FCaption)
    else
      CancelHint;
end;

{-----------------------------------------------------------}

procedure TDCHint.SetCaption(Value : string);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    if Visible then
    begin
      FHintWindow.Caption := Value;
      FHintWindow.Repaint;
    end;
  end;
end;

{-----------------------------------------------------------}

procedure TDCHint.SetBoldFont(Value : TFont);
begin
  FBoldFont.Assign(Value);
  FontChanged(Self);
end;

{-----------------------------------------------------------}

procedure TDCHint.FontChanged(Sender : TObject);
begin
  TDCHintWindow(FHintWindow).FBoldFont.Assign(FBoldFont);
end;

{-----------------------------------------------------------}

function  TDCHint.GetSize(const S : string) : TSize;
begin
  with TDCHintWindow(FHintWindow) do
    result := CalcSize(s);
  inc(result.Cx, HintSpace * 2);  
end;

{-----------------------------------------------------------}

procedure TDCHint.ActivateHintAtPos(const Point : TPoint; const S : string);
var
  ASize   : TSize;
begin
  if S = '' then
    CancelHint
  else
  begin
    with TDCHintWindow(FHintWindow) do
      ASize := CalcSize(S);
    with Point do
      FHintRect := Rect(X, Y, X + ASize.cx + HintSpace * 2, Y + ASize.cy);
    FHintTimer.Enabled := true;
    FHintState := hsBeginShow;
    FCaption := S;
    if Immediate then
      ExecHintTimer;
  end;
  FHintDelta := 0;
end;

{-----------------------------------------------------------}

procedure TDCHint.OnHintTimer(Sender: TObject);
begin
  ExecHintTimer;
end;

{-----------------------------------------------------------}

procedure TDCHint.VisibleChanged;
begin
  if Assigned(FOnVisibleChanged) then
    FOnVisibleChanged(Self);
end;

{-----------------------------------------------------------}

procedure TDCHint.HideHintWindow;
begin
  if GetVisible then
  {$IFNDEF CLX}
    ShowWindow(FHintWindow.Handle, SW_HIDE);
  {$ELSE}
    FHintWindow.Hide;
  {$ENDIF}
  VisibleChanged;
end;

{-----------------------------------------------------------}

function TDCHint.IsHintInRect(R : TRect; Point : TPoint) : boolean;
begin
  with R do
    result := PtInRect(Rect(left , 2 * top - bottom  , right , bottom ), Point) ;
end;

{-----------------------------------------------------------}

procedure TDCHint.ExecHintTimer;
var
  Point     : TPoint;
  InRect    : boolean;
  ADelay    : integer;
  HintPause : integer;
begin

  ADelay := FTimerDelay * integer(FHintTimer.Interval);
  GetCursorPos(Point);
  InRect := IsHintInRect(FHintRect, Point);

  case FHintState of
    hsBeginShow :
      begin
        if fAutoHide and not InRect then
          FHintState := hsHide
        else
        begin
          if GetVisible then
            HintPause := Application.HintShortPause
          else
            HintPause := Application.HintPause;
          if FImmediate  or (ADelay >= HintPause) then
          begin
            DrawHintWindow;
            FTimerDelay := 0;
            FHintState := hsShow;
          end
          else
            inc(FTimerDelay);
        end;
      end;
    hsShow :
      begin
        if (FAutoHide) and (not InRect or (ADelay > Application.HintHidePause)) then
        begin
          HideHintWindow;
          FTimerDelay := 0;
          FHintState := hsHide;
        end
        else
          inc(FTimerDelay);
      end;
    hsHide:
      begin
        HideHintWindow;
        FTimerDelay := 0;
        if not InRect then
          FHintTimer.Enabled := false;
      end;
  end;
end;
{-----------------------------------------------------------}

procedure  TDCHint.DrawHintWindow;
var
  OldVisible : boolean;
begin
  with FHintWindow, FHintRect do
  begin
    OldVisible := GetVisible;
    ActivateHint(Rect(Left , Top + FHintDelta, Right , Bottom + FHintDelta), FCaption);
    if not OldVisible then
      VisibleChanged;
  end;
end;

{-----------------------------------------------------------}

procedure TDCHint.CancelHint;
begin
  HideHintWindow;
  FTimerDelay := 0;
  FHintTimer.Enabled := false;
end;

{--------TControlBackground-------------------------------------------}

procedure TControlBackground.SetBackground(Value : TBitmap);
begin
  FBackground.Assign(Value);
end;

{------------------------------------------------------------------}

procedure TControlBackground.SetBkgndOption(Value : TBkgndOption);
begin
  if FBkgndOption <> Value then
  begin
    FBkgndOption := Value;
    BackgroundChanged(Self);
    FOwner.Invalidate;
  end;
end;

{------------------------------------------------------------------}

procedure TControlBackground.SetGradientBeginColor(Value : TColor);
begin
  if FGradientBeginColor <> Value then
  begin
    FGradientBeginColor := Value;
    BackgroundChanged(Self);
  end;
end;

{-------------------------------------------------------------}

procedure TControlBackground.SetGradientEndColor(Value : TColor);
begin
  if FGradientEndColor <> Value then
  begin
    FGradientEndColor := Value;
    BackgroundChanged(Self);
  end;
end;

{------------------------------------------------------------------}

procedure TControlBackground.BackgroundChanged(Sender : TObject);
begin
  if NeedPaint then
    PaintBackground;
end;

{------------------------------------------------------------------}

function  TControlBackground.NeedPaint : boolean;
begin
  result := not IsRectEmpty(GetPaintRect);
  if result and not (FBkgndOption in [boHorzGradient, boVertGradient]) then
    with FBackground do
      result := (FBkgndOption <> boNone) and (Width <> 0) and (Height <> 0);
end;

{------------------------------------------------------------------}

function  TControlBackground.GetPaintRect : TRect;
begin
  if FOwner.HandleAllocated then
    result := FOwner.ClientRect
  else
    result := Rect(0, 0, 0, 0);  
end;

{------------------------------------------------------------------}
type
  TMCustomControl = class(TCustomControl);

function  TControlBackground.GetPaintBrush : TBrush;
begin
  result := TMCustomControl(FOwner).Canvas.Brush;
end;

{------------------------------------------------------------------}

procedure  TControlBackground.PaintBackground;
var
  R        : TRect;
  StartX   : integer;
  Ax       : integer;
  AY       : integer;
  i        : integer;
  j        : integer;

  {--------------------------------------------------}

  function _GetSize(A, B : integer) : integer;
  begin
    result := B div A;
    if B mod A <> 0 then
      inc(result);
  end;

  {--------------------------------------------------}


begin

  if not NeedPaint then
    exit;


  with FBackground, FTempBackground.Canvas do
  begin
    R := GetPaintRect;
    StartX := R.Left;

    FTempBackground.Width  := R.Right - R.Left;
    FTempBackground.Height := R.Bottom - R.Top;


    case FBkgndOption of
      boStretch : StretchDraw(R, FBackground);
      boCenter  :
      begin
        Brush.Assign(GetPaintBrush);
        Brush.Color := TMCustomControl(FOwner).Color;
        FillRect(R);
        Draw(R.Left + (FTempBackground.Width - StartX - Width) div 2,
        R.Top + (FTempBackground.Height - Height) div 2, FBackground);
      end;
      boTile    :
      begin
        AX := _GetSize(Width, FTempBackground.Width - StartX);
        AY := _GetSize(Height, FTempBackground.Height);
        for i := 0 to AX do
          for j := 0 to AY do
            Draw(StartX + i * Width , j * Height, FBackground);
      end;
      boHorzGradient  :
        with FTempBackground do
          FillGradient(Canvas, Width, Height, FGradientBeginColor, FGradientEndColor, false);
      boVertGradient :
        with FTempBackground do
          FillGradient(Canvas, Width, Height, FGradientBeginColor, FGradientEndColor, true);
    end;
  end;
  FOwner.Invalidate;
end;

{------------------------------------------------------------------}

constructor TControlBackground.Create(Owner : TCustomControl);
begin
  inherited Create;
  FOwner := Owner;
  FBackground := TBitmap.Create;
  FBackground.OnChange := BackgroundChanged;
  FTempBackground  := TBitmap.Create;
  FGradientBeginColor := clBlue;
  FGradientEndColor   := clBlack;

end;

{------------------------------------------------------------------}

procedure TControlBackground.Assign(Source : TPersistent);
begin
  if Source is TControlBackground then
    with TControlBackground(Source) do
    begin
      Self.Background := Background;
      Self.BkgndOption := BkgndOption;
      Self.GradientBeginColor := GradientBeginColor;
      Self.GradientEndColor := GradientEndColor;
    end
  else
    inherited Assign(Source);
end;

{------------------------------------------------------------------}

destructor TControlBackground.Destroy;
begin
  FBackground.Free;
  FTempBackground.Free;             
  inherited Destroy;
end;

{------------------------------------------------------------------}

procedure DrawWithSelection(Canvas : TCanvas; Font , BoldFont : TFont ; Rect : TRect;
          const S : string; BoldPos, BoldLen : integer ; Align : TLeftRightAlign);
{$IFNDEF CLX}
const
  AlignArray : array[TLeftRightAlign] of integer = (DT_LEFT, DT_RIGHT);
{$ENDIF}
var
  str1    : string;
  str2    : string;
  str3    : string;

  size    : TSize;
  {$IFNDEF CLX}
  OldFont : THandle;
  {$ENDIF}
  Style   : integer;

  {-------------------------------------------------------}

  procedure  DrawSubString(const S : string);
  begin
    if s <> '' then
    begin
      with TMCanvas(Canvas) do
      {$IFNDEF CLX}
      begin
        DrawText(Handle , pchar(s), length(s) , Rect,  Style);
        GetTextExtentPoint(Handle, PChar(s), length(s) , size);
      end;
      {$ELSE}
      begin
        Start;
        try
          RequiredState([csHandleValid, csFontValid]);
//          QPainter_setBackgroundMode(Handle, BGMode_OPaqueMode);
          Qpainter_drawText(Handle, @Rect, Style, @s, Length(s), nil, nil);
          with Rect do
          begin
            size.cx := Bottom - Top;
            size.cy := Right - Left;
          end;
        finally
  //        QPainter_setBackgroundMode(Handle, BGMode_TransparentMode);
          Stop;
        end;
      end;

      {$ENDIF}
      if Align = lrLeftJustify then
        inc(Rect.Left, size.cx)
      else
        dec(Rect.Right, size.cx)
    end;
  end;

  {-------------------------------------------------------}

  procedure _SetFont(Font : TFont; AStore : boolean);
  begin
    {$IFNDEF CLX}
    if AStore then
      OldFont := SelectObject(Canvas.Handle, Font.Handle)
    else
      SelectObject(Canvas.Handle, Font.Handle)
    {$ELSE}
    Canvas.Font := Font;
    {$ENDIF}
  end;

  {-------------------------------------------------------}

  procedure DrawSubStrings(const s1, s2, s3 : string);
  begin
    _SetFont(Font, true);
    DrawSubString(s1);
    if s2 <> '' then
    begin
      _SetFont(BoldFont, false);
      DrawSubString(s2);
      _SetFont(Font, false);
    end;
    DrawSubString(s3);
    {$IFNDEF CLX}
    SelectObject(Canvas.Handle, OldFont);
    {$ENDIF}
  end;

  {-------------------------------------------------------}

begin
  if (BoldPos > 0)  then
  begin
    str1  := copy(S, 1, BoldPos - 1 );
    str2 := copy(S, BoldPos , BoldLen);
    str3 := copy(S, BoldPos +  BoldLen ,length(s) - BoldPos - BoldLen + 1);
  end
  else
  begin
    str1 := s;
    str2 := '';
    str3 := '';
  end;

  {$IFNDEF CLX}
  Style := AlignArray[Align] or DT_END_ELLIPSIS or DT_SINGLELINE;
  {$ELSE}
  if Align = lrLeftJustify then
    Style :=  Integer(AlignmentFlags_AlignLeft)
  else
    Style := Integer(AlignmentFlags_AlignRight);
  {$ENDIF}

  if Align = lrLeftJustify then
    DrawSubStrings(str1, str2, str3)
  else
    DrawSubStrings(str3, str2, str1);
end;

{------------------------------------------------------------------}

function CalcStringSize(Canvas : TCanvas; Font , BoldFont : TFont ; const S : string) : TSize;
var
  {$IFNDEF CLX}
  OldFont : THandle;
  {$ENDIF}
  BoldPos : integer;
  BoldEnd : integer;
  str     : string;
  Size    : TSize;

  {-------------------------------------------------------}

  procedure _SetFont(Font : TFont; AStore : boolean);
  begin
    {$IFNDEF CLX}
    if AStore then
      OldFont := SelectObject(Canvas.Handle, Font.Handle)
    else
      SelectObject(Canvas.Handle, Font.Handle)
    {$ELSE}
    Canvas.Font := Font;
    {$ENDIF}
  end;

  {-------------------------------------------------------}

begin
  _SetFont(Font, true);
  BoldPos := Pos(SBoldTag, S);
  if (BoldPos > 0)  then
    str  := copy(S, 1, BoldPos - 1 )
  else
    str := s;
  result := GetStringExtent(Canvas, str);
  if BoldPos > 0  then
  begin
    inc(BoldPos, Length(SBoldTag));

    BoldEnd := PosEx(SBoldTag, S, BoldPos);
    if BoldEnd = 0 then
      BoldEnd := Length(S) + 1;

    _SetFont(BoldFont, false);
    str := copy(S, BoldPos , BoldEnd - BoldPos);
    Size := GetStringExtent(Canvas, str);
    inc(result.cx, Size.cx);
    result.cy := Max(result.cy, Size.cy);
    _SetFont(Font, false);
    inc(BoldEnd, Length(SBoldTag));
    str := copy(S, BoldEnd,length(s) - BoldEnd + 1);
    Size := GetStringExtent(Canvas, str);
    inc(result.cx, Size.cx);
    result.cy := Max(result.cy, Size.cy);
  end;
  {$IFNDEF CLX}
  SelectObject(Canvas.Handle, OldFont);
  {$ENDIF}
end;

{------------------------------------------------------------------}

function ExtractBoldPos(const S : string; var BoldPos , BoldLen : integer): string;
begin
  result := s;
  BoldPos := Pos(SBoldTag,S);
  if BoldPos <> 0 then
  begin
     delete(result, BoldPos, Length(SBoldTag));
     BoldLen := Pos(SBoldTag,result);
     if BoldLen <> 0 then
     begin
       delete(result, BoldLen, Length(SBoldTag));
       BoldLen := BoldLen - BoldPos;
     end
     else
       BoldLen := length(result) - BoldPos + 1;
  end
    else
      BoldLen := 0;
end;

{------------------------------------------------------------------}

function ExtractColumn(const S : string; var Pos: Integer): string;
var
  i : integer;
begin
  i := Pos;
  while (i <= Length(S)) and (S[i] <> SSeparatorTag) do
    inc(i);
  result := Copy(S, pos, i - Pos);
  if (i <= Length(S)) and (s[i] = SSeparatorTag) then
    inc(i);
  Pos := i;
end;

{------------------------------------------------------------------}

function GetStringExtent(Canvas : TCanvas; const S : string) : TSize;
begin
  if s = '' then
  begin
    result.cx := 0;
    result.cy := 0;
  end
  else
  {$IFNDEF CLX}
    GetTextExtentPoint(Canvas.Handle, PChar(s), length(s) , result);
  {$ELSE}
    result := Canvas.TextExtent(s, 0);
  {$ENDIF}
end;

{-----------------------------------------------------------}

function MaxValue(Value1, Value2, Value3 : integer) : integer;
begin
  if Value1 > Value2 then
    Result := Value1
  else
    Result := Value2;

  if Value3 > Result then
    Result := Value3;
end;

{$IFDEF CLX}

{------------------------------------------------------------------}

function GetRValue(Rgb : integer) : byte;
begin
  result := byte(Rgb);
end;

{------------------------------------------------------------------}

function GetBValue(Rgb : integer) : byte;
begin
  result := byte(Rgb shr 16);
end;

{------------------------------------------------------------------}

function GetGValue(Rgb : integer) : byte;
begin
  result := byte(Rgb shr 8);
end;

{------------------------------------------------------------------}

function RGB(r, g, b : byte) : TColor;
begin
  result := (r or (g shl 8) or (b shl 16));
end;

{$ENDIF}

{------------------------------------------------------------------}

procedure FillGradient(Canvas : TCanvas; Width, Height : integer; StartColor, EndColor : TColor; IsVertical : boolean);
var
  i          : integer;
  LenRed     : integer;
  LenGreen   : integer;
  LenBlue    : integer;
  StartRed   : Byte;
  StartGreen : Byte;
  StartBlue  : Byte;
  MaxLen     : integer;
  Step       : integer;
  ARect      : TRect;
  StepRed    : integer;
  StepGreen  : integer;
  StepBlue   : integer;
  StartRGB   : integer;
  EndRGB     : integer;
  R          : integer;
  OldColor   : TColor;
begin
  if not ((width > 0) and (height > 0)) then
    exit;

  StartRGB := ColorToRgb(StartColor);
  EndRGB := ColorToRgb(EndColor);

  StartRed := GetRValue(StartRGB);
  StartGreen := GetGValue(StartRGB);
  StartBlue := GetBValue(StartRGB);

  LenRed := GetRValue(EndRGB)- StartRed;
  LenGreen := GetGValue(EndRGB) - StartGreen;
  LenBlue := GetBValue(EndRGB) - StartBlue;
  MaxLen := MaxValue(Abs(LenRed), Abs(LenGreen), Abs(LenBlue)) + 1;
  if MaxLen = 0 then
    exit;
  if IsVertical then
  begin
    Step := Height div MaxLen  + 1;
    ARect := Rect(0, 0, Width, Step);
  end
  else
  begin
    Step := Width div MaxLen + 1;
    ARect := Rect(0, 0, Step, Height);
  end;
  StepRed := Step * LenRed;
  StepGreen := Step * LenGreen;
  StepBlue := Step * LenBlue;
  if IsVertical then
    R := Height
  else
    R := Width;
  OldColor := Canvas.Brush.Color;
  for i := 0 to MaxLen - 1 do
  begin
    Canvas.Brush.Color := RGB(Round(StartRed  + (i * StepRed) div R),
                              Round(StartGreen + (i * StepGreen) div R),
                              Round(StartBlue + (i * StepBlue)  div R));
    Canvas.FillRect(ARect);
    with ARect do
      if IsVertical then
      begin
        inc(Top, Step);
        if Top > Height then
          break;
        inc(Bottom, Step);
      end
      else
      begin
        inc(Left, Step);
        if Left > Width then
          break;
        inc(Right, Step);
      end;

  end;
  Canvas.Brush.Color := OldColor;

end;

{------------------------------------------------------------------}

procedure PaintExpandCollapse(Canvas : TCanvas; X, Y, ASize, AIndent : integer; Value : boolean);
var
  R       : TRect;
  {-------------------------------------------------------}

  function GetButtonRect(const R : TRect) : TRect;
  var
    W      : integer;
    AWidth : integer;
  begin
    with R do
    begin
      AWidth := Right - Left;
      if AWidth < 5 then
        W := 1
      else
      if AWidth < 7 then
        W := 3
      else
        W := 5;
      result := Rect(0, 0, W, W);
      W := (AWidth - W) div 2;
      OffsetRect(result, Left + W, Top + W);
    end;  
  end;

  {-------------------------------------------------------}

begin


  R := Rect(X + AIndent, Y + AIndent, X + ASize - AIndent, Y + ASize - AIndent);

  {$IFNDEF CLX}
  DrawFrameControl(Canvas.Handle, R, DFC_BUTTON, DFCS_BUTTONPUSH);
  {$ENDIF}
  with GetButtonRect(R) do
  begin
    with Canvas.Pen do
    begin
      Color := clBlack;
      Style := psSolid;
      Width := 1;
    end;
    with Canvas do
    begin
      MoveTo(Left, Top + (Bottom - Top) div 2);
      LineTo(Right, Top + (Bottom - Top) div 2);
      if not Value then
      begin
        MoveTo(Left + (Right - Left) div 2, Top);
        LineTo(Left + (Right - Left) div 2, Bottom);
      end;
    end;
  end;
end;

end.


