{====================================================}
{                                                    }
{   EldoS Visual Components                          }
{                                                    }
{   Copyright (c) 1998-2003, EldoS Corporation       }
{                                                    }
{====================================================}

{$include elpack2.inc}
{$ifdef ELPACK_SINGLECOMP}
{$I ElPack.inc}
{$else}
{$ifdef LINUX}
{$I ../ElPack.inc}
{$else}
{$I ..\ElPack.inc}
{$endif}
{$endif}

(*

Version History

03/02/2003

  Added EndEllipsis property

03/06/2002

  Added unicode hint

12/28/2001

  When the control is resized, WordWrap is on and IsHTML is turned on, wrapping
was not updated. Fixed.

09/26/2001

  Added LinkStyle, LinkColor and LinkPopupMenu properties

09/10/2001

  Fixed updating after control is resized and WordWrap is set to TRUE.

09/03/2001

  in HTML mode Layout and Alignment properties are taken into account now.

08/20/2001

  Improved AutoSize behaviour

08/13/2001

  Fixed GetItemRect method to return correct values

*)
unit ElHTMLLbl;  { TElHTMLLabel component. }

{ HTML-enabled label }

interface

uses
  Windows,
  Messages,
  Graphics,
  Controls,
  StdCtrls,
  Forms,
  Menus,
  Classes,
  SysUtils,
  HTMLRender,
{$ifdef VCL_6_USED}
Types,
{$endif}
  ElTools,
  ElUxTheme,
  ElVCLUtils,
  ElStrUtils,
  ElCLabel,
  ElXPThemedControl,
  ElHandPt;

type

  TElHTMLLabel = class(TCustomElLabel)
  protected
    FCursor : TCursor;
    FRender : TElHTMLRender;
    FIsHTML : Boolean;
    FOnLinkClick : TElHTMLLinkClickEvent;
    FOnImageNeeded : TElHTMLImageNeededEvent;
    FLinkColor: TColor;
    FLinkPopupMenu: TPopupMenu;
    FLinkStyle: TFontStyles;
    {$ifdef ELPACK_UNICODE}
    FHint: TElFString;
    {$endif}
    procedure CMTextChanged(var Msg : TMessage); message CM_TEXTCHANGED;
    procedure CMFontChanged(var Msg : TMessage); message CM_FONTCHANGED;
    procedure CMMouseLeave(var Msg : TMessage); message CM_MOUSELEAVE;
    procedure SetLinkPopupMenu(newValue : TPopupMenu);

    procedure AdjustBounds;
{$IFNDEF VER100}
    override;
{$ENDIF}
    procedure SetIsHTML(newValue : Boolean); virtual;
    procedure TriggerLinkClickEvent(HRef : TElFString); virtual;
    procedure TriggerImageNeededEvent(Sender : TObject; Src : TElFString; var Image : TBitmap);
    procedure Loaded; override;
    procedure SetCursor(newValue : TCursor); virtual;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure Click; override;
    function GetWordWrap : Boolean; virtual;
    procedure SetWordWrap(newValue : Boolean); virtual;
    procedure SetAutoSize(newValue : Boolean); override;
    function GetTextRect : TRect;
    procedure DoDrawText(var Rect: TRect; Flags: {$ifdef VCL_4_USED}Longint{$else}Word{$endif});
    {$ifndef D_3}override;{$endif}
    procedure SetLinkColor(newValue : TColor); virtual;
    procedure SetLinkStyle(newValue : TFontStyles); virtual;
    procedure Notification(AComponent : TComponent; operation : TOperation);
        override;

    procedure WMRButtonUp(var Message: TWMRButtonUp); message WM_RBUTTONUP;
    procedure DoLinkPopup(MousePos : TPoint);
    {$ifdef VCL_5_USED}
    procedure WMContextMenu(var Message: TWMContextMenu); message WM_CONTEXTMENU;
    {$endif}
    function CalcTextRect: TRect;
    {$ifdef ELPACK_UNICODE}
    procedure SetHint(Value: TElFString);

    procedure CMHintShow(var Message: TMessage); message CM_HINTSHOW;
    {$endif}
    procedure SetName(const Value: TComponentName); override;
    function GetPlainText: TElFString;
   public
    { Public declarations }
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure Paint;
    override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;

    property TextRect : TRect read GetTextRect;
    property PlainText: TElFString read GetPlainText;
  published
    {$ifdef ELPACK_UNICODE}
    property Hint: TElFString read FHint write SetHint;
    {$endif}

    property Cursor   : TCursor read FCursor write SetCursor;  { Published }
    property IsHTML   : Boolean read FIsHTML write SetIsHTML;  { Published }
    property WordWrap : Boolean read GetWordWrap write SetWordWrap;  { Published }
    property LinkColor: TColor read FLinkColor write SetLinkColor default clBlue;
    property LinkPopupMenu: TPopupMenu read FLinkPopupMenu write SetLinkPopupMenu;
    property LinkStyle: TFontStyles read FLinkStyle write SetLinkStyle;

    property OnLinkClick : TElHTMLLinkClickEvent read FOnLinkClick write FOnLinkClick;
    property OnImageNeeded : TElHTMLImageNeededEvent read FOnImageNeeded write FOnImageNeeded;

    {$IFDEF ELPACK_USE_STYLEMANAGER}
    property EndEllipsis;
    {$ENDIF}

    property Align;
    property Alignment;
    property AutoSize;
{$IFDEF VCL_4_USED}
    property Anchors;
    property BiDiMode;
{$ENDIF}
    property Color nodefault;
{$IFDEF VCL_4_USED}
    property Constraints;
    property DragKind;
{$ENDIF}
    property DragCursor;
    property DragMode;
    property Enabled;
    property FocusControl;
    property Font;
{$IFDEF VCL_4_USED}
    property ParentBiDiMode;
{$ENDIF}
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Transparent;
    property Layout;
    property Visible;

    property OnClick;

{$IFDEF VCL_5_USED}
    property OnContextPopup;
{$ENDIF}
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
{$IFDEF VCL_4_USED}
    property OnEndDock;
    property OnStartDock;
{$ENDIF}
    property OnStartDrag;
  end;  { TElHTMLLabel }

implementation

procedure TElHTMLLabel.AdjustBounds;
begin
  if FIsHTML then
  begin
    if (not (csLoading in ComponentState)) and AutoSize then
       SetBounds(Left, Top, FRender.Data.TextSize.CX, FRender.Data.TextSize.CY);
  end else
    inherited;
end;

procedure TElHTMLLabel.SetIsHTML(newValue : Boolean);
begin
  if (FIsHTML <> newValue) then
  begin
    FIsHTML := newValue;
    if FIsHTML then
    begin
      FRender.Data.DefaultFont  := Font.Name;
      FRender.Data.Charset      := Font.Charset;
      FRender.Data.DefaultColor := Font.Color;
      FRender.Data.DefaultStyle := Font.Style;
      FRender.Data.DefaultHeight:= Font.Height;
      FRender.Data.LinkColor    := LinkColor;
      FRender.Data.LinkStyle    := LinkStyle;
      if WordWrap then
        FRender.PrepareText(Caption, Width, true)
      else
      begin
        FRender.PrepareText(Caption, Width, false);
        if AutoSize then
           AdjustBounds;
      end;
    end;
    Invalidate;
  end;  { if }
end;  { SetIsHTML }


procedure TElHTMLLabel.DoDrawText;
var
  Text: TElFString;
begin
  Text := Caption;
  if (Flags and DT_CALCRECT <> 0) and ((Text = '') or (ShowAccelChar and
     (Text[1] = '&') and (Text[2] = #0))) then
    Text := Text + ' ';
  if not ShowAccelChar then
    Flags := Flags or DT_NOPREFIX;

  {$IFDEF ELPACK_USE_STYLEMANAGER}
  if EndEllipsis then
    Flags := Flags or DT_END_ELLIPSIS;
  {$ENDIF}

  {$ifdef VCL_4_USED}
  Flags := DrawTextBiDiModeFlags(Flags);
  {$endif}
  Canvas.Font := Font;
  if not Enabled then
  begin
    OffsetRect(Rect, 1, 1);
    Canvas.Font.Color := clBtnHighlight;
    {$ifdef ELPACK_UNICODE}
    ElVCLUtils.DrawTextW(Canvas.Handle, PWideChar(Text), Length(Text), Rect, Flags);
    {$else}
    DrawText(Canvas.Handle, PChar(Text), Length(Text), Rect, Flags);
    {$endif}
    OffsetRect(Rect, -1, -1);
    Canvas.Font.Color := clBtnShadow;
    {$ifdef ELPACK_UNICODE}
    ElVCLUtils.DrawTextW(Canvas.Handle, PWideChar(Text), Length(Text), Rect, Flags);
    {$else}
    DrawText(Canvas.Handle, PChar(Text), Length(Text), Rect, Flags);
    {$endif}
  end
  else
    {$ifdef ELPACK_UNICODE}
    ElVCLUtils.DrawTextW(Canvas.Handle, PWideChar(Text), Length(Text), Rect, Flags);
    {$else}
    DrawText(Canvas.Handle, PChar(Text), Length(Text), Rect, Flags);
    {$endif}
end;

procedure TElHTMLLabel.Paint;  { public }
var R, RB : TRect;
  OldP, P : TPoint;
    Bmp   : TBitmap;
    ARect : TRect;

  function ParentIsThemed : boolean;
  begin
    result := (SendMessage(Parent.Handle, WM_ISTHEMEDCONTROL, 0, 0) <> 0) or (GetWindowTheme(Parent.Handle) <> 0);
  end;

begin
  if not IsHTML then
  begin
    inherited;
  end
  else
  begin
    Canvas.Font := Font;
    with Canvas do
    begin
      if ThemesAvailable and FUseXPThemes and ParentIsThemed then
      begin
        // copy parent's background
        P := Point(Left, Top);
        SetMapMode(Canvas.Handle, MM_ANISOTROPIC);
        SetViewPortOrgEx(Canvas.Handle, -P.x, -P.y, @OldP);
        SendMessage(Parent.Handle, WM_ERASEBKGND, Self.Canvas.Handle, 0);
        SetViewPortOrgEx(Canvas.Handle, OldP.x, OldP.y, nil);
        SetMapMode(Self.Canvas.Handle, MM_TEXT);
        ARect := ClientRect;
        //bitblt(FBuffer.Canvas.Handle, ARect.Left, ARect.Top, ARect.Right - ARect.Left, ARect.Bottom - ARect.Top, Self.Canvas.Handle, ARect.Left, ARect.Top, SRCCOPY);
      end
      else
      begin
        if not Transparent then
        begin
          Brush.Color := Self.Color;
          Brush.Style := bsSolid;
          FillRect(ClientRect);
        end;
      end;
      Brush.Style := bsClear;
    end;
    if Layout = tlCenter then
    begin
      CenterRects(ClientWidth, ClientWidth, FRender.Data.TextSize.cy, ClientHeight, R);
    end
    else
    if Layout = tlBottom then
    begin
      R := ClientRect;
      R.Top := R.Bottom - 1 - FRender.Data.TextSize.cy;
    end
    else
      R := ClientRect;
    if Alignment = taRightJustify then
    begin
      R.Right := ClientWidth;
      R.Left := R.Right - FRender.Data.TextSize.cx;
    end
    else
    if Alignment = taCenter then
    begin
      R.Left := (ClientWidth - FRender.Data.TextSize.cx) div 2;
      R.Right := R.Left + FRender.Data.TextSize.cx;
    end;
    Bmp := TBitmap.Create;
    Bmp.Handle := CreateCompatibleBitmap(Canvas.Handle, R.Right - R.Left, R.Bottom - R.Top);
    bitblt(Bmp.Canvas.Handle, 0, 0, R.Right - R.Left, R.Bottom - R.Top, Canvas.Handle, R.Left, R.Top, SRCCOPY);
    RB := R;
    OffsetRect(RB, -RB.Left, -RB.Top);
    FRender.DrawText(Bmp.Canvas, Point(0, 0), RB, clNone);
    bitblt(Canvas.Handle, R.Left, R.Top, R.Right - R.Left, R.Bottom - R.Top, Bmp.Canvas.Handle, 0, 0, SRCCOPY);
    Bmp.Free;
  end;
end;  { Paint }

{ Event triggers: }
procedure TElHTMLLabel.TriggerLinkClickEvent(HRef : TElFString);
begin
  if (assigned(FOnLinkClick)) then
    FOnLinkClick(Self, HRef );
end;  { TriggerLinkClickEvent }

procedure TElHTMLLabel.TriggerImageNeededEvent(Sender : TObject; Src : TElFString; var Image : TBitmap);
begin
  Image := nil;
  if (assigned(FOnImageNeeded)) then
      FOnImageNeeded(Self, Src, Image);
end;  { TriggerImageNeededEvent }

procedure TElHTMLLabel.Loaded;
begin
  inherited Loaded;
  if IsHTML then
  begin
    FIsHTML := false;
    IsHTML := true;
  end;
end;		{ Loaded }

procedure TElHTMLLabel.CMTextChanged(var Msg : TMessage);
begin
  inherited;
  if FIsHTML then
  begin
    FIsHTML := false;
    IsHTML  := true;
  end;
end;  { CMTextChanged }

procedure TElHTMLLabel.CMMouseLeave(var Msg : TMessage);  { private }
begin
  inherited Cursor := FCursor;
  inherited;
end;  { CMMouseLeave }

procedure TElHTMLLabel.SetCursor(newValue : TCursor);
var P : TPoint;
    R : TRect;
    href : TElFString;
begin
  if (FCursor <> newValue) then
  begin
    FCursor := newValue;
    GetCursorPos(P);
    P := ScreenToClient(P);
    R := CalcTextRect;
    if IsHTML then
    begin
      if FRender.IsCursorOverLink(P, Point(0, 0), R, href) then
        inherited Cursor := crURLCursor
      else
        inherited Cursor := FCursor;
    end
    else
      inherited Cursor := FCursor;
  end;  { if }
end;  { SetCursor }

procedure TElHTMLLabel.MouseMove(Shift: TShiftState; X, Y: Integer);  { protected }
var href : TElFString;
    R    : TRect;
begin
  if IsHTML then
  begin
    R := CalcTextRect;
    if IsHTML and FRender.IsCursorOverLink(Point(X - R.Left, Y - R.Top), Point(0, 0), R, href) then
       inherited Cursor := crURLCursor
    else
       inherited Cursor := FCursor;
  end;
  inherited MouseMove(Shift, X, Y);
end;  { MouseMove }

procedure TElHTMLLabel.CMFontChanged(var Msg : TMessage);  { private }
begin
  inherited;
  if FIsHTML then
  begin
    FIsHTML := false;
    IsHTML  := true;
  end;
end;  { CMFontChanged }

procedure TElHTMLLabel.Click;
var P : TPoint;
    R : TRect;
    href : TElFString;
begin
  GetCursorPos(P);
  P := ScreenToClient(P);
  if IsHTML then
  begin
    R := CalcTextRect;

    dec(P.x, R.Left);
    dec(P.y, R.Top);
    if IsHTML and FRender.IsCursorOverLink(P, Point(0, 0), R, href) then
       TriggerLinkClickEvent(href)
    else
      inherited;
  end
  else
    inherited;
end;  { Click }

function TElHTMLLabel.GetWordWrap : Boolean;
{ Returns the value for the WordWrap property. }
begin
  result := inherited WordWrap;
end;  { GetWordWrap }

procedure TElHTMLLabel.SetWordWrap(newValue : Boolean);
{ Sets the value for the WordWrap property. }
begin
  if WordWrap <> newValue then
  begin
    inherited WordWrap := newValue;
    if IsHTML then
    begin
      FIsHTML := false;
      IsHTML := true;
    end;
  end;
end;  { SetWordWrap }

function TElHTMLLabel.GetTextRect : TRect;
var S : TSize;
    AL: integer;
begin
  if IsHTML then
  begin
    S := FRender.Data.TextSize;
    result := Rect(0, 0, S.cx, S.cy);
  end
  else
  begin
    Canvas.Font.Assign(Font);
    if WordWrap then
      AL := DT_WORDBREAK
    else
      AL := 0;
{$ifdef ELPACK_UNICODE}
    SetRectEmpty(Result);
    ElVCLUtils.DrawTextW(Canvas.Handle, PWideChar(Caption), Length(Caption), Result,
      DT_EXPANDTABS or DT_CALCRECT or AL
{$else}
    DrawText(Canvas.Handle, PChar(Caption), Length(Caption), Result,
      DT_EXPANDTABS or DT_CALCRECT or AL
{$endif}
{$IFDEF VCL_4_USED}
      or
      DrawTextBiDiModeFlagsReadingOnly
{$ENDIF}
      );
  end;
end;

procedure TElHTMLLabel.SetAutoSize(newValue : Boolean);
{ Sets the value for the AutoSize property. }
begin
  if inherited AutoSize <> newValue then
  begin
    inherited SetAutoSize(newValue);
    {$ifdef VER100}
    AdjustBounds;
    {$endif}
    if FIsHTML then
    begin
      FIsHTML := false;
      IsHTML  := true;
      if newValue then
      begin
        inherited SetAutoSize(false);
        inherited SetAutoSize(true);
      end;
    end;
  end;
end;  { SetAutoSize }

destructor TElHTMLLabel.Destroy;
begin
  FRender.Free;
  inherited Destroy;
end;  { Destroy }

constructor TElHTMLLabel.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  //ControlStyle := ControlStyle - [csSetCaption];
  FRender := TElHTMLRender.Create;
  FRender.OnImageNeeded := TriggerImageNeededEvent;
  FLinkColor := clBlue;
  FLinkStyle := [fsUnderline];
end;  { Create }

procedure TElHTMLLabel.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited;
  if WordWrap and IsHTML then
  begin
    FIsHTML := false;
    IsHTML := true;
  end;
end;  { WMSize }

procedure TElHTMLLabel.SetLinkColor(newValue : TColor);
{ Sets data member FLinkColor to newValue. }
begin
  if (FLinkColor <> newValue) then
  begin
    FLinkColor := newValue;
    if IsHTML then
    begin
      FIsHTML := false;
      IsHTML := true;
    end;
  end;  { if }
end;  { SetLinkColor }

procedure TElHTMLLabel.SetLinkPopupMenu(newValue : TPopupMenu);
begin
  if (FLinkPopupMenu <> newValue) then
  begin
    {$ifdef VCL_5_USED}
    if FLinkPopupMenu <> nil then
      if not (csDestroying in FLinkPopupMenu.ComponentState) then
        FLinkPopupMenu.RemoveFreeNotification(Self);
    {$endif}
    FLinkPopupMenu := newValue;
    if (newValue <> nil) then
       newValue.FreeNotification(Self);
  end;  { if }
end;  { SetLinkPopupMenu }

procedure TElHTMLLabel.SetLinkStyle(newValue : TFontStyles);
{ Sets data member FLinkStyle to newValue. }
begin
  if (FLinkStyle <> newValue) then
  begin
    FLinkStyle := newValue;
    if IsHTML then
    begin
      FIsHTML := false;
      IsHTML := true;
    end;
  end;  { if }
end;  { SetLinkStyle }

procedure TElHTMLLabel.Notification(AComponent : TComponent; operation :
    TOperation);
begin
  inherited Notification(AComponent, operation);
  if (operation = opRemove) then
  begin
    if (AComponent = FLinkPopupMenu) then
      LinkPopupMenu := nil;
  end;  { if }
end;  { Notification }

procedure TElHTMLLabel.WMRButtonUp(var Message: TWMRButtonUp);
{$ifndef VCL_5_USED}
var P : TPoint;
    R : TRect;
    href : TElFString;
{$endif}
begin
  {$ifndef VCL_5_USED}
  P := SmallPointToPoint(Message.Pos);
  R := CalcTextRect;
  if IsHTML and (LinkPopupMenu <> nil) and FRender.IsCursorOverLink(P, Point(0, 0), ClientRect, href) then
  begin
    if not (csNoStdEvents in ControlStyle) then
      with Message do
        MouseUp(mbRight, KeysToShiftState(Keys), XPos, YPos);
    if Message.Result = 0 then
    begin
      DoLinkPopup(P);
    end;
  end
  else
  {$endif}
    inherited;
end;

procedure TElHTMLLabel.DoLinkPopup(MousePos : TPoint);
begin
  if (FLinkPopupMenu <> nil) and FLinkPopupMenu.AutoPopup then
  begin
    SendCancelMode(nil);
    FLinkPopupMenu.PopupComponent := Self;
    if MousePos.X < 0 then
      MousePos := ClientToScreen(Point(0,0));
    FLinkPopupMenu.Popup(MousePos.X, MousePos.Y);
  end;
end;

{$ifdef VCL_5_USED}
procedure TElHTMLLabel.WMContextMenu(var Message: TWMContextMenu);
var
  Pt, Temp: TPoint;
  Handled: Boolean;
  href : TElFString;
begin
  if Message.Result <> 0 then Exit;
  if csDesigning in ComponentState then Exit;

  Pt := ScreenToClient(SmallPointToPoint(Message.Pos));

  if IsHTML and (LinkPopupMenu <> nil) and FRender.IsCursorOverLink(Pt, Point(0, 0), CLientRect, href) then
  begin
    Handled := False;
    Temp := ClientToScreen(Pt);
    DoContextPopup(Temp, Handled);
    Message.Result := Ord(Handled);
    if Handled then Exit;

    DoLinkPopup(ClientToScreen(Pt));
    Message.Result := 1;
  end
  else
    inherited;
end;

{$endif}

function TElHTMLLabel.CalcTextRect: TRect;
begin
  if Layout = tlCenter then
  begin
    CenterRects(ClientWidth, ClientWidth, FRender.Data.TextSize.cy, ClientHeight, Result);
  end
  else
  if Layout = tlBottom then
  begin
    Result := ClientRect;
    Result.Top := Result.Bottom - 1 - FRender.Data.TextSize.cy;
  end
  else
    Result := ClientRect;
  if Alignment = taRightJustify then
  begin
    Result.Right := ClientWidth;
    Result.Left := Result.Right - FRender.Data.TextSize.cx;
  end
  else
  if Alignment = taCenter then
  begin
    Result.Left := (ClientWidth - FRender.Data.TextSize.cx) div 2;
    Result.Right := Result.Left + FRender.Data.TextSize.cx;
  end;
end;

{$ifdef ELPACK_UNICODE}
procedure TElHTMLLabel.CMHintShow(var Message: TMessage);
var T: WideChar;
  HintInfo : PHintInfo;
  l : integer;
  S : String;
  WS: WideString;
begin
  inherited;
  HintInfo := PHintInfo(Message.lParam);
  if Length(FHint) = 0 then
  begin
    HintInfo.hintStr := '';
    exit;
  end;

  S := GetShortHint(inherited Hint);
  if HintInfo.HintStr = S then
  begin
    WS := GetShortHintW(FHint);
  end
  else
  begin
    S := FHint;
    WS := FHint;
  end;

  l := Length(S) + 1 + Length(WS) * 2;
  SetLength(HintInfo.HintStr, l + 4);
  Move(PChar(S)^, HintInfo.HintStr[1], Length(S) + 1);

  Move(WS[1], HintInfo.HintStr[Length(S) + 2], Length(WS) * 2);
  T := #0;
  Move(T, HintInfo.HintStr[l + 1], sizeof(T));
  T := #$FFFE;
  Move(T, HintInfo.HintStr[l + 3], sizeof(T));
end;

procedure TElHTMLLabel.SetHint(Value: TElFString);
var S : String;
    i,
    l : integer;
    T : WideChar;
begin
  FHint := Value;

  S := FHint;
  i := Length(S);
  l := Length(S) + 1 + Length(FHint) * 2;
  SetLength(S, l + 4);
  S[i + 1] := #0;

  Move(FHint[1], S[i + 2], Length(FHint) * 2);
  T := #0;
  Move(T, S[l + 1], sizeof(T));
  T := #$FFFE;
  Move(T, S[l + 3], sizeof(T));
  inherited Hint := S;
end;

{$endif}

procedure TElHTMLLabel.SetName(const Value: TComponentName);
var
  ChangeText: Boolean;
begin
  ChangeText := (csSetCaption in ControlStyle) and
    not (csLoading in ComponentState) and (Name = Text) and
    ((Owner = nil) or not (Owner is TControl) or
    not (csLoading in TControl(Owner).ComponentState));
  inherited SetName(Value);
  if ChangeText then
    Caption := Value;
end;

function TElHTMLLabel.GetPlainText: TElFString;
begin
  if not IsHTML then
    Result := Caption
  else
    Result := FRender.AsText;
end;

end.
