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

07/15/2003

  If TabStop of ElPopupButton was set to false, the button ignored clicks. Fixed. 

03/30/2003

  now hints show action shortcuts

12/19/2002

  OnKeyUp was not fired. Fixed.

10/26/2002

  The image list was not updated after the menu is cancelled

10/02/2002

  Added ButtonClick method to TElPopupButton

09/01/2002

  Fixed an AV that happened when setting Glyph to nil

07/03/2002

  Added Alignment property for the text. It is active for multiline captions only

06/05/2002

  Added support for HTML-formatted captions

05/31/2002

  With older versions of VCL pressing F1 on buttons caused an AV if
  there was no PullDownMenu assigned. Fixed.

04/28/2002

  Buttons didn't work correctly with ElPopupMenu as PulldownMenu if they didn't
  have an owner. Fixed.

04/18/2002

  DrawFocusFrame property added

03/17/2002

  Fixed the AV that happened when ImageIsAlphaBlended was turned off for bitmaps

03/09/2002

  Fixed drawing of disabled images when manifest is included
  Fixed popup menu handling for ElPopupMenu

03/06/2002

  Added unicode hint
  Fixed disabled image creation for images that use imagelist

02/23/2002

  Added support for 32-bit images with alpha blending (used in XP).
  Such images are supported on all OS, not just WinXP

02/17/2002

  Fixed alignment of the text with XP styles enabled

01/29/2002

  Improved positioning of text and glyphs in buttons

01/16/2002

  Now GraphicButton is drawn without accelerator

12/25/2001

  Fixed measurement of size in CLX version

12/21/2001

  DownBackground can now be used without Background

12/09/2001

  Fixed sizing of the buttons with MeasureButton with XP styles enabled

11/28/2001

  Added MoneyFlat and accompanying properties
  Fixed the problem with raised frame that stays after pull-down menu is hidden

11/24/2001

  Improved drawing of hot images when mouse enters and leaves the button

11/21/2001

  Removed flicker in TElPopupButton with XP styles enabled

11/09/2001

  Transparency fixed

10/26/2001

  Fixed painting of background with XP styles enabled

09/24/2001

  Improved flat borders behaviour

09/17/2001

  Added Windows XP Themes Support

09/13/2001

  Fixed position of menu that pulls up

07/26/2001

  Added Unicode support

07/25/2001

  Added AdjustSpaceForGlyph property to use new rectangle calculation

07/22/2001

  Changed the drawing rectangle calculation to look the same as TSpeedButton and
  TBitBtn

06/06/2001

  Small memory leak fixed in ElPopupButton and ElGraphicButton with UseArrow
  set to true

05/27/2001 (c) Akzhan Abdulin

    Fixed Color property design-time storing issue (clWindow not stored)

03/10/2001

  Fixed possible AVs that could happen when image list is removed.

  Minor optimizations and readness improvements.

1/7/2001

  NumGlyphs property is now set correctly

12/16/2000

  Border colors calculation fixed for custom border.

============================== Version 2.76 ====================================

12/04/2000

  When the glyph of disabled button is drawn from the imagelist, specified by
  Images property, this glyph is grayed before drawing now.

  The glyph is not being offset when the image for Down state differs from
  the image for normal state

============================== Version 2.75 ====================================

10/31/2000

  When the color is changed, the button is repaint�ed.

============================== Version 2.74 ====================================

09/23/2000

  When ElPopupButton.ImageList is assigned, UseImageList wasn't taken into
  account. Fixed.
  Added DownImages property for ElPopupButton and ElGraphicButton

09/14/2000

  ShowBorder property added to ElPopupButton and ElGraphicButton

*)

unit ElPopBtn;

interface

{$R 'ElPopBtn.res'}

uses
  SysUtils,
  Classes,
  ElBtnCtl,
  ElTmSchema,
  ElUxTheme,

  Windows,
  Messages,
  Graphics,
  Controls,
  Forms,
  Buttons,
  CommCtrl,
  Menus,
  ExtCtrls,
{$ifdef VCL_6_USED}
  Types,
{$endif}
{$ifdef VCL_4_USED}
  ImgList,
{$endif}
{$IFDEF VCL_4_USED}
  ActnList,
{$ENDIF}
  ElVCLUtils,
{$IFDEF HAS_HTML_RENDER}
  HTMLRender,
{$ENDIF}
{$ifdef HAS_HTML_RENDER}
  ElHandPt,
{$endif}
  ElTools,
  {$ifdef ELPACK_USE_IMAGEFORM}
  ElImgFrm,
  {$endif}
{$ifdef ELPACK_USE_STYLEMANAGER}
  ElStyleMan,
{$endif}
  ElList,
  {$ifdef USE_SOUND_MAP}
  ElSndMap,
  {$endif}
  ElStrUtils,
  ElGlyphs;

type
  TPullDownEvent = procedure(Sender : TObject) of object;

  TElSpeedButton = class(TGraphicControl)
  private
    FTransparentColor : TColor;
    FAutoSize : Boolean;
    FNormalImage : TBitmap;
    FDisabledImage : TBitmap;
    FMouseInImage : TBitmap;
    FPressedImage : TBitmap;
    FFlat : Boolean;
    FDrawEdge : Boolean;
    FPressed : boolean;
    FOver : boolean;
    FPullTimer : TTimer;
    FPullDownBtn : TMouseButton;
    FPullDownInterval : Integer;
    FPullDownEnabled : Boolean;
    FPullDownMenu : TPopupMenu;
    FTransparent : Boolean;
    FOnPullDown : TPullDownEvent;
    procedure SetPullDownMenu(newValue : TPopupMenu);
    procedure SetTransparent(newValue : Boolean);
    procedure SetDrawEdge(newValue : Boolean);

    procedure WMMouseMove(var Msg : TWMMouseMove); message WM_MOUSEMOVE;
    procedure CMMouseLeave(var Msg : TMessage); message CM_MOUSELEAVE;

    procedure SetFlat(newValue : Boolean);
    procedure SetNormalImage(newValue : TBitmap);
    procedure SetDisabledImage(newValue : TBitmap);
    procedure SetMouseInImage(newValue : TBitmap);
    procedure SetPressedImage(newValue : TBitmap);
    procedure SetTransparentColor(newValue : TColor);
    procedure WMEraseBkgnd(var Msg : TWMEraseBkgnd); message WM_ERASEBKGND;
  protected
    procedure SetAutoSize(newValue : boolean); {$ifdef VCL_6_USED} override; {$endif}
    procedure TriggerPullDownEvent; virtual;
    procedure Paint; override;
    procedure MouseDown(Button : TMouseButton; Shift : TShiftState; X, Y : Integer); override;
    procedure MouseUp(Button : TMouseButton; Shift : TShiftState; X, Y : Integer); override;
    procedure OnTimer(Sender : TObject);
    procedure StartTimer;
    procedure PullMenu;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    function InCircle(X, Y : integer) : Boolean; virtual;
  published
    property PullDownBtn : TMouseButton read FPullDownBtn write FPullDownBtn; { Published }
    property PullDownInterval : Integer read FPullDownInterval write FPullDownInterval default 1000; { Published }
    property PullDownEnabled : Boolean read FPullDownEnabled write FPullDownEnabled default false; { Published }
    property PullDownMenu : TPopupMenu read FPullDownMenu write SetPullDownMenu; { Published }
    property Transparent : Boolean read FTransparent write SetTransparent default true; { Published }
    property OnPullDown : TPullDownEvent read FOnPullDown write FOnPullDown;
    property DrawEdge : Boolean read FDrawEdge write SetDrawEdge default False; { Published }
    property Flat : Boolean read FFlat write SetFlat; { Published }
    property NormalImage : TBitmap read FNormalImage write SetNormalImage; { Published }
    property DisabledImage : TBitmap read FDisabledImage write SetDisabledImage; { Published }
    property MouseInImage : TBitmap read FMouseInImage write SetMouseInImage; { Published }
    property PressedImage : TBitmap read FPressedImage write SetPressedImage; { Published }
    property AutoSize : Boolean read FAutoSize write SetAutoSize default true; { Published }
    property TransparentColor : TColor read FTransparentColor write SetTransparentColor; { Published }

    //VCL properties
    property Align;
    property Color nodefault;
    property DragCursor;
    property DragMode;
    property ParentColor;
    property Enabled;
    property ParentShowHint;
    property ShowHint;
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
    property OnDragOver;
    property OnDragDrop;
{$IFDEF VCL_4_USED}
    property Anchors;
    property Action;
    property Constraints;
    property DockOrientation;
    property Floating;
    property DragKind;
{$ENDIF}
  end; { TElSpeedButton }

  TPopupPlace = (ppDown, ppRight, ppTop);

{$WARNINGS OFF}
  TCustomElPopupButton = class(TElButtonControl)
  protected
    FNumGlyphs: Integer;
    {$IFDEF HAS_HTML_RENDER}
    FCursor: TCursor;
    {$endif}
    FShadowsUseCustom : boolean;
    FShadowBtnHighlight,
    FShadowBtnShadow,
    FShadowBtnDkShadow : TColor;
    FBackground : TBitmap;
    FShadowFollowsColor : boolean;
    FDownBackground : TBitmap;
    FBackgroundDrawBorder : boolean;
    FThinFrame : Boolean;
    FHotImages      : TImageList;
    FAlphaHotImages : TImageList;
    FAlphaDisabledImages : TImageList;
    FAlphaDownImages: TImageList;
    FAlphaImageList : TImageList;
    FDisabledImages : TImageList;
    FDownImages     : TImageList;
    FImageList      : TImageList;
    FOldStyled : Boolean;
    FUseImageList : boolean;
    FUseIcon : Boolean;
{$IFDEF USE_SOUND_MAP}
    FSoundMap : TElSoundMap;
    FDownSound : TElSoundName;
    FUpSound : TElSoundName;
    FClickSound : TElSoundName;
    FArrowClickSound : TElSoundName;
{$ENDIF}
    FIsSwitch : Boolean;
    FShowGlyph : Boolean;
    FShowText : Boolean;
    FUseArrow : Boolean;
    FShowFocus : Boolean;
    FMultiLine : Boolean;
    FGroupIndex : Integer;
    FGlyph : TElButtonGlyph;
    FDown : Boolean;
    FArrDown : boolean;
    FInMenu,
    FIgnoreClick  : boolean;
    FDragging : Boolean;
    FAllowAllUp : Boolean;
    FLayout : TButtonLayout;
    FSpacing : Integer;
    FMargin : Integer;
    FFlat : Boolean;
    FMouseInArrow,
    FMouseInControl : Boolean;
    FDisableAp : boolean;
    FPopupPlace : TPopupPlace;
    FDefault : Boolean;
    FCancel : Boolean;
    FActive : Boolean;
    FModalResult : TModalResult;
    FClicksDisabled : Boolean;
    FAChLink,
    FANChLink,
    FADChLink,
    FAHChLink,
    FChLink,
    FNChLink,
    FDChLink,
    FHChLink: TChangeLink;
    FPullDownMenu : TPopupMenu;
    FOnArrowClick : TNotifyEvent;
    {$ifdef ELPACK_USE_IMAGEFORM}
    FImgForm : TElImageForm;
    FImgFormChLink  : TImgFormChangeLink;
    {$endif}
    FShowBorder   : boolean;
    FAdjustSpaceForGlyph: Boolean;
    FArrTheme: HTheme;
    {$ifdef HAS_HTML_RENDER}
    FIsHTML  : Boolean;
    FRender  : TElHTMLRender;
    {$endif}
    {$IFDEF HAS_HTML_RENDER}
    FOnImageNeeded: TElHTMLImageNeededEvent;
    FOnLinkClick: TElHTMLLinkClickEvent;
    {$endif}
    FOrigState,
    FState : TElButtonState;
    FDrawDefaultFrame: Boolean;
    FImageIsAlphaBlended: Boolean;
    FDrawFocusFrame: Boolean;
    {$IFDEF HAS_HTML_RENDER}
    FLinkColor: TColor;
    FLinkPopupMenu: TPopupMenu;
    FLinkStyle: TFontStyles;
    {$endif}
    FTextRect: TRect;
    FChangeDisabledText: Boolean;
    FAlignment : TAlignment;
    FOldCapture : HWND;
    FIgnoreMouseDown: Boolean;

    procedure SetAlignment(Value: TAlignment);
{$ifdef HAS_HTML_RENDER}
    procedure SetIsHTML(Value: Boolean);
{$endif}
    procedure SetShowBorder(newValue : boolean);
    {$ifdef ELPACK_USE_IMAGEFORM}
    procedure ImageFormChange(Sender : TObject);
    procedure SetImageForm(newValue : TElImageForm);
    {$endif}
    procedure SetPullDownMenu(newValue : TPopupMenu);
    procedure SetDefault(Value : Boolean);
    procedure SetPopupPlace(Value : TPopupPlace);
    procedure SetDisableAp(Value : boolean);
    procedure GlyphChanged(Sender : TObject);
    procedure UpdateExclusive;
    function GetGlyph : TBitmap;
    procedure SetGlyph(Value : TBitmap);
    function GetNumGlyphs : TNumGlyphs;
    procedure SetNumGlyphs(Value : TNumGlyphs);
    procedure SetDown(Value : Boolean);
    procedure SetAllowAllUp(Value : Boolean);
    procedure SetGroupIndex(Value : Integer);
    procedure SetLayout(Value : TButtonLayout);
    procedure SetSpacing(Value : Integer);
    procedure SetMargin(Value : Integer);
    procedure UpdateTracking;
    procedure IntMouseEnter;
    procedure IntMouseLeave;
    procedure IntEnabledChanged;
    function IntKeyDown(var Key: Word; Shift: TShiftState) : boolean;
    procedure IntKeyUp(var Key: Word; Shift: TShiftState);
    procedure IntTextChanged;
    procedure CMMouseEnter(var Message : TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message : TMessage); message CM_MOUSELEAVE;
    procedure CMEnter(var Msg: TCMEnter); message CM_ENTER;
    procedure CMExit(var Msg: TCMExit); message CM_EXIT;

    procedure WMKeyDown(var Message : TWMKeyDown); message WM_KEYDOWN;
    procedure WMKeyUp(var Msg: TWMKeyUp); message WM_KEYUP;
    procedure WMLButtonDblClk(var Message : TWMLButtonDown); message WM_LBUTTONDBLCLK;
    procedure CMEnabledChanged(var Message : TMessage); message CM_ENABLEDCHANGED;
    procedure CMButtonPressed(var Message : TMessage); message CM_BUTTONPRESSED;
    procedure CMDialogKey(var Message : TCMDialogKey); message CM_DIALOGKEY;
    procedure CMFontChanged(var Message : TMessage); message CM_FONTCHANGED;
    procedure CMTextChanged(var Message : TMessage); message CM_TEXTCHANGED;
    procedure CMColorChanged(var Message : TMessage); message CM_COLORCHANGED;
    procedure CMSysColorChange(var Message : TMessage); message CM_SYSCOLORCHANGE;
    {$ifdef ELPACK_USE_IMAGEFORM}
    procedure IFMRepaintChildren(var Message: TMessage); message
        IFM_REPAINTCHILDREN;
    {$endif}
    procedure WMGetDlgCode(var Msg : TMessage); message WM_GETDLGCODE;
    procedure CMFocusChanged(var Message : TCMFocusChanged); message CM_FOCUSCHANGED;
    procedure CNCommand(var Message : TWMCommand); message CN_COMMAND;
    procedure SetShowFocus(newValue : Boolean);
    procedure SetShowGlyph(newValue : Boolean);
    procedure SetShowText(newValue : Boolean);
    function GetIcon : TIcon;
    procedure SetIcon(newValue : TIcon);
    procedure SetIsSwitch(newValue : Boolean);
{$IFDEF USE_SOUND_MAP}
    procedure SetSoundMap(newValue : TElSoundMap);
{$ENdIF}
    procedure SetImageIndex(newValue : Integer);
    function GetImageIndex : integer;
    procedure SetUseIcon(newValue : Boolean);
    procedure SetImageList(newValue : TImageList);
    procedure SetAlphaImageList(newValue: TImageList);
    procedure SetUseImageList(newValue : Boolean);
    function GetUseImageList : boolean;
    procedure SetOldStyled(newValue : Boolean);
    procedure SetHotImages(newValue : TImageList);
    procedure SetAlphaHotImages(newValue : TImageList);
    procedure SetDownImages(newValue : TImageList);
    procedure SetAlphaDownImages(newValue : TImageList);
    procedure SetDisabledImages(newValue : TImageList);
    procedure SetAlphaDisabledImages(newValue : TImageList);
    procedure ImagesChanged(Sender : TObject);
    procedure SetThinFrame(newValue : Boolean);
    procedure SetBackground(newValue : TBitmap);
    procedure SetDownBackground(newValue : TBitmap);
    procedure SetBackgroundDrawBorder(Value : boolean);
    procedure SetShadowFollowsColor(Value : Boolean);
    procedure SetShadowsUseCustom(Value : Boolean);
    procedure SetShadowBtnHighlight(Value : TColor);
    procedure SetShadowBtnShadow(Value : TColor);
    procedure SetShadowBtnDkShadow(Value : TColor);
    procedure SetAdjustSpaceForGlyph(Value: Boolean);
    {$IFDEF HAS_HTML_RENDER}
    procedure SetLinkPopupMenu(newValue : TPopupMenu);
    procedure SetLinkColor(newValue : TColor); virtual;
    procedure SetLinkStyle(newValue : TFontStyles); virtual;
    procedure DoLinkPopup(MousePos : TPoint);
    procedure TriggerImageNeededEvent(Sender : TObject; Src : TElFString; var Image
        : TBitmap);
    procedure TriggerLinkClickEvent(HRef : TElFString); virtual;
    {$endif}
    procedure SetUseArrow(newValue : boolean); virtual;
    procedure CreateThemeHandle; override;
    procedure FreeThemeHandle; override;

    function GetPalette : HPALETTE; override;
    procedure Loaded; override;
    procedure MouseDown(Button : TMouseButton; Shift : TShiftState;
      X, Y : Integer); override;
    procedure MouseMove(Shift : TShiftState; X, Y : Integer); override;
    procedure MouseUp(Button : TMouseButton; Shift : TShiftState;
      X, Y : Integer); override;
    procedure Paint; override;
    procedure CreateParams(var Params : TCreateParams); override;
    procedure CreateWnd; override;
    procedure SetButtonStyle(ADefault : Boolean); virtual;
    procedure WndProc(var Message : TMessage); override;
    procedure SetFlat(Value : Boolean); virtual;
    function GetChecked : Boolean; override;
    procedure SetChecked(newValue : Boolean); override;
{$IFDEF VCL_4_USED}
    function GetActionLinkClass : TControlActionLinkClass; override;
    procedure ActionChange(Sender : TObject; CheckDefaults : Boolean); override;
{$ENDIF}

    {$ifdef VCL_5_USED}
    procedure WMContextMenu(var Message: TWMContextMenu); message WM_CONTEXTMENU;
    {$endif}
    procedure WMRButtonUp(var Message: TWMRButtonUp); message WM_RBUTTONUP;

    property ClicksDisabled : Boolean read FClicksDisabled write FClicksDisabled;
    procedure Notification(AComponent : TComponent; operation : TOperation); override;

    procedure SetDrawDefaultFrame(Value: Boolean);
    function GetArrowSize: Integer; virtual;
    function DoSaveShadows: Boolean;
    procedure SetImageIsAlphaBlended(Value: Boolean);
    procedure SetDrawFocusFrame(Value: Boolean);
    {$IFDEF HAS_HTML_RENDER}
    procedure SetCursor(Value: TCursor); virtual;
    {$endif}
    procedure SetChangeDisabledText(Value: Boolean);

    property PullDownMenu : TPopupMenu read FPullDownMenu write SetPullDownMenu; { Published }
    property PopupPlace : TPopupPlace read FPopupPlace write SetPopupPlace default ppDown;
    property DisableAutoPopup : boolean read FDisableAp write SetDisableAp default false;
    property Cancel : Boolean read FCancel write FCancel default False;
    property Default : Boolean read FDefault write SetDefault default False;
    property ModalResult : TModalResult read FModalResult write FModalResult default 0;
    property AllowAllUp : Boolean read FAllowAllUp write SetAllowAllUp default False;
    property GroupIndex : Integer read FGroupIndex write SetGroupIndex default 0;
    property Down : Boolean read FDown write SetDown default False;
    property Flat : Boolean read FFlat write SetFlat default False;
    property Glyph : TBitmap read GetGlyph write SetGlyph;
    property Layout : TButtonLayout read FLayout write SetLayout default blGlyphLeft;
    property Margin : Integer read FMargin write SetMargin default -1;
    property NumGlyphs : TNumGlyphs read GetNumGlyphs write SetNumGlyphs;
    property Spacing : Integer read FSpacing write SetSpacing default 4;
    property ShowFocus : Boolean read FShowFocus write SetShowFocus default true;
    property UseArrow : Boolean read FUseArrow write SetUseArrow default False;
    property ShadowFollowsColor : boolean read FShadowFollowsColor write SetShadowFollowsColor default true;
    property ShowGlyph : Boolean read FShowGlyph write SetShowGlyph default true;
    property ShowText : Boolean read FShowText write SetShowText default true;
    property OnArrowClick : TNotifyEvent read FOnArrowClick write FOnArrowClick;
    property Icon : TIcon read GetIcon write SetIcon;
    property UseIcon : Boolean read FUseIcon write SetUseIcon default False;
    property IsSwitch : Boolean read FIsSwitch write SetIsSwitch default False;
{$IFDEF USE_SOUND_MAP}
    property DownSound : TElSoundName read FDownSound write FDownSound;
    property UpSound : TElSoundName read FUpSound write FUpSound;
    property ClickSound : TElSoundName read FClickSound write FClickSound; { Published }
    property ArrowClickSound : TElSoundName read FArrowClickSound write FArrowClickSound; { Published }
    property SoundMap : TElSoundMap read FSoundMap write SetSoundMap;
{$ENDIF}
    property ImageIndex : Integer read GetImageIndex write SetImageIndex default -1;
    property Images : TImageList read FImageList write SetImageList;
    property AlphaForImages : TImageList read FAlphaImageList write SetAlphaImageList;
    property DownImages : TImageList read FDownImages write SetDownImages;
    property AlphaForDownImages : TImageList read FAlphaDownImages write SetAlphaDownImages;
    property HotImages : TImageList read FHotImages write SetHotImages;
    property AlphaForHotImages : TImageList read FAlphaHotImages write SetAlphaHotImages;
    property DisabledImages : TImageList read FDisabledImages write SetDisabledImages;
    property AlphaForDisabledImages : TImageList read FAlphaDisabledImages write SetAlphaDisabledImages;
    {$ifdef ELPACK_USE_IMAGEFORM}
    property ImageForm      : TElImageForm read FImgForm write SetImageForm;
    {$endif}
    property ShowBorder     : boolean read FShowBorder write SetShowBorder default True;

    property ShadowsUseCustom  : boolean read FShadowsUseCustom write SetShadowsUseCustom default False;
    property ShadowBtnHighlight: TColor read FShadowBtnHighlight write SetShadowBtnHighlight stored DoSaveShadows;
    property ShadowBtnShadow   : TColor read FShadowBtnShadow write   SetShadowBtnShadow stored DoSaveShadows;
    property ShadowBtnDkShadow : TColor read FShadowBtnDkShadow write SetShadowBtnDkShadow stored DoSaveShadows;

    property UseImageList : Boolean read GetUseImageList write SetUseImageList default False;
    property OldStyled : Boolean read FOldStyled write SetOldStyled default False;
    property ThinFrame : Boolean read FThinFrame write SetThinFrame default False;
    property Background : TBitmap read FBackground write SetBackground;
    property DownBackground : TBitmap read FDownBackground write SetDownBackground;  { Protected }
    property BackgroundDrawBorder : boolean read FBackgroundDrawBorder write SetBackgroundDrawBorder default False;
    property AdjustSpaceForGlyph: Boolean read FAdjustSpaceForGlyph write
        SetAdjustSpaceForGlyph default true;
    property DrawDefaultFrame: Boolean read FDrawDefaultFrame write
        SetDrawDefaultFrame;
    property DrawFocusFrame: Boolean read FDrawFocusFrame write SetDrawFocusFrame
        default false;
    property ImageIsAlphaBlended: Boolean read FImageIsAlphaBlended write
        SetImageIsAlphaBlended default false;
    property ChangeDisabledText: Boolean read FChangeDisabledText write
        SetChangeDisabledText default true;
{$ifdef HAS_HTML_RENDER}
    property IsHTML : Boolean read FIsHTML write SetIsHTML default false;
    property OnImageNeeded: TElHTMLImageNeededEvent read FOnImageNeeded write
        FOnImageNeeded;
    property OnLinkClick: TElHTMLLinkClickEvent read FOnLinkClick write
        FOnLinkClick;
    property LinkColor: TColor read FLinkColor write SetLinkColor default clBlue;
    property LinkPopupMenu: TPopupMenu read FLinkPopupMenu write SetLinkPopupMenu;
    property LinkStyle: TFontStyles read FLinkStyle write SetLinkStyle;
    property Cursor: TCursor read FCursor write SetCursor;
{$endif}
    property Alignment: TAlignment read FAlignment write SetAlignment default taCenter;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure AClick(Arrow : boolean); virtual;
    procedure Click; override;
    procedure ButtonClick; virtual;
    property MouseInControl : Boolean read FMouseInControl;
    property MouseInArrow : Boolean read FMouseInArrow;
  end;
{$WARNINGS ON}

  TElPopupButton = class(TCustomElPopupButton)
  protected
    procedure MouseDown(Button : TMouseButton; Shift : TShiftState; X, Y : Integer); override;
    procedure DefineProperties(Filer: TFiler); override;
    procedure ReadImageIsAlphaBlended(Reader : TReader);
    procedure WMMouseActivate(var Message: TMessage); message WM_MOUSEACTIVATE;
//    property ImageIsAlphaBlended;
  published
    property Alignment;
    property Background;
    property BackgroundDrawBorder;
    property DownBackground;
    property ImageIndex;
    property UseImageList;
    property Images;
    property AlphaForImages;
    property AlphaForHotImages;
    property AlphaForDisabledImages;
    property AlphaForDownImages;
    property HotImages;
    property DisabledImages;
    property DrawDefaultFrame;
    property DrawFocusFrame;
    property PullDownMenu;
    property PopupPlace;
    property DisableAutoPopup;
    property Cancel;
    property Default;
    property ModalResult;
    property MoneyFlat;
    property MoneyFlatActiveColor;
    property MoneyFlatInactiveColor;
    property MoneyFlatDownColor;
    property AdjustSpaceForGlyph;
    property AllowAllUp;
    property GroupIndex;
    property Down;
    property Flat;
    property Glyph;
    {$ifdef ELPACK_USE_IMAGEFORM}
    property ImageForm;
    {$endif}
{$ifdef HAS_HTML_RENDER}
    property IsHTML;
{$endif}
    {$ifdef HAS_HTML_RENDER}
    property LinkColor;
    property LinkPopupMenu;
    property LinkStyle;
    {$endif}
    property Layout;
    property Margin;
    property NumGlyphs;
    property ShadowFollowsColor;
    property ShadowsUseCustom;
    property ShadowBtnHighlight;
    property ShadowBtnShadow;
    property ShadowBtnDkShadow;

    property ShowFocus;
    property ShowGlyph;
    property ShowText;
    property Spacing;
    property UseArrow;
    property IsSwitch;
    property OnArrowClick;
    property Icon;
    property UseIcon;
    property ThinFrame;
    property TextDrawType;
    property Transparent;
{$IFDEF USE_SOUND_MAP}
    property DownSound;
    property UpSound;
    property ClickSound;
    property ArrowClickSound;
    property SoundMap;
{$ENDIF}
    property DownImages;
    property ShowBorder;
    property OldStyled;
    property UseXPThemes;

    // VCL properties
    property Caption;
    property Cursor;
    property Enabled;
    property TabStop default True;
    property TabOrder;
    property PopupMenu;
    property Color;
    property ParentColor;
    property Align;
    property Font;
    property HelpContext;
    property ParentFont;
    property ParentShowHint;
    property ShowHint;
    property Visible;

    {$IFDEF HAS_HTML_RENDER}
    property OnImageNeeded;
    property OnLinkClick;
    {$endif}
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnKeyDown;
    property OnKeyUp;
    property OnKeyPress;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnStartDrag;

{$IFDEF VCL_4_USED}
    property Anchors;
    property Action;
    property Constraints;
    property DockOrientation;
    property Floating;
    property BevelKind;
    property DoubleBuffered;
    property DragKind;

    property OnStartDock;
    property OnEndDock;
{$IFDEF VCL_5_USED}
    property OnContextPopup;
{$ENDIF}
    {$endif}
  end;

{$IFDEF VCL_4_USED}
  TElPopupButtonActionLink = class(TElButtonActionlink)
  protected
    procedure SetImageIndex(Value: Integer); override;
    procedure SetChecked(Value : boolean); override;
  end;
{$ENDIF}

{$WARNINGS OFF}
  TCustomElGraphicButton = class(TGraphicControl)
  protected
    FNumGlyphs: Integer;
    FMenuWindowProc: TWndMethod;
    {$IFDEF HAS_HTML_RENDER}
    FCursor: TCursor;
    {$endif}
    FShadowsUseCustom : boolean;
    FShadowBtnHighlight,
    FShadowBtnShadow,
    FShadowBtnDkShadow : TColor;
    FBackground : TBitmap;
    FShadowFollowsColor : boolean;
    FDownBackground : TBitmap;
    FBackgroundDrawBorder : boolean;
    FThinFrame : Boolean;
    FAlphaImageList,
    FAlphaHotImages,
    FAlphaDownImages,
    FAlphaDisabledImages,
    FHotImages,
    FDownImages,
    FDisabledImages,
    FImageList : TImageList;
    FOldStyled : Boolean;
    FUseImageList : boolean;
    FUseIcon : Boolean;
{$IFDEF USE_SOUND_MAP}
    FSoundMap : TElSoundMap;
    FDownSound : TElSoundName;
    FUpSound : TElSoundName;
    FClickSound : TElSoundName;
    FArrowClickSound : TElSoundName;
{$ENDIF}
    FIsSwitch : Boolean;
    FShowGlyph: Boolean;
    FShowText : Boolean;
    FUseArrow : Boolean;
    FMultiLine : Boolean;
    FGroupIndex : Integer;
    FGlyph : TElButtonGlyph;
    FDown : Boolean;
    FArrDown : boolean;
    FInMenu,
    FIgnoreClick  : boolean;
    FDragging : Boolean;
    FAllowAllUp : Boolean;
    FLayout : TButtonLayout;
    FSpacing : Integer;
    FMargin : Integer;
    FFlat : Boolean;
    FMouseInArrow,
    FMouseInControl : Boolean;
    FDisableAp : boolean;
    FPopupPlace : TPopupPlace;
    FDefault : Boolean;
    FCancel : Boolean;
    FModalResult : TModalResult;
    FClicksDisabled : Boolean;
    FAChLink,
    FAHChLink,
    FANChLink,
    FADChLink,
    FChLink,
    FNChLink,
    FDChLink,
    FHChLink : TChangeLink;
    FPullDownMenu : TPopupMenu;
    FOnArrowClick : TNotifyEvent;
    FTransparent  : boolean;
    FTextDrawType : TElTextDrawType;
    {$ifdef ELPACK_USE_IMAGEFORM}
    FImgForm      : TElImageForm;
    FImgFormChLink  : TImgFormChangeLink;
    {$endif}
    {$IFDEF ELPACK_USE_STYLEMANAGER}
    FStyleMgrLink : TElStyleMgrChangeLink;
    FStyleManager: TElStyleManager;
    FStyleName: string;
    {$endif}
    FShowBorder   : boolean;
    FAdjustSpaceForGlyph: Boolean;
    {$IFDEF HAS_HTML_RENDER}
    FLinkColor: TColor;
    FLinkPopupMenu: TPopupMenu;
    FLinkStyle: TFontStyles;
    {$endif}
    {$ifdef HAS_HTML_RENDER}
    FIsHTML  : Boolean;
    FRender  : TElHTMLRender;
    {$endif}
    {$IFDEF HAS_HTML_RENDER}
    FOnImageNeeded: TElHTMLImageNeededEvent;
    FOnLinkClick: TElHTMLLinkClickEvent;
    {$endif}

    FUseXPThemes: Boolean;
    FTheme: HTheme;
    FArrTheme: HTheme;
    FWnd: HWND;
    FAlignment: TAlignment;

    procedure SetAlignment(Value: TAlignment);
{$ifdef HAS_HTML_RENDER}
    procedure SetIsHTML(Value: Boolean);
{$endif}
    function  IsColorStored : boolean;
    procedure SetShowBorder(newValue : boolean);
    {$ifdef ELPACK_USE_IMAGEFORM}
    procedure ImageFormChange(Sender : TObject);
    procedure SetImageForm(newValue : TElImageForm);
    {$endif}
    procedure SetTransparent(newValue : Boolean); virtual;
    procedure SetTextDrawType(newValue : TElTextDrawType);
    procedure SetPullDownMenu(newValue : TPopupMenu);

    procedure SetPopupPlace(Value : TPopupPlace);
    procedure SetDisableAp(Value : boolean);
    procedure GlyphChanged(Sender : TObject);
    procedure UpdateExclusive;
    function GetGlyph : TBitmap;
    procedure SetGlyph(Value : TBitmap);
    function GetNumGlyphs : TNumGlyphs;
    procedure SetNumGlyphs(Value : TNumGlyphs);
    procedure SetDown(Value : Boolean);
    procedure SetAllowAllUp(Value : Boolean);
    procedure SetGroupIndex(Value : Integer);
    procedure SetLayout(Value : TButtonLayout); virtual;
    procedure SetSpacing(Value : Integer); virtual;
    procedure SetMargin(Value : Integer); virtual;
    procedure UpdateTracking;

    procedure IntMouseEnter;
    procedure IntMouseLeave;
    procedure IntEnabledChanged;
    procedure IntTextChanged;


    procedure CMEnabledChanged(var Message : TMessage); message CM_ENABLEDCHANGED;
    procedure CMButtonPressed(var Message : TMessage); message CM_BUTTONPRESSED;
    procedure CMDialogKey(var Message : TCMDialogKey); message CM_DIALOGKEY;
    procedure CMDialogChar(var Message : TCMDialogChar); message CM_DIALOGCHAR;
    procedure CMFontChanged(var Message : TMessage); message CM_FONTCHANGED;
    procedure CMTextChanged(var Message : TMessage); message CM_TEXTCHANGED;
    procedure CMColorChanged(var Message : TMessage); message CM_COLORCHANGED;
    procedure CMSysColorChange(var Message : TMessage); message CM_SYSCOLORCHANGE;
    procedure CMMouseEnter(var Message : TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message : TMessage); message CM_MOUSELEAVE;
    procedure ELThemeChanged(var Message: TMessage); message EL_THEMECHANGED;
    procedure WMIsThemedControl(var Message: TMessage); message WM_ISTHEMEDCONTROL;

    procedure SetShowGlyph(newValue: Boolean); virtual;
    procedure SetShowText(newValue : Boolean); virtual;
    function GetIcon : TIcon;
    procedure SetIcon(newValue : TIcon);
    procedure SetIsSwitch(newValue : Boolean);
{$IFDEF USE_SOUND_MAP}
    procedure SetSoundMap(newValue : TElSoundMap);
{$ENDIF}
    procedure SetImageIndex(newValue : Integer); virtual;
    function GetImageIndex : integer;
    procedure SetUseIcon(newValue : Boolean); virtual;
    procedure SetImageList(newValue : TImageList); virtual;
    procedure SetAlphaImageList(newValue: TImageList); virtual;
    procedure SetUseImageList(newValue : Boolean); virtual;
    function GetUseImageList : boolean;
    procedure SetOldStyled(newValue : Boolean);
    procedure SetDownImages(newValue : TImageList);
    procedure SetAlphaDownImages(newValue : TImageList);
    procedure SetHotImages(newValue : TImageList);
    procedure SetAlphaHotImages(newValue : TImageList);
    procedure SetDisabledImages(newValue : TImageList);
    procedure SetAlphaDisabledImages(newValue : TImageList);
    procedure ImagesChanged(Sender : TObject); virtual;
    procedure SetThinFrame(newValue : Boolean);
    procedure SetBackground(newValue : TBitmap);
    procedure SetDownBackground(newValue : TBitmap);
    procedure SetBackgroundDrawBorder(Value : boolean);
    procedure SetShadowFollowsColor(Value : Boolean);
    procedure SetShadowsUseCustom(Value : Boolean);
    procedure SetShadowBtnHighlight(Value : TColor);
    procedure SetShadowBtnShadow(Value : TColor);
    procedure SetShadowBtnDkShadow(Value : TColor);
    procedure SetAdjustSpaceForGlyph(Value: Boolean);
    procedure SetUseXPThemes(const Value: Boolean);

    procedure CreateThemeHandle;
    procedure FreeThemeHandle;

  protected
    FOrigState,
    FState : TElButtonState;
    FCaption: TElFString;

    {$ifdef ELPACK_UNICODE}
    FHint: TElFString;
    {$endif}

    FMoneyFlat: Boolean;
    FMoneyFlatDownColor: TColor;
    FMoneyFlatActiveColor: TColor;
    FMoneyFlatInactiveColor: TColor;
    FShortcutsEnabled: Boolean;
    FImageIsAlphaBlended: Boolean;
    FTextRect: TRect;
    FChangeDisabledText: Boolean;

    {$IFDEF HAS_HTML_RENDER}
    procedure SetLinkPopupMenu(newValue : TPopupMenu);
    procedure SetLinkColor(newValue : TColor); virtual;
    procedure SetLinkStyle(newValue : TFontStyles); virtual;
    procedure DoLinkPopup(MousePos : TPoint);
    procedure TriggerImageNeededEvent(Sender : TObject; Src : TElFString; var Image
        : TBitmap);
    procedure TriggerLinkClickEvent(HRef : TElFString); virtual;
    {$endif}

    {$ifdef VCL_5_USED}
    procedure WMContextMenu(var Message: TWMContextMenu); message WM_CONTEXTMENU;
    {$endif}
    procedure WMRButtonUp(var Message: TWMRButtonUp); message WM_RBUTTONUP;

    procedure SetUseArrow(newValue : boolean); virtual;
    function GetPalette : HPALETTE; override;
    procedure Loaded; override;
    procedure MouseDown(Button : TMouseButton; Shift : TShiftState;
      X, Y : Integer); override;
    procedure MouseMove(Shift : TShiftState; X, Y : Integer); override;
    procedure MouseUp(Button : TMouseButton; Shift : TShiftState;
      X, Y : Integer); override;
    procedure Paint; override;
    procedure WndProc(var Message : TMessage); override;
    procedure SetFlat(Value : Boolean); virtual;
    function GetChecked : Boolean; virtual;
    procedure SetChecked(newValue : Boolean); virtual;
{$IFDEF VCL_4_USED}
    function GetActionLinkClass : TControlActionLinkClass; override;
    procedure ActionChange(Sender : TObject; CheckDefaults : Boolean); override;
{$ENDIF}
    function DoSaveShadows : boolean;

    {$ifdef ELPACK_UNICODE}
    procedure CMHintShow(var Message: TMessage); message CM_HINTSHOW;
    {$endif}

    procedure Notification(AComponent : TComponent; operation : TOperation); override;

    procedure SetCaption(Value: TElFString);
    {$ifdef ELPACK_USE_IMAGEFORM}
    procedure IFMRepaintChildren(var Message: TMessage); message
        IFM_REPAINTCHILDREN;
    {$endif}
    function GetThemePartID: Integer; virtual;
    function GetThemeStateID: Integer; virtual;
    function GetThemedClassName: WideString; virtual;
    function GetArrowThemePartID: Integer; virtual;
    function GetArrowThemeStateID: Integer; virtual;
    function GetArrowThemedClassName: WideString; virtual;

    function GetArrowSize: Integer; virtual;
    {$ifdef MSWINDOWS}
    procedure DrawThemedBackground(Canvas : TCanvas); virtual;
    {$endif}
    procedure WMWindowPosChanged(var Message: TMessage); message WM_WINDOWPOSCHANGED;
    function MeasureButton(LockHeight : boolean): TPoint;

    procedure SetMoneyFlat(Value: Boolean);
    procedure SetMoneyFlatDownColor(Value: TColor);
    procedure SetMoneyFlatActiveColor(Value: TColor);
    procedure SetMoneyFlatInactiveColor(Value: TColor);
    function GetMoneyFlat: Boolean;

    procedure IntWndProc(var Message : TMessage);
    procedure DoPullMenu; virtual;
    procedure SetShortcutsEnabled(Value: Boolean);
    function Focused: Boolean; virtual;
    procedure SetImageIsAlphaBlended(Value: Boolean);
    {$ifdef ELPACK_UNICODE}
    procedure SetHint(Value: TElFString);
    {$endif}
    {$IFDEF HAS_HTML_RENDER}
    procedure SetCursor(Value: TCursor); virtual;
    {$endif}
    procedure SetChangeDisabledText(Value: Boolean);
    {$ifdef ELPACK_USE_STYLEMANAGER}
    procedure SetStyleManager(Value: TElStyleManager);
    procedure SetStyleName(const Value: string);
    procedure StyleMgrChange(Sender : TObject);
    procedure UpdateStyle;
    {$endif}

    function GetShowGlyph: Boolean; virtual;

    property ClicksDisabled : Boolean read FClicksDisabled write FClicksDisabled;

    property PullDownMenu : TPopupMenu read FPullDownMenu write SetPullDownMenu; { Published }
    property PopupPlace : TPopupPlace read FPopupPlace write SetPopupPlace default ppDown;
    property DisableAutoPopup : boolean read FDisableAp write SetDisableAp default false;
    property Cancel : Boolean read FCancel write FCancel default False;
    property ModalResult : TModalResult read FModalResult write FModalResult default 0;
    property AllowAllUp : Boolean read FAllowAllUp write SetAllowAllUp default False;
    property GroupIndex : Integer read FGroupIndex write SetGroupIndex default 0;
    property Down : Boolean read FDown write SetDown default False;
    property Flat : Boolean read FFlat write SetFlat default false;
    property Glyph : TBitmap read GetGlyph write SetGlyph;
    property Layout : TButtonLayout read FLayout write SetLayout default blGlyphLeft;
    property Margin : Integer read FMargin write SetMargin default -1;
    property NumGlyphs : TNumGlyphs read GetNumGlyphs write SetNumGlyphs;
    property Spacing : Integer read FSpacing write SetSpacing default 4;

    property UseArrow : Boolean read FUseArrow write SetUseArrow default False;
    property ShadowFollowsColor : boolean read FShadowFollowsColor write SetShadowFollowsColor default true;
    property ShowGlyph: Boolean read GetShowGlyph write SetShowGlyph default true;
    property ShowText : Boolean read FShowText write SetShowText default true;
    property OnArrowClick : TNotifyEvent read FOnArrowClick write FOnArrowClick;
    property Icon : TIcon read GetIcon write SetIcon;
    property UseIcon : Boolean read FUseIcon write SetUseIcon default false; { Protected }
    property IsSwitch : Boolean read FIsSwitch write SetIsSwitch default false;
{$IFDEF USE_SOUND_MAP}
    property DownSound : TElSoundName read FDownSound write FDownSound; { Published }
    property UpSound : TElSoundName read FUpSound write FUpSound; { Published }
    property ClickSound : TElSoundName read FClickSound write FClickSound; { Published }
    property ArrowClickSound : TElSoundName read FArrowClickSound write FArrowClickSound; { Published }
    property SoundMap : TElSoundMap read FSoundMap write SetSoundMap;
{$ENDIF}
    property ImageIndex : Integer read GetImageIndex write SetImageIndex default -1;
    property Images : TImageList read FImageList write SetImageList;
    property AlphaForImages: TImageList read FAlphaImageList write SetAlphaImageList;
    property AlphaForHotImages : TImageList read FAlphaHotImages write SetAlphaHotImages;
    property AlphaForDisabledImages : TImageList read FAlphaDisabledImages write SetAlphaDisabledImages;
    property AlphaForDownImages : TImageList read FAlphaDownImages write SetAlphaDownImages;
    property HotImages : TImageList read FHotImages write SetHotImages;
    property DisabledImages : TImageList read FDisabledImages write SetDisabledImages;
    property DownImages     : TImageList read FDownImages write SetDownImages;
    {$ifdef ELPACK_USE_IMAGEFORM}
    property ImageForm      : TElImageForm read FImgForm write SetImageForm;
    {$endif}
    property ShowBorder     : boolean read FShowBorder write SetShowBorder default true;

    property ShadowsUseCustom  : boolean read FShadowsUseCustom write SetShadowsUseCustom default false;
    property ShadowBtnHighlight: TColor read FShadowBtnHighlight write SetShadowBtnHighlight stored DoSaveShadows default $00F7F7F5;
    property ShadowBtnShadow   : TColor read FShadowBtnShadow write   SetShadowBtnShadow stored DoSaveShadows default $00767A60;
    property ShadowBtnDkShadow : TColor read FShadowBtnDkShadow write SetShadowBtnDkShadow stored DoSaveShadows default $00595C48;

    property UseImageList : Boolean read GetUseImageList write SetUseImageList default false; { Protected }
    property OldStyled : Boolean read FOldStyled write SetOldStyled default false; { Protected }
    property ThinFrame : Boolean read FThinFrame write SetThinFrame default false;  { Protected }
    property Background : TBitmap read FBackground write SetBackground;  { Protected }
    property DownBackground : TBitmap read FDownBackground write SetDownBackground;  { Protected }
    property BackgroundDrawBorder : boolean read FBackgroundDrawBorder write SetBackgroundDrawBorder default false;
    property Transparent : boolean read FTransparent write SetTransparent default false;
    property TextDrawType : TElTextDrawType read FTextDrawType write SetTextDrawType default tdtNormal; { Published }
    property Checked : Boolean read GetChecked write SetChecked default false; { Protected }
    property Color stored IsColorStored nodefault;
    property AdjustSpaceForGlyph: Boolean read FAdjustSpaceForGlyph write
        SetAdjustSpaceForGlyph default true;
    property Caption: TElFString read FCaption write SetCaption;

    property UseXPThemes: Boolean read FUseXPThemes write SetUseXPThemes default
        True;

    property MoneyFlat: Boolean read GetMoneyFlat write SetMoneyFlat default false;
    property MoneyFlatDownColor: TColor read FMoneyFlatDownColor write
        SetMoneyFlatDownColor stored GetMoneyFlat;
    property MoneyFlatActiveColor: TColor read FMoneyFlatActiveColor write
        SetMoneyFlatActiveColor  stored GetMoneyFlat;
    property MoneyFlatInactiveColor: TColor read FMoneyFlatInactiveColor write
        SetMoneyFlatInactiveColor  stored GetMoneyFlat;
    property ImageIsAlphaBlended: Boolean read FImageIsAlphaBlended write
        SetImageIsAlphaBlended default false;
    property ChangeDisabledText: Boolean read FChangeDisabledText write
        SetChangeDisabledText default true;
    property Alignment: TAlignment read FAlignment write SetAlignment default
        taCenter;

{$ifdef HAS_HTML_RENDER}
    property IsHTML : Boolean read FIsHTML write SetIsHTML default false;

    property OnImageNeeded: TElHTMLImageNeededEvent read FOnImageNeeded write
        FOnImageNeeded;
    property OnLinkClick: TElHTMLLinkClickEvent read FOnLinkClick write
        FOnLinkClick;
    property LinkColor: TColor read FLinkColor write SetLinkColor default clBlue;
    property LinkPopupMenu: TPopupMenu read FLinkPopupMenu write SetLinkPopupMenu;
    property LinkStyle: TFontStyles read FLinkStyle write SetLinkStyle;
    property Cursor: TCursor read FCursor write SetCursor;
    {$endif}
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure AClick(Arrow : boolean); virtual;

    function IsThemeApplied: Boolean;
    procedure Click; override;
    procedure ButtonClick; virtual;
    property MouseInControl : Boolean read FMouseInControl;
    property MouseInArrow : Boolean read FMouseInArrow;
    property Theme: HTheme read FTheme;
    property MenuWindowProc: TWndMethod read FMenuWindowProc write FMenuWindowProc;
    property ShortcutsEnabled: Boolean read FShortcutsEnabled write
        SetShortcutsEnabled default false;
  published
    {$ifdef ELPACK_UNICODE}
    property Hint: TElFString read FHint write SetHint;
    {$endif}
    {$ifdef ELPACK_USE_STYLEMANAGER}
    property StyleManager: TElStyleManager read FStyleManager write SetStyleManager;
    property StyleName: string read FStyleName write SetStyleName;
    {$endif}
  end;
{$WARNINGS ON}

  TCustomElGraphicButtonClass = class of TCustomElGraphicButton;

  TElGraphicButton = class(TCustomElGraphicButton)
  protected
    procedure DefineProperties(Filer: TFiler); override;
    procedure ReadImageIsAlphaBlended(Reader : TReader);
  published
    property Alignment;
    property Background;
    property BackgroundDrawBorder;
    property DownBackground;
//    property ImageIsAlphaBlended;
    property ImageIndex;
    property UseImageList;
    property Images;
    property HotImages;
    property DisabledImages;
    property AlphaForImages;
    property AlphaForHotImages;
    property AlphaForDisabledImages;
    property AlphaForDownImages;
    property PullDownMenu;
    property PopupPlace;
    property DisableAutoPopup;
    property Cancel;
    property ChangeDisabledText;

    property ModalResult;

    property MoneyFlat;
    property MoneyFlatInactiveColor;
    property MoneyFlatActiveColor;
    property MoneyFlatDownColor;

    property AdjustSpaceForGlyph;
    property AllowAllUp;
    property GroupIndex;
    property Down;
    property Flat;
    property Glyph;
    {$ifdef ELPACK_USE_IMAGEFORM}
    property ImageForm;
    {$endif}
{$ifdef HAS_HTML_RENDER}
    property IsHTML;
{$endif}
    property Layout;

    property Margin;
    property NumGlyphs;
    property ShadowFollowsColor;
    property ShadowsUseCustom;
    property ShadowBtnHighlight;
    property ShadowBtnShadow;
    property ShadowBtnDkShadow;

    property ShowGlyph;
    property ShowText;
    property Spacing;
    property UseArrow;
    property IsSwitch;
    property OnArrowClick;
    property Icon;
    {$ifdef HAS_HTML_RENDER}
    property LinkColor;
    property LinkPopupMenu;
    property LinkStyle;
    {$endif}
    property UseIcon;
    property ThinFrame;
    property TextDrawType;
    property Transparent;
{$IFDEF USE_SOUND_MAP}
    property DownSound;
    property UpSound;
    property ClickSound;
    property ArrowClickSound;
    property SoundMap;
{$ENDIF}
    property DownImages;
    property ShowBorder;
    property ShortcutsEnabled;
    property OldStyled;
    property UseXPThemes;

    // VCL properties
    property Caption;
    property Cursor;
    property Enabled;
    property PopupMenu;
    property Color;
    property ParentColor;
    property Align;
    property Font;
    property ParentFont;
    property ParentShowHint;
    property ShowHint;
    property Visible;
    {$IFDEF HAS_HTML_RENDER}
    property OnImageNeeded;
    property OnLinkClick;
    {$endif}

    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnStartDrag;

{$IFDEF VCL_4_USED}
    property Anchors;
    property Action;
    property Constraints;
    property DockOrientation;
    property Floating;
    property DragKind;

    property OnStartDock;
    property OnEndDock;
{$IFDEF VCL_5_USED}
    property OnContextPopup;
{$ENDIF}
    {$endif}
  end;

{$IFDEF VCL_4_USED}
  TElGraphicButtonActionLink = class(TControlActionLink)
  protected
    FClient : TCustomElGraphicButton;
    procedure AssignClient(AClient : TObject); override;
    function IsCheckedLinked : Boolean; override;
    function IsImageIndexLinked : Boolean; override;
    function IsHintLinked: Boolean; override;
    function IsCaptionLinked: Boolean; override;

    procedure SetImageIndex(Value: Integer); override;
    procedure SetChecked(Value : Boolean); override;
    procedure SetCaption(const Value: string); override;
    procedure SetHint(const Value: string); override;
  public
  end;
{$ENDIF}

var MenuCancelMsg : Cardinal;


function GetMenuHandle(AMenu : TMenu) : HMENU;

implementation

{$ifdef ELPACK_COMPLETE}
uses ElMenus;
{$endif}
var FArrow : TBitmap;

function GetMenuHandle(AMenu : TMenu) : HMENU;
begin
{$ifndef ELPACK_SINGLECOMP}
  if AMenu is TElPopupMenu then
    result := TElPopupMenu(AMenu).Handle
  else
  if AMenu is TElMainMenu then
    result := TElMainMenu(AMenu).Handle
  else
{$endif}
    result := AMenu.Handle;
end;

type THackGlyph = class(TElButtonGlyph) end;

// =============================================================================

procedure TElPopupButton.MouseDown;
begin
  inherited;
end;

procedure TElPopupButton.ReadImageIsAlphaBlended(Reader : TReader);
begin
  Reader.ReadBoolean;
end;

procedure TElPopupButton.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('ImageIsAlphaBlended', ReadImageIsAlphaBlended, nil, false);
end;

procedure TElPopupButton.WMMouseActivate(var Message: TMessage);
begin
//  Message.Result := MA_ACTIVATE;
  try
    if CanFocus and TabStop then
    begin
      SetFocus;
      if GetFocus <> Handle then
        FIgnoreMouseDown := true;
    end;
  except
  end;
  inherited;
end;


// =============================================================================

procedure TElGraphicButton.ReadImageIsAlphaBlended(Reader : TReader);
begin
  Reader.ReadBoolean;
end;

procedure TElGraphicButton.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('ImageIsAlphaBlended', ReadImageIsAlphaBlended, nil, false);
end;

// =============================================================================

function TCustomElPopupButton.GetChecked : Boolean;
begin
  result := Down;
end;

procedure TCustomElPopupButton.SetChecked(newValue : Boolean);
begin
  Down := newValue;
end;

procedure TCustomElPopupButton.SetDefault(Value : Boolean);
var
{$IFNDEF VER90}
  Form : TCustomForm;
{$ELSE}
  Form : TForm;
{$ENDIF}
begin
  FDefault := Value;
  if HandleAllocated then
  begin
    Form := GetParentForm(Self);
    if Form <> nil then
      Form.Perform(CM_FOCUSCHANGED, 0, Longint(Form.ActiveControl));
  end;
  if DrawDefaultFrame then
    Invalidate;
end;

procedure TCustomElPopupButton.SetPopupPlace(Value : TPopupPlace);
begin
  FPopupPlace := Value;
end;

procedure TCustomElPopupButton.SetDisableAp(Value : boolean);
begin
  FDisableAp := Value;
end;

procedure TCustomElPopupButton.Paint;
var
  PaintRect, R,
  R1, BgRect : TRect;
  ArrRect    : TRect;
  Offset     : TPoint;
  dw : integer;
  aw : integer;
  AColor : TColor;
  ACtl   : TWinControl;
  ax, ay : integer;
  OldP,
  P      : TPoint;
  SaveIL : TImageList;
  SaveAIL : TImageList;
  GlyphState : TElButtonState;
  {$ifdef MSWINDOWS}
  sID, sID1  : integer;
  RClip   : TRect;
  {$endif}

  Canvas  : TCanvas;
  Bitmap  : TBitmap;


  procedure DrawButtonFrameEx(DC : HDC; rc : TRect; Focused : boolean; Pushed : boolean; ButtonColor : TColor; Thin : boolean);
  begin
    if ShadowsUseCustom then
       ElVCLUtils.DrawButtonFrameEx2(DC, rc, Focused, Pushed, ButtonColor, Thin,
         ColorToRGB(FShadowBtnHighlight), ColorToRGB(FShadowBtnDkShadow), ColorToRGB(Color), ColorToRGB(FShadowBtnShadow), AllBorderSides)
    else
       ElVCLUtils.DrawButtonFrameEx3(DC, rc, Focused, Pushed, ButtonColor, Thin, AllBorderSides);
  end;

begin
  {$ifdef MSWINDOWS}
  sid := 0;
  {$endif}

  SaveIL := nil;
  SaveAIL := nil;
  Bitmap := Tbitmap.Create;
  Bitmap.Width := ClientWidth;
  Bitmap.Height := ClientHeight;
  Canvas := Bitmap.Canvas;
  {$ifdef MSWINDOWS}
  if IsThemeApplied then
  begin
    // DrawThemeParentBackground(Handle, Self.Canvas.Handle, ClientRect);
    P := Point(Left, Top);
    SetMapMode(Bitmap.Canvas.Handle, MM_ANISOTROPIC);
    SetViewPortOrgEx(Bitmap.Canvas.Handle, -P.x, -P.y, @OldP);
    SendMessage(Parent.Handle, WM_ERASEBKGND, Bitmap.Canvas.Handle, 0);
    SetViewPortOrgEx(Bitmap.Canvas.Handle, OldP.x, OldP.y, nil);
    SetMapMode(Bitmap.Canvas.Handle, MM_TEXT);
  end;
  {$endif}

  if (not Enabled) or (not Parent.Enabled) then
  begin
    FState := ebsDisabled;
    FDragging := False;
  end
  else
  if FState = ebsDisabled then
    if FDown and (GroupIndex <> 0) then
      FState := ebsExclusive
    else
      FState := ebsUp;
  Canvas.Font := Self.Font;
  PaintRect := ClientRect;

  if FShadowFollowsColor then
    AColor := Color
  else
    AColor := clBtnFace;

  {$ifdef MSWINDOWS}
  if not IsThemeApplied then
  {$endif}
  begin
    if not Transparent then
    begin
      {$ifdef ELPACK_USE_IMAGEFORM}
      if (FImgForm <> nil) and (not (csDesigning in FImgForm.GetRealControl.ComponentState)) then
      begin
        if (FImgForm.Control <> Self) then
        begin
          ACtl := FImgForm.GetRealControl;
          R1 := PaintRect;
          BgRect := R1;
          BgRect.TopLeft := ClientToScreen(BgRect.TopLeft);
          P := Parent.ClientToScreen(Point(Left, Top));
          ax := BgRect.Left - P.x;
          ay := BgRect.Top - P.y;

          BgRect.BottomRight := ClientToScreen(BgRect.BottomRight);
          BgRect.TopLeft := ACtl.ScreenToClient(BgRect.TopLeft);
          BgRect.BottomRight := ACtl.ScreenToClient(BgRect.BottomRight);
          FImgForm.PaintBkgnd(Canvas.Handle, R1, Point(BgRect.Left - ax, BgRect.Top - ay), false);
        end
      end;
      {$endif}
      begin
        Canvas.Brush.Color := Color;
        if ((FDown and FIsSwitch) or (FState in [ebsDown, ebsExclusive])) then
        begin
          if (not FDownBackground.Empty) then
            Canvas.CopyRect(ClientRect, DownBackground.Canvas, Rect(0, 0, DownBackground.Width, DownBackground.Height))
          else
          {$ifdef ELPACK_USE_IMAGEFORM}
          if (FImgForm = nil) or (csDesigning in FImgForm.GetRealControl.ComponentState) then
          {$endif}
            Canvas.FillRect(PaintRect);
        end
        else
        begin
          if (not Background.Empty) then
            Canvas.CopyRect(ClientRect, Background.Canvas, Rect(0, 0, Background.Width, Background.Height))
          else
          {$ifdef ELPACK_USE_IMAGEFORM}
          if (FImgForm = nil) or (csDesigning in FImgForm.GetRealControl.ComponentState) then
          {$endif}
            Canvas.FillRect(PaintRect);
        end;
      end;
    end
    else
    begin
      GetClipBox(Self.Canvas.Handle, PaintRect);
      OffsetRect(PaintRect, Left, Top);
      RedrawWindow(Parent.Handle, @PaintRect, 0, RDW_ERASE or RDW_INVALIDATE or RDW_NOCHILDREN or RDW_UPDATENOW);
      OffsetRect(PaintRect, -Left, -Top);
      bitblt(Canvas.Handle, PaintRect.Left, PaintRect.Top, PaintRect.Right - PaintRect.Left, PaintRect.Bottom - PaintRect.Top, Self.Canvas.Handle, PaintRect.Left, PaintRect.Top, SRCCOPY);
    end
    ;
    PaintRect := ClientRect;
  end
  ;

  dw := 0;
  aw := 0;

  if {$ifdef MSWINDOWS}(not IsThemeApplied) and {$endif}((Default and DrawDefaultFrame) or (Focused and DrawFocusFrame)) then
  begin
    if FUseArrow then
    begin
      dw := GetArrowSize;
      aw := dw;
      Dec(PaintRect.Right, dw);
    end;

    if MoneyFlat then
    begin
      if (FDown and FIsSwitch) or (FState in [ebsDown, ebsExclusive]) then
        Canvas.Brush.Color := MoneyFlatDownColor
      else
      if (FMouseInControl or FMouseInArrow) and (FState <> ebsDisabled) then
        Canvas.Brush.Color := MoneyFlatActiveColor
      else
        Canvas.Brush.Color := MoneyFlatInactiveColor;
      Canvas.FrameRect(PaintRect);
      PaintRect := ClientRect;
      if not FUseArrow then
        InflateRect(PaintRect, -1, -1);
    end
    else
    begin
      if not OldStyled then
        Canvas.Brush.Color := clBtnShadow
      else
        Canvas.Brush.Color := cl3DDkShadow;

      Canvas.FrameRect(PaintRect);
      PaintRect := ClientRect;
      if not FUseArrow then
        InflateRect(PaintRect, -1, -1);

    end;
  end;
  {$ifdef MSWINDOWS}
  if (not IsThemeApplied) or (FArrTheme = 0) then
  {$endif}
  begin
    if not FFlat then
    begin
      if FUseArrow then
      begin
        dw := GetArrowSize;
        aw := dw;
        Dec(PaintRect.Right, dw);
      end;
      if ((Background.Empty) or (BackgroundDrawBorder)) and (ShowBorder or (csDesigning in ComponentState)) then
      begin
        if MoneyFlat then
        begin
          if (FDown and FIsSwitch) or (FState in [ebsDown, ebsExclusive]) then
            Canvas.Brush.Color := MoneyFlatDownColor
          else
          if (FMouseInControl or FMouseInArrow) and (FState <> ebsDisabled) then
            Canvas.Brush.Color := MoneyFlatActiveColor
          else
            Canvas.Brush.Color := MoneyFlatInactiveColor;
          Canvas.FrameRect(PaintRect);
        end
        else
        begin
          if OldStyled or ((FMouseInControl or Focused) and
             (not ((FDown and FIsSwitch) or (FState in [ebsDown, ebsExclusive])))) then
             DrawButtonFrameEx(Canvas.Handle, PaintRect, (not ThinFrame),
                             (FDown and FIsSwitch) or (FState in [ebsDown, ebsExclusive]), AColor, ThinFrame)
          else
             DrawButtonFrameEx(Canvas.Handle, PaintRect, FOldStyled,
                             (FDown and FIsSwitch) or (FState in [ebsDown, ebsExclusive]), AColor, ThinFrame);
        end;
      end;
    end
    else
    begin
      if FUseArrow then
      begin
        dw := GetArrowSize;
        aw := dw;
        Dec(PaintRect.Right, dw);
      end;
      if MoneyFlat then
      begin
        if (FDown and FIsSwitch) or (FState in [ebsDown, ebsExclusive]) then
          Canvas.Brush.Color := MoneyFlatDownColor
        else
        if (FMouseInControl or FMouseInArrow) and (FState <> ebsDisabled) then
          Canvas.Brush.Color := MoneyFlatActiveColor
        else
          Canvas.Brush.Color := MoneyFlatInactiveColor;
        Canvas.FrameRect(PaintRect);
      end
      else
      begin
        if (FDown and FIsSwitch) or (FState in [ebsDown, {ebsArrDown, }ebsExclusive]) or
          ((FMouseInControl or FMouseInArrow) and (FState <> ebsDisabled)) or Focused or
          (csDesigning in ComponentState) then
        begin
          if ((Background.Empty) or (BackgroundDrawBorder)) and ShowBorder then
             DrawButtonFrameEx(Canvas.Handle, PaintRect, false, //OldStyled or ((FMouseInControl or Focused)) and (not ThinFrame),
                             (FDown and FIsSwitch) or (FState in [ebsDown, ebsExclusive]), AColor, true{ThinFrame});
        end;
      end;
    end;

    // draw the rectangle for the arrow
    if FUseArrow then
    begin
      if dw = 0 then
      begin
        dw := GetArrowSize;
        Dec(PaintRect.Right, dw);
      end;
      ArrRect := Rect(PaintRect.Right, 0, PaintRect.Right + dw, Height);
      if Default and DrawDefaultFrame then
        InflateRect(ArrRect, 0, -1);
      Canvas.Brush.Color := Color;
      if ((Background.Empty) or (BackgroundDrawBorder)) and FShowBorder then
      begin
        if MoneyFlat then
        begin
          if (FState in [ebsDown, ebsArrDown]) then
            Canvas.Brush.Color := MoneyFlatDownColor
          else
          if (FMouseInControl or FMouseInArrow) and (FState <> ebsDisabled) then
            Canvas.Brush.Color := MoneyFlatActiveColor
          else
            Canvas.Brush.Color := MoneyFlatInactiveColor;
          Canvas.FrameRect(ArrRect);
        end
        else
        begin
          if ((not FFlat) or ((FMouseInControl or FMouseInArrow) or
              (FState in [ebsArrDown, ebsExclusive])
               or (csDesigning in ComponentState))) then
            DrawButtonFrameEx(Canvas.Handle, ArrRect, (FMouseInArrow or FOldStyled) and (not FThinFrame) and (not FDown), (FState in [ebsDown, ebsArrDown]), AColor, ThinFrame);
        end;
      end;
      DrawArrow(Canvas, eadDown, ArrRect, Font.Color, FState <> ebsDisabled);
    end;
  end
  {$ifdef MSWINDOWS}
  else
  begin
    DrawThemeBackground(Theme, Canvas.Handle, BP_PUSHBUTTON, 0, PaintRect, nil);

    if not Enabled then
      sid := PBS_DISABLED
    else
    if (FDown and FIsSwitch) or (FState in [ebsDown, ebsExclusive]) then
      sid := PBS_PRESSED
    else
    if FMouseInControl or FMouseInArrow then
      sid := PBS_HOT
    else
    if (Default and DrawDefaultFrame) or Focused then
      sid := PBS_DEFAULTED
    else
      sid := PBS_NORMAL;
    if FUseArrow then
    begin
      dw := GetArrowSize;
      aw := dw;
      Dec(PaintRect.Right, dw);
    end;
    RClip := Canvas.ClipRect;
    DrawThemeBackground(Theme, Canvas.Handle, BP_PUSHBUTTON, sID, PaintRect, @RClip);

    if FUseArrow then
    begin
      if dw = 0 then
      begin
        dw := GetThemeSysSize(FArrTheme, SM_CXVSCROLL);
        Dec(PaintRect.Right, dw);
      end;
      ArrRect := Rect(PaintRect.Right, PaintRect.Top, PaintRect.Right + dw, PaintRect.Bottom);

      RClip := Canvas.ClipRect;
      if not Enabled then
        sid1 := CBXS_DISABLED
      else
      if FState in [ebsArrDown, ebsExclusive] then
        sid1 := CBXS_PRESSED
      else
      if FMouseInControl or FMouseInArrow then
        sid1 := CBXS_HOT
      else
        sid1 := CBXS_NORMAL;
      DrawThemeBackground(FArrTheme, Canvas.Handle, CP_DROPDOWNBUTTON, sid1, ArrRect, @RClip);
    end;
  end
  {$endif}
  ;

  Offset.x := 0;
  Offset.y := 0;

  if (FState in [ebsDown, ebsExclusive]) or (FDown and FIsSwitch) then
  begin
    if (FState = ebsExclusive) or
       (UseImageList and ((DownImages = nil) or (DownImages = Images))) or
       (UseIcon) or
       ((not UseImageList) and (UseIcon) and (NumGlyphs < 2)) then
    begin
      Offset.X := 1;
      Offset.Y := 1;
    end;
  end;
  inc(PaintRect.Right, dw);

  if ((FDown and FIsSwitch) or (FState in [ebsDown, ebsExclusive])) and (FDownImages <> nil) then
  begin
    SaveIL := THackGlyph(FGlyph).FImageList;
    SaveAIL := THackGlyph(FGlyph).FAlphaImageList;
    THackGlyph(FGlyph).FImageList := FDownImages;
    THackGlyph(FGlyph).FAlphaImageList := FAlphaDownImages;
  end;

  if (THackGlyph(FGlyph).FImageList = Self.FDisabledImages) and (FDisabledImages <> nil) and (FState = ebsDisabled) then
    GlyphState := ebsUp
  else
    GlyphState := FState;

  if AdjustSpaceForGlyph then
  begin
    if (not FThinFrame) then
      InflateRect(PaintRect, -2, -2)
    else
      InflateRect(PaintRect, -1, -1);
  end;
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
  end;
  {$endif}

  FTextRect := FGlyph.Draw(Canvas, PaintRect, Offset, Caption, FLayout, FMargin,
    FSpacing, FState, GlyphState, Alignment, true, FMultiline, (Focused and FShowFocus), FShowGlyph,
    FShowText, Aw, TextDrawType, Color, {$ifdef MSWINDOWS}ParentFont and (Theme <> 0), Theme, BP_PUSHBUTTON, sid{$else}false,0,0,0{$endif}, true, ImageIsAlphaBlended{$ifdef HAS_HTML_RENDER}, IsHTML, FRender{$endif}, FChangeDisabledText);

  if ((FDown and FIsSwitch) or (FState in [ebsDown, ebsExclusive])) and (FDownImages <> nil) then
  begin
    THackGlyph(FGlyph).FImageList := SaveIL;
    THackGlyph(FGlyph).FAlphaImageList := SaveAIL;
  end;
  if (Focused and FShowFocus) then
  begin
    R := PaintRect;
    dec(R.right, dw);
    {$ifdef MSWINDOWS}
    InflateRect(R, -1, -1);
    // ��� ��������� �������� �� ������ �������� �� �����.
    if (Width > 22) or (Height > 22) then
     InflateRect(R, -1, -1);
    {$endif}
    Canvas.Pen.Color := clWindowFrame;
    Canvas.Brush.Color := clBtnFace;
    DrawFocusRect(Canvas.Handle, R);
  end;

  bitblt(Self.Canvas.Handle, 0, 0, ClientWidth, ClientHeight, Bitmap.Canvas.Handle, 0, 0, SRCCOPY);
  Bitmap.Free;
end;

{$HINTS OFF}
procedure TCustomElPopupButton.AClick;
var
  q : TPoint;
  i : THandle;
var
{$IFNDEF VER90}
  Form : TCustomForm;
{$ELSE}
  Form : TForm;
{$ENDIF}

{$IFDEF VCL_4_USED}
const
  Buttons: array[TTrackButton] of Word = (TPM_RIGHTBUTTON, TPM_LEFTBUTTON);
{$ENDIF}

begin
  Form := GetParentForm(Self);
  if Form <> nil then Form.ModalResult := ModalResult;
  if Arrow then
  begin
{$IFDEF USE_SOUND_MAP}
    if SoundMap <> nil then SoundMap.Play(ArrowClickSound);
{$ENDIF}
    if Assigned(FOnArrowClick) then FOnArrowClick(Self);
  end
  else
  begin
{$IFDEF USE_SOUND_MAP}
    if SoundMap <> nil then SoundMap.Play(ClickSound);
{$ENDIF}
    inherited Click;
    //FMouseInControl := false;
    Invalidate;
  end;
  if (PullDownMenu = nil) or (FDisableAp) or ((not Arrow) and FUseArrow) then
  begin
    //FState := ebsUp;
    //FMouseInArrow := false;
    //FMouseInControl := false;
    exit;
  end;
  PullDownMenu.PopupComponent := Self;
  PullDownMenu.AutoPopup := True;
  q.X := 0;
  q.Y := 0;
  q := ClientToScreen(q);

  if FPopupPlace = ppRight then
  begin
    q.x := q.X + Width;
    q.y := q.Y - 1;
    //PullDownMenu.Popup(q.X + Width, q.Y - 1);
  end else
  if FPopupPlace = ppDown then
  begin
    q.x := q.X - 1;
    q.y := q.Y + height;
    //PullDownMenu.Popup(q.X - 1, q.Y + Height)
  end
  else
  begin
    q.x := q.x - 1;
    q.y := q.y - GetSystemMetrics(SM_CYMENU) * PullDownMenu.Items.Count - GetSystemMetrics(SM_CXEDGE);
    //PullDownMenu.Popup(q.X - 1, q.Y - GetSystemMetrics(SM_CYMENU) * PullDownMenu.Items.Count);
  end;

  PullDownMenu.PopupComponent := Self;
  if not FUseArrow then
  begin
    FState := ebsDown;
    FOrigState := ebsDown;
    Invalidate;
  end;
  FInMenu := true;
  if Assigned(PullDownMenu.OnPopup) then PullDownMenu.OnPopup(PullDownMenu);
  TrackPopupMenu(GetMenuHandle(PullDownMenu), TPM_LEFTALIGN or TPM_LEFTBUTTON or TPM_RIGHTBUTTON, q.X, q.Y, 0, Handle, nil);
  FState := ebsUp;
end;

{$HINTS ON}
procedure TCustomElPopupButton.CreateParams(var Params : TCreateParams);
//const
//  ButtonStyles : array[Boolean] of DWORD = (BS_PUSHBUTTON, BS_DEFPUSHBUTTON);
begin
  inherited CreateParams(Params);
  //Params.Style := Params.Style or ButtonStyles[FDefault];
end;

procedure TCustomElPopupButton.CreateWnd;
begin
  inherited;
  FActive := FDefault;
end;

procedure TCustomElPopupButton.CNCommand(var Message : TWMCommand);
begin
  if Message.NotifyCode = BN_CLICKED then
    Click;
end;

procedure TCustomElPopupButton.CMDialogKey(var Message : TCMDialogKey);
begin
  with Message do
    if (((CharCode = VK_RETURN) and FDefault) or
      ((CharCode = VK_ESCAPE) and FCancel)) and
      (KeyDataToShiftState(Message.KeyData) = []) and CanFocus then
    begin
      Click;
      Result := 1;
    end
    else
      inherited;
end;

procedure TCustomElPopupButton.CMFocusChanged(var Message : TCMFocusChanged);
var
  b : boolean;
begin
  b := FActive;
  FActive := Message.Sender = Self;
  SetButtonStyle(FActive);
  if b <> FActive then
     Invalidate;
  inherited;
end;


procedure TCustomElPopupButton.UpdateExclusive;
var
  Msg : TMessage;
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

procedure TCustomElPopupButton.GlyphChanged(Sender : TObject);
begin
  if (not (csLoading in ComponentState)) and
     (not UseIcon) and (not UseImageList) then
  Invalidate;
end;

function TCustomElPopupButton.GetPalette : HPALETTE;
begin
  Result := Glyph.Palette;
end;

function TCustomElPopupButton.GetGlyph : TBitmap;
begin
  Result := FGlyph.Glyph;
end;

procedure TCustomElPopupButton.SetGlyph(Value : TBitmap);
begin
  FGlyph.Glyph := Value;
  FGlyph.ResetNumGlyphs;
  Invalidate;
end;

function TCustomElPopupButton.GetNumGlyphs : TNumGlyphs;
begin
  Result := FGlyph.NumGlyphs;
end;

procedure TCustomElPopupButton.SetNumGlyphs(Value : TNumGlyphs);
begin
  if Value < 0 then
    Value := 1
  else if Value > 4 then
    Value := 4;
  // if Value <> FNumGlyphs then
  begin
    FNumGlyphs := Value;
    if (ComponentState * [csReading, csLoading] = []) then
    begin
      FGlyph.NumGlyphs := Value;
      Invalidate;
    end;
  end;
end;

procedure TCustomElPopupButton.SetDown(Value : Boolean);
begin
  if csLoading in ComponentState then
  begin
    FDown := value;
    exit;
  end;
  if (FGroupIndex = 0) and (not FIsSwitch) then Value := False;
  if FDown and (not FAllowAllUp) and (not FIsSwitch) then Exit;
  if FDown <> Value then
  begin
    FDown := Value;
    if Value then
    begin
  {$IFDEF USE_SOUND_MAP}
      if SoundMap <> nil then SoundMap.Play(DownSound);
  {$ENDIF}
      if FIsSwitch then
        FState := ebsDown
      else
        FState := ebsExclusive;
      Invalidate;
    end
    else
    begin
  {$IFDEF USE_SOUND_MAP}
      if SoundMap <> nil then SoundMap.Play(UpSound);
  {$ENDIF}
      FState := ebsUp;
      Invalidate;
    end;
    if Value then UpdateExclusive;
  end;
end;

procedure TCustomElPopupButton.SetFlat(Value : Boolean);
begin
  if Value <> FFlat then
  begin
    FFlat := Value;
    if Value then
    begin
      OldStyled := false;
    end;
    Invalidate;
  end;
end;

procedure TCustomElPopupButton.SetGroupIndex(Value : Integer);
begin
  if FGroupIndex <> Value then
  begin
    FGroupIndex := Value;
    UpdateExclusive;
  end;
end;

procedure TCustomElPopupButton.SetLayout(Value : TButtonLayout);
begin
  if FLayout <> Value then
  begin
    FLayout := Value;
    Invalidate;
  end;
end;

procedure TCustomElPopupButton.SetMargin(Value : Integer);
begin
  if (Value <> FMargin) and (Value >= -1) then
  begin
    FMargin := Value;
    Invalidate;
  end;
end;

procedure TCustomElPopupButton.SetSpacing(Value : Integer);
begin
  if Value <> FSpacing then
  begin
    FSpacing := Value;
    Invalidate;
  end;
end;

procedure TCustomElPopupButton.SetAllowAllUp(Value : Boolean);
begin
  if FAllowAllUp <> Value then
  begin
    FAllowAllUp := Value;
    UpdateExclusive;
  end;
end;

procedure TCustomElPopupButton.WMLButtonDblClk(var Message : TWMLButtonDown);
begin
  inherited;
  if FDown then DblClick;
end;

procedure TCustomElPopupButton.UpdateTracking;
var
  P : TPoint;
begin
  if not Enabled then FMouseInControl := false;

  if FFlat and Enabled then
  begin
    GetCursorPos(P);
    FMouseInControl := not (FindDragTarget(P, True) = Self);
    if Enabled and FMouseInControl then
      Perform(CM_MOUSELEAVE, 0, 0)
    else
      Perform(CM_MOUSEENTER, 0, 0);
  end;
end;

procedure TCustomElPopupButton.Loaded;
var
  State : TElButtonState;
begin
  inherited Loaded;
  if Enabled then
    State := ebsUp
  else
    State := ebsDisabled;
  if FUseImageList then
    THackGlyph(FGlyph).UseImageList := true;
  THackGlyph(FGlyph).CreateButtonGlyph(State);
  THackGlyph(FGlyph).NumGlyphs := FNumGlyphs;
  if FDown then
  begin
    FDown := false;
    Down := true;
  end;
  Invalidate;
end;

procedure TCustomElPopupButton.IntEnabledChanged;
const
  NewState : array[Boolean] of TElButtonState = (ebsDisabled, ebsUp);
begin
  if FGlyph <> nil then
  begin
    THackGlyph(FGlyph).CreateButtonGlyph(NewState[Enabled]);
    if UseImageList then
    begin
      if (not Enabled) and (FDisabledImages <> nil) then
      begin
         THackGlyph(FGlyph).ImageList := FDisabledImages;
         THackGlyph(FGlyph).AlphaImageList := FAlphaDisabledImages;
      end else
      begin
         THackGlyph(FGlyph).ImageList := FImageList;
         THackGlyph(FGlyph).AlphaImageList := FAlphaImageList;
      end;
    end;
  end;
  UpdateTracking;
  Invalidate;
end;

procedure TCustomElPopupButton.CMEnabledChanged(var Message : TMessage);
begin
  inherited;
  IntEnabledChanged;
end;

procedure TCustomElPopupButton.CMButtonPressed(var Message : TMessage);
var
  Sender : TCustomElPopupButton;
begin
  if Message.WParam = FGroupIndex then
  begin
    Sender := TCustomElPopupButton(Message.LParam);
    if Sender <> Self then
    begin
      if Sender.Down and FDown then
      begin
        FDown := False;
{$IFDEF USE_SOUND_MAP}
        if SoundMap <> nil then SoundMap.Play(UpSound);
{$ENDIF}
        FState := ebsUp;
        Invalidate;
      end;
      FAllowAllUp := Sender.AllowAllUp;
    end;
  end;
end;

procedure TCustomElPopupButton.CMFontChanged(var Message : TMessage);
begin
  Invalidate;
end;

procedure TCustomElPopupButton.CMColorChanged(var Message : TMessage);
var ButtonColor : TColor;
    hls1, hls2, hls3, hls4 : integer;
    lum : integer;

begin
  inherited;
  if not ShadowsUseCustom then
  begin
    ButtonColor := ColorToRGB(Color);

    hls1 := RGBtoHLS(ButtonColor);
    hls2 := hls1;
    hls3 := hls1;
    hls4 := hls1;

    lum := Hi(LoWord(hls3));
    hls1 := (Min(239, (Hi(LoWord(hls3))  + lum div 3)) shl 8) or (hls1 and $FF00FF);
    hls2 := (Min(239, (Hi(LoWord(hls3))  - lum div 2)) shl 8) or (hls2 and $FF00FF);
    hls4 := (Min(239, (Hi(LoWord(hls3))  - lum div 3)) shl 8) or (hls4 and $FF00FF);

    FShadowBtnHighlight := HLStoRGB(hls1);
    FShadowBtnDkShadow  := HLStoRGB(hls2);
    FShadowBtnShadow    := HLStoRGB(hls4);
  end;
  Invalidate;
end;

procedure TCustomElPopupButton.CMTextChanged(var Message : TMessage);
begin
  inherited;
  IntTextChanged;
end;

procedure TCustomElPopupButton.CMSysColorChange(var Message : TMessage);
begin
  with THackGlyph(FGlyph) do
  begin
    Invalidate;
    CreateButtonGlyph(FState);
  end;
end;

procedure TCustomElPopupButton.CMMouseEnter(var Message : TMessage);
begin
  inherited;
  IntMouseEnter;
end;

procedure TCustomElPopupButton.CMMouseLeave(var Message : TMessage);
begin
  inherited;
  IntMouseLeave;
end;

procedure TCustomElPopupButton.MouseDown(Button : TMouseButton; Shift : TShiftState;
  X, Y : Integer);
var
  l : integer;
{$IFDEF HAS_HTML_RENDER}
var
  P : TPoint;
  R : TRect;
  href : TElFString;
{$endif}
begin
  if FIgnoreMouseDown then
  begin
    FIgnoreMouseDown := false;
    exit;
  end;
  {$IFDEF HAS_HTML_RENDER}
  if IsHTML then
  begin
    P.x := X;
    P.y := Y;
    R := FTextRect;
    if IsHTML and FRender.IsCursorOverLink(Point(P.X - R.Left, P.Y - R.Top), Point(0, 0), R, href) then
      exit;
  end;
  {$endif}
  FOrigState := ebsUp;
  if (csDesigning in ComponentState) or ((Parent <> nil) and (csDesigning in Parent.ComponentState)) then exit;
  inherited MouseDown(Button, Shift, X, Y);
  if (Button = mbLeft) and Enabled then
  begin
    l := 11;
    if not FFlat then inc(l, 4);
    if (not FDown) and ((FUseArrow and not InRange(Width - l, Width, X)) or not FUseArrow) then
    begin
      FState := ebsDown;
{$IFDEF USE_SOUND_MAP}
      if SoundMap <> nil then SoundMap.Play(DownSound);
{$ENDIF}
      Invalidate;
    end
    else
    if (not FArrDown) and (FUseArrow and InRange(Width - l, Width, X)) then
    begin
{$IFDEF USE_SOUND_MAP}
      if SoundMap <> nil then SoundMap.Play(DownSound);
{$ENDIF}
      if FIgnoreClick then
        FIgnoreClick := false
      else
      begin
        FState := ebsArrDown;
        Invalidate;
        FOrigState := ebsArrDown;
        AClick(true);
        if not FInMenu then
          FDragging := true;
      end;
      exit;
    end;
    FDragging := True;
    FMouseInControl := true;
    (*
    {$ifndef CLX_USED}
    FOldCapture := GetCapture;
    if FOldCapture = Handle then
      FOldCapture := 0;
    SetCapture(Handle);
    {$endif}
    *)
  end
  else
  if (Button <> mbLeft) then
    FIgnoreClick := false;
end;

procedure TCustomElPopupButton.MouseMove(Shift : TShiftState; X, Y : Integer);
var
  NewState : TElButtonState;
var
  l   : integer;
  b        : boolean;
begin
  inherited MouseMove(Shift, X, Y);
  if FDragging then
  begin
    if (not FDown) and (not FArrDown) then
      NewState := ebsUp
    else
      NewState := ebsExclusive;
    if (X >= 0) and (X < ClientWidth) and (Y >= 0) and (Y <= ClientHeight) then
    begin
      if FDown then
        NewState := ebsExclusive
      else
      begin
        l := GetArrowSize;
        // if not FFlat then inc(l, 4);
        if (FUseArrow and InRange(Width - l, Width, X)) then
          NewState := ebsArrDown
        else
          NewState := ebsDown;
      end;
    end
    else
    begin
      if UseArrow then
      begin
        FMouseInArrow := false;
        Invalidate;
      end;
    end;
    if NewState <> FState then
    begin
      FState := NewState;
      if FState = ebsDown then
      begin
{$IFDEF USE_SOUND_MAP}
        if SoundMap <> nil then SoundMap.Play(DownSound);
{$ENDIF}
      end
      else if FState = ebsUp then
{$IFDEF USE_SOUND_MAP}
        if SoundMap <> nil then SoundMap.Play(UpSound);
{$ENDIF}
      UpdateTracking;
      Invalidate;
    end;
  end
  else
  if UseArrow then
  begin
    //b := FMouseInArrow;
    FMouseInArrow := X > ClientWidth - GetArrowSize;

    if FMouseInArrow then
    begin
      b := FMouseInControl = false;
      FMouseInControl := false;
    end
    else
    begin
      b := FMouseInControl = false;
      FMouseInControl := true;
    end;

    if b <> FMouseInArrow then
      Invalidate;
  end;
end;

procedure TCustomElPopupButton.MouseUp(Button : TMouseButton; Shift : TShiftState;
  X, Y : Integer);
var
  DoClick : Boolean;
  ArrClick : Boolean;
  l : integer;
  {$IFDEF HAS_HTML_RENDER}
  P : TPoint;
  R : TRect;
  href : TElFString;
  {$endif}
begin
  inherited;
  (*
  if FDragging then
  begin
    {$ifndef CLX_USED}
    if FOldCapture <> 0 then
      SetCapture(FOldCapture)
    else
      ReleaseCapture;
    FOldCapture := 0;
    {$endif}
  end;
  *)
  {$IFDEF HAS_HTML_RENDER}
  if IsHTML then
  begin
    GetCursorPos(P);
    P := ScreenToClient(P);
    R := FTextRect;

    if IsHTML and FRender.IsCursorOverLink(Point(P.X - R.Left, P.Y - R.Top), Point(0, 0), R, href) then
    begin
      TriggerLinkClickEvent(href);
      exit;
    end;
  end;
  {$endif}
  if FDragging and (Button = mbLeft) then
  begin
    FDragging := False;
    DoClick := (X >= 0) and (X < ClientWidth) and (Y >= 0) and (Y <= ClientHeight);
    l := 11;
    if not FFlat then inc(l, 4);
    ArrClick := (FUseArrow and InRange(Width - l, Width, X));
    if FGroupIndex = 0 then
    begin
      if FIsSwitch and (not ArrClick) then
      begin
        if FOrigState <> ebsArrDown then
        begin
          FDown := not FDown;
          if FDown then
          begin
            FState := ebsDown;
{$IFDEF USE_SOUND_MAP}
            if SoundMap <> nil then SoundMap.Play(DownSound);
{$endif}
          end
          else
          begin
            FState := ebsUp;
{$IFDEF USE_SOUND_MAP}
            if SoundMap <> nil then SoundMap.Play(UpSound);
{$ENDIF}
          end;
        end else
        begin
          FState := ebsUp;
{$IFDEF USE_SOUND_MAP}
          if SoundMap <> nil then SoundMap.Play(UpSound);
{$ENDIF}
        end;
      end
      else
      begin
        if ArrClick and FInMenu then
          DoClick := false
        else
        begin
          FState := ebsUp;
{$IFDEF USE_SOUND_MAP}
          if SoundMap <> nil then SoundMap.Play(UpSound);
{$ENDIF}
        end;
      end;
      FMouseInControl := PtInRect(ClientRect, Point(X, Y));
      if not FMouseInControl then IntMouseLeave;
      if not (FState in [ebsExclusive, ebsArrDown, ebsDown]) then Invalidate;
    end
    else
    if DoClick then
    begin
      SetDown(not FDown);
      if FDown or FArrDown then Invalidate;
    end else
    begin
      if FDown then FState := ebsExclusive;
      Invalidate;
    end;
    if DoClick then AClick(ArrClick);
  end;
end;


{$ifdef VCL_5_USED}
procedure TCustomElPopupButton.WMContextMenu(var Message: TWMContextMenu);
var
  Pt, Temp: TPoint;
  Handled: Boolean;
  href : TElFString;
  R    : TRect;
begin
  if csDesigning in ComponentState then Exit;

  {$ifdef HAS_HTML_RENDER}
  Pt := ScreenToClient(SmallPointToPoint(Message.Pos));
  if IsHTML then
  begin
    R := FTextRect;
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

procedure TCustomElPopupButton.WMRButtonUp(var Message: TWMRButtonUp);
{$ifndef VCL_5_USED}
var P : TPoint;
    R : TRect;
    href : TElFString;
{$endif}
begin
  {$ifndef VCL_5_USED}
  {$ifdef HAS_HTML_RENDER}
  if IsHTML then
  begin
    P := SmallPointToPoint(Message.Pos);
    R := FTextRect;
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
  {$endif}
    inherited;
end;

procedure TCustomElPopupButton.SetButtonStyle(ADefault : Boolean);
const
  BS_MASK = $000F;
var
  Style : Word;
begin
  if HandleAllocated then
  begin
    if ADefault then
      Style := BS_DEFPUSHBUTTON
    else
      Style := BS_PUSHBUTTON;
    if GetWindowLong(Handle, GWL_STYLE) and BS_MASK <> Style then
      SendMessage(Handle, BM_SETSTYLE, Style, 1);
  end;
end;

type
  TMenuItemEx = class(TMenuItem);

{$HINTS OFF}
procedure TCustomElPopupButton.WndProc(var Message : TMessage);
var P : TPoint;
    I : Integer;
    MenuItem: TMenuItem;
    FindKind: TFindItemKind;
    ContextID: Integer;
    DC: HDC;
    R : TRect;
    Item: Integer;

begin
  if Message.Msg = MenuCancelMsg then
  begin
    FInMenu := false;
    FDragging := false;
    FArrDown := false;
    FState := ebsUp;
    FMouseInControl := false;
    FMouseInArrow := false;
    Invalidate;
    Exit;
  end;

  //if FInMenu then
  try
    case Message.Msg of
{$IFNDEF VCL_5_USED}
      WM_COMMAND:
        if FPulldownMenu.DispatchCommand(Message.wParam) then Exit;
      WM_INITMENUPOPUP:
        with TWMInitMenuPopup(Message) do
          if FPulldownMenu.DispatchPopup(MenuPopup) then Exit;
      WM_MENUSELECT:
        with TWMMenuSelect(Message) do
        begin
          FindKind := fkCommand;
          if MenuFlag and MF_POPUP <> 0 then
            FindKind := fkHandle;
          MenuItem := FPulldownMenu.FindItem(IDItem, FindKind);
          if MenuItem <> nil then
          begin
            Application.Hint := MenuItem.Hint;
            Exit;
          end;
          Application.Hint := '';
        end;
      WM_HELP:
        with PHelpInfo(Message.LParam)^ do
        begin
            if (FPullDownMenu <> nil) and (FPulldownMenu.Handle = hItemHandle) then
            begin
              ContextID := FPulldownMenu.GetHelpContext(iCtrlID, True);
              if ContextID = 0 then
                ContextID := FPulldownMenu.GetHelpContext(hItemHandle, False);
              if Screen.ActiveForm = nil then Exit;
              if (biHelp in Screen.ActiveForm.BorderIcons) then
                Application.HelpCommand(HELP_CONTEXTPOPUP, ContextID)
              else
                Application.HelpContext(ContextID);
              Exit;
            end;
        end;
{$ELSE}
      WM_COMMAND,
      WM_INITMENUPOPUP,
      WM_MENUSELECT,
      WM_DRAWITEM,
      WM_MEASUREITEM,
      WM_MENUCHAR,
      WM_HELP:
        begin
        {$ifdef ELPACK_COMPLETE}
        if (PulldownMenu is TElPopupMenu) then
          with Message do
            SendMessage(GetParentForm(Self).Handle, Msg, wParam, lParam)
        else
        {$endif}
          with Message do
            SendMessage(PopupList.Window, Msg, wParam, lParam);
        end;
{$ENDIF}
      WM_EXITMENULOOP:
        begin
          GetCursorPos(P);
          P := ScreenToClient(P);
          FDragging := true;
          PostMessage(Handle, MenuCancelMsg, 0, 0);
          if PtInRect(Rect(ClientWidth - GetArrowSize, 0, ClientWidth, ClientHeight), P) then
             FIgnoreClick := true;
          {$IFDEF VCL_5_USED}
          with Message do
               SendMessage(PopupList.Window, Msg, wParam, lParam);
          {$ENDIF}
        end;
      WM_QUERYENDSESSION:
        begin
          Message.result := 1;
          exit;
        end;
      end;
  except
    Application.HandleException(Self);
  end;
  if Message.Msg = CN_COMMAND then
    if FClicksDisabled then Exit;
  inherited WndProc(Message);
end;

{$HINTS ON}
procedure TCustomElPopupButton.WMKeyUp(var Msg: TWMKeyUp);
begin
  IntKeyUp(Msg.CharCode, KeyDataToShiftState(Msg.KeyData));
  inherited;
end;

procedure TCustomElPopupButton.WMGetDlgCode(var Msg : TMessage);
begin
  inherited;
  Msg.Result := DLGC_BUTTON or DLGC_WANTALLKEYS;
end;

procedure TCustomElPopupButton.WMKeyDown(var Message : TWMKeyDown); { private }
begin
  if not IntKeyDown(Message.CharCode, KeyDataToShiftState(Message.KeyData)) then
    inherited;
end; { WMKeyDown }


procedure TCustomElPopupButton.SetShowFocus(newValue : Boolean);
begin
  if (FShowFocus <> newValue) then
  begin
    FShowFocus := newValue;
    Invalidate;
  end; { if }
end; { SetShowFocus }

procedure TCustomElPopupButton.SetUseArrow(newValue : Boolean);
begin
  if (FUseArrow <> newValue) then
  begin
    FUseArrow := newValue;
    Invalidate;
  end; { if }
end; { SetUseArrow }

procedure TCustomElPopupButton.SetShowGlyph(newValue : Boolean);
begin
  if (FShowGlyph <> newValue) then
  begin
    FShowGlyph := newValue;
    Invalidate;
  end; { if }
end; { SetShowGlyph }

procedure TCustomElPopupButton.SetShowText(newValue : Boolean);
begin
  if (FShowText <> newValue) then
  begin
    FShowText := newValue;
    Invalidate;
  end; { if }
end; { SetShowText }

procedure TCustomElPopupButton.SetPullDownMenu(newValue : TPopupMenu);
begin
  if (FPullDownMenu <> newValue) then
  begin
    {$ifdef VCL_5_USED}
    if (FPullDownMenu <> nil) and (not (csDestroying in FPullDownMenu.ComponentState)) then
      FPullDownMenu.RemoveFreeNotification(Self);
    {$endif}
    FPullDownMenu := newValue;
    if FPullDownMenu = nil then
      FDisableAp := true
    else
    begin
      FDisableAp := false;
      FPulldownMenu.FreeNotification(Self);
    end;
  end; { if }
end; { SetPullDownMenu }

function TCustomElPopupButton.GetIcon : TIcon;
begin
  result := FGlyph.Icon;
end;

procedure TCustomElPopupButton.SetIcon(newValue : TIcon);
begin
  FGlyph.Icon.Assign(newValue);
end;

procedure TCustomElPopupButton.SetIsSwitch(newValue : Boolean);
begin
  if (FIsSwitch <> newValue) then
  begin
    if not NewValue then
    begin
      FDown := false;
      FState := ebsUp;
    end;
    FIsSwitch := newValue;
  end;
end;

{$IFDEF USE_SOUND_MAP}
procedure TCustomElPopupButton.SetSoundMap(newValue : TElSoundMap);
begin
  if (FSoundMap <> newValue) then
  begin
    {$ifdef VCL_5_USED}
    if FSoundMap <> nil then
      FSoundMap.RemoveFreeNotification(Self);
    {$endif}
    FSoundMap := newValue;
    {$ifdef VCL_5_USED}
    if FSoundMap <> nil then
      FSoundMap.FreeNotification(Self);
    {$endif}
  end;
end; { SetSoundMap }
{$ENDIF}


procedure TCustomElPopupButton.SetShowBorder;
begin
  if FShowBorder <> newValue then
  begin
    FShowBorder := newValue;
    Invalidate;
  end;
end;

{$ifdef ELPACK_USE_IMAGEFORM}
procedure TCustomElPopupButton.ImageFormChange(Sender : TObject);
begin
  Invalidate;
end;

procedure TCustomElPopupButton.SetImageForm(newValue : TElImageForm);
begin
  if FImgForm <> newValue then
  begin
    {$ifdef VCL_5_USED}
    if (FImgForm <> nil) and (not (csDestroying in FImgForm.ComponentState)) then
      FImgForm.RemoveFreeNotification(Self);
    {$endif}
    if FImgForm <> nil then
      FImgForm.UnRegisterChanges(FImgFormChLink);
    if newValue <> nil then
       newValue.FreeNotification(Self);
    FImgForm := newValue;
    if FImgForm <> nil then
      FImgForm.RegisterChanges(FImgFormChLink);
    if HandleAllocated then Invalidate;
  end;
end;
{$endif}

procedure TCustomElPopupButton.Notification(AComponent : TComponent; operation : TOperation);
begin
  inherited Notification(AComponent, operation);
  if (operation = opRemove) then
  begin
{$IFDEF USE_SOUND_MAP}
    if (AComponent = FSoundMap) then SoundMap := nil;
{$ENDIF}
    if (AComponent = FImageList) then Images := nil;
    if (AComponent = FAlphaImageList) then AlphaForImages := nil;
    if (AComponent = FAlphaHotImages) then AlphaForHotImages := nil;
    if (AComponent = FAlphaDownImages) then AlphaForDownImages := nil;
    if (AComponent = FAlphaDisabledImages) then AlphaForDisabledImages := nil;
    if (AComponent = FHotImages) then HotImages := nil;
    if (AComponent = FDownImages) then DownImages := nil;
    if (AComponent = FDisabledImages) then DisabledImages := nil;
    if AComponent = FPullDownMenu then PullDownMenu :=nil;
   {$ifdef HAS_HTML_RENDER}
   if AComponent = LinkPopupMenu then
     LinkPopupMenu := nil;
   {$endif}
    {$ifdef ELPACK_USE_IMAGEFORM}
    if AComponent = FImgForm then ImageForm := nil;
    {$endif}
  end; { if }
end; { Notification }

function TCustomElPopupButton.GetImageIndex : integer;
begin
  result := THackGlyph(FGlyph).FImageIndex;
end;

procedure TCustomElPopupButton.SetImageIndex(newValue : Integer);
begin
  if (THackGlyph(FGlyph).FImageIndex <> newValue) then
  begin
    THackGlyph(FGlyph).ImageIndex := newValue;
    if THackGlyph(FGlyph).UseImageList then
      Invalidate;
  end; {if}
end;

procedure TCustomElPopupButton.SetImageList(newValue : TImageList);
var b : boolean;
begin
  if FImageList <> newValue then
  begin
    b := FImageList = nil;
    if not b then
    begin
      FImageList.UnregisterChanges(FChLink);
      {$ifdef VCL_5_USED}
      if (not (csDestroying in FImageList.ComponentState)) then
        FImageList.RemoveFreeNotification(Self);
      {$endif}
    end;
    FImageList := newValue;
    if FImageList <> nil then
    begin
      FImageList.RegisterChanges(FChLink);
      FImageList.FreeNotification(Self);
    end;
    THackGlyph(FGlyph).ImageList := newValue;
    if FImageList = nil then
      UseImageList := false
    else
    if b and (not (csLoading in ComponentState)) then UseImageList := true;
    Invalidate;
  end;
end;

procedure TCustomElPopupButton.SetAlphaImageList(newValue : TImageList);
var b : boolean;
begin
  if FAlphaImageList <> newValue then
  begin
    b := FAlphaImageList = nil;
    if not b then
    begin
      FAlphaImageList.UnregisterChanges(FAChLink);
      {$ifdef VCL_5_USED}
      if (not (csDestroying in FImageList.ComponentState)) then
        FAlphaImageList.RemoveFreeNotification(Self);
      {$endif}
    end;
    FAlphaImageList := newValue;
    if FAlphaImageList <> nil then
    begin
      FAlphaImageList.RegisterChanges(FAChLink);
      FAlphaImageList.FreeNotification(Self);
    end;
    THackGlyph(FGlyph).AlphaImageList := newValue;
    Invalidate;
  end;
end;

procedure TCustomElPopupButton.SetUseIcon(newValue : Boolean);
begin
  if (FUseIcon <> newValue) then
  begin
    FUseIcon := newValue;
    FGlyph.UseIcon := newValue;
    if not UseImageList then Invalidate;
  end; { if }
end; { SetUseIcon }

function TCustomElPopupButton.GetUseImageList : boolean;
begin
  result := FUseImageList;
end;

procedure TCustomElPopupButton.SetUseImageList(newValue : Boolean);
begin
  if (UseImageList <> newValue) then
  begin
    FUseImageList := newValue;
    if not (csLoading in ComponentState) then
    begin
      THackGlyph(FGlyph).UseImageList := newValue;
      Invalidate;
    end;
  end; { if }
end; { SetUseImageList }

procedure TCustomElPopupButton.SetOldStyled(newValue : Boolean);
{ Sets data member FOldStyled to newValue. }
begin
  if (FOldStyled <> newValue) then
  begin
    if not (newValue and Flat) then
    begin
      FOldStyled := newValue;
      Repaint;
    end;
  end; { if }
end; { SetOldStyled }

procedure TCustomElPopupButton.ImagesChanged(Sender : TObject);
begin
  if FUseImageList then
  begin
    if (FMouseInControl and Enabled) and (Sender = Images) then Invalidate else
    if (not Enabled) and (Sender = DisabledImages) then Invalidate else
    if ((FDown and FIsSwitch) or (FState in [ebsDown, ebsExclusive])) and (Sender = DownImages) then Invalidate else
    if Sender = FImageList then Invalidate;
  end else
  begin
    if (Sender = FBackGround) or
         ((Sender = FDownBackground) and (FDown and FIsSwitch) or
         (FState in [ebsDown, ebsExclusive]))  then Invalidate;
  end;
end;

procedure TCustomElPopupButton.SetDownImages(newValue : TImageList);
begin
  if (FDownImages <> newValue) then
  begin
    if FDownImages <> nil then
    begin
      {$ifdef VCL_5_USED}
      if (not (csDestroying in FDownImages.ComponentState)) then
        FDownImages.RemoveFreeNotification(Self);
      {$endif}
      FDownImages.UnregisterChanges(FNChLink);
    end;
    FDownImages := newValue;
    if FDownImages <> nil then FDownImages.RegisterChanges(FNChLink);
    if ((FDown and FIsSwitch) or (FState in [ebsDown, ebsExclusive])) then
    begin
      if newValue = nil then
        THackGlyph(FGlyph).ImageList := FImageList
      else
        THackGlyph(FGlyph).ImageList := newValue;
      Invalidate;
    end;
    if FDownImages <> nil then
      FDownImages.FreeNotification(Self);
  end;  { if }
end;

procedure TCustomElPopupButton.SetAlphaDownImages(newValue : TImageList);
begin
  if (FAlphaDownImages <> newValue) then
  begin
    if FAlphaDownImages <> nil then
    begin
      {$ifdef VCL_5_USED}
      if (not (csDestroying in FAlphaDownImages.ComponentState)) then
        FAlphaDownImages.RemoveFreeNotification(Self);
      {$endif}
      FAlphaDownImages.UnregisterChanges(FANChLink);
    end;
    FAlphaDownImages := newValue;
    if FAlphaDownImages <> nil then FAlphaDownImages.RegisterChanges(FANChLink);
    if ((FDown and FIsSwitch) or (FState in [ebsDown, ebsExclusive])) then
    begin
      if newValue = nil then
        THackGlyph(FGlyph).AlphaImageList := FAlphaImageList
      else
        THackGlyph(FGlyph).AlphaImageList := newValue;
      Invalidate;
    end;
    if FAlphaDownImages <> nil then
      FAlphaDownImages.FreeNotification(Self);
  end;  { if }
end;

procedure TCustomElPopupButton.SetHotImages(newValue : TImageList);
begin
  if (FHotImages <> newValue) then
  begin
    if FHotImages <> nil then
    begin
      {$ifdef VCL_5_USED}
      if (not (csDestroying in FHotImages.ComponentState)) then
        FHotImages.RemoveFreeNotification(Self);
      {$endif}
      FHotImages.UnregisterChanges(FHChLink);
    end;
    FHotImages := newValue;
    if FHotImages <> nil then
    begin
      FHotImages.RegisterChanges(FHChLink);
      FHotImages.FreeNotification(Self);
    end;
    if FMouseInControl then
    begin
      if newValue = nil then
        THackGlyph(FGlyph).ImageList := FImageList
      else
        THackGlyph(FGlyph).ImageList := newValue;
      Invalidate;
    end;
  end;  { if }
end;  { SetHotImages }

procedure TCustomElPopupButton.SetAlphaHotImages(newValue : TImageList);
begin
  if (FAlphaHotImages <> newValue) then
  begin
    if FAlphaHotImages <> nil then
    begin
      {$ifdef VCL_5_USED}
      if (not (csDestroying in FAlphaHotImages.ComponentState)) then
        FAlphaHotImages.RemoveFreeNotification(Self);
      {$endif}
      FAlphaHotImages.UnregisterChanges(FAHChLink);
    end;
    FAlphaHotImages := newValue;
    if FAlphaHotImages <> nil then
    begin
      FAlphaHotImages.RegisterChanges(FAHChLink);
      FAlphaHotImages.FreeNotification(Self);
    end;
    if FMouseInControl then
    begin
      if newValue = nil then
        THackGlyph(FGlyph).AlphaImageList := FAlphaImageList
      else
        THackGlyph(FGlyph).AlphaImageList := newValue;
      Invalidate;
    end;
  end;  { if }
end;  { SetAlphaHotImages }

procedure TCustomElPopupButton.SetDisabledImages(newValue : TImageList);
begin
  if (FDisabledImages <> newValue) then
  begin
    if FDisabledImages <> nil then
    begin
      {$ifdef VCL_5_USED}
      if (not (csDestroying in FDisabledImages.ComponentState)) then
        FDisabledImages.RemoveFreeNotification(Self);
      {$endif}
      FDisabledImages.UnregisterChanges(FDChLink);
    end;
    FDisabledImages := newValue;
    if FDisabledImages <> nil then
    begin
      FDisabledImages.RegisterChanges(FDChLink);
      FDisabledImages.FreeNotification(Self);
    end;
    if not Enabled then
    begin
      if newValue <> nil then
        THackGlyph(FGlyph).ImageList := newValue
      else
        THackGlyph(FGlyph).ImageList := FImageList;
      Invalidate;
    end;
  end;  { if }
end;  { SetDisabledImages }

procedure TCustomElPopupButton.SetAlphaDisabledImages(newValue : TImageList);
begin
  if (FAlphaDisabledImages <> newValue) then
  begin
    if FAlphaDisabledImages <> nil then
    begin
      {$ifdef VCL_5_USED}
      if (not (csDestroying in FAlphaDisabledImages.ComponentState)) then
        FAlphaDisabledImages.RemoveFreeNotification(Self);
      {$endif}
      FAlphaDisabledImages.UnregisterChanges(FADChLink);
    end;
    FAlphaDisabledImages := newValue;
    if FAlphaDisabledImages <> nil then
    begin
      FAlphaDisabledImages.RegisterChanges(FADChLink);
      FAlphaDisabledImages.FreeNotification(Self);
    end;
    if not Enabled then
    begin
      if newValue <> nil then
        THackGlyph(FGlyph).AlphaImageList := newValue
      else
        THackGlyph(FGlyph).AlphaImageList := FAlphaImageList;
      Invalidate;
    end;
  end;  { if }
end;  { SetAlphaDisabledImages }

procedure TCustomElPopupButton.CMEnter(var Msg: TCMEnter);
begin
  inherited;
  Invalidate;
end;

procedure TCustomElPopupButton.CMExit(var Msg: TCMExit);
begin
  inherited;
  Invalidate;
end;

{$IFDEF VCL_4_USED}

function TCustomElPopupButton.GetActionLinkClass : TControlActionLinkClass;
begin
  result := TElPopupButtonActionLink;
end;

procedure TCustomElPopupButton.ActionChange(Sender : TObject; CheckDefaults : Boolean);
begin
  inherited;
  if Action is TAction then
  begin
    ImageIndex := TAction(Action).ImageIndex;
    Down := TAction(Action).Checked;
  end;
end;
{$ENDIF}

procedure TCustomElPopupButton.SetThinFrame(newValue : Boolean);
{ Sets data member FThinFrame to newValue. }
begin
  if (FThinFrame <> newValue) then
  begin
    FThinFrame := newValue;
    if newValue then FOldStyled := false;
    if OldStyled or ((FMouseInControl or Focused) and (not (FState in [ebsDown, ebsExclusive]))) then Invalidate;
  end;  { if }
end;  { SetThinFrame }

procedure TCustomElPopupButton.SetShadowsUseCustom(Value : Boolean);
begin
  if Value <> FShadowsUseCustom then
  begin
    FShadowsUseCustom := Value;
    Invalidate;
  end;
end;

procedure TCustomElPopupButton.SetShadowBtnHighlight(Value : TColor);
begin
  if Value <> FShadowBtnHighlight then
  begin
    FShadowBtnHighlight := Value;
    if FShadowsUseCustom then Invalidate;
  end;
end;

procedure TCustomElPopupButton.SetShadowBtnShadow(Value : TColor);
begin
  if Value <> FShadowBtnShadow then
  begin
    FShadowBtnShadow := Value;
    if FShadowsUseCustom then Invalidate;
  end;
end;

procedure TCustomElPopupButton.SetShadowBtnDkShadow(Value : TColor);
begin
  if Value <> FShadowBtnDkShadow then
  begin
    FShadowBtnDkShadow := Value;
    if FShadowsUseCustom then Invalidate;
  end;
end;

procedure TCustomElPopupButton.SetShadowFollowsColor(Value : Boolean);
begin
  if Value <> FShadowFollowsColor then
  begin
    FShadowFollowsColor := Value;
    Invalidate;
  end;
end;

procedure TCustomElPopupButton.SetBackgroundDrawBorder(Value : boolean);
begin
  if Value <> FBackgroundDrawBorder then
  begin
    FBackgroundDrawBorder := Value;
    if not FBackground.Empty then Invalidate;
  end;
end;

procedure TCustomElPopupButton.SetDownBackground(newValue : TBitmap);
{ Sets data member FDownBackground to newValue. }
begin
  FDownBackground.Assign(newValue);
end;  { SetDownBackground }

procedure TCustomElPopupButton.SetBackground(newValue : TBitmap);
{ Sets data member FBackground to newValue. }
begin
  FBackground.Assign(newValue);
end;  { SetBackground }

{$ifdef HAS_HTML_RENDER}
procedure TCustomElPopupButton.SetIsHTML(Value: Boolean);
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
    Invalidate;
  end;
end;

procedure TCustomElPopupButton.SetLinkColor(newValue : TColor);
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

procedure TCustomElPopupButton.SetLinkPopupMenu(newValue : TPopupMenu);
begin
  if (FLinkPopupMenu <> newValue) then
  begin
    {$ifdef VCL_5_USED}
    if (FLinkPopupMenu <> nil) and (not (csDestroying in FLinkPopupMenu.ComponentState)) then
      FLinkPopupMenu.RemoveFreeNotification(Self);
    {$endif}
    FLinkPopupMenu := newValue;
    if (newValue <> nil) then
       newValue.FreeNotification(Self);
  end;  { if }
end;  { SetLinkPopupMenu }

procedure TCustomElPopupButton.SetLinkStyle(newValue : TFontStyles);
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

procedure TCustomElPopupButton.DoLinkPopup(MousePos : TPoint);
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

procedure TCustomElPopupButton.TriggerImageNeededEvent(Sender : TObject; Src :
    TElFString; var Image : TBitmap);
begin
  Image := nil;
  if (assigned(FOnImageNeeded)) then
      FOnImageNeeded(Self, Src, Image);
end;  { TriggerImageNeededEvent }

procedure TCustomElPopupButton.TriggerLinkClickEvent(HRef : TElFString);
begin
  if (assigned(FOnLinkClick)) then
    FOnLinkClick(Self, HRef );
end;  { TriggerLinkClickEvent }

{$endif}

constructor TCustomElPopupButton.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
{$IFNDEF VER90}
  ControlStyle := [csReflector, csSetCaption, csCaptureMouse, csDoubleClicks, csOpaque];
{$ELSE}
  ControlStyle := [csSetCaption, csCaptureMouse, csDoubleClicks];
{$ENDIF}
  Width := 75;
  Height := 25;
  FAlignment := taCenter;
  TabStop := True;
  FMultiLine := False;
  FGlyph := TElButtonGlyph.Create;
  FGlyph.OnChange := GlyphChanged;
  FFlat := false;
  FSpacing := 4;
  FMargin := -1;
  FLayout := blGlyphLeft;
  Inc(ButtonCount);
  FUseArrow := False;
  FShowText := true;
  FShowGlyph := true;
  THackGlyph(FGlyph).FImageIndex := -1;
  Font.Color := clBtnText;
  ParentFont := True;
  FAdjustSpaceForGlyph := true;
  FChangeDisabledText := true;

  FChLink  := TChangeLink.Create; FChLink.OnChange := ImagesChanged;
  FAChLink  := TChangeLink.Create; FAChLink.OnChange := ImagesChanged;
  FDChLink := TChangeLink.Create; FDChLink.OnChange := ImagesChanged;
  FADChLink := TChangeLink.Create; FADChLink.OnChange := ImagesChanged;
  FHChLink := TChangeLink.Create; FHChLink.OnChange := ImagesChanged;
  FAHChLink := TChangeLink.Create; FAHChLink.OnChange := ImagesChanged;
  FNChLink := TChangeLink.Create; FNChLink.OnChange := ImagesChanged;
  FANChLink := TChangeLink.Create; FANChLink.OnChange := ImagesChanged;
  FBackground := TBitmap.Create;
  FDownBackground := TBitmap.Create;
  FShadowFollowsColor := true;
  {$ifdef ELPACK_USE_IMAGEFORM}
  FImgFormChLink  := TImgFormChangeLink.Create;
  FImgFormChLink.OnChange := ImageFormChange;
  {$endif}
  FShowBorder := true;
  FShowFocus := true;
{$ifdef HAS_HTML_RENDER}
  FLinkStyle := [fsUnderline];
  FLinkColor := clBlue;
  {$endif}
  UseXPThemes := true;
end;

destructor TCustomElPopupButton.Destroy;
begin
  {$ifdef ELPACK_USE_IMAGEFORM}
  ImageForm := nil;
  FImgFormChLink.Free;
  {$endif}
  UseArrow := false;
  FDownBackground.Free;
  FBackground.Free;
  Dec(ButtonCount);
  FChLink.Free;
  FAChLink.Free;
  FDChLink.Free;
  FADChLink.Free;
  FHChLink.Free;
  FAHChLink.Free;
  FNChLink.Free;
  FANChLink.Free;
  if ButtonCount = 0 then
  begin
    Pattern.Free;
    Pattern := nil;
  end;
  FGlyph.Free;

  UseXPThemes := false;

  {$ifdef HAS_HTML_RENDER}
  if IsHTML then
    FRender.Free;
  FRender := nil;
  {$endif}
  inherited Destroy;
end;

procedure TCustomElPopupButton.SetAdjustSpaceForGlyph(Value: Boolean);
begin
  if FAdjustSpaceForGlyph <> Value then
  begin
    FAdjustSpaceForGlyph := Value;
    Invalidate;
  end;
end;

{$ifdef ELPACK_USE_IMAGEFORM}
procedure TCustomElPopupButton.IFMRepaintChildren(var Message: TMessage);
begin
  inherited;
  if (not (csDesigning in ComponentState)) and (ImageForm <> nil) then
    Invalidate;
  Broadcast(Message);
end;
{$endif}

procedure TCustomElPopupButton.Click;
begin
  AClick(false);
end;

procedure TCustomElPopupButton.ButtonClick;
var
  First, Last: Integer;
begin
  if not FDown then
  begin
    FState := ebsDown;
    Repaint;
  end;
  First := GetTickCount;
  repeat
    Last := GetTickCount;
  until ((Last - First) >= 25) or (Last < First);
  FState := ebsUp;
  if GroupIndex = 0 then
  begin
    Click;
    Repaint;
  end
  else
  begin
    Down := not Down;
    Click;
  end;
end;

procedure TCustomElPopupButton.SetDrawDefaultFrame(Value: Boolean);
begin
  if FDrawDefaultFrame <> Value then
  begin
    FDrawDefaultFrame := Value;
    if Default then
      Invalidate;
  end;
end;

procedure TCustomElPopupButton.CreateThemeHandle;
begin
  inherited;
  if ThemesAvailable then
  begin
    FArrTheme := OpenThemeData(Handle, 'COMBOBOX');
  end
  else
  begin
    FArrTheme := 0;
  end;
end;

procedure TCustomElPopupButton.FreeThemeHandle;
begin
  inherited;
  {$ifdef MSWINDOWS}
  if ThemesAvailable then
  begin
    CloseThemeData(FArrTheme);
  end;
  {$endif}
  FArrTheme := 0;
end;

function TCustomElPopupButton.GetArrowSize: Integer;
var PS  : TSize;
begin
{$ifdef MSWINDOWS}
  if FArrTheme <> 0 then
  begin
    GetThemePartSizeTo('COMBOBOX', 0, CP_DROPDOWNBUTTON, CBXS_NORMAL, nil, TS_TRUE, PS);
    result := PS.cx;
  end
  else
{$endif}
    result := 13;
end;


function TCustomElPopupButton.IntKeyDown;
begin
  result := false;
  if 
     (Key = VK_SPACE)
     and Focused and
    (Shift = []) and CanFocus then
  begin
    if FState <> ebsDown then
    begin
      FState := ebsDown;
{$IFDEF USE_SOUND_MAP}
      if SoundMap <> nil then SoundMap.Play(DownSound);
{$ENDIF}
      Invalidate;
    end;
    Result := false;
  end
  else
  if (
     (Key = VK_RETURN)
      and Focused) and
    (Shift = []) and CanFocus then
  begin
    if FIsSwitch then
    begin
      FDown := not FDown;
      if not FDown then
      begin
        FState := ebsUp;
{$IFDEF USE_SOUND_MAP}
        if SoundMap <> nil then SoundMap.Play(UpSound);
{$ENDIF}
      end;
    end
    else
    begin
      FState := ebsUp;
{$IFDEF USE_SOUND_MAP}
      if SoundMap <> nil then SoundMap.Play(UpSound);
{$ENDIF}
    end;
    Invalidate;
    Click;
    result := false;
  end
  else
  if
     (Key = VK_ESCAPE)
     and (Shift = []) then
  begin
    //result := true;
    GetParentForm(Self).Perform(CM_DIALOGKEY, Key, ShiftStateToKeyData(Shift))
  end
  else
  if
    (Key = VK_DOWN)
    and (Shift = [ssAlt]) and
    Enabled and FUseArrow and Assigned(FPullDownMenu) and (FPullDownMenu.AutoPopup) then
  begin
    // result := true;
    AClick(true)
  end;
end;

procedure TCustomElPopupButton.IntKeyUp;
begin
  if (
     (Key = VK_SPACE)
     and Focused) and (Shift = []) and CanFocus then
  begin
    if FIsSwitch then
    begin
      FDown := not FDown;
      if not FDown then
      begin
        FState := ebsUp;
{$IFDEF USE_SOUND_MAP}
        if SoundMap <> nil then SoundMap.Play(UpSound);
{$ENDIF}
      end;
    end
    else
    begin
      FState := ebsUp;
{$IFDEF USE_SOUND_MAP}
      if SoundMap <> nil then SoundMap.Play(UpSound);
{$ENDIF}
    end;
    Invalidate;
    Click;
  end;
end;

procedure TCustomElPopupButton.IntMouseEnter;
var P     : TPoint;
    b     : boolean;
begin
  b := false;
  if Enabled then
  begin
    if (not OldStyled) or IsThemeApplied then
      b := true;

    if UseArrow then
    begin
      GetCursorPos(P);
      P := ScreenToClient(P);
      FMouseInArrow := P.X > ClientWidth - GetArrowSize;
      if not FMouseInArrow then
        FMouseInControl := true;
    end
    else
      FMouseInControl := true;

    if UseImageList then
    begin
      if FHotImages <> nil then
      begin
        if THackGlyph(FGlyph).ImageList <> FHotImages then
          b := true;
        THackGlyph(FGlyph).ImageList := FHotImages;
        THackGlyph(FGlyph).AlphaImageList := FAlphaHotImages;
      end
      else
      begin
        if THackGlyph(FGlyph).ImageList <> FImageList then
          b := true;
        THackGlyph(FGlyph).ImageList := FImageList;
        THackGlyph(FGlyph).AlphaImageList := FAlphaImageList;
      end;
    end;
    if b then
      Invalidate;
  end;
end;

procedure TCustomElPopupButton.IntTextChanged;
begin
  if (Pos(#13#10, Caption) > 0)
  {$ifdef HAS_HTML_RENDER}
  and (not IsHTML)
  {$endif}
  then
    FMultiline := true
  else
    FMultiline := false;
  Invalidate;
end;

procedure TCustomElPopupButton.IntMouseLeave;
var b : boolean;
begin
  b := false;
  if not OldStyled or IsThemeApplied then
    b := true;
  if Enabled and (not FDragging) then
  begin
    if UseImageList and (HotImages <> nil) then
    begin
      if THackGlyph(FGlyph).ImageList <> FImageList then
        b := true;
      THackGlyph(FGlyph).ImageList := FImageList;
      THackGlyph(FGlyph).AlphaImageList := FAlphaImageList;
    end;
  end;
  if FMouseInControl or FMouseInArrow then
    b := true;
  FMouseInControl := False;
  FMouseInArrow := false;
  if b then
    Invalidate;
end;

function TCustomElPopupButton.DoSaveShadows: Boolean;
begin
  result := ShadowsUseCustom and not (ShadowFollowsColor);
end;

procedure TCustomElPopupButton.SetImageIsAlphaBlended(Value: Boolean);
begin
  if FImageIsAlphaBlended <> Value then
  begin
    FImageIsAlphaBlended := Value;
//    Invalidate;
  end;
end;

procedure TCustomElPopupButton.SetDrawFocusFrame(Value: Boolean);
begin
  if FDrawFocusFrame <> Value then
  begin
    FDrawFocusFrame := Value;
    if Focused then
      Invalidate;
  end;
end;

{$ifdef HAS_HTML_RENDER}
procedure TCustomElPopupButton.SetCursor(Value: TCursor);
var P : TPoint;
    R : TRect;
    href : TElFString;
begin
  if (FCursor <> Value) then
  begin
    FCursor := Value;
    {$IFDEF HAS_HTML_RENDER}
    if IsHTML then
    begin
      GetCursorPos(P);
      P := ScreenToClient(P);
      R := FTextRect;
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
{$endif}

procedure TCustomElPopupButton.SetChangeDisabledText(Value: Boolean);
begin
  if FChangeDisabledText <> Value then
  begin
    FChangeDisabledText := Value;
    if FState = ebsDisabled then
      Invalidate;
  end;
end;

procedure TCustomElPopupButton.SetAlignment(Value: TAlignment);
begin
  if FAlignment <> Value then
  begin
    FAlignment := Value;
    Invalidate;
  end;
end;

procedure TElSpeedButton.SetPullDownMenu(newValue : TPopupMenu);
begin
  if (FPullDownMenu <> newValue) then
  begin
    FPullDownMenu := newValue;
    if FPullDownMenu = nil then FPullDownEnabled := false;
  end; { if }
end; { SetPullDownMenu }

procedure TElSpeedButton.SetTransparent(newValue : Boolean);
begin
  if (FTransparent <> newValue) then
  begin
    FTransparent := newValue;
    Repaint;
  end; { if }
end; { SetTransparent }

procedure TElSpeedButton.Paint; { protected }
var
  xx, yy : integer;
  Bmp : TBitmap;
  IL : TImageList;

begin
  Bmp := nil;
  with Canvas do
  begin
    if not Transparent then
    begin
      pen.color := Color;
      Brush.Color := Color;
      Ellipse(1, 1, width - 2, height - 2); { fill inner button }
    end;
    if not Enabled then
      Bmp := FDisabledImage
    else if (not FPressed) and (not FOver) then
      Bmp := FNormalImage
    else if FPressed then
      Bmp := FPressedImage
    else if FOver then
      Bmp := FMouseInImage;
    if Bmp = nil then Bmp := FNormalImage;
    if Bmp <> nil then
    begin
      IL := TImageList.Create(self);
      xx := self.ClientWidth div 2 - Bmp.width div 2;
      if (bmp.width mod 2) <> 0 then dec(xx);
      yy := self.ClientHeight div 2 - Bmp.Height div 2;
      if (bmp.height mod 2) <> 0 then dec(yy);
      Brush.Color := Color;
      Il.Height := Bmp.Height;
      IL.Width := Bmp.Width;
      IL.AddMasked(Bmp, FTransparentColor);
      IL.DrawingStyle := dsNormal;
      IL.BkColor := clNone;
      IL.Draw(Canvas, XX, YY, 0);
      IL.Free;
    end;
    if (not FPressed) and ((FOver and FDrawEdge) or (not Flat)) or (csDesigning in ComponentState) then
    begin
      pen.color := clBtnHighlight; { highlighted edge }
      Arc(0, 0, width - 1, height - 1, width div 5 * 4, height div 5, width div 5, height div 5 * 4);
      pen.color := clBtnShadow; { shadowed edge }
      Arc(0, 0, width - 1, height - 1, width div 5, height div 5 * 4, width div 5 * 4, height div 5);
    end
    else if (FPressed and FDrawEdge) then
    begin
      pen.color := clBtnShadow; { shadowed edge }
      Arc(0, 0, width - 1, height - 1, width div 5 * 4, height div 5, width div 5, height div 5 * 4);
      pen.color := clBtnHighlight; { highlighted edge }
      Arc(0, 0, width - 1, height - 1, width div 5, height div 5 * 4, width div 5 * 4, height div 5);
    end;
  end;
end; { Paint }

procedure TElSpeedButton.MouseDown(Button : TMouseButton; Shift : TShiftState; X, Y : Integer); { protected }
begin
  if InCircle(X, Y) then
  begin
    FPressed := true;
    if FPullDownEnabled and (FPullDownBtn = Button) then
      StartTimer
    else
    begin
      FPullTimer.Free;
      FPullTimer := nil;
    end;
    Repaint;
  end;
  inherited;
end; { MouseDown }

procedure TElSpeedButton.MouseUp(Button : TMouseButton; Shift : TShiftState; X, Y : Integer); { protected }
begin
  if FPressed then
  begin
    FPressed := false;
    begin
      FPullTimer.Free;
      FPullTimer := nil;
    end;
    Repaint;
  end;
  inherited;
end; { MouseUp }

procedure TElSpeedButton.TriggerPullDownEvent;
begin
  if (assigned(FOnPullDown)) then
    FOnPullDown(Self);
end; { TriggerPullDownEvent }

procedure TElSpeedButton.SetDrawEdge(newValue : Boolean);
begin
  if (FDrawEdge <> newValue) then
  begin
    FDrawEdge := newValue;
    Repaint;
  end; { if }
end; { SetDrawEdge }

procedure TElSpeedButton.WMMouseMove(var Msg : TWMMouseMove); { private }
begin
  if (InCircle(Msg.XPos, Msg.YPos) and not FOver) then
  begin
    FOver := true;
    if ((MK_LBUTTON or MK_MBUTTON or MK_RBUTTON) and Msg.Keys) > 0 then FPressed := true;
    Repaint;
  end
  else if ((not InCircle(Msg.XPos, Msg.YPos)) and FOver) then
  begin
    FOver := false;
    FPressed := false;
    Repaint;
  end;
  inherited;
end; { WMMouseMove }

procedure TElSpeedButton.CMMouseLeave(var Msg : TMessage); { private }
var
  b : boolean;
begin
  inherited;
  b := false;
  if FPressed then
  begin
    FPressed := false;
    b := true;
  end;
  if FOver then
  begin
    FOver := false;
    b := true;
  end;
  if b then Repaint;
end; { CMMouseLeave }

function TElSpeedButton.InCircle(X, Y : integer) : Boolean; { public }
var
  xx, yy, ll : integer;
begin
  xx := abs(X - ClientWidth div 2);
  yy := abs(Y - ClientHeight div 2);
  ll := ClientWidth div 2;
  result := (sqr(xx) + sqr(yy)) <= sqr(ll);
end; { InCircle }

procedure TElSpeedButton.SetFlat(newValue : Boolean);
begin
  if (FFlat <> newValue) then
  begin
    FFlat := newValue;
    Repaint;
  end; { if }
end; { SetFlat }

procedure TElSpeedButton.SetNormalImage(newValue : TBitmap);
begin
  FNormalImage.Assign(newValue);
  if FAutoSize then
  begin
    ClientWidth := 3 + Trunc(sqrt(sqr(FNormalImage.Height) + sqr(FNormalImage.Width)));
    ClientHeight := ClientWidth;
  end;
  //if Enabled then Repaint;
end; { SetNormalImage }

procedure TElSpeedButton.SetDisabledImage(newValue : TBitmap);
begin
  FDisabledImage.Assign(newValue);
  if FAutoSize then
  begin
    ClientWidth := 3 + Trunc(sqrt(sqr(FDisabledImage.Height) + sqr(FDisabledImage.Width)));
    ClientHeight := ClientWidth;
  end;
  if not Enabled then Repaint;
end; { SetDisabledImage }

procedure TElSpeedButton.SetMouseInImage(newValue : TBitmap);
begin
  FMouseInImage.Assign(newValue);
  if FAutoSize then
  begin
    ClientWidth := 3 + Trunc(sqrt(sqr(FPressedImage.Height) + sqr(FPressedImage.Width)));
    ClientHeight := ClientWidth;
  end;
  if FOver then Repaint;
end; { SetMouseInImage }

procedure TElSpeedButton.SetPressedImage(newValue : TBitmap);
begin
  FPressedImage.Assign(newValue);
  if FAutoSize then
  begin
    ClientWidth := 3 + Trunc(sqrt(sqr(FPressedImage.Height) + sqr(FPressedImage.Width)));
    ClientHeight := ClientWidth;
  end;
  if FPressed then Repaint;
end; { SetPressedImage }

destructor TElSpeedButton.Destroy;
begin
  FNormalImage.Free;
  FDisabledImage.Free;
  FMouseInImage.Free;
  FPressedImage.Free;
  if FPullTimer <> nil then FPullTimer.Free;
  inherited Destroy;
end; { Destroy }

constructor TElSpeedButton.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  FPullTimer := nil;
  FPullDownInterval := 1000;
  FPullDownEnabled := false;
  FTransparent := true;
  FDrawEdge := False;
  FNormalImage := TBitmap.Create;
  FDisabledImage := TBitmap.Create;
  FMouseInImage := TBitmap.Create;
  FPressedImage := TBitmap.Create;
  FAutoSize := true;
  Color := clBtnFace;
  Width := 20;
  Height := 20;
end; { Create }

procedure TElSpeedButton.SetAutoSize(newValue : boolean);
begin
  inherited;
  if FAutoSize <> newValue then
  begin
    FAutoSize := newValue;
    if FAutoSize then
    begin
      ClientWidth := 3 + Trunc(sqrt(sqr(FNormalImage.Height) + sqr(FNormalImage.Width)));
      ClientHeight := ClientWidth;
    end;
  end;
end;

procedure TElSpeedButton.SetTransparentColor(newValue : TColor);
begin
  if (FTransparentColor <> newValue) then
  begin
    FTransparentColor := newValue;
{$IFNDEF VER90}
    FNormalImage.TransparentColor := newValue;
    FDisabledImage.TransparentColor := newValue;
    FMouseInImage.TransparentColor := newValue;
    FPressedImage.TransparentColor := newValue;
{$ENDIF}
    Repaint;
  end; { if }
end; { SetTransparentColor }

procedure TElSpeedButton.WMEraseBkgnd(var Msg : TWMEraseBkgnd); { private }
begin
  Msg.Result := 1;
end; { WMEraseBkgnd }

procedure TElSpeedButton.StartTimer;
begin
  if FPullDownInterval > 0 then
  begin
    if FPullTimer = nil then FPullTimer := TTimer.Create(self);
    FPullTimer.Interval := FPullDownInterval;
    FPullTimer.OnTimer := OnTimer;
    FPullTimer.Enabled := true;
  end
  else
    PullMenu;
end;

procedure TElSpeedButton.OnTimer(Sender : TObject);
begin
  FPullTimer.Enabled := false;
  PullMenu;
end;

procedure TElSpeedButton.PullMenu;
var
  P : TPoint;
begin
  TriggerPullDownEvent;
  if FPullDownMenu <> nil then
  begin
    if FPullDownMenu.Alignment = paLeft then
    begin
      P.X := 0;
      P.Y := Height + 1;
    end
    else if FPullDownMenu.Alignment = paRight then
    begin
      P.X := Width;
      P.Y := Height + 1;
    end
    else
    begin
      P.X := Width div 2;
      P.Y := Height + 1;
    end;
    P := ClientToScreen(P);
    FPullDownMenu.Popup(P.X, P.Y);
  end;
end;


{$IFDEF VCL_4_USED}

procedure TElPopupButtonActionLink.SetChecked(Value : boolean);
begin
  if IsCheckedLinked then
  begin
    with TCustomElPopupButton(FClient) do
    begin
      ClicksDisabled := True;
      try
        Checked := Value;
      finally
        ClicksDisabled := False;
      end;
    end;
  end;
end;

procedure TElPopupButtonActionLink.SetImageIndex(Value: Integer);
begin
  if FClient is TCustomElPopupButton then
  begin
    TCustomElPopupButton(FClient).ImageIndex := value;
  end;
end;

{$ENDIF}


// =============================================================================

function TCustomElGraphicButton.GetChecked : Boolean;
begin
  result := Down;
end;

procedure TCustomElGraphicButton.SetChecked(newValue : Boolean);
begin
  Down := newValue;
end;

procedure TCustomElGraphicButton.SetPopupPlace(Value : TPopupPlace);
begin
  FPopupPlace := Value;
end;

procedure TCustomElGraphicButton.SetDisableAp(Value : boolean);
begin
  FDisableAp := Value;
end;

function TCustomElGraphicButton.IsColorStored : boolean;
begin
  result := not ParentColor;
end;

procedure TCustomElGraphicButton.SetShowBorder;
begin
  if FShowBorder <> newValue then
  begin
    FShowBorder := newValue;
    Invalidate;
  end;
end;

{$ifdef ELPACK_USE_IMAGEFORM}
procedure TCustomElGraphicButton.ImageFormChange(Sender : TObject);
begin
  Invalidate;
end;

procedure TCustomElGraphicButton.SetImageForm(newValue : TElImageForm);
begin
  if FImgForm <> newValue then
  begin
    if FImgForm <> nil then
    begin
      {$ifdef VCL_5_USED}
      if (FImgForm <> nil) and (not (csDestroying in FImgForm.ComponentState)) then
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


procedure TCustomElGraphicButton.Paint;
var
  PaintRect,
  R1, BgRect : TRect;
  ACtl    : TWinControl;
  ArrRect : TRect;
  Offset : TPoint;
  dw : integer;
  aw : integer;
  AColor : TColor;
  ax, ay : integer;
  P      : TPoint;
  SaveIL : TImageList;
  SaveAIL : TImageList;
  GlyphState : TElButtonState;
  sID     : integer;
  RClip   : TRect;
  Bitmap  : TBitmap;
  Canvas  : TCanvas;

  procedure DrawButtonFrameEx(DC : HDC; rc : TRect; Focused : boolean; Pushed : boolean; ButtonColor : TColor; Thin : boolean);
  begin
    if ShadowsUseCustom then
       ElVCLUtils.DrawButtonFrameEx2(DC, rc, Focused, Pushed, ButtonColor, Thin, ColorToRGB(FShadowBtnHighlight), ColorToRGB(FShadowBtnDkShadow), ColorToRGB(Color), ColorToRGB(FShadowBtnShadow), AllBorderSides)
    else
       ElVCLUtils.DrawButtonFrameEx3(DC, rc, Focused, Pushed, ButtonColor, Thin, AllBorderSides);
  end;

begin
  SaveIL := nil;
  SaveAIL := nil;
  sid := 0;
  Bitmap := Tbitmap.Create;
  Bitmap.Handle := CreateCompatibleBitmap(Self.Canvas.Handle, ClientWidth, ClientHeight);
  Canvas := Bitmap.Canvas;
  bitblt(Bitmap.Canvas.Handle, 0, 0, Bitmap.Width, Bitmap.Height, Self.Canvas.Handle, 0, 0, SRCCOPY);

  if (not Enabled) or (not Parent.Enabled) then
  begin
    FState := ebsDisabled;
    FDragging := False;
  end
  else
  if FState = ebsDisabled then
    if FDown and (GroupIndex <> 0) then
      FState := ebsExclusive
    else
      FState := ebsUp;
  Canvas.Font := Self.Font;
  PaintRect := ClientRect;

  if FShadowFollowsColor then
    AColor := Color
  else
    AColor := clBtnFace;

  {$ifdef MSWINDOWS}
  if not IsThemeApplied then
  {$endif}
  begin
    if not Transparent then
    begin
      {$ifdef ELPACK_USE_IMAGEFORM}
      if (FImgForm <> nil) and (not (csDesigning in FImgForm.GetRealControl.ComponentState)) then
      begin
        ACtl := FImgForm.GetRealControl;
        R1 := PaintRect;
        BgRect := R1;
        BgRect.TopLeft := ClientToScreen(BgRect.TopLeft);
        P := Parent.ClientToScreen(Point(Left, Top));
        ax := BgRect.Left - P.x;
        ay := BgRect.Top - P.y;

        BgRect.BottomRight := ClientToScreen(BgRect.BottomRight);
        BgRect.TopLeft := ACtl.ScreenToClient(BgRect.TopLeft);
        BgRect.BottomRight := ACtl.ScreenToClient(BgRect.BottomRight);
        FImgForm.PaintBkgnd(Canvas.Handle, R1, Point(BgRect.Left - ax, BgRect.Top - ay), false);
      end;
      {$endif}
      begin
        Canvas.Brush.Color := Color;
        if ((FDown and FIsSwitch) or (FState in [ebsDown, ebsExclusive])) then
        begin
          if (not FDownBackground.Empty) then
            Canvas.CopyRect(ClientRect, DownBackground.Canvas, Rect(0, 0, DownBackground.Width, DownBackground.Height))
          else
          {$ifdef ELPACK_USE_IMAGEFORM}
          if (FImgForm = nil) or (csDesigning in FImgForm.GetRealControl.ComponentState) then
          {$endif}
            Canvas.FillRect(PaintRect);
        end
        else
        begin
          if (not Background.Empty) then
            Canvas.CopyRect(ClientRect, Background.Canvas, Rect(0, 0, Background.Width, Background.Height))
          else
          {$ifdef ELPACK_USE_IMAGEFORM}
          if (FImgForm = nil) or (csDesigning in FImgForm.GetRealControl.ComponentState) then
          {$endif}
            Canvas.FillRect(PaintRect);
        end;
      end;
    end
    else
    begin
      bitblt(Bitmap.Canvas.Handle, 0, 0, ClientWidth, ClientHeight, Self.Canvas.Handle, 0, 0, SRCCOPY);
    end;
    PaintRect := ClientRect;
  end;

  dw := 0;
  aw := 0;

  {$ifdef MSWINDOWS}
  if (not IsThemeApplied) or (FArrTheme = 0) then
  {$endif}
  begin
    if not FFlat then
    begin
      if FUseArrow then
      begin
        dw := GetArrowSize;
        aw := dw;
        Dec(PaintRect.Right, dw);
      end;
      if ((Background.Empty) or (BackgroundDrawBorder)) and ShowBorder then
      begin
        if MoneyFlat then
        begin
          if (FDown and FIsSwitch) or (FState in [ebsDown, ebsExclusive]) then
            Canvas.Brush.Color := MoneyFlatDownColor
          else
          if (FMouseInControl or FMouseInArrow or Focused) and (FState <> ebsDisabled) then
            Canvas.Brush.Color := MoneyFlatActiveColor
          else
            Canvas.Brush.Color := MoneyFlatInactiveColor;
          Canvas.FrameRect(PaintRect);
          InflateRect(PaintRect, -1, -1);
        end
        else
        begin
             DrawButtonFrameEx(Canvas.Handle, PaintRect, OldStyled or ((FMouseInControl or Focused)) and (not ThinFrame),
                             (FDown and FIsSwitch) or (FState in [ebsDown, ebsExclusive]), AColor, ThinFrame);
        end;
      end;
    end
    else
    begin
      if FUseArrow then
      begin
        dw := GetArrowSize;
        aw := dw;
        Dec(PaintRect.Right, dw);
      end;
      if MoneyFlat then
      begin
        if (FDown and FIsSwitch) or (FState in [ebsDown, ebsExclusive]) then
          Canvas.Brush.Color := MoneyFlatDownColor
        else
        if (FMouseInControl or FMouseInArrow or Focused) and (FState <> ebsDisabled) then
          Canvas.Brush.Color := MoneyFlatActiveColor
        else
          Canvas.Brush.Color := MoneyFlatInactiveColor;
        Canvas.FrameRect(PaintRect);
        InflateRect(PaintRect, -1, -1);
      end
      else
      begin
        if (FDown and FIsSwitch) or (FState in [ebsDown, {ebsArrDown, }ebsExclusive]) or
          ((FMouseInControl or FMouseInArrow or Focused) and (FState <> ebsDisabled)) or (csDesigning in ComponentState) then
        begin
          if ((Background.Empty) or (BackgroundDrawBorder)) and ShowBorder then
             DrawButtonFrameEx(Canvas.Handle, PaintRect, false, //OldStyled or ((FMouseInControl or Focused)) and (not ThinFrame),
                             (FDown and FIsSwitch) or (FState in [ebsDown, ebsExclusive]), AColor, true{ThinFrame});
        end;
      end;
    end;

    // draw the rectangle for the arrow
    if FUseArrow then
    begin
      if dw = 0 then
      begin
        dw := GetArrowSize;
        Dec(PaintRect.Right, dw);
      end;
      ArrRect := Rect(PaintRect.Right, 0, PaintRect.Right + dw, Height);

      Canvas.Brush.Color := Color;

      if ((Background.Empty) or (BackgroundDrawBorder)) and FShowBorder then
      begin
        if MoneyFlat then
        begin
          if (FState in [ebsArrDown, ebsDown]) then
            Canvas.Brush.Color := MoneyFlatDownColor
          else
          if (FMouseInControl or FMouseInArrow or Focused) and (FState <> ebsDisabled) then
            Canvas.Brush.Color := MoneyFlatActiveColor
          else
            Canvas.Brush.Color := MoneyFlatInactiveColor;
          Canvas.FrameRect(ArrRect);
        end
        else
        begin
          if ((not FFlat) or ((FMouseInControl or FMouseInArrow or Focused) or
              (FState in [ebsArrDown, ebsExclusive])
               or (csDesigning in ComponentState))) then
            DrawButtonFrameEx(Canvas.Handle, ArrRect, ({FMouseInArrow or }FOldStyled) and (not FThinFrame) and (not FDown), (FState in [ebsDown, ebsArrDown]), AColor, ThinFrame or Flat);
        end;
      end;
      DrawArrow(Canvas, eadDown, ArrRect, Font.Color, FState <> ebsDisabled);
    end;
  {$ifdef MSWINDOWS}
  end
  else
  begin
    //DrawThemedBackground(Canvas);
    sid := GetThemeStateID;
    if FUseArrow then
    begin
      dw := GetArrowSize;
      aw := dw;
      Dec(PaintRect.Right, dw);
    end;
    RClip := Canvas.ClipRect;

    DrawThemeBackground(Theme, Canvas.Handle, GetThemePartID, sID, PaintRect, @RClip);

    if FUseArrow then
    begin
      if dw = 0 then
      begin
        dw := GetArrowSize();
        Dec(PaintRect.Right, dw);
      end;
      ArrRect := Rect(PaintRect.Right, PaintRect.Top, PaintRect.Right + dw, PaintRect.Bottom);

      RClip := Canvas.ClipRect;
      DrawThemeBackground(FArrTheme, Canvas.Handle, GetArrowThemePartID, GetArrowThemeStateID, ArrRect, @RClip);
    end;
  {$endif}
  end;

  Offset.x := 0;
  Offset.y := 0;

  if (FState in [ebsDown, ebsExclusive]) or (FDown and FIsSwitch) then
  begin
    if (FState = ebsExclusive) or
       (UseImageList and ((DownImages = nil) or (DownImages = Images))) or
       (UseIcon) or
       ((not UseImageList) and (UseIcon) and (NumGlyphs < 2)) then
    begin
      Offset.X := 1;
      Offset.Y := 1;
    end;
  end;
  inc(PaintRect.Right, dw);

  if ((FDown and FIsSwitch) or (FState in [ebsDown, ebsExclusive])) and (FDownImages <> nil) then
  begin
    SaveIL := THackGlyph(FGlyph).FImageList;
    SaveAIL := THackGlyph(FGlyph).FAlphaImageList;
    THackGlyph(FGlyph).FImageList := FDownImages;
    THackGlyph(FGlyph).FAlphaImageList := FAlphaDownImages;
  end;

  if (THackGlyph(FGlyph).FImageList = Self.FDisabledImages) and (FDisabledImages <> nil) and (FState = ebsDisabled) then
    GlyphState := ebsUp
  else
    GlyphState := FState;

  if AdjustSpaceForGlyph then
  begin
    if (not FThinFrame) then
      InflateRect(PaintRect, -2, -2)
    else
      InflateRect(PaintRect, -1, -1);
  end;
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
  end;
  {$endif}
  FTextRect := FGlyph.Draw(Canvas, PaintRect, Offset, Caption, FLayout, FMargin,
    FSpacing, FState, GlyphState, Alignment, true, FMultiline, false, ShowGlyph,
    FShowText, Aw, TextDrawType, Color,
    {$ifdef MSWINDOWS}false{ParentFont and (Theme <> 0)}, FTheme, GetThemePartID, sid
    {$else}false, 0, 0, 0{$endif},
    ShortcutsEnabled, ImageIsAlphaBlended{$ifdef HAS_HTML_RENDER}, IsHTML, FRender{$endif}, FChangeDisabledText);
//  Canvas.Stop;


  if ((FDown and FIsSwitch) or (FState in [ebsDown, ebsExclusive])) and (FDownImages <> nil) then
  begin
    THackGlyph(FGlyph).FImageList := SaveIL;
    THackGlyph(FGlyph).FAlphaImageList := SaveAIL;
  end;
  bitblt(Self.Canvas.Handle, 0, 0, ClientWidth, ClientHeight, Bitmap.Canvas.Handle, 0, 0, SRCCOPY);
  Bitmap.Free;
end;

{$HINTS OFF}
procedure TCustomElGraphicButton.AClick;
var
{$IFNDEF VER90}
  Form : TCustomForm;
{$ELSE}
  Form : TForm;
{$ENDIF}

{$IFDEF VCL_4_USED}
const
   Buttons: array[TTrackButton] of Word = (TPM_RIGHTBUTTON, TPM_LEFTBUTTON);
{$ENDIF}

begin
  Form := GetParentForm(Self);
  if Form <> nil then Form.ModalResult := ModalResult;
  if Arrow then
  begin
{$IFDEF USE_SOUND_MAP}
    if SoundMap <> nil then SoundMap.Play(ArrowClickSound);
{$ENDIF}
    if Assigned(FOnArrowClick) then FOnArrowClick(Self);
  end
  else
  begin
{$IFDEF USE_SOUND_MAP}
    if SoundMap <> nil then SoundMap.Play(ClickSound);
{$ENDIF}
    inherited Click;
    //FMouseInControl := false;
    Invalidate;
  end;
  if (PullDownMenu = nil) or (FDisableAp) or ((not Arrow) and FUseArrow) then exit;
  DoPullMenu;
end;

{$HINTS ON}
procedure TCustomElGraphicButton.CMDialogKey(var Message : TCMDialogKey);
begin
  with Message do
    if ShortcutsEnabled and ((((CharCode = VK_RETURN) and FDefault) or
      ((CharCode = VK_ESCAPE) and FCancel)) and
      (KeyDataToShiftState(Message.KeyData) = [])) then
    begin
      Click;
      Result := 1;
    end
    else
      inherited;
end;

procedure TCustomElGraphicButton.CMDialogChar(var Message : TCMDialogChar);
begin
  with Message do
    if ShortcutsEnabled and IsAccel(CharCode, Caption) then
    begin
      Click;
      Result := 1;
    end
    else
      inherited;
end;

procedure TCustomElGraphicButton.UpdateExclusive;
var
  Msg : TMessage;
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

procedure TCustomElGraphicButton.GlyphChanged(Sender : TObject);
begin
  if (not (csLoading in ComponentState)) and
     (not UseIcon) and (not UseImageList) then
  Invalidate;
end;

function TCustomElGraphicButton.GetPalette : HPALETTE;
begin
  Result := Glyph.Palette;
end;

function TCustomElGraphicButton.GetGlyph : TBitmap;
begin
  Result := FGlyph.Glyph;
end;

procedure TCustomElGraphicButton.SetGlyph(Value : TBitmap);
begin
  FGlyph.Glyph := Value;
  FGlyph.ResetNumGlyphs;
  Invalidate;
end;

function TCustomElGraphicButton.GetNumGlyphs : TNumGlyphs;
begin
  Result := FGlyph.NumGlyphs;
end;

procedure TCustomElGraphicButton.SetNumGlyphs(Value : TNumGlyphs);
begin
  if Value < 0 then
    Value := 1
  else if Value > 4 then
    Value := 4;
  // if Value <> FNumGlyphs then
  begin
    FNumGlyphs := Value;
    if (ComponentState * [csReading, csLoading] = []) then
    begin
      FGlyph.NumGlyphs := Value;
      Invalidate;
    end;
  end;
end;

procedure TCustomElGraphicButton.SetDown(Value : Boolean);
begin
  if csLoading in ComponentState then
  begin
    FDown := value;
    exit;
  end;
  if (FGroupIndex = 0) and (not FIsSwitch) then Value := False;
  if FDown and (not FAllowAllUp) and (not FIsSwitch) then Exit;
  if FDown <> Value then
  begin
    FDown := Value;
    if Value then
    begin
  {$IFDEF USE_SOUND_MAP}
      if SoundMap <> nil then SoundMap.Play(DownSound);
  {$ENDIF}
      if FIsSwitch then
        FState := ebsDown
      else
        FState := ebsExclusive;
      Invalidate;
    end
    else
    begin
  {$IFDEF USE_SOUND_MAP}
      if SoundMap <> nil then SoundMap.Play(UpSound);
  {$ENDIF}
      FState := ebsUp;
      Invalidate;
    end;
    if Value then UpdateExclusive;
  end;
end;

procedure TCustomElGraphicButton.SetFlat(Value : Boolean);
begin
  if Value <> FFlat then
  begin
    FFlat := Value;
    if Value then
    begin
      OldStyled := false;
    end;
    Invalidate;
  end;
end;

procedure TCustomElGraphicButton.SetGroupIndex(Value : Integer);
begin
  if FGroupIndex <> Value then
  begin
    FGroupIndex := Value;
    UpdateExclusive;
  end;
end;

procedure TCustomElGraphicButton.SetLayout(Value : TButtonLayout);
begin
  if FLayout <> Value then
  begin
    FLayout := Value;
    Invalidate;
  end;
end;

procedure TCustomElGraphicButton.SetMargin(Value : Integer);
begin
  if (Value <> FMargin) and (Value >= -1) then
  begin
    FMargin := Value;
    Invalidate;
  end;
end;

procedure TCustomElGraphicButton.SetSpacing(Value : Integer);
begin
  if Value <> FSpacing then
  begin
    FSpacing := Value;
    Invalidate;
  end;
end;

procedure TCustomElGraphicButton.SetAllowAllUp(Value : Boolean);
begin
  if FAllowAllUp <> Value then
  begin
    FAllowAllUp := Value;
    UpdateExclusive;
  end;
end;

procedure TCustomElGraphicButton.UpdateTracking;
var
  P : TPoint;
begin
  if not Enabled then
    FMouseInControl := false;

  if FFlat and Enabled then
  begin
    GetCursorPos(P);
    FMouseInControl := not (FindDragTarget(P, True) = Self);
    if Enabled and FMouseInControl then
      Perform(CM_MOUSELEAVE, 0, 0)
    else
      Perform(CM_MOUSEENTER, 0, 0);
  end;
end;

procedure TCustomElGraphicButton.Loaded;
var
  State : TElButtonState;
begin
  inherited Loaded;
  if Enabled then
    State := ebsUp
  else
    State := ebsDisabled;
  if FUseImageList then
    THackGlyph(FGlyph).UseImageList := true;
  THackGlyph(FGlyph).CreateButtonGlyph(State);
  THackGlyph(FGlyph).NumGlyphs := FNumGlyphs;
  if FDown then
  begin
    FDown := false;
    Down := true;
  end;
  Invalidate;
end;

procedure TCustomElGraphicButton.CMEnabledChanged(var Message : TMessage);
begin
  inherited;
  IntEnabledChanged;
end;

procedure TCustomElGraphicButton.CMButtonPressed(var Message : TMessage);
var
  Sender : TCustomElGraphicButton;
begin
  if Message.WParam = FGroupIndex then
  begin
    Sender := TCustomElGraphicButton(Message.LParam);
    if Sender <> Self then
    begin
      if Sender.Down and FDown then
      begin
        FDown := False;
{$IFDEF USE_SOUND_MAP}
        if SoundMap <> nil then SoundMap.Play(UpSound);
{$ENDIF}
        FState := ebsUp;
        Invalidate;
      end;
      FAllowAllUp := Sender.AllowAllUp;
    end;
  end;
end;

procedure TCustomElGraphicButton.CMFontChanged(var Message : TMessage);
begin
  inherited;
  Invalidate;
end;

procedure TCustomElGraphicButton.CMColorChanged(var Message : TMessage);
var ButtonColor : TColor;
    hls1, hls2, hls3, hls4 : integer;
    lum : integer;

begin
  inherited;
  if not ShadowsUseCustom then
  begin
    ButtonColor := ColorToRGB(Color);

    hls1 := RGBtoHLS(ButtonColor);
    hls2 := hls1;
    hls3 := hls1;
    hls4 := hls1;

    lum := Hi(LoWord(hls3));
    hls1 := (Min(239, (Hi(LoWord(hls3))  + lum div 3)) shl 8) or (hls1 and $FF00FF);
    hls2 := (Min(239, (Hi(LoWord(hls3))  - lum div 2)) shl 8) or (hls2 and $FF00FF);
    hls4 := (Min(239, (Hi(LoWord(hls3))  - lum div 3)) shl 8) or (hls4 and $FF00FF);

    FShadowBtnHighlight := HLStoRGB(hls1);
    FShadowBtnDkShadow  := HLStoRGB(hls2);
    FShadowBtnShadow    := HLStoRGB(hls4);
  end;
  Invalidate;
end;

procedure TCustomElGraphicButton.CMTextChanged(var Message : TMessage);
begin
  IntTextChanged;
end;

procedure TCustomElGraphicButton.CMSysColorChange(var Message : TMessage);
begin
  with THackGlyph(FGlyph) do
  begin
    Invalidate;
    CreateButtonGlyph(FState);
  end;
end;

procedure TCustomElGraphicButton.CMMouseEnter(var Message : TMessage);
begin
  inherited;
  IntMouseEnter;
  (*
  DoInv := false;
  if IsThemeApplied then
    DoInv := true;
  if (not FMouseInControl) and Enabled then
  begin
    if UseArrow then
    begin
      GetCursorPos(P);
      P := ScreenToClient(P);
      FMouseInArrow := P.X > ClientWidth - GetArrowSize;
      if not FMouseInArrow then
        FMouseInControl := true;
    end
    else
      FMouseInControl := true;
    DoInv := true;

    if UseImageList then
    begin
      if FHotImages <> nil then
      begin
        THackGlyph(FGlyph).ImageList := FHotImages
        THackGlyph(FGlyph).AlphaImageList := FAlphaHotImages
      end else
      begin
        THackGlyph(FGlyph).ImageList := FImageList;
        THackGlyph(FGlyph).AlphaImageList := FAlphaImageList;
      end;
      DoInv := FHotImages <> FImageList;
    end;
  end;
  if DoInv then Invalidate;
  *)
end;

procedure TCustomElGraphicButton.CMMouseLeave(var Message : TMessage);
// var DoInv : boolean;
begin
  inherited;
  IntMouseLeave;
  (*
  DoInv := false;
  if IsThemeApplied then
    DoInv := true;
  if FMousEInArrow then
    DoInv := true;
  if FMouseInControl and Enabled and not FDragging then
  begin
    if UseImageList and (HotImages <> nil) then
    begin
      THackGlyph(FGlyph).ImageList := FImageList;
      THackGlyph(FGlyph).AlphaImageList := FAlphaImageList;
      DoInv := FHotImages <> FImageList;
    end;
    if Flat or (not (OldStyled or ThinFrame)) then DoInv := true;
  end;
  FMouseInControl := False;
  FMouseInArrow := false;
  if DoInv then Invalidate;
  *)
end;

procedure TCustomElGraphicButton.MouseDown(Button : TMouseButton; Shift : TShiftState;
  X, Y : Integer);
var
  l : integer;
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
    R := FTextRect;
    if IsHTML and FRender.IsCursorOverLink(Point(P.X - R.Left, P.Y - R.Top), Point(0, 0), R, href) then
      exit;
  end;
  {$endif}

  FOrigState := ebsUp;
  if (csDesigning in ComponentState) or ((Parent <> nil) and (csDesigning in Parent.ComponentState)) then exit;
  inherited MouseDown(Button, Shift, X, Y);
  if (Button = mbLeft) and Enabled then
  begin
    l := 11;
    if not FFlat then inc(l, 4);
    if (not FDown) and ((FUseArrow and not InRange(Width - l, Width, X)) or not FUseArrow) then
    begin
      FState := ebsDown;
{$IFDEF USE_SOUND_MAP}
      if SoundMap <> nil then SoundMap.Play(DownSound);
{$ENDIF}
      Invalidate;
    end
    else
    if (not FArrDown) and (FUseArrow and InRange(Width - l, Width, X)) then
    begin
{$IFDEF USE_SOUND_MAP}
      if SoundMap <> nil then SoundMap.Play(DownSound);
{$ENDIF}
      if FIgnoreClick then FIgnoreClick := false else
      begin
        FState := ebsArrDown;
        Invalidate;
        FOrigState := ebsArrDown;
        AClick(true);
        if not FInMenu then
          FDragging := true;
      end;
      exit;
    end;
    FDragging := True;
    FMouseInControl := true;
  end else if (Button <> mbLeft) then FIgnoreClick := false;
end;

procedure TCustomElGraphicButton.MouseMove(Shift : TShiftState; X, Y : Integer);
var
  NewState : TElButtonState;
var
  l : integer;
  b : boolean;
begin
  inherited MouseMove(Shift, X, Y);
  if FDragging then
  begin
    if (not FDown) and (not FArrDown) then
      NewState := ebsUp
    else
      NewState := ebsExclusive;
    if (X >= 0) and (X < ClientWidth) and (Y >= 0) and (Y <= ClientHeight) then
    begin
      if FDown then
        NewState := ebsExclusive
      else
      begin
        l := GetArrowSize;
        // if not FFlat then inc(l, 4);
        if (FUseArrow and InRange(Width - l, Width, X)) then
          NewState := ebsArrDown
        else
          NewState := ebsDown;
      end;
    end
    else
    begin
      if UseArrow then
      begin
        FMouseInArrow := false;
        Invalidate;
      end;
    end;
    if NewState <> FState then
    begin
      FState := NewState;
      if FState = ebsDown then
      begin
{$IFDEF USE_SOUND_MAP}
        if SoundMap <> nil then SoundMap.Play(DownSound);
{$ENDIF}
      end
      else if FState = ebsUp then
{$IFDEF USE_SOUND_MAP}
        if SoundMap <> nil then SoundMap.Play(UpSound);
{$ENDIF}
      UpdateTracking;
      Invalidate;
    end;
  end
  else
  if UseArrow then
  begin
    //b := FMouseInArrow;
    FMouseInArrow := X > ClientWidth - GetArrowSize;

    if FMouseInArrow then
    begin
      b := FMouseInControl = false;
      FMouseInControl := false;
    end
    else
    begin
      b := FMouseInControl = false;
      FMouseInControl := true;
    end;
    if b <> FMouseInArrow then
      Invalidate;
  end;
end;

procedure TCustomElGraphicButton.MouseUp(Button : TMouseButton; Shift : TShiftState;
  X, Y : Integer);
var
  DoClick : Boolean;
  ArrClick : Boolean;
  l : integer;
  {$IFDEF HAS_HTML_RENDER}
  P : TPoint;
  R : TRect;
  href : TElFString;
  {$endif}
begin
  inherited;
  {$IFDEF HAS_HTML_RENDER}
  if IsHTML then
  begin
    GetCursorPos(P);
    P := ScreenToClient(P);
    R := FTextRect;

    if IsHTML and FRender.IsCursorOverLink(Point(P.X - R.Left, P.Y - R.Top), Point(0, 0), R, href) then
    begin
      TriggerLinkClickEvent(href);
      exit;
    end;
  end;
  {$endif}
  if FDragging and (Button = mbLeft) then
  begin
    FDragging := False;
    DoClick := (X >= 0) and (X < ClientWidth) and (Y >= 0) and (Y <= ClientHeight);
    l := 11;
    if not FFlat then inc(l, 4);
    ArrClick := (FUseArrow and InRange(Width - l, Width, X));
    if FGroupIndex = 0 then
    begin
      if FIsSwitch and (not ArrClick) then
      begin
        if FOrigState <> ebsArrDown then
        begin
          if DoClick then
          begin
            FDown := not FDown;
            if FDown then
            begin
              FState := ebsDown;
  {$IFDEF USE_SOUND_MAP}
              if SoundMap <> nil then SoundMap.Play(DownSound);
  {$ENDIF}
            end
            else
            begin
              FState := ebsUp;
  {$IFDEF USE_SOUND_MAP}
              if SoundMap <> nil then SoundMap.Play(UpSound);
  {$ENDIF}
            end;
          end;
        end else
        begin
          FState := ebsUp;
{$IFDEF USE_SOUND_MAP}
          if SoundMap <> nil then SoundMap.Play(UpSound);
{$ENDIF}
        end;
      end
      else
      begin
        if ArrClick and FInMenu then
          DoClick := false
        else
        begin
          FState := ebsUp;
{$IFDEF USE_SOUND_MAP}
          if SoundMap <> nil then SoundMap.Play(UpSound);
{$ENDIF}
        end;
      end;
      FMouseInControl := PtInRect(ClientRect, Point(X, Y));
      if not FMouseInControl then
        IntMouseLeave;
      if not (FState in [ebsExclusive, ebsArrDown, ebsDown]) then
        Invalidate;
    end
    else
    if DoClick then
    begin
      SetDown(not FDown);
      if FDown or FArrDown then Invalidate;
    end
    else
    begin
      if FDown then
        FState := ebsExclusive;
      Invalidate;
    end;
    if DoClick then
    begin
      AClick(ArrClick);
    end;
  end;
end;

{$HINTS OFF}
procedure TCustomElGraphicButton.WndProc(var Message : TMessage);
var P : TPoint;
    I : Integer;
    MenuItem: TMenuItem;
    FindKind: TFindItemKind;
    ContextID: Integer;
    DC: HDC;
    R : TRect;
    Item: Integer;

begin
  if Message.Msg = MenuCancelMsg then
  begin
    FInMenu := false;
    FDragging := false;
    FArrDown := false;
    FState := ebsUp;
    Perform(CM_MOUSELEAVE, 0, 0);
    Exit;
  end;

  //if FInMenu then
  try
    case Message.Msg of
      EL_THEMECHANGED:
        ELThemeChanged(Message);
{$IFNDEF VCL_5_USED}
      WM_COMMAND:
        if FPulldownMenu.DispatchCommand(Message.wParam) then Exit;
      WM_INITMENUPOPUP:
        with TWMInitMenuPopup(Message) do
          if FPulldownMenu.DispatchPopup(MenuPopup) then Exit;
      WM_MENUSELECT:
        with TWMMenuSelect(Message) do
        begin
          FindKind := fkCommand;
          if MenuFlag and MF_POPUP <> 0 then FindKind := fkHandle;
          MenuItem := FPulldownMenu.FindItem(IDItem, FindKind);
          if MenuItem <> nil then
          begin
            Application.Hint := MenuItem.Hint;
            Exit;
          end;
          Application.Hint := '';
        end;
      WM_HELP:
        with PHelpInfo(Message.LParam)^ do
        begin
            if (FPullDownMenu <> nil) and (FPulldownMenu.Handle = hItemHandle) then
            begin
              ContextID := FPulldownMenu.GetHelpContext(iCtrlID, True);
              if ContextID = 0 then
                ContextID := FPulldownMenu.GetHelpContext(hItemHandle, False);
              if Screen.ActiveForm = nil then Exit;
              if (biHelp in Screen.ActiveForm.BorderIcons) then
                Application.HelpCommand(HELP_CONTEXTPOPUP, ContextID)
              else
                Application.HelpContext(ContextID);
              Exit;
            end;
        end;
{$ELSE}
      WM_COMMAND,
      WM_INITMENUPOPUP,
      WM_MENUSELECT,
      WM_DRAWITEM,
      WM_MEASUREITEM,
      WM_MENUCHAR,
      WM_HELP:
        {$ifdef ELPACK_COMPLETE}
        if (PulldownMenu is TElPopupMenu) then
          with Message do
            SendMessage(GetParentForm(Self).Handle, Msg, wParam, lParam)
        else
        {$endif}
          with Message do
            SendMessage(PopupList.Window, Msg, wParam, lParam);
{$ENDIF}
      WM_EXITMENULOOP:
        begin
          GetCursorPos(P);
          P := ScreenToClient(P);
          FDragging := true;
          PostMessage(FWND, MenuCancelMsg, 0, 0);
          if PtInRect(Rect(ClientWidth - GetArrowSize, 0, ClientWidth, ClientHeight), P) then
             FIgnoreClick := true;
          {$IFDEF VCL_5_USED}
          with Message do
               SendMessage(PopupList.Window, Msg, wParam, lParam);
          {$ENDIF}
        end;
      WM_QUERYENDSESSION:
        begin
          Message.Result := 1;
          exit;
        end;
      end
  except
    Application.HandleException(Self);
  end;
  if Message.Msg = CN_COMMAND then
    if FClicksDisabled then Exit;
  inherited WndProc(Message);
end;
{$HINTS ON}
procedure TCustomElGraphicButton.SetUseArrow(newValue : Boolean);
begin
  if (FUseArrow <> newValue) then
  begin
    FUseArrow := newValue;
    Invalidate;
  end; { if }
end; { SetUseArrow }

procedure TCustomElGraphicButton.SetShowGlyph(newValue: Boolean);
begin
  if (FShowGlyph <> newValue) then
  begin
    FShowGlyph := newValue;
    Invalidate;
  end; { if }
end; { SetShowGlyph }

procedure TCustomElGraphicButton.SetShowText(newValue : Boolean);
begin
  if (FShowText <> newValue) then
  begin
    FShowText := newValue;
    Invalidate;
  end; { if }
end; { SetShowText }

procedure TCustomElGraphicButton.SetPullDownMenu(newValue : TPopupMenu);
begin
  if (FPullDownMenu <> newValue) then
  begin
    {$ifdef VCL_5_USED}
    if (FPullDownMenu <> nil) and (not (csDestroying in FPullDownMenu.ComponentState)) then
      FPulldownMenu.RemoveFreeNotification(Self);
    {$endif}
    FPullDownMenu := newValue;
    if FPullDownMenu = nil then
      FDisableAp := true
    else
    begin
      FDisableAp := false;
      FPulldownMenu.FreeNotification(Self);
    end;
  end; { if }
end; { SetPullDownMenu }

function TCustomElGraphicButton.GetIcon : TIcon;
begin
  result := FGlyph.Icon;
end;

procedure TCustomElGraphicButton.SetIcon(newValue : TIcon);
begin
  FGlyph.Icon.Assign(newValue);
end;

procedure TCustomElGraphicButton.SetIsSwitch(newValue : Boolean);
begin
  if (FIsSwitch <> newValue) then
    FIsSwitch := newValue;
end;

{$IFDEF USE_SOUND_MAP}
procedure TCustomElGraphicButton.SetSoundMap(newValue : TElSoundMap);
begin
  if (FSoundMap <> newValue) then
  begin
    {$ifdef VCL_5_USED}
    if FSoundMap <> nil then
      FSoundMap.RemoveFreeNotification(Self);
    {$endif}
    FSoundMap := newValue;
    {$ifdef VCL_5_USED}
    if FSoundMap <> nil then
      FSoundMap.FreeNotification(Self);
    {$endif}
  end;
end; { SetSoundMap }
{$ENDIF}

procedure TCustomElGraphicButton.Notification(AComponent : TComponent; operation : TOperation);
begin
  inherited Notification(AComponent, operation);
  if (operation = opRemove) then
  begin
{$IFDEF USE_SOUND_MAP}
    if (AComponent = FSoundMap) then SoundMap := nil;
{$ENDIF}
    if (AComponent = FImageList) then Images := nil;
    if (AComponent = FAlphaImageList) then AlphaForImages := nil;
    if (AComponent = FAlphaHotImages) then AlphaForHotImages := nil;
    if (AComponent = FAlphaDownImages) then AlphaForDownImages := nil;
    if (AComponent = FAlphaDisabledImages) then AlphaForDisabledImages := nil;
    if (AComponent = FHotImages) then HotImages := nil;
    if (AComponent = FDownImages) then DownImages := nil;
    if (AComponent = FDisabledImages) then DisabledImages := nil;
    if AComponent = FPullDownMenu then PullDownMenu :=nil;
    {$ifdef HAS_HTML_RENDER}
    if AComponent = LinkPopupMenu then
      LinkPopupMenu := nil;
    {$endif}
    {$ifdef ELPACK_USE_IMAGEFORM}
    if AComponent = FImgForm then ImageForm := nil;
    {$endif}
  end; { if }
{$ifdef ELPACK_USE_STYLEMANAGER}
  if (Operation = opRemove) and (AComponent = FStyleManager) then
     StyleManager := nil;
{$ENDIF}
end; { Notification }

function TCustomElGraphicButton.GetImageIndex : integer;
begin
  result := THackGlyph(FGlyph).FImageIndex;
end;

procedure TCustomElGraphicButton.SetImageIndex(newValue : Integer);
begin
  if (THackGlyph(FGlyph).FImageIndex <> newValue) then
  begin
    THackGlyph(FGlyph).ImageIndex := newValue;
    if THackGlyph(FGlyph).UseImageList then Invalidate;
  end; {if}
end;

procedure TCustomElGraphicButton.SetImageList(newValue : TImageList);
var b : boolean;
begin
  if FImageList <> newValue then
  begin
    b := FImageList = nil;
    if not b then
    begin
      {$ifdef VCL_5_USED}
      if (not (csDestroying in FImageList.ComponentState)) then
        FImageList.RemoveFreeNotification(Self);
      {$endif}
      FImageList.UnregisterChanges(FChLink);
    end;
    FImageList := newValue;
    if FImageList <> nil then
    begin
      FImageList.RegisterChanges(FChLink);
      FImageList.FreeNotification(Self);
    end;
    THackGlyph(FGlyph).ImageList := newValue;
    if FImageList = nil then
      UseImageList := false
    else
    if b and (not (csLoading in ComponentState)) then
      UseImageList := true;
    Invalidate;
  end;
end;

procedure TCustomElGraphicButton.SetAlphaImageList(newValue : TImageList);
var b : boolean;
begin
  if FAlphaImageList <> newValue then
  begin
    b := FAlphaImageList = nil;
    if not b then
    begin
      {$ifdef VCL_5_USED}
      if (not (csDestroying in FAlphaImageList.ComponentState)) then
        FAlphaImageList.RemoveFreeNotification(Self);
      {$endif}
      FAlphaImageList.UnregisterChanges(FAChLink);
    end;
    FAlphaImageList := newValue;
    if FAlphaImageList <> nil then
    begin
      FAlphaImageList.RegisterChanges(FAChLink);
      FAlphaImageList.FreeNotification(Self);
    end;
    THackGlyph(FGlyph).AlphaImageList := newValue;
{
    if FImageList = nil then
      UseImageList := false
    else
    if b and (not (csLoading in ComponentState)) then
      UseImageList := true;
}
    Invalidate;
  end;
end;

procedure TCustomElGraphicButton.SetUseIcon(newValue : Boolean);
begin
  if (FUseIcon <> newValue) then
  begin
    FUseIcon := newValue;
    FGlyph.UseIcon := newValue;
    if not UseImageList then Invalidate;
  end; { if }
end; { SetUseIcon }

function TCustomElGraphicButton.GetUseImageList : boolean;
begin
  result := FUseImageList;
end;

procedure TCustomElGraphicButton.SetUseImageList(newValue : Boolean);
begin
  if (UseImageList <> newValue) then
  begin
    FUseImageList := newValue;
    if not (csLoading in ComponentState) then
    begin
      THackGlyph(FGlyph).UseImageList := newValue;
      Invalidate;
    end;
  end; { if }
end; { SetUseImageList }

procedure TCustomElGraphicButton.SetOldStyled(newValue : Boolean);
{ Sets data member FOldStyled to newValue. }
begin
  if (FOldStyled <> newValue) then
  begin
    if not (newValue and Flat) then
    begin
      FOldStyled := newValue;
      Repaint;
    end;
  end; { if }
end; { SetOldStyled }

procedure TCustomElGraphicButton.ImagesChanged(Sender : TObject);
begin
  if FUseImageList then
  begin
    if (FMouseInControl and Enabled) and (Sender = Images) then Invalidate else
    if (not Enabled) and (Sender = DisabledImages) then Invalidate else
    if ((FDown and FIsSwitch) or (FState in [ebsDown, ebsExclusive])) and (Sender = DownImages) then Invalidate else
    if Sender = FImageList then Invalidate;
  end else
  begin
    if (Sender = FBackGround) or
         ((Sender = FDownBackground) and (FDown and FIsSwitch) or
         (FState in [ebsDown, ebsExclusive]))  then Invalidate;
  end;
end;

procedure TCustomElGraphicButton.SetDownImages(newValue : TImageList);
begin
  if (FDownImages <> newValue) then
  begin
    if FDownImages <> nil then
    begin
      {$ifdef VCL_5_USED}
      if (not (csDestroying in FDownImages.ComponentState)) then
        FDownImages.RemoveFreeNotification(Self);
      {$endif}
      FDownImages.UnregisterChanges(FNChLink);
    end;
    FDownImages := newValue;
    if FDownImages <> nil then FDownImages.FreeNotification(Self);
    if FDownImages <> nil then FDownImages.RegisterChanges(FNChLink);
    if ((FDown and FIsSwitch) or (FState in [ebsDown, ebsExclusive])) then
    begin
      if newValue = nil then
        THackGlyph(FGlyph).ImageList := FImageList
      else
        THackGlyph(FGlyph).ImageList := newValue;
      Invalidate;
    end;
  end;  { if }
end;

procedure TCustomElGraphicButton.SetAlphaDownImages(newValue : TImageList);
begin
  if (FAlphaDownImages <> newValue) then
  begin
    if FAlphaDownImages <> nil then
    begin
      {$ifdef VCL_5_USED}
      if (not (csDestroying in FAlphaDownImages.ComponentState)) then
        FAlphaDownImages.RemoveFreeNotification(Self);
      {$endif}
      FAlphaDownImages.UnregisterChanges(FANChLink);
    end;
    FAlphaDownImages := newValue;
    if FAlphaDownImages <> nil then FAlphaDownImages.RegisterChanges(FANChLink);
    if ((FDown and FIsSwitch) or (FState in [ebsDown, ebsExclusive])) then
    begin
      if newValue = nil then
        THackGlyph(FGlyph).AlphaImageList := FAlphaImageList
      else
        THackGlyph(FGlyph).AlphaImageList := newValue;

      Invalidate;
    end;
    if FAlphaDownImages <> nil then FAlphaDownImages.FreeNotification(Self);
  end;  { if }
end;

procedure TCustomElGraphicButton.SetHotImages(newValue : TImageList);
begin
  if (FHotImages <> newValue) then
  begin
    if FHotImages <> nil then
    begin
      {$ifdef VCL_5_USED}
      if (not (csDestroying in FHotImages.ComponentState)) then
        FHotImages.RemoveFreeNotification(Self);
      {$endif}
      FHotImages.UnregisterChanges(FHChLink);
    end;
    FHotImages := newValue;
    if FHotImages <> nil then
    begin
      FHotImages.RegisterChanges(FHChLink);
      FHotImages.FreeNotification(Self);
    end;
    if FMouseInControl then
    begin
      if newValue = nil then THackGlyph(FGlyph).ImageList := FImageList else THackGlyph(FGlyph).ImageList := newValue;
      Invalidate;
    end;
  end;  { if }
end;  { SetHotImages }

procedure TCustomElGraphicButton.SetAlphaHotImages(newValue : TImageList);
begin
  if (FAlphaHotImages <> newValue) then
  begin
    if FAlphaHotImages <> nil then
    begin
      {$ifdef VCL_5_USED}
      if (not (csDestroying in FAlphaHotImages.ComponentState)) then
        FAlphaHotImages.RemoveFreeNotification(Self);
      {$endif}
      FAlphaHotImages.UnregisterChanges(FAHChLink);
    end;
    FAlphaHotImages := newValue;
    if FAlphaHotImages <> nil then
    begin
      FAlphaHotImages.RegisterChanges(FAHChLink);
      FAlphaHotImages.FreeNotification(Self);
    end;
    if FMouseInControl then
    begin
      if newValue = nil then
        THackGlyph(FGlyph).AlphaImageList := FAlphaImageList
      else
        THackGlyph(FGlyph).AlphaImageList := newValue;
      Invalidate;
    end;
  end;  { if }
end;  { SetAlphaHotImages }

procedure TCustomElGraphicButton.SetDisabledImages(newValue : TImageList);
begin
  if (FDisabledImages <> newValue) then
  begin
    if FDisabledImages <> nil then
    begin
      {$ifdef VCL_5_USED}
      if (not (csDestroying in FDisabledImages.ComponentState)) then
        FDisabledImages.RemoveFreeNotification(Self);
      {$endif}
      FDisabledImages.UnregisterChanges(FDChLink);
    end;
    FDisabledImages := newValue;
    if FDisabledImages <> nil then
    begin
      FDisabledImages.RegisterChanges(FDChLink);
      FDisabledImages.FreeNotification(Self);
    end;
    if not Enabled then
    begin
      if newValue <> nil then
        THackGlyph(FGlyph).ImageList := newValue
      else
        THackGlyph(FGlyph).ImageList := FImageList;
      Invalidate;
    end;
  end;  { if }
end;  { SetDisabledImages }

procedure TCustomElGraphicButton.SetAlphaDisabledImages(newValue : TImageList);
begin
  if (FAlphaDisabledImages <> newValue) then
  begin
    if FAlphaDisabledImages <> nil then
    begin
      {$ifdef VCL_5_USED}
      if (not (csDestroying in FAlphaDisabledImages.ComponentState)) then
        FAlphaDisabledImages.RemoveFreeNotification(Self);
      {$endif}
      FAlphaDisabledImages.UnregisterChanges(FADChLink);
    end;
    FAlphaDisabledImages := newValue;
    if FAlphaDisabledImages <> nil then
    begin
      FAlphaDisabledImages.RegisterChanges(FADChLink);
      FAlphaDisabledImages.FreeNotification(Self);
    end;
    if not Enabled then
    begin
      if newValue <> nil then
        THackGlyph(FGlyph).AlphaImageList := newValue
      else
        THackGlyph(FGlyph).AlphaImageList := FAlphaImageList;
      Invalidate;
    end;
  end;  { if }
end;  { SetAlphaDisabledImages }

{$IFDEF VCL_4_USED}

function TCustomElGraphicButton.GetActionLinkClass : TControlActionLinkClass;
begin
  result := TElGraphicButtonActionLink;
end;

procedure TCustomElGraphicButton.ActionChange(Sender : TObject; CheckDefaults : Boolean);
begin
  inherited ActionChange(Sender, CheckDefaults);
  if Sender is TCustomAction then
  begin
    with TCustomAction(Sender) do
    begin
      if not CheckDefaults or (Self.Checked = False) then
        Self.Checked := Checked;
    end;
    if Sender is TAction then
    begin
      Enabled := TAction(Sender).Enabled;
      Visible := TAction(Sender).Visible;
      Hint := TAction(Sender).Hint;
      Caption := TAction(Sender).Caption;
      ImageIndex := TAction(Sender).ImageIndex;
      Down := TAction(Sender).Checked;
    end;
  end;
end;
{$ENDIF}

procedure TCustomElGraphicButton.SetThinFrame(newValue : Boolean);
{ Sets data member FThinFrame to newValue. }
begin
  if (FThinFrame <> newValue) then
  begin
    FThinFrame := newValue;
    if newValue then FOldStyled := false;
    if OldStyled or (FMouseInControl and (not (FState in [ebsDown, ebsExclusive]))) then Invalidate;
  end;  { if }
end;  { SetThinFrame }

procedure TCustomElGraphicButton.SetShadowsUseCustom(Value : Boolean);
begin
  if Value <> FShadowsUseCustom then
  begin
    FShadowsUseCustom := Value;
    Invalidate;
  end;
end;

procedure TCustomElGraphicButton.SetShadowBtnHighlight(Value : TColor);
begin
  if Value <> FShadowBtnHighlight then
  begin
    FShadowBtnHighlight := Value;
    if FShadowsUseCustom then Invalidate;
  end;
end;

procedure TCustomElGraphicButton.SetShadowBtnShadow(Value : TColor);
begin
  if Value <> FShadowBtnShadow then
  begin
    FShadowBtnShadow := Value;
    if FShadowsUseCustom then Invalidate;
  end;
end;

procedure TCustomElGraphicButton.SetShadowBtnDkShadow(Value : TColor);
begin
  if Value <> FShadowBtnDkShadow then
  begin
    FShadowBtnDkShadow := Value;
    if FShadowsUseCustom then Invalidate;
  end;
end;

procedure TCustomElGraphicButton.SetShadowFollowsColor(Value : Boolean);
begin
  if Value <> FShadowFollowsColor then
  begin
    FShadowFollowsColor := Value;
    Invalidate;
  end;
end;

procedure TCustomElGraphicButton.SetBackgroundDrawBorder(Value : boolean);
begin
  if Value <> FBackgroundDrawBorder then
  begin
    FBackgroundDrawBorder := Value;
    if not FBackground.Empty then Invalidate;
  end;
end;

procedure TCustomElGraphicButton.SetDownBackground(newValue : TBitmap);
{ Sets data member FDownBackground to newValue. }
begin
  FDownBackground.Assign(newValue);
end;  { SetDownBackground }

procedure TCustomElGraphicButton.SetBackground(newValue : TBitmap);
{ Sets data member FBackground to newValue. }
begin
  FBackground.Assign(newValue);
end;  { SetBackground }

procedure TCustomElGraphicButton.SetTextDrawType(newValue : TElTextDrawType);
begin
  if (FTextDrawType <> newValue) then
  begin
    FTextDrawType := newValue;
    Invalidate;
  end; { if }
end; { SetTextDrawType }

procedure TCustomElGraphicButton.SetTransparent(newValue : Boolean);
var R : TRect;
begin
  if (FTransparent <> newValue) then
  begin
    FTransparent := newValue;
    if FTransparent then
    begin
      ControlStyle := ControlStyle - [csOpaque];
      R := Rect(Left, Top, Left + Width, Top + Height);
      if (Parent <> nil) and Parent.HandleAllocated then
        InvalidateRect(Parent.Handle, @R, false);
      Invalidate;
    end
    else
    begin
      ControlStyle := ControlStyle + [csOpaque];
      Invalidate;
    end;
  end; { if }
end; { SetTransparent }

constructor TCustomElGraphicButton.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
{$IFNDEF VER90}
  ControlStyle := [csReflector, csSetCaption, csCaptureMouse, csDoubleClicks];
{$ELSE}
  ControlStyle := [csSetCaption, csCaptureMouse, csDoubleClicks];
{$ENDIF}
  Width := 75;
  Height := 25;

  FAlignment := taCenter;
  FChangeDisabledText := true;
  FMultiLine := False;
  FGlyph := TElButtonGlyph.Create;
  FGlyph.OnChange := GlyphChanged;
  FFlat := false;
  FSpacing := 4;
  FMargin := -1;
  FLayout := blGlyphLeft;
  Inc(ButtonCount);
  FUseArrow := False;
  FShowText := true;
  FShowGlyph := true;
  THackGlyph(FGlyph).FImageIndex := -1;
  PInteger(@Color)^ := clBtnFace;
  PInteger(@Font.Color)^ := clBtnText;
  FAChLink  := TChangeLink.Create; FAChLink.OnChange := ImagesChanged;
  FChLink  := TChangeLink.Create; FChLink.OnChange := ImagesChanged;
  FDChLink := TChangeLink.Create; FDChLink.OnChange := ImagesChanged;
  FADChLink := TChangeLink.Create; FADChLink.OnChange := ImagesChanged;
  FHChLink := TChangeLink.Create; FHChLink.OnChange := ImagesChanged;
  FAHChLink := TChangeLink.Create; FAHChLink.OnChange := ImagesChanged;
  FNChLink := TChangeLink.Create; FNChLink.OnChange := ImagesChanged;
  FANChLink := TChangeLink.Create; FANChLink.OnChange := ImagesChanged;
  FBackground := TBitmap.Create;
  FDownBackground := TBitmap.Create;
  FShadowFollowsColor := true;
  MenuWindowProc := WndProc;
  {$warnings off}
  FWnd := AllocateHWND(IntWndProc);
  {$warnings on}
  {$ifdef ELPACK_USE_IMAGEFORM}
  FImgFormChLink  := TImgFormChangeLink.Create;
  FImgFormChLink.OnChange := ImageFormChange;
  {$endif}
  FShowBorder := true;
  FAdjustSpaceForGlyph := true;
  {$ifdef MSWINDOWS}
  UseXPThemes := true;
  {$endif}
  {$ifdef HAS_HTML_RENDER}
  FLinkStyle := [fsUnderline];
  FLinkColor := clBlue;
  {$endif}
{$IFDEF ELPACK_USE_STYLEMANAGER}
  FStyleMgrLink := TElStyleMgrChangeLink.Create;
  FStyleMgrLink.OnChange := StyleMgrChange;
{$ENDIF}
end;

destructor TCustomElGraphicButton.Destroy;
begin
  UseArrow := false;
{$ifdef ELPACK_USE_STYLEMANAGER}
  StyleManager := nil;
  FreeAndNil(FStyleMgrLink);
{$ENDIF}
  {$ifdef ELPACK_USE_IMAGEFORM}
  ImageForm := nil;
  FImgFormChLink.Free;
  {$endif}
  {$warnings off}
  DeallocateHWnd(FWnd);
  {$warnings on}
  FDownBackground.Free;
  FBackground.Free;
  Dec(ButtonCount);
  FChLink.Free;
  FAChLink.Free;
  FDChLink.Free;
  FADChLink.Free;
  FHChLink.Free;
  FAHChLink.Free;
  FNChLink.Free;
  FANChLink.Free;

  (*
  if ButtonCount = 0 then
  begin
    Pattern.Free;
    Pattern := nil;
  end;
  *)
  FGlyph.Free;
  {$ifdef MSWINDOWS}
  UseXPThemes := false;
  {$endif}
  {$ifdef HAS_HTML_RENDER}
  if IsHTML then
    FRender.Free;
  FRender := nil;
  {$endif}
  inherited Destroy;
end;

procedure TCustomElGraphicButton.SetAdjustSpaceForGlyph(Value: Boolean);
begin
  if FAdjustSpaceForGlyph <> Value then
  begin
    FAdjustSpaceForGlyph := Value;
    Invalidate;
  end;
end;

procedure TCustomElGraphicButton.SetCaption(Value: TElFString);
begin
  if FCaption <> Value then
  begin
    inherited Caption := '';
    FCaption := Value;
    inherited Caption := Value;
    (*
    {$ifndef CLX_USED}
    Perform(CM_TEXTCHANGED, 0, 0);
    {$else}
    TextChanged;
    {$endif}
    *)
  end;
end;

{$ifdef ELPACK_USE_IMAGEFORM}
procedure TCustomElGraphicButton.IFMRepaintChildren(var Message: TMessage);
begin
  inherited;
  if (not (csDesigning in ComponentState)) and (ImageForm <> nil) then
    Invalidate;
end;
{$endif}

procedure TCustomElGraphicButton.SetUseXPThemes(const Value: Boolean);
begin
  if FUseXPThemes <> Value then
  begin
    FUseXPThemes := Value;
    if ThemesAvailable then
    begin
      {$ifdef MSWINDOWS}
      if FUseXPThemes then
      begin
        CreateThemeHandle;
      end
      else
      begin
        FreeThemeHandle;
      end;
      {$endif}
      Invalidate;
    end;
  end;
end;

procedure TCustomElGraphicButton.CreateThemeHandle;
begin
  if ThemesAvailable then
  begin
    {$ifdef MSWINDOWS}
    FTheme := OpenThemeData(0, PWideChar(GetThemedClassName()));
    FArrTheme := OpenThemeData(0, PWideChar(GetArrowThemedClassName()));
    {$endif}
  end
  else
  begin
    FTheme := 0;
    FArrTheme := 0;
  end;
end;

procedure TCustomElGraphicButton.FreeThemeHandle;
begin
  if ThemesAvailable then
  begin
    {$ifdef MSWINDOWS}
    CloseThemeData(FTheme);
    CloseThemeData(FArrTheme);
    {$endif}
  end;
  FTheme := 0;
  FArrTheme := 0;
end;


procedure TCustomElGraphicButton.WMIsThemedControl(var Message: TMessage);
begin
  Message.Result := Theme;
end;

procedure TCustomElGraphicButton.ELThemeChanged(var Message: TMessage);
begin
  if ThemesAvailable and UseXPThemes then
  begin
    FreeThemeHandle;
    CreateThemeHandle;
    Invalidate;
  end;
  Message.Result := 1;
end;

function TCustomElGraphicButton.IsThemeApplied: Boolean;
begin
  Result := UseXPThemes and (FTheme <> 0) and (FArrTheme <> 0);
end;

function TCustomElGraphicButton.GetThemePartID: Integer;
begin
  Result := BP_PUSHBUTTON;
end;

function TCustomElGraphicButton.GetThemeStateID: Integer;
begin
  if not Enabled then
    result := PBS_DISABLED
  else
  if (FDown and FIsSwitch) or (FState in [ebsDown, ebsExclusive]) then
    result := PBS_PRESSED
  else
  if FMouseInControl or FMouseInArrow then
    result := PBS_HOT
  else
    result := PBS_NORMAL;
end;

function TCustomElGraphicButton.GetThemedClassName: WideString;
begin
  Result := 'BUTTON';
end;

function TCustomElGraphicButton.GetArrowThemePartID: Integer;
begin
  Result := CP_DROPDOWNBUTTON;
end;

function TCustomElGraphicButton.GetArrowThemeStateID: Integer;
begin
  if not Enabled then
    result := CBXS_DISABLED
  else
  if FState in [ebsArrDown, ebsExclusive] then
    result := CBXS_PRESSED
  else
  if FMouseInControl or FMouseInArrow or Focused then
    result := CBXS_HOT
  else
    result := CBXS_NORMAL;
end;

function TCustomElGraphicButton.GetArrowThemedClassName: WideString;
begin
  Result := 'COMBOBOX';
end;

function TCustomElGraphicButton.GetArrowSize: Integer;
var PS  : TSize;
begin
  {$ifdef MSWINDOWS}
  if FArrTheme <> 0 then
  begin
    GetThemePartSizeTo(PWideChar(GetArrowThemedClassName), Canvas.Handle, GetArrowThemePartID, GetArrowThemeStateID, nil, TS_TRUE, PS);
    result := PS.cx;
  end
  else
  {$endif}
    result := 13;
end;


procedure TCustomElGraphicButton.IntEnabledChanged;
const
  NewState : array[Boolean] of TElButtonState = (ebsDisabled, ebsUp);
begin
  THackGlyph(FGlyph).CreateButtonGlyph(NewState[Enabled]);
  if UseImageList then
  begin
    if (not Enabled) and (FDisabledImages <> nil) then
    begin
       THackGlyph(FGlyph).ImageList := FDisabledImages;
       THackGlyph(FGlyph).AlphaImageList := FAlphaDisabledImages;
    end else
    begin
       THackGlyph(FGlyph).ImageList := FImageList;
       THackGlyph(FGlyph).AlphaImageList := FAlphaImageList;
    end;
  end;
  UpdateTracking;
  Invalidate;
end;

procedure TCustomElGraphicButton.IntMouseEnter;
var P     : TPoint;
    b     : boolean;
begin
  b := false;
  if Enabled then
  begin
    if (not OldStyled) or IsThemeApplied then
      b := true;

    if UseArrow then
    begin
      GetCursorPos(P);
      P := ScreenToClient(P);
      FMouseInArrow := P.X > ClientWidth - GetArrowSize;
      if not FMouseInArrow then
        FMouseInControl := true;
    end
    else
      FMouseInControl := true;

    if UseImageList then
    begin
      if FHotImages <> nil then
      begin
        if THackGlyph(FGlyph).ImageList <> FHotImages then
          b := true;
        THackGlyph(FGlyph).ImageList := FHotImages;
        THackGlyph(FGlyph).AlphaImageList := FAlphaHotImages;
      end
      else
      begin
        if THackGlyph(FGlyph).ImageList <> FImageList then
          b := true;
        THackGlyph(FGlyph).ImageList := FImageList;
        THackGlyph(FGlyph).AlphaImageList := FAlphaImageList;
      end;
    end;
    if b then
    begin
      Invalidate;
    end;
  end;
end;

procedure TCustomElGraphicButton.IntTextChanged;
begin
  if (Pos(#13#10, Caption) > 0)
  {$ifdef HAS_HTML_RENDER}
  and (not IsHTML)
  {$endif}
   then
    FMultiline := true
  else
    FMultiline := false;
  Invalidate;
end;

procedure TCustomElGraphicButton.IntMouseLeave;
var b : boolean;
begin
  b := false;
  if (not OldStyled) or IsThemeApplied then
    b := true;
  if Enabled and (not FDragging) then
  begin
    if UseImageList and (HotImages <> nil) then
    begin
      if THackGlyph(FGlyph).ImageList <> FImageList then
        b := true;
      THackGlyph(FGlyph).ImageList := FImageList;
      THackGlyph(FGlyph).AlphaImageList := FAlphaImageList;
    end;
  end;
  if FMouseInControl or FMouseInArrow then
    b := true;
  FMouseInControl := False;
  FMouseInArrow := false;
  if b then
    Invalidate;
end;

{$ifdef MSWINDOWS}
procedure TCustomElGraphicButton.DrawThemedBackground(Canvas : TCanvas);
begin
  if not Transparent then
  begin
    DrawThemeBackground(Theme, Canvas.Handle, BP_PUSHBUTTON, 0, ClientRect, nil);
  end;
end;
{$endif}


{$ifdef VCL_5_USED}
procedure TCustomElGraphicButton.WMContextMenu(var Message: TWMContextMenu);
var
  Pt, Temp: TPoint;
  Handled: Boolean;
  href : TElFString;
  R    : TRect;
begin
  if csDesigning in ComponentState then Exit;

  {$ifdef HAS_HTML_RENDER}
  Pt := ScreenToClient(SmallPointToPoint(Message.Pos));
  if IsHTML then
  begin
    R := FTextRect;
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

procedure TCustomElGraphicButton.WMRButtonUp(var Message: TWMRButtonUp);
{$ifndef VCL_5_USED}
var P : TPoint;
    R : TRect;
    href : TElFString;
{$endif}
begin
  {$ifndef VCL_5_USED}
  {$ifdef HAS_HTML_RENDER}
  if IsHTML then
  begin
    P := SmallPointToPoint(Message.Pos);
    R := FTextRect;
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
  {$endif}
    inherited;
end;

procedure TCustomElGraphicButton.WMWindowPosChanged(var Message: TMessage);
begin
  inherited;
  (*if Parent <> nil then
  begin
    Windows.SetParent(FWnd, Parent.Handle);
    SetWindowPos(FWnd, HWND_BOTTOM, Left, Top, Width, Height, SWP_HIDEWINDOW);
  end;
  *)
end;


function TCustomElGraphicButton.MeasureButton(LockHeight : boolean): TPoint;
var Aw : integer;
    inR,
    R  : TRect;
    AHeight : integer;

begin
  Canvas.Font.Assign(Font);
  if UseArrow then
  begin
    aw := GetArrowSize;
    {$ifdef MSWINDOWS}
    if IsThemeApplied then
    begin
      r := Rect(0,0,aw, aw);
      GetThemeBackgroundExtent(Theme, Canvas.Handle, GetThemePartID, GetThemeStateID, @R, inR);
      aw := inR.Right - inR.Left;
    end;
    {$endif}
  end
  else
    aw := 0;

  R := Rect(0, 0, Width, Height);
  {$ifdef MSWINDOWS}
  if IsThemeApplied then
  begin
    GetThemeBackgroundContentRect(Theme, Canvas.Handle, GetThemePartID, GetThemeStateID, R, inR);
    if EqualRect(R, inR) then
      InflateRect(inR, -2, -2);
    inR := Rect(0,
                0,
                R.Right - R.Left + (R.Left - InR.Left + InR.Right - R.Right),
                R.Bottom - R.Top + (R.Top - InR.Top + InR.Bottom - R.Bottom));
  end
  else
  {$endif}
  begin
    inR := R;
    dec(inR.Right, 4);
    dec(inR.Bottom, 4);
  end;
  if LockHeight then
    AHeight := inR.Bottom
  else
    AHeight := 0;
  result := Point(
         FGlyph.CalcButtonWidth(Canvas, AHeight, Point(0, 0),
             Caption, Layout, Margin, Spacing,
             ShowGlyph, ShowText, FMultiline, aw,
             {$ifdef MSWINDOWS}false{ParentFont and (FTheme <> 0)},
             FTheme, GetThemePartID, GetThemeStateID{$else}false, 0, 0, 0{$endif}, true
             {$ifdef HAS_HTML_RENDER}, IsHTML, FRender{$endif}),
         0);
  result.y := AHeight + R.Bottom - inR.Bottom;

  inc(result.x, R.Right - inR.Right);
end; { MeasureButton }

function TCustomElGraphicButton.GetMoneyFlat: Boolean;
begin
  Result := FMoneyFlat;
end;

procedure TCustomElGraphicButton.SetMoneyFlat(Value: Boolean);
begin
  if FMoneyFlat <> Value then
  begin
    FMoneyFlat := Value;
    Invalidate;
  end;
end;

procedure TCustomElGraphicButton.SetMoneyFlatDownColor(Value: TColor);
begin
  if FMoneyFlatDownColor <> Value then
  begin
    FMoneyFlatDownColor := Value;
    if MoneyFlat then Invalidate;
  end;
end;

procedure TCustomElGraphicButton.SetMoneyFlatActiveColor(Value: TColor);
begin
  if FMoneyFlatActiveColor <> Value then
  begin
    FMoneyFlatActiveColor := Value;
    if MoneyFlat then Invalidate;
  end;
end;

procedure TCustomElGraphicButton.SetMoneyFlatInactiveColor(Value: TColor);
begin
  if FMoneyFlatInactiveColor <> Value then
  begin
    FMoneyFlatInactiveColor := Value;
    if MoneyFlat then Invalidate;
  end;
end;

function TCustomElGraphicButton.DoSaveShadows : boolean;
begin
  result := ShadowsUseCustom and not (ShadowFollowsColor);
end;

procedure TCustomElGraphicButton.Click;
begin
  AClick(false);
end;


procedure TCustomElGraphicButton.IntWndProc(var Message : TMessage);
begin
  if @WindowProc <> nil then
    WindowProc(Message)
  else
  WndProc(Message);
end;
procedure TCustomElGraphicButton.DoPullMenu;
var
  q : TPoint;
begin
  PullDownMenu.PopupComponent := Self;
  PullDownMenu.AutoPopup := True;
  q.X := 0;
  q.Y := 0;
  q := ClientToScreen(q);

  if FPopupPlace = ppRight then
  begin
    q.x := q.X + Width;
    q.y := q.Y - 1;
  end else
  if FPopupPlace = ppDown then
  begin
    q.x := q.X - 1;
    q.y := q.Y + height;
  end
  else
  begin
    q.x := q.x - 1;
    q.y := q.y - GetSystemMetrics(SM_CYMENU) * PullDownMenu.Items.Count;
    //PullDownMenu.Popup(q.X - 1, q.Y - GetSystemMetrics(SM_CYMENU) * PullDownMenu.Items.Count);
  end;
  if q.x < 0 then q.x := 0;
  if q.y < 0 then q.y := 0;
  PullDownMenu.PopupComponent := Self;
  if not FUseArrow then
  begin
    FState := ebsDown;
    FOrigState := ebsDown;
    Invalidate;
  end;
  FInMenu := true;
  if Assigned(PullDownMenu.OnPopup) then
    PullDownMenu.OnPopup(PullDownMenu);
  TrackPopupMenu(GetMenuHandle(PullDownMenu), TPM_LEFTALIGN or TPM_LEFTBUTTON or TPM_RIGHTBUTTON, q.X, q.Y, 0, FWND, nil);
  FState := ebsUp;
end;

procedure TCustomElGraphicButton.SetShortcutsEnabled(Value: Boolean);
begin
  if FShortcutsEnabled <> Value then
  begin
    FShortcutsEnabled := Value;
    Invalidate;
  end;
end;

function TCustomElGraphicButton.Focused: Boolean;
begin
  Result := false;
end;

{$ifdef HAS_HTML_RENDER}
procedure TCustomElGraphicButton.SetIsHTML(Value: Boolean);
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
    Invalidate;
  end;
end;

procedure TCustomElGraphicButton.SetLinkColor(newValue : TColor);
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

procedure TCustomElGraphicButton.SetLinkPopupMenu(newValue : TPopupMenu);
begin
  if (FLinkPopupMenu <> newValue) then
  begin
    {$ifdef VCL_5_USED}
    if (FLinkPopupMenu <> nil) and (not (csDestroying in FLinkPopupMenu.ComponentState)) then
      FLinkPopupMenu.RemoveFreeNotification(Self);
    {$endif}
    FLinkPopupMenu := newValue;
    if (newValue <> nil) then
       newValue.FreeNotification(Self);
  end;  { if }
end;  { SetLinkPopupMenu }

procedure TCustomElGraphicButton.SetLinkStyle(newValue : TFontStyles);
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

procedure TCustomElGraphicButton.DoLinkPopup(MousePos : TPoint);
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

procedure TCustomElGraphicButton.TriggerImageNeededEvent(Sender : TObject; Src :
    TElFString; var Image : TBitmap);
begin
  Image := nil;
  if (assigned(FOnImageNeeded)) then
      FOnImageNeeded(Self, Src, Image);
end;  { TriggerImageNeededEvent }

procedure TCustomElGraphicButton.TriggerLinkClickEvent(HRef : TElFString);
begin
  if (assigned(FOnLinkClick)) then
    FOnLinkClick(Self, HRef );
end;  { TriggerLinkClickEvent }
{$endif}

procedure TCustomElGraphicButton.SetImageIsAlphaBlended(Value: Boolean);
begin
  if FImageIsAlphaBlended <> Value then
  begin
    FImageIsAlphaBlended := Value;
//    Invalidate;
  end;
end;

{$ifdef ELPACK_UNICODE}
procedure TCustomElGraphicButton.CMHintShow(var Message: TMessage);
var T: WideChar;
  HintInfo : PHintInfo;
  l : integer;
  S : String;
  WS : WideString;

  function AddShortcutToHint(WS : WideString) : WideString;
  begin
    if (WS <> '') and (ActionLink.Action is TCustomAction) and (TCustomAction(ActionLink.Action).ShortCut <> scNone) then
    begin
      result := WS + ' (' + ShortCutToText(TCustomAction(ActionLink.Action).ShortCut) + ')';
    end
    else
      result := WS;
  end;

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
    {$ifdef VCL_4_USED}
    if Application.HintShortCuts and (ActionLink <> nil) then
      WS := AddShortcutToHint(WS);
    {$endif}
  end
  else
  begin
    {$ifdef VCL_4_USED}
    if Application.HintShortCuts and (ActionLink <> nil) then
      WS := AddShortcutToHint(FHint)
    else
    {$endif}
      WS := FHint;

    S := FHint;
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

procedure TCustomElGraphicButton.SetHint(Value: TElFString);
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

{$ifdef HAS_HTML_RENDER}
procedure TCustomElGraphicButton.SetCursor(Value: TCursor);
var P : TPoint;
    R : TRect;
    href : TElFString;
begin
  if (FCursor <> Value) then
  begin
    FCursor := Value;
    {$IFDEF HAS_HTML_RENDER}
    if IsHTML then
    begin
      GetCursorPos(P);
      P := ScreenToClient(P);
      R := FTextRect;
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
{$endif}

procedure TCustomElGraphicButton.SetChangeDisabledText(Value: Boolean);
begin
  if FChangeDisabledText <> Value then
  begin
    FChangeDisabledText := Value;
    if FState = ebsDisabled then
      Invalidate;
  end;
end;

procedure TCustomElGraphicButton.SetAlignment(Value: TAlignment);
begin
  if FAlignment <> Value then
  begin
    FAlignment := Value;
    Invalidate;
  end;
end;

procedure TCustomElGraphicButton.ButtonClick;
var
  First, Last: Integer;
begin
  if not FDown then
  begin
    FState := ebsDown;
    Repaint;
  end;
  First := GetTickCount;
  repeat
    Last := GetTickCount;
  until ((Last - First) >= 25) or (Last < First);
  FState := ebsUp;
  if GroupIndex = 0 then
  begin
    Click;
    Repaint;
  end
  else
  begin
    Down := not Down;
    Click;
  end;
end;


{$ifdef ELPACK_USE_STYLEMANAGER}
procedure TCustomElGraphicButton.SetStyleManager(Value: TElStyleManager);
begin
  if FStyleManager <> Value then
  begin
    {$ifdef VCL_5_USED}
    if (FStyleManager <> nil) and (not (csDestroying in FStyleManager.ComponentState)) then
      FStyleManager.RemoveFreeNotification(Self);
    {$endif}
    if (FStyleManager <> nil) and (not (csDestroying in FStyleManager.ComponentState)) then
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

procedure TCustomElGraphicButton.SetStyleName(const Value: string);
begin
  if FStyleName <> Value then
  begin
    FStyleName := Value;
    UpdateStyle;
  end;
end;

procedure TCustomElGraphicButton.StyleMgrChange(Sender : TObject);
begin
  UpdateStyle;
end;

procedure TCustomElGraphicButton.UpdateStyle;
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
{$endif}


function TCustomElGraphicButton.GetShowGlyph: Boolean;
begin
  Result := FShowGlyph;
end;

{$IFDEF VCL_4_USED}
procedure TElGraphicButtonActionLink.SetImageIndex(Value: Integer);
begin
  if FClient is TCustomElGraphicButton then
  begin
    TCustomElGraphicButton(FClient).ImageIndex := value;
  end;
end;

procedure TElGraphicButtonActionLink.AssignClient(AClient : TObject);
begin
  inherited AssignClient(AClient);
  FClient := AClient as TCustomElGraphicButton;
end;

function TElGraphicButtonActionLink.IsCheckedLinked : Boolean;
begin
  Result := inherited IsCheckedLinked and
    (FClient.Checked = (Action as TCustomAction).Checked);
end;

function TElGraphicButtonActionLink.IsImageIndexLinked : Boolean;
begin
  result := true;
end;

procedure TElGraphicButtonActionLink.SetChecked(Value : Boolean);
begin
  if IsCheckedLinked then
  begin
    FClient.ClicksDisabled := True;
    try
      FClient.Checked := Value;
    finally
      FClient.ClicksDisabled := False;
    end;
  end;
end;

procedure TElGraphicButtonActionLink.SetCaption(const Value: string);
begin
  if IsCaptionLinked then
    FClient.Caption := Value;
  inherited;
end;

procedure TElGraphicButtonActionLink.SetHint;
begin
  if IsHintLinked then
    FClient.Hint := Value;
  inherited;
end;

function TElGraphicButtonActionLink.IsCaptionLinked : Boolean;
begin
  result := false;
  if FClient is TCustomElGraphicButton then
    Result := TCustomElGraphicButton(FClient).Caption = (Action as TCustomAction).Caption;
end;

function TElGraphicButtonActionLink.IsHintLinked: Boolean;
begin
  result := false;
  if FClient is TCustomElGraphicButton then
    Result := TCustomElGraphicButton(FClient).Hint = StrPas(PChar((Action as TCustomAction).Hint));
end;

{$ENDIF}

initialization

  MenuCancelMsg := RegisterWindowMessage('El - Cancel pulldown menu');
  FArrow := TBitmap.Create;
  FArrow.LoadFromResourceName(HInstance, 'ELPOPUPBUTTONDOWNARROW');

finalization

  FArrow.Free;

end.
