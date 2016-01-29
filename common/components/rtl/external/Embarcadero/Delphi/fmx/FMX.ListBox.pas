{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit FMX.ListBox;

interface

uses
  System.Classes, System.Types, System.UITypes, System.SysUtils, System.Rtti,
  System.Generics.Collections, FMX.Types, FMX.StdCtrls, FMX.Layouts,
  FMX.Objects, FMX.Platform, FMX.Pickers, FMX.Messages, FMX.Controls;

{$SCOPEDENUMS ON}

type

  TCustomListBox = class;
  TCustomComboBox = class;
  TListBoxItemData = class;

{ TListBoxItem }

  TListBoxItem = class(TTextControl)
  private type
    TBackgroundShape = (bsSeparatorBottom, bsSharp, bsRoundTop, bsRoundBottom, bsRoundAll);
  private
    FIsChecked: Boolean;
    FCheck: TCheckBox;
    FIsSelected: Boolean;
    FIsSelectable: Boolean;
    FData: TObject;
    FItemData: TListBoxItemData;
    FBitmap: TBitmap;
    FBackgroundShape: TBackgroundShape;
    procedure SetIsChecked(const Value: Boolean);
    procedure DoCheckClick(Sender: TObject);
    procedure UpdateCheck;
    procedure SetIsSelected(const Value: Boolean);
    procedure SetSelectable(const Value: Boolean);
  protected
    procedure ChangeOrder; override;
    function ListBox: TCustomListBox;
    function ComboBox: TCustomComboBox;
    function GetDefaultSize: TSizeF; override;
    procedure ApplyStyle; override;
    procedure FreeStyle; override;
    function EnterChildren(AObject: IControl): Boolean; override;
    procedure DragEnd; override;
    procedure Paint; override;
    function GetHeight: Single;
    procedure SetHeight(const Value: Single); override;
    procedure SelectBackground(const Shape: TBackgroundShape);
    procedure OnBitmapChanged(Sender: TObject);
    function StyledSettingsStored: Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ApplyTriggerEffect(const AInstance: TFmxObject; const ATrigger: string); override;
    property Data: TObject read FData write FData;
    function GetParentComponent: TComponent; override;
  published
    property Align;
    property AutoTranslate default True;
    property ClipChildren default False;
    property ClipParent default False;
    property Cursor default crDefault;
    property DesignVisible default True;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property Selectable: Boolean read FIsSelectable write SetSelectable default True;
    property Font;
    property StyledSettings;
    property Locked default False;
    property Height: Single read GetHeight write SetHeight;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property HitTest default False;
    {triggers}
    property IsChecked: Boolean read FIsChecked write SetIsChecked default False;
    property IsSelected: Boolean read FIsSelected write SetIsSelected default False;
    property ItemData: TListBoxItemData read FItemData write FItemData;
    property Padding;
    property Opacity;
    property Margins;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property StyleLookup;
    property TabOrder;
    property Text;
    property TextAlign default TTextAlign.taLeading;
    property Visible default True;
    property Width;
    property WordWrap;
    {events}
    property OnApplyStyleLookup;
    {Drag and Drop events}
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    {Mouse events}
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnClick;
    property OnPainting;
    property OnPaint;
    property OnResize;
  end;

  { TListBoxItemData }

  TListBoxItemData = class(TPersistent)
  public type
    TAccessory = (aNone=0, aMore=1, aDetail=2, aCheckmark=3);
  strict private
  const
    StyleSelectorMore =      'accessorymore.Visible';
    StyleSelectorDetail =    'accessorydetail.Visible';
    StyleSelectorCheckmark = 'accessorycheckmark.Visible';
  private
    [Weak] FItem: TListBoxItem;
    FAccessory: TAccessory;
    procedure SetText(const Text: String);
    function GetText: String;
    procedure SetDetail(const Detail: String);
    function GetDetail: String;
    procedure SetBitmap(const Bitmap: TBitmap);
    function GetBitmap: TBitmap;
    function GetAccessory: TAccessory;
    procedure SetAccessory(const Accessory: TAccessory);
  public
    constructor Create(const HostItem: TListBoxItem);
    destructor Destroy; override;
    procedure AssignTo(Dest: TPersistent); override;
    procedure Disappear;
  published
    property Text: string read GetText write SetText stored false;
    property Detail: string read GetDetail write SetDetail;
    property Accessory: TAccessory read GetAccessory write SetAccessory default TAccessory.aNone;
    property Bitmap: TBitmap read GetBitmap write SetBitmap;
  end;

{ TCustomListBox }

  TListStyle = (lsVertical, lsHorizontal);
  TListGroupingKind = (gsPlain, gsGrouped);

  TOnCompareListBoxItemEvent = procedure(Item1, Item2: TListBoxItem; var Result: Integer) of object;
  TOnListBoxDragChange = procedure(SourceItem, DestItem: TListBoxItem; var Allow: Boolean) of object;


  TListBoxItemStyleDefaults = class(TPersistent)
  strict private
    FItemStyle : string;
    FHeaderStyle : string;
    FFooterStyle : string;
    [Weak] FListBox: TCustomListBox;
  private
    function GetItemStyle: string;
    procedure SetItemStyle(const Value: string);
    function GetGroupHeaderStyle: string;
    procedure SetGroupHeaderStyle(const Value: string);
    function GetGroupFooterStyle: string;
    procedure SetGroupFooterStyle(const Value: string);
    constructor Create(const ListBox: TCustomListBox);
  public
    procedure Assign(Source: TPersistent); override;
    property ListBox: TCustomListBox read FListBox;
  published
    property ItemStyle: string read GetItemStyle write SetItemStyle nodefault;
    property GroupHeaderStyle: string read GetGroupHeaderStyle write SetGroupHeaderStyle nodefault;
    property GroupFooterStyle: string read GetGroupFooterStyle write SetGroupFooterStyle nodefault;
  end;

  TCustomListBox = class(TScrollBox, IItemsContainer, IInflatableContent<TListBoxItem>, ISearchResponder)
  public type
    TStringsChangeOp = (tsoAdded, tsoDeleted, tsoClear);
    TStringsChangedEvent = procedure(const S: String; const StringsEvent: TCustomListBox.TStringsChangeOp) of object;
    TItemClickEvent = procedure(const Sender: TCustomListBox; const Item: TListBoxItem) of object;
  private type
    TListBoxStrings = class(TStrings)
    private
      FListBox: TCustomListBox;
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
    end;

    TGroup = record
      First:  Integer;
      Length: Integer;
      constructor Create(const AFirst, ALength: Integer);
    end;

    TGroups = class(TList<TGroup>)
    public
      function FindGroup(const Index: Integer): Integer;
    end;

  strict private
    FBeingPainted: Boolean;
    FRealignRequested: Boolean;
    FUpdateGroupsRequested: Boolean;
    FToInflate: TList<TListBoxItem>;
    FInflater: TContentInflater<TListBoxItem>;
    FStringsChanged: TStringsChangedEvent;
    FOnItemClick: TItemClickEvent;

    FMouseSelecting: Boolean;
    FOnChange: TNotifyEvent;
    FShowCheckboxes: Boolean;
    FOnChangeCheck: TNotifyEvent;
    FSorted: Boolean;
    FOnCompare: TOnCompareListBoxItemEvent;
    FMultiSelect: Boolean;
    FAlternatingRowBackground: Boolean;
    FAllowDrag: Boolean;
    FOnDragChange: TOnListBoxDragChange;
    FNoItemsContent: TContent;
    FHeaderCompartment: TContent;
    FFooterCompartment: TContent;
    FContentOverlay: TContent;
    FDefaultStyles: TListBoxItemStyleDefaults;
    FGroups: TGroups;
    FGroupingKind: TListGroupingKind;
    FItemDown: TListBoxItem;
    FClickEnable: Boolean;
    FSelectionTimer: TTimer;
    FSelectionTimerTarget: TListBoxItem;

    function GetInflatableItems: TList<TListBoxItem>;
    procedure SelectionTimerNotify(Sender: TObject);
    procedure InitiateSelectionTimer(Interval: Integer; const Item: TListBoxItem);

  private
    FDragItem: TListBoxItem;
    FFirstVisibleItem, FLastVisibleItem: Integer;

    procedure IgnoreString(Reader: TReader);
    function GetCount: Integer;
    function GetSelected: TListBoxItem;
    procedure SetColumns(const Value: Integer);
    procedure SetItemHeight(const Value: Single);
    procedure SetItemWidth(const Value: Single);
    procedure SetListStyle(const Value: TListStyle);
    procedure SetShowCheckboxes(const Value: Boolean);
    function GetListItem(Index: Integer): TListBoxItem;
    procedure SetSorted(const Value: Boolean);
    procedure SetAlternatingRowBackground(const Value: Boolean);
    procedure SetItems(const Value: TStrings);
    procedure SetMultiSelect(const Value: Boolean);
    procedure SetAllowDrag(const Value: Boolean);
    { IItemsContainer }
    function IItemsContainer.GetItemsCount = GetCount;
    function GetItem(const AIndex: Integer): TFmxObject;
    function GetFilterPredicate: TPredicate<string>;
    procedure SetFilterPredicate(const Predicate: TPredicate<string>);
  protected
    FColumns: Integer;
    FItemWidth: Single;
    FItemHeight: Single;
    FListStyle: TListStyle;
    FFirstSelect: TListBoxItem;
    FFocusedSelection: TControl;
    FSelection: TControl;
    FSelections: TControlList;
    FOddFill: TBrush;
    FItemIndex: Integer;
    FItems: TStrings;
    FMouseUp: Boolean;
    procedure DefineProperties(Filer: TFiler); override;
    function GetData: TValue; override;
    procedure SetData(const Value: TValue); override;
    function CanObserve(const ID: Integer): Boolean; override;
    procedure DoChangeCheck(const Item: TListBoxItem); dynamic;
    function CompareItems(const Item1, Item2: TListBoxItem): Integer; virtual;
    procedure DoChange; dynamic;
    procedure SortItems; virtual;
    procedure SetItemIndex(const Value: Integer); virtual;
    procedure KeyDown(var Key: Word; var KeyChar: System.WideChar; Shift: TShiftState); override;
    procedure KeyUp(var Key: Word; var KeyChar: System.WideChar; Shift: TShiftState); override;
    procedure DragOver(const Data: TDragObject; const Point: TPointF; var Accept: Boolean); override;
    procedure DragDrop(const Data: TDragObject; const Point: TPointF); override;
    function GetDefaultSize: TSizeF; override;
    procedure ApplyStyle; override;
    procedure FreeStyle; override;
    procedure DoEnter; override;
    procedure DoExit; override;
    procedure DoAddObject(const AObject: TFmxObject); override;
    procedure DoInsertObject(Index: Integer; const AObject: TFmxObject); override;
    procedure DoRemoveObject(const AObject: TFmxObject); override;
    function GetBorderHeight: Single;
    function CreateScrollContent: TScrollContent; override;
    function DoCalcContentBounds: TRectF; override;
    procedure DoContentPaint(Sender: TObject; Canvas: TCanvas; const ARect: TRectF);
    procedure Painting; override;
    procedure AfterPaint; override;
    procedure ViewportPositionChange(const OldViewportPosition, NewViewportPosition: TPointF;
                                     const ContentSizeChanged: boolean); override;
    procedure DoUpdateAniCalculations(const AAniCalculations: TScrollCalculations); override;

    function IsAddToContent(const AObject: TFmxObject): Boolean; override;
    procedure ContentAddObject(const AObject: TFmxObject); override;
    procedure ContentInsertObject(Index: Integer; const AObject: TFmxObject); override;
    procedure ContentBeforeRemoveObject(AObject: TFmxObject); override;
    procedure ContentRemoveObject(const AObject: TFmxObject); override;
    procedure AddToTabList(const AObject: TFmxObject); override;
    function IsOpaque: Boolean; override;
    procedure UpdateVisibleItems;
    procedure UpdateSelection;
    procedure UpdateGroups;
    procedure RealUpdateGroups; virtual;
    procedure UpdateStickyHeader;
    procedure SetGroupingKind(const Value: TListGroupingKind);
    procedure DoRealign; override;
    procedure DispatchStringsChangeEvent(const S: String; const Op: TStringsChangeOp);
    procedure UpdateItemStyleFromDefaults(const Item: TListBoxItem);
    procedure DoStyleChanged; override;
    property CanFocus default True;
    property CanParentFocus;
    property AllowDrag: Boolean read FAllowDrag write SetAllowDrag default False;
    property AlternatingRowBackground: Boolean read FAlternatingRowBackground write SetAlternatingRowBackground default False;
    property Columns: Integer read FColumns write SetColumns default 1;
    property ItemWidth: Single read FItemWidth write SetItemWidth;
    property ItemHeight: Single read FItemHeight write SetItemHeight;
    property ListStyle: TListStyle read FListStyle write SetListStyle
      default TListStyle.lsVertical;
    property MultiSelect: Boolean read FMultiSelect write SetMultiSelect default False;
    property Sorted: Boolean read FSorted write SetSorted default False;
    property ShowCheckboxes: Boolean read FShowCheckboxes write SetShowCheckboxes default False;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnChangeCheck: TNotifyEvent read FOnChangeCheck write FOnChangeCheck;
    property OnCompare: TOnCompareListBoxItemEvent read FOnCompare write FOnCompare;
    property OnDragChange: TOnListBoxDragChange read FOnDragChange write FOnDragChange;
    property OnStringsChanged: TStringsChangedEvent read FStringsChanged write FStringsChanged;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Clear; virtual;
    function DragChange(const SourceItem, DestItem: TListBoxItem): Boolean; dynamic;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Single); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single); override;
    procedure SelectAll;
    procedure ClearSelection;
    procedure SelectRange(const Item1, Item2: TListBoxItem);
    function ItemByPoint(const X, Y: Single): TListBoxItem;
    function ItemByIndex(const Idx: Integer): TListBoxItem;
    procedure ItemsExchange(Item1, Item2: TListBoxItem);
    procedure Sort(Compare: TFmxObjectSortCompare); override;
    procedure NotifyInflated;
    property BorderHeight: Single read GetBorderHeight;
    property Count: Integer read GetCount;
    property Selected: TListBoxItem read GetSelected;
    property Items: TStrings read FItems write SetItems stored False;
    property ListItems[Index: Integer]: TListBoxItem read GetListItem;
    property ItemIndex: Integer read FItemIndex write SetItemIndex default -1;
    property GroupingKind: TListGroupingKind read FGroupingKind write SetGroupingKind default TListGroupingKind.gsPlain;
    property FilterPredicate: TPredicate<string> read GetFilterPredicate write SetFilterPredicate stored False;
    property DefaultItemStyles: TListBoxItemStyleDefaults read FDefaultStyles write FDefaultStyles;
    property OnItemClick: TItemClickEvent read FOnItemClick write FOnItemClick;
  end;

{ TListBox }

  TListBox = class(TCustomListBox)
  published
    property Align;
    property AllowDrag;
    property AlternatingRowBackground;
    property Anchors;
    property CanFocus;
    property CanParentFocus;
    property ClipChildren default False;
    property ClipParent default False;
    property Columns;
    property Cursor default crDefault;
    property DesignVisible default True;
    property DisableFocusEffect default True;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property Locked default False;
    property Height;
    property HitTest default True;
    property ItemIndex;
    property ItemHeight;
    property Items;
    property ItemWidth;
    property DefaultItemStyles;
    property GroupingKind;
    property ListStyle;
    property Padding;
    property MultiSelect;
    property Opacity;
    property Margins;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property ShowCheckboxes;
    property Sorted;
    property StyleLookup;
    property TabOrder;
    property Visible default True;
    property Width;

    {events}
    property OnApplyStyleLookup;
    property OnChange;
    property OnChangeCheck;
    property OnCompare;
    {Drag and Drop events}
    property OnDragChange;
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    {Keyboard events}
    property OnKeyDown;
    property OnKeyUp;
    {Mouse events}
    property OnCanFocus;
    property OnItemClick;

    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseEnter;
    property OnMouseLeave;

    property OnPainting;
    property OnPaint;
    property OnResize;
  end;

  TListBoxHeader = class(TToolBar, IListBoxHeaderTrait)
  end;

  TListBoxSeparatorItem = class(TListBoxItem)
  end;

  TListBoxGroupHeader = class(TListBoxSeparatorItem)
  protected
    function GetDefaultStyleLookupName: string; override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TListBoxGroupFooter = class(TListBoxSeparatorItem)
  protected
    function GetDefaultStyleLookupName: string; override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  { TComboListBox }

  TComboListBox = class(TCustomListBox, IContent)
  protected
    FComboBox: TCustomComboBox;
    procedure KeyDown(var Key: Word; var KeyChar: System.WideChar; Shift: TShiftState); override;
    function GetObservers: TObservers; override;
    function GetDefaultStyleLookupName: string; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Single); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single); override;
  end;

{ TCustomComboBox }

  TCustomComboBox = class(TStyledControl, IItemsContainer)
  private
    FDropDownCount: Integer;
    FOnChange: TNotifyEvent;
    FOnClosePopup: TNotifyEvent;
    FOnPopup: TNotifyEvent;
    FDroppedDown: Boolean;
    procedure SetItemIndex(const Value: Integer);
    function GetItemIndex: Integer;
    function GetCount: Integer;
    procedure SetListBoxResource(const Value: string);
    function GetListBoxResource: string;
    function GetItemHeight: Single;
    procedure SetItemHeight(const Value: Single);
    function GetPlacement: TPlacement;
    function GetPlacementRectangle: TBounds;
    procedure SetPlacement(const Value: TPlacement);
    procedure SetPlacementRectangle(const Value: TBounds);
    procedure UpdateCurrentItem;
    function GetItems: TStrings;
    function GetListItem(Index: Integer): TListBoxItem;
    function GetSelected: TListBoxItem;
    procedure SetItems(const Value: TStrings);
    procedure IgnoreBoolean(Reader: TReader);
    { IItemContainer }
    function GetItemsCount: Integer;
    function GetItem(const AIndex: Integer): TFmxObject;
  protected
    FPopup: TPopup;
    FListBox: TComboListBox;
    FItemIndex: Integer;
    FListPicker: TCustomListPicker;
    FDropDownKind: TDropDownKind;
    procedure DefineProperties(Filer: TFiler); override;
    procedure DoOnValueChangedFromDropDownList(Sender: TObject; const AValueIndex: Integer);
    procedure DoChange; dynamic;
    procedure DoPopup(Sender: TObject);
    procedure DoClosePopup(Sender: TObject);
    procedure DoClosePicker(Sender: TObject);
    function CreateListBox: TComboListBox; virtual;
    function CanObserve(const ID: Integer): Boolean; override;
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    procedure Notification(Component: TComponent; Operation: TOperation); override;
    function GetDefaultSize: TSizeF; override;
    procedure ApplyStyle; override;
    procedure DoRealign; override;
    procedure DoContentPaint(Sender: TObject; Canvas: TCanvas; const ARect: TRectF); virtual;
    procedure DoExit; override;
    procedure DoAddObject(const AObject: TFmxObject); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single); override;
    procedure MouseWheel(Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean); override;
    procedure KeyDown(var Key: Word; var KeyChar: System.WideChar; Shift: TShiftState); override;
    property Popup: TPopup read FPopup;
    property CanFocus default True;
    property CanParentFocus;
    property ItemHeight: Single read GetItemHeight write SetItemHeight;
    property DropDownCount: Integer read FDropDownCount write FDropDownCount default 8;
    property Placement: TPlacement read GetPlacement write SetPlacement;
    property PlacementRectangle: TBounds read GetPlacementRectangle write SetPlacementRectangle;
    property DropDownKind: TDropDownKind read FDropDownKind write FDropDownKind default TDropDownKind.ddkNative;
    property ListBoxResource: string read GetListBoxResource write SetListBoxResource;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnClosePopup: TNotifyEvent read FOnClosePopup write FOnClosePopup;
    property OnPopup: TNotifyEvent read FOnPopup write FOnPopup;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Clear; virtual;
    procedure DropDown; virtual;
    procedure Sort(Compare: TFmxObjectSortCompare); override;
    property ListBox: TComboListBox read FListBox;
    property Count: Integer read GetCount;
    property Selected: TListBoxItem read GetSelected;
    property Items: TStrings read GetItems write SetItems stored False;
    property ListItems[Index: Integer]: TListBoxItem read GetListItem;
    property ItemIndex: Integer read GetItemIndex write SetItemIndex;
    property DroppedDown: Boolean read FDroppedDown;
  end;

{ TComboBox }

  TComboBox = class(TCustomComboBox)
  public
    property PlacementRectangle;
  published
    property Align;
    property Anchors;
    property CanFocus;
    property CanParentFocus;
    property ClipChildren default False;
    property ClipParent default False;
    property Cursor default crDefault;
    property DesignVisible default True;
    property DisableFocusEffect default True;
    property DragMode default TDragMode.dmManual;
    property DropDownCount;
    property EnableDragHighlight default True;
    property Enabled default True;
    property Locked default False;
    property Height;
    property HelpContext;
    property HelpKeyword;
    property HelpType;
    property HitTest default True;
    property Items;
    property ItemIndex default -1;
    property ItemHeight;
    property ListBoxResource;
    property Padding;
    property DropDownKind;
    property Opacity;
    property Margins;
    property Placement default TPlacement.plBottom;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property StyleLookup;
    property TabOrder;
    property TouchTargetExpansion;
    property Visible default True;
    property Width;

    {events}
    property OnApplyStyleLookup;
    property OnChange;
    property OnClosePopup;
    property OnPopup;
    {Drag and Drop events}
    property OnDragEnter;
    property OnDragLeave;
    property OnDragOver;
    property OnDragDrop;
    property OnDragEnd;
    {Keyboard events}
    property OnKeyDown;
    property OnKeyUp;
    {Mouse events}
    property OnCanFocus;
    property OnClick;
    property OnDblClick;

    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseEnter;
    property OnMouseLeave;

    property OnPainting;
    property OnPaint;
    property OnResize;
  end;

  TMetropolisUIListBoxItem = class(TListBoxItem)
  private
    FImage: TImage;
    FText: TLayout;
    FTextPanel: TPanel;

    FTitle: TLabel;
    FSubTitle: TLabel;
    FDescription: TLabel;
    FIconSize: Integer;

    procedure SkipIconSize(Reader: TReader);
    procedure SkipAlign(Reader: TReader);
  protected
    procedure SetIcon(const Bitmap: TBitmap); virtual;
    function GetIcon : TBitmap; virtual;
    procedure SetTitle(const Title: String); virtual;
    function GetTitle: String; virtual;
    procedure SetSubTitle(const SubTitle: String); virtual;
    function GetSubTitle: String; virtual;
    procedure SetDescription(const Description: String); virtual;
    function GetDescription: String; virtual;
    procedure SetIconSize(Value: Integer); virtual;

    procedure SetParent(const AParent: TFmxObject); override;
    procedure ApplyStyle; override;
    procedure OnBitmapChanged(Sender: TObject);
    procedure Resize; override;
    procedure DoRealign; override;
    procedure DefineProperties(Filer: TFiler); override;
    function GetDefaultStyleLookupName: string; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property IconSize: Integer read FIconSize write SetIconSize;
 published
    property Title: String read GetTitle write SetTitle nodefault;
    property SubTitle: String read GetSubTitle write SetSubTitle nodefault;
    property Description: String read GetDescription write SetDescription nodefault;
    property Icon: TBitmap read GetIcon write SetIcon;
    property Padding;
    property Margins;
  end;

implementation

uses
  System.Math, System.Generics.Defaults, FMX.Consts, FMX.TextLayout
  {$IFDEF MACOS}, Macapi.CoreFoundation{$ENDIF};

type
  TOpenObject = class(TControl);
  TOpenCanvas = class(TCanvas);

  TListBoxContent = class(TScrollContent)
  strict private
    FListBox: TCustomListBox;
    FFilterPredicate: TPredicate<string>;
  protected
    function GetFirstVisibleObjectIndex: Integer; override;
    function GetLastVisibleObjectIndex: Integer; override;
    procedure DoRealign; override;
    procedure SetFilterPredicate(const Filter: TPredicate<string>);
    function CreateChildrenList(const Children: TFmxObjectList): TFmxChildrenList; override;
    procedure AddToTabList(const AObject: TFmxObject); override;
    procedure PaintChildren; override;
  public
    constructor Create(AOwner: TComponent); override;
    constructor CreateContent(const AOwner: TComponent; const ListBox: TCustomListBox);
    destructor Destroy; override;
    property Filter: TPredicate<string> read FFilterPredicate write SetFilterPredicate;
  end;

  TFilteredChildrenList = class(TFmxChildrenList)
  strict private
    FFilteredChildren: TFmxObjectList;
    [Weak] FBaseChildren: TFmxObjectList;
  protected
    function DoGetEnumerator: TEnumerator<TFmxObject>; override;
    function GetChildCount: Integer; override;
    function GetChild(AIndex: Integer): TFmxObject; override;
    function IndexOf(const Obj: TFmxObject): Integer; override;
    procedure ApplyFilter(const Filter: TPredicate<string>);
    constructor Create(const Children: TFmxObjectList);
    destructor Destroy; override;
  end;

{ TListBoxItem }

constructor TListBoxItem.Create(AOwner: TComponent);
begin
  inherited;
  TextAlign := TTextAlign.taLeading;
  AutoTranslate := True;
  Text := '';
  HitTest := False;
  FIsSelectable := True;
  FBitmap := TBitmap.Create(0,0);
  FBitmap.OnChange := OnBitmapChanged;
  FItemData := TListBoxItemData.Create(Self);
  StyledSettings := StyledSettings + [TStyledSetting.ssOther];
  SetAcceptsControls(True);
end;

destructor TListBoxItem.Destroy;
begin
  FreeAndNil(FItemData);
  FreeAndNil(FBitmap);
  inherited;
end;

procedure TListBoxItem.ApplyStyle;
var
  B: TFmxObject;
  LListBox : TCustomListBox;
  Dimensions: TRectF;
begin
  Dimensions := BoundsRect;
  inherited;
  LListBox := ListBox;

  if Assigned(LListBox) and LListBox.ShowCheckboxes then
  begin
    B := FindStyleResource('check');
    if Assigned(B) and (B is TCheckBox) then
    begin
      FCheck := TCheckBox(B);
      FCheck.IsChecked := IsChecked;
      FCheck.OnChange := DoCheckClick;
      FCheck.Visible := LListBox.ShowCheckboxes;
    end;
  end;

  B := FindStyleResource('icon');
  if Assigned(B) and (B is TImage) then
  begin
    TImage(B).Bitmap := FBitmap;
    TImage(B).Visible := FBitmap.Width > 0;
  end;

  StartTriggerAnimation(Self, 'IsSelected');
  ApplyTriggerEffect(Self, 'IsSelected');

  // Make the listbox recalculates item positions if size changed
  if Assigned(LListBox) and (Dimensions <> BoundsRect) then
    LListBox.Realign;
end;

procedure TListBoxItem.FreeStyle;
begin
  inherited;
  if Assigned(FCheck) then
    FCheck.OnChange := nil;
  FCheck := nil;
  FItemData.Disappear;
end;

procedure TListBoxItem.DoCheckClick(Sender: TObject);
var
  LListBox : TCustomListBox ;
begin
  if Assigned(FCheck) then
    FIsChecked := FCheck.IsChecked;
  LListBox := ListBox ;
  if Assigned(LListBox) then
  begin
    LListBox.SetFocus;
    LListBox.ItemIndex := Index;
    LListBox.DoChangeCheck(Self);
  end;
end;

procedure TListBoxItem.ApplyTriggerEffect(const AInstance: TFmxObject;
  const ATrigger: string);
begin
end;

procedure TListBoxItem.ChangeOrder;
var
  LListBox : TCustomListBox;
begin
  inherited ChangeOrder;
  LListBox := ListBox ;
  if Assigned(LListBox) and (not LListBox.IsUpdating) then
  begin
    LListBox.BeginUpdate;
    try
      LListBox.InvalidateContentSize;
    finally
      LListBox.EndUpdate;
    end;
  end;
end;

function TListBoxItem.ComboBox: TCustomComboBox;
var
  P: TFmxObject;
begin
  P := Parent;
  while Assigned(P) do
  begin
    if P is TCustomComboBox then
    begin
      Result := TCustomComboBox(P);
      Exit;
    end;
    P := P.Parent;
  end;
  Result := nil;
end;

function TListBoxItem.ListBox: TCustomListBox;
var
  P: TFmxObject;
begin
  P := Parent;
  while Assigned(P) do
  begin
    if P is TCustomListBox then
    begin
      Result := TCustomListBox(P);
      Exit;
    end;
    if P is TCustomComboBox then
    begin
      Result := TCustomComboBox(P).FListBox;
      Exit;
    end;
    P := P.Parent;
  end;
  Result := nil;
end;

procedure TListBoxItem.OnBitmapChanged(Sender: TObject);
var
  Res: TFmxObject;
  Icon: TImage;
begin
  Res := FindStyleResource('icon');
  if Res is TImage then
  begin
    Icon := TImage(Res);
    Icon.Bitmap := FBitmap;
    Icon.Visible := FBitmap.Width > 0;
    Icon.Repaint;
    Icon.UpdateEffects;
  end;
end;

procedure TListBoxItem.Paint;
var
  R: TRectF;
begin
  if (csDesigning in ComponentState) and not Locked and not FInPaintTo then
  begin
    R := LocalRect;
    InflateRect(R, -0.5, -0.5);
    Canvas.DrawDashRect(R, 0, 0, AllCorners, AbsoluteOpacity, $A0909090);
  end;
end;

function TListBoxItem.GetDefaultSize: TSizeF;
var
  DefMetricsSrv: IFMXDefaultMetricsService;
begin
  if SupportsPlatformService(IFMXDefaultMetricsService, IInterface(DefMetricsSrv)) and DefMetricsSrv.SupportsDefaultSize(ckListBoxItem) then
    Result := TSizeF.Create(DefMetricsSrv.GetDefaultSize(ckListBoxItem).Width, DefMetricsSrv.GetDefaultSize(ckListBoxItem).Height)
  else
    Result := TSizeF.Create(19, 19);
end;

function TListBoxItem.GetHeight: Single;
begin
  Result := FHeight;
end;

function TListBoxItem.GetParentComponent: TComponent;
var
  LComboBox : TCustomComboBox;
  LListBox : TCustomListBox;
begin
  LComboBox := ComboBox;
  if Assigned(LComboBox) then
    Result := LComboBox
  else
  begin
    LListBox := ListBox;
    if Assigned(LListBox) then
      Result := LListBox
    else
      Result := inherited GetParentComponent;
  end;
end;

function TListBoxItem.EnterChildren(AObject: IControl): Boolean;
var
  LListBox : TCustomListBox;
begin
  Result := inherited EnterChildren(AObject);
  LListBox := ListBox;
  if Assigned(LListBox) then
  begin
    if LListBox.MultiSelect then
      LListBox.ClearSelection;
    LListBox.ItemIndex := Index;
    Result := True;
  end;
end;

procedure TListBoxItem.UpdateCheck;
var
  LListBox : TCustomListBox ;
  Item: TListBoxItem;
begin
  LListBox := ListBox ;

  if LListBox.ShowCheckBoxes and not Assigned(FCheck) then
    FCheck := TCheckBox(FindStyleResource('check'));

  if Assigned(LListBox) and Assigned(FCheck) then
    FCheck.Visible := LListBox.ShowCheckboxes;
  for Item in TControlsFilter<TListBoxItem>.Filter(Controls) do
    Item.UpdateCheck;
end;

procedure TListBoxItem.SelectBackground(const Shape: TBackgroundShape);
begin
  StylesData['background_separatorbottom.Visible'] := TValue.From<Boolean>(Shape = TBackgroundShape.bsSeparatorBottom);
  StylesData['background_sharp.Visible'] := TValue.From<Boolean>(Shape = TBackgroundShape.bsSharp);
  StylesData['background_roundtop.Visible'] := TValue.From<Boolean>(Shape = TBackgroundShape.bsRoundTop);
  StylesData['background_roundbottom.Visible'] := TValue.From<Boolean>(Shape = TBackgroundShape.bsRoundBottom);
  StylesData['background_roundall.Visible'] := TValue.From<Boolean>(Shape = TBackgroundShape.bsRoundAll);
  FBackgroundShape := Shape;
end;

procedure TListBoxItem.SetHeight(const Value: Single);
var
  LListBox : TCustomListBox;
begin
  inherited SetHeight(Value);
  LListBox := ListBox;
  if Assigned(LListBox) then
    LListBox.Realign;
end;

procedure TListBoxItem.SetIsChecked(const Value: Boolean);
begin
  if FIsChecked <> Value then
  begin
    FIsChecked := Value;
    if Assigned(FCheck) then
      FCheck.IsChecked := FIsChecked;
  end;
end;

procedure TListBoxItem.SetIsSelected(const Value: Boolean);
var
  LListBox : TCustomListBox ;
begin
  if FIsSelected <> Value then
  begin
    FIsSelected := Selectable and Value;
    StartTriggerAnimation(Self, 'IsSelected');
    LListBox := ListBox;
    if FIsSelected and Assigned(LListBox) and not (LListBox.MultiSelect) then
      ListBox.FItemIndex := Index
    else
      if not FIsSelected and Assigned(LListBox)
      and not(LListBox.MultiSelect) and (LListBox.ItemIndex = Index) then
        LListBox.ItemIndex := -1
      else
        if Assigned(LListBox) then
          LListBox.UpdateSelection;
  end;
end;

procedure TListBoxItem.SetSelectable(const Value: Boolean);
var
  LListBox : TCustomListBox;
begin
  if FIsSelectable <> Value then
  begin
    FIsSelectable := Value;
    LListBox := ListBox;
    if Assigned(LListBox) then
      ListBox.UpdateSelection;
  end;
end;

function TListBoxItem.StyledSettingsStored: Boolean;
begin
  Result := StyledSettings <> (DefaultStyledSettings + [TStyledSetting.ssOther]);
end;

procedure TListBoxItem.DragEnd;
var
  LListBox : TCustomListBox;
begin
  inherited;
  DragLeave;
  LListBox := ListBox;
  if Assigned(LListBox) then
    LListBox.FDragItem := nil;
end;

{ TListBoxContent }

constructor TListBoxContent.CreateContent(const AOwner: TComponent; const ListBox: TCustomListBox);
begin
  FListBox := ListBox;
  Create(AOwner);
end;

function TListBoxContent.CreateChildrenList(const Children: TFmxObjectList): TFmxChildrenList;
begin
  Result := TFilteredChildrenList.Create(Children);
end;

constructor TListBoxContent.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TListBoxContent.Destroy;
begin
  inherited;
end;

procedure TListBoxContent.DoRealign;
begin
  if csDesigning in ComponentState then
  begin
    FListBox.Realign;
    FListBox.UpdateGroups;
  end;
end;

function TListBoxContent.GetFirstVisibleObjectIndex: Integer;
begin
  Result := FListBox.FFirstVisibleItem;
end;

function TListBoxContent.GetLastVisibleObjectIndex: Integer;
begin
  Result := FListBox.FLastVisibleItem;
end;

procedure TListBoxContent.PaintChildren;
var
  SaveStage: TPaintStage;
begin
  if TCanvasStyle.NeedGPUSurface in Canvas.GetCanvasStyle then
  begin
    SaveStage := PaintStage;
    try
      PaintStage := TPaintStage.psBackground;
      inherited ;
      PaintStage := TPaintStage.psText;
      inherited;
    finally
      PaintStage := SaveStage;
    end;
  end else
    inherited;
end;

procedure TListBoxContent.SetFilterPredicate(const Filter: TPredicate<string>);
begin
  FFilterPredicate := Filter;
  if Children <> nil then
    TFilteredChildrenList(Children).ApplyFilter(FFilterPredicate);
  ResetChildrenIndices;
  ChangeChildren;
end;

procedure TListBoxContent.AddToTabList(const AObject: TFmxObject);
begin
end;

{ TListBox }

constructor TCustomListBox.Create(AOwner: TComponent);
begin
  inherited;

  FDefaultStyles := TListBoxItemStyleDefaults.Create(Self);

  FGroupingKind := TListGroupingKind.gsPlain;
  FDisableAlign := True;
  FNoItemsContent := TContent.Create(Self);
  FNoItemsContent.Parent := Self;
  FNoItemsContent.Stored := False;
  FNoItemsContent.Locked := True;
  FNoItemsContent.HitTest := False;
  FHeaderCompartment := TContent.Create(Self);
  FHeaderCompartment.Stored := False;
  FHeaderCompartment.Locked := True;
  FHeaderCompartment.Visible := False;
  FHeaderCompartment.Align := TAlignLayout.alTop;
  FHeaderCompartment.Parent := Self;
  FFooterCompartment := TContent.Create(Self);
  FFooterCompartment.Stored := False;
  FFooterCompartment.Locked := True;
  FFooterCompartment.Visible := False;
  FFooterCompartment.Align := TAlignLayout.alBottom;
  FFooterCompartment.Parent := Self;

  FContentOverlay := TContent.Create(Self);
  FContentOverlay.Stored := False;
  FContentOverlay.Locked := True;
  FContentOverlay.Visible := True;
  FContentOverlay.Align := TAlignLayout.alClient;
  FContentOverlay.HitTest := False;
  FContentOverlay.ClipChildren := True;
  FContentOverlay.Parent := Self;

  FDisableAlign := False;

  FGroups := TGroups.Create;
  FItems := TListBoxStrings.Create;
  TListBoxStrings(FItems).FListBox := Self;
  FOddFill := TBrush.Create(TBrushKind.bkSolid, $20000000);
  FColumns := 1;
  FItemIndex := -1;
  DisableFocusEffect := True;
  CanFocus := True;
  AutoCapture := True;
  MinClipWidth := 22;
  MinClipHeight := 22;
  SetAcceptsControls(True);

  FToInflate := TList<TListBoxItem>.Create;
  FInflater := TContentInflater<TListBoxItem>.Create(Self);
end;

function TCustomListBox.CreateScrollContent: TScrollContent;
begin
  Result := TListBoxContent.CreateContent(Self, Self);
end;

procedure TCustomListBox.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('DefaultItemStyle', IgnoreString, nil, False);
end;

destructor TCustomListBox.Destroy;
begin
  FStringsChanged := nil;
  FreeAndNil(FSelectionTimer);
  FreeAndNil(FSelections);
  FreeAndNil(FOddFill);
  FreeAndNil(FItems);
  FreeAndNil(FGroups);
  FreeAndNil(FInflater);
  FreeAndNil(FToInflate);
  FreeAndNil(FDefaultStyles);
  inherited;
end;

procedure TCustomListBox.DispatchStringsChangeEvent(const S: String;
  const Op: TStringsChangeOp);
begin
  if Assigned(FStringsChanged) then
    FStringsChanged(S, Op);
end;

function TCustomListBox.GetData: TValue;
begin
  if Assigned(Selected) then
    Result := Selected.Text
  else
    Result := '';
end;

function TCustomListBox.GetDefaultSize: TSizeF;
begin
  Result := TSizeF.Create(200, 200);
end;

procedure TCustomListBox.SetData(const Value: TValue);
begin
  if Assigned(Selected) then
    Selected.Text := Value.ToString;
end;

procedure TCustomListBox.SetFilterPredicate(const Predicate: TPredicate<string>);
begin
  try
    BeginUpdate;
    ScrollTo(HScrollBarValue, VScrollBarValue);
    InvalidateContentSize;
    Self.ItemIndex := -1;
    TListBoxContent(Content).Filter := Predicate;
    UpdateGroups;
    RealignContent;
  finally
    EndUpdate;
  end;
end;

function TCustomListBox.GetFilterPredicate: TPredicate<string>;
begin
  Result := TListBoxContent(Content).Filter;
end;

procedure TCustomListBox.SetGroupingKind(const Value: TListGroupingKind);
begin
  if FGroupingKind <> Value then
  begin
    try
      BeginUpdate;
      FGroupingKind := Value;
      UpdateGroups;
      RealignContent;
    finally
      EndUpdate;
    end;
  end;
end;

procedure TCustomListBox.Assign(Source: TPersistent);
var
  i: Integer;
  Item: TListBoxItem;
begin
  if Source is TStrings then
  begin
    BeginUpdate;
    try
      Clear;
      for i := 0 to TStrings(Source).Count - 1 do
      begin
        Item := TListBoxItem.Create(Owner);
        Item.Parent := Self;
        Item.Text := TStrings(Source)[i];
      end;
    finally
      EndUpdate;
    end;
  end
  else
    inherited;
end;

procedure TCustomListBox.ViewportPositionChange(const OldViewportPosition, NewViewportPosition: TPointF;
                                                const ContentSizeChanged: boolean);
begin
  inherited;

  InitiateSelectionTimer(-1, nil);

  UpdateVisibleItems;
  UpdateSelection;
  if ContentSizeChanged or (not SameValue(OldViewportPosition.Y, NewViewportPosition.Y, Epsilon)) then
    UpdateStickyHeader;
end;

procedure TCustomListBox.DoUpdateAniCalculations(const AAniCalculations: TScrollCalculations);
begin
  inherited DoUpdateAniCalculations(AAniCalculations);
  if ListStyle = TListStyle.lsVertical then
    AAniCalculations.TouchTracking := AAniCalculations.TouchTracking - [ttHorizontal]
  else
    AAniCalculations.TouchTracking := AAniCalculations.TouchTracking - [ttVertical];
end;

function CompareListItem(Item1, Item2: TFmxObject): Integer;
var
  LListBox : TCustomListBox ;
begin
  if Item1 is TListBoxItem then
    LListBox := TListBoxItem(Item1).ListBox
  else
    LListBox := nil ;
  if (Item1 is TListBoxItem) and (Item2 is TListBoxItem)
  and Assigned(LListBox) then
    Result := LListBox.CompareItems(TListBoxItem(Item1), TListBoxItem(Item2))
  else
    Result := 0;
end;

procedure TCustomListBox.Sort(Compare: TFmxObjectSortCompare);
var
  I : Integer;
  Item: TListBoxItem;
begin
  Item := Selected;
  inherited;
  BeginUpdate;
  Content.Sort(CompareListItem);
  try
    if not MultiSelect then
    begin
      for I := 0 to Count - 1 do
        ListItems[I].IsSelected := False;
      // and re-select the previous selected item
      if Assigned(Item) then
      begin
        Item.IsSelected := True;
        FItemIndex := Item.Index;
      end;
    end;
  finally
    EndUpdate;
  end;
  if not (csLoading in ComponentState) then
    DoChange;
end;

procedure TCustomListBox.SortItems;
begin
  if FSorted then
    Content.Sort(CompareListItem);
end;

procedure TCustomListBox.DoContentPaint(Sender: TObject; Canvas: TCanvas; const ARect: TRectF);
var
  i: Integer;
  Item: TListBoxItem;
  P: TPointF;
  R: TRectF;
begin
  if Assigned(Content) and Assigned(ContentLayout) then
  begin
    if FAlternatingRowBackground then
    begin
      for i := 0 to ((FLastVisibleItem - FFirstVisibleItem - 1) div Columns) do
      begin
        if Odd((FFirstVisibleItem div Columns ) + i) then
        begin
          if FFirstVisibleItem + (i * Columns) > Count - 1 then
            Item := ItemByIndex(Count - 1)
          else
            Item := ItemByIndex(FFirstVisibleItem + (i * Columns));
          P := Item.LocalToAbsolute(PointF(0, 0));
          P := TControl(Sender).AbsoluteToLocal(P);
          R := RectF(P.X, P.Y, P.X + ContentLayout.Width, P.Y + Item.Height);
          if not IntersectRect(R, ARect) then
            Continue;
          Canvas.FillRect(R, 0, 0, [], AbsoluteOpacity, FOddFill);
        end;
      end;
    end;
  end;
end;

procedure TCustomListBox.AddToTabList(const AObject: TFmxObject);
begin
  if not IsAddToContent(AObject) then
    inherited;
end;

procedure TCustomListBox.ApplyStyle;
var
  T: TFmxObject;
  LDisableAlign: Boolean;
begin
  inherited;
  LDisableAlign := FDisableAlign;
  try
    FDisableAlign := True;
    T := FindStyleResource('content');
    if Assigned(T) and (T is TControl) then
    begin
      TControl(T).OnPainting := DoContentPaint;
      if Assigned(TControl(T).ParentControl) then
        FContentOverlay.Margins.Assign(TControl(T).ParentControl.Padding);
    end;
    T := FindStyleResource('selection');
    if Assigned(T) and (T is TControl) then
    begin
      FSelection := TControl(T);
      FSelection.Visible := False;
    end;
    T := FindStyleResource('focusedselection');
    if Assigned(T) and (T is TControl) then
    begin
      FFocusedSelection := TControl(T);
      FFocusedSelection.Visible := False;
    end;
    T := FindStyleResource('AlternatingRowBackground');
    if Assigned(T) and (T is TBrushObject) then
      FOddFill.Assign(TBrushObject(T).Brush);
    if Assigned(T) and (T is TControl) then
      TControl(T).Visible := False;

    T := FindStyleResource('header');
    if Assigned(T) and (T is TControl) then
    begin
      FHeaderCompartment.TagObject := T;
      TControl(T).Height := FHeaderCompartment.Height;
      TControl(T).Visible := FHeaderCompartment.Visible;
    end;
    T := FindStyleResource('footer');
    if Assigned(T) and (T is TControl) then
    begin
      FFooterCompartment.TagObject := T;
      TControl(T).Height := FFooterCompartment.Height;
      TControl(T).Visible := FFooterCompartment.Visible;
    end;

    UpdateSelection;
    UpdateStickyHeader;
  finally
    FDisableAlign := LDisableAlign;
  end;
  Realign;
end;

procedure TCustomListBox.FreeStyle;
begin
  inherited;
  FSelection := nil;
  FFocusedSelection := nil;
  FHeaderCompartment.TagObject := nil;
  FFooterCompartment.TagObject := nil;
  if Assigned(FSelections) then
    FSelections.Clear;
end;

procedure TCustomListBox.UpdateSelection;
var
  i: Integer;
  P: TPointF;
  R: TRectF;
  SelRects: array of TRectF;
  Clone: TControl;
  Item: TListBoxItem;
  FMobj : TFmxObject;
begin
  if not Assigned(FSelection) or (FUpdating > 0) then
    Exit;

  // To avoid component deletion during loading
  if (Owner <> nil) and (csLoading in Owner.ComponentState) then
    Exit;

  // calc rects
  SetLength(SelRects, 0);
  for i := FFirstVisibleItem to FLastVisibleItem - 1 do
  begin
    Item := ItemByIndex(i);
    if Assigned(Item) then
      if Item.IsSelected then
      begin
        P := Item.LocalToAbsolute(PointF(0, 0));
        if Assigned(FSelection.ParentControl) then
          P := FSelection.ParentControl.AbsoluteToLocal(P);
        R := RectF(P.X, P.Y, P.X + Item.Width, P.Y + Item.Height);
        if (Length(SelRects) > 0) and (i > 0) and (ItemByIndex(i - 1).IsSelected) then
          SelRects[High(SelRects)] := UnionRect(R, SelRects[High(SelRects)])
        else
        begin
          SetLength(SelRects, Length(SelRects) + 1);
          SelRects[High(SelRects)] := R;
        end;
      end;
  end;
  // Create selection list
  if not Assigned(FSelections) then
    FSelections := TControlList.Create;
  for i := 0 to FSelections.Count - 1 do
  begin
    FMobj := FSelections[i];
    RemoveComponent(FSelections[i]);
    FMobj.Parent := nil;
    FMobj.Free;
  end;
  FSelections.Clear;
  // create selections
  for i := 0 to Length(SelRects) - 1 do
  begin
    if Self.IsFocused and Assigned(FFocusedSelection) then
      Clone := TControl(FFocusedSelection.Clone(Self))
    else
      Clone := TControl(FSelection.Clone(Self));
    Clone.StyleName := '';  // remove Clone from ResourceList
    FSelections.Add(Clone);
    Clone.Parent := FSelection.Parent;
    Clone.Stored := False;
  end;
  // hide if not need
  if Length(SelRects) < FSelections.Count then
    for i := Length(SelRects) to FSelections.Count - 1 do
    begin
      FSelections[i].Visible := False;
      FSelections[i].DesignVisible := False;
    end;
  // align selections
  for i := 0 to High(SelRects) do
  begin
    FSelections[i].Visible := True;
    FSelections[i].DesignVisible := True;
    FSelections[i].BoundsRect := SelRects[i];
  end;
end;

function TCustomListBox.CompareItems(const Item1, Item2: TListBoxItem): Integer;
begin
  Result := CompareText(Item1.Text, Item2.Text);
  if Assigned(FOnCompare) then
    FOnCompare(Item1, Item2, Result);
end;

procedure TCustomListBox.UpdateGroups;
begin
  FUpdateGroupsRequested := True;
end;

procedure TCustomListBox.RealUpdateGroups;
type
  TState = (GroupStart, InGroup, GroupEnd);
const
  NextState: array[TState] of TState = (TState.InGroup, TState.GroupEnd, TState.GroupStart);
var
  Item, GroupLast: TListBoxItem;
  State: TState;
  Group: TGroup;
  Headers: Integer;

  procedure SelectBackground(const Item: TListBoxItem; const Shape: TListBoxItem.TBackgroundShape);
  begin
    if FGroupingKind = TListGroupingKind.gsGrouped then
      Item.SelectBackground(Shape)
    else
      Item.SelectBackground(TListBoxItem.TBackgroundShape.bsSeparatorBottom)
  end;

  procedure EndGroup(const Item: TListBoxItem; const GroupLength: Integer);
  begin
    if GroupLength = 1 then
      SelectBackground(Item, TListBoxItem.TBackgroundShape.bsRoundAll)
    else
      SelectBackground(Item, TListBoxItem.TBackgroundShape.bsRoundBottom);
  end;

  procedure SelectHeaderStyle(Item: TListBoxItem);
  begin
    case GroupingKind of
      TListGroupingKind.gsPlain:    Item.StyleLookup := 'listboxplainheader';
      TListGroupingKind.gsGrouped:  Item.StyleLookup := 'listboxgroupheader';
    end;
  end;

begin
  if not FUpdateGroupsRequested then
    Exit;
  Group := TGroup.Create(0, 0);
  BeginUpdate;
  try
    Headers := 0;
    GroupLast := nil;
    State := Low(TState);
    FGroups.Clear;
    for Item in TControlsFilter<TListBoxItem>.Filter(Content.Controls) do
    begin
      if Item is TListBoxSeparatorItem then
      begin
        SelectHeaderStyle(Item);
        if State = TState.InGroup then
        begin
          EndGroup(GroupLast, Group.Length - Headers);
          FGroups.Add(Group);
        end;

        State := TState.GroupStart;
        Group := TGroup.Create(Item.Index, 1);
        Headers := 1;
        Continue;
      end;

      case State of
        TState.GroupStart:
          begin
            SelectBackground(Item, TListBoxItem.TBackgroundShape.bsRoundTop);
            Inc(Group.Length);
            State := NextState[State];
          end;
        TState.InGroup:
          begin
            Inc(Group.Length);
            SelectBackground(Item, TListBoxItem.TBackgroundShape.bsSharp);
          end;
        TState.GroupEnd:
          begin
            Inc(Group.Length);
            EndGroup(GroupLast, Group.Length);
            FGroups.Add(Group);
            State := NextState[State];
          end;
      end;
      GroupLast := Item;
    end;

    if (State = TState.InGroup) then
    begin
      EndGroup(GroupLast, Group.Length - Headers);
      FGroups.Add(Group);
    end;

    FUpdateGroupsRequested := False;
  finally
    EndUpdate;
  end;
end;

procedure TCustomListBox.UpdateItemStyleFromDefaults(const Item: TListBoxItem);
begin
  if Item.StyleLookup = EmptyStr then
  begin
    if (DefaultItemStyles.GroupHeaderStyle <> EmptyStr) and (Item is TListBoxGroupHeader) then
      Item.StyleLookup := DefaultItemStyles.GroupHeaderStyle
    else
    if (DefaultItemStyles.GroupFooterStyle <> EmptyStr) and (Item is TListBoxGroupFooter) then
      Item.StyleLookup := DefaultItemStyles.GroupFooterStyle
    else
      Item.StyleLookup := DefaultItemStyles.ItemStyle;
  end;
end;

procedure TCustomListBox.ContentAddObject(const AObject: TFmxObject);
begin
  if not (AObject is TListBoxItem) then
  begin
    if Supports(AObject, IListBoxHeaderTrait) then
    begin
      FHeaderCompartment.AddObject(AObject);
      Realign;
    end
    else
      FNoItemsContent.AddObject(AObject)
  end
  else
  begin
    UpdateItemStyleFromDefaults(TListBoxItem(AObject));
    UpdateGroups;
    if not TListBoxItem(AObject).IsInflated then
      FToInflate.Add(TListBoxItem(AObject));
    inherited;
  end;
end;

procedure TCustomListBox.ContentInsertObject(Index: Integer; const AObject: TFmxObject);
begin
  if not (AObject is TListBoxItem) then
  begin
    if Supports(AObject, IListBoxHeaderTrait) then
    begin
      FHeaderCompartment.AddObject(AObject);
      Realign;
    end
    else
      FNoItemsContent.InsertObject(Index, AObject)
  end
  else
  begin
    if FItemIndex >= Index then Inc(FItemIndex);
    UpdateGroups;
    if not TListBoxItem(AObject).IsInflated then
      FToInflate.Add(TListBoxItem(AObject));
    inherited;
  end;
end;

procedure TCustomListBox.ContentBeforeRemoveObject(AObject: TFmxObject);
begin
  inherited;
  if AObject is TListBoxItem then
  begin
    // TListBoxItem.Index can be expensive so check FItemIndex before calling it
    if (FItemIndex > 0) and (FItemIndex > TListBoxItem(AObject).Index) then
    begin
      Dec(FItemIndex);
      UpdateSelection;
    end;
    TListBoxItem(AObject).IsSelected := False;
    FToInflate.Remove(TListBoxItem(AObject));
  end;
end;

procedure TCustomListBox.ContentRemoveObject(const AObject: TFmxObject);
begin
  inherited;
  if AObject is TListBoxItem then
    UpdateGroups;
end;

function TCustomListBox.GetInflatableItems: TList<TListBoxItem>;
begin
  Result := FToInflate;
end;

function TCustomListBox.GetBorderHeight: Single;
begin
  ApplyStyleLookup;
  if Assigned(ContentLayout) then
    Result := (Height - AbsoluteToLocal(ContentLayout.LocalToAbsolute(PointF(0, ContentLayout.Height))).Y) +
      AbsoluteToLocal(ContentLayout.LocalToAbsolute(PointF(0, 0))).Y
  else
    Result := 0;
end;

function TCustomListBox.DoCalcContentBounds: TRectF;
  procedure Align(const Row: array of TListBoxItem; const Count: Integer;
    const X0, Y0, XMul, YMul, ColWidth, RowHeight: Single);
  var
    I: Integer;
  begin
    for I := 0 to Count - 1 do
    begin
      Row[I].SetBounds(X0 + Row[I].Margins.Left + (I * XMul),
                       Y0 + Row[I].Margins.Top  + (I * YMul),
                       ColWidth  - Row[I].Margins.Left - Row[I].Margins.Right,
                       RowHeight - Row[I].Margins.Bottom - Row[I].Margins.Top);
    end;
  end;

var
  R: TRectF;
  J: Integer;
  RowHeight, ColWidth, CurY: Single;
  W, H: Single;
  LItem: TListBoxItem;
  Row: array of TListBoxItem;
begin
  Result := LocalRect;
  if FUpdating > 0 then
    Exit;
  if not Assigned(ContentLayout) then
    Exit;

  R := ContentLayout.LocalRect;
  { FContent }
  if Assigned(Content) then
  begin
    { Sort if need }
    SortItems;
    { Set Selection }
    if not MultiSelect and Assigned(Selected) then
      Selected.IsSelected := True;
    { Align }
    case FListStyle of
      TListStyle.lsVertical:
        begin
          { find number of columns and their width }
          if FItemWidth <> 0 then
          begin
            FColumns := Min(Max(1, Trunc(R.Width / FItemWidth)), Content.ControlsCount);
            ColWidth := FItemWidth
          end
          else
            ColWidth := Trunc(R.Width / FColumns);

          CurY := 0;
          J := 0;
          RowHeight := 0;
          SetLength(Row, FColumns);
          for LItem in TControlsFilter<TListBoxItem>.Filter(Content.Controls) do
          begin
            if FItemHeight <> 0 then H := FItemHeight else H := LItem.Height;
            RowHeight := Max(RowHeight, H + LItem.Margins.Top + LItem.Margins.Bottom);
            Row[J] := LItem;
            Inc(J);
            if J = FColumns then
            begin
              Align(Row, J, 0, CurY, ColWidth, 0, ColWidth, RowHeight);
              CurY := CurY + RowHeight;
              J := 0;
              RowHeight := 0;
            end;
          end;
          if J > 0 then       // align the last row
          begin
            Align(Row, J, 0, CurY, ColWidth, 0, ColWidth, RowHeight);
            CurY := CurY + RowHeight;
          end;
          if CurY > 0 then
            R.Bottom := R.Top + CurY;
          if FItemWidth <> 0 then
            R.Right := R.Left + (FItemWidth * FColumns);
        end;
      TListStyle.lsHorizontal:
        begin
          { correct items size }
          if FItemHeight <> 0 then
          begin
            FColumns := Min(Max(1, Trunc(R.Height / FItemHeight)), Content.ControlsCount);
            RowHeight := FItemHeight
          end
          else
            RowHeight := (R.Bottom - R.Top) / FColumns;

          J := 0;
          ColWidth := 0;
          CurY := 0;
          SetLength(Row, FColumns);
          for LItem in TControlsFilter<TListBoxItem>.Filter(Content.Controls) do
          begin
            if FItemWidth <> 0 then W := FItemWidth else W := LItem.Width;
            ColWidth := Max(ColWidth, W + LItem.Margins.Left + LItem.Margins.Right);
            Row[J] := LItem;
            Inc(J);
            if J = FColumns then
            begin
              Align(Row, J, CurY, 0, 0, RowHeight, ColWidth, RowHeight);
              CurY := CurY + ColWidth;
              J := 0;
              ColWidth := 0;
            end;
          end;
          if J > 0 then
          begin
            Align(Row, J, CurY, 0, 0, RowHeight, ColWidth, RowHeight);
            CurY := CurY + ColWidth;
          end;

          if CurY > 0 then
            R.Right := R.Left + CurY;
          if FItemHeight <> 0 then
            R.Bottom := R.Top + (FItemHeight * FColumns);
        end;
    end;
  end;
  UpdateVisibleItems;
  UpdateSelection;
  Result := R;
end;

procedure TCustomListBox.UpdateVisibleItems;
var
  I, Mid, First, Last: Integer;
  R: TRectF;
  H: Single;
  OldFirstVisibleItem: Integer;
  OldLastVisibleItem: Integer;
begin
  OldFirstVisibleItem := Min(FFirstVisibleItem, Content.ControlsCount);
  OldLastVisibleItem := Min(FLastVisibleItem, Content.ControlsCount);

  FFirstVisibleItem := -1;
  FLastVisibleItem := -1;
  if Assigned(Content) and (Content.ControlsCount > 0) then
  begin
    { Calc dimention }
    First := 0;
    Last := Content.ControlsCount;

    while (First < Last) do
    begin
      Mid := First + (Last - First) div 2;
      R := ListItems[Mid].AbsoluteRect;
      R.TopLeft := AbsoluteToLocal(R.TopLeft);
      R.BottomRight := AbsoluteToLocal(R.BottomRight);
      if R.Bottom < 0 then
        First := Mid + 1
      else if R.Top > Height then
        Last := Mid
      else
        Break;
    end;

    { Check each }
    for I := First to Last - 1 do
    begin
      R := ListItems[I].AbsoluteRect;
      R.TopLeft := AbsoluteToLocal(R.TopLeft);
      R.BottomRight := AbsoluteToLocal(R.BottomRight);
      if ListStyle = TListStyle.lsVertical then
      begin
        if (FFirstVisibleItem < 0) and (R.Bottom >= FHeaderCompartment.Height) then
          FFirstVisibleItem := I;
        if (FLastVisibleItem < 0) and (R.Top >= Height) then
        begin
          FLastVisibleItem := I;
          Break;
        end;
      end
      else
      begin
        if (FFirstVisibleItem < 0) and (R.Right >= 0) then
          FFirstVisibleItem := I;
        if (FLastVisibleItem < 0) and (R.Left >= Width) then
        begin
          FLastVisibleItem := I;
          Break;
        end;
      end;
    end;
    if FFirstVisibleItem < 0 then
      FFirstVisibleItem := First;
    if FLastVisibleItem < 0 then
      FLastVisibleItem := Last;
  end
  else
  begin
    FFirstVisibleItem := 0;
    FLastVisibleItem := 0;
  end;
  { Disappear invisible - need optimization }
  if Assigned(Content) and (Content.ControlsCount > 0) then
  begin
    if FFirstVisibleItem > OldLastVisibleItem then
      for I := OldFirstVisibleItem to OldLastVisibleItem - 1 do
        ListItems[I].Disappear;
    if FLastVisibleItem < OldFirstVisibleItem then
      for I := OldFirstVisibleItem to OldLastVisibleItem - 1 do
        ListItems[I].Disappear;
    if (FFirstVisibleItem >= OldFirstVisibleItem) and (FFirstVisibleItem < OldLastVisibleItem) then
      for I := OldFirstVisibleItem to FFirstVisibleItem - 1 do
        ListItems[I].Disappear;
    if (FLastVisibleItem >= OldFirstVisibleItem) and (FLastVisibleItem < OldLastVisibleItem) then
      for I := FLastVisibleItem to OldLastVisibleItem - 1 do
        ListItems[I].Disappear;
  end;

  TListBoxContent(Content).RecalcUpdateRect;
  { }
  H := Content.Height;
  if H = 0 then H := 1;
  FNoItemsContent.SetBounds(Content.Position.X, Content.Position.Y, Content.Width, H);
end;


procedure TCustomListBox.UpdateStickyHeader;
var
  G: Integer;
  Header, HeaderClone, Item: TListBoxItem;
  I: Integer;
  R, RH: TRectF;
begin
  if not Assigned(FContentOverlay) or (csDesigning in ComponentState) then
    Exit;

  if FGroupingKind = TListGroupingKind.gsGrouped then
  begin
    FContentOverlay.Visible := False;
    Exit;
  end;

  // Ensure that groups are updated if there are pending changes
  RealUpdateGroups;

  G := FGroups.FindGroup(FFirstVisibleItem);
  HeaderClone := nil;

  if (G <> -1) and (FGroups[G].First <> -1) and (FGroups[G].Length > 0) then
  begin
    Header := ListItems[FGroups[G].First];
    if Assigned(Header) and (Header is TListBoxGroupHeader) then
    begin
      if FContentOverlay.ChildrenCount > 0 then
        HeaderClone := TListBoxItem(FContentOverlay.Children[0]);

      if (HeaderClone = nil) or (HeaderClone.Owner <> Header) then
      begin
        FContentOverlay.BeginUpdate;
        FContentOverlay.DeleteChildren;

        HeaderClone := TListBoxItem(Header.Clone(Header));
        HeaderClone.Locked := True;
        HeaderClone.Stored := False;
        HeaderClone.Text := Header.Text; // Clone ignores default values
        HeaderClone.Parent := FContentOverlay;
        FDisableAlign := True;
        FContentOverlay.EndUpdate;
        FDisableAlign := False;
      end
      else
        HeaderClone.SetBounds(
          HeaderClone.Position.X,
          HeaderClone.Position.Y,
          Header.Width,
          Header.Height
        );
      HeaderClone.Position.Y := HeaderClone.Margins.Top + FContentOverlay.Padding.Top;
      HeaderClone.Position.X := HeaderClone.Margins.Left + FContentOverlay.Padding.Left;
    end
    else
      FContentOverlay.DeleteChildren;
  end;

  if Assigned(HeaderClone) then
  begin
    RH := HeaderClone.AbsoluteRect;

    for I := FFirstVisibleItem to FLastVisibleItem do
    begin
      Item := ListItems[I];
      if Item is TListBoxGroupHeader then
      begin
        if (HeaderClone.Owner <> Item) then
        begin
          R := Item.AbsoluteRect;
          if R.Top - RH.Bottom < 0 then
          begin
            HeaderClone.Position.Y := R.Top - RH.Bottom;
            Break;
          end;
        end;
      end;
    end;
  end;
  FContentOverlay.Visible := (HeaderClone <> nil) and (ViewportPosition.Y >= 0);
end;

function TCustomListBox.GetCount: Integer;
begin
  Result := Content.ControlsCount;
end;

function TCustomListBox.ItemByIndex(const Idx: Integer): TListBoxItem;
var
  Obj: TFmxObject;
begin
  if (Idx >= 0) and (Idx < Content.ControlsCount) then
  begin
    Obj := Content.Controls[Idx];
    Result := TListBoxItem(Obj)
  end
  else
    Result := nil;
end;

function TCustomListBox.ItemByPoint(const X, Y: Single): TListBoxItem;
var
  i: Integer;
  P: TPointF;
  LItem: TListBoxItem;
begin
  P := LocalToAbsolute(PointF(X, Y));
  for i := FFirstVisibleItem to FLastVisibleItem - 1 do
  begin
    LItem := ItemByIndex(i);
    if not LItem.Visible then
      Continue;
    if LItem.PointInObject(P.X, P.Y) then
    begin
      Result := LItem;
      Exit;
    end
  end;
  Result := nil;
end;

procedure TCustomListBox.KeyDown(var Key: Word; var KeyChar: System.WideChar; Shift: TShiftState);
var
  i: Integer;
  LItemIndex: Integer;
  LChanged: Boolean;
begin
  LItemIndex := ItemIndex;
  if Observers.IsObserving(TObserverMapping.EditLinkID) then
    if (KeyChar > ' ') or
      (Key in [vkHome, vkEnd, vkUp, vkDown, vkRight, vkLeft]) then
      if TLinkObservers.EditLinkIsReadOnly(Observers) then
        Exit
      else
        if not TLinkObservers.EditLinkEdit(Observers) then
          Exit;
  inherited;
  if Count > 0 then
  begin
    if KeyChar <> #0 then
    begin
      for i := 0 to Count - 1 do
        if (ItemByIndex(I).Text <> '') and (string(ItemByIndex(I).Text.Chars[0]).ToLower = string(KeyChar).ToLower) then
        begin
          LItemIndex := i;
          Break;
        end;
      KeyChar := #0;
    end;
    case Key of
      vkHome:
        LItemIndex := 0;
      vkEnd:
        LItemIndex := Count - FColumns;
      vkUp:
        If ItemIndex > 0 then
        begin
          LItemIndex := LItemIndex - FColumns;
          if LItemIndex < 0 then
            LItemIndex := 0;
        end;
      vkDown:
        begin
          If LItemIndex < Count - 1 then
            LItemIndex := LItemIndex + FColumns;
          if LItemIndex > Count - 1 then
            ItemIndex := Count - 1;
        end;
      vkLeft:
        If LItemIndex > 0 then
          LItemIndex := ItemIndex - 1;
      vkRight:
        If LItemIndex < Count - 1 then
          LItemIndex := LItemIndex + 1;
      vkPrior:
        begin
          if LItemIndex > 0 then
            LItemIndex := LItemIndex - (FLastVisibleItem - FFirstVisibleItem);
          if LItemIndex < 0 then
            LItemIndex := 0;
        end;
      vkNext:
        begin
          if LItemIndex < Count - 1 then
            LItemIndex:= LItemIndex + (FLastVisibleItem - FFirstVisibleItem);
          if LItemIndex > Count - 1 then
            LItemIndex := Count - 1;
        end
    else
      Exit;
    end;
    LChanged := LItemIndex <> ItemIndex;
    if LChanged then
    begin
      TLinkObservers.PositionLinkPosChanging(Observers);
                                    
      ItemIndex := LItemIndex;
    end;
    if ItemIndex > -1 then
      if MultiSelect then
        if not (ssShift in Shift) then
        begin
          ClearSelection;
          ItemByIndex(ItemIndex).IsSelected := True;
        end;
    if LChanged then
    begin
      TLinkObservers.ListSelectionChanged(Observers);
    end;
    Key := 0;
  end;
end;

procedure TCustomListBox.KeyUp(var Key: Word; var KeyChar: System.WideChar; Shift: TShiftState);
begin
  inherited;
end;

procedure TCustomListBox.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
var
  LItemIndex: Integer;
  LBitMap: TBitmap;
  P: TPointF;
begin
  FClickEnable := (Button <> TMouseButton.mbLeft) or
                  AniCalculations.LowVelocity or
                  (AniCalculations.TouchTracking = []);
  LItemIndex := ItemIndex;
  if Observers.IsObserving(TObserverMapping.EditLinkID) then
    if not TLinkObservers.EditLinkEdit(Observers) then
      Exit;

  inherited;

  if not FClickEnable then
    Exit;
  FItemDown := ItemByPoint(X, Y);
  if Assigned(FItemDown) and (FItemDown.Index <> ItemIndex) then
    TLinkObservers.PositionLinkPosChanging(Observers);
  if Assigned(FItemDown) then
  begin
    P := TPointF.Create(X, Y);
    P := FItemDown.ScreenToLocal(LocalToScreen(P));
    FItemDown.MouseDown(Button, Shift, P.X, P.Y);
  end;

  if (Button = TMouseButton.mbLeft)
    and (AniCalculations.TouchTracking <> [])
    and Assigned(FItemDown) then
  begin
    InitiateSelectionTimer(250, FItemDown);
  end
  else
  if (Button = TMouseButton.mbLeft) and (AniCalculations.TouchTracking = []) then
  begin
    if Assigned(FItemDown) then
    begin
      if MultiSelect then
      begin
{$IFDEF MACOS}
        if ssCommand in Shift then
{$ELSE}
        if ssCtrl in Shift then
{$ENDIF}
          FItemDown.IsSelected := not FItemDown.IsSelected
        else if ssShift in Shift then
        begin
          SelectRange(Selected, FItemDown);
          ItemIndex := FItemDown.Index;
        end
        else
        begin
          SelectRange(FItemDown, FItemDown);
          ItemIndex := FItemDown.Index;
        end;
        FFirstSelect := FItemDown;
      end
      else
      begin
        if ItemIndex <> FItemDown.Index then
          ItemIndex := FItemDown.Index
        else
          if AllowDrag then
          begin
            LBitMap := FItemDown.MakeScreenshot;
            try
              Root.BeginInternalDrag(Selected, LBitMap);
            finally
              LBitMap.Free;
            end;
          end;
      end;
    end;
    FMouseSelecting := True;
  end;
  if LItemIndex <> ItemIndex then
  begin
    TLinkObservers.ListSelectionChanged(Observers);
  end;
end;

procedure TCustomListBox.MouseMove(Shift: TShiftState; X, Y: Single);
var
  Item: TListBoxItem;
  LItemIndex: Integer;
  P: TPointF;
begin
  LItemIndex := ItemIndex;
  inherited;
  Item := ItemByPoint(X, Y);
  if Assigned(Item) then
  begin
    P := TPointF.Create(X, Y);
    P := Item.ScreenToLocal(LocalToScreen(P));
    Item.MouseMove(Shift, P.X, P.Y);
  end;
  if (ssLeft in Shift) and FMouseSelecting then
  begin
    if Assigned(Item) then
    begin
      if Selected = Item then
        Exit;
      if Observers.IsObserving(TObserverMapping.EditLinkID) then
        if not TLinkObservers.EditLinkEdit(Observers) then
          Exit;
      TLinkObservers.PositionLinkPosChanging(Observers);
      if MultiSelect then
      begin
{$IFDEF MACOS}
        if ssCommand in Shift then
{$ELSE}
        if ssCtrl in Shift then
{$ENDIF}
          Item.IsSelected := not Item.IsSelected
        else
          SelectRange(FFirstSelect, Item);
        ItemIndex := Item.Index;
      end
      else
        ItemIndex := Item.Index;
      if ItemIndex <> LItemIndex then
        TLinkObservers.ListSelectionChanged(Observers);
    end;
  end;
end;

procedure TCustomListBox.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
var
  Item: TListBoxItem;
  LItemIndex: Integer;
  P: TPointF;
begin
  inherited;
  FFirstSelect := nil;
  try
    FMouseUp := True;
    if (not AniCalculations.Moved) and (FClickEnable) then
    begin
      if Assigned(FSelectionTimer) and FSelectionTimer.Enabled then
      begin
        if MultiSelect then
          SelectionTimerNotify(Self);
      end;

      Item := ItemByPoint(X, Y);
      if Assigned(Item) and (Item = FItemDown) then
      begin
        LItemIndex := Item.Index;
        if LItemIndex <> ItemIndex then
        begin
          TLinkObservers.PositionLinkPosChanging(Observers);
                                        
          ItemIndex := LItemIndex;
          TLinkObservers.ListSelectionChanged(Observers);
        end;
        if Assigned(OnItemClick) then
          OnItemClick(Self, Item);
        P := TPointF.Create(X, Y);
        P := Item.ScreenToLocal(LocalToScreen(P));
        Item.MouseUp(Button, Shift, P.X, P.Y);
      end;
    end;
  finally
    FClickEnable := False;
    FMouseSelecting := False;
    FMouseUp := False;
  end;
end;

procedure TCustomListBox.NotifyInflated;
begin
  RealignContent;
  UpdateGroups;
  UpdateStickyHeader;
end;

procedure TCustomListBox.Painting;
begin
  inherited;
  RealUpdateGroups;
  FBeingPainted := True;
  FRealignRequested := False;
end;

procedure TCustomListBox.AfterPaint;
begin
  inherited;
  FBeingPainted := False;
  if FRealignRequested then
    Realign;
  FRealignRequested := False;
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

function TCustomListBox.GetSelected: TListBoxItem;
begin
  Result := ItemByIndex(FItemIndex);
end;

procedure TCustomListBox.SetItemIndex(const Value: Integer);
var
  Item: TListBoxItem;
begin
  if FItemIndex <> Value then
  begin
    Item := ItemByIndex(ItemIndex);
    FUpdating := FUpdating + 1;
    try
      // if not MultiSelect, de-select the previous selected item
      if Assigned(Item) and (not MultiSelect) then
        Item.IsSelected := False;

      // set and get the new list item
      FItemIndex := Value;
      Item := ItemByIndex(FItemIndex);

      if Assigned(Item) and Assigned(Content) and Assigned(VScrollBar)
        and Assigned(ContentLayout) then
      begin
        if Content.Position.Y + Item.Position.Y + Item.Margins.Top + Item.Margins.Bottom + Item.Height >
          ContentLayout.Position.Y + ContentLayout.Height then
          VScrollBar.Value := VScrollBar.Value + (Content.Position.Y + Item.Position.Y + Item.Margins.Top +
            Item.Margins.Bottom + Item.Height - ContentLayout.Position.Y - ContentLayout.Height);
        if Content.Position.Y + Item.Position.Y < ContentLayout.Position.Y then
          VScrollBar.Value := VScrollBar.Value + Content.Position.Y + Item.Position.Y - ContentLayout.Position.Y;
      end;
      if Assigned(Item) and Assigned(Content) and Assigned(HScrollBar) and Assigned(ContentLayout) then
      begin
        if Content.Position.X + Item.Position.X + Item.Margins.Left + Item.Margins.Right + Item.Width >
          ContentLayout.Position.X + ContentLayout.Width then
          HScrollBar.Value := HScrollBar.Value + (Content.Position.X + Item.Position.X + Item.Margins.Left +
            Item.Margins.Right + Item.Width - ContentLayout.Position.X - ContentLayout.Width);
        if Content.Position.X + Item.Position.X < 0 then
          HScrollBar.Value := HScrollBar.Value + Content.Position.X + Item.Position.X - ContentLayout.Position.X;
      end;

      if Assigned(Item) and not (FMouseUp and MultiSelect) then
        Item.IsSelected := True;
    finally
      FUpdating := FUpdating - 1;
    end;

    if (FUpdating = 0) then
    begin
      if not (csLoading in ComponentState) then
        DoChange;
    end;
    UpdateSelection;
  end;
end;

procedure TCustomListBox.SetItems(const Value: TStrings);
begin
  Items.Assign(Value);
end;

procedure TCustomListBox.DoChangeCheck(const Item: TListBoxItem);
begin
  if Assigned(FOnChangeCheck) then
    FOnChangeCheck(Item);
end;

procedure TCustomListBox.DoChange;
begin
  if Assigned(FOnChange) then
    FOnChange(ItemByIndex(FItemIndex));
end;

procedure TCustomListBox.Clear;
begin
  BeginUpdate;
  try
    RealignContent;
    FToInflate.Clear;
    if Assigned(Content) then
      Content.DeleteChildren;
    FGroups.Clear;
    FItemIndex := -1;
  finally
    EndUpdate;
  end;
end;

procedure TCustomListBox.SelectRange(const Item1, Item2: TListBoxItem);
var
  I: Integer;
begin
  if not Multiselect then
    Exit;

  if (not Assigned(Item1)) or (not Assigned(Item2)) then
    Exit;

  for I := 0 to Min(Item1.Index, Item2.Index) - 1 do
    ItemByIndex(I).IsSelected := False;
  for I := Max(Item1.Index, Item2.Index) + 1 to Count - 1 do
    ItemByIndex(I).IsSelected := False;
  for I := Min(Item1.Index, Item2.Index) to Max(Item1.Index, Item2.Index) do
    ItemByIndex(I).IsSelected := True;
end;

procedure TCustomListBox.ClearSelection;
var
  I: Integer;
begin
  BeginUpdate;
  for i := 0 to Count - 1 do
    ItemByIndex(I).IsSelected := False;
  EndUpdate;
end;

procedure TCustomListBox.SelectAll;
var
  I: Integer;
begin
  if MultiSelect then
  begin
    BeginUpdate;
    for I := 0 to Count - 1 do
      ItemByIndex(I).IsSelected := True;
    EndUpdate;
  end;
end;

procedure TCustomListBox.SelectionTimerNotify(Sender: TObject);
begin
  FSelectionTimer.Enabled := False;
  if Assigned(FSelectionTimerTarget) then
  begin
    if MultiSelect then
      FSelectionTimerTarget.IsSelected := not FSelectionTimerTarget.IsSelected
    else
      ItemIndex := FSelectionTimerTarget.Index;
  end;
end;

procedure TCustomListBox.InitiateSelectionTimer(Interval: Integer;
  const Item: TListBoxItem);
begin
  if not Assigned(FSelectionTimer) then
  begin
    FSelectionTimer := TTimer.Create(nil);
    FSelectionTimer.OnTimer := SelectionTimerNotify;
  end;

  FSelectionTimer.Enabled := False;
  FSelectionTimerTarget := Item;
  if (Interval > 0) and Assigned(Item) then
  begin
    FSelectionTimer.Interval := Interval;
    FSelectionTimer.Enabled := True;
  end
end;

procedure TCustomListBox.DoEnter;
begin
  inherited;
  if Assigned(Selected) then
    UpdateSelection;
end;

procedure TCustomListBox.DoExit;
begin
  inherited;
  if Assigned(Selected) then
    UpdateSelection;
  if Observers.IsObserving(TObserverMapping.EditLinkID) then
    if TLinkObservers.EditLinkIsEditing(Observers) then
      TLinkObservers.EditLinkUpdate(Observers);
  if Observers.IsObserving(TObserverMapping.ControlValueID) then
    TLinkObservers.ControlValueUpdate(Observers);
end;

function TCustomListBox.DragChange(const SourceItem, DestItem: TListBoxItem): Boolean;
begin
  Result := True;
  if Assigned(FOnDragChange) then
    FOnDragChange(SourceItem, DestItem, Result);
end;

procedure TCustomListBox.DragDrop(const Data: TDragObject; const Point: TPointF);
var
  Obj: TListBoxItem;
  P: TPointF;
begin
  inherited;
  if Assigned(FDragItem) then
  begin
    FDragItem.DragLeave;
    FDragItem := nil;
  end;
  P := AbsoluteToLocal(Point);
  Obj := ItemByPoint(P.X, P.Y);
  if Assigned(Obj) and DragChange(TListBoxItem(Data.Source), Obj) then
    Exchange(TListBoxItem(Data.Source), Obj);
end;

procedure TCustomListBox.DragOver(const Data: TDragObject; const Point: TPointF; var Accept: Boolean);
var
  Obj: TListBoxItem;
begin
  inherited;
  Obj := ItemByPoint(Point.X,Point.Y);
  if (Obj <> FDragItem) then
  begin
    if Assigned(FDragItem) then
      FDragItem.DragLeave;
    FDragItem := Obj;
    if Assigned(FDragItem) then
    begin
      FDragItem.DragEnter(Data, Point);
      Accept := True;
    end
    else
      Accept := False;
  end
  else
    Accept := True;

  if Assigned(FDragItem) then
    if FDragItem.Equals(Data.Source) then
      Accept := False;
end;

procedure TCustomListBox.ItemsExchange(Item1, Item2: TListBoxItem);
begin
  if Item1.Index = FItemIndex then
    FItemIndex := Item2.Index
  else
    if Item2.Index = FItemIndex then
      FItemIndex := Item1.Index;
  Content.Exchange(Item1, Item2);
end;

procedure TCustomListBox.DoAddObject(const AObject: TFmxObject);
begin
  if Assigned(Content) and (AObject is TListBoxItem) then
    Content.AddObject(AObject)
  else
    inherited;
end;

procedure TCustomListBox.DoInsertObject(Index: Integer; const AObject: TFmxObject);
begin
  if Assigned(Content) and (AObject is TListBoxItem) then
    Content.InsertObject(Index, AObject)
  else
    inherited;
end;

procedure TCustomListBox.IgnoreString(Reader: TReader);
begin
  Reader.ReadString;
end;

function TCustomListBox.IsAddToContent(const AObject: TFmxObject): Boolean;
begin
  Result := inherited IsAddToContent(AObject) and (AObject <> FNoItemsContent)
    and (AObject <> FHeaderCompartment) and (AObject <> FFooterCompartment)
    and (AObject <> FContentOverlay);
end;

function TCustomListBox.IsOpaque: Boolean;
begin
  Result := True;
end;

procedure TCustomListBox.DoRealign;
  procedure Relocate(const C: TControl; const HeadRect, FootRect: TRectF);
  begin
      case C.Align of
      TAlignLayout.alBottom:
        begin
        C.Parent := FFooterCompartment;
        FootRect.Height := FootRect.Height + C.BoundsRect.Height;
        end;
      TAlignLayout.alTop:
        begin
        C.Parent := FHeaderCompartment;
        HeadRect.Height := HeadRect.Height + C.BoundsRect.Height;
        end;
      end;
  end;

var
  C, Layout: TControl;
  HeadRect, FootRect: TRectF;
begin
  if FBeingPainted then
  begin
    FRealignRequested := True;
    Exit;
  end;

  if (csDesigning in ComponentState) and Assigned(FInflater) then
    FInflater.Inflate(True);

  inherited;

  UpdateSelection;
  HeadRect := TRectF.Empty;
  FootRect := TRectF.Empty;

  for C in FHeaderCompartment.Controls do
    if (C.Owner <> nil) and (C.Visible) then
      Relocate(C, HeadRect, FootRect);
  for C in FFooterCompartment.Controls do
    if (C.Owner <> nil) and (C.Visible) then
      Relocate(C, HeadRect, FootRect);

  FHeaderCompartment.Height := HeadRect.Height;
  FHeaderCompartment.Visible := HeadRect.Height > 0;
  FFooterCompartment.Height := FootRect.Height;
  FFooterCompartment.Visible := FootRect.Height > 0;

  Layout := TControl(FHeaderCompartment.TagObject);
  if Assigned(Layout) then
  begin
    TControl(Layout).Height := FHeaderCompartment.Height;
    TControl(Layout).Visible := FHeaderCompartment.Visible;
  end;
  Layout := TControl(FFooterCompartment.TagObject);
  if Assigned(Layout) then
  begin
    TControl(Layout).Height := FFooterCompartment.Height;
    TControl(Layout).Visible := FFooterCompartment.Visible;
  end;

end;

procedure TCustomListBox.DoRemoveObject(const AObject: TFmxObject);
begin
  if (AObject is TListBoxItem) and (TListBoxItem(AObject).ListBox = Self) then
    TListBoxItem(AObject).Parent := nil
  else
    inherited;
end;

procedure TCustomListBox.DoStyleChanged;
var
  i: Integer;
  Item: TListBoxItem;
begin
  inherited;
  FToInflate.Clear;
  for i := 0 to Count - 1 do
  begin
    Item := ListItems[i];
    Item.DoStyleChanged;
    FToInflate.Add(Item);
  end;
  FInflater.Inflate(csDesigning in ComponentState);
end;

procedure TCustomListBox.SetColumns(const Value: Integer);
begin
  if FColumns <> Value then
  begin
    FColumns := Value;
    if FColumns < 1 then
      FColumns := 1;
    RealignContent;
  end;
end;

procedure TCustomListBox.SetAlternatingRowBackground(const Value: Boolean);
begin
  if FAlternatingRowBackground <> Value then
  begin
    FAlternatingRowBackground := Value;
    Repaint;
  end;
end;

procedure TCustomListBox.SetMultiSelect(const Value: Boolean);
begin
  if FMultiSelect <> Value then
  begin
    FMultiSelect := Value;
    if not FMultiSelect then
      ClearSelection;
  end;
end;

procedure TCustomListBox.SetItemHeight(const Value: Single);
begin
  if FItemHeight <> Value then
  begin
    FItemHeight := Value;
    RealignContent;
  end;
end;

procedure TCustomListBox.SetItemWidth(const Value: Single);
begin
  if FItemWidth <> Value then
  begin
    FItemWidth := Value;
    RealignContent;
  end;
end;

procedure TCustomListBox.SetListStyle(const Value: TListStyle);
begin
  if FListStyle <> Value then
  begin
    FListStyle := Value;
    UpdateAniCalculations;
    RealignContent;
  end;
end;

procedure TCustomListBox.SetShowCheckboxes(const Value: Boolean);
var
  I: Integer;
begin
  if FShowCheckboxes <> Value then
  begin
    FShowCheckboxes := Value;
    BeginUpdate;
    for I := 0 to Count - 1 do
      ItemByIndex(i).UpdateCheck;
    EndUpdate;
  end;
end;

function TCustomListBox.GetListItem(Index: Integer): TListBoxItem;
begin
  Result := ItemByIndex(Index);
end;

procedure TCustomListBox.SetSorted(const Value: Boolean);
begin
  if FSorted <> Value then
  begin
    FSorted := Value;
    if FSorted then
      Sort(CompareListItem);
    Realign;
  end;
end;

procedure TCustomListBox.SetAllowDrag(const Value: Boolean);
begin
  if FAllowDrag <> Value then
  begin
    FAllowDrag := Value;
    if FAllowDrag then
      EnableDragHighlight := True;
  end;
end;

function TCustomListBox.GetItem(const AIndex: Integer): TFmxObject;
begin
  Result := ItemByIndex(AIndex);
end;

{ TComboListBox }

constructor TComboListBox.Create(AOwner: TComponent);
begin
  inherited;
  MinClipWidth := 16;
  MinClipHeight := 14;
  Margins.Rect := RectF(1, 1, 1, 1);
  if AOwner is TCustomComboBox then
    FComboBox := TCustomComboBox(AOwner);
end;

function TComboListBox.GetDefaultStyleLookupName: string;
begin
  Result := 'transparentlistboxstyle';
end;

function TComboListBox.GetObservers: TObservers;
begin
  if Assigned(FComboBox) then
    Result := FComboBox.Observers
  else
    Result := inherited;
end;

procedure TComboListBox.KeyDown(var Key: Word; var KeyChar: System.WideChar; Shift: TShiftState);
begin
  inherited;
  if Key = vkReturn then
  begin
    if (Parent is TPopup) and TPopup(Parent).IsOpen and Assigned(FComboBox) then
    begin
      FComboBox.ItemIndex := ItemIndex;
      TPopup(Parent).IsOpen := False;
    end;
  end;
end;

procedure TComboListBox.MouseMove(Shift: TShiftState; X, Y: Single);
var
  Item: TListBoxItem;
  LItemIndex: Integer;
begin
  inherited;
  Item := ItemByPoint(X, Y);
  if Assigned(Item) then
  begin
    if Selected = Item then
      Exit;
    if Observers.IsObserving(TObserverMapping.EditLinkID) then
      if TLinkObservers.EditLinkIsReadOnly(Observers) then
        Exit
      else
        if not TLinkObservers.EditLinkEdit(Observers) then
          Exit;
    TLinkObservers.PositionLinkPosChanging(Observers);
    LItemIndex := ItemIndex;
    if MultiSelect then
    begin
{$IFDEF MACOS}
      if ssCommand in Shift then
{$ELSE}
      if ssCtrl in Shift then
{$ENDIF}
        Item.IsSelected := not Item.IsSelected
      else
        SelectRange(FFirstSelect, Item);
      ItemIndex := Item.Index;
    end
    else
      ItemIndex := Item.Index;
    FComboBox.ItemIndex := ItemIndex;
    FComboBox.Repaint;
    if LItemIndex <> ItemIndex then
    begin
      TLinkObservers.ListSelectionChanged(Observers);
    end;
  end;
end;

procedure TComboListBox.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
var
  LItem : TListBoxItem;
  LItemIndex: Integer;
begin
  inherited;
  if (Parent is TPopup) and TPopup(Parent).IsOpen and Assigned(FComboBox) then
  begin
    LItemIndex := ItemIndex;
    if LocalRect.Contains(PointF(X, Y)) then
    begin
      LItem := ItemByPoint(X, Y) ;
      if Assigned(LItem) then
      begin
        if LItem.Index <> FComboBox.ItemIndex then
          TLinkObservers.PositionLinkPosChanging(Observers);
        if Observers.IsObserving(TObserverMapping.EditLinkID) then
        begin
          if TLinkObservers.EditLinkIsEditing(Observers) then
            FComboBox.ItemIndex := LItem.Index;
        end
        else
          FComboBox.ItemIndex := LItem.Index;
      end;
    end;
    TPopup(Parent).IsOpen := False;
    if LItemIndex <> ItemIndex then
    begin
      TLinkObservers.ListSelectionChanged(Observers);
    end;

  end;
end;

{ TComboBox }

constructor TCustomComboBox.Create(AOwner: TComponent);
var
  PickerService: IFMXPickerService;
begin
  inherited;
  if TPlatformServices.Current.SupportsPlatformService(IFMXPickerService, IInterface(PickerService)) then
  begin
    FListPicker := PickerService.CreateListPicker;
    FListPicker.Parent := Self;
    FListPicker.OnValueChanged := DoOnValueChangedFromDropDownList;
    FListPicker.OnHide := DoClosePicker;
    FListPicker.OnShow := DoPopup;
  end;
  FDropDownKind := TDropDownKind.ddkCustom;
  DropDownCount := 8;
  CanFocus := True;
  FDroppedDown := False;
  FPopup := TPopup.Create(Self);
  FPopup.StyleLookup := 'combopopupstyle';
  FPopup.PlacementTarget := Self;
  FPopup.StaysOpen := False;
  FPopup.Stored := False;
  FPopup.Parent := Self;
  FPopup.Locked := True;
  FPopup.DesignVisible := False;
  FPopup.DragWithParent := True;
  FPopup.OnClosePopup := DoClosePopup;
  FPopup.OnPopup := DoPopup;
  FListBox := CreateListBox;
  FListBox.Parent := Popup;
  FListBox.Stored := False;
  FListBox.Align := TAlignLayout.alClient;
  FListBox.ShowCheckboxes := False;
  FItemIndex := -1;
  SetAcceptsControls(False);
  DropDownKind := TDropDownKind.ddkNative;
end;

function TCustomComboBox.CreateListBox: TComboListBox;
begin
  Result := TComboListBox.Create(Self);
end;

function TCustomComboBox.CanObserve(const ID: Integer): Boolean;
begin
  Result := FListBox.CanObserve(ID);
end;

procedure TCustomComboBox.ApplyStyle;
var
  T: TFmxObject;
begin
  inherited;
  T := FindStyleResource('Content');
  if Assigned(T) and (T is TControl) then
  begin
    TControl(T).OnPaint := DoContentPaint;
    UpdateCurrentItem;
  end;
end;

procedure TCustomComboBox.DoRealign;
begin
  inherited;
  if FDisableAlign then
    Exit;
  FDisableAlign := True;
  { FContent }
  if Assigned(FPopup) then
    FPopup.Width := Width;
  FDisableAlign := False;
end;

procedure TCustomComboBox.UpdateCurrentItem;
var
  C: TFmxObject;
  Item: TListBoxItem;
  NewHeight: Single;
begin
  if Not Assigned(FListBox) then
    Exit;
  Item := FListBox.ItemByIndex(FListBox.ItemIndex);
  if Assigned(Item) then
  begin
    C := FindStyleResource('Content');
    if Assigned(C) and (C is TControl) then
    begin
      if Item.Height <> 0 then
        NewHeight := Item.Height
      else if ItemHeight = 0 then
        NewHeight := TControl(C).Height
      else
        NewHeight := ItemHeight;
      Item.SetBounds(Item.Position.X, Item.Position.Y, Item.Width, NewHeight);
      Item.ApplyStyleLookup;
    end;
  end;
end;

procedure TCustomComboBox.DoContentPaint(Sender: TObject; Canvas: TCanvas; const ARect: TRectF);
var
  SOpacity: Single;
  Item: TListBoxItem;
  SaveSize: TPointF;
  SaveScene: IScene;
  SaveSelected: Boolean;
begin
  if Assigned(FListBox) then
  begin
    Item := FListBox.ItemByIndex(FListBox.ItemIndex);
    if Assigned(Item) then
    begin
      SOpacity := Item.FAbsoluteOpacity;
      SaveSize := PointF(Item.Width, Item.Height);
      SaveScene := Item.Scene;
      SaveSelected := Item.IsSelected;
      Item.SetNewScene(Scene);
      try
        TOpenObject(Item).FWidth := ARect.Width;
        TOpenObject(Item).FLastWidth := ARect.Width;
        TOpenObject(Item).FHeight := ARect.Height;
        TOpenObject(Item).FLastHeight := ARect.Height;
        Item.FIsSelected := False;
        Item.StartTriggerAnimation(Item, 'IsSelected'); // to correct drawing
        Item.FAbsoluteOpacity := Opacity;
        Item.RecalcOpacity;
        Item.Realign;
        Item.FRecalcOpacity := False;
        Item.PaintTo(Canvas, ARect, Sender as TFmxObject);
      finally
        Item.SetNewScene(SaveScene);
        Item.FAbsoluteOpacity := SOpacity;
        Item.RecalcOpacity;
        // Do not assign directly to FHeight/FWidth, because
        // children sizes have to be updated after Realign
        Item.FIsSelected := SaveSelected;
        Item.StartTriggerAnimation(Item, 'IsSelected');
        Item.Height := SaveSize.Y;
        Item.Width := SaveSize.X;
        TOpenObject(Item).FLastWidth := SaveSize.X;
        TOpenObject(Item).FLastHeight := SaveSize.Y;
      end;
    end;
  end;
end;

procedure TCustomComboBox.DoExit;
begin
  inherited;
  if Observers.IsObserving(TObserverMapping.EditLinkID) then
    if TLinkObservers.EditLinkIsEditing(Observers) then
      TLinkObservers.EditLinkUpdate(Observers);
  if Observers.IsObserving(TObserverMapping.ControlValueID) then
    TLinkObservers.ControlValueUpdate(Observers);
  if Assigned(FListPicker) and (TDropDownKind.ddkNative = DropDownKind) and
    FListPicker.IsShown then
  begin
    FDroppedDown := False;
    FListPicker.Hide;
  end;
  if TDropDownKind.ddkCustom = DropDownKind then
    FPopup.IsOpen := False;
end;

procedure TCustomComboBox.DoOnValueChangedFromDropDownList(Sender: TObject;
  const AValueIndex: Integer);
var
  LChanged: Boolean;
begin
  if Observers.IsObserving(TObserverMapping.EditLinkID) then
    if not TLinkObservers.EditLinkEdit(Observers) then
      Exit;
  LChanged := ItemIndex <> AValueIndex;
  if LChanged then
    TLinkObservers.PositionLinkPosChanging(Observers);
  ItemIndex := AValueIndex;
  if LChanged then
    TLinkObservers.ListSelectionChanged(Observers);
end;

procedure TCustomComboBox.DoPopup(Sender: TObject);
begin
  if Assigned(FOnPopup) then
    FOnPopup(Self);
end;

procedure TCustomComboBox.DropDown;
var
  H, BorderHeight: Single;
  Num, Count, i: Integer;
  Item: TListBoxItem;

  procedure UpdateItem(Index: Integer);
  var
    C: TFmxObject;
    Item: TListBoxItem;
    NewHeight: Single;
  begin
    if not Assigned(FListBox) then
      Exit;
    Item := FListBox.ItemByIndex(Index);
    if Assigned(Item) then
    begin
      C := FindStyleResource('Content');
      if Assigned(C) and (C is TControl) then
      begin
        if Item.Height <> 0 then
          NewHeight := Item.Height
        else if ItemHeight = 0 then
          NewHeight := TControl(C).Height
        else
          NewHeight := ItemHeight;
        Item.SetBounds(Item.Position.X, Item.Position.Y, Item.Width, NewHeight);
        Item.ApplyStyleLookup;
      end;
    end;
  end;

  function UseNativePicker: Boolean;
  begin
    Result := (TDropDownKind.ddkNative = DropDownKind) and Assigned(FListPicker);
  end;

begin
  if UseNativePicker then
  begin
    if FListPicker.IsShown then
    begin
      FDroppedDown := False;
      FListPicker.Hide;
    end
    else
    begin
      FDroppedDown := True;
      FListPicker.Values := Items;
      FListPicker.ItemIndex := ItemIndex;
      FListPicker.CountVisibleItems := DropDownCount;
      FListPicker.Show;
    end;
  end
  else
  begin
    if not FPopup.IsOpen then
    begin
      FDroppedDown := True;
      FPopup.Width := Width;
      // Resize list items to match the dimensions of the control
      if Assigned(FListbox) then
        for i := 0 to FListbox.Count - 1 do
          UpdateItem(i)
      else
        Exit;

      // calc content rect
      BorderHeight := FListBox.BorderHeight;
      //
      Count := DropDownCount;
      if FListBox.Count < Count then
        Count := FListBox.Count;
      if FListBox.ItemHeight > 0 then
        FPopup.Height := Count * FListBox.ItemHeight + BorderHeight
      else
      begin
        if Count < DropDownCount then
          FPopup.Height := FListbox.Content.Height + BorderHeight
        else
        begin
          H := 0;
          Num := 0;
          for i := 0 to FListbox.Count - 1 do
          begin
            Item := FListbox.ListItems[i];
            if Item.Position.Y >= 0 then
            begin
              H := H + Item.Height;
              Num := Num + 1;
            end;
            if Num >= Count then Break;
          end;
          FPopup.Height := H + BorderHeight +
                           FListbox.Margins.Top + FListbox.Margins.Bottom;
        end;
      end;
      FPopup.IsOpen := True;
      if FPopup.IsOpen then
        FListBox.SetFocus;
    end
    else
      FPopup.IsOpen := False;
  end;
end;

procedure TCustomComboBox.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  inherited;
  if Button = TMouseButton.mbLeft then
    DropDown;
end;

procedure TCustomComboBox.MouseWheel(Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean);
begin
  inherited;
  if WheelDelta < 0 then
  begin
    if ItemIndex < Count - 1 then
      ItemIndex := ItemIndex + 1
  end else
  begin
    if ItemIndex > 0 then
      ItemIndex := ItemIndex - 1;
  end;
  Handled := True;
end;

procedure TCustomComboBox.Notification(Component: TComponent; Operation: TOperation);
begin
  inherited Notification(Component, Operation);
  if (Operation = opRemove) and (FListBox = Component) then
    FListBox := nil;
end;

procedure TCustomComboBox.KeyDown(var Key: Word; var KeyChar: System.WideChar; Shift: TShiftState);
var
  i: Integer;
  NoVisItems: Integer;
  LItemIndex: Integer;
  LChanged: Boolean;
begin
  LItemIndex := ItemIndex;
  if Observers.IsObserving(TObserverMapping.EditLinkID) then
    if (KeyChar > ' ') or
      (Key in [vkHome, vkEnd, vkUp, vkDown, vkRight, vkLeft]) then
      if not TLinkObservers.EditLinkEdit(Observers) then
        Exit;
  inherited;
  if Count > 0 then
  begin
    if KeyChar <> #0 then
    begin
      for i := 0 to Count - 1 do
        if (FListBox.ListItems[i].Text <> '') and (string(FListBox.ListItems[i].Text.Chars[0]).ToLower = string(KeyChar).ToLower) then
        begin
          LItemIndex := i;
          Break;
        end;
      KeyChar := #0;
    end;
    case Key of
      vkHome:
        LItemIndex := 0;
      vkEnd:
        LItemIndex := Count - 1;
      vkUp:
        If LItemIndex > 0 then
        begin
          LItemIndex := LItemIndex - 1;
          if LItemIndex < 0 then
            LItemIndex := 0;
        end;
      vkDown:
        begin
          if ssAlt in Shift then
          begin
            DropDown;
          end
          else
          begin
            If LItemIndex < Count - 1 then
              LItemIndex := LItemIndex + 1;
            if LItemIndex > Count - 1 then
              LItemIndex := Count - 1;
          end;
        end;
      vkLeft:
        If LItemIndex > 0 then
          LItemIndex := LItemIndex - 1;
      vkRight:
        If LItemIndex < Count - 1 then
          LItemIndex := LItemIndex + 1;
      vkF4:
        DropDown;
      vkPrior:
        begin
          if LItemIndex > 0 then
          begin
            //calculate the number of visible items of the List Box
            NoVisItems:= DropDownCount;
            // updating the index after PageUp key is pressed
            LItemIndex:= LItemIndex - NoVisItems;
          end;
          if LItemIndex < 0 then
            LItemIndex:= 0;
        end;
      vkNext:
        begin
          if LItemIndex < Count - 1 then
          begin
            //calculate the number of visible items of the List Box
            NoVisItems:= DropDownCount;
            //updating the index after PageDown key is pressed
            LItemIndex:= LItemIndex + NoVisItems;
          end;
          if LItemIndex > Count -1 then
            LItemIndex:= Count - 1;
        end;
      vkReturn:
        DropDown;
    else
      Exit;
    end;
    LChanged := LItemIndex <> ItemIndex;
    if LChanged then
      TLinkObservers.PositionLinkPosChanging(Observers);
                                   
    ItemIndex := LItemIndex;
    if LChanged then
      TLinkObservers.ListSelectionChanged(Observers);
    Key := 0;
  end;
end;

procedure TCustomComboBox.DoChange;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

procedure TCustomComboBox.DoClosePicker(Sender: TObject);
begin
  if not (csDestroying in ComponentState) then
  begin
    FDroppedDown := False;
    if Assigned(FOnClosePopup) and (csDestroying in ComponentState) then
      FOnClosePopup(Self);
  end;
end;

procedure TCustomComboBox.DoClosePopup(Sender: TObject);
begin
  FDroppedDown := False;
  if Assigned(FListBox) then
    ItemIndex := FListBox.ItemIndex;
  if Assigned(FOnClosePopup) then
    FOnClosePopup(Self);
end;

procedure TCustomComboBox.Clear;
begin
  if Assigned(FListBox) then
    FListBox.Clear;
  FItemIndex := -1;
  Repaint;
end;

procedure TCustomComboBox.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('UseSmallScrollBars', IgnoreBoolean, nil, False);
end;

destructor TCustomComboBox.Destroy;
begin
  FreeAndNil(FListPicker);
  inherited;
end;

procedure TCustomComboBox.DoAddObject(const AObject: TFmxObject);
begin
  if Assigned(FListBox) and ((AObject is TListBoxItem)) then
  begin
    FListBox.AddObject(AObject);
  end else
    inherited;
end;

function TCustomComboBox.GetItemIndex: Integer;
begin
  Result := FItemIndex
end;

function TCustomComboBox.GetCount: Integer;
begin
  if Assigned(FListBox) then
    Result := FListBox.Count
  else
    Result := 0;
end;

function TCustomComboBox.GetDefaultSize: TSizeF;
var
  DefMetricsSrv: IFMXDefaultMetricsService;
begin
  if SupportsPlatformService(IFMXDefaultMetricsService, IInterface(DefMetricsSrv)) and DefMetricsSrv.SupportsDefaultSize(ckLabel) then
    Result := TSizeF.Create(DefMetricsSrv.GetDefaultSize(ckLabel).Width, DefMetricsSrv.GetDefaultSize(ckLabel).Height)
  else
    Result := TSizeF.Create(100, 22);
end;

procedure TCustomComboBox.SetItemIndex(const Value: Integer);
begin
  if Assigned(FListBox) then
    FListBox.ItemIndex := Value;
  if Assigned(FListPicker) then
    FListPicker.ItemIndex := Value;

  if FItemIndex <> Value then
  begin
    FItemIndex := Value;
    if Assigned(FListBox) then
    begin
      FListBox.ItemIndex := Value;
      if not (csLoading in ComponentState) then
        DoChange;
      UpdateCurrentItem;
      if Assigned(ResourceControl) then
        ResourceControl.UpdateEffects;
      Repaint;
    end;
  end;
end;

procedure TCustomComboBox.SetItems(const Value: TStrings);
begin
  FListBox.Items.Assign(Value);
end;

procedure TCustomComboBox.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
  I: Integer;
begin
  inherited;
  if Assigned(FListBox) and (FListBox.Count > 0)then
  begin
    for I := 0 to FListBox.Count - 1 do
      if FListBox.ListItems[I].Stored then
        Proc(TComponent(FListBox.ListItems[I]));
  end;
end;

function TCustomComboBox.GetListBoxResource: string;
begin
  Result := FListBox.StyleLookup;
end;

function TCustomComboBox.GetListItem(Index: Integer): TListBoxItem;
begin
  Result := FListBox.ListItems[Index];
end;

function TCustomComboBox.GetPlacement: TPlacement;
begin
  Result := FPopup.Placement;
end;

function TCustomComboBox.GetPlacementRectangle: TBounds;
begin
  Result := FPopup.PlacementRectangle;
end;

function TCustomComboBox.GetSelected: TListBoxItem;
begin
  Result := FListBox.Selected;
end;

procedure TCustomComboBox.IgnoreBoolean(Reader: TReader);
begin
  Reader.ReadBoolean;
end;

procedure TCustomComboBox.SetListBoxResource(const Value: string);
begin
  FListBox.StyleLookup := Value;
end;

procedure TCustomComboBox.SetPlacement(const Value: TPlacement);
begin
  FPopup.Placement := Value;
end;

procedure TCustomComboBox.SetPlacementRectangle(const Value: TBounds);
begin
  FPopup.PlacementRectangle := Value;
end;

procedure TCustomComboBox.Sort(Compare: TFmxObjectSortCompare);
var
  Item: TListBoxItem;
  obj: TFmxObject;
  I : Integer;
begin
  if Assigned(FListBox) then
  begin
    Item := nil;
    obj := GetItem(FListBox.ItemIndex);
    if obj is TListBoxItem then
      Item := obj as TListBoxItem;

    FListBox.Sort(Compare);
    FListBox.Sorted := True;

    // deselect all items if not MultiSelect
    if not FListBox.MultiSelect then
    begin
      for I := 0 to FListBox.Count - 1 do
        if ListBox.ListItems[I] is TListBoxItem then
          ListBox.ListItems[I].IsSelected := False;

      // and re-select the previous selected item
      if Assigned(Item) then
        Item.IsSelected := True;
    end;

    if not (csLoading in ComponentState) then
      DoChange;
  end;
end;

function TCustomComboBox.GetItems: TStrings;
begin
  Result := FListBox.Items;
end;

function TCustomComboBox.GetItemsCount: Integer;
begin
  Result := Count;
end;

function TCustomComboBox.GetItem(const AIndex: Integer): TFmxObject;
begin
  Result := FListBox.ListItems[AIndex];
end;

function TCustomComboBox.GetItemHeight: Single;
begin
  Result := FListBox.ItemHeight;
end;

procedure TCustomComboBox.SetItemHeight(const Value: Single);
begin
  if FListBox.ItemHeight <> Value then
  begin
    FListBox.ItemHeight := Value;
    UpdateCurrentItem;
  end;
end;

{ TCustomListBox.TListBoxStrings }

function TCustomListBox.TListBoxStrings.Add(const S: string): Integer;
var
  Item: TListBoxItem;
begin
  Item := TListBoxItem.Create(FListBox);
  try
    Item.Text := S;
    Result := FListBox.Count;
    FListBox.AddObject(Item);
    Item.StyleLookup := FListBox.DefaultItemStyles.ItemStyle;
    FListBox.DispatchStringsChangeEvent(S, TCustomListBox.TStringsChangeOp.tsoAdded);
  except
    Item.Free;
    raise;
  end;
end;

procedure TCustomListBox.TListBoxStrings.Clear;
begin
  if not (csDestroying in FListBox.ComponentState) then
    FListBox.Clear;
end;

procedure TCustomListBox.TListBoxStrings.Delete(Index: Integer);
var
  Item: TListBoxItem;
begin
  Item := FListBox.ListItems[Index];
  if Assigned(Item) then
  begin
    FListBox.RemoveObject(Item);
    Item.Free;
  end;
end;

procedure TCustomListBox.TListBoxStrings.Exchange(Index1, Index2: Integer);
begin
  FListBox.Exchange(FListBox.ItemByIndex(Index1), FListBox.ItemByIndex(Index2));
end;

function TCustomListBox.TListBoxStrings.Get(Index: Integer): string;
begin
  Result := FListBox.ListItems[Index].Text;
end;

function TCustomListBox.TListBoxStrings.GetCount: Integer;
begin
  Result := FListBox.Count;
end;

function TCustomListBox.TListBoxStrings.GetObject(Index: Integer): TObject;
begin
  Result := FListBox.ListItems[Index].Data;
end;

function TCustomListBox.TListBoxStrings.IndexOf(const S: string): Integer;
var
  I: Integer;
begin
  for I := 0 to FListBox.Count - 1 do
    if SameText(FListBox.ListItems[I].Text, S) then
      Exit(I);
  Result := -1;
end;

procedure TCustomListBox.TListBoxStrings.Insert(Index: Integer; const S: string);
var
  Item: TListBoxItem;
begin
  Item := TListBoxItem.Create(FListBox);
  try
    Item.Text := S;
    FListBox.InsertObject(Index, Item);
  except
    Item.Free;
    raise;
  end;
end;

procedure TCustomListBox.TListBoxStrings.Put(Index: Integer; const S: string);
begin
  FListBox.ListItems[Index].Text := S;
end;

procedure TCustomListBox.TListBoxStrings.PutObject(Index: Integer; AObject: TObject);
begin
  FListBox.ListItems[Index].Data := AObject;
end;

procedure TCustomListBox.TListBoxStrings.SetUpdateState(Updating: Boolean);
begin
  if Updating then
    FListBox.BeginUpdate
  else
    FListBox.EndUpdate;
end;

{ TMetroListBoxItem }
procedure TMetropolisUIListBoxItem.ApplyStyle;
var
  T: TFmxObject;
begin
  inherited;
  T := FindStyleResource('text');
  if T <> nil then
  begin
    FTitle.FontColor := TText(T).Color;
    FSubTitle.FontColor := TText(T).Color;
    FDescription.FontColor := TText(T).Color;
    TText(T).Visible := False;
  end;

  FText.BringToFront;
  FTitle.StyleLookup := 'griditemtitlelabel';
  FSubTitle.StyleLookup := 'griditemsubtitlelabel';
  FDescription.StyleLookup := 'griditemtitlelabel';
  FTextPanel.StyleLookup := 'gridpanel';
end;

constructor TMetropolisUIListBoxItem.Create(AOwner: TComponent);
begin
  inherited;

  Align := TAlignLayout.alFit;

  Width := 500;
  FIconSize := 128;
  Height := FIconSize;
  ClipChildren := True;

  FImage := TImage.Create(nil);
  FImage.Stored := False;
  FImage.Locked := True;
  FImage.Bitmap.OnChange := OnBitmapChanged;

  FText := TLayout.Create(nil);
  FText.Stored := False;
  FText.Locked := True;
  FTitle := TLabel.Create(nil);
  FTitle.Stored := False;
  FTitle.Locked := True;
  FSubTitle := TLabel.Create(nil);
  FSubTitle.Stored := False;
  FSubTitle.Locked := True;
  FDescription := TLabel.Create(nil);
  FDescription.Stored := False;
  FDescription.Locked := True;
  FDescription.Trimming := TTextTrimming.ttWord;

  FImage.Position.X := 0;
  FImage.Position.Y := 0;
  FImage.HitTest := False;
  FImage.Visible := False;
  FImage.Align := TAlignLayout.alNone;

  FText.Parent := Self;
  FImage.Parent := Self;

  FText.Padding.Left := 5;
  FText.Align := TAlignLayout.alClient;

  FTextPanel := TPanel.Create(nil);
  FTextPanel.StyleLookup := 'flipviewpanel';
  FTextPanel.Align := TAlignLayout.alContents;
  FTextPanel.Parent := FText;
  FTextPanel.Visible := False;
  FTextPanel.Locked := True;
  FTextPanel.Stored := False;

  FTitle.Parent := FText;
  FTitle.Position.X := 0;
  FTitle.Position.Y := 0;
  FTitle.Height := 22;
  FTitle.AutoSize := True;
  FTitle.Align := TAlignLayout.alTop;

  FTitle.TextAlign := TTextAlign.taLeading;
  FTitle.VertTextAlign := TTextAlign.taTrailing;
  FTitle.Trimming := TTextTrimming.ttWord;
  FTitle.WordWrap := False;
  FTitle.Text := 'Item Title';
  FTitle.HitTest := False;

  FSubTitle.Parent := FText;
  FSubTitle.Position.X := 0;
  FSubTitle.Position.Y := FTitle.AbsoluteRect.Bottom + 1;
  FSubTitle.Height := 22;
  FSubTitle.TextAlign := TTextAlign.taLeading;
  FSubTitle.VertTextAlign := TTextAlign.taTrailing;
  FSubTitle.Align := TAlignLayout.alTop;
  FSubTitle.Trimming := TTextTrimming.ttWord;
  FSubTitle.AutoSize := True;
  FSubTitle.WordWrap := True;

  FSubTitle.Text := 'Item SubTitle';
  FSubTitle.HitTest := False;

  FDescription.Parent := FText;
  FDescription.Position.X := 0;
  FDescription.Position.Y := FSubTitle.AbsoluteRect.Bottom + 1;

  FDescription.TextAlign := TTextAlign.taLeading;
  FDescription.VertTextAlign := TTextAlign.taLeading;
  FDescription.Align := TAlignLayout.alClient;
  FDescription.Text := 'Long description';
  FDescription.HitTest := False;

  SetAcceptsControls(True);
  SetIconSize(FIconSize);
end;

procedure TMetropolisUIListBoxItem.DefineProperties(Filer: TFiler);
begin
  Filer.DefineProperty('IconSize', SkipIconSize, nil, False);
  Filer.DefineProperty('Align', SkipAlign, nil, False);
end;

destructor TMetropolisUIListBoxItem.Destroy;
begin
  inherited;
end;

procedure TMetropolisUIListBoxItem.DoRealign;
var
  Scale : Single;
begin
  inherited;

  if (FImage.Align <> TAlignLayout.alNone)
    or (FImage.Bitmap.Height = 0)
    or (FImage.Bitmap.Width = 0) then
    Exit;

  if Width > Height then
  begin
    Scale := Width / FImage.Bitmap.Width;
  end
  else begin
    Scale := Height / FImage.Bitmap.Height;
  end;

  FImage.SetBounds(0, 0, FImage.Bitmap.Width*Scale, FImage.Bitmap.Height*Scale);
end;

procedure TMetropolisUIListBoxItem.Resize;
begin
  if (FImage = nil) or (FText = nil) then
    Exit;

  if Width < 2*Height then
  begin
    // it's a square
    FImage.Align := TAlignLayout.alNone;
    FImage.WrapMode := TImageWrapMode.iwStretch;
    FText.Align := TAlignLayout.alBottom;
    FTextPanel.Visible := True;
    FTextPanel.Enabled := False;
    FTextPanel.Align := TAlignLayout.alContents;
    FText.Height := Height * 0.4;
    Realign;
  end
  else begin
    // it's a rectangle
    FImage.Align := TAlignLayout.alFitLeft;
    FImage.WrapMode := TImageWrapMode.iwFit;
    FText.Align := TAlignLayout.alClient;
    FTextPanel.Visible := False;
    Realign;
  end;

  inherited;
end;

function TMetropolisUIListBoxItem.GetDefaultStyleLookupName: string;
begin
  Result := 'collectionlistboxitem';
end;

function TMetropolisUIListBoxItem.GetDescription: String;
begin
  Result := FDescription.Text;
end;

function TMetropolisUIListBoxItem.GetIcon: TBitmap;
begin
  Result := FImage.Bitmap;
end;

function TMetropolisUIListBoxItem.GetSubTitle: String;
begin
  Result := FSubTitle.Text;
end;

function TMetropolisUIListBoxItem.GetTitle: String;
begin
  Result := FTitle.Text;
end;

procedure TMetropolisUIListBoxItem.OnBitmapChanged(Sender: TObject);
begin
  if FImage.Bitmap.Width > 0 then
    FImage.Visible := True
  else
    FImage.Visible := False;

  FImage.Repaint;
  FImage.UpdateEffects;
end;

procedure TMetropolisUIListBoxItem.SetIcon(const Bitmap: TBitmap);
var
  W, H : Integer;
begin
  W := Round(FImage.Width);
  H := Round(FImage.Height);
  FImage.Bitmap := Bitmap;
  FImage.Bitmap.SetSize(W, H);
  FImage.Visible := True;
  Realign;
end;

procedure TMetropolisUIListBoxItem.SetIconSize(Value: Integer);
begin
  FIconSize := Value;

  Height := Value;

  FImage.Width := FIconSize;
  FImage.Height := FIconSize;

  FText.Position.X := FIconSize + FText.Padding.Left;
  FText.Position.Y := 0;
  FText.Width := Width - FText.Position.X - FText.Padding.Left;
  FText.Height := Value;

  Realign;
end;

procedure TMetropolisUIListBoxItem.SetParent(const AParent: TFmxObject);
var
  X : Single;
begin
  inherited;
  X := FText.Position.X;
  FText.Anchors := [TAnchorKind.akLeft, TAnchorKind.akRight];
  FText.Position.X := X;
  if AParent is TControl then
    FText.Width := TControl(AParent).Width - X;
  if AParent is TListBox then
    FText.Width := TListBox(AParent).ClientWidth - X;
end;

procedure TMetropolisUIListBoxItem.SetDescription(const Description: String);
begin
  FDescription.Text := Description;
end;

procedure TMetropolisUIListBoxItem.SetSubTitle(const SubTitle: String);
begin
  FSubTitle.Text := SubTitle;
end;

procedure TMetropolisUIListBoxItem.SetTitle(const Title: String);
begin
  FTitle.Text := Title;
end;

procedure TMetropolisUIListBoxItem.SkipAlign(Reader: TReader);
begin
  Reader.SkipValue;
end;

procedure TMetropolisUIListBoxItem.SkipIconSize(Reader: TReader);
begin
  Reader.ReadInteger;
end;

{ TListBoxItemData }

procedure TListBoxItemData.AssignTo(Dest: TPersistent);
begin
  TListBoxItemData(Dest).SetBitmap(GetBitmap);
  TListBoxItemData(Dest).SetDetail(GetDetail);
  TListBoxItemData(Dest).SetAccessory(GetAccessory);
end;

constructor TListBoxItemData.Create(const HostItem: TListBoxItem);
begin
  inherited Create;
  FItem := HostItem;
  Detail := EmptyStr;
  Accessory := TAccessory.aNone;
end;

destructor TListBoxItemData.Destroy;
begin
  inherited;
end;


procedure TListBoxItemData.Disappear;
var
  B: TControl;
begin
  case FAccessory of
    TListBoxItemData.TAccessory.aNone: ;
    TListBoxItemData.TAccessory.aMore:
      begin
        B := TControl(FItem.FindStyleResource('accessorymore'));
        if Assigned(B) then
          B.Visible := False;
      end;
    TListBoxItemData.TAccessory.aDetail:
      begin
        B := TControl(FItem.FindStyleResource('accessorydetail'));
        if Assigned(B) then
          B.Visible := False;
      end;
    TListBoxItemData.TAccessory.aCheckmark:
      begin
        B := TControl(FItem.FindStyleResource('accessorycheckmark'));
        if Assigned(B) then
          B.Visible := False;
      end;
  end;
end;

function TListBoxItemData.GetBitmap: TBitmap;
begin
  Result := FItem.FBitmap;
end;

function TListBoxItemData.GetDetail: String;
begin
  Result := FItem.StylesData['detail'].AsString;
end;

function TListBoxItemData.GetText: String;
begin
  Result := FItem.Text;
end;

procedure TListBoxItemData.SetBitmap(const Bitmap: TBitmap);
begin
  FItem.FBitmap.Assign(Bitmap);
end;

procedure TListBoxItemData.SetAccessory(const Accessory: TAccessory);
begin
  Self.FAccessory := Accessory;
  case Accessory of
    TAccessory.aNone: begin
      FItem.StylesData[StyleSelectorMore] := False;
      FItem.StylesData[StyleSelectorDetail] := False;
      FItem.StylesData[StyleSelectorCheckmark] := False;
    end;
    TAccessory.aMore: begin
      FItem.StylesData[StyleSelectorMore] := True;
      FItem.StylesData[StyleSelectorDetail] := False;
      FItem.StylesData[StyleSelectorCheckmark] := False;
      end;
    TAccessory.aDetail: begin
      FItem.StylesData[StyleSelectorMore] := False;
      FItem.StylesData[StyleSelectorDetail] := True;
      FItem.StylesData[StyleSelectorCheckmark] := False;
      end;
    TAccessory.aCheckmark: begin
      FItem.StylesData[StyleSelectorMore] := False;
      FItem.StylesData[StyleSelectorDetail] := False;
      FItem.StylesData[StyleSelectorCheckmark] := True;
    end;
  end
end;

function TListBoxItemData.GetAccessory: TAccessory;
begin
  Exit(FAccessory);
end;

procedure TListBoxItemData.SetDetail(const Detail: string);
begin
  FItem.StylesData['detail'] := Detail;
end;

procedure TListBoxItemData.SetText(const Text: string);
begin
  FItem.Text := Text;
end;

{ TListBoxGroupHeader }

constructor TListBoxGroupHeader.Create(AOwner: TComponent);
begin
  inherited;
end;

function TListBoxGroupHeader.GetDefaultStyleLookupName: string;
begin
  Result := 'listboxplainheader';
end;

{ TListBoxGroupFooter }

constructor TListBoxGroupFooter.Create(AOwner: TComponent);
begin
  inherited;
end;

function TListBoxGroupFooter.GetDefaultStyleLookupName: string;
begin
  Result := 'listboxfooter';
end;

{ TCustomListBox.TGroup }

constructor TCustomListBox.TGroup.Create(const AFirst, ALength: Integer);
begin
  First := AFirst;
  Length := ALength;
end;

{ TCustomListBox.TGroups }

function TCustomListBox.TGroups.FindGroup(const Index: Integer): Integer;
var
  Blank: TGroup;
begin
  Blank := TGroup.Create(Index, 0);
  if not Self.BinarySearch(Blank, Result, TComparer<TGroup>.Construct(
    function(const G, R: TGroup):Integer
    begin
      if (G.First <= R.First) and (G.First+G.Length > R.First) then
        Result := 0
      else
        Result := G.First - R.First
    end
    )) then Result := -1;
end;

{ TDefaultListBoxItemStyles }

procedure TListBoxItemStyleDefaults.Assign(Source: TPersistent);
var
  Src: TListBoxItemStyleDefaults;
begin
  if Source is TListBoxItemStyleDefaults then
  begin
    Src := TListBoxItemStyleDefaults(Source);
    FItemStyle := Src.FItemStyle;
    FFooterStyle := Src.FFooterStyle;
    FHeaderStyle := Src.FHeaderStyle;
  end;
end;

constructor TListBoxItemStyleDefaults.Create(const ListBox: TCustomListBox);
var
  DefaultValueService: IInterface;
begin
  FListBox := ListBox;

  if (csDesigning in ListBox.ComponentState) and
    ListBox.SupportsPlatformService(IFMXDefaultPropertyValueService, DefaultValueService) then
  begin
    ItemStyle := IFMXDefaultPropertyValueService(DefaultValueService).GetDefaultPropertyValue(Self.ClassName, 'itemstyle').AsString;
    GroupHeaderStyle := IFMXDefaultPropertyValueService(DefaultValueService).GetDefaultPropertyValue(Self.ClassName, 'groupheaderstyle').AsString;
    GroupFooterStyle := IFMXDefaultPropertyValueService(DefaultValueService).GetDefaultPropertyValue(Self.ClassName, 'groupfooterstyle').AsString;
  end;
end;

function TListBoxItemStyleDefaults.GetGroupFooterStyle: string;
begin
  Result := FFooterStyle;
end;

function TListBoxItemStyleDefaults.GetGroupHeaderStyle: string;
begin
  Result := FHeaderStyle;
end;

function TListBoxItemStyleDefaults.GetItemStyle: string;
begin
  Result := FItemStyle;
end;

procedure TListBoxItemStyleDefaults.SetGroupFooterStyle(const Value: string);
begin
  FFooterStyle := Value;
end;

procedure TListBoxItemStyleDefaults.SetGroupHeaderStyle(const Value: string);
begin
  FHeaderStyle := Value;
end;

procedure TListBoxItemStyleDefaults.SetItemStyle(const Value: string);
begin
  FItemStyle := Value;
end;

{ TFmxFilteredChildrenList }

constructor TFilteredChildrenList.Create(const Children: TFmxObjectList);
begin
  inherited Create(Children);
  FBaseChildren := Children;
end;

procedure TFilteredChildrenList.ApplyFilter(const Filter: TPredicate<string>);
var
  Item: TFmxObject;
  HeaderIndex, FooterIndex, SectionSize: Integer;
begin
  if not Assigned(Filter) then
    FreeAndNil(FFilteredChildren)
  else
  begin
    if FFilteredChildren = nil then
      FFilteredChildren := TFmxObjectList.Create
    else
      FFilteredChildren.Clear;

    HeaderIndex := -1;
    FooterIndex := -1;
    SectionSize := 0;
    for Item in FBaseChildren do
    begin
      if Item is TListBoxGroupHeader then
      begin
        if SectionSize = 0 then
        begin
          if (FooterIndex <> -1)  then
            FFilteredChildren.Delete(FooterIndex);
          if (HeaderIndex <> -1) then
            FFilteredChildren.Delete(HeaderIndex);
        end;

        FFilteredChildren.Add(Item);
        HeaderIndex := FFilteredChildren.Count - 1;
        FooterIndex := -1;
        SectionSize := 0;
      end
      else if Item is TListBoxGroupFooter then
      begin
        FFilteredChildren.Add(Item);
        FooterIndex := FFilteredChildren.Count - 1;
        if FooterIndex < HeaderIndex then
        begin
          FooterIndex := HeaderIndex;
          HeaderIndex := FFilteredChildren.Count - 1;
        end;
      end
      else if Filter(TListBoxItem(Item).Text) or Filter(TListBoxItem(Item).ItemData.Detail) then
      begin
        FFilteredChildren.Add(Item);
        Inc(SectionSize);
      end;
    end;

    if (SectionSize = 0) then
    begin
      if FooterIndex <> -1 then
        FFilteredChildren.Delete(FooterIndex);
      if HeaderIndex <> -1 then
        FFilteredChildren.Delete(HeaderIndex);
    end;
  end;
end;

destructor TFilteredChildrenList.Destroy;
begin
  FreeAndNil(FFilteredChildren);
  inherited;
end;

function TFilteredChildrenList.DoGetEnumerator: TEnumerator<TFmxObject>;
begin
  if FFilteredChildren = nil then
    Result := inherited DoGetEnumerator
  else
    Result := FFilteredChildren.GetEnumerator;
end;

function TFilteredChildrenList.GetChildCount: Integer;
begin
  if FFilteredChildren = nil then
    Result := inherited GetChildCount
  else
    Result := FFilteredChildren.Count;
end;

function TFilteredChildrenList.IndexOf(const Obj: TFmxObject): Integer;
begin
  if FFilteredChildren = nil then
    Result := inherited IndexOf(Obj)
  else
    Result := FFilteredChildren.IndexOf(Obj);
end;

function TFilteredChildrenList.GetChild(AIndex: Integer): TFmxObject;
begin
  if FFilteredChildren = nil then
    Result := inherited GetChild(AIndex)
  else
    Result := FFilteredChildren[AIndex];
end;


initialization
  RegisterFmxClasses([TCustomListBox, TCustomComboBox, TListBoxItem, TListBox,
    TComboBox, TMetropolisUIListBoxItem, TListBoxHeader, TListBoxGroupHeader, TListBoxGroupFooter]);
end.

