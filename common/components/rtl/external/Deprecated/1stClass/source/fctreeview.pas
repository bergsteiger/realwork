unit fcTreeView;
{
//
// Components : TfcTreeView
//
// Copyright (c) 1999 by Woll2Woll Software
// 3/3/99 - (RSW) Remove tvoUnderscoreAllowed Option
// 5/21/99 - Complete editing
// 6/14/99 - Fix disappearing tree when going into edit mode
// 6/23/99 - Fire OnDblClick event even when ExpandOnDblClick is False
// 7/3/99 - Only call Invalidate if not in expanding/collapsing
// 7/6/99 - Support streaming of TfcTreeView Items to TfcTreecombo's tree
}
interface

{$i fcIfdef.pas}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  CommCtrl, ComStrs, consts, comctrls, fccustomdraw, fccanvas, extctrls, fccommon,
  shellapi
  {$ifdef fcDelphi4Up}, ImgList{$endif};

type
  TfcCustomTreeView = class;
  TfcTreeNode = class;
  TfcItemState = (fcisSelected, fcisGrayed, fcisDisabled, fcisChecked,
    fcisFocused, fcisDefault, fcisHot, fcisMarked, fcisIndeterminate);
  TfcItemStates = set of TfcItemState;
  TfcTVDrawTextEvent = procedure (TreeView: TfcCustomTreeview;
    Node: TfcTreeNode; ARect: TRect; AItemState: TfcItemStates;
    var DefaultDrawing: boolean) of object;
  TfcTreeMouseMoveEvent = procedure(TreeView: TfcCustomTreeView;
      Node: TfcTreeNode;
      Shift: TShiftState; X, Y: Integer)of object;
  TfcTreeMouseEvent = procedure(TreeView: TfcCustomTreeView;
      Node: TfcTreeNode;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer) of object;


  TfcTreeNodes = class;

  TfcNodeState = (fcnsCut, fcnsDropHilited, fcnsFocused, fcnsSelected,
                  fcnsExpanded);
  TfcNodeAttachMode = (fcnaAdd, fcnaAddFirst, fcnaAddChild, fcnaAddChildFirst,
                       fcnaInsert, fcnaInsertAfter);
  TfcAddMode = (fctaAddFirst, fctaAdd, fctaInsert);

  TfcTreeViewCheckboxType = (tvctNone, tvctCheckbox, tvctRadioGroup);

  TfcTreeViewOption = (tvoExpandOnDblClk, tvoExpandButtons3D,
     tvoFlatCheckBoxes, tvoHideSelection,
     tvoRowSelect, tvoShowButtons,
     tvoShowLines, tvoShowRoot,
     {tvoUnderscoreAllowed,} tvoHotTrack, tvoAutoURL, tvoToolTips,
     tvoEditText, tvo3StateCheckbox);
  TfcTreeViewOptions = set of TfcTreeViewOption;

  PfcNodeInfo = ^TfcNodeInfo;
  TfcNodeInfo = packed record
    ImageIndex: Integer;
    SelectedIndex: Integer;
    StateIndex: Integer;
    OverlayIndex: Integer;
    CheckboxType: TfcTreeViewCheckboxType;
    Checked: byte;
    DummyPad: packed array[1..4] of char;  { Allow Future growth }
    Data: Pointer;
    StringDataSize1: integer;
    StringDataSize2: integer;
    Count: Integer;
    Text: string[255];

    { Future growth so that old executables can still run with newer tree view formats }
//    Dummy1: integer;
//    Dummy2: integer;
//    Dummy3: integer;
//    Dummy4: integer;
  end;

  TfcTreeNode = class(TPersistent)
  private
    FMultiSelected: boolean;
    FCheckboxType: TfcTreeViewCheckboxType;
    FChecked: boolean;

    FOwner: TfcTreeNodes;
    FText: string;
    FStringData1, FStringData2: String;

    FData: Pointer;
    FItemId: HTreeItem;
    FImageIndex: Integer;
    FSelectedIndex: Integer;
    FOverlayIndex: Integer;
    FStateIndex: Integer;
    FDeleting: Boolean;
    FInTree: Boolean;
    FGrayed: boolean;

    procedure SetCheckboxType(val: TfcTreeViewCheckboxType);

    function CompareCount(CompareMe: Integer): Boolean;
    function DoCanExpand(Expand: Boolean): Boolean;
    procedure DoExpand(Expand: Boolean);
    procedure ExpandItem(Expand: Boolean; Recurse: Boolean);
    function GetAbsoluteIndex: Integer;
    function GetExpanded: Boolean;
    function GetLevel: Integer;
    function GetParent: TfcTreeNode;
    function GetChildren: Boolean;
    function GetCut: Boolean;
    function GetDropTarget: Boolean;
    function GetFocused: Boolean;
    function GetIndex: Integer;
    function GetItem(Index: Integer): TfcTreeNode;
    function GetSelected: Boolean;
    function GetState(NodeState: TfcNodeState): Boolean;
    function GetCount: Integer;
    function GetTreeView: TfcCustomTreeView;
    procedure InternalMove(ParentNode, Node: TfcTreeNode; HItem: HTreeItem;
      AddMode: TfcAddMode);
//    function IsEqual(Node: TfcTreeNode): Boolean;
    function IsNodeVisible: Boolean;
    procedure SetChildren(Value: Boolean);
    procedure SetCut(Value: Boolean);
    procedure SetData(Value: Pointer);
    procedure SetDropTarget(Value: Boolean);
    procedure SetItem(Index: Integer; Value: TfcTreeNode);
    procedure SetExpanded(Value: Boolean);
    procedure SetFocused(Value: Boolean);
    procedure SetImageIndex(Value: Integer);
    procedure SetOverlayIndex(Value: Integer);
    procedure SetSelectedIndex(Value: Integer);
    procedure SetSelected(Value: Boolean);
    procedure SetStateIndex(Value: Integer);
    procedure SetText(const S: string);

    function GetMultiSelected: Boolean;
    procedure SetMultiSelected(Value: Boolean);

    procedure SetChecked(val: boolean);
    procedure SetGrayed(val: boolean);
  protected
//    function ShowBlankImage: boolean; virtual;
    {$ifdef fcDelphi4Up}
    ReadDataSize: integer;
    {$endif}
    procedure Invalidate; virtual;
    Function GetSizeOfNodeInfo: integer; virtual;
    procedure ReadData(Stream: TStream; Info: PfcNodeInfo); virtual;
    procedure WriteData(Stream: TStream; Info: PfcNodeInfo); virtual;
  public
    Patch: Variant;
    function GetStateIndex: integer;
    Function IsRadioGroup: boolean;
    function GetSortText: string; virtual;

    constructor Create(AOwner: TfcTreeNodes); virtual;
    destructor Destroy; override;
    function AlphaSort: Boolean;
    procedure Assign(Source: TPersistent); override;
    procedure Collapse(Recurse: Boolean);
    function CustomSort(SortProc: TTVCompare; Data: Longint): Boolean;
    procedure Delete;
    procedure DeleteChildren;
    function DisplayRect(TextOnly: Boolean): TRect;
    function EditText: Boolean;
    procedure EndEdit(Cancel: Boolean);
    procedure Expand(Recurse: Boolean);
    function GetFirstChild: TfcTreeNode;
    function GetHandle: HWND;
    function GetLastChild: TfcTreeNode;
    function GetNext: TfcTreeNode;
    function GetNextChild(Value: TfcTreeNode): TfcTreeNode;
    function GetNextSibling: TfcTreeNode;
    function GetNextVisible: TfcTreeNode;
    function GetPrev: TfcTreeNode;
    function GetPrevChild(Value: TfcTreeNode): TfcTreeNode;
    function GetPrevSibling: TfcTreeNode;
    function GetPrevVisible: TfcTreeNode;
    function HasAsParent(Value: TfcTreeNode): Boolean;
    function IndexOf(Value: TfcTreeNode): Integer;
    procedure MakeVisible;
    procedure MoveTo(Destination: TfcTreeNode; Mode: TfcNodeAttachMode); virtual;
    property AbsoluteIndex: Integer read GetAbsoluteIndex;
    property Count: Integer read GetCount;
    property Cut: Boolean read GetCut write SetCut;
    property Data: Pointer read FData write SetData;
    property Deleting: Boolean read FDeleting;
    property Focused: Boolean read GetFocused write SetFocused;
    property DropTarget: Boolean read GetDropTarget write SetDropTarget;
    property Selected: Boolean read GetSelected write SetSelected;
    property Expanded: Boolean read GetExpanded write SetExpanded;
    property Handle: HWND read GetHandle;
    property HasChildren: Boolean read GetChildren write SetChildren;
    property ImageIndex: Integer read FImageIndex write SetImageIndex;
    property Index: Integer read GetIndex;
    property IsVisible: Boolean read IsNodeVisible;
    property Item[Index: Integer]: TfcTreeNode read GetItem write SetItem; default;
    property ItemId: HTreeItem read FItemId;
    property Level: Integer read GetLevel;
    property OverlayIndex: Integer read FOverlayIndex write SetOverlayIndex;
    property Owner: TfcTreeNodes read FOwner;
    property Parent: TfcTreeNode read GetParent;
    property SelectedIndex: Integer read FSelectedIndex write SetSelectedIndex;
    property StateIndex: Integer read FStateIndex write SetStateIndex;
    property Text: string read FText write SetText;
    property StringData: string read FStringData1 write FStringData1;
    property StringData2: string read FStringData2 write FStringData2;
    property TreeView: TfcCustomTreeView read GetTreeView;

    property Checked: boolean read FChecked write SetChecked;
    property Grayed: boolean read FGRayed write SetGrayed;
    property CheckboxType: TfcTreeViewCheckboxType read FCheckboxType write SetCheckboxType;
    property MultiSelected: Boolean read GetMultiSelected write SetMultiSelected;
  end;

{ TfcTreeNodes }

  PfcNodeCache = ^TfcNodeCache;
  TfcNodeCache = record
    CacheNode: TfcTreeNode;
    CacheIndex: Integer;
  end;

  TfcTreeNodes = class(TPersistent)
  private
    FOwner: TfcCustomTreeView;
    FUpdateCount: Integer;
    FNodeCache: TfcNodeCache;
    InDestroy: boolean;
    procedure AddedNode(Value: TfcTreeNode);
    function GetHandle: HWND;
    function GetNodeFromIndex(Index: Integer): TfcTreeNode;
    procedure ReadData(Stream: TStream);
    procedure Repaint(Node: TfcTreeNode);
    procedure WriteData(Stream: TStream);
    procedure ClearCache;
    procedure ReadStreamVersion(Reader: TReader);
    procedure WriteStreamVersion(Writer: TWriter);
  protected
    function AddItem(Parent, Target: HTreeItem; const Item: TTVItem;
      AddMode: TfcAddMode): HTreeItem;
    function InternalAddObject(Node: TfcTreeNode; const S: string;
      Ptr: Pointer; AddMode: TfcAddMode): TfcTreeNode;
    procedure DefineProperties(Filer: TFiler); override;
    function CreateItem(Node: TfcTreeNode): TTVItem;
    function GetCount: Integer;
    procedure SetItem(Index: Integer; Value: TfcTreeNode);
    procedure SetUpdateState(Updating: Boolean);
  public
    constructor Create(AOwner: TfcCustomTreeView);
    destructor Destroy; override;
    function AddChildFirst(Node: TfcTreeNode; const S: string): TfcTreeNode;
    function AddChild(Node: TfcTreeNode; const S: string): TfcTreeNode;
    function AddChildObjectFirst(Node: TfcTreeNode; const S: string;
      Ptr: Pointer): TfcTreeNode;
    function AddChildObject(Node: TfcTreeNode; const S: string;
      Ptr: Pointer): TfcTreeNode;
    function AddFirst(Node: TfcTreeNode; const S: string): TfcTreeNode;
    function Add(Node: TfcTreeNode; const S: string): TfcTreeNode;
    function AddObjectFirst(Node: TfcTreeNode; const S: string;
      Ptr: Pointer): TfcTreeNode;
    function AddObject(Node: TfcTreeNode; const S: string;
      Ptr: Pointer): TfcTreeNode;
    procedure Assign(Source: TPersistent); override;
    procedure BeginUpdate;
    procedure Clear;
    procedure Delete(Node: TfcTreeNode);
    procedure EndUpdate;
    function GetFirstNode: TfcTreeNode;
    function GetNode(ItemId: HTreeItem): TfcTreeNode;
    function Insert(Node: TfcTreeNode; const S: string): TfcTreeNode;
    function InsertObject(Node: TfcTreeNode; const S: string;
      Ptr: Pointer): TfcTreeNode;
    function FindNode(SearchText: string; VisibleOnly: Boolean): TfcTreeNode;
    property Count: Integer read GetCount;
    property Handle: HWND read GetHandle;
    property Item[Index: Integer]: TfcTreeNode read GetNodeFromIndex; default;
    property Owner: TfcCustomTreeView read FOwner;
  end;

{ TfcCustomTreeView }

  TfcTVMultiSelectAttributes = class(TPersistent)
  private
     FEnabled: Boolean;
     FAutoUnselect: boolean;
//     FAlwaysIncludeSelectedItem: Boolean;
     FMultiSelectLevel: integer;
     FMultiSelectCheckbox: boolean;
     TreeView: TfcCustomTreeView;
     procedure SetEnabled(val: boolean);
     procedure SetMultiSelectLevel(val: integer);
     procedure SetMultiSelectCheckBox(val: boolean);

  public
     constructor Create(Owner: TComponent);
     procedure Assign(Source: TPersistent); override;

  published
     property AutoUnselect : boolean read FAutoUnselect write FAutoUnselect default True;
//     property AlwaysIncludeSelectedItem: Boolean read FAlwaysIncludeSelectedItem write FAlwaysIncludeSelectedItem default False;
     property Enabled: boolean read FEnabled write SetEnabled default False;
     property MultiSelectLevel: integer read FMultiSelectLevel write SetMultiSelectLevel default 0;
     property MultiSelectCheckbox: boolean read FMultiSelectCheckbox write SetMultiSelectCheckbox default True;
  end;

  TfcHitTest = (fchtAbove, fchtBelow, fchtNowhere, fchtOnItem, fchtOnButton, fchtOnIcon,
    fchtOnIndent, fchtOnLabel, fchtOnRight, fchtOnStateIcon, fchtToLeft, fchtToRight);
  TfcHitTests = set of TfcHitTest;
  TfcSortType = (fcstNone, fcstData, fcstText, fcstBoth);
  EfcTreeViewError = class(Exception);

  TfcTVChangingEvent = procedure(TreeView: TfcCustomTreeView; Node: TfcTreeNode;
    var AllowChange: Boolean) of object;
  TfcTVChangedEvent = procedure(TreeView: TfcCustomTreeView; Node: TfcTreeNode) of object;
  TfcTVEditingEvent = procedure(TreeView: TfcCustomTreeView; Node: TfcTreeNode;
    var AllowEdit: Boolean) of object;
  TfcTVEditedEvent = procedure(TreeView: TfcCustomTreeView; Node: TfcTreeNode; var S: string) of object;
  TfcTVExpandingEvent = procedure(TreeView: TfcCustomTreeView; Node: TfcTreeNode;
    var AllowExpansion: Boolean) of object;
  TfcTVCollapsingEvent = procedure(TreeView: TfcCustomTreeView; Node: TfcTreeNode;
    var AllowCollapse: Boolean) of object;
  TfcTVExpandedEvent = procedure(TreeView: TfcCustomTreeView; Node: TfcTreeNode) of object;
  TfcTVCompareEvent = procedure(TreeView: TfcCustomTreeView; Node1, Node2: TfcTreeNode;
    Data: Integer; var Compare: Integer) of object;
  TfcTVCustomDrawEvent = procedure(TreeView: TfcCustomTreeView; const ARect: TRect;
    var DefaultDraw: Boolean) of object;
  TfcCalcNodeAttributesEvent = procedure(TreeView: TfcCustomTreeView;
          Node: TfcTreeNode; State: TfcItemStates) of object;

  TfcItemChangeAction = (icaAdd, icaDelete, icaText, icaImageIndex);
  TfcItemChangeEvent = procedure(TreeView: TfcCustomTreeView; Node: TfcTreeNode;
    Action: TfcItemChangeAction; NewValue: Variant) of object;
  TfcToggleCheckboxEvent = procedure(TreeView: TfcCustomTreeView; Node: TfcTreeNode) of object;

  TfcTreeNodeClass = class of TfcTreeNode;

  TfcCustomTreeView = class(TWinControl)
  private
    FOnItemChange: TfcItemChangeEvent;
//    FOnItemChanging: TfcItemChangeEvent;
    FAutoExpand: Boolean;
    FBorderStyle: TBorderStyle;
    FCanvas: TfcCanvas;
    FPaintCanvas: TfcCanvas;
    FCanvasChanged: Boolean;
    FDefEditProc: Pointer;
    FDragged: Boolean;
    FDragImage: {$ifdef fcDelphi4Up}TDragImageList{$else}TCustomImageList{$endif};
    FDragNode: TfcTreeNode;
    FEditHandle: HWND;
    FEditInstance: Pointer;
    FImageChangeLink: TChangeLink;
    FImages: TCustomImageList;
    FLastDropTarget: TfcTreeNode;
    FManualNotify: Boolean;
    FMemStream: TMemoryStream;
    FRClickNode: TfcTreeNode;
    FRightClickSelects: Boolean;
    FReadOnly: Boolean;
    FSaveIndex: Integer;
    FSaveIndent: Integer;
    FSaveItems: TStringList;
    FSaveTopIndex: Integer;
    FSortType: TfcSortType;
    FStateChanging: Boolean;
    FStateImages: TCustomImageList;
    FStateChangeLink: TChangeLink;
//    FToolTips: Boolean;
    FTreeNodes: TfcTreeNodes;
    FWideText: WideString;
    FOnEditing: TfcTVEditingEvent;
    FOnEdited: TfcTVEditedEvent;
    FOnExpanded: TfcTVExpandedEvent;
    FOnExpanding: TfcTVExpandingEvent;
    FOnCollapsed: TfcTVExpandedEvent;
    FOnCollapsing: TfcTVCollapsingEvent;
    FOnChanging: TfcTVChangingEvent;
    FOnChange: TfcTVChangedEvent;
    FOnCompare: TfcTVCompareEvent;
    FOnDeletion: TfcTVExpandedEvent;
    FOnGetImageIndex: TfcTVExpandedEvent;
    FOnGetSelectedIndex: TfcTVExpandedEvent;
    FLineColor: TColor;
    FInactiveFocusColor: TColor;
    FOnMouseDown, FOnMouseUp, FOnDblClick: TfcTreeMouseEvent;
    FOnMouseMove: TfcTreeMouseMoveEvent;
    FOnToggleCheckbox: TfcToggleCheckboxEvent;

    FNodeClass: TfcTreeNodeClass;
    FMultiSelectAttributes: TfcTVMultiSelectAttributes;
    FOnCalcNodeAttributes: TfcCalcNodeAttributesEvent;
    FBorderWidth: Integer;
    FOnDrawText: TfcTVDrawTextEvent;
    FFixBugImageList: TImageList;
    FOptions: TfcTreeViewOptions;
    FPaintBitmap: TBitmap;
    FIndent: Integer;
    LastSelectedNode: TfcTreeNode;
    MouseNode: TfcTreeNode;
    Down: boolean;
    EditNode, BeforeMouseDownNode: TfcTreeNode;
    FStreamVersion: integer;
//    FEditControl: TWinControl;

    procedure CanvasChanged(Sender: TObject);
    procedure CMColorChanged(var Message: TMessage); message CM_COLORCHANGED;
    procedure CMCtl3DChanged(var Message: TMessage); message CM_CTL3DCHANGED;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMDrag(var Message: TCMDrag); message CM_DRAG;
    procedure CNNotify(var Message: TWMNotify); message CN_NOTIFY;
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
    procedure EditWndProc(var Message: TMessage);
    procedure DoDragOver(Source: TDragObject; X, Y: Integer; CanDrop: Boolean);
    function GetChangeDelay: Integer;
    function GetDropTarget: TfcTreeNode;
    function GetIndent: Integer;
    function GetNodeFromItem(const Item: TTVItem): TfcTreeNode;
    function GetSelection: TfcTreeNode;
    function GetTopItem: TfcTreeNode;
    procedure ImageListChange(Sender: TObject);
    procedure SetAutoExpand(Value: Boolean);
    procedure SetBorderStyle(Value: TBorderStyle);
    procedure SetChangeDelay(Value: Integer);
    procedure SetDropTarget(Value: TfcTreeNode);
    procedure SetImageList(Value: HImageList; Flags: Integer);
    procedure SetIndent(Value: Integer);
    procedure SetImages(Value: TCustomImageList);
    procedure SetReadOnly(Value: Boolean);
    procedure SetSelection(Value: TfcTreeNode);
    procedure SetSortType(Value: TfcSortType);
    procedure SetStateImages(Value: TCustomImageList);
//    procedure SetToolTips(Value: Boolean);
    procedure SeTfcTreeNodes(Value: TfcTreeNodes);
    procedure SetTopItem(Value: TfcTreeNode);
    procedure OnChangeTimer(Sender: TObject);
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMRButtonDown(var Message: TWMRButtonDown); message WM_RBUTTONDOWN;
    procedure WMRButtonUp(var Message: TWMRButtonUp); message WM_RBUTTONUP;
    procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
    procedure WMNotify(var Message: TWMNotify); message WM_NOTIFY;
    procedure CMSysColorChange(var Message: TMessage); message CM_SYSCOLORCHANGE;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMEraseBkgnd(var Message: TWmEraseBkgnd); message WM_ERASEBkgnd;
    procedure CMExit(var Message: TMessage); message CM_EXIT;
    procedure CMDesignHitTest(var Message: TCMDesignHitTest); message CM_DESIGNHITTEST;

    procedure WMDestroy(var Message: TWMDestroy); message WM_DESTROY;
    function ValidMultiSelectLevel(ALevel: Integer): Boolean;
    Function CheckboxNeeded(Node: TfcTreeNode): boolean;
    Function GetCenterPoint(ARect: TRect): TPoint;
    procedure SetOptions(Value: TfcTreeViewOptions);
    procedure SetLineColor(Value: TColor);
    procedure SetInactiveFocusColor(Value: TColor);
    function GetItemHeight: ShortInt;
    procedure SetItemHeight(Value: ShortInt);
    function GetScrollTime: Integer;
    procedure SetScrollTime(Value: Integer);
    function GetMultiSelectListCount: integer;
    function GetMultiSelectItem(Index: integer): TfcTreeNode;
    procedure HintTimerEvent(Sender: TObject);
  protected
    FMultiSelectList: TList;
    SkipErase: boolean;
    SkipChangeMessages: boolean;  { Notify method skips processing of change notifications }
    InLoading: boolean; { During expansion of Reference tree,
                          do not recursively expand item's children.
                          Calling MoveTo expands parent so we prevent this}

    FChangeTimer: TTimer;
    DisplayedItems: integer;
    FMouseInControl : boolean;

    { Implement hint handling }
    HintWindow: THintWindow;
    HintTimer: TTimer;
    HintTimerCount: integer;
    LastHintNode: TfcTreeNode;

    function CanEdit(Node: TfcTreeNode): Boolean; dynamic;
    function CanChange(Node: TfcTreeNode): Boolean; dynamic;
    function CanCollapse(Node: TfcTreeNode): Boolean; dynamic;
    function CanExpand(Node: TfcTreeNode): Boolean; dynamic;
    procedure Change(Node: TfcTreeNode); dynamic;
    procedure Collapse(Node: TfcTreeNode); dynamic;
    function CreateNode: TfcTreeNode; virtual;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure Delete(Node: TfcTreeNode); dynamic;
    procedure DestroyWnd; override;
    procedure DoEndDrag(Target: TObject; X, Y: Integer); override;
    procedure DoStartDrag(var DragObject: TDragObject); override;
    procedure Edit(const Item: TTVItem); dynamic;
    procedure Expand(Node: TfcTreeNode); dynamic;
    function GetDragImages: {$ifdef fcDelphi4Up}TDragImageList{$else}TCustomImageList{$endif}; override;
    procedure GetImageIndex(Node: TfcTreeNode); virtual;
    procedure GetSelectedIndex(Node: TfcTreeNode); virtual;
    procedure Loaded; override;
    procedure KeyPress(var Key: Char); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure SetDragMode(Value: TDragMode); override;
    procedure WndProc(var Message: TMessage); override;
    property AutoExpand: Boolean read FAutoExpand write SetAutoExpand default False;
    property BorderStyle: TBorderStyle read FBorderStyle write SetBorderStyle default bsSingle;
    property ChangeDelay: Integer read GetChangeDelay write SetChangeDelay default 0;
    property Images: TCustomImageList read FImages write SetImages;
    property Indent: Integer read GetIndent write SetIndent;
    property ReadOnly: Boolean read FReadOnly write SetReadOnly default False;
    property RightClickSelects: Boolean read FRightClickSelects write FRightClickSelects default False;
    property SortType: TfcSortType read FSortType write SetSortType default fcstNone;
    property StateImages: TCustomImageList read FStateImages write SetStateImages;
//    property ToolTips: Boolean read FToolTips write SetToolTips default False;
    property OnEditing: TfcTVEditingEvent read FOnEditing write FOnEditing;
    property OnEdited: TfcTVEditedEvent read FOnEdited write FOnEdited;
    property OnExpanding: TfcTVExpandingEvent read FOnExpanding write FOnExpanding;
    property OnExpanded: TfcTVExpandedEvent read FOnExpanded write FOnExpanded;
    property OnCollapsing: TfcTVCollapsingEvent read FOnCollapsing write FOnCollapsing;
    property OnCollapsed: TfcTVExpandedEvent read FOnCollapsed write FOnCollapsed;
    property OnChanging: TfcTVChangingEvent read FOnChanging write FOnChanging;
    property OnChange: TfcTVChangedEvent read FOnChange write FOnChange;
    property OnCompare: TfcTVCompareEvent read FOnCompare write FOnCompare;
    property OnDeletion: TfcTVExpandedEvent read FOnDeletion write FOnDeletion;
    property OnGetImageIndex: TfcTVExpandedEvent read FOnGetImageIndex write FOnGetImageIndex;
    property OnGetSelectedIndex: TfcTVExpandedEvent read FOnGetSelectedIndex write FOnGetSelectedIndex;

    procedure MultiSelectNode(Node: TfcTreeNode; Select: boolean; redraw: boolean); virtual;
    function IsVisible(Node: TfcTreeNode; PartialOK: Boolean): Boolean; virtual;
    function ItemRect(Node: TfcTreeNode; LabelOnly: Boolean): TRect;
    procedure PaintButton(Node: TfcTreeNode; pt: TPoint; size: integer);
    procedure PaintLines(Node: TfcTreeNode);
    procedure PaintImage(Node: TfcTreeNode; State: TfcItemStates);
    function LevelRect(ANode: TfcTreeNode): TRect;
    procedure DoDrawText(TreeView: TfcCustomTreeView;
         Node: TfcTreeNode; ARect: TRect; AItemState: TfcItemStates;
         var DefaultDrawing: boolean); virtual;
    procedure Compare(Node1, Node2: TfcTreeNode; lParam: integer; var Result: integer); virtual;
    procedure CalcNodeAttributes(Node: TfcTreeNode; AItemState: TfcItemStates); virtual;
    function GetDisplayText(Node: TfcTreeNode): string; virtual;
    procedure LoadCanvasDefaults(Node: TfcTreeNode; AItemState: TfcItemStates);
    function ProcessKeyPress(Key: char; shift: TShiftState): boolean; virtual;
    function IsRowSelect: boolean; virtual;
    procedure MouseLoop(X, Y: Integer); virtual;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
                 X, Y: Integer); override;
    function UseImages(Node: TfcTreeNode): Boolean;
    function UseStateImages(Node: TfcTreeNode): Boolean;
    procedure BeginPainting; virtual;
    procedure EndPainting; virtual;
    procedure BeginItemPainting(Node: TfcTreeNode; ARect: TRect; AItemState: TfcItemStates); virtual;
    procedure EndItemPainting(Node: TfcTreeNode; ARect: TRect; AItemState: TfcItemStates); virtual;
    procedure PaintItem(Node: TfcTreeNode); virtual;
    procedure ClearStateImageIndexes;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure DoToggleCheckbox(Node: TfcTreeNode); virtual;
    procedure FreeHintWindow; virtual;
    Function CreateHintWindow(Node: TfcTreeNode): THintWindow; virtual;
    Procedure UnselectAllNodes(IgnoreNode: TfcTreeNode);
    procedure InvalidateNoErase;

    property ItemHeight: ShortInt read GetItemHeight write SetItemHeight;
    property OnCalcNodeAttributes: TfcCalcNodeAttributesEvent read FOnCalcNodeAttributes write FOnCalcNodeAttributes;
    property ScrollTime: Integer read GetScrollTime write SetScrollTime;
    property NodeClass: TfcTreeNodeClass read FNodeClass write FNodeClass;
  public
    Patch: Variant;

    procedure ResetStateImages;
    property StreamVersion: integer read FStreamVersion;
    Function GetFirstSibling(Node: TfcTreeNode): TfcTreeNode;
    Procedure InvalidateNode(Node: TfcTreeNode);
    Function MultiSelectCheckboxNeeded(Node: TfcTreeNode): boolean;
    Procedure UnselectAll;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function AlphaSort: Boolean;
    function CustomSort(SortProc: TTVCompare; Data: Longint): Boolean;
    procedure FullCollapse;
    procedure FullExpand;
    function GetHitTestInfoAt(X, Y: Integer): TfcHitTests;
    function GetNodeAt(X, Y: Integer): TfcTreeNode;
    function IsEditing: Boolean;
    procedure LoadFromFile(const FileName: string);
    procedure LoadFromStream(Stream: TStream);
    procedure SaveToFile(const FileName: string);
    procedure SaveToStream(Stream: TStream);
    property Canvas: TfcCanvas read FPaintCanvas;
    property DropTarget: TfcTreeNode read GetDropTarget write SetDropTarget;
    property Selected: TfcTreeNode read GetSelection write SetSelection;
    property TopItem: TfcTreeNode read GetTopItem write SetTopItem;

    property RightClickNode: TfcTreeNode read FRClickNode;
    property Options: TfcTreeViewOptions read FOptions write SetOptions default
        [tvoExpandOnDblClk, tvoShowButtons, tvoShowRoot, tvoShowLines, tvoHideSelection, tvoToolTips];
    property Items: TfcTreeNodes read FTreeNodes write SeTfcTreeNodes;
    property MultiSelectAttributes: TfcTVMultiSelectAttributes
        read FMultiSelectAttributes write FMultiSelectAttributes;
    property OnDrawText: TfcTVDrawTextEvent read FOnDrawText write FOnDrawText;
    property OnItemChange: TfcItemChangeEvent read FOnItemChange write FOnItemChange;

    property MultiSelectList[Index: Integer]: TfcTreeNode read GetMultiSelectItem;
    property MultiSelectListCount : integer read GetMultiSelectListCount;
    property LineColor: TColor read FLineColor write SetLineColor default clBtnShadow;
    property InactiveFocusColor: TColor read FInactiveFocusColor write SetInactiveFocusColor default clBtnFace;
    property OnMouseMove: TfcTreeMouseMoveEvent read FOnMouseMove write FOnMouseMove;
    property OnMouseDown: TfcTreeMouseEvent read FOnMouseDown write FOnMouseDown;
    property OnMouseUp: TfcTreeMouseEvent read FOnMouseUp write FOnMouseUp;
    property OnDblClick: TfcTreeMouseEvent read FOnDblClick write FOnDblClick;
    property OnToggleCheckbox: TfcToggleCheckboxEvent read FOnToggleCheckbox write FOnToggleCheckbox;

  end;

  TfcTreeView = class(TfcCustomTreeView)
  published
    property Align;
    {$ifdef fcDelphi4Up}
    property Anchors;
    {$endif}
    property AutoExpand;
    {$ifdef fcDelphi4Up}
    property BiDiMode;
    {$endif}
    property BorderStyle;
//    property BorderWidth;
    property ChangeDelay;
    property Color;
    property LineColor;
    property InactiveFocusColor;
    property Ctl3D;
    {$ifdef fcDelphi4Up}
    property Constraints;
    property DragKind;
    {$endIf}
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property Images;
    property Indent;
    property MultiSelectAttributes;
    property Options;
    property Items;
    {$ifdef fcDelphi4Up}
    property ParentBiDiMode;
    {$endif}
    property ParentColor default False;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property RightClickSelects;
    {$ifdef fcDelphi4Up}
    property ShowHint;
    {$endif}
    property SortType;
    property StateImages;
    property TabOrder;
    property TabStop default True;
//    property ToolTips;
    property Visible;
    property OnChange;
    property OnChanging;
    property OnClick;
    property OnCollapsing;
    property OnCollapsed;
    property OnCompare;
    property OnDblClick;
    property OnDeletion;
    property OnDragDrop;
    property OnDragOver;
    property OnEdited;
    property OnEditing;
    {$ifdef fcDelphi4Up}
    property OnEndDock;
    {$endif}
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnExpanding;
    property OnExpanded;
    property OnGetImageIndex;
    property OnGetSelectedIndex;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnToggleCheckbox;
    {$ifdef fcDelphi4Up}
    property OnStartDock;
    {$endif}
    property OnStartDrag;

    property OnCalcNodeAttributes;
    property OnDrawText;

  end;

  procedure fcTreeViewError(const Msg: string);

implementation
{ TfcTreeNode }

{$IfDef fcDelphi6Up}
uses
  Variants,
  RTLConsts
  ;
{$EndIf fcDelphi6Up}

const MaxCheckboxSize = 6;
      FixBugImageListSize = 16;

procedure SetComCtlStyle(Ctl: TWinControl; Value: Integer; UseStyle: Boolean);
var
  Style: Integer;
begin
  if Ctl.HandleAllocated then
  begin
    Style := GetWindowLong(Ctl.Handle, GWL_STYLE);
    if not UseStyle then Style := Style and not Value
    else Style := Style or Value;
    SetWindowLong(Ctl.Handle, GWL_STYLE, Style);
  end;
end;

function DefaultTreeViewSort(Node1, Node2: TfcTreeNode; lParam: Integer): Integer; stdcall;
begin
//    Result := lstrcmp(PChar(Node1.Text), PChar(Node2.Text));
   Node1.TreeView.Compare(Node1, Node2, lParam, Result);
end;

{
function DefaultTreeViewSort(Node1, Node2: TfcTreeNode; lParam: Integer): Integer; stdcall;
begin
  with Node1 do
    if Assigned(TreeView.OnCompare) then
      TreeView.OnCompare(TreeView, Node1, Node2, lParam, Result)
    else Result := lstrcmp(PChar(Node1.Text), PChar(Node2.Text));
end;
}

procedure TreeViewError(const Msg: string);
begin
  raise ETreeViewError.Create(Msg);
end;

{procedure TreeViewErrorFmt(const Msg: string; Format: array of const);
begin
  raise ETreeViewError.CreateFmt(Msg, Format);
end;
}
constructor TfcTreeNode.Create(AOwner: TfcTreeNodes);
begin
  inherited Create;
  FOverlayIndex := -1;
  FStateIndex := -1;
  FOwner := AOwner;
end;

destructor TfcTreeNode.Destroy;
var
  Node: TfcTreeNode;
  CheckValue: Integer;
  i: integer;
  MultiSelectList: TList;
begin
   Owner.ClearCache;
   FDeleting := True;

   if FMultiSelected then begin
      if TfcCustomTreeView(TreeView).LastSelectedNode= self then
         TfcCustomTreeView(TreeView).LastSelectedNode:= nil;

      MultiSelectList:= (TreeView as TfcCustomTreeView).FMultiSelectList;
      for i:= 0 to MultiSelectList.count-1 do begin  { Bad code }
         if self=TfcTreeNode(MultiSelectList[i]) then
         begin
            MultiSelectList.delete(i);
            break;
         end
      end
   end;

   if Owner.Owner.FLastDropTarget = Self then
      Owner.Owner.FLastDropTarget := nil;
   Node := Parent;
   if (Node <> nil) and (not Node.Deleting) then
   begin
      if Node.IndexOf(Self) <> -1 then CheckValue := 1
      else CheckValue := 0;
      if Node.CompareCount(CheckValue) then
      begin
         Expanded := False;
         Node.HasChildren := False;
      end;
   end;
   if ItemId <> nil then TreeView_DeleteItem(Handle, ItemId);
   Data := nil;
   inherited Destroy;
end;

function TfcTreeNode.GetHandle: HWND;
begin
  Result := TreeView.Handle;
end;

function TfcTreeNode.GetTreeView: TfcCustomTreeView;
begin
  Result := Owner.Owner;
end;

function TfcTreeNode.HasAsParent(Value: TfcTreeNode): Boolean;
begin
  if Value <> Nil then
  begin
    if Parent = nil then Result := False
    else if Parent = Value then Result := True
    else Result := Parent.HasAsParent(Value);
  end
  else Result := True;
end;

procedure TfcTreeNode.SetText(const S: string);
var
  Item: TTVItem;
  AVariant: Variant;
begin
  if s = '' then AVariant := NULL else AVariant := s;
  if Assigned(TreeView.OnItemChange) then TreeView.OnItemChange(TreeView, self, icaText, AVariant);
  FText := S;
  with Item do
  begin
    mask := TVIF_TEXT;
    hItem := ItemId;
    pszText := LPSTR_TEXTCALLBACK;
  end;
  TreeView_SetItem(Handle, Item);
  if (TreeView.SortType in [fcstText, fcstBoth]) and FInTree then
  begin
    if (Parent <> nil) then Parent.AlphaSort
    else TreeView.AlphaSort;
  end;
end;

procedure TfcTreeNode.SetData(Value: Pointer);
begin
  FData := Value;
  if (TreeView.SortType in [fcstData, fcstBoth]) and Assigned(TreeView.OnCompare)
    and (not Deleting) and FInTree then
  begin
    if Parent <> nil then Parent.AlphaSort
    else TreeView.AlphaSort;
  end;
end;

function TfcTreeNode.GetState(NodeState: TfcNodeState): Boolean;
var
  Item: TTVItem;
begin
  Result := False;
  with Item do
  begin
    mask := TVIF_STATE;
    hItem := ItemId;
    if TreeView_GetItem(Handle, Item) then
      case NodeState of
        fcnsCut: Result := (state and TVIS_CUT) <> 0;
        fcnsFocused: Result := (state and TVIS_FOCUSED) <> 0;
        fcnsSelected: Result := (state and TVIS_SELECTED) <> 0;
        fcnsExpanded: Result := (state and TVIS_EXPANDED) <> 0;
        fcnsDropHilited: Result := (state and TVIS_DROPHILITED) <> 0;
      end;
  end;
end;

procedure TfcTreeNode.SetImageIndex(Value: Integer);
var
  Item: TTVItem;
begin
  if Assigned(TreeView.OnItemChange) then TreeView.OnItemChange(TreeView, self, icaImageIndex, Value);
  FImageIndex := Value;
  with Item do
  begin
    mask := TVIF_IMAGE or TVIF_HANDLE;
    hItem := ItemId;
    iImage := I_IMAGECALLBACK;
  end;
  TreeView_SetItem(Handle, Item);
end;

procedure TfcTreeNode.SetSelectedIndex(Value: Integer);
var
  Item: TTVItem;
begin
  FSelectedIndex := Value;
  with Item do
  begin
    mask := TVIF_SELECTEDIMAGE or TVIF_HANDLE;
    hItem := ItemId;
    iSelectedImage := I_IMAGECALLBACK;
  end;
  TreeView_SetItem(Handle, Item);
end;

procedure TfcTreeNode.SetOverlayIndex(Value: Integer);
var
  Item: TTVItem;
begin
  FOverlayIndex := Value;
  with Item do
  begin
    mask := TVIF_STATE or TVIF_HANDLE;
    stateMask := TVIS_OVERLAYMASK;
    hItem := ItemId;
    state := IndexToOverlayMask(OverlayIndex + 1);
  end;
  TreeView_SetItem(Handle, Item);
end;

procedure TfcTreeNode.SetStateIndex(Value: Integer);
var
  Item: TTVItem;
begin
  if Value=0 then Value:= -1;  // 11/21/98 - (RSW) Don't allow 0 as state index
  if (CheckboxType = tvctCheckbox) and (Value<>-1) and (Value<>1) then exit; { 3/8/99}

  FStateIndex := Value;
  if Value >= 0 then Dec(Value);
  with Item do
  begin
    mask := TVIF_STATE or TVIF_HANDLE;
    stateMask := TVIS_STATEIMAGEMASK;
    hItem := ItemId;
    state := IndexToStateImageMask(Value + 1);
  end;
  TreeView_SetItem(Handle, Item);
end;

function TfcTreeNode.CompareCount(CompareMe: Integer): Boolean;
var
  Count: integer;
  Node: TfcTreeNode;
Begin
  Count := 0;
  Result := False;
  Node := GetFirstChild;
  while Node <> nil do
  begin
    Inc(Count);
    Node := Node.GetNextChild(Node);
    if Count > CompareMe then Exit;
  end;
  if Count = CompareMe then Result := True;
end;

function TfcTreeNode.DoCanExpand(Expand: Boolean): Boolean;
begin
  Result := False;
  if HasChildren then
  begin
    if Expand then Result := TreeView.CanExpand(Self)
    else Result := TreeView.CanCollapse(Self);
  end;
end;

procedure TfcTreeNode.DoExpand(Expand: Boolean);
begin
  if HasChildren then
  begin
    if Expand then TreeView.Expand(Self)
    else TreeView.Collapse(Self);
  end;
end;

procedure TfcTreeNode.ExpandItem(Expand: Boolean; Recurse: Boolean);
var
  Flag: Integer;
  Node: TfcTreeNode;
begin
  if Recurse then
  begin
    Node := Self;
    repeat
      Node.ExpandItem(Expand, False);
      Node := Node.GetNext;
    until (Node = nil) or (not Node.HasAsParent(Self));
  end
  else begin
    TreeView.FManualNotify := True;
    try
      Flag := 0;
      if Expand then
      begin
        if DoCanExpand(True) then
        begin
          Flag := TVE_EXPAND;
          DoExpand(True);
        end;
      end
      else begin
        if DoCanExpand(False) then
        begin
          Flag := TVE_COLLAPSE;
          DoExpand(False);
        end;
      end;
      if Flag <> 0 then TreeView_Expand(Handle, ItemId, Flag);
    finally
      TreeView.FManualNotify := False;
    end;
  end;
end;

procedure TfcTreeNode.Expand(Recurse: Boolean);
begin
  ExpandItem(True, Recurse);
end;

procedure TfcTreeNode.Collapse(Recurse: Boolean);
begin
  ExpandItem(False, Recurse);
end;

function TfcTreeNode.GetExpanded: Boolean;
begin
  Result := GetState(fcnsExpanded);
end;

procedure TfcTreeNode.SetExpanded(Value: Boolean);
begin
  if Value then Expand(False)
  else Collapse(False);
end;

function TfcTreeNode.GetSelected: Boolean;
begin
  Result := GetState(fcnsSelected);
end;

procedure TfcTreeNode.SetSelected(Value: Boolean);
begin
  if Value then TreeView_SelectItem(Handle, ItemId)
  else if Selected then TreeView_SelectItem(Handle, nil);
end;

function TfcTreeNode.GetCut: Boolean;
begin
  Result := GetState(fcnsCut);
end;

procedure TfcTreeNode.SetCut(Value: Boolean);
var
  Item: TTVItem;
  Template: DWORD;
begin
  if Value then Template := DWORD(-1)
  else Template := 0;
  with Item do
  begin
    mask := TVIF_STATE;
    hItem := ItemId;
    stateMask := TVIS_CUT;
    state := stateMask and Template;
  end;
  TreeView_SetItem(Handle, Item);
end;

function TfcTreeNode.GetDropTarget: Boolean;
begin
  Result := GetState(fcnsDropHilited);
end;

procedure TfcTreeNode.SetDropTarget(Value: Boolean);
begin
  if Value then TreeView_SelectDropTarget(Handle, ItemId)
  else if DropTarget then TreeView_SelectDropTarget(Handle, nil);
end;

function TfcTreeNode.GetChildren: Boolean;
var
  Item: TTVItem;
begin
  Item.mask := TVIF_CHILDREN;
  Item.hItem := ItemId;
  if TreeView_GetItem(Handle, Item) then Result := Item.cChildren > 0
  else Result := False;
end;

procedure TfcTreeNode.SetFocused(Value: Boolean);
var
  Item: TTVItem;
  Template: DWORD;
begin
  if Value then Template := DWORD(-1)
  else Template := 0;
  with Item do
  begin
    mask := TVIF_STATE;
    hItem := ItemId;
    stateMask := TVIS_FOCUSED;
    state := stateMask and Template;
  end;
  TreeView_SetItem(Handle, Item);
end;

function TfcTreeNode.GetFocused: Boolean;
begin
  Result := GetState(fcnsFocused);
end;

procedure TfcTreeNode.SetChildren(Value: Boolean);
var
  Item: TTVItem;
begin
  with Item do
  begin
    mask := TVIF_CHILDREN;
    hItem := ItemId;
    cChildren := Ord(Value);
  end;
  TreeView_SetItem(Handle, Item);
end;

function TfcTreeNode.GetParent: TfcTreeNode;
begin
  with FOwner do
    Result := GetNode(TreeView_GetParent(Handle, ItemId));
end;

function TfcTreeNode.GetNextSibling: TfcTreeNode;
begin
  with FOwner do
    Result := GetNode(TreeView_GetNextSibling(Handle, ItemId));
end;

function TfcTreeNode.GetPrevSibling: TfcTreeNode;
begin
  with FOwner do
    Result := GetNode(TreeView_GetPrevSibling(Handle, ItemId));
end;

function TfcTreeNode.GetNextVisible: TfcTreeNode;
begin
  if IsVisible then
    with FOwner do
      Result := GetNode(TreeView_GetNextVisible(Handle, ItemId))
  else Result := nil;
end;

function TfcTreeNode.GetPrevVisible: TfcTreeNode;
begin
  with FOwner do
    Result := GetNode(TreeView_GetPrevVisible(Handle, ItemId));
end;

function TfcTreeNode.GetNextChild(Value: TfcTreeNode): TfcTreeNode;
begin
  if Value <> nil then Result := Value.GetNextSibling
  else Result := nil;
end;

function TfcTreeNode.GetPrevChild(Value: TfcTreeNode): TfcTreeNode;
begin
  if Value <> nil then Result := Value.GetPrevSibling
  else Result := nil;
end;

function TfcTreeNode.GetFirstChild: TfcTreeNode;
begin
  with FOwner do
    Result := GetNode(TreeView_GetChild(Handle, ItemId));
end;

function TfcTreeNode.GetLastChild: TfcTreeNode;
var
  Node: TfcTreeNode;
begin
  Result := GetFirstChild;
  if Result <> nil then
  begin
    Node := Result;
    repeat
      Result := Node;
      Node := Result.GetNextSibling;
    until Node = nil;
  end;
end;

function TfcTreeNode.GetNext: TfcTreeNode;
var
  NodeID, ParentID: HTreeItem;
  Handle: HWND;
begin
  Handle := FOwner.Handle;
  NodeID := TreeView_GetChild(Handle, ItemId);
  if NodeID = nil then NodeID := TreeView_GetNextSibling(Handle, ItemId);
  ParentID := ItemId;
  while (NodeID = nil) and (ParentID <> nil) do
  begin
    ParentID := TreeView_GetParent(Handle, ParentID);
    NodeID := TreeView_GetNextSibling(Handle, ParentID);
  end;
  Result := FOwner.GetNode(NodeID);
end;

function TfcTreeNode.GetPrev: TfcTreeNode;
var
  Node: TfcTreeNode;
begin
  Result := GetPrevSibling;
  if Result <> nil then
  begin
    Node := Result;
    repeat
      Result := Node;
      Node := Result.GetLastChild;
    until Node = nil;
  end else
    Result := Parent;
end;

function TfcTreeNode.GetAbsoluteIndex: Integer;
var
  Node: TfcTreeNode;
begin
  if Owner.FNodeCache.CacheNode = Self then
    Result := Owner.FNodeCache.CacheIndex
  else begin
    Result := -1;
    Node := Self;
    while Node <> nil do
    begin
      Inc(Result);
      Node := Node.GetPrev;
    end;
  end;
end;

function TfcTreeNode.GetIndex: Integer;
var
  Node: TfcTreeNode;
begin
  Result := -1;
  Node := Self;
  while Node <> nil do
  begin
    Inc(Result);
    Node := Node.GetPrevSibling;
  end;
end;

function TfcTreeNode.GetItem(Index: Integer): TfcTreeNode;
begin
  Result := GetFirstChild;
  while (Result <> nil) and (Index > 0) do
  begin
    Result := GetNextChild(Result);
    Dec(Index);
  end;
  if Result = nil then TreeViewError(SListIndexError);
end;

procedure TfcTreeNode.SetItem(Index: Integer; Value: TfcTreeNode);
begin
  item[Index].Assign(Value);
end;

function TfcTreeNode.IndexOf(Value: TfcTreeNode): Integer;
var
  Node: TfcTreeNode;
begin
  Result := -1;
  Node := GetFirstChild;
  while (Node <> nil) do
  begin
    Inc(Result);
    if Node = Value then Break;
    Node := GetNextChild(Node);
  end;
  if Node = nil then Result := -1;
end;

function TfcTreeNode.GetCount: Integer;
var
  Node: TfcTreeNode;
begin
  Result := 0;
  Node := GetFirstChild;
  while Node <> nil do
  begin
    Inc(Result);
    Node := Node.GetNextChild(Node);
  end;
end;

procedure TfcTreeNode.EndEdit(Cancel: Boolean);
begin
  TreeView_EndEditLabelNow(Handle, Cancel);
end;

procedure TfcTreeNode.InternalMove(ParentNode, Node: TfcTreeNode;
  HItem: HTreeItem; AddMode: TfcAddMode);
var
  I: Integer;
  NodeId: HTreeItem;
  TreeViewItem: TTVItem;
  Children: Boolean;
  IsSelected: Boolean;
begin
  { if ParentNode = Node then Exit; }
  Owner.ClearCache;
  if (AddMode = fctaInsert) and (Node <> nil) then
    NodeId := Node.ItemId else
    NodeId := nil;
  Children := HasChildren;
  IsSelected := Selected;
  if (Parent <> nil) and (Parent.CompareCount(1)) then
  begin
    Parent.Expanded := False;
    Parent.HasChildren := False;
  end;
  with TreeViewItem do
  begin
    mask := TVIF_PARAM;
    hItem := ItemId;
    lParam := 0;
  end;
  TreeView_SetItem(Handle, TreeViewItem);
  with Owner do
    HItem := AddItem(HItem, NodeId, CreateItem(Self), AddMode);
  if HItem = nil then
    raise EOutOfResources.Create(sInsertError);
  for I := Count - 1 downto 0 do
    Item[I].InternalMove(Self, nil, HItem, fctaAddFirst);
  TreeView_DeleteItem(Handle, ItemId);
  FItemId := HItem;
  Assign(Self);
  HasChildren := Children;
  Selected := IsSelected;
end;

procedure TfcTreeNode.MoveTo(Destination: TfcTreeNode; Mode: TfcNodeAttachMode);
var
  AddMode: TfcAddMode;
  Node: TfcTreeNode;
  HItem: HTreeItem;
  OldOnChanging: TfcTVChangingEvent;
  OldOnChange: TfcTVChangedEvent;
begin
  OldOnChanging := TreeView.OnChanging;
  OldOnChange := TreeView.OnChange;
  TreeView.OnChanging := nil;
  TreeView.OnChange := nil;
  try
    if (Destination = nil) or not Destination.HasAsParent(Self) then
    begin
      AddMode := fctaAdd;
      if (Destination <> nil) and not (Mode in [fcnaAddChild, fcnaAddChildFirst]) then
        Node := Destination.Parent else
        Node := Destination;
      case Mode of
        fcnaAdd,
        fcnaAddChild: AddMode := fctaAdd;
        fcnaAddFirst,
        fcnaAddChildFirst: AddMode := fctaAddFirst;
        fcnaInsert:
          begin
            Destination := Destination.GetPrevSibling;
            if Destination = Self then exit;
            if Destination = nil then AddMode := fctaAddFirst
            else AddMode := fctaInsert;
          end;
        fcnaInsertAfter:
          begin
            if Destination.GetNextSibling = nil then AddMode := fctaAdd
            else AddMode := fctaInsert;
          end;
      end;
      if Node <> nil then
        HItem := Node.ItemId else
        HItem := nil;
      InternalMove(Node, Destination, HItem, AddMode);
      Node := Parent;
      if Node <> nil then
      begin
        Node.HasChildren := True;
        Node.Expanded := True;
      end;
    end;
  finally
    TreeView.OnChanging := OldOnChanging;
    TreeView.OnChange := OldOnChange;
    Invalidate;
  end;
end;

procedure TfcTreeNode.MakeVisible;
begin
  TreeView_EnsureVisible(Handle, ItemId);
end;

function TfcTreeNode.GetLevel: Integer;
var
  Node: TfcTreeNode;
begin
  Result := 0;
  Node := Parent;
  while Node <> nil do
  begin
    Inc(Result);
    Node := Node.Parent;
  end;
end;

function TfcTreeNode.IsNodeVisible: Boolean;
var
  Rect: TRect;
begin
  Result := TreeView_GetItemRect(Handle, ItemId, Rect, True);
end;

function TfcTreeNode.EditText: Boolean;
begin
  Result := TreeView_EditLabel(Handle, ItemId) <> 0;
end;

{function TfcTreeNode.ShowBlankImage: boolean;
begin
  result:= not ((TreeView.Images<>nil) and (ImageIndex=-2));
end;
}
function TfcTreeNode.DisplayRect(TextOnly: Boolean): TRect;
begin
  FillChar(Result, SizeOf(Result), 0);
  TreeView_GetItemRect(Handle, ItemId, Result, TextOnly);

  { Special case of imageindex=-2, do not show blank image }
  if TextOnly and (TreeView.Images<>nil) and not TreeView.UseImages(self) then
      result.Left:= result.Left - TImageList(TreeView.Images).Width-1
end;

function TfcTreeNode.AlphaSort: Boolean;
begin
  Result := CustomSort(nil, 0);
end;

function TfcTreeNode.CustomSort(SortProc: TTVCompare; Data: Longint): Boolean;
var
  SortCB: TTVSortCB;
begin
  Owner.ClearCache;
  with SortCB do
  begin
    if not Assigned(SortProc) then lpfnCompare := @DefaultTreeViewSort
    else lpfnCompare := SortProc;
    hParent := ItemId;
    lParam := Data;
  end;
  Result := TreeView_SortChildrenCB(Handle, SortCB, 0);
end;

procedure TfcTreeNode.Delete;
begin
  if not Deleting then Free;
end;

procedure TfcTreeNode.DeleteChildren;
begin
  Owner.ClearCache;
  TreeView_Expand(TreeView.Handle, ItemID, TVE_COLLAPSE or TVE_COLLAPSERESET);
  HasChildren := False;
end;

procedure TfcTreeNode.Assign(Source: TPersistent);
var
  Node: TfcTreeNode;
begin
  Owner.ClearCache;
  if Source is TfcTreeNode then
  begin
    Node := TfcTreeNode(Source);
    Text := Node.Text;
    Data := Node.Data;
    CheckboxType:= Node.CheckboxType;  { 4/26/99 - Do before assign State Index }
    StringData:= Node.StringData;
    StringData2:= Node.StringData2;
    ImageIndex := Node.ImageIndex;
    SelectedIndex := Node.SelectedIndex;
    StateIndex := Node.StateIndex;
    OverlayIndex := Node.OverlayIndex;
    Focused := Node.Focused;
    DropTarget := Node.DropTarget;
    Cut := Node.Cut;
    HasChildren := Node.HasChildren;
//    CheckboxType:= Node.CheckboxType;
    Checked:= Node.Checked;
  end
  else inherited Assign(Source);
end;

{function TfcTreeNode.IsEqual(Node: TfcTreeNode): Boolean;
begin
  Result := (Text = Node.Text) and (Data = Node.Data);
end;
}
procedure TfcTreeNode.ReadData(Stream: TStream; Info: PfcNodeInfo);
var
  I, Size, ItemCount: Integer;
  StrBuffer: PChar;
  Temp: Integer;
begin
  Owner.ClearCache;
  Stream.ReadBuffer(Size, SizeOf(Size));

  { 7/6/99 - Save for fcTreeCombo streaming }
  {$ifdef fcDelphi4Up}
  ReadDataSize:= Size;
  {$endif}

  { RSW - Advance if somehow size is greater than node size }
  Stream.ReadBuffer(Info^, fcmin(Size, SizeOf(Info^)));
  Temp := SizeOf(TfcNodeInfo) - (255 - Length(Info^.Text));

  { Support StringData property }
  if Info^.StringDataSize1>0 then
  begin
     StrBuffer:= StrAlloc(Info^.StringDataSize1+1);
     StrBuffer[Info^.StringDataSize1]:= #0;
     Stream.ReadBuffer(StrBuffer^, Info^.StringDataSize1);
     StringData:= StrPas(StrBuffer);
     StrDispose(StrBuffer);
  end
  else StringData:= '';

  { Support StringData property }
  if Info^.StringDataSize2>0 then
  begin
     StrBuffer:= StrAlloc(Info^.StringDataSize2+1);
     StrBuffer[Info^.StringDataSize2]:= #0;
     Stream.ReadBuffer(StrBuffer^, Info^.StringDataSize2);
     StringData2:= StrPas(StrBuffer);
     StrDispose(StrBuffer);
  end
  else StringData2:= '';

  Text := Info^.Text;
  ImageIndex := Info^.ImageIndex;
  SelectedIndex := Info^.SelectedIndex;
  StateIndex := Info^.StateIndex;
  OverlayIndex := Info^.OverlayIndex;
  Data := Info^.Data;
  ItemCount := Info^.Count;
  CheckboxType:= Info^.CheckboxType;
  Checked:= (Info^.Checked and $01)<>0;
  Grayed:= (Info^.Checked and $02)<>0;
  for I := 0 to ItemCount - 1 do
    with Owner.AddChild(Self, '') do ReadData(Stream, Info);

  if TreeView.StreamVersion=1 then
     if Size > Temp then Stream.Position:= Stream.Position + (Size - Temp);
end;

Function TfcTreeNode.GetSizeOfNodeInfo: integer;
begin
  result:= SizeOf(TfcNodeInfo);
end;

procedure TfcTreeNode.WriteData(Stream: TStream; Info: PfcNodeInfo);
var
  Size, L, ItemCount: Integer;
  Node: TfcTreeNode;
begin
  L := Length(Text);
  if L > 255 then L := 255;
  Size := GetSizeOfNodeInfo + L - 255;
//  Size := SizeOf(TfcNodeInfo) + L - 255;
  FillChar(Info^, SizeOf(TfcNodeInfo), 0);
  Info^.Text := Text;
  Info^.ImageIndex := ImageIndex;
  Info^.SelectedIndex := SelectedIndex;
  Info^.OverlayIndex := OverlayIndex;
  Info^.StateIndex := StateIndex;
  Info^.Data := Data;
  ItemCount := Count;
  Info^.Count := ItemCount;
  Info^.CheckboxType:= CheckboxType;
  Info^.Checked:= ord(Checked) + $02 * Ord(Grayed);
  Info^.StringDataSize1:= length(StringData);
  Info^.StringDataSize2:= length(StringData2);
  Stream.WriteBuffer(Size, SizeOf(Size));
  Stream.WriteBuffer(Info^, Size);

  { Support StringData properties }
  if Info^.StringDataSize1>0 then begin
     Stream.WriteBuffer(PChar(StringData)^, length(StringData));
  end;

  if Info^.StringDataSize2>0 then begin
     Stream.WriteBuffer(PChar(StringData2)^, length(StringData2));
  end;

  Node := GetFirstChild;
  while Node <> nil do
  begin
    Node.WriteData(Stream, Info);
    Node := Node.GetNextSibling;
  end;

//  for I := 0 to ItemCount - 1 do Item[I].WriteData(Stream, Info);
end;

{ TfcTreeNodes }

constructor TfcTreeNodes.Create(AOwner: TfcCustomTreeView);
begin
  inherited Create;
  FOwner := AOwner;
end;

destructor TfcTreeNodes.Destroy;
begin
  InDestroy:= True;
  Clear;
//  FOwner := nil;
  inherited Destroy;
end;

function TfcTreeNodes.GetCount: Integer;
begin
  if Owner.HandleAllocated then Result := TreeView_GetCount(Handle)
  else Result := 0;
end;

function TfcTreeNodes.GetHandle: HWND;
begin
  Result := Owner.Handle;
end;

procedure TfcTreeNodes.Delete(Node: TfcTreeNode);
begin
  if (Node.ItemId = nil) then
    Owner.Delete(Node);
  Node.Delete;
end;

procedure TfcTreeNodes.Clear;
var PrevNode, Node: TfcTreeNode;
begin
  ClearCache;
  if { (Owner <> nil) and ksw - prevent problem }Owner.HandleAllocated then
  begin
     if count<=0 then exit;

     Owner.SkipChangeMessages:= True;

     try
        BeginUpdate;

        Owner.Selected:= nil;

        { Clearing by scanning backwards seems to be significantly faster }
        { TreeView_DeleteAllItem's current implementation is slower than this
        { technique. Scanning forwards is also slower. }
        Node := GetFirstNode;
        Owner.TopItem:= Node;

        { Retrieve last node }
        while Node.GetNextSibling <> nil do Node:= Node.GetNextSibling;
        while Node.GetNext <> nil do Node:= Node.GetNext;

        While Node<>Nil do
        begin
            PrevNode:= Node;
            Node := Node.GetPrev;
            TreeView_DeleteItem(PrevNode.Handle, PrevNode.ItemId);
        end;
     finally
        Owner.SkipChangeMessages:= False;
        if not inDestroy then EndUpdate;
     end
  end
end;

{procedure TfcTreeNodes.Clear;
begin
  ClearCache;
  if Owner.HandleAllocated then
    TreeView_DeleteAllItems(Handle);
end;}

function TfcTreeNodes.AddChildFirst(Node: TfcTreeNode; const S: string): TfcTreeNode;
begin
  Result := AddChildObjectFirst(Node, S, nil);
end;

function TfcTreeNodes.AddChildObjectFirst(Node: TfcTreeNode; const S: string;
  Ptr: Pointer): TfcTreeNode;
begin
  Result := InternalAddObject(Node, S, Ptr, fctaAddFirst);
end;

function TfcTreeNodes.AddChild(Node: TfcTreeNode; const S: string): TfcTreeNode;
begin
  Result := AddChildObject(Node, S, nil);
end;

function TfcTreeNodes.AddChildObject(Node: TfcTreeNode; const S: string;
  Ptr: Pointer): TfcTreeNode;
begin
  Result := InternalAddObject(Node, S, Ptr, fctaAdd);
end;

function TfcTreeNodes.AddFirst(Node: TfcTreeNode; const S: string): TfcTreeNode;
begin
  Result := AddObjectFirst(Node, S, nil);
end;

function TfcTreeNodes.AddObjectFirst(Node: TfcTreeNode; const S: string;
  Ptr: Pointer): TfcTreeNode;
begin
  if Node <> nil then Node := Node.Parent;
  Result := InternalAddObject(Node, S, Ptr, fctaAddFirst);
end;

function TfcTreeNodes.Add(Node: TfcTreeNode; const S: string): TfcTreeNode;
begin
  Result := AddObject(Node, S, nil);
end;

procedure TfcTreeNodes.Repaint(Node: TfcTreeNode);
var
  R: TRect;
begin
  if FUpdateCount < 1 then
  begin
    while (Node <> nil) and not Node.IsVisible do Node := Node.Parent;
    if Node <> nil then
    begin
      R := Node.DisplayRect(False);
      InvalidateRect(Owner.Handle, @R, True);
    end;
  end;
end;

function TfcTreeNodes.AddObject(Node: TfcTreeNode; const S: string;
  Ptr: Pointer): TfcTreeNode;
begin
  if Node <> nil then Node := Node.Parent;
  Result := InternalAddObject(Node, S, Ptr, fctaAdd);
end;

function TfcTreeNodes.Insert(Node: TfcTreeNode; const S: string): TfcTreeNode;
begin
  Result := InsertObject(Node, S, nil);
end;

procedure TfcTreeNodes.AddedNode(Value: TfcTreeNode);
begin
  if Value <> nil then
  begin
    Value.HasChildren := True;
    Repaint(Value);
  end;
end;

function TfcTreeNodes.InsertObject(Node: TfcTreeNode; const S: string;
  Ptr: Pointer): TfcTreeNode;
var
  Item, ItemId: HTreeItem;
  Parent: TfcTreeNode;
  AddMode: TfcAddMode;
begin
  Result := Owner.CreateNode;
  try
    Item := nil;
    ItemId := nil;
    Parent := nil;
    AddMode := fctaInsert;
    if Node <> nil then
    begin
      Parent := Node.Parent;
      if Parent <> nil then Item := Parent.ItemId;
      Node := Node.GetPrevSibling;
      if Node <> nil then ItemId := Node.ItemId
      else AddMode := fctaAddFirst;
    end;
    Result.Data := Ptr;
    Result.Text := S;
    Item := AddItem(Item, ItemId, CreateItem(Result), AddMode);
    if Item = nil then
      raise EOutOfResources.Create(sInsertError);
    Result.FItemId := Item;
    AddedNode(Parent);
    if not Owner.MultiSelectCheckboxNeeded(Result) then
       Result.StateIndex:= -1; { 5/15/98 - Required since its not initialized to -1}
  except
    Result.Free;
    raise;
  end;
end;

function TfcTreeNodes.InternalAddObject(Node: TfcTreeNode; const S: string;
  Ptr: Pointer; AddMode: TfcAddMode): TfcTreeNode;
var
  Item: HTreeItem;
begin
  Result := Owner.CreateNode;
  try
    if Node <> nil then Item := Node.ItemId
    else Item := nil;
    Result.Data := Ptr;
    Result.Text := S;
    Item := AddItem(Item, nil, CreateItem(Result), AddMode);
    if Item = nil then
      raise EOutOfResources.Create(sInsertError);
    Result.FItemId := Item;
    AddedNode(Node);
    if not Owner.MultiSelectCheckboxNeeded(Result) then
       Result.StateIndex:= -1; { 5/15/98 - Required since its not initialized to -1}
  except
    Result.Free;
    raise;
  end;
end;

function TfcTreeNodes.CreateItem(Node: TfcTreeNode): TTVItem;
begin
  Node.FInTree := True;
  with Result do
  begin
    mask := TVIF_TEXT or TVIF_PARAM or TVIF_IMAGE or TVIF_SELECTEDIMAGE;
    lParam := Longint(Node);
    pszText := LPSTR_TEXTCALLBACK;
    iImage := I_IMAGECALLBACK;
    iSelectedImage := I_IMAGECALLBACK;
  end;
end;

function TfcTreeNodes.AddItem(Parent, Target: HTreeItem;
  const Item: TTVItem; AddMode: TfcAddMode): HTreeItem;
var
  InsertStruct: TTVInsertStruct;
begin
  ClearCache;
  with InsertStruct do
  begin
    hParent := Parent;
    case AddMode of
      fctaAddFirst:
        hInsertAfter := TVI_FIRST;
      fctaAdd:
        hInsertAfter := TVI_LAST;
      fctaInsert:
        hInsertAfter := Target;
    end;
  end;
  InsertStruct.item := Item;
  FOwner.FChangeTimer.Enabled := False;
  Result := TreeView_InsertItem(Handle, InsertStruct);
end;

function TfcTreeNodes.GetFirstNode: TfcTreeNode;
begin
  Result := GetNode(TreeView_GetRoot(Handle));
end;

function TfcTreeNodes.GetNodeFromIndex(Index: Integer): TfcTreeNode;
var
  I: Integer;
begin
  if Index < 0 then TreeViewError(sInvalidIndex);
  if (FNodeCache.CacheNode <> nil) and (Abs(FNodeCache.CacheIndex - Index) <= 1) then
  begin
    with FNodeCache do
    begin
      if Index = CacheIndex then Result := CacheNode
      else if Index < CacheIndex then Result := CacheNode.GetPrev
      else Result := CacheNode.GetNext;
    end;
  end
  else begin
    Result := GetFirstNode;
    I := Index;
    while (I <> 0) and (Result <> nil) do
    begin
      Result := Result.GetNext;
      Dec(I);
    end;
  end;
  if Result = nil then TreeViewError(sInvalidIndex);
  FNodeCache.CacheNode := Result;
  FNodeCache.CacheIndex := Index;
end;

function TfcTreeNodes.GetNode(ItemId: HTreeItem): TfcTreeNode;
var
  Item: TTVItem;
begin
  with Item do
  begin
    hItem := ItemId;
    mask := TVIF_PARAM;
  end;
  if TreeView_GetItem(Handle, Item) then Result := TfcTreeNode(Item.lParam)
  else Result := nil;
end;

procedure TfcTreeNodes.SetItem(Index: Integer; Value: TfcTreeNode);
begin
  GetNodeFromIndex(Index).Assign(Value);
end;

procedure TfcTreeNodes.BeginUpdate;
begin
  if FUpdateCount = 0 then SetUpdateState(True);
  Inc(FUpdateCount);
end;

procedure TfcTreeNodes.SetUpdateState(Updating: Boolean);
begin
  SendMessage(Handle, WM_SETREDRAW, Ord(not Updating), 0);
  if not Updating then Owner.Refresh;
end;

procedure TfcTreeNodes.EndUpdate;
begin
  Dec(FUpdateCount);
  if FUpdateCount = 0 then SetUpdateState(False);
end;

procedure TfcTreeNodes.Assign(Source: TPersistent);
var
  TreeNodes: TfcTreeNodes;
  MemStream: TMemoryStream;
begin
  ClearCache;

  { 12/1/98 (RSW) Clear treeview display }
  SendMessage(Owner.Handle, WM_ERASEBkgnd, Owner.Canvas.Handle, 0);

  if Source is TfcTreeNodes then
  begin
    Owner.FStreamVersion:= 1;

    TreeNodes := TfcTreeNodes(Source);
    Clear;
    MemStream := TMemoryStream.Create;
    try
      TreeNodes.WriteData(MemStream);
      MemStream.Position := 0;
      ReadData(MemStream);
    finally
      MemStream.Free;
    end;
  end
  else inherited Assign(Source);

  if Count>0 then Owner.Selected:= Owner.Items[0];
  Owner.invalidate;
  // RSW - 1/13/99 Make sure some node is selected as the treeview common control
  // has problems in repainting in certain cases if no control has the selection

end;

procedure TfcTreeNodes.DefineProperties(Filer: TFiler);
{
  function WriteNodes: Boolean;
  var
    I: Integer;
    Nodes: TfcTreeNodes;
  begin
    Nodes := TfcTreeNodes(Filer.Ancestor);
    if Nodes = nil then
      Result := Count > 0
    else if Nodes.Count <> Count then
      Result := True
    else
    begin
      Result := False;
      for I := 0 to Count - 1 do
      begin
        Result := not Item[I].IsEqual(Nodes[I]);
        if Result then Break;
      end
    end;
  end;
}
begin
  inherited DefineProperties(Filer);
//  Filer.DefineBinaryProperty('Data', ReadData, WriteData, WriteNodes);
  Filer.DefineProperty('StreamVersion',
     ReadStreamVersion, WriteStreamVersion, True);
  Filer.DefineBinaryProperty('Data', ReadData, WriteData, True);
end;

procedure TfcTreeNodes.ReadStreamVersion(Reader: TReader);
begin
  Owner.FStreamVersion:= Reader.ReadInteger;
end;

procedure TfcTreeNodes.WriteStreamVersion(Writer: TWriter);
begin
   Owner.FStreamVersion:= 1;
   Writer.WriteInteger(Owner.StreamVersion)
end;



procedure TfcTreeNodes.ReadData(Stream: TStream);
var
  I, Count: Integer;
  NodeInfo: TfcNodeInfo;
begin
  FillChar(NodeInfo, SizeOf(TfcNodeInfo), 0);
  Clear;
  Stream.ReadBuffer(Count, SizeOf(Count));
  for I := 0 to Count - 1 do
    Add(nil, '').ReadData(Stream, @NodeInfo);
  Owner.FStreamVersion:= 1;
end;

procedure TfcTreeNodes.WriteData(Stream: TStream);
var
  I: Integer;
  Node: TfcTreeNode;
  NodeInfo: TfcNodeInfo;
begin
  Owner.FStreamVersion:=1;
  I := 0;
  Node := GetFirstNode;
  while Node <> nil do
  begin
    Inc(I);
    Node := Node.GetNextSibling;
  end;
  Stream.WriteBuffer(I, SizeOf(I));
  Node := GetFirstNode;
  while Node <> nil do
  begin
    Node.WriteData(Stream, @NodeInfo);
    Node := Node.GetNextSibling;
  end;
end;

procedure TfcTreeNodes.ClearCache;
begin
  FNodeCache.CacheNode := nil;
end;

{type
  TTreeStrings = class(TStrings)
  private
    FOwner: TfcTreeNodes;
  protected
    function Get(Index: Integer): string; override;
    function GetBufStart(Buffer: PChar; var Level: Integer): PChar;
    function GetCount: Integer; override;
    function GetObject(Index: Integer): TObject; override;
    procedure PutObject(Index: Integer; AObject: TObject); override;
    procedure SetUpdateState(Updating: Boolean); override;
  public
    constructor Create(AOwner: TfcTreeNodes);
    function Add(const S: string): Integer; override;
    procedure Clear; override;
    procedure Delete(Index: Integer); override;
    procedure Insert(Index: Integer; const S: string); override;
    procedure LoadTreeFromStream(Stream: TStream);
    procedure SaveTreeToStream(Stream: TStream);
    property Owner: TfcTreeNodes read FOwner;
  end;

constructor TTreeStrings.Create(AOwner: TfcTreeNodes);
begin
  inherited Create;
  FOwner := AOwner;
end;

function TTreeStrings.Get(Index: Integer): string;
const
  TabChar = #9;
var
  Level, I: Integer;
  Node: TfcTreeNode;
begin
  Result := '';
  Node := Owner.GetNodeFromIndex(Index);
  Level := Node.Level;
  for I := 0 to Level - 1 do Result := Result + TabChar;
  Result := Result + Node.Text;
end;

function TTreeStrings.GetBufStart(Buffer: PChar; var Level: Integer): PChar;
begin
  Level := 0;
  while Buffer^ in [' ', #9] do
  begin
    Inc(Buffer);
    Inc(Level);
  end;
  Result := Buffer;
end;

function TTreeStrings.GetObject(Index: Integer): TObject;
begin
  Result := Owner.GetNodeFromIndex(Index).Data;
end;

procedure TTreeStrings.PutObject(Index: Integer; AObject: TObject);
begin
  Owner.GetNodeFromIndex(Index).Data := AObject;
end;

function TTreeStrings.GetCount: Integer;
begin
  Result := Owner.Count;
end;

procedure TTreeStrings.Clear;
begin
  Owner.Clear;
end;

procedure TTreeStrings.Delete(Index: Integer);
begin
  Owner.GetNodeFromIndex(Index).Delete;
end;

procedure TTreeStrings.SetUpdateState(Updating: Boolean);
begin
  SendMessage(Owner.Handle, WM_SETREDRAW, Ord(not Updating), 0);
  if not Updating then Owner.Owner.Refresh;
end;

function TTreeStrings.Add(const S: string): Integer;
var
  Level, OldLevel, I: Integer;
  NewStr: string;
  Node: TfcTreeNode;
begin
  Result := GetCount;
  if (Length(S) = 1) and (S[1] = Chr($1A)) then Exit;
  Node := nil;
  OldLevel := 0;
  NewStr := GetBufStart(PChar(S), Level);
  if Result > 0 then
  begin
    Node := Owner.GetNodeFromIndex(Result - 1);
    OldLevel := Node.Level;
  end;
  if (Level > OldLevel) or (Node = nil) then
  begin
    if Level - OldLevel > 1 then TreeViewError(sInvalidLevel);
  end
  else begin
    for I := OldLevel downto Level do
    begin
      Node := Node.Parent;
      if (Node = nil) and (I - Level > 0) then
        TreeViewError(sInvalidLevel);
    end;
  end;
  Owner.AddChild(Node, NewStr);
end;

procedure TTreeStrings.Insert(Index: Integer; const S: string);
begin
  with Owner do
    Insert(GetNodeFromIndex(Index), S);
end;

procedure TTreeStrings.LoadTreeFromStream(Stream: TStream);
var
  List: TStringList;
  ANode, NextNode: TfcTreeNode;
  ALevel, i: Integer;
  CurrStr: string;
begin
  List := TStringList.Create;
  Owner.BeginUpdate;
  try
    try
      Clear;
      List.LoadFromStream(Stream);
      ANode := nil;
      for i := 0 to List.Count - 1 do
      begin
        CurrStr := GetBufStart(PChar(List[i]), ALevel);
        if ANode = nil then
          ANode := Owner.AddChild(nil, CurrStr)
        else if ANode.Level = ALevel then
          ANode := Owner.AddChild(ANode.Parent, CurrStr)
        else if ANode.Level = (ALevel - 1) then
          ANode := Owner.AddChild(ANode, CurrStr)
        else if ANode.Level > ALevel then
        begin
          NextNode := ANode.Parent;
          while NextNode.Level > ALevel do
            NextNode := NextNode.Parent;
          ANode := Owner.AddChild(NextNode.Parent, CurrStr);
        end
        else TreeViewErrorFmt(sInvalidLevelEx, [ALevel, CurrStr]);
      end;
    finally
      Owner.EndUpdate;
      List.Free;
    end;
  except
    Owner.Owner.Invalidate;  // force repaint on exception
    raise;
  end;
end;

procedure TTreeStrings.SaveTreeToStream(Stream: TStream);
const
  TabChar = #9;
  EndOfLine = #13#10;
var
  i: Integer;
  ANode: TfcTreeNode;
  NodeStr: string;
begin
  if Count > 0 then
  begin
    ANode := Owner[0];
    while ANode <> nil do
    begin
      NodeStr := '';
      for i := 0 to ANode.Level - 1 do NodeStr := NodeStr + TabChar;
      NodeStr := NodeStr + ANode.Text + EndOfLine;
      Stream.Write(Pointer(NodeStr)^, Length(NodeStr));
      ANode := ANode.GetNext;
    end;
  end;
end;
}

{ TfcCustomTreeView }

constructor TfcCustomTreeView.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle - [csCaptureMouse] + [csDisplayDragImage, csReflector];
  Width := 121;
  Height := 97;
  TabStop := True;
  ParentColor := False;
  NodeClass := TfcTreeNode;
  FCanvas := TfcCanvas.Create;
  TControlCanvas(FCanvas).Control := Self;
  FTreeNodes := TfcTreeNodes.Create(Self);
  FBorderStyle := bsSingle;
//  FShowButtons := True;
//  FShowRoot := True;
//  FShowLines := True;
//  FHideSelection := True;
  FOptions:= [tvoExpandOnDblClk, tvoShowButtons, tvoShowRoot,
    tvoShowLines, tvoHideSelection, tvoToolTips];
  {$ifdef fcDelphi4Up}
  FDragImage := TDragImageList.CreateSize(32, 32);
  {$else}
  FDragImage := TImageList.CreateSize(32, 32);
  {$endif}
  FSaveIndent := -1;
  FChangeTimer := TTimer.Create(Self);
  FChangeTimer.Enabled := False;
  FChangeTimer.Interval := 0;
  FChangeTimer.OnTimer := OnChangeTimer;
//  FToolTips := False;
  FEditInstance := MakeObjectInstance(EditWndProc);
  FImageChangeLink := TChangeLink.Create;
  FImageChangeLink.OnChange := ImageListChange;
  FStateChangeLink := TChangeLink.Create;
  FStateChangeLink.OnChange := ImageListChange;

//  FOptions := [tvoExpandOnDblClk];
  FMultiSelectAttributes:= TfcTVMultiSelectAttributes.create(self);
  FMultiSelectList:= TList.create;
  FBorderWidth := GetSystemMetrics(SM_CXBORDER);
  FFixBugImageList:= TImageList.create(self);
  FFixBugImageList.Width:= FixBugImageListSize;
  FFixBugImageList.Height:= FixBugImageListSize;

  FPaintBitmap:= TBitmap.create;
  FPaintCanvas:= TfcCanvas(FPaintBitmap.Canvas);

  FLineColor:= clBtnShadow;
  FInactiveFocusColor:= clBtnFace;
  FReadOnly:= False;

  Patch:= VarArrayCreate([0, 0], varVariant);
  Patch[0]:= False;
//  Patch[1]:= 0; { Used by TfcTreeNode ReadData }

end;

destructor TfcCustomTreeView.Destroy;
begin
  FPaintBitmap.Free;

  FMultiSelectList.Free;
  FMultiSelectAttributes.Free;
  FFixBugImageList.Free;


//  Items.Free;
  FTreeNodes.Free;
  FTreeNodes:= nil;
  FChangeTimer.Free;
  FSaveItems.Free;
  FDragImage.Free;
  FMemStream.Free;
  FreeObjectInstance(FEditInstance);
  FImageChangeLink.Free;
  FStateChangeLink.Free;
  FCanvas.Free;

  inherited Destroy;
end;

procedure TfcCustomTreeView.CreateParams(var Params: TCreateParams);
const
  TVS_TRACKSELECT         = $0200;
  TVS_NOTOOLTIPS          = $0080;
  TVS_INFOTIP             = $0800;
  TVS_SINGLEEXPAND        = $0400;
  BorderStyles: array[TBorderStyle] of DWORD = (0, WS_BORDER);
  LineStyles: array[Boolean] of DWORD = (0, TVS_HASLINES);
  RootStyles: array[Boolean] of DWORD = (0, TVS_LINESATROOT);
  ButtonStyles: array[Boolean] of DWORD = (0, TVS_HASBUTTONS);
  EditStyles: array[Boolean] of DWORD = (TVS_EDITLABELS, 0);
  HideSelections: array[Boolean] of DWORD = (TVS_SHOWSELALWAYS, 0);
  DragStyles: array[TDragMode] of DWORD = (TVS_DISABLEDRAGDROP, 0);
  HotTrackStyles: array[Boolean] of DWORD = (0, TVS_TRACKSELECT);
  ToolTipStyles: array[Boolean] of DWORD = (TVS_NOTOOLTIPS, TVS_NOTOOLTIPS);
  AutoExpandStyles: array[Boolean] of DWORD = (0, TVS_SINGLEEXPAND);
  {$ifdef fcDelphi4Up}
  RTLStyles: array[Boolean] of DWORD = (0, TVS_RTLREADING);
  RowSelectStyles: array[Boolean] of DWORD = (0, TVS_FULLROWSELECT);
  {$endif}
  TVS_NOSCROLL = $2000;
begin
  InitCommonControl(ICC_TREEVIEW_CLASSES);
  inherited CreateParams(Params);
  CreateSubClass(Params, WC_TREEVIEW);
  with Params do
  begin
    Style := Style or LineStyles[tvoShowLines in Options] or BorderStyles[FBorderStyle] or
      RootStyles[tvoShowRoot in Options] or ButtonStyles[tvoShowButtons in Options] or
      EditStyles[not (tvoEditText in Options)] or HideSelections[not (tvoHideSelection in Options)] or
      DragStyles[DragMode] or
      ToolTipStyles[False] or // FToolTips] or
      HotTrackStyles[tvoHotTrack in Options] or
      AutoExpandStyles[FAutoExpand]
      {$ifdef fcDelphi4Up}
       or
      RTLStyles[UseRightToLeftReading]
      {$endif};
    if Ctl3D and NewStyleControls and (FBorderStyle = bsSingle) then
    begin
      Style := Style and not WS_BORDER;
      ExStyle := Params.ExStyle or WS_EX_CLIENTEDGE;
    end;
    WindowClass.style := WindowClass.style and not (CS_HREDRAW or CS_VREDRAW);
  end;
  Params.Style := Params.Style or TVS_CHECKBOXES;

end;

function TreeView_SetBkColor(hwnd: HWND; clr: COLORREF): COLORREF;
const
  TVM_SETBKCOLOR              = TV_FIRST + 29;
begin
  Result := COLORREF(SendMessage(hwnd, TVM_SETBKCOLOR, 0, LPARAM(clr)));
end;

function TreeView_SetTextColor(hwnd: HWND; clr: COLORREF): COLORREF;
const
  TVM_SETTEXTCOLOR              = TV_FIRST + 30;
begin
  Result := COLORREF(SendMessage(hwnd, TVM_SETTEXTCOLOR, 0, LPARAM(clr)));
end;

procedure TfcCustomTreeView.CreateWnd;
var
  DC: HDC;
  SaveFont: HFont;
  TextSize: TSize;
begin
  FStateChanging := False;
  inherited CreateWnd;
  TreeView_SetBkColor(Handle, ColorToRGB(Color));
  TreeView_SetTextColor(Handle, ColorToRGB(Font.Color));
  if FMemStream <> nil then
  begin
    Items.ReadData(FMemStream);
    FMemStream.Destroy;
    FMemStream := nil;
    SetTopItem(Items.GetNodeFromIndex(FSaveTopIndex));
    FSaveTopIndex := 0;
    SetSelection(Items.GetNodeFromIndex(FSaveIndex));
    FSaveIndex := 0;
  end;
  if FSaveIndent <> -1 then Indent := FSaveIndent;
  if (Images <> nil) and Images.HandleAllocated then
    SetImageList(Images.Handle, TVSIL_NORMAL);
  if (StateImages <> nil) and StateImages.HandleAllocated then
    SetImageList(StateImages.Handle, TVSIL_STATE);

  { Create StateImageList if not assigned }
  DC := GetDC(0);
  SaveFont := SelectObject(DC, Font.Handle);
  GetTextExtentPoint32(DC, 'A', 1, TextSize);
  SelectObject(DC, SaveFont);
  ReleaseDC(0, DC);
  FFixBugImageList.Width:= fcMin(TextSize.cy+2, FixBugImageListSize);
  FFixBugImageList.Width:= fcMax(FixBugImageListSize, 16); { 2/1/99}
  FFixBugImageList.Height:= FFixBugImageList.Width;

  if HandleAllocated and (StateImages=Nil) then
     TreeView_SetImageList(Handle, FFixBugImageList.Handle, TVSIL_STATE);

  { 5/5/99 - Workaround for TreeView common control problem where this property is reset }
  if not (tvoHideSelection in Options) and HandleAllocated then
     SetComCtlStyle(Self, TVS_SHOWSELALWAYS, True);


end;

procedure TfcCustomTreeView.DestroyWnd;
var
  Node: TfcTreeNode;
begin
  FStateChanging := True;
  if Items.Count > 0 then
  begin
    FMemStream := TMemoryStream.Create;
    Items.WriteData(FMemStream);
    FMemStream.Position := 0;
    Node := GetTopItem;
    if Node <> nil then FSaveTopIndex := Node.AbsoluteIndex;
    Node := Selected;
    if Node <> nil then FSaveIndex := Node.AbsoluteIndex;
  end;
  FSaveIndent := Indent;
  inherited DestroyWnd;
end;

procedure TfcCustomTreeView.EditWndProc(var Message: TMessage);
var DisplayRect: TRect;
begin
  try
    with Message do
    begin
      case Msg of
        WM_WINDOWPOSCHANGED, WM_SIZE:
          begin
            If (EditNode<>Nil) and (Images<>Nil) and (EditNode.imageindex=-2) then
            begin
              DisplayRect:= EditNode.DisplayRect(True);
              SetWindowPos(FEditHandle, 0, fcmax(DisplayRect.Left, 0),DisplayRect.Top,0,0, //sp.x + DisplayRect.Left, sp.y + DisplayRect.Top, 0, 0,
                SWP_NOZORDER OR SWP_NOSIZE OR SWP_NOACTIVATE);
              ValidateRect(Handle, nil);
//            Message.Result:= 1;
            end
            else if (EditNode<>Nil) and (Msg=WM_SIZE) then begin
               if (Patch[0]=False) then
                  ValidateRect(Handle, nil) // RSW (4/8/99 } Prevent flicker when edit box size changes
               else Patch[0]:= False;
            end
          end;


        WM_KEYDOWN,
        WM_SYSKEYDOWN: if DoKeyDown(TWMKey(Message)) then Exit;
        WM_CHAR: if DoKeyPress(TWMKey(Message)) then Exit;
        WM_KEYUP,
        WM_SYSKEYUP: if DoKeyUp(TWMKey(Message)) then Exit;
        CN_KEYDOWN,
        CN_CHAR, CN_SYSKEYDOWN,
        CN_SYSCHAR:
          begin
            WndProc(Message);
            Exit;
          end;
      end;
      Result := CallWindowProc(FDefEditProc, FEditHandle, Msg, WParam, LParam);
    end;
  except
    Application.HandleException(Self);
  end;
end;

procedure TfcCustomTreeView.CMColorChanged(var Message: TMessage);
begin
  inherited;
  RecreateWnd;
end;

procedure TfcCustomTreeView.CMCtl3DChanged(var Message: TMessage);
begin
  inherited;
  if FBorderStyle = bsSingle then RecreateWnd;
end;

procedure TfcCustomTreeView.CMFontChanged(var Message: TMessage);
begin
  inherited;
  TreeView_SetTextColor(Handle, ColorToRGB(Font.Color));
end;

procedure TfcCustomTreeView.CMSysColorChange(var Message: TMessage);
begin
  inherited;
  if not (csLoading in ComponentState) then
  begin
    Message.Msg := WM_SYSCOLORCHANGE;
    DefaultHandler(Message);
  end;
end;

function TfcCustomTreeView.AlphaSort: Boolean;
var
  Node: TfcTreeNode;
begin
  if HandleAllocated then
  begin
    Result := CustomSort(nil, 0);
    Node := FTreeNodes.GetFirstNode;
    while Node <> nil do
    begin
      if Node.HasChildren then Node.AlphaSort;
      Node := Node.GetNext;
    end;
  end
  else
    Result := False;
end;

function TfcCustomTreeView.CustomSort(SortProc: TTVCompare; Data: Longint): Boolean;
var
  SortCB: TTVSortCB;
//  Node: TfcTreeNode;
begin
  Result := False;
  if HandleAllocated then
  begin
    with SortCB do
    begin
      if not Assigned(SortProc) then lpfnCompare := @DefaultTreeViewSort
      else lpfnCompare := SortProc;
      hParent := TVI_ROOT;
      lParam := Data;
      Result := TreeView_SortChildrenCB(Handle, SortCB, 0);
    end;
{    Node := FTreeNodes.GetFirstNode;
    while Node <> nil do
    begin
      if Node.HasChildren then Node.CustomSort(SortProc, Data);
      Node := Node.GetNext;
    end;}
    Items.ClearCache;
  end;
end;

procedure TfcCustomTreeView.SetAutoExpand(Value: Boolean);
const
  TVS_SINGLEEXPAND        = $0400;
begin
  if FAutoExpand <> Value then
  begin
    FAutoExpand := Value;
    SetComCtlStyle(Self, TVS_SINGLEEXPAND, Value);
  end;
end;

{
procedure TfcCustomTreeView.SetHotTrack(Value: Boolean);
const
  TVS_TRACKSELECT         = $0200;
begin
  if FHotTrack <> Value then
  begin
    FHotTrack := Value;
    SetComCtlStyle(Self, TVS_TRACKSELECT, Value);
  end;
end;
}

{procedure TfcCustomTreeView.SetRowSelect(Value: Boolean);
const
  TVS_FULLROWSELECT       = $1000;
begin
  if (tvoRowSelect in Options) <> Value then
  begin
    FRowSelect := Value;
    SetComCtlStyle(Self, TVS_FULLROWSELECT, Value);
  end;
end;
}
{procedure TfcCustomTreeView.SetToolTips(Value: Boolean);
const TVS_NOTOOLTIPS          = $0080;
begin
  if FToolTips <> Value then
  begin
    FToolTips := Value;
    SetComCtlStyle(Self, TVS_NOTOOLTIPS, not Value);
  end;
end;
}
procedure TfcCustomTreeView.SetSortType(Value: TfcSortType);
begin
  if SortType <> Value then
  begin
    FSortType := Value;
    if ((SortType in [fcstData, fcstBoth]) and Assigned(OnCompare)) or
      (SortType in [fcstText, fcstBoth]) then
      AlphaSort;
  end;
end;

procedure TfcCustomTreeView.SetBorderStyle(Value: TBorderStyle);
begin
  if BorderStyle <> Value then
  begin
    FBorderStyle := Value;
    RecreateWnd;
  end;
end;

procedure TfcCustomTreeView.SetDragMode(Value: TDragMode);
begin
  if Value <> DragMode then
    SetComCtlStyle(Self, TVS_DISABLEDRAGDROP, Value = dmManual);
  inherited;
end;

{
procedure TfcCustomTreeView.SetButtonStyle(Value: Boolean);
begin
  if ShowButtons <> Value then
  begin
    FShowButtons := Value;
    SetComCtlStyle(Self, TVS_HASBUTTONS, Value);
  end;
end;
}

{
procedure TfcCustomTreeView.SetLineStyle(Value: Boolean);
begin
  if ShowLines <> Value then
  begin
    FShowLines := Value;
    SetComCtlStyle(Self, TVS_HASLINES, Value);
    SetComCtlStyle(Self, TVS_HASBUTTONS, Value);
  end;
end;
}
{
procedure TfcCustomTreeView.SetRootStyle(Value: Boolean);
begin
  if ShowRoot <> Value then
  begin
    FShowRoot := Value;
  end;
end;
}
procedure TfcCustomTreeView.SetReadOnly(Value: Boolean);
begin
  if ReadOnly <> Value then
  begin
    FReadOnly := Value;

    if FReadOnly then
    begin
       if (tvoEditText in Options) then SetComCtlStyle(Self, TVS_EDITLABELS, False);
    end
    else begin
       if (tvoEditText in Options) then SetComCtlStyle(Self, TVS_EDITLABELS, True);
    end;
  end;


end;

{procedure TfcCustomTreeView.SetHideSelection(Value: Boolean);
begin
  if HideSelection <> Value then
  begin
    FHideSelection := Value;
    SetComCtlStyle(Self, TVS_SHOWSELALWAYS, not Value);
    Invalidate;
  end;
end;
}
function TfcCustomTreeView.GetNodeAt(X, Y: Integer): TfcTreeNode;
var
  HitTest: TTVHitTestInfo;
begin
  with HitTest do
  begin
    pt.X := X;
    pt.Y := Y;
    if TreeView_HitTest(Handle, HitTest) <> nil then
      Result := Items.GetNode(HitTest.hItem)
    else Result := nil;
  end;
end;

function TfcCustomTreeView.GetHitTestInfoAt(X, Y: Integer): TfcHitTests;
var
  HitTest: TTVHitTestInfo;
  DisplayRect: TRect;
  Node: TfcTreeNode;
begin
  Result := [];
  with HitTest do
  begin
    pt.X := X;
    pt.Y := Y;
    TreeView_HitTest(Handle, HitTest);

    if (flags and TVHT_ABOVE) <> 0 then Include(Result, fchtAbove);
    if (flags and TVHT_BELOW) <> 0 then Include(Result, fchtBelow);
    if (flags and TVHT_NOWHERE) <> 0 then Include(Result, fchtNowhere);
    if (flags and TVHT_ONITEM) <> 0 then Include(Result, fchtOnItem);
    if (flags and TVHT_ONITEMBUTTON) <> 0 then Include(Result, fchtOnButton);
    if (flags and TVHT_ONITEMICON) <> 0 then Include(Result, fchtOnIcon);
    if (flags and TVHT_ONITEMINDENT) <> 0 then Include(Result, fchtOnIndent);
    if (flags and TVHT_ONITEMLABEL) <> 0 then Include(Result, fchtOnLabel);
    if (flags and TVHT_ONITEMRIGHT) <> 0 then Include(Result, fchtOnRight);
    if (flags and TVHT_ONITEMSTATEICON) <> 0 then Include(Result, fchtOnStateIcon);
    if (flags and TVHT_TOLEFT) <> 0 then Include(Result, fchtToLeft);
    if (flags and TVHT_TORIGHT) <> 0 then Include(Result, fchtToRight);

    if (fchtOnItem in Result) then
    begin
       node:= GetNodeAt(X, Y);
       if (Images<>Nil) and (node<>nil) and (node.imageindex=-2) then
       begin
          DisplayRect:= Node.DisplayRect(True);
          if (x>=DisplayRect.Left) and (x<=DisplayRect.Right) then
          begin
             Include(Result, fchtOnLabel);
             Exclude(Result, fchtOnIcon);
          end
       end
    end;

  end;
end;

procedure TfcCustomTreeView.SeTfcTreeNodes(Value: TfcTreeNodes);
begin
  Items.Assign(Value);
end;

procedure TfcCustomTreeView.SetIndent(Value: Integer);
begin
  if Value <> Indent then TreeView_SetIndent(Handle, Value);
end;

function TfcCustomTreeView.GetIndent: Integer;
begin
  Result := TreeView_GetIndent(Handle)
end;

procedure TfcCustomTreeView.FullExpand;
var
  Node: TfcTreeNode;
begin
  Node := Items.GetFirstNode;
  while Node <> nil do
  begin
    Node.Expand(True);
    Node := Node.GetNextSibling;
  end;
  ResetStateImages;
end;

procedure TfcCustomTreeView.FullCollapse;
var
  Node: TfcTreeNode;
begin
  Node := Items.GetFirstNode;
  while Node <> nil do
  begin
    Node.Collapse(True);
    Node := Node.GetNextSibling;
  end;
end;

procedure TfcCustomTreeView.Loaded;
begin
  inherited Loaded;
  if csDesigning in ComponentState then FullExpand;
end;

function TfcCustomTreeView.GetTopItem: TfcTreeNode;
begin
  if HandleAllocated then
    Result := Items.GetNode(TreeView_GetFirstVisible(Handle))
  else Result := nil;
end;

procedure TfcCustomTreeView.SetTopItem(Value: TfcTreeNode);
begin
  if HandleAllocated and (Value <> nil) then
    TreeView_SelectSetFirstVisible(Handle, Value.ItemId);
end;

procedure TfcCustomTreeView.OnChangeTimer(Sender: TObject);
begin
  FChangeTimer.Enabled := False;
  Change(TfcTreeNode(FChangeTimer.Tag));
end;

function TfcCustomTreeView.GetSelection: TfcTreeNode;
begin
  if HandleAllocated then
  begin
     Result := Items.GetNode(TreeView_GetSelection(Handle));
  end
  else Result := nil;
end;

procedure TfcCustomTreeView.SetSelection(Value: TfcTreeNode);
begin
  if Value <> nil then Value.Selected := True
  else TreeView_SelectItem(Handle, nil);
end;

procedure TfcCustomTreeView.SetChangeDelay(Value: Integer);
begin
  FChangeTimer.Interval := Value;
end;

function TfcCustomTreeView.GetChangeDelay: Integer;
begin
  Result := FChangeTimer.Interval;
end;

function TfcCustomTreeView.GetDropTarget: TfcTreeNode;
begin
  if HandleAllocated then
  begin
    Result := Items.GetNode(TreeView_GetDropHilite(Handle));
    if Result = nil then Result := FLastDropTarget;
  end
  else Result := nil;
end;

procedure TfcCustomTreeView.SetDropTarget(Value: TfcTreeNode);
begin
  if HandleAllocated then
    if Value <> nil then Value.DropTarget := True
    else TreeView_SelectDropTarget(Handle, nil);
end;

function TfcCustomTreeView.GetNodeFromItem(const Item: TTVItem): TfcTreeNode;
begin
  with Item do
    if (state and TVIF_PARAM) <> 0 then Result := Pointer(lParam)
    else Result := Items.GetNode(hItem);
end;

function TfcCustomTreeView.IsEditing: Boolean;
var
  ControlHand: HWnd;
begin
  ControlHand := TreeView_GetEditControl(Handle);
  Result := (ControlHand <> 0) and IsWindowVisible(ControlHand);
end;

function fcWinItemStateTokwItemState(WinItemState: UINT): TfcItemStates;
begin
  result := [];
  if WinItemState and CDIS_SELECTED <> 0 then include(result, fcisSelected);
  if WinItemState and CDIS_GRAYED <> 0 then include(result, fcisGrayed);
  if WinItemState and CDIS_DISABLED <> 0 then include(result, fcisDisabled);
  if WinItemState and CDIS_CHECKED <> 0 then include(result, fcisChecked);
  if WinItemState and CDIS_FOCUS <> 0 then include(result, fcisFocused);
  if WinItemState and CDIS_DEFAULT <> 0 then include(result, fcisDefault);
  if WinItemState and CDIS_HOT <> 0 then include(result, fcisHot);
  if WinItemState and CDIS_MARKED <> 0 then include(result, fcisMarked);
  if WinItemState and CDIS_INDETERMINATE <> 0 then include(result, fcisIndeterminate);
end;

procedure TfcCustomTreeView.PaintItem(node: TfcTreeNode);
begin
end;


procedure TfcCustomTreeView.CNNotify(var Message: TWMNotify);
//const
//  TVN_BEGINLABELEDIT = TVN_FIRST-10;
var
  Node: TfcTreeNode;
  MousePos: TPoint;
  R: TRect;
  DefaultDraw: Boolean;
  TmpItem: TTVItem;
  ANode: TfcTreeNode;
  TempText: string; // -ksw (Added for tvoUnderscoreAllowed option)
begin
  with Message do
    case NMHdr^.code of
      NM_CUSTOMDRAW:
        with PNMCustomDraw(NMHdr)^ do
        begin
          Result := CDRF_DODEFAULT;
          if dwDrawStage = CDDS_PREPAINT then
          begin
            FIndent := TreeView_GetIndent(self.Handle);

            if True then // IsCustomDrawn(dtControl, cdPrePaint) then
            begin
              FCanvas.Handle := dc;
              FPaintCanvas.Font := Font;
              FPaintCanvas.Brush := Brush;
              R := ClientRect;
              BeginPainting;
              DisplayedItems:= 0;

{              DefaultDraw := CustomDraw(R, cdPrePaint);
              if not DefaultDraw then
              begin
                Result := CDRF_SKIPDEFAULT;
                Exit;
              end;}
            end;
            if True then //IsCustomDrawn(dtControl, cdPostPaint) then
              Result := CDRF_NOTIFYPOSTPAINT;
            if True then //IsCustomDrawn(dtItem, cdPrePaint) then
              Result := Result or CDRF_NOTIFYITEMDRAW else
              Result := Result or CDRF_DODEFAULT;
          end
          else if dwDrawStage = CDDS_ITEMPREPAINT then
          begin
            FillChar(TmpItem, SizeOf(TmpItem), 0);
            TmpItem.hItem := HTREEITEM(dwItemSpec);
            Node := GetNodeFromItem(TmpItem);
            inc(DisplayedItems);
            if Node <> nil then
            begin
//              {$ifdef fcdelphi4up}
//              FCanvas.Handle := hdc;
//              {$else}
//              FCanvas.Handle := dc;
//              {$endif}
              FPaintCanvas.Font := Font;
              FPaintCanvas.Brush := Brush;
              { Unlike the list view, the tree view doesn't override the text
                foreground and background colors of selected items. }
              if uItemState and CDIS_SELECTED <> 0 then
              begin
                FPaintCanvas.Font.Color := clHighlightText;
                FPaintCanvas.Brush.Color := clHighlight;
              end;
              FPaintCanvas.Font.OnChange := CanvasChanged;
              FPaintCanvas.Brush.OnChange := CanvasChanged;
              DefaultDraw:= True;
//              DefaultDraw := CustomDrawItem(Node,
//                TCustomDrawState(Word(uItemState)), cdPrePaint);
              Result := Result or CDRF_SKIPDEFAULT; {ww}

              if DefaultDraw and FCanvasChanged then
              begin
                FCanvasChanged := False;
                FPaintCanvas.Font.OnChange := nil;
                FPaintCanvas.Brush.OnChange := nil;
                with PNMTVCustomDraw(NMHdr)^ do
                begin
                  clrText := ColorToRGB(FPaintCanvas.Font.Color);
                  clrTextBk := ColorToRGB(FPaintCanvas.Brush.Color);
                  SelectObject(dc, FPaintCanvas.Font.Handle);
                  Result := Result or CDRF_NEWFONT;
                end;
              end;

              if DefaultDraw then
              begin
                ANode := TfcTreeNode(lItemlParam);
                rc := ANode.DisplayRect(True);
                BeginItemPainting(ANode, rc,
                   fcWinItemStateTokwItemState(uItemState));
                EndItemPainting(TfcTreeNode(lItemlParam),
                   rc, fcWinItemStateTokwItemState(uItemState));
              end;

              PaintItem(Node);
//              FCanvas.Handle := 0;
              if True then //IsCustomDrawn(dtItem, cdPostPaint) then
                Result := Result or CDRF_NOTIFYPOSTPAINT;
            end;
          end

          else if dwDrawStage = CDDS_POSTPAINT then
          begin
//             if DisplayedItems>0 then
//             begin
                EndPainting;
                FCanvas.Handle := 0;
//             end;
          end;

        end;
      TVN_BEGINDRAG:
        begin
          FDragged := True;
          with PNMTreeView(NMHdr)^ do
            FDragNode := GetNodeFromItem(ItemNew);
        end;

      TVN_BEGINLABELEDIT:
        begin
{          Result:= 1;
          Node := GetNodeFromItem(PTVDispInfo(NMHdr)^.Item);
          DisplayRect:= Node.DisplayRect(True);
          if FEditControl=Nil then
          begin
             FEditControl:= TEdit.create(self);
          end;
          FEditControl.parent:= self;
          TEdit(FEditControl).AutoSize:= False;
          FEditControl.Left:= DisplayRect.Left;
          FEditControl.Top:= DisplayRect.Top;
          FEditControl.Height:= DisplayRect.Bottom - DisplayRect.Top;
          FEditControl.Visible:= True;
          TEdit(FEditControl).Text:= Node.Text;
//          TEdit(FEditControl).Ctl3d:= False;
          TEdit(FEditControl).SelectAll;
          TEdit(FEditControl).SetFocus;
          exit;
}
          with PTVDispInfo(NMHdr)^ do
            if Dragging or not CanEdit(GetNodeFromItem(item)) then
              Result := 1;
          if Result = 0 then
          begin
            FEditHandle := TreeView_GetEditControl(Handle);
            FDefEditProc := Pointer(GetWindowLong(FEditHandle, GWL_WNDPROC));
            SetWindowLong(FEditHandle, GWL_WNDPROC, LongInt(FEditInstance));

//            sp:= self.ClientToScreen(Point(0, 0));
            EditNode := GetNodeFromItem(PTVDispInfo(NMHdr)^.Item);
            Patch[0]:= True; { 6/14/99 - Skip Validate in EditWndProc }
//            DisplayRect:= Node.DisplayRect(True);
//
//            GetWindowRect(self.handle, r);
//            SetWindowPos(FEditHandle, 0, 1,1,0,0, //sp.x + DisplayRect.Left, sp.y + DisplayRect.Top, 0, 0,
//              SWP_NOZORDER OR SWP_NOSIZE OR SWP_NOACTIVATE);

          end;
        end;
      TVN_ENDLABELEDIT:
        begin
           Edit(PTVDispInfo(NMHdr)^.item);
        end;

      TVN_ITEMEXPANDING:
        if not FManualNotify then
        begin
          with PNMTreeView(NMHdr)^ do
          begin
            Node := GetNodeFromItem(ItemNew);
            if (action = TVE_EXPAND) and not CanExpand(Node) then
              Result := 1
            else if (action = TVE_COLLAPSE) and
              not CanCollapse(Node) then Result := 1;
          end;
        end;
      TVN_ITEMEXPANDED:
        if not FManualNotify then
        begin
          with PNMTreeView(NMHdr)^ do
          begin
            Node := GetNodeFromItem(itemNew);
            if (action = TVE_EXPAND) then Expand(Node)
            else if (action = TVE_COLLAPSE) then Collapse(Node);
          end;
        end;
      TVN_SELCHANGINGA, TVN_SELCHANGINGW:
        begin
          if SkipChangeMessages then exit; { RSW}
          if not CanChange(GetNodeFromItem(PNMTreeView(NMHdr)^.itemNew)) then
            Result := 1;
        end;
      TVN_SELCHANGEDA, TVN_SELCHANGEDW:
        begin
          if SkipChangeMessages then exit; { RSW}
          with PNMTreeView(NMHdr)^ do
            if FChangeTimer.Interval > 0 then
            with FChangeTimer do
            begin
              Enabled := False;
              Tag := Integer(GetNodeFromItem(itemNew));
              Enabled := True;
            end
            else
              Change(GetNodeFromItem(itemNew));
          end;
      TVN_DELETEITEM:
          if not FStateChanging then
          begin
             Node := GetNodeFromItem(PNMTreeView(NMHdr)^.itemOld);
             if Node <> nil then
             begin
               Node.FItemId := nil;
               FChangeTimer.Enabled := False;
               if FStateChanging then Node.Delete
               else Items.Delete(Node);
             end;
          end;
      TVN_SETDISPINFO:
        with PTVDispInfo(NMHdr)^ do
        begin
          Node := GetNodeFromItem(item);
          if (Node <> nil) and ((item.mask and TVIF_TEXT) <> 0) then
            Node.Text := item.pszText;
        end;
      TVN_GETDISPINFO:
        with PTVDispInfo(NMHdr)^ do
        begin
          Node := GetNodeFromItem(item);
          if Node <> nil then
          begin
            TempText := Node.Text;  // -ksw  (Added for tvoUnderscoreAllowed option)
//            if tvoUnderscoreAllowed in FOptions then TempText := fcStripAmpersands(Node.Text);  // -ksw Added
            if (item.mask and TVIF_TEXT) <> 0 then
              StrLCopy(item.pszText, PChar(TempText), item.cchTextMax); // -ksw (Changed to use the TempText var)
            if (item.mask and TVIF_IMAGE) <> 0 then
            begin
              GetImageIndex(Node);
              item.iImage := Node.ImageIndex;
            end;
            if (item.mask and TVIF_SELECTEDIMAGE) <> 0 then
            begin
              GetSelectedIndex(Node);
              item.iSelectedImage := Node.SelectedIndex;
            end;
          end;
        end;
      NM_RCLICK:
        begin
            GetCursorPos(MousePos);
            with PointToSmallPoint(ScreenToClient(MousePos)) do
            begin
              FRClickNode := GetNodeAt(X, Y);
              if RightClickSelects and (FRClickNode<>nil) then Selected:= FRClickNode
              else begin
                 if FRClickNode<>nil then InvalidateNode(FRClickNode);
              end;
              InvalidateNoErase; { 4/21/99 - Workaround for Microsoft Tree bug which causes last
                                    node to not paint correctly  }
              Perform(WM_RBUTTONUP, 0, MakeLong(X, Y));
            end;
        end;
//      TVN_BEGINLABELEDIT:
//        begin
//        end;

{      TVN_GETINFOTIP:
        begin
           if fcUpdatedComCtlVersion then begin
              ToolTipHandle:= SendMessage(Handle, TVM_GETTOOLTIPS, 0, 0);
              with PNMTVGetInfoTip(NMHdr)^ do
              begin
                 Node:= Items.GetNode(hItem);
                 HintTimer:= TTimer.create(self);
                 HintTimer.OnTimer:=HintTimerEvent;
                 HintTimer.Interval:=250;
                 HintTimer.Enabled:= True;
//                 strpcopy(pszText, Node.Text);
              end;
              if (ToolTipHandle <> 0) and (LastHintNode<>Node) then
              begin
                 FreeHintWindow;
                 sp:= self.ClientToScreen(Point(0, 0));
                 DisplayRect:= Node.DisplayRect(True);
                 R.Left:= DisplayRect.Left + sp.x - 1;
                 R.Top:= DisplayRect.Top + sp.y - 2;
                 R.Right:= R.Left + FPaintCanvas.TextWidth(Node.Text) + 6;
                 R.Bottom:= R.Top + FPaintCanvas.TextHeight(Node.Text) + 2;

                 if DisplayRect.Left+FPaintCanvas.TextWidth(Node.Text)>
                    GetEffectiveWidth then
                 begin
                    LastHintNode:= Node;
                    HintWindow:= CreateHintWindow;
                    HintWindow.ActivateHint(R, Node.Text);
                 end
                 else LastHintNode:= nil;
              end

           end;
        end;}
    end;
end;

function TfcCustomTreeView.GetDragImages: {$ifdef fcDelphi4Up}TDragImageList{$else}TCustomImageList{$endif};
begin
  if (FDragImage <> nil) and (FDragImage.Count > 0) then // Added check to make sure FDragImage is not nil -ksw (11/30/98)
    Result := FDragImage else
    Result := nil;
end;

procedure TfcCustomTreeView.WndProc(var Message: TMessage);
begin
{   if (csDesigning in ComponentState) then
   begin
      if (Message.Msg = wm_lbuttondown) or (Message.Msg = wm_vscroll) then
      begin
         ControlState := ControlState + [csLButtonDown];
         Dispatch(Message);
         exit;
      end;
   end;
}
  {$ifdef fcDelphi4Up}
  if not (csDesigning in ComponentState) and ((Message.Msg = WM_LBUTTONDOWN) or
    (Message.Msg = WM_LBUTTONDBLCLK)) and not Dragging and
    (DragMode = dmAutomatic) and (DragKind = dkDrag) then
  begin
    if not IsControlMouseMsg(TWMMouse(Message)) then
    begin
      ControlState := ControlState + [csLButtonDown];
      Dispatch(Message);
    end;
  end
  else inherited WndProc(Message);
  {$else}
  inherited WndProc(Message);
  {$endif}
end;

procedure TfcCustomTreeView.DoStartDrag(var DragObject: TDragObject);
var
  ImageHandle: HImageList;
  DragNode: TfcTreeNode;
  P: TPoint;
begin
  inherited DoStartDrag(DragObject);
  DragNode := FDragNode;
  FLastDropTarget := nil;
  FDragNode := nil;
  if DragNode = nil then
  begin
    GetCursorPos(P);
    with ScreenToClient(P) do DragNode := GetNodeAt(X, Y);
  end;
  if DragNode <> nil then
  begin
    ImageHandle := TreeView_CreateDragImage(Handle, DragNode.ItemId);
    if ImageHandle <> 0 then
      with FDragImage do
      begin
        Handle := ImageHandle;
        SetDragImage(0, 2, 2);
      end;
  end;
end;

procedure TfcCustomTreeView.DoEndDrag(Target: TObject; X, Y: Integer);
begin
  inherited DoEndDrag(Target, X, Y);
  FLastDropTarget := nil;
end;

procedure TfcCustomTreeView.CMDrag(var Message: TCMDrag);
begin
  inherited;
  with Message, DragRec^ do
    case DragMessage of
      dmDragMove:
        with ScreenToClient(Pos) do
          DoDragOver(Source, X, Y, Message.Result <> 0);
      dmDragLeave:
        begin
          TDragObject(Source).HideDragImage;
          FLastDropTarget := DropTarget;
          DropTarget := nil;
          TDragObject(Source).ShowDragImage;
        end;
      dmDragDrop: FLastDropTarget := nil;
    end;
end;

procedure TfcCustomTreeView.DoDragOver(Source: TDragObject; X, Y: Integer; CanDrop: Boolean);
var
  Node: TfcTreeNode;
begin
  Node := GetNodeAt(X, Y);
  if (Node <> nil) and
    ((Node <> DropTarget) or (Node = FLastDropTarget)) then
  begin
    FLastDropTarget := nil;
    TDragObject(Source).HideDragImage;
    Node.DropTarget := True;
    TDragObject(Source).ShowDragImage;
  end;
end;

procedure TfcCustomTreeView.GetImageIndex(Node: TfcTreeNode);
begin
  if Assigned(FOnGetImageIndex) then FOnGetImageIndex(Self, Node);
end;

procedure TfcCustomTreeView.GetSelectedIndex(Node: TfcTreeNode);
begin
  if Assigned(FOnGetSelectedIndex) then FOnGetSelectedIndex(Self, Node);
end;

function TfcCustomTreeView.CanChange(Node: TfcTreeNode): Boolean;
begin
  Result := True;
  if Assigned(FOnChanging) then FOnChanging(Self, Node, Result);
end;

procedure TfcCustomTreeView.Change(Node: TfcTreeNode);
begin
  if Assigned(FOnChange) then FOnChange(Self, Node);
end;

procedure TfcCustomTreeView.Delete(Node: TfcTreeNode);
begin
  if Assigned(FOnDeletion) then FOnDeletion(Self, Node);
  if Assigned(FOnItemChange) then FOnItemChange(self, Node, icaDelete, NULL);
end;

procedure TfcCustomTreeView.Expand(Node: TfcTreeNode);
begin
  if Assigned(FOnExpanded) then FOnExpanded(Self, Node);
end;

function TfcCustomTreeView.CanExpand(Node: TfcTreeNode): Boolean;
begin
  Result := True;
  if Assigned(FOnExpanding) then FOnExpanding(Self, Node, Result);

  { 5/21/99 - Complete editing  }
  if IsEditing and (Selected<>nil) and
     (Selected.HasAsParent(Node) or (Selected=Node)) then
  begin
     Selected.EndEdit(False);
     result:= False;
  end;
  if InLoading then result:= False;

end;

procedure TfcCustomTreeView.Collapse(Node: TfcTreeNode);
begin
  if Assigned(FOnCollapsed) then FOnCollapsed(Self, Node);
end;

function TfcCustomTreeView.CanCollapse(Node: TfcTreeNode): Boolean;
begin
  Result := True;
  if Assigned(FOnCollapsing) then FOnCollapsing(Self, Node, Result);

  { 5/21/99 - Complete editing  }
  if IsEditing and (Selected<>nil) and
     (Selected.HasAsParent(Node) or (Selected=Node)) then
  begin
     Selected.EndEdit(False);
     result:= False;
  end
end;

function TfcCustomTreeView.CanEdit(Node: TfcTreeNode): Boolean;
begin
  Result := True;
  if Assigned(FOnEditing) then FOnEditing(Self, Node, Result);
end;

procedure TfcCustomTreeView.Edit(const Item: TTVItem);
var
  S: string;
  Node: TfcTreeNode;
begin
  with Item do
    if pszText <> nil then
    begin
      S := pszText;
      Node := GetNodeFromItem(Item);
      if Assigned(FOnEdited) then FOnEdited(Self, Node, S);
      if Node <> nil then Node.Text := S;
      EditNode := Nil;
    end;
end;

function TfcCustomTreeView.CreateNode: TfcTreeNode;
begin
  Result := NodeClass.Create(Items);
  if Assigned(OnItemChange) then OnItemChange(self, result, icaAdd, NULL);
end;

procedure TfcCustomTreeView.SetImageList(Value: HImageList; Flags: Integer);
begin
  if HandleAllocated then TreeView_SetImageList(Handle, Value, Flags);
end;

procedure TfcCustomTreeView.ImageListChange(Sender: TObject);
var
  ImageHandle: HImageList;
begin
  if HandleAllocated then
  begin
    if TCustomImageList(Sender).HandleAllocated then
      ImageHandle := TCustomImageList(Sender).Handle
    else
      ImageHandle := 0;
    if Sender = Images then
      SetImageList(ImageHandle, TVSIL_NORMAL)
    else if Sender = StateImages then
      SetImageList(ImageHandle, TVSIL_STATE);
  end;
end;

procedure TfcCustomTreeView.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin
    if AComponent = Images then Images := nil;
    if AComponent = StateImages then StateImages := nil;
  end;
end;

procedure TfcCustomTreeView.ResetStateImages;
var Node: TfcTreeNode;
begin
   if Images<>nil then begin
      Node := Items.GetFirstNode;
      while Node <> nil do
      begin
          if (Node.StateIndex <>(Node.GetStateIndex shr 12) -1) then
            Node.StateIndex:= Node.StateIndex;
          Node := Node.GetNext;
      end
   end
end;

procedure TfcCustomTreeView.SetImages(Value: TCustomImageList);
begin
  if Images <> nil then
    Images.UnRegisterChanges(FImageChangeLink);
  FImages := Value;
  if Images <> nil then
  begin
    Images.RegisterChanges(FImageChangeLink);
    Images.FreeNotification(Self);
    SetImageList(Images.Handle, TVSIL_NORMAL);

    { Imagelist changing after nodes loaded causes stateindex to no longer be -1 }
    { Therefore scan all nodes and reset the ones that are incorrect }

    { 2/1/99 - Reset state images due to Microsoft TreeView resetting StateImage list }
    if StateImages <> nil then
    begin
      SetImageList(StateImages.Handle, TVSIL_STATE)
    end;

    ResetStateImages;
//    if not (csLoading in ComponentState) then RecreateWnd; // 2/2/99
  end
  else SetImageList(0, TVSIL_NORMAL);
end;

procedure TfcCustomTreeView.SetStateImages(Value: TCustomImageList);
var PrevStateImages: TCustomImageList;
begin
  PrevStateImages:= StateImages;
  if StateImages <> nil then
    StateImages.UnRegisterChanges(FStateChangeLink);
  FStateImages := Value;
  if StateImages <> nil then
  begin
    StateImages.RegisterChanges(FStateChangeLink);
    StateImages.FreeNotification(Self);
    SetImageList(StateImages.Handle, TVSIL_STATE)
  end;

//  else SetImageList(0, TVSIL_STATE);
  if PrevStateImages<>Value then
  begin
     if (Value=Nil) then
     begin
       TreeView_SetImageList(Handle, FFixBugImageList.Handle, TVSIL_STATE);
       RecreateWnd;
     end
  end

end;

procedure TfcCustomTreeView.LoadFromFile(const FileName: string);
var
  Stream: TStream;
begin
  Stream := TFileStream.Create(FileName, fmOpenRead);
  try
    LoadFromStream(Stream);
  finally
    Stream.Free;
  end;
end;

procedure TfcCustomTreeView.LoadFromStream(Stream: TStream);
begin
   Stream.Position := 0;
   Items.ReadData(Stream);
{  with TTreeStrings.Create(Items) do
    try
      LoadTreeFromStream(Stream);
    finally
      Free;
  end;}
end;

procedure TfcCustomTreeView.SaveToFile(const FileName: string);
var
  Stream: TStream;
begin
  Stream := TFileStream.Create(FileName, fmCreate);
  try
     SaveToStream(Stream);
  finally
     Stream.Free;
  end;
end;

procedure TfcCustomTreeView.SaveToStream(Stream: TStream);
begin
    Items.WriteData(Stream);
{  with TTreeStrings.Create(Items) do
    try
      SaveTreeToStream(Stream);
    finally
      Free;
  end;}
end;

procedure TfcCustomTreeView.WMRButtonDown(var Message: TWMRButtonDown);
begin
  InvalidateNoErase; { 4/21/99 - Workaround for Microsoft Tree bug which causes last
                                 node to not paint correctly  }
  inherited;
end;

procedure TfcCustomTreeView.WMRButtonUp(var Message: TWMRButtonUp);
begin
  inherited;
end;

procedure TfcCustomTreeView.WMLButtonDown(var Message: TWMLButtonDown);
var
  {$ifdef fcDelphi4Up}
  Node: TfcTreeNode;
  {$endif}
  MousePos, SP: TPoint;
  hitTest: TfcHitTests;
begin
   GetCursorPos(MousePos);
   SP:= ScreenToClient(MousePos);
   hitTest:= GetHitTestInfoAt(sp.x, sp.y);
   BeforeMouseDownNode:= Selected;

   if (fchtOnButton in hitTest) {and (ssLeft in Shift) }then
   begin
      if tvoExpandButtons3D in Options then
      begin
         MouseNode:= GetNodeAt(sp.x, sp.y) as TfcTreeNode;
         MouseLoop(sp.x, sp.y);
         MouseNode:= nil;
         exit;
      end
   end;

  { 7/3/99 - Only call Invalidate if not in expanding/collapsing}
  if not (fchtOnButton in hitTest) then
    InvalidateNoErase; { 4/21/99 - Workaround for Microsoft Tree bug which causes last
                                 node to not paint correctly  }
  {$ifdef fcDelphi4Up}
  FDragged := False;
  FDragNode := nil;
  try
    inherited;
    if (DragMode = dmAutomatic) and (DragKind = dkDrag) then
    begin
      SetFocus;
      if not FDragged then
      begin
        GetCursorPos(MousePos);
        with PointToSmallPoint(ScreenToClient(MousePos)) do
          Perform(WM_LBUTTONUP, 0, MakeLong(X, Y));
      end
      else begin
        Node := GetNodeAt(Message.XPos, Message.YPos);
        if Node <> nil then
        begin
          Node.Focused := True;
          Node.Selected := True;
          BeginDrag(False);
        end;
      end;
    end;
  finally
    FDragNode := nil;
  end;
  {$else}
  inherited;
  {$endif}

end;

procedure TfcCustomTreeView.WMNotify(var Message: TWMNotify);
var
  Node: TfcTreeNode;
  MaxTextLen: Integer;
  Pt: TPoint;
begin
  with Message do
    if NMHdr^.code = TTN_NEEDTEXTW then
    begin
      // Work around NT COMCTL32 problem with tool tips >= 80 characters
      GetCursorPos(Pt);
      Pt := ScreenToClient(Pt);
      Node := GetNodeAt(Pt.X, Pt.Y);
      if (Node = nil) or (Node.Text = '') or
        (PToolTipTextW(NMHdr)^.uFlags and TTF_IDISHWND = 0) then Exit;
      if (fcGetComCtlVersion >= fcComCtlVersionIE4) and (Length(Node.Text) < 80) then
      begin
        inherited;
        Exit;
      end;
      FWideText := Node.Text;
      MaxTextLen := SizeOf(PToolTipTextW(NMHdr)^.szText) div SizeOf(WideChar);
      if Length(FWideText) >= MaxTextLen then
        SetLength(FWideText, MaxTextLen - 1);
      PToolTipTextW(NMHdr)^.lpszText := PWideChar(FWideText);
      FillChar(PToolTipTextW(NMHdr)^.szText, MaxTextLen, 0);
      Move(Pointer(FWideText)^, PToolTipTextW(NMHdr)^.szText, Length(FWideText) * SizeOf(WideChar));
      PToolTipTextW(NMHdr)^.hInst := 0;
      SetWindowPos(NMHdr^.hwndFrom, HWND_TOP, 0, 0, 0, 0, SWP_NOACTIVATE or
        SWP_NOSIZE or SWP_NOMOVE or SWP_NOOWNERZORDER);
      Result := 1;
    end
    else inherited;
end;

{ CustomDraw support }

procedure TfcCustomTreeView.CanvasChanged;
begin
  FCanvasChanged := True;
end;

{function TfcCustomTreeView.IsCustomDrawn(Target: TCustomDrawTarget;
  Stage: TCustomDrawStage): Boolean;
begin
  result:= True;
end;
}
//function TfcCustomTreeView.CustomDraw(const ARect: TRect; Stage: TCustomDrawStage): Boolean;
//begin
//  Result := True;
//  if Assigned(FOnCustomDraw) then FOnCustomDraw(Self, ARect, Result);
//end;

//function TfcCustomTreeView.CustomDrawItem(Node: TfcTreeNode; State: TCustomDrawState;
//  Stage: TCustomDrawStage): Boolean;
//begin
//  Result := True;
//  if Assigned(FOnCustomDrawItem) then FOnCustomDrawItem(Self, Node, State, Result);
//end;

procedure TfcTreeNode.SetCheckboxType(val: TfcTreeViewCheckboxType);
begin
   if (val<>FCheckboxType) {or (StateIndex>1) }then  {4/26/99 - RSW Don't reset state index }
   begin
      FCheckboxType:= val;
      if val<>tvctNone then
         StateIndex:= 1
      else
         StateIndex:= -1
   end
end;

function TfcTreeNode.GetMultiSelected: Boolean;
begin
  result := FMultiSelected {or (TreeView.MultiSelectAttributes.AlwaysIncludeSelectedItem and Selected)};
end;

procedure TfcCustomTreeView.DoToggleCheckbox(Node: TfcTreeNode);
begin
   if Assigned(OnToggleCheckbox) then FOnToggleCheckbox(self, Node);
end;

procedure TfcTreeNode.SetChecked(val : boolean);
var curNode: TfcTreeNode;
begin
   if FChecked<>val then
   begin
      FChecked:= val;
      if self.IsRadioGroup then
      begin
         if val=False then exit;

         { Unselect all siblings }
         CurNode:= Treeview.GetFirstSibling(Self);
         while curNode<>Nil do begin
            if CurNode<>self then begin
               curNode.checked:= False;
               Treeview.InvalidateNode(CurNode);
            end;
            curNode:= TfcTreeNode(curNode.GetNextSibling);
         end;
      end
      else if TreeView.MultiSelectCheckboxNeeded(self) then MultiSelected:= val;
      Treeview.InvalidateNode(self);
      TreeView.DoToggleCheckbox(self);
   end;
end;

procedure TfcTreeNode.SetGrayed(val : boolean);
var curNode: TfcTreeNode;
begin
   if FGrayed<>val then
   begin
      FGrayed:= val;
      if self.IsRadioGroup then
      begin
         { Toggle gray for all siblings }
         CurNode:= Treeview.GetFirstSibling(Self);
         while curNode<>Nil do begin
            if CurNode<>self then begin
               curNode.Grayed:= val;
               Treeview.InvalidateNode(CurNode);
            end;
            curNode:= TfcTreeNode(curNode.GetNextSibling);
         end;
      end;
      Treeview.InvalidateNode(self);
   end;
end;

procedure TfcTreeNode.SetMultiSelected(Value: Boolean);
begin
  if MultiSelected <> Value then
  begin
    TreeView.MultiSelectNode(self, Value, true);  // This method will set the FMultiSelect var
  end;
end;

function TfcTreeNode.GetStateIndex: integer;
var
  Item: TTVItem;
begin
  with Item do
  begin
    mask := TVIF_STATE or TVIF_HANDLE;
    stateMask := TVIS_STATEIMAGEMASK;
    hItem := ItemId;
//    state := IndexToStateImageMask(Value + 1);
  end;
  TreeView_GetItem(Handle, Item);
  result:= Item.state;
end;

Function TfcTreeNode.IsRadioGroup: boolean;
begin
   result:= CheckboxType=tvctRadioGroup;
end;

Function TfcTreeNode.GetSortText: string;
begin
   with TreeView do begin
      result:= Text;
   end
end;

constructor TfcTVMultiSelectAttributes.Create(Owner: TComponent);
begin
   TreeView:= Owner as TfcCustomTreeView;
   FMultiSelectCheckbox:= True;
//   FAlwaysIncludeSelectedItem := False;
   FAutoUnselect:= True;
end;

procedure TfcTVMultiSelectAttributes.Assign(Source: TPersistent);
var tsa: TfcTVMultiSelectAttributes;
begin
   If Source is TfcTVMultiSelectAttributes then
   begin
      tsa:= TfcTVMultiSelectAttributes(Source);
      Enabled:= tsa.Enabled;
      MultiSelectCheckbox:= tsa.MultiSelectCheckbox;
      MultiSelectLevel:= tsa.MultiSelectLevel;
   end
   else inherited Assign(Source);
end;

procedure TfcTVMultiSelectAttributes.SetEnabled(val: boolean);
var Node: TfcTreeNode;
begin
   if val<>FEnabled then
   begin
      if FEnabled=True then
      begin
         { Set all Stateimages of 1 to -1 unless checkboxType is checkbox}
         Node := TreeView.Items.GetFirstNode;
         while Node <> nil do
         begin
//             if (Node.StateIndex=1) and (Node.ShowCheckbox<>0) and
             if (Node.StateIndex=1) and (Node.CheckboxType=tvctNone) and
               (TreeView.ValidMultiSelectLevel(Node.Level)) then
                 Node.StateIndex:= -1;
             Node := TfcTreeNode(Node.GetNext);
         end;
      end;

      FEnabled:= val;
      TreeView.invalidate;
   end
end;

procedure TfcTVMultiSelectAttributes.SetMultiSelectCheckBox(val: boolean);
begin
   if val<>FMultiSelectCheckbox then
   begin
      FMultiSelectCheckbox:= val;
      if not val then Treeview.ClearStateImageIndexes;
      TreeView.invalidate;
   end
end;

procedure TfcTVMultiSelectAttributes.SetMultiSelectLevel(val: integer);
begin
   if val<>FMultiSelectLevel then
   begin
      FMultiSelectLevel:= val;
      (TreeView as TfcCustomTreeView).UnselectAllNodes(Nil);
      if val>=0 then Treeview.ClearStateImageIndexes;
      TreeView.Invalidate;
   end
end;

function TfcCustomTreeView.ValidMultiSelectLevel(ALevel: Integer): Boolean;
begin
  result := (FMultiSelectAttributes.MultiSelectLevel = ALevel) or
            (FMultiSelectAttributes.MultiSelectLevel = -1);
end;

Procedure TfcCustomTreeView.UnselectAll;
begin
   UnselectAllNodes(nil);
end;

Procedure TfcCustomTreeView.UnselectAllNodes(IgnoreNode: TfcTreeNode);
var curNode: TfcTreeNode;
    i: integer;
begin
   for i:= 0 to FMultiSelectList.count-1 do begin
      curNode:= TfcTreeNode(FMultiSelectList[i]);
      if (curNode<>IgnoreNode) then begin
         curNode.FMultiSelected:= False;
         if FMultiSelectAttributes.MultiSelectCheckbox then
           curNode.checked:= False;
         if IsVisible(curNode, True) then begin
            InvalidateNode(curNode);
         end
      end
   end;
   FMultiSelectList.Clear;
   if IgnoreNode<>nil then FMultiSelectList.Add(IgnoreNode);
end;

procedure TfcCustomTreeView.MultiSelectNode(Node: TfcTreeNode; Select: boolean; redraw: boolean);
begin
   if (not ValidMultiSelectLevel(Node.Level)) {and
      (FMultiSelectAttributes.MultiSelectLevel>=0)} then exit;

   if FMultiSelectAttributes.MultiSelectCheckbox then
      (Node as TfcTreeNode).checked:= Select;

   if (Select <> (Node as TfcTreeNode).FMultiSelected) then
   begin
      if Select then FMultiSelectList.Add(Node)
      else FMultiSelectList.Remove(Node);

      (Node as TfcTreeNode).FMultiSelected:= Select;

      if redraw and IsVisible(Node, True) then begin
         InvalidateNode(Node);
      end
   end
end;

function TfcCustomTreeView.IsVisible(Node: TfcTreeNode; PartialOK: Boolean): Boolean;
var r: TRect;
    i: integer;
begin
  r := ItemRect(Node, True);
  if PartialOK then i := r.Top else i := r.Bottom;
  result := (i < Height - FBorderWidth * 2) and
            (r.Bottom>0)
end;

Procedure TfcCustomTreeView.InvalidateNode(Node: TfcTreeNode);
var r: TRect;
begin
    if Node=nil then exit;
    r := ItemRect(Node, False);
    if (r.Left=r.right) then exit;
    InvalidateRect(Handle, @r, False);
end;

function TfcCustomTreeView.LevelRect(ANode: TfcTreeNode): TRect;
const wwIMAGEMARGIN = 4;
begin
  result := ItemRect(ANode, True);
  result.Right := result.Left+0;
  result.Left := result.Left+0 - FIndent;
  if UseImages(ANode) then
     OffSetRect(result, -(TImageList(Images).Width + 2{ + wwIMAGEMARGIN}), 0);

  { 3/8/99 - Don't allow state images that are a multple of 16, as Microsoft does not currently support this }
  if UseStateImages(ANode) or
     ((ANode.StateIndex>0) and ((ANode.StateIndex mod 16)<>0)) then
  begin
     if StateImages<>Nil then
        OffsetRect(result, -TImageList(StateImages).Width, 0)
     else
        OffsetRect(result, -TImageList(FFixBugImageList).Width, 0);
  end;

  if UseImages(ANode) {and
     not (UseStateImages(ANode) or (ANode.StateIndex>0)) }then begin
     result.Left:= result.Left + 1;
     result.Right:= result.Right + 1;
  end

end;

function TfcCustomTreeView.ItemRect(Node: TfcTreeNode; LabelOnly: Boolean): TRect;
begin
  result := Rect(0,0,0,0);
  if Node = nil then Exit;
  result := Node.DisplayRect(LabelOnly);
end;

Function TfcCustomTreeView.GetFirstSibling(Node: TfcTreeNode): TfcTreeNode;
var parentNode: TfcTreeNode;
begin
   if Node=Nil then
      parentNode:= Node
   else
      parentNode:= Node.parent;

   if parentNode=nil then
       result := Items.GetFirstNode as TfcTreeNode
   else
       result := TfcTreeNode(parentNode.GetFirstChild);
end;

procedure TfcCustomTreeView.DoDrawText(TreeView: TfcCustomTreeView;
         Node: TfcTreeNode; ARect: TRect; AItemState: TfcItemStates;
         var DefaultDrawing: boolean);
begin
   DefaultDrawing:= True;
   if Assigned(FOnDrawText) then FOnDrawText(Self, Node, ARect, AItemState, defaultDrawing); // -ksw (Added Canvas parameter)
end;

procedure TfcCustomTreeView.Compare(Node1, Node2: TfcTreeNode;
   lParam: integer; var Result: integer);
begin
   if Assigned(OnCompare) then
      OnCompare(self, Node1, Node2, lParam, Result)
   else
      Result := lstrcmp(PChar(Node1.Text), PChar(Node2.Text));
end;

function TfcCustomTreeView.GetDisplayText(Node: TfcTreeNode): string;
begin
   result:= node.text;
end;

procedure TfcCustomTreeView.LoadCanvasDefaults(Node: TfcTreeNode; AItemState: TfcItemStates);
begin
    FPaintCanvas.Font.Assign(Font);
    FPaintCanvas.Brush.Color := Color;

    if (fcisSelected in AItemState) and not (tvoHideSelection in Options) then
       FPaintCanvas.Brush.Color := clBtnFace;
    if (((fcisSelected in AItemState) and ((DropTarget = nil) or (DropTarget = Node))) or Node.DropTarget)
       and not FMultiSelectAttributes.enabled then
    begin
       if Focused then begin
          FPaintCanvas.Brush.Color := clHighlight;
          FPaintCanvas.Font.Color := clHighlightText;
       end
       else if not (tvoHideSelection in Options) then begin
           if InactiveFocusColor<>Color then
              FPaintCanvas.Brush.Color:= InactiveFocusColor
           else
              FPaintCanvas.Brush.Color:= clGray;
          FPaintCanvas.Font.Color:= Font.Color;
       end
    end
    else if FMultiSelectAttributes.enabled then
    begin
       if (Node as TfcTreeNode).FMultiSelected then
       begin
          FPaintCanvas.Brush.Color := clHighlight;
          FPaintCanvas.Font.Color := clHighlightText;
       end
       else begin
          FPaintCanvas.Brush.Color := Color;
          FPaintCanvas.Font.Color := Font.Color;
       end
    end
    else begin
      FPaintCanvas.Brush.Color := Color;
      FPaintCanvas.Font.Color := Font.Color;
    end;

end;

procedure fcTreeViewError(const Msg: string);
begin
  raise EfcTreeViewError.Create(Msg);
end;

function TfcCustomTreeView.ProcessKeyPress(Key: char; shift: TShiftState): boolean;
begin
   result:= false;
end;

function TfcCustomTreeView.IsRowSelect: boolean;
begin
   result:= tvoRowSelect in Options;
//   result:= tvoRowSelect in Options;
end;

procedure TfcCustomTreeView.BeginItemPainting(Node: TfcTreeNode; ARect: TRect; AItemState: TfcItemStates);
begin
end;

procedure TfcCustomTreeView.EndPainting;
var r: TRect;
    state: TfcItemStates;
begin
  { workaround for TreeView bug in Microsoft control when there is exactly one
    item displayed }
  if (Items.Count>0) and (DisplayedItems=0) and True then
  begin
     r := Items[0].DisplayRect(True);
     state:= [fcisSelected];
     if focused then
        state:= state + [fcisFocused];
     EndItemPainting(Items[0], r, state);
  end;

  if Items.Count>0 then begin { 1/24/99 -
                                If no records, then clearing done by erasebckground message
                                Don't rely upn paintcanvas as BeginPainting may not be called
                                if Items.Count is 0. }
    r := ClientRect;
    OffsetRect(r, 1, 0);
    FCanvas.CopyMode:= cmSrcCopy;
    FCanvas.CopyRect(
     Rect(0,0,FPaintCanvas.ClipRect.Right,FPaintCanvas.ClipRect.Bottom),
     FPaintCanvas, FPaintCanvas.ClipRect);
  end;

end;

procedure TfcCustomTreeView.BeginPainting;
begin
  { Ensure that stateimages does not have exactly 1 image when painting a checkbox}
  { A bug in the Microsoft Tree control causs a gpf when there is exactly 1 state image when
    clicking on a checkbox }
  if (StateImages<>Nil) and (StateImages.Count=1) and
     not (csDesigning in ComponentState) then
  begin
    StateImages.Clear;
    TreeView_SetImageList(Handle, FFixBugImageList.Handle, TVSIL_STATE);
  end;

  { Fill with background color }
  FPaintBitmap.Width := Width;
  FPaintBitmap.Height := Height;
  FPaintBitmap.Canvas.Brush.Color := color;
  FPaintBitmap.Canvas.FillRect(Rect(0, 0, FPaintBitmap.Width, FPaintBitmap.Height));
end;

procedure TfcCustomTreeView.CalcNodeAttributes(Node: TfcTreeNode; AItemState: TfcItemStates);
begin
    if Assigned(FOnCalcNodeAttributes) then
      FOnCalcNodeAttributes(Self, Node as TfcTreeNode, AItemState);
end;

procedure TfcCustomTreeView.EndItemPainting(Node: TfcTreeNode; ARect: TRect; AItemState: TfcItemStates);
const HDM_ORDERTOINDEX = HDM_FIRST + 15;
      HDM_GETORDERARRAY = HDM_FIRST + 17;
      DrawTextUnderscoreStyles: array[Boolean] of Integer = (DT_NOPREFIX, 0);
      wwTEXTPADDING = 4;
var r, FocusRect: TRect;
    DefaultDrawing: boolean;
begin
  { Imagelist changing after nodes loaded causes stateindex to no longer be -1 }
  if (Node.StateIndex <>(Node.GetStateIndex shr 12) -1) then
  begin
     Node.StateIndex:= Node.StateIndex;
//     exit;  { RSW - Don't paint now, let Microsoft control paint this later}
  end;

  PaintLines(Node);
  if MultiSelectCheckBoxNeeded(Node) then Node.StateIndex:= 1;

  LoadCanvasDefaults(Node, AItemState);
  if (fcisHot in AItemState) or
     ((tvoAutoURL in Options) and (Node.StringData<>'')) then
  begin
     if not (fcisSelected in AItemState) or not Focused then { 4/8/99 - No focus still paint clBlue }
        FPaintCanvas.Font.Color:= clBlue;
     FPaintCanvas.Font.Style:= [fsUnderline];
  end;

  CalcNodeAttributes(Node, AItemState);
  FPaintCanvas.Refresh;

  TreeView_GetItemRect(Handle, Node.ItemID, r, False);
  r.Left := ARect.Left;

  if FPaintCanvas.Font.Style * [fsBold, fsItalic] <> [] then
    ARect := Rect(ARect.Left, ARect.Top, ARect.Left +
                  FPaintCanvas.TextWidth(GetDisplayText(Node)) + wwTEXTPADDING, ARect.Bottom);

  FPaintCanvas.Pen.Color := Color;

  FocusRect:= ARect;

  if IsRowSelect then
  begin
    FocusRect.Right:= Width-4;
    if UseImages(node) then dec(FocusRect.Left, TImageList(Images).Width);
    if UseStateImages(node) then begin
       if StateImages<>nil then
          dec(FocusRect.Left, TImageList(StateImages).Width)
       else
          dec(FocusRect.Left, FixBugImageListSize)
    end;
    if UseImages(node) or UseStateImages(node) then dec(FocusRect.Left, 4);
    if not MultiSelectAttributes.enabled then
       FocusRect.Bottom := FocusRect.Bottom + 1;
  end;

  if (not IsEditing) or not (fcIsSelected in AItemState) then
  begin
    if (FPaintCanvas.Brush.Color <> clNone) and
       ((not MultiSelectAttributes.enabled) or Node.MultiSelected) then
    begin
      if (fcisFocused in AItemState) then
         FPaintCanvas.Rectangle(FocusRect.Left, FocusRect.Top, FocusRect.Right, FocusRect.Bottom)
      else begin
         FocusRect.bottom:= FocusRect.Bottom - 1;
         FPaintCanvas.FillRect(FocusRect);
         FocusRect.bottom:= FocusRect.Bottom + 1;
      end
    end
  end;

  PaintImage(Node, AItemState);

  InflateRect(ARect, -1, -1);
  ARect.Left:= ARect.Left + 1;
  SetBkMode(FPaintCanvas.Handle, TRANSPARENT);

  try
     if (not IsEditing) or not (fcIsSelected in AItemState) then
     begin
        DoDrawText(self, Node, ARect, AItemState, DefaultDrawing);
        if DefaultDrawing then begin
           FPaintCanvas.DrawText(GetDisplayText(Node), ARect, DT_END_ELLIPSIS or DrawTextUnderscoreStyles[False]);
           if (fcisFocused in AItemState) and Focused and
               ((not IsRowSelect) or MultiSelectAttributes.enabled) then
           begin
              FPaintCanvas.DrawFocusRect(FocusRect);
           end
        end
     end
  finally
     SetBkMode(FPaintCanvas.Handle, OPAQUE);
  end
end;

(*
procedure TfcCustomTreeView.EndItemPainting(Node: TfcTreeNode; ARect: TRect; AItemState: TfcItemStates);
const HDM_ORDERTOINDEX = HDM_FIRST + 15;
      HDM_GETORDERARRAY = HDM_FIRST + 17;
      DrawTextUnderscoreStyles: array[Boolean] of Integer = (DT_NOPREFIX, 0);
      fcTEXTPADDING = 4;
var r: TRect;
    DefaultDrawing: boolean;
begin
  { Imagelist changing after nodes loaded causes stateindex to no longer be -1 }
  if (Node.StateIndex <>(Node.GetStateIndex shr 12) -1) then
  begin
     Node.StateIndex:= Node.StateIndex;
  end;

  PaintLines(Node);
  if MultiSelectCheckBoxNeeded(Node) then Node.StateIndex:= 1;

  LoadCanvasDefaults(Node, AItemState);
  CalcNodeAttributes(Node, AItemState);
  FPaintCanvas.Refresh;

  if FPaintCanvas.Font.Style * [fsBold, fsItalic] <> [] then
    ARect := Rect(ARect.Left, ARect.Top, ARect.Left +
                  FPaintCanvas.TextWidth(GetDisplayText(Node)) + fcTEXTPADDING, ARect.Bottom);

  fPaintCanvas.Pen.Color := Color;

  r := ARect;

  if RowSelect then
  begin
    ARect.Left := LevelRect(Node).Left;
    ARect.Right := Width;
  end;
  if fPaintCanvas.Brush.Color <> clNone then
  begin
    if (isFocused in AItemState) then
       fPaintCanvas.Rectangle(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom)
    else fPaintCanvas.FillRect(ARect);
  end;
  if RowSelect then ARect.Left := r.Left;

  PaintImage(Node, AItemState);
  TreeView_GetItemRect(Handle, Node.ItemID, r, False);
  r.Left := ARect.Left;


  InflateRect(ARect, -1, -1);
  SetBkMode(fPaintCanvas.Handle, TRANSPARENT);

  try
     DoDrawText(self, Node, ARect, AItemState, DefaultDrawing);
     if DefaultDrawing then begin
        fPaintCanvas.DrawText(GetDisplayText(Node), ARect, DT_END_ELLIPSIS or DrawTextUnderscoreStyles[tvoUnderscoreAllowed in FOptions]);
        if (isFocused in AItemState) and Focused then begin
           InflateRect(ARect, 1, 1);
           fPaintCanvas.Brush.Color := clBlack;
           SetTextColor(fPaintCanvas.Handle, clWhite);
           fPaintCanvas.DrawFocusRect(ARect);
        end
     end
  finally
     SetBkMode(fPaintCanvas.Handle, OPAQUE);
  end
end;
*)

procedure TfcCustomTreeView.PaintButton(Node: TfcTreeNode;
   pt: TPoint; Size: integer);
var offset: integer;
    drawRect: TRect;
    OrigColor: TColor;
    StateFlags: Word;
begin
   OrigColor:= FPaintCanvas.Brush.Color;
   if not (tvoShowButtons in Options) then Exit;
   offset:= Size;
   Offset:= Offset div 2;

   DrawRect.Left:= pt.x - offset;
   DrawRect.Right:= pt.x + offset+1;
   DrawRect.Top:= pt.y-offset;
   DrawRect.Bottom:= pt.y+offset+1;

   if tvoExpandButtons3D in Options then
   begin
      FPaintCanvas.Brush.Color := clBtnFace;
      FPaintCanvas.FillRect(DrawRect);
      FPaintCanvas.Brush.Color := clBtnShadow;

      StateFlags:= DFCS_BUTTONPUSH;
      if Down and (MouseNode=Node) then
         StateFlags := StateFlags or DFCS_PUSHED;

      with DrawRect do
         DrawFrameControl(FPaintCanvas.Handle, Rect(Left, Top, Right+1, Bottom+1),
              DFC_BUTTON, StateFlags);
      if ColorToRGB(Color)=clWhite then
      begin
         with DrawRect, FPaintCanvas do begin
           Pen.Color := clBtnFace;
           Polyline([Point(Left-1, Bottom), Point(Left-1, Top-1), Point(Right+1, Top-1)]);
         end;
      end;

      if Down and (MouseNode = Node) then
      begin
         pt.x:= pt.x+1;
         pt.y:= pt.y+1;
         DrawRect.Left:= DrawRect.Left + 1;
         DrawRect.Top:= DrawRect.Top + 1;
         DrawRect.Right:= DrawRect.Right + 1;
         DrawRect.Bottom:= DrawRect.Bottom + 1;
      end;

      FPaintCanvas.Brush.Color := Color;

      FPaintCanvas.Pen.Color := clBlack;
      if not Node.Expanded then
         FPaintCanvas.Polyline([Point(pt.x, DrawRect.Top+Offset div 2), Point(pt.x, DrawRect.Bottom-Offset div 2)]);
      FPaintCanvas.Polyline([Point(DrawRect.Left+Offset div 2, pt.y), Point(DrawRect.Right-Offset div 2, pt.y)]);

      FPaintCanvas.Brush.Color:= OrigColor;
   end
   else begin
      FPaintCanvas.Brush.Color := clWhite;
      FPaintCanvas.FillRect(DrawRect);
      FPaintCanvas.Brush.Color := clBtnShadow;
      FPaintCanvas.FrameRect(DrawRect);
      FPaintCanvas.Brush.Color := Color;

      FPaintCanvas.Pen.Color := clBlack;
      if not Node.Expanded then
         FPaintCanvas.Polyline([Point(pt.x, DrawRect.Top+Offset div 2), Point(pt.x, DrawRect.Bottom-Offset div 2)]);
      FPaintCanvas.Polyline([Point(DrawRect.Left+Offset div 2, pt.y), Point(DrawRect.Right-Offset div 2, pt.y)]);

      FPaintCanvas.Brush.Color:= OrigColor;
   end
{   FPaintCanvas.Brush.Color := clWhite;
   FPaintCanvas.FillRect(DrawRect);
   FPaintCanvas.Brush.Color := clBtnShadow;
   FPaintCanvas.FrameRect(DrawRect);
   FPaintCanvas.Brush.Color := Color;

   FPaintCanvas.Pen.Color := clBlack;
   if not Expanded then
      FPaintCanvas.Polyline([Point(pt.x, DrawRect.Top+Offset div 2), Point(pt.x, DrawRect.Bottom-Offset div 2)]);
   FPaintCanvas.Polyline([Point(DrawRect.Left+Offset div 2, pt.y), Point(DrawRect.Right-Offset div 2, pt.y)]);}
end;

Function TfcCustomTreeView.GetCenterPoint(ARect: TRect): TPoint;
var r: TRect;
begin
   r:= ARect;

   if odd(fcRectHeight(r) div 2) then
      result.y:= r.Top + (fcRectHeight(r)+2) div 2
   else
      result.y:= r.Top + (fcRectHeight(r)) div 2;

   if odd(fcRectWidth(r) div 2) then
      result.x:= r.Left + (fcRectWidth(r)) div 2
   else
      result.x:= r.Left + (fcRectWidth(r)) div 2;
end;

procedure TfcCustomTreeView.PaintLines(Node: TfcTreeNode);
var LevelNode: TfcTreeNode;
    r: TRect;
    LineTop, LineBottom: TPoint;
    X,Y: integer;
    LineStartX: integer;
    size: integer;

    Function GetStartX(Node: TfcTreeNode): integer;
    var Offset : integer;
        r: TRect;
    begin
        r := LevelRect(Node);
        Offset:= (((r.Bottom - r.Top) div 2) div 2)+2;
        Offset:= fcMin(Offset, MaxCheckboxSize);
        result:= r.Left + offset + 1; //r.Right + Offset + 1;

{        if Node.Level>0 then begin
           r:= LevelRect(Node.parent);
           Offset:= ((fcRectHeight(r) div 2) div 2)+2;
           Offset:= fcMin(Offset, MaxCheckboxSize);
           result:= r.Right + Offset + 1;
        end
        else begin
           r := LevelRect(Node);
           result:= r.Left + fcRectWidth(r) div 2;
        end}
    end;

begin
  r:= LevelRect(Node);
  if tvoShowLines in Options then
  begin
    FPaintCanvas.Pen.Color := FLineColor; //clBtnShadow; { for line drawing }
    LevelNode := Node;
    while (LevelNode <> nil) and ((LevelNode.Level = 0) or (LevelNode.Parent <> nil)) do
    begin

      with ItemRect(Node, False) do
      begin
        r := LevelRect(LevelNode);
        r.Top := Top;
        r.Bottom := Bottom;
      end;
      LineStartX:= GetStartX(LevelNode);
      LineTop:= Point(LineStartX, r.Top);
      LineBottom:= Point(LineStartX, r.Bottom);

      if LevelNode.Level = Node.Level then
      begin
       if (Node.GetPrevSibling = nil) and (Node.Parent = nil) then
          inc(LineTop.y, GetCenterPoint(r).y);
        if Node.GetNextSibling = nil then
          dec(LineBottom.y, fcRectHeight(r) div 2 - 1);
      end;
      if (LevelNode.GetNextSibling <> nil) or (LevelNode.Level = Node.Level) then
        FPaintCanvas.DottedLine(LineTop, LineBottom);
      LevelNode := LevelNode.Parent;
    end;
    r := LevelRect(Node);
    if (tvoShowRoot in Options) or (Node.Level <> 0) then
    begin
      y:= GetCenterPoint(r).y;
      x:= GetStartX(Node);
      if UseStateImages(Node) or MultiSelectAttributes.enabled then
      begin
         if (CheckboxNeeded(Node as TfcTreeNode)) then
         begin
            r.right:= r.right - 2;
         end
      end;
      FPaintCanvas.DottedLine(Point(x, y), Point(r.Right, y));
    end
  end;
  if Node.HasChildren then begin
     size:= (fcRectHeight(r) div 2);
     size:= fcMax(size, 8);
     PaintButton(Node, Point(GetStartX(Node), GetCenterPoint(r).y), size)
  end
end;

procedure TfcCustomTreeView.PaintImage(Node: TfcTreeNode; State: TfcItemStates);
const ItemChecked: array[Boolean] of Integer = (0, DFCS_CHECKED);
      CheckBoxFlat: array[Boolean] of Integer = (0, DFCS_FLAT);
      DrawSelected: array[Boolean] of Integer = (ILD_NORMAL, ILD_SELECTED);
      Grayed: array[Boolean] of Integer = (0, DFCS_INACTIVE);
var r: TRect;
    x: Integer;
    Index: Integer;
    cp: TPoint;
    offset: integer;
    Style: UINT;
    BlendColor: TColorRef;
begin
  r := LevelRect(Node);

  if not((Images = nil) or
    ((Node.ImageIndex < 0)) or
     (Node.ImageIndex >= Images.Count)) then
  begin
    x := r.Right;
    if UseStateImages(Node) then
    begin
       if StateImages<>nil then
          inc(x, TImageList(StateImages).Width)
       else
          inc(x, FixBugImageListSize);
    end;

    if (not (fcisSelected in State)) or (Node.SelectedIndex < 0) or (Node.SelectedIndex >= Images.Count) then
      Index := Node.ImageIndex
    else Index := Node.SelectedIndex;

    Style:=
       DrawSelected[((Node.Selected and (DropTarget = nil)) or Node.DropTarget) and (TImageList(Images).BlendColor <> clNone)
          and not IsRowSelect];
    if Node.Cut then
    begin
       Style:= Style or ILD_BLEND50;
       BlendColor:= clWhite;
    end
    else begin
       BlendColor:= ColorToRGB(TImageList(Images).BlendColor);
    end;

    if Node.OverlayIndex>=0 then
      Style:= Style or UINT(IndexToOverlayMask(Node.OverlayIndex+1));

    ImageList_DrawEx(Images.Handle, Index, FPaintCanvas.Handle,
      x, r.Top + (r.Bottom - r.Top - TImageList(Images).Height) div 2, 0, 0,
      CLR_NONE, BlendColor, Style);

  end;


  if UseStateImages(Node) then
  begin
    if (not CheckboxNeeded(Node as TfcTreeNode)) then
       StateImages.Draw(FPaintCanvas, r.right, r.Top + (r.Bottom-r.Top-TImageList(StateImages).Height) div 2, Node.StateIndex)
//       StateImages.Draw(FPaintCanvas, r.Right, r.Top, Node.StateIndex)
    else begin
      cp:= GetCenterPoint(r);
      Offset:= ((fcRectHeight(r) div 2) div 2)+2;
      Offset:= fcMin(Offset, MaxCheckboxSize);
      if Node.CheckboxType=tvctRadioGroup then
        DrawFrameControl(FPaintCanvas.Handle, Rect(r.right+1, cp.y-offset, r.Right + 2*offset+2, cp.y+offset+1),
           DFC_BUTTON,
           Grayed[Node.Grayed] or
           DFCS_BUTTONRADIO or CheckBoxFlat[tvoFlatCheckBoxes in Options] or ItemChecked[Node.checked])
      else
        DrawFrameControl(FPaintCanvas.Handle, Rect(r.right+1, cp.y-offset, r.Right + 2*offset+2, cp.y+offset+1),
           DFC_BUTTON, Grayed[Node.Grayed] or
                 DFCS_BUTTONCHECK or CheckBoxFlat[tvoFlatCheckBoxes in Options]
                 or ItemChecked[Node.checked])
    end;
  end;
end;


procedure TfcCustomTreeView.SetOptions(Value: TfcTreeViewOptions);
const TVS_FULLROWSELECT       = $1000;
      TVS_TRACKSELECT         = $0200;
var ChangedOptions: TfcTreeViewOptions;
begin
  if not HandleAllocated then begin
     FOptions := Value;
     exit;
  end;

  if Value <> FOptions then
  begin
    ChangedOptions := (FOptions + Value) - (FOptions * Value);
    if tvoRowSelect in ChangedOptions then
       SetComCtlStyle(Self, TVS_FULLROWSELECT, tvoRowSelect in Value);
    if tvoShowRoot in ChangedOptions then
       SetComCtlStyle(Self, TVS_LINESATROOT, tvoShowRoot in Value);
    if tvoShowLines in ChangedOptions then
       SetComCtlStyle(Self, TVS_HASLINES, tvoShowLines in Value);
    if tvoShowButtons in ChangedOptions then
       SetComCtlStyle(Self, TVS_HASBUTTONS, tvoShowButtons in Value);
    if tvoHideSelection in ChangedOptions then
       SetComCtlStyle(Self, TVS_SHOWSELALWAYS, not (tvoHideSelection in Value));
    if tvoHotTrack in ChangedOptions then
       SetComCtlStyle(Self, TVS_TRACKSELECT, tvoHotTrack in Value);
    if tvoEditText in ChangedOptions then
       SetComCtlStyle(Self, TVS_EDITLABELS, tvoEditText in Value);

    FOptions := Value;
    Invalidate;
  end;
end;

Function TfcCustomTreeView.MultiSelectCheckboxNeeded(Node: TfcTreeNode): boolean;
begin
   if Node=nil then result:= False
   else with FMultiSelectAttributes do
      result:= Enabled and MultiSelectCheckbox and (ValidMultiSelectLevel(Node.Level))
end;

Function TfcCustomTreeView.CheckboxNeeded(Node: TfcTreeNode): boolean;
begin
   result:= MultiSelectCheckBoxNeeded(Node) or
            (TfcTreeNode(Node).CheckboxType<>tvctNone);
end;

function TfcCustomTreeView.UseImages(Node: TfcTreeNode): Boolean;
begin
   result:= (Images<>nil) and (Node.ImageIndex<>-2);
end;

function TfcCustomTreeView.UseStateImages(Node: TfcTreeNode): Boolean;
begin
  { 3/8/99 - Don't allow StateIndex to be multiple of 16,
   as the Microsoft TreeView control ignores these state images }
  result := ((StateImages <> nil) and
   (Node.StateIndex>=1) and ((Node.StateIndex mod 16)<>0)) and
//  result := ((StateImages <> nil) and (Node.StateIndex >= 1) and
    (Node.StateIndex < StateImages.Count);

  if MultiSelectCheckBoxNeeded(Node) then result:= True
  else if ((Node as TfcTreeNode).CheckboxType<>tvctNone) and (Node.StateIndex>=1) then
     result:= True;

end;

function TfcCustomTreeView.GetItemHeight: ShortInt;
begin
  result := TreeView_GetItemHeight(Handle);
end;

procedure TfcCustomTreeView.SetItemHeight(Value: ShortInt);
begin
  TreeView_SetItemHeight(Handle, Value);
end;

procedure TfcCustomTreeView.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var Node: TfcTreeNode;
begin
   inherited MouseUp(Button, Shift, X, Y);

   Node:= nil; { Make compiler happy}
   if Assigned(FOnMouseUp) or (tvoAutoURL in Options) then
      Node:= GetNodeAt(X, Y) as TfcTreeNode;

   if Assigned(FOnMouseUp) then
      FOnMouseUp(self, Node, Button, Shift, X, Y);

   if tvoAutoURL in Options then
   begin
      if (Button = mbLeft) and (Node<>nil) and (Node.StringData<>'') and
         (fchtOnItem in GetHitTestInfoAt(x,y)) then
      begin
         Screen.Cursor:= crHourGlass;
         ShellExecute(Handle, 'OPEN', PChar(Node.StringData), nil, nil, sw_shownormal);
         Screen.Cursor:= crDefault; { 10/30/98 - Restore to default cursor }
      end
   end

end;

procedure TfcCustomTreeView.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var Node, CurNode, LastNode: TfcTreeNode;
    hitTest: TfcHitTests;

   Function SameLevelShiftSelect: boolean;
   begin
{       if FMultiSelectAttributes.MultiSelectLevel=-1 then begin
          result:= True;
          exit;
       end;}
       result:=
         (ssShift in Shift) and
         (LastSelectedNode<>Nil) and (LastSelectedNode.parent=Node.parent);
   end;

begin

   inherited MouseDown(Button, Shift, X, Y);

   Node:= GetNodeAt(X, Y) as TfcTreeNode;
   if Assigned(FOnMouseDown) then FOnMouseDown(self, Node, Button, Shift, X, Y);
   if (ssDouble in Shift) and Assigned(FOnDblClick) then FOnDblClick(self, Node, Button, Shift, X, Y);

   if Node=Nil then exit;
   hitTest:= GetHitTestInfoAt(X, Y);

   if (ssDouble in Shift) and (Button = mbLeft) then
   begin
      Exit;
   end;

   if Node=BeforeMouseDownNode then { Bring up edit control }
   begin
      if (fchtOnLabel in hittest) and (tvoEditText in Options) then
      begin
         FreeHintWindow;
         LastHintNode:= nil;
         If (Node<>Nil) and (Images<>Nil) and
            (Node.imageindex=-2) then
            SendMessage(Handle, TVM_EDITLABEL, 0, integer(node.ItemID));
      end;
   end;

   if (fchtOnStateIcon in hitTest) and CheckboxNeeded(Node) and (not ReadOnly) then
   begin
      if Node.IsRadioGroup then begin
         Node.Grayed:= False;
         Node.checked:= True;
      end
      else begin
         if (tvo3StateCheckbox in Options) and
            Node.checked and (not Node.Grayed) then Node.Grayed:= True
         else begin
            Node.checked:= not Node.checked;
            if (tvo3StateCheckbox in Options) or
               not (csDesigning in ComponentState) then
               Node.Grayed:= False;
         end;
      end;
      exit;
   end;

   if FMultiSelectAttributes.Enabled and
   ((IsRowSelect and (X >= LevelRect(Node).Left + FIndent)) or  // -ksw (Added to make behavior more
    (not IsRowSelect and (hitTest * [fchtOnItem, fchtOnLabel] <> []))) then    // consistent in non-databound cases)
   begin
      if (not (ssCtrl in Shift)) and MultiSelectAttributes.AutoUnselect then
      begin
         if SameLevelShiftSelect then UnselectAllNodes(LastSelectedNode)
         else if ValidMultiSelectLevel(Node.Level) then UnselectAllNodes(nil);
      end;

      if (ssShift in Shift) then begin
         if SamelevelShiftSelect then begin
            if Node.index>LastSelectedNode.index then begin
               curNode:= LastSelectedNode;
               LastNode:= Node;

               if not MultiSelectAttributes.AutoUnselect and
                 (LastSelectedNode<>nil) then
                  MultiSelectNode(LastSelectedNode, True, True);

               while curNode<>LastNode do begin
                  curNode:= curNode.GetNextSibling as TfcTreeNode;
                  if curNode=Nil then break;
                  MultiSelectNode(curNode, True, True);
               end;
            end
            else begin
               curNode:= Node;
               LastNode:= LastSelectedNode;
               while curNode<>LastNode do begin
                  MultiSelectNode(curNode, True, True);
                  curNode:= curNode.GetNextSibling as TfcTreeNode;
                  if curNode=Nil then break;
               end;
               if not MultiSelectAttributes.AutoUnselect and
                 (curNode=LastNode) and (curNode<>nil) then
                  MultiSelectNode(curNode, True, True);
            end;
            if not node.selected then node.selected:= True;
         end
      end
      else begin
          if Node<>nil then
             with Node as TfcTreeNode do begin
                if MultiSelectAttributes.AutoUnselect or (ssCtrl in Shift) then
                   MultiSelectNode(Node, not FMultiSelected, True);
                if not node.selected then node.selected:= True;
             end;
      end;

   end;

   if MultiSelectAttributes.enabled and  not (ssShift in Shift) then
      LastSelectedNode:= Node;

end;

procedure TfcCustomTreeView.WMDestroy(var Message: TWMDestroy);
begin
  if Items<>Nil then Items.Clear;  { Faster to call special clear code than to just destroy }
  inherited;
end;

procedure TfcCustomTreeView.WMLButtonDblClk(var Message: TWMLButtonDblClk);
begin
  if not (tvoExpandOnDblClk in FOptions) then
  begin
     with Message do begin { 6/23/99 - Fires OnDblClick event }
        MouseDown(mbLeft, KeysToShiftState(Keys) + [ssDouble], XPos, YPos);
     end
  end
  else inherited;
end;

function TfcCustomTreeView.GetScrollTime: Integer;
begin
  result := TreeView_GetScrollTime(Handle);
end;

procedure TfcCustomTreeView.SetScrollTime(Value: Integer);
begin
  TreeView_SetScrollTime(Handle, Value);
end;

{ Prevents flicker when changing selected node }
procedure TfcCustomTreeView.WMPaint(var Message: TWMPaint);
var OldSkipErase: boolean;
begin
   OldSkipErase:= SkipErase;
   if Items.Count>0 then SkipErase:= True;
   inherited;
   SkipErase:= OldSkipErase;
end;

function TfcTreeNodes.FindNode(SearchText: string; VisibleOnly: Boolean): TfcTreeNode;
var Node: TfcTreeNode;
begin
  result := nil;
  Node := GetFirstNode;
  while Node <> nil do
  begin
    if UpperCase(Node.Text) = UpperCase(SearchText) then
    begin
      result := Node;
      Exit;
    end;
    if VisibleOnly then Node := Node.GetNextVisible
    else Node := Node.GetNext;    
  end;
end;

procedure TfcCustomTreeView.WMEraseBkgnd(var Message: TWmEraseBkgnd);
begin
  if SkipErase then begin
     Message.result:= 1;
     exit;
  end
  else inherited;
end;

function TfcCustomTreeView.GetMultiSelectItem(Index: integer): TfcTreeNode;
begin
   result:= TfcTreeNode(FMultiSelectList[Index]);
end;

function TfcCustomTreeView.GetMultiSelectListCount: integer;
begin
  result:= FMultiSelectList.Count;
end;

procedure TfcCustomTreeView.ClearStateImageIndexes;
var CurNode: TfcTreeNode;
begin
   { Clear image index for all siblings of MultiSelectLevel}
   CurNode := FTreeNodes.GetFirstNode;

   while curNode<>Nil do begin
      if (MultiSelectAttributes.MultiSelectCheckbox=False) then begin
         if ((curNode.Level = MultiSelectAttributes.MultiSelectLevel) or
           (MultiSelectAttributes.MultiSelectLevel=-1)) then
         begin
            curNode.checked:= False;
            curNode.StateIndex:= -1;
         end
      end
      else begin
         if ((curNode.Level <> MultiSelectAttributes.MultiSelectLevel) and
           (MultiSelectAttributes.MultiSelectLevel<>-1)) then
         begin
            curNode.checked:= False;
            curNode.StateIndex:= -1;
         end
      end;

      curNode:= TfcTreeNode(curNode.GetNext);
   end;

end;

procedure TfcCustomTreeView.KeyDown(var Key: Word; Shift: TShiftState);
begin
   inherited;
   if (Key=32) and (Selected<>nil) and (EditNode=nil) then begin
      with MultiSelectAttributes do begin
         if Enabled and (not MultiSelectCheckbox) and
            (ValidMultiSelectLevel(Selected.Level)) then
         begin
            if (ssCtrl in Shift) then
               Selected.MultiSelected:= not Selected.MultiSelected;
            exit;
         end
      end;

      if (not ReadOnly) then
      begin
         if Selected.IsRadioGroup then begin
            if not (csDesigning in ComponentState) then Selected.Grayed:= False;
            Selected.checked:= True;
         end
         else begin
            if (tvo3StateCheckbox in Options) and
               Selected.checked and (not Selected.Grayed) then Selected.Grayed:= True
            else begin
               Selected.checked:= not Selected.checked;
               if (tvo3StateCheckbox in Options) or
                  not (csDesigning in ComponentState) then
                  Selected.Grayed:= False;
            end
         end;
      end;
      Key:= 0;
   end;
end;

procedure TfcCustomTreeview.KeyPress(var Key: Char);
begin
   inherited;
end;

procedure TfcTreeNode.Invalidate;
var r: TRect;
begin
  r := DisplayRect(False);
  InvalidateRect(TreeView.Handle, @r, False);
end;

procedure TfcCustomTreeView.MouseLoop(X, Y: Integer);
var ACursor: TPoint;
    Msg: TMsg;

   Function InButton(ACursorPos: TPoint): boolean;
   var sp: TPoint;
       MouseRect: TRect;
   begin
      sp:= ScreenToClient(ACursorPos);
      MouseRect:= MouseNode.DisplayRect(False);
      Result:= (fchtOnButton in GetHitTestInfoAt(sp.x, sp.y)) and { 2/2/99 }
           (sp.y>=MouseRect.Top) and (sp.y<=MouseRect.Bottom);
   end;

   procedure MouseLoop_MouseMove(X, Y: Integer; ACursorPos: TPoint);
   begin
     Down:= InButton(ACursorPos);
     if not Down then
     begin
        Down:= InButton(ACursorPos);
        InvalidateNode(MouseNode)
     end
     else
        InvalidateNode(MouseNode)
   end;

   procedure MouseLoop_MouseUp(X, Y: Integer; ACursorPos: TPoint);
   var IsMouseInControl: Boolean;
   begin
     IsMouseInControl:= InButton(ACursorPos);
     Down:= False;
     InvalidateNode(MouseNode);
     if IsMouseInControl then
     begin
        if MouseNode.expanded then begin
           if AutoExpand then Selected:= MouseNode; { 4/13/99 - Otherwise it expands again after auto-collapsing }
           MouseNode.Collapse(False);
        end
        else MouseNode.Expand(False);
     end
   end;

begin
  Down:= True;
  InvalidateNode(MouseNode); { Invalidate button icon }

  SetCapture(Handle);
  try
    while GetCapture = Handle do
    begin
      GetCursorPos(ACursor);
      case Integer(GetMessage(Msg, 0, 0, 0)) of
        -1: Break;
        0: begin
          PostQuitMessage(Msg.WParam);
          Break;
        end;
      end;
      case Msg.Message of
        WM_LBUTTONDOWN, WM_LBUTTONDBLCLK: ;
        WM_MOUSEMOVE: MouseLoop_MouseMove(X, Y, ACursor);
        WM_LBUTTONUP: begin
          MouseLoop_MouseUp(X, Y, ACursor);

          TranslateMessage(Msg);   // So OnMouseUp fires
          DispatchMessage(Msg);

          if GetCapture = Handle then ReleaseCapture;
        end;
        else begin
          TranslateMessage(Msg);   // So OnMouseUp fires
          DispatchMessage(Msg);
        end;
      end;
    end;
  finally
    if GetCapture = Handle then ReleaseCapture;
  end;
end;

procedure TfcCustomTreeView.SetLineColor(Value: TColor);
begin
  if FLineColor <> Value then
  begin
    FLineColor:= Value;
    Invalidate;
  end;
end;

procedure TfcCustomTreeView.SetInactiveFocusColor(Value: TColor);
begin
  if FInactiveFocusColor <> Value then
  begin
    FInactiveFocusColor:= Value;
    Invalidate;
  end;
end;

procedure TfcCustomTreeView.CMExit(var Message: TMessage);
var firstNode: TfcTreeNode;
begin
   inherited;

   { If exactly one node then invalidate }
   firstNode:= Items.GetFirstNode;
   if (firstNode<>nil) and (firstNode.GetNextSibling=nil) then InvalidateNode(firstNode);
end;

procedure TfcCustomTreeView.MouseMove(Shift: TShiftState; X, Y: Integer);
var Node: TfcTreeNode;

   Function GetEffectiveWidth: integer;
   begin
      Result:= ClientRect.Right - ClientRect.Left - 4;
   end;

   procedure ProcessToolTips;
   var SP: TPoint;
       R, DisplayRect: TRect;
   begin
      if ((EditNode<>Node) or (EditNode=Nil)) and
         (LastHintNode<>Node) and (Node<>nil) then
      begin
         FreeHintWindow;
         HintTimer.Free;
         HintTimer:= nil;

         sp:= self.ClientToScreen(Point(0, 0));
         DisplayRect:= Node.DisplayRect(True);
         R.Left:= DisplayRect.Left + sp.x - 1;
         R.Top:= DisplayRect.Top + sp.y - 2;
         R.Right:= R.Left + FPaintCanvas.TextWidth(Node.Text) + 6;
         R.Bottom:= R.Top + FPaintCanvas.TextHeight(Node.Text) + 2;
         if DisplayRect.Left+FPaintCanvas.TextWidth(Node.Text)>
            GetEffectiveWidth then
         begin
            HintTimer:= TTimer.create(self);
            HintTimer.OnTimer:=HintTimerEvent;
            HintTimer.Interval:=250;
            HintTimer.Enabled:= True;

            LastHintNode:= Node;
            HintWindow:= CreateHintWindow(Node);
            with HintWindow do begin
               if (Node.StringData<>'') and (tvoAutoURL in Options) then
               begin
                  Canvas.Font.Color:= GetSysColor(clBlue);
                  Canvas.Font.Style:=
                  Canvas.Font.Style + [fsUnderline];
               end;
               ActivateHint(R, Node.Text);
            end
         end
         else LastHintNode:= nil;
      end
   end;


begin
   inherited MouseMove(Shift, X, Y);

   if Assigned(FOnMouseUp) or (tvoAutoURL in Options) or (tvoToolTips in Options) then
      Node:= GetNodeAt(X, Y) as TfcTreeNode;

   if Assigned(FOnMouseMove) then
      FOnMouseMove(self, Node, Shift, X, Y);

   if tvoAutoURL in Options then
   begin
      if (Node<>Nil) and (Node.StringData<>'') and
          (fchtOnItem in GetHitTestInfoAt(x,y)) then
         Cursor:= crHandPoint
      else
         Cursor:= crDefault;
   end;

   if tvoToolTips in Options then ProcessToolTips;

end;

type
  TfcTreeHintWindow=class(THintWindow)
  protected
     procedure Paint; override;
  public
     Node: TfcTreeNode;
  end;

procedure TfcTreeHintWindow.Paint;
var
  R: TRect;
begin
  R := ClientRect;
  Inc(R.Left, 2);
  Inc(R.Top, 2);
  if (Node.StringData<>'') and (tvoAutoURL in Node.TreeView.Options) then
  begin
      Canvas.Font.Color:= clBlue;
      Canvas.Font.Style:=
              Canvas.Font.Style + [fsUnderline];
  end
  else begin
      Canvas.Font.Color := clInfoText;
  end;

  SetBkMode(Canvas.Handle, TRANSPARENT);
  DrawText(Canvas.Handle, PChar(Caption), -1, R, DT_LEFT or DT_NOPREFIX or
    DT_WORDBREAK);
end;

Function TfcCustomTreeView.CreateHintWindow(Node: TfcTreeNode): THintWindow;
begin
   HintWindow:= TfcTreeHintWindow.create(self);
   TfcTreeHintWindow(HintWindow).Node:= Node;

   HintWindow.Color:= GetSysColor(COLOR_INFOBK);
   HintWindow.Canvas.Brush.Color:= GetSysColor(COLOR_INFOBK);
   HintWindow.Canvas.Font:= self.Font;
   HintWindow.Canvas.Font.Color:= GetSysColor(COLOR_INFOTEXT);
   HintWindow.Canvas.Pen.Color:= clBlack;
   result:= HintWindow;
end;

procedure TfcCustomTreeView.FreeHintWindow;
begin
   HintTimerCount:= 0;
   HintWindow.Free;
   HintWindow:= nil;
   if HintTimer<>nil then
      HintTimer.enabled:= False;
end;

procedure TfcCustomTreeView.HintTimerEvent(Sender: TObject);
var
    sp, cp: TPoint;
    OutsideClient: boolean;
begin
   if not (HintWindow<>nil) then exit;

   GetCursorPos(cp);
   sp:= self.ClientToScreen(Point(0, 0));
   if (cp.x<sp.x) or (cp.x>sp.x+ClientRect.Right-ClientRect.Left) or
      (cp.y<sp.y) or (cp.y>sp.y+ClientRect.Bottom-ClientRect.Top) then
   begin
      OutsideClient:= True;
   end
   else OutsideClient:= False;

   { Process Hint Timer clean-up}
   if OutsideClient then
   begin
      FreeHintWindow;
      LastHintNode:= nil;
   end
   else begin
      inc(HintTimerCount);
      if HintTimerCount>16 then
      begin
         FreeHintWindow;
      end
   end

end;

procedure TfcCustomTreeView.CMDesignHitTest(var Message: TCMDesignHitTest);
//var HitTest: TfcHitTests;
begin
{   HitTest:= GetHitTestInfoAt(Message.xPos, Message.yPos);
   if fchtToRight in HitTest then begin
      Message.Result:= 1;
   end
   else }inherited;
end;

procedure TfcCustomTreeView.InvalidateNoErase;
begin
   InvalidateRect(Handle, nil, False);
end;

procedure TfcCustomTreeView.WMNCHitTest(var Message: TWMNCHitTest);
begin
  DefaultHandler(Message);
end;

end.
