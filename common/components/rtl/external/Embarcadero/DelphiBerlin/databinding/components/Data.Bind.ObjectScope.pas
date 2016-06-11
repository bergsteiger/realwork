{*******************************************************}
{                                                       }
{             Delphi LiveBindings Framework             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{$HPPEMIT LINKUNIT}
unit Data.Bind.ObjectScope;

interface

uses System.Classes, System.SysUtils, System.Generics.Collections, System.Bindings.EvalProtocol,
  Data.Bind.Components, System.Bindings.CustomScope, System.Rtti, System.TypInfo,
  System.Bindings.Expression;

type
  TBindSourceAdapter = class;
  TBindSourceAdapterLink = class;
  TBindSourceAdapterField = class;


  /// <summary>Event signature for creating an adapter</summary>
  TCreateAdapterEvent = procedure(Sender: TObject; var ABindSourceAdapter: TBindSourceAdapter) of object;
  /// <summary>Bind source which supports adapters to connect to different types of data</summary>
  /// <remarks>Adapter my be provided by setting a property or by implementing
  ///  the OnCreateAdapter event</remarks>
  TBaseObjectBindSource = class(TBaseLinkingBindSource, IScopeEditLink, IScopeRecordEnumerable,
    IScopeNavigator, IScopeState, IScopeEditor, IScopeMemberNames, IScopeCurrentRecord, IScopeActive,
    IScopeMemberScripting, IScopeGetRecord,
    IScopeLookup, IScopeNavigatorUpdates, IScopeLocate)
  private
    FConnectedAdapter: TBindSourceAdapter;
    FDataLink: TBindSourceAdapterLink;
    FAdapterLinks: TDictionary<TBasicBindComponent, TBindSourceAdapterLink>;
    FActiveChanged: TBindEventList;
    FDataSetChanged: TBindEventList;
    FEditingChanged: TBindEventList;
    FDataSetScrolled: TBindEventList1<Integer>;
    FAutoActivate: Boolean;
    FDeferActivate: Boolean;
    FOnCreateAdapter: TCreateAdapterEvent;
    FRuntimeAdapter: TBindSourceAdapter;
    FCheckRuntimeAdapter: Boolean;
    FAutoEdit: Boolean;
    procedure SetAutoActivate(const Value: Boolean);
    procedure SetItemIndex(const Value: Integer);
    function GetItemIndex: Integer;
    //procedure ActivateExpressions;
    procedure GetRowMember(ARow: Integer; const AMemberName: string;
      ACallback: TProc<TObject>);
    function AdapterLookup(const KeyFields: string; const KeyValues: TValue;
      const ResultFields: string): TValue;
    function AdapterLocate(const KeyFields: string; const KeyValues: TValue): Boolean;
    function AdapterFindValues(LEnumerator: IScopeRecordEnumerator;
      const KeyFields: string; const KeyValues: TValue; AProc: TProc<Integer,
      TValue>): Boolean;
  protected
    procedure UpdateAdapterChanged; virtual;
    procedure UpdateAdapterChanging; virtual;
    procedure SetInternalAdapter(const Value: TBindSourceAdapter;
      AAssignProc: TProc<TBindSourceAdapter>);
    function CheckRuntimeAdapter: Boolean;
    function GetRuntimeAdapter: TBindSourceAdapter;
    procedure ConnectAdapter(AAdapter: TBindSourceAdapter);
    procedure DisconnectAdapter(AAdapter: TBindSourceAdapter);
    procedure DoMemberRenamed(const CurName, PrevName: string);
    procedure DoMemberRenaming(const CurName, NewName: string);
    procedure OnAdapterUpdateState(Sender: TObject);
    procedure OnAdapterDataSetChanged(Sender: TObject);
    procedure OnAdapterDataSetScrolled(Sender: TObject;
      ADistance: Integer);
    procedure OnAdapterEdit(Sender: TObject; var Allow: Boolean);
    procedure OnAdapterEditingChanged(Sender: TObject);
    procedure OnAdapterLayoutChanged(Sender: TObject);
    procedure OnAdapterUpdateRecord(Sender: TObject);
    procedure OnAdapterRecordChanged(Sender: TObject;
      AField: TBindSourceAdapterField);

    procedure SetActive(const Value: Boolean); virtual;
    function CheckAdapter: Boolean; virtual;
    function GetInternalAdapter: TBindSourceAdapter; virtual;
    procedure SetRuntimeAdapter(AAdapter: TBindSourceAdapter); virtual;
    function GetValue: TObject; override;
    function GetMember(const AMemberName: string): TObject; override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure Loaded; override;
    procedure AddExpression(AExpression: TBasicBindComponent); override;
    procedure RemoveExpression(AExpression: TBasicBindComponent); override;
    { IScopeEditLink }
    function Edit(ABindComp: TBasicBindComponent): Boolean; overload;  virtual;
    function GetIsEditing(ABindComp: TBasicBindComponent): Boolean; virtual;
    procedure SetModified(ABindComp: TBasicBindComponent); virtual;
    function GetIsModified(ABindComp: TBasicBindComponent): Boolean; virtual;
    function GetCanModify(ABindComp: TBasicBindComponent): Boolean; overload; virtual;
    procedure UpdateRecord(ABindComp: TBasicBindComponent); virtual;
    procedure Reset(ABindComp: TBasicBindComponent); virtual;
    procedure SetField(ABindComp: TBasicBindComponent; const FieldName: string); virtual;
    procedure SetReadOnly(ABindComp: TBasicBindComponent; const Value: Boolean); virtual;
    procedure ClearModified(ABindComp: TBasicBindComponent); virtual;
    procedure PosChanging(ABindComp: TBasicBindComponent); virtual;
    { IScopeRecordEnumerable }
    function GetEnumerator(const AMemberName: string; ABufferCount: Integer = -1): IScopeRecordEnumerator;
    { IScopeNavigator }
    function GetBOF: Boolean; virtual;
    function GetEOF: Boolean; virtual;
    function GetSelected: Boolean; virtual;
    { IScopeState }
    function GetActive: Boolean; virtual;
    function GetCanModify: Boolean; overload; virtual;
    function GetCanInsert: Boolean; virtual;
    function GetCanDelete: Boolean; virtual;
    function GetEditing: Boolean; virtual;
    function GetCanRefresh: Boolean; virtual;
    procedure AddActiveChanged(LNotify: TNotifyEvent); virtual;
    procedure RemoveActiveChanged(LNotify: TNotifyEvent); virtual;
    procedure AddEditingChanged(LNotify: TNotifyEvent); virtual;
    procedure RemoveEditingChanged(LNotify: TNotifyEvent); virtual;
    procedure AddDataSetScrolled(LNotify: TNotifyDistanceEvent); virtual;
    procedure RemoveDataSetScrolled(LNotify: TNotifyDistanceEvent); virtual;
    procedure AddDataSetChanged(LNotify: TNotifyEvent); virtual;
    procedure RemoveDataSetChanged(LNotify: TNotifyEvent); virtual;
    { IScopeMemberNames }
    procedure GetMemberNames(AList: TStrings); virtual;
    { IScopeCurrentRecord }
    function GetCurrentRecord(const AMemberName: string): IScope;
    { IScopeMemberScripting }
    function GetMemberGetter(const AMemberName: string; var AGetter: string): Boolean;
    function GetMemberSetter(const AMemberName: string; var ASetter: string): Boolean;
    function GetMemberType(const AMemberName: string; var AType: TScopeMemberType): Boolean;
    function GetPositionGetter(var AGetter: string; var ABase: Integer): Boolean;
    function GetPositionSetter(var ASetter: string; var ABase: Integer): Boolean;
    { IScopeGetRecord }
    procedure GetRecord(ARow: Integer; const AMemberName: string; ACallback: TProc<IScope>);

    procedure DoCreateAdapter(var ADataObject: TBindSourceAdapter); virtual;
    procedure GetLookupMemberNames(AList: TStrings); virtual;
    { IScopeNavigatorUpdates }
    function GetCanApplyUpdates: Boolean; virtual;
    function GetCanCancelUpdates: Boolean; virtual;
  public
    { IScopeLocate }
    function Locate(const KeyFields: string; const KeyValues: TValue): Boolean; virtual;
    { IScopeLookup }
    function Lookup(const KeyFields: string; const KeyValues: TValue;
      const ResultFields: string): TValue; virtual;
    { IScopeNavigatorUpdates }
    procedure ApplyUpdates; virtual;
    procedure CancelUpdates; virtual;
    { IScopeNavigator }
    procedure Next; virtual;
    procedure Prior; virtual;
    procedure First; virtual;
    procedure Last; virtual;
    { IScopeEditor }
    procedure Insert; virtual;
    procedure Delete; virtual;
    procedure Cancel; virtual;
    procedure Post; virtual;
    procedure Edit; overload; virtual;
    procedure Refresh; virtual;
    function IsValidChar(const AFieldName: string; const AChar: Char): Boolean; virtual;
    function IsRequired(const AFieldName: string): Boolean; virtual;
    property Eof: Boolean read GetEOF;
    property BOF: Boolean read GetBOF;
    property CanModify: Boolean read GetCanModify;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    [Default(True)]
    property Active: Boolean read GetActive write SetActive default True;
    property AutoActivate: Boolean read FAutoActivate write SetAutoActivate;
    property ItemIndex: Integer read GetItemIndex write SetItemIndex;
    property Editing: Boolean read GetEditing;
    property OnCreateAdapter: TCreateAdapterEvent read FOnCreateAdapter write FOnCreateAdapter;
    property Members[const AName: string]: TObject read GetMember;
    property InternalAdapter: TBindSourceAdapter read GetInternalAdapter;
  end;

  /// <summary>Bind source which delegates</summary>
  TBaseObjectBindSourceDelegate = class(TBaseLinkingBindSource, IScopeEditLink, IScopeRecordEnumerable,
    IScopeNavigator, IScopeState, IScopeEditor, IScopeMemberNames, IScopeCurrentRecord, IScopeActive,
    IScopeMemberScripting, IScopeGetRecord,
    IScopeLookup, IScopeNavigatorUpdates, IScopeLocate)
  private
    FBindSource: TBaseObjectBindSource;
  protected
    function GetValue: TObject; override;
    function GetMember(const AMemberName: string): TObject; override;
    procedure AddExpression(AExpression: TBasicBindComponent); override;
    procedure RemoveExpression(AExpression: TBasicBindComponent); override;
    { IScopeEditLink }
    function Edit(ABindComp: TBasicBindComponent): Boolean; overload;
    function GetIsEditing(ABindComp: TBasicBindComponent): Boolean;
    procedure SetModified(ABindComp: TBasicBindComponent);
    function GetIsModified(ABindComp: TBasicBindComponent): Boolean;
    function GetCanModify(ABindComp: TBasicBindComponent): Boolean; overload;
    procedure UpdateRecord(ABindComp: TBasicBindComponent);
    procedure Reset(ABindComp: TBasicBindComponent);
    procedure SetField(ABindComp: TBasicBindComponent; const FieldName: string);
    procedure SetReadOnly(ABindComp: TBasicBindComponent; const Value: Boolean);
    procedure ClearModified(ABindComp: TBasicBindComponent);
    procedure PosChanging(ABindComp: TBasicBindComponent);
    { IScopeRecordEnumerable }
    function GetEnumerator(const AMemberName: string; ABufferCount: Integer = -1): IScopeRecordEnumerator;
    { IScopeNavigator }
    function GetBOF: Boolean;
    function GetEOF: Boolean;
    function GetSelected: Boolean;
    { IScopeState }
    function GetActive: Boolean;
    function GetCanModify: Boolean; overload;
    function GetCanInsert: Boolean;
    function GetCanDelete: Boolean;
    function GetEditing: Boolean;
    function GetCanRefresh: Boolean;
    procedure AddActiveChanged(LNotify: TNotifyEvent);
    procedure RemoveActiveChanged(LNotify: TNotifyEvent);
    procedure AddEditingChanged(LNotify: TNotifyEvent);
    procedure RemoveEditingChanged(LNotify: TNotifyEvent);
    procedure AddDataSetScrolled(LNotify: TNotifyDistanceEvent);
    procedure RemoveDataSetScrolled(LNotify: TNotifyDistanceEvent);
    procedure AddDataSetChanged(LNotify: TNotifyEvent);
    procedure RemoveDataSetChanged(LNotify: TNotifyEvent);
    { IScopeMemberNames }
    procedure GetMemberNames(AList: TStrings); virtual;
    { IScopeCurrentRecord }
    function GetCurrentRecord(const AMemberName: string): IScope;
    { IScopeMemberScripting }
    function GetMemberGetter(const AMemberName: string; var AGetter: string): Boolean;
    function GetMemberSetter(const AMemberName: string; var ASetter: string): Boolean;
    function GetMemberType(const AMemberName: string; var AType: TScopeMemberType): Boolean;
    function GetPositionGetter(var AGetter: string; var ABase: Integer): Boolean;
    function GetPositionSetter(var ASetter: string; var ABase: Integer): Boolean;
    { IScopeGetRecord }
    procedure GetRecord(ARow: Integer; const AMemberName: string; ACallback: TProc<IScope>);
    { IScopeNavigatorUpdates }
    function GetCanApplyUpdates: Boolean;
    function GetCanCancelUpdates: Boolean;
    { IScopeLocate }
    function Locate(const KeyFields: string; const KeyValues: TValue): Boolean;
    { IScopeLookup }
    function Lookup(const KeyFields: string; const KeyValues: TValue;
      const ResultFields: string): TValue;
    procedure GetLookupMemberNames(AList: TStrings);
    { IScopeNavigatorUpdates }
    procedure ApplyUpdates;
    procedure CancelUpdates;
    { IScopeNavigator }
    procedure Next;
    procedure Prior;
    procedure First;
    procedure Last;
    { IScopeEditor }
    procedure Insert;
    procedure Delete;
    procedure Cancel;
    procedure Post;
    procedure Edit; overload;
    procedure Refresh;
    function IsValidChar(const AFieldName: string; const AChar: Char): Boolean;
    function IsRequired(const AFieldName: string): Boolean;

    function CreateBindSource: TBaseObjectBindSource; virtual; abstract;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TCustomDataGeneratorAdapter = class;

  TCustomAdapterBindSource = class(TBaseObjectBindSource)
  private
    FAdapter: TBindSourceAdapter;
    procedure SetAdapter(Value: TBindSourceAdapter);
  protected
    function GetInternalAdapter: TBindSourceAdapter; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation);  override;
  public
    destructor Destroy; override;
    property Adapter: TBindSourceAdapter read FAdapter write SetAdapter;
  end;

  /// <summary>Bind source which supports adapters to connect to different types of data</summary>
  TAdapterBindSource = class(TCustomAdapterBindSource)
  published
    property AutoActivate;
    property OnCreateAdapter;
    property Adapter;
    property ScopeMappings;
  end;


  TGeneratorFieldDefs = class;

  TCustomPrototypeBindSource = class(TBaseObjectBindSource)
  private
    FDataGenerator: TCustomDataGeneratorAdapter;
    FAdapter: TBindSourceAdapter;
    function GetFieldDefs: TGeneratorFieldDefs;
    function GetRecordCount: Integer;
    procedure SetFieldDefs(const Value: TGeneratorFieldDefs);
    procedure SetRecordCount(const Value: Integer);
    procedure SetAutoEdit(const Value: Boolean);
    procedure SetAutoPost(const Value: Boolean);
    function GetAutoEdit: Boolean;
    function GetAutoPost: Boolean;
  protected
    function GetInternalAdapter: TBindSourceAdapter; override;
  public
    constructor Create(AOwner: TComponent); override;
    [Default(true)]
    property AutoEdit: Boolean read GetAutoEdit write SetAutoEdit default true;
    property AutoPost: Boolean read GetAutoPost write SetAutoPost;
    property FieldDefs: TGeneratorFieldDefs read GetFieldDefs write SetFieldDefs;
    [Default(-1)]
    property RecordCount: Integer read GetRecordCount write SetRecordCount default -1;
    property DataGenerator: TCustomDataGeneratorAdapter read FDataGenerator;
  end;

  /// <summary>Bind source for creating sample data</summary>
  TPrototypeBindSource = class(TCustomPrototypeBindSource)
  published
    property AutoActivate;
    property AutoEdit;
    property AutoPost;
    property RecordCount;
    property FieldDefs;
    property ScopeMappings;
    property OnCreateAdapter;
  end;

{ TBindFieldDef }

  TBindFieldDef = class(TCollectionItem)
  private
    FName: string;
  protected
    function GetDisplayName: string; override;
    procedure SetDisplayName(const Value: string); reintroduce;// overload;
    class function MakeKey(const AName: string): string; static;
    property Name: string read FName write SetDisplayName;
    function HasChildDefs: Boolean; virtual;
  public
    destructor Destroy; override;
  end;

  TBindFieldDefClass = class of TBindFieldDef;
  TBindFieldDefs = class;

  TDefUpdateMethod = procedure of object;

  TBindFieldDefs = class(TOwnedCollection)
  private
    FDictionary: TDictionary<string, TBindFieldDef>;
    [weak] FDataSource: TComponent;
    FUpdated: Boolean;
    FInternalUpdateCount: Integer;
    FParentDef: TBindFieldDef;
    function SafeCast<T: TBindFieldDef>(AValue: TObject): T;
  protected
    procedure DoRenamingFieldDef(AFieldDef: TBindFieldDef; const CurName, NewName: string); virtual;
    procedure DoRenameFieldDef(AFieldDef: TBindFieldDef; const CurName, PrevName: string); virtual;
    procedure DataSourceFieldDefChanged(Sender: TObject); virtual; abstract;
    procedure DataSourceInitFieldDefs; virtual; abstract;
    function GetDataSourceFieldDefs: TBindFieldDefs; virtual; abstract;

    procedure DoUpdate(Sender: TObject);
    procedure SetItemName(AItem: TCollectionItem); override;
    procedure Update(AItem: TCollectionItem); overload; override;
    procedure UpdateDefs(AMethod: TDefUpdateMethod);
    function GetParentDef<T: TBindFieldDef>: T;
    function GetFieldDef<T: TBindFieldDef>(Index: Integer): T;
    procedure SetFieldDef(Index: Integer; Value: TBindFieldDef);
    procedure FieldDefUpdate(Sender: TObject);
    procedure ChildDefUpdate(Sender: TObject);
    function GetFieldDefClass: TBindFieldDefClass; virtual; abstract;
    function AddFieldDef<T: TBindFieldDef>: T;
    function Find<T: TBindFieldDef>(const Name: string): T;
    procedure Update; reintroduce; overload;
  public
    constructor Create(AOwner: TPersistent); virtual;
    destructor Destroy; override;
    procedure GetItemNames(List: TStrings); overload;
    function IndexOf(const AName: string): Integer;
    property DataSource: TComponent read FDataSource;
    property Updated: Boolean read FUpdated write FUpdated;
  end;

  TBindFieldDefsClass = class of TBindFieldDefs;

  TBindFieldDefWithChildren = class(TBindFieldDef)
  private
    FChildDefs: TBindFieldDefs;
  protected
    function GetChildDefs<T: TBindFieldDefs>: T;
    function GetParentDef<T: TBindFieldDef>: T;
    procedure SetChildDefs(Value: TBindFieldDefs);
    function GetChildDefsClass: TBindFieldDefsClass; virtual; abstract;
    function AddChild<T: TBindFieldDef>: T;
    function HasChildDefs: Boolean; override;
  public
    destructor Destroy; override;
  end;


  TGeneratorBindFieldDefsClass = class of TGeneratorFieldDefs;

  TGeneratorFieldType = (ftString, ftInteger, ftSingle, ftBoolean,
    ftBitmap, ftUInteger, ftCurrency, ftDateTime, ftTStrings, ftDate, ftTime, ftChar);

  TGeneratorFieldTypes = set of TGeneratorFieldType;

  TGeneratorOption = (optShuffle, optRepeat);
  TGeneratorOptions = set of TGeneratorOption;

  TGeneratorFieldDef = class(TBindFieldDefWithChildren)
  private
    FFieldNo: Integer;
    FFieldType: TGeneratorFieldType;
    FGenerator: string;
    FReadOnly: Boolean;
    FOptions: TGeneratorOptions;
    FCustomFormat: string;
    function GetChildDefs: TGeneratorFieldDefs;
    function GetFieldNo: Integer;
    function GetParentDef: TGeneratorFieldDef;
    procedure SetChildDefs(Value: TGeneratorFieldDefs);
    procedure SetFieldType(Value: TGeneratorFieldType);
    procedure SetGenerator(const Value: string);
    function GetTypeInfo: PTypeInfo;
    function GetMemberType: TScopeMemberType;
    procedure SetReadOnly(const Value: Boolean);
    procedure SetOptions(const Value: TGeneratorOptions);
    procedure SetCustomFormat(const Value: string);
  protected
    function GetChildDefsClass: TBindFieldDefsClass; override;//override; //virtual; reintroduce;
  public
    constructor Create(Collection: TCollection); overload; override;
    constructor Create(Owner: TBindFieldDefs; const Name: string;
      FieldNo: Integer); reintroduce; overload; virtual;
    function AddChild: TGeneratorFieldDef;
    procedure Assign(Source: TPersistent); override;
    property FieldNo: Integer read GetFieldNo write FFieldNo stored False;
    property ParentDef: TGeneratorFieldDef read GetParentDef;
    property TypeInfo: PTypeInfo read GetTypeInfo;
    property MemberType: TScopeMemberType read GetMemberType;
    property ChildDefs: TGeneratorFieldDefs read GetChildDefs write SetChildDefs stored HasChildDefs;
  published
    property Name;
    property FieldType: TGeneratorFieldType read FFieldType write SetFieldType default ftString;
    property Generator: string read FGenerator write SetGenerator;
    property Options: TGeneratorOptions read FOptions write SetOptions default [optShuffle, optRepeat];
    property ReadOnly: Boolean read FReadOnly write SetReadOnly;
    property CustomFormat: string read FCustomFormat write SetCustomFormat;
  end;

  TGeneratorFieldDefs = class(TBindFieldDefs)
  type
    TEnumerator = TCollectionEnumerator<TGeneratorFieldDef>;
  protected
    function GetAttr(Index: Integer): string; override;
    function GetAttrCount: Integer; override;
    function GetItemAttr(Index, ItemIndex: Integer): string; override;
    procedure DoRenamingFieldDef(AFieldDef: TBindFieldDef; const CurName, NewName: string); override;
    procedure DoRenameFieldDef(AFieldDef: TBindFieldDef; const CurName, PrevName: string); override;
    procedure DataSourceFieldDefChanged(Sender: TObject); override;
    procedure DataSourceInitFieldDefs; override;
    function GetDataSourceFieldDefs: TBindFieldDefs; override;
    function GetFieldDefClass: TBindFieldDefClass; override;

    function GetParentDef: TGeneratorFieldDef;
    function GetFieldDef(Index: Integer): TGeneratorFieldDef;
    procedure SetFieldDef(Index: Integer; Value: TGeneratorFieldDef);
  public
    function GetEnumerator: TEnumerator;
    function AddFieldDef: TGeneratorFieldDef;
    function Find(const Name: string): TGeneratorFieldDef;
    property Items[Index: Integer]: TGeneratorFieldDef read GetFieldDef write SetFieldDef; default;
    property ParentDef: TGeneratorFieldDef read GetParentDef;
  end;

  TBindSourceAdapterLink = class
  private
    [weak] FAdapter: TBindSourceAdapter;
    FUpdating: Boolean;
    FActive: Boolean;
    FEditing: Boolean;
    FReadOnly: Boolean;
    procedure SetAdapter(const Value: TBindSourceAdapter);
    procedure UpdateState;
    procedure SetActive(Value: Boolean);
    procedure SetEditing(Value: Boolean);
  protected
    procedure UpdateRecord;


    procedure RecordChanged(Field: TBindSourceAdapterField); virtual;
    procedure DataSetChanged; virtual;
    procedure DataSetScrolled(ADistance: Integer); virtual;
    procedure LayoutChanged; virtual;
    procedure ActiveChanged; virtual;
    procedure EditingChanged; virtual;
    procedure UpdateData; virtual;
    function Edit: Boolean; virtual;

    property Active: Boolean read FActive;
    property Adapter: TBindSourceAdapter read FAdapter write SetAdapter;
    property Editing: Boolean read FEditing;
  public
    constructor Create;
  end;

  /// <summary>State of a scope adapter</summary>
  TBindSourceAdapterState = (seInactive, seBrowse, seEdit, seInsert);


  /// <summary>Interface for retrieving the underlying object exposed an adapter field</summary>
  IGetMemberObject = interface
    function GetMemberObject: TObject;
  end;

  /// <summary>Type information about an adapter field</summary>
  TBindSourceAdapterFieldType = record
  private
    FTypeKind: TTypeKind;
    FTypeName: string;
  public
    constructor Create(const ATypeName: string; ATypeKind: TTypeKind);
    property TypeKind: TTypeKind read FTypeKind;
    property TypeName: string read FTypeName;
  end;

  IBindSourceAdapter = interface;

  IBindSourceAdapter = interface
  ['{6F63422E-B03D-4308-A536-12F3C5A22931}']
    procedure Next;
    procedure Prior;
    procedure First;
    procedure Last;
    procedure Insert;
    procedure Append;
    procedure Delete;
    procedure Cancel;
    procedure Post;
    procedure Edit(AForce: Boolean=False);
    procedure ApplyUpdates;
    procedure CancelUpdates;
    function GetEmpty: Boolean;
    function GetCurrent: TObject;
    function GetCount: Integer;
    function GetItemIndex: Integer;
    function GetCurrentIndex: Integer;
    function GetCanDelete: Boolean;
    function GetCanInsert: Boolean;
    function GetActive: Boolean;
    function GetCanModify: Boolean;
    function GetCanApplyUpdates: Boolean;
    function GetCanCancelUpdates: Boolean;
    function GetBOF: Boolean;
    function GetEOF: Boolean;
    procedure GetMemberNames(AList: TStrings);
    procedure GetLookupMemberNames(AList: TStrings);
    procedure SetItemIndex(AValue: Integer);
    procedure SetItemIndexOffset(AValue: Integer);
    function GetItemIndexOffset: Integer;
    procedure SetActive(AValue: Boolean);
    property Current: TObject read GetCurrent;
    function GetCurrentRecord(const AMemberName: string): IScope;
    property ItemIndex: Integer read GetItemIndex write SetItemIndex;
    property CurrentIndex: Integer read GetCurrentIndex;
    property ItemCount: Integer read GetCount;
    property ItemIndexOffset: Integer read GetItemIndexOffset write SetItemIndexOffset;
    property CanModify: Boolean read GetCanModify;
    property CanInsert: Boolean read GetCanInsert;
    property CanDelete: Boolean read GetCanDelete;
    property Active: Boolean read GetActive write SetActive;
    property BOF: Boolean read GetBOF;
    property Eof: Boolean read GetEOF;
    property Empty: Boolean read GetEmpty;
  end;

  TAdapterErrorAction = (aaFail, aaAbort, aaRetry);
  TAdapterNotifyEvent = procedure(Adapter: TBindSourceAdapter) of object;
  TAdapterHasUpdatesEvent = procedure(Adapter: TBindSourceAdapter; var AHasUpdates: Boolean) of object;
  TAdapterErrorEvent = procedure(Adapter: TBindSourceAdapter; E: EBindCompError;
    var Action: TAdapterErrorAction) of object;

    /// <summary>Adapter base class for providing data to a TAdapterBindScope</summary>
  TBindSourceAdapter = class(TComponent, IBindSourceAdapter)
  private type
    // Disambiguate methods when linked statically with C++
    TDummy<T> = class
    protected
      FDummy: T;
    end;
  private
    FEnteringEditState: Boolean;
    FUpdatingRecords: Integer;
    FScopes: TList<TBaseObjectBindSource>;
    FModified: Boolean;
    FFields: TList<TBindSourceAdapterField>;
    FLinks: TList<TBindSourceAdapterLink>;
    FItemIndex: Integer;
    FState: TBindSourceAdapterState;
    { Events }
    FBeforeOpen: TAdapterNotifyEvent;
    FAfterOpen: TAdapterNotifyEvent;
    FBeforeClose: TAdapterNotifyEvent;
    FAfterClose: TAdapterNotifyEvent;
    FBeforeInsert: TAdapterNotifyEvent;
    FAfterInsert: TAdapterNotifyEvent;
    FBeforeEdit: TAdapterNotifyEvent;
    FAfterEdit: TAdapterNotifyEvent;
    FBeforePost: TAdapterNotifyEvent;
    FAfterPost: TAdapterNotifyEvent;
    FBeforeCancel: TAdapterNotifyEvent;
    FAfterCancel: TAdapterNotifyEvent;
    FBeforeDelete: TAdapterNotifyEvent;
    FAfterDelete: TAdapterNotifyEvent;
    FBeforeRefresh: TAdapterNotifyEvent;
    FAfterRefresh: TAdapterNotifyEvent;
    FBeforeScroll: TAdapterNotifyEvent;
    FAfterScroll: TAdapterNotifyEvent;
    FBeforeApplyUpdates: TAdapterNotifyEvent;
    FAfterApplyUpdates: TAdapterNotifyEvent;
    FBeforeCancelUpdates: TAdapterNotifyEvent;
    FAfterCancelUpdates: TAdapterNotifyEvent;
    FOnPostError: TAdapterErrorEvent;
    FOnDeleteError: TAdapterErrorEvent;
    FOnInsertError: TAdapterErrorEvent;
    FItemIndexOffset: Integer;
    FOnCancelUpdates: TAdapterNotifyEvent;
    FOnApplyUpdates: TAdapterNotifyEvent;
    FOnApplyUpdatesError: TAdapterErrorEvent;
    FOnEditError: TAdapterErrorEvent;
    FOnCancelUpdatesError: TAdapterErrorEvent;
    FOnHasUpdates: TAdapterHasUpdatesEvent;
    FAutoEdit: Boolean;
    FResetNeeded: Boolean;
    FAutoPost: Boolean;
    function GetScopes: TEnumerable<TBaseObjectBindSource>;
    procedure CheckBrowseMode;
    procedure CheckActive;
    procedure CheckCanModify;
    procedure CheckOperation(AOperation: TProc; ErrorEvent: TAdapterErrorEvent);
    procedure DoAfterApplyUpdates;
    procedure DoAfterCancelUpdates;
    procedure DoBeforeApplyUpdates;
    procedure DoBeforeCancelUpdates;
    procedure AutoEditField(AField: TBindSourceAdapterField);
    procedure AutoPostField(AField: TBindSourceAdapterField);
  protected
    procedure PostFields(AFields: TArray<TBindSourceAdapterField>);
    procedure DataSetChanged;
    procedure RecordChanged(AField: TBindSourceAdapterField);
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function GetItemIndexOffset: Integer;
    procedure SetItemIndexOffset(Value: Integer);
    function SupportsNestedFields: Boolean; virtual;
    function GetCanActivate: Boolean; virtual;
    procedure AddScope(Value: TBaseObjectBindSource); virtual;
    function HasScope(Value: TBaseObjectBindSource): Boolean;
    procedure RemoveScope(Value: TBaseObjectBindSource); virtual;
    procedure SetItemIndex(Value: Integer);
    procedure ClearFields;
    procedure AddLink(DataLink: TBindSourceAdapterLink);
    procedure RemoveLink(DataLink: TBindSourceAdapterLink);
    procedure SetState(Value: TBindSourceAdapterState);
    function GetMemberGetter(const AMemberName: string; var AGetter: string): Boolean; virtual;
    function GetMemberSetter(const AMemberName: string; var ASetter: string): Boolean; virtual;
    function GetMemberType(const AMemberName: string;
      var AType: TScopeMemberType): Boolean; virtual;
    function IsValidChar(const AMemberName: string;
      const AChar: Char): Boolean; virtual;
    procedure UpdateRecord;
    function GetEmpty: Boolean;
    function GetCurrent: TObject; virtual;
    function GetCount: Integer; virtual;
    function GetItemIndex: Integer;
    function GetCurrentIndex: Integer;
    function GetCanDelete: Boolean; virtual;
    function GetCanInsert: Boolean; virtual;
    function GetActive: Boolean; virtual;
    function GetCanModify: Boolean; virtual;
    function GetCanRefresh: Boolean; virtual;
    function GetBOF: Boolean; virtual;
    function GetEOF: Boolean; virtual;
    procedure GetLookupMemberNames(AList: TStrings); virtual;
    function DeleteAt(AIndex: Integer): Boolean; virtual;
    procedure SetActive(Value: Boolean); virtual;
    function AppendAt: Integer; virtual;
    procedure InternalEdit; virtual;
    procedure InternalRefresh; virtual;
    procedure InternalCancelUpdates; virtual;
    procedure InternalApplyUpdates; virtual;
    procedure InternalPost; virtual;
    function InsertAt(AIndex: Integer): Integer; virtual;
    function GetCanApplyUpdates: Boolean; virtual;
    function GetCanCancelUpdates: Boolean; virtual;
    class procedure AddFieldsToList(AType: TRttiType;
      ABindSourceAdapter: TBindSourceAdapter;
      AFieldsList: TList<TBindSourceAdapterField>; const AGetMemberObject: IGetMemberObject);
    class function CreateRttiPropertyField<T>(AProperty: TRttiProperty; ABindSourceAdapter: TBindSourceAdapter;
      const AGetMemberObject: IGetMemberObject; AMemberType: TScopeMemberType; LDummy: TDummy<T> = nil): TBindSourceAdapterField;
    class function CreateRttiObjectPropertyField<T: class>(AProperty: TRttiProperty; ABindSourceAdapter: TBindSourceAdapter;
      const AGetMemberObject: IGetMemberObject; AMemberType: TScopeMemberType; LDummy: TDummy<T> = nil): TBindSourceAdapterField;
    class function CreateRttiFieldField<T>(AProperty: TRttiField; ABindSourceAdapter: TBindSourceAdapter;
      const AGetMemberObject: IGetMemberObject; AMemberType: TScopeMemberType; LDummy: TDummy<T> = nil): TBindSourceAdapterField;
    class function CreateRttiObjectFieldField<T: class>(AProperty: TRttiField; ABindSourceAdapter: TBindSourceAdapter;
      const AGetMemberObject: IGetMemberObject; AMemberType: TScopeMemberType; LDummy: TDummy<T> = nil): TBindSourceAdapterField;
    class procedure AddPropertiesToList(AType: TRttiType;
      ABindSourceAdapter: TBindSourceAdapter;
      AFieldsList: TList<TBindSourceAdapterField>; const AGetMemberObject: IGetMemberObject);
    procedure DoAfterCancel; virtual;
    procedure DoAfterClose; virtual;
    procedure DoAfterDelete; virtual;
    procedure DoAfterEdit; virtual;
    procedure DoAfterInsert; virtual;
    procedure DoAfterOpen; virtual;
    procedure DoAfterPost; virtual;
    procedure DoAfterRefresh; virtual;
    procedure DoAfterScroll; virtual;
    procedure DoBeforeCancel; virtual;
    procedure DoBeforeClose; virtual;
    procedure DoBeforeDelete; virtual;
    procedure DoBeforeEdit; virtual;
    procedure DoBeforeInsert; virtual;
    procedure DoBeforeOpen; virtual;
    procedure DoBeforePost; virtual;
    procedure DoBeforePostFields(AFields: TArray<TBindSourceAdapterField>); virtual;
    procedure DoAfterPostFields(AFields: TArray<TBindSourceAdapterField>); virtual;
    procedure DoBeforeRefresh; virtual;
    procedure DoBeforeScroll; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function FindField(const AMemberName: string): TBindSourceAdapterField;
    function GetEnumerator(const AMemberName: string;
      AGetScope: TFunc<IScope>; AGetMemberScope: TFunc<string, IScope>): IScopeRecordEnumerator;
    function GetValue: TObject;
    function GetMember(const AMemberName: string): TObject;
    procedure Refresh; virtual;
    procedure Next; virtual;
    procedure Prior; virtual;
    procedure First; virtual;
    procedure Last; virtual;
    procedure Insert; virtual;
    procedure Append; virtual;
    procedure Delete; virtual;
    procedure Cancel; virtual;
    procedure Post; virtual;
    procedure PosChanging; virtual;
    procedure Edit(AForce: Boolean = False); overload; virtual;
    procedure CancelUpdates; virtual;
    procedure ApplyUpdates; virtual;
    procedure GetMemberNames(AList: TStrings); virtual;
    // Cause linked grid controls to reset on next data change
    procedure ResetNeeded;
    property Current: TObject read GetCurrent;
    function GetCurrentRecord(const AMemberName: string): IScope;
    property ItemIndex: Integer read GetItemIndex write SetItemIndex;
    property CurrentIndex: Integer read GetCurrentIndex;
    property ItemCount: Integer read GetCount;
    property ItemIndexOffset: Integer read GetItemIndexOffset write SetItemIndexOffset;
    property CanModify: Boolean read GetCanModify;
    property CanInsert: Boolean read GetCanInsert;
    property CanDelete: Boolean read GetCanDelete;
    property CanRefresh: Boolean read GetCanRefresh;
    property Active: Boolean read GetActive write SetActive;
    [Default(True)]
    property AutoEdit: Boolean read FAutoEdit write FAutoEdit default True;
    property AutoPost: Boolean read FAutoPost write FAutoPost;
    property BOF: Boolean read GetBOF;
    property Eof: Boolean read GetEOF;
    property Modified: Boolean read FModified;
    property Empty: Boolean read GetEmpty;
    property State: TBindSourceAdapterState read FState;
    property Fields: TList<TBindSourceAdapterField> read FFields;
    property CanActivate: Boolean read GetCanActivate;
    property CanApplyUpdates: Boolean read GetCanApplyUpdates;
    property CanCancelUpdates: Boolean read GetCanCancelUpdates;
    property Scopes: TEnumerable<TBaseObjectBindSource> read GetScopes;
    property BeforeOpen: TAdapterNotifyEvent read FBeforeOpen write FBeforeOpen;
    property AfterOpen: TAdapterNotifyEvent read FAfterOpen write FAfterOpen;
    property BeforeClose: TAdapterNotifyEvent read FBeforeClose write FBeforeClose;
    property AfterClose: TAdapterNotifyEvent read FAfterClose write FAfterClose;
    property BeforeInsert: TAdapterNotifyEvent read FBeforeInsert write FBeforeInsert;
    property AfterInsert: TAdapterNotifyEvent read FAfterInsert write FAfterInsert;
    property BeforeEdit: TAdapterNotifyEvent read FBeforeEdit write FBeforeEdit;
    property AfterEdit: TAdapterNotifyEvent read FAfterEdit write FAfterEdit;
    property BeforePost: TAdapterNotifyEvent read FBeforePost write FBeforePost;
    property AfterPost: TAdapterNotifyEvent read FAfterPost write FAfterPost;
    property BeforeCancel: TAdapterNotifyEvent read FBeforeCancel write FBeforeCancel;
    property AfterCancel: TAdapterNotifyEvent read FAfterCancel write FAfterCancel;
    property BeforeDelete: TAdapterNotifyEvent read FBeforeDelete write FBeforeDelete;
    property AfterDelete: TAdapterNotifyEvent read FAfterDelete write FAfterDelete;
    property BeforeScroll: TAdapterNotifyEvent read FBeforeScroll write FBeforeScroll;
    property AfterScroll: TAdapterNotifyEvent read FAfterScroll write FAfterScroll;
    property BeforeRefresh: TAdapterNotifyEvent read FBeforeRefresh write FBeforeRefresh;
    property AfterRefresh: TAdapterNotifyEvent read FAfterRefresh write FAfterRefresh;
    property BeforeApplyUpdates: TAdapterNotifyEvent read FBeforeApplyUpdates write FBeforeApplyUpdates;
    property AfterApplyUpdates: TAdapterNotifyEvent read FAfterApplyUpdates write FAfterApplyUpdates;
    property BeforeCancelUpdates: TAdapterNotifyEvent read FBeforeCancelUpdates write FBeforeCancelUpdates;
    property AfterCancelUpdates: TAdapterNotifyEvent read FAfterCancelUpdates write FAfterCancelUpdates;
    property OnDeleteError: TAdapterErrorEvent read FOnDeleteError write FOnDeleteError;
    property OnInsertError: TAdapterErrorEvent read FOnInsertError write FOnINsertError;
    property OnEditError: TAdapterErrorEvent read FOnEditError write FOnEditError;
    property OnPostError: TAdapterErrorEvent read FOnPostError write FOnPostError;
    property OnApplyUpdatesError: TAdapterErrorEvent read FOnApplyUpdatesError write FOnApplyUpdatesError;
    property OnCancelUpdatesError: TAdapterErrorEvent read FOnCancelUpdatesError write FOnCancelUpdatesError;
    property OnApplyUpdates: TAdapterNotifyEvent read FOnApplyUpdates write FOnApplyUpdates;
    property OnCancelUpdates: TAdapterNotifyEvent read FOnCancelUpdates write FOnCancelUpdates;
    property OnHasUpdates: TAdapterHasUpdatesEvent read FOnHasUpdates write FOnHasUpdates;
  end;

  TObjectAdapterOption = (optAllowModify,
    optAllowApplyUpdates, optAllowCancelUpdates);
  TObjectAdapterOptions = set of TObjectAdapterOption;

  TBaseObjectBindSourceAdapter = class(TBindSourceAdapter)
  private
    FOptions: TObjectAdapterOptions;
  protected
    function GetObjectType: TRttiType; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    property Options: TObjectAdapterOptions read FOptions write FOptions;
  end;

  TBindSourceAdapterInstanceFactory = class
  private
    FType: TRttiType;
    FFindConstructor: Boolean;
    FConstructor: TRttiMethod;
    function FindConstructor: TRttiMethod;
  public
    constructor Create(AType: TRttiType);
    function CheckConstructor(out AType: TRttiType; out AMethod: TRttiMethod): Boolean; overload;
    function CheckConstructor: Boolean; overload;
    function CanConstructInstance: Boolean;
    function ConstructInstance: TObject;
  end;

  TListAdapterOption = (loptAllowInsert, loptAllowDelete, loptAllowModify,
    loptAllowApplyUpdates, loptAllowCancelUpdates);
  TListAdapterOptions = set of TListAdapterOption;

  TListInsertEvent = procedure(Sender: TBindSourceAdapter; AIndex: Integer; var AHandled: Boolean; var ANewIndex: Integer) of object;
  TListAppendEvent = procedure(Sender: TBindSourceAdapter; var AHandled: Boolean; var Appended: Boolean) of object;
  TListDeleteEvent = procedure(Sender: TBindSourceAdapter; AIndex: Integer; var AHandled: Boolean; var ADeleted: Boolean) of object;
  TCreateItemInstanceEvent = procedure(Sender: TBindSourceAdapter; var AHandled: Boolean; var AInstance: TObject) of object;
  TInitItemInstanceEvent = procedure(Sender: TBindSourceAdapter; AInstance: TObject) of object;
  TSetObjectEvent = procedure(Sender: TBindSourceAdapter; AObject: TObject) of object;
  TBaseListBindSourceAdapter = class(TBaseObjectBindSourceAdapter)
  private
    FOnListAppend: TListAppendEvent;
    FOnListInsert: TListInsertEvent;
    FOnListDelete: TListDeleteEvent;
    FOnCreateItemInstance: TCreateItemInstanceEvent;
    FOnInitItemInstance: TInitItemInstanceEvent;
    FOptions: TListAdapterOptions;
  protected
    procedure DoListDelete(AIndex: Integer; out AHandled: Boolean;
      out ARemoved: Boolean); virtual;
    procedure DoListInsert(AIndex: Integer; out AHandled: Boolean;
      out ANewIndex: Integer); virtual;
    procedure DoListAppend(out AHandled: Boolean; out AAppended: Boolean); virtual;
    procedure DoCreateInstance(out AHandled: Boolean; out AInstance: TObject); virtual;
    procedure DoInitItemInstance(AInstance: TObject); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    property OnListAppend: TListAppendEvent read FOnListAppend write FOnListAppend;
    property OnListDelete: TListDeleteEvent read FOnListDelete write FOnListDelete;
    property OnListInsert: TListInsertEvent read FOnListInsert write FOnListInsert;
    property OnCreateItemInstance: TCreateItemInstanceEvent read FOnCreateItemInstance write FOnCreateItemInstance;
    property OnInitItemInstance: TInitItemInstanceEvent read FOnInitItemInstance write FOnInitItemInstance;
    property Options: TListAdapterOptions read FOptions write FOptions;
  end;

  /// <summary>Adapter to provide a generic TList to TAdapterBindSource</summary>
  TListBindSourceAdapter<T: class> = class(TBaseListBindSourceAdapter)
  private
    FList: TList<T>;
    FInstanceFactory: TBindSourceAdapterInstanceFactory;
    FOwnsList: Boolean;
    FOnBeforeSetList: TSetObjectEvent;
    FOnAfterSetList: TAdapterNotifyEvent;
    function GetItemInstanceFactory: TBindSourceAdapterInstanceFactory;
  protected
    procedure CheckList;
    function GetObjectType: TRttiType; override;
    function CreateItemInstance: T; virtual;
    procedure InitItemInstance(AInstance: T); virtual;
    function GetCurrent: TObject; override;
    function GetCount: Integer; override;
    function DeleteAt(AIndex: Integer): Boolean;  override;
    function AppendAt: Integer; override;
    function InsertAt(AIndex: Integer): Integer; override;
    function GetCanActivate: Boolean; override;
    function SupportsNestedFields: Boolean; override;
    function GetCanDelete: Boolean; override;
    function GetCanInsert: Boolean; override;
    function GetCanModify: Boolean; override;
    function GetCanApplyUpdates: Boolean; override;
    function GetCanCancelUpdates: Boolean; override;
    procedure AddFields; virtual;
    procedure InternalCancelUpdates; override;
    procedure InternalApplyUpdates; override;
    procedure DoOnBeforeSetList(AList: TList<T>); virtual;
    procedure DoOnAfterSetList; virtual;
  public
    constructor Create(AOwner: TComponent; AList: TList<T>; AOwnsObject: Boolean = True); reintroduce; overload; virtual;
    destructor Destroy; override;
    procedure SetList(AList: TList<T>; AOwnsObject: Boolean = True);
    property List: TList<T> read FList;
    property OnBeforeSetList: TSetObjectEvent read FOnBeforeSetList write FOnBeforeSetList;
    property OnAfterSetList: TAdapterNotifyEvent read FOnAfterSetList write FOnAfterSetList;
  end;

  TListBindSourceAdapter =  class(TListBindSourceAdapter<TObject>)
  private
    FClass: TClass;
  protected
    function GetObjectType: TRttiType; override;
  public
    constructor Create(AOwner: TComponent; AList: TList<TObject>;
      AClass: TClass; AOwnsObject: Boolean = True); reintroduce; overload; virtual;
  end;

  /// <summary>Adapter to provide an arbitrary object to TAdapterBindSource</summary>
  TObjectBindSourceAdapter<T: class> = class(TBaseObjectBindSourceAdapter)
  private
    FDataObject: T;
    FOwnsObject: Boolean;
    FOnBeforeSetDataObject: TSetObjectEvent;
    FOnAfterSetDataObject: TAdapterNotifyEvent;
  protected
    function GetObjectType: TRttiType; override;
    function GetCanActivate: Boolean; override;
    function GetCurrent: TObject; override;
    function GetCount: Integer; override;
    function DeleteAt(AIndex: Integer): Boolean;  override;
    function AppendAt: Integer; override;
    function InsertAt(AIndex: Integer): Integer; override;
    function SupportsNestedFields: Boolean; override;
    function GetCanModify: Boolean; override;
    function GetCanApplyUpdates: Boolean; override;
    function GetCanCancelUpdates: Boolean; override;
    procedure AddFields; virtual;
    procedure InternalApplyUpdates; override;
    procedure InternalCancelUpdates; override;
    procedure DoOnBeforeSetDataObject(ADataObject: T); virtual;
    procedure DoOnAfterSetDataObject; virtual;
  public
    constructor Create(AOwner: TComponent; AObject: T; AOwnsObject: Boolean = True); reintroduce; overload; virtual;
    destructor Destroy; override;
    procedure SetDataObject(ADataObject: T; AOwnsObject: Boolean = True);
    property DataObject: T read FDataObject;
    property OnBeforeSetDataObject: TSetObjectEvent read FOnBeforeSetDataObject write FOnBeforeSetDataObject;
    property OnAfterSetDataObject: TAdapterNotifyEvent read FOnAfterSetDataObject write FOnAfterSetDataObject;
  end;

  TObjectBindSourceAdapter = class(TObjectBindSourceAdapter<TObject>)
  private
    FClass: TClass;
  protected
    function GetObjectType: TRttiType; override;
  public
    constructor Create(AOwner: TComponent; AObject: TObject;
      AClass: TClass; AOwnsObject: Boolean = True); reintroduce; overload; virtual;
  end;

  /// <summary>Base class for an adapter field</summary>
  TBindSourceAdapterField = class(TPersistent)
  private
    class var FValidChars: TDictionary<char, TScopeMemberTypes>;

  private var
    FMemberName: string;
    [weak] FOwner: TBindSourceAdapter;
    FGetMemberObject: IGetMemberObject;
    function GetMemberObject: TObject;
    function SupportsStreamPersist(const Persistent: TObject;
      var StreamPersist: IStreamPersist): Boolean;
    procedure SaveToStreamPersist(StreamPersist: IStreamPersist);
    procedure SaveToStrings(Strings: TStrings);
    function CreateValueBlobStream(AValue: TObject): TStream;
    function GetAutoPost: Boolean; virtual;
    procedure SetAutoPost(const Value: Boolean); virtual;
  protected
    procedure AutoPostField;
    procedure AutoEditField;
    function CreateBlobStream: TStream; virtual;
    function AssignValue(Dest: TPersistent): Boolean;
    procedure Post; virtual;
    function IsBuffered: Boolean; virtual;
    procedure Cancel; virtual;
    function GetIsObject: Boolean; virtual;
    function GetIsReadable: Boolean; virtual;
    function GetIsWritable: Boolean; virtual;
    function GetGetter(var AGetter: string): Boolean; virtual;
    function GetSetter(var AGetter: string): Boolean; virtual;
    function GetMemberType(var AType: TScopeMemberType): Boolean; virtual;
    function IsValidChar(AChar: Char): Boolean;
    procedure RecordChanged;
  public
    constructor Create(AOwner: TBindSourceAdapter; const AMemberName: string;
      const AGetMemberObject: IGetMemberObject); virtual;
    class destructor Destroy;
    // Non generic access
    function GetTValue: TValue; virtual;
    procedure SetTValue(const AValue: TValue); virtual;
    function FindField(const AMemberName: string): TBindSourceAdapterField; virtual;
    property Owner: TBindSourceAdapter read FOwner;
    property MemberName: string read FMemberName;
    property IsObject: Boolean read GetIsObject;
    property IsReadable: Boolean read GetIsReadable;
    property IsWritable: Boolean read GetIsWritable;
    property AutoPost: Boolean read GetAutoPost write SetAutoPost;
    property MemberObject: TObject read GetMemberObject;
    property GetMemberObjectIntf: IGetMemberObject read FGetMemberObject write FGetMemberObject;
  end;

  /// <summary>Base class to get a value using RTTI</summary>
  TValueAccessor = class
  protected
    FField: TBindSourceAdapterField;
  end;

  /// <summary>Base class to get a value of a particular type using RTTI</summary>
  TValueReader<T> = class(TValueAccessor)
  public
    function GetValue: T; virtual; abstract;
  end;

  /// <summary>Use RTTI to read the value of a field</summary>
  TFieldValueReader<T> = class(TValueReader<T>)
  public
    function GetValue: T; override;
  end;

  TBindFieldDefValueReader<T> = class(TValueReader<T>)
  public
    function GetValue: T; override;
  end;

  TBindFieldDefObjectValueReader<T: class> = class(TBindFieldDefValueReader<T>)
  public
    function GetValue: T; override;
  end;

  /// <summary>Use RTTI to read the value of a property</summary>
  TPropertyValueReader<T> = class(TValueReader<T>)
  public
    function GetValue: T; override;
  end;

  /// <summary>Base class to set a value using RTTI</summary>
  TValueWriter<T> = class(TValueAccessor)
  public
    procedure SetValue(const AValue: T); virtual; abstract;
  end;

  /// <summary>Use RTTI to set the value of a field</summary>
  TFieldValueWriter<T> = class(TValueWriter<T>)
  public
    procedure SetValue(const AValue: T); override;
  end;

  TBindFieldDefValueWriter<T> = class(TValueWriter<T>)
  public
    procedure SetValue(const AValue: T); override;
  end;

  TBindFieldDefObjectValueWriter<T: class> = class(TBindFieldDefValueWriter<T>)
  public
    procedure SetValue(const AValue: T); override;
  end;

  /// <summary>Use RTTI to set the value of a property</summary>
  TPropertyValueWriter<T> = class(TValueWriter<T>)
  public
    procedure SetValue(const AValue: T); override;
  end;


  /// <summary>Adapter field which supports reading</summary>
  TBindSourceAdapterReadField<T> = class(TBindSourceAdapterField)
  protected const
    sMemberName = 'Value';
  strict private var
    FValueReader: TValueReader<T>;
    FRttiType: TBindSourceAdapterFieldType;
    FMemberType: TScopeMemberType;
  protected
    function GetValue: T; virtual;
    function GetMemberType(var AType: TScopeMemberType): Boolean; override;
    function GetGetter(var AGetter: string): Boolean; override;
  public
    constructor Create(AOwner: TBindSourceAdapter; const AMemberName: string; AType: TBindSourceAdapterFieldType;
      const AGetMemberObject: IGetMemberObject; const AReader: TValueReader<T>; AMemberType: TScopeMemberType); reintroduce;
    destructor Destroy; override;
    function GetTValue: TValue; override;
    property Value: T read GetValue;
  end;

  TBindSourceAdapterReadObjectField<T: class> = class(TBindSourceAdapterReadField<T>)
  protected
    function CreateBlobStream: TStream; override;
    procedure AssignTo(Dest: TPersistent); override;
  end;


  /// <summary>Adapter field which supports reading and writing</summary>
  TBindSourceAdapterReadWriteField<T> = class(TBindSourceAdapterReadField<T>)
  strict private
    FAutoPost: Boolean;
    FBuffered: Boolean;
    FValueWriter: TValueWriter<T>;
  private
    FBuffer: T;
  protected
    function IsBuffered: Boolean; override;
    procedure Post; override;
    procedure Cancel; override;
    function GetValue: T; override;
    procedure SetValue(const Value: T); virtual;
    function GetSetter(var AGetter: string): Boolean; override;
    procedure ClearBuffer; virtual;
    function GetAutoPost: Boolean; override;
    procedure SetAutoPost(const Value: Boolean); override;
  public
    constructor Create(AOwner: TBindSourceAdapter; const AMemberName: string; AType: TBindSourceAdapterFieldType;
      const AGetMemberObject: IGetMemberObject; const AReader: TValueReader<T>;
        const AWriter: TValueWriter<T>; AMemberType: TScopeMemberType); reintroduce;
    procedure SetTValue(const AValue: TValue); override;
    destructor Destroy; override;
    property Value: T read GetValue write SetValue;
  end;

  TBindSourceAdapterReadWriteObjectField<T: class> = class(TBindSourceAdapterReadWriteField<T>)
  protected
    function CreateBlobStream: TStream; override;
    procedure AssignTo(Dest: TPersistent); override;
    procedure ClearBuffer; override;
  end;

  /// <summary>Adapter field which supports an object property</summary>
  /// <remarks>The members of the object are also exposed as fields</remarks>
  TBindSourceAdapterReadObjectField = class(TBindSourceAdapterReadObjectField<TObject>)
  private var
    FHaveFields: Boolean;
    FFields: TList<TBindSourceAdapterField>;
    procedure CheckAddFields;
  protected
    function GetIsObject: Boolean; override;
  public
    destructor Destroy; override;
    constructor Create(AOwner: TBindSourceAdapter; const AMemberName: string; AType: TBindSourceAdapterFieldType;
      const AGetMemberObject: IGetMemberObject; const AReader: TValueReader<TObject>;
      AMemberType: TScopeMemberType);
    function FindField(const AMemberName: string): TBindSourceAdapterField; override;
    property Fields: TList<TBindSourceAdapterField> read FFields;
  end;

  /// <summary>Custom scope to allow the expression engine to access field names as if they are members of the
  ///  wrapped TBindSourceAdapter</summary>
  TBindSourceAdapterCustomScope = class(TCustomScope)
  protected
    function DoLookup(const Name: String): IInterface; override;
  end;

  /// <summary>Custom scope to allow the expression engine to access field names as if they are members of the
  ///  wrapped field</summary>
  TBindSourceAdapterObjectFieldCustomScope = class(TCustomScope)
  protected
    function DoLookup(const Name: String): IInterface; override;
  end;

  /// <summary>Implementation of IGetMemberObject to get the object associated with an adapter</summary>
  TBindSourceAdapterGetMemberObject = class(TInterfacedObject, IGetMemberObject)
  private
    FBindSourceAdapter: TBindSourceAdapter;
  public
    constructor Create(ACollectionEditor: TBindSourceAdapter);
    function GetMemberObject: TObject;
  end;

  /// <summary>Implementation of IGetMemberObject to get the object associated with object field</summary>
  TBindSourceAdapteObjectFieldGetMemberObject = class(TInterfacedObject, IGetMemberObject)
  private
    FObject: TObject;
  public
    constructor Create(AObject: TObject);
    function GetMemberObject: TObject;
  end;

  TGeneratorRecord = class(TObject)
  private
    FDictionary: TDictionary<string, TValue>;
    FFreeObjects: TList<TObject>;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TValueGenerator = class;
  TCustomFormatObject = class;

  /// <summary>Adapter to provide a generic TList to TAdaptiveBindScope</summary>
  TCustomDataGeneratorAdapter = class(TListBindSourceAdapter<TGeneratorRecord>)
  private type
    // Disambiguate methods when linked statically with C++
    TDummy<T> = class
    protected
      FDummy: T;
    end;
  private
    FFieldDefs: TGeneratorFieldDefs;
    FRecordCount: Integer;
    class procedure AddFieldsToList(AFieldDefs: TGeneratorFieldDefs;
      ABindSourceAdapter: TBindSourceAdapter; AFieldsList: TList<TBindSourceAdapterField>;
      const AGetMemberObject: IGetMemberObject); static;
    class function CreateField<T>(AFieldDef: TGeneratorFieldDef;
      ABindSourceAdapter: TBindSourceAdapter;
      const AGetMemberObject: IGetMemberObject; LDummy: TDummy<T> = nil): TBindSourceAdapterField; static;
    class function CreateObjectField<T: class>(AFieldDef: TGeneratorFieldDef;
      ABindSourceAdapter: TBindSourceAdapter;
      const AGetMemberObject: IGetMemberObject; LDummy: TDummy<T> = nil): TBindSourceAdapterField; static;
    procedure GenerateExistingRecords(AList: TList<TGeneratorRecord>);

    procedure SetFieldDefs(Value: TGeneratorFieldDefs);
    function GetFieldDefsClass: TGeneratorBindFieldDefsClass;
    procedure InitFieldDefs;
    procedure SetRecordCount(const Value: Integer);
    procedure CreateCustomFormatExpression<T>(const ACustomFormat: string;
      out AExpression: TBindingExpression; out ACustomFormatObject: TCustomFormatObject);//    function GenerateValue<T>(const AGenerator: TValueGenerator;
  protected
    function SupportsNestedFields: Boolean; override;
    procedure SetActive(Value: Boolean); override;
    function CreateItemInstance: TGeneratorRecord; override;
    procedure InitItemInstance(ARecord: TGeneratorRecord); override;
    procedure FieldDefChanged(Sender: TObject); virtual;
    function GetCanActivate: Boolean; override;
    function GetCanInsert: Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure GetMemberNames(AList: TStrings); override;
    procedure AddFields; override;
    property FieldDefs: TGeneratorFieldDefs read FFieldDefs write SetFieldDefs;
    [Default(-1)]
    property RecordCount: Integer read FRecordCount write SetRecordCount default -1;
  end;

  TDataGeneratorAdapter = class(TCustomDataGeneratorAdapter)
  published
    property FieldDefs;
    property Active;
    property AutoEdit;
    property AutoPost;
    property RecordCount;
    property BeforeOpen;
    property AfterOpen;
    property BeforeClose;
    property AfterClose;
    property BeforeInsert;
    property AfterInsert;
    property BeforeEdit;
    property AfterEdit;
    property BeforePost;
    property AfterPost;
    property BeforeCancel;
    property AfterCancel;
    property BeforeDelete;
    property AfterDelete;
    property BeforeScroll;
    property AfterScroll;
    property BeforeRefresh;
    property AfterRefresh;
    property OnDeleteError;
    property OnInsertError;
    property OnEditError;
    property OnPostError;
    property OnApplyUpdates;
    property OnCancelUpdates;
    property Options;
  end;

  TValueGenerator = class
  private
    FGeneratorName: string;
    FFieldType: TGeneratorFieldType;
    FOptions: TGeneratorOptions;
    FCustomFormat: string;
  protected
    function GetRecordCount: Integer; virtual;
  public
    constructor Create(AFieldDef: TGeneratorFieldDef); virtual;
    procedure FirstRecord; virtual;
    procedure NextRecord; virtual;
    function GetValue(var AFree: Boolean): TValue; virtual;
    property FieldType: TGeneratorFieldType read FFieldType;
    property Options: TGeneratorOptions read FOptions;
    property GeneratorName: string read FGeneratorName;
    property CustomFormat: string read FCustomFormat;
    property RecordCount: Integer read GetRecordCount;
  end;

  TValueGeneratorDelegate = class
  public
    function GetValue(var AFree: Boolean): TValue; virtual; abstract;
    procedure NextRecord; virtual; abstract;
    procedure FirstRecord; virtual; abstract;
    function GetRecordCount: Integer; virtual;
  end;

  TValueGeneratorOnGetValue = reference to function(AKey: TValue; var AFreeObject: Boolean): TValue;
  TValueGeneratorDelegateWithEvents = class(TValueGeneratorDelegate)
  private
    FGetValue: TValueGeneratorOnGetValue; // TFunc<TValue, TValue>;
  public
    property OnGetValue: TValueGeneratorOnGetValue read FGetValue write FGetValue;
  end;

  TTypedListValueGeneratorDelegate<T> = class(TValueGeneratorDelegateWithEvents)
  private
    FValueCounter: Integer;
    FValuesList: TList<T>;
  public
    constructor Create(AOptions: TGeneratorOptions; AValuesList: TArray<T>);
    destructor Destroy; override;
    function GetRecordCount: Integer; override;
    function GetValue(var AFree: Boolean): TValue; override;
    procedure NextRecord; override;
    procedure FirstRecord; override;
  end;

  TTypedListValueGeneratorDelegate2<T, T1> = class(TTypedListValueGeneratorDelegate<T>)
  private
    function ConvertArray(AArray: TArray<T1>): TArray<T>;
  public
    constructor Create(AOptions: TGeneratorOptions; AValuesList: TArray<T1>);
  end;

  TDelegateValueGenerator = class(TValueGenerator)
  private
    FDelegate: TValueGeneratorDelegate;
  protected
    function GetRecordCount: Integer; override;
    function CreateDelegate: TValueGeneratorDelegate; virtual; abstract;
  public
    constructor Create(AFieldDef: TGeneratorFieldDef); override;
    procedure FirstRecord; override;
    procedure NextRecord; override;
    function GetValue(var AFree: Boolean): TValue; override;
    destructor Destroy; override;
  end;

  TValueGeneratorClass = class of TValueGenerator;

  TValueGeneratorDescription = record
  strict private
    FClassType: TValueGeneratorClass;
    FFormatFieldName: string;
    FUnitName: string;
  public
    constructor Create(AClassType: TValueGeneratorClass; const AFormatFieldName: string = ''; const AUnitName: string = '');
    property ClassType: TValueGeneratorClass read FClassType;
    // String used to Format a field name (e.g.; 'StringField%d')
    property FormatFieldName: string read FFormatFieldName;
    // Used at design time to add to uses list
    property UnitName: string read FUnitName;
  end;

  TCustomFormatObject = class
  protected
    function GetTValue: TValue; virtual; abstract;
    procedure SetTValue(const AValue: TValue); virtual; abstract;
  end;

  TTypedCustomFormatObject<T> = class(TCustomFormatObject)
  private
    FValue: T;
    //constructor Create(const AValue: TValue); overload;
    constructor Create; overload;
    function GetValue: T;
    procedure SetValue(AValue: T);
  protected
    function GetTValue: TValue; override;
    procedure SetTValue(const AValue: TValue); override;
  public
    property V: T read GetValue write SetValue;
  end;

  TValueReaderFunc<T> = class(TValueReader<T>)
  private
    FGetValue: TFunc<string, T>;
    FName: string;
  public
    constructor Create(const AName: string; AGetValue: TFunc<string, T>);
    function GetValue: T; override;
  end;

  // Writer with an anonymous method
  TValueWriterProc<T> = class(TValueWriter<T>)
  private
    FSetValue: TProc<string,T>;
    FName: string;
  public
    constructor Create(const AName: string; ASetValue: TProc<string, T>);
    procedure SetValue(const AValue: T); override;
  end;

  TNameValueGeneratorDescriptionPair = TPair<string, TValueGeneratorDescription>;
  procedure RegisterValueGenerator(const AName: string; AFieldTypes: TGeneratorFieldTypes; const ADescription: TValueGeneratorDescription;
    const AFrameWorkExt: string = ''); overload;
  procedure RegisterValueGenerator(const AName: string; AFieldTypes: TGeneratorFieldTypes; AClass: TValueGeneratorClass; const AFrameworkExt: string = ''); overload;
  procedure UnRegisterValueGenerator(const AName: string; AFieldTypes: TGeneratorFieldTypes; const AFrameWorkExt: string);
  function GetRegisteredValueGenerators(AFieldType: TGeneratorFieldType): TArray<string>;
  function FindRegisteredValueGenerator(const AName: string; AFieldType: TGeneratorFieldType; var ADescription: TValueGeneratorDescription): Boolean;
  function FindRegisteredValueGenerators(const AName: string; AFieldType: TGeneratorFieldType): TArray<TNameValueGeneratorDescriptionPair>;
  procedure BindSourceAdapterError(const Message: string; Component: TComponent = nil);

const
  /// <summary>Modes which allow editing</summary>
  seEditModes = [seEdit, seInsert];

implementation

uses System.Math, Data.Bind.Consts, System.Bindings.CustomWrapper, System.Bindings.Factories,
  System.Bindings.Outputs, System.Bindings.Helper,
  System.Types, System.Bindings.ObjEval;


var
  // Lookup by framework, then name, then fieldtype
  GValueGenerators: TDictionary<string, TDictionary<string, TDictionary<TGeneratorFieldType, TValueGeneratorDescription>>>;


procedure RegisterValueGenerator(const AName: string; AFieldTypes: TGeneratorFieldTypes; AClass: TValueGeneratorClass;
    const AFrameWorkExt: string);
begin
  RegisterValueGenerator(AName, AFieldTypes, TValueGeneratorDescription.Create(AClass), AFrameworkExt);
end;

procedure RegisterValueGenerator(const AName: string; AFieldTypes: TGeneratorFieldTypes; const ADescription: TValueGeneratorDescription;
    const AFrameWorkExt: string);
var
  LNameDictionary: TDictionary<string, TDictionary<TGeneratorFieldType, TValueGeneratorDescription>>;
  LFieldTypeDictionary: TDictionary<TGeneratorFieldType, TValueGeneratorDescription>;
  LFieldType: TGeneratorFieldType;
begin
  if GValueGenerators = nil then
    GValueGenerators := TObjectDictionary<string, TDictionary<string, TDictionary<TGeneratorFieldType, TValueGeneratorDescription>>>.Create([doOwnsValues]);
  if not GValueGenerators.TryGetValue(AFrameWorkExt, LNameDictionary)  then
  begin
    LNameDictionary := TObjectDictionary<string, TDictionary<TGeneratorFieldType, TValueGeneratorDescription>>.Create([doOwnsValues]);
    GValueGenerators.Add(AFrameWorkExt, LNameDictionary);
  end;
  if not LNameDictionary.TryGetValue(AName, LFieldTypeDictionary)  then
  begin
    LFieldTypeDictionary := TDictionary<TGeneratorFieldType, TValueGeneratorDescription>.Create;
    LNameDictionary.Add(AName, LFieldTypeDictionary);
  end;
  for LFieldType in AFieldTypes do
  begin
    if not LFieldTypeDictionary.ContainsKey(LFieldType)  then
      LFieldTypeDictionary.Add(LFieldType, ADescription)
    else
      Assert(False);  // Duplicates
  end;
end;

procedure UnRegisterValueGenerator(const AName: string; AFieldTypes: TGeneratorFieldTypes; const AFrameWorkExt: string);
var
  LNameDictionary: TDictionary<string, TDictionary<TGeneratorFieldType, TValueGeneratorDescription>>;
  LFieldTypeDictionary: TDictionary<TGeneratorFieldType, TValueGeneratorDescription>;
  LFieldType: TGeneratorFieldType;
begin
  if GValueGenerators <> nil then
    if GValueGenerators.TryGetValue(AFrameWorkExt, LNameDictionary)  then
      if LNameDictionary.TryGetValue(AName, LFieldTypeDictionary) then
        for LFieldType in AFieldTypes do
          if LFieldTypeDictionary.ContainsKey(LFieldType) then
            LFieldTypeDictionary.Remove(LFieldType);
end;

function GetRegisteredValueGenerators(AFieldType: TGeneratorFieldType): TArray<string>;
var
  LList: TList<string>;
  LFrameworkPair: TPair<string, TDictionary<string, TDictionary<TGeneratorFieldType, TValueGeneratorDescription>>>;
  LNamePair: TPair<string, TDictionary<TGeneratorFieldType, TValueGeneratorDescription>>;
begin
  LList := TList<string>.Create;
  try
    if GValueGenerators <> nil then
      for LFrameworkPair in GValueGenerators do
      begin
        for LNamePair in LFrameworkPair.Value do
        begin
          if LNamePair.Value.ContainsKey(AFieldType) then
          begin
            // May be duplicates for fmx and vcl frameworks
            if not LList.Contains(LNamePair.Key) then
              LList.Add(LNamePair.Key);
          end;
        end;
      end;
    Result := LList.ToArray;
  finally
    LList.Free;
  end;
end;

function FindRegisteredValueGenerator(const AName: string; AFieldType: TGeneratorFieldType; var ADescription: TValueGeneratorDescription): Boolean;
var
  LDescriptions: TArray<TPair<string, TValueGeneratorDescription>>;
begin
  Result := False;
  LDescriptions := FindRegisteredValueGenerators(AName, AFieldType);
  if Length(LDescriptions) > 0 then
  begin
    ADescription := LDescriptions[0].Value;
    Result := True;
  end;
  // if duplicates for multiple frameworks, just pick first found
  // Data generated by different frameworks must be cross-framework compatible.
  // However, framework specific generators will be implemented using framework specific rtl.
end;


function FindRegisteredValueGenerators(const AName: string; AFieldType: TGeneratorFieldType): TArray<TPair<string, TValueGeneratorDescription>>;
var
  LList: TList<TPair<string, TValueGeneratorDescription>>;
  LFrameworkPair: TPair<string, TDictionary<string, TDictionary<TGeneratorFieldType, TValueGeneratorDescription>>>;
  LNameDictionary: TDictionary<string, TDictionary<TGeneratorFieldType, TValueGeneratorDescription>>;
  LFieldTypeDictionary: TDictionary<TGeneratorFieldType, TValueGeneratorDescription>;
  LDescription: TValueGeneratorDescription;
begin
  LList := TList<TPair<string, TValueGeneratorDescription>>.Create;
  try
    if GValueGenerators <> nil then
      for LFrameworkPair in GValueGenerators do
      begin
        LNameDictionary := LFrameworkPair.Value;
        if LNameDictionary.TryGetValue(AName, LFieldTypeDictionary) then
          if LFieldTypeDictionary.TryGetValue(AFieldType, LDescription) then
            LList.Add(TPair<string, TValueGeneratorDescription>.Create(LFrameworkPair.Key, LDescription));
      end;
    Result := LList.ToArray;
  finally
    LList.Free;
  end;
end;

{ TCustomBindScopeStrings }

procedure TBaseObjectBindSource.AddActiveChanged(LNotify: TNotifyEvent);
begin
  FActiveChanged.Add(LNotify);
end;

procedure TBaseObjectBindSource.AddDataSetChanged(LNotify: TNotifyEvent);
begin
  FDataSetChanged.Add(LNotify);
end;

procedure TBaseObjectBindSource.AddDataSetScrolled(LNotify: TNotifyDistanceEvent);
begin
  FDataSetScrolled.Add(LNotify);
end;

procedure TBaseObjectBindSource.AddEditingChanged(LNotify: TNotifyEvent);
begin
  FEditingChanged.Add(LNotify);
end;

type
  TBindSourceAdapterLinkImpl = class(TBindSourceAdapterLink)
  private
    FDeferEvaluate: Boolean;
    FField: TBindSourceAdapterField;
    FEditing: Boolean;
    FBindLink: IBindLink;
    FBindPosition: IBindPosition;
    FBindListUpdate: IBindListUpdate;
    FModified: Boolean;
    FRefreshNeeded: Boolean;
    function GetCanModify: Boolean;
    procedure DoDataChange(AField: TBindSourceAdapterField);
    function GetField: TBindSourceAdapterField;
    function GetFieldName: string;
    procedure UpdateField;
    procedure SetField(Value: TBindSourceAdapterField);
    procedure SetEditing(Value: Boolean);
  protected
    procedure RecordChanged(Field: TBindSourceAdapterField); override;
    procedure DataSetChanged; override;
    procedure DataSetScrolled(ADistance: Integer); override;
    procedure LayoutChanged; override;
    procedure ActiveChanged; override;
    procedure EditingChanged; override;
    procedure UpdateData; override;
    function Edit: Boolean; override;
  public
    constructor Create(ABindLink: IBindLink); overload;
    constructor Create(ABindPosition: IBindPosition); overload;
    constructor Create(ABindListUpdate: IBindListUpdate); overload;
    procedure SetModified;
    function GetIsModified: Boolean;
    procedure Reset;
    procedure RefreshNeeded;
    property CanModify: Boolean read GetCanModify;
    property Editing: Boolean read FEditing;
    property Field: TBindSourceAdapterField read GetField;
  end;

procedure TBaseObjectBindSource.AddExpression(AExpression: TBasicBindComponent);
var
  LBindLinkDataLink: TBindSourceAdapterLinkImpl;
  LBindLink: IBindLink;
  LBindPosition: IBindPosition;
begin
  inherited;
  if Supports(AExpression, IBindLink, LBindLink) then
  begin
    LBindLinkDataLink := TBindSourceAdapterLinkImpl.Create(LBindLink);
    FAdapterLinks.AddOrSetValue(AExpression,
      LBindLinkDataLink);
    LBindLinkDataLink.Adapter := Self.GetInternalAdapter;
  end
  else if Supports(AExpression, IBindPosition, LBindPosition) then
  begin
    LBindLinkDataLink := TBindSourceAdapterLinkImpl.Create(LBindPosition);
    FAdapterLinks.AddOrSetValue(AExpression,
      LBindLinkDataLink);
    LBindLinkDataLink.Adapter := Self.GetInternalAdapter;
  end;

end;

procedure TBaseObjectBindSource.ApplyUpdates;
begin
  if CheckAdapter then
    GetInternalAdapter.ApplyUpdates;
end;

constructor TBaseObjectBindSource.Create(AOwner: TComponent);
var
  LDataLink: TBindSourceAdapterLink;
begin
  inherited;
  FCheckRuntimeAdapter := True;
  LDataLink := TBindSourceAdapterLink.Create;
  FDataLink := LDataLink;
  FAdapterLinks := TObjectDictionary<TBasicBindComponent, TBindSourceAdapterLink>.Create([doOwnsValues]);
  FActiveChanged := TBindEventList.Create;
  FDataSetChanged := TBindEventList.Create;
  FEditingChanged := TBindEventList.Create;
  FDataSetScrolled := TBindEventList1<Integer>.Create;
  FAutoActivate := True;
  FAutoEdit := True;
end;

function TBaseObjectBindSource.CheckAdapter: Boolean;
var
  LAdapter: TBindSourceAdapter;
begin
  LAdapter := GetInternalAdapter;
  Result :=  (LAdapter <> nil) and
    LAdapter.CanActivate;
end;

procedure TBaseObjectBindSource.OnAdapterEdit(Sender: TObject; var Allow: Boolean);
begin
  Assert(False);
end;

procedure TBaseObjectBindSource.OnAdapterEditingChanged(
  Sender: TObject);
begin
  FEditingChanged.Send(Self);
end;

procedure TBaseObjectBindSource.OnAdapterDataSetChanged(Sender: TObject);
var
  ALink: TBindSourceAdapterLink;
begin
  FDataSetChanged.Send(Self);

  for ALink in FAdapterLinks.Values do
    ALink.DataSetChanged;
end;

procedure TBaseObjectBindSource.OnAdapterUpdateState(Sender: TObject);
var
  ALink: TBindSourceAdapterLink;
begin
  FActiveChanged.Send(Self);

  ActivateExpressions(Active);
  for ALink in FAdapterLinks.Values do
    ALink.UpdateState;
end;

procedure TBaseObjectBindSource.OnAdapterLayoutChanged(Sender: TObject);
begin
  Assert(False);
end;

procedure TBaseObjectBindSource.OnAdapterUpdateRecord(Sender: TObject);
var
  ALink: TBindSourceAdapterLink;
begin
  for ALink in FAdapterLinks.Values do
    ALink.UpdateRecord;
end;

procedure TBaseObjectBindSource.OnAdapterDataSetScrolled(Sender: TObject; ADistance: Integer);
var
  ALink: TBindSourceAdapterLink;
begin
  FDataSetScrolled.Send(Self,ADistance);
  for ALink in FAdapterLinks.Values do
    ALink.DataSetScrolled(ADistance);
end;

procedure TBaseObjectBindSource.OnAdapterRecordChanged(Sender: TObject; AField: TBindSourceAdapterField);
var
  ALink: TBindSourceAdapterLink;
begin
  for ALink in FAdapterLinks.Values do
    ALink.RecordChanged(AField);
end;

procedure TBaseObjectBindSource.Delete;
begin
  if CheckAdapter then
    GetInternalAdapter.Delete;
end;

destructor TBaseObjectBindSource.Destroy;
begin
  FDataLink.Free;
  // Free and clear in case we are called back during destruction
  FreeAndNil(FAdapterLinks);
  FreeAndNil(FActiveChanged);
  FreeAndNil(FDataSetChanged);
  FreeAndNil(FEditingChanged);
  FreeAndNil(FDataSetScrolled);
  FreeAndNil(FRuntimeAdapter);
  inherited;
end;

procedure TBaseObjectBindSource.DoCreateAdapter(
  var ADataObject: TBindSourceAdapter);
begin
  ADataObject := nil;
  if Assigned(FOnCreateAdapter) then
    FOnCreateAdapter(Self, ADataObject)
end;

procedure TBaseObjectBindSource.DoMemberRenamed(const CurName, PrevName: string);
var
  LBindComponent: TBasicBindComponent;
  LBindMemberChange: IBindMemberChange;
begin
  for LBindComponent in Expressions do
    if Supports(LBindComponent, IBindMemberChange, LBindMemberChange) then
    begin
      LBindMemberChange.MemberRenamed(Self, CurName, PrevName);
    end;
end;

procedure TBaseObjectBindSource.ConnectAdapter(AAdapter: TBindSourceAdapter);
var
  LCollectionEditorLink: TBindSourceAdapterLink;
begin
  Assert(AAdapter <> nil);
  if FConnectedAdapter = AAdapter then
    Exit;
  Assert(FConnectedAdapter = nil);
  if csDestroying in AAdapter.ComponentState then
    Exit;
  if csDestroying in ComponentState then
    Exit;
  if csLoading in ComponentState then
    Exit;
  if not AAdapter.HasScope(Self) then
  begin
    FConnectedAdapter := AAdapter;
    AAdapter.AddScope(Self);
    for LCollectionEditorLink in FAdapterLinks.Values do
      LCollectionEditorLink.Adapter := AAdapter;
    if AutoActivate then
      if (csDesigning in ComponentState) then
        if AAdapter.CanActivate then
          Active := True;
  end;
end;

procedure TBaseObjectBindSource.DisconnectAdapter(AAdapter: TBindSourceAdapter);
var
  LCollectionEditorLink: TBindSourceAdapterLink;
begin
  Assert(AAdapter <> nil);
  Assert((csDestroying in Self.ComponentState) or (csDestroying in AAdapter.ComponentState) or AAdapter.HasScope(Self));
  if Active then
  begin
    FConnectedAdapter := nil;
    OnAdapterUpdateState(Self);
  end
  else
    FConnectedAdapter := nil;
  Assert(Active = False);
  if (not (csDestroying in ComponentState)) and (not (csDestroying in AAdapter.ComponentState)) then // Already removed
    AAdapter.RemoveScope(Self);
  for LCollectionEditorLink in FAdapterLinks.Values do
    if LCollectionEditorLink.Adapter = AAdapter then
      LCollectionEditorLink.Adapter := nil;
end;

procedure TBaseObjectBindSource.DoMemberRenaming(const CurName, NewName: string);
var
  LBindComponent: TBasicBindComponent;
  LBindMemberChange: IBindMemberChange;
begin
  for LBindComponent in Expressions do
    if Supports(LBindComponent, IBindMemberChange, LBindMemberChange) then
    begin
      LBindMemberChange.MemberRenaming(Self, CurName, NewName);
    end;
end;

procedure TBaseObjectBindSource.Edit;
begin
  if CheckAdapter then
    GetInternalAdapter.Edit(True);  // Force
end;

function TBaseObjectBindSource.Edit(ABindComp: TBasicBindComponent): Boolean;
var
  LDataLink: TBindSourceAdapterLink;
begin
  if FAdapterLinks.TryGetValue(ABindComp, LDataLink) then
  begin
    Assert(LDataLink <> nil);
    Result := LDataLink.Edit
  end
  else
    Result := False;
end;

procedure TBaseObjectBindSource.First;
begin
  if CheckAdapter then
    GetInternalAdapter.First;
end;

procedure TBaseObjectBindSource.UpdateRecord(ABindComp: TBasicBindComponent);
var
  LDataLink: TBindSourceAdapterLink;
begin
  if FAdapterLinks.TryGetValue(ABindComp, LDataLink) then
  begin
    Assert(LDataLink <> nil);
    LDataLink.UpdateRecord;
  end
end;

procedure TBaseObjectBindSource.Reset(ABindComp: TBasicBindComponent);
var
  LDataLink: TBindSourceAdapterLink;
begin
  if FAdapterLinks.TryGetValue(ABindComp, LDataLink) then
  begin
    Assert(LDataLink <> nil);
    if LDataLink is TBindSourceAdapterLinkImpl then
      TBindSourceAdapterLinkImpl(LDataLink).Reset
  end
end;

procedure TBaseObjectBindSource.SetActive(const Value: Boolean);
begin
  if csLoading in ComponentState then
    FDeferActivate := Value
  else if Value <> Active then
  begin
    if Value then
    begin
      if CheckAdapter then
        GetInternalAdapter.Active := True;
    end
    else
      if GetInternalAdapter <> nil then
        GetInternalAdapter.Active := False;
    OnAdapterUpdateState(Self);
    if not Active then
      if not (csDestroying in ComponentState) then
        FCheckRuntimeAdapter := True; // Recheck later

  end;

end;


procedure TBaseObjectBindSource.UpdateAdapterChanged;
begin

end;

procedure TBaseObjectBindSource.UpdateAdapterChanging;
begin

end;

procedure TBaseObjectBindSource.SetAutoActivate(const Value: Boolean);
begin
  if FAutoActivate <> Value then
  begin
    FAutoActivate := Value;
    if not (csLoading in ComponentState) then
      if (csDesigning in ComponentState) then
        // While designing, active when enable
        Active := FAutoActivate;
  end;
end;

procedure TBaseObjectBindSource.SetField(ABindComp: TBasicBindComponent;
  const FieldName: string);
begin
//
end;

procedure TBaseObjectBindSource.SetItemIndex(const Value: Integer);
begin
  if CheckAdapter then
    GetInternalAdapter.ItemIndex := Value;
end;

procedure TBaseObjectBindSource.SetModified(ABindComp: TBasicBindComponent);
var
  LDataLink: TBindSourceAdapterLink;
begin
  if FAdapterLinks.TryGetValue(ABindComp, LDataLink) then
  begin
    Assert(LDataLink <> nil);
    if LDataLink is TBindSourceAdapterLinkImpl then
      TBindSourceAdapterLinkImpl(LDataLink).SetModified
  end
end;

procedure TBaseObjectBindSource.SetReadOnly(ABindComp: TBasicBindComponent;
  const Value: Boolean);
var
  LDataLink: TBindSourceAdapterLink;
begin
  if FAdapterLinks.TryGetValue(ABindComp, LDataLink) then
  begin
    Assert(LDataLink <> nil);
    if LDataLink is TBindSourceAdapterLinkImpl then
      TBindSourceAdapterLinkImpl(LDataLink).FReadOnly := Value;
  end
end;

function TBaseObjectBindSource.GetIsModified(ABindComp: TBasicBindComponent): Boolean;
var
  LDataLink: TBindSourceAdapterLink;
begin
  Result := False;
  if FAdapterLinks.TryGetValue(ABindComp, LDataLink) then
  begin
    Assert(LDataLink <> nil);
    if LDataLink is TBindSourceAdapterLinkImpl then
      Result := TBindSourceAdapterLinkImpl(LDataLink).GetIsModified
  end
end;

function TBaseObjectBindSource.GetIsEditing(ABindComp: TBasicBindComponent): Boolean;
var
  LDataLink: TBindSourceAdapterLink;
begin
  Result := False;
  if FAdapterLinks.TryGetValue(ABindComp, LDataLink) then
  begin
    Assert(LDataLink <> nil);
    if LDataLink is TBindSourceAdapterLinkImpl then
      Result := TBindSourceAdapterLinkImpl(LDataLink).Editing;
  end
end;

function TBaseObjectBindSource.GetCanApplyUpdates: Boolean;
begin
  if CheckAdapter then
    Result := GetInternalAdapter.CanApplyUpdates
  else
    Result := False;
end;

function TBaseObjectBindSource.GetCanCancelUpdates: Boolean;
begin
  if CheckAdapter then
    Result := GetInternalAdapter.CanCancelUpdates
  else
    Result := False;
end;

procedure TBaseObjectBindSource.Cancel;
begin
  if CheckAdapter then
    GetInternalAdapter.Cancel;
end;

procedure TBaseObjectBindSource.CancelUpdates;
begin
  if CheckAdapter then
    GetInternalAdapter.CancelUpdates;
end;

procedure TBaseObjectBindSource.ClearModified(ABindComp: TBasicBindComponent);
var
  LDataLink: TBindSourceAdapterLink;
begin
  if (FAdapterLinks <> nil) and FAdapterLinks.TryGetValue(ABindComp, LDataLink) then
  begin
    Assert(LDataLink <> nil);
    if LDataLink is TBindSourceAdapterLinkImpl then
      TBindSourceAdapterLinkImpl(LDataLink).FModified := False;
  end
end;

function TBaseObjectBindSource.GetCanModify(ABindComp: TBasicBindComponent): Boolean;
var
  LDataLink: TBindSourceAdapterLink;
begin
  Result := False;
  if FAdapterLinks.TryGetValue(ABindComp, LDataLink) then
  begin
    Assert(LDataLink <> nil);
    if LDataLink is TBindSourceAdapterLinkImpl then
      Result := TBindSourceAdapterLinkImpl(LDataLink).CanModify
  end
end;

function TBaseObjectBindSource.GetActive: Boolean;
begin
   Result := (FConnectedAdapter <> nil) and (FConnectedAdapter.Active)
end;

function TBaseObjectBindSource.GetInternalAdapter: TBindSourceAdapter;
begin
  Result := nil;
end;

procedure TBaseObjectBindSource.SetRuntimeAdapter(AAdapter: TBindSourceAdapter);
begin
  SetInternalAdapter(AAdapter,
    procedure(AScope: TBindSourceAdapter)
    begin
      if FRuntimeAdapter <> nil then
      begin
        if not (csDestroying in FRuntimeAdapter.ComponentState) then
          FreeAndNil(FRuntimeAdapter);
        if (AAdapter = nil) and not (csDestroying in ComponentState) then
          // Recheck
          FCheckRuntimeAdapter := True;
      end;
      FRuntimeAdapter := AAdapter;
      if FRuntimeAdapter <> nil then
      begin
        FRuntimeAdapter.FreeNotification(Self);
      end;
    end);
end;

function TBaseObjectBindSource.CheckRuntimeAdapter: Boolean;
var
  LAdapter: TBindSourceAdapter;
begin
  if FCheckRuntimeAdapter and (FRuntimeAdapter = nil) and not (csDestroying in ComponentState) then
  begin
    FCheckRuntimeAdapter := False;
    Self.DoCreateAdapter(LAdapter);
    if LAdapter <> nil then
      SetRuntimeAdapter(LAdapter);
  end;
  Result := FRuntimeAdapter <> nil;
end;

function TBaseObjectBindSource.GetBOF: Boolean;
begin
  if CheckAdapter then
    Result := GetInternalAdapter.BOF
  else
    Result := False;

end;

function TBaseObjectBindSource.GetCanModify: Boolean;
begin
  if CheckAdapter then
    Result := GetInternalAdapter.CanModify
  else
    Result := False;
end;

function TBaseObjectBindSource.GetCanDelete: Boolean;
begin
  if CheckAdapter then
    Result := GetInternalAdapter.CanDelete
  else
    Result := False;
end;

function TBaseObjectBindSource.GetCanInsert: Boolean;
begin
  if CheckAdapter then
    Result := GetInternalAdapter.CanInsert
  else
    Result := False;
end;

function TBaseObjectBindSource.GetCanRefresh: Boolean;
begin
  if CheckAdapter then
    Result := GetInternalAdapter.CanRefresh
  else
    Result := False;
end;

function TBaseObjectBindSource.GetCurrentRecord(const AMemberName: string): IScope;
begin
  if AMemberName <> '' then
    Result := GetMemberScope(AMemberName)
  else
    Result := GetScope;
end;

function TBaseObjectBindSource.GetEditing: Boolean;
begin
  if CheckAdapter then
    Result := GetInternalAdapter.State in seEditModes
  else
    Result := False
end;

function TBaseObjectBindSource.GetEnumerator(
  const AMemberName: string; ABufferCount: Integer): IScopeRecordEnumerator;
begin
  if not CheckAdapter then
    Result := nil;
  Result := GetInternalAdapter.GetEnumerator(AMemberName,
    function: IScope
    begin
      Result := GetScope;
    end,
    function(AMemberName: string): IScope
    begin
      Result := GetMemberScope(AMemberName);
    end);
end;

function TBaseObjectBindSource.GetEOF: Boolean;
begin
  if CheckAdapter then
    Result := GetInternalAdapter.Eof
  else
    Result := True;
end;

function TBaseObjectBindSource.GetSelected: Boolean;
begin
  if CheckAdapter then

    Result := GetInternalAdapter.ItemIndex <> -1
  else
    Result := True;
end;

function TBaseObjectBindSource.GetItemIndex: Integer;
begin
  if CheckAdapter then

    Result := GetInternalAdapter.ItemIndex
  else
    Result := -1;
end;

procedure TBaseObjectBindSource.GetLookupMemberNames(AList: TStrings);
begin
  if CheckAdapter then
    GetInternalAdapter.GetLookupMemberNames(AList);
end;

function TBaseObjectBindSource.GetMember(const AMemberName: string): TObject;
begin
  if CheckAdapter then
    Result := GetInternalAdapter.GetMember(AMemberName)
  else
    raise TBindCompException.Create(sNoBindSourceAdapter);
end;

function TBaseObjectBindSource.GetMemberGetter(const AMemberName: string;
  var AGetter: string): Boolean;
begin
  Result := False;
  if CheckAdapter then
    Result := GetInternalAdapter.GetMemberGetter(AMemberName, AGetter)
  else
    if (csDesigning in ComponentState) then
    begin
      AGetter := 'Value'; // do not localize
      Result := True;
    end;
end;

procedure TBaseObjectBindSource.GetMemberNames(AList: TStrings);
begin
  if CheckAdapter then
    GetInternalAdapter.GetMemberNames(AList)
end;

function TBaseObjectBindSource.GetMemberSetter(const AMemberName: string;
  var ASetter: string): Boolean;
begin
  Result := False;
  if CheckAdapter then
    Result := GetInternalAdapter.GetMemberSetter(AMemberName, ASetter)
  else
  begin
    if (csDesigning in ComponentState) then
    begin
      ASetter := 'Value'; // do not localize
      Result := True;
    end;
  end;
end;

function TBaseObjectBindSource.GetMemberType(const AMemberName: string;
  var AType: TScopeMemberType): Boolean;
begin
  AType := mtUnknown;
  Result := False;
  if CheckAdapter then
    Result := GetInternalAdapter.GetMemberType(AMemberName, AType)
  else
  begin
    if (csDesigning in ComponentState) then
    begin
      AType := mtText;
      Result := True;
    end;
  end;
end;

function TBaseObjectBindSource.GetPositionGetter(
  var AGetter: string; var ABase: Integer): Boolean;
begin
  AGetter := 'ItemIndex';  // Do not localize
  ABase := 0;
  Exit(True);
end;

function TBaseObjectBindSource.GetPositionSetter(

  var ASetter: string; var ABase: Integer): Boolean;
begin
  ASetter := 'ItemIndex'; // Do not localize
  ABase := 0;
  Exit(True);
end;

procedure TBaseObjectBindSource.GetRecord(ARow: Integer;
  const AMemberName: string; ACallback: TProc<IScope>);
begin
  GetRowMember(ARow, AMemberName,
    procedure(AObject: TObject)
    begin
      if AObject = nil then
        ACallback(nil)
      else
        ACallback(WrapObject(AObject));
    end);
end;

procedure TBaseObjectBindSource.GetRowMember(ARow: Integer; const AMemberName: string; ACallback: TProc<TObject>);
var
  LObject: TObject;
  LBindSourceAdapter: TBindSourceAdapter;
  LItemIndexOffset: Integer;
begin
  if CheckAdapter then
  begin
    LBindSourceAdapter := GetInternalAdapter;
    if AMemberName <> '' then
      LObject := LBindSourceAdapter.GetMember(AMemberName)
    else
      LObject := nil;
    LItemIndexOffset := LBindSourceAdapter.ItemIndexOffset;
    LBindSourceAdapter.ItemIndexOffset := ARow - LBindSourceAdapter.ItemIndex;
    try
      ACallBack(LObject);
    finally
      LBindSourceAdapter.ItemIndexOffset := LItemIndexOffset;
    end;
  end;
end;

function TBaseObjectBindSource.GetRuntimeAdapter: TBindSourceAdapter;
begin
  Result := FRuntimeAdapter;
end;

function TBaseObjectBindSource.GetValue: TObject;
begin
  if CheckAdapter then
    Result := GetInternalAdapter.GetValue
  else
    raise TBindCompException.Create(sNoBindSourceAdapter);

end;

procedure TBaseObjectBindSource.Loaded;
begin
  try
    inherited;
    if FDeferActivate or FAutoActivate then
      Active := True;
  except
    // Do not raise exception while loading
  end;
end;

function TBaseObjectBindSource.Lookup(const KeyFields: string;
  const KeyValues: TValue; const ResultFields: string): TValue;
begin
  if CheckAdapter then
    Result := AdapterLookup(KeyFields, KeyValues, ResultFields);
end;

function TBaseObjectBindSource.Locate(const KeyFields: string;
  const KeyValues: TValue): Boolean;
begin
  Result := False;
  if CheckAdapter then
    Result := AdapterLocate(KeyFields, KeyValues);
end;

function TBaseObjectBindSource.AdapterLocate(const KeyFields: string; const KeyValues: TValue): Boolean;
var
  LEnumerator: IScopeRecordEnumerator;
  LIndex: Integer;
begin
  Result := False;
  LIndex := -1;
  LEnumerator := GetEnumerator('', -1);  // Need auto buffer count
  if LEnumerator = nil then
    Exit;
  LEnumerator.First;
  Result := AdapterFindValues(LEnumerator, KeyFields, KeyValues,
    procedure(AIndex: Integer; AValue: TValue)
    begin
      LIndex := AIndex;
    end);
  LEnumerator := nil;

  if Result  then
  begin
    Assert(LIndex >= 0);
    Assert(LIndex < GetInternalAdapter.GetCount);
    GetInternalAdapter.ItemIndex := LIndex;
  end;
end;

function TBaseObjectBindSource.AdapterLookup(const KeyFields: string; const KeyValues: TValue;
  const ResultFields: string): TValue;
var
  LEnumerator: IScopeRecordEnumerator;
  LValueMemberName: string;
  LResult: TValue;
  LValueExpression: TBindingExpression;
  LIValueValue: IValue;
  LValueScope: IScope;
begin
  LResult := TValue.Empty;
  if not GetMemberGetter(ResultFields, LValueMemberName) then
    Exit;
  LEnumerator := GetEnumerator('', -1);  // Need auto buffer count
  if LEnumerator = nil then
    Exit;
  LEnumerator.First;
  AdapterFindValues(LEnumerator, KeyFields, KeyValues,
    procedure(AIndex: Integer; AValue: TValue)
    begin
      LValueScope := LEnumerator.GetMemberCurrent(ResultFields);
      LValueExpression := TBindings.CreateExpression(
        LValueScope,
        LValueMemberName,
        TBindingEventRec.Create(TBindingEvalErrorEvent(nil) (*DoOnEvalError*)));
      try
        LIValueValue := LValueExpression.Evaluate;
        LResult := LIValueValue.GetValue;
      finally
        LValueExpression.Free;
      end;
    end);
  LEnumerator := nil;
  Result := LResult;
end;

function TBaseObjectBindSource.AdapterFindValues(LEnumerator: IScopeRecordEnumerator;
  const KeyFields: string; const KeyValues: TValue;
  AProc: TProc<Integer, TValue>): Boolean;

  function SameValue(const AValue1, AValue2: TValue): Boolean;
  begin
    Result := False;
    try
      if AValue1.IsEmpty or AValue2.IsEmpty then
        Result := AValue1.IsEmpty and AValue2.IsEmpty
      else if (AValue1.TypeInfo.Kind = tkInteger) and (AValue2.TypeInfo.Kind = tkInteger) then
      begin
        if AValue1.IsType<uint64> or AValue2.IsType<uint64> then
          Result := AValue1.AsType<uint64> = AValue2.AsType<uint64>
        else
          Result := AValue1.AsType<int64> = AValue2.AsType<int64>;
      end
      else
        Result := AValue1.ToString = AValue2.ToString
    except
    end;
  end;
var
  LKeyMemberName: string;
  LKeyExpression: TBindingExpression;
  LIKeyValue: IValue;
  LKeyScope: IScope;
  LIndex: Integer;
  LKeyValue: TValue;
begin
  Result := False;
  if LEnumerator = nil then
    Exit;
  if not GetMemberGetter(KeyFields, LKeyMemberName) then
    Exit;
  LKeyScope := LEnumerator.GetMemberCurrent(KeyFields);
  LKeyExpression := TBindings.CreateExpression(
    LKeyScope,
    LKeyMemberName,
    TBindingEventRec.Create(TBindingEvalErrorEvent(nil) (*DoOnEvalError*)));
  try
    LIndex := 0;
    while LEnumerator.MoveNext do
    begin
      LIKeyValue := LKeyExpression.Evaluate;
      LKeyValue := LIKeyValue.GetValue;
      if SameValue(LKeyValue, KeyValues) then
      begin
        Result := True;
        AProc(LIndex, LKeyValue);
        break;
      end;
      Inc(LIndex);
    end;
  finally
    LKeyExpression.Free;
  end;
end;

procedure TBaseObjectBindSource.Insert;
begin
  if CheckAdapter then
    GetInternalAdapter.Insert;
end;

function TBaseObjectBindSource.IsRequired(const AFieldName: string): Boolean;
begin
  Result := True;  // null scaler types not supported
end;

function TBaseObjectBindSource.IsValidChar(const AFieldName: string;
  const AChar: Char): Boolean;
begin
  Result := False;
  if CheckAdapter then
    Result := GetInternalAdapter.IsValidChar(AFieldName, AChar);
end;

procedure TBaseObjectBindSource.Last;
begin
  if CheckAdapter then
    GetInternalAdapter.Last;
end;

procedure TBaseObjectBindSource.Next;
begin
  if CheckAdapter then
    GetInternalAdapter.Next;
end;

procedure TBaseObjectBindSource.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation = TOperation.opRemove then
  begin
    if AComponent = FRuntimeAdapter then
      SetRuntimeAdapter(nil);
    if AComponent = FConnectedAdapter then
      FConnectedAdapter := nil;
    if AComponent is TBasicBindComponent then
      if FAdapterLinks.ContainsKey(TBasicBindComponent(AComponent)) then
        FAdapterLinks.Remove(TBasicBindComponent(AComponent));
  end;
end;

procedure TBaseObjectBindSource.PosChanging(ABindComp: TBasicBindComponent);
begin
  if CheckAdapter then
    GetInternalAdapter.PosChanging;
end;

procedure TBaseObjectBindSource.Post;
begin
  if CheckAdapter then
    GetInternalAdapter.Post;
end;

procedure TBaseObjectBindSource.Prior;
begin
  if CheckAdapter then
    GetInternalAdapter.Prior;
end;

procedure TBaseObjectBindSource.Refresh;
begin
  if CheckAdapter then
    GetInternalAdapter.Refresh;
end;

procedure TBaseObjectBindSource.RemoveActiveChanged(LNotify: TNotifyEvent);
begin
  if Assigned(FActiveChanged) then
    FActiveChanged.Remove(LNotify);
end;

procedure TBaseObjectBindSource.RemoveDataSetChanged(LNotify: TNotifyEvent);
begin
  if Assigned(FDataSetChanged) then
    FDataSetChanged.Remove(LNotify);
end;

procedure TBaseObjectBindSource.RemoveDataSetScrolled(LNotify: TNotifyDistanceEvent);
begin
  if Assigned(FDataSetScrolled) then
    FDataSetScrolled.Remove(LNotify);
end;

procedure TBaseObjectBindSource.RemoveEditingChanged(LNotify: TNotifyEvent);
begin
  if Assigned(FEditingChanged) then
    FEditingChanged.Remove(LNotify);
end;

procedure TBaseObjectBindSource.RemoveExpression(AExpression: TBasicBindComponent);
begin
  inherited;
  if not (csDestroying in ComponentState) then
    if Assigned(FAdapterLinks) then
      FAdapterLinks.Remove(AExpression);

end;

procedure TBaseObjectBindSource.SetInternalAdapter(const Value: TBindSourceAdapter;
  AAssignProc: TProc<TBindSourceAdapter>);
begin
  Assert(Assigned(AAssignProc));
  if InternalAdapter <> Value then
  begin
    if FConnectedAdapter <> nil then
    begin
      DisconnectAdapter(FConnectedAdapter)
    end;
    try
      UpdateAdapterChanging;
    finally
      AAssignProc(Value);
    end;
    UpdateAdapterChanged;
  end;
end;


{ TCustomAdapterBindSource }

destructor TCustomAdapterBindSource.Destroy;
begin
  Adapter := nil;
  inherited;
end;

function TCustomAdapterBindSource.GetInternalAdapter: TBindSourceAdapter;
begin
  if CheckRuntimeAdapter then
    Result := GetRuntimeAdapter
  else
    Result := FAdapter;
  if Result <> nil then
    ConnectAdapter(Result);
end;

procedure TCustomAdapterBindSource.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation = TOperation.opRemove then
  begin
    if AComponent = FAdapter then
    begin
      if GetInternalAdapter = FAdapter then
        SetAdapter(nil)
      else
        FAdapter := nil;
    end;
  end;
end;

procedure TCustomAdapterBindSource.SetAdapter(Value: TBindSourceAdapter);
begin
  if Value <> nil then
    Value.RemoveFreeNotification(Self);
  SetInternalAdapter(Value,
    procedure(AScope: TBindSourceAdapter)
    begin
      FAdapter := Value;
      if FAdapter <> nil then
        FAdapter.FreeNotification(Self);
      if InternalAdapter <> nil then
      begin
        ConnectAdapter(InternalAdapter);
      end;
   end);
end;


{ TCustomPrototypeBindSource }



function TCustomPrototypeBindSource.GetAutoEdit: Boolean;
begin
  Result := FDataGenerator.AutoEdit;
end;

function TCustomPrototypeBindSource.GetAutoPost: Boolean;
begin
  Result := FDataGenerator.AutoPost;
end;

function TCustomPrototypeBindSource.GetFieldDefs: TGeneratorFieldDefs;
begin
  Result := FDataGenerator.FieldDefs;
end;

function TCustomPrototypeBindSource.GetInternalAdapter: TBindSourceAdapter;
begin
  if CheckRuntimeAdapter then
    Result := GetRuntimeAdapter
  else if FAdapter <> nil then
    Result := FAdapter
  else
    Result := FDataGenerator;
  if (Result <> nil) and (not (csDestroying in Result.ComponentState)) then
  begin
    ConnectAdapter(Result);
  end;
end;

function TCustomPrototypeBindSource.GetRecordCount: Integer;
begin
  Result := FDataGenerator.RecordCount;
end;

procedure TCustomPrototypeBindSource.SetAutoEdit(const Value: Boolean);
begin
  FDataGenerator.AutoEdit := Value;
end;

procedure TCustomPrototypeBindSource.SetAutoPost(const Value: Boolean);
begin
  FDataGenerator.AutoPost := Value;
end;

procedure TCustomPrototypeBindSource.SetFieldDefs(
  const Value: TGeneratorFieldDefs);
begin
  FDataGenerator.FieldDefs := Value;
end;

procedure TCustomPrototypeBindSource.SetRecordCount(const Value: Integer);
begin
  FDataGenerator.RecordCount := Value;
end;

constructor TCustomPrototypeBindSource.Create(AOwner: TComponent);
begin
  inherited;
  FAutoEdit := True;
  FDataGenerator := TCustomDataGeneratorAdapter.Create(Self); // No free needed, Owned by Self
end;


{ TBindSourceAdapter }

procedure TBindSourceAdapter.Cancel;
var
  LField: TBindSourceAdapterField;
  LLink: TBindSourceAdapterLink;
begin
  case State of
    seEdit, seInsert:
    begin
      DoBeforeCancel;
      for LLink in FLinks do
        if LLink is TBindSourceAdapterLinkImpl then
          TBindSourceAdapterLinkImpl(LLink).FDeferEvaluate := True;
      try
      for LField in FFields do
      begin
        LField.Cancel;
      end;
      finally
        for LLink in FLinks do
          if LLink is TBindSourceAdapterLinkImpl then
            TBindSourceAdapterLinkImpl(LLink).FDeferEvaluate := False;
      end;
      SetState(seBrowse);
      DataSetChanged;
      DoAfterCancel;
    end;
  end;
end;

procedure TBindSourceAdapter.Refresh;
var
  LLink: TBindSourceAdapterLink;
begin
  CheckBrowseMode;
  DoBeforeRefresh;
  ResetNeeded;  // Refresh grids
  for LLink in FLinks do
    if LLink is TBindSourceAdapterLinkImpl then
      TBindSourceAdapterLinkImpl(LLink).FDeferEvaluate := True;
  try
  InternalRefresh;
  finally
    for LLink in FLinks do
      if LLink is TBindSourceAdapterLinkImpl then
        TBindSourceAdapterLinkImpl(LLink).FDeferEvaluate := False;
  end;
  DataSetChanged;
  DoAfterRefresh;
end;

procedure TBindSourceAdapter.CancelUpdates;
begin
  CheckBrowseMode;
  DoBeforeCancelUpdates;
  CheckOperation(InternalCancelUpdates, FOnCancelUpdatesError);
  DataSetChanged;
  DoAfterCancelUpdates;
end;

procedure TBindSourceAdapter.ClearFields;
begin
  FFields.Clear;
end;

constructor TBindSourceAdapter.Create(AOwner: TComponent);
begin
  inherited;
  FAutoEdit := True;
  FScopes := TList<TBaseObjectBindSource>.Create;
  FFields := TObjectList<TBindSourceAdapterField>.Create; // Owned
  FLinks := TObjectList<TBindSourceAdapterLink>.Create(False); // not Owned
  FItemIndex := 0;
  FItemIndexOffset := 0;
end;

procedure TBindSourceAdapter.Delete;
var
  LItemIndex: Integer;
  LDeleted: Boolean;
begin
  if ItemIndex <> -1 then
  begin
    DoBeforeDelete;
    LItemIndex := ItemIndex;
    CheckOperation(
      procedure begin LDeleted := Self.DeleteAt(ItemIndex) end,
      FOnDeleteError);
    if LDeleted then
    begin
      if LItemIndex >= Self.GetCount then
      begin
        LItemIndex := Self.GetCount - 1;
        ItemIndex := Max(0, LItemIndex);
      end;
      DataSetChanged;
     end;
      DoAfterDelete;

  end;
end;

function TBindSourceAdapter.DeleteAt(AIndex: Integer): Boolean;
begin
  Assert(False);
  Result := False;
end;

destructor TBindSourceAdapter.Destroy;
begin
  FFields.Free;
  FLinks.Free;
  FScopes.Free;
  inherited;
end;

procedure BindSourceAdapterError(const Message: string; Component: TComponent = nil);
begin
  if Assigned(Component) and (Component.Name <> '') then
  begin
    if (csSubComponent in Component.ComponentStyle) and (Component.Owner <> nil) and
      (Component.Owner.Name <> '') then
      raise EBindCompError.Create(Format('%s.%s: %s', [Component.Owner.Name, Component.Name, Message]))
    else
      raise EBindCompError.Create(Format('%s: %s', [Component.Name, Message]))
  end
  else
    raise EBindCompError.Create(Message);
end;

procedure TBindSourceAdapter.CheckCanModify;
begin
  if not CanModify then BindSourceAdapterError(SDataSourceReadOnly, Self);
end;

procedure TBindSourceAdapter.CheckActive;
begin
  if State = seInactive then BindSourceAdapterError(SDataSourceClosed, Self);
end;

procedure TBindSourceAdapter.CheckBrowseMode;
begin
  CheckActive;
  case State of
    seEdit, seInsert:
      begin
        UpdateRecord;
        if Modified then Post else Cancel;
      end;
  end;
end;

procedure TBindSourceAdapter.Edit(AForce: Boolean);
begin
  if  (ItemIndex >= 0) and ((AForce or AutoEdit) and not(State in [seEdit, seInsert])) then // and not Inserting then
  begin
    if GetCount = 0 then Insert else
    begin
      CheckBrowseMode;
      CheckCanModify;
      DoBeforeEdit;
      CheckOperation(InternalEdit, FOnEditError);
      SetState(seEdit);
      DoAfterEdit;
    end;
  end;

end;

procedure TBindSourceAdapter.InternalApplyUpdates;
begin

end;

procedure TBindSourceAdapter.InternalCancelUpdates;
begin

end;

procedure TBindSourceAdapter.InternalEdit;
begin
end;

procedure TBindSourceAdapter.InternalRefresh;
begin
end;


procedure TBindSourceAdapter.AddScope(Value: TBaseObjectBindSource);
begin
  FScopes.Add(Value);
end;

procedure TBindSourceAdapter.RemoveScope(Value: TBaseObjectBindSource);
begin
  FScopes.Remove(Value);
end;

procedure TBindSourceAdapter.ResetNeeded;
var
  LLink: TBindSourceAdapterLink;
begin
  for LLink in FLinks do
    if LLink is TBindSourceAdapterLinkImpl then
      TBindSourceAdapterLinkImpl(LLink).RefreshNeeded;
end;

function TBindSourceAdapter.HasScope(Value: TBaseObjectBindSource): Boolean;
begin
  Result := FScopes.Contains(Value);
end;

procedure TBindSourceAdapter.SetState(Value: TBindSourceAdapterState);
var
  LScope: TBaseObjectBindSource;
begin
  if FState <> Value then
  begin
    FState := Value;
    FModified := False;
    for LScope in FScopes do
    begin
      LScope.OnAdapterUpdateState(Self);
    end;
  end;
end;

function TBindSourceAdapter.SupportsNestedFields: Boolean;
begin
  Result := False;
end;

procedure TBindSourceAdapter.First;
var
  LNewIndex: Integer;
begin
  LNewIndex := GetItemIndex;
  if GetCount >= 1 then
    LNewIndex := 0;
  if GetItemIndex <> LNewIndex then
  begin
    ItemIndex := LNewIndex;
  end;
end;

function TBindSourceAdapter.GetBOF: Boolean;
begin
  Result := ItemIndex <= 0;
end;

function TBindSourceAdapter.GetCanModify: Boolean;
begin
  Result := False;
end;

function TBindSourceAdapter.GetCanRefresh: Boolean;
begin
  Result := True;
end;

function TBindSourceAdapter.GetCanInsert: Boolean;
begin
  Result := False;
end;

function TBindSourceAdapter.GetCanActivate: Boolean;
begin
  Result := True;
end;

function TBindSourceAdapter.GetCanApplyUpdates: Boolean;
begin
  Result := False;
end;

function TBindSourceAdapter.GetCanCancelUpdates: Boolean;
begin
  Result := False;
end;

function TBindSourceAdapter.GetCanDelete: Boolean;
begin
  Result := False;
end;

function TBindSourceAdapter.GetCount: Integer;
begin
  Assert(False); // Should be implemented by descendent
  Result := 1;
end;

function TBindSourceAdapter.GetItemIndex: Integer;
begin
  Result := FItemIndex;
end;

procedure TBindSourceAdapter.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation = TOperation.opRemove then
  begin
    if AComponent is TBaseObjectBindSource then
      if FScopes.Contains(TBaseObjectBindSource(AComponent)) then
        FScopes.Remove(TBaseObjectBindSource(AComponent));
  end;
end;

procedure TBindSourceAdapter.AutoEditField(AField: TBindSourceAdapterField);
begin
  Edit(True);
end;

procedure TBindSourceAdapter.AutoPostField(AField: TBindSourceAdapterField);
begin
  Inc(FUpdatingRecords);
  try
    PostFields(TArray<TBindSourceAdapterField>.Create(AField));
  finally
    Dec(FUpdatingRecords);
  end;
end;

procedure TBindSourceAdapter.PostFields(AFields: TArray<TBindSourceAdapterField>);
var
  LBuffered: Boolean;
  LField: TBindSourceAdapterField;
begin
  UpdateRecord;
  case State of
    seEdit, seInsert:
      begin
        DoBeforePostFields(AFields);
        CheckOperation(
          procedure
          var
            LField: TBindSourceAdapterField;
          begin
            for LField in AFields do
            begin
              LField.Post;
            end;
          end,
          FOnPostError); // FOnPostFieldError);
        LBuffered := False;
        for LField in  Fields do
          if LField.IsBuffered then
          begin
            LBuffered := True;
            break;
          end;
        if not LBuffered then
        begin
          // Not pending changes
          SetState(seBrowse);
          DataSetChanged;
        end
        else
          if Length(AFields) = 1 then
            RecordChanged(AFields[0])
          else
            RecordChanged(nil);
        DoAfterPostFields(AFields);
      end;
  end;
end;

function TBindSourceAdapter.GetItemIndexOffset: Integer;
begin
  Result := FItemIndexOffset;
end;

function TBindSourceAdapter.GetCurrent: TObject;
begin
  Result := Self;
end;

function TBindSourceAdapter.GetCurrentIndex: Integer;
begin
  Result := ItemIndex + ItemIndexOffset;
end;

function TBindSourceAdapter.GetCurrentRecord(const AMemberName: string): IScope;
begin
  Assert(False);
  Result := nil;
end;

type
  TBindSourceAdapterEnumerator = class(TInterfacedObject, IScopeRecordEnumerator, IScopeRecordEnumeratorCount,
    IScopeRecordEnumeratorStatus,  IScopeRecordEnumeratorEvalShortcut)
  private
    FBindSourceAdapter: TBindSourceAdapter;
    FMemberName: string;
    FNextRecord: Integer;
    FGetScope: TFunc<IScope>;
    FGetMemberScope: TFunc<string, IScope>;
    FMultiRecordChange: Boolean;
    { IScopeRecordEnumeratorEvalShortcut }
    procedure GetMemberValue(const AMemberName: string;  const AType: TScopeMemberType;
      const ACallback: TValueCallback); overload;
    function GetMemberValue(const AMemberName: string; const ATypes: array of TScopeMemberType; out AValue: TValue): Boolean; overload;
    function CanGetMemberValue(const AMemberName: string; AType: TScopeMemberType): Boolean;
//    function GetSupportedTypes(AType: TScopeMemberType): TScopeMemberTypes;
  public
    constructor Create(ABindScope: TBindSourceAdapter; const AMemberName: string;
     AGetScope: TFunc<IScope>; AGetMemberScope: TFunc<string, IScope>);
    destructor Destroy; override;
    procedure First;
    function GetCurrent: IScope;
    function GetRecordCount: Integer;
    function GetMemberCurrent(const AMemberName: string): IScope;
    function GetMultiRecordChange: Boolean;
    function MoveNext: Boolean;
    property Current: IScope read GetCurrent;
  end;

constructor TBindSourceAdapterEnumerator.Create(ABindScope: TBindSourceAdapter;
  const AMemberName: string; AGetScope: TFunc<IScope>; AGetMemberScope: TFunc<string, IScope>);
begin
  Assert(ABindScope <> nil);
  FBindSourceAdapter := ABindScope;
  FMemberName := AMemberName;
  Assert(FBindSourceAdapter.ItemIndexOffset = 0); //
  FNextRecord := FBindSourceAdapter.ItemIndex;
  FBindSourceAdapter.ItemIndexOffset := FNextRecord - FBindSourceAdapter.ItemIndex;
  FGetScope := AGetScope;
  FGetMemberScope := AGetMemberScope;
end;

destructor TBindSourceAdapterEnumerator.Destroy;
begin
  FBindSourceAdapter.ItemIndexOffset := 0;
  inherited;
end;

procedure TBindSourceAdapterEnumerator.First;
begin
  FNextRecord := 0;
  FBindSourceAdapter.ItemIndexOffset := FNextRecord - FBindSourceAdapter.ItemIndex;
end;

function TBindSourceAdapterEnumerator.GetCurrent: IScope;
begin
  if FMemberName <> '' then
    Result := FGetMemberScope(FMemberName)
  else
    Result := FGetScope;
end;

function TBindSourceAdapterEnumerator.GetMemberCurrent(const AMemberName: string): IScope;
begin
  if AMemberName <> '' then
    Result := FGetMemberScope(AMemberName)
  else
    Result := GetCurrent;
end;

type
  TConvertFunc = function(const ASource: TValue; AType: TScopeMemberType; out AResult: TValue): Boolean;

function ConvNone(const ASource: TValue; AType: TScopeMemberType; out AResult: TValue): Boolean;
begin
  AResult := ASource;
  Result := True;
end;

function ConvFail(const ASource: TValue; AType: TScopeMemberType; out AResult: TValue): Boolean;
begin
  Result := False;
end;

function ConvToText(const ASource: TValue; AType: TScopeMemberType; out AResult: TValue): Boolean;
begin
  AResult := ASource.ToString;
  Result := True;
end;

function ConvTextToInteger(const ASource: TValue; AType: TScopeMemberType; out AResult: TValue): Boolean;
begin
  case AType of
    mtInteger: 
      TConverterUtils.StringToInteger(ASource, TypeInfo(Int64), AResult);
    mtUInteger:
      TConverterUtils.StringToInteger(ASource, TypeInfo(UInt64), AResult);
  else
    Assert(False);
  end;
  Result := True;
end;

function ConvTextToFloat(const ASource: TValue; AType: TScopeMemberType; out AResult: TValue): Boolean;
begin
  case AType of
    mtFloat: 
      TConverterUtils.StringToFloat(ASource, TypeInfo(Extended), AResult);
    mtCurrency: 
      TConverterUtils.StringToFloat(ASource, TypeInfo(Currency), AResult);
  else
    Assert(False);
  end;
  Result := True;
end;

function ConvTextToBoolean(const ASource: TValue; AType: TScopeMemberType; out AResult: TValue): Boolean;
begin
  TConverterUtils.StringToBool(ASource, AResult);
  Result := True;
end;

function ConvTextToDateTime(const ASource: TValue; AType: TScopeMemberType; out AResult: TValue): Boolean;
begin
  TConverterUtils.StringToDateTime(ASource, AResult);
  Result := True;
end;

function ConvTextToTime(const ASource: TValue; AType: TScopeMemberType; out AResult: TValue): Boolean;
begin
  TConverterUtils.StringToTime(ASource, AResult);
  Result := True;
end;

function ConvTextToDate(const ASource: TValue; AType: TScopeMemberType; out AResult: TValue): Boolean;
begin
  TConverterUtils.StringToDate(ASource, AResult);
  Result := True;
end;

function ConvTextToChar(const ASource: TValue; AType: TScopeMemberType; out AResult: TValue): Boolean;
begin
  TConverterUtils.StringToChar(ASource, AResult);
  Result := True;
end;

// Handle Integer, UInteger
function ConvFloatToInteger(const ASource: TValue; AType: TScopeMemberType; out AResult: TValue): Boolean;
begin
  case AType of
    mtInteger: 
      TConverterUtils.FloatToInteger(ASource, TypeInfo(Int64), AResult);
    mtUInteger: 
      TConverterUtils.FloatToInteger(ASource, TypeInfo(UInt64), AResult);
  else
    Assert(False);
  end;
  Result := True;
end;

function ConvBitmapToText(const ASource: TValue; AType: TScopeMemberType; out AResult: TValue): Boolean;
begin
  TConverterUtils.PersistentToString(ASource, AResult);
  Result := True;
end;

function ConvBitmapToObject(const ASource: TValue; AType: TScopeMemberType; out AResult: TValue): Boolean;
begin
  TConverterUtils.PersistentToPersistent(ASource, AResult);
  Result := True;
end;

function ConvMemoToText(const ASource: TValue; AType: TScopeMemberType; out AResult: TValue): Boolean;
begin
  TConverterUtils.StringsToString(ASource, AResult);
  Result := True;
end;

function ConvBooleanToText(const ASource: TValue; AType: TScopeMemberType; out AResult: TValue): Boolean;
begin
  TConverterUtils.BoolToString(ASource, AResult);
  Result := True;
end;

function ConvObjectToText(const ASource: TValue; AType: TScopeMemberType; out AResult: TValue): Boolean;
begin
  TConverterUtils.PersistentToString(ASource, AResult);
  Result := True;
end;

const
  Conversions: array[TScopeMemberType,TScopeMemberType] of TConvertFunc = ( // [source, target]
    // mtUnknown
    (
      // mtUnknown, mtText, mtInteger, mtFloat, mtBitmap,
      ConvNone, ConvFail, ConvFail, ConvFail, ConvFail,
      // mtMemo, mtBoolean, mtBCD, mtUInteger, mtDateTime,
      ConvFail, ConvFail, ConvFail, ConvFail, ConvFail,
      // mtCurrency, mtObject, mtVariant, mtDate, mtTime,
      ConvFail, ConvFail, ConvFail, ConvFail, ConvFail,
      // mtChar, mtTValue
      ConvFail, ConvFail
    ),
    // mtText
    (
      // mtUnknown, mtText, mtInteger, mtFloat, mtBitmap,
      ConvFail, ConvNone, ConvTextToInteger, ConvTextToFloat, ConvFail,
      // mtMemo, mtBoolean, mtBCD, mtUInteger, mtDateTime,
      ConvFail, ConvTextToBoolean, ConvFail, ConvFail, ConvTextToDateTime, 
      // mtCurrency, mtObject, mtVariant, mtDate, mtTime,
      ConvTextToFloat, ConvFail, ConvFail, ConvTextToDate, ConvTextToTime,
      // mtChar, mtTValue
      ConvTextToChar, ConvNone
    ),
    // mtInteger
    (
      // mtUnknown, mtText, mtInteger, mtFloat, mtBitmap,
      ConvFail, ConvToText, ConvNone, ConvNone, ConvFail,
      // mtMemo, mtBoolean, mtBCD, mtUInteger, mtDateTime,
      ConvFail, ConvFail, ConvFail, ConvFail, ConvFail,
      // mtCurrency, mtObject, mtVariant, mtDate, mtTime,
      ConvFail, ConvFail, ConvFail, ConvFail, ConvFail,
      // mtChar, mtTValue
      ConvFail, ConvNone
    ),
    // mtFloat
    (
      // mtUnknown, mtText, mtInteger, mtFloat, mtBitmap,
      ConvFail, ConvToText, ConvFloatToInteger, ConvNone, ConvFail,
      // mtMemo, mtBoolean, mtBCD, mtUInteger, mtDateTime,
      ConvFail, ConvFail, ConvFail, ConvFail, ConvFail,
      // mtCurrency, mtObject, mtVariant, mtDate, mtTime,
      ConvFail, ConvFail, ConvFail, ConvFail, ConvFail,
      // mtChar, mtTValue
      ConvFail, ConvNone
    ),
    // mtBitmap
    (
      // mtUnknown, mtText, mtInteger, mtFloat, mtBitmap,
      ConvFail, ConvBitmapToText, ConvFail, ConvFail, ConvNone,
      // mtMemo, mtBoolean, mtBCD, mtUInteger, mtDateTime,
      ConvFail, ConvFail, ConvFail, ConvFail, ConvFail,
      // mtCurrency, mtObject, mtVariant, mtDate, mtTime,
      ConvFail, ConvBitmapToObject, ConvFail, ConvFail, ConvFail,
      // mtChar, mtTValue
      ConvFail, ConvNone
    ),
    // mtMemo
    (
      // mtUnknown, mtText, mtInteger, mtFloat, mtBitmap,
      ConvFail, ConvMemoToText, ConvFail, ConvFail, ConvFail,
      // mtMemo, mtBoolean, mtBCD, mtUInteger, mtDateTime,
      ConvNone, ConvFail, ConvFail, ConvFail, ConvFail,
      // mtCurrency, mtObject, mtVariant, mtDate, mtTime,
      ConvFail, ConvFail, ConvFail, ConvFail, ConvFail,
      // mtChar, mtTValue
      ConvFail, ConvNone
    ),
    // mtBoolean
    (
      // mtUnknown, mtText, mtInteger, mtFloat, mtBitmap,
      ConvFail, ConvBooleanToText, ConvFail, ConvFail, ConvFail,
      // mtMemo, mtBoolean, mtBCD, mtUInteger, mtDateTime,
      ConvFail, ConvNone, ConvFail, ConvFail, ConvFail,
      // mtCurrency, mtObject, mtVariant, mtDate, mtTime,
      ConvFail, ConvFail, ConvFail, ConvFail, ConvFail,
      // mtChar, mtTValue
      ConvFail, ConvNone
    ),
    // mtBCD
    (
      // mtUnknown, mtText, mtInteger, mtFloat, mtBitmap,
      ConvFail, ConvToText, ConvTextToInteger, ConvTextToFloat, ConvFail,
      // mtMemo, mtBoolean, mtBCD, mtUInteger, mtDateTime,
      ConvFail, ConvFail, ConvNone, ConvFail, ConvFail,
      // mtCurrency, mtObject, mtVariant, mtDate, mtTime,
      ConvFail, ConvFail, ConvFail, ConvFail, ConvFail,
      // mtChar, mtTValue
      ConvFail, ConvToText
    ),
    // mtUInteger
    (
      // mtUnknown, mtText, mtInteger, mtFloat, mtBitmap,
      ConvFail, ConvToText, ConvNone, ConvNone, ConvFail,
      // mtMemo, mtBoolean, mtBCD, mtUInteger, mtDateTime,
      ConvFail, ConvFail, ConvFail, ConvNone, ConvFail,
      // mtCurrency, mtObject, mtVariant, mtDate, mtTime,
      ConvFail, ConvFail, ConvFail, ConvFail, ConvFail,
      // mtChar, mtTValue
      ConvFail, ConvNone
    ),
    // mtDateTime
    (
      // mtUnknown, mtText, mtInteger, mtFloat, mtBitmap,
      ConvFail, ConvToText, ConvFail, ConvFail, ConvFail,
      // mtMemo, mtBoolean, mtBCD, mtUInteger, mtDateTime,
      ConvFail, ConvFail, ConvFail, ConvFail, ConvNone,
      // mtCurrency, mtObject, mtVariant, mtDate, mtTime,
      ConvFail, ConvFail, ConvFail, ConvNone, ConvNone,
      // mtChar, mtTValue
      ConvFail, ConvNone
    ),
    // mtCurrency
    (
      // mtUnknown, mtText, mtInteger, mtFloat, mtBitmap,
      ConvFail, ConvToText, ConvFloatToInteger, ConvNone, ConvFail,
      // mtMemo, mtBoolean, mtBCD, mtUInteger, mtDateTime,
      ConvFail, ConvFail, ConvFail, ConvFail, ConvFail,
      // mtCurrency, mtObject, mtVariant, mtDate, mtTime,
      ConvFail, ConvFail, ConvFail, ConvFail, ConvFail,
      // mtChar, mtTValue
      ConvFail, ConvNone
    ),
    // mtObject
    (
      // mtUnknown, mtText, mtInteger, mtFloat, mtBitmap,
      ConvFail, ConvObjectToText, ConvFail, ConvFail, ConvFail,
      // mtMemo, mtBoolean, mtBCD, mtUInteger, mtDateTime,
      ConvFail, ConvFail, ConvFail, ConvFail, ConvFail,
      // mtCurrency, mtObject, mtVariant, mtDate, mtTime,
      ConvFail, ConvNone, ConvFail, ConvFail, ConvFail,
      // mtChar, mtTValue
      ConvFail, ConvNone
    ),
    // mtVariant
    (
      // mtUnknown, mtText, mtInteger, mtFloat, mtBitmap,
      ConvFail, ConvToText, ConvFail, ConvFail, ConvFail,
      // mtMemo, mtBoolean, mtBCD, mtUInteger, mtDateTime,
      ConvFail, ConvFail, ConvFail, ConvFail, ConvFail,
      // mtCurrency, mtObject, mtVariant, mtDate, mtTime,
      ConvFail, ConvFail, ConvFail, ConvFail, ConvFail,
      // mtChar, mtTValue
      ConvFail, ConvNone
    ),
    // mtDate
    (
      // mtUnknown, mtText, mtInteger, mtFloat, mtBitmap,
      ConvFail, ConvToText, ConvFail, ConvFail, ConvFail,
      // mtMemo, mtBoolean, mtBCD, mtUInteger, mtDateTime,
      ConvFail, ConvFail, ConvFail, ConvFail, ConvFail,
      // mtCurrency, mtObject, mtVariant, mtDate, mtTime,
      ConvFail, ConvFail, ConvFail, ConvNone, ConvNone,
      // mtChar, mtTValue
      ConvFail, ConvNone
    ),
    // mtTime
    (
      // mtUnknown, mtText, mtInteger, mtFloat, mtBitmap,
      ConvFail, ConvToText, ConvFail, ConvFail, ConvFail,
      // mtMemo, mtBoolean, mtBCD, mtUInteger, mtDateTime,
      ConvFail, ConvFail, ConvFail, ConvFail, ConvFail,
      // mtCurrency, mtObject, mtVariant, mtDate, mtTime,
      ConvFail, ConvFail, ConvFail, ConvNone, ConvNone,
      // mtChar, mtTValue
      ConvFail, ConvNone
    ),
    // mtChar
    (
      // mtUnknown, mtText, mtInteger, mtFloat, mtBitmap,
      ConvFail, ConvToText, ConvFail, ConvFail, ConvFail,
      // mtMemo, mtBoolean, mtBCD, mtUInteger, mtDateTime,
      ConvFail, ConvFail, ConvFail, ConvFail, ConvFail,
      // mtCurrency, mtObject, mtVariant, mtDate, mtTime,
      ConvFail, ConvFail, ConvFail, ConvFail, ConvFail,
      // mtChar, mtTValue
      ConvNone, ConvNone
    ),
    // mtTValue
    (
      // mtUnknown, mtText, mtInteger, mtFloat, mtBitmap,
      ConvFail, ConvNone, ConvNone, ConvNone, ConvNone,
      // mtMemo, mtBoolean, mtBCD, mtUInteger, mtDateTime,
      ConvFail, ConvNone, ConvFail, ConvFail, ConvNone,
      // mtCurrency, mtObject, mtVariant, mtDate, mtTime,
      ConvFail, ConvFail, ConvFail, ConvNone, ConvNone,
      // mtChar, mtTValue
      ConvFail, ConvNone
    )
  );

procedure TBindSourceAdapterEnumerator.GetMemberValue(const AMemberName: string; const AType: TScopeMemberType;
  const ACallback: TValueCallback);
const
  LObjectTypes: TScopeMemberTypes = [TScopeMemberType.mtObject, TScopeMemberType.mtBitmap];

var
  LMember: TObject;
  LMemberType: TScopeMemberType;
  LValue: TValue;
  LConverter: TConvertFunc;
  LResult: TValue;
begin
  LMember := FBindSourceAdapter.GetMember(AMemberName);
  if (LMember is TBindSourceAdapterField) and TBindSourceAdapterField(LMember).GetMemberType(LMemberType) then
  begin
    LConverter := Conversions[LMemberType, AType];
    LValue := TBindSourceAdapterField(LMember).GetTValue;
    Assert(@LConverter <> @ConvFail);
    if @LConverter <> @ConvNone then
    begin
      if LConverter(LValue, AType, LResult) then
        ACallback(LResult, AType)
      else
        Assert(False);
    end
    else
      ACallback(LValue, AType)
  end;
end;

function TBindSourceAdapterEnumerator.GetMemberValue(const AMemberName: string; const ATypes: array of TScopeMemberType; out AValue: TValue): Boolean;
const
  FloatTypes: TScopeMemberTypes = [TScopeMemberType.mtFloat, TScopeMemberType.mtCurrency, TScopeMemberType.mtBCD];
  IntegerTypes: TScopeMemberTypes = [TScopeMemberType.mtInteger, TScopeMemberType.mtUInteger];
var
  LMember: TObject;
  LType: TScopeMemberType;
  LValue: TValue;
  LMemberType: TScopeMemberType;
begin
  LType := TScopeMemberType.mtUnknown;
  LMember := FBindSourceAdapter.GetMember(AMemberName);
  Result := (LMember is TBindSourceAdapterField) and TBindSourceAdapterField(LMember).GetMemberType(LMemberType);
  if Result then
  begin
    for LType in ATypes do
    begin
      Result := (LType = LMemberType);
      if not Result then
        Result := (@Conversions[LMemberType, LType] = @ConvNone) and
          not ((LType in FloatTypes) and (LType in IntegerTypes));
      if Result then
        break;
    end;
    if not Result then
      for LType in ATypes do
      begin
        Result := @Conversions[LMemberType, LType] = @ConvNone;
        if Result then
          break;
      end;
    if not Result then
      for LType in ATypes do
      begin
        Result := LType = mtText;
        if Result then
          break;
      end;
    if Result then
    begin
      GetMemberValue(AMemberName, LType,
        procedure(const AValue: TValue; AType: TScopeMemberType)
        begin
          LValue := AValue;
        end);
      AValue := LValue;
    end;
  end;
end;

function TBindSourceAdapterEnumerator.CanGetMemberValue(const AMemberName: string; AType: TScopeMemberType): Boolean;
var
  LMember: TObject;
  LMemberType: TScopeMemberType;
  LConvertFunc: TConvertFunc;
begin
  LMember := FBindSourceAdapter.GetMember(AMemberName);
  Result := (LMember is TBindSourceAdapterField) and  TBindSourceAdapterField(LMember).GetMemberType(LMemberType);
  if Result then
  begin
    LConvertFunc := Conversions[LMemberType, AType];
    Result := @LConvertFunc <> @ConvFail;
  end;
end;

function TBindSourceAdapterEnumerator.GetMultiRecordChange: Boolean;
begin
  Result := FMultiRecordChange;
end;

function TBindSourceAdapterEnumerator.GetRecordCount: Integer;
begin
  Result := FBindSourceAdapter.GetCount;

end;

function TBindSourceAdapterEnumerator.MoveNext: Boolean;
begin
  if (FBindSourceAdapter.GetCount > 0) and (FNextRecord < FBindSourceAdapter.GetCount) then
  begin
    FBindSourceAdapter.ItemIndexOffset := FNextRecord - FBindSourceAdapter.ItemIndex;
    FNextRecord := FNextRecord + 1;
    Result := True;
  end
  else
    Result := False;
end;

procedure TBindSourceAdapter.AddLink(DataLink: TBindSourceAdapterLink);
begin
  FLinks.Add(DataLink);
  DataLink.FAdapter := Self;
  DataLink.UpdateState;
end;

procedure TBindSourceAdapter.RemoveLink(DataLink: TBindSourceAdapterLink);
begin
  DataLink.FAdapter := nil;
  FLinks.Remove(DataLink);
  DataLink.UpdateState;
end;

function TBindSourceAdapter.GetEmpty: Boolean;
begin
  Result := GetCount = 0;
end;

function TBindSourceAdapter.GetEnumerator(
  const AMemberName: string; AGetScope: TFunc<IScope>; AGetMemberScope: TFunc<string, IScope>): IScopeRecordEnumerator;
var
  LEnumerator: TBindSourceAdapterEnumerator;
begin
  LEnumerator := TBindSourceAdapterEnumerator.Create(Self, AMemberName,
    AGetScope, AGetMemberScope);
  LEnumerator.FMultiRecordChange := FResetNeeded;
  FResetNeeded := False;
  Result := LEnumerator;
end;

function TBindSourceAdapter.GetEOF: Boolean;
begin
  Result := (GetCount = 0) or (ItemIndex + 1 = GetCount);
end;

function TBindSourceAdapter.FindField(const AMemberName: string): TBindSourceAdapterField;
var
  LField: TBindSourceAdapterField;
  LFieldName, LPath: string;
  LPos: Integer;
begin
  if SupportsNestedFields then
  begin
    LPath := AMemberName;
    LPos := LPath.IndexOf('.') + 1;
    if LPos > 0 then
    begin
      LFieldName := LPath.Substring(0, LPos-1);
      LPath := LPath.Remove(0, LPos);
    end
    else
    begin
      LFieldName := LPath;
      LPath := '';
    end;
    end
  else
    LFieldName := AMemberName;
  for LField in FFields do
  begin
    if SameText(LField.MemberName, LFieldName) then
    begin
      if LPath <> '' then
        Exit(LField.FindField(LPath));
      Exit(LField);
    end;
  end;
  Result := nil;
end;

function TBindSourceAdapter.GetMember(const AMemberName: string): TObject;
begin
  Result := FindField(AMemberName);
end;

function TBindSourceAdapter.GetMemberGetter(const AMemberName: string;
  var AGetter: string): Boolean;
var
  LField: TBindSourceAdapterField;
begin
  LField := FindField(AMemberName);
  if LField <> nil then
    Result := LField.GetGetter(AGetter)
  else
    Result := False;
end;

procedure TBindSourceAdapter.GetMemberNames(AList: TStrings);
var
  LField: TBindSourceAdapterField;
begin
  AList.Clear;
  for LField in FFields do
    AList.Add(LField.MemberName);
end;

procedure TBindSourceAdapter.GetLookupMemberNames(AList: TStrings);
var
  LField: TBindSourceAdapterField;
begin
  AList.Clear;
  for LField in FFields do
    if not LField.IsObject then
      AList.Add(LField.MemberName);
end;

function TBindSourceAdapter.GetMemberSetter(const AMemberName: string;
  var ASetter: string): Boolean;
var
  LField: TBindSourceAdapterField;
begin
  LField := FindField(AMemberName);
  if LField <> nil then
    Result := LField.GetSetter(ASetter)
  else
    Result := False;
end;

function TBindSourceAdapter.IsValidChar(const AMemberName: string;
  const AChar: Char): Boolean;
var
  LField: TBindSourceAdapterField;
begin
  LField := FindField(AMemberName);
  if LField <> nil then
    Result := LField.IsValidChar(AChar)
  else
    Result := False;
end;

function TBindSourceAdapter.GetMemberType(const AMemberName: string;
  var AType: TScopeMemberType): Boolean;
var
  LField: TBindSourceAdapterField;
begin
  LField := FindField(AMemberName);
  if LField <> nil then
    Result := LField.GetMemberType(AType)
  else
    Result := False;
end;

function TBindSourceAdapter.GetScopes: TEnumerable<TBaseObjectBindSource>;
begin
  Result := FScopes;
end;

function TBindSourceAdapter.GetValue: TObject;
begin
  Result := Self;
end;

procedure TBindSourceAdapter.Insert;
var
  LIndex: Integer;
begin
  if (ItemCount > 0) and  (FItemIndex <> -1) then
  begin
    CheckBrowseMode;
    DoBeforeInsert;
    DoBeforeScroll;
    CheckOperation(
      procedure begin LIndex := InsertAt(FItemIndex + FItemIndexOffset) end,
      FOnInsertError);
    if LIndex >= 0 then
    begin
      SetState(seInsert);
      FEnteringEditState := True;
      try
        ItemIndex := LIndex;
        DataSetChanged;
      finally
        FEnteringEditState := False;
      end;
    end;
    DoAfterInsert;
    DoAfterScroll;
  end
  else
  begin
    Append;
  end;
end;

function TBindSourceAdapter.InsertAt(AIndex: Integer): Integer;
begin
  Assert(False);
  Result := -1;
end;

procedure TBindSourceAdapter.Append;
var
  LIndex: Integer;
begin
  CheckBrowseMode;
  DoBeforeInsert;
  DoBeforeScroll;
  CheckOperation(
    procedure begin LIndex := AppendAt end,
    FOnInsertError);
  if LIndex >= 0  then
  begin
    SetState(seInsert);
    FEnteringEditState := True;
    try
      DataSetChanged;
      ItemIndex := LIndex;
    finally
      FEnteringEditState := False;
    end;
  end;
  DoAfterInsert;
  DoAfterScroll;
end;

function TBindSourceAdapter.AppendAt: Integer;
begin
  Assert(False);
  Result := -1;
end;

procedure TBindSourceAdapter.DataSetChanged;
var
  LScope: TBaseObjectBindSource;
begin
  for LScope in Scopes do
  begin
    LScope.OnAdapterDataSetChanged(Self);
  end;
end;

procedure TBindSourceAdapter.RecordChanged(AField: TBindSourceAdapterField);
var
  LScope: TBaseObjectBindSource;
begin
  for LScope in Scopes do
  begin
    LScope.OnAdapterRecordChanged(Self, AField);
  end;
end;

procedure TBindSourceAdapter.ApplyUpdates;
begin
  CheckBrowseMode;
  DoBeforeApplyUpdates;
  CheckOperation(InternalApplyUpdates, FOnApplyUpdatesError);
  DataSetChanged;
  DoAfterApplyUpdates;
end;

procedure TBindSourceAdapter.Last;
var
  LNewIndex: Integer;
begin
  LNewIndex := ItemIndex;
  if GetCount >= 1 then
  begin
    LNewIndex := GetCount - 1;
  end;
  if GetItemIndex <> LNewIndex then
  begin
    ItemIndex := LNewIndex;
  end;
end;

procedure TBindSourceAdapter.Next;
var
  LNewIndex: Integer;
begin
  LNewIndex := ItemIndex;
  if LNewIndex = -1 then
  begin
    if GetCount > 0 then
      LNewIndex := 0;
  end
  else if LNewIndex + 1 < GetCount then
    Inc(LNewIndex);
  if ItemIndex <> LNewIndex then
  begin
    ItemIndex := LNewIndex;
  end;
end;

procedure TBindSourceAdapter.UpdateRecord;
var
  LScope: TBaseObjectBindSource;
begin
  if not (State in seEditModes) then
    BindSourceAdapterError(SNotEditing, Self);
  if FUpdatingRecords = 0 then
    for LScope in FScopes do
    begin
      LScope.OnAdapterUpdateRecord(Self);
    end;
end;

procedure TBindSourceAdapter.PosChanging;
begin
  if (State in seEditModes) then
    Post;
end;

procedure TBindSourceAdapter.Post;
begin
  UpdateRecord;
  case State of
    seEdit, seInsert:
      begin
        DoBeforePost;
        CheckOperation(
          procedure
          begin
            InternalPost;
          end,
          FOnPostError);
        SetState(seBrowse);
        DataSetChanged;
        DoAfterPost;
      end;
  end;
end;

procedure TBindSourceAdapter.InternalPost;
var
  LField: TBindSourceAdapterField;
begin
  for LField in FFields do
  begin
    LField.Post;
  end;
end;

procedure TBindSourceAdapter.Prior;
var
  LNewIndex: Integer;
begin
  LNewIndex := ItemIndex;
  if LNewIndex - 1 >= 0 then
    Dec(LNewIndex);
  if ItemIndex <> LNewIndex then
  begin
    ItemIndex := LNewIndex;
  end;
end;

function TBindSourceAdapter.GetActive: Boolean;
begin
  Result := not (State in [seInactive]);
end;

procedure TBindSourceAdapter.SetActive(Value: Boolean);
begin
    if Active <> Value then
    begin
      if Value then
      begin
        DoBeforeOpen;
        SetState(seBrowse);
        DoAfterOpen;
      end else
      begin
        if not (csDestroying in ComponentState) then DoBeforeClose;
        SetState(seInactive);
        if not (csDestroying in ComponentState) then DoAfterClose;
      end;
    end;
end;

procedure TBindSourceAdapter.SetItemIndex(Value: Integer);
var
  LDistance: Integer;
  LScope: TBaseObjectBindSource;
begin
  Assert(FItemIndexOffset = 0);
  if (Value <> ItemIndex) and (Value < GetCount) then
  begin
    if Active then
    begin
      if (State in seEditModes) then
        if not FEnteringEditState then
          Post;
      DoBeforeScroll;
      LDistance := Value - ItemIndex;
      FItemIndex := Value;
      for LScope in Scopes do
        LScope.OnAdapterDataSetScrolled(Self, LDistance);
      DoAfterScroll;
    end
    else
      FItemIndex := Value;
  end;
end;

procedure TBindSourceAdapter.SetItemIndexOffset(Value: Integer);
begin
  FItemIndexOffset := Value;
end;

{ Event Handler Helpers }

procedure TBindSourceAdapter.DoAfterCancel;
begin
  if Assigned(FAfterCancel) then FAfterCancel(Self);
end;

procedure TBindSourceAdapter.DoAfterClose;
begin
  if Assigned(FAfterClose) then FAfterClose(Self);
end;

procedure TBindSourceAdapter.DoAfterDelete;
begin
  if Assigned(FAfterDelete) then FAfterDelete(Self);
end;

procedure TBindSourceAdapter.DoAfterEdit;
begin
  if Assigned(FAfterEdit) then FAfterEdit(Self);
end;

procedure TBindSourceAdapter.DoAfterInsert;
begin
  if Assigned(FAfterInsert) then FAfterInsert(Self);
end;

procedure TBindSourceAdapter.DoAfterOpen;
begin
  if Assigned(FAfterOpen) then FAfterOpen(Self);
  if ItemCount <> 0 then DoAfterScroll;
end;

procedure TBindSourceAdapter.DoAfterPost;
begin
  if Assigned(FAfterPost) then FAfterPost(Self);
end;

procedure TBindSourceAdapter.DoAfterRefresh;
begin
  if Assigned(FAfterRefresh) then FAfterRefresh(Self);
end;

procedure TBindSourceAdapter.DoAfterScroll;
begin
  if Assigned(FAfterScroll) then FAfterScroll(Self);
end;

procedure TBindSourceAdapter.DoBeforeCancel;
begin
  if Assigned(FBeforeCancel) then FBeforeCancel(Self);
end;

procedure TBindSourceAdapter.DoBeforeClose;
begin
  if Assigned(FBeforeClose) then FBeforeClose(Self);
end;

procedure TBindSourceAdapter.DoBeforeDelete;
begin
  if Assigned(FBeforeDelete) then FBeforeDelete(Self);
end;

procedure TBindSourceAdapter.DoBeforeEdit;
begin
  if Assigned(FBeforeEdit) then FBeforeEdit(Self);
end;

procedure TBindSourceAdapter.DoBeforeInsert;
begin
  if Assigned(FBeforeInsert) then FBeforeInsert(Self);
end;

procedure TBindSourceAdapter.DoBeforeOpen;
begin
  if Assigned(FBeforeOpen) then FBeforeOpen(Self);
end;

procedure TBindSourceAdapter.DoBeforePost;
begin
  if Assigned(FBeforePost) then FBeforePost(Self);
end;

procedure TBindSourceAdapter.DoBeforePostFields(
  AFields: TArray<TBindSourceAdapterField>);
begin
//
end;

procedure TBindSourceAdapter.DoAfterPostFields(
  AFields: TArray<TBindSourceAdapterField>);
begin
//
end;

procedure TBindSourceAdapter.DoBeforeRefresh;
begin
  if Assigned(FBeforeRefresh) then FBeforeRefresh(Self);
end;

procedure TBindSourceAdapter.DoBeforeScroll;
begin
  if Assigned(FBeforeScroll) then FBeforeScroll(Self);
end;

procedure TBindSourceAdapter.DoBeforeCancelUpdates;
begin
  if Assigned(FBeforeCancelUpdates) then FBeforeCancelUpdates(Self);
end;

procedure TBindSourceAdapter.DoBeforeApplyUpdates;
begin
  if Assigned(FBeforeApplyUpdates) then FBeforeApplyUpdates(Self);
end;

procedure TBindSourceAdapter.DoAfterCancelUpdates;
begin
  if Assigned(FAfterCancelUpdates) then FAfterCancelUpdates(Self);
end;

procedure TBindSourceAdapter.DoAfterApplyUpdates;
begin
  if Assigned(FAfterApplyUpdates) then FAfterApplyUpdates(Self);
end;

procedure TBindSourceAdapter.CheckOperation(AOperation: TProc;
  ErrorEvent: TAdapterErrorEvent);
var
  Done: Boolean;
  Action: TAdapterErrorAction;
begin
  Done := False;
  repeat
    try
      AOperation();
      Done := True;
    except
      on E: EBindCompError do
      begin
        Action := aaFail;
        if Assigned(ErrorEvent) then ErrorEvent(Self, E, Action);
        if Action = aaFail then raise;
        if Action = aaAbort then System.SysUtils.Abort;
      end;
    end;
  until Done;
end;


{ TBindSourceAdapterField }

function TBindSourceAdapterField.SupportsStreamPersist(const Persistent: TObject;
  var StreamPersist: IStreamPersist): Boolean;
begin
   Result := (Persistent is TInterfacedPersistent) and
     (TInterfacedPersistent(Persistent).QueryInterface(IStreamPersist, StreamPersist) = S_OK);
end;

function TBindSourceAdapterField.AssignValue(Dest: TPersistent): Boolean;
var
  StreamPersist: IStreamPersist;
begin
  Result := False;

  if Dest is TStrings then
  begin
    SaveToStrings(TStrings(Dest));
    Exit(True);
  end;

  if SupportsStreamPersist(Dest, StreamPersist) then
  begin
    SaveToStreamPersist(StreamPersist);
    Exit(True);
  end;

end;

function TBindSourceAdapterField.CreateValueBlobStream(AValue: TObject): TStream;
var
  LStreamPersist: IStreamPersist;
begin
  Result := TMemoryStream.Create;
  if SupportsStreamPersist(AValue, LStreamPersist) then
  begin
    LStreamPersist.SaveToStream(Result);
  end;
end;


class destructor TBindSourceAdapterField.Destroy;
begin
  FValidChars.Free;
end;

function TBindSourceAdapterField.CreateBlobStream: TStream;
begin
  Result := TMemoryStream.Create;
end;

procedure TBindSourceAdapterField.SaveToStrings(Strings: TStrings);
var
  BlobStream: TStream;
begin
  BlobStream := CreateBlobStream;
  try
    Strings.LoadFromStream(BlobStream);
  finally
    BlobStream.Free;
  end;
end;

procedure TBindSourceAdapterField.SetTValue(const AValue: TValue);
begin
  BindSourceAdapterError(sNotImplemented, Self.Owner);
end;

procedure TBindSourceAdapterField.SetAutoPost(const Value: Boolean);
begin
  //
end;

type
  TGraphicHeader = record
    Count: Word;                { Fixed at 1 }
    HType: Word;                { Fixed at $0100 }
    Size: Longint;              { Size not including header }
  end;

procedure TBindSourceAdapterField.SaveToStreamPersist(StreamPersist: IStreamPersist);
var
  BlobStream: TStream;
  Size: Longint;
  Header: TGraphicHeader;
begin
  BlobStream := CreateBlobStream;
  try
    Size := BlobStream.Size;
    if Size >= SizeOf(TGraphicHeader) then
    begin
      BlobStream.Read(Header, SizeOf(Header));
      if (Header.Count <> 1) or (Header.HType <> $0100) or
        (Header.Size <> Size - SizeOf(Header)) then
        BlobStream.Position := 0;
    end;
    StreamPersist.LoadFromStream(BlobStream);
  finally
    BlobStream.Free;
  end;
end;

procedure TBindSourceAdapterField.AutoEditField;
begin
  FOwner.AutoEditField(Self);
end;

procedure TBindSourceAdapterField.AutoPostField;
begin
  FOwner.AutoPostField(Self);
end;

procedure TBindSourceAdapterField.Cancel;
begin

end;

constructor TBindSourceAdapterField.Create(AOwner: TBindSourceAdapter; const AMemberName: string;
      const AGetMemberObject: IGetMemberObject);
begin
  FOwner := AOwner;
  FMemberName := AMemberName;
end;

function TBindSourceAdapterField.FindField(const AMemberName: string): TBindSourceAdapterField;
begin
  Result := nil;
end;

function TBindSourceAdapterField.GetGetter(var AGetter: string): Boolean;
begin
  Result := False;
end;

function TBindSourceAdapterField.GetMemberType(var AType: TScopeMemberType): Boolean;
begin
  Result := False;
end;

function TBindSourceAdapterField.GetIsObject: Boolean;
begin
  Result := False;
end;

function TBindSourceAdapterField.GetIsReadable: Boolean;
var
  LSetter: string;
begin
  Result := GetGetter(LSetter);
end;

function TBindSourceAdapterField.GetIsWritable: Boolean;
var
  LSetter: string;
begin
  Result := GetSetter(LSetter);
end;

function TBindSourceAdapterField.GetMemberObject: TObject;
begin
  if Assigned(FGetMemberObject) then
    Result := FGetMemberObject.GetMemberObject
  else
    Result := Self.FOwner.Current;
end;

function TBindSourceAdapterField.GetSetter(var AGetter: string): Boolean;
begin
  Result := False;
end;


function TBindSourceAdapterField.GetTValue: TValue;
begin
  Result := TValue.Empty;
end;

function TBindSourceAdapterField.GetAutoPost: Boolean;
begin
  Result := False;
end;

function TBindSourceAdapterField.IsBuffered: Boolean;
begin
  Result := False;
end;

function TBindSourceAdapterField.IsValidChar(AChar: Char): Boolean;
var
  LMemberType: TScopeMemberType;
  C: Char;
  LMemberTypes: TScopeMemberTypes;
begin
  if FValidChars = nil then
  begin
    FValidChars := TDictionary<char, TScopeMemberTypes>.Create;
    FValidChars.Add(#0, [mtUnknown, mtText, mtBitmap, mtMemo, mtBoolean, mtDateTime, mtTime, mtDate, mtChar]);
    for C := '0' to '9' do
      FValidChars.Add(C, [mtInteger, mtFloat, mtUInteger, mtBCD, mtCurrency]);
    FValidChars.Add(FormatSettings.DecimalSeparator, [mtInteger, mtFloat, mtUInteger, mtBCD, mtCurrency]);
    FValidChars.Add('+', [mtInteger, mtFloat, mtBCD, mtCurrency]);
    FValidChars.Add('-', [mtInteger, mtFloat, mtBCD, mtCurrency]);
    FValidChars.Add('e', [mtFloat]);
    FValidChars.Add('E', [mtFloat]);
  end;
  if AChar = #0 then
    // Special case to test if field is read only
    Result := GetIsWritable
  else
  begin
    Result := True;
    if GetMemberType(LMemberType) then
    begin
      if not (LMemberType in FValidChars[#0]) then
        if (not FValidChars.TryGetValue(AChar, LMemberTypes)) or
         (not (LMemberType in LMemberTypes)) then
        Result := False;
    end;
  end;
end;

procedure TBindSourceAdapterField.Post;
begin

end;

procedure TBindSourceAdapterField.RecordChanged;
var
  LScope: TBaseObjectBindSource;
begin
  if Assigned(Self.FOwner) then
    for LScope in FOwner.Scopes do
    begin
      LScope.OnAdapterRecordChanged(Self, Self);
    end;
end;

{ TCollectionEditorBindLink }

constructor TBindSourceAdapterLinkImpl.Create(ABindLink: IBindLink);
begin
  inherited Create;
  FBindLink := ABindLink;
  Supports(FBindLink, IBindPosition, FBindPosition);
  Supports(FBindLink, IBindListUpdate, FBindListUpdate);
end;

constructor TBindSourceAdapterLinkImpl.Create(ABindPosition: IBindPosition);
begin
  inherited Create;
  FBindPosition := ABindPosition;
  Supports(FBindPosition, IBindLink, FBindLink);
  Supports(FBindPosition, IBindListUpdate, FBindListUpdate);
end;

constructor TBindSourceAdapterLinkImpl.Create(ABindListUpdate: IBindListUpdate);
begin
  inherited Create;
  FBindListUpdate := ABindListUpdate;
  Supports(FBindListUpdate, IBindLink, FBindLink);
  Supports(FBindListUpdate, IBindPosition, FBindPosition);
end;

procedure TBindSourceAdapterLinkImpl.ActiveChanged;
begin
  UpdateField;
end;

procedure TBindSourceAdapterLinkImpl.UpdateData;
begin
  if FBindLink <> nil then

    if FModified then
    begin
      FBindLink.EvaluateParse('');
      FModified := False;
    end;
end;

procedure TBindSourceAdapterLinkImpl.UpdateField;
var
  LFieldName: string;
begin
  LFieldName := GetFieldName;
  if (LFieldName = '') and (FField = nil) then
  begin
    // No field name
    RecordChanged(nil);
  end
  else
  begin
    if Active and (LFieldName <> '') then
    begin
      FField := nil;
      SetField(FAdapter.FindField(LFieldName));
    end
    else
      SetField(nil);
  end;
end;

procedure TBindSourceAdapterLinkImpl.SetField(Value: TBindSourceAdapterField);
begin
  if FField <> Value then
  begin
    FField := Value;
    EditingChanged;
    RecordChanged(nil);
  end;
end;

function TBindSourceAdapterLinkImpl.Edit: Boolean;
begin
  if CanModify then inherited Edit;
  Result := FEditing;
end;

procedure TBindSourceAdapterLinkImpl.EditingChanged;
begin
  SetEditing(inherited Editing and CanModify);
end;

procedure TBindSourceAdapterLinkImpl.SetEditing(Value: Boolean);
begin
  if FEditing <> Value then
  begin
    FEditing := Value;
    FModified := False;
  end;
end;

procedure TBindSourceAdapterLinkImpl.RecordChanged(Field: TBindSourceAdapterField);
begin
  if (Field = nil) or (Field = FField) then
  begin
    DoDataChange(Field);
    FModified := False;
  end
  else if FField = nil then
  begin
    DoDataChange(Field);
    FModified := False;
  end;
end;

function TBindSourceAdapterLinkImpl.GetFieldName: string;
begin
  if FBindLink <> nil then
    Result := FBindLink.SourceMemberName
  else if FBindPosition <> nil then
    Result := FBindPosition.SourceMemberName
  else
    Result := '';
end;

function TBindSourceAdapterLinkImpl.GetCanModify: Boolean;
begin
  Result := FAdapter.CanModify and ((Field = nil) or Field.GetIsWritable);
end;

function TBindSourceAdapterLinkImpl.GetField: TBindSourceAdapterField;
begin
  Result := FField;
end;

function TBindSourceAdapterLinkImpl.GetIsModified: Boolean;
begin
  Result := FModified;
end;

procedure TBindSourceAdapterLinkImpl.LayoutChanged;
begin
  UpdateField;
end;

procedure TBindSourceAdapterLinkImpl.SetModified;
begin
  FModified := True;
  FAdapter.FModified := True;
end;

procedure TBindSourceAdapterLinkImpl.Reset;
begin
  FModified := False;
  DoDataChange(FField);
end;

procedure TBindSourceAdapterLinkImpl.RefreshNeeded;
begin
  FRefreshNeeded := True;
end;

procedure TBindSourceAdapterLinkImpl.DataSetChanged;
var
  LBindListRefresh: IBindListRefresh;
  LRefreshed: Boolean;
begin
  if (FBindListUpdate <> nil) and Active and FBindListUpdate.Active then
  begin
    LRefreshed := False;
    if Supports(FBindListUpdate, IBindListRefresh, LBindListRefresh)  then
      if LBindListRefresh.RefreshNeeded or FRefreshNeeded then
      begin
        FRefreshNeeded := False;
        LBindListRefresh.RefreshList;
        LRefreshed := True;
      end;
    if not LRefreshed then
    begin
      if (FBindPosition <> nil) and FBindPosition.Active then
      begin
        FBindPosition.EvaluatePosControl;
      end;
      FBindListUpdate.UpdateList;
      if (FBindPosition <> nil) and FBindPosition.Active then
      begin
        // Make sure new row is selected
        if seInsert = Self.Adapter.State then
           FBindPosition.EvaluatePosControl;  
      end;
    end;
  end
  else if (FBindPosition <> nil) and Active and FBindPosition.Active then
  begin
    FBindPosition.EvaluatePosControl;
  end;
  RecordChanged(nil);
end;

procedure TBindSourceAdapterLinkImpl.DataSetScrolled(ADistance: Integer);
begin
  if Active then
    if (FBindLink <> nil) and (FBindLink.Active) then
    begin
      if (FBindPosition <> nil) and (FBindPosition.Active) then
      begin
        // Must position grid to current record
        FBindPosition.EvaluatePosControl;
      end
      else
        RecordChanged(nil);
    end
    else if (FBindPosition <> nil) and (FBindPosition.Active) then
      if Active then
        FBindPosition.EvaluatePosControl;
end;

procedure TBindSourceAdapterLinkImpl.DoDataChange(AField: TBindSourceAdapterField);
var
  LMemberName: string;
begin
  if AField <> nil then
    LMemberName := AField.MemberName;
  if not FDeferEvaluate then
    if (FBindLink <> nil) and (FBindLink.Active) then
    begin
      if Active and (Adapter.ItemCount > 0) then
        FBindLink.EvaluateFormat(LMemberName)
      else
        FBindLink.EvaluateClear(LMemberName)
    end
end;

{ TBindSourceAdapterLink }

procedure TBindSourceAdapterLink.ActiveChanged;
begin

end;

procedure TBindSourceAdapterLink.EditingChanged;
begin

end;

constructor TBindSourceAdapterLink.Create;
begin
  FReadOnly := False;
end;

procedure TBindSourceAdapterLink.DataSetChanged;
begin

end;

procedure TBindSourceAdapterLink.DataSetScrolled(ADistance: Integer);
begin

end;

procedure TBindSourceAdapterLink.LayoutChanged;
begin

end;

procedure TBindSourceAdapterLink.RecordChanged(Field: TBindSourceAdapterField);
begin

end;

function TBindSourceAdapterLink.Edit: Boolean;
begin
  if not FReadOnly and (FAdapter <> nil) then FAdapter.Edit;
  Result := FEditing;
end;

procedure TBindSourceAdapterLink.SetAdapter(const Value: TBindSourceAdapter);
begin
  if FAdapter <> Value then
  begin
    if (FAdapter <> nil) and (not (csDestroying in FAdapter.ComponentState)) then
      FAdapter.RemoveLink(Self);
    FAdapter := Value;
    if Value <> nil then Value.AddLink(Self);
  end;
end;

procedure TBindSourceAdapterLink.UpdateData;
begin

end;

procedure TBindSourceAdapterLink.UpdateRecord;
begin
  FUpdating := True;
  try
    UpdateData;
  finally
    FUpdating := False;
  end;
end;

procedure TBindSourceAdapterLink.UpdateState;
begin
  SetActive((FAdapter <> nil) and (not (csDestroying in  FAdapter.ComponentState)) and (FAdapter.State <> seInactive));
  SetEditing((FAdapter <> nil) and (not (csDestroying in  FAdapter.ComponentState)) and (FAdapter.State in seEditModes) and
    not FReadOnly);
end;

procedure TBindSourceAdapterLink.SetActive(Value: Boolean);
begin
  if FActive <> Value then
  begin
    FActive := Value;
    ActiveChanged;
  end;
end;

procedure TBindSourceAdapterLink.SetEditing(Value: Boolean);
begin
  if FEditing <> Value then
  begin
    FEditing := Value;
    EditingChanged;
  end;
end;


{ TBindSourceAdapterCustomScope }

function TBindSourceAdapterCustomScope.DoLookup(const Name: String): IInterface;
var
  LScope: TBindSourceAdapter;
begin
  Result := nil;
  if MappedObject is TBindSourceAdapter then
  begin
    LScope := TBindSourceAdapter(MappedObject);
    if LScope.FindField(Name) <> nil then
      Result := TCustomWrapper.Create(LScope, LScope.ClassType, Name, cwtProperty,
        function (ParentObject: TObject; const MemberName: String; Args: TArray<TValue>): TValue
        begin
          Result := TBindSourceAdapter(ParentObject).FindField(MemberName);
        end);
  end;
end;

{ TBaseObjectBindSourceAdapter }

constructor TBaseObjectBindSourceAdapter.Create(AOwner: TComponent);
begin
  inherited;
  FOptions := [optAllowModify];
end;

function TBaseObjectBindSourceAdapter.GetObjectType: TRttiType;
begin
  Result := nil;
end;

{ TBindSourceAdapterInstanceFactory }

function TBindSourceAdapterInstanceFactory.FindConstructor: TRttiMethod;
var
  LMethod: TRTTIMethod;
  LParameters: TArray<TRttiParameter>;
begin
  if FType <> nil then
    for LMethod in FType.GetMethods do
    begin
      if LMethod.HasExtendedInfo and LMethod.IsConstructor then
      begin
        LParameters := LMethod.GetParameters;
        if Length(LParameters) = 0 then
        begin
          Exit(LMethod);
        end;
      end;
    end;
  exit(nil);
end;

function TBindSourceAdapterInstanceFactory.ConstructInstance: TObject;
var
  LClass: TClass;
  LInstance: TObject;
begin
  Result := nil;
  if FConstructor <> nil then
  begin
    LClass := FType.AsInstance.MetaclassType;
    LInstance := FConstructor.Invoke(LClass, []).AsObject;
    try
      Result := LInstance;
      if not (LInstance.InheritsFrom(LClass)) then
          BindSourceAdapterError(Format(sInvalidInstance, [LInstance.ClassName, LClass.ClassName]));
    except
      LInstance.Free;
      raise;
    end;
  end;
end;

function TBindSourceAdapterInstanceFactory.CanConstructInstance: Boolean;
begin
  Result := CheckConstructor;
end;

function TBindSourceAdapterInstanceFactory.CheckConstructor: Boolean;
var
  LMethod: TRttiMethod;
  LType: TRttiType;
begin
  Result := CheckConstructor(LType, LMethod);
end;

function TBindSourceAdapterInstanceFactory.CheckConstructor(out AType: TRttiType; out AMethod: TRttiMethod): Boolean;
begin
  if (FType <> nil) and FFindConstructor then
  begin
    FFindConstructor := False;
    if FType <> nil then
      FConstructor := FindConstructor
  end;
  AMethod := FConstructor;
  AType := FType;
  Result := AMethod <> nil;
end;

constructor TBindSourceAdapterInstanceFactory.Create(AType: TRttiType);
begin
  FFindConstructor := True;
  Assert(AType <> nil);
  FType := AType;

end;

{ TBaseListBindSourceAdapter }

procedure TBaseListBindSourceAdapter.DoInitItemInstance(AInstance: TObject);
begin
  if Assigned(FOnInitItemInstance) then FOnInitItemInstance(Self, AInstance);
end;

procedure TBaseListBindSourceAdapter.DoListInsert(AIndex: Integer; out AHandled: Boolean; out ANewIndex: Integer);
begin
  AHandled := False;
  ANewIndex := AIndex;
  if Assigned(FOnListInsert) then FOnListInsert(Self, AIndex, AHandled, ANewIndex);
end;

constructor TBaseListBindSourceAdapter.Create(AOwner: TComponent);
begin
  inherited;
  FOptions := [loptAllowInsert, loptAllowModify, loptAllowDelete];
end;

procedure TBaseListBindSourceAdapter.DoCreateInstance(out AHandled: Boolean; out AInstance: TObject);
begin
  AHandled := False;
  AInstance := nil;
  if Assigned(FOnCreateItemInstance) then FOnCreateItemInstance(Self, AHandled, AInstance);
end;

procedure TBaseListBindSourceAdapter.DoListAppend(out AHandled: Boolean; out AAppended: Boolean);
begin
  AHandled := False;
  AAppended := True;
  if Assigned(FOnListAppend) then FOnListAppend(Self, AHandled, AAppended);
end;

procedure TBaseListBindSourceAdapter.DoListDelete(AIndex: Integer; out AHandled: Boolean; out ARemoved: Boolean);
begin
  AHandled := False;
  ARemoved := True;
  if Assigned(FOnListDelete) then FOnListDelete(Self, AIndex, AHandled, ARemoved);
end;

{ TListBindSourceAdapter<T> }

function TListBindSourceAdapter<T>.GetObjectType: TRttiType;
var
  LType: TRttiType;
  LCtxt: TRttiContext;
begin
  LType := LCtxt.GetType(TypeInfo(T));
  Result := LType;
end;

function TListBindSourceAdapter<T>.GetItemInstanceFactory: TBindSourceAdapterInstanceFactory;
begin
  if FInstanceFactory = nil then
    FInstanceFactory := TBindSourceAdapterInstanceFactory.Create(GetObjectType);
  Result := FInstanceFactory;
end;

procedure TListBindSourceAdapter<T>.CheckList;
begin
  if FList = nil then
    BindSourceAdapterError(sNilList);
end;

function TListBindSourceAdapter<T>.CreateItemInstance: T;
var
  LObject: TObject;
  LHandled: Boolean;
begin
  CheckList;
  Result := nil;
  DoCreateInstance(LHandled, LObject);
  if not LHandled then
  begin
    Assert(GetItemInstanceFactory.CanConstructInstance);
    if GetItemInstanceFactory.CanConstructInstance then
      LObject := GetItemInstanceFactory.ConstructInstance;
  end;
  try
    if not (LObject is T) then
      BindSourceAdapterError(Format(sInvalidInstance, [LObject.ClassName, T.ClassName]));
    Result := LObject as T;
  except
    LObject.Free;
    raise;
  end;
end;

function TListBindSourceAdapter<T>.AppendAt: Integer;
var
  ANewItem: T;
  LIndex: Integer;
  LHandled: Boolean;
  LAppended: Boolean;
begin
  DoListAppend(LHandled, LAppended);
  if LHandled then
    if LAppended then
    begin
      CheckList;
      Exit(FList.Count - 1)
    end
    else
      Exit(-1);

  Result := -1;
  ANewItem := CreateItemInstance;
  if ANewItem <> nil then
  begin
    InitItemInstance(ANewItem);
    FList.Add(ANewItem);
    Result := FList.Count - 1;
  end;
end;

function TListBindSourceAdapter<T>.GetCanInsert: Boolean;
begin
  Result := (loptAllowInsert in Options);
  if Result then
  begin
    Result := Assigned(FOnCreateItemInstance) or
      GetItemInstanceFactory.CheckConstructor;
  end;
end;

function TListBindSourceAdapter<T>.GetCanModify: Boolean;
begin
  Result := (loptAllowModify in Options);
end;

constructor TListBindSourceAdapter<T>.Create(AOwner: TComponent; AList: TList<T>; AOwnsObject: Boolean = True);
begin
  Create(AOwner);
  SetList(AList, AOwnsObject);
end;

procedure TListBindSourceAdapter<T>.SetList(AList: TList<T>; AOwnsObject: Boolean);
begin
  DoOnBeforeSetList(AList);
  Active := False;
  if FList <> nil then
  begin
    ClearFields;
    if FOwnsList then
      FreeAndNil(FList);
  end;
  FOwnsList := AOwnsObject;
  FList := AList;
  if FList <> nil then
  begin
    AddFields;
  end;
  DoOnAfterSetList;
end;

function TListBindSourceAdapter<T>.SupportsNestedFields: Boolean;
begin
  Result := True;
end;

function TListBindSourceAdapter<T>.DeleteAt(AIndex: Integer): Boolean;
var
  LHandled: Boolean;
  LRemoved: Boolean;
begin
  DoListDelete(AIndex, LHandled, LRemoved);
  if LHandled then
    Exit(LRemoved);
  if (AIndex >= 0) and (AIndex < FList.Count) then
  begin
    CheckList;
    FList.Delete(AIndex);
    Result := True;
  end
  else
    Result := False;
end;

function TListBindSourceAdapter<T>.GetCanApplyUpdates: Boolean;
var
  LHasUpdates: Boolean;
begin
  Result := loptAllowApplyUpdates in Options;
  if Result then
  begin
    Result := Assigned(FOnApplyUpdates);
    if Result then
      if Assigned(FOnHasUpdates) then
      begin
        LHasUpdates := False;
        FOnHasUpdates(Self, LHasUpdates);
        Result := LHasUpdates;
      end;
  end;
end;

function TListBindSourceAdapter<T>.GetCanCancelUpdates: Boolean;
var
  LHasUpdates: Boolean;
begin
  Result := loptAllowCancelUpdates in Options;
  if Result then
  begin
    Result := Assigned(FOnCancelUpdates);
    if Result then
      if Assigned(FOnHasUpdates) then
      begin
        LHasUpdates := False;
        FOnHasUpdates(Self, LHasUpdates);
        Result := LHasUpdates;
      end;
  end;
end;

function TListBindSourceAdapter<T>.GetCanDelete: Boolean;
begin
  Result := loptAllowDelete in Options;
end;

destructor TListBindSourceAdapter<T>.Destroy;
begin
  if FOwnsList then
    FreeAndNil(FList);
  FInstanceFactory.Free;
  inherited;
end;

procedure TListBindSourceAdapter<T>.DoOnAfterSetList;
begin
  if Assigned(FOnAfterSetList) then
    FOnAfterSetList(Self);
end;

procedure TListBindSourceAdapter<T>.DoOnBeforeSetList(AList: TList<T>);
begin
  if Assigned(FOnBeforeSetList) then
    FOnBeforeSetList(Self, AList);
end;

function TListBindSourceAdapter<T>.GetCanActivate: Boolean;
begin
  Result := FList <> nil;
end;

function TListBindSourceAdapter<T>.GetCount: Integer;
begin
  if FList <> nil then
    Result := FList.Count
  else
    Result := 0;
end;

function TListBindSourceAdapter<T>.GetCurrent: TObject;
var
  LIndex: Integer;
begin
  LIndex := ItemIndex + FItemIndexOffset;
  if (FList <> nil) and (LIndex >= 0) and (LIndex < FList.Count) then
    Result := FList.Items[ItemIndex +  FItemIndexOffset]
  else
    Result := nil;
end;


procedure TListBindSourceAdapter<T>.InitItemInstance(AInstance: T);
begin
  DoInitItemInstance(AInstance);
end;

function TListBindSourceAdapter<T>.InsertAt(AIndex: Integer): Integer;
var
  ANewItem: T;
  AHandled: Boolean;
begin
  DoListInsert(AIndex, AHandled, Result);
  if AHandled then
    Exit;
  Result := -1;
  ANewItem := CreateItemInstance;
  if ANewItem <> nil then
  begin
    InitItemInstance(ANewItem);
    FList.Insert(AIndex, ANewItem);
    Result := AIndex;
  end;
end;

procedure TListBindSourceAdapter<T>.InternalApplyUpdates;
begin
  if Assigned(FOnApplyUpdates) then
    FOnApplyUpdates(Self);

end;

procedure TListBindSourceAdapter<T>.InternalCancelUpdates;
begin
  if Assigned(FOnCancelUpdates) then
    FOnCancelUpdates(Self);
end;

{ TObjectBindSourceAdapter<T> }

function TObjectBindSourceAdapter<T>.GetObjectType: TRttiType;
var
  LType: TRttiType;
  LCtxt: TRttiContext;
begin
  LType := LCtxt.GetType(TypeInfo(T));
  Result := LType;
end;

procedure TObjectBindSourceAdapter<T>.AddFields;
var
  LType: TRttiType;
  LIntf: IGetMemberObject;
begin
  LType := GetObjectType;
  LIntf := TBindSourceAdapterGetMemberObject.Create(Self);
  AddFieldsToList(LType, Self, Self.Fields, LIntf);
  AddPropertiesToList(LType, Self, Self.Fields, LIntf);
end;

function TObjectBindSourceAdapter<T>.AppendAt: Integer;
var
  ANewItem: T;
begin
  Assert(False);
end;

constructor TObjectBindSourceAdapter<T>.Create(AOwner: TComponent; AObject: T; AOwnsObject: Boolean);
begin
  inherited Create(AOwner);
  SetDataObject(AObject, AOwnsObject);
end;

function TObjectBindSourceAdapter<T>.DeleteAt(AIndex: Integer): Boolean;
begin
  Assert(False);
end;

destructor TObjectBindSourceAdapter<T>.Destroy;
begin
  if FOwnsObject then
    FreeAndNil(FDataObject);
  inherited;
end;


procedure TObjectBindSourceAdapter<T>.DoOnBeforeSetDataObject(ADataObject: T);
begin
  if Assigned(FOnBeforeSetDataObject) then
    FOnBeforeSetDataObject(Self, ADataObject);
end;

procedure TObjectBindSourceAdapter<T>.DoOnAfterSetDataObject;
begin
  if Assigned(FOnAfterSetDataObject) then
    FOnAfterSetDataObject(Self);
end;

function TObjectBindSourceAdapter<T>.GetCanActivate: Boolean;
begin
  Result := FDataObject <> nil;
end;

function TObjectBindSourceAdapter<T>.GetCanModify: Boolean;
begin
  Result := optAllowModify in Options;
end;

function TObjectBindSourceAdapter<T>.GetCanApplyUpdates: Boolean;
begin
  Result := optAllowApplyUpdates in Options;
  if Result then
    Result := Assigned(FOnApplyUpdates)
end;

function  TObjectBindSourceAdapter<T>.GetCanCancelUpdates: Boolean;
begin
  Result := optAllowCancelUpdates in Options;
  if Result then
    Result := Assigned(FOnCancelUpdates);
end;

procedure TObjectBindSourceAdapter<T>.InternalApplyUpdates;
begin
  if Assigned(FOnApplyUpdates) then
    FOnApplyUpdates(Self);

end;

procedure TObjectBindSourceAdapter<T>.InternalCancelUpdates;
begin
  if Assigned(FOnCancelUpdates) then
    FOnCancelUpdates(Self);
end;

function TObjectBindSourceAdapter<T>.GetCount: Integer;
begin
  if Assigned(FDataObject) then
    Result := 1
  else
    Result := 0;
end;

function TObjectBindSourceAdapter<T>.GetCurrent: TObject;
begin
  Result := FDataObject;
end;

function TObjectBindSourceAdapter<T>.InsertAt(AIndex: Integer): Integer;
var
  ANewItem: T;
begin
  Assert(False);
end;

procedure TObjectBindSourceAdapter<T>.SetDataObject(ADataObject: T;
  AOwnsObject: Boolean);
begin
  DoOnBeforeSetDataObject(ADataObject);
  Active := False;
  if FDataObject <> nil then
  begin
    ClearFields;
    if FOwnsObject then
      FreeAndNil(FDataObject);
  end;
  FOwnsObject := AOwnsObject;
  FDataObject := ADataObject;
  if FDataObject <> nil then
  begin
    AddFields;
  end;
  DoOnAfterSetDataObject;
end;

function TObjectBindSourceAdapter<T>.SupportsNestedFields: Boolean;
begin
  Result := True;
end;

{ TCustomDataGeneratorAdapter }

class function TCustomDataGeneratorAdapter.CreateField<T>(AFieldDef: TGeneratorFieldDef; ABindSourceAdapter: TBindSourceAdapter;
  const AGetMemberObject: IGetMemberObject; LDummy: TDummy<T>): TBindSourceAdapterField;
var
  LTypeInfo: PTypeInfo;
begin
  LTypeInfo := AFieldDef.TypeInfo;
  Assert(LTypeInfo <> nil);
  if AFieldDef.ReadOnly then
    Result := TBindSourceAdapterReadField<T>.Create(ABindSourceAdapter,
      AFieldDef.Name, TBindSourceAdapterFieldType.Create(LTypeInfo.NameFld.ToString, LTypeInfo.Kind), AGetMemberObject,
      TBindFieldDefValueReader<T>.Create,
      AFieldDef.MemberType)
  else
    Result := TBindSourceAdapterReadWriteField<T>.Create(ABindSourceAdapter,
      AFieldDef.Name, TBindSourceAdapterFieldType.Create(LTypeInfo.NameFld.ToString, LTypeInfo.Kind), AGetMemberObject,
      TBindFieldDefValueReader<T>.Create, TBindFieldDefValueWriter<T>.Create,
      AFieldDef.MemberType)
end;

class function TCustomDataGeneratorAdapter.CreateObjectField<T>(AFieldDef: TGeneratorFieldDef; ABindSourceAdapter: TBindSourceAdapter;
  const AGetMemberObject: IGetMemberObject; LDummy: TDummy<T>): TBindSourceAdapterField;
var
  LTypeInfo: PTypeInfo;
begin
  LTypeInfo := AFieldDef.TypeInfo;
  Assert(LTypeInfo <> nil);
  if AFieldDef.ReadOnly then
    Result := TBindSourceAdapterReadObjectField<T>.Create(ABindSourceAdapter,
      AFieldDef.Name, TBindSourceAdapterFieldType.Create(LTypeInfo.NameFld.ToString, LTypeInfo.Kind), AGetMemberObject,
      TBindFieldDefValueReader<T>.Create,
      AFieldDef.MemberType)
  else
    Result := TBindSourceAdapterReadWriteObjectField<T>.Create(ABindSourceAdapter,
      AFieldDef.Name, TBindSourceAdapterFieldType.Create(LTypeInfo.NameFld.ToString, LTypeInfo.Kind), AGetMemberObject,
      TBindFieldDefObjectValueReader<T>.Create, TBindFieldDefObjectValueWriter<T>.Create,
      AFieldDef.MemberType)
end;


class procedure TCustomDataGeneratorAdapter.AddFieldsToList(AFieldDefs: TGeneratorFieldDefs;
      ABindSourceAdapter: TBindSourceAdapter;
      AFieldsList: TList<TBindSourceAdapterField>; const AGetMemberObject: IGetMemberObject);
var
  LFieldDef: TGeneratorFieldDef;
  LCollectionEditorField: TBindSourceAdapterField;
  LTypeInfo: PTypeInfo;
  I: Integer;
begin
  AFieldsList.Clear;
  for I := 0 to AFieldDefs.Count - 1 do
  begin
    LFieldDef := AFieldDefs.GetFieldDef(I);                        
    LCollectionEditorField := nil;
    LTypeInfo := LFieldDef.TypeInfo;
    if LTypeInfo = nil then
      continue;
    case LTypeInfo.Kind of
      tkClass:
        case LFieldDef.FieldType of
          ftTStrings:
            LCollectionEditorField := CreateObjectField<TStrings>(LFieldDef,
              ABindSourceAdapter, AGetMemberObject);
        else
            LCollectionEditorField := CreateObjectField<TPersistent>(LFieldDef,
              ABindSourceAdapter, AGetMemberObject);
        end;
      tkEnumeration:
        if LFieldDef.FieldType = ftBoolean then
          LCollectionEditorField := CreateField<Boolean>(LFieldDef,
            ABindSourceAdapter, AGetMemberObject);
      tkWChar:
          LCollectionEditorField := CreateField<char>(LFieldDef,
            ABindSourceAdapter, AGetMemberObject);
      tkUString:
          LCollectionEditorField := CreateField<string>(LFieldDef,
            ABindSourceAdapter, AGetMemberObject);
{$IFNDEF NEXTGEN}
      tkChar:
          LCollectionEditorField := CreateField<ansichar>(LFieldDef,
            ABindSourceAdapter, AGetMemberObject);
      tkLString:
        LCollectionEditorField := CreateField<AnsiString>(LFieldDef,
          ABindSourceAdapter, AGetMemberObject);
      tkString:
        LCollectionEditorField := CreateField<ShortString>(LFieldDef,
          ABindSourceAdapter, AGetMemberObject);
{$ENDIF}
      tkInteger:
            case System.TypInfo.GetTypeData(LTypeInfo).OrdType of
              otSByte: // Int8
                LCollectionEditorField := CreateField<int8>(LFieldDef,
                  ABindSourceAdapter, AGetMemberObject);
              otSWord: // Int16
                LCollectionEditorField := CreateField<int16>(LFieldDef,
                  ABindSourceAdapter, AGetMemberObject);
              otSLong: // Int32
                LCollectionEditorField := CreateField<int32>(LFieldDef,
                  ABindSourceAdapter, AGetMemberObject);
              otUByte: // UInt8
                LCollectionEditorField := CreateField<uint8>(LFieldDef,
                  ABindSourceAdapter, AGetMemberObject);
              otUWord: // UInt16
                LCollectionEditorField := CreateField<uint16>(LFieldDef,
                  ABindSourceAdapter, AGetMemberObject);
              otULong: //UInt32
                LCollectionEditorField := CreateField<uint32>(LFieldDef,
                  ABindSourceAdapter, AGetMemberObject);
            else
              LCollectionEditorField := CreateField<integer>(LFieldDef,
                ABindSourceAdapter, AGetMemberObject);
            end;
      tkInt64:
          if LTypeInfo.TypeData.MinInt64Value > LTypeInfo.TypeData.MaxInt64Value then
            LCollectionEditorField := CreateField<Uint64>(LFieldDef,
              ABindSourceAdapter, AGetMemberObject)
          else
            LCollectionEditorField := CreateField<int64>(LFieldDef,
              ABindSourceAdapter, AGetMemberObject);
      tkFloat:
        case LFieldDef.FieldType of
          ftSingle:
            LCollectionEditorField := CreateField<single>(LFieldDef,
            ABindSourceAdapter, AGetMemberObject);
          ftCurrency:
            LCollectionEditorField := CreateField<currency>(LFieldDef,
            ABindSourceAdapter, AGetMemberObject);
          ftDateTime:
            LCollectionEditorField := CreateField<TDatetime>(LFieldDef,
            ABindSourceAdapter, AGetMemberObject);
          ftDate:
            LCollectionEditorField := CreateField<TDate>(LFieldDef,
            ABindSourceAdapter, AGetMemberObject);
          ftTime:
            LCollectionEditorField := CreateField<TTime>(LFieldDef,
            ABindSourceAdapter, AGetMemberObject);
        else
          Assert(False);
          LCollectionEditorField := CreateField<single>(LFieldDef,
            ABindSourceAdapter, AGetMemberObject);
        end;
    end;
    if LCollectionEditorField <> nil then
    begin
      LCollectionEditorField.FGetMemberObject := AGetMemberObject;
      AFieldsList.Add(LCollectionEditorField);
    end;
  end;

end;

function TCustomDataGeneratorAdapter.CreateItemInstance: TGeneratorRecord;
begin
  Result := TGeneratorRecord.Create;
end;

procedure TCustomDataGeneratorAdapter.InitItemInstance(ARecord: TGeneratorRecord);
var
  I: Integer;
  LFieldDef: TGeneratorFieldDef;
begin
  for I := 0 to FieldDefs.Count - 1 do
  begin
    LFieldDef := FieldDefs[I];
    case LFieldDef.FieldType of
      ftString:
        ARecord.FDictionary.Add(LFieldDef.Name, '');
      ftInteger,
      ftUInteger:
        ARecord.FDictionary.Add(LFieldDef.Name, 0);
      ftSingle:
        ARecord.FDictionary.Add(LFieldDef.Name, 0);
      ftBoolean:
        ARecord.FDictionary.Add(LFieldDef.Name, False);
      ftTStrings:
        ARecord.FDictionary.Add(LFieldDef.Name, TStringList.Create);
      ftBitmap:
        ARecord.FDictionary.Add(LFieldDef.Name, nil);
      ftCurrency:
        ARecord.FDictionary.Add(LFieldDef.Name, TValue.Empty.AsType<Currency>);
      ftDateTime:
        ARecord.FDictionary.Add(LFieldDef.Name, TValue.Empty.AsType<TDateTime>);
      ftTime:
        ARecord.FDictionary.Add(LFieldDef.Name, TValue.Empty.AsType<TTime>);
      ftDate:
        ARecord.FDictionary.Add(LFieldDef.Name, TValue.Empty.AsType<TDate>);
    else
      Assert(False);
    end;
  end;
end;

procedure TCustomDataGeneratorAdapter.AddFields;
var
  LGetMemberObject: IGetMemberObject;
begin
  LGetMemberObject := TBindSourceAdapterGetMemberObject.Create(Self);
  AddFieldsToList(Self.FieldDefs, Self, Self.Fields, LGetMemberObject);

end;

function TCustomDataGeneratorAdapter.GetCanActivate: Boolean;
begin
  Result := True;
end;

function TCustomDataGeneratorAdapter.GetCanInsert: Boolean;
begin
  Result := (loptAllowInsert in Options);
end;

constructor TCustomDataGeneratorAdapter.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FFieldDefs := GetFieldDefsClass.Create(Self);
  FRecordCount := -1;
end;

destructor TCustomDataGeneratorAdapter.Destroy;
begin
  FreeAndNil(FFieldDefs);
  inherited;
end;

procedure TCustomDataGeneratorAdapter.FieldDefChanged(Sender: TObject);
var
  LActive: Boolean;
begin
  LActive := Active;
  if LActive then
    Active := False;
  Self.AddFields;
  if Self.List <> nil then
    Self.GenerateExistingRecords(Self.List);
  Active := LActive;
end;

function TCustomDataGeneratorAdapter.SupportsNestedFields: Boolean;
begin
  Result := False;
end;

procedure TCustomDataGeneratorAdapter.SetActive(Value: Boolean);
begin
  if Value and (List = nil) then
  begin
    SetList(TObjectList<TGeneratorRecord>.Create); // Owns records
    GenerateExistingRecords(List);
  end;
  inherited;
end;

procedure TCustomDataGeneratorAdapter.SetFieldDefs(Value: TGeneratorFieldDefs);
begin
  FFieldDefs.Assign(Value);
end;

procedure TCustomDataGeneratorAdapter.SetRecordCount(const Value: Integer);
var
  LActive: Boolean;
begin
  if Value <> FRecordCount then
  begin
    FRecordCount := Value;
    LActive := Active;
    if LActive then
      Active := False;
    if FRecordCount > 0 then
      if ItemIndex >= 0 then
        ItemIndex := Min(FRecordCount - 1, ItemIndex)
      else
        ItemIndex := 0
    else
      ItemIndex := 0;
    if Self.List <> nil then
      GenerateExistingRecords(Self.List);
    Active := LActive;
  end;
end;

function TCustomDataGeneratorAdapter.GetFieldDefsClass: TGeneratorBindFieldDefsClass;
begin
  Result := TGeneratorFieldDefs;
end;

procedure TCustomDataGeneratorAdapter.GetMemberNames(AList: TStrings);
var
  LFieldDef: TGeneratorFieldDef;
begin
  for LFieldDef in FFieldDefs do
    AList.AddObject(LFieldDef.Name, LFieldDef);
end;

procedure TCustomDataGeneratorAdapter.InitFieldDefs;
begin

end;

constructor TTypedCustomFormatObject<T>.Create;
begin
end;

procedure TCustomDataGeneratorAdapter.CreateCustomFormatExpression<T>(const ACustomFormat: string;
  out AExpression: TBindingExpression; out ACustomFormatObject: TCustomFormatObject);
const
  sGenerator = '_G';
  sGeneratorValue = '_G.V';
var
  LExpression: TBindingExpression;
  LScope: IScope;
  LCustomFormatObject: TTypedCustomFormatObject<T>;
begin
  LExpression := nil;
  LCustomFormatObject := TTypedCustomFormatObject<T>.Create;
  try
    LScope :=  TBindings.CreateAssociationScope(
      TArray<TBindingAssociation>.Create(
        TBindingAssociation.Create(LCustomFormatObject, sGenerator)));
    LExpression := TBindings.CreateExpression(
      LScope,
      Format(ACustomFormat, [sGeneratorValue]),
      TBindingEventRec.Create(TBindingEvalErrorEvent(nil) (*DoOnEvalError*)));
  except
    LExpression.Free;
    LExpression := nil;
    LCustomFormatObject.Free;
    LCustomFormatObject := nil;
    // Ignore and don't provide an expression
  end;
  AExpression := LExpression;
  ACustomFormatObject := LCustomFormatObject;
end;


procedure TCustomDataGeneratorAdapter.GenerateExistingRecords(AList: TList<TGeneratorRecord>);

  procedure InitExistingRecord(ARecord: TGeneratorRecord; AGenerators: TList<TValueGenerator>;
    AExpressions: TList<TBindingExpression>; AExpressionObjects: TList<TCustomFormatObject>;
    AGetDefaultValue: TFunc<Integer, TValue>);
  var
    I: Integer;
    LFieldDef: TGeneratorFieldDef;
    LGenerator: TValueGenerator;
    LValue: TValue;
    LExpression: TBindingExpression;
    LObject: TCustomFormatObject;
    LIValue: IValue;
    LFree: Boolean;


  begin
    for I := 0 to FieldDefs.Count - 1 do
    begin
      LFree := False;
      LFieldDef := FieldDefs[I];
      LGenerator := AGenerators[I];
      LExpression := AExpressions[I];
      LObject := AExpressionObjects[I];
      LValue := TValue.Empty;
      if LGenerator <> nil then
      begin
        LValue := LGenerator.GetValue(LFree);
        if LFree then
          Assert(LValue.IsObject);
      end
      else
      begin
        // LValue := ADefaultValues[I];
        LValue := AGetDefaultValue(I);
        LFree := LValue.IsObject and (LValue.AsObject <> nil);
      end;
      if LExpression <> nil then
      begin
        Assert(LObject <> nil);
        LObject.SetTValue(LValue);
        LIValue := LExpression.Evaluate;
        LValue := LIValue.GetValue;
      end;
      ARecord.FDictionary.Add(LFieldDef.Name, LValue);
      if LFree and LValue.IsObject then
        ARecord.FFreeObjects.Add(LValue.AsObject);
    end;
  end;

  function Validate(AExpression: TBindingExpression; AObject: TCustomFormatObject; AValue: TValue): Boolean;
  begin
    Result := True;
    try
      Assert(AObject <> nil);
      AObject.SetTValue(AValue);
      AExpression.Evaluate;
    except
      Result := False;
    end;
  end;
var
  I: Integer;
  LRecordCount: integer;
  LRecord: TGeneratorRecord;
  LFieldDef: TGeneratorFieldDef;
  LGenerators: TList<TValueGenerator>;
  LGenerator: TValueGenerator;
  LGeneratorRecord: TValueGeneratorDescription;
  LCustomFormatExpressions: TList<TBindingExpression>;
  LCustomFormatExpression: TBindingExpression;
  LExpressionObjects: TList<TCustomFormatObject>;
  LExpressionObject: TCustomFormatObject;
  LDefaultValues: TList<TValue>;
  LDefaultValue: TValue;
  LMinNoRepeat: Integer;
begin
  LExpressionObjects := nil;
  LCustomFormatExpressions := nil;
  LDefaultValues := nil;
  try
  AList.Clear;
  LRecordCount := RecordCount;
  if LRecordCount <> 0 then
  begin
    LGenerators := TObjectList<TValueGenerator>.Create; // Owns objects
    LExpressionObjects := TObjectList<TCustomFormatObject>.Create;
    LCustomFormatExpressions := TObjectList<TBindingExpression>.Create;
    LDefaultValues := TList<TValue>.Create;
    try
      for I := 0 to FieldDefs.Count - 1 do
      begin
        LFieldDef := FieldDefs[I];
        LGenerator := nil;
        LCustomFormatExpression := nil;
        LExpressionObject := nil;
        if LFieldDef.Generator <> '' then
          if FindRegisteredValueGenerator(LFieldDef.Generator, LFieldDef.FFieldType, LGeneratorRecord) then
            LGenerator := LGeneratorRecord.ClassType.Create(LFieldDef);
        // LGenerator may be nil
        LGenerators.Add(LGenerator);
        case LFieldDef.FieldType of
          ftString:
          begin
            if LFieldDef.CustomFormat <> '' then
              Self.CreateCustomFormatExpression<string>(LFieldDef.CustomFormat,
                LCustomFormatExpression, LExpressionObject);
            LDefaultValue := TValue.Empty.AsType<string>;
          end;
          ftInteger:
          begin
            if LFieldDef.CustomFormat <> '' then
              Self.CreateCustomFormatExpression<integer>(LFieldDef.CustomFormat,
                LCustomFormatExpression, LExpressionObject);
            LDefaultValue := TValue.Empty.AsType<integer>;
          end;
          ftSingle:
          begin
            if LFieldDef.CustomFormat <> '' then
              Self.CreateCustomFormatExpression<single>(LFieldDef.CustomFormat,
                LCustomFormatExpression, LExpressionObject);
            LDefaultValue := TValue.Empty.AsType<single>;
          end;
          ftBoolean:
          begin
            if LFieldDef.CustomFormat <> '' then
              Self.CreateCustomFormatExpression<Boolean>(LFieldDef.CustomFormat,
                LCustomFormatExpression, LExpressionObject);
            LDefaultValue := TValue.Empty.AsType<Boolean>;
          end;
          ftBitmap,
          ftTStrings:
          begin
            if LFieldDef.CustomFormat <> '' then
              Self.CreateCustomFormatExpression<TObject>(LFieldDef.CustomFormat,
                LCustomFormatExpression, LExpressionObject);
            LDefaultValue := TValue.Empty.AsType<TObject>;
          end;
          ftUInteger:
          begin
            if LFieldDef.CustomFormat <> '' then
              Self.CreateCustomFormatExpression<uint32>(LFieldDef.CustomFormat,
                LCustomFormatExpression, LExpressionObject);
            LDefaultValue := TValue.Empty.AsType<uint32>;
          end;
          ftCurrency:
          begin
            if LFieldDef.CustomFormat <> '' then
              Self.CreateCustomFormatExpression<currency>(LFieldDef.CustomFormat,
                LCustomFormatExpression, LExpressionObject);
            LDefaultValue := TValue.Empty.AsType<currency>;
          end;
          ftDateTime:
          begin
            if LFieldDef.CustomFormat <> '' then
              Self.CreateCustomFormatExpression<TDateTime>(LFieldDef.CustomFormat,
                LCustomFormatExpression, LExpressionObject);
            LDefaultValue := TValue.Empty.AsType<TDateTime>;
          end;
          ftTime:
          begin
            if LFieldDef.CustomFormat <> '' then
              Self.CreateCustomFormatExpression<TTime>(LFieldDef.CustomFormat,
                LCustomFormatExpression, LExpressionObject);
            LDefaultValue := TValue.Empty.AsType<TDate>;
          end;
          ftDate:
          begin
            if LFieldDef.CustomFormat <> '' then
              Self.CreateCustomFormatExpression<TDate>(LFieldDef.CustomFormat,
                LCustomFormatExpression, LExpressionObject);
            LDefaultValue := TValue.Empty.AsType<TTime>;
          end;
        else
          LDefaultValue := TValue.Empty;
          Assert(False);
        end;
        if LCustomFormatExpression <> nil then
          if not Validate(LCustomFormatExpression, LExpressionObject, LDefaultValue) then
            FreeAndNil(LCustomFormatExpression);
        LCustomFormatExpressions.Add(LCustomFormatExpression);
        LExpressionObjects.Add(LExpressionObject);
        LDefaultValues.Add(LDefaultValue);
      end;
      if LRecordCount < 0 then
      begin
        LMinNoRepeat := MaxInt;
        for LGenerator in LGenerators do
        begin
          if LGenerator <> nil then
            if not (TGeneratorOption.optRepeat in LGenerator.Options) then
              LMinNoRepeat := Min(LMinNoRepeat, LGenerator.RecordCount);
        end;
        // If any can't repeat then constrain record count to number of unique records
        if LMinNoRepeat <> MaxInt then
          LRecordCount := LMinNoRepeat;
      end;
      if LRecordCount < 0 then
        LRecordCount := 200;
      if csDesigning in ComponentState then
        // Make sure we don't lock up the ide displaying a large number of records
        LRecordCount := Min(1000, LRecordCount);
      for I := 0 to LRecordCount - 1 do
      begin
        LRecord := TGeneratorRecord.Create;
        try
          for LGenerator in LGenerators do
            if LGenerator <> nil then
              if I = 0 then
                LGenerator.FirstRecord
              else
                LGenerator.NextRecord;

          InitExistingRecord(LRecord, LGenerators,
            LCustomFormatExpressions, LExpressionObjects,
            function(I: Integer): TValue
            begin
              case FieldDefs[I].FFieldType of
                ftBitmap:
                                   
                  Result := LDefaultValues[I];
                ftTStrings:
                  Result := TStringList.Create;
              else
                Result := LDefaultValues[I];
              end;
            end);
          AList.Add(LRecord);
        except
          LRecord.Free;
        end;
      end;
    finally
      LGenerators.Free;
    end;
  end;
  finally
    LCustomFormatExpressions.Free;
    LExpressionObjects.Free;
    LDefaultValues.Free;
  end;
end;

class function TBindSourceAdapter.CreateRttiFieldField<T>(AProperty: TRttiField; ABindSourceAdapter: TBindSourceAdapter;
  const AGetMemberObject: IGetMemberObject; AMemberType: TScopeMemberType; LDummy: TDummy<T>): TBindSourceAdapterField;
begin
  Result := TBindSourceAdapterReadWriteField<T>.Create(ABindSourceAdapter,
    AProperty.Name, TBindSourceAdapterFieldType.Create(AProperty.FieldType.Name, AProperty.FieldType.TypeKind), AGetMemberObject,
    TFieldValueReader<T>.Create, TFieldValueWriter<T>.Create, AMemberType)
end;


class function TBindSourceAdapter.CreateRttiObjectFieldField<T>(AProperty: TRttiField; ABindSourceAdapter: TBindSourceAdapter;
  const AGetMemberObject: IGetMemberObject; AMemberType: TScopeMemberType; LDummy: TDummy<T>): TBindSourceAdapterField;
begin
  Result := TBindSourceAdapterReadWriteObjectField<T>.Create(ABindSourceAdapter,
    AProperty.Name, TBindSourceAdapterFieldType.Create(AProperty.FieldType.Name, AProperty.FieldType.TypeKind), AGetMemberObject,
    TFieldValueReader<T>.Create, TFieldValueWriter<T>.Create, AMemberType)
end;


class procedure TBindSourceAdapter.AddFieldsToList(AType: TRttiType;
      ABindSourceAdapter: TBindSourceAdapter;
      AFieldsList: TList<TBindSourceAdapterField>; const AGetMemberObject: IGetMemberObject);
const
  sTStrings = 'TStrings';
  sTPersistent = 'TPersistent';
var
  LType: TRttiType;
  LFields: TArray<TRttiField>;
  LField: TRttiField;
  LCollectionEditorField: TBindSourceAdapterField;
  LTypeName: string;
  LTypeInfo: PTypeInfo;
  LInstance: TRttiInstanceType;
  LAncestor: string;
begin
  LType := AType;
  LFields := LType.GetFields;
  for LField in LFields do
  begin
    if LField.FieldType = nil then
      continue;
    LCollectionEditorField := nil;
    case LField.Visibility of
      TMemberVisibility.mvPublic, TMemberVisibility.mvPublished:
      begin
        LTypeName := LField.FieldType.Name;
        LTypeInfo := LField.FieldType.Handle;
        case LField.FieldType.TypeKind of
          tkEnumeration:
            if SameText(LTypeName, 'boolean') or SameText(LTypeName, 'bool') then // 'bool' for C++
              LCollectionEditorField := CreateRttiFieldField<Boolean>(LField,
                ABindSourceAdapter, AGetMemberObject, mtBoolean);
          tkInteger:
              case System.TypInfo.GetTypeData(LField.FieldType.Handle).OrdType of
                otSByte: // Int8
                  LCollectionEditorField := CreateRttiFieldField<Int8>(LField,
                    ABindSourceAdapter, AGetMemberObject, mtInteger);
                otSWord: // Int16
                  LCollectionEditorField := CreateRttiFieldField<Int16>(LField,
                    ABindSourceAdapter, AGetMemberObject, mtInteger);
                otSLong: // Int32
                  LCollectionEditorField := CreateRttiFieldField<Int32>(LField,
                    ABindSourceAdapter, AGetMemberObject, mtInteger);
                otUByte: // UInt8
                  LCollectionEditorField := CreateRttiFieldField<UInt8>(LField,
                    ABindSourceAdapter, AGetMemberObject, mtUInteger);
                otUWord: // UInt16
                  LCollectionEditorField := CreateRttiFieldField<UInt16>(LField,
                    ABindSourceAdapter, AGetMemberObject, mtUInteger);
                otULong: // UInt32
                  LCollectionEditorField := CreateRttiFieldField<UInt32>(LField,
                    ABindSourceAdapter, AGetMemberObject, mtUInteger);
              else
                LCollectionEditorField := CreateRttiFieldField<Integer>(LField,
                  ABindSourceAdapter, AGetMemberObject, mtInteger);
              end;
          tkWChar:
              LCollectionEditorField := CreateRttiFieldField<char>(LField,
                ABindSourceAdapter, AGetMemberObject, mtChar);
          tkUString:
              LCollectionEditorField := CreateRttiFieldField<string>(LField,
                ABindSourceAdapter, AGetMemberObject, mtText);
{$IFNDEF NEXTGEN}
          tkChar:
              LCollectionEditorField := CreateRttiFieldField<ansichar>(LField,
                ABindSourceAdapter, AGetMemberObject, mtChar);
          tkString:
              LCollectionEditorField := CreateRttiFieldField<ShortString>(LField,
                ABindSourceAdapter, AGetMemberObject, mtText);
          tkLString:
              LCollectionEditorField := CreateRttiFieldField<AnsiString>(LField,
                ABindSourceAdapter, AGetMemberObject, mtText);
{$ENDIF}
          tkFloat:
            begin
              case LTypeInfo.TypeData^.FloatType of
                System.TypInfo.ftSingle:
                  LCollectionEditorField := CreateRttiFieldField<single>(LField,
                    ABindSourceAdapter, AGetMemberObject, mtFloat);
                System.TypInfo.ftDouble:
                begin
                  if LTypeinfo = System.TypeInfo(TDate) then
                    LCollectionEditorField := CreateRttiFieldField<TDate>(LField,
                      ABindSourceAdapter, AGetMemberObject, mtDate)
                  else if LTypeinfo = System.TypeInfo(TTime) then
                    LCollectionEditorField := CreateRttiFieldField<TTime>(LField,
                      ABindSourceAdapter, AGetMemberObject, mtTime)
                  else if LTypeinfo = System.TypeInfo(TDateTime) then
                    LCollectionEditorField := CreateRttiFieldField<TDateTime>(LField,
                      ABindSourceAdapter, AGetMemberObject, mtDateTime)
                  else
                    LCollectionEditorField := CreateRttiFieldField<double>(LField,
                      ABindSourceAdapter, AGetMemberObject, mtFloat);
                end;
                ftExtended:
                  LCollectionEditorField := CreateRttiFieldField<Extended>(LField,
                    ABindSourceAdapter, AGetMemberObject, mtFloat);
                ftCurr:
                  LCollectionEditorField := CreateRttiFieldField<currency>(LField,
                    ABindSourceAdapter, AGetMemberObject, mtCurrency);
                // ftComp:  // Not supported
              else
                Assert(False);
                LCollectionEditorField := CreateRttiFieldField<Extended>(LField,
                  ABindSourceAdapter, AGetMemberObject, mtFloat);
              end;
           end;
          tkInt64:
              if LTypeInfo.TypeData.MinInt64Value > LTypeInfo.TypeData.MaxInt64Value then
                LCollectionEditorField := CreateRttiFieldField<UInt64>(LField,
                  ABindSourceAdapter, AGetMemberObject, mtUInteger)
              else
                LCollectionEditorField := CreateRttiFieldField<Int64>(LField,
                  ABindSourceAdapter, AGetMemberObject, mtInteger);
          tkClass:
          begin
            if LField.FieldType.IsInstance then
            begin
              LInstance :=  LField.FieldType.AsInstance;
              while LInstance <> nil do
              begin
                LAncestor := LInstance.Name;
                if LAncestor = sTStrings then
                  break;
                if LAncestor = sTPersistent then
                  break;
                LInstance := LInstance.BaseType;
              end;
            end;
            if LAncestor = sTStrings then
              LCollectionEditorField := CreateRttiObjectFieldField<TObject>(LField,
                ABindSourceAdapter, AGetMemberObject, mtMemo)
            else if LAncestor = sTPersistent then
             LCollectionEditorField := CreateRttiObjectFieldField<TObject>(LField,
                ABindSourceAdapter, AGetMemberObject, mtBitmap)
            else
              LCollectionEditorField := CreateRttiObjectFieldField<TObject>(LField,
                ABindSourceAdapter, AGetMemberObject, mtObject)
                                            
          end;
        end;
        if LCollectionEditorField <> nil then
        begin
          LCollectionEditorField.FGetMemberObject := AGetMemberObject;
          AFieldsList.Add(LCollectionEditorField);
        end;
      end;

    end;

  end;
end;

class function TBindSourceAdapter.CreateRttiPropertyField<T>(AProperty: TRttiProperty; ABindSourceAdapter: TBindSourceAdapter;
  const AGetMemberObject: IGetMemberObject; AMemberType: TScopeMemberType; LDummy: TDummy<T>): TBindSourceAdapterField;
begin
  Result := nil;
  if AProperty.IsReadable then
    if AProperty.IsWritable then
       Result := TBindSourceAdapterReadWriteField<T>.Create(ABindSourceAdapter, AProperty.Name,
        TBindSourceAdapterFieldType.Create(AProperty.PropertyType.Name, AProperty.PropertyType.TypeKind), AGetMemberObject,
        TPropertyValueReader<T>.Create, TPropertyValueWriter<T>.Create, AMemberType)
    else
       Result := TBindSourceAdapterReadField<T>.Create(ABindSourceAdapter, AProperty.Name,
        TBindSourceAdapterFieldType.Create(AProperty.PropertyType.Name, AProperty.PropertyType.TypeKind), AGetMemberObject,
        TPropertyValueReader<T>.Create, AMemberType);
end;

class function TBindSourceAdapter.CreateRttiObjectPropertyField<T>(AProperty: TRttiProperty; ABindSourceAdapter: TBindSourceAdapter;
  const AGetMemberObject: IGetMemberObject; AMemberType: TScopeMemberType; LDummy: TDummy<T>): TBindSourceAdapterField;
begin
  Result := nil;
  if AProperty.IsReadable then
    if AProperty.IsWritable then
       Result := TBindSourceAdapterReadWriteObjectField<T>.Create(ABindSourceAdapter, AProperty.Name,
        TBindSourceAdapterFieldType.Create(AProperty.PropertyType.Name, AProperty.PropertyType.TypeKind), AGetMemberObject,
        TPropertyValueReader<T>.Create, TPropertyValueWriter<T>.Create, AMemberType)
    else
       Result := TBindSourceAdapterReadObjectField<T>.Create(ABindSourceAdapter, AProperty.Name,
        TBindSourceAdapterFieldType.Create(AProperty.PropertyType.Name, AProperty.PropertyType.TypeKind), AGetMemberObject,
        TPropertyValueReader<T>.Create, AMemberType);
end;

class procedure TBindSourceAdapter.AddPropertiesToList(AType: TRttiType; ABindSourceAdapter: TBindSourceAdapter; AFieldsList: TList<TBindSourceAdapterField>;
  const AGetMemberObject: IGetMemberObject);
const
  sTStrings = 'TStrings';
  sTPersistent = 'TPersistent';
var
  LType: TRttiType;
  LProperties: TArray<TRttiProperty>;
  LProperty: TRttiProperty;
  LCollectionEditorField: TBindSourceAdapterField;
  LTypeInfo: PTypeInfo;
  LTypeName: string;
  LTypeData: PTypeData;
  LInstance: TRttiInstanceType;
  LAncestor: string;
begin
  LType := AType;
  LProperties := LType.GetProperties;
  for LProperty in LProperties do
  begin
    LCollectionEditorField := nil;
    LTypeInfo := LProperty.PropertyType.Handle;
    if LTypeInfo = nil then
      continue;
    LTypeName := LProperty.PropertyType.Name;
    LTypeData :=  System.TypInfo.GetTypeData(LTypeInfo);
    case LProperty.Visibility of
      TMemberVisibility.mvPublic, TMemberVisibility.mvPublished:
      begin
        {$IFDEF NEXTGEN}
        if (LProperty.Name = 'Disposed') or (LProperty.Name = 'RefCount') then
          continue;
        {$ENDIF}
        case LProperty.PropertyType.TypeKind of
          tkEnumeration:
            if SameText(LTypeName, 'boolean') or SameText(LTypeName, 'bool') then // 'bool' for C++
              LCollectionEditorField := CreateRttiPropertyField<Boolean>(LProperty,
                ABindSourceAdapter, AGetMemberObject, mtBoolean);
          tkInteger:
          begin
              case LTypeData.OrdType of
                otSByte: // Int8
                  LCollectionEditorField := CreateRttiPropertyField<Int8>(LProperty,
                    ABindSourceAdapter, AGetMemberObject, mtInteger);
                otSWord: // Int16
                  LCollectionEditorField := CreateRttiPropertyField<Int16>(LProperty,
                    ABindSourceAdapter, AGetMemberObject, mtInteger);
                otSLong: // Int32
                  LCollectionEditorField := CreateRttiPropertyField<Int32>(LProperty,
                    ABindSourceAdapter, AGetMemberObject, mtInteger);
                otUByte: // UInt8
                  LCollectionEditorField := CreateRttiPropertyField<UInt8>(LProperty,
                    ABindSourceAdapter, AGetMemberObject, mtUInteger);
                otUWord: // UInt16
                  LCollectionEditorField := CreateRttiPropertyField<UInt16>(LProperty,
                    ABindSourceAdapter, AGetMemberObject, mtUInteger);
                otULong: // UInt32
                  LCollectionEditorField := CreateRttiPropertyField<UInt32>(LProperty,
                    ABindSourceAdapter, AGetMemberObject, mtUInteger);
              else
                LCollectionEditorField := CreateRttiPropertyField<Integer>(LProperty,
                  ABindSourceAdapter, AGetMemberObject, mtInteger);
              end
          end;
          tkWChar:
            LCollectionEditorField := CreateRttiPropertyField<Char>(LProperty,
              ABindSourceAdapter, AGetMemberObject, mtChar);
          tkUString:
            LCollectionEditorField := CreateRttiPropertyField<string>(LProperty,
              ABindSourceAdapter, AGetMemberObject, mtText);
{$IFNDEF NEXTGEN}
          tkChar:
            LCollectionEditorField := CreateRttiPropertyField<AnsiChar>(LProperty,
              ABindSourceAdapter, AGetMemberObject, mtChar);
          tkString:
            LCollectionEditorField := CreateRttiPropertyField<ShortString>(LProperty,
              ABindSourceAdapter, AGetMemberObject, mtText);
          tkLString:
            LCollectionEditorField := CreateRttiPropertyField<AnsiString>(LProperty,
              ABindSourceAdapter, AGetMemberObject, mtText);
{$ENDIF}
          tkFloat:
            case LTypeData^.FloatType of
              System.TypInfo.ftSingle:
                LCollectionEditorField := CreateRttiPropertyField<single>(LProperty,
                  ABindSourceAdapter, AGetMemberObject, mtFloat);
              System.TypInfo.ftDouble:
              begin
                if LTypeinfo = System.TypeInfo(TDate) then
                  LCollectionEditorField := CreateRttiPropertyField<TDate>(LProperty,
                    ABindSourceAdapter, AGetMemberObject, mtDate)
                else if LTypeinfo = System.TypeInfo(TTime) then
                  LCollectionEditorField := CreateRttiPropertyField<TTime>(LProperty,
                    ABindSourceAdapter, AGetMemberObject, mtTime)
                else if LTypeinfo = System.TypeInfo(TDateTime) then
                  LCollectionEditorField := CreateRttiPropertyField<TDateTime>(LProperty,
                    ABindSourceAdapter, AGetMemberObject, mtDateTime)
                else
                  LCollectionEditorField := CreateRttiPropertyField<double>(LProperty,
                    ABindSourceAdapter, AGetMemberObject, mtFloat);
              end;
              ftExtended:
                LCollectionEditorField := CreateRttiPropertyField<Extended>(LProperty,
                  ABindSourceAdapter, AGetMemberObject, mtFloat);
              ftCurr:
                LCollectionEditorField := CreateRttiPropertyField<currency>(LProperty,
                  ABindSourceAdapter, AGetMemberObject, mtCurrency);
              // ftComp:  // Not supported
            else
              Assert(False);
              LCollectionEditorField := CreateRttiPropertyField<Extended>(LProperty,
                ABindSourceAdapter, AGetMemberObject, mtFloat);
            end;
          tkInt64:
            if LTypeData.MinInt64Value > LTypeData.MaxInt64Value then
              LCollectionEditorField := CreateRttiPropertyField<UInt64>(LProperty,
                ABindSourceAdapter, AGetMemberObject, mtUInteger)
            else
              LCollectionEditorField := CreateRttiPropertyField<Int64>(LProperty,
                ABindSourceAdapter, AGetMemberObject, mtInteger);
          tkClass:
          begin
            if LProperty.PropertyType.IsInstance then
            begin
              LInstance :=  LProperty.PropertyType.AsInstance;
              while LInstance <> nil do
              begin
                LAncestor := LInstance.Name;
                if LAncestor = sTStrings then
                  break;
                if LAncestor = sTPersistent then
                  break;
                LInstance := LInstance.BaseType;
              end;
            end;
            if LAncestor = sTStrings then
              LCollectionEditorField := CreateRttiObjectPropertyField<TObject>(LProperty,
                ABindSourceAdapter, AGetMemberObject, mtMemo)
            else if LAncestor = sTPersistent then
              LCollectionEditorField := CreateRttiObjectPropertyField<TObject>(LProperty,
                ABindSourceAdapter, AGetMemberObject, mtBitmap)
            else
              LCollectionEditorField := CreateRttiObjectPropertyField<TObject>(LProperty,
                ABindSourceAdapter, AGetMemberObject, mtObject)
                                            
          end;
        end;
        if LCollectionEditorField <> nil then
        begin
          LCollectionEditorField.FGetMemberObject := AGetMemberObject;
          AFieldsList.Add(LCollectionEditorField);
        end;
      end;

    end;

  end;
end;

procedure TListBindSourceAdapter<T>.AddFields;
var
  LType: TRttiType;
  LGetMemberObject: IGetMemberObject;
begin
  LType := GetObjectType;
  LGetMemberObject := TBindSourceAdapterGetMemberObject.Create(Self);
  AddFieldsToList(LType, Self, Self.Fields, LGetMemberObject);
  AddPropertiesToList(LType, Self, Self.Fields, LGetMemberObject);
end;

{ TBindSourceAdapterReadWriteField<T> }

procedure TBindSourceAdapterReadWriteField<T>.ClearBuffer;
begin
  //
end;

constructor TBindSourceAdapterReadWriteField<T>.Create(AOwner: TBindSourceAdapter;
  const AMemberName: string; AType: TBindSourceAdapterFieldType; const AGetMemberObject: IGetMemberObject;
  const AReader: TValueReader<T>; const AWriter: TValueWriter<T>; AMemberType: TScopeMemberType);
begin
  inherited Create(AOwner, AMemberName, AType, AGetMemberObject, AReader, AMemberType);
  FValueWriter := AWriter;
  AWriter.FField := Self;
end;

destructor TBindSourceAdapterReadWriteField<T>.Destroy;
begin
  FValueWriter.Free;
  inherited;
end;

function TBindSourceAdapterReadWriteField<T>.GetSetter(var AGetter: string): Boolean;
begin
  AGetter := sMemberName;
  Result := True;

end;

function TBindSourceAdapterReadWriteField<T>.GetAutoPost: Boolean;
begin
  Result := FAutoPost;
end;

function TBindSourceAdapterReadWriteField<T>.GetValue: T;
begin
  if FBuffered and (Owner.FItemIndexOffset = 0) then
    Result := FBuffer
  else
    Result := inherited;
end;


function TBindSourceAdapterReadWriteField<T>.IsBuffered: Boolean;
begin
  Result := FBuffered = True;
end;

procedure TBindSourceAdapterReadWriteField<T>.SetTValue(const AValue: TValue);
begin
  Value := AValue.AsType<T>;
end;

procedure TBindSourceAdapterReadWriteField<T>.SetAutoPost(
  const Value: Boolean);
begin
  FAutoPost := Value;
end;

procedure TBindSourceAdapterReadWriteField<T>.SetValue(const Value: T);
begin
  if (Owner <> nil) and not (Owner.State in seEditModes) then
    if Owner.AutoEdit then
      AutoEditField
    else
      BindSourceAdapterError(SNotEditing, Self.Owner);
  FBuffer := Value;
  FBuffered := True;
  if FAutoPost or Owner.AutoPost then
    AutoPostField
  else
    RecordChanged;
end;

procedure TBindSourceAdapterReadWriteField<T>.Post;
begin
  if FBuffered then
  begin
    FBuffered := False;
    try
      FValueWriter.SetValue(FBuffer);
    finally
      ClearBuffer;
    end;
  end;
end;

procedure TBindSourceAdapterReadWriteField<T>.Cancel;
begin
  FBuffered := False;
  RecordChanged;
end;

{ TScopeAdapteObjectField }

constructor TBindSourceAdapterReadObjectField.Create(AOwner: TBindSourceAdapter; const AMemberName: string;
  AType: TBindSourceAdapterFieldType; const AGetMemberObject: IGetMemberObject; const AReader: TValueReader<TObject>;
  AMemberType: TScopeMemberType);

begin
  inherited;
  FFields := TObjectList<TBindSourceAdapterField>.Create; // Owned

end;

destructor TBindSourceAdapterReadObjectField.Destroy;
begin
  FFields.Free;
  inherited;
end;

function TBindSourceAdapterReadObjectField.FindField(const AMemberName: string): TBindSourceAdapterField;
var
  LField: TBindSourceAdapterField;
  LFieldName, LPath: string;
  LPos: Integer;
begin
  CheckAddFields;
  LPath := AMemberName;
  LPos := LPath.IndexOf('.') + 1;
  if LPos > 0 then
  begin
    LFieldName := LPath.Substring(0, LPos-1);
    LPath := LPath.Remove(0, LPos);
  end
  else
  begin
    LFieldName := LPath;
    LPath := '';
  end;
  for LField in FFields do
  begin
    if SameText(LField.MemberName, LFieldName) then
    begin
      if LPath <> '' then
        Exit(LField.FindField(LPath));
      Exit(LField);
    end;
  end;
  Result := nil;

end;

function TBindSourceAdapterReadObjectField.GetIsObject: Boolean;
begin
  Result := True;
end;


procedure TBindSourceAdapterReadObjectField.CheckAddFields;
var
  LCtxt: TRttiContext;
  LType: TRttiType;
  LObject: TObject;
begin
  LObject := GetValue;
  if (LObject <> nil) and (not FHaveFields) then
  begin
    FHaveFields := True;
    LType := LCtxt.GetType(LObject.ClassType);
    TBindSourceAdapter.AddFieldsToList(LType, FOwner,
      FFields,
      TBindSourceAdapteObjectFieldGetMemberObject.Create(Self));
    TBindSourceAdapter.AddPropertiesToList(LType, FOwner,
      FFields,
      TBindSourceAdapteObjectFieldGetMemberObject.Create(Self));
  end;
end;

{ TBindSourceAdapterObjectFieldCustomScope }

function TBindSourceAdapterObjectFieldCustomScope.DoLookup(
  const Name: String): IInterface;
var
  LScope: TBindSourceAdapterReadObjectField;
begin
  Result := nil;
  if MappedObject is TBindSourceAdapterReadObjectField then
  begin
    LScope := TBindSourceAdapterReadObjectField(MappedObject);
    if LScope.FindField(Name) <> nil then
      Result := TCustomWrapper.Create(LScope, LScope.ClassType, Name, cwtProperty,
        function (ParentObject: TObject; const MemberName: String; Args: TArray<TValue>): TValue
        begin
          Result := TBindSourceAdapterReadObjectField(ParentObject).FindField(MemberName);
        end);
  end;
end;

{ TBindSourceAdapterGetMemberObject }

constructor TBindSourceAdapterGetMemberObject.Create(
  ACollectionEditor: TBindSourceAdapter);
begin
  FBindSourceAdapter := ACollectionEditor;
end;

function TBindSourceAdapterGetMemberObject.GetMemberObject: TObject;
begin
  Result := FBindSourceAdapter.Current;
end;

{ TScopeAdapteObjectFieldGetMemberObject }

constructor TBindSourceAdapteObjectFieldGetMemberObject.Create(
  AObject: TObject);
begin
  FObject := AObject;
end;

function TBindSourceAdapteObjectFieldGetMemberObject.GetMemberObject: TObject;
begin
  Result := nil;
  if FObject is TBindSourceAdapterReadObjectField then
  begin
    Result := TBindSourceAdapterReadObjectField(FObject).GetValue;
  end
  else
    Assert(False);
end;

{ TFieldValueReader<T> }

function TFieldValueReader<T>.GetValue: T;
var
  LObject: TObject;
  LCtxt: TRttiContext;
  LRttiType: TRttiType;
  LRttiField: TRttiField;
begin
  LObject := FField.GetMemberObject;
  if LObject <> nil then
  begin
    LRttiType := LCtxt.GetType(LObject.ClassType);
    LRttiField := LRttiType.GetField(FField.MemberName);
    if LRttiField <> nil then
    begin
      Result := LRttiField.GetValue(LObject).AsType<T>;
    end
    else
      Result := TValue.Empty.AsType<T>;
  end
  else
    Result := TValue.Empty.AsType<T>;

end;

{ TBindFieldDefValueReader<T> }

function TBindFieldDefValueReader<T>.GetValue: T;
var
  LObject: TObject;
  LDictionary: TDictionary<string, TValue>;
  LValue: TValue;
  S: string;
begin
  LObject := FField.GetMemberObject;
  if LObject <> nil then
  begin
    LDictionary := (LObject as TGeneratorRecord).FDictionary;
    if LDictionary.TryGetValue(FField.MemberName, LValue) then
    begin
      //if not LValue.IsEmpty then
        try
          Result := LValue.AsType<T>()
        except
          on E: Exception do
          begin
            S := E.Message;
            raise;
          end;
        end;
    end
    else
    begin
      Assert(False);
      Result := TValue.Empty.AsType<T>;
    end;
  end
  else
    Result := TValue.Empty.AsType<T>;
end;

{ TBindFieldDefObjectValueReader<T> }

function TBindFieldDefObjectValueReader<T>.GetValue: T;
begin
  Result := inherited GetValue;
end;

{ TFieldValueWriter }

procedure TFieldValueWriter<T>.SetValue(const AValue: T);
var
  LObject: TObject;
  LCtxt: TRttiContext;
  LRttiType: TRttiType;
  LRttiField: TRttiField;
begin
  LObject := FField.GetMemberObject;
  if LObject <> nil then
  begin
    LRttiType := LCtxt.GetType(LObject.ClassType);
    LRttiField := LRttiType.GetField(FField.MemberName);
    if LRttiField <> nil then
    begin
      LRttiField.SetValue(LObject, TValue.From<T>(AValue));
    end;

  end;
end;

{ TPropertyValueReader<T> }

function TPropertyValueReader<T>.GetValue: T;
var
  LObject: TObject;
  LCtxt: TRttiContext;
  LRttiType: TRttiType;
  LRttiField: TRttiProperty;
begin
  LObject := FField.GetMemberObject;
  if LObject <> nil then
  begin
    LRttiType := LCtxt.GetType(LObject.ClassType);
    LRttiField := LRttiType.GetProperty(FField.MemberName);
    if LRttiField <> nil then
    begin
      Result := LRttiField.GetValue(LObject).AsType<T>;
    end
    else
      Result := TValue.Empty.AsType<T>;
  end
  else
    Result := TValue.Empty.AsType<T>;

end;

{ TPropertyValueWriter }

procedure TPropertyValueWriter<T>.SetValue(const AValue: T);
var
  LObject: TObject;
  LCtxt: TRttiContext;
  LRttiType: TRttiType;
  LRttiField: TRttiProperty;
begin
  LObject := FField.GetMemberObject;
  if LObject <> nil then
  begin
    LRttiType := LCtxt.GetType(LObject.ClassType);
    LRttiField := LRttiType.GetProperty(FField.MemberName);
    if LRttiField <> nil then
    begin
      LRttiField.SetValue(LObject, TValue.From<T>(AValue));
      //RecordChanged;
    end;

  end;
end;

{ TBindSourceAdapterReadField<T> }

constructor TBindSourceAdapterReadField<T>.Create(AOwner: TBindSourceAdapter;
  const AMemberName: string; AType: TBindSourceAdapterFieldType; const AGetMemberObject: IGetMemberObject;
  const AReader: TValueReader<T>; AMemberType: TScopeMemberType);
begin
  inherited Create(AOwner, AMemberName, AGetMemberObject);
  FRttiType := AType;
  FValueReader := AReader;
  AReader.FField := Self;
  FMemberType := AMemberType;
end;

destructor TBindSourceAdapterReadField<T>.Destroy;
begin
  FValueReader.Free;
  inherited;
end;

function TBindSourceAdapterReadField<T>.GetGetter(var AGetter: string): Boolean;
begin
  AGetter := sMemberName;
  Result := True;

end;

function TBindSourceAdapterReadField<T>.GetMemberType(var AType: TScopeMemberType): Boolean;
begin
  Result := True;
  AType := FMemberType;
end;

function TBindSourceAdapterReadField<T>.GetTValue: TValue;
begin
  Result := TValue.From<T>(Value);
end;

function TBindSourceAdapterReadField<T>.GetValue: T;
begin
  Result := FValueReader.GetValue;
end;

{ TBindSourceAdapterFieldType }

constructor TBindSourceAdapterFieldType.Create(const ATypeName: string; ATypeKind: TTypeKind);
begin
  FTypeName := ATypeName;
  FTypeKind := ATypeKind;
end;

{ TBindFieldDef }

destructor TBindFieldDef.Destroy;
var
  LCollection: TBindFieldDefs;
begin
  if Collection is TBindFieldDefs then
  begin
    LCollection := TBindFieldDefs(Collection);
    if (LCollection.FDictionary <> nil) and LCollection.FDictionary.ContainsKey(MakeKey(FName)) then
      LCollection.FDictionary.Remove(MakeKey(FName));

  end;
  inherited;
end;

function TBindFieldDef.GetDisplayName: string;
begin
  Result := FName;
end;

procedure TBindFieldDef.SetDisplayName(const Value: string);
var
  LCollection: TBindFieldDefs;
begin
  LCollection := nil;
  if (Value <> '') and (AnsiCompareText(Value, FName) <> 0) and
    (Collection is TBindFieldDefs) and
    (TBindFieldDefs(Collection).IndexOf(Value) >= 0) then
     raise TBindCompException.CreateFmt(SDuplicateName, [Value, Collection.ClassName]);
  if Collection is TBindFieldDefs then
  begin
    LCollection := TBindFieldDefs(Collection);
    LCollection.DoRenamingFieldDef(Self, FName, Value);
    if FName <> '' then
      LCollection.FDictionary.Remove(MakeKey(FName));
    if Value <> '' then
      LCollection.FDictionary.Add(MakeKey(Value), Self);
  end;
  FName := Value;
  //FNameHashValue := TBindFieldDef.HashName(FName);
  inherited SetDisplayName(Value);
  if LCollection <> nil then
  begin
    LCollection.DoRenameFieldDef(Self, FName, Value);
  end;
end;

{ TBindFieldDefsWithChildren }


destructor TBindFieldDefWithChildren.Destroy;
begin
  inherited Destroy;
  FChildDefs.Free;
end;


function TBindFieldDefWithChildren.GetChildDefs<T>: T;
begin
  if FChildDefs = nil then
    FChildDefs := GetChildDefsClass.Create(Self);
  Result := FChildDefs as T;
end;

procedure TBindFieldDefWithChildren.SetChildDefs(Value: TBindFieldDefs);
begin
  FChildDefs.Assign(Value);
end;

function TBindFieldDefWithChildren.HasChildDefs: Boolean;
begin
  Result := (FChildDefs <> nil) and (FChildDefs.Count > 0);
end;

function TBindFieldDefWithChildren.AddChild<T>: T;
begin
  Result := FChildDefs.AddFieldDef<T>;
end;

function TBindFieldDefWithChildren.GetParentDef<T>: T;
begin
  Result := TBindFieldDefs(Collection).GetParentDef<T>;
end;

{ TGeneratorBindFieldDef }

constructor TGeneratorFieldDef.Create(Collection: TCollection);
begin
  inherited;
  FOptions := [optRepeat, optShuffle]; // Default
  FFieldType := ftString; // Default
end;

constructor TGeneratorFieldDef.Create(Owner: TBindFieldDefs; const Name: string;
      FieldNo: Integer);
begin
  FName := Name;
  Create(Owner);
  FFieldNo := FieldNo;
end;


function TGeneratorFieldDef.GetFieldNo: Integer;
begin
  if FFieldNo > 0 then
    Result := FFieldNo else
    Result := Index + 1;
end;

function TGeneratorFieldDef.GetMemberType: TScopeMemberType;
begin
  case FFieldType of
    ftString:
      Result := mtText;
    ftInteger:
      Result := mtInteger;
    ftUInteger:
      Result := mtUInteger;
    ftSingle:
      Result := mtFloat;
    ftBoolean:
      Result := mtBoolean;
    ftBitmap:
      Result := mtBitmap;
    ftTStrings:
      Result := mtMemo;
    ftCurrency:
      Result := mtCurrency;
    ftDateTime:
      Result := mtDateTime;
    ftTime:
      Result := mtTime;
    ftDate:
      Result := mtDate;
    ftChar:
      Result := mtChar;
  else
    Assert(False);
    Result := mtUnknown;
  end;
end;


procedure TGeneratorFieldDef.SetFieldType(Value: TGeneratorFieldType);
var
  LRecord: TValueGeneratorDescription;
begin
  FFieldType := Value;
  if Generator <> '' then
    if (Collection <> nil) and (Collection.Owner is TComponent) then
      if csDesigning in TComponent(Collection.Owner).ComponentState then
        if (not FindRegisteredValueGenerator(Generator, FFieldType, LRecord)) then
          Generator := '';
  Changed(False);
end;


procedure TGeneratorFieldDef.SetGenerator(const Value: string);
begin
  FGenerator := Value;
  Changed(False);
end;

procedure TGeneratorFieldDef.SetCustomFormat(const Value: string);
begin
  FCustomFormat := Value;
  Changed(False);
end;

procedure TGeneratorFieldDef.SetOptions(
  const Value: TGeneratorOptions);
begin
  FOptions := Value;
  Changed(False);
end;

procedure TGeneratorFieldDef.SetReadOnly(const Value: Boolean);
begin
  FReadOnly := Value;
  Changed(False);  // No need to regenerate
end;

function TGeneratorFieldDef.GetChildDefs: TGeneratorFieldDefs;
begin
  Result := inherited GetChildDefs<TGeneratorFieldDefs>;
end;

procedure TGeneratorFieldDef.SetChildDefs(Value: TGeneratorFieldDefs);
begin
  ChildDefs.Assign(Value);
end;

function TGeneratorFieldDef.AddChild: TGeneratorFieldDef;
begin
  Result := inherited AddChild<TGeneratorFieldDef>;
end;

function TGeneratorFieldDef.GetParentDef: TGeneratorFieldDef;
begin
  Result := inherited GetParentDef<TGeneratorFieldDef>;
end;

function TGeneratorFieldDef.GetTypeInfo: PTypeInfo;
begin
  case FFieldType of
    ftString:
      Result := System.TypeInfo(string);
    ftInteger:
      Result := System.TypeInfo(Integer);
    ftUInteger:
      Result := System.TypeInfo(UInt32);
    ftSingle:
      Result := System.TypeInfo(Single);
    ftBoolean:
      Result := System.TypeInfo(Boolean);
    ftBitmap:
      Result := System.TypeInfo(TPersistent);
    ftTStrings:
      Result := System.TypeInfo(TStrings);
    ftCurrency:
      Result := System.TypeInfo(Currency);
    ftDateTime:
      Result := System.TypeInfo(TDateTime);
    ftTime:
      Result := System.TypeInfo(TTime);
    ftDate:
      Result := System.TypeInfo(TDate);
  else
    Result := System.TypeInfo(string);
    Assert(False);
  end;
end;

procedure TGeneratorFieldDef.Assign(Source: TPersistent);
var
  I: Integer;
  S, LBindFieldDef: TGeneratorFieldDef;
begin
  if Source is TGeneratorFieldDef then
  begin
    if Collection <> nil then Collection.BeginUpdate;
    try
      S := TGeneratorFieldDef(Source);
      Name := S.Name;
      FieldType := S.FieldType;
      Generator := S.Generator;
      Options := S.Options;
      ReadOnly := S.ReadOnly;
      CustomFormat := S.CustomFormat;
      if HasChildDefs then ChildDefs.Clear;
      if S.HasChildDefs then
        for I := 0 to S.ChildDefs.Count - 1 do
        begin
          LBindFieldDef := AddChild;
          LBindFieldDef.Assign(S.ChildDefs[I]);
        end;
    finally
      if Collection <> nil then Collection.EndUpdate;
    end;
  end else inherited;
end;


function TGeneratorFieldDef.GetChildDefsClass: TBindFieldDefsClass;
begin
  Result := TGeneratorFieldDefs;
end;

{ TBindFieldDefs }

procedure TBindFieldDefs.Update(AItem: TCollectionItem);
begin
  if Assigned(FDataSource) and not (csLoading in FDataSource.ComponentState) then DoUpdate(AItem);
end;

destructor TBindFieldDefs.Destroy;
begin
  FreeAndNil(FDictionary);
  inherited;
end;

procedure TBindFieldDefs.DoRenameFieldDef(AFieldDef: TBindFieldDef;
  const CurName, PrevName: string);
begin
//
end;

procedure TBindFieldDefs.DoRenamingFieldDef(AFieldDef: TBindFieldDef;
  const CurName, NewName: string);
begin
//
end;

procedure TBindFieldDefs.DoUpdate(Sender: TObject);
begin
  if (FInternalUpdateCount = 0) then
  begin
    Updated := False;
    DataSourceFieldDefChanged(Self);
  end;
end;

procedure TBindFieldDefs.UpdateDefs(AMethod: TDefUpdateMethod);
begin
  if not Updated then
  begin
    Inc(FInternalUpdateCount);
    BeginUpdate;
    try
      AMethod;
    finally
      EndUpdate;
      Dec(FInternalUpdateCount);
    end;
    Updated := True; { Defs are now a mirror of data source }
  end;
end;

function TBindFieldDefs.IndexOf(const AName: string): Integer;
var
  LFieldDef: TBindFieldDef;
begin
  if Count > 0 then
  begin
    if FDictionary.TryGetValue(TBindFieldDef.MakeKey(AName), LFieldDef) then
    begin
      Exit(LFieldDef.Index);
    end;
  end;
  Result := -1;
end;

procedure TBindFieldDefs.GetItemNames(List: TStrings);
var
  I: Integer;
begin
  List.BeginUpdate;
  try
    List.Clear;
    for I := 0 to Count - 1 do
      if TBindFieldDef(Items[I]).Name <> '' then List.Add(TBindFieldDef(Items[I]).Name);
  finally
    List.EndUpdate;
  end;
end;

constructor TBindFieldDefs.Create(AOwner: TPersistent);
var
  LDataSource: TComponent;
begin
  inherited Create(AOwner, GetFieldDefClass);
  FDictionary := TDictionary<string, TBindFieldDef>.Create;
  if AOwner is TBindFieldDef then
  begin
    FParentDef := TBindFieldDef(AOwner);
    LDataSource := TBindFieldDefs(FParentDef.Collection).DataSource
  end else
    LDataSource := AOwner as TComponent;
  FDataSource := LDataSource;
end;

procedure TBindFieldDefs.SetItemName(AItem: TCollectionItem);
const
  sField = 'Field';
var
  LID: Integer;
  LName: string;
begin
  if TBindFieldDef(AItem).Name = '' then
  begin
    LID := TBindFieldDef(AItem).ID;
    while TBindFieldDef(AItem).Name = '' do
    begin
      if (GetOwner = nil) or (not (Self.GetOwner is TBindFieldDef)) then
      begin
        LName := sField + IntToStr(LID+1);
      end
      else
        LName := TBindFieldDef(Self.GetOwner).Name + sField + IntToStr(LID+1);
      if IndexOf(LName) = -1 then
        TBindFieldDef(AItem).Name := LName;
      Inc(LID);
    end;

  end;
end;

function TBindFieldDefs.AddFieldDef<T>: T;
begin
  Result := SafeCast<T>(inherited Add);
end;


function TBindFieldDefs.Find<T>(const Name: string): T;
var
  I: Integer;
  LResult: TBindFieldDef;
begin
  I := IndexOf(Name);
  if I < 0 then LResult := nil else LResult := TBindFieldDef(Items[I]);
  Result := SafeCast<T>(LResult);
  if Result = nil then
     raise TBindCompException.CreateFmt(SFieldNotFound, [Name]);
end;

function TBindFieldDefs.GetFieldDef<T>(Index: Integer): T;
begin
  Result := T(inherited Items[Index]);
end;

function TBindFieldDefs.SafeCast<T>(AValue: TObject): T;
begin
  if AValue <> nil then
    Result := T(AValue)
  else
    Result := nil;

end;

procedure TBindFieldDefs.SetFieldDef(Index: Integer; Value: TBindFieldDef);
begin
  inherited Items[Index] := Value;
end;

procedure TBindFieldDefs.Update;
begin
  UpdateDefs(DataSourceInitFieldDefs);
end;


procedure TBindFieldDefs.ChildDefUpdate(Sender: TObject);
begin
  { Need to update based on the UpdateCount of the DataSet's FieldDefs }
  if (GetDataSourceFieldDefs.UpdateCount = 0) and
     (GetDataSourceFieldDefs.FInternalUpdateCount = 0) then
    DoUpdate(Sender);
end;

procedure TBindFieldDefs.FieldDefUpdate(Sender: TObject);
begin
  DoUpdate(Sender);
end;

function TBindFieldDefs.GetParentDef<T>: T;
begin
  Result := SafeCast<T>(FParentDef);
end;

{ TGeneratorRecord }

constructor TGeneratorRecord.Create;
begin
  FDictionary := TDictionary<string, TValue>.Create();
  FFreeObjects := TObjectList<TObject>.Create;
end;

destructor TGeneratorRecord.Destroy;
begin
  FDictionary.Free;
  FFreeObjects.Free;
  inherited;
end;

{ TBindFieldDefValueWriter<T> }

procedure TBindFieldDefValueWriter<T>.SetValue(const AValue: T);
var
  LObject: TObject;
  LDictionary: TDictionary<string, TValue>;
  LValue: TValue;
begin
  LObject := FField.GetMemberObject;
  if LObject <> nil then
  begin
    LDictionary := (LObject as TGeneratorRecord).FDictionary;
    if LDictionary.TryGetValue(FField.MemberName, LValue) then
    begin
      Assert( not LValue.IsEmpty);
      LValue := TValue.From<T>(AValue);
      LDictionary[FField.MemberName] := LValue;
    end
    else
      Assert(False);
  end;
end;

{ TGeneratorBindFieldDefs }


function TGeneratorFieldDefs.GetAttrCount: Integer;
begin
  Result := 3;
end;

function TGeneratorFieldDefs.GetAttr(Index: Integer): string;
begin
  case Index of
    0: Result := sNameAttr;
    1: Result := sTypeAttr;
    2: Result := sGeneratorAttr;
  else
    Result := ''; { do not localize }
  end;
end;

function TGeneratorFieldDefs.GetItemAttr(Index, ItemIndex: Integer): string;
begin
  case Index of
    0: begin
         Result := Items[ItemIndex].Name;
         if Result = '' then Result := IntToStr(ItemIndex);
       end;
    1: begin
         Result := GetEnumName(TypeInfo(TGeneratorFieldType), Integer(Items[ItemIndex].FieldType));
       end;
    2: begin
         Result := Items[ItemIndex].Generator;
       end;
  else
    Result := '';
  end;
end;

procedure TGeneratorFieldDefs.DataSourceFieldDefChanged(Sender: TObject);
begin
  if FDataSource <> nil then

    (FDataSource as TCustomDataGeneratorAdapter).FieldDefChanged(Sender);
end;

procedure TGeneratorFieldDefs.DoRenamingFieldDef(AFieldDef: TBindFieldDef; const CurName, NewName: string);
var
  LScope: TBaseObjectBindSource;
begin
  if (FDataSource <> nil) and (not (csLoading in FDataSource.ComponentState)) then
  for LScope in (FDataSource as TCustomDataGeneratorAdapter).Scopes do
    LScope.DoMemberRenaming(CurName, NewName);
end;

procedure TGeneratorFieldDefs.DoRenameFieldDef(AFieldDef: TBindFieldDef; const CurName, PrevName: string);
var
  LScope: TBaseObjectBindSource;
begin
  if (FDataSource <> nil) and (not (csLoading in FDataSource.ComponentState)) then
  for LScope in (FDataSource as TCustomDataGeneratorAdapter).Scopes do
    LScope.DoMemberRenamed(CurName, PrevName);
end;

procedure TGeneratorFieldDefs.DataSourceInitFieldDefs;
begin
  (FDataSource as TCustomDataGeneratorAdapter).InitFieldDefs;
end;

function TGeneratorFieldDefs.GetDataSourceFieldDefs: TBindFieldDefs;
begin
  Result := (FDataSource as TCustomDataGeneratorAdapter).FieldDefs;
end;


function TGeneratorFieldDefs.AddFieldDef: TGeneratorFieldDef;
begin
  Result := inherited AddFieldDef<TGeneratorFieldDef>;
end;

function TGeneratorFieldDefs.Find(const Name: string): TGeneratorFieldDef;
begin
  Result := inherited Find<TGeneratorFieldDef>(Name);
end;

function TGeneratorFieldDefs.GetFieldDef(Index: Integer): TGeneratorFieldDef;
begin
  Result := inherited GetFieldDef<TGeneratorFieldDef>(Index);
end;

function TGeneratorFieldDefs.GetFieldDefClass: TBindFieldDefClass;
begin
  Result := TGeneratorFieldDef;
end;

function TGeneratorFieldDefs.GetParentDef: TGeneratorFieldDef;
begin
  Result := inherited GetParentDef<TGeneratorFieldDef>;
end;

procedure TGeneratorFieldDefs.SetFieldDef(Index: Integer;
  Value: TGeneratorFieldDef);
begin
  inherited SetFieldDef(Index, Value);
end;

function TGeneratorFieldDefs.GetEnumerator: TEnumerator;
begin
  Result := TEnumerator.Create(Self);
end;

{ TBindFieldDef }

function TBindFieldDef.HasChildDefs: Boolean;
begin
  Result := False;
end;

class function TBindFieldDef.MakeKey(const AName: string): string;
begin
  Assert(AName <> '');
  Result := UpperCase(AName);
end;

{ TValueGenerator }

constructor TValueGenerator.Create(AFieldDef: TGeneratorFieldDef);
begin
  FGeneratorName := AFieldDef.Generator;
  FFieldType := AFieldDef.FieldType;
  FOptions := AFieldDef.Options;
  FCustomFormat := AFieldDef.CustomFormat;
end;

function TValueGenerator.GetRecordCount: Integer;
begin
  Result := -1;
end;

procedure TValueGenerator.FirstRecord;
begin

end;

procedure TValueGenerator.NextRecord;
begin

end;

function TValueGenerator.GetValue(var AFree: Boolean): TValue;
begin
  Result := TValue.Empty;
end;


{ TDelegateValueGenerator }

constructor TDelegateValueGenerator.Create(AFieldDef: TGeneratorFieldDef);
begin
  inherited;
  FDelegate := CreateDelegate;
end;

destructor TDelegateValueGenerator.Destroy;
begin
  FDelegate.Free;
  inherited;
end;

procedure TDelegateValueGenerator.FirstRecord;
begin
  inherited;
  if FDelegate <> nil then
    FDelegate.FirstRecord;
end;

function TDelegateValueGenerator.GetRecordCount: Integer;
begin
  if FDelegate <> nil then
    Result := FDelegate.GetRecordCount
  else
    Result := inherited;
end;

procedure TDelegateValueGenerator.NextRecord;
begin
  inherited;
  if FDelegate <> nil then
    FDelegate.NextRecord;
end;

function TDelegateValueGenerator.GetValue(var AFree: Boolean): TValue;
begin
  if FDelegate <> nil then
    Exit(FDelegate.GetValue(AFree))
  else
  begin
    Assert(False);
    Result := TValue.Empty;
  end;
end;

{ TValueGeneratorRecord }

constructor TValueGeneratorDescription.Create(
  AClassType: TValueGeneratorClass; const AFormatFieldName: string; const AUnitName: string);
begin
  FClassType := AClassType;
  FFormatFieldName := AFormatFieldName;
  FUnitName := AUnitName;
end;


{ TBindSourceAdapterReadWriteObjectField<T> }

type
  TPersistentCracker = class(TPersistent)

  end;

procedure TBindSourceAdapterReadWriteObjectField<T>.AssignTo(Dest: TPersistent);
begin
  if (Value is TPersistent) or (Value = nil) then
  begin
    if AssignValue(Dest) then
    begin
      // Assign OK
    end
    else
      inherited
  end
  else
    inherited;

end;

procedure TBindSourceAdapterReadWriteObjectField<T>.ClearBuffer;
begin
  FBuffer := nil;
end;

function TBindSourceAdapterReadWriteObjectField<T>.CreateBlobStream: TStream;
begin
  Result := CreateValueBlobStream(Value);
end;

{ TBindSourceAdapterReadObjectField<T> }

procedure TBindSourceAdapterReadObjectField<T>.AssignTo(Dest: TPersistent);
begin
  if Value is TPersistent then
  begin
    if AssignValue(Dest) then
    begin
      // Assign OK
    end
    else
      inherited;
  end
  else
    inherited;
end;

function TBindSourceAdapterReadObjectField<T>.CreateBlobStream: TStream;
begin
  Result := CreateValueBlobStream(Value);
end;


{ TTypedListValueGeneratorDelegate2<T> }

constructor TTypedListValueGeneratorDelegate2<T, T1>.Create(AOptions: TGeneratorOptions; AValuesList: TArray<T1>);
begin
  inherited Create(AOptions, ConvertArray(AValuesList));
end;

function TTypedListValueGeneratorDelegate2<T, T1>.ConvertArray(
  AArray: TArray<T1>): TArray<T>;
var
  LList: TList<T>;
  LT1: T1;
  LT: T;
  LValue: TValue;
begin
  LList := TList<T>.Create;
  try
    for LT1 in AArray do
    begin
      LValue := TValue.From<T1>(LT1);
      if LValue.TryAsType<T>(LT) then
        LList.Add(LT)
      else
      begin
        LValue := LValue.ToString;
        if LValue.TryAsType<T>(LT) then
          LList.Add(LT)
        else
        begin
          LValue := TValue.Empty; // Debugging
        end;
      end;
    end;
    Result := LList.ToArray;
  finally
    LList.Free;
  end;
end;

{ TTypedListValueGeneratorDelegate<T> }

constructor TTypedListValueGeneratorDelegate<T>.Create(AOptions: TGeneratorOptions; AValuesList: TArray<T>);
var
  I: Integer;
begin
  FValuesList := TList<T>.Create;
  FValuesList.AddRange(AValuesList);
  if optShuffle in AOptions then
  begin
    if (FValuesList.Count > 0) and (optRepeat in AOptions) then
      while FValuesList.Count < 20  do
        // Add more if a list of booleans, for example
        FValuesList.AddRange(AValuesList);

    RandSeed := 123456789; // Shuffle always results in same order, so that generated and names match corresponding generated values
    for I := 0 to FValuesList.Count - 1 do
      FValuesList.Exchange(I, Random(FValuesList.Count));
  end;
end;

destructor TTypedListValueGeneratorDelegate<T>.Destroy;
begin
  FValuesList.Free;
  inherited;
end;

procedure TTypedListValueGeneratorDelegate<T>.FirstRecord;
begin
  FValueCounter := 0;
end;

function TTypedListValueGeneratorDelegate<T>.GetRecordCount: Integer;
begin
  Result := FValuesList.Count;
end;

procedure TTypedListValueGeneratorDelegate<T>.NextRecord;
begin
  Inc(FValueCounter);
end;

function TTypedListValueGeneratorDelegate<T>.GetValue(var AFree: Boolean): TValue;
var
  LValue: T;
begin
  if (FValuesList <> nil) and (FValuesList.Count > 0) then
    Result := TValue.From<T>(FValuesList[FValueCounter mod FValuesList.Count])
  else
  begin
    // Create default value
    LValue := TValue.Empty.AsType<T>;
    Result := TValue.From<T>(LValue);
  end;

  // Allow owner to override return value
  if Assigned(FGetValue) then
  begin
    Assert(not AFree);
    Result := FGetValue(Result, AFree);
    if AFree then
    begin
      Assert(Result.IsObject);
    end;
  end;
end;

{ TValueGeneratorDelegate }

function TValueGeneratorDelegate.GetRecordCount: Integer;
begin
  Result := -1;
end;

{ TBindFieldDefObjectValueWriter<T> }

procedure TBindFieldDefObjectValueWriter<T>.SetValue(const AValue: T);
var
  LObject: TObject;
  LDictionary: TDictionary<string, TValue>;
  LValue: TValue;
  LDictionaryValue: TValue;
begin
  LObject := FField.GetMemberObject;
  if LObject <> nil then
  begin
    LDictionary := (LObject as TGeneratorRecord).FDictionary;
    if LDictionary.TryGetValue(FField.MemberName, LValue) then
    begin
      Assert( not LValue.IsEmpty);
      LValue := TValue.From<T>(AValue);
      LDictionaryValue := LDictionary[FField.MemberName];
      if LDictionaryValue.IsObject and (LDictionaryValue.AsObject is TPersistent) then
        if (LValue.IsObject) and (LValue.AsObject is TPersistent) then
          TPersistent(LDictionaryValue.AsObject).Assign(TPersistent(LValue.AsObject))
        else
          TPersistent(LDictionaryValue.AsObject).Assign(nil) // Clear
      else
        Assert(False); // Unexpected value
    end
    else
      Assert(False);
  end;
end;

function TTypedCustomFormatObject<T>.GetTValue: TValue;
begin
  Result := TValue.From<T>(FValue);
end;

function TTypedCustomFormatObject<T>.GetValue: T;
begin
  Result := FValue;
end;

procedure TTypedCustomFormatObject<T>.SetTValue(const AValue: TValue);
begin
  FValue := AValue.AsType<T>();
end;

procedure TTypedCustomFormatObject<T>.SetValue(AValue: T);
begin
  FValue := AValue;
end;

{ TListBindSourceAdapter }

constructor TListBindSourceAdapter.Create(AOwner: TComponent;
  AList: TList<TObject>; AClass: TClass; AOwnsObject: Boolean);
begin
  FClass := AClass;
  inherited Create(AOwner, AList, AOwnsObject);
end;

function TListBindSourceAdapter.GetObjectType: TRttiType;
var
  LType: TRttiType;
  LCtxt: TRttiContext;
begin
  if FClass <> nil then
    LType := LCtxt.GetType(FClass)
  else
    LType := LCtxt.GetType(TObject);
  Result := LType;
end;

{ TObjectBindSourceAdapter }

constructor TObjectBindSourceAdapter.Create(AOwner: TComponent;
  AObject: TObject; AClass: TClass; AOwnsObject: Boolean);
begin
  FClass := AClass;
  inherited Create(AOwner, AObject, AOwnsObject);
end;

function TObjectBindSourceAdapter.GetObjectType: TRttiType;
var
  LType: TRttiType;
  LCtxt: TRttiContext;
begin
  if FClass <> nil then
    LType := LCtxt.GetType(FClass)
  else
    LType := LCtxt.GetType(TObject);
  Result := LType;
end;


{ TBaseObjectBindSourceDelegate }

procedure TBaseObjectBindSourceDelegate.AddActiveChanged(LNotify: TNotifyEvent);
begin
  FBindSource.AddActiveChanged(LNotify);
end;

procedure TBaseObjectBindSourceDelegate.AddDataSetChanged(
  LNotify: TNotifyEvent);
begin
  FBindSource.AddDataSetChanged(LNotify);
end;

procedure TBaseObjectBindSourceDelegate.AddDataSetScrolled(
  LNotify: TNotifyDistanceEvent);
begin
  FBindSource.AddDataSetScrolled(LNotify);
end;

procedure TBaseObjectBindSourceDelegate.AddEditingChanged(
  LNotify: TNotifyEvent);
begin
  FBindSource.AddEditingChanged(LNotify);
end;

procedure TBaseObjectBindSourceDelegate.AddExpression(
  AExpression: TBasicBindComponent);
begin
  FBindSource.AddExpression(AExpression);

end;

procedure TBaseObjectBindSourceDelegate.ApplyUpdates;
begin
  FBindSource.ApplyUpdates;
end;

procedure TBaseObjectBindSourceDelegate.Cancel;
begin
  FBindSource.Cancel;
end;

procedure TBaseObjectBindSourceDelegate.CancelUpdates;
begin
  FBindSource.CancelUpdates;
end;

procedure TBaseObjectBindSourceDelegate.ClearModified(
  ABindComp: TBasicBindComponent);
begin
  FBindSource.ClearModified(ABindComp);
end;

constructor TBaseObjectBindSourceDelegate.Create(AOwner: TComponent);
begin
  FBindSource := CreateBindSource;
  inherited;
end;

procedure TBaseObjectBindSourceDelegate.Delete;
begin
  FBindSource.Delete;
end;

function TBaseObjectBindSourceDelegate.Edit(
  ABindComp: TBasicBindComponent): Boolean;
begin
  Result := FBindSource.Edit(ABindComp);
end;

procedure TBaseObjectBindSourceDelegate.Edit;
begin
  FBindSource.Edit;
end;

procedure TBaseObjectBindSourceDelegate.First;
begin
  FBindSource.First;
end;

function TBaseObjectBindSourceDelegate.GetActive: Boolean;
begin
  Result := FBindSource.GetActive;
end;

function TBaseObjectBindSourceDelegate.GetBOF: Boolean;
begin
  Result := FBindSource.GetBOF;
end;

function TBaseObjectBindSourceDelegate.GetCanApplyUpdates: Boolean;
begin
  Result := FBindSource.GetCanApplyUpdates;
end;

function TBaseObjectBindSourceDelegate.GetCanCancelUpdates: Boolean;
begin
  Result := FBindSource.GetCanCancelUpdates;
end;

function TBaseObjectBindSourceDelegate.GetCanDelete: Boolean;
begin
  Result := FBindSource.GetCanDelete;
end;

function TBaseObjectBindSourceDelegate.GetCanInsert: Boolean;
begin
  Result := FBindSource.GetCanInsert;
end;

function TBaseObjectBindSourceDelegate.GetCanModify: Boolean;
begin
  Result := FBindSource.GetCanModify;
end;

function TBaseObjectBindSourceDelegate.GetCanModify(
  ABindComp: TBasicBindComponent): Boolean;
begin
  Result := FBindSource.GetCanModify(ABindComp);
end;

function TBaseObjectBindSourceDelegate.GetCanRefresh: Boolean;
begin
  Result := FBindSource.GetCanRefresh;
end;

function TBaseObjectBindSourceDelegate.GetCurrentRecord(
  const AMemberName: string): IScope;
begin
  Result := FBindSource.GetCurrentRecord(AMemberName);
end;

function TBaseObjectBindSourceDelegate.GetEditing: Boolean;
begin
  Result := FBindSource.GetEditing;
end;

function TBaseObjectBindSourceDelegate.GetEnumerator(const AMemberName: string;
  ABufferCount: Integer): IScopeRecordEnumerator;
begin
  Result := FBindSource.GetEnumerator(AMemberName, ABufferCount);
end;

function TBaseObjectBindSourceDelegate.GetEOF: Boolean;
begin
  Result := FBindSource.GetEOF;
end;

function TBaseObjectBindSourceDelegate.GetIsEditing(
  ABindComp: TBasicBindComponent): Boolean;
begin
  Result := FBindSource.GetIsEditing(ABindComp);
end;

function TBaseObjectBindSourceDelegate.GetIsModified(
  ABindComp: TBasicBindComponent): Boolean;
begin
  Result := FBindSource.GetIsModified(ABindComp);
end;

procedure TBaseObjectBindSourceDelegate.GetLookupMemberNames(AList: TStrings);
begin
  FBindSource.GetLookupMemberNames(AList);
end;

function TBaseObjectBindSourceDelegate.GetMember(
  const AMemberName: string): TObject;
begin
  Result := FBindSource.GetMember(AMemberName)
end;

function TBaseObjectBindSourceDelegate.GetMemberGetter(
  const AMemberName: string; var AGetter: string): Boolean;
begin
  Result := FBindSource.GetMemberGetter(AMemberName, AGetter);
end;

procedure TBaseObjectBindSourceDelegate.GetMemberNames(AList: TStrings);
begin
  FBindSource.GetMemberNames(AList);
end;

function TBaseObjectBindSourceDelegate.GetMemberSetter(
  const AMemberName: string; var ASetter: string): Boolean;
begin
  Result := FBindSource.GetMemberSetter(AMemberName, ASetter);
end;

function TBaseObjectBindSourceDelegate.GetMemberType(const AMemberName: string;
  var AType: TScopeMemberType): Boolean;
begin
  Result := FBindSource.GetMemberType(AMemberName, AType);
end;

function TBaseObjectBindSourceDelegate.GetPositionGetter(var AGetter: string;
  var ABase: Integer): Boolean;
begin
  Result := FBindSource.GetPositionGetter(AGetter, ABase);
end;

function TBaseObjectBindSourceDelegate.GetPositionSetter(var ASetter: string;
  var ABase: Integer): Boolean;
begin
  Result := FBindSource.GetPositionSetter(ASetter, ABase);
end;

procedure TBaseObjectBindSourceDelegate.GetRecord(ARow: Integer;
  const AMemberName: string; ACallback: TProc<IScope>);
begin
  FBindSource.GetRecord(ARow, AMemberName, ACallback);
end;

function TBaseObjectBindSourceDelegate.GetSelected: Boolean;
begin
  Result := FBindSource.GetSelected;
end;

function TBaseObjectBindSourceDelegate.GetValue: TObject;
begin
  Result := FBindSource.GetValue;
end;

procedure TBaseObjectBindSourceDelegate.Insert;
begin
  FBindSource.Insert;
end;

function TBaseObjectBindSourceDelegate.IsRequired(
  const AFieldName: string): Boolean;
begin
  Result := FBindSource.IsRequired(AFieldName);
end;

function TBaseObjectBindSourceDelegate.IsValidChar(const AFieldName: string;
  const AChar: Char): Boolean;
begin
  Result := FBindSource.IsValidChar(AFieldName, AChar);
end;

procedure TBaseObjectBindSourceDelegate.Last;
begin
  FBindSource.Last;
end;

function TBaseObjectBindSourceDelegate.Locate(const KeyFields: string;
  const KeyValues: TValue): Boolean;
begin
  Result := FBindSource.Locate(KeyFields, KeyValues);
end;

function TBaseObjectBindSourceDelegate.Lookup(const KeyFields: string;
  const KeyValues: TValue; const ResultFields: string): TValue;
begin
  Result := FBindSource.Lookup(KeyFields, KeyValues, ResultFields);
end;

procedure TBaseObjectBindSourceDelegate.Next;
begin
  FBindSource.Next;
end;

procedure TBaseObjectBindSourceDelegate.PosChanging(
  ABindComp: TBasicBindComponent);
begin
  FBindSource.PosChanging(ABindComp);
end;

procedure TBaseObjectBindSourceDelegate.Post;
begin
  FBindSource.Post;
end;

procedure TBaseObjectBindSourceDelegate.Prior;
begin
  FBindSource.Prior;
end;

procedure TBaseObjectBindSourceDelegate.Refresh;
begin
  FBindSource.Refresh;
end;

procedure TBaseObjectBindSourceDelegate.RemoveActiveChanged(
  LNotify: TNotifyEvent);
begin
  FBindSource.RemoveActiveChanged(LNotify);
end;

procedure TBaseObjectBindSourceDelegate.RemoveDataSetChanged(
  LNotify: TNotifyEvent);
begin
  FBindSource.RemoveDataSetChanged(LNotify);
end;

procedure TBaseObjectBindSourceDelegate.RemoveDataSetScrolled(
  LNotify: TNotifyDistanceEvent);
begin
  FBindSource.RemoveDataSetScrolled(LNotify);
end;

procedure TBaseObjectBindSourceDelegate.RemoveEditingChanged(
  LNotify: TNotifyEvent);
begin
  FBindSource.RemoveEditingChanged(LNotify);
end;

procedure TBaseObjectBindSourceDelegate.RemoveExpression(
  AExpression: TBasicBindComponent);
begin
  FBindSource.RemoveExpression(AExpression);

end;

procedure TBaseObjectBindSourceDelegate.Reset(ABindComp: TBasicBindComponent);
begin
  FBindSource.Reset(ABindComp);
end;

procedure TBaseObjectBindSourceDelegate.SetField(ABindComp: TBasicBindComponent;
  const FieldName: string);
begin
  FBindSource.SetField(ABindComp, FieldName);
end;

procedure TBaseObjectBindSourceDelegate.SetModified(
  ABindComp: TBasicBindComponent);
begin
  FBindSource.SetModified(ABindComp);
end;

procedure TBaseObjectBindSourceDelegate.SetReadOnly(
  ABindComp: TBasicBindComponent; const Value: Boolean);
begin
  FBindSource.SetReadOnly(ABindComp, Value);
end;

procedure TBaseObjectBindSourceDelegate.UpdateRecord(
  ABindComp: TBasicBindComponent);
begin
  FBindSource.UpdateRecord(ABindComp);
end;

{ TValueReaderFunc<T> }

constructor TValueReaderFunc<T>.Create(const AName: string; AGetValue: TFunc<string, T>);
begin
  FGetValue := AGetValue;
  FName := AName;
end;

function TValueReaderFunc<T>.GetValue: T;
begin
  Result := FGetValue(FName);
end;

{ TValueWriteProc<T> }

constructor TValueWriterProc<T>.Create(const AName: string; ASetValue: TProc<string, T>);
begin
  FSetValue := ASetValue;
  FName := AName;
end;

procedure TValueWriterProc<T>.SetValue(const AValue: T);
begin
  FSetValue(FName, AValue);
end;

initialization
  TBindingScopeFactory.RegisterScope(TBindSourceAdapter, TBindSourceAdapterCustomScope);
  TBindingScopeFactory.RegisterScope(TBindSourceAdapterReadObjectField, TBindSourceAdapterObjectFieldCustomScope);
finalization
  TBindingScopeFactory.UnregisterScope(TBindSourceAdapterCustomScope);
  TBindingScopeFactory.UnregisterScope(TBindSourceAdapterObjectFieldCustomScope);
  GValueGenerators.Free;
end.

