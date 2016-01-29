{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit FMX.ListView;

interface

uses
  System.Types, System.UITypes, System.Math, System.Classes, System.Generics.Collections, System.UIConsts, FMX.Types,
  FMX.Controls, FMX.InertialMovement, FMX.TextLayout, FMX.ListView.Types, FMX.Styles, FMX.Objects, FMX.StdCtrls,
  System.Rtti, System.SysUtils;

{$SCOPEDENUMS ON}

type

                                                                       

  TListViewItems = class;
  TListViewItem = class;
  TItemAppearanceObjects = class;
  {$HPPEMIT OPENNAMESPACE} // RS-37665
  {$HPPEMIT 'class DELPHICLASS TItemAppearanceObjects;'}
  {$HPPEMIT CLOSENAMESPACE}  
  TItemAppearanceProperties = class;

  TCustomListView = class(TStyledControl, ISearchResponder, IListItemStyleResources)
  public
    type
      TEditModeOption = (DisallowSelection, HideSelection, RadioButtonMode, UncheckMode, ModalMode, ClearWhenStart);
      TEditModeOptions = set of TEditModeOption;
  private type

    TItemHeightSums = TList<Integer>;

  protected type
    TEditModeState = class
    private
      [weak] FOwner: TCustomListView;
      FClearing: Integer;
      FOptions: TEditModeOptions;
      function GetClearing: Boolean;
      function GetModalMode: Boolean;
      function GetDisallowSelection: Boolean;
      function GetClearWhenStart: Boolean;
      function GetRadioButtonMode: Boolean;
      function GetHideSelection: Boolean;
      function GetUncheckMode: Boolean;
      function GetFirstChecked: Integer;
      function GetCanCancelMode: Boolean;
      function GetCheckedValue: Boolean;
    public
      constructor Create(const AOwner: TCustomListView);
      procedure BeginClearing;
      procedure EndClearing;
      procedure CancelMode;
      property Clearing: Boolean read GetClearing;
      property CheckedValue: Boolean read GetCheckedValue;
      property CanCancelMode: Boolean read GetCanCancelMode;
      property FirstChecked: Integer read GetFirstChecked;
      property RadioButtonMode: Boolean read GetRadioButtonMode;
      property DisallowSelection: Boolean read GetDisallowSelection;
      property UncheckMode: Boolean read GetUncheckMode;
      property HideSelection: Boolean read GetHideSelection;
      property ModalMode: Boolean read GetModalMode;
      property ClearWhenStart: Boolean read GetClearWhenStart;
    end;

  public type
    TListItemPurposes = set of TListItemPurpose;
    TItemAppearanceObjectsClass = class of TItemAppearanceObjects;
    THandleChangeEvent = procedure(const Sender: TObject; var AHandled: Boolean) of object;
    TItemEvent = procedure(const Sender: TObject; const AItem: TListViewItem) of object;
    TUpdateObjectsEvent = TItemEvent;
    TUpdatingObjectsEvent = procedure(const Sender: TObject; const AItem: TListViewItem; var AHandled: Boolean) of object;
    TItemControlEvent = procedure(const Sender: TObject; const AItem: TListViewItem; const AObject: TListItemSimpleControl) of object;
    TAppearanceNamePair = TPair<string (*Identifier*), string (*displayname*)>;
    TAppearanceType = (Item, ItemEdit, Header, Footer);
    TRegisterAppearanceOption = (Footer, Header, Item, ItemEdit, DefaultFooter, DefaultHeader, DefaultItem, DefaultItemEdit);
    TRegisterAppearanceOptions = set of TRegisterAppearanceOption;
    TRegisteredAppearance = record
      Name: string;
      Value: TItemAppearanceObjectsClass;
      UnitName: string;
      Options: TRegisterAppearanceOptions;
    end;

    TAppearanceNames = class
    public const
      Empty = '';
      Null = 'Null';
      Custom = 'Custom';
      ListHeader = 'ListHeader';
      // ListItem group
      ListItem = 'ListItem';
      ListItemDelete = 'ListItemDelete';
      ListItemShowCheck = 'ListItemShowCheck';
      // ListItemRightDetail group
      ListItemRightDetail = 'ListItemRightDetail';
      ListItemRightDetailDelete = 'ListItemRightDetailDelete';
      ListItemRightDetailShowCheck = 'ListItemRightDetailShowCheck';
      // ImageListItem group
      ImageListItem = 'ImageListItem';
      ImageListItemDelete = 'ImageListItemDelete';
      ImageListItemShowCheck = 'ImageListItemShowCheck';
      // ListItemRightButton group
      ImageListItemRightButton = 'ImageListItemRightButton';
      ImageListItemRightButtonDelete = 'ImageListItemRightButtonDelete';
      ImageListItemRightButtonShowCheck = 'ImageListItemRightButtonShowCheck';
    end;

    TPublishedAppearance = class(TPersistent)
    private
      [weak] FOwner: TCustomListView;
      function GetFooterAppearance: string;
      function GetFooterHeight: Integer;
      function GetHeaderAppearance: string;
      function GetHeaderHeight: Integer;
      function GetItemAppearance: string;
      function GetItemEditAppearance: string;
      function GetItemHeight: Integer;
      function GetItemEditHeight: Integer;
      procedure SetFooterAppearance(const Value: string);
      procedure SetFooterHeight(const Value: Integer);
      procedure SetHeaderAppearance(const Value: string);
      procedure SetHeaderHeight(const Value: Integer);
      procedure SetItemAppearance(const Value: string);
      procedure SetItemEditAppearance(const Value: string);
      procedure SetItemHeight(const Value: Integer);
      procedure SetItemEditHeight(const Value: Integer);
      function IsFooterHeightStored: Boolean;
      function IsHeaderHeightStored: Boolean;
      function IsItemEditHeightStored: Boolean;
      function IsItemHeightStored: Boolean;
    public
      property Owner: TCustomListView read FOwner;
    published
      constructor Create(const AOwner: TCustomListView);
      property ItemHeight: Integer read GetItemHeight write SetItemHeight stored IsItemHeightStored nodefault;
      property ItemEditHeight: Integer read GetItemEditHeight write SetItemEditHeight stored IsItemEditHeightStored nodefault;
      property HeaderHeight: Integer read GetHeaderHeight write SetHeaderHeight stored IsHeaderHeightStored nodefault;
      property FooterHeight: Integer read GetFooterHeight write SetFooterHeight stored IsFooterHeightStored nodefault;
      property ItemAppearance: string read GetItemAppearance write SetItemAppearance stored False;
      property ItemEditAppearance: string read GetItemEditAppearance write SetItemEditAppearance stored False;
      property HeaderAppearance: string read GetHeaderAppearance write SetHeaderAppearance stored False;
      property FooterAppearance: string read GetFooterAppearance write SetFooterAppearance stored False;
    end;

    TPublishedObjects = class(TPersistent)
    private
      [weak] FOwner: TCustomListView;
      function GetFooterObjects: TItemAppearanceObjects;
      function GetHeaderObjects: TItemAppearanceObjects;
      function GetItemEditObjects: TItemAppearanceObjects;
      function GetItemObjects: TItemAppearanceObjects;
      procedure SetFooterObjects(const Value: TItemAppearanceObjects);
      procedure SetHeaderObjects(const Value: TItemAppearanceObjects);
      procedure SetItemEditObjects(const Value: TItemAppearanceObjects);
      procedure SetItemObjects(const Value: TItemAppearanceObjects);
    public
      property Owner: TCustomListView read FOwner;
    published
      constructor Create(const AOwner: TCustomListView);
      property ItemObjects: TItemAppearanceObjects read GetItemObjects write SetItemObjects;
      property ItemEditObjects: TItemAppearanceObjects read GetItemEditObjects write SetItemEditObjects;
      property HeaderObjects: TItemAppearanceObjects read GetHeaderObjects write SetHeaderObjects;
      property FooterObjects: TItemAppearanceObjects read GetFooterObjects write SetFooterObjects;
    end;

    public  const
      cDefaultEditModeOptions = [TEditModeOption.ClearWhenStart, TEditModeOption.DisallowSelection, TEditModeOption.HideSelection];
      cRegisterDefault = [TRegisterAppearanceOption.DefaultFooter, TRegisterAppearanceOption.DefaultHeader,  TRegisterAppearanceOption.DefaultItem, TRegisterAppearanceOption.DefaultItemEdit];
      cRegisterAll = [
        TRegisterAppearanceOption.Footer, TRegisterAppearanceOption.Header,  TRegisterAppearanceOption.Item, TRegisterAppearanceOption.ItemEdit,
        TRegisterAppearanceOption.DefaultFooter, TRegisterAppearanceOption.DefaultHeader,  TRegisterAppearanceOption.DefaultItem, TRegisterAppearanceOption.DefaultItemEdit];
    class procedure RegisterAppearances(AFactories: TArray<TItemAppearanceObjectsClass>; ADisplayNames: TArray<string>; AOptions: TRegisterAppearanceOptions = [TRegisterAppearanceOption.Item]; const AUnitName: string = ''); overload;
    class procedure RegisterAppearance(const AFactory: TItemAppearanceObjectsClass; const ADisplayName: string; AOptions: TRegisterAppearanceOptions = [TRegisterAppearanceOption.Item]; const AUnitName: string = ''); overload;
    class procedure UnregisterAppearance(const AFactory: TItemAppearanceObjectsClass); overload;
    class procedure UnregisterAppearances(AFactories: TArray<TItemAppearanceObjectsClass>); overload;
    class function GetRegisteredAppearances(AFilter: TRegisterAppearanceOptions = []): TArray<TRegisteredAppearance>;
  private
    FPainting: Boolean;
    FResettingObjects: Boolean;
    FAppearanceProperties: TPublishedAppearance;
    FItemAppearanceObjects: TPublishedObjects;
    FItemAppearanceProperties: TItemAppearanceProperties;
    FItemEditAppearanceProperties: TItemAppearanceProperties;
    FHeaderAppearanceProperties: TItemAppearanceProperties;
    FFooterAppearanceProperties: TItemAppearanceProperties;
    FListViewItems: TListViewItems;

    FEditModeOptions: TEditModeOptions;
    FEditModeState: TEditModeState;

    //FItemHeight: Integer;
    FItemIndex: Integer;
    FAniCalc: TAniCalculations;
    FScrollViewPos: Single;
    FBrush: TBrush;
    FStroke: TStrokeBrush;

    MouseClickPrev: TPointF;
    MouseClickDelta: TPointF;
    MouseClicked: Boolean;
    MouseClickIndex: Integer;
    MouseEventIndex: Integer;
    MouseSetItemIndex: Integer;
    FItemSpaces: TBounds;

    HeightSums: TItemHeightSums;
    HeightSumsDirty: Boolean;

    MaxKnownHeight: Integer;

    FSideSpace: Integer;
    FScrollScale: Single;

    BackgroundStyleColor: TAlphaColor;
    SelectionStyleColor: TAlphaColor;
    ItemStyleFillColor: TAlphaColor;
    ItemStyleFillAltColor: TAlphaColor;
    ItemStyleFrameColor: TAlphaColor;

    [weak]SelectionStyleImage: TSubImage;
    [weak]HeaderStyleImage: TSubImage;

    FScrollBar: TScrollBar;
    FTransparent: Boolean;
    FAllowSelection: Boolean;
    FAlternatingColors: Boolean;
    ScrollingActive: Boolean;
    ScrollingMouseTouch: Boolean;
    NeedShowScrollBar: Boolean;

    ItemSelectTimer: TTimer;
    ItemSelectTimerIndex: Integer;
    ItemSelectTimerWorked: Boolean;
    FShowSelection: Boolean;
    FOnChange: TNotifyEvent;
    FAutoTapScroll: Boolean;
    FAutoTapTreshold: Integer;
    FAutoTapDistance: Integer;

    FOnItemClick: TItemEvent;
    FOnItemChange: TItemEvent;
    FOnEditModeChanging: THandleChangeEvent;
    FOnEditModeChange: TNotifyEvent;
    FOnButtonClick: TItemControlEvent;
    FOnButtonChange: TItemControlEvent;
    FOnUpdateObjects: TUpdateObjectsEvent;
    FOnUpdatingObjects: TUpdatingObjectsEvent;
    FEditMode: Boolean;
    FUpdatingAppearance: Integer;
    FChangedAppearanceObjects: TListItemPurposes;
    FChangedAppearanceHeights: TListItemPurposes;
    FStyleResources: TListItemStyleResources;
    FUpdateStyleResources: Boolean;
    FDisableMouseWheel: Boolean;

    procedure ObjectsNotify(Sender: TObject; const Item: TListViewItem; Action: TCollectionNotification);
    procedure ScrollBarChange(Sender: TObject);
    procedure ItemSpacesChange(Sender: TObject);
    procedure AniCalcChange(Sender: TObject);
    procedure AniCalcStart(Sender: TObject);
    procedure AniCalcStop(Sender: TObject);
    procedure SelectItemNotify(Sender: TObject);

    procedure SetItemHeight(const Value: Integer);
    procedure SetItemEditHeight(const Value: Integer);
    procedure SetHeaderHeight(const Value: Integer);
    procedure SetFooterHeight(const Value: Integer);
    procedure SetItemIndex(const Value: Integer);
    function GetMaxScrollViewPos: Integer;
    procedure UpdateScrollViewPos(const Value: Single);
    procedure SetScrollViewPos(const Value: Single);
    procedure UpdateScrollingLimits;
    procedure UpdateScrollBar;
    function GetNumberOfPassesForObjects(const StartItem, EndItem: Integer): Integer;
    function GetNumberOfSubPassesForObjects(const StartItem, EndItem: Integer): Integer;

    function GetItemHeight(Index: Integer): Integer; overload; inline;
    function GetItemHeight: Integer; overload;
    function GetItemEditHeight: Integer; overload;
    function GetHeaderHeight: Integer; overload;
    function GetFooterHeight: Integer; overload;
    function GetItemRelRect(const Index: Integer; const LocRect: TRectF; const SideSpace: Integer = 0): TRectF; inline;
    function GetItemGroupSeparators(const Index: Integer): Integer; inline;

    procedure DrawItemsFill(const StartItem, EndItem: Integer; const LocRect: TRectF; HeaderIndex: Integer = -1);
    procedure DrawSelectedFill(const LocRect: TRectF);

    function GetHeaderRelRect(const StartItem, HeaderIndex: Integer; const LocRect: TRectF;
      const SideSpace: Integer = 0): TRectF;
    procedure DrawHeaderItem(const LocRect: TRectF; StartItem, HeaderIndex: Integer);

    procedure DrawListItems;
    function GetItem(Index: Integer): TListViewItem;

    procedure UpdateItemLookups();
    function FindItemAbsoluteAt(ViewAt: Integer): Integer;
    procedure SetSideSpace(const Value: Integer);
    procedure SetTransparent(const Value: Boolean);
    procedure SetAlternatingColors(const Value: Boolean);
    procedure SetShowSelection(const Value: Boolean);

    procedure ObserversBeforeSelection(out LAllowSelection: Boolean);
    function GetFooterAppearanceName: string;
    function GetFooterAppearanceClassName: string;
    function GetHeaderAppearanceName: string;
    function GetHeaderAppearanceClassName: string;
    function GetItemAppearanceName: string;
    function GetItemEditAppearanceName: string;
    function GetItemObjectsClassName: string;
    function GetItemEditObjectsClassName: string;
    procedure SetFooterAppearanceClassName(const Value: string);
    procedure SetHeaderAppearanceClassName(const Value: string);
    procedure SetItemObjectsClassName(const Value: string);
    procedure SetItemEditObjectsClassName(const Value: string);
    procedure SetFooterAppearanceName(const Value: string);
    procedure SetHeaderAppearanceName(const Value: string);
    procedure SetItemAppearanceName(const Value: string);
    procedure SetItemEditAppearanceName(const Value: string);
    procedure DoUpdateObjects(const AListViewItem: TListViewItem);
    procedure DoUpdatingObjects(const AListViewItem: TListViewItem;
      var AHandled: Boolean);
    procedure SetEditMode(const Value: Boolean);
    procedure SetAppearanceProperties(
      const Value: TPublishedAppearance);
    procedure SetItemAppearanceObjects(
      const Value: TPublishedObjects);
    function GetInternalAllowSelection: Boolean;
    function GetInternalShowSelection: Boolean;
    procedure AppearanceResetObjects(
      APurposes: TCustomListView.TListItemPurposes);
    procedure AppearanceResetHeights(
      APurposes: TCustomListView.TListItemPurposes);
    function GetSelected: TListViewItem;
    procedure SetSelected(const Value: TListViewItem);
    property InternalAllowSelection: Boolean read GetInternalAllowSelection;
    property InternalShowSelection: Boolean read GetInternalShowSelection;
    { ISearchResponder }
    procedure SetFilterPredicate(const Predicate: TPredicate<string>);
  protected
    { IListItemStyleResources }
    function GetStyleResources: TListItemStyleResources;

    function GetAppearanceProperties: TArray<TItemAppearanceProperties>;
    procedure RefreshAppearances(const APurposes: TListItemPurposes = []);
    procedure UpdateAppearanceStyleResources;
    procedure ResizeAppearances;

    function GetItemCount: Integer;
    procedure ResetObjects(const AItem: TListViewItem);
    procedure ItemAppearanceChange(const Sender: TItemAppearanceProperties);
    procedure ItemAppearanceChangeObjects(const Sender: TItemAppearanceProperties);
    procedure ItemAppearanceChangeHeight(const Sender: TItemAppearanceProperties);
    procedure SetItemSpaces(const Value: TBounds);

    property EditModeState: TEditModeState read FEditModeState;


  protected
    procedure Paint; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Single); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single); override;
    procedure MouseWheel(Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean); override;

    procedure KeyDown(var Key: Word; var KeyChar: System.WideChar;
      Shift: TShiftState); override;

    function ObjectAtPoint(P: TPointF): IControl; override;
    procedure DoMouseLeave; override;
    procedure Resize; override;

    function GetDefaultStyleLookupName: string; override;
    procedure ApplyStyle; override;
    procedure FreeStyle; override;

    procedure InvalidateHeights;
    procedure Invalidate;

    function CanObserve(const ID: Integer): Boolean; override;
    procedure DoExit; override;
    procedure DoChange; virtual;
    procedure DoItemClick(const AItem: TListViewItem); virtual;
    procedure DoButtonClick(const AObject: TListItemSimpleControl); virtual;
    procedure DoButtonChange(const AObject: TListItemGlyphButton); virtual;
    procedure DoEditModeChange; virtual;
    procedure DoEditModeChanging(var AHandled: Boolean); virtual;
    
    procedure BeginAppearanceUpdate;
    procedure EndAppearanceUpdate(AForceInvalidate: TListItemPurposes = []);
    procedure InitializeItemAppearance(const AAppearance: TItemAppearanceProperties); virtual;
  protected
    // Appearance related properties

    // Must be loaded prior to other Item, header and footer properties
    property ItemEditAppearanceClassName: string read GetItemEditObjectsClassName write SetItemEditObjectsClassName;
    property ItemAppearanceClassName: string read GetItemObjectsClassName write SetItemObjectsClassName;
    property HeaderAppearanceClassName: string read GetHeaderAppearanceClassName write SetHeaderAppearanceClassName;
    property FooterAppearanceClassName: string read GetFooterAppearanceClassName write SetFooterAppearanceClassName;

    // Default item height (can be overriden for each item).
    property ItemHeight: Integer read GetItemHeight write SetItemHeight;
    property ItemEditHeight: Integer read GetItemEditHeight write SetItemEditHeight;
    property HeaderHeight: Integer read GetHeaderHeight write SetHeaderHeight;
    property FooterHeight: Integer read GetFooterHeight write SetFooterHeight;

    property ItemAppearanceName: string read GetItemAppearanceName write SetItemAppearanceName stored False;
    property ItemEditAppearanceName: string read GetItemEditAppearanceName write SetItemEditAppearanceName stored False;
    property HeaderAppearanceName: string read GetHeaderAppearanceName write SetHeaderAppearanceName stored False;
    property FooterAppearanceName: string read GetFooterAppearanceName write SetFooterAppearanceName stored False;

    property ItemAppearance: TPublishedAppearance read FAppearanceProperties write SetAppearanceProperties;
    property ItemAppearanceObjects: TPublishedObjects read FItemAppearanceObjects write SetItemAppearanceObjects;

    property OnUpdatingObjects: TUpdatingObjectsEvent read FOnUpdatingObjects write FOnUpdatingObjects;
    property OnUpdateObjects: TUpdateObjectsEvent read FOnUpdateObjects write FOnUpdateObjects;
    property OnEditModeChange: TNotifyEvent read FOnEditModeChange write FOnEditModeChange;
    property OnEditModeChanging: THandleChangeEvent read FOnEditModeChanging write FOnEditModeChanging;
    property OnButtonChange: TItemControlEvent read FOnButtonChange write FOnButtonChange;
    property OnButtonClick: TItemControlEvent read FOnButtonClick write FOnButtonClick;

    property EditModeOptions: TEditModeOptions read FEditModeOptions write FEditModeOptions;
    property EditMode: Boolean read FEditMode write SetEditMode;  // Last
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy(); override;


    { check for support interface }
    function IsIControl: Boolean; override;
    function AsIControl: IControl; override;

    // Creates a new list item.
    //function NewItem(): TListBoxItem;
    // Removes all existing list items.
    procedure ClearItems();

    // Scrolls the view (instantly) to the desired item placing it within the view.
    procedure ScrollTo(const AItemIndex: Integer);

    property ItemIndex: Integer read FItemIndex write SetItemIndex default -1;
    property Selected: TListViewItem read GetSelected write SetSelected;
    property ScrollViewPos: Single read FScrollViewPos write SetScrollViewPos;
    function GetItemRect(const AItemIndex: Integer): TRectF;

    // Access to each individual item. Use "NewItem" to create new items.
    //property Items[Index: Integer]: TListBoxItem read GetItem;
    property Items: TListViewItems read FListViewItems;

   // Space in logical units around the content of each list item.
    property ItemSpaces: TBounds read FItemSpaces write SetItemSpaces;

    // Space in logical units on all sides around the list box encompassing the items.
    property SideSpace: Integer read FSideSpace write SetSideSpace default 0;

    // If the control is transparent, it will not draw its background.
    property Transparent: Boolean read FTransparent write SetTransparent;

    { Determines whether the items are used selectable or not. If items are not selectable, user will still be
      able to click on embedded controls. }
    property AllowSelection: Boolean read FAllowSelection write FAllowSelection default True;

    // Enabling this will switch fill colors for odd and even elements.
    property AlternatingColors: Boolean read FAlternatingColors write SetAlternatingColors default False;

    // Determines whether the selection is visible when selecting items. It may be disabled when using list of checkboxes.
    property ShowSelection: Boolean read FShowSelection write SetShowSelection default True;

    property AutoTapScroll: Boolean read FAutoTapScroll write FAutoTapScroll default False;
    property AutoTapTreshold: Integer read FAutoTapTreshold write FAutoTapTreshold default 8;

    property DisableMouseWheel: Boolean read FDisableMouseWheel write FDisableMouseWheel default False;

    property ItemCount: Integer read GetItemCount;


    property OnItemClick: TItemEvent read FOnItemClick write FOnItemClick;
    property OnItemChange: TItemEvent read FOnItemChange write FOnItemChange;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;

  end;


  TListView = class(TCustomListView)
  protected
    procedure InitializeItemAppearance(const AAppearance: TItemAppearanceProperties); override;
  public
    // Hoist protected appearance properties
    property ItemAppearanceName;
    property ItemEditAppearanceName;
    property HeaderAppearanceName;
    property FooterAppearanceName;
  published
    // Hoist protected appearance properties
    property ItemAppearanceClassName;
    property ItemEditAppearanceClassName;
    property HeaderAppearanceClassName;
    property FooterAppearanceClassName;

    property OnUpdatingObjects;
    property OnUpdateObjects;
    property OnEditModeChange;
    property OnEditModeChanging;

    property EditModeOptions;
    property EditMode;

    property Transparent default false;
    property AllowSelection;
    property AlternatingColors;

    property ItemIndex;
    property ScrollViewPos;

    property ItemSpaces;

    property SideSpace;

    property Align;
    property Anchors;
    property CanFocus default True;
    property CanParentFocus;
    property ClipChildren default False;
    property ClipParent default False;
    property Cursor default crDefault;
    property DesignVisible default True;
    property DisableFocusEffect default True;
    property DragMode default TDragMode.dmManual;
    property EnableDragHighlight default True;
    property Enabled default True;
    property Locked default False;
    property Height;
    property HitTest default True;
    property Margins;
    property Opacity;
    property Padding;
    property PopupMenu;
    property Position;
    property RotationAngle;
    property RotationCenter;
    property Scale;
    property TabOrder;
    property Visible default True;
    property Width;

    {events}
    property OnApplyStyleLookup;
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

    property ItemAppearance;
    property ItemAppearanceObjects;


    property HelpContext;
    property HelpKeyword;
    property HelpType;

    property StyleLookup;
    property TouchTargetExpansion;
    property OnClick;
    property OnDblClick;

    { ListView selection events }
    property OnChange;
    property OnItemClick;
    property OnButtonClick;
    property OnButtonChange;

    property AutoTapScroll;
    property AutoTapTreshold;
    property ShowSelection;
    property DisableMouseWheel;

  end;

  TListViewItems = class(TPersistent)
  public type
    TOrder = (FirstToLast, LastToFirst);
    TItemsList = TList<TListViewItem>;
  strict private
    [weak] FOwner: TCustomListView;
    FNewItems: TItemsList;
    FActiveItems: TItemsList;
    FUnfilteredItems: TItemsList;
    FFilteredItems: TItemsList;
  private
    FFilterPredicate: TPredicate<string>;
    FOnNotify: TCollectionNotifyEvent<TListViewItem>;
    procedure SetFilterPredicate(const Value: TPredicate<string>);
    procedure ApplyFilter;
    procedure ObjectsNotify(Sender: TObject; const Item: TListViewItem;
      Action: TCollectionNotification);
    procedure ResetIndexes;
    function GetCount: Integer;
    function GetItem(Index: Integer): TListViewItem;
    procedure ResetObjects(APurposes: TCustomListView.TListItemPurposes);
    procedure CreateNewObjects;
    function GetFiltered: Boolean;
    procedure Changed;
    property OnNotify: TCollectionNotifyEvent<TListViewItem> read FOnNotify write FOnNotify;
  protected
    function IndexOf(const AItem: TListViewItem): Integer;
  public
    constructor Create(const AOwner: TCustomListView);
    destructor Destroy; override;
    function Add: TListViewItem;
    function AddItem(Index: Integer = -1): TListViewItem;
    procedure BeginUpdate;
    procedure Clear;
    procedure Delete(Index: Integer);
    procedure EndUpdate;
    function GetEnumerator: TEnumerator<TListViewItem>;
    function Insert(Index: Integer): TListViewItem;
    // functions to get state of checks
    function AnyChecked(AChecked: Boolean = True): Boolean;
    function CheckedCount(AChecked: Boolean = True): Integer;
    function FirstChecked(AChecked: Boolean = True): Integer;
    // Check or uncheck all
    procedure CheckAll(AChecked: Boolean = True); overload;
    procedure CheckAll(ACallback: TFunc<Integer, Boolean>; AChecked: Boolean = True); overload;
    // Default order is LastToFirst.  Good for deleting items from last to first
    function CheckedIndexes(AOrder: TOrder; AChecked: Boolean = True): TArray<Integer>; overload;
    function CheckedIndexes(AChecked: Boolean = True): TArray<Integer>; overload;
    property Count: Integer read GetCount;
    property Item[Index: Integer]: TListViewItem read GetItem; default;
    property Owner: TCustomListView read FOwner;
    // Filtered is True if some items are not displayed
    property Filtered: Boolean read GetFiltered;
    property Filter: TPredicate<string> read FFilterPredicate write SetFilterPredicate;
  end;


  TListViewItem = class(TListItem)
  private type
    TFlag = (HasObjects, HasButtonText, HasCheck);
    TFlags = set of TFlag;
  public type
    TObjectNames = class
    public const
      Text = 'T';
      Detail = 'D';
      Accessory = 'A';
      TextButton = 'B';
      GlyphButton = 'G';
      Image = 'I';
    end;
    TMemberNames = class
    public const
      Text = 'Text';
      Detail = 'Detail';
      ButtonText = 'ButtonText';
      Bitmap = 'Bitmap';
    end;

    TListViewItemObjects = class(TListItemObjects)
    private
      FAppearance: TItemAppearanceObjects;
      function GetDetailObject: TListItemText;
      function GetGlyphButton: TListItemGlyphButton;
      function GetImageObject: TListItemImage;
      function GetTextButton: TListItemTextButton;
      function GetTextObject: TListItemText;
      function GetAccessoryObject: TListItemAccessory;
      function FindObjectT<T: TListItemObject>(const AName: string): T;
    public
      procedure Clear; override;
      property TextObject: TListItemText read GetTextObject;
      property DetailObject: TListItemText read GetDetailObject;
      property ImageObject: TListItemImage read GetImageObject;
      property TextButton: TListItemTextButton read GetTextButton;
      property GlyphButton: TListItemGlyphButton read GetGlyphButton;
      property AccessoryObject: TListItemAccessory read GetAccessoryObject;
    end;

  private
    FData: TDictionary<string, TValue>;
    FDataBitmaps: TDictionary<string, TBitmap>;
    FIndex: Integer;
    FFlags: TFlags;
    FText: string;
    FDetail: string;
    FButtonText: string;
    FAccessory: TAccessoryType;
    FBitmap: TBitmap;
    FChecked: Boolean;
    [weak] FBitmapRef: TBitmap;
    FTag: NativeInt;
    procedure SetText(const Value: string);
    function GetBitmap: TBitmap;
    procedure SetAccessory(const Value: TAccessoryType);
    procedure SetDetail(const Value: string);
    procedure SetButtonText(const Value: string);
    procedure SetBitmap(const Value: TBitmap);
    procedure OnBitmapChanged(Sender: TObject);
    function GetIndex: Integer;
    procedure SetBitmapRef(const Value: TBitmap);
    procedure CheckBitmap;
    function GetParent: TCustomListView;
    function GetChecked: Boolean;
    procedure SetChecked(const Value: Boolean);
    function GetHasObjects: Boolean;
    function GetObjects: TListViewItem.TListViewItemObjects; inline;
    function GetData(const AIndex: string): TValue;
    procedure SetData(const AIndex: string; const AValue: TValue);
  protected
    function GetHasButtonText: Boolean;
    function GetHasCheck: Boolean;
    function GetHasData(const AIndex: string): Boolean;
    function ListItemObjectsClass: TListItem.TListItemObjectsType; override;
    procedure SetPurpose(const AValue: TListItemPurpose); override;
    procedure InvalidateHeights; override;
    procedure Repaint; override;
  public
    procedure CreateObjects; override;
    constructor Create;
    destructor Destroy; override;

    property Parent: TCustomListView read GetParent;
    property Index: Integer read GetIndex;

    property Text: string read FText write SetText;
    property Detail: string read FDetail write SetDetail;
    property Accessory: TAccessoryType read FAccessory write SetAccessory;
    property Bitmap: TBitmap read GetBitmap write SetBitmap;
    property BitmapRef: TBitmap read FBitmapRef write SetBitmapRef;
    property ButtonText: string read FButtonText write SetButtonText;
    property Checked: Boolean read GetChecked write SetChecked;
    property Objects: TListViewItem.TListViewItemObjects read GetObjects;

    property HasObjects: Boolean read GetHasObjects;
    procedure SetHasObjects;
    property Tag: NativeInt read FTag write FTag;
    // Polymorphic method to set data, such as text or bitmap
    property Data[const AIndex: string]: TValue read GetData write SetData;
    property HasData[const AIndex: string]: Boolean read GetHasData;
  end;

  TObjectAppearance = class abstract (TPersistent)
  public type
    TDataMember = TPair<string, string>; // display name, data member
    TDataMembers = TArray<TDataMember>;
  private
    [weak] FOwner: TItemAppearanceObjects;
    FName: string;
    FDefaultValues: TObjectAppearance;
    FVisible: Boolean;
    FOnChange: TNotifyEvent;
    FOnHeightChange: TNotifyEvent;
    FInitializing: Boolean;
    FDataMembers: TDataMembers;
    procedure SetDefaultValues(const Value: TObjectAppearance);
    function IgnoreChanges: Boolean;
    procedure SetVisible(const Value: Boolean);
  private
    FIsDefaultValues: Boolean;
  protected
    procedure DoChange;
    procedure DoHeightChange;
    function IsActive: Boolean; virtual;
    function GetHeight: Integer; virtual;
    function CreateDefaultValues: TObjectAppearance; virtual;
  public
    constructor Create; overload; virtual;
    constructor Create(AIsDefaultValues: Boolean); overload;
    destructor Destroy; override;
    procedure RestoreDefaults; virtual;
    procedure AfterConstruction; override;
    procedure BeginUpdate;
    procedure EndUpdate;
    procedure CreateObject(const AListViewItem: TListViewItem); virtual;
    procedure ResetObject(const AListViewItem: TListViewItem); virtual;
    property DefaultValues: TObjectAppearance read FDefaultValues write SetDefaultValues;
    property Owner: TItemAppearanceObjects read FOwner write FOwner;
    property Name: string read FName write FName;
    property DataMembers: TDataMembers read FDataMembers write FDataMembers;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnHeightChange: TNotifyEvent read FOnHeightChange write FOnHeightChange;
    property Height: Integer read GetHeight;
    // Determines whether the current item is visible or not.
    property Visible: Boolean read FVisible write SetVisible;
  end;

  TListItemObjectClass = class of TListItemObject;

  TCommonObjectAppearance = class(TObjectAppearance)
  strict private
    FWidth: Single;
    FHeight: Single;
    FAlign: TListItemAlign;
    FVertAlign: TListItemAlign;
    FPlaceOffset: TPosition;
    FInternalPlaceOffset: TPosition;
    FInternalWidth: Single;
    FInternalHeight: Single;
    FOpacity: Single;
    procedure SetAlign(const Value: TListItemAlign);
    procedure SetPlaceOffset(const Value: TPosition);
    procedure SetVertAlign(const Value: TListItemAlign);
    procedure SetHeight(const Value: Single);
    procedure SetWidth(const Value: Single);
    procedure OnPlaceOffsetChange(Sender: TObject);
    procedure SetInternalPlaceOffset(const Value: TPosition);
    procedure SetOpacity(const Value: Single);
    procedure SetInternalWidth(const Value: Single);
    procedure SetInternalHeight(const Value: Single);
  private
    function GetActualHeight: Single;
    function GetActualPlaceOffset: TPointF;
    function GetActualWidth: Single;
    function GetWidthWhenVisible: Single;
    function GetHeightWhenVisible: Single;
  protected
    procedure AssignTo(ADest: TPersistent); override;
    procedure InitDefaultValues(const ADefaults: TCommonObjectAppearance); virtual;
    procedure ResetObjectT<T: TListItemObject>(const AListViewItem: TListViewItem);

    function IsAlignStored: Boolean;
    function IsVertAlignStored: Boolean;
    function IsVisibleStored: Boolean;
    function IsPlaceOffsetStored: Boolean;
    function IsWidthStored: Boolean;
    function IsHeightStored: Boolean;
    function IsOpacityStored: Boolean;
  public
    constructor Create; override;
    destructor Destroy; override;
    property ActualHeight: Single read GetActualHeight;
    property ActualWidth: Single read GetActualWidth;
    property WidthWhenVisible: Single read GetWidthWhenVisible;
    property HeightWhenVisible: Single read GetHeightWhenVisible;
    property ActualPlaceOffset: TPointF read GetActualPlaceOffset;
    property InternalWidth: Single read FInternalWidth write SetInternalWidth;
    property InternalHeight: Single read FInternalHeight write SetInternalHeight;
    property InternalPlaceOffset: TPosition read FInternalPlaceOffset write SetInternalPlaceOffset;
    // Local width of list item inside its designated area.
    property Width: Single read FWidth write SetWidth;
    // Local height of list item inside its designated area.
    property Height: Single read FHeight write SetHeight;

    // Horizontal alignment of list item inside its designated area.
    property Align: TListItemAlign read FAlign write SetAlign;
    // Vertical alignment of list item inside its designated area.
    property VertAlign: TListItemAlign read FVertAlign write SetVertAlign;
    // The offset in logical units regarding aligned location for finer placement control.
    property PlaceOffset: TPosition read FPlaceOffset write SetPlaceOffset;
    property Opacity: Single read FOpacity write SetOpacity;
  end;

  TCustomTextObjectAppearance = class(TCommonObjectAppearance)
  private
    FFont: TFont;
    FTextLayout: TTextLayout;

    FTextAlign: TTextAlign;
    FTextVertAlign: TTextAlign;
    FWordWrap: Boolean;

    FTextColor: TAlphaColor;
    FTrimming: TTextTrimming;
    FIsDetailText: Boolean;

    procedure FontChanged(Sender: TObject);

    procedure SetTextAlign(const Value: TTextAlign);
    procedure SetTextVertAlign(const Value: TTextAlign);
    procedure SetWordWrap(const Value: Boolean);
    procedure SetTextColor(const Value: TAlphaColor);
    procedure SetTrimming(const Value: TTextTrimming);
    procedure SetFont(const Value: TFont);
    function GetDefaultValues: TCustomTextObjectAppearance;
    procedure SetIsDetailText(const Value: Boolean);
  protected
    procedure AssignTo(ADest: TPersistent); override;
    function CreateDefaultValues: TObjectAppearance; override;

    function IsFontStored: Boolean;
    function IsTextAlignStored: Boolean;
    function IsTextVertAlignStored: Boolean;
    function IsWordWrapStored: Boolean;
    function IsDetailTextStored: Boolean;
    function IsTextColorStored: Boolean;
    function IsOpacityStored: Boolean;
    function IsTrimmingStored: Boolean;


  public
    constructor Create; override;
    destructor Destroy; override;
    procedure CreateObject(const AListViewItem: TListViewItem); override;
    procedure ResetObject(const AListViewItem: TListViewItem); override;
    property Font: TFont read FFont write SetFont;

    // Horizontal text alignment inside local item rectangle.
    property TextAlign: TTextAlign read FTextAlign write SetTextAlign;
    // Vertical text alignment inside local item rectangle.
    property TextVertAlign: TTextAlign read FTextVertAlign write SetTextVertAlign;

    property WordWrap: Boolean read FWordWrap write SetWordWrap;

    property TextColor: TAlphaColor read FTextColor write SetTextColor;
    property Trimming: TTextTrimming read FTrimming write SetTrimming;
    property IsDetailText: Boolean read FIsDetailText write SetIsDetailText;
    property DefaultValues: TCustomTextObjectAppearance read GetDefaultValues;
  end;

  TTextObjectAppearance = class(TCustomTextObjectAppearance)
  published
    property Font stored IsFontStored nodefault;
    property TextAlign stored IsTextAlignStored nodefault;
    property TextVertAlign stored IsTextVertAlignStored nodefault;
    property WordWrap stored IsWordWrapStored nodefault;
    property TextColor stored IsTextColorStored nodefault;
    property Trimming stored IsTrimmingStored nodefault;
    // Common
    property Width stored IsWidthStored nodefault;
    property Height stored IsHeightStored nodefault;
    property Align stored IsAlignStored nodefault;
    property VertAlign stored IsVertAlignStored nodefault;
    property Visible stored IsVisibleStored nodefault;
    property PlaceOffset stored IsPlaceOffsetStored nodefault;
    property Opacity stored IsOpacityStored nodefault;
  end;

  TCustomImageObjectAppearance = class(TCommonObjectAppearance)
  strict private var
    FSrcRect: TBounds;
    FScalingMode: TImageScalingMode;
    procedure SetScalingMode(const Value: TImageScalingMode);
    procedure SetSrcRect(const Value: TBounds);
    procedure OnSrcRectChange(Sender: TObject);
  private
    function GetDefaultValues: TCustomImageObjectAppearance;
  protected
    procedure AssignTo(ADest: TPersistent); override;
    function CreateDefaultValues: TObjectAppearance; override;
    function IsOpacityStored: Boolean;
    function IsSrcRectStored: Boolean;
    function IsScalingModeStored: Boolean;

  public
    constructor Create; override;
    destructor Destroy; override;
    procedure CreateObject(const AListViewItem: TListViewItem); override;
    procedure ResetObject(const AListViewItem: TListViewItem); override;
    property SrcRect: TBounds read FSrcRect write SetSrcRect;
    property ScalingMode: TImageScalingMode read FScalingMode write SetScalingMode;
    property DefaultValues: TCustomImageObjectAppearance read GetDefaultValues;
  end;

  TImageObjectAppearance = class(TCustomImageObjectAppearance)
  published
    property SrcRect stored IsSrcRectStored nodefault;
    property ScalingMode stored IsScalingModeStored nodefault;
    // Common
    property Width stored IsWidthStored nodefault;
    property Height stored IsHeightStored nodefault;
    property Align stored IsAlignStored nodefault;
    property VertAlign stored IsVertAlignStored nodefault;
    property Visible stored IsVisibleStored nodefault;
    property PlaceOffset stored IsPlaceOffsetStored nodefault;
    property Opacity stored IsOpacityStored nodefault;
  end;

  TCustomAccessoryObjectAppearance = class(TCommonObjectAppearance)
  strict private var
    FAccessoryType: TAccessoryType;

    procedure SetAccessoryType(const Value: TAccessoryType);
  private
    function GetDefaultValues: TCustomAccessoryObjectAppearance;
  protected
    procedure AssignTo(ADest: TPersistent); override;
    function CreateDefaultValues: TObjectAppearance; override;
    function IsAccessoryTypeStored: Boolean;
  public
    constructor Create; override;
    procedure CreateObject(const AListViewItem: TListViewItem); override;
    procedure ResetObject(const AListViewItem: TListViewItem); override;
    property AccessoryType: TAccessoryType read FAccessoryType write SetAccessoryType;
    property DefaultValues: TCustomAccessoryObjectAppearance read GetDefaultValues;
  end;

  TAccessoryObjectAppearance = class(TCustomAccessoryObjectAppearance)
  published
    property AccessoryType  stored IsAccessoryTypeStored nodefault;
    // Common
    property Width stored IsWidthStored nodefault;
    property Height stored IsHeightStored nodefault;
    property Align stored IsAlignStored nodefault;
    property VertAlign stored IsVertAlignStored nodefault;
    property Visible stored IsVisibleStored nodefault;
    property PlaceOffset stored IsPlaceOffsetStored nodefault;
    property Opacity stored IsOpacityStored nodefault;
  end;

  TCustomTextButtonObjectAppearance = class(TCommonObjectAppearance)
  strict private var
    FButtonType: TTextButtonType;

    procedure SetButtonType(const Value: TTextButtonType);
  private
    FOnControlClick: TNotifyEvent;
    FOnControlChange: TNotifyEvent;
    FText: string;
    FFont: TFont;
    FTrimming: TTextTrimming;
    FTextVertAlign: TTextAlign;
    FTextAlign: TTextAlign;
    FWordWrap: Boolean;
    FTextColor: TAlphaColor;
    FPressedTextColor: TAlphaColor;
    FTextShadowColor: TAlphaColor;
    FEnabled: Boolean;
    FHasButtonText: Boolean;
    function GetDefaultValues: TCustomTextButtonObjectAppearance;
    procedure SetText(const Value: string);
    procedure SetFont(const Value: TFont);
    procedure SetTextAlign(const Value: TTextAlign);
    procedure SetTextVertAlign(const Value: TTextAlign);
    procedure SetTrimming(const Value: TTextTrimming);
    procedure SetWordWrap(const Value: Boolean);
    procedure FontChanged(Sender: TObject);
    procedure SetPressedTextColor(const Value: TAlphaColor);
    procedure SetTextColor(const Value: TAlphaColor);
    procedure SetTextShadowColor(const Value: TAlphaColor);
    procedure SetEnabled(const Value: Boolean);
  protected
    procedure AssignTo(ADest: TPersistent); override;
    function CreateDefaultValues: TObjectAppearance; override;
    function IsButtonTypeStored: Boolean;
    function IsTextStored: Boolean;
    function IsTrimmingStored: Boolean;
    function IsFontStored: Boolean;
    function IsTextAlignStored: Boolean;
    function IsTextColorStored: Boolean;
    function IsPressedTextColorStored: Boolean;
    function IsTextShadowColorStored: Boolean;
    function IsTextVertAlignStored: Boolean;
    function IsWordWrapStored: Boolean;
    function IsEnabledStored: Boolean;
    procedure DoControlClick(Sender: TObject); virtual;
    procedure DoControlChange(Sender: TObject); virtual;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure CreateObject(const AListViewItem: TListViewItem); override;
    procedure ResetObject(const AListViewItem: TListViewItem); override;
    property ButtonType: TTextButtonType read FButtonType write SetButtonType;
    property Enabled: Boolean read FEnabled write SetEnabled;
    property Text: string read FText write SetText;
    property Trimming: TTextTrimming read FTrimming write SetTrimming;
    property Font: TFont read FFont write SetFont;
    property TextColor: TAlphaColor read FTextColor write SetTextColor;
    property PressedTextColor: TAlphaColor read FPressedTextColor write SetPressedTextColor;
    property TextShadowColor: TAlphaColor read FTextShadowColor write SetTextShadowColor;
    // Horizontal text alignment inside local item rectangle.
    property TextAlign: TTextAlign read FTextAlign write SetTextAlign;
    // Vertical text alignment inside local item rectangle.
    property TextVertAlign: TTextAlign read FTextVertAlign write SetTextVertAlign;
    property WordWrap: Boolean read FWordWrap write SetWordWrap;
    property DefaultValues: TCustomTextButtonObjectAppearance read GetDefaultValues;
    property OnControlClick: TNotifyEvent read FOnControlClick write FOnControlClick;
    property OnControlChange: TNotifyEvent read FOnControlChange write FOnControlChange;
  end;

  TTextButtonObjectAppearance = class(TCustomTextButtonObjectAppearance)
  published
    property ButtonType  stored IsButtonTypeStored nodefault;
    property Trimming stored IsTrimmingStored nodefault;
    property Font stored IsFontStored nodefault;
    property Enabled stored IsEnabledStored nodefault;
    property TextAlign stored IsTextAlignStored nodefault;
    property TextVertAlign stored IsTextVertAlignStored nodefault;
    property WordWrap stored IsWordWrapStored nodefault;
    property TextColor stored IsTextColorStored nodefault;
    property PressedTextColor stored IsPressedTextColorStored nodefault;
    property TextShadowColor stored IsTextShadowColorStored nodefault;
    // Common
    property Width stored IsWidthStored nodefault;
    // property Height stored IsHeightStored nodefault;  // Not adjustable
    property Align stored IsAlignStored nodefault;
    property VertAlign stored IsVertAlignStored nodefault;
    property Visible stored IsVisibleStored nodefault;
    property PlaceOffset stored IsPlaceOffsetStored nodefault;
    property Opacity stored IsOpacityStored nodefault;
    property Text stored IsTextStored nodefault;
  end;

  TCustomGlyphButtonObjectAppearance = class(TCommonObjectAppearance)
  strict private var
    FButtonType: TGlyphButtonType;
    FEnabled: Boolean;

    procedure SetButtonType(const Value: TGlyphButtonType);
  private
    FOnControlClick: TNotifyEvent;
    FOnControlChange: TNotifyEvent;
    FClickOnSelect: Boolean;
    function GetDefaultValues: TCustomGlyphButtonObjectAppearance;
    procedure SetClickOnSelect(const AValue: Boolean);
    procedure SetEnabled(const Value: Boolean);
  protected
    procedure AssignTo(ADest: TPersistent); override;
    function CreateDefaultValues: TObjectAppearance; override;
    function IsButtonTypeStored: Boolean;
    function IsEnabledStored: Boolean;
    function IsClickOnSelectStored: Boolean;
    procedure DoControlClick(Sender: TObject); virtual;
    procedure DoControlChange(Sender: TObject); virtual;
  public
    constructor Create; override;
    procedure CreateObject(const AListViewItem: TListViewItem); override;
    procedure ResetObject(const AListViewItem: TListViewItem); override;
    property ButtonType: TGlyphButtonType read FButtonType write SetButtonType;
    property Enabled: Boolean read FEnabled write SetEnabled;
    property ClickOnSelect: Boolean read FClickOnSelect write SetClickOnSelect;
    property DefaultValues: TCustomGlyphButtonObjectAppearance read GetDefaultValues;
    property OnControlClick: TNotifyEvent read FOnControlClick write FOnControlClick;
    property OnControlChange: TNotifyEvent read FOnControlChange write FOnControlChange;
  end;

  TGlyphButtonObjectAppearance = class(TCustomGlyphButtonObjectAppearance)
  published
    property ButtonType  stored IsButtonTypeStored nodefault;
    property Enabled stored IsEnabledStored nodefault;
    property ClickOnSelect stored IsClickOnSelectStored nodefault;
    // Common
    property Width stored IsWidthStored nodefault;
    property Height stored IsHeightStored nodefault;
    property Align stored IsAlignStored nodefault;
    property VertAlign stored IsVertAlignStored nodefault;
    property Visible stored IsVisibleStored nodefault;
    property PlaceOffset stored IsPlaceOffsetStored nodefault;
    property Opacity stored IsOpacityStored nodefault;
  end;

  TAppearanceObjects = class abstract (TPersistent)
  public type
    TControlEvent = procedure(const Sender: TObject; const AControl: TListItemSimpleControl) of object;
    TCreatingObjectsEvent = procedure(const Sender: TObject; const AListViewItem: TListViewItem; var AHandled: Boolean) of object;
    TCreateObjectsEvent = procedure(const Sender: TObject; const AListViewItem: TListViewItem) of object;
  private const
    cDefaultHeight = 44;
    cDefaultHeaderHeight = 24;
    cDefaultLeftSpaces = 10.0;
    cDefaultRightSpaces = 11.0;
  private
    [weak]FOwner: TCustomListView;
    FOnChange: TNotifyEvent;
    FOnChangeHeight: TNotifyEvent;
    function GetHeight: Integer; virtual;
    procedure SetHeight(Value: Integer); virtual;
  protected
    procedure ItemPropertyChange(Sender: TObject);
    procedure ItemControlClick(Sender: TObject);
    procedure ItemControlChange(Sender: TObject);
    procedure DoChange;
    procedure DoChangeHeight;
    procedure DoButtonClick(const AControl: TListItemSimpleControl);
    procedure DoButtonChange(const AControl: TListItemGlyphButton);
    procedure AssignTo(ADest: TPersistent); override;
    procedure UpdateSizes; virtual;
    procedure ResetObjects(const AListViewItem: TListViewItem); virtual;
    function DefaultHeight: Integer; virtual;
    function GetPublishedObjects: TArray<TCommonObjectAppearance>; virtual;
    function GetObjects: TArray<TCommonObjectAppearance>; virtual;
    // For custom appearances to read/write TListViewItem.Data
    procedure SetObjectData(const AListViewItem: TListViewItem; const AIndex: string; const AValue: TValue; var AHandled: Boolean); virtual;
  public
    constructor Create; virtual;
    property Owner: TCustomListView read FOwner write FOwner;
    property Height: Integer read GetHeight write SetHeight;
    procedure BeginUpdate;
    procedure EndUpdate;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnChangeHeight: TNotifyEvent read FOnChangeHeight write FOnChangeHeight;
    property Objects: TArray<TCommonObjectAppearance> read GetObjects;
    property PublishedObjects: TArray<TCommonObjectAppearance> read GetPublishedObjects;
  end;


  // Includes Text, Detail, etc.
  TItemAppearanceObjects = class(TAppearanceObjects)
  private const
    cDefaultHeight = TAppearanceObjects.cDefaultHeight;
  strict private
    FText: TTextObjectAppearance;
    FDetail: TTextObjectAppearance;
    FImage: TImageObjectAppearance;
    FAccessory: TAccessoryObjectAppearance;
    FTextButton: TTextButtonObjectAppearance;
    FGlyphButton: TGlyphButtonObjectAppearance;
    FHeight: Integer;
    FObjects: TArray<TCommonObjectAppearance>;
    FPublishedObjects: TArray<TCommonObjectAppearance>;
    procedure SetAccessoryElement(const Value: TAccessoryObjectAppearance);
    procedure SetTextButtonElement(const Value: TTextButtonObjectAppearance);
    procedure SetGlyphButtonElement(const Value: TGlyphButtonObjectAppearance);
    procedure SetImageElement(const Value: TImageObjectAppearance);
    procedure SetTextElement(const Value: TTextObjectAppearance);
    procedure SetDetailElement(const Value: TTextObjectAppearance);
  protected
    procedure AssignTo(ADest: TPersistent); override;
    function GetHeight: Integer; override;
    procedure SetHeight(Value: Integer); override;
    function DefaultHeight: Integer; override;
    function GetPublishedObjects: TArray<TCommonObjectAppearance>; override;
    procedure AddObject(const AObjectAppearance: TCommonObjectAppearance; APublished: Boolean);
    function GetObjects: TArray<TCommonObjectAppearance>; override;
  public
    constructor Create; override;
    destructor Destroy; override;
    property Text: TTextObjectAppearance read FText write SetTextElement;
    property Detail: TTextObjectAppearance read FDetail write SetDetailElement;
    property Image: TImageObjectAppearance read FImage write SetImageElement;
    property Accessory: TAccessoryObjectAppearance read FAccessory write SetAccessoryElement;
    property TextButton: TTextButtonObjectAppearance read FTextButton write SetTextButtonElement;
    property GlyphButton: TGlyphButtonObjectAppearance read FGlyphButton write SetGlyphButtonElement;
  end;

  TItemAppearanceProperties = class(TPersistent)
  public type
    TControlEvent = TAppearanceObjects.TControlEvent;
    TItemAppearanceObjectsClass = TCustomListView.TItemAppearanceObjectsClass;
    TAppearancePropertiesEvent = procedure(const Sender: TItemAppearanceProperties) of object;
  public const
    cDefaultHeight = TAppearanceObjects.cDefaultHeight;
  strict private
    [weak] FOwner: TCustomListView;
    FName: string;
    FAppearanceType: TCustomListView.TAppearanceType;
    FAppearanceCache: TDictionary<TItemAppearanceObjectsClass, TItemAppearanceObjects>;
    FAppearance: TItemAppearanceObjects;
    FAppearanceClass: TItemAppearanceObjectsClass;
    FPurpose: TListItemPurpose;
    procedure SetName(const Value: string);
    procedure SetObjects(const Value: TItemAppearanceObjects);
    procedure PropertiesChange(Sender: TObject);
    procedure PropertiesChangeHeight(Sender: TObject);
    function GetHeight: Integer;
    procedure SetHeight(AValue: Integer);
    procedure SetAppearanceClass(const Value: TItemAppearanceObjectsClass);
    function GetAppearanceClassName: string;
    procedure SetAppearanceClassName(const Value: string);
    procedure DoChange;
    procedure DoChangeHeight;
    procedure DoChangeObjects;
    function GetActive: Boolean;
  protected
    function IsHeightStored: Boolean;
  public
    constructor Create(const AListView: TCustomListView; AType: TCustomListView.TAppearanceType);
    destructor Destroy; override;
    property Purpose: TListItemPurpose read FPurpose;
    property AppearanceClass: TItemAppearanceObjectsClass read FAppearanceClass write SetAppearanceClass;
    property Owner: TCustomListView read FOwner;
    property Active: Boolean read GetActive;
    property AppearanceClassName: string read GetAppearanceClassName write SetAppearanceClassName;
    property Name: string read FName write SetName stored False;
    property Height: Integer read GetHeight write SetHeight;
    property Objects: TItemAppearanceObjects read FAppearance write SetObjects;  // Objects is published name of Appearance
    property AppearanceType: TCustomListView.TAppearanceType read FAppearanceType;
  end;

  // Does not create objects
  TEmptyItemObjects = class(TItemAppearanceObjects)
  private const
    cDefaultHeight = TAppearanceObjects.cDefaultHeight;
  private var
    FHeight: Integer;
  protected
    procedure SetHeight(Value: Integer); override;
    function GetHeight: Integer; override;
    function DefaultHeight: Integer; override;
  public
    constructor Create; override;
  end;

  // Disables all services for managing TListViewItem.Objects, such as creating and resizing
  TNullItemObjects = class(TEmptyItemObjects)
  end;

  // Set some defaults on Text, Detail, etc.
  TCustomItemObjects = class(TItemAppearanceObjects)
  public const
    cDefaultHeight = TAppearanceObjects.cDefaultHeight;
    cDefaultButtonHeight = 31;
    cDefaultTextButtonWidth = 64;
    cDefaultImageWidth = 29;
    cDefaultImageHeight = 29;
    cDefaultImageTextPlaceOffsetX = 10;
    cDefaultGlyphPlaceOffsetX = -6;
  protected
    procedure UpdateSizes; override;
    function GetStyleResources: TListItemStyleResources;
    procedure SetInternalSize(const AGlyphButton: TGlyphButtonObjectAppearance;
      AStyleResources: TListItemStyleResources); overload;
    procedure SetInternalSize(const AAccessory: TAccessoryObjectAppearance;
      AStyleResources: TListItemStyleResources); overload;
    function DefaultHeight: Integer; override;
  public
    constructor Create; override;
    property Text;
    property Detail;
    property Image;
    property Accessory;
    property TextButton;
    property GlyphButton;
  end;

  // Base class for item object presets
  TPresetItemObjects = class(TCustomItemObjects)
  public type
    TGroupClass = class of TPresetItemObjects;
  protected
    procedure ResetObjects(const AListViewItem: TListViewItem); override;
    // Identify the ancestor class that supports resetobjects
    function GetGroupClass: TGroupClass; virtual;
    // Indicate if this is an itemedit appearance
    function GetIsItemEdit: Boolean; virtual;
    property IsItemEdit: Boolean read GetIsItemEdit;
    property GroupClass: TGroupClass read GetGroupClass;
  end;


implementation

uses
  System.RTLConsts, System.TypInfo
  {$IFDEF MACOS}, Macapi.CoreFoundation{$ENDIF};


const
  MouseClickTreshold = 12;
  TentativeBufferSize = 128;
  AutoTapScrollingSpeed = 4;

  ItemSeparatorTop = 1;
  ItemSeparatorBottom = 2;

{$IFDEF IOS}
  DefaultScrollBarWidth = 7;
{$ELSE}
{$IFDEF MACOS}
  DefaultScrollBarWidth = 7;
{$ENDIF}
{$ENDIF}

{$IFDEF MSWINDOWS}
  DefaultScrollBarWidth = 16;
{$ENDIF}

type
  TOpenListItemObject = class(TListItemObject);
  TOpenListBoxItem = class(TListItem);
  TOpenBitmap = class(TBitmap);


function RectF(X, Y, Width, Height: Single): TRectF; inline;
begin
  Result.Left := X;
  Result.Top := Y;
  Result.Right := X + Width;
  Result.Bottom := Y + Height;
end;

type
  TRegisterAppearanceValue = record
    Name: string;
    UnitName: string;
    Options: TCustomListView.TRegisterAppearanceOptions;
    constructor Create(const AName: string; AOptions: TCustomListView.TRegisterAppearanceOptions;
      const AUnitName: string);
  end;

var
 FFactories: TDictionary<TCustomListView.TItemAppearanceObjectsClass, TRegisterAppearanceValue>;


constructor TCustomListView.Create(AOwner: TComponent);
begin
  inherited;
  CanFocus := True;
  DisableFocusEffect := True;
  AutoCapture := True;

  FEditModeOptions := cDefaultEditModeOptions;

  FScrollBar := TScrollBar.Create(nil);
  FScrollBar.Stored := False;
  FScrollBar.DesignVisible := False;
  FScrollBar.Orientation := TOrientation.orVertical;
  FScrollBar.Align := TAlignLayout.alRight;
  FScrollBar.Width := DefaultScrollBarWidth;

  FScrollBar.Parent := Self;

{$IFNDEF IOS}
  FScrollBar.Visible := False;
  FScrollBar.OnChange := ScrollBarChange;
{$ENDIF}

  FAppearanceProperties := TPublishedAppearance.Create(Self);
  FItemAppearanceObjects := TPublishedObjects.Create(Self);

  FItemAppearanceProperties := TItemAppearanceProperties.Create(Self, TAppearanceType.Item);
  InitializeItemAppearance(FItemAppearanceProperties);
  FItemEditAppearanceProperties := TItemAppearanceProperties.Create(Self, TAppearanceType.ItemEdit);
  InitializeItemAppearance(FItemEditAppearanceProperties);
  FHeaderAppearanceProperties := TItemAppearanceProperties.Create(Self, TAppearanceType.Header);
  InitializeItemAppearance(FHeaderAppearanceProperties);
  FFooterAppearanceProperties := TItemAppearanceProperties.Create(Self, TAppearanceType.Footer);
  InitializeItemAppearance(FFooterAppearanceProperties);

  FListViewItems := TListViewItems.Create(Self);
  FListViewItems.OnNotify := ObjectsNotify;
{$IFDEF IOS}
  FAniCalc := TAniCalculations.Create(nil);
  FAniCalc.Animation := True;
  FAniCalc.OnChanged := AniCalcChange;
  FAniCalc.Interval := Round(1000.0 / 120.0);
  FAniCalc.OnStart := AniCalcStart;
  FAniCalc.OnStop := AniCalcStop;
{$ENDIF}
  FItemSpaces := TBounds.Create(TRectF.Create(
    TAppearanceObjects.cDefaultLeftSpaces, 0.0,
    TAppearanceObjects.cDefaultRightSpaces, 0.0));
  FItemSpaces.OnChange := ItemSpacesChange;

  FBrush := TBrush.Create(TBrushKind.bkSolid, $FF000000);
  FStroke := TStrokeBrush.Create(TBrushKind.bkSolid, $FF000000);

  FStyleResources := TListItemStyleResources.Create;

  HeightSums := TItemHeightSums.Create;
  HeightSumsDirty := False;

  FItemIndex := -1;
  MouseClickIndex := -1;
  MouseEventIndex := -1;
  FTransparent := False;
  FAllowSelection := True;
  FShowSelection := True;
  FAutoTapTreshold := 8;

  MaxKnownHeight := 0;
  FScrollScale := 1.0;

  UpdateScrollingLimits();
end;

destructor TCustomListView.Destroy();
begin
  FreeAndNil(ItemSelectTimer);
  FEditModeState.Free;

  HeightSums.Free;
  FStroke.Free;
  FBrush.Free;
  FItemSpaces.Free;

{$IFDEF IOS}
  FAniCalc.Free;
{$ENDIF}

  FListViewItems.Free;

  FAppearanceProperties.Free;
  FItemAppearanceObjects.Free;
  FItemAppearanceProperties.Free;
  FItemEditAppearanceProperties.Free;
  FHeaderAppearanceProperties.Free;
  FFooterAppearanceProperties.Free;

  FStyleResources.Free;

  inherited;
end;


procedure TCustomListView.InitializeItemAppearance(const AAppearance: TItemAppearanceProperties);
begin
  AAppearance.AppearanceClass := TNullItemObjects;
end;

procedure TCustomListView.ItemAppearanceChange(const Sender: TItemAppearanceProperties);
begin
  if FResettingObjects then
    Exit;
  Assert(Sender <> nil);
  if Sender <> nil then
    if FUpdatingAppearance = 0 then
      AppearanceResetObjects([Sender.Purpose])
    else
      Include(FChangedAppearanceObjects, Sender.Purpose);
end;

procedure TCustomListView.ItemAppearanceChangeObjects(const Sender: TItemAppearanceProperties);
begin
  ItemAppearanceChange(Sender);
end;

procedure TCustomListView.AppearanceResetObjects(APurposes: TListItemPurposes);
var
  LPurposes: TListItemPurposes;
  LProperties: TItemAppearanceProperties;
begin
  if Items <> nil then
  begin
    LPurposes := [];
    for LProperties in GetAppearanceProperties do
      if LProperties.Active then
        Include(LPurposes, LProperties.Purpose);
    LPurposes := LPurposes * APurposes;
    if LPurposes <> [] then
    begin
      Items.ResetObjects(LPurposes); // update or recreate rendering objects
      InvalidateHeights;
      UpdateScrollingLimits();
      Invalidate;
    end;
  end;
end;

procedure TCustomListView.AppearanceResetHeights(APurposes: TListItemPurposes);
var
  LPurposes: TListItemPurposes;
  LProperties: TItemAppearanceProperties;
begin
  if Items <> nil then
  begin
    LPurposes := [];
    for LProperties in GetAppearanceProperties do
      if LProperties.Active then
        Include(LPurposes, LProperties.Purpose);
    LPurposes := LPurposes * APurposes;
    if LPurposes <> [] then
    begin
      InvalidateHeights;
      UpdateScrollingLimits();
      Invalidate;
    end;
  end;
end;

procedure TCustomListView.ResizeAppearances;
begin
  BeginUpdate;
  try
    Items.ResetObjects([]);
  finally
    EndUpdate;
  end;
end;

procedure TCustomListView.RefreshAppearances(const APurposes: TListItemPurposes);
begin
  Items.ResetObjects(APurposes);
  InvalidateHeights; // Object heights may have changed
end;

procedure TCustomListView.UpdateAppearanceStyleResources;
begin
  Assert(not FUpdateStyleResources);
  if not FUpdateStyleResources then
  begin
    FUpdateStyleResources := True;
    try
      RefreshAppearances;
    finally
      FUpdateStyleResources := False;
    end;
  end;
end;

procedure TCustomListView.ItemAppearanceChangeHeight(const Sender: TItemAppearanceProperties);
begin
  Assert(Sender <> nil);
  if Sender <> nil then
    if FUpdatingAppearance = 0 then
      AppearanceResetHeights([Sender.Purpose])
    else
      Include(FChangedAppearanceHeights, Sender.Purpose);
end;

function TCustomListView.GetItemCount: Integer;
begin
  Result := Items.Count;
end;

procedure TCustomListView.ObjectsNotify(Sender: TObject; const Item: TListViewItem; Action: TCollectionNotification);
begin
  HeightSumsDirty := True;
end;

procedure TCustomListView.SelectItemNotify(Sender: TObject);
begin
  if (FAutoTapDistance > 0) then
  begin
    AnimateFloat('ScrollViewPos', 0.0, Min(FAutoTapDistance / AutoTapScrollingSpeed, 1.0), TAnimationType.atOut,
      TInterpolationType.itSinusoidal);
    ItemSelectTimerWorked := True;
  end
  else if (ItemSelectTimerIndex <> -1) and (InternalAllowSelection) then
  begin
    if (TOpenListBoxItem(Items[ItemSelectTimerIndex]).HasClickOnSelectItems) then
      FItemIndex := -1;

    SetItemIndex(ItemSelectTimerIndex);
    ItemSelectTimerIndex := -1;
    ItemSelectTimerWorked := True;
  end;

  ItemSelectTimer.Enabled := False;
end;

procedure TCustomListView.ItemSpacesChange(Sender: TObject);
begin
  Invalidate;
end;

function TCustomListView.GetInternalAllowSelection: Boolean;
begin
  Result := FAllowSelection and ((FEditModeState = nil) or (not FEditModeState.DisallowSelection));
end;

function TCustomListView.GetInternalShowSelection: Boolean;
begin
  Result := FShowSelection and ((FEditModeState = nil) or (not FEditModeState.HideSelection));
end;

function TCustomListView.GetItem(Index: Integer): TListViewItem;
begin
  if (Index < 0) or (Index >= Items.Count) then
    raise EListError.CreateFmt(SListIndexError, [Index]);

  Result := Items[Index];
end;

function TCustomListView.GetItemAppearanceName: string;
begin
  Result := FItemAppearanceProperties.Name;
end;

function TCustomListView.GetItemEditAppearanceName: string;
begin
  Result := FItemEditAppearanceProperties.Name;
end;

function TCustomListView.GetItemObjectsClassName: string;
begin
  Result := FItemAppearanceProperties.AppearanceClassName;
end;

function TCustomListView.GetItemEditObjectsClassName: string;
begin
  Result := FItemEditAppearanceProperties.AppearanceClassName;
end;

procedure TCustomListView.SetSideSpace(const Value: Integer);
var
  NewValue: Integer;
begin
  NewValue := Max(Value, 0);

  if (FSideSpace <> NewValue) then
  begin
    FSideSpace := NewValue;
    Invalidate;
  end;
end;

procedure TCustomListView.SetTransparent(const Value: Boolean);
begin
  if (FTransparent <> Value) then
begin
    FTransparent := Value;
    Invalidate;
  end;
end;

procedure TCustomListView.SetAlternatingColors(const Value: Boolean);
begin
  if (FAlternatingColors <> Value) then
  begin
    FAlternatingColors := Value;
    Invalidate;
  end;
end;


procedure TCustomListView.SetAppearanceProperties(
  const Value: TCustomListView.TPublishedAppearance);
begin
  Assert(False);
  // Do nothing
end;

procedure TCustomListView.SetItemAppearanceObjects(
  const Value: TPublishedObjects);
begin
  Assert(False);
  // Do nothing
end;

procedure TCustomListView.SetItemHeight(const Value: Integer);
begin
  FItemAppearanceProperties.Height := Value;
end;

procedure TCustomListView.SetItemEditHeight(const Value: Integer);
begin
  FItemEditAppearanceProperties.Height := Value;
end;

procedure TCustomListView.SetHeaderHeight(const Value: Integer);
begin
  FHeaderAppearanceProperties.Height := Value;
end;

procedure TCustomListView.SetFooterHeight(const Value: Integer);
begin
  FFooterAppearanceProperties.Height := Value;
end;

procedure TCustomListView.SetItemIndex(const Value: Integer);
var
  NewValue: Integer;
begin
  NewValue := Value;

  if (NewValue < 0) or (NewValue > Items.Count - 1) then
    NewValue := -1;

  if (NewValue <> FItemIndex) then
  begin
    FItemIndex := NewValue;
    if FItemIndex <> -1 then
      ScrollTo(FItemIndex);  // Make selected item visible.

    if (FItemIndex >= 0) and (FItemIndex < Items.Count) then
      TOpenListBoxItem(Items[FItemIndex]).MouseSelect;
    
    DoChange;

    Invalidate;
  end;
end;

procedure TCustomListView.SetItemAppearanceName(const Value: string);
begin
  FItemAppearanceProperties.Name := Value;
end;

procedure TCustomListView.SetItemEditAppearanceName(const Value: string);
begin
  FItemEditAppearanceProperties.Name := Value;
end;

procedure TCustomListView.SetItemObjectsClassName(const Value: string);
begin
  FItemAppearanceProperties.AppearanceClassName := Value;
end;

procedure TCustomListView.SetItemEditObjectsClassName(const Value: string);
begin
  FItemEditAppearanceProperties.AppearanceClassName := Value;
end;

procedure TCustomListView.SetEditMode(const Value: Boolean);

  procedure InitEditModeOptions(const AOptions: TEditModeOptions);
  begin
    FreeAndNil(FEditModeState);
    FEditModeState := TEditModeState.Create(Self);
    if FEditModeState.ClearWhenStart then
      // check or uncheck all
      Items.CheckAll(not FEditModeState.CheckedValue);
  end;

var
  LHandled: Boolean;
begin
  if FEditMode <> Value then
  begin
    LHandled := False;
    DoEditModeChanging(LHandled);
    if not LHandled then
    begin
      FEditMode := Value;
      BeginUpdate;
      try
        if FEditMode then
          InitEditModeOptions(EditModeOptions)
        else
          FreeAndNil(FEditModeState);
        RefreshAppearances([TListItemPurpose.None]);
      finally
        EndUpdate;
      end;
    end;
    DoEditModeChange;
  end;
end;

procedure TCustomListView.DoEditModeChanging(var AHandled: Boolean);
begin
  if Assigned(FOnEditModeChanging) then
    FOnEditModeChanging(Self, AHandled);
end;

procedure TCustomListView.DoEditModeChange;
begin
  if Assigned(FOnEditModeChange) then
    FOnEditModeChange(Self);
end;

procedure TCustomListView.SetHeaderAppearanceName(const Value: string);
begin
  FHeaderAppearanceProperties.Name := Value;
end;

procedure TCustomListView.SetHeaderAppearanceClassName(const Value: string);
begin
  FHeaderAppearanceProperties.AppearanceClassName := Value;
end;

procedure TCustomListView.SetFooterAppearanceName(const Value: string);
begin
  FFooterAppearanceProperties.Name := Value;
end;

procedure TCustomListView.SetFilterPredicate(
  const Predicate: TPredicate<string>);
begin
  Items.Filter := Predicate;
end;

procedure TCustomListView.SetFooterAppearanceClassName(const Value: string);
begin
  FFooterAppearanceProperties.AppearanceClassName := Value;
end;

procedure TCustomListView.SetItemSpaces(const Value: TBounds);
begin
  FItemSpaces.Assign(Value);
end;

function TCustomListView.GetAppearanceProperties: TArray<TItemAppearanceProperties>;
begin
  SetLength(Result, 4);
  Result[0] := FItemEditAppearanceProperties;
  Result[1] := FItemAppearanceProperties;
  Result[2] := FHeaderAppearanceProperties;
  Result[3] := FFooterAppearanceProperties;
end;

procedure TCustomListView.ResetObjects(const AItem: TListViewItem);
var
  LHandled: Boolean;
  LItemObjects: TItemAppearanceObjects;
begin
  if FResettingObjects then
    Exit;
  FResettingObjects := True;
  try
    AItem.SetHasObjects;
    LItemObjects := nil;
    case AItem.Purpose of
      TListItemPurpose.None:
        if FItemEditAppearanceProperties.Active then
          LItemObjects := FItemEditAppearanceProperties.Objects
        else if FItemAppearanceProperties.Active then
          LItemObjects := FItemAppearanceProperties.Objects;
      TListItemPurpose.Header:
        if FHeaderAppearanceProperties.Active then
          LItemObjects := FHeaderAppearanceProperties.Objects;
      TListItemPurpose.Footer:
        if FFooterAppearanceProperties.Active then
          LItemObjects := FFooterAppearanceProperties.Objects;
    else
      Assert(False);
    end;
    if (LItemObjects <> nil) and not (LItemObjects is TNullItemObjects) then
    begin
      LHandled := False;
      DoUpdatingObjects(AItem, LHandled);
      if not LHandled then
        LItemObjects.ResetObjects(AItem);
      DoUpdateObjects(AItem);
    end;
  finally
    FResettingObjects := False;
  end;
end;

function TCustomListView.CanObserve(const ID: Integer): Boolean;
begin
  Result := False;
  if ID = TObserverMapping.EditLinkID then
    Result := True
  else if ID = TObserverMapping.PositionLinkID then
    Result := True
  else if ID = TObserverMapping.ControlValueID then
    Result := True;
end;

procedure TCustomListView.DoItemClick(const AItem: TListViewItem);
begin
  if Assigned(FOnItemClick) then
    FOnItemClick(Self, AItem);
end;

procedure TCustomListView.DoButtonClick(const AObject: TListItemSimpleControl);
begin
  if Assigned(FOnButtonClick) then
  begin
    Assert(AObject.Owner is TListViewItem);
    FOnButtonClick(Self, AObject.Owner as TListViewItem, AObject);
  end;
end;

procedure TCustomListView.DoUpdateObjects(const AListViewItem: TListViewItem);
begin
  if Assigned(FOnUpdateObjects) then
  begin
    FOnUpdateObjects(Self, AListViewItem);
  end;
end;

procedure TCustomListView.DoUpdatingObjects(const AListViewItem: TListViewItem; var AHandled: Boolean);
begin
  if Assigned(FOnUpdatingObjects) then
  begin
    FOnUpdatingObjects(Self, AListViewItem, AHandled);
  end;
end;

procedure TCustomListView.DoButtonChange(const AObject: TListItemGlyphButton);

  procedure ClearOthers(const AListItem: TListItem);
  var
    LIndex: Integer;
  begin
    LIndex := (AListItem as TListViewItem).Index;
    Items.CheckAll(
      function(I: Integer): Boolean
      begin
        Result := I <> LIndex;
      end,
      not FEditModeState.CheckedValue);
  end;

begin
  if (FEditModeState <> nil) and not FEditModeState.Clearing and FEditModeState.RadioButtonMode and
     (AObject.Checked = FEditModeState.CheckedValue) then
  begin
    FEditModeState.BeginClearing;
    try
      ClearOthers(AObject.Owner);
    finally
      FEditModeState.EndClearing;
    end;
  end;

  if Assigned(FOnButtonChange) then
  begin
    Assert(AObject.Owner is TListViewItem);
    FOnButtonChange(Self, AObject.Owner as TListViewItem, AObject);
  end;
end;

procedure TCustomListView.DoExit;
begin
  inherited;
  if Observers.IsObserving(TObserverMapping.EditLinkID) then
    if TLinkObservers.EditLinkIsEditing(Observers) then
      TLinkObservers.EditLinkUpdate(Observers);
  if Observers.IsObserving(TObserverMapping.ControlValueID) then
    TLinkObservers.ControlValueUpdate(Observers);
end;


procedure TCustomListView.ClearItems;
begin
  Items.Clear;
end;

procedure TCustomListView.UpdateScrollViewPos(const Value: Single);
begin
  if (FScrollViewPos <> Value) then
  begin
    FScrollViewPos := Value;
    Invalidate;
  end;
end;

function TCustomListView.GetMaxScrollViewPos(): Integer;
begin
  Result := Trunc(FSideSpace * 2 + MaxKnownHeight - LocalRect.Height);
end;

procedure TCustomListView.SetScrollViewPos(const Value: Single);
var
  NewValue, MaxValue: Single;
begin
  NewValue := Value;

  if (NewValue < 0.0) then
    NewValue := 0.0;

  MaxValue := GetMaxScrollViewPos();
  if (NewValue > MaxValue) then
    NewValue := MaxValue;

  UpdateScrollViewPos(NewValue);

  if Assigned(FAniCalc) then
    FAniCalc.ViewportPosition := TPointD.Create(0.0, FScrollViewPos);

{$IFNDEF IOS}
  UpdateScrollBar;
{$ENDIF}
end;

procedure TCustomListView.SetSelected(const Value: TListViewItem);
begin
  if Value = nil then
    ItemIndex := -1
  else
    ItemIndex := Items.IndexOf(Value);
end;

procedure TCustomListView.SetShowSelection(const Value: Boolean);
begin
  if (FShowSelection <> Value) then
  begin
    FShowSelection := Value;
    Invalidate;
  end;
end;

procedure TCustomListView.ScrollBarChange(Sender: TObject);
begin
  UpdateScrollViewPos(Int(FScrollBar.Value));
end;

procedure TCustomListView.AniCalcChange(Sender: TObject);
var
  NewViewPos: Single;
begin
  if (FScrollScale > 1.5) then
    NewViewPos := Int(FAniCalc.ViewportPosition.Y * 2.0) / 2.0
  else
    NewViewPos := Int(FAniCalc.ViewportPosition.Y);

  if (NewViewPos <> FScrollViewPos) then
  begin
    if Assigned(ItemSelectTimer) and (ItemSelectTimer.Enabled) then
    begin
      ItemSelectTimer.Enabled := False;
      ItemSelectTimerIndex := -1;
    end;

    if NeedShowScrollBar then
    begin
      FScrollBar.StopPropertyAnimation('Opacity');
      FScrollBar.Opacity := 1.0;

      NeedShowScrollBar := False;
    end;
  end;

  UpdateScrollViewPos(NewViewPos);
  UpdateScrollBar;
end;

procedure TCustomListView.AniCalcStart(Sender: TObject);
begin
  if Assigned(Scene) then
    Scene.ChangeScrollingState(Self, True);

  NeedShowScrollBar := True;

  ScrollingActive := True;
end;

procedure TCustomListView.AniCalcStop(Sender: TObject);
begin
  FScrollBar.AnimateFloat('Opacity', 0.0, 0.2);
  ScrollingActive := False;
  if Assigned(Scene) then
    Scene.ChangeScrollingState(nil, False);
end;

procedure TCustomListView.UpdateScrollBar;
var
  LocalHeight, ViewSize: Single;
begin
  LocalHeight := LocalRect.Height;

  if (FScrollViewPos < 0) then
  begin
    ViewSize := LocalHeight + FScrollViewPos;
  end
  else if (FScrollViewPos > MaxKnownHeight - LocalHeight) then
  begin
    ViewSize := LocalHeight - (FScrollViewPos - (MaxKnownHeight - LocalHeight));
  end
  else
    ViewSize := LocalHeight;

  FScrollBar.BeginUpdate;
  try
    FScrollBar.Max := FSideSpace * 2 + MaxKnownHeight;
    FScrollBar.SmallChange := ItemHeight * 0.5;
    if not (csDesigning in ComponentState) then  // Don't show at design time
      FScrollBar.Visible := MaxKnownHeight > LocalHeight
    else
      FScrollBar.Visible := False;
    FScrollBar.Value := FScrollViewPos;
    FScrollBar.ViewportSize := ViewSize;
  finally
    FScrollBar.EndUpdate;
  end;
end;

procedure TCustomListView.UpdateScrollingLimits();
var
  Targets: array of TAniCalculations.TTarget;
begin
  if Assigned(FAniCalc) then
  begin
    SetLength(Targets, 2);

    Targets[0].TargetType := ttMin;
    Targets[0].Point := TPointD.Create(0, 0);
    Targets[1].TargetType := ttMax;
    Targets[1].Point := TPointD.Create(0, Max(FSideSpace * 2 + MaxKnownHeight - LocalRect.Height, 0));

    FAniCalc.SetTargets(Targets);
  end;

{$IFNDEF IOS}
  UpdateScrollBar;
{$ENDIF}
end;

function TCustomListView.GetNumberOfPassesForObjects(const StartItem, EndItem: Integer): Integer;
var
  I: Integer;
begin
  Result := 0;

    for I := StartItem to EndItem do
    begin
      Items[I].CreateObjects;
      Result := Max(Result, Items[I].Count);
    end;
end;

function TCustomListView.GetNumberOfSubPassesForObjects(const StartItem, EndItem: Integer): Integer;
var
  I, J: Integer;
begin
  Result := 0;

  for J := StartItem to EndItem do
    for I := 0 to Items[J].Count - 1 do
      Result := Max(Result, TOpenListItemObject(Items[J].Objects[I]).GetRenderPassCount);
end;

function TCustomListView.GetItemHeight(Index: Integer): Integer;
begin
  if (Index < 0) or (Index >= Items.Count) then
    Exit(0);

  Result := Items[Index].Height;
  if (Result < 1) then
    case Items[Index].Purpose of
      TListItemPurpose.None:
        if EditMode and FItemEditAppearanceProperties.Active then
          Result := ItemEditHeight
        else
          Result := ItemHeight;
      TListItemPurpose.Header:
        Result := HeaderHeight;
      TListItemPurpose.Footer:
        Result := FooterHeight;
    else
      Assert(False);
    end;
end;

function TCustomListView.GetItemHeight: Integer;
begin
  Result := FItemAppearanceProperties.Height;
end;

function TCustomListView.GetItemEditHeight: Integer;
begin
  Result := FItemEditAppearanceProperties.Height;
end;

function TCustomListView.GetHeaderAppearanceName: string;
begin
  Result := FHeaderAppearanceProperties.Name;
end;

function TCustomListView.GetHeaderAppearanceClassName: string;
begin
  Result := FHeaderAppearanceProperties.AppearanceClassName;
end;

function TCustomListView.GetHeaderHeight: Integer;
begin
  Result := FHeaderAppearanceProperties.Height;
end;

function TCustomListView.GetFooterAppearanceName: string;
begin
  Result := FFooterAppearanceProperties.Name;
end;

function TCustomListView.GetFooterAppearanceClassName: string;
begin
  Result := FFooterAppearanceProperties.AppearanceClassName;
end;

function TCustomListView.GetFooterHeight: Integer;
begin
  Result := FFooterAppearanceProperties.Height;
end;

function TCustomListView.GetItemRelRect(const Index: Integer; const LocRect: TRectF;
  const SideSpace: Integer = 0): TRectF;
begin
  Result := RectF(LocRect.Left + FSideSpace + SideSpace, LocRect.Top + FSideSpace + HeightSums[Index] - FScrollViewPos,
    LocRect.Width - ((SideSpace + FSideSpace) * 2), GetItemHeight(Index));

{$IFDEF MSWINDOWS}
  if (FScrollBar.Visible) and (not Assigned(FAniCalc)) then
    Result.Right := Result.Right - FScrollBar.Width;
{$ENDIF}
end;

function TCustomListView.GetSelected: TListViewItem;
begin
  if (ItemIndex >= 0) and (ItemIndex < Items.Count) then
    Result := Items[ItemIndex]
  else
    Result := nil;
end;

function TCustomListView.GetStyleResources: TListItemStyleResources;
begin
  if not (csDesigning in ComponentState) then  // load later if designing
    ApplyStyleLookup;
  Result := FStyleResources;
end;

function TCustomListView.GetItemGroupSeparators(const Index: Integer): Integer;
var
  EndIndex: Integer;
begin
  Result := 0;

  EndIndex := Items.Count - 1;
  if (Index < 0) or (Index > EndIndex) then
    Exit;

  if (Index > 0) and (Index < EndIndex) and (Items[Index - 1].Count > 0) and (Items[Index + 1].Count > 0) then
    Exit;

  if (Index = 0) or ((Items[Index - 1].Count < 1) and (Items[Index - 1].Purpose = TListItemPurpose.None)) then
    Result := Result or ItemSeparatorTop;

  if (Index >= EndIndex) or ((Items[Index + 1].Count < 1) and (Items[Index + 1].Purpose = TListItemPurpose.None)) then
    Result := Result or ItemSeparatorBottom;
end;

procedure TCustomListView.DrawItemsFill(const StartItem, EndItem: Integer; const LocRect: TRectF; HeaderIndex: Integer);
var
  I, Sep, AltIndex: Integer;
  DrawRect, DrawSubRect: TRectF;
  ItemObjects: TListViewItem;
begin
  for I := StartItem to EndItem do
    if (I <> HeaderIndex) then
    begin
      ItemObjects := Items[I];

      if Assigned(ItemObjects) and ((ItemObjects.Count > 0) or (Items[Index - 1].Purpose <> TListItemPurpose.None)) then
      begin
        DrawRect := GetItemRelRect(I, LocRect, 1);
        if (ItemObjects.Purpose = TListItemPurpose.None) then
        begin
          FBrush.Color := ItemStyleFillColor;

          if (TOpenListBoxItem(Items[StartItem]).FHeaderRef <> -1) then
            AltIndex := Max((I - TOpenListBoxItem(Items[StartItem]).FHeaderRef) - 1, 0)
          else
            AltIndex := I;

          if (FAlternatingColors) and (AltIndex mod 2 = 1) then
            FBrush.Color := ItemStyleFillAltColor;

          Canvas.FillRect(DrawRect, 0, 0, AllCorners, 1, FBrush);
        end;

        Sep := GetItemGroupSeparators(I);

        FBrush.Color := ItemStyleFrameColor;
        Canvas.FillRect(RectF(DrawRect.Left - 1, DrawRect.Top, 1, DrawRect.Height), 0, 0, AllCorners, 1, FBrush);
        Canvas.FillRect(RectF(DrawRect.Right, DrawRect.Top, 1, DrawRect.Height), 0, 0, AllCorners, 1, FBrush);

        if (Sep and ItemSeparatorTop > 0) and (ItemObjects.Purpose = TListItemPurpose.None) then
          Canvas.FillRect(RectF(DrawRect.Left, DrawRect.Top, DrawRect.Width, 1), 0, 0, AllCorners, 1, FBrush);

        if (ItemObjects.Purpose = TListItemPurpose.None) and
          ((I >= Items.Count - 1) or (Items[I + 1].Purpose = TListItemPurpose.None)) then
          Canvas.FillRect(RectF(DrawRect.Left, DrawRect.Bottom - 1, DrawRect.Width, 1), 0, 0, AllCorners, 1, FBrush);
      end;
    end;

  if Assigned(HeaderStyleImage) then
    for I := StartItem to EndItem do
      if (I <> HeaderIndex) then
      begin
        ItemObjects := Items[I];

        if (Assigned(ItemObjects)) and ((ItemObjects.Count > 0) or (Items[Index - 1].Purpose <> TListItemPurpose.None))
        then
        begin
          DrawRect := GetItemRelRect(I, LocRect, 1);
          if (ItemObjects.Purpose <> TListItemPurpose.None) then
          begin
            DrawSubRect := DrawRect;

            if (I = 0) then
              DrawSubRect.Top := DrawSubRect.Top + 1;

            HeaderStyleImage.DrawToCanvas(Canvas, DrawSubRect);
          end;
        end;
      end;
end;

procedure TCustomListView.DrawSelectedFill(const LocRect: TRectF);
var
  DrawRect: TRectF;
begin
  DrawRect := GetItemRelRect(FItemIndex, LocRect, 1);

  if (FItemIndex >= Items.Count - 1) or (Items[FItemIndex + 1].Purpose = TListItemPurpose.None) then
    DrawRect.Bottom := DrawRect.Bottom - 1;

{$IFNDEF IOS}
  // The selection seems to be broken on Windows (looks ugly, needs fixing). Meanwhile, attempt a temporal fix.
  DrawRect.Inflate(-2, -2);
{$ENDIF}
  if Assigned(SelectionStyleImage) then
    SelectionStyleImage.DrawToCanvas(Canvas, DrawRect)
  else
  begin
    FBrush.Color := SelectionStyleColor;
    Canvas.FillRect(DrawRect, 0.0, 0.0, AllCorners, 1.0, FBrush);
  end;
end;

procedure TCustomListView.BeginAppearanceUpdate;
begin
  Inc(FUpdatingAppearance);
  if FUpdatingAppearance = 1 then
  begin
    FChangedAppearanceObjects := [];
    FChangedAppearanceHeights := [];
  end;
end;

procedure TCustomListView.EndAppearanceUpdate(AForceInvalidate: TListItemPurposes);
begin
  if (FUpdatingAppearance > 0) then
  begin
    Dec(FUpdatingAppearance);
    if FUpdatingAppearance = 0 then
    begin
      AppearanceResetObjects(FChangedAppearanceObjects + AForceInvalidate);
      AppearanceResetHeights(FChangedAppearanceHeights - (FChangedAppearanceObjects + AForceInvalidate));
    end;
  end;
end;

function TCustomListView.GetHeaderRelRect(const StartItem, HeaderIndex: Integer; const LocRect: TRectF;
  const SideSpace: Integer): TRectF;
var
  LimitRect: TRectF;
begin
  Result := GetItemRelRect(HeaderIndex, LocRect, SideSpace);
  if (Result.Top < LocRect.Top) then
    Result.Offset(0, LocRect.Top - Result.Top);

  if (StartItem < Items.Count - 1) and (TOpenListBoxItem(Items[StartItem + 1]).FHeaderRef <> HeaderIndex) then
  begin
    LimitRect := GetItemRelRect(StartItem, LocRect, SideSpace);

    if (Result.Bottom > LimitRect.Bottom) then
      Result.Offset(0, LimitRect.Bottom - Result.Bottom);
  end;
end;

procedure TCustomListView.DrawHeaderItem(const LocRect: TRectF; StartItem, HeaderIndex: Integer);
var
  DrawRect: TRectF;
begin
  if (Assigned(HeaderStyleImage)) then
  begin
    DrawRect := GetHeaderRelRect(StartItem, HeaderIndex, LocRect, 1);

    FBrush.Color := ItemStyleFrameColor;
    Canvas.FillRect(RectF(DrawRect.Left - 1, DrawRect.Top, 1, DrawRect.Height), 0, 0, AllCorners, 1, FBrush);
    Canvas.FillRect(RectF(DrawRect.Right, DrawRect.Top, 1, DrawRect.Height), 0, 0, AllCorners, 1, FBrush);

    HeaderStyleImage.DrawToCanvas(Canvas, DrawRect);
  end;
end;

procedure TCustomListView.DrawListItems();
var
  I, StartItem, EndItem, MaxHeight, ItemHeaderIndex, SubPassNo: Integer;
  VertMarginHeight: Single;
  PassNo, NumberOfPasses, TopViewIndex, NumberOfSubPasses: Integer;
  MarginSize: TPointF;
  BorderRect, RelRect: TRectF;
  LocRect: TRectF;
  State: TCanvasSaveState;
  ItemObjects: TListViewItem;
  CurItem: TListItemObject;
  SceneScale: Single;
begin
  Items.CreateNewObjects;
  UpdateItemLookups;

  // Precache local rectangle.
  LocRect := LocalRect;

  // Set item clipping.
  State := Canvas.SaveState();
  Canvas.IntersectClipRect(LocRect);

  // Calculate item height sums.
  MaxHeight := Ceil(LocRect.Height + FScrollViewPos);

  // Determine starting and final elements that are currently visible.
  TopViewIndex := Trunc(FScrollViewPos - FSideSpace);

  StartItem := Min(Max(FindItemAbsoluteAt(TopViewIndex), 0), Items.Count - 1);
  EndItem := Items.Count - 1;

  for I := StartItem + 1 to Items.Count - 2 do
    if (HeightSums[I + 1] > MaxHeight) then
    begin
      EndItem := I;
      Break;
    end;

{$IFDEF IOS}
  ItemHeaderIndex := TOpenListBoxItem(Items[StartItem]).FHeaderRef;
{$ELSE}
  ItemHeaderIndex := -1;
{$ENDIF}
  VertMarginHeight := FItemSpaces.Top + FItemSpaces.Bottom;

  Canvas.Blending := False;
  DrawItemsFill(StartItem, EndItem, LocRect, ItemHeaderIndex);
  Canvas.Blending := True;

  if (InternalShowSelection) and (FItemIndex >= StartItem) and (FItemIndex <= EndItem) and (Items[FItemIndex].Count > 0) then
    DrawSelectedFill(LocRect);

  MarginSize.X := FItemSpaces.Left + FItemSpaces.Right;
  MarginSize.Y := FItemSpaces.Top + FItemSpaces.Bottom;

  BorderRect.Left := LocRect.Left + FSideSpace + FItemSpaces.Left;
  BorderRect.Top := LocRect.Top + FSideSpace + FItemSpaces.Top;
  BorderRect.Right := LocRect.Right - (FSideSpace + FItemSpaces.Right);
  BorderRect.Bottom := BorderRect.Top + ItemHeight - MarginSize.Y;

  SceneScale := Canvas.Scale;

{$IFDEF MSWINDOWS}
  if (FScrollBar.Visible) and (not Assigned(FAniCalc)) then
    BorderRect.Right := BorderRect.Right - FScrollBar.Width;
{$ENDIF}
  NumberOfPasses := GetNumberOfPassesForObjects(StartItem, EndItem);
  NumberOfSubPasses := Max(GetNumberOfSubPassesForObjects(StartItem, EndItem), 1);

  for PassNo := 0 to NumberOfPasses - 1 do
    for SubPassNo := 0 to NumberOfSubPasses - 1 do
      for I := StartItem to EndItem do
        if (I <> ItemHeaderIndex) then
        begin
          ItemObjects := Items[I];

          if Assigned(ItemObjects) and (ItemObjects.Count > PassNo) then
          begin
            CurItem := ItemObjects.Objects[PassNo];
            if (not Assigned(CurItem)) or (not CurItem.Visible) then
              Continue;

            // During the first sub-pass the designated areas are calculated.
            if (SubPassNo = 0) then
              TOpenListItemObject(CurItem).CalculateLocalRect
                (TRectF.Create(PointF(BorderRect.Left, BorderRect.Top + HeightSums[I] - FScrollViewPos),
                BorderRect.Width, GetItemHeight(I) - VertMarginHeight), SceneScale);

            CurItem.Render(Canvas, (I = FItemIndex) and InternalShowSelection, SubPassNo);
          end;
        end;

  if (ItemHeaderIndex <> -1) then
  begin
    DrawHeaderItem(LocRect, StartItem, ItemHeaderIndex);

    for PassNo := 0 to NumberOfPasses - 1 do
      for SubPassNo := 0 to NumberOfSubPasses - 1 do
      begin
        ItemObjects := Items[ItemHeaderIndex];

        if (Assigned(ItemObjects)) and (ItemObjects.Count > PassNo) then
        begin
          CurItem := ItemObjects.Objects[PassNo];
          if (not Assigned(CurItem)) or (not CurItem.Visible) then
            Continue;

          // During the first sub-pass the designated areas are calculated.
          if (SubPassNo = 0) then
          begin
            RelRect := GetHeaderRelRect(StartItem, ItemHeaderIndex, LocRect);
            RelRect.Left := BorderRect.Left;
            RelRect.Right := BorderRect.Right;

            TOpenListItemObject(CurItem).CalculateLocalRect(RelRect, SceneScale);
          end;

          CurItem.Render(Canvas, ItemHeaderIndex = FItemIndex, SubPassNo);
        end;
      end;
  end;

  // Restore previous clipping rectangle.
  Canvas.RestoreState(State);
end;

procedure TCustomListView.Paint();
var
  LocRect: TRectF;
begin
  Assert(not FPainting);
  if FPainting then
    Exit;
  FPainting := True;
  try
    FScrollScale:= Canvas.Scale;

    LocRect := LocalRect;

    if (not FTransparent) then
    begin
      Canvas.Blending := False;
      FBrush.Color := BackgroundStyleColor;
      Canvas.FillRect(LocalRect, 0.0, 0.0, AllCorners, 1.0, FBrush);
      Canvas.Blending := True;
    end;

    if (Items.Count > 0) then
      DrawListItems();
  finally
    FPainting := False;
  end;
end;

procedure TCustomListView.Resize;
begin
  inherited;

  ResizeAppearances;  // such as width of text objects
  UpdateScrollingLimits;
end;

function TCustomListView.ObjectAtPoint(P: TPointF): IControl;
var
  LocalPt: TPointF;
  ItemAt: Integer;
  Control: TControl;
begin
  if (not MouseClicked) then
  begin
    LocalPt := P;
    if Assigned(FScene) then
      LocalPt := FScene.ScreenToLocal(LocalPt);

    ItemAt := FindItemAbsoluteAt(Round(FScrollViewPos + LocalPt.Y - (LocalRect.Top + FSideSpace)));
    if (ItemAt >= 0) and (ItemAt < Items.Count) and (Items[ItemAt].Count > 0) then
    begin
      Control := TOpenListBoxItem(Items[ItemAt]).ObjectAtPoint(P);
      if Assigned(Control) then
        Exit(Control);
    end;
  end;

  Result := inherited ObjectAtPoint(P);
end;

procedure TCustomListView.ObserversBeforeSelection(out LAllowSelection: Boolean);
begin
  LAllowSelection := True;
  if Observers.IsObserving(TObserverMapping.EditLinkID) then
    if not TLinkObservers.EditLinkEdit(Observers) then
      LAllowSelection := False;
  if LAllowSelection then
    TLinkObservers.PositionLinkPosChanging(Observers);
end;

procedure TCustomListView.KeyDown(var Key: Word; var KeyChar: System.WideChar; Shift: TShiftState);
var
  LFirstVisible, LLastVisible: Integer;

  procedure CalcVisible;
  var
    I: Integer;
    MaxHeight: Integer;
    TopViewIndex: Integer;
    LocRect: TRectF;
  begin
    // Precache local rectangle.
    LocRect := LocalRect;

    // Calculate item height sums.
    MaxHeight := Ceil(LocRect.Height + FScrollViewPos);

    // Determine starting and final elements that are currently visible.
    TopViewIndex := Trunc(FScrollViewPos - FSideSpace);

    LFirstVisible := Min(Max(FindItemAbsoluteAt(TopViewIndex), 0), Items.Count - 1);
    LLastVisible := Items.Count - 1;

    for I := LFirstVisible + 1 to Items.Count - 2 do
      if (HeightSums[I + 1] >= MaxHeight) then
      begin
        LLastVisible := I;
        Break;
      end;
  end;

var
  i: Integer;
  LItemIndex: Integer;
  LChanged: Boolean;
  LColumns: Integer;
begin
  LItemIndex := ItemIndex;
  LColumns := 1; // ListView only has one column
  if InternalAllowSelection then
  if Observers.IsObserving(TObserverMapping.EditLinkID) then
    if (KeyChar > ' ') or
      (Key in [vkHome, vkEnd, vkUp, vkDown, vkRight, vkLeft]) then
      if TLinkObservers.EditLinkIsReadOnly(Observers) then
        Exit
      else
        if not TLinkObservers.EditLinkEdit(Observers) then
          Exit;
  inherited;
  if ItemCount > 0 then
  begin
    if KeyChar <> #0 then
    begin
      for i := 0 to ItemCount - 1 do
        if (GetItem(I).Text <> '') and (string(GetItem(I).Text.Chars[0]).ToLower = string(KeyChar).ToLower) then
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
        LItemIndex := ItemCount - LColumns;
      vkUp:
        If ItemIndex > 0 then
        begin
          LItemIndex := LItemIndex - LColumns;
          if LItemIndex < 0 then
            LItemIndex := 0;
        end;
      vkDown:
        begin
          If LItemIndex < ItemCount - 1 then
            LItemIndex := LItemIndex + LColumns;
          if LItemIndex > ItemCount - 1 then
            ItemIndex := ItemCount - 1;
        end;
      vkLeft:
        If LItemIndex > 0 then
          LItemIndex := ItemIndex - 1;
      vkRight:
        If LItemIndex < ItemCount - 1 then
          LItemIndex := LItemIndex + 1;
      vkPrior:
      begin
        CalcVisible;
        LItemIndex := Max(0, LFirstVisible - Max(1, LLastVisible - LFirstVisible + 1));
      end;
      vkNext:
      begin
        CalcVisible;
        LItemIndex := Min(Items.Count-1, LLastVisible + Max(1, LLastVisible - LFirstVisible + 1));
      end;
    else
      Exit;
    end;
    LChanged := LItemIndex <> ItemIndex;
    if LChanged then
      TLinkObservers.PositionLinkPosChanging(Observers);  // Validation exception during this call
    ItemIndex := LItemIndex;
    if LChanged then
      TLinkObservers.ListSelectionChanged(Observers);
    Key := 0;
  end;
end;

procedure TCustomListView.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Single);

  procedure SetItemIndex(AValue: Integer);
  var
    LAllowSelection: Boolean;
  begin
    LAllowSelection := True;
    MouseSetItemIndex := AValue;
    if AValue <> ItemIndex then
      ObserversBeforeSelection(LAllowSelection);
    if LAllowSelection then
    begin
      Self.SetItemIndex(AValue);
      DoItemClick(Items[ItemIndex]);
    end;
  end;

  procedure CancelMode;
  var
    LButton: TListItemSimpleControl;
    ItemAt: Integer;
    LCancel: Boolean;
  begin
    if (not ScrollingActive) and (FEditModeState <> nil) and FEditModeState.CanCancelMode then
    begin
      LCancel := True;
      ItemAt := FindItemAbsoluteAt(Round(FScrollViewPos + Y - (LocalRect.Top + FSideSpace)));
      if (ItemAt >= 0) and (ItemAt < Items.Count) then
      begin
        LButton := Items[ItemAt].Objects.GlyphButton;
        if (LButton <> nil) and LButton.PointInLocalRect(TPointF.Create(X, Y)) then
          LCancel := False;
        if LCancel then
              begin
          LButton := Items[ItemAt].Objects.TextButton;
          if (LButton <> nil) and LButton.PointInLocalRect(TPointF.Create(X, Y)) then
                LCancel := False;
        end;
      end;
      if LCancel then
        FEditModeState.CancelMode;
    end;
  end;

var
  ItemAt: Integer;
  LItemIndex: Integer;
  Distance: Single;
begin
  inherited;

  CancelMode;

  LItemIndex := ItemIndex;
  if (Button = TMouseButton.mbLeft) then
  begin
    MouseClicked := True;
    MouseClickIndex := -1;
    MouseEventIndex := -1;
    MouseSetItemIndex := -1;

{$IFDEF IOS}
    StopPropertyAnimation('ScrollViewPos');

    Distance := Y - LocalRect.Top;

    if (not ScrollingActive) and FAutoTapScroll and (Distance < FAutoTapTreshold) then
      FAutoTapDistance := Trunc(Distance)
    else
      FAutoTapDistance := 0;
{$ENDIF}
    if (not ScrollingActive) then
    begin
      ItemAt := FindItemAbsoluteAt(Round(FScrollViewPos + Y - (LocalRect.Top + FSideSpace)));
      if (ItemAt >= 0) and (ItemAt < Items.Count) and (Items[ItemAt].Count > 0) then
      begin
        if (TOpenListBoxItem(Items[ItemAt]).MouseDown(Button, Shift, PointF(X, Y))) then
        begin
          MouseEventIndex := ItemAt;

          if (InternalAllowSelection) then
            SetItemIndex(MouseEventIndex);
        end
        else
        begin
{$IFDEF IOS}
          if Assigned(TOpenListBoxItem(Items[ItemAt]).ObjectAtPoint(PointF(X, Y))) then
            MouseClickIndex := ItemAt;

          if (MouseClickIndex <> -1) and (InternalAllowSelection) then
            SetItemIndex(MouseClickIndex);

          if (MouseClickIndex = -1) then
          begin
            if (not Assigned(ItemSelectTimer)) then
            begin
              ItemSelectTimer := TTimer.Create(nil);
              ItemSelectTimer.Enabled := False;
              ItemSelectTimer.Parent := Self;
              ItemSelectTimer.Interval := 250;
              ItemSelectTimer.OnTimer := SelectItemNotify;
            end;

            ItemSelectTimer.Enabled := True;
            ItemSelectTimerIndex := ItemAt;
            ItemSelectTimerWorked := False;
          end;

{$ELSE}
          if (TOpenListBoxItem(Items[ItemAt]).HasClickOnSelectItems) then
            FItemIndex := -1;

          SetItemIndex(ItemAt);
          MouseClickIndex := -1;
{$ENDIF}
        end;
      end;
    end
    else
      ScrollingMouseTouch := True;

    if (MouseClickIndex = -1) and (MouseEventIndex = -1) then
    begin
      if Assigned(FAniCalc) then
      begin
        FAniCalc.Averaging := ssTouch in Shift;
        FAniCalc.MouseDown(X, Y);
      end;

      MouseClickPrev := PointF(X, Y);
      MouseClickDelta := PointF(0.0, 0.0);
    end;
  end;

  if LItemIndex <> ItemIndex then
    TLinkObservers.ListSelectionChanged(Observers);
end;

procedure TCustomListView.MouseMove(Shift: TShiftState; X, Y: Single);
begin
  inherited;

  if (Assigned(FAniCalc)) and (FAniCalc.Down) then
    FAniCalc.MouseMove(X, Y);

  if (MouseClicked) and (MouseClickIndex = -1) then
  begin
    MouseClickDelta.X := MouseClickDelta.X + (X - MouseClickPrev.X);
    MouseClickDelta.Y := MouseClickDelta.Y + (Y - MouseClickPrev.Y);

    MouseClickPrev := PointF(X, Y);
  end;

  if (MouseEventIndex <> -1) then
    TOpenListBoxItem(Items[MouseEventIndex]).MouseMove(Shift, PointF(X, Y));
end;

procedure TCustomListView.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Single);

  procedure SetItemIndex(AValue: Integer);
  var
    LAllowSelection: Boolean;
  begin
    if MouseSetItemIndex <> AValue then
    begin
      LAllowSelection := True;
      if AValue <> ItemIndex then
        ObserversBeforeSelection(LAllowSelection);
      if LAllowSelection then
      begin
        Self.SetItemIndex(AValue);
        DoItemClick(Items[AValue]);
      end;
    end;
  end;
var
  Mag: Single;
  NewIndex: Integer;
  LItemIndex: Integer;
begin
  inherited;
  LItemIndex := ItemIndex;

  if (Assigned(FAniCalc)) and (FAniCalc.Down) then
    FAniCalc.MouseUp(X, Y);

  if (MouseClicked) then
  begin
    if Assigned(ItemSelectTimer) and ItemSelectTimer.Enabled then
      ItemSelectTimer.Enabled := False;

    if (not ScrollingMouseTouch) then
    begin
      if (MouseEventIndex <> -1) then
      begin
        TOpenListBoxItem(Items[MouseEventIndex]).MouseUp(Button, Shift, PointF(X, Y));
        MouseEventIndex := -1;
      end
      else
      begin
        if (FAutoTapDistance > 0) and (not ItemSelectTimerWorked) then
          AnimateFloat('ScrollViewPos', 0.0, Min(FAutoTapDistance / AutoTapScrollingSpeed, 1.0), TAnimationType.atOut,
            TInterpolationType.itSinusoidal)
        else if (MouseClickIndex = -1) and (not ItemSelectTimerWorked) then
        begin
          Mag := Sqrt(Sqr(MouseClickDelta.X) + Sqr(MouseClickDelta.Y));

          if (Mag < MouseClickTreshold) and (InternalAllowSelection) then
          begin
            NewIndex := FindItemAbsoluteAt(Round(FScrollViewPos + Y - (LocalRect.Top + FSideSpace)));

            if (NewIndex >= 0) and (NewIndex < Items.Count) and (Items[NewIndex].Count > 0) and
              (Items[NewIndex].Purpose = TListItemPurpose.None) then
            begin
{$IFDEF IOS}
              if (TOpenListBoxItem(Items[NewIndex]).HasClickOnSelectItems) then
                FItemIndex := -1;
{$ENDIF}
              SetItemIndex(NewIndex);
            end;
          end;
        end
        else
          MouseClickIndex := -1;
      end;
    end
    else
      ScrollingMouseTouch := False;

    MouseClicked := False;
    ItemSelectTimerWorked := False;
  end;  
  if LItemIndex <> ItemIndex then
    TLinkObservers.ListSelectionChanged(Observers);
end;

procedure TCustomListView.MouseWheel(Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean);
var
  Offset: Single;
begin
  inherited;
  if (not Handled) and (not DisableMouseWheel) then
  begin
    if ssHorizontal in Shift then
    begin
      // Ignore horizontal
    end
    else
    begin
      if Assigned(FScrollBar) then
        Offset := FScrollBar.SmallChange
      else
        Offset := Height / 5;
      Offset := Offset * -1 * (WheelDelta / 120);
      SetScrollViewPos(ScrollViewPos + Offset);
      Handled := True;
    end
  end;
end;

procedure TCustomListView.DoMouseLeave();
begin
  inherited;

  if Assigned(FAniCalc) then
  FAniCalc.MouseLeave();
end;

procedure TCustomListView.Invalidate;
begin
  InvalidateRect(LocalRect);
end;

procedure TCustomListView.InvalidateHeights;
begin
  HeightSumsDirty := True;
end;

function TCustomListView.IsIControl: Boolean;
begin
  Result := True;
end;

procedure TCustomListView.DoChange;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

procedure TCustomListView.UpdateItemLookups();
var
  I, TotalHeight, PrevItemHeight, CurHeaderRef: Integer;
begin
  if (HeightSumsDirty) then
  begin
    TotalHeight := 0;

    HeightSums.Clear;
    HeightSums.Add(0);

    CurHeaderRef := -1;

    for I := 0 to Items.Count - 1 do
    begin
      if (I > 0) then
      begin
        PrevItemHeight := GetItemHeight(I-1);
        Inc(TotalHeight, PrevItemHeight);

        HeightSums.Add(TotalHeight);
      end;

      if (Items[I].Purpose = TListItemPurpose.Header) then
      begin
        CurHeaderRef := I;
        TOpenListBoxItem(Items[I]).FHeaderRef := I;
      end;

      if (Items[I].Purpose = TListItemPurpose.None) then
      begin
        if (Items[I].Count > 0) then
          TOpenListBoxItem(Items[I]).FHeaderRef := CurHeaderRef
        else
          CurHeaderRef := -1;
      end;
    end;

    Inc(TotalHeight, GetItemHeight(Items.Count - 1));
    if (TotalHeight <> MaxKnownHeight) then
    begin
      MaxKnownHeight := TotalHeight;
      UpdateScrollingLimits();
    end;

    HeightSumsDirty := False;
  end;
end;

function TCustomListView.FindItemAbsoluteAt(ViewAt: Integer): Integer;
var
  Left, Right, Pivot, Value: Integer;
begin
  UpdateItemLookups;

  if (Items.Count < 1) then
    Exit(-1);
  if (ViewAt < 1) then
    Exit(0);
  if (ViewAt >= HeightSums[HeightSums.Count - 1]) then
    Exit(HeightSums.Count - 1);

  Left := 0;
  Right := HeightSums.Count - 1;
  Pivot := 0;

  while (Left <= Right) do
  begin
    Pivot := (Left + Right) div 2;

    Value := HeightSums[Pivot];
    if (Value = ViewAt) then
      Exit(Pivot);

    if (Value > ViewAt) then
      Right := Pivot - 1
    else
      Left := Pivot + 1;
  end;

  Result := Pivot;

  if (Result > 0) and (Result < HeightSums.Count) and (HeightSums[Result] >= ViewAt) then
    Dec(Result);
end;

function TCustomListView.GetDefaultStyleLookupName: string;
begin
  Result := 'listviewstyle';
end;

procedure TCustomListView.ApplyStyle;

  function GetColorFromStyle(const ObjectName: string; const DefaultColor: TAlphaColor): TAlphaColor;
  var
    StyleObject: TFmxObject;
  begin
    StyleObject := FindStyleResource(ObjectName);
    if StyleObject is TColorObject then
      Result := TColorObject(StyleObject).Color
    else if StyleObject is TText then
      Result := TText(StyleObject).Color
    else
      Result := DefaultColor;
  end;

  procedure AssignFontFromStyle(const Font: TFont; const ObjectName: string);
  var
    StyleObject: TFmxObject;
  begin
    StyleObject := FindStyleResource(ObjectName);
    if StyleObject is TFontObject then
      Font.Assign(TFontObject(StyleObject).Font)
    else if StyleObject is TText then
      Font.Assign(TText(StyleObject).Font);
  end;

  function GetSubImageFromStyle(const ObjectName: string): TSubImage;
  var
    StyleObject: TFmxObject;
  begin
    StyleObject := FindStyleResource(ObjectName);
    if StyleObject is TSubImage then
      Result := TSubImage(StyleObject)
    else
      Result := nil;
  end;

begin
  inherited;


  // Control Colors
  BackgroundStyleColor := GetColorFromStyle('background', claWhite);

  ItemStyleFillColor := GetColorFromStyle('itembackground', claWhite);
  ItemStyleFillAltColor := GetColorFromStyle('alternatingitembackground', claWhite);
  ItemStyleFrameColor := GetColorFromStyle('frame', claBlack);

  // Item Colors
  FStyleResources.DefaultTextColor := GetColorFromStyle('foreground', claBlack);
  FStyleResources.DefaultTextSelectedColor := GetColorFromStyle('selectiontext', claBlack);
  FStyleResources.DetailTextColor := GetColorFromStyle('detailtext', claBlack);
  FStyleResources.HeaderTextColor := GetColorFromStyle('headertext', claWhite);
  FStyleResources.HeaderTextShadowColor := GetColorFromStyle('headertextshadow', claWhite);

  FStyleResources.ButtonTextColor := GetColorFromStyle('buttontext', claWhite);
  FStyleResources.ButtonTextPressedColor := GetColorFromStyle('buttontextpressed', claBlack);
  FStyleResources.DeleteButtonTextColor := GetColorFromStyle('deletebuttontext', claWhite);
  FStyleResources.DeleteButtonTextPressedColor := GetColorFromStyle('deletebuttontextpressed', claWhite);

  // Fonts
  AssignFontFromStyle(FStyleResources.DefaultTextFont, 'font');
  AssignFontFromStyle(FStyleResources.DetailTextFont, 'detailfont');
  AssignFontFromStyle(FStyleResources.HeaderTextFont, 'headerfont');
  AssignFontFromStyle(FStyleResources.ButtonTextFont, 'buttonfont');
  AssignFontFromStyle(FStyleResources.DeleteButtonTextFont, 'deletebuttonfont');

  // Style Images
  SelectionStyleImage := GetSubImageFromStyle('selection');
  HeaderStyleImage := GetSubImageFromStyle('header');

  if (not Assigned(SelectionStyleImage)) then
    SelectionStyleColor := GetColorFromStyle('selection', claBlue);

  FStyleResources.ButtonAddItemStyleImage.Normal := GetSubImageFromStyle('additembutton');
  FStyleResources.ButtonAddItemStyleImage.Pressed := GetSubImageFromStyle('additembuttonpressed');
  FStyleResources.ButtonDeleteItemStyleImage.Normal := GetSubImageFromStyle('deleteitembutton');
  FStyleResources.ButtonDeleteItemStyleImage.Pressed := GetSubImageFromStyle('deleteitembuttonglyph');
  FStyleResources.ButtonNormalStyleImage.Normal := GetSubImageFromStyle('button');
  FStyleResources.ButtonNormalStyleImage.Pressed := GetSubImageFromStyle('buttonpressed');
  FStyleResources.ButtonDeleteStyleImage.Normal := GetSubImageFromStyle('deletebutton');
  FStyleResources.ButtonDeleteStyleImage.Pressed := GetSubImageFromStyle('deletebuttonpressed');
  FStyleResources.ButtonCheckboxStyleImage.Normal := GetSubImageFromStyle('checkboxunchecked');
  FStyleResources.ButtonCheckboxStyleImage.Pressed := GetSubImageFromStyle('checkboxchecked');

  // Acessory Images
  FStyleResources.AccessoryImages[TAccessoryType.More].Normal := GetSubImageFromStyle('accessorymore');
  FStyleResources.AccessoryImages[TAccessoryType.More].Selected := GetSubImageFromStyle('accessorymoreselected');
  FStyleResources.AccessoryImages[TAccessoryType.Checkmark].Normal := GetSubImageFromStyle('accessorycheckmark');
  FStyleResources.AccessoryImages[TAccessoryType.Checkmark].Selected := GetSubImageFromStyle('accessorycheckmarkselected');
  FStyleResources.AccessoryImages[TAccessoryType.Detail].Normal := GetSubImageFromStyle('accessorydetail');
  FStyleResources.AccessoryImages[TAccessoryType.Detail].Selected := GetSubImageFromStyle('accessorydetailselected');

  // Update resources if designing.
  if csDesigning in ComponentState then
    UpdateAppearanceStyleResources;
end;

function TCustomListView.AsIControl: IControl;
begin
  Result := Self;
end;

procedure TCustomListView.FreeStyle;
begin

  inherited;
end;

function TCustomListView.GetItemRect(const AItemIndex: Integer): TRectF;
begin
  if (AItemIndex < 0) or (AItemIndex >= Items.Count) then
    Exit;
  UpdateItemLookups();
  Result := GetItemRelRect(AItemIndex, LocalRect);
end;

procedure TCustomListView.ScrollTo(const AItemIndex: Integer);
var
  LocRect, ItemRect: TRectF;
  NewPos: Integer;
begin
  if (AItemIndex < 0) or (AItemIndex >= Items.Count) then
    Exit;

  UpdateItemLookups();

  LocRect := LocalRect;

  ItemRect := GetItemRelRect(AItemIndex, LocRect);

  if (ItemRect.Top < LocRect.Top) then
  begin
   NewPos := FSideSpace + HeightSums[AItemIndex];

{$IFDEF IOS}
    // Take into account sticky header, so it does not clutter the view.
    if (TOpenListBoxItem(Items[AItemIndex]).FHeaderRef <> -1) and
      (TOpenListBoxItem(Items[AItemIndex]).FHeaderRef <> AItemIndex) then
      Dec(NewPos, GetItemHeight(TOpenListBoxItem(Items[AItemIndex]).FHeaderRef));
{$ENDIF}
    SetScrollViewPos(NewPos);
  end
  else if (ItemRect.Bottom > LocRect.Bottom) then
  begin
    SetScrollViewPos(FSideSpace + HeightSums[AItemIndex] - (LocRect.Height - GetItemHeight(AItemIndex)));
  end;
end;


class procedure TCustomListView.RegisterAppearances(AFactories: TArray<TItemAppearanceObjectsClass>; ADisplayNames: TArray<string>; AOptions: TRegisterAppearanceOptions;
  const AUnitName: string);
var
  I: Integer;
begin
  for I := 0 to Length(AFactories) - 1 do
  begin
    if I < Length(ADisplayNames) then
      RegisterAppearance(AFactories[I], ADisplayNames[I], AOptions, AUnitName);
  end;
end;

class procedure TCustomListView.RegisterAppearance(const AFactory: TItemAppearanceObjectsClass; const ADisplayName: string; AOptions: TRegisterAppearanceOptions;
  const AUnitName: string);
var
  LPair: TPair<TItemAppearanceObjectsClass, TRegisterAppearanceValue>;
  LFilter: TRegisterAppearanceOptions;
begin
  LFilter := AOptions * cRegisterDefault;
  if LFilter <> [] then
  begin
    // Clear defaults, so there is only one default for item, header and footer
    for LPair in FFactories do
      if LPair.Value.Options * LFilter <> [] then
        FFactories[LPair.Key] := TRegisterAppearanceValue.Create(LPair.Value.Name, LPair.Value.Options - LFilter,
          LPair.Value.UnitName);
  end;
  FFactories.AddOrSetValue(AFactory,
    TRegisterAppearanceValue.Create(ADisplayName, AOptions, AUnitName));
end;

class procedure TCustomListView.UnregisterAppearances(AFactories: TArray<TItemAppearanceObjectsClass>);
var
  LFactory: TItemAppearanceObjectsClass;
begin
  for LFactory in AFactories do
    FFactories.Remove(LFactory);
end;

class procedure TCustomListView.UnregisterAppearance(const AFactory: TItemAppearanceObjectsClass);
begin
  FFactories.Remove(AFactory);
end;

class function TCustomListView.GetRegisteredAppearances(AFilter: TRegisterAppearanceOptions): TArray<TRegisteredAppearance>;
var
  LList: TList<TRegisteredAppearance>;
  LPair: TPair<TItemAppearanceObjectsClass, TRegisterAppearanceValue>;
  LValue: TRegisteredAppearance;
begin
  LList := TList<TRegisteredAppearance>.Create;
  try
    for LPair in FFactories do
      if (AFilter = []) or (LPair.Value.Options * AFilter <> []) then
      begin
        LValue.Value := LPair.Key;
        LValue.Name := LPair.Value.Name;
        LValue.UnitName := LPair.Value.UnitName;
        LValue.Options := LPair.Value.Options;
        LList.Add(LValue);
      end;
    Result := LList.ToArray;
  finally
    LList.Free;
  end;

end;

{ TCustomListView.TEditModeState }

function TCustomListView.TEditModeState.GetClearWhenStart: Boolean;
begin
  Result := (TEditModeOption.ClearWhenStart in FOptions);
end;

constructor TCustomListView.TEditModeState.Create(const AOwner: TCustomListView);
begin
  FOwner := AOwner;
  FOptions := FOwner.EditModeOptions;
end;

function TCustomListView.TEditModeState.GetUncheckMode: Boolean;
begin
  Result := (TEditModeOption.UncheckMode in FOptions);
end;

procedure TCustomListView.TEditModeState.BeginClearing;
begin
  Inc(FClearing);
end;

function TCustomListView.TEditModeState.GetCanCancelMode: Boolean;
begin
  Result := (ModalMode) and (FirstChecked <> -1)
end;

procedure TCustomListView.TEditModeState.CancelMode;
var
  I: Integer;
begin
  I := FOwner.Items.FirstChecked(Self.CheckedValue);
  if I <> -1 then
    FOwner.Items[I].Checked := not Self.CheckedValue;
end;

function TCustomListView.TEditModeState.GetCheckedValue: Boolean;
begin
  Result := not UncheckMode;
end;

function TCustomListView.TEditModeState.GetDisallowSelection: Boolean;
begin
  Result := (TEditModeOption.DisallowSelection in FOptions);
end;

procedure TCustomListView.TEditModeState.EndClearing;
begin
  Dec(FClearing);
end;

function TCustomListView.TEditModeState.GetFirstChecked: Integer;
begin
  Result := FOwner.Items.FirstChecked(CheckedValue);
end;

function TCustomListView.TEditModeState.GetClearing: Boolean;
begin
  Result := FClearing > 0;
end;

function TCustomListView.TEditModeState.GetModalMode: Boolean;
begin
  Result := TEditModeOption.ModalMode in FOptions;
end;

function TCustomListView.TEditModeState.GetHideSelection: Boolean;
begin
  Result := (TEditModeOption.HideSelection in FOptions);
end;

function TCustomListView.TEditModeState.GetRadioButtonMode: Boolean;
begin
  Result := TEditModeOption.RadioButtonMode in FOptions;
end;

{ TCustomListView.TPublishedAppearance }

constructor TCustomListView.TPublishedAppearance.Create(const AOwner: TCustomListView);
begin
  inherited Create;
  FOwner := AOwner;
end;

function TCustomListView.TPublishedAppearance.GetFooterAppearance: string;
begin
  Result := FOwner.FooterAppearanceName;
end;

function TCustomListView.TPublishedAppearance.GetFooterHeight: Integer;
begin
  Result := FOwner.FooterHeight;
end;

function TCustomListView.TPublishedAppearance.GetHeaderAppearance: string;
begin
  Result := FOwner.HeaderAppearanceName;
end;

function TCustomListView.TPublishedAppearance.GetHeaderHeight: Integer;
begin
  Result := FOwner.HeaderHeight;
end;

function TCustomListView.TPublishedAppearance.GetItemAppearance: string;
begin
  Result := FOwner.ItemAppearanceName;
end;

function TCustomListView.TPublishedAppearance.GetItemEditAppearance: string;
begin
  Result := FOwner.ItemEditAppearanceName;
end;

function TCustomListView.TPublishedAppearance.GetItemEditHeight: Integer;
begin
  Result := FOwner.ItemEditHeight;
end;

function TCustomListView.TPublishedAppearance.GetItemHeight: Integer;
begin
  Result := FOwner.ItemHeight;
end;

function TCustomListView.TPublishedAppearance.IsFooterHeightStored: Boolean;
begin
  Result := FOwner.FFooterAppearanceProperties.IsHeightStored;
end;

function TCustomListView.TPublishedAppearance.IsHeaderHeightStored: Boolean;
begin
  Result := FOwner.FHeaderAppearanceProperties.IsHeightStored;
end;

function TCustomListView.TPublishedAppearance.IsItemEditHeightStored: Boolean;
begin
  Result := FOwner.FItemEditAppearanceProperties.IsHeightStored;
end;

function TCustomListView.TPublishedAppearance.IsItemHeightStored: Boolean;
begin
  Result := FOwner.FItemAppearanceProperties.IsHeightStored;
end;

procedure TCustomListView.TPublishedAppearance.SetFooterAppearance(const Value: string);
begin
  FOwner.FooterAppearanceName := Value;
end;

procedure TCustomListView.TPublishedAppearance.SetFooterHeight(const Value: Integer);
begin
  FOwner.FooterHeight := Value;
end;

procedure TCustomListView.TPublishedAppearance.SetHeaderAppearance(const Value: string);
begin
  FOwner.HeaderAppearanceName := Value;
end;

procedure TCustomListView.TPublishedAppearance.SetHeaderHeight(const Value: Integer);
begin
  FOwner.HeaderHeight := Value;
end;

procedure TCustomListView.TPublishedAppearance.SetItemAppearance(const Value: string);
begin
  FOwner.ItemAppearanceName := Value;
end;

procedure TCustomListView.TPublishedAppearance.SetItemEditAppearance(const Value: string);
begin
  FOwner.ItemEditAppearanceName := Value;
end;

procedure TCustomListView.TPublishedAppearance.SetItemEditHeight(const Value: Integer);
begin
  FOwner.ItemEditHeight := Value;
end;

procedure TCustomListView.TPublishedAppearance.SetItemHeight(const Value: Integer);
begin
  FOwner.ItemHeight := Value;
end;

{ TCustomListView.TPublishedObjects }

constructor TCustomListView.TPublishedObjects.Create(
  const AOwner: TCustomListView);
begin
  inherited Create;
  FOwner := AOwner;
end;

function TCustomListView.TPublishedObjects.GetFooterObjects: TItemAppearanceObjects;
begin
  Result := FOwner.FFooterAppearanceProperties.Objects;
end;

function TCustomListView.TPublishedObjects.GetHeaderObjects: TItemAppearanceObjects;
begin
  Result := FOwner.FHeaderAppearanceProperties.Objects;
end;

function TCustomListView.TPublishedObjects.GetItemEditObjects: TItemAppearanceObjects;
begin
  Result := FOwner.FItemEditAppearanceProperties.Objects;
end;

function TCustomListView.TPublishedObjects.GetItemObjects: TItemAppearanceObjects;
begin
  Result := FOwner.FItemAppearanceProperties.Objects;
end;

procedure TCustomListView.TPublishedObjects.SetFooterObjects(
  const Value: TItemAppearanceObjects);
begin
  FOwner.FFooterAppearanceProperties.Objects := Value;
end;

procedure TCustomListView.TPublishedObjects.SetHeaderObjects(
  const Value: TItemAppearanceObjects);
begin
  FOwner.FHeaderAppearanceProperties.Objects := Value;
end;

procedure TCustomListView.TPublishedObjects.SetItemEditObjects(
  const Value: TItemAppearanceObjects);
begin
  FOwner.FItemEditAppearanceProperties.Objects := Value;
end;

procedure TCustomListView.TPublishedObjects.SetItemObjects(
  const Value: TItemAppearanceObjects);
begin
  FOwner.FItemAppearanceProperties.Objects := Value;
end;

{ TListView }

procedure TListView.InitializeItemAppearance(
  const AAppearance: TItemAppearanceProperties);

  function FindAppearanceOption(AOption: TRegisterAppearanceOption): TCustomListView.TItemAppearanceObjectsClass;
  var
    LPair: TPair<TItemAppearanceObjectsClass, TRegisterAppearanceValue>;
  begin
    Result := nil;
    for LPair in FFactories do
      if AOption in LPair.Value.Options then
        Result := LPair.Key;
  end;

begin
  case AAppearance.AppearanceType of
    TAppearanceType.Item:
      AAppearance.AppearanceClass := FindAppearanceOption(TRegisterAppearanceOption.DefaultItem);
    TAppearanceType.ItemEdit:
      AAppearance.AppearanceClass := FindAppearanceOption(TRegisterAppearanceOption.DefaultItemEdit);
    TAppearanceType.Header:
      AAppearance.AppearanceClass := FindAppearanceOption(TRegisterAppearanceOption.DefaultHeader);
    TAppearanceType.Footer:
      AAppearance.AppearanceClass := FindAppearanceOption(TRegisterAppearanceOption.DefaultFooter);
  else
    Assert(False);
  end;
end;


{ TListViewItem }

constructor TListViewItem.Create;
begin
  inherited;
  FIndex := -1;
end;

destructor TListViewItem.Destroy;
begin
  FBitmap.Free;
  FData.Free;
  FDataBitmaps.Free;

  inherited;
end;

procedure TListViewItem.CheckBitmap;
begin
  if FBitmap = nil then
  begin
    FBitmap := TBitmap.Create(0,0);
    FBitmap.OnChange := OnBitmapChanged;
  end;
end;

procedure TListViewItem.OnBitmapChanged(Sender: TObject);
begin
  Invalidate;
end;

procedure TListViewItem.Repaint;
begin
  Parent.Invalidate;
end;

function TListViewItem.GetIndex: Integer;
var
  I: Integer;
begin
  Result := FIndex;
  if Result = -1 then
  begin
    for I := 0 to Parent.Items.Count - 1 do
    begin
      Parent.Items[I].FIndex := I; // Maybe -1
      if Parent.Items[I] = Self then
        Result := i;
    end;
  end
end;

function TListViewItem.GetObjects: TListViewItem.TListViewItemObjects;
begin
  CreateObjects;
  Result := TListViewItem.TListViewItemObjects(inherited Objects);
end;

function TListViewItem.GetParent: TCustomListView;
begin
  Assert(inherited Parent is TCustomListView);
  Result := inherited Parent as TCustomListView;
end;

procedure TListViewItem.InvalidateHeights;
begin
  Parent.InvalidateHeights;
end;

function TListViewItem.GetHasData(const AIndex: string): Boolean;
begin
  Result := (FData <> nil)
    and FData.ContainsKey(AIndex);
end;

function TListViewItem.ListItemObjectsClass: TListItem.TListItemObjectsType;
begin
  Result := TListViewItem.TListViewItemObjects;
end;

function TListViewItem.GetBitmap: TBitmap;
begin
  CheckBitmap;  // Need a bitmap for assignment
  Result := FBitmap;
end;

function TListViewItem.GetChecked: Boolean;
var
  LObject: TListItemGlyphButton;
begin
  Result := FChecked;
  LObject := Objects.GetGlyphButton;
  if LObject <> nil then
    Result := LObject.Checked;
end;

function TListViewItem.GetData(const AIndex: string): TValue;
begin
  if Assigned(FData) then
    if not FData.TryGetValue(AIndex, Result) then
      Result := TValue.Empty;
end;

function TListViewItem.GetHasObjects: Boolean;
begin
  Result := TFlag.HasObjects in FFlags;
end;

function TListViewItem.GetHasButtonText: Boolean;
begin
  Result := TFlag.HasButtonText in FFlags;
end;

function TListViewItem.GetHasCheck: Boolean;
begin
  Result := TFlag.HasCheck in FFlags;
end;

procedure TListViewItem.SetHasObjects;
begin
  System.Include(FFlags, TFlag.HasObjects);
end;

procedure TListViewItem.SetPurpose(const AValue: TListItemPurpose);
begin
  if AValue <> Purpose then
  begin
    inherited;
    if HasObjects then
      Parent.ResetObjects(Self);  // Change appearance
  end
  else
    inherited;
end;

procedure TListViewItem.SetText(const Value: string);
var
  LObject: TListItemText;
begin
  FText := Value;
  LObject := Objects.TextObject;
  if LObject <> nil then
    LObject.Text := Value;
end;

procedure TListViewItem.SetButtonText(const Value: string);
var
  LObject: TListItemTextButton;
begin
  System.Include(FFlags, TFlag.HasButtonText);
  FButtonText := Value;
  LObject := Objects.TextButton;
  if LObject <> nil then
    LObject.Text := Value;
end;

procedure TListViewItem.SetChecked(const Value: Boolean);
var
  LObject: TListItemGlyphButton;
begin
  System.Include(FFlags, TFlag.HasCheck);
  FChecked := Value;
  LObject := Objects.GlyphButton;
  if LObject <> nil then
    LObject.Checked := Value;
end;

procedure TListViewItem.SetData(const AIndex: string; const AValue: TValue);
var
  LObject: TListItemObject;
  LHandled: Boolean;
  LDataObject: TObject;
  LBitmap: TBitmap;
begin
  if FData = nil then
    FData := TDictionary<string, TValue>.Create;
  if not AValue.IsObject then
  begin
    FData.AddOrSetValue(AIndex, AValue);
    LHandled := False;
    if Objects.FAppearance <> nil then
      Objects.FAppearance.SetObjectData(Self, AIndex, AValue, LHandled);
    if not LHandled then
    begin
      LObject := Objects.FindObject(AIndex);
      if LObject <> nil then
        LObject.Data := AValue;
    end;
  end
  else
  begin
    LDataObject := AValue.AsObject;
    if LDataObject is TBitmap then
    begin
      LBitmap := nil;
      if (FDataBitmaps = nil) or not FDataBitmaps.TryGetValue(AIndex, LBitmap) then
      begin
        LBitmap := TBitmap.Create(0, 0);
        if FDataBitmaps = nil then
          FDataBitmaps := TObjectDictionary<string, TBitmap>.Create([doOwnsValues]);
        FDataBitmaps.Add(AIndex, LBitmap);
      end;
      LBitmap.Assign(TBitmap(LDataObject));
      LObject := Objects.FindObject(AIndex);
      if LObject is TListItemImage then
      begin
        Assert(not TListItemImage(LObject).OwnsBitmap);
        TListItemImage(LObject).Bitmap := LBitmap;
      end;
    end;
  end;
end;

procedure TListViewItem.SetDetail(const Value: string);
var
  LObject: TListItemText;
begin
  FDetail := Value;
  LObject :=  Objects.DetailObject;
  if LObject <> nil then
    LObject.Text := Value;
end;

procedure TListViewItem.SetBitmap(const Value: TBitmap);
var
  LObject: TListItemImage;
begin
  if Value <> nil then
    CheckBitmap;
  if FBitmap <> nil then
    FBitmap.Assign(Value);
  LObject := Objects.ImageObject;
  if LObject <> nil then
  begin
    LObject.OwnsBitmap := False;
    LObject.Bitmap := FBitmap;
  end;
end;

procedure TListViewItem.SetBitmapRef(const Value: TBitmap);
var
  LObject: TListItemImage;
begin
  FBitmapRef := Value;
  LObject := Objects.ImageObject;
  if LObject <> nil then
  begin
    LObject.OwnsBitmap := False;
    LObject.Bitmap := FBitmapRef;
  end;
end;


procedure TListViewItem.SetAccessory(const Value: TAccessoryType);
var
  LObject: TListItemAccessory;
begin
  FAccessory := Value;
  LObject := Objects.AccessoryObject;
  if LObject <> nil then
    LObject.AccessoryType := Value;
end;

procedure TListViewItem.CreateObjects;
begin
  if not HasObjects then
    Parent.ResetObjects(Self);
end;

{ TListViewItem.TListViewItemObjects }

procedure TListViewItem.TListViewItemObjects.Clear;
begin
  inherited;
  System.Exclude(TListViewItem(Owner).FFlags, TFlag.HasObjects);
end;

function TListViewItem.TListViewItemObjects.GetAccessoryObject: TListItemAccessory;
begin
  Result := FindObjectT<TListItemAccessory>(TListViewItem.TObjectNames.Accessory);
end;

function TListViewItem.TListViewItemObjects.GetDetailObject: TListItemText;
begin
  Result := FindObjectT<TListItemText>(TListViewItem.TObjectNames.Detail);
end;

function TListViewItem.TListViewItemObjects.GetGlyphButton: TListItemGlyphButton;
begin
  Result := FindObjectT<TListItemGlyphButton>(TListViewItem.TObjectNames.GlyphButton);
end;

function TListViewItem.TListViewItemObjects.GetImageObject: TListItemImage;
begin
  Result := FindObjectT<TListItemImage>(TListViewItem.TObjectNames.Image);
end;

function TListViewItem.TListViewItemObjects.GetTextButton: TListItemTextButton;
begin
  Result := FindObjectT<TListItemTextButton>(TListViewItem.TObjectNames.TextButton);
end;

function TListViewItem.TListViewItemObjects.GetTextObject: TListItemText;
begin
  Result := FindObjectT<TListItemText>(TListViewItem.TObjectNames.Text);
end;

function TListViewItem.TListViewItemObjects.FindObjectT<T>(const AName: string): T;
var
  LObject: TListItemObject;
begin
  LObject := FindObject(AName);
  if LObject is T then
    Exit(T(LObject));
  Result := nil;
end;

{ TListViewItems }

constructor TListViewItems.Create(const AOwner: TCustomListView);
begin
  inherited Create;
  FOwner := AOwner;
  FUnfilteredItems := TObjectList<TListViewItem>.Create; // Owned
  FActiveItems := FUnfilteredItems;
  FNewItems := TObjectList<TListViewItem>.Create(False); // Not owned
  FUnfilteredItems.OnNotify := ObjectsNotify;
end;

destructor TListViewItems.Destroy;
begin
  inherited;
  FNewItems.Free;
  FActiveItems := nil;
  if FFilteredItems <> nil then
  begin
    FFilteredItems.OnNotify := nil;
    FFilteredItems.Free;
  end;
  FUnfilteredItems.OnNotify := nil;
  FUnfilteredItems.Free;
end;

procedure TListViewItems.ObjectsNotify(Sender: TObject; const Item: TListViewItem; Action: TCollectionNotification);
begin
                        
  if Assigned(FOnNotify) then
    FOnNotify(Sender, Item, Action);
end;

function TListViewItems.Add: TListViewItem;
begin
  Result := AddItem(-1);
end;

function TListViewItems.IndexOf(const AItem: TListViewItem): Integer;
begin
  Result := FActiveItems.IndexOf(AItem);
end;

function TListViewItems.Insert(Index: Integer): TListViewItem;
begin
  Result := AddItem(Index);
end;

procedure TListViewItems.SetFilterPredicate(const Value: TPredicate<string>);
begin
  FFilterPredicate := Value;
  ApplyFilter;
  if FFilteredItems <> nil then
    FActiveItems := FFilteredItems
  else
    FActiveItems := FUnfilteredItems;
  ResetIndexes;
  FOwner.InvalidateHeights;
  FOwner.UpdateScrollingLimits();
  FOwner.Invalidate;
end;

procedure TListViewItems.ResetIndexes;
var
  I: Integer;
begin
  for I := 0 to FActiveItems.Count - 1 do
    FActiveItems[I].FIndex := I;
end;

procedure TListViewItems.ApplyFilter;
var
  Item: TListViewItem;
  HeaderIndex, FooterIndex, SectionSize: Integer;
begin
  if not Assigned(Filter) then
  begin
    if FFilteredItems <> nil then
    begin
      FActiveItems := FUnfilteredItems;
      FFilteredItems.OnNotify := nil;
      FreeAndNil(FFilteredItems);
    end;
  end
  else
  begin
    if FFilteredItems = nil then
    begin
      FFilteredItems := TList<TListViewItem>.Create; // Not owned
      FFilteredItems.OnNotify := OnNotify;
    end
    else
      FFilteredItems.Clear;

    HeaderIndex := -1;
    FooterIndex := -1;
    SectionSize := 0;
    for Item in FUnfilteredItems do
    begin
      if Item.Purpose =  TListItemPurpose.Header then
      begin
        if SectionSize = 0 then
        begin
          if (FooterIndex <> -1)  then
            FFilteredItems.Delete(FooterIndex);
          if (HeaderIndex <> -1) then
            FFilteredItems.Delete(HeaderIndex);
        end;

        FFilteredItems.Add(Item);
        HeaderIndex := FFilteredItems.Count - 1;
        FooterIndex := -1;
        SectionSize := 0;
      end
      else if Item.Purpose = TListItemPurpose.Footer then
      begin
        FFilteredItems.Add(Item);
        FooterIndex := FFilteredItems.Count - 1;
        if FooterIndex < HeaderIndex then
        begin
          FooterIndex := HeaderIndex;
          HeaderIndex := FFilteredItems.Count - 1;
        end;
      end
      else if Filter(Item.Text) or Filter(Item.Detail) then
      begin
        FFilteredItems.Add(Item);
        Inc(SectionSize);
      end;
    end;

    if (SectionSize = 0) then
    begin
      if FooterIndex <> -1 then
        FFilteredItems.Delete(FooterIndex);
      if HeaderIndex <> -1 then
        FFilteredItems.Delete(HeaderIndex);
    end;
  end;
end;


function TListViewItems.AddItem(Index: Integer): TListViewItem;
var
  I: Integer;
  LIndex: Integer;
begin
  Result := TListViewItem.Create;
  FNewItems.Add(Result);
  TOpenListBoxItem(Result).FParent := Owner;
  if Index < 0 then
    LIndex := FUnfilteredItems.Add(Result)
  else
  begin
    FUnfilteredItems.Insert(Index, Result);
    LIndex := Index;
  end;
  if FFilteredItems <> FActiveItems then
  begin
    // Update indexes if not filtering
    Result.FIndex := LIndex;
    for I := Result.FIndex+1 to Count - 1 do
      FActiveItems[I].FIndex := -1;
  end;
  Changed;
end;

function TListViewItems.AnyChecked(AChecked: Boolean): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to Count - 1 do
    if Item[I].Checked = AChecked then
      Exit(True);
end;

function TListViewItems.FirstChecked(AChecked: Boolean): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to Count - 1 do
    if Item[I].Checked = AChecked then
      Exit(I);
end;

function TListViewItems.CheckedIndexes(AChecked: Boolean): TArray<Integer>;
begin
  Result := CheckedIndexes(TOrder.LastToFirst, AChecked);
end;

function TListViewItems.CheckedIndexes(AOrder: TOrder;
  AChecked: Boolean): TArray<Integer>;
var
  LList: TList<Integer>;
  I: Integer;
begin
  LList := TList<Integer>.Create;
  try
    for I := 0 to Count - 1 do
      if Item[I].Checked = AChecked then
        if AOrder = TOrder.FirstToLast then
          LList.Add(I)
        else
          LList.Insert(0, I);
    Result := LList.ToArray;
  finally
    LList.Free;
  end;
end;

function TListViewItems.GetCount: Integer;
begin
  Result := FActiveItems.Count;
end;

function TListViewItems.GetEnumerator: TEnumerator<TListViewItem>;
begin
  Result := FActiveItems.GetEnumerator
end;

function TListViewItems.GetFiltered: Boolean;
begin
  Result := (FFilteredItems <> nil) and
    (FFilteredItems.Count <> FUnfilteredItems.Count);
end;

function TListViewItems.GetItem(Index: Integer): TListViewItem;
begin
  Result := FActiveItems[Index]; //Owner.GetItem(Index);
end;

procedure TListViewItems.CheckAll(AChecked: Boolean);
begin
  CheckAll(nil, AChecked);
end;

procedure TListViewItems.CheckAll(ACallback: TFunc<Integer, Boolean>; AChecked: Boolean = True);
var
  I: Integer;
  LItem: TListViewItem;
begin
  BeginUpdate;
  try
    for I := 0 to Count - 1 do
    begin
      LItem := Item[I];
      if LItem.Checked <> AChecked then
        if (not Assigned(ACallback)) or ACallback(I) then
          LItem.Checked := AChecked;
    end;
  finally
    EndUpdate;
  end;
end;

function TListViewItems.CheckedCount(AChecked: Boolean): Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to Count - 1 do
    if Item[I].Checked = AChecked then
      Inc(Result);
end;

procedure TListViewItems.Changed;
begin
  FOwner.InvalidateHeights;
  FOwner.UpdateScrollingLimits();
  FOwner.Invalidate;
end;

procedure TListViewItems.Clear;
begin
  FNewItems.Clear;
  if FFilteredItems <> nil then
    FFilteredItems.Clear;
  FUnfilteredItems.Clear;
  Changed;
end;

procedure TListViewItems.ResetObjects(APurposes: TCustomListView.TListItemPurposes);

  function CanResetObjects: Boolean;
  var
    LProperties: TItemAppearanceProperties;
  begin
    Result := False;
    for LProperties in Owner.GetAppearanceProperties do
      if LProperties.Active then
        if not (LProperties.Objects is TNullItemObjects) then
          Exit(True);
  end;

var
  I: Integer;
begin
  if CanResetObjects then
    for I := 0 to FUnfilteredItems.Count - 1 do
      if (APurposes = []) or (FUnfilteredItems[I].Purpose in APurposes) then
        FOwner.ResetObjects(FUnfilteredItems[I]);
end;

procedure TListViewItems.CreateNewObjects;
var
  LItem: TListViewItem;
begin
  for LItem in FNewItems do
    LItem.CreateObjects;
  FNewItems.Clear;
end;

procedure TListViewItems.BeginUpdate;
begin
  Owner.BeginUpdate;
end;

procedure TListViewItems.EndUpdate;
begin
  Owner.EndUpdate;
end;

procedure TListViewItems.Delete(Index: Integer);
var
  I: Integer;
  LItem: TListViewItem;
begin
  if Owner.FItemIndex >= Count - 1 then
    Owner.ItemIndex := -1;
  if FActiveItems = FFilteredItems then
  begin
    LItem := FActiveItems[Index];
    FFilteredItems.Delete(Index);
    FNewItems.Remove(LItem);
    FUnfilteredItems.Remove(LItem); // Free the item
  end
  else
  begin
    FNewItems.Remove(FUnfilteredItems[Index]);
    FUnfilteredItems.Delete(Index); // Free the item
    FreeAndNil(FFilteredItems);
  end;
  for I := Index to Count - 1 do
    FActiveItems[I].FIndex := -1;
  Changed;
end;

{ TObjectAppearanceBase }

procedure TObjectAppearance.AfterConstruction;
begin
  inherited;
  if not FIsDefaultValues then
  begin
    FDefaultValues := CreateDefaultValues;
    if FDefaultValues <> nil then
    begin
      Assert(FDefaultValues.FIsDefaultValues); // Descendent should have set this
      FDefaultValues.FIsDefaultValues := True; // Just in case
      FInitializing := True;
      try
        Self.Assign(FDefaultValues);
      finally
        FInitializing := False;
      end;
    end;
  end;
end;

procedure TObjectAppearance.BeginUpdate;
begin
  if FOwner <> nil then
    FOwner.BeginUpdate;
end;

destructor TObjectAppearance.Destroy;
begin
  FDefaultValues.Free;
  inherited;
end;

procedure TObjectAppearance.DoChange;
begin
  if not IgnoreChanges then
    if Assigned(FOnChange) then
      FOnChange(Self);
end;

procedure TObjectAppearance.DoHeightChange;
begin
  if not IgnoreChanges then
    if Assigned(FOnHeightChange) then
      FOnHeightChange(Self);
end;

constructor TObjectAppearance.Create;
begin
  inherited Create;
end;

constructor TObjectAppearance.Create(AIsDefaultValues: Boolean);
begin
  FIsDefaultValues := AIsDefaultValues;
  Create;
end;

function TObjectAppearance.CreateDefaultValues: TObjectAppearance;
begin
  Result := nil;
end;

procedure TObjectAppearance.CreateObject(
  const AListViewItem: TListViewItem);
begin
  Assert(False); // shouldn't get here
end;

procedure TObjectAppearance.ResetObject(
  const AListViewItem: TListViewItem);
begin
  Assert(False); // shouldn't get here
end;

procedure TObjectAppearance.EndUpdate;
begin
  if FOwner <> nil then
    FOwner.EndUpdate;
end;

function TObjectAppearance.GetHeight: Integer;
begin
  Result := TItemAppearanceProperties.cDefaultHeight;
end;

function TObjectAppearance.IsActive: Boolean;
begin
  Result := True;
end;

function TObjectAppearance.IgnoreChanges: Boolean;
begin
  Result := FInitializing or FIsDefaultValues or
    not IsActive;
end;

procedure TObjectAppearance.RestoreDefaults;
begin
  if Assigned(FDefaultValues) then
  begin
    BeginUpdate;
    try
      Self.Assign(FDefaultValues);
    finally
      EndUpdate;
    end;
  end;
end;

procedure TObjectAppearance.SetDefaultValues(const Value: TObjectAppearance);
begin
  if FDefaultValues <> nil then
  begin
    Assert(FDefaultValues.IgnoreChanges); // No need to begin/end update
    FDefaultValues.Assign(Value);
  end;
end;

procedure TObjectAppearance.SetVisible(const Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    DoChange;
  end;
end;

{ TObjectAppearance }

function SamePosition(const APosition1, APosition2: TPosition): Boolean; overload;
begin
  Result := (APosition1.X = APosition2.X) and (APosition1.Y = APosition1.Y);
end;

function SamePosition(const APosition1: TPosition; const APosition2: TPointF): Boolean; overload;
begin
  Result := (APosition1.X = APosition2.X) and (APosition1.Y = APosition1.Y);
end;

procedure TCommonObjectAppearance.AssignTo(ADest: TPersistent);
var
 LObject: TListItemObject;
begin
  if ADest is TCommonObjectAppearance then
  begin
    with TCommonObjectAppearance(ADest) do
    begin
      BeginUpdate;
      try
        Width := Self.Width;
        Height := Self.Height;
        Align := Self.Align;
        VertAlign := Self.VertAlign;
        Visible := Self.Visible;
        if not SamePosition(PlaceOffset, Self.PlaceOffset) then
          PlaceOffset.Assign(Self.PlaceOffset);
        if not SamePosition(InternalPlaceOffset, Self.InternalPlaceOffset) then
          InternalPlaceOffset.Assign(Self.InternalPlaceOffset);
        InternalWidth := Self.InternalWidth;
        InternalHeight := Self.InternalHeight;
      finally
        EndUpdate;
      end;
    end;
  end
  else if ADest is TListItemObject then
  begin
    LObject := TListItemObject(ADest);
    LObject.BeginUpdate;
    try
      if (FOwner <> nil) and (FOwner.Owner <> nil) and FOwner.Owner.FUpdateStyleResources then
        TOpenListItemObject(LObject).UpdateValuesFromStyle;
      LObject.Height := Self.HeightWhenVisible;
      LObject.Width := Self.WidthWhenVisible;
      LObject.Align := Self.Align;
      LObject.VertAlign := Self.VertAlign;
      LObject.Visible := Self.Visible;
      if not SamePosition(LObject.PlaceOffset, Self.ActualPlaceOffset) then
        LObject.PlaceOffset.Point := Self.ActualPlaceOffset;
    finally
      LObject.EndUpdate;
    end;
  end
  else
    inherited;

end;

constructor TCommonObjectAppearance.Create;
begin
  inherited;
  FOpacity := 1.0;
  FPlaceOffset := TPosition.Create(TPointF.Create(0.0, 0.0));
  FPlaceOffset.OnChange := OnPlaceOffsetChange;
  FInternalPlaceOffset := TPosition.Create(TPointF.Create(0.0, 0.0));
  FInternalPlaceOffset.OnChange := OnPlaceOffsetChange;
end;

destructor TCommonObjectAppearance.Destroy;
begin
  FPlaceOffset.Free;
  FInternalPlaceOffset.Free;

  inherited;
end;

function TCommonObjectAppearance.GetActualHeight: Single;
begin
  if Visible then
    if Height <> 0 then
      Result := Height
    else
      Result := InternalHeight
  else
    Result := 0;

end;

function TCommonObjectAppearance.GetHeightWhenVisible: Single;
begin
  if Height <> 0 then
    Result := Height
  else
    Result := InternalHeight
end;

function TCommonObjectAppearance.GetActualPlaceOffset: TPointF;
begin
  Result.X := 0;
  Result.Y := 0;
  if PlaceOffset.X <> 0 then
    Result.X := PlaceOffset.X
  else
    Result.X := InternalPlaceOffset.X;
  if PlaceOffset.Y <> 0 then
    Result.Y := PlaceOffset.Y
  else
    Result.Y := InternalPlaceOffset.Y;

end;

function TCommonObjectAppearance.GetActualWidth: Single;
begin
  if Visible then
    if Width <> 0 then
      Result := Width
    else
      Result := InternalWidth
  else
    Result := 0;
end;

function TCommonObjectAppearance.GetWidthWhenVisible: Single;
begin
  if Width <> 0 then
    Result := Width
  else
    Result := InternalWidth;
end;

procedure TCommonObjectAppearance.InitDefaultValues(
  const ADefaults: TCommonObjectAppearance);
begin
  Assert(ADefaults.FIsDefaultValues);
end;

function TCommonObjectAppearance.IsAlignStored: Boolean;
begin
  if DefaultValues is TCommonObjectAppearance then
    Result := Align <> TCommonObjectAppearance(DefaultValues).Align
  else
    Result := Align <> Low(TListItemAlign);
end;

function TCommonObjectAppearance.IsHeightStored: Boolean;
begin
  if DefaultValues is TCommonObjectAppearance then
    Result := TCommonObjectAppearance(DefaultValues).Height <> Height
  else
    Result := Height <> 0;
end;

function TCommonObjectAppearance.IsOpacityStored: Boolean;
begin
  if DefaultValues is TCommonObjectAppearance then
    Result := TCommonObjectAppearance(DefaultValues).Opacity <> Opacity
  else
    Result := Opacity <> 1.0;
end;

function TCommonObjectAppearance.IsPlaceOffsetStored: Boolean;
begin
  if DefaultValues is TCommonObjectAppearance then
    Result := TCommonObjectAppearance(DefaultValues).PlaceOffset.Point <> PlaceOffset.Point
  else
    Result := PlaceOffset.Point <> TPointF.Create(0, 0);
end;

function TCommonObjectAppearance.IsVertAlignStored: Boolean;
begin
  if DefaultValues is TCommonObjectAppearance then
    Result := TCommonObjectAppearance(DefaultValues).VertAlign <> VertAlign
  else
    Result := VertAlign <> Low(TListItemAlign);
end;

function TCommonObjectAppearance.IsVisibleStored: Boolean;
begin
  if DefaultValues is TCommonObjectAppearance then
    Result := TCommonObjectAppearance(DefaultValues).Visible <> Visible
  else
    Result := Visible <> False;
end;

function TCommonObjectAppearance.IsWidthStored: Boolean;
begin
  if DefaultValues is TCommonObjectAppearance then
    Result := TCommonObjectAppearance(DefaultValues).Width <> Width
  else
    Result := Width <> 0;
end;

procedure TCommonObjectAppearance.OnPlaceOffsetChange(Sender: TObject);
begin
  DoChange;
end;

procedure TCommonObjectAppearance.ResetObjectT<T>(const AListViewItem: TListViewItem);
var
  LObject: T;
begin
  LObject := AListViewItem.Objects.FindObjectT<T>(Name);
  if LObject <> nil then
    LObject.Assign(Self)
end;

procedure TCommonObjectAppearance.SetAlign(const Value: TListItemAlign);
begin
  if FAlign <> Value then
  begin
    FAlign := Value;
    DoChange;
  end;
end;

procedure TCommonObjectAppearance.SetInternalPlaceOffset(
  const Value: TPosition);
begin
  FInternalPlaceOffset.Assign(Value);
end;

procedure TCommonObjectAppearance.SetOpacity(const Value: Single);
begin
  if FOpacity <> Value then
  begin
    FOpacity := Value;
    DoChange;
  end;
end;

procedure TCommonObjectAppearance.SetPlaceOffset(
  const Value: TPosition);
begin
  FPlaceOffset.Assign(Value);  // DoChange called by TPosition.OnChange
end;

procedure TCommonObjectAppearance.SetWidth(const Value: Single);
var
  NewValue: Single;
begin
  NewValue := Value;
  if (NewValue < 0.0) then
    NewValue := 0.0;

  if (FWidth <> NewValue) then
  begin
    FWidth := NewValue;
    DoChange;
  end;
end;

procedure TCommonObjectAppearance.SetInternalWidth(const Value: Single);
begin
  if (FInternalWidth <> Value) then
  begin
    FInternalWidth := Value;
    DoChange;
  end;
end;

procedure TCommonObjectAppearance.SetInternalHeight(const Value: Single);
begin
  if (FInternalHeight <> Value) then
  begin
    FInternalHeight := Value;
    DoChange;
  end;
end;

procedure TCommonObjectAppearance.SetHeight(const Value: Single);
var
  NewValue: Single;
begin
  NewValue := Value;
  if (NewValue < 0.0) then
    NewValue := 0.0;

  if (FHeight <> NewValue) then
  begin
    FHeight := NewValue;
    DoChange;
  end;
end;

procedure TCommonObjectAppearance.SetVertAlign(
  const Value: TListItemAlign);
begin
  if FVertAlign <> Value then
  begin
    FVertAlign := Value;
    DoChange;
  end;
end;

procedure TCustomTextObjectAppearance.AssignTo(ADest: TPersistent);
var
  LObject: TListItemText;
begin
  if ADest is TCustomTextObjectAppearance then
  begin
    with TCustomTextObjectAppearance(ADest) do
    begin
      BeginUpdate;
      try
        inherited AssignTo(ADest);
        Font.Assign(Self.Font);
        TextColor := Self.TextColor;
        TextAlign := Self.TextAlign;
        TextVertAlign := Self.TextVertAlign;
        WordWrap := Self.WordWrap;
        Opacity := Self.Opacity;
        Trimming := Self.Trimming;
        IsDetailText := Self.IsDetailText;
      finally
        EndUpdate;
      end;
    end;
  end
  else if ADest is TListItemText then
  begin
    LObject := TListItemText(ADest);
    LObject.BeginUpdate;
    try
      inherited AssignTo(ADest);
      if Self.Font.IsFamilyStored then
        LObject.Font.Family := Self.Font.Family;
      if Self.Font.IsSizeStored then
        LObject.Font.Size := Self.Font.Size;
      if Self.Font.Style <> [] then
        LObject.Font.Style := Self.Font.Style;
      if Self.TextColor <> TAlphaColorRec.Null then
        LObject.TextColor := Self.TextColor;
      LObject.TextAlign := Self.TextAlign;
      LObject.TextVertAlign := Self.TextVertAlign;
      LObject.WordWrap := Self.WordWrap;
      LObject.Opacity := Self.Opacity;
      LObject.Trimming := Self.Trimming;
      LObject.IsDetailText := Self.IsDetailText;
    finally
      LObject.EndUpdate;
    end;
  end
  else
    inherited;

end;

constructor TCustomTextObjectAppearance.Create;
begin
  inherited;
  FName := TListViewItem.TObjectNames.Text;

  FFont := TFont.Create();
  FFont.OnChanged := FontChanged;
end;

function TCustomTextObjectAppearance.CreateDefaultValues: TObjectAppearance;
var
  LDefaults: TCustomTextObjectAppearance;
begin
  LDefaults := TCustomTextObjectAppearance.Create(True);
  InitDefaultValues(LDefaults);
  Result := LDefaults;
end;

procedure TCustomTextObjectAppearance.ResetObject(
  const AListViewItem: TListViewItem);
begin
  ResetObjectT<TListItemText>(AListViewItem);
end;

procedure TCustomTextObjectAppearance.CreateObject(
  const AListViewItem: TListViewItem);
var
  LItem: TListItemText;
  LHandled: Boolean;
  LValue: TValue;
begin
  LItem := TListItemText.Create(AListViewItem);
  LItem.BeginUpdate;
  try
    LItem.Name := FName;
    if FName = TListViewItem.TObjectNames.Detail then
      LItem.Text := AListViewItem.Detail
    else if FName = TListViewItem.TObjectNames.Text then
      LItem.Text := AListViewItem.Text
    else if AListViewItem.GetHasData(FName) then
    begin
      LHandled := False;
      LValue := AListViewItem.GetData(FName);
      FOwner.SetObjectData(AListViewItem, FName, LValue, LHandled);
      if not LHandled then
        LItem.Data := LValue;
    end;
    LItem.Assign(Self);
  finally
    LItem.EndUpdate;
  end;
end;

destructor TCustomTextObjectAppearance.Destroy;
begin
  FreeAndNil(FTextLayout);

  FFont.Free;

  inherited;
end;

procedure TCustomTextObjectAppearance.FontChanged(Sender: TObject);
begin
  DoChange;
end;

function TCustomTextObjectAppearance.GetDefaultValues: TCustomTextObjectAppearance;
begin
  Result := inherited DefaultValues as TCustomTextObjectAppearance;
end;

function TCustomTextObjectAppearance.IsFontStored: Boolean;
begin
  if DefaultValues is TCustomTextObjectAppearance then
    Result := not Font.Equals(TCustomTextObjectAppearance(DefaultValues).Font)
  else
    Result := Font.IsFamilyStored or Font.IsSizeStored or (Font.Style <> []);
end;

function TCustomTextObjectAppearance.IsOpacityStored: Boolean;
begin
  if DefaultValues is TCustomTextObjectAppearance then
    Result := Opacity <> TCustomTextObjectAppearance(DefaultValues).Opacity
  else
    Result := Opacity <> 1;
end;

function TCustomTextObjectAppearance.IsTextAlignStored: Boolean;
begin
  if DefaultValues is TCustomTextObjectAppearance then
    Result := TextAlign <> TCustomTextObjectAppearance(DefaultValues).TextAlign
  else
    Result := TextAlign <> Low(TTextAlign);
end;

function TCustomTextObjectAppearance.IsTextColorStored: Boolean;
begin
  if DefaultValues is TCustomTextObjectAppearance then
    Result := TextColor <> TCustomTextObjectAppearance(DefaultValues).TextColor
  else
    Result := True;
end;

function TCustomTextObjectAppearance.IsTextVertAlignStored: Boolean;
begin
  if DefaultValues is TCustomTextObjectAppearance then
    Result := TextVertAlign <> TCustomTextObjectAppearance(DefaultValues).TextVertAlign
  else
    Result := TextVertAlign <> Low(TTextAlign);
end;

function TCustomTextObjectAppearance.IsTrimmingStored: Boolean;
begin
  if DefaultValues is TCustomTextObjectAppearance then
    Result := Trimming <> TCustomTextObjectAppearance(DefaultValues).Trimming
  else
    Result := Trimming <> Low(TTextTrimming);
end;

function TCustomTextObjectAppearance.IsWordWrapStored: Boolean;
begin
  if DefaultValues is TCustomTextObjectAppearance then
    Result := WordWrap <> TCustomTextObjectAppearance(DefaultValues).WordWrap
  else
    Result := WordWrap <> False;
end;

function TCustomTextObjectAppearance.IsDetailTextStored: Boolean;
begin
  if DefaultValues is TCustomTextObjectAppearance then
    Result := IsDetailText <> TCustomTextObjectAppearance(DefaultValues).IsDetailText
  else
    Result := IsDetailText <> False;
end;

procedure TCustomTextObjectAppearance.SetIsDetailText(const Value: Boolean);
begin
  if (FIsDetailText <> Value) then
  begin
    FIsDetailText := Value;
    DoChange;
  end;
end;

procedure TCustomTextObjectAppearance.SetFont(const Value: TFont);
begin
  FFont.Assign(Value); // DoChange called by Font.OnChange event
end;

procedure TCustomTextObjectAppearance.SetTextAlign(const Value: TTextAlign);
begin
  if (FTextAlign <> Value) then
  begin
    FTextAlign := Value;
    DoChange;
  end;
end;

procedure TCustomTextObjectAppearance.SetTextColor(const Value: TAlphaColor);
begin
  if (FTextColor <> Value) then
  begin
    FTextColor := Value;
    DoChange;
  end;
end;

procedure TCustomTextObjectAppearance.SetTextVertAlign(const Value: TTextAlign);
begin
  if (FTextVertAlign <> Value) then
  begin
    FTextVertAlign := Value;
    DoChange;
  end;
end;

procedure TCustomTextObjectAppearance.SetTrimming(const Value: TTextTrimming);
begin
  if (FTrimming <> Value) then
  begin
    FTrimming := Value;
    DoChange;
  end;
end;

procedure TCustomTextObjectAppearance.SetWordWrap(const Value: Boolean);
begin
  if (FWordWrap <> Value) then
  begin
    FWordWrap := Value;
    DoChange;
  end;
end;


procedure TCustomImageObjectAppearance.AssignTo(ADest: TPersistent);
var
  LObject: TListItemImage;

begin
  if ADest is TCustomImageObjectAppearance then
  begin
    with TCustomImageObjectAppearance(ADest) do
    begin
      BeginUpdate;
      try
        inherited AssignTo(ADest);
        SrcRect := Self.SrcRect;
        ScalingMode := Self.ScalingMode;
        Opacity := Self.Opacity;
      finally
        EndUpdate;
      end;
    end;
  end
  else if ADest is TListItemImage then
  begin
    LObject := TListItemImage(ADest);
    LObject.BeginUpdate;
    try
      inherited AssignTo(ADest);
      LObject.SrcRect := TRectF.Create(Self.SrcRect.Left, Self.SrcRect.Top,
        Self.SrcRect.Width, Self.SrcRect.Height);
      LObject.ScalingMode := Self.ScalingMode;
      LObject.Opacity := Self.Opacity;
    finally
      LObject.EndUpdate;
    end;
  end
  else
    inherited;
end;

constructor TCustomImageObjectAppearance.Create;
begin
  inherited;
  FName := TListViewItem.TObjectNames.Image;
  FSrcRect := TBounds.Create(TRectF.Create(0, 0, 0, 0));
  FSrcRect.OnChange := OnSrcRectChange;
end;

function TCustomImageObjectAppearance.CreateDefaultValues: TObjectAppearance;
var
  LDefaults: TCustomImageObjectAppearance;
begin
  LDefaults := TCustomImageObjectAppearance.Create(True);
  InitDefaultValues(LDefaults);
  Result := LDefaults;
end;

procedure TCustomImageObjectAppearance.OnSrcRectChange(Sender: TObject);
begin
  DoChange;
end;

procedure TCustomImageObjectAppearance.ResetObject(
  const AListViewItem: TListViewItem);
begin
  ResetObjectT<TListItemImage>(AListViewItem);
end;

procedure TCustomImageObjectAppearance.CreateObject(
  const AListViewItem: TListViewItem);
var
  LItem: TListItemImage;
  LBitmap: TBitmap;
begin
  LItem := TListItemImage.Create(AListViewItem);
  LItem.BeginUpdate;
  try
    LItem.Name := FName;
    LItem.OwnsBitmap := False; // Always reference listitem's bitmap
    if FName = TListViewItem.TObjectNames.Image then
    begin
      if Assigned(AListViewItem.BitmapRef) then
        LItem.Bitmap := AListViewItem.BitmapRef
      else
        LItem.Bitmap := AListViewItem.Bitmap;
      LItem.Assign(Self);
    end
    else if AListViewItem.GetHasData(FName) then
    begin
      if AListViewItem.GetData(FName).TryAsType<TBitmap>(LBitmap) then
        LItem.Bitmap := LBitmap
    end;
  finally
    LItem.EndUpdate;
  end;
end;

destructor TCustomImageObjectAppearance.Destroy;
begin
  FSrcRect.Free;
  inherited;
end;

function TCustomImageObjectAppearance.GetDefaultValues: TCustomImageObjectAppearance;
begin
  Result := inherited DefaultValues as TCustomImageObjectAppearance;
end;

function TCustomImageObjectAppearance.IsOpacityStored: Boolean;
begin
  if DefaultValues is TCustomImageObjectAppearance then
    Result := Opacity <> TCustomImageObjectAppearance(DefaultValues).Opacity
  else
    Result := Opacity <> 1;
end;

function TCustomImageObjectAppearance.IsScalingModeStored: Boolean;
begin
  if DefaultValues is TCustomImageObjectAppearance then
    Result := ScalingMode <> TCustomImageObjectAppearance(DefaultValues).ScalingMode
  else
    Result := ScalingMode <> Low(TImageScalingMode);
end;

function TCustomImageObjectAppearance.IsSrcRectStored: Boolean;
begin
  if DefaultValues is TCustomImageObjectAppearance then
    Result := SrcRect.Equals(TCustomImageObjectAppearance(DefaultValues).SrcRect)
  else
    Result := not SrcRect.Empty;
end;

procedure TCustomImageObjectAppearance.SetScalingMode(const Value: TImageScalingMode);
begin
  if FScalingMode <> Value then
  begin
    FScalingMode := Value;
    DoChange;
  end;
end;

procedure TCustomImageObjectAppearance.SetSrcRect(const Value: TBounds);
begin
  FSrcRect.Assign(Value); // DoChange called by TBounds.OnChange
end;

{ TCustomAccessoryObjectAppearance }

procedure TCustomAccessoryObjectAppearance.AssignTo(ADest: TPersistent);
var
  LObject: TListItemAccessory;
begin
  if ADest is TCustomAccessoryObjectAppearance then
  begin
    with TCustomAccessoryObjectAppearance(ADest) do
    begin
      BeginUpdate;
      try
        inherited AssignTo(ADest);
        AccessoryType := Self.AccessoryType;
      finally
        EndUpdate;
      end;
    end;
  end
  else if ADest is TListItemAccessory then
  begin
    LObject := TListItemAccessory(ADest);
    LObject.BeginUpdate;
    try
      inherited AssignTo(ADest);
      LObject.AccessoryType := Self.AccessoryType;
    finally
      LObject.EndUpdate;
    end;
  end
  else
    inherited;


end;

constructor TCustomAccessoryObjectAppearance.Create;
begin
  inherited;
  FName := TListViewItem.TObjectNames.Accessory;
end;

function TCustomAccessoryObjectAppearance.CreateDefaultValues: TObjectAppearance;
var
  LDefaults: TCustomAccessoryObjectAppearance;
begin
  LDefaults := TCustomAccessoryObjectAppearance.Create(True);
  InitDefaultValues(LDefaults);
  Result := LDefaults;
end;

procedure TCustomAccessoryObjectAppearance.CreateObject(
  const AListViewItem: TListViewItem);
var
  LItem: TListItemAccessory;
begin
  LItem := TListItemAccessory.Create(AListViewItem);
  LItem.BeginUpdate;
  try
    LItem.Name := FName;
    LItem.Assign(Self);
  finally
    LItem.EndUpdate;
  end;
end;

function TCustomAccessoryObjectAppearance.GetDefaultValues: TCustomAccessoryObjectAppearance;
begin
  Result := inherited DefaultValues as TCustomAccessoryObjectAppearance;
end;

function TCustomAccessoryObjectAppearance.IsAccessoryTypeStored: Boolean;
begin
  if DefaultValues is TCustomAccessoryObjectAppearance then
    Result := AccessoryType <> TCustomAccessoryObjectAppearance(DefaultValues).AccessoryType
  else
    Result := AccessoryType <> Low(TAccessoryType);
end;

procedure TCustomAccessoryObjectAppearance.ResetObject(
  const AListViewItem: TListViewItem);
begin
  ResetObjectT<TListItemAccessory>(AListViewItem);
end;

procedure TCustomAccessoryObjectAppearance.SetAccessoryType(const Value: TAccessoryType);
begin
  if (FAccessoryType <> Value) then
  begin
    FAccessoryType := Value;
    DoChange;
  end;
end;

{ TCustomTextButtonObjectAppearance }

procedure TCustomTextButtonObjectAppearance.AssignTo(ADest: TPersistent);
var
  LObject: TListItemTextButton;
begin
  if ADest is TCustomTextButtonObjectAppearance then
  begin
    with TCustomTextButtonObjectAppearance(ADest) do
    begin
      BeginUpdate;
      try
        inherited AssignTo(ADest);
        ButtonType := Self.ButtonType;
        Text := Self.Text;
        Font.Assign(Self.Font);
        TextAlign := Self.TextAlign;
        TextVertAlign := Self.TextVertAlign;
        WordWrap := Self.WordWrap;
        Opacity := Self.Opacity;
        Trimming := Self.Trimming;
        TextColor := Self.TextColor;
        PressedTextColor := Self.PressedTextColor;
        TextShadowColor := Self.TextShadowColor;
        Enabled := Self.Enabled;
      finally
        EndUpdate;
      end;
    end;
  end
  else if ADest is TListItemTextButton then
  begin
    LObject := TListItemTextButton(ADest);
    LObject.BeginUpdate;
    try
      inherited AssignTo(ADest);
      LObject.ButtonType := Self.ButtonType;
      if not FHasButtonText then
        LObject.Text := Self.Text;
      LObject.OnClick := Self.OnControlClick;
      if Self.Font.IsFamilyStored then
        LObject.Font.Family := Self.Font.Family;
      if Self.Font.IsSizeStored then
        LObject.Font.Size := Self.Font.Size;
      if Self.Font.Style <> [] then
        LObject.Font.Style := Self.Font.Style;
      LObject.TextAlign := Self.TextAlign;
      LObject.TextVertAlign := Self.TextVertAlign;
      LObject.WordWrap := Self.WordWrap;
      LObject.Trimming := Self.Trimming;
      if Self.TextColor <> TAlphaColorRec.Null then
        LObject.TextColor := Self.TextColor;
      if Self.PressedTextColor <> TAlphaColorRec.Null then
        LObject.PressedTextColor := Self.PressedTextColor;
      if Self.TextShadowColor <> TAlphaColorRec.Null then
        LObject.TextShadowColor := Self.TextShadowColor;
      LObject.Enabled := Self.Enabled;
      LObject.Opacity := Self.Opacity;
    finally
      LObject.EndUpdate;
    end;
  end

  else
    inherited;


end;

constructor TCustomTextButtonObjectAppearance.Create;
begin
  inherited;
  FName := TListViewItem.TObjectNames.TextButton;
  FFont := TFont.Create;
  FFont.OnChanged := FontChanged;
  FEnabled := True;
end;

procedure TCustomTextButtonObjectAppearance.FontChanged(Sender: TObject);
begin
  DoChange;
end;

function TCustomTextButtonObjectAppearance.CreateDefaultValues: TObjectAppearance;
var
  LDefaults: TCustomTextButtonObjectAppearance;
begin
  LDefaults := TCustomTextButtonObjectAppearance.Create(True);
  InitDefaultValues(LDefaults);
  Result := LDefaults;
end;

procedure TCustomTextButtonObjectAppearance.CreateObject(
  const AListViewItem: TListViewItem);
var
  LItem: TListItemTextButton;
  LHandled: Boolean;
  LValue: TValue;
begin
  LItem := TListItemTextButton.Create(AListViewItem);
  LItem.BeginUpdate;
  try
    LItem.Name := FName;
    LItem.Assign(Self);
    if FName = TListViewItem.TObjectNames.TextButton then
    begin
      if AListViewItem.GetHasButtonText then
        LItem.Text := AListViewItem.FButtonText;
    end
    else if AListViewItem.GetHasData(FName) then
    begin
      LHandled := False;
      LValue := AListViewItem.GetData(FName);
      FOwner.SetObjectData(AListViewItem, FName, LValue, LHandled);
      if not LHandled then
        LItem.Data := LValue;
    end;
  finally
    LItem.EndUpdate;
  end;
end;

function TCustomTextButtonObjectAppearance.GetDefaultValues: TCustomTextButtonObjectAppearance;
begin
  Result := inherited DefaultValues as TCustomTextButtonObjectAppearance;
end;

function TCustomTextButtonObjectAppearance.IsButtonTypeStored: Boolean;
begin
  if DefaultValues is TCustomTextButtonObjectAppearance then
    Result := ButtonType <> TCustomTextButtonObjectAppearance(DefaultValues).ButtonType
  else
    Result := ButtonType <> Low(TTextButtonType);
end;

function TCustomTextButtonObjectAppearance.IsTextStored: Boolean;
begin
  if DefaultValues is TCustomTextButtonObjectAppearance then
    Result := Text <> TCustomTextButtonObjectAppearance(DefaultValues).Text
  else
    Result := Text <> '';
end;

function TCustomTextButtonObjectAppearance.IsTrimmingStored: Boolean;
begin
  if DefaultValues is TCustomTextButtonObjectAppearance then
    Result := Trimming <> TCustomTextButtonObjectAppearance(DefaultValues).Trimming
  else
    Result := Trimming <> Low(TTextTrimming);
end;

function TCustomTextButtonObjectAppearance.IsFontStored: Boolean;
begin
  if DefaultValues is TCustomTextButtonObjectAppearance then
    Result := not Font.Equals(TCustomTextButtonObjectAppearance(DefaultValues).Font)
  else
    Result := Font.IsFamilyStored or Font.IsSizeStored or (Font.Style <> []);
end;

function TCustomTextButtonObjectAppearance.IsTextAlignStored: Boolean;
begin
  if DefaultValues is TCustomTextButtonObjectAppearance then
    Result := TextAlign <> TCustomTextButtonObjectAppearance(DefaultValues).TextAlign
  else
    Result := TextAlign <> Low(TTextAlign);
end;

function TCustomTextButtonObjectAppearance.IsTextColorStored: Boolean;
begin
  if DefaultValues is TCustomTextButtonObjectAppearance then
    Result := TextColor <> TCustomTextButtonObjectAppearance(DefaultValues).TextColor
  else
    Result := True;
end;

function TCustomTextButtonObjectAppearance.IsPressedTextColorStored: Boolean;
begin
  if DefaultValues is TCustomTextButtonObjectAppearance then
    Result := PressedTextColor <> TCustomTextButtonObjectAppearance(DefaultValues).PressedTextColor
  else
    Result := True;
end;

function TCustomTextButtonObjectAppearance.IsTextShadowColorStored: Boolean;
begin
  if DefaultValues is TCustomTextButtonObjectAppearance then
    Result := TextShadowColor <> TCustomTextButtonObjectAppearance(DefaultValues).TextShadowColor
  else
    Result := True;
end;

function TCustomTextButtonObjectAppearance.IsTextVertAlignStored: Boolean;
begin
  if DefaultValues is TCustomTextButtonObjectAppearance then
    Result := TextVertAlign <> TCustomTextButtonObjectAppearance(DefaultValues).TextVertAlign
  else
    Result := TextVertAlign <> Low(TTextAlign);
end;

function TCustomTextButtonObjectAppearance.IsWordWrapStored: Boolean;
begin
  if DefaultValues is TCustomTextButtonObjectAppearance then
    Result := WordWrap <> TCustomTextButtonObjectAppearance(DefaultValues).WordWrap
  else
    Result := WordWrap <> False;
end;

procedure TCustomTextButtonObjectAppearance.ResetObject(
  const AListViewItem: TListViewItem);
var
  LObject: TListItemTextButton;
begin
  LObject := AListViewItem.Objects.FindObjectT<TListItemTextButton>(FName);
  if LObject <> nil then
    if LObject.Name = TListViewItem.TObjectNames.TextButton then
    begin
      FHasButtonText := AListViewItem.GetHasButtonText;
      try
        LObject.Assign(Self)
      finally
        FHasButtonText := False;
      end;
    end
    else
      LObject.Assign(Self)
end;

function TCustomTextButtonObjectAppearance.IsEnabledStored: Boolean;
begin
  if DefaultValues is TCustomTextButtonObjectAppearance then
    Result := Enabled <> TCustomTextButtonObjectAppearance(DefaultValues).Enabled
  else
    Result := Enabled <> True;
end;


procedure TCustomTextButtonObjectAppearance.DoControlClick(Sender: TObject);
begin
  if Assigned(FOnControlClick) then
    FOnControlClick(Self);
end;

destructor TCustomTextButtonObjectAppearance.Destroy;
begin
  FFont.Free;
  inherited;
end;

procedure TCustomTextButtonObjectAppearance.DoControlChange(Sender: TObject);
begin
  if Assigned(FOnControlChange) then
    FOnControlChange(Self);
end;

procedure TCustomTextButtonObjectAppearance.SetButtonType(const Value: TTextButtonType);
begin
  if Value <> FButtonType then
  begin
    FButtonType := Value;
    DoChange;
  end;
end;

procedure TCustomTextButtonObjectAppearance.SetEnabled(const Value: Boolean);
begin
  if Value <> FEnabled then
  begin
    FEnabled := Value;
    DoChange;
  end;
end;

procedure TCustomTextButtonObjectAppearance.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);  // OnFontChanged called
end;

procedure TCustomTextButtonObjectAppearance.SetPressedTextColor(
  const Value: TAlphaColor);
begin
  if FPressedTextColor <> Value then
  begin
    FPressedTextColor := Value;
    DoChange;
  end;
end;

procedure TCustomTextButtonObjectAppearance.SetText(const Value: string);
begin
  if Value <> FText then
  begin
    FText := Value;
    DoChange;
  end;
end;

procedure TCustomTextButtonObjectAppearance.SetTextAlign(
  const Value: TTextAlign);
begin
  if Value <> FTextAlign then
  begin
    FTextAlign := Value;
    DoChange;
  end;
end;

procedure TCustomTextButtonObjectAppearance.SetTextColor(
  const Value: TAlphaColor);
begin
  if FTextColor <> Value then
  begin
    FTextColor := Value;
    DoChange;
  end;
end;

procedure TCustomTextButtonObjectAppearance.SetTextShadowColor(
  const Value: TAlphaColor);
begin
  if FTextShadowColor <> Value then
  begin
    FTextShadowColor := Value;
    DoChange;
  end;
end;

procedure TCustomTextButtonObjectAppearance.SetTextVertAlign(
  const Value: TTextAlign);
begin
  if Value <> FTextAlign then
  begin
    FTextVertAlign := Value;
    DoChange;
  end;
end;

procedure TCustomTextButtonObjectAppearance.SetTrimming(
  const Value: TTextTrimming);
begin
  if Value <> FTrimming then
  begin
    FTrimming := Value;
    DoChange;
  end;
end;

procedure TCustomTextButtonObjectAppearance.SetWordWrap(const Value: Boolean);
begin
  if Value <> FWordWrap then
  begin
    FWordWrap := Value;
    DoChange;
  end;
end;

{ TCustomGlyphButtonObjectAppearance }

procedure TCustomGlyphButtonObjectAppearance.AssignTo(ADest: TPersistent);
var
  LObject: TListItemGlyphButton;
begin
  if ADest is TCustomGlyphButtonObjectAppearance then
  begin
    with TCustomGlyphButtonObjectAppearance(ADest) do
    begin
      BeginUpdate;
      try
        inherited AssignTo(ADest);
        ButtonType := Self.ButtonType;
        ClickOnSelect := Self.ClickOnSelect;
        Opacity := Self.Opacity;
        Enabled := Self.Enabled;
      finally
        EndUpdate;
      end;
    end;
  end
  else if ADest is TListItemGlyphButton then
  begin
    LObject := TListItemGlyphButton(ADest);
    LObject.BeginUpdate;
    try
      inherited AssignTo(ADest);
      LObject.ButtonType := Self.ButtonType;
      LObject.ClickOnSelect := Self.ClickOnSelect;
      LObject.Enabled := Self.Enabled;
      LObject.Opacity := Self.Opacity;
      LObject.OnClick := Self.OnControlClick;
      LObject.OnChange := Self.OnControlChange;
    finally
      LObject.EndUpdate;
    end;
  end

  else
    inherited;


end;

constructor TCustomGlyphButtonObjectAppearance.Create;
begin
  inherited;
  FName := TListViewItem.TObjectNames.GlyphButton;
  FEnabled := True;
end;

function TCustomGlyphButtonObjectAppearance.CreateDefaultValues: TObjectAppearance;
var
  LDefaults: TCustomGlyphButtonObjectAppearance;
begin
  LDefaults := TCustomGlyphButtonObjectAppearance.Create(True);
  InitDefaultValues(LDefaults);
  Result := LDefaults;
end;

procedure TCustomGlyphButtonObjectAppearance.CreateObject(
  const AListViewItem: TListViewItem);
var
  LItem: TListItemGlyphButton;
  LValue: TValue;
  LHandled: Boolean;
begin
  LItem := TListItemGlyphButton.Create(AListViewItem);
  LItem.BeginUpdate;
  try
    LItem.Name := FName;
    LItem.Assign(Self);
    if FName = TListViewItem.TObjectNames.GlyphButton then
    begin
      if AListViewItem.GetHasCheck then
        LItem.Checked := AListViewItem.FChecked;
    end
    else if AListViewItem.GetHasData(FName) then
    begin
      LHandled := False;
      LValue := AListViewItem.GetData(FName);
      FOwner.SetObjectData(AListViewItem, FName, LValue, LHandled);
      if not LHandled then
        LItem.Data := LValue;
    end;
  finally
    LItem.EndUpdate;
  end;
end;

function TCustomGlyphButtonObjectAppearance.GetDefaultValues: TCustomGlyphButtonObjectAppearance;
begin
  Result := inherited DefaultValues as TCustomGlyphButtonObjectAppearance;
end;

function TCustomGlyphButtonObjectAppearance.IsButtonTypeStored: Boolean;
begin
  if DefaultValues is TCustomGlyphButtonObjectAppearance then
    Result := ButtonType <> TCustomGlyphButtonObjectAppearance(DefaultValues).ButtonType
  else
    Result := ButtonType <> Low(TGlyphButtonType);

end;

function TCustomGlyphButtonObjectAppearance.IsEnabledStored: Boolean;
begin
  if DefaultValues is TCustomGlyphButtonObjectAppearance then
    Result := Enabled <> TCustomGlyphButtonObjectAppearance(DefaultValues).Enabled
  else
    Result := Enabled <> True;
end;

procedure TCustomGlyphButtonObjectAppearance.ResetObject(
  const AListViewItem: TListViewItem);
begin
  ResetObjectT<TListItemGlyphButton>(AListViewItem);
end;

function TCustomGlyphButtonObjectAppearance.IsClickOnSelectStored: Boolean;
begin
  if DefaultValues is TCustomGlyphButtonObjectAppearance then
    Result := ClickOnSelect <> TCustomGlyphButtonObjectAppearance(DefaultValues).ClickOnSelect
  else
    Result := ClickOnSelect <> False;
end;

procedure TCustomGlyphButtonObjectAppearance.DoControlClick(Sender: TObject);
begin
  if Assigned(FOnControlClick) then
    FOnControlClick(Self);
end;

procedure TCustomGlyphButtonObjectAppearance.DoControlChange(Sender: TObject);
begin
  if Assigned(FOnControlChange) then
    FOnControlChange(Self);
end;

procedure TCustomGlyphButtonObjectAppearance.SetClickOnSelect(const AValue: Boolean);
begin
  if AValue <> FClickOnSelect then
  begin
    FClickOnSelect := AValue;
    DoChange;
  end;
end;

procedure TCustomGlyphButtonObjectAppearance.SetButtonType(const Value: TGlyphButtonType);
begin
  if FButtonType <> Value then
  begin
    FButtonType := Value;
    DoChange;
  end;
end;

procedure TCustomGlyphButtonObjectAppearance.SetEnabled(const Value: Boolean);
begin
  if FEnabled <> Value then
  begin
    FEnabled := Value;
    DoChange;
  end;
end;


{ TCommonItemAppearance }

constructor TItemAppearanceObjects.Create;
begin
  inherited Create;
  FText := TTextObjectAppearance.Create;
  FText.DataMembers := TObjectAppearance.TDataMembers.Create(
    TObjectAppearance.TDataMember.Create(TListViewItem.TMemberNames.Text, TListViewItem.TMemberNames.Text));

  FDetail := TTextObjectAppearance.Create;
  FDetail.Name := TListViewItem.TObjectNames.Detail;
  FDetail.DataMembers := TObjectAppearance.TDataMembers.Create(
    TObjectAppearance.TDataMember.Create(TListViewItem.TMemberNames.Detail, TListViewItem.TMemberNames.Detail));

  FImage := TImageObjectAppearance.Create;
  FImage.DataMembers := TObjectAppearance.TDataMembers.Create(
    TObjectAppearance.TDataMember.Create(TListViewItem.TMemberNames.Bitmap, TListViewItem.TMemberNames.Bitmap));

  FAccessory := TAccessoryObjectAppearance.Create;

  FTextButton := TTextButtonObjectAppearance.Create;
  FTextButton.Name := TListViewItem.TObjectNames.TextButton;
  FTextButton.DataMembers := TObjectAppearance.TDataMembers.Create(
    TObjectAppearance.TDataMember.Create(TListViewItem.TMemberNames.ButtonText, TListViewItem.TMemberNames.ButtonText));

  FGlyphButton := TGlyphButtonObjectAppearance.Create;
  FGlyphButton.Name := TListViewItem.TObjectNames.GlyphButton;

  FHeight := DefaultHeight;

  FText.OnChange := ItemPropertyChange;
  FDetail.OnChange := ItemPropertyChange;
  FImage.OnChange := ItemPropertyChange;
  FAccessory.OnChange := ItemPropertyChange;
  FGlyphButton.OnChange := ItemPropertyChange;
  FTextButton.OnChange := ItemPropertyChange;

  FText.Owner := Self;
  FDetail.Owner := Self;
  FImage.Owner := Self;
  FAccessory.Owner := Self;
  FGlyphButton.Owner := Self;
  FTextButton.Owner := Self;

  FTextButton.OnControlClick := ItemControlClick;
  FGlyphButton.OnControlChange := ItemControlChange;  // Checked
  FGlyphButton.OnControlClick := ItemControlClick;

end;

function TItemAppearanceObjects.DefaultHeight: Integer;
begin
  Result := cDefaultHeight;
end;

destructor TItemAppearanceObjects.Destroy;
begin
  FObjects := nil;
  FPublishedObjects := nil;
  FText.Free;
  FDetail.Free;
  FImage.Free;
  FAccessory.Free;
  FTextButton.Free;
  FGlyphButton.Free;
  inherited;
end;

function TItemAppearanceObjects.GetHeight: Integer;
begin
  Result := FHeight;
end;

function TItemAppearanceObjects.GetObjects: TArray<TCommonObjectAppearance>;
begin
  Result := FObjects;
end;

function TItemAppearanceObjects.GetPublishedObjects: TArray<TCommonObjectAppearance>;
begin
  Result := FPublishedObjects;
end;

procedure TItemAppearanceObjects.AddObject(const AObjectAppearance: TCommonObjectAppearance; APublished: Boolean);
begin
  if APublished then
  begin
    SetLength(FPublishedObjects, Length(FPublishedObjects) + 1);
    FPublishedObjects[Length(FPublishedObjects)-1] := AObjectAppearance;
  end;
  SetLength(FObjects, Length(FObjects) + 1);
  FObjects[Length(FObjects)-1] := AObjectAppearance;
end;

procedure TItemAppearanceObjects.AssignTo(ADest: TPersistent);
begin
  if ADest is TItemAppearanceObjects then
  begin
    with TItemAppearanceObjects(ADest) do
    begin
      Text := Self.Text;
      Detail := Self.Detail;
      Image := Self.Image;
      Accessory := Self.Accessory;
      TextButton := Self.TextButton;
      GlyphButton := Self.GlyphButton;
    end;
  end
  else
    inherited;
end;


procedure TItemAppearanceObjects.SetAccessoryElement(const Value: TAccessoryObjectAppearance);
begin
  FAccessory.Assign(Value);
end;

procedure TItemAppearanceObjects.SetTextButtonElement(const Value: TTextButtonObjectAppearance);
begin
  FTextButton.Assign(Value);
end;

procedure TItemAppearanceObjects.SetGlyphButtonElement(const Value: TGlyphButtonObjectAppearance);
begin
  FGlyphButton.Assign(Value);
end;

procedure TItemAppearanceObjects.SetImageElement(const Value: TImageObjectAppearance);
begin
  FImage.Assign(Value);
end;

procedure TItemAppearanceObjects.SetTextElement(const Value: TTextObjectAppearance);
begin
  FText.Assign(Value);
end;

procedure TItemAppearanceObjects.SetDetailElement(const Value: TTextObjectAppearance);
begin
  FDetail.Assign(Value);
end;

procedure TItemAppearanceObjects.SetHeight(Value: Integer);
begin
  if FHeight <> Value then
  begin
    FHeight := Value;
    DoChangeHeight;
  end;
end;

{ TItemAppearanceProperties }

constructor TItemAppearanceProperties.Create(const AListView: TCustomListView; AType: TCustomListView.TAppearanceType);
begin
  FOwner := AListView;
  FAppearanceType := AType;
  case AType of
    TCustomListView.TAppearanceType.Item,
    TCustomListView.TAppearanceType.ItemEdit:
      FPurpose := TListItemPurpose.None;
    TCustomListView.TAppearanceType.Header:
      FPurpose := TListItemPurpose.Header;
    TCustomListView.TAppearanceType.Footer:
      FPurpose := TListItemPurpose.Footer;
  else
    Assert(False);
  end;
  if csDesigning in AListView.ComponentState then
    // Keep settings while designing
    FAppearanceCache := TObjectDictionary<TItemAppearanceObjectsClass, TItemAppearanceObjects>.Create([doOwnsValues]);
end;

destructor TItemAppearanceProperties.Destroy;
begin
  FAppearanceCache.Free;
  FAppearance.Free;
  inherited;
end;

procedure TItemAppearanceProperties.PropertiesChange(Sender: TObject);
begin
  DoChange;
end;

procedure TItemAppearanceProperties.PropertiesChangeHeight(Sender: TObject);
begin
  DoChangeHeight;
end;

function TItemAppearanceProperties.GetActive: Boolean;
begin
  Result := Objects <> nil;
  if Result then
  begin
    if Self = FOwner.FItemEditAppearanceProperties then
    begin
      if not FOwner.FEditMode then
        Result := False;
    end
    else if Self = FOwner.FItemAppearanceProperties then
    begin
      if FOwner.FEditMode and (FOwner.FItemEditAppearanceProperties.Objects <> nil) then
        Result := False;
    end;
  end;

end;

function TItemAppearanceProperties.GetAppearanceClassName: string;
begin
  if Assigned(FAppearanceClass) then
    Result := FAppearanceClass.ClassName
end;

function TItemAppearanceProperties.GetHeight: Integer;
begin
  if FAppearance <> nil then
    Result := Max(1, FAppearance.Height)
  else
    Result := cDefaultHeight;
end;

function TItemAppearanceProperties.IsHeightStored: Boolean;
begin
  Result := (Objects <> nil) and (Objects.DefaultHeight <> Objects.Height);
end;

procedure TItemAppearanceProperties.SetHeight(AValue: Integer);
begin
  if FAppearance <> nil then
    FAppearance.Height := AValue;
end;

procedure TItemAppearanceProperties.SetObjects(
  const Value: TItemAppearanceObjects);
begin
  if Value = nil then
    AppearanceClassName := ''
  else
  begin
    AppearanceClassName := Value.ClassName;
    if FAppearance <> nil then
      FAppearance.Assign(Value);
  end;
end;

procedure TItemAppearanceProperties.SetName(const Value: string);
var
  LFactory: TItemAppearanceObjectsClass;
  LPair: TPair<TItemAppearanceObjectsClass, TRegisterAppearanceValue>;
begin
  LFactory := nil;
  if Value = TCustomListView.TAppearanceNames.Empty then
    LFactory := TEmptyItemObjects
  else if Value = TCustomListView.TAppearanceNames.Null  then
    LFactory := TNullItemObjects;
  if LFactory = nil then
    // Look for display name
    for LPair in FFactories do
    begin
      if SameText(LPair.Value.Name, Value) then
      begin
        LFactory := LPair.Key;
        break;
      end;
    end;

  Assert((LFactory <> nil));
  if LFactory <> nil then
    AppearanceClass := LFactory  // sets FName
  else
    AppearanceClass := TEmptyItemObjects;  // sets FName
end;

procedure TItemAppearanceProperties.SetAppearanceClassName(const Value: string);
var
  LFactory: TItemAppearanceObjectsClass;
  LPair: TPair<TItemAppearanceObjectsClass, TRegisterAppearanceValue>;
begin
  LFactory := nil;
  // Look for class name
  for LPair in FFactories do
  begin
    if SameText(LPair.Key.ClassName, Value) then
    begin
      LFactory := LPair.Key;
      break;
    end;
  end;
  if LFactory <> nil then
    AppearanceClass := LFactory  // Sets FName
  else
    AppearanceClass := TEmptyItemObjects;  // Sets FName
end;

procedure TItemAppearanceProperties.DoChange;
begin
  FOwner.ItemAppearanceChange(Self);
end;

procedure TItemAppearanceProperties.DoChangeObjects;
begin
  FOwner.ItemAppearanceChangeObjects(Self);
end;

procedure TItemAppearanceProperties.DoChangeHeight;
begin
  FOwner.ItemAppearanceChangeHeight(Self);
end;

procedure TItemAppearanceProperties.SetAppearanceClass(
  const Value: TItemAppearanceObjectsClass);
var
  LPair: TPair<TItemAppearanceObjectsClass, TRegisterAppearanceValue>;
  LAppearance: TItemAppearanceObjects;
begin
  if Value <> FAppearanceClass then
  begin
    FName := '';
    if FAppearance <> nil then
    begin
      FAppearance.FOwner := Self.Owner;
      FAppearance.OnChange := nil;
      FAppearance.OnChangeHeight := nil;
      if FAppearanceCache <> nil then
      begin
        FAppearanceCache.Remove(TItemAppearanceObjectsClass(FAppearance.ClassType));
        FAppearanceCache.AddOrSetValue(TItemAppearanceObjectsClass(FAppearance.ClassType), FAppearance);
        FAppearance := nil;
      end
      else
        FreeAndNil(FAppearance);
    end;

    FAppearanceClass := Value;
    FName := '';
    if FAppearanceClass <> nil then
    begin
      // Update FName
      for LPair in FFactories do
        if LPair.Key = FAppearanceClass then
        begin
          FName := LPair.Value.Name;
          break;
        end;
      Assert(FAppearance = nil);
      FAppearance := FAppearanceClass.Create;
      FAppearance.Owner := Self.Owner;
      if FAppearanceCache <> nil then
        if FAppearanceCache.TryGetValue(FAppearanceClass, LAppearance) then
          FAppearance.Assign(LAppearance);
      FAppearance.OnChange := PropertiesChange;
      FAppearance.OnChangeHeight := PropertiesChangeHeight;
    end;
    DoChangeObjects;
  end;
end;


{ TAppearanceObjectsBase }

procedure TAppearanceObjects.AssignTo(ADest: TPersistent);
begin
  if ADest is TAppearanceObjects then
  begin
    // Support this assignment
  end
  else
    inherited;
end;

procedure TAppearanceObjects.BeginUpdate;
begin
  if FOwner <> nil then
    FOwner.BeginAppearanceUpdate;
end;

constructor TAppearanceObjects.Create;
begin
  inherited;
end;

procedure TAppearanceObjects.ResetObjects(const AListViewItem: TListViewItem);
begin
  // Do nothing
end;

function TAppearanceObjects.DefaultHeight: Integer;
begin
  Result := cDefaultHeight;
end;

procedure TAppearanceObjects.DoChange;
begin
  if Assigned(OnChange) then
    OnChange(Self);
end;

procedure TAppearanceObjects.DoButtonClick(const AControl: TListItemSimpleControl);
begin
  if Assigned(FOwner) then
    FOwner.DoButtonClick(AControl);
end;

procedure TAppearanceObjects.DoButtonChange(const AControl: TListItemGlyphButton);
begin
  if Assigned(FOwner) then
    FOwner.DoButtonChange(AControl);
end;

procedure TAppearanceObjects.DoChangeHeight;
begin
  if Assigned(FOnChangeHeight) then
    FOnChangeHeight(Self);
end;

procedure TAppearanceObjects.EndUpdate;
begin
  if FOwner <> nil then
    FOwner.EndAppearanceUpdate;
end;

function TAppearanceObjects.GetHeight: Integer;
begin
  Result := cDefaultHeight;
end;

function TAppearanceObjects.GetPublishedObjects: TArray<TCommonObjectAppearance>;
begin
  Result := nil;
end;

function TAppearanceObjects.GetObjects: TArray<TCommonObjectAppearance>;
begin
  Result := nil;
end;

procedure TAppearanceObjects.ItemPropertyChange(Sender: TObject);
begin
  DoChange;
end;

procedure TAppearanceObjects.ItemControlClick(Sender: TObject);
begin
  Assert(Sender is TListItemSimpleControl);
  if Sender is TListItemSimpleControl then
    DoButtonClick(TListItemSimpleControl(Sender));
end;

procedure TAppearanceObjects.ItemControlChange(Sender: TObject);
begin
  Assert(Sender is TListItemGlyphButton);
  if Sender is TListItemGlyphButton then
    DoButtonChange(TListItemGlyphButton(Sender));
end;


procedure TAppearanceObjects.SetHeight(Value: Integer);
begin
//
end;

procedure TAppearanceObjects.SetObjectData(const AListViewItem: TListViewItem; const AIndex: string;
  const AValue: TValue; var AHandled: Boolean);
begin
  // Do nothing
end;

procedure TAppearanceObjects.UpdateSizes;
begin
  // Do nothing
end;


{ TCustomItemObjects }

constructor TCustomItemObjects.Create;
  procedure SetTextDefaults(const AText: TTextObjectAppearance);
  begin
    AText.DefaultValues.Align := TListItemAlign.Leading;
    AText.DefaultValues.TextVertAlign := TTextAlign.taCenter;
    AText.DefaultValues.TextAlign := TTextAlign.taLeading;
    AText.DefaultValues.Trimming := TTextTrimming.ttCharacter;
  end;

begin
  inherited;

  GlyphButton.DefaultValues.Align := TListItemAlign.Leading;
  GlyphButton.DefaultValues.VertAlign := TListItemAlign.Center;
  GlyphButton.DefaultValues.ButtonType := TGlyphButtonType.Checkbox;
  GlyphButton.DefaultValues.Visible := False;
  GlyphButton.RestoreDefaults;

  SetTextDefaults(Text);
  Text.DefaultValues.Visible := True;
  Text.RestoreDefaults;

  SetTextDefaults(Detail);
  Detail.DefaultValues.Visible := False;
  Detail.DefaultValues.IsDetailText := True;
  Detail.RestoreDefaults;

  TextButton.DefaultValues.Align := TListItemAlign.Trailing;
  TextButton.DefaultValues.VertAlign := TListItemAlign.Center;
  TextButton.DefaultValues.ButtonType := TTextButtonType.Normal;
  TextButton.DefaultValues.Trimming := TTextTrimming.ttCharacter;
  TextButton.DefaultValues.Width := cDefaultTextButtonWidth;
  TextButton.DefaultValues.Visible := False;
  TextButton.RestoreDefaults;

  Accessory.DefaultValues.Align := TListItemAlign.Trailing;
  Accessory.DefaultValues.VertAlign := TListItemAlign.Center;
  Accessory.DefaultValues.AccessoryType := TAccessoryType.More;
  Accessory.DefaultValues.Visible := False;
  Accessory.RestoreDefaults;

  Image.DefaultValues.Width := cDefaultImageWidth;
  Image.DefaultValues.Height := cDefaultImageHeight;
  Image.DefaultValues.VertAlign := TListItemAlign.Center;
  Image.DefaultValues.Visible := False;
  Image.RestoreDefaults;

  Height := DefaultHeight;
end;

procedure TCustomItemObjects.SetInternalSize(const AAccessory: TAccessoryObjectAppearance;
  AStyleResources: TListItemStyleResources);
var
  LWidth: Single;
  LHeight: Single;
const
  cDefaultHeightNoStyle = 30;  // when no style
  cDefaultWidthNoStyle = 30;
begin
  LWidth := cDefaultWidthNoStyle;
  LHeight := cDefaultHeightNoStyle;
  if AStyleResources <> nil then
    if AStyleResources.AccessoryImages[AAccessory.AccessoryType].Normal <> nil then
    begin
      LWidth := AStyleResources.AccessoryImages[AAccessory.AccessoryType].Normal.Width;
      LHeight := AStyleResources.AccessoryImages[AAccessory.AccessoryType].Normal.Height;
    end;
  AAccessory.InternalWidth := LWidth;
  AAccessory.InternalHeight := LHeight;
end;

function TCustomItemObjects.GetStyleResources: TListItemStyleResources;
begin
  Result := Owner.GetStyleResources;
end;

procedure TCustomItemObjects.SetInternalSize(const AGlyphButton: TGlyphButtonObjectAppearance;
  AStyleResources: TListItemStyleResources);
const
  cDefaultHeightNoStyle = 30;  // when no style
  cDefaultWidthNoStyle = 30;
var
  LWidth: Single;
  LHeight: Single;
begin
  LWidth := cDefaultWidthNoStyle;
  LHeight := cDefaultHeightNoStyle;
  if AStyleResources <> nil then
    case AGlyphButton.ButtonType of
      TGlyphButtonType.Add:
        if AStyleResources.ButtonAddItemStyleImage.Normal <> nil then
        begin
          LWidth := AStyleResources.ButtonAddItemStyleImage.Normal.Width;
          LHeight := AStyleResources.ButtonAddItemStyleImage.Normal.Height;
        end;
      TGlyphButtonType.Delete:
        if AStyleResources.ButtonDeleteItemStyleImage.Normal <> nil then
        begin
          LWidth := AStyleResources.ButtonDeleteItemStyleImage.Normal.Width;
          LHeight := AStyleResources.ButtonDeleteItemStyleImage.Normal.Height;
        end;
      TGlyphButtonType.Checkbox:
        if AStyleResources.ButtonCheckboxStyleImage.Normal <> nil then
        begin
          LWidth := AStyleResources.ButtonCheckboxStyleImage.Normal.Width;
          LHeight := AStyleResources.ButtonCheckboxStyleImage.Normal.Height;
        end;
    end;
  AGlyphButton.InternalWidth := LWidth;
  AGlyphButton.InternalHeight := LHeight;
end;

procedure TCustomItemObjects.UpdateSizes;
var
  LStyleResources: TListItemStyleResources;
begin
  BeginUpdate;
  try
    LStyleResources := GetStyleResources;

    SetInternalSize(Accessory, LStyleResources);
    SetInternalSize(GlyphButton, LStyleResources);

    if GlyphButton.Align = TListItemAlign.Leading then
      GlyphButton.InternalPlaceOffset.X := cDefaultGlyphPlaceOffsetX;

    TextButton.InternalHeight := cDefaultButtonHeight;
  finally
    EndUpdate;
  end;
end;


function TCustomItemObjects.DefaultHeight: Integer;
begin
  Result := cDefaultHeight;
end;

{ TEmptyItemObjects }

constructor TEmptyItemObjects.Create;
begin
  inherited Create;
  FHeight := DefaultHeight;
end;


function TEmptyItemObjects.DefaultHeight: Integer;
begin
  Result := cDefaultHeight;
end;

function TEmptyItemObjects.GetHeight: Integer;
begin
  Result := FHeight;
end;

procedure TEmptyItemObjects.SetHeight(Value: Integer);
begin
  if FHeight <> Value then
  begin
    FHeight := Value;
    DoChangeHeight;
  end;
end;

{ TPresetItemObjects }

function TPresetItemObjects.GetGroupClass: TGroupClass;
begin
  Result := nil;
end;

function TPresetItemObjects.GetIsItemEdit: Boolean;
var
  LAppearance: TCustomListView.TRegisteredAppearance;
begin
  Result := False;
  for LAppearance in TCustomListView.GetRegisteredAppearances do
    if LAppearance.Value = Self.ClassType then
    begin
      Result :=  TCustomListView.TRegisterAppearanceOption.ItemEdit in LAppearance.Options;
      break;
    end;
end;

procedure TPresetItemObjects.ResetObjects(const AListViewItem: TListViewItem);
var
  LObjectAppearance: TCommonObjectAppearance;
  LGroupClass: TGroupClass;
begin
  BeginUpdate;
  try
    UpdateSizes;  // May change properties of appearance
    LGroupClass := GroupClass;
    if Assigned(LGroupClass) and
     (AListViewItem.Objects.FAppearance <> nil) and
      AListViewItem.Objects.FAppearance.InheritsFrom(LGroupClass) then
    begin
      for LObjectAppearance in GetObjects do
        // Change properties of rendering objects
        LObjectAppearance.ResetObject(AListViewItem);
    end
    else
    begin
      AListViewItem.Objects.Clear;
      for LObjectAppearance in GetObjects do
        // create rendering objects and set properties
        LObjectAppearance.CreateObject(AListViewItem);
    end;
  finally
    EndUpdate;
  end;
  AListViewItem.Objects.FAppearance := Self;
end;


{ TRegisterAppearanceValue }

constructor TRegisterAppearanceValue.Create(const AName: string;
  AOptions: TCustomListView.TRegisterAppearanceOptions;
  const AUnitName: string);
begin
  Name := AName;
  UnitName := AUnitName;
  Options := AOptions;
end;

type
  // Preset appearance classes

  TPresetBase = class(TPresetItemObjects)
  const
    cTextMarginAccessory = 8;
    cTextMarginDetail = 8;
    cTextMarginTextButton = 8;
  private
    FGroupClass: TPresetItemObjects.TGroupClass;
    FIsItemEdit: Boolean;
  protected
    function GetGroupClass: TPresetItemObjects.TGroupClass; override;
    function GetIsItemEdit: Boolean; override;
  end;

  TCustomizeItemObjects = class(TPresetBase)
  public
    constructor Create; override;
  published
    property Text;
    property Detail;
    property Image;
    property Accessory;
    property TextButton;
    property GlyphButton;
  end;

  TListHeaderObjects = class(TPresetBase)
  private const
    cDefaultHeaderHeight = TItemAppearanceObjects.cDefaultHeaderHeight;
  protected
    procedure UpdateSizes; override;
    function DefaultHeight: Integer; override;
  public
    constructor Create; override;
  published
    property Text;
  end;

  TListItemAppearance = class(TPresetBase)
  protected
    procedure UpdateSizes; override;
  public
    constructor Create; override;
  published
    property Text;
    property Accessory;
  end;

  TListItemDeleteAppearance = class(TListItemAppearance)
  private const
    cDefaultGlyph = TGlyphButtonType.Delete;
  public
    constructor Create; override;
  published
    property GlyphButton;
  end;

  TListItemShowCheckAppearance = class(TListItemAppearance)
  private const
    cDefaultGlyph = TGlyphButtonType.Checkbox;
  public
    constructor Create; override;
  published
    property GlyphButton;
  end;


  TListItemRightDetailAppearance = class(TPresetBase)
  protected
    procedure UpdateSizes; override;
  public
    constructor Create; override;
  published
    property Text;
    property Accessory;
    property Detail;
  end;

  TListItemRightDetailDeleteAppearance = class(TListItemRightDetailAppearance)
  private const
    cDefaultGlyph = TGlyphButtonType.Delete;
  public
    constructor Create; override;
  published
    property GlyphButton;
  end;

  TListItemRightDetailShowCheckAppearance = class(TListItemRightDetailAppearance)
  private const
    cDefaultGlyph = TGlyphButtonType.Checkbox;
  public
    constructor Create; override;
  published
    property GlyphButton;
  end;

  TImageListItemAppearance = class(TPresetBase)
  public const
    cDefaultImagePlaceOffsetX = -3;
    cDefaultImageTextPlaceOffsetX = 4;
  protected
    procedure UpdateSizes; override;
  public
    constructor Create; override;
  published
    property Text;
    property Accessory;
    property Image;
  end;

  TImageListItemDeleteAppearance = class(TImageListItemAppearance)
  private const
    cDefaultGlyph = TGlyphButtonType.Delete;
  public
    constructor Create; override;
  published
    property GlyphButton;
  end;

  TImageListItemShowCheck = class(TImageListItemAppearance)
  private const
    cDefaultGlyph = TGlyphButtonType.Checkbox;
  public
    constructor Create; override;
  published
    property GlyphButton;
  end;

  TImageListItemRightButtonAppearance = class(TPresetBase)
  protected
    procedure UpdateSizes; override;
  public
    constructor Create; override;
  published
    property Text;
    property TextButton;
    property Image;
  end;

  TImageListItemRightButtonDeleteAppearance = class(TImageListItemRightButtonAppearance)
  private const
    cDefaultGlyph = TGlyphButtonType.Delete;
  public
    constructor Create; override;
  published
    property GlyphButton;
  end;

  TImageListItemRightButtonShowCheckAppearance = class(TImageListItemRightButtonAppearance)
  private const
    cDefaultGlyph = TGlyphButtonType.Checkbox;
  public
    constructor Create; override;
  published
    property GlyphButton;
  end;

{ TPresetBase }

function TPresetBase.GetGroupClass: TPresetItemObjects.TGroupClass;
begin
  Assert(FGroupClass <> nil);
  Result := FGroupClass;
end;

function TPresetBase.GetIsItemEdit: Boolean;
begin
  Result := FIsItemEdit;
end;

{ TListItemAppearance }

constructor TListItemAppearance.Create;
begin
  FGroupClass := TListItemAppearance;
  inherited;
  Text.DefaultValues.Visible := True;
  Text.RestoreDefaults;
  Accessory.DefaultValues.Visible := not IsItemEdit;
  Accessory.RestoreDefaults;
  AddObject(Text, True);
  AddObject(Accessory, True);
  AddObject(GlyphButton, IsItemEdit);
end;

procedure TListItemAppearance.UpdateSizes;
var
  LOuterWidth: Single;
  LInternalWidth: Single;
begin
  BeginUpdate;
  try
    inherited;
    Assert(Owner <> nil);
    if Owner <> nil then
    begin
      LOuterWidth := Owner.Width - Owner.ItemSpaces.Left - Owner.ItemSpaces.Right;
      Text.InternalPlaceOffset.X := GlyphButton.ActualWidth;
      LInternalWidth := LOuterWidth - Text.ActualPlaceOffset.X - Accessory.ActualWidth;
      if Accessory.ActualWidth > 0 then
        LInternalWidth := LInternalWidth - cTextMarginAccessory;
      Text.InternalWidth := Max(1, LInternalWidth);
    end;
  finally
    EndUpdate;
  end;
end;

constructor TListItemDeleteAppearance.Create;
begin
  FIsItemEdit := True;
  inherited;
  GlyphButton.DefaultValues.ButtonType := cDefaultGlyph;
  GlyphButton.DefaultValues.Visible := True;
  GlyphButton.RestoreDefaults;
end;

constructor TListItemShowCheckAppearance.Create;
begin
  FIsItemEdit := True;
  inherited;
  GlyphButton.DefaultValues.ButtonType := cDefaultGlyph;
  GlyphButton.DefaultValues.Visible := True;
  GlyphButton.RestoreDefaults;
end;

{ TListItemRightDetailAppearance }

constructor TListItemRightDetailAppearance.Create;
begin
  FGroupClass := TListItemRightDetailAppearance;
  inherited;
  Text.DefaultValues.Visible := True;
  Text.RestoreDefaults;
  Detail.DefaultValues.Visible := True;
  Detail.DefaultValues.Align := TListItemAlign.Trailing;
  Detail.DefaultValues.TextAlign := TTextAlign.taTrailing;
  Detail.RestoreDefaults;
  Accessory.DefaultValues.Visible := not IsItemEdit;
  Accessory.RestoreDefaults;
  AddObject(Text, True);
  AddObject(Detail, True);
  AddObject(Accessory, True);
  AddObject(GlyphButton, IsItemEdit);
end;

procedure TListItemRightDetailAppearance.UpdateSizes;
var
  LOuterWidth: Single;
  LInternalWidth: Single;
begin
  BeginUpdate;
  try
    inherited;
    if Owner <> nil then
    begin
      LOuterWidth := Owner.Width - Owner.ItemSpaces.Left - Owner.ItemSpaces.Right;
      Text.InternalPlaceOffset.X := GlyphButton.ActualWidth;
      Text.InternalWidth := LOuterWidth * 0.6; // Portion of total width
      if Detail.Align = TListItemAlign.Trailing then
      begin
        if Accessory.ActualWidth > 0 then
          Detail.InternalPlaceOffset.X := -1 * (Accessory.ActualWidth + cTextMarginAccessory)
        else
          Detail.InternalPlaceOffset.X := 0;
        LInternalWidth := LOuterWidth - (Text.ActualPlaceOffset.X + Text.ActualWidth)
          + Detail.ActualPlaceOffset.X - cTextMarginDetail;
      end
      else
      begin
        Detail.InternalPlaceOffset.X := Text.ActualPlaceOffset.X + Text.ActualWidth + cTextMarginDetail;
        LInternalWidth := LOuterWidth - Detail.ActualPlaceOffset.X - Accessory.ActualWidth;
      end;
      if Accessory.ActualWidth > 0 then
        LInternalWidth := LInternalWidth - cTextMarginAccessory;
      Detail.InternalWidth := Max(1, LInternalWidth);
    end;
  finally
    EndUpdate;
  end;
end;

constructor TListItemRightDetailShowCheckAppearance.Create;
begin
  FIsItemEdit := True;
  inherited;
  GlyphButton.DefaultValues.ButtonType := cDefaultGlyph;
  GlyphButton.DefaultValues.Visible := True;
  GlyphButton.RestoreDefaults;
end;

constructor TListItemRightDetailDeleteAppearance.Create;
begin
  FIsItemEdit := True;
  inherited;
  GlyphButton.DefaultValues.ButtonType := cDefaultGlyph;
  GlyphButton.DefaultValues.Visible := True;
  GlyphButton.RestoreDefaults;
end;

{ TImageListItemAppearance }

constructor TImageListItemAppearance.Create;
begin
  FGroupClass := TImageListItemAppearance;
  inherited;
  Text.DefaultValues.Visible := True;
  Text.RestoreDefaults;
  Image.DefaultValues.Visible := True;
  Image.RestoreDefaults;
  Accessory.DefaultValues.Visible := not IsItemEdit;
  Accessory.RestoreDefaults;
  AddObject(Text, True);
  AddObject(Image, True);
  AddObject(Accessory, True);
  AddObject(GlyphButton, IsItemEdit);
end;

procedure TImageListItemAppearance.UpdateSizes;
var
  LOuterWidth: Single;
  LImagePlaceOffset: Single;
  LImageTextPlaceOffset: Single;
  LInternalWidth: Single;
begin
  BeginUpdate;
  try
    inherited;
    Assert(Owner <> nil);
    if Owner <> nil then
    begin
      LOuterWidth := Owner.Width - Owner.ItemSpaces.Left - Owner.ItemSpaces.Right;
      if Image.ActualWidth = 0 then
      begin
        LImagePlaceOffset := 0;
        LImageTextPlaceOffset := 0;
      end
      else
      begin
        LImagePlaceOffset := cDefaultImagePlaceOffsetX;
        LImageTextPlaceOffset := cDefaultImageTextPlaceOffsetX;
      end;
      Image.InternalPlaceOffset.X := GlyphButton.ActualWidth + LImagePlaceOffset;
      if Image.ActualWidth > 0 then
        Text.InternalPlaceOffset.X :=
          Image.ActualPlaceOffset.X +  Image.ActualWidth + LImageTextPlaceOffset
      else
        Text.InternalPlaceOffset.X :=
          0 + GlyphButton.ActualWidth;
      LInternalWidth := LOuterWidth - Text.ActualPlaceOffset.X - Accessory.ActualWidth;
      if Accessory.ActualWidth > 0 then
        LInternalWidth := LInternalWidth - cTextMarginAccessory;
      Text.InternalWidth := Max(1, LInternalWidth);
    end;
  finally
    EndUpdate;
  end;
end;

constructor TImageListItemShowCheck.Create;
begin
  FIsItemEdit := True;
  inherited;
  GlyphButton.DefaultValues.ButtonType := cDefaultGlyph;
  GlyphButton.DefaultValues.Visible := True;
  GlyphButton.RestoreDefaults;
end;

constructor TImageListItemDeleteAppearance.Create;
begin
  FIsItemEdit := True;
  inherited;
  GlyphButton.DefaultValues.ButtonType := cDefaultGlyph;
  GlyphButton.DefaultValues.Visible := True;
  GlyphButton.RestoreDefaults;
end;

{ TImageListItemRightButtonAppearance }

constructor TImageListItemRightButtonAppearance.Create;
begin
  FGroupClass := TImageListItemRightButtonAppearance;
  inherited;
  Text.DefaultValues.Visible := True;
  Text.RestoreDefaults;
  Image.DefaultValues.Visible := True;
  Image.RestoreDefaults;
  TextButton.DefaultValues.Visible := True;
  TextButton.RestoreDefaults;
  AddObject(Text, True);
  AddObject(Image, True);
  AddObject(TextButton, True);
  AddObject(GlyphButton, IsItemEdit);
end;

procedure TImageListItemRightButtonAppearance.UpdateSizes;
var
  LOuterWidth: Single;
  LImagePlaceOffset: Single;
  LImageTextPlaceOffset: Single;
  LInternalWidth: Single;
begin
  BeginUpdate;
  try
    inherited;
    Assert(Owner <> nil);
    if Owner <> nil then
    begin
      LOuterWidth := Owner.Width - Owner.ItemSpaces.Left - Owner.ItemSpaces.Right;
      if Image.ActualWidth = 0 then
      begin
        LImagePlaceOffset := 0;
        LImageTextPlaceOffset := 0;
      end
      else
      begin
        LImagePlaceOffset := TImageListItemAppearance.cDefaultImagePlaceOffsetX;
        LImageTextPlaceOffset := TImageListItemAppearance.cDefaultImageTextPlaceOffsetX;
      end;
      Image.InternalPlaceOffset.X := GlyphButton.ActualWidth + LImagePlaceOffset;
      Text.InternalPlaceOffset.X :=
        Image.ActualPlaceOffset.X +  Image.ActualWidth + LImageTextPlaceOffset;
      LInternalWidth :=
        LOuterWidth - Text.ActualPlaceOffset.X - TextButton.ActualWidth;
      if TextButton.ActualWidth > 0 then
        LInternalWidth := LInternalWidth - cTextMarginTextButton;
      Text.InternalWidth := Max(1, LInternalWidth);
    end;
  finally
    EndUpdate;
  end;
end;

constructor TImageListItemRightButtonShowCheckAppearance.Create;
begin
  FIsItemEdit := True;
  inherited;
  GlyphButton.DefaultValues.ButtonType := cDefaultGlyph;
  GlyphButton.DefaultValues.Visible := True;
  GlyphButton.RestoreDefaults;
end;

constructor TImageListItemRightButtonDeleteAppearance.Create;
begin
  FIsItemEdit := True;
  inherited;
  GlyphButton.DefaultValues.ButtonType := cDefaultGlyph;
  GlyphButton.DefaultValues.Visible := True;
  GlyphButton.RestoreDefaults;
end;

{ TCustomizeItemObjects }

constructor TCustomizeItemObjects.Create;
begin
  inherited;
  FGroupClass := TCustomizeItemObjects;
  AddObject(GlyphButton, False);
  AddObject(Text, True);
  AddObject(Detail, True);
  AddObject(Image, True);
  AddObject(Accessory, False);
  AddObject(TextButton, False);
end;

{ TListHeaderObjects }

constructor TListHeaderObjects.Create;
begin
  inherited;
  FGroupClass := TListHeaderObjects;
  Text.DefaultValues.Visible := True;
  Text.RestoreDefaults;
  AddObject(Text, True);
end;

function TListHeaderObjects.DefaultHeight: Integer;
begin
  Result := cDefaultHeaderHeight;
end;

procedure TListHeaderObjects.UpdateSizes;
var
  LOuterWidth: Single;
begin
  BeginUpdate;
  try
    inherited;
    Assert(Owner <> nil);
    if Owner <> nil then
    begin
      LOuterWidth := Owner.Width - Owner.ItemSpaces.Left - Owner.ItemSpaces.Right;
      Text.InternalWidth := LOuterWidth;
    end;
  finally
    EndUpdate;
  end;
end;

type
  TAppearanceNames = TCustomListView.TAppearanceNames;
  TOption = TCustomListView.TRegisterAppearanceOption;

initialization
  RegisterFmxClasses([TCustomListView, TListView]);
  FFactories := TDictionary<TCustomListView.TItemAppearanceObjectsClass, TRegisterAppearanceValue>.Create;
  // Register appearances
  TCustomListView.RegisterAppearance(TEmptyItemObjects, TAppearanceNames.Empty);
  TCustomListView.RegisterAppearance(TCustomizeItemObjects, TAppearanceNames.Custom,
  [TOption.Item, TOption.ItemEdit, TOption.Footer, TOption.Header]);

  // ListItem group
  TCustomListView.RegisterAppearance(
    TListItemAppearance, TAppearanceNames.ListItem,
    [TOption.Item, TOption.DefaultItem]);
  TCustomListView.RegisterAppearance(
    TListItemDeleteAppearance, TAppearanceNames.ListItemDelete,
    [TOption.ItemEdit]);
  TCustomListView.RegisterAppearance(
    TListItemShowCheckAppearance, TAppearanceNames.ListItemShowCheck,
    [TOption.ItemEdit, TOption.DefaultItemEdit]);

  // ListItemRightDetail group
  TCustomListView.RegisterAppearance(
    TListItemRightDetailAppearance, TAppearanceNames.ListItemRightDetail,
    [TOption.Item]);
  TCustomListView.RegisterAppearance(
    TListItemRightDetailDeleteAppearance, TAppearanceNames.ListItemRightDetailDelete,
    [TOption.ItemEdit]);
  TCustomListView.RegisterAppearance(
    TListItemRightDetailShowCheckAppearance, TAppearanceNames.ListItemRightDetailShowCheck,
    [TOption.ItemEdit]);

  // ImageListItem group
  TCustomListView.RegisterAppearance(
    TImageListItemAppearance, TAppearanceNames.ImageListItem,
    [TOption.Item]);
  TCustomListView.RegisterAppearance(
    TImageListItemDeleteAppearance, TAppearanceNames.ImageListItemDelete,
    [TOption.ItemEdit]);
  TCustomListView.RegisterAppearance(
    TImageListItemShowCheck, TAppearanceNames.ImageListItemShowCheck,
    [TOption.ItemEdit]);

  // ImageListItemRightButton group
  TCustomListView.RegisterAppearance(
    TImageListItemRightButtonAppearance, TAppearanceNames.ImageListItemRightButton,
    [TOption.Item]);
  TCustomListView.RegisterAppearance(
    TImageListItemRightButtonDeleteAppearance, TAppearanceNames.ImageListItemRightButtonDelete,
    [TOption.ItemEdit]);
  TCustomListView.RegisterAppearance(
    TImageListItemRightButtonShowCheckAppearance, TAppearanceNames.ImageListItemRightButtonShowCheck,
    [TOption.ItemEdit]);


  TCustomListView.RegisterAppearance(TListHeaderObjects, TAppearanceNames.ListHeader,
    [
    TCustomListView.TRegisterAppearanceOption.Header,
    TCustomListView.TRegisterAppearanceOption.Footer,
    TCustomListView.TRegisterAppearanceOption.DefaultHeader,
    TCustomListView.TRegisterAppearanceOption.DefaultFooter]
    );  // Default
finalization
  FFactories.Free;
end.
