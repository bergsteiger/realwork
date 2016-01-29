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

03/10/2003

  Alignment property renamed to CheckAlignment

03/08/2003

  Focus is now set only when the item is clicked with left button

03/02/2003

  Added EndEllipsis property

10/12/2002

  AdjustAutoSize doesn't cause an exception if the handle is not allocated

09/06/2002

  Fixed background drawing issues with XP styles enabled

08/21/2002 (c) Akzhan Abdulin

  Some property defaults added.

06/05/2002

  Deletion of LinkPopupMenu component didn't clear the property. Fixed.

02/08/2002

  imagelist removal was not tracked. Fixed.

01/31/2002

  Fixed the bug with right-clicks when IsHTML is false

12/25/2001

  Added LinkPopupMenu, LinkStyle and LinkColor properties

11/28/2001

  Added MoneyFlat and accompanying properties

11/20/2001

  Fixed an exception that happens when CheckBox is dropped to the form
  (introduced recently)

11/17/2001

  Removed flicker with XP styles enabled

11/10/2001

  in RadioButton now Checked state follows focus (this behaviour was spoiled
  during CLX adaptation)

11/05/2001

  Disabled controls are flat now too

10/26/2001

  Fixed painting of background with XP styles enabled

10/21/2001

  Text was not drawn when Unicode is off (spoiled during CLX adaptation). Fixed.

10/16/2001

  CLX adaptation complete

09/17/2001

  Added Windows XP Themes Support

07/26/2001

  Added Unicode support

05/26/2001

  HTML support added

10/06/2000

  Margin between text and glyph increased

10/05/2000

  Click reaction improved

09/14/2000

  Multiline property added

*)

unit ElCheckCtl;

interface

uses
{$ifdef VCL_6_USED}
  Types,
{$endif}
  Controls,
  Messages,
  Windows,
  Graphics,
  Forms,
  StdCtrls,
  Menus,
  CommCtrl,
{$ifdef VCL_4_USED}
  ImgList,
{$endif}
  SysUtils,
  Classes,
{$IFDEF HAS_HTML_RENDER}
  HTMLRender,
{$ENDIF}
{$ifdef MSWINDOWS}
  ElTmSchema,
  ElUxTheme,
{$endif}
{$ifdef ELPACK_USE_IMAGEFORM}
  ElImgFrm,
{$endif}
  ElSndMap,
  ElVCLUtils,
  ElBtnCtl,
{$ifdef HAS_HTML_RENDER}
  ElHandPt,
{$endif}
  TypInfo,
  ElStrUtils,
  ElTools;

type
  TElCheckItem = class(TElButtonControl)
  private
    FFlat : Boolean;
{$IFDEF USE_SOUND_MAP}
    FSoundMap : TElSoundMap;
{$ENDIF}
    FCheckSound : TElSoundName;
    FUseCustomGlyphs : Boolean;
    FGlyph : TBitmap;
    FAlignment : TLeftRight;
    FMouseInControl : boolean;
    FPressed : boolean;
    FOldCapture : HWND;
    FChLink  : TChangeLink;
    FAChLink  : TChangeLink;
    // FDoFocus : boolean;
    {$ifdef ELPACK_USE_IMAGEFORM}
    FImgForm : TElImageForm;
    FImgFormChLink  : TImgFormChangeLink;
    {$endif}
    FAutoSize       : boolean;
{$ifdef HAS_HTML_RENDER}
    FIsHTML  : Boolean;
    FRender  : TElHTMLRender;
{$endif}
    // FMultiLine: boolean;
    FModified : boolean;
    FImages  : TImageList;
    FAlphaImages  : TImageList;
    FUseImageList: Boolean;
    FCursor: TCursor;
    FTextPos: TPoint;
    {$IFDEF HAS_HTML_RENDER}
    FLinkColor: TColor;
    FLinkPopupMenu: TPopupMenu;
    FLinkStyle: TFontStyles;
    {$endif}
    {$IFDEF HAS_HTML_RENDER}
    FOnImageNeeded: TElHTMLImageNeededEvent;
    FOnLinkClick: TElHTMLLinkClickEvent;
    {$endif}
    // procedure SetMultiLine(value : boolean);
    procedure AdjustAutoSize;
    {$ifdef ELPACK_USE_IMAGEFORM}
    procedure ImageFormChange(Sender: TObject);
    {$endif}
    procedure ImagesChanged(Sender: TObject);
    {$ifdef ELPACK_USE_IMAGEFORM}
    procedure setImageForm(newValue : TElImageForm);
    {$endif}
    procedure setUseCustomGlyphs(newValue : Boolean);
    procedure setGlyph(newValue : TBitmap);
    procedure setAlignment(newValue : TLeftRight);
{$IFDEF USE_SOUND_MAP}
    procedure setSoundMap(newValue : TElSoundMap);
{$ENDIF}
{$ifdef HAS_HTML_RENDER}
    procedure SetIsHTML(Value: Boolean);
{$endif}
    procedure CMEnabledChanged(var Msg : TMessage); message CM_ENABLEDCHANGED;
    procedure CMMouseLeave(var Msg : TMessage); message CM_MOUSELEAVE;
    procedure CMMouseEnter(var Msg : TMessage); message CM_MOUSEENTER;
//    procedure CMExit(var Msg : TCMExit); message CM_EXIT;
//    procedure CMEnter(var Msg : TCMEnter); message CM_ENTER;
    procedure CMTextChanged(var Msg : TMessage); message CM_TEXTCHANGED;
    procedure CMFocusChanged(var Msg : TCMFocusChanged); message CM_FOCUSCHANGED;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure SetFlat(newValue : Boolean);
    procedure SetImages(Value: TImageList);
    procedure SetAlphaImages(Value: TImageList);
    procedure SetUseImageList(Value: Boolean);
  protected
    { Protected declarations }
    FFlatAlways: Boolean;
    FHandleDialogKeys: Boolean;
    FEndEllipsis: Boolean;
    FReadOnly: Boolean;
    function GetPartId: Integer;
    function GetCheckBoxSize: TSize;
    procedure setAutoSize(newValue : boolean);
{$ifdef VCL_6_USED}
    override;
{$endif}

    procedure DoEnter; override;
    procedure DoExit; override;

    procedure WMEraseBkgnd(var Msg : TWMEraseBkGnd); message WM_ERASEBKGND;
    procedure Notification(AComponent : TComponent; operation : TOperation);
        override;
    procedure GlyphChange(Sender : TObject); virtual;
    procedure DrawFlatFrame(Canvas : TCanvas; R : TRect); virtual; abstract;
    procedure DrawGlyph(Canvas : TCanvas; DestRect: TRect; SrcRect: TRect); virtual;
    procedure MouseDown(Button : TMouseButton; Shift : TShiftState; X, Y : Integer); override;
    procedure MouseUp(Button : TMouseButton; Shift : TShiftState; X, Y : Integer); override;
    procedure KeyDown(var Key : Word; Shift : TShiftState); override;
    procedure Paint; override;
    procedure SetFlatAlways(Value: Boolean);
    {$ifdef ELPACK_USE_IMAGEFORM}
    procedure IFMRepaintChildren(var Message: TMessage); message
        IFM_REPAINTCHILDREN;
    procedure WMWindowPosChanged(var Message: TWMWindowPosChanged); message
        WM_WINDOWPOSCHANGED;
    {$endif}
    procedure WMGetDlgCode(var Msg : TWMGetDlgCode); message WM_GETDLGCODE;
    {$ifdef VCL_5_USED}
    procedure WMContextMenu(var Message: TWMContextMenu); message WM_CONTEXTMENU;
    {$endif}
    procedure WMRButtonUp(var Message: TWMRButtonUp); message WM_RBUTTONUP;

    procedure CreateWnd; override;
    function CalcAutoHeight(Multiline : boolean) : Integer; virtual;
    procedure SetCursor(newValue : TCursor); virtual;
    {$IFDEF HAS_HTML_RENDER}
    function CalcTextRect: TRect;
    {$endif}
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    {$IFDEF HAS_HTML_RENDER}
    procedure SetLinkPopupMenu(newValue : TPopupMenu);
    procedure SetLinkColor(newValue : TColor); virtual;
    procedure SetLinkStyle(newValue : TFontStyles); virtual;
    procedure DoLinkPopup(MousePos : TPoint);
    procedure TriggerImageNeededEvent(Sender : TObject; Src : TElFString; var Image
        : TBitmap);
    procedure TriggerLinkClickEvent(HRef : TElFString); virtual;
    {$endif}
    procedure DefineProperties(Filer: TFiler); override;
    procedure ReadAlignment(Reader: TReader);
    procedure SetEndEllipsis(Value: Boolean);

    property CheckSound : TElSoundName read FCheckSound write FCheckSound; { Protected }
{$IFDEF USE_SOUND_MAP}
    property SoundMap   : TElSoundMap read FSoundMap write SetSoundMap;
{$ENDIF}
    property CheckAlignment : TLeftRight read FAlignment write SetAlignment default taRightJustify; { Protected }
    property UseCustomGlyphs : Boolean read FUseCustomGlyphs write SetUseCustomGlyphs default false; { Protected }
    property Glyph : TBitmap read FGlyph write SetGlyph; { Published }
    property Flat : Boolean read FFlat write SetFlat default false; { Published }
    {$ifdef ELPACK_USE_IMAGEFORM}
    property ImageForm : TElImageForm read FImgForm write SetImageForm;
    {$endif}
    property AutoSize : boolean read FAutoSize write SetAutoSize default true;
{$ifdef HAS_HTML_RENDER}
    property IsHTML : Boolean read FIsHTML write SetIsHTML default false;
{$endif}
    // property Multiline: boolean read FMultiline write SetMultiline default false;
    property FlatAlways: Boolean read FFlatAlways write SetFlatAlways default false;
    property Images: TImageList read FImages write SetImages;
    property AlphaForImages: TImageList read FAlphaImages write SetAlphaImages;
    property UseImageList: Boolean read FUseImageList write SetUseImageList default
        false;
    property EndEllipsis: Boolean read FEndEllipsis write SetEndEllipsis default
        false;
  public
    { Public declarations }
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;
    procedure Click; override;
    property Modified : boolean read FModified write FModified;

    property Cursor: TCursor read FCursor write SetCursor;
    {$IFDEF HAS_HTML_RENDER}
    property LinkColor: TColor read FLinkColor write SetLinkColor default clBlue;
    property LinkPopupMenu: TPopupMenu read FLinkPopupMenu write SetLinkPopupMenu;
    property LinkStyle: TFontStyles read FLinkStyle write SetLinkStyle default [fsUnderline];

    property OnImageNeeded: TElHTMLImageNeededEvent read FOnImageNeeded write
        FOnImageNeeded;
    property OnLinkClick: TElHTMLLinkClickEvent read FOnLinkClick write
        FOnLinkClick;
    {$endif}
  published
    property HandleDialogKeys: Boolean read FHandleDialogKeys write
        FHandleDialogKeys default false;
    property ReadOnly: Boolean read FReadOnly write FReadOnly default false;
  end; { TElCheckItem }

  TElCheckBox = class(TElCheckItem)
  private
    { Private declarations }
    FState : TCheckBoxState;
    FAllowGrayed : Boolean;
    procedure SetState(newValue : TCheckBoxState);
    procedure SetAllowGrayed(newValue : Boolean);
  protected
    function GetChecked : Boolean; override;
    procedure SetChecked(newValue : Boolean); override;
    procedure DrawFlatFrame(Canvas : TCanvas; R : TRect); override;
    procedure Toggle; virtual;
  published
    property CheckAlignment;
    property AllowGrayed : Boolean read FAllowGrayed write SetAllowGrayed default false; { Published }
    property State : TCheckBoxState read FState write SetState default cbUnchecked; { Published }

    property EndEllipsis;
    property AutoSize;
    property UseCustomGlyphs;
    property Checked;
    property CheckSound;
{$IFDEF USE_SOUND_MAP}
    property SoundMap;
{$ENDIF}
    property Glyph;
    {$ifdef ELPACK_USE_IMAGEFORM}
    property ImageForm;
    {$endif}
    // property Multiline;
    property TextDrawType;
    property Transparent;
    property Flat;
    property FlatAlways;
{$ifdef HAS_HTML_RENDER}
    property IsHTML;
{$endif}
    property Images;
    property AlphaForImages;

    property Cursor;
    {$IFDEF HAS_HTML_RENDER}
    property LinkColor;
    property LinkPopupMenu;
    property LinkStyle;
    property OnImageNeeded;
    property OnLinkClick;
    {$endif}

    property MoneyFlat;
    property MoneyFlatActiveColor;
    property MoneyFlatInactiveColor;
    property MoneyFlatDownColor;
    property UseImageList;

    // VCL properties
    property Caption;
    property Enabled;
    property TabStop default True;
    property TabOrder;
    property PopupMenu;
    property Color;
    property ParentColor;
    property Align;
    property Font;
    property ParentFont;
    property ParentShowHint;
    property ShowHint;
    {$ifdef MSWINDOWS}
    property UseXPThemes;
    {$endif}
    property Visible;

    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnStartDrag;

{$IFDEF VCL_4_USED}
    property Anchors;
    property Action;
    property Constraints;
    property DockOrientation default doNoOrient;
    property Floating;
    property DoubleBuffered;
    property DragKind;
    property OnStartDock;
    property OnEndDock;
{$ENDIF}
{$IFDEF VCL_5_USED}
    property OnContextPopup;
{$ENDIF}
  end; { TElCheckBox }

  TElRadioButton = class(TElCheckItem)
  private
    FChecked : boolean;
  protected
    procedure DrawFlatFrame(Canvas : TCanvas; R : TRect); override;
    function GetChecked : Boolean; override;
    procedure SetChecked(newValue : Boolean); override;
  published
    property AutoSize;
    property Checked;
    property EndEllipsis;
    property Cursor;
    {$ifdef HAS_HTML_RENDER}
    property LinkColor;
    property LinkPopupMenu;
    property LinkStyle;

    property OnImageNeeded;
    property OnLinkClick;
    {$endif}

    property UseCustomGlyphs;
{$IFDEF USE_SOUND_MAP}
    property CheckSound;
    property SoundMap;
{$ENDIF}
    property CheckAlignment;
    property Glyph;
    {$ifdef ELPACK_USE_IMAGEFORM}
    property ImageForm;
    {$endif}
    property MoneyFlat;
    property MoneyFlatActiveColor;
    property MoneyFlatInactiveColor;
    property MoneyFlatDownColor;
    // property Multiline;
    property Transparent;
    property TextDrawType;
    property Flat;
    property FlatAlways;
{$ifdef HAS_HTML_RENDER}
    property IsHTML;
{$endif}
    property Images;
    property AlphaForImages;
    property UseImageList;
    {$ifdef MSWINDOWS}
    property UseXPThemes;
    {$endif}

    // VCL properties
    property Caption;
    property Enabled;
    property TabStop default True;
    property TabOrder;
    property PopupMenu;
    property Color;
    property ParentColor;
    property Align;
    property Font;
    property ParentFont;
    property ParentShowHint;
    property ShowHint;
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;

    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnStartDrag;

    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;


{$IFDEF VCL_4_USED}
    property Anchors;
    property Action;
    property Constraints;
    property DockOrientation default doNoOrient;
    property Floating;
    property DoubleBuffered;
    property DragKind;

    property OnStartDock;
    property OnEndDock;

{$ENDIF}
{$IFDEF VCL_5_USED}
    property OnContextPopup;
{$ENDIF}
  end; { TElRadioButton }

const
  CheckMargin = 5;
  {$ifdef MSWINDOWS}
  CheckBoxSize = 13;
  {$else}
  CheckBoxSize = 0;
  {$endif}

implementation

const EllipsisFlags : array [boolean] of integer = (0, DT_END_ELLIPSIS);

{$ifdef ELPACK_USE_IMAGEFORM}
procedure TElCheckItem.ImageFormChange(Sender : TObject);
begin
  Invalidate;
end;
{$endif}

function TElCheckItem.CalcAutoHeight(Multiline : boolean): Integer;
var ay : integer;
    R : TRect;
    al : integer;
begin
  result := GetCheckBoxSize.cy;
  if not HandleAllocated then exit;
  if FUseCustomGlyphs and (not FGlyph.Empty) then
  begin
    ay := FGlyph.Height;
  end
  else
  begin
    if FUSeImageList then
    begin
      ay := FImages.Height;
    end
    else
    begin
      ay := GetCheckBoxSize.cy;
    end;
  end;
  inc(ay, 4);
  Canvas.Font.Assign(Font);
  SetRectEmpty(R);
  if not Multiline then
    AL := DT_SINGLELINE
  else
    AL := 0;
  {$ifdef HAS_HTML_RENDER}
  if IsHTML then
  begin
    FRender.Data.DefaultColor := Font.Color;
    FRender.Data.DefaultBgColor := clNone;
    FRender.Data.DefaultStyle := Font.Style;
    FRender.Data.DefaultHeight := Font.Height;
    FRender.Data.DefaultFont := Font.Name;
    FRender.Data.LinkColor := LinkColor;
    FRender.Data.LinkStyle := LinkStyle;
    FRender.Data.Charset := Font.Charset;

    FRender.PrepareText(FCaption, 0, false);
    R.Right  := FRender.Data.TextSize.cx;
    R.Bottom := FRender.Data.TextSize.cy;
  end
  else
  {$endif}
  begin
    {$ifdef ELPACK_UNICODE}
    ElVCLUtils.DrawTextW(Canvas.Handle, PWideChar(Caption), Length(Caption), R, AL or DT_LEFT or DT_CALCRECT);
    {$else}
    DrawText(Canvas.Handle, PChar(Caption), Length(Caption), R, AL or DT_LEFT or DT_CALCRECT);
    {$endif}
  end;
  ay := Max(ay, R.Bottom - R.Top + CheckMargin div 2);
  if TextDrawType <> tdtNormal then
    inc(ay, 2);
  result := ay;
end;

procedure TElCheckItem.AdjustAutoSize;
var ax, ay : integer;
    R : TRect;
    al : integer;
begin
  if (ComponentState * [csDestroying, csLoading, csReading] <> []) or
     (Parent = nil) or (not HandleAllocated) then exit;
  ax := 0;
  if IsThemeApplied then
  begin
    inc(ax, GetCheckBoxSize.cx);
    ay := GetCheckBoxSize.cy;
  end
  else
  if FUseCustomGlyphs and (not FGlyph.Empty) then
  begin
    inc(ax, FGlyph.Width div 6);
    ay := FGlyph.Height;
  end
  else
  begin
    if FUseImageList then
    begin
      inc(ax, FImages.Width);
      ay := FImages.Height;
    end
    else
    begin
      inc(ax, GetCheckBoxSize.cx);
      ay := GetCheckBoxSize.cy;
    end;
  end;
  inc(ax, CheckMargin + CheckMargin div 2);
  inc(ay, 4);
  Canvas.Font.Assign(Font);
  SetRectEmpty(R);
  {$ifdef HAS_HTML_RENDER}
  if IsHTML then
  begin
    FRender.Data.DefaultColor := Font.Color;
    FRender.Data.DefaultBgColor := clNone;
    FRender.Data.DefaultStyle := Font.Style;
    FRender.Data.DefaultHeight := Font.Height;
    FRender.Data.DefaultFont := Font.Name;
    FRender.Data.Charset := Font.Charset;
    FRender.Data.LinkColor := LinkColor;
    FRender.Data.LinkStyle := LinkStyle;

    FRender.PrepareText(FCaption, 0, false);
    R.Right  := FRender.Data.TextSize.cx;
    R.Bottom := FRender.Data.TextSize.cy;
  end
  else
  {$endif}
  begin
    {if not FMultiline then
      AL := DT_SINGLELINE
    else
      }AL := 0;
    {$ifdef ELPACK_UNICODE}
    ElVCLUtils.DrawTextW(Canvas.Handle, PWideChar(Caption), Length(Caption), R, AL or DT_LEFT or DT_CALCRECT);
    {$else}
    DrawText(Canvas.Handle, PChar(Caption), Length(Caption), R, AL or DT_LEFT or DT_CALCRECT);
    {$endif}
  end;
  inc(ax, R.Right - R.Left + 2);
  ay := Max(ay, R.Bottom - R.Top + CheckMargin div 2);
  if TextDrawType <> tdtNormal then
    inc(ay, 2);
  if HandleAllocated then
     SetBounds(Left, Top, ax, ay);
end;

(*
procedure TElCheckItem.SetMultiLine(value : boolean);
begin
  if FMultiline <> Value then
  begin
    FMultiline := Value;
    if FAutoSize then AdjustAutoSize;
    if Pos(#13#10, Caption) > 0 then Invalidate;
  end;
end;
*)
procedure TElCheckItem.SetAutoSize(newValue : boolean);
begin
  if FAutoSize <> newValue then
  begin
    FAutoSize := newValue;
    if FAutoSize then AdjustAutoSize;
  end;
end;

{$ifdef ELPACK_USE_IMAGEFORM}
procedure TElCheckItem.SetImageForm(newValue : TElImageForm);
begin
  if FImgForm <> newValue then
  begin
    if FImgForm <> nil then
    begin
      {$ifdef VCL_5_USED}
      if not (csDestroying in FImgForm.ComponentState) then
        FImgForm.RemoveFreeNotification(Self);
      {$endif}
      FImgForm.UnRegisterChanges(FImgFormChLink);
    end;
    if newValue <> nil then
       newValue.FreeNotification(Self);
    FImgForm := newValue;
    if FImgForm <> nil then FImgForm.RegisterChanges(FImgFormChLink);
    Invalidate;
  end;
end;
{$endif}

procedure TElCheckItem.SetUseCustomGlyphs(newValue : Boolean);
{ Sets data member FUseCutomGlyphs to newValue. }
begin
  if (FUseCustomGlyphs <> newValue) then
  begin
    FUseCustomGlyphs := newValue;
    if AutoSize then AdjustAutoSize;
    Invalidate;
  end; { if }
end; { SetUseCutomGlyphs }

procedure TElCheckItem.SetGlyph(newValue : TBitmap);
{ Sets data member FGlyph to newValue. }
begin
  FGlyph.Assign(newValue);
  FGlyph.Transparent := True;
end; { SetGlyph }

procedure TElCheckItem.SetAlignment(newValue : TLeftRight);
{ Sets data member FAlignment to newValue. }
begin
  if (FAlignment <> newValue) then
  begin
    FAlignment := newValue;
    Invalidate;
  end; { if }
end; { SetAlignment }

procedure TElCheckItem.WMEraseBkGnd(var Msg : TWMEraseBkGnd);
begin
  if IsThemeApplied then
  begin
  end;
  Msg.Result := 1; { Return non-zero so windows doesn't step on our work. }
end; { WMEraseBkGnd }

{$IFDEF USE_SOUND_MAP}
procedure TElCheckItem.SetSoundMap(newValue : TElSoundMap);
begin
  if (FSoundMap <> newValue) then
  begin
    {$ifdef VCL_5_USED}
    if FSoundMap <> nil then
      if not (csDestroying in FSoundMap.ComponentState) then
        FSoundMap.RemoveFreeNotification(Self);
    {$endif}
    FSoundMap := newValue;
    if FSoundMap <> nil then
      FSoundMap.FreeNotification(Self);
  end; { if }
end; { SetSoundMap }
{$ENDIF}

procedure TElCheckItem.Notification(AComponent : TComponent; operation :
    TOperation);
begin
  inherited Notification(AComponent, operation);
  if (operation = opRemove) then
  begin
{$IFDEF USE_SOUND_MAP}
    if (AComponent = FSoundMap) then FSoundMap := nil;
{$ENDIF}
   if (AComponent = FImages) then
     Images := nil;
   if (AComponent = FAlphaImages) then
     AlphaForImages := nil;
   {$ifdef HAS_HTML_RENDER}
   if AComponent = LinkPopupMenu then
     LinkPopupMenu := nil;
   {$endif}
{$ifdef ELPACK_USE_IMAGEFORM}
    if AComponent = FImgForm then
    begin
      ImageForm := nil;
      Invalidate;
    end;
{$endif}
  end; { if }
end; { Notification }

procedure TElCheckItem.GlyphChange(Sender : TObject);
begin
  if AutoSize then AdjustAutoSize;
  if UseCustomGlyphs then Invalidate;
end;
{$WARNINGS off}


procedure TElCheckItem.Paint; { public }
var
  XRect,
  {$ifdef ELPACK_USE_IMAGEFORM}
  BgRect,
  {$endif}
  {$ifdef MSWINDOWS}
  RClip,
  {$endif}
  R1,
  ARect : TRect;
  SrcRect,
  CheckRect : TRect;
  cbh,
  cbw   : integer;
  i     : integer;
  {$ifdef ELPACK_USE_IMAGEFORM}
  ACtl  : TWinControl;
  {$endif}
  OldP,
  P     : TPoint;
  {$ifdef ELPACK_USE_IMAGEFORM}
  ax, ay: integer;
  {$endif}
  al
  ,al2
     : integer;
  ImgIdx: integer;
  Canvas: TCanvas;
  Bitmap: TBitmap;

  {$ifdef MSWINDOWS}
  pid,
  sid   : integer;
  {$endif}
  PX    : TSize;
  //HRes  : HRESULT;
(*
  HR    : HRESULT;
  TM    : TTextMetric;
  LFont : TLogFont;
  WX    : TSize;
*)
  {$ifdef HAS_HTML_RENDER}
  AColor: COLORREF;
  {$endif}
  BMP, amBMP : TBitmap;

begin
  Bitmap := TBitmap.Create;
  Bitmap.Width := ClientWidth;
  Bitmap.Height := ClientHeight;
  Canvas := Bitmap.Canvas;

  Bitmap.Handle := CreateCompatibleBitmap(Canvas.Handle, ClientWidth, ClientHeight);

  {$ifdef MSWINDOWS}
  if IsThemeApplied then
  with Bitmap do
  begin
    P := Point(Left, Top);
    SetMapMode(Canvas.Handle, MM_ANISOTROPIC);
    SetViewPortOrgEx(Canvas.Handle, -P.x, -P.y, @OldP);
    SendMessage(Parent.Handle, WM_ERASEBKGND, Canvas.Handle, 0);
    SetViewPortOrgEx(Canvas.Handle, OldP.x, OldP.y, nil);
    SetMapMode(Canvas.Handle, MM_TEXT);
  end
  else
  {$endif}
  if (not Transparent) then
  begin
    {$ifdef ELPACK_USE_IMAGEFORM}
    if (FImgForm <> nil) and (not (csDesigning in FImgForm.ComponentState)) then
    begin
      if (FImgForm.Control <> Self) then
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

        FImgForm.PaintBkgnd(Canvas.Handle, R1, Point(BgRect.Left - ax, BgRect.Top - ay), false);
      end
    end
    else
    {$endif}
    begin
      Canvas.Brush.Color := Color;
      Canvas.FillRect(ClientRect);
    end;
  end
  else
  begin
    GetClipBox(Self.Canvas.Handle, ARect);
    OffsetRect(ARect, Left, Top);
    RedrawWindow(Parent.Handle, @ARect, 0, RDW_ERASE or RDW_INVALIDATE or RDW_NOCHILDREN or RDW_UPDATENOW);
    OffsetRect(ARect, -Left, -Top);
    bitblt(Canvas.Handle, ARect.Left, ARect.Top, ARect.Right - ARect.Left, ARect.Bottom - ARect.Top, Self.Canvas.Handle, ARect.Left, ARect.Top, SRCCOPY);
  end;
  ARect := ClientRect;
  ImgIdx := 0;
  {$ifdef MSWINDOWS}
  if (not IsThemeApplied) then
  {$endif}
  begin
    if FUseCustomGlyphs and (not FGlyph.Empty) then
    begin
      cbh := FGlyph.Height;
      cbw := FGlyph.Width div 6;

      if Self is TElRadioButton then
      begin
        if not Checked then
        begin
          if Enabled and (not (FPressed and FMouseInControl))
          then
            SrcRect := Rect(0, 0, cbw, cbh)
          else
            SrcRect := Rect(cbw, 0, cbw * 2, cbh);
        end
        else
        begin
          if Enabled and (not (FPressed and FMouseInControl))
          then
            SrcRect := Rect(cbw * 2, 0, cbw * 3, cbh)
          else
            SrcRect := Rect(cbw * 3, 0, cbw * 4, cbh);
        end;
      end
      else
      if Self is TElCheckBox then
      begin
        case TElCheckBox(Self).State of
          cbUnchecked :
            if Enabled and (not (FPressed and FMouseInControl))
            then
              SrcRect := Rect(0, 0, cbw, cbh)
            else
              SrcRect := Rect(cbw, 0, cbw * 2, cbh);
          cbChecked :
            if Enabled and (not (FPressed and FMouseInControl))
            then
              SrcRect := Rect(cbw * 2, 0, cbw * 3, cbh)
            else
              SrcRect := Rect(cbw * 3, 0, cbw * 4, cbh);
          cbGrayed :
            if Enabled and (not (FPressed and FMouseInControl))
            then
              SrcRect := Rect(cbw * 4, 0, cbw * 5, cbh)
            else
              SrcRect := Rect(cbw * 5, 0, cbw * 6, cbh);
        end;
      end
      else
      begin
        cbh := 0;
        cbw := 0;
        SrcRect := Rect(0, 0, 0, 0);
      end;
    end
    else
    begin
      if FUseImageList then
      begin
        cbw := FImages.Width;
        cbh := FImages.Height;
        if Self is TElRadioButton then
        begin
          if not Checked then
          begin
            if Enabled and (not (FPressed and FMouseInControl))
            then
              ImgIdx := 0
            else
              ImgIdx := 1;
          end
          else
          begin
            if Enabled and (not (FPressed and FMouseInControl))
            then
              ImgIdx := 2
            else
              ImgIdx := 3;
          end;
        end
        else
        if Self is TElCheckBox then
        begin
          case TElCheckBox(Self).State of
            cbUnchecked :
              if Enabled and (not (FPressed and FMouseInControl))
              then
                ImgIdx := 0
              else
                ImgIdx := 1;
            cbChecked :
              if Enabled and (not (FPressed and FMouseInControl))
              then
                ImgIdx := 2
              else
                ImgIdx := 3;
            cbGrayed :
              if Enabled and (not (FPressed and FMouseInControl))
              then
                ImgIdx := 4
              else
                ImgIdx := 5;
          end;
        end;
      end
      else
      begin
        cbw := GetCheckBoxSize.cx;
        cbh := GetCheckBoxSize.cy;
      end;
      i := DFCS_BUTTONCHECK or DFCS_CHECKED;
      if Self is TElRadioButton then
      begin
        if Checked
          then
          i := DFCS_BUTTONRADIO or DFCS_CHECKED
        else
          i := DFCS_BUTTONRADIO;
      end
      else if Self is TElCheckBox then
      begin
        case TElCheckBox(Self).State of
          cbChecked : i := DFCS_BUTTONCHECK or DFCS_CHECKED;
          cbUnchecked : i := DFCS_BUTTONCHECK;
          cbGrayed : i := DFCS_BUTTON3STATE or DFCS_CHECKED;
        end; // case
      end;
      if (not Enabled) or (FMouseInControl and FPressed) then i := i or DFCS_INACTIVE;
    end;

    if (CheckAlignment = taRightJustify)
  {$IFDEF VCL_4_USED}
    xor UseRightToLeftAlignment
  {$ENDIF}
    then
    begin
      {$ifdef ELPACK_UNICODE}
      if WidePos(WideString(#13#10), Caption) = 0 then
      {$else}
      if Pos(#13#10, Caption) = 0 then
      {$endif}
      begin
        CheckRect := Rect(0, (ClientHeight div 2 - cbh div 2), cbw, 0);
        CheckRect.Bottom := CheckRect.Top + cbh;
      end
      else
      begin
        CheckRect := Rect(0, 0, cbw, 0);
        CheckRect.Top := (CalcAutoHeight(false) div 2 - cbh div 2);
        CheckRect.Bottom := CheckRect.Top + cbh;
      end;
    end
    else
    begin
      {$ifdef ELPACK_UNICODE}
      if WidePos(WideString(#13#10), Caption) = 0 then
      {$else}
      if Pos(#13#10, Caption) = 0 then
      {$endif}
      begin
        CheckRect := Rect(Width - cbw, (ClientHeight div 2 - cbh div 2), Width, 0);
        CheckRect.Bottom := CheckRect.Top + cbh;
      end
      else
      begin
        CheckRect        := Rect(Width - cbw, 0, Width, 0);
        CheckRect.Top    := (CalcAutoHeight(false)  div 2 - cbh div 2);
        CheckRect.Bottom := CheckRect.Top + cbh;
      end;
    end;
    if UseCustomGlyphs and (not FGlyph.Empty) then
      DrawGlyph(Canvas, CheckRect, SrcRect)
    else
    begin
      if FUseImageList then
      begin
        if (FAlphaImages <> nil) and (FAlphaImages.Count > ImgIdx) then
        begin
          BMP := TBitmap.Create;
          BMP.Width := FImages.Width;
          BMP.Height := FImages.Height;
          ImageList_DrawEx(FImages.Handle, ImgIdx, BMP.Canvas.Handle, 0, 0, 0, 0,
            clNone, clNone, ILD_Normal);

          amBMP := TBitmap.Create;
          amBMP.Width := FAlphaImages.Width;
          amBMP.Height := FAlphaImages.Height;
          ImageList_DrawEx(FAlphaImages.Handle, ImgIdx, amBMP.Canvas.Handle, 0, 0, 0, 0,
            clNone, clNone, ILD_Normal);

          AlphaCopyRect2(Canvas.Handle, CheckRect, BMP.Canvas.Handle,
            rect(0, 0, BMP.Width, BMP.Height), amBMP, 255);

          amBMP.Free;
          BMP.Free;
        end
        else
          FImages.Draw(Canvas, CheckRect.Left, CheckRect.Top, ImgIdx);
      end
      else
      begin
        DrawFrameControl(Canvas.Handle, CheckRect, DFC_BUTTON, i);
        if MoneyFlat or (Flat and (not (Focused or FMouseInControl or FPressed) or FlatAlways)) {and Enabled} then
          DrawFlatFrame(Canvas, CheckRect);
      end;
    end;
  {$ifdef MSWINDOWS}
  end
  else // XP-style checkmarks
  begin
    if Self is TElCheckBox then
    begin
      pid := BP_CHECKBOX;
      case TElCheckBox(Self).State of
        cbUnchecked :
          if not Enabled then
            sid := CBS_UNCHECKEDDISABLED
          else
          if FPressed then
            sid := CBS_UNCHECKEDPRESSED
          else
          if FMouseInControl then
            sid := CBS_UNCHECKEDHOT
          else
            sid := CBS_UNCHECKEDNORMAL;

        cbChecked :
          if not Enabled then
            sid := CBS_CHECKEDDISABLED
          else
          if FPressed then
            sid := CBS_CHECKEDPRESSED
          else
          if FMouseInControl then
            sid := CBS_CHECKEDHOT
          else
            sid := CBS_CHECKEDNORMAL;

        cbGrayed :
          if not Enabled then
            sid := CBS_MIXEDDISABLED
          else
          if FPressed then
            sid := CBS_MIXEDPRESSED
          else
          if FMouseInControl then
            sid := CBS_MIXEDHOT
          else
            sid := CBS_MIXEDNORMAL;
      end;
    end
    else
    begin
      pid := BP_RADIOBUTTON;
      if not Checked then
      begin
        if not Enabled then
          sid := RBS_UNCHECKEDDISABLED
        else
        if FPressed then
          sid := RBS_UNCHECKEDPRESSED
        else
        if FMouseInControl then
          sid := RBS_UNCHECKEDHOT
        else
          sid := RBS_UNCHECKEDNORMAL;
      end
      else
      begin
        if not Enabled then
          sid := RBS_CHECKEDDISABLED
        else
        if FPressed then
          sid := RBS_CHECKEDPRESSED
        else
        if FMouseInControl then
          sid := RBS_CHECKEDHOT
        else
          sid := RBS_CHECKEDNORMAL;
      end;
    end;

    PX.cx := 0;
    PX.cy := 0;

    ARect := ClientRect;
    cbw := GetCheckBoxSize.cx;
    cbh := GetCheckBoxSize.cy;

    if (CheckAlignment = taRightJustify)
  {$IFDEF VCL_4_USED}
    xor UseRightToLeftAlignment
  {$ENDIF}
    then
    begin
      {$ifdef ELPACK_UNICODE}
      if WidePos(WideString(#13#10), Caption) = 0 then
      {$else}
      if Pos(#13#10, Caption) = 0 then
      {$endif}
      begin
        CheckRect := Rect(0, (ClientHeight div 2 - cbh div 2), cbw, 0);
        CheckRect.Bottom := CheckRect.Top + cbh;
      end
      else
      begin
        CheckRect := Rect(0, 0, cbw, 0);
        CheckRect.Top := (CalcAutoHeight(false) div 2 - cbh div 2);
        CheckRect.Bottom := CheckRect.Top + cbh;
      end;
    end
    else
    begin
      {$ifdef ELPACK_UNICODE}
      if WidePos(WideString(#13#10), Caption) = 0 then
      {$else}
      if Pos(#13#10, Caption) = 0 then
      {$endif}
      begin
        CheckRect := Rect(Width - cbw, (ClientHeight - cbh) div 2 + ClientHeight mod 2, Width, 0);
        CheckRect.Bottom := CheckRect.Top + cbh;
      end
      else
      begin
        CheckRect        := Rect(Width - cbw, 0, Width, 0);
        CheckRect.Top    := (CalcAutoHeight(false) div 2 - cbh div 2)  + ClientHeight mod 2;
        CheckRect.Bottom := CheckRect.Top + cbh;
      end;
    end;
    RClip := Canvas.ClipRect;
    DrawThemeBackground(Theme, Canvas.Handle, pid, sid, CheckRect, @RClip);
  {$endif}
  end;

  {$ifdef MSWINDOWS}
  if IsThemeApplied then
  begin
    AL := 0;
    Canvas.Font.Assign(Font);
    {$ifdef HAS_HTML_RENDER}
    if IsHTML then
    begin
      AColor := GetThemeSysColor(Theme, COLOR_BTNTEXT);

      FRender.Data.DefaultColor := AColor;
      FRender.Data.DefaultBgColor := clNone;
      FRender.Data.DefaultStyle := Font.Style;
      FRender.Data.DefaultHeight := Font.Height;
      FRender.Data.DefaultFont := Font.Name;
      FRender.Data.Charset := Font.Charset;
      FRender.Data.LinkColor := LinkColor;
      FRender.Data.LinkStyle := LinkStyle;

      XRect.Left := 0;
      XRect.Top  := 0;
      FRender.PrepareText(FCaption, 0, false);
      XRect.Right := FRender.Data.TextSize.cx;
      XRect.Bottom := FRender.Data.TextSize.cy;
    end
    else
    {$endif}
    begin
      ARect := ClientRect;
      GetThemeTextExtent(Theme, Canvas.Handle, pid, sid, PWideChar(WideString(Caption)), Length(WideString(Caption)), Al, @ARect, XRect);
    end;
    ARect := ClientRect;

    if (CheckAlignment = taRightJustify)
  {$IFDEF VCL_4_USED}
    xor UseRightToLeftAlignment
  {$ENDIF}
    then
      ARect.Left := ARect.Left + cbw + CheckMargin
    else
      ARect.Right := ARect.Right - cbw - CheckMargin;

    ARect.Bottom := XRect.Bottom;
    OffsetRect(ARect, 0, (ClientHeight - XRect.Bottom) div 2);

    Canvas.Brush.Style := bsClear;
    {if not FMultiLine then
       AL := DT_SINGLELINE
    else
       }AL := 0;

    {$ifdef HAS_HTML_RENDER}
    if IsHTML then
    begin
      FTextPos := ARect.TopLeft;
      if (ARect.Bottom > ARect.top) and (ARect.right > ARect.Left) then
        FRender.DrawText(Canvas, Point(0, 0), ARect, clNone);
    end
    else
    {$endif}
    begin
      if not Enabled then
        AL2 := DTT_GRAYED
      else
        AL2 := 0;
      DrawThemeText(Theme, Canvas.Handle, pid, sid, PWideChar(WideString(Caption)), Length(WideString(Caption)), AL, AL2, ARect);
    end;

    if (Focused {and FDoFocus}) and Enabled and (Length(Caption) > 0) and (UIStateDrawFocus) then
    begin
      Canvas.Brush.Style := bsSolid;
    {$ifdef HAS_HTML_RENDER}
      if IsHTML then
      begin
        // FRender.PrepareText(FCaption, 0, false);
        ARect.Right := ARect.Left + FRender.Data.TextSize.cx;
        ARect.Bottom := ARect.Top + FRender.Data.TextSize.cy;
      end
      else
    {$endif}
      begin
        AL := 0;
        GetThemeTextExtent(Theme, Canvas.Handle, pid, sid, PWideChar(WideString(Caption)), Length(Caption), AL, nil, XRect);
        ARect.Right := ARect.Left + (XRect.Right - XRect.Left);
        ARect.Bottom := ARect.Top + (XRect.Bottom - XRect.Top);
      end;
      ARect.Bottom := ARect.Bottom - ARect.Top;//Canvas.TextHeight(Caption);
      ARect.Top := 0;
      OffsetRect(ARect, 0, (ClientHeight - ARect.Bottom) div 2);

      i := ARect.Right - ARect.Left;
      if (CheckAlignment = taRightJustify)
    {$IFDEF VCL_4_USED}
      xor UseRightToLeftAlignment
    {$ENDIF}
      then
      begin
        ARect.Right := ARect.Left + i;
        InflateRect(ARect, 1, 1);
      end
      else
      begin
        ARect.Left := ARect.Right - i;
        InflateRect(ARect, 1, 1);
        Inc(ARect.Left);
      end;

      case TextDrawType of
        tdtNormal: OffsetRect(ARect, 1, 0);
        tdtShadowed :
          begin
            OffsetRect(ARect, 1, 1);
            Inc(ARect.Right);
          end;
        tdtRaised :
            OffsetRect(ARect, 1, -1);
      end;
      OffsetRect(ARect, -1, 0);
      Canvas.DrawFocusRect(ARect);
    end;
  end
  else
  {$endif}
  begin
    if (CheckAlignment = taRightJustify)
  {$IFDEF VCL_4_USED}
    xor UseRightToLeftAlignment
  {$ENDIF}
    then
      ARect.Left := ARect.Left + cbw + CheckMargin
    else
      ARect.Right := ARect.Right - cbw - CheckMargin;
    ARect.Top := 0;

    Canvas.Font.Assign(Font);

    SetRectEmpty(XRect);
    AL := 0;

  {$ifdef HAS_HTML_RENDER}
    if IsHTML then
    begin
      FRender.Data.DefaultColor := Font.Color;
      FRender.Data.DefaultBgColor := clNone;
      FRender.Data.DefaultStyle := Font.Style;
      FRender.Data.DefaultHeight := Font.Height;
      FRender.Data.DefaultFont := Font.Name;
      FRender.Data.Charset := Font.Charset;
      FRender.Data.LinkColor := LinkColor;
      FRender.Data.LinkStyle := LinkStyle;

      XRect.Left := 0;
      XRect.Top  := 0;
      FRender.PrepareText(FCaption, 0, false);
      XRect.Right := FRender.Data.TextSize.cx;
      XRect.Bottom := FRender.Data.TextSize.cy;
    end
    else
  {$endif}
    {$ifdef ELPACK_UNICODE}
      ElVCLUtils.DrawTextW(Canvas.Handle, PWideChar(Caption), Length(Caption), XRect, AL or DT_LEFT or DT_CALCRECT);
    {$else}
      DrawText(Canvas.Handle, PChar(Caption), Length(Caption), XRect, AL or DT_LEFT or DT_CALCRECT);
    {$endif}
    ARect.Bottom := XRect.Bottom;
    OffsetRect(ARect, 0, (ClientHeight - XRect.Bottom) div 2);
    Canvas.Brush.Style := bsClear;
    if not UIStateDrawAccel then
      AL := DT_HIDEPREFIX
    else
      AL := 0;
    {$ifdef HAS_HTML_RENDER}
    if IsHTML then
    begin
      FTextPos := ARect.TopLeft;
      FRender.DrawText(Canvas, Point(0, 0), ARect, clNone);
    end
    else
  {$endif}
    begin
      FTextPos := ARect.TopLeft;
      if not Enabled then
      begin
        OffsetRect(ARect, 1, 1);

        Canvas.Font.Color := clBtnHighlight;
      {$ifdef ELPACK_UNICODE}
        ElVCLUtils.DrawTextW(Canvas.Handle, PWideChar(Caption), Length(Caption), ARect, AL or DT_LEFT or DT_VCENTER or EllipsisFlags[EndEllipsis]);
      {$else}
        Canvas.Font.Color := clBtnHighlight;
        DrawText(Canvas.Handle, PChar(Caption), Length(Caption), ARect, AL or DT_LEFT or DT_VCENTER or EllipsisFlags[EndEllipsis]);
      {$endif}

        OffsetRect(ARect, -1, -1);
        Canvas.Font.Color := clBtnShadow;
      {$ifdef ELPACK_UNICODE}
        ElVCLUtils.DrawTextW(Canvas.Handle, PWideChar(Caption), Length(Caption), ARect, AL or DT_LEFT or DT_VCENTER or EllipsisFlags[EndEllipsis]);
      {$else}
        DrawText(Canvas.Handle, PChar(Caption), Length(Caption), ARect, AL or DT_LEFT or DT_VCENTER or EllipsisFlags[EndEllipsis]);
      {$endif}
      end
      else
      begin
        Canvas.Font.Color := Font.Color;
        {$ifdef ELPACK_UNICODE}
        DrawTypedTextW(Canvas, ARect, Caption,
        {$else}
        DrawTypedText(Canvas, ARect, Caption,
        {$endif}
        AL or DT_LEFT or DT_VCENTER or EllipsisFlags[EndEllipsis],
        TextDrawType);
      end;
    end;
    if (Focused {and FDoFocus}) and Enabled and (Length(Caption) > 0) and (UIStateDrawFocus) then
    begin
      Canvas.Brush.Style := bsSolid;

    // Recalculate text position
      AL := 0;

    {$ifdef HAS_HTML_RENDER}
      if IsHTML then
      begin
        // FRender.PrepareText(FCaption, 0, false);
        ARect.Right := ARect.Left + FRender.Data.TextSize.cx;
        ARect.Bottom := ARect.Top + FRender.Data.TextSize.cy;
      end
      else
  {$endif}
    {$ifdef ELPACK_UNICODE}
      ElVCLUtils.DrawTextW(Canvas.Handle, PWideChar(Caption), -1, ARect, AL or DT_LEFT or DT_VCENTER or DT_CALCRECT);
    {$else}
      DrawText(Canvas.Handle, PChar(Caption), -1, ARect, AL or DT_LEFT or DT_VCENTER or DT_CALCRECT);
    {$endif}
      ARect.Bottom := ARect.Bottom - ARect.Top;//Canvas.TextHeight(Caption);
      ARect.Top := 0;
      OffsetRect(ARect, 0, (ClientHeight - ARect.Bottom) div 2);

      i := ARect.Right - ARect.Left;
      if (CheckAlignment = taRightJustify)
    {$IFDEF VCL_4_USED}
      xor UseRightToLeftAlignment
    {$ENDIF}
      then
      begin
        ARect.Right := ARect.Left + i;
        InflateRect(ARect, 1, 1);
      end
      else
      begin
        ARect.Left := ARect.Right - i;
        InflateRect(ARect, 1, 1);
        Inc(ARect.Left);
      end;

      case TextDrawType of
        tdtNormal: OffsetRect(ARect, 1, 0);
        tdtShadowed :
          begin
            OffsetRect(ARect, 1, 1);
            Inc(ARect.Right);
          end;
        tdtRaised :
            OffsetRect(ARect, 1, -1);
      end;
      OffsetRect(ARect, -1, 0);
      Canvas.DrawFocusRect(ARect);
    end;
  end;
  // FDoFocus := not FDoFocus;
  bitblt(Self.Canvas.Handle, 0, 0, ClientWidth, ClientHeight, Bitmap.Canvas.Handle, 0, 0, SRCCOPY);
  Bitmap.Free;
end; { Paint }
{$WARNINGS on}


procedure TElCheckItem.DoEnter;
begin
  inherited;
  // FDoFocus := Focused;
  if Self is TElRadioButton then
  begin
    //FDoFocus := true;
    if not Checked then
    begin
      Checked := true;
      Click;
    end
    else
      Invalidate;
  end
  else
    Invalidate;
end;

procedure TElCheckItem.DoExit;
begin
  inherited;
  if not HandleAllocated then exit;
  Invalidate;
end;

procedure TElCheckItem.SetFlat(newValue : Boolean);
{ Sets data member FFlat to newValue. }
begin
  if (FFlat <> newValue) then
  begin
    FFlat := newValue;
    if (not UseCustomGlyphs) then Invalidate;
  end; { if }
end; { SetFlat }

procedure TElCheckItem.CMMouseLeave(var Msg : TMessage); { private }
begin
  inherited Cursor := FCursor;
  inherited;
  FMouseInControl := false;
  if MoneyFlat or (Flat and (not FlatAlways) and (not UseCustomGlyphs)) or FPressed  or (IsThemeApplied) then
  begin
    // FDoFocus := focused;
    Invalidate;
  end;
end; { CMMouseLeave }

procedure TElCheckItem.CMMouseEnter(var Msg : TMessage); { private }
begin
  inherited;
  FMouseInControl := true;
  if MoneyFlat or (Flat and (not FlatAlways) and (not UseCustomGlyphs)) or FPressed or (IsThemeApplied) then
  begin
    // FDoFocus := focused;
    Invalidate;
  end;
end; { CMMouseEnter }

(*
procedure TElCheckItem.CMExit(var Msg : TCMExit); { private }
begin
  inherited;
  Invalidate;
end; { CMExit }

procedure TElCheckItem.CMEnter(var Msg : TCMEnter); { private }
begin
  inherited;
  {if Self is TElRadioButton then
  begin
    //FDoFocus := true;
    if not Checked then
      Checked := true
    else
      Invalidate;
  end
  else}
    Invalidate;
end; { CMEnter }
*)

procedure TElCheckItem.CMTextChanged(var Msg : TMessage); { private }
begin
  inherited;
  if AutoSize then
    AdjustAutoSize;
  Invalidate;
end; { CMTextChanged }

procedure TElCheckItem.MouseDown(Button : TMouseButton; Shift : TShiftState; X, Y : Integer); { protected }
{$IFDEF HAS_HTML_RENDER}
var
  P : TPoint;
  R : TRect;
  href : TElFString;
{$endif}
begin
  {$IFDEF HAS_HTML_RENDER}
  if IsHTML then
  begin
    P.x := X;
    P.y := Y;
    R := CalcTextRect;
    if IsHTML and FRender.IsCursorOverLink(Point(P.X - R.Left, P.Y - R.Top), Point(0, 0), R, href) then
      exit;
  end;
  {$endif}
  if Button = mbLeft then
  begin
    if CanFocus then
      SetFocus;
    FPressed := true;
  end;
  FOldCapture := GetCapture;
  if FOldCapture = Handle then
    FOldCapture := 0;
  SetCapture(Handle);
  // FDoFocus := focused;
  Invalidate;
  inherited;
end; { MouseDown }

procedure TElCheckItem.MouseUp(Button : TMouseButton; Shift : TShiftState; X, Y : Integer); { protected }
begin
  if FPressed then
  begin
    if PtInRect(ClientRect, Point(X, Y)) then
    begin
      FPressed := false;
  {$IFDEF USE_SOUND_MAP}
      if not ReadOnly then
        if SoundMap <> nil then
          SoundMap.Play(FCheckSound);
  {$ENDIF}
    end
    else
    begin
      FPressed := false;
      if FOldCapture <> 0 then
        SetCapture(FOldCapture)
      else
        ReleaseCapture;
      FOldCapture := 0;
    end;
    // FDoFocus := Focused;
    Invalidate;
  end;
end; { MouseUp }

procedure TElCheckItem.KeyDown(var Key : Word; Shift : TShiftState); { protected }
begin
  inherited;
  if (Key = VK_SPACE) and (Shift = []) then
  begin
    if not ReadOnly then
    begin
      if (Self is TElCheckBox) then
      begin
  {$IFDEF USE_SOUND_MAP}
        if SoundMap <> nil then SoundMap.Play(FCheckSound);
  {$ENDIF}
        // FDoFocus := true;
        Click;
      end
      else
      if Self is TElRadioButton then
        Click;
    end;
  end;
end; { KeyDown }

procedure TElCheckItem.Click;
var
  State : TCheckBoxState;
  {$IFDEF HAS_HTML_RENDER}
  P : TPoint;
  R : TRect;
  href : TElFString;
  {$endif}
begin
  {$IFDEF HAS_HTML_RENDER}
  if IsHTML then
  begin
    GetCursorPos(P);
    P := ScreenToClient(P);
    R := CalcTextRect;

    if IsHTML and FRender.IsCursorOverLink(Point(P.X - R.Left, P.Y - R.Top), Point(0, 0), R, href) then
    begin
      TriggerLinkClickEvent(href);
      exit;
    end;
  end;
  {$endif}
  if not ReadOnly then
  begin
    if Self is TElCheckBox then
    begin
      State := TElCheckBox(Self).State;
      case State of
        cbChecked : Checked := false;
        cbGrayed : Checked := true;
        cbUnchecked :
          if TElCheckBox(Self).AllowGrayed then
            TElCheckBox(Self).State := cbGrayed
          else
            Checked := true;
      end;
      Modified := true;
    end
    else if Self is TElRadioButton then
    begin
      // FDoFocus := focused;
      if not Checked then
      begin
        Checked := true;
        //if (not ClicksDisabled) then Click;
        Modified := true;
      end
      else
        Invalidate;
    end;
    inherited Changed;
    inherited Click;
  end;
end;

procedure TElCheckItem.Loaded;
begin
  inherited;
  if AutoSize then
  begin
    FAutoSize := false;
    AutoSize := true;
  end;
  if UseImageList then
  if FImages = nil then
    UseImageList := false;
end;

procedure TElCheckItem.CMFocusChanged(var Msg : TCMFocusChanged);  { private }
begin
  inherited;
  if Msg.Sender = Self then
  begin
    // FDoFocus := Focused;
    Invalidate;
  end;
end;  { CMFocusChanged }


procedure TElCheckItem.CMFontChanged(var Message: TMessage);
begin
  inherited;
  if AutoSize then
    AdjustAutoSize;
end;


destructor TElCheckItem.Destroy;
begin
{$ifdef HAS_HTML_RENDER}
  if FRender <> nil then
    FRender.Free;
  FRender := nil;
{$endif}
  {$ifdef ELPACK_USE_IMAGEFORM}
  ImageForm := nil;
  {$endif}
  FGlyph.Free;
  {$ifdef ELPACK_USE_IMAGEFORM}
  FImgFormChLink.Free;
  {$endif}
  FChLink.Free;
  FAChLink.Free;
  inherited Destroy;
end; { Destroy }

constructor TElCheckItem.Create(AOwner : TComponent);
{ Creates an object of type TElCheckItem, and initializes properties. }
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csSetCaption] - [csDoubleClicks];
  FGlyph := TBitmap.Create;
  FGlyph.OnChange := GlyphChange;
  Height := 17;
  Width := 60;
  FAlignment := taRightJustify;
  TabStop := true;
  {$ifdef ELPACK_USE_IMAGEFORM}
  FImgFormChLink  := TImgFormChangeLink.Create; FImgFormChLink.OnChange := ImageFormChange;
  {$endif}
  FChLink  := TChangeLink.Create; FChLink.OnChange := ImagesChanged;
  FAChLink  := TChangeLink.Create; FAChLink.OnChange := ImagesChanged;
  FAutoSize := true;
  {$ifdef HAS_HTML_RENDER}
  FLinkStyle := [fsUnderline];
  FLinkColor := clBlue;
  {$endif}
  //UseXPThemes := true;
end; { Create }

procedure TElCheckBox.DrawFlatFrame(Canvas : TCanvas; R : TRect);
var AColor, Color : TColor;
begin
  if MoneyFlat then
  begin
    if Enabled and not FPressed then
      Color := clWindow
    else
      Color := clBtnFace;
    if FPressed then
      AColor := Self.MoneyFlatDownColor
    else
    if Focused or FMouseInControl then
      AColor := MoneyFlatActiveColor
    else
      AColor := MoneyFlatInactiveColor;
    ELVCLUtils.DrawFlatFrameEx2(Canvas.Handle, R, AColor, Color, false, true, AllBorderSides, fbtColorLineBorder, clBtnFace, cl3DDkShadow, clBtnShadow, clBtnHighlight, clWindow);
  end
  else
  if Enabled and not FPressed then
    ElVCLUtils.DrawFlatFrame(Canvas.Handle, R, clWindow, false)
  else
    ElVCLUtils.DrawFlatFrame(Canvas.Handle, R, clBtnFace, false);
end;

function TElCheckBox.GetChecked : Boolean;
{ Returns the value of data member FChecked. }
begin
  result := FState = cbChecked;
end; { GetChecked }

procedure TElCheckBox.SetChecked(newValue : Boolean);
{ Sets data member FChecked to newValue. }
begin
  if newValue then
    SetState(cbChecked)
  else
    SetState(cbUnchecked);
end; { SetChecked }

procedure TElCheckBox.SetState(newValue : TCheckBoxState);
{ Sets data member FState to newValue. }
begin
  if (FState <> newValue) then
  begin
    if AllowGrayed or (newValue <> cbGrayed) then
    begin
      FState := newValue;
      // FDoFocus := Focused;
      Invalidate;
    end;
  end; { if }
end; { SetState }

procedure TElCheckBox.SetAllowGrayed(newValue : Boolean);
{ Sets data member FAllowGrayed to newValue. }
begin
  if (FAllowGrayed <> newValue) then
  begin
    FAllowGrayed := newValue;
    if (not NewValue) and (FState = cbGrayed) then SetState(cbUnchecked);
  end; { if }
end; { SetAllowGrayed }

procedure TElCheckBox.Toggle;
begin
  case State of
    cbUnchecked:
      if AllowGrayed then State := cbGrayed else State := cbChecked;
    cbChecked: State := cbUnchecked;
    cbGrayed: State := cbChecked;
  end;
end;


procedure TElRadioButton.DrawFlatFrame(Canvas : TCanvas; R : TRect);
var
  i : integer;
  Color : TColor;
  AColor: TColor;

const
  points : array[0..27] of TPoint = ((x : 1; y : 4), (x : 1; y : 5), (x : 1; y : 6), (x : 1; y : 7),
    (x : 2; y : 2), (x : 2; y : 3), (x : 2; y : 8),
    (x : 3; y : 2), (x : 4; y : 1), (x : 5; y : 1), (x : 6; y : 1), (x : 7; y : 1),
    (x : 8; y : 2), (x : 9; y : 2),

    (x : 2; y : 9), (x : 3; y : 9),
    (x : 4; y : 10), (x : 5; y : 10), (x : 6; y : 10), (x : 7; y : 10),
    (x : 8; y : 9), (x : 9; y : 9), (x : 9; y : 8),
    (x : 10; y : 7), (x : 10; y : 6), (x : 10; y : 5),
    (x : 10; y : 4), (x : 9; y : 3)
    );

  Apoints : array[0..31] of TPoint = ((x : 0; y : 4), (x : 0; y : 5), (x : 0; y : 6), (x : 0; y : 7),
    (x : 1; y : 2), (x : 1; y : 3), (x : 1; y : 8), (x : 1; y : 9),

    (x : 2; y : 1), (x : 3; y : 1), (x : 4; y : 0), (x : 5; y : 0), (x : 6; y : 0), (x : 7; y : 0),
    (x : 8; y : 1), (x : 9; y : 1),

    (x : 2; y : 10), (x : 3; y : 10),
    (x : 4; y : 11), (x : 5; y : 11), (x : 6; y : 11), (x : 7; y : 11),
    (x : 8; y : 10), (x : 9; y : 10),
    (x : 10; y : 9), (x : 10; y : 8),
    (x : 11; y : 7), (x : 11; y : 6), (x : 11; y : 5), (x : 11; y : 4),
    (x : 10; y : 3), (x : 10; y : 2)
    );


begin
  if MoneyFlat then
  begin
    if Enabled and not FPressed then
      Color := clWindow
    else
      Color := clBtnFace;
    if FPressed then
      AColor := Self.MoneyFlatDownColor
    else
    if Focused or FMouseInControl then
      AColor := MoneyFlatActiveColor
    else
      AColor := MoneyFlatInactiveColor;
    for i := 0 to 27 do
    begin
      Canvas.Pixels[R.Left + Points[i].x + 1, R.Top + Points[i].y] := Color;
    end;
    for i := 0 to 31 do
    begin
      Canvas.Pixels[R.Left + APoints[i].x + 1, R.Top + APoints[i].y] := AColor;
    end;
  end
  else
  begin
    if Enabled and not FPressed then
      AColor := clWindow
    else
      AColor := clBtnFace;
    for i := 0 to 27 do
    begin
      Canvas.Pixels[R.Left + Points[i].x + 1, R.Top + Points[i].y] := AColor;
    end;
  end;
end;

function TElRadioButton.GetChecked : Boolean;
{ Returns the value of data member FChecked. }
begin
  result := FChecked;
end; { GetChecked }

procedure TElRadioButton.SetChecked(newValue : Boolean);
var
  i : Integer;
  C : TControl;
begin
  if FChecked <> newValue then
  begin
    FChecked := newValue;
    TabStop := newValue;
    if newValue then
    begin
      if Parent <> nil then
        with Parent do
          for i := 0 to ControlCount - 1 do
          begin
            C := Controls[i];
            if (C <> Self) and (C is TElRadioButton) then TElRadioButton(C).SetChecked(False);
          end; { for }
      if not ClicksDisabled then
        inherited Changed;
    end; { if }
    //FDoFocus := Focused;
    Invalidate;
  end; { if }
end; { SetChecked }

procedure TElCheckItem.DrawGlyph(Canvas : TCanvas; DestRect: TRect; SrcRect:
    TRect);
begin
  DrawTransparentBitmapEx(Canvas.Handle, FGlyph, DestRect.Left, DestRect.Top, SrcRect, FGlyph.Canvas.Pixels[SrcRect.Left, SrcRect.Bottom - 1]);
end;

procedure TElCheckItem.SetFlatAlways(Value: Boolean);
begin
  if FFlatAlways <> Value then
  begin
    FFlatAlways := Value;
    if not UseCustomGlyphs then
      Invalidate;
  end;
end;

{$ifdef HAS_HTML_RENDER}
procedure TElCheckItem.SetIsHTML(Value: Boolean);
begin
  if FIsHTML <> Value then
  begin
    FIsHTML := Value;
    if FIsHTML then
    begin
      FRender := TElHTMLRender.Create;
      FRender.OnImageNeeded := TriggerImageNeededEvent;
    end
    else
    begin
      FRender.Free;
      FRender := nil;
    end;
    if AutoSize then
      AdjustAutoSize;
    Invalidate;
  end;
end;

{$endif}

procedure TElCheckItem.SetImages(Value: TImageList);
var b : boolean;
begin
  if FImages <> Value then
  begin
    b := FImages = nil;
    if not b then
    begin
      {$ifdef VCL_5_USED}
      if not (csDestroying in FImages.ComponentState) then
        FImages.RemoveFreeNotification(Self);
      {$endif}
      FImages.UnregisterChanges(FChLink);
    end;
    FImages := Value;
    if FImages <> nil then
    begin
      FImages.RegisterChanges(FChLink);
      FImages.FreeNotification(Self);
    end;
    if FImages = nil then
      UseImageList := false
    else
    if b and (not (csLoading in ComponentState)) then
      UseImageList := true;
    Invalidate;
  end;
end;

procedure TElCheckItem.SetAlphaImages(Value: TImageList);
begin
  if FAlphaImages <> Value then
  begin
    if FAlphaImages <> nil then
    begin
      {$ifdef VCL_5_USED}
      if not (csDestroying in FAlphaImages.ComponentState) then
        FAlphaImages.RemoveFreeNotification(Self);
      {$endif}
      FAlphaImages.UnregisterChanges(FAChLink);
    end;
    FAlphaImages := Value;
    if FAlphaImages <> nil then
    begin
      FAlphaImages.RegisterChanges(FAChLink);
      FAlphaImages.FreeNotification(Self);
    end;
    Invalidate;
  end;
end;

procedure TElCheckItem.SetUseImageList(Value: Boolean);
begin
  if FUseImageList <> Value then
  begin
    if (Value and (FImages <> nil)) or (not Value) or (csLoading in ComponentState) then
    begin
      FUseImageList := Value;
      if AutoSize then
        AdjustAutoSize;
      Invalidate;
    end;
  end;
end;

procedure TElCheckItem.ImagesChanged(Sender: TObject);
begin
  if FUseImageList then
    Invalidate;
end;

procedure TElCheckItem.CMEnabledChanged(var Msg : TMessage); { private }
begin
  inherited;
  Invalidate;
end; { CMEnabledChanged }


{$ifdef ELPACK_USE_IMAGEFORM}
procedure TElCheckItem.IFMRepaintChildren(var Message: TMessage);
begin
  inherited;
  if (not (csDesigning in ComponentState)) and (ImageForm <> nil) then
    Invalidate;
  Broadcast(Message);
end;

procedure TElCheckItem.WMWindowPosChanged(var Message: TWMWindowPosChanged);
begin
  inherited;
  Perform(IFM_REPAINTCHILDREN, 0, 0);
end;
{$endif}

procedure TElCheckItem.CreateWnd;
begin
  inherited;
  if Autosize then AdjustAutosize;
end;

function TElCheckItem.GetCheckBoxSize: TSize;
begin
  Result.cx := CheckBoxSize;
  Result.cy := CheckBoxSize;
  if IsThemeApplied() then
  begin
    GetThemePartSize(Theme, Canvas.Handle, GetPartId, 1, nil, TS_TRUE, Result);
  end;
end;

function TElCheckItem.GetPartId: Integer;
begin
  if Self is TElRadioButton then
  begin
    Result := BP_RADIOBUTTON;
  end
  else
  begin
    if Self is TElCheckBox then
    begin
      Result := BP_CHECKBOX;
    end
    else
    begin
      Result := BP_USERBUTTON;
    end;
  end;
end;

procedure TElCheckItem.WMGetDlgCode(var Msg : TWMGetDlgCode);
begin
  with TMessage(Msg) do
  begin
    Result := DefWindowProc(Handle, Msg, wParam, lParam);
    Result := (Result and (not DLGC_WANTALLKEYS));
    if HandleDialogKeys then
      result := result or DLGC_WANTALLKEYS;
  end;
end;  { WMGetDlgCode }

{$ifdef VCL_5_USED}
procedure TElCheckItem.WMContextMenu(var Message: TWMContextMenu);
var
  Pt, Temp: TPoint;
  Handled: Boolean;
  href : TElFString;
  R    : TRect;
begin
  if Message.Result <> 0 then Exit;
  if csDesigning in ComponentState then Exit;

  {$ifdef HAS_HTML_RENDER}
  Pt := ScreenToClient(SmallPointToPoint(Message.Pos));
  if IsHTML then
  begin
    R := CalcTextRect;
    if (LinkPopupMenu <> nil) and FRender.IsCursorOverLink(Point(Pt.X - R.Left, Pt.Y - R.Top), Point(0, 0), R, href) then
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
      inherited
  end
  else
  {$endif}
    inherited;
end;
{$endif}

procedure TElCheckItem.WMRButtonUp(var Message: TWMRButtonUp);
{$ifndef VCL_5_USED}
var P : TPoint;
    R : TRect;
    href : TElFString;
{$endif}
begin
  {$ifndef VCL_5_USED}
  if IsHTML then
  begin
    P := SmallPointToPoint(Message.Pos);
    R := CalcTextRect;
    if (LinkPopupMenu <> nil) and FRender.IsCursorOverLink(Point(P.X - R.Left, P.Y - R.Top), Point(0, 0), R, href) then
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
      inherited;
  end
  else
  {$endif}
    inherited;
end;



procedure TElCheckItem.SetCursor(newValue : TCursor);
var P : TPoint;
    R : TRect;
    href : TElFString;
begin
  if (FCursor <> newValue) then
  begin
    FCursor := newValue;
    {$IFDEF HAS_HTML_RENDER}
    if IsHTML then
    begin
      GetCursorPos(P);
      P := ScreenToClient(P);
      R := CalcTextRect;
      if FRender.IsCursorOverLink(Point(P.X - R.Left, P.Y - R.Top), Point(0, 0), R, href) then
        inherited Cursor := crURLCursor
      else
        inherited Cursor := FCursor;
    end
    else
    {$endif}
      inherited Cursor := FCursor;
  end;  { if }
end;  { SetCursor }

{$IFDEF HAS_HTML_RENDER}
function TElCheckItem.CalcTextRect: TRect;
begin
  Result.Left := FTextPos.x;
  Result.Top  := FTextPos.y;
  Result.Right  := FTextPos.x + FRender.Data.TextSize.cx;
  Result.Bottom := FTextPos.y + FRender.Data.TextSize.cy;
end;
{$endif}

procedure TElCheckItem.MouseMove(Shift: TShiftState; X, Y: Integer);
{$IFDEF HAS_HTML_RENDER}
var href : TElFString;
    R    : TRect;
{$endif}
begin
{$IFDEF HAS_HTML_RENDER}
  if IsHTML then
  begin
    R := CalcTextRect;
    if FRender.IsCursorOverLink(Point(X - R.Left, Y - R.Top), Point(0, 0), R, href) then
       inherited Cursor := crURLCursor
    else
       inherited Cursor := FCursor;
  end;
{$endif}
  inherited MouseMove(Shift, X, Y);
end;  { MouseMove }

{$IFDEF HAS_HTML_RENDER}
procedure TElCheckItem.SetLinkColor(newValue : TColor);
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

procedure TElCheckItem.SetLinkPopupMenu(newValue : TPopupMenu);
begin
  if (FLinkPopupMenu <> newValue) then
  begin
    {$ifdef VCL_5_USED}
    if (FLinkPopupMenu <> nil) then
      if not (csDestroying in FLinkPopupMenu.ComponentState) then
        FLinkPopupMenu.RemoveFreeNotification(Self);
    {$endif}
    FLinkPopupMenu := newValue;
    if (newValue <> nil) then
       newValue.FreeNotification(Self);
  end;  { if }
end;  { SetLinkPopupMenu }

procedure TElCheckItem.SetLinkStyle(newValue : TFontStyles);
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

procedure TElCheckItem.DoLinkPopup(MousePos : TPoint);
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

procedure TElCheckItem.TriggerImageNeededEvent(Sender : TObject; Src :
    TElFString; var Image : TBitmap);
begin
  Image := nil;
  if (assigned(FOnImageNeeded)) then
      FOnImageNeeded(Self, Src, Image);
end;  { TriggerImageNeededEvent }

procedure TElCheckItem.TriggerLinkClickEvent(HRef : TElFString);
begin
  if (assigned(FOnLinkClick)) then
    FOnLinkClick(Self, HRef );
end;  { TriggerLinkClickEvent }

{$endif}

procedure TElCheckItem.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('Alignment', ReadAlignment, nil, false);
end;

procedure TElCheckItem.ReadAlignment(Reader: TReader);
var S : string;
begin
  s := Reader.ReadIdent;
  {$ifdef VCL_5_USED}
  SetEnumProp(Self, 'CheckAlignment', s);
  {$endif}
end;

procedure TElCheckItem.SetEndEllipsis(Value: Boolean);
begin
  if FEndEllipsis <> Value then
  begin
    FEndEllipsis := Value;
    Invalidate;
  end;
end;


end.
