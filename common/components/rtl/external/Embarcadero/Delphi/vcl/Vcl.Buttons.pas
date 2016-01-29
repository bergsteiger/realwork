{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Vcl.Buttons;

{$S-,W-,R-,H+,X+}
{$C PRELOAD}

{$HPPEMIT '#ifndef _WIN64'}
{$HPPEMIT '#pragma link "dwmapi.lib"'}
{$HPPEMIT '#endif //_WIN64'}

interface

uses Winapi.Windows, Winapi.Messages, System.Classes, Vcl.Controls, Vcl.Forms, Vcl.Graphics,
  Vcl.StdCtrls, Vcl.ExtCtrls, Winapi.CommCtrl, Vcl.ImgList,
  Vcl.Themes, System.Generics.Collections;

type
  TButtonLayout = (blGlyphLeft, blGlyphRight, blGlyphTop, blGlyphBottom);
  TButtonState = (bsUp, bsDisabled, bsDown, bsExclusive);
  TButtonStyle = (bsAutoDetect, bsWin31, bsNew);
  TNumGlyphs = 1..4;

  TSpeedButton = class;

  TSpeedButtonActionLink = class(TControlActionLink)
  protected
    FClient: TSpeedButton;
    FImageIndex: Integer;
    procedure AssignClient(AClient: TObject); override;
    function IsCheckedLinked: Boolean; override;
    function IsGlyphLinked(Index: TImageIndex): Boolean; virtual;
    function IsGroupIndexLinked: Boolean; override;
    function IsImageIndexLinked: Boolean; override;
    procedure SetGroupIndex(Value: Integer); override;
    procedure SetChecked(Value: Boolean); override;
    procedure SetImageIndex(Value: Integer); override;
  public
    constructor Create(AClient: TObject); override;
  end;

  TSpeedButton = class(TGraphicControl)
  private
    FGroupIndex: Integer;
    FGlyph: TObject;
    FDown: Boolean;
    FDragging: Boolean;
    FAllowAllUp: Boolean;
    FLayout: TButtonLayout;
    FSpacing: Integer;
    FTransparent: Boolean;
    FMargin: Integer;
    FFlat: Boolean;
    FMouseInControl: Boolean;
    procedure GlyphChanged(Sender: TObject);
    function HasCustomGlyph: Boolean;
    procedure InternalCopyImage(Image: TBitmap; ImageList: TCustomImageList; Index: Integer);
    procedure UpdateExclusive;
    function GetGlyph: TBitmap;
    procedure SetGlyph(Value: TBitmap);
    function GetNumGlyphs: TNumGlyphs;
    procedure SetNumGlyphs(Value: TNumGlyphs);
    procedure SetDown(Value: Boolean);
    procedure SetFlat(Value: Boolean);
    procedure SetAllowAllUp(Value: Boolean);
    procedure SetGroupIndex(Value: Integer);
    procedure SetLayout(Value: TButtonLayout);
    procedure SetSpacing(Value: Integer);
    procedure SetTransparent(Value: Boolean);
    procedure SetMargin(Value: Integer);
    procedure UpdateTracking;
    procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure CMSysColorChange(var Message: TMessage); message CM_SYSCOLORCHANGE;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
{$IF DEFINED(CLR)}
    procedure ButtonPressed(Group: Integer; Button: TSpeedButton);
{$ELSE}
    procedure CMButtonPressed(var Message: TMessage); message CM_BUTTONPRESSED;
{$ENDIF}
  protected
    FState: TButtonState;
    procedure ActionChange(Sender: TObject; CheckDefaults: Boolean); override;
    procedure CopyImage(ImageList: TCustomImageList; Index: Integer);
    function GetActionLinkClass: TControlActionLinkClass; override;
    function GetPalette: HPALETTE; override;
    procedure Loaded; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure Paint; override;
    property MouseInControl: Boolean read FMouseInControl;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Click; override;
  published
    property Action;
    property Align;
    property AllowAllUp: Boolean read FAllowAllUp write SetAllowAllUp default False;
    property Anchors;
    property BiDiMode;
    property Constraints;
    property GroupIndex: Integer read FGroupIndex write SetGroupIndex default 0;
    property Down: Boolean read FDown write SetDown default False;
    property Caption;
    property Enabled;
    property Flat: Boolean read FFlat write SetFlat default False;
    property Font;
    property Glyph: TBitmap read GetGlyph write SetGlyph stored HasCustomGlyph;
    property Layout: TButtonLayout read FLayout write SetLayout default blGlyphLeft;
    property Margin: Integer read FMargin write SetMargin default -1;
    property NumGlyphs: TNumGlyphs read GetNumGlyphs write SetNumGlyphs default 1;
    property ParentFont;
    property ParentShowHint;
    property ParentBiDiMode;
    property PopupMenu;
    property ShowHint;
    property Spacing: Integer read FSpacing write SetSpacing default 4;
    property Transparent: Boolean read FTransparent write SetTransparent default True;
    property Visible;
    property StyleElements;
    property OnClick;
    property OnDblClick;
    property OnMouseActivate;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
  end;

  TBitBtn = class;

  TBitBtnActionLink = class(TControlActionLink)
  protected
    FClient: TBitBtn;
    FImageIndex: Integer;
    procedure AssignClient(AClient: TObject); override;
    function IsImageIndexLinked: Boolean; override;
    function IsGlyphLinked(Index: TImageIndex): Boolean;
    procedure SetImageIndex(Value: Integer); override;
  public
    constructor Create(AClient: TObject); override;
  end;

  TBitBtnKind = (bkCustom, bkOK, bkCancel, bkHelp, bkYes, bkNo, bkClose,
    bkAbort, bkRetry, bkIgnore, bkAll);

  TBitBtn = class(TCustomButton)
  strict private
    class constructor Create;
    class destructor Destroy;
  private
    FCanvas: TCanvas;
    FGlyph: TObject;
    FStyle: TButtonStyle;
    FKind: TBitBtnKind;
    FLayout: TButtonLayout;
    FSpacing: Integer;
    FMargin: Integer;
    IsFocused: Boolean;
    FModifiedGlyph: Boolean;
    FMouseInControl: Boolean;
    procedure DrawItem(const DrawItemStruct: TDrawItemStruct);
    procedure SetGlyph(Value: TBitmap);
    function GetGlyph: TBitmap;
    function GetNumGlyphs: TNumGlyphs;
    procedure SetNumGlyphs(Value: TNumGlyphs);
    procedure GlyphChanged(Sender: TObject);
    procedure InternalCopyImage(Image: TBitmap; ImageList: TCustomImageList; Index: Integer);
    function IsCustom: Boolean;
    function IsCustomCaption: Boolean;
    procedure SetStyle(Value: TButtonStyle);
    procedure SetKind(Value: TBitBtnKind);
    function GetKind: TBitBtnKind;
    procedure SetLayout(Value: TButtonLayout);
    procedure SetSpacing(Value: Integer);
    procedure SetMargin(Value: Integer);
    procedure CNMeasureItem(var Message: TWMMeasureItem); message CN_MEASUREITEM;
    procedure CNDrawItem(var Message: TWMDrawItem); message CN_DRAWITEM;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
{$IF DEFINED(CLR)}
    function BitBtnCaptions(Kind: TBitBtnKind): string;
{$ENDIF}
  protected
    procedure ActionChange(Sender: TObject; CheckDefaults: Boolean); override;
    procedure CopyImage(ImageList: TCustomImageList; Index: Integer);
    procedure CreateHandle; override;
    procedure CreateParams(var Params: TCreateParams); override;
    function GetActionLinkClass: TControlActionLinkClass; override;
    function GetPalette: HPALETTE; override;
    procedure SetButtonStyle(ADefault: Boolean); override;
    procedure UpdateStyleElements; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Click; override;
  published
    property Action;
    property Align;
    property Anchors;
    property BiDiMode;
    property Cancel stored IsCustom;
    property Caption stored IsCustomCaption;
    property Constraints;
    property Default stored IsCustom;
    property DoubleBuffered default True;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property Glyph: TBitmap read GetGlyph write SetGlyph stored IsCustom;
    property Kind: TBitBtnKind read GetKind write SetKind default bkCustom;
    property Layout: TButtonLayout read FLayout write SetLayout default blGlyphLeft;
    property Margin: Integer read FMargin write SetMargin default -1;
    property ModalResult stored IsCustom;
    property NumGlyphs: TNumGlyphs read GetNumGlyphs write SetNumGlyphs default 1;
    property ParentBiDiMode;
    property ParentDoubleBuffered default False;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Style: TButtonStyle read FStyle write SetStyle default bsAutoDetect;
    property Spacing: Integer read FSpacing write SetSpacing default 4;
    property TabOrder;
    property TabStop;
    property Visible;
    property WordWrap;
    property StyleElements;
    property OnClick;
    property OnContextPopup;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseActivate;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  end;

  TBitBtnStyleHook = class(TButtonStyleHook)
  strict protected
    procedure DrawButton(ACanvas: TCanvas; AMouseInControl: Boolean); override;
  end;

  TNavButton = class;

  TNavBtnID = Integer;

  TBaseNavigator = class (TCustomPanel)
  public type
  {$SCOPEDENUMS ON}
    TOrientation = (orHorizontal, orVertical);
  {$SCOPEDENUMS OFF}
  protected type
    TButtonDescription = record
    public
      ID: TNavBtnID;
      AllowTimer: Boolean;
      DefaultVisible: Boolean;
      DefaultHint: string;
      GlyphResInstance: HINST;
      GlyphResName: string;
      ThemeNormal: TThemedDataNavButtons;
      ThemeHot: TThemedDataNavButtons;
      ThemeDisabled: TThemedDataNavButtons;
      ThemePressed: TThemedDataNavButtons;
    end;
  private type
    TButtonInstance = record
      Instance: TNavButton;
      Description: TButtonDescription;
      function Visible: Boolean;
      procedure Invalidate;
      procedure Click;
      function Enabled: Boolean;
    end;
  private
    FButtonInstances: TDictionary<TNavBtnID, TButtonInstance>;
    FBtnIDs: TList<TNavBtnID>;
    ButtonWidth: Integer;
    ButtonHeight: Integer;
    MinBtnSize: TPoint;
    FocusedButton: TNavBtnID;
    FConfirmDelete: Boolean;
    FFlat: Boolean;
    FOrientation: TOrientation;
    procedure BtnMouseDown (Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ClickHandler(Sender: TObject);
    procedure InitButtons;
    procedure SetFlat(Value: Boolean);
    procedure SetKind(Value: TOrientation);
    procedure SetSize(var W: Integer; var H: Integer);
    procedure WMSize(var Message: TWMSize);  message WM_SIZE;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure WMWindowPosChanging(var Message: TWMWindowPosChanging); message WM_WINDOWPOSCHANGING;
  protected
    procedure BtnIDClick(Index: TNavBtnID); virtual;
    procedure DefineButtons(ADescriptions: TArray<TButtonDescription>);
    function GetButton(Index: TNavBtnID): TNavButton;
    procedure SetVisible(Value: TArray<TNavBtnID>);
    procedure EnabledChanged; virtual;
    procedure CalcMinSize(var W, H: Integer);
    procedure CreateWnd; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure Loaded; override;
    procedure Paint; override;
    procedure SetButtonGlyph(Index: TNavBtnID); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    property Align;
    property Anchors;
    property Constraints;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    [Default(False)]
    property Flat: Boolean read FFlat write SetFlat default False;
    property Ctl3D;
    property Orientation: TOrientation read FOrientation write SetKind; // default orHorizontal;
    property ParentCtl3D;
    property ParentShowHint;
    property PopupMenu;
    [Default(True)]
    property ConfirmDelete: Boolean read FConfirmDelete write FConfirmDelete default True;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
  end;

{ TNavButton }
  TNavButtonStyle = set of (nsAllowTimer);

  TNavButton = class(TSpeedButton)
  private const
    InitRepeatPause = 400;  { pause before repeat timer (ms) }
    RepeatPause     = 100;  { pause before hint window displays (ms)}
  private
    FIndex: TNavBtnID;
    FNavStyle: TNavButtonStyle;
    FRepeatTimer: TTimer;
    FThemeHot: TThemedDataNavButtons;
    FThemePressed: TThemedDataNavButtons;
    FThemeNormal: TThemedDataNavButtons;
    FThemeDisabled: TThemedDataNavButtons;
    procedure TimerExpired(Sender: TObject);
  protected
    procedure Paint; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
  public
    destructor Destroy; override;
    property NavStyle: TNavButtonStyle read FNavStyle write FNavStyle;
    property Index : TNavBtnID read FIndex write FIndex;
    property ThemeHot: TThemedDataNavButtons read FThemeHot write FThemeHot;
    property ThemeNormal: TThemedDataNavButtons read FThemeNormal write FThemeNormal;
    property ThemeDisabled: TThemedDataNavButtons read FThemeDisabled write FThemeDisabled;
    property ThemePressed: TThemedDataNavButtons read FThemePressed write FThemePressed;
  end;


function DrawButtonFace(Canvas: TCanvas; const Client: TRect;
  BevelWidth: Integer; Style: TButtonStyle; IsRounded, IsDown,
  IsFocused: Boolean): TRect;


implementation

uses
{$IF DEFINED(CLR)}
  Types, System.Security.Permissions,
  System.Runtime.InteropServices, System.Reflection,
{$ENDIF}
  System.Types, Vcl.Consts, System.SysUtils, Vcl.ActnList, Winapi.UxTheme, Winapi.DwmApi,
  System.Math;

{$IF NOT DEFINED(CLR)}
{$R Buttons.res}
{$ELSE}
{$R Borland.Vcl.Buttons.resources}

const
  ResourceBaseName = 'Borland.Vcl.Buttons'; { Do not localize }
{$ENDIF}

{ TBitBtn data }
var
{$IF DEFINED(CLR)}
  BitBtnResNames: array[TBitBtnKind] of string = (
    '', 'BBOK', 'BBCANCEL', 'BBHELP', 'BBYES', 'BBNO', 'BBCLOSE',
    'BBABORT', 'BBRETRY', 'BBIGNORE', 'BBALL');
{$ELSE}
  BitBtnResNames: array[TBitBtnKind] of PChar = (
    nil, 'BBOK', 'BBCANCEL', 'BBHELP', 'BBYES', 'BBNO', 'BBCLOSE',
    'BBABORT', 'BBRETRY', 'BBIGNORE', 'BBALL');
  BitBtnCaptions: array[TBitBtnKind] of Pointer = (
    nil, @SOKButton, @SCancelButton, @SHelpButton, @SYesButton, @SNoButton,
    @SCloseButton, @SAbortButton, @SRetryButton, @SIgnoreButton,
    @SAllButton);
{$ENDIF}
  BitBtnModalResults: array[TBitBtnKind] of TModalResult = (
    0, mrOk, mrCancel, 0, mrYes, mrNo, 0, mrAbort, mrRetry, mrIgnore,
    mrAll);

var
  BitBtnGlyphs: array[TBitBtnKind] of TBitmap;

{ DrawButtonFace - returns the remaining usable area inside the Client rect.}
function DrawButtonFace(Canvas: TCanvas; const Client: TRect;
  BevelWidth: Integer; Style: TButtonStyle; IsRounded, IsDown,
  IsFocused: Boolean): TRect;
var
  NewStyle: Boolean;
  R: TRect;
  DC: THandle;
begin
  NewStyle := ((Style = bsAutoDetect) and NewStyleControls) or (Style = bsNew);
    
  R := Client;
  with Canvas do
  begin
    if NewStyle then
    begin
      Brush.Color := clBtnFace;
      Brush.Style := bsSolid;
      DC := Canvas.Handle;    { Reduce calls to GetHandle }
    
      if IsDown then
      begin    { DrawEdge is faster than Polyline }
        DrawEdge(DC, R, BDR_SUNKENINNER, BF_TOPLEFT);              { black     }
        DrawEdge(DC, R, BDR_SUNKENOUTER, BF_BOTTOMRIGHT);          { btnhilite }
        Dec(R.Bottom);
        Dec(R.Right);
        Inc(R.Top);
        Inc(R.Left);
        DrawEdge(DC, R, BDR_SUNKENOUTER, BF_TOPLEFT or BF_MIDDLE); { btnshadow }
      end
      else
      begin
        DrawEdge(DC, R, BDR_RAISEDOUTER, BF_BOTTOMRIGHT);          { black }
        Dec(R.Bottom);
        Dec(R.Right);
        DrawEdge(DC, R, BDR_RAISEDINNER, BF_TOPLEFT);              { btnhilite }
        Inc(R.Top);
        Inc(R.Left);
        DrawEdge(DC, R, BDR_RAISEDINNER, BF_BOTTOMRIGHT or BF_MIDDLE); { btnshadow }
      end;
    end
    else
    begin
      Pen.Color := clWindowFrame;
      Brush.Color := clBtnFace;
      Brush.Style := bsSolid;
      Rectangle(R.Left, R.Top, R.Right, R.Bottom);
    
      { round the corners - only applies to Win 3.1 style buttons }
      if IsRounded then
      begin
        Pixels[R.Left, R.Top] := clBtnFace;
        Pixels[R.Left, R.Bottom - 1] := clBtnFace;
        Pixels[R.Right - 1, R.Top] := clBtnFace;
        Pixels[R.Right - 1, R.Bottom - 1] := clBtnFace;
      end;
    
      if IsFocused then
      begin
        InflateRect(R, -1, -1);
        Brush.Style := bsClear;
        Rectangle(R.Left, R.Top, R.Right, R.Bottom);
      end;
    
      InflateRect(R, -1, -1);
      if not IsDown then
        Frame3D(Canvas, R, clBtnHighlight, clBtnShadow, BevelWidth)
      else
      begin
        Pen.Color := clBtnShadow;
        PolyLine([Point(R.Left, R.Bottom - 1), R.TopLeft, Point(R.Right, R.Top)]);
      end;
    end;
  end;
    
  Result := Rect(Client.Left + 1, Client.Top + 1,
    Client.Right - 2, Client.Bottom - 2);
  if IsDown then OffsetRect(Result, 1, 1);
end;
    
[SecurityPermission(SecurityAction.Assert, UnmanagedCode=True)]
function GetBitBtnGlyph(Kind: TBitBtnKind): TBitmap;
begin
  if BitBtnGlyphs[Kind] = nil then
  begin
    BitBtnGlyphs[Kind] := TBitmap.Create;
{$IF DEFINED(CLR)}
    if Kind <> bkCustom then
      BitBtnGlyphs[Kind].LoadFromResourceName(BitBtnResNames[Kind],
        ResourceBaseName, Assembly.GetExecutingAssembly);
{$ELSE}
    BitBtnGlyphs[Kind].LoadFromResourceName(HInstance, BitBtnResNames[Kind]);
{$ENDIF}
  end;
  Result := BitBtnGlyphs[Kind];
end;

type
  TGlyphList = class(TImageList)
  private
    Used: TBits;
    FCount: Integer;
    function AllocateIndex: Integer;
  public
    constructor CreateSize(AWidth, AHeight: Integer);
    destructor Destroy; override;
    function AddMasked(Image: TBitmap; MaskColor: TColor): Integer;
    procedure Delete(Index: Integer);
    property Count: Integer read FCount;
  end;

  TGlyphCache = class
  private
    GlyphLists: TList;
  public
    constructor Create;
    destructor Destroy; override;
    function GetList(AWidth, AHeight: Integer): TGlyphList;
    procedure ReturnList(List: TGlyphList);
    function Empty: Boolean;
  end;

  TButtonGlyph = class
  private
    FOriginal: TBitmap;
    FGlyphList: TGlyphList;
    FIndexs: array[TButtonState] of Integer;
    FTransparentColor: TColor;
    FNumGlyphs: TNumGlyphs;
    FPaintOnGlass: Boolean;
    FThemeDetails: TThemedElementDetails;
    FThemesEnabled: Boolean;
    FOnChange: TNotifyEvent;
    FThemeTextColor: Boolean;
    procedure GlyphChanged(Sender: TObject);
    procedure SetGlyph(Value: TBitmap);
    procedure SetNumGlyphs(Value: TNumGlyphs);
    procedure Invalidate;
    function CreateButtonGlyph(State: TButtonState): Integer;
    procedure DrawButtonGlyph(Canvas: TCanvas; const GlyphPos: TPoint;
      State: TButtonState; Transparent: Boolean);
    procedure DrawButtonText(Canvas: TCanvas; const Caption: string;
      TextBounds: TRect; State: TButtonState; Flags: Longint);
    procedure CalcButtonLayout(Canvas: TCanvas; const Client: TRect;
      const Offset: TPoint; const Caption: string; Layout: TButtonLayout;
      Margin, Spacing: Integer; var GlyphPos: TPoint; var TextBounds: TRect;
      BiDiFlags: Longint);
  public
    constructor Create;
    destructor Destroy; override;
    { return the text rectangle }
    function Draw(Canvas: TCanvas; const Client: TRect; const Offset: TPoint;
      const Caption: string; Layout: TButtonLayout; Margin, Spacing: Integer;
      State: TButtonState; Transparent: Boolean; BiDiFlags: Longint): TRect;
    property Glyph: TBitmap read FOriginal write SetGlyph;
    property NumGlyphs: TNumGlyphs read FNumGlyphs write SetNumGlyphs;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

{ TGlyphList }

constructor TGlyphList.CreateSize(AWidth, AHeight: Integer);
begin
  inherited CreateSize(AWidth, AHeight);
  Used := TBits.Create;
end;
    
destructor TGlyphList.Destroy;
begin
  Used.Free;
  inherited Destroy;
end;
    
function TGlyphList.AllocateIndex: Integer;
begin
  Result := Used.OpenBit;
  if Result >= Used.Size then
  begin
    Result := inherited Add(nil, nil);
    Used.Size := Result + 1;
  end;
  Used[Result] := True;
end;
    
function TGlyphList.AddMasked(Image: TBitmap; MaskColor: TColor): Integer;
begin
  Result := AllocateIndex;
  ReplaceMasked(Result, Image, MaskColor);
  Inc(FCount);
end;
    
procedure TGlyphList.Delete(Index: Integer);
begin
  if Used[Index] then
  begin
    Dec(FCount);
    Used[Index] := False;
  end;
end;
    
{ TGlyphCache }
    
constructor TGlyphCache.Create;
begin
  inherited Create;
  GlyphLists := TList.Create;
end;
    
destructor TGlyphCache.Destroy;
begin
  GlyphLists.Free;
  inherited Destroy;
end;
    
function TGlyphCache.GetList(AWidth, AHeight: Integer): TGlyphList;
var
  I: Integer;
begin
  for I := GlyphLists.Count - 1 downto 0 do
  begin
    Result := TGlyphList(GlyphLists[I]);
    with Result do
      if (AWidth = Width) and (AHeight = Height) then Exit;
  end;
  Result := TGlyphList.CreateSize(AWidth, AHeight);
  GlyphLists.Add(Result);
end;

procedure TGlyphCache.ReturnList(List: TGlyphList);
begin
  if List = nil then Exit;
  if List.Count = 0 then
  begin
    GlyphLists.Remove(List);
    List.Free;
  end;
end;

function TGlyphCache.Empty: Boolean;
begin
  Result := GlyphLists.Count = 0;
end;

var
  GlyphCache: TGlyphCache = nil;
  ButtonCount: Integer = 0;

{ TButtonGlyph }

constructor TButtonGlyph.Create;
var
  I: TButtonState;
begin
  inherited Create;
  FOriginal := TBitmap.Create;
  FOriginal.OnChange := GlyphChanged;
  FTransparentColor := clOlive;
  FNumGlyphs := 1;
  FPaintOnGlass := False;
  FThemesEnabled := False;
  FThemeTextColor := True;
  for I := Low(I) to High(I) do
    FIndexs[I] := -1;
  if GlyphCache = nil then GlyphCache := TGlyphCache.Create;
end;

destructor TButtonGlyph.Destroy;
begin
  FOriginal.Free;
  Invalidate;
  if Assigned(GlyphCache) and GlyphCache.Empty then
  begin
    GlyphCache.Free;
    GlyphCache := nil;
  end;
  inherited Destroy;
end;

procedure TButtonGlyph.Invalidate;
var
  I: TButtonState;
begin
  for I := Low(I) to High(I) do
  begin
    if FIndexs[I] <> -1 then FGlyphList.Delete(FIndexs[I]);
    FIndexs[I] := -1;
  end;
  GlyphCache.ReturnList(FGlyphList);
  FGlyphList := nil;
end;

procedure TButtonGlyph.GlyphChanged(Sender: TObject);
begin
  if Sender = FOriginal then
  begin
    FTransparentColor := FOriginal.TransparentColor;
    Invalidate;
    if Assigned(FOnChange) then FOnChange(Self);
  end;
end;

procedure TButtonGlyph.SetGlyph(Value: TBitmap);
var
  Glyphs: Integer;
begin
  Invalidate;
  FOriginal.Assign(Value);
  if (Value <> nil) and (Value.Height > 0) then
  begin
    FTransparentColor := Value.TransparentColor;
    if Value.Width mod Value.Height = 0 then
    begin
      Glyphs := Value.Width div Value.Height;
      if Glyphs > 4 then Glyphs := 1;
      SetNumGlyphs(Glyphs);
    end;
  end;
end;

procedure TButtonGlyph.SetNumGlyphs(Value: TNumGlyphs);
begin
  if (Value <> FNumGlyphs) and (Value > 0) then
  begin
    Invalidate;
    FNumGlyphs := Value;
    GlyphChanged(Glyph);
  end;
end;

const
  ROP_DSPDxax = $00E20746;

[SecurityPermission(SecurityAction.Assert, UnmanagedCode=True)]
function TButtonGlyph.CreateButtonGlyph(State: TButtonState): Integer;
var
  TmpImage, DDB, MonoBmp: TBitmap;
  IWidth, IHeight: Integer;
  IRect, ORect: TRect;
  I: TButtonState;
  DestDC: HDC;
begin
  if (State = bsDown) and (NumGlyphs < 3) then State := bsUp;
  Result := FIndexs[State];
  if Result <> -1 then Exit;
  if (FOriginal.Width or FOriginal.Height) = 0 then Exit;
  IWidth := FOriginal.Width div FNumGlyphs;
  IHeight := FOriginal.Height;
  if FGlyphList = nil then
  begin
    if GlyphCache = nil then GlyphCache := TGlyphCache.Create;
    FGlyphList := GlyphCache.GetList(IWidth, IHeight);
  end;
  TmpImage := TBitmap.Create;
  try
    TmpImage.Width := IWidth;
    TmpImage.Height := IHeight;
    IRect := Rect(0, 0, IWidth, IHeight);
    TmpImage.Canvas.Brush.Color := clBtnFace;
    TmpImage.Palette := CopyPalette(FOriginal.Palette);
    I := State;
    if Ord(I) >= NumGlyphs then I := bsUp;
    ORect := Rect(Ord(I) * IWidth, 0, (Ord(I) + 1) * IWidth, IHeight);
    case State of
      bsUp, bsDown,
      bsExclusive:
        begin
          TmpImage.Canvas.CopyRect(IRect, FOriginal.Canvas, ORect);
          if FOriginal.TransparentMode = tmFixed then
            FIndexs[State] := FGlyphList.AddMasked(TmpImage, FTransparentColor)
          else
            FIndexs[State] := FGlyphList.AddMasked(TmpImage, clDefault);
        end;
      bsDisabled:
        begin
          MonoBmp := nil;
          DDB := nil;
          try
            MonoBmp := TBitmap.Create;
            DDB := TBitmap.Create;
            DDB.Assign(FOriginal);
            DDB.HandleType := bmDDB;
            if NumGlyphs > 1 then
            with TmpImage.Canvas do
            begin    { Change white & gray to clBtnHighlight and clBtnShadow }
              CopyRect(IRect, DDB.Canvas, ORect);
              MonoBmp.Monochrome := True;
              MonoBmp.Width := IWidth;
              MonoBmp.Height := IHeight;
    
              { Convert white to clBtnHighlight }
              DDB.Canvas.Brush.Color := clWhite;
              MonoBmp.Canvas.CopyRect(IRect, DDB.Canvas, ORect);
              Brush.Color := clBtnHighlight;
              DestDC := Handle;
              SetTextColor(DestDC, clBlack);
              SetBkColor(DestDC, clWhite);
              BitBlt(DestDC, 0, 0, IWidth, IHeight,
                     MonoBmp.Canvas.Handle, 0, 0, ROP_DSPDxax);
    
              { Convert gray to clBtnShadow }
              DDB.Canvas.Brush.Color := clGray;
              MonoBmp.Canvas.CopyRect(IRect, DDB.Canvas, ORect);
              Brush.Color := clBtnShadow;
              DestDC := Handle;
              SetTextColor(DestDC, clBlack);
              SetBkColor(DestDC, clWhite);
              BitBlt(DestDC, 0, 0, IWidth, IHeight,
                     MonoBmp.Canvas.Handle, 0, 0, ROP_DSPDxax);
    
              { Convert transparent color to clBtnFace }
              DDB.Canvas.Brush.Color := ColorToRGB(FTransparentColor);
              MonoBmp.Canvas.CopyRect(IRect, DDB.Canvas, ORect);
              Brush.Color := clBtnFace;
              DestDC := Handle;
              SetTextColor(DestDC, clBlack);
              SetBkColor(DestDC, clWhite);
              BitBlt(DestDC, 0, 0, IWidth, IHeight,
                     MonoBmp.Canvas.Handle, 0, 0, ROP_DSPDxax);
            end
            else
            begin
              { Create a disabled version }
              with MonoBmp do
              begin
                Assign(FOriginal);
                HandleType := bmDDB;
                Canvas.Brush.Color := clBlack;
                Width := IWidth;
                if Monochrome then
                begin
                  Canvas.Font.Color := clWhite;
                  Monochrome := False;
                  Canvas.Brush.Color := clWhite;
                end;
                Monochrome := True;
              end;
              with TmpImage.Canvas do
              begin
                Brush.Color := clBtnFace;
                FillRect(IRect);
                Brush.Color := clBtnHighlight;
                SetTextColor(Handle, clBlack);
                SetBkColor(Handle, clWhite);
                BitBlt(Handle, 1, 1, IWidth, IHeight,
                  MonoBmp.Canvas.Handle, 0, 0, ROP_DSPDxax);
                Brush.Color := clBtnShadow;
                SetTextColor(Handle, clBlack);
                SetBkColor(Handle, clWhite);
                BitBlt(Handle, 0, 0, IWidth, IHeight,
                  MonoBmp.Canvas.Handle, 0, 0, ROP_DSPDxax);
              end;
            end;
          finally
            DDB.Free;
            MonoBmp.Free;
          end;
          FIndexs[State] := FGlyphList.AddMasked(TmpImage, clDefault);
        end;
    end;
  finally
    TmpImage.Free;
  end;
  Result := FIndexs[State];
  FOriginal.Dormant;
end;

procedure TButtonGlyph.DrawButtonGlyph(Canvas: TCanvas; const GlyphPos: TPoint;
  State: TButtonState; Transparent: Boolean);
var
  Index: Integer;
  Details: TThemedElementDetails;
  R: TRect;
  Button: TThemedButton;
  MemDC: HDC;
  PaintBuffer: HPAINTBUFFER;
begin
  if FOriginal = nil then Exit;
  if (FOriginal.Width = 0) or (FOriginal.Height = 0) then Exit;
  Index := CreateButtonGlyph(State);
  with GlyphPos do
  begin
    if FThemesEnabled then
    begin
      R.Left := GlyphPos.X;
      R.Top := GlyphPos.Y;
      R.Right := R.Left + FOriginal.Width div FNumGlyphs;
      R.Bottom := R.Top + FOriginal.Height;
      case State of
        bsDisabled:
          Button := tbPushButtonDisabled;
        bsDown,
        bsExclusive:
          Button := tbPushButtonPressed;
      else
        // bsUp
        Button := tbPushButtonNormal;
      end;
      Details := StyleServices.GetElementDetails(Button);

      if FPaintOnGlass then
      begin
        PaintBuffer := BeginBufferedPaint(Canvas.Handle, R, BPBF_TOPDOWNDIB, nil, MemDC);
        try
          StyleServices.DrawIcon(MemDC, Details, R, FGlyphList.Handle, Index);
          BufferedPaintMakeOpaque(PaintBuffer, R);
        finally
          EndBufferedPaint(PaintBuffer, True);
        end;
      end
      else
        StyleServices.DrawIcon(Canvas.Handle, Details, R, FGlyphList.Handle, Index);
    end
    else
      if Transparent or (State = bsExclusive) then
      begin
        ImageList_DrawEx(FGlyphList.Handle, Index, Canvas.Handle, X, Y, 0, 0,
          clNone, clNone, ILD_Transparent)
      end
      else
        ImageList_DrawEx(FGlyphList.Handle, Index, Canvas.Handle, X, Y, 0, 0,
          ColorToRGB(clBtnFace), clNone, ILD_Normal);
  end;
end;

procedure TButtonGlyph.DrawButtonText(Canvas: TCanvas; const Caption: string;
  TextBounds: TRect; State: TButtonState; Flags: LongInt);

  procedure DoDrawText(DC: HDC; const Text: UnicodeString;
    var TextRect: TRect; TextFlags: Cardinal);
  var
    LColor: TColor;
    LFormats: TTextFormat;
  begin
    if FThemesEnabled then
    begin
      if (State = bsDisabled) or (not StyleServices.IsSystemStyle and FThemeTextColor) then
      begin
        if not StyleServices.GetElementColor(FThemeDetails, ecTextColor, LColor) or (LColor = clNone) then
          LColor := Canvas.Font.Color;
      end
      else
        LColor := Canvas.Font.Color;

      LFormats := TTextFormatFlags(TextFlags);
      if FPaintOnGlass then
        Include(LFormats, tfComposited);
      StyleServices.DrawText(DC, FThemeDetails, Text, TextRect, LFormats, LColor);
    end
    else
      Winapi.Windows.DrawText(DC, Text, Length(Text), TextRect, TextFlags);
  end;

begin
  with Canvas do
  begin
    Brush.Style := bsClear;
    if (State = bsDisabled) and not FThemesEnabled then
    begin
      OffsetRect(TextBounds, 1, 1);
      Font.Color := clBtnHighlight;
      DoDrawText(Handle, Caption, TextBounds, DT_NOCLIP or DT_CENTER or DT_VCENTER or Flags);
      OffsetRect(TextBounds, -1, -1);
      Font.Color := clBtnShadow;
      DoDrawText(Handle, Caption, TextBounds, DT_NOCLIP or DT_CENTER or DT_VCENTER or Flags);
    end
    else
      DoDrawText(Handle, Caption, TextBounds, DT_NOCLIP or DT_CENTER or DT_VCENTER or Flags);
  end;
end;

procedure TButtonGlyph.CalcButtonLayout(Canvas: TCanvas; const Client: TRect;
  const Offset: TPoint; const Caption: string; Layout: TButtonLayout; Margin,
  Spacing: Integer; var GlyphPos: TPoint; var TextBounds: TRect;
  BiDiFlags: LongInt);
var
  TextPos: TPoint;
  ClientSize, GlyphSize, TextSize: TPoint;
  TotalSize: TPoint;
begin
  if (BiDiFlags and DT_RIGHT) = DT_RIGHT then
    if Layout = blGlyphLeft then Layout := blGlyphRight
    else
      if Layout = blGlyphRight then Layout := blGlyphLeft;
  { calculate the item sizes }
  ClientSize := Point(Client.Right - Client.Left, Client.Bottom -
    Client.Top);

  if FOriginal <> nil then
    GlyphSize := Point(FOriginal.Width div FNumGlyphs, FOriginal.Height) else
    GlyphSize := Point(0, 0);

  if Length(Caption) > 0 then
  begin
    TextBounds := Rect(0, 0, Client.Right - Client.Left, 0);
    DrawText(Canvas.Handle, Caption, Length(Caption), TextBounds,
      DT_CALCRECT or BiDiFlags);
    TextSize := Point(TextBounds.Right - TextBounds.Left, TextBounds.Bottom -
      TextBounds.Top);
  end
  else
  begin
    TextBounds := Rect(0, 0, 0, 0);
    TextSize := Point(0,0);
  end;
    
  { If the layout has the glyph on the right or the left, then both the
    text and the glyph are centered vertically.  If the glyph is on the top
    or the bottom, then both the text and the glyph are centered horizontally.}
  if Layout in [blGlyphLeft, blGlyphRight] then
  begin
    GlyphPos.Y := (ClientSize.Y - GlyphSize.Y + 1) div 2;
    TextPos.Y := (ClientSize.Y - TextSize.Y + 1) div 2;
  end
  else
  begin
    GlyphPos.X := (ClientSize.X - GlyphSize.X + 1) div 2;
    TextPos.X := (ClientSize.X - TextSize.X + 1) div 2;
  end;
    
  { if there is no text or no bitmap, then Spacing is irrelevant }
  if (TextSize.X = 0) or (GlyphSize.X = 0) then
    Spacing := 0;
    
  { adjust Margin and Spacing }
  if Margin = -1 then
  begin
    if Spacing < 0 then
    begin
      TotalSize := Point(GlyphSize.X + TextSize.X, GlyphSize.Y + TextSize.Y);
      if Layout in [blGlyphLeft, blGlyphRight] then
        Margin := (ClientSize.X - TotalSize.X) div 3
      else
        Margin := (ClientSize.Y - TotalSize.Y) div 3;
      Spacing := Margin;
    end
    else
    begin
      TotalSize := Point(GlyphSize.X + Spacing + TextSize.X, GlyphSize.Y +
        Spacing + TextSize.Y);
      if Layout in [blGlyphLeft, blGlyphRight] then
        Margin := (ClientSize.X - TotalSize.X + 1) div 2
      else
        Margin := (ClientSize.Y - TotalSize.Y + 1) div 2;
    end;
  end
  else
  begin
    if Spacing < 0 then
    begin
      TotalSize := Point(ClientSize.X - (Margin + GlyphSize.X), ClientSize.Y -
        (Margin + GlyphSize.Y));
      if Layout in [blGlyphLeft, blGlyphRight] then
        Spacing := (TotalSize.X - TextSize.X) div 2
      else
        Spacing := (TotalSize.Y - TextSize.Y) div 2;
    end;
  end;
    
  case Layout of
    blGlyphLeft:
      begin
        GlyphPos.X := Margin;
        TextPos.X := GlyphPos.X + GlyphSize.X + Spacing;
      end;
    blGlyphRight:
      begin
        GlyphPos.X := ClientSize.X - Margin - GlyphSize.X;
        TextPos.X := GlyphPos.X - Spacing - TextSize.X;
      end;
    blGlyphTop:
      begin
        GlyphPos.Y := Margin;
        TextPos.Y := GlyphPos.Y + GlyphSize.Y + Spacing;
      end;
    blGlyphBottom:
      begin
        GlyphPos.Y := ClientSize.Y - Margin - GlyphSize.Y;
        TextPos.Y := GlyphPos.Y - Spacing - TextSize.Y;
      end;
  end;
    
  { fixup the result variables }
  Inc(GlyphPos.X, Client.Left + Offset.X);
  Inc(GlyphPos.Y, Client.Top + Offset.Y);

  OffsetRect(TextBounds, TextPos.X + Client.Left + Offset.X, TextPos.Y + Client.Top + Offset.Y);
end;

function TButtonGlyph.Draw(Canvas: TCanvas; const Client: TRect;
  const Offset: TPoint; const Caption: string; Layout: TButtonLayout;
  Margin, Spacing: Integer; State: TButtonState; Transparent: Boolean;
  BiDiFlags: LongInt): TRect;
var
  GlyphPos: TPoint;
begin
  CalcButtonLayout(Canvas, Client, Offset, Caption, Layout, Margin, Spacing,
    GlyphPos, Result, BiDiFlags);
  DrawButtonGlyph(Canvas, GlyphPos, State, Transparent);
  DrawButtonText(Canvas, Caption, Result, State, BiDiFlags);
end;

{ TSpeedButtonActionLink }

procedure TSpeedButtonActionLink.AssignClient(AClient: TObject);
begin
  inherited AssignClient(AClient);
  FClient := AClient as TSpeedButton;
end;

constructor TSpeedButtonActionLink.Create(AClient: TObject);
begin
  inherited Create(AClient);
  FImageIndex := -1;
end;

function TSpeedButtonActionLink.IsCheckedLinked: Boolean;
begin
  Result := inherited IsCheckedLinked and (FClient.GroupIndex <> 0) and
    FClient.AllowAllUp and (FClient.Down = TCustomAction(Action).Checked);
end;

function TSpeedButtonActionLink.IsGlyphLinked(Index: TImageIndex): Boolean;
var
  LBitmap: TBitmap;
  Images: TCustomImageList;
begin
  Images := TCustomAction(Action).ActionList.Images;
  Result := (Images <> nil) and (FClient.Glyph <> nil) and
    (FClient.Glyph.Width = Images.Width) and (FClient.Glyph.Height = Images.Height);
  if Result then
  begin
    LBitmap := TBitmap.Create;
    try
      FClient.InternalCopyImage(LBitmap, Images, Index);
      Result := LBitmap.Equals(FClient.Glyph);
    finally
      LBitmap.Free;
    end;
  end;
end;

function TSpeedButtonActionLink.IsGroupIndexLinked: Boolean;
begin
  Result := inherited IsGroupIndexLinked and (FClient is TSpeedButton) and
    (TSpeedButton(FClient).GroupIndex = TCustomAction(Action).GroupIndex);
end;

function TSpeedButtonActionLink.IsImageIndexLinked: Boolean;
begin
  Result := inherited IsImageIndexLinked and
    (FImageIndex = TCustomAction(Action).ImageIndex);
end;

procedure TSpeedButtonActionLink.SetChecked(Value: Boolean);
begin
  if IsCheckedLinked then TSpeedButton(FClient).Down := Value;
end;

procedure TSpeedButtonActionLink.SetGroupIndex(Value: Integer);
begin
  if IsGroupIndexLinked then TSpeedButton(FClient).GroupIndex := Value;
end;

procedure TSpeedButtonActionLink.SetImageIndex(Value: Integer);
begin
  if IsImageIndexLinked or FClient.Glyph.Empty then
  begin
    if Action is TCustomAction then
      with TCustomAction(Action) do
        { Copy image from action's imagelist }
        if (ActionList <> nil) and (ActionList.Images <> nil) then
          if (Value >= 0) and (Value < ActionList.Images.Count) then
          begin
            if IsGlyphLinked(FImageIndex) or FClient.Glyph.Empty then
              FClient.CopyImage(ActionList.Images, Value);
          end
          else
            FClient.Glyph := nil;
    FImageIndex := Value;
  end;
end;

{ TSpeedButton }

constructor TSpeedButton.Create(AOwner: TComponent);
begin
                                       
{$IF DEFINED(CLR)}
  inherited Create(AOwner);
  FGlyph := TButtonGlyph.Create;
  TButtonGlyph(FGlyph).OnChange := GlyphChanged;
{$ELSE}
  FGlyph := TButtonGlyph.Create;
  TButtonGlyph(FGlyph).OnChange := GlyphChanged;
  inherited Create(AOwner);
{$ENDIF}
  SetBounds(0, 0, 23, 22);
  ControlStyle := [csCaptureMouse, csDoubleClicks];
  ParentFont := True;
  Color := clBtnFace;
  FSpacing := 4;
  FMargin := -1;
  FLayout := blGlyphLeft;
  FTransparent := True;
  Inc(ButtonCount);
end;
    
destructor TSpeedButton.Destroy;
begin
  Dec(ButtonCount);
  inherited Destroy;
  TButtonGlyph(FGlyph).Free;
end;

const
  DownStyles: array[Boolean] of Integer = (BDR_RAISEDINNER, BDR_SUNKENOUTER);
  FillStyles: array[Boolean] of Integer = (BF_MIDDLE, 0);

procedure TSpeedButton.Paint;

  function DoGlassPaint: Boolean;
  var
    LParent: TWinControl;
  begin
    Result := csGlassPaint in ControlState;
    if Result then
    begin
      LParent := Parent;
      while (LParent <> nil) and not LParent.DoubleBuffered do
        LParent := LParent.Parent;
      Result := (LParent = nil) or not LParent.DoubleBuffered or (LParent is TCustomForm);
    end;
  end;

var
  PaintRect: TRect;
  DrawFlags: Integer;
  Offset: TPoint;
  LGlassPaint: Boolean;
  Button: TThemedButton;
  ToolButton: TThemedToolBar;
  Details: TThemedElementDetails;
  LStyle: TCustomStyleServices;
begin
  if not Enabled then
  begin
    FState := bsDisabled;
    FDragging := False;
  end
  else if FState = bsDisabled then
    if FDown and (GroupIndex <> 0) then
      FState := bsExclusive
    else
      FState := bsUp;
  Canvas.Font := Self.Font;

  if ThemeControl(Self) then
  begin
    LGlassPaint := DoGlassPaint;
    if not LGlassPaint then
      if Transparent then
        StyleServices.DrawParentBackground(0, Canvas.Handle, nil, True)
      else
        PerformEraseBackground(Self, Canvas.Handle)
    else
      FillRect(Canvas.Handle, ClientRect, GetStockObject(BLACK_BRUSH));

    if not Enabled then
      Button := tbPushButtonDisabled
    else
      if FState in [bsDown, bsExclusive] then
        Button := tbPushButtonPressed
      else
        if MouseInControl then
          Button := tbPushButtonHot
        else
          Button := tbPushButtonNormal;

    ToolButton := ttbToolbarDontCare;
    if FFlat or TStyleManager.IsCustomStyleActive then
    begin
      case Button of
        tbPushButtonDisabled:
          Toolbutton := ttbButtonDisabled;
        tbPushButtonPressed:
          Toolbutton := ttbButtonPressed;
        tbPushButtonHot:
          Toolbutton := ttbButtonHot;
        tbPushButtonNormal:
          Toolbutton := ttbButtonNormal;
      end;
    end;

    PaintRect := ClientRect;
    if ToolButton = ttbToolbarDontCare then
    begin
      Details := StyleServices.GetElementDetails(Button);
      StyleServices.DrawElement(Canvas.Handle, Details, PaintRect);
      StyleServices.GetElementContentRect(Canvas.Handle, Details, PaintRect, PaintRect);
    end
    else
    begin
      Details := StyleServices.GetElementDetails(ToolButton);
      if not TStyleManager.IsCustomStyleActive then
      begin
        StyleServices.DrawElement(Canvas.Handle, Details, PaintRect);
        // Windows theme services doesn't paint disabled toolbuttons
        // with grayed text (as it appears in an actual toolbar). To workaround,
        // retrieve Details for a disabled button for drawing the caption.
        if (ToolButton = ttbButtonDisabled) then
          Details := StyleServices.GetElementDetails(Button);
      end
      else
      begin
        // Special case for flat speedbuttons with custom styles. The assumptions
        // made about the look of ToolBar buttons may not apply, so only paint
        // the hot and pressed states , leaving normal/disabled to appear flat.
        if not FFlat or ((Button = tbPushButtonPressed) or (Button = tbPushButtonHot)) then
          StyleServices.DrawElement(Canvas.Handle, Details, PaintRect);
      end;
      StyleServices.GetElementContentRect(Canvas.Handle, Details, PaintRect, PaintRect);
    end;

    Offset := Point(0, 0);
    if Button = tbPushButtonPressed then
    begin
      // A pressed "flat" speed button has white text in XP, but the Themes
      // API won't render it as such, so we need to hack it.
      if (ToolButton <> ttbToolbarDontCare) and not CheckWin32Version(6) then
        Canvas.Font.Color := clHighlightText
      else
        if FFlat then
          Offset := Point(1, 0);
    end;
    TButtonGlyph(FGlyph).FPaintOnGlass := LGlassPaint;
    TButtonGlyph(FGlyph).FThemeDetails := Details;
    TButtonGlyph(FGlyph).FThemesEnabled := True;
    TButtonGlyph(FGlyph).FThemeTextColor := seFont in StyleElements;
    TButtonGlyph(FGlyph).Draw(Canvas, PaintRect, Offset, Caption, FLayout,
      FMargin, FSpacing, FState, Transparent, DrawTextBiDiModeFlags(0));
  end
  else
  begin
    PaintRect := Rect(0, 0, Width, Height);
    if not FFlat then
    begin
      DrawFlags := DFCS_BUTTONPUSH or DFCS_ADJUSTRECT;
      if FState in [bsDown, bsExclusive] then
        DrawFlags := DrawFlags or DFCS_PUSHED;
      DrawFrameControl(Canvas.Handle, PaintRect, DFC_BUTTON, DrawFlags);
    end
    else
    begin
      if (FState in [bsDown, bsExclusive]) or
        (FMouseInControl and (FState <> bsDisabled)) or
        (csDesigning in ComponentState) then
        DrawEdge(Canvas.Handle, PaintRect, DownStyles[FState in [bsDown, bsExclusive]],
          FillStyles[Transparent] or BF_RECT)
      else if not Transparent then
      begin
        Canvas.Brush.Color := Color;
        Canvas.FillRect(PaintRect);
      end;
      InflateRect(PaintRect, -1, -1);
    end;
    if FState in [bsDown, bsExclusive] then
    begin
      if (FState = bsExclusive) and (not FFlat or not FMouseInControl) then
      begin
        Canvas.Brush.Bitmap := AllocPatternBitmap(clBtnFace, clBtnHighlight);
        Canvas.FillRect(PaintRect);
      end;
      Offset.X := 1;
      Offset.Y := 1;
    end
    else
    begin
      Offset.X := 0;
      Offset.Y := 0;
    end;

    LStyle := StyleServices;
    TButtonGlyph(FGlyph).FThemesEnabled := LStyle.Enabled;
    TButtonGlyph(FGlyph).Draw(Canvas, PaintRect, Offset, Caption, FLayout, FMargin,
      FSpacing, FState, Transparent, DrawTextBiDiModeFlags(0));
  end;
end;

procedure TSpeedButton.UpdateTracking;
var
  P: TPoint;
begin
  if FFlat then
  begin
    if Enabled then
    begin
      GetCursorPos(P);
      FMouseInControl := not (FindDragTarget(P, True) = Self);
      if FMouseInControl then
        Perform(CM_MOUSELEAVE, 0, 0)
      else
        Perform(CM_MOUSEENTER, 0, 0);
    end;
  end;
end;

procedure TSpeedButton.Loaded;
var
  State: TButtonState;
begin
  inherited Loaded;
  if Enabled then
    State := bsUp
  else
    State := bsDisabled;
  TButtonGlyph(FGlyph).CreateButtonGlyph(State);
end;

procedure TSpeedButton.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited MouseDown(Button, Shift, X, Y);
  if (Button = mbLeft) and Enabled then
  begin
    if not FDown then
    begin
      FState := bsDown;
      Invalidate;
    end;
    FDragging := True;
  end;
end;

procedure TSpeedButton.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  NewState: TButtonState;
begin
  inherited MouseMove(Shift, X, Y);
  if FDragging then
  begin
    if not FDown then NewState := bsUp
    else NewState := bsExclusive;
    if (X >= 0) and (X < ClientWidth) and (Y >= 0) and (Y <= ClientHeight) then
      if FDown then NewState := bsExclusive else NewState := bsDown;
    if NewState <> FState then
    begin
      FState := NewState;
      Invalidate;
    end;
  end
  else if not FMouseInControl then
    UpdateTracking;
end;

procedure TSpeedButton.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  DoClick: Boolean;
begin
  inherited MouseUp(Button, Shift, X, Y);
  if FDragging then
  begin
    FDragging := False;
    DoClick := (X >= 0) and (X < ClientWidth) and (Y >= 0) and (Y <= ClientHeight);
    if FGroupIndex = 0 then
    begin
      { Redraw face in-case mouse is captured }
      FState := bsUp;
      FMouseInControl := False;
      if DoClick and not (FState in [bsExclusive, bsDown]) then
        Invalidate;
    end
    else
      if DoClick then
      begin
        SetDown(not FDown);
        if FDown then Repaint;
      end
      else
      begin
        if FDown then FState := bsExclusive;
        Repaint;
      end;
    if DoClick then Click;
    UpdateTracking;
  end;
end;

procedure TSpeedButton.Click;
begin
  inherited Click;
end;

function TSpeedButton.GetPalette: HPALETTE;
begin
  Result := Glyph.Palette;
end;

function TSpeedButton.GetActionLinkClass: TControlActionLinkClass;
begin
  Result := TSpeedButtonActionLink;
end;

function TSpeedButton.GetGlyph: TBitmap;
begin
  Result := TButtonGlyph(FGlyph).Glyph;
end;

procedure TSpeedButton.SetGlyph(Value: TBitmap);
begin
  TButtonGlyph(FGlyph).Glyph := Value;
  Invalidate;
end;

function TSpeedButton.GetNumGlyphs: TNumGlyphs;
begin
  Result := TButtonGlyph(FGlyph).NumGlyphs;
end;

procedure TSpeedButton.SetNumGlyphs(Value: TNumGlyphs);
begin
  if Value < 0 then Value := 1
  else if Value > 4 then Value := 4;
  if Value <> TButtonGlyph(FGlyph).NumGlyphs then
  begin
    TButtonGlyph(FGlyph).NumGlyphs := Value;
    Invalidate;
  end;
end;

procedure TSpeedButton.GlyphChanged(Sender: TObject);
begin
  Invalidate;
end;

function TSpeedButton.HasCustomGlyph: Boolean;
var
  Link: TSpeedButtonActionLink;
begin
  Link := TSpeedButtonActionLink(ActionLink);
  Result := not ((Link <> nil) and Link.IsImageIndexLinked and Link.IsGlyphLinked(Link.FImageIndex));
end;

procedure TSpeedButton.InternalCopyImage(Image: TBitmap; ImageList: TCustomImageList; Index: Integer);
begin
  with Image do
  begin
    Width := ImageList.Width;
    Height := ImageList.Height;
    Canvas.Brush.Color := clFuchsia;//! for lack of a better color
    Canvas.FillRect(Rect(0,0, Width, Height));
    ImageList.Draw(Canvas, 0, 0, Index);
  end;
end;

procedure TSpeedButton.UpdateExclusive;
var
{$IF DEFINED(CLR)}
  I: Integer;
{$ELSE}
  Msg: TMessage;
{$ENDIF}
begin
  if (FGroupIndex <> 0) and (Parent <> nil) then
  begin
{$IF DEFINED(CLR)}
    for I := 0 to Parent.ControlCount - 1 do
      if Parent.Controls[I] is TSpeedButton then
        TSpeedButton(Parent.Controls[I]).ButtonPressed(FGroupIndex, Self);
{$ELSE}
    Msg.Msg := CM_BUTTONPRESSED;
    Msg.WParam := FGroupIndex;
    Msg.LParam := LPARAM(Self);
    Msg.Result := 0;
    Parent.Broadcast(Msg);
{$ENDIF}
  end;
end;

procedure TSpeedButton.SetDown(Value: Boolean);
begin
  if FGroupIndex = 0 then Value := False;
  if Value <> FDown then
  begin
    if FDown and (not FAllowAllUp) then Exit;
    FDown := Value;
    if Value then
    begin
      if FState = bsUp then Invalidate;
      FState := bsExclusive
    end
    else
    begin
      FState := bsUp;
      Repaint;
    end;
    if Value then UpdateExclusive;
  end;
end;

procedure TSpeedButton.SetFlat(Value: Boolean);
begin
  if Value <> FFlat then
  begin
    FFlat := Value;
    Invalidate;
  end;
end;

procedure TSpeedButton.SetGroupIndex(Value: Integer);
begin
  if FGroupIndex <> Value then
  begin
    FGroupIndex := Value;
    UpdateExclusive;
  end;
end;

procedure TSpeedButton.SetLayout(Value: TButtonLayout);
begin
  if FLayout <> Value then
  begin
    FLayout := Value;
    Invalidate;
  end;
end;

procedure TSpeedButton.SetMargin(Value: Integer);
begin
  if (Value <> FMargin) and (Value >= -1) then
  begin
    FMargin := Value;
    Invalidate;
  end;
end;

procedure TSpeedButton.SetSpacing(Value: Integer);
begin
  if Value <> FSpacing then
  begin
    FSpacing := Value;
    Invalidate;
  end;
end;

procedure TSpeedButton.SetTransparent(Value: Boolean);
begin
  if Value <> FTransparent then
  begin
    FTransparent := Value;
    if Value then
      ControlStyle := ControlStyle - [csOpaque] else
      ControlStyle := ControlStyle + [csOpaque];
    Invalidate;
  end;
end;

procedure TSpeedButton.SetAllowAllUp(Value: Boolean);
begin
  if FAllowAllUp <> Value then
  begin
    FAllowAllUp := Value;
    UpdateExclusive;
  end;
end;

procedure TSpeedButton.WMLButtonDblClk(var Message: TWMLButtonDblClk);
begin
  inherited;
  if FDown then DblClick;
end;

procedure TSpeedButton.CMEnabledChanged(var Message: TMessage);
const
  NewState: array[Boolean] of TButtonState = (bsDisabled, bsUp);
begin
  TButtonGlyph(FGlyph).CreateButtonGlyph(NewState[Enabled]);
  UpdateTracking;
  Repaint;
end;

{$IF DEFINED(CLR)}
procedure TSpeedButton.ButtonPressed(Group: Integer; Button: TSpeedButton);
begin
  if (Group = FGroupIndex) and (Button <> Self) then
  begin
    if Button.Down and FDown then
    begin
      FDown := False;
      FState := bsUp;
      if (Action is TCustomAction) then
        TCustomAction(Action).Checked := False;
      Invalidate;
    end;
    FAllowAllUp := Button.AllowAllUp;
  end;
end;
{$ELSE}
procedure TSpeedButton.CMButtonPressed(var Message: TMessage);
var
  Sender: TSpeedButton;
begin
  if Message.WParam = WPARAM(FGroupIndex) then
  begin
    Sender := TSpeedButton(Message.LParam);
    if Sender <> Self then
    begin
      if Sender.Down and FDown then
      begin
        FDown := False;
        FState := bsUp;
        if (Action is TCustomAction) then
          TCustomAction(Action).Checked := False;
        Invalidate;
      end;
      FAllowAllUp := Sender.AllowAllUp;
    end;
  end;
end;
{$ENDIF}

procedure TSpeedButton.CMDialogChar(var Message: TCMDialogChar);
begin
  with Message do
    if IsAccel(CharCode, Caption) and Enabled and Visible and
      (Parent <> nil) and Parent.Showing then
    begin
      Click;
      Result := 1;
    end else
      inherited;
end;

procedure TSpeedButton.CMFontChanged(var Message: TMessage);
begin
  Invalidate;
end;

procedure TSpeedButton.CMTextChanged(var Message: TMessage);
begin
  Invalidate;
end;

procedure TSpeedButton.CMSysColorChange(var Message: TMessage);
begin
  with TButtonGlyph(FGlyph) do
  begin
    Invalidate;
    CreateButtonGlyph(FState);
  end;
end;

procedure TSpeedButton.CMMouseEnter(var Message: TMessage);
var
  NeedRepaint: Boolean;
begin
  inherited;
  { Don't draw a border if DragMode <> dmAutomatic since this button is meant to
    be used as a dock client. }
  NeedRepaint := FFlat and not FMouseInControl and Enabled and (DragMode <> dmAutomatic) and (GetCapture = 0);

  { Windows XP introduced hot states also for non-flat buttons. }
  if (NeedRepaint or StyleServices.Enabled) and not (csDesigning in ComponentState) then
  begin
    FMouseInControl := True;
    if Enabled then
      Repaint;
  end;
end;

procedure TSpeedButton.CMMouseLeave(var Message: TMessage);
var
  NeedRepaint: Boolean;
begin
  inherited;
  NeedRepaint := FFlat and FMouseInControl and Enabled and not FDragging;
  { Windows XP introduced hot states also for non-flat buttons. }
  if NeedRepaint or StyleServices.Enabled then
  begin
    FMouseInControl := False;
    if Enabled then
      Repaint;
  end;
end;

procedure TSpeedButton.CopyImage(ImageList: TCustomImageList; Index: Integer);
begin
  InternalCopyImage(Glyph, ImageList, Index);
end;

procedure TSpeedButton.ActionChange(Sender: TObject; CheckDefaults: Boolean);
var
  Link: TSpeedButtonActionLink;
begin
  inherited ActionChange(Sender, CheckDefaults);
  if Sender is TCustomAction then
    with TCustomAction(Sender) do
    begin
      Link := TSpeedButtonActionLink(ActionLink);
      if CheckDefaults and not Link.IsGlyphLinked(Link.FImageIndex) and (not Glyph.Empty) then
        Exit;
      if CheckDefaults or (Link.FImageIndex <> -1) or (Link.FImageIndex <> ImageIndex) then
      begin
        Link.FImageIndex := ImageIndex;
        if ImageIndex <> -1 then
          Glyph := nil;
      end;
      if CheckDefaults or (Self.GroupIndex = 0) then
        Self.GroupIndex := GroupIndex;
      { Copy image from action's imagelist }
      if (Glyph.Empty) and (ActionList <> nil) and (ActionList.Images <> nil) and
        (ImageIndex >= 0) and (ImageIndex < ActionList.Images.Count) then
        CopyImage(ActionList.Images, ImageIndex);
    end;
end;

{ TBitBtn }

class constructor TBitBtn.Create;
begin
  TCustomStyleEngine.RegisterStyleHook(TBitBtn, TBitBtnStyleHook);
end;

class destructor TBitBtn.Destroy;
begin
  TCustomStyleEngine.UnRegisterStyleHook(TBitBtn, TBitBtnStyleHook);
end;


constructor TBitBtn.Create(AOwner: TComponent);
begin
                                        
{$IF DEFINED(CLR)}
  inherited Create(AOwner);
  FGlyph := TButtonGlyph.Create;
  TButtonGlyph(FGlyph).OnChange := GlyphChanged;
{$ELSE}
  FGlyph := TButtonGlyph.Create;
  TButtonGlyph(FGlyph).OnChange := GlyphChanged;
  inherited Create(AOwner);
{$ENDIF}
  FCanvas := TCanvas.Create;
  FStyle := bsAutoDetect;
  FKind := bkCustom;
  FLayout := blGlyphLeft;
  FSpacing := 4;
  FMargin := -1;
  ControlStyle := ControlStyle + [csReflector, csPaintBlackOpaqueOnGlass];
  DoubleBuffered := True;
end;

destructor TBitBtn.Destroy;
begin
  inherited Destroy;
  TButtonGlyph(FGlyph).Free;
  FCanvas.Free;
end;

[UIPermission(SecurityAction.LinkDemand, Window=UIPermissionWindow.AllWindows)]
procedure TBitBtn.CreateHandle;
var
  State: TButtonState;
begin
  if Enabled then
    State := bsUp
  else
    State := bsDisabled;
  inherited CreateHandle;
  TButtonGlyph(FGlyph).CreateButtonGlyph(State);
end;
    
procedure TBitBtn.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do Style := Style or BS_OWNERDRAW;
end;
    
procedure TBitBtn.SetButtonStyle(ADefault: Boolean);
begin
  if ADefault <> IsFocused then
  begin
    IsFocused := ADefault;
    Refresh;
  end;
end;

procedure TBitBtn.UpdateStyleElements;
begin
  Invalidate;
end;

procedure TBitBtn.Click;
var
  Form: TCustomForm;
  Control: TWinControl;
begin
  case FKind of
    bkClose:
      begin
        Form := GetParentForm(Self);
        if Form <> nil then Form.Close
        else inherited Click;
      end;
    bkHelp:
      begin
        Control := Self;
        while (Control <> nil) and
              (((Control.HelpType = htContext) and (Control.HelpContext = 0)) or
              ((Control.HelpType = htKeyword) and (Control.HelpKeyword = ''))) do
          Control := Control.Parent;
        if Control <> nil then
        begin
          if Control.HelpType = htContext then
            Application.HelpContext(Control.HelpContext)
          else
            Application.HelpKeyword(Control.HelpKeyword);
        end
        else
          inherited Click;
      end;
    else
      inherited Click;
  end;
end;

procedure TBitBtn.CNMeasureItem(var Message: TWMMeasureItem);
var
{$IF DEFINED(CLR)}
  Temp: TMeasureItemStruct;
{$ELSE}
  Temp: PMeasureItemStruct;
{$ENDIF}
begin
  Temp := Message.MeasureItemStruct;
  with Temp{$IFNDEF CLR}^{$ENDIF} do
  begin
    itemWidth := Width;
    itemHeight := Height;
  end;
{$IF DEFINED(CLR)}
  Message.MeasureItemStruct := Temp;
{$ENDIF}
end;

procedure TBitBtn.CNDrawItem(var Message: TWMDrawItem);
begin
  DrawItem(Message.DrawItemStruct{$IFNDEF CLR}^{$ENDIF});
end;

procedure TBitBtn.DrawItem(const DrawItemStruct: TDrawItemStruct);
const
  WordBreakFlag: array[Boolean] of Integer = (0, DT_WORDBREAK);
var
  IsDown, IsDefault: Boolean;
  State: TButtonState;
  R: TRect;
  Flags: Longint;
  Details: TThemedElementDetails;
  Button: TThemedButton;
  Offset: TPoint;
  LStyle: TCustomStyleServices;
begin
  FCanvas.Handle := DrawItemStruct.hDC;
  R := ClientRect;

  with DrawItemStruct do
  begin
    FCanvas.Handle := hDC;
    FCanvas.Font := Self.Font;
    IsDown := itemState and ODS_SELECTED <> 0;
    IsDefault := itemState and ODS_FOCUS <> 0;

    if not Enabled then State := bsDisabled
    else if IsDown then State := bsDown
    else State := bsUp;
  end;

  if ThemeControl(Self) then
  begin
    LStyle := StyleServices;
    if not Enabled then
      Button := tbPushButtonDisabled
    else
      if IsDown then
        Button := tbPushButtonPressed
      else
        if FMouseInControl then
          Button := tbPushButtonHot
        else
          if IsFocused or IsDefault then
            Button := tbPushButtonDefaulted
          else
            Button := tbPushButtonNormal;

    Details := LStyle.GetElementDetails(Button);
    // Parent background.
    if not (csGlassPaint in ControlState) then
      LStyle.DrawParentBackground(Handle, DrawItemStruct.hDC, Details, True)
    else
      FillRect(DrawItemStruct.hDC, R, GetStockObject(BLACK_BRUSH));
    // Button shape.
    LStyle.DrawElement(DrawItemStruct.hDC, Details, DrawItemStruct.rcItem);
    LStyle.GetElementContentRect(FCanvas.Handle, Details, DrawItemStruct.rcItem, R);

    Offset := Point(0, 0);
    TButtonGlyph(FGlyph).FPaintOnGlass := csGlassPaint in ControlState;
    TButtonGlyph(FGlyph).FThemeDetails := Details;
    TButtonGlyph(FGlyph).FThemesEnabled := ThemeControl(Self);
    TButtonGlyph(FGlyph).FThemeTextColor := seFont in StyleElements;
    TButtonGlyph(FGlyph).Draw(FCanvas, R, Offset, Caption, FLayout, FMargin, FSpacing, State, False,
      DrawTextBiDiModeFlags(0) or WordBreakFlag[WordWrap]);

    if IsFocused and IsDefault and LStyle.IsSystemStyle then
    begin
      FCanvas.Pen.Color := clWindowFrame;
      FCanvas.Brush.Color := clBtnFace;
      DrawFocusRect(FCanvas.Handle, R);
    end;
  end
  else
  begin
    R := ClientRect;

    Flags := DFCS_BUTTONPUSH or DFCS_ADJUSTRECT;
    if IsDown then Flags := Flags or DFCS_PUSHED;
    if DrawItemStruct.itemState and ODS_DISABLED <> 0 then
      Flags := Flags or DFCS_INACTIVE;

    { DrawFrameControl doesn't allow for drawing a button as the
        default button, so it must be done here. }
    if IsFocused or IsDefault then
    begin
      FCanvas.Pen.Color := clWindowFrame;
      FCanvas.Pen.Width := 1;
      FCanvas.Brush.Style := bsClear;
      FCanvas.Rectangle(R.Left, R.Top, R.Right, R.Bottom);

      { DrawFrameControl must draw within this border }
      InflateRect(R, -1, -1);
    end;
    
    { DrawFrameControl does not draw a pressed button correctly }
    if IsDown then
    begin
      FCanvas.Pen.Color := clBtnShadow;
      FCanvas.Pen.Width := 1;
      FCanvas.Brush.Color := clBtnFace;
      FCanvas.Rectangle(R.Left, R.Top, R.Right, R.Bottom);
      InflateRect(R, -1, -1);
    end
    else
      DrawFrameControl(DrawItemStruct.hDC, R, DFC_BUTTON, Flags);

    if IsFocused then
    begin
      R := ClientRect;
      InflateRect(R, -1, -1);
    end;

    FCanvas.Font := Self.Font;
    if IsDown then
      OffsetRect(R, 1, 1);

    TButtonGlyph(FGlyph).FThemesEnabled := ThemeControl(Self);
    TButtonGlyph(FGlyph).Draw(FCanvas, R, Point(0,0), Caption, FLayout, FMargin,
      FSpacing, State, False, DrawTextBiDiModeFlags(0) or WordBreakFlag[WordWrap]);

    if IsFocused and IsDefault then
    begin
      R := ClientRect;
      InflateRect(R, -4, -4);
      FCanvas.Pen.Color := clWindowFrame;
      FCanvas.Brush.Color := clBtnFace;
      DrawFocusRect(FCanvas.Handle, R);
    end;
  end;

  FCanvas.Handle := 0;
end;
    
procedure TBitBtn.CMFontChanged(var Message: TMessage);
begin
  inherited;
  Invalidate;
end;

procedure TBitBtn.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  Invalidate;
end;

procedure TBitBtn.WMLButtonDblClk(var Message: TWMLButtonDblClk);
begin
  Perform(WM_LBUTTONDOWN, Message.Keys, LPARAM(Word(Message.XPos) or (Word(Message.YPos) shr 16)));
end;

function TBitBtn.GetPalette: HPALETTE;
begin
  Result := Glyph.Palette;
end;
    
procedure TBitBtn.SetGlyph(Value: TBitmap);
begin
  TButtonGlyph(FGlyph).Glyph := Value as TBitmap;
  FModifiedGlyph := True;
  Invalidate;
end;
    
function TBitBtn.GetGlyph: TBitmap;
begin
  Result := TButtonGlyph(FGlyph).Glyph;
end;
    
procedure TBitBtn.GlyphChanged(Sender: TObject);
begin
  Invalidate;
end;

procedure TBitBtn.InternalCopyImage(Image: TBitmap;
  ImageList: TCustomImageList; Index: Integer);
begin
  with Image do
  begin
    Width := ImageList.Width;
    Height := ImageList.Height;
    Canvas.Brush.Color := clFuchsia;//! for lack of a better color
    Canvas.FillRect(Rect(0,0, Width, Height));
    ImageList.Draw(Canvas, 0, 0, Index);
  end;
end;

function TBitBtn.IsCustom: Boolean;
var
  Link: TBitBtnActionLink;
begin
  Link := TBitBtnActionLink(ActionLink);
  Result := (Kind = bkCustom) and
    not ((Link <> nil) and Link.IsImageIndexLinked and Link.IsGlyphLinked(Link.FImageIndex));
end;
    
procedure TBitBtn.SetStyle(Value: TButtonStyle);
begin
  if Value <> FStyle then
  begin
    FStyle := Value;
    Invalidate;
  end;
end;

{$IF DEFINED(CLR)}
function TBitBtn.BitBtnCaptions(Kind: TBitBtnKind): string;
begin
  case Kind of
    bkOK: Result := SOKButton;
    bkCancel: Result := SCancelButton;
    bkHelp: Result := SHelpButton;
    bkYes: Result := SYesButton;
    bkNo: Result := SNoButton;
    bkClose: Result := SCloseButton;
    bkAbort: Result := SAbortButton;
    bkRetry: Result := SRetryButton;
    bkIgnore: Result := SIgnoreButton;
    bkAll: Result := SAllButton;
  else
    Result := '';
  end;
end;
{$ENDIF}

procedure TBitBtn.SetKind(Value: TBitBtnKind);
begin
  if Value <> FKind then
  begin
    if Value <> bkCustom then
    begin
      Default := Value in [bkOK, bkYes];
      Cancel := Value in [bkCancel, bkNo];

      if ((csLoading in ComponentState) and (Caption = '')) or
        (not (csLoading in ComponentState)) then
      begin
{$IF DEFINED(CLR)}
        if Value <> bkCustom then
          Caption := BitBtnCaptions(Value);
{$ELSE}
        if BitBtnCaptions[Value] <> nil then
          Caption := LoadResString(BitBtnCaptions[Value]);
{$ENDIF}
      end;

      ModalResult := BitBtnModalResults[Value];
      TButtonGlyph(FGlyph).Glyph := GetBitBtnGlyph(Value);
      NumGlyphs := 2;
      FModifiedGlyph := False;
    end;
    FKind := Value;
    Invalidate;
  end;
end;

function TBitBtn.IsCustomCaption: Boolean;
begin
{$IF DEFINED(CLR)}
  Result := WideCompareStr(Caption, BitBtnCaptions(FKind)) <> 0;
{$ELSE}
  Result := AnsiCompareStr(Caption, LoadResString(BitBtnCaptions[FKind])) <> 0;
{$ENDIF}
end;
    
function TBitBtn.GetKind: TBitBtnKind;
begin
  if FKind <> bkCustom then
    if ((FKind in [bkOK, bkYes]) xor Default) or
      ((FKind in [bkCancel, bkNo]) xor Cancel) or
      (ModalResult <> BitBtnModalResults[FKind]) or
      FModifiedGlyph then
      FKind := bkCustom;
  Result := FKind;
end;
    
procedure TBitBtn.SetLayout(Value: TButtonLayout);
begin
  if FLayout <> Value then
  begin
    FLayout := Value;
    Invalidate;
  end;
end;
    
function TBitBtn.GetNumGlyphs: TNumGlyphs;
begin
  Result := TButtonGlyph(FGlyph).NumGlyphs;
end;
    
procedure TBitBtn.SetNumGlyphs(Value: TNumGlyphs);
begin
  if Value < 0 then Value := 1
  else if Value > 4 then Value := 4;
  if Value <> TButtonGlyph(FGlyph).NumGlyphs then
  begin
    TButtonGlyph(FGlyph).NumGlyphs := Value;
    Invalidate;
  end;
end;

procedure TBitBtn.SetSpacing(Value: Integer);
begin
  if FSpacing <> Value then
  begin
    FSpacing := Value;
    Invalidate;
  end;
end;
    
procedure TBitBtn.SetMargin(Value: Integer);
begin
  if (Value <> FMargin) and (Value >= - 1) then
  begin
    FMargin := Value;
    Invalidate;
  end;
end;

procedure TBitBtn.CopyImage(ImageList: TCustomImageList; Index: Integer);
begin
  InternalCopyImage(Glyph, ImageList, Index);
end;

procedure TBitBtn.ActionChange(Sender: TObject; CheckDefaults: Boolean);
var
  Link: TBitBtnActionLink;
begin
  inherited ActionChange(Sender, CheckDefaults);
  if Sender is TCustomAction then
    with TCustomAction(Sender) do
    begin
      Link := TBitBtnActionLink(ActionLink);
      if CheckDefaults and not Link.IsGlyphLinked(Link.FImageIndex) and (not Glyph.Empty) then
        Exit;
      if CheckDefaults or (Link.FImageIndex <> -1) or (Link.FImageIndex <> ImageIndex) then
      begin
        Link.FImageIndex := ImageIndex;
        if ImageIndex <> -1 then
          Glyph := nil;
      end;
      { Copy image from action's imagelist }
      if (Glyph.Empty) and (ActionList <> nil) and (ActionList.Images <> nil) and
        (ImageIndex >= 0) and (ImageIndex < ActionList.Images.Count) then
        CopyImage(ActionList.Images, ImageIndex);
    end;
end;

{$IF NOT DEFINED(CLR)}
procedure DestroyLocals; far;
var
  I: TBitBtnKind;
begin
  for I := Low(TBitBtnKind) to High(TBitBtnKind) do
    BitBtnGlyphs[I].Free;
end;
{$ENDIF}

procedure TBitBtn.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  if StyleServices.Enabled and not FMouseInControl and not (csDesigning in ComponentState) then
  begin
    FMouseInControl := True;
    Repaint;
  end;
end;

procedure TBitBtn.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  if StyleServices.Enabled and FMouseInControl then
  begin
    FMouseInControl := False;
    Repaint;
  end;
end;

function TBitBtn.GetActionLinkClass: TControlActionLinkClass;
begin
  Result := TBitBtnActionLink;
end;

{ TBinBtnStyleHook }

procedure TBitBtnStyleHook.DrawButton(ACanvas: TCanvas; AMouseInControl: Boolean);
const
  WordBreakFlag: array[Boolean] of Integer = (0, DT_WORDBREAK);
var
  Details:  TThemedElementDetails;
  DrawRect: TRect;
  Offset: TPoint;
  State: TButtonState;
begin
  if not (Control is TBitBtn) then
  begin
    inherited;
    Exit;
  end;
  DrawRect := Control.ClientRect;
  if FPressed then
    Details := StyleServices.GetElementDetails(tbPushButtonPressed)
  else if AMouseInControl then
    Details := StyleServices.GetElementDetails(tbPushButtonHot)
  else if Focused then
    Details := StyleServices.GetElementDetails(tbPushButtonDefaulted)
  else if Control.Enabled then
    Details := StyleServices.GetElementDetails(tbPushButtonNormal)
  else
    Details := StyleServices.GetElementDetails(tbPushButtonDisabled);
  DrawRect := Control.ClientRect;
  StyleServices.DrawElement(ACanvas.Handle, Details, DrawRect);

  Offset := Point(0, 0);
  with TBitBtn(Control) do
  begin
    if not Enabled then State := bsDisabled
    else if FPressed then State := bsDown
    else State := bsUp;
    ACanvas.Font := Font;
    TButtonGlyph(FGlyph).FPaintOnGlass := False;
    TButtonGlyph(FGlyph).FThemeDetails := Details;
    TButtonGlyph(FGlyph).FThemesEnabled := True;
    TButtonGlyph(FGlyph).FThemeTextColor := seFont in StyleElements;
    TButtonGlyph(FGlyph).Draw(ACanvas, DrawRect, Offset, Caption, FLayout, FMargin, FSpacing, State, False,
      DrawTextBiDiModeFlags(0) or WordBreakFlag[WordWrap]);
  end;
end;

{ TBitBtnActionLink }

procedure TBitBtnActionLink.AssignClient(AClient: TObject);
begin
  inherited AssignClient(AClient);
  FClient := AClient as TBitBtn;
end;

constructor TBitBtnActionLink.Create(AClient: TObject);
begin
  inherited;
  FImageIndex := -1;
end;

function TBitBtnActionLink.IsImageIndexLinked: Boolean;
begin
  Result := inherited IsImageIndexLinked and
    (FImageIndex = TCustomAction(Action).ImageIndex);
end;

function TBitBtnActionLink.IsGlyphLinked(Index: TImageIndex): Boolean;
var
  LBitmap: TBitmap;
  Images: TCustomImageList;
begin
  Images := TCustomAction(Action).ActionList.Images;
  Result := (Images <> nil) and (FClient.Glyph <> nil) and
    (FClient.Glyph.Width = Images.Width) and (FClient.Glyph.Height = Images.Height);
  if Result then
  begin
    LBitmap := TBitmap.Create;
    try
      FClient.InternalCopyImage(LBitmap, Images, Index);
      Result := LBitmap.Equals(FClient.Glyph);
    finally
      LBitmap.Free;
    end;
  end;
end;

procedure TBitBtnActionLink.SetImageIndex(Value: Integer);
begin
  if IsImageIndexLinked or FClient.Glyph.Empty then
  begin
    if Action is TCustomAction then
      with TCustomAction(Action) do
        { Copy image from action's imagelist }
        if (ActionList <> nil) and (ActionList.Images <> nil) then
          if (Value >= 0) and (Value < ActionList.Images.Count) then
          begin
            if IsGlyphLinked(FImageIndex) or FClient.Glyph.Empty then
              FClient.CopyImage(ActionList.Images, Value);
          end
          else
            FClient.Glyph := nil;
    FImageIndex := Value;
    FClient.GlyphChanged(nil);
  end;
end;

{ TBaseNavigator }

constructor TBaseNavigator.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle - [csAcceptsControls, csSetCaption, csGestures] + [csOpaque];
  if not NewStyleControls then ControlStyle := ControlStyle + [csFramed];
  FButtonInstances :=  TDictionary<TNavBtnID, TButtonInstance>.Create;
  FBtnIDs :=  TList<TNavBtnID>.Create;
  BevelOuter := bvNone;
  BevelInner := bvNone;
  Orientation := TOrientation.orHorizontal;
  Width := 241;
  Height := 25;
  ButtonWidth := 0;
  ButtonHeight := 0;
  FocusedButton := 0; // nbFirst;
  FConfirmDelete := True;
  FullRepaint := False;
end;

procedure TBaseNavigator.CreateWnd;
var
  I: TNavBtnID;
  UseGlyphs: Boolean;
  LNavButton: TNavButton;
begin
  inherited;
  UseGlyphs := not StyleServices.Enabled or StyleServices.IsSystemStyle;
  for I in FBtnIDs do
  begin
    LNavButton := FButtonInstances[I].Instance;
    if LNavButton <> nil then
      if UseGlyphs and (LNavButton.Glyph.Empty) then
        SetButtonGlyph(I)
      else if not UseGlyphs then
        // With custom styles, glyphs are painted in the Paint method
        LNavButton.Glyph.SetSize(0, 0);
  end;
end;

destructor TBaseNavigator.Destroy;
begin
  FButtonInstances.Free;
  FBtnIDs.Free;
  inherited Destroy;
end;

procedure TBaseNavigator.Paint;
begin
  if not Flat and StyleServices.Enabled and not StyleServices.IsSystemStyle  then
    with Canvas do
    begin
      Brush.Style := bsSolid;
      Brush.Color := StyleServices.GetSystemColor(clBtnFace);
      FillRect(Rect(0, 0, Width, Height));
    end
  else
    inherited;
end;

procedure TBaseNavigator.DefineButtons(ADescriptions: TArray<TButtonDescription>);
var
  LRecord: TButtonInstance;
  LDescription: TButtonDescription;
begin
  for LDescription in ADescriptions do
  begin
    LRecord.Instance := nil;
    LRecord.Description := LDescription;
    FButtonInstances.Add(LDescription.ID, LRecord);
    FBtnIDs.Add(LDescription.ID);
  end;
  InitButtons;
end;

procedure TBaseNavigator.InitButtons;
var
  I: TNavBtnID;
  Btn: TNavButton;
  X, Y: Integer;
  LRecord: TButtonInstance;
begin
  MinBtnSize := Point(20, 18);
  X := 0;
  Y := 0;
  for I in FBtnIDs do
  begin
    LRecord := FButtonInstances[I];
    Btn := TNavButton.Create(Self);
    Btn.Flat := Flat;
    Btn.Index := I;
    Btn.Visible := LRecord.Description.DefaultVisible;
    Btn.Hint := LRecord.Description.DefaultHint;
    if LRecord.Description.AllowTimer then
      Btn.NavStyle := Btn.NavStyle + [nsAllowTimer];
    Btn.Enabled := True;
    Btn.SetBounds (X, Y, MinBtnSize.X, MinBtnSize.Y);
    Btn.Enabled := False;
    Btn.Enabled := True;
    Btn.OnClick := ClickHandler;
    Btn.OnMouseDown := BtnMouseDown;
    Btn.Parent := Self;
    Assert(FButtonInstances[I].Instance = nil);
    LRecord.Instance := Btn;
    FButtonInstances[I] := LRecord;
    if Orientation = TOrientation.orHorizontal then
      X := X + MinBtnSize.X
    else
      Y := Y + MinBtnSize.Y;
  end;
end;


procedure TBaseNavigator.SetFlat(Value: Boolean);
var
  I: TNavBtnID;
begin
  if FFlat <> Value then
  begin
    FFlat := Value;
    for I in FBtnIDs do
      if FButtonInstances[I].Instance <> nil then
        FButtonInstances[I].Instance.Flat := Value;

    if Value then
      ControlStyle := ControlStyle - [csOpaque]
    else
      ControlStyle := ControlStyle + [csOpaque];
  end;
end;

procedure TBaseNavigator.SetKind(Value: TOrientation);
begin
  if FOrientation <> Value then
  begin
    FOrientation := Value;
    if not (csLoading in ComponentState) then
      SetBounds(Left, Top, Height, Width);
    Invalidate;
  end;
end;

function TBaseNavigator.GetButton(Index: TNavBtnID): TNavButton;
begin
  Result := FButtonInstances[Index].Instance;
end;

procedure TBaseNavigator.GetChildren(Proc: TGetChildProc; Root: TComponent);
begin
end;

procedure TBaseNavigator.SetVisible(Value: TArray<TNavBtnID>);
var
  I: TNavBtnID;
  W, H: Integer;
  LList: TList<TNavBtnID>;
  LVisible: Boolean;
  LUpdate: Boolean;
begin
  LUpdate := False;
  W := Width;
  H := Height;
  LList := TList<TNavBtnID>.Create;
  try
    LList.AddRange(Value);
    for I in FBtnIDs do
    begin
      LVisible := LList.Contains(I);
      Assert(FButtonInstances[I].Instance <> nil);
      LUpdate := True;
      FButtonInstances[I].Instance.Visible := LVisible;
    end;
  finally
    LList.Free;
  end;
  if LUpdate then
  begin
    SetSize(W, H);
    if (W <> Width) or (H <> Height) then
      inherited SetBounds (Left, Top, W, H);
    Invalidate;
  end;
end;

procedure TBaseNavigator.CalcMinSize(var W, H: Integer);
var
  Count: Integer;
  I: TNavBtnID;
begin
  if (csLoading in ComponentState) then Exit;
  if FButtonInstances = nil then Exit;

  Count := 0;
  for I in FBtnIDs do
  begin
    if FButtonInstances[I].Instance = nil then
      Exit; // Not created yet
    if FButtonInstances[I].Instance.Visible then
      Inc(Count);
  end;
  if Count = 0 then Inc(Count);
  if Orientation = TOrientation.orHorizontal then
  begin
    W := Max(W, Count * MinBtnSize.X);
    H := Max(H, MinBtnSize.Y);
    if Align = alNone then W := (W div Count) * Count;
  end
  else
  begin
    W := Max(W, MinBtnSize.X);
    H := Max(H, Count * MinBtnSize.Y);
    if Align = alNone then H := (H div Count) * Count;
  end;
end;

procedure TBaseNavigator.SetSize(var W: Integer; var H: Integer);
var
  Count: Integer;
  I: TNavBtnID;
  Space, Temp, Remain: Integer;
  X, Y: Integer;
  LButton: TNavButton;
begin
  if (csLoading in ComponentState) then Exit;
  if FButtonInstances = nil then Exit;

  CalcMinSize(W, H);

  Count := 0;
  for I in FBtnIDs do
  begin
    if FButtonInstances[I].Instance = nil then
      Exit; // Not created yet
    if FButtonInstances[I].Instance.Visible then
      Inc(Count);
  end;
  if Count = 0 then Inc(Count);

  if Orientation = TOrientation.orHorizontal then
  begin
    ButtonWidth := W div Count;
    ButtonHeight := H;
    Temp := Count * ButtonWidth;
    if Align = alNone then W := Temp;
    Remain := W - Temp;
  end
  else
  begin
    ButtonWidth := W;
    ButtonHeight := H div Count;
    Temp := Count * ButtonHeight;
    if Align = alNone then H := Temp;
    Remain := H - Temp;
  end;

  X := 0;
  Y := 0;
  Temp := Count div 2;

  for I in FBtnIDs do
  begin
    LButton := FButtonInstances[I].Instance;
    if LButton.Visible then
    begin
      Space := 0;
      if Remain <> 0 then
      begin
        Dec(Temp, Remain);
        if Temp < 0 then
        begin
          Inc(Temp, Count);
          Space := 1;
        end;
      end;
      if Orientation = TOrientation.orHorizontal then
      begin
        LButton.SetBounds(X, Y, ButtonWidth + Space, Height);
        Inc(X, ButtonWidth + Space);
      end
      else
      begin
        LButton.SetBounds(X, Y, ButtonWidth, ButtonHeight + Space);
        Inc(Y, ButtonHeight + Space);
      end;
    end
    else
      if Orientation = TOrientation.orHorizontal then
        LButton.SetBounds(Width + 1, 0, ButtonWidth, Height)
      else
        LButton.SetBounds(0, Height + 1, ButtonWidth, ButtonHeight);
  end;
end;

procedure TBaseNavigator.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var
  W, H: Integer;
begin
  W := AWidth;
  H := AHeight;
  if not HandleAllocated then SetSize(W, H);
  inherited SetBounds (ALeft, ATop, W, H);
end;

procedure TBaseNavigator.WMSize(var Message: TWMSize);
var
  W, H: Integer;
begin
  inherited;
  W := Width;
  H := Height;
  SetSize(W, H);
end;

procedure TBaseNavigator.WMWindowPosChanging(var Message: TWMWindowPosChanging);
begin
  inherited;
  if (SWP_NOSIZE and Message.WindowPos.Flags) = 0 then
    CalcMinSize(Message.WindowPos.cx, Message.WindowPos.cy);
end;

procedure TBaseNavigator.ClickHandler(Sender: TObject);
begin
  BtnIDClick (TNavButton (Sender).Index);
end;

procedure TBaseNavigator.BtnMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  OldFocus: TNavBtnID;
begin
  OldFocus := FocusedButton;
  FocusedButton := TNavButton (Sender).Index;
  if TabStop and (GetFocus <> Handle) and CanFocus then
  begin
    SetFocus;
    if (GetFocus <> Handle) then
      Exit;
  end
  else if TabStop and (GetFocus = Handle) and (OldFocus <> FocusedButton) then
  begin
    FButtonInstances[OldFocus].Invalidate;
    FButtonInstances[FocusedButton].Invalidate;
  end;
end;


procedure TBaseNavigator.BtnIDClick(Index: TNavBtnID);
begin
 //
end;

procedure TBaseNavigator.WMSetFocus(var Message: TWMSetFocus);
begin
  FButtonInstances[FocusedButton].Invalidate;
end;

procedure TBaseNavigator.WMKillFocus(var Message: TWMKillFocus);
begin
  FButtonInstances[FocusedButton].Invalidate;
end;

procedure TBaseNavigator.KeyDown(var Key: Word; Shift: TShiftState);
var
  LDictionary: TDictionary<TNavBtnID, Integer>;
  LArray: TArray<TNavBtnID>;

  procedure CheckDictionary;
  var
    I: TNavBtnID;
    LOrdinal: Integer;
  begin
    if LDictionary = nil then
    begin
      LDictionary := TDictionary<TNavBtnID, Integer>.Create;
      LOrdinal := 0;
      for I in FBtnIDs do
      begin
        LDictionary.Add(I, LOrdinal);
        Inc(LOrdinal);
      end;
      LArray := LDictionary.Keys.ToArray;
    end;
  end;

  function HighNavButton: TNavBtnID;
  begin
    CheckDictionary;
    if Length(LArray) > 0 then
      Result := LArray[Length(LArray)-1]
    else
      Result := 0;
  end;

  function LowNavButton: TNavBtnID;
  begin
    if Length(LArray) > 0 then
      Result := LArray[0]
    else
      Result := 0;
  end;

  function NextNavButton(AButton: TNavBtnID): TNavBtnID;
  var
    LOrdinal: Integer;
  begin
    Result := 0;
    CheckDictionary;
    if AButton <> HighNavButton then
      if LDictionary.TryGetValue(AButton, LOrdinal) then
        Result := LArray[LOrdinal+1]
  end;

  function PrevNavButton(AButton: TNavBtnID): TNavBtnID;
  var
    LOrdinal: Integer;
  begin
    Result := 0;
    CheckDictionary;
    if AButton <> HighNavButton then
      if LDictionary.TryGetValue(AButton, LOrdinal) then
        Result := LArray[LOrdinal-1]
  end;

var
  NewFocus: TNavBtnID;
  OldFocus: TNavBtnID;
begin
  LDictionary := nil;
  try
    OldFocus := FocusedButton;
    case Key of
      VK_RIGHT:
        begin
          if OldFocus < HighNavButton then
          begin
            NewFocus := OldFocus;
            repeat
              NewFocus := NextNavButton(NewFocus);
            until (NewFocus = HighNavButton) or (FButtonInstances[NewFocus].Visible);
            if FButtonInstances[NewFocus].Visible then
            begin
              FocusedButton := NewFocus;
              FButtonInstances[OldFocus].Invalidate;
              FButtonInstances[NewFocus].Invalidate;
            end;
          end;
        end;
      VK_LEFT:
        begin
          NewFocus := FocusedButton;
          repeat
            if NewFocus > LowNavButton then
              NewFocus := PrevNavButton(NewFocus);
          until (NewFocus = LowNavButton) or (FButtonInstances[NewFocus].Visible);
          if NewFocus <> FocusedButton then
          begin
            FocusedButton := NewFocus;
            FButtonInstances[OldFocus].Invalidate;
            FButtonInstances[FocusedButton].Invalidate;
          end;
        end;
      VK_SPACE:
        begin
          if FButtonInstances[FocusedButton].Enabled then
            FButtonInstances[FocusedButton].Click;
        end;
    end;
  finally
    LDictionary.Free;
  end;
end;

procedure TBaseNavigator.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  Message.Result := DLGC_WANTARROWS;
end;


procedure TBaseNavigator.EnabledChanged;
var
  I: TNavBtnID;
begin
  for I in FBtnIDs do
    if FButtonInstances[I].Instance <> nil then
      FButtonInstances[I].Instance.Enabled := False
end;

procedure TBaseNavigator.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  if not (csLoading in ComponentState) then
    EnabledChanged;
end;

procedure TBaseNavigator.SetButtonGlyph(Index: TNavBtnID);
begin
  if FButtonInstances[Index].Description.GlyphResName <> '' then
  begin
    FButtonInstances[Index].Instance.Glyph.LoadFromResourceName(
      FButtonInstances[Index].Description.GlyphResInstance,
      FButtonInstances[Index].Description.GlyphResName);
    FButtonInstances[Index].Instance.NumGlyphs := 2;
  end;
end;

procedure TBaseNavigator.Loaded;
var
  W, H: Integer;
begin
  inherited Loaded;
  W := Width;
  H := Height;
  SetSize(W, H);
  if (W <> Width) or (H <> Height) then
    inherited SetBounds (Left, Top, W, H);
  EnabledChanged;
end;

{TNavButton}

destructor TNavButton.Destroy;
begin
  if FRepeatTimer <> nil then
    FRepeatTimer.Free;
  inherited Destroy;
end;

procedure TNavButton.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited MouseDown (Button, Shift, X, Y);
  if nsAllowTimer in FNavStyle then
  begin
    if FRepeatTimer = nil then
      FRepeatTimer := TTimer.Create(Self);

    FRepeatTimer.OnTimer := TimerExpired;
    FRepeatTimer.Interval := InitRepeatPause;
    FRepeatTimer.Enabled  := True;
  end;
end;

procedure TNavButton.MouseUp(Button: TMouseButton; Shift: TShiftState;
                                  X, Y: Integer);
begin
  inherited MouseUp (Button, Shift, X, Y);
  if FRepeatTimer <> nil then
    FRepeatTimer.Enabled  := False;
end;

procedure TNavButton.TimerExpired(Sender: TObject);
begin
  FRepeatTimer.Interval := RepeatPause;
  if (FState = bsDown) and MouseCapture then
  begin
    try
      Click;
    except
      FRepeatTimer.Enabled := False;
      raise;
    end;
  end;
end;

procedure TNavButton.Paint;
var
  R: TRect;
  LButton: TThemedDataNavButtons;
begin
  inherited Paint;

  if StyleServices.Enabled and not StyleServices.IsSystemStyle then
  begin
    if not Enabled then
      LButton := ThemeDisabled
    else if FState in [bsDown, bsExclusive] then
      LButton := ThemePressed
    else if MouseInControl then
      LButton := ThemeHot
    else
      LButton := ThemeNormal;

    R := Bounds(0, 0, Width, Height);
    StyleServices.DrawElement(Canvas.Handle, StyleServices.GetElementDetails(LButton), R);
  end;

  if (GetFocus = Parent.Handle) and
     (FIndex = TBaseNavigator(Parent).FocusedButton) then
  begin
    R := Bounds(0, 0, Width, Height);
    InflateRect(R, -3, -3);
    if FState = bsDown then
      OffsetRect(R, 1, 1);
    Canvas.Brush.Style := bsSolid;
    Font.Color := clBtnShadow;
    DrawFocusRect(Canvas.Handle, R);
  end;
end;

{ TBaseNavigator.TNavButtonRecord }

procedure TBaseNavigator.TButtonInstance.Click;
begin
  Assert(Instance <> nil);
  Instance.Click;
end;

function TBaseNavigator.TButtonInstance.Enabled: Boolean;
begin
  Assert(Instance <> nil);
  Result := Instance.Enabled
end;

procedure TBaseNavigator.TButtonInstance.Invalidate;
begin
  Assert(Instance <> nil);
  Instance.Invalidate;
end;

function TBaseNavigator.TButtonInstance.Visible: Boolean;
begin
  Assert(Instance <> nil);
  Result := Instance.Visible
end;

{$IF NOT DEFINED(CLR)}
initialization
  FillChar(BitBtnGlyphs, SizeOf(BitBtnGlyphs), 0);
finalization
  DestroyLocals;
{$ENDIF}
end.

