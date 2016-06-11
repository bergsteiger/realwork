{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.ListView.Appearances;

{$SCOPEDENUMS ON}

interface

uses
  System.Classes, System.Generics.Collections, System.SysUtils, System.Generics.Defaults, System.Rtti,
  FMX.Types, FMX.ListView.Types, FMX.ListView.Adapters.Base, FMX.Graphics, System.Types, FMX.TextLayout,
  System.UITypes, FMX.Controls, FMX.Utils;

type
  TItemControlEvent = procedure(const Sender: TObject; const AItem: TListItem; const AObject: TListItemSimpleControl) of object;

  TListViewItem = class;
  TItemAppearanceProperties = class;
  TPublishedObjects = class;

  /// <summary>An extension of TListView that uses appearance-based items.
  /// </summary>
  IAppearanceItemOwner = interface
    ['{A3CAF8E2-ECD5-4989-9B03-B3E79B02DFBC}']
    /// <summary>Return array of TItemAppearanceProperties specific for this ListView.
    /// The array includes appearances for various item purposes and state, namely
    /// Item, ItemEdit, Header and Footer.
    /// </summary>
    function GetAppearanceProperties: TArray<TItemAppearanceProperties>;
    /// <summary>Begin control update. Uses the same semantics as TControl.BeginUpdate</summary>
    procedure BeginUpdate;
    /// <summary>End  control update. Uses the same semantics as TControl.EndUpdate</summary>
    procedure EndUpdate;
  end;

  /// <summary>Interface from TPublishedAppearance and TItemAppearanceProperties
  /// to its owner (TAppearanceListView).</summary>
  IPublishedAppearanceOwner = interface
    ['{990AB866-92AB-4552-BB12-223F44CFD062}']
    /// <summary>Notify the owner of appearance change</summary>
    procedure ItemAppearanceChange(const Sender: TItemAppearanceProperties);
    /// <summary>Notify the owner of appearance view change</summary>
    procedure ItemAppearanceChangeObjects(const Sender: TItemAppearanceProperties);
    /// <summary>Notify the owner of appearance height change</summary>
    procedure ItemAppearanceChangeHeight(const Sender: TItemAppearanceProperties);
    /// <summary>Query owner if it's currently in edit mode</summary>
    function IsEditMode: Boolean;
    /// <summary>Get header height</summary>
    function GetHeaderHeight: Integer;
    /// <summary>Set header height</summary>
    procedure SetHeaderHeight(const Value: Integer);
    /// <summary>Get footer height</summary>
    function GetFooterHeight: Integer;
    /// <summary>Set footer height</summary>
    procedure SetFooterHeight(const Value: Integer);
    /// <summary>Get regular item height</summary>
    function GetItemHeight: Integer;
    /// <summary>Set regular item height</summary>
    procedure SetItemHeight(const Value: Integer);
    /// <summary>Get regular item edit mode height</summary>
    function GetItemEditHeight: Integer;
    /// <summary>Set regular item edit mode height</summary>
    procedure SetItemEditHeight(const Value: Integer);

    /// <summary>Get footer apperance name</summary>
    function GetFooterAppearanceName: string;
    /// <summary>Set footer apperance name</summary>
    procedure SetFooterAppearanceName(const Value: string);
    /// <summary>Get header appearance name</summary>
    function GetHeaderAppearanceName: string;
    /// <summary>Set header appearance name</summary>
    procedure SetHeaderAppearanceName(const Value: string);
    /// <summary>Get regular item appearance name</summary>
    function GetItemAppearanceName: string;
    /// <summary>Set regular item appearance name</summary>
    procedure SetItemAppearanceName(const Value: string);
    /// <summary>Get regular item appearance name in edit mode</summary>
    function GetItemEditAppearanceName: string;
    /// <summary>Set regular item appearance name in edit mode</summary>
    procedure SetItemEditAppearanceName(const Value: string);

    /// <summary>Get footer appearance properties</summary>
    function GetFooterAppearanceProperties: TItemAppearanceProperties;
    /// <summary>Get header appearance properties</summary>
    function GetHeaderAppearanceProperties: TItemAppearanceProperties;
    /// <summary>Get regular item appearance properties</summary>
    function GetItemAppearanceProperties: TItemAppearanceProperties;
    /// <summary>Get regular item appearance properties in edit mode</summary>
    function GetItemEditAppearanceProperties: TItemAppearanceProperties;
    /// <summary>Setter for ItemAppearanceObjects property</summary>
    procedure SetItemAppearanceObjects(const Value: TPublishedObjects);
    /// <summary>Getter for ItemAppearanceObjects property</summary>
    function GetItemAppearanceObjects: TPublishedObjects;

    /// <summary>Footer height</summary>
    property FooterHeight: Integer read GetFooterHeight write SetFooterHeight;
    /// <summary>Header height</summary>
    property HeaderHeight: Integer read GetHeaderHeight write SetHeaderHeight;
    /// <summary>Regular item height</summary>
    property ItemHeight: Integer read GetItemHeight write SetItemHeight;
    /// <summary>Regular item height in edit mode</summary>
    property ItemEditHeight: Integer read GetItemEditHeight write SetItemEditHeight;

    /// <summary>Footer appearance name</summary>
    property FooterAppearanceName: string read GetFooterAppearanceName write SetFooterAppearanceName;
    /// <summary>Header appearance name</summary>
    property HeaderAppearanceName: string read GetHeaderAppearanceName write SetHeaderAppearanceName;
    /// <summary>Regular item appearance name</summary>
    property ItemAppearanceName: string read GetItemAppearanceName write SetItemAppearanceName;
    /// <summary>Regular appearance name in edit mode</summary>
    property ItemEditAppearanceName: string read GetItemEditAppearanceName write SetItemEditAppearanceName;

    /// <summary>Footer appearance properties</summary>
    property FooterAppearanceProperties: TItemAppearanceProperties read GetFooterAppearanceProperties;
    /// <summary>Header appearance properties</summary>
    property HeaderAppearanceProperties: TItemAppearanceProperties read GetHeaderAppearanceProperties;
    /// <summary>Regular item appearance properties</summary>
    property ItemAppearanceProperties: TItemAppearanceProperties read GetItemAppearanceProperties;
    /// <summary>Regular item appearance properties in edit mode</summary>
    property ItemEditAppearanceProperties: TItemAppearanceProperties read GetItemEditAppearanceProperties;
    /// <summary>Access instance of TPublishedObjects used by ListView</summary>
    property ItemAppearanceObjects: TPublishedObjects read GetItemAppearanceObjects write SetItemAppearanceObjects;
  end;

  TAppearanceNamePair = TPair<string (*Identifier*), string (*displayname*)>;
  TAppearanceType = (Item, ItemEdit, Header, Footer);

  TItemAppearanceObjects = class;

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
    // ImageListItemgec group
    ImageListItem = 'ImageListItem';
    ImageListItemDelete = 'ImageListItemDelete';
    ImageListItemShowCheck = 'ImageListItemShowCheck';
    ImageListItemBottomDetail = 'ImageListItemBottomDetail';
    ImageListItemBottomDetailShowCheck = 'ImageListItemBottomDetailShowCheck';
    ImageListItemBottomDetailRightButton = 'ImageListItemBottomDetailRightButton';
    ImageListItemBottomDetailRightButtonShowCheck = 'ImageListItemBottomDetailRightButtonShowCheck';
    // ListItemRightButton group
    ImageListItemRightButton = 'ImageListItemRightButton';
    ImageListItemRightButtonDelete = 'ImageListItemRightButtonDelete';
    ImageListItemRightButtonShowCheck = 'ImageListItemRightButtonShowCheck';
  end;

  /// <summary>Extended items adapter that supports item appearances. This is the default adapter used by
  /// TAppearanceListView. It implements all extensions supported by TAppearanceListView.
  ///</summary>
  TAppearanceListViewItems = class(TFilterableListViewItems, IListViewAdapter, IListViewCheckProvider, IListViewEditor,
    IListViewFilterable, IListViewTextProvider, IListViewTextButtonProvider, IListViewGlyphButtonProvider,
    IListViewExtrasProvider)
  strict private
    [Weak] FOwnerControl: TControl;
    FNewItems: TListItemsList;
    FAsFilterable: IListViewFilterable;
    FPresentationParent: IListViewPresentationParent;
    FListViewController: IListViewController;
    { IListViewEditor }
    FBeforeItemAdded: TBeforeItemAddedNotify;
    FAfterItemAdded: TAfterItemAddedNotify;
    FBeforeItemDeleted: TBeforeItemDeletedNotify;
    FAfterItemDeleted: TAfterItemDeletedNotify;
    FCheckedCount: Integer;

    { IListViewEditor }
    function EditorAdd: TListItem;
    function EditorInsert(const Index: Integer): TListItem;

    procedure SetBeforeItemAdded(const AHandler: TBeforeItemAddedNotify);
    procedure SetAfterItemAdded(const AHandler: TAfterItemAddedNotify);
    procedure SetBeforeItemDeleted(const AHandler: TBeforeItemDeletedNotify);
    procedure SetAfterItemDeleted(const AHandler: TAfterItemDeletedNotify);

    { IListViewTextProvider }
    function GetText(const Index: Integer): string;
    function GetIndexTitle(const Index: Integer): string;

    { IListViewGlyphButtonProvider }
    function GetGlyphButtonDrawable(const Index: Integer): TListItemGlyphButton;

    { IListViewTextButtonProvider }
    function GetTextButtonDrawable(const Index: Integer): TListItemTextButton;

    { IListViewExtrasProvider }
    function GetItemData(const Index: Integer; const DataIndex: string): TValue;
    procedure SetItemData(const Index: Integer; const DataIndex: string; const AValue: TValue);
    function GetHasData(const Index: Integer; const DataIndex: string): Boolean;
    function GetItemTag(const Index: Integer): NativeInt;
    procedure SetItemTag(const Index: Integer; const AValue: NativeInt);

  strict private
    function GetAppearanceItem(const Index: Integer): TListViewItem;
  strict protected
    /// <summary>Create drawables for newly added items.</summary>
    procedure DoCreateNewViews; override;
    /// <summary>Apply filter to given item</summary>
    function DoFilterItem(const Item: TListItem): Boolean; override;
    /// <summary>Recreate drawables for items with given purposes.</summary>
    procedure DoResetViews(const APurposes: TListItemPurposes); override;
    /// <summary>Clear the list of items.</summary>
    procedure DoClear; virtual;
    /// <summary>Add new item at index Index and return it.</summary>
    function DoAddItem(const Index: Integer = -1): TListViewItem; virtual;
  protected
    property OwnerControl: TControl read FOwnerControl;
    function AppearanceItemOwner: IAppearanceItemOwner;
  public
    constructor Create(const Owner: TControl);
    destructor Destroy; override;
    function IListViewEditor.Add = EditorAdd;
    function IListViewEditor.Insert = EditorInsert;
    /// <summary>Sort items using given AComparer</summary>
    procedure Sort(AComparer: IComparer<TListViewItem>); overload;
    { IListViewCheckable }
    /// <summary>True if there is an item such that Item.Checked = AChecked</summary>
    function AnyChecked(const AChecked: Boolean = True): Boolean;
    /// <summary>Index of the first item where Item.Checked = AChecked</summary>
    function FirstChecked(const AChecked: Boolean = True): Integer;
    /// <summary>Count items where Item.Checked = AChecked</summary>
    function CheckedCount(const AChecked: Boolean = True): Integer;
    /// <summary>Change check state of all items</summary>
    procedure CheckAll(const AChecked: Boolean = True); overload;
    /// <summary>Change check state of all items. If ACallback is not nil, it should return True
    /// for items state of which should be changed. Callback argument is Item Index, return value is
    /// a Boolean which enables or disables state change for given index.</summary>
    procedure CheckAll(const ACallback: TFunc<Integer, Boolean>; const AChecked: Boolean = True); overload;
    function GetChecked(const Index: Integer): Boolean;
    procedure SetChecked(const Index: Integer; const Value: Boolean);
    /// <summary>Get/set checked state of item at Index</summary>
    property Checked[const Index: Integer]: Boolean read GetChecked write SetChecked;
    /// <summary>Return indexes of all checked (if AChecked = True) or unchecked (AChecked = False) items.</summary>
    function CheckedIndexes(const AChecked: Boolean): TArray<Integer>; overload;
    /// <summary>Return indexes of all checked (if AChecked = True) or unchecked (AChecked = False) items.
    /// AOrder specifies order of returned items, TListViewItems.TOrder.FirstToLast or
    /// TListViewItems.TOrder.LastToFirst.</summary>
    function CheckedIndexes(const AOrder: TListViewItems.TOrder; const AChecked: Boolean): TArray<Integer>; overload;
    /// <summary>Obtain TEnumerator<TListViewItem> for this adapter</summary>
    function GetEnumerator: TEnumerator<TListViewItem>; reintroduce;
    /// <summary>Perform recounting of all items, find AItem and return its index or -1 if not found</summary>
    function ReindexAndFindItem(const AItem: TListViewItem): Integer; // item reindexer, formerly in ListView

    { IListViewEditor }
    /// <summary>Create a new TListViewItem and append it at the end of list of items</summary>
    /// <returns>New item instance</returns>
    function Add: TListViewItem;
    /// <summary>Create a new TListViewItem and insert it before position specified by Index</summary>
    /// <returns>New item instance</returns>
    function Insert(const Index: Integer): TListViewItem;
    /// <summary>Delete an item with index Index</summary>
    procedure Delete(const Index: Integer);
    /// <summary>Dispose of all items at once</summary>
    procedure Clear;
    /// <summary>Same as Insert(Index)</summary>
    function AddItem(const Index: Integer = -1): TListViewItem;
    /// <summary>Default index property. Get a TListViewItem at index Index.</summary>
    property AppearanceItem[const Index: Integer]: TListViewItem read GetAppearanceItem; default;
    /// <summary>Return this adapter as IListViewFilterable</summary>
    property AsFilterable: IListViewFilterable read FAsFilterable;
  end;

  /// <summary>Extension of TListItem that supports Appearances. Forms content of TAppearanceListViewItems</summary>
  TListViewItem = class(TListItem)
  private type
    TFlag = (HasButtonText, HasCheck);
    TFlags = set of TFlag;
  public type
    TObjectNames = class
    public const
      Text = 'T'; // do not localize
      Detail = 'D'; // do not localize
      Accessory = 'A'; // do not localize
      TextButton = 'B'; // do not localize
      GlyphButton = 'G'; // do not localize
      Image = 'I'; // do not localize
    end;
    TMemberNames = class
    public const
      Text = 'Text'; // do not localize
      Detail = 'Detail'; // do not localize
      ButtonText = 'ButtonText'; // do not localize
      Bitmap = 'Bitmap'; // do not localize
      ImageIndex = 'ImageIndex'; // do not localize
    end;

    TListViewItemObjects = class(TListItemView)
    strict private
      FAppearance: TItemAppearanceObjects;
      function GetDetailObject: TListItemText;
      function GetGlyphButton: TListItemGlyphButton;
      function GetImageObject: TListItemImage;
      function GetTextButton: TListItemTextButton;
      function GetTextObject: TListItemText;
      function GetAccessoryObject: TListItemAccessory;
    public
      procedure Clear; override;
      function FindObjectT<T: TListItemDrawable>(const AName: string): T;
      property TextObject: TListItemText read GetTextObject;
      property DetailObject: TListItemText read GetDetailObject;
      property ImageObject: TListItemImage read GetImageObject;
      property TextButton: TListItemTextButton read GetTextButton;
      property GlyphButton: TListItemGlyphButton read GetGlyphButton;
      property AccessoryObject: TListItemAccessory read GetAccessoryObject;
      property Appearance: TItemAppearanceObjects read FAppearance write FAppearance;
    end;

  private type
    TDirtyDrawable = (Text, Detail, Check, ButtonText);
    TDirtyDrawables = set of TDirtyDrawable;

  private
    FData: TDictionary<string, TValue>;
    FDataBitmaps: TDictionary<string, TBitmap>;
    FFlags: TFlags;
    FText: string;
    FDetail: string;
    FIndexTitle: string;
    FButtonText: string;
    FAccessory: TAccessoryType;
    FBitmap: TBitmap;
    FChecked: Boolean;
    FImageIndex: Integer;
    [Weak] FBitmapRef: TBitmap;
    FTag: NativeInt;
    FCreatingObjectsGuard: Boolean;

    FDirtyDrawables: TDirtyDrawables;
    FPresentationParent: IListViewPresentationParent;

    procedure SetText(const Value: string);
    function GetBitmap: TBitmap;
    procedure SetAccessory(const Value: TAccessoryType);
    procedure SetDetail(const Value: string);
    procedure SetButtonText(const Value: string);
    procedure SetImageIndex(Value: Integer);
    procedure SetBitmap(const Value: TBitmap);
    procedure OnBitmapChanged(Sender: TObject);
    procedure SetBitmapRef(const Value: TBitmap);
    procedure CheckBitmap;
    function GetChecked: Boolean;
    procedure SetChecked(const Value: Boolean);
    function GetObjects: TListViewItemObjects; inline;
    function GetData(const AIndex: string): TValue;
    procedure SetData(const AIndex: string; const AValue: TValue);
    function GetIndexTitle: string;
    procedure SetIndexTitle(const Value: string);
    procedure UpdateDrawables;
  protected
    function GetIndex: Integer; override;
    /// <summary>True if user-specified button text is set for this item. If user text is not specified,
    /// the value defined by Text Button Appearance will be used.</summary>
    function GetHasButtonText: Boolean;
    function GetHasData(const AIndex: string): Boolean;
    function ListItemObjectsClass: TListItem.TListItemViewType; override;
    procedure SetPurpose(const AValue: TListItemPurpose); override;
    procedure InvalidateHeights; override;
    procedure ClearData(const AIndex: string);
  public
    constructor Create(const Owner: TAppearanceListViewItems; PresentationParent: IListViewPresentationParent;
      AController: IListViewController);
    destructor Destroy; override;
    procedure CreateObjects; override;
    procedure WillBePainted; override;
    /// <summary> Main text for the cell. </summary>
    property Text: string read FText write SetText;
    /// <summary> Detail (smaller) text for the cell. This may either appear below or to the right of main text,
    /// depending on currently selected appearance. It may also not appear at all. </summary>
    property Detail: string read FDetail write SetDetail;
    /// <summary>Shortcut letter that appears on the right of the list in native iOS presentations.</summary>
    property IndexTitle: string read GetIndexTitle write SetIndexTitle;
    /// <summary>Accessory type. Used if the appearance defines an accessory item.</summary>
    property Accessory: TAccessoryType read FAccessory write SetAccessory;
    /// <summary>Bitmap to be used by default Image Appearance Item. Assigning this property will
    /// create a bitmap copy stored in this item.</summary>
    property Bitmap: TBitmap read GetBitmap write SetBitmap;
    /// <summary>Bitmap reference to be used by default Image Appearance Item. The bitmap will not be
    /// copied to the item, the original TBitmap object should be managed by the user.</summary>
    property BitmapRef: TBitmap read FBitmapRef write SetBitmapRef;
    /// <summary>Text to be used by default TextButton Appearance Item.</summary>
    property ButtonText: string read FButtonText write SetButtonText;
    ///<summary>Zero based index of an image in the ImageList. The default is <c>-1</c>.
    ///<para> See also <b>FMX.ActnList.IGlyph</b></para></summary>
    ///<remarks>If non-existing index is specified, an image is not drawn and no exception is raised</remarks>
    property ImageIndex: Integer read FImageIndex write SetImageIndex;
    ///<summary>True if this item is checked. Only valid in EditMode</summary>
    property Checked: Boolean read GetChecked write SetChecked;
    ///<summary>An extension of TListItemView that has public references to the default set of drawables
    ///used by predefined appearances</summary>
    property Objects: TListViewItemObjects read GetObjects;
    ///<summary>User tag</summary>
    property Tag: NativeInt read FTag write FTag;
    /// <summary>Set or get arbitrary data values. Once set, the values will be stored in the item.
    /// Data values with AIndex matching AppearanceItem Name will be used to initialize
    /// that the Drawable created by that Appearance Item. For example, Data['Text'] := MyText will initialize
    /// the drawable managed by the appearance item called 'Text' using myText. </summary>
    property Data[const AIndex: string]: TValue read GetData write SetData;
    /// <summary>True if a value with index AIndex is stored in this item</summary>
    property HasData[const AIndex: string]: Boolean read GetHasData;
  end;

  TAppearanceListViewItem = TListViewItem;

{$REGION 'Appearance object declarations'}

  TObjectAppearance = class abstract (TInterfacedPersistent, IDesignablePersistent)
  public type
    TDataMember = TPair<string, string>; // display name, data member
    TDataMembers = TArray<TDataMember>;
  private
    [Weak] FOwner: TItemAppearanceObjects;
    FName: string;
    FDefaultValues: TObjectAppearance;
    FVisible: Boolean;
    FOnChange: TNotifyEvent;
    FOnHeightChange: TNotifyEvent;
    FInitializing: Boolean;
    FDataMembers: TDataMembers;
    FUsingDefaultValues: Boolean;
    FShim: IPersistentShim;

    procedure SetDefaultValues(const Value: TObjectAppearance);
    function IgnoreChanges: Boolean;
    procedure SetVisible(const Value: Boolean);
    function IsActive: Boolean; virtual;
    function GetHeight: Integer; virtual;
    function CreateDefaultValues: TObjectAppearance; virtual;

    { IDesignablePersistent }
    function GetBoundsRect: TRect;
    function GetDesignParent: TPersistent;
    procedure BindShim(AShim: IPersistentShim);
    procedure UnbindShim;
    procedure IDesignablePersistent.Bind = BindShim;
    procedure IDesignablePersistent.Unbind = UnbindShim;
    function BeingDesigned: Boolean;
  protected
    procedure DoChange; virtual;
    procedure DoHeightChange; virtual;
  public
    constructor Create; overload; virtual;
    constructor Create(AIsDefaultValues: Boolean); overload;
    destructor Destroy; override;
    procedure RestoreDefaults; virtual;
    procedure AfterConstruction; override;
    procedure BeginUpdate;
    procedure EndUpdate;
    /// <summary>Create a drawable in the view after own image and initialize it with appearance properties.
    /// For example, TCustomTextObjectAppearance.CreateObject creates an instance of TListItemText </summary>
    procedure CreateObject(const AListViewItem: TListViewItem); virtual; abstract;
    /// <summary>Find drawable that matches type and name of self in AListViewItem.View, and initialize it.</summary>
    procedure ResetObject(const AListViewItem: TListViewItem); virtual; abstract;
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

  TListItemObjectClass = class of TListItemDrawable;

  TCommonObjectAppearance = class(TObjectAppearance, IMovablePersistent)
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
    function GetSizeWhenVisible: TPointF;
  protected
    procedure AssignTo(ADest: TPersistent); override;
    procedure InitDefaultValues(const ADefaults: TCommonObjectAppearance); virtual;
    /// <summary>Find or create new drawable object of type T named Name in item AListViewItem
    /// and initialize it by assigning self.</summary>
    procedure ResetObjectT<T: TListItemDrawable>(const AListViewItem: TListViewItem);
    function IsAlignStored: Boolean;
    function IsVertAlignStored: Boolean;
    function IsVisibleStored: Boolean;
    function IsPlaceOffsetStored: Boolean;
    function IsWidthStored: Boolean;
    function IsHeightStored: Boolean;
    function IsOpacityStored: Boolean;

    { IMovablePersistent }
    procedure SetBoundsRect(const AValue: TRect);
  public
    constructor Create; override;
    destructor Destroy; override;
    /// <summary>Get actual height of the Appearance Object. The return value is:
    ///  If Visible = True:
    ///    Value of property Height if it is not zero.
    ///    Value of property InternalHeight otherwise.
    ///  If Visible = False:
    ///    0
    /// </summary>
    property ActualHeight: Single read GetActualHeight;
    /// <summary>Get actual width of the Appearance Object. The return value is:
    ///  If Visible = True:
    ///    Value of property Width if it is not zero.
    ///    Value of property InternalWidth otherwise.
    ///  If Visible = False:
    ///    0
    /// </summary>
    property ActualWidth: Single read GetActualWidth;
    /// <summary>Width of this object appearance regardless of current visibility</summary>
    property WidthWhenVisible: Single read GetWidthWhenVisible;
    /// <summary>Height of this object appearance regardless of current visibility</summary>
    property HeightWhenVisible: Single read GetHeightWhenVisible;
    /// <summary>Size of this object appearance regardless of current visibility</summary>
    property SizeWhenVisible: TPointF read GetSizeWhenVisible;
    /// <summary>Actual offset from the calculated position: PlaceOffset if nonzero, InternalPlaceOffset otherwise.</summary>
    property ActualPlaceOffset: TPointF read GetActualPlaceOffset;
    property InternalWidth: Single read FInternalWidth write SetInternalWidth;
    property InternalHeight: Single read FInternalHeight write SetInternalHeight;
    property InternalPlaceOffset: TPosition read FInternalPlaceOffset write SetInternalPlaceOffset;
    // Local width of list item inside its designated area.
    property Width: Single read FWidth write SetWidth;
    // Local height of list item inside its designated area.
    property Height: Single read FHeight write SetHeight;

    /// <summary>Horizontal alignment of Appearance Object inside its designated area.</summary>
    property Align: TListItemAlign read FAlign write SetAlign;
    /// <summary>Vertical alignment of Appearance Object inside its designated area.</summary>
    property VertAlign: TListItemAlign read FVertAlign write SetVertAlign;
    /// <summary>Offset from aligned location for placement control</summary>
    property PlaceOffset: TPosition read FPlaceOffset write SetPlaceOffset;
    /// <summary>Opacity of this Appearance Object</summary>
    property Opacity: Single read FOpacity write SetOpacity;
  end;

  TCustomTextObjectAppearance = class(TCommonObjectAppearance)
  private
    FFont: TFont;
    FFontDirty: Boolean;
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
    FScalingMode: TImageScalingMode;
    procedure SetScalingMode(const Value: TImageScalingMode);
  private
    function GetDefaultValues: TCustomImageObjectAppearance;
  protected
    procedure AssignTo(ADest: TPersistent); override;
    function CreateDefaultValues: TObjectAppearance; override;
    function IsOpacityStored: Boolean;
    function IsScalingModeStored: Boolean;
  public
    constructor Create; override;
    procedure CreateObject(const AListViewItem: TListViewItem); override;
    procedure ResetObject(const AListViewItem: TListViewItem); override;
    property ScalingMode: TImageScalingMode read FScalingMode write SetScalingMode;
    property DefaultValues: TCustomImageObjectAppearance read GetDefaultValues;
  end;

  TImageObjectAppearance = class(TCustomImageObjectAppearance)
  published
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
    FTintColor: TAlphaColor;
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
    procedure SetTintColor(const Value: TAlphaColor);
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
    function IsTintColorStored: Boolean;
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
    property TintColor: TAlphaColor read FTintColor write SetTintColor;
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
    property TintColor stored IsTintColorStored nodefault;
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
  strict private
    [Weak] FOwnerControl: TControl;
    FResources: IListItemStyleResources;
  private
    FOnChange: TNotifyEvent;
    FOnChangeHeight: TNotifyEvent;
    FOnButtonClick: TItemControlEvent;
    FOnButtonChange: TItemControlEvent;
    function GetHeight: Integer; virtual;
    procedure SetHeight(Value: Integer); virtual;
    procedure TakeOwnership(const NewOwner: TControl);
  protected
    procedure ItemPropertyChange(Sender: TObject);
    procedure DoChange; virtual;
    procedure DoChangeHeight; virtual;
    procedure AssignTo(ADest: TPersistent); override;
    procedure UpdateSizes(const FinalSize: TSizeF); virtual;
    function DefaultHeight: Integer; virtual;
    function GetPublishedObjects: TArray<TCommonObjectAppearance>; virtual;
    function GetObjects: TArray<TCommonObjectAppearance>; virtual;
    // For custom appearances to read/write TAppearanceListViewItem.Data
    procedure SetObjectData(const AListViewItem: TListViewItem; const AIndex: string; const AValue: TValue; var AHandled: Boolean); virtual;
    function StyleResourcesNeedUpdate: Boolean;
    function GetStyleResources: TListItemStyleResources;
    property OwnerControl: TControl read FOwnerControl;
  public
    constructor Create(const Owner: TControl); virtual;
    /// <summary>Initialize view ("objects") of specified TListViewItem using objects of this Appearance. If
    /// the view is already initialized, it will be fully updated.</summary>
    procedure ResetObjects(const AListViewItem: TListViewItem; const FinalSize: TSizeF); virtual;
    property Height: Integer read GetHeight write SetHeight;
    procedure BeginUpdate;
    procedure EndUpdate;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnChangeHeight: TNotifyEvent read FOnChangeHeight write FOnChangeHeight;
    property Objects: TArray<TCommonObjectAppearance> read GetObjects;
    property PublishedObjects: TArray<TCommonObjectAppearance> read GetPublishedObjects;
    property OnButtonClick: TItemControlEvent write FOnButtonClick;
    property OnButtonChange: TItemControlEvent write FOnButtonChange;
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
    /// <summary>Search Objects and PublishedObjects for an object with the same name as that of given
    /// AObjectAppearance and replace them with it. If not found, append.</summary>
    function UpdateObject(const AObjectAppearance: TCommonObjectAppearance; APublished: Boolean):
      TCommonObjectAppearance;
    /// <summary>Remove given AObjectAppearance from Objects and PublishedObjects</summary>
    procedure RemoveObject(const AObjectAppearance: TCommonObjectAppearance);
    function GetObjects: TArray<TCommonObjectAppearance>; override;
  public
    constructor Create(const Owner: TControl); overload; override;
    destructor Destroy; override;
    property Text: TTextObjectAppearance read FText write SetTextElement;
    property Detail: TTextObjectAppearance read FDetail write SetDetailElement;
    property Image: TImageObjectAppearance read FImage write SetImageElement;
    property Accessory: TAccessoryObjectAppearance read FAccessory write SetAccessoryElement;
    property TextButton: TTextButtonObjectAppearance read FTextButton write SetTextButtonElement;
    property GlyphButton: TGlyphButtonObjectAppearance read FGlyphButton write SetGlyphButtonElement;
  end;

  TItemAppearanceObjectsClass = class of TItemAppearanceObjects;

  TRegisterAppearanceOption = (Footer, Header, Item, ItemEdit, DefaultFooter, DefaultHeader, DefaultItem, DefaultItemEdit);
  TRegisterAppearanceOptions = set of TRegisterAppearanceOption;
  TRegisteredAppearance = record
    Name: string;
    Value: TItemAppearanceObjectsClass;
    UnitName: string;
    Options: TRegisterAppearanceOptions;
  end;

  ///<summary>Represents properties of Item Appearance that define geometric properties of the entire ListViewItem,
  /// specify AppearanceClass and AppearanceClassName that define Item Appearance Objects that comprise item's view.
  /// </summary>
  TItemAppearanceProperties = class(TInterfacedPersistent, IDesignablePersistent, ISpriggedPersistent)
  public type
    TControlEvent = TAppearanceObjects.TControlEvent;
    TItemAppearanceObjectsClass = TItemAppearanceObjectsClass;
    TAppearancePropertiesEvent = procedure(const Sender: TItemAppearanceProperties) of object;
  public const
    cDefaultHeight = TAppearanceObjects.cDefaultHeight;
  strict private
    FOwnerControl: TControl;
    FName: string;
    FAppearanceType: TAppearanceType;
    FAppearanceCache: TDictionary<TItemAppearanceObjectsClass, TItemAppearanceObjects>;
    FAppearance: TItemAppearanceObjects;
    FAppearanceClass: TItemAppearanceObjectsClass;
    FPurpose: TListItemPurpose;
    FPropertiesOwner: IPublishedAppearanceOwner;
    FOnChange: TNotifyEvent;
    FOnDestroy: TNotifyEvent;
    FSprig: TPersistent;
    FShim: IPersistentShim;

    procedure SetName(const Value: string);
    procedure SetObjects(const Value: TItemAppearanceObjects);
    procedure PropertiesChange(Sender: TObject);
    procedure PropertiesChangeHeight(Sender: TObject);
    function GetHeight: Integer;
    procedure SetHeight(AValue: Integer);
    procedure SetAppearanceClass(const Value: TItemAppearanceObjectsClass);
    function GetAppearanceClassName: string;
    procedure SetAppearanceClassName(const Value: string);
    function GetActive: Boolean;
    function PropertiesOwner: IPublishedAppearanceOwner;

    { IDesignableAppearance }
    function GetBoundsRect: TRect;
    function GetDesignParent: TPersistent;

    procedure BindShim(AShim: IPersistentShim);
    procedure UnbindShim;
    procedure IDesignablePersistent.Bind = BindShim;
    procedure IDesignablePersistent.Unbind = UnbindShim;
    function BeingDesigned: Boolean;

    procedure SetSprig(const APersistent: TPersistent);
    function GetSprig: TPersistent;
  protected
    /// <summary>Notify PropertiesOwner of change in its Item Appearance Properties and invoke
    /// FOnChange event if it is assigned.</summary>
    procedure DoChange; virtual;
    /// <summary>Notify PropertiesOwner of item height change</summary>
    procedure DoChangeHeight; virtual;
    /// <summary>Notify PropertiesOwner that the objects that comprise the appearance represented by these
    ///  properties have been changed</summary>
    procedure DoChangeObjects; virtual;
    /// <summary>True if the Height property is user modified</summary>
    function IsHeightStored: Boolean;
  public
    constructor Create(const Owner: TControl; AType: TAppearanceType);
    destructor Destroy; override;
    /// <summary>Owner control for property editors. The host TListView.</summary>
    property Owner: TControl read FOwnerControl;
    /// <summary>Item purpose: None (regular), Header, Footer.</summary>
    property Purpose: TListItemPurpose read FPurpose;
    /// <summary>The class that defines objects that comprise item appearance. E.g. TListItemAppearance. See also
    /// AppearanceClassName.</summary>
    property AppearanceClass: TItemAppearanceObjectsClass read FAppearanceClass write SetAppearanceClass;
    /// <summary>AppearanceClass name. The class with given name will be searched in TAppearancesRegistry
    /// and if found, used to intialize appearance.</summary>
    property AppearanceClassName: string read GetAppearanceClassName write SetAppearanceClassName;
    /// <summary>Indicates that this appearance is currently active. EditMode appearance will be inactive in regular
    /// mode and active when ListView is in Edit Mode. The opposite is true for regular Item Appearances.</summary>
    property Active: Boolean read GetActive;
    /// <summary>Display name for this Item Appearance</summary>
    property Name: string read FName write SetName stored False;
    /// <summary>Specifies Item Height.</summary>
    property Height: Integer read GetHeight write SetHeight;
    /// <summary>Appearance Item Objects that comprise this Item Appearance, e.g. 'Text', 'Image', etc</summary>
    property Objects: TItemAppearanceObjects read FAppearance write SetObjects;  // Objects is published name of Appearance
    /// <summary>Appearance type: (Item, ItemEdit, Header, Footer)</summary>
    property AppearanceType: TAppearanceType read FAppearanceType;
    /// <summary>Event to be invoked when these change</summary>
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    /// <summary>Event to be invoked when is instance is being destroyed</summary>
    property OnDestroy: TNotifyEvent read FOnDestroy write FOnDestroy;
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
    constructor Create(const Owner: TControl); override;
  end;

  // Disables all services for managing TAppearanceListViewItem.Objects, such as creating and resizing
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
    procedure UpdateSizes(const FinalSize: TSizeF); override;
    procedure SetInternalSize(const AGlyphButton: TGlyphButtonObjectAppearance;
      AStyleResources: TListItemStyleResources); overload;
    procedure SetInternalSize(const AAccessory: TAccessoryObjectAppearance;
      AStyleResources: TListItemStyleResources); overload;
    function DefaultHeight: Integer; override;
  public
    constructor Create(const Owner: TControl); override;
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
    // Identify the ancestor class that supports resetobjects
    function GetGroupClass: TGroupClass; virtual;
    // Indicate if this is an itemedit appearance
    function GetIsItemEdit: Boolean; virtual;
    property IsItemEdit: Boolean read GetIsItemEdit;
    property GroupClass: TGroupClass read GetGroupClass;
  public
    procedure ResetObjects(const AListViewItem: TListViewItem; const FinalSize: TSizeF); override;
  end;

  TPublishedAppearance = class(TPersistent)
  strict private
    FOwnerComponent: TComponent;
    FPropertiesOwner: IPublishedAppearanceOwner;

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
  published
    constructor Create(const AOwner: TComponent);
    property Owner: TComponent read FOwnerComponent;
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
    FOwner: IPublishedAppearanceOwner;

    function GetFooterObjects: TItemAppearanceObjects;
    function GetHeaderObjects: TItemAppearanceObjects;
    function GetItemEditObjects: TItemAppearanceObjects;
    function GetItemObjects: TItemAppearanceObjects;
    procedure SetFooterObjects(const Value: TItemAppearanceObjects);
    procedure SetHeaderObjects(const Value: TItemAppearanceObjects);
    procedure SetItemEditObjects(const Value: TItemAppearanceObjects);
    procedure SetItemObjects(const Value: TItemAppearanceObjects);
  published
    constructor Create(const AOwner: IPublishedAppearanceOwner);
    property ItemObjects: TItemAppearanceObjects read GetItemObjects write SetItemObjects;
    property ItemEditObjects: TItemAppearanceObjects read GetItemEditObjects write SetItemEditObjects;
    property HeaderObjects: TItemAppearanceObjects read GetHeaderObjects write SetHeaderObjects;
    property FooterObjects: TItemAppearanceObjects read GetFooterObjects write SetFooterObjects;
  end;

  /// <summary>Registered appearance descriptor used in TAppearancesRegistry</summary>
  TRegisterAppearanceValue = record
    /// <summary>Appearance name</summary>
    Name: string;
    /// <summary>Appearance unit name</summary>
    UnitName: string;
    /// <summary>Appearance options: Footer, Header, Item, ItemEdit, DefaultFooter,
    /// DefaultHeader, DefaultItem, DefaultItemEdit</summary>
    Options: TRegisterAppearanceOptions;
    constructor Create(const AName: string; AOptions: TRegisterAppearanceOptions; const AUnitName: string);
  end;

  /// <summary>Global registry of Item Appearances</summary>
  TAppearancesRegistry = class
    private class var
      FFactories: TDictionary<TItemAppearanceObjectsClass, TRegisterAppearanceValue>;
    public const
      cRegisterDefault = [TRegisterAppearanceOption.DefaultFooter, TRegisterAppearanceOption.DefaultHeader,
        TRegisterAppearanceOption.DefaultItem, TRegisterAppearanceOption.DefaultItemEdit];
      cRegisterAll = [
        TRegisterAppearanceOption.Footer, TRegisterAppearanceOption.Header,  TRegisterAppearanceOption.Item,
        TRegisterAppearanceOption.ItemEdit, TRegisterAppearanceOption.DefaultFooter,
        TRegisterAppearanceOption.DefaultHeader,  TRegisterAppearanceOption.DefaultItem,
        TRegisterAppearanceOption.DefaultItemEdit];
    class constructor Create;
    class destructor Destroy;
    /// <summary>Register appearances from an array</summary>
    class procedure RegisterAppearances(AFactories: TArray<TItemAppearanceObjectsClass>; ADisplayNames: TArray<string>;
      AOptions: TRegisterAppearanceOptions = [TRegisterAppearanceOption.Item]; const AUnitName: string = ''); overload;
    /// <summary>Register a single appearance</summary>
    class procedure RegisterAppearance(const AFactory: TItemAppearanceObjectsClass; const ADisplayName: string;
      AOptions: TRegisterAppearanceOptions = [TRegisterAppearanceOption.Item]; const AUnitName: string = ''); overload;
    /// <summary>Unregister an item appearance</summary>
    class procedure UnregisterAppearance(const AFactory: TItemAppearanceObjectsClass); overload;
    /// <summary>Unregister appearances from an array</summary>
    class procedure UnregisterAppearances(AFactories: TArray<TItemAppearanceObjectsClass>); overload;
    /// <summary>Get registered appearances, filtered by kind. See TRegisterAppearanceOption</summary>
    class function GetRegisteredAppearances(AFilter: TRegisterAppearanceOptions = []): TArray<TRegisteredAppearance>;
    /// <summary>Find TItemAppearanceObjectsClass by option.
    /// See TRegisterAppearanceOption, TItemAppearanceObjectsClass </summary>
    class function FindItemAppearanceObjectsClassByOption(AOption: TRegisterAppearanceOption): TItemAppearanceObjectsClass;
  end;

implementation

uses
  System.Math;

{$REGION 'TAppearanceListViewItem'}

constructor TListViewItem.Create(const Owner: TAppearanceListViewItems; PresentationParent: IListViewPresentationParent;
  AController: IListViewController);
begin
  inherited Create(Owner, AController);
  FPresentationParent := PresentationParent;
  FImageIndex := -1;
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

function TListViewItem.GetIndex: Integer;
begin
  Result := inherited;
  if Result = -1 then
  begin
    Controller.RequestReindexing(Self);
    Result := inherited;
  end;
end;

function TListViewItem.GetObjects: TListViewItemObjects;
begin
  if TNonReentrantHelper.EnterSection(FCreatingObjectsGuard) then
    try
      CreateObjects;
    finally
      TNonReentrantHelper.LeaveSection(FCreatingObjectsGuard);
    end;
  Result := TListViewItem.TListViewItemObjects(inherited View);
end;

procedure TListViewItem.InvalidateHeights;
begin
  Controller.ItemResized(Self);
end;

function TListViewItem.ListItemObjectsClass: TListItem.TListItemViewType;
begin
  Result := TListViewItem.TListViewItemObjects;
end;

function TListViewItem.GetBitmap: TBitmap;
begin
  CheckBitmap;  // Need a bitmap for assignment
  Result := FBitmap;
end;

function TListViewItem.GetHasButtonText: Boolean;
begin
  Result := TFlag.HasButtonText in FFlags;
end;

procedure TListViewItem.SetPurpose(const AValue: TListItemPurpose);
begin
  inherited;
  if (AValue <> Purpose) and View.Initialized then
    Adapter.ResetView(Self);
end;

function TListViewItem.GetIndexTitle: string;
begin
  if not FIndexTitle.IsEmpty then
    Result := FIndexTitle
  else
    Result := FText.Substring(0, 1);
end;

procedure TListViewItem.SetIndexTitle(const Value: string);
begin
  if FText <> Value then
  begin
    FText := Value;
    if FPresentationParent <> nil then
      FPresentationParent.RebuildList;
  end;
end;

procedure TListViewItem.SetText(const Value: string);
begin
  FText := Value;
  Include(FDirtyDrawables, TDirtyDrawable.Text);
  Invalidate;
end;

procedure TListViewItem.UpdateDrawables;
var
  LText: TListItemText;
  LCheck: TListItemGlyphButton;
  LButton: TListItemTextButton;
  Dirty: TDirtyDrawable;
begin
  for Dirty in FDirtyDrawables do
    case Dirty of
      TDirtyDrawable.Text:
        begin
          LText := Objects.TextObject;
          if LText <> nil then
            LText.Text := FText;
        end;
      TDirtyDrawable.Detail:
        begin
          LText := Objects.DetailObject;
          if LText <> nil then
            LText.Text := FDetail;
        end;
      TDirtyDrawable.Check:
        begin
          LCheck := Objects.GlyphButton;
          if LCheck <> nil then
            LCheck.Checked := FChecked;
        end;
      TDirtyDrawable.ButtonText:
        begin
          LButton := Objects.TextButton;
          if LButton <> nil then
            LButton.Text := FButtonText;
        end;
    end;

  FDirtyDrawables := [];
end;

procedure TListViewItem.WillBePainted;
begin
  UpdateDrawables;
end;

procedure TListViewItem.SetButtonText(const Value: string);
begin
  System.Include(FFlags, TFlag.HasButtonText);
  FButtonText := Value;
  Include(FDirtyDrawables, TDirtyDrawable.ButtonText);
  Invalidate;
end;

procedure TListViewItem.SetImageIndex(Value: Integer);
var
  LObject: TListItemImage;
begin
  FImageIndex := Value;
  LObject := Objects.ImageObject;
  if LObject <> nil then
    LObject.ImageIndex := Value;
end;

function TListViewItem.GetChecked: Boolean;
begin
  Result := FChecked;
end;

procedure TListViewItem.SetChecked(const Value: Boolean);
var
  ValueChanged: Boolean;
begin
  ValueChanged := FChecked <> Value;
  FChecked := Value;
  System.Include(FDirtyDrawables, TDirtyDrawable.Check);
  System.Include(FFlags, TFlag.HasCheck);
  if ValueChanged then
    Controller.CheckStateChanged(Self, Objects.GlyphButton);
  Invalidate;
end;

function TListViewItem.GetData(const AIndex: string): TValue;
var
  DataBitmap: TBitmap;
begin
  if FData <> nil then
  begin
    if not FData.TryGetValue(AIndex, Result) then
      if (FDataBitmaps <> nil) and not FDataBitmaps.TryGetValue(AIndex, DataBitmap) then
        Result := DataBitmap
      else
        Result := TValue.Empty;
  end
  else
    Result := TValue.Empty;
end;

function TListViewItem.GetHasData(const AIndex: string): Boolean;
begin
  Result := ((FData <> nil) and FData.ContainsKey(AIndex))
    or ((FDataBitmaps <> nil) and FDataBitmaps.ContainsKey(AIndex));
end;

procedure TListViewItem.SetData(const AIndex: string; const AValue: TValue);
var
  LObject: TListItemDrawable;
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
    if Objects.Appearance <> nil then
      Objects.Appearance.SetObjectData(Self, AIndex, AValue, LHandled);
    if not LHandled then
    begin
      LObject := Objects.FindDrawable(AIndex);
      if LObject <> nil then
        LObject.Data := AValue;
    end;
  end
  else
  begin
    LDataObject := AValue.AsObject;
    if LDataObject is TPersistent then  // LDataObject could be TBitmap, TBitmapSurface, TField
    begin
      LBitmap := nil;
      if (FDataBitmaps = nil) or not FDataBitmaps.TryGetValue(AIndex, LBitmap) then
      begin
        LBitmap := TBitmap.Create(0, 0);
        if FDataBitmaps = nil then
          FDataBitmaps := TObjectDictionary<string, TBitmap>.Create([doOwnsValues]);
        FDataBitmaps.Add(AIndex, LBitmap);
      end;
      LBitmap.Assign(TPersistent(LDataObject));
      LObject := Objects.FindDrawable(AIndex);
      if LObject is TListItemImage then
      begin
        Assert(not TListItemImage(LObject).OwnsBitmap);
        TListItemImage(LObject).Bitmap := LBitmap;
      end;
    end;
  end;
end;

procedure TListViewItem.ClearData(const AIndex: string);
begin
  if (FData <> nil) and FData.ContainsKey(AIndex) then
    FData.Remove(AIndex);
  if (FDataBitmaps <> nil) and FDataBitmaps.ContainsKey(AIndex) then
    FDataBitmaps.Remove(AIndex);
end;

procedure TListViewItem.SetDetail(const Value: string);
begin
  FDetail := Value;
  Include(FDirtyDrawables, TDirtyDrawable.Detail);
  Invalidate;
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
  if not View.Initialized then
  begin
    Adapter.ResetView(Self);
    View.Initialized := True;
  end;
end;

{ TAppearanceListViewItem.TListViewItemObjects }

procedure TListViewItem.TListViewItemObjects.Clear;
begin
  inherited;
  Initialized := False;
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
  LObject: TListItemDrawable;
begin
  LObject := FindDrawable(AName);
  if LObject is T then
    Exit(T(LObject));
  Result := nil;
end;

{$ENDREGION}
{$REGION 'TObjectAppearance'}

procedure TObjectAppearance.AfterConstruction;
begin
  inherited;
  if not FUsingDefaultValues then
  begin
    FDefaultValues := CreateDefaultValues;
    if FDefaultValues <> nil then
    begin
      Assert(FDefaultValues.FUsingDefaultValues); // Descendent should have set this
      FDefaultValues.FUsingDefaultValues := True; // Just in case
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

procedure TObjectAppearance.EndUpdate;
begin
  if FOwner <> nil then
    FOwner.EndUpdate;
end;

function TObjectAppearance.BeingDesigned: Boolean;
var
  Parent: IListViewDesignPresentationParent;
begin
  Result := (Owner <> nil) and
    Supports(Owner.OwnerControl, IListViewDesignPresentationParent, Parent) and Parent.HasDesignPresentationAttached;
end;

destructor TObjectAppearance.Destroy;
begin
  FDefaultValues.Free;
  UnbindShim;
  inherited;
end;

procedure TObjectAppearance.DoChange;
begin
  if not IgnoreChanges and Assigned(FOnChange) then
    FOnChange(Self);
end;

procedure TObjectAppearance.DoHeightChange;
begin
  if not IgnoreChanges and Assigned(FOnHeightChange) then
    FOnHeightChange(Self);
end;

constructor TObjectAppearance.Create;
begin
  inherited Create;
end;

constructor TObjectAppearance.Create(AIsDefaultValues: Boolean);
begin
  FUsingDefaultValues := AIsDefaultValues;
  Create;
end;

function TObjectAppearance.CreateDefaultValues: TObjectAppearance;
begin
  Result := nil;
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
  Result := FInitializing or FUsingDefaultValues or not IsActive;
end;

procedure TObjectAppearance.RestoreDefaults;
begin
  if FDefaultValues <> nil then
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

function TObjectAppearance.GetBoundsRect: TRect;
begin
  Result := TRect.Empty;
  if FShim <> nil then
    Result := FShim.GetBoundsRect;
end;

function TObjectAppearance.GetDesignParent: TPersistent;
begin
  Result := FOwner.OwnerControl;
end;

procedure TObjectAppearance.BindShim(AShim: IPersistentShim);
begin
  FShim := AShim;
end;

procedure TObjectAppearance.UnbindShim;
begin
  FShim := nil;
end;



{$ENDREGION}

{$REGION 'TCommonObjectAppearance'}

function SamePosition(const APosition1, APosition2: TPosition): Boolean; inline; overload;
begin
  Result := (APosition1.X = APosition2.X) and (APosition1.Y = APosition2.Y);
end;

function SamePosition(const APosition1: TPosition; const APosition2: TPointF): Boolean; inline; overload;
begin
  Result := (APosition1.X = APosition2.X) and (APosition1.Y = APosition2.Y);
end;

procedure TCommonObjectAppearance.AssignTo(ADest: TPersistent);
var
 DstDrawable: TListItemDrawable;
 DstAppearance: TCommonObjectAppearance;
 Offset: TPointF;
begin
  if ADest is TCommonObjectAppearance then
  begin
    DstAppearance := TCommonObjectAppearance(ADest);
    DstAppearance.BeginUpdate;
    try
      DstAppearance.Width := Self.Width;
      DstAppearance.Height := Self.Height;
      DstAppearance.Align := Self.Align;
      DstAppearance.VertAlign := Self.VertAlign;
      DstAppearance.Visible := Self.Visible;
      DstAppearance.Opacity := Self.Opacity;
      if not SamePosition(DstAppearance.PlaceOffset, Self.PlaceOffset) then
        DstAppearance.PlaceOffset.Assign(Self.PlaceOffset);
      if not SamePosition(DstAppearance.InternalPlaceOffset, Self.InternalPlaceOffset) then
        DstAppearance.InternalPlaceOffset.Assign(Self.InternalPlaceOffset);
      DstAppearance.InternalWidth := Self.InternalWidth;
      DstAppearance.InternalHeight := Self.InternalHeight;
    finally
      DstAppearance.EndUpdate;
    end;
  end
  else if ADest is TListItemDrawable then
  begin
    DstDrawable := TListItemDrawable(ADest);
    DstDrawable.BeginUpdate;
    try
      if (FOwner <> nil) and FOwner.StyleResourcesNeedUpdate then
        DstDrawable.UpdateValuesFromStyle;
      DstDrawable.Size := SizeWhenVisible;
      DstDrawable.Align := Self.Align;
      DstDrawable.VertAlign := Self.VertAlign;
      DstDrawable.Visible := Self.Visible;
      DstDrawable.Opacity := Self.Opacity;
      Offset := Self.ActualPlaceOffset;
      if not SamePosition(DstDrawable.PlaceOffset, Offset) then  // caution: PlaceOffset creates new PlaceOffset with OnChange handler
        DstDrawable.PlaceOffset.Point := Offset;
    finally
      DstDrawable.EndUpdate;
    end;
  end
  else
    inherited;
end;

constructor TCommonObjectAppearance.Create;
begin
  inherited;

  FOpacity := 1;
  FPlaceOffset := TPosition.Create(TPointF.Zero);
  FPlaceOffset.OnChange := OnPlaceOffsetChange;
  FInternalPlaceOffset := TPosition.Create(TPointF.Zero);
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
  Result := PlaceOffset.Point;
  if Result.X = 0 then
    Result.X := InternalPlaceOffset.X;
  if Result.Y = 0 then
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

function TCommonObjectAppearance.GetSizeWhenVisible: TPointF;
begin
  if Width <> 0 then
    Result.X := Width
  else
    Result.X := InternalWidth;
  if Height <> 0 then
    Result.Y := Height
  else
    Result.Y := InternalHeight;
end;

procedure TCommonObjectAppearance.InitDefaultValues(const ADefaults: TCommonObjectAppearance);
begin
  Assert(ADefaults.FUsingDefaultValues);
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
    Result := Opacity <> 1;
end;

function TCommonObjectAppearance.IsPlaceOffsetStored: Boolean;
begin
  if DefaultValues is TCommonObjectAppearance then
    Result := TCommonObjectAppearance(DefaultValues).PlaceOffset.Point <> PlaceOffset.Point
  else
    Result := PlaceOffset.Point <> TPointF.Zero;
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
  Old: TListItemDrawable;
begin
  LObject := AListViewItem.Objects.FindObjectT<T>(Name);
  if LObject <> nil then
    LObject.Assign(Self)
  else
  begin
    Old := AListViewItem.View.FindDrawable(Name);
    if Old <> nil then
      AListViewItem.View.Delete(AListViewItem.View.ViewList.IndexOf(Old));
    CreateObject(AListViewItem);
  end;
end;

procedure TCommonObjectAppearance.SetAlign(const Value: TListItemAlign);
begin
  if FAlign <> Value then
  begin
    FAlign := Value;
    DoChange;
  end;
end;

procedure TCommonObjectAppearance.SetInternalPlaceOffset(const Value: TPosition);
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

procedure TCommonObjectAppearance.SetPlaceOffset(const Value: TPosition);
begin
  FPlaceOffset.Assign(Value);  // DoChange called by TPosition.OnChange
end;

procedure TCommonObjectAppearance.SetWidth(const Value: Single);
var
  NewValue: Single;
begin
  NewValue := Value;
  if NewValue < 0 then
    NewValue := 0;

  if FWidth <> NewValue then
  begin
    FWidth := NewValue;
    DoChange;
  end;
end;

procedure TCommonObjectAppearance.SetInternalWidth(const Value: Single);
begin
  if FInternalWidth <> Value then
  begin
    FInternalWidth := Value;
    DoChange;
  end;
end;

procedure TCommonObjectAppearance.SetInternalHeight(const Value: Single);
begin
  if FInternalHeight <> Value then
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
  if NewValue < 0 then
    NewValue := 0;

  if FHeight <> NewValue then
  begin
    FHeight := NewValue;
    DoChange;
  end;
end;

procedure TCommonObjectAppearance.SetVertAlign(const Value: TListItemAlign);
begin
  if FVertAlign <> Value then
  begin
    FVertAlign := Value;
    DoChange;
  end;
end;

procedure TCommonObjectAppearance.SetBoundsRect(const AValue: TRect);
var
  NewRect: TRectF;
  Shim: IListViewDrawableShim;
begin
  Shim := FShim as IListViewDrawableShim;
  NewRect := Shim.CalcAppearanceBounds(AValue, TRectF.Create(FPlaceOffset.Point, FWidth, FHeight));
  FPlaceOffset.SetPointNoChange(NewRect.TopLeft);
  FWidth := NewRect.Width;
  FHeight := NewRect.Height;
  DoChange;
end;


{$ENDREGION}
{$REGION 'TCustomTextObjectAppearance'}

procedure TCustomTextObjectAppearance.AssignTo(ADest: TPersistent);
var
  DstDrawable: TListItemText;
  DstAppearance: TCustomTextObjectAppearance;
begin
  if ADest is TCustomTextObjectAppearance then
  begin
    DstAppearance := TCustomTextObjectAppearance(ADest);
    DstAppearance.BeginUpdate;
    try
      inherited AssignTo(ADest);
      DstAppearance.Font.Assign(Self.Font);
      DstAppearance.TextColor := Self.TextColor;
      DstAppearance.TextAlign := Self.TextAlign;
      DstAppearance.TextVertAlign := Self.TextVertAlign;
      DstAppearance.WordWrap := Self.WordWrap;
      DstAppearance.Opacity := Self.Opacity;
      DstAppearance.Trimming := Self.Trimming;
      DstAppearance.IsDetailText := Self.IsDetailText;
    finally
      DstAppearance.EndUpdate;
    end;
  end
  else if ADest is TListItemText then
  begin
    DstDrawable := TListItemText(ADest);
    DstDrawable.BeginUpdate;
    try
      inherited AssignTo(ADest);
      if (Self.Font.Family <> DstDrawable.Font.Family) and Self.Font.IsFamilyStored or FFontDirty then
        DstDrawable.Font.Family := Self.Font.Family;
      if (Self.Font.Size <> DstDrawable.Font.Size) and Self.Font.IsSizeStored or FFontDirty then
        DstDrawable.Font.Size := Self.Font.Size;
      if (DstDrawable.Font.Style <> Self.Font.Style) and not Self.Font.StyleExt.IsRegular or FFontDirty then
        DstDrawable.Font.Style := Self.Font.Style;
      if Self.TextColor <> TAlphaColorRec.Null then
        DstDrawable.TextColor := Self.TextColor;
      DstDrawable.TextAlign := Self.TextAlign;
      DstDrawable.TextVertAlign := Self.TextVertAlign;
      DstDrawable.WordWrap := Self.WordWrap;
      DstDrawable.Opacity := Self.Opacity;
      DstDrawable.Trimming := Self.Trimming;
      DstDrawable.IsDetailText := Self.IsDetailText;
    finally
      DstDrawable.EndUpdate;
    end;
  end
  else
    inherited;
end;

constructor TCustomTextObjectAppearance.Create;
begin
  inherited;
  FName := TListViewItem.TObjectNames.Text;

  FFont := TFont.Create;
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

procedure TCustomTextObjectAppearance.ResetObject(const AListViewItem: TListViewItem);
begin
  ResetObjectT<TListItemText>(AListViewItem);
end;

procedure TCustomTextObjectAppearance.CreateObject(const AListViewItem: TListViewItem);
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
  FFontDirty := True;
  try
    DoChange;
  finally
    FFontDirty := False;
  end;
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
  if FIsDetailText <> Value then
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
  if FTextAlign <> Value then
  begin
    FTextAlign := Value;
    DoChange;
  end;
end;

procedure TCustomTextObjectAppearance.SetTextColor(const Value: TAlphaColor);
begin
  if FTextColor <> Value then
  begin
    FTextColor := Value;
    DoChange;
  end;
end;

procedure TCustomTextObjectAppearance.SetTextVertAlign(const Value: TTextAlign);
begin
  if FTextVertAlign <> Value then
  begin
    FTextVertAlign := Value;
    DoChange;
  end;
end;

procedure TCustomTextObjectAppearance.SetTrimming(const Value: TTextTrimming);
begin
  if FTrimming <> Value then
  begin
    FTrimming := Value;
    DoChange;
  end;
end;

procedure TCustomTextObjectAppearance.SetWordWrap(const Value: Boolean);
begin
  if FWordWrap <> Value then
  begin
    FWordWrap := Value;
    DoChange;
  end;
end;

{$ENDREGION}
{$REGION 'TCustomImageObjectAppearance'}

procedure TCustomImageObjectAppearance.AssignTo(ADest: TPersistent);
var
  DstDrawable: TListItemImage;
  DstAppearance: TCustomImageObjectAppearance;
begin
  if ADest is TCustomImageObjectAppearance then
  begin
    DstAppearance := TCustomImageObjectAppearance(ADest);
    DstAppearance.BeginUpdate;
    try
      inherited AssignTo(ADest);
      DstAppearance.ScalingMode := Self.ScalingMode;
      DstAppearance.Opacity := Self.Opacity;
    finally
      DstAppearance.EndUpdate;
    end;
  end
  else if ADest is TListItemImage then
  begin
    DstDrawable := TListItemImage(ADest);
    DstDrawable.BeginUpdate;
    try
      inherited AssignTo(ADest);
      DstDrawable.ScalingMode := Self.ScalingMode;
      DstDrawable.Opacity := Self.Opacity;
    finally
      DstDrawable.EndUpdate;
    end;
  end
  else
    inherited;
end;

constructor TCustomImageObjectAppearance.Create;
begin
  inherited;
  FName := TListViewItem.TObjectNames.Image;
end;

function TCustomImageObjectAppearance.CreateDefaultValues: TObjectAppearance;
var
  LDefaults: TCustomImageObjectAppearance;
begin
  LDefaults := TCustomImageObjectAppearance.Create(True);
  InitDefaultValues(LDefaults);
  Result := LDefaults;
end;

procedure TCustomImageObjectAppearance.ResetObject(const AListViewItem: TListViewItem);
begin
  ResetObjectT<TListItemImage>(AListViewItem);
end;

procedure TCustomImageObjectAppearance.CreateObject(const AListViewItem: TListViewItem);
var
  LImageDrawable: TListItemImage;
begin
  LImageDrawable := TListItemImage.Create(AListViewItem);
  LImageDrawable.BeginUpdate;
  try
    LImageDrawable.Name := FName;
    LImageDrawable.OwnsBitmap := False; // Always reference listitem's bitmap
    if FName = TListViewItem.TObjectNames.Image then
    begin
      if AListViewItem.BitmapRef <> nil then
        LImageDrawable.Bitmap := AListViewItem.BitmapRef
      else
        LImageDrawable.Bitmap := AListViewItem.Bitmap;
      LImageDrawable.ImageIndex := AListViewItem.ImageIndex;
    end
    else if AListViewItem.GetHasData(FName) then
      LImageDrawable.Data := AListViewItem.GetData(FName);
    LImageDrawable.Assign(Self);
  finally
    LImageDrawable.EndUpdate;
  end;
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

procedure TCustomImageObjectAppearance.SetScalingMode(const Value: TImageScalingMode);
begin
  if FScalingMode <> Value then
  begin
    FScalingMode := Value;
    DoChange;
  end;
end;

{$ENDREGION}
{$REGION 'TCustomAccessoryObjectAppearance'}

procedure TCustomAccessoryObjectAppearance.AssignTo(ADest: TPersistent);
var
  DstDrawable: TListItemAccessory;
  DstAppearance: TCustomAccessoryObjectAppearance;
begin
  if ADest is TCustomAccessoryObjectAppearance then
  begin
    DstAppearance := TCustomAccessoryObjectAppearance(ADest);
    DstAppearance.BeginUpdate;
    try
      inherited AssignTo(ADest);
      DstAppearance.AccessoryType := Self.AccessoryType;
    finally
      DstAppearance.EndUpdate;
    end;
  end
  else if ADest is TListItemAccessory then
  begin
    DstDrawable := TListItemAccessory(ADest);
    DstDrawable.BeginUpdate;
    try
      inherited AssignTo(ADest);
      DstDrawable.AccessoryType := Self.AccessoryType;
    finally
      DstDrawable.EndUpdate;
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

procedure TCustomAccessoryObjectAppearance.CreateObject(const AListViewItem: TListViewItem);
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

procedure TCustomAccessoryObjectAppearance.ResetObject(const AListViewItem: TListViewItem);
begin
  ResetObjectT<TListItemAccessory>(AListViewItem);
end;

procedure TCustomAccessoryObjectAppearance.SetAccessoryType(const Value: TAccessoryType);
begin
  if FAccessoryType <> Value then
  begin
    FAccessoryType := Value;
    DoChange;
  end;
end;

{$ENDREGION}
{$REGION 'TCustomTextButtonObjectAppearance'}

procedure TCustomTextButtonObjectAppearance.AssignTo(ADest: TPersistent);
var
  DstDrawable: TListItemTextButton;
  DstAppearance: TCustomTextButtonObjectAppearance;
begin
  if ADest is TCustomTextButtonObjectAppearance then
  begin
    DstAppearance := TCustomTextButtonObjectAppearance(ADest);
    DstAppearance.BeginUpdate;
    try
      inherited AssignTo(ADest);
      DstAppearance.ButtonType := Self.ButtonType;
      DstAppearance.Text := Self.Text;
      DstAppearance.Font.Assign(Self.Font);
      DstAppearance.TextAlign := Self.TextAlign;
      DstAppearance.TextVertAlign := Self.TextVertAlign;
      DstAppearance.WordWrap := Self.WordWrap;
      DstAppearance.Opacity := Self.Opacity;
      DstAppearance.Trimming := Self.Trimming;
      DstAppearance.TextColor := Self.TextColor;
      DstAppearance.TintColor := Self.TintColor;
      DstAppearance.PressedTextColor := Self.PressedTextColor;
      DstAppearance.TextShadowColor := Self.TextShadowColor;
      DstAppearance.Enabled := Self.Enabled;
    finally
      DstAppearance.EndUpdate;
    end;
  end
  else if ADest is TListItemTextButton then
  begin
    DstDrawable := TListItemTextButton(ADest);
    DstDrawable.BeginUpdate;
    try
      inherited AssignTo(ADest);
      DstDrawable.ButtonType := Self.ButtonType;
      if not FHasButtonText then
        DstDrawable.Text := Self.Text;
      if Self.Font.IsFamilyStored then
        DstDrawable.Font.Family := Self.Font.Family;
      if Self.Font.IsSizeStored then
        DstDrawable.Font.Size := Self.Font.Size;
      if DstDrawable.Font.Style <> Self.Font.Style then
        DstDrawable.Font.Style := Self.Font.Style;
      DstDrawable.TextAlign := Self.TextAlign;
      DstDrawable.TextVertAlign := Self.TextVertAlign;
      DstDrawable.WordWrap := Self.WordWrap;
      DstDrawable.Trimming := Self.Trimming;
      if Self.TextColor <> TAlphaColorRec.Null then
        DstDrawable.TextColor := Self.TextColor;
      if Self.TintColor <> TAlphaColorRec.Null then
        DstDrawable.TintColor := Self.TintColor;
      if Self.PressedTextColor <> TAlphaColorRec.Null then
        DstDrawable.PressedTextColor := Self.PressedTextColor;
      if Self.TextShadowColor <> TAlphaColorRec.Null then
        DstDrawable.TextShadowColor := Self.TextShadowColor;
      DstDrawable.Enabled := Self.Enabled;
      DstDrawable.Opacity := Self.Opacity;
    finally
      DstDrawable.EndUpdate;
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
  FTintColor := TAlphaColorRec.Null;
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

procedure TCustomTextButtonObjectAppearance.CreateObject(const AListViewItem: TListViewItem);
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

function TCustomTextButtonObjectAppearance.IsTintColorStored: Boolean;
begin
  if DefaultValues is TCustomTextButtonObjectAppearance then
    Result := TintColor <> TCustomTextButtonObjectAppearance(DefaultValues).TintColor
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

procedure TCustomTextButtonObjectAppearance.ResetObject(const AListViewItem: TListViewItem);
begin
  if AListViewItem.GetHasData(FName) then
    FHasButtonText := True; // don't overwrite item text with default value from appearance
  try
    ResetObjectT<TListItemTextButton>(AListViewItem);
  finally
    FHasButtonText := False;
  end;
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

procedure TCustomTextButtonObjectAppearance.SetPressedTextColor(const Value: TAlphaColor);
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

procedure TCustomTextButtonObjectAppearance.SetTextAlign(const Value: TTextAlign);
begin
  if Value <> FTextAlign then
  begin
    FTextAlign := Value;
    DoChange;
  end;
end;

procedure TCustomTextButtonObjectAppearance.SetTextColor(const Value: TAlphaColor);
begin
  if FTextColor <> Value then
  begin
    FTextColor := Value;
    DoChange;
  end;
end;

procedure TCustomTextButtonObjectAppearance.SetTintColor(const Value: TAlphaColor);
begin
  if FTintColor <> Value then
  begin
    FTintColor := Value;
    DoChange;
  end;
end;

procedure TCustomTextButtonObjectAppearance.SetTextShadowColor(const Value: TAlphaColor);
begin
  if FTextShadowColor <> Value then
  begin
    FTextShadowColor := Value;
    DoChange;
  end;
end;

procedure TCustomTextButtonObjectAppearance.SetTextVertAlign(const Value: TTextAlign);
begin
  if Value <> FTextVertAlign then
  begin
    FTextVertAlign := Value;
    DoChange;
  end;
end;

procedure TCustomTextButtonObjectAppearance.SetTrimming(const Value: TTextTrimming);
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

{$ENDREGION}
{$REGION 'TCustomGlyphButtonObjectAppearance'}

procedure TCustomGlyphButtonObjectAppearance.AssignTo(ADest: TPersistent);
var
  DstDrawable: TListItemGlyphButton;
  DstAppearance: TCustomGlyphButtonObjectAppearance;
begin
  if ADest is TCustomGlyphButtonObjectAppearance then
  begin
    DstAppearance := TCustomGlyphButtonObjectAppearance(ADest);
    DstAppearance.BeginUpdate;
    try
      inherited AssignTo(ADest);
      DstAppearance.ButtonType := Self.ButtonType;
      DstAppearance.ClickOnSelect := Self.ClickOnSelect;
      DstAppearance.Opacity := Self.Opacity;
      DstAppearance.Enabled := Self.Enabled;
    finally
      DstAppearance.EndUpdate;
    end;
  end
  else if ADest is TListItemGlyphButton then
  begin
    DstDrawable := TListItemGlyphButton(ADest);
    DstDrawable.BeginUpdate;
    try
      inherited AssignTo(ADest);
      DstDrawable.ButtonType := Self.ButtonType;
      DstDrawable.ClickOnSelect := Self.ClickOnSelect;
      DstDrawable.Enabled := Self.Enabled;
      DstDrawable.Opacity := Self.Opacity;
    finally
      DstDrawable.EndUpdate;
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
  FClickOnSelect := True;
end;

function TCustomGlyphButtonObjectAppearance.CreateDefaultValues: TObjectAppearance;
var
  LDefaults: TCustomGlyphButtonObjectAppearance;
begin
  LDefaults := TCustomGlyphButtonObjectAppearance.Create(True);
  InitDefaultValues(LDefaults);
  Result := LDefaults;
end;

procedure TCustomGlyphButtonObjectAppearance.CreateObject(const AListViewItem: TListViewItem);
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
      LItem.Checked := AListViewItem.FChecked
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

procedure TCustomGlyphButtonObjectAppearance.ResetObject(const AListViewItem: TListViewItem);
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

{$ENDREGION}
{$REGION 'TItemAppearanceObjects'}

constructor TItemAppearanceObjects.Create(const Owner: TControl);
begin
  inherited Create(Owner);
  FText := TTextObjectAppearance.Create;
  FText.DataMembers := TObjectAppearance.TDataMembers.Create(
    TObjectAppearance.TDataMember.Create(TListViewItem.TMemberNames.Text, TListViewItem.TMemberNames.Text));

  FDetail := TTextObjectAppearance.Create;
  FDetail.Name := TListViewItem.TObjectNames.Detail;
  FDetail.DataMembers := TObjectAppearance.TDataMembers.Create(
    TObjectAppearance.TDataMember.Create(TListViewItem.TMemberNames.Detail, TListViewItem.TMemberNames.Detail));

  FImage := TImageObjectAppearance.Create;
  FImage.DataMembers :=
    [TObjectAppearance.TDataMember.Create(TListViewItem.TMemberNames.Bitmap, TListViewItem.TMemberNames.Bitmap),
     TObjectAppearance.TDataMember.Create(TListViewItem.TMemberNames.ImageIndex, TListViewItem.TMemberNames.ImageIndex)];

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

function TItemAppearanceObjects.UpdateObject(const AObjectAppearance: TCommonObjectAppearance; APublished: Boolean):
  TCommonObjectAppearance;

  procedure Update(var Store: TArray<TCommonObjectAppearance>);
  var
    I: Integer;
  begin
    for I := Low(Store) to High(Store) do
      if SameText(Store[I].Name, AObjectAppearance.Name) then
      begin
        if Result = nil then
          Result := Store[I];
        Store[I] := AObjectAppearance;
        Exit;
      end;
    SetLength(Store, Length(Store) + 1);
    Store[High(Store)] := AObjectAppearance;
  end;
begin
  Result := nil;
  Update(FObjects);
  Update(FPublishedObjects);
end;

procedure TItemAppearanceObjects.RemoveObject(const AObjectAppearance: TCommonObjectAppearance);
  procedure RemoveFrom(var Store: TArray<TCommonObjectAppearance>);
  var
    I, K: Integer;
  begin
    for I := Low(Store) to High(Store) do
      if Store[I] = AObjectAppearance then
      begin
        for K := I to High(Store) - 1 do
          Store[K] := Store[K + 1];
        SetLength(Store, Length(Store) - 1);
        Break;
      end;
  end;
begin
  RemoveFrom(FObjects);
  RemoveFrom(FPublishedObjects);
end;


procedure TItemAppearanceObjects.AssignTo(ADest: TPersistent);
var
  Dest: TItemAppearanceObjects;
begin
  if ADest is TItemAppearanceObjects then
  begin
    Dest := TItemAppearanceObjects(ADest);
    Dest.Text := Self.Text;
    Dest.Detail := Self.Detail;
    Dest.Image := Self.Image;
    Dest.Accessory := Self.Accessory;
    Dest.TextButton := Self.TextButton;
    Dest.GlyphButton := Self.GlyphButton;
    Dest.Height := Self.Height;
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

{$ENDREGION}
{$REGION 'TItemAppearanceProperties'}
constructor TItemAppearanceProperties.Create(const Owner: TControl; AType: TAppearanceType);
begin
  FOwnerControl := Owner;
  FAppearanceType := AType;
  case AType of
    TAppearanceType.Item,
    TAppearanceType.ItemEdit:
      FPurpose := TListItemPurpose.None;
    TAppearanceType.Header:
      FPurpose := TListItemPurpose.Header;
    TAppearanceType.Footer:
      FPurpose := TListItemPurpose.Footer;
  else
    Assert(False);
  end;
  // Keep last appearance around because ListItems reference an appearance
  FAppearanceCache := TObjectDictionary<TItemAppearanceObjectsClass, TItemAppearanceObjects>.Create([doOwnsValues]);
end;

destructor TItemAppearanceProperties.Destroy;
begin
  if Assigned(FOnDestroy) then
    FOnDestroy(Self);
  UnbindShim;
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
    if Self = PropertiesOwner.ItemEditAppearanceProperties then
    begin
      if not PropertiesOwner.IsEditMode then
        Result := False;
    end
    else if Self = PropertiesOwner.ItemAppearanceProperties then
    begin
      if PropertiesOwner.IsEditMode and (PropertiesOwner.ItemEditAppearanceProperties.Objects <> nil) then
        Result := False;
    end;
  end;
end;

function TItemAppearanceProperties.GetAppearanceClassName: string;
begin
  if FAppearanceClass <> nil then
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

function TItemAppearanceProperties.PropertiesOwner: IPublishedAppearanceOwner;
begin
  if FPropertiesOwner = nil then
    Supports(FOwnerControl, IPublishedAppearanceOwner, FPropertiesOwner);
  Result := FPropertiesOwner;
end;

procedure TItemAppearanceProperties.SetHeight(AValue: Integer);
begin
  if FAppearance <> nil then
    FAppearance.Height := AValue;
end;

procedure TItemAppearanceProperties.SetObjects(const Value: TItemAppearanceObjects);
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
  if Value = TAppearanceNames.Empty then
    LFactory := TEmptyItemObjects
  else if Value = TAppearanceNames.Null  then
    LFactory := TNullItemObjects;
  if LFactory = nil then
    // Look for display name
    for LPair in TAppearancesRegistry.FFactories do
    begin
      if SameText(LPair.Value.Name, Value) then
      begin
        LFactory := LPair.Key;
        Break;
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
  for LPair in TAppearancesRegistry.FFactories do
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
  PropertiesOwner.ItemAppearanceChange(Self);
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

procedure TItemAppearanceProperties.DoChangeObjects;
begin
  PropertiesOwner.ItemAppearanceChangeObjects(Self);
end;

procedure TItemAppearanceProperties.DoChangeHeight;
begin
  PropertiesOwner.ItemAppearanceChangeHeight(Self);
end;

procedure TItemAppearanceProperties.SetAppearanceClass(const Value: TItemAppearanceObjectsClass);
var
  LPair: TPair<TItemAppearanceObjectsClass, TRegisterAppearanceValue>;
  LAppearance: TItemAppearanceObjects;
begin
  if Value <> FAppearanceClass then
  begin
    FName := '';
    if FAppearance <> nil then
    begin
      FAppearance.TakeOwnership(FOwnerControl);
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
      for LPair in TAppearancesRegistry.FFactories do
        if LPair.Key = FAppearanceClass then
        begin
          FName := LPair.Value.Name;
          Break;
        end;
      Assert(FAppearance = nil);
      FAppearance := FAppearanceClass.Create(FOwnerControl);
      if csDesigning in FOwnerControl.ComponentState then
        // At design time, preserve changes to an appearance when switch do a different appearance
        // and then back
        if FAppearanceCache <> nil then
          if FAppearanceCache.TryGetValue(FAppearanceClass, LAppearance) then
            FAppearance.Assign(LAppearance);
      FAppearance.OnChange := PropertiesChange;
      FAppearance.OnChangeHeight := PropertiesChangeHeight;
    end;
    DoChangeObjects;
  end;
end;

function TItemAppearanceProperties.GetBoundsRect: TRect;
begin
  if FShim <> nil then
    Result := FShim.GetBoundsRect
  else
    Result := TRect.Empty;
end;

function TItemAppearanceProperties.GetDesignParent: TPersistent;
begin
  Result := FOwnerControl;
end;

function TItemAppearanceProperties.GetSprig: TPersistent;
begin
  Result := FSprig;
end;

procedure TItemAppearanceProperties.SetSprig(const APersistent: TPersistent);
var
  Designable: IDesignablePersistent;
begin
  FSprig := APersistent;
  // Bind the sprig to the item shim
  if Supports(APersistent, IDesignablePersistent, Designable) then
  begin
    Designable.Bind(FShim);
    Designable := nil;
  end;
end;

function TItemAppearanceProperties.BeingDesigned: Boolean;
var
  Parent: IListViewDesignPresentationParent;
begin
  Result := Supports(Owner, IListViewDesignPresentationParent, Parent) and Parent.HasDesignPresentationAttached;
end;

procedure TItemAppearanceProperties.BindShim(AShim: IPersistentShim);
var
  Designable: IDesignablePersistent;
begin
  FShim := AShim;
  // Bind the sprig to the item shims
  if Supports(FSprig, IDesignablePersistent, Designable) then
  begin
    Designable.Bind(FShim);
    Designable := nil;
  end;
end;

procedure TItemAppearanceProperties.UnbindShim;
var
  Designable: IDesignablePersistent;
begin
  if Supports(FSprig, IDesignablePersistent, Designable) then
  begin
    Designable.Unbind;
    Designable := nil;
  end;
  FShim := nil;
end;

{$ENDREGION}
{$REGION 'TAppearanceObjects'}
constructor TAppearanceObjects.Create(const Owner: TControl);
begin
  inherited Create;
  FOwnerControl := Owner;
end;

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
  if FOwnerControl <> nil then
    FOwnerControl.BeginUpdate;
end;

procedure TAppearanceObjects.EndUpdate;
begin
  if FOwnerControl <> nil then
    FOwnerControl.EndUpdate;
end;

procedure TAppearanceObjects.ResetObjects(const AListViewItem: TListViewItem; const FinalSize: TSizeF);
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

procedure TAppearanceObjects.DoChangeHeight;
begin
  if Assigned(FOnChangeHeight) then
    FOnChangeHeight(Self);
end;

function TAppearanceObjects.GetHeight: Integer;
begin
  Result := cDefaultHeight;
end;

function TAppearanceObjects.GetPublishedObjects: TArray<TCommonObjectAppearance>;
begin
  Result := nil;
end;

function TAppearanceObjects.GetStyleResources: TListItemStyleResources;
begin
  Result := nil;
  if FResources <> nil then
    Result := FResources.StyleResources;
end;

function TAppearanceObjects.StyleResourcesNeedUpdate: Boolean;
begin
  Result := (FResources <> nil) and FResources.StyleResourcesNeedUpdate;
end;

procedure TAppearanceObjects.TakeOwnership(const NewOwner: TControl);
begin
  FOwnerControl := NewOwner;
  Supports(FOwnerControl, IListItemStyleResources, FResources);
end;

function TAppearanceObjects.GetObjects: TArray<TCommonObjectAppearance>;
begin
  Result := nil;
end;

procedure TAppearanceObjects.ItemPropertyChange(Sender: TObject);
begin
  DoChange;
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

procedure TAppearanceObjects.UpdateSizes(const FinalSize: TSizeF);
begin
  // Do nothing
end;

{$ENDREGION}
{$REGION 'TCustomItemObjects'}

constructor TCustomItemObjects.Create(const Owner: TControl);
  procedure SetTextDefaults(const AText: TTextObjectAppearance);
  begin
    AText.DefaultValues.Align := TListItemAlign.Leading;
    AText.DefaultValues.TextVertAlign := TTextAlign.Center;
    AText.DefaultValues.TextAlign := TTextAlign.Leading;
    AText.DefaultValues.Trimming := TTextTrimming.Character;
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
  TextButton.DefaultValues.Trimming := TTextTrimming.Character;
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
  DefaultHeightNoStyle = 30;
  DefaultWidthNoStyle = 30;
begin
  LWidth := DefaultWidthNoStyle;
  LHeight := DefaultHeightNoStyle;
  if AStyleResources <> nil then
    if AStyleResources.AccessoryImages[AAccessory.AccessoryType].Normal <> nil then
    begin
      LWidth := AStyleResources.AccessoryImages[AAccessory.AccessoryType].Normal.Width;
      LHeight := AStyleResources.AccessoryImages[AAccessory.AccessoryType].Normal.Height;
    end;
  AAccessory.InternalWidth := LWidth;
  AAccessory.InternalHeight := LHeight;
end;

procedure TCustomItemObjects.SetInternalSize(const AGlyphButton: TGlyphButtonObjectAppearance;
  AStyleResources: TListItemStyleResources);
const
  DefaultHeightNoStyle = 30;
  DefaultWidthNoStyle = 30;
var
  LWidth: Single;
  LHeight: Single;
begin
  LWidth := DefaultWidthNoStyle;
  LHeight := DefaultHeightNoStyle;
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

procedure TCustomItemObjects.UpdateSizes(const FinalSize: TSizeF);
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

{$ENDREGION}
{$REGION 'TEmptyItemObjects'}

constructor TEmptyItemObjects.Create(const Owner: TControl);
begin
  inherited;
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

{$ENDREGION}

{$REGION 'TPresetItemObjects'}

function TPresetItemObjects.GetGroupClass: TGroupClass;
begin
  Result := nil;
end;

function TPresetItemObjects.GetIsItemEdit: Boolean;
var
  LAppearance: TRegisteredAppearance;
begin
  Result := False;
  for LAppearance in TAppearancesRegistry.GetRegisteredAppearances do
    if LAppearance.Value = Self.ClassType then
    begin
      Result :=  TRegisterAppearanceOption.ItemEdit in LAppearance.Options;
      break;
    end;
end;

procedure TPresetItemObjects.ResetObjects(const AListViewItem: TListViewItem; const FinalSize: TSizeF);
  function IndexOf(const Arr: TArray<TCommonObjectAppearance>; const Name: string): Integer;
  begin
    for Result := Low(Arr) to High(Arr) do
      if Arr[Result].Name = Name then
        Exit;
    Result := -1;
  end;
  procedure UpdateDeleted(const Ref: TArray<TCommonObjectAppearance>; View: TListViewItem.TListViewItemObjects);
  var
    I: Integer;
  begin
    for I := View.Count - 1 downto 0 do
      if IndexOf(Ref, View[I].Name) = -1 then
      begin
        if AListViewItem.HasData[View[I].Name] then
          AListViewItem.ClearData(View[I].Name);
        View.Delete(I);
      end;
  end;
var
  LObjectAppearance: TCommonObjectAppearance;
  LGroupClass: TGroupClass;
  LObjects: TListViewItem.TListViewItemObjects;
  LAppearanceObjects: TArray<TCommonObjectAppearance>;
  I: Integer;
begin
  LObjects := AListViewItem.Objects;
  LAppearanceObjects := GetObjects;
  BeginUpdate;
  try
    UpdateSizes(FinalSize);  // May change properties of appearance
    LGroupClass := GroupClass;
    if (LGroupClass <> nil) and (LObjects.Appearance <> nil) and LObjects.Appearance.InheritsFrom(LGroupClass) then
    begin
      AListViewItem.BeginUpdate;
      try
        if LObjects.Count > Length(LAppearanceObjects) then
          UpdateDeleted(LAppearanceObjects, LObjects);

        // Drawables will be updated, missing ones will be created
        for I := 0 to High(LAppearanceObjects) do
          LAppearanceObjects[I].ResetObject(AListViewItem);

        if LObjects.Count > Length(LAppearanceObjects) then
          UpdateDeleted(LAppearanceObjects, LObjects);
      finally
        AListViewItem.EndUpdate;
      end;
    end
    else
    begin
      AListViewItem.BeginUpdate;
      try
        LObjects.Clear;
        LObjects.ViewList.Capacity := Length(GetObjects);
        for LObjectAppearance in GetObjects do
          // create rendering objects and set properties
          LObjectAppearance.CreateObject(AListViewItem);
      finally
        AListViewItem.EndUpdate;
      end;
    end;
  finally
    EndUpdate;
  end;
  LObjects.Appearance := Self;
end;

{$ENDREGION}
{$REGION 'Preset appearance classes'}

type
  TPresetBase = class(TPresetItemObjects)
  const
    cTextMarginAccessory = 7;
    cTextMarginDetail = 4;
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
    constructor Create(const Owner: TControl); override;
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
    procedure UpdateSizes(const FinalSize: TSizeF); override;
    function DefaultHeight: Integer; override;
  public
    constructor Create(const Owner: TControl); override;
  published
    property Text;
  end;

  TListItemAppearance = class(TPresetBase)
  protected
    procedure UpdateSizes(const FinalSize: TSizeF); override;
  public
    constructor Create(const Owner: TControl); override;
  published
    property Text;
    property Accessory;
  end;

  TListItemDeleteAppearance = class(TListItemAppearance)
  private const
    DefaultGlyph = TGlyphButtonType.Delete;
  public
    constructor Create(const Owner: TControl); override;
  published
    property GlyphButton;
  end;

  TListItemShowCheckAppearance = class(TListItemAppearance)
  private const
    DefaultGlyph = TGlyphButtonType.Checkbox;
  public
    constructor Create(const Owner: TControl); override;
  published
    property GlyphButton;
  end;

  TListItemRightDetailAppearance = class(TPresetBase)
  protected
    procedure UpdateSizes(const FinalSize: TSizeF); override;
  public
    constructor Create(const Owner: TControl); override;
  published
    property Text;
    property Accessory;
    property Detail;
  end;

  TListItemRightDetailDeleteAppearance = class(TListItemRightDetailAppearance)
  private const
    DefaultGlyph = TGlyphButtonType.Delete;
  public
    constructor Create(const Owner: TControl); override;
  published
    property GlyphButton;
  end;

  TListItemRightDetailShowCheckAppearance = class(TListItemRightDetailAppearance)
  private const
    DefaultGlyph = TGlyphButtonType.Checkbox;
  public
    constructor Create(const Owner: TControl); override;
  published
    property GlyphButton;
  end;

  TImageListItemAppearance = class(TPresetBase)
  public const
    cDefaultImagePlaceOffsetX = -3;
    cDefaultImageTextPlaceOffsetX = 4;
  protected
    procedure UpdateSizes(const FinalSize: TSizeF); override;
  public
    constructor Create(const Owner: TControl); override;
  published
    property Text;
    property Accessory;
    property Image;
  end;

  TImageListItemDeleteAppearance = class(TImageListItemAppearance)
  private const
    DefaultGlyph = TGlyphButtonType.Delete;
  public
    constructor Create(const Owner: TControl); override;
  published
    property GlyphButton;
  end;

  TImageListItemShowCheck = class(TImageListItemAppearance)
  private const
    DefaultGlyph = TGlyphButtonType.Checkbox;
  public
    constructor Create(const Owner: TControl); override;
  published
    property GlyphButton;
  end;

  TImageListItemRightButtonAppearance = class(TPresetBase)
  protected
    procedure UpdateSizes(const FinalSize: TSizeF); override;
  public
    constructor Create(const Owner: TControl); override;
  published
    property Text;
    property TextButton;
    property Image;
  end;

  TImageListItemRightButtonDeleteAppearance = class(TImageListItemRightButtonAppearance)
  private const
    DefaultGlyph = TGlyphButtonType.Delete;
  public
    constructor Create(const Owner: TControl); override;
  published
    property GlyphButton;
  end;

  TImageListItemRightButtonShowCheckAppearance = class(TImageListItemRightButtonAppearance)
  private const
    DefaultGlyph = TGlyphButtonType.Checkbox;
  public
    constructor Create(const Owner: TControl); override;
  published
    property GlyphButton;
  end;

  TImageListItemBottomDetailAppearance = class(TPresetBase)
  public const
    cDefaultImagePlaceOffsetX = -3;
    cDefaultTextPlaceOffsetY = -9;
    cDefaultDetailPlaceOffsetY = 9;
    cDefaultTextAccessorySpace = 4;
  protected
    procedure UpdateSizes(const FinalSize: TSizeF); override;
  public
    constructor Create(const Owner: TControl); override;
  published
    property Text;
    property Detail;
    property Accessory;
    property Image;
  end;

  TImageListItemBottomDetailShowCheckAppearance = class(TImageListItemBottomDetailAppearance)
  private const
    DefaultGlyph = TGlyphButtonType.Checkbox;
  public
    constructor Create(const Owner: TControl); override;
  published
    property GlyphButton;
  end;

  TImageListItemBottomDetailRightButtonAppearance = class(TPresetBase)
  public const
    cDefaultImagePlaceOffsetX = -3;
    cDefaultTextPlaceOffsetY = -9;
    cDefaultDetailPlaceOffsetY = 9;
    cDefaultTextRightButtonSpace = 4;
  protected
    procedure UpdateSizes(const FinalSize: TSizeF); override;
  public
    constructor Create(const Owner: TControl); override;
  published
    property Text;
    property Detail;
    property Image;
    property TextButton;
  end;

  TImageListItemBottomDetailRightButtonShowCheckAppearance = class(TImageListItemBottomDetailRightButtonAppearance)
  private const
    DefaultGlyph = TGlyphButtonType.Checkbox;
  public
    constructor Create(const Owner: TControl); override;
  published
    property GlyphButton;
  end;

{$ENDREGION}
{$REGION 'TPresetBase'}

function TPresetBase.GetGroupClass: TPresetItemObjects.TGroupClass;
begin
  Assert(FGroupClass <> nil);
  Result := FGroupClass;
end;

function TPresetBase.GetIsItemEdit: Boolean;
begin
  Result := FIsItemEdit;
end;

{$ENDREGION}
{$REGION 'TListItemAppearance'}

constructor TListItemAppearance.Create(const Owner: TControl);
begin
  FGroupClass := TListItemAppearance;
  inherited;
  Text.DefaultValues.Visible := True;
  Text.RestoreDefaults;
  Accessory.DefaultValues.Visible := True;
  Accessory.RestoreDefaults;
  AddObject(Text, True);
  AddObject(Accessory, True);
  AddObject(GlyphButton, IsItemEdit);
end;

procedure TListItemAppearance.UpdateSizes(const FinalSize: TSizeF);
var
  LInternalWidth: Single;
begin
  BeginUpdate;
  try
    inherited;
    LInternalWidth := FinalSize.Width - Text.ActualPlaceOffset.X - Accessory.ActualWidth;
    if Accessory.ActualWidth > 0 then
      LInternalWidth := LInternalWidth - cTextMarginAccessory;
    Text.InternalWidth := Max(1, LInternalWidth);
  finally
    EndUpdate;
  end;
end;

{$ENDREGION}
{$REGION 'TListItemDeleteAppearance'}

constructor TListItemDeleteAppearance.Create(const Owner: TControl);
begin
  FIsItemEdit := True;
  inherited;
  Accessory.DefaultValues.Visible := False;
  Accessory.RestoreDefaults;
  GlyphButton.DefaultValues.ButtonType := DefaultGlyph;
  GlyphButton.DefaultValues.Visible := True;
  GlyphButton.RestoreDefaults;
end;

{$ENDREGION}
{$REGION 'TListItemShowCheckAppearance'}

constructor TListItemShowCheckAppearance.Create(const Owner: TControl);
begin
  FIsItemEdit := True;
  inherited;
  Accessory.DefaultValues.Visible := False;
  Accessory.RestoreDefaults;
  GlyphButton.DefaultValues.ButtonType := DefaultGlyph;
  GlyphButton.DefaultValues.Visible := True;
  GlyphButton.RestoreDefaults;
end;

{$ENDREGION}
{$REGION 'TListItemRightDetailAppearance'}

constructor TListItemRightDetailAppearance.Create(const Owner: TControl);
begin
  FGroupClass := TListItemRightDetailAppearance;
  inherited;
  Text.DefaultValues.Visible := True;
  Text.RestoreDefaults;
  Detail.DefaultValues.Visible := True;
  Detail.DefaultValues.Align := TListItemAlign.Trailing;
  Detail.DefaultValues.TextAlign := TTextAlign.Trailing;
  Detail.RestoreDefaults;
  Accessory.DefaultValues.Visible := True;
  Accessory.RestoreDefaults;
  AddObject(Text, True);
  AddObject(Detail, True);
  AddObject(Accessory, True);
  AddObject(GlyphButton, IsItemEdit);
end;

procedure TListItemRightDetailAppearance.UpdateSizes(const FinalSize: TSizeF);
var
  LInternalWidth: Single;
begin
  BeginUpdate;
  try
    inherited;
    Text.InternalWidth := FinalSize.Width * 0.6;
    if Detail.Align = TListItemAlign.Trailing then
    begin
      Detail.InternalPlaceOffset.X := - (Accessory.ActualWidth + cTextMarginAccessory);
      LInternalWidth := (FinalSize.Width + Detail.ActualPlaceOffset.X) - (Text.ActualWidth + cTextMarginDetail);
    end
    else
    begin
      Detail.InternalPlaceOffset.X := Text.ActualPlaceOffset.X + Text.ActualWidth - GlyphButton.ActualWidth
        + cTextMarginDetail;
      LInternalWidth := FinalSize.Width - Detail.ActualPlaceOffset.X - Accessory.ActualWidth;
    end;
    Detail.InternalWidth := Max(1, LInternalWidth);
  finally
    EndUpdate;
  end;
end;

constructor TListItemRightDetailShowCheckAppearance.Create(const Owner: TControl);
begin
  FIsItemEdit := True;
  inherited;
  Accessory.DefaultValues.Visible := False;
  Accessory.RestoreDefaults;
  GlyphButton.DefaultValues.ButtonType := DefaultGlyph;
  GlyphButton.DefaultValues.Visible := True;
  GlyphButton.RestoreDefaults;
end;

constructor TListItemRightDetailDeleteAppearance.Create(const Owner: TControl);
begin
  FIsItemEdit := True;
  inherited;
  Accessory.DefaultValues.Visible := False;
  Accessory.RestoreDefaults;
  GlyphButton.DefaultValues.ButtonType := DefaultGlyph;
  GlyphButton.DefaultValues.Visible := True;
  GlyphButton.RestoreDefaults;
end;

{$ENDREGION}
{$REGION 'TImageListItemAppearance'}

constructor TImageListItemAppearance.Create(const Owner: TControl);
begin
  FGroupClass := TImageListItemAppearance;
  inherited;
  Text.DefaultValues.Visible := True;
  Text.RestoreDefaults;
  Image.DefaultValues.Visible := True;
  Image.RestoreDefaults;
  Accessory.DefaultValues.Visible := True;
  Accessory.RestoreDefaults;
  AddObject(Text, True);
  AddObject(Image, True);
  AddObject(Accessory, True);
  AddObject(GlyphButton, IsItemEdit);
end;

procedure TImageListItemAppearance.UpdateSizes(const FinalSize: TSizeF);
var
  LImagePlaceOffset, LImageTextPlaceOffset, LInternalWidth: Single;
begin
  BeginUpdate;
  try
    inherited;
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
    Image.InternalPlaceOffset.X := LImagePlaceOffset;
    if Image.ActualWidth > 0 then
      Text.InternalPlaceOffset.X := Image.ActualPlaceOffset.X +  Image.ActualWidth + LImageTextPlaceOffset;
    LInternalWidth := FinalSize.Width - Text.ActualPlaceOffset.X - Accessory.ActualWidth;
    if Accessory.ActualWidth > 0 then
      LInternalWidth := LInternalWidth - cTextMarginAccessory;
    Text.InternalWidth := Max(1, LInternalWidth);
  finally
    EndUpdate;
  end;
end;

{$ENDREGION}
{$REGION 'TImageListItemShowCheck'}

constructor TImageListItemShowCheck.Create(const Owner: TControl);
begin
  FIsItemEdit := True;
  inherited;
  Accessory.DefaultValues.Visible := False;
  Accessory.RestoreDefaults;
  GlyphButton.DefaultValues.ButtonType := DefaultGlyph;
  GlyphButton.DefaultValues.Visible := True;
  GlyphButton.RestoreDefaults;
end;

{$ENDREGION}
{$REGION 'TImageListItemDeleteAppearance'}

constructor TImageListItemDeleteAppearance.Create(const Owner: TControl);
begin
  FIsItemEdit := True;
  inherited;
  Accessory.DefaultValues.Visible := False;
  Accessory.RestoreDefaults;
  GlyphButton.DefaultValues.ButtonType := DefaultGlyph;
  GlyphButton.DefaultValues.Visible := True;
  GlyphButton.RestoreDefaults;
end;

{$ENDREGION}
{$REGION 'TImageListItemRightButtonAppearance'}

constructor TImageListItemRightButtonAppearance.Create(const Owner: TControl);
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

procedure TImageListItemRightButtonAppearance.UpdateSizes(const FinalSize: TSizeF);
var
  LImagePlaceOffset, LImageTextPlaceOffset, LInternalWidth: Single;
begin
  BeginUpdate;
  try
    inherited;
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
    Image.InternalPlaceOffset.X := LImagePlaceOffset;
    Text.InternalPlaceOffset.X := Image.ActualPlaceOffset.X +  Image.ActualWidth + LImageTextPlaceOffset;
    LInternalWidth := FinalSize.Width - Text.ActualPlaceOffset.X - TextButton.ActualWidth;
    if TextButton.ActualWidth > 0 then
      LInternalWidth := LInternalWidth - cTextMarginTextButton;
    Text.InternalWidth := Max(1, LInternalWidth);
  finally
    EndUpdate;
  end;
end;

{$ENDREGION}
{$REGION 'TImageListItemRightButtonShowCheckAppearance'}

constructor TImageListItemRightButtonShowCheckAppearance.Create(const Owner: TControl);
begin
  FIsItemEdit := True;
  inherited;
  Accessory.DefaultValues.Visible := False;
  Accessory.RestoreDefaults;
  GlyphButton.DefaultValues.ButtonType := DefaultGlyph;
  GlyphButton.DefaultValues.Visible := True;
  GlyphButton.RestoreDefaults;
end;

{$ENDREGION}
{$REGION 'TImageListItemRightButtonDeleteAppearance'}

constructor TImageListItemRightButtonDeleteAppearance.Create(const Owner: TControl);
begin
  FIsItemEdit := True;
  inherited;
  Accessory.DefaultValues.Visible := False;
  Accessory.RestoreDefaults;
  GlyphButton.DefaultValues.ButtonType := DefaultGlyph;
  GlyphButton.DefaultValues.Visible := True;
  GlyphButton.RestoreDefaults;
end;

{$ENDREGION}
{$REGION 'TImageListItemBottomDetailAppearance'}

constructor TImageListItemBottomDetailAppearance.Create(const Owner: TControl);
begin
  FGroupClass := TImageListItemBottomDetailAppearance;
  inherited;
  Text.DefaultValues.Visible := True;
  Text.RestoreDefaults;
  Detail.DefaultValues.Visible := True;
  Detail.RestoreDefaults;
  Image.DefaultValues.Visible := True;
  Image.RestoreDefaults;
  Accessory.DefaultValues.Visible := True;
  Accessory.RestoreDefaults;
  AddObject(Text, True);
  AddObject(Detail, True);
  AddObject(Image, True);
  AddObject(Accessory, True);
  AddObject(GlyphButton, IsItemEdit);
end;

procedure TImageListItemBottomDetailAppearance.UpdateSizes(const FinalSize: TSizeF);
var
  LImagePlaceOffset, LImageTextPlaceOffset, LInternalWidth: Single;
begin
  BeginUpdate;
  try
    inherited;
    // Image placement.
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

    Image.InternalPlaceOffset.X := LImagePlaceOffset;

    // Text size and placement.
    Text.InternalPlaceOffset.X := Image.ActualPlaceOffset.X + Image.ActualWidth + LImageTextPlaceOffset;

    LInternalWidth := FinalSize.Width - Text.ActualPlaceOffset.X;

    if Accessory.ActualWidth > 0 then
      LInternalWidth := LInternalWidth - (Accessory.ActualWidth + cDefaultTextAccessorySpace);

    Text.InternalWidth := Max(1, LInternalWidth);
    Text.InternalPlaceOffset.Y := cDefaultTextPlaceOffsetY;

    // Detail size and placement.
    Detail.InternalPlaceOffset.X := Text.ActualPlaceOffset.X;
    Detail.InternalPlaceOffset.Y := cDefaultDetailPlaceOffsetY;

    Detail.InternalPlaceOffset.X := Image.ActualPlaceOffset.X + Image.ActualWidth + LImageTextPlaceOffset;

    LInternalWidth := FinalSize.Width - Text.ActualPlaceOffset.X;

    if Accessory.ActualWidth > 0 then
      LInternalWidth := LInternalWidth - (Accessory.ActualWidth + cDefaultTextAccessorySpace);

    Detail.InternalWidth := Max(1, LInternalWidth);
  finally
    EndUpdate;
  end;
end;

{$ENDREGION}
{$REGION 'TImageListItemBottomDetailShowCheckAppearance'}

constructor TImageListItemBottomDetailShowCheckAppearance.Create(const Owner: TControl);
begin
  FIsItemEdit := True;
  inherited;
  Accessory.DefaultValues.Visible := False;
  Accessory.RestoreDefaults;
  GlyphButton.DefaultValues.ButtonType := DefaultGlyph;
  GlyphButton.DefaultValues.Visible := True;
  GlyphButton.RestoreDefaults;
end;

{$ENDREGION}
{$REGION 'TImageListItemBottomDetailRightButtonAppearance'}

constructor TImageListItemBottomDetailRightButtonAppearance.Create(const Owner: TControl);
begin
  FGroupClass := TImageListItemBottomDetailRightButtonAppearance;
  inherited;
  Text.DefaultValues.Visible := True;
  Text.RestoreDefaults;
  Detail.DefaultValues.Visible := True;
  Detail.RestoreDefaults;
  Image.DefaultValues.Visible := True;
  Image.RestoreDefaults;
  TextButton.DefaultValues.Visible := True;
  TextButton.RestoreDefaults;
  AddObject(Text, True);
  AddObject(Detail, True);
  AddObject(Image, True);
  AddObject(TextButton, True);
  AddObject(GlyphButton, IsItemEdit);
end;

procedure TImageListItemBottomDetailRightButtonAppearance.UpdateSizes(const FinalSize: TSizeF);
var
  LImagePlaceOffset, LImageTextPlaceOffset, LInternalWidth: Single;
begin
  BeginUpdate;
  try
    inherited;
    // Image placement.
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

    Image.InternalPlaceOffset.X := LImagePlaceOffset;

    // Text size and placement.
    Text.InternalPlaceOffset.X := Image.ActualPlaceOffset.X + Image.ActualWidth + LImageTextPlaceOffset;

    LInternalWidth := FinalSize.Width - Text.ActualPlaceOffset.X;

    if TextButton.ActualWidth > 0 then
      LInternalWidth := LInternalWidth - (TextButton.ActualWidth + cDefaultTextRightButtonSpace);

    Text.InternalWidth := Max(1, LInternalWidth);
    Text.InternalPlaceOffset.Y := cDefaultTextPlaceOffsetY;

    // Detail size and placement.
    Detail.InternalPlaceOffset.X := Text.ActualPlaceOffset.X;
    Detail.InternalPlaceOffset.Y := cDefaultDetailPlaceOffsetY;

    Detail.InternalPlaceOffset.X := Image.ActualPlaceOffset.X + Image.ActualWidth + LImageTextPlaceOffset;

    LInternalWidth := FinalSize.Width - Text.ActualPlaceOffset.X;

    if TextButton.ActualWidth > 0 then
      LInternalWidth := LInternalWidth - (TextButton.ActualWidth + cDefaultTextRightButtonSpace);

    Detail.InternalWidth := Max(1, LInternalWidth);
  finally
    EndUpdate;
  end;
end;

{$ENDREGION}
{$REGION 'TImageListItemBottomDetailRightButtonShowCheckAppearance'}

constructor TImageListItemBottomDetailRightButtonShowCheckAppearance.Create(const Owner: TControl);
begin
  FIsItemEdit := True;
  inherited;
  Accessory.DefaultValues.Visible := False;
  Accessory.RestoreDefaults;
  GlyphButton.DefaultValues.ButtonType := DefaultGlyph;
  GlyphButton.DefaultValues.Visible := True;
  GlyphButton.RestoreDefaults;
end;

{$ENDREGION}
{$REGION 'TCustomizeItemObjects'}

constructor TCustomizeItemObjects.Create(const Owner: TControl);
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

{$ENDREGION}
{$REGION 'TListHeaderObjects'}

constructor TListHeaderObjects.Create(const Owner: TControl);
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

procedure TListHeaderObjects.UpdateSizes(const FinalSize: TSizeF);
begin
  BeginUpdate;
  try
    inherited;
    Text.InternalWidth := FinalSize.Width;
  finally
    EndUpdate;
  end;
end;

{$ENDREGION}

{$REGION TCustomListView.TPublishedAppearance}

constructor TPublishedAppearance.Create(const AOwner: TComponent);
begin
  inherited Create;
  FOwnerComponent := AOwner;
  Supports(AOwner, IPublishedAppearanceOwner, FPropertiesOwner);
end;

function TPublishedAppearance.GetFooterAppearance: string;
begin
  Result := FPropertiesOwner.FooterAppearanceName;
end;

function TPublishedAppearance.GetFooterHeight: Integer;
begin
  Result := FPropertiesOwner.FooterHeight;
end;

function TPublishedAppearance.GetHeaderAppearance: string;
begin
  Result := FPropertiesOwner.HeaderAppearanceName;
end;

function TPublishedAppearance.GetHeaderHeight: Integer;
begin
  Result := FPropertiesOwner.HeaderHeight;
end;

function TPublishedAppearance.GetItemAppearance: string;
begin
  Result := FPropertiesOwner.ItemAppearanceName;
end;

function TPublishedAppearance.GetItemEditAppearance: string;
begin
  Result := FPropertiesOwner.ItemEditAppearanceName;
end;

function TPublishedAppearance.GetItemEditHeight: Integer;
begin
  Result := FPropertiesOwner.ItemEditHeight;
end;

function TPublishedAppearance.GetItemHeight: Integer;
begin
  Result := FPropertiesOwner.ItemHeight;
end;

function TPublishedAppearance.IsFooterHeightStored: Boolean;
begin
  Result := FPropertiesOwner.FooterAppearanceProperties.IsHeightStored;
end;

function TPublishedAppearance.IsHeaderHeightStored: Boolean;
begin
  Result := FPropertiesOwner.HeaderAppearanceProperties.IsHeightStored;
end;

function TPublishedAppearance.IsItemEditHeightStored: Boolean;
begin
  Result := FPropertiesOwner.ItemEditAppearanceProperties.IsHeightStored;
end;

function TPublishedAppearance.IsItemHeightStored: Boolean;
begin
  Result := FPropertiesOwner.ItemAppearanceProperties.IsHeightStored;
end;

procedure TPublishedAppearance.SetFooterAppearance(const Value: string);
begin
  FPropertiesOwner.FooterAppearanceName := Value;
end;

procedure TPublishedAppearance.SetFooterHeight(const Value: Integer);
begin
  FPropertiesOwner.FooterHeight := Value;
end;

procedure TPublishedAppearance.SetHeaderAppearance(const Value: string);
begin
  FPropertiesOwner.HeaderAppearanceName := Value;
end;

procedure TPublishedAppearance.SetHeaderHeight(const Value: Integer);
begin
  FPropertiesOwner.HeaderHeight := Value;
end;

procedure TPublishedAppearance.SetItemAppearance(const Value: string);
begin
  FPropertiesOwner.ItemAppearanceName := Value;
end;

procedure TPublishedAppearance.SetItemEditAppearance(const Value: string);
begin
  FPropertiesOwner.ItemEditAppearanceName := Value;
end;

procedure TPublishedAppearance.SetItemEditHeight(const Value: Integer);
begin
  FPropertiesOwner.ItemEditHeight := Value;
end;

procedure TPublishedAppearance.SetItemHeight(const Value: Integer);
begin
  FPropertiesOwner.ItemHeight := Value;
end;
{$ENDREGION}

{$REGION TCustomListView.TPublishedObjects}
constructor TPublishedObjects.Create(const AOwner: IPublishedAppearanceOwner);
begin
  inherited Create;
  FOwner := AOwner;
end;

function TPublishedObjects.GetFooterObjects: TItemAppearanceObjects;
begin
  Result := FOwner.FooterAppearanceProperties.Objects;
end;

function TPublishedObjects.GetHeaderObjects: TItemAppearanceObjects;
begin
  Result := FOwner.HeaderAppearanceProperties.Objects;
end;

function TPublishedObjects.GetItemEditObjects: TItemAppearanceObjects;
begin
  Result := FOwner.ItemEditAppearanceProperties.Objects;
end;

function TPublishedObjects.GetItemObjects: TItemAppearanceObjects;
begin
  Result := FOwner.ItemAppearanceProperties.Objects;
end;

procedure TPublishedObjects.SetFooterObjects(const Value: TItemAppearanceObjects);
begin
  FOwner.FooterAppearanceProperties.Objects := Value;
end;

procedure TPublishedObjects.SetHeaderObjects(const Value: TItemAppearanceObjects);
begin
  FOwner.HeaderAppearanceProperties.Objects := Value;
end;

procedure TPublishedObjects.SetItemEditObjects(const Value: TItemAppearanceObjects);
begin
  FOwner.ItemEditAppearanceProperties.Objects := Value;
end;

procedure TPublishedObjects.SetItemObjects(const Value: TItemAppearanceObjects);
begin
  FOwner.ItemAppearanceProperties.Objects := Value;
end;
{$ENDREGION}


{$REGION TAppearancesRegistry}
class constructor TAppearancesRegistry.Create;
begin
  FFactories := TDictionary<TItemAppearanceObjectsClass, TRegisterAppearanceValue>.Create;
end;

class destructor TAppearancesRegistry.Destroy;
begin
  FFactories.Free;
end;

class function TAppearancesRegistry.FindItemAppearanceObjectsClassByOption(AOption: TRegisterAppearanceOption)
  : TItemAppearanceObjectsClass;
var
  LPair: TPair<TItemAppearanceObjectsClass, TRegisterAppearanceValue>;
begin
  Result := nil;
  for LPair in FFactories do
    if AOption in LPair.Value.Options then
      Exit(LPair.Key);
end;

class procedure TAppearancesRegistry.RegisterAppearances(AFactories: TArray<TItemAppearanceObjectsClass>;
  ADisplayNames: TArray<string>; AOptions: TRegisterAppearanceOptions; const AUnitName: string);
var
  I: Integer;
begin
  for I := 0 to Length(AFactories) - 1 do
    if I < Length(ADisplayNames) then
      RegisterAppearance(AFactories[I], ADisplayNames[I], AOptions, AUnitName);
end;

class procedure TAppearancesRegistry.RegisterAppearance(const AFactory: TItemAppearanceObjectsClass;
  const ADisplayName: string; AOptions: TRegisterAppearanceOptions; const AUnitName: string);
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
  FFactories.AddOrSetValue(AFactory, TRegisterAppearanceValue.Create(ADisplayName, AOptions, AUnitName));
end;

class procedure TAppearancesRegistry.UnregisterAppearances(AFactories: TArray<TItemAppearanceObjectsClass>);
var
  LFactory: TItemAppearanceObjectsClass;
begin
  for LFactory in AFactories do
    FFactories.Remove(LFactory);
end;

class procedure TAppearancesRegistry.UnregisterAppearance(const AFactory: TItemAppearanceObjectsClass);
begin
  FFactories.Remove(AFactory);
end;

class function TAppearancesRegistry.GetRegisteredAppearances(AFilter: TRegisterAppearanceOptions): TArray<TRegisteredAppearance>;
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
{$ENDREGION}

{$REGION 'TRegisterAppearanceValue'}

constructor TRegisterAppearanceValue.Create(const AName: string; AOptions: TRegisterAppearanceOptions;
  const AUnitName: string);
begin
  Name := AName;
  UnitName := AUnitName;
  Options := AOptions;
end;

{$ENDREGION}

{ TAppearanceListViewItems }

constructor TAppearanceListViewItems.Create(const Owner: TControl);
begin
  inherited Create;
  FAsFilterable := Self;
  Supports(Owner, IListViewPresentationParent, FPresentationParent);
  Supports(Owner, IListViewController, FListViewController);

  FOwnerControl := Owner;
  FNewItems := TObjectList<TListItem>.Create(False);
end;

destructor TAppearanceListViewItems.Destroy;
begin
  FNewItems.Free;
  inherited;
end;

function TAppearanceListViewItems.GetAppearanceItem(const Index: Integer): TListViewItem;
begin
  Result := Item[Index] as TListViewItem;
end;

function TAppearanceListViewItems.AppearanceItemOwner: IAppearanceItemOwner;
begin
  Supports(FOwnerControl, IAppearanceItemOwner, Result);
end;

function TAppearanceListViewItems.ReindexAndFindItem(const AItem: TListViewItem): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to Count - 1 do
  begin
    Item[I].Index := I;
    if Item[I] = AItem then
      Result := I;
  end;
end;

procedure TAppearanceListViewItems.DoResetViews(const APurposes: TListItemPurposes);
  function CanResetObjects: Boolean;
  var
    LProperties: TItemAppearanceProperties;
  begin
    Result := False;
    for LProperties in AppearanceItemOwner.GetAppearanceProperties do
      if LProperties.Active and not (LProperties.Objects is TNullItemObjects) then
          Exit(True);
  end;

var
  I: Integer;
begin
  if CanResetObjects then
    for I := 0 to UnfilteredItems.Count - 1 do
      if (APurposes = []) or (UnfilteredItems[I].Purpose in APurposes) then
        ResetView(UnfilteredItems[I]);
end;

procedure TAppearanceListViewItems.DoCreateNewViews;
var
  LItem: TListItem;
begin
  OwnerControl.BeginUpdate;
  try
    for LItem in FNewItems do
      LItem.CreateObjects;
    FNewItems.Clear;
  finally
    OwnerControl.EndUpdate;
  end;
end;

type
  TComparerAdapter = class(TInterfacedObject, IComparer<TListItem>)
  private
    FAdapted: IComparer<TListViewItem>;
  public
    constructor Create(const Adapted: IComparer<TListViewItem>);
    function Compare(const Left, Right: TListItem): Integer;
  end;

constructor TComparerAdapter.Create(const Adapted: IComparer<TListViewItem>);
begin
  FAdapted := Adapted;
end;

function TComparerAdapter.Compare(const Left, Right: TListItem): Integer;
begin
  Result := FAdapted.Compare(Left as TListViewItem, Right as TListViewItem);
end;

procedure TAppearanceListViewItems.Sort(AComparer: IComparer<TListViewItem>);
begin
  Sort(TComparerAdapter.Create(AComparer));
end;

{ IListViewCheckProvider }

procedure TAppearanceListViewItems.CheckAll(const AChecked: Boolean);
begin
  CheckAll(nil, AChecked);
end;

procedure TAppearanceListViewItems.CheckAll(const ACallback: TFunc<Integer, Boolean>; const AChecked: Boolean = True);
var
  I: Integer;
  LItem: TListViewItem;
begin
  FOwnerControl.BeginUpdate;
  try
    FCheckedCount := 0;
    for I := 0 to Count - 1 do
    begin
      LItem := AppearanceItem[I];
      if (LItem.Checked <> AChecked) and (not Assigned(ACallback) or ACallback(I)) then
        LItem.Checked := AChecked;
      if LItem.Checked then
        Inc(FCheckedCount);
    end;
  finally
    FOwnerControl.EndUpdate;
  end;
end;

function TAppearanceListViewItems.FirstChecked(const AChecked: Boolean): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to Count - 1 do
    if AppearanceItem[I].Checked = AChecked then
      Exit(I);
end;

function TAppearanceListViewItems.AnyChecked(const AChecked: Boolean): Boolean;
begin
  if AChecked then
    Result := FCheckedCount > 0
  else
    Result := FCheckedCount = Count;
end;

function TAppearanceListViewItems.CheckedIndexes(const AChecked: Boolean): TArray<Integer>;
begin
  Result := CheckedIndexes(TOrder.LastToFirst, AChecked);
end;

function TAppearanceListViewItems.CheckedIndexes(const AOrder: TListViewItems.TOrder; const AChecked: Boolean): TArray<Integer>;
var
  LList: TList<Integer>;
  I: Integer;
begin
  LList := TList<Integer>.Create;
  try
    for I := 0 to Count - 1 do
      if AppearanceItem[I].Checked = AChecked then
        if AOrder = TOrder.FirstToLast then
          LList.Add(I)
        else
          LList.Insert(0, I);
    Result := LList.ToArray;
  finally
    LList.Free;
  end;
end;

function TAppearanceListViewItems.CheckedCount(const AChecked: Boolean): Integer;
begin
  if AChecked then
    Result := FCheckedCount
  else
    Result := Count - FCheckedCount;
end;

function TAppearanceListViewItems.GetChecked(const Index: Integer): Boolean;
begin
  Result := AppearanceItem[Index].Checked;
end;

procedure TAppearanceListViewItems.SetChecked(const Index: Integer; const Value: Boolean);
var
  Item: TListViewItem;
  OldState: Boolean;
begin
  Item := AppearanceItem[Index];
  OldState := Item.Checked;
  Item.Checked := Value;
  if Item.Checked and not OldState then
    Inc(FCheckedCount);
  if OldState and not Item.Checked then
    Dec(FCheckedCount);
end;

type
  TEnumeratorCast<P:TListItem> = class(TEnumerator<TListViewItem>)
  strict private
    FFrom: TEnumerator<P>;
  protected
    function DoGetCurrent: TListViewItem; override;
    function DoMoveNext: Boolean; override;
  public
    constructor Create(const From: TEnumerator<P>);
    destructor Destroy; override;
  end;

constructor TEnumeratorCast<P>.Create(const From: TEnumerator<P>);
begin
  FFrom := From;
end;

destructor TEnumeratorCast<P>.Destroy;
begin
  FFrom.Free;
  inherited;
end;

function TEnumeratorCast<P>.DoGetCurrent: TListViewItem;
begin
  Result := TListViewItem(FFrom.DoGetCurrent);
end;

function TEnumeratorCast<P>.DoMoveNext: Boolean;
begin
  Result := FFrom.DoMoveNext;
end;

function TAppearanceListViewItems.GetEnumerator: TEnumerator<TListViewItem>;
begin
  Result := TEnumeratorCast<TListItem>.Create(inherited GetEnumerator);
end;

function TAppearanceListViewItems.GetGlyphButtonDrawable(const Index: Integer): TListItemGlyphButton;
begin
  Result := AppearanceItem[Index].Objects.GlyphButton;
end;

function TAppearanceListViewItems.GetIndexTitle(const Index: Integer): string;
begin
  Result := AppearanceItem[Index].IndexTitle;
end;

function TAppearanceListViewItems.GetText(const Index: Integer): string;
begin
  Result := AppearanceItem[Index].Text;
end;

function TAppearanceListViewItems.GetTextButtonDrawable(const Index: Integer): TListItemTextButton;
begin
  Result := AppearanceItem[Index].Objects.TextButton;
end;

procedure TAppearanceListViewItems.SetItemData(const Index: Integer; const DataIndex: string; const AValue: TValue);
begin
  AppearanceItem[Index].Data[DataIndex] := AValue;
end;

function TAppearanceListViewItems.GetItemData(const Index: Integer; const DataIndex: string): TValue;
begin
  Result := AppearanceItem[Index].Data[DataIndex];
end;

function TAppearanceListViewItems.GetHasData(const Index: Integer; const DataIndex: string): Boolean;
begin
  Result := AppearanceItem[Index].HasData[DataIndex];
end;

procedure TAppearanceListViewItems.SetItemTag(const Index: Integer; const AValue: NativeInt);
begin
  AppearanceItem[Index].Tag := AValue;
end;

function TAppearanceListViewItems.GetItemTag(const Index: Integer): NativeInt;
begin
  Result := AppearanceItem[Index].Tag;
end;

// Concrete filter
function TAppearanceListViewItems.DoFilterItem(const Item: TListItem): Boolean;
begin
  Result := Filter(TListViewItem(Item).Text) or Filter(TListViewItem(Item).Detail);
end;

// IListViewEditor

procedure TAppearanceListViewItems.SetAfterItemAdded(const AHandler: TAfterItemAddedNotify);
begin
  FAfterItemAdded := AHandler;
end;

procedure TAppearanceListViewItems.SetAfterItemDeleted(const AHandler: TAfterItemDeletedNotify);
begin
  FAfterItemDeleted := AHandler;
end;

procedure TAppearanceListViewItems.SetBeforeItemAdded(const AHandler: TBeforeItemAddedNotify);
begin
  FBeforeItemAdded := AHandler;
end;

procedure TAppearanceListViewItems.SetBeforeItemDeleted(const AHandler: TBeforeItemDeletedNotify);
begin
  FBeforeItemDeleted := AHandler;
end;

function TAppearanceListViewItems.EditorAdd: TListItem;
begin
  Result := AddItem(-1);
end;

function TAppearanceListViewItems.EditorInsert(const Index: Integer): TListItem;
begin
  Result := AddItem(Index);
end;

function TAppearanceListViewItems.Add: TListViewItem;
begin
  Result := TListViewItem(EditorAdd);
end;

function TAppearanceListViewItems.DoAddItem(const Index: Integer): TListViewItem;
begin
  Result := TListViewItem.Create(Self, FPresentationParent, FListViewController);

  if Assigned(FBeforeItemAdded) then
    FBeforeItemAdded(Self);
  try
    FNewItems.Add(Result);
    AsFilterable.ItemAdded(Index, Result);
    Changed;
  finally
    if Assigned(FAfterItemAdded) then
      FAfterItemAdded(Self, Result);
  end;
end;

function TAppearanceListViewItems.Insert(const Index: Integer): TListViewItem;
begin
  Result := TListViewItem(EditorInsert(Index));
end;

function TAppearanceListViewItems.AddItem(const Index: Integer): TListViewItem;
begin
  Result := DoAddItem(Index);
end;

procedure TAppearanceListViewItems.Delete(const Index: Integer);
var
  LItem: TListItem;
begin
  if Assigned(FBeforeItemDeleted) then
    FBeforeItemDeleted(Self, Index);
  try
    LItem := ActiveItems[Index];
    AsFilterable.ItemDeleted(Index);
    FNewItems.Remove(LItem);
    ResetIndexes;
    Changed;
  finally
    if Assigned(FAfterItemDeleted) then
      FAfterItemDeleted(Self);
  end;
end;

procedure TAppearanceListViewItems.DoClear;
begin
  FNewItems.Clear;
  AsFilterable.ItemsCleared;
  Changed;
end;

procedure TAppearanceListViewItems.Clear;
begin
  ItemsMayChange;
  try
    DoClear;
  finally
    ItemsCouldHaveChanged;
  end;
end;

initialization
  // Register appearances
  TAppearancesRegistry.RegisterAppearance(TEmptyItemObjects, TAppearanceNames.Empty);
  TAppearancesRegistry.RegisterAppearance(TCustomizeItemObjects, TAppearanceNames.Custom,
  [TRegisterAppearanceOption.Item, TRegisterAppearanceOption.ItemEdit, TRegisterAppearanceOption.Footer,
  TRegisterAppearanceOption.Header]);

  // ListItem group
  TAppearancesRegistry.RegisterAppearance(TListItemAppearance, TAppearanceNames.ListItem,
    [TRegisterAppearanceOption.Item, TRegisterAppearanceOption.DefaultItem]);
  TAppearancesRegistry.RegisterAppearance(
    TListItemDeleteAppearance, TAppearanceNames.ListItemDelete,
    [TRegisterAppearanceOption.ItemEdit]);
  TAppearancesRegistry.RegisterAppearance(
    TListItemShowCheckAppearance, TAppearanceNames.ListItemShowCheck,
    [TRegisterAppearanceOption.ItemEdit, TRegisterAppearanceOption.DefaultItemEdit]);

  // ListItemRightDetail group
  TAppearancesRegistry.RegisterAppearance(
    TListItemRightDetailAppearance, TAppearanceNames.ListItemRightDetail,
    [TRegisterAppearanceOption.Item]);
  TAppearancesRegistry.RegisterAppearance(
    TListItemRightDetailDeleteAppearance, TAppearanceNames.ListItemRightDetailDelete,
    [TRegisterAppearanceOption.ItemEdit]);
  TAppearancesRegistry.RegisterAppearance(
    TListItemRightDetailShowCheckAppearance, TAppearanceNames.ListItemRightDetailShowCheck,
    [TRegisterAppearanceOption.ItemEdit]);

  // ImageListItem group
  TAppearancesRegistry.RegisterAppearance(
    TImageListItemAppearance, TAppearanceNames.ImageListItem,
    [TRegisterAppearanceOption.Item]);
  TAppearancesRegistry.RegisterAppearance(
    TImageListItemDeleteAppearance, TAppearanceNames.ImageListItemDelete,
    [TRegisterAppearanceOption.ItemEdit]);
  TAppearancesRegistry.RegisterAppearance(
    TImageListItemShowCheck, TAppearanceNames.ImageListItemShowCheck,
    [TRegisterAppearanceOption.ItemEdit]);
  TAppearancesRegistry.RegisterAppearance(
    TImageListItemBottomDetailAppearance, TAppearanceNames.ImageListItemBottomDetail,
    [TRegisterAppearanceOption.Item]);
  TAppearancesRegistry.RegisterAppearance(
    TImageListItemBottomDetailShowCheckAppearance, TAppearanceNames.ImageListItemBottomDetailShowCheck,
    [TRegisterAppearanceOption.ItemEdit]);
  TAppearancesRegistry.RegisterAppearance(
    TImageListItemBottomDetailRightButtonAppearance, TAppearanceNames.ImageListItemBottomDetailRightButton,
    [TRegisterAppearanceOption.Item]);
  TAppearancesRegistry.RegisterAppearance(
    TImageListItemBottomDetailRightButtonShowCheckAppearance,
    TAppearanceNames.ImageListItemBottomDetailRightButtonShowCheck,
    [TRegisterAppearanceOption.ItemEdit]);

  // ImageListItemRightButton group
  TAppearancesRegistry.RegisterAppearance(
    TImageListItemRightButtonAppearance, TAppearanceNames.ImageListItemRightButton,
    [TRegisterAppearanceOption.Item]);
  TAppearancesRegistry.RegisterAppearance(
    TImageListItemRightButtonDeleteAppearance, TAppearanceNames.ImageListItemRightButtonDelete,
    [TRegisterAppearanceOption.ItemEdit]);
  TAppearancesRegistry.RegisterAppearance(
    TImageListItemRightButtonShowCheckAppearance, TAppearanceNames.ImageListItemRightButtonShowCheck,
    [TRegisterAppearanceOption.ItemEdit]);

  TAppearancesRegistry.RegisterAppearance(TListHeaderObjects, TAppearanceNames.ListHeader,
    [
    TRegisterAppearanceOption.Header,
    TRegisterAppearanceOption.Footer,
    TRegisterAppearanceOption.DefaultHeader,
    TRegisterAppearanceOption.DefaultFooter]
    );  // Default

finalization

end.
