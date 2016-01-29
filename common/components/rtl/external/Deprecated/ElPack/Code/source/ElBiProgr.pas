{====================================================}
{                                                    }
{   EldoS Visual Components                          }
{                                                    }
{   Copyright (c) 1998-2003, EldoS Corporation       }
{                                                    }
{====================================================}
{$INCLUDE elpack2.inc}
{$IFDEF ELPACK_SINGLECOMP}
{$I ElPack.inc}
{$ELSE}
{$IFDEF LINUX}
{$I ../ElPack.inc}
{$ELSE}
{$I ..\ElPack.inc}
{$ENDIF}
{$ENDIF}

(*

Version History

04/04/2003

  Added Transparent and Imageform properties

02/XX/2003

  Added Orientation property
  Added Smooth property

11/13/2002

  Added UseXPThemes property
  Added Unicode Hint

*)

unit ElBiProgr;

interface

uses
  Windows,
  Messages,
  Graphics,
  Controls,
  Forms,
  extctrls,
{$IFDEF VCL_6_USED}
  Types,
{$ENDIF}
{$IFDEF ELPACK_USE_STYLEMANAGER}
  ElStyleMan,
{$ENDIF}
{$IFDEF ELPACK_USE_IMAGEFORM}
  ElImgFrm,
{$ENDIF}
  ElUxTheme,
  ElTmSchema,
  ElStrUtils,
  ElVCLUtils,
  Classes,
  SysUtils,
  TypInfo,
  ElXPThemedControl;

type
  TProgrShowMode = (psmAllFull, psmLightHalf, psmDarkHalf, psmAllHalf);
  TElBevelStyle = (ebsNone, ebsLowered, ebsRaised);
  TElProgrOrientation = (poHorizontal, poVertical);

type
  TElBiProgressBar = class({TGraphicControl} TElXPThemedControl)
  private
    FMinValue: Integer;
    FOrientation: TElProgrOrientation;
    FSmooth: boolean;
    FScale: integer;
    FAdditive: boolean;
    FProgrShowMode: TProgrShowMode;
    FLightTextFullLine: Boolean;
    FDarkTextFullLine: Boolean;
    FLightButtonStyle: Boolean;
    FDarkButtonStyle: Boolean;
    FBevelStyle: TElBevelStyle;
    FDarkText: TElFString;
    FLightText: TElFString;
    FDarkTextColor: TColor;
    FLightTextColor: TColor;
    FLightColor: TColor;
    FDarkColor: TColor;
    FLightValue: integer;
    FDarkValue: integer;
    {$ifdef ELPACK_USE_IMAGEFORM}
    FImgFormChLink: TImgFormChangeLink;
    FImgForm: TElImageForm;
    {$endif}
    // FUseXPThemes: Boolean;
{$IFDEF ELPACK_USE_STYLEMANAGER}
    FStyleMgrLink: TElStyleMgrChangeLink;
    FStyleManager: TElStyleManager;
    FStyleName: String;
{$ENDIF}
    FBtnTheme: HTheme;
    FCaption: TElFString;
    FBitmap: TBitmap;

    {$ifdef ELPACK_USE_IMAGEFORM}
    procedure SetImageForm(NewValue: TElImageForm); virtual;
    procedure ImageFormChange(Sender : TObject);
    {$endif}
    procedure SetLightColor(aValue: TColor);
    procedure SetDarkColor(aValue: TColor);
    procedure SetScale(aValue: integer);
    procedure SetLightValue(aValue: integer);
    procedure SetDarkValue(aValue: integer);
    procedure SetAdditive(aValue: boolean);
    procedure SetProgrShowMode(aValue: TProgrShowMode);
    procedure SetDarkText(NewValue: TElFString);
    procedure SetLightText(NewValue: TElFString);
    procedure SetCaption(NewValue: TElFString);
    procedure SetDarkTextColor(NewValue: TColor);
    procedure SetLightTextColor(NewValue: TColor);
    procedure SetBevelStyle(NewValue: TElBevelStyle);
    procedure SetMinValue(NewValue: Integer);
    procedure SetLightButtonStyle(NewValue: Boolean);
    procedure SetDarkButtonStyle(NewValue: Boolean);
    procedure SetLightTextFullLine(NewValue: boolean);
    procedure SetDarkTextFullLine(NewValue: boolean);
    procedure SetOrientation(NewValue: TElProgrOrientation);
    procedure SetSmooth(NewValue: boolean);
//    procedure SetUseXPThemes(const Value: Boolean); override;
//    procedure ELThemeChanged(var Message: TMessage); message EL_THEMECHANGED;
  protected
{$IFDEF ELPACK_UNICODE}
    FHint: TElFString;
{$ENDIF}
    FTransparent: Boolean;
    procedure Paint; override;
{$IFDEF ELPACK_UNICODE}
    procedure SetHint(Value: TElFString);
    procedure CMHintShow(var Message: TMessage); message CM_HINTSHOW;
{$ENDIF}
{$IFDEF ELPACK_USE_STYLEMANAGER}
    procedure SetStyleManager(Value: TElStyleManager); override {virtual};
    procedure SetStyleName(const Value: String); override {virtual};
    procedure StyleMgrChange(Sender: TObject);
    procedure UpdateStyle;
{$ENDIF}
    {$ifdef MSWINDOWS}
    function GetThemedClassName: WideString; override;
    procedure CreateThemeHandle; override;
    procedure FreeThemeHandle; override;
    {$endif}
    procedure DefineProperties(Filer: TFiler); override;
    procedure ReadBorderStyle(Reader: TReader);
    procedure SetTransparent(NewValue: Boolean);
    procedure CreateParams(var Params: TCreateParams); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetValues(ALightValue, ADarkValue, AScale: integer; AAdditive:
      boolean);
  published
    property LightColor: TColor read FLightColor write SetLightColor default clRed;
    property DarkColor: TColor read FDarkColor write SetDarkColor default clMaroon;
    property Scale: integer read FScale write SetScale default 100;
    property LightValue: integer read FLightValue write SetLightValue;
    property DarkValue: integer read FDarkValue write SetDarkValue;
    property Additive: boolean read FAdditive write SetAdditive;
    property Caption: TElFString read FCaption write SetCaption;
    property ProgressShowMode: TProgrShowMode read FProgrShowMode write SetProgrShowMode
      default psmAllFull;
    property LightTextFullLine: Boolean read FLightTextFullLine write SetLightTextFullLine;
    property DarkTextFullLine: Boolean read FDarkTextFullLine write SetDarkTextFullLine;
    property DarkText: TElFString read FDarkText write SetDarkText;
    property LightText: TElFString read FLightText write SetLightText;
    property DarkTextColor: TColor read FDarkTextColor write SetDarkTextColor;
    property LightTextColor: TColor read FLightTextColor write SetLightTextColor;
    property BevelStyle: TElBevelStyle read FBevelStyle write SetBevelStyle;
    property MinValue: Integer read FMinValue write SetMinValue default 0;
    property LightButtonStyle: Boolean read FLightButtonStyle write SetLightButtonStyle;
    property DarkButtonStyle: Boolean read FDarkButtonStyle write SetDarkButtonStyle;
    property Orientation: TElProgrOrientation read FOrientation write SetOrientation
      default poHorizontal;
    property Smooth: boolean read FSmooth write SetSmooth default False;
{$IFDEF ELPACK_USE_STYLEMANAGER}
    property StyleManager: TElStyleManager read FStyleManager write SetStyleManager;
    property StyleName: String read FStyleName write SetStyleName;
{$ENDIF}
{$IFDEF ELPACK_UNICODE}
    property Hint: TElFString read FHint write SetHint;
{$ENDIF}
    {$ifdef ELPACK_USE_IMAGEFORM}
    property ImageForm: TElImageForm read FImgForm write SetImageForm;
    {$endif}
    property Transparent: Boolean read FTransparent write SetTransparent default False;
    property UseXPThemes;
    property Align;
    property Color default clWindow;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ParentColor default False;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;

{$IFDEF VCL_4_USED}
    property Anchors;
    property Action;
    property Constraints;
    property DockOrientation;
    property Floating;
    property DragKind;
{$ENDIF}
  end;

implementation

uses ElTools;

{TELBiProgressBar}

//---------------------------------------------------------------
//                        create/destroy
//---------------------------------------------------------------

constructor TELBiProgressBar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  // win control style:
  ControlStyle := ControlStyle + [csOpaque];
  // color:
  ParentColor := False;
  FLightColor := clRed;
  FDarkColor := clMaroon;
  Color := clWindow;
  // size:
  Width := 100;
  Height := 21;
  // other data:
  FBitmap := TBitmap.Create;
  // other properties:
  FMinValue := 0;
  FOrientation := poHorizontal;
  FSmooth := False;
  FProgrShowMode := psmAllFull;
  Scale := 100;
  {$ifdef ELPACK_USE_IMAGEFORM}
  FImgFormChLink := TImgFormChangeLink.Create;
  FImgFormChLink.OnChange := ImageFormChange;
  {$endif}
  {$IFDEF ELPACK_USE_STYLEMANAGER}
  FStyleMgrLink := TElStyleMgrChangeLink.Create;
  FStyleMgrLink.OnChange := StyleMgrChange;
  {$ENDIF}
end;

destructor TELBiProgressBar.Destroy;
begin
  FreeAndNil(FBitmap);
{$IFDEF ELPACK_USE_STYLEMANAGER}
  StyleManager := nil;
  FreeAndNil(FStyleMgrLink);
{$ENDIF}
  {$ifdef ELPACK_USE_IMAGEFORM}
  FreeAndNil(FImgFormChLink);
  {$endif}
  inherited Destroy;
end;

{$ifdef ELPACK_USE_IMAGEFORM}
procedure TELBiProgressBar.ImageFormChange(Sender : TObject);
begin
  Invalidate;
end;
{$endif}

{$ifdef ELPACK_USE_IMAGEFORM}
procedure TELBiProgressBar.SetImageForm(NewValue: TElImageForm);
{ Sets data member FImageForm to NewValue. }
begin
  if FImgForm <> NewValue then
  begin
    if FImgForm <> nil then
    begin
      {$ifdef VCL_5_USED}
      if not (csDestroying in FImgForm.ComponentState) then
        FImgForm.RemoveFreeNotification(Self);
      {$endif}
      FImgForm.UnregisterChanges(FImgFormChLink);
    end;
    FImgForm := NewValue;
    if FImgForm <> nil then
    begin
      FImgForm.RegisterChanges(FImgFormChLink);
      FImgForm.FreeNotification(Self);
    end;
    Invalidate;
  end;
end; { SetImageForm }
{$endif}

{$IFDEF ELPACK_USE_STYLEMANAGER}
procedure TELBiProgressBar.SetStyleManager(Value: TElStyleManager);
begin
  if FStyleManager <> Value then
  begin
{$IFDEF VCL_5_USED}
    if (FStyleManager <> nil) and (not (csDestroying in
      FStyleManager.ComponentState)) then
      FStyleManager.RemoveFreeNotification(Self);
{$ENDIF}
    if FStyleManager <> nil then
      FStyleManager.UnregisterChanges(FStyleMgrLink);
    FStyleManager := Value;
    if FStyleManager <> nil then
    begin
      FStyleManager.FreeNotification(Self);
      FStyleManager.RegisterChanges(FStyleMgrLink);
      UpdateStyle;
    end;
  end;
end;

procedure TELBiProgressBar.SetStyleName(const Value: String);
begin
  if FStyleName <> Value then
  begin
    FStyleName := Value;
    UpdateStyle;
  end;
end;

procedure TELBiProgressBar.StyleMgrChange(Sender: TObject);
begin
  UpdateStyle;
end;

procedure TELBiProgressBar.UpdateStyle;
begin
  if FStyleManager <> nil then
  begin
    if (Parent <> nil) and Parent.HandleAllocated then
      SendMessage(Parent.Handle, WM_SETREDRAW, 0, 0);
    FStyleManager.ApplyStyle(Self, StyleName);
    if (Parent <> nil) and Parent.HandleAllocated then
    begin
      SendMessage(Parent.Handle, WM_SETREDRAW, 1, 0);
      Invalidate;
    end;
  end;
end;
{$ENDIF}

{$ifdef MSWINDOWS}
procedure TELBiProgressBar.CreateThemeHandle;
begin
  inherited;
  if ThemesAvailable then
  begin
    FBtnTheme := OpenThemeData(Handle, 'BUTTON')
  end
    // FBtnTheme := OpenThemeData(Handle, PWideChar(WideString('BUTTON')))
  else
    FBtnTheme := 0;
end;

procedure TELBiProgressBar.FreeThemeHandle;
begin
  inherited;
  if ThemesAvailable then
    CloseThemeData(FBtnTheme);
  FBtnTheme := 0;
end;

{
procedure TELBiProgressBar.ELThemeChanged(var Message: TMessage);
begin
  if ThemesAvailable and UseXPThemes then
  begin
    FreeThemeHandle;
    CreateThemeHandle;
    SetWindowPos(
      Handle,
      0,
      0, 0, 0, 0,
      SWP_FRAMECHANGED or SWP_NOMOVE or SWP_NOSIZE or SWP_NOZORDER
      );
    RedrawWindow(Handle, nil, 0, RDW_FRAME or RDW_INVALIDATE or RDW_ERASE);
  end;
  Message.Result := 1;
end;
}

function TELBiProgressBar.GetThemedClassName: WideString;
begin
  Result := 'PROGRESS';
end;
{$endif}

//---------------------------------------------------------------
//                     get/set properties
//---------------------------------------------------------------

procedure TELBiProgressBar.SetCaption(NewValue: TElFString);
{ Sets data member FDarkText to NewValue. }
begin
  if (FCaption <> NewValue) then
  begin
    FCaption := NewValue;
    Invalidate;
  end; { if }
end; { SetCaption }

procedure TELBiProgressBar.SetDarkText(NewValue: TElFString);
{ Sets data member FDarkText to NewValue. }
begin
  if (FDarkText <> NewValue) then
  begin
    FDarkText := NewValue;
    Invalidate;
  end; { if }
end; { SetDarkText }

procedure TELBiProgressBar.SetLightText(NewValue: TElFString);
{ Sets data member FLightText to NewValue. }
begin
  if (FLightText <> NewValue) then
  begin
    FLightText := NewValue;
    Invalidate;
  end; { if }
end; { SetLightText }

procedure TELBiProgressBar.SetDarkTextColor(NewValue: TColor);
{ Sets data member FDarkTextColor to NewValue. }
begin
  if (FDarkTextColor <> NewValue) then
  begin
    FDarkTextColor := NewValue;
    Invalidate;
  end; { if }
end; { SetDarkTextColor }

procedure TELBiProgressBar.SetLightTextColor(NewValue: TColor);
{ Sets data member FLightTextColor to NewValue. }
begin
  if (FLightTextColor <> NewValue) then
  begin
    FLightTextColor := NewValue;
    Invalidate;
  end; { if }
end; { SetLightTextColor }

procedure TELBiProgressBar.SetBevelStyle(NewValue: TElBevelStyle);
{ Sets data member FBevelStyle to NewValue. }
begin
  if (FBevelStyle <> NewValue) then
  begin
    FBevelStyle := NewValue;
    Invalidate;
  end; { if }
end; { SetBevelStyle }

procedure TELBiProgressBar.SetLightColor(aValue: TColor);
begin
  if FLightColor = aValue then Exit;
  FLightColor := aValue;
  Invalidate;
end;

procedure TELBiProgressBar.SetDarkColor(aValue: TColor);
begin
  if FDarkColor = aValue then Exit;
  FDarkColor := aValue;
  Invalidate;
end;

procedure TELBiProgressBar.SetScale(aValue: integer);
begin
  if FScale = aValue then Exit;
  FScale := aValue;
  Invalidate;
end;

procedure TELBiProgressBar.SetLightValue(aValue: integer);
begin
  if FLightValue = aValue then Exit;
  FLightValue := aValue;
  Invalidate;
end;

procedure TELBiProgressBar.SetDarkValue(aValue: integer);
begin
  if FDarkValue = aValue then Exit;
  FDarkValue := aValue;
  Invalidate;
end;

procedure TELBiProgressBar.SetAdditive(aValue: boolean);
begin
  if FAdditive = aValue then Exit;
  FAdditive := aValue;
  Invalidate;
end;

procedure TELBiProgressBar.SetValues(ALightValue, ADarkValue, AScale: integer;
  AAdditive: boolean);
begin
  FScale := AScale;
  FLightValue := ALightValue;
  FDarkValue := ADarkValue;
  FAdditive := AAdditive;
  Invalidate;
end;

procedure TELBiProgressBar.SetProgrShowMode(aValue: TProgrShowMode);
begin
  if FProgrShowMode <> aValue then
  begin
    FProgrShowMode := aValue;
    Invalidate;
  end;
end;

procedure TELBiProgressBar.SetLightTextFullLine(NewValue: boolean);
begin
  if FLightTextFullLine <> NewValue then
  begin
    FLightTextFullLine := NewValue;
    Invalidate;
  end;
end;

procedure TELBiProgressBar.SetDarkTextFullLine(NewValue: boolean);
begin
  if FDarkTextFullLine <> NewValue then
  begin
    FDarkTextFullLine := NewValue;
    Invalidate;
  end;
end;

procedure TELBiProgressBar.Paint;
var
  R: TRect;
  PartRect: TRect;

  DarkSize: integer;
  LightSize: integer;

  DarkRect: TRect;
  LightRect: TRect;

  Margin: integer;
  pid: integer;
  ps: TSize;

  procedure FillPBRect(const R: TRect);
  const
    dx = 8;
    ox = 2;
  var
    r1: trect;
  begin
    with FBitmap.Canvas do
      if Smooth then FillRect(R)
      else
      begin
        r1 := r;
        if FOrientation = poVertical then
          repeat
            r1.top := r1.bottom - dx;
            FillRect(r1);
            r1.bottom := r1.top - ox;
          until r1.top - dx < r.top
        else
          while r1.left + dx <= R.Right do
          begin
            r1.Right := r1.Left + dx;
            FillRect(r1);
            r1.left := r1.right + ox;
          end;
      end;
  end;

var
  OldP, P: TPoint;
  {$ifdef ELPACK_USE_IMAGEFORM}
  BgRect,
  R1    : TRect;
  ACtl  : TWinControl;
  ax, ay: integer;
  {$endif}
begin
  FBitmap.Width := ClientWidth;
  FBitmap.Height := ClientHeight;
  FBitmap.Handle := CreateCompatibleBitmap(Canvas.Handle, ClientWidth, ClientHeight);
  R := ClientRect;

  Margin := 0;
  pid := PP_CHUNK;

  if ThemesAvailable and UseXPThemes and (GetWindowTheme(Parent.Handle) <> 0) then
  begin
    // copy parent's background
    P := Point(Left, Top);
    SetMapMode(Self.Canvas.Handle, MM_ANISOTROPIC);
    SetViewPortOrgEx(Self.Canvas.Handle, -P.x, -P.y, @OldP);
    SendMessage(Parent.Handle, WM_ERASEBKGND, Self.Canvas.Handle, 0);
    SetViewPortOrgEx(Self.Canvas.Handle, OldP.x, OldP.y, nil);
    SetMapMode(Self.Canvas.Handle, MM_TEXT);
    bitblt(FBitmap.Canvas.Handle, R.Left, R.Top, R.Right - R.Left, R.Bottom -
      R.Top, Self.Canvas.Handle, R.Left, R.Top, SRCCOPY);
  end
  else
  if not Transparent then
  begin
    {$ifdef ELPACK_USE_IMAGEFORM}
    if (FImgForm <> nil) and (not (csDesigning in FImgForm.GetRealControl.ComponentState)) then
    begin
      if FImgForm.Control <> Self then
      begin
        ACtl := FImgForm.GetRealControl;
        BgRect := ClientRect;
        R1 := BgRect;
        BgRect.TopLeft := ClientToScreen(BgRect.TopLeft);
        P := Parent.ClientToScreen(Point(Left, Top));
        ax := BgRect.Left - P.x;
        ay := BgRect.Top - P.y;

        BgRect.BottomRight := ClientToScreen(BgRect.BottomRight);
        BgRect.TopLeft := ACtl.ScreenToClient(BgRect.TopLeft);
        BgRect.BottomRight := ACtl.ScreenToClient(BgRect.BottomRight);

        FImgForm.PaintBkgnd(FBitmap.Canvas.Handle, R1, Point(BgRect.Left - ax, BgRect.Top - ay), False);
      end;
    end
    else
    {$endif}
    begin
{$ifdef MSWINDOWS}
      if IsThemeApplied then
      begin
        DrawThemeBackground(Theme, FBitmap.Canvas.Handle, PP_BAR, 0, R, nil);
        Margin := 4;
        inc(R.Left, Margin);
        inc(R.Top, Margin);
        dec(R.Bottom, Margin);
        dec(R.Right, Margin);

        if FOrientation = poVertical then pid := PP_CHUNKVERT;
      end
      else
{$endif}
      with FBitmap.Canvas do
      begin
        Brush.Color := Self.Color;
        Brush.Style := bsSolid;
        FillRect(R);
      end;
    end;
  end
  else { if Transparent }
  if Transparent then
  begin
    GetClipBox(Canvas.Handle, R);
    OffsetRect(R, Left, Top);
    RedrawWindow(Parent.Handle, @R, 0, RDW_ERASE or RDW_INVALIDATE or
      RDW_NOCHILDREN or RDW_UPDATENOW);
    OffsetRect(R, -Left, -Top);
    BitBlt(FBitmap.Canvas.Handle, R.Left, R.Top, R.Right - R.Left, R.Bottom - R.Top,
      Self.Canvas.Handle, R.Left, R.Top, SRCCOPY);
  end;
  with FBitmap.Canvas do
  begin
    // paint background:
    if FBevelStyle <> ebsNone then
    begin
      Pen.Width := 1;
      // paint bevel rect:
      PartRect := Rect(0, 0, Width - 1, Height - 1);
      with FBitmap.Canvas, PartRect do
      begin
        // calculate color left - top:
        if FBevelStyle = ebsLowered then
          Pen.Color := clBtnShadow
        else
          Pen.Color := clBtnHighlight;
        // bevel left - top:
        PolyLine([
          Point(Left, Bottom),
          Point(Left, Top),
          Point(Right, Top)
        ]);
        // calculate color right - bottom:
        if FBevelStyle = ebsLowered then
          Pen.Color := clBtnHighlight
        else
          Pen.Color := clBtnShadow;
        // bevel right - bottom:
        PolyLine([
          Point(Right, Top),
          Point(Right, Bottom),
          Point(Left, Bottom)
        ]);
      end;
      // skip bevel:
      InflateRect(R, -1, -1);
    end;
    if FScale > 0 then
    try

    // paint of dark part:

      PartRect := R;
      if FOrientation = poHorizontal then
      begin
        DarkSize := Max(MulDiv(DarkValue - MinValue, R.Right - R.Left, Scale - MinValue), 0);
        with PartRect do
          if DarkSize >= (Right - Left) then
            DarkSize := Right
          else
            Right := Left + DarkSize;
{$ifdef MSWINDOWS}
        if IsThemeApplied then
        begin
          GetThemePartSize(Theme, Handle, pid, 0, @PartRect, TS_TRUE, ps);
          LightSize := (DarkSize div ps.cx) * ps.cx;
          if (DarkSize - LightSize) >= (ps.cx div 2) then
            DarkSize := LightSize + ps.cx
          else
            DarkSize := LightSize;
          if DarkSize + R.Left < R.Right then
            R.Right := R.Left + DarkSize
          else
            DarkSize := R.Right;
        end
        else
{$endif}
          R := PartRect;
      end
      else
      begin
        DarkSize := Max(MulDiv(DarkValue - MinValue, R.Bottom - R.Top, Scale - MinValue), 0);
        with PartRect do
          if DarkSize >= Bottom - Top then
            DarkSize := Bottom - Top
          else
            Top := Bottom - DarkSize;
{$ifdef MSWINDOWS}
        if IsThemeApplied then
        begin
          GetThemePartSize(Theme, Handle, pid, 0, @PartRect, TS_TRUE, ps);
          LightSize := (DarkSize div ps.cy) * ps.cy;
          if (DarkSize - LightSize) >= (ps.cy div 2) then
            DarkSize := LightSize + ps.cy
          else
            DarkSize := LightSize;
          if R.Bottom - DarkSize > R.Top then
            R.Top := R.Bottom - DarkSize
          else
            DarkSize := R.Bottom - R.Top;
        end
        else
{$endif}
          R := PartRect;
      end;

      Brush.Color := FDarkColor;
      if FProgrShowMode in [psmDarkHalf, psmAllHalf] then
      begin
        if FOrientation = poHorizontal then
          R.Top := R.Bottom div 2 + Margin div 2
        else
          R.Right := R.Right div 2 + Margin div 2;
      end;

{$ifdef MSWINDOWS}
      if IsThemeApplied then
      begin
        if FDarkValue > 0 then
          if FDarkButtonStyle then
            DrawThemeBackground(FBtnTheme, Handle, BP_PUSHBUTTON, 0, R, nil)
          else
          begin
            DrawThemeBackground(Theme, Handle, pid, 0, R, nil);
            if FOrientation = poVertical then
              StretchBlt(handle, r.Left, r.top, r.Right - R.Left, r.bottom -
                r.top, handle, r.left, r.bottom, r.Right - r.left, r.Top - r.Bottom,
                SRCCOPY);
          end;
      end
      else
{$endif}
      begin
        if FDarkButtonStyle then
        begin
          if FDarkValue > 0 then
          begin
            DrawFrameControl(Handle, R, DFC_BUTTON, DFCS_BUTTONPUSH);
          end;
        end
        else
          if FDarkValue > 0 then
          FillPBRect(R);
      end;

      DarkRect := R;

    //paint of light part:

      R := ClientRect;
      if IsThemeApplied then
      begin
        inc(R.Left, Margin);
        inc(R.Top, Margin);
        dec(R.Bottom, Margin);
        dec(R.Right, Margin);
      end;

      if FBevelStyle <> ebsNone then InflateRect(R, -1, -1);
      if FProgrShowMode in [psmLightHalf, psmAllHalf] then
        if FOrientation = poHorizontal then
          R.Bottom := R.Bottom div 2 + Margin div 2
        else
          R.Left := R.Right div 2 + Margin div 2;

      PartRect := R;
      if FOrientation = poHorizontal then
      begin
        LightSize := MulDiv(LightValue - MinValue, R.Right - R.Left, Scale - MinValue);
        with PartRect do
        begin
          if (FProgrShowMode = psmAllFull) and FAdditive then
            Left := DarkSize;
          if LightSize >= Right - Left then
            LightSize := Right
          else
            Right := Left + LightSize;
        end;
{$ifdef MSWINDOWS}
        if IsThemeApplied then
        begin
          GetThemePartSize(Theme, Handle, pid, 0, @PartRect, TS_TRUE, ps);
          DarkSize := (LightSize div ps.cx) * ps.cx;
          if (LightSize - DarkSize) >= (ps.cx div 2) then
            LightSize := DarkSize + ps.cx
          else
            LightSize := DarkSize;
          if LightSize + R.Left < R.Right then
            R.Right := R.Left + LightSize;
        end
        else
{$endif}
          R := PartRect;
      end
      else
      begin
        LightSize := MulDiv(LightValue - MinValue, R.Bottom - R.Top, Scale - MinValue);
        with PartRect do
        begin
          if (FProgrShowMode = psmAllFull) and FAdditive then
            Top := Bottom - DarkSize;
          if LightSize >= Bottom - Top then
            LightSize := Bottom - Top
          else
            Top := Bottom - LightSize;
        end;
{$ifdef MSWINDOWS}
        if IsThemeApplied then
        begin
          GetThemePartSize(Theme, Handle, pid, 0, @R, TS_TRUE, ps);

          DarkSize := (LightSize div ps.cy) * ps.cy;
          if (LightSize - DarkSize) >= (ps.cy div 2) then
            LightSize := DarkSize + ps.cy
          else
            LightSize := DarkSize;
          if R.Bottom - LightSize > R.Top then
            R.Top := R.Bottom - LightSize;
        end
        else
{$endif}
          R := PartRect;
      end;

      Brush.Color := FLightColor;

{$ifdef MSWINDOWS}
      if IsThemeApplied then
      begin
        if FLightValue > 0 then
          if FLightButtonStyle then
            DrawThemeBackground(FBtnTheme, Handle, BP_PUSHBUTTON, 0, R, nil)
          else
          begin
            DrawThemeBackground(Theme, Handle, pid, 1, R, nil);
            if FOrientation = poVertical then
              StretchBlt(handle, r.Left, r.top, r.Right - R.Left, r.bottom -
                r.top, handle, r.left, r.bottom, r.Right - r.left, r.Top - r.Bottom,
                SRCCOPY);
          end;
      end
      else
{$endif}
      begin
        if FLightButtonStyle then
        begin
          if FLightValue > 0 then
            DrawFrameControl(Handle, R, DFC_BUTTON, DFCS_BUTTONPUSH);
        end
        else
          if FLightValue > 0 then
          FillPBRect(R);
      end;

      LightRect := R;
      R.Left := 1;
      R.Right := Width - 1;

    // paint of dark text:

      Font.Assign(Self.Font);
      Font.Color := FDarkTextColor;
      Brush.Color := clNone;
      Brush.Style := bsClear;
      if Length(FDarkText) > 0 then
      begin
        if not FDarkTextFullLine then
          PartRect := DarkRect
        else
        begin
          PartRect := Rect(0, 0, 0, 0);
  {$IFDEF ELPACK_UNICODE}
          ElVCLUtils.DrawTextW(Handle, PWideChar(FDarkText), Length(FDarkText),
            PartRect, DT_CALCRECT);
  {$ELSE}
          DrawText(Handle, PChar(FDarkText), Length(FDarkText), PartRect, DT_CALCRECT);
  {$ENDIF}
          with PartRect do
            CenterRects(Right - Left, R.Right - R.Left, Bottom - Top, R.Bottom - R.Top, PartRect);
          OffsetRect(PartRect, 0, R.Top);
        end;
  {$IFDEF ELPACK_UNICODE}
        ElVCLUtils.DrawTextW(Handle, PWideChar(FDarkText), Length(FDarkText), PartRect,
          DT_NOPREFIX or DT_CENTER or DT_SINGLELINE or DT_VCENTER);
  {$ELSE}
        DrawText(Handle, PChar(FDarkText), Length(FDarkText), PartRect, DT_NOPREFIX or
          DT_CENTER or DT_SINGLELINE or DT_VCENTER);
  {$ENDIF}
      end;

    // paint of light text:

      Font.Assign(Self.Font);
      Font.Color := FLightTextColor;
      Brush.Color := clNone;
      Brush.Style := bsClear;
      if Length(FLightText) > 0 then
      begin
        if not FLightTextFullLine then
          PartRect := LightRect
        else
        begin
          PartRect := Rect(0, 0, 0, 0);
  {$IFDEF ELPACK_UNICODE}
          ElVCLUtils.DrawTextW(Handle, PWideChar(FLightText), Length(FLightText),
            PartRect, DT_CALCRECT);
  {$ELSE}
          DrawText(Handle, PChar(FLightText), Length(FLightText), PartRect, DT_CALCRECT);
  {$ENDIF}
          with PartRect do
            CenterRects(Right - Left, R.Right - R.Left, Bottom - Top, R.Bottom - R.Top, PartRect);
          OffsetRect(PartRect, 0, R.Top);
        end;
  {$IFDEF ELPACK_UNICODE}
        ElVCLUtils.DrawTextW(Handle, PWideChar(FLightText), Length(FLightText),
          PartRect, DT_NOPREFIX or DT_CENTER or DT_SINGLELINE or DT_VCENTER);
  {$ELSE}
        DrawText(Handle, PChar(FLightText), Length(FLightText), PartRect, DT_NOPREFIX or
          DT_CENTER or DT_SINGLELINE or DT_VCENTER);
  {$ENDIF}
      end;

      if FCaption <> '' then
      begin
        Brush.Style := bsClear;
        Font.Assign(Self.Font);
        PartRect := Rect(0, 0, 0, 0);
        R := ClientRect;
        R.Left := 1;
        R.Right := Width - 1;
  {$IFDEF ELPACK_UNICODE}
        ElVCLUtils.DrawTextW(Handle, PWideChar(FCaption), Length(FCaption), PartRect,
          DT_CALCRECT);
  {$ELSE}
        DrawText(Handle, PChar(FCaption), Length(FCaption), PartRect, DT_CALCRECT);
  {$ENDIF}
        with PartRect do
          CenterRects(Right - Left, R.Right - R.Left, Bottom - Top, R.Bottom - R.Top, PartRect);
        OffsetRect(PartRect, 0, R.Top);
  {$IFDEF ELPACK_UNICODE}
        ElVCLUtils.DrawTextW(Handle, PWideChar(FCaption), Length(FCaption), PartRect,
          DT_NOPREFIX or DT_CENTER or DT_VCENTER);
  {$ELSE}
        DrawText(Handle, PChar(FCaption), Length(FCaption), PartRect, DT_NOPREFIX or
          DT_CENTER or DT_VCENTER);
  {$ENDIF}
      end;
    except
    end;
  end;
  with FBitmap do
    BitBlt(Self.Canvas.Handle, 0, 0, Width, Height, FBitmap.Canvas.Handle, 0, 0, SRCCOPY);
end;

procedure TELBiProgressBar.SetMinValue(NewValue: Integer);
begin
  if (FMinValue <> NewValue) then
  begin
    FMinValue := NewValue;
    Invalidate;
  end; {if}
end; {SetMinValue}

procedure TELBiProgressBar.SetLightButtonStyle(NewValue: Boolean);
begin
  if (FLightButtonStyle <> NewValue) then
  begin
    FLightButtonStyle := NewValue;
    Invalidate;
  end; {if}
end; {SetLightButtonStyle}

procedure TELBiProgressBar.SetDarkButtonStyle(NewValue: Boolean);
begin
  if (FDarkButtonStyle <> NewValue) then
  begin
    FDarkButtonStyle := NewValue;
    Invalidate;
  end; {if}
end; {SetDarkButtonStyle}

procedure TElBiProgressBar.SetOrientation(NewValue: TElProgrOrientation);
begin
  if FOrientation <> NewValue then
  begin
    FOrientation := NewValue;
    if not (csLoading in ComponentState) then
      SetBounds(Left, Top, Height, Width);
    Invalidate;
  end;
end;

procedure TElBiProgressBar.SetSmooth(NewValue: boolean);
begin
  if FSmooth <> NewValue then
  begin
    FSmooth := NewValue;
    Invalidate;
  end;
end;

{
procedure TElBiProgressBar.SetUseXPThemes(const Value: Boolean);
begin
  if FUseXPThemes <> Value then
  begin
    FUseXPThemes := Value;
    if ThemesAvailable then
      Invalidate;
  end;
end;
}
{$IFDEF ELPACK_UNICODE}


procedure TElBiProgressBar.CMHintShow(var Message: TMessage);
var
  T: WideChar;
  HintInfo: PHintInfo;
  l: integer;
  S: String;
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

procedure TElBiProgressBar.SetHint(Value: TElFString);
var
  S: String;
  i,
    l: integer;
  T: WideChar;
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

{$ENDIF ELPACK_UNICODE}

procedure TElBiProgressBar.DefineProperties(Filer: TFiler);
begin
  inherited;
  with GetElReader do
    Filer.DefineProperty('Transparent', FakeBoolean, nil, False);
  Filer.DefineProperty('BorderStyle', ReadBorderStyle, nil, False);
end;

procedure TElBiProgressBar.ReadBorderStyle(Reader: TReader);
var
  S: String;
begin
  s := Reader.ReadIdent;
{$IFDEF ELPACK_4_USED}
  SetEnumProp(Self, 'BevelStyle', s);
{$ENDIF}
end;


procedure TElBiProgressBar.SetTransparent(NewValue: Boolean);
{ Sets data member FTransparent to NewValue. }
begin
  if (FTransparent <> NewValue) then
  begin
    FTransparent := NewValue;
    if FTransparent then
      ControlStyle := ControlStyle - [csOpaque]
    else
      ControlStyle := ControlStyle + [csOpaque];
    if HandleAllocated then
      RecreateWnd;
  end; { if }
end; { SetTransparent }

procedure TElBiProgressBar.CreateParams(var Params: TCreateParams);
begin
  inherited;
  if Transparent then
    Params.ExStyle := Params.ExStyle or WS_EX_TRANSPARENT
  else
    Params.ExStyle := Params.ExStyle and not WS_EX_TRANSPARENT;
end; { CreateParams }


end.
