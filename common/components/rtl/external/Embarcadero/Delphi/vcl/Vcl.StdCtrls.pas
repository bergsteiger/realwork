{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Vcl.StdCtrls;

{$R-,T-,H+,X+}

{$HPPEMIT '#ifndef _WIN64'}
{$HPPEMIT '#pragma link "dwmapi.lib"'}
{$HPPEMIT '#endif //_WIN64'}

interface

uses
{$IF DEFINED(CLR)}
  System.Collections, WinUtils,
{$ENDIF}
{$IF DEFINED(LINUX)}
  WinUtils,
{$ENDIF}
  Winapi.Messages, Winapi.Windows, System.SysUtils, System.Classes, Vcl.Controls,
  Vcl.Forms, Vcl.Menus, Vcl.Graphics, Winapi.CommCtrl, Vcl.ImgList, Vcl.Themes;

type
  TCustomGroupBox = class(TCustomControl)
  private
    class constructor Create;
    class destructor Destroy;
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure CMCtl3DChanged(var Message: TMessage); message CM_CTL3DCHANGED;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
  protected
    procedure UpdateStyleElements; override;
    procedure AdjustClientRect(var Rect: TRect); override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TGroupBox = class(TCustomGroupBox)
  strict private
    class constructor Create;
    class destructor Destroy;
  published
    property Align;
    property Anchors;
    property BiDiMode;
    property Caption;
    property Color;
    property Constraints;
    property Ctl3D;
    property DockSite;
    property DoubleBuffered;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property Padding;
    property ParentBackground default True;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentDoubleBuffered;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Touch;
    property Visible;
    property StyleElements;
    property OnAlignInsertBefore;
    property OnAlignPosition;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDockDrop;
    property OnDockOver;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGesture;
    property OnGetSiteInfo;
    property OnMouseActivate;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
    property OnUnDock;
  end;

  TTextLayout = (tlTop, tlCenter, tlBottom);
  TEllipsisPosition = (epNone, epPathEllipsis, epEndEllipsis, epWordEllipsis);
  TFNDrawText = procedure(DC: HDC; const Text: UnicodeString; var TextRect: TRect;
    TextFlags: Cardinal) of object;

  TCustomLabel = class(TGraphicControl)
  private
    FFocusControl: TWinControl;
    FAlignment: TAlignment;
    FAutoSize: Boolean;
    FDrawTextProc: TFNDrawText;
    FGlowSize: Integer;
    FLayout: TTextLayout;
    FWordWrap: Boolean;
    FShowAccelChar: Boolean;
    FTransparentSet: Boolean;
    FEllipsisPosition: TEllipsisPosition;
    procedure DoDrawThemeTextEx(DC: HDC; const Text: UnicodeString;
      var TextRect: TRect; TextFlags: Cardinal);
    procedure DoDrawNormalText(DC: HDC; const Text: UnicodeString;
      var TextRect: TRect; TextFlags: Cardinal);
    function GetTransparent: Boolean;
    procedure SetAlignment(Value: TAlignment);
    procedure SetEllipsisPosition(Value: TEllipsisPosition);
    procedure SetFocusControl(Value: TWinControl);
    procedure SetGlowSize(const Value: Integer);
    procedure SetLayout(Value: TTextLayout);
    procedure SetShowAccelChar(Value: Boolean);
    procedure SetTransparent(Value: Boolean);
    procedure SetWordWrap(Value: Boolean);
    procedure UpdateDrawTextProc;
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure CMStyleChanged(var Message: TMessage); message CM_STYLECHANGED;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
  protected
    procedure UpdateStyleElements; override;
    procedure AdjustBounds; dynamic;
    procedure DoDrawText(var Rect: TRect; Flags: Longint); dynamic;
    function GetLabelText: string; virtual;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Paint; override;
    procedure SetAutoSize(Value: Boolean); override;
    property Alignment: TAlignment read FAlignment write SetAlignment
      default taLeftJustify;
    property AutoSize: Boolean read FAutoSize write SetAutoSize default True;
    property EllipsisPosition: TEllipsisPosition read FEllipsisPosition write SetEllipsisPosition default epNone;
    property FocusControl: TWinControl read FFocusControl write SetFocusControl;
    property ShowAccelChar: Boolean read FShowAccelChar write SetShowAccelChar default True;
    property Transparent: Boolean read GetTransparent write SetTransparent stored FTransparentSet;
    property Layout: TTextLayout read FLayout write SetLayout default tlTop;
    property WordWrap: Boolean read FWordWrap write SetWordWrap default False;
  public
    constructor Create(AOwner: TComponent); override;
    property Caption;
    property Canvas;
    property GlowSize: Integer read FGlowSize write SetGlowSize default 0;
  end;

  TLabel = class(TCustomLabel)
  published
    property Align;
    property Alignment;
    property Anchors;
    property AutoSize;
    property BiDiMode;
    property Caption;
    property Color nodefault;
    property Constraints;
    property DragCursor;
    property DragKind;
    property DragMode;
    property EllipsisPosition;
    property Enabled;
    property FocusControl;
    property Font;
    property GlowSize; // Windows Vista only
    property ParentBiDiMode;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowAccelChar;
    property ShowHint;
    property Touch;
    property Transparent;
    property Layout;
    property Visible;
    property WordWrap;
    property StyleElements;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnGesture;
    property OnMouseActivate;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnStartDock;
    property OnStartDrag;
  end;

const
{ Editors common support }
  ecNormal	= System.UITypes.TEditCharCase.ecNormal;
  ecUpperCase	= System.UITypes.TEditCharCase.ecUpperCase;
  ecLowerCase	= System.UITypes.TEditCharCase.ecLowerCase;

type
  TEditCharCase = System.UITypes.TEditCharCase;
  {$NODEFINE TEditCharCase}
  {$HPPEMIT OPENNAMESPACE}
  {$HPPEMIT 'using ::System::Uitypes::TEditCharCase;'}
  {$HPPEMIT CLOSENAMESPACE}

  TCustomEdit = class(TWinControl)
  private
    FAlignment: TAlignment;
    FMaxLength: Integer;
    FBorderStyle: TBorderStyle;
    FPasswordChar: Char;
    FReadOnly: Boolean;
    FAutoSize: Boolean;
    FAutoSelect: Boolean;
    FHideSelection: Boolean;
    FOEMConvert: Boolean;
    FCharCase: TEditCharCase;
    FCreating: Boolean;
    FModified: Boolean;
    FInBufferedPrintClient: Boolean;
    FOnChange: TNotifyEvent;
    FOldSelLength: Integer;
    FOldSelStart: Integer;
    FNumbersOnly: Boolean;
    FTextHint: string;
    FSaveReadOnly: Boolean;
    class constructor Create;
    class destructor Destroy;
    procedure AdjustHeight;
    function GetModified: Boolean;
    function GetCanUndo: Boolean;
    function GetReadOnly: Boolean;
    procedure SetBorderStyle(Value: TBorderStyle);
    procedure SetCharCase(Value: TEditCharCase);
    procedure SetHideSelection(Value: Boolean);
    procedure SetMaxLength(Value: Integer);
    procedure SetModified(Value: Boolean);
    procedure SetNumbersOnly(Value: Boolean);
    procedure SetOEMConvert(Value: Boolean);
    procedure SetPasswordChar(Value: Char);
    procedure SetReadOnly(Value: Boolean);
    procedure SetTextHint(const Value: string);
    procedure UpdateHeight;
    procedure CMCtl3DChanged(var Message: TMessage); message CM_CTL3DCHANGED;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMGestureManagerChanged(var Message: TMessage); message CM_GESTUREMANAGERCHANGED;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
    procedure CMColorChanged(var Message: TMessage); message CM_COLORCHANGED;
    procedure WMContextMenu(var Message: TWMContextMenu); message WM_CONTEXTMENU;
    procedure WMSetFont(var Message: TWMSetFont); message WM_SETFONT;
  protected
    function CanObserve(const ID: Integer): Boolean; override;
    procedure ObserverAdded(const ID: Integer; const Observer: IObserver); override;
    procedure ObserverToggle(const AObserver: IObserver; const Value: Boolean);
    procedure Change; dynamic;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWindowHandle(const Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure DestroyWnd; override;
    procedure DoSetMaxLength(Value: Integer); virtual;
    procedure DoSetTextHint(const Value: string); virtual;
    function GetSelLength: Integer; virtual;
    function GetSelStart: Integer; virtual;
    function GetSelText: string; virtual;
    procedure SetAlignment(Value: TAlignment);
    procedure SetAutoSize(Value: Boolean); override;
    procedure SetSelLength(Value: Integer); virtual;
    procedure SetSelStart(Value: Integer); virtual;
{$IF DEFINED(CLR)}
    procedure SendGetSel(var SelStart, SelEnd: Integer);
{$ENDIF}
    procedure UpdateTIPStatus; override;
    property AutoSelect: Boolean read FAutoSelect write FAutoSelect default True;
    property AutoSize: Boolean read FAutoSize write SetAutoSize default True;
    property BorderStyle: TBorderStyle read FBorderStyle write SetBorderStyle default bsSingle;
    property CharCase: TEditCharCase read FCharCase write SetCharCase default ecNormal;
    property HideSelection: Boolean read FHideSelection write SetHideSelection default True;
    property MaxLength: Integer read FMaxLength write SetMaxLength default 0;
    property OEMConvert: Boolean read FOEMConvert write SetOEMConvert default False;
    property NumbersOnly: Boolean read FNumbersOnly write SetNumbersOnly default False;
    property PasswordChar: Char read FPasswordChar write SetPasswordChar default #0;
    property ParentColor default False;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Clear; virtual;
    procedure ClearSelection;
    procedure CopyToClipboard;
    procedure CutToClipboard;
    procedure DefaultHandler(var Message); override;
    function GetControlsAlignment: TAlignment; override;
    procedure PasteFromClipboard;
    procedure Undo;
    procedure ClearUndo;
    procedure SetSelText(const Value: string);
    procedure SelectAll;
{$IF NOT DEFINED(CLR)}
    function GetSelTextBuf(Buffer: PChar; BufSize: Integer): Integer; virtual;
    procedure SetSelTextBuf(Buffer: PChar);
{$ENDIF}
    property Alignment: TAlignment read FAlignment write SetAlignment default taLeftJustify;
    property CanUndo: Boolean read GetCanUndo;
    property Modified: Boolean read GetModified write SetModified;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property SelLength: Integer read GetSelLength write SetSelLength;
    property SelStart: Integer read GetSelStart write SetSelStart;
    property SelText: string read GetSelText write SetSelText;
    property Text;
    property TextHint: string read FTextHint write SetTextHint;
  published
    property TabStop default True;
  end;

  TEdit = class(TCustomEdit)
  strict private
    class constructor Create;
    class destructor Destroy;
  published
    property Align;
    property Alignment;
    property Anchors;
    property AutoSelect;
    property AutoSize;
    property BevelEdges;
    property BevelInner;
    property BevelKind default bkNone;
    property BevelOuter;
    property BevelWidth;
    property BiDiMode;
    property BorderStyle;
    property CharCase;
    property Color;
    property Constraints;
    property Ctl3D;
    property DoubleBuffered;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property HideSelection;
    property ImeMode;
    property ImeName;
    property MaxLength;
    property NumbersOnly;
    property OEMConvert;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentDoubleBuffered;
    property ParentFont;
    property ParentShowHint;
    property PasswordChar;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Text;
    property TextHint;
    property Touch;
    property Visible;
    property StyleElements;
    property OnChange;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGesture;
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

{ TScrollStyle constants }
{ To be moved to System.UITypes in a future release }
const
  ssNone = System.UITypes.TScrollStyle.ssNone; { deprecated 'Use System.UITypes.TScrollStyle.ssNone' }
  ssHorizontal = System.UITypes.TScrollStyle.ssHorizontal; { deprecated 'Use System.UITypes.TScrollStyle.ssHorizontal' }
  ssVertical = System.UITypes.TScrollStyle.ssVertical; { deprecated 'Use System.UITypes.TScrollStyle.ssVertical' }
  ssBoth = System.UITypes.TScrollStyle.ssBoth; { deprecated 'Use System.UITypes.TScrollStyle.ssBoth' }

type
  TScrollStyle = System.UITypes.TScrollStyle deprecated 'Use System.UITypes.TScrollStyle';


  TCustomMemo = class(TCustomEdit)
  private
    FLines: TStrings;
    FScrollBars: System.UITypes.TScrollStyle;
    FWordWrap: Boolean;
    FWantReturns: Boolean;
    FWantTabs: Boolean;
    class constructor Create;
    class destructor Destroy;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMNCDestroy(var Message: TWMNCDestroy); message WM_NCDESTROY;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWindowHandle(const Params: TCreateParams); override;
    function GetCaretPos: TPoint; virtual;
    procedure DoGetGestureOptions(var Gestures: TInteractiveGestures;
      var Options: TInteractiveGestureOptions); override;
    function IsTouchPropertyStored(AProperty: TTouchProperty): Boolean; override;
    procedure KeyPress(var Key: Char); override;
    procedure Loaded; override;
    procedure SetCaretPos(const Value: TPoint); virtual;
    procedure SetLines(Value: TStrings);
    procedure SetScrollBars(Value: System.UITypes.TScrollStyle);
    procedure SetWordWrap(Value: Boolean);
    property ScrollBars: System.UITypes.TScrollStyle read FScrollBars write SetScrollBars default ssNone;
    property WantReturns: Boolean read FWantReturns write FWantReturns default True;
    property WantTabs: Boolean read FWantTabs write FWantTabs default False;
    property WordWrap: Boolean read FWordWrap write SetWordWrap default True;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property CaretPos: TPoint read GetCaretPos write SetCaretPos;
    property Lines: TStrings read FLines write SetLines;
  end;

  TMemo = class(TCustomMemo)
  strict private
    class constructor Create;
    class destructor Destroy;
  published
    property Align;
    property Alignment;
    property Anchors;
    property BevelEdges;
    property BevelInner;
    property BevelKind default bkNone;
    property BevelOuter;
    property BiDiMode;
    property BorderStyle;
    property CharCase;
    property Color;
    property Constraints;
    property Ctl3D;
    property DoubleBuffered;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property HideSelection;
    property ImeMode;
    property ImeName;
    property Lines;
    property MaxLength;
    property OEMConvert;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentDoubleBuffered;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property ScrollBars;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Touch;
    property Visible;
    property WantReturns;
    property WantTabs;
    property WordWrap;
    property StyleElements;
    property OnChange;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGesture;
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

  TOwnerDrawState = Winapi.Windows.TOwnerDrawState;
{$IF NOT DEFINED(CLR)}
  {$NODEFINE TOwnerDrawState}
{$ENDIF}

  TCustomCombo = class;
  TDrawItemEvent = procedure(Control: TWinControl; Index: Integer;
    Rect: TRect; State: TOwnerDrawState) of object;

  TMeasureItemEvent = procedure(Control: TWinControl; Index: Integer;
    var Height: Integer) of object;

  TCustomComboBoxStrings = class(TStrings)
  private
    FComboBox: TCustomCombo;
{$IF DEFINED(CLR)}
    FObjects: HashTable;
{$ENDIF}
  protected
    function GetCount: Integer; override;
    function Get(Index: Integer): string; override;
    function GetObject(Index: Integer): TObject; override;
    procedure PutObject(Index: Integer; AObject: TObject); override;
    procedure SetUpdateState(Updating: Boolean); override;
    property ComboBox: TCustomCombo read FComboBox write FComboBox;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure Clear; override;
    procedure Delete(Index: Integer); override;
    function IndexOf(const S: string): Integer; override;
  end;

  TCustomComboBoxStringsClass = class of TCustomComboBoxStrings;

{$IF DEFINED(CLR)}
  TComboChildren = class
  private
    FEditInstance: TFNWndProc;
    FListInstance: TFNWndProc;
  strict protected
    procedure Finalize; override;
  end;
{$ENDIF}

  TCustomCombo = class(TCustomListControl)
  private
    FCanvas: TCanvas;
    FMaxLength: Integer;
    FDropDownCount: Integer;
    FInBufferedPrintClient: Boolean;
    FItemIndex: Integer;
    FOnChange: TNotifyEvent;
    FOnSelect: TNotifyEvent;
    FOnDropDown: TNotifyEvent;
    FOnCloseUp: TNotifyEvent;
    FItemHeight: Integer;
    FItems: TStrings;
    procedure CMCancelMode(var Message: TCMCancelMode); message CM_CANCELMODE;
    procedure CMCtl3DChanged(var Message: TMessage); message CM_CTL3DCHANGED;
    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
    procedure CMGestureManagerChanged(var Message: TMessage); message CM_GESTUREMANAGERCHANGED;
    procedure WMCreate(var Message: TWMCreate); message WM_CREATE;
    procedure WMDrawItem(var Message: TWMDrawItem); message WM_DRAWITEM;
    procedure WMMeasureItem(var Message: TWMMeasureItem); message WM_MEASUREITEM;
    procedure WMDeleteItem(var Message: TWMDeleteItem); message WM_DELETEITEM;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
{$IF DEFINED(CLR)}
    function GetEditInstance: TFNWndProc;
    function GetListInstance: TFNWndProc;
{$ENDIF}
  protected
    FEditHandle: HWnd;
    FListHandle: HWnd;
    FDropHandle: HWnd;
    FDefEditProc: TWindowProcPtr;
    FDefListProc: TWindowProcPtr;
    FDroppingDown: Boolean;
    FFocusChanged: Boolean;
    FIsFocused: Boolean;
    FSaveIndex: Integer;
{$IF DEFINED(CLR)}
    FChildInstances: TComboChildren;
{$ELSE}
    FEditInstance: Pointer;
    FListInstance: Pointer;
{$ENDIF}
    procedure AdjustDropDown; virtual;
    procedure ComboWndProc(var Message: TMessage; ComboWnd: HWnd;
      ComboProc: TWindowProcPtr); virtual;
    procedure CreateWnd; override;
    procedure EditWndProc(var Message: TMessage); virtual;
    function GetItemsClass: TCustomComboBoxStringsClass; virtual; abstract;
    procedure WndProc(var Message: TMessage); override;
    function GetItemHt: Integer; virtual; abstract;
    procedure SetItemHeight(Value: Integer); virtual;
    function GetItemCount: Integer; virtual; abstract;
    function GetItemIndex: Integer; override;
    function GetDroppedDown: Boolean;
    function GetSelLength: Integer;
    function GetSelStart: Integer;
    procedure ListWndProc(var Message: TMessage);
    procedure Loaded; override;
    procedure Change; dynamic;
    procedure Select; dynamic;
    procedure DropDown; dynamic;
    procedure CloseUp; dynamic;
    procedure DestroyWindowHandle; override;
    procedure SetDroppedDown(Value: Boolean);
    procedure SetSelLength(Value: Integer);
    procedure SetSelStart(Value: Integer);
    procedure SetMaxLength(Value: Integer);
    procedure SetDropDownCount(const Value: Integer); virtual;
    procedure SetItemIndex(const Value: Integer); override;
    procedure SetItems(const Value: TStrings); virtual;
    function IsItemHeightStored: Boolean; virtual;
    property DropDownCount: Integer read FDropDownCount write SetDropDownCount default 8;
    property EditHandle: HWnd read FEditHandle;
{$IF DEFINED(CLR)}
    property FEditInstance: TFNWndProc read GetEditInstance;
    property FListInstance: TFNWndProc read GetListInstance;
{$ENDIF}
    property ItemCount: Integer read GetItemCount;
    property ItemHeight: Integer read GetItemHt write SetItemHeight stored IsItemHeightStored;
    property ListHandle: HWnd read FListHandle;
    property MaxLength: Integer read FMaxLength write SetMaxLength default 0;
    property ParentColor default False;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnDropDown: TNotifyEvent read FOnDropDown write FOnDropDown;
    property OnSelect: TNotifyEvent read FOnSelect write FOnSelect;
    property OnCloseUp: TNotifyEvent read FOnCloseUp write FOnCloseUp;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AddItem(Item: String; AObject: TObject); override;
    procedure Clear; override;
    procedure ClearSelection; override;
    procedure CopySelection(Destination: TCustomListControl); override;
    procedure DeleteSelected; override;
    function Focused: Boolean; override;
    function GetCount: Integer; override;
    procedure SelectAll; override;
    property Canvas: TCanvas read FCanvas;
    property DroppedDown: Boolean read GetDroppedDown write SetDroppedDown;
    property Items: TStrings read FItems write SetItems;
    property SelLength: Integer read GetSelLength write SetSelLength;
    property SelStart: Integer read GetSelStart write SetSelStart;
    property TabStop default True;
  end;

  TComboBoxStyle = (csDropDown, csSimple, csDropDownList, csOwnerDrawFixed,
    csOwnerDrawVariable);

  TCustomComboBox = class(TCustomCombo)
  private
    FAutoComplete: Boolean;
    FAutoDropDown: Boolean;
    FLastTime: Cardinal;
    FFilter: String;
    FCharCase: TEditCharCase;
    FSorted: Boolean;
    FStyle: TComboBoxStyle;
    FSaveItems: TStringList;
    FOnDrawItem: TDrawItemEvent;
    FOnMeasureItem: TMeasureItemEvent;
    FAutoCloseUp: Boolean;
    FAutoCompleteDelay: Cardinal;
    FTextHint: string;
    class constructor Create;
    class destructor Destroy;
    procedure SetCharCase(Value: TEditCharCase);
    procedure SetSelText(const Value: string);
    procedure SetSorted(Value: Boolean);
    procedure SetTextHint(const Value: string);
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure CMParentColorChanged(var Message: TMessage); message CM_PARENTCOLORCHANGED;
    procedure CNDrawItem(var Message: TWMDrawItem); message CN_DRAWITEM;
    procedure CNMeasureItem(var Message: TWMMeasureItem); message CN_MEASUREITEM;
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
  protected
    procedure ComboWndProc(var Message: TMessage; ComboWnd: HWnd;
      ComboProc: TWindowProcPtr); override;
    function CanObserve(const ID: Integer): Boolean; override;
    procedure Change; override;
    procedure Click; override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure DestroyWnd; override;
    procedure DoSetTextHint; virtual;
    procedure DrawItem(Index: Integer; Rect: TRect;
      State: TOwnerDrawState); virtual;
    function GetItemHt: Integer; override;
    function IsItemHeightStored: Boolean; override;
    function GetItemsClass: TCustomComboBoxStringsClass; override;
    function GetSelText: string;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure MeasureItem(Index: Integer; var Height: Integer); virtual;
    function SelectItem(const AnItem: string): Boolean;
    procedure SetStyle(Value: TComboBoxStyle); virtual;
    property Sorted: Boolean read FSorted write SetSorted default False;
    property Style: TComboBoxStyle read FStyle write SetStyle default csDropDown;
    property OnDrawItem: TDrawItemEvent read FOnDrawItem write FOnDrawItem;
    property OnMeasureItem: TMeasureItemEvent read FOnMeasureItem write FOnMeasureItem;
    procedure WndProc(var Message: TMessage); override;
    function GetItemCount: Integer; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property AutoCompleteDelay: Cardinal read FAutoCompleteDelay write FAutoCompleteDelay default 500;
    property AutoComplete: Boolean read FAutoComplete write FAutoComplete default True;
    property AutoCloseUp: Boolean read FAutoCloseUp write FAutoCloseUp default False;
    property AutoDropDown: Boolean read FAutoDropDown write FAutoDropDown default False;
    property CharCase: TEditCharCase read FCharCase write SetCharCase default ecNormal;
    property SelText: string read GetSelText write SetSelText;
    property TextHint: string read FTextHint write SetTextHint;
  end;

  TComboBox = class(TCustomComboBox)
  strict private
    class constructor Create;
    class destructor Destroy;
  published
    property Align;
    property AutoComplete default True;
    property AutoCompleteDelay default 500;
    property AutoDropDown default False;
    property AutoCloseUp default False;
    property BevelEdges;
    property BevelInner;
    property BevelKind default bkNone;
    property BevelOuter;
    property Style; {Must be published before Items}
    property Anchors;
    property BiDiMode;
    property CharCase;
    property Color;
    property Constraints;
    property Ctl3D;
    property DoubleBuffered;
    property DragCursor;
    property DragKind;
    property DragMode;
    property DropDownCount;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property ItemHeight;
    property ItemIndex default -1;
    property MaxLength;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentDoubleBuffered;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Sorted;
    property TabOrder;
    property TabStop;
    property Text;
    property TextHint;
    property Touch;
    property Visible;
    property StyleElements;
    property OnChange;
    property OnClick;
    property OnCloseUp;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDrawItem;
    property OnDropDown;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGesture;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMeasureItem;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnSelect;
    property OnStartDock;
    property OnStartDrag;
    property Items; { Must be published after OnMeasureItem }
  end;

{ TButtonControl }

  TButtonControl = class;

  TButtonActionLink = class(TWinControlActionLink)
  protected
    FClient: TButtonControl;
    procedure AssignClient(AClient: TObject); override;
    function IsCheckedLinked: Boolean; override;
    procedure SetChecked(Value: Boolean); override;
  end;

  TButtonActionLinkClass = class of TButtonActionLink;

  TButtonControl = class(TWinControl)
  private
    FClicksDisabled: Boolean;
    FWordWrap: Boolean;
    function IsCheckedStored: Boolean;
    procedure CNCtlColorStatic(var Message: TWMCtlColorStatic); message CN_CTLCOLORSTATIC;
    procedure WMEraseBkGnd(var Message: TWMEraseBkGnd); message WM_ERASEBKGND;
    procedure SetWordWrap(const Value: Boolean);
  protected
    procedure ActionChange(Sender: TObject; CheckDefaults: Boolean); override;
    function GetActionLinkClass: TControlActionLinkClass; override;
    function GetChecked: Boolean; virtual;
    procedure SetChecked(Value: Boolean); virtual;
    procedure WndProc(var Message: TMessage); override;
    procedure CreateParams(var Params: TCreateParams); override;
    property Checked: Boolean read GetChecked write SetChecked stored IsCheckedStored default False;
    property ClicksDisabled: Boolean read FClicksDisabled write FClicksDisabled;
    property WordWrap: Boolean read FWordWrap write SetWordWrap default False;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TImageAlignment = (iaLeft, iaRight, iaTop, iaBottom, iaCenter);

  TImageMargins = class(TPersistent)
  private
    FRight: Integer;
    FBottom: Integer;
    FTop: Integer;
    FLeft: Integer;
    FOnChange: TNotifyEvent;
    procedure SetMargin(Index, Value: Integer);
  protected
    procedure Change; virtual;
  public
    procedure Assign(Source: TPersistent); override;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  published
    property Left: Integer index 0 read FLeft write SetMargin default 0;
    property Top: Integer index 1 read FTop write SetMargin default 0;
    property Right: Integer index 2 read FRight write SetMargin default 0;
    property Bottom: Integer index 3 read FBottom write SetMargin default 0;
  end;

  TPushButtonActionLink = class(TButtonActionLink)
  protected
    function IsImageIndexLinked: Boolean; override;
    procedure SetImageIndex(Value: Integer); override;
  end;

  TPushButtonActionLinkClass = class of TPushButtonActionLink;

  TCustomButton = class(TButtonControl)
  public type
    TButtonStyle = (bsPushButton, bsCommandLink, bsSplitButton);
  private
    FActive: Boolean;
    FCancel: Boolean;
    FCommandLinkHint: string;
    FDefault: Boolean;
    FDisabledImageIndex: TImageIndex;
    FDropDownMenu: TPopupMenu;
    FElevationRequired: Boolean;
    FHotImageIndex: TImageIndex;
    FImageAlignment: TImageAlignment;
    FImageChangeLink: TChangeLink;
    FImageIndex: TImageIndex;
    FImageMargins: TImageMargins;
    FImages: TCustomImageList;
    FInternalImageList: TImageList;
    FModalResult: TModalResult;
    FPressedImageIndex: TImageIndex;
    FSelectedImageIndex: TImageIndex;
    FStyle: TButtonStyle;
    FStylusHotImageIndex: TImageIndex;
    FOnDropDownClick: TNotifyEvent;
    class constructor Create;
    class destructor Destroy;
    procedure CMDialogKey(var Message: TCMDialogKey); message CM_DIALOGKEY;
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
    procedure CNCtlColorBtn(var Message: TWMCtlColorBtn); message CN_CTLCOLORBTN;
    procedure CNNotify(var Message: TWMNotify); message CN_NOTIFY;
    procedure ImageListChange(Sender: TObject);
    procedure ImageMarginsChange(Sender: TObject);
    function IsImageIndexStored: Boolean;
    procedure SetCommandLinkHint(const Value: string);
    procedure SetDefault(Value: Boolean);
    procedure SetDisabledImageIndex(const Value: TImageIndex);
    procedure SetDropDownMenu(const Value: TPopupMenu);
    procedure SetElevationRequired(const Value: Boolean);
    procedure SetElevationRequiredState;
    procedure SetHotImageIndex(const Value: TImageIndex);
    procedure SetImageAlignment(const Value: TImageAlignment);
    procedure SetImageIndex(const Value: TImageIndex);
    procedure SetImageList(AHandle: HIMAGELIST);
    procedure SetImageMargins(const Value: TImageMargins);
    procedure SetImages(const Value: TCustomImageList);
    procedure SetPressedImageIndex(const Value: TImageIndex);
    procedure SetSelectedImageIndex(const Value: TImageIndex);
    procedure SetStyle(const Value: TButtonStyle);
    procedure SetStylusHotImageIndex(const Value: TImageIndex);
    procedure UpdateCommandLinkHint;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
{$IF NOT DEFINED(CLR)}
    procedure CMFocusChanged(var Message: TCMFocusChanged); message CM_FOCUSCHANGED;
{$ENDIF}
  protected
    procedure ActionChange(Sender: TObject; CheckDefaults: Boolean); override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    function GetActionLinkClass: TControlActionLinkClass; override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetButtonStyle(ADefault: Boolean); virtual;
    procedure UpdateImageList; virtual;
    procedure UpdateImages; virtual;
{$IF DEFINED(CLR)}
    procedure FocusChanged(NewFocusControl: TWinControl); override;
{$ENDIF}
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Click; override;
    function UseRightToLeftAlignment: Boolean; override;
    property Cancel: Boolean read FCancel write FCancel default False;
    property CommandLinkHint: string read FCommandLinkHint write SetCommandLinkHint;
    property Default: Boolean read FDefault write SetDefault default False;
    property DisabledImageIndex: TImageIndex read FDisabledImageIndex write SetDisabledImageIndex default -1;
    property DropDownMenu: TPopupMenu read FDropDownMenu write SetDropDownMenu;
    property ElevationRequired: Boolean read FElevationRequired write SetElevationREquired default False;
    property HotImageIndex: TImageIndex read FHotImageIndex write SetHotImageIndex default -1;
    property Images: TCustomImageList read FImages write SetImages;
    property ImageAlignment: TImageAlignment read FImageAlignment write SetImageAlignment default iaLeft;
    property ImageIndex: TImageIndex read FImageIndex write SetImageIndex stored IsImageIndexStored default -1;
    property ImageMargins: TImageMargins read FImageMargins write SetImageMargins;
    property ModalResult: TModalResult read FModalResult write FModalResult default 0;
    property PressedImageIndex: TImageIndex read FPressedImageIndex write SetPressedImageIndex default -1;
    property SelectedImageIndex: TImageIndex read FSelectedImageIndex write SetSelectedImageIndex default -1;
    property Style: TButtonStyle read FStyle write SetStyle default bsPushButton;
    property StylusHotImageIndex: TImageIndex read FStylusHotImageIndex write SetStylusHotImageIndex default -1;
    property TabStop default True;
    property OnDropDownClick: TNotifyEvent read FOnDropDownClick write FOnDropDownClick;
  end;

  TButton = class(TCustomButton)
  strict private
    class constructor Create;
    class destructor Destroy;
  published
    property Action;
    property Align;
    property Anchors;
    property BiDiMode;
    property Cancel;
    property Caption;
    property CommandLinkHint;
    property Constraints;
    property Default;
    property DisabledImageIndex;
    property DoubleBuffered;
    property DragCursor;
    property DragKind;
    property DragMode;
    property DropDownMenu;
    property ElevationRequired;
    property Enabled;
    property Font;
    property HotImageIndex;
    property ImageAlignment;
    property ImageIndex;
    property ImageMargins;
    property Images;
    property ModalResult;
    property ParentBiDiMode;
    property ParentDoubleBuffered;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property PressedImageIndex;
    property SelectedImageIndex;
    property ShowHint;
    property Style;
    property StylusHotImageIndex;
    property TabOrder;
    property TabStop;
    property Visible;
    property WordWrap;
    property StyleElements;
    property OnClick;
    property OnContextPopup;
    property OnDragDrop;
    property OnDragOver;
    property OnDropDownClick;
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

  TCheckBoxState = (cbUnchecked, cbChecked, cbGrayed);

  TCustomCheckBox = class(TButtonControl)
  private
    FAlignment: TLeftRight;
    FAllowGrayed: Boolean;
    FState: TCheckBoxState;
    class constructor Create;
    class destructor Destroy;
    procedure SetAlignment(Value: TLeftRight);
    procedure SetState(Value: TCheckBoxState);
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure CMCtl3DChanged(var Message: TMessage); message CM_CTL3DCHANGED;
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
  protected
    procedure UpdateStyleElements; override;
    function CanObserve(const ID: Integer): Boolean; override;
    procedure ObserverAdded(const ID: Integer; const Observer: IObserver); override;
    procedure ObserverToggle(const AObserver: IObserver; const Value: Boolean);
    procedure Toggle; virtual;
    procedure KeyPress(var Key: Char); override;
    procedure Click; override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    function GetChecked: Boolean; override;
    procedure SetChecked(Value: Boolean); override;
    property Alignment: TLeftRight read FAlignment write SetAlignment default taRightJustify;
    property AllowGrayed: Boolean read FAllowGrayed write FAllowGrayed default False;
    property State: TCheckBoxState read FState write SetState default cbUnchecked;
  public
    constructor Create(AOwner: TComponent); override;
    function GetControlsAlignment: TAlignment; override;
  published
    property TabStop default True;
  end;

  TCheckBox = class(TCustomCheckBox)
  strict private
    class constructor Create;
    class destructor Destroy;
  published
    property Action;
    property Align;
    property Alignment;
    property AllowGrayed;
    property Anchors;
    property BiDiMode;
    property Caption;
    property Checked;
    property Color nodefault;
    property Constraints;
    property Ctl3D;
    property DoubleBuffered;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentDoubleBuffered;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property State;
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

  TRadioButton = class(TButtonControl)
  private
    FAlignment: TLeftRight;
    FChecked: Boolean;
    class constructor Create;
    class destructor Destroy;
    procedure SetAlignment(Value: TLeftRight);
    procedure CMCtl3DChanged(var Message: TMessage); message CM_CTL3DCHANGED;
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
  protected
    function GetChecked: Boolean; override;
    procedure UpdateStyleElements; override;
    procedure SetChecked(Value: Boolean); override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
  public
    constructor Create(AOwner: TComponent); override;
    function GetControlsAlignment: TAlignment; override;
  published
    property Action;
    property Align;
    property Alignment: TLeftRight read FAlignment write SetAlignment default taRightJustify;
    property Anchors;
    property BiDiMode;
    property Caption;
    property Checked;
    property Color;
    property Constraints;
    property Ctl3D;
    property DoubleBuffered;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentDoubleBuffered;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property WordWrap;
    property StyleElements;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
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

  TListBoxStyle = (lbStandard, lbOwnerDrawFixed, lbOwnerDrawVariable,
    lbVirtual, lbVirtualOwnerDraw);
  TLBGetDataEvent = procedure(Control: TWinControl; Index: Integer;
    var Data: string) of object;
  TLBGetDataObjectEvent = procedure(Control: TWinControl; Index: Integer;
    var DataObject: TObject) of object;
  TLBFindDataEvent = function(Control: TWinControl;
    FindString: string): Integer of object;

{$IF DEFINED(CLR)}
  TListBoxItemData = TObject;
{$ELSE}
  TListBoxItemData = Winapi.Windows.LPARAM;
{$ENDIF}

  TCustomListBox = class(TCustomMultiSelectListControl)
  private
    FAutoComplete: Boolean;
    FCount: Integer;
    FItems: TStrings;
    FFilter: String;
    FLastTime: Cardinal;
    FBorderStyle: TBorderStyle;
    FCanvas: TCanvas;
    FColumns: Integer;
    FItemHeight: Integer;
    FOldCount: Integer;
    FStyle: TListBoxStyle;
    FIntegralHeight: Boolean;
    FSorted: Boolean;
    FExtendedSelect: Boolean;
    FTabWidth: Integer;
    FSaveItems: TStringList;
    FSaveTopIndex: Integer;
    FSaveItemIndex: Integer;
    FSaveScrollWidth: Integer;
    FSaveSelection: array of Boolean;
    FOnDrawItem: TDrawItemEvent;
    FOnMeasureItem: TMeasureItemEvent;
    FOnData: TLBGetDataEvent;
    FOnDataFind: TLBFindDataEvent;
    FOnDataObject: TLBGetDataObjectEvent;
    FAutoCompleteDelay: Cardinal;
    FInBufferedPrintClient: Boolean;
{$IF DEFINED(CLR)}
    FObjects: HashTable;
{$ENDIF}
    class constructor Create;
    class destructor Destroy;
    function GetItemHeight: Integer;
    function GetItemRect(Index: Integer): TRect;
    function GetTopIndex: Integer;
    procedure LBGetText(var Message: TMessage); message LB_GETTEXT;
    procedure LBGetTextLen(var Message: TMessage); message LB_GETTEXTLEN;
    procedure SetBorderStyle(Value: TBorderStyle);
    procedure SetColumnWidth;
    procedure SetColumns(Value: Integer);
    procedure SetCount(const Value: Integer);
    procedure SetExtendedSelect(Value: Boolean);
    procedure SetIntegralHeight(Value: Boolean);
    procedure SetItemHeight(Value: Integer);
    procedure SetItems(Value: TStrings);
    procedure SetSelected(Index: Integer; Value: Boolean);
    procedure SetSorted(Value: Boolean);
    procedure SetStyle(Value: TListBoxStyle);
    procedure SetTabWidth(Value: Integer);
    procedure SetTopIndex(Value: Integer);
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
    procedure CNDrawItem(var Message: TWMDrawItem); message CN_DRAWITEM;
    procedure CNMeasureItem(var Message: TWMMeasureItem); message CN_MEASUREITEM;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure CMCtl3DChanged(var Message: TMessage); message CM_CTL3DCHANGED;
    function GetScrollWidth: Integer;
    procedure SetScrollWidth(const Value: Integer);
  protected
    FMoving: Boolean;
    function CanObserve(const ID: Integer): Boolean; override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure DestroyWnd; override;
    function DoGetData(const Index: Integer): String;
    function DoGetDataObject(const Index: Integer): TObject;
    function DoFindData(const Data: String): Integer;
    procedure WndProc(var Message: TMessage); override;
    procedure DragCanceled; override;
    procedure DrawItem(Index: Integer; Rect: TRect;
      State: TOwnerDrawState); virtual;
    function GetSelCount: Integer; override;
    procedure MeasureItem(Index: Integer; var Height: Integer); virtual;
    function InternalGetItemData(Index: Integer): TListBoxItemData; dynamic;
    procedure InternalSetItemData(Index: Integer; AData: TListBoxItemData); dynamic;
    function GetItemData(Index: Integer): TListBoxItemData; dynamic;
    function GetItemIndex: Integer; override;
    function GetSelected(Index: Integer): Boolean;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure LoadRecreateItems(RecreateItems: TStrings); virtual;
    procedure SetItemData(Index: Integer; AData: TListBoxItemData); dynamic;
    procedure ResetContent; dynamic;
    procedure SaveRecreateItems(RecreateItems: TStrings); virtual;
    procedure DeleteString(Index: Integer); dynamic;
    procedure SetMultiSelect(Value: Boolean); override;
    procedure SetItemIndex(const Value: Integer); override;
    property BorderStyle: TBorderStyle read FBorderStyle write SetBorderStyle default bsSingle;
    property Columns: Integer read FColumns write SetColumns default 0;
    property ExtendedSelect: Boolean read FExtendedSelect write SetExtendedSelect default True;
    property IntegralHeight: Boolean read FIntegralHeight write SetIntegralHeight default False;
    property ItemHeight: Integer read GetItemHeight write SetItemHeight default 16;
    property ParentColor default False;
    property Sorted: Boolean read FSorted write SetSorted default False;
    property Style: TListBoxStyle read FStyle write SetStyle default lbStandard;
    property TabWidth: Integer read FTabWidth write SetTabWidth default 0;
    property OnDrawItem: TDrawItemEvent read FOnDrawItem write FOnDrawItem;
    property OnMeasureItem: TMeasureItemEvent read FOnMeasureItem write FOnMeasureItem;
    property OnData: TLBGetDataEvent read FOnData write FOnData;
    property OnDataObject: TLBGetDataObjectEvent read FOnDataObject write FOnDataObject;
    property OnDataFind: TLBFindDataEvent read FOnDataFind write FOnDataFind;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AddItem(Item: String; AObject: TObject); override;
    procedure Clear; override;
    procedure ClearSelection; override;
    procedure CopySelection(Destination: TCustomListControl); override;
    procedure DeleteSelected; override;
    function GetCount: Integer; override;
    function ItemAtPos(Pos: TPoint; Existing: Boolean): Integer;
    function ItemRect(Index: Integer): TRect;
    procedure SelectAll; override;
    property AutoCompleteDelay: Cardinal read FAutoCompleteDelay write FAutoCompleteDelay default 500;
    property AutoComplete: Boolean read FAutoComplete write FAutoComplete default True;
    property Canvas: TCanvas read FCanvas;
    property Count: Integer read GetCount write SetCount;
    property Items: TStrings read FItems write SetItems;
    property Selected[Index: Integer]: Boolean read GetSelected write SetSelected;
    property ScrollWidth: Integer read GetScrollWidth write SetScrollWidth default 0;
    property TopIndex: Integer read GetTopIndex write SetTopIndex;
  published
    property TabStop default True;
  end;

  TListBox = class(TCustomListBox)
  strict private
    class constructor Create;
    class destructor Destroy;
  published
    property Style;
    property AutoComplete;
    property AutoCompleteDelay;
    property Align;
    property Anchors;
    property BevelEdges;
    property BevelInner;
    property BevelKind default bkNone;
    property BevelOuter;
    property BevelWidth;
    property BiDiMode;
    property BorderStyle;
    property Color;
    property Columns;
    property Constraints;
    property Ctl3D;
    property DoubleBuffered;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property ExtendedSelect;
    property Font;
    property ImeMode;
    property ImeName;
    property IntegralHeight;
    property ItemHeight;
    property Items;
    property MultiSelect;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentDoubleBuffered;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ScrollWidth;
    property ShowHint;
    property Sorted;
    property TabOrder;
    property TabStop;
    property TabWidth;
    property Touch;
    property Visible;
    property StyleElements;
    property OnClick;
    property OnContextPopup;
    property OnData;
    property OnDataFind;
    property OnDataObject;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDrawItem;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGesture;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMeasureItem;
    property OnMouseActivate;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  end;

const
  scLineUp = System.UITypes.TScrollCode.scLineUp;
  scLineDown = System.UITypes.TScrollCode.scLineDown;
  scPageUp = System.UITypes.TScrollCode.scPageUp;
  scPageDown = System.UITypes.TScrollCode.scPageDown;
  scPosition = System.UITypes.TScrollCode.scPosition;
  scTrack = System.UITypes.TScrollCode.scTrack;
  scTop = System.UITypes.TScrollCode.scTop;
  scBottom = System.UITypes.TScrollCode.scBottom;
  scEndScroll = System.UITypes.TScrollCode.scEndScroll;

type
  TScrollCode = System.UITypes.TScrollCode;
  {$NODEFINE TScrollCode}

  TScrollEvent = procedure(Sender: TObject; ScrollCode: TScrollCode;
    var ScrollPos: Integer) of object;

  TScrollBar = class(TWinControl)
  private
    FKind: TScrollBarKind;
    FPosition: Integer;
    FMin: Integer;
    FMax: Integer;
    FPageSize: Integer;
    FRTLFactor: Integer;
    FSmallChange: TScrollBarInc;
    FLargeChange: TScrollBarInc;
    FOnChange: TNotifyEvent;
    FOnScroll: TScrollEvent;
    class constructor Create;
    class destructor Destroy;
    procedure DoScroll(var Message: TWMScroll);
    function NotRightToLeft: Boolean;
    procedure SetKind(Value: TScrollBarKind);
    procedure SetMax(Value: Integer);
    procedure SetMin(Value: Integer);
    procedure SetPosition(Value: Integer);
    procedure SetPageSize(Value: Integer);
    procedure CNHScroll(var Message: TWMHScroll); message CN_HSCROLL;
    procedure CNVScroll(var Message: TWMVScroll); message CN_VSCROLL;
    procedure CNCtlColorScrollBar(var Message: TMessage); message CN_CTLCOLORSCROLLBAR;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
  protected
    function CanObserve(const ID: Integer): Boolean; override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure Change; dynamic;
    procedure Scroll(ScrollCode: TScrollCode; var ScrollPos: Integer); dynamic;
  public
    constructor Create(AOwner: TComponent); override;
    procedure SetParams(APosition, AMin, AMax: Integer);
  published
    property Align;
    property Anchors;
    property BiDiMode;
    property Constraints;
    property Ctl3D;
    property DoubleBuffered;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Kind: TScrollBarKind read FKind write SetKind default sbHorizontal;
    property LargeChange: TScrollBarInc read FLargeChange write FLargeChange default 1;
    property Max: Integer read FMax write SetMax default 100;
    property Min: Integer read FMin write SetMin default 0;
    property PageSize: Integer read FPageSize write SetPageSize;
    property ParentBiDiMode;
    property ParentCtl3D;
    property ParentDoubleBuffered;
    property ParentShowHint;
    property PopupMenu;
    property Position: Integer read FPosition write SetPosition default 0;
    property ShowHint;
    property SmallChange: TScrollBarInc read FSmallChange write FSmallChange default 1;
    property TabOrder;
    property TabStop default True;
    property Visible;
    property StyleElements;
    property OnContextPopup;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnScroll: TScrollEvent read FOnScroll write FOnScroll;
    property OnStartDock;
    property OnStartDrag;
  end;

  TStaticBorderStyle = (sbsNone, sbsSingle, sbsSunken);

  TCustomStaticText = class(TWinControl)
  private
    FAlignment: TAlignment;
    FAutoSize: Boolean;
    FBorderStyle: TStaticBorderStyle;
    FFocusControl: TWinControl;
    FShowAccelChar: Boolean;
    class constructor Create;
    class destructor Destroy;
    procedure CNCtlColorStatic(var Message: TWMCtlColorStatic); message CN_CTLCOLORSTATIC;
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure AdjustBounds;
    procedure SetAlignment(Value: TAlignment);
    procedure SetBorderStyle(Value: TStaticBorderStyle);
    procedure SetFocusControl(Value: TWinControl);
    procedure SetShowAccelChar(Value: Boolean);
    procedure SetTransparent(const Value: Boolean);
    function GetTransparent: Boolean;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetAutoSize(Value: Boolean); override;
    property Alignment: TAlignment read FAlignment write SetAlignment
      default taLeftJustify;
    property AutoSize: Boolean read FAutoSize write SetAutoSize default True;
    property BorderStyle: TStaticBorderStyle read FBorderStyle
      write SetBorderStyle default sbsNone;
    property FocusControl: TWinControl read FFocusControl write SetFocusControl;
    property ShowAccelChar: Boolean read FShowAccelChar write SetShowAccelChar
      default True;
    property Transparent: Boolean read GetTransparent write SetTransparent
      default True;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TStaticText = class(TCustomStaticText)
  strict private
    class constructor Create;
    class destructor Destroy;
  published
    property Align;
    property Alignment;
    property Anchors;
    property AutoSize;
    property BevelEdges;
    property BevelInner;
    property BevelKind default bkNone;
    property BevelOuter;
    property BiDiMode;
    property BorderStyle;
    property Caption;
    property Color nodefault;
    property Constraints;
    property DoubleBuffered;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property FocusControl;
    property Font;
    property ParentBiDiMode;
    property ParentColor;
    property ParentDoubleBuffered;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowAccelChar;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Touch;
    property Transparent;
    property Visible;
    property StyleElements;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnGesture;
    property OnMouseActivate;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  end;

  TSelection = record
    StartPos, EndPos: Integer;
  end;

  TScrollBarStyleHook = class(TMouseTrackControlStyleHook)
  public type
    {$REGION 'TScrollWindow'}
    TScrollWindow = class(TWinControl)
    strict private
      FSizeBox: Boolean;
      FStyleHook: TScrollBarStyleHook;
      FVertical: Boolean;
      procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
      procedure WMEraseBkgnd(var Message: TMessage); message WM_ERASEBKGND;
      procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    strict protected
      procedure CreateParams(var Params: TCreateParams); override;
      procedure WndProc(var Message: TMessage); override;
    public
      constructor Create(AOwner: TComponent); override;
      property SizeBox: Boolean read FSizeBox write FSizeBox;
      property StyleHook: TScrollBarStyleHook read FStyleHook write FStyleHook;
      property Vertical: Boolean read FVertical write FVertical;
    end;
    {$ENDREGION}
  strict private
    FScrollWnd: TScrollWindow;
    FVSliderState, FVUpState, FVDownState: TThemedScrollBar;
    FHSliderState, FHUpState, FHDownState: TThemedScrollBar;
    function ControlBounds: TRect;
    function Horizontal: Boolean;
    function HorzDownButtonRect: TRect;
    function HorzScrollRect: TRect;
    function HorzSliderRect: TRect;
    function HorzTrackRect: TRect;
    function HorzUpButtonRect: TRect;
    procedure InitScrollBar;
    procedure PaintScrollBar;
    function VertDownButtonRect: TRect;
    function VertScrollRect: TRect;
    function VertSliderRect: TRect;
    function VertTrackRect: TRect;
    function VertUpButtonRect: TRect;
    procedure UpdateScrollBar;
    procedure CMVisibleChanged(var Message: TMessage); message CM_VISIBLECHANGED;
    procedure CNHScroll(var Message: TWMHScroll); message CN_HSCROLL;
    procedure CNVScroll(var Message: TWMVScroll); message CN_VSCROLL;
    procedure WMPaint(var Message: TMessage); message WM_PAINT;
    procedure WMNCPaint(var Message: TMessage); message WM_NCPAINT;
    procedure WMLButtonDown(var Message: TWMMouse); message WM_LBUTTONDOWN;
    procedure WMLButtonUp(var Message: TWMMouse); message WM_LBUTTONUP;
    procedure WMLButtonDblClk(var Message: TWMMouse); message WM_LBUTTONDBLCLK;
    procedure WMMouseMove(var Message: TWMMouse); message WM_MOUSEMOVE;
    procedure WMMouseWheel(var Message: TMessage); message WM_MOUSEWHEEL;
    procedure WMSetFocus(var Message: TMessage); message WM_SETFOCUS;
    procedure WMKillFocus(var Message: TMessage); message WM_KILLFOCUS;
    procedure WMKeyDown(var Message: TMessage); message WM_KEYDOWN;
    procedure WMKeyUp(var Message: TMessage); message WM_KEYUP;
    procedure WMCaptureChanged(var Message: TMessage); message WM_CAPTURECHANGED;
    procedure WMSize(var Message: TMessage); message WM_SIZE;
    procedure WMMove(var Message: TMessage); message WM_MOVE;
    procedure WMWindowPosChanged(var Message: TWMWindowPosChanging); message WM_WINDOWPOSCHANGED;
    procedure WMShowWindow(var Message: TWMShowWindow); message WM_SHOWWINDOW;
  strict protected
    function AcceptMessage(var Message: TMessage): Boolean; override;
    function HasBorder: Boolean; override;
    procedure MouseLeave; override;
    procedure WndProc(var Message: TMessage); override;
protected
    procedure VertDrawScroll(DC: HDC);
    procedure HorzDrawScroll(DC: HDC);
  public
    constructor Create(AControl: TWinControl); override;
    destructor Destroy;  override;
  end;

  TEditStyleHook = class(TMouseTrackControlStyleHook)
  strict private
    procedure UpdateColors;
    procedure WMNCCalcSize(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
  strict protected
    procedure PaintNC(Canvas: TCanvas); override;
    procedure WndProc(var Message: TMessage); override;
    procedure MouseEnter; override;
    procedure MouseLeave; override;
  public
    constructor Create(AControl: TWinControl); override;
  end;

  TMemoStyleHook = class(TScrollingStyleHook)
  strict private
    procedure UpdateColors;
    procedure WMNCCalcSize(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
  strict protected
    procedure WndProc(var Message: TMessage); override;
  public
    constructor Create(AControl: TWinControl); override;
  end;

  TListBoxStyleHook = class(TScrollingStyleHook)
  strict private
    procedure UpdateColors;
  strict protected
    procedure WndProc(var Message: TMessage); override;
    procedure WMSetFocus(var Message: TMessage); message WM_SETFOCUS;
    procedure WMKillFocus(var Message: TMessage); message WM_KILLFOCUS;
  public
    constructor Create(AControl: TWinControl); override;
  end;

  TComboBoxStyleHook = class(TMouseTrackControlStyleHook)
  strict private
    FDownPos, FMovePos: TPoint;
    FDownSliderPos: Integer;
    FOldIdx, FInvsibleCount, FSliderSize: Integer;
    FVSliderState, FVUpState, FVDownState: TThemedScrollBar;
    FIgnoreStyleChanged: Boolean;
    FMouseOnButton: Boolean;
    FListHandle, FEditHandle: HWnd;
    FListBoxInstance: Pointer;
    FDefListBoxProc: Pointer;
    FListBoxTimerCode: Integer;
    FListBoxUpBtnDown, FListBoxDownBtnDown,
    FListBoxTrackUpDown, FListBoxTrackDownDown: Boolean;
    procedure DrawListBoxVertScroll(DC: HDC);
    procedure DrawListBoxBorder;
    function DroppedDown: Boolean;
    function GetButtonRect: TRect;
    function Style: TComboBoxStyle;
    function ListBoxBoundsRect: TRect;
    function ListBoxClientRect: TRect;
    procedure ListBoxSetTimer(ATimerCode: Integer);
    procedure ListBoxStopTimer;
    function ListBoxVertScrollRect: TRect;
    function ListBoxVertDownButtonRect: TRect;
    function ListBoxVertUpButtonRect: TRect;
    function ListBoxVertScrollArea: TRect;
    function ListBoxVertSliderRect: TRect;
    function ListBoxVertTrackRect: TRect;
    function ListBoxVertTrackRectUp: TRect;
    function ListBoxVertTrackRectDown: TRect;
    procedure PaintListBoxBorder(Canvas: TCanvas; const R: TRect);
    procedure UpdateColors;
    procedure WMCommand(var Message: TWMCommand); message WM_COMMAND;
    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
    procedure WMPaint(var Message: TMessage); message WM_PAINT;
    procedure WMMouseMove(var Message: TWMMouse); message WM_MOUSEMOVE;
    procedure CNDrawItem(var Message: TWMDrawItem); message CN_DRAWITEM;
    procedure WMDrawItem(var Message: TWMDrawItem); message WM_DRAWITEM;
    procedure WMParentNotify(var Message: TMessage); message WM_PARENTNOTIFY;
  strict protected
    function IsChildHandle(AHandle: HWnd): Boolean; override;
    function AcceptMessage(var Message: TMessage): Boolean; override;
    procedure DrawItem(Canvas: TCanvas; Index: Integer;
      const R: TRect; Selected: Boolean); virtual;
    procedure HookListBox(AListHandle: HWND);
    property ListBoxInstance: Pointer read FListBoxInstance;
    procedure ListBoxWndProc(var Msg: TMessage); virtual;
    property ListHandle: HWND read FListHandle;
    procedure MouseEnter; override;
    procedure MouseLeave; override;
    procedure PaintBorder(Canvas: TCanvas); virtual;
    procedure WndProc(var Message: TMessage); override;
    property ButtonRect: TRect read GetButtonRect;
    property MouseOnButton: Boolean read FMouseOnButton write FMouseOnButton;
  public
    constructor Create(AControl: TWinControl); override;
    destructor Destroy; override;
  end;

  TButtonStyleHook = class(TMouseTrackControlStyleHook)
  strict private
    FOldMouseInControl: Boolean;
    procedure CNNotify(var Message: TWMNotify); message CN_NOTIFY;
    procedure WMLButtonDown(var Message: TWMMouse); message WM_LBUTTONDOWN;
    procedure WMLButtonDblClk(var Message: TWMMouse); message WM_LBUTTONDBLCLK;
    procedure WMLButtonUp(var Message: TWMMouse); message WM_LBUTTONUP;
    procedure WMMouseMove(var Message: TWMMouse); message WM_MOUSEMOVE;
    procedure WMKeyDown(var Message: TMessage); message WM_KEYDOWN;
    procedure WMKeyUp(var Message: TMessage); message WM_KEYUP;
    procedure WMSetFocus(var Message: TMessage); message WM_SETFOCUS;
    procedure WMKillFocus(var Message: TMessage); message WM_KILLFOCUS;
    function AnimationEnabled: Boolean;
    function StartAnimation(ADC: HDC): Boolean;
    procedure PrepareAnimationDC(ADC: HDC; AMouseInControl: Boolean; ARendering: Boolean);
  strict protected
    FPressed: Boolean;
    FMouseDown: Boolean;
    FDropDown: Boolean;
    procedure DrawButton(ACanvas: TCanvas; AMouseInControl: Boolean); virtual;
    procedure DoClick;
    procedure MouseEnter; override;
    procedure MouseLeave; override;
    procedure Paint(Canvas: TCanvas); override;
    function InternalPaint(ADC: HDC): Boolean; override;
    procedure PaintBackground(Canvas: TCanvas); override;
    procedure WndProc(var Message: TMessage); override;
  public
    constructor Create(AControl: TWinControl); override;
  end;

  TCheckBoxStyleHook = class(TMouseTrackControlStyleHook)
  strict private
    FPressed: Boolean;
    procedure WMLButtonDown(var Message: TWMMouse); message WM_LBUTTONDOWN;
    procedure WMLButtonUp(var Message: TWMMouse); message WM_LBUTTONUP;
    procedure WMLButtonDblClk(var Message: TWMMouse); message WM_LBUTTONDBLCLK;
    procedure WMKeyDown(var Message: TWMKeyDown); message WM_KEYDOWN;
    procedure WMKeyUp(var Message: TWMKeyUp); message WM_KEYUP;
    procedure BMSetCheck(var Message: TMessage); message BM_SETCHECK;
    function RightAlignment: Boolean;
  strict protected
    function GetDrawState(State: TCheckBoxState): TThemedButton; virtual;
    procedure Paint(Canvas: TCanvas); override;
    procedure PaintBackground(Canvas: TCanvas); override;
    procedure MouseEnter; override;
    procedure MouseLeave; override;
    procedure WndProc(var Message: TMessage); override;
    property Pressed: Boolean read FPressed;
  public
    constructor Create(AControl: TWinControl); override;
  end;

  TRadioButtonStyleHook = class(TCheckBoxStyleHook)
  strict protected
    function GetDrawState(State: TCheckBoxState): TThemedButton; override;
    procedure WndProc(var Message: TMessage); override;
  public
    constructor Create(AControl: TWinControl); override;
  end;

  TGroupBoxStyleHook = class(TStyleHook)
  strict private
    function GetCaptionRect(Canvas: TCanvas): TRect;
    function GetBoxRect(Canvas: TCanvas): TRect;
    procedure WMEraseBkgnd(var Message: TMessage); message WM_ERASEBKGND;
    procedure WMPaint(var Message: TMessage); message WM_PAINT;
  strict protected
    procedure Paint(Canvas: TCanvas); override;
    procedure PaintBackground(Canvas: TCanvas); override;
    procedure WndProc(var Message: TMessage); override;
  end;

  TStaticTextStyleHook = class(TStyleHook)
  strict protected
    procedure Paint(Canvas: TCanvas); override;
    procedure PaintNC(Canvas: TCanvas); override;
    procedure WndProc(var Message: TMessage); override;
  public
    constructor Create(AControl: TWinControl); override;
  end;

implementation

uses
{$IF DEFINED(CLR)}
  System.Runtime.InteropServices, System.Security, System.Security.Permissions, Types,
{$ENDIF}
  Vcl.Consts, System.RTLConsts, Vcl.ActnList, Winapi.UxTheme, Winapi.DwmApi,
  System.Types, System.UITypes, System.StrUtils, Vcl.ExtCtrls;

function HasPopup(Control: TControl): Boolean;
begin
  Result := True;
  while Control <> nil do
    if TCustomEdit(Control).PopupMenu <> nil then Exit else Control := Control.Parent;
  Result := False;
end;

type
  TMemoStrings = class(TStrings)
  private
    Memo: TCustomMemo;
  protected
    function Get(Index: Integer): string; override;
    function GetCount: Integer; override;
    function GetTextStr: string; override;
    procedure Put(Index: Integer; const S: string); override;
    procedure SetTextStr(const Value: string); override;
    procedure SetUpdateState(Updating: Boolean); override;
  public
    procedure Clear; override;
    procedure Delete(Index: Integer); override;
    procedure Insert(Index: Integer; const S: string); override;
  end;

  TComboBoxStrings = class(TCustomComboBoxStrings)
  public
    function Add(const S: string): Integer; override;
    procedure Insert(Index: Integer; const S: string); override;
  end;

  TListBoxStrings = class(TStrings)
  private
    ListBox: TCustomListBox;
  protected
    procedure Put(Index: Integer; const S: string); override;
    function Get(Index: Integer): string; override;
    function GetCount: Integer; override;
    function GetObject(Index: Integer): TObject; override;
    procedure PutObject(Index: Integer; AObject: TObject); override;
    procedure SetUpdateState(Updating: Boolean); override;
  public
    function Add(const S: string): Integer; override;
    procedure Clear; override;
    procedure Delete(Index: Integer); override;
    procedure Exchange(Index1, Index2: Integer); override;
    function IndexOf(const S: string): Integer; override;
    procedure Insert(Index: Integer; const S: string); override;
    procedure Move(CurIndex, NewIndex: Integer); override;
  end;

{$IF DEFINED(CLR)}
  TGCHandleList = class sealed(HashTable)
  strict private
    procedure FreeHandles;
  strict protected
    procedure Finalize; override;
  public
    procedure Clear; override;
  end;

{ TGCHandleList }

procedure TGCHandleList.Finalize;
begin
  FreeHandles;
  inherited Finalize;
end;

procedure TGCHandleList.FreeHandles;
var
  LHandle: GCHandle;
  LEnumerator: IEnumerator;
begin
  LEnumerator := Values.GetEnumerator;
  while LEnumerator.MoveNext do
  begin
    LHandle := GChandle(LEnumerator.Current);
    if (IntPtr(LHandle) <> nil) and LHandle.IsAllocated then
      LHandle.Free;
  end;
end;

procedure TGCHandleList.Clear;
begin
  FreeHandles;
  inherited Clear;
end;
{$ENDIF}

const
  BorderStyles: array[TBorderStyle] of DWORD = (0, WS_BORDER);

{ TCustomGroupBox }

class constructor TCustomGroupBox.Create;
begin
  TCustomStyleEngine.RegisterStyleHook(TCustomGroupBox, TGroupBoxStyleHook);
end;

constructor TCustomGroupBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := [csAcceptsControls, csCaptureMouse, csClickEvents,
    csSetCaption, csDoubleClicks, csReplicatable, csParentBackground, csGestures];
  Width := 185;
  Height := 105;
end;

class destructor TCustomGroupBox.Destroy;
begin
  TCustomStyleEngine.UnRegisterStyleHook(TCustomGroupBox, TGroupBoxStyleHook);
end;

procedure TCustomGroupBox.UpdateStyleElements;
begin
  Invalidate;
end;

procedure TCustomGroupBox.AdjustClientRect(var Rect: TRect);
begin
  inherited AdjustClientRect(Rect);
  Canvas.Font := Font;
  Inc(Rect.Top, Canvas.TextHeight('0'));
  InflateRect(Rect, -1, -1);
  if Ctl3d then InflateRect(Rect, -1, -1);
end;

procedure TCustomGroupBox.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params.WindowClass do
    style := style and not (CS_HREDRAW or CS_VREDRAW);
end;

procedure TCustomGroupBox.Paint;
var
  H: Integer;
  R: TRect;
  Flags: Longint;
  CaptionRect,
  OuterRect: TRect;
  Size: TSize;
  Box: TThemedButton;
  Details: TThemedElementDetails;
begin
  with Canvas do
  begin
    Font := Self.Font;

    if ThemeControl(Self) then
    begin
      if Text <> '' then
      begin
        GetTextExtentPoint32(Handle, Text, Length(Text), Size);
        CaptionRect := Rect(0, 0, Size.cx, Size.cy);
        if not UseRightToLeftAlignment then
          OffsetRect(CaptionRect, 8, 0)
        else
          OffsetRect(CaptionRect, Width - 8 - CaptionRect.Right, 0);
      end
      else
        CaptionRect := Rect(0, 0, 0, 0);

      OuterRect := ClientRect;
      OuterRect.Top := (CaptionRect.Bottom - CaptionRect.Top) div 2;
      with CaptionRect do
        ExcludeClipRect(Handle, Left, Top, Right, Bottom);
      if Enabled then
        Box := tbGroupBoxNormal
      else
        Box := tbGroupBoxDisabled;
      Details := StyleServices.GetElementDetails(Box);
      StyleServices.DrawElement(Handle, Details, OuterRect);

      SelectClipRgn(Handle, 0);
      Brush.Style := bsClear;
      if Text <> '' then
        StyleServices.DrawText(Handle, Details, Text, CaptionRect, [tfLeft]);
    end
    else
    begin
      H := TextHeight('0');
      R := Rect(0, H div 2 - 1, Width, Height);
      if Ctl3D then
      begin
        Inc(R.Left);
        Inc(R.Top);
        Brush.Color := clBtnHighlight;
        FrameRect(R);
        OffsetRect(R, -1, -1);
        Brush.Color := clBtnShadow;
      end else
        Brush.Color := clWindowFrame;
      FrameRect(R);
      if Text <> '' then
      begin
        if not UseRightToLeftAlignment then
          R := Rect(8, 0, 0, H)
        else
          R := Rect(R.Right - Canvas.TextWidth(Text) - 8, 0, 0, H);
        Flags := DrawTextBiDiModeFlags(DT_SINGLELINE);
        DrawText(Handle, Text, Length(Text), R, Flags or DT_CALCRECT);
        Brush.Color := Color;
        DrawText(Handle, Text, Length(Text), R, Flags);
      end;
    end;
  end;
end;

procedure TCustomGroupBox.CMDialogChar(var Message: TCMDialogChar);
begin
  with Message do
    if IsAccel(CharCode, Caption) and CanFocus then
    begin
      SelectFirst;
      Result := 1;
    end else
      inherited;
end;

procedure TCustomGroupBox.CMTextChanged(var Message: TMessage);
begin
  Invalidate;
  Realign;
end;

procedure TCustomGroupBox.CMCtl3DChanged(var Message: TMessage);
begin
  inherited;
  Invalidate;
  Realign;
end;

procedure TCustomGroupBox.WMSize(var Message: TWMSize);
begin
  inherited;
  Invalidate;
end;

{ TCustomLabel }

constructor TCustomLabel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable];
  Width := 65;
  Height := 17;
  FAutoSize := True;
  FShowAccelChar := True;
  { The "default" value for the Transparent property depends on
    if you have Themes available and enabled or not. If you have
    ever explicitly set it, that will override the default value. }
  if StyleServices.Enabled then
    ControlStyle := ControlStyle - [csOpaque]
  else
    ControlStyle := ControlStyle + [csOpaque];
  UpdateDrawTextProc;
end;

procedure TCustomLabel.CMEnabledChanged(var Message: TMessage);
begin
  if TStyleManager.IsCustomStyleActive then
    UpdateDrawTextProc;
  inherited;
end;

function TCustomLabel.GetLabelText: string;
begin
  Result := Caption;
end;

procedure TCustomLabel.DoDrawThemeTextEx(DC: HDC; const Text: UnicodeString;
  var TextRect: TRect; TextFlags: Cardinal);
const
  CStates: array[Boolean] of TThemedTextLabel = (ttlTextLabelDisabled, ttlTextLabelNormal);
var
  LFormat: TTextFormat;
  LOptions: TStyleTextOptions;
begin
  LFormat := TTextFormatFlags(TextFlags);
  if csGlassPaint in ControlState then
    Include(LFormat, tfComposited);

  LOptions.Flags := [stfTextColor, stfGlowSize];
  LOptions.TextColor := Canvas.Font.Color;
  LOptions.GlowSize := FGlowSize;

  StyleServices.DrawText(DC,
    StyleServices.GetElementDetails(CStates[Enabled]), Text, TextRect, LFormat, LOptions);
end;

procedure TCustomLabel.DoDrawNormalText(DC: HDC; const Text: UnicodeString;
  var TextRect: TRect; TextFlags: Cardinal);
begin
  Winapi.Windows.DrawTextW(DC, Text, Length(Text), TextRect, TextFlags);
end;

procedure TCustomLabel.DoDrawText(var Rect: TRect; Flags: Longint);
const
  EllipsisStr = '...';
  Ellipsis: array[TEllipsisPosition] of Longint = (0, DT_PATH_ELLIPSIS,
    DT_END_ELLIPSIS, DT_WORD_ELLIPSIS);
var
  Text, DText: string;
  NewRect: TRect;
  Height, Delim: Integer;
begin
  Text := GetLabelText;
  if (Flags and DT_CALCRECT <> 0) and
     ((Text = '') or FShowAccelChar and (Text[1] = '&') and (Length(Text) = 1)) then
    Text := Text + ' ';

  if Text <> '' then
  begin
    if not FShowAccelChar then Flags := Flags or DT_NOPREFIX;
    Flags := DrawTextBiDiModeFlags(Flags);
    Canvas.Font := Font;
    if (FEllipsisPosition <> epNone) and not FAutoSize then
    begin
      DText := Text;
      Flags := Flags and not DT_EXPANDTABS;
      Flags := Flags or Ellipsis[FEllipsisPosition];
      if FWordWrap and (FEllipsisPosition in [epEndEllipsis, epWordEllipsis]) then
      begin
        repeat
          NewRect := Rect;
          Dec(NewRect.Right, Canvas.TextWidth(EllipsisStr));
          FDrawTextProc(Canvas.Handle, DText, NewRect, Flags or DT_CALCRECT);
          Height := NewRect.Bottom - NewRect.Top;
          if (Height > ClientHeight) and (Height > Canvas.Font.Height) then
          begin
            Delim := LastDelimiter(' '#9, Text);
            if Delim = 0 then
              Delim := Length(Text);
            Dec(Delim);
  {$IF NOT DEFINED(CLR)}
            if ByteType(Text, Delim) = mbLeadByte then
              Dec(Delim);
  {$ENDIF}
            Text := Copy(Text, 1, Delim);
            DText := Text + EllipsisStr;
            if Text = '' then
              Break;
          end else
            Break;
        until False;
      end;
      if Text <> '' then
        Text := DText;
    end;

    if Enabled or StyleServices.Enabled then
      FDrawTextProc(Canvas.Handle, Text, Rect, Flags)
    else
    begin
      OffsetRect(Rect, 1, 1);
      Canvas.Font.Color := clBtnHighlight;
      FDrawTextProc(Canvas.Handle, Text, Rect, Flags);
      OffsetRect(Rect, -1, -1);
      Canvas.Font.Color := clBtnShadow;
      FDrawTextProc(Canvas.Handle, Text, Rect, Flags);
    end;
  end;
end;

procedure FillGlassRect(Canvas: TCanvas; Rect: TRect);
var
  MemDC: HDC;
  PaintBuffer: HPAINTBUFFER;
begin
  PaintBuffer := BeginBufferedPaint(Canvas.Handle, Rect, BPBF_TOPDOWNDIB, nil, MemDC);
  try
    FillRect(MemDC, Rect, Canvas.Brush.Handle);
    BufferedPaintMakeOpaque(PaintBuffer, Rect);
  finally
    EndBufferedPaint(PaintBuffer, True);
  end;
end;

procedure TCustomLabel.Paint;
const
  Alignments: array[TAlignment] of Word = (DT_LEFT, DT_RIGHT, DT_CENTER);
  WordWraps: array[Boolean] of Word = (0, DT_WORDBREAK);
var
  Rect, CalcRect: TRect;
  DrawStyle: Longint;
begin
  with Canvas do
  begin
    Rect := ClientRect;
    if not Transparent then
    begin
      Brush.Color := Self.Color;
      Brush.Style := bsSolid;
      if not (csGlassPaint in ControlState) then
        FillRect(Rect)
      else
        FillGlassRect(Canvas, Rect);
    end;

    Brush.Style := bsClear;
    { DoDrawText takes care of BiDi alignments }
    DrawStyle := DT_EXPANDTABS or WordWraps[FWordWrap] or Alignments[FAlignment];
    { Calculate vertical layout }
    if FLayout <> tlTop then
    begin
      CalcRect := Rect;
      DoDrawText(CalcRect, DrawStyle or DT_CALCRECT);
      if FLayout = tlBottom then OffsetRect(Rect, 0, Height - CalcRect.Bottom)
      else OffsetRect(Rect, 0, (Height - CalcRect.Bottom) div 2);
    end;
    DoDrawText(Rect, DrawStyle);
  end;
end;

procedure TCustomLabel.Loaded;
begin
  inherited Loaded;
  AdjustBounds;
end;

procedure TCustomLabel.AdjustBounds;
const
  WordWraps: array[Boolean] of Word = (0, DT_WORDBREAK);
var
  DC: HDC;
  X: Integer;
  Rect: TRect;
  AAlignment: TAlignment;
begin
  if not (csReading in ComponentState) and FAutoSize then
  begin
    Rect := ClientRect;
    DC := GetDC(0);
    try
      Canvas.Handle := DC;
      DoDrawText(Rect, (DT_EXPANDTABS or DT_CALCRECT or MASK_TF_COMPOSITED) or WordWraps[FWordWrap]);
      Canvas.Handle := 0;
    finally
      ReleaseDC(0, DC);
    end;
    X := Left;
    AAlignment := FAlignment;
    if UseRightToLeftAlignment then
      ChangeBiDiModeAlignment(AAlignment);
    if AAlignment = taRightJustify then
      Inc(X, Width - Rect.Right);
    SetBounds(X, Top, Rect.Right, Rect.Bottom);
  end;
end;

procedure TCustomLabel.SetAlignment(Value: TAlignment);
begin
  if FAlignment <> Value then
  begin
    FAlignment := Value;
    Invalidate;
  end;
end;

procedure TCustomLabel.SetEllipsisPosition(Value: TEllipsisPosition);
begin
  if FEllipsisPosition <> Value then
  begin
    FEllipsisPosition := Value;
    FAutoSize := False;
    Invalidate;
  end;
end;

procedure TCustomLabel.SetAutoSize(Value: Boolean);
begin
  if FAutoSize <> Value then
  begin
    FAutoSize := Value;
    FEllipsisPosition := epNone;
    AdjustBounds;
  end;
end;

function TCustomLabel.GetTransparent: Boolean;
begin
  Result := not (csOpaque in ControlStyle);
end;

procedure TCustomLabel.SetFocusControl(Value: TWinControl);
begin
  FFocusControl := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

procedure TCustomLabel.SetGlowSize(const Value: Integer);
begin
  if Value <> FGlowSize then
  begin
    FGlowSize := Value;
    Invalidate;
  end;
end;

procedure TCustomLabel.SetShowAccelChar(Value: Boolean);
begin
  if FShowAccelChar <> Value then
  begin
    FShowAccelChar := Value;
    Invalidate;
  end;
end;

procedure TCustomLabel.SetTransparent(Value: Boolean);
begin
  if Transparent <> Value then
  begin
    if Value then
      ControlStyle := ControlStyle - [csOpaque]
    else
      ControlStyle := ControlStyle + [csOpaque];
    Invalidate;
  end;
  FTransparentSet := True;
end;

procedure TCustomLabel.SetLayout(Value: TTextLayout);
begin
  if FLayout <> Value then
  begin
    FLayout := Value;
    Invalidate;
  end;
end;

procedure TCustomLabel.SetWordWrap(Value: Boolean);
begin
  if FWordWrap <> Value then
  begin
    FWordWrap := Value;
    AdjustBounds;
    Invalidate;
  end;
end;

procedure TCustomLabel.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FFocusControl) then
    FFocusControl := nil;
end;

procedure TCustomLabel.CMTextChanged(var Message: TMessage);
begin
  Invalidate;
  AdjustBounds;
end;

procedure TCustomLabel.UpdateStyleElements;
begin
  Perform(CM_STYLECHANGED, 0, 0);
end;

procedure TCustomLabel.CMStyleChanged(var Message: TMessage);
begin
  inherited;
  if StyleServices.Enabled and (seClient in StyleElements) then
    ControlStyle := ControlStyle - [csOpaque]
  else
  if not Transparent then
    ControlStyle := ControlStyle + [csOpaque];
  UpdateDrawTextProc;
  Invalidate;
end;

procedure TCustomLabel.CMFontChanged(var Message: TMessage);
begin
  inherited;
  AdjustBounds;
end;

procedure TCustomLabel.CMDialogChar(var Message: TCMDialogChar);
begin
  if (FFocusControl <> nil) and Enabled and ShowAccelChar and
    IsAccel(Message.CharCode, Caption) then
    with FFocusControl do
      if CanFocus then
      begin
        SetFocus;
        Message.Result := 1;
      end;
end;

procedure TCustomLabel.UpdateDrawTextProc;
begin
  if StyleServices.Enabled then
  begin
    if Enabled and TStyleManager.IsCustomStyleActive and not (seFont in StyleElements) then
      FDrawTextProc := DoDrawNormalText
    else
      FDrawTextProc := DoDrawThemeTextEx;
  end
  else
    FDrawTextProc := DoDrawNormalText;
end;

{ TCustomEdit }

class constructor TCustomEdit.Create;
begin
  TCustomStyleEngine.RegisterStyleHook(TCustomEdit, TEditStyleHook);
end;

constructor TCustomEdit.Create(AOwner: TComponent);
const
  EditStyle = [csClickEvents, csSetCaption, csDoubleClicks, csFixedHeight, csPannable];
begin
  inherited Create(AOwner);
  if NewStyleControls then
    ControlStyle := EditStyle else
    ControlStyle := EditStyle + [csFramed];
  Width := 121;
  Height := 25;
  TabStop := True;
  ParentColor := False;
  FBorderStyle := bsSingle;
  FAlignment := taLeftJustify;
  FAutoSize := True;
  FAutoSelect := True;
  FHideSelection := True;
  AdjustHeight;
  FOldSelLength := -1;
  FOldSelStart := -1;
  FNumbersOnly := False;
  FTextHint := '';
  FInBufferedPrintClient := False;
  TipMode := tipOpen;
end;

class destructor TCustomEdit.Destroy;
begin
  TCustomStyleEngine.UnRegisterStyleHook(TCustomEdit, TEditStyleHook);
end;

procedure TCustomEdit.DoSetMaxLength(Value: Integer);
begin
  SendMessage(Handle, EM_LIMITTEXT, Value, 0)
end;

procedure TCustomEdit.DoSetTextHint(const Value: string);
begin
  if CheckWin32Version(5, 1) and StyleServices.Enabled and HandleAllocated then
    SendTextMessage(Handle, EM_SETCUEBANNER, WPARAM(0), Value);
end;

procedure TCustomEdit.SetAlignment(Value: TAlignment);
begin
  if FAlignment <> Value then
  begin
    FAlignment := Value;
    RecreateWnd;
  end;
end;

procedure TCustomEdit.SetAutoSize(Value: Boolean);
begin
  if FAutoSize <> Value then
  begin
    FAutoSize := Value;
    UpdateHeight;
  end;
end;

procedure TCustomEdit.SetBorderStyle(Value: TBorderStyle);
begin
  if FBorderStyle <> Value then
  begin
    FBorderStyle := Value;
    UpdateHeight;
    RecreateWnd;
  end;
end;

procedure TCustomEdit.SetCharCase(Value: TEditCharCase);
begin
  if FCharCase <> Value then
  begin
    FCharCase := Value;
    RecreateWnd;
  end;
end;

procedure TCustomEdit.SetTextHint(const Value: string);
begin
  if FTextHint <> Value then
  begin
    FTextHint := Value;
    if not (csLoading in ComponentState) then
      DoSetTextHint(FTextHint);
  end;
end;

procedure TCustomEdit.SetHideSelection(Value: Boolean);
begin
  if FHideSelection <> Value then
  begin
    FHideSelection := Value;
    RecreateWnd;
  end;
end;

procedure TCustomEdit.SetMaxLength(Value: Integer);
begin
  if FMaxLength <> Value then
  begin
    FMaxLength := Value;
    if HandleAllocated then DoSetMaxLength(Value);
  end;
end;

procedure TCustomEdit.SetOEMConvert(Value: Boolean);
begin
  if FOEMConvert <> Value then
  begin
    FOEMConvert := Value;
    RecreateWnd;
  end;
end;

function TCustomEdit.GetModified: Boolean;
begin
  Result := FModified;
  if HandleAllocated then Result := SendMessage(Handle, EM_GETMODIFY, 0, 0) <> 0;
end;

function TCustomEdit.GetReadOnly: Boolean;
begin
  Result := FReadOnly;
end;

function TCustomEdit.GetCanUndo: Boolean;
begin
  Result := False;
  if HandleAllocated then Result := SendMessage(Handle, EM_CANUNDO, 0, 0) <> 0;
end;

procedure TCustomEdit.SetModified(Value: Boolean);
begin
  if HandleAllocated then
    SendMessage(Handle, EM_SETMODIFY, Byte(Value), 0) else
    FModified := Value;
end;

procedure TCustomEdit.SetNumbersOnly(Value: Boolean);
begin
  if FNumbersOnly <> Value then
  begin
    FNumbersOnly := Value;
    if HandleAllocated then
    begin
      if FNumbersOnly then
        SetWindowLong(Handle, GWL_STYLE, GetWindowLong(Handle, GWL_STYLE) or ES_NUMBER)
      else
        SetWindowLong(Handle, GWL_STYLE, GetWindowLong(Handle, GWL_STYLE) and not ES_NUMBER);
    end;
  end;
end;

procedure TCustomEdit.SetPasswordChar(Value: Char);
begin
  if FPasswordChar <> Value then
  begin
    FPasswordChar := Value;
    if HandleAllocated then
      RecreateWnd;
  end;
end;

procedure TCustomEdit.SetReadOnly(Value: Boolean);
begin
  if FReadOnly <> Value then
  begin
    FReadOnly := Value;
    if HandleAllocated then
      SendMessage(Handle, EM_SETREADONLY, Ord(Value), 0);
  end;
  FSaveReadOnly := FReadOnly;
end;

{$IF DEFINED(CLR)}
procedure TCustomEdit.SendGetSel(var SelStart, SelEnd: Integer);
var
  LAnsiStr: AnsiString;
begin
  SendGetIntMessage(Handle, EM_GETSEL, SelStart, SelEnd);

  // On MBCS Win98/ME systems, make sure we return number of
  // characters instead of number of bytes that are selected
  if SysLocale.FarEast and (Marshal.SystemDefaultCharSize = 1) then
  begin
    LAnsiStr := AnsiString(Text);
    SelStart := Length(WideString(Copy(LAnsiStr, 1, SelStart)));
    SelEnd := Length(WideString(Copy(LAnsiStr, 1, SelEnd)));
  end;
end;
{$ENDIF}

function TCustomEdit.GetSelStart: Integer;
{$IF DEFINED(CLR)}
var
  Temp: Integer;
begin
  SendGetSel(Result, Temp);
{$ELSE}
begin
  SendMessage(Handle, EM_GETSEL, WPARAM(@Result), 0);
{$ENDIF}
end;

procedure TCustomEdit.SetSelStart(Value: Integer);
begin
  SendMessage(Handle, EM_SETSEL, Value, Value);
end;

function TCustomEdit.GetSelLength: Integer;
var
  Selection: TSelection;
begin
{$IF DEFINED(CLR)}
  SendGetSel(Selection.StartPos, Selection.EndPos);
{$ELSE}
  SendMessage(Handle, EM_GETSEL, WPARAM(@Selection.StartPos), LPARAM(@Selection.EndPos));
{$ENDIF}
  Result := Selection.EndPos - Selection.StartPos;
end;

procedure TCustomEdit.SetSelLength(Value: Integer);
var
  Selection: TSelection;
begin
{$IF DEFINED(CLR)}
  SendGetSel(Selection.StartPos, Selection.EndPos);
{$ELSE}
  SendMessage(Handle, EM_GETSEL, WPARAM(@Selection.StartPos), LPARAM(@Selection.EndPos));
{$ENDIF}
  Selection.EndPos := Selection.StartPos + Value;
  SendMessage(Handle, EM_SETSEL, Selection.StartPos, Selection.EndPos);
  SendMessage(Handle, EM_SCROLLCARET, 0, 0);
end;

procedure TCustomEdit.UpdateTIPStatus;
begin
  // If Memo/Edit control is ReadOnly, Force close TIP(on-screen keyboard)
  // otherwise, use standard behavior.
  if ReadOnly then SetTextInputPanelStatus(Self, False)
  else
    inherited UpdateTIPStatus;
end;

procedure TCustomEdit.Clear;
begin
  SetWindowText(Handle, '');
end;

procedure TCustomEdit.ClearSelection;
begin
  SendMessage(Handle, WM_CLEAR, 0, 0);
end;

procedure TCustomEdit.CopyToClipboard;
begin
  SendMessage(Handle, WM_COPY, 0, 0);
end;

procedure TCustomEdit.CutToClipboard;
begin
  SendMessage(Handle, WM_CUT, 0, 0);
end;

[UIPermission(SecurityAction.LinkDemand, Clipboard=UIPermissionClipboard.AllClipboard)]
procedure TCustomEdit.PasteFromClipboard;
begin
  SendMessage(Handle, WM_PASTE, 0, 0);
end;

procedure TCustomEdit.Undo;
begin
  SendMessage(Handle, WM_UNDO, 0, 0);
end;

procedure TCustomEdit.ClearUndo;
begin
  SendMessage(Handle, EM_EMPTYUNDOBUFFER, 0, 0);
end;

procedure TCustomEdit.SelectAll;
begin
  SendMessage(Handle, EM_SETSEL, 0, -1);
end;

{$IF NOT DEFINED(CLR)}
function TCustomEdit.GetSelTextBuf(Buffer: PChar; BufSize: Integer): Integer;
var
  P: PChar;
  StartPos: Integer;
begin
  StartPos := GetSelStart;
  Result := GetSelLength;
  P := StrAlloc(GetTextLen + 1);
  try
    GetTextBuf(P, StrBufSize(P));
    if Result >= BufSize then Result := BufSize - 1;
    StrLCopy(Buffer, P + StartPos, Result);
  finally
    StrDispose(P);
  end;
end;
{$ENDIF}

{$IF NOT DEFINED(CLR)}
procedure TCustomEdit.SetSelTextBuf(Buffer: PChar);
begin
  SendMessage(Handle, EM_REPLACESEL, 0, LPARAM(Buffer));
end;
{$ENDIF}

function TCustomEdit.GetSelText: string;
{$IF DEFINED(CLR)}
var
  SelStart, SelEnd: Integer;
begin
  SendGetSel(SelStart, SelEnd);
  Result := Copy(Text, SelStart + 1, SelEnd - SelStart);
{$ELSE}
var
  P: PChar;
  SelStart, Len: Integer;
begin
  SelStart := GetSelStart;
  Len := GetSelLength;
  SetString(Result, PChar(nil), Len);
  if Len <> 0 then
  begin
    P := StrAlloc(GetTextLen + 1);
    try
      GetTextBuf(P, StrBufSize(P));
      Move(P[SelStart], Pointer(Result)^, Len * SizeOf(Char));
    finally
      StrDispose(P);
    end;
  end;
{$ENDIF}
end;

procedure TCustomEdit.KeyDown(var Key: Word; Shift: TShiftState);
var
  LEditLink: Boolean;
begin
  inherited;
  LEditLink := Observers.IsObserving(TObserverMapping.EditLinkID);
  if (Key = VK_DELETE) or ((Key = VK_INSERT) and (ssShift in Shift)) then
  begin
    if LEditLink and TLinkObservers.EditLinkEdit(Observers) then
      TLinkObservers.EditLinkModified(Observers);
    if Observers.IsObserving(TObserverMapping.ControlValueID) then
      TLinkObservers.ControlValueModified(Observers);
  end;
end;

procedure TCustomEdit.KeyPress(var Key: Char);
var
  LEditLink: Boolean;
begin
  inherited;
  LEditLink := Observers.IsObserving(TObserverMapping.EditLinkID);
  if LEditLink and (Key >= #32) and
    not TLinkObservers.EditLinkIsValidChar(Observers, Key) then
  begin
    MessageBeep(0);
    Key := #0;
  end;
  case Key of
    ^H, ^V, ^X, #32..High(Char):
      if LEditLink and not TLinkObservers.EditLinkEdit(Observers) then
        Key := #0
      else
      begin
        if LEditLink then TLinkObservers.EditLinkModified(Observers);
        if Observers.IsObserving(TObserverMapping.ControlValueID) then
           TLinkObservers.ControlValueModified(Observers);
      end;
    #27:
      begin
        if LEditLink then
        begin
          if TLinkObservers.EditLinkIsEditing(Observers) then
          begin
            TLinkObservers.EditLinkReset(Observers);
            SelectAll;
          end;
          Key := #0;
        end;
      end;
    Char(VK_RETURN):
      begin
        if Observers.IsObserving(TObserverMapping.EditLinkID) then
          if TLinkObservers.EditLinkIsEditing(Observers) then
            if TLinkObservers.EditLinkTrackUpdate(Observers) then
              Key := #0; // No beep if tracking (note that descendent classes like TMemo will not get VK_RETURN)
        if Observers.IsObserving(TObserverMapping.ControlValueID) then
        begin
          if TLinkObservers.ControlValueTrackUpdate(Observers) then
            Key := #0;
        end;
      end;
  end;
end;

function TCustomEdit.CanObserve(const ID: Integer): Boolean;
begin
  Result := False;
  if ID = TObserverMapping.EditLinkID then
    Result := True
  else if ID = TObserverMapping.ControlValueID then
    Result := True;
end;

procedure TCustomEdit.ObserverAdded(const ID: Integer;
  const Observer: IObserver);
begin
  if ID = TObserverMapping.EditLinkID then
    Observer.OnObserverToggle := ObserverToggle;
end;

procedure TCustomEdit.ObserverToggle(const AObserver: IObserver;
  const Value: Boolean);
var
  LEditLinkObserver: IEditLinkObserver;
  LSaveReadOnly: Boolean;
begin
  if Supports(AObserver, IEditLinkObserver, LEditLinkObserver) then
  begin
    if Value then
    begin
      LSaveReadOnly := ReadOnly;
      if LEditLinkObserver.IsReadOnly then
        ReadOnly := True;
      FSaveReadOnly := LSaveReadOnly;
    end
    else
      if not (csDestroying in ComponentState) then
        ReadOnly := FSaveReadOnly;
  end;
end;

procedure TCustomEdit.SetSelText(const Value: string);
begin
{$IF DEFINED(CLR)}
  if not Assigned(Value) then
    SendTextMessage(Handle, EM_REPLACESEL, 0, '')
  else
{$ENDIF}
    SendTextMessage(Handle, EM_REPLACESEL, 0, Value);
end;

procedure TCustomEdit.CreateParams(var Params: TCreateParams);
const
  Alignments: array[Boolean, TAlignment] of DWORD =
    ((ES_LEFT, ES_RIGHT, ES_CENTER),(ES_RIGHT, ES_LEFT, ES_CENTER));
  Passwords: array[Boolean] of DWORD = (0, ES_PASSWORD);
  ReadOnlys: array[Boolean] of DWORD = (0, ES_READONLY);
  CharCases: array[TEditCharCase] of DWORD = (0, ES_UPPERCASE, ES_LOWERCASE);
  HideSelections: array[Boolean] of DWORD = (ES_NOHIDESEL, 0);
  OEMConverts: array[Boolean] of DWORD = (0, ES_OEMCONVERT);
  NumbersOnlyStyle: array[Boolean] of DWORD = (0, ES_NUMBER);
begin
  inherited CreateParams(Params);
  CreateSubClass(Params, 'EDIT');
  with Params do
  begin
    Style := Style or (ES_AUTOHSCROLL or ES_AUTOVSCROLL) or
      Alignments[UseRightToLeftAlignment, FAlignment] or
      BorderStyles[FBorderStyle] or Passwords[FPasswordChar <> #0] or
      NumbersOnlyStyle[FNumbersOnly] or
      ReadOnlys[FReadOnly] or CharCases[FCharCase] or
      HideSelections[FHideSelection] or OEMConverts[FOEMConvert];
    if NewStyleControls and Ctl3D and (FBorderStyle = bsSingle) then
    begin
      Style := Style and not WS_BORDER;
      ExStyle := ExStyle or WS_EX_CLIENTEDGE;
    end;
  end;
end;

[UIPermission(SecurityAction.LinkDemand, Window=UIPermissionWindow.AllWindows)]
procedure TCustomEdit.CreateWindowHandle(const Params: TCreateParams);
var
  P: TCreateParams;
begin
  if SysLocale.FarEast and (Win32Platform <> VER_PLATFORM_WIN32_NT) and
    ((Params.Style and ES_READONLY) <> 0) then
  begin
    // Work around Far East Win95 API/IME bug.
    P := Params;
    P.Style := P.Style and (not ES_READONLY);
    inherited CreateWindowHandle(P);
    if WindowHandle <> 0 then
      SendMessage(WindowHandle, EM_SETREADONLY, Ord(True), 0);
  end
  else
    inherited CreateWindowHandle(Params);
end;

[UIPermission(SecurityAction.LinkDemand, Window=UIPermissionWindow.AllWindows)]
procedure TCustomEdit.CreateWnd;
begin
  FCreating := True;
  try
    inherited CreateWnd;
  finally
    FCreating := False;
  end;
  DoSetMaxLength(FMaxLength);
  Modified := FModified;
  if (FPasswordChar <> #0) and not (StyleServices.Enabled and ((FPasswordChar = '*'))) then
    SendMessage(Handle, EM_SETPASSWORDCHAR, Ord(FPasswordChar), 0);
  if FOldSelStart <> -1 then
  begin
    SelStart := FOldSelStart;
    FOldSelStart := -1;
  end;
  if FOldSelLength <> -1 then
    SelLength := FOldSelLength;
  UpdateHeight;
  DoSetTextHint(FTextHint);
end;

procedure TCustomEdit.DestroyWnd;
begin
  FModified := Modified;
  FOldSelLength := SelLength;
  FOldSelStart := SelStart;
  inherited DestroyWnd;
end;

procedure TCustomEdit.UpdateHeight;
begin
  if FAutoSize and (BorderStyle = bsSingle) then
  begin
    ControlStyle := ControlStyle + [csFixedHeight];
    AdjustHeight;
  end else
    ControlStyle := ControlStyle - [csFixedHeight];
end;

procedure TCustomEdit.AdjustHeight;
var
  DC: HDC;
  SaveFont: HFont;
  I: Integer;
  SysMetrics, Metrics: TTextMetric;
begin
  DC := GetDC(0);
  try
    GetTextMetrics(DC, SysMetrics);
    SaveFont := SelectObject(DC, Font.Handle);
    GetTextMetrics(DC, Metrics);
    SelectObject(DC, SaveFont);
  finally
    ReleaseDC(0, DC);
  end;
  if NewStyleControls then
  begin
    if Ctl3D then I := 8 else I := 6;
    I := GetSystemMetrics(SM_CYBORDER) * I;
  end else
  begin
    I := SysMetrics.tmHeight;
    if I > Metrics.tmHeight then I := Metrics.tmHeight;
    I := I div 4 + GetSystemMetrics(SM_CYBORDER) * 4;
  end;
  Height := Metrics.tmHeight + I;
end;

procedure TCustomEdit.Change;
begin
  inherited Changed;
  if Assigned(FOnChange) then FOnChange(Self);
end;

procedure TCustomEdit.DefaultHandler(var Message);
{$IF DEFINED(CLR)}
var
  FocusMsg: TWMSetFocus;
  Msg: TMessage;
{$ENDIF}
begin
{$IF DEFINED(CLR)}
  Msg := UnwrapMessage(TObject(Message));
  case Msg.Msg of
{$ELSE}
  case TMessage(Message).Msg of
{$ENDIF}
    WM_SETFOCUS:
      if Win32Platform = VER_PLATFORM_WIN32_WINDOWS then
      begin
{$IF DEFINED(CLR)}
        FocusMsg := TWMSetFocus.Create(Msg);
        if not IsWindow(FocusMsg.FocusedWnd) then
          FocusMsg.FocusedWnd := 0;
{$ELSE}
        if not IsWindow(TWMSetFocus(Message).FocusedWnd) then
          TWMSetFocus(Message).FocusedWnd := 0;
{$ENDIF}
      end;
    CN_CTLCOLOREDIT:
      if (csGlassPaint in ControlState) and not FInBufferedPrintClient then
      begin
        FInBufferedPrintClient := True;
        PostMessage(Handle, CM_BUFFEREDPRINTCLIENT, 0, 0);
      end;
    CM_BUFFEREDPRINTCLIENT:
      if FInBufferedPrintClient then
      begin
        PerformBufferedPrintClient(Handle, ClientRect);
        FInBufferedPrintClient := False;
      end;
  end;
  inherited;
end;

procedure TCustomEdit.WMSetFont(var Message: TWMSetFont);
begin
  inherited;
  if NewStyleControls and
    (GetWindowLong(Handle, GWL_STYLE) and ES_MULTILINE = 0) then
    SendMessage(Handle, EM_SETMARGINS, EC_LEFTMARGIN or EC_RIGHTMARGIN, 0);
end;

procedure TCustomEdit.CMColorChanged(var Message: TMessage);
begin
  inherited;
  if HandleAllocated then
    RedrawWindow(Handle, nil, 0, RDW_INVALIDATE or RDW_FRAME);
end;

procedure TCustomEdit.CMCtl3DChanged(var Message: TMessage);
begin
  if NewStyleControls and (FBorderStyle = bsSingle) then
  begin
    UpdateHeight;
    RecreateWnd;
  end;
  inherited;
end;

procedure TCustomEdit.CMFontChanged(var Message: TMessage);
begin
  inherited;
  if (csFixedHeight in ControlStyle) and not ((csDesigning in
    ComponentState) and (csLoading in ComponentState)) then AdjustHeight;
end;

procedure TCustomEdit.CMGestureManagerChanged(var Message: TMessage);
begin
  if not (csDestroying in ComponentState) then
  begin
    if (Touch.GestureManager <> nil) then
      ControlStyle := ControlStyle + [csGestures]
    else
      ControlStyle := ControlStyle - [csGestures];
    if HandleAllocated then
      RecreateWnd;
  end;
end;

procedure TCustomEdit.CNCommand(var Message: TWMCommand);
begin
  if (Message.NotifyCode = EN_CHANGE) and not FCreating then Change;
end;

procedure TCustomEdit.CMEnter(var Message: TCMEnter);
begin
  if FAutoSelect and not (csLButtonDown in ControlState) and
    (GetWindowLong(Handle, GWL_STYLE) and ES_MULTILINE = 0) then SelectAll;
  inherited;
end;

procedure TCustomEdit.CMExit(var Message: TCMExit);
begin
  try
    if Observers.IsObserving(TObserverMapping.EditLinkID) then
      TLinkObservers.EditLinkUpdate(Observers);
    if Observers.IsObserving(TObserverMapping.ControlValueID) then
      TLinkObservers.ControlValueUpdate(Observers);
    inherited;
  except
    SelectAll;
    SetFocus;
    raise;
  end;
end;

procedure TCustomEdit.CMTextChanged(var Message: TMessage);
begin
  inherited;
  if not HandleAllocated or (GetWindowLong(Handle, GWL_STYLE) and
    ES_MULTILINE <> 0) then Change;
end;

procedure TCustomEdit.WMContextMenu(var Message: TWMContextMenu);
var
  LPoint: TPoint;
  LMessage: TMessage;
  Handled: Boolean;
begin
  SetFocus;
  if PopupMenu = nil then
  begin
    LPoint := SmallPointToPoint(Message.Pos);
    if not InvalidPoint(LPoint) then
      LPoint := ScreenToClient(LPoint);

    Handled := False;
    DoContextPopup(LPoint, Handled);
    Message.Result := Ord(Handled);
    if Handled then Exit;

{$IF DEFINED(CLR)}
    LMessage := UnwrapMessage(TObject(Message));
{$ELSE}
    LMessage := TMessage(Message);
{$ENDIF}
    with LMessage do
      Result := CallWindowProc(DefWndProc, WindowHandle, Msg, WParam, LParam)
  end
  else
    inherited;
end;

function TCustomEdit.GetControlsAlignment: TAlignment;
begin
  Result := FAlignment;
end;

{ TMemoStrings }

function TMemoStrings.GetCount: Integer;
begin
  Result := 0;
{$IF DEFINED(CLR)}
  if Memo.HandleAllocated or (Memo.WindowText <> '') then
{$ELSE}
  if Memo.HandleAllocated or (Memo.WindowText <> nil) then
{$ENDIF}
  begin
    Result := SendMessage(Memo.Handle, EM_GETLINECOUNT, 0, 0);
    if SendMessage(Memo.Handle, EM_LINELENGTH, SendMessage(Memo.Handle,
      EM_LINEINDEX, Result - 1, 0), 0) = 0 then Dec(Result);
  end;
end;

function TMemoStrings.Get(Index: Integer): string;
{$IF DEFINED(CLR)}
const
  MaxLineBytes = 4096 * 2;
begin
  SendGetTextMessage(Memo.Handle, EM_GETLINE, Index, Result, MaxLineBytes);
end;
{$ELSE}
var
  Text: array[0..4095] of Char;
begin
  Word((@Text)^) := Length(Text);
  SetString(Result, Text, SendMessage(Memo.Handle, EM_GETLINE, Index,
    LPARAM(@Text)));
end;
{$ENDIF}

procedure TMemoStrings.Put(Index: Integer; const S: string);
var
  SelStart: Integer;
begin
  SelStart := SendMessage(Memo.Handle, EM_LINEINDEX, Index, 0);
  if SelStart >= 0 then
  begin
    SendMessage(Memo.Handle, EM_SETSEL, SelStart, SelStart +
      SendMessage(Memo.Handle, EM_LINELENGTH, SelStart, 0));
    SendTextMessage(Memo.Handle, EM_REPLACESEL, 0, S);
  end;
end;

procedure TMemoStrings.Insert(Index: Integer; const S: string);
var
  SelStart, LineLen: Integer;
  Line: string;
begin
  if Index >= 0 then
  begin
    SelStart := SendMessage(Memo.Handle, EM_LINEINDEX, Index, 0);
    if SelStart >= 0 then Line := S + #13#10 else
    begin
      SelStart := SendMessage(Memo.Handle, EM_LINEINDEX, Index - 1, 0);
      if SelStart < 0 then Exit;
      LineLen := SendMessage(Memo.Handle, EM_LINELENGTH, SelStart, 0);
      if LineLen = 0 then Exit;
      Inc(SelStart, LineLen);
      Line := #13#10 + s;
      if s = '' then
        Line := Line + #13#10;
    end;
    SendMessage(Memo.Handle, EM_SETSEL, SelStart, SelStart);
    SendTextMessage(Memo.Handle, EM_REPLACESEL, 0, Line);
  end;
end;

procedure TMemoStrings.Delete(Index: Integer);
var
  SelStart, SelEnd: Integer;
begin
  SelStart := SendMessage(Memo.Handle, EM_LINEINDEX, Index, 0);
  if SelStart >= 0 then
  begin
    SelEnd := SendMessage(Memo.Handle, EM_LINEINDEX, Index + 1, 0);
    if SelEnd < 0 then SelEnd := SelStart +
      SendMessage(Memo.Handle, EM_LINELENGTH, SelStart, 0);
    SendMessage(Memo.Handle, EM_SETSEL, SelStart, SelEnd);
    SendTextMessage(Memo.Handle, EM_REPLACESEL, 0, '');
  end;
end;

procedure TMemoStrings.Clear;
begin
  Memo.Clear;
end;

procedure TMemoStrings.SetUpdateState(Updating: Boolean);
begin
  if Memo.HandleAllocated then
  begin
    SendMessage(Memo.Handle, WM_SETREDRAW, Ord(not Updating), 0);
    if not Updating then
    begin   // WM_SETREDRAW causes visibility side effects in memo controls
      Memo.Perform(CM_SHOWINGCHANGED, 0, 0); // This reasserts the visibility we want
      Memo.Refresh;
    end;
  end;
end;

function TMemoStrings.GetTextStr: string;
begin
  Result := Memo.Text;
end;

procedure TMemoStrings.SetTextStr(const Value: string);
var
  NewText: string;
begin
  NewText := AdjustLineBreaks(Value);
  if (Length(NewText) <> Memo.GetTextLen) or (NewText <> Memo.Text) then
  begin
    if SendTextMessage(Memo.Handle, WM_SETTEXT, 0, NewText) = 0 then
      raise EInvalidOperation.Create(SInvalidMemoSize);
    Memo.Perform(CM_TEXTCHANGED, 0, 0);
  end;
end;

{ TCustomMemo }

class constructor TCustomMemo.Create;
begin
  TCustomStyleEngine.RegisterStyleHook(TCustomMemo, TMemoStyleHook);
end;

constructor TCustomMemo.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Width := 185;
  Height := 89;
  AutoSize := False;
  FWordWrap := True;
  FWantReturns := True;
  FLines := TMemoStrings.Create;
  TMemoStrings(FLines).Memo := Self;
  ParentBackground := False;
  Touch.InteractiveGestures := [igPan, igPressAndTap];
  Touch.InteractiveGestureOptions := [igoPanInertia,
    igoPanSingleFingerVertical, igoPanGutter, igoParentPassthrough];
end;

class destructor TCustomMemo.Destroy;
begin
  TCustomStyleEngine.UnRegisterStyleHook(TCustomMemo, TMemoStyleHook);
end;

destructor TCustomMemo.Destroy;
begin
  FLines.Free;
  inherited Destroy;
end;

procedure TCustomMemo.DoGetGestureOptions(var Gestures: TInteractiveGestures;
  var Options: TInteractiveGestureOptions);
begin
  inherited DoGetGestureOptions(Gestures, Options);
  if (igPan in Gestures) and ((ScrollBars = ssNone) or (ScrollBars = ssHorizontal)) then
    Gestures := Gestures - [igPan];
end;

procedure TCustomMemo.CreateParams(var Params: TCreateParams);
const
  ScrollBar: array[System.UITypes.TScrollStyle] of DWORD = (0, WS_HSCROLL, WS_VSCROLL,
    WS_HSCROLL or WS_VSCROLL);
  WordWraps: array[Boolean] of DWORD = (0, ES_AUTOHSCROLL);
begin
  inherited CreateParams(Params);
  with Params do
    Style := Style and not WordWraps[FWordWrap] or ES_MULTILINE or ScrollBar[FScrollBars];
end;

[UIPermission(SecurityAction.LinkDemand, Window=UIPermissionWindow.AllWindows)]
procedure TCustomMemo.CreateWindowHandle(const Params: TCreateParams);
begin
  with Params do
  begin
    if SysLocale.FarEast and (Win32Platform <> VER_PLATFORM_WIN32_NT) and
      ((Style and ES_READONLY) <> 0) then
    begin
      // Work around Far East Win95 API/IME bug.
      WindowHandle := CreateWindowEx(ExStyle, WinClassName, '',
        Style and (not ES_READONLY),
        X, Y, Width, Height, WndParent, 0, HInstance, Param);
      if WindowHandle <> 0 then
        SendMessage(WindowHandle, EM_SETREADONLY, Ord(True), 0);
    end
    else
      WindowHandle := CreateWindowEx(ExStyle, WinClassName, '', Style,
        X, Y, Width, Height, WndParent, 0, HInstance, Param);
    SendTextMessage(WindowHandle, WM_SETTEXT, 0, Caption);
  end;
end;

function TCustomMemo.GetCaretPos: TPoint;
var
  Selection : TSelection;
begin
  SendMessage(Handle, EM_GETSEL, NativeInt(@Selection.StartPos), NativeInt(@Selection.EndPos));
  Result.Y := SendMessage(Handle, EM_LINEFROMCHAR, WPARAM(Selection.StartPos), 0);
  Result.X := Selection.StartPos - SendMessage(Handle, EM_LINEINDEX, WPARAM(Result.Y), 0);
end;

function TCustomMemo.IsTouchPropertyStored(AProperty: TTouchProperty): Boolean;
begin
  Result := inherited IsTouchPropertyStored(AProperty);
  case AProperty of
    tpInteractiveGestures:
      Result := Touch.InteractiveGestures <> [igPan, igPressAndTap];
    tpInteractiveGestureOptions:
      Result := Touch.InteractiveGestureOptions <> [igoPanInertia,
        igoPanSingleFingerVertical, igoPanGutter, igoParentPassthrough];
  end;
end;

procedure TCustomMemo.SetCaretPos(const Value: TPoint);
var
  CharIdx: Integer;
begin
  CharIdx := SendMessage(Handle, EM_LINEINDEX, Value.y, 0) + Value.x;
  SendMessage(Handle, EM_SETSEL, CharIdx, CharIdx);
end;

procedure TCustomMemo.Loaded;
begin
  inherited Loaded;
  Modified := False;
end;

procedure TCustomMemo.SetLines(Value: TStrings);
begin
  FLines.Assign(Value);
end;

procedure TCustomMemo.SetScrollBars(Value: System.UITypes.TScrollStyle);
begin
  if FScrollBars <> Value then
  begin
    FScrollBars := Value;
    RecreateWnd;
  end;
end;

procedure TCustomMemo.SetWordWrap(Value: Boolean);
begin
  if Value <> FWordWrap then
  begin
    FWordWrap := Value;
    RecreateWnd;
  end;
end;

procedure TCustomMemo.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  inherited;
  if FWantTabs then Message.Result := Message.Result or DLGC_WANTTAB
  else Message.Result := Message.Result and not DLGC_WANTTAB;
  if not FWantReturns then
    Message.Result := Message.Result and not DLGC_WANTALLKEYS;
end;

procedure TCustomMemo.WMNCDestroy(var Message: TWMNCDestroy);
begin
  inherited;
end;

procedure TCustomMemo.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  if (Key = Char(VK_RETURN)) and not FWantReturns then Key := #0;
end;

{ TCustomComboBoxStrings }

constructor TCustomComboBoxStrings.Create;
begin
  inherited Create;
{$IF DEFINED(CLR)}
  FObjects := TGCHandleList.Create;
{$ENDIF}
end;

destructor TCustomComboBoxStrings.Destroy;
begin
{$IF DEFINED(CLR)}
  FObjects.Clear;
  GC.SuppressFinalize(FObjects);
{$ENDIF}
  inherited Destroy;
end;

function TCustomComboBoxStrings.GetCount: Integer;
begin
  Result := SendMessage(ComboBox.Handle, CB_GETCOUNT, 0, 0);
end;

function TCustomComboBoxStrings.GetObject(Index: Integer): TObject;
var
  LItemData: LPARAM;
begin
  LItemData := SendMessage(ComboBox.Handle, CB_GETITEMDATA, Index, 0);
  // Do additional checking on Count and Index here is so in the event
  // the object being retrieved is the integer -1 the call will succeed
  if (LItemData = CB_ERR) and ((Count = 0) or (Index < 0) or (Index > Count)) then
    Error(SListIndexError, Index);
{$IF DEFINED(CLR)}
  if LItemData <> 0 then
    Result := GCHandle(FObjects.Item[TObject(LItemData)]).Target
  else
    Result := nil;
{$ELSE}
  Result := TObject(LItemData);
{$ENDIF}
end;

procedure TCustomComboBoxStrings.PutObject(Index: Integer; AObject: TObject);
{$IF DEFINED(CLR)}
var
  LHandle: GCHandle;
  LItemData: Integer;
begin
  // If it's an existing item, free the previous GCHandle
  LItemData := SendMessage(ComboBox.Handle, CB_GETITEMDATA, Index, 0);
  if LItemData <> 0 then
  begin
    LHandle := GCHandle(FObjects[TObject(LItemData)]);
    if LHandle.IsAllocated then
      LHandle.Free;
    FObjects.Remove(TObject(LItemData));
  end;

  // Allocate GCHandle and add to hash table
  LHandle := GCHandle.Alloc(AObject);
  FObjects.Add(TObject(LHandle.GetHashCode), LHandle);
  SendMessage(ComboBox.Handle, CB_SETITEMDATA, Index, LHandle.GetHashCode);
end;
{$ELSE}
begin
  SendMessage(ComboBox.Handle, CB_SETITEMDATA, Index, LPARAM(AObject));
end;
{$ENDIF}

function TCustomComboBoxStrings.Get(Index: Integer): string;
var
  Len: Integer;
begin
  Len := SendMessage(ComboBox.Handle, CB_GETLBTEXTLEN, Index, 0);
  // When style = csSimple we need to also check the Len > 0
  if (Len <> CB_ERR) and (Len > 0) then
{$IF DEFINED(CLR)}
    SendGetTextMessage(ComboBox.Handle, CB_GETLBTEXT, Index, Result, Len, False)
{$ELSE}
  begin
    SetLength(Result, Len);
    SendMessage(ComboBox.Handle, CB_GETLBTEXT, Index, LPARAM(PChar(Result)));
  end
{$ENDIF}
  else
    SetLength(Result, 0);
end;

procedure TCustomComboBoxStrings.Clear;
var
  S: string;
begin
  S := ComboBox.Text;
  SendMessage(ComboBox.Handle, CB_RESETCONTENT, 0, 0);
{$IF DEFINED(CLR)}
  FObjects.Clear;
{$ENDIF}
  ComboBox.Text := S;
  ComboBox.Update;
end;

procedure TCustomComboBoxStrings.Delete(Index: Integer);
{$IF DEFINED(CLR)}
var
  LHandle: GCHandle;
  LItemData: Integer;
{$ENDIF}
begin
{$IF DEFINED(CLR)}
  // Free GChandle if item has data associated
  LItemData := SendMessage(ComboBox.Handle, CB_GETITEMDATA, Index, 0);
  if LItemData > 0 then
  begin
    LHandle := GCHandle(FObjects[TObject(LItemData)]);
    if LHandle.IsAllocated then
      LHandle.Free;
    FObjects.Remove(TObject(LItemData));
  end;
{$ENDIF}
  SendMessage(ComboBox.Handle, CB_DELETESTRING, Index, 0);
end;

function TCustomComboBoxStrings.IndexOf(const S: string): Integer;
var
  Stop: Boolean;
begin
  if S <> '' then
    Result := SendTextMessage(ComboBox.Handle, CB_FINDSTRINGEXACT, WPARAM(-1), S)
  else
  begin
    // the ComboBox messages do not search for empty strings so we have
    // to do the search manually
    Stop := False;
    Result := 0;
    while (not Stop) and (Result < Count) do
      if SendMessage(ComboBox.Handle, CB_GETLBTEXTLEN, Result, 0) = 0 then
        Stop := True
      else
        Inc(Result);

    if not Stop then
      Result := -1;
  end;
end;

procedure TCustomComboBoxStrings.SetUpdateState(Updating: Boolean);
begin
  SendMessage(ComboBox.Handle, WM_SETREDRAW, Ord(not Updating), 0);
  if not Updating then ComboBox.Refresh;
end;

{ TComboBoxStrings }

function TComboBoxStrings.Add(const S: string): Integer;
var
  EmptyStr: Char;
  LString: string;
  LPStr: LPARAM;
begin
  // From the Windows SDK documentation:
  // Comclt32.dll version 5.0 or later: If CBS_LOWERCASE or CBS_UPPERCASE is set,
  // the Unicode version of CB_ADDSTRING alters the string. If using read-only
  // global memory, this causes the application to fail.
  if S = '' then
  begin
    EmptyStr := #0;
    LPStr := LPARAM(@EmptyStr)
  end
  else
  begin
    LString := S;
    UniqueString(LString);
    LPStr := LPARAM(LString);
  end;
  Result := SendMessage(ComboBox.Handle, CB_ADDSTRING, 0, LPStr);
  if Result < 0 then
    raise EOutOfResources.Create(SInsertLineError);
end;

procedure TComboBoxStrings.Insert(Index: Integer; const S: string);
var
  EmptyStr: Char;
  LPStr: LPARAM;
  LResult: Integer;
  LString: string;
begin
  if S = '' then
  begin
    EmptyStr := #0;
    LPStr := LPARAM(@EmptyStr)
  end
  else
  begin
    // See TComboBoxStrings.Add for SDK doc information
    LString := S;
    UniqueString(LString);
    LPStr := LPARAM(LString);
  end;
  LResult := SendMessage(ComboBox.Handle, CB_INSERTSTRING, Index, LPStr);
  if LResult < 0 then
    raise EOutOfResources.Create(SInsertLineError);
end;

{ TCustomCombo }

{$IF DEFINED(CLR)}
procedure TComboChildren.Finalize;
begin
  if Assigned(FEditInstance) then
  begin
    FreeObjectInstance(@FEditInstance);
    FEditInstance := nil;
  end;
  if Assigned(FListInstance) then
  begin
    FreeObjectInstance(@FListInstance);
    FListInstance := nil;
  end;
  inherited;
end;
{$ENDIF}

constructor TCustomCombo.Create(AOwner: TComponent);
const
  ComboBoxStyle = [csCaptureMouse, csSetCaption, csDoubleClicks,
    csFixedHeight, csReflector, csPannable];
begin
  inherited Create(AOwner);
  if NewStyleControls then
    ControlStyle := ComboBoxStyle else
    ControlStyle := ComboBoxStyle + [csFramed];
  Width := 145;
  Height := 25;
  TabStop := True;
  ParentColor := False;
  FCanvas := TControlCanvas.Create;
  TControlCanvas(FCanvas).Control := Self;
  FItemHeight := 16;
{$IF DEFINED(CLR)}
  FChildInstances := TComboChildren.Create;
  FChildInstances.FEditInstance := MakeObjectInstance(EditWndProc);
  FChildInstances.FListInstance := MakeObjectInstance(ListWndProc);
{$ELSE}
  FEditInstance := MakeObjectInstance(EditWndProc);
  FListInstance := MakeObjectInstance(ListWndProc);
{$ENDIF}
  FDropDownCount := 8;
  FItemIndex := -1;
  FSaveIndex := -1;
  FInBufferedPrintClient := False;
end;

destructor TCustomCombo.Destroy;
begin
  if HandleAllocated then
    DestroyWindowHandle;
{$IF DEFINED(CLR)}
  if Assigned(FChildInstances) then
  begin
    if Assigned(FListInstance) then
      FreeObjectInstance(FListInstance);
    FChildInstances.FListInstance := nil;
    if Assigned(FEditInstance) then
      FreeObjectInstance(FEditInstance);
    FChildInstances.FEditInstance := nil;
    System.GC.SuppressFinalize(FChildInstances);
    FChildInstances := nil;
  end;
  FreeAndNil(FCanvas);
{$ELSE}
  FreeObjectInstance(FListInstance);
  FreeObjectInstance(FEditInstance);
  FCanvas.Free;
{$ENDIF}
  inherited Destroy;
end;

procedure TCustomCombo.Clear;
begin
  SetTextBuf('');
  FItems.Clear;
  FSaveIndex := -1;
end;

procedure TCustomCombo.DestroyWindowHandle;
begin
  inherited DestroyWindowHandle;
  {
    must be cleared after the main handle is destroyed as messages are sent
    to our internal WndProcs when the main handle is destroyed and we should not
    have NULL handles when we receive those messages.
  }
  FEditHandle := 0;
  FListHandle := 0;
  FDropHandle := 0;
end;

procedure TCustomCombo.SelectAll;
begin
  SendMessage(Handle, CB_SETEDITSEL, 0, LPARAM($FFFF0000));
end;

function TCustomCombo.GetDroppedDown: Boolean;
begin
  Result := LongBool(SendMessage(Handle, CB_GETDROPPEDSTATE, 0, 0));
end;

procedure TCustomCombo.SetDroppedDown(Value: Boolean);
var
  R: TRect;
begin
  SendMessage(Handle, CB_SHOWDROPDOWN, WPARAM(Value), 0);
  R := ClientRect;
  InvalidateRect(Handle, R, True);
end;

function TCustomCombo.GetItemIndex: Integer;
begin
  if csLoading in ComponentState then
    Result := FItemIndex
  else
    Result := SendMessage(Handle, CB_GETCURSEL, 0, 0);
end;

procedure TCustomCombo.SetItemIndex(const Value: Integer);
begin
  if csLoading in ComponentState then
    FItemIndex := Value
  else
    if GetItemIndex <> Value then
      SendMessage(Handle, CB_SETCURSEL, Value, 0);
end;

function TCustomCombo.GetSelStart: Integer;
var
  Temp: Integer;
begin
  SendGetIntMessage(Handle, CB_GETEDITSEL, Result, Temp);
end;

procedure TCustomCombo.SetSelStart(Value: Integer);
var
  Selection: TSelection;
begin
  Selection.StartPos := Value;
  Selection.EndPos := Value;
  SendMessage(Handle, CB_SETEDITSEL, 0, MakeLParam(Selection.StartPos,
    Selection.EndPos));
end;

function TCustomCombo.GetSelLength: Integer;
var
  Selection: TSelection;
begin
  SendGetIntMessage(Handle, CB_GETEDITSEL, Selection.StartPos, Selection.EndPos);
  Result := Selection.EndPos - Selection.StartPos;
end;

procedure TCustomCombo.SetSelLength(Value: Integer);
var
  Selection: TSelection;
begin
  SendGetIntMessage(Handle, CB_GETEDITSEL, Selection.StartPos, Selection.EndPos);
  Selection.EndPos := Selection.StartPos + Value;
  SendMessage(Handle, CB_SETEDITSEL, 0, MakeLParam(Selection.StartPos,
    Selection.EndPos));
end;

procedure TCustomCombo.SetMaxLength(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if FMaxLength <> Value then
  begin
    FMaxLength := Value;
    if HandleAllocated then SendMessage(Handle, CB_LIMITTEXT, Value, 0);
  end;
end;

procedure TCustomCombo.SetItemHeight(Value: Integer);
begin
  if Value > 0 then
  begin
    FItemHeight := Value;
    RecreateWnd;
  end;
end;

procedure TCustomCombo.WMCreate(var Message: TWMCreate);
begin
  inherited;
{$IF DEFINED(CLR)}
  if WindowText <> '' then
{$ELSE}
  if WindowText <> nil then
{$ENDIF}
    SetWindowText(Handle, WindowText);
end;

procedure TCustomCombo.WMDrawItem(var Message: TWMDrawItem);
begin
  DefaultHandler(Message);
end;

procedure TCustomCombo.WMMeasureItem(var Message: TWMMeasureItem);
begin
  DefaultHandler(Message);
end;

procedure TCustomCombo.WMDeleteItem(var Message: TWMDeleteItem);
begin
  DefaultHandler(Message);
end;

procedure TCustomCombo.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  inherited;
  if DroppedDown then Message.Result := Message.Result or DLGC_WANTALLKEYS;
end;

procedure TCustomCombo.CMCancelMode(var Message: TCMCancelMode);
begin
{$IF DEFINED(CLR)}
  if not System.Object.Equals(Message.Sender, Self) then
{$ELSE}
  if Message.Sender <> Self then
{$ENDIF}
    Perform(CB_SHOWDROPDOWN, 0, 0);
end;

procedure TCustomCombo.CMCtl3DChanged(var Message: TMessage);
begin
  if NewStyleControls then RecreateWnd;
  inherited;
end;

procedure TCustomCombo.CMGestureManagerChanged(var Message: TMessage);
begin
  if not (csDestroying in ComponentState) then
  begin
    if (Touch.GestureManager <> nil) then
      ControlStyle := ControlStyle + [csGestures]
    else
      ControlStyle := ControlStyle - [csGestures];
    if HandleAllocated then
      RecreateWnd;
  end;
end;

procedure TCustomComboBox.Change;
var
  LEditLink: Boolean;
begin
  LEditLink := Observers.IsObserving(TObserverMapping.EditLinkID);
  if LEditLink then
    TLinkObservers.EditLinkEdit(Observers);
  inherited;
  TLinkObservers.ListSelectionChanged(Observers);
end;

procedure TCustomComboBox.Click;
begin
  if Observers.IsObserving(TObserverMapping.EditLinkID) then
    TLinkObservers.EditLinkEdit(Observers);
  inherited;
  TLinkObservers.ListSelectionChanged(Observers);
end;

procedure TCustomComboBox.CMEnter(var Message: TCMEnter);
begin
  inherited;
  if Observers.IsObserving(TObserverMapping.EditLinkID) then
  begin
    if TLinkObservers.EditLinkIsReadOnly(Observers) then
      SendMessage(EditHandle, EM_SETREADONLY, Ord(True), 0)
    else
      SendMessage(EditHandle, EM_SETREADONLY, Ord(False), 0);
  end;
end;

procedure TCustomComboBox.CMExit(var Message: TCMExit);
begin
  try
    if Observers.IsObserving(TObserverMapping.EditLinkID) then
      TLinkObservers.EditLinkUpdate(Observers);
    if Observers.IsObserving(TObserverMapping.ControlValueID) then
      TLinkObservers.ControlValueUpdate(Observers);
  except
    SelectAll;
    SetFocus;
    raise;
  end;
  inherited;
end;

procedure TCustomComboBox.CMParentColorChanged(var Message: TMessage);
begin
  inherited;
  if not NewStyleControls and (Style < csDropDownList) then Invalidate;
end;

{$IF DEFINED(CLR)}
function TCustomCombo.GetEditInstance: TFNWndProc;
begin
  if Assigned(FChildInstances) then
    Result := FChildInstances.FEditInstance
  else
    Result := nil;
end;
{$ENDIF}

procedure TCustomCombo.EditWndProc(var Message: TMessage);
var
  P: TPoint;
  Form: TCustomForm;
  LWindowRect: TRect;
begin
  if Message.Msg = WM_SYSCOMMAND then
  begin
    WndProc(Message);
    Exit;
  end
  else if (Message.Msg >= WM_KEYFIRST) and (Message.Msg <= WM_KEYLAST) then
  begin
    Form := GetParentForm(Self);
    if (Form <> nil) and Form.WantChildKey(Self, Message) then Exit;
  end;
  ComboWndProc(Message, FEditHandle, FDefEditProc);
  case Message.Msg of
    WM_LBUTTONDOWN, WM_LBUTTONDBLCLK:
      begin
        if DragMode = dmAutomatic then
        begin
          GetCursorPos(P);
          SendMessage(FEditHandle, WM_LBUTTONUP, 0, PointToLParam(ScreenToClient(P)));
          BeginDrag(False);
        end;
      end;
    WM_MOUSEMOVE: Perform(Message.Msg, Message.WParam, Message.LParam);
    WM_SETFONT:
      if NewStyleControls then
        SendMessage(FEditHandle, EM_SETMARGINS, EC_LEFTMARGIN or EC_RIGHTMARGIN, 0);
    CM_BUFFEREDPRINTCLIENT:
      if FInBufferedPrintClient then
      begin
        GetWindowRect(EditHandle, LWindowRect);
        MapWindowPoints(0, EditHandle, LWindowRect, 2);
        PerformBufferedPrintClient(EditHandle, LWindowRect);
        FInBufferedPrintClient := False;
      end;
  end;
end;

{$IF DEFINED(CLR)}
function TCustomCombo.GetListInstance: TFNWndProc;
begin
  if Assigned(FChildInstances) then
    Result := FChildInstances.FListInstance
  else
    Result := nil;
end;
{$ENDIF}

procedure TCustomCombo.ListWndProc(var Message: TMessage);
begin
  ComboWndProc(Message, FListHandle, FDefListProc);
end;

procedure TCustomComboBox.SetCharCase(Value: TEditCharCase);
begin
  if FCharCase <> Value then
  begin
    FCharCase := Value;
    RecreateWnd;
  end;
end;

procedure TCustomComboBox.SetTextHint(const Value: string);
begin
  if FTextHint <> Value then
  begin
    FTextHint := Value;
    if not (csLoading in ComponentState) then
      DoSetTextHint;
  end;
end;

[SecurityPermission(SecurityAction.InheritanceDemand, UnmanagedCode=True)]
procedure TCustomCombo.ComboWndProc(var Message: TMessage; ComboWnd: HWnd;
  ComboProc: TWindowProcPtr);
var
  LPoint: TPoint;
  Form: TCustomForm;
{$IF DEFINED(CLR)}
  KeyMsg: TWMKey;
{$ENDIF}
begin
  try
    with Message do
    begin
      case Msg of
        WM_SETFOCUS:
          begin
            Form := GetParentForm(Self);
            if (Form <> nil) and not Form.SetFocusedControl(Self) then Exit;
          end;
        WM_KILLFOCUS:
          if csFocusing in ControlState then Exit;
        WM_KEYDOWN, WM_SYSKEYDOWN:
          begin
{$IF DEFINED(CLR)}
            KeyMsg := TWMKey.Create(Message);
            if (ComboWnd <> FListHandle) and DoKeyDown(KeyMsg) then
              Exit;
{$ELSE}
            if (ComboWnd <> FListHandle) and DoKeyDown(TWMKey(Message)) then
              Exit;
{$ENDIF}
          end;
        WM_CHAR:
          begin
{$IF DEFINED(CLR)}
            KeyMsg := TWMKey.Create(Message);
            if DoKeyPress(KeyMsg) then Exit;
            with KeyMsg do
{$ELSE}
            if DoKeyPress(TWMKey(Message)) then Exit;
            with TWMKey(Message) do
{$ENDIF}
            begin
              if ((CharCode = VK_RETURN) or (CharCode = VK_ESCAPE)) and DroppedDown then
              begin
                DroppedDown := False;
                Exit;
              end;
            end;
          end;
        WM_KEYUP, WM_SYSKEYUP:
          begin
{$IF DEFINED(CLR)}
            KeyMsg := TWMKey.Create(Message);
            if DoKeyUp(KeyMsg) then Exit;
{$ELSE}
            if DoKeyUp(TWMKey(Message)) then Exit;
{$ENDIF}
          end;
        WM_MOUSEMOVE: Application.HintMouseMessage(Self, Message);
        WM_RBUTTONUP:
          if HasPopup(Self) then
          begin
            with TWMRButtonUp(Message) do
            begin
              LPoint.X := Pos.X;
              LPoint.Y := Pos.Y;
              MapWindowPoints(ComboWnd, Handle, LPoint, 1);
              Pos := SmallPoint(LPoint.X, LPoint.Y);
            end;
            WndProc(Message);
            Exit;
          end;
        WM_GETDLGCODE:
          if DroppedDown then
          begin
            Result := DLGC_WANTALLKEYS;
            Exit;
          end;
        WM_NCHITTEST:
          if csDesigning in ComponentState then
          begin
            Result := HTTRANSPARENT;
            Exit;
          end;
        CN_KEYDOWN, CN_CHAR, CN_SYSKEYDOWN, CN_SYSCHAR:
          begin
            WndProc(Message);
            Exit;
          end;
      end;
      Result := CallWindowProc(ComboProc, ComboWnd, Msg, WParam, LParam);
      if (Msg = WM_LBUTTONDBLCLK) and (csDoubleClicks in ControlStyle) then
        DblClick;
    end;
  except
    Application.HandleException(Self);
  end;
end;

procedure TCustomCombo.WndProc(var Message: TMessage);
{$IF DEFINED(CLR)}
var
  KeyMsg: TWMKey;
  MouseMsg: TWMMouse;
{$ENDIF}
begin
    {for auto drag mode, let listbox handle itself, instead of TControl}
  if not (csDesigning in ComponentState) and
     ((Message.Msg = WM_LBUTTONDOWN) or (Message.Msg = WM_LBUTTONDBLCLK)) and
     not Dragging then
  begin
    if DragMode = dmAutomatic then
    begin
{$IF DEFINED(CLR)}
      MouseMsg := TWMMouse.Create(Message);
      if IsControlMouseMsg(MouseMsg) then
{$ELSE}
      if IsControlMouseMsg(TWMMouse(Message)) then
{$ENDIF}
        Exit;
      ControlState := ControlState + [csLButtonDown];
      Dispatch(Message);  {overrides TControl's BeginDrag}
      Exit;
    end;
  end;
  with Message do
    case Msg of
      WM_SIZE:
        { Prevent TWinControl from handling WM_SIZE when adjusting drop-down
          listbox size. }
        if FDroppingDown then
        begin
          DefaultHandler(Message);
          Exit;
        end;
      WM_CTLCOLORMSGBOX..WM_CTLCOLORSTATIC:
        if (not TStyleManager.IsCustomStyleActive) or
           (TStyleManager.IsCustomStyleActive and not (seBorder in StyleElements)) then
        begin
          SetTextColor(WParam, ColorToRGB(Font.Color));
          SetBkColor(WParam, ColorToRGB(Brush.Color));
          Result := Brush.Handle;
          if (csGlassPaint in ControlState) and not FInBufferedPrintClient then
          begin
            FInBufferedPrintClient := True;
            PostMessage(EditHandle, CM_BUFFEREDPRINTCLIENT, 0, 0);
          end;
          Exit;
        end;
      WM_CHAR:
        begin
{$IF DEFINED(CLR)}
          KeyMsg := TWMKey.Create(Message);
          if DoKeyPress(KeyMsg) then Exit;
          with KeyMsg do
{$ELSE}
          if DoKeyPress(TWMKey(Message)) then Exit;
          with TWMKey(Message) do
{$ENDIF}
            if ((CharCode = VK_RETURN) or (CharCode = VK_ESCAPE)) and DroppedDown then
            begin
              DroppedDown := False;
              Exit;
            end;
        end;
      WM_NCCALCSIZE:
        Exit; // Prevent TWinControl.WMNCCalcSize from being called
      WM_CONTEXTMENU:
        if PopupMenu = nil then
        begin
          Dispatch(Message);
          Result := CallWindowProc(FDefEditProc, FEditHandle, Msg, WParam, LParam);
          Exit;
        end;
    end;
  inherited WndProc(Message);
end;

procedure TCustomCombo.CNCommand(var Message: TWMCommand);
begin
  case Message.NotifyCode of
    CBN_DBLCLK:
      DblClick;
    CBN_EDITCHANGE:
      Change;
    CBN_DROPDOWN:
      begin
        FFocusChanged := False;
        DropDown;
        AdjustDropDown;
        if FFocusChanged then
        begin
          PostMessage(Handle, WM_CANCELMODE, 0, 0);
          if not FIsFocused then
            PostMessage(Handle, CB_SHOWDROPDOWN, 0, 0);
        end;
      end;
    CBN_SELCHANGE:
      begin
        if ItemIndex <> -1 then
        begin
          Text := Items[ItemIndex];
          Click;
          Select;
        end;
      end;
    CBN_CLOSEUP:
      CloseUp;
    CBN_SETFOCUS:
      begin
        FIsFocused := True;
        FFocusChanged := True;
        SetIme;
      end;
    CBN_KILLFOCUS:
      begin
        FIsFocused := False;
        FFocusChanged := True;
        ResetIme;
      end;
  end;
end;

procedure TCustomCombo.Change;
begin
  inherited Changed;
  if Assigned(FOnChange) then FOnChange(Self);
end;

procedure TCustomComboBox.DrawItem(Index: Integer; Rect: TRect;
  State: TOwnerDrawState);
begin
  TControlCanvas(FCanvas).UpdateTextFlags;
  if Assigned(FOnDrawItem) then
    FOnDrawItem(Self, Index, Rect, State)
  else
  begin
    FCanvas.FillRect(Rect);
    if Index >= 0 then
    FCanvas.TextOut(Rect.Left + 2, Rect.Top, Items[Index]);
  end;
end;

procedure TCustomCombo.DropDown;
begin
  if Assigned(FOnDropDown) then FOnDropDown(Self);
end;

procedure TCustomCombo.Loaded;
begin
  inherited Loaded;
  if FItemIndex <> -1 then
    SetItemIndex(FItemIndex);
end;

function TCustomCombo.Focused: Boolean;
var
  FocusedWnd: HWND;
begin
  Result := False;
  if HandleAllocated then
  begin
    FocusedWnd := GetFocus;
    Result := (FocusedWnd = FEditHandle) or (FocusedWnd = FListHandle) or (FocusedWnd = Handle);
  end;
end;

procedure TCustomCombo.CloseUp;
begin
  if Assigned(FOnCloseUp) then
    FOnCloseUp(Self);
end;

procedure TCustomCombo.Select;
begin
  if Assigned(FOnSelect) then
    FOnSelect(Self)
  else
    Change;
end;

[UIPermission(SecurityAction.LinkDemand, Window=UIPermissionWindow.AllWindows)]
procedure TCustomCombo.CreateWnd;
begin
  inherited CreateWnd;
  SendMessage(Handle, CB_LIMITTEXT, FMaxLength, 0);
  FEditHandle := 0;
  FListHandle := 0;
  if CheckWin32Version(5, 1) and StyleServices.Enabled then
    SendMessage(Handle, CB_SETMINVISIBLE, WPARAM(DropDownCount), 0);
end;

procedure TCustomCombo.AdjustDropDown;
var
  Count: Integer;
begin
  Count := ItemCount;
  if Count > DropDownCount then Count := DropDownCount;
  if Count < 1 then Count := 1;
  FDroppingDown := True;
  try
    SetWindowPos(FDropHandle, 0, 0, 0, Width, ItemHeight * Count +
      Height + 2, SWP_NOMOVE or SWP_NOZORDER or SWP_NOACTIVATE or SWP_NOREDRAW or
      SWP_HIDEWINDOW);
  finally
    FDroppingDown := False;
  end;
  SetWindowPos(FDropHandle, 0, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE or
    SWP_NOZORDER or SWP_NOACTIVATE or SWP_SHOWWINDOW);
end;

procedure TCustomCombo.SetItems(const Value: TStrings);
begin
  if Assigned(FItems) then
    FItems.Assign(Value)
  else
    FItems := Value;
end;

procedure TCustomCombo.ClearSelection;
begin
  ItemIndex := -1;
end;

procedure TCustomCombo.CopySelection(Destination: TCustomListControl);
begin
  if ItemIndex <> -1 then
    Destination.AddItem(Items[ItemIndex], Items.Objects[ItemIndex]);
end;

procedure TCustomCombo.DeleteSelected;
begin
  if ItemIndex <> -1 then
    Items.Delete(ItemIndex);
end;

function TCustomCombo.GetCount: Integer;
begin
  Result := GetItemCount;
end;

procedure TCustomCombo.SetDropDownCount(const Value: Integer);
begin
  if Value <> FDropDownCount then
  begin
    FDropDownCount := Value;
    if HandleAllocated and CheckWin32Version(5, 1) and StyleServices.Enabled then
      SendMessage(Handle, CB_SETMINVISIBLE, WPARAM(FDropDownCount), 0);
  end;
end;

procedure TCustomCombo.AddItem(Item: String; AObject: TObject);
begin
  Items.AddObject(Item, AObject);
end;

function TCustomCombo.IsItemHeightStored: Boolean;
begin
  Result := FItemHeight <> 16;
end;

{ TCustomComboBox }

class constructor TCustomComboBox.Create;
begin
  TCustomStyleEngine.RegisterStyleHook(TCustomComboBox, TComboBoxStyleHook);
end;

constructor TCustomComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FItems := GetItemsClass.Create;
  TCustomComboBoxStrings(FItems).ComboBox := Self;
  FStyle := csDropDown;
  FLastTime := 0;
  FAutoComplete := True;
  FAutoCloseUp := False;
  FAutoCompleteDelay := 500;
  FTextHint := '';
end;

class destructor TCustomComboBox.Destroy;
begin
  TCustomStyleEngine.UnRegisterStyleHook(TCustomComboBox, TComboBoxStyleHook);
end;

destructor TCustomComboBox.Destroy;
begin
  FItems.Free;
  FSaveItems.Free;
  inherited Destroy;
end;

function TCustomComboBox.GetSelText: string;
begin
  Result := '';
  if FStyle < csDropDownList then
    Result := Copy(Text, GetSelStart + 1, GetSelLength);
end;

procedure TCustomComboBox.SetSorted(Value: Boolean);
begin
  if FSorted <> Value then
  begin
    FSorted := Value;
    RecreateWnd;
  end;
end;

procedure TCustomComboBox.SetSelText(const Value: string);
begin
  if FStyle < csDropDownList then
  begin
    HandleNeeded;
{$IF DEFINED(CLR)}
    if not Assigned(Value) then
      SendTextMessage(FEditHandle, EM_REPLACESEL, 0, '')
    else
{$ENDIF}
      SendTextMessage(FEditHandle, EM_REPLACESEL, 0, Value);
  end;
end;

procedure TCustomComboBox.SetStyle(Value: TComboBoxStyle);
begin
  if FStyle <> Value then
  begin
    FStyle := Value;
    if Value = csSimple then
      ControlStyle := ControlStyle - [csFixedHeight] else
      ControlStyle := ControlStyle + [csFixedHeight];
    RecreateWnd;
  end;
end;

function TCustomComboBox.GetItemHt: Integer;
begin
  if FStyle in [csOwnerDrawFixed, csOwnerDrawVariable] then
    Result := FItemHeight
  else
    Result := Perform(CB_GETITEMHEIGHT, 0, 0); // returns 0 if Handle = 0
end;

function TCustomComboBox.IsItemHeightStored: Boolean;
begin
  Result := (FStyle in [csOwnerDrawFixed, csOwnerDrawVariable]) and
            inherited IsItemHeightStored;
end;

procedure TCustomComboBox.CreateParams(var Params: TCreateParams);
const
  ComboBoxStyles: array[TComboBoxStyle] of DWORD = (
    CBS_DROPDOWN, CBS_SIMPLE, CBS_DROPDOWNLIST,
    CBS_DROPDOWNLIST or CBS_OWNERDRAWFIXED,
    CBS_DROPDOWNLIST or CBS_OWNERDRAWVARIABLE);
  CharCases: array[TEditCharCase] of DWORD = (0, CBS_UPPERCASE, CBS_LOWERCASE);
  Sorts: array[Boolean] of DWORD = (0, CBS_SORT);
begin
  inherited CreateParams(Params);
  CreateSubClass(Params, 'COMBOBOX');
  with Params do
    Style := Style or (WS_VSCROLL or CBS_HASSTRINGS or CBS_AUTOHSCROLL) or
      ComboBoxStyles[FStyle] or Sorts[FSorted] or CharCases[FCharCase];
end;

[UIPermission(SecurityAction.LinkDemand, Window=UIPermissionWindow.AllWindows)]
procedure TCustomComboBox.CreateWnd;
var
  ChildHandle: THandle;
begin
  inherited CreateWnd;
  FDropHandle := Handle;
  if FSaveItems <> nil then
  begin
    FItems.Assign(FSaveItems);
    FSaveItems.Free;
    FSaveItems := nil;
    if FSaveIndex <> -1 then
    begin
      if FItems.Count < FSaveIndex then FSaveIndex := Items.Count;
      SendMessage(Handle, CB_SETCURSEL, FSaveIndex, 0);
      FSaveIndex := -1;
    end;
  end;
  if FStyle in [csDropDown, csSimple] then
  begin
    ChildHandle := GetWindow(Handle, GW_CHILD);
    if ChildHandle <> 0 then
    begin
      if FStyle = csSimple then
      begin
        FListHandle := ChildHandle;
{$IF DEFINED(CLR)}
        FDefListProc := SetWindowLong(FListHandle, GWL_WNDPROC, FListInstance);
{$ELSE}
        FDefListProc := Pointer(GetWindowLong(FListHandle, GWL_WNDPROC));
        SetWindowLong(FListHandle, GWL_WNDPROC, LPARAM(FListInstance));
{$ENDIF}
        ChildHandle := GetWindow(ChildHandle, GW_HWNDNEXT);
      end;
      FEditHandle := ChildHandle;
{$IF DEFINED(CLR)}
      FDefEditProc := SetWindowLong(FEditHandle, GWL_WNDPROC, FEditInstance);
{$ELSE}
      FDefEditProc := Pointer(GetWindowLong(FEditHandle, GWL_WNDPROC));
      SetWindowLong(FEditHandle, GWL_WNDPROC, LPARAM(FEditInstance));
{$ENDIF}
    end;
  end;
  if NewStyleControls and (FEditHandle <> 0) then
    SendMessage(FEditHandle, EM_SETMARGINS, EC_LEFTMARGIN or EC_RIGHTMARGIN, 0);
  DoSetTextHint;
end;

procedure TCustomComboBox.DestroyWnd;
begin
  if (FItems.Count > 0) and (csRecreating in ControlState) then
  begin
    FSaveIndex := ItemIndex;
    FSaveItems := TStringList.Create;
    FSaveItems.Assign(FItems);
  end;
  inherited DestroyWnd;
end;

procedure TCustomComboBox.DoSetTextHint;
begin
  if StyleServices.Enabled and HandleAllocated then
    if CheckWin32Version(6) then
      SendTextMessage(Handle, CB_SETCUEBANNER, WPARAM(0), FTextHint)
    else if CheckWin32Version(5, 1) then
      SendTextMessage(FEditHandle, EM_SETCUEBANNER, WPARAM(0), FTextHint);
end;

procedure TCustomComboBox.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  if (Style = csSimple) and (Parent <> nil) then
  begin
    FillRect(Message.DC, ClientRect, Parent.Brush.Handle);
    Message.Result := 1;
  end
  else
    DefaultHandler(Message);
end;

procedure TCustomComboBox.KeyDown(var Key: Word; Shift: TShiftState);
var
  LEditLink: Boolean;
begin
  inherited;
  LEditLink := Observers.IsObserving(TObserverMapping.EditLinkID);
  if Key in [VK_BACK, VK_DELETE, VK_UP, VK_DOWN, 32..255] then
  begin
    if LEditLink and not TLinkObservers.EditLinkEdit(Observers) and (Key in [VK_UP, VK_DOWN]) then
      Key := 0;
    TLinkObservers.ListSelectionChanged(Observers);
  end;
end;

procedure TCustomComboBox.KeyPress(var Key: Char);

  function HasSelectedText(var StartPos, EndPos: Integer): Boolean;
  begin
    if Style in [csDropDown, csSimple] then
    begin
      SendGetIntMessage(Handle, CB_GETEDITSEL, StartPos, EndPos);
      Result := EndPos > StartPos;
    end
    else
      Result := False;
  end;

  procedure DeleteSelectedText(const StartPos, EndPos: DWORD);
  var
     OldText: String;
  begin
    OldText := Text;
    Delete(OldText, StartPos + 1, EndPos - StartPos);
    SendMessage(Handle, CB_SETCURSEL, WPARAM(-1), 0);
    Text := OldText;
    SendMessage(Handle, CB_SETEDITSEL, 0, MakeLParam(StartPos, StartPos));
  end;

var
  StartPos, EndPos: Integer;
  OldText: string;
  SaveText: string;
  LastByte: Integer;
  LItemIndex: Integer;
{$IF NOT DEFINED(CLR)}
  Msg : TMSG;
{$ENDIF}
begin
  LItemIndex := ItemIndex;
  inherited KeyPress(Key);
  if Observers.IsObserving(TObserverMapping.EditLinkID) then
  begin
    if (Key >= #32) and
      not TLinkObservers.EditLinkIsValidChar(Observers, Key) then
    begin
      MessageBeep(0);
      Key := #0;
    end;
    case Key of
      ^H, ^V, ^X, #32..High(Char):
        if not TLinkObservers.EditLinkEdit(Observers) then
          Key := #0;
      #27:
        begin
          TLinkObservers.EditLinkReset(Observers);
          SelectAll;
        end;
    end;
  end;

  if not AutoComplete then exit;
  if Style in [csDropDown, csSimple] then
    FFilter := Text
  else
  begin
   if GetTickCount - FLastTime >= FAutoCompleteDelay then
      FFilter := '';
    FLastTime := GetTickCount;
  end;
  case Ord(Key) of
    VK_ESCAPE: exit;
    VK_TAB:
      if FAutoDropDown and DroppedDown then
        DroppedDown := False;
    VK_BACK:
      begin
        if HasSelectedText(StartPos, EndPos) then
          DeleteSelectedText(StartPos, EndPos)
        else
          if (Style in [csDropDown, csSimple]) and (Length(Text) > 0) then
          begin
            SaveText := Text;
            LastByte := StartPos;
{$IF NOT DEFINED(CLR)}
            while ByteType(SaveText, LastByte) = mbTrailByte do Dec(LastByte);
{$ENDIF}
            OldText := Copy(SaveText, 1, LastByte - 1);
            SendMessage(Handle, CB_SETCURSEL, WPARAM(-1), 0);
            Text := OldText + Copy(SaveText, EndPos + 1, MaxInt);
            SendMessage(Handle, CB_SETEDITSEL, 0, MakeLParam(LastByte - 1, LastByte - 1));
            FFilter := Text;
          end
          else
          begin
{$IF NOT DEFINED(CLR)}
            while ByteType(FFilter, Length(FFilter)) = mbTrailByte do
              Delete(FFilter, Length(FFilter), 1);
{$ENDIF}
            Delete(FFilter, Length(FFilter), 1);
          end;
        Key := #0;
        Change;
      end;
  else // case
    HasSelectedText(StartPos, EndPos); // This call sets StartPos and EndPos
    if (FStyle < csDropDownList) and (StartPos < Length(FFilter))  then
      SaveText := Copy(FFilter, 1, StartPos) + Key + Copy(FFilter, EndPos+1, Length(FFilter))
    else
      SaveText := FFilter + Key;
    if FAutoDropDown and not DroppedDown then
      DroppedDown := True;

{$IF NOT DEFINED(CLR)}
    if IsLeadChar(Key) then
    begin
      if PeekMessage(Msg, Handle, 0, 0, PM_NOREMOVE) and (Msg.Message = WM_CHAR) then
      begin
        if SelectItem(SaveText + Char(Msg.wParam)) then
        begin
          PeekMessage(Msg, Handle, 0, 0, PM_REMOVE);
          Key := #0
        end;
      end;
    end
    else
{$ENDIF}
    if SelectItem(SaveText) then
      Key := #0
  end; // case
  if ItemIndex <> LItemIndex then
  begin
    TLinkObservers.ListSelectionChanged(Observers);
  end;
end;

function TCustomComboBox.SelectItem(const AnItem: string): Boolean;
var
  Idx: Integer;
  ValueChange: Boolean;
begin
  if Length(AnItem) = 0 then
  begin
    Result := False;
    ItemIndex := -1;
    Change;
    exit;
  end;
  Idx := SendTextMessage(Handle, CB_FINDSTRING, WPARAM(-1), AnItem);
  Result := (Idx <> CB_ERR);
  if not Result then exit;
  ValueChange := Idx <> ItemIndex;
  if AutoCloseUp and (Items.IndexOf(AnItem) <> -1) then
    SendMessage(Handle, CB_SHOWDROPDOWN, 0, 0);
  SendMessage(Handle, CB_SETCURSEL, Idx, 0);
  if (Style in [csDropDown, csSimple]) then
  begin
    Text := AnItem + Copy(Items[Idx], Length(AnItem) + 1, MaxInt);
    SendMessage(Handle, CB_SETEDITSEL, 0, MakeLParam(Length(AnItem), Length(Text)));
  end
  else
  begin
    ItemIndex := Idx;
    FFilter := AnItem;
  end;
  if ValueChange then
  begin
    Click;
    Select;
  end;
end;

procedure TCustomComboBox.MeasureItem(Index: Integer; var Height: Integer);
begin
  if Assigned(FOnMeasureItem) then FOnMeasureItem(Self, Index, Height)
end;

function TCustomComboBox.CanObserve(const ID: Integer): Boolean;
begin
  Result := False;
  if ID = TObserverMapping.EditLinkID then
    Result := True
  else if ID = TObserverMapping.PositionLinkID then
    Result := True
  else if ID = TObserverMapping.ControlValueID then
    Result := True;

end;

procedure TCustomComboBox.ComboWndProc(var Message: TMessage; ComboWnd: HWnd;
  ComboProc: TWindowProcPtr);
begin
  if not (csDesigning in ComponentState) then
    if Observers.IsObserving(TObserverMapping.EditLinkID) then
    begin
      case Message.Msg of
        WM_LBUTTONDOWN:
          if (Style = csSimple) and (ComboWnd <> EditHandle) then
            if not TLinkObservers.EditLinkEdit(Observers) then
              Exit;
        WM_PASTE, WM_CUT, WM_UNDO, WM_CLEAR:
           if not TLinkObservers.EditLinkEdit(Observers) then
             Exit;
       end;
    end;
  inherited ComboWndProc(Message, ComboWnd, ComboProc);
end;

procedure TCustomComboBox.CNDrawItem(var Message: TWMDrawItem);
const
  ColorStates: array[Boolean] of TStyleColor = (scComboBoxDisabled, scComboBox);
  FontStates: array[Boolean] of TStyleFont = (sfComboBoxItemDisabled, sfComboBoxItemNormal);
var
  State: TOwnerDrawState;
begin
  with Message.DrawItemStruct{$IFNDEF CLR}^{$ENDIF} do
  begin
    State := TOwnerDrawState(LoWord(itemState));
    if itemState and ODS_COMBOBOXEDIT <> 0 then
      Include(State, odComboBoxEdit);
    if itemState and ODS_DEFAULT <> 0 then
      Include(State, odDefault);
    FCanvas.Handle := hDC;
    FCanvas.Font := Font;
    if TStyleManager.IsCustomStyleActive then
    begin
      if seClient in StyleElements then
        FCanvas.Brush.Color := StyleServices.GetStyleColor(ColorStates[Enabled])
      else
        FCanvas.Brush := Brush;
      if seFont in StyleElements then
        FCanvas.Font.Color := StyleServices.GetStyleFontColor(FontStates[Enabled]);
    end
    else
      FCanvas.Brush := Brush;
    if (Integer(itemID) >= 0) and (odSelected in State) then
    begin
      FCanvas.Brush.Color := clHighlight;
      FCanvas.Font.Color := clHighlightText
    end;
    if Integer(itemID) >= 0 then
      DrawItem(itemID, rcItem, State) else
      FCanvas.FillRect(rcItem);
    if odFocused in State then DrawFocusRect(hDC, rcItem);
    FCanvas.Handle := 0;
  end;
end;

procedure TCustomComboBox.CNMeasureItem(var Message: TWMMeasureItem);
var
  Height: Integer;
{$IF DEFINED(CLR)}
  MeasureItemStruct: TMeasureItemStruct;
{$ELSE}
  MeasureItemStruct: PMeasureItemStruct;
{$ENDIF}
begin
  MeasureItemStruct := Message.MeasureItemStruct;
  with MeasureItemStruct{$IFNDEF CLR}^{$ENDIF} do
  begin
    itemHeight := FItemHeight;
    if FStyle = csOwnerDrawVariable then
    begin
      Height := FItemHeight;
      MeasureItem(itemID, Height);
      itemHeight := Height;
    end;
  end;
{$IF DEFINED(CLR)}
  Message.MeasureItemStruct := MeasureItemStruct;
{$ENDIF}
end;

procedure TCustomComboBox.WMLButtonDown(var Message: TWMLButtonDown);
var
  Form: TCustomForm;
begin
  if (DragMode = dmAutomatic) and (Style = csDropDownList) and
      (Message.XPos < (Width - GetSystemMetrics(SM_CXHSCROLL))) then
  begin
    SetFocus;
    BeginDrag(False);
    Exit;
  end;
  inherited;
  if MouseCapture then
  begin
    Form := GetParentForm(Self);
    if (Form <> nil) and (Form.ActiveControl <> Self) then
      MouseCapture := False;
  end;
end;

procedure TCustomComboBox.WndProc(var Message: TMessage);
begin
  if not (csDesigning in ComponentState) then
    if Observers.IsObserving(TObserverMapping.EditLinkID) then
      case Message.Msg of
        WM_COMMAND:
          if TWMCommand(Message).NotifyCode = CBN_SELCHANGE then
            if not TLinkObservers.EditLinkEdit(Observers) then
            begin
              if Style <> csSimple then
                PostMessage(Handle, CB_SHOWDROPDOWN, 0, 0);
              Exit;
            end;
        CB_SHOWDROPDOWN:
          if Message.WParam <> 0 then TLinkObservers.EditLinkEdit(Observers) else
            if not TLinkObservers.EditLinkIsEditing(Observers) then
              TLinkObservers.EditLinkReset(Observers); {Restore text}
      end;

  with Message do
    case Msg of
      CN_CTLCOLORMSGBOX..CN_CTLCOLORSTATIC:
        if not NewStyleControls and (Style < csDropDownList) and (Parent <> nil) then
        begin
          Result := LRESULT(Parent.Brush.Handle);
          Exit;
        end;
    end;
  inherited WndProc(Message);
end;

function TCustomComboBox.GetItemCount: Integer;
begin
  Result := FItems.Count;
end;

function TCustomComboBox.GetItemsClass: TCustomComboBoxStringsClass;
begin
  Result := TComboBoxStrings;
end;

procedure TCustomComboBox.WMPaint(var Message: TWMPaint);
const
  InnerStyles: array[TBevelCut] of Integer = (0, BDR_SUNKENINNER, BDR_RAISEDINNER, 0);
  OuterStyles: array[TBevelCut] of Integer = (0, BDR_SUNKENOUTER, BDR_RAISEDOUTER, 0);
  EdgeStyles: array[TBevelKind] of Integer = (0, 0, BF_SOFT, BF_FLAT);
  Ctl3DStyles: array[Boolean] of Integer = (BF_MONO, 0);
var
  EdgeSize: Integer;
  C: TControlCanvas;
  R: TRect;
begin
                                       
{$IF DEFINED(CLR)}
  if Message.DC <> 0 then
  begin
    Message.Result := CallWindowProc(DefWndProc, Handle, WM_PRINT, Message.DC,
      LPARAM(PRF_CLIENT or PRF_CHILDREN));
  end
  else
{$ENDIF}
    inherited;
  if BevelKind = bkNone then Exit;
  C := TControlCanvas.Create;
  try
    C.Control := Self;
    with C do
    begin
      R := ClientRect;
      C.Brush.Color := Color;
      FrameRect(R);
      InflateRect(R,-1,-1);
      FrameRect(R);
      if BevelKind <> bkNone then
      begin
        EdgeSize := 0;
        if BevelInner <> bvNone then Inc(EdgeSize, BevelWidth);
        if BevelOuter <> bvNone then Inc(EdgeSize, BevelWidth);
        if EdgeSize = 0 then
        begin
          R := ClientRect;
          C.Brush.Color := Color;
          FrameRect(R);
          InflateRect(R,-1,-1);
          FrameRect(R);
        end;

        R := ClientRect;
        DrawEdge(C.Handle, R, InnerStyles[BevelInner] or OuterStyles[BevelOuter],
          Byte(BevelEdges) or EdgeStyles[BevelKind] or Ctl3DStyles[Ctl3D] or BF_ADJUST);
        R.Left := R.Right - GetSystemMetrics(SM_CXHTHUMB);
        if Style <> csSimple then
          if DroppedDown then
            DrawFrameControl(C.Handle, R, DFC_SCROLL, DFCS_FLAT or DFCS_SCROLLCOMBOBOX)
          else
            DrawFrameControl(C.Handle, R, DFC_SCROLL, DFCS_FLAT or DFCS_SCROLLCOMBOBOX);
      end;
    end;
  finally
    C.Free;
  end;
end;

{ TButtonActionLink }

procedure TButtonActionLink.AssignClient(AClient: TObject);
begin
  inherited AssignClient(AClient);
  FClient := AClient as TButtonControl;
end;

function TButtonActionLink.IsCheckedLinked: Boolean;
begin
  Result := inherited IsCheckedLinked and
    (FClient.Checked = TCustomAction(Action).Checked);
end;

procedure TButtonActionLink.SetChecked(Value: Boolean);
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

{ TButtonControl }

constructor TButtonControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  if SysLocale.FarEast and (Win32Platform = VER_PLATFORM_WIN32_NT) then
    ImeMode := imDisable;
  TipMode := tipClose;
end;

procedure TButtonControl.ActionChange(Sender: TObject; CheckDefaults: Boolean);
var
  OldClicksDisabled: Boolean;
begin
  inherited ActionChange(Sender, CheckDefaults);
  if Sender is TCustomAction then
    with TCustomAction(Sender) do
      if not CheckDefaults or (Self.Checked = False) then
      begin
        // prevent generating Action.OnExecute when the control gets checked
        OldClicksDisabled := ClicksDisabled;
        ClicksDisabled := True;

        Self.Checked := Checked;

        ClicksDisabled := OldClicksDisabled;
      end;
end;

function TButtonControl.GetActionLinkClass: TControlActionLinkClass;
begin
  Result := TButtonActionLink;
end;

function TButtonControl.GetChecked: Boolean;
begin
  Result := False;
end;

function TButtonControl.IsCheckedStored: Boolean;
begin
  Result := (ActionLink = nil) or not TButtonActionLink(ActionLink).IsCheckedLinked;
end;

procedure TButtonControl.SetChecked(Value: Boolean);
begin
end;

procedure TButtonControl.WndProc(var Message: TMessage);
begin
  case Message.Msg of
    WM_LBUTTONDOWN, WM_LBUTTONDBLCLK:
      if not (csDesigning in ComponentState) and not Focused then
      begin
        FClicksDisabled := True;
        Winapi.Windows.SetFocus(Handle);
        FClicksDisabled := False;
        if not Focused then Exit;
      end;
    CN_COMMAND:
      if FClicksDisabled then Exit;
  end;
  inherited WndProc(Message);
end;

procedure TButtonControl.CNCtlColorStatic(var Message: TWMCtlColorStatic);
begin
  with StyleServices do
    if ThemeControl(Self) then
    begin
      if (Parent <> nil) and Parent.DoubleBuffered then
        PerformEraseBackground(Self, Message.ChildDC)
      else
        DrawParentBackground(Handle, Message.ChildDC, nil, False);
      { Return an empty brush to prevent Windows from overpainting we just have created. }
      Message.Result := GetStockObject(NULL_BRUSH);
    end
    else
      inherited;
end;

procedure TButtonControl.WMEraseBkGnd(var Message: TWMEraseBkGnd);
begin
  { Under theme services the background is drawn in CN_CTLCOLORSTATIC. }
  if StyleServices.Enabled then
    Message.Result := 1
  else
    inherited;
end;

procedure TButtonControl.CreateParams(var Params: TCreateParams);
begin
  inherited;
  if FWordWrap then
    Params.Style := Params.Style or BS_MULTILINE;
end;

procedure TButtonControl.SetWordWrap(const Value: Boolean);
begin
  if FWordWrap <> Value then
  begin
    FWordWrap := Value;
    RecreateWnd;
  end;
end;

{ TImageMargins }

procedure TImageMargins.Assign(Source: TPersistent);
begin
  if Source is TImageMargins then
  begin
    FLeft := TImageMargins(Source).Left;
    FTop := TImageMargins(Source).Top;
    FRight := TImageMargins(Source).Right;
    FBottom := TImageMargins(Source).Bottom;
    Change;
  end
  else
    inherited Assign(Source);
end;

procedure TImageMargins.Change;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

procedure TImageMargins.SetMargin(Index, Value: Integer);
begin
  case Index of
    0:
      if Value <> FLeft then
      begin
        FLeft := Value;
        Change;
      end;
    1:
      if Value <> FTop then
      begin
        FTop := Value;
        Change;
      end;
    2:
      if Value <> FRight then
      begin
        FRight := Value;
        Change;
      end;
    3:
      if Value <> FBottom then
      begin
        FBottom := Value;
        Change;
      end;
  end;
end;

{ TPushButtonActionLink }

function TPushButtonActionLink.IsImageIndexLinked: Boolean;
begin
  Result := inherited IsImageIndexLinked and
    (TCustomButton(FClient).ImageIndex = TCustomAction(Action).ImageIndex);
end;

procedure TPushButtonActionLink.SetImageIndex(Value: Integer);
begin
  if IsImageIndexLinked then
    TCustomButton(FClient).ImageIndex := Value;
end;

{ TCustomButton }

class constructor TCustomButton.Create;
begin
  TCustomStyleEngine.RegisterStyleHook(TCustomButton, TButtonStyleHook);
end;

constructor TCustomButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := [csSetCaption, csDoubleClicks];
  Width := 75;
  Height := 25;
  TabStop := True;
  FImageChangeLink := TChangeLink.Create;
  FImageChangeLink.OnChange := ImageListChange;
  FImageMargins := TImageMargins.Create;
  FImageMargins.OnChange := ImageMarginsChange;
  FInternalImageList := nil;
  FCommandLinkHint := '';
  FDisabledImageIndex := -1;
  FElevationRequired := False;
  FHotImageIndex := -1;
  FImageAlignment := iaLeft;
  FImageIndex := -1;
  FPressedImageIndex := -1;
  FSelectedImageIndex := -1;
  FStyle := bsPushButton;
  FStylusHotImageIndex := -1;
end;

class destructor TCustomButton.Destroy;
begin
  TCustomStyleEngine.UnRegisterStyleHook(TCustomButton, TButtonStyleHook);
end;

procedure TCustomButton.ActionChange(Sender: TObject; CheckDefaults: Boolean);
begin
  inherited ActionChange(Sender, CheckDefaults);
  if Sender is TCustomAction then
    with TCustomAction(Sender) do
    begin
      if not CheckDefaults or (Self.ImageIndex = -1) then
        Self.ImageIndex := ImageIndex;
    end;
end;

procedure TCustomButton.Click;
var
  Form: TCustomForm;
begin
  Form := GetParentForm(Self);
  if Form <> nil then Form.ModalResult := ModalResult;
  inherited Click;
end;

function GetColor(Value: DWORD): TColor;
begin
  case Value of
    CLR_NONE: Result := clNone;
    CLR_DEFAULT: Result := clDefault;
  else
    Result := TColor(Value);
  end;
end;

procedure TCustomButton.UpdateImageList;
const
  PBS_NORMAL = 1;
  PBS_HOT = 2;
  PBS_PRESSED = 3;
  PBS_DISABLED = 4;
  PBS_DEFAULTED = 5;
  PBS_STYLUSHOT = 6;
begin
  if CheckWin32Version(5, 1) and (FImages <> nil) and HandleAllocated then
  begin
    if FInternalImageList = nil then
      FInternalImageList := TImageList.Create(nil);
    with FInternalImageList do
    begin
      ColorDepth := FImages.ColorDepth;
      Masked := FImages.Masked;
      ImageType := FImages.ImageType;
      DrawingStyle := FImages.DrawingStyle;
      ShareImages := FImages.ShareImages;
      SetSize(FImages.Width, FImages.Height);
      if not HandleAllocated then
        HandleNeeded
      else
        ImageList_SetIconSize(Handle, Width, Height);
      BkColor := GetColor(ImageList_GetBkColor(FImages.Handle));
      BlendColor := FImages.BlendColor;
    end;
    UpdateImages;
    if FImageIndex <> -1 then
      SetImageList(FInternalImageList.Handle);
  end
  else
    SetImageList(0);
end;

procedure TCustomButton.UpdateImages;
begin
  if CheckWin32Version(5, 1) and (FImageIndex <> -1) then
  begin
    FInternalImageList.Clear;
    // PBS_NORMAL
    FInternalImageList.AddImage(FImages, FImageIndex);
    // PBS_HOT
    if FHotImageIndex <> -1 then
      FInternalImageList.AddImage(FImages, FHotImageIndex)
    else
      FInternalImageList.AddImage(FImages, FImageIndex);
    // PBS_PRESSED
    if FPressedImageIndex <> -1 then
      FInternalImageList.AddImage(FImages, FPressedImageIndex)
    else
      FInternalImageList.AddImage(FImages, FImageIndex);
    // PBS_DISABLED
    if FDisabledImageIndex <> -1 then
      FInternalImageList.AddImage(FImages, FDisabledImageIndex)
    else
      FInternalImageList.AddImage(FImages, FImageIndex);
    // PBS_DEFAULTED
    if FSelectedImageIndex <> -1 then
      FInternalImageList.AddImage(FImages, FSelectedImageIndex)
    else
      FInternalImageList.AddImage(FImages, FImageIndex);
    // PBS_STYLUSHOT
    if FStylusHotImageIndex <> -1 then
      FInternalImageList.AddImage(FImages, FStylusHotImageIndex)
    else if FSelectedImageIndex <> -1 then
      FInternalImageList.AddImage(FImages, FSelectedImageIndex)
    else
      FInternalImageList.AddImage(FImages, FImageIndex);
  end;
end;

function TCustomButton.UseRightToLeftAlignment: Boolean;
begin
  Result := False;
end;

procedure TCustomButton.SetButtonStyle(ADefault: Boolean);
const
  BS_MASK = $000F;
  NormalStyles: array[Boolean] of Integer = (BS_PUSHBUTTON, BS_DEFPUSHBUTTON);
  CommandLinkStyles: array[Boolean] of Integer = (BS_COMMANDLINK, BS_DEFCOMMANDLINK);
  SplitButtonStyles: array[Boolean] of Integer = (BS_SPLITBUTTON, BS_DEFSPLITBUTTON);
var
  LStyle: Integer;
begin
  if HandleAllocated then
  begin
    if Win32MajorVersion >= 6 then
      case FStyle of
        bsCommandLink: LStyle := CommandLinkStyles[ADefault];
        bsSplitButton: LStyle := SplitButtonStyles[ADefault];
      else
        LStyle := NormalStyles[ADefault];
      end
    else
      LStyle := NormalStyles[ADefault];
    if (GetWindowLong(Handle, GWL_STYLE) and BS_MASK) <> LStyle then
      SendMessage(Handle, BM_SETSTYLE, LStyle, 1);
  end;
end;

procedure TCustomButton.SetCommandLinkHint(const Value: string);
begin
  if Value <> FCommandLinkHint then
  begin
    FCommandLinkHint := Value;
    if HandleAllocated and (FStyle = bsCommandLink) then
      UpdateCommandLinkHint;
  end;
end;

procedure TCustomButton.SetDefault(Value: Boolean);
var
  Form: TCustomForm;
begin
  FDefault := Value;
  if HandleAllocated then
  begin
    Form := GetParentForm(Self);
    if Form <> nil then
{$IF DEFINED(CLR)}
      (Form as IWinControl).FocusChanged(Form.ActiveControl);
{$ELSE}
      Form.Perform(CM_FOCUSCHANGED, 0, LPARAM(Form.ActiveControl));
{$ENDIF}
  end;
end;

procedure TCustomButton.SetDisabledImageIndex(const Value: TImageIndex);
begin
  if Value <> FDisabledImageIndex then
  begin
    FDisabledImageIndex := Value;
    if FInternalImageList <> nil then
    begin
      UpdateImages;
      Invalidate;
    end;
  end;
end;

procedure TCustomButton.SetDropDownMenu(const Value: TPopupMenu);
begin
  if Value <> FDropDownMenu then
  begin
    FDropDownMenu := Value;
    if Value <> nil then
      Value.FreeNotification(Self);
  end;
end;

procedure TCustomButton.SetElevationRequired(const Value: Boolean);
begin
  if Value <> FElevationRequired then
  begin
    FElevationRequired := Value;
    if HandleAllocated then
    begin
      SetElevationRequiredState;
      if not FElevationRequired then
        UpdateImageList; // rebuild imagelist for button
    end;
  end;
end;

procedure TCustomButton.SetElevationRequiredState;
begin
  if CheckWin32Version(6, 0) and HandleAllocated then
    Button_SetElevationRequiredState(Handle, FElevationRequired);
end;

procedure TCustomButton.SetHotImageIndex(const Value: TImageIndex);
begin
  if Value <> FHotImageIndex then
  begin
    FHotImageIndex := Value;
    if FInternalImageList <> nil then
    begin
      UpdateImages;
      Invalidate;
    end;
  end;
end;

procedure TCustomButton.SetImageAlignment(const Value: TImageAlignment);
begin
  if Value <> FImageAlignment then
  begin
    FImageAlignment := Value;
    if FInternalImageList <> nil then
      SetImageList(FInternalImageList.Handle);
    Invalidate;
  end;
end;

procedure TCustomButton.SetImageIndex(const Value: TImageIndex);
var
  LOldIndex: TImageIndex;
begin
  if Value <> FImageIndex then
  begin
    LOldIndex := FImageIndex;
    FImageIndex := Value;
    if FInternalImageList <> nil then
    begin
      if FImageIndex <> -1 then
      begin
        UpdateImages;
        if LOldIndex = -1 then
          SetImageList(FInternalImageList.Handle)
      end
      else
      begin
        FInternalImageList.Clear;
        SetImageList(0);
      end;
      Invalidate;
    end;
  end;
end;

procedure TCustomButton.SetImageList(AHandle: HIMAGELIST);
const
  ImageAlignments: array[TImageAlignment] of DWORD = (BUTTON_IMAGELIST_ALIGN_LEFT,
    BUTTON_IMAGELIST_ALIGN_RIGHT, BUTTON_IMAGELIST_ALIGN_TOP,
    BUTTON_IMAGELIST_ALIGN_BOTTOM, BUTTON_IMAGELIST_ALIGN_CENTER);
var
  UpdateImages: Boolean;
  LButtonImageList: TButtonImageList;
begin
  if HandleAllocated then
  begin
    if Win32MajorVersion >= 6 then
      UpdateImages := not FElevationRequired
    else
      UpdateImages := CheckWin32Version(5, 1);

    if UpdateImages then
    begin
      LButtonImageList.himl := AHandle;
      LButtonImageList.uAlign := ImageAlignments[FImageAlignment];
      with FImageMargins do
        LButtonImageList.margin := Rect(Left, Top, Right, Bottom);
      Button_SetImageList(Handle, LButtonImageList);
    end;
  end;
end;

procedure TCustomButton.SetImageMargins(const Value: TImageMargins);
begin
  FImageMargins.Assign(Value);
end;

procedure TCustomButton.SetImages(const Value: TCustomImageList);
begin
  if Value <> FImages then
  begin
    if Images <> nil then
      Images.UnRegisterChanges(FImageChangeLink);
    FImages := Value;
    if Images <> nil then
    begin
      Images.RegisterChanges(FImageChangeLink);
      Images.FreeNotification(Self);
    end;
    UpdateImageList;
  end;
end;

procedure TCustomButton.SetPressedImageIndex(const Value: TImageIndex);
begin
  if Value <> FPressedImageIndex then
  begin
    FPressedImageIndex := Value;
    if FInternalImageList <> nil then
    begin
      UpdateImages;
      Invalidate;
    end;
  end;
end;

procedure TCustomButton.SetSelectedImageIndex(const Value: TImageIndex);
begin
  if Value <> FSelectedImageIndex then
  begin
    FSelectedImageIndex := Value;
    if FInternalImageList <> nil then
    begin
      UpdateImages;
      Invalidate;
    end;
  end;
end;

procedure TCustomButton.SetStyle(const Value: TButtonStyle);
const
  DefCmdLinkWidth = 175;
  DefCmdLinkHeights: array[Boolean] of Integer = (57, 41);
var
  LAligning: Boolean;
begin
  if Value <> FStyle then
  begin
    if (csLoading in ComponentState) then
      FStyle := Value
    else
      case Value of
        bsPushButton,
        bsSplitButton:
          begin
            if FStyle = bsCommandLink then
              SetBounds(Left, Top, ExplicitWidth, ExplicitHeight);
            FStyle := Value;
            RecreateWnd;
          end;
        bsCommandLink:
          begin
            LAligning := csAligning in ControlState;
            if not LAligning then
              ControlState := ControlState + [csAligning];
            try
              if Height < DefCmdLinkHeights[FCommandLinkHint = ''] then
                Height := DefCmdLinkHeights[FCommandLinkHint = ''];
              if Width < DefCmdLinkWidth then
                Width := DefCmdLinkWidth;
              FStyle := Value;
              RecreateWnd;
            finally
              if not LAligning then
                ControlState := ControlState - [csAligning];
            end;
          end;
      end;
  end;
end;

procedure TCustomButton.SetStylusHotImageIndex(const Value: TImageIndex);
begin
  if Value <> FStylusHotImageIndex then
  begin
    FStylusHotImageIndex := Value;
    if FInternalImageList <> nil then
    begin
      UpdateImages;
      Invalidate;
    end;
  end;
end;

procedure TCustomButton.CreateParams(var Params: TCreateParams);
const
  NormalStyles: array[Boolean] of Cardinal = (BS_PUSHBUTTON, BS_DEFPUSHBUTTON);
  CommandLinkStyles: array[Boolean] of Cardinal = (BS_COMMANDLINK, BS_DEFCOMMANDLINK);
  SplitButtonStyles: array[Boolean] of Cardinal = (BS_SPLITBUTTON, BS_DEFSPLITBUTTON);
begin
  inherited CreateParams(Params);
  CreateSubClass(Params, 'BUTTON');
  if Win32MajorVersion >= 6 then
    case FStyle of
      bsCommandLink: Params.Style := Params.Style or CommandLinkStyles[Default];
      bsSplitButton: Params.Style := Params.Style or SplitButtonStyles[Default];
    else
      Params.Style := Params.Style or NormalStyles[Default];
    end
  else
    Params.Style := Params.Style or NormalStyles[Default];
end;

procedure TCustomButton.CreateWnd;
begin
  inherited CreateWnd;
  FActive := FDefault;
  if not (csLoading in ComponentState) then
  begin
    SetElevationRequiredState;
    UpdateImageList;
    if FStyle = bsCommandLink then
      UpdateCommandLinkHint;
  end;
end;

destructor TCustomButton.Destroy;
begin
  FreeAndNil(FImageChangeLink);
  if FInternalImageList <> nil then
    FreeAndNil(FInternalImageList);
  FreeAndNil(FImageMargins);
  inherited;
end;

function TCustomButton.GetActionLinkClass: TControlActionLinkClass;
begin
  Result := TPushButtonActionLink;
end;

procedure TCustomButton.UpdateCommandLinkHint;
begin
  if Win32MajorVersion >= 6 then
    Button_SetNote(Handle, FCommandLinkHint);
end;

procedure TCustomButton.ImageListChange(Sender: TObject);
begin
  if HandleAllocated then
    UpdateImageList;
end;

procedure TCustomButton.ImageMarginsChange(Sender: TObject);
begin
  if HandleAllocated and (FInternalImageList <> nil) then
    SetImageList(FInternalImageList.Handle);
  Invalidate;
end;

function TCustomButton.IsImageIndexStored: Boolean;
begin
  Result := (ActionLink = nil) or not TPushButtonActionLink(ActionLink).IsImageIndexLinked;
end;

procedure TCustomButton.Loaded;
begin
  inherited;
  SetElevationRequiredState;
  UpdateImageList;
  if FStyle = bsCommandLink then
    UpdateCommandLinkHint;
end;

procedure TCustomButton.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin
    if AComponent = FDropDownMenu then
      FDropDownMenu := nil;
    if AComponent = FImages then
    begin
      FImages := nil;
      UpdateImageList;
    end;
  end;
end;

procedure TCustomButton.CNCommand(var Message: TWMCommand);
begin
  if Message.NotifyCode = BN_CLICKED then Click;
end;

procedure TCustomButton.CMDialogKey(var Message: TCMDialogKey);
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

procedure TCustomButton.CMDialogChar(var Message: TCMDialogChar);
begin
  with Message do
    if IsAccel(CharCode, Caption) and CanFocus then
    begin
      Click;
      Result := 1;
    end else
      inherited;
end;

{$IF DEFINED(CLR)}
[UIPermission(SecurityAction.LinkDemand, Window=UIPermissionWindow.AllWindows)]
procedure TCustomButton.FocusChanged(NewFocusControl: TWinControl);
begin
  if NewFocusControl is TCustomButton then
    FActive := NewFocusControl = Self
  else
    FActive := FDefault;
  SetButtonStyle(FActive);
  inherited;
end;
{$ENDIF}

{$IF NOT DEFINED(CLR)}
procedure TCustomButton.CMFocusChanged(var Message: TCMFocusChanged);
begin
  with Message do
    if Sender is TCustomButton then
      FActive := Sender = Self
    else
      FActive := FDefault;
  SetButtonStyle(FActive);
  inherited;
end;
{$ENDIF}

procedure TCustomButton.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  if StyleServices.Enabled then
    Message.Result := 1
  else
    DefaultHandler(Message);
end;

procedure TCustomButton.CNCtlColorBtn(var Message: TWMCtlColorBtn);
begin
  with StyleServices do
    if Enabled then
    begin
      if (Parent <> nil) and Parent.DoubleBuffered then
        PerformEraseBackground(Self, Message.ChildDC)
      else
        DrawParentBackground(Handle, Message.ChildDC, nil, False);
      { Return an empty brush to prevent Windows from overpainting we just have created. }
      Message.Result := GetStockObject(NULL_BRUSH);
    end
    else
      inherited;
end;

procedure TCustomButton.CNNotify(var Message: TWMNotify);
var
  Pt: TPoint;
  LRect: TRect;
begin
  if Message.NMHdr.code = BCN_DROPDOWN then
  begin
    if Assigned(FOnDropDownClick) then
      FOnDropDownClick(Self);
    if Assigned(FDropDownMenu) then
    begin
{$IF DEFINED(CLR)}
      LRect := TWMNotifyButton.Create(Message.OriginalMessage).BCDropDown.rcButton;
{$ELSE}
      LRect := PNMBCDropDown(Message.NMHdr).rcButton;
{$ENDIF}
      Pt := ClientToScreen(Point(LRect.Left, LRect.Bottom));
      FDropDownMenu.Popup(Pt.X, Pt.Y);
    end;
  end;
end;

{ TCustomCheckBox }

class constructor TCustomCheckBox.Create;
begin
  TCustomStyleEngine.RegisterStyleHook(TCustomCheckBox, TCheckBoxStyleHook);
end;

constructor TCustomCheckBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Width := 97;
  Height := 17;
  TabStop := True;
  ControlStyle := [csSetCaption, csDoubleClicks];
  FAlignment := taRightJustify;
end;

class destructor TCustomCheckBox.Destroy;
begin
  TCustomStyleEngine.UnRegisterStyleHook(TCustomCheckBox, TCheckBoxStyleHook);
end;

procedure TCustomCheckBox.UpdateStyleElements;
begin
  Invalidate;
end;

function TCustomCheckBox.GetControlsAlignment: TAlignment;
begin
  if not UseRightToLeftAlignment then
    Result := taRightJustify
  else
    if FAlignment = taRightJustify then
      Result := taLeftJustify
    else
      Result := taRightJustify;
end;

procedure TCustomCheckBox.KeyPress(var Key: Char);
begin
  if Observers.IsObserving(TObserverMapping.EditLinkID) then
  begin
    if TLinkObservers.EditLinkIsReadOnly(Observers) then
      Exit;
    case Key of
      #8, ' ':
        if TLinkObservers.EditLinkEdit(Observers) then
          TLinkObservers.EditLinkModified(Observers);
    end;
  end;
  inherited KeyPress(Key);
  case Key of
    #8, ' ':
      try
        if Observers.IsObserving(TObserverMapping.EditLinkID) then
          if TLinkObservers.EditLinkIsEditing(Observers) then
            TLinkObservers.EditLinkTrackUpdate(Observers);
        if Observers.IsObserving(TObserverMapping.ControlValueID) then
        begin
          TLinkObservers.ControlValueModified(Observers);
          TLinkObservers.ControlValueTrackUpdate(Observers);
        end;
      except
        SetFocus;
        raise;
      end;
  end;
end;

function TCustomCheckBox.CanObserve(const ID: Integer): Boolean;
begin
  Result := False;
  if ID = TObserverMapping.EditLinkID then
    Result := True
  else if ID = TObserverMapping.ControlValueID then
    Result := True;
end;

procedure TCustomCheckBox.ObserverAdded(const ID: Integer;
  const Observer: IObserver);
begin
  if ID = TObserverMapping.EditLinkID then
    Observer.OnObserverToggle := ObserverToggle;
end;

procedure TCustomCheckBox.ObserverToggle(const AObserver: IObserver;
  const Value: Boolean);
var
  LEditLinkObserver: IEditLinkObserver;
begin
  if Value then
  begin
    if Supports(AObserver, IEditLinkObserver, LEditLinkObserver) then
    begin
      AllowGrayed := not LEditLinkObserver.IsRequired;
    end;
  end
  else
  begin
    AllowGrayed := False;
  end;
end;

procedure TCustomCheckBox.Toggle;
begin
  if Observers.IsObserving(TObserverMapping.EditLinkID) then
  begin
    if TLinkObservers.EditLinkIsReadOnly(Observers) then
      Exit;
    if TLinkObservers.EditLinkEdit(Observers) then
      TLinkObservers.EditLinkModified(Observers);
  end;
  case State of
    cbUnchecked:
      if AllowGrayed then State := cbGrayed else State := cbChecked;
    cbChecked: State := cbUnchecked;
    cbGrayed: State := cbChecked;
  end;
  try
    if Observers.IsObserving(TObserverMapping.EditLinkID) then
      if TLinkObservers.EditLinkIsEditing(Observers) then
        TLinkObservers.EditLinkTrackUpdate(Observers);
    if Observers.IsObserving(TObserverMapping.ControlValueID) then
    begin
      TLinkObservers.ControlValueModified(Observers);
      TLinkObservers.ControlValueTrackUpdate(Observers);
    end;
  except
    SetFocus;
    raise;
  end;
end;

procedure TCustomCheckBox.Click;
begin
  inherited Changed;
  inherited Click;
end;

function TCustomCheckBox.GetChecked: Boolean;
begin
  Result := State = cbChecked;
end;

procedure TCustomCheckBox.SetAlignment(Value: TLeftRight);
begin
  if FAlignment <> Value then
  begin
    FAlignment := Value;
    RecreateWnd;
  end;
end;

procedure TCustomCheckBox.SetChecked(Value: Boolean);
begin
  if Value then State := cbChecked else State := cbUnchecked;
end;

procedure TCustomCheckBox.SetState(Value: TCheckBoxState);
begin
  if FState <> Value then
  begin
    FState := Value;
    if HandleAllocated then
      SendMessage(Handle, BM_SETCHECK, WPARAM(NativeInt(FState)), 0);
    if not ClicksDisabled then Click;
  end;
end;

procedure TCustomCheckBox.CreateParams(var Params: TCreateParams);
const
  Alignments: array[Boolean, TLeftRight] of DWORD =
    ((BS_LEFTTEXT, 0), (0, BS_LEFTTEXT));
begin
  inherited CreateParams(Params);
  CreateSubClass(Params, 'BUTTON');
  with Params do
  begin
    Style := Style or BS_3STATE or
      Alignments[UseRightToLeftAlignment, FAlignment];
    WindowClass.style := WindowClass.style and not (CS_HREDRAW or CS_VREDRAW);
  end;
end;

[UIPermission(SecurityAction.LinkDemand, Window=UIPermissionWindow.AllWindows)]
procedure TCustomCheckBox.CreateWnd;
begin
  inherited CreateWnd;
  SendMessage(Handle, BM_SETCHECK, WPARAM(NativeInt(FState)), 0);
end;

procedure TCustomCheckBox.WMSize(var Message: TWMSize);
begin
  inherited;
  Invalidate;
end;

procedure TCustomCheckBox.CMCtl3DChanged(var Message: TMessage);
begin
  RecreateWnd;
end;

procedure TCustomCheckBox.CMDialogChar(var Message: TCMDialogChar);
begin
  with Message do
    if IsAccel(CharCode, Caption) and CanFocus then
    begin
      SetFocus;
      if Focused then Toggle;
      Result := 1;
    end else
      inherited;
end;

procedure TCustomCheckBox.CMExit(var Message: TCMExit);
begin
  try
    if Observers.IsObserving(TObserverMapping.EditLinkID) then
      TLinkObservers.EditLinkUpdate(Observers);
    if Observers.IsObserving(TObserverMapping.ControlValueID) then
      TLinkObservers.ControlValueUpdate(Observers);
  except
    SetFocus;
    raise;
  end;
  inherited;
end;

procedure TCustomCheckBox.CNCommand(var Message: TWMCommand);
begin
  if Message.NotifyCode = BN_CLICKED then Toggle;
end;

{ TRadioButton }

class constructor TRadioButton.Create;
begin
  TCustomStyleEngine.RegisterStyleHook(TRadioButton, TRadioButtonStyleHook);
end;

constructor TRadioButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Width := 113;
  Height := 17;
  ControlStyle := [csSetCaption, csDoubleClicks];
  FAlignment := taRightJustify;
end;

class destructor TRadioButton.Destroy;
begin
  TCustomStyleEngine.UnRegisterStyleHook(TRadioButton, TRadioButtonStyleHook);
end;

procedure TRadioButton.UpdateStyleElements;
begin
  Invalidate;
end;

function TRadioButton.GetChecked: Boolean;
begin
  Result := FChecked;
end;

function TRadioButton.GetControlsAlignment: TAlignment;
begin
  if not UseRightToLeftAlignment then
    Result := taRightJustify
  else
    if FAlignment = taRightJustify then
      Result := taLeftJustify
    else
      Result := taRightJustify;
end;

procedure TRadioButton.SetAlignment(Value: TLeftRight);
begin
  if FAlignment <> Value then
  begin
    FAlignment := Value;
    RecreateWnd;
  end;
end;

procedure TRadioButton.SetChecked(Value: Boolean);

  procedure TurnSiblingsOff;
  var
    I: Integer;
    Sibling: TControl;
  begin
    if Parent <> nil then
      with Parent do
        for I := 0 to ControlCount - 1 do
        begin
          Sibling := Controls[I];
          if (Sibling <> Self) and (Sibling is TRadioButton) then
            with TRadioButton(Sibling) do
            begin
              if Assigned(Action) and
                 (Action is TCustomAction) and
                 TCustomAction(Action).AutoCheck then
                TCustomAction(Action).Checked := False;
              SetChecked(False);
            end;
        end;
  end;

begin
  if FChecked <> Value then
  begin
    FChecked := Value;
    TabStop := Value;
    if HandleAllocated then
      SendMessage(Handle, BM_SETCHECK, WPARAM(Checked), 0);
    if Value then
    begin
      TurnSiblingsOff;
      inherited Changed;
      if not ClicksDisabled then Click;
    end;
  end;
end;

procedure TRadioButton.CreateParams(var Params: TCreateParams);
const
  Alignments: array[Boolean, TLeftRight] of DWORD =
    ((BS_LEFTTEXT, 0), (0, BS_LEFTTEXT));
begin
  inherited CreateParams(Params);
  CreateSubClass(Params, 'BUTTON');
  with Params do
    Style := Style or BS_RADIOBUTTON or
      Alignments[UseRightToLeftAlignment, FAlignment];
end;

[UIPermission(SecurityAction.LinkDemand, Window=UIPermissionWindow.AllWindows)]
procedure TRadioButton.CreateWnd;
begin
  inherited CreateWnd;
  SendMessage(Handle, BM_SETCHECK, WPARAM(FChecked), 0);
end;

procedure TRadioButton.CMCtl3DChanged(var Message: TMessage);
begin
  RecreateWnd;
end;

procedure TRadioButton.CMDialogChar(var Message: TCMDialogChar);
begin
  with Message do
    if IsAccel(Message.CharCode, Caption) and CanFocus then
    begin
      SetFocus;
      Result := 1;
    end else
      inherited;
end;

procedure TRadioButton.CNCommand(var Message: TWMCommand);
begin
  case Message.NotifyCode of
    BN_CLICKED: SetChecked(True);
    BN_DOUBLECLICKED: DblClick;
  end;
end;

{ TListBoxStrings }

function TListBoxStrings.GetCount: Integer;
begin
  Result := SendMessage(ListBox.Handle, LB_GETCOUNT, 0, 0);
end;

function TListBoxStrings.Get(Index: Integer): string;
var
  Len: Integer;
begin
  if ListBox.Style in [lbVirtual, lbVirtualOwnerDraw] then
    Result := ListBox.DoGetData(Index)
  else
  begin
    Len := SendMessage(ListBox.Handle, LB_GETTEXTLEN, Index, 0);
    if Len = LB_ERR then Error(SListIndexError, Index);
                            
{$IF DEFINED(CLR)}
    if Len <> 0 then
      SendGetTextMessage(ListBox.Handle, LB_GETTEXT, Index, Result, Len, False)
    else
      Result := '';
{$ELSE}
    SetLength(Result, Len);
    if Len <> 0 then
    begin
      Len := SendMessage(ListBox.Handle, LB_GETTEXT, Index, LPARAM(PChar(Result)));
      SetLength(Result, Len);  // LB_GETTEXTLEN isn't guaranteed to be accurate
    end;
{$ENDIF}
  end;
end;

function TListBoxStrings.GetObject(Index: Integer): TObject;
begin
  if ListBox.Style in [lbVirtual, lbVirtualOwnerDraw] then
    Result := ListBox.DoGetDataObject(Index)
  else
  begin
{$IF DEFINED(CLR)}
    if (Index < 0) or (Index >= Count) then
      Error(SListIndexError, Index);
    Result := TObject(ListBox.GetItemData(Index));
{$ELSE}
    Result := TObject(ListBox.GetItemData(Index));
    if TListBoxItemData(Result) = LB_ERR then Error(SListIndexError, Index);
{$ENDIF}
  end;
end;

procedure TListBoxStrings.Put(Index: Integer; const S: string);
var
  I: Integer;
  TempData: TListBoxItemData;
begin
  I := ListBox.ItemIndex;
  TempData := ListBox.InternalGetItemData(Index);
  // Set the Item to 0 in case it is an object that gets freed during Delete
{$IF DEFINED(CLR)}
  ListBox.InternalSetItemData(Index, nil);
{$ELSE}
  ListBox.InternalSetItemData(Index, 0);
{$ENDIF}
  Delete(Index);
  InsertObject(Index, S, nil);
  ListBox.InternalSetItemData(Index, TempData);
  ListBox.ItemIndex := I;
end;

procedure TListBoxStrings.PutObject(Index: Integer; AObject: TObject);
begin
  if not (ListBox.Style in [lbVirtual, lbVirtualOwnerDraw]) then
  begin
   // Calling Insert (LB_INSERTSTRING) with an index of -1 adds the
   // string to the end of the list. Mimic that behaviour for InsertObject
   // since an index of -1 with LB_SETITEMDATA means something completely
   // different (it sets the "data" for ALL items in the list).
   if Index = -1 then
     Index := Count - 1;
{$IF DEFINED(CLR)}
    ListBox.SetItemData(Index, AObject);
{$ELSE}
    ListBox.SetItemData(Index, TListBoxItemData(AObject));
{$ENDIF}
  end;
end;

function TListBoxStrings.Add(const S: string): Integer;
begin
  Result := -1;
  if ListBox.Style in [lbVirtual, lbVirtualOwnerDraw] then Exit;
{$IF DEFINED(CLR)}
  if not Assigned(S) then
    Result := SendTextMessage(ListBox.Handle, LB_ADDSTRING, 0, '')
  else
{$ENDIF}
    Result := SendTextMessage(ListBox.Handle, LB_ADDSTRING, 0, S);
  if Result < 0 then raise EOutOfResources.Create(SInsertLineError);
end;

procedure TListBoxStrings.Insert(Index: Integer; const S: string);
var
  LResult: Integer;
begin
  if ListBox.Style in [lbVirtual, lbVirtualOwnerDraw] then exit;
{$IF DEFINED(CLR)}
  if not Assigned(S) then
    LResult := SendTextMessage(ListBox.Handle, LB_INSERTSTRING, Index, '')
  else
{$ENDIF}
    LResult := SendTextMessage(ListBox.Handle, LB_INSERTSTRING, Index, S);
  if LResult < 0 then
    raise EOutOfResources.Create(SInsertLineError);
end;

procedure TListBoxStrings.Delete(Index: Integer);
begin
  ListBox.DeleteString(Index);
end;

procedure TListBoxStrings.Exchange(Index1, Index2: Integer);
var
  TempData: TListBoxItemData;
  TempString: string;
begin
  if ListBox.Style in [lbVirtual, lbVirtualOwnerDraw] then exit;
  BeginUpdate;
  try
    TempString := Strings[Index1];
    TempData := ListBox.InternalGetItemData(Index1);
    Strings[Index1] := Strings[Index2];
    ListBox.InternalSetItemData(Index1, ListBox.InternalGetItemData(Index2));
    Strings[Index2] := TempString;
    ListBox.InternalSetItemData(Index2, TempData);
    if ListBox.ItemIndex = Index1 then
      ListBox.ItemIndex := Index2
    else if ListBox.ItemIndex = Index2 then
      ListBox.ItemIndex := Index1;
  finally
    EndUpdate;
  end;
end;

procedure TListBoxStrings.Clear;
begin
  ListBox.ResetContent;
end;

procedure TListBoxStrings.SetUpdateState(Updating: Boolean);
begin
  SendMessage(ListBox.Handle, WM_SETREDRAW, Ord(not Updating), 0);
  if not Updating then ListBox.Refresh;
end;

function TListBoxStrings.IndexOf(const S: string): Integer;
begin
  if ListBox.Style in [lbVirtual, lbVirtualOwnerDraw] then
    Result := ListBox.DoFindData(S)
  else
    Result := SendTextMessage(ListBox.Handle, LB_FINDSTRINGEXACT, WPARAM(-1), S);
end;

procedure TListBoxStrings.Move(CurIndex, NewIndex: Integer);
var
  TempData: TListBoxItemData;
  TempString: string;
begin
  if ListBox.Style in [lbVirtual, lbVirtualOwnerDraw] then exit;
  BeginUpdate;
  ListBox.FMoving := True;
  try
    if CurIndex <> NewIndex then
    begin
      TempString := Get(CurIndex);
      TempData := ListBox.InternalGetItemData(CurIndex);
{$IF DEFINED(CLR)}
      ListBox.InternalSetItemData(CurIndex, nil);
{$ELSE}
      ListBox.InternalSetItemData(CurIndex, 0);
{$ENDIF}
      Delete(CurIndex);
      Insert(NewIndex, TempString);
      ListBox.InternalSetItemData(NewIndex, TempData);
    end;
  finally
    ListBox.FMoving := False;
    EndUpdate;
  end;
end;

{ TCustomListBox }

class constructor TCustomListBox.Create;
begin
  TCustomStyleEngine.RegisterStyleHook(TCustomListBox, TListBoxStyleHook);
end;

constructor TCustomListBox.Create(AOwner: TComponent);
const
  ListBoxStyle = [csSetCaption, csDoubleClicks, csOpaque, csPannable, csGestures];
begin
  inherited Create(AOwner);
  if NewStyleControls then
    ControlStyle := ListBoxStyle else
    ControlStyle := ListBoxStyle + [csFramed];
  Width := 121;
  Height := 97;
  TabStop := True;
  ParentColor := False;
  FAutoComplete := True;
  FItems := TListBoxStrings.Create;
  TListBoxStrings(FItems).ListBox := Self;
{$IF DEFINED(CLR)}
  FObjects := TGCHandleList.Create;
{$ENDIF}
  FCanvas := TControlCanvas.Create;
  TControlCanvas(FCanvas).Control := Self;
  FItemHeight := 16;
  FBorderStyle := bsSingle;
  FExtendedSelect := True;
  FOldCount := -1;
  FAutoCompleteDelay := 500;
  FInBufferedPrintClient := False;
end;

class destructor TCustomListBox.Destroy;
begin
  TCustomStyleEngine.UnRegisterStyleHook(TCustomListBox, TListBoxStyleHook);
end;

destructor TCustomListBox.Destroy;
begin
  FCanvas.Free;
  FItems.Free;
  FSaveItems.Free;
{$IF DEFINED(CLR)}
  FObjects.Clear;
  GC.SuppressFinalize(FObjects);
{$ENDIF}
  inherited Destroy;
end;

procedure TCustomListBox.AddItem(Item: string; AObject: TObject);
{$IF DEFINED(CLR)}
var
  I: Integer;
begin
  for I := 1 to Length(Item) do
    if Item[I] = #0 then
    begin
      SetLength(Item, I);
      Break;
    end;
  Items.AddObject(Item, AObject);
end;
{$ELSE}
var
  S: String;
begin
  SetString(S, PChar(Item), StrLen(PChar(Item)));
  Items.AddObject(S, AObject);
end;
{$ENDIF}

function TCustomListBox.GetItemData(Index: Integer): TListBoxItemData;
var
  LItemData: TListBoxItemData;
begin
  LItemData := SendMessage(Handle, LB_GETITEMDATA, Index, 0);
{$IF DEFINED(CLR)}
  if LItemData <> 0 then
    Result := GCHandle(FObjects.Item[TObject(LItemData)]).Target
  else
    Result := nil;
{$ELSE}
  Result := LItemData;
{$ENDIF}
end;

procedure TCustomListBox.SetItemData(Index: Integer; AData: TListBoxItemData);
{$IF DEFINED(CLR)}
var
  LHandle: GCHandle;
  LItemData: Integer;
begin
  // If it's an existing item, free the previous GCHandle
  LItemData := SendMessage(Handle, LB_GETITEMDATA, Index, 0);
  if LItemData <> 0 then
  begin
    LHandle := GCHandle(FObjects[TObject(LItemData)]);
    if LHandle.IsAllocated then
      LHandle.Free;
    FObjects.Remove(TObject(LItemData));
  end;

  // Allocate GCHandle and add to hash table
  LHandle := GCHandle.Alloc(AData);
  FObjects.Add(TObject(LHandle.GetHashCode), LHandle);
  SendMessage(Handle, LB_SETITEMDATA, Index, LHandle.GetHashCode);
end;
{$ELSE}
begin
  SendMessage(Handle, LB_SETITEMDATA, Index, AData);
end;
{$ENDIF}

function TCustomListBox.InternalGetItemData(Index: Integer): TListBoxItemData;
begin
  Result := GetItemData(Index);
end;

procedure TCustomListBox.InternalSetItemData(Index: Integer; AData: TListBoxItemData);
begin
  SetItemData(Index, AData);
end;

procedure TCustomListBox.DeleteString( Index: Integer );
{$IF DEFINED(CLR)}
var
  LHandle: GCHandle;
  LItemData: Integer;
{$ENDIF}
begin
{$IF DEFINED(CLR)}
  // Free GChandle if item has data associated
  LItemData := SendMessage(Handle, LB_GETITEMDATA, Index, 0);
  if LItemData <> 0 then
  begin
    LHandle := GCHandle(FObjects[TObject(LItemData)]);
    if LHandle.IsAllocated then
      LHandle.Free;
    FObjects.Remove(TObject(LItemData));
  end;
{$ENDIF}
  SendMessage(Handle, LB_DELETESTRING, Index, 0);
end;

procedure TCustomListBox.ResetContent;
begin
  if Style in [lbVirtual, lbVirtualOwnerDraw] then exit;
  SendMessage(Handle, LB_RESETCONTENT, 0, 0);
{$IF DEFINED(CLR)}
  FObjects.Clear;
{$ENDIF}
end;

procedure TCustomListBox.SaveRecreateItems(RecreateItems: TStrings);
begin
  RecreateItems.Assign(FItems);
end;

procedure TCustomListBox.Clear;
begin
  FItems.Clear;
end;

procedure TCustomListBox.ClearSelection;
var
  I: Integer;
begin
  if MultiSelect then
    for I := 0 to Items.Count - 1 do
      Selected[I] := False
  else
    ItemIndex := -1;
end;

procedure TCustomListBox.CopySelection(Destination: TCustomListControl);
var
  I: Integer;
begin
  if MultiSelect then
  begin
    for I := 0 to Items.Count - 1 do
      if Selected[I] then
{$IF DEFINED(CLR)}
        Destination.AddItem(Items[I], Items.Objects[I]);
{$ELSE}
        Destination.AddItem(PChar(Items[I]), Items.Objects[I]);
{$ENDIF}
  end
  else
    if ItemIndex <> -1 then
{$IF DEFINED(CLR)}
      Destination.AddItem(Items[ItemIndex], Items.Objects[ItemIndex]);
{$ELSE}
      Destination.AddItem(PChar(Items[ItemIndex]), Items.Objects[ItemIndex]);
{$ENDIF}
end;

procedure TCustomListBox.DeleteSelected;
var
  I: Integer;
begin
  if MultiSelect then
  begin
    for I := Items.Count - 1 downto 0 do
      if Selected[I] then
        Items.Delete(I);
  end
  else
    if ItemIndex <> -1 then
      Items.Delete(ItemIndex);
end;

procedure TCustomListBox.SetColumnWidth;
var
  ColWidth: Integer;
begin
  if (FColumns > 0) and (Width > 0) then
  begin
    ColWidth := Trunc(ClientWidth / FColumns);
    if ColWidth < 1 then ColWidth := 1;
    SendMessage(Handle, LB_SETCOLUMNWIDTH, ColWidth, 0);
  end;
end;

procedure TCustomListBox.SetColumns(Value: Integer);
begin
  if FColumns <> Value then
    if (FColumns = 0) or (Value = 0) then
    begin
      FColumns := Value;
      RecreateWnd;
    end else
    begin
      FColumns := Value;
      if HandleAllocated then SetColumnWidth;
    end;
end;

function TCustomListBox.GetItemIndex: Integer;
begin
  if not MultiSelect then
    Result := SendMessage(Handle, LB_GETCURSEL, 0, 0)
  else
  begin
    Result := SendMessage(Handle, LB_GETCARETINDEX, 0, 0);
    if Result >= Count then
      Result := LB_ERR;
  end;
end;

function TCustomListBox.GetCount: Integer;
begin
  if Style in [lbVirtual, lbVirtualOwnerDraw] then
    Result := FCount
  else
    Result := Items.Count;
end;

function TCustomListBox.GetSelCount: Integer;
begin
  Result := SendMessage(Handle, LB_GETSELCOUNT, 0, 0);
end;

procedure TCustomListBox.SetItemIndex(const Value: Integer);
begin
  if GetItemIndex <> Value then
  begin
    if MultiSelect then
      SendMessage(Handle, LB_SETCARETINDEX, Value, 0)
    else
      SendMessage(Handle, LB_SETCURSEL, Value, 0);
  end;
end;

procedure TCustomListBox.SetExtendedSelect(Value: Boolean);
begin
  if Value <> FExtendedSelect then
  begin
    FExtendedSelect := Value;
    RecreateWnd;
  end;
end;

procedure TCustomListBox.SetIntegralHeight(Value: Boolean);
begin
  if Value <> FIntegralHeight then
  begin
    FIntegralHeight := Value;
    RecreateWnd;
    RequestAlign;
  end;
end;

function TCustomListBox.GetItemHeight: Integer;
var
  R: TRect;
begin
  Result := FItemHeight;
  if HandleAllocated and (FStyle = lbStandard) then
  begin
    R := GetItemRect(0);
    Result := R.Bottom - R.Top;
  end;
end;

function TCustomListBox.GetItemRect(Index: Integer): TRect;
begin
  Perform(LB_GETITEMRECT, Index, Result);
end;

procedure TCustomListBox.SetItemHeight(Value: Integer);
begin
  if (FItemHeight <> Value) and (Value > 0) then
  begin
    FItemHeight := Value;
    RecreateWnd;
  end;
end;

procedure TCustomListBox.SetTabWidth(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if FTabWidth <> Value then
  begin
    FTabWidth := Value;
    RecreateWnd;
  end;
end;

procedure TCustomListBox.SetMultiSelect(Value: Boolean);
begin
  if FMultiSelect <> Value then
  begin
    FMultiSelect := Value;
    RecreateWnd;
  end;
end;

function TCustomListBox.GetSelected(Index: Integer): Boolean;
var
  R: Longint;
begin
  R := SendMessage(Handle, LB_GETSEL, Index, 0);
  if R = LB_ERR then
    raise EListError.CreateResFmt({$IFNDEF CLR}@{$ENDIF}SListIndexError, [Index]);
  Result := LongBool(R);
end;

procedure TCustomListBox.SetSelected(Index: Integer; Value: Boolean);
begin
  if FMultiSelect then
  begin
    if SendMessage(Handle, LB_SETSEL, WPARAM(Value), Index) = LB_ERR then
      raise EListError.CreateResFmt({$IFNDEF CLR}@{$ENDIF}SListIndexError, [Index]);
  end
  else
    if Value then
    begin
      if SendMessage(Handle, LB_SETCURSEL, Index, 0) = LB_ERR then
        raise EListError.CreateResFmt({$IFNDEF CLR}@{$ENDIF}SListIndexError, [Index])
    end
    else
      SendMessage(Handle, LB_SETCURSEL, WPARAM(-1), 0);
end;

procedure TCustomListBox.SetSorted(Value: Boolean);
begin
  if Style in [lbVirtual, lbVirtualOwnerDraw] then exit;
  if FSorted <> Value then
  begin
    FSorted := Value;
    RecreateWnd;
  end;
end;

procedure TCustomListBox.SetStyle(Value: TListBoxStyle);
begin
  if FStyle <> Value then
  begin
    if Value in [lbVirtual, lbVirtualOwnerDraw] then
    begin
      Items.Clear;
      Sorted := False;
    end;
    FStyle := Value;
    RecreateWnd;
  end;
end;

function TCustomListBox.GetTopIndex: Integer;
begin
  Result := SendMessage(Handle, LB_GETTOPINDEX, 0, 0);
end;

procedure TCustomListBox.LBGetText(var Message: TMessage);
var
  S: string;
{$IF DEFINED(CLR)}
  Bytes: TBytes;
{$ENDIF}
begin
  if Style in [lbVirtual, lbVirtualOwnerDraw] then
  begin
    if Assigned(FOnData) and (Message.WParam < WPARAM(Count)) then
    begin
      S := '';
      OnData(Self, Message.wParam, S);
{$IF DEFINED(CLR)}
      Bytes := PlatformBytesOf(S);
      Marshal.Copy(Bytes, 0, IntPtr(Message.lParam), Length(Bytes));
{$ELSE}
      StrCopy(PChar(Message.lParam), PChar(S));
{$ENDIF}
      Message.Result := Length(S);
    end
    else
      Message.Result := LB_ERR;
  end
  else
    inherited;
end;

procedure TCustomListBox.LBGetTextLen(var Message: TMessage);
var
  S: string;
begin
  if Style in [lbVirtual, lbVirtualOwnerDraw] then
  begin
    if Assigned(FOnData) and (Message.WParam < WPARAM(Count)) then
    begin
      S := '';
      OnData(Self, Message.wParam, S);
      Message.Result := Length(S);
    end
    else
      Message.Result := LB_ERR;
  end
  else
    inherited;
end;

procedure TCustomListBox.SetBorderStyle(Value: TBorderStyle);
begin
  if FBorderStyle <> Value then
  begin
    FBorderStyle := Value;
    RecreateWnd;
  end;
end;

procedure TCustomListBox.SetTopIndex(Value: Integer);
begin
  if GetTopIndex <> Value then
    SendMessage(Handle, LB_SETTOPINDEX, Value, 0);
end;

procedure TCustomListBox.SetItems(Value: TStrings);
begin
  if Style in [lbVirtual, lbVirtualOwnerDraw] then
    case Style of
      lbVirtual: Style := lbStandard;
      lbVirtualOwnerDraw: Style := lbOwnerDrawFixed;
    end;
  Items.Assign(Value);
end;

function TCustomListBox.ItemAtPos(Pos: TPoint; Existing: Boolean): Integer;
var
  Count: Integer;
  ItemRect: TRect;
begin
  if ClientRect.Contains(Pos) then
  begin
    Result := TopIndex;
    Count := Items.Count;
    while Result < Count do
    begin
      ItemRect := GetItemRect(Result);
      if ItemRect.Contains(Pos) then Exit;
      Inc(Result);
    end;
    if not Existing then Exit;
  end;
  Result := -1;
end;

function TCustomListBox.ItemRect(Index: Integer): TRect;
var
  Count: Integer;
begin
  Count := Items.Count;
  if (Index = 0) or (Index < Count) then
    Result := GetItemRect(Index)
  else if Index = Count then
  begin
    Result := GetItemRect(Index - 1);
    OffsetRect(Result, 0, Result.Bottom - Result.Top);
  end
  else
    Result := TRect.Empty;
end;

procedure TCustomListBox.CreateParams(var Params: TCreateParams);
const
  Styles: array[TListBoxStyle] of DWORD =
    (0, LBS_OWNERDRAWFIXED, LBS_OWNERDRAWVARIABLE, LBS_OWNERDRAWFIXED,
     LBS_OWNERDRAWFIXED);
  Sorteds: array[Boolean] of DWORD = (0, LBS_SORT);
  MultiSelects: array[Boolean] of DWORD = (0, LBS_MULTIPLESEL);
  ExtendSelects: array[Boolean] of DWORD = (0, LBS_EXTENDEDSEL);
  IntegralHeights: array[Boolean] of DWORD = (LBS_NOINTEGRALHEIGHT, 0);
  MultiColumns: array[Boolean] of DWORD = (0, LBS_MULTICOLUMN);
  TabStops: array[Boolean] of DWORD = (0, LBS_USETABSTOPS);
  CSHREDRAW: array[Boolean] of DWORD = (CS_HREDRAW, 0);
  Data: array[Boolean] of DWORD = (LBS_HASSTRINGS, LBS_NODATA);
var
  Select: DWORD;
begin
  inherited CreateParams(Params);
  CreateSubClass(Params, 'LISTBOX');
  with Params do
  begin
    if FExtendedSelect then
      Select := ExtendSelects[FMultiSelect]
    else
      Select := MultiSelects[FMultiSelect];
    Style := Style or (WS_HSCROLL or WS_VSCROLL or
      Data[Self.Style in [lbVirtual, lbVirtualOwnerDraw]] or
      LBS_NOTIFY) or Styles[FStyle] or Sorteds[FSorted] or
      Select or IntegralHeights[FIntegralHeight] or
      MultiColumns[FColumns <> 0] or BorderStyles[FBorderStyle] or
      TabStops[FTabWidth <> 0];
    if NewStyleControls and Ctl3D and (FBorderStyle = bsSingle) then
    begin
      Style := Style and not WS_BORDER;
      ExStyle := ExStyle or WS_EX_CLIENTEDGE;
    end;
    WindowClass.style := WindowClass.style and not (CSHREDRAW[UseRightToLeftAlignment] or CS_VREDRAW);
  end;
end;

{$IF DEFINED(CLR)}
[SuppressUnmanagedCodeSecurity, DllImport(user32, CharSet = CharSet.Auto, SetLastError = False, EntryPoint = 'SendMessage')]
function SendSetTabStopsMessage(Handle: HWND; Msg: UINT; WParam: WPARAM;
  [in] var LParam: Integer): LRESULT; external;
{$ENDIF}

[UIPermission(SecurityAction.LinkDemand, Window=UIPermissionWindow.AllWindows)]
procedure TCustomListBox.CreateWnd;
var
  W, H, I: Integer;
begin
  W := Width;
  H := Height;
  inherited CreateWnd;
  SetWindowPos(Handle, 0, Left, Top, W, H, SWP_NOZORDER or SWP_NOACTIVATE);
  if FTabWidth <> 0 then
{$IF NOT DEFINED(CLR)}
    SendMessage(Handle, LB_SETTABSTOPS, 1, LPARAM(@FTabWidth));
{$ELSE}
    SendSetTabStopsMessage(Handle, LB_SETTABSTOPS, 1, FTabWidth);
{$ENDIF}
  SetColumnWidth;
  if FSaveScrollWidth <> 0 then
    ScrollWidth := FSaveScrollWidth;
  if (FOldCount <> -1) or Assigned(FSaveItems) then
  begin
    if (Style in [lbVirtual, lbVirtualOwnerDraw]) then
      Count := FOldCount;
    if FSaveItems <> nil then
    begin
      LoadRecreateItems(FSaveItems);
      FreeAndNil(FSaveItems);
    end;
    SetTopIndex(FSaveTopIndex);
    SetItemIndex(FSaveItemIndex);
    if FMultiSelect and (Length(FSaveSelection) = FItems.Count) then
      for I := 0 to FItems.Count -1 do
        Selected[I] := FSaveSelection[I];
    SetLength(FSaveSelection, 0);
    FOldCount := -1;
  end;
end;

procedure TCustomListBox.DestroyWnd;
var
  I: Integer;
begin
  if (csRecreating in ControlState) then
  begin
    FSaveScrollWidth := ScrollWidth;
    if (FItems.Count > 0) then
    begin
      if (Style in [lbVirtual, lbVirtualOwnerDraw]) then
        FOldCount := FItems.Count
      else
      begin
        FSaveItems := TStringList.Create;
        SaveRecreateItems(FSaveItems);
        if FMultiSelect then
        begin
          SetLength(FSaveSelection, FItems.Count);
          for I := 0 to FItems.Count - 1 do
            FSaveSelection[I] := Selected[I];
        end;
      end;
      FSaveTopIndex := GetTopIndex;
      FSaveItemIndex := GetItemIndex;
    end;
  end;
  inherited DestroyWnd;
end;

procedure TCustomListBox.WndProc(var Message: TMessage);
var
  DC: HDC;
{$IF DEFINED(CLR)}
  MouseMsg: TWMMouse;
{$ENDIF}
begin
  {for auto drag mode, let listbox handle itself, instead of TControl}
  if not (csDesigning in ComponentState) and ((Message.Msg = WM_LBUTTONDOWN) or
    (Message.Msg = WM_LBUTTONDBLCLK)) and not Dragging then
  begin
    if DragMode = dmAutomatic then
    begin
{$IF DEFINED(CLR)}
      MouseMsg := TWMMouse.Create(Message);
      if IsControlMouseMsg(MouseMsg) then
{$ELSE}
      if IsControlMouseMsg(TWMMouse(Message)) then
{$ENDIF}
        Exit;
      ControlState := ControlState + [csLButtonDown];
      Dispatch(Message);  {overrides TControl's BeginDrag}
      Exit;
    end;
  end;

  case Message.Msg of
    CM_COLORCHANGED:
      if HandleAllocated then
        InvalidateRect(Handle, nil, True);
    CN_CTLCOLORLISTBOX:
      if (csGlassPaint in ControlState) and not FInBufferedPrintClient then
      begin
        FInBufferedPrintClient := True;
        PostMessage(Handle, CM_BUFFEREDPRINTCLIENT, 0, 0);
      end;
    CM_BUFFEREDPRINTCLIENT:
      if FInBufferedPrintClient then
      begin
        PerformBufferedPrintClient(Handle, ClientRect);
        FInBufferedPrintClient := False;
      end;
    WM_HSCROLL:
      begin
        inherited;
        // Need to force a repaint when DoubleBuffered
        if DoubleBuffered and
           ((Message.WParamLo and SB_THUMBTRACK = SB_THUMBTRACK) or
           (Message.WParamLo and SB_LINELEFT = SB_LINELEFT) or
           (Message.WParamLo and SB_LINERIGHT = SB_LINERIGHT)) then
        begin
          DC := GetDC(Handle);
          try
            PaintWindow(DC);
          finally
            ReleaseDC(Handle, DC);
          end;
        end;
        Exit;
      end;
  end;
  inherited WndProc(Message);
end;

procedure TCustomListBox.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  if DoubleBuffered then
    DefaultHandler(Message)
  else
    inherited;
end;

procedure TCustomListBox.WMLButtonDown(var Message: TWMLButtonDown);
var
  ItemNo : Integer;
  ShiftState: TShiftState;
begin
  if Observers.IsObserving(TObserverMapping.EditLinkID) and (not TLinkObservers.EditLinkEdit(Observers)) then
  begin
    SetFocus;
    with Message do
      MouseDown(mbLeft, KeysToShiftState(Keys), XPos, YPos);
  end
  else
  begin
    ShiftState := KeysToShiftState(Message.Keys);
    if (DragMode = dmAutomatic) and FMultiSelect then
    begin
      if not (ssShift in ShiftState) or (ssCtrl in ShiftState) then
      begin
        ItemNo := ItemAtPos(SmallPointToPoint(Message.Pos), True);
        if (ItemNo >= 0) and (Selected[ItemNo]) then
        begin
          BeginDrag (False);
          Exit;
        end;
      end;
    end;
    inherited;
    if (DragMode = dmAutomatic) and not (FMultiSelect and
      ((ssCtrl in ShiftState) or (ssShift in ShiftState))) then
      BeginDrag(False);
  end;
end;

procedure TCustomListBox.CNCommand(var Message: TWMCommand);
begin
  case Message.NotifyCode of
    LBN_SELCHANGE:
      begin
        inherited Changed;
        Click;
        TLinkObservers.ListSelectionChanged(Observers);
      end;
    LBN_DBLCLK: DblClick;
  end;
end;

procedure TCustomListBox.WMPaint(var Message: TWMPaint);

  procedure PaintListBox;
  var
    DrawItemMsg: TWMDrawItem;
    MeasureItemMsg: TWMMeasureItem;
    DrawItemStruct: TDrawItemStruct;
    MeasureItemStruct: TMeasureItemStruct;
    R: TRect;
    Y, I, H, W: Integer;
{$IF DEFINED(CLR)}
    LMessage: TMessage;
    LMeasureItemBuf: IntPtr;
    LDrawItemBuf: IntPtr;
{$ENDIF}
  begin
    if Items.Count = 0 then
    begin
      { Just fill it in with the color }
      with TBrush.Create do
      try
        Color := Self.Color;
        FillRect(Message.DC, ClientRect, Handle);
      finally
        Free;
      end;
      Exit;
    end;

{$IF DEFINED(CLR)}
    DrawItemMsg := TWMDrawItem.Create;
    MeasureItemMsg := TWMMeasureItem.Create;
    LDrawItemBuf := Marshal.AllocHGlobal(Marshal.SizeOf(TypeOf(TDrawItemStruct)));
    LMeasureItemBuf := Marshal.AllocHGlobal(Marshal.SizeOf(TypeOf(TMeasureItemStruct)));
{$ENDIF}
    try
{$IF DEFINED(CLR)}
      DrawItemMsg.OriginalMessage.LParam := THandle(LDrawItemBuf);
      MeasureItemMsg.OriginalMessage.LParam := THandle(LMeasureItemBuf);
{$ELSE}
      DrawItemMsg.DrawItemStruct := @DrawItemStruct;
      MeasureItemMsg.MeasureItemStruct := @MeasureItemStruct;
{$ENDIF}
      { Initialize drawing records }
      DrawItemMsg.Msg := CN_DRAWITEM;
      DrawItemMsg.Ctl := Handle;
      DrawItemStruct.CtlType := ODT_LISTBOX;
      DrawItemStruct.itemAction := ODA_DRAWENTIRE;
      DrawItemStruct.itemState := 0;
      DrawItemStruct.hDC := Message.DC;
      DrawItemStruct.CtlID := Handle;
      DrawItemStruct.hwndItem := Handle;

      { Intialize measure records }
      MeasureItemMsg.Msg := CN_MEASUREITEM;
      MeasureItemMsg.IDCtl := Handle;
      MeasureItemStruct.CtlType := ODT_LISTBOX;
      MeasureItemStruct.CtlID := Handle;

      { Draw the listbox }
      Y := 0;
      I := TopIndex;
      GetClipBox(Message.DC, R);
      H := Height;
      W := Width;
      while Y < H do
      begin
        MeasureItemStruct.itemID := I;
        if I < Items.Count then
{$IF NOT DEFINED(CLR)}
          MeasureItemStruct.itemData := UIntPtr(Pointer(Items.Objects[I]));
{$ELSE}
          if Items.Objects[I] <> nil then
            MeasureItemStruct.itemData := I;
{$ENDIF}
        MeasureItemStruct.itemWidth := W;
        MeasureItemStruct.itemHeight := FItemHeight;
        DrawItemStruct.itemData := MeasureItemStruct.itemData;
        DrawItemStruct.itemID := I;
{$IF DEFINED(CLR)}
        Marshal.StructureToPtr(TObject(MeasureItemStruct), LMeasureItemBuf, False);
        LMessage := MeasureItemMsg.OriginalMessage;
        Dispatch(LMessage);
        MeasureItemStruct := TMeasureItemStruct(Marshal.PtrToStructure(LMessage.LParam,
          TypeOf(TMeasureItemStruct)));
{$ELSE}
        Dispatch(MeasureItemMsg);
{$ENDIF}
        DrawItemStruct.rcItem := Rect(0, Y, MeasureItemStruct.itemWidth,
          Y + Integer(MeasureItemStruct.itemHeight));
{$IF DEFINED(CLR)}
        Marshal.StructureToPtr(TObject(DrawItemStruct), LDrawItemBuf, False);
        LMessage := DrawItemMsg.OriginalMessage;
        Dispatch(LMessage);
{$ELSE}
        Dispatch(DrawItemMsg);
{$ENDIF}
        Inc(Y, MeasureItemStruct.itemHeight);
        Inc(I);
        if I >= Items.Count then
          Break;
      end;
    finally
{$IF DEFINED(CLR)}
      if Assigned(DrawItemMsg) and (LDrawItemBuf.ToInt64 <> 0) then
        Marshal.FreeHGlobal(LDrawItemBuf);
      if Assigned(MeasureItemMsg) and (LMeasureItemBuf.ToInt64 <> 0) then
        Marshal.FreeHGlobal(LMeasureItemBuf);
{$ENDIF}
    end;
  end;

begin
  if Message.DC <> 0 then
    { Listboxes don't allow paint "sub-classing" like the other windows controls
      so we have to do it ourselves. }
    PaintListBox
  else
    inherited;
end;

procedure TCustomListBox.WMSize(var Message: TWMSize);
begin
  inherited;
  SetColumnWidth;
end;

procedure TCustomListBox.DragCanceled;
var
  M: TWMMouse;
  MousePos: TPoint;
begin
{$IF DEFINED(CLR)}
  M := TWMMouse.Create;
{$ENDIF}
  with M do
  begin
    Msg := WM_LBUTTONDOWN;
    GetCursorPos(MousePos);
    Pos := PointToSmallPoint(ScreenToClient(MousePos));
    Keys := 0;
    Result := 0;
  end;
  DefaultHandler(M);
  M.Msg := WM_LBUTTONUP;
  DefaultHandler(M);
end;

procedure TCustomListBox.DrawItem(Index: Integer; Rect: TRect;
  State: TOwnerDrawState);
var
  Flags: Longint;
  Data: String;
begin
  if Assigned(FOnDrawItem) then FOnDrawItem(Self, Index, Rect, State) else
  begin
    FCanvas.FillRect(Rect);
    if Index < Count then
    begin
      Flags := DrawTextBiDiModeFlags(DT_SINGLELINE or DT_VCENTER or DT_NOPREFIX);
      if not UseRightToLeftAlignment then
        Inc(Rect.Left, 2)
      else
        Dec(Rect.Right, 2);
      Data := '';
      if (Style in [lbVirtual, lbVirtualOwnerDraw]) then
        Data := DoGetData(Index)
      else
        Data := Items[Index];
      DrawText(FCanvas.Handle, Data, Length(Data), Rect, Flags);
    end;
  end;
end;

procedure TCustomListBox.MeasureItem(Index: Integer; var Height: Integer);
begin
  if Assigned(FOnMeasureItem) then FOnMeasureItem(Self, Index, Height)
end;

function TCustomListBox.CanObserve(const ID: Integer): Boolean;
begin
  Result := False;
  if ID = TObserverMapping.EditLinkID then
    Result := True
  else if ID = TObserverMapping.PositionLinkID then
    Result := True
  else if ID = TObserverMapping.ControlValueID then
    Result := True;
end;

procedure TCustomListBox.CNDrawItem(var Message: TWMDrawItem);
var
  State: TOwnerDrawState;
begin
  with Message.DrawItemStruct{$IFNDEF CLR}^{$ENDIF} do
  begin
    State := TOwnerDrawState(LoWord(itemState));
    FCanvas.Handle := hDC;
    FCanvas.Font := Font;
    FCanvas.Brush := Brush;
    if TStyleManager.IsCustomStyleActive and (seClient in StyleElements) then
    begin
      if (Integer(itemID) >= 0) and (odSelected in State) then
      begin
        FCanvas.Brush.Color := StyleServices.GetSystemColor(clHighlight);
        FCanvas.Font.Color := StyleServices.GetStyleFontColor(sfListItemTextSelected);
      end
      else
      begin
        FCanvas.Brush.Color := StyleServices.GetStyleColor(scListBox);
        if seFont in StyleElements then
          FCanvas.Font.Color := StyleServices.GetStyleFontColor(sfListItemTextNormal);
      end;
    end
    else
    begin
      if (Integer(itemID) >= 0) and (odSelected in State) then
      begin
        FCanvas.Brush.Color := clHighlight;
        FCanvas.Font.Color := clHighlightText
      end;
    end;
    if Integer(itemID) >= 0 then
      DrawItem(itemID, rcItem, State)
    else
      FCanvas.FillRect(rcItem);
    if (odFocused in State) and not TStyleManager.IsCustomStyleActive then
      DrawFocusRect(hDC, rcItem);
    FCanvas.Handle := 0;
  end;
end;

procedure TCustomListBox.CNMeasureItem(var Message: TWMMeasureItem);
var
  Height: Integer;
{$IF DEFINED(CLR)}
  MeasureItemStruct: TMeasureItemStruct;
{$ELSE}
  MeasureItemStruct: PMeasureItemStruct;
{$ENDIF}
begin
  MeasureItemStruct := Message.MeasureItemStruct;
  with MeasureItemStruct{$IFNDEF CLR}^{$ENDIF} do
  begin
    itemHeight := FItemHeight;
    if FStyle = lbOwnerDrawVariable then
    begin
      Height := itemHeight;
      MeasureItem(itemID, Height);
      itemHeight := Height;
    end;
  end;
{$IF DEFINED(CLR)}
  Message.MeasureItemStruct := MeasureItemStruct;
{$ENDIF}
end;

procedure TCustomListBox.CMCtl3DChanged(var Message: TMessage);
begin
  if NewStyleControls and (FBorderStyle = bsSingle) then RecreateWnd;
  inherited;
end;

procedure TCustomListBox.CMExit(var Message: TCMExit);
begin
  try
    if Observers.IsObserving(TObserverMapping.EditLinkID) then
      TLinkObservers.EditLinkUpdate(Observers);
    if Observers.IsObserving(TObserverMapping.ControlValueID) then
      TLinkObservers.ControlValueUpdate(Observers);
  except
    SetFocus;
    raise;
  end;
  inherited;
end;

procedure TCustomListBox.SelectAll;
var
  I: Integer;
begin
  if FMultiSelect then
    for I := 0 to Items.Count - 1 do
      Selected[I] := True;
end;

procedure TCustomListBox.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  if Observers.IsObserving(TObserverMapping.EditLinkID) then
    TLinkObservers.EditLinkEdit(Observers);
  inherited;
end;

procedure TCustomListBox.KeyDown(var Key: Word; Shift: TShiftState);
var
  LEditLink: Boolean;
begin
  inherited;
  LEditLink := Observers.IsObserving(TObserverMapping.EditLinkID);
  if Key in [VK_PRIOR, VK_NEXT, VK_END, VK_HOME, VK_LEFT, VK_UP,
    VK_RIGHT, VK_DOWN] then
  begin
    if LEditLink and not TLinkObservers.EditLinkEdit(Observers) then
      Key := 0;
  end;

end;

procedure TCustomListBox.KeyPress(var Key: Char);

  procedure FindString;
  var
    Idx: Integer;
  begin
    if Style in [lbVirtual, lbVirtualOwnerDraw] then
      Idx := DoFindData(FFilter)
    else
      Idx := SendTextMessage(Handle, LB_FINDSTRING, WPARAM(-1), FFilter);
    if Idx <> LB_ERR then
    begin
      if MultiSelect then
      begin
        ClearSelection;
        SendMessage(Handle, LB_SELITEMRANGE, 1, MakeLParam(Idx, Idx))
      end;
      ItemIndex := Idx;
      Click;
    end;
    if not ((Ord(Key) in [VK_RETURN, VK_BACK, VK_ESCAPE])) then
      Key := #0;  // Clear so that the listbox's default search mechanism is disabled
  end;

{$IF NOT DEFINED(CLR)}
var
  Msg: TMsg;
{$ENDIF}
  LItemIndex: Integer;
begin
  LItemIndex := ItemIndex;
  inherited KeyPress(Key);

  if Observers.IsObserving(TObserverMapping.EditLinkID) then
  begin
    case Key of
      #32..High(Char):
        if not TLinkObservers.EditLinkEdit(Observers) then
          Key := #0
        else
          TLinkObservers.EditLinkModified(Observers);
      #27:
        TLinkObservers.EditLinkReset(Observers);
    end;
  end;

  if not FAutoComplete then exit;
  if GetTickCount - FLastTime >= FAutoCompleteDelay then
    FFilter := '';
  FLastTime := GetTickCount;

  if Ord(Key) <> VK_BACK then
  begin
{$IF NOT DEFINED(CLR)}
    if IsLeadChar(Key) then
    begin
      if PeekMessage(Msg, Handle, WM_CHAR, WM_CHAR, PM_REMOVE) then
      begin
        FFilter := FFilter + Key + Chr(Msg.wParam);
        Key := #0;
      end;
    end
    else
{$ENDIF}
      FFilter := FFilter + Key;
  end
  else
  begin
{$IF NOT DEFINED(CLR)}
    while ByteType(FFilter, Length(FFilter)) = mbTrailByte do
      Delete(FFilter, Length(FFilter), 1);
{$ENDIF}
    Delete(FFilter, Length(FFilter), 1);
  end;

  if Length(FFilter) > 0 then
    FindString
  else
  begin
    ItemIndex := 0;
    Click;
  end;

  if LItemIndex <> ItemIndex then
  begin
    TLinkObservers.ListSelectionChanged(Observers);
  end;
end;

procedure TCustomListBox.LoadRecreateItems(RecreateItems: TStrings);
begin
  FItems.Assign(RecreateItems);
end;

procedure TCustomListBox.SetCount(const Value: Integer);
var
  Error: Integer;
begin
  if Style in [lbVirtual, lbVirtualOwnerDraw] then
  begin
    // Limited to 32767 on Win95/98 as per Win32 SDK
    Error := SendMessage(Handle, LB_SETCOUNT, Value, 0);
    if (Error <> LB_ERR) and (Error <> LB_ERRSPACE) then
      FCount := Value
    else
      raise Exception.CreateFmt(SErrorSettingCount, [Name]);
  end
  else
    raise Exception.CreateFmt(SListBoxMustBeVirtual, [Name]);
end;

function TCustomListBox.DoGetData(const Index: Integer): String;
begin
  if Assigned(FOnData) then FOnData(Self, Index, Result);
end;

function TCustomListBox.DoGetDataObject(const Index: Integer): TObject;
begin
  Result := nil;
  if Assigned(FOnDataObject) then FOnDataObject(Self, Index, Result);
end;

function TCustomListBox.DoFindData(const Data: String): Integer;
begin
  if Assigned(FOnDataFind) then
    Result := FOnDataFind(Self, Data)
  else
    Result := -1;
end;

function TCustomListBox.GetScrollWidth: Integer;
begin
  Result := SendMessage(Handle, LB_GETHORIZONTALEXTENT, 0, 0);
end;

procedure TCustomListBox.SetScrollWidth(const Value: Integer);
begin
  if Value <> ScrollWidth then
    SendMessage(Handle, LB_SETHORIZONTALEXTENT, Value, 0);
end;

{ TScrollBar }

constructor TScrollBar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Width := 121;
  Height := GetSystemMetrics(SM_CYHSCROLL);
  TabStop := True;
  ControlStyle := [csFramed, csDoubleClicks, csOpaque];
  FKind := sbHorizontal;
  FPosition := 0;
  FMin := 0;
  FMax := 100;
  FSmallChange := 1;
  FLargeChange := 1;
  if SysLocale.FarEast and (Win32Platform = VER_PLATFORM_WIN32_NT) then
    ImeMode := imDisable;
end;

class constructor TScrollBar.Create;
begin
  TCustomStyleEngine.RegisterStyleHook(TScrollBar, TScrollBarStyleHook);
end;

class destructor TScrollBar.Destroy;
begin
  TCustomStyleEngine.UnRegisterStyleHook(TScrollBar, TScrollBarStyleHook);
end;

procedure TScrollBar.CreateParams(var Params: TCreateParams);
const
  Kinds: array[TScrollBarKind] of DWORD = (SBS_HORZ, SBS_VERT);
begin
  inherited CreateParams(Params);
  CreateSubClass(Params, 'SCROLLBAR');
  Params.Style := Params.Style or Kinds[FKind];
  if FKind = sbVertical then
    if not UseRightToLeftAlignment then
      Params.Style := Params.Style or SBS_RIGHTALIGN
    else
      Params.Style := Params.Style or SBS_LEFTALIGN;
  if NotRightToLeft then
    FRTLFactor := 1
  else
    FRTLFactor := -1;
end;

[UIPermission(SecurityAction.LinkDemand, Window=UIPermissionWindow.AllWindows)]
procedure TScrollBar.CreateWnd;
var
  ScrollInfo: TScrollInfo;
  LBounds: TRect;
begin
  // Windows' does not always create the window size we ask for, so we have
  //  insist sometimes.  Setting BoundsRect will only adjust the size if needed.
  LBounds := BoundsRect;
  inherited CreateWnd;
  BoundsRect := LBounds;

  SetScrollRange(Handle, SB_CTL, FMin, FMax, False);
{$IF DEFINED(CLR)}
  ScrollInfo.cbSize := Marshal.SizeOf(TypeOf(ScrollInfo));
{$ELSE}
  ScrollInfo.cbSize := SizeOf(ScrollInfo);
{$ENDIF}
  ScrollInfo.nPage := FPageSize;
  ScrollInfo.fMask := SIF_PAGE;
  SetScrollInfo(Handle, SB_CTL, ScrollInfo, False);
  if NotRightToLeft then
    SetScrollPos(Handle, SB_CTL, FPosition, True)
  else
    SetScrollPos(Handle, SB_CTL, FMax - FPosition, True);
end;

function TScrollBar.NotRightToLeft: Boolean;
begin
  Result := (not IsRightToLeft) or (FKind = sbVertical);
end;

procedure TScrollBar.SetKind(Value: TScrollBarKind);
begin
  if FKind <> Value then
  begin
    FKind := Value;
    if not (csLoading in ComponentState) then
      SetBounds(Left, Top, Height, Width);
    RecreateWnd;
  end;
end;

procedure TScrollBar.SetParams(APosition, AMin, AMax: Integer);
begin
  if (AMax < AMin) or (AMax < FPageSize) then
    raise EInvalidOperation.Create(SScrollBarRange);
  if APosition < AMin then APosition := AMin;
  if APosition > AMax then APosition := AMax;
  if (FMin <> AMin) or (FMax <> AMax) then
  begin
    FMin := AMin;
    FMax := AMax;
    if HandleAllocated then
      SetScrollRange(Handle, SB_CTL, AMin, AMax, FPosition = APosition);
  end;
  if FPosition <> APosition then
  begin
    FPosition := APosition;
    if HandleAllocated then
    begin
      if sfHandleMessages in StyleServices.Flags then
      begin
        if NotRightToLeft then
          SetScrollPos(Handle, SB_CTL, FPosition, False)
        else
          SetScrollPos(Handle, SB_CTL, FMax - FPosition, False);
        RedrawWindow(Handle, nil, 0, RDW_INVALIDATE or RDW_UPDATENOW);
      end
      else
        begin
          if NotRightToLeft then
            SetScrollPos(Handle, SB_CTL, FPosition, True)
          else
            SetScrollPos(Handle, SB_CTL, FMax - FPosition, True);
        end;
    end;
    Enabled := True;
    Change;
  end;
end;

procedure TScrollBar.SetPosition(Value: Integer);
begin
  SetParams(Value, FMin, FMax);
end;

procedure TScrollBar.SetPageSize(Value: Integer);
var
  ScrollInfo: TScrollInfo;
begin
  if (FPageSize = Value) or (Value > FMax) then exit;
  FPageSize := Value;
{$IF DEFINED(CLR)}
  ScrollInfo.cbSize := Marshal.SizeOf(TypeOf(ScrollInfo));
{$ELSE}
  ScrollInfo.cbSize := SizeOf(ScrollInfo);
{$ENDIF}
  ScrollInfo.nPage := Value;
  ScrollInfo.fMask := SIF_PAGE;
  if HandleAllocated then
   if sfHandleMessages in StyleServices.Flags then
   begin
     SetScrollInfo(Handle, SB_CTL, ScrollInfo, False);
     RedrawWindow(Handle, nil, 0, RDW_INVALIDATE or RDW_UPDATENOW);
   end
    else
      SetScrollInfo(Handle, SB_CTL, ScrollInfo, True);
end;

procedure TScrollBar.SetMin(Value: Integer);
begin
  SetParams(FPosition, Value, FMax);
end;

procedure TScrollBar.SetMax(Value: Integer);
begin
  SetParams(FPosition, FMin, Value);
end;

function TScrollBar.CanObserve(const ID: Integer): Boolean;
begin
  Result := False;
  if ID = TObserverMapping.PositionLinkID then
    Result := True
  else if ID = TObserverMapping.ControlValueID then
    Result := True;
end;

procedure TScrollBar.Change;
begin
  inherited Changed;
  if Assigned(FOnChange) then FOnChange(Self);
end;

procedure TScrollBar.Scroll(ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
  if Assigned(FOnScroll) then FOnScroll(Self, ScrollCode, ScrollPos);
end;

procedure TScrollBar.DoScroll(var Message: TWMScroll);
var
  ScrollPos: Integer;
  NewPos: Longint;
  ScrollInfo: TScrollInfo;
begin
  with Message do
  begin
    NewPos := FPosition;
    case TScrollCode(ScrollCode) of
      scLineUp:
        Dec(NewPos, FSmallChange * FRTLFactor);
      scLineDown:
        Inc(NewPos, FSmallChange * FRTLFactor);
      scPageUp:
        Dec(NewPos, FLargeChange * FRTLFactor);
      scPageDown:
        Inc(NewPos, FLargeChange * FRTLFactor);
      scPosition, scTrack:
        with ScrollInfo do
        begin
{$IF DEFINED(CLR)}
          cbSize := Marshal.SizeOf(TypeOf(ScrollInfo));
{$ELSE}
          cbSize := SizeOf(ScrollInfo);
{$ENDIF}
          fMask := SIF_ALL;
          GetScrollInfo(Handle, SB_CTL, ScrollInfo);
          NewPos := nTrackPos;
          { We need to reverse the positioning because SetPosition below
            calls SetParams that reverses the position. This acts as a
            double negative. }
          if not NotRightToLeft then NewPos := FMax - NewPos;
        end;
      scTop:
        NewPos := FMin;
      scBottom:
        NewPos := FMax;
    end;
    if NewPos < FMin then NewPos := FMin;
    if NewPos > FMax then NewPos := FMax;
    ScrollPos := NewPos;
    Scroll(TScrollCode(ScrollCode), ScrollPos);
    SetPosition(ScrollPos);
  end;
end;

procedure TScrollBar.CNHScroll(var Message: TWMHScroll);
begin
  DoScroll(Message);
  if Observers.IsObserving(TObserverMapping.PositionLinkID) then
    TLinkObservers.PositionLinkPosChanged(Observers);
  if Observers.IsObserving(TObserverMapping.ControlValueID) then
  begin
    TLinkObservers.ControlValueModified(Observers);
    TLinkObservers.ControlValueUpdate(Observers);
  end;
end;

procedure TScrollBar.CNVScroll(var Message: TWMVScroll);
begin
  DoScroll(Message);
  if Observers.IsObserving(TObserverMapping.PositionLinkID) then
    TLinkObservers.PositionLinkPosChanged(Observers);
  if Observers.IsObserving(TObserverMapping.ControlValueID) then
  begin
    TLinkObservers.ControlValueModified(Observers);
    TLinkObservers.ControlValueUpdate(Observers);
  end;
end;

procedure TScrollBar.CNCtlColorScrollBar(var Message: TMessage);
begin
  with Message do
    CallWindowProc(DefWndProc, Handle, Msg, WParam, LParam);
end;

procedure TScrollBar.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  DefaultHandler(Message);
end;

{ TCustomStaticText }

class constructor TCustomStaticText.Create;
begin
  TCustomStyleEngine.RegisterStyleHook(TCustomStaticText, TStaticTextStyleHook);
end;

constructor TCustomStaticText.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := [csCaptureMouse, csClickEvents, csSetCaption,
    csReplicatable, csDoubleClicks, csGestures];
  Width := 65;
  Height := 17;
  FAutoSize := True;
  FShowAccelChar := True;
  AdjustBounds;
end;

class destructor TCustomStaticText.Destroy;
begin
  TCustomStyleEngine.UnRegisterStyleHook(TCustomStaticText, TStaticTextStyleHook);
end;

procedure TCustomStaticText.CreateParams(var Params: TCreateParams);
const
  Alignments: array[Boolean, TAlignment] of DWORD =
    ((SS_LEFT, SS_RIGHT, SS_CENTER), (SS_RIGHT, SS_LEFT, SS_CENTER));
  Borders: array[TStaticBorderStyle] of DWORD = (0, WS_BORDER, SS_SUNKEN);
begin
  inherited CreateParams(Params);
  CreateSubClass(Params, 'STATIC');
  with Params do
  begin
    Style := Style or SS_NOTIFY or
      Alignments[UseRightToLeftAlignment, FAlignment] or Borders[FBorderStyle];
    if not FShowAccelChar then Style := Style or SS_NOPREFIX;
    WindowClass.style := WindowClass.style and not CS_VREDRAW;
  end;
end;

procedure TCustomStaticText.CMDialogChar(var Message: TCMDialogChar);
begin
  if (FFocusControl <> nil) and Enabled and ShowAccelChar and
    IsAccel(Message.CharCode, Caption) then
    with FFocusControl do
      if CanFocus then
      begin
        SetFocus;
        Message.Result := 1;
      end;
end;

procedure TCustomStaticText.CMFontChanged(var Message: TMessage);
begin
  inherited;
  AdjustBounds;
end;

procedure TCustomStaticText.CMTextChanged(var Message: TMessage);
begin
  inherited;
  AdjustBounds;
  Invalidate;
end;

procedure TCustomStaticText.Loaded;
begin
  inherited Loaded;
  AdjustBounds;
end;

procedure TCustomStaticText.AdjustBounds;
var
  DC: HDC;
  TextSize: TSize;
  SaveFont: HFONT;
begin
  if not (csReading in ComponentState) and FAutoSize then
  begin
    DC := GetDC(0);
    try
      SaveFont := SelectObject(DC, Font.Handle);
      GetTextExtentPoint32(DC, Caption, Length(Caption), TextSize);
      SelectObject(DC, SaveFont);
    finally
      ReleaseDC(0, DC);
    end;
    SetBounds(Left, Top,
      TextSize.cx + (GetSystemMetrics(SM_CXBORDER) * 4),
      TextSize.cy + (GetSystemMetrics(SM_CYBORDER) * 4));
  end;
end;

procedure TCustomStaticText.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FFocusControl) then
    FFocusControl := nil;
end;

procedure TCustomStaticText.SetAlignment(Value: TAlignment);
begin
  if FAlignment <> Value then
  begin
    FAlignment := Value;
    RecreateWnd;
  end;
end;

procedure TCustomStaticText.SetAutoSize(Value: Boolean);
begin
  if FAutoSize <> Value then
  begin
    FAutoSize := Value;
    if Value then AdjustBounds;
  end;
end;

procedure TCustomStaticText.SetBorderStyle(Value: TStaticBorderStyle);
begin
  if FBorderStyle <> Value then
  begin
    FBorderStyle := Value;
    RecreateWnd;
  end;
end;

procedure TCustomStaticText.SetFocusControl(Value: TWinControl);
begin
  FFocusControl := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

procedure TCustomStaticText.SetShowAccelChar(Value: Boolean);
begin
  if FShowAccelChar <> Value then
  begin
    FShowAccelChar := Value;
    RecreateWnd;
  end;
end;

procedure TCustomStaticText.CNCtlColorStatic(var Message: TWMCtlColorStatic);
begin
  if StyleServices.Enabled and Transparent then
  begin
    SetBkMode(Message.ChildDC, Winapi.Windows.TRANSPARENT);
    StyleServices.DrawParentBackground(Handle, Message.ChildDC, nil, False);
    { Return an empty brush to prevent Windows from overpainting what we just have created. }
    Message.Result := GetStockObject(NULL_BRUSH);
  end
  else
    inherited;
end;

procedure TCustomStaticText.SetTransparent(const Value: Boolean);
begin
  if Transparent <> Value then
  begin
    if Value then
      ControlStyle := ControlStyle - [csOpaque]
    else
      ControlStyle := ControlStyle + [csOpaque];
    Invalidate;
  end;
end;

function TCustomStaticText.GetTransparent: Boolean;
begin
  Result := not (csOpaque in ControlStyle);
end;

{ TScrollBarStyleHook.TScrollWindow }

constructor TScrollBarStyleHook.TScrollWindow.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := ControlStyle + [csOverrideStylePaint];
end;

procedure TScrollBarStyleHook.TScrollWindow.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style or WS_CHILDWINDOW or WS_CLIPCHILDREN or WS_CLIPSIBLINGS;
  Params.ExStyle := Params.ExStyle or WS_EX_NOPARENTNOTIFY;
end;

procedure TScrollBarStyleHook.TScrollWindow.WMNCHitTest(var Message: TWMNCHitTest);
begin
  if not FSizeBox then
    Message.Result := HTTRANSPARENT;
end;

procedure TScrollBarStyleHook.TScrollWindow.WMEraseBkgnd(var Message: TMessage);
begin
  Message.Result := 1;
end;

procedure TScrollBarStyleHook.TScrollWindow.WMPaint(var Message: TWMPaint);
var
  DC: HDC;
  PS: TPaintStruct;
  Canvas: TCanvas;
begin
  BeginPaint(Handle, PS);
  try
    if FStyleHook <> nil then
    begin
      DC := GetWindowDC(Handle);
      try
        if FVertical then
          FStyleHook.VertDrawScroll(DC)
        else
          FStyleHook.HorzDrawScroll(DC);
      finally
        ReleaseDC(Handle, DC);
      end;
    end
    else if FSizeBox then
    begin
      Canvas := TCanvas.Create;
      try
        Canvas.Handle := GetWindowDC(Handle);
        if StyleServices.Enabled then
          with Canvas do
          begin
            Brush.Style := bsSolid;
            Brush.Color := StyleServices.ColorToRGB(clBtnFace);
            FillRect(Rect(0, 0, Width, Height));
          end;
      finally
        ReleaseDC(Handle, Canvas.Handle);
        Canvas.Handle := 0;
        Canvas.Free;
      end;
    end;
  finally
    EndPaint(Handle, PS);
  end;
end;

procedure TScrollBarStyleHook.TScrollWindow.WndProc(var Message: TMessage);
begin
  // Reserved for potential updates
  inherited;
end;

{ TScrollBarStyleHook }

constructor TScrollBarStyleHook.Create;
begin
  inherited;
  FScrollWnd := nil;
  FVSliderState := tsThumbBtnVertNormal;
  FVUpState := tsArrowBtnUpNormal;
  FVDownState := tsArrowBtnDownNormal;
  FHSliderState := tsThumbBtnHorzNormal;
  FHUpState := tsArrowBtnLeftNormal;
  FHDownState := tsArrowBtnRightNormal;
end;

destructor TScrollBarStyleHook.Destroy;
begin
  if FScrollWnd <> nil then
  begin
    FScrollWnd.StyleHook := nil;
    FreeAndNil(FScrollWnd);
  end;
  inherited;
end;

function TScrollBarStyleHook.AcceptMessage(var Message: TMessage): Boolean;
begin
  Result := seClient in Control.StyleElements;
end;

function TScrollBarStyleHook.HasBorder: Boolean;
begin
  Result := False;
  if (Control is TScrollBar) and TScrollBar(Control).Ctl3D then
    Result := True;
end;

function TScrollBarStyleHook.ControlBounds: TRect;
var
  R: TRect;
begin
  R := Control.BoundsRect;
  if HasBorder then InflateRect(R, 1, 1);
  Result := R;
end;

procedure TScrollBarStyleHook.CMVisibleChanged(var Message: TMessage);
begin
  if (FScrollWnd <> nil) and FScrollWnd.HandleAllocated then
  begin
    if Control.Visible then
      ShowWindow(FScrollWnd.Handle, SW_SHOW)
    else
      ShowWindow(FScrollWnd.Handle, SW_HIDE);
  end;
end;

procedure TScrollBarStyleHook.WMPaint(var Message: TMessage);
begin
  PaintScrollBar;
end;

procedure TScrollBarStyleHook.WMShowWindow(var Message: TWMShowWindow);
begin
  CallDefaultProc(TMessage(Message));
  if (FScrollWnd <> nil) and FScrollWnd.HandleAllocated then
  begin
    if Message.Show then
      ShowWindow(FScrollWnd.Handle, SW_SHOW)
    else
      ShowWindow(FScrollWnd.Handle, SW_HIDE);
  end;
  Handled := True;
end;

procedure TScrollBarStyleHook.WMWindowPosChanged;
begin
  CallDefaultProc(TMessage(Message));
  if IsWindowVisible(Control.Handle) then
    UpdateScrollBar;
  Handled := True;
end;

procedure TScrollBarStyleHook.WndProc(var Message: TMessage);
begin
  // Reserved for potential updates
  inherited;
end;

procedure TScrollBarStyleHook.WMMove(var Message: TMessage);
begin
  CallDefaultProc(TMessage(Message));
  UpdateScrollBar;
  Handled := True;
end;

procedure TScrollBarStyleHook.WMSize(var Message: TMessage);
begin
  CallDefaultProc(TMessage(Message));
  UpdateScrollBar;
  Handled := True;
end;

procedure TScrollBarStyleHook.InitScrollBar;
var
  R: TRect;
begin
  FScrollWnd := TScrollWindow.CreateParented(GetParent(Control.Handle));
  FScrollWnd.StyleHook := Self;
  FScrollWnd.Vertical := not Horizontal;
  FScrollWnd.SizeBox := False;
  R := ControlBounds;
  SetWindowPos(FScrollWnd.Handle, HWND_TOP, R.Left, R.Top,
      R.Width, R.Height, SWP_NOREDRAW);
  if Control.Visible then
   ShowWindow(FScrollWnd.Handle, SW_SHOW);
end;

procedure TScrollBarStyleHook.UpdateScrollBar;
var
  R: TRect;
begin
  if Control.Visible and (FScrollWnd <> nil) then
  begin
    R := ControlBounds;
    SetWindowPos(FScrollWnd.Handle, HWND_TOP, R.Left,
        R.Top, R.Width, R.Height, SWP_SHOWWINDOW);
  end;
end;

procedure TScrollBarStyleHook.PaintScrollBar;
begin
  if FScrollWnd <> nil then
    FScrollWnd.Repaint;
end;

procedure TScrollBarStyleHook.CNHScroll(var Message: TWMHScroll);
begin
  PaintScrollBar;
end;

procedure TScrollBarStyleHook.CNVScroll(var Message: TWMVScroll);
begin
  PaintScrollBar;
end;


function TScrollBarStyleHook.Horizontal: Boolean;
begin
  Result := GetWindowLong(Handle, GWL_STYLE) and SBS_VERT = 0;
end;

function TScrollBarStyleHook.VertScrollRect: TRect;
begin
  Result := TRect.Create(0, 0, Control.Width, Control.Height);
end;

function TScrollBarStyleHook.VertSliderRect: TRect;
var
  Info: TScrollInfo;
begin
  if not Control.Enabled then
    Result := TRect.Create(0, 0, 0, 0)
  else
  begin
    Result := Control.ClientRect;
    Info.fMask := SIF_ALL;
    Info.cbSize := SizeOf(Info);
    GetScrollInfo(Handle, SB_CTL, Info);
    if Info.nMax - Info.nMin = 0 then
      Exit(TRect.Empty);

    if Info.nPage = 0 then
    begin
      Result.Top := VertTrackRect.Top + Round(((Info.nPos - Info.nMin) / (Info.nMax - Info.nMin)) * (VertTrackRect.Height - GetSystemMetrics(SM_CYVTHUMB)));
      Result.Bottom := Result.Top + GetSystemMetrics(SM_CYVTHUMB);
    end
    else
    begin
      Result.Top := VertTrackRect.Top + Round(((Info.nPos - Info.nMin) / (Info.nMax - Info.nMin)) * VertTrackRect.Height);
      Result.Bottom := VertTrackRect.Top + Round(((Info.nPos + Integer(Info.nPage) - Info.nMin - 1) / (Info.nMax - Info.nMin)) * VertTrackRect.Height);
      if Result.Bottom - Result.Top < GetSystemMetrics(SM_CYVTHUMB) then
      begin
        if Info.nMax - Info.nMin - Integer(Info.nPage) = 0 then
          Result.Top := VertTrackRect.Top
        else
          Result.Top := VertTrackRect.Top + Round(((Info.nPos - Info.nMin) / (Info.nMax - Info.nMin - Integer(Info.nPage))) * (VertTrackRect.Height - GetSystemMetrics(SM_CYVTHUMB)));
        Result.Bottom := Result.Top + GetSystemMetrics(SM_CYVTHUMB);
      end;
    end;
    if Result.Bottom > VertDownButtonRect.Top then
        Result.Bottom := VertDownButtonRect.Top;
    if VertDownButtonRect.Top - VertUpButtonRect.Bottom < GetSystemMetrics(SM_CYVTHUMB) then
        Result := Rect(0, 0, 0, 0);
  end;
end;

function TScrollBarStyleHook.VertTrackRect: TRect;
begin
  Result := VertScrollRect;
  if Result.Width > 0 then
  begin
    Result.Top := Result.Top + GetSystemMetrics(SM_CYVTHUMB);
    Result.Bottom := Result.Bottom - GetSystemMetrics(SM_CYVTHUMB);
  end
  else
    Result := TRect.Empty;
end;

function TScrollBarStyleHook.VertUpButtonRect: TRect;
begin
  Result := VertScrollRect;
  if Result.Width > 0 then
  begin
    Result.Bottom := Result.Top + GetSystemMetrics(SM_CYVTHUMB);
    if VertScrollRect.Height < GetSystemMetrics(SM_CYVTHUMB) * 2 then
    Dec(Result.Bottom, (GetSystemMetrics(SM_CYVTHUMB) * 2 - VertScrollRect.Height) div 2);
    if Result.Bottom - Result.Top < GetSystemMetrics(SM_CYVTHUMB) div 2 then
      Result.Bottom := Result.Top + GetSystemMetrics(SM_CYVTHUMB) div 2;
  end
  else
    Result := TRect.Empty;
end;

function TScrollBarStyleHook.VertDownButtonRect: TRect;
begin
  Result := VertScrollRect;
  if Result.Width > 0 then
  begin
    Result.Top := Result.Bottom - GetSystemMetrics(SM_CYVTHUMB);
    if VertScrollRect.Height < GetSystemMetrics(SM_CYVTHUMB) * 2 then
    Inc(Result.Top, (GetSystemMetrics(SM_CYVTHUMB) * 2 - VertScrollRect.Height) div 2);
    if Result.Bottom - Result.Top < GetSystemMetrics(SM_CYVTHUMB) div 2 then
      Result.Top := Result.Bottom - GetSystemMetrics(SM_CYVTHUMB) div 2;
  end
  else
    Result := TRect.Empty;
end;

function TScrollBarStyleHook.HorzScrollRect: TRect;
begin
  Result := TRect.Create(0, 0, Control.Width, Control.Height);
end;

function TScrollBarStyleHook.HorzSliderRect: TRect;
var
  Info: TScrollInfo;
begin
  if not Control.Enabled then
    Result := TRect.Create(0, 0, 0, 0)
  else
  begin
    Result := Control.ClientRect;
    Info.fMask := SIF_ALL;
    Info.cbSize := SizeOf(Info);
    GetScrollInfo(Handle, SB_CTL, Info);
    if Info.nMax - Info.nMin = 0 then
      Exit(TRect.Empty);

    if Info.nPage = 0 then
    begin
      Result.Left := HorzTrackRect.Left + Round(((Info.nPos - Info.nMin) / (Info.nMax - Info.nMin)) * (HorzTrackRect.Width - GetSystemMetrics(SM_CXHTHUMB)));
      Result.Right := Result.Left + GetSystemMetrics(SM_CXHTHUMB);
    end
    else
    begin
      Result.Left := HorzTrackRect.Left + Round(((Info.nPos - Info.nMin) / (Info.nMax - Info.nMin)) * HorzTrackRect.Width);
      Result.Right := HorzTrackRect.Left + Round(((Info.nPos + Integer(Info.nPage) - Info.nMin - 1) / (Info.nMax - Info.nMin)) * HorzTrackRect.Width);
      if Result.Right - Result.Left < GetSystemMetrics(SM_CXHTHUMB) then
      begin
        if Info.nMax - Info.nMin - Integer(Info.nPage) = 0 then
          Result.Left := HorzTrackRect.Left 
        else
          Result.Left := HorzTrackRect.Left + Round(((Info.nPos - Info.nMin) / (Info.nMax - Info.nMin - Integer(Info.nPage))) * (HorzTrackRect.Width - GetSystemMetrics(SM_CXHTHUMB)));
        Result.Right := Result.Left + GetSystemMetrics(SM_CXHTHUMB);
      end;
    end;
    if Result.Right > HorzDownButtonRect.Left then
        Result.Right := HorzDownButtonRect.Left;
    if HorzDownButtonRect.Left - HorzUpButtonRect.Right < GetSystemMetrics(SM_CXHTHUMB) then
        Result := Rect(0, 0, 0, 0);
  end;
end;

function TScrollBarStyleHook.HorzTrackRect: TRect;
begin
  Result := HorzScrollRect;
  if Result.Width > 0 then
  begin
    Result.Left := Result.Left + GetSystemMetrics(SM_CXHTHUMB);
    Result.Right := Result.Right - GetSystemMetrics(SM_CXHTHUMB);
  end
  else
    Result := TRect.Empty;
end;

function TScrollBarStyleHook.HorzUpButtonRect: TRect;
begin
  Result := HorzScrollRect;
  if Result.Height > 0 then
  begin
    Result.Right := Result.Left + GetSystemMetrics(SM_CXHTHUMB);

    if HorzScrollRect.Width < GetSystemMetrics(SM_CXHTHUMB) * 2 then
    Dec(Result.Right, (GetSystemMetrics(SM_CXHTHUMB) * 2 - HorzScrollRect.Width) div 2);
    if Result.Right - Result.Left < GetSystemMetrics(SM_CXHTHUMB) div 2 then
      Result.Right := Result.Left + GetSystemMetrics(SM_CXHTHUMB) div 2;
  end
  else
    Result := TRect.Empty;
end;

function TScrollBarStyleHook.HorzDownButtonRect: TRect;
begin
  Result := HorzScrollRect;
  if Result.Height > 0 then
  begin
    Result.Left := Result.Right - GetSystemMetrics(SM_CXHTHUMB);
    if HorzScrollRect.Width < GetSystemMetrics(SM_CXHTHUMB) * 2 then
    Inc(Result.Left, (GetSystemMetrics(SM_CXHTHUMB) * 2 - HorzScrollRect.Width) div 2);
    if Result.Right - Result.Left < GetSystemMetrics(SM_CXHTHUMB) div 2 then
      Result.Left := Result.Right - GetSystemMetrics(SM_CXHTHUMB) div 2;
  end
  else
    Result := TRect.Empty;
end;

procedure TScrollBarStyleHook.VertDrawScroll(DC: HDC);
var
  LRect: TRect;
  LHandle: HDC;
  LBitmap: TBitmap;
  LStyle: TCustomStyleServices;
  LDetails: TThemedElementDetails;
begin
  if (Handle = 0) or (DC = 0) or (ControlBounds.Width = 0) or (ControlBounds.Height = 0) then
    Exit;

  LStyle := StyleServices;
  if (VertScrollRect.Width > 0) and LStyle.Available then
  begin
    LBitmap := TBitmap.Create;
    try
      LBitmap.SetSize(ControlBounds.Width, ControlBounds.Height);
      LBitmap.Canvas.Brush.Color := StyleServices.ColorToRGB(clBtnFace);
      LBitmap.Canvas.FillRect(Rect(0, 0, LBitmap.Width, LBitmap.Height));

      LRect := VertScrollRect;
      LRect.Top := VertUpButtonRect.Bottom;
      LRect.Bottom := VertDownButtonRect.Top;
      if LRect.Height > 0 then
      begin
        LDetails := StyleServices.GetElementDetails(tsUpperTrackVertNormal);
        StyleServices.DrawElement(LBitmap.Canvas.Handle, LDetails, LRect);
      end;

      {if HasBorder and Control.Enabled then
        MoveWindowOrg(LBitmap.Canvas.Handle, 1, 1);}

      // Important: The method VertSliderRect causes LBitmap.Canvas to free its handle
      LRect := VertSliderRect;

      // Imposrtant: Must get handle after call to VertSliderRect
      LHandle := LBitmap.Canvas.Handle;

      if Control.Enabled then
      begin
        LDetails := StyleServices.GetElementDetails(FVSliderState);
        StyleServices.DrawElement(LHandle, LDetails, LRect);
      end;

      if Control.Enabled then
        LDetails := StyleServices.GetElementDetails(FVUpState)
      else
        LDetails := StyleServices.GetElementDetails(tsArrowBtnUpDisabled);

      StyleServices.DrawElement(LHandle, LDetails, VertUpButtonRect);

      if Control.Enabled then
        LDetails := StyleServices.GetElementDetails(FVDownState)
      else
        LDetails := StyleServices.GetElementDetails(tsArrowBtnDownDisabled);

      StyleServices.DrawElement(LHandle, LDetails, VertDownButtonRect);

      BitBlt(DC, 0, 0, LBitmap.Width, LBitmap.Height, LHandle, 0, 0, SRCCOPY);
    finally
      LBitmap.Free;
    end;
  end;
end;

procedure TScrollBarStyleHook.HorzDrawScroll(DC: HDC);
var
  LRect: TRect;
  LHandle: HDC;
  LBitmap: TBitmap;
  LDetails: TThemedElementDetails;
  LStyle: TCustomStyleServices;
begin
  if (Handle = 0) or (DC = 0) or (ControlBounds.Width = 0) or (ControlBounds.Height = 0) then
    Exit;

  LStyle := StyleServices;
  if (HorzScrollRect.Height > 0) and LStyle.Available then
  begin
    LBitmap := TBitmap.Create;
    try
      LBitmap.SetSize(ControlBounds.Width, ControlBounds.Height);
      LBitmap.Canvas.Brush.Color := LStyle.ColorToRGB(clBtnFace);
      LBitmap.Canvas.FillRect(Rect(0, 0, LBitmap.Width, LBitmap.Height));

      LRect := HorzScrollRect;
      LRect.Left := HorzUpButtonRect.Right;
      LRect.Right := HorzDownButtonRect.Left;
      if LRect.Height > 0 then
      begin
        LDetails := LStyle.GetElementDetails(tsUpperTrackHorzNormal);
        LStyle.DrawElement(LBitmap.Canvas.Handle, LDetails, LRect);
      end;

      {if HasBorder then
        MoveWindowOrg(LBitmap.Canvas.Handle, 1, 1);}

      // Important: The method HorzSliderRect causes LBitmap.Canvas to free its handle
      LRect := HorzSliderRect;

      // Imposrtant: Must get handle after call to HorzSliderRect
      LHandle := LBitmap.Canvas.Handle;

      if Control.Enabled then
      begin
        LDetails := LStyle.GetElementDetails(FHSliderState);
        LStyle.DrawElement(LHandle, LDetails, LRect);
      end;

      if Control.Enabled then
        LDetails := LStyle.GetElementDetails(FHUpState)
      else
        LDetails := LStyle.GetElementDetails(tsArrowBtnLeftDisabled);
      LStyle.DrawElement(LHandle, LDetails, HorzUpButtonRect);

      if Control.Enabled then
        LDetails := LStyle.GetElementDetails(FHDownState)
      else
        LDetails := LStyle.GetElementDetails(tsArrowBtnRightDisabled);
      LStyle.DrawElement(LHandle, LDetails, HorzDownButtonRect);

      BitBlt(DC, 0, 0, LBitmap.Width, LBitmap.Height, LHandle, 0, 0, SRCCOPY);
    finally
      LBitmap.Free;
    end;
  end;
end;

procedure TScrollBarStyleHook.WMNCPaint(var Message: TMessage);
begin
  if FScrollWnd = nil then
    InitScrollBar;
end;

procedure TScrollBarStyleHook.WMMouseWheel(var Message: TMessage);
begin
  CallDefaultProc(TMessage(Message));
  Invalidate;
  Handled := True;
end;

procedure TScrollBarStyleHook.WMLButtonDown(var Message: TWMMouse);
var
  P: TPoint;
begin
  P := Point(Message.XPos, Message.YPos);
  if not Horizontal then
  begin
    if VertUpButtonRect.Contains(P) then
    begin
      FVUpState := tsArrowBtnUpPressed;
      PaintScrollBar;
    end
    else if VertDownButtonRect.Contains(P) then
    begin
      FVDownState := tsArrowBtnDownPressed;
      PaintScrollBar;
    end
    else if VertSliderRect.Contains(P) then
    begin
      FVSliderState := tsThumbBtnVertPressed;
      PaintScrollBar;
    end;
  end
  else
  begin
    if HorzUpButtonRect.Contains(P) then
    begin
      FHUpState := tsArrowBtnLeftPressed;
      PaintScrollBar;
    end
    else if HorzDownButtonRect.Contains(P) then
    begin
      FHDownState := tsArrowBtnRightPressed;
      PaintScrollBar;
    end
    else if HorzSliderRect.Contains(P) then
    begin
      FHSliderState := tsThumbBtnHorzPressed;
      PaintScrollBar;
    end;
  end;
end;

procedure TScrollBarStyleHook.WMLButtonUp(var Message: TWMMouse);
var
  P: TPoint;
begin
  P := Point(Message.XPos, Message.YPos);

  if not Horizontal then
  begin
    if FVSliderState = tsThumbBtnVertPressed then
    begin
      if VertSliderRect.Contains(P) then
        FVSliderState := tsThumbBtnVertHot
      else
        FVSliderState := tsThumbBtnVertNormal;
      PaintScrollBar;
    end
    else if FVUpState = tsArrowBtnUpPressed then
    begin
      if VertUpButtonRect.Contains(P) then
        FVUpState := tsArrowBtnUpHot
      else
        FVUpState := tsArrowBtnUpNormal;
      PaintScrollBar;
    end
    else if FVDownState = tsArrowBtnDownPressed then
    begin
      if VertDownButtonRect.Contains(P) then
        FVDownState := tsArrowBtnDownHot
      else
        FVDownState := tsArrowBtnDownNormal;
      PaintScrollBar;
    end;
  end
  else
  begin
    if FHSliderState = tsThumbBtnHorzPressed then
    begin
      if HorzSliderRect.Contains(P) then
        FHSliderState := tsThumbBtnHorzHot
      else
        FHSliderState := tsThumbBtnHorzNormal;
      PaintScrollBar;
    end
    else if FHUpState = tsArrowBtnLeftPressed then
    begin
      if HorzUpButtonRect.Contains(P) then
        FHUpState := tsArrowBtnLeftHot
      else
        FHUpState:= tsArrowBtnLeftNormal;
      PaintScrollBar;
    end
    else if FHDownState = tsArrowBtnRightPressed then
    begin
       if HorzDownButtonRect.Contains(P) then
        FHDownState := tsArrowBtnRightHot
      else
        FHDownState:= tsArrowBtnRightNormal;
      PaintScrollBar;
    end;
  end;
end;

procedure TScrollBarStyleHook.WMMouseMove(var Message: TWMMouse);
var
  P: TPoint;
  MustUpdateScroll: Boolean;
begin
  inherited;
  CallDefaultProc(TMessage(Message));
  P := Point(Message.XPos, Message.YPos);
  MustUpdateScroll := False;

  if Horizontal then
  begin
    if HorzSliderRect.Width > 0 then
      if PtInRect(HorzSliderRect, P) and (FHSliderState = tsThumbBtnHorzNormal) then
      begin
        FHSliderState := tsThumbBtnHorzHot;
        MustUpdateScroll := True;
      end
      else if not PtInRect(HorzSliderRect, P) and (FHSliderState = tsThumbBtnHorzHot) then
      begin
        FHSliderState := tsThumbBtnHorzNormal;
        MustUpdateScroll := True;
      end;

    if HorzSliderRect.Width > 0 then
      if PtInRect(HorzDownButtonRect, P) and (FHDownState = tsArrowBtnRightNormal) then
      begin
        FHDownState := tsArrowBtnRightHot;
        MustUpdateScroll := True;
      end
      else if not PtInRect(HorzDownButtonRect, P) and (FHDownState = tsArrowBtnRightHot) then
      begin
        FHDownState := tsArrowBtnRightNormal;
        MustUpdateScroll := True;
      end;

    if HorzSliderRect.Width > 0 then
      if PtInRect(HorzUpButtonRect, P) and (FHUpState = tsArrowBtnLeftNormal) then
      begin
        FHUpState := tsArrowBtnLeftHot;
        MustUpdateScroll := True;
      end
      else if not PtInRect(HorzUpButtonRect, P) and (FHUpState = tsArrowBtnLeftHot) then
      begin
        FHUpState := tsArrowBtnLeftNormal;
        MustUpdateScroll := True;
      end;
  end
  else
  begin
    if VertSliderRect.Height > 0 then
      if PtInRect(VertSliderRect, P) and (FVSliderState = tsThumbBtnVertNormal) then
      begin
        FVSliderState := tsThumbBtnVertHot;
        MustUpdateScroll := True;
      end
      else if not PtInRect(VertSliderRect, P) and (FVSliderState = tsThumbBtnVertHot) then
      begin
        FVSliderState := tsThumbBtnVertNormal;
        MustUpdateScroll := True;
      end;

    if VertSliderRect.Height > 0 then
      if PtInRect(VertDownButtonRect, P) and (FVDownState = tsArrowBtnDownNormal) then
      begin
        FVDownState := tsArrowBtnDownHot;
        MustUpdateScroll := True;
      end
      else if not PtInRect(VertDownButtonRect, P) and (FVDownState = tsArrowBtnDownHot) then
      begin
        FVDownState := tsArrowBtnDownNormal;
        MustUpdateScroll := True;
      end;

    if VertSliderRect.Height > 0 then
      if PtInRect(VertUpButtonRect, P) and (FVUpState = tsArrowBtnUpNormal) then
      begin
        FVUpState := tsArrowBtnUpHot;
        MustUpdateScroll := True;
      end
      else if not PtInRect(VertUpButtonRect, P) and (FVUpState = tsArrowBtnUpHot) then
      begin
        FVUpState := tsArrowBtnUpNormal;
        MustUpdateScroll := True;
      end;
  end;

  if MustUpdateScroll then
    PaintScrollBar;

  Handled := True;
end;

procedure TScrollBarStyleHook.WMLButtonDblClk(var Message: TWMMouse);
begin
  WMLButtonDown(Message);
end;

procedure TScrollBarStyleHook.WMSetFocus(var Message: TMessage);
begin
  CallDefaultProc(TMessage(Message));
  PaintScrollBar;
  Handled := True;
end;

procedure TScrollBarStyleHook.WMKillFocus(var Message: TMessage);
begin
  CallDefaultProc(TMessage(Message));
  PaintScrollBar;
  Handled := True;
end;

procedure TScrollBarStyleHook.WMKeyDown(var Message: TMessage);
begin
  CallDefaultProc(TMessage(Message));
  PaintScrollBar;
  Handled := True;
end;

procedure TScrollBarStyleHook.WMKeyUp(var Message: TMessage);
begin
  CallDefaultProc(TMessage(Message));
  PaintScrollBar;
  Handled := True;
end;

procedure TScrollBarStyleHook.MouseLeave;
begin
  inherited;

  if FVSliderState = tsThumbBtnVertHot then
    FVSliderState := tsThumbBtnVertNormal;

  if FHSliderState = tsThumbBtnHorzHot then
    FHSliderState := tsThumbBtnHorzNormal;

  if FVUpState = tsArrowBtnUpHot then
    FVUpState := tsArrowBtnUpNormal;

  if FVDownState = tsArrowBtnDownHot then
    FVDownState := tsArrowBtnDownNormal;

  if FHUpState = tsArrowBtnLeftHot then
    FHUpState := tsArrowBtnLeftNormal;

  if FHDownState = tsArrowBtnRightHot then
    FHDownState := tsArrowBtnRightNormal;

  PaintScrollBar;
end;

procedure TScrollBarStyleHook.WMCaptureChanged(var Message: TMessage);
var
  MustUpdateScroll: Boolean;
begin
  MustUpdateScroll := False;

  if FVUpState = tsArrowBtnUpPressed then
  begin
    FVUpState := tsArrowBtnUpNormal;
    MustUpdateScroll := True;
  end;

  if FVDownState = tsArrowBtnDownPressed then
  begin
    FVDownState := tsArrowBtnDownNormal;
    MustUpdateScroll := True;
  end;

  if FHUpState = tsArrowBtnLeftPressed then
  begin
    FHUpState := tsArrowBtnLeftNormal;
    MustUpdateScroll := True;
  end;

  if FHDownState = tsArrowBtnRightPressed then
  begin
    FHDownState := tsArrowBtnRightNormal;
    MustUpdateScroll := True;
  end;

  if (FVSliderState = tsThumbBtnVertPressed) and (NativeInt(Message.LParam) <> NativeInt(Handle))
  then
  begin
    FVSliderState := tsThumbBtnVertNormal;
    MustUpdateScroll := True;
  end;

  if (FHSliderState = tsThumbBtnHorzPressed) and (NativeInt(Message.LParam) <> NativeInt(Handle))
  then
  begin
    FHSliderState := tsThumbBtnHorzNormal;
    MustUpdateScroll := True;
  end;

  if  MustUpdateScroll then PaintScrollBar;
end;

type
  TWinControlClass = class(TWinControl);

{ TEditStyleHook }

constructor TEditStyleHook.Create(AControl: TWinControl);
begin
  inherited;
  OverridePaintNC := True;
  OverrideEraseBkgnd := True;
  UpdateColors;
end;

procedure TEditStyleHook.WMNCCalcSize(var Message: TWMNCCalcSize);
var
  Params: PNCCalcSizeParams;
begin
  if (Control is TCustomEdit) then
  begin
    if TCustomEdit(Control).BevelKind <> bkNone then
    begin
      Params := Message.CalcSize_Params;
      if HasBorder then
        with Params^.rgrc[0] do
        begin
          Inc(Left, 2);
          Inc(Top, 2);
          Dec(Right, 2);
          Dec(Bottom, 2);
        end;
      Handled := True;
    end;
  end;
end;

procedure TEditStyleHook.MouseEnter;
begin
  InvalidateNC;
end;

procedure TEditStyleHook.MouseLeave;
begin
  InvalidateNC;
end;

procedure TEditStyleHook.PaintNC(Canvas: TCanvas);
var
  Details: TThemedElementDetails;
  R: TRect;
begin
  if StyleServices.Available and HasBorder then
  begin
    if Control.Focused then
      Details := StyleServices.GetElementDetails(teEditBorderNoScrollFocused)
    else
    if MouseInControl then
      Details := StyleServices.GetElementDetails(teEditBorderNoScrollHot)
    else
    if Control.Enabled then
      Details := StyleServices.GetElementDetails(teEditBorderNoScrollNormal)
    else
      Details := StyleServices.GetElementDetails(teEditBorderNoScrollDisabled);
    R := Rect(0, 0, Control.Width, Control.Height);
    InflateRect(R, -2, -2);
    ExcludeClipRect(Canvas.Handle, R.Left, R.Top, R.Right, R.Bottom);
    StyleServices.DrawElement(Canvas.Handle, Details,
      Rect(0, 0, Control.Width, Control.Height));
  end;
end;

procedure TEditStyleHook.UpdateColors;
const
  ColorStates: array[Boolean] of TStyleColor = (scEditDisabled, scEdit);
  FontColorStates: array[Boolean] of TStyleFont = (sfEditBoxTextDisabled, sfEditBoxTextNormal);
var
  LStyle: TCustomStyleServices;
begin
  LStyle := StyleServices;
  Brush.Color := LStyle.GetStyleColor(ColorStates[Control.Enabled]);
  if seFont in Control.StyleElements then
    FontColor := LStyle.GetStyleFontColor(FontColorStates[Control.Enabled])
  else
    FontColor := TWinControlClass(Control).Font.Color;
end;

procedure TEditStyleHook.WndProc(var Message: TMessage);
begin
  case Message.Msg of
    CN_CTLCOLORMSGBOX..CN_CTLCOLORSTATIC:
      begin
        SetTextColor(Message.WParam, ColorToRGB(FontColor));
        SetBkColor(Message.WParam, ColorToRGB(Brush.Color));
        Message.Result := LRESULT(Brush.Handle);
        Handled := True;
      end;
    CM_ENABLEDCHANGED:
      begin
        UpdateColors;
        Handled := False; // Allow control to handle message
      end
  else
    inherited WndProc(Message);
  end;
  case Message.Msg of
    WM_SIZE:
    begin
      if seBorder in Control.StyleElements then InvalidateNC;
      Handled := False;
    end;
    CM_FOCUSCHANGED:
      if not TStyleManager.SystemStyle.Enabled then
        InvalidateNC;
  end;
end;

{ TComboBoxStyleHook }

constructor TComboBoxStyleHook.Create;
begin
  inherited;
  if Style = csSimple then
    OverrideEraseBkgnd := True;
  FMouseOnButton := False;
  FEditHandle := 0;
  FListHandle := 0;
  FListBoxInstance := nil;
  FIgnoreStyleChanged := False;
  FVSliderState := tsThumbBtnVertNormal;
  FVUpState := tsArrowBtnUpNormal;
  FVDownState := tsArrowBtnDownNormal;
  FSliderSize := 0;
  FListBoxTimerCode := 0;
  FListBoxUpBtnDown := False;
  FListBoxDownBtnDown := False;
  FListBoxTrackUpDown := False;
  FListBoxTrackDownDown := False;
  UpdateColors;
end;

destructor TComboBoxStyleHook.Destroy;
begin
  if (FListHandle <> 0) and (FListBoxInstance <> nil) then
  begin
    SetWindowLong(FListHandle, GWL_WNDPROC, IntPtr(FDefListBoxProc));
    FreeObjectInstance(FListBoxInstance);
    FListBoxInstance := nil;
  end;
  if FListBoxTimerCode <> 0 then
    ListBoxStopTimer;
  inherited;
end;

function TComboBoxStyleHook.IsChildHandle(AHandle: HWnd): Boolean;
begin
  Result := (FEditHandle <> 0) and (FEditHandle = AHandle);
end;

function TComboBoxStyleHook.AcceptMessage(var Message: TMessage): Boolean;
begin
  Result := seBorder in Control.StyleElements;
end;

procedure TComboBoxStyleHook.ListBoxSetTimer(ATimerCode: Integer);
begin
  if FListBoxTimerCode <> 0 then ListBoxStopTimer;
  FListBoxTimerCode := ATimerCode;
  if ATimerCode < 4 then
    SetTimer(FListHandle, 1, 300, nil)
  else
    SetTimer(FListHandle, 1, 50, nil);
end;

procedure TComboBoxStyleHook.ListBoxStopTimer;
begin
  FListBoxTimerCode := -1;
  KillTimer(FListHandle, 1);
end;

function TComboBoxStyleHook.DroppedDown: Boolean;
begin
  if (Control <> nil) and (Control is TCustomComboBox) then
    Result := TCustomComboBox(Control).DroppedDown
  else if Handle <> 0 then
    Result := LongBool(SendMessage(Handle, CB_GETDROPPEDSTATE, 0, 0))
  else
    Result := False;
end;

function TComboBoxStyleHook.GetButtonRect: TRect;
begin
  Result := Control.ClientRect;
  InflateRect(Result, -2, -2);
  if Control.BiDiMode <> bdRightToLeft then
    Result.Left := Result.Right - GetSystemMetrics(SM_CXVSCROLL) + 1
  else
    Result.Right := Result.Left + GetSystemMetrics(SM_CXVSCROLL) - 1;
end;

function TComboBoxStyleHook.Style: TComboBoxStyle;
const
  ComboBoxStyles: array[TComboBoxStyle] of DWORD = (
    CBS_DROPDOWN, CBS_SIMPLE, CBS_DROPDOWNLIST,
    CBS_DROPDOWNLIST or CBS_OWNERDRAWFIXED,
    CBS_DROPDOWNLIST or CBS_OWNERDRAWVARIABLE);
var
  LStyle: Cardinal;
begin
  if (Control <> nil) and (Control is TCustomComboBox) then
    Result := TCustomComboBox(Control).Style
  else if Handle <> 0 then
  begin
    LStyle := GetWindowLong(Handle, GWL_STYLE);
    Result := csDropDown;
    if LStyle and ComboBoxStyles[csDropDown] = ComboBoxStyles[csDropDown] then
      Result := csDropDown;
    if LStyle and ComboBoxStyles[csSimple] = ComboBoxStyles[csSimple] then
      Result := csSimple;
    if LStyle and ComboBoxStyles[csDropDownList] = ComboBoxStyles[csDropDownList] then
      Result := csDropDownList;
    if LStyle and ComboBoxStyles[csOwnerDrawFixed] = ComboBoxStyles[csOwnerDrawFixed] then
      Result := csOwnerDrawFixed;
    if LStyle and ComboBoxStyles[csOwnerDrawVariable] = ComboBoxStyles[csOwnerDrawVariable] then
      Result := csOwnerDrawVariable;
  end
  else
    Result := csDropDown;
end;

procedure TComboBoxStyleHook.UpdateColors;
const
  ColorStates: array[Boolean] of TStyleColor = (scComboBoxDisabled, scComboBox);
  FontColorStates: array[Boolean] of TStyleFont = (sfComboBoxItemDisabled, sfComboBoxItemNormal);
var
  LStyle: TCustomStyleServices;
begin
  LStyle := StyleServices;
  if seClient in Control.StyleElements then
    Brush.Color := LStyle.GetStyleColor(ColorStates[Control.Enabled])
  else
    Brush.Color := TWinControlClass(Control).Color;
  if seFont in Control.StyleElements then
    FontColor := LStyle.GetStyleFontColor(FontColorStates[Control.Enabled])
  else
    FontColor := TWinControlClass(Control).Font.Color;
end;

procedure TComboBoxStyleHook.PaintBorder(Canvas: TCanvas);
var
  R, ControlRect, EditRect, ListRect: TRect;
  DrawState: TThemedComboBox;
  BtnDrawState: TThemedComboBox;
  Details: TThemedElementDetails;
  Buffer: TBitmap;
begin
  if not StyleServices.Available then Exit;

  if not Control.Enabled then
    BtnDrawState := tcDropDownButtonDisabled
  else if DroppedDown then
    BtnDrawState := tcDropDownButtonPressed
  else if FMouseOnButton then
    BtnDrawState := tcDropDownButtonHot
  else
    BtnDrawState := tcDropDownButtonNormal;

  if not Control.Enabled then
    DrawState := tcBorderDisabled
  else
  if Control.Focused then
    DrawState := tcBorderFocused
  else if MouseInControl then
    DrawState := tcBorderHot
  else
    DrawState := tcBorderNormal;

  Buffer := TBitMap.Create;
  Buffer.SetSize(Control.Width, Control.Height);
  try
    R := Rect(0, 0, Buffer.Width, Buffer.Height);
    // draw border + client in buffer
    Details := StyleServices.GetElementDetails(DrawState);
    if (Style = csSimple) and (FListHandle <> 0) then
    begin
      GetWindowRect(FListHandle, ListRect);
      GetWindowRect(Handle, ControlRect);
      R.Bottom := ListRect.Top - ControlRect.Top;
      StyleServices.DrawElement(Buffer.Canvas.Handle, Details, R);
      R := Rect(0, Control.Height - (ControlRect.Bottom - ListRect.Bottom),
        Control.Width, Control.Height);
      with Buffer.Canvas do
      begin
        Brush.Style := bsSolid;
        Brush.Color := StyleServices.GetSystemColor(clBtnFace);
        FillRect(R);
      end;
      R := Rect(0, 0, Buffer.Width, Buffer.Height);
      R.Bottom := ListRect.Top - ControlRect.Top;
    end
    else
      StyleServices.DrawElement(Buffer.Canvas.Handle, Details, R);

    if not (seClient in Control.StyleElements) and (FEditHandle = 0) then
    begin
      R := Control.ClientRect;
      InflateRect(R, -3, -3);
      R.Right := ButtonRect.Left - 2;
      with Buffer.Canvas do
      begin
        Brush.Color := TWinControlClass(Control).Color;
        FillRect(R);
      end;
    end;
    // draw button in buffer
    if Style <> csSimple then
    begin
      Details := StyleServices.GetElementDetails(BtnDrawState);
      StyleServices.DrawElement(Buffer.Canvas.Handle, Details, ButtonRect);
    end;
    // calculation of exclude area for drawing buffer
    if (SendMessage(Handle, CB_GETCURSEL, 0, 0) >= 0) and (FEditHandle = 0) then
    begin
      R := Control.ClientRect;
      InflateRect(R, -3, -3);
      R.Right := ButtonRect.Left - 2;
      ExcludeClipRect(Canvas.Handle, R.Left, R.Top, R.Right, R.Bottom);
    end
    else
    if FEditHandle <> 0 then
    begin
      GetWindowRect(Handle, R);
      GetWindowRect(FEditHandle, EditRect);
      OffsetRect(EditRect, -R.Left, -R.Top);
      with EditRect do
        ExcludeClipRect(Canvas.Handle, Left, Top, Right, Bottom);
    end;
    // draw buffer
    Canvas.Draw(0, 0, Buffer);
  finally
    Buffer.Free;
  end;
end;

procedure TComboBoxStyleHook.DrawItem(Canvas: TCanvas;
  Index: Integer; const R: TRect; Selected: Boolean);
var
  DIS: TDrawItemStruct;
begin
  FillChar(DIS, SizeOf(DIS), 0);
  DIS.CtlType := ODT_COMBOBOX;
  DIS.CtlID := GetDlgCtrlID(Handle);
  DIS.itemAction := ODA_DRAWENTIRE;
  DIS.hDC := Canvas.Handle;
  DIS.hwndItem := Handle;
  DIS.rcItem := R;
  DIS.itemID := Index;
  DIS.itemData := SendMessage(FListHandle, LB_GETITEMDATA, 0, 0);
  if Selected then
    DIS.itemState := DIS.itemState or ODS_FOCUS or ODS_SELECTED;

  SendMessage(Handle, WM_DRAWITEM, Handle, LPARAM(@DIS));
end;

procedure TComboBoxStyleHook.WMParentNotify(var Message: TMessage);
begin
  if (FListHandle = 0) and (LoWord(Message.WParam) = WM_CREATE) then
  begin
    if (Message.LParam <> 0) and (FListBoxInstance = nil) then
      HookListBox(Message.LParam);
  end
  else if (FEditHandle = 0) and (LoWord(Message.WParam) = WM_CREATE) then
    FEditHandle := Message.LParam;
end;

procedure TComboBoxStyleHook.WndProc(var Message: TMessage);
const
  States: array[Boolean] of TStyleColor = (scEditDisabled, scComboBox);
begin
  case Message.Msg of
    WM_CTLCOLORMSGBOX..WM_CTLCOLORSTATIC,
    CN_CTLCOLORMSGBOX..CN_CTLCOLORSTATIC:
      begin
        SetTextColor(Message.WParam, ColorToRGB(FontColor));
        if seClient in Control.StyleElements then
          Brush.Color := StyleServices.GetStyleColor(States[Control.Enabled])
        else
          Brush.Color := TWinControlClass(Control).Color;
        SetBkColor(Message.WParam, ColorToRGB(Brush.Color));
        Message.Result := LRESULT(Brush.Handle);
        Handled := True;
      end;
    CM_ENABLEDCHANGED:
      begin
        UpdateColors;
        Handled := False; // Allow control to handle message
      end;
    CM_FOCUSCHANGED:
      begin
        Invalidate;
        Handled := False; // Allow control to handle message
      end;
  else
    inherited WndProc(Message);
  end;
end;

procedure TComboBoxStyleHook.MouseEnter;
begin
  inherited;
  Invalidate;
end;

procedure TComboBoxStyleHook.MouseLeave;
begin
  inherited;
  if not DroppedDown and FMouseOnButton then
    FMouseOnButton := False;
  Invalidate;
end;

procedure TComboBoxStyleHook.WMMouseMove(var Message: TWMMouse);
var
  P: TPoint;
  R: TRect;
  FOldMouseOnButton: Boolean;
begin
  CallDefaultProc(TMessage(Message));
  inherited;

  P := Point(Message.XPos, Message.YPos);
  FOldMouseOnButton := FMouseOnButton;
  R := ButtonRect;
  if R.Contains(P) then
    FMouseOnButton := True
  else
    FMouseOnButton := False;

  if FOldMouseOnButton <> FMouseOnButton then
    InvalidateRect(Handle, @R, False);

  Handled := True;
end;

procedure TComboBoxStyleHook.CNDrawItem(var Message: TWMDrawItem);
begin
  WMDrawItem(Message);
  Handled := True;
end;

procedure TComboBoxStyleHook.WMDrawItem(var Message: TWMDrawItem);
begin
  CallDefaultProc(TMessage(Message));
  Handled := True;
end;

procedure TComboBoxStyleHook.WMPaint(var Message: TMessage);
var
  R: TRect;
  Canvas: TCanvas;
  PS: TPaintStruct;
  SaveIndex: Integer;
  DC: HDC;
begin
  DC := Message.WParam;
  Canvas := TCanvas.Create;
  try
    if DC = 0 then
      Canvas.Handle := BeginPaint(Handle, PS)
    else
      Canvas.Handle := DC;

    SaveIndex := SaveDC(Canvas.Handle);
    try
      PaintBorder(Canvas);
    finally
      RestoreDC(Canvas.Handle, SaveIndex);
    end;

    if (Style <> csSimple) and (FEditHandle = 0) then
    begin
      R := Control.ClientRect;
      InflateRect(R, -3, -3);
      if Control.BiDiMode <> bdRightToLeft then
        R.Right := ButtonRect.Left - 1
      else
        R.Left := ButtonRect.Right + 1;
      SaveIndex := SaveDC(Canvas.Handle);
      try
        IntersectClipRect(Canvas.Handle, R.Left, R.Top, R.Right, R.Bottom);
        DrawItem(Canvas, TComboBox(Control).ItemIndex, R, Focused);
      finally
        RestoreDC(Canvas.Handle, SaveIndex);
      end;
    end;

  finally
    Canvas.Handle := 0;
    Canvas.Free;
    if DC = 0 then
      EndPaint(Handle, PS);
  end;

  Handled := True;
end;

procedure TComboBoxStyleHook.WMCommand(var Message: TWMCommand);
begin
  if (Message.NotifyCode = CBN_SELENDCANCEL) or (Message.NotifyCode = CBN_SELENDOK) or
     (Message.NotifyCode = CBN_CLOSEUP) or (Message.NotifyCode = CBN_DROPDOWN) or
     (Message.NotifyCode = CBN_SELCHANGE) then
  begin
    if FListBoxTimerCode <> 0 then
      ListBoxStopTimer;
    FMouseOnButton := False;
    Invalidate;
  end;
end;

procedure TComboBoxStyleHook.CNCommand(var Message: TWMCommand);
begin
  if (Message.NotifyCode = CBN_SELENDCANCEL) or (Message.NotifyCode = CBN_SELENDOK) or
     (Message.NotifyCode = CBN_CLOSEUP) or (Message.NotifyCode = CBN_DROPDOWN) or
     (Message.NotifyCode = CBN_SELCHANGE)  then
  begin
    if FListBoxTimerCode <> 0 then ListBoxStopTimer;
    FMouseOnButton := False;
    Invalidate;
  end;
end;

procedure TComboBoxStyleHook.HookListBox(AListHandle: HWND);
begin
  if (AListHandle <> 0) and (FListBoxInstance = nil) then
  begin
    FListHandle := AListHandle;
    FListBoxInstance := MakeObjectInstance(ListBoxWndProc);
    FDefListBoxProc := Pointer(GetWindowLong(FListHandle, GWL_WNDPROC));
    SetWindowLong(FListHandle, GWL_WNDPROC, IntPtr(FListBoxInstance));
  end;
end;


function TComboBoxStyleHook.ListBoxBoundsRect: TRect;
begin
  GetWindowRect(FListHandle, Result);
end;

function TComboBoxStyleHook.ListBoxClientRect: TRect;
begin
   GetClientRect(FListHandle, Result);
end;

function TComboBoxStyleHook.ListBoxVertScrollRect: TRect;
begin
  Result := ListBoxBoundsRect;
  OffsetRect(Result, -Result.Left, -Result.Top);
  InflateRect(Result, -1, -1);
  OffsetRect(Result, 1, 1);
  if Control.BiDiMode <> bdRightToLeft then
    Result.Left := Result.Right - GetSystemMetrics(SM_CXVSCROLL)
  else
    Result.Right := Result.Left + GetSystemMetrics(SM_CXVSCROLL);
  if ListBoxBoundsRect.Height > 30 then OffsetRect(Result, -1, -1);
end;

function TComboBoxStyleHook.ListBoxVertDownButtonRect: TRect;
begin
  Result := ListBoxVertScrollRect;
  if Result.Width > 0 then
    Result.Top := Result.Bottom - GetSystemMetrics(SM_CYVTHUMB)
  else
    Result := TRect.Empty;
 end;

function TComboBoxStyleHook.ListBoxVertUpButtonRect: TRect;
begin
  Result := ListBoxVertScrollRect;
  if Result.Width > 0 then
    Result.Bottom := Result.Top + GetSystemMetrics(SM_CYVTHUMB)
  else
    Result := TRect.Empty;
end;

function TComboBoxStyleHook.ListBoxVertScrollArea: TRect;
begin
  if GetWindowLong(FListHandle, GWL_STYLE) and WS_VSCROLL = 0 then
  begin
    Result := TRect.Empty;
    Exit;
  end;
  Result := ListBoxBoundsRect;
  OffsetRect(Result, -Result.Left, -Result.Top);
  if Control.BiDiMode <> bdRightToLeft then
     Result.Left := Result.Right - GetSystemMetrics(SM_CYVSCROLL) - 1
   else
     Result.Right := Result.Left + GetSystemMetrics(SM_CYVSCROLL);
end;

function TComboBoxStyleHook.ListBoxVertSliderRect: TRect;
var
  I, LVisibleHeight, LTotalHeight, LSize, LTotalSize,
  LFinalHeight, LItemHeight, LBoundsHeight, LBorderHeight: Integer;
begin
  Result := ListBoxVertScrollRect;
  Result.Top := ListBoxVertUpButtonRect.Bottom;
  Result.Bottom := ListBoxVertDownButtonRect.Top;
  LSize := Result.Bottom - Result.Top;
  LTotalSize := SendMessage(FListHandle, LB_GETCOUNT, 0, 0) * LSize;
  if LTotalSize = 0 then
    Exit;
  Result.Top := Result.Top +
     Round((SendMessage(FListHandle, LB_GETTOPINDEX, 0, 0) / SendMessage(FListHandle, LB_GETCOUNT, 0, 0)) * LSize);

  LTotalHeight := 1;
  FInvsibleCount := 0;
  LBoundsHeight := ListBoxBoundsRect.Height;
  for I := 0 to SendMessage(FListHandle, LB_GETCOUNT, 0, 0) - 1 do
  begin
    LItemHeight := SendMessage(FListHandle, LB_GETITEMHEIGHT, I, 0);
    LTotalHeight := LTotalHeight + LItemHeight;
    if (LTotalHeight > LBoundsHeight) and (FInvsibleCount = 0) then
      FInvsibleCount := SendMessage(FListHandle, LB_GETCOUNT, 0, 0) - I;
  end;

  LVisibleHeight := 0;
  for I := SendMessage(FListHandle, LB_GETTOPINDEX, 0, 0) to SendMessage(FListHandle, LB_GETCOUNT, 0, 0) - 1 do
  begin
    LVisibleHeight := LVisibleHeight + SendMessage(FListHandle, LB_GETITEMHEIGHT, I, 0);
    if Style <> csSimple then LBorderHeight := 2 else
      LBorderHeight := 4;
    if LVisibleHeight >= ListBoxBoundsRect.Height - LBorderHeight then
      Break;
  end;

  Result.Bottom := Result.Top + Round((LVisibleHeight / LTotalHeight) * LSize);
  if (I = SendMessage(FListHandle, LB_GETCOUNT, 0, 0) - 1) and
     (Result.Bottom <> ListBoxVertDownButtonRect.Top) then
  begin
    LFinalHeight := Result.Height;
    Result.Bottom := ListBoxVertDownButtonRect.Top;
    Result.Top := Result.Bottom - LFinalHeight;
  end;
  FSliderSize := Round((LVisibleHeight / LTotalHeight) * LSize);
end;

function TComboBoxStyleHook.ListBoxVertTrackRect: TRect;
begin
  Result := ListBoxVertScrollRect;
  if Result.Width > 0 then
  begin
    Result.Top := Result.Top + GetSystemMetrics(SM_CYVTHUMB);
    Result.Bottom := Result.Bottom - GetSystemMetrics(SM_CYVTHUMB);
  end
  else
    Result := TRect.Empty;
end;

function TComboBoxStyleHook.ListBoxVertTrackRectUp: TRect;
begin
  Result := ListBoxVertTrackRect;
  if (Result.Width > 0) and (ListBoxVertSliderRect.Height > 0) then
    Result.Bottom := ListBoxVertSliderRect.Top;
end;

function TComboBoxStyleHook.ListBoxVertTrackRectDown: TRect;
begin
  Result := ListBoxVertTrackRect;
  if (Result.Width > 0) and (ListBoxVertSliderRect.Height > 0) then
    Result.Top := ListBoxVertSliderRect.Bottom;
end;

procedure TComboBoxStyleHook.PaintListBoxBorder(Canvas: TCanvas; const R: TRect);
begin
  with Canvas do
  begin
    Brush.Color := StyleServices.GetSystemColor(clWindowFrame);
    FillRect(R);
  end;
end;

procedure TComboBoxStyleHook.DrawListBoxVertScroll(DC: HDC);
var
  B: TBitmap;
  Details: TThemedElementDetails;
  Canvas: TCanvas;
  R: TRect;
begin
  if GetWindowLong(FListHandle, GWL_STYLE) and WS_VSCROLL = 0 then
    Exit;
  Canvas := TCanvas.Create;
  try
    if DC <> 0 then
      Canvas.Handle := DC
    else
      Canvas.Handle := GetWindowDC(FListHandle);
    if ListBoxVertScrollRect.Width > 0 then
    begin
      B := TBitmap.Create;
      try
        B.Width := ListBoxVertScrollRect.Width;
        B.Height := ListBoxVertScrollRect.Height;
        MoveWindowOrg(B.Canvas.Handle, -ListBoxVertScrollRect.Left, -ListBoxVertScrollRect.Top);

        if StyleServices.Available then
        begin
          R := ListBoxVertScrollRect;
          R.Top := ListBoxVertUpButtonRect.Bottom;
          R.Bottom := ListBoxVertDownButtonRect.Top;
          if R.Height > 0 then
          begin
            Details := StyleServices.GetElementDetails(tsUpperTrackVertNormal);
            StyleServices.DrawElement(B.Canvas.Handle, Details, R);
          end;
          Details := StyleServices.GetElementDetails(FVSliderState);
          StyleServices.DrawElement(B.Canvas.Handle, Details, ListBoxVertSliderRect);
          Details := StyleServices.GetElementDetails(FVUpState);
          StyleServices.DrawElement(B.Canvas.Handle, Details, ListBoxVertUpButtonRect);
          Details := StyleServices.GetElementDetails(FVDownState);
          StyleServices.DrawElement(B.Canvas.Handle, Details, ListBoxVertDownButtonRect);
        end;

        MoveWindowOrg(B.Canvas.Handle, ListBoxVertScrollRect.Left, ListBoxVertScrollRect.Top);
        Canvas.Draw(ListBoxVertScrollRect.Left, ListBoxVertScrollRect.Top,  B);
      finally
        B.Free;
      end;
    end;
  finally
    if DC <> 0 then
      Canvas.Handle := 0
    else
    begin
      ReleaseDC(FListHandle, Canvas.Handle);
      Canvas.Handle := 0;
    end;
    Canvas.Free;
  end;
end;

procedure TComboBoxStyleHook.DrawListBoxBorder;
var
  R: TRect;
  Canvas: TCanvas;
  SaveIdx: Integer;
  P: TPoint;
begin
  Canvas := TCanvas.Create;
  try
    Canvas.Handle := GetWindowDC(FListHandle);
    P := Point(0, 0);
    ClientToScreen(FListHandle, P);
    GetWindowRect(FListHandle, R);
    P.X := P.X - R.Left;
    P.Y := P.Y - R.Top;
    if (R.Width < 5000) and (R.Height < 5000) then
    begin
      GetClientRect(FListHandle, R);
      ExcludeClipRect(Canvas.Handle, P.X, P.Y, R.Right - R.Left + P.X, R.Bottom - R.Top + P.Y);
      GetWindowRect(FListHandle, R);
      OffsetRect(R, -R.Left, -R.Top);
      SaveIdx := SaveDC(Canvas.Handle);
      try
        PaintListBoxBorder(Canvas, R);
      finally
        RestoreDC(Canvas.Handle, SaveIdx);
      end;
      DrawListBoxVertScroll(Canvas.Handle);
    end;
  finally
    ReleaseDC(FListHandle, Canvas.Handle);
    Canvas.Handle := 0;
    Canvas.Free;
  end;
end;

procedure TComboBoxStyleHook.ListBoxWndProc(var Msg: TMessage);
var
  MsgHandled: Boolean;

  procedure WMNCCalcSize(var Msg: TWMNCCalcSize);
  var
    LCalcSizeParams: PNCCalcSizeParams;
    LWindowPos: PWindowPos;
    LLeft, LRight, LTop, LBottom: Integer;
    LStyle, LNewStyle: Integer;
  begin
    LStyle := GetWindowLong(FListHandle, GWL_STYLE);
    if ((LStyle and WS_VSCROLL = WS_VSCROLL) or (LStyle and WS_HSCROLL = WS_HSCROLL)) then
    begin
      LNewStyle := LStyle and not WS_VSCROLL and not WS_HSCROLL;
      FIgnoreStyleChanged := True;
      SetWindowLong(FListHandle, GWL_STYLE, LNewStyle);
      Msg.Result := CallWindowProc(FDefListBoxProc, FListHandle,
        TMessage(Msg).Msg, TMessage(Msg).WParam, TMessage(Msg).LParam);
      SetWindowLong(FListHandle, GWL_STYLE, LStyle);
      FIgnoreStyleChanged := False;
    end
    else
      Msg.Result := CallWindowProc(FDefListBoxProc, FListHandle,
       TMessage(Msg).Msg, TMessage(Msg).WParam, TMessage(Msg).LParam);

    if (Msg.CalcValidRects) then
    begin
      LCalcSizeParams := Msg.CalcSize_Params;
      if Control.BiDiMode <> bdRightToLeft then
      begin
        LLeft := 1;
         if LStyle and WS_VSCROLL = WS_VSCROLL then
           LRight := ListBoxVertScrollRect.Width + 1
         else
          LRight := 1;
        end
      else
      begin
        LRight := 1;
        if LStyle and WS_VSCROLL = WS_VSCROLL then
         LLeft := ListBoxVertScrollRect.Width + 1
       else
         LLeft := 1;
      end;

      LTop := 1;
      LBottom := 1;
      LWindowPos := LCalcSizeParams.lppos;
      with LCalcSizeParams^.rgrc[0] do
      begin
        left := LWindowPos^.x;
        top := LWindowPos^.y;
        right := LWindowPos^.x + LWindowPos^.cx;
        bottom := LWindowPos^.y + LWindowPos^.cy;
        left := left + LLeft;
        top := top + LTop;
        right := right - LRight;
        bottom := bottom - LBottom;
      end;
      LCalcSizeParams^.rgrc[1] := LCalcSizeParams^.rgrc[0];
      Msg.CalcSize_Params := LCalcSizeParams;
      Msg.Result := WVR_VALIDRECTS;
    end;
    Msg.Result := 0;
    MsgHandled := True;
  end;

  procedure WMMouseWheel(var Msg: TWMMouseWheel);
  var
    Index: Integer;
    R: TRect;
  begin
    SendMessage(FListHandle, WM_SETREDRAW, 0, 0);
    Index := SendMessage(FListHandle, LB_GETTOPINDEX, 0, 0);
    if Msg.WheelDelta < 0 then
      Inc(Index)
    else
      Dec(Index);
    SendMessage(FListHandle, LB_SETTOPINDEX, Index, 0);
    SendMessage(FListHandle, WM_SETREDRAW, 1, 0);
    R := Rect(0, 0, ListBoxBoundsRect.Width, ListBoxBoundsRect.Height);
    RedrawWindow(FListHandle, @R, 0, RDW_INVALIDATE or RDW_ERASE);
    DrawListBoxVertScroll(0);
    MsgHandled := True;
  end;

  procedure WMNCLButtonDblClk(var Msg: TWMMouse);
  var
    R: TRect;
    P: TPoint;
  begin
    P := Point(Msg.XPos, Msg.YPos);
    if ListBoxVertScrollArea.Contains(P) then
    begin
      if ListBoxVertUpButtonRect.Contains(Point(Msg.XPos, Msg.YPos)) then
      begin
        SendMessage(FListHandle, WM_SETREDRAW, 0, 0);
        SendMessage(FListHandle, LB_SETTOPINDEX, SendMessage(FListHandle, LB_GETTOPINDEX, 0, 0) - 1, 0);
        SendMessage(FListHandle, WM_SETREDRAW, 1, 0);
        R := Rect(0, 0, ListBoxBoundsRect.Width, ListBoxBoundsRect.Height);
        RedrawWindow(FListHandle, @R, 0, RDW_INVALIDATE or RDW_ERASE);
        DrawListBoxVertScroll(0);
        Exit;
      end;

      if ListBoxVertDownButtonRect.Contains(Point(Msg.XPos, Msg.YPos)) then
      begin
        SendMessage(FListHandle, WM_SETREDRAW, 0, 0);
        SendMessage(FListHandle, LB_SETTOPINDEX, SendMessage(FListHandle, LB_GETTOPINDEX, 0, 0) + 1, 0);
        SendMessage(FListHandle, WM_SETREDRAW, 1, 0);
        R := Rect(0, 0, ListBoxBoundsRect.Width, ListBoxBoundsRect.Height);
        RedrawWindow(FListHandle, @R, 0, RDW_INVALIDATE or RDW_ERASE);
        DrawListBoxVertScroll(0);
        Exit;
      end;
    end;
    MsgHandled := True;
  end;

  procedure WMLButtonDown(var Msg: TWMMouse);
  var
    P: TPoint;
    R: TRect;
    ItemHeight, VisibleCount, TopIndex: Integer;
  begin
    MsgHandled := False;
    P := Point(Msg.XPos, Msg.YPos);
    if Control.BiDiMode = bdRightToLeft then P.X := - P.X;
    FDownPos := P;
    if ListBoxVertScrollArea.Contains(P) then
    begin
      if Style = csSimple then
        SetCapture(FListHandle);
      FDownPos := P;
      if ListBoxVertTrackRectUp.Contains(P) then
      begin
        ItemHeight := SendMessage(FListHandle, LB_GETITEMHEIGHT, 0, 0);
        if ItemHeight > 0 then
          VisibleCount := ListBoxClientRect.Height div ItemHeight
        else
          VisibleCount := 0;
        TopIndex := SendMessage(FListHandle, LB_GETTOPINDEX, 0, 0) - VisibleCount + 1;
        if TopIndex < 0 then TopIndex := 0;
        SendMessage(FListHandle, WM_SETREDRAW, 0, 0);
        SendMessage(FListHandle, LB_SETTOPINDEX, TopIndex, 0);
        SendMessage(FListHandle, WM_SETREDRAW, 1, 0);
        R := Rect(0, 0, ListBoxBoundsRect.Width, ListBoxBoundsRect.Height);
        RedrawWindow(FListHandle, @R, 0, RDW_INVALIDATE or RDW_ERASE);
        DrawListBoxVertScroll(0);
        ListBoxSetTimer(3);
      end
      else if ListBoxVertTrackRectDown.Contains(P) then
      begin
        ItemHeight := SendMessage(FListHandle, LB_GETITEMHEIGHT, 0, 0);
        if ItemHeight > 0 then
          VisibleCount := ListBoxClientRect.Height div ItemHeight
        else
          VisibleCount := 0;
        TopIndex := SendMessage(FListHandle, LB_GETTOPINDEX, 0, 0) + VisibleCount - 1;
        SendMessage(FListHandle, WM_SETREDRAW, 0, 0);
        SendMessage(FListHandle, LB_SETTOPINDEX, TopIndex, 0);
        SendMessage(FListHandle, WM_SETREDRAW, 1, 0);
        R := Rect(0, 0, ListBoxBoundsRect.Width, ListBoxBoundsRect.Height);
        RedrawWindow(FListHandle, @R, 0, RDW_INVALIDATE or RDW_ERASE);
        DrawListBoxVertScroll(0);
        ListBoxSetTimer(4);
      end
      else if ListBoxVertSliderRect.Contains(P) then
      begin
        FVSliderState := tsThumbBtnVertPressed;
        FDownSliderPos := FDownPos.Y - ListBoxVertSliderRect.Top;
        DrawListBoxVertScroll(0);
      end
      else if ListBoxVertDownButtonRect.Contains(P) then
      begin
        FListBoxDownBtnDown := True;
        FVDownState := tsArrowBtnDownPressed;
        DrawListBoxVertScroll(0);

        SendMessage(FListHandle, WM_SETREDRAW, 0, 0);
        SendMessage(FListHandle, LB_SETTOPINDEX, SendMessage(FListHandle, LB_GETTOPINDEX, 0, 0) + 1, 0);
        SendMessage(FListHandle, WM_SETREDRAW, 1, 0);
        R := Rect(0, 0, ListBoxBoundsRect.Width, ListBoxBoundsRect.Height);
        RedrawWindow(FListHandle, @R, 0, RDW_INVALIDATE or RDW_ERASE);

        ListBoxSetTimer(2);
      end
      else if ListBoxVertUpButtonRect.Contains(P) then
      begin
        FListBoxUpBtnDown := True;
        FVUpState := tsArrowBtnUpPressed;
        DrawListBoxVertScroll(0);

        SendMessage(FListHandle, WM_SETREDRAW, 0, 0);
        SendMessage(FListHandle, LB_SETTOPINDEX, SendMessage(FListHandle, LB_GETTOPINDEX, 0, 0) - 1, 0);
        SendMessage(FListHandle, WM_SETREDRAW, 1, 0);
        R := Rect(0, 0, ListBoxBoundsRect.Width, ListBoxBoundsRect.Height);
        RedrawWindow(FListHandle, @R, 0, RDW_INVALIDATE or RDW_ERASE);

        ListBoxSetTimer(1);
      end;
      MsgHandled := True;
    end
    else
    begin
      if (FVSliderState <> tsThumbBtnVertNormal) or
         (FVUpState <> tsArrowBtnUpNormal) or (FVDownState <> tsArrowBtnDownNormal) then
      begin
        FVSliderState := tsArrowBtnUpNormal;
        FVUpState := tsArrowBtnUpNormal;
        FVDownState := tsArrowBtnDownNormal;
        DrawListBoxVertScroll(0);
      end;
    end;
    FOldIdx := SendMessage(FListHandle, LB_GETTOPINDEX, 0, 0);
  end;

  procedure WMMouseMove(var Msg: TWMMouse);
  var
    P: TPoint;
    NewIndex, Index: Integer;
    Dist: Integer;
    R: TRect;
  begin
    P := Point(Msg.XPos, Msg.YPos);
    if Control.BiDiMode = bdRightToLeft then
      P.X := - P.X;

    FMovePos := P;
    if (FVSliderState = tsThumbBtnVertPressed) then
    begin
      Index := SendMessage(FListHandle, LB_GETTOPINDEX, 0, 0);
      Dist := (ListBoxVertScrollRect.Height - ListBoxVertUpButtonRect.Height - ListBoxVertDownButtonRect.Height - ListBoxVertSliderRect.Height);
      if Dist > 0 then
      begin
        NewIndex := round((((FMovePos.y - FDownSliderPos - ListBoxVertUpButtonRect.Bottom) / Dist) * FInvsibleCount));
        if NewIndex <> Index then
        begin
          if NewIndex < 0 then NewIndex := 0;
          if NewIndex >= SendMessage(FListHandle, LB_GETCOUNT, 0, 0) then NewIndex := SendMessage(FListHandle, LB_GETCOUNT, 0, 0) - 1;
          SendMessage(FListHandle, WM_SETREDRAW, 0, 0);
          SendMessage(FListHandle, LB_SETTOPINDEX, NewIndex, 0);
          SendMessage(FListHandle, WM_SETREDRAW, 1, 0);
          R := Rect(0, 0, ListBoxBoundsRect.Width, ListBoxBoundsRect.Height);
          RedrawWindow(FListHandle, @R, 0, RDW_INVALIDATE or RDW_ERASE);
          DrawListBoxVertScroll(0);
        end;
      end;
      MsgHandled := True;
      Exit;
    end;

    if FListBoxUpBtnDown and not ListBoxVertUpButtonRect.Contains(P) and (FVUpState = tsArrowBtnUpPressed)
    then
    begin
      FVUpState := tsArrowBtnUpNormal;
      DrawListBoxVertScroll(0);
      ListBoxStopTimer;
      Exit;
    end;

    if FListBoxUpBtnDown and ListBoxVertUpButtonRect.Contains(P) and (FVUpState = tsArrowBtnUpNormal)
    then
    begin
      FVUpState := tsArrowBtnUpPressed;
      DrawListBoxVertScroll(0);
      ListBoxSetTimer(5);
      Exit;
    end;

    if FListBoxDownBtnDown and not ListBoxVertDownButtonRect.Contains(P) and (FVDownState = tsArrowBtnDownPressed)
    then
    begin
      FVDownState := tsArrowBtnDownNormal;
      DrawListBoxVertScroll(0);
      ListBoxStopTimer;
      Exit;
    end;

    if FListBoxDownBtnDown and ListBoxVertDownButtonRect.Contains(P) and (FVDownState = tsArrowBtnDownNormal)
    then
    begin
      FVDownState := tsArrowBtnDownPressed;
      DrawListBoxVertScroll(0);
      ListBoxSetTimer(6);
      Exit;
    end;

    if ListBoxVertScrollArea.Contains(P) then
    begin
      if ListBoxVertSliderRect.Contains(P) and (FVSliderState = tsThumbBtnVertNormal) then
      begin
        FVSliderState := tsThumbBtnVertHot;
        DrawListBoxVertScroll(0);
      end
      else if not ListBoxVertSliderRect.Contains(P) and (FVSliderState = tsThumbBtnVertHot) then
      begin
        FVSliderState := tsThumbBtnVertNormal;
        DrawListBoxVertScroll(0);
      end
      else if ListBoxVertUpButtonRect.Contains(P) and (FVUpState = tsArrowBtnUpNormal) then
      begin
        FVUpState := tsArrowBtnUpHot;
        DrawListBoxVertScroll(0);
      end
      else if not ListBoxVertUpButtonRect.Contains(P) and (FVUpState = tsArrowBtnUpHot) then
      begin
        FVUpState := tsArrowBtnUpNormal;
        DrawListBoxVertScroll(0);
      end
      else if ListBoxVertDownButtonRect.Contains(P) and (FVDownState = tsArrowBtnDownNormal) then
      begin
        FVDownState :=  tsArrowBtnDownHot;
        DrawListBoxVertScroll(0);
      end
      else if not ListBoxVertDownButtonRect.Contains(P) and (FVDownState =  tsArrowBtnDownHot) then
      begin
        FVDownState :=  tsArrowBtnDownNormal;
        DrawListBoxVertScroll(0);
      end;
      MsgHandled := True;
    end
    else
    begin
      if (FVSliderState <> tsThumbBtnVertNormal) or (FVUpState <> tsArrowBtnUpNormal) or
         (FVUpState <> tsArrowBtnDownNormal) then
      begin
        if FListBoxTimerCode <> 0 then ListBoxStopTimer;
        FVSliderState := tsThumbBtnVertNormal;
        FVUpState := tsArrowBtnUpNormal;
        FVDownState := tsArrowBtnDownNormal;
        DrawListBoxVertScroll(0);
      end;
    end;
  end;

  procedure WMLButtonUp(var Msg: TWMMouse);
  var
    P: TPoint;
  begin
    FListBoxUpBtnDown := False;
    FListBoxDownBtnDown := False;
    FListBoxTrackUpDown := False;
    FListBoxTrackDownDown := False;

    P := Point(Msg.XPos, Msg.YPos);
    if Control.BiDiMode = bdRightToLeft then P.X := - P.X;

    if (Style = csSimple) and ListBoxVertScrollArea.Contains(FDownPos)
    then
      ReleaseCapture;


    if ListBoxVertSliderRect.Contains(P) then
      FVSliderState := tsThumbBtnVertHot
    else
      FVSliderState := tsThumbBtnVertNormal;

    if ListBoxVertUpButtonRect.Contains(P) then
      FVUpState := tsArrowBtnUpHot
    else
      FVUpState := tsArrowBtnUpNormal;

    if ListBoxVertDownButtonRect.Contains(P) then
      FVDownState := tsArrowBtnDownHot
    else
      FVDownState := tsArrowBtnDownNormal;

    DrawListBoxVertScroll(0);

    if FListBoxTimerCode <> 0 then
      ListBoxStopTimer;

    MsgHandled := ListBoxVertScrollArea.Contains(P);
  end;

  procedure WMNCLButtonDown(var Msg: TWMMouse);
  var
    P: TPoint;
  begin
    if Style <> csSimple then
      SetCapture(FListHandle);
    P := Point(Msg.XPos, Msg.YPos);
    ScreenToClient(FListHandle, P);
    with P do
    begin
      Msg.XPos := X;
      Msg.YPos := Y;
    end;
    WMLButtonDown(Msg);
    MsgHandled := True;
  end;

  procedure WMPrint(var Msg: TMessage);
  var
    SaveIndex: Integer;
    Canvas: TCanvas;
    R: TRect;
  begin
    Msg.Result := CallWindowProc(FDefListBoxProc, FListHandle, Msg.Msg, Msg.WParam, Msg.LParam);

    if (Msg.LParam and PRF_NONCLIENT = PRF_NONCLIENT) and
       (Msg.wParam > 0) then
    begin
      SaveIndex := 0;
      Canvas := TCanvas.Create;
      try
        SaveIndex := SaveDC(Msg.WParam);
        Canvas.Handle := Msg.WParam;
        GetWindowRect(FListHandle, R);
        OffsetRect(R, -R.Left, -R.Top);
        ExcludeClipRect(Canvas.Handle, R.Left + 2, R.Top + 2, R.Right - 2, R.Bottom - 2);
        PaintListBoxBorder(Canvas, R);
      finally
        if SaveIndex <> 0 then
          RestoreDC(Canvas.Handle, SaveIndex);
        Canvas.Handle := 0;
        Canvas.Free;
      end;
      DrawListBoxVertScroll(Msg.wParam);
    end;
    MsgHandled := True;
  end;

  procedure WMTimer(var Msg: TMessage);
  var
    R: TRect;
    ItemHeight, VisibleCount, TopIndex: Integer;
  begin
    case FListBoxTimerCode of
      1: ListBoxSetTimer(5);
      2: ListBoxSetTimer(6);
      3: ListBoxSetTimer(7);
      4: ListBoxSetTimer(8);
      5:
        begin
          SendMessage(FListHandle, WM_SETREDRAW, 0, 0);
          SendMessage(FListHandle, LB_SETTOPINDEX,
            SendMessage(FListHandle, LB_GETTOPINDEX, 0, 0) - 1, 0);
          SendMessage(FListHandle, WM_SETREDRAW, 1, 0);
          R := Rect(0, 0, ListBoxBoundsRect.Width, ListBoxBoundsRect.Height);
          RedrawWindow(FListHandle, @R, 0, RDW_INVALIDATE or RDW_ERASE);
          DrawListBoxVertScroll(0);
        end;
      6:
        begin
          SendMessage(FListHandle, WM_SETREDRAW, 0, 0);
          SendMessage(FListHandle, LB_SETTOPINDEX,
            SendMessage(FListHandle, LB_GETTOPINDEX, 0, 0) + 1, 0);
          SendMessage(FListHandle, WM_SETREDRAW, 1, 0);
          R := Rect(0, 0, ListBoxBoundsRect.Width, ListBoxBoundsRect.Height);
          RedrawWindow(FListHandle, @R, 0, RDW_INVALIDATE or RDW_ERASE);
          DrawListBoxVertScroll(0);
        end;
      7:
        begin
          if ListBoxVertSliderRect.Contains(FMovePos) or (FMovePos.Y > ListBoxVertSliderRect.Bottom) then
          begin
            ListBoxStopTimer;
            Exit;
          end;
          ItemHeight := SendMessage(FListHandle, LB_GETITEMHEIGHT, 0, 0);
          if ItemHeight > 0 then
            VisibleCount := ListBoxClientRect.Height div ItemHeight
          else
            VisibleCount := 0;
          TopIndex := SendMessage(FListHandle, LB_GETTOPINDEX, 0, 0) - VisibleCount + 1;
          if TopIndex < 0 then TopIndex := 0;
          SendMessage(FListHandle, WM_SETREDRAW, 0, 0);
          SendMessage(FListHandle, LB_SETTOPINDEX, TopIndex, 0);
          SendMessage(FListHandle, WM_SETREDRAW, 1, 0);
          R := Rect(0, 0, ListBoxBoundsRect.Width, ListBoxBoundsRect.Height);
          RedrawWindow(FListHandle, @R, 0, RDW_INVALIDATE or RDW_ERASE);
          DrawListBoxVertScroll(0);
        end;
      8:
        begin
          if ListBoxVertSliderRect.Contains(FMovePos) or (FMovePos.Y < ListBoxVertSliderRect.Top) then
          begin
            ListBoxStopTimer;
            Exit;
          end;
          ItemHeight := SendMessage(FListHandle, LB_GETITEMHEIGHT, 0, 0);
          if ItemHeight > 0 then
            VisibleCount := ListBoxClientRect.Height div ItemHeight
          else
            VisibleCount := 0;
          TopIndex := SendMessage(FListHandle, LB_GETTOPINDEX, 0, 0) + VisibleCount - 1;
          SendMessage(FListHandle, WM_SETREDRAW, 0, 0);
          SendMessage(FListHandle, LB_SETTOPINDEX, TopIndex, 0);
          SendMessage(FListHandle, WM_SETREDRAW, 1, 0);
          R := Rect(0, 0, ListBoxBoundsRect.Width, ListBoxBoundsRect.Height);
          RedrawWindow(FListHandle, @R, 0, RDW_INVALIDATE or RDW_ERASE);
          DrawListBoxVertScroll(0);
        end;
    end;
  end;

begin
  MsgHandled := False;
  if ListBoxVertScrollArea.Height = 0 then
  begin
    case Msg.Msg of
      WM_NCCALCSIZE:
        WMNCCalcSize(TWMNCCalcSize(Msg));
      WM_NCPAINT:
         begin
           DrawListBoxBorder;
           MsgHandled := True;
         end;
    end;
  end
  else
    case Msg.Msg of
      WM_NCHITTEST:
        if Style = csSimple then
        begin
          Msg.Result := HTCLIENT;
          MsgHandled := True;
        end;
      WM_MOUSELEAVE, WM_NCMOUSELEAVE:
        if Style = csSimple then
        begin
          FVSliderState := tsThumbBtnVertNormal;
          FVUpState := tsArrowBtnUpNormal;
          FVDownState := tsArrowBtnDownNormal;
          DrawListBoxVertScroll(0);
        end;
      WM_TIMER: WMTimer(Msg);
      WM_UpdateUIState: MsgHandled := True;
      WM_NCCALCSIZE: WMNCCalcSize(TWMNCCalcSize(Msg));
      WM_MOUSEWHEEL: WMMouseWheel(TWMMouseWheel(Msg));
      WM_NCLButtonDblClk: WMNCLButtonDblClk(TWMMouse(Msg));
      WM_LButtonDown: WMLButtonDown(TWMMouse(Msg));
      WM_MOUSEMOVE: WMMouseMove(TWMMouse(Msg));
      WM_LBUTTONUP: WMLButtonUp(TWMMouse(Msg));
      WM_NCLButtonDown: WMNCLButtonDown(TWMMouse(Msg));
      WM_NCLButtonUp, WM_NCMouseMove: MsgHandled := True;
      WM_PRINT: WMPrint(Msg);
      WM_KEYDOWN, WM_KEYUP:
        begin
          Msg.Result := CallWindowProc(FDefListBoxProc, FListHandle,
            Msg.Msg, Msg.WParam, Msg.LParam);
          DrawListBoxVertScroll(0);
          MsgHandled := True;
        end;
      WM_NCPAINT:
       begin
         DrawListBoxBorder;
         DrawListBoxVertScroll(0);
         MsgHandled := True;
       end;
      LB_SETTOPINDEX:
        begin
          Msg.Result := CallWindowProc(FDefListBoxProc, FListHandle,
            Msg.Msg, Msg.WParam, Msg.LParam);
          DrawListBoxVertScroll(0);
          MsgHandled := True;
        end;
      WM_STYLECHANGED, WM_STYLECHANGING:
       if FIgnoreStyleChanged then
       begin
         Msg.Result := 0;
         MsgHandled := True;
       end;
    end;
  if not MsgHandled then
    Msg.Result := CallWindowProc(FDefListBoxProc, FListHandle,
      Msg.Msg, Msg.WParam, Msg.LParam);
end;

{ TListBoxStyleHook }

constructor TListBoxStyleHook.Create(AControl: TWinControl);
begin
  inherited;
  OverrideEraseBkgnd := True;
  UpdateColors;
end;

procedure TListBoxStyleHook.WMSetFocus(var Message: TMessage);
begin
  inherited;
  CallDefaultProc(Message);
  RedrawWindow(Handle, nil, 0, RDW_INVALIDATE or RDW_UPDATENOW);
  Handled := True;
end;

procedure TListBoxStyleHook.WndProc(var Message: TMessage);
begin
  case Message.Msg of
    CN_CTLCOLORMSGBOX..CN_CTLCOLORSTATIC:
      begin
        SetTextColor(Message.WParam, ColorToRGB(FontColor));
        SetBkColor(Message.WParam, ColorToRGB(Brush.Color));
        Message.Result := LRESULT(Brush.Handle);
        Handled := True;
      end;
    CM_ENABLEDCHANGED:
      begin
        UpdateColors;
        Handled := False; // Allow control to handle message
      end
  else
    inherited WndProc(Message);
  end;
end;

procedure TListBoxStyleHook.UpdateColors;
const
  ColorStates: array[Boolean] of TStyleColor = (scListBoxDisabled, scListBox);
  FontColorStates: array[Boolean] of TStyleFont = (sfListItemTextDisabled, sfListItemTextNormal);
var
  LStyle: TCustomStyleServices;
begin
  LStyle := StyleServices;
  Brush.Color := LStyle.GetStyleColor(ColorStates[Control.Enabled]);
  if seFont in Control.StyleElements then
    FontColor := LStyle.GetStyleFontColor(FontColorStates[Control.Enabled])
  else
    FontColor := TWinControlClass(Control).Font.Color;
end;

procedure TListBoxStyleHook.WMKillFocus(var Message: TMessage);
begin
  inherited;
  CallDefaultProc(Message);
  RedrawWindow(Handle, nil, 0, RDW_INVALIDATE or RDW_UPDATENOW);
  Handled := True;
end;

{ TButtonStyleHook }

procedure ClearAlpha(B: TBitmap);
type
  PRGBA = ^TRGBA;
  TRGBA = packed record
    case Cardinal of
      0: (Color: Cardinal);
      2: (HiWord, LoWord: Word);
      3: (B, G, R, A: Byte);
    end;
  PRGBAArray = ^TRGBAArray;
  TRGBAArray = array[0..0] of TRGBA;
var
  I: Integer;
begin
  for I := 0 to B.Width * B.Height do
    PRGBAArray(B.Scanline[B.Height - 1])[I].A := 255;
end;

constructor TButtonStyleHook.Create;
begin
  inherited;
  OverridePaint := True;
  OverrideEraseBkgnd := True;
  DoubleBuffered := True;
  FDropDown := False;
  FOldMouseInControl := False;
end;

function TButtonStyleHook.AnimationEnabled: Boolean;
begin
  Result := TStyleManager.AnimationOnControls and Control.Visible and
    (seClient in Control.StyleElements) and CheckWin32Version(6, 0);
end;

function TButtonStyleHook.StartAnimation;
var
  FromDC, ToDC: HDC;
  P: TBPAnimationParams;
  R: TRect;
  Animation: HANIMATIONBUFFER;
  FRendering: Boolean;
begin
  Result := False;
  if not AnimationEnabled then Exit;
  FillChar(P, SizeOf(P), #0);
  P.cbSize := SizeOf(P);
  P.style := BPAS_LINEAR;
  if FOldMouseInControl <> MouseInControl then
    P.dwDuration := 200;
  R := Control.ClientRect;
  Animation := BeginBufferedAnimation(Handle, ADC, R,
    BPBF_COMPATIBLEBITMAP, nil, P, FromDC, ToDC);
  if Animation <> 0 then
  begin
    Result := True;
    FRendering := P.dwDuration > 0;
    if FromDC <> 0 then
      PrepareAnimationDC(FromDC, not MouseInControl, FRendering);
    if ToDC <> 0 then
      PrepareAnimationDC(ToDC, MouseInControl, FRendering);
    EndBufferedAnimation(Animation, True);
  end;
  FOldMouseInControl := MouseInControl;
end;

procedure TButtonStyleHook.PaintBackground(Canvas: TCanvas);
var
  Details:  TThemedElementDetails;
begin
  if StyleServices.Available then
  begin
    Details.Element := teButton;
    if StyleServices.HasTransparentParts(Details) then
        StyleServices.DrawParentBackground(Handle, Canvas.Handle, Details, False);
  end;
end;

procedure TButtonStyleHook.PrepareAnimationDC(ADC: HDC; AMouseInControl: Boolean; ARendering: Boolean);
var
  FBuffer: TBitmap;
  BF: TBlendFunction;
  DstRect, SrcRect: TRect;
  FCanvas: TCanvas;
begin
  if Control.Width * Control.Height = 0 then Exit;

  if not ARendering then
  begin
    FCanvas := TCanvas.Create;
    FCanvas.Handle := ADC;
    try
      PaintBackground(FCanvas);
      DrawButton(FCanvas, AMouseInControl);
    finally
      FCanvas.Handle := 0;
      FCanvas.Free;
    end;
    Exit;
  end;

  FBuffer := TBitmap.Create;
  FBuffer.PixelFormat := pf32bit;
  FBuffer.SetSize(Control.Width, Control.Height);
  try
    PaintBackground(FBuffer.Canvas);
    DrawButton(FBuffer.Canvas, AMouseInControl);

    ClearAlpha(FBuffer);
    BF.BlendOp := AC_SRC_OVER;
    BF.BlendFlags := 0;
    BF.SourceConstantAlpha := 255;
    BF.AlphaFormat := AC_SRC_ALPHA;
    DstRect := Rect(0, 0, FBuffer.Width, FBuffer.Height);
    SrcRect := DstRect;
    Winapi.Windows.AlphaBlend(ADC,
      DstRect.Left, DstRect.Top, DstRect.Right - DstRect.Left, DstRect.Bottom - DstRect.Top,
      FBuffer.Canvas.Handle,
      SrcRect.Left, SrcRect.Top, SrcRect.Right - SrcRect.Left, SrcRect.Bottom - SrcRect.Top,
      BF);
  finally
    FBuffer.Free;
  end;
end;

procedure TButtonStyleHook.DrawButton(ACanvas: TCanvas; AMouseInControl: Boolean);
var
  Details:  TThemedElementDetails;
  DrawRect: TRect;
  IL: BUTTON_IMAGELIST;
  IW, IH, IX, IY: Integer;
  TextFormat: TTextFormatFlags;
  ThemeTextColor: TColor;
  Buffer: string;
  BufferLength: Integer;
  SaveIndex: Integer;
  X, Y, I, ImgIndex: Integer;
  BCaption: String;
begin
  BCaption := Text;
  ImgIndex := 0;
  if not Control.Enabled then
  begin
    Details := StyleServices.GetElementDetails(tbPushButtonDisabled);
    ImgIndex := 3;
  end
  else
  if FPressed then
  begin
    Details := StyleServices.GetElementDetails(tbPushButtonPressed);
    ImgIndex := 2;
  end
  else if AMouseInControl then
  begin
    Details := StyleServices.GetElementDetails(tbPushButtonHot);
    ImgIndex := 1;
  end
  else if Focused then
  begin
    Details := StyleServices.GetElementDetails(tbPushButtonDefaulted);
    ImgIndex := 4;
  end
  else if Control.Enabled then
    Details := StyleServices.GetElementDetails(tbPushButtonNormal);

  DrawRect := Control.ClientRect;
  StyleServices.DrawElement(ACanvas.Handle, Details, DrawRect);

  if Button_GetImageList(handle, IL) and (IL.himl <> 0) and
     ImageList_GetIconSize(IL.himl, IW, IH) then
  begin
    IX := DrawRect.Left + 2;
    IY := DrawRect.Top + (DrawRect.Height - IH) div 2;
    if (GetWindowLong(Handle, GWL_STYLE) and BS_COMMANDLINK) = BS_COMMANDLINK then
      IY := DrawRect.Top + 15
    else
    if Control is TCustomButton then
      with TCustomButton(Control) do
       case ImageAlignment of
          iaLeft:
            begin
              IX := DrawRect.Left + 2;
              Inc(IX, ImageMargins.Left);
              Inc(IY, ImageMargins.Top);
              Dec(IY, ImageMargins.Bottom);
              Inc(DrawRect.Left, IX + IW + ImageMargins.Right);
            end;
          iaRight:
            begin
              IX := DrawRect.Right - IW - 2;
              Dec(IX, ImageMargins.Right);
              Dec(IX, ImageMargins.Left);
              Inc(IY, ImageMargins.Top);
              Dec(IY, ImageMargins.Bottom);
              DrawRect.Right := IX;
            end;
          iaTop:
            begin
              IX := DrawRect.Left + (DrawRect.Width - IW) div 2;
              Inc(IX, ImageMargins.Left);
              Dec(IX, ImageMargins.Right);
              IY := DrawRect.Top + 2;
              Inc(IY, ImageMargins.Top);
              Inc(DrawRect.Top, IY + IH + ImageMargins.Bottom);
            end;
          iaBottom:
            begin
              IX := DrawRect.Left + (DrawRect.Width - IW) div 2;
              Inc(IX, ImageMargins.Left);
              Dec(IX, ImageMargins.Right);
              IY := DrawRect.Bottom - IH - 2;
              Dec(IY, ImageMargins.Bottom);
              Dec(IY, ImageMargins.Top);
              DrawRect.Bottom := IY;
            end;
        end;
    ImageList_Draw(IL.himl, ImgIndex, ACanvas.Handle, IX, IY, ILD_NORMAL);
  end;
  if (GetWindowLong(Handle, GWL_STYLE) and BS_COMMANDLINK) = BS_COMMANDLINK then
  begin
    if IL.himl = 0 then
    Inc(DrawRect.Left, 35);
    Inc(DrawRect.Top, 15);
    Inc(DrawRect.Left, 5);
    ACanvas.Font := TCustomButton(Control).Font;
    ACanvas.Font.Style := [];
    ACanvas.Font.Size := 12;
    TextFormat := TTextFormatFlags(DT_LEFT);
    if (seFont in Control.StyleElements) and StyleServices.GetElementColor(Details, ecTextColor, ThemeTextColor) then
       ACanvas.Font.Color := ThemeTextColor;
    StyleServices.DrawText(ACanvas.Handle, Details, BCaption, DrawRect, TextFormat, ACanvas.Font.Color);
    SetLength(Buffer, Button_GetNoteLength(Handle) + 1);
    if Length(Buffer) <> 0 then
    begin
      BufferLength := Length(Buffer);
      if Button_GetNote(Handle, PChar(Buffer), BufferLength) then
      begin
        TextFormat := TTextFormatFlags(DT_LEFT or DT_WORDBREAK);
        Inc(DrawRect.Top, ACanvas.TextHeight('Wq') + 2);
        ACanvas.Font.Size := 8;
        StyleServices.DrawText(ACanvas.Handle, Details, Buffer, DrawRect,
        TextFormat, ACanvas.Font.Color);
      end;
    end;
    if IL.himl = 0 then
    begin
      if FPressed then
        Details := StyleServices.GetElementDetails(tbCommandLinkGlyphPressed)
      else if AMouseInControl then
        Details := StyleServices.GetElementDetails(tbCommandLinkGlyphHot)
      else if Control.Enabled then
        Details := StyleServices.GetElementDetails(tbCommandLinkGlyphNormal)
      else
        Details := StyleServices.GetElementDetails(tbCommandLinkGlyphDisabled);
      DrawRect.Right := 35;
      DrawRect.Left := 3;
      DrawRect.Top := 10;
      DrawRect.Bottom := DrawRect.Top + 32;
      StyleServices.DrawElement(ACanvas.Handle, Details, DrawRect);
     end;
  end
  else
    if (GetWindowLong(Handle, GWL_STYLE) and BS_SPLITBUTTON) = BS_SPLITBUTTON then
    begin
      Dec(DrawRect.Right, 15);
      DrawControlText(ACanvas, Details, Text, DrawRect, DT_VCENTER or DT_CENTER);
      if FDropDown then
      begin
        Details := StyleServices.GetElementDetails(tbPushButtonPressed);
        SaveIndex := SaveDC(ACanvas.Handle);
        try
          IntersectClipRect(ACanvas.Handle, Control.Width - 15, 0,
            Control.Width, Control.Height);
          DrawRect := Rect(Control.Width - 30, 0, Control.Width, Control.Height);
          StyleServices.DrawElement(ACanvas.Handle, Details, DrawRect);
        finally
          RestoreDC(ACanvas.Handle, SaveIndex);
        end;
      end;
      with ACanvas do
      begin
        // draw split line
        Pen.Color := StyleServices.GetSystemColor(clBtnShadow);
        MoveTo(Control.Width - 15, 3);
        LineTo(Control.Width - 15, Control.Height - 3);
        if Control.Enabled then
          Pen.Color := StyleServices.GetSystemColor(clBtnHighLight)
        else
          Pen.Color := Font.Color;
        MoveTo(Control.Width - 14, 3);
        LineTo(Control.Width - 14, Control.Height - 3);
        // draw arrow
        Pen.Color := Font.Color;
        X := Control.Width - 8;
        Y := Control.Height div 2 + 1;
        for i := 3 downto 0 do
        begin
          MoveTo(X - I, Y - I);
          LineTo(X + I + 1, Y - I);
        end;
      end;
    end
    else
      if (Control is TCustomButton) and TCustomButton(Control).WordWrap then
        DrawControlText(ACanvas, Details, BCaption, DrawRect, DT_VCENTER or DT_CENTER or DT_WORDBREAK)
      else
        DrawControlText(ACanvas, Details, BCaption, DrawRect, DT_VCENTER or DT_CENTER);
end;


function TButtonStyleHook.InternalPaint(ADC: HDC): Boolean;
begin
  if not AnimationEnabled or FPressed or FDropDown or not Control.Enabled then
  begin
    Result := False;
    Exit;
  end;
  Result := True;
  if not BufferedPaintRenderAnimation(Handle, ADC) then StartAnimation(ADC);
end;

procedure TButtonStyleHook.Paint(Canvas: TCanvas);
begin
  DrawButton(Canvas, MouseInControl);
end;

procedure TButtonStyleHook.DoClick;
var
  Msg: TMessage;
begin
  TWMCommand(Msg).NotifyCode := BN_CLICKED;
  TWMCommand(Msg).ItemID := Word(GetDlgCtrlID(Handle));
  TWMCommand(Msg).Ctl := Handle;
  SendMessage(Control.Parent.Handle, WM_COMMAND, Msg.WParam, Msg.LParam);
end;

procedure TButtonStyleHook.WMSetFocus(var Message: TMessage);
begin
  inherited;
  SetRedraw(False);
  CallDefaultProc(TMessage(Message));
  SetRedraw(True);
  Invalidate;
  Handled := True;
end;

procedure TButtonStyleHook.WndProc(var Message: TMessage);
var
  FStopRedraw: Boolean;
begin
  // Reserved for potential updates
 FStopRedraw := False;
 if AnimationEnabled then
   case Message.Msg of
     CM_ENABLEDCHANGED:
       begin
         BufferedPaintStopAllAnimations(Handle);
         FStopRedraw := True;
         SetRedraw(False);
       end;
     WM_SIZE, CM_FOCUSCHANGED,
     WM_LBUTTONDOWN..WM_RBUTTONDOWN:
       begin
         BufferedPaintStopAllAnimations(Handle);
       end;
   end;
 inherited;
 case Message.Msg of
   CM_ENABLEDCHANGED:
     begin
       if FStopRedraw then SetRedraw(True);
       if Control.HandleAllocated and IsWindowVisible(Handle) then
         RedrawWindow(Handle, nil, 0, RDW_INVALIDATE or RDW_UPDATENOW);
     end;
   CM_TEXTCHANGED:
      begin
        if Control.HandleAllocated and IsWindowVisible(Handle) then
          RedrawWindow(Handle, nil, 0, RDW_INVALIDATE or RDW_UPDATENOW);
      end;
   CM_FOCUSCHANGED:
     if AnimationEnabled then
     begin
       if Control.HandleAllocated and IsWindowVisible(Handle) then
          RedrawWindow(Handle, nil, 0, RDW_INVALIDATE or RDW_UPDATENOW);
     end;
  end;
end;

procedure TButtonStyleHook.WMKillFocus(var Message: TMessage);
begin
  inherited;
  SetRedraw(False);
  CallDefaultProc(TMessage(Message));
  SetRedraw(True);
  Invalidate;
  Handled := True;
end;

procedure TButtonStyleHook.WMKeyDown(var Message: TMessage);
begin
  if Message.WParam = VK_SPACE then
  begin
    FPressed := True;
    MouseInControl := True;
    Invalidate;
  end;
end;

procedure TButtonStyleHook.WMKeyUp(var Message: TMessage);
var
  P: TPoint;
begin
  if Message.WParam = VK_SPACE then
  begin
    FPressed := False;
    P := Mouse.CursorPos;
    MouseInControl := WindowFromPoint(P) = Handle;
    Invalidate;
  end;
end;

procedure TButtonStyleHook.CNNotify(var Message: TWMNotify);
begin
  if Message.NMHdr.code = BCN_DROPDOWN then
  begin
    FDropDown := True;
    SetRedraw(True);
    RedrawWindow(Handle, nil, 0, RDW_INVALIDATE or RDW_UPDATENOW);
    SetRedraw(False);
    CallDefaultProc(TMessage(Message));
    SetRedraw(True);
    FDropDown := False;
    Invalidate;
    Handled := True;
  end;
end;

procedure TButtonStyleHook.WMLButtonDblClk(var Message: TWMMouse);
begin
  WMLButtonDown(Message);
  Handled := True;
end;

procedure TButtonStyleHook.WMLButtonDown(var Message: TWMMouse);
begin
  if TButtonControl(Control).DragMode = dmAutomatic then
  begin
    SetRedraw(False);
    CallDefaultProc(TMessage(Message));
    SetRedraw(True);
    Handled := True;
  end
  else
  if ((GetWindowLong(Handle, GWL_STYLE) and BS_SPLITBUTTON) = BS_SPLITBUTTON) and
     (Message.XPos >= Control.Width - 15) and (TCustomButton(Control).DropDownMenu <> nil)
  then
    begin
      Handled := False;
    end
  else
    begin
      SetFocus(Handle);
      SetCapture(Handle);
      FPressed := True;
      FMouseDown := True;
      Handled := False;
    end;
  Invalidate;
end;

procedure TButtonStyleHook.WMLButtonUp(var Message: TWMMouse);
begin
  if TButtonControl(Control).DragMode <> dmAutomatic then
    ReleaseCapture;
  FMouseDown := False;
  if FPressed then
  begin
    FPressed := False;
    Invalidate;
    DoClick;
  end;
end;

procedure TButtonStyleHook.WMMouseMove(var Message: TWMMouse);
var
  NewPressed: Boolean;
begin
  inherited;
  CallDefaultProc(TMessage(Message));
  if FMouseDown then
  begin
    NewPressed := IsMouseInControl;
    if NewPressed <> FPressed then
    begin
      FPressed := NewPressed;
      Invalidate;
    end;
  end;
  Handled := True;
end;

procedure TButtonStyleHook.MouseEnter;
begin
  inherited;
  Invalidate;
  Handled := True;
end;

procedure TButtonStyleHook.MouseLeave;
begin
  inherited;
  Invalidate;
  Handled := True;
end;

{ TCheckBoxStyleHook }

                                
function RectVCenter(var R: TRect; Bounds: TRect): TRect;
begin
  OffsetRect(R, -R.Left, -R.Top);
  OffsetRect(R, 0, (Bounds.Height - R.Height) div 2);
  OffsetRect(R, Bounds.Left, Bounds.Top);

  Result := R;
end;

constructor TCheckBoxStyleHook.Create;
begin
  inherited;
  OverridePaint := True;
  OverrideEraseBkgnd := True;
  DoubleBuffered := True;
end;

function TCheckBoxStyleHook.RightAlignment: Boolean;
begin
  Result := (Control.BiDiMode = bdRightToLeft) or
            (GetWindowLong(Handle, GWL_STYLE) and BS_RIGHTBUTTON = BS_RIGHTBUTTON);
end;

function TCheckBoxStyleHook.GetDrawState(State: TCheckBoxState): TThemedButton;
begin
  Result := tbButtonDontCare;

  if not Control.Enabled then
    case State of
      cbUnChecked: Result := tbCheckBoxUncheckedDisabled;
      cbChecked: Result := tbCheckBoxCheckedDisabled;
      cbGrayed: Result := tbCheckBoxMixedDisabled;
    end
  else if Pressed and MouseInControl then
    case State of
      cbUnChecked: Result := tbCheckBoxUncheckedPressed;
      cbChecked: Result := tbCheckBoxCheckedPressed;
      cbGrayed: Result := tbCheckBoxMixedPressed;
    end
  else if MouseInControl then
    case State of
      cbUnChecked: Result := tbCheckBoxUncheckedHot;
      cbChecked: Result := tbCheckBoxCheckedHot;
      cbGrayed: Result := tbCheckBoxMixedHot;
    end
  else
    case State of
      cbUnChecked: Result := tbCheckBoxUncheckedNormal;
      cbChecked: Result := tbCheckBoxCheckedNormal;
      cbGrayed: Result := tbCheckBoxMixedNormal;
    end;
end;

procedure TCheckBoxStyleHook.Paint(Canvas: TCanvas);
var
   State: TCheckBoxState;
   Details: TThemedElementDetails;
   R: TRect;
   Spacing: Integer;
   BoxSize: TSize;
   LCaption: string;
   FWordWrap: Boolean;
   LRect: TRect;
   ElementSize: TElementSize;
begin
  if StyleServices.Available then
  begin
    State := TCheckBoxState(SendMessage(Handle, BM_GETCHECK, 0, 0));
    Details := StyleServices.GetElementDetails(GetDrawState(State));

    if Control is TCustomCheckBox then
      FWordWrap :=  TCustomCheckBox(Control).WordWrap
    else
    if Control is TRadioButton then
      FWordWrap :=  TRadioButton(Control).WordWrap
    else
      FWordWrap := False;

    Spacing := 3;
    LRect := System.Classes.Rect(0, 0, 20, 20);
    ElementSize := esActual;
    R := Control.ClientRect;
    with StyleServices do
      if not GetElementSize(Canvas.Handle, GetElementDetails(tbCheckBoxCheckedNormal),
         LRect, ElementSize, BoxSize) then
      begin
        BoxSize.cx := 13;
        BoxSize.cy := 13;
      end;
    if not RightAlignment then
    begin
      R := Rect(0, 0, BoxSize.cx, BoxSize.cy);
      RectVCenter(R, Rect(0, 0, Control.Width, Control.Height));
    end
    else
    begin
      R := Rect(Control.Width - BoxSize.cx - 1, 0, Control.Width, Control.Height);
      RectVCenter(R, Rect(Control.Width - BoxSize.cy - 1, 0, Control.Width, Control.Height));
    end;

    StyleServices.DrawElement(Canvas.Handle, Details, R);
    Canvas.Font := TWinControlClass(Control).Font;

    R := Rect(0, 0, Control.Width - BoxSize.cx - 10, Control.Height);
    LCaption := Text;
    if FWordWrap then
      DrawText(Canvas.Handle, PWideChar(LCaption), Length(LCaption), R, Control.DrawTextBiDiModeFlags(DT_CALCRECT or DT_EXPANDTABS or DT_WORDBREAK))
    else
      DrawText(Canvas.Handle, PWideChar(LCaption), Length(LCaption), R, Control.DrawTextBiDiModeFlags(DT_CALCRECT or DT_EXPANDTABS));

    if not RightAlignment then
      RectVCenter(R, Rect(BoxSize.cx + Spacing, 0, Control.Width, Control.Height))
    else
     begin
       if Control.BiDiMode <> bdRightToLeft then
         RectVCenter(R, Rect(3, 0,
           Control.Width - BoxSize.cx - Spacing, Control.Height))
       else
         RectVCenter(R, Rect(Control.Width - BoxSize.cx - Spacing - R.Right, 0,
           Control.Width - BoxSize.cx - Spacing, Control.Height));
     end;

    if FWordWrap then
      DrawControlText(Canvas, Details, LCaption, R, Control.DrawTextBiDiModeFlags(DT_LEFT or DT_VCENTER or DT_EXPANDTABS or DT_WORDBREAK))
    else
      DrawControlText(Canvas, Details, LCaption, R, Control.DrawTextBiDiModeFlags(DT_LEFT or DT_VCENTER or DT_EXPANDTABS));

    if Focused then
    begin
      InflateRect(R, 2, 1);
      if R.Top < 0 then
        R.Top := 0;
      if R.Bottom > Control.Height then
        R.Bottom := Control.Height;
      Canvas.Brush.Color := StyleServices.GetSystemColor(clBtnFace);
      Canvas.DrawFocusRect(R);
    end;
  end;
end;

procedure TCheckBoxStyleHook.PaintBackground(Canvas: TCanvas);
var
  Details:  TThemedElementDetails;
begin
  if StyleServices.Available then
  begin
    Details.Element := teButton;
    if StyleServices.HasTransparentParts(Details) then
        StyleServices.DrawParentBackground(Handle, Canvas.Handle, Details, False);
  end;
end;

procedure TCheckBoxStyleHook.BMSetCheck(var Message: TMessage);
begin
  SetRedraw(False);
  CallDefaultProc(TMessage(Message));
  SetRedraw(True);
  Invalidate;
  Handled := True;
end;

procedure TCheckBoxStyleHook.WMLButtonDblClk(var Message: TWMMouse);
begin
  SetRedraw(False);
  CallDefaultProc(TMessage(Message));
  SetRedraw(True);
  Invalidate;
  Handled := True;
end;

procedure TCheckBoxStyleHook.WMLButtonDown(var Message: TWMMouse);
begin
  SetRedraw(False);
  CallDefaultProc(TMessage(Message));
  SetRedraw(True);
  FPressed := True;
  Invalidate;
  Handled := True;
end;

procedure TCheckBoxStyleHook.WMLButtonUp(var Message: TWMMouse);
begin
  SetRedraw(False);
  CallDefaultProc(TMessage(Message));
  SetRedraw(True);
  FPressed := False;
  Invalidate;
  Handled := True;
end;

procedure TCheckBoxStyleHook.WndProc(var Message: TMessage);
begin
  // Reserved for potential updates
  inherited;
end;

procedure TCheckBoxStyleHook.WMKeyUp(var Message: TWMKeyUp);
begin
  if Message.CharCode = VK_SPACE then
    SetRedraw(False);
  CallDefaultProc(TMessage(Message));
  if Message.CharCode = VK_SPACE then
  begin
    SetRedraw(True);
    Invalidate;
  end;
  Handled := True;
end;

procedure TCheckBoxStyleHook.WMKeyDown(var Message: TWMKeyDown);
begin
  if Message.CharCode = VK_SPACE then
    SetRedraw(False);
  CallDefaultProc(TMessage(Message));
  if Message.CharCode = VK_SPACE then
  begin
    SetRedraw(True);
    Invalidate;
  end;
  Handled := True;
end;

procedure TCheckBoxStyleHook.MouseEnter;
begin
  inherited;
  Invalidate;
  Handled := True;
end;

procedure TCheckBoxStyleHook.MouseLeave;
begin
  inherited;
  Invalidate;
  Handled := True;
end;

{ TRadioButtonStyleHook }

constructor TRadioButtonStyleHook.Create;
begin
  inherited;
  OverridePaint := True;
  OverrideEraseBkgnd := True;
  DoubleBuffered := True;
end;

function TRadioButtonStyleHook.GetDrawState(State: TCheckBoxState): TThemedButton;
begin
  Result := tbButtonDontCare;

  if not Control.Enabled then
    case State of
      cbUnChecked: Result := tbRadioButtonUncheckedDisabled;
      cbChecked: Result := tbRadioButtonCheckedDisabled;
    end
  else if Pressed and MouseInControl then
    case State of
      cbUnChecked: Result := tbRadioButtonUncheckedPressed;
      cbChecked: Result := tbRadioButtonCheckedPressed;
    end
  else if MouseInControl then
    case State of
      cbUnChecked: Result := tbRadioButtonUncheckedHot;
      cbChecked: Result := tbRadioButtonCheckedHot;
    end
  else
    case State of
      cbUnChecked: Result := tbRadioButtonUncheckedNormal;
      cbChecked: Result := tbRadioButtonCheckedNormal;
    end;
end;

procedure TRadioButtonStyleHook.WndProc(var Message: TMessage);
begin
  // Reserved for potential updates
  inherited;
end;

{ TGroupBoxStyleHook }

function TGroupBoxStyleHook.GetCaptionRect(Canvas: TCanvas): TRect;
const
  FCaptionMargin = 12;
var
  S: String;
begin
  Canvas.Font.Assign(TWinControlClass(Control).Font);
  if Control is TCustomGroupBox then
    S := TCustomGroupBox(Control).Caption else S := Text;
  if Control.BiDiMode <> bdRightToLeft then
    Result := Rect(FCaptionMargin, 0,
      FCaptionMargin + Canvas.TextWidth(S), Canvas.TextHeight(S))
  else
    Result := Rect(Control.Width - Canvas.TextWidth(S) - FCaptionMargin, 0,
     Control.Width  - FCaptionMargin, Canvas.TextHeight(S));
end;

function TGroupBoxStyleHook.GetBoxRect(Canvas: TCanvas): TRect;
var
  S: String;
begin
  if Control is TCustomGroupBox then
    S := TCustomGroupBox(Control).Caption else S := Text;
  with Canvas do
    Result := Rect(0, TextHeight(S) div 2 + 1, Control.Width - 0, Control.Height - 0);
end;

procedure TGroupBoxStyleHook.WMEraseBkgnd(var Message: TMessage);
begin
  Message.Result := 1;
end;

procedure TGroupBoxStyleHook.WMPaint(var Message: TMessage);
var
  Canvas: TCanvas;
  PS: TPaintStruct;
begin
  Canvas := TCanvas.Create;
  try
    if TWMPaint(Message).DC = 0 then
      Canvas.Handle := BeginPaint(Handle, PS)
    else
      Canvas.Handle := TWMPaint(Message).DC;
    Paint(Canvas);
    TWinControlClass(Control).PaintControls(Canvas.Handle, nil);
  finally
    Canvas.Handle := 0;
    Canvas.Free;
    if TWMPaint(Message).DC = 0 then
      EndPaint(Handle, PS);
 end;
 Message.Result := 0;
 Handled := True;
end;

procedure TGroupBoxStyleHook.WndProc(var Message: TMessage);
begin
  // Reserved for potential updates
  inherited;
end;

procedure TGroupBoxStyleHook.PaintBackground(Canvas: TCanvas);
var
  Details:  TThemedElementDetails;
begin
  if StyleServices.Available then
  begin
    Details := StyleServices.GetElementDetails(tbGroupBoxNormal);
    StyleServices.DrawParentBackground(Handle, Canvas.Handle, Details, False);
  end;
end;

procedure TGroupBoxStyleHook.Paint(Canvas: TCanvas);
var
  R, CaptionRect: TRect;
  Details: TThemedElementDetails;
  SaveIndex: Integer;
begin
  if not StyleServices.Available then Exit;

  PaintBackground(Canvas);
  CaptionRect := GetCaptionRect(Canvas);
  R := GetBoxRect(Canvas);
  if Control.Enabled then
    Details := StyleServices.GetElementDetails(tbGroupBoxNormal)
  else
    Details := StyleServices.GetElementDetails(tbGroupBoxDisabled);

  SaveIndex := SaveDC(Canvas.Handle);
  try
    ExcludeClipRect(Canvas.Handle, CaptionRect.Left, CaptionRect.Top,
      CaptionRect.Right, CaptionRect.Bottom);
    StyleServices.DrawElement(Canvas.Handle, Details, R);
  finally
    RestoreDC(Canvas.Handle, SaveIndex);
  end;
  DrawControlText(Canvas, Details, Text, CaptionRect,  DT_VCENTER or DT_CENTER);
end;

{ TStaticTextStyleHook }

constructor TStaticTextStyleHook.Create(AControl: TWinControl);
begin
  inherited;
  OverridePaint := True;
  OverridePaintNC := True;
  OverrideEraseBkgnd := True;
  PaintOnEraseBkgnd := True;
  DoubleBuffered := True;
end;

procedure TStaticTextStyleHook.Paint(Canvas: TCanvas);
const
  Alignments: array[TAlignment] of Word = (DT_LEFT, DT_RIGHT, DT_CENTER);
  States: array[Boolean] of TThemedTextLabel = (ttlTextLabelDisabled, ttlTextLabelNormal);
var
  Details: TThemedElementDetails;
  R: TRect;
begin
  if StyleServices.Available then
  begin
    R := Control.ClientRect;
    if TStaticText(Control).Transparent then
    begin
      Details := StyleServices.GetElementDetails(tbCheckBoxUncheckedNormal);
      StyleServices.DrawParentBackground(Handle, Canvas.Handle, Details, False);
      Canvas.Brush.Style := bsClear;
    end
    else
    begin
      Canvas.Brush.Color := StyleServices.GetStyleColor(scWindow);
      Canvas.FillRect(R);
    end;
    Details := StyleServices.GetElementDetails(States[Control.Enabled]);
    DrawControlText(Canvas, Details, Text, R,
      Alignments[TCustomStaticText(Control).Alignment] or DT_WORDBREAK);
  end;
end;

procedure TStaticTextStyleHook.PaintNC(Canvas: TCanvas);
var
  R: TRect;
  Buffer: TBitmap;
  C1, C2: TColor;
begin
  if not StyleServices.Available then Exit;
  R := Rect(0, 0, Control.Width, Control.Height);
  if (R.Width = 0) or (R.Height = 0) then Exit;
  if TCustomStaticText(Control).BorderStyle = sbsNone then
    Exit;
  Buffer := TBitMap.Create;
  try
    Buffer.Width := R.Width;
    Buffer.Height := R.Height;
                                                                       
    C1 := StyleServices.ColorToRGB(clBtnShadow);
    if TCustomStaticText(Control).BorderStyle = sbsSunken then
      C2 := StyleServices.ColorToRGB(clBtnHighLight)
    else
      C2 := C1;
    Frame3D(Buffer.Canvas, R, C1, C2, 1);
    ExcludeClipRect(Canvas.Handle, 1, 1, Control.Width - 1, Control.Height - 1);
    Canvas.Draw(0, 0, Buffer);
  finally
    Buffer.Free;
  end;
end;

procedure TStaticTextStyleHook.WndProc(var Message: TMessage);
begin
  // Reserved for potential updates
  inherited;
end;

{ TGroupBox }

class constructor TGroupBox.Create;
begin
  TCustomStyleEngine.RegisterStyleHook(TGroupBox, TGroupBoxStyleHook);
end;

class destructor TGroupBox.Destroy;
begin
  TCustomStyleEngine.UnRegisterStyleHook(TGroupBox, TGroupBoxStyleHook);
end;

{ TEdit }

class constructor TEdit.Create;
begin
  TCustomStyleEngine.RegisterStyleHook(TEdit, TEditStyleHook);
end;

class destructor TEdit.Destroy;
begin
  TCustomStyleEngine.UnRegisterStyleHook(TEdit, TEditStyleHook);
end;

{ TMemo }

class constructor TMemo.Create;
begin
  TCustomStyleEngine.RegisterStyleHook(TMemo, TMemoStyleHook);
end;

class destructor TMemo.Destroy;
begin
  TCustomStyleEngine.UnRegisterStyleHook(TMemo, TMemoStyleHook);
end;

{ TComboBox }

class constructor TComboBox.Create;
begin
  TCustomStyleEngine.RegisterStyleHook(TComboBox, TComboBoxStyleHook);
end;

class destructor TComboBox.Destroy;
begin
  TCustomStyleEngine.UnRegisterStyleHook(TComboBox, TComboBoxStyleHook);
end;

{ TButton }

class constructor TButton.Create;
begin
  TCustomStyleEngine.RegisterStyleHook(TButton, TButtonStyleHook);
end;

class destructor TButton.Destroy;
begin
  TCustomStyleEngine.UnRegisterStyleHook(TButton, TButtonStyleHook);
end;

{ TCheckBox }

class constructor TCheckBox.Create;
begin
  TCustomStyleEngine.RegisterStyleHook(TCheckBox, TCheckBoxStyleHook);
end;

class destructor TCheckBox.Destroy;
begin
  TCustomStyleEngine.UnRegisterStyleHook(TCheckBox, TCheckBoxStyleHook);
end;

{ TListBox }

class constructor TListBox.Create;
begin
  TCustomStyleEngine.RegisterStyleHook(TListBox, TListBoxStyleHook);
end;

class destructor TListBox.Destroy;
begin
  TCustomStyleEngine.UnRegisterStyleHook(TListBox, TListBoxStyleHook);
end;

{ TStaticText }

class constructor TStaticText.Create;
begin
  TCustomStyleEngine.RegisterStyleHook(TStaticText, TStaticTextStyleHook);
end;

class destructor TStaticText.Destroy;
begin
  TCustomStyleEngine.UnRegisterStyleHook(TStaticText, TStaticTextStyleHook);
end;

{ TMemoStyleHook }

constructor TMemoStyleHook.Create(AControl: TWinControl);
begin
  inherited;
  OverridePaintNC := True;
  OverrideEraseBkgnd := True;
  UpdateColors;
end;

procedure TMemoStyleHook.UpdateColors;
const
  ColorStates: array[Boolean] of TStyleColor = (scEditDisabled, scEdit);
  FontColorStates: array[Boolean] of TStyleFont = (sfEditBoxTextDisabled, sfEditBoxTextNormal);
var
  LStyle: TCustomStyleServices;
begin
  LStyle := StyleServices;
  Brush.Color := LStyle.GetStyleColor(ColorStates[Control.Enabled]);
  if seFont in Control.StyleElements then
    FontColor := LStyle.GetStyleFontColor(FontColorStates[Control.Enabled])
  else
    FontColor := TWinControlClass(Control).Font.Color;
end;

procedure TMemoStyleHook.WndProc(var Message: TMessage);
begin
  case Message.Msg of
    CN_CTLCOLORMSGBOX..CN_CTLCOLORSTATIC:
      begin
        SetTextColor(Message.WParam, ColorToRGB(FontColor));
        SetBkColor(Message.WParam, ColorToRGB(Brush.Color));
        Message.Result := LRESULT(Brush.Handle);
        Handled := True;
      end;
    CM_ENABLEDCHANGED:
      begin
        UpdateColors;
        Handled := False; // Allow control to handle message
      end
  else
    inherited WndProc(Message);
  end;
end;

procedure TMemoStyleHook.WMNCCalcSize(var Message: TWMNCCalcSize);
var
  Params: PNCCalcSizeParams;
begin
  if (Control is TCustomMemo) and (TCustomMemo(Control).BevelKind <> bkNone) and HasBorder then
  begin
    CallDefaultProc(TMessage(Message));
    Params := Message.CalcSize_Params;
    with Params^.rgrc[0] do
    begin
      Dec(Left, 2);
      Dec(Top, 2);
      Inc(Right, 2);
      Inc(Bottom, 2);
    end;
    Handled := True;
  end;
end;

end.
