{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcDTree;

interface
{$I dc.inc}
uses

  Windows, Messages, SysUtils, Classes, Graphics, Controls,  Forms, extctrls,
  dcdreamlib, ComCtrls, CommCtrl, dcconsts{$IFDEF D4},imglist{$ENDIF};


const
  TreeTimerID  = 151;
  DragTimerID  = 153;
  ScrollTimerID = 154;

  TSIMAGECHANGED = 122;


{$IFNDEF CPB3}
  TVS_FULLROWSELECT     = $1000;
  TVS_NOTOOLTIPS        = $0080;
  LVS_EX_REGIONAL       = $00000200;
{$ENDIF}
  TVS_HOTTRACK          = $0200;
{$IFNDEF D3}
  LVM_SETEXTENDEDLISTVIEWSTYLE = LVM_FIRST + 54;
  LVM_GETEXTENDEDLISTVIEWSTYLE = LVM_FIRST + 55;
  LVS_EX_CHECKBOXES       = $00000004;
  LVS_EX_GRIDLINES        = $00000001;
  LVS_EX_TRACKSELECT      = $00000008;
  LVS_EX_HEADERDRAGDROP   = $00000010;
  LVS_EX_FULLROWSELECT    = $00000020;
  LVS_EX_ONECLICKACTIVATE = $00000040;
  LVS_EX_TWOCLICKACTIVATE = $00000080;

{$ENDIF}

{$IFDEF CPB3}
  {$DEFINE DEFAULTDRAW}
{$ENDIF}
{$IFDEF D4}
  {$DEFINE DEFAULTDRAW}
{$ENDIF}


{$IFNDEF DEFAULTDRAW}
const
  NM_CUSTOMDRAW           = NM_FIRST-12;
  CDRF_DODEFAULT          = $00000000;
  CDRF_NEWFONT            = $00000002;
  CDRF_SKIPDEFAULT        = $00000004;
  CDRF_NOTIFYPOSTPAINT    = $00000010;
  CDRF_NOTIFYITEMDRAW     = $00000020;
  CDRF_NOTIFYSUBITEMDRAW  = $00000020;
  CDRF_NOTIFYPOSTERASE    = $00000040;

  CDDS_PREPAINT           = $00000001;
  CDDS_POSTPAINT          = $00000002;
  CDDS_PREERASE           = $00000003;
  CDDS_POSTERASE          = $00000004;
  CDDS_ITEM               = $00010000;
  CDDS_ITEMPREPAINT       = CDDS_ITEM or CDDS_PREPAINT;
  CDDS_ITEMPOSTPAINT      = CDDS_ITEM or CDDS_POSTPAINT;
  CDDS_ITEMPREERASE       = CDDS_ITEM or CDDS_PREERASE;
  CDDS_ITEMPOSTERASE      = CDDS_ITEM or CDDS_POSTERASE;
  CDDS_SUBITEM            = $00020000;

  CDIS_SELECTED       = $0001;
  CDIS_GRAYED         = $0002;
  CDIS_DISABLED       = $0004;
  CDIS_CHECKED        = $0008;
  CDIS_FOCUS          = $0010;
  CDIS_DEFAULT        = $0020;
  CDIS_HOT            = $0040;
  CDIS_MARKED         = $0080;
  CDIS_INDETERMINATE  = $0100;
  TVM_SETBKCOLOR      = TV_FIRST + 29;
  TVM_SETTEXTCOLOR    = TV_FIRST + 30;

  LVS_EX_FLATSB         = $00000100;
  LVS_EX_UNDERLINEHOT   = $00000800;
  LVS_EX_UNDERLINECOLD  = $00001000;
  LVSICF_NOINVALIDATEALL  = $00000001;
type
  tagNMCUSTOMDRAWINFO = packed record
    hdr: TNMHdr;
    dwDrawStage: DWORD;
    hdc: HDC;
    rc: TRect;
    dwItemSpec: DWORD;
    uItemState: UINT;
    lItemlParam: LPARAM;
  end;
  PNMCustomDraw = ^TNMCustomDraw;
  TNMCustomDraw = tagNMCUSTOMDRAWINFO;
  tagNMTTCUSTOMDRAW = packed record
    nmcd: TNMCustomDraw;
    uDrawFlags: UINT;
  end;
  PNMTTCustomDraw = ^TNMTTCustomDraw;
  TNMTTCustomDraw = tagNMTTCUSTOMDRAW;

  tagNMTVCUSTOMDRAW = packed record
    nmcd: TNMCustomDraw;
    clrText: COLORREF;
    clrTextBk: COLORREF;
    iLevel: Integer;
  end;

  PNMTVCustomDraw = ^TNMTVCustomDraw;
  TNMTVCustomDraw = tagNMTVCUSTOMDRAW;

{$ENDIF}
{$IFNDEF D4}
type

  TCustomDrawState = set of (cdsSelected, cdsGrayed, cdsDisabled, cdsChecked, cdsFocused, cdsDefault, cdsHot, cdsMarked, cdsIndeterminate);
  TCustomDrawStage = (cdPrePaint, cdPostPaint, cdPreErase, cdPostErase);
  TCustomDrawTarget = (dtControl, dtItem);
  TTVCustomDrawEvent = procedure(Sender: TCustomTreeView; ARect: TRect; var DefaultDraw: Boolean) of object;
  TTVCustomDrawItemEvent = procedure(Sender: TCustomTreeView; Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean) of object;

{$ENDIF}


type
  TCheckState = (csUnchecked, csChecked, csGrayed, csNone);
  TCustomDCDrawTreeView = class;


  {State of TTreeNode}
  TDrawNodeState = (msCut,msBold, msDropHilited, msFocused, msSelected, msExpanded);
  TDrawNodeStates = set of TDrawNodeState;

  TDrawNode = class(TTreeNode)
  private
    FFontColor   : TColor;
    FFontStyle   : TFontStyles;
    FRadioItem   : boolean;
    FStateIndex  : integer;
    FCheckState  : TCheckState;
    FAllowGrayed : boolean;
    FParentFontStyle : boolean;
    FParentColor : boolean;
    procedure SetNodeState(Value : TDrawNodeStates);
    function  GetNodeState : TDrawNodeStates;
    function  DrawTree : TCustomDCDrawTreeView;
    procedure SetFontColor(Value : TColor);
    procedure SetFontStyle(Value : TFontStyles);
    procedure SetCheckState(Value : TCheckState);
    procedure SetRadioItem(Value : boolean);
    procedure SetChecked(Value : boolean);
    procedure SetStateIndex(Value : integer);
    procedure SetParentFontStyle(Value : boolean);
    procedure SetParentColor(Value : boolean);

    function  GetCheckState : TCheckState;
    function  GetChecked : boolean;
    procedure InvalidateNode;
    function  IsNodeStateStored : boolean;
  public
    constructor Create(AOwner: TTreeNodes);
  published
    property NodeState : TDrawNodeStates read GetNodeState write SetNodeState stored IsNodeStateStored;
    property FontColor : TColor read FFontColor write SetFontColor default clWindowText;
    property FontStyle : TFontStyles read FFontStyle write SetFontStyle default [];
    property RadioItem : boolean read FRadioItem write SetRadioItem default false;
    property Checked : boolean read GetChecked write SetChecked  default false;
    property CheckState : TCheckState  read GetCheckState write SetCheckState;
    property StateIndex : integer read FStateIndex write SetStateIndex default -1;
    property AllowGrayed : boolean read FAllowGrayed write FAllowGrayed default true;
    property ParentFontStyle : boolean read FParentFontStyle write SetParentFontStyle default true;
    property ParentColor : boolean read FParentColor write SetParentColor default true;
    property Text stored false;
    property ImageIndex stored false;
    property SelectedIndex stored false;
  end;

  TScrollDirection = set of (sdLeft,sdUp,sdRight,sdDown);

  TCustomDCDrawTreeView = class(TCustomTreeView)
  private
    {$IFNDEF D4}
    FOnCustomDraw       : TTVCustomDrawEvent;
    FOnCustomDrawItem   : TTVCustomDrawItemEvent;
    FCanvas             : TCanvas;
    FToolTips           : boolean;
    FHotTrack           : boolean;
    FRowSelect          : boolean;
    FStateImages        : TImageList;
    {$ELSE}
    FStateImages        : TCustomImageList;
    {$ENDIF}
    FCheckBoxes         : boolean;
    FAllowChange        : boolean;
    FAllowGrayed        : boolean;
    FCanvasChanged      : boolean;
    FMemStream          : TMemoryStream;
    FOnClickCheck       : TTVChangedEvent;
    FCashedRadioNode    : TTreeNode;
    FAutoScroll         : boolean;
    FExpandOnDrag       : boolean;
    FScrollPos          : TPoint;
    FDragTimerEnabled   : boolean;
    FScrollTimerEnabled : boolean;
    FDragExpandDelay    : integer;
    FDragObject         : TDragObject;
    FScrollDir          : TScrollDirection;
    FSelfScrolling      : boolean;
    FMultiDragged       : boolean;
    FWindowsSaveCursor  : TCursor;
    FEditHandle         : THandle;
    FOldEditProc        : Pointer;
    FEditProc           : Pointer;
    FEditNode           : TTreeNode;
    FPersHolder         : TComponent;
    FVersion            : TDCVersion;
    FCanEditChanged     : boolean;
    FEditException      : boolean;
    {$IFNDEF D4}
    procedure SetToolTips(Value : boolean);
    procedure SetHotTrack(Value : boolean);
    procedure SetRowSelect(Value : Boolean);
    {$ENDIF}
    procedure SetStateImages (Value : {$IFNDEF D4} TImageList {$ELSE} TCustomImageList {$ENDIF});
    procedure CanvasChanged(Sender : TObject);
    procedure InitCanvas(DC : HDC);
    procedure SetCheckBoxes(Value : boolean);
    procedure CheckRadioItems(Node : TTreeNode);
    procedure SetAllCheckIndex;
    procedure ToggleClickCheck(Node : TTreeNode);
    function  ClickOnCheck(X,Y : integer): boolean;
    function  IsStateImagesStored : boolean;
    procedure ReadData(Nodes : TTreeNodes; Stream: TStream);
    procedure WriteData(Nodes : TTreeNodes; Stream: TStream);
    procedure WriteObjToStream(Stream : TStream; Instance : TPersistent);
    procedure ReadObjFromStream(Stream : TStream; Instance : TPersistent);
    procedure WriteStreamData(Stream: TStream);
    procedure ReadStreamData(Stream: TStream);
    function  ScrollInfoAt(X, Y : integer) : TPoint;
    procedure InitScrollInfo(var Info : TScrollInfo; Mask : integer);
    procedure UpdateDragCursor;
    procedure EditWndProc(var Message : TMessage);
  protected
    {$IFNDEF D4}
    function  CustomDraw(const ARect: TRect; Stage: TCustomDrawStage): Boolean; virtual;
    procedure InvalidateSelection; virtual;
    procedure CreateParams(var Params: TCreateParams); override;
    {$ENDIF}
    function  GetDrawNodeFromItem(const Item: TTVItem): TTreeNode;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;

    procedure INSERTITEM(var Message : TMessage); message TVM_INSERTITEM;
    procedure WMLBUTTONDOWN(var Message: TWMMouse);  message WM_LBUTTONDOWN;
    procedure WMLBUTTONDBLCLK(var Message: TWMMouse);  message WM_LBUTTONDBLCLK;
    procedure WMTIMER(var M:TMessage); message WM_TIMER;
    procedure KeyPress(var Key: Char); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation);override;
    function  CreateNode : TTreeNode ; override;
    procedure InitNode(Node : TTreeNode); virtual;
    procedure CNNotify(var Message: TWMNotify); message CN_NOTIFY;
    function  CustomDrawItem(Node: TTreeNode; State: TCustomDrawState; Stage: TCustomDrawStage
                             {$IFDEF D5};var PaintImages: Boolean{$ENDIF}): Boolean;
    {$IFNDEF D4} virtual{$ELSE} override{$ENDIF};

    function  IsCustomDrawn(Target: TCustomDrawTarget; Stage: TCustomDrawStage): Boolean;{$IFDEF D6}override;{$ENDIF}
    procedure SetCheckState(Node : TTreeNode ; State : TCheckState);
    function  GetCheckState(Node : TTreeNode): TCheckState;
    procedure CreateWnd; override;
    procedure DestroyWnd; override;
    procedure DestroyWindowHandle; override;
    procedure ClickCheck(Node : TTreeNode); virtual;
    procedure DoMouseScroll(X, Y : integer);
    procedure DoScroll; virtual;
    procedure CMDrag(var Message: TCMDrag); message CM_DRAG;
    function  GetNodeState(Node: TTReeNode) : TDrawNodeStates; virtual;
    procedure SetNodeState(Node: TTreeNode; NodeState: TDrawNodeState ; Value : boolean); virtual;
    procedure SetNodeStates(Node: TTreeNode; Value: TDrawNodeStates); virtual;
    procedure DoStartDrag(var DragObject: TDragObject); override;
    procedure DoEndDrag(Target: TObject; X, Y: Integer); override;
    procedure DestroyTimers ; virtual;
    procedure DefineProperties(Filer: TFiler); override;
    function  CanEdit(Node: TTreeNode): Boolean; override;
    function  StoreDrawData : boolean; virtual;
  public
    constructor Create(AOwner:TComponent); override;
    destructor Destroy; override;
    procedure  BeginUpdate;virtual;
    procedure  EndUpdate;virtual;
    procedure  AssignNodes(Source : TTreeNodes);
    procedure  MakeVisible(Node : TTreeNode);

    {$IFNDEF D4}
    property  OnCustomDraw: TTVCustomDrawEvent read FOnCustomDraw write FOnCustomDraw;
    property  OnCustomDrawItem: TTVCustomDrawItemEvent read FOnCustomDrawItem write FOnCustomDrawItem;
    property  Canvas: TCanvas read FCanvas;
    property  ToolTips:boolean  read FToolTips write SetToolTips default True;
    property  HotTrack:boolean read FHotTrack write SetHotTrack default False;
    property  RowSelect: Boolean read FRowSelect write SetRowSelect default False;
    {$ENDIF}
    property  CheckBoxes : boolean read FCheckBoxes write SetCheckBoxes;
    property  AllowGrayed : boolean read FAllowGrayed write FAllowGrayed default false;
    property  AutoScroll : boolean read FAutoScroll write FAutoScroll;
    property  ExpandOnDrag : boolean read FExpandOnDrag write FExpandOnDrag;
    property  DragExpandDelay : integer  read FDragExpandDelay write FDragExpandDelay;
    property  StateImages : {$IFNDEF D4} TImageList {$ELSE} TCustomImageList {$ENDIF}
              read FStateImages write SetStateImages stored  IsStateImagesStored;
    property  AllowChange : boolean read FAllowChange write FAllowChange;
    property  OnClickCheck : TTVChangedEvent read FOnClickCheck write FOnClickCheck;
  published
    property Version : TDCVersion read FVersion write FVersion stored false;
  end;


  TDirectionType = (dtNone, dtDown,dtUp);

  TCustomMSTreeView =class(TCustomDCDrawTreeView)
  private
    FDirection : TDirectionType;
    FCtrlPressed: boolean;
    FMultiSelect:boolean;
    FDeselectOnButton : boolean;
    FCanSelect:boolean;
    FSelectedList : TList;
    FOnSelectionChanged : TTVChangedEvent;
    FDragged  : boolean;
    FMouseSel : boolean;
    FMouseStartPos : TPoint;
    FMouseStartNode : TTreeNode;
    FOldDragNode : TTreeNode;
    FChangeNode : TTreeNode;
    FSelRect : TRect;
    FClicked : boolean;
    FDragSaveCursor : TCursor;
    FAllowMultiDrag : boolean;
    FSelectDelay : integer;
    FSelectOnlySiblings : boolean;
    procedure SetMultiSelect(Value:Boolean);
    procedure SetItemsSelected(Value:Tlist);
    procedure SetItemsList(Value:Tlist; FocusSelected : boolean);
    procedure SetSelectOnlySiblings(value : boolean);
    function  GetItemsSelected:TList;
    procedure SelectNodes(Node:TTreeNode);
    procedure DoAfterCtrlPressed;
    procedure DrawMouseRect(const R : TRect);
    function  GetFocusRect(const Rect : TRect; const Point : TPoint ) : TRect;
    procedure SelectNodesWithRect(const Rect : TRect);
    procedure FinishMouseSelect;
    procedure CheckSiblings(Node : TTreeNode);
  protected
    FAllowNotify : boolean;
    FFirstSelNode:TTreeNode;
    FUpdateCount : integer;
    FItemsSelected :TList;
    FTimerEnabled : boolean;
    procedure ChangeSelect(Node : TTreeNode);
    procedure CNNotify(var Message: TWMNotify); message CN_NOTIFY;
    procedure WMLBUTTONUP(var Message : TWMMouse); message WM_LBUTTONUP;
    procedure WMRBUTTONDOWN(var Message : TWMMouse);message WM_RBUTTONDOWN;
    procedure WMLBUTTONDOWN(var Message : TWMMouse); message WM_LBUTTONDOWN;
    procedure TVMSELECTITEM(var Message: TMessage) ; message TVM_SELECTITEM;

    procedure WMMOUSEMOVE(var Message: TWMMouseMove); message WM_MOUSEMOVE;
    procedure WMKeyDown(var Message:TWMKey);  message WM_KEYDOWN;
    procedure CNKeyDown(var Message: TWMKeyDown); message CN_KEYDOWN;
    procedure WMChar(var Message: TWMChar); message WM_CHAR;
    procedure WMKILLFOCUS(var Message: TMessage); message WM_KILLFOCUS;
    procedure WMSETFOCUS(var Message: TMessage); message WM_SETFOCUS;
    procedure WMVScroll(var Message: TWMHScroll); message WM_VSCROLL;
    procedure WMHScroll(var Message: TWMHScroll); message WM_HSCROLL;
    procedure WMTIMER(var M:TMessage); message WM_TIMER;
    function  CreateNode: TTreeNode; override;
    procedure Edit(const Item : TTVItem); override;
    procedure CMDrag(var Message: TCMDrag); message CM_Drag;
    procedure DoStartDrag(var DragObject: TDragObject); override;
    procedure DragOver(Source: TObject; X, Y: Integer; State: TDragState;
      var Accept: Boolean);override;
    procedure DoEndDrag(Target: TObject; X, Y: Integer); override;

    procedure SelectionChanged; virtual;
    procedure DoScroll; override;
    procedure DestroyTimers; override;
    procedure FlushDelayedSelection;
  public
    {$IFDEF D6}
    procedure ClearSelection(KeepPrimary: Boolean = False); override;
    {$ELSE}
    procedure ClearSelection;
    {$ENDIF}

    constructor Create(Aowner:TComponent);override;
    destructor  Destroy; override;
    procedure BeginUpdate; override;
    procedure EndUpdate; override;
    procedure SelectAllItems;
    procedure DeselectAllItems;
    function  ItemSelected(Node:TTreeNode):boolean;
    procedure DeleteSelectedItems; virtual;
    procedure SetItemSelected(Node:TtreeNode;Value:boolean);
    procedure SetNodeState(Node:TtreeNode; NodeState:TDrawNodeState; Value:boolean); override;
    procedure SetNodeStates(Node: TTreeNode; Value: TDrawNodeStates); override;
    property  MultiSelect : boolean read FMultiSelect write SetMultiSelect;
    property  DeselectOnButton : boolean read FDeselectOnButton write FDeselectOnButton default true;
    property  ItemsSelected: TList read GetItemsSelected write SetItemsSelected;
    property  SelectDelay : integer read FSelectDelay write FSelectDelay;
    property  AllowMultiDrag : boolean read FAllowMultiDrag  write FAllowMultiDrag;
    property  SelectOnlySiblings : boolean read FSelectOnlySiblings write SetSelectOnlySiblings;
    property  OnSelectionChanged:TTVChangedEvent read FOnSelectionChanged write FOnSelectionChanged;
   end;

  TDCDrawTreeView = class(TCustomDCDrawTreeView)
  published
    property Items;
    property ShowButtons;
    property BorderStyle;
    property DragCursor;
    property ShowLines;
    property ShowRoot;
    property ReadOnly;
    {$IFDEF D3}
    property RightClickSelect;
    {$ENDIF}
    property DragMode;
    property HideSelection;
    property Indent;
    property OnEditing;
    property OnEdited;
    property OnExpanding;
    property OnExpanded;
    property OnCollapsing;
    property OnCompare;
    property OnCollapsed;
    property OnChanging;
    property OnChange;
    property OnDeletion;
    property OnGetImageIndex;
    property OnGetSelectedIndex;
    property Align;
    property Enabled;
    property Font;
    property Color;
    property ParentColor;
    property ParentCtl3D;
    property Ctl3D;
    property SortType;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnClick;
    property OnEnter;
    property OnExit;
    property OnDragDrop;
    property OnDragOver;
    property OnStartDrag;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnDblClick;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property PopupMenu;
    property ParentFont;
    property ParentShowHint;
    property ShowHint;
    property OnCustomDraw;
    property OnCustomDrawItem;
    {$IFDEF D5}
    property OnAdvancedCustomDrawItem;
    {$ENDIF}
    property OnClickCheck;
    property ToolTips;
    property RowSelect;
    property HotTrack;
    property CheckBoxes;
    property AllowGrayed;
    property AutoScroll;
    property ExpandOnDrag;
    property DragExpandDelay;
    {$IFDEF D4}
    property Anchors;
    property AutoExpand;
    property BiDiMode;
    property BorderWidth;
    property ChangeDelay;
    property Constraints;
    property DragKind;
    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
    {$ENDIF}
    property Images;
    property StateImages;

  end;


  TDCMSTreeView=class(TCustomMSTreeView)
  published
    property Items;
    property ShowButtons;
    property BorderStyle;
    property DragCursor;
    property ShowLines;
    property ShowRoot;
    property ReadOnly;
    {$IFDEF D3}
    property RightClickSelect;
    {$ENDIF}
    property DragMode;
    property HideSelection;
    property Indent;
    property OnEditing;
    property OnEdited;
    property OnExpanding;
    property OnExpanded;
    property OnCollapsing;
    property OnCompare;
    property OnCollapsed;
    property OnChanging;
    property OnChange;
    property OnDeletion;
    property OnGetImageIndex;
    property OnGetSelectedIndex;
    property Align;
    property Enabled;
    property Font;
    property Color;
    property ParentColor;
    property ParentCtl3D;
    property Ctl3D;
    property SelectDelay;
    property SortType;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnClick;
    property OnEnter;
    property OnExit;
    property OnDragDrop;
    property OnDragOver;
    property OnStartDrag;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnDblClick;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property PopupMenu;
    property ParentFont;
    property ParentShowHint;
    property ShowHint;
    property MultiSelect;
    property DeselectOnButton;
    property ToolTips;
    property HotTrack;
    property RowSelect;
    property CheckBoxes;
    property AllowGrayed;
    property AutoScroll;
    property ExpandOnDrag;
    property DragExpandDelay;
    property AllowMultiDrag;
    property SelectOnlySiblings;
    property Version;
    property OnSelectionChanged;
    property OnCustomDraw;
    property OnCustomDrawItem;
    {$IFDEF D5}
    property OnAdvancedCustomDrawItem;
    {$ENDIF}
    property OnClickCheck;
    {$IFDEF D4}
    property Anchors;
    property AutoExpand;
    property BiDiMode;
    property BorderWidth;
    property ChangeDelay;
    property Constraints;
    property DragKind;
    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
    {$ENDIF}
    property Images;
    property StateImages;
  end;

  TDrawTreeNodes = class(TPersistent)
  private
    FItems : TTreeNodes;
    FOwner : TCustomTreeView;
    function  GetHandle: HWND;
    function  GetCount: Integer;
  protected
    function  InternalAdd(Node: TTreeNode; const S: string; Ptr:Pointer; InsertType:TNodeAttachMode): TTreeNode; virtual;
    function  GetNodeFromIndex(Index: Integer): TTreeNode; virtual;
  public
    constructor Create(AOwner: TCustomMsTreeView); virtual;
    function  AddChildFirst(Node: TTreeNode; const S: string): TTreeNode;
    function  AddChild(Node: TTreeNode; const S: string): TTreeNode;
    function  AddChildObjectFirst(Node: TTreeNode; const S: string; Ptr: Pointer): TTreeNode;
    function  AddChildObject(Node: TTreeNode; const S: string;  Ptr: Pointer): TTreeNode;
    function  AddFirst(Node: TTreeNode; const S: string): TTreeNode;
    function  Add(Node: TTreeNode; const S: string): TTreeNode;
    function  AddObjectFirst(Node: TTreeNode; const S: string; Ptr: Pointer): TTreeNode;
    function  AddObject(Node: TTreeNode; const S: string;  Ptr: Pointer): TTreeNode;
    function  Insert(Node: TTreeNode; const S: string): TTreeNode;
    function  InsertObject(Node: TTreeNode; const S: string;  Ptr: Pointer): TTreeNode;
    procedure BeginUpdate; virtual;
    procedure EndUpdate; virtual;
    procedure Clear; virtual;
    procedure Delete(Node: TTreeNode); virtual;
    function  GetFirstNode: TTreeNode;
    function  GetNode(ItemId: HTreeItem): TTreeNode;
    property  Count: Integer read GetCount;
    property  Handle: HWND read GetHandle;
    property  Item[Index: Integer]: TTreeNode read GetNodeFromIndex; default;
    property  Owner: TCustomTreeView read FOwner;
  end;

  TLVChangeSelectEvent =  TLVDeletedEvent;
  {$IFNDEF D4}
  TListHotTrackStyle = (htHandPoint, htUnderlineCold, htUnderlineHot);
  TListHotTrackStyles = set of TListHotTrackStyle;
  {$ENDIF}

  TCheckStyle = (csFlat, cs3D);

  TLVGetImageIndexEvent = TLVDeletedEvent;
  TCustomDrawListView = class(TCustomListView)
  private
    FSelfHandled : boolean;
    {$IFNDEF D4}
    FFlatScrollBars :boolean;
    FFullDrag: Boolean;
    FHotTrackStyles: TListHotTrackStyles;
    FOnGetImageIndex : TLVGetImageIndexEvent;
    {$ENDIF}
    FOnSelectionChanged : TLVChangeSelectEvent;
    FChangeItem  : TListItem;
    FRegional : boolean;
    FSelectedItems : TList;
    FChangeTimer : TTimer;
    FVersion : TDCVersion;
    FInGetImageIndex : boolean;
    FCheckStyle: TCheckStyle;
    {$IFNDEF D3}
    FGridLines: Boolean;
    FHotTrack: Boolean;
    FRowSelect: Boolean;
    FCheckboxes: Boolean;
    procedure SetCheckboxes(Value: Boolean);
    procedure SetGridLines(Value: Boolean);
    procedure SetHotTrack(Value: Boolean);
    procedure SetRowSelect(Value: Boolean);
    {$ENDIF}
    procedure SetRegional(Value: Boolean);
    {$IFNDEF D4}
    procedure SetFlatScrollBars(Value:boolean);
    procedure SetFullDrag(Value: Boolean);
    procedure SetHotTrackStyles(Value: TListHotTrackStyles);
    function  GetItem(Value: TLVItem): TListItem;
    {$ENDIF}
    procedure ChangeSelect(Item : TListItem);
    function  GetSelectedItems : TList;
    procedure TimerExpired(Sender : TObject);
    function  GetSelectDelay : integer;
    procedure SetSelectDelay(Value : integer);
    procedure SetCheckStyle(Value : TCheckStyle);
    procedure CheckStyleChanged;
  protected
    procedure LVMSETEXTENDEDLISTVIEWSTYLE(Var Message:TMessage); message LVM_SETEXTENDEDLISTVIEWSTYLE;
    {$IFNDEF D4}
    procedure ResetExStyles;
    procedure CMColorChanged(var Message : TMessage) ; message CM_ColorChanged;
    procedure SetTextBkColor(Value: TColor);
    procedure GetImageIndex(Item : TListItem);

    {$ENDIF}
    procedure CNNotify(var Message: TWMNotify); message CN_NOTIFY;
    procedure SelectionChanged; virtual;
    procedure LVMREDRAWITEMS(var Message : TMessage); message LVM_REDRAWITEMS;
    procedure CreateWnd ; override;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    property SelectDelay : integer read GetSelectDelay write SetSelectDelay;
    property OnSelectionChanged : TLVChangeSelectEvent read FOnSelectionChanged write FOnSelectionChanged;
    {$IFNDEF D4}
    property FlatScrollBars :boolean read FFlatScrollBars write SetFlatScrollBars default False;
    property FullDrag: Boolean read FFullDrag write SetFullDrag default False;
    property HotTrackStyles: TListHotTrackStyles read FHotTrackStyles write SetHotTrackStyles;
    {$ENDIF}
    {$IFNDEF D3}
    property Checkboxes: Boolean read FCheckboxes write SetCheckboxes default False;
    property GridLines: Boolean read FGridLines write SetGridLines default False;
    property RowSelect: Boolean read FRowSelect write SetRowSelect default False;
    property HotTrack: Boolean read FHotTrack write SetHotTrack default False;
    {$ENDIF}
    property Regional : boolean read FRegional write SetRegional;
    property SelectedItems : TList read GetSelectedItems;
    {$IFNDEF D4}
    property OnGetImageIndex : TLVGetImageIndexEvent read FOnGetImageIndex write FOnGetImageIndex;
    {$ENDIF}
    property CheckStyle : TCheckStyle read FCheckStyle write SetCheckStyle;
  published
    property Version : TDCVersion read FVersion write FVersion stored false;
  end;

  TDCDrawListView = class(TCustomDrawListView)
  published
    property Align;
    property AllocBy;
    {$IFDEF D4}
    property Anchors;
    property BiDiMode;
    {$ENDIF}
    property BorderStyle;
    {$IFDEF D4}
    property BorderWidth;
    {$ENDIF}
    property Color;
    property Columns;
    property ColumnClick;
    {$IFDEF D4}
    property Constraints;
    {$ENDIF}
    property Ctl3D;
    property DragCursor;
    {$IFDEF D4}
    property DragKind;
    {$ENDIF}
    property DragMode;
    property Enabled;
    property Font;
    property FlatScrollBars;
    property FullDrag;
    property GridLines;
    property HideSelection;
    property HotTrack;
    property HotTrackStyles;
    property IconOptions;
    property CheckStyle;
    property Items;
    property Checkboxes;
    property LargeImages;
    property MultiSelect;
    {$IFDEF D4}
    property OwnerData;
    property OwnerDraw;
    {$ENDIF}
    property ReadOnly default False;
    property RowSelect;
    {$IFDEF D4}
    property ParentBiDiMode;
    {$ENDIF}
    property ParentColor default False;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property Regional;
    property SelectDelay;
    property ShowColumnHeaders;
    property ShowHint;
    property SmallImages;
    property SortType;
    property StateImages;
    property TabOrder;
    property TabStop default True;
    property ViewStyle;
    property Visible;
    property OnChange;
    property OnChanging;
    property OnClick;
    property OnColumnClick;
    property OnCompare;
    {$IFDEF D4}
    property OnCustomDraw;
    property OnCustomDrawItem;
    property OnCustomDrawSubItem;
    property OnData;
    property OnDataFind;
    property OnDataHint;
    property OnDataStateChange;
    {$ENDIF}
    property OnDblClick;
    property OnDeletion;
    {$IFDEF D4}
    property OnDrawItem;
    {$ENDIF}
    property OnEdited;
    property OnEditing;
    {$IFDEF D4}
    property OnEndDock;
    {$ENDIF}
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGetImageIndex;
    property OnDragDrop;
    property OnDragOver;
    property OnInsert;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    {$IFDEF D4}
    property OnResize;
    {$ENDIF}
    property OnSelectionChanged;
    {$IFDEF D4}
    property OnSelectItem;
    property OnStartDock;
    {$ENDIF}
    property OnStartDrag;
  end;

  TDrawListItems = class(TPersistent)
  private
    FItems : TListItems;
    FOwner : TCustomListView;
    function  GetCount: Integer;
    procedure SetCount(Value : integer);
    function  GetHandle: HWND;
    function  GetItem(Index: Integer): TListItem;
    procedure SetItem(Index :Integer; Value : TListItem);
  protected
    function  InternalAdd(Index:integer; const S : String; InsertType : TNodeAttachMode):TListItem; virtual;
    procedure AssignListItem(Destination, Source  : TListItem); virtual;
  public
    constructor Create(AOwner: TCustomListView); virtual;
    procedure Assign(Source: TPersistent); override;
    function  Add: TListItem;
    function  Insert(Index: Integer): TListItem;
    function  AddCaption(const S:String):TListItem;
    function  InsertCaption(Index: Integer; const S:String): TListItem;
    procedure BeginUpdate; virtual;
    procedure EndUpdate; virtual;
    procedure Clear; virtual;
    procedure Delete(Index: Integer); virtual;
    function  IndexOf(Value: TListItem): Integer;
    property  Count: Integer read GetCount write SetCount;
    property  Handle: HWND read GetHandle;
    property  Item[Index: Integer]: TListItem read GetItem write SetItem; default;
    property  Owner: TCustomListView read FOwner;
  end;


  procedure Register;

implementation

{$R *.res}
const
  crCtrlDrag = 102;
  crCtrlMultiDrag = 103;
var
  CheckImages : TImageList;
  FDragTreeView : TCustomDCDrawTreeView = nil;
  FDragHook : THandle;
type

  TPersHolder = class(TComponent)
  private
    fP : TPersistent;
  published
    property P : TPersistent read fP write fP;
  end;


{------------------------------------------------------------------}

function GetScrollDelay(Control : TControl ; X , Y : integer) : integer;
const
  Offset = 25;
begin
  result := 100;
  if Assigned(Control) then
    with Control do
      if (X < - Offset) or (X > WIdth + Offset) or (Y < - Offset) or (Y >  Height + Offset) then
        result := 10;
end;

{-----------TDrawNode------------------------------------------------}

constructor TDrawNode.Create(AOwner: TTreeNodes);
begin
  inherited Create(AOwner);
  FStateIndex  := -1;
  FAllowGrayed := true;
  ParentFontStyle := true;
  ParentColor := true;
  with DrawTree do
    if (ComponentState * [csLoading,csReading] = []) and  FCheckBoxes  then
      inherited StateIndex := 1;
end;

{------------------------------------------------------------------}

function TDrawNode.DrawTree : TCustomDCDrawTreeView;
begin
  result := TCustomDCDrawTreeView(TreeView);
end;

{------------------------------------------------------------------}

procedure TDrawNode.SetParentFontStyle(Value : boolean);
begin
  if FParentFontStyle <> Value then
  begin
     if Value then
       FontStyle := DrawTree.Font.Style;
     FParentFontStyle := Value;
  end;
end;

{------------------------------------------------------------------}

procedure TDrawNode.SetParentColor(Value : boolean);
begin
  if FParentColor <> Value then
  begin
     if Value then
       FontColor:= DrawTree.Font.Color;
     FParentColor := Value;  
  end;
end;

{------------------------------------------------------------------}

procedure  TDrawNode.InvalidateNode;
var
  R:TRect;
begin
  R:=DisplayRect(false);
  InvalidateRect(TreeView.Handle,@R,true);
end;

{------------------------------------------------------------------}

function  TDrawNode.IsNodeStateStored : boolean;
begin
  result := (TreeView is TCustomDCDrawTreeView) and (TCustomDCDrawTreeView(TreeView).FMemStream <> nil);
end;

{------------------------------------------------------------------}

procedure TDrawNode.SetNodeState(Value : TDrawNodeStates);
begin
  DrawTree.SetNodeStates(Self, Value);
end;

{------------------------------------------------------------------}

function  TDrawNode.GetNodeState : TDrawNodeStates;
begin
  result := DrawTree.GetNodeState(Self);
end;

{------------------------------------------------------------------}

procedure  TDrawNode.SetFontColor(Value : TColor);
begin
  if FFontColor <> Value then
  begin
    FFontColor := Value;
    FParentColor := false;
    InvalidateNode;
  end;
end;

{------------------------------------------------------------------}

procedure  TDrawNode.SetFontStyle(Value : TFontStyles);
begin
  if FFOntStyle <> Value then
  begin
    FFontStyle := Value;
    FParentFontStyle := false;
    InvalidateNode;
  end;
end;

{------------------------------------------------------------------}

procedure  TDrawNode.SetCheckState(Value : TCheckState);
begin
  if (Value <> csGrayed) or (FAllowGrayed and DrawTree.AllowGrayed) then
  begin
    FCheckState := Value;
    DrawTree.SetCheckState(Self,Value);
  end;
end;

{------------------------------------------------------------------}

function  TDrawNode.GetCheckState : TCheckState;
begin
  result :=  FCheckState;
end;

{------------------------------------------------------------------}
type
  TMTreeView = class(TCustomTreeView);

procedure TDrawNode.SetStateIndex(Value : integer);
begin
  if FStateIndex <> Value then
  begin
    FStateIndex := Value;
    if TMTreeView(TreeView).StateImages <> CheckImages then
      inherited StateIndex := Value;
  end;
end;

{------------------------------------------------------------------}

procedure  TDrawNode.SetRadioItem(Value : boolean);
var
  AState : TCheckState;
begin
  if FRadioItem <> Value then
  begin
    AState := GetCheckState;
    FRadioItem := value;
    SetCheckState(AState);
  end;
end;

{------------------------------------------------------------------}

procedure  TDrawNode.SetChecked(Value : boolean);
begin
  if Value then
    SetCheckState(csChecked)
  else
    SetCheckState(csUnChecked);
end;

{------------------------------------------------------------------}

function  TDrawNode.GetChecked : boolean;
begin
  result := GetCheckState = csChecked;
end;

{-----------TCustomDCDrawTreeView------------------------------------}

constructor TCustomDCDrawTreeView.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  FPersHolder := TPersHolder.Create(nil);
  FDragExpandDelay := 100;
  FExpandOnDrag := true;
  {$IFNDEF D4}
  FCanvas := TCanvas.Create;
  FToolTips := true;
  {$ENDIF}

  {$IFDEF D6}
  FEditProc := Classes.MakeObjectInstance(EditWndProc);
  {$ELSE}
  FEditProc := MakeObjectInstance(EditWndProc);
  {$ENDIF}
end;

{------------------------------------------------------------------}

procedure TCustomDCDrawTreeView.CreateWnd;
begin
  inherited CreateWnd;
  if FMemStream <> nil then
  begin
    ReadData(Items, FMemStream);
    FMemStream.Free;
    FMemStream := nil;
  end;
  {$IFNDEF D4}
  Perform(TVM_SETBKCOLOR, 0, LPARAM(ColorToRGB(Color)));
  Perform(TVM_SETTEXTCOLOR, 0, LPARAM(ColorToRGB(Font.Color)));
  {$ENDIF}

end;

{------------------------------------------------------------------}

procedure TCustomDCDrawTreeView.DestroyTimers;
begin
  if HandleAllocated then
    if FDragTimerEnabled then
    begin
      KillTimer(Handle,DragTimerID);
      FDragTimerEnabled := false;
    end;
    if FScrollTimerEnabled then
    begin
      KillTimer(Handle,ScrollTimerID);
      FScrollTimerEnabled := false;
    end;
end;

{------------------------------------------------------------------}

procedure TCustomDCDrawTreeView.DestroyWnd;
begin
  if Items.Count > 0 then
  begin
    FMemStream := TMemoryStream.Create;
    WriteData(Items, FMemStream);
    FMemStream.Position := 0;
  end;
  DestroyTimers;
  inherited DestroyWnd;
end;

{------------------------------------------------------------------}

procedure TCustomDCDrawTreeView.DestroyWindowHandle;
begin
  DestroyTimers;
  if HandleAllocated then
    inherited DestroyWindowHandle;
end;

{------------------------------------------------------------------}

procedure TCustomDCDrawTreeView.BeginUpdate;
begin
  Items.BeginUpdate;
end;

{------------------------------------------------------------------}

procedure TCustomDCDrawTreeView.EndUpdate;
begin
  Items.EndUpdate;
end;

{------------------------------------------------------------------}

procedure TCustomDCDrawTreeView.AssignNodes(Source : TTreeNodes);
var
  MemStream : TMemoryStream;
begin
  BeginUpdate;
  try
  Items.Assign(Source);
    MemStream := TMemoryStream.Create;
    try
      WriteData(Source , MemStream);
      MemStream.Position := 0;
      ReadData(Items, MemStream);
    finally
      MemStream.Free;
    end;
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------}

function TCustomDCDrawTreeView.StoreDrawData : boolean;
begin
  result := Items.Count > 0;
end;

{------------------------------------------------------------------}

procedure TCustomDCDrawTreeView.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineBinaryProperty('DrawData', ReadStreamData, WriteStreamData, StoreDrawData);//don't resource
end;

{------------------------------------------------------------------}

procedure TCustomDCDrawTreeView.WriteObjToStream(Stream : TStream; Instance : TPersistent);
begin
  if Instance is TComponent then
    Stream.WriteComponent(TComponent(Instance))
  else
  begin
    TPersHolder(FPersHolder).P := Instance;
    Stream.WriteComponent(FPersHolder);
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDCDrawTreeView.ReadObjFromStream(Stream : TStream; Instance : TPersistent);
begin
  BeginGlobalLoading;
  try
    if Instance is TComponent then
      begin
        Stream.ReadComponent(TComponent(Instance));
        NotifyGlobalLoading;
      end
    else
    begin
      TPersHolder(FPersHolder).P := Instance;
      Stream.ReadComponent(FPersHolder);
    end;
  finally
    EndGlobalLoading;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDCDrawTreeView.ReadData(Nodes : TTreeNodes; Stream: TStream);
var
  Node : TTreeNode;
begin
  Node := Nodes.GetFirstNode;
  while Node <> nil do
  begin
    ReadObjFromStream(Stream, Node);
    Node := Node.GetNext;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDCDrawTreeView.WriteData(Nodes : TTreeNodes; Stream: TStream);
var
  Node: TTreeNode;
begin
  Node := Nodes.GetFirstNode;
  while Node <> nil do
  begin
    WriteObjToStream(Stream, Node);
    Node := Node.GetNext;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDCDrawTreeView.WriteStreamData(Stream: TStream);
begin
  if StoreDrawData then
    WriteData(Items, Stream);
end;

{------------------------------------------------------------------}

procedure TCustomDCDrawTreeView.ReadStreamData(Stream: TStream);
begin
  ReadData(Items, Stream);
end;

{------------------------------------------------------------------}

procedure SetCtlStyle(Ctl: TWinControl; Value: Integer; UseStyle: Boolean);
var
  Style: Integer;
begin
  if Ctl.HandleAllocated then
  begin
    Style := GetWindowLong(Ctl.Handle, GWL_STYLE);
    if not UseStyle then
      Style := Style and not Value
    else
      Style := Style or Value;
    SetWindowLong(Ctl.Handle, GWL_STYLE, Style);
  end;
end;

{------------------------------------------------------------------}

destructor TCustomDCDrawTreeView.Destroy;
begin
  DestroyTimers;
  DestroyWindowHandle;
  {$IFNDEF D4}
  FCanvas.Free;
  {$ENDIF}
  FMemStream.Free;
  if FDragTreeView = Self then
    FDragTreeView := nil;

  {$IFDEF D6}
  Classes.FreeObjectInstance(FEditProc);
  {$ELSE}
  FreeObjectInstance(FEditProc);
  {$ENDIF}

  FPersHolder.Free;
  inherited Destroy;
end;

{$IFNDEF D4}

{------------------------------------------------------------------}

procedure TCustomDCDrawTreeView.CreateParams(var Params: TCreateParams);
const
  ToolTipsStyle: array[boolean] of DWORD = (0,TVS_NOTOOLTIPS);
  HotTrackStyle: array[boolean] of DWORD = (0,TVS_HOTTRACK);
  RowSelectStyles: array[Boolean] of DWORD = (0, TVS_FULLROWSELECT);
begin
  inherited CreateParams(Params);
  with Params do
    Style := Style or ToolTipsStyle[not FToolTips] or HotTrackStyle[FHotTrack] or RowSelectStyles[FRowSelect] ;
end;

{------------------------------------------------------------------}

procedure TCustomDCDrawTreeView.SetToolTips(Value:boolean);
begin
  if FToolTips <> Value then
  begin
    FToolTips:=Value;
    SetCtlStyle(Self, TVS_NOTOOLTIPS, not Value);
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDCDrawTreeView.SetHotTrack(Value:boolean);
begin
  if FHotTrack <> Value then
  begin
    FHotTrack := Value;
    SetCtlStyle(Self, TVS_HOTTRACK, Value);
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDCDrawTreeView.SetRowSelect(Value: Boolean);
begin
  if FRowSelect <> Value then
  begin
    FRowSelect := Value;
    SetCtlStyle(Self, TVS_FULLROWSELECT, Value);
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDCDrawTreeView.InvalidateSelection;
var
  R:TRect;
begin
  if not HandleAllocated or (Selected = nil) then
    Exit;

  R:=Selected.DisplayRect(false);
  InvalidateRect(Handle,@R,true);
end;

{------------------------------------------------------------------}

function TCustomDCDrawTreeView.CustomDraw(const ARect: TRect; Stage: TCustomDrawStage): Boolean;
begin
  Result := True;
  if Assigned(OnCustomDraw) then OnCustomDraw(Self, ARect, Result);
end;

{$ENDIF}

{------------------------------------------------------------------}

function TCustomDCDrawTreeView.IsCustomDrawn(Target: TCustomDrawTarget; Stage: TCustomDrawStage): Boolean;
begin
  if Stage = cdPrePaint then
  begin
    if Target = dtItem then
      Result := true 
    else
    if Target = dtControl then
      Result := Assigned(OnCustomDraw)
    else
      Result := False;
  end
  else
    Result := False;
end;

{------------------------------------------------------------------}

function TCustomDCDrawTreeView.CustomDrawItem(Node: TTreeNode; State: TCustomDrawState;
  Stage: TCustomDrawStage{$IFDEF D5};var PaintImages: Boolean{$ENDIF}): Boolean;
var
  ADropTarget : boolean;
begin
  Result := True;
  with TDrawNode(Node), Canvas.Font do
  begin
    if not ((cdsSelected in State) and Self.Focused) and (FontColor <> Color) then
      Color := FontColor;
    Style := Style + FontStyle;
    ADropTarget := Node.DropTarget;
    if ((cdsSelected in State) or ADropTarget) and (FCanvasChanged or Assigned(OnCustomDrawItem)) then
    begin
      if (Self.Focused) or ADropTarget then
      begin
        Canvas.Brush.Color := clHighLight;
        Color := clHighLightText;
      end
      else
        Canvas.Brush.Color := clBtnFace;
    end;
  end;
  if Assigned(OnCustomDrawItem) then
    OnCustomDrawItem(Self, Node, State, Result);

  {$IFDEF D5}
  PaintImages := true;
  if Assigned(OnAdvancedCustomDrawItem) then
    OnAdvancedCustomDrawItem(Self, Node, State, Stage, PaintImages, Result);
  {$ENDIF}
end;

{------------------------------------------------------------------}

procedure TCustomDCDrawTreeView.CanvasChanged(Sender:TObject);
begin
  FCanvasChanged := True;
end;

{------------------------------------------------------------------}

procedure TCustomDCDrawTreeView.InitCanvas(DC:HDC);
begin
  Canvas.Handle := DC;
  Canvas.Font := Font;
  Canvas.Brush := Brush;
end;

{------------------------------------------------------------------}

procedure TCustomDCDrawTreeView.EditWndProc(var Message : TMessage);
var
  ARect : TRect;
begin
  with Message do
    if (Msg = WM_WINDOWPOSCHANGING) and (FEditNode <> nil) then
    with TWindowPos(Pointer(LParam)^) do
    begin
      ARect := FEditNode.DisplayRect(true);
      InvalidateRect(Handle, @ARect,true);
    end;
  with Message do
    Result := CallWindowProc(Pointer(FOldEditProc), FEditHandle, Msg, wParam,lParam);
end;

{------------------------------------------------------------------}

function  TCustomDCDrawTreeView.CanEdit(Node: TTreeNode): Boolean;
begin
  if FCanEditChanged then
    result := (FEditNode <> nil)
  else
    result := inherited CanEdit(Node);
end;

{------------------------------------------------------------------}

procedure TCustomDCDrawTreeView.CNNotify(var Message: TWMNotify);
var
  Node        : TTreeNode;
  R           : TRect;
  DefaultDraw : Boolean;
  {$IFDEF D5}
  PaintImages : Boolean;
  {$ENDIF}
begin
  with Message do
    case  NMHdr^.code of
      NM_CUSTOMDRAW :
        with PNMCustomDraw(NMHdr)^ do
        begin
          Result := CDRF_DODEFAULT;
          if dwDrawStage = CDDS_PREPAINT then
          begin
            if IsCustomDrawn(dtControl, cdPrePaint) then
            begin
              InitCanvas(Hdc);
              R := ClientRect;
              DefaultDraw := CustomDraw(R, cdPrePaint);
              Canvas.Handle := 0;
              if not DefaultDraw then
              begin
                Result := CDRF_SKIPDEFAULT;
                Exit;
              end;
            end;
            if IsCustomDrawn(dtControl, cdPostPaint) then
              Result := CDRF_NOTIFYPOSTPAINT;
            if IsCustomDrawn(dtItem, cdPrePaint) then
              Result := Result or CDRF_NOTIFYITEMDRAW
            else
              Result := Result or CDRF_DODEFAULT;
          end
          else if dwDrawStage = CDDS_ITEMPREPAINT then
          begin
            Node := Items.GetNode(HTReeItem(dwItemSpec));
            if Node <> nil then
            begin
              InitCanvas(hdc);
              Canvas.Font.OnChange := CanvasChanged;
              Canvas.Brush.OnChange := CanvasChanged;
              DefaultDraw := CustomDrawItem(Node, TCustomDrawState(Word(uItemState)), cdPrePaint{$IFDEF D5}, PaintImages{$ENDIF});
              {$IFDEF D5}
              if not PaintImages then
                result := Result or TVCDRF_NOIMAGES;
              {$ENDIF}
              if not DefaultDraw then
                Result := result or CDRF_SKIPDEFAULT
              else if FCanvasChanged then
              begin
                FCanvasChanged := False;
                Canvas.Font.OnChange := nil;
                Canvas.Brush.OnChange := nil;
                with PNMTVCustomDraw(NMHdr)^ do
                begin
                  clrText := ColorToRGB(Canvas.Font.Color);
                  clrTextBk := ColorToRGB(Canvas.Brush.Color);
                  SelectObject(hdc, Canvas.Font.Handle);
                  Result := Result or CDRF_NEWFONT;
                end;
              end;
              Canvas.Handle := 0;
              if IsCustomDrawn(dtItem, cdPostPaint) then
                Result := Result or CDRF_NOTIFYPOSTPAINT;
            end;
          end;
          exit;
        end;
      TVN_DELETEITEM :
        with PNMTreeView(Pointer(Message.NMHdr))^ do
        begin
          Node:=GetDrawNodeFromItem(ItemOld);
          if FCashedRadioNode = Node then
            FCashedRadioNode := nil;
          if FEditNode = Node then
            FEditNode := nil;
        end;
      TVN_BEGINLABELEDIT:
        with PTVDispInfo(Pointer(Message.NMHdr))^ do
        begin
          Node := GetDrawNodeFromItem(item);
          if not Dragging and CanEdit(Node) then
          begin
            FEditNode := Node;
            FEditHandle := TreeView_GetEditControl(Handle);
            FOldEditProc := Pointer(GetWindowLong(FEditHandle, GWL_WNDPROC));
            SetWindowLong(FEditHandle, GWL_WNDPROC, LongInt(FEditProc));
          end;
          FCanEditChanged := true;
        end;
      TVN_ENDLABELEDIT:
      begin
        SetWindowLong(FEditHandle,GWL_WNDPROC, LongInt(FOldEditProc));
        FEditNode := nil;
      end;
    end;
  inherited;
  FCanEditChanged := false;
end;

{------------------------------------------------------------------}

procedure TCustomDCDrawTreeView.INSERTITEM(var Message : TMessage);
var
  Item : TTVItem;
begin
  inherited;
  if (ComponentState * [csLoading,csReading] = []) and  FCheckBoxes then
  with Item do
    begin
      mask := TVIF_STATE or TVIF_HANDLE;
      stateMask := TVIS_STATEIMAGEMASK;
      hItem := HTreeItem(Message.Result);
      state := IndexToStateImageMask(1);
      TreeView_SetItem(Handle, Item);
    end;
end;

{------------------------------------------------------------------}

procedure TCustomDCDrawTreeView.CMFontChanged(var Message: TMessage);
var
  Node : TTreeNode;
  {---------------------------------------------}

  procedure SetNodeFont(Node : TTreeNode);
  begin
    with TDrawNode(Node) do
    begin
      if ParentFontStyle then
      begin
        ParentFontStyle := false;
        ParentFontStyle := true;
      end;
      if ParentColor then
      begin
        ParentColor := false;
        ParentColor := true;
      end;
    end;
  end;

  {---------------------------------------------}

begin
  inherited;
  {$IFNDEF D4}
  Perform(TVM_SETTEXTCOLOR, 0, LPARAM(ColorToRGB(Font.Color)));
  {$ENDIF};
  Node := Items.GetFirstNode;
  while Assigned(Node) do
  begin
    SetNodeFont(Node);
    Node := Node.GetNext;
  end;
end;

function TCustomDCDrawTreeView.GetDrawNodeFromItem(const Item: TTVItem): TTreeNode;
begin
  with Item do
    if (state and TVIF_PARAM) <> 0 then Result := Pointer(lParam)
    else Result := Items.GetNode(hItem);
end;

{------------------------------------------------------------------}

function TCustomDCDrawTreeView.CreateNode: TTreeNode;
begin
  Result := TDrawNode.Create(Items);
  InitNode(result);
end;

{------------------------------------------------------------------}

procedure TCustomDCDrawTreeView.InitNode(Node : TTreeNode);
begin
  with TDrawNode(Node) do
  begin
    FontColor := Font.Color;
    FontStyle := Font.Style;
    NodeState := NodeState - [msSelected];
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDCDrawTreeView.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited ;
  if (Operation = opRemove) and (AComponent = FStateImages) then
    FStateImages := nil;
end;

{------------------------------------------------------------------}

function  TCustomDCDrawTreeView.IsStateImagesStored : boolean;
begin
  result :=  (StateImages <> nil) and (StateImages <> CheckImages);
end;

{------------------------------------------------------------------}

procedure TCustomDCDrawTreeView.SetStateImages (Value : {$IFNDEF D4} TImageList {$ELSE} TCustomImageList {$ENDIF});
begin
  if FStateImages <> Value then
  begin
    FStateImages := Value;
    if FStateImages <> nil then
      FStateImages.FreeNotification(Self);
    if (inherited StateImages <> CheckImages) then
      inherited StateImages := Value;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDCDrawTreeView.SetCheckBoxes(Value : boolean);
begin
  if FCheckBoxes <> value then
  begin
    FCheckBoxes := value;
    SetAllCheckIndex;
    if Value then
      inherited StateImages := CheckImages
    else
      inherited StateImages := FStateImages;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDCDrawTreeView.SetAllCheckIndex;
const
  CheckArray : Array[boolean] of integer = (-1,1);
var
  Node : TTreeNode;
begin
  if ComponentState * [csLoading,csReading] <> [] then
    exit;
  Node := Items.GetFirstNode;
  while Assigned(Node) do
  begin
    if FCheckBoxes then
      with TDrawNode(Node) do
      begin
        FStateIndex := Node.StateIndex;
        CheckState := FCheckState;
    end
    else
      Node.StateIndex := TDrawNode(Node).FStateIndex;
    Node := Node.GetNext;
  end;
end;

{------------------------------------------------------------------}

function CheckStateToImageIndex(State : TCheckState; RadioItem : boolean) : integer;
begin
  result := 1;
  case State of
    csUnchecked : result := 1;
    csChecked   : result := 2;
    csGrayed    : result := 4;
    csNone      : result := -1;
  end;
  if (result <> -1) and RadioItem then
    inc(result, 4);
end;

{------------------------------------------------------------------}

function ImageIndexToCheckState(ImageIndex : integer; RadioItem : boolean) : TCheckState;
begin
  if ImageIndex = -1 then
  begin
    result := csNone;
    exit;
  end;
  result := csUnchecked;
  if RadioItem then
    dec(ImageIndex,4);
  case ImageIndex of
    1 : result := csUnchecked;
    2 : result := csChecked;
    4 : result := csGrayed;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDCDrawTreeView.SetCheckState(Node : TTreeNode ; State : TCheckState);
begin
  with TDrawNode(Node) do
  begin
    if FCheckBoxes then
      Node.StateIndex := CheckStateToImageIndex(State, RadioItem);
    if RadioItem and (State <> csUnChecked) then
    begin
      CheckRadioItems(Node);
      FCashedRadioNode := Node;
    end;
  end;
end;

{------------------------------------------------------------------}

function  TCustomDCDrawTreeView.GetCheckState(Node : TTreeNode): TCheckState;
begin
  if FCheckBoxes then
    with TDrawNode(Node) do
      result := ImageIndexToCheckState(Node.StateIndex, RadioItem)
  else
    result := csUnChecked
end;

{------------------------------------------------------------------}

procedure TCustomDCDrawTreeView.CheckRadioItems(Node : TTreeNode);
var
  ANode   : TTreeNode;
begin
  if (FCashedRadioNode <> nil) and (FCashedRadioNode <> Node) and (FCashedRadioNode.Parent = Node.Parent) then
    with TDrawNode(FCashedRadioNode) do
      if RadioItem and (CheckState = csChecked) then
      begin
        CheckState := csUnChecked;
        exit;
      end;

  if Assigned(Node.Parent) then
    ANode := Node.Parent.GetFirstChild
  else
    ANode := Items.GetFirstNode;

  while Assigned(ANode) do
    with TDrawNode(ANode) do
    begin
      if (ANode <> Node) and RadioItem and (CheckState = csChecked) then
      begin
        CheckState := csUnChecked;
        break;
      end;
      ANode := ANode.GetNextSibling;
    end;
end;

{------------------------------------------------------------------}

function  TCustomDCDrawTreeView.ClickOnCheck(X,Y : integer): boolean;
var
  Node : TTreeNode;
begin
  result := CheckBoxes; 
  if not result then                              
    exit;                                              

  Node := GetNodeAt(X,Y);
  result := Assigned(Node) and (htOnStateIcon in GetHitTestInfoAt(X, Y));
  if result then
  begin
    if not Focused then
      SetFocus;
    ToggleClickCheck(Node);
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDCDrawTreeView.WMLBUTTONDOWN(var Message : TWMMouse);
begin
  with Message do
    if not ClickOnCheck(Xpos,Ypos) then
      inherited;
end;

{------------------------------------------------------------------}

procedure TCustomDCDrawTreeView.WMLBUTTONDBLCLK(var Message: TWMMouse);
begin
  with Message do
    if not ClickOnCheck(Xpos,Ypos) then
      inherited;
end;

{------------------------------------------------------------------}

procedure TCustomDCDrawTreeView.KeyPress(var Key: Char);
begin
  inherited;
  if FCheckBoxes and (Key = #32)  and  Assigned(Selected) and not isEditing then
  begin
    ToggleClickCheck(Selected);
    Key := #0;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDCDrawTreeView.WMTIMER(var M:TMessage);
var
  Pos  : TPoint;
  Node : TTreeNode;
begin
  inherited;
  if M.WParam = DragTimerID then
  begin
    KillTimer(Handle,DragTimerID);
    if FExpandOnDrag  then
    begin
      GetCursorPos(Pos);
      with ScreenToClient(Pos) do
      begin
        Node := GetNodeAt(X,Y);
        if Assigned(Node) and Node.HasChildren and not Node.Expanded then
        begin
          if FDragObject <> nil then
            FDragObject.HideDragImage;
          Node.Expand(false);
          UpdateWindow(Handle);
          if FDragObject <> nil then
            FDragObject.ShowDragImage;
        end;
      end;
    end;
    FDragTimerEnabled := false;
  end
  else
  if  M.WParam = ScrollTimerID then
    DoScroll;
end;

{------------------------------------------------------------------}

procedure TCustomDCDrawTreeView.CMDrag(var Message: TCMDrag);
var
  Node : TTreeNode;
begin
  inherited;
  with Message ,DragRec^ do
    if  DragMessage in [dmDragEnter, dmDragMove] then
      with ScreenToClient(Pos) do
      begin
        if FAutoScroll then
          DoMouseScroll(X,Y);
        FDragObject := Source;
        if FDragTimerEnabled then
        begin
          KillTimer(Handle, DragTimerID);
          FDragTimerEnabled := false;
        end;
        if FExpandOnDrag then
        begin
          Node := GetNodeAt(X,Y);
          if Assigned(Node) and Node.HasChildren and not Node.Expanded then
          begin
            SetTimer(Handle, DragTimerID, FDragExpandDelay, nil);
            FDragTimerEnabled := true;
          end;
        end;
      end
    else
    if DragMessage <> dmFindTarget then
    begin
      FDragObject := nil;
      if FDragTimerEnabled then
      begin
        KillTimer(Handle, DragTimerID);
        FDragTimerEnabled := false;
      end;
      if FScrollTimerEnabled then
      begin
        KillTimer(Handle, ScrollTimerID);
        FScrollTimerEnabled := false;
      end;
    end;

end;

{------------------------------------------------------------------}

procedure TCustomDCDrawTreeView.InitScrollInfo(var Info : TScrollInfo; Mask : integer);
begin
  FillChar(Info,SizeOf(Info),0);
  Info.cbSize := SizeOf(TScrollInfo);
  Info.fMask := Mask;
end;

{------------------------------------------------------------------}

function ModDiv(A, B : integer) : integer;
begin
  result := A div B;
  if A mod B <> 0 then
    inc(result);
end;

{------------------------------------------------------------------}

procedure TCustomDCDrawTreeView.MakeVisible(Node : TTreeNode);
var
  FNode  : TTreeNode;
  R      : TRect;
  DistX  : integer;
  DistY   : integer;
  Offset : integer;
  i      : integer;
  Info   : TScrollInfo;
  List   : TList;
begin
  if Node = nil then
    exit;

  FNode := Node;
  List := TList.Create;
  try
    while (Node.Parent <> nil) and not Node.IsVisible do
    begin
      List.Add(Node.Parent);
      Node := Node.Parent;
    end;
    for i := List.Count - 1 downto 0 do
      TTreeNode(List[i]).Expand(false);
  finally
    List.Free;
  end;

  R := FNode.DisplayRect(false);
  if R.Top < 0 then
    DistX := R.Top
  else
  if R.Bottom > ClientHeight then
    DistX := R.Bottom - ClientHeight
  else
    DistX := 0;

  DistY := Indent * FNode.Level;
  if (DistX <> 0) then
  begin
    InitScrollInfo(Info, SIF_POS);
    GetScrollInfo(Handle, SB_VERT, Info);
    Offset := Info.Npos + ModDiv(DistX, (Abs(Font.Size) * 2));
    if Offset <> 0 then
      Perform(WM_VSCROLL , MakeWParam(SB_THUMBPOSITION, Offset), 0);
  end;

  if (DistY <> 0) then
  begin
    InitScrollInfo(Info, SIF_POS);
    GetScrollInfo(Handle, SB_HORZ, Info);
    Perform(WM_HSCROLL , MakeWParam(SB_THUMBPOSITION, DistY), 0);
  end;

end;

{------------------------------------------------------------------}

procedure TCustomDCDrawTreeView.DoScroll;
var
  HSInfo     : TScrollInfo;
  VSInfo     : TScrollInfo;
  OffX       : integer;
  OffY       : integer;
  Offset     : integer;
  Info       : TPoint;
begin
  GetCursorPos(Info);
  Info := ScreenToClient(Info);
  Info := ScrollInfoAt(Info.X,Info.Y);

  if (FDragObject <> nil) then
    FDragObject.HideDragImage;

  Offset := Abs(Font.Size) * 2;
  FSelfScrolling := true;
  try
    if sdLeft in FScrollDir then
      Perform(WM_HSCROLL,SB_LINELEFT,0);
    if sdRight in FScrollDir then
      Perform(WM_HSCROLL,SB_LINERIGHT,0);
    if sdUp in FScrollDir then
      Perform(WM_VSCROLL,SB_LINEUP,0);
    if sdDown in FScrollDir then
      Perform(WM_VSCROLL,SB_LINEDOWN,0);
  finally
    FSelfScrolling := false;
  end;

  if (FDragObject <> nil) then
    FDragObject.ShowDragImage;
  InitScrollInfo(HSInfo, SIF_POS);
  VSInfo := HSInfo;
  GetScrollInfo(Handle,SB_VERT,VSInfo);
  GetScrollInfo(Handle,SB_HORZ,HSInfo);
  OffX := abs(Info.X - HSInfo.nPos); //* Offset;
  OffY := abs(Info.Y - VSInfo.nPos) * Offset;

  FScrollPos := Point(0,0);
  if sdLeft in FScrollDir then
    inc(FScrollPos.X, OffX );
  if sdRight in FScrollDir then
    dec(FScrollPos.X, OffX );
  if sdUp in FScrollDir then
    inc(FScrollPos.Y, OffY );
  if sdDown in FScrollDir then
    dec(FScrollPos.Y, OffY);
  if FScrollTimerEnabled and (FScrollDir = []) then
  begin
    KillTimer(Handle,ScrollTimerID);
    FScrollTimerEnabled := false;
  end;

end;

{------------------------------------------------------------------}

function TCustomDCDrawTreeView.ScrollInfoAt(X, Y : integer) : TPoint;
var
  HSInfo     : TScrollInfo;
  VSInfo     : TScrollInfo;
  Offset     : integer;
begin
  FScrollDir := [];
  result := Point(0,0);
  FillChar(HSInfo,SizeOf(HSInfo),0);
  InitScrollInfo(HSInfo, SIF_ALL);
  VSInfo := HSInfo;
  GetScrollInfo(Handle,SB_VERT,VSInfo);
  GetScrollInfo(Handle,SB_HORZ,HSInfo);
  Offset := Abs(Font.Size) * 2;
  if (X <> 0) or  (Y <> 0) then
  begin
    with HSInfo do
    begin
      if (X < Offset) and (nPos > nMin) then
        Include(FScrollDir, sdLeft);
      if (nPage > 0) and (nPos + Integer(nPage) - 1 < nMax) and (X > ClientWidth - Offset) then
        Include(FScrollDir, sdRight);
    end;
    with VSInfo do
    begin
      if (Y < Offset) and (nPos > nMin) then
        Include(FScrollDir, sdUp);
      if (nPage > 0) and(Y > ClientHeight - Offset) and (nPos + Integer(nPage) - 1 < nMax) then
        Include(FScrollDir, sdDown);
    end;
  end;
  result.X :=  HSInfo.nPos;
  result.Y :=  VSInfo.nPos;
end;

{------------------------------------------------------------------}

procedure TCustomDCDrawTreeView.DoMouseScroll(X, Y : integer);
begin
  ScrollInfoAt(X, Y);
  if (FScrollDir <> []) then
  begin
    if FScrollTimerEnabled then
      KillTimer(Handle, ScrollTimerID);
    SetTimer(Handle, ScrollTimerID, GetScrollDelay(Self, X, Y), nil);
    FScrollTimerEnabled := true;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDCDrawTreeView.ToggleClickCheck(Node : TTreeNode);
var
  AState: TCheckState;
begin
  if ReadOnly and not AllowChange then
    exit;
  with TDrawNode(Node) do
  begin
    AState := Self.GetCheckState(Node);
    if not ((AState = csChecked) and RadioItem)  then
    begin
      case AState of
        csUnchecked:
          if Self.FAllowGrayed and FAllowGrayed and not RadioItem then
            AState := csGrayed
          else
            AState := csChecked;
        csChecked: AState := csUnchecked;
        csGrayed: AState := csChecked;
      end;
    CheckState := AState;
    end;
  end;
  ClickCheck(Node);
end;

{------------------------------------------------------------------}

procedure TCustomDCDrawTreeView.ClickCheck(Node : TTreeNode);
begin
  if Assigned(FOnClickCheck) then
    FOnClickCheck(Self,Node);
end;

{------------------------------------------------------------------}

function  TCustomDCDrawTreeView.GetNodeState(Node: TTReeNode) : TDrawNodeStates;
var
  Item: TTVItem;
begin
  Result := [];
  with Item do
  begin
    mask := TVIF_STATE;
    hItem := Node.ItemId;
    if TreeView_GetItem(Handle, Item) then
    begin
      if (state and TVIS_CUT) <> 0 then
        include(result ,msCut);
      if (state and TVIS_BOLD) <> 0 then
        include(result ,msBold);
      if (state and TVIS_FOCUSED) <> 0 then
        include(result , msFocused);
      if (state and TVIS_SELECTED) <> 0 then
        include(result , msSelected);
      if (state and TVIS_EXPANDED) <> 0 then
        include(result , msExpanded);
      if (state and TVIS_DROPHILITED) <> 0 then
        include(result , msDropHilited);
    end;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDCDrawTreeView.SetNodeStates(Node: TTreeNode; Value: TDrawNodeStates);
var
  Item: TTVItem;
begin
  if Node = nil then
    exit;
  with Item do
  begin
    mask := TVIF_STATE;
    hItem := Node.ItemId;
    stateMask := 0;
    if msCut in Value then
      stateMask := stateMask or TVIS_CUT;
    if msBold in Value then
      stateMask := stateMask or TVIS_BOLD;
    if msFocused in Value then
      stateMask := stateMask or  TVIS_FOCUSED;
    if msSelected in Value then
      stateMask :=  stateMask or TVIS_SELECTED;
    if msExpanded in Value then
      stateMask :=  stateMask or TVIS_EXPANDED;
    if msDropHilited in Value then
      stateMask := stateMask or TVIS_DROPHILITED;

    state := TVIS_CUT or TVIS_BOLD or TVIS_FOCUSED or TVIS_SELECTED or TVIS_EXPANDED or TVIS_DROPHILITED;
  end;
  TreeView_SetItem(Handle, Item);
end;

{------------------------------------------------------------------}

procedure TCustomDCDrawTreeView.SetNodeState(Node: TTreeNode; NodeState: TDrawNodeState ; Value : boolean);
var
  Item: TTVItem;
  Template: Integer;
begin
  if Node = nil then
    exit;
  if Value then
    Template := -1
  else
    Template := 0;
  with Item do
  begin
    mask := TVIF_STATE;
    hItem := Node.ItemId;
    case NodeState of
      msCut: stateMask :=  TVIS_CUT;
      msBold : stateMask := TVIS_BOLD;
      msFocused: stateMask :=  TVIS_FOCUSED;
      msSelected:  stateMask :=  TVIS_SELECTED;
      msExpanded: stateMask :=  TVIS_EXPANDED;
      msDropHilited: stateMask := TVIS_DROPHILITED;
    end;
    state := stateMask and Template;
  end;
  TreeView_SetItem(Handle, Item);
end;

{------------------------------------------------------------------}

procedure TCustomDCDrawTreeView.DoStartDrag(var DragObject: TDragObject);
begin
  inherited;
  FDragTreeView := Self;
  FWindowsSaveCursor := Windows.GetCursor;
end;

{------------------------------------------------------------------}

procedure TCustomDCDrawTreeView.DoEndDrag(Target: TObject; X, Y: Integer);
begin
  inherited;
  FDragTreeView := nil;
  Windows.SetCursor(FWindowsSaveCursor);
end;

{------------------------------------------------------------------}

procedure TCustomDCDrawTreeView.UpdateDragCursor;
var
  ADragCursor : TCursor;

  {-----------------------------------------------------------}

  function DragAllowed : boolean;
  var
    ACursor : HCursor;
  begin
    ACursor := Windows.GetCursor;
    with Screen do
      result := (Cursors[crDrag] = ACursor) or (Cursors[crMultiDrag] = ACursor) or
     (Cursors[crCtrlDrag] = ACursor) or (Cursors[crCtrlMultiDrag] = ACursor) ;
  end;

  {-----------------------------------------------------------}

begin

  if (GetAsyncKeyState(VK_CONTROL) <> 0) and DragAllowed then
    if FMultiDragged then
      ADragCursor := crCtrlMultiDrag
    else
      ADragCursor := crCtrlDrag
  else
    if FMultiDragged then
      ADragCursor := crMultiDrag
    else
      ADragCursor := crDrag;
  if ADragCursor <> DragCursor then
  begin
    DragCursor := ADragCursor;
    Windows.SetCursor(Screen.Cursors[ADragCursor]);
  end;
end;

{----------------TCustomMSTreeView--------------------------------------}

constructor TCustomMSTreeView.Create(Aowner:TCOmponent);
begin
  inherited Create(Aowner);
  FItemsSelected := TList.Create;
  FSelectedList := TList.Create;
  FSelectDelay := 100;
  FAllowMultiDrag := true;
  FDeselectOnButton := true;
end;

{------------------------------------------------------------------}

destructor TCustomMSTreeView.Destroy;
begin
  FItemsSelected.Free;
  FSelectedList.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------}

procedure TCustomMSTreeView.BeginUpdate;
begin
  inc(fUpdateCount);
  inherited;
end;

{------------------------------------------------------------------}

procedure TCustomMSTreeView.EndUpdate;
begin
  dec(fUpdateCount);
  inherited;
end;

{------------------------------------------------------------------}

function TCustomMSTreeView.CreateNode: TTreeNode;
begin
  Result := inherited CreateNode;
end;

{------------------------------------------------------------------}

procedure TCustomMSTreeView.SetMultiSelect(Value:Boolean);
begin
  if FMultiSelect <> Value then
  begin
    FMultiSelect:=Value;
    if not value then
      ClearSelection;
    {else
      FFirstSelNode := Selected;}
  end;
end;

{------------------------------------------------------------------}

procedure TCustomMSTreeView.SetSelectOnlySiblings(Value : boolean);
begin
  if FSelectOnlySiblings <> value then
  begin
    FSelectOnlySiblings := value;
    if value then
      CheckSiblings(Selected);
  end;
end;

{------------------------------------------------------------------}

procedure TCustomMSTreeView.CheckSiblings(Node : TTreeNode);
var
  i       : integer;
  AParent : TTreeNode;
begin
  if (Node = nil) or not (FSelectOnlySiblings) then
    exit;
  AParent := Node.Parent;
  with FItemsSelected do
    for i := Count - 1 downto 0 do
      with TTreeNode(Items[i]) do
        if Parent  <>  AParent then
        begin
          if TTreeNode(Items[i]) = FFirstSelNode then
            FFirstSelNode := nil;
          SetNodeState(TTreeNode(Items[i]),msSelected ,false);
        end;
  if Assigned(FFirstSelNode) and Assigned(Selected) and  (Node <> Selected) and (Selected.Parent <> AParent) then
    FFirstSelNode := nil;
end;

{------------------------------------------------------------------}

procedure  TCustomMSTreeView.DeleteSelectedItems;
var
  P       : Pointer;
  SelNode : TTreeNode;
begin
  SelNode := Selected;
  if Assigned(SelNode) and (msSelected in GetNodeState(SelNode)) and
    (FItemsSelected.IndexOf(SelNode) <0) then
    FItemsSelected.Add(SelNode);
  BeginUpdate;
  try
    while FItemsSelected.Count >0 do
    begin
      P:=FItemsSelected.Items[0];
      Items.Delete(P);
      FItemsSelected.Remove(P);
    end;
  finally
    EndUpdate;
  end;
  Change(Selected);
  ChangeSelect(Selected);
end;

{------------------------------------------------------------------}

function  TCustomMSTreeView.ItemSelected(Node:TTreeNode):boolean;
begin
  if Assigned(Node) then
    result:= msSelected in GetNodeState(Node)
  else
    result:=false;
end;

{------------------------------------------------------------------}

procedure TCustomMSTreeView.SelectionChanged;
begin
  if Assigned(FOnSelectionChanged) and (FUpdateCount<=0) then
    FOnSelectionChanged(Self,FChangeNode);
end;

{------------------------------------------------------------------}

procedure TCustomMSTreeView.FlushDelayedSelection;
begin
  if FTimerEnabled then
  begin
    KillTimer(Handle,TreeTimerID);
    FTimerEnabled := false;
    SelectionChanged;
  end
end;

{------------------------------------------------------------------}

procedure TCustomMSTreeView.WMTIMER(var M:TMessage);
begin
  inherited;
  if M.wParam = TreeTimerID then
    FlushDelayedSelection;
end;

{------------------------------------------------------------------}

procedure TCustomMSTreeView.ChangeSelect(Node : TTreeNode);
begin
  if ComponentState * [csReading ,csLoading] = [] then
    begin
      if FTimerEnabled then
        KillTimer(Handle,TreeTimerID);

      FChangeNode := Node;
      if fSelectDelay > 0 then
        begin
          SetTimer(Handle, TreeTimerID, FSelectDelay, nil);
          FTimerEnabled := true;
        end
      else
        SelectionChanged;
    end;
end;

{------------------------------------------------------------------}

procedure TCustomMSTreeView.SetItemsList(Value:Tlist; FocusSelected : boolean);
var
  i   : integer;
  Idx : integer;
  Lst : TSortedList;
begin
  Lst := TSortedList.Create;
  try
    with Value do
      for i := 0 to Count -1 do
        Lst.Add(Items[i]);

    if Assigned(Selected) and (Lst.IndexOf(Selected) < 0) then
      if FocusSelected then
        SetItemSelected(Selected , false)
      else
        Selected := nil;


    with FItemsSelected do
      for i:= Count - 1 downto 0 do
        if  Lst.Find(Items[i],Idx) then
          Lst.Delete(Idx)
        else
          SetItemSelected(Items[i],false);

    with Lst do
      for i := 0 to Count -1 do
      begin
        FItemsSelected.Add(Items[i]);
        SetItemSelected(Items[i],true);
      end;

  finally
    Lst.Free;
  end;
  UpdateWindow(Handle);
end;

procedure TCustomMSTreeView.SetItemsSelected(Value:Tlist);
begin
  SetItemsList(Value,false);
end;

{------------------------------------------------------------------}

function  TCustomMSTreeView.GetItemsSelected:TList;
var
  SelNode : TTreeNode;
begin
  result:= FSelectedList;
  CopyList(FItemsSelected, result);
  SelNode := Selected;
  if (SelNode <> nil) and (msSelected in GetNodeState(SelNode)) and
     (result.IndexOf(SelNode) <0 ) then
    result.Add(SelNode);
end;

{------------------------------------------------------------------}

procedure TCustomMSTreeView.SetItemSelected(Node:TTreeNode;Value:boolean);
begin
  if Assigned(Node) then
     SetNodeState(Node,msSelected,Value);
end;

{------------------------------------------------------------------}

procedure TCustomMSTreeView.SetNodeState(Node:TtreeNode;NodeState:TDrawNodeState;Value:boolean);
begin
  if (Node = nil) or ((NodeState = msSelected)  and Value and FSelectOnlySiblings and
     Assigned(Selected) and (Selected.Parent <> Node.Parent) ) then
    begin
      if not (msSelected in GetNodeState(Selected)) then
        Selected := Node;
      exit;
    end;

  inherited;
  if NodeState = msSelected  then
  begin
    if Value then
    begin
     if FItemsSelected.IndexOf(Node) < 0 then
        FItemsSelected.Add(Node);
    end
    else
      FItemsSelected.Remove(Node);
    if fUpdateCount <= 0 then
      ChangeSelect(Node);
  end;
end;

{------------------------------------------------------------------}

procedure TCustomMSTreeView.SetNodeStates(Node: TTreeNode; Value: TDrawNodeStates);
var
  OldSel  : boolean;
  NeedSel : boolean;
begin
  if Node = nil then
    exit;
  OldSel := ItemSelected(Node);
  NeedSel := msSelected in Value;
  if (not OldSel and NeedSel) or (OldSel and not NeedSel) then
    SetNodeState(Node, msSelected, NeedSel);
  inherited;
end;

{------------------------------------------------------------------}

procedure  TCustomMSTreeView.SelectAllItems;
var
  Node    : TTreeNode;
  SelNode : TTreeNode;
begin
  BeginUpdate;
  try
    Node:=Items.GetFirstNode;
    SelNode := Selected;
    while Assigned(Node) do
    begin
      if Node <> SelNode then
        SetNodeState(Node, msSelected, true);
      Node:=Node.GetNext;
    end;
    if (SelNode <> nil) and not (msSelected in GetNodeState(SelNode)) then
      SetNodeState(SelNode, msSelected, true);
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomMSTreeView.DeselectAllItems;
begin
  ClearSelection;
  Selected := nil;
end;

{------------------------------------------------------------------}

{$IFDEF D6}
procedure TCustomMSTreeView.ClearSelection(KeepPrimary: Boolean = False); 
{$ELSE}
procedure TCustomMSTreeView.ClearSelection;
{$ENDIF}
  procedure DoDeselecAll;
  var
    SelNode : TTreeNode;
  begin
    SelNode := Selected;
    with FItemsSelected do
      while Count >0 do
      begin
        if Items[0] = SelNode then
          Remove(Items[0])
        else
          SetNodeState(Items[0],msSelected,false);
      end;
  end;
begin
  FFirstSelNode:=nil;
  FCanSelect:=false;
  if FItemsSelected.Count = 0 then
     Exit;
  if FItemsSelected.Count > 1 then
  begin
    BeginUpdate;
    try
      DoDeselecAll;
    finally
      EndUpdate;
    end;
  end
  else
    DoDeselecAll;
  ChangeSelect(Selected);
end;

{------------------------------------------------------------------}

procedure TCustomMSTreeView.DoAfterCtrlPressed;
begin
  if FCtrlPressed then
  begin
    FCtrlPressed := false;
    ClearSelection;
    FFirstSelNode := Selected;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomMSTreeView.SelectNodes(Node:TTreeNode);
var
  Item      : TTreeNode;
  FSelState : boolean;
  FGoTop    : boolean;

  {--------------------------------}

  function GoTop : boolean;
  var
    R1 : TRect;
    R2 : TRect;
  begin
    if FDirection <> dtNone then
      result := FDirection = DtUp
    else
    begin
      R1 := Selected.DisplayRect(False);
      R2 := Node.DisplayRect(False);
      result := R1.Top < R2.Top;
    end;  
  end;

  {--------------------------------}

begin
  if (Node = nil) or (Selected = nil) then
    exit;
  FGoTop := GoTop;
  DoAfterCtrlPressed;
  If FGoTop then
    if FSelectOnlySiblings then
      Item :=Node.GetNextSibling
    else
      Item :=Node.GetNextVisible
  else
    if FSelectOnlySiblings then
      Item:=Node.GetPrevSibling
    else
      Item:=Node.GetPrevVisible;
  FSelState := (Item <> nil) and (msSelected  in GetNodeState(Item));
  Item := Node;
  inc(fUpdateCount);
  try
    while (Item <> nil) and (Item <> Selected) do
    begin
      if Item = FFirstSelNode then
      begin
        SetNodeState(Item, msSelected, true);
        FSelState := true;
      end
      else
        SetNodeState(Item,msSelected, FSelState);
      if FGoTop  then
        Item := Item.GetPrevVisible
      else
        Item := Item.GetNextVisible;
    end;
  finally
    dec(fUpdateCount);
  end;
  ChangeSelect(Node);
end;


{------------------------------------------------------------------}

procedure TCustomMSTreeView.FinishMouseSelect;
begin
 if FMouseSel then
  begin
    DrawMouseRect(FSelRect);
    FMouseSel := false;
    FMouseStartNode := nil;
    FSelRect := Rect(0,0,0,0);
    ReleaseCapture;
    if HotTrack then
      SetCtlStyle(Self, TVS_HOTTRACK, true);
    if  FScrollTimerEnabled then
    begin
      KillTimer(Handle, ScrollTimerID);
      FScrollTimerEnabled := false;
    end;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomMSTreeView.WMKILLFOCUS(var Message: TMessage);
begin
  if FitemsSelected.Count <> 0 then
    Invalidate;
  FinishMouseSelect;
  inherited;
end;

{------------------------------------------------------------------}

procedure TCustomMSTreeView.WMSETFOCUS(var Message: TMessage);
begin
  if FitemsSelected.Count <> 0 then
    Invalidate;
  inherited;
end;

{------------------------------------------------------------------}

procedure TCustomMSTreeView.CNNotify(var Message: TWMNotify);
var
  Node:TTreeNode;
begin
try
  with Message.NMHdr^ do
    case code of
      TVN_SELCHANGING:
        with PNMTreeView(Pointer(Message.NMHdr))^ do
          CheckSiblings(GetDrawNodeFromItem(itemNew));
      TVN_SELCHANGED:
        with PNMTreeView(Pointer(Message.NMHdr))^ do
        begin
          if FMultiSelect and FCanSelect then
            SelectNodes(GetDrawNodeFromItem(ItemOld));
          ChangeSelect(GetDrawNodeFromItem(ItemNew));
        end;
      TVN_DELETEITEM:
        with PNMTreeView(Pointer(Message.NMHdr))^ do
        begin
          Node:=GetDrawNodeFromItem(ItemOld);
          FItemsSelected.Remove(Node);
          if FFirstSelNode = Node then
            FFirstSelNode:=nil;
          if FChangeNode = Node then
            FChangeNode := nil;
        end;
      NM_CLICK: FClicked := True;
    end;
    inherited;
 except
   asm nop end;
 end;
end;

{------------------------------------------------------------------}

procedure TCustomMSTreeView.WMChar(var Message: TWMChar);
begin
  if FMouseSel then
  begin
    if (Message.CharCode = VK_ESCAPE) then
      FinishMouseSelect
  end
  else
    inherited;
end;

{------------------------------------------------------------------}

procedure TCustomMSTreeView.CNKeyDown(var Message: TWMKeyDown);
begin
  if not (FMouseSel and (Message.CharCode = VK_TAB)) then
    inherited;
end;

{------------------------------------------------------------------}

procedure TCustomMSTreeView.WMKeyDown(var Message:TWMKey);
var
  ShiftState:TShiftState;

  {--------------------------------------------------------}

  procedure ShiftPressed ;
  begin
    if FFirstSelNode = nil then
       FFirstSelNode := Selected;
    case  Message.CharCode of
      vk_down,vk_right,vk_end,vk_next:
      begin
        FDirection:= dtDown;
        FCanSelect:=true;
        inherited;
        FCanSelect:=false;
      end;
      vk_up,vk_left,vk_home,vk_prior:
      begin
        FCanSelect:=true;
        FDirection:= dtUp;
        inherited;
        FCanSelect:=false;
      end
      else
        Inherited;
    end;
  end;
begin
  FDirection := dtNone;
  if FMouseSel and (Message.CharCode <> VK_ESCAPE) then
    exit;

  ShiftState := KeyDataToShiftState(Message.KeyData);
  if FMultiSelect and (Message.CharCode in [vk_home, vk_prior, vk_end, vk_next,
                 vk_up, vk_left, vk_down, vk_right, vk_plus, vk_minus]) and (not isEditing ) then
  begin
    if not (ssCtrl in ShiftState) and (Selected <> nil) then
      with Message, Selected do
        if HasChildren and ((CharCode in [vk_plus,vk_right]) and not Expanded or (CharCode in [vk_minus, vk_left]) and Expanded) then
        begin
          ClearSelection;
          inherited;
          exit;
        end
        else
        if  (ssShift in ShiftState) then
        begin
          ShiftPressed;
          Exit;
        end
        else
        if (Message.CharCode in [vk_home,vk_prior,vk_end,vk_next, vk_up,vk_left,vk_down,vk_right]) then
        begin
          ClearSelection;
          inherited;
          Exit;
        end
  end;

  if  (ssCtrl in ShiftState) and (Message.CharCode = VK_MULTIPLY) then
  begin
    BeginUpdate;
    FAllowNotify:=true;
    try
      FullExpand;
    finally
      FAllowNotify:=false;
      EndUpdate;
    end;
  end;
  inherited;
end;

{------------------------------------------------------------------}

procedure TCustomMSTreeView.Edit(const Item : TTVItem);
begin
  try
    inherited;
  except
    FEditException := true;
    raise;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomMSTreeView.WMLBUTTONUP(var Message : TWMMouse);
begin
  if FMultiSelect then
    FinishMouseSelect;
  inherited;
end;

{------------------------------------------------------------------}

procedure TCustomMSTreeView.WMRBUTTONDOWN(var Message : TWMMouse);
var
  Node    : TTreeNode;
  OldNode : TTreeNode;
begin
  if not FMultiSelect then
  begin
    inherited ;
    exit;
  end;
  FinishMouseSelect;
  with Message do
    if PtInRect(ClientRect, Point(XPos, YPos)) then
    begin
      if RightClickSelect then
      begin
        Node := GetNodeAt(XPos, YPos);
        if (Selected <> nil) and (Node <> nil) then
        begin
          OldNode := Selected;
          Selected := Node;
          SetNodeState(OldNode, msSelected, true);
          inherited;
          Selected := OldNode;
          SetNodeState(Node, msSelected, true);
          exit;
        end;
      end;
      inherited;
    end;
end;

{------------------------------------------------------------------}

procedure TCustomMSTreeView.WMLBUTTONDOWN(var Message : TWMMouse);
var
  Node       : TTreeNode;
  OldSel     : TTreeNode;
  ShiftState : TShiftState;
  Info       : THitTests;

  {---------------------------------------------------------}

  procedure CtrlPressed(XYNode:TTreeNode);
  var
    SelState:boolean;
  begin
     SendCancelMode(Self);
     if Canfocus then
       SetFocus;
     FCtrlPressed := true;
     if FFirstSelNode = nil  then
       FFirstSelNode:=Selected;
     SelState:= (msSelected in GetNodeState(XYNode));
     if SelState then
       SetNodeState(XYNode,msSelected,false)
     else
       SetNodeState(XYNode,msSelected,true);
     ChangeSelect(XYNode);
  end;

  {---------------------------------------------------------}

  procedure ShiftPressed(XYNode:TTreeNode);
  var
    OldSel : TTreeNode;
  begin
    DoAfterCtrlPressed;
    if FFirstSelNode = nil  then
       FFirstSelNode:=Selected;
    if Assigned(Selected) then
    begin
      OldSel := Selected;
      Selected := XyNode;
      SelectNodes(OldSel);
      inherited;
      TreeView_EndEditLabelNow(Handle,true);
    end;
  end;

  {---------------------------------------------------------}

  procedure SelectFocusedNode;
  begin
    if Assigned(Selected) and not (msSelected in GetNodeState(Selected)) then
    begin
      SetNodeState(Selected,MsSelected,true);
      TreeView_EndEditLabelNow(Handle,true);
    end;
  end;

  {---------------------------------------------------------}

  function CanStartMouseSelect(const Info : THitTests) : boolean;
  begin
    if RowSelect then
      result := (Info = [])  or  (htNowhere in Info)
    else
      result := (Info = []) or (Info * [htNowhere,htOnRight,htOnIndent] <> []);
  end;

  {---------------------------------------------------------}

  function UserDrag : boolean;
  begin
    result := (DragMode = dmManual) and Dragging;
  end;

  {---------------------------------------------------------}

begin
  FEditException := false;
  if not FMultiSelect then
  begin
    inherited;
    exit;
  end;
  FDirection := dtNone;
  FDragged := false;
  with Message do
  begin
    ShiftState:=KeyDataToShiftState(Keys);
    Info := GetHitTestInfoAt(XPos,YPos);
    if CanStartMouseSelect(Info) then
    begin
      Node := nil;
      FMouseStartPos := Point(XPos,YPos);
    end
    else
      Node := GetNodeAt(XPos,YPos);
  end;

  if FMultiSelect and (not isEditing) and  Assigned(Node) and not (htOnButton in Info) then
  begin
    if ssCtrl in ShiftState then
      CtrlPressed(Node)
    else
    if  ssShift in ShiftState then
      ShiftPressed(Node)
    else
    if not ClickOnCheck(Message.Xpos,Message.Ypos) then
    begin
      if  Node.Selected and  (htOnItem in Info) then
      begin
        SetFocus;
        if Assigned(Selected) and (msSelected in GetNodeState(Selected)) then
          OldSel := Selected
        else
          OldSel := nil;

        if (DragMode = dmAutomatic) then
        begin
          Selected := Node;
          if Assigned(OldSel) then
            SetNodeState(OldSel ,msSelected,true);
        end;
        FClicked :=  false;
        inherited;
        if (not FAllowMultiDrag) or (FClicked and not UserDrag)  then
        begin
          ClearSelection;
          SelectFocusedNode;
        end
        else
        if (DragMode <> dmAutomatic) and Assigned(OldSel) then
          SetNodeState(OldSel ,msSelected,true);
      end
      else
      begin
        ClearSelection;
        inherited;
        SelectFocusedNode;
      end;
    end;
  end
  else
  begin
    if FMultiSelect and not FDeselectOnButton and (htOnButton in Info) then
    begin
      OldSel := Selected;
      inherited;
      if OldSel <> nil then
        SetNodeState(OldSel ,msSelected, true);
    end
    else
    begin
      ClearSelection;
      inherited;
    end;
  end;

  FMouseSel := not FEditException and FMultiSelect and (not isEditing) and (Node = nil) and not Dragging;
  if FMouseSel then
  begin
    with FMouseStartPos do
    begin
      FMouseStartNode := GetNodeAt(X,Y);
      SetCapture(Handle);
    end;
    if HotTrack then
      SetCtlStyle(Self, TVS_HOTTRACK, false);
  end;
  FEditException := false;
end;

{------------------------------------------------------------------}

procedure TCustomMSTreeView.DrawMouseRect(const R : TRect);
var
  DC : THandle;
begin
  if not IsRectEmpty(R) then
  begin
    DC := GetDC(Handle);
    DrawFocusRect(DC,R);
    ReleaseDC(Handle,DC)
  end;
end;

{------------------------------------------------------------------}

function  TCustomMSTreeView.GetFocusRect(const Rect : TRect; const Point : TPoint) : TRect;
begin
  result := Rect;
  with result, Point do
  begin
    SwapMaxInt(Left, Right);
    SwapMaxInt(Top, Bottom);
    if  X >= 0 then
      Left := Max(Left,0)
    else
      Right := Max(Right, 1);
    if X < ClientWidth then
      Right := Min(Right, ClientWidth  - 1);
    if Y >= 0 then
      Top := Max(Top,0)
    else
      Bottom := Max(Bottom , 1);
    if Y < ClientHeight then
     Bottom := Min(Bottom, ClientHeight - 1);
  end;
end;

{------------------------------------------------------------------}

procedure TCustomMSTreeView.DoScroll;
var
  Pt : TPoint;
begin
  if FMouseSel then
  begin
    DrawMouseRect(FSelRect);
    inherited;
    if FScrollDir <> [] then
    begin
      with FSelRect, FMouseStartPos do
      begin
        inc(X, FScrollPos.X);
        inc(Y, FScrollPos.Y);
        GetCursorPos(Pt);
        Pt := ScreenToClient(Pt);
        FSelRect := GetFocusRect(Rect(Pt.X, Pt.Y, X, Y), Point(X,Y));
      end;
      SelectNodesWithRect(FSelRect);
    end;
    DrawMouseRect(FSelRect);
  end
  else
    inherited;
end;

{------------------------------------------------------------------}

procedure TCustomMSTreeView.SelectNodesWithRect(const Rect : TRect);
var
  Node       : TTreeNode;
  FinishNode : TTreeNode;
  Lst        : TList;
  R          : TRect;
begin
  Lst := TList.Create;
  try
    if (FMouseStartNode <> nil) and (FMouseStartPos.Y  <= Rect.Top) then
      Node := FMouseStartNode
    else
      Node := GetNodeAt(max(Rect.Left,0),Rect.Top);
    FinishNode := GetNodeAt(min(Rect.Right,ClientWidth),Rect.Bottom);
    while Assigned(Node) do
    begin
      if Node.IsVisible then
      begin
        InterSectRect(R, Node.DisplayRect(true),Rect);
        if not IsRectEmpty(R) then
          Lst.Add(Node);
      end;
      if Node = FinishNode then
        break;
      Node := Node.GetNext;
    end;
    SetItemsList(Lst,true);
  finally
    lst.Free;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomMSTreeView.WMHScroll(var Message: TWMHScroll);
var
  OffX   : integer;
  Pt     : TPoint;
begin
  if not (FMouseSel and  FMultiSelect) then
  begin
    inherited;
    exit;
  end;
  if not FSelfScrolling then
  begin
    DrawMouseRect(FSelRect);
    OffX  := ScrollInfoAt(0,0).X;
    inherited;
    OffX := (OffX - ScrollInfoAt(0,0).X);
    GetCursorPos(Pt);
    Pt := ScreenToClient(Pt);
    with FMouseStartPos do
    begin
      inc(X, OffX);
      FSelRect := GetFocusRect(Rect(Pt.X, Pt.Y, X, Y), Point(X,Y));
    end;
    SelectNodesWithRect(FSelRect);
    DrawMouseRect(FSelRect);
  end
  else
    inherited;
end;

{------------------------------------------------------------------}

procedure TCustomMSTreeView.WMVScroll(var Message: TWMHScroll);
var
  Offset : integer;
  OffY   : integer;
  Pt     : TPoint;
begin
  if not (FMouseSel and  FMultiSelect) then
  begin
    inherited;
    exit;
  end;
  if not FSelfScrolling then
  begin
    DrawMouseRect(FSelRect);
    Offset := Abs(Font.Size) * 2;
    OffY  := ScrollInfoAt(0,0).Y;
    inherited;
    OffY := (OffY - ScrollInfoAt(0,0).Y) * Offset;
    GetCursorPos(Pt);
    Pt := ScreenToClient(Pt);
    with FMouseStartPos do
    begin
      inc(Y, OffY);
      FSelRect := GetFocusRect(Rect(Pt.X, Pt.Y, X, Y), Point(X,Y));
    end;
    SelectNodesWithRect(FSelRect);
    DrawMouseRect(FSelRect);
  end
  else
    inherited;
end;

{------------------------------------------------------------------}

procedure TCustomMSTreeView.WMMOUSEMOVE(var Message: TWMMouseMove);
begin
  if not (FMouseSel and  FMultiSelect) then
  begin
    inherited;
    exit;
  end;
  FScrollPos := Point(0,0);
  DrawMouseRect(FSelRect);
  inherited;
  with Message, FSelRect, FMouseStartPos do
  begin
    if FAutoScroll then
      DoMouseScroll(Xpos,Ypos);
    FSelRect := GetFocusRect(Rect(Xpos,Ypos, X, Y), Point(X,Y));
  end;
  SelectNodesWithRect(FSelRect);
  DrawMouseRect(FSelRect);
end;

{------------------------------------------------------------------}

procedure TCustomMSTreeView.DestroyTimers;
begin
  inherited;
  if HandleAllocated and FTimerEnabled then
  begin
    KillTimer(Handle,TreeTimerID);
    FTimerEnabled := false;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomMSTreeView.DoStartDrag(var DragObject: TDragObject);
var
  Cnt : integer;
begin
  FDragged := true;
  FDragSaveCursor := DragCursor;
  Cnt := FItemsSelected.Count;
  if FAllowMultiDrag and ((Cnt > 1) or
  ((Cnt = 1) and (Selected <> nil) and (FItemsSelected.IndexOf(Selected) <0) )) then
  begin
    DragCursor := crMultiDrag;
    FMultiDragged := true;
  end;
  inherited;
end;

{------------------------------------------------------------------}

procedure TCustomMSTreeView.DragOver(Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  FDragged := true;
  inherited;
end;

{------------------------------------------------------------------}

procedure TCustomMSTreeView.DoEndDrag(Target: TObject; X, Y: Integer);
begin
  DragCursor := FDragSaveCursor;
  FMultiDragged := false;
  FDragged := false;
  inherited;
end;

{------------------------------------------------------------------}

procedure TCustomMSTreeView.CMDrag(var Message: TCMDrag);
begin
  with Message,DragRec^ do
    if DragMessage = dmDragMove then
    begin
      TDragObject(Source).HideDragImage;
      inherited;
      TDragObject(Source).ShowDragImage;
    end
    else
      inherited;
end;

{------------------------------------------------------------------}


procedure TCustomMSTreeView.TVMSELECTITEM(var Message: TMessage) ;
var
  Node : TTreeNode;

  {-------------------------------------------------------------}

  procedure SetDropValue(Node : TTreeNode; value : boolean);
  var
    R : TRect;
  begin
    if Assigned(Node) and not (msSelected in GetNodeState(Node)) then
    begin
      SetNodeState(Node, msDropHilited, Value);
      R := Node.DisplayRect(true);
      InvalidateRect(Handle,@R,false);
      UpdateWindow(Handle);
    end;
  end;

  {-------------------------------------------------------------}

begin
  with Message do
    if FDragged and (wParam = TVGN_DROPHILITE) then
    begin
      Node := Items.GetNode(HTREEITEM(Lparam));
      if FOldDragNode <> Node then
      begin
        SetDropValue(FOldDragNode,false);
        SetDropValue(Node,true);
        if Node <> nil then
          FOldDragNode := Node;
      end;
      exit;
    end;
  FOldDragNode := nil;
  inherited;
end;

{----------TDrawTreeNodes-------------------------------------------}

constructor TDrawTreeNodes.Create(AOwner: TCustomMsTreeView);
begin
  inherited Create;
  FOwner := AOwner;
  FItems := AOwner.Items;
end;

{------------------------------------------------------------------}

function TDrawTreeNodes.InternalAdd(Node: TTreeNode; const S: string; Ptr:Pointer;InsertType:TNodeAttachMode): TTreeNode;
begin
  case InsertType of
    naAdd                 :  result := FItems.AddObject(Node,s,Ptr);
    naAddFirst            :  result := FItems.AddObjectFirst(Node,s,Ptr);
    naInsert              :  result := FItems.InsertObject(Node,s,Ptr);
    naAddChild            :  result:=  FItems.AddChildObject(Node,s,Ptr);
    naAddChildFirst       :  result := FItems.AddChildObjectFirst(Node,s,Ptr);
    else
      result := nil;
  end;
end;

{------------------------------------------------------------------}

function TDrawTreeNodes.AddChildFirst(Node: TTreeNode; const S: string): TTreeNode;
begin
  result:=InternalAdd(Node,S,nil,naAddChildFirst);
end;

{------------------------------------------------------------------}

function TDrawTreeNodes.AddChild(Node: TTreeNode; const S: string): TTreeNode;
begin
  result:=InternalAdd(Node,S,nil,naAddChild);
end;

{------------------------------------------------------------------}

function TDrawTreeNodes.AddChildObjectFirst(Node: TTreeNode; const S: string;
   Ptr: Pointer): TTreeNode;
begin
  result:=InternalAdd(Node,S,Ptr,naAddChildFirst);
end;

{------------------------------------------------------------------}

function TDrawTreeNodes.AddChildObject(Node: TTreeNode; const S: string;
  Ptr: Pointer): TTreeNode;
begin
  result:=InternalAdd(Node,S,Ptr,naAddChild);
end;

{------------------------------------------------------------------}

function TDrawTreeNodes.AddFirst(Node: TTreeNode; const S: string): TTreeNode;
begin
  result:=InternalAdd(Node,S,nil,naAddFirst);
end;

{------------------------------------------------------------------}

function TDrawTreeNodes.Add(Node: TTreeNode; const S: string): TTreeNode;
begin
  result:=InternalAdd(Node,S,nil,naAdd);
end;

{------------------------------------------------------------------}

function TDrawTreeNodes.AddObjectFirst(Node: TTreeNode; const S: string; Ptr: Pointer): TTreeNode;
begin
  result:=InternalAdd(Node,S,Ptr,naAddFirst);
end;

{------------------------------------------------------------------}

function TDrawTreeNodes.AddObject(Node: TTreeNode; const S: string;  Ptr: Pointer): TTreeNode;
begin
  result:=InternalAdd(Node,S,Ptr,naAdd);
end;

{------------------------------------------------------------------}

procedure TDrawTreeNodes.BeginUpdate;
begin
  Fitems.BeginUpdate;
end;

{------------------------------------------------------------------}

procedure TDrawTreeNodes.Clear;
begin
  FItems.Clear;
end;

{------------------------------------------------------------------}

procedure TDrawTreeNodes.Delete(Node: TTreeNode);
begin
  FItems.Delete(Node);
end;

{------------------------------------------------------------------}

procedure TDrawTreeNodes.EndUpdate;
begin
  FItems.EndUpdate;
end;

{------------------------------------------------------------------}

function TDrawTreeNodes.GetFirstNode: TTreeNode;
begin
  result := FItems.GetFirstNode;
end;

{------------------------------------------------------------------}

function TDrawTreeNodes.GetNode(ItemId: HTreeItem): TTreeNode;
begin
  result := FItems.GetNode(ItemId);
end;

{------------------------------------------------------------------}

function TDrawTreeNodes.Insert(Node: TTreeNode; const S: string): TTreeNode;
begin
  result := InternalAdd(Node,S,nil,naInsert);
end;

{------------------------------------------------------------------}

function TDrawTreeNodes.InsertObject(Node: TTreeNode; const S: string; Ptr: Pointer): TTreeNode;
begin
  result := InternalAdd(Node,S,Ptr,naInsert);
end;

{------------------------------------------------------------------}

function TDrawTreeNodes.GetHandle: HWND;
begin
  result := FItems.Handle;
end;
{------------------------------------------------------------------}

function TDrawTreeNodes.GetNodeFromIndex(Index: Integer): TTreeNode;
begin
  result := FItems.Item[Index];
end;

{------------------------------------------------------------------}

function TDrawTreeNodes.GetCount: Integer;
begin
  result := FItems.Count;
end;

{---------TCustomDrawListView---------------------------------------}

constructor TCustomDrawListView.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  FSelectedItems := TList.Create;
  FChangeTimer := TTimer.Create(Self);
  with FChangeTimer do
  begin
    Enabled := false;
    OnTimer := TimerExpired;
    Interval := 100;
  end;
end;

{------------------------------------------------------------------}

destructor TCustomDrawListView.Destroy;
begin
  if HandleAllocated then
    DestroyWindowHandle;
  FSelectedItems.Free;
  inherited;
end;

{------------------------------------------------------------------}

function  TCustomDrawListView.GetSelectedItems : TList;
var
  Item : TListItem;
begin
  FSelectedItems.Clear;
  Item := Selected;
  while Assigned(Item) do
  begin
    FSelectedItems.Add(Item);
    Item := GetNextItem(Item, sdAll, [isSelected]);
  end;
  result := FSelectedItems;
end;

{------------------------------------------------------------------}

function  TCustomDrawListView.GetSelectDelay : integer;
begin
  result := FChangeTimer.Interval;
end;

{------------------------------------------------------------------}

procedure TCustomDrawListView.CheckStyleChanged;
var
  b      : TBitmap;
  hIList : THandle;
  W      : integer;
  H      : integer;
  Style  : integer;
begin
  if not HandleAllocated then
    exit;
  hIList := ListView_GetImageList(Handle, LVSIL_STATE);
  if hIList = 0 then
    exit;
  if FCheckStyle = csFlat then
    Style := DFCS_FLAT
  else
    Style := 0;
  b := TBitmap.Create;
  try
    ImageList_GetIconSize(hIList, W, H);
    b.Width := W;
    b.Height := H;
    DrawFrameControl(b.canvas.handle, Rect(2, 2, W - 1, H - 1), DFC_BUTTON, DFCS_BUTTONCHECK or Style);
    ImageList_Replace(hIList, 0, b.Handle, 0);
    DrawFrameControl(b.canvas.handle, Rect(2, 2, W - 1, H - 1), DFC_BUTTON, DFCS_BUTTONCHECK or DFCS_CHECKED or Style);
    ImageList_Replace(hIList, 1, b.Handle, 0);
  finally
    b.Free;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDrawListView.SetCheckStyle(Value : TCheckStyle);
begin
  if FCheckStyle <> Value then
  begin
    FCheckStyle := Value;
    if CheckBoxes then
    begin
      CheckStyleChanged;
      RecreateWnd;
    end;  
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDrawListView.SetSelectDelay(Value : integer);
begin
  FChangeTimer.Interval := Value;
end;

{------------------------------------------------------------------}

procedure TCustomDrawListView.CreateWnd;
begin
  inherited CreateWnd;
  {$IFNDEF D4}
  ResetExStyles;
  SetTextBkColor(Color);
  {$ENDIF}
  CheckStyleChanged;
end;

{------------------------------------------------------------------}

procedure TCustomDrawListView.LVMSETEXTENDEDLISTVIEWSTYLE(Var Message:TMessage);
begin
  if not FSelfHandled then
  begin
    CheckStyleChanged;
    {$IFNDEF D4}
    ResetExStyles
    {$ELSE}
    inherited
    {$ENDIF}
  end
  else
    inherited;
end;

{------------------------------------------------------------------}

{$IFNDEF D4}

function TCustomDrawListView.GetItem(Value: TLVItem): TListItem;
begin
  with Value do
    if (mask and LVIF_PARAM) <> 0 then Result := TListItem(lParam)
    else Result := Items[IItem];
end;

{------------------------------------------------------------------}

procedure TCustomDrawListView.SetTextBkColor(Value: TColor);
begin
  ListView_SetTextBkColor(Handle, ColorToRGB(Color));
  ListView_SetBkColor(Handle, ColorToRGB(Color));
end;

{------------------------------------------------------------------}

procedure TCustomDrawListView.CMColorChanged(var Message : TMessage) ;
begin
  inherited;
  if HandleAllocated then
    SetTextBkColor(Color);
end;

{------------------------------------------------------------------}

procedure TCustomDrawListView.GetImageIndex(Item : TListItem);
begin
  if Assigned(FOnGetImageIndex) then
    FOnGetImageIndex(Self, Item);
end;


{------------------------------------------------------------------}

procedure TCustomDrawListView.SetFlatScrollBars(Value:boolean);
begin
  if FFlatScrollBars <> Value then
  begin
    FFlatScrollBars := Value;
    ResetExStyles;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDrawListView.SetFullDrag(Value: Boolean);
begin
  if FFullDrag <> Value then
  begin
    FFullDrag := Value;
    ResetExStyles;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDrawListView.SetHotTrackStyles(Value: TListHotTrackStyles);
begin
  if FHotTrackStyles <> Value then
  begin
    FHotTrackStyles := Value;
    ResetExStyles;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDrawListView.ResetExStyles;
var
  Styles: DWORD;
  TempImages : {$IFDEF D4} TCustomImageList {$ELSE}TImageList {$ENDIF};
begin
  if HandleAllocated then
  begin
    TempImages := nil;
    if StateImages <> nil then
    begin
      TempImages := StateImages;
      StateImages := nil;
    end;
    Styles := 0;
    if Checkboxes then Styles := LVS_EX_CHECKBOXES;
    if GridLines then Styles := Styles or LVS_EX_GRIDLINES;
    if HotTrack then Styles := Styles or LVS_EX_TRACKSELECT;
    if RowSelect then Styles := Styles or LVS_EX_FULLROWSELECT;
    if FFlatScrollBars then Styles := Styles or LVS_EX_FLATSB;
    if FFullDrag then Styles := Styles or LVS_EX_HEADERDRAGDROP;
    if FRegional then Styles := Styles or LVS_EX_REGIONAL;
    if HotTrack then
    begin
      if htHandPoint in FHotTrackStyles then
        Styles := Styles or LVS_EX_ONECLICKACTIVATE
      else
      if FHotTrackStyles * [htUnderlineHot, htUnderlineCold] <> [] then
        Styles := Styles or LVS_EX_TWOCLICKACTIVATE;
      if htUnderlineHot in FHotTrackStyles then
        Styles := Styles or LVS_EX_UNDERLINEHOT;
      if htUnderlineCold in FHotTrackStyles then
        Styles := Styles or LVS_EX_UNDERLINECOLD;
    end;
    FSelfHandled := true;
    try
      Perform(LVM_SETEXTENDEDLISTVIEWSTYLE, 0, Styles);
    finally
      FSelfHandled := false;
    end;
    if TempImages <> nil then
      StateImages := TempImages;
  end;
end;

{$ENDIF}

{$IFNDEF D3}

{------------------------------------------------------------------}

procedure TCustomDrawListView.SetCheckboxes(Value: Boolean);
begin
  if FCheckboxes <> Value then
  begin
    FCheckboxes := Value;
    ResetExStyles;
    CheckStyleChanged;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDrawListView.SetGridLines(Value: Boolean);
begin
  if FGridLines <> Value then
  begin
    FGridLines := Value;
    ResetExStyles;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDrawListView.SetHotTrack(Value: Boolean);
begin
  if FHotTrack <> Value then
  begin
    FHotTrack := Value;
    ResetExStyles;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDrawListView.SetRowSelect(Value: Boolean);
begin
  if FRowSelect <> Value then
  begin
    FRowSelect := Value;
    ResetExStyles;
  end;
end;

{$ENDIF}

{------------------------------------------------------------------}

procedure TCustomDrawListView.SetRegional(Value: Boolean);
var
  Styles: DWORD;
begin
  if (FRegional <> Value)  then
  begin
    FRegional := Value;
    Styles := SendMessage(Handle, LVM_GETEXTENDEDLISTVIEWSTYLE, 0, 0);
    if FRegional then
      Styles := Styles or LVS_EX_REGIONAL
    else
      Styles := Styles and not LVS_EX_REGIONAL;
    Perform(LVM_SETEXTENDEDLISTVIEWSTYLE, 0, Styles);
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDrawListView.LVMREDRAWITEMS(var Message : TMessage);
begin
  if not FInGetImageIndex then
    inherited;
end;

{------------------------------------------------------------------}

procedure TCustomDrawListView.CNNotify(var Message: TWMNotify);
{$IFNDEF D4}
var
  Item: TListItem;
{$ENDIF}  
begin
  with  Message.NMHdr^ do
    case code of
      LVN_ITEMCHANGED:
        with PNMListView(Pointer(Message.NMHdr))^ do
          if (uChanged = LVIF_STATE) then
            if ((uOldState and LVIS_SELECTED <> 0) and (uNewState and LVIS_SELECTED = 0)) or
               ( (uOldState and LVIS_SELECTED = 0) and  (uNewState and LVIS_SELECTED <> 0)) then
               ChangeSelect(Items[iItem]);
      LVN_DELETEITEM:
        with PNMListView(Pointer(Message.NMHdr))^ do
          if FChangeItem = TListItem(lParam) then
            FChangeItem := nil;
      LVN_GETDISPINFO:
        begin
          {$IFNDEF D4}
          Item := GetItem(PLVDispInfo(Pointer(Message.NMHdr))^.item);
          {$ENDIF}
          with PLVDispInfo(Pointer(Message.NMHdr))^.item do
          begin
            if (mask and LVIF_IMAGE) <> 0 then
            begin
              FInGetImageIndex := true;
              try
                {$IFNDEF D4}
                GetImageIndex(Item);
                iImage := Item.ImageIndex; //was after end !!
                {$ELSE}
                inherited;
                exit;
                {$ENDIF}
              finally
                FInGetImageIndex := false;
              end; //!!
            end;
          end;
        end;
    end;
  inherited;
end;

{---------------------------}

procedure TCustomDrawListView.TimerExpired(Sender : TObject);
begin
  FChangeTimer.Enabled := false;
  SelectionChanged;
end;

{------------------------------------------------------------------}

procedure TCustomDrawListView.ChangeSelect(Item : TListItem);
begin
  if (HandleAllocated) and (ComponentState * [csReading ,csLoading] = []) then
  begin
    FChangeTimer.Enabled  := false;
    FChangeTimer.Enabled  := true;
    FChangeItem := Item;
  end;
end;

{------------------------------------------------------------------}

procedure TCustomDrawListView.SelectionChanged;
begin
  if Assigned(FOnSelectionChanged) then
    FOnSelectionChanged(Self, FChangeItem);
end;

{-----------TDrawListItems------------------------------------------}
type
  TMListView = class(TCustomListView);

constructor TDrawListItems.Create(AOwner: TCustomListView);
begin
  inherited Create;
  FItems := TMListView(AOwner).Items;
  FOwner := AOwner;
end;

{------------------------------------------------------------------}

function TDrawListItems.InternalAdd(Index:integer; const S : String; InsertType: TNodeAttachMode):TListItem;
begin
  if InsertType in [naAdd,naAddFirst] then
    result := FItems.Add
  else
  if InsertType = naInsert then
    result:=  FItems.Insert(Index)
  else
    result := nil;
end;

{------------------------------------------------------------------}

function TDrawListItems.Add: TListItem;
begin
  result := InternalAdd(0,'',naAdd);
end;

{------------------------------------------------------------------}

procedure TDrawListItems.BeginUpdate;
begin
  FItems.BeginUpdate;
end;

{------------------------------------------------------------------}

procedure TDrawListItems.Clear;
begin
  FItems.Clear;
end;

{------------------------------------------------------------------}

procedure TDrawListItems.Delete(Index: Integer);
begin
  FItems.Delete(Index);
end;

{------------------------------------------------------------------}

procedure TDrawListItems.EndUpdate;
begin
  FItems.EndUpdate;
end;

{------------------------------------------------------------------}

function TDrawListItems.IndexOf(Value: TListItem): Integer;
begin
  result:= FItems.IndexOf(Value);
end;

{------------------------------------------------------------------}

function TDrawListItems.Insert(Index: Integer): TListItem;
begin
  result := InternalAdd(Index,'',naInsert);
end;

{------------------------------------------------------------------}

function TDrawListItems.AddCaption(const S : String):TListItem;
begin
  result := InternalAdd(0,S,naAdd);
end;

{------------------------------------------------------------------}

function TDrawListItems.InsertCaption(Index: Integer;const S : String): TListItem;
begin
  result := InternalAdd(Index,S,naInsert);
end;

{------------------------------------------------------------------}

function TDrawListItems.GetCount: Integer;
begin
  result := FItems.Count;
end;

{------------------------------------------------------------------}

procedure TDrawListItems.SetCount(Value: Integer);
begin
  SendMessage(Handle, LVM_SETITEMCOUNT, Value, LVSICF_NOINVALIDATEALL);
end;

{------------------------------------------------------------------}

function TDrawListItems.GetHandle: HWND;
begin
  result := FItems.Handle;
end;

{------------------------------------------------------------------}

function TDrawListItems.GetItem(Index: Integer): TListItem;
begin
  result := FItems.Item[Index];
end;

{------------------------------------------------------------------}

procedure TDrawListItems.SetItem(Index: Integer; Value: TListItem);
begin
  AssignListItem(Item[Index], Value);
end;

{------------------------------------------------------------------}

procedure TDrawListItems.Assign(Source: TPersistent);
var
  Items : TDrawListItems;
  i     : Integer;
begin
  if Source is TDrawListItems then
  begin
    Clear;
    Items := TDrawListItems(Source);
    for i := 0 to Items.Count - 1 do
      AssignListItem(Add, Items[i]);
  end
  else
    inherited Assign(Source);
end;

{------------------------------------------------------------------}

procedure TDrawListItems.AssignListItem(Destination, Source  : TListItem);
begin
  with Source do
  begin
    Destination.Caption := Caption;
    Destination.Data := Data;
    Destination.ImageIndex := ImageIndex;
    Destination.OverlayIndex := OverlayIndex;
    Destination.StateIndex := StateIndex;
    Destination.SubItems := SubItems;
    {$IFDEF D4}
    Destination.Indent := Indent;
    if Destination.Checked <> Checked then
      Destination.Checked := Checked;
    {$ENDIF}
  end
end;


{------------------------------------------------------------------}

procedure Register;
begin
  RegisterComponents(SPalDreamInfoTree,
    [TDCDrawTreeView,TDCMSTreeView,TDCDrawListView]);
end;

{------------------------------------------------------------------}

procedure InitCheckImages;
var
  Bitmap : TBitmap;
begin
  CheckImages := TImageList.Create(nil);
  CheckImages.Name := SCheckImages;  
  Bitmap := TBitmap.Create;
  try
    Bitmap.LoadFromResourceName(HINstance,'CHECK_DARK'); //don't resource
    CheckImages.AddMasked(Bitmap,Bitmap.TransparentColor);
  finally
    Bitmap.Free;
  end;

end;

{------------------------------------------------------------------}

function  CallDragHook(code,Wparam,Lparam:integer) : hresult; stdcall;

  {-----------------------------------------------------}

  function EscPressed : boolean;
  begin
    result := (word(wParam) = VK_ESCAPE)  and (KeyDataToShiftState(lParam) * [ssCtrl, ssAlt,SsShift] = []);
  end;
  {-----------------------------------------------------}

  function CtrlPressed : boolean;
  begin
    result := word(wParam) = VK_CONTROL;
  end;

  {-----------------------------------------------------}

begin
  if (Code = HC_ACTION) and  (FDragTreeView <> nil) then
  begin
    if EscPressed then
    begin
      FDragTreeView.EndDrag(false);
      result := 1;
      exit;
    end
    else
    if CtrlPressed then
      FDragTreeView.UpdateDragCursor;
  end;

  result := CallNextHookEx(FDragHook,code,Wparam,Lparam)
end;

{------------------------------------------------------------------}

initialization
  InitCheckImages;
  FDragHook := SetWindowsHookEx(WH_KEYBOARD, @CallDragHook, 0, GetCurrentThreadId);
  Screen.Cursors[crCtrlDrag]:= LoadCursor(HInstance, 'TREEDRAGCOPY'); //don't resource
  Screen.Cursors[crCtrlMultiDrag]:= LoadCursor(HInstance,'TREEDRAGMULTICOPY'); //don't resource

finalization
  CheckImages.Free;
  if FDragHook <> 0 then
    UnhookWindowsHookEx(FDragHook);

end.

