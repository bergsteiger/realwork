{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcedit;
{$I dc.inc}
interface

uses
  {$IFNDEF CLX}
  Windows, Messages, Graphics, Controls, Forms, Dialogs, Buttons, StdCtrls, extctrls, comctrls, commctrl
  {$IFDEF D3}, extdlgs{$ENDIF}{$IFDEF USEMASKEDIT}, mask{$ENDIF}, shellapi, 
  {$ELSE}
  Types, Qt, QGraphics, QControls, QForms, QDialogs, QStdCtrls, QExtCtrls, QComCtrls, QButtons, QMAsk,
  {$ENDIF}
  dcsystem, SysUtils, Classes, typinfo, dccommon, dcdreamlib, dccontrols, dcconsts;

type
  TButtonKind = (bkCustom, bkDropDown, bkDots);

  TDreamBorderStyle = (dbsSunkenBorder, dbsRaisedBorder,
    dbsSunkenLine, dbsRaisedLine,
    dbsLine, dbsLineBorder,
    dbsSunkenSingle, dbsRaisedSingle,
    dbsNone);

type
  {$IFDEF CLX}
  TWinControlClass = class of TWidgetControl;
  TControlClass = class of TControl;
  {$ELSE}
  {$IFNDEF D3}
  TWinControlClass = class of TWinControl;
  {$ENDIF}
  {$ENDIF}


  TEditButton = class(TSpeedButton)
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Click; override;
  end;

  TButtonSizeChangeProc = procedure of object;

  TButtonParams = class(TPersistent)
  private
    fWidth: integer;
    fCursor: TCursor;
    fButton: TEditButton;
    fKind: TButtonKind;
    function IsCustom: boolean;

    procedure SetWidth(val: integer);
    procedure SetKind(val: TButtonKind);
    procedure SetGlyph(val: TBitmap);
    function GetGlyph: TBitmap;
    function GetVisible: boolean;
    procedure SetVisible(val: boolean);
    function GetHint: string;
    procedure SetHint(const val: string);
    function GetShowHint: boolean;
    procedure SetShowHint(val: boolean);
    function GetParentShowHint: boolean;
    procedure SetParentShowHint(val: boolean);

    procedure SetNumGlyphs(val: TNumGlyphs);
    function GetNumGlyphs: TNumGlyphs;

    procedure SizeChanged;
    procedure GlyphChanged(Sender: TObject);
  public
    OnSizeChanged: TButtonSizeChangeProc;
    property Button: TEditButton read fButton write fButton;
  published
    property Width: integer read fWidth write SetWidth;
    property Cursor: TCursor read fCursor write fCursor;
    property Kind: TButtonKind read fKind write SetKind;
    property Glyph: TBitmap read GetGlyph write SetGlyph stored IsCustom;
    property Hint: string read GetHint write SetHint;
    property NumGlyphs: TNumGlyphs read GetNumGlyphs write SetNumGlyphs;
    property ParentShowHint: boolean read GetParentShowHint write SetParentShowHint;
    property ShowHint: boolean read GetShowHint write SetShowHint;
    property Visible: boolean read GetVisible write SetVisible;
  end;

  TCustomDCEdit = class(TCustomControl)
  private
    fOnDropDown: TNotifyEvent;
    fButton1: TEditButton;
    fButton2: TEditButton;
    fOnEdit1Click: TNotifyEvent;
    fOnEdit2Click: TNotifyEvent;
    fOnChange: TNotifyEvent;
    {$IFNDEF CLX}
    fOldWndProc: pointer;
    finstance: pointer;
    fhooked: boolean;
    fLostFocus: boolean;
    {$ENDIF}
    fNumButtons: integer;

    fPopupClassName: string;
    fEditSourceType: string;
    fEditSource: TEditSource;
    fEditClass: string;
    fButton1Params: TButtonParams;
    fButton2Params: TButtonParams;
    fCaption: TCaption;
    fSavedText: string;
    fBorderStyle: TBorderStyle;
    fOldFlat: integer;

    fDropped: boolean;
    finitialized: boolean;
    fDropOnClick: boolean;
    fHideCaret: boolean;
    fAlive: boolean;
    fModified: boolean;
    fReadOnly: boolean;

    fDisplayFocused: boolean;
    fInTerm: boolean;

    fEditClicked: boolean;

    fFlat: boolean;
    fFlatTimer: boolean;

    fSkipEnter: boolean;
    firstload: boolean;

    FVersion: TDCVersion;

    fDreamBorderStyle: TDreamBorderStyle;
    fUseDreamBorder: boolean;
    fLineColor: TColor;

    FRealTabStop: Boolean;
    {$IFNDEF CLX}
    procedure WMSize(var Msg: TWMSize); message WM_SIZE;
    procedure CMCtl3DChanged(var Message: TMessage); message CM_CTL3DCHANGED;
    procedure WMSetCursor(var Msg: TWMSetCursor); message WM_SETCURSOR;
    procedure CMVisibleChanged(var Message: TMessage); message CM_VISIBLECHANGED;
    procedure CMWantSpecialKey(var Message: TCMWantSpecialKey); message CM_WANTSPECIALKEY;
    procedure WMKillFocus(var Message: TWMSetFocus); message WM_KILLFOCUS;
    function  AppHook(var Message: TMessage): Boolean;
    procedure HookEditWndProc;
    procedure UnHookEditWndProc;
    function IsEditDroppedDown: Boolean;
    {$ENDIF}
    procedure SetEdit1Click(val: TNotifyEvent);
    procedure SetEdit2Click(val: TNotifyEvent);
    procedure SetDroppedDown(val: boolean);
    //procedure CMTABSTOPCHANGED(var Message: TMessage); message CM_TABSTOPCHANGED;


    function IsWinEditAvailable: boolean;
    procedure AdjustEditorSize;
    procedure SetCaption(const val: TCaption);
    procedure AdjustHeight;
    procedure SetAlive(val: boolean);
    procedure SetDreamBorderStyle(val: TDreamBorderStyle);
    procedure SetUseDreamBorder(val: boolean);
    procedure SetLineColor(val: TColor);
    function GetFlat: boolean;
    procedure UpdateBorder;
    procedure SetBorderStyle(val: TBorderStyle);
    procedure DrawBorder;
    function GetPopup: TWinControlClass;
    procedure SetPopup(val: TWinControlClass);
    procedure SetPopupClassName(const val: string);
    procedure SetEditClass(const val: string);
    procedure SetEditSourceType(const val: string);
    procedure SetNumButtons(val: integer);
    procedure SetButtonBounds;
    procedure SetReadOnly(val: boolean);
    function GetEditorClass: TControlClass;
    procedure SetEditorClass(val: TControlClass);
    procedure SetDisplayFocused(val: boolean);
    function GetDisplayFocused: boolean;
    procedure SetModified(val: boolean);
    procedure SetHideCaret(val: boolean);
    procedure SetRealTabStop(Value: Boolean);

    property IsFlat: boolean read GetFlat;
  protected
    EditOffset: integer;
    fskipCreateHandle: integer;
    fEdit: TControl;
    fDropWindow: TWinControl;

    UseDefaultEditor: boolean;
    fNoBroadCast: boolean;
    fexcept: boolean;

    procedure RestoreSavedText; virtual;
    function  IsEditAvailable: boolean;

    procedure CheckReadOnly; virtual;

    procedure Changed;
    procedure UpdateButtonCount;

    {$IFNDEF CLX}
    procedure CreateWnd; override;
    procedure DestroyWnd; override;
    procedure SetParent(AParent: TWinControl); override;
    function  GetText: string; virtual;
    procedure WndProc(var Message: TMessage); override;
    procedure SetText(const val: string); virtual;
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMExit(var Msg: TCMExit); message CM_EXIT;
    procedure CMEnter(var Message: TCMGotFocus); message CM_ENTER;
    procedure CMColorChanged(var Message: TMessage); message CM_COLORCHANGED;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMTimer(var Msg: TWMTimer); message WM_TIMER;
    procedure ChangeCaption(var Msg: TMessage); message WM_SETTEXT;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure SetEditRect;
    procedure EditWndProc(var Message: TMessage); virtual;
    {$ELSE}
    procedure CreateWidget; override;
    procedure DestroyWidget; override;
    procedure SetParent(const AParent: TWidgetControl); override;
    procedure DoEnter; override;
    procedure DoExit; override;
    procedure BoundsChanged; override;
    procedure CursorChanged; override;
    procedure VisibleChanged; override;
    function  GetText : TCaption; override;
    procedure SetText(const Value : TCaption); override;
//    function  EventHandler(Sender : QObjectH; Event : QEventH) : boolean; override;
    procedure FontChanged; override;
    procedure EnabledChanged; override;
    procedure ColorChanged; override;
    procedure TextChanged; override;
    procedure MouseEnter(AControl: TControl); override;
    procedure MouseLeave(AControl: TControl); override;
    {$ENDIF}
    procedure AlignControls(AControl: TControl; var Rect: TRect); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;

    procedure Loaded; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;

    procedure PostValue(var Msg: TMessage); message CM_UPDATEEDITORS;
    procedure SetDropValue; virtual;
    procedure GetDropValue; virtual;
    function GetModified: boolean; virtual;
    function GetReadOnly: boolean; virtual;
    procedure ValidateEditorClass(var c: TControlClass); virtual;
    procedure DoTerm; virtual;
    function GetDefaultEditorClass: TControlClass; virtual;
    function GetDefaultPopupClass: TWinControlClass; virtual;
    procedure Change; virtual;
    procedure Paint; override;
    function GetTopLineColor: TColor;
    function GetBottomLineColor: TColor;
    function Is3DLine: boolean;
    function IsSingleBorder: boolean;
  public

    {$IFDEF D3}
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    {$ELSE}
    procedure GetChildren(Proc: TGetChildProc); override;
    {$ENDIF}
    function GetChildOwner: TComponent; override;
    function GetChildParent: TComponent; override;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure GetTabOrderList(List: TList); override;
    function Focused: boolean;
    {$IFDEF D4}override;
    {$ENDIF}
    procedure Deselect;
    procedure SelectAll;
    procedure SetFocus; override;
    procedure Drop; virtual;
    procedure CloseDropped(DoChange: boolean); virtual;

    procedure Click; override;
    procedure Term;

    property DropWindow: TWinControl read fDropWindow write fDropWindow;
    property DroppedDown: boolean read fDropped write SetDroppedDown;
    property Flat: boolean read fAlive write SetAlive;
    property DreamBorderStyle: TDreamBorderStyle read fDreamBorderStyle
      write SetDreamBorderStyle stored fUseDreamBorder;
    property UseDreamBorder: boolean read fUseDreamBorder write SetUseDreamBorder
      default False;
    property LineColor: TColor read fLineColor write SetLineColor default cl3DDkShadow;
    property Modified: boolean read GetModified write SetModified;
    property ReadOnly: boolean read GetReadOnly write SetReadOnly;

    property Text: {$IFNDEF CLX} string {$ELSE} TCaption {$ENDIF} read GetText write SetText;

    property DisplayFocused: boolean read GetDisplayFocused write SetDisplayFocused;
    property EditorClass: TControlClass read GetEditorClass write SetEditorClass;
    property PopupClass: TWinControlClass read GetPopup write SetPopup;

    property Button1: TButtonParams read fButton1Params write fButton1Params;
    property Button2: TButtonParams read fButton2Params write fButton2Params;
    property Caption: TCaption read fCaption write SetCaption;

    property HideCaret: boolean read fHideCaret write SetHideCaret default false;
    property NumButtons: integer read fNumButtons write SetNumButtons default 1;
    property PopupWindowClass: string read fPopupClassName write SetPopupClassName;
    property PopupWindow: TWinControl read fDropWindow stored false;
    property EditSourceClass: string read fEditSourceType write SetEditSourceType;
    property EditSource: TEditSource read fEditSource stored false;
    property EditClass: string read fEditClass write SetEditClass;
    property Edit: TControl read fEdit stored false;
    property BorderStyle: TBorderStyle read fBorderStyle write SetBorderStyle default bsSingle;
    property DropOnClick: boolean read fDropOnClick write fDropOnClick default False;

    property TabStop read FRealTabStop write SetRealTabStop;

    property OnButton1Click: TNotifyEvent read fOnEdit1Click write SetEdit1Click;
    property OnButton2Click: TNotifyEvent read fOnEdit2Click write SetEdit2Click;
    property OnDropDown: TNotifyEvent read fOnDropDown write fOnDropDown;

    {$IFNDEF CLX}
    property Ctl3D;
    {$ENDIF}
    property PopupMenu;

    property OnChange: TNotifyEvent read fOnChange write fOnChange;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
  published
    property Version: TDCVersion read FVersion write FVersion stored false;
  end;

  TDCEdit = class(TCustomDCEdit)
  published
    property Align;
    {$IFDEF D4}
    property Anchors;
    {$IFNDEF CLX}
    property AutoSize;
    property BiDiMode;
    {$ENDIF}
    {$ENDIF}
    property BorderStyle;
    property Button1;
    property Button2;
    property Caption;
    property Color;
    {$IFDEF D4}
    property Constraints;
    {$ENDIF}

    {$IFNDEF CLX}
    property Ctl3D;
    property DragCursor;
    {$ENDIF}
    {$IFDEF D4}
    {$IFNDEF CLX}
    property DragKind;
    {$ENDIF}
    {$ENDIF}
    property DragMode;
    property DropOnClick;
    property Edit;
    property EditClass;
    property EditSource;
    property EditSourceClass;
    property Enabled;
    property Flat;
    property DreamBorderStyle;
    property UseDreamBorder;
    property LineColor;
    property Font;
    property HideCaret;
    property NumButtons;
    {$IFDEF D4}
    {$IFNDEF CLX}
    property ParentBiDiMode;
    {$ENDIF}
    {$ENDIF}
    property ParentColor;
    {$IFNDEF CLX}
    property ParentCtl3D;
    {$ENDIF}
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property PopupWindow;
    property PopupWindowClass;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Text;
    property Visible;

    property OnButton1Click;
    property OnButton2Click;

    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDropDown;
    {$IFDEF D4}
    {$IFNDEF CLX}
    property OnEndDock;
    {$ENDIF}
    {$ENDIF}
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    {$IFDEF D4}
    {$IFNDEF CLX}
    property OnStartDock;
    {$ENDIF}
    {$ENDIF}
    property OnStartDrag;
  end;

type
  TPropButtonKind = (bkAuto, bkEllipsis, bkNone);

  TSelDirect = (selNext, selPrior);

  TDCColorEdit = class(TCustomDCEdit)
  private
    procedure SetSelectedColor(Value: TColor);
    function GetSelectedColor: TColor;
  protected
    function GetDefaultEditorClass: TControlClass; override;
    function GetDefaultPopupClass: TWinControlClass; override;
    procedure DblClick; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Align;
    property BorderStyle;
    property Color;
    {$IFNDEF CLX}
    property Ctl3D;
    property DragCursor;
    {$ENDIF}
    property DragMode;
    property DropOnClick;
    property Enabled;
    property Flat;
    property DreamBorderStyle;
    property UseDreamBorder;
    property LineColor;
    property Font;
    property ParentColor;
    {$IFNDEF CLX}
    property ParentCtl3D;
    {$ENDIF}
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;

    property SelectedColor: TColor read GetSelectedColor write SetSelectedColor;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Text;
    property Visible;

    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDropDown;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
    {$IFDEF D4}
    property Anchors;
    {$IFNDEF CLX}
    property AutoSize;
    property BiDiMode;
    {$ENDIF}

    property Constraints;
    {$IFNDEF CLX}
    property DragKind;
    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
    {$ENDIF}
    {$ENDIF}
  end;

  TDCPenStyleEdit = class(TCustomDCEdit)
  private
    procedure SetPenStyle(Value: TPenStyle);
    function GetPenStyle: TPenStyle;
  protected
    function GetDefaultEditorClass: TControlClass; override;
    function GetDefaultPopupClass: TWinControlClass; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Align;
    property BorderStyle;
    property Color;
    {$IFNDEF CLX}
    property Ctl3D;
    property DragCursor;
    {$ENDIF}
    property DragMode;
    property DropOnClick;
    property Enabled;
    property Flat;
    property DreamBorderStyle;
    property UseDreamBorder;
    property LineColor;
    property Font;
    property ParentColor;
    {$IFNDEF CLX}
    property ParentCtl3D;
    {$ENDIF}
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property PenStyle: TPenStyle read GetPenStyle write SetPenStyle;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Text;
    property Visible;

    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDropDown;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
    {$IFDEF D4}
    property Anchors;
    {$IFNDEF CLX}
    property AutoSize;
    property BiDiMode;
    {$ENDIF}
    property Constraints;
    {$IFNDEF CLX}
    property DragKind;
    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
    {$ENDIF}
    {$ENDIF}
  end;

  TDCListBoxColumn = class(TCollectionItem)
  private
    FColumnSize: integer;
    FAlignment: TLeftRightAlign;
  published
    property Alignment: TLeftRightAlign read FAlignment write FAlignment;
    property ColumnSize: integer read FColumnSize write FColumnSize;
  end;

  TDCListBoxColumns = class(TCollection)
  private
    function GetItem(Index: Integer): TDCListBoxColumn;
    procedure SetItem(Index: Integer; Value: TDCListBoxColumn);
  public
    property Items[Index: Integer]: TDCListBoxColumn read GetItem write SetItem;
  end;

  TDCListBox = class(TCustomListBox)
  private
    FBoldFont: TFont;
    FColumns: TDCListBoxColumns;
    FInternalList: TStrings;
    FUpdateCount: integer;

    fCustomDraw: boolean;
    {$IFDEF CLX}
    FDisableDraw : boolean;
    {$ENDIF}

    function CalcSize(ACanvas : TCanvas; const S: string): integer;
    function ColumnAlign(Index: Integer): TLeftRightAlign;
    function ColumnSize(Index: Integer): integer;
    procedure AssignBold;
    procedure SetCustomDraw(Value: boolean);
  protected

    {$IFNDEF CLX}
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState); override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure LBADDSTRING(var Message: TMessage); message LB_ADDSTRING;
    procedure LBINSERTSTRING(var Message: TMessage); message LB_INSERTSTRING;
    procedure LBDELETESTRING(var Message: TMessage); message LB_DELETESTRING;
    procedure WMSETREDRAW(var Message: TMessage); message WM_SETREDRAW;
    {$ELSE}
    procedure FontChanged; override;
    function  DrawItem(Index : integer; Rect : TRect; State : TOwnerDrawState): boolean; override;
    procedure InitWidget; override;
    {$ENDIF}
    procedure ResetColumnSize;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Columns: TDCListBoxColumns read FColumns;
    property CustomDraw: boolean read fCustomDraw write SetCustomDraw;
  end;

  TPopupListBox = class(TDCListBox)
  private
    fDisplayNames: boolean;

    procedure SetDisplayNames(val: boolean);
  protected
    {$IFNDEF CLX}
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateHandle; override;
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMMouseMove(var Message: TWMMouseMove); message WM_MOUSEMOVE;

    procedure GetText(var Msg: TMessage); message WM_GETTEXT;
    procedure SetText(var Msg: TMessage); message WM_SETTEXT;
    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
    procedure CMWantSpecialKey(var Message: TCMWantSpecialKey); message CM_WANTSPECIALKEY;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    {$ELSE}
    procedure CreateWidget; override;
    procedure MouseDown(Button : TMouseButton; Shift : TShiftState; X, Y : integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    function  GetText : TCaption; override;
    procedure SetText(const Value : TCaption); override;
    procedure FontChanged; override;
    procedure InitWidget; override;
    {$ENDIF}
    procedure AdjustHeight;
    procedure MouseUp(Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure ResetItemHeight;

  public
    constructor Create(AOwner: TComponent); override;
    procedure Close(DoSelect: boolean); virtual;
    property DisplayNames: boolean read FDisplayNames write SetDisplayNames;
    procedure BuildList; virtual;
  published
    property ItemHeight;
    property Items;
    property Sorted;
    property Font;
    property ParentFont;
    property Color;
    property ParentColor;
    property OnKeyDown;
    property OnKeyPress;
  end;

  TPopupListBoxCallback = procedure(Sender: TObject; SelIndex: integer) of object;

  TDCPopupListBox = class(TPopupListBox)
  private
    FMaxSize : integer;
    fCallBack: TPopupListBoxCallback;
    {$IFNDEF CLX}
    fOldWindProc: integer;
    fHookProcInst: integer;
    function  AppHook(var Message: TMessage): Boolean;
    procedure HookParent;
    procedure UnHookParent;
    procedure HookProc(var Message: TMessage);
    {$ENDIF}
    function AdjustColumns(ASize : integer) : integer;
  protected
    {$IFNDEF CLX}
    procedure CreateHandle; override;
    procedure DestroyWnd; override;
    {$ENDIF}
  public
    constructor Create(AOwner: TComponent); override;
    procedure Close(DoSelect: boolean); override;
    procedure Popup(x, y: integer);
    property CallBack: TPopupListBoxCallback read fCallBack write fCallBack;
    property MaxSize : integer read FMaxSize write FMaxSize;
  end;

type
  TDCBrushStyleEdit = class(TCustomDCEdit)
  private
    procedure SetBrushStyle(Value: TBrushStyle);
    function GetBrushStyle: TBrushStyle;
  protected
    function GetDefaultEditorClass: TControlClass; override;
    function GetDefaultPopupClass: TWinControlClass; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Align;
    property BorderStyle;
    property BrushStyle: TBrushStyle read GetBrushStyle write SetBrushStyle;
    property Color;
    {$IFNDEF CLX}
    property Ctl3D;
    property DragCursor;
    {$ENDIF}
    property DragMode;
    property DropOnClick;
    property Enabled;
    property Flat;
    property DreamBorderStyle;
    property UseDreamBorder;
    property LineColor;
    property Font;
    property ParentColor;
    {$IFNDEF CLX}
    property ParentCtl3D;
    {$ENDIF}
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Text;
    property Visible;

    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDropDown;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
    {$IFDEF D4}
    property Anchors;
    {$IFNDEF CLX}
    property AutoSize;
    property BiDiMode;
    {$ENDIF}

    property Constraints;
    {$IFNDEF CLX}
    property DragKind;

    property ParentBiDiMode;

    property OnEndDock;
    property OnStartDock;
    {$ENDIF}
    {$ENDIF}
  end;

type
  TPaintToMsg = record
    Msg: Cardinal;
    Canvas: TCanvas;
    X: Smallint;
    Y: Smallint;
    Result: longint;
  end;

const
  CM_PAINTTO = CM_BASE + 200;

type
  TDCSimpleEdit = class(TCustomEdit)
  protected
    {$IFNDEF CLX}
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CMEnter(var Message: TCMGotFocus); message CM_ENTER;
    {$ELSE}
    procedure DoEnter; override;
    {$ENDIF}
  public
    constructor Create(AOwner: TComponent); override;
  published
    property CharCase;
    property Color;
    property Font;
    property MaxLength;
    {$IFNDEF CLX}
    property OEMConvert;
    {$ENDIF}
  end;

  {$IFDEF USEMASKEDIT}
  TDCMaskEdit = class(TCustomMaskEdit)
  protected
    {$IFNDEF CLX}
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CMEnter(var Message: TCMGotFocus); message CM_ENTER;
    {$ELSE}
    procedure DoEnter; override;
    {$ENDIF}
  public
    constructor Create(AOwner: TComponent); override;
  published
    property CharCase;
    property Color;
    property EditMask;
    property Font;
    property MaxLength;
    {$IFNDEF CLX}
    property OEMConvert;
    {$ENDIF}
  end;
  {$ENDIF}

  {$IFDEF D3}
  {$IFNDEF CLX}

  TDCDtEdit = class(TDateTimePicker)
  private
    fdropped: boolean;
    fmodified: boolean;
    firstsetparent: boolean;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure GetModified(var Msg: TMessage); message EM_GETMODIFY;
    procedure CNNotify(var Message: TWMNotify); message CN_NOTIFY;
    procedure GetDropped(var Message: TMessage); message CB_GETDROPPEDSTATE;
    procedure WMSetText(var Msg: TMessage); message WM_SETTEXT;
    procedure WMGetText(var Msg: TMessage); message WM_GETTEXT;
    procedure WMGetTextLength(var Msg: TMessage); message WM_GETTEXTLENGTH;
    function GetText: string; virtual; abstract;
    procedure SetText(const val: string); virtual; abstract;
    procedure CreateWnd; override;
    procedure SetParent(AParent: TWinControl); override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TDCDateEdit = class(TDCDtEdit)
  protected
    function GetText: string; override;
    procedure SetText(const val: string); override;
  end;

  TDCTimeEdit = class(TDCDtEdit)
  protected
    function GetText: string; override;
    procedure SetText(const val: string); override;
    procedure CNNotify(var Message: TWMNotify); message CN_NOTIFY;
  public
    constructor Create(AOwner: TComponent); override;
  end;
  {$ENDIF}
  {$ENDIF}

  TPopupColorBox = class(TPopupListBox)
  private
    FColorValue: TColor;
    procedure SetColorValue(NewValue: TColor);
    procedure DoSetText;
  protected
    {$IFNDEF CLX}
    procedure GetText(var Msg: TMessage); message WM_GETTEXT;
    procedure SetText(var Msg: TMessage); message WM_SETTEXT;
    procedure DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState); override;
    {$ELSE}
    function  GetText : TCaption; override;
    procedure SetText(const Value : TCaption); override;
    function  DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState) : boolean; override;
    {$ENDIF}
    procedure Click; override;
  public
    procedure BuildList; override;
    constructor Create(AOwner: TComponent); override;
  published
    property DisplayNames;
    property Items stored false;
  end;

  TPopupBrushBox = class(TPopupListBox)
  private
    FBrushValue: TBrushStyle;
    fbrush: TBrush;
    procedure SetBrushValue(NewValue: TBrushStyle);
    procedure DoSetText;

  protected
    {$IFNDEF CLX}
    procedure GetText(var Msg: TMessage); message WM_GETTEXT;
    procedure SetText(var Msg: TMessage); message WM_SETTEXT;
    procedure DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState); override;
    {$ELSE}
    function  GetText : TCaption; override;
    procedure SetText(const Value : TCaption); override;
    function  DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState) : boolean; override;
    {$ENDIF}
    procedure Click; override;
  public
    procedure BuildList; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property DisplayNames;
    property Items stored false;
  end;

  TPopupPenBox = class(TPopupListBox)
  private
    FPenValue: TPenStyle;
    procedure SetPenValue(NewValue: TPenStyle);
    procedure DoSetText;

  protected
    {$IFNDEF CLX}
    procedure GetText(var Msg: TMessage); message WM_GETTEXT;
    procedure SetText(var Msg: TMessage); message WM_SETTEXT;
    procedure DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState); override;
    {$ELSE}
    function  GetText : TCaption; override;
    procedure SetText(const Value : TCaption); override;
    function  DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState) : boolean; override;
    {$ENDIF}
    procedure Click; override;
  public
    procedure BuildList; override;
    constructor Create(AOwner: TComponent); override;
  published
    property DisplayNames;
    property Items stored false;
  end;

  TGraphicEdit = class(TCustomControl)
  private
    fText: string;
  protected
    procedure PaintToCanvas(Canvas: TCanvas; X, Y: integer); virtual; abstract;
    {$IFNDEF CLX}
    procedure WMSetText(var Msg: TMessage); message WM_SETTEXT;
    procedure WMGetText(var Msg: TMessage); message WM_GETTEXT;
    procedure WMGetTextLength(var Msg: TMessage); message WM_GETTEXTLENGTH;
    procedure CMPaintTo(var Msg: TPaintToMsg); message CM_PAINTTO;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure SetText(const val: string); virtual;
    function  GetText: string; virtual;
    {$ELSE}
    function  GetText : TCaption; override;
    procedure SetText(const Value : TCaption); override;
    procedure EnabledChanged; override;
    {$ENDIF}
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    property Canvas;
  end;

  TColorEdit = class(TGraphicEdit)
  protected
    {$IFNDEF CLX}
    procedure PaintToCanvas(Canvas: TCanvas; X, Y: integer); override;
    procedure SetText(const val: string); override;
    {$ELSE}
    procedure SetText(const Value : TCaption); override;
    {$ENDIF}
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TGraphEdit = class(TGraphicEdit)
  protected
    {$IFNDEF CLX}
    procedure WMEraseBkgnd(var Message: TWmEraseBkgnd); message WM_ERASEBKGND;
    {$ENDIF}
    procedure PaintToCanvas(Canvas: TCanvas; X, Y: integer); override;
    function GetGraphic: TGraphic; virtual; abstract;
  end;

  TPenStyleEdit = class(TGraphicEdit)
  protected
    {$IFNDEF CLX}
    procedure PaintToCanvas(Canvas: TCanvas; X, Y: integer); override;
    procedure SetText(const val: string); override;
    {$ELSE}
    procedure SetText(const Value : TCaption); override;
    {$ENDIF}
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TBrushStyleEdit = class(TGraphicEdit)
  private
    foldbrush: TBrush;
  protected
    {$IFNDEF CLX}
    procedure PaintToCanvas(Canvas: TCanvas; X, Y: integer); override;
    procedure SetText(const val: string); override;
    {$ELSE}
    procedure SetText(const Value : TCaption); override;
    {$ENDIF}
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

  TCheckEdit = class(TCustomControl)
  private
    fmodified: boolean;
    fcute: boolean;
    fScaled: boolean;
    fInvert: boolean;

    procedure ChangeChecked;
    procedure SetCute(val: boolean);
    procedure SetScaled(val: boolean);
    procedure PaintToCanvas(Canvas: TCanvas; X, Y: integer);
  protected
    {$IFNDEF CLX}
    procedure WMSetText(var Msg: TMessage); message WM_SETTEXT;
    procedure WMGetText(var Msg: TMessage); message WM_GETTEXT;
    procedure WMGetTextLength(var Msg: TMessage); message WM_GETTEXTLENGTH;
    procedure WMEraseBkgnd(var Message: TWmEraseBkgnd); message WM_ERASEBKGND;
    procedure CMPaintTo(var Msg: TPaintToMsg); message CM_PAINTTO;
    procedure GetModified(var Msg: TMessage); message EM_GETMODIFY;
    {$ELSE}
    procedure SetText(const Value : TCaption); override;
    {$ENDIF}
    procedure Paint; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure Click; override;
    function  GetWinStyle: integer; virtual;
  public
    Checked: boolean;
    fClickAnyWhere: boolean;

    constructor Create(AOwner: TComponent); override;
    procedure SetFocus; override;

    property Cute: boolean read fCute write SetCute;
    property Scaled: boolean read fScaled write SetScaled;
    property Invert: boolean read fInvert write fInvert;
  end;

  TRadioEdit = class(TCheckEdit)
  protected
    procedure Click; override;
    {$IFNDEF CLX}
    function GetWinStyle: integer; override;
    {$ENDIF}
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TDummyEditSource = class(TEditSource)
  private
    fText: string;
  public
    function GetValue: string; override;
    procedure SetValue(const val: string); override;
  end;

  TCustomFileDirEdit = class(TCustomDCEdit)
  private
    FInitialDir: string;
    FOnDropFiles: TNotifyEvent;
    {$IFNDEF CLX}
    FAcceptFiles: boolean;
    procedure SetAcceptFiles(Value: Boolean);
    procedure SetDragAccept(Value: Boolean);
    {$ENDIF}
  protected
    {$IFNDEF CLX}
    procedure CreateHandle; override;
    procedure DestroyWindowHandle; override;
    procedure WMDropFiles(var Message: TWMDropFiles); message WM_DROPFILES;
    {$ENDIF}
    procedure Button1Click(Sender: TObject); virtual; abstract;
  public
    constructor Create(AOwner: TComponent); override;
    {$IFNDEF CLX}
    property AcceptFiles: boolean read FAcceptFiles write SetAcceptFiles;
    {$ENDIF}
    property InitialDir: string read FInitialDir write FInitialDir;
    property OnDropFiles: TNotifyEvent read FOnDropFiles write FOnDropFiles;
  end;

  TFileDialogKind = (fdOpen, fdSave{$IFDEF D3}, fdOpenpicture, fdSavePicture{$ENDIF});

  TDCFileNameEdit = class(TCustomFileDirEdit)
  private
    FDefaultExt: string;
    FDialogKind: TFileDialogKind;
    FDialogOptions: TOpenOptions;
    FDialogTitle: string;
    FFilter: string;
    FFilterIndex: integer;
    FDialog: TOpenDialog;
    procedure SetFileName(Value: string);
    function GetFileName: string;
  protected
    {$IFNDEF CLX}
    procedure WMDropFiles(var Message: TWMDropFiles); message WM_DROPFILES;
    {$ENDIF}
    procedure Button1Click(Sender: TObject); override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property DefaultExt: string read FDefaultExt write FDefaultExt;
    property DialogKind: TFileDialogKind read FDialogKind write FDialogKind;
    property DialogOptions: TOpenOptions read FDialogOptions write FDialogOptions;
    property DialogTitle: string read FDialogTitle write FDialogTitle;
    property FileName: string read GetFileName write SetFileName stored false;
    property Filter: string read FFilter write FFilter;
    property FilterIndex: integer read FFilterIndex write FFilterIndex;
    {$IFNDEF CLX}
    property AcceptFiles;
    {$ENDIF}
    property HelpContext;
    property InitialDir;

    property Align;
    {$IFDEF D4}
    property Anchors;
    {$IFNDEF CLX}
    property AutoSize;
    property BiDiMode;
    {$ENDIF}
    property Constraints;
    {$IFNDEF CLX}
    property DragKind;
    property ParentBiDiMode;
    {$ENDIF}
    {$ENDIF}
    property BorderStyle;
    property Button1;
    property Button2;
    property Caption;
    property Color;
    {$IFNDEF CLX}
    property Ctl3D;
    property DragCursor;
    {$ENDIF}
    property DragMode;
    property Enabled;
    property Flat;
    property DreamBorderStyle;
    property UseDreamBorder;
    property LineColor;
    property Font;
    property ParentColor;
    {$IFNDEF CLX}
    property ParentCtl3D;
    {$ENDIF}
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Text;
    property Visible;

    property OnButton2Click;
    property OnDropFiles;
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDropDown;
    {$IFDEF D4}
    {$IFNDEF CLX}
    property OnEndDock;
    property OnStartDock;
    {$ENDIF}
    {$ENDIF}
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
  end;

  TDCDirectoryEdit = class(TCustomFileDirEdit)
  private
    //FDialogOptions : TSelectDirOpts;
    FDialogText: string;
    FMultipleDirs: boolean;
  protected
    {$IFNDEF CLX}
    procedure WMDropFiles(var Message: TWMDropFiles); message WM_DROPFILES;
    {$ENDIF}
    procedure Button1Click(Sender: TObject); override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    //property DialogOptions : TSelectDirOpts read FDialogOptions write FDialogOptions;
    property DialogText: string read FDialogText write FDialogText;
    property MultipleDirs: boolean read FMultipleDirs write FMultipleDirs;
    property HelpContext;
    {$IFNDEF CLX}
    property AcceptFiles;
    {$ENDIF}
    property InitialDir;

    property Align;
    {$IFDEF D4}
    property Anchors;
    {$IFNDEF CLX}
    property AutoSize;
    property BiDiMode;
    {$ENDIF}
    property Constraints;
    {$IFNDEF CLX}
    property DragKind;
    property ParentBiDiMode;
    {$ENDIF}
    {$ENDIF}
    property BorderStyle;
    property Button1;
    property Button2;
    property Caption;
    property Color;
    {$IFNDEF CLX}
    property Ctl3D;
    property DragCursor;
    {$ENDIF}
    property DragMode;
    property Enabled;
    property Flat;
    property DreamBorderStyle;
    property UseDreamBorder;
    property LineColor;
    property Font;
    property ParentColor;
    {$IFNDEF CLX}
    property ParentCtl3D;
    {$ENDIF}
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Text;
    property Visible;

    property OnButton2Click;
    property OnDropFiles;
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDropDown;
    {$IFDEF D4}
    {$IFNDEF CLX}
    property OnEndDock;
    property OnStartDock;
    {$ENDIF}
    {$ENDIF}
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
  end;

procedure UnRegisterBooleanEditor;

function PopupListbox(AParent: TWinControl; Sl: TStrings; X, Y: integer;
  AlignArray: array of TLeftRightAlign;
  AFont: TFont; ACallBack: TPopupListBoxCallback; AMaxSize : integer): TDCPopupListBox;

type
  TCustomDCPropEditor = class(TCustomDCEdit);

procedure Register;

implementation
{$R dcedit.dcr}

{$IFDEF CLX}
type
  TMCustomEdit = class(TCustomEdit);
{$ENDIF}

{------------------------------------------------------------------}

procedure _FrameRect(Canvas : TCanvas; R : TRect);
{$IFDEF CLX}
var
  OldColor : TColor;
{$ENDIF}
begin
  {$IFDEF CLX}
  with Canvas do
  begin
    OldColor := Pen.Color;
    Pen.Color := Brush.Color;
    with R do
      QPainter_drawRect(Canvas.Handle, Left, Top, Right - Left, Bottom - Top);
    Pen.Color := OldColor;
  end;
  {$ELSE}
  Canvas.FrameRect(R);
  {$ENDIF}
end;


procedure UnRegisterBooleanEditor;
begin
  UnRegisterEditClass(TypeInfo(Boolean), nil, '', TCheckEdit);
  UnRegisterPopupClass(TypeInfo(Boolean), nil, '', nil);
end;

{------------------------------------------------------------------}

type
  TMWinControl = class(TWinControl)
  end;

  TMControl = class(TControl)
  end;

var
  fDropDownGlyph: TBitmap;
  fDotsGlyph: TBitmap;

  {------------------------------------------------------------------}

type
  TDummyPopup = class(TWinControl)
  end;

  {------------------------------------------------------------------}

function TDummyEditSource.GetValue: string;
begin
  result := fText;
end;

{------------------------------------------------------------------}

procedure TDummyEditSource.SetValue(const val: string);
begin
  fText := val;
end;

{------------------------------------------------------------------}

constructor TEditButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  {$IFNDEF CLX}
  Width := GetSystemMetrics(SM_CXHTHUMB);
  {$ELSE}
  Width := SM_CXHTHUMB;
  {$ENDIF}
  ControlStyle := ControlStyle + [csNoDesignVisible];
  Visible := True;
  Parent := TWinControl(AOwner);
end;

{------------------------------------------------------------------}

procedure TEditButton.Paint;
var
  editcolor: TColor;
begin
  inherited Paint;

  with Canvas do
    if TCustomDCEdit(Owner).IsFlat then
    begin
      editcolor := TCustomDCEdit(Owner).Color;
      Brush.color := editcolor;

      if (TCustomDCEdit(Owner).IsSingleBorder) then
      begin
        _FrameRect(Canvas, Rect(0, 0, Width, Height));
        Brush.Color := clBtnFace;
        _FrameRect(Canvas, Rect(1, 1, Width - 1, Height - 1));
        Pen.Color := clBtnHighlight;
        MoveTo(1, 0);
        LineTo(1, Height);
      end
      else
      begin
        _FrameRect(Canvas, Rect(1, 1, Width - 1, Height - 1));

        Pen.Color := clBtnFace;
        MoveTo(0, 0);
        LineTo(width - 1, 0);
        LineTo(width - 1, Height - 1);
        LineTo(-1, Height - 1);
      end;
    end
    else
    begin
      Pen.Color := clBtnFace;
      MoveTo(0, 0);
      LineTo(0, Height - 1);
      MoveTo(0, 0);
      LineTo(ClientWidth, 0);
      LineTo(ClientWidth, 2);
      Pen.Color := clBtnHighlight;
      MoveTo(1, 1);
      LineTo(ClientWidth - 2, 1);

      Pen.Color := clBtnHighlight;
      MoveTo(1, 1);
      LineTo(1, Height - 2);

      if ((not TCustomDCEdit(Owner).UseDreamBorder) and
        (not TCustomDCEdit(Owner).Flat)) or
        (TCustomDCEdit(Owner).IsSingleBorder) then
      begin
        Pen.Color := clBlack;
        MoveTo(ClientWidth - 1, 0);
        LineTo(ClientWidth - 1, 1);
      end
      else
      begin
        Brush.Color := clBtnFace;
        _FrameRect(Canvas, Rect(0, 0, Width, Height));
        if TCustomDCEdit(Owner).Is3DLine then //Redraw the painted over portion
        begin
          Pen.Color := TCustomDCEdit(Owner).GetTopLineColor;
          MoveTo(0, Height - 1);
          LineTo(Width, Height - 1);
        end;
      end;
    end;
end;

{------------------------------------------------------------------}

procedure TEditButton.Click;
var
  needdropdown: boolean;
begin
  needdropdown := Assigned(OnClick);
  TCustomDCEdit(Owner).SetFocus;
  inherited Click;
  with TCustomDCEdit(Owner) do
    if not needdropdown then
      DroppedDown := not DroppedDown;
end;

{------------------------------------------------------------------}

var
  pwindow: TWinControl;
  cedit: TCustomDCEdit;
{$IFNDEF CLX}
  WHook: HHook;

  {------------------------------------------------------------------}

procedure RemoveHooks;
begin
  if GetCapture <> 0 then
    SendMessage(GetCapture, WM_CANCELMODE, 0, 0);

  UnhookWindowsHookEx(WHook);
end;

{------------------------------------------------------------------}

function CallWndProcHook(nCode: integer; wParam: Longint; var mhs: TMouseHookStruct): longint; stdcall;
var
  r: TRect;
  r2: TRect;
begin
  result := 0;
  GetWindowRect(pwindow.handle, r);
  if cedit <> nil then
  begin
    GetWindowRect(cedit.handle, r2);

    if cedit.fbutton1.visible then
      inc(r2.right, cedit.fbutton1.width);

    if cedit.fbutton2.visible then
      inc(r2.right, cedit.fbutton2.width);
  end
  else
  begin
    r2.Left := 0;
    r2.Top := 0;
    r2.Bottom := 0;
    r2.Right := 0;
  end;

  if (((wParam = WM_LBUTTONDOWN) or (wParam = WM_LBUTTONUP)
    or (wParam = WM_NCLBUTTONDOWN) or (wParam = WM_NCLBUTTONUP))) and
    not (PtInRect(r, mhs.pt) or PtInRect(r2, mhs.pt)) then
    if pwindow is TPopupListBox then
      TPopupListBox(pwindow).Close(false)
    else
      cedit.CloseDropped(false);

  if (wParam = WM_LBUTTONDOWN) and PtInRect(r, mhs.pt) then
    SetCapture(pWindow.Handle);

  if (wParam = WM_MOUSEMOVE) and (GetCapture = pwindow.Handle) then
  begin
    pwindow.Perform(WM_MOUSEMOVE, 0, integer(PointToSmallPoint(pwindow.ScreenToClient(mhs.pt))));
    if not (PtInRect(r, mhs.pt) or PtInRect(r2, mhs.pt)) then
      exit;
  end;

  Result := CallNextHookEx(WHook, nCode, wParam, Longint(@mhs));
end;

{$ENDIF}
{------------------------------------------------------------------}

constructor TCustomDCEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  firstload := true;
  fFlat := true;
  fOldFlat := 2;
  FRealTabStop := False;
  TabStop := True;
  Width := 121;
  Height := 21;
  ParentColor := false;
  UseDefaultEditor := true;
  fBorderStyle := bsSingle;
  fDisplayFocused := true;
  fUseDreamBorder := False;
  fLineColor := cl3DDkShadow;

  fButton1Params := TButtonParams.Create;
  fButton2Params := TButtonParams.Create;

  fButton1 := TEditButton.Create(Self);
  fButton1Params.Button := fButton1;
  fButton1Params.OnSizeChanged := SetButtonBounds;
  fButton1.Glyph.OnChange := fButton1Params.GlyphChanged;
  Button1.Kind := bkDropDown;

  fButton2 := TEditButton.Create(Self);
  fButton2Params.Button := fButton2;
  fButton2Params.OnSizeChanged := SetButtonBounds;
  fButton2.Glyph.OnChange := fButton2Params.GlyphChanged;
  Button2.Kind := bkDots;

  fNumButtons := 1;
  fButton2.visible := false;
  if not NewStyleControls then
    ControlStyle := ControlStyle + [csFramed];

  fDropWindow := TDummyPopup.Create(self);
  fDropWindow.Visible := false;

  fEditSource := TDummyEditSource.Create(self);
  if csDesigning in ComponentState then
    fPopupClassName := 'TPopupListBox'; //don't resource
end;

{------------------------------------------------------------------}

destructor TCustomDCEdit.Destroy;
begin
  {$IFNDEF CLX}
  UnHookEditWndProc;
  {$ENDIF}
  fButton1Params.Free;
  fButton2Params.Free;

  inherited Destroy;
end;

{------------------------------------------------------------------}
{$IFNDEF CLX}
procedure TCustomDCEdit.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Caption := PChar(fCaption);
    if (fBorderStyle = bsSingle) and not (Flat or UseDreamBorder) then
      Style := Style or WS_BORDER;
    if NewStyleControls and not (Flat or UseDreamBorder) and
      Ctl3D and (fBorderStyle = bsSingle) then
    begin
      Style := Style and not WS_BORDER;
      ExStyle := ExStyle or WS_EX_CLIENTEDGE;
    end
    else
      ExStyle := ExStyle and not WS_EX_CLIENTEDGE;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.WMTimer(var Msg: TWMTimer);
var
  pt: TPoint;
begin
  if fFlatTimer then
  begin
    UpdateBorder;
    KillTimer(handle, 1);
  end
  else
  begin
    GetCursorPos(pt);
    if GetCapture = pwindow.Handle then
      pwindow.Perform(WM_MOUSEMOVE, 0, integer(PointToSmallPoint(pwindow.ScreenToClient(pt))));
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.WMSetCursor(var Msg: TWMSetCursor);
var
  tl: tpoint;
  tl2: tpoint;
  x: integer;
begin
  if csDesigning in ComponentState then
  begin
    inherited;
    exit;
  end;

  tl := fButton1.ClientToScreen(Point(0, 0));
  tl2 := fButton2.ClientToScreen(Point(0, 0));

  x := LOWORD(GetMessagePos);
  if (fButton2.Visible) and (x >= tl2.x) then
    windows.SetCursor(Screen.Cursors[Button2.Cursor])
  else if fButton1.Visible and (x > tl.x) then
    windows.SetCursor(Screen.Cursors[Button1.Cursor])
  else
  begin
    inherited;
    //Windows.SetCursor(Screen.Cursors[Cursor]);
    //Msg.Result := 1;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.CMVisibleChanged(var Message: TMessage);
begin
  if fDropped then
    CloseDropped(false);

  inherited;
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.CMCtl3DChanged(var Message: TMessage);
begin
  if NewStyleControls and (FBorderStyle = bsSingle) then
    RecreateWnd;
  SetButtonBounds;
  inherited;
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.CMColorChanged(var Message: TMessage);
begin
  inherited;
  if Assigned(fEdit) then
    TMControl(fEdit).Color := self.Color;
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.CMDialogChar(var Message: TCMDialogChar);
begin
  with Message do
    if IsAccel(CharCode, Caption) then
      if CanFocus then
      begin
        Click;
        Result := 1;
      end
      else
        inherited;
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.CMWantSpecialKey(var Message: TCMWantSpecialKey);
begin
  inherited;
  with Message do
  begin
    if (CharCode in [VK_DOWN, VK_UP]) or ((CharCode in [VK_ESCAPE, VK_RETURN]) and DroppedDown) then
      Message.Result := 1;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  fFlat := false;
  UpdateBorder;
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  fFlatTimer := true;
  fFlat := true;
  SetTimer(Handle, 1, 10, nil);
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.WMSetFocus(var Message: TWMSetFocus);
begin
  inherited;
  //  if csDestroying in ComponentState then
  exit;

  if Assigned(fEdit) and (fEdit is TWinControl) and
    (windows.GetFocus <> TWinControl(fEdit).Handle) then
  begin
    TWinControl(fEdit).SetFocus;
    windows.SetFocus(TWinControl(fEdit).Handle);
    if DisplayFocused then
      Invalidate;
  end;
  UpdateBorder;
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.WndProc(var Message: TMessage);
var
  isKeyMessage: boolean;
begin
  with Message do
  begin
    IsKeyMessage := (Msg = WM_KEYDOWN) or (Msg = WM_KEYUP) or (Msg = WM_CHAR);
    if IsKeyMessage then
      if fDropped then
      begin
        fDropWindow.Perform(Msg, wParam, lParam);
        exit;
      end;

    inherited WndProc(Message);

    if (Msg = WM_PARENTNOTIFY) then
      with TWMParentNotify(Message) do
        case Event of
          WM_DESTROY:
            begin
              //CloseDropped(false);
              UnHookEditWndProc;
            end;

          WM_CREATE:
            begin
              HookEditWndProc;
              AdjustEditorSize;

              if Assigned(fDropWindow) and fDropWindow.HandleAllocated then
                windows.SetParent(fDropWindow.Handle, 0);

              CheckReadOnly;
              //                           UpdateColor;
            end;
        end;
  end;

end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.ChangeCaption(var Msg: TMessage);
begin
  Caption := StrPas(PChar(Msg.LParam));
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.SetText(const val: string);
begin
  if Assigned(fEdit) then
    with fEdit do
      if GetText <> val then
      begin
        fSavedText := val;
        Perform(WM_SETTEXT, 0, Longint(PChar(val)));
        Perform(CM_TEXTCHANGED, 0, 0);
        Change;
      end;
end;

{------------------------------------------------------------------}

function TCustomDCEdit.GetText: string;
var
  len: Integer;
begin
  if Assigned(fEdit) then
  begin
    len := fEdit.Perform(WM_GETTEXTLENGTH, 0, 0);
    SetString(Result, PChar(nil), len);
    if len <> 0 then
      fEdit.Perform(WM_GETTEXT, len + 1, Longint(pointer(result)));
  end
  else
    result := '';
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.WMSize(var Msg: TWMSize);
begin
  inherited;
  AdjustEditorSize;
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.CMEnter(var Message: TCMEnter);
begin
  fFlat := False;
  if fSkipEnter then
  begin
    fSkipEnter := false;
    exit;
  end;

  inherited;
  UpdateBorder;
  if IsWinEditAvailable then
  begin
    fSkipEnter := true;
    TWinControl(fEdit).SetFocus;
  end;
  Invalidate;
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.CMExit(var Msg: TCMExit);
begin
  fFlat := True;
  try
    Term;
  except
    SelectAll;
    SetFocus;
    raise;
  end;
  UpdateBorder;
  DoExit;
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.SetEditRect;
var
  delta: integer;
  Loc: TRect;
  ydelta: integer;
begin
  if not HandleAllocated then
    exit;

  delta := 0;
  ydelta := byte(Flat or UseDreamBorder) * 2;
  Loc := Rect(1, ydelta + 1, ClientWidth - delta - ydelta * 2 - 2, ClientHeight - 2 - ydelta * 2);

  if fNumButtons > 0 then
    inc(delta, fButton1.Width);

  if fNumButtons > 1 then
    inc(delta, fButton2.Width);

  if IsEditAvailable then
    fEdit.SetBounds(ydelta, 1 + ydelta, ClientWidth - delta - ydelta * 2, ClientHeight - ydelta * 2 - 1);

  if IsEditAvailable then
    fEdit.Perform(EM_SETRECT, 0, LongInt(@Loc));

  if fdropped then
    CloseDropped(false);
end;

{------------------------------------------------------------------}

function TCustomDCEdit.AppHook(var Message: TMessage): Boolean;
begin
  if Message.Msg = WM_ACTIVATEAPP then
    CloseDropped(false);

  result := false;
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.WMKillFocus(var Message: TWMSetFocus);
begin
  CloseDropped(false);
  Term;
  UpdateBorder;
  inherited;
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.HookEditWndProc;
var
  style: integer;
  fEditHandle: THandle;
begin
  if not fhooked and IsWinEditAvailable then
  begin
    fhooked := true;
    fEditHandle := TWinControl(fEdit).Handle;
    style := GetWindowLong(fEditHandle, GWL_EXSTYLE);
    SetWindowlong(fEditHandle, GWL_EXSTYLE, style and not WS_EX_NOPARENTNOTIFY);
    fOldWndProc := pointer(GetWindowLong(fEditHandle, GWL_WNDPROC));
    SetWindowLong(fEditHandle, GWL_WNDPROC, Longint(MakeObjectInstance(EditWndProc)));
    finstance := pointer(GetWindowLong(fEditHandle, GWL_WNDPROC));
    TMWinControl(fEdit).TabStop := true;
    inherited TabStop := false;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.UnHookEditWndProc;
begin
  if Assigned(fEdit) and (fEdit is TWinControl) and
    TWinControl(fEdit).HandleAllocated and fhooked then
  begin
    fhooked := false;
    if pointer(GetWindowLong(TWinControl(fEdit).Handle, GWL_WNDPROC)) = finstance then
      SetWindowLong(TWinControl(fEdit).Handle, GWL_WNDPROC, Longint(fOldWndProc));

    FreeObjectInstance(finstance);
    inherited TabStop := true;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.EditWndProc(var Message: TMessage);
var
  IsKeyMessage: boolean;
  l: longint;
  pt: TSmallPoint;
  form: TCustomForm;
  shiftstate: TShiftState;
  ischange: boolean;
  foldtext: string;
  _Dropped: boolean;
  needDrop: boolean;
  Mask: integer;
  ChangeKeyPreview: boolean;
  fSaveKeyPreview: boolean;
begin
  if csDestroying in ComponentState then
  begin
    with message do
      Result := CallWindowProc(fOldWndProc, TWinControl(fEdit).Handle, Msg, WParam, LParam);

    exit;
  end;

  try
    IsKeyMessage := false;
    _Dropped := fDropped;
    needDrop := false;

    if not (csDesigning in ComponentState) then
      with Message do
      begin
        l := GetMessagePos;
        pt.X := LOWORD(l);
        pt.Y := HIWORD(l);
        pt := PointToSmallPoint(ScreenToClient(SmallPointToPoint(pt)));
        shiftstate := KeysToShiftState(wParam);

        case Msg of
          WM_LBUTTONDOWN:
            begin
              fLostFocus := false;
              MouseDown(mbLeft, shiftstate, pt.X, pt.Y);
              result := 0;
              if not Focused or fLostFocus then
                exit;
            end;

          WM_LBUTTONUP: needDrop := fDropOnClick and not _Dropped and fEditClicked;

          WM_RBUTTONUP:
            begin
              Result := Perform(Msg, WParam, lParam);
              if result = 1 then
                exit;
            end;

          WM_LBUTTONDBLCLK:
            begin
              shiftstate := KeysToShiftState(wParam);
              if not _Dropped then
                Include(ShiftState, ssDouble);

              MouseDown(mbLeft, ShiftState, pt.X, pt.Y);
              result := 0;
              exit;
            end;
        end;

        if Msg = CN_KEYDOWN then
        begin
          if fDropped then
          begin
            result := 0;
            exit;
          end;
          try
            if TWMKeyDown(Message).CharCode = VK_RETURN then
              Term;
          except
            Result := 0;
            raise;
          end;
        end;

        IsKeyMessage := (Msg = WM_KEYDOWN) or (Msg = WM_SYSKEYDOWN) or (Msg = WM_KEYUP) or (Msg = WM_CHAR);
        if IsKeyMessage then
          if fDropped then
          begin
            result := fDropWindow.Perform(Msg, WParam, LParam);
            if (TWMKey(Message).CharCode = VK_UP) and (Msg = WM_SYSKEYDOWN) then
              DoKeyDown(TWMKeyDown(Message));

            exit;
          end
          else if not IsEditDroppedDown then
          begin
            case Msg of

              WM_CHAR: DoKeyPress(TWMChar(Message));

              WM_KEYDOWN,
                WM_SYSKEYDOWN: DoKeyDown(TWMKeyDown(Message));
            end;
          end;
      end;

    if not fDropped then
      with Message do
      begin
        if (Msg = CM_ENTER) {or (Msg = CM_EXIT)} then
          self.Perform(Msg, 0, 0)

        else if (Msg = WM_KILLFOCUS) then
        begin
          fLostFocus := true;
          form := GetParentForm(self);
          if form.visible and not ((THandle(wParam) = form.Handle) or IsChild(form.handle, wParam)) then
            Term;
        end;
      end;

    with TWMKey(Message) do
      ischange := (Msg = WM_CHAR) or IsKeyMessage and ((KeyDataToShiftState(KeyData) <> []) or (CharCode = VK_DELETE));

    with Message do
    begin
      if ischange then
        foldtext := text;

      if (Msg = CN_KEYDOWN) then
        with TWMKey(Message) do
        begin
          case CharCode of
            VK_TAB: Mask := DLGC_WANTTAB;
            VK_LEFT, VK_RIGHT, VK_UP, VK_DOWN: Mask := DLGC_WANTARROWS;
            VK_RETURN, VK_EXECUTE, VK_ESCAPE, VK_CANCEL: Mask := DLGC_WANTALLKEYS;
            else
              Mask := 0;
          end;

          if (Perform(WM_GETDLGCODE, 0, 0) and Mask <> 0) then
            exit;
        end;

      form := GetParentForm(self);
      ChangeKeyPreview := (form <> nil) and ((Msg = WM_KEYDOWN) or (Msg = WM_CHAR) or (Msg = WM_SYSKEYDOWN));

      if ChangeKeyPreview then
      begin
        fSaveKeyPreview := form.KeyPreview;
        form.KeyPreview := false;
      end
      else
        fSaveKeyPreview := false;

      if isChange then
        if EditSource <> nil then
          EditSource.StartEdit;

      try
        Result := CallWindowProc(fOldWndProc, TWinControl(fEdit).Handle, Msg, WParam, LParam);
      finally
        if ChangeKeyPreview then
          form.KeyPreview := fSaveKeyPreview;
      end;

      if Msg = WM_GETDLGCODE then
        result := result or Perform(WM_GETDLGCODE, wParam, LParam);

      if not _Dropped and (Msg = WM_LBUTTONDOWN) or (Msg = WM_LBUTTONUP) then
        fEditClicked := csClicked in fEdit.ControlState;

      if Msg = CN_KEYDOWN then
        if (result = 1) and (Perform(CM_WANTSPECIALKEY, TWMKeyDown(Message).CharCode, 0) = 1) then
          result := 0;

      if (Msg = WM_SETFOCUS) and fHideCaret then
        windows.HideCaret(TWinControl(fEdit).Handle);
    end;

    if not fDropped then
    begin
      if needDrop then
        Drop;

      if ischange and (text <> foldtext) then
        Change;

      if (Message.Msg = WM_KILLFOCUS) and DisplayFocused then
      begin
        Invalidate;
        Update;
      end;
    end;

  except
    Application.HandleException(self);
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  if Assigned(fEdit) then
  begin
    fEdit.Enabled := enabled;
    fEdit.Invalidate;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.CMFontChanged(var Message: TMessage);
begin
  inherited;
  AdjustHeight;
end;


{------------------------------------------------------------------}

procedure TCustomDCEdit.CreateWnd;
begin
  CloseDropped(false);
  inherited;
  RestoreSavedText;
  AdjustEditorSize;
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.DestroyWnd;
begin
  fSavedText := Text;
  inherited;
end;
{$ELSE}

{------------------------------------------------------------------}

procedure TCustomDCEdit.CreateWidget;
begin
  CloseDropped(false);
  inherited;
  RestoreSavedText;
  AdjustEditorSize;
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.DestroyWidget;
begin
  fSavedText := Text;
  inherited;
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.DoEnter;
begin
  fFlat := False;
  if fSkipEnter then
  begin
    fSkipEnter := false;
    exit;
  end;

  inherited;
  UpdateBorder;
  if IsWinEditAvailable then
  begin
    fSkipEnter := true;
    TWinControl(fEdit).SetFocus;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.DoExit;
begin
  fFlat := True;
  try
    Term;
  except
    SelectAll;
    SetFocus;
    raise;
  end;
  UpdateBorder;
  inherited;
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.BoundsChanged;
begin
  inherited;
  AdjustEditorSize;
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.CursorChanged;
begin
  inherited;
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.VisibleChanged;
begin
  if fDropped then
    CloseDropped(false);
  inherited;
end;

{------------------------------------------------------------------}

function  TCustomDCEdit.GetText : TCaption;
begin
  if Assigned(fEdit) then
    result := TMControl(fEdit).GetText
  else
    result := '';

end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.SetText(const Value : TCaption);
begin
  if Assigned(fEdit) then
    with TMControl(fEdit) do
      if Self.GetText <> Value then
      begin
        fSavedText := Value;
        SetText(Value);
        Change;
      end;
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.FontChanged;
begin
  inherited;
  AdjustHeight;
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.EnabledChanged;
begin
  inherited;
  if Assigned(fEdit) then
  begin
    fEdit.Enabled := enabled;
    fEdit.Invalidate;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.ColorChanged;
begin
  inherited;
  if Assigned(fEdit) then
    TMControl(fEdit).Color := self.Color;
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.TextChanged;
begin
  inherited;
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.MouseEnter(AControl: TControl);
begin
  inherited;
  fFlat := false;
  UpdateBorder;
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.MouseLeave(AControl: TControl);
begin
  inherited;
  fFlatTimer := true;
  fFlat := true;
end;

{$ENDIF}

{------------------------------------------------------------------}

procedure FreeDCEditResources(Instance : TCustomDCEdit);

  procedure _FreeHandle(AControl : TControl);
  begin
    if (AControl is TWinControl) and not AControl.Visible then
      TMWinControl(AControl).DestroyHandle;
  end;

var
  i : integer;
begin
  with Instance do
    for i := 0 to ControlCount - 1 do
      _FreeHandle(Controls[i]);
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.Loaded;
var
  s: string;
begin
  inherited Loaded;

  if firstLoad then
  begin
    s := fEditSourceType;
    fEditSourceType := '';
    SetEditSourceType(s);

    s := fEditClass;
    fEditClass := '';
    SetEditClass(s);
    if Assigned(fEdit) then
      fEdit.Parent := self;

    s := fPopupClassName;
    fPopupClassName := '';
    SetPopupClassName(s);

    firstload := false;
  end;

  SetButtonBounds;
  if Focused then
    {$IFNDEF CLX}
    Perform(CM_MOUSEENTER, 0, 0);
    {$ELSE}
    MouseEnter(Self);
    {$ENDIF}

  FreeDCEditResources(self);
end;

{------------------------------------------------------------------}


procedure TCustomDCEdit.Paint;
begin
  inherited;
  DrawBorder;
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.DrawBorder;
var
  R: TRect;

  {------------------------------------------------------}

  procedure _DrawPixels;
  begin
    with Canvas do
    begin
      {$IFNDEF CLX}
      Pixels[0, self.Height - 1] := clBtnFace;
      Pixels[self.width - 1, 0] := clBtnFace;
      {$ELSE}
      Pen.Color := clBtnFace;
      DrawPoint(0, self.Height - 1);
      DrawPoint(self.width - 1, 0);
      {$ENDIF}
    end;
  end;

  {------------------------------------------------------}

begin
  if not (Flat or UseDreamBorder) then
    exit;

  r := Rect(0, 0, Width - 1, Height - 1);

  with Canvas, R, Pen do
    if (csDesigning in ComponentState) or
      (not Flat) or (not IsFlat) then
    begin
      Brush.Color := clBtnFace;
      _FrameRect(Canvas, R);
      OffsetRect(R, 1, 1);
      _FrameRect(Canvas, R);
      _DrawPixels;
      OffsetRect(R, -1, -1);
      if Is3DLine and UseDreamBorder then
      begin
        Color := GetTopLineColor;
        MoveTo(Left + 1, Bottom - 1);
        LineTo(Right, Bottom - 1);
        Color := GetBottomLineColor;
        MoveTo(Left + 1, Bottom);
        LineTo(Right, Bottom);
      end
      else if IsSingleBorder then
      begin
        R := Rect(0, 0, Self.Width, Self.Height);
        {$IFNDEF CLX}
        if DreamBorderStyle = dbsSunkenSingle then
          DrawEdge(Canvas.Handle, R, EDGE_SUNKEN, BF_RECT)
        else
          DrawEdge(Canvas.Handle, R, EDGE_RAISED, BF_RECT);
        {$ELSE}
        if DreamBorderStyle = dbsSunkenSingle then
          DrawEdge(Canvas, R, esLowered, esNone, ebRect)
        else
          DrawEdge(Canvas, R, esRaised, esNone, ebRect);

        {$ENDIF}
      end
      else if (UseDreamBorder) and
        (DreamBorderStyle in [dbsLine, dbsLineBorder]) then
      begin
        Color := LineColor;
        MoveTo(Left, Bottom);
        LineTo(Right, Bottom);
        if (DreamBorderStyle = dbsLineBorder) then
        begin
          LineTo(Right, Top);
          LineTo(Left, Top);
          LineTo(Left, Bottom);
        end;
      end
      else if not (UseDreamBorder and (DreamBorderStyle = dbsNone)) then
      begin
        Color := GetBottomLineColor;
        MoveTo(Left + 1, Bottom);
        LineTo(Right, Bottom);
        LineTo(Right, Top - 1);
        Color := GetTopLineColor;
        MoveTo(Right - 1, Top);
        LineTo(Left, Top);
        LineTo(Left, Bottom);
      end;
    end
    else
    begin
      Brush.Color := clBtnFace;
      _FrameRect(Canvas, R);
      OffsetRect(R, 1, 1);
      _FrameRect(Canvas, R);
      _DrawPixels;
    end;
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.GetTabOrderList(List: TList);
{var
  form: TCustomForm;}
begin
  {  if List.Count = 0 then
      begin
        Parent.GetTabOrderList(List);
        exit;
      end;

    form := GetParentForm(self);
    if Assigned(form) and IsWinEditAvailable and (form.ActiveControl = fEdit) then
      with List do
        begin
          Remove(Last);
          Add(fEdit);
        end
   else}
  inherited GetTabOrderList(List);
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.PostValue(var Msg: TMessage);
var
  _nobroadcast: boolean;
begin
  _nobroadcast := fNoBroadCast;
  fNoBroadCast := true;
  try
    Term;
  finally
    fNoBroadCast := _nobroadcast;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.AlignControls(AControl: TControl; var Rect: TRect);
begin
  //
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.ValidateEditorClass(var c: TControlClass);
begin

end;

{------------------------------------------------------------------}

function TCustomDCEdit.GetDefaultEditorClass: TControlClass;
begin
  result := TDCSimpleEdit;
end;

{------------------------------------------------------------------}

function TCustomDCEdit.GetDefaultPopupClass: TWinControlClass;
begin
  result := TPopupListBox;
end;

{------------------------------------------------------------------}
{$IFNDEF CLX}
procedure TCustomDCEdit.SetParent(AParent: TWinControl);
{$ELSE}
procedure TCustomDCEdit.SetParent(const AParent:  TWidgetControl);
{$ENDIF}
begin
  inherited SetParent(AParent);
  if Assigned(AParent) and UseDefaultEditor and not finitialized then
  begin
    EditorClass := GetDefaultEditorClass;
    PopupClass := GetDefaultPopupClass;
    if PopupClass <> nil then
      fPopupClassName := PopupClass.ClassName
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.SetCaption(const val: TCaption);
begin
  if val = fCaption then
    exit;

  fCaption := val;
  Invalidate;
end;

{------------------------------------------------------------------}
{$IFNDEF CLX}
function TCustomDCEdit.IsEditDroppedDown: boolean;
begin
  Result := IsEditAvailable and
  LongBool(Edit.Perform(CB_GETDROPPEDSTATE, 0, 0));
end;
{$ENDIF}

{------------------------------------------------------------------}

procedure TCustomDCEdit.SetButtonBounds;
var
  x1: integer;
  ydelta: integer;
begin
  if not HandleAllocated then
    exit;

  if IsSingleBorder then
    ydelta := 2
  else
    ydelta := byte(Flat or UseDreamBorder);

  if NumButtons = 2 then
  begin
    x1 := ClientWidth - fButton2.Width - ydelta;
    fButton2.SetBounds(x1, ydelta, fButton2.Width, ClientHeight - ydelta * 2);
  end
  else
    x1 := ClientWidth - ydelta;

  if NumButtons > 0 then
    fButton1.SetBounds(x1 - fButton1.Width, ydelta, fButton1.Width, ClientHeight - ydelta * 2);
  {$IFNDEF CLX}
  SetEditRect;
  {$ENDIF}
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.Term;
begin
  if (ExceptObject <> nil) or fexcept or fInTerm then
    exit;

  fInTerm := true;
  try
    DoTerm;
  finally
    fInTerm := false;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.KeyPress(var Key: Char);
begin
  if key in [#13, #27] then
  begin
    if Assigned(OnKeyPress) then
      OnKeyPress(Self, Key);

    key := #0;
    exit;
  end;
  inherited;
end;

{------------------------------------------------------------------}

type
  TSelection = record
    StartPos, EndPos: word;
  end;

procedure TCustomDCEdit.KeyDown(var Key: Word; Shift: TShiftState);
var
  Alt: boolean;
  form: TCustomForm;
  processed: boolean;
begin
  Alt := ssAlt in Shift;
  form := GetParentForm(self);

  inherited KeyDown(Key, Shift);

  processed := true;

  case Key of
    VK_UP:
      if Alt then
      begin
        if fDropped then
          CloseDropped(true);
      end
      else
        TMWinControl(Parent).SelectNext(form.ActiveControl, false, true);

    VK_DOWN:
      if Alt then
        begin
          if fButton1.visible then
            Drop
          else
            processed := false;
        end
      else
        TMWinControl(Parent).SelectNext(form.ActiveControl, true, true);

    VK_RETURN: processed := not fDropped;

    else
      processed := false;
  end;

  if processed then
    key := 0;
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.AdjustEditorSize;
begin
  SetButtonBounds;
end;

{------------------------------------------------------------------}


procedure TCustomDCEdit.UpdateBorder;
begin
  if not (Flat or UseDreamBorder) then
    exit;

  if byte(IsFlat) <> fOldFlat then
  begin
    DrawBorder;
    fButton1.Invalidate;
    fButton2.Invalidate;
    fOldFlat := byte(IsFlat);
  end;
end;

{------------------------------------------------------------------}

function TCustomDCEdit.IsEditAvailable: boolean;
begin
  result := Assigned(fEdit) and
    (not (fEdit is TWinControl) or TWinControl(fEdit).HandleAllocated);
end;

{------------------------------------------------------------------}

function TCustomDCEdit.IsWinEditAvailable: boolean;
begin
  result := (fEdit is TWinControl) and TWinControl(fEdit).HandleAllocated;
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.Deselect;
begin
  if IsEditAvailable then
  {$IFNDEF CLX}
    fEdit.Perform(EM_SETSEL, -1, -1);
  {$ELSE}
    if fEdit is TCustomEdit then
      TCustomEdit(fEdit).ClearSelection;
  {$ENDIF}
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.SelectAll;
begin
  if IsEditAvailable then
  {$IFNDEF CLX}
    fEdit.Perform(EM_SETSEL, 0, -1);
  {$ELSE}
    if fEdit is TCustomEdit then
      TCustomEdit(fEdit).SelectAll;
  {$ENDIF}
end;

{------------------------------------------------------------------}

function TCustomDCEdit.GetModified: Boolean;
begin
  if IsEditAvailable then
  {$IFNDEF CLX}
    Result := fEdit.Perform(EM_GETMODIFY, 0, 0) <> 0
  {$ELSE}
    if fEdit is TCustomEdit then
      Result := TCustomEdit(fEdit).Modified
    else
      Result := fModified
  {$ENDIF}
  else
    Result := fModified;
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.SetModified(val: boolean);
begin
  if IsEditAvailable then
  {$IFNDEF CLX}
    fEdit.Perform(EM_SETMODIFY, byte(val), 0)
  {$ELSE}
    if fEdit is TCustomEdit then
      TCustomEdit(fEdit).Modified := val
    else
      fModified := val
  {$ENDIF}
  else
    fModified := val;
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.SetHideCaret(val: boolean);
begin
  if fHideCaret <> val then
  begin
    fHideCaret := val;
    if val and IsWinEditAvailable then
    {$IFNDEF CLX}
      windows.HideCaret(TWinControl(fEdit).Handle);
    {$ENDIF}
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.SetFocus;
begin
  if not (visible and enabled) then
    exit;

  if IsWinEditAvailable then
  begin
    TWinControl(fEdit).SetFocus;
    {$IFNDEF CLX}
    windows.SetFocus(TWinControl(fEdit).Handle);
    {$ENDIF}
    if DisplayFocused then
      fEdit.Invalidate;
    fflat := false;
    UpdateBorder;
  end
  else
    inherited SetFocus;
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.SetEdit1Click(val: TNotifyEvent);
begin
  fOnEdit1Click := val;
  if fButton1 <> nil then
    fButton1.OnClick := val;
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.SetEdit2Click(val: TNotifyEvent);
begin
  fOnEdit2Click := val;
  if fButton2 <> nil then
    fButton2.OnClick := val;
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.SetDroppedDown(val: boolean);
begin
  if (val = fDropped) then
    exit;

  if val then
    Drop
  else
    CloseDropped(true);
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.SetDropValue;
var
  t: string;
begin
  if Assigned(fDropWindow) then
  begin
    t := text;
    {$IFNDEF CLX}
    fdropwindow.Perform(WM_SETTEXT, 0, longint(@(t[1])));
    {$ELSE}
    TMWinControl(fdropwindow).SetText(t);
    {$ENDIF}
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.GetDropValue;
{$IFNDEF CLX}
var
  newtext: array[0..255] of char;
{$ENDIF}
begin
  if not Assigned(fDropWindow) then
    exit;

  {$IFNDEF CLX}
  StrPCopy(newtext, Text);
  fdropwindow.Perform(WM_GETTEXT, 256, longint(@newtext));

  if newtext[0] <> #0 then
  begin
    Text := StrPas(newtext);
    Change;
  end;
  {$ELSE}
  Text := TMWinControl(fdropwindow).Text;
  Change;
  {$ENDIF}
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.Drop;
var
  p: TPoint;
  x: integer;
  y: integer;
  {$IFNDEF CLX}
  drophandle: THandle;
  {$ENDIF}
begin
  fEditClicked := false;
  if (fDropWindow <> nil) and not (fDropWindow is TDummyPopup) and not fdropped then
  begin
    fDropWindow.ClientWidth := ClientWidth;
    if Assigned(fOnDropDown) then
      fOnDropDown(self);
    {$IFNDEF CLX}
    drophandle := fDropWindow.Handle;
    {$ENDIF}

    SetDropValue;
    p := Parent.ScreenToClient(ClientOrigin);

    inc(p.y, Clientheight);
    y := p.y;
    if UseDreamBorder then
      x := p.x
    else
      x := p.x - 2;
    //Align drop down to the left like standard controls
    if fDropWindow.Width > Width then
      Dec(x, fDropWindow.Width - Width)
    else if fDropWindow.width < Width then
      fDropWindow.width := Width;

    if x < 0 then
      x := p.x - 2;

    //      p := Parent.ClientToScreen(Point(Parent.ClientWidth, Height));
    SetFocus;
    p := Parent.ClientToScreen(Point(x, y));

    if p.y + fDropWindow.Height > Screen.Height then
      p.y := p.y - fDropWindow.Height - self.height;
    {$IFNDEF CLX}
    SetWindowPos(drophandle, HWND_TOPMOST, p.x, p.y, fDropWindow.Width, fDropWindow.Height,
      SWP_NOACTIVATE or SWP_SHOWWINDOW);
    {$ELSE}
    fDropWindow.Left := p.x;
    fDropWindow.Top := p.y;
    {$ENDIF}
    fDropWindow.Visible := true;
    //      fDropWindow.parent := self;
    pwindow := fDropWindow;
    cedit := self;

    {$IFNDEF CLX}
    WHook := SetWindowsHookEx(WH_MOUSE, @CallWndProcHook, 0, GetCurrentThreadId);
    Application.HookMainWindow(AppHook);
    SetTimer(Handle, 1, 20, nil);
    {$ENDIF}
    
    //      fDropWindow.SetFocus;
    //      windows.SetFocus(drophandle);
    fDropped := true;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.CloseDropped(dochange: boolean);
var
  _text: string;
  _ntext: string;
begin
  fEditClicked := false;
  if fDropped then
  begin
    {$IFNDEF CLX}
    RemoveHooks;
    KillTimer(Handle, 1);
    Application.UnhookMainWindow(AppHook);

    SetWindowPos(fDropWindow.Handle, 0, 0, 0, 0, 0, SWP_NOZORDER or
      SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or SWP_HIDEWINDOW);
    {$ENDIF}

    fDropWindow.Visible := false;
    try
      if GetParentForm(self).Focused then
        SetFocus;

      if dochange then
      begin
        GetDropValue;
        if Assigned(fEditSource) then
        begin
          _text := Text;
          fEditSource.Value := _text;
          _ntext := fEditSource.Value;
          if _ntext <> _text then
            Text := _ntext;
        end;
      end;
    finally
      fDropWindow.TabStop := false;
      fDropped := False;
      SelectAll;
    end;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.SetPopupClassName(const val: string);
var
  c: TWinControlClass;
  i: integer;
  found: boolean;
begin
  if val = fPopupClassName then
    exit;

  fPopupClassName := val;

  if csReading in ComponentState then
    exit;

  FreeObject(fDropWindow,fDropWindow);
  c := TWinControlClass(GetClass(val));

  found := false;
  for i := 0 to PopupClasses.Count - 1 do
    if TPopupClassInfo(PopupClasses[i]).c = c then
    begin
      found := true;
      break;
    end;

  if c = nil then
    exit;

  if not found then
    c := TDummyPopup;

  for i := 1 to ComponentCount - 1 do
    if (Components[i].ClassName = c.ClassName) then
    begin
      fDropWindow := TWinControl(Components[i]);
      break;
    end;

  if fDropWindow = nil then
    fDropWindow := c.Create(self);

  with fDropWindow do
  begin
    Visible := false;
    ControlStyle := fDropWindow.ControlStyle + [csNoDesignVisible] - [csCaptureMouse];
    TabStop := false;
    Parent := self;
  end;

  //  if HandleAllocated then
  inc(fskipCreateHandle);
  try
    {$IFNDEF CLX}
    windows.SetParent(fDropWindow.Handle, 0);
    {$ENDIF}
  finally
    dec(fSkipCreateHandle);
  end;
end;

{------------------------------------------------------------------}

function TCustomDCEdit.GetPopup: TWinControlClass;
begin
  result := nil;
  if fDropWindow <> nil then
    result := TWinControlClass(fDropWindow.ClassType);
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.SetPopup(val: TWinControlClass);
begin
  if (fDropWindow <> nil) and (val = fDropWindow.ClassType) then
    exit;

  fDropWindow.Free;

  if val = nil then
  begin
    fDropWindow := nil;
    exit;
  end;

  fDropWindow := val.Create(self);
  fDropWindow.Parent := self;
  {$IFNDEF CLX}
  windows.SetParent(fDropWindow.Handle, 0);
  {$ENDIF}
end;

{------------------------------------------------------------------}

function TCustomDCEdit.GetEditorClass: TControlClass;
begin
  result := TControlClass(fEdit);
  if result <> nil then
    result := TControlClass(fedit.ClassType);
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.SetEditorClass(val: TControlClass);
begin
  if (fEdit = nil) or (val <> fEdit.ClassType) then
  begin
    {$IFNDEF CLX}
    UnHookEditWndProc;
    {$ENDIF}
    fEdit.Free;
    ValidateEditorClass(val);
    if val = nil then
    begin
      fEdit := nil;
      exit;
    end;

    fEdit := val.Create(self);
    fEdit.Parent := self;

    {$IFNDEF CLX}
    if fEdit is TWinControl then
      TMWinControl(fEdit).Ctl3D := false;
    {$ENDIF}

    TMControl(fEdit).Color := self.Color;

    if fEdit is TEdit then
      TEdit(fEdit).BorderStyle := bsNone;
    if fEdit is TWinControl then
      TMWinControl(fEdit).CreateHandle;

    SetButtonBounds;
    {$IFNDEF CLX}
    HookEditWndProc;
    {$ENDIF}
  end;
  fEdit.Parent := self;
  fEdit.Enabled := enabled;
  fEdit.BringTofront;
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.SetEditClass(const val: string);
var
  c: TControlClass;
  i: integer;
  found: boolean;
begin
  if val = fEditClass then
    exit;

  fEditClass := val;

  if csReading in ComponentState then
    exit;

  {$IFNDEF CLX}
  UnHookEditWndProc;
  {$ENDIF}
  FreeObject(fEdit,fEdit);
  c := TControlClass(GetClass(val));

  found := false;
  for i := 0 to EditClasses.Count - 1 do
    if TEditClassInfo(EditClasses[i]).c = c then
    begin
      found := true;
      break;
    end;

  if not found then
  begin
    c := TDCSimpleEdit;
  end;

  for i := 1 to ComponentCount - 1 do
    if (Components[i].ClassName = c.ClassName) then
    begin
      fEdit := TControl(Components[i]);
      break;
    end;

  if fEdit = nil then
  begin
    fEdit := c.Create(self);
    fEdit.Parent := self;
  end;

  if fEdit is TWinControl then
  begin
    {$IFNDEF CLX}
    TMWinControl(fEdit).Ctl3D := false;
    ShowWindow(TWinControl(fEdit).Handle, SW_SHOW);
    {$ELSE}
    TWinControl(fEdit).Show;
    {$ENDIF}
  end;

  TMControl(fEdit).Color := self.Color;
  if fEdit is TEdit then
    TEdit(fEdit).BorderStyle := bsNone;
  SetButtonBounds;
  {$IFNDEF CLX}
  HookEditWndProc;
  {$ENDIF}
  fEdit.Parent := self;
  CheckReadOnly
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.SetEditSourceType(const val: string);
var
  c: TEditSourceClass;
  i: integer;
  found: boolean;
begin
  if val = fEditSourceType then
    exit;

  fEditSourceType := val;

  if csReading in ComponentState then
    exit;

  FreeObject(fEditSource,fEditSource);
  c := TEditSourceClass(GetClass(val));

  found := false;
  for i := 0 to EditSourceClasses.Count - 1 do
    if TEditSourceClassInfo(EditSourceClasses[i]).c = c then
    begin
      found := true;
      break;
    end;

  if not found then
    c := TDummyEditSource;

  for i := 1 to ComponentCount - 1 do
    if (Components[i].ClassName = c.ClassName) then
    begin
      fEditSource := TEditSource(Components[i]);
      exit;
    end;

  fEditSource := c.Create(self);
end;

{------------------------------------------------------------------}

{$IFDEF D3}

procedure TCustomDCEdit.GetChildren(Proc: TGetChildProc; Root: TComponent);
{$ELSE}

procedure TCustomDCEdit.GetChildren(Proc: TGetChildProc);
{$ENDIF}
begin
  if Assigned(fdropwindow) and (PopupWindowClass <> '') then
    Proc(fdropwindow);

  if Assigned(feditsource) and (EditSourceClass <> '') then
    Proc(feditsource);

  if Assigned(fedit) and (EditClass <> '') then
    Proc(fedit);

  {$IFDEF D3}
  inherited GetChildren(Proc, Root);
  {$ELSE}
  inherited GetChildren(Proc);
  {$ENDIF}
end;

{------------------------------------------------------------------}

function TCustomDCEdit.GetChildOwner: TComponent;
begin
  result := self;
end;

{------------------------------------------------------------------}

function TCustomDCEdit.GetChildParent: TComponent;
begin
  result := self;
end;

{------------------------------------------------------------------}


procedure TCustomDCEdit.SetDisplayFocused(val: boolean);
begin
  if fDisplayFocused = val then
    exit;

  fDisplayFocused := val;
  Invalidate;
end;

{------------------------------------------------------------------}

function TCustomDCEdit.GetDisplayFocused: boolean;
begin
  result := fDisplayFocused and not fAlive;
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.SetNumButtons(val: integer);
begin
  if (fNumButtons = val) or not (val in [0, 1, 2]) then
    exit;

  fNumButtons := val;
  fButton1.Visible := val > 0;
  fButton2.Visible := val > 1;
  SetButtonBounds;
end;

{------------------------------------------------------------------}

function TCustomDCEdit.GetFlat: boolean;
begin
  result := Flat and fFlat and not (Focused or (csDesigning in ComponentState));
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.SetAlive(val: boolean);
begin
  if val = Flat then
    exit;
  fAlive := val;
  fOldFlat := 2; //Force a repaint
  if not val then //Calculate the current state
    fFlat := False
  else
    fFlat := not (Focused or (csDesigning in ComponentState));
  {$IFNDEF CLX}
  RecreateWnd;
  {$ELSE}
  RecreateWidget;
  {$ENDIF}
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.SetDreamBorderStyle(val: TDreamBorderStyle);
begin
  if val = fDreamBorderStyle then
    exit;
  fDreamBorderStyle := val;
  {$IFNDEF CLX}
  RecreateWnd;
  {$ELSE}
  RecreateWidget;
  {$ENDIF}
  AdjustEditorSize;
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.SetUseDreamBorder(val: boolean);
begin
  if val = fUseDreamBorder then
    exit;
  fUseDreamBorder := val;
  {$IFNDEF CLX}
  RecreateWnd;
  {$ELSE}
  RecreateWidget;
  {$ENDIF}
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.SetLineColor(val: TColor);
begin
  if val = fLineColor then
    exit;
  fLineColor := val;
  if (UseDreamBorder) and
    (DreamBorderStyle in [dbsLine, dbsLineBorder]) then
    DrawBorder;
end;

{------------------------------------------------------------------}

function TCustomDCEdit.GetReadOnly: boolean;
begin
  result := fReadOnly;
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.CheckReadOnly;
var
  rdonly: boolean;
  {$IFDEF D6}
  PropInfo: PPropInfo;
  {$ENDIF}
begin
  if IsEditAvailable then
  begin
    rdonly := GetReadOnly or HideCaret;
    {$IFNDEF CLX}
    fEdit.Perform(EM_SETREADONLY, Ord(rdonly), 0);
    {$ELSE}
    if fEdit is TCustomEdit then
      TMCustomEdit(fEdit).ReadOnly := true;
    {$ENDIF}
    {$IFDEF D6}
    PropInfo := GetPropInfo(fEdit, 'ReadOnly');
    if PropInfo <> nil then
    {$ENDIF}
      SetPropValue(fEdit, 'ReadOnly', rdonly); //don't resource
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.SetReadOnly(val: boolean);
begin
  if fReadOnly <> val then
  begin
    fReadOnly := val;
    CheckReadOnly;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.SetBorderStyle(val: TBorderStyle);
begin
  if (val = fBorderStyle) then
    exit;

  fBorderStyle := val;
  {$IFNDEF CLX}
  RecreateWnd;
  {$ELSE}
  RecreateWidget;
  {$ENDIF}
  AdjustEditorSize;
end;

{------------------------------------------------------------------}

{procedure TCustomDCEdit.CMTABSTOPCHANGED(var Message: TMessage);
begin
  inherited;
  if IsWinEditAvailable then
  begin
    inherited TabStop := false;
    TWinControl(fEdit).TabStop := FRealTabStop;
  end
  else
    inherited TabStop := true;
end;}

{------------------------------------------------------------------}

procedure TCustomDCEdit.SetRealTabStop(Value: Boolean);
begin
  if FRealTabStop <> Value then
  begin
    FRealTabStop := Value; 
    if IsWinEditAvailable then
    begin
      inherited TabStop := false;
      TWinControl(fEdit).TabStop := FRealTabStop;
    end
    else
      inherited TabStop := true;
  end;
end;

{------------------------------------------------------------------}

function TCustomDCEdit.Focused: boolean;
begin
  result := inherited Focused;
  if IsWinEditAvailable then
    result := result or TWinControl(fEdit).Focused;
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.Changed;
begin
  {$IFDEF D3}
  inherited;
  {$ENDIF}
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.AdjustHeight;         
{$IFNDEF CLX}
var
  dc: THandle;
  SaveFont: THandle;
  i: Integer;
  SysMetrics: TTextMetric;
  Metrics: TTextMetric;
begin
  dc := GetDC(0);
  GetTextMetrics(dc, SysMetrics);
  SaveFont := SelectObject(dc, Font.Handle);
  GetTextMetrics(dc, Metrics);
  SelectObject(dc, SaveFont);
  ReleaseDC(0, dc);
  if NewStyleControls then
    i := GetSystemMetrics(SM_CYBORDER) * (6 + byte(Ctl3D or Flat) * 2)
  else
    i := min(SysMetrics.tmHeight, Metrics.tmHeight) div 4 + GetSystemMetrics(SM_CYBORDER) * 4;
  Height := Metrics.tmHeight + i;
  {$ELSE}
begin
  Height := abs(Font.Height) + SM_CYBORDER * (6 + byte(Flat) * 2);
  {$ENDIF}
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.Change;
begin
  if Assigned(fOnChange) then
    fOnChange(self);

  Changed;
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.Click;
begin
  if IsEditAvailable then
    TMControl(fEdit).Click;
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.RestoreSavedText;
begin
  if fSavedText <> '' then
    Text := fSavedText;
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  CloseDropped(false);
  inherited MouseDown(Button, Shift, X, Y);
  if not (csDesigning in ComponentState) and
    (CanFocus or (GetParentForm(Self) = nil)) then
    SetFocus;

  if ssDouble in Shift then
    DblClick;
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.DoTerm;
begin
  if Assigned(fEditSource) then
    fEditSource.Value := Text;
end;

{------------------------------------------------------------------}

procedure TCustomDCEdit.UpdateButtonCount;
begin
  NumButtons := byte(Button1.Visible) + byte(Button2.Visible);
end;

{------------------------------------------------------------------}

function TCustomDCEdit.GetTopLineColor: TColor;
begin
  if (fDreamBorderStyle in [dbsRaisedBorder, dbsRaisedLine]) then
    Result := clBtnHighlight
  else
    Result := clBtnShadow;
end;

{------------------------------------------------------------------}

function TCustomDCEdit.GetBottomLineColor: TColor;
begin
  if (fDreamBorderStyle in [dbsRaisedBorder, dbsRaisedLine]) then
    Result := clBtnShadow
  else
    Result := clBtnHighlight;
end;

{------------------------------------------------------------------}

function TCustomDCEdit.Is3DLine: boolean;
begin
  Result := (FDreamBorderStyle in [dbsSunkenLine, dbsRaisedLine]);
end;

{------------------------------------------------------------------}

function TCustomDCEdit.IsSingleBorder: boolean;
begin
  Result := (UseDreamBorder) and
    (FDreamBorderStyle in [dbsSunkenSingle, dbsRaisedSingle]);
end;

{******************************************************************}

procedure TButtonParams.SetKind(val: TButtonKind);
begin
  if fKind = val then
    exit;

  fKind := val;
  if val = bkDropDown then
    fButton.Glyph := fDropDownGlyph
  else if val = bkDots then
    fButton.Glyph := fDotsGlyph;

  SetNumGlyphs(GetNumGlyphs);
end;

{------------------------------------------------------------------}

procedure TButtonParams.GlyphChanged(Sender: TObject);
begin
  if (fKind = bkCustom) and (fWidth = 0) then
  begin
    fButton.Width := fButton.Glyph.Width + 4;
    SizeChanged;
  end
  else
    fButton.Invalidate;
end;

{------------------------------------------------------------------}

procedure TButtonParams.SetGlyph(val: TBitmap);
begin
  fKind := bkCustom;
  fButton.Layout := blGlyphLeft;
  fButton.Glyph := val;
  GlyphChanged(nil);
end;

{------------------------------------------------------------------}

function TButtonParams.GetGlyph: TBitmap;
begin
  result := fButton.Glyph;
end;

{------------------------------------------------------------------}

procedure TButtonParams.SetWidth(val: integer);
begin
  if val = fButton.Width then
    exit;

  if val <> 0 then
    fButton.Width := val
  else if fKind <> bkCustom then
    {$IFNDEF CLX}
    fButton.Width := GetSystemMetrics(SM_CXHTHUMB);
    {$ELSE}
    fButton.Width := SM_CXHTHUMB;
    {$ENDIF}
  fWidth := val;
  SizeChanged;
end;

{------------------------------------------------------------------}

procedure TButtonParams.SetNumGlyphs(val: TNumGlyphs);
begin
  if fKind = bkCustom then
    fButton.NumGlyphs := val
  else
    fButton.NumGlyphs := 1;
end;

{------------------------------------------------------------------}

function TButtonParams.GetNumGlyphs: TNumGlyphs;
begin
  result := fButton.NumGlyphs;
end;

{------------------------------------------------------------------}

function TButtonParams.IsCustom: boolean;
begin
  result := Kind = bkCustom;
end;

{------------------------------------------------------------------}

procedure TButtonParams.SizeChanged;
begin
  if Assigned(OnSizeChanged) then
    OnSizeChanged;
end;

{------------------------------------------------------------------}

function TButtonParams.GetVisible: boolean;
begin
  result := fbutton.Visible;
end;

{------------------------------------------------------------------}

procedure TButtonParams.SetVisible(val: boolean);
begin
  fButton.Visible := val;
  TCustomDCEdit(fButton.Parent).UpdateButtonCount;
end;

{------------------------------------------------------------------}

function TButtonParams.GetHint: string;
begin
  result := fbutton.Hint;
end;

{------------------------------------------------------------------}

function TButtonParams.GetShowHint: boolean;
begin
  result := fbutton.ShowHint;
end;

{------------------------------------------------------------------}

function TButtonParams.GetParentShowHint: boolean;
begin
  result := fbutton.ParentShowHint;
end;

{------------------------------------------------------------------}

procedure TButtonParams.SetShowHint(val: boolean);
begin
  fButton.ShowHint := val;
end;

{------------------------------------------------------------------}

procedure TButtonParams.SetHint(const val: string);
begin
  fButton.Hint := val;
end;

{------------------------------------------------------------------}

procedure TButtonParams.SetParentShowHint(val: boolean);
begin
  fButton.ParentShowHint := val;
end;

{******************************************************************}

constructor TDCSimpleEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  {$IFNDEF CLX}
  Ctl3D := false;
  {$ENDIF}
  BorderStyle := bsNone;
end;

{------------------------------------------------------------------}

{$IFNDEF CLX}
procedure TDCSimpleEdit.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := (Params.Style {or ES_MULTILINE } or WS_CLIPCHILDREN) and not WS_BORDER;
    ExStyle := ExStyle and not WS_EX_CLIENTEDGE;
  end;
  //  inherited CreateParams(Params);
  //  Params.Style := Params.Style or ES_MULTILINE or WS_CLIPCHILDREN;
end;

{------------------------------------------------------------------}

procedure TDCSimpleEdit.CMEnter(var Message: TCMGotFocus);
begin
  if not (csLButtonDown in ControlState) then
    SelectAll;

  inherited;
end;
{$ELSE}
{------------------------------------------------------------------}

procedure TDCSimpleEdit.DoEnter;
begin
  if not (csLButtonDown in ControlState) then
    SelectAll;
  inherited;
end;


{$ENDIF}

{******************************************************************}

{$IFDEF D3}
{$IFNDEF CLX}

constructor TDCDtEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Ctl3D := false;
  CalAlignment := dtaRight;
  ShowCheckBox := true;
end;

{------------------------------------------------------------------}

procedure TDCDtEdit.SetParent(AParent: TWinControl);
begin
  inherited;
  if not firstsetparent then
  begin
    if Owner is TCustomDCEdit then
      TCustomDCEdit(Owner).NumButtons := 0;
    firstsetparent := true;
  end;
end;

{------------------------------------------------------------------}

procedure TDCDtEdit.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := DTS_SHORTDATEFORMAT or WS_CHILD;
    if Kind = dtkTime then
      Style := Style or DTS_TIMEFORMAT;
  end;
end;

{------------------------------------------------------------------}

procedure TDCDtEdit.CreateWnd;
begin
  inherited CreateWnd;
  SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) and not WS_EX_CLIENTEDGE);
  if Owner is TCustomDCEdit then
    TCustomDCEdit(Owner).SetEditRect;
end;

{------------------------------------------------------------------}

procedure TDCDtEdit.WMSetText(var Msg: TMessage);
begin
  SetText(StrPas(pchar(Msg.Lparam)));
end;

{------------------------------------------------------------------}

procedure TDCDtEdit.WMGetText(var Msg: TMessage);
begin
  StrPCopy(pchar(Msg.lparam), GetText);
end;

{------------------------------------------------------------------}

procedure TDCDtEdit.GetModified(var Msg: TMessage);
begin
  Msg.result := integer(fmodified);
end;

{------------------------------------------------------------------}

procedure TDCDtEdit.WMGetTextLength(var Msg: TMessage);
begin
  Msg.result := length(GetText);
end;

{------------------------------------------------------------------}

procedure TDCDtEdit.CNNotify(var Message: TWMNotify);
begin
  with Message, Message.NMHdr^ do
    case code of
      DTN_CLOSEUP: fdropped := false;
      DTN_DROPDOWN: fdropped := true;
      DTN_DATETIMECHANGE: fmodified := true;
    end;

  inherited;
end;

{------------------------------------------------------------------}

procedure TDCDtEdit.GetDropped(var Message: TMessage);
begin
  Message.result := integer(fdropped);
end;

{******************************************************************}

procedure TDCDateEdit.SetText(const val: string);
var
  ST: TSystemTime;
begin
  time := 0;
  if val = '' then
  begin
    date := 0;
    DateTime_SetSystemTime(Handle, GDT_NONE, ST);
  end
  else
    date := StrToDateTime(val);
end;

{------------------------------------------------------------------}

function TDCDateEdit.GetText: string;
begin
  if checked then
    result := DateToStr(date)
  else
    result := '';
end;

{******************************************************************}

constructor TDCTimeEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  kind := dtkTime;
  ShowCheckBox := true;
end;

{------------------------------------------------------------------}

procedure TDCTimeEdit.SetText(const val: string);
var
  ST: TSystemTime;
begin
  date := 0;
  if val = '' then
  begin
    time := 0;
    DateTime_SetSystemTime(Handle, GDT_NONE, ST);
  end
  else
    time := StrToTime(val);
end;

{------------------------------------------------------------------}

function TDCTimeEdit.GetText: string;
begin
  if checked then
    result := TimeToStr(time)
  else
    result := '';
end;

{------------------------------------------------------------------}

procedure TDCTimeEdit.CNNotify(var Message: TWMNotify);
begin
  with Message, Message.NMHdr^ do
    if code = DTN_DATETIMECHANGE then
    begin
      fmodified := true;
      exit;
    end;

  inherited;
end;
{$ENDIF}
{$ENDIF}

{******************************************************************}

function GetItemHeight(Font: TFont): integer;
{$IFNDEF CLX}
var
  dc: THandle;
  SaveFont: THandle;
  Metrics: TTextMetric;
begin
  dc := GetDC(0);
  SaveFont := SelectObject(dc, Font.Handle);
  GetTextMetrics(dc, Metrics);
  SelectObject(dc, SaveFont);
  ReleaseDC(0, dc);
  Result := Metrics.tmHeight + 1;
{$ELSE}
begin
  result := abs(Font.Height) + 1;
{$ENDIF}
end;

{------------------------------------------------------------------}

function GetItemWidth(Font: TFont; const s: string): Integer;
var
{$IFNDEF CLX}
  dc: THandle;
  SaveFont: THandle;
  size: TSize;
{$ELSE}
  Canvas : TCanvas;
{$ENDIF}
begin
{$IFNDEF CLX}
  dc := GetDC(0);
  SaveFont := SelectObject(DC, Font.Handle);
  GetTextExtentPoint32(dc, @(s[1]), length(s), Size);
  SelectObject(DC, SaveFont);
  ReleaseDC(0, DC);
  Result := size.cx;
{$ELSE}
  Canvas := TCanvas.Create;
  try
    Canvas.Font := Font;
    result := Canvas.TextWidth(s);
  finally
    Canvas.Free;
  end;
{$ENDIF}
end;

{------------------------------------------------------------------}
{$IFNDEF CLX}
const
  Styles: array[TListBoxStyle] of Longint =
  {$IFNDEF D6}
    (0, LBS_OWNERDRAWFIXED, LBS_OWNERDRAWVARIABLE);
  {$ELSE}
    (0, LBS_OWNERDRAWFIXED, LBS_OWNERDRAWVARIABLE, LBS_OWNERDRAWFIXED,
     LBS_OWNERDRAWFIXED);
  {$ENDIF}

{$ENDIF}
constructor TPopupListBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csNoDesignVisible];
  visible := false;
  TabStop := false;
end;

{------------------------------------------------------------------}
{$IFNDEF CLX}
const
  Sorteds: array[boolean] of longint = (0, LBS_SORT);
  DrawStyles: array[boolean] of integer = (0, LBS_OWNERDRAWFIXED);

procedure TPopupListBox.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := WS_CHILD or WS_BORDER or WS_VSCROLL or LBS_NOTIFY or LBS_HASSTRINGS or
      Styles[self.Style] or Sorteds[Sorted] or DrawStyles[fCustomDraw];
    ExStyle := {WS_EX_TOPMOST or } WS_EX_TOOLWINDOW;
    WindowClass.Style := WindowClass.Style or CS_SAVEBITS;
  end;
end;

{------------------------------------------------------------------}

procedure TPopupListBox.CreateHandle;
begin
  inherited;
  BuildList;
end;

{------------------------------------------------------------------}

procedure TPopupListBox.WMLButtonDown(var Message: TWMLButtonDown);
var
  ItemNo: integer;
begin
  with Message do
  begin
    ItemNo := ItemAtPos(SmallPointToPoint(Message.Pos), True);
    if ItemNo <> -1 then
      Perform(LB_SETCURSEL, ItemNo, 0);
  end;
end;

{------------------------------------------------------------------}

procedure TPopupListBox.WMMouseMove(var Message: TWMMouseMove);
var
  ItemNo: integer;
  pt: TPoint;
  oldItem: integer;
begin
  with Message do
    if (word(GetAsyncKeyState(VK_LBUTTON)) and $8000) <> 0 then
    begin
      pt := SmallPointToPoint(Message.Pos);
      ItemNo := ItemAtPos(pt, True);
      OldItem := Perform(LB_GETCURSEL, 0, 0);
      if ItemNo = -1 then
      begin
        if pt.Y > ClientHeight then
          if OldItem < Items.Count - 1 then
            ItemNo := OldItem + 1;

        if pt.Y < 0 then
          if OldItem > 0 then
            ItemNo := OldItem - 1;
      end;

      if (ItemNo <> -1) and (ItemNo <> OldItem) then
        Perform(LB_SETCURSEL, ItemNo, 0);
    end;
end;

{------------------------------------------------------------------}

procedure TPopupListBox.GetText(var Msg: TMessage);
var
  index: integer;
begin
  index := Perform(LB_GETCURSEL, 0, 0);

  if index <> -1 then
    Perform(LB_GETTEXT, index, Msg.LParam)
  else
    pchar(Msg.LParam)^ := #0;
end;

{------------------------------------------------------------------}

procedure TPopupListBox.SetText(var Msg: TMessage);
begin
  Perform(LB_SETCURSEL, Perform(LB_FINDSTRING, -1, Msg.LParam), 0);
  AdjustHeight;
end;

{------------------------------------------------------------------}

procedure TPopupListBox.CNCommand(var Message: TWMCommand);
begin
  if Message.NotifyCode = LBN_SELCHANGE then
    if Owner is TCustomDCEdit then
      TCustomDCEdit(Owner).Change;
end;

{------------------------------------------------------------------}

procedure TPopupListBox.CMWantSpecialKey(var Message: TCMWantSpecialKey);
begin
  inherited;
  if (Message.CharCode = VK_ESCAPE) then
    Message.result := 1;
end;

{------------------------------------------------------------------}

procedure TPopupListBox.CMFontChanged(var Message: TMessage);
begin
  inherited;
  ResetItemHeight;
  RecreateWnd;
end;
{$ELSE}

{------------------------------------------------------------------}

procedure TPopupListBox.CreateWidget;
begin
  inherited;
  BuildList;
end;

{------------------------------------------------------------------}

procedure TPopupListBox.MouseDown(Button : TMouseButton; Shift : TShiftState; X, Y : integer);
var
  ItemNo : integer;
begin
  inherited;
  ItemNo := ItemAtPos(Point(X, Y));
  if ItemNo <> -1 then
    Selected[ItemNo] := true;
end;

{------------------------------------------------------------------}

procedure TPopupListBox.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited;
end;

{------------------------------------------------------------------}

function  TPopupListBox.GetText : TCaption;
begin
  result := Items.Text;
end;

{------------------------------------------------------------------}

procedure TPopupListBox.SetText(const Value : TCaption);
begin
  Items.Text := Value;
  AdjustHeight;
end;

{------------------------------------------------------------------}

procedure TPopupListBox.FontChanged;
begin
  inherited;
  ResetItemHeight;
  RecreateWidget;
end;

{$ENDIF}
{------------------------------------------------------------------}

procedure TPopupListBox.AdjustHeight;
var
  i : integer;
begin
  i := Items.Count;

  if i > 7 then
    i := 7
  else if i < 1 then
    i := 1;

  ClientHeight := ItemHeight * i;
end;

const
  ColorWidth = 22;

{------------------------------------------------------------------}

{$IFNDEF CLX}
procedure TPopupColorBox.DrawItem(Index: Integer; Rect: TRect;
  State: TOwnerDrawState);
{$ELSE}
function TPopupColorBox.DrawItem(Index: Integer; Rect: TRect;
  State: TOwnerDrawState) : boolean;
{$ENDIF}
var
  ARect: TRect;
  Text: array[0..255] of Char;
  Safer: TColor;
begin
  ARect := Rect;
  Inc(ARect.Top, 2);
  Inc(ARect.Left, 2);
  Dec(ARect.Bottom, 2);
  if FDisplayNames then
    ARect.Right := ARect.Left + ColorWidth
  else
    Dec(ARect.Right, 3);

  with Canvas do
  begin
    FillRect(Rect);
    Safer := Brush.Color;
    Pen.Color := clBlack;
    Rectangle(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
    Brush.Color := TColor(Items.Objects[Index]);
    InflateRect(ARect, -1, -1);
    FillRect(ARect);
    Brush.Color := Safer;
    if fDisplayNames then
    begin
      StrPCopy(Text, Items[Index]);
      Rect.Left := Rect.Left + ColorWidth + 6;
     {$IFNDEF CLX}
      DrawText(Canvas.Handle, Text, StrLen(Text), Rect, DT_SINGLELINE or
        DT_VCENTER or DT_NOPREFIX);
     {$ELSE}
     TextOut(Rect.Left, Rect.Top, TExt);
     {$ENDIF}
    end;
  end;
  {$IFDEF CLX}
  inherited DrawItem(Index, Rect, State);
  result := true;
  {$ENDIF}
end;

{$IFDEF CLX}

procedure TPopupListBox.InitWidget;
begin
  inherited;
  if FCustomDraw then
    Style := lbOwnerDrawFixed;
end;

{$ENDIF}
{------------------------------------------------------------------}

procedure TPopupListBox.Close(DoSelect: boolean);
begin
  if Owner is TCustomDCEdit then
    TCustomDCEdit(Owner).CloseDropped(DoSelect);
end;

{------------------------------------------------------------------}

procedure TPopupListBox.BuildList;
begin

end;

{------------------------------------------------------------------}

procedure TPopupListBox.MouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if (Button = mbLeft) then
    Close(PtInRect(ClientRect, Point(X, Y)));
end;

{------------------------------------------------------------------}

procedure TPopupListBox.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if ((Key = VK_RETURN) or (Key = VK_ESCAPE)) and (Shift = []) then
  begin
    Close(key <> VK_ESCAPE);
    key := 0;
    exit;
  end;
  inherited KeyDown(Key, Shift);
end;

{------------------------------------------------------------------}


procedure TPopupListBox.SetDisplayNames(val: Boolean);
begin
  if fDisplayNames <> val then
  begin
    fDisplayNames := val;
    Invalidate;
  end;
end;

{------------------------------------------------------------------}

procedure TPopupListBox.ResetItemHeight;
begin
  ItemHeight := Max(GetItemHeight(Font), 9);
end;

{******************************************************************}

const
  ColorsInList = 42;
  ColorValues: array[1..ColorsInList] of TColor = (
    clBlack, clMaroon, clGreen, clOlive, clNavy, clPurple, clTeal, clGray,
    clSilver, clRed, clLime, clYellow, clBlue, clFuchsia, clAqua, clWhite,
    clScrollBar, clBackground, clActiveCaption, clInactiveCaption, clMenu,
    clWindow, clWindowFrame, clMenuText, clWindowText, clCaptionText,
    clActiveBorder, clInactiveBorder, clAppWorkSpace, clHighlight,
    clHighlightText, clBtnFace, clBtnShadow, clGrayText, clBtnText,
    clInactiveCaptionText, clBtnHighlight, cl3DDkShadow, cl3DLight, clInfoText,
    clInfoBk, clNone);

  {------------------------------------------------------------------}

constructor TPopupColorBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Style := lbOwnerDrawFixed;
  fColorValue := clBlack;
  fDisplayNames := True;
end;

{------------------------------------------------------------------}

procedure TPopupColorBox.BuildList;
var
  i: integer;
begin
  Clear;
  for i := 1 to ColorsInList do
    Items.AddObject(ColorToString(ColorValues[I]), TObject(ColorValues[I]));
end;

{------------------------------------------------------------------}

procedure TPopupColorBox.SetColorValue(NewValue: TColor);
var
  i: integer;
  CurrentColor: TColor;
begin
  if (ItemIndex < 0) or (NewValue <> fColorValue) then
    for i := 0 to items.Count - 1 do
    begin
      CurrentColor := TColor(Items.Objects[i]);
      if CurrentColor = NewValue then
      begin
        fColorValue := NewValue;
        if ItemIndex <> i then
          ItemIndex := i;
        break;
      end;
    end;
end;

{------------------------------------------------------------------}

procedure TPopupColorBox.Click;
begin
  if ItemIndex >= 0 then
    fColorValue := TColor(Items.Objects[ItemIndex]);

  TCustomDCEdit(Owner).Changed;
  inherited Click;
end;

{------------------------------------------------------------------}
{$IFNDEF CLX}

procedure TPopupColorBox.GetText(var Msg: TMessage);
var
  index: integer;
begin
  index := Perform(LB_GETCURSEL, 0, 0);
  if index <> -1 then
  begin
    fColorValue := TColor(Items.Objects[index]);
    StrPCopy(pchar(Msg.LParam), Items[index]);
  end
  else
    pchar(Msg.LParam)^ := #0;
end;

{------------------------------------------------------------------}

procedure TPopupColorBox.SetText(var Msg: TMessage);
begin
  DoSetText;
end;
{$ELSE}

{------------------------------------------------------------------}

function  TPopupColorBox.GetText : TCaption;
begin
  if ItemIndex >= 0 then
  begin
    fColorValue := TColor(Items.Objects[ItemIndex]);
    result := ColorToString(fColorValue);
  end
  else
    result := '';
end;

{------------------------------------------------------------------}

procedure TPopupColorBox.SetText(const Value : TCaption);
begin
  DoSetText;
end;

{------------------------------------------------------------------}

{$ENDIF}

procedure TPopupColorBox.DoSetText;
var
  i : integer;
begin
  width := ColorWidth + 20;
  if fDisplayNames then
    width := width + GetItemWidth(Font, 'clInactiveCaptionText'); //don't resource

  SetColorValue(FColorValue);
  for i := 0 to Items.Count - 1 do
    if TCustomDCEdit(Owner).Text = Items[i] then
    begin
      ItemIndex := i;
      break;
    end;
end;

{******************************************************************}

constructor TPopupBrushBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Style := lbOwnerDrawFixed;
  fBrushValue := bsSolid;
  fDisplayNames := True;
  fBrush := TBrush.Create;
end;

{------------------------------------------------------------------}

destructor TPopupBrushBox.Destroy;
begin
  fBrush.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------}
const
  BrushesInList = 8;
  BrushNames: array[1..BrushesInList] of string = ('Solid', 'Clear', 'Horizontal', //don't resource
    'Vertical', 'FDiagonal', 'BDiagonal', 'Cross', 'DiagCross'); //don't resource

procedure TPopupBrushBox.BuildList;
var
  i: integer;
begin
  Clear;
  for i := 1 to BrushesInList do
    Items.AddObject(BrushNames[I], TObject(TBrushStyle(I)));
end;

{------------------------------------------------------------------}

procedure TPopupBrushBox.SetBrushValue(NewValue: TBrushStyle);
begin
  if (ItemIndex < 0) or (NewValue <> fBrushValue) then
  begin
    fBrushValue := NewValue;
    ItemIndex := integer(NewValue);
  end;
end;

{------------------------------------------------------------------}


{$IFNDEF CLX}
procedure TPopupBrushBox.DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState);
{$ELSE}
function TPopupBrushBox.DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState) : boolean;
{$ENDIF}
var
  ARect: TRect;
  foldbk: integer;
begin
  ARect := Rect;
  Inc(ARect.Top, 2);
  Inc(ARect.Left, 2);
  Dec(ARect.Bottom, 2);
  if FDisplayNames then
    ARect.Right := ARect.Left + ColorWidth
  else
    Dec(ARect.Right, 3);

  with Canvas do
  begin
    FillRect(Rect);
    Pen.Color := clBlack;
    Rectangle(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
    InflateRect(ARect, -1, -1);

    {$IFNDEF CLX}
    foldbk := SetBkColor(Handle, ColorToRGB(clInfoBk));
    {$ELSE}
    foldbk := Font.Color;
    Font.Color := clInfoBk;
    {$ENDIF}
    if TBrushStyle(Index) = bsClear then
    begin
      fBrush.Color := clInfoBk;
      fBrush.Style := bsSolid;
      {$IFNDEF CLX}
      windows.FillRect(Handle, ARect, fBrush.Handle);
      {$ELSE}
      FillRect(ARect);
      {$ENDIF}
    end
    else
    begin
      fBrush.Color := clBlack;
      fBrush.Style := TBrushStyle(Index);
      {$IFNDEF CLX}
      windows.FillRect(Handle, ARect, fBrush.Handle);
      {$ELSE}
      FillRect(ARect);
      {$ENDIF}
    end;

    {$IFNDEF CLX}
    SetBkColor(Handle, foldbk);
    {$ELSE}
    Font.Color := foldbk;
    {$ENDIF}
    if fDisplayNames then
    begin
      Rect.Left := Rect.Left + ColorWidth + 6;
      {$IFNDEF CLX}
      DrawText(Canvas.Handle, PChar(BrushNames[index + 1]), Length(BrushNames[index + 1]), Rect, DT_SINGLELINE or
        DT_VCENTER or DT_NOPREFIX);
      {$ELSE}
      TextOut(Rect.Left, Rect.Top, BrushNames[index + 1]);
      {$ENDIF}
    end;
  end;
  {$IFDEF CLX}
  inherited DrawItem(Index, Rect, State);
  result := true;
  {$ENDIF}
end;

{------------------------------------------------------------------}
{$IFNDEF CLX}
procedure TPopupBrushBox.GetText(var Msg: TMessage);
var
  index: integer;
begin
  index := Perform(LB_GETCURSEL, 0, 0);
  if index <> -1 then
  begin
    fBrushValue := TBrushStyle(index);
    StrPCopy(pchar(Msg.LParam), 'bs' + BrushNames[integer(fBrushValue) + 1]); //don't resource
  end
  else
    pchar(Msg.LParam)^ := #0;
end;

{------------------------------------------------------------------}

procedure TPopupBrushBox.SetText(var Msg: TMessage);
begin
  DoSetText;
end;

{------------------------------------------------------------------}

{$ELSE}
function  TPopupBrushBox.GetText : TCaption;
begin
  if ItemIndex >= 0 then
  begin
    fBrushValue := TBrushStyle(ItemIndex);
    result := 'bs' + BrushNames[integer(fBrushValue) + 1]; //don't resource
  end
  else
    result := '';
end;

{------------------------------------------------------------------}

procedure TPopupBrushBox.SetText(const Value : TCaption);
begin
  DoSetText;
end;

{$ENDIF}

{------------------------------------------------------------------}

procedure TPopupBrushBox.DoSetText;
var
  i : integer;
begin
  width := ColorWidth + 20;
  if fDisplayNames then
    width := width + GetItemWidth(Font, 'Horizontal'); //don't resource

  SetBrushValue(fBrushValue);
  for i := 1 to BrushesInList do
    if TCustomDCEdit(Owner).Text = 'bs' + BrushNames[i] then //don't resource
    begin
      ItemIndex := i - 1;
      break;
    end;
end;

{------------------------------------------------------------------}

procedure TPopupBrushBox.Click;
begin
  if ItemIndex >= 0 then
    fBrushValue := TBrushStyle(ItemIndex);

  inherited Click;
end;

{******************************************************************}

constructor TPopupPenBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Style := lbOwnerDrawFixed;
  fPenValue := psSolid;
end;

{------------------------------------------------------------------}

procedure TPopupPenBox.BuildList;
var
  i: integer;
  penmin: integer;
  penmax: integer;
begin
  Clear;
  with GetTypeData(TypeInfo(TPenStyle))^ do
  begin
    penmin := MinValue;
    penmax := MaxValue;
  end;
  for i := penmin to penmax do
  begin
    Items.AddObject(GetEnumName(TypeInfo(TPenStyle), i), TObject(i));
  end;
end;

{------------------------------------------------------------------}

procedure TPopupPenBox.SetPenValue(NewValue: TPenStyle);
begin
  if (ItemIndex < 0) or (NewValue <> fPenValue) then
  begin
    fPenValue := NewValue;
    ItemIndex := integer(NewValue);
  end;
end;

{------------------------------------------------------------------}

{$IFNDEF CLX}
procedure TPopupPenBox.DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState);
{$ELSE}
function TPopupPenBox.DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState) : boolean;
{$ENDIF}
var
  ARect : TRect;
  s     : string;
begin
  ARect := Rect;
  Inc(ARect.Top, 2);
  Inc(ARect.Left, 2);
  Dec(ARect.Bottom, 2);
  if FDisplayNames then
    ARect.Right := ARect.Left + ColorWidth
  else
    Dec(ARect.Right, 3);

  with Canvas do
  begin
    FillRect(Rect);
    Pen.Color := clBlack;
    Pen.Style := TPenStyle(index);
    MoveTo(ARect.Left, (ARect.Top + ARect.Bottom) div 2);
    LineTo(ARect.Right, (ARect.Top + ARect.Bottom) div 2);

    if fDisplayNames then
    begin
      Rect.Left := Rect.Left + ColorWidth + 6;
      s := GetEnumName(TypeInfo(TPenStyle), index);
      {$IFNDEF CLX}
      DrawText(Canvas.Handle, PChar(s), Length(s), Rect, DT_SINGLELINE or
        DT_VCENTER or DT_NOPREFIX);
      {$ELSE}
      TextOut(Rect.Left, Rect.Top, s)
      {$ENDIF}
    end;
  end;
  {$IFDEF CLX}
  inherited DrawItem(Index, Rect, State);
  result := true;
  {$ENDIF}
end;


{$IFNDEF CLX}

{------------------------------------------------------------------}

procedure TPopupPenBox.GetText(var Msg: TMessage);
var
  index: integer;
begin
  index := Perform(LB_GETCURSEL, 0, 0);
  if index <> -1 then
  begin
    fPenValue := TPenStyle(index);
    StrPCopy(pchar(Msg.LParam), GetEnumName(TypeInfo(TPenStyle), index));
  end
  else
    pchar(Msg.LParam)^ := #0;
end;

{------------------------------------------------------------------}

procedure TPopupPenBox.SetText(var Msg: TMessage);
begin
  DoSetText;
end;
{$ELSE}

{------------------------------------------------------------------}

function  TPopupPenBox.GetText : TCaption;
begin
  if ItemIndex >= 0 then
  begin
    fPenValue := TPenStyle(ItemIndex);
    result := GetEnumName(TypeInfo(TPenStyle), ItemIndex);
  end
  else
    result := '';
end;

{------------------------------------------------------------------}

procedure TPopupPenBox.SetText(const Value : TCaption);
begin
  DoSetText;
end;

{$ENDIF}

{------------------------------------------------------------------}

procedure TPopupPenBox.DoSetText;
begin
  width := ColorWidth + 20;
  if fDisplayNames then
    width := width + GetItemWidth(Font, 'InsideFrame'); //don't resource

  SetPenValue(fPenValue);
  ItemIndex := GetEnumValue(TypeInfo(TPenStyle), TCustomDCEdit(Owner).Text);
end;

{------------------------------------------------------------------}

procedure TPopupPenBox.Click;
begin
  if ItemIndex >= 0 then
    fPenValue := TPenStyle(ItemIndex);

  inherited Click;
end;

{******************************************************************}

constructor TGraphicEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csNoDesignVisible];
  {$IFNDEF CLX}
  ParentCtl3D := false;
  {$ENDIF}
end;

{------------------------------------------------------------------}
{$IFNDEF CLX}

procedure TGraphicEdit.WMSetText(var Msg: TMessage);
begin
  SetText(StrPas(pchar(Msg.Lparam)));
  if Owner is TCustomDCEdit then
    TCustomDCEdit(Owner).Change;
  Invalidate;
end;


{------------------------------------------------------------------}

procedure TGraphicEdit.WMGetText(var Msg: TMessage);
begin
  StrPCopy(pchar(Msg.lparam), Gettext);
end;

{------------------------------------------------------------------}

procedure TGraphicEdit.WMGetTextLength(var Msg: TMessage);
begin
  msg.result := length(GetText);
end;

{------------------------------------------------------------------}

procedure TGraphicEdit.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  Invalidate;
end;

{------------------------------------------------------------------}

procedure TGraphicEdit.CMPaintTo(var Msg: TPaintToMsg);
begin
  with Msg do
  begin
    PaintToCanvas(Canvas, X, Y);
    Result := 1;
  end;
end;

{------------------------------------------------------------------}

procedure TGraphicEdit.SetText(const val: string);
begin
  fText := val;
end;

{------------------------------------------------------------------}

function TGraphicEdit.GetText: string;
begin
  result := fText;
end;
{$ELSE}

{------------------------------------------------------------------}

function  TGraphicEdit.GetText : TCaption;
begin
  result := fText;
end;

{------------------------------------------------------------------}

procedure TGraphicEdit.SetText(const Value : TCaption);
begin
  fText := Value;
end;
{------------------------------------------------------------------}

procedure TGraphicEdit.EnabledChanged;
begin
  inherited;
  Invalidate;
end;

{$ENDIF}

{------------------------------------------------------------------}

procedure TGraphicEdit.Paint;
begin
  PaintToCanvas(Canvas, 0, 0);
end;

{----------------}

{$IFNDEF CLX}

procedure TGraphEdit.WMEraseBkgnd(var Message: TWmEraseBkgnd);
{$IFDEF D3}
var
  gr: TGraphic;
begin
  gr := GetGraphic;
  if (gr = nil) or gr.Transparent then
    {$ELSE}
begin
  {$ENDIF}
  inherited;
end;

{$ENDIF}

{------------------------------------------------------------------}

procedure TGraphEdit.PaintToCanvas(Canvas: TCanvas; X, Y: integer);
var
  r: TRect;
begin
  r := ClientRect;
  OffsetRect(r, X, Y);
  if (Owner is TCustomDCPropEditor) then
    Canvas.StretchDraw(r, GetGraphic);
end;

{******************************************************************}

constructor TColorEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fText := 'clBlack'; //don't resource
end;

{------------------------------------------------------------------}

{$IFNDEF CLX}

procedure TColorEdit.SetText(const val: string);
begin
  StringToColor(val);
  fText := val;
end;

{------------------------------------------------------------------}

procedure TColorEdit.PaintToCanvas(Canvas: TCanvas; X, Y: integer);
var
  ARect: TRect;
  Text: array[0..255] of Char;
  TempDC: THandle;
  Bitmap: THandle;
  OldBitmap: THandle;
  pen: THandle;
  brush: THandle;
  oldpen: THandle;
  oldfont: THandle;
  Size: TSize;
begin
  ARect := ClientRect;

  TempDC := CreateCompatibleDC(Canvas.Handle);
  Bitmap := CreateCompatibleBitmap(Canvas.Handle, ClientWidth, ClientHeight);
  OldBitmap := SelectObject(TempDC, Bitmap);
  pen := CreatePen(PS_SOLID, 1, ColorTORGB(clBlack));
  oldpen := SelectObject(TempDC, pen);

  ARect := ClientRect;
  Canvas.Brush.Color := Color;
  SetBkColor(TempDC, ColorToRGB(Canvas.Brush.color));
  FillRect(TempDC, ARect, Canvas.Brush.Handle);
  Inc(ARect.Top, 2);
  Inc(ARect.Left, 2);
  Dec(ARect.Bottom, 2);
  ARect.Right := ARect.Left + ColorWidth;

  brush := CreateSolidBrush(ColorToRGB(StringToColor(fText)));
  with ARect do
    Rectangle(TempDC, Left, Top, Right, Bottom);

  InflateRect(ARect, -1, -1);
  FillRect(TempDC, ARect, brush);

  StrPCopy(Text, copy(fText, 3, length(fText) - 2));
  ARect := ClientRect;
  ARect.Left := ARect.Left + ColorWidth + 6;
  oldfont := SelectObject(TempDC, Font.Handle);
  SetTextColor(TempDC, GetTextColor(Canvas.Handle));

  GetTextExtentPoint32(TempDC, Text, length(Text), Size);
  OffsetRect(ARect, 0, (ARect.Bottom - ARect.Top - Size.cy) div 2);
  if Enabled then
    ExtTextOut(TempDC, ARect.Left, ARect.Top, ETO_CLIPPED { or ETO_OPAQUE},
      @ARect, Text, StrLen(Text), nil)
  else
  begin
    SetTextColor(TempDC, ColorToRGB(clBtnShadow));
    DrawText(TempDC, Text, StrLen(Text), ARect, 0);
  end;

  if (Owner is TCustomDCEdit) and TCustomDCEdit(Owner).DisplayFocused and TCustomDCEdit(Owner).Focused then
    DrawFocusRect(TempDC, ClientRect);

  BitBlt(Canvas.Handle, X, Y, ClientWidth, ClientHeight, TempDC, 0, 0, SRCCOPY);

  SelectObject(TempDC, oldfont);
  SelectObject(TempDC, oldpen);
  DeleteObject(pen);
  DeleteObject(brush);
  SelectObject(TempDC, oldbitmap);
  DeleteObject(Bitmap);
  DeleteDC(TempDC);
end;
{$ELSE}

{------------------------------------------------------------------}

procedure TColorEdit.SetText(const Value : TCaption); 
begin
  StringToColor(Value);
  fText := Value;
end;

{$ENDIF}

{******************************************************************}
{$IFNDEF CLX}

const
  PenStyles: array[TPenStyle] of integer = (ps_Solid, ps_Dash, ps_Dot, ps_DashDot,
    ps_DashDotDot, ps_Null, ps_InsideFrame);

procedure TPenStyleEdit.PaintToCanvas(Canvas: TCanvas; X, Y: integer);
var
  ARect: TRect;
  cy: integer;
  mpen: THandle;
  oldpen: THandle;
  dc: THandle;
begin
  dc := Canvas.Handle;
  ARect := ClientRect;
  OffsetRect(ARect, X, Y);
  FillRect(dc, ARect, Brush.Handle);
  mpen := CreatePen(PenStyles[TPenStyle(GetEnumValue(TypeInfo(TPenStyle), fText))], 1, ColorToRGB(clBlack));
  oldpen := SelectObject(dc, mpen);
  cy := (ARect.Top + ARect.Bottom) div 2;

  MoveToEx(dc, ARect.Left + 2, cy, nil);
  LineTo(dc, ARect.Right - 2, cy);

  SelectObject(dc, oldpen);
  DeleteObject(mpen);

  if (Owner is TCustomDCEdit) and TCustomDCEdit(Owner).DisplayFocused and TCustomDCEdit(Owner).Focused then
  begin
    //      SelectClipRgn(dc, 0);
    DrawFocusRect(dc, ARect);
  end;
end;

{------------------------------------------------------------------}

procedure TPenStyleEdit.SetText(const val: string);
begin
  ftext := val;
end;
{$ELSE}

{------------------------------------------------------------------}

procedure TPenStyleEdit.SetText(const Value : TCaption);
begin
  ftext := Value;
end;

{$ENDIF}

{------------------------------------------------------------------}

constructor TPenStyleEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fText := 'psSolid'; //don't resource
end;

{******************************************************************}
{$IFNDEF CLX}

procedure TBrushStyleEdit.PaintToCanvas(Canvas: TCanvas; X, Y: integer);
var
  ARect: TRect;
  BRect: TRect;
  Size: TSize;
  oldbrush: THandle;
  foldbk: integer;
  tcolor: integer;
begin
  BRect := ClientRect;
  OffsetRect(BRect, X, Y);

  with Canvas do
  begin
    tcolor := GetTextColor(Canvas.Handle);
    ARect := BRect;
    Font := self.Font;
    Brush.Color := Color;
    FillRect(ARect);

    Inc(ARect.Top, 2);
    Inc(ARect.Left, 2);
    Dec(ARect.Bottom, 2);
    ARect.Right := ARect.Left + ColorWidth;
    Pen.Color := clBlack;
    foldbk := SetBkColor(Handle, ColorToRGB(clInfoBk));
    if fText <> 'bsClear' then //don't resource
    begin
      foldbrush.style := TBrushStyle(GetEnumValue(TypeInfo(TBrushStyle), fText));
      foldbrush.Color := clBlack;
    end
    else
    begin
      fOldBrush.Color := clInfoBk;
      fOldBrush.Style := bsSolid;
    end;

    oldbrush := SelectObject(Handle, foldbrush.handle);
    with ARect do
      windows.Rectangle(Handle, Left, Top, Right, Bottom);

    SetBkColor(Handle, foldbk);
    SelectObject(Handle, oldbrush);

    ARect := BRect;
    ARect.Left := ARect.Left + ColorWidth + 6;
    GetTextExtentPoint32(Handle, pchar(ftext) + 2, length(fText) - 2, Size);
    OffsetRect(ARect, 0, ((ARect.Bottom - ARect.Top - Size.cy) div 2));

    if Enabled then
    begin
      SetTextColor(Canvas.Handle, tcolor);
      windows.TextOut(Handle, ARect.Left, ARect.Top, PChar(fText) + 2, length(fText) - 2)
    end
    else
    begin
      Font.Color := ColorToRGB(clBtnShadow);
      DrawText(Handle, PChar(fText) + 2, Length(fText) - 2, ARect, 0);
    end;

    if (Owner is TCustomDCEdit) and TCustomDCEdit(Owner).DisplayFocused and TCustomDCEdit(Owner).Focused then
      DrawFocusRect(ClientRect);
  end;
end;

{------------------------------------------------------------------}

procedure TBrushStyleEdit.SetText(const val: string);
begin
  ftext := val;
end;
{$ELSE}

{------------------------------------------------------------------}

procedure TBrushStyleEdit.SetText(const Value : TCaption); 
begin
  ftext := Value;
end;

{$ENDIF}

{------------------------------------------------------------------}

constructor TBrushStyleEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fOldBrush := TBrush.Create;
  fOldBrush.Color := clBlack;
  fText := 'bsSolid'; //don't resource
end;

{------------------------------------------------------------------}

destructor TBrushStyleEdit.Destroy;
begin
  fOldBrush.Free;
  inherited Destroy;
end;

{******************************************************************}

constructor TCheckEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csNoDesignVisible] - [csDoubleClicks];
  ParentColor := false;
  Color := clWindow;
end;
{------------------------------------------------------------------}

{$IFNDEF CLX}
procedure TCheckEdit.WMEraseBkgnd(var Message: TWmEraseBkgnd);
begin
end;

{------------------------------------------------------------------}

procedure TCheckEdit.WMSetText(var Msg: TMessage);
begin
  if (Checked xor Invert) <> (byte(pchar(Msg.Lparam)^) and $5F in [byte('T'), byte('Y')]) then
  begin
    checked := not checked;
    Invalidate;
  end;

  fmodified := false;
end;

{------------------------------------------------------------------}

procedure TCheckEdit.WMGetText(var Msg: TMessage);
var
  s: string;
begin
  if checked xor Invert then
    s := 'True' //don't resource
  else
    s := 'False'; //don't resource

  StrPCopy(pchar(Msg.lparam), s);
end;

{------------------------------------------------------------------}

procedure TCheckEdit.WMGetTextLength(var Msg: TMessage);
begin
  if checked xor Invert then
    msg.result := 4
  else
    msg.result := 5;
end;

{------------------------------------------------------------------}

function TCheckEdit.GetWinStyle: integer;
begin
  result := DFCS_BUTTONCHECK;
end;

{------------------------------------------------------------------}

procedure TCheckEdit.PaintToCanvas(Canvas: TCanvas; X, Y: integer);
var
  style: integer;
  Bitmap: THandle;
  OldBitmap: THandle;
  TempDC: THandle;
  caption: string;
  Size: TSize;
  oldfont: THandle;
  r: TRect;
  csize: integer;
  cy: integer;
  ofs: integer;
begin
  style := GetWinStyle;
  if checked then
    style := style or DFCS_CHECKED;

  if not enabled then
    style := style or DFCS_INACTIVE;

  if cute then
    style := style or DFCS_FLAT;

  TempDC := CreateCompatibleDC(Canvas.Handle);
  Bitmap := CreateCompatibleBitmap(Canvas.Handle, ClientWidth, ClientHeight);
  OldBitmap := SelectObject(TempDC, Bitmap);
  SetBkColor(TempDC, ColorToRGB(Color));
  FillRect(TempDC, ClientRect, Canvas.Brush.Handle);
  if fScaled then
  begin
    csize := height;
    cy := 0;
  end
  else
  begin
    csize := min(height, DefaultCheckHeight);
    cy := (height - csize) div 2;
  end;

  if Owner is TCustomDCEdit then
  begin
    caption := TCustomDCEdit(Owner).Caption;
    ofs := TCustomDCEdit(Owner).EditOffset;
  end
  else
  begin
    caption := '';
    ofs := 2;
  end;

  DrawFrameControl(TempDC, Rect(ofs, cy, csize + ofs, cy + csize), DFC_BUTTON, style);

  if caption <> '' then
  begin
    oldfont := SelectObject(TempDC, self.Font.Handle);
    GetTextExtentPoint32(TempDC, pchar(caption), length(caption), Size);
    r := Rect(csize + 7, (Height - Size.cy) div 2, ClientWidth, ClientHeight);
    windows.DrawText(TempDC, PChar(caption), length(Caption), r, DT_CALCRECT);
    if enabled then
      windows.DrawText(TempDC, PChar(caption), length(Caption), r, DT_NOCLIP)
    else
    begin
      SetBkMode(TempDC, TRANSPARENT);
      OffsetRect(r, 1, 1);
      SetTextColor(TempDC, ColorToRGB(clBtnHighLight));
      DrawText(TempDC, PChar(Caption), Length(Caption), R, 0);

      OffsetRect(r, -1, -1);
      SetTextColor(TempDC, ColorToRGB(clBtnShadow));
      DrawText(TempDC, PChar(Caption), Length(Caption), R, 0);
      OffsetRect(r, -1, -1);
    end;

    InflateRect(r, 2, 0);
    if (Owner is TCustomDCEdit) and TCustomDCEdit(Owner).DisplayFocused and TCustomDCEdit(Owner).Focused then
      DrawFocusRect(TempDC, r);

    SelectObject(TempDC, oldfont);
  end;

  BitBlt(Canvas.Handle, X, Y, ClientWidth, ClientHeight, TempDC, 0, 0, SRCCOPY);

  SelectObject(TempDC, oldbitmap);
  DeleteObject(Bitmap);
  DeleteDC(TempDC);
end;

{------------------------------------------------------------------}

procedure TCheckEdit.CMPaintTo(var Msg: TPaintToMsg);
begin
  with Msg do
  begin
    PaintToCanvas(Canvas, X, Y);
    Result := 1;
  end;
end;

{------------------------------------------------------------------}

procedure TCheckEdit.GetModified(var Msg: TMessage);
begin
  Msg.result := ord(fmodified);
end;
{$ELSE}

{------------------------------------------------------------------}

procedure TCheckEdit.PaintToCanvas(Canvas: TCanvas; X, Y: integer);
begin
 //
end;

{------------------------------------------------------------------}

procedure TCheckEdit.SetText(const Value : TCaption);
begin

  if (Checked xor Invert) <> (byte(pchar(Value)^) and $5F in [byte('T'), byte('Y')]) then
  begin
    checked := not checked;
    Invalidate;
  end;

  fmodified := false;

end;

{------------------------------------------------------------------}

function TCheckEdit.GetWinStyle: integer;
begin
  result := 0;//DFCS_BUTTONCHECK;
end;


{$ENDIF}

{------------------------------------------------------------------}

procedure TCheckEdit.Paint;
begin
  Canvas.Brush.Color := Color;
  PaintToCanvas(Canvas, 0, 0);
end;

{------------------------------------------------------------------}


procedure TCheckEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if key = VK_SPACE then
    ChangeChecked;

  inherited;
end;

{------------------------------------------------------------------}

procedure TCheckEdit.ChangeChecked;
begin
  if TCustomDCEdit(Owner).ReadOnly then
    exit;

  checked := not checked;
  if Owner is TCustomDCEdit then
    TCustomDCEdit(Owner).Change;

  invalidate;
  fmodified := true;

  if Owner is TCustomDCEdit then
    TCustomDCEdit(Owner).Term;
end;

{------------------------------------------------------------------}

procedure TCheckEdit.Click;
var
  p: TPoint;
begin
  SetFocus;
  GetCursorPos(p);
  p := ScreenToClient(p);
  if PtInRect(Rect(0, 0, Height + 2, Height + 2), p) or fClickAnyWhere then
    ChangeChecked;
  if Assigned(OnClick) then
    OnClick(self);
end;

{------------------------------------------------------------------}

procedure TCheckEdit.SetCute(val: boolean);
begin
  if val = fCute then
    exit;

  fCute := val;
  Invalidate;
end;

{------------------------------------------------------------------}

procedure TCheckEdit.SetScaled(val: boolean);
begin
  if val = fScaled then
    exit;

  fScaled := val;
  Invalidate;
end;

{------------------------------------------------------------------}

procedure TCheckEdit.SetFocus;
begin
  inherited SetFocus;
  invalidate;
end;

{******************************************************************}

constructor TDCColorEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDropOnCLick := true;
end;

{------------------------------------------------------------------}

procedure TDCColorEdit.SetSelectedColor(Value: TColor);
begin
  Text := ColorToString(Value);
end;

{------------------------------------------------------------------}

function TDCColorEdit.GetSelectedColor: TColor;
begin
  result := StringToColor(Text);
end;

{------------------------------------------------------------------}

function TDCColorEdit.GetDefaultPopupClass: TWinControlClass;
begin
  result := TPopupColorBox;
end;

{------------------------------------------------------------------}

function TDCColorEdit.GetDefaultEditorClass: TControlClass;
begin
  result := TColorEdit;
end;

{------------------------------------------------------------------}

procedure TDCColorEdit.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  if not (csDesigning in ComponentState) and (Button = mbLeft) and (ssCtrl in Shift) then
    CallPropertyEdit(self, 'SelectedColor') //don't resource
  else
    inherited;
end;

{------------------------------------------------------------------}

procedure TDCColorEdit.DblClick;
begin
  inherited;
  CallPropertyEdit(self, 'SelectedColor'); //don't resource
end;

{******************************************************************}

constructor TDCPenStyleEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDropOnCLick := true;
end;

{------------------------------------------------------------------}

procedure TDCPenStyleEdit.SetPenStyle(Value: TPenStyle);
begin
  Text := GetEnumName(TypeInfo(TPenStyle), integer(Value));
end;

{------------------------------------------------------------------}

function TDCPenStyleEdit.GetPenStyle: TPenStyle;
begin
  result := TPenStyle(GetEnumValue(TypeInfo(TPenStyle), Text));
end;

{------------------------------------------------------------------}

function TDCPenStyleEdit.GetDefaultPopupClass: TWinControlClass;
begin
  result := TPopupPenBox;
end;

{------------------------------------------------------------------}

function TDCPenStyleEdit.GetDefaultEditorClass: TControlClass;
begin
  result := TPenStyleEdit;
end;

{******************************************************************}

type
  TMPersistent = class(TPersistent)
  end;

{******************************************************************}

constructor TRadioEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle - [csDoubleClicks];
end;

{------------------------------------------------------------------}

{$IFNDEF CLX}

function TRadioEdit.GetWinStyle: integer;
begin
  result := DFCS_BUTTONRADIO;
end;

{$ENDIF}

{------------------------------------------------------------------}

procedure TRadioEdit.Click;
begin
  SetFocus;
  if not checked then
    inherited
  else if Assigned(OnClick) then
    OnClick(self);
end;

{------------------------------------------------------------------}

procedure TRadioEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if (key = VK_SPACE) and checked then
    key := 0;

  inherited;
end;

{******************************************************************}

{******************************************************************}

constructor TDCBrushStyleEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDropOnCLick := true;
end;

{------------------------------------------------------------------}

procedure TDCBrushStyleEdit.SetBrushStyle(Value: TBrushStyle);
begin
  Text := GetEnumName(TypeInfo(TBrushStyle), Integer(Value));
end;

{----------------------------------------------------}

function TDCBrushStyleEdit.GetBrushStyle: TBrushStyle;
begin
  Result := TBrushStyle(GetEnumValue(TypeInfo(TBrushStyle), Text));
end;

{----------------------------------------------------}

function TDCBrushStyleEdit.GetDefaultEditorClass: TControlClass;
begin
  Result := TBrushStyleEdit;
end;

{----------------------------------------------------}

function TDCBrushStyleEdit.GetDefaultPopupClass: TWinControlClass;
begin
  Result := TPopupBrushBox;
end;

{******************************************************************}

{------TCustomFileDirEdit---------------------------------}

constructor TCustomFileDirEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  NumButtons := 1;
  Button1.Kind := bkCustom;
  OnButton1Click := Button1Click;
end;

{-----------------------------------------------------------}

{$IFNDEF CLX}

procedure TCustomFileDirEdit.CreateHandle;
begin
  inherited CreateHandle;
  if FAcceptFiles then SetDragAccept(True);
end;

{-----------------------------------------------------------}

procedure TCustomFileDirEdit.DestroyWindowHandle;
begin
  SetDragAccept(False);
  inherited DestroyWindowHandle;
end;

{-----------------------------------------------------------}

procedure TCustomFileDirEdit.SetDragAccept(Value: Boolean);
begin
  if not (csDesigning in ComponentState) and (HandleAllocated) then
    DragAcceptFiles(Handle, Value);
end;

{-----------------------------------------------------------}

procedure TCustomFileDirEdit.SetAcceptFiles(Value: Boolean);
begin
  if FAcceptFiles <> Value then
  begin
    SetDragAccept(Value);
    FAcceptFiles := Value;
  end;
end;

{-----------------------------------------------------------}

procedure TCustomFileDirEdit.WMDropFiles(var Message: TWMDropFiles);
begin
  if Assigned(FOnDropFiles) then
    FOnDropFiles(Self);
end;
{$ENDIF}

{--------TDCFileNameEdit-----------------------------------}

const
  SResFileEdit = 'DCFILENAMEEDIT'; //don't resource
  SResDirEdit = 'DCDIRECTORYEDIT'; //don't resource

constructor TDCFileNameEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Button1.Glyph.LoadFromResourceName(HInstance, SResFileEdit);
end;

{-----------------------------------------------------------}

{$IFNDEF CLX}

procedure TDCFileNameEdit.WMDropFiles(var Message: TWMDropFiles);
begin
  Text := DropFiles(false, false, #0, Message);
  inherited;
end;
{$ENDIF}

{-----------------------------------------------------------}

procedure TDCFileNameEdit.SetFileName(Value: string);
begin
  Text := Value
end;

{-----------------------------------------------------------}

function TDCFileNameEdit.GetFileName: string;
begin
  result := Text;
end;

{-----------------------------------------------------------}

procedure TDCFileNameEdit.Button1Click(Sender: TObject);
begin
  case FDialogKind of
    fdOpen: FDialog := TOpenDialog.Create(nil);
    fdSave: FDialog := TSaveDialog.Create(nil);
    {$IFDEF D3}
    {$IFNDEF CLX}
    fdOpenpicture: FDialog := TOpenPictureDialog.Create(nil);
    fdSavePicture: FDialog := TSavePictureDialog.Create(nil);
    {$ENDIF}
    {$ENDIF}

  end;
  with FDialog do
  try
    DefaultExt := FDefaultExt;
    Options := FDialogOptions;
    Title := FDialogTitle;
    FileName := Self.FileName;
    Filter := FFilter;
    {$IFNDEF CLX}
    FilterIndex := FFilterIndex;
    {$ENDIF}
    HelpContext := Self.HelpContext;
    InitialDir := FInitialDir;
    if Execute then
      Text := FileName;
  finally
    Free;
  end;
end;

{--------TDCDirectoryEdit--------------------------------------}

constructor TDCDirectoryEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Button1.Glyph.LoadFromResourceName(HInstance, SResDirEdit);
end;

{-----------------------------------------------------------}

{$IFNDEF CLX}

procedure TDCDirectoryEdit.WMDropFiles(var Message: TWMDropFiles);
begin
  Text := DropFiles(true, FMultipleDirs, ';', Message);
  inherited;
end;

{$ENDIF}

{-----------------------------------------------------------}

function GetLastDir(const dir: string): string;
begin
  result := dir;
  while pos(';', result) <> 0 do
    delete(result, 1, pos(';', result));
end;

{-----------------------------------------------------------}

procedure TDCDirectoryEdit.Button1Click(Sender: TObject);
var
  TempStr: string;
begin
  if Text <> '' then
    TempStr := GetLastDir(Text)
  else
    TempStr := FInitialDir;
  {$IFNDEF CLX}
  if QueryDirectory(SSelectDirectory, TempStr) then
  begin
    if (Text = '') or not FMultipleDirs then
      Text := TempStr
    else
      Text := Text + ';' + TempStr;
  end;
  {$ENDIF}
end;

{******************************************************************}

function TDCListBoxColumns.GetItem(Index: Integer): TDCListBoxColumn;
begin
  result := TDCListBoxColumn(inherited Items[Index]);
end;

{------------------------------------------------------------------}

procedure TDCListBoxColumns.SetItem(Index: Integer; Value: TDCListBoxColumn);
begin
  inherited Items[Index] := Value;
end;

{******************************************************************}

//BeginSkipConst

procedure _Register;
begin
  RegisterPopupClass(Typeinfo(string), nil, '', TPopupListBox);
  RegisterTextEditClass(TypeInfo(string), nil, '', TDCSimpleEdit);
  {$IFDEF USEMASKEDIT}
  RegisterTextEditClass(TypeInfo(string), nil, ' ', TDCMaskEdit);
  {$ENDIF}
  RegisterPopupClass(TypeInfo(TColor), nil, '', TPopupColorBox);
  RegisterEditClass(TypeInfo(TColor), nil, '', TColorEdit);
  RegisterEditClass(TypeInfo(TPenStyle), nil, '', TPenStyleEdit);
  RegisterPopupClass(TypeInfo(TPenStyle), nil, '', TPopupPenBox);
  RegisterEditClass(TypeInfo(TBrushStyle), nil, '', TBrushStyleEdit);
  RegisterPopupClass(TypeInfo(TBrushStyle), nil, '', TPopupBrushBox);
  RegisterEditClass(TypeInfo(Boolean), nil, '', TCheckEdit);

  {$IFDEF D3}
  {
    RegisterTextEditClass(TypeInfo(TDate), nil, '', TDCDateEdit);
    RegisterTextEditClass(TypeInfo(TTime), nil, '', TDCTimeEdit);
  }
  {$ENDIF}

  RegisterPopupClass(TypeInfo(Boolean), nil, '', nil);

  SafeRegisterClass(TDCSimpleEdit);
  SafeRegisterClass(TDummyEditSource);
  SafeRegisterClass(TDummyPopup);
end;

//EndSkipConst

{------------------------------------------------------------------}

procedure RunRegister;
begin
  _Register;
end;

{******************************************************************}

{$IFNDEF CLX}

procedure TDCListBox.CMFontChanged(var Message: TMessage);
begin
  inherited;
  AssignBold;
end;

{------------------------------------------------------------------}

procedure TDCListBox.CreateParams(var Params: TCreateParams);
begin
  inherited;

  if fCustomDraw then
  begin
    with Params do
      Style := Style or LBS_OWNERDRAWFIXED;

    AssignBold;
  end;
end;

{------------------------------------------------------------------}

procedure TDCListBox.LBADDSTRING(var Message: TMessage);
begin
  inherited;
  ResetColumnSize;
end;

{------------------------------------------------------------------}

procedure TDCListBox.LBINSERTSTRING(var Message: TMessage);
begin
  inherited;
  ResetColumnSize;
end;

{------------------------------------------------------------------}

procedure TDCListBox.LBDELETESTRING(var Message: TMessage);
begin
  inherited;
  ResetColumnSize;
end;

{------------------------------------------------------------------}

procedure TDCListBox.WMSETREDRAW(var Message: TMessage);
begin
  inherited;

  if Message.wParam = 0 then
    inc(FUpdateCount)
  else
    dec(FUpdateCount);

  ResetColumnSize;
end;

{------------------------------------------------------------------}

procedure TDCPopupListBox.HookProc(var Message: TMessage);
begin
  with Message do
    if (Msg >= WM_KEYFIRST) and (Msg <= WM_KEYLAST) then
      Perform(Msg, wParam, lParam)
    else
      Result := CallWindowProc(pointer(fOldWindProc), Parent.Handle, Msg, WParam, LParam);
end;

{------------------------------------------------------------------}

procedure TDCPopupListBox.CreateHandle;
begin
  inherited;
  windows.SetParent(handle, 0);
end;

{------------------------------------------------------------------}

procedure TDCPopupListBox.HookParent;
begin
  fOldWindProc := GetWindowLong(Parent.Handle, GWL_WNDPROC);
  SetWindowLong(Parent.Handle, GWL_WNDPROC, fHookProcInst);
end;

{------------------------------------------------------------------}

procedure TDCPopupListBox.UnHookParent;
begin
  if Parent.HandleAllocated then
    SetWindowLong(Parent.Handle, GWL_WNDPROC, fOldWindProc);
end;

{------------------------------------------------------------------}

function TDCPopupListBox.AppHook(var Message: TMessage): Boolean;
begin
  if Message.Msg = WM_ACTIVATEAPP then
    Close(false);

  result := false;
end;

{------------------------------------------------------------------}

procedure TDCPopupListBox.DestroyWnd;
begin
  UnHookParent;
  KillTimer(Handle, 1);
  inherited;
end;
{$ENDIF}

{------------------------------------------------------------------}

{$IFNDEF CLX}
procedure TDCListBox.DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState);
{$ELSE}
function TDCListBox.DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState) : boolean;
{$ENDIF}
var
  Pos: integer;
  BPos: integer;
  BLen: integer;
  cnt: integer;
  s: string;
  FAlign: TLeftRightAlign;
  ARect : TRect;
begin
  {$IFDEF CLX}
  if FDisableDraw then
  begin
    result := inherited DrawItem(Index, Rect, State);
    exit;
  end;
  {$ELSE}
  Canvas.FillRect(Rect);
  {$ENDIF}

  if Index < Items.Count then
  begin
    {$IFDEF CLX}
    with Canvas do
      if odSelected in State then
      begin
        Brush.Color := clHighlight;
        Font.Color := clHighlightText;
        FBoldFont.Color := clHighlightText;
        FillRect(Rect); ///
      end
      else
      begin
        Brush.Color := Self.Color;
        Font.Color := Self.Font.Color;
        FBoldFont.Color := Self.Font.Color;
      end;
    {$ENDIF}  
    inc(Rect.Left, 2);
    dec(Rect.Right, 2);
    Pos := 1;
    cnt := 0;
    while Pos <= Length(Items[Index]) do
    begin
      s := ExtractBoldPos(ExtractColumn(Items[Index], Pos), BPos, BLen);
      FAlign := ColumnAlign(cnt);
      ARect := Rect;
      ARect.Right := ARect.Left + ColumnSize(cnt);
      if FAlign = lrRightJustify then
        dec(ARect.Right);
      DrawWithSelection(Canvas, Canvas.Font, FBoldFont, ARect, s, BPos, BLen, FAlign);
      inc(Rect.Left, ColumnSize(cnt));
      inc(cnt);
    end;
  end;
  {$IFDEF CLX}
  inherited DrawItem(Index, Rect, State);
  result := true;
  {$ENDIF}
end;

{------------------------------------------------------------------}

{$IFDEF CLX}
procedure TDCListBox.InitWidget;
begin
  inherited;
  if fCustomDraw then
  begin
    Style := lbOwnerDrawFixed;
    AssignBold;
  end;
end;
{$ENDIF}

{------------------------------------------------------------------}

constructor TDCListBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FBoldFont := TFont.Create;
  FColumns := TDCListBoxColumns.Create(TDCListBoxColumn);
  FInternalList := TStringList.Create;
end;

{------------------------------------------------------------------}

destructor TDCListBox.Destroy;
begin
  FBoldFont.Free;
  FColumns.Free;
  FInternalList.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------}

procedure TDCListBox.AssignBold;
begin
  FBoldFont.Assign(Font);
  FBoldFont.Style := [fsBold];
end;

{------------------------------------------------------------------}

function TDCListBox.CalcSize(ACanvas : TCanvas; const S: string): integer;
begin
  result := CalcStringSize(ACanvas, Font, FBoldFont, S + ' ').cx;
end;

{------------------------------------------------------------------}

function TDCListBox.ColumnAlign(Index: Integer): TLeftRightAlign;
begin
  result := lrLeftJustify;
  if Index < FColumns.Count then
    result := FColumns.Items[Index].FAlignment;
end;

{------------------------------------------------------------------}

function TDCListBox.ColumnSize(Index: Integer): integer;
begin
  result := 0;
  if Index < FColumns.Count then
    result := FColumns.Items[Index].FColumnSize;
  if (result = 0) and (Index < FInternalList.Count) then
    result := integer(FInternalList.Objects[Index]);
end;

{------------------------------------------------------------------}

procedure TDCListBox.SetCustomDraw(Value: boolean);
begin
  if FCustomDraw <> Value then
  begin
    FCustomDraw := Value;
    ResetColumnSize;
  end;
end;

{------------------------------------------------------------------}

procedure TDCListBox.ResetColumnSize;
var
  i: integer;
  Pos: integer;
  Cnt: integer;
  size: integer;
  ACanvas : TCanvas;
begin
  {$IFDEF CLX}
  FDisableDraw := true;
  ACanvas := TControlCanvas.Create;
  TControlCanvas(ACanvas).Control := Self;
  try
  {$ELSE}
  ACanvas := Canvas;
  {$ENDIF}
  if fCustomDraw and (FUpdateCount <= 0) then
    for i := 0 to Items.Count - 1 do
    begin
      Pos := 1;
      Cnt := 0;
      while Pos <= Length(Items[i]) do
      begin
        if Cnt = FInternalList.Count then
          FInternalList.Add('');
        size := CalcSize(ACanvas, ExtractColumn(Items[i], Pos));
        if integer(FInternalList.Objects[Cnt]) < size then
          FInternalList.Objects[Cnt] := pointer(size);
        inc(Cnt);
      end;
    end;
  {$IFDEF CLX}
  finally
    FDisableDraw := false;
    ACanvas.Free;
  end;
  {$ENDIF}
end;

{$IFDEF CLX}
{------------------------------------------------------------------}

procedure TDCListBox.FontChanged;
begin
  inherited;
  AssignBold;
end;

{$ENDIF}

{******************************************************************}

constructor TDCPopupListBox.Create(AOwner: TComponent);
begin
  fCustomDraw := true;
  {$IFNDEF CLX}
  fHookProcInst := integer(MakeObjectInstance(HookProc));
  {$ENDIF}

  inherited;
end;

{------------------------------------------------------------------}

procedure TDCPopupListBox.Close(DoSelect: boolean);
var
  index: integer;
begin
  {$IFNDEF CLX}
  UnHookParent;
  Application.UnhookMainWindow(AppHook);
  RemoveHooks;

  if HandleAllocated then
    KillTimer(Handle, 1);
  {$ENDIF}

  if DoSelect then
    index := ItemIndex
  else
    index := -1;

  if Assigned(fCallBack) then
    fCallBack(self, index);

  {$IFNDEF CLX}
  if HandleAllocated then
    SetWindowPos(Handle, 0, 0, 0, 0, 0, SWP_NOZORDER or
      SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or SWP_HIDEWINDOW);
  {$ENDIF}

  Visible := false;
end;

{------------------------------------------------------------------}

function TDCPopupListBox.AdjustColumns(ASize : integer) : integer;
const
  cMinSize = 10;
var
  cSize   : integer;
  i       : integer;
begin
  result := 0;
  with FInternalList do
    for i := 0 to Count - 1 do
    begin
      cSize := Round(integer(Objects[i]) * FMaxSize / ASize);
      Objects[i] := Pointer(cSize);
      inc(result, cSize);
    end;
    if result <> 0 then
      inc(result);
end;

{------------------------------------------------------------------}

procedure TDCPopupListBox.Popup(x, y: integer);
var
  sizex   : integer;
  i       : integer;
begin
  sizex := 8;

  {$IFDEF CLX}
  ResetColumnSize;
  BorderStyle :=  bsSingle;
  {$ENDIF}

  with FInternalList do
    for i := 0 to Count - 1 do
      inc(sizex, integer(Objects[i]));

  if FMaxSize > 0 then
    if sizex > FMaxSize then
      sizex := AdjustColumns(sizex);
  {$IFDEF CLX}
  inc(sizex);
  {$ENDIF}

  ClientWidth := max(Clientwidth, sizex);

  if y + Height > Screen.Height then
    dec(y, Height);

  if x + Width > Screen.Width then
    dec(x, Width);

  if Items.Count > 0 then
    ItemIndex := 0;

  {$IFNDEF CLX}
  SetWindowPos(Handle, HWND_TOPMOST, x, y, Width, Height, SWP_NOACTIVATE or SWP_SHOWWINDOW);
  {$ELSE}
  Left := x;
  Top := y;
  {$ENDIF}
  visible := true;

  //SetFocus; ///
  
  pwindow := self;
  cedit := nil;

  {$IFNDEF CLX}
  WHook := SetWindowsHookEx(WH_MOUSE, @CallWndProcHook, 0, GetCurrentThreadId);
  Application.HookMainWindow(AppHook);
  //  SetCapture(handle);
  HookParent;
  //  SetTimer(Handle, 1, 20, nil);
  {$ENDIF}
end;

{-------------------------------------------------------------}

function PopupListbox(AParent: TWinControl; Sl: TStrings; X, Y: integer;
  AlignArray: array of TLeftRightAlign;
  AFont: TFont;
  ACallBack: TPopupListBoxCallback; AMaxSize : integer): TDCPopupListBox;
var
  p: TPoint;
  i: integer;
begin
  Result := TDCPopupListBox.Create(nil);
  with Result do
  begin

    MaxSize := AMaxSize;
    {$IFNDEF CLX}
    p := AParent.ClientToScreen(point(x, y));
    {$ELSE}
    p := Point(X, Y);
    Height := 100;
    {$ENDIF}

    for i := Low(AlignArray) to High(AlignArray) do
      TDCListBoxColumn(Columns.Add).Alignment := AlignArray[i];

    Parent := AParent;
    if AFont = nil then
    begin
      Font.Size := 8;
      Font.Name := 'MS Sans Serif'; //don't resource
    end
    else
      Font.Assign(AFont);

    CallBack := ACallBack;
    Items.Assign(Sl);
    Popup(p.x, p.y);
  end;
end;

{******************************************************************}

{$IFDEF USEMASKEDIT}

constructor TDCMaskEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  {$IFNDEF CLX}
  Ctl3D := false;
  {$ENDIF}
  BorderStyle := bsNone;
end;

{------------------------------------------------------------------}

{$IFNDEF CLX}

procedure TDCMaskEdit.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := (Params.Style {or ES_MULTILINE } or WS_CLIPCHILDREN) and not WS_BORDER;
    ExStyle := ExStyle and not WS_EX_CLIENTEDGE;
  end;
end;

{------------------------------------------------------------------}

procedure TDCMaskEdit.CMEnter(var Message: TCMGotFocus);
begin
  if not (csLButtonDown in ControlState) then
    SelectAll;

  inherited;
end;
{$ELSE}

{------------------------------------------------------------------}

procedure TDCMaskEdit.DoEnter;
begin
  if not (csLButtonDown in ControlState) then
    SelectAll;
  inherited;  
end;

{$ENDIF}
{$ENDIF}

{******************************************************************}

procedure Register;
begin
  if Assigned(RegisterComponentsProc) then
    RegisterComponents(SPalDreamEdit, [TDCEdit, TDCColorEdit, TDCPenStyleEdit,
      TDCBrushStyleEdit, TDCFileNameEdit, TDCDirectoryEdit]);
end;

initialization
  fDropDownGlyph := TBitmap.Create;
  fDotsGlyph := TBitmap.Create;
  fDropDownGlyph.LoadFromResourceName(HInstance, 'DCEDIT_DROPDOWN'); //don't resource
  fDotsGlyph.LoadFromResourceName(HInstance, 'DCEDIT_DOTS'); //don't resource

  RunRegister;
finalization
  if Assigned(fDropDownGlyph) then
    fDropDownGlyph.Free;
  if Assigned(fDotsGlyph) then
    fDotsGlyph.Free;
end.

