unit fcButton;
{
//
// Components : TfcButton
//
// Copyright (c) 1999 by Woll2Woll Software
//
// Changes:
// RSW - 3/9/99 - Process default button when carriage return or Cancel entered
// 6/6/99 - Respect windows smooth font settings when painting text of buttons
// 6/8/99 - Improved support for painting flat style if dialog is shown in button's OnClick
// 7/13/99 - PYW - Changed to always process mouse up in fcoutlookbar
// 7/26/99 - Call click on space key
// 7/26/99 - setfocus when mouse clicked on button if focusable is true
}
interface

{$i fcIfDef.pas}

uses Windows, Messages, Classes, Controls, Forms, Graphics, StdCtrls,
  CommCtrl, Buttons, Dialogs, Math, Consts, SysUtils, fccommon, fcBitmap, fcChangeLink,
  TypInfo,
  {$ifdef fcDelphi4Up}
  ImgList, ActnList,
  {$endif}
  fcText;

const DESIGN_KEY = VK_MENU;

type
  TfcShadeStyle = (fbsNormal, fbsRaised, fbsHighlight, fbsFlat);

  TfcButtonOption = (boFocusable, boOverrideActionGlyph, boToggleOnUp,
    boFocusRect, boAutoBold);
  TfcButtonOptions = set of TfcButtonOption;

  TfcCustomBitBtn = class;
  TfcCustomBitBtnClass = class of TfcCustomBitBtn;

  TfcRegionData = record
    dwSize: Integer;
    rgnData: PRgnData;
  end;
  PfcRegionData = ^TfcRegionData;

  TfcOffsets =  class(TPersistent)
  private
    // Property Storage Variables
    FControl: TWinControl;
    FGlyphX: Integer;
    FGlyphY: Integer;
    FTextX: Integer;
    FTextY: Integer;
    FTextDownX: Integer;
    FTextDownY: Integer;
    procedure SetGlyphX(Value: Integer);
    procedure SetGlyphY(Value: Integer);
    procedure SetTextX(Value: Integer);
    procedure SetTextY(Value: Integer);
  protected
    procedure AssignTo(Dest: TPersistent); override;
    property Control: TWinControl read FControl;
  public
    constructor Create(Button: TfcCustomBitBtn);
  published
    property GlyphX: Integer read FGlyphX write SetGlyphX default 0;
    property GlyphY: Integer read FGlyphY write SetGlyphY default 0;
    property TextX: Integer read FTextX write SetTextX default 0;
    property TextY: Integer read FTextY write SetTextY default 0;
    property TextDownX: Integer read FTextDownX write FTextDownX default 1;
    property TextDownY: Integer read FTextDownY write FTextDownY default 1;
  end;

  TfcShadeColors = class(TPersistent)
  private
    FButton: TfcCustomBitBtn;
    FBtnHighlight: TColor;
    FBtn3dLight: TColor;
    FBtnShadow: TColor;
    FBtnBlack: TColor;
    FBtnFocus: TColor;
    FShadow: TColor;
    procedure SetBtn3DLight(Value: TColor);
    procedure SetBtnBlack(Value: TColor);
    procedure SetBtnHighlight(Value: TColor);
    procedure SetBtnShadow(Value: TColor);
    procedure SetBtnFocus(Value: TColor);
    procedure SetShadow(Value: TColor);
  protected
    procedure AssignTo(Dest: TPersistent); override;
  public
    constructor Create(Button: TfcCustomBitBtn);
  published
    property Btn3DLight: TColor read FBtn3DLight write SetBtn3DLight default cl3DLight;
    property BtnHighlight: TColor read FBtnHighlight write SetBtnHighlight default clBtnHighlight;
    property BtnShadow: TColor read FBtnShadow write SetBtnShadow default clBtnShadow;
    property BtnBlack: TColor read FBtnBlack write SetBtnBlack default clBlack;
    property BtnFocus: TColor read FBtnFocus write SetBtnFocus default clBlack;
    property Shadow: TColor read FShadow write SetShadow default clBlack;
  end;

  TfcCustomBitBtn = class(TWinControl)
  private
    // Property Storage Variables
    FActive: Boolean;
    FAllowAllUp: Boolean;
    FCancel: Boolean;
    FDefault: Boolean;
    FDown: Boolean;
    FGlyph: TBitmap;
    FGroupIndex: Integer;
    FKind: TBitBtnKind;
    FLayout: TButtonLayout;
    FMargin: Integer;
    FModalResult: TModalResult;
    FNumGlyphs: TNumGlyphs;
    FRegion, FLastRegion: HRgn;
    FShadeColors: TfcShadeColors;
    FShadeStyle: TfcShadeStyle;  // Published
    FShowFocusRect: Boolean;
    FSpacing: Integer;
    FStyle: TButtonStyle;
    FTextOptions: TfcCaptionText;
    {$ifdef fcDelphi4Up}
    FSmoothFont: boolean;
    {$endif}

    FGlyphRect: TRect;
    FTextRect: TRect;

    FOnMouseEnter: TNotifyEvent;
    FOnMouseLeave: TNotifyEvent;
    FOnSelChange: TNotifyEvent;
    FOnSetName: TNotifyEvent;

    FCanvas: TCanvas;
    FOffsets: TfcOffsets;
    FModifiedGlyph: Boolean;
    FOptions: TfcButtonOptions;
    FChangeLinks: TList;
    FChangeLink: TfcChangeLink;
    FClicked: Boolean;
    FInitialDown: Boolean;
    FEvents: TStringList;

    // Property Access Methods
    function GetKind: TBitBtnKind;
    procedure SetAllowAllUp(Value: Boolean);
    procedure SetButtonDown(Value: Boolean; CheckAllowAllUp: Boolean; DoUpdateExclusive: Boolean; DoInvalidate: Boolean);
    procedure SetDefault(Value: Boolean);
    procedure SetDown(Value: Boolean);
    procedure SetGlyph(Value: TBitmap);
    procedure SetGroupIndex(Value: Integer);
    procedure SetKind(Value: TBitBtnKind);
    procedure SetLayout(Value: TButtonLayout);
    procedure SetMargin(Value: Integer);
    procedure SetNumGlyphs(Value: TNumGlyphs);
    procedure SetOptions(Value: TfcButtonOptions);
    procedure SetSpacing(Value: Integer);
    procedure SetShadeStyle(Value: TfcShadeStyle);
    procedure SetStyle(Value: TButtonStyle);

    // Message Handlers
    procedure WMCancelMode(var Message: TWMCancelMode); message WM_CANCELMODE;
    procedure CMDialogKey(var Message: TCMDialogKey); message CM_DIALOGKEY;
    procedure CMButtonPressed(var Message: TMessage); message CM_BUTTONPRESSED;
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMFocusChanged(var Message: TCMFocusChanged); message CM_FOCUSCHANGED;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CNDrawItem(var Message: TWMDrawItem); message CN_DRAWITEM;
    procedure CNMeasureItem(var Message: TWMMeasureItem); message CN_MEASUREITEM;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMMouseActivate(var Message: TWMMouseActivate); message WM_MOUSEACTIVATE;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure ProcessMouseUp(X, Y: Integer; AMouseInControl: Boolean; AClicked: Boolean);
    procedure ProcessMouseDown;
  protected
    FDownRegionData: TfcRegionData;
    FRegionData: TfcRegionData;
    FSelected: Boolean;
    DisableButton: boolean;

    // Overriden Methods
    function GetPalette: HPALETTE; override;
    {$ifdef fcDelphi4Up}
    procedure ActionChange(Sender: TObject; CheckDefaults: Boolean); override;
    {$endif}
    procedure AssignTo(Dest: TPersistent); override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure DestroyWnd; override;
    procedure DefineProperties(Filer: TFiler); override;
    procedure Loaded; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure SetName(const Value: TComponentName); override;

    // Virtual Methods
    procedure GetEvents(const s: string);
    function CreateOffsets: TfcOffsets; virtual;
    function CreateRegion(DoImplementation: Boolean; Down: Boolean): HRgn; virtual;
    function CalcButtonLayout(Canvas: TCanvas; Client: TRect; var TextRect: TRect;
      var GlyphRect: TRect; TextSize: TSize): TRect; virtual;
    function GlyphWidth: Integer; virtual;
    function IsCustom: Boolean; virtual;
    function IsCustomCaption: Boolean; virtual;
    function MouseInControl(X, Y: Integer; AndClicked: Boolean): Boolean;
    function StoreRegionData: Boolean; virtual;
    procedure ChangeButtonDown; virtual;
    procedure CleanUp; virtual;
    procedure ClearRegion(ARgnData: PfcRegionData); virtual;
    procedure DrawButtonGlyph(Canvas: TCanvas; const GlyphPos: TPoint); virtual;
    procedure DrawButtonText(Canvas: TCanvas; TextBounds: TRect); virtual;
    procedure DrawItem(const DrawItemStruct: TDrawItemStruct); virtual;
    procedure GetDrawBitmap(DrawBitmap: TfcBitmap; ForRegion: Boolean;
      ShadeStyle: TfcShadeStyle; Down: Boolean); virtual;
    procedure GlyphChanged(Sender: TObject); virtual;
    procedure NotifyChange; virtual;
    procedure NotifyChanging; virtual;
    procedure NotifyLoaded; virtual;
    procedure Paint; virtual;
    procedure Redraw; virtual;
    procedure ReadRegionData(Stream: TStream); virtual;
    procedure ReadDownRegionData(Stream: TStream); virtual;
    procedure SaveRegion(NewRegion: HRGN; Down: Boolean); virtual;
    procedure SelChange; virtual;
//    procedure WriteState(Writer: TWriter); override;
    procedure WndProc(var Message: TMessage); override;
    procedure WriteRegionData(Stream: TStream); virtual;
    procedure WriteDownRegionData(Stream: TStream); virtual;
    procedure UpdateExclusive; virtual;
    function UseRegions: boolean; virtual;

    // Protected Properties
    property Active: Boolean read FActive;
    property Canvas: TCanvas read FCanvas;
    property GlyphRect: TRect read FGlyphRect;
    property TextRect: TRect read FTextRect;
  public
    BasePatch: Variant;
    property Region: HRGN read FRegion;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    // Virtual Methods
    procedure ApplyRegion; virtual;
    procedure InvalidateNotRegion(const Erase: Boolean); virtual;

    function Draw(Canvas: TCanvas): TRect; virtual;
    function IsMultipleRegions: Boolean; virtual;
    procedure Click; override;
    procedure SizeToDefault; virtual;
    procedure UpdateShadeColors(Color: TColor); virtual;

    procedure RegisterChanges(Value: TfcChangeLink); virtual;
    procedure UnRegisterChanges(Value: TfcChangeLink); virtual;

    function GetTextEnabled: Boolean; virtual;
    procedure AdjustBounds; virtual;

    // Public Properties
    property AllowAllUp: Boolean read FAllowAllUp write SetAllowAllUp default False;
    property Cancel: Boolean read FCancel write FCancel default False;
    property Caption stored IsCustomCaption;
    property Color;
    property Default: Boolean read FDefault write SetDefault default False;
    property Down: Boolean read FDown write SetDown default False;
    property Font;
    property Offsets: TfcOffsets read FOffsets write FOffsets;
    property Glyph: TBitmap read FGlyph write SetGlyph stored IsCustom;
    property GroupIndex: Integer read FGroupIndex write SetGroupIndex default 0;
    property Kind: TBitBtnKind read GetKind write SetKind default bkCustom;
    property Layout: TButtonLayout read FLayout write SetLayout default blGlyphLeft;
    property Margin: Integer read FMargin write SetMargin default -1;
    property ModalResult: TModalResult read FModalResult write FModalResult default 0;
    property NumGlyphs: TNumGlyphs read FNumGlyphs write SetNumGlyphs stored IsCustom default 1;
    property Options: TfcButtonOptions read FOptions write SetOptions default [];
    property Selected: Boolean read FSelected;
    property ShadeColors: TfcShadeColors read FShadeColors write FShadeColors;
    property ShadeStyle: TfcShadeStyle read FShadeStyle write SetShadeStyle;
    {$ifdef fcDelphi4Up}
    property SmoothFont: boolean read FSmoothFont write FSmoothFont default false;
    {$endif}
    property Style: TButtonStyle read FStyle write SetStyle default bsAutoDetect;
    property Spacing: Integer read FSpacing write SetSpacing default 4;
    property TabStop default False;
    property TextOptions: TfcCaptionText read FTextOptions write FTextOptions;
    property OnClick;
    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave;
    property OnSelChange: TNotifyEvent read FOnSelChange write FOnSelChange;
    property OnSetName: TNotifyEvent read FOnSetName write FOnSetName;
  end;

implementation

{$IfDef fcDelphi6Up}
uses
  Variants
  ;
{$EndIf fcDelphi6Up}

{$r fcButtns.RES}

const
  BITBTNMODALRESULTS: array[TBitBtnKind] of TModalResult = (
    0, mrOk, mrCancel, 0, mrYes, mrNo, 0, mrAbort, mrRetry, mrIgnore,
    mrAll);

var
  BitBtnResNames: array[TBitBtnKind] of PChar = (
    nil, 'WWOK', 'WWCANCEL', 'WWHELP', 'WWYES', 'WWNO', 'WWCLOSE',
    'WWABORT', 'WWRETRY', 'WWIGNORE', 'WWALL');
  BitBtnCaptions: array[TBitBtnKind] of Pointer = (nil, nil, nil,
    nil, nil, nil, nil, nil, nil, nil, nil);
  BitBtnGlyphs: array[TBitBtnKind] of TBitmap;

procedure GetBitBtnGlyph(Kind: TBitBtnKind; Bitmap: TBitmap);
begin
  if BitBtnGlyphs[Kind] = nil then
  begin
    BitBtnGlyphs[Kind] := TBitmap.Create;
    BitBtnGlyphs[Kind].LoadFromResourceName(HInstance, BitBtnResNames[Kind]);
  end;
  Bitmap.Assign(BitBtnGlyphs[Kind]);
end;

// TfcDownOffsets

constructor TfcOffsets.Create(Button: TfcCustomBitBtn);
begin
  inherited Create;
  FControl := Button;
  FTextDownX := 1;
  FTextDownY := 1;
end;

procedure TfcOffsets.AssignTo(Dest: TPersistent);
begin
  if Dest is TfcOffsets then
    with Dest as TfcOffsets do
  begin
    GlyphX := self.GlyphX;
    GlyphY := self.GlyphY;
    TextX := self.TextX;
    TextY := self.TextY;
    TextDownX := self.TextDownX;
    TextDownY := self.TextDownY;
  end else inherited;
end;

procedure TfcOffsets.SetGlyphX(Value: Integer);
begin
  if FGlyphX <> Value then
  begin
    FGlyphX := Value;
    Control.Invalidate;
  end;
end;

procedure TfcOffsets.SetGlyphY(Value: Integer);
begin
  if FGlyphY <> Value then
  begin
    FGlyphY := Value;
    Control.Invalidate;
  end;
end;

procedure TfcOffsets.SetTextX(Value: Integer);
begin
  if FTextX <> Value then
  begin
    FTextX := Value;
    Control.Invalidate;
  end;
end;

procedure TfcOffsets.SetTextY(Value: Integer);
begin
  if FTextY <> Value then
  begin
    FTextY := Value;
    Control.Invalidate;
  end;
end;

// TfcShadeColors

constructor TfcShadeColors.Create(Button: TfcCustomBitBtn);
begin
  inherited Create;
  FButton := Button;

  FBtnHighlight := clBtnHighlight;
  FBtn3DLight := cl3DLight;
  FBtnShadow := clBtnShadow;
end;

procedure TfcShadeColors.AssignTo(Dest: TPersistent);
begin
  if Dest is TfcShadeColors then
    with Dest as TfcShadeColors do
  begin
    Btn3dLight := self.Btn3dLight;
    BtnHighlight := self.BtnHighlight;
    BtnShadow := self.BtnShadow;
    BtnBlack := self.BtnBlack;
    BtnFocus := self.BtnFocus;
    Shadow := self.Shadow;
  end else inherited;
end;

procedure TfcShadeColors.SetBtn3DLight(Value: TColor);
begin
  if Value <> FBtn3DLight then
  begin
    FBtn3DLight := Value;
    FButton.Invalidate;
  end;
end;

procedure TfcShadeColors.SetBtnBlack(Value: TColor);
begin
  if FBtnBlack <> Value then
  begin
    FBtnBlack := Value;
    FButton.Invalidate;
  end;
end;

procedure TfcShadeColors.SetBtnHighlight(Value: TColor);
begin
  if Value <> FBtnHighlight then
  begin
    FBtnHighlight := Value;
    FButton.Invalidate;
  end;
end;

procedure TfcShadeColors.SetBtnShadow(Value: TColor);
begin
  if Value <> FBtnShadow then
  begin
    FBtnShadow := Value;
    FButton.Invalidate;
  end;
end;

procedure TfcShadeColors.SetBtnFocus(Value: TColor);
begin
  if Value <> FBtnFocus then
  begin
    FBtnFocus := Value;
    FButton.Invalidate;
  end;
end;

procedure TfcShadeColors.SetShadow(Value: TColor);
begin
  if FShadow <> Value then
  begin
    FShadow := Value;
    FButton.Invalidate;
  end;
end;

// TfcCustomBitBtn

function TfcCustomBitBtn.GetTextEnabled: Boolean;
begin
  result := Enabled;
end;

procedure TfcCustomBitBtn.AdjustBounds;
begin
end;

constructor TfcCustomBitBtn.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := [csSetCaption, csOpaque, csReflector];

  FCanvas := TCanvas.Create;
  FChangeLinks := TList.Create;
  Color := clBtnFace;
  FChangeLink := TfcChangeLink.Create;
  FGlyph := TBitmap.Create;
  FGlyph.OnChange := GlyphChanged;
  Height := 25;
  FKind := bkCustom;
  FLayout := blGlyphLeft;
  FMargin := -1;
  FOffsets := CreateOffsets;
  FShadeColors := TfcShadeColors.Create(self);
  FShowFocusRect := True;
  FSpacing := 4;
  FShadeStyle := fbsNormal;
  FStyle := bsAutoDetect;
  TabStop := True;
  FTextOptions := TfcCaptionText.Create(MakeCallbacks(Invalidate, AdjustBounds, GetTextEnabled),
    FCanvas, Font);
  FTextOptions.Alignment := taCenter;
  FTextOptions.VAlignment := vaVCenter;
  FEvents := TStringList.Create;
  Width := 75;

  BasePatch:= VarArrayCreate([0, 0], varVariant);
  BasePatch[0]:= False; { 6/8/99 - Internal use to support painting issues with flat buttons }
end;

destructor TfcCustomBitBtn.Destroy;
begin
  CleanUp;
  if FRegionData.rgnData <> nil then FreeMem(FRegionData.rgnData);
  if FDownRegionData.rgnData <> nil then FreeMem(FDownRegionData.rgnData);
  FCanvas.Free;
  FChangeLinks.Free;
  FChangeLinks:= nil;
  FChangeLink.Free;
  FGlyph.Free;
  FOffsets.Free;
  FShadeColors.Free;
  FTextOptions.Free;
  FEvents.Free;
  inherited Destroy;
end;

procedure TfcCustomBitBtn.CleanUp;
begin
  if FRegion <> 0 then
  begin
    if not (csDestroying in ComponentState) and HandleAllocated then SetWindowRgn(Handle, 0, False);
    DeleteObject(FRegion);
    DeleteObject(FLastRegion);
    FRegion := 0;
    FLastRegion := 0;
  end;
end;

//{$ifdef fcDelphi4Up}
//type TFormDesigner = IFormDesigner;
//{$endif}

procedure TfcCustomBitBtn.WndProc(var Message: TMessage);
var
//    Selections: TComponentList;
//    SelPosition: Integer;
    ButtonGroup: TWinControl;
{  function IsSelected: Boolean;
  var CompList: TComponentList;
      i: Integer;
  begin
    CompList := TComponentList.Create;
    TFormDesigner(GetParentForm(ButtonGroup).Designer).GetSelections(CompList);
    result := False;
    for i := 0 to CompList.Count - 1 do if Selections[i] = self then
      result := True;
    CompList.Free;
  end;
  function InList: Integer;
  var i: Integer;
  begin
    for i := 0 to Selections.Count - 1 do if Selections[i] = ButtonGroup then
    begin
      result := i;
      Exit;
    end;
    result := -1;
  end;
  procedure RemoveButtonGroup;
  var NewSelections: TComponentList;
      i: Integer;
  begin
    NewSelections := TComponentList.Create;
    for i := 0 to Selections.Count - 1 do
      if i <> SelPosition then NewSelections.Add(Selections[i]);
    Selections.Free;
    Selections := NewSelections;
  end;}
begin
  if (csDesigning in ComponentState) and (Parent <> nil) and fcIsClass(Parent.ClassType, 'TfcCustomButtonGroup') then
  begin
    ButtonGroup := Parent;
    case Message.Msg of
      // If the user right-clicks on the control then
      // this code will select the buttonGroup (instead of
      // having this button be selected) and then pass the
      // message along to the ButtonGroup.
      WM_RBUTTONDOWN: begin
        ButtonGroup.Perform(WM_LBUTTONDOWN, Message.wParam, MakeLParam(LoWord(Message.lParam) + Left, HiWord(Message.lParam) + Top));
        ButtonGroup.Dispatch(Message);
      end;

{      WM_RBUTTONDOWN: begin
        TFormDesigner(GetParentForm(ButtonGroup).Designer).SelectComponent(ButtonGroup);
        ButtonGroup.Dispatch(Message);
      end;
}
      WM_LBUTTONDOWN: begin
        if (GetKeyState(DESIGN_KEY) < 0) then
          inherited
        else begin
            ButtonGroup.Dispatch(Message);
            ButtonGroup.Perform(Message.Msg, Message.wParam, MakeLParam(LoWord(Message.lParam) + Left, HiWord(Message.lParam) + Top));
            { 2/21/99 -ksw - LockedWindow fix }
            if GetCapture = ButtonGroup.Handle then ReleaseCapture;
        end
      end;

      // Prevent the default ComponentEditor to occur if
      // the space key isn't pressed down. -ksw (6/24/98)
      WM_LBUTTONDBLCLK:
        if (GetKeyState(DESIGN_KEY) < 0) then
          inherited
        else begin
          // This line is a tweak that prevents an annoyance
          // in which after double-clicking on the Navigator,
          // clicking again would move attempt to move it, event
          // if you weren't clicking in the navigator.  -ksw (6/24/98)
          ButtonGroup.Perform(WM_LBUTTONDOWN, Message.wParam, MakeLParam(LoWord(Message.lParam) + Left, HiWord(Message.lParam) + Top));

          // These other two lines need to go together.  If the second line is called
          // without the call to the first, Delphi will exit out rather
          // ungracefully.  If the first one is called without the call to the
          // second one, the double-click isn't processed by Delphi.
          ButtonGroup.Dispatch(Message);
          ButtonGroup.Perform(Message.Msg, Message.wParam, Message.lParam);
        end;
      else inherited;
    end;
  end else inherited;
end;

procedure TfcCustomBitBtn.AssignTo(Dest: TPersistent);
begin
  if Dest is TfcCustomBitBtn then
    with Dest as TfcCustomBitBtn do
  begin
    Color := self.Color;
    Offsets.Assign(self.Offsets);
//    Glyph := self.Glyph;
    Layout := self.Layout;
    Margin := self.Margin;
    NumGlyphs := self.NumGlyphs;
    Options := self.Options;
    ShadeColors.Assign(self.ShadeColors);
    Spacing := self.Spacing;
    TabStop := self.TabStop;
    TextOptions.Assign(self.TextOptions);
  end else inherited;
end;

procedure TfcCustomBitBtn.CreateParams(var Params: TCreateParams);
const
  ButtonStyles: array[Boolean] of UINT = (BS_PUSHBUTTON, BS_DEFPUSHBUTTON);
begin
  inherited CreateParams(Params);

  CreateSubClass(Params, 'BUTTON');
//  Params.Style := Params.Style or ButtonStyles[FDefault];

  with Params do Style := Style or BS_OWNERDRAW;
end;

procedure TfcCustomBitBtn.Createwnd;
begin
  inherited;
  FActive := FDefault;
  ApplyRegion;
end;

procedure TfcCustomBitBtn.DestroyWnd;
begin
  CleanUp;
  inherited;
end;

procedure TfcCustomBitBtn.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineBinaryProperty('RegionData', ReadRegionData, WriteRegionData, StoreRegionData);
  Filer.DefineBinaryProperty('DownRegionData', ReadDownRegionData, WriteDownRegionData, StoreRegionData);
end;

function TfcCustomBitBtn.GetPalette: HPALETTE;
begin
  result := Glyph.Palette;
end;

function TfcCustomBitBtn.CreateOffsets: TfcOffsets;
begin
  result := TfcOffsets.Create(self);
end;

function TfcCustomBitBtn.Draw(Canvas: TCanvas): TRect;
var
  TextSize: TSize;
  r: TRect;
begin
  result := ClientRect;
  InflateRect(result, -2, -2);

  TextOptions.Canvas := Canvas;
  TextOptions.Text := Caption;
  TextOptions.TextRect := result;

  with TextOptions.CalcDrawRect(True) do
    TextSize := fcSize(Right - Left, Bottom - Top);
  CalcButtonLayout(Canvas, result, FTextRect, FGlyphRect, TextSize);
  with FTextRect do FTextRect := Rect(
    fcMax(0, Left), fcMax(0, Top), fcMin(ClientWidth, Right), fcMin(ClientHeight, Bottom));

  if not Glyph.Empty then DrawButtonGlyph(Canvas, FGlyphRect.TopLeft);
  DrawButtonText(Canvas, FTextRect);

  if (boFocusRect in Options) and (boFocusable in Options) and Focused then
  begin
    UnionRect(r, TextRect, GlyphRect);
    InflateRect(r, 2, 2);
    Canvas.Brush.Color := clWhite;
    Canvas.Font.Color := clBlack;
    Canvas.DrawFocusRect(r);
  end;
end;

function TfcCustomBitBtn.CalcButtonLayout(Canvas: TCanvas; Client: TRect;
  var TextRect: TRect; var GlyphRect: TRect; TextSize: TSize): TRect;
var GlyphSize: TSize;
    TopLeft: TPoint;
    Spacing: Integer;
    EffectiveMargin: Integer;
begin
  InflateRect(Client, -Margin, -Margin);
  if Margin = -1 then EffectiveMargin := 4 else EffectiveMargin := Margin;
  SetRectEmpty(GlyphRect);
  GlyphSize := fcSize(0, 0);
  if not Glyph.Empty then GlyphSize := fcSize(GlyphWidth, Glyph.Height);
  Spacing := 0;
  if (Caption <> '') and (not Glyph.Empty) then Spacing := self.Spacing;
  case TextOptions.Alignment of
    taLeftJustify: TopLeft := Point(EffectiveMargin + (TextSize.cx + GlyphSize.cx + Spacing) div 2, Height div 2);
    taRightJustify: TopLeft := Point(-EffectiveMargin + Width - (TextSize.cx + GlyphSize.cx + Spacing) div 2, Height div 2);
    taCenter: TopLeft := Point(Width div 2, Height div 2);
  end;

  fcCalcButtonLayout(TopLeft, @TextRect, @GlyphRect, TextSize, GlyphSize, Layout, Spacing);

  OffsetRect(TextRect, Offsets.TextX, Offsets.TextY);
  OffsetRect(GlyphRect, Offsets.GlyphX, Offsets.GlyphY);

  // Offset if down
  if Down then
  begin
    OffsetRect(TextRect, Offsets.TextDownX, Offsets.TextDownY);
    OffsetRect(GlyphRect, Offsets.TextDownX, Offsets.TextDownY);
  end;
  result := Client;
end;

procedure TfcCustomBitBtn.ReadRegionData(Stream: TStream);
begin
  Stream.ReadBuffer(FRegionData.dwSize, SizeOf(FRegionData.dwSize));
  if FRegionData.dwSize <> 0 then
  begin
    GetMem(FRegionData.rgnData, FRegionData.dwSize);
    Stream.ReadBuffer(FRegionData.rgnData^, FRegionData.dwSize);
  end;
end;

procedure TfcCustomBitBtn.ReadDownRegionData(Stream: TStream);
begin
  Stream.ReadBuffer(FDownRegionData.dwSize, SizeOf(FDownRegionData.dwSize));
  if FDownRegionData.dwSize <> 0 then
  begin
    GetMem(FDownRegionData.rgnData, FDownRegionData.dwSize);
    Stream.ReadBuffer(FDownRegionData.rgnData^, FDownRegionData.dwSize);
  end;
end;

procedure TfcCustomBitBtn.WriteRegionData(Stream: TStream);
begin
  if FRegionData.rgnData <> nil then
  begin
    Stream.WriteBuffer(FRegionData.dwSize, SizeOf(FRegionData.dwSize));
    Stream.WriteBuffer(FRegionData.rgnData^, FRegionData.dwSize);
  end else begin
    FRegionData.dwSize := 0;
    Stream.WriteBuffer(FRegionData.dwSize, SizeOf(FRegionData.dwSize));
  end;
end;

procedure TfcCustomBitBtn.WriteDownRegionData(Stream: TStream);
begin
  if FDownRegionData.rgnData <> nil then
  begin
    Stream.WriteBuffer(FDownRegionData.dwSize, SizeOf(FDownRegionData.dwSize));
    Stream.WriteBuffer(FDownRegionData.rgnData^, FDownRegionData.dwSize);
  end else begin
    FDownRegionData.dwSize := 0;
    Stream.WriteBuffer(FDownRegionData.dwSize, SizeOf(FDownRegionData.dwSize));
  end;
end;

procedure TfcCustomBitBtn.ApplyRegion;
var CurParent: TWinControl;
begin
  if not HandleAllocated then Exit;
  if not UseRegions then exit;

  SetWindowRgn(Handle, 0, False);
  if FRegion <> 0 then DeleteObject(FRegion);
  FRegion := CreateRegion(True, Down);

  if (FLastRegion <> 0) and (FRegion <> 0) and IsMultipleRegions then
  begin
    CombineRgn(FLastRegion, FLastRegion, FRegion, RGN_XOR);

    CurParent := self;
    while (CurParent <> GetParentForm(self)) and (CurParent <> nil) do
    begin
      OffsetRgn(FLastRegion, CurParent.Left, CurParent.Top);
      InvalidateRgn(CurParent.Parent.Handle, FLastRegion, True);
      CurParent := CurParent.Parent;
    end;
  end;

  if IsMultipleRegions then
  begin
    if FLastRegion <> 0 then DeleteObject(FLastRegion);
    FLastRegion := CreateRectRgn(0, 0, 10, 10);
    CombineRgn(FLastRegion, FRegion, 0, RGN_COPY);
  end;

  SetWindowRgn(Handle, FRegion, False);
  if IsMultipleRegions and (Parent <> nil) then fcInvalidateOverlappedWindows(Parent.Handle, Handle);
end;

procedure TfcCustomBitBtn.ChangeButtonDown;
begin
  if IsMultipleRegions then ApplyRegion;
end;

procedure TfcCustomBitBtn.GetEvents(const s: string);
begin
  FEvents.Add(s);
end;
{
procedure TfcCustomBitBtn.WriteState(Writer: TWriter);
var
    FormDesigner: IFormDesigner;
    s: string;
begin
  if (csDesigning in ComponentState) and (GetParentForm(self) <> nil) and not (Owner is TCustomForm) then
  begin
    FormDesigner := IFormDesigner(GetParentForm(self).Designer);
    FEvents.Clear;
    FormDesigner.GetMethods(GetTypeData(TypeInfo(TNotifyEvent)), GetEvents);
    s := FormDesigner.GetMethodName(TMethod(OnClick));
    if FEvents.IndexOf(s) = -1 then OnClick := nil;
  end;
  inherited;
end;
}
procedure TfcCustomBitBtn.SelChange;
begin
  FSelected := Down;
  if Assigned(FOnSelChange) then FOnSelChange(self);
  NotifyChange;
end;

procedure TfcCustomBitBtn.SaveRegion(NewRegion: HRGN; Down: Boolean);
var ARgnData: ^TfcRegionData;
begin
  if not Down then ARgnData := @FRegionData else ARgnData := @FDownRegionData;
  if ARgnData^.rgnData <> nil then FreeMem(ARgnData^.rgnData);
  ARgnData^.rgnData := nil;
  ARgnData^.dwSize := GetRegionData(NewRegion, 0, nil);
  GetMem(ARgnData^.rgnData, ARgnData^.dwSize);
  GetRegionData(NewRegion, ARgnData^.dwSize, ARgnData^.rgnData);
end;

function TfcCustomBitBtn.CreateRegion(DoImplementation: Boolean; Down: Boolean): HRgn;
var ARgnData: PRgnData;
begin
  if (not Down and (FRegionData.rgnData <> nil)) or (Down and (FDownRegionData.rgnData <> nil)) then
  begin
    if Down then ARgnData := FDownRegionData.rgnData else ARgnData := FRegionData.rgnData;
    result := ExtCreateRegion(nil, ARgnData.rdh.dwSize + ARgnData.rdh.nRgnSize, ARgnData^);
  end else result := 0;
end;

procedure TfcCustomBitBtn.ClearRegion(ARgnData: PfcRegionData);
begin
  if ARgnData^.rgnData <> nil then
  begin
    FreeMem(ARgnData^.rgnData);
    ARgnData^.rgnData := nil;
  end;
end;

procedure TfcCustomBitBtn.DrawButtonGlyph(Canvas: TCanvas; const GlyphPos: TPoint);
var
  ImageList: TImageList;
  TempGlyph: TBitmap;
  Offset: Integer;
begin
  Offset := 0;
  if not Enabled and (NumGlyphs > 1) then Offset := GlyphWidth
  else if Down and (NumGlyphs > 2) then Offset := 2 * GlyphWidth
  else if MouseInControl(-1, -1, False) and (NumGlyphs > 3) then Offset := 3 * GlyphWidth;

  ImageList := TImageList.Create(self);
  ImageList.Width := GlyphWidth;
  ImageList.Height := Glyph.Height;
  TempGlyph := TBitmap.Create;

  try
    TempGlyph.Width := GlyphWidth;
    TempGlyph.Height := Glyph.Height;

    if (not Enabled) and (NumGlyphs <= 1) then
      fcCreateDisabledBitmap(Glyph, TempGlyph)
    else TempGlyph.Canvas.CopyRect(Rect(0, 0, TempGlyph.Width, TempGlyph.Height),
      Glyph.Canvas, Rect(Offset, 0, Offset + GlyphWidth, Glyph.Height));
    TempGlyph.Transparent := True;
    ImageList.AddMasked(TempGlyph, TempGlyph.TransparentColor);
    with GlyphPos do fcImageListDraw(ImageList, 0, Canvas, x, y, ILD_NORMAL, True);
  finally
    ImageList.Free;
    TempGlyph.Free;
  end;
end;

procedure TfcCustomBitBtn.DrawButtonText(Canvas: TCanvas; TextBounds: TRect);
begin
  Canvas.Brush.Style := bsClear;
  TextOptions.TextRect := TextBounds;
  TextOptions.Draw;
end;

procedure TfcCustomBitBtn.DrawItem(const DrawItemStruct: TDrawItemStruct);
begin
  FCanvas.Handle := DrawItemStruct.hDC;
  Paint;
  FCanvas.Handle := 0;
end;

procedure TfcCustomBitBtn.GetDrawBitmap(DrawBitmap: TfcBitmap; ForRegion: Boolean;
  ShadeStyle: TfcShadeStyle; Down: Boolean);
begin
end;

procedure TfcCustomBitBtn.GlyphChanged(Sender: TObject);
begin
  Invalidate;
end;

function TfcCustomBitBtn.GlyphWidth: Integer;
begin
  result := Glyph.Width;
  if NumGlyphs <> 0 then
    result := Glyph.Width div NumGlyphs;
end;

function TfcCustomBitBtn.IsMultipleRegions: Boolean;
begin
  result := False;
end;

function TfcCustomBitBtn.StoreRegionData: Boolean;
begin
  result := False;
end;

procedure TfcCustomBitBtn.NotifyLoaded;
var i: Integer;
begin
  for i := 0 to FChangeLinks.Count - 1 do
    with TfcChangeLink(FChangeLinks[i]) do
  begin
    Sender := self;
    Loaded;
  end;
end;

procedure TfcCustomBitBtn.NotifyChange;
var i: Integer;
begin
  for i := 0 to FChangeLinks.Count - 1 do
    with TfcChangeLink(FChangeLinks[i]) do
  begin
    Sender := self;
    Change;
  end;
end;

procedure TfcCustomBitBtn.NotifyChanging;
var i: Integer;
begin
  for i := 0 to FChangeLinks.Count - 1 do
    with TfcChangeLink(FChangeLinks[i]) do
  begin
    Sender := self;
    Changing;
  end;
end;

procedure TfcCustomBitBtn.Paint;
var DrawBitmap: TfcBitmap;
begin
  DrawBitmap := TfcBitmap.Create;
  try
    if BasePatch[0]=True then { 6/8/99 }
       GetDrawBitmap(DrawBitmap, False, fbsNormal, Down)
    else
       GetDrawBitmap(DrawBitmap, False, ShadeStyle, Down);
    Draw(DrawBitmap.Canvas);
    Canvas.Draw(0, 0, DrawBitmap);       // Paint TempBitmap to Canvas
    {$ifdef fcDelphi4Up} { 6/6/99 - Add SmoothFont property }
    if SmoothFont then begin
       TextOptions.Canvas:= Canvas;
       DrawButtonText(Canvas, TextRect); { Repaint text of button }
    end
    {$endif}
  finally
    DrawBitmap.Free;
  end;
end;

procedure TfcCustomBitBtn.Redraw;
begin
  FCanvas.Handle := GetDC(Handle);
  Paint;
  ReleaseDC(Handle, FCanvas.Handle);
  FCanvas.Handle := 0;
end;

procedure TfcCustomBitBtn.SetButtonDown(Value: Boolean; CheckAllowAllUp: Boolean; DoUpdateExclusive: Boolean; DoInvalidate: Boolean);
begin
  if Value <> FDown then
  begin
    FDown := Value;
    ChangeButtonDown;
    if FDown then NotifyChanging;
    if DoUpdateExclusive then UpdateExclusive;
    if DoInvalidate then Invalidate;
  end;
  if (GroupIndex > 0) and (boAutoBold in Options) then
  begin
    if FDown then Font.Style := Font.Style + [fsBold] else Font.Style := Font.Style - [fsBold];
  end;
end;

procedure TfcCustomBitBtn.UpdateExclusive;
var
  Msg: TMessage;
begin
  if (FGroupIndex <> 0) and (Parent <> nil) then
  begin
    Msg.Msg := CM_BUTTONPRESSED;
    Msg.WParam := FGroupIndex;
    Msg.LParam := Longint(Self);
    Msg.Result := 0;
    Parent.Broadcast(Msg);
  end;
end;

procedure TfcCustomBitBtn.SizeToDefault;
begin
end;

procedure TfcCustomBitBtn.UpdateShadeColors(Color: TColor);
begin
  ShadeColors.BtnShadow := fcModifyColor(Color, -50, True);
  ShadeColors.BtnBlack := fcModifyColor(ShadeColors.BtnShadow, -50, True);
  ShadeColors.Btn3dLight := fcModifyColor(Color, 50, True);
  ShadeColors.BtnHighlight := fcModifyColor(ShadeColors.Btn3dLight, 50, True);
end;

procedure TfcCustomBitBtn.RegisterChanges(Value: TfcChangeLink);
begin
   if FChangeLinks<>nil then { RSW - 3/5/99 }
      FChangeLinks.Add(Value);
end;

procedure TfcCustomBitBtn.UnRegisterChanges(Value: TfcChangeLink);
begin
   if FChangeLinks<>nil then { RSW - 3/5/99 }
      FChangeLinks.Remove(Value);
end;

{$ifdef fcDelphi4Up}
procedure TfcCustomBitBtn.ActionChange(Sender: TObject; CheckDefaults: Boolean);
  procedure CopyImage(ImageList: TCustomImageList; Index: Integer);
  begin
    with Glyph do
    begin
      Width := ImageList.Width;
      Height := ImageList.Height;
      Canvas.Brush.Color := clFuchsia;  // !!! Why clFuchsia?  Is this going to cause problems? -ksw
      Canvas.FillRect(Rect(0,0, Width, Height));
      ImageList.Draw(Canvas, 0, 0, Index);
    end;
  end;
begin
  inherited ActionChange(Sender, CheckDefaults);
  if Sender is TCustomAction then
    with TCustomAction(Sender) do
    begin
      if not (Glyph.Empty) then begin
        // Put Somethign Here
      end;
      // Copy image from action's imagelist
      if (Glyph.Empty) and (ActionList <> nil) and (ActionList.Images <> nil) and
        (ImageIndex >= 0) and (ImageIndex < ActionList.Images.Count) then
        CopyImage(ActionList.Images, ImageIndex);
    end;
end;
{$endif}

procedure TfcCustomBitBtn.Click;
var
  Form: TCustomForm;
  Control: TWinControl;
begin
  if DisableButton then exit;
  BasePatch[0]:= True;

  case FKind of
    bkClose: begin
      Form := GetParentForm(Self);
      if Form <> nil then Form.Close
      else inherited Click;
    end;
    bkHelp: begin
      Control := Self;
      while (Control <> nil) and (Control.HelpContext = 0) do
        Control := Control.Parent;
      if Control <> nil then Application.HelpContext(Control.HelpContext)
      else inherited Click;
    end;
    else begin
      Form := GetParentForm(Self);
      if Form <> nil then Form.ModalResult := ModalResult;
      inherited Click;
    end;
  end;
  BasePatch[0]:= False;
  invalidate;
end;

procedure TfcCustomBitBtn.Loaded;
begin
  inherited;
  if not (boFocusable in Options) then TabStop := False;
  ApplyRegion;

  NotifyLoaded;
end;

procedure TfcCustomBitBtn.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_SPACE then
  begin
    ProcessMouseDown;
    ProcessMouseUp(-1, -1, True, True);
    Click; { 7/26/99 - Call click on space }
  end;
end;

procedure TfcCustomBitBtn.ProcessMouseDown;
begin
  if DisableButton then exit;
  FInitialDown := Down;
  if not (boToggleOnUp in Options) or (GroupIndex = 0) then
  begin
    if (boFocusable in Options) then SetFocus; { 7/26/99 - Set focus when mouse is pressed on button }
    SetButtonDown(True, True, False, False);
  end;
  if FInitialDown <> Down then Redraw;
end;

procedure TfcCustomBitBtn.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin

  if (Button = mbLeft) and (GetKeyState(VK_LBUTTON) < 0) then
  begin
    FClicked := True;
    SetCaptureControl(self);
//    MouseCapture:= True; { Equivalent - Perhaps change to this in the future }

    ProcessMouseDown;
  end;
  inherited;
//  else inherited
end;

procedure TfcCustomBitBtn.MouseMove(Shift: TShiftState; X, Y: Integer);
var IsMouseInControl: Boolean;
begin
  if DisableButton then exit;

  inherited;

  if ((boToggleOnUp in Options)) or not FClicked or (GetKeyState(VK_LBUTTON) >= 0) then Exit;

  IsMouseInControl := MouseInControl(x, y, True);

  if (IsMouseInControl and not Down) or
     ((not IsMouseInControl and Down) and not FInitialDown) then
  begin
    SetButtonDown(IsMouseInControl, False, False, False);
    Redraw;
  end;
end;

procedure TfcCustomBitBtn.ProcessMouseUp(X, Y: Integer; AMouseInControl: Boolean; AClicked: Boolean);
begin
  if DisableButton then exit;
  if (GroupIndex = 0) then
  begin
    SetButtonDown(False, False, False, False);
    Redraw;
  end else begin
    UpdateExclusive;
    if AMouseInControl or (boToggleOnUp in Options) then
    begin
      if ((FInitialDown and AllowAllUp) or (not FInitialDown)) then
      begin
        SetButtonDown(not FInitialDown, True, True, False);
        Redraw;
        SelChange;
      end;
    end;
  end;
end;

procedure TfcCustomBitBtn.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited;

  {7/13/99 - PYW - Changed to always process mouse up in fcoutlookbar}
  if fcIsClass(Parent.ClassType, 'TfcCustomOutlookBar') then
     ProcessMouseUp(x, y, True, FClicked)
  else
     ProcessMouseUp(x, y, MouseInControl(x, y, True), FClicked);

//  MouseCapture:= False; { 4/2/99  Equivalent - Perhaps change to this in the future }
  SetCaptureControl(nil);

  //2/26/99 - Check for ToggleOnUp so that Click will be fired when button has
  //          different up/down regions.
  if MouseInControl(x, y, True) or (boToggleOnUp in Options) then Click;

  FClicked := False;
end;

procedure TfcCustomBitBtn.SetName(const Value: TComponentName);
begin
  inherited;
  if Assigned(FOnSetName) then FOnSetName(self);
end;

procedure TfcCustomBitBtn.CMButtonPressed(var Message: TMessage);
var
  Sender: TfcCustomBitBtn;
begin
  if Message.WParam = FGroupIndex then
  begin
    if not (TObject(Message.LParam) is TfcCustomBitBtn) then Exit;
    Sender := TfcCustomBitBtn(Message.LParam);
    if (Sender <> Self) and (Sender.Down) then
    begin
      SetButtonDown(False, False, False, True);
      SelChange;
    end;
  end;
end;

procedure TfcCustomBitBtn.CMDialogChar(var Message: TCMDialogChar);
begin
  with Message do
  begin
    if  (((CharCode = VK_RETURN) and FActive) or
      ((CharCode = VK_ESCAPE) and FCancel)) and
      (KeyDataToShiftState(Message.KeyData) = []) and CanFocus then
    begin
      Click;
      Result := 1;
    end else if IsAccel(CharCode, Caption) and CanFocus then begin
      Down := not Down;
      Click;
      Invalidate;
      Result := 1;
    end else inherited;
  end;
end;

procedure TfcCustomBitBtn.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  Invalidate;
end;

procedure TfcCustomBitBtn.CMFocusChanged(var Message: TCMFocusChanged);
begin
  with Message do
    if Sender is TfcCustomBitBtn then
      FActive := Sender = Self
    else
      FActive := FDefault;
  inherited;
end;

procedure TfcCustomBitBtn.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  if (ShadeStyle = fbsFlat) or (NumGlyphs = 4) then Invalidate;
  if Assigned(FOnMouseEnter) then FOnMouseEnter(self);
end;

procedure TfcCustomBitBtn.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  if (ShadeStyle = fbsFlat) or (NumGlyphs = 4) then Invalidate;
  if Assigned(FOnMouseLeave) then FOnMouseLeave(self);
end;

procedure TfcCustomBitBtn.CNMeasureItem(var Message: TWMMeasureItem);
begin
  with Message.MeasureItemStruct^ do
  begin
    ItemWidth := Width;
    ItemHeight := Height;
  end;
end;

procedure TfcCustomBitBtn.CNDrawItem(var Message: TWMDrawItem);
begin
  DrawItem(Message.DrawItemStruct^);
end;

procedure TfcCustomBitBtn.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  Message.Result := 1;
end;

procedure TfcCustomBitBtn.WMLButtonDown(var Message: TWMLButtonDown);
begin
  SendCancelMode(Self);
  if csCaptureMouse in ControlStyle then MouseCapture := True;
  if csClickEvents in ControlStyle then ControlState := ControlState + [csClicked];
  with Message do
    MouseDown(mbLeft, KeysToShiftState(Keys) + [], XPos, YPos);
end;

procedure TfcCustomBitBtn.WMMouseActivate(var Message: TWMMouseActivate);
var Button: TMouseButton;
    Shift: TShiftState;

  function GetShiftState: TShiftState;
  begin
    Result := [];
    if GetKeyState(VK_SHIFT) < 0 then Include(Result, ssShift);
    if GetKeyState(VK_CONTROL) < 0 then Include(Result, ssCtrl);
  end;

  function ShiftStateToKeys(State: TShiftState): Word;
  begin
     Result := 0;
     if ssShift in State then Result:= Result + MK_SHIFT;
     if ssCtrl in State then Result:= Result + MK_CONTROL;
     if ssLeft in State then Result:= Result + MK_LBUTTON;
     if ssRight in State then Result:= Result + MK_RBUTTON;
  end;

begin
  if (csDesigning in ComponentState) or (boFocusable in Options) then inherited
  else begin
    Message.result := MA_NOACTIVATEANDEAT;
    if Message.MouseMsg = WM_LBUTTONDOWN then Button := mbLeft else Button := mbRight;
    Shift := GetShiftState;
    if Button = mbLeft then include(Shift, ssLeft) else include(Shift, ssRight);

    GetParentForm(self).BringToFront; // Added to make sure form is shown when user clicks on button. (Avoid IE5 scroll button problems) -ksw (2/19/99)

    with ScreenToClient(fcGetCursorPos) do
      if (x>=0) and (y>=0) then { RSW - 4/16/99 }
      begin
         if Button=mbLeft then
            PostMessage(Handle, WM_LBUTTONDOWN, ShiftStateToKeys(Shift), MAKELPARAM(x, y))
         else
            PostMessage(Handle, WM_RBUTTONDOWN, ShiftStateToKeys(Shift), MAKELPARAM(x, y))
      end
  end;
end;

function TfcCustomBitBtn.GetKind: TBitBtnKind;
begin
  if FKind <> bkCustom then
    if ((FKind in [bkOK, bkYes]) xor Default) or
       ((FKind in [bkCancel, bkNo]) xor Cancel) or
       (ModalResult <> BITBTNMODALRESULTS[FKind]) or
       FModifiedGlyph then
      FKind := bkCustom;
  Result := FKind;
end;

procedure TfcCustomBitBtn.SetAllowAllUp(Value: Boolean);
begin
  if FAllowAllUp <> Value then
  begin
    FAllowAllUp := Value;
    UpdateExclusive;
  end;
end;

procedure TfcCustomBitBtn.SetDefault(Value: Boolean);
var
  Form: TCustomForm;
begin
  FDefault := Value;
  if HandleAllocated then
  begin
    Form := GetParentForm(Self);
    if Form <> nil then
      Form.Perform(CM_FOCUSCHANGED, 0, Longint(Form.ActiveControl));
  end;
end;

procedure TfcCustomBitBtn.SetDown(Value: Boolean);
begin
  if (FGroupIndex = 0) and (not (csLoading in ComponentState)) then Value := False;
  if FDown <> Value then
  begin
    SetButtonDown(Value, True, True, True);
    if FDown = Value then SelChange;
  end;
end;

procedure TfcCustomBitBtn.SetGlyph(Value: TBitmap);
begin
  Glyph.Assign(Value);
  Invalidate;
end;

procedure TfcCustomBitBtn.SetGroupIndex(Value: Integer);
begin
  if FGroupIndex <> Value then
  begin
    FGroupIndex := Value;
    UpdateExclusive;
  end;
end;

procedure TfcCustomBitBtn.SetKind(Value: TBitBtnKind);
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
        if BitBtnCaptions[Value] <> nil then
          Caption := LoadResString(BitBtnCaptions[Value]);
      end;

      ModalResult := BITBTNMODALRESULTS[Value];
      GetBitBtnGlyph(Value, FGlyph);
      NumGlyphs := 2;
      FModifiedGlyph := False;
    end;
    FKind := Value;
    Invalidate;
  end;
end;

procedure TfcCustomBitBtn.SetLayout(Value: TButtonLayout);
begin
  if FLayout <> Value then
  begin
    FLayout := Value;
    Invalidate;
  end;
end;

procedure TfcCustomBitBtn.SetMargin(Value: Integer);
begin
  if (Value <> FMargin) and (Value >= - 1) then
  begin
    FMargin := Value;
    Invalidate;
  end;
end;

procedure TfcCustomBitBtn.SetNumGlyphs(Value: TNumGlyphs);
begin
  Value := fcMin(fcMax(Value, 1), 4);
  if Value <> FNumGlyphs then
  begin
    FNumGlyphs := Value;
    Invalidate;
  end;
end;

procedure TfcCustomBitBtn.SetOptions(Value: TfcButtonOptions);
var ChangedOptions: TfcButtonOptions;
begin
  if FOptions <> Value then
  begin
    ChangedOptions := (FOptions - Value) + (Value - FOptions);
    FOptions := Value;
    if not (boFocusable in FOptions) then TabStop := False;
    if boAutoBold in ChangedOptions then SetButtonDown(Down, False, False, True);
  end;
end;

procedure TfcCustomBitBtn.SetShadeStyle(Value: TfcShadeStyle);
begin
  if FShadeStyle <> Value then
  begin
    FShadeStyle := Value;
    Recreatewnd;
  end;
end;

procedure TfcCustomBitBtn.SetSpacing(Value: Integer);
begin
  if FSpacing <> Value then
  begin
    FSpacing := Value;
    Invalidate;
  end;
end;

procedure TfcCustomBitBtn.SetStyle(Value: TButtonStyle);
begin
  if Value <> FStyle then
  begin
    FStyle := Value;
    Invalidate;
  end;
end;

function TfcCustomBitBtn.IsCustom: Boolean;
begin
  Result := Kind = bkCustom;
end;

function TfcCustomBitBtn.IsCustomCaption: Boolean;
begin
  Result := CompareStr(Caption, LoadResString(BitBtnCaptions[FKind])) <> 0;
end;

function TfcCustomBitBtn.MouseInControl(X, Y: Integer; AndClicked: Boolean): Boolean;
var p: TPoint;
    AHandle: HWND;
    TmpRgn: HRGN;
    Control: TWinControl;
begin
  if IsMultipleRegions then Control := self else Control := Parent;
  if (x = -1) and (y = -1) then p := Control.ScreenToClient(fcGetCursorPos)
  else p := Control.ScreenToClient(ClientToScreen(Point(x, y)));

  if IsMultipleRegions then
  begin
    TmpRgn := CreateRegion(True, not Down);
    CombineRgn(TmpRgn, TmpRgn, FLastRegion, RGN_OR);
    result := PtInRegion(TmpRgn, p.x, p.y);
    DeleteOBject(TmpRgn);
  end else begin
    AHandle := ChildWindowFromPoint(Parent.Handle, p);
    result := FindControl(AHandle) = self;
  end;
  if AndClicked then result := result and FClicked;
end;

procedure Initialize;
begin
  FillChar(BitBtnGlyphs, SizeOf(BitBtnGlyphs), 0);
  BitBtnCaptions[bkOK] := @SOKButton;
  BitBtnCaptions[bkCancel] := @SCancelButton;
  BitBtnCaptions[bkHelp] := @SHelpButton;
  BitBtnCaptions[bkYes] := @SYesButton;
  BitBtnCaptions[bkNo] := @SNoButton;
  BitBtnCaptions[bkClose] := @SCloseButton;
  BitBtnCaptions[bkAbort] := @SAbortButton;
  BitBtnCaptions[bkRetry] := @SRetryButton;
  BitBtnCaptions[bkIgnore] := @SIgnoreButton;
  BitBtnCaptions[bkAll] := @SAllButton;
end;

procedure Finalize;
var i: TBitBtnKind;
begin
  for i := Low(TBitBtnKind) to High(TBitBtnKind) do
    BitBtnGlyphs[I].Free;
end;

procedure TfcCustomBitBtn.WMSize(var Message: TWMSize);
var r: TRect;
begin
  inherited;
  ClearRegion(@FRegionData);
  ClearRegion(@FDownRegionData);
  SetWindowRgn(Handle, 0, True);
  ApplyRegion;
  Invalidate;
  r := BoundsRect;
  if Parent <> nil then InvalidateRect(Parent.Handle, @r, True);
end;

{ RSW - 3/9/99 - Process default button when carriage return or Cancel entered }
procedure TfcCustomBitBtn.CMDialogKey(var Message: TCMDialogKey);
begin
  with Message do
    if  (((CharCode = VK_RETURN) and FActive) or
      ((CharCode = VK_ESCAPE) and FCancel)) and
      (KeyDataToShiftState(Message.KeyData) = []) and CanFocus then
    begin
      Click;
      Result := 1;
    end else
      inherited;
end;

procedure TfcCustomBitBtn.WMCancelMode(var Message: TWMCancelMode);
begin
  inherited;
  if csLButtonDown in ControlState then Perform(WM_LBUTTONUP, 0, Integer($FFFFFFFF));
end;

procedure TfcCustomBitBtn.InvalidateNotRegion(const Erase: Boolean);
var Rgn, TmpRgn: HRGN;
begin
  with ClientRect do Rgn := CreateRectRgn(Left, Top, Right, Bottom);
  with ClientRect do TmpRgn := CreateRegion(False, Down);
  try
    CombineRgn(Rgn, Rgn, TmpRgn, RGN_DIFF);
    OffsetRgn(Rgn, Left, Top);
    InvalidateRgn(Parent.Handle, Rgn, Erase);
  finally
    DeleteObject(Rgn);
    DeleteObject(TmpRgn);
  end;
end;

function TfcCustomBitBtn.UseRegions: boolean;
begin
   result:= False;
end;

initialization
  Initialize;
finalization
  Finalize;
end.
