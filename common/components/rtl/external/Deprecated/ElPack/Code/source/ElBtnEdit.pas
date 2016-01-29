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

02/26/2002

  Added ButtonTransparent and AltButtonTransparent properties

02/03/2002

  Fixed the problem with disappearing AltButton (caused by incorrect calculation
  of button size)

01/01/2002

  Fixed some problems with painting borders when focus is moved

10/12/2001

  ButtonThinFrame and AltButtonThinFrame added.

08/31/2001

  Buttons are of type TElGraphicButton now.

03/09/2001

  Fixed drawing artefacts on buttons.

01/17/2001

  Now AltButton can be located on the left side of the control

09/30/2000

  Ancestor changed to TCustomElFlatEdit

*)

unit ElBtnEdit; { TElButtonEdit component. }

interface

{$R 'elbtnedit.res'}

uses
{$ifdef MSWINDOWS}
  Windows,
  Messages,
  Graphics,
  Controls,
  StdCtrls,
  Forms,
{$ifdef VCL_6_USED}
Types,
{$endif}
  Menus,
{$else}
  QGraphics,
  QControls,
  Qt,
  Types,
  QStdCtrls,
  QForms,
{$endif}
  SysUtils,
  Classes,
  ElPopBtn,
  ElVCLUtils,
{$ifdef MSWINDOWS}
{$ifdef ELPACK_USE_IMAGEFORM}
  ElImgFrm,
{$endif}
(*
{$ifdef ELPACK_USE_STYLEMANAGER}
  ElStyleMan,
{$endif}
*)
  {$ifdef USE_SOUND_MAP}
  ElSndMap,
  {$endif}
{$endif}
  ElTools,
  ElEdits;

type

  TCustomElButtonEdit = class(TCustomElEdit)
  private
    FOnAltButtonClick : TNotifyEvent;
    FButtonShortcut : TShortcut;
    FAltButtonShortcut : TShortcut;
    FOnButtonClick : TNotifyEvent;
{$IFDEF USE_SOUND_MAP}
    procedure SetButtonClickSound(newValue : TElSoundName);
    function GetButtonClickSound : TElSoundName;
    procedure SetButtonDownSound(newValue : TElSoundName);
    function GetButtonDownSound : TElSoundName;
    procedure SetButtonSoundMap(newValue : TElSoundMap);
    function GetButtonSoundMap : TElSoundMap;
    procedure SetButtonUpSound(newValue : TElSoundName);
    function GetButtonUpSound : TElSoundName;
    procedure SetAltButtonClickSound(newValue : TElSoundName);
    function GetAltButtonClickSound : TElSoundName;
    procedure SetAltButtonUpSound(newValue : TElSoundName);
    function GetAltButtonUpSound : TElSoundName;
    procedure SetAltButtonSoundMap(newValue : TElSoundMap);
    function GetAltButtonSoundMap : TElSoundMap;
{$ENDIF}
    procedure SetButtonColor(newValue : TColor);
    function GetButtonColor : TColor;
    procedure SetButtonDown(newValue : Boolean);
    function GetButtonDown : Boolean;
    function GetButtonGlyph : TBitmap;
    procedure SetButtonHint(newValue : string);
    function GetButtonHint : string;
    procedure SetButtonIcon(newValue : TIcon);
    function GetButtonIcon : TIcon;
    procedure SetButtonNumGlyphs(newValue : integer);
    function GetButtonNumGlyphs : integer;
    procedure SetButtonUseIcon(newValue : Boolean);
    function GetButtonUseIcon : Boolean;
    procedure SetButtonWidth(newValue : Integer);
    function GetButtonWidth : Integer;
    procedure ButtonClickTransfer(Sender : TObject); { TNotifyEvent }
    procedure SetButtonVisible(newValue : Boolean);
    function GetButtonVisible : Boolean;
    procedure SetAltButtonDown(newValue : Boolean);
    function GetAltButtonDown : Boolean;
{$IFDEF USE_SOUND_MAP}
    procedure SetAltButtonDownSound(newValue : TElSoundName);
    function GetAltButtonDownSound : TElSoundName;
{$endif}
    procedure SetAltButtonFlat(newValue : Boolean);
    function GetAltButtonFlat : Boolean;
    procedure SetAltButtonGlyph(newValue : TBitmap);
    function GetAltButtonGlyph : TBitmap;
    procedure SetAltButtonIcon(newValue : TIcon);
    function GetAltButtonIcon : TIcon;
    procedure SetAltButtonNumGlyphs(newValue : integer);
    function GetAltButtonNumGlyphs : integer;
    procedure SetAltButtonUseIcon(newValue : Boolean);
    function GetAltButtonUseIcon : Boolean;
    procedure SetAltButtonVisible(newValue : Boolean);
    function GetAltButtonVisible : Boolean;
    procedure SetAltButtonWidth(newValue : Integer);
    function GetAltButtonWidth : Integer;
    procedure AltButtonClickTransfer(Sender : TObject); { TNotifyEvent }
    procedure SetButtonFlat(newValue : Boolean);
    function GetButtonFlat : Boolean;
    procedure SetAltButtonEnabled(newValue : Boolean);
    function GetAltButtonEnabled : Boolean;
    procedure SetButtonEnabled(newValue : Boolean);
    function GetButtonEnabled : Boolean;
    procedure CMEnabledChanged(var Msg : TMessage); message CM_ENABLEDCHANGED;
    procedure SetAltButtonHint(newValue : String);
    function GetAltButtonHint : String;
    procedure SetAltButtonPopupPlace(newValue : TPopupPlace);
    function GetAltButtonPopupPlace : TPopupPlace;
    procedure SetAltButtonPullDownMenu(newValue : TPopupMenu);
    function GetAltButtonPullDownMenu : TPopupMenu;
    procedure SetButtonPopupPlace(newValue : TPopupPlace);
    function GetButtonPopupPlace : TPopupPlace;
    procedure SetButtonPullDownMenu(newValue : TPopupMenu);
    function GetButtonPullDownMenu : TPopupMenu;
    procedure SetAltButtonCaption(newValue : TCaption);
    function GetAltButtonCaption : TCaption;
    procedure SetButtonCaption(newValue : TCaption);
    function GetButtonCaption : TCaption;
    procedure SetAltBtnAlign(newValue : TLeftRight);
    procedure WMGetDlgCode(var Msg : TWMGetDlgCode); message WM_GETDLGCODE;
  protected
    { Protected declarations }
    FAltButton : TCustomElGraphicButton;
    FButton    : TCustomElGraphicButton;
    FAltBtnAlign : TLeftRight;
    ButtonClass : TCustomElGraphicButtonClass;
    FButtonIsSwitch: Boolean;
    FAltButtonIsSwitch: Boolean;

    procedure WMSize(var Msg : TWMSize); message WM_Size;
    procedure KeyPress(var Key : Char); override;
    procedure KeyDown(var Key : Word; Shift : TShiftState); override;
    procedure SetEditRect(Value : TRect); override;
    procedure WMKeyDown(var Message: TWMKey); message WM_KEYDOWN;
    function GetAltButtonColor: TColor;
    procedure SetAltButtonColor(Value: TColor);
    function GetButtonThinFrame: Boolean;
    procedure SetButtonThinFrame(Value: Boolean);
    function GetAltButtonThinFrame: Boolean;
    procedure SetAltButtonThinFrame(Value: Boolean);
    procedure SetUseXPThemes(const Value : boolean); override;
    procedure UpdateButtonStyles;
    procedure SetActiveBorderType(const Value: TElFlatBorderType); override;
    procedure SetFlat(const Value: boolean); override;
    procedure SetInactiveBorderType(const Value: TElFlatBorderType); override;
    procedure SetLineBorderActiveColor(Value: TColor); override;
    procedure SetLineBorderInactiveColor(Value: TColor); override;
    function GetButtonTransparent: Boolean;
    procedure SetButtonTransparent(Value: Boolean);
    function GetAltButtonTransparent: Boolean;
    procedure SetAltButtonTransparent(Value: Boolean);
    function GetButtonIsSwitch: Boolean;
    procedure SetButtonIsSwitch(Value: Boolean);
    function GetAltButtonIsSwitch: Boolean;
    procedure SetAltButtonIsSwitch(Value: Boolean);
    procedure SetButtonGlyph(newValue : TBitmap); virtual;
    function GetButtonShowBorder: Boolean;
    procedure SetButtonShowBorder(Value: Boolean);
    function GetAltButtonShowBorder: Boolean;
    procedure SetAltButtonShowBorder(Value: Boolean);
    function GetButtonOldStyled: Boolean;
    procedure SetButtonOldStyled(Value: Boolean);
    function GetAltButtonOldStyled: Boolean;
    procedure SetAltButtonOldStyled(Value: Boolean);
    (*
    {$ifdef ELPACK_USE_STYLEMANAGER}
    procedure SetStyleManager(Value: TElStyleManager); override;
    procedure SetStyleName(const Value: string); override;
    {$endif}
    *)
    property ButtonCaption : TCaption read GetButtonCaption write SetButtonCaption;
    {$IFDEF USE_SOUND_MAP}
    property ButtonClickSound : TElSoundName read GetButtonClickSound write SetButtonClickSound;
    property ButtonDownSound : TElSoundName read GetButtonDownSound write SetButtonDownSound;
    {$endif}
    property ButtonColor : TColor read GetButtonColor write SetButtonColor default clBtnFace;
    property ButtonDown : Boolean read GetButtonDown write SetButtonDown default false;
    property ButtonFlat : Boolean read GetButtonFlat write SetButtonFlat default false;
    property ButtonGlyph : TBitmap read GetButtonGlyph write SetButtonGlyph;
    property ButtonHint : string read GetButtonHint write SetButtonHint;
    property ButtonIcon : TIcon read GetButtonIcon write SetButtonIcon;
    property ButtonNumGlyphs : integer read GetButtonNumGlyphs write SetButtonNumGlyphs default 1;
    property ButtonPopupPlace : TPopupPlace read GetButtonPopupPlace write SetButtonPopupPlace;
    property ButtonPullDownMenu : TPopupMenu read GetButtonPullDownMenu write SetButtonPullDownMenu;
{$IFDEF USE_SOUND_MAP}
    property ButtonSoundMap : TElSoundMap read GetButtonSoundMap write SetButtonSoundMap;
    property ButtonUpSound : TElSoundName read GetButtonUpSound write SetButtonUpSound;
{$endif}
    property ButtonUseIcon : Boolean read GetButtonUseIcon write SetButtonUseIcon default false;
    property ButtonWidth : Integer read GetButtonWidth write SetButtonWidth;
    property ButtonEnabled : Boolean read GetButtonEnabled write SetButtonEnabled default true;
    property ButtonThinFrame: Boolean read GetButtonThinFrame write
        SetButtonThinFrame default false;
    property ButtonTransparent: Boolean read GetButtonTransparent write
        SetButtonTransparent default false;
    property ButtonIsSwitch: Boolean read GetButtonIsSwitch write SetButtonIsSwitch
        default false;

    property OnButtonClick : TNotifyEvent read FOnButtonClick write FOnButtonClick;
    property OnAltButtonClick : TNotifyEvent read FOnAltButtonClick write FOnAltButtonClick;

    property ButtonShortcut : TShortcut read FButtonShortcut write FButtonShortcut; { Published }
    property AltButtonShortcut : TShortcut read FAltButtonShortcut write FAltButtonShortcut; { Published }
    property ButtonVisible : Boolean read GetButtonVisible write SetButtonVisible default true;
    property AltButtonCaption : TCaption read GetAltButtonCaption write SetAltButtonCaption;
{$IFDEF USE_SOUND_MAP}
    property AltButtonClickSound : TElSoundName read GetAltButtonClickSound write SetAltButtonClickSound;
    property AltButtonDownSound : TElSoundName read GetAltButtonDownSound write SetAltButtonDownSound;
    property AltButtonSoundMap : TElSoundMap read GetAltButtonSoundMap write SetAltButtonSoundMap;
    property AltButtonUpSound : TElSoundName read GetAltButtonUpSound write SetAltButtonUpSound;
{$ENDIF}
    property AltButtonColor: TColor read GetAltButtonColor write SetAltButtonColor default clbtnface;
    property AltButtonDown : Boolean read GetAltButtonDown write SetAltButtonDown default false;
    property AltButtonFlat : Boolean read GetAltButtonFlat write SetAltButtonFlat default false;
    property AltButtonGlyph : TBitmap read GetAltButtonGlyph write SetAltButtonGlyph;
    property AltButtonHint : String read GetAltButtonHint write SetAltButtonHint;
    property AltButtonIcon : TIcon read GetAltButtonIcon write SetAltButtonIcon;
    property AltButtonNumGlyphs : integer read GetAltButtonNumGlyphs write SetAltButtonNumGlyphs;
    property AltButtonPopupPlace : TPopupPlace read GetAltButtonPopupPlace write SetAltButtonPopupPlace;
    property AltButtonPosition : TLeftRight read FAltBtnAlign write SetAltBtnAlign default taRightJustify;
    property AltButtonPullDownMenu : TPopupMenu read GetAltButtonPullDownMenu write SetAltButtonPullDownMenu;
    property AltButtonUseIcon : Boolean read GetAltButtonUseIcon write SetAltButtonUseIcon default false;
    property AltButtonVisible : Boolean read GetAltButtonVisible write SetAltButtonVisible default false;
    property AltButtonWidth : Integer read GetAltButtonWidth write SetAltButtonWidth;
    property AltButtonEnabled : Boolean read GetAltButtonEnabled write SetAltButtonEnabled default true;
    property AltButtonIsSwitch: Boolean read GetAltButtonIsSwitch write
        SetAltButtonIsSwitch default false;
    property AltButtonThinFrame: Boolean read GetAltButtonThinFrame write
        SetAltButtonThinFrame default false;
    property AltButtonTransparent: Boolean read GetAltButtonTransparent write
        SetAltButtonTransparent default false;
    property ButtonShowBorder: Boolean read GetButtonShowBorder write
        SetButtonShowBorder default true;
    property AltButtonShowBorder: Boolean read GetAltButtonShowBorder write
        SetAltButtonShowBorder default true;
    property ButtonOldStyled: Boolean read GetButtonOldStyled write
        SetButtonOldStyled default false;
    property AltButtonOldStyled: Boolean read GetAltButtonOldStyled write
        SetAltButtonOldStyled default false;
  public
    { Public declarations }

    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
  end; { TCustomElButtonEdit }

  TElButtonEdit = class(TCustomElButtonEdit)

    property AlignBottom;
    property CharCase;
    property TopMargin;
    property LeftMargin;
    property RightMargin;
    property AutoSize;
    property RightAlignedView;
    property BorderSides;
    property PasswordChar;
    property MaxLength;
    property Transparent;
    property FlatFocusedScrollBars;
    property WantTabs;
    property HandleDialogKeys;
    property FocusedSelectColor;
    property FocusedSelectTextColor;
    property HideSelection;
    property HideSelectColor;
    property HideSelectTextColor;
    property HighlightAlphaLevel;

    property TabSpaces;
    property Lines stored false;
    property LinkedControl;
    property LinkedControlPosition;
    property LinkedControlSpacing;
    property UseDisabledColors;
    property DisabledColor;
    property DisabledFontColor;

    {$IFDEF ELPACK_USE_IMAGEFORM}
    property ImageForm;
    {$endif}
    property WordWrap;
    property ScrollBars;

    property OnMouseEnter;
    property OnMouseLeave;
    property OnResize;
    property OnChange;
    property OnSelectionChange;

    property Text;
    property Multiline;

(*    property VertScrollBarStyles;
    property HorzScrollBarStyles;*) // <trash> // LAW
    property UseCustomScrollBars;

    // inherited
    property Flat;
    property ActiveBorderType;
    property InactiveBorderType;
    property LineBorderActiveColor;
    property LineBorderInactiveColor;

    property UseBackground;
    property UseSystemMenu;

    property Alignment;
    property AutoSelect;

    property Background;
    property ButtonCaption;
{$IFDEF USE_SOUND_MAP}
    property ButtonClickSound;
    property ButtonDownSound;
    property ButtonUpSound;
    property ButtonSoundMap;
{$ENDIF}
    property ButtonColor;
    property ButtonDown;
    property ButtonEnabled;
    property ButtonFlat;
    property ButtonGlyph;
    property ButtonHint;
    property ButtonIcon;
    property ButtonIsSwitch;
    property ButtonNumGlyphs;
    property ButtonOldStyled;
    property ButtonPopupPlace;
    property ButtonPullDownMenu;
    property ButtonShowBorder;
    property ButtonShortcut;
    property ButtonTransparent;
    property ButtonThinFrame;
    property ButtonUseIcon;
    property ButtonVisible;
    property ButtonWidth;
    property OnButtonClick;

    property AltButtonCaption;
{$IFDEF USE_SOUND_MAP}
    property AltButtonClickSound;
    property AltButtonDownSound;
    property AltButtonUpSound;
    property AltButtonSoundMap;
{$ENDIF}
    property AltButtonColor;
    property AltButtonDown;
    property AltButtonEnabled;
    property AltButtonFlat;
    property AltButtonGlyph;
    property AltButtonHint;
    property AltButtonIsSwitch;
    property AltButtonIcon;
    property AltButtonNumGlyphs;
    property AltButtonOldStyled;
    property AltButtonPopupPlace;
    property AltButtonPosition;
    property AltButtonPullDownMenu;
    property AltButtonShortcut;
    property AltButtonThinFrame;
    property AltButtonTransparent;
    property AltButtonUseIcon;
    property AltButtonShowBorder;
    property AltButtonVisible;
    property AltButtonWidth;
    property OnAltButtonClick;

    // VCL properties
    property BorderStyle;
    property Ctl3D;
    property ParentCtl3D;
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
    property ReadOnly;

    property OnEnter;
    property OnExit;
    property OnClick;
    property OnDblClick;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnStartDrag;
    property OnDragDrop;
    property OnDragOver;
    {$IFDEF VCL_4_USED}
    property OnEndDock;
    {$ENDIF}
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
{$IFDEF VCL_4_USED}
    property OnStartDock;
{$ENDIF}
  {$IFDEF VCL_5_USED}
    property OnContextPopup;
  {$ENDIF}

{$IFDEF VCL_4_USED}
    property Anchors;
    property Constraints;
    property DockOrientation;
    property Floating;
    property DoubleBuffered;
    property DragKind;
{$ENDIF}
  end;

implementation

type
  TElEditBtn = class(TCustomElGraphicButton);

{$IFDEF USE_SOUND_MAP}
procedure TCustomElButtonEdit.SetButtonClickSound(newValue : TElSoundName);
{ Sets the FButton subcomponent's ClickSound property to newValue. }
begin
  TElEditBtn(FButton).ClickSound := newValue;
end; { SetButtonClickSound }

function TCustomElButtonEdit.GetButtonClickSound : TElSoundName;
{ Returns the ClickSound property from the FButton subcomponent. }
begin
  GetButtonClickSound := TElEditBtn(FButton).ClickSound;
end; { GetButtonClickSound }
{$endif}

procedure TCustomElButtonEdit.SetButtonColor(newValue : TColor);
{ Sets the FButton subcomponent's Color property to newValue. }
begin
  TElEditBtn(FButton).Color := newValue;
end; { SetButtonColor }

function TCustomElButtonEdit.GetButtonColor : TColor;
{ Returns the Color property from the FButton subcomponent. }
begin
  GetButtonColor := TElEditBtn(FButton).Color;
end; { GetButtonColor }

procedure TCustomElButtonEdit.SetButtonDown(newValue : Boolean);
{ Sets the FButton subcomponent's Down property to newValue. }
begin
  TElEditBtn(FButton).Down := newValue;
end; { SetButtonDown }

function TCustomElButtonEdit.GetButtonDown : Boolean;
{ Returns the Down property from the FButton subcomponent. }
begin
  GetButtonDown := TElEditBtn(FButton).Down;
end; { GetButtonDown }

{$IFDEF USE_SOUND_MAP}
procedure TCustomElButtonEdit.SetButtonDownSound(newValue : TElSoundName);
{ Sets the FButton subcomponent's DownSound property to newValue. }
begin
  TElEditBtn(FButton).DownSound := newValue;
end; { SetButtonDownSound }

function TCustomElButtonEdit.GetButtonDownSound : TElSoundName;
{ Returns the DownSound property from the FButton subcomponent. }
begin
  GetButtonDownSound := TElEditBtn(FButton).DownSound;
end; { GetButtonDownSound }
{$endif}

procedure TCustomElButtonEdit.SetButtonGlyph(newValue : TBitmap);
{ Sets the FButton subcomponent's Glyph property to newValue. }
begin
  TElEditBtn(FButton).Glyph := newValue;
end; { SetButtonGlyph }

function TCustomElButtonEdit.GetButtonGlyph : TBitmap;
{ Returns the Glyph property from the FButton subcomponent. }
begin
  GetButtonGlyph := TElEditBtn(FButton).Glyph;
end; { GetButtonGlyph }

procedure TCustomElButtonEdit.SetButtonHint(newValue : string);
{ Sets the FButton subcomponent's Hint property to newValue. }
begin
  TElEditBtn(FButton).Hint := newValue;
end; { SetButtonHint }

function TCustomElButtonEdit.GetButtonHint : string;
{ Returns the Hint property from the FButton subcomponent. }
begin
  GetButtonHint := TElEditBtn(FButton).Hint;
end; { GetButtonHint }

procedure TCustomElButtonEdit.SetButtonIcon(newValue : TIcon);
{ Sets the FButton subcomponent's Icon property to newValue. }
begin
  TElEditBtn(FButton).Icon := newValue;
end; { SetButtonIcon }

function TCustomElButtonEdit.GetButtonIcon : TIcon;
{ Returns the Icon property from the FButton subcomponent. }
begin
  GetButtonIcon := TElEditBtn(FButton).Icon;
end; { GetButtonIcon }

procedure TCustomElButtonEdit.SetButtonNumGlyphs(newValue : integer);
{ Sets the FButton subcomponent's NumGlyphs property to newValue. }
begin
  TElEditBtn(FButton).NumGlyphs := newValue;
end; { SetButtonNumGlyphs }

function TCustomElButtonEdit.GetButtonNumGlyphs : integer;
{ Returns the NumGlyphs property from the FButton subcomponent. }
begin
  GetButtonNumGlyphs := TElEditBtn(FButton).NumGlyphs;
end; { GetButtonNumGlyphs }

{$IFDEF USE_SOUND_MAP}
procedure TCustomElButtonEdit.SetButtonSoundMap(newValue : TElSoundMap);
{ Sets the FButton subcomponent's SoundMap property to newValue. }
begin
  TElEditBtn(FButton).SoundMap := newValue;
end; { SetButtonSoundMap }

function TCustomElButtonEdit.GetButtonSoundMap : TElSoundMap;
{ Returns the SoundMap property from the FButton subcomponent. }
begin
  GetButtonSoundMap := TElEditBtn(FButton).SoundMap;
end; { GetButtonSoundMap }
{$endif}

{$IFDEF USE_SOUND_MAP}
procedure TCustomElButtonEdit.SetButtonUpSound(newValue : TElSoundName);
{ Sets the FButton subcomponent's UpSound property to newValue. }
begin
  TElEditBtn(FButton).UpSound := newValue;
end; { SetButtonUpSound }

function TCustomElButtonEdit.GetButtonUpSound : TElSoundName;
{ Returns the UpSound property from the FButton subcomponent. }
begin
  GetButtonUpSound := TElEditBtn(FButton).UpSound;
end; { GetButtonUpSound }
{$endif}

procedure TCustomElButtonEdit.SetButtonUseIcon(newValue : Boolean);
{ Sets the FButton subcomponent's UseIcon property to newValue. }
begin
  TElEditBtn(FButton).UseIcon := newValue;
end; { SetButtonUseIcon }

function TCustomElButtonEdit.GetButtonUseIcon : Boolean;
{ Returns the UseIcon property from the FButton subcomponent. }
begin
  GetButtonUseIcon := TElEditBtn(FButton).UseIcon;
end; { GetButtonUseIcon }

procedure TCustomElButtonEdit.SetButtonWidth(newValue : Integer);
{ Sets the FButton subcomponent's Width property to newValue. }
begin
  FButton.Width := newValue;
  if FButton.Visible and HandleAllocated then
  begin
    SetEditRect(ClientRect);
    Invalidate;
  end;
end; { SetButtonWidth }

function TCustomElButtonEdit.GetButtonWidth : Integer;
{ Returns the Width property from the FButton subcomponent. }
begin
  GetButtonWidth := FButton.Width;
end; { GetButtonWidth }

procedure TCustomElButtonEdit.ButtonClickTransfer(Sender : TObject);
{ Transfers FButton OnClick event to the outside world. }
begin
  if (assigned(FOnButtonClick)) then
    FOnButtonClick(Self); { Substitute Self for subcomponent's Sender. }
end; { ButtonClickTransfer }

procedure TCustomElButtonEdit.WMSize(var Msg : TWMSize);
begin
  inherited;
end; { WMSize }

procedure TCustomElButtonEdit.SetEditRect(Value : TRect);
var
  Loc : TRect;
  HOffs,
  VOffs: integer;
begin
  if (not HandleAllocated) or (csDestroying in ComponentState) then
  begin
    inherited;
    exit;
  end;

  HOffs := 0;
  VOffs := 0;
  if (BorderStyle = bsSingle) and (not Ctl3D) then
  begin
    Hoffs := GetSystemMetrics(SM_CYBORDER);
    Voffs := GetSystemMetrics(SM_CXBORDER);
  end;
  if FButton.Visible then
  begin
    if FMultiLine then
    begin
      FButton.BoundsRect := Rect(ClientWidth - FButton.Width - HOffs, VOffs, ClientWidth - HOffs, Min(FButton.Width, ClientHeight - VOffs))
    end
    else
      FButton.BoundsRect := Rect(ClientWidth - FButton.Width- HOffs, VOffs, ClientWidth - HOffs, ClientHeight - VOffs);
  end;
  if FAltButton.Visible then
  begin
    if FButton.Visible then
    begin
      if FMultiLine then
        if FAltBtnAlign = taLeftJustify then
          FAltButton.BoundsRect := Rect(HOffs, VOffs, HOffs + FAltButton.Width, Min(FAltButton.Width, ClientHeight - VOffs))
        else
          FAltButton.BoundsRect := Rect(ClientWidth - FButton.Width - FAltButton.Width - HOffs, VOffs, ClientWidth - FButton.Width - HOffs, Min(FAltButton.Width, ClientHeight - VOffs))
      else
        if FAltBtnAlign = taLeftJustify then
          FAltButton.BoundsRect := Rect(HOffs, VOffs, HOffs + FAltButton.Width, ClientHeight - VOffs)
        else
          FAltButton.BoundsRect := Rect(ClientWidth - FButton.Width - FAltButton.Width - HOffs, VOffs, ClientWidth - FButton.Width - HOffs, ClientHeight- VOffs);
    end
    else
    begin
      if FMultiLine then
        if FAltBtnAlign = taLeftJustify then
          FAltButton.BoundsRect := Rect(HOffs, VOffs, FButton.Width, Min(FAltButton.Width, ClientHeight- VOffs))
        else
          FAltButton.BoundsRect := Rect(ClientWidth - FButton.Width - hOffs, VOffs, ClientWidth, Min(FAltButton.Width, ClientHeight- VOffs))
      else
        if FAltBtnAlign = taLeftJustify then
          FAltButton.BoundsRect := Rect(HOffs, VOffs, FAltButton.Width, ClientHeight - VOffs)
        else
          FAltButton.BoundsRect := Rect(ClientWidth - FAltButton.Width - HOffs, VOffs, ClientWidth, ClientHeight - VOffs);
    end;
  end;

  SetRect(Loc, HOffs, VOffs, ClientWidth - HOffs, ClientHeight - VOffs);
  if FButton.Visible then
    Dec(Loc.Right, FButton.Width);
  if FAltButton.Visible then
  begin
    if FAltBtnAlign = taLeftJustify then
      inc(Loc.Left, FAltButton.Width{ + 2})
    else
      Dec(Loc.Right, FAltButton.Width{ + 2});
  end;
  inherited SetEditRect(Loc);
(*  if UseCustomScrollbars and Multiline and scbVert.Visible then
  begin
    if not (RightAlignedView) then
    begin
      if FButton.Visible then
        FButton.Left := FButton.Left - scbVert.Width;
      if FAltButton.Visible and (FAltBtnAlign = taRightJustify) then
        FAltButton.Left := FAltButton.Left - scbVert.Width;
    end
    else
    begin
      if FAltButton.Visible and (FAltBtnAlign = taLeftJustify) then
        FAltButton.Left := FAltButton.Left + scbVert.Width;
    end;
  end;*) // <trash> // LAW
end;

procedure TCustomElButtonEdit.KeyPress(var Key : Char); { protected }
begin
  if (Key = Char(VK_RETURN)) or (Key = Char(VK_ESCAPE)) then
  begin
    {if HandleDialogKeys then
       GetParentForm(Self).Perform(CM_DIALOGKEY, Byte(Key), 0);
    }if Key = Char(VK_RETURN) then
    begin
      inherited KeyPress(Key);
      if not Multiline then
         Key := #0;
      Exit;
    end;
  end;
  inherited KeyPress(Key);
end; { KeyPress }

{ Exposed properties' Read/Write methods: }

procedure TCustomElButtonEdit.SetButtonVisible(newValue : Boolean);
{ Sets the FButton subcomponent's Visible property to newValue. }
begin
  FButton.Visible := newValue;
  if HandleAllocated then
  begin
    SetEditRect(ClientRect);
    Invalidate;
  end;
end; { SetButtonVisible }

function TCustomElButtonEdit.GetButtonVisible : Boolean;
{ Returns the Visible property from the FButton subcomponent. }
begin
  GetButtonVisible := FButton.Visible;
end; { GetButtonVisible }

{$IFDEF USE_SOUND_MAP}
procedure TCustomElButtonEdit.SetAltButtonClickSound(newValue : TElSoundName);
{ Sets the FAltButton subcomponent's ClickSound property to newValue. }
begin
  TElEditBtn(FAltButton).ClickSound := newValue;
end; { SetAltButtonClickSound }

function TCustomElButtonEdit.GetAltButtonClickSound : TElSoundName;
{ Returns the ClickSound property from the FAltButton subcomponent. }
begin
  GetAltButtonClickSound := TElEditBtn(FAltButton).ClickSound;
end; { GetAltButtonClickSound }
{$endif}

procedure TCustomElButtonEdit.SetAltButtonDown(newValue : Boolean);
{ Sets the FAltButton subcomponent's Down property to newValue. }
begin
  TElEditBtn(FAltButton).Down := newValue;
end; { SetAltButtonDown }

function TCustomElButtonEdit.GetAltButtonDown : Boolean;
{ Returns the Down property from the FAltButton subcomponent. }
begin
  GetAltButtonDown := TElEditBtn(FAltButton).Down;
end; { GetAltButtonDown }

{$IFDEF USE_SOUND_MAP}
procedure TCustomElButtonEdit.SetAltButtonDownSound(newValue : TElSoundName);
{ Sets the FAltButton subcomponent's DownSound property to newValue. }
begin
  TElEditBtn(FAltButton).DownSound := newValue;
end; { SetAltButtonDownSound }

function TCustomElButtonEdit.GetAltButtonDownSound : TElSoundName;
{ Returns the DownSound property from the FAltButton subcomponent. }
begin
  GetAltButtonDownSound := TElEditBtn(FAltButton).DownSound;
end; { GetAltButtonDownSound }
{$endif}

procedure TCustomElButtonEdit.SetAltButtonFlat(newValue : Boolean);
{ Sets the FAltButton subcomponent's Flat property to newValue. }
begin
  TElEditBtn(FAltButton).Flat := newValue;
end; { SetAltButtonFlat }

function TCustomElButtonEdit.GetAltButtonFlat : Boolean;
{ Returns the Flat property from the FAltButton subcomponent. }
begin
  GetAltButtonFlat := TElEditBtn(FAltButton).Flat;
end; { GetAltButtonFlat }

procedure TCustomElButtonEdit.SetAltButtonGlyph(newValue : TBitmap);
{ Sets the FAltButton subcomponent's Glyph property to newValue. }
begin
  TElEditBtn(FAltButton).Glyph := newValue;
end; { SetAltButtonGlyph }

function TCustomElButtonEdit.GetAltButtonGlyph : TBitmap;
{ Returns the Glyph property from the FAltButton subcomponent. }
begin
  GetAltButtonGlyph := TElEditBtn(FAltButton).Glyph;
end; { GetAltButtonGlyph }

procedure TCustomElButtonEdit.SetAltButtonIcon(newValue : TIcon);
{ Sets the FAltButton subcomponent's Icon property to newValue. }
begin
  TElEditBtn(FAltButton).Icon := newValue;
end; { SetAltButtonIcon }

function TCustomElButtonEdit.GetAltButtonIcon : TIcon;
{ Returns the Icon property from the FAltButton subcomponent. }
begin
  GetAltButtonIcon := TElEditBtn(FAltButton).Icon;
end; { GetAltButtonIcon }

procedure TCustomElButtonEdit.SetAltButtonNumGlyphs;
{ Sets the FAltButton subcomponent's NumGlyphs property to newValue. }
begin
  TElEditBtn(FAltButton).NumGlyphs := newValue;
end; { SetAltButtonNumGlyphs }

function TCustomElButtonEdit.GetAltButtonNumGlyphs;
{ Returns the NumGlyphs property from the FAltButton subcomponent. }
begin
  GetAltButtonNumGlyphs := TElEditBtn(FAltButton).NumGlyphs;
end; { GetAltButtonNumGlyphs }

{$IFDEF USE_SOUND_MAP}
procedure TCustomElButtonEdit.SetAltButtonSoundMap(newValue : TElSoundMap);
{ Sets the FAltButton subcomponent's SoundMap property to newValue. }
begin
  TElEditBtn(FAltButton).SoundMap := newValue;
end; { SetAltButtonSoundMap }

function TCustomElButtonEdit.GetAltButtonSoundMap : TElSoundMap;
{ Returns the SoundMap property from the FAltButton subcomponent. }
begin
  GetAltButtonSoundMap := TElEditBtn(FAltButton).SoundMap;
end; { GetAltButtonSoundMap }
{$ENDIF}

{$IFDEF USE_SOUND_MAP}
procedure TCustomElButtonEdit.SetAltButtonUpSound(newValue : TElSoundName);
{ Sets the FAltButton subcomponent's UpSound property to newValue. }
begin
  TElEditBtn(FAltButton).UpSound := newValue;
end; { SetAltButtonUpSound }

function TCustomElButtonEdit.GetAltButtonUpSound : TElSoundName;
{ Returns the UpSound property from the FAltButton subcomponent. }
begin
  GetAltButtonUpSound := TElEditBtn(FAltButton).UpSound;
end; { GetAltButtonUpSound }
{$endif}

procedure TCustomElButtonEdit.SetAltButtonUseIcon(newValue : Boolean);
{ Sets the FAltButton subcomponent's UseIcon property to newValue. }
begin
  TElEditBtn(FAltButton).UseIcon := newValue;
end; { SetAltButtonUseIcon }

function TCustomElButtonEdit.GetAltButtonUseIcon : Boolean;
{ Returns the UseIcon property from the FAltButton subcomponent. }
begin
  GetAltButtonUseIcon := TElEditBtn(FAltButton).UseIcon;
end; { GetAltButtonUseIcon }

procedure TCustomElButtonEdit.SetAltButtonVisible(newValue : Boolean);
{ Sets the FAltButton subcomponent's Visible property to newValue. }
begin
  FAltButton.Visible := newValue;
  if HandleAllocated then
  begin
    SetEditRect(ClientRect);
    Invalidate;
  end;
end; { SetAltButtonVisible }

function TCustomElButtonEdit.GetAltButtonVisible : Boolean;
{ Returns the Visible property from the FAltButton subcomponent. }
begin
  GetAltButtonVisible := FAltButton.Visible;
end; { GetAltButtonVisible }

procedure TCustomElButtonEdit.SetAltButtonWidth(newValue : Integer);
{ Sets the FAltButton subcomponent's Width property to newValue. }
begin
  FAltButton.Width := newValue;
  if FAltButton.Visible and HandleAllocated then
  begin
    SetEditRect(ClientRect);
    Invalidate;
  end;
end; { SetAltButtonWidth }

function TCustomElButtonEdit.GetAltButtonWidth : Integer;
{ Returns the Width property from the FAltButton subcomponent. }
begin
  GetAltButtonWidth := FAltButton.Width;
end; { GetAltButtonWidth }

procedure TCustomElButtonEdit.AltButtonClickTransfer(Sender : TObject);
{ Transfers FAltButton OnClick event to the outside world. }
begin
  if (assigned(FOnAltButtonClick)) then
    FOnAltButtonClick(Self); { Substitute Self for subcomponent's Sender. }
end; { AltButtonClickTransfer }

{ Exposed properties' Read/Write methods: }

procedure TCustomElButtonEdit.SetButtonFlat(newValue : Boolean);
{ Sets the FButton subcomponent's Flat property to newValue. }
begin
  TElEditBtn(FButton).Flat := newValue;
end; { SetButtonFlat }

function TCustomElButtonEdit.GetButtonFlat : Boolean;
{ Returns the Flat property from the FButton subcomponent. }
begin
  GetButtonFlat := TElEditBtn(FButton).Flat;
end; { GetButtonFlat }

procedure TCustomElButtonEdit.SetAltButtonEnabled(newValue : Boolean);
{ Sets the FAltButton subcomponent's Enabled property to newValue. }
begin
  FAltButton.Enabled := newValue;
end; { SetAltButtonEnabled }

function TCustomElButtonEdit.GetAltButtonEnabled : Boolean;
{ Returns the Enabled property from the FAltButton subcomponent. }
begin
  GetAltButtonEnabled := FAltButton.Enabled;
end; { GetAltButtonEnabled }

procedure TCustomElButtonEdit.SetButtonEnabled(newValue : Boolean);
{ Sets the FButton subcomponent's Enabled property to newValue. }
begin
  FButton.Enabled := newValue;
end; { SetButtonEnabled }

function TCustomElButtonEdit.GetButtonEnabled : Boolean;
{ Returns the Enabled property from the FButton subcomponent. }
begin
  GetButtonEnabled := FButton.Enabled;
end; { GetButtonEnabled }

procedure TCustomElButtonEdit.CMEnabledChanged(var Msg : TMessage); { private }
begin
  inherited;
  NotifyControls(CM_ENABLEDCHANGED);
end; { CMEnabledChanged }

procedure TCustomElButtonEdit.KeyDown(var Key : Word; Shift : TShiftState); { protected }
var
  SC : TShortcut;
begin
  if Key = 0 then
  begin
    inherited;
    exit;
  end;
  SC := Shortcut(Key, Shift);
  if (SC = FButtonShortcut) and (FButton.Visible) and (FButton.Enabled) then
   FButton.Click
  else
  if (SC = FAltButtonShortcut) and (FAltButton.Visible) and (FAltButton.Enabled) then
    FAltButton.Click
  else
    inherited;
end; { KeyDown }

{ Exposed properties' Read/Write methods: }
procedure TCustomElButtonEdit.SetAltButtonHint(newValue : String);
{ Sets the FAltButton subcomponent's Hint property to newValue. }
begin
  FAltButton.Hint := newValue;
end;  { SetAltButtonHint }

function TCustomElButtonEdit.GetAltButtonHint : String;
{ Returns the Hint property from the FAltButton subcomponent. }
begin
  GetAltButtonHint := FAltButton.Hint;
end;  { GetAltButtonHint }

{ Exposed properties' Read/Write methods: }
procedure TCustomElButtonEdit.SetAltButtonPopupPlace(newValue : TPopupPlace);
{ Sets the FAltButton subcomponent's PopupPlace property to newValue. }
begin
  TElEditBtn(FAltButton).PopupPlace := newValue;
end;  { SetAltButtonPopupPlace }

function TCustomElButtonEdit.GetAltButtonPopupPlace : TPopupPlace;
{ Returns the PopupPlace property from the FAltButton subcomponent. }
begin
  GetAltButtonPopupPlace := TElEditBtn(FAltButton).PopupPlace;
end;  { GetAltButtonPopupPlace }

procedure TCustomElButtonEdit.SetAltButtonPullDownMenu(newValue : TPopupMenu);
{ Sets the FAltButton subcomponent's PullDownMenu property to newValue. }
begin
  TElEditBtn(FAltButton).PullDownMenu := newValue;
end;  { SetAltButtonPullDownMenu }

function TCustomElButtonEdit.GetAltButtonPullDownMenu : TPopupMenu;
{ Returns the PullDownMenu property from the FAltButton subcomponent. }
begin
  GetAltButtonPullDownMenu := TElEditBtn(FAltButton).PullDownMenu;
end;  { GetAltButtonPullDownMenu }

procedure TCustomElButtonEdit.SetButtonPopupPlace(newValue : TPopupPlace);
{ Sets the FButton subcomponent's PopupPlace property to newValue. }
begin
  TElEditBtn(FButton).PopupPlace := newValue;
end;  { SetButtonPopupPlace }

function TCustomElButtonEdit.GetButtonPopupPlace : TPopupPlace;
{ Returns the PopupPlace property from the FButton subcomponent. }
begin
  GetButtonPopupPlace := TElEditBtn(FButton).PopupPlace;
end;  { GetButtonPopupPlace }

procedure TCustomElButtonEdit.SetButtonPullDownMenu(newValue : TPopupMenu);
{ Sets the FButton subcomponent's PullDownMenu property to newValue. }
begin
  TElEditBtn(FButton).PullDownMenu := newValue;
end;  { SetButtonPullDownMenu }

function TCustomElButtonEdit.GetButtonPullDownMenu : TPopupMenu;
{ Returns the PullDownMenu property from the FButton subcomponent. }
begin
  GetButtonPullDownMenu := TElEditBtn(FButton).PullDownMenu;
end;  { GetButtonPullDownMenu }

{ Exposed properties' Read/Write methods: }
procedure TCustomElButtonEdit.SetAltButtonCaption(newValue : TCaption);
{ Sets the FAltButton subcomponent's Caption property to newValue. }
begin
  TElEditBtn(FAltButton).Caption := newValue;
end;  { SetAltButtonCaption }

function TCustomElButtonEdit.GetAltButtonCaption : TCaption;
{ Returns the Caption property from the FAltButton subcomponent. }
begin
  GetAltButtonCaption := TElEditBtn(FAltButton).Caption;
end;  { GetAltButtonCaption }

procedure TCustomElButtonEdit.SetButtonCaption(newValue : TCaption);
{ Sets the FButton subcomponent's Caption property to newValue. }
begin
  TElEditBtn(FButton).Caption := newValue;
end;  { SetButtonCaption }

function TCustomElButtonEdit.GetButtonCaption : TCaption;
{ Returns the Caption property from the FButton subcomponent. }
begin
  GetButtonCaption := TElEditBtn(FButton).Caption;
end;  { GetButtonCaption }

procedure TCustomElButtonEdit.WMGetDlgCode(var Msg : TWMGetDlgCode);  { private }
begin
  inherited;
  if Multiline then
    Msg.Result := Msg.Result or DLGC_WANTALLKEYS;
end;  { WMGetDlgCode }

procedure TCustomElButtonEdit.SetAltBtnAlign(newValue : TLeftRight);
begin
  if newValue <> FAltBtnAlign then
  begin
    FAltBtnAlign := newValue;
    if HandleAllocated then
    begin
      SetEditRect(ClientRect);
      Invalidate;
    end;
  end;
end;

destructor TCustomElButtonEdit.Destroy;
begin
  FButton.Free;
  FAltButton.Free;
  FButton := nil;
  FAltButton := nil;
  inherited;
end; { Destroy }

constructor TCustomElButtonEdit.Create(AOwner : TComponent);
begin
  if ButtonClass = nil then
    ButtonClass := TElEditBtn;
  inherited Create(AOwner);
  FButton := ButtonClass.Create(nil);
  with TElEditBtn(FButton) do
  begin
    Cursor := crArrow;
    ParentColor := false;
    Color := clBtnFace;
    Parent := Self;
    UseXPThemes := false;
    UseXPThemes := true;
    OnClick := ButtonClickTransfer;
    Width := 15;
    Flat := false;
    Visible := true;
    AdjustSpaceForGlyph := false;
    if csDesigning in ComponentState then
      Enabled := false;
  end; { FButton }
  FAltButton := ButtonClass.Create(nil);
  with TElEditBtn(FAltButton) do
  begin
    Cursor := crArrow;
    ParentColor := false;
    Color := clBtnFace;
    Parent := Self;
    UseXPThemes := false;
    UseXPThemes := true;
    OnClick := AltButtonClickTransfer;
    Width := 15;
    Flat := false;
    Visible := false;
    AdjustSpaceForGlyph := false;
    if csDesigning in ComponentState then
      Enabled := false;
  end; { FAltButton }
  FAltBtnAlign := taRightJustify;
  TabStop := true;
end; { Create }

procedure TCustomElButtonEdit.WMKeyDown(var Message: TWMKey);
begin
  with Message do
    if (CharCode = VK_ESCAPE) and (KeyDataToShiftState(KeyData) = []) then
    begin
      GetParentForm(Self).Perform(CM_DIALOGKEY, CharCode, KeyData);
      inherited;
    end
    else
    if (CharCode = VK_RETURN) and (KeyDataToShiftState(KeyData) = [ssCtrl]) then
    begin
      SendMessage(Handle, WM_CHAR, TMessage(Message).wParam, TMessage(Message).lParam);
      CharCode := 0;
    end
    else
      inherited;
end;

function TCustomElButtonEdit.GetAltButtonColor: TColor;
begin
  Result := TElEditBtn(FAltButton).Color;
end;

procedure TCustomElButtonEdit.SetAltButtonColor(Value: TColor);
begin
  TelEditBtn(FAltButton).Color := Value;
end;

function TCustomElButtonEdit.GetButtonThinFrame: Boolean;
begin
  Result := TElGraphicButton(FButton).ThinFrame;
end;

procedure TCustomElButtonEdit.SetButtonThinFrame(Value: Boolean);
begin
  TElGraphicButton(FButton).ThinFrame := Value;
end;

function TCustomElButtonEdit.GetAltButtonThinFrame: Boolean;
begin
  Result := TElGraphicButton(FAltButton).ThinFrame;
end;

procedure TCustomElButtonEdit.SetAltButtonThinFrame(Value: Boolean);
begin
  TElGraphicButton(FAltButton).ThinFrame := Value;
end;

procedure TCustomElButtonEdit.SetUseXPThemes(const Value : boolean);
begin
  inherited;
  TElEditBtn(FButton).UseXPThemes := Value;
  TElEditBtn(FAltButton).UseXPThemes := Value;
end;

procedure TCustomElButtonEdit.UpdateButtonStyles;
begin
  TElEditBtn(FButton).MoneyFlat := Flat and (InactiveBorderType = fbtColorLineBorder) and (ActiveBorderType = fbtColorLineBorder);
  TElEditBtn(FButton).MoneyFlatActiveColor := LineBorderActiveColor;
  TElEditBtn(FButton).MoneyFlatInactiveColor := LineBorderInactiveColor;
  TElEditBtn(FButton).MoneyFlatDownColor := LineBorderActiveColor;

  TElEditBtn(FAltButton).MoneyFlat := TElEditBtn(FButton).MoneyFlat;
  TElEditBtn(FAltButton).MoneyFlatActiveColor := LineBorderActiveColor;
  TElEditBtn(FAltButton).MoneyFlatInactiveColor := LineBorderInactiveColor;
  TElEditBtn(FAltButton).MoneyFlatDownColor := LineBorderActiveColor;
end;

procedure TCustomElButtonEdit.SetActiveBorderType(const Value:
    TElFlatBorderType);
begin
  inherited;
  UpdateButtonStyles;
end;

procedure TCustomElButtonEdit.SetFlat(const Value: boolean);
begin
  inherited;
  UpdateButtonStyles;
end;

procedure TCustomElButtonEdit.SetInactiveBorderType(const Value:
    TElFlatBorderType);
begin
  inherited;
  UpdateButtonStyles;
end;

procedure TCustomElButtonEdit.SetLineBorderActiveColor(Value: TColor);
begin
  inherited;
  UpdateButtonStyles;
end;

procedure TCustomElButtonEdit.SetLineBorderInactiveColor(Value: TColor);
begin
  inherited;
  UpdateButtonStyles;
end;

function TCustomElButtonEdit.GetButtonTransparent: Boolean;
begin
  Result := TElEditBtn(FButton).Transparent;
end;

procedure TCustomElButtonEdit.SetButtonTransparent(Value: Boolean);
begin
  TElEditBtn(FButton).Transparent := Value;
end;

function TCustomElButtonEdit.GetAltButtonTransparent: Boolean;
begin
  Result := TElEditBtn(FAltButton).Transparent;
end;

procedure TCustomElButtonEdit.SetAltButtonTransparent(Value: Boolean);
begin
  TElEditBtn(FAltButton).Transparent := Value;
end;

function TCustomElButtonEdit.GetButtonIsSwitch: Boolean;
begin
  Result := TElEditBtn(FButton).IsSwitch;
end;

procedure TCustomElButtonEdit.SetButtonIsSwitch(Value: Boolean);
begin
  TElEditBtn(FButton).IsSwitch := Value;
end;

function TCustomElButtonEdit.GetAltButtonIsSwitch: Boolean;
begin
  Result := TElEditBtn(FAltButton).IsSwitch;
end;

procedure TCustomElButtonEdit.SetAltButtonIsSwitch(Value: Boolean);
begin
  TElEditBtn(FAltButton).IsSwitch := Value;
end;

function TCustomElButtonEdit.GetButtonShowBorder: Boolean;
begin
  Result := TElEditBtn(FButton).ShowBorder;
end;

procedure TCustomElButtonEdit.SetButtonShowBorder(Value: Boolean);
begin
  TElEditBtn(FButton).ShowBorder := Value;
end;

function TCustomElButtonEdit.GetAltButtonShowBorder: Boolean;
begin
  Result := TElEditBtn(FAltButton).ShowBorder;
end;

procedure TCustomElButtonEdit.SetAltButtonShowBorder(Value: Boolean);
begin
  TElEditBtn(FAltButton).ShowBorder := Value;
end;

function TCustomElButtonEdit.GetButtonOldStyled: Boolean;
begin
  Result := TElEditBtn(FButton).OldStyled;
end;

procedure TCustomElButtonEdit.SetButtonOldStyled(Value: Boolean);
begin
  TElEditBtn(FButton).OldStyled := Value;
end;

function TCustomElButtonEdit.GetAltButtonOldStyled: Boolean;
begin
  Result := TElEditBtn(FAltButton).OldStyled;
end;

procedure TCustomElButtonEdit.SetAltButtonOldStyled(Value: Boolean);
begin
  TElEditBtn(FAltButton).OldStyled := Value;
end;


(*
{$ifdef ELPACK_USE_STYLEMANAGER}
procedure TCustomElButtonEdit.SetStyleManager(Value: TElStyleManager);
begin
  inherited;
  if not (csDestroying in ComponentState) then
  begin
    FButton.StyleManager := Value;
    FAltButton.StyleManager := Value;
  end;
end;

procedure TCustomElButtonEdit.SetStyleName(const Value: string);
begin
  inherited;
  FButton.Name := Value;
  FAltButton.Name := Value;
end;
{$endif}
*)

end.
