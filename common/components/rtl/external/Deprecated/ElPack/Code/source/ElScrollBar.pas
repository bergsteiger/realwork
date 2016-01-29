{====================================================}
{                                                    }
{   EldoS Visual Components                          }
{                                                    }
{   Copyright (c) 1998-2003, EldoS Corporation       }
{   Portions Copyright (c) 2001, Akzhan Abdulin      }
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

06/17/2003

  OnChange was fired twice in some cases. Fixed.

03/28/2003

  Theme change didn't cause update of scrollbar size. Fixed.

01/12/2003

  Now timered change of the value causes OnChange event to be triggered

07/02/2002

  Fixed the problem with incorrect keyboard handling

06/20/2002

  The value of Min property different from 0 caused incorrect positioning of the thumb. Fixed.

04/25/2002

  Fixed the bug with setting width of the scrollbar with UseSystemMetrics
  set to true and themes enabled

04/23/2002

  Fixed the problem with Width/UseSystemMetrics loading order.

03/06/2002

  Added unicode hint
  Added Step property

02/26/2202

  Fixed background painting for horizontal scorllbar in cases, when thumb is not visible

02/16/2002

  Optimized resource usage on Win9x

02/03/2002

  Fixed scroll hint text displaying in Unicode mode (was broken in update 7)

10/16/2001

  Disabled scrollbars had incorrect background in Windows XP with styles enabled. Fixed.

10/15/2001

  Improved scrollbar system size detection in Windows XP with styles enabled

09/22/2001

  In non-flat mode arrow colors where drawn with HotTrackColor. Fixed.

09/17/2001 (c) Akzhan Abdulin

  Windows XP Themes Support remade using TElXPThemedControl.

  Mouse hot tracking now works for themed control not only in flat mode.

09/14/2001 (c) Akzhan Abdulin

  Bug fixed when user uses secondary buttons in Page mode and tries
  to look at end of scrollbar and reverse to begin (PageUp button was disabled).

  Added Windows XP Themes Support. UseXPThemes property added.
  Note that themed scrollbar will ignore some its look'n'feel properties.
  Note that themed arrow buttons will not fire OnDrawPart event.

  Developer note: Gripper on thumb button drawn always when ShowBars is true
  because GetThemePartSize doesn't work for gripper (under research).

09/10/2001

  Added WM_MOUSEWHEEL processing

08/01/2001

  Added OnHitTest event, that simplifies implementation of owner-drawn scrollbars.

07/26/2001

  Added Unicode support

05/27/2001 (c) Akzhan Abdulin

    Fixed Color property design-time storing issue (clWindow didn't stored)

    Fixed SystemBkColor property setter (always didn't changed)

    DrawArrowFrames, DrawBars, BarOffset and BarColor properties added (inspired by Windows XP)
    Note: try to setup all by default except: Color to clWindow, MinThumbSize to 23 and DrawArrowFrames to false

    Painting was slightly restructured using subroutines

04/28/2001

    Fixed design-time settings being loaded for UseSystemMetrics-related properties

03/01/2001

    Now background color is drawn in the same way as for system scrollbar

    Now scrollbar behaves more like standard scrollbar

02/10/2001

    Added HintColor and HintTextColor properties

10/10/2000

    Colors adjusted to be the same as standard scrollbars

10/05/2000

    Added following properties:

    ImageForm  - pseudo-transparency support
    ArrowColor -  defines the color of the arrow
    ArrowHotTrackColor - defines the color of the arrow when cursor is over
                         the button
    ShowBorder - enables or disables buttons and thumb frames (border)
    ThinFrame - enables or disables thin buttons and thumb frames (border)

07/09/2000

    OnMouse* events published.

*)

unit ElScrollBar; { TElScrollBar component. }

{ ScrollBar replacement component }

interface

uses
  SysUtils,
  Windows,
  Messages,
  Graphics,
  Controls,
  Forms,
  ExtCtrls,
  StdCtrls,
{$ifdef VCL_6_USED}
Types,
{$endif}
  ElTmSchema,
  ElUxTheme,
  ElXPThemedControl,
  Classes,
  ElTools,
  ElVCLUtils,
  ElStrUtils,
{$ifdef ELPACK_UNICODE}
  ElUnicodeStrings,
{$endif}
{$IFDEF ELPACK_USE_IMAGEFORM}
  ElImgFrm,
{$ENDIF}
{$IFDEF HAS_HTML_RENDER}
  HTMLRender,
{$ENDIF}
  ElHintWnd,
  ElSBCtrl
  ;


type
(*
  TElScrollHintNeededEvent = procedure(Sender : TObject; TrackPosition : integer; var Hint : TElFString) of object;

  TElScrollBarPart = (sbpNowhere,
    sbpLeftArrow, sbpRightSndArrow {actually pointing to the left},
    sbpRightArrow, sbpLeftSndArrow {actually pointing to the right},
    sbpThumb, sbpLeftTop, sbpRightBottom);

  TElScrollHitTestEvent = procedure(Sender : TObject; X, Y : integer; var Part : TElScrollBarPart; var DefaultTest : boolean) of object;
  TElScrollDrawPartEvent = procedure(Sender : TObject; Canvas : TCanvas; R : TRect; Part : TElScrollBarPart; Enabled, Focused, Pressed : boolean; var DefaultDraw : boolean) of object;

  TElScrollCode = (escLineUp, escLineDown, escPageUp, escPageDown, escPosition, escTrack, escTop, escBottom, escEndScroll, escSndLineUp, escSndLineDown);

  TElScrollEvent = procedure(Sender : TObject; ScrollCode : TElScrollCode; var ScrollPos : integer; var DoChange : boolean) of object;

  TElSecButtonsKind = (sbkOpposite, sbkPage, sbkCustom);
  TElScrollThumbMode = (etmFixed, etmAuto);
*)

  TCustomElScrollBar = class(TElXPThemedControl)
  protected
    FThinFrame: Boolean;
    FShowBorder: Boolean;
    FDrawArrowFrames: Boolean;
    FDrawBars: Boolean;
    FBarOffset: Cardinal;
    FBarColor: TColor;
    FArrowColor: TColor;
    FArrowHotTrackColor: TColor;
{$IFDEF ELPACK_USE_IMAGEFORM}
    FImgFormChLink: TImgFormChangeLink;
    FImgForm: TElImageForm;
{$ENDIF}
    FUseSystemMetrics: boolean;
    FNoSunkenThumb: Boolean;
    FShowLeftArrows: Boolean;
    FShowRightArrows: Boolean;
    FChangeColorsOnScroll: Boolean;
    FBitmapOwner : boolean;
    FBlendBackground: boolean;
    FShowTrackHint: Boolean;
    FNoDisableButtons: Boolean;
    FOwnerDraw: Boolean;

    FSecondaryButtons: Boolean;
    FSecondBtnKind: TElSecButtonsKind;
    FPage: Integer;
    FMinThumbSize: Integer;
    FThumbMode: TElScrollThumbMode;
    FThumbSize: Integer;
    FButtonSize: Integer;
    FKind: TScrollBarKind;
    FPosition: Integer;
    FMax: Integer;
    FMin: Integer;
    FFlat: Boolean;
    FActiveFlat: Boolean;
    FMouseInControl: boolean;
{$IFDEF HAS_HTML_RENDER}
    FIsHTML: boolean;
{$ENDIF}
    FOnChange: TNotifyEvent;
    FOnScroll: TElScrollEvent;
    FOnDrawPart: TElScrollDrawPartEvent;
    FOnScrollHintNeeded: TElScrollHintNeededEvent;
{$IFNDEF VCL_4_USED}
    FOnResize: TNotifyEvent;
{$ENDIF}

    FScrollTimer: TTimer;
    FThumbOffset,
      FOrigPos,
      FOrigCoord: integer;
    FSaveCapture: HWND;
    FTrackPos,
    FThumbPos   : integer;

    FPressedIn,
    FOrigPressedIn,
    FMouseOver: TElScrollBarPart;
    FHintWnd: TElHintWindow;
    FPressedPos: TPoint;
    FPressed: boolean;
    FTracking : boolean;
    FNoScrollMessages: boolean;
    FAltDisablingArrows: Boolean;
    FOnHitTest: TElScrollHitTestEvent;
    FHintColor: TColor;
    FHintTextColor: TColor;
    {$ifdef ELPACK_UNICODE}
    FHint: TElFString;
    {$endif}
    FSysBkColor: boolean;
    FStep: Integer;

    procedure SetKind(newValue: TScrollBarKind);

    procedure SetPosition(newValue: Integer);
    procedure SetMax(newValue: Integer);
    procedure SetMin(newValue: Integer);
    procedure SetPage(newValue: Integer);

    procedure IntMouseButton(Pressed : Boolean; Btn : TMouseButton; XPos, YPos : SmallInt);
    procedure IntMouseMove(XPos, YPos : SmallInt);
    procedure IntMouseEnter;
    procedure IntMouseLeave;
    procedure IntDoEnter;
    procedure IntDoExit;
    procedure IntColorChanged;
    function Control:TWinControl; virtual;
    {$ifdef MSWINDOWS}
    function ScreenToClient(const Point: TPoint): TPoint;virtual;
    {$endif}

    procedure DoSetPosition(newValue : Integer; Redraw : boolean);
    procedure DoSetMax(newValue : Integer; Redraw : boolean);
    procedure DoSetMin(newValue : Integer; Redraw : boolean);
    procedure DoSetPage(newValue : Integer; Redraw : boolean);
    function  ShadowColor: TColor;
    function  LighterColor: TColor;
    procedure SetFlat(newValue: Boolean);
    procedure SetActiveFlat(newValue: Boolean);
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMMouseEnter(var Msg: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;
    procedure CMEnter(var Msg: TCMEnter); message CM_ENTER;
    procedure CMExit(var Msg: TCMExit); message CM_EXIT;
    procedure WMEraseBkgnd(var Msg: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMLButtonDown(var Msg: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMLButtonUp(var Msg: TWMLButtonUp); message WM_LBUTTONUP;
    procedure WMGetDlgCode(var Msg: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMSize(var Msg: TWMSize); message WM_SIZE;
    procedure SBMSetScrollInfo(var Msg: TMessage); message SBM_SETSCROLLINFO;
    procedure SBMGetScrollInfo(var Msg: TMessage); message SBM_GETSCROLLINFO;
    procedure WMMouseMove(var Msg: TWMMouseMove); message WM_MOUSEMOVE;
    procedure WMSysColorChange(var Msg: TWMSysColorChange); message WM_SYSCOLORCHANGE;
    procedure CMColorChanged(var Msg: TMessage); message CM_COLORCHANGED;
    procedure WMPaint(var Msg : TWMPaint); message WM_PAINT;
    procedure WMWindowPosChanged(var Message: TWMWindowPosChanged); message
        WM_WINDOWPOSCHANGED;
    procedure WMMouseWheel(var Msg: TMessage); message WM_MOUSEWHEEL;
    procedure OnScrollTimer(Sender: TObject);
    procedure SetButtonSize(newValue: Integer);
    procedure SetThumbMode(newValue: TElScrollThumbMode);
    procedure SetThumbSize(newValue: Integer);
    function  GetAutoThumbSize : integer;
    function  GetThumbPos : integer;
    function  GetTopBtns : integer;
    function  GetBottomBtns : integer;
    function  AdjustThumbPos : integer; virtual;
    function  UpdateThumbPos : integer; virtual;
    procedure SetMinThumbSize(newValue: Integer);
    procedure SetSecondaryButtons(newValue: Boolean);
    procedure SetOwnerDraw(newValue: Boolean);
    procedure SetSecondBtnKind(newValue: TElSecButtonsKind);

    procedure SetNoDisableButtons(newValue: Boolean);
    procedure UpdateScrollingRegion;
    procedure ShowHintAt(APosition, X, Y: integer);
    function  GetButtonSize : integer;
    procedure SetIsDesigning(newValue : Boolean);
    function  GetIsDesigning : Boolean;
    procedure SetBlendBackground(newValue: boolean);
    procedure SetShowLeftArrows(newValue: Boolean);
    procedure SetShowRightArrows(newValue: Boolean);
    procedure SetNoSunkenThumb(newValue: Boolean);
    procedure SetUseSystemMetrics(value: boolean);
    procedure SetArrowColor(newValue: TColor);
    procedure SetArrowHotTrackColor(newValue: TColor);
    procedure SetShowBorder(newValue: Boolean);
    procedure SetDrawBars(const Value: Boolean);
    procedure SetDrawArrowFrames(const Value: Boolean);
    procedure SetThinFrame(newValue: Boolean);
    procedure SetBarColor(const Value: TColor);
    procedure SetBarOffset(const Value: Cardinal);
{$IFDEF ELPACK_USE_IMAGEFORM}
    procedure ImageFormChange(Sender: TObject);
    procedure SetImageForm(newValue: TElImageForm); virtual;
{$ENDIF}
    function RightBtnsEnabled: Boolean;
    function LeftBtnsEnabled: Boolean;
    procedure RebuildBackground;
    procedure SetAltDisablingArrows(const Value: Boolean);
    function GetThumbSize: Integer;
    function GetThemedClassName: WideString; override;

    procedure TriggerChangeEvent; virtual;
    procedure TriggerScrollEvent(ScrollCode: TElScrollCode; var ScrollPos: Integer; var DoChange: boolean); virtual;
    procedure TriggerScrollHintNeededEvent(TrackPosition: integer; var Hint: TElFString); virtual;
{$IFNDEF VCL_4_USED}
    procedure TriggerResizeEvent; virtual;
{$ENDIF}
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure CreateWnd; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetSysBkColor(Value: boolean);
    procedure TriggerHitTestEvent(X, Y : integer; var Part : TElScrollBarPart;
              var DefaultTest : boolean); virtual;
{$ifdef ELPACK_USE_IMAGEFORM}
    procedure IFMRepaintChildren(var Message: TMessage); message
        IFM_REPAINTCHILDREN;
{$endif}
    {$ifdef ELPACK_UNICODE}
    procedure SetHint(Value: TElFString);

    procedure CMHintShow(var Message: TMessage); message CM_HINTSHOW;
    {$endif}

    {$ifdef MSWINDOWS}
    procedure ELThemeChanged(var Message: TMessage); message EL_THEMECHANGED;
    {$endif}


    property Color nodefault;
    property ParentColor default False;

    property Kind: TScrollBarKind read FKind write SetKind default sbHorizontal; { Published }
    property Position: Integer read FPosition write SetPosition default 0; { Published }
    property Max: Integer read FMax write SetMax default 100; { Published }
    property Min: Integer read FMin write SetMin default 0; { Published }
    property Step: Integer read FStep write FStep default 1;
    property Flat: Boolean read FFlat write SetFlat default true; { Published }
    property ActiveFlat: Boolean read FActiveFlat write SetActiveFlat default true; { Published }
    property ButtonSize: Integer read GetButtonSize write SetButtonSize; { Published }
    property ThumbMode: TElScrollThumbMode read FThumbMode write SetThumbMode default etmAuto; { Published }
    property ThumbSize: Integer read GetThumbSize write SetThumbSize default 0;
    property MinThumbSize: Integer read FMinThumbSize write SetMinThumbSize default 4; { Published }
    property Page: Integer read FPage write SetPage default 14; { Published }
    property SecondaryButtons: Boolean read FSecondaryButtons write SetSecondaryButtons default false; { Published }
    property SecondBtnKind: TElSecButtonsKind read FSecondBtnKind write SetSecondBtnKind default sbkOpposite;
    property NoDisableButtons: Boolean read FNoDisableButtons write SetNoDisableButtons default false; { Published }
    property ShowTrackHint: Boolean read FShowTrackHint write FShowTrackHint default false; { Published }
    property IsDesigning: Boolean read GetIsDesigning write SetIsDesigning default false; { Protected }
    property BlendBackground: boolean read FBlendBackground write SetBlendBackground default true; { Protected }
    property ShowLeftArrows: Boolean read FShowLeftArrows write SetShowLeftArrows default True; { Protected }
    property ShowRightArrows: Boolean read FShowRightArrows write SetShowRightArrows default true; { Protected }
    property ChangeColorsOnScroll: Boolean read FChangeColorsOnScroll write FChangeColorsOnScroll default True; { Protected }
    property NoScrollMessages: boolean read FNoScrollMessages write FNoScrollMessages default false;
    property NoSunkenThumb: Boolean read FNoSunkenThumb write SetNoSunkenThumb default false; { Protected }
    property UseSystemMetrics: boolean read FUseSystemMetrics write SetUseSystemMetrics default true;
    property ShowBorder: Boolean read FShowBorder write SetShowBorder default true; { Protected }
    property DrawArrowFrames: Boolean read FDrawArrowFrames write SetDrawArrowFrames default true; { Protected }
    property DrawBars: Boolean read FDrawBars write SetDrawBars default True;
    property BarOffset: Cardinal read FBarOffset write SetBarOffset default 2;
    property BarColor: TColor read FBarColor write SetBarColor default clBtnShadow;
{$IFDEF HAS_HTML_RENDER}
    property IsHTML: boolean read FIsHTML write FIsHTML default false;
{$ENDIF}
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnHitTest: TElScrollHitTestEvent read FOnHitTest write FOnHitTest;
    property OnScroll: TElScrollEvent read FOnScroll write FOnScroll;
    property OnScrollHintNeeded: TElScrollHintNeededEvent read FOnScrollHintNeeded write FOnScrollHintNeeded;
    property OwnerDraw: Boolean read FOwnerDraw write SetOwnerDraw;
    property OnDrawPart: TElScrollDrawPartEvent read FOnDrawPart write FOnDrawPart;
    property ArrowColor: TColor read FArrowColor write SetArrowColor default clBtnText; { Protected }
    property ArrowHotTrackColor: TColor read FArrowHotTrackColor write SetArrowHotTrackColor default clHighlight; { Protected }
    property ThinFrame: Boolean read FThinFrame write SetThinFrame default false; { Protected }
    property HintColor: TColor read FHintColor write FHintColor default clInfoBk;
    property HintTextColor: TColor read FHintTextColor write FHintTextColor default
      clInfoText;
    property SystemBkColor : boolean read FSysBkColor write SetSysBkColor default true;
    property AltDisablingArrows: Boolean read FAltDisablingArrows write
        SetAltDisablingArrows default false;

{$IFDEF ELPACK_USE_IMAGEFORM}
    property ImageForm: TElImageForm read FImgForm write SetImageForm; { Protected }
{$ENDIF}
{$IFNDEF VCL_4_USED}
    property OnResize: TNotifyEvent read FOnResize write FOnResize;
{$ENDIF}
   {+}
    property TrackPos :Integer read fTrackPos write fTrackPos;
    property ThumbPos :Integer read fThumbPos write fThumbPos;
    property MouseInControl :boolean read fMouseInControl write fMouseInControl;
    property MouseOver :TElScrollBarPart read fMouseOver;
    property Tracking :boolean read fTracking;
    property Pressed :boolean read fPressed;
    property PressedIn :TElScrollBarPart read fPressedIn;
//    FOrigPressedIn,
//    FMouseOver: TElScrollBarPart;
    property ScrollTimer: TTimer read fScrollTimer;
   {+.}
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;
    function GetHitTest(X, Y : integer) : TElScrollBarPart;
    procedure Paint; override;
{$IFNDEF VCL_4_USED}
    procedure Resize; virtual;
{$ELSE}
    procedure Resize; override;
{$ENDIF}
    procedure EndScroll;
    function SetScrollInfo(ScrollInfo: TScrollInfo; Redraw: BOOL): Integer;
    function GetScrollInfo(var ScrollInfo: TScrollInfo): BOOL;
  published
    {$ifdef ELPACK_UNICODE}
    property Hint: TElFString read FHint write SetHint;
    {$endif}
  end; { TCustomElScrollBar }

  TElScrollBarStyles = class(TPersistent)
  private
    FElScrollBar: TCustomElScrollBar;
    FOnChange: TNotifyEvent;
    FOwner: TControl;
    function GetButtonSize: integer;
    procedure SetButtonSize(newValue: Integer);
    function GetNoDisableButtons: Boolean;
    procedure SetNoDisableButtons(newValue: Boolean);
    function GetNoSunkenThumb: Boolean;
    procedure SetNoSunkenThumb(newValue: Boolean);
    procedure SetActiveFlat(newValue: Boolean);
    function GetActiveFlat: Boolean;
    procedure SetColor(newValue: TColor);
    function GetColor: TColor;
    procedure SetFlat(newValue: Boolean);
    function GetFlat: Boolean;
    procedure SetMinThumbSize(newValue: Integer);
    function GetMinThumbSize: Integer;
    procedure SetOwnerDraw(newValue: Boolean);
    function GetOwnerDraw: Boolean;
    procedure SetSecondaryButtons(newValue: Boolean);
    function GetSecondaryButtons: Boolean;
    procedure SetSecondBtnKind(newValue: TElSecButtonsKind);
    function GetSecondBtnKind: TElSecButtonsKind;
    procedure SetShowTrackHint(newValue: Boolean);
    function GetShowTrackHint: Boolean;
    procedure SetThumbMode(newValue: TElScrollThumbMode);
    function GetThumbMode: TElScrollThumbMode;
    procedure SetThumbSize(newValue: Integer);
    function GetThumbSize: Integer;
    function GetBlendBackground: Boolean;
    procedure SetBlendBackground(newValue: Boolean);
    function GetWidth : Integer;
    procedure SetWidth(newValue : Integer);
    function GetShowLeftArrows: Boolean;
    procedure SetShowLeftArrows(newValue: Boolean);
    function GetShowRightArrows: Boolean;
    procedure SetShowRightArrows(newValue: Boolean);
    function GetUseSystemMetrics: boolean;
    procedure SetUseSystemMetrics(Value: boolean);
    function GetArrowColor: TColor;
    procedure SetArrowColor(newValue: TColor);
    function GetArrowHotTrackColor: TColor;
    procedure SetArrowHotTrackColor(newValue: TColor);
    function GetShowBorder: Boolean;
    procedure SetShowBorder(newValue: Boolean);
    function GetThinFrame: Boolean;
    procedure SetThinFrame(newValue: Boolean);
    function GetHintColor: TColor;
    procedure SetHintColor(Value: TColor);
    function GetHintTextColor: TColor;
    procedure SetHintTextColor(Value: TColor);
    function GetDrawBars: Boolean;
    procedure SetDrawBars(const Value: Boolean);
    function GetBarColor: TColor;
    procedure SetBarColor(const Value: TColor);
    function GetBarOffset: Cardinal;
    procedure SetBarOffset(const Value: Cardinal);
{$IFDEF ELPACK_USE_IMAGEFORM}
    function GetImageForm: TElImageForm;
    procedure SetImageForm(newValue: TElImageForm);
{$ENDIF}
    function GetDrawArrowFrames: Boolean;
    procedure SetDrawArrowFrames(const Value: Boolean);

    function GetUseXPThemes: Boolean;
    procedure SetUseXPThemes(const Value: Boolean);

  protected
    function GetSysBkColor: boolean;
    procedure SetSysBkColor(Value: boolean);
    procedure ReadThinFramesProperty(Reader: TReader);
    procedure ReadDrawFramesProperty(Reader: TReader);
    procedure DefineProperties(Filer : TFiler); override;
  public
    constructor Create(AControl: TCustomElScrollBar; AOwner : TControl);
    procedure Assign(Source: TPersistent); override;
  published
    property ActiveFlat: Boolean read GetActiveFlat write SetActiveFlat default false;
    property BlendBackground: Boolean read GetBlendBackground write SetBlendBackground default true; { Published }
    property Color: TColor read GetColor write SetColor default clBtnFace;
    property Flat: Boolean read GetFlat write SetFlat default true;
    property MinThumbSize: Integer read GetMinThumbSize write SetMinThumbSize default 4;
    property NoDisableButtons: Boolean read GetNoDisableButtons write SetNoDisableButtons default false; { Published }
    property NoSunkenThumb: Boolean read GetNoSunkenThumb write SetNoSunkenThumb default false; { Published }
    property OwnerDraw: Boolean read GetOwnerDraw write SetOwnerDraw default false;
    property SecondaryButtons: Boolean read GetSecondaryButtons write SetSecondaryButtons default false;
    property SecondBtnKind: TElSecButtonsKind read GetSecondBtnKind write SetSecondBtnKind default sbkOpposite;
    property ShowLeftArrows: Boolean read GetShowLeftArrows write SetShowLeftArrows default true; { Published }
    property ShowRightArrows: Boolean read GetShowRightArrows write SetShowRightArrows default true; { Published }
    property ShowTrackHint: Boolean read GetShowTrackHint write SetShowTrackHint;
    property ThumbMode: TElScrollThumbMode read GetThumbMode write SetThumbMode default etmAuto;
    property ThumbSize: Integer read GetThumbSize write SetThumbSize default 0;
    property Width     : Integer read GetWidth write SetWidth;  { Published }
    property ButtonSize: integer read GetButtonSize write SetButtonSize;
    property UseSystemMetrics: boolean read GetUseSystemMetrics write SetUseSystemMetrics default true;
    property ArrowColor: TColor read GetArrowColor write SetArrowColor default clBtnText; { Published }
    property ArrowHotTrackColor: TColor read GetArrowHotTrackColor write SetArrowHotTrackColor default clHighlight; { Published }

    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property ShowBorder: Boolean read GetShowBorder write SetShowBorder default true; { Published }
    property DrawArrowFrames: Boolean read GetDrawArrowFrames write SetDrawArrowFrames default true; { Published }
    property DrawBars: Boolean read GetDrawBars write SetDrawBars default True;
    property BarOffset: Cardinal read GetBarOffset write SetBarOffset default 2;
    property BarColor: TColor read GetBarColor write SetBarColor default clBtnShadow;
    property ThinFrame: Boolean read GetThinFrame write SetThinFrame default false; { Published }
    property HintColor: TColor read GetHintColor write SetHintColor default clInfoBk;
    property HintTextColor: TColor read GetHintTextColor write SetHintTextColor default clInfoText;
    property SystemBkColor: boolean read GetSysBkColor write SetSysBkColor default true;
{$IFDEF ELPACK_USE_IMAGEFORM}
    property ImageForm: TElImageForm read GetImageForm write SetImageForm; { Published }
{$ENDIF}
    property UseXPThemes: Boolean read GetUseXPThemes write SetUseXPThemes default True;
  end;

  TElScrollBar = class(TCustomElScrollBar)
  published
    property AltDisablingArrows;
    property ArrowColor;
    property ArrowHotTrackColor;
    property Kind;
    property Position;
    property Max;
    property Min;
    property Flat;
    property ActiveFlat;
    property BlendBackground;
    property SystemBkColor;
    property ButtonSize;
    property ChangeColorsOnScroll;
    property ShowBorder;
    property DrawArrowFrames;
    property DrawBars;
    property BarOffset;
    property BarColor;
{$IFDEF ELPACK_USE_IMAGEFORM}
    property ImageForm;
{$ENDIF}
{$IFDEF HAS_HTML_RENDER}
    property IsHTML;
{$ENDIF}
    property MinThumbSize;
    property NoDisableButtons;
    property NoSunkenThumb;
    property Page;
    property SecondaryButtons;
    property SecondBtnKind;
    property ShowLeftArrows;
    property ShowRightArrows;
    property ShowTrackHint;
    property Step;
    property ThinFrame;
    property ThumbMode;
    property ThumbSize;
    property UseSystemMetrics;

    property UseXPThemes;

    { Inherited properties: }

    property Align;
    property Color;
    property Ctl3D;
    property Enabled;
    property ParentFont;
    property ParentColor;
    property ParentShowHint;
    property ShowHint;

    property TabOrder;
    property TabStop;
    property Visible;

    property OnHitTest;
    property OnChange;
    property OnScroll;
    property OnScrollHintNeeded;
    property OwnerDraw;
    property OnDrawPart;

{$IFNDEF VCL_4_USED}
    property OnResize;
{$ENDIF}

    { Inherited events: }
{$IFDEF VCL_4_USED}
    property OnStartDock;
    property OnEndDock;
{$ENDIF}
{$IFDEF VCL_5_USED}
    property OnContextPopup;
{$ENDIF}
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseUp;
    property OnMouseMove;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnStartDrag;
  end;

implementation

var FBlendBitmap: TBitmap;

procedure TCustomElScrollBar.SetKind(newValue: TScrollBarKind);
begin
  if (FKind <> newValue) then
  begin
    FKind := newValue;
    if not (csLoading in ComponentState) then SetBounds(Left, Top, Height, Width);
    if (not (csLoading in ComponentState)) and HandleAllocated then
    begin
      if FUseSystemMetrics then
      begin
        FUseSystemMetrics := false;
        UseSystemMetrics := true;
      end
      else
      begin
        FThumbPos := AdjustThumbPos;
        Invalidate;
      end;
    end;
  end; { if }
end; { SetKind }

procedure TCustomElScrollBar.DoSetPosition(newValue: Integer; Redraw: boolean);
var op : integer;
    DoChange: boolean;
begin
  if (FPosition <> newValue) then
  begin
    op := FPosition;
    if not (csLoading in ComponentState) then
    begin
      if newValue < FMin then
        FPosition := FMin
      else
        if newValue > FMax then
          FPosition := FMax
        else
          FPosition := newValue;
      FThumbPos := AdjustThumbPos;
    end
    else
      FPosition := newValue;
    if Redraw and (OP <> FPosition) then
    begin
      if FNoDisableButtons and (OP <> FMin) and (Position <> FMin) and (OP <> FMax) and (Position <> FMax) then
        UpdateScrollingRegion
      else
        Invalidate;
    end;
    TriggerScrollEvent(escPosition, newValue, DoChange);
  end; { if }
end;

procedure TCustomElScrollBar.DoSetMax(newValue: Integer; Redraw: boolean);
begin
  if (FMax <> newValue) then
  begin
    FMax := newValue;
    if not (csLoading in ComponentState) then
    begin
      if FMin >= FMax then FMax := FMin;
      FPage := ElTools.Min(FPage, FMax - FMin + 1);
      FThumbPos := AdjustThumbPos;
      if HandleAllocated then Invalidate;
    end;
    if FPosition > FMax then
      SetPosition(Max)
    else
      if Redraw then Invalidate;
  end; { if }
end;

procedure TCustomElScrollBar.DoSetMin(newValue: Integer; Redraw: boolean);
begin
  if (FMin <> newValue) then
  begin
    FMin := newValue;
    if not (csLoading in ComponentState) then
    begin
      if FMin >= FMax then FMax := FMin;
      FPage := ElTools.Min(FPage, FMax - FMin + 1);
      FThumbPos := AdjustThumbPos;
      if HandleAllocated then Invalidate;
    end;
    if FPosition < FMin then
      SetPosition(Min)
    else
      if Redraw then Invalidate;
  end; { if }
end;

procedure TCustomElScrollBar.DoSetPage(newValue: Integer; Redraw: boolean);
begin
  if (FPage <> newValue) and (newValue >= 0) then
  begin
    FPage := newValue;
    if (not (csLoading in ComponentState)) and HandleAllocated then Invalidate;
  end; { if }
end;

procedure TCustomElScrollBar.SetPosition(newValue: Integer);
begin
  DoSetPosition(newValue, (not (csLoading in ComponentState)) and HandleAllocated);
end; { SetPosition }

procedure TCustomElScrollBar.SetMax(newValue: Integer);
begin
  DoSetMax(newValue, not (csLoading in ComponentState) and HandleAllocated);
end; { SetMax }

procedure TCustomElScrollBar.SetMin(newValue: Integer);
{ Sets data member FMin to newValue. }
begin
  DoSetMin(newValue, not (csLoading in ComponentState) and HandleAllocated);
end; { SetMin }

procedure TCustomElScrollBar.SetFlat(newValue: Boolean);
{ Sets data member FFlat to newValue. }
begin
  if (FFlat <> newValue) then
  begin
    FFlat := newValue;
    if not (csLoading in ComponentState) and HandleAllocated then Invalidate;
  end; { if }
end; { SetFlat }

procedure TCustomElScrollBar.SetActiveFlat(newValue: Boolean);
{ Sets data member FActiveFlat to newValue. }
begin
  if (FActiveFlat <> newValue) then
  begin
    FActiveFlat := newValue;
    if (FMouseInControl or Focused) then Invalidate;
  end; { if }
end; { SetActiveFlat }

{$warnings off}
procedure TCustomElScrollBar.IntMouseButton(Pressed : Boolean; Btn : TMouseButton; XPos, YPos : SmallInt);
var
  FHit: TElScrollBarPart;
  ScrollCode: TElScrollCode;
  NewPos: Integer;
  DoChange: boolean;
  AX, AY: integer;
  PrevPressed : boolean;
begin
  inherited;
  if Btn <> mbLeft then
    exit;
  if Pressed then
  begin
    FPressedIn := GetHitTest(XPos, YPos);
    FHit := FPressedIn;
    if not FPressed then
    begin
      PrevPressed := FPressed;
      FOrigPressedIn := FPressedIn;
      FPressed := true;
      case FPressedIn of
        sbpThumb:
          begin
            FPressed := (Page < Max - Min + 1) and (Max - Min <> 0);
            if FPressed then
            begin
              if Kind = sbHorizontal then
                FOrigCoord := XPos
              else
                FOrigCoord := YPos;
              FOrigPos := Position;
              FThumbOffset := FOrigCoord - GetThumbPos;
              if FShowTrackHint then
              begin
                if Kind = sbHorizontal then
                begin
                  AY := -5;
                  AX := FThumbPos - 2;
                end
                else
                begin
                  AX := -2;
                  AY := FThumbPos - 2;
                end;
                if not (csDesigning in Parent.ComponentState) then
                  ShowHintAt(Position, AX, AY);
              end;
            end;
          end;
        sbpLeftTop:
          begin
            ScrollCode := escPageUp;
            NewPos := ElTools.Max(FMin, FPosition - FPage);
            FPressed := LeftBtnsEnabled;
          end;
        sbpRightBottom:
          begin
            ScrollCode := escPageDown;
            NewPos := ElTools.Min(FMax, FPosition + FPage);
            FPressed := RightBtnsEnabled;
          end;
        sbpLeftArrow:
          begin
            ScrollCode := escLineUp;
            NewPos := ElTools.Max(FMin, FPosition - FStep);
            FPressed := LeftBtnsEnabled;
          end;
        sbpRightArrow:
          begin
            ScrollCode := escLineDown;
            NewPos := ElTools.Min(FMax, FPosition + FStep);
            FPressed := RightBtnsEnabled;
          end;
        sbpRightSndArrow:
          begin
            case FSecondBtnKind of
              sbkOpposite:
                begin
                  ScrollCode := escLineUp;
                  NewPos := ElTools.Max(FMin, FPosition - FStep);
                  FPressed := LeftBtnsEnabled;
                end;
              sbkPage:
                begin
                  ScrollCode := escPageDown;
                  NewPos := ElTools.Min(FMax, FPosition + FPage);
                  FPressed := RightBtnsEnabled;
                end;
              sbkCustom:
                begin
                  ScrollCode := escSndLineUp;
                  NewPos := FPosition;
                end;
            end;
          end;
        sbpLeftSndArrow:
          begin
            case FSecondBtnKind of
              sbkOpposite:
                begin
                  ScrollCode := escLineDown;
                  NewPos := ElTools.Min(FMax, FPosition + FStep);
                  FPressed := RightBtnsEnabled;
                end;
              sbkPage:
                begin
                  ScrollCode := escPageUp;
                  NewPos := ElTools.Max(FMin, FPosition - FPage);
                  FPressed := LeftBtnsEnabled;
                end;
              sbkCustom:
                begin
                  ScrollCode := escSndLineDown;
                  NewPos := FPosition;
                end;
            end;
          end;
      end;
      if FPressed or (NoDisableButtons and (FPressedIn <> sbpThumb)) then
      begin
        FPressed := true;
        FSaveCapture := GetCapture;
        if FSaveCapture = Handle then FSaveCapture := 0;
        SetCapture(Handle);
        if FPressedIn <> sbpThumb then
        begin
          FPressedPos.x := XPos;
          FPressedPos.y := YPos;
          FScrollTimer.Interval := GetKeybTimes(SPI_GETKEYBOARDDELAY);
          FScrollTimer.Enabled := true;
          TriggerScrollEvent(ScrollCode, NewPos, DoChange);
          if DoChange then
          begin
            Position := NewPos;
            TriggerChangeEvent;
          end;
        end
        else
          UpdateScrollingRegion;
      end
      else
        FPressedIn := sbpNowhere;
    end;
    if (FHit <> FPressedIn) or (not PrevPressed) then
      Invalidate;
  end
  else// if not Pressed then
  begin
    if FPressed then
    begin
      FScrollTimer.Enabled := false;
      if FSaveCapture <> 0 then
        SetCapture(FSaveCapture)
      else
        ReleaseCapture;
      FSaveCapture := 0;
      FPressed := false;
      if FTrackPos <> -1 then
      begin
        FTracking := false;
        FTrackPos := -1;
      end;

      if FPressedIn = sbpThumb then
      begin
        if FHintWnd <> nil then
        begin
          FHintWnd.Free;
          FHintWnd := nil;
        end;
        NewPos := UpdateThumbPos;
        TriggerScrollEvent(escPosition, NewPos, DoChange);
        if DoChange and (NewPos <> Position) then
        begin
          Position := NewPos;
          TriggerChangeEvent;
        end;
        FThumbPos := AdjustThumbPos;
      end
      else
        if FPressedIn <> sbpNowhere then
        begin
          NewPos := Position;
          TriggerScrollEvent(escEndScroll, NewPos, DoChange);
          if DoChange and (NewPos <> Position) then
          begin
            Position := NewPos;
            TriggerChangeEvent;
          end;
          FThumbPos := AdjustThumbPos;
        end;
      FPressedIn := sbpNowhere;
      Invalidate;
    end
    else
    begin
      if FSaveCapture <> 0 then
        SetCapture(FSaveCapture)
      else
        ReleaseCapture;
      FSaveCapture := 0;
    end;
  end;
end; { IntMouseButton }
{$warnings on}

procedure TCustomElScrollBar.IntMouseMove (XPos, YPos : SmallInt);
var
  OldMouseOver: TElScrollBarPart;
  ATS, OP, NP, CS: integer;
  DoChange: boolean;
  AX, AY: integer;
begin
  if not FPressed then
  begin
    OldMouseOver := FMouseOver;
    FMouseOver := GetHitTest(XPos, YPos);
    if FMouseOver <> OldMouseOver then
      Invalidate;
  end
  else
  begin
    if FTrackPos = -1 then
    begin
      FTracking := true;
      FTrackPos := FThumbOffset;
    end;
    if FPressedIn = sbpThumb then
    begin
      if Kind = sbHorizontal then
      begin
        CS := ClientWidth;
        OP := FThumbPos;
        if ((XPos < 0) and (Abs(XPos) > CS shr 1)) or
          ((XPos > CS) and (XPos - CS > CS shr 1)) then
        begin
          FThumbPos := FOrigCoord - FThumbOffset;
          NP := UpdateThumbPos;
          UpdateScrollingRegion;
        end
        else
        begin
          if FThumbMode = etmFixed then
            ATS := ThumbSize
          else
            ATS := GetAutoThumbSize;
          FThumbPos := XPos - FThumbOffset;
          if FThumbPos < ButtonSize * (GetTopBtns) then
            FThumbPos := ButtonSize * (GetTopBtns)
          else
          if FThumbPos > (CS - ButtonSize * (GetBottomBtns) - ATS) then
            FThumbPos := CS - ButtonSize * (GetBottomBtns) - ATS;

          NP := UpdateThumbPos;
          if not NoScrollMessages then
            SendMessage(Parent.Handle, WM_HSCROLL, NP shl 16 + SB_THUMBPOSITION, Handle);
          TriggerScrollEvent(escTrack, NP, DoChange);
          if OP <> FThumbPos then
            UpdateScrollingRegion;
        end;
      end
      else
      begin
        CS := ClientHeight;
        OP := FThumbPos;
        if ((YPos < 0) and (Abs(YPos) > CS shr 1)) or
          ((YPos > CS) and (YPos - CS > CS shr 1)) then
        begin
          FThumbPos := FOrigCoord - FThumbOffset;
          NP := UpdateThumbPos;
          UpdateScrollingRegion;
        end
        else
        begin
          if FThumbMode = etmFixed then
            ATS := ThumbSize
          else
            ATS := GetAutoThumbSize;
          FThumbPos := YPos - FThumbOffset;
          if FThumbPos < ButtonSize * (GetTopBtns) then
            FThumbPos := ButtonSize * (GetTopBtns)
          else
            if FThumbPos > (CS - ButtonSize * (GetBottomBtns) - ATS) then
              FThumbPos := CS - ButtonSize * (GetBottomBtns) - ATS;
          NP := UpdateThumbPos;
          if not NoScrollMessages then
            SendMessage(Parent.Handle, WM_VSCROLL, NP shl 16 + SB_THUMBPOSITION, Handle);
          TriggerScrollEvent(escTrack, NP, Dochange);
          if OP <> FThumbPos then
            UpdateScrollingRegion;
        end;
      end;
      if FShowTrackHint and (OP <> FThumbPos) then
      begin
        if Kind = sbHorizontal then
        begin
          AY := -5;
          AX := FThumbPos - 2;
        end
        else
        begin
          AX := -2;
          AY := FThumbPos - 2;
        end;
        ShowHintAt(NP, AX, AY);
      end;
    end
    else
    begin
      OldMouseOver := FMouseOver;
      FMouseOver := GetHitTest(XPos, YPos);
      if FMouseOver <> FPRessedIn then
        FScrollTimer.Enabled := false
      else
        if OldMouseOver <> FMouseOver then
        begin
          if (FPressedIn <> sbpThumb) then
            FScrollTimer.Enabled := true;
        end;
      if OldMouseOver <> FMouseOver then Invalidate;
    end;
  end;
end; { IntMouseMove }

procedure TCustomElScrollBar.IntMouseEnter;
begin
  FMouseInControl := true;
  if (Flat and (not ActiveFlat)) {$ifdef MSWINDOWS}or IsThemeApplied{$endif} then Invalidate;
end;

procedure TCustomElScrollBar.IntMouseLeave;
begin
  FMouseInControl := false;
  if (Flat and (not ActiveFlat)) {$ifdef MSWINDOWS}or IsThemeApplied(){$endif} or
     (FMouseOver in [sbpLeftArrow, sbpRightSndArrow, sbpRightArrow, sbpLeftSndArrow]) then
    Invalidate;
  FMouseOver := sbpNowhere;
end;

procedure TCustomElScrollBar.IntDoEnter;
begin
  if (Flat and (not ActiveFlat)) {$ifdef MSWINDOWS}or IsThemeApplied(){$endif} then Invalidate;
end;

procedure TCustomElScrollBar.IntDoExit;
begin
  if (Flat and (not ActiveFlat)) {$ifdef MSWINDOWS}or IsThemeApplied(){$endif} then Invalidate;
end;

procedure TCustomElScrollBar.IntColorChanged;
begin
  if FBlendBackground then
    RebuildBackground;
  Invalidate;
end;

procedure TCustomElScrollBar.CMMouseEnter(var Msg: TMessage); { private }
begin
  inherited;
  IntMousEenter;
end; { CMMouseEnter }

procedure TCustomElScrollBar.CMMouseLeave(var Msg: TMessage); { private }
begin
  inherited;
  IntMouseLeave;
end; { CMMouseLeave }

procedure TCustomElScrollBar.CMEnter(var Msg: TCMEnter); { private }
begin
  inherited;
  IntDoEnter;
end; { CMEnter }

procedure TCustomElScrollBar.CMExit(var Msg: TCMExit); { private }
begin
  inherited;
  IntDoExit;
end; { CMExit }

function TCustomElScrollBar.ShadowColor: TColor;
var
  hlscol, rgbcol: Cardinal;
  lum: integer;
begin
  if Color = clBtnFace then
    result := clBtnShadow
  else
  begin
    rgbcol := ColorToRGB(Color);
    hlscol := RGBtoHLS(rgbcol);
    lum := Hi(hlscol and $0000FFFF);
{$warnings off}
    hlscol := Cardinal((ElTools.Min(255, (Hi(hlscol and $0000FFFF) - lum div 4)) shl 8)) or (hlscol and $FF00FF);
{$warnings on}
    result := HLStoRGB(hlscol);
  end;
end;

function TCustomElScrollBar.LighterColor: TColor;
var
  hlscol, rgbcol: TColor;
  lum: integer;
begin
  if Color = clBtnFace then
    result := clBtnHighlight
  else
  begin
    rgbcol := ColorToRGB(Color);
    hlscol := RGBtoHLS(rgbcol);
    lum := Hi(hlscol and $0000FFFF);
{$warnings off}
    hlscol := Cardinal((ElTools.Min(255, (Hi(hlscol and $0000FFFF) + lum div 4)) shl 8)) or (hlscol and $FF00FF);
{$warnings on}
    result := HLStoRGB(hlscol);
  end;
end;

procedure TCustomElScrollBar.Paint; { public }
var
  R1, R2: TRect;
  ATS: integer;
  b, e: boolean;
  DefDraw: boolean;
  TransBk: boolean;
  aW, aH, aSh: Integer;
{$IFDEF ELPACK_COMPLETE}
  ACtl : TWinControl;
  ax, ay: integer;
  P: TPoint;
  BgRect: TRect;
{$ENDIF}
  TmpCanvas : TCanvas;

  // TmpBitmap : TBitmap;

  ArrColors: array[boolean] of TColor;

  {$ifdef MSWINDOWS}
  iStateId: Integer;
  RClip: TRect;
  {$endif}

  procedure FillBackground(Rect: TRect);
  {$ifdef MSWINDOWS}
  var
    C: COLORREF;
  {$endif}
  begin
    if not TransBk then
    begin
      if (BlendBackground and (not SystemBkColor))
         or (SystemBkColor and (GetSysColor(COLOR_SCROLLBAR) = GetSysColor(COLOR_BTNFACE)))
      then
      begin
        TmpCanvas.Brush.Bitmap := FBlendBitmap;
        TmpCanvas.FillRect(Rect);
        TmpCanvas.Brush.Bitmap := nil;
        TmpCanvas.Brush.Color := Color;
        TmpCanvas.Brush.Style := bsSolid;
      end
      else
      begin
        {$ifdef MSWINDOWS}
        if IsThemeApplied() and Succeeded(GetThemeColor(Theme, 0, 0, TMT_SCROLLBAR, C)) then
        begin
          TmpCanvas.Brush.Color := C;
        end
        else
        begin
          if SystemBkColor then
            TmpCanvas.Brush.Color := clScrollbar
          else
            TmpCanvas.Brush.Color := Color;
        end;
        {$else}
        if SystemBkColor then
          TmpCanvas.Brush.Color := clScrollbar
        else
          TmpCanvas.Brush.Color := Color;
        {$endif}
        TmpCanvas.FillRect(Rect);
        TmpCanvas.Brush.Color := Color;
        TmpCanvas.Brush.Style := bsSolid;
      end;
    end;
  end;

  procedure FillShadow(Rect: TRect);
  begin
    if {$ifdef MSWINDOWS}(not IsThemeApplied()) and {$endif}not TransBk then
    begin
      TmpCanvas.Brush.Color := ShadowColor;
      TmpCanvas.FillRect(Rect);
      TmpCanvas.Brush.Color := Color;
    end;
  end;

  procedure FillArrowFrame(Rect: TRect);
  var
    OldColor: TColor;
    {$ifdef MSWINDOWS}
    iPartId: Integer;
    {$endif}
  begin
    {$ifdef MSWINDOWS}
    if IsThemeApplied() then
    begin
      RClip := TmpCanvas.ClipRect;
      if Kind = sbHorizontal then
      begin
        iPartId := (SBP_THUMBBTNHORZ);
      end
      else
      begin
        iPartId := (SBP_THUMBBTNVERT);
      end;
      DrawThemeBackground(Theme, TmpCanvas.Handle, iPartId, 0, Rect, @RClip);
    end
    else
    {$endif}
    begin
      if not TransBk then
      begin
        OldColor := TmpCanvas.Brush.Color;
        if FDrawArrowFrames then
        begin
          TmpCanvas.Brush.Color := Color;
          TmpCanvas.FillRect(Rect)
        end
        else
        begin
          FillBackground(Rect);
        end;
        TmpCanvas.Brush.Color := OldColor;
      end;
    end;
  end;

begin
  TmpCanvas := Canvas;

  {$ifdef MSWINDOWS}
  RClip := Canvas.ClipRect;
  {$endif}
  ArrColors[false] := ArrowColor;
  ArrColors[true] := ArrowHotTrackColor;

  TmpCanvas.Brush.Color := Color;
  R2 := ClientRect;
  R1 := R2;
  TransBk := false;
{$IFDEF ELPACK_USE_IMAGEFORM}
  if (FImgForm <> nil) and (not (csDesigning in FImgForm.ComponentState)) then
  begin
    TransBk := true;
    TmpCanvas.Brush.Style := bsClear;
    if (FImgForm.Control <> Self) then
    begin
      ACtl := FImgForm.GetRealControl;
      R1 := R2;
      BgRect := R1;
      BgRect.TopLeft := ClientToScreen(BgRect.TopLeft);
      P := Parent.ClientToScreen(Point(Left, Top));
      ax := BgRect.Left - P.x;
      ay := BgRect.Top - P.y;

      BgRect.BottomRight := ClientToScreen(BgRect.BottomRight);
      BgRect.TopLeft := ACtl.ScreenToClient(BgRect.TopLeft);
      BgRect.BottomRight := ACtl.ScreenToClient(BgRect.BottomRight);
      FImgForm.PaintBkgnd(TmpCanvas.Handle, R1, Point(BgRect.Left - ax, BgRect.Top - ay), false);
    end;
  end
  else
{$ENDIF}
  TmpCanvas.Brush.Style := bsSolid;
  R2 := ClientRect;
  R1 := R2;
  if (kind = sbHorizontal) then
  begin
    if FShowLeftArrows then
    begin
      R1.Right := R1.Left + ButtonSize;
      R2.Left := R1.Right;
      {$ifdef MSWINDOWS}
      if IsThemeApplied() then
      begin
        if (LeftBtnsEnabled or NoDisableButtons) and Enabled then
        begin
          if (FPressedIn = sbpLeftArrow) and (FMouseOver = FPressedIn) then
          begin
            iStateId := (ABS_LEFTPRESSED);
          end
          else
          begin
            if (not FPressed) and FMouseInControl and (FMouseOver = sbpLeftArrow) then
            begin
              iStateId := (ABS_LEFTHOT);
            end
            else
            begin
              iStateId := (ABS_LEFTNORMAL);
            end;
          end;
        end
        else
        begin
          iStateId := (ABS_LEFTDISABLED);
        end;
        DrawThemeBackground(Theme, TmpCanvas.Handle, SBP_ARROWBTN, iStateId, R1, @RClip);
      end
      else
      {$endif}
      begin
        FillArrowFrame(R1);
        b := (not Flat) or ((not FPressed) and FMouseInControl and (not FActiveFlat) and (FMouseOver = sbpLeftArrow) and (LeftBtnsEnabled or NoDisableButtons));
        DefDraw := true;
        if OwnerDraw and Assigned(FOnDrawPart) then
        begin
          FOnDrawPart(Self, TmpCanvas, R1, sbpLeftArrow, LeftBtnsEnabled, b, (FPressedIn = sbpLeftArrow) and (FMouseOver = FPressedIn), DefDraw);
        end;
        if DefDraw then
        begin
          if FDrawArrowFrames then
            DrawButtonFrameEx3(TmpCanvas.Handle, R1, b, (FPressedIn = sbpLeftArrow) and (FMouseOver = FPressedIn), Color, ThinFrame, AllBorderSides);
          DrawArrow(TmpCanvas, eadLeft, R1, ArrColors[(FMouseOver = sbpLeftArrow)], LeftBtnsEnabled or NoDisableButtons);
        end;
      end;
    end;

    if FShowRightArrows then
    begin
      R1 := R2;
      R1.Left := R1.Right - ButtonSize;
      R2.Right := R1.Left;
      {$ifdef MSWINDOWS}
      if IsThemeApplied() then
      begin
        if ( (RightBtnsEnabled or NoDisableButtons) and Enabled ) then
        begin
          if (FPressedIn = sbpRightArrow) and (FMouseOver = FPressedIn) then
          begin
            iStateId := (ABS_RIGHTPRESSED);
          end
          else
          begin
            if (not FPressed) and FMouseInControl and (FMouseOver = sbpRightArrow) then
            begin
              iStateId := (ABS_RIGHTHOT);
            end
            else
            begin
              iStateId := (ABS_RIGHTNORMAL);
            end;
          end;
        end
        else
        begin
          iStateId := (ABS_RIGHTDISABLED);
        end;
        DrawThemeBackground(Theme, TmpCanvas.Handle, SBP_ARROWBTN, iStateId, R1, @RClip);
      end
      else
      {$endif}
      begin
      FillArrowFrame(R1);
      b := (not Flat) or ((not FPressed) and FMouseInControl and (not FActiveFlat) and
           (FMouseOver = sbpRightArrow) and (RightBtnsEnabled or NoDisableButtons));
      DefDraw := true;
      if OwnerDraw and Assigned(FOnDrawPart) then
      begin
        FOnDrawPart(Self, TmpCanvas, R1, sbpRightArrow, RightBtnsEnabled, b, (FPressedIn = sbpRightArrow) and (FMouseOver = FPressedIn), DefDraw);
      end;
      if DefDraw then
      begin
        if FDrawArrowFrames then
          DrawButtonFrameEx3(TmpCanvas.Handle, R1, b, (FPressedIn = sbpRightArrow) and (FMouseOver = FPressedIn), Color, ThinFrame, AllBorderSides);
        DrawArrow(TmpCanvas, eadRight, R1, ArrColors[(FMouseOver = sbpRightArrow)], RightBtnsEnabled or NoDisableButtons);
      end;
    end;
    end;

    if FSecondaryButtons then
    begin
      if FShowLeftArrows then
      begin
        R1 := R2;
        R1.Right := R1.Left + ButtonSize;
        R2.Left := R1.Right;
        {$ifdef MSWINDOWS}
        if (FSecondBtnKind = sbkOpposite) and IsThemeApplied() then
        begin
          if (RightBtnsEnabled or NoDisableButtons) and Enabled then
          begin
            if (FPressedIn = sbpLeftSndArrow) and (FMouseOver = FPressedIn) then
            begin
              iStateId := (ABS_RIGHTPRESSED);
            end
            else
            begin
              if (not FPressed) and FMouseInControl and (FMouseOver = sbpLeftSndArrow) then
              begin
                iStateId := (ABS_RIGHTHOT);
              end
              else
              begin
                iStateId := (ABS_RIGHTNORMAL);
              end;
            end;
          end
          else
          begin
            iStateId := (ABS_RIGHTDISABLED);
          end;
          DrawThemeBackground(Theme, TmpCanvas.Handle, SBP_ARROWBTN, iStateId, R1, @RClip);
        end
        else
        {$endif}
        begin
          FillArrowFrame(R1);
          e := (((FSecondBtnKind <> sbkOpposite) and LeftBtnsEnabled) or ((FSecondBtnKind = sbkOpposite) and RightBtnsEnabled) or (FSecondBtnKind = sbkCustom) or NoDisableButtons);
          b := (not Flat) or ((not FPressed) and FMouseInControl and (not FActiveFlat) and (FMouseOver = sbpLeftSndArrow) and e);
          DefDraw := true;
          if OwnerDraw and Assigned(FOnDrawPart) then
          begin
            FOnDrawPart(Self, TmpCanvas, R1, sbpLeftSndArrow, e, b, (FPressedIn = sbpLeftSndArrow) and (FMouseOver = FPressedIn), DefDraw);
          end;
          if DefDraw then
          begin
            {$ifdef MSWINDOWS}
            if IsThemeApplied() then
            begin
              RClip := TmpCanvas.ClipRect;
              if (not e) or (not Enabled) then
              begin
                iStateId := (SCRBS_DISABLED);
              end
              else
              begin
                if (FPressedIn = sbpLeftSndArrow) and (FMouseOver = FPressedIn) then
                begin
                  iStateId := (SCRBS_PRESSED);
                end
                else
                begin
                  if (not FPressed) and FMouseInControl and (FMouseOver = sbpLeftSndArrow) then
                  begin
                    iStateId := (SCRBS_HOT);
                  end
                  else
                  begin
                    iStateId := (SCRBS_NORMAL);
                  end;
                end;
              end;
              DrawThemeBackground(Theme, TmpCanvas.Handle, SBP_THUMBBTNHORZ, iStateId, R1, @RClip);
            end
            else
            {$endif}
            begin
              if FDrawArrowFrames then
                DrawButtonFrameEx3(TmpCanvas.Handle, R1, b, (FPressedIn = sbpLeftSndArrow) and (FMouseOver = FPressedIn), Color, ThinFrame, AllBorderSides);
            end;
            if FSecondBtnKind = sbkPage then
            begin
              OffsetRect(R1, 1, 0);
              DrawArrow(TmpCanvas, eadLeft, R1, ArrColors[(FMouseOver = sbpLeftSndArrow)], e);
              OffsetRect(R1, -3, 0);
              DrawArrow(TmpCanvas, eadLeft, R1, ArrColors[(FMouseOver = sbpLeftSndArrow)], e);
              OffsetRect(R1, 2, 0);
            end
            else
              DrawArrow(TmpCanvas, eadRight, R1, ArrColors[(FMouseOver = sbpLeftSndArrow)], e);
          end;
        end;
      end;

      if FShowRightArrows then
      begin
        R1 := R2;
        R1.Left := R1.Right - ButtonSize;
        R2.Right := R1.Left;
        {$ifdef MSWINDOWS}
        if (FSecondBtnKind = sbkOpposite) and IsThemeApplied() then
        begin
          if (LeftBtnsEnabled or NoDisableButtons) and Enabled then
          begin
            if (FPressedIn = sbpRightSndArrow) and (FMouseOver = FPressedIn) then
            begin
              iStateId := (ABS_LEFTPRESSED);
            end
            else
            begin
              if (not FPressed) and FMouseInControl and (FMouseOver = sbpRightSndArrow) then
              begin
                iStateId := (ABS_LEFTHOT);
              end
              else
              begin
                iStateId := (ABS_LEFTNORMAL);
              end;
            end;
          end
          else
          begin
            iStateId := (ABS_LEFTDISABLED);
          end;
          DrawThemeBackground(Theme, TmpCanvas.Handle, SBP_ARROWBTN, iStateId, R1, @RClip);
        end
        else
        {$endif}
        begin
          FillArrowFrame(R1);
            e := (((FSecondBtnKind <> sbkOpposite) and RightBtnsEnabled) or ((FSecondBtnKind = sbkOpposite) and LeftBtnsEnabled) or (FSecondBtnKind = sbkCustom) or NoDisableButtons);
          b := (not Flat) or ((not FPressed) and FMouseInControl and (not FActiveFlat) and (FMouseOver = sbpRightSndArrow) and e);
          DefDraw := true;
          if OwnerDraw and Assigned(FOnDrawPart) then
          begin
            FOnDrawPart(Self, TmpCanvas, R1, sbpRightSndArrow, e, b, (FPressedIn = sbpRightSndArrow) and (FMouseOver = FPressedIn), DefDraw);
          end;
          if DefDraw then
          begin
            {$ifdef MSWINDOWS}
            if IsThemeApplied() then
            begin
              RClip := TmpCanvas.ClipRect;
              if (not e) or (not Enabled) then
              begin
                iStateId := (SCRBS_DISABLED);
              end
              else
              begin
                if (FPressedIn = sbpRightSndArrow) and (FMouseOver = FPressedIn) then
                begin
                  iStateId := (SCRBS_PRESSED);
                end
                else
                begin
                  if (not FPressed) and FMouseInControl and (FMouseOver = sbpRightSndArrow) then
                  begin
                    iStateId := (SCRBS_HOT);
                  end
                  else
                  begin
                    iStateId := (SCRBS_NORMAL);
                  end;
                end;
              end;
              DrawThemeBackground(Theme, TmpCanvas.Handle, SBP_THUMBBTNHORZ, iStateId, R1, @RClip);
            end
            else
            {$endif}
            begin
              if FDrawArrowFrames then
                DrawButtonFrameEx3(TmpCanvas.Handle, R1, b, (FPressedIn = sbpRightSndArrow) and (FMouseOver = FPressedIn), Color, ThinFrame, AllBorderSides);
            end;
            if FSecondBtnKind = sbkPage then
            begin
              OffsetRect(R1, 2, 0);
              DrawArrow(TmpCanvas, eadRight, R1, ArrColors[(FMouseOver = sbpRightSndArrow)], e);
              OffsetRect(R1, -3, 0);
              DrawArrow(TmpCanvas, eadRight, R1, ArrColors[(FMouseOver = sbpRightSndArrow)], e);
              OffsetRect(R1, 1, 0);
            end
            else
              DrawArrow(TmpCanvas, eadLeft, R1, ArrColors[(FMouseOver = sbpRightSndArrow)], e);
          end;
        end;
      end;
    end;

    if FThumbMode = etmFixed then
      ATS := ThumbSize
    else
      ATS := GetAutoThumbSize;
    if (ATS > 0) and Enabled then
    begin

      // first draw the left part of the scroll fields
      DefDraw := true;

      R2.Right := FThumbPos;
      if FOwnerDraw and Assigned(FOnDrawPart) then
      begin
        FOnDrawPart(Self, TmpCanvas, R2, sbpLeftTop, Enabled, Focused, (FPressedIn = sbpLeftTop) and (FMouseOver = FPressedIn), DefDraw);
      end;
      if DefDraw then
      begin
        {$ifdef MSWINDOWS}
        if IsThemeApplied() then
        begin
          if (not Enabled) then
          begin
            iStateId := (SCRBS_DISABLED);
          end
          else
          begin
            if (FPressedIn = sbpLeftTop) and (FMouseOver = FPressedIn) then
            begin
              iStateId := (SCRBS_PRESSED);
            end
            else
            begin
              if (not FPressed) and FMouseInControl and (FMouseOver = sbpLeftTop) then
              begin
                iStateId := (SCRBS_HOT);
              end
              else
              begin
                iStateId := (SCRBS_NORMAL);
              end;
            end;
          end;
          DrawThemeBackground(Theme, TmpCanvas.Handle, SBP_UPPERTRACKHORZ, iStateId, R2, @RClip);
        end
        else
        {$endif}
        begin
          if (FPressedIn = sbpLeftTop) and (FMouseOver = FPressedIn) and ChangeColorsOnScroll then
          begin
            FillShadow(R2);
          end
          else
          begin
            FillBackground(R2);
          end;
        end;
      end;

      R1 := ClientRect;
      R1.Left := FThumbPos;
      R1.Right := R1.Left + ATS;
      b := (Focused and (not FActiveFlat)) or (not Flat) or (FMouseInControl and (not FActiveFlat) and ((FMouseOver = sbpThumb) and ((Max >= Min + 1) and (FPage < (Max - Min)))));
      DefDraw := true;
      if FOwnerDraw and Assigned(FOnDrawPart) then
      begin
        FOnDrawPart(Self, TmpCanvas, R1, sbpThumb, Enabled, b, FPressedIn = sbpThumb, DefDraw);
      end;
      if DefDraw then
      begin
        {$ifdef MSWINDOWS}
        if IsThemeApplied() then
        begin
          if not Enabled then
          begin
            iStateId := (SCRBS_DISABLED);
          end
          else
          begin
            if (FPressedIn = sbpThumb) then
            begin
              iStateId := (SCRBS_PRESSED);
            end
            else
            begin
              if (not FPressed) and FMouseInControl and (FMouseOver = sbpThumb) then
              begin
                iStateId := (SCRBS_HOT);
              end
              else
              begin
                iStateId := (SCRBS_NORMAL);
              end;
            end;
          end;
          DrawThemeBackground(Theme, TmpCanvas.Handle, SBP_THUMBBTNHORZ, iStateId, R1, @RClip);
          if FDrawBars then
          begin
            GetThemeBackgroundContentRect(Theme, TmpCanvas.Handle, SBP_THUMBBTNHORZ, iStateId, R1, R1);
            DrawThemeBackground(Theme, TmpCanvas.Handle, SBP_GRIPPERHORZ, iStateId, R1, @RClip);
          end;
        end
        else
        {$endif}
      begin
        TmpCanvas.Brush.Color := Color;
        if not TransBk then
          TmpCanvas.FillRect(R1);
        if FShowBorder then
          DrawButtonFrameEx3(TmpCanvas.Handle, R1, b, (FPressedIn = sbpThumb) and (not NoSunkenThumb), Color, ThinFrame, AllBorderSides);
        TmpCanvas.Brush.Color := Color;
        if FDrawBars and (ATS > 14) then
        begin
          aH := FBarOffset;
          if FShowBorder then Inc(aH);
          if (b) and (FPressedIn = sbpThumb) and (not NoSunkenThumb) then
            aSh := 1
          else
            aSh := 0;
          if (R1.Bottom - R1.Top) >= aH + aH + 3 then
          begin
            with R1 do
            begin
              aW := (Right + Left) shr 1;
            end;
            Inc(aW, aSh);
            with TmpCanvas do
            begin
              Pen.Color := FBarColor;
              MoveTo(aW - 1, R1.Top + aH + aSh);
              LineTo(aW - 1, R1.Bottom - aH + aSh);
              MoveTo(aW - 3, R1.Top + aH + aSh);
              LineTo(aW - 3, R1.Bottom - aH + aSh);
              MoveTo(aW + 1, R1.Top + aH + aSh);
              LineTo(aW + 1, R1.Bottom - aH + aSh);
              MoveTo(aW + 3, R1.Top + aH + aSh);
              LineTo(aW + 3, R1.Bottom - aH + aSh);
            end;
          end;
        end;
      end;
      end;

      // then draw the right part of the scroll fields
      R2.Left := FThumbPos + ATS;
      R2.Right := ClientWidth - ButtonSize * GetBottomBtns;
      if FOwnerDraw and Assigned(FOnDrawPart) then
      begin
        FOnDrawPart(Self, TmpCanvas, R2, sbpRightBottom, Enabled, Focused, (FPressedIn = sbpRightBottom) and (FMouseOver = FPressedIn), DefDraw);
      end;
      if DefDraw then
      begin
        {$ifdef MSWINDOWS}
        if IsThemeApplied() then
        begin
          if not Enabled then
          begin
            iStateId := (SCRBS_DISABLED);
          end
          else
          begin
            if (FPressedIn = sbpRightBottom) and (FMouseOver = FPressedIn) then
            begin
              iStateId := (SCRBS_PRESSED);
            end
            else
            begin
              if (not FPressed) and FMouseInControl and (FMouseOver = sbpRightBottom) then
              begin
                iStateId := (SCRBS_HOT);
              end
              else
              begin
                iStateId := (SCRBS_NORMAL);
              end;
            end;
          end;
          DrawThemeBackground(Theme, TmpCanvas.Handle, SBP_LOWERTRACKHORZ, iStateId, R2, @RClip);
        end
        else
        {$endif}
        begin
          if (FPressedIn = sbpRightBottom) and (FMouseOver = FPressedIn) and ChangeColorsOnScroll then
          begin
            FillShadow(R2);
          end
          else
          begin
            FillBackground(R2);
          end;
        end;
      end;
    end
    else
    begin
      DefDraw := true;
      if FOwnerDraw and Assigned(FOnDrawPart) then
      begin
        FOnDrawPart(Self, TmpCanvas, R2, sbpNowhere, Enabled, Focused, false, DefDraw);
      end;
      if DefDraw then
      begin
        {$ifdef MSWINDOWS}
        if IsThemeApplied() then
        begin
          iStateId := (SCRBS_DISABLED);
          DrawThemeBackground(Theme, TmpCanvas.Handle, SBP_LOWERTRACKHORZ, iStateId, R2, @RClip);
        end
        else
        {$endif}
        if not TransBk then
          FillBackground(R2);
        //if not TransBk then
        //  TmpCanvas.FillRect(R2);
      end;
    end;
  end
  else
  begin
    if FShowLeftArrows then
    begin
      R1.Bottom := R1.Top + ButtonSize;
      R2.Top := R1.Bottom;
      {$ifdef MSWINDOWS}
      if IsThemeApplied() then
      begin
        if (LeftBtnsEnabled or NoDisableButtons) and Enabled then
        begin
          if (FPressedIn = sbpLeftArrow) and (FMouseOver = FPressedIn) then
          begin
            iStateId := (ABS_UPPRESSED);
          end
          else
          begin
            if (not FPressed) and FMouseInControl and (FMouseOver = sbpLeftArrow) then
            begin
              iStateId := (ABS_UPHOT);
            end
            else
            begin
              iStateId := (ABS_UPNORMAL);
            end;
          end;
        end
        else
        begin
          iStateId := (ABS_UPDISABLED);
        end;
        DrawThemeBackground(Theme, TmpCanvas.Handle,  SBP_ARROWBTN, iStateId, R1, @RClip);
      end
      else
      {$endif}
      begin
      FillArrowFrame(R1);
      b := (not Flat) or ((not FPressed) and FMouseInControl and (not FActiveFlat) and (FMouseOver = sbpLeftArrow) and (LeftBtnsEnabled or NoDisableButtons));
      DefDraw := true;
      if OwnerDraw and Assigned(FOnDrawPart) then
      begin
        FOnDrawPart(Self, TmpCanvas, R1, sbpLeftArrow, LeftBtnsEnabled, b, (FPressedIn = sbpLeftArrow) and (FMouseOver = FPressedIn), DefDraw);
      end;
      if DefDraw then
      begin
        if FDrawArrowFrames then
          DrawButtonFrameEx3(TmpCanvas.Handle, R1, b, (FPressedIn = sbpLeftArrow) and (FMouseOver = FPressedIn), Color, ThinFrame, AllBorderSides);
        DrawArrow(TmpCanvas, eadUp, R1, ArrColors[(FMouseOver = sbpLeftArrow)], LeftBtnsEnabled or NoDisableButtons);
      end;
    end;
    end;

    if Self.FShowRightArrows then
    begin
      R1 := R2;
      R1.Top := R1.Bottom - ButtonSize;
      R2.Bottom := R1.Top;
      {$ifdef MSWINDOWS}
      if IsThemeApplied() then
      begin
        if (RightBtnsEnabled or NoDisableButtons) and Enabled then
        begin
          if (FPressedIn = sbpRightArrow) and (FMouseOver = FPressedIn) then
          begin
            iStateId := (ABS_DOWNPRESSED);
          end
          else
          begin
            if (not FPressed) and FMouseInControl and (FMouseOver = sbpRightArrow) then
            begin
              iStateId := (ABS_DOWNHOT);
            end
            else
            begin
              iStateId := (ABS_DOWNNORMAL);
            end;
          end;
        end
        else
        begin
          iStateId := (ABS_DOWNDISABLED);
        end;
        DrawThemeBackground(Theme, TmpCanvas.Handle,  SBP_ARROWBTN, iStateId, R1, @RClip);
      end
      else
      {$endif}
      begin
      FillArrowFrame(R1);
      b := (not Flat) or ((not FPressed) and FMouseInControl and (not FActiveFlat) and (FMouseOver = sbpRightArrow) and (RightBtnsEnabled or NoDisableButtons));
      DefDraw := true;
      if OwnerDraw and Assigned(FOnDrawPart) then
      begin
        FOnDrawPart(Self, TmpCanvas, R1, sbpRightArrow, RightBtnsEnabled, b, (FPressedIn = sbpRightArrow) and (FMouseOver = FPressedIn), DefDraw);
      end;
      if DefDraw then
      begin
        if FDrawArrowFrames then
          DrawButtonFrameEx3(TmpCanvas.Handle, R1, b, (FPressedIn = sbpRightArrow) and (FMouseOver = FPressedIn), Color, ThinFrame, AllBorderSides);
        DrawArrow(TmpCanvas, eadDown, R1, ArrColors[(FMouseOver = sbpRightArrow)], RightBtnsEnabled or NoDisableButtons);
      end;
    end;
    end;

    if FSecondaryButtons then
    begin
      if FShowLeftArrows then
      begin
        R1 := R2;
        R1.Bottom := R1.Top + ButtonSize;
        R2.Top := R1.Bottom;
        {$ifdef MSWINDOWS}
        if (FSecondBtnKind = sbkOpposite) and IsThemeApplied() then
        begin
          if (RightBtnsEnabled or NoDisableButtons) and Enabled then
          begin
            if (FPressedIn = sbpLeftSndArrow) and (FMouseOver = FPressedIn) then
            begin
              iStateId := (ABS_DOWNPRESSED);
            end
            else
            begin
              if (not FPressed) and FMouseInControl and (FMouseOver = sbpLeftSndArrow) then
              begin
                iStateId := (ABS_DOWNHOT);
              end
              else
              begin
                iStateId := (ABS_DOWNNORMAL);
              end;
            end;
          end
          else
          begin
            iStateId := (ABS_DOWNDISABLED);
          end;
          DrawThemeBackground(Theme, TmpCanvas.Handle, SBP_ARROWBTN, iStateId, R1, @RClip);
        end
        else
        {$endif}
        begin
          FillArrowFrame(R1);
          e := (((FSecondBtnKind <> sbkOpposite) and LeftBtnsEnabled) or ((FSecondBtnKind = sbkOpposite) and RightBtnsEnabled) or (FSecondBtnKind = sbkCustom) or NoDisableButtons);
          b := (not Flat) or ((not FPressed) and FMouseInControl and (not FActiveFlat) and (FMouseOver = sbpLeftSndArrow) and e);
          DefDraw := true;
          if OwnerDraw and Assigned(FOnDrawPart) then
          begin
            FOnDrawPart(Self, TmpCanvas, R1, sbpLeftSndArrow, e, b, (FPressedIn = sbpLeftSndArrow) and (FMouseOver = FPressedIn), DefDraw);
          end;
          if DefDraw then
          begin
            {$ifdef MSWINDOWS}
            if IsThemeApplied() then
            begin
              RClip := TmpCanvas.ClipRect;
              if (not e) or (not Enabled) then
              begin
                iStateId := (SCRBS_DISABLED);
              end
              else
              begin
                if (FPressedIn = sbpLeftSndArrow) and (FMouseOver = FPressedIn) then
                begin
                  iStateId := (SCRBS_PRESSED);
                end
                else
                begin
                  if (not FPressed) and FMouseInControl and (FMouseOver = sbpLeftSndArrow) then
                  begin
                    iStateId := (SCRBS_HOT);
                  end
                  else
                  begin
                    iStateId := (SCRBS_NORMAL);
                  end;
                end;
              end;
              DrawThemeBackground(Theme, TmpCanvas.Handle, SBP_THUMBBTNHORZ, iStateId, R1, @RClip);
            end
            else
            {$endif}
            begin
              if FDrawArrowFrames then
                DrawButtonFrameEx3(TmpCanvas.Handle, R1, b, (FPressedIn = sbpLeftSndArrow) and (FMouseOver = FPressedIn), Color, ThinFrame, AllBorderSides);
            end;
            if FSecondBtnKind = sbkPage then
            begin
              OffsetRect(R1, 0, 1);
              DrawArrow(TmpCanvas, eadUp, R1, ArrColors[(FMouseOver = sbpLeftSndArrow)], e);
              OffsetRect(R1, 0, -3);
              DrawArrow(TmpCanvas, eadUp, R1, ArrColors[(FMouseOver = sbpLeftSndArrow)], e);
              OffsetRect(R1, 0, 2);
            end
            else
              DrawArrow(TmpCanvas, eadDown, R1, ArrColors[(FMouseOver = sbpLeftSndArrow)], e);
          end;
        end;
      end;
      if FShowRightArrows then
      begin
        R1 := R2;
        R1.Top := R1.Bottom - ButtonSize;
        R2.Bottom := R1.Top;
        {$ifdef MSWINDOWS}
        if (FSecondBtnKind = sbkOpposite) and IsThemeApplied() then
        begin
          if (LeftBtnsEnabled or NoDisableButtons) and Enabled then
          begin
            if (FPressedIn = sbpRightSndArrow) and (FMouseOver = FPressedIn) then
            begin
              iStateId := (ABS_UPPRESSED);
            end
            else
            begin
              if (not FPressed) and FMouseInControl and (FMouseOver = sbpRightSndArrow) then
              begin
                iStateId := (ABS_UPHOT);
              end
              else
              begin
                iStateId := (ABS_UPNORMAL);
              end;
            end;
          end
          else
          begin
            iStateId := (ABS_UPDISABLED);
          end;
          DrawThemeBackground(Theme, TmpCanvas.Handle, SBP_ARROWBTN, iStateId, R1, @RClip);
        end
        else
        {$endif}
        begin
          FillArrowFrame(R1);
          e := (((FSecondBtnKind <> sbkOpposite) and RightBtnsEnabled) or ((FSecondBtnKind = sbkOpposite) and LeftBtnsEnabled) or (FSecondBtnKind = sbkCustom) or NoDisableButtons);
          b := (not Flat) or ((not FPressed) and FMouseInControl and (not FActiveFlat) and (FMouseOver = sbpRightSndArrow) and e);
          DefDraw := true;
          if OwnerDraw and Assigned(FOnDrawPart) then
          begin
            FOnDrawPart(Self, TmpCanvas, R1, sbpRightSndArrow, e, b, (FPressedIn = sbpRightSndArrow) and (FMouseOver = FPressedIn), DefDraw);
          end;
          if DefDraw then
          begin
            {$ifdef MSWINDOWS}
            if IsThemeApplied() then
            begin
              RClip := TmpCanvas.ClipRect;
              if (not e) or (not Enabled) then
              begin
                iStateId := (SCRBS_DISABLED);
              end
              else
              begin
                if (FPressedIn = sbpRightSndArrow) and (FMouseOver = FPressedIn) then
                begin
                  iStateId := (SCRBS_PRESSED);
                end
                else
                begin
                  if (not FPressed) and FMouseInControl and (FMouseOver = sbpRightSndArrow) then
                  begin
                    iStateId := (SCRBS_HOT);
                  end
                  else
                  begin
                    iStateId := (SCRBS_NORMAL);
                  end;
                end;
              end;
              DrawThemeBackground(Theme, TmpCanvas.Handle, SBP_THUMBBTNHORZ, iStateId, R1, @RClip);
            end
            else
            {$endif}
            begin
              if FDrawArrowFrames then
                DrawButtonFrameEx3(TmpCanvas.Handle, R1, b, (FPressedIn = sbpRightSndArrow) and (FMouseOver = FPressedIn), Color, ThinFrame, AllBorderSides);
            end;
            if FSecondBtnKind = sbkPage then
            begin
              OffsetRect(R1, 0, 2);
              DrawArrow(TmpCanvas, eadDown, R1, ArrColors[(FMouseOver = sbpRightSndArrow)], e);
              OffsetRect(R1, 0, -3);
              DrawArrow(TmpCanvas, eadDown, R1, ArrColors[(FMouseOver = sbpRightSndArrow)], e);
              OffsetRect(R1, 0, 1);
            end
            else
              DrawArrow(TmpCanvas, eadUp, R1, ArrColors[(FMouseOver = sbpRightSndArrow)], e);
          end;
        end;
      end;
    end;

    if FThumbMode = etmFixed then
      ATS := ThumbSize
    else
      ATS := GetAutoThumbSize;
    if (ATS > 0) and Enabled then
    begin

      // first draw the left part of the scroll fields
      DefDraw := true;

      R2.Bottom := FThumbPos;
      if FOwnerDraw and Assigned(FOnDrawPart) then
      begin
        FOnDrawPart(Self, TmpCanvas, R2, sbpLeftTop, Enabled, Focused, (FPressedIn = sbpLeftTop) and (FMouseOver = FPressedIn), DefDraw);
      end;
      if DefDraw then
      begin
        {$ifdef MSWINDOWS}
        if IsThemeApplied() then
        begin
          if (not Enabled) or (not Enabled) then
          begin
            iStateId := (SCRBS_DISABLED);
          end
          else
          begin
            if (FPressedIn = sbpLeftTop) and (FMouseOver = FPressedIn) then
            begin
              iStateId := (SCRBS_PRESSED);
            end
            else
            begin
              if (not FPressed) and FMouseInControl and (FMouseOver = sbpLeftTop) then
              begin
                iStateId := (SCRBS_HOT);
              end
              else
              begin
                iStateId := (SCRBS_NORMAL);
              end;
            end;
          end;
          DrawThemeBackground(Theme, TmpCanvas.Handle, SBP_UPPERTRACKVERT, iStateId, R2, @RClip);
        end
        else
        {$endif}
        begin
          if (FPressedIn = sbpLeftTop) and (FMouseOver = FPressedIn) and ChangeColorsOnScroll then
          begin
            FillShadow(R2);
          end
          else
          begin
            FillBackground(R2);
          end;
        end;
      end;

      R1 := ClientRect;
      R1.Top := FThumbPos;
      R1.Bottom := R1.Top + ATS;
      b := (Focused and (not FActiveFlat)) or (not Flat) or (FMouseInControl and (not FActiveFlat) and ((FMouseOver = sbpThumb) and ((Max >= Min + 1) and (FPage < (Max - Min)))));
      DefDraw := true;
      if FOwnerDraw and Assigned(FOnDrawPart) then
      begin
        FOnDrawPart(Self, TmpCanvas, R1, sbpThumb, Enabled, b, FPressedIn = sbpThumb, DefDraw);
      end;
      if DefDraw then
      begin
        {$ifdef MSWINDOWS}
        if IsThemeApplied() then
        begin
          if (not Enabled) then
          begin
            iStateId := (SCRBS_DISABLED);
          end
          else
          begin
            if (FPressedIn = sbpThumb) then
            begin
              iStateId := (SCRBS_PRESSED);
            end
            else
            begin
              if (not FPressed) and FMouseInControl and (FMouseOver = sbpThumb) then
              begin
                iStateId := (SCRBS_HOT);
              end
              else
              begin
                iStateId := (SCRBS_NORMAL);
              end;
            end;
          end;
          DrawThemeBackground(Theme, TmpCanvas.Handle, SBP_THUMBBTNVERT, iStateId, R1, @RClip);
          if FDrawBars then
          begin
            GetThemeBackgroundContentRect(Theme, TmpCanvas.Handle, SBP_THUMBBTNHORZ, iStateId, R1, R1);
            DrawThemeBackground(Theme, TmpCanvas.Handle, SBP_GRIPPERVERT, iStateId, R1, @RClip);
          end;
        end
        else
        {$endif}
        begin
          TmpCanvas.Brush.Color := Color;
          if not TransBk then
            TmpCanvas.FillRect(R1);
          if FShowBorder then
            DrawButtonFrameEx3(TmpCanvas.Handle, R1, b, (FPressedIn = sbpThumb) and (not NoSunkenThumb), Color, ThinFrame, AllBorderSides);
          if FDrawBars and (ATS > 14) then
          begin
            aH := FBarOffset;
            if FShowBorder then Inc(aH);
            if (b) and (FPressedIn = sbpThumb) and (not NoSunkenThumb) then
              aSh := 1
            else
              aSh := 0;
            if (R1.Right - R1.Left) >= aH + aH + 3 then
            begin
              with R1 do
              begin
                aW := (Bottom + Top) shr 1;
              end;
              Inc(aW, aSh);
              with TmpCanvas do
              begin
                Pen.Color := FBarColor;
                MoveTo(R1.Left + aH + aSh, aW - 1);
                LineTo(R1.Right - aH + aSh, aW - 1);
                MoveTo(R1.Left + aH + aSh, aW - 3);
                LineTo(R1.Right - aH + aSh, aW - 3);
                MoveTo(R1.Left + aH + aSh, aW + 1);
                LineTo(R1.Right - aH + aSh, aW + 1);
                MoveTo(R1.Left + aH + aSh, aW + 3);
                LineTo(R1.Right - aH + aSh, aW + 3);
              end;
            end;
          end;
        end;
      end;

      // then draw the right part of the scroll fields
      R2.Top := FThumbPos + ATS;
      R2.Bottom := ClientHeight;
      Dec(R2.Bottom, ButtonSize * GetBottomBtns);
      if FOwnerDraw and Assigned(FOnDrawPart) then
      begin
        FOnDrawPart(Self, TmpCanvas, R2, sbpRightBottom, Enabled, Focused, (FPressedIn = sbpRightBottom) and (FMouseOver = FPressedIn), DefDraw);
      end;
      if DefDraw then
      begin
        {$ifdef MSWINDOWS}
        if IsThemeApplied() then
        begin
          if (not Enabled) then
          begin
            iStateId := (SCRBS_DISABLED);
          end
          else
          begin
            if (FPressedIn = sbpRightBottom) and (FMouseOver = FPressedIn) then
            begin
              iStateId := (SCRBS_PRESSED);
            end
            else
            begin
              if (not FPressed) and FMouseInControl and (FMouseOver = sbpRightBottom) then
              begin
                iStateId := (SCRBS_HOT);
              end
              else
              begin
                iStateId := (SCRBS_NORMAL);
              end;
            end;
          end;
          DrawThemeBackground(Theme, TmpCanvas.Handle, SBP_LOWERTRACKVERT, iStateId, R2, @RClip);
        end
        else
        {$endif}
        begin
          if (FPressedIn = sbpRightBottom) and (FMouseOver = FPressedIn) and ChangeColorsOnScroll then
          begin
            FillShadow(R2);
          end
          else
          begin
            FillBackground(R2);
          end;
        end;
      end;
    end
    else
    begin
      DefDraw := true;
      if FOwnerDraw and Assigned(FOnDrawPart) then
      begin
        FOnDrawPart(Self, TmpCanvas, R2, sbpNowhere, Enabled, Focused, false, DefDraw);
      end;
      if DefDraw then
      begin
      {$ifdef MSWINDOWS}
        if IsThemeApplied() then
        begin
          iStateId := (SCRBS_DISABLED);
          DrawThemeBackground(Theme, TmpCanvas.Handle, SBP_LOWERTRACKVERT, iStateId, R2, @RClip);
        end
        else
        {$endif}
        if not TransBk then
          FillBackground(R2);
      end;
    end;
  end;
end; { Paint }


procedure TCustomElScrollBar.WMMouseMove(var Msg: TWMMouseMove); { private }
begin
  inherited;
  with Msg do IntmouseMove(XPos, YPos);
end; { WMMouseMove }

procedure TCustomElScrollBar.WMEraseBkgnd(var Msg: TWMEraseBkgnd); { private }
begin
  Msg.Result := 1;
end; { WMEraseBkgnd }

procedure TCustomElScrollBar.Resize; { public }
begin
  if HandleAllocated then
  begin
    FThumbPos := AdjustThumbPos;
    Invalidate;
  end;
{$IFNDEF VCL_4_USED}
  TriggerResizeEvent;
{$ENDIF}
end; { Resize }

procedure TCustomElScrollBar.ShowHintAt(APosition, X, Y: integer);
var
  HintText: TElFString;
  R: TRect;
  P: TPoint;
  mx,
    my: integer;

begin
  P := ClientToScreen(Point(X, Y));
  HintText := '';
  TriggerScrollHintNeededEvent(APosition, HintText);
  if FHintWnd = nil then
    FHintWnd := TElHintWindow.Create(nil);
  FHintWnd.Font.Assign(Font);
  FHintWnd.Font.Color := clInfoText;
  FHintWnd.Font.Charset := Font.Charset;
{$IFDEF HAS_HTML_RENDER}
  FHintWnd.IsHTML := IsHTML and (Copy(HintText, 1, 6) = '<html>');
{$ENDIF}
  FHintWnd.Canvas.Font.Assign(FHintWnd.Font);
{$IFDEF VCL_4_USED}
  mx := Screen.DesktopWidth + Screen.DesktopLeft;
  my := Screen.DesktopHeight + Screen.DesktopTop;
{$ELSE}
  mx := GetSystemMetrics(SM_CXSCREEN);
  my := GetSystemMetrics(SM_CYSCREEN);
{$ENDIF}
  {$ifdef ELPACK_UNICODE}
  R := FHintWnd.CalcHintRectW(mx, HintText, nil);
  {$else}
  R := FHintWnd.CalcHintRect(mx, HintText, nil);
  {$endif}
  OffsetRect(R, P.X - (R.Right - R.Left + 1), P.Y - (R.Bottom - R.Top + 1));
{$IFDEF VCL_4_USED}
  if R.Left < Screen.DesktopLeft then
    OffsetRect(R, Screen.DesktopLeft - R.Left, 0);
  if R.Top < Screen.DesktopTop then
    OffsetRect(R, 0, Screen.DesktopTop - R.Top);
{$ELSE}
  if R.Left < 0 then OffsetRect(R, -R.Left, 0);
  if R.Top < 0 then OffsetRect(R, 0, -R.Top);
{$ENDIF}
  if R.Right > mx then OffsetRect(R, -(R.Right - mx), 0);
  if R.Bottom > my then OffsetRect(R, -(R.Bottom - my), 0);

  FHintWnd.Color := clInfoBk;
  {$ifdef ELPACK_UNICODE}
  FHintWnd.ActivateHintW(R, HintText);
  {$else}
  FHintWnd.ActivateHint(R, HintText);
  {$endif}
end;


procedure TCustomElScrollBar.WMLButtonDown(var Msg: TWMLButtonDown); { private }
begin
  inherited;
  with Msg do
    IntMouseButton(true, mbLeft, XPos, YPos);
end; { WMLButtonDown }

procedure TCustomElScrollBar.WMLButtonUp(var Msg: TWMLButtonUp); { private }
begin
  inherited;
  with Msg do
    IntMouseButton(false, mbLeft, XPos, YPos);
end; { WMLButtonUp }

procedure TCustomElScrollBar.TriggerChangeEvent;
begin
  if (assigned(FOnChange)) then
    FOnChange(Self);
end; { TriggerChangeEvent }

procedure TCustomElScrollBar.TriggerScrollEvent(ScrollCode: TElScrollCode; var ScrollPos: Integer; var DoChange: boolean);
begin
  DoChange := true;
  if (assigned(FOnScroll)) then FOnScroll(Self, ScrollCode, ScrollPos, DoChange);
end; { TriggerScrollEvent }

procedure TCustomElScrollBar.TriggerScrollHintNeededEvent(TrackPosition: integer; var Hint: TElFString);
begin
  if (assigned(FOnScrollHintNeeded)) then
    FOnScrollHintNeeded(Self, TrackPosition, Hint);
end; { TriggerScrollHintNeededEvent }

{$IFNDEF VCL_4_USED}

procedure TCustomElScrollBar.TriggerResizeEvent;
begin
  if (assigned(FOnResize)) then
    FOnResize(Self);
end; { TriggerResizeEvent }
{$ENDIF}

procedure TCustomElScrollBar.WMGetDlgCode(var Msg: TWMGetDlgCode); { private }
begin
  inherited;
  Msg.Result := dlgc_WantArrows; { so we get the arrow keys. }
end; { WMGetDlgCode }

{$WARNINGS OFF}

procedure TCustomElScrollBar.KeyDown(var Key: Word; Shift: TShiftState);
var
  ScrollCode: TElScrollCode;
  NewPos: Integer;
  DoChange: boolean;
begin
  if (Shift = []) then
  begin
    NewPos := Position;
    DoChange := true;
    case Key of
      VK_PRIOR:
        begin
          ScrollCode := escPageUp;
          NewPos := ElTools.Max(FMin, FPosition - FPage);
        end;
      VK_NEXT:
        begin
          ScrollCode := escPageDown;
          NewPos := ElTools.Min(FMax, FPosition + FPage);
        end;
      VK_LEFT, VK_UP:
        begin
          ScrollCode := escLineUp;
          NewPos := ElTools.Max(FMin, FPosition - 1);
        end;
      VK_RIGHT, VK_DOWN:
        begin
          ScrollCode := escLineDown;
          NewPos := ElTools.Min(FMax, FPosition + 1);
        end;
      VK_HOME:
        begin
          ScrollCode := escTop;
          NewPos := FMin;
        end;
      VK_END:
        begin
          ScrollCode := escBottom;
          NewPos := FMax;
        end;
    end;
    TriggerScrollEvent(ScrollCode, NewPos, DoChange);
    if DoChange and (Position <> NewPos) then
    begin
      Position := NewPos;
      TriggerChangeEvent;
    end;
    Key := 0;
  end
  else
    inherited;
end; { KeyDown }
{$WARNINGS ON}

procedure TCustomElScrollBar.WMSize(var Msg: TWMSize); { private }
begin
  inherited;
{$IFNDEF VCL_4_USED}
  Resize;
{$ENDIF}
end; { WMSize }

function TCustomElScrollBar.GetHitTest(X, Y: integer): TElScrollBarPart;
var
  BS: integer;
  CS: integer;
  ATS: integer;
  Default : boolean;
begin
  TriggerHitTestEvent(X, Y, Result, Default);
  if not Default then
    exit;
  if Kind = sbHorizontal then
  begin
    if (Y < 0) or (Y > ClientHeight) then
    begin
      result := sbpNowhere;
      exit;
    end;
    CS := ClientWidth;
    if CS > ButtonSize * (GetTopBtns + GetBottomBtns) then
      BS := ButtonSize
    else
      BS := CS div (GetTopBtns + GetBottomBtns);
    if FShowLeftArrows and InRange(0, BS, X) then
    begin
      result := sbpLeftArrow;
      exit;
    end
    else
      if FShowRightArrows and (CS - X < BS) then
      begin
        result := sbpRightArrow;
        exit;
      end;
    if FSecondaryButtons then
    begin
      if FShowLeftArrows and InRange(BS, BS shl 1, X) then
      begin
        result := sbpLeftSndArrow;
        exit;
      end
      else
        if FShowRightArrows and InRange(CS - BS shl 1, CS - BS, X) then
        begin
          result := sbpRightSndArrow;
          exit;
        end;
    end;

    BS := GetThumbPos;
    if BS = -1 then
    begin
      result := sbpNowhere;
      exit;
    end;
    if X < BS then
    begin
      result := sbpLeftTop;
      exit;
    end;
    if FThumbMode = etmFixed then
      ATS := ThumbSize
    else
      ATS := GetAutoThumbSize;
    if X >= BS + ATS then
    begin
      result := sbpRightBottom;
      exit;
    end;
    result := sbpThumb;
  end
  else
  begin
    if (X < 0) or (X > ClientWidth) then
    begin
      result := sbpNowhere;
      exit;
    end;
    CS := ClientHeight;
    if CS > ButtonSize * (GetTopBtns + GetBottomBtns) then
      BS := ButtonSize
    else
      BS := CS div (GetTopBtns + GetBottomBtns);
    if FShowLeftArrows and InRange(0, BS, Y) then
    begin
      result := sbpLeftArrow;
      exit;
    end
    else
      if Self.FShowRightArrows and (CS - Y < BS) then
      begin
        result := sbpRightArrow;
        exit;
      end;
    if SecondaryButtons then
    begin
      if FShowLeftArrows and InRange(BS, BS shl 1, Y) then
      begin
        result := sbpLeftSndArrow;
        exit;
      end
      else
        if FShowRightArrows and InRange(CS - BS shl 1, CS - BS, Y) then
        begin
          result := sbpRightSndArrow;
          exit;
        end;
    end;
    BS := GetThumbPos;
    if BS = -1 then
    begin
      result := sbpNowhere;
      exit;
    end;
    if Y < BS then
    begin
      result := sbpLeftTop;
      exit;
    end;
    if FThumbMode = etmFixed then
      ATS := ThumbSize
    else
      ATS := GetAutoThumbSize;
    if Y >= BS + ATS then
    begin
      result := sbpRightBottom;
      exit;
    end;
    result := sbpThumb;
  end;
end;

{$WARNINGS OFF}

function TCustomElScrollBar.Control:TWinControl;
begin
  Result := Self;
end;

{$ifdef MSWINDOWS}
function TCustomElScrollBar.ScreenToClient(const Point: TPoint): TPoint;
begin
  Result := inherited ScreenToClient(Point);
end;
{$endif}

procedure TCustomElScrollBar.OnScrollTimer(Sender: TObject);
var
  ScrollCode: TElScrollCode;
  NewPos: Integer;
  DoChange: boolean;
  CP: TPoint;
  FPage: integer;
begin
  FPage := Self.FPage;
  if FPage = 0 then
    FPage := 1;
  FScrollTimer.Interval := GetKeybTimes(SPI_GETKEYBOARDSPEED);
  GetCursorPos(CP);
  CP := ScreenToClient(CP);
  DoChange := true;
  case FPressedIn of
    sbpLeftTop:
      begin
        ScrollCode := escPageUp;
        with CP do
          if GetHitTest(X, Y) = sbpLeftTop then
            NewPos := ElTools.Max(FMin, FPosition - FPage)
          else
            NewPos := Position;
      end;
    sbpRightBottom:
      begin
        ScrollCode := escPageDown;
        with CP do
          if GetHitTest(X, Y) = sbpRightBottom then
            NewPos := ElTools.Min(FMax, FPosition + FPage)
          else
            NewPos := Position;
      end;
    sbpLeftArrow:
      begin
        ScrollCode := escLineUp;
        NewPos := ElTools.Max(FMin, FPosition - FStep);
      end;
    sbpRightArrow:
      begin
        ScrollCode := escLineDown;
        NewPos := ElTools.Min(FMax, FPosition + FStep);
      end;
    sbpRightSndArrow:
      begin
        case FSecondBtnKind of
          sbkOpposite:
            begin
              ScrollCode := escLineUp;
              NewPos := ElTools.Max(FMin, FPosition - FStep);
            end;
          sbkPage:
            begin
              ScrollCode := escPageDown;
              NewPos := ElTools.Min(FMax, FPosition + FPage);
            end;
          sbkCustom:
            begin
              ScrollCode := escSndLineUp;
              NewPos := FPosition;
            end;
        end;
      end;
    sbpLeftSndArrow:
      begin
        case FSecondBtnKind of
          sbkOpposite:
            begin
              ScrollCode := escLineDown;
              NewPos := ElTools.Min(FMax, FPosition + FStep);
            end;
          sbkPage:
            begin
              ScrollCode := escPageUp;
              NewPos := ElTools.Max(FMin, FPosition - FPage);
            end;
          sbkCustom:
            begin
              ScrollCode := escSndLineDown;
              NewPos := FPosition;
            end;
        end;
      end;
  end;
  if (NewPos <> Position) then   begin
    TriggerScrollEvent(ScrollCode, NewPos, DoChange);
    if DoChange and (NewPos <> Position) then
    begin
      Position := NewPos;
      TriggerChangeEvent;
    end;
  end;
end;
{$WARNINGS ON}

function TCustomElScrollBar.GetTopBtns: integer;
begin
  if not FShowLeftArrows then
    result := 0
  else
    if Self.FSecondaryButtons then
      result := 2
    else
      result := 1;
end;

function TCustomElScrollBar.GetBottomBtns: integer;
begin
  if not FShowRightArrows then
    result := 0
  else
    if Self.FSecondaryButtons then
      result := 2
    else
      result := 1;
end;

function TCustomElScrollBar.GetThumbPos: integer;
begin
  result := FThumbPos;
end;

function TCustomElScrollBar.UpdateThumbPos: integer;
var
  CS: integer;
  ATS: integer;
begin
  if Kind = sbHorizontal then
    CS := ClientWidth
  else
    CS := ClientHeight;
  if FThumbMode = etmFixed then
    ATS := ThumbSize
  else
    ATS := GetAutoThumbSize;
  result := MulDiv(FThumbPos - ButtonSize * GetTopBtns, (Max - Min + 1) - ElTools.Min((Page), (Max - Min + 1)), (CS - ButtonSize * (GetTopBtns + GetBottomBtns) - ATS)) + Min;
end;

function TCustomElScrollBar.AdjustThumbPos: integer;
var
  CS: integer;
  ATS: integer;
  XX: integer;
  TB,
    BB: integer;
begin
  if Kind = sbHorizontal then
    CS := ClientWidth
  else
    CS := ClientHeight;
  if FThumbMode = etmFixed then
    ATS := ThumbSize
  else
    ATS := GetAutoThumbSize;
  TB := GetTopBtns;
  BB := GetBottomBtns;
  if (CS > (ButtonSize * (TB + BB) + ATS)) and (Max > Min - 1) then
  begin
    XX := ElTools.Min(Max + 1 - Page, Position) - Min;
    result := ButtonSize * TB
      + ElTools.Max(0, MulDiv((CS - ButtonSize * (TB + BB) - ATS),
      XX, (Max - Min + 1) - ElTools.Min((Page), (Max - Min + 1))));
  end
  else
    result := ButtonSize * TB;
end;

function TCustomElScrollBar.GetButtonSize: integer;
var
  CS: integer;
  AButtonSize : integer;
begin
  if FUseSystemMetrics then
  begin
    if Kind = sbHorizontal then
      AButtonSize := GetSystemMetrics(SM_CXHSCROLL)
    else
      AButtonSize := GetSystemMetrics(SM_CYVSCROLL);
  end
  else
    AButtonSize := FButtonSize;
  if Kind = sbHorizontal then
    CS := ClientWidth
  else
    CS := ClientHeight;
  if CS < AButtonSize * (GetTopBtns + GetBottomBtns) then
    result := CS div (GetTopBtns + GetBottomBtns)
  else
    result := AButtonSize;
end;

{$warnings off}
function TCustomElScrollBar.GetAutoThumbSize: integer;
var
  CS: integer;
  FW: integer;
  TB,
    BB,
    BS: integer;
  APage : Integer;
begin
  APage := FPage;
  {$ifndef MSWINDOWS}
  if (APage = 0) and not
     ((Max < Min + 1) or (APage > (Max - Min))) then
    APage := 1;
  {$endif}
  if Kind = sbHorizontal then
    CS := ClientWidth
  else
    CS := ClientHeight;
  TB := GetTopBtns;
  BB := GetBottomBtns;
  BS := ButtonSize;
  FW := CS - (ButtonSize * (TB + BB));
  if FW < 0 then
    result := 0
  else
  begin
    if (APage = 0) then
    begin
      if (Max < Min + 1) or (APage > (Max - Min)) then
        result := (CS - BS * (TB + BB))
      else
        if Kind = sbHorizontal then
          result := GetSystemMetrics(SM_CXHTHUMB)
        else
          result := GetSystemMetrics(SM_CYVTHUMB);
    end
    else
    begin
      if (Max < Min + 1) or (APage > (Max - Min)) then
        result := (CS - BS * (TB + BB))
      else
        result := MulDiv(ElTools.Min(APage, (Max - Min + 1)), (CS - BS * (TB + BB)), (Max - Min + 1));
    end;
    if Result < FMinThumbSize then
      Result := FMinThumbSize;
    if Result > FW then
      result := 0;
  end;
end;
{$warnings on}

procedure TCustomElScrollBar.SetButtonSize(newValue: Integer);
{ Sets data member FButtonSize to newValue. }
begin
  if (FButtonSize <> newValue) and (newValue > 0) then
  begin
    if (not HandleAllocated) or (((kind = sbHorizontal) and (newValue shl 1 <= ClientWidth)) or ((kind = sbVertical) and (newValue shl 1 <= ClientHeight))) then
    begin
      FButtonSize := newValue;
      if (not (csLoading in ComponentState)) and HandleAllocated then
      begin
        FThumbPos := AdjustThumbPos;
        Invalidate;
      end;
    end;
  end; { if }
end; { SetButtonSize }

procedure TCustomElScrollBar.SetThumbMode(newValue: TElScrollThumbMode);
{ Sets data member FThumbMode to newValue. }
begin
  if (FThumbMode <> newValue) then
  begin
    FThumbMode := newValue;
    if UseSystemMetrics and (ThumbMode = etmFixed) then
    begin
      if Kind = sbHorizontal then
        ThumbSize := GetSystemMetrics(SM_CXHTHUMB)
      else
        ThumbSize := GetSystemMetrics(SM_CYVTHUMB);
    end;
    if (not (csLoading in ComponentState)) and HandleAllocated then
    begin
      FThumbPos := AdjustThumbPos;
      Invalidate;
    end;
  end; { if }
end; { SetThumbMode }

procedure TCustomElScrollBar.SetThumbSize(newValue: Integer);
begin
  if (FThumbSize <> newValue) and (newValue > 0) then
  begin
    FThumbSize := newValue;
    if (not (csLoading in ComponentState)) and HandleAllocated then
    begin
      FThumbPos := AdjustThumbPos;
      Invalidate;
    end;
  end; { if }
end; { SetThumbSize }

procedure TCustomElScrollBar.SetMinThumbSize(newValue: Integer);
{ Sets data member FMinThumbSize to newValue. }
begin
  if (FMinThumbSize <> newValue) and (newValue > 0) then
  begin
    FMinThumbSize := newValue;
    if (ThumbMode = etmAuto) and (not (csLoading in ComponentState)) and HandleAllocated then
    begin
      FThumbPos := AdjustThumbPos;
      Invalidate;
    end;
  end; { if }
end; { SetMinThumbSize }

procedure TCustomElScrollBar.SetPage(newValue: Integer);
{ Sets data member FPage to newValue. }
begin
  DoSetPage(newValue, not (csLoading in ComponentState) and HandleAllocated);
end; { SetPage }

procedure TCustomElScrollBar.SetSecondaryButtons(newValue: Boolean);
{ Sets data member FSecondaryButtons to newValue. }
begin
  if (FSecondaryButtons <> newValue) then
  begin
    FSecondaryButtons := newValue;
    if (not (csLoading in ComponentState)) and HandleAllocated then
    begin
      FThumbPos := AdjustThumbPos;
      Invalidate;
    end;
  end; { if }
end; { SetSecondaryButtons }

procedure TCustomElScrollBar.SetSecondBtnKind(newValue: TElSecButtonsKind);
begin
  if newValue <> FSecondBtnKind then
  begin
    FSecondBtnKind := newValue;
    if FSecondaryButtons and (not (csLoading in ComponentState)) and HandleAllocated then Invalidate;
  end;
end;

procedure TCustomElScrollBar.SetOwnerDraw(newValue: Boolean);
{ Sets data member FOwnerDraw to newValue. }
begin
  if (FOwnerDraw <> newValue) then
  begin
    FOwnerDraw := newValue;
    Invalidate;
  end; { if }
end; { SetOwnerDraw }

procedure TCustomElScrollBar.Loaded; { protected }
begin
  inherited;
  if FMin >= FMax then FMax := FMin;
  FPage := ElTools.Min(FPage, FMax - FMin + 1);
  if FPosition < FMin then
    FPosition := FMin
  else
    if FPosition > FMax then FPosition := FMax;
  if UseSystemMetrics then
  begin
    FUseSystemMetrics := false;
    UseSystemMetrics := true;
  end;
  FThumbPos := AdjustThumbPos;
  if HandleAllocated then Invalidate;
end; { Loaded }

type
  PScrollInfo = ^TScrollInfo;

procedure TCustomElScrollBar.SBMSetScrollInfo(var Msg: TMessage); { private }
var
  ScrollInfo: PScrollInfo;
  Redraw: BOOL;
begin
  with Msg do
  begin
    ScrollInfo := PScrollInfo(lParam);
    Redraw := BOOL(wParam);
  end;
  Msg.Result := SetScrollInfo(ScrollInfo^, Redraw);
end; { SBMSetScrollInfo }

procedure TCustomElScrollBar.SBMGetScrollInfo(var Msg: TMessage); { private }
var
  ScrollInfo: PScrollInfo;
begin
  ScrollInfo := PScrollInfo(Msg.lParam);
  Msg.Result := Integer(GetScrollInfo(ScrollInfo^));
end; { SBMGetScrollInfo }

procedure TCustomElScrollBar.SetNoDisableButtons(newValue: Boolean);
{ Sets data member FNoDisableButtons to newValue. }
begin
  if (FNoDisableButtons <> newValue) then
  begin
    FNoDisableButtons := newValue;
    Invalidate;
  end; { if }
end; { SetNoDisableButtons }

procedure TCustomElScrollBar.UpdateScrollingRegion;
var
  R: TRect;
begin
  R := ClientRect;
  if Kind = sbHorizontal then
  begin
    R.Left := R.Left + ButtonSize * GetTopBtns;
    R.Right := R.Right - ButtonSize * GetBottomBtns;
  end
  else
  begin
    R.Top := R.Top + ButtonSize * GetTopBtns;
    R.Bottom := R.Bottom - ButtonSize * GetBottomBtns;
  end;
  InvalidateRect(Handle, @R, false);
  Update;
end;

procedure TCustomElScrollBar.CreateWnd; { protected }
begin
  inherited;
  FThumbPos := AdjustThumbPos;
end; { CreateWnd }


procedure TCustomElScrollBar.WMPaint(var Msg: TWMPaint); { private }
var
  DC, MemDC: HDC;
  MemBitmap, OldBitmap: HBITMAP;
  PS: TPaintStruct;
  R: TRect;
begin
  if (Msg.DC <> 0) then
    PaintHandler(Msg)
  else
  begin
    DC := GetDC(0);
    MemBitmap := CreateCompatibleBitmap(DC, ClientRect.Right, ClientRect.Bottom);
    ReleaseDC(0, DC);
    MemDC := CreateCompatibleDC(0);
    OldBitmap := SelectObject(MemDC, MemBitmap);
    try
      DC := BeginPaint(Handle, PS);
      GetClipBox(DC, R);
      if IsRectEmpty(R) then
        R := ClientRect;
      InvalidateRect(MemDC, @R, false);
      Perform(WM_ERASEBKGND, MemDC, MemDC);
      Msg.DC := MemDC;
      WMPaint(Msg);
      Msg.DC := 0;
      GetClipBox(DC, R);
      if IsRectEmpty(R) then R := ClientRect;
      with R do
        BitBlt(DC, Left, Top, Right, Bottom, MemDC, Left, Top, SRCCOPY);
      EndPaint(Handle, PS);
    finally
      SelectObject(MemDC, OldBitmap);
      DeleteDC(MemDC);
      DeleteObject(MemBitmap);
    end;
  end;
end;

function TCustomElScrollBar.GetIsDesigning: boolean;
begin
  result := csDesigning in ComponentState;
end;

procedure TCustomElScrollBar.SetIsDesigning(newValue: Boolean);
begin
  SetDesigning(newValue);
end; { SetIsDesigning }

procedure TCustomElScrollBar.SetBlendBackground(newValue: boolean);
begin
  if (FBlendBackground <> newValue) then
  begin
    FBlendBackground := newValue;
    if HandleAllocated then
      Invalidate;
  end; { if }
end; { SetBlendBackground }

procedure TCustomElScrollBar.WMSysColorChange(var Msg: TWMSysColorChange); { private }
begin
  inherited;
  RebuildBackground;
end; { WMSysColorChange }

procedure TCustomElScrollBar.SetShowLeftArrows(newValue: Boolean);
{ Sets data member FShowLeftArrows to newValue. }
begin
  if (FShowLeftArrows <> newValue) then
  begin
    FShowLeftArrows := newValue;
    if (not (csLoading in ComponentState)) and HandleAllocated then
    begin
      FThumbPos := AdjustThumbPos;
      Invalidate;
    end;
  end; { if }
end; { SetShowLeftArrows }

procedure TCustomElScrollBar.SetShowRightArrows(newValue: Boolean);
{ Sets data member FShowRightArrows to newValue. }
begin
  if (FShowRightArrows <> newValue) then
  begin
    FShowRightArrows := newValue;
    if (not (csLoading in ComponentState)) and HandleAllocated then
    begin
      FThumbPos := AdjustThumbPos;
      Invalidate;
    end;
  end; { if }
end; { SetShowRightArrows }

procedure TCustomElScrollBar.SetUseSystemMetrics(value: boolean);
  {$ifndef MSWINDOWS}
  var AVal : TSize;
  {$endif}
begin
  if FUseSystemMetrics <> value then
  begin
    FUseSystemMetrics := value;
    if (csLoading in ComponentState) or
       ((Owner <> nil) and (csLoading in Owner.ComponentState)) then exit;
    if Value then
    begin
      if Kind = sbHorizontal then
      begin
        {$ifdef MSWINDOWS}
        begin
          ButtonSize := GetSystemMetrics(SM_CXHSCROLL);
          Height := GetSystemMetrics(SM_CXVSCROLL);
        end;
        {$else}
        ButtonSize := GetButtonSize;
        QStyle_scrollBarExtent(Application.Style.Handle, @AVal);
        Height := AVal.cy;
        {$endif}
      end
      else
      begin
        {$ifdef MSWINDOWS}
        begin
          ButtonSize := GetSystemMetrics(SM_CYVSCROLL);
          Width := GetSystemMetrics(SM_CYHSCROLL);
        end;
        {$else}
        ButtonSize := GetButtonSize;
        QStyle_scrollBarExtent(Application.Style.Handle, @AVal);
        Width := AVal.cx;
        {$endif}
      end;
      if HandleAllocated then
      begin
        FThumbPos := AdjustThumbPos;
        Invalidate;
      end;
    end
    else
      if HandleAllocated then
      begin
        FThumbPos := AdjustThumbPos;
        Invalidate;
      end;
  end;
end;

procedure TCustomElScrollBar.SetNoSunkenThumb(newValue: Boolean);
{ Sets data member FNoSunkenThumb to newValue. }
begin
  if (FNoSunkenThumb <> newValue) then
  begin
    FNoSunkenThumb := newValue;
    if FPressedIn = sbpThumb then Invalidate;
  end; { if }
end;

{$IFDEF ELPACK_USE_IMAGEFORM}
procedure TCustomElScrollBar.ImageFormChange(Sender: TObject);
begin
  Invalidate;
end;

procedure TCustomElScrollBar.SetImageForm(newValue: TElImageForm);
{ Sets data member FImageForm to newValue. }
begin
  if FImgForm <> newValue then
  begin
    if FImgForm <> nil then
    begin
      {$ifdef VCL_5_USED}
      if not (csDestroying in FImgForm.ComponentState) then
        FImgForm.RemoveFreeNotification(Self);
      {$endif}
      FImgForm.UnregisterChanges(FImgFormChLink);
    end;
    FImgForm := newValue;
    if FImgForm <> nil then
    begin
      FImgForm.RegisterChanges(FImgFormChLink);
      FImgForm.FreeNotification(Self);
    end;
    Invalidate;
  end;
end; { SetImageForm }
{$ENDIF}

procedure TCustomElScrollBar.Notification(AComponent: TComponent; Operation: TOperation); { protected }
begin
  inherited;
{$IFDEF ELPACK_USE_IMAGEFORM}
  if AComponent = FImgForm then
  begin
    ImageForm := nil;
    Invalidate;
  end;
{$ENDIF}
end; { Notification }

procedure TCustomElScrollBar.SetArrowColor(newValue: TColor);
{ Sets data member FArrowColor to newValue. }
begin
  if (FArrowColor <> newValue) then
  begin
    FArrowColor := newValue;
    Invalidate;
  end; { if }
end; { SetArrowColor }

procedure TCustomElScrollBar.SetArrowHotTrackColor(newValue: TColor);
{ Sets data member FArrowHotTrackColor to newValue. }
begin
  if (FArrowHotTrackColor <> newValue) then
  begin
    FArrowHotTrackColor := newValue;
    Invalidate;
  end; { if }
end; { SetArrowHotTrackColor }

procedure TCustomElScrollBar.SetShowBorder(newValue: Boolean);
{ Sets data member FShowBorder to newValue. }
begin
  if (FShowBorder <> newValue) then
  begin
    FShowBorder := newValue;
    if not newValue then FDrawArrowFrames := False;
    Invalidate;
  end; { if }
end; { SetShowBorder }

procedure TCustomElScrollBar.SetThinFrame(newValue: Boolean);
{ Sets data member FThinFrame to newValue. }
begin
  if (FThinFrame <> newValue) then
  begin
    FThinFrame := newValue;
    Invalidate;
  end; { if }
end; { SetThinFrame }

procedure TCustomElScrollBar.CMColorChanged(var Msg: TMessage); { private }
begin
  inherited;
  IntColorChanged;
end; { CMColorChanged }

destructor TCustomElScrollBar.Destroy;
begin
  FScrollTimer.Free;
{$IFDEF ELPACK_USE_IMAGEFORM}
  ImageForm := nil;
  FImgFormChLink.Free;
{$ENDIF}
  inherited;
end; { Destroy }

constructor TCustomElScrollBar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ParentColor := False;
  Color := clBtnFace;
  FScrollTimer := TTimer.Create(nil);
  FScrollTimer.Enabled := false;
  FScrollTimer.OnTimer := OnScrollTimer;
  Width := 121;
  ControlStyle := [csOpaque, csFramed];
  Height := GetSystemMetrics(SM_CYHSCROLL);
  TabStop := True;
  FKind := sbHorizontal;
  FFlat := true;
  FMinThumbSize := 4;
  FThumbMode := etmAuto;
  FPosition := 0;
  FMin := 0;
  FMax := 100;
  FPage := 14;
  FTrackPos := -1;
  FStep := 1;
  Ctl3D := false;
  //FButtonSize := GetSystemMetrics(SM_CYHSCROLL);
  BlendBackground := true;
  FShowLeftArrows := True;
  FShowRightArrows := true;
  FChangeColorsOnScroll := True;

  UseSystemMetrics := true;
  FArrowColor := clBtnText;
  FArrowHotTrackColor := clHighlight;

  FHintColor := clInfoBk;
  FHintTextColor := clInfoText;

  FSysBkColor := true;
  FShowBorder := true;
  FDrawArrowFrames := true;
  FDrawBars := true;
  FBarOffset := 2;
  FBarColor := clBtnShadow;
{$IFDEF ELPACK_USE_IMAGEFORM}
  FImgFormChLink := TImgFormChangeLink.Create;
  FImgFormChLink.OnChange := ImageFormChange;
{$ENDIF}
  if FBlendBitmap = nil then
  begin
    FBitmapOwner := true;
    FBlendBitmap := TBitmap.Create;
    FBlendBitmap.Width := 8;
    FBlendBitmap.Height := 8;
  end;

  RebuildBackground;
end; { Create }

procedure TCustomElScrollBar.EndScroll;
var NewPos   : integer;
    DoChange : boolean;
begin
  FScrollTimer.Enabled := false;
  if FSaveCapture <> 0 then
    SetCapture(FSaveCapture)
  else
    ReleaseCapture;
  FSaveCapture := 0;
  FPressed := false;
  if FPressedIn = sbpThumb then
  begin
    if FHintWnd <> nil then
    begin
      FHintWnd.Free;
      FHintWnd := nil;
    end;
    NewPos := UpdateThumbPos;
    TriggerScrollEvent(escPosition, NewPos, DoChange);
    if DoChange then
    begin
      Position := NewPos;
      TriggerChangeEvent;
    end;
    FThumbPos := AdjustThumbPos;
  end else
  if FPressedIn <> sbpNowhere then
  begin
    NewPos := Position;
    TriggerScrollEvent(escEndScroll, NewPos, DoChange);
    if DoChange then
    begin
      Position := NewPos;
      TriggerChangeEvent;
    end;
    FThumbPos := AdjustThumbPos;
  end;
  FPressedIn := sbpNowhere;
  Invalidate;
end;

function TCustomElScrollBar.RightBtnsEnabled: Boolean;
begin
  if FAltDisablingArrows then
  begin
    Result := (Position < FMax - FPage + 1) and (Page <= FMax - FMin);
  end
  else
    Result := (Position < FMax) and (Page <= FMax - FMin);
end;

function TCustomElScrollBar.LeftBtnsEnabled: Boolean;
begin
  Result := (Position > Min) and (Page <= FMax - FMin);
end;

procedure TCustomElScrollBar.SetSysBkColor(Value: boolean);
begin
  if FSysBkColor <> Value then
  begin
    FSysBkColor := Value;
    Invalidate;
  end;
end;


procedure TCustomElScrollBar.RebuildBackground;
var i, j : integer;
begin
  if FBitmapOwner then
  begin
    with FBlendBitmap.Canvas do
    begin
      for i := 0 to 7 do
        for j := 0 to 7 do
          if ((j xor i) and 1) <> 0 then
            Pixels[i, j] := Color
          else
            Pixels[i, j] := LighterColor;
    end;
  end;
end;

procedure TCustomElScrollBar.SetAltDisablingArrows(const Value: Boolean);
begin
  if FAltDisablingArrows <> Value then
  begin
    FAltDisablingArrows := Value;
    Invalidate;
  end;
end;

function TCustomElScrollBar.GetThumbSize: Integer;
begin
  Result := FThumbSize;

  if FUseSystemMetrics then
  begin
    if Kind = sbHorizontal then
    begin
      if ThumbMode = etmFixed then
        result := GetSystemMetrics(SM_CXHTHUMB);
    end
    else
    begin
      if ThumbMode = etmFixed then
        result := GetSystemMetrics(SM_CYVTHUMB);
    end;

  end;
end;

procedure TCustomElScrollBar.SetDrawArrowFrames(const Value: Boolean);
begin
  if (FDrawArrowFrames <> Value) then
  begin
    FDrawArrowFrames := Value;
    Invalidate;
  end; { if }
end;

procedure TCustomElScrollBar.SetDrawBars(const Value: Boolean);
begin
  if (FDrawBars <> Value) then
  begin
    FDrawBars := Value;
    Invalidate;
  end; { if }
end;

procedure TCustomElScrollBar.SetBarColor(const Value: TColor);
begin
  if (FBarColor <> Value) then
  begin
    FBarColor := Value;
    Invalidate;
  end; { if }
end;

procedure TCustomElScrollBar.SetBarOffset(const Value: Cardinal);
begin
  if (FBarOffset <> Value) then
  begin
    FBarOffset := Value;
    Invalidate;
  end; { if }
end;

procedure TCustomElScrollBar.TriggerHitTestEvent(X, Y : integer; var Part :
    TElScrollBarPart; var DefaultTest : boolean);
begin
  DefaultTest := true;
  if assigned(OnHitTest) then
    OnHitTest(Self, X, Y, Part, DefaultTest);
end;

{$IFDEF ELPACK_USE_IMAGEFORM}
procedure TCustomElScrollBar.IFMRepaintChildren(var Message: TMessage);
begin
  inherited;
  if (not (csDesigning in ComponentState)) and (ImageForm <> nil) then
    Invalidate;
  Broadcast(Message);
end;
{$endif}

procedure TCustomElScrollBar.WMWindowPosChanged(var Message:
    TWMWindowPosChanged);
begin
  inherited;
  {$IFDEF ELPACK_USE_IMAGEFORM}
  Perform(IFM_REPAINTCHILDREN, 0, 0);
  {$endif}
end;

procedure TCustomElScrollBar.WMMouseWheel(var Msg: TMessage);
var
  Dy, i, sl  : integer;
  ScrollCode : TElScrollCode;
  NewPos     : integer;
  DoChange   : boolean;
begin
  inherited;
  if IsWinNTUp or IsWin98Up then
    SystemParametersInfo(SPI_GETWHEELSCROLLLINES, 0, @sl, SPIF_SENDCHANGE)
  else
    sl := 3;

  if sl = 0 then sl := 1;
  Dy := TWMMouseWheel(Msg).WheelDelta div (MOUSE_WHEEL_DELTA div sl);
  if Dy <> 0 then
  begin
    DoChange := true;
    for i := 1 to Abs(Dy) do
    begin
      NewPos := Position - Sign(Dy);
      if Dy > 0 then
        ScrollCode := escLineDown
      else
        ScrollCode := escLineUp;
      TriggerScrollEvent(ScrollCode, NewPos, DoChange);
      if DoChange then
        Position := NewPos
      else
        Break;
    end;
    NewPos := Position;
    DoChange := true;
    ScrollCode := escEndScroll;
    TriggerScrollEvent(ScrollCode, NewPos, DoChange);
    if DoChange and (NewPos <> Position) then
    begin
      Position := NewPos;
      TriggerChangeEvent;
    end;
  end;
end; { WMMouseWheel }

function TCustomElScrollBar.GetThemedClassName: WideString;
begin
  Result := 'SCROLLBAR';
end;

procedure TCustomElScrollBar.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  if IsThemeApplied then Invalidate;
end;

function TCustomElScrollBar.GetScrollInfo(var ScrollInfo: TScrollInfo): BOOL;
begin
  if ScrollInfo.cbSize < sizeof(TScrollInfo) then
  begin
    Result := BOOL(0);
    exit;
  end;
  with ScrollInfo do
  begin
    if (fMask and SIF_PAGE) <> 0 then nPage := FPage;
    if (fMask and SIF_POS) <> 0 then nPos := FPosition;
    if (fMask and SIF_TRACKPOS) <> 0 then nTrackPos := UpdateThumbPos;
    if (fMask and SIF_RANGE) <> 0 then
    begin
      nMin := FMin;
      nMax := FMax;
    end;
  end; { with }
  Result := BOOL(1);
end;

function TCustomElScrollBar.SetScrollInfo(ScrollInfo: TScrollInfo;
    Redraw: BOOL): Integer;
begin
  if ScrollInfo.cbSize < sizeof(TScrollInfo) then
  begin
    Result := Position;
    exit;
  end;
  with ScrollInfo do
  begin
    if (fMask and SIF_RANGE) <> 0 then
    begin
      if (nMin <= nMax) then
      begin
        if (fMask and SIF_POS) <> 0 then
        begin
          if not InRange(nMin, nMax, nPos) then nPos := nMax;
          begin
            FPosition := nPos;
            FMin := nMin;
            FMax := nMax;

            if (fMask and SIF_PAGE) <> 0 then
            begin
              FPage := nPage;
            end;
            FThumbPos := AdjustThumbPos;
          end;
        end
        else
        begin
          if InRange(nMin, nMax, FPosition) then
          begin
            FMin := nMin;
            FMax := nMax;
            if (fMask and SIF_PAGE) <> 0 then
            begin
              {if nPage < (FMax - FMin) then } FPage := nPage;
            end;
          end;
        end;
        FThumbPos := AdjustThumbPos;
        if Redraw then Invalidate;
      end;
    end
    else
      if (fMask and SIF_POS) <> 0 then
      begin
        if InRange(FMin, FMax, nPos) then
        begin
          if (fMask and SIF_PAGE) <> 0 then
          begin
          {if nPage < (FMax - FMin) then } FPage := nPage;
          end;
          FPosition := nPos;
          FThumbPos := AdjustThumbPos;
          if Redraw then Invalidate;
        end;
      end
      else
        if (fMask and SIF_PAGE) <> 0 then
        begin
      // if nPage < (FMax - FMin) then
          begin
            FPage := nPage;
            FThumbPos := AdjustThumbPos;
            if Redraw then Invalidate;
          end;
        end;
  end;
  Result := Position;
end;

{$ifdef ELPACK_UNICODE}
procedure TCustomElScrollBar.CMHintShow(var Message: TMessage);
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

procedure TCustomElScrollBar.SetHint(Value: TElFString);
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
{$ifdef MSWINDOWS}
procedure TCustomElScrollBar.ELThemeChanged(var Message: TMessage);
begin
  inherited;
  if UseSystemMetrics then
  begin
    FUseSystemMetrics := false;
    UseSystemMetrics := true;
  end;
end;
{$endif}
procedure TElScrollBarStyles.SetActiveFlat(newValue: Boolean);
begin
  FElScrollBar.ActiveFlat := newValue;
end; { SetActiveFlat }

function TElScrollBarStyles.GetActiveFlat: Boolean;
{ Returns the ActiveFlat property from the FElScrollBar subcomponent. }
begin
  GetActiveFlat := FElScrollBar.ActiveFlat;
end; { GetActiveFlat }

procedure TElScrollBarStyles.SetColor(newValue: TColor);
{ Sets the FElScrollBar subcomponent's Color property to newValue. }
begin
  FElScrollBar.Color := newValue;
end; { SetFElScrollBarColor }

function TElScrollBarStyles.GetColor: TColor;
{ Returns the Color property from the FElScrollBar subcomponent. }
begin
  GetColor := FElScrollBar.Color;
end; { GetFElScrollBarColor }

procedure TElScrollBarStyles.SetFlat(newValue: Boolean);
{ Sets the FElScrollBar subcomponent's Flat property to newValue. }
begin
  FElScrollBar.Flat := newValue;
end; { SetFlat }

function TElScrollBarStyles.GetFlat: Boolean;
{ Returns the Flat property from the FElScrollBar subcomponent. }
begin
  GetFlat := FElScrollBar.Flat;
end; { GetFlat }

procedure TElScrollBarStyles.SetMinThumbSize(newValue: Integer);
{ Sets the FElScrollBar subcomponent's MinThumbSize property to newValue. }
begin
  FElScrollBar.MinThumbSize := newValue;
end; { SetMinThumbSize }

function TElScrollBarStyles.GetMinThumbSize: Integer;
{ Returns the MinThumbSize property from the FElScrollBar subcomponent. }
begin
  GetMinThumbSize := FElScrollBar.MinThumbSize;
end; { GetMinThumbSize }

procedure TElScrollBarStyles.SetOwnerDraw(newValue: Boolean);
{ Sets the FElScrollBar subcomponent's OwnerDraw property to newValue. }
begin
  FElScrollBar.OwnerDraw := newValue;
end; { SetOwnerDraw }

function TElScrollBarStyles.GetOwnerDraw: Boolean;
{ Returns the OwnerDraw property from the FElScrollBar subcomponent. }
begin
  GetOwnerDraw := FElScrollBar.OwnerDraw;
end; { GetOwnerDraw }

procedure TElScrollBarStyles.SetSecondaryButtons(newValue: Boolean);
{ Sets the FElScrollBar subcomponent's SecondaryButtons property to newValue. }
begin
  FElScrollBar.SecondaryButtons := newValue;
end; { SetSecondaryButtons }

function TElScrollBarStyles.GetSecondaryButtons: Boolean;
{ Returns the SecondaryButtons property from the FElScrollBar subcomponent. }
begin
  GetSecondaryButtons := FElScrollBar.SecondaryButtons;
end; { GetSecondaryButtons }

procedure TElScrollBarStyles.SetSecondBtnKind(newValue: TElSecButtonsKind);
{ Sets the FElScrollBar subcomponent's SecondBtnKind property to newValue. }
begin
  FElScrollBar.SecondBtnKind := newValue;
end; { SetSecondBtnKind }

function TElScrollBarStyles.GetSecondBtnKind: TElSecButtonsKind;
{ Returns the SecondBtnKind property from the FElScrollBar subcomponent. }
begin
  GetSecondBtnKind := FElScrollBar.SecondBtnKind;
end; { GetSecondBtnKind }

procedure TElScrollBarStyles.SetShowTrackHint(newValue: Boolean);
{ Sets the FElScrollBar subcomponent's ShowTrackHint property to newValue. }
begin
  FElScrollBar.ShowTrackHint := newValue;
end; { SetShowTrackHint }

function TElScrollBarStyles.GetShowTrackHint: Boolean;
{ Returns the ShowTrackHint property from the FElScrollBar subcomponent. }
begin
  GetShowTrackHint := FElScrollBar.ShowTrackHint;
end; { GetShowTrackHint }

procedure TElScrollBarStyles.SetThumbMode(newValue: TElScrollThumbMode);
{ Sets the FElScrollBar subcomponent's ThumbMode property to newValue. }
begin
  FElScrollBar.ThumbMode := newValue;
end; { SetThumbMode }

function TElScrollBarStyles.GetThumbMode: TElScrollThumbMode;
{ Returns the ThumbMode property from the FElScrollBar subcomponent. }
begin
  GetThumbMode := FElScrollBar.ThumbMode;
end; { GetThumbMode }

procedure TElScrollBarStyles.SetThumbSize(newValue: Integer);
{ Sets the FElScrollBar subcomponent's ThumbSize property to newValue. }
begin
  FElScrollBar.ThumbSize := newValue;
end; { SetThumbSize }

function TElScrollBarStyles.GetThumbSize: Integer;
{ Returns the ThumbSize property from the FElScrollBar subcomponent. }
begin
  GetThumbSize := FElScrollBar.ThumbSize;
end; { GetThumbSize }

resourcestring
  esbsNoControl = 'No scrollbar specified when attempting to create TElScrollBarStyles instance';

procedure TElScrollBarStyles.Assign(Source: TPersistent);
begin
  if Source is TElScrollBarStyles then
    with TElScrollBarStyles(Source) do
    begin
      Self.ActiveFlat := ActiveFlat;
      Self.BlendBackground := BlendBackground;
      Self.Color := Color;
      Self.Flat := Flat;
      Self.MinThumbSize := MinThumbSize;
      Self.OwnerDraw := OwnerDraw;
      Self.SecondaryButtons := SecondaryButtons;
      Self.SecondBtnKind := SecondBtnKind;
      Self.ShowTrackHint := ShowTrackHint;
      Self.ThumbMode := ThumbMode;
      Self.ThumbSize := ThumbSize;
    end
  else
    inherited;
end;

function TElScrollBarStyles.GetBlendBackground: Boolean;
{ Returns the value of data member FBlendBackground. }
begin
  result := FElScrollBar.BlendBackground;
end; { GetBlendBackground }

procedure TElScrollBarStyles.SetBlendBackground(newValue: Boolean);
{ Sets data member FBlendBackground to newValue. }
begin
  FElScrollBar.BlendBackground := newValue;
end; { SetBlendBackground }

function TElScrollBarStyles.GetUseSystemMetrics: boolean;
begin
  result := FElScrollBar.UseSystemMetrics;
end;

procedure TElScrollBarStyles.SetUseSystemMetrics(Value: boolean);
begin
  if FElScrollBar.UseSystemMetrics <> Value then
  begin
    FElScrollBar.UseSystemMetrics := Value;
    if Assigned(FOnChange) then FOnChange(Self);
  end;
end;

function TElScrollBarStyles.GetWidth : Integer;
begin
  if FElScrollBar.FKind = sbHorizontal then
    result := FElScrollBar.Height
  else
    result := FElScrollBar.Width;
end; { GetWidth }

procedure TElScrollBarStyles.SetWidth(newValue : Integer);
begin
  if UseSystemMetrics and not (csLoading in FOwner.ComponentState) then
  begin
    UseSystemMetrics := false;
    UseSystemMetrics := true;
  end
  else
  begin
    if FElScrollBar.FKind = sbHorizontal then
      FElScrollBar.Height := newValue
    else
      FElScrollBar.Width := newValue;
  end;
  if Assigned(FOnChange) then FOnChange(Self);
end; { SetWidth }

function TElScrollBarStyles.GetShowLeftArrows: Boolean;
{ Returns the value of data member FShowLeftArrows. }
begin
  result := FElScrollBar.ShowLeftArrows;
end; { GetShowLeftArrows }

procedure TElScrollBarStyles.SetShowLeftArrows(newValue: Boolean);
{ Sets data member FShowLeftArrows to newValue. }
begin
  FElScrollBar.ShowLeftArrows := newValue;
end; { SetShowLeftArrows }

function TElScrollBarStyles.GetShowRightArrows: Boolean;
{ Returns the value of data member FShowRightArrows. }
begin
  result := FElScrollBar.ShowRightArrows;
end; { GetShowRightArrows }

procedure TElScrollBarStyles.SetShowRightArrows(newValue: Boolean);
{ Sets data member FShowRightArrows to newValue. }
begin
  FElScrollBar.ShowRightArrows := newValue;
end; { SetShowRightArrows }

function TElScrollBarStyles.GetNoSunkenThumb: Boolean;
{ Returns the value of data member FNoSunkenThumb. }
begin
  result := FElScrollBar.NoSunkenThumb;
end; { GetNoSunkenThumb }

procedure TElScrollBarStyles.SetNoSunkenThumb(newValue: Boolean);
{ Sets data member FNoSunkenThumb to newValue. }
begin
  FElScrollBar.NoSunkenThumb := newValue;
end; { SetNoSunkenThumb }

function TElScrollBarStyles.GetNoDisableButtons: Boolean;
begin
  result := FElScrollBar.NoDisableButtons;
end;

procedure TElScrollBarStyles.SetNoDisableButtons(newValue: Boolean);
begin
  FElScrollBar.NoDisableButtons := newValue;
end; { SetNoDisableButtons }

function TElScrollBarStyles.GetButtonSize: integer;
begin
  result := FElScrollBar.ButtonSize;
end;

procedure TElScrollBarStyles.SetButtonSize(newValue: Integer);
begin
  FElScrollBar.ButtonSize := newValue;
end;

function TElScrollBarStyles.GetArrowColor: TColor;
{ Returns the value for the ArrowColor property. }
begin
  Result := FElScrollBar.ArrowColor;
end; { GetArrowColor }

procedure TElScrollBarStyles.SetArrowColor(newValue: TColor);
{ Sets the value for the ArrowColor property. }
begin
  FElScrollBar.ArrowColor := newValue;
end; { SetArrowColor }

function TElScrollBarStyles.GetArrowHotTrackColor: TColor;
{ Returns the value for the ArrowHotTrackColor property. }
begin
  result := FElScrollBar.ArrowHotTrackColor;
end; { GetArrowHotTrackColor }

procedure TElScrollBarStyles.SetArrowHotTrackColor(newValue: TColor);
{ Sets the value for the ArrowHotTrackColor property. }
begin
  FElScrollBar.ArrowHotTrackColor := newValue;
end; { SetArrowHotTrackColor }

function TElScrollBarStyles.GetShowBorder: Boolean;
{ Returns the value for the ShowBorder property. }
begin
  result := FElScrollBar.ShowBorder;
end; { GetShowBorder }

procedure TElScrollBarStyles.SetShowBorder(newValue: Boolean);
{ Sets the value for the ShowBorder property. }
begin
  FElScrollBar.ShowBorder := newValue;
end; { SetShowBorder }

function TElScrollBarStyles.GetThinFrame: Boolean;
{ Returns the value for the ThinFrame property. }
begin
  result := FElScrollBar.ThinFrame;
end; { GetThinFrame }

procedure TElScrollBarStyles.SetThinFrame(newValue: Boolean);
{ Sets the value for the ThinFrame property. }
begin
  FElScrollBar.ThinFrame := newValue;
end; { SetThinFrame }

{$IFDEF ELPACK_USE_IMAGEFORM}
function TElScrollBarStyles.GetImageForm: TElImageForm;
{ Returns the value for the ImageForm property. }
begin
  Result := FElScrollBar.ImageForm;
end; { GetImageForm }

procedure TElScrollBarStyles.SetImageForm(newValue: TElImageForm);
{ Sets the value for the ImageForm property. }
begin
  FElScrollBar.ImageForm := newValue;
end; { SetImageForm }
{$ENDIF}

constructor TElScrollBarStyles.Create(AControl: TCustomElScrollBar; AOwner :
    TControl);
{ Creates an object of type TElScrollBarStyles, and initializes properties. }
begin
  if (AControl = nil) or (AOwner = nil) then
    raise Exception.Create(esbsNoControl);
  inherited Create;
  FElScrollBar := AControl;
  FOwner := AOwner;
  UseSystemMetrics := true;
end; { Create }

procedure TElScrollBarStyles.SetHintColor(Value: TColor);
begin
  FElScrollBar.HintColor := Value;
end;

function TElScrollBarStyles.GetHintColor: TColor;
begin
  result := FElScrollBar.HintColor;
end;

procedure TElScrollBarStyles.SetHintTextColor(Value: TColor);
begin
  FElScrollBar.HintTextColor := Value;
end;

function TElScrollBarStyles.GetHintTextColor: TColor;
begin
  result := FElScrollBar.HintTextColor;
end;

function TElScrollBarStyles.GetSysBkColor: boolean;
begin
  Result := FElScrollBar.SystemBkColor;
end;

procedure TElScrollBarStyles.SetSysBkColor(Value: boolean);
begin
  FElScrollBar.SystemBkColor := Value;
end;

procedure TElScrollBarStyles.DefineProperties(Filer : TFiler);
begin
  inherited;
  // TElCtrlScrollBarStyles published properties:
  with GetElReader do
  begin
    Filer.DefineProperty('AltDisablingArrows', FakeBoolean, nil, False);
    Filer.DefineProperty('ChangeColorsOnScroll', FakeBoolean, nil, False);
    Filer.DefineProperty('IsHTML', FakeBoolean, nil, False);
    Filer.DefineProperty('UseSystemStep', FakeBoolean, nil, False);
    Filer.DefineProperty('Step', FakeInteger, nil, False);
  end;
  // old properties:
  Filer.DefineProperty('ThinFrames', ReadThinFramesProperty, nil, False);
  Filer.DefineProperty('DrawFrames', ReadDrawFramesProperty, nil, False);
end;

procedure TElScrollBarStyles.ReadThinFramesProperty(Reader: TReader);
begin
  ThinFrame := Reader.ReadBoolean;
end;

procedure TElScrollBarStyles.ReadDrawFramesProperty(Reader: TReader);
begin
  ShowBorder := Reader.ReadBoolean;
end;

function TElScrollBarStyles.GetDrawArrowFrames: Boolean;
begin
  Result := FElScrollBar.DrawArrowFrames;
end;

function TElScrollBarStyles.GetDrawBars: Boolean;
begin
  Result := FElScrollBar.DrawBars;
end;

function TElScrollBarStyles.GetBarColor: TColor;
begin
  Result := FElScrollBar.BarColor;
end;

function TElScrollBarStyles.GetBarOffset: Cardinal;
begin
  Result := FElScrollBar.BarOffset;
end;

procedure TElScrollBarStyles.SetDrawBars(const Value: Boolean);
begin
  FElScrollBar.DrawBars := Value;
end;

procedure TElScrollBarStyles.SetBarColor(const Value: TColor);
begin
  FElScrollBar.BarColor := Value;
end;

procedure TElScrollBarStyles.SetBarOffset(const Value: Cardinal);
begin
  FElScrollBar.BarOffset := Value;
end;

procedure TElScrollBarStyles.SetDrawArrowFrames(const Value: Boolean);
begin
  FElScrollBar.DrawArrowFrames := Value;
end;

function TElScrollBarStyles.GetUseXPThemes: Boolean;
begin
  Result := FElScrollBar.UseXPThemes;
end;

procedure TElScrollBarStyles.SetUseXPThemes(const Value: Boolean);
begin
  FElScrollBar.UseXPThemes := Value;
end;

initialization
  FBlendBitmap := nil;
  try
    if Classes.GetClass(TElScrollBarStyles.ClassName)=nil then
      RegisterClass(TElScrollBarStyles);
  except
  end;
finalization
  FBlendBitmap.Free;
  try
    Classes.UnRegisterClass(TElScrollBarStyles)
  except
  end;
end.
