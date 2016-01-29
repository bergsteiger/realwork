{====================================================}
{                                                    }
{   EldoS Visual Components                          }
{                                                    }
{   Copyright (c) 1998-2003, EldoS Corporation       }
{   Copyright (c) 2002, Elizabeth Krivonos,          }
{                       Alexander Hramov             }
{                                                    }
{====================================================}
{$INCLUDE elpack2.inc}
{$IFDEF ELPACK_SINGLECOMP}
{$I ElPack.inc}
{$ELSE}
{$IFDEF LINUX}
{$I ../ElPack.inc}
{$ELSE}
{$I ..\ElPack.inc}
{$ENDIF}
{$ENDIF}

(*

Version History

14/06/2003

  added NoRebuildOnDataChange property which defines reaction of the tree to changes in related data sets.

06/06/2003
  
  added OnItemCreated event

02/18/2003

  fixed bug with unassigned user-data in custom column

02/08/2003

  fixed problem with showing widestring.

01/28/2003

  fixed something bugs in TElDBTreeItem.Assign method

  add event OnCustomColumnDataNeed fired when multi-column tree
  (such as TElDBTreeStringGrid) needs data for building user-defined data column

  modified TriggerInplaceEditorNeeded for correct choice editor for editing db
  or not db data.

01/06/2003

  fixed bug with accepting when editing
  value of data field in inplace editors.

12/04/2002

  Fixed some bugs in DataLink events processing

11/16/2002

  Fixed some issues in NotifyControl procedure

11/01/2002

  Move properties TCustomElDBTree.Changing and
  TCustomElDBTree.LookAllSetsPosition to protected

11/02/2002

  redefied method GetFirstNode
  fixed problem with filtered datasets

11/10/2002

  add property TCustomElDBTree.PrebuildLevelCount

*)

unit ElDBTree;

interface

uses
  SysUtils,
  Classes,
  Windows,
  Messages,
  Graphics,
  Controls,
  StdCtrls,
  Forms,
  Dialogs,
  DBCtrls,
  ExtCtrls,
  TypInfo,
  DB,
  Math,
  ElVCLUtils,
  ElXPThemedControl,
  ElTree,
  ElStrUtils,
  ElHeader,
{$IFDEF VCL_6_USED}
  Variants,
  Types,
{$ENDIF}
{$IFDEF ELPACK_UNICODE}
  ElUnicodeStrings,
{$ENDIF}
  ElDBConst;


type
  TCustomElDBTree = class;
  TElDBTreeItem = class;
  TElStylesDefsItem = class;
  EOnErrorInRelation = class (Exception)
  end;

  EOnMoveError = class (Exception)
  end;

  EOnGoToBookmark = class (Exception)
  end;

  EErrorInPattern = class (Exception)
  end;

  TOnActivateLevel = procedure (Sender: TObject; Parent: TElDBTreeItem) of
          object;
  TOnItemChangedEvent = procedure (AItem: TElDBTreeItem) of object;
  TOnItemCreated = procedure (Item: TElDBTreeItem) of object;
  TOnCustomColumnDataNeed = procedure (Sender: TObject; Item: TElDBTreeItem;
          SectionNumber : Integer;var UserData : Variant;var IsPicture :
          Boolean) of object;
  TTableName = type string;

  TUpdateStylesType = (stPattern, stFontAndStyles, stHint, stCheckBox, stImages, stCaption, stShowCaption);


  TElRelDataSource = class;
  TElRelationsItem = class;
  TElRelations = class;

  TElCustomEvent = (elSetModify, elSetRelActive, elRecordChange, elUserDefined, elRelDeleted, elRelAdded, elRelSetChanged, elSetRelRefresh);


  TElDBTreeInplaceEditor = class (TElTreeInplaceEditor)
  protected
    FOnAfterCompleteOperation: TNotifyEvent;
    function GetTree: TCustomElDBTree;
    procedure SetTree(Value: TCustomElDBTree);
    procedure TriggerAfterCompleteOperation; virtual;
  published
    property Tree: TCustomElDBTree read GetTree write SetTree;
    property OnAfterCompleteOperation: TNotifyEvent read FOnAfterCompleteOperation write FOnAfterCompleteOperation;
  end;

// TELTreeDataLink

  TElTreeDataLink = class (TPersistent)
  private
    FDataSetName: string;
    FTreeView: TCustomElDBTree;
  protected
    procedure NotifyControl(Event: TElCustomEvent; UserTag: integer); virtual;
  public
    constructor Create(ATreeView: TCustomElDBTree);
  end;

//  TElRelationsItem
  TElMasterField = type string;
  TElDetailField = type string;
  TElDetailDisplayField = type string;

  TSourceDataLink = class (TDataLink)
  private
    FElRelationsItem: TElRelationsItem;
    FElRelDataSource: TElRelDataSource;
  protected
    procedure ActiveChanged; override;
    procedure DataSetChanged; override;
  public
    constructor Create(AElRelDataSource: TElRelDataSource; AElRelationsItem:
            TElRelationsItem);
  end;

// TElRelationsItem

  TElRelationsItem = class (TCollectionItem)
  private
    FActive: Boolean;
    FActiveOnLevel: Integer;
    FAfterRefresh: TDataSetNotifyEvent;
    FDenyLookSetPosition: Boolean;
    FDetailDataLink: TSourceDataLink;
    FDetailDataSource: TDataSource;
    FDetailDisplayField: TElDetailDisplayField;
    FDetailField: TElDetailField;
    FMasterDataSource: TDataSource;
    FMasterField: TElMasterField;
    FOldFilter: string;
    FOldFiltering: Boolean;
    function GetDetailDataSet: TDataSet;
    function GetMasterDataSet: TDataSet;
    procedure SetAfterRefresh(ADataset : TDataSet);
    procedure SetDenyLookSetPosition(Value: Boolean);
    procedure SetDetailDataSet(ADataSet: TDataSet);
    procedure SetDetailDisplayField(AField: TElDetailDisplayField);
    procedure SetDetailField(AField: TElDetailField);
    procedure SetMasterDataSet(ADataSet: TDataSet);
    procedure SetMasterField(AField: TElMasterField);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    function GetDetailDataSource: TDataSource;
    function GetMasterDataSource: TDataSource;
  published
    property Active: Boolean read FActive write FActive default True;
    property ActiveOnLevel: Integer read FActiveOnLevel write FActiveOnLevel
            default -1;
    property DenyLookSetPosition: Boolean read FDenyLookSetPosition write
            SetDenyLookSetPosition default False;
    property DetailDataSet: TDataSet read GetDetailDataSet write
            SetDetailDataSet;
    property DetailDisplayField: TElDetailDisplayField read FDetailDisplayField
            write SetDetailDisplayField;
    property DetailField: TElDetailField read FDetailField write SetDetailField;
    property MasterDataSet: TDataSet read GetMasterDataSet write
            SetMasterDataSet;
    property MasterField: TElMasterField read FMasterField write SetMasterField;
  end;

//  TRelations

  TElRelations = class (TCollection)
  private
    FElRelDataSource: TElRelDataSource;
    function GetItem(Index: Integer): TElRelationsItem;
    procedure SetItem(Index: Integer; Value: TElRelationsItem);
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(AElRelDataSource: TElRelDataSource; ItemClass:
            TCollectionItemClass);

  {$IFDEF D_4_UP}
    procedure EndUpdate; override;
  {$else}
    procedure EndUpdate;
  {$ENDIF}
    property DataSource: TElRelDataSource read FElRelDataSource;
    property Items[Index: Integer]: TElRelationsItem read GetItem write SetItem;
            default;
  end;

// TElRelDataSource
  TElDataField = type string;

  TElRelDataSource = class (TComponent)
  private
    FAfterRefresh: TDataSetNotifyEvent;
    FDataField: TElDataField;
    FDenyLookSetPosition: Boolean;
    FFilter: string;
    FFiltered: Boolean;
    FOwnFilter: Boolean;
    FRelations: TElRelations;
    FRootDataLink: TSourceDataLink;
    FRootDataSource: TDataSource;
    FTreeDataLinks: TList;
    function GetRootDataSet: TDataSet;
    procedure SetAfterRefresh(ADataset : TDataSet); virtual;
    procedure SetDataField(const Value: TElDataField);
    procedure SetDenyLookSetPosition(Value: Boolean);
    procedure SetFilter(const Value: string);
    procedure SetFiltered(const Value: Boolean);
    procedure SetRelations(Value: TElRelations);
    procedure SetRootDataSet(ADataSet: TDataSet);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetRootDataSource: TDataSource;
    procedure NotifyLinks(Event: TElCustomEvent; UserTag: integer); virtual;
    procedure RegisterLink(ALink: TElTreeDataLink); virtual;
    procedure UnRegisterLink(ALink: TElTreeDataLink); virtual;
  published
    property DataSet: TDataSet read GetRootDataSet write SetRootDataSet;
    property DenyLookSetPosition: Boolean read FDenyLookSetPosition write
            SetDenyLookSetPosition default False;
    property Filter: string read FFilter write SetFilter;
    property Filtered: Boolean read FFiltered write SetFiltered;
    property OwnFilter: Boolean read FOwnFilter write FOwnFilter;
    property Relations: TElRelations read FRelations write SetRelations;
    property RootDataField: TElDataField read FDataField write SetDataField;
  end;

  TElHackTreeView = class (TElTreeView)
  end;

  THackElTreeInplaceManager = class (TElTreeInplaceManager)
  end;

// TELTreeItemDataLink

  TElTreeItemDataLink = class (TDataLink)
  private
    FElDBTreeItem: TElDBTreeItem;
  protected
    procedure RecordChanged(Field: TField); override;
  public
    constructor Create(AElDBTreeItem: TElDBTreeItem);
  end;

// TElDBTreeItem
{$HINTS OFF}
{$WARNINGS OFF}

  TElDBTreeItem = class (TElTreeItem)
  private
    function GetAncestor: TElDBTreeItem;
  protected
    FBookmark: TBookmark;
    FChangingItem: Boolean;
    FCheckBoxField: string;
    FCheckBoxFromBase: Boolean;
    FDataField: string;
    FDataLink: TElTreeItemDataLink;
    FDenyLookSetPosition: Boolean;
    FDetailField: string;
    FEditingField: string;
    FHintField: string;
    FHintFromBase: Boolean;
    FImage2Index: string;
    FImageIndex: string;
    FImagesFromBase: Boolean;
    FMarker: Boolean;
    FMasterField: string;
    FMasterValue: TElFString;
    FPattern: TElFString;
    FRecNum: Integer;
    FRelIndex: Integer;
    FStImage2Index: string;
    FStImageIndex: string;
    procedure DeleteChild;
    function GetDataSource: TDataSource;
    function GetItems(Index: integer): TElDBTreeItem;
    function GetOwner: TCustomElDBTree;
    function GetParent: TElDBTreeItem;
    function GetText: TElFString;
    procedure MoveTo(NewParent: TElDBTreeItem);
    procedure MoveToIns(NewParent: TElDBTreeItem; AnIndex: integer);
    procedure MoveToItem(Item: TElDBTreeItem; Mode: TNodeAttachMode);
    procedure SetDataSource(Value: TDataSource);
    procedure SetStyle;
    procedure SetText(Value: TElFString); override;
    property CheckBoxField: string read FCheckBoxField write FCheckBoxField;
    property CheckBoxFromBase: Boolean read FCheckBoxFromBase write
            FCheckBoxFromBase;
    property DataField: string read FDataField write FDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property DetailField: string read FDetailField write FDetailField;
    property HintField: string read FHintField write FHintField;
    property HintFromBase: Boolean read FHintFromBase write FHintFromBase;
    property Image2IndexField: string read FImage2Index write FImage2Index;
    property ImageIndexField: string read FImageIndex write FImageIndex;
    property ImagesFromBase: Boolean read FImagesFromBase write FImagesFromBase;
    property MasterField: string read FMasterField write FMasterField;
    property StateImage2IndexField: string read FStImage2Index write
            FStImage2Index;
    property StateImageIndexField: string read FStImageIndex write
            FStImageIndex;
  public
    constructor Create(AOwner: TCustomELTree); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Delete; override;
    function GetChildByIndex(index: integer): TElDBTreeItem;
    function GetFirstChild: TElDBTreeItem;
    function GetFirstSibling: TElDBTreeItem;
    function GetFirstVisibleChild: TElDBTreeItem;
    function GetLastChild: TElDBTreeItem;
    function GetLastSibling: TElDBTreeItem;
    function GetLastSubItem: TElDBTreeItem;
    function GetNext: TElDBTreeItem; virtual;
    function GetNextChild(Child: TElDBTreeItem): TElDBTreeItem;
    function GetNextSibling: TElDBTreeItem;
    function GetNextVisible: TElDBTreeItem;
    function GetPrev: TElDBTreeItem; virtual;
    function GetPrevChild(Child: TElDBTreeItem): TElDBTreeItem;
    function GetPrevSibling: TElDBTreeItem;
    function GetPrevVisible: TElDBTreeItem;
    procedure Refresh;
    property Ancestor: TElDBTreeItem read GetAncestor;
    property Bookmark: TBookmark read FBookmark;
    property Children[Index: integer]: TElDBTreeItem read GetItems;
    property EditingField: string read FEditingField;
    property Item[Index: integer]: TElDBTreeItem read GetItems;
    property MasterValue: TElFString read FMasterValue;
    property Owner: TCustomElDBTree read GetOwner;
    property Parent: TElDBTreeItem read GetParent;
    property RelationIndex: Integer read FRelIndex;
    property Text: TElFString read GetText write SetText;
    property TreeView: TCustomElDBTree read GetOwner;
  end;

{$WARNINGS ON}

  TElDBTreeItems = class (TElTreeItems)
  private
    function GetDBItem(Index: integer): TElDBTreeItem;
    function GetDBRootItem(Index: Integer): TElDBTreeItem;
    function GetDBVisItem(Index: integer): TElDBTreeItem;
  protected
    function Add(Item: TElTreeItem; Text: TElFString): TElTreeItem; override;
    function AddChild(Item: TElTreeItem; Text: TElFString): TElTreeItem;
            override;
    function AddChildFirst(Item: TElTreeItem; Text: TElFString): TElTreeItem;
            override;
    function AddChildObject(Item: TElTreeItem; Text: TElFString; Ptr: pointer):
            TElTreeItem; override;
    function AddChildObjectFirst(Item: TElTreeItem; Text: TElFString; Ptr:
            pointer): TElTreeItem; override;
    function AddFirst(Item: TElTreeItem; Text: TElFString): TElTreeItem;
            override;
    function AddItem(Parent: TElTreeItem): TElTreeItem;
    function AddLastItem(Parent: TElTreeItem): TElTreeItem;
    function AddObject(Item: TElTreeItem; Text: TElFString; Ptr: pointer):
            TElTreeItem; override;
    function AddObjectFirst(Item: TElTreeItem; Text: TElFString; Ptr: pointer):
            TElTreeItem; override;
    procedure Clear;
    procedure Delete(Item: TElTreeItem); override;
    procedure DeleteItem(Child: TElTreeItem);
    function Insert(Item: TElTreeItem; Text: TElFString): TElTreeItem; override;
    function InsertAfter(Item: TElTreeItem; Text: TElFString): TElTreeItem;
            override;
    function InsertAfterObject(Item: TElTreeItem; Text: TElFString; Ptr:
            Pointer): TElTreeItem; override;
    function InsertItem(Index: integer; Parent: TElTreeItem): TElTreeItem;
    function InsertObject(Item: TElTreeItem; Text: TElFString; Ptr: pointer):
            TElTreeItem; override;
    procedure LoadFromFile(FileName: string);
    procedure LoadFromStream(Stream: TStream);
    procedure LoadFromStringList(Strings: TStrings);

  {$IFDEF ELPACK_UNICODE}
  {$IFDEF D_4_UP}
    procedure LoadFromWideStringList(Strings: TElWideStrings);
  {$ENDIF}
  {$ENDIF}
    procedure SetItem(Index: Integer; Value: TElTreeItem);
  public
    procedure Assign(Source: TPersistent); override;
    function GetFirstNode: TElDBTreeItem;
    property Item[Index: integer]: TElDBTreeItem read GetDBItem; default;
    property ItemAsVis[Index: integer]: TElDBTreeItem read GetDBVisItem;
    property RootItem[Index: Integer]: TElDBTreeItem read GetDBRootItem;
  end;

{$HINTS ON}

// Collection for Styles

  TElStylesDefsItem = class (TCollectionItem)
  protected
    FAllowEdit: Boolean;
    FBkColor: TColor;
    FBold: Boolean;
    FBorderStyle: TElItemBorderStyle;
    FCaption: TElFString;
    FCheckBox: string;
    FCheckBoxEnabled: Boolean;
    FColor: TColor;
    FDataField: ShortString;
    FDataFields: TStringList;
    FHasColumn: Boolean;
    FDataLink: TDataLink;
    FDrawHLine: Boolean;
    FEnabled: Boolean;
    FForceButtons: Boolean;
    FHeight: Integer;
    FHidden: Boolean;
    FHint: string;
    FHintField: string;
    FHintIsHTML: Boolean;
    FImage: string;
    FImage2: string;
    FImageIndex: Integer;
    FImageIndex2: Integer;
    FImagesFromBase: Boolean;
    FIndentAdjust: Integer;
    FInDesign: Boolean;
    FIsHTML: Boolean;
    FItalic: Boolean;
    FMultiline: Boolean;
    FOwnerHeight: Boolean;
    FParentColors: Boolean;
    FParentStyle: Boolean;
    FPattern: TELFString;
    FRowBkColor: TColor;
    FShowCaption: Boolean;
    FShowCheckBox: Boolean;
    FStImage: string;
    FStImage2: string;
    FStImageIndex: Integer;
    FStImageIndex2: Integer;
    FStrikedLineColor: TColor;
    FStrikedOutLine: Boolean;
    FStrikeout: Boolean;
    FStyleCaption: string;
    FSuppressButtons: Boolean;
    FSuppressLines: Boolean;
    FUnderlined: Boolean;
    FUseBkColor: Boolean;
    FUsePattern: Boolean;
    procedure DefineProperties(Filer: TFiler); override;
    function GetDataFields: TStringList;
    function GetDataSetName: string;
    procedure ReadParentStyle(Reader: TReader);
    procedure SetAllowEdit(Value: Boolean);
    procedure SetBkColor(Value: TColor);
    procedure SetBold(Value: Boolean);
    procedure SetBorderStyle(Value: TElItemBorderStyle);
    procedure SetCaption(Value: TElFString);
    procedure SetCheckBox(const Value: string);
    procedure SetCheckBoxEnabled(Value: Boolean);
    procedure SetColor(Value: TColor);
    procedure SetDataFields(Value: TStringList);
    procedure SetDrawHLine(Value: Boolean);
    procedure SetEnabled(Value: Boolean);
    procedure SetForceButtons(Value: Boolean);
    procedure SetHeight(Value: Integer);
    procedure SetHidden(Value: Boolean);
    procedure SetHint(const Value: string);
    procedure SetHintField(const Value: string);
    procedure SetHintIsHTML(Value: Boolean);
    procedure SetImage(const Value: string);
    procedure SetImage2(const Value: string);
    procedure SetImageIndex(Value: Integer);
    procedure SetImageIndex2(Value: Integer);
    procedure SetImagesFromBase(Value: Boolean);
    procedure SetIndentAdjust(Value: Integer);
    procedure SetIsHTML(Value: Boolean);
    procedure SetItalic(Value: Boolean);
    procedure SetMultiline(Value: Boolean);
    procedure SetOwnerHeight(Value: Boolean);
    procedure SetParentColors(Value: Boolean);
    procedure SetParentStyle(Value: Boolean);
    procedure SetPattern(Value: TELFString);
    procedure SetRowBkColor(Value: TColor);
    procedure SetShowCaption(Value: Boolean);
    procedure SetShowCheckBox(Value: Boolean);
    procedure SetStateImageIndex(Value: Integer);
    procedure SetStateImageIndex2(Value: Integer);
    procedure SetStImage(const Value: string);
    procedure SetStImage2(const Value: string);
    procedure SetStrikedLineColor(Value: TColor);
    procedure SetStrikedOutLine(Value: Boolean);
    procedure SetStrikeout(Value: Boolean);
    procedure SetStyleCaption(const Value: string);
    procedure SetSuppressButtons(Value: Boolean);
    procedure SetSuppressLines(Value: Boolean);
    procedure SetUnderlined(Value: Boolean);
    procedure SetUseBkColor(Value: Boolean);
    procedure SetUsePattern(Value: Boolean);
    property DataSetName: string read GetDataSetName;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  published
    property AllowEdit: Boolean read FAllowEdit write SetAllowEdit;
    property BkColor: TColor read FBkColor write SetBkColor;
    property Bold: Boolean read FBold write SetBold;
    property BorderStyle: TElItemBorderStyle read FBorderStyle write
            SetBorderStyle;
    property Caption: TElFString read FCaption write SetCaption;
    property CheckBox: string read FCheckBox write SetCheckBox;
    property CheckBoxEnabled: Boolean read FCheckBoxEnabled write
            SetCheckBoxEnabled;
    property Color: TColor read FColor write SetColor;
    property DataFields: TStringList read GetDataFields write SetDataFields;
    property DrawHLine: Boolean read FDrawHLine write SetDrawHLine;
    property Enabled: Boolean read FEnabled write SetEnabled default True;
    property ForceButtons: Boolean read FForceButtons write SetForceButtons;
    property Height: Integer read FHeight write SetHeight;
    property Hidden: Boolean read FHidden write SetHidden;
    property Hint: string read FHint write SetHint;
    property HintField: string read FHintField write SetHintField;
    property HintIsHTML: Boolean read FHintIsHTML write SetHintIsHTML;
    property Image: string read FImage write SetImage;
    property Image2: string read FImage2 write SetImage2;
    property ImageIndex: Integer read FImageIndex write SetImageIndex;
    property ImageIndex2: Integer read FImageIndex2 write SetImageIndex2;
    property ImagesFromBase: Boolean read FImagesFromBase write
            SetImagesFromBase;
    property IndentAdjust: Integer read FIndentAdjust write SetIndentAdjust;
    property IsHTML: Boolean read FIsHTML write SetIsHTML;
    property Italic: Boolean read FItalic write SetItalic;
    property Multiline: Boolean read FMultiline write SetMultiline;
    property OwnerHeight: Boolean read FOwnerHeight write SetOwnerHeight;
    property ParentColors: Boolean read FParentColors write SetParentColors;
    property ParentFontStyle: Boolean read FParentStyle write SetParentStyle;
    property Pattern: TELFString read FPattern write SetPattern;
    property RowBkColor: TColor read FRowBkColor write SetRowBkColor;
    property ShowCaption: Boolean read FShowCaption write SetShowCaption;
    property ShowCheckBox: Boolean read FShowCheckBox write SetShowCheckBox;
    property StateImageIndex: Integer read FStImageIndex write
            SetStateImageIndex;
    property StateImageIndex2: Integer read FStImageIndex2 write
            SetStateImageIndex2;
    property StImage: string read FStImage write SetStImage;
    property StImage2: string read FStImage2 write SetStImage2;
    property StrikedLineColor: TColor read FStrikedLineColor write
            SetStrikedLineColor;
    property StrikedOutLine: Boolean read FStrikedOutLine write
            SetStrikedOutLine;
    property Strikeout: Boolean read FStrikeout write SetStrikeout;
    property StyleCaption: string read FStyleCaption write SetStyleCaption;
    property SuppressButtons: Boolean read FSuppressButtons write
            SetSuppressButtons;
    property SuppressLines: Boolean read FSuppressLines write SetSuppressLines;
    property Underlined: Boolean read FUnderlined write SetUnderlined;
    property UseBkColor: Boolean read FUseBkColor write SetUseBkColor;
    property UsePattern: Boolean read FUsePattern write SetUsePattern default
            False;
  end;


//  TElStylesDefs

  TElStylesDefs = class (TCollection)
  private
    FCanAppend: Boolean;
    FCustomElDBTree: TCustomElDBTree;
    function GetItem(Index: Integer): TElStylesDefsItem;
    procedure SetItem(Index: Integer; Value: TElStylesDefsItem);
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(ACustomElDBTree: TCustomElDBTree; ItemClass:
            TCollectionItemClass);
    function Add: TElStylesDefsItem;
    procedure Delete(Index: Integer);
    property Items[Index: Integer]: TElStylesDefsItem read GetItem write
            SetItem; default;
    property Tree: TCustomElDBTree read FCustomElDBTree;
  end;


  TElCustomDataLink = class (TDataLink)
  private
    FOldFilter: string;
    FOldFiltered: Boolean;
    FRecCount: Integer;
    FTree: TCustomElDBTree;
  protected
    procedure ActiveChanged; override;
    procedure RecordChanged(Field: TField); override;
  public
    constructor Create;
  end;

// TDBTreeView
  TElDBTreeView = class (TElTreeView)
  protected
    procedure EditOperationAccepted; override;
    procedure EditOperationCancelled; override;
  end;

//TCustomElDBTree
  TCustomElDBTree = class (TCustomElTree)
  private
    FNoRebuildOnDataChange : Boolean;
    FCustomDataEditing: Boolean;
    FCustomSectionNum: Integer;
    function GetDBDropTarget: TElDBTreeItem;
    function GetDBSelected: TElDBTreeItem;
    function GetDBTopItem: TElDBTreeitem;
    function GetDBTrackItem: TElDBTreeItem;
    procedure SetDBSelected(const Value: TElDBTreeItem);
    procedure SetDBTopItem(const Value: TElDBTreeitem);
    procedure SetPrebuildLevelCount(const Value: Integer);
    function ParsePattern(Pattern: TElFString; ADataSet: TDataSet): TElFString;
   {$IFDEF ELPACK_UNICODE}
    function GetWideStringText(Field : TField): WideString;
   {$ELSE}
    function GetWideStringText(Field : TField): String;
   {$ENDIF}
  protected
    FChanging: Boolean;
    FCheckField: Boolean;
    FDataLink: TElTreeDataLink;
    FDragItem: TElDBTreeItem;
    FGlobalChange: Boolean;
    FInserting: Boolean;
    FListOfSets: TList;
    FMaxLevelCount: Integer;
    FOnActivateLevel: TOnActivateLevel;
    FOnAfterRebuildTree: TNotifyEvent;
    FOnCustomColumnDataNeed: TOnCustomColumnDataNeed;
    FOnItemChanged: TOnItemChangedEvent;
    FOnItemCreated: TOnItemCreated;
    FOnMyDrag: TEndDragEvent;
    FOnMyOver: TDragOverEvent;
    FOnMyStartDrag: TStartDragEvent;
    FPrebuildLevelCount: Integer;
    FSource: TElRelDataSource;
    FStylesDefs: TElStylesDefs;
    FTablRelName: TTableName;
    FUnicodeMode: TElDBUnicodeMode;
    procedure CheckField(Field: TField);
    function CreateNewItemInRoot: TElDBTReeItem; virtual;
    function CreateView: TElTreeView; override;
    procedure DataSetChanged;
    procedure DefineProperties(Filer: TFiler); override;
    procedure DoItemCollapsing(AItem: TElTreeItem; var CanProcess: boolean);
            override;
    procedure DoItemExpanding(AItem: TElTreeItem; var CanProcess: boolean);
            override;
    procedure EditCanceled;
    function GetDBItems: TElDBTreeItems;
    function GetItemFocused: TElDBTreeItem;
    function GetSource: TElRelDataSource;
    procedure KeyDownTransfer(Sender : TObject; var Key : Word; Shift :
            TShiftState); override;
    procedure MoveToNewParent(FElDBTreeItem: TElDBTreeItem; Field: TField);
    procedure Notification(AComponent: TComponent; Operation: TOperation);
            override;
    procedure OnHeaderSectionChange(Sender: TCustomElHeader; Section:
            TElHeaderSection; Change: TSectionChangeMode); override;
    procedure ProcessItem(ACurItem: TElDBTreeItem; FStepCount: integer);
    procedure RebuildItemChilds(AElDBTreeItem: TElDBTreeItem);
    procedure RebuildStylesOnLevel(StyleNum: integer; code: TUpdateStylesType);
    procedure RebuildTableRelationsLevels(AName: TTableName); virtual;
    procedure SetItemFocused(Value: TElDBTreeItem);
    procedure SetSource(Source: TElRelDataSource); virtual;
    procedure SetStylesDefs(Value: TElStylesDefs);
    procedure TriggerInplaceEditorNeeded(Item: TElTreeItem; SectionIndex:
            Integer; SupposedFieldType: TElFieldType; var Editor:
            TElTreeInplaceEditor); override;
    procedure TriggerItemSelectedChangeEvent(AItem: TElTreeItem); override;
    procedure TriggerLinkClickEvent(HRef: string; X, Y: integer); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetItemAt(X, Y: Integer; var ItemPart: TSTItemPart; var HitColumn:
            integer): TElDBTreeItem;  {$ifdef VCL_4_USED} reintroduce;{$endif} virtual;
    function GetItemAtY(Y: integer): TElDBTreeItem;  {$ifdef VCL_4_USED} reintroduce;{$endif} virtual;
    function GetNextSelected(Prev: TElTreeItem): TElDBTreeItem;  {$ifdef VCL_4_USED} reintroduce;{$endif}virtual;
    function GetNodeAt(X, Y: integer): TElDBTreeItem;
    procedure RebuildTree(KeepCurrentID: Boolean); virtual;
    property DataChange: Boolean read FChanging write FChanging;
    property DropTarget: TElDBTreeItem read GetDBDropTarget;
    property ItemFocused: TElDBTreeItem read GetItemFocused write
            SetItemFocused;
    property Items: TElDBTreeItems read GetDBItems;
    property Selected: TElDBTreeItem read GetDBSelected write SetDBSelected;
    property TopItem: TElDBTreeitem read GetDBTopItem write SetDBTopItem;
    property TrackItem: TElDBTreeItem read GetDBTrackItem;
  published
    property NoRebuildOnDataChange : Boolean read FNoRebuildOnDataChange write FNoRebuildOnDataChange;
    property AlphaForImages;
    property DataSource: TElRelDataSource read GetSource write SetSource;
    property Images;
    property MaxLevelCount: Integer read FMaxLevelCount write FMaxLevelCount;
    property OnActivateLevel: TOnActivateLevel read FOnActivateLevel write
            FOnActivateLevel;
    property OnAfterRebuildTree: TNotifyEvent read FOnAfterRebuildTree write
            FOnAfterRebuildTree;
    property OnCustomColumnDataNeed: TOnCustomColumnDataNeed read
            FOnCustomColumnDataNeed write FOnCustomColumnDataNeed;
    property OnItemChanged: TOnItemChangedEvent read FOnItemChanged write
            FOnItemChanged;
    property OnItemCreated: TOnItemCreated read FOnItemCreated write
            FOnItemCreated;
    property PrebuildLevelCount: Integer read FPrebuildLevelCount write
            SetPrebuildLevelCount default 2;
    property StylesDefs: TElStylesDefs read FStylesDefs write SetStylesDefs;
    property UnicodeMode: TElDBUnicodeMode read FUnicodeMode write FUnicodeMode
            default umFieldType;
    property VirtualityLevel;
  end;

  TElDBTree = class (TCustomElDBTree)
  published
  {$IFDEF D_4_UP}
    property Action;
  {$ENDIF}
    property NoRebuildOnDataChange;
    property ActiveBorderType;
    property AdjustMultilineHeight;
    property Align;
    property AlphaForImages;
    property AlphaForImages2;
    property AlwaysKeepFocus;
    property AlwaysKeepSelection;
  {$IFDEF D_4_UP}
    property Anchors;
  {$ENDIF}
    property AutoCollapse;
    property AutoExpand;
    property AutoLineHeight;
    property AutoLookup;
    property AutoResizeColumns;
    property Background;
    property BackgroundType;
    property BarStyle;
    property BarStyleVerticalLines;
  {$IFDEF D_4_UP}
    property BevelKind;
  {$ENDIF}
    property BkColor;
    property BorderSides;
    property BorderStyle;
    property ChangeDelay;
    property ChangeStateImage;
    property CheckBoxGlyph;
    property CheckBoxSize;
    property Color;
  {$IFDEF D_4_UP}
    property Constraints;
  {$ENDIF}
    property Ctl3D;
    property Cursor;
    property CustomCheckboxes;
    property CustomPlusMinus;
    property DataSource;
    property DblClickMode;
    property DefaultSectionWidth;
    property DeselectChildrenOnCollapse;
  {$IFDEF D_4_UP}
    property DockOrientation;
  {$ENDIF}
    property DoInplaceEdit;
    property DoubleBuffered;
    property DragAllowed;
    property DragCursor;
    property DragExpandDelay;
    property DraggableSections;
    property DragImageMode;
  {$IFDEF D_4_UP}
    property DragKind;
  {$ENDIF}
    property DragRectAcceptColor;
    property DragRectDenyColor;
    property DragScrollInterval;
    property DragTrgDrawMode;
    property DragType;
    property DrawFocusRect;
    property Enabled;
    property ExpandOnDragOver;
    property ExplorerEditMode;
    property FilteredVisibility;
    property Flat;
    property FlatFocusedScrollbars;
  {$IFDEF D_4_UP}
    property Floating;
  {$ENDIF}
    property FocusedSelectColor;
    property FocusedSelectTextColor;
    property Font stored true;
    property ForcedScrollBars;
    property FullRowSelect;
    property GradientEndColor;
    property GradientStartColor;
    property GradientSteps;
    property HeaderImageForm;
    property HideFocusRect;
    property HideHintOnMove;
    property HideHintOnTimer;
    property HideHorzScrollBar;
    property HideSelectColor;
    property HideSelection;
    property HideSelectTextColor;
    property HideVertScrollBar;
    property Hint;
    property HintType;
    property HorizontalLines;
    property HorzDivLinesColor;
    property HorzScrollBarStyles;
    property HorzScrollTracking;
    property IgnoreEnabled;
    property ImageForm;
    property Images;
    property Images2;
    property InactiveBorderType;
    property IncrementalSearch;
    property IncrementalSearchScope;
    property ItemIndent;
    property KeepSelectionWithinLevel;
    property LeafPicture;
    property LineBorderActiveColor;
    property LineBorderInactiveColor;
    property LineHeight;
    property LineHintColor;
    property LineHintMode default shmLong;
    property LineHintTimeout;
    property LineHintType;
    property LinesColor;
    property LinesStyle;
    property LinkColor;
    property LinkCursor;
    property LinkStyle;
    property LockHeaderHeight;
    property MainTreeColumn;
    property MaxLevelCount;
    property MinusPicture;
    property MouseFrameSelect;
    property MoveColumnOnDrag;
    property MoveFocusOnCollapse;
    property MultiSelect;
    property MultiSelectLevel;
    property OnAfterRebuildTree;
    property OnAfterSelectionChange;
    property OnCellStyleLoad;
    property OnCellStyleSave;
    property OnChanging;
    property OnClick;
{$ifndef VER3_EDITORS}
{$ifdef ELTREE_USE_INPLACE_EDITORS}
    property OnComboEditShow;
{$endif}
{$endif}
    property OnCompareItems;
  {$IFDEF D_5_UP}
    property OnContextPopup;
  {$ENDIF}
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDragTargetChange;
{$ifndef VER3_EDITORS}
{$ifdef ELTREE_USE_INPLACE_EDITORS}
    property OnEditKeyDown;
    property OnEditRequest;
{$endif}
{$endif}
  {$IFDEF D_4_UP}
    property OnEndDock;
  {$ENDIF}
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnHorzScrollDrawPart;
    property OnHorzScrollHintNeeded;
    property OnHotTrack;
    property OnHTMLImageNeeded;
    property OnInplaceEditorNeeded;
    property OnItemChange;
    property OnItemChecked;
    property OnItemCollapse;
    property OnItemCollapsing;
    property OnItemDraw;
    property OnItemExpand;
    property OnItemExpanding;
    property OnItemFocused;
    property OnItemPicDraw;
    property OnItemPicDraw2;
    property OnItemPostDraw;
    property OnItemPreDraw;
    property OnItemSave;
    property OnItemSelectedChange;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnLinkClick;
    property OnMeasureItemPart;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
  {$IFDEF D_4_UP}
    property OnMouseWheel;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
  {$ENDIF}
    property OnResize;
    property OnScroll;
    property OnShowLineHint;
    property OnSortBegin;
    property OnSortEnd;
  {$IFDEF D_4_UP}
    property OnStartDock;
  {$ENDIF}
    property OnStartDrag;
{$ifndef VER3_EDITORS}
{$ifdef ELTREE_USE_INPLACE_EDITORS}
    property OnTryEdit;
    property OnTuneUpInplaceEdit;
    property OnValidateCombo;
    property OnValidateInplaceEdit;
{$endif}
{$endif}
    property OnVertScrollDrawPart;
    property OnVertScrollHintNeeded;
    property OnVirtualHintNeeded;
    property OnVirtualStyleNeeded;
    property OnVirtualTextNeeded;
    property OnVirtualValueNeeded;
    property OwnerDrawByColumn default true;
    property OwnerDrawMask;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PathSeparator;
    property PlusMinusTransparent;
    property PlusPicture;
    property PopupMenu;
    property RadioButtonGlyph;
    property RightAlignedText;
    property RightAlignedView;
    property RightClickSelect;
    property RowHotTrack;
    property RowSelect;
    property ScrollbarOpposite;
    property SelectColumn;
    property SelectionMode;
    property ShowButtons;
    property ShowCheckboxes;
    property ShowColumns;
    property ShowEmptyImages;
    property ShowEmptyImages2;
    property ShowHint;
    property ShowImages;
    property ShowLeafButton;
    property ShowLines;
    property ShowRoot;
    property ShowRootButtons;
    property SortDir;
    property SortMode;
    property SortSection;
    property SortType;
    property SortUseCase;
    property StickyHeaderSections;
    property Storage;
    property StoragePath;
    property StripedEvenColor;
    property StripedItems;
    property StripedOddColor;
    property StylesDefs;
    property TabOrder;
    property TabStop;
    property TextColor;
    property TrackColor;
    property Tracking;
    property UnderlineTracked;
    property UseCustomScrollBars;
    property UseSystemHintColors;
    property UseXPThemes;
    property VertDivLinesColor;
    property VerticalLines;
    property VerticalLinesLong;
    property VertScrollBarStyles;
    property VertScrollTracking;
    property VirtualityLevel;
    property Visible;
  end;

implementation


type
  TElDBDragObject = class (TDragControlObject)
    function GetDragCursor(Accepted: Boolean; X, Y: Integer): TCursor; override;
  end;

{
******************************* TElDBDragObject ********************************
}
function TElDBDragObject.GetDragCursor(Accepted: Boolean; X, Y: Integer):
        TCursor;
begin
  if Control is TElTree then
  begin
    if ((Control as TElTree).GetItemAtY(Y) <> nil) or (Accepted) then
      Result := (Control as TElTree).DragCursor
    else
      Result := crNoDrop;
  end
  else
    Result := inherited GetDragCursor(Accepted, X, Y);
end;

// TTreeItemDataLink

{
***************************** TElTreeItemDataLink ******************************
}
constructor TElTreeItemDataLink.Create(AElDBTreeItem: TElDBTreeItem);
begin
  inherited Create;
  FElDBTreeItem := AElDBTreeItem;
  {$IFDEF D_4_UP}
  VisualControl := false;
  {$ENDIF}
end;

procedure TElTreeItemDataLink.RecordChanged(Field: TField);
var
  i: Integer;
  book: TBookmark;
begin
  if not FElDBTreeItem.Owner.FNoRebuildOnDataChange then
  begin
    if not FElDBTreeItem.Owner.FChanging then
    begin
      if (Field <> nil) then
      begin
        book := field.DataSet.GetBookmark;
        if ( Field.DataSet.CompareBookmarks(book,FElDBTreeItem.FBookmark) = 0 ) then
        begin
          if (Field.DataSet.RecNo <> -1) then
          begin
            if not (FElDBTreeItem.FDenyLookSetPosition) then // and (not FElDBTreeItem.Owner.FChanging) and (Field.DataSet.Name = FElDBTreeItem.FDataLink.DataSet.Name)
            begin
              if Self.FElDBTreeItem.TreeView.IsEditing then Abort;
              FElDBTreeItem.FChangingItem := True;
              FElDBTreeItem.Owner.FGlobalChange := True;

              i := FElDBTreeItem.Owner.StylesDefs[FElDBTreeItem.FRelIndex].DataFields.IndexOf({$IFNDEF VCL_3_USED}Field.FullName{$ELSE}Field.FieldName{$ENDIF});
              if (i > -1) then
                FElDBTreeItem.ColumnText.Strings[i] := FElDBTreeItem.Owner.GetWideStringText(Field.DataSet.FieldByName(FElDBTreeItem.TreeView.StylesDefs[FElDBTreeItem.FRelIndex].DataFields[i]));

              if (not (Field.IsNull)) then
                if (FElDBTreeItem.FPattern <> '') then
                  FElDBTreeItem.Text := FElDBTreeItem.TreeView.ParsePattern(FElDBTreeItem.FPattern, FElDBTreeItem.FDataLink.DataSet)
                else if (FElDBTreeItem.DataField = Field.FieldName) then FElDBTreeItem.Text := Field.DisplayText;
              if ((UpperCase(FElDBTreeItem.ImageIndexField) = UpperCase(Field.FieldName))) or ((UpperCase(FElDBTreeItem.StateImageIndexField) = UpperCase(Field.FieldName))) or ((UpperCase(FElDBTreeItem.Image2IndexField) = UpperCase(Field.FieldName))) or ((UpperCase(FElDBTreeItem.StateImage2IndexField) = UpperCase(Field.FieldName))) or ((UpperCase(FElDBTreeItem.CheckBoxField) = UpperCase(Field.FieldName))) then
              begin
                if FElDBTreeItem.ImagesFromBase then
                begin
                  if (UpperCase(FElDBTreeItem.ImageIndexField) = UpperCase(Field.FieldName)) then
                    FElDBTreeItem.ImageIndex := StrToInt(Field.text);
                  if (UpperCase(FElDBTreeItem.StateImageIndexField) = UpperCase(Field.FieldName)) then
                    FElDBTreeItem.StateImageIndex := StrToInt(Field.text);
                  if (UpperCase(FElDBTreeItem.Image2IndexField) = UpperCase(Field.FieldName)) then
                    FElDBTreeItem.ImageIndex2 := StrToInt(Field.text);
                  if (UpperCase(FElDBTreeItem.StateImage2IndexField) = UpperCase(Field.FieldName)) then
                    FElDBTreeItem.StateImageIndex2 := StrToInt(Field.text);
                end;
                if (FElDBTreeItem.CheckBoxFromBase) and (UpperCase(FElDBTreeItem.CheckBoxField) = UpperCase(Field.FieldName)) then
                begin
                  if (LowerCase(Field.text) = 'true') then FElDBTreeItem.CheckBoxState := cbChecked
                  else FElDBTreeItem.CheckBoxState := cbUnChecked;
                  if Field.text = '' then FElDBTreeItem.CheckBoxState := cbGrayed;
                end;
                FElDBTreeItem.Owner.RebuildItemChilds(FElDBTreeItem);
                FElDBTreeItem.Expanded := false;
              end;
              if (UpperCase(FElDBTreeItem.DetailField) = UpperCase(Field.FieldName)) then
                begin
                  FElDBTreeItem.Owner.MoveToNewParent(FElDBTreeItem,Field);
                end
              else if (FElDBTreeItem <> nil) and (UpperCase(FElDBTreeItem.MasterField) = UpperCase(Field.FieldName)) then
                FElDBTreeItem.Owner.RebuildItemChilds(FElDBTreeItem);
              FElDBTreeItem.FChangingItem := False;
            end;
          end;
        end;
        Field.DataSet.FreeBookmark(book);
      end;
    end;
  end;
end;

// TElDBTreeItem

{
******************************** TElDBTreeItem *********************************
}
constructor TElDBTreeItem.Create(AOwner: TCustomELTree);
begin
  inherited Create(AOwner);
  FDataLink := TElTreeItemDataLink.Create(Self);
  FDataLink.DataSource := nil;
  FImagesFromBase := False;
  FDenyLookSetPosition := False;
end;

destructor TElDBTreeItem.Destroy;
begin
  if (FDataLink.DataSet <> nil) and (FBookmark <> nil) then FDataLink.DataSet.FreeBookmark(FBookmark);
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

procedure TElDBTreeItem.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if (Source is TElDBTreeItem) then
  begin
    FDataLink.DataSource := (Source as TElDBTreeItem).FDataLink.DataSource;
    FBookmark := (Source as TElDBTreeItem).FDataLink.DataSet.GetBookmark;
    FRecNum := (Source as TElDBTreeItem).FRecNum;
    FDataField := (Source as TElDBTreeItem).FDataField;
    FDetailField := (Source as TElDBTreeItem).FDetailField;
    FMasterField := (Source as TElDBTreeItem).FMasterField;
    FMasterValue := (Source as TElDBTreeItem).FMasterValue;
    FRelIndex := (Source as TElDBTreeItem).FRelIndex;
    FImagesFromBase := (Source as TElDBTreeItem).FImagesFromBase;
    FCheckBoxFromBase := (Source as TElDBTreeItem).FCheckBoxFromBase;
    FImageIndex := (Source as TElDBTreeItem).FImageIndex;
    FStImageIndex := (Source as TElDBTreeItem).FStImageIndex;
    FImage2Index := (Source as TElDBTreeItem).FImage2Index;
    FStImage2Index := (Source as TElDBTreeItem).FStImage2Index;
    FCheckBoxField := (Source as TElDBTreeItem).FCheckBoxField;
    FHintField := (Source as TElDBTreeItem).HintField;
    Hint := (Source as TElDBTreeItem).Hint;
  end;
end;

procedure TElDBTreeItem.Delete;
var
  c: Boolean;
begin
  c := Owner.FChanging;
  Owner.FChanging := True;
  if ChildrenCount <> 0 then DeleteChild;
  {$IFDEF ELTREE_USE_STYLES}
  if Assigned(MainStyle.Picture) then
    MainStyle.Picture.Free;
  {$ENDIF}
  Owner.FChanging := c;
  inherited Delete;
end;

procedure TElDBTreeItem.DeleteChild;
var
  ritem: TElDBTreeItem;
  c: Boolean;
begin
  c := Owner.FChanging;
  Owner.FChanging := True;
  ritem := GetFirstChild;
  while Assigned(ritem) do
  begin
    if ritem.ChildrenCount = 0 then ritem.Delete
    else begin
      ritem.DeleteChild;
      ritem.Delete;
    end;
    ritem := GetFirstChild;
  end;
  Owner.FChanging := c;
end;

function TElDBTreeItem.GetAncestor: TElDBTreeItem;
var
  i: TElTreeItem;
begin
  i := inherited GetAncestor;
  if i <> nil then Result := TElDBTreeItem(i)
  else Result := nil;
end;

function TElDBTreeItem.GetChildByIndex(index: integer): TElDBTreeItem;
begin
  Result := TElDBTreeItem(inherited GetChildByIndex(index));
end;

function TElDBTreeItem.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

function TElDBTreeItem.GetFirstChild: TElDBTreeItem;
begin
  Result := TElDBTreeItem(inherited GetFirstChild);
end;

function TElDBTreeItem.GetFirstSibling: TElDBTreeItem;
begin
  Result := TElDBTreeItem(inherited GetFirstSibling);
end;

function TElDBTreeItem.GetFirstVisibleChild: TElDBTreeItem;
begin
  Result := TElDBTreeItem(inherited GetFirstVisibleChild);
end;

function TElDBTreeItem.GetItems(Index: integer): TElDBTreeItem;
begin
  Result := TElDBTreeItem(inherited GetItems(Index));
end;

function TElDBTreeItem.GetLastChild: TElDBTreeItem;
begin
  Result := TElDBTreeItem(inherited GetLastChild);
end;

function TElDBTreeItem.GetLastSibling: TElDBTreeItem;
begin
  Result := TElDBTreeItem(inherited GetLastSibling);
end;

function TElDBTreeItem.GetLastSubItem: TElDBTreeItem;
begin
  Result := TElDBTreeItem(inherited GetLastSubItem);
end;

function TElDBTreeItem.GetNext: TElDBTreeItem;
begin
  Result := TElDBTreeItem(inherited GetNext);
end;

function TElDBTreeItem.GetNextChild(Child: TElDBTreeItem): TElDBTreeItem;
begin
  Result := TElDBTreeItem(inherited GetNextChild(Child));
end;

function TElDBTreeItem.GetNextSibling: TElDBTreeItem;
begin
  Result := TElDBTreeItem(inherited GetNextSibling);
end;

function TElDBTreeItem.GetNextVisible: TElDBTreeItem;
begin
  Result := TElDBTreeItem(inherited GetNextVisible);
end;

function TElDBTreeItem.GetOwner: TCustomElDBTree;
begin
  Result := TCustomElDBTree(FOwner);
end;

function TElDBTreeItem.GetParent: TElDBTreeItem;
begin
  Result := TElDBTreeItem(inherited GetParent);
end;

function TElDBTreeItem.GetPrev: TElDBTreeItem;
begin
  Result := TElDBTreeItem(inherited GetPrev);
end;

function TElDBTreeItem.GetPrevChild(Child: TElDBTreeItem): TElDBTreeItem;
begin
  Result := TElDBTreeItem(inherited GetPrevChild(Child));
end;

function TElDBTreeItem.GetPrevSibling: TElDBTreeItem;
begin
  Result := TElDBTreeItem(inherited GetPrevSibling);
end;

function TElDBTreeItem.GetPrevVisible: TElDBTreeItem;
begin
  Result := TElDBTreeItem(inherited GetPrevVisible);
end;

function TElDBTreeItem.GetText: TElFString;
begin
  inherited GetText;
end;

procedure TElDBTreeItem.MoveTo(NewParent: TElDBTreeItem);
var
  TSI: TElDBTreeItem;
begin
  if NewParent = self then exit;
  if NewParent = nil then
    TSI := (FRoot as TElDBTreeItem)
  else
    TSI := NewParent;
  if TSI.FChildren = nil then
    MoveToIns(NewParent, 0)
  else
    MoveToIns(NewParent, TSI.FChildren.Count);
end;

procedure TElDBTreeItem.MoveToIns(NewParent: TElDBTreeItem; AnIndex: integer);
var
  Child: TElDBTreeItem;
begin
  if (FBookmark <> nil) and (DataSource.DataSet.Active) and (NewParent.FBookmark <> nil) and (NewParent.DataSource.DataSet.Active) then
  begin
    try
      if Level > 1 then
        if NewParent.FRelIndex <> Parent.FRelIndex then raise EOnMoveError.Create(SOnMoveError)
        else if NewParent <> nil then raise EOnMoveError.Create(SOnMoveError);
      try
        NewParent.DataSource.DataSet.DisableControls;
        NewParent.DataSource.DataSet.GotoBookmark(NewParent.FBookmark);
        DataSource.DataSet.DisableControls;
        DataSource.DataSet.GotoBookmark(FBookmark);
        DataSource.DataSet.Edit;
        DataSource.DataSet.FieldByName(FDetailField).asString := NewParent.DataSource.DataSet.FieldByName(NewParent.FMasterField).asString;
        DataSource.DataSet.Post;
      finally
        DataSource.DataSet.EnableControls;
        NewParent.DataSource.DataSet.EnableControls;
      end;
      inherited MoveToIns(NewParent as TElTreeItem, AnIndex);
      Owner.Items.BeginUpdate;
      Child := GetFirstChild;
      while (Child <> nil) do
      begin
        Child.Delete;
        Child := GetFirstChild;
      end;
      Owner.ProcessItem((Self), 0);
      Self.Expanded := false;
      Owner.Items.EndUpdate;
    except
      on E: Exception do
      begin
        DataSource.DataSet.EnableControls;
        NewParent.DataSource.DataSet.EnableControls;
        raise EOnMoveError.Create(SOnMoveError);
      end;
    end;
  end;
end;

procedure TElDBTreeItem.MoveToItem(Item: TElDBTreeItem; Mode: TNodeAttachMode);
begin
  ;
end;

procedure TElDBTreeItem.Refresh;
var
  book: TBookmark;
  i: Integer;
  oldchanging: Boolean;
begin
  oldchanging := Owner.FChanging;
  FDataLink.DataSet.DisableControls;
  Owner.FChanging := True;
  book := FDataLink.DataSet.GetBookmark;
  FDataLink.DataSet.GotoBookmark(FBookmark);
  for i := 0 to Owner.StylesDefs[FRelIndex].DataFields.Count - 1 do
  begin
    if Owner.StylesDefs[FRelIndex].FDataFields[i] <> 'empty column or defined by user' then
      if FDataLink.DataSet.FindField(Owner.StylesDefs[FRelIndex].FDataFields[i]) <> nil then
        ColumnText.Strings[i] := FDataLink.DataSet.FieldByName(Owner.StylesDefs[FRelIndex].FDataFields[i]).AsString;
  end;
  if (FPattern <> '') then Text := TreeView.ParsePattern(FPattern, FDataLink.DataSet)
    else Text := FDataLink.DataSet.FieldByName(FDataField).AsVariant;
  if FMasterField <> '' then
    if FMasterValue <> FDataLink.DataSet.FieldByName(FMasterField).AsString then Owner.RebuildItemChilds(Self);
  FDataLink.DataSet.GotoBookmark(book);
  Owner.FGlobalChange := True;
  FDataLink.DataSet.EnableControls;
  Owner.FChanging := oldchanging;
  if Parent <> nil then
  if Parent.FMasterValue <> FDataLink.DataSet.FieldByName(FDetailField).AsString then
    begin
      Owner.CheckField(FDataLink.DataSet.FieldByName(FDetailField));
      Delete;
    end;
end;

procedure TElDBTreeItem.SetDataSource(Value: TDataSource);
begin
  if not (FDataLink.DataSourceFixed) then FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Owner);
end;

procedure TElDBTreeItem.SetStyle;
begin
  if Owner.StylesDefs[FRelIndex].FInDesign then exit;
  ParentColors := Owner.StylesDefs[FRelIndex].ParentColors;
  MainStyle.OwnerProps := false;
  if not Owner.StylesDefs[FRelIndex].ParentColors then
  begin
  {$IFDEF ELTREE_USE_STYLES}
    MainStyle.TextColor := Owner.StylesDefs[FRelIndex].Color;
    MainStyle.TextBkColor := Owner.StylesDefs[FRelIndex].BkColor;
    MainStyle.UseBkColor := Owner.StylesDefs[FRelIndex].UseBkColor;
  {$ENDIF}
    Color := Owner.StylesDefs[FRelIndex].Color;
    BkColor := Owner.StylesDefs[FRelIndex].BkColor;
    UseBkColor := Owner.StylesDefs[FRelIndex].UseBkColor;
    RowBkColor := Owner.StylesDefs[FRelIndex].RowBkColor;
  end;

  ParentFontStyle := Owner.StylesDefs[FRelIndex].ParentFontStyle;

  if Owner.StylesDefs[FRelIndex].Italic then
    MainStyle.FontStyles := MainStyle.FontStyles + [fsItalic];
  if Owner.StylesDefs[FRelIndex].Underlined then
    MainStyle.FontStyles := MainStyle.FontStyles + [fsUnderline];
  if Owner.StylesDefs[FRelIndex].Bold then
    MainStyle.FontStyles := MainStyle.FontStyles + [fsBold];
  if Owner.StylesDefs[FRelIndex].Strikeout then
    MainStyle.FontStyles := MainStyle.FontStyles + [fsStrikeout];

  ForceButtons := Owner.StylesDefs[FRelIndex].ForceButtons;
  if not Owner.StylesDefs[FRelIndex].ImagesFromBase then
  begin
    ImagesFromBase := False;
    ImageIndex := Owner.StylesDefs[FRelIndex].ImageIndex;
    StateImageIndex := Owner.StylesDefs[FRelIndex].StateImageIndex;
    ImageIndex2 := Owner.StylesDefs[FRelIndex].ImageIndex2;
    StateImageIndex2 := Owner.StylesDefs[FRelIndex].StateImageIndex2;
  end
  else
  begin
    ImagesFromBase := True;
    ImageIndexField := Owner.StylesDefs[FRelIndex].Image;
    StateImageIndexField := Owner.StylesDefs[FRelIndex].StImage;
    Image2IndexField := Owner.StylesDefs[FRelIndex].Image2;
    StateImage2IndexField := Owner.StylesDefs[FRelIndex].StImage2;
  end;

  HintIsHTML := Owner.StylesDefs[FRelIndex].HintIsHTML;
  if Owner.StylesDefs[FRelIndex].HintField <> '' then
    HintField := Owner.StylesDefs[FRelIndex].HintField
  else
    Hint := Owner.StylesDefs[FRelIndex].Hint;

  if Owner.StylesDefs[FRelIndex].CheckBox <> '' then
  begin
    CheckBoxFromBase := True;
    CheckBoxEnabled := Owner.StylesDefs[FRelIndex].CheckBoxEnabled;
    ShowCheckBox := Owner.StylesDefs[FRelIndex].ShowCheckBox;
  end
  else
  begin
    CheckBoxFromBase := False;
    CheckBoxEnabled := False;
    ShowCheckBox := False;
  end;
  CheckBoxField := Owner.StylesDefs[FRelIndex].CheckBox;

  Hidden := Owner.StylesDefs[FRelIndex].Hidden;

  Enabled := Owner.StylesDefs[FRelIndex].Enabled;
  IsHTML := Owner.StylesDefs[FRelIndex].IsHTML;
  Multiline := Owner.StylesDefs[FRelIndex].Multiline;
  DrawHLine := Owner.StylesDefs[FRelIndex].DrawHLine;
  AllowEdit := Owner.StylesDefs[FRelIndex].AllowEdit;
  SuppressButtons := Owner.StylesDefs[FRelIndex].SuppressButtons;
  SuppressLines := Owner.StylesDefs[FRelIndex].SuppressLines;

  StrikedOutLine := Owner.StylesDefs[FRelIndex].Strikeout;
  if StrikedOutLine then
    StrikedLineColor := Owner.StylesDefs[FRelIndex].StrikedLineColor;

  if Owner.StylesDefs[FRelIndex].IndentAdjust <> 0 then
    IndentAdjust := Owner.StylesDefs[FRelIndex].IndentAdjust
  else
    IndentAdjust := 0;
  BorderStyle := Owner.StylesDefs[FRelIndex].BorderStyle;
end;

procedure TElDBTreeItem.SetText(Value: TElFString);
begin
  inherited SetText(Value);
end;


// TELCustomDataLink

{
****************************** TElCustomDataLink *******************************
}
constructor TElCustomDataLink.Create;
begin
  inherited Create;
  {$IFDEF D_4_UP}
  VisualControl := true;
  {$ENDIF}
end;

procedure TElCustomDataLink.ActiveChanged;
begin
  inherited ActiveChanged;
  if Active then FRecCount := DataSet.RecordCount
  else FRecCount := -1;
end;

procedure TElCustomDataLink.RecordChanged(Field: TField);
begin
  if not FTree.FNoRebuildOnDataChange then
  begin
    if not FTree.FChanging then
    begin
      if Assigned(Field) then
        if not(Field.FieldKind in [fkLookup, fkCalculated]) then
        begin
          if (Field.DataSet.RecNo <> -1) then
          begin
            if not FTree.FGlobalChange then
              FTree.CheckField(Field);
            FTree.FGlobalChange := false;

            if FTree.FCheckField then
              FTree.RebuildTableRelationsLevels(FTree.FTablRelName);
            FTree.FCheckField := false;
          end;
        end;
      if (FOldFilter <> DataSet.Filter) or (FOldFiltered <> DataSet.Filtered) then
      begin
        if not FTree.FChanging then
        begin
          FOldFilter := DataSet.Filter;
          FOldFiltered := DataSet.Filtered;
          FRecCount := DataSet.RecordCount;
    //        if Assigned(FTree.FOnActivateLevel) then
          FTree.RebuildTree(true);
        end;
      end
      else
      begin
        if FRecCount <> DataSet.RecordCount then
        begin
          FRecCount := DataSet.RecordCount;
          if not FTree.FChanging then FTree.RebuildTableRelationsLevels(DataSet.Name);
        end;
      end;
    end;
  end;
end;


// Collection for Styles

{
****************************** TElStylesDefsItem *******************************
}
constructor TElStylesDefsItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FDataLink := TDataLink.Create;
  FDataLink.DataSource := nil;
  FDataFields := TStringList.Create;
  FOwnerHeight := True;
  FParentColors := True;
  FParentStyle := True;
  FInDesign := true;
  FEnabled := True;
  FImagesFromBase := False;
  FImageIndex := -1;
  FImageIndex2 := -1;
  FStImageIndex := -1;
  FStImageIndex2 := -1;
  FAllowEdit := True;
  FDrawHLine := True;
  FHasColumn := False;
  FShowCheckBox := (Collection as TElStylesDefs).FCustomElDBTree.ShowCheckboxes;
end;

destructor TElStylesDefsItem.Destroy;
begin
  FDataFields.Free;
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

procedure TElStylesDefsItem.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('ParentStyle', ReadParentStyle, nil, false);
end;

function TElStylesDefsItem.GetDataFields: TStringList;
begin
  Result := FDataFields;
end;

function TElStylesDefsItem.GetDataSetName: string;
begin
  if FDataLink.DataSet <> nil then Result := FDataLink.DataSet.Name;
end;

procedure TElStylesDefsItem.ReadParentStyle(Reader: TReader);
begin
  FParentStyle := Reader.ReadBoolean;
end;

procedure TElStylesDefsItem.SetAllowEdit(Value: Boolean);
begin
  if Value <> FAllowEdit then
  begin
    FAllowEdit := Value;
    (Collection as TElStylesDefs).FCustomElDBTree.RebuildStylesOnLevel(index, stFontAndStyles);
  end;
end;

procedure TElStylesDefsItem.SetBkColor(Value: TColor);
begin
  if Value <> FBkColor then
  begin
    FBkColor := Value;
    (Collection as TElStylesDefs).FCustomElDBTree.RebuildStylesOnLevel(index, stFontAndStyles);
  end;
end;

procedure TElStylesDefsItem.SetBold(Value: Boolean);
begin
  if Value <> FBold then
  begin
    FBold := Value;
    (Collection as TElStylesDefs).FCustomElDBTree.RebuildStylesOnLevel(index, stFontAndStyles);
  end;
end;

procedure TElStylesDefsItem.SetBorderStyle(Value: TElItemBorderStyle);
begin
  if Value <> FBorderStyle then
  begin
    FBorderStyle := Value;
    (Collection as TElStylesDefs).FCustomElDBTree.RebuildStylesOnLevel(index, stFontAndStyles);
  end;
end;

procedure TElStylesDefsItem.SetCaption(Value: TElFString);
begin
  if Value <> FCaption then
  begin
    FCaption := Value;
    (Collection as TElStylesDefs).FCustomElDBTree.RebuildStylesOnLevel(index, stCaption);
  end;
end;

procedure TElStylesDefsItem.SetCheckBox(const Value: string);
begin
  if Value <> FCheckBox then
  begin
    FCheckBox := Value;
    (Collection as TElStylesDefs).FCustomElDBTree.RebuildStylesOnLevel(index, stCheckBox);
  end;
end;

procedure TElStylesDefsItem.SetCheckBoxEnabled(Value: Boolean);
begin
  if Value <> FCheckBoxEnabled then
  begin
    FCheckBoxEnabled := Value;
    (Collection as TElStylesDefs).FCustomElDBTree.RebuildStylesOnLevel(index, stCheckBox);
  end;
end;

procedure TElStylesDefsItem.SetColor(Value: TColor);
begin
  if Value <> FColor then
  begin
    FColor := Value;
    (Collection as TElStylesDefs).FCustomElDBTree.RebuildStylesOnLevel(index, stFontAndStyles);
  end;
end;

procedure TElStylesDefsItem.SetDataFields(Value: TStringList);
begin
  FDataFields := Value;
end;

procedure TElStylesDefsItem.SetDrawHLine(Value: Boolean);
begin
  if Value <> FDrawHLine then
  begin
    FDrawHLine := Value;
    (Collection as TElStylesDefs).FCustomElDBTree.RebuildStylesOnLevel(index, stFontAndStyles);
  end;
end;

procedure TElStylesDefsItem.SetEnabled(Value: Boolean);
begin
  if Value <> FEnabled then
  begin
    FEnabled := Value;
    (Collection as TElStylesDefs).FCustomElDBTree.RebuildStylesOnLevel(index, stFontAndStyles);
  end;
end;

procedure TElStylesDefsItem.SetForceButtons(Value: Boolean);
begin
  if Value <> FForceButtons then
  begin
    FForceButtons := Value;
    (Collection as TElStylesDefs).FCustomElDBTree.RebuildStylesOnLevel(index, stFontAndStyles);
  end;
end;

procedure TElStylesDefsItem.SetHeight(Value: Integer);
begin
  if Value <> FHeight then
  begin
    FHeight := Value;
    (Collection as TElStylesDefs).FCustomElDBTree.RebuildStylesOnLevel(index, stFontAndStyles);
  end;
end;

procedure TElStylesDefsItem.SetHidden(Value: Boolean);
begin
  if Value <> FHidden then
  begin
    FHidden := Value;
    (Collection as TElStylesDefs).FCustomElDBTree.RebuildStylesOnLevel(index, stFontAndStyles);
  end;
end;

procedure TElStylesDefsItem.SetHint(const Value: string);
begin
  if Value <> FHint then
  begin
    FHint := Value;
    (Collection as TElStylesDefs).FCustomElDBTree.RebuildStylesOnLevel(index, stHint);
  end;
end;

procedure TElStylesDefsItem.SetHintField(const Value: string);
begin
  if Value <> FHintField then
  begin
    FHintField := Value;
    (Collection as TElStylesDefs).FCustomElDBTree.RebuildStylesOnLevel(index, stHint);
  end;
end;

procedure TElStylesDefsItem.SetHintIsHTML(Value: Boolean);
begin
  if Value <> FHintIsHTML then
  begin
    FHintIsHTML := Value;
    (Collection as TElStylesDefs).FCustomElDBTree.RebuildStylesOnLevel(index, stHint);
  end;
end;

procedure TElStylesDefsItem.SetImage(const Value: string);
begin
  if Value <> FImage then
  begin
    FImage := Value;
    (Collection as TElStylesDefs).FCustomElDBTree.RebuildStylesOnLevel(index, stImages);
  end;
end;

procedure TElStylesDefsItem.SetImage2(const Value: string);
begin
  if Value <> FImage2 then
  begin
    FImage2 := Value;
    (Collection as TElStylesDefs).FCustomElDBTree.RebuildStylesOnLevel(index, stImages);
  end;
end;

procedure TElStylesDefsItem.SetImageIndex(Value: Integer);
begin
  if Value <> FImageIndex then
  begin
    FImageIndex := Value;
    (Collection as TElStylesDefs).FCustomElDBTree.RebuildStylesOnLevel(index, stImages);
  end;
end;

procedure TElStylesDefsItem.SetImageIndex2(Value: Integer);
begin
  if Value <> FImageIndex2 then
  begin
    FImageIndex2 := Value;
    (Collection as TElStylesDefs).FCustomElDBTree.RebuildStylesOnLevel(index, stImages);
  end;
end;

procedure TElStylesDefsItem.SetImagesFromBase(Value: Boolean);
begin
  if Value <> FImagesFromBase then
  begin
    FImagesFromBase := Value;
    (Collection as TElStylesDefs).FCustomElDBTree.RebuildStylesOnLevel(index, stImages);
  end;
end;

procedure TElStylesDefsItem.SetIndentAdjust(Value: Integer);
begin
  if Value <> FIndentAdjust then
  begin
    FIndentAdjust := Value;
    (Collection as TElStylesDefs).FCustomElDBTree.RebuildStylesOnLevel(index, stFontAndStyles);
  end;
end;

procedure TElStylesDefsItem.SetIsHTML(Value: Boolean);
begin
  if Value <> FIsHTML then
  begin
    FIsHTML := Value;
    (Collection as TElStylesDefs).FCustomElDBTree.RebuildStylesOnLevel(index, stFontAndStyles);
  end;
end;

procedure TElStylesDefsItem.SetItalic(Value: Boolean);
begin
  if Value <> FItalic then
  begin
    FItalic := Value;
    (Collection as TElStylesDefs).FCustomElDBTree.RebuildStylesOnLevel(index, stFontAndStyles);
  end;
end;

procedure TElStylesDefsItem.SetMultiline(Value: Boolean);
begin
  if Value <> FMultiline then
  begin
    FMultiline := Value;
    (Collection as TElStylesDefs).FCustomElDBTree.RebuildStylesOnLevel(index, stFontAndStyles);
  end;
end;

procedure TElStylesDefsItem.SetOwnerHeight(Value: Boolean);
begin
  if Value <> FOwnerHeight then
  begin
    FOwnerHeight := Value;
    (Collection as TElStylesDefs).FCustomElDBTree.RebuildStylesOnLevel(index, stFontAndStyles);
  end;
end;

procedure TElStylesDefsItem.SetParentColors(Value: Boolean);
begin
  if Value <> FParentColors then
  begin
    FParentColors := Value;
    (Collection as TElStylesDefs).FCustomElDBTree.RebuildStylesOnLevel(index, stFontAndStyles);
  end;
end;

procedure TElStylesDefsItem.SetParentStyle(Value: Boolean);
begin
  if Value <> FParentStyle then
  begin
    FParentStyle := Value;
    (Collection as TElStylesDefs).FCustomElDBTree.RebuildStylesOnLevel(index, stFontAndStyles);
  end;
end;

procedure TElStylesDefsItem.SetPattern(Value: TELFString);
begin
  if Value <> FPattern then
  begin
    FPattern := Value;
    (Collection as TElStylesDefs).FCustomElDBTree.RebuildStylesOnLevel(index, stPattern);
  end;
end;

procedure TElStylesDefsItem.SetRowBkColor(Value: TColor);
begin
  if Value <> FRowBkColor then
  begin
    FRowBkColor := Value;
    (Collection as TElStylesDefs).FCustomElDBTree.RebuildStylesOnLevel(index, stFontAndStyles);
  end;
end;

procedure TElStylesDefsItem.SetShowCaption(Value: Boolean);
begin
  if Value <> FShowCaption then
  begin
    FShowCaption := Value;
  //      (Collection as TElStylesDefs).FCustomElDBTree.RebuildStylesOnLevel(index, stShowCaption);
  end;
end;

procedure TElStylesDefsItem.SetShowCheckBox(Value: Boolean);
begin
  if Value <> FShowCheckBox then
  begin
    FShowCheckBox := Value;
    (Collection as TElStylesDefs).FCustomElDBTree.RebuildStylesOnLevel(index, stCheckBox);
  end;
end;

procedure TElStylesDefsItem.SetStateImageIndex(Value: Integer);
begin
  if Value <> FStImageIndex then
  begin
    FStImageIndex := Value;
    (Collection as TElStylesDefs).FCustomElDBTree.RebuildStylesOnLevel(index, stImages);
  end;
end;

procedure TElStylesDefsItem.SetStateImageIndex2(Value: Integer);
begin
  if Value <> FStImageIndex2 then
  begin
    FStImageIndex2 := Value;
    (Collection as TElStylesDefs).FCustomElDBTree.RebuildStylesOnLevel(index, stImages);
  end;
end;

procedure TElStylesDefsItem.SetStImage(const Value: string);
begin
  if Value <> FStImage then
  begin
    FStImage := Value;
    (Collection as TElStylesDefs).FCustomElDBTree.RebuildStylesOnLevel(index, stImages);
  end;
end;

procedure TElStylesDefsItem.SetStImage2(const Value: string);
begin
  if Value <> FStImage2 then
  begin
    FStImage2 := Value;
    (Collection as TElStylesDefs).FCustomElDBTree.RebuildStylesOnLevel(index, stImages);
  end;
end;

procedure TElStylesDefsItem.SetStrikedLineColor(Value: TColor);
begin
  if Value <> FStrikedLineColor then
  begin
    FStrikedLineColor := Value;
    (Collection as TElStylesDefs).FCustomElDBTree.RebuildStylesOnLevel(index, stFontAndStyles);
  end;
end;

procedure TElStylesDefsItem.SetStrikedOutLine(Value: Boolean);
begin
  if Value <> FStrikedOutLine then
  begin
    FStrikedOutLine := Value;
    (Collection as TElStylesDefs).FCustomElDBTree.RebuildStylesOnLevel(index, stFontAndStyles);
  end;
end;

procedure TElStylesDefsItem.SetStrikeout(Value: Boolean);
begin
  if Value <> FStrikeout then
  begin
    FStrikeout := Value;
    (Collection as TElStylesDefs).FCustomElDBTree.RebuildStylesOnLevel(index, stFontAndStyles);
  end;
end;

procedure TElStylesDefsItem.SetStyleCaption(const Value: string);
begin
  if (csLoading in (Collection as TElStylesDefs).FCustomElDBTree.ComponentState) then
  begin
    FInDesign := false;
    FStyleCaption := value;
  end;
end;

procedure TElStylesDefsItem.SetSuppressButtons(Value: Boolean);
begin
  if Value <> FSuppressButtons then
  begin
    FSuppressButtons := Value;
    (Collection as TElStylesDefs).FCustomElDBTree.RebuildStylesOnLevel(index, stFontAndStyles);
  end;
end;

procedure TElStylesDefsItem.SetSuppressLines(Value: Boolean);
begin
  if Value <> FSuppressLines then
  begin
    FSuppressLines := Value;
    (Collection as TElStylesDefs).FCustomElDBTree.RebuildStylesOnLevel(index, stFontAndStyles);
  end;
end;

procedure TElStylesDefsItem.SetUnderlined(Value: Boolean);
begin
  if Value <> FUnderlined then
  begin
    FUnderlined := Value;
    (Collection as TElStylesDefs).FCustomElDBTree.RebuildStylesOnLevel(index, stFontAndStyles);
  end;
end;

procedure TElStylesDefsItem.SetUseBkColor(Value: Boolean);
begin
  if Value <> FUseBkColor then
  begin
    FUseBkColor := Value;
    (Collection as TElStylesDefs).FCustomElDBTree.RebuildStylesOnLevel(index, stFontAndStyles);
  end;
end;

procedure TElStylesDefsItem.SetUsePattern(Value: Boolean);
begin
  if Value <> FUsePattern then
  begin
    FUsePattern := Value;
    (Collection as TElStylesDefs).FCustomElDBTree.RebuildStylesOnLevel(index, stPattern);
  end;
end;

//  TElStylesDefs

{
******************************** TElStylesDefs *********************************
}
constructor TElStylesDefs.Create(ACustomElDBTree: TCustomElDBTree; ItemClass:
        TCollectionItemClass);
begin
  inherited Create(ItemClass);
  FCustomElDBTree := ACustomElDBTree;
  FCanAppend := False;
end;

function TElStylesDefs.Add: TElStylesDefsItem;
begin
  if FCanAppend then Result := TElStylesDefsItem(inherited Add)
  else
  begin
    ShowMessage(SNoSetInstall);
    Result := nil;
  end;
end;

procedure TElStylesDefs.Delete(Index: Integer);
begin
  inherited;
end;

function TElStylesDefs.GetItem(Index: Integer): TElStylesDefsItem;
begin
  Result := TElStylesDefsItem(inherited GetItem(Index));
end;

function TElStylesDefs.GetOwner: TPersistent;
begin
  Result := FCustomElDBTree;
end;

procedure TElStylesDefs.SetItem(Index: Integer; Value: TElStylesDefsItem);
begin
  inherited SetItem(Index, Value);
end;

//TCustomElDBTree

{
******************************* TCustomElDBTree ********************************
}
constructor TCustomElDBTree.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FMaxLevelCount := 10;
  Items.ItemClass := TElDBTreeItem;
  FDataLink := TElTreeDataLink.Create(Self);
  FChanging := False;
  FStylesDefs := TElStylesDefs.Create(Self, TElStylesDefsItem);
//  ShowCheckBoxes := True;
  FInserting := False;
  FListOfSets := TList.Create;
  FGlobalChange := false;
  FCheckField := False;
  FPrebuildLevelCount := 2;
  FCustomDataEditing := False;
  FNoRebuildOnDataChange := False;
//  QuickEditMode := false;
end;

destructor TCustomElDBTree.Destroy;
var
  i, j: Integer;
  link: TElCustomDataLink;
begin
  Items.Clear;
  FStylesDefs.Free;
  if Assigned(FSource) then
    FSource.UnRegisterLink(FDataLink);
  FDataLink.Free;
  FSource := nil;
  i := FListOfSets.Count - 1;
  for j := 0 to i do
  begin
    link := FListOfSets[0];
    link.DataSource.DataSet := nil;
  //    link.DataSource := nil;
    link.DataSource.Free;
    FListOfSets.Delete(0);
    link.free;
  end;
  FListOfSets.Clear;
  FListOfSets.Free;
  inherited Destroy;
end;

procedure TCustomElDBTree.CheckField(Field: TField);
var
  SetName, RootSetName, FieldName, FieldValue, OldFilter: string;
  i, recno, RelNum: Integer;
  ritem: TElDBTreeItem;
  TextToFind: Variant;
  find: Boolean;
  book: TBookmark;
  FirstIteration, c, OldFiltered: Boolean;
begin
  // check , if this is Query with DenyLookSetPosition=true that exit
  SetName := Field.DataSet.Name;
  RootSetName := DataSource.DataSet.Name;
  if (RootSetName = SetName) and (DataSource.DenyLookSetPosition) then exit;
  if Field.DataSet.RecordCount < 1 then Exit;
  RelNum := -2;
  for i := DataSource.Relations.Count - 1 downto 0 do
  begin
    if (SetName = DataSource.Relations.Items[i].DetailDataSet.Name)
      and (DataSource.Relations.Items[i].Active) then
    begin
      RelNum := i;
      if RelNum = DataSource.Relations[i].ActiveOnLevel then Break;
    end;
  end;
  if (RelNum = -2) or (DataSource.Relations[RelNum].DenyLookSetPosition) then exit
  else
  begin // check may be it is in items?
    if not ((StylesDefs.Items[RelNum + 1].UsePattern) and (StylesDefs.Items[RelNum + 1].Pattern <> '')) then
      TextToFind := Field.DisplayText
    else
      TextToFind := ParsePattern(StylesDefs.Items[RelNum + 1].Pattern, DataSource.Relations[RelNum].DetailDataSet);
    ritem := (Items.LookForItem(nil, TextToFind, nil, -1, false, false, false, false, true) as TElDBTreeItem);
    book := Field.DataSet.GetBookmark;
    while ritem <> nil do
    begin
      if (ritem.FDataLink.dataset.Name = Field.DataSet.Name) and (Field.DataSet.CompareBookmarks(book, ritem.FBookmark) = 0) then
      begin
        Field.DataSet.FreeBookmark(book);
        Exit;
      end;
      ritem := (Items.LookForItem(ritem, TextToFind, nil, -1, false, false, false, false, true) as TElDBTreeItem);
    end;
  end;
  Field.DataSet.FreeBookmark(book);
  c := FChanging;
  FChanging := True;
  recno := Field.DataSet.RecNo;
  if recno = -1 then Field.DataSet.CheckBrowseMode;
  if DataSource.DataSet.Name = Field.DataSet.Name then
  begin
    if DataSource.FFiltered then
    begin
      FChanging := c;
      Exit;
    end;
    if (StylesDefs.Items[0].UsePattern) and (StylesDefs.Items[0].Pattern <> '') then
      TextToFind := ParsePattern(StylesDefs.Items[0].Pattern, DataSource.DataSet)
    else
      TextToFind := DataSource.DataSet.FieldByName(DataSource.RootDataField).asString;

    book := Field.DataSet.GetBookmark;
    ritem := (Items.LookForItem(nil, TextToFind, nil, -1, false, false, false, false, true) as TElDBTreeItem);
    while ritem <> nil do
    begin
      if (Field.DataSet.CompareBookmarks(book, ritem.FBookmark) = 0) then
      begin
        FChanging := c;
        Field.DataSet.FreeBookmark(book);
        exit;
      end;
      ritem := (Items.LookForItem(ritem, TextToFind, nil, -1, false, false, false, false, true) as TElDBTreeItem);
    end;
    Field.DataSet.FreeBookmark(book);
    ritem := CreateNewItemInRoot;
    ProcessItem(ritem, FPrebuildLevelCount-1);
    FChanging := c;
    exit;
  end
  else
  begin
    SetName := Field.DataSet.Name;
    RootSetName := DataSource.DataSet.Name;
    RelNum := -2;
    find := false;
    FirstIteration := true;
    while not find do
    begin
      for i := DataSource.Relations.Count - 1 downto 0 do
      begin
        if (SetName = DataSource.Relations.Items[i].DetailDataSet.Name)
          and (DataSource.Relations.Items[i].Active) then
        begin
          RelNum := i;
          if RelNum = DataSource.Relations[i].ActiveOnLevel then Break;
        end;
      end;
      if RelNum = -2 then
      begin
        FChanging := c;
        exit;
      end;
      if DataSource.Relations[RelNum].MasterDataSet.Name = RootSetName then
      begin
        if FirstIteration then
        begin
          FieldValue := Field.DataSet.FieldByName(DataSource.Relations[RelNum].DetailField).asString;
          if not ((StylesDefs.Items[RelNum + 1].UsePattern) and (StylesDefs.Items[RelNum + 1].Pattern <> '')) then
            TextToFind := DataSource.DataSet.lookup(DataSource.Relations[RelNum].MasterField, FieldValue, DataSource.RootDataField)
          else
          begin
            TextToFind := DataSource.DataSet.locate(DataSource.Relations[RelNum].MasterField, FieldValue, []);
            TextToFind := ParsePattern(StylesDefs.Items[RelNum + 1].Pattern, DataSource.Relations[RelNum].DetailDataSet);
          end;
          FieldName := DataSource.Relations[RelNum].MasterField;
        end
        else
        begin
          if not ((StylesDefs.Items[RelNum + 1].UsePattern) and (StylesDefs.Items[RelNum + 1].Pattern <> '')) then
            TextToFind := DataSource.DataSet.lookup(DataSource.Relations[RelNum].MasterField, FieldValue, DataSource.RootDataField)
          else
          begin
            TextToFind := DataSource.DataSet.locate(DataSource.Relations[RelNum].MasterField, FieldValue, []);
            TextToFind := ParsePattern(StylesDefs.Items[RelNum + 1].Pattern, DataSource.Relations[RelNum].DetailDataSet);
          end;
          FieldName := DataSource.Relations[RelNum].MasterField;
        end;
        find := true;
      end
      else
      begin
        if FirstIteration then
        begin
          FieldValue := Field.DataSet.FieldByName(DataSource.Relations[RelNum].DetailField).asString;
          FieldName := DataSource.Relations[RelNum].MasterField;
          FirstIteration := false;
        end
        else
        begin
          FieldValue := DataSource.Relations[RelNum].DetailDataSet.lookup(FieldName, FieldValue, DataSource.Relations[RelNum].MasterField);
          FieldName := DataSource.Relations[RelNum].MasterField;
        end;
        SetName := DataSource.Relations[RelNum].MasterDataSet.Name;
      end;
    end;
  end;

  if (TextToFind = Null) then
  begin
    FChanging := c;
    exit;
  end;
  try
    DataSource.DataSet.DisableControls;
    OldFiltered := DataSource.DataSet.Filtered;
    OldFilter := DataSource.DataSet.Filter;
    if DataSource.DataSet.FieldByName(FieldName).DataType = ftString then FieldValue := QuotedStr(FieldValue);
    DataSource.DataSet.Filter := FieldName + '=' + FieldValue;
    DataSource.DataSet.Filtered := true;
    DataSource.DataSet.First;

    while not DataSource.DataSet.Eof do
    begin
      if (StylesDefs.Items[0].UsePattern) and (StylesDefs.Items[0].Pattern <> '') then
        TextToFind := ParsePattern(StylesDefs.Items[0].Pattern, DataSource.DataSet)
      else
        TextToFind := DataSource.DataSet.FieldByName(DataSource.RootDataField).asString;

      ritem := (Items.LookForItem(nil, TextToFind, nil, -1, false, false, false, false, true) as TElDBTreeItem);
      if StylesDefs.Items[0].ShowCaption then i := 1
      else i := 0;
      while (ritem <> nil) and (ritem.Level = i) do
      begin
        RebuildItemChilds(ritem);
        ritem := (Items.LookForItem(ritem, TextToFind, nil, -1, false, false, false, false, true) as TElDBTreeItem);
      end;
      DataSource.DataSet.Next;
    end;
    DataSource.DataSet.Filtered := OldFiltered;
    DataSource.DataSet.Filter := OldFilter;
  finally
    DataSource.DataSet.EnableControls;
    FChanging := c;
  end
end;

function TCustomElDBTree.CreateNewItemInRoot: TElDBTReeItem;
var
  Child: TElDBTreeItem;
  MDataField, MMasterField, MDetailField: string;
  MDataSet: TDataSet;
  MDataSource: TDataSource;
  ChangingStatus: Boolean;
  CheckBox: TElCellCheckBox;
begin
  // Root ?
  ChangingStatus := FChanging;
  FChanging := True;
  MDetailField := 'RootLevelField';
  MMasterField := 'RootLevelField';
  MDataSet := FSource.DataSet;
  MDataSource := FSource.GetRootDataSource;
  MDataField := FSource.RootDataField;
  Child := (Items.AddChildObject(nil, MDataSet.FieldByName(MDataField).AsString, nil) as TElDBTreeItem);
  case MDataSet.FieldByName(MDataField).DataType of
    ftBoolean: Child.MainStyle.CellType := sftBool;
    ftString{$IFDEF D_4_UP}, ftWideString{$ENDIF}: Child.MainStyle.CellType := sftText;
    ftMemo, ftFmtMemo: Child.MainStyle.CellType := sftMemo;
    ftSmallint, ftInteger, ftWord, ftAutoInc{$IFDEF D_4_UP}, ftLargeInt{$ENDIF}: Child.MainStyle.CellType := sftNumber;
    ftFloat: Child.MainStyle.CellType := sftFloating;
    ftCurrency: Child.MainStyle.CellType := sftCurrency;
    ftDate: Child.MainStyle.CellType := sftDate;
    ftTime: Child.MainStyle.CellType := sftTime;
    ftDateTime: Child.MainStyle.CellType := sftDateTime;
    ftBlob: Child.MainStyle.CellType := sftBLOB;
    ftGraphic: Child.MainStyle.CellType := sftPicture;
    ftUnknown: Child.MainStyle.CellType := sftCustom;
  else Child.MainStyle.CellType := sftText;
  end;
  Child.DataSource := MDataSource;
  Child.FBookmark := MDataSet.GetBookmark;
  Child.FRecNum := MDataSet.RecNo;
  Child.DataField := MDataField;
  Child.DetailField := MDetailField;
  Child.FRelIndex := 0;
  Child.SetStyle;
  if Child.ImagesFromBase then
  begin
    if Child.ImageIndexField <> '' then
      Child.ImageIndex := MDataSet.FieldByName(Child.ImageIndexField).asInteger;
    if Child.StateImageIndexField <> '' then
      Child.StateImageIndex := MDataSet.FieldByName(Child.StateImageIndexField).asInteger;
    if Child.Image2IndexField <> '' then
      Child.ImageIndex2 := MDataSet.FieldByName(Child.Image2IndexField).asInteger;
    if Child.StateImage2IndexField <> '' then
      Child.StateImageIndex2 := MDataSet.FieldByName(Child.StateImage2IndexField).asInteger;
  end;
  if Child.CheckBoxFromBase then
  begin
    Child.CheckBoxType := ectCheckBox;
    CheckBox := TElCellCheckBox.Create;
    Child.MainStyle.Control := CheckBox;
    if MDataSet.FieldByName(Child.CheckBoxField).asBoolean then Child.CheckBoxState := cbChecked;
    if MDataSet.FieldByName(MDataField).isNull then
    begin
      Child.CheckBoxState := cbGrayed;
    end;
  end;
  FChanging := ChangingStatus;
  Result := Child;
end;

function TCustomElDBTree.CreateView: TElTreeView;
begin
  Result := TElDBTreeView.Create(Self);
end;

procedure TCustomElDBTree.DataSetChanged;
begin
  if not HandleAllocated then Exit;
  if not FChanging and FSource.DataSet.Active and not (csLoading in ComponentState) then RebuildTree(False);
end;

procedure TCustomElDBTree.DefineProperties(Filer: TFiler);
begin
  inherited;
  with GetElReader do
    Filer.DefineProperty('LookAllSetsPosition', FakeBoolean, nil, false);
end;

procedure TCustomElDBTree.DoItemCollapsing(AItem: TElTreeItem; var CanProcess:
        boolean);
begin
  inherited DoItemCollapsing(AItem, CanProcess);
end;

procedure TCustomElDBTree.DoItemExpanding(AItem: TElTreeItem; var CanProcess:
        boolean);
var
  Child, ritem: TElDBTreeItem;
  OldChanging: Boolean;
begin
  if (AItem.Level >= FPrebuildLevelCount - 3) then
  begin
    if (AItem.HasChildren) and (AItem.Level < (MaxLevelCount - 1)) and ((AItem as TElDBTreeItem).DataField <> 'That caption') then
    begin
      OldChanging := FChanging;
      FChanging := True;
      try
        Items.BeginUpdate;
        if AItem <> nil then
        begin
          (AItem as TElDBTreeItem).FDataLink.dataset.CheckBrowseMode;
          if (not (csDesigning in ComponentState)) and Assigned(FOnActivateLevel) then
          begin
            if not (AItem as TElDBTreeItem).FDenyLookSetPosition then
            begin
              try
                (AItem as TElDBTreeItem).FDataLink.dataset.GotoBookmark((AItem as TElDBTreeItem).FBookmark);
              except
                on E: exception do
                begin
                  FChanging := OldChanging;
                  Items.EndUpdate;
                  raise EOnGoToBookmark.CreateFmt(SOnGoToBookmark, [(AItem as TElDBTreeItem).FDataLink.dataset.name]);
                end;
              end;
              FOnActivateLevel(Self, AItem as TElDBTreeItem);
            end;
          end;
        end;
        Child := (AItem.GetFirstChild as TElDBTreeItem);
        if (Child <> nil) and (Child.DataField = 'That caption') then
        begin
          ritem := Child;
          Child := (rItem.GetFirstChild as TElDBTreeItem);
        end
        else ritem := AItem as TelDBTreeItem;
        while (Child <> nil) do
        begin
          if not Child.HasChildren then ProcessItem(Child, 0);
          Child := (rItem.GetNextChild(Child) as TElDBTreeItem);
        end;
      finally
        Items.EndUpdate;
        FChanging := OldChanging;
      end;
    end;
  end;
  inherited DoItemExpanding(AItem, CanProcess);
  if Self.AutoResizeColumns then
    AItem.TreeView.AutoSizeAllColumns;
end;

procedure TCustomElDBTree.EditCanceled;
var
  c, IsPicture: Boolean;
  UserData: Variant;
begin
  if Assigned(Selected) then
  begin
    if Selected.FPattern <> '' then
    begin
      c := FChanging;
      FChanging := True;
      if Selected.FPattern <> '' then
        Selected.text := ParsePattern(Selected.FPattern, Selected.FDataLink.DataSet);
      FChanging := c;
    end;
    if Assigned(FOnItemChanged) then FOnItemChanged(Selected);
  end;
  if FCustomDataEditing then
  begin
    if Assigned(FOnCustomColumnDataNeed) then FOnCustomColumnDataNeed(Self,Selected,FCustomSectionNum - 1,UserData,IsPicture);
    selected.FStaticData.FColText[FCustomSectionNum - 1] := VarToStr(UserData);
    FCustomDataEditing := False;
  end;
end;

function TCustomElDBTree.GetDBDropTarget: TElDBTreeItem;
begin
  Result := TElDBTreeItem(GetDropTarget);
end;

function TCustomElDBTree.GetDBItems: TElDBTreeItems;
begin
  Result := TElDBTreeItems(FItems);
end;

function TCustomElDBTree.GetDBSelected: TElDBTreeItem;
begin
  Result := TElDBTreeItem(GetSelected);
end;

function TCustomElDBTree.GetDBTopItem: TElDBTreeitem;
begin
  Result := TElDBTreeItem(GetTopItem);
end;

function TCustomElDBTree.GetDBTrackItem: TElDBTreeItem;
begin
  Result := TElDBTreeItem(GetTrackItem);
end;

function TCustomElDBTree.GetItemAt(X, Y: Integer; var ItemPart: TSTItemPart;
        var HitColumn: integer): TElDBTreeItem;
begin
  Result := TElDBTreeItem(inherited GetItemAt(X, Y, ItemPart, HitColumn));
end;

function TCustomElDBTree.GetItemAtY(Y: integer): TElDBTreeItem;
begin
  Result := TElDBTreeItem(inherited GetItemAtY(Y));
end;

function TCustomElDBTree.GetItemFocused: TElDBTreeItem;
begin
  Result := TElDBTreeItem(GetFocused);
end;

function TCustomElDBTree.GetNextSelected(Prev: TElTreeItem): TElDBTreeItem;
begin
  Result := TElDBTreeItem(inherited GetNextSelected(Prev));
end;

function TCustomElDBTree.GetNodeAt(X, Y: integer): TElDBTreeItem;
begin
  Result := TElDBTreeItem(inherited GetNodeAt(X, Y));
end;

function TCustomElDBTree.GetSource: TElRelDataSource;
begin
  Result := FSource;
end;

procedure TCustomElDBTree.KeyDownTransfer(Sender : TObject; var Key : Word;
        Shift : TShiftState);
begin
  inherited;
  if Key = VK_DELETE then
  begin
  //// temporary remark
  //        if goEditing then
  //          Items.DeleteItem(ItemFocused);
  //        DoAfterSelectionChange;
  //        Key := 0;
  end;
end;

procedure TCustomElDBTree.MoveToNewParent(FElDBTreeItem: TElDBTreeItem; Field:
        TField);
begin
  FElDBTreeItem.TreeView.FCheckField := True;
  FElDBTreeItem.TreeView.FTablRelName := FElDBTreeItem.FDataLink.DataSet.Name;
  Items.DeleteItem(FElDBTreeItem);
end;

procedure TCustomElDBTree.Notification(AComponent: TComponent; Operation:
        TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = DataSource) and (FSource <> nil) then DataSource := nil;
end;

procedure TCustomElDBTree.OnHeaderSectionChange(Sender: TCustomElHeader;
        Section: TElHeaderSection; Change: TSectionChangeMode);

  procedure SetAlignment(Item : TElTreeItem; i : Integer);
  var
    Child : TElTreeItem;
  begin
    if Assigned(Item) and ((i > 0) and (i <= Item.StylesCount)) then
    begin
      if Self.HeaderSections[i].Alignment = hsaLeft then
        Item.Styles[i - 1].TextFlags := DT_LEFT;
      if Self.HeaderSections[i].Alignment = hsaCenter then
        Item.Styles[i - 1].TextFlags := DT_CENTER;
      if Self.HeaderSections[i].Alignment = hsaRight then
        Item.Styles[i - 1].TextFlags := DT_RIGHT;
    end;
    if Assigned(Item) then
      Child := Item.GetFirstChild
    else
      Child := Self.Items.GetFirstNode;
    while Child <> nil do
    begin
      SetAlignment(Child,i);
      if Assigned(Item) then
        Child := Item.GetNextChild(Child)
      else
        Child := Child.GetNextSibling;
    end;
  end;

begin
  inherited;
  case Change of
    scmAlign, scmStyle:
      if Section.Visible then
      begin
  //
       SetAlignment(nil,Section.Index);
      end;
  end;
end;

procedure TCustomElDBTree.ProcessItem(ACurItem: TElDBTreeItem; FStepCount:
        integer);
var
  Child, ritem, fitem: TElDBTreeItem;
  MDataField, MMasterField, MDetailField, MCaption, MMasterValue: string;
  MDataSet: TDataSet;
  MDataSource: TDataSource;
  MShowCaption: Boolean;
  MPattern: string;
  MUsePattern: Boolean;
  isPicture: Boolean;
  I: Integer;
  OldFiltered: Boolean;
  OldFilter, AppliedFilter: string;
  RelNum: Integer;
  tmp1: string;
  BookmarkD, BookmarkD1: TBookmark;
  ChangingStatus, MDenyLookSetPosition: Boolean;
  CheckBox: TElCellCheckBox;
  CS: TElCellStyle;
  OldState, OldState1: TDataSetState;
  UserData: Variant;
//  W: WideString;
begin
  ChangingStatus := FChanging;
  FChanging := True;
  //  if Assigned(ACurItem) then
  //    OldState := ACurItem.FDataLink.dataset.state;
  //  else
  //     FOnActivateLevel(Self, nil);
  OldState := dsBrowse;
    //OldState1 := dsBrowse;
  MDataSet := nil;
  MDataSource := nil;
  MDetailField := 'RootLevelField';
  MMasterField := 'RootLevelField';
  MCaption := '';
  MShowCaption := False;
  RelNum := -1;
  OldFilter := '';
  OldFiltered := False;
  BookmarkD := nil;
  MDenyLookSetPosition := False;
  MMasterValue := '';
  MUsePattern := False;
  if ACurItem = nil then
  begin
    MDataSet := FSource.DataSet;
    MDataSource := FSource.GetRootDataSource;
    MDataField := FSource.RootDataField;
    MDenyLookSetPosition := FSource.DenyLookSetPosition;
    if MDataSet.Active then
    begin
      BookmarkD := MDataSet.GetBookmark;
      OldFiltered := MDataSet.Filtered;
      OldFilter := MDataSet.Filter;
      OldState := MDataSet.State;
      MCaption := StylesDefs.Items[0].Caption;
      MShowCaption := StylesDefs.Items[0].ShowCaption;
      MPattern := StylesDefs.Items[0].Pattern;
      MUsePattern := StylesDefs.Items[0].UsePattern;
      if OldFiltered and (OldFilter <> '') then AppliedFilter := '(' + OldFilter + ')' + ' AND '
      else AppliedFilter := '';
      if (FSource.Filter <> '') and (FSource.Filtered) then
        MDataSet.Filter := AppliedFilter + ' ( ' + FSource.Filter + ')';
      if OldFiltered or FSource.Filtered then
        MDataSet.Filtered := True;
    end;
  end
  else
  begin
    for i := FSource.Relations.Count - 1 downto 0 do
    begin
      if FSource.Relations.Items[i].MasterDataSet <> nil then
        if (ACurItem.DataSource.DataSet.Name = FSource.Relations.Items[i].MasterDataSet.Name)
          and (FSource.Relations.Items[i].Active) then
        begin
          MDataSet := FSource.Relations.Items[i].DetailDataSet;
          MDataSource := FSource.Relations.Items[i].GetDetailDataSource;
          MDataField := FSource.Relations[i].DetailDisplayField;
          MMasterField := FSource.Relations[i].MasterField;
          MDetailField := FSource.Relations[i].DetailField;
          MDenyLookSetPosition := FSource.Relations[i].DenyLookSetPosition;
          RelNum := i;
          if Assigned(MDataSet) then
            OldState := MDataSet.State
          else
            OldState := dsBrowse;
          MCaption := StylesDefs.Items[i + 1].Caption;
          MShowCaption := StylesDefs.Items[i + 1].ShowCaption;
          MPattern := StylesDefs.Items[i + 1].Pattern;
          MUsePattern := StylesDefs.Items[i + 1].UsePattern;
          if ACurItem.Level + 1 = FSource.Relations[i].ActiveOnLevel then Break;
        end;
    end;
  end;

  if (MDataSet = nil) or (MDataField = '') or (MMasterField = '') or (MDetailField = '') then
  begin
    if OldState = dsEdit then ACurItem.DataSource.DataSet.Edit;
    FChanging := ChangingStatus;
    Exit;
  end;
  if Assigned(ACurItem) then
  begin
    if not ACurItem.Selected then
    begin
      try
        OldState1 := ACurItem.DataSource.DataSet.State;
        ACurItem.DataSource.DataSet.DisableControls;
        ACurItem.DataSource.DataSet.CheckBrowseMode;
        BookmarkD1 := ACurItem.DataSource.DataSet.GetBookmark;
        ACurItem.DataSource.DataSet.GotoBookmark(ACurItem.FBookmark);
      finally
        ACurItem.DataSource.DataSet.EnableControls;
      end;
      tmp1 := ACurItem.DataSource.DataSet.FieldByName(MMasterField).asString;
      MMasterValue := tmp1;
      if Assigned(BookmarkD1) then
      begin
        ACurItem.DataSource.DataSet.GotoBookmark(BookmarkD1);
        ACurItem.DataSource.DataSet.FreeBookmark(BookmarkD1);
      end;
      if OldState1 = dsEdit then
        ACurItem.DataSource.DataSet.Edit;
    end
    else
    begin
      tmp1 := ACurItem.DataSource.DataSet.FieldByName(MMasterField).asString;
      MMasterValue := tmp1;
    end;
    if ACurItem.DataSource.DataSet.FieldByName(MMasterField).DataType = ftString then tmp1 := QuotedStr(tmp1);
    ACurItem.MasterField := MMasterField;
    ACurItem.FMasterValue := MMasterValue;

    if (not (csDesigning in ComponentState)) and Assigned(FOnActivateLevel) then
    begin
      if not ACurItem.FDenyLookSetPosition then
      begin
        try
          ACurItem.FDataLink.dataset.GotoBookmark(ACurItem.FBookmark);
        except
          on E: exception do
          begin
            FChanging := ChangingStatus;
            raise EOnGoToBookmark.CreateFmt(SOnGoToBookmark, [ACurItem.FDataLink.dataset.name]);
          end;
        end;
        if ACurItem.FDataLink.dataset.ControlsDisabled then
        begin
          ACurItem.FDataLink.dataset.EnableControls;
          FOnActivateLevel(Self, ACurItem);
          ACurItem.FDataLink.dataset.DisableControls;
        end
        else
          FOnActivateLevel(Self, ACurItem);
      end;
    end;
  end;
  if (not MDataSet.Active) then
  begin
    if OldState = dsEdit then ACurItem.DataSource.DataSet.Edit;
    FChanging := ChangingStatus;
    Exit;
  end;
  MDataSet.DisableControls;
  if Assigned(ACurItem) then
  begin
    BookmarkD := MDataSet.GetBookmark;
    OldFiltered := MDataSet.Filtered;
    OldFilter := MDataSet.Filter;

    if OldFiltered and (OldFilter <> '') then AppliedFilter := '(' + OldFilter + ') AND '
    else AppliedFilter := '';
    if OldState = dsEdit then ACurItem.DataSource.DataSet.Edit;
    if tmp1 <> '' then
      AppliedFilter := AppliedFilter + ' ( ' + MDetailField + '=' + tmp1 + ' )'
    else
    begin
      ACurItem.MasterField := MMasterField;
      ACurItem.FMasterValue := MMasterValue;
      MDataSet.Filter := OldFilter;
      MDataSet.Filtered := OldFiltered;
      MDataSet.Active := True;
      if Assigned(BookmarkD) then
        MDataSet.GotoBookmark(BookmarkD);
      MDataSet.EnableControls;
      FChanging := ChangingStatus;
      Exit;
    end;
    OldState := MDataSet.State;
    try
      MDataSet.Filter := AppliedFilter;
    except
      on E: EDataBaseError do
      begin
        MDataSet.Filter := OldFilter;
        MDataSet.Filtered := OldFiltered;
        MDataSet.Active := True;
        if Assigned(BookmarkD) then
          MDataSet.GotoBookmark(BookmarkD);
        MDataSet.EnableControls;
        FChanging := ChangingStatus;
        if OldState = dsEdit then MDataset.Edit;
        raise EOnErrorInRelation.CreateFmt(SOnErrorInRelation, [RelNum]);
      end;
    end;
    MDataSet.Filtered := True;
  end;
  MDataSet.First;
  ritem := ACurItem;
  if Assigned(ACurItem) then
  begin
    if MDataSet.Eof then ACurItem.FMarker := True
    else
    begin
      ACurItem.FMarker := False;
      if MShowCaption then
      begin
        Child := (Items.AddChildObject(ACurItem, MCaption, nil) as TElDBTreeItem);
  {$IFDEF ELTREE_USE_STYLES}
        Child.UseStyles := true;
        Child.MainStyle.CellType := sftText;
  {$ENDIF}
        Child.DataField := 'That caption';
        Child.DetailField := 'That caption';
        Child.Expanded := True;
        Child.DataSource := MDataSource;
        Child.FRecNum := -1;
        Child.FDenyLookSetPosition := MDenyLookSetPosition;
        Child.FRelIndex := RelNum + 1;
        Child.SetStyle;
        Child.AllowEdit := False;
        ritem := Child;
      end;
    end;
  end
  else
  begin
    if MShowCaption then
    begin
      Child := (Items.AddChildObject(ACurItem, MCaption, nil) as TElDBTreeItem);
  {$IFDEF ELTREE_USE_STYLES}
      Child.UseStyles := true;
      Child.MainStyle.CellType := sftText;
  {$ENDIF}
      Child.DataField := 'That caption';
      Child.DetailField := 'That caption';
      Child.DataSource := MDataSource;
      Child.FRecNum := -1;
      Child.FDenyLookSetPosition := MDenyLookSetPosition;
      Child.FRelIndex := RelNum + 1;
      Child.SetStyle;
      Child.AllowEdit := False;
      ritem := Child;
    end;
  end;
  while not MDataSet.EOF do
  begin
    if (MUsePattern) and (MPattern <> '') then
    begin
      Child := (Items.AddChildObject(rItem, ParsePattern(Mpattern, MDataSet), nil) as TElDBTreeItem);
      Child.FPattern := MPattern;
    end
    else
    begin
    {$IFDEF D_4_UP}
    {$IFDEF ELPACK_UNICODE}
      if MDataSet.FieldByName(MDataField).DataType in ([ftString, ftWideString]) then
      begin
        Child := (Items.AddChildObject(rItem, GetWideStringText(MDataSet.FieldByName(MDataField)), nil) as TElDBTreeItem)
      end
      else
        Child := (Items.AddChildObject(rItem, MDataSet.FieldByName(MDataField).DisplayText, nil) as TElDBTreeItem);
    {$ELSE}
      Child := (Items.AddChildObject(rItem, MDataSet.FieldByName(MDataField).DisplayText, nil) as TElDBTreeItem);
    {$ENDIF}
    {$ELSE}
      Child := (Items.AddChildObject(rItem, MDataSet.FieldByName(MDataField).DisplayText, nil) as TElDBTreeItem);
    {$ENDIF}
    end;
    {$IFDEF ELTREE_USE_STYLES}
    Child.UseStyles := true;
    case MDataSet.FieldByName(MDataField).DataType of
      ftBoolean: Child.MainStyle.CellType := sftBool;
        //ftString : Child.MainStyle.CellType := sftText;
        {$IFDEF D_4_UP}
      ftString, ftWideString :
            Child.MainStyle.CellType := sftText;
        {$ENDIF}
      ftMemo, ftFmtMemo: Child.MainStyle.CellType := sftMemo;
      ftSmallint, ftInteger, ftWord, ftAutoInc{$IFDEF D_4_UP}, ftLargeInt{$ENDIF}: Child.MainStyle.CellType := sftNumber;
      ftFloat: Child.MainStyle.CellType := sftFloating;
      ftCurrency: Child.MainStyle.CellType := sftCurrency;
      ftDate: Child.MainStyle.CellType := sftDate;
      ftTime: Child.MainStyle.CellType := sftTime;
      ftDateTime: Child.MainStyle.CellType := sftDateTime;
      ftBlob: Child.MainStyle.CellType := sftBLOB;
      ftGraphic: begin
  //                      Child.MainStyle.CellType := sftPicture;
          if MDataSet.FieldByName(MDataField).IsBlob then
          begin
            Child.MainStyle.Style := ElhsPictureOnly;
            Child.MainStyle.Picture := TBitmap.Create;
            Child.MainStyle.Picture.Assign(MDataSet.FieldByName(MDataField));
            Child.OwnerHeight := false;
            Child.Height := Child.MainStyle.Picture.Height;
          end;
        end;
      ftUnknown: Child.MainStyle.CellType := sftCustom;
    else
      Child.MainStyle.CellType := sftText;
    end;
  {$ENDIF}
    Child.DataSource := MDataSource;
    Child.FDenyLookSetPosition := MDenyLookSetPosition;
    Child.FBookmark := MDataSet.GetBookmark;
    Child.FRecNum := MDataSet.RecNo;
    Child.DataField := MDataField;
    Child.FEditingField := MDataField;
    Child.DetailField := MDetailField;
    Child.FRelIndex := RelNum + 1;
    Child.SetStyle;
    if Child.ImagesFromBase then
    begin
      if Child.ImageIndexField <> '' then
        Child.ImageIndex := MDataSet.FieldByName(Child.ImageIndexField).asInteger;
      if Child.StateImageIndexField <> '' then
        Child.StateImageIndex := MDataSet.FieldByName(Child.StateImageIndexField).asInteger;
      if Child.Image2IndexField <> '' then
        Child.ImageIndex2 := MDataSet.FieldByName(Child.Image2IndexField).asInteger;
      if Child.StateImage2IndexField <> '' then
        Child.StateImageIndex2 := MDataSet.FieldByName(Child.StateImage2IndexField).asInteger;
    end;
    if Child.CheckBoxFromBase then
    begin
      Child.CheckBoxType := ectCheckBox;
      CheckBox := TElCellCheckBox.Create;
  {$IFDEF ELTREE_USE_STYLES}
      Child.MainStyle.Control := CheckBox;
  {$ENDIF}
      if MDataSet.FieldByName(Child.CheckBoxField).asBoolean then Child.CheckBoxState := cbChecked;
      if MDataSet.FieldByName(MDataField).isNull then
      begin
        Child.CheckBoxState := cbGrayed;
      end;
    end;

    if MUsePattern then Child.IsHTML := True;

    if Child.HintField <> '' then
      Child.Hint := MDataSet.FieldByName(Child.HintField).DisplayText;

    if StylesDefs[Child.FRelIndex].FDataFields.Count > 0 then
      for i := 0 to (StylesDefs[Child.FRelIndex].FDataFields.Count - 1) do
      begin
        if StylesDefs[Child.FRelIndex].FDataFields[i] <> 'empty column or defined by user' then
        begin
          if MDataSet.FindField(StylesDefs[Child.FRelIndex].FDataFields[i]) <> nil then
          begin
//            Child.FStaticData.FColText.Add(MDataSet.FieldByName(StylesDefs[Child.FRelIndex].FDataFields[i]).DisplayText);
            {$IFDEF D_4_UP}
            {$IFDEF ELPACK_UNICODE}
              if MDataSet.FieldByName(StylesDefs[Child.FRelIndex].FDataFields[i]).DataType in ([ftString, ftWideString]) then
              begin
                Child.FStaticData.FColText.Add(GetWideStringText(MDataSet.FieldByName(StylesDefs[Child.FRelIndex].FDataFields[i])))
              end
              else
                Child.FStaticData.FColText.Add(MDataSet.FieldByName(StylesDefs[Child.FRelIndex].FDataFields[i]).DisplayText);
            {$ELSE}
              Child.FStaticData.FColText.Add(MDataSet.FieldByName(StylesDefs[Child.FRelIndex].FDataFields[i]).DisplayText);
            {$ENDIF}
            {$ELSE}
              Child.FStaticData.FColText.Add(MDataSet.FieldByName(StylesDefs[Child.FRelIndex].FDataFields[i]).DisplayText);
            {$ENDIF}
  {$IFDEF ELTREE_USE_STYLES}
            CS := Child.AddStyle;
            CS.Style := ElhsText;
            if Self.HeaderSections[i+1].Alignment = hsaLeft then
              CS.TextFlags := DT_LEFT;
            if Self.HeaderSections[i+1].Alignment = hsaCenter then
              CS.TextFlags := DT_CENTER;
            if Self.HeaderSections[i+1].Alignment = hsaRight then
              CS.TextFlags := DT_RIGHT;

            case MDataSet.FieldByName(StylesDefs[Child.FRelIndex].FDataFields[i]).DataType of
              ftBoolean: CS.CellType := sftBool;
                //ftString : CS.CellType := sftText;
              {$IFDEF D_4_UP}
              ftString, ftWideString:
                  CS.CellType := sftText;
               {$ENDIF}
              ftMemo, ftFmtMemo: CS.CellType := sftMemo;
              ftSmallint, ftInteger, ftWord, ftAutoInc{$IFDEF D_4_UP}, ftLargeInt{$ENDIF}: CS.CellType := sftNumber;
              ftFloat: CS.CellType := sftFloating;
              ftCurrency: CS.CellType := sftCurrency;
              ftDate: CS.CellType := sftDate;
              ftTime: CS.CellType := sftTime;
              ftDateTime: CS.CellType := sftDateTime;
              ftBlob: CS.CellType := sftBLOB;
              ftGraphic: begin
                  CS.CellType := sftPicture;
                  if MDataSet.FieldByName(StylesDefs[Child.FRelIndex].FDataFields[i]).IsBlob then
                  begin
                    CS.Style := ElhsPictureOnly;
                    CS.Picture := TBitmap.Create;
                    CS.Picture.Assign(MDataSet.FieldByName(StylesDefs[Child.FRelIndex].FDataFields[i]));
                    Child.OwnerHeight := false;
                    Child.Height := CS.Picture.Height;
                  end;
                end;
              ftUnknown: CS.CellType := sftCustom;
            else
              CS.CellType := sftText;
            end;
  {$ENDIF}
          end
          else
          begin
            Child.FStaticData.FColText.Add(' field not found ');
             {$IFDEF ELTREE_USE_STYLES}
            CS := Child.AddStyle;
            CS.CellType := sftText;
            if Self.HeaderSections[i+1].Alignment = hsaLeft then
              CS.TextFlags := DT_LEFT;
            if Self.HeaderSections[i+1].Alignment = hsaCenter then
              CS.TextFlags := DT_CENTER;
            if Self.HeaderSections[i+1].Alignment = hsaRight then
              CS.TextFlags := DT_RIGHT;
            Self.HeaderSections[i+1].Editable := False;
             {$ENDIF}
          end;
        end
        else
        begin
  //OnCustomColumnDataNeed
          if Assigned(FOnCustomColumnDataNeed) then
          begin
          fitem := TElDBTreeItem.Create(Self);
          fitem.Assign(Child);
          try
            IsPicture := False;
            FOnCustomColumnDataNeed(Self,fitem,i+1,UserData, IsPicture);
            if not ((VarIsEmpty(UserData)) or (VarIsNull(UserData))) then
            begin
              Child.FStaticData.FColText.Add(VarToStr(UserData));
    {$IFDEF ELTREE_USE_STYLES}
              CS := Child.AddStyle;
              CS.Style := ElhsText;
              if Self.HeaderSections[i+1].Alignment = hsaLeft then
                CS.TextFlags := DT_LEFT;
              if Self.HeaderSections[i+1].Alignment = hsaCenter then
                CS.TextFlags := DT_CENTER;
              if Self.HeaderSections[i+1].Alignment = hsaRight then
                CS.TextFlags := DT_RIGHT;
              case VarType(UserData) of
                varBoolean: CS.CellType := sftBool;
                varString{$IFDEF VCL_4_USED}, varOleStr{$ENDIF}: CS.CellType := sftText;
                varSmallint {$ifdef VCL_6_USED}, varShortInt, varWord, varLongWord{$endif} : CS.CellType := sftNumber;
                varSingle, varDouble: CS.CellType := sftFloating;
                varCurrency: CS.CellType := sftCurrency;
                varDate: CS.CellType := sftDate;
                varInteger: begin
                    if IsPicture then
                    begin
                      CS.CellType := sftPicture;
                      CS.Style := ElhsPictureOnly;
                      CS.Picture := TBitmap.Create;
                      CS.Picture.Assign(TBitmap(Integer(UserData)));
                      Child.OwnerHeight := false;
                      Child.Height := CS.Picture.Height;
                    end
                    else
                    CS.CellType := sftNumber;
                  end;
                varUnknown: CS.CellType := sftCustom;
    {$ENDIF}
              else
              begin
                Child.FStaticData.FColText.Add(' ');
                 {$IFDEF ELTREE_USE_STYLES}
                CS := Child.AddStyle;
                CS.CellType := sftText;
                Self.HeaderSections[i+1].Editable := False;
                 {$ENDIF}
              end;
              end;
            end
            else
            begin
              Child.FStaticData.FColText.Add(' ');
               {$IFDEF ELTREE_USE_STYLES}
              CS := Child.AddStyle;
              CS.CellType := sftText;
              Self.HeaderSections[i+1].Editable := False;
               {$ENDIF}
            end;
          finally
            fitem.Free;
          end;
          end
          else
          begin
            Child.FStaticData.FColText.Add(' ');
  {$IFDEF ELTREE_USE_STYLES}
            CS := Child.AddStyle;
            CS.CellType := sftText;
  {$ENDIF}
          end;
        end;
      end;
    if Assigned(FOnItemCreated) then FOnItemCreated(Child);
    MDataSet.Next;
  end;

  MDataSet.Filter := OldFilter;
  MDataSet.Filtered := OldFiltered;
  if Assigned(BookmarkD) then
    if MDAtaSet.BookmarkValid(BookmarkD) then
      MDataSet.GotoBookmark(BookmarkD);
  if OldState = dsEdit then MDataset.Edit;
  MDataSet.EnableControls;
  if rItem = nil then Child := Items.GetFirstNode else Child := rItem.GetFirstChild;
  while (Child <> nil) and ((FStepCount > 0) or (Child.Expanded)) and (Child.Level < FMaxLevelCount - 1) do
  begin
    if Child.Expanded then
    begin
      if FStepCount > 0 then
        ProcessItem(Child, FStepCount - 1)
      else
        ProcessItem(Child, 0);
    end
    else
      ProcessItem(Child, FStepCount - 1);
    if rItem = nil then Child := Child.GetNextSibling else Child := rItem.GetNextChild(Child);
  end;
  FChanging := ChangingStatus;
end;

procedure TCustomElDBTree.RebuildItemChilds(AElDBTreeItem: TElDBTreeItem);
var
  Child, ritem: TElDBTreeItem;
  OldChanging: Boolean;
  pri: Boolean;
begin
  if AElDBTreeItem = nil then
  begin
    RebuildTree(false);
    Exit;
  end;
  OldChanging := FChanging;
  FChanging := True;
  try
    Items.BeginUpdate;
    if not AElDBTreeItem.FDenyLookSetPosition then
    begin
      pri := AElDBTreeItem.Expanded;
      AElDBTreeItem.DeleteChild;
      if AElDBTreeItem.Level < FPrebuildLevelCount then
        ProcessItem(AElDBTreeItem, (FPrebuildLevelCount - AElDBTreeItem.Level - 2))
      else
        ProcessItem(AElDBTreeItem, 0);
      if pri and (AElDBTreeItem.ChildrenCount > 0) then
      begin
        AElDBTreeItem.Expand(false);
        Child := AElDBTreeItem.GetFirstChild;
        if Child.DataField = 'That caption' then Child.Expand(false);
      end;
    end
    else
    begin
      Child := AElDBTreeItem.GetFirstChild;
      while (Child <> nil) do
      begin
        Child.Collapse(True);
        Child := AElDBTreeItem.GetNextChild(Child);
      end;
    end;
    if AElDbTreeItem.Expanded then
    begin
      Child := AElDbTreeItem.GetFirstChild;
      ritem := AElDbTreeItem;
      if (Child <> nil) and (Child.DataField = 'That caption') then ritem := Child;
      Child := rItem.GetFirstChild;
      while (Child <> nil) do
      begin
        pri := Child.Expanded;
        RebuildItemChilds(Child);
        if pri then Child.Expand(false);
        Child := rItem.GetNextChild(Child);
      end;
    end;
  finally
    FChanging := OldChanging;
    Items.EndUpdate;
  end;
end;

procedure TCustomElDBTree.RebuildStylesOnLevel(StyleNum: integer; code:
        TUpdateStylesType);
var
  OldChanging: Boolean;
  book: TBookmark;

  procedure CheckFrom(ACurItem: TELDBTreeItem; StyleNum: integer; code: TUpdateStylesType);
  var Child, ritem: TElDBTreeItem;
  begin
    ritem := ACurItem;
    if ACurItem = nil then Child := Items.GetFirstNode else Child := ACurItem.GetFirstChild;
    while (Child <> nil) do
    begin
      if (Child.FRelIndex = StyleNum) then
      begin
        case code of
          stShowCaption:
            begin
              RebuildItemChilds(Child.Parent);
              Exit;
            end;
          stPattern:
            begin
              if (Child.DataField = 'That caption') then ritem := Child;
              if (Child.FRelIndex = StyleNum) and (Child.DataField <> 'That caption') then
              begin
                Child.FDataLink.DataSet.GotoBookmark(Child.FBookmark);
                if (StylesDefs[StyleNum].UsePattern) and (StylesDefs[StyleNum].Pattern <> '') then
                begin
                  Child.FPattern := StylesDefs[StyleNum].Pattern;
                  Child.Text := ParsePattern(Child.FPattern, Child.FDataLink.DataSet);
                  Child.IsHTML := True;
                end
                else
                begin
                  Child.FPattern := '';
                  Child.Text := Child.FDataLink.DataSet.FieldByName(Child.FDataField).asString;
                  Child.IsHTML := StylesDefs[StyleNum].isHTML;
                end;
              end;
            end;
          stFontAndStyles:
            begin
              Child.SetStyle;
              if StylesDefs[StyleNum].UsePattern then Child.IsHTML := True;
            end;
          stHint:
            begin
              Child.HintIsHTML := StylesDefs[StyleNum].HintIsHTML;
              if StylesDefs[StyleNum].HintField <> '' then
              begin
                Child.HintField := StylesDefs[StyleNum].HintField;
                Child.FDataLink.DataSet.GotoBookmark(Child.FBookmark);
                Child.Hint := Child.FDataLink.DataSet.FieldByName(Child.HintField).AsString;
              end
              else
                Child.Hint := StylesDefs[StyleNum].Hint;
              if StylesDefs[StyleNum].UsePattern then Child.IsHTML := True;
            end;
          stCheckBox:
            begin
              Child.FDataLink.DataSet.GotoBookmark(Child.FBookmark);
              if StylesDefs[StyleNum].CheckBox <> '' then
              begin
                Child.CheckBoxFromBase := True;
                Child.CheckBoxEnabled := StylesDefs[StyleNum].CheckBoxEnabled;
                Child.ShowCheckBox := StylesDefs[StyleNum].ShowCheckBox;
              end
              else
              begin
                Child.CheckBoxFromBase := False;
                Child.CheckBoxEnabled := False;
                Child.ShowCheckBox := False;
              end;
              Child.CheckBoxField := StylesDefs[StyleNum].CheckBox;
              if Child.CheckBoxFromBase then
              begin
                Child.CheckBoxType := ectCheckBox;
  {$IFDEF ELTREE_USE_STYLES}
                Child.MainStyle.Control := TElCellCheckBox.Create;
  {$ENDIF}
                if Child.FDataLink.DataSet.FieldByName(Child.CheckBoxField).asBoolean then Child.CheckBoxState := cbChecked;
                if Child.FDataLink.DataSet.FieldByName(Child.CheckBoxField).isNull then
                begin
                  Child.CheckBoxState := cbGrayed;
                end;
              end;
            end;
          stImages:
            begin
              Child.FDataLink.DataSet.GotoBookmark(Child.FBookmark);
              if not StylesDefs[StyleNum].ImagesFromBase then
              begin
                Child.ImagesFromBase := False;
                Child.ImageIndex := StylesDefs[StyleNum].ImageIndex;
                Child.StateImageIndex := StylesDefs[StyleNum].StateImageIndex;
                Child.ImageIndex2 := StylesDefs[StyleNum].ImageIndex2;
                Child.StateImageIndex2 := StylesDefs[StyleNum].StateImageIndex2;
              end
              else
              begin
                Child.ImagesFromBase := True;
                Child.ImageIndexField := StylesDefs[StyleNum].Image;
                Child.StateImageIndexField := StylesDefs[StyleNum].StImage;
                Child.Image2IndexField := StylesDefs[StyleNum].Image2;
                Child.StateImage2IndexField := StylesDefs[StyleNum].StImage2;
              end;
              if Child.ImagesFromBase then
              begin
                if Child.ImageIndexField <> '' then
                  Child.ImageIndex := Child.FDataLink.DataSet.FieldByName(Child.ImageIndexField).asInteger;
                if Child.StateImageIndexField <> '' then
                  Child.StateImageIndex := Child.FDataLink.DataSet.FieldByName(Child.StateImageIndexField).asInteger;
                if Child.Image2IndexField <> '' then
                  Child.ImageIndex2 := Child.FDataLink.DataSet.FieldByName(Child.Image2IndexField).asInteger;
                if Child.StateImage2IndexField <> '' then
                  Child.StateImageIndex2 := Child.FDataLink.DataSet.FieldByName(Child.StateImage2IndexField).asInteger;
              end;
            end;
          stCaption:
            begin
              if (Child.DataField = 'That caption') then Child.Text := StylesDefs[StyleNum].Caption;
            end;
        end;
      end;
      CheckFrom(Child, StyleNum, code);
      if rItem = nil then Child := Child.GetNextSibling else Child := rItem.GetNextChild(Child);
    end;
  end;

begin
  if ((csLoading in ComponentState) or ((csDesigning in ComponentState))) then Exit;
  Items.BeginUpdate;
  OldChanging := FChanging;
  FChanging := True;
  StylesDefs[StyleNum].FDataLink.DataSet.DisableControls;
  book := StylesDefs[StyleNum].FDataLink.DataSet.GetBookmark;
  try
    CheckFrom(nil, StyleNum, code)
  finally
    StylesDefs[StyleNum].FDataLink.DataSet.GotoBookmark(book);
    StylesDefs[StyleNum].FDataLink.DataSet.FreeBookmark(book);
    StylesDefs[StyleNum].FDataLink.DataSet.EnableControls;
    FChanging := OldChanging;
    Items.EndUpdate;
  end;
end;

procedure TCustomElDBTree.RebuildTableRelationsLevels(AName: TTableName);
var
  OldChanging: Boolean;
  ritem: TELDBTreeItem;

  procedure CheckAndBuildChild(ACurItem: TELDBTreeItem);
  var
    child, ritem: TElDBTreeItem;
    b : Boolean;
  begin
    ritem := ACurItem.GetFirstChild;
    if Assigned(ritem) then
    begin
      if (ritem.DataField <> 'That caption') then ritem := ACurItem;
      Child := rItem.GetFirstChild;
      while (Child <> nil) do
      begin
        if ACurItem.Expanded and (ACurItem.Level >= (FPrebuildlevelCount-2)) then
        begin
          b := child.Expanded;
          ProcessItem(Child, 0);
          CheckAndBuildChild(Child);
          if b then
            child.Expand(false);
        end;
        Child := rItem.GetNextChild(Child);
      end;
    end;
  end;
  procedure CheckFrom(ACurItem: TELDBTreeItem; AName: TTableName);
  var
    Child: TElDBTreeItem;
    b : Boolean;
  begin
    if (ACurItem = nil) or ((ACurItem.Level = 0) and (ACurItem.DataField = 'That caption')) then
    begin
      Child := Items.GetFirstNode;
      if not Assigned(Child) then exit;
      if Child.FDataLink.DataSet.Name = AName then
      begin
        RebuildTree(true);
        exit;
      end;
    end;
    if (ACurItem <> nil) and (ACurItem.HasChildren) and (ACurItem.DataField <> 'That caption') then
      if (ACurItem.GetFirstChild <> nil) and (ACurItem.GetFirstChild.FDataLink.DataSet.Name = AName) then
      begin
        b := ACurItem.Expanded;
        ACurItem.DeleteChild;
        if ACurItem.Level < FPrebuildLevelCount then
          ProcessItem(ACurItem, FPrebuildLevelCount - ACurItem.Level - 2)
        else
          ProcessItem(ACurItem, 0);
        if (ACurItem.HasChildren) then
          CheckAndBuildChild(ACurItem);
        if b then
          ACurItem.Expand(False);
        exit;
      end;
    if (ACurItem <> nil) and (ACurItem.DataField <> 'That caption') and (ACurItem.FMarker) then
    begin
        b := ACurItem.Expanded;
        if ACurItem.Level < FPrebuildLevelCount then
          ProcessItem(ACurItem, FPrebuildLevelCount - ACurItem.Level - 2)
        else
          ProcessItem(ACurItem, 0);
      if (ACurItem.HasChildren) then CheckAndBuildChild(ACurItem);
      if b then
        ACurItem.Expand(False);
      exit;
    end;
    if ACurItem = nil then Child := Items.GetFirstNode else Child := ACurItem.GetFirstChild;
    while (Child <> nil) do
    begin
      CheckFrom(Child, AName);
      if ACurItem = nil then Child := Child.GetNextSibling else Child := ACurItem.GetNextChild(Child);
    end;
  end;

begin
  Items.BeginUpdate;
  OldChanging := FChanging;
  FChanging := True;
  try
    ritem := Items.GetFirstNode;
    if Assigned(ritem) then
    begin
      if ritem.DataField <> 'That caption' then
        CheckFrom(nil, AName)
      else CheckFrom(ritem, AName);
    end
    else
      RebuildTree(true);
  finally
    FChanging := OldChanging;
    if Assigned(Selected) then TriggerItemSelectedChangeEvent(Selected);
    Items.EndUpdate;
  end;
end;

procedure TCustomElDBTree.RebuildTree(KeepCurrentID: Boolean);
var
  CurItemIndex, CurLevel: Integer;
  oldchanging: Boolean;
  ritem: TElDBTreeItem;
begin
  if not (Assigned(FSource) and Assigned(FSource.DataSet) and (FSource.DataSet.Active)) then
    begin
      Items.BeginUpdate;
      Items.Clear;
      Items.EndUpdate;
      Exit;
    end;
  oldchanging := FChanging;
  FChanging := True;
  CurItemIndex := -1;
  CurLevel := FPrebuildLevelCount - 1;
  if KeepCurrentID then
    if Selected <> nil then
    begin
      CurItemIndex := Selected.AbsoluteIndex;
      if Selected.Level >= FPrebuildLevelCount-1 then
        CurLevel := Selected.Level + 1;
    end;
  if (csDesigning in ComponentState) then
    CurLevel := 1;
  Items.BeginUpdate;
  Items.Clear;
  if FSource.DataSet.Active then
  try
    FSource.FRootDataSource.DataSet.DisableCOntrols;
    ProcessItem(nil, CurLevel);
    ritem := items.GetFirstNode;
    if (Assigned(ritem)) and (ritem.DataField = 'That caption') then ritem.Expand(False);
  finally
    if (KeepCurrentID) and (CurItemIndex <> -1) then
    begin
      Selected := Items[CurItemIndex];
      if Assigned(Selected) then
        ritem := Selected.Parent
      else
        ritem := nil;
      while Assigned(ritem) do
      begin
        ritem.Expand(False);
        ritem := ritem.Parent;
      end;
    end;
    Items.EndUpdate;
    if Assigned(FOnAfterRebuildTree) then FOnAfterRebuildTree(Self);
    FChanging := oldchanging;
    FSource.FRootDataSource.DataSet.EnableControls;
  end
  else
  begin
    Items.EndUpdate;
    if Assigned(FOnAfterRebuildTree) then FOnAfterRebuildTree(Self);
    if Assigned(selected) then TriggerItemSelectedChangeEvent(selected);
    FChanging := oldchanging;
  end;
end;

procedure TCustomElDBTree.SetDBSelected(const Value: TElDBTreeItem);
begin
  SetSelected(Value);
end;

procedure TCustomElDBTree.SetDBTopItem(const Value: TElDBTreeitem);
begin
  SetTopItem(Value);
end;

procedure TCustomElDBTree.SetItemFocused(Value: TElDBTreeItem);
begin
  if Value <> nil then
    DoSetFocused(Value, True);
  //    Value.SetSelected(true);
end;

procedure TCustomElDBTree.SetPrebuildLevelCount(const Value: Integer);
begin
  if FPrebuildLevelCount <> Value then
  begin
    if Value < 2 then
      ShowMessage(SErrorPrebuildLevel)
    else
      FPrebuildLevelCount := Value;
  end;
end;

procedure TCustomElDBTree.SetSource(Source: TElRelDataSource);
var
  i, j: Integer;
  item: TElStylesDefsItem;
  link: TElCustomDataLink;
begin
  if Source = FSource then Exit;
  i := FListOfSets.Count - 1;
  if i >= 0 then
    for j := 0 to i do
    begin
      link := FListOfSets[0];
      link.DataSource.DataSet := nil;
  //      link.DataSource := nil;
      link.DataSource.Free;
      FListOfSets.Delete(0);
      link.free;
    end;
  if (not (csLoading in ComponentState)) and ((Source <> nil) and (not (csLoading in Source.ComponentState))) then
  begin
    FStylesDefs.FCanAppend := True;
    FStylesDefs.Clear;
    for i := 0 to Source.Relations.Count do
    begin
      item := FStylesDefs.Add;
      if i = 0 then
      begin
        item.FStyleCaption := 'Rootlevel';
        item.FDataLink.DataSource := Source.GetRootDataSource;
        item.FDataField := Source.RootDataField;
        item.FInDesign := false;
        if (Source.DataSet <> nil) then
        begin
          link := TElCustomDataLink.Create;
          link.FTree := Self;
          link.DataSource := TDataSource.Create(Self);
          link.DataSource.Name := Name + '7t36g78ljRoot';
          link.DataSource.DataSet := Source.DataSet;
          link.FOldFilter := Source.DataSet.Filter;
          link.FOldFiltered := Source.DataSet.Filtered;
          if Source.DataSet.Active then link.FRecCount := Source.DataSet.RecordCount;
          FListOfSets.Add(link);
        end;
      end
      else
      begin
        if (Source.Relations[i - 1].DetailDataSet <> nil) and (Source.Relations[i - 1].MasterDataSet <> nil) then
        begin
          item.FStyleCaption := 'Relation ' + IntToStr(i - 1) + ' level : ' + Source.Relations[i - 1].MasterDataSet.Name + '-' + Source.Relations[i - 1].DetailDataSet.Name;
          item.FInDesign := false;
        end
        else
        begin
          item.FStyleCaption := 'Relation ' + IntToStr(i - 1);
          item.FInDesign := true;
        end;
        item.FDataLink.DataSource := Source.Relations[i - 1].GetDetailDataSource;
        item.FDataField := Source.Relations[i - 1].DetailDisplayField;
        if Source.Relations[i - 1].DetailDataSet <> nil then
        begin
          j := 0;
          if FListOfSets.Count > 0 then
          begin
            link := FListOfSets.Items[j];
            while (j < FListOfSets.Count) and (link.DataSet.Name <> Source.Relations[i - 1].GetDetailDataSource.DataSet.Name) do
            begin
              j := j + 1;
              if j < FListOfSets.Count - 1 then
                link := FListOfSets.Items[j];
            end;
            if (j = FListOfSets.Count) then
            begin
              link := TElCustomDataLink.Create;
              link.FTree := Self;
              link.DataSource := TDataSource.Create(Self);
              link.DataSource.Name := Name + '7t36g78ljRel' + IntToStr(i - 1);
              link.DataSource.DataSet := Source.Relations[i - 1].DetailDataSet;
              link.FOldFilter := Source.Relations[i - 1].DetailDataSet.Filter;
              link.FOldFiltered := Source.Relations[i - 1].DetailDataSet.Filtered;
              if Source.Relations[i - 1].DetailDataSet.Active then link.FRecCount := Source.Relations[i - 1].DetailDataSet.RecordCount;
              FListOfSets.Add(link);
            end;
          end;
        end;
      end;
    end;
    FStylesDefs.FCanAppend := False;
  end
  else
  begin
    if (Source <> nil) then
    begin
      if Source.Relations.Count + 1 > FStylesDefs.Count then
      begin
        FStylesDefs.FCanAppend := True;
        for i := FStylesDefs.Count to Source.Relations.Count do FStylesDefs.Add;
        FStylesDefs.FCanAppend := False;
      end;
      for i := 0 to Source.Relations.Count do
      begin
        if i = 0 then
        begin
          FStylesDefs[i].FDataLink.DataSource := Source.GetRootDataSource;
          FStylesDefs[i].FDataField := Source.RootDataField;
          FStylesDefs[i].FInDesign := false;
          if Source.DataSet <> nil then
          begin
            link := TElCustomDataLink.Create;
            link.FTree := Self;
            Link.DataSource := TDataSource.Create(Self);
            link.DataSource.Name := Name + '7t36g78ljRoot';
            link.DataSource.DataSet := Source.GetRootDataSet;
            link.FOldFilter := Source.GetRootDataSet.Filter;
            link.FOldFiltered := Source.GetRootDataSet.Filtered;
            if Source.DataSet.Active then link.FRecCount := Source.DataSet.RecordCount;
            FListOfSets.Add(link);
         end;
        end
        else
        begin
          FStylesDefs[i].FDataLink.DataSource := Source.Relations[i - 1].GetDetailDataSource;
          FStylesDefs[i].FDataField := Source.Relations[i - 1].DetailDisplayField;
          if Source.Relations[i - 1].DetailDataSet <> nil then
          begin
            j := 0;
            if FListOfSets.Count > 0 then
            begin
              link := FListOfSets.Items[j];
              while (j < FListOfSets.Count) and (link.DataSet.Name <> Source.Relations[i - 1].DetailDataSet.Name) do
              begin
                j := j + 1;
                if j < FListOfSets.Count - 1 then
                  link := FListOfSets.Items[j];
              end;
              if (j = FListOfSets.Count) then
              begin
                link := TElCustomDataLink.Create;
                link.FTree := Self;
                Link.DataSource := TDataSource.Create(Self);
                link.DataSource.Name := Name + '7t36g78ljRel' + IntToStr(i - 1);
                link.DataSource.DataSet := Source.Relations[i - 1].GetDetailDataSource.DataSet;
                link.FOldFilter := Source.Relations[i - 1].GetDetailDataSource.DataSet.Filter;
                link.FOldFiltered := Source.Relations[i - 1].GetDetailDataSource.DataSet.Filtered;
                if Source.Relations[i - 1].DetailDataSet <> nil then
                  if Source.Relations[i - 1].DetailDataSet.Active then link.FRecCount := Source.Relations[i - 1].DetailDataSet.RecordCount;
                FListOfSets.Add(link);
              end;
            end;
          end;
        end;
      end;
    end
    else FStylesDefs.Clear;
  end;
  if FSource <> nil then FSource.UnRegisterLink(FDataLink);
  if Source <> nil then Source.RegisterLink(FDataLink);
  FSource := Source;
  Items.Clear;
  if Source <> nil then
  begin
    Source.GetRootDataSource.FreeNotification(Self);
    RebuildTree(false);
  end;
end;

procedure TCustomElDBTree.SetStylesDefs(Value: TElStylesDefs);
begin
  FStylesDefs.Assign(Value);
end;

procedure TCustomElDBTree.TriggerInplaceEditorNeeded(Item: TElTreeItem;
        SectionIndex: Integer; SupposedFieldType: TElFieldType; var Editor:
        TElTreeInplaceEditor);
var
  i: Integer;
begin
   if (HeaderSections.Count > 1) then
     if SectionIndex > 0 then
     begin
       if (StylesDefs.Items[(Item as TElDBTreeItem).FRelIndex].FDataFields.Count > 0) then
         if (StylesDefs.Items[(Item as TElDBTreeItem).FRelIndex].DataFields.Strings[SectionIndex - 1] <> 'empty column or defined by user') then
           (Item as TElDBTreeItem).FEditingField := StylesDefs.Items[(Item as TElDBTreeItem).FRelIndex].DataFields.Strings[SectionIndex - 1]
         else
         begin
             Editor := nil;
             with THackElTreeInplaceManager(Self.FEditorManager) do
             begin
               for i := 0 to FEditorsList.Count - 1 do
               begin
                 Editor := TElTreeInplaceEditor(FEditorsList[i]);
                 if (SupposedFieldType in Editor.Types) and (not (Editor is TElDBTreeInplaceEditor)) then
                   break
                 else
                   Editor := nil
               end;
             end;
           if Assigned(Editor) then
           begin
             FCustomDataEditing := True;
             FCustomSectionNum := SectionIndex;
           end;
           if Assigned(OnInplaceEditorNeeded) then
             OnInplaceEditorNeeded(Self, Item, SectionIndex, SupposedFieldType, Editor);
           exit;
         end
       else
       begin
         if Assigned(OnInplaceEditorNeeded) then
           OnInplaceEditorNeeded(Self, Item, SectionIndex, SupposedFieldType, Editor);
         Abort;
       end;
     end
     else (Item as TElDBTreeItem).FEditingField := (Item as TElDBTreeItem).FDataField;
   Editor := nil;
   with THackElTreeInplaceManager(Self.FEditorManager) do
   begin
     for i := 0 to FEditorsList.Count - 1 do
     begin
       Editor := TElTreeInplaceEditor(FEditorsList[i]);
       if (SupposedFieldType in Editor.Types) and (Editor is TElDBTreeInplaceEditor) then
         break
       else
         Editor := nil
     end;
   end;
  if Assigned(OnInplaceEditorNeeded) then
    OnInplaceEditorNeeded(Self, Item, SectionIndex, SupposedFieldType, Editor);
end;

procedure TCustomElDBTree.TriggerItemSelectedChangeEvent(AItem: TElTreeItem);
var
  AParent: TElTreeItem;
  OldChanging: Boolean;
  list: TList;
  s: string;
begin
  inherited TriggerItemSelectedChangeEvent(AItem);
  if (AItem as TElDBTreeItem).DataField = 'That caption' then Exit;
  if (not (csDestroying in ComponentState)) and (not FChanging) then
  begin
    OldChanging := FChanging;
    FChanging := True;
    if (not (AItem as TELDBTreeItem).FDenyLookSetPosition) and ((AItem as TELDBTreeItem).FBookmark <> nil) and ((AItem as TELDBTreeItem).DataSource.DataSet.Active) then
    begin
      try
        (AItem as TElDBTreeItem).DataSource.DataSet.GotoBookmark((AItem as TElDBTreeItem).FBookmark);
      except
        on E: exception do
        begin
          FChanging := OldChanging;
          raise EOnGoToBookmark.CreateFmt(SOnGoToBookmark, [(AItem as TElDBTreeItem).DataSource.DataSet.name]);
        end;
      end;
    end;
      list := TList.Create;
      s := (AItem as TElDBTreeItem).DataSource.DataSet.Name;
      List.Add(pointer(s));
      AParent := AItem.Parent;
      if (AParent <> nil) and ((AParent as TElDBTreeItem).DataField = 'That caption') then AParent := AParent.Parent;
      while AParent <> nil do
      begin
        s := (AParent as TELDBTreeItem).DataSource.DataSet.Name;
        if List.IndexOf(pointer(s)) = -1 then
        begin
          List.Add(pointer(s));
          if (not (AParent as TELDBTreeItem).FDenyLookSetPosition) and ((AParent as TELDBTreeItem).FBookmark <> nil) and ((AParent as TELDBTreeItem).DataSource.DataSet.Active) then
          begin
            try
              (AParent as TElDBTreeItem).DataSource.DataSet.GotoBookmark((AParent as TElDBTreeItem).FBookmark);
            except
              on E: exception do
              begin
                list.free;
                FChanging := OldChanging;
                raise EOnGoToBookmark.CreateFmt(SOnGoToBookmark, [(AParent as TElDBTreeItem).DataSource.dataset.name]);
              end;
            end;
          end;
        end;
        AParent := AParent.Parent as TELDBTreeItem
      end;
      list.free;
    FChanging := OldChanging;
  end;
end;

procedure TCustomElDBTree.TriggerLinkClickEvent(HRef: string; X, Y: integer);
var
  MItem: TelDBTreeItem;
begin
  MItem := Self.GetItemAtY(Y);
  if Assigned(MItem) then
  begin
    MItem.FEditingField := Href;
  {$IFDEF ELTREE_USE_STYLES}
    if MItem.DataSource.DataSet.FindField(Href) <> nil then
    begin
      case MItem.DataSource.DataSet.FieldByName(Href).DataType of
        ftBoolean: MItem.MainStyle.CellType := sftBool;
        ftString{$IFDEF D_4_UP}, ftWideString{$ENDIF}: MItem.MainStyle.CellType := sftText;
        ftMemo, ftFmtMemo: MItem.MainStyle.CellType := sftMemo;
        ftSmallint, ftInteger, ftWord, ftAutoInc{$IFDEF D_4_UP}, ftLargeInt{$ENDIF}: MItem.MainStyle.CellType := sftNumber;
        ftFloat: MItem.MainStyle.CellType := sftFloating;
        ftCurrency: MItem.MainStyle.CellType := sftCurrency;
        ftDate: MItem.MainStyle.CellType := sftDate;
        ftTime: MItem.MainStyle.CellType := sftTime;
        ftDateTime: MItem.MainStyle.CellType := sftDateTime;
        ftBlob: MItem.MainStyle.CellType := sftBLOB;
        ftGraphic: begin
            MItem.MainStyle.CellType := sftPicture;
          end;
        ftUnknown: MItem.MainStyle.CellType := sftCustom;
      else
        MItem.MainStyle.CellType := sftText;
      end;
    {$ENDIF}
      if TElHackTreeView(Self.FView).FInpEdit <> nil then
      begin
        inherited;
        MItem.EditText;
      end;
    end;
  end;
end;


{ TElDBTreeItems }

{
******************************** TElDBTreeItems ********************************
}
function TElDBTreeItems.Add(Item: TElTreeItem; Text: TElFString): TElTreeItem;
begin
  Result := inherited Add(Item, Text);
end;

function TElDBTreeItems.AddChild(Item: TElTreeItem; Text: TElFString):
        TElTreeItem;
begin
  Result := inherited AddChild(Item, Text);
end;

function TElDBTreeItems.AddChildFirst(Item: TElTreeItem; Text: TElFString):
        TElTreeItem;
begin
  Result := inherited AddChildFirst(Item, Text);
end;

function TElDBTreeItems.AddChildObject(Item: TElTreeItem; Text: TElFString;
        Ptr: pointer): TElTreeItem;
begin
  Result := inherited AddChildObject(Item, Text, Ptr);
end;

function TElDBTreeItems.AddChildObjectFirst(Item: TElTreeItem; Text: TElFString;
        Ptr: pointer): TElTreeItem;
begin
  Result := inherited AddChildObjectFirst(Item, Text, Ptr);
end;

function TElDBTreeItems.AddFirst(Item: TElTreeItem; Text: TElFString):
        TElTreeItem;
begin
  Result := inherited AddFirst(Item, Text);
end;

function TElDBTreeItems.AddItem(Parent: TElTreeItem): TElTreeItem;
begin
  Result := inherited AddItem(Parent);
end;

function TElDBTreeItems.AddLastItem(Parent: TElTreeItem): TElTreeItem;
begin
  Result := inherited AddLastItem(Parent);
end;

function TElDBTreeItems.AddObject(Item: TElTreeItem; Text: TElFString; Ptr:
        pointer): TElTreeItem;
begin
  Result := inherited AddObject(Item, Text, Ptr);
end;

function TElDBTreeItems.AddObjectFirst(Item: TElTreeItem; Text: TElFString;
        Ptr: pointer): TElTreeItem;
begin
  Result := inherited AddObjectFirst(Item, Text, Ptr);
end;

procedure TElDBTreeItems.Assign(Source: TPersistent);
begin
  //  nothing to do
end;

procedure TElDBTreeItems.Clear;
begin
  inherited;
end;

procedure TElDBTreeItems.Delete(Item: TElTreeItem);
begin
  DeleteItem(Item);
end;

procedure TElDBTreeItems.DeleteItem(Child: TElTreeItem);
begin
  (Child as TElDBTreeItem).DeleteChild;
  Child.Delete;
end;

function TElDBTreeItems.GetDBItem(Index: integer): TElDBTreeItem;
begin
  Result := TElDBTreeItem(GetItem(Index));
end;

function TElDBTreeItems.GetDBRootItem(Index: Integer): TElDBTreeItem;
begin
  Result := TElDBTreeItem(GetRootItem(Index));
end;

function TElDBTreeItems.GetDBVisItem(Index: integer): TElDBTreeItem;
begin
  Result := TElDBTreeItem(GetVisItem(Index));
end;

function TElDBTreeItems.GetFirstNode: TElDBTreeItem;
begin
  Result := (inherited GetFirstNode) as TElDBTreeItem;
end;

function TElDBTreeItems.Insert(Item: TElTreeItem; Text: TElFString):
        TElTreeItem;
begin
  Result := inherited Insert(Item, Text);
end;

function TElDBTreeItems.InsertAfter(Item: TElTreeItem; Text: TElFString):
        TElTreeItem;
begin
  Result := inherited InsertAfter(Item, Text);
end;

function TElDBTreeItems.InsertAfterObject(Item: TElTreeItem; Text: TElFString;
        Ptr: Pointer): TElTreeItem;
begin
  Result := inherited InsertAfterObject(Item, Text, Ptr);
end;

function TElDBTreeItems.InsertItem(Index: integer; Parent: TElTreeItem):
        TElTreeItem;
begin
  Result := inherited InsertItem(Index, Parent);
end;

function TElDBTreeItems.InsertObject(Item: TElTreeItem; Text: TElFString; Ptr:
        pointer): TElTreeItem;
begin
  Result := inherited InsertObject(Item, Text, Ptr);
end;

procedure TElDBTreeItems.LoadFromFile(FileName: string);
begin
  // nothing to do
end;

procedure TElDBTreeItems.LoadFromStream(Stream: TStream);
begin
  // nothing to do
end;

procedure TElDBTreeItems.LoadFromStringList(Strings: TStrings);
begin
  // nothing to do
end;

{$IFDEF ELPACK_UNICODE}
{$IFDEF D_4_UP}
procedure TElDBTreeItems.LoadFromWideStringList(Strings: TElWideStrings);
begin
  // nothing to do
end;
{$ENDIF}
{$ENDIF}

procedure TElDBTreeItems.SetItem(Index: Integer; Value: TElTreeItem);
begin
  inherited SetItem(Index, Value);
end;

{$IFDEF ELPACK_UNICODE}
function TCustomElDBTree.GetWideStringText(Field : TField): WideString;
var
  W : WideString;
begin
  with Field do
  begin
    w := Field.asString;
    if UnicodeMode = umForceUTF8 then
    begin
      if isNull then
      begin
        W := '';
      end
      else
      if ConvertUTF8toUTF16(DisplayText, W, strictConversion, false)  <> sourceIllegal
      then
      else
      begin
        if DataType = ftWideString then
          W := Value;
      end;
    end
    else
    if UnicodeMode = umFieldType then
    begin
      if isNull then
        W := ''
      else
      if DataType = ftWideString then
        W := Value;
    end;
  end;
  Result := W;
end;
{$ELSE}
function TCustomElDBTree.GetWideStringText(Field : TField): String;
begin
  Result := Field.AsString;
end;
{$ENDIF}

function TCustomElDBTree.ParsePattern(Pattern: TElFString; ADataSet: TDataSet): TElFString;
const
  ElFTab = {$IFDEF ELPACK_UNICODE}WideChar(#9){$ELSE}#9{$ENDIF};
  ElFSpace = {$IFDEF ELPACK_UNICODE}WideChar(#32){$ELSE}#32{$ENDIF};
var
  tmp, field: TElFString;
  P, Start: {$IFDEF ELPACK_UNICODE}
  PWideChar;
{$ELSE}
  PChar;
{$ENDIF}
  W: {$IFDEF ELPACK_UNICODE}
  WideString;
{$ELSE}
  String;
{$ENDIF}
begin
  Result := '';
{$IFDEF ELPACK_UNICODE}
  if WidePos('<html>', Pattern) <> 1 then EErrorInPattern.Create(SErrorInPattern);
{$ELSE}
  if Pos('<html>', Pattern) <> 1 then EErrorInPattern.Create(SErrorInPattern);
{$ENDIF}

{$IFDEF ELPACK_UNICODE}
  P := PWideChar(Pattern);
{$ELSE}
  P := PChar(Pattern);
{$ENDIF}

  Start := P;
  while P^ <> #0 do
  begin
    if (P^ = '<') then
    begin
      inc(P);
      if ((P^ = 'a') or (P^ = 'A')) and (((P + 1)^ = ElFTab) or ((P + 1)^ = ElFSpace)) then
      begin
        inc(P);
        // Skip space symbols
        while (P^ = ElFTab) or ((P)^ = ElFSpace) do Inc(P);
        if ((P^ = 'h') or (P^ = 'H')) then
          inc(P, 4)
        else
          EErrorInPattern.Create(SErrorInPattern);
        // Skip space symbols
        while (P^ = ElFTab) or ((P)^ = ElFSpace) do Inc(P);
        if P^ = '=' then
          inc(P)
        else
          EErrorInPattern.Create(SErrorInPattern);
        // Skip space symbols
        while (P^ = ElFTab) or ((P)^ = ElFSpace) do Inc(P);
        if P^ = '"' then
          inc(P)
        else
          EErrorInPattern.Create(SErrorInPattern);
        SetString(tmp, Start, P - Start);
        Result := Result + Tmp;
        Start := P;
        while (P^ <> '"') and (P^ <> #0) and (P^ <> '>') do inc(P);
        if P^ = '>' then EErrorInPattern.Create(SErrorInPattern);
        SetString(tmp, Start, P - Start);
        field := tmp;
        Result := Result + Tmp;
        Start := P;
        while (P^ <> #0) and (P^ <> '>') do inc(P);
        inc(P);
        SetString(tmp, Start, P - Start);
        Start := P;
        Result := Result + Tmp;
        if ADataSet.FindField(field) = nil then raise EErrorInPattern.Create(SErrorInPattern);
//***
        W := ADataSet.FieldByName(field).DisplayText;
        {$IFDEF D_4_UP}
        {$IFDEF ELPACK_UNICODE}
        if ADataSet.FieldByName(field).DataType in [ftString, ftWideString] then
          W := GetWideStringText(ADataSet.FieldByName(field));
        {$ENDIF}
        {$ENDIF}
//***
//        Result := Result + ADataSet.FieldByName(field).DisplayText;
        Result := Result + W;
      end;
    end;
    inc(P);
  end;
  SetString(Tmp, Start, P - Start);
  Result := Result + Tmp;
end;

{ TElDBTreeView }

{
******************************** TElDBTreeView *********************************
}
procedure TElDBTreeView.EditOperationAccepted;
begin
  inherited EditOperationCancelled;
  (FOwner as TCustomElDBTree).EditCanceled;

end;

procedure TElDBTreeView.EditOperationCancelled;
begin
  inherited EditOperationCancelled;
  (FOwner as TCustomElDBTree).EditCanceled;
end;

//TElRelationsItem

{
******************************* TElRelationsItem *******************************
}
constructor TElRelationsItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FActiveOnLevel := -1;
  FActive := True;
  FMasterDataSource := TDataSource.Create(((Collection as TElRelations).GetOwner as TComponent));
  FMasterDataSource.Name := ((Collection as TElRelations).GetOwner as TComponent).Name + 'MasterRel' + IntToStr(Self.ID);
  FDetailDataSource := TDataSource.Create(((Collection as TElRelations).GetOwner as TComponent));
  FDetailDataSource.Name := ((Collection as TElRelations).GetOwner as TComponent).Name + 'DetailRel' + IntToStr(Self.ID);
  FDetailDataLink := TSourceDataLink.Create((Collection as TElRelations).FElRelDataSource as TElRelDataSource, Self);
  FDetailDataLink.DataSource := FDetailDataSource;
  FOldFilter := '';
  FOldFiltering := False;
  (Collection as TElRelations).FElRelDataSource.NotifyLinks(elRelAdded, Index);
end;

destructor TElRelationsItem.Destroy;
begin
  (Collection as TElRelations).FElRelDataSource.NotifyLinks(elRelDeleted, Index);
  FDetailDataLink.Free;
  FDetailDataLink := nil;
  FMasterDataSource.free;
  FDetailDataSource.free;
  inherited Destroy;
end;

function TElRelationsItem.GetDetailDataSet: TDataSet;
begin
  Result := FDetailDataSource.DataSet;
end;

function TElRelationsItem.GetDetailDataSource: TDataSource;
begin
  Result := FDetailDataSource;
end;

function TElRelationsItem.GetMasterDataSet: TDataSet;
begin
  Result := FMasterDataSource.DataSet;
end;

function TElRelationsItem.GetMasterDataSource: TDataSource;
begin
  Result := FMasterDataSource;
end;

procedure TElRelationsItem.SetAfterRefresh(ADataset : TDataSet);
begin
  (Collection as TElRelations).FElRelDataSource.NotifyLinks(elSetRelRefresh,Index);
  if Assigned(FAfterRefresh) then FAfterRefresh(ADataSet);
end;

procedure TElRelationsItem.SetDenyLookSetPosition(Value: Boolean);
begin
  FDenyLookSetPosition := Value;
  (Collection as TElRelations).FElRelDataSource.NotifyLinks(elSetModify, Index);
end;

procedure TElRelationsItem.SetDetailDataSet(ADataSet: TDataSet);
var
  pri: Boolean;
begin
  if FDetailDataSource.DataSet <> ADataSet then
  begin
  pri := false;
  (Collection as TElRelations).BeginUpdate;
  if (csDesigning in (Collection as TElRelations).FElRelDataSource.ComponentState) and (not (csLoading in (Collection as TElRelations).FElRelDataSource.ComponentState)) then
  if FDetailField <> '' then
    if Assigned(ADataSet) then
    begin
     {$IFDEF D_4_UP}
      if ADataSet.DefaultFields then
      begin
        if not Assigned(ADataSet.FieldDefList.Find(FDetailField)) then
        begin
          FDetailField := '';
          pri := true;
       end;
      end
      else
      begin
        if not Assigned(ADataSet.FindField(FDetailField)) then
        begin
          FDetailField := '';
          pri := true;
        end;
      end;
     {$ELSE}
      if not Assigned(ADataSet.FindField(FDetailField)) then
      begin
        FDetailField := '';
        pri := true;
      end;
     {$ENDIF}
    end;
  if (csDesigning in (Collection as TElRelations).FElRelDataSource.ComponentState) and (not (csLoading in (Collection as TElRelations).FElRelDataSource.ComponentState)) then
  if FDetailDisplayField <> '' then
    if Assigned(ADataSet) then
    begin
     {$IFDEF D_4_UP}
      if ADataSet.DefaultFields then
      begin
        if not Assigned(ADataSet.FieldDefList.Find(FDetailDisplayField)) then
        begin
          FDetailDisplayField := '';
          pri := true;
       end;
      end
      else
      begin
        if not Assigned(ADataSet.FindField(FDetailDisplayField)) then
        begin
          FDetailDisplayField := '';
          pri := true;
        end;
      end;
     {$ELSE}
      if not Assigned(ADataSet.FindField(FDetailDisplayField)) then
      begin
        FDetailDisplayField := '';
        pri := true;
      end;
     {$ENDIF}
    end;
  FDetailDataSource.DataSet := ADataSet;
  if ADataSet <> nil then
  begin
    FOldFilter := ADataSet.Filter;
    FOldFiltering := ADataSet.Filtered;
  end
  else
  begin
    FOldFilter := '';
    FOldFiltering := false;
  end;
  {$IFDEF D_5_UP}
  if Assigned(ADataSet) then
  begin
    FAfterRefresh := FDetailDataSource.DataSet.AfterRefresh;
    FDetailDataSource.DataSet.AfterRefresh := Self.SetAfterRefresh;
  end
  else
  begin
    FAfterRefresh := nil;
  end;
  {$ELSE}
    FAfterRefresh := nil;
  {$ENDIF}
  if pri or (csLoading in ((Collection as TElRelations).GetOwner as TElRelDataSource).ComponentState) then
    (Collection as TElRelations).FElRelDataSource.NotifyLinks(elRelSetChanged, Index);
  (Collection as TElRelations).EndUpdate;
  end;
end;

procedure TElRelationsItem.SetDetailDisplayField(AField: TElDetailDisplayField);
begin
  if FDetailDisplayField <> AField then
  begin
    FDetailDisplayField := AField;
    (Collection as TElRelations).FElRelDataSource.NotifyLinks(elSetModify, Index);
  end;
end;

procedure TElRelationsItem.SetDetailField(AField: TElDetailField);
begin
  if FDetailField <> AField then
  begin
    FDetailField := AField;
    (Collection as TElRelations).FElRelDataSource.NotifyLinks(elSetModify, Index);
  end;
end;

procedure TElRelationsItem.SetMasterDataSet(ADataSet: TDataSet);
begin
  (Collection as TElRelations).BeginUpdate;
  FMasterDataSource.DataSet := ADataSet;
  if (csDesigning in (Collection as TElRelations).FElRelDataSource.ComponentState) and (not (csLoading in (Collection as TElRelations).FElRelDataSource.ComponentState)) then
  if FMasterField <> '' then
    if Assigned(ADataSet) then
    begin
    {$IFDEF D_4_UP}
      if ADataSet.DefaultFields then
      begin
        if not Assigned(ADataSet.FieldDefList.Find(FMasterField)) then
          FMasterField := '';
      end
      else
      begin
        if not Assigned(ADataSet.FindField(FMasterField)) then
          FMasterField := '';
      end;
    {$ELSE}
      if not Assigned(ADataSet.FindField(FMasterField)) then
        FMasterField := '';
    {$ENDIF}
    end;
  (Collection as TElRelations).EndUpdate;
end;

procedure TElRelationsItem.SetMasterField(AField: TElMasterField);
begin
  if FMasterField <> AField then
  begin
    FMasterField := AField;
    (Collection as TElRelations).FElRelDataSource.NotifyLinks(elSetModify, Index);
  end;
end;





// TSourceDataLink

{
******************************* TSourceDataLink ********************************
}
constructor TSourceDataLink.Create(AElRelDataSource: TElRelDataSource;
        AElRelationsItem: TElRelationsItem);
begin
  FElRelDataSource := AElRelDataSource;
  FElRelationsItem := AElRelationsItem;
end;

procedure TSourceDataLink.ActiveChanged;
begin
  if FElRelationsItem = nil then FElRelDataSource.NotifyLinks(elSetRelActive, -1)
  else FElRelDataSource.NotifyLinks(elSetRelActive, FElRelationsItem.Index);
end;

procedure TSourceDataLink.DataSetChanged;
begin
  inherited DataSetChanged;
end;

// TElRelations

{
********************************* TElRelations *********************************
}
constructor TElRelations.Create(AElRelDataSource: TElRelDataSource; ItemClass:
        TCollectionItemClass);
begin
  inherited Create(ItemClass);
  FElRelDataSource := AElRelDataSource;
end;

procedure TElRelations.EndUpdate;
var
  I: Integer;
  ritem: TElRelationsItem;
  valid: Boolean;
begin
  inherited EndUpdate;
  valid := true;
  for i := 0 to Count - 1 do
  begin
    ritem := (items[i] as TElRelationsItem);
    if (ritem.FMasterField = '') or (ritem.FDetailField = '') or (ritem.FDetailDisplayField = '') or (ritem.FMasterDataSource = nil) or (ritem.FDetailDataSource = nil) then valid := false;
  end;
  if not valid then exit;
  FElRelDataSource.NotifyLinks(elSetModify, 0);
end;

function TElRelations.GetItem(Index: Integer): TElRelationsItem;
begin
  Result := TElRelationsItem(inherited GetItem(Index));
end;

function TElRelations.GetOwner: TPersistent;
begin
  Result := FElRelDataSource;
end;

procedure TElRelations.SetItem(Index: Integer; Value: TElRelationsItem);
begin
  inherited SetItem(Index, Value);
end;


// TElRelDataSource

{
******************************* TElRelDataSource *******************************
}
constructor TElRelDataSource.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FRootDataSource := TDataSource.Create(Self);
  FRootDataLink := TSourceDataLink.Create(Self, nil);
  FRootDataLink.DataSource := FRootDataSource;
  FRelations := TElRelations.Create(Self, TElRelationsItem);
  FOwnFilter := true;
  FFilter := '';
  FFiltered := false;
  FTreeDataLinks := TList.Create;
end;

destructor TElRelDataSource.Destroy;
var
  link: TElTreeDataLink;
begin
  while FTreeDataLinks.Count > 0 do
  begin
    link := FTreeDataLinks.Last;
    link.FTreeView.SetSource(nil);
  end;
  FRootDataLink.DataSource := nil;
  FRootDataLink.Free;
  FRootDataSource.Free;
  FTreeDataLinks.Clear;
  FTreeDataLinks.Free;
  FRelations.Free;
  inherited Destroy;
end;

function TElRelDataSource.GetRootDataSet: TDataSet;
begin
  Result := FRootDataSource.DataSet;
end;

function TElRelDataSource.GetRootDataSource: TDataSource;
begin
  Result := FRootDataSource;
end;

procedure TElRelDataSource.NotifyLinks(Event: TElCustomEvent; UserTag: integer);
var
  I: Integer;
  ritem: TElRelationsItem;
  valid: Boolean;
begin
  valid := true;
  for i := 0 to Relations.Count - 1 do
  begin
    ritem := (Relations.items[i] as TElRelationsItem);
    if (ritem.FMasterField = '') or (ritem.FDetailField = '') or (ritem.FDetailDisplayField = '') or (ritem.FMasterDataSource = nil) or (ritem.FDetailDataSource = nil) then valid := false;
  end;
  //  if valid then valid := Enabled;
  if Event in [elRelDeleted, elRelAdded, elRelSetChanged] then
    valid := true;
  if (UserTag = -1) and (RootDataField <> '') then
    valid := True;
  if not valid then exit;

  for I := FTreeDataLinks.Count - 1 downto 0 do
    if not (csLoading in ComponentState) then TElTreeDataLink(FTreeDataLinks[i]).NotifyControl(Event, UserTag)
    else if (Event in [elSetRelActive, elRelSetChanged, elSetRelRefresh]) then TElTreeDataLink(FTreeDataLinks[i]).NotifyControl(Event, UserTag);
end;

procedure TElRelDataSource.RegisterLink(ALink: TElTreeDataLink);
begin
  FTreeDataLinks.Add(ALink);
  if DataSet <> nil then ALink.FDataSetName := DataSet.Name
  else ALink.FDataSetName := '';
end;

procedure TElRelDataSource.SetAfterRefresh(ADataset : TDataSet);
begin
  Self.NotifyLinks(elSetRelRefresh,-1);
  if Assigned(FAfterRefresh) then FAfterRefresh(ADataSet);
end;

procedure TElRelDataSource.SetDataField(const Value: TElDataField);
begin
  if FDataField <> Value then
  begin
    FDataField := Value;
    NotifyLinks(elSetModify, -1);
  end;
end;

procedure TElRelDataSource.SetDenyLookSetPosition(Value: Boolean);
begin
  FDenyLookSetPosition := Value;
  NotifyLinks(elSetModify, -1);
end;

procedure TElRelDataSource.SetFilter(const Value: string);
begin
  if FFilter <> Value then
  begin
    FFilter := Value;
    NotifyLinks(elSetModify, -1);
  end;
end;

procedure TElRelDataSource.SetFiltered(const Value: Boolean);
begin
  if FFiltered <> Value then
  begin
    FFiltered := Value;
    NotifyLinks(elSetModify, -1);
  end;
end;

procedure TElRelDataSource.SetRelations(Value: TElRelations);
begin
  FRelations.Assign(Value);
end;

procedure TElRelDataSource.SetRootDataSet(ADataSet: TDataSet);
var
  i: Integer;
begin
  if FRootDataSource.DataSet <> ADataSet then
  begin
    if ((csDesigning in ComponentState) and (not (csLoading in ComponentState))) then
      if FDataField <> '' then
        if Assigned(ADataSet) then
        begin
          {$IFDEF D_4_UP}
          if ADataSet.DefaultFields then
          begin
            if not Assigned(ADataSet.FieldDefList.Find(FDataField)) then
              FDataField := '';
          end
          else
          begin
            if not Assigned(ADataSet.FindField(FDataField)) then
              FDataField := '';
          end;
          {$ELSE}
          if not Assigned(ADataSet.FindField(FDataField)) then
            FDataField := '';
          {$ENDIF}
        end;
    if ADataSet <> nil then
    begin
  FOwnFilter := ADataSet.Filtered;
  for I := FTreeDataLinks.Count - 1 downto 0 do
  begin
    TElTreeDataLink(FTreeDataLinks[i]).FDataSetName := ADataSet.Name;
  end;
    end
    else FOwnFilter := false;
    FRootDataSource.DataSet := ADataSet;
  {$IFDEF D_5_UP}
    if Assigned(ADataSet) then
    begin
      FAfterRefresh := FRootDataSource.DataSet.AfterRefresh;
      FRootDataSource.DataSet.AfterRefresh := Self.SetAfterRefresh;
    end
    else
    begin
      FAfterRefresh := nil;
    end;
   {$ELSE}
    FAfterRefresh := nil;
   {$ENDIF}
  NotifyLinks(elRelSetChanged, -1);
  end;
end;

procedure TElRelDataSource.UnRegisterLink(ALink: TElTreeDataLink);
begin
  FTreeDataLinks.Remove(ALink);
end;

{ TElMultiDataSource }

// TTreeDataLink

{
******************************* TElTreeDataLink ********************************
}
constructor TElTreeDataLink.Create(ATreeView: TCustomElDBTree);
begin
  inherited Create;
  FTreeView := ATreeView;
  {$IFDEF D_4_UP}
  //  VisualControl := True;
  {$ENDIF}
end;

procedure TElTreeDataLink.NotifyControl(Event: TElCustomEvent; UserTag:
        integer);
var
  item: TElStylesdefsItem;
  i, j: Integer;
  link: TElCustomDataLink;
begin
  if (FTreeView.FSource <> nil) then
  begin
      case Event of
        elRelDeleted:
        if not (csLoading in FTreeView.ComponentState) then
          FtreeView.FStylesDefs.Delete(UserTag+1);
        elRelAdded:
        begin
          if not (csLoading in FTreeView.ComponentState) then
          begin
            FtreeView.FStylesDefs.FCanAppend := True;
            item := FTreeView.FStylesDefs.Add;
            item.FInDesign := true;
            FtreeView.FStylesDefs.FCanAppend := False;
          end;
        end;
        elSetRelRefresh:
          if (not FTreeView.FChanging) and (not FTreeView.FNoRebuildOnDataChange) then
              FTreeView.RebuildTree(true);
        elSetRelActive:
          if (not FTreeView.FChanging) and (not FTreeView.FNoRebuildOnDataChange) then
              FTreeView.RebuildTree(False);
        elSetModify:
          if not (csLoading in FTreeView.ComponentState) then
          begin
            if (not (csLoading in FTreeView.FSource.ComponentState)) and (not FTreeView.FChanging) then
              if ((FTreeView.FSource.DataSet <> nil) and (FTreeView.FSource.DataSet.Active)) then
                FTreeView.RebuildTree(False)
              else
                FTreeView.Items.Clear;
          end;
        elRelSetChanged:
        begin
          if (UserTag > -1) then
          begin
            i := UserTag + 1;
            if (FTreeView.DataSource.Relations[i-1].MasterDataSet <> nil) and (FTreeView.FSource.Relations[i-1].DetailDataSet <> nil) then
            begin
              FTreeView.FstylesDefs[i].FStyleCaption := 'Relation '+IntToStr(i-1)+' level : '+FTreeView.DataSource.Relations[i-1].MasterDataSet.Name+'-'+FTreeView.FSource.Relations[i-1].DetailDataSet.Name;
              FTreeView.FstylesDefs[i].FInDesign := false;
            end
            else
            begin
              FTreeView.FstylesDefs[i].FStyleCaption := 'Relation ' + IntToStr(i - 1);
              FTreeView.FstylesDefs[i].FInDesign := true;
            end;
            FTreeView.FstylesDefs[i].FDataLink.DataSource := FTreeView.DataSource.Relations[i - 1].GetDetailDataSource;
            FTreeView.FstylesDefs[i].FDataField := FTreeView.FSource.Relations[i - 1].DetailDisplayField;
            if (not (csLoading in FTreeView.FSource.ComponentState)) and (not (csLoading in FTreeView.ComponentState)) then
            begin
              FTreeView.FstylesDefs[i].UsePattern := false;
              FTreeView.FstylesDefs[i].Pattern := '';
              FTreeView.FstylesDefs[i].HintField := '';
              FTreeView.FstylesDefs[i].FCheckBox := '';
              FTreeView.FstylesDefs[i].FShowCheckBox := false;
              FTreeView.FstylesDefs[i].FOwnerHeight := True;
              FTreeView.FstylesDefs[i].FParentColors := True;
              FTreeView.FstylesDefs[i].FParentStyle := True;
              FTreeView.FstylesDefs[i].FEnabled := True;
              FTreeView.FstylesDefs[i].FImagesFromBase := False;
              FTreeView.FstylesDefs[i].FImageIndex := -1;
              FTreeView.FstylesDefs[i].FImageIndex2 := -1;
              FTreeView.FstylesDefs[i].FStImageIndex := -1;
              FTreeView.FstylesDefs[i].FStImageIndex2 := -1;
              FTreeView.FstylesDefs[i].FAllowEdit := True;
              FTreeView.FstylesDefs[i].IsHTML := false;
            end;
           if (FTreeView.FSource.Relations[i - 1].DetailDataSet <> nil) and (FTreeView.FSource.Relations[i - 1].FDetailField <> '') and (FTreeView.FSource.Relations[i - 1].FDetailDisplayField <> '') then
           begin
             if FTreeView.FSource.Relations[i - 1].DetailDataSet <> nil then
             begin
               j := 0;
               if FTreeView.FListOfSets.Count > 0 then
               begin
                 link := FTreeView.FListOfSets.Items[j];
                 while (j < FTreeView.FListOfSets.Count) and (link.DataSet.Name <> FTreeView.FSource.Relations[i - 1].DetailDataSet.Name) do
                 begin
                   if link.DataSource.Name = FTreeView.Name + '7t36g78ljRel' + IntToStr(i - 1) then
                   begin
                     link.DataSource.DataSet := nil;
                     link.DataSource.Free;
                     FTreeView.FListOfSets.Delete(j);
                     link.Free;
                   end
                   else
                     j := j + 1;
                   if j < FtreeView.FListOfSets.Count - 1 then
                     link := FTreeView.FListOfSets.Items[j];
                 end;
                 if (j = FTreeView.FListOfSets.Count) then
                 begin
                   link := TElCustomDataLink.Create;
                   link.FTree := FTreeView;
                   link.DataSource := TDataSource.Create(FTreeView);
                   link.DataSource.Name := FTreeView.Name + '7t36g78ljRel' + IntToStr(i - 1);
                   link.DataSource.DataSet := FTreeView.FSource.Relations[i - 1].GetDetailDataSet;
                   link.FOldFilter := FTreeView.FSource.Relations[i - 1].GetDetailDataSet.Filter;
                   link.FOldFiltered := FTreeView.FSource.Relations[i - 1].GetDetailDataSet.Filtered;
                   if FTreeView.FSource.Relations[i - 1].DetailDataSet <> nil then
                     if FTreeView.FSource.Relations[i - 1].DetailDataSet.Active then link.FRecCount := FTreeView.FSource.Relations[i - 1].DetailDataSet.RecordCount;
                   FTreeView.FListOfSets.Add(link);
                 end;
               end
               else
               begin
                 link := TElCustomDataLink.Create;
                 link.FTree := FTreeView;
                 link.DataSource := TDataSource.Create(FTreeView);
                 link.DataSource.Name := FTreeView.Name + '7t36g78ljRel' + IntToStr(i - 1);
                 link.DataSource.DataSet := FTreeView.FSource.Relations[i - 1].GetDetailDataSet;
                 link.FOldFilter := FTreeView.FSource.Relations[i - 1].GetDetailDataSet.Filter;
                 link.FOldFiltered := FTreeView.FSource.Relations[i - 1].GetDetailDataSet.Filtered;
                 if FTreeView.FSource.Relations[i - 1].DetailDataSet <> nil then
                   if FTreeView.FSource.Relations[i - 1].DetailDataSet.Active then link.FRecCount := FTreeView.FSource.Relations[i - 1].DetailDataSet.RecordCount;
                 FTreeView.FListOfSets.Add(link);
               end;
             end;
           end;
           end
           else
           begin
             if (FTreeView.FSource.GetRootDataSet <> nil) then
             begin
               j := 0;
               if FTreeView.FListOfSets.Count > 0 then
               begin
                 link := FTreeView.FListOfSets.Items[j];
                 while (j < FTreeView.FListOfSets.Count) and (link.DataSet.Name <> FTreeView.FSource.GetRootDataSet.Name) do
                 begin
                   if link.DataSource.Name = FTreeView.Name + '7t36g78ljRoot' then
                   begin
                     link.DataSource.DataSet := nil;
                     link.DataSource.Free;
                     FTreeView.FListOfSets.Delete(j);
                     link.Free;
                   end
                   else
                     j := j + 1;
                   if j < FtreeView.FListOfSets.Count - 1 then
                     link := FTreeView.FListOfSets.Items[j];
                 end;
                 if (j = FTreeView.FListOfSets.Count) then
                 begin
                   link := TElCustomDataLink.Create;
                   link.FTree := FTreeView;
                   link.DataSource := TDataSource.Create(FTreeView);
                   link.DataSource.Name := FTreeView.Name + '7t36g78ljRoot';
                   link.DataSource.DataSet := FTreeView.FSource.GetRootDataSet;
                   link.FOldFilter := FTreeView.FSource.GetRootDataSet.Filter;
                   link.FOldFiltered := FTreeView.FSource.GetRootDataSet.Filtered;
                   if FTreeView.FSource.GetRootDataSet.Active then link.FRecCount := FTreeView.FSource.GetRootDataSet.RecordCount;
                   FTreeView.FListOfSets.Add(link);
                 end;
               end
               else
               begin
                 link := TElCustomDataLink.Create;
                 link.FTree := FTreeView;
                 link.DataSource := TDataSource.Create(FTreeView);
                 link.DataSource.Name := FTreeView.Name + '7t36g78ljRoot';
                 link.DataSource.DataSet := FTreeView.FSource.GetRootDataSet;
                 link.FOldFilter := FTreeView.FSource.GetRootDataSet.Filter;
                 link.FOldFiltered := FTreeView.FSource.GetRootDataSet.Filtered;
                 if FTreeView.FSource.GetRootDataSet.Active then link.FRecCount := FTreeView.FSource.GetRootDataSet.RecordCount;
                 FTreeView.FListOfSets.Add(link);
               end;
             end;
             if Assigned(FTreeView.FSource.DataSet) then
               FDataSetNAme := FTreeView.FSource.DataSet.Name
             else
               FDataSetNAme := '';
             FTreeView.FstylesDefs[0].FStyleCaption := 'RootLevel';
             FTreeView.FstylesDefs[0].FDataField := FTreeView.DataSource.RootDataField;
            if (not (csLoading in FTreeView.FSource.ComponentState)) and (not (csLoading in FTreeView.ComponentState)) then
            begin
             FTreeView.FstylesDefs[0].UsePattern := false;
             FTreeView.FstylesDefs[0].Pattern := '';
             FTreeView.FstylesDefs[0].HintField := '';
             FTreeView.FstylesDefs[0].FCheckBox := '';
             FTreeView.FstylesDefs[0].FShowCheckBox := false;
             FTreeView.FstylesDefs[0].FOwnerHeight := True;
             FTreeView.FstylesDefs[0].FParentColors := True;
             FTreeView.FstylesDefs[0].FParentStyle := True;
             FTreeView.FstylesDefs[0].FEnabled := True;
             FTreeView.FstylesDefs[0].FImagesFromBase := False;
             FTreeView.FstylesDefs[0].FImageIndex := -1;
             FTreeView.FstylesDefs[0].FImageIndex2 := -1;
             FTreeView.FstylesDefs[0].FStImageIndex := -1;
             FTreeView.FstylesDefs[0].FStImageIndex2 := -1;
             FTreeView.FstylesDefs[0].FAllowEdit := True;
             FTreeView.FstylesDefs[0].FIsHTML := false;
            end;
           end;
           if not (csDestroying in FTreeView.ComponentState) then
             FTreeView.RebuildTree(False);
          end;
      end;
  end;
end;


{ TElDBTreeInplaceEditor }

{ TElDBTreeInplaceEditor }

{
**************************** TElDBTreeInplaceEditor ****************************
}
function TElDBTreeInplaceEditor.GetTree: TCustomElDBTree;
begin
  Result := TCustomElDBTree(inherited Tree);
end;

procedure TElDBTreeInplaceEditor.SetTree(Value: TCustomElDBTree);
begin
  inherited Tree := Value;
end;

procedure TElDBTreeInplaceEditor.TriggerAfterCompleteOperation;
begin
  if Assigned(FOnAfterCompleteOperation) then
    OnAfterCompleteOperation(Self);
end;

end.
