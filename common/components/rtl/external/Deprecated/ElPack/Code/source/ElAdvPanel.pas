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

{$r ElAdvPanel.res}

(*

Version History

03/10/2003

 Fixed storing of CaptionSettings property to form (added assign method)
 Fixed CaptionSettings.MinButtonGlyph (setting empty images

11/22/2002

  Added OnCloseQuery event
  Now clicks on caption fire OnClick and OnDblClick events
  ShowFocus property made published

10/12/2002

  Added optional checkbox to caption

08/12/2002

  Added support for undocked panel (when DragMode = dmDock and the control is in floating window)

12/27/2001

  Now one can correctly set glyphs for Minimize button -- 2 images in one bitmap
  in format suitable for imagelist

11/22/2001

  Link* properties now change settings for caption too

10/29/2001

  Fixed the problem with incorrect OnRestore event invokation when the panel is resized.

10/27/2001

  InvertMinButtonArrows property now does really work correctly when the for is just loade :)

10/25/2001

  When panel is saved as minimized, there was no way to restore it in run-time.
  Fixed.

10/21/2001

  Clicks on caption links were not processed. Fixed.

10/19/2001

  InvertMinButtonArrows property now works correctly when the for is just loaded.

10/06/2001

  InvertMinButtonArrows property added.
  Caption rectangle is inflated by BevelWidth size now

09/26/2001

  Fixed caption sizing when bevel size is > 0.

09/17/2001

  Default caption alignment taCenter was not set properly. Fixed.
  OnClose event was mapped to OnRestore event handler. Fixed.

*)

unit ElAdvPanel;

interface

uses

  SysUtils,
  Classes,

  Forms,
  ElPanel,
  ElPopBtn,
  ElVCLUtils,
  ElHTMLPanel,
  ElTools,
{$ifdef ELPACK_USE_IMAGEFORM}
  ElImgFrm,
{$endif}
  ElStrUtils,
  ElUxTheme,
  ElTmSchema,
  {$ifndef ELADVPANEL_NO_CHECKBOX}
  ElCheckCtl,
  {$endif}

  {$ifdef VCL_4_USED}
  ImgList,
  {$endif}
  Windows,
  Graphics,
  Controls,
  StdCtrls,
  Menus,
  ExtCtrls,
{$ifdef VCL_6_USED}
Types,
{$endif}
  Messages;

type

  TCustomElAdvancedPanel = class;
  TElAdvCaptionButton = class;
  TElAdvCaptionPanel = class;

  // TElCloseQueryEvent = procedure(Sender : TObject; var CanClose : boolean) of object;

  TElPanelCaptionSettings = class(TPersistent)
  private
    FVisible: Boolean;
    FHeight: Integer;
    FShowCloseButton: Boolean;
    FOwner: TCustomElAdvancedPanel;
    FShowMinButton: Boolean;
    FButtonWidth: Integer;
    FAlignment: TAlignment;
    FLayout: TTextLayout;
    FButtonColor: TColor;
    {$ifndef ELADVPANEL_NO_CHECKBOX}
    FShowCheckBox: boolean;
    FCheckBoxChecked: Boolean;
    {$endif}
    procedure SetText(Value: TElFString);
    procedure SetVisible(Value: Boolean);
    procedure SetHeight(Value: Integer);
    procedure SetShowCloseButton(Value: Boolean);
    procedure SetShowMinButton(Value: Boolean);
    function GetText: TElFString;
    procedure SetButtonWidth(Value: Integer);
    procedure SetAlignment(Value: TAlignment);
    procedure SetLayout(newValue: TTextLayout);
    function GetFont: TFont;
    procedure SetFont(Value: TFont);
    function GetParentFont: Boolean;
    procedure SetParentFont(Value: Boolean);
    function GetColor: TColor;
    procedure SetColor(Value: TColor);
    procedure SetButtonColor(Value: TColor);
    {$ifdef ELPACK_USE_IMAGEFORM}
    function GetImageForm: TElImageForm;
    procedure SetImageForm(Value: TElImageForm);
    {$endif}
    {$ifndef ELADVPANEL_NO_CHECKBOX}
    procedure SetShowCheckBox(Value: boolean);
    procedure SetCheckBoxChecked(Value: boolean);
    {$endif}
  protected
    FInvertMinButtonArrows: Boolean;
    FAutoSize: Boolean;
    FFlat: Boolean;
    FFlatAlways: Boolean;
    function GetMinButtonGlyph: TBitmap;
    procedure SetMinButtonGlyph(Value: TBitmap);
    function GetCloseButtonGlyph: TBitmap;
    procedure SetCloseButtonGlyph(Value: TBitmap);
    procedure SetInvertMinButtonArrows(Value: Boolean);
    procedure SetAutoSize(Value: Boolean);
    procedure FontChanged;
    procedure AdjustHeight;
    procedure SetFlat(Value: Boolean);
    procedure SetFlatAlways(Value: Boolean);
  public
    constructor Create(Owner : TCustomElAdvancedPanel);
    procedure LoadDefaultMinButton;
    procedure Assign(Source : TPersistent); override;
  published
    property Text: TElFString read GetText write SetText;
    property Visible: Boolean read FVisible write SetVisible default true;
    property Height: Integer read FHeight write SetHeight default 19;
    property ShowCloseButton: Boolean read FShowCloseButton write
        SetShowCloseButton default true;
    property ShowMinButton: Boolean read FShowMinButton write SetShowMinButton default true;
    property FlatButtons: Boolean read FFlat write SetFlat stored False default
        true;
    property ButtonWidth: Integer read FButtonWidth write SetButtonWidth default 15;
    property Alignment: TAlignment read FAlignment write SetAlignment default
        taCenter;
    property Layout: TTextLayout read FLayout write SetLayout default tlTop;
    property Font: TFont read GetFont write SetFont;
    property ParentFont: Boolean read GetParentFont write SetParentFont default true;
    property Color: TColor read GetColor write SetColor default clBtnFace;
    property ButtonColor: TColor read FButtonColor write SetButtonColor default
        clBtnFace;
    {$ifdef ELPACK_USE_IMAGEFORM}
    property ImageForm: TElImageForm read GetImageForm write SetImageForm;
    {$endif}
    property MinButtonGlyph: TBitmap read GetMinButtonGlyph write SetMinButtonGlyph;
    property CloseButtonGlyph: TBitmap read GetCloseButtonGlyph write
        SetCloseButtonGlyph;
    property InvertMinButtonArrows: Boolean read FInvertMinButtonArrows write
        SetInvertMinButtonArrows default false;
    property AutoSize: Boolean read FAutoSize write SetAutoSize default false;
    {$ifndef ELADVPANEL_NO_CHECKBOX}
    property ShowCheckBox: boolean read FShowCheckBox write SetShowCheckBox default false;
    property CheckBoxChecked: Boolean read FCheckBoxChecked write
        SetCheckBoxChecked default false;
    {$endif}
    property Flat: Boolean read FFlat write SetFlat default true;
    property FlatAlways: Boolean read FFlatAlways write SetFlatAlways default false;
  end;

  TCustomElAdvancedPanel = class(TCustomElHTMLPanel)
  protected
    FMinButtonGlyph: TBitmap;
    FImages     : TImageList;
    FSaveHeight : Integer;
    FMinimized: Boolean;
    FCaptionPanel: TElHTMLPanel;
    FCaptionSettings: TElPanelCaptionSettings;
    FMinButton: TElGraphicButton;
    FCloseButton: TElGraphicButton;
    {$ifndef ELADVPANEL_NO_CHECKBOX}
    FCheckBox: TElCheckBox;
    {$endif}
    FOnMinimize: TNotifyEvent;
    FOnRestore: TNotifyEvent;
    FOnClose: TNotifyEvent;
    FOnCloseQuery: TCloseQueryEvent;

    procedure SetLinkPopupMenu(newValue : TPopupMenu); override;
    procedure SetLinkColor(newValue : TColor); override;
    procedure SetLinkStyle(newValue : TFontStyles); override;

    procedure WMSize(var Message: TMessage); message WM_SIZE;
    procedure TriggerMinimizeEvent; virtual;
    procedure TriggerRestoreEvent; virtual;
    procedure AdjustButtonSize;
    procedure OnCaptionSize(Sender : TObject);
    procedure OnMinButtonClick(Sender : TObject);
    procedure OnCloseButtonClick(Sender : TObject);
    procedure TriggerCloseEvent; virtual;
    procedure AdjustClientRect(var Rect: TRect); override;
    procedure CreateWnd; override;
    procedure SetCaptionSettings(Value: TElPanelCaptionSettings);
    procedure WMNCHitTest(var Msg : TMessage); message WM_NCHITTEST;
    procedure LinkClickEventTransfer(Sender : TObject; HRef : TElFString);
    {$ifdef ELPACK_USE_IMAGEFORM}
    procedure SetImageForm(newValue : TElImageForm); override;
    {$endif}
    procedure SetUseXPThemes(const Value: Boolean); override;
    procedure AdjustInnerSize(var R : TRect); virtual;
    function GetBevelAdjustment: Integer;
    procedure UpdateMinButtonImages;
    procedure Loaded; override;
    procedure DefineProperties(Filer: TFiler); override;
    procedure ReadExpHeight(Reader : TReader);
    procedure WriteExpHeight(Writer : TWriter);
    procedure SetTransparentXPThemes(Value: Boolean); override;
    function CreateButton: TElAdvCaptionButton; virtual;
    {$ifndef ELADVPANEL_NO_CHECKBOX}
    function CreateCheckbox: TElCheckBox; virtual;
    {$endif}
    procedure SetMinimized(Value: Boolean); virtual;
    function CreatePanel: TElAdvCaptionPanel; virtual;
    function GetThemePartID: Integer; virtual;
    procedure UpdateInterior; override;
    procedure WMSetFocus(var Message: TMessage); message WM_SETFOCUS;
    procedure DoClick(Sender : TObject); virtual;
    function GetShowFocus: Boolean;
    procedure SetShowFocus(Value: Boolean);
    procedure DoDblClick(Sender : TObject); virtual;
    procedure TriggerCloseQueryEvent(var CanClose : boolean); virtual;
    procedure ELThemeChanged(var Message: TMessage); message EL_THEMECHANGED;
    property Minimized: Boolean read FMinimized write SetMinimized default false;
    property CaptionSettings: TElPanelCaptionSettings read FCaptionSettings write SetCaptionSettings;
    property OnMinimize: TNotifyEvent read FOnMinimize write FOnMinimize;
    property OnRestore: TNotifyEvent read FOnRestore write FOnRestore;
    property OnClose: TNotifyEvent read FOnClose write FOnClose;
    property OnCloseQuery: TCloseQueryEvent read FOnCloseQuery write FOnCloseQuery;
    property ShowFocus: Boolean read GetShowFocus write SetShowFocus default true;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    function GetCaptionHeight: Integer; virtual;
    function GetButtonWidth: Integer; virtual;

    property CaptionPanel : TElHTMLPanel read FCaptionPanel;
  end;

  TElAdvancedPanel = class(TCustomElAdvancedPanel)
  published
    property OnImageNeeded;
    property OnLinkClick;
    property Cursor;
    property LinkColor;
    property LinkPopupMenu;
    property LinkStyle;

    property Background;
    property BackgroundType;
    property GradientEndColor;
    property GradientStartColor;
    property GradientSteps;
    property Alignment;
    property Layout;
    {$ifdef ELPACK_USE_IMAGEFORM}
    property ImageForm;
    {$endif}
    property TopGrabHandle;
    property RightGrabHandle;
    property LeftGrabHandle;
    property BottomGrabHandle;

    property Resizable;
    property Movable;
    property OnMove;

    property Align nodefault;
    property BevelInner nodefault;
    property BevelOuter nodefault;
    property BevelSpaceColor nodefault;
    property BevelWidth;
    property BorderStyle;
    property BorderWidth;
    property Color;
{$ifdef MSWINDOWS}
    property DragCursor;
{$endif}
    property DragMode;
    property Enabled;
    property Font;
{$ifdef MSWINDOWS}
    property Locked;
    property MouseCapture;
{$endif}
    property ParentColor;
{$ifdef MSWINDOWS}
    property ParentCtl3D;
{$endif}
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property ShowFocus;
    property TabStop;
    property Transparent;
    property TransparentXPThemes;
    property UseXPThemes;
    property Visible;
    property SizeGrip;

    property Caption;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnResize;
{$IFDEF VCL_4_USED}
    property Anchors;
    property Action;
    property Constraints;
{$ifdef MSWINDOWS}
    property DockSite;
    property DockOrientation;
    property BevelKind;
    property DoubleBuffered;
    property DragKind;
{$endif}
{$ENDIF}

    property Minimized;
    property CaptionSettings;
    property OnMinimize;
    property OnRestore;
    property OnClose;
    property OnCloseQuery;
  end;

  TElAdvCaptionPanel = class(TElHTMLPanel)
  private
    FDummyInt : integer;
    FDummyBool: boolean;
    DoResize  : boolean;

    procedure WMNCHitTest(var Msg : TMessage); message WM_NCHITTEST;
  protected
    procedure CreateWnd; override;
    procedure AdjustClientRect(var Rect: TRect); override;
    {$ifdef ELPACK_USE_IMAGEFORM}
    procedure SetImageForm(newValue : TElImageForm); override;
    {$endif}
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure WMKillFocus(var Message: TMessage); message WM_KILLFOCUS;
    procedure WMSetFocus(var Message: TMessage); message WM_SETFOCUS;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
        override;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
  public
    constructor Create(AOwner : TComponent); override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
  published
    property TabStop : boolean write FDummyBool;
    property TabOrder: integer write FDummyInt;
  end;

  TElAdvCaptionButton = class(TElGraphicButton)
  protected
    procedure DrawThemedBackground(Canvas : TCanvas); override;
  public
    constructor Create(AOwner : TComponent); override;
  end;

  {$ifndef ELADVPANEL_NO_CHECKBOX}
  THackCheckBox = class(TElCheckBox)
  end;
  {$endif}

implementation

var
  CloseBmp,
  UpArrowBmp,
  DownArrowBmp : TBitmap;

const Margin = 1;

type

  THackGraphicButton = TElAdvCaptionButton;

procedure TElAdvCaptionPanel.CreateWnd;
begin
  inherited;
  THackGraphicButton(TCustomElAdvancedPanel(Parent).FMinButton).SetDesigning(false);
  THackGraphicButton(TCustomElAdvancedPanel(Parent).FCloseButton).SetDesigning(false);
  {$ifndef ELADVPANEL_NO_CHECKBOX}
  THackCheckBox(TCustomElAdvancedPanel(Parent).FCheckBox).SetDesigning(false);
  {$endif}
end;

procedure TElAdvCaptionPanel.AdjustClientRect(var Rect : TRect);
var ASettings : TElPanelCaptionSettings;
begin
  inherited;
  ASettings := TCustomElAdvancedPanel(Parent).FCaptionSettings;

  if ASettings.FShowMinButton then
    dec(Rect.Right, Margin + TCustomElAdvancedPanel(Parent).GetButtonWidth);
  if ASettings.FShowCloseButton then
    dec(Rect.Right, Margin + TCustomElAdvancedPanel(Parent).GetButtonWidth);
  {$ifndef ELADVPANEL_NO_CHECKBOX}
  if ASettings.ShowCheckbox then
    inc(Rect.Left, Margin + TCustomElAdvancedPanel(Parent).FCheckBox.Width);
  {$endif}
  InflateRect(Rect, - Margin * 2, 0);
end;

procedure TElAdvCaptionPanel.WMNCHitTest(var Msg : TMessage);
begin
  inherited;
  if TCustomElAdvancedPanel(Parent).Movable or (csDesigning in Parent.ComponentState) then
    Msg.Result := HTTRANSPARENT;
end; {WMNCHitTest}

{$ifdef ELPACK_USE_IMAGEFORM}
procedure TElAdvCaptionPanel.SetImageForm(newValue : TElImageForm);
begin
  inherited;
  if Parent = nil then exit;
  if TCustomElAdvancedPanel(Parent).FCloseButton <> nil then
    TCustomElAdvancedPanel(Parent).FCloseButton.ImageForm := newValue;
  if TCustomElAdvancedPanel(Parent).FMinButton <> nil then
    TCustomElAdvancedPanel(Parent).FMinButton.ImageForm := newValue;
end;
{$endif}

constructor TElAdvCaptionPanel.Create(AOwner : TComponent);
begin
  inherited;
  BevelInner   := bvNone;
  BevelOuter   := bvNone;
  BorderStyle  := bsNone;

  ShowFocus    := true;

  ControlStyle := [csClickEvents, csDoubleClicks];
end;

procedure TElAdvCaptionPanel.CMFontChanged(var Message: TMessage);
begin
  inherited;
  TElAdvancedPanel(Parent).FCaptionSettings.FontChanged;
end;

procedure TElAdvCaptionPanel.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_SPACE) and (Shift = []) and
     TElAdvancedPanel(Parent).FCaptionSettings.ShowMinButton then
  begin
    TElAdvancedPanel(Parent).Minimized := not TElAdvancedPanel(Parent).Minimized;
    Key := 0;
  end;
  inherited;
end;

type THackForm = class(TForm);

procedure TElAdvCaptionPanel.WMKillFocus(var Message: TMessage);
var CurControl : TWinControl;
begin
  inherited;
  if TElAdvancedPanel(Parent).Minimized then
  begin
    Curcontrol := self;
    repeat
      CurControl := THackForm(GetParentForm(Self)).FindNextControl(Curcontrol, true, true, false);
    until (CurControl = nil) or ((CurControl.Parent <> Parent) and CurControl.Enabled and CurControl.Visible);
    if (CurControl <> nil) and CurControl.CanFocus and CurControl.Visible and GetParentForm(CurControl).Visible then
    try
     CurControl.SetFocus;
    except
    end;
  end;
end;

procedure TElAdvCaptionPanel.WMSetFocus(var Message: TMessage);
var CurControl : TWinControl;
begin
  inherited;
  if not TElAdvancedPanel(Parent).FCaptionSettings.ShowMinButton then
  begin
    Curcontrol := THackForm(GetParentForm(Self)).FindNextControl(Self, true, true, false);
    if (CurControl <> nil) and (TWMSetFocus(Message).FocusedWnd = CurControl.Handle) then
      THackForm(GetParentForm(Self)).SelectNext(Parent, false, true)
    else
      THackForm(GetParentForm(Self)).SelectNext(Self, true, true)
  end;
end;

procedure TElAdvCaptionPanel.MouseDown(Button: TMouseButton; Shift: TShiftState;
    X, Y: Integer);
begin
  inherited MouseDown(Button, Shift, X, Y);
  SetFocus;
end;

procedure TElAdvCaptionPanel.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var SaveHeight : integer;
begin
  SaveHeight := Height;
  if DoResize then
    inherited;
  if SaveHeight <> AHeight then
  begin

  end;
end;

procedure TElAdvCaptionPanel.WMPaint(var Message: TWMPaint);
begin
  inherited;
end;

procedure TElPanelCaptionSettings.SetText(Value: TElFString);
begin
  FOwner.FCaptionPanel.Caption := Value;
end;

procedure TElPanelCaptionSettings.SetVisible(Value: Boolean);
var R : TRect;
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    if not Visible and FOwner.Minimized then
      FOwner.Minimized := false;
    FOwner.FCaptionPanel.Visible := Value;
    R := FOwner.ClientRect;
    FOwner.AlignControls(nil, R);
    FOwner.Invalidate;
  end;
end;

procedure TElPanelCaptionSettings.SetHeight(Value: Integer);
begin
  if FHeight <> Value then
  begin
    FHeight := Value;
    if FOwner.FMinimized then
      FOwner.Height := Value;
    with TElAdvCaptionPanel(FOwner.FCaptionPanel) do
    begin
      DoResize := true;
      Height := Value;
      DoResize := false;
    end;
    FOwner.Invalidate;
  end;
end;

procedure TElPanelCaptionSettings.SetShowCloseButton(Value: Boolean);
begin
  if FShowCloseButton <> Value then
  begin
    FShowCloseButton := Value;
    FOwner.FCloseButton.Visible := Value;
    FOwner.AdjustButtonSize;
    FOwner.FCaptionPanel.Invalidate;
  end;
end;

procedure TElPanelCaptionSettings.SetShowMinButton(Value: Boolean);
begin
  if FShowMinButton <> Value then
  begin
    FShowMinButton := Value;
    FOwner.FMinButton.Visible := Value;
    FOwner.AdjustButtonSize;
    FOwner.FCaptionPanel.Invalidate;
  end;
end;

{$ifndef ELADVPANEL_NO_CHECKBOX}
procedure TElPanelCaptionSettings.SetShowCheckBox(Value: boolean);
begin
  if Value <> FShowCheckBox then
  begin
    FShowCheckBox := Value;
    FOwner.FCheckBox.Visible := Value;
    FOwner.FCaptionPanel.Invalidate;
  end;
end;

procedure TElPanelCaptionSettings.SetCheckBoxChecked(Value: boolean);
begin
  if Value <> FCheckBoxChecked then
  begin
    FCheckBoxChecked := Value;
    FOwner.FCheckBox.Checked := Value;
  end;
end;
{$endif}

constructor TElPanelCaptionSettings.Create(Owner : TCustomElAdvancedPanel);
begin
  inherited Create;
  FOwner := Owner;
  FVisible := true;
  FHeight := 19;
  FButtonWidth := 15;
  FShowCloseButton := true;
  FShowMinButton := true;
  FFlat := true;
  //FColor := clBtnFace;
  FButtonColor := clBtnFace;
  FAlignment := taCenter;
  {$ifndef ELADVPANEL_NO_CHECKBOX}
  FShowCheckBox := false;
  FCheckBoxChecked := false;
  {$endif}
end;

procedure TElPanelCaptionSettings.SetButtonWidth(Value: Integer);
begin
  if FButtonWidth <> Value then
  begin
    FButtonWidth := Value;
    if AutoSize then
      AdjustHeight;
    FOwner.AdjustButtonSize;
  end;
end;

procedure TElPanelCaptionSettings.SetAlignment(Value: TAlignment);
begin
  FAlignment := Value;
  FOwner.FCaptionPanel.Alignment := Value;
end;

procedure TElPanelCaptionSettings.SetLayout(newValue: TTextLayout);
{ Sets data member FLayout to newValue. }
begin
  if (FLayout <> newValue) then
  begin
    FLayout := newValue;
    FOwner.FCaptionPanel.Layout := newValue;
  end;  { if }
end;  { SetLayout }

function TElPanelCaptionSettings.GetFont: TFont;
begin
  Result := FOwner.FCaptionPanel.Font;
end;

procedure TElPanelCaptionSettings.SetFont(Value: TFont);
begin
  FOwner.FCaptionPanel.Font := Value;
end;

function TElPanelCaptionSettings.GetParentFont: Boolean;
begin
  Result := FOwner.FCaptionPanel.ParentFont;
end;

procedure TElPanelCaptionSettings.SetParentFont(Value: Boolean);
begin
  FOwner.FCaptionPanel.ParentFont := Value;
end;

function TElPanelCaptionSettings.GetColor: TColor;
begin
  Result := FOwner.FCaptionPanel.Color;
end;

procedure TElPanelCaptionSettings.SetColor(Value: TColor);
begin
  FOwner.FCaptionPanel.Color := Value;
end;

procedure TElPanelCaptionSettings.SetButtonColor(Value: TColor);
begin
  if FButtonColor <> Value then
  begin
    FButtonColor := Value;
    FOwner.FMinButton.Color := FButtonColor;
    FOwner.FCloseButton.Color := FButtonColor;
  end;
end;

{$ifdef ELPACK_USE_IMAGEFORM}
function TElPanelCaptionSettings.GetImageForm: TElImageForm;
begin
  Result := FOwner.FCaptionPanel.ImageForm;
end;

procedure TElPanelCaptionSettings.SetImageForm(Value: TElImageForm);
begin
  FOwner.FCaptionPanel.ImageForm := Value;
end;
{$endif}

function TElPanelCaptionSettings.GetMinButtonGlyph: TBitmap;
begin
  FOwner.FMinButtonGlyph.Width := 0;
  FOwner.FMinButtonGlyph.Width := FOwner.FImages.Width * 2;
  FOwner.FMinButtonGlyph.Height := FOwner.FImages.Height;

  if FOwner.FImages.Count>0 then
  begin
    FOwner.FImages.Draw(FOwner.FMinButtonGlyph.Canvas, 0, 0, 0);
    FOwner.FImages.Draw(FOwner.FMinButtonGlyph.Canvas, FOwner.FImages.Width, 0, 1);
  end;

  Result := FOwner.FMinButtonGlyph;
end;

procedure TElPanelCaptionSettings.LoadDefaultMinButton;
begin
  with FOwner do
  begin
    FImages.Width := 7;
    FImages.Height := 5;
    FImages.AddMasked(UpArrowBmp, clWhite);
    FImages.AddMasked(DownArrowBmp, clWhite);
    FMinButton.Images := FImages;
    FMinButton.UseImageList := true;
    FMinButton.ImageIndex := 0;
  end;
end;

procedure TElPanelCaptionSettings.Assign(Source : TPersistent);
 var
   Src :TElPanelCaptionSettings absolute Source;
begin
  if Source is TElPanelCaptionSettings then
  begin
    Text                  := Src.Text;
    Visible               := Src.Visible;
    Height                := Src.Height;
    ShowCloseButton       := Src.ShowCloseButton;
    ShowMinButton         := Src.ShowMinButton;
    FlatButtons           := Src.FlatButtons;
    ButtonWidth           := Src.ButtonWidth;
    Alignment             := Src.Alignment;
    Layout                := Src.Layout;
    Font                  := Src.Font;
    ParentFont            := Src.ParentFont;
    Color                 := Src.Color;
    ButtonColor           := Src.ButtonColor;
    {$ifdef ELPACK_USE_IMAGEFORM}
    ImageForm             := Src.ImageForm;
    {$endif}
    MinButtonGlyph        := Src.MinButtonGlyph;
    CloseButtonGlyph      := Src.CloseButtonGlyph;
    InvertMinButtonArrows := Src.InvertMinButtonArrows;
    AutoSize              := Src.AutoSize;
    {$ifndef ELADVPANEL_NO_CHECKBOX}
    ShowCheckBox          := Src.ShowCheckBox;
    CheckBoxChecked       := Src.CheckBoxChecked;
    {$endif}
    Flat                  := Src.Flat;
    FlatAlways            := Src.FlatAlways;
  end
  else inherited Assign(Source);
end;

procedure TElPanelCaptionSettings.SetMinButtonGlyph(Value: TBitmap);
begin
  FOwner.FMinButtonGlyph.Assign(Value);
  FOwner.FImages.Clear;
  if Assigned(Value) and (not Value.Empty) then
  begin
    FOwner.FImages.Width := Value.Width div 2;
    FOwner.FImages.Height := Value.Height;
    FOwner.FImages.AddMasked(Value, Value.Canvas.Pixels[0, Value.Height - 1]);
  end
  else
  begin
    FOwner.FImages.Width := 7;
    FOwner.FImages.Height := 5;
  end;
end;

function TElPanelCaptionSettings.GetCloseButtonGlyph: TBitmap;
begin
  Result := FOwner.FCloseButton.Glyph;
end;

procedure TElPanelCaptionSettings.SetCloseButtonGlyph(Value: TBitmap);
begin
  FOwner.FCloseButton.Glyph := Value;
end;

procedure TElPanelCaptionSettings.SetInvertMinButtonArrows(Value: Boolean);
begin
  if FInvertMinButtonArrows <> Value then
  begin
    FInvertMinButtonArrows := Value;
    if not (csLoading in FOwner.ComponentState) then
      FOwner.UpdateMinButtonImages;
  end;
end;

procedure TElPanelCaptionSettings.SetAutoSize(Value: Boolean);
begin
  if FAutoSize <> Value then
  begin
    FAutoSize := Value;
    if AutoSize then
      AdjustHeight;
  end;
end;

procedure TElPanelCaptionSettings.FontChanged;
begin
  if AutoSize then AdjustHeight;
end;

procedure TElPanelCaptionSettings.AdjustHeight;
var
  DC: HDC;
  SaveFont: HFont;
  SysMetrics, Metrics: TTextMetric;
begin
  DC := GetDC(0);
  GetTextMetrics(DC, SysMetrics);
  SaveFont := SelectObject(DC, Font.Handle);
  GetTextMetrics(DC, Metrics);
  SelectObject(DC, SaveFont);
  ReleaseDC(0, DC);

  Height := Max(Metrics.tmHeight, FButtonWidth) + Margin * 2;
end;

procedure TElPanelCaptionSettings.SetFlat(Value: Boolean);
begin
  if FFlat <> Value then
  begin
    FFlat := Value;
    FOwner.FMinButton.Flat := Value;
    FOwner.FCloseButton.Flat := Value;
    {$ifndef ELADVPANEL_NO_CHECKBOX}
    FOwner.FCheckBox.flat := Value;
    {$endif}
  end;
end;

procedure TElPanelCaptionSettings.SetFlatAlways(Value: Boolean);
begin
  if FFlatAlways <> Value then
  begin
    FFlatAlways := Value;
    FOwner.FMinButton.ThinFrame := Value;
    FOwner.FCloseButton.ThinFrame := Value;
    {$ifndef ELADVPANEL_NO_CHECKBOX}
    FOwner.FCheckBox.FlatAlways := Value;
    {$endif}
  end;
end;


function TElPanelCaptionSettings.GetText: TElFString;
begin
  Result := FOwner.FCaptionPanel.Caption;
end;

procedure TCustomElAdvancedPanel.SetMinimized(Value: Boolean);
//var R : TRect;
begin
  if FMinimized <> Value then
  begin
    if FCaptionSettings.Visible or Value then
    begin
      if Value then
      begin
        {
        R := ClientRect;
        inherited AdjustClientRect(R);
        }
        FSaveHeight := Height;
        FMinimized := Value;
        {$ifdef VCL_4_USED}
        if (Parent <> nil) and (Parent.ClassType = TCustomDockForm) then
          Parent.Height := GetCaptionHeight + GetBevelAdjustment + (Parent.Height - Parent.ClientHeight)
        else
        {$endif}
          Height := GetCaptionHeight + GetBevelAdjustment;
        TriggerMinimizeEvent;
      end
      else
      begin
        FMinimized := Value;
        {$ifdef VCL_4_USED}
        if (Parent <> nil) and (Parent.ClassType = TCustomDockForm) then
          Parent.Height := FSaveHeight + (Parent.Height - Parent.ClientHeight)
        else
        {$endif}
          Height := FSaveHeight;
        TriggerRestoreEvent;
      end;

      UpdateMinButtonImages;
      Realign;
    end;
  end;
end;

procedure TCustomElAdvancedPanel.WMSize(var Message: TMessage);
var R : TRect;
begin
  inherited;

  R := ClientRect;
  inherited AdjustClientRect(R);
  AdjustInnerSize(R);

  if Minimized and (Height <> GetCaptionHeight + GetBevelAdjustment) then
  if not (csDesigning in ComponentState) then
  begin
    FMinimized := false;
    FSaveHeight := Height;
    UpdateMinButtonImages;
    TriggerRestoreEvent;
  end;
end;

procedure TCustomElAdvancedPanel.SetCaptionSettings(Value: TElPanelCaptionSettings);
begin
  FCaptionSettings.Assign(Value);
end;

constructor TCustomElAdvancedPanel.Create(AOwner : TComponent);
begin
  inherited;
  FCaptionSettings := TElPanelCaptionSettings.Create(Self);

  FCaptionPanel := CreatePanel;
  FCaptionPanel.Parent := Self;
  FCaptionPanel.TabStop := true;
  FCaptionPanel.OnImageNeeded := TriggerImageNeededEvent;
  FCaptionPanel.OnLinkClick := LinkClickEventTransfer;
  FCaptionPanel.OnClick := DoClick;
  FCaptionPanel.OnDblClick := DoDblClick;

  BevelInner := bvNone;
  BevelOuter := bvNone;

  FMinButton := CreateButton;
  FCloseButton := CreateButton;
  {$ifndef ELADVPANEL_NO_CHECKBOX}
  FCheckBox := CreateCheckbox;
  {$endif}
  FMinButton.Parent := FCaptionPanel;
  FMinButton.OnClick := OnMinButtonClick;
  FMinButton.Flat := true;
  FMinButton.ThinFrame := true;
  FCloseButton.Parent := FCaptionPanel;
  FCloseButton.OnClick := OnCloseButtonClick;
  FCloseButton.Flat := true;
  FCloseButton.ThinFrame := true;

  FCaptionPanel.OnResize := OnCaptionSize;
  FCaptionPanel.Height := 19;

  FImages := TImageList.Create(Self);
  FMinButtonGlyph := TBitmap.Create;

  FCloseButton.Glyph := CloseBmp;
  CaptionSettings.LoadDefaultMinButton;

  FCaptionPanel.BoundsRect := Rect(0, 0, Width, GetCaptionHeight);

  {$ifndef ELADVPANEL_NO_CHECKBOX}
  FCheckBox.Parent := FCaptionPanel;
  FCheckBox.Visible := false;
  FCheckBox.Left := Margin;
  FCheckBox.Top:= Margin;
  FCheckBox.Width := FCheckBox.Height;
  FCheckBox.Flat := true;
  FCheckBox.OnClick := DoClick;
  FCheckBox.OnDblClick := DoDblClick;
  {$endif}

  AdjustButtonSize;
end;

destructor TCustomElAdvancedPanel.Destroy;
begin
  FCloseButton.Free;
  FCloseButton := nil;
  FMinButton.Free;
  FMinButton := nil;
  {$ifndef ELADVPANEL_NO_CHECKBOX}
  FCheckBox.Free;
  FCheckBox := nil;
  {$endif}
  FCaptionSettings.Free;
  FCaptionSettings := nil;
  FMinButtonGlyph.Free;
  FMinButtonGlyph := nil;
  inherited;
end;

procedure TCustomElAdvancedPanel.TriggerMinimizeEvent;
begin
  if assigned(FOnMinimize) then FOnMinimize(Self);
end;

procedure TCustomElAdvancedPanel.TriggerRestoreEvent;
begin
  if assigned(FOnRestore) then FOnRestore(Self);
end;

procedure TCustomElAdvancedPanel.OnMinButtonClick(Sender : TObject);
begin
  if not (csDesigning in ComponentState) then
    Minimized := not Minimized;
end;

procedure TCustomElAdvancedPanel.OnCloseButtonClick(Sender : TObject);
var CanClose : boolean;
begin
  if not (csDesigning in ComponentState) then
  begin
    CanClose := true;
    TriggerCloseQueryEvent(CanClose);
    if CanClose then
    begin
      TriggerCloseEvent;
      Hide;
    end;
  end;
end;

procedure TCustomElAdvancedPanel.OnCaptionSize(Sender : TObject);
begin
  AdjustButtonSize;
end;

procedure TCustomElAdvancedPanel.AdjustButtonSize;
var R : TRect;
    bw : integer;
begin
  bw := GetButtonWidth;
  R := Rect(FCaptionPanel.Width - bw - Margin, Margin,
            FCaptionPanel.Width - Margin, Margin + bw);
  FCloseButton.BoundsRect := R;

  R := Rect(FCaptionPanel.Width - bw - Margin, Margin,
            FCaptionPanel.Width - Margin, Margin + bw);

  if FCaptionSettings.ShowCloseButton then
    OffsetRect(R, - (bw + Margin), 0);
  FMinButton.BoundsRect := R;

  {$ifndef ELADVPANEL_NO_CHECKBOX}
  R := Rect(0, 0, CheckBoxSize, CheckBoxSize);
  OffsetRect(R, Margin, (FCaptionPanel.Height - Margin * 2 - CheckBoxSize) div 2);
  FCheckBox.BoundsRect := R;
  {$endif}
end;

procedure TCustomElAdvancedPanel.TriggerCloseEvent;
begin
  if assigned(FOnClose) then FOnClose(Self);
end;

procedure TCustomElAdvancedPanel.AdjustClientRect(var Rect : TRect);
begin
  inherited;
  if FCaptionSettings.Visible then
  begin
    inc(Rect.Top, GetCaptionHeight);
  end;
end;

procedure TCustomElAdvancedPanel.CreateWnd;
var R : TRect;
begin
  inherited;
  TElAdvCaptionPanel(FCaptionPanel).SetDesigning(false);
  if IsThemeApplied then
  begin
    R := ClientRect;
    inherited AdjustClientRect(R);
    AdjustInnerSize(R);
  end;
end;

procedure TCustomElAdvancedPanel.WMNCHitTest(var Msg : TMessage);
var P : TPoint;
begin
  inherited;
  if Movable and FCaptionSettings.Visible and (not (csDesigning in ComponentState)) then
  begin
    P := ScreenToClient(SmallPointToPoint(TWMMouse(Msg).Pos));
    if (P.Y >= GetCaptionHeight) and (Msg.Result = HTCAPTION) then
      Msg.Result := HTNOWHERE;
  end;
end; {WMNCHitTest}

procedure TCustomElAdvancedPanel.LinkClickEventTransfer(Sender : TObject; HRef : TElFString);
begin
  TriggerLinkClickEvent(HRef);
end;

{$ifdef ELPACK_USE_IMAGEFORM}
procedure TCustomElAdvancedPanel.SetImageForm(newValue : TElImageForm);
begin
  inherited;
  // FCaptionPanel.ImageForm := newValue;
end;
{$endif}

procedure TCustomElAdvancedPanel.SetUseXPThemes(const Value: Boolean);
begin
  inherited;
  FCaptionPanel.UseXPThemes := Value;
  FCloseButton.UseXPThemes := Value;
  FMinButton.UseXPThemes := Value;
  if IsThemeApplied then
    SetBounds(Left, Top, Width, Height);
end;

procedure TCustomElAdvancedPanel.AdjustInnerSize(var R : TRect);
var ATheme : HTheme;
    //KindOffs: integer;
begin
  if IsThemeApplied then
  begin
    ATheme := OpenThemeData(Handle, 'GLOBALS');
    if ATheme <> 0 then
    begin
      if BevelOuter <> bvNone then
      begin
        InflateRect(R, BevelWidth, BevelWidth);
        GetThemeBackgroundContentRect(ATheme, 0, GP_BORDER, BSS_SUNKEN, R, R);
      end;
      if BevelInner <> bvNone then
      begin
        InflateRect(R, BevelWidth, BevelWidth);
        GetThemeBackgroundContentRect(ATheme, 0, GP_BORDER, BSS_SUNKEN, R, R);
      end;
      CloseThemeData(ATheme);
    end;
  end;
  //KindOffs := 0;

  InflateRect(R, BorderWidth, BorderWidth);
  TElAdvCaptionPanel(FCaptionPanel).DoResize := true;
  FCaptionPanel.BoundsRect := Rect(R.Left, R.Top, R.Right, R.Top + Min(GetCaptionHeight, R.Bottom - R.Top));
  TElAdvCaptionPanel(FCaptionPanel).DoResize := false;
  InflateRect(R, -BorderWidth, -BorderWidth);
end;

function TCustomElAdvancedPanel.GetBevelAdjustment: Integer;
begin
  Result := 0;
  if BevelOuter <> bvNone then
    inc(result, 2 * BevelWidth);
  if BevelInner <> bvNone then
    inc(result, 2 * BevelWidth);
end;

procedure TCustomElAdvancedPanel.UpdateMinButtonImages;
begin
  if Minimized xor FCaptionSettings.InvertMinButtonArrows then
    FMinButton.ImageIndex := 1
  else
    FMinButton.ImageIndex := 0;
end;

procedure TCustomElAdvancedPanel.Loaded;
begin
  inherited;
  UpdateMinButtonImages;
end;

procedure TCustomElAdvancedPanel.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('ExpandedHeight', ReadExpHeight, WriteExpHeight, true);
  with GetElReader do
   Filer.DefineProperty('Canvas', FakeValue, nil, False);
end;

procedure TCustomElAdvancedPanel.ReadExpHeight(Reader : TReader);
begin
  FSaveHeight := Reader.ReadInteger;
end;

procedure TCustomElAdvancedPanel.WriteExpHeight(Writer : TWriter);
var i : TValueType;
begin
  i := vaInt32;
  Writer.Write(i, SizeOf(i));
  Writer.Write(FSaveHeight, SizeOf(FSaveHeight));
end;

procedure TCustomElAdvancedPanel.SetLinkPopupMenu(newValue : TPopupMenu);
begin
  inherited;
  FCaptionPanel.LinkPopupMenu := newValue;
end;

procedure TCustomElAdvancedPanel.SetLinkColor(newValue : TColor);
begin
  inherited;
  FCaptionPanel.LinkColor := newValue;
end;

procedure TCustomElAdvancedPanel.SetLinkStyle(newValue : TFontStyles);
begin
  inherited;
  FCaptionPanel.LinkStyle := newValue;
end;

procedure TCustomElAdvancedPanel.SetTransparentXPThemes(Value: Boolean);
begin
  inherited;
  FCaptionPanel.TransparentXPThemes := Value;
end;

function TCustomElAdvancedPanel.CreateButton: TElAdvCaptionButton;
begin
  Result := TElAdvCaptionButton.Create(FCaptionPanel);
end;

{$ifndef ELADVPANEL_NO_CHECKBOX}
function TCustomElAdvancedPanel.CreateCheckbox: TElCheckBox;
begin
  Result := THackCheckBox.Create(FCaptionPanel);
end;
{$endif}

function TCustomElAdvancedPanel.CreatePanel: TElAdvCaptionPanel;
begin
  Result := TElAdvCaptionPanel.Create(Self);
end;

function TCustomElAdvancedPanel.GetThemePartID: Integer;
begin
  result := GP_BORDER;
end;

function TCustomElAdvancedPanel.GetButtonWidth: Integer;
begin
  Result := FCaptionSettings.FButtonWidth;
end;

function TCustomElAdvancedPanel.GetCaptionHeight: Integer;
begin
  if FCaptionSettings <> nil then
    result := FCaptionSettings.Height
  else
    result := 0;
end;

procedure TCustomElAdvancedPanel.UpdateInterior;
var R : TRect;
begin
  inherited;
  if HandleAllocated then
  begin
    R := ClientRect;
    inherited AdjustClientRect(R);
    AdjustInnerSize(R);
  end;
end;

procedure TCustomElAdvancedPanel.WMSetFocus(var Message: TMessage);
begin
  inherited;
  if TWMSetFocus(Message).FocusedWnd = FCaptionPanel.Handle then
    THackForm(GetParentForm(Self)).SelectNext(Self, false, True)
  else
    FCaptionPanel.SetFocus;
end;

procedure TCustomElAdvancedPanel.DoClick(Sender : TObject);
begin
  Click;
end;

function TCustomElAdvancedPanel.GetShowFocus: Boolean;
begin
  Result := FCaptionPanel.ShowFocus;
end;

procedure TCustomElAdvancedPanel.SetShowFocus(Value: Boolean);
begin
  FCaptionPanel.ShowFocus := Value;
end;

procedure TCustomElAdvancedPanel.DoDblClick(Sender : TObject);
begin
  DblClick;
end;

procedure TCustomElAdvancedPanel.TriggerCloseQueryEvent(var CanClose : boolean);
begin
  if assigned(FOnCloseQuery) then FOnCloseQuery(Self, CanClose);
end;

procedure TCustomElAdvancedPanel.ELThemeChanged(var Message: TMessage);
begin
  inherited;
  with FCaptionSettings do
    if AutoSize then
      AdjustHeight;
  AdjustButtonSize;
end;

procedure TElAdvCaptionButton.DrawThemedBackground;
begin
  inherited;
end;

constructor TElAdvCaptionButton.Create(AOwner : TComponent);
begin
  inherited;
  ParentColor := false;
end;

initialization

  CloseBmp := TBitmap.Create;
  UpArrowBmp := TBitmap.Create;
  DownArrowBmp:= TBitmap.Create;
  CloseBmp.LoadFromResourceName(HInstance, 'ELADVPANELCLOSEBUTTON');
  UpArrowBmp.LoadFromResourceName(HInstance, 'ELADVPANELUPARROW');
  DownArrowBmp.LoadFromResourceName(HInstance, 'ELADVPANELDOWNARROW');

finalization

  CloseBmp.Free;
  UpArrowBmp.Free;
  DownArrowBmp.Free;

end.
