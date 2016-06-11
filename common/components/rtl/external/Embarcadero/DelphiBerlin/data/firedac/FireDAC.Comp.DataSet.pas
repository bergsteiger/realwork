{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{     FireDAC TFDDataSet (base TDataSet descendant)     }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.Comp.DataSet;

interface

uses
  System.SysUtils, System.Classes, Data.DB, System.Generics.Collections,
  FireDAC.Stan.Util, FireDAC.Stan.Intf, FireDAC.Stan.SQLTimeInt, FireDAC.Stan.Option,
    FireDAC.Stan.Error, FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.Phys.Intf,
  FireDAC.UI.Intf;

const
  C_NIL = TRecBuf(nil);

type
  TFDColMapItem = class;
  TFDDataSet = class;
  TFDMasterDataLink = class;
  TFDIndex = class;
  TFDIndexes = class;
  TFDAggregate = class;
  TFDAggregates = class;
  TFDXMLField = class;
  TFDAutoIncField = class;
  TFDSQLTimeIntervalField = class;
  TFDBlobStream = class;
  IFDDataSetReference = interface;

  TFDColMapItem = class(TObject)
  public
    FColumn: TFDDatSColumn;
    FColumnIndex: Integer;
    FPath: array of Integer;
  end;

  TFDKeyIndex = (kiLookup, kiRangeStart, kiRangeEnd, kiCurRangeStart,
    kiCurRangeEnd, kiSave);

  PFDRecInfo = ^TFDRecInfo;
  TFDRecInfo = record
    [unsafe] FRow: TFDDatSRow;
    FRowIndex: LongInt;
    FBookmarkFlag: TBookmarkFlag;
  end;

  PFDBookmarkData = ^TFDBookmarkData;
  TFDBookmarkData = record
    [unsafe] FRow: TFDDatSRow;
    FRowIndex: Integer;
    FResultSetNum: Integer;
  end;

  PFDKeyBuffer = ^TFDKeyBuffer;
  TFDKeyBuffer = packed record
    FModified: Boolean;
    FExclusive: Boolean;
    FFieldCount: Integer;
    FAssignedFieldCount: Integer;
    FRecBuff: TRecBuf;
  end;

  IFDDataSetReference = interface (IUnknown)
    ['{3E9B315B-F456-4175-A864-B2573C4A2400}']
    function GetDataView: TFDDatSView;
    property DataView: TFDDatSView read GetDataView;
  end;

  IFDDataSetListener = interface (IUnknown)
    ['{3E9B315B-F456-4175-A864-B2573C4A2401}']
    procedure ResultsetDefined(ADataSet: TFDDataSet);
    procedure ResultsetReleasing(ADataSet: TFDDataSet);
    procedure ResultsetActivated(ADataSet: TFDDataSet);
  end;

  TFDUpdateRecordEvent = procedure (ASender: TDataSet; ARequest: TFDUpdateRequest;
    var AAction: TFDErrorAction; AOptions: TFDUpdateRowOptions) of object;
  TFDUpdateErrorEvent = procedure (ASender: TDataSet; AException: EFDException;
    ARow: TFDDatSRow; ARequest: TFDUpdateRequest; var AAction: TFDErrorAction) of object;
  TFDAfterApplyUpdatesEvent = procedure (DataSet: TFDDataSet; AErrors: Integer) of object;
  TFDReconcileErrorEvent = procedure(DataSet: TFDDataSet; E: EFDException;
    UpdateKind: TFDDatSRowState; var Action: TFDDAptReconcileAction) of object;
  TFDDataSetEvent = procedure(DataSet: TFDDataSet) of object;
  TFDDataSetFlags = set of (dfOpenBlob, dfOfflining, dfKeyBuffersAllocated,
    dfRangeFromExclusive, dfRangeToExclusive, dfLockNoBMK, dfClearIndexDefs,
    dfColumnAttributesUpdated, dfCalcFieldInIndex, dfStreamedActive,
    dfPreserveCurrentIndex, dfPostRow, dfDataSetOpened, dfNoRecNoCmp,
    dfDataSetOpening, dfDeleting);
  TFDFetchDirection = (fdUp, fdDown);
  TFDDataSetLocateOption = (lxoCaseInsensitive, lxoPartialKey, lxoFromCurrent,
    lxoBackward, lxoCheckOnly, lxoNoFetchAll);
  TFDDataSetLocateOptions = set of TFDDataSetLocateOption;
  TFDCopyDataSetOptions = set of (coStructure, coCalcFields,
    coIndexesReset, coIndexesCopy,
    coConstraintsReset, coConstraintsCopy,
    coAggregatesReset, coAggregatesCopy,
    coRestart, coAppend, coEdit, coDelete, coRefresh);
  TFDStoredActivationUsage = set of (auDesignTime, auRunTime);
  TFDUpdateRecordTypes = set of (rtModified, rtInserted, rtDeleted,
    rtUnmodified, rtHasErrors);

  TFDFieldList = TList<TField>;
  TFDDataSetList = TList<TDataSet>;

  TFDMasterDataLink = class(TMasterDataLink)
  private
    [Weak] FDetailDataSet: TFDDataSet;
    FOnMasterChange: TNotifyEvent;
    FOnMasterFieldsDefined: TNotifyEvent;
    FFireActiveChanged: Boolean;
    FActiveChangedLocked: Boolean;
    FDelayedEvent: TDataEvent;
    FDelayedScrollDisabled: Integer;
    FTimer: IFDGUIxTimer;
    FScrollDisabled: Integer;
    procedure StartDelayedScroll;
    procedure DoDelayedScroll(ASender: TObject);
    function GetDelayedScrollEnabled: Boolean;
    function GetActualDelayedScrollEnabled: Boolean;
    procedure DoMasterChanged(ASender: TObject);
  protected
    procedure ActiveChanged; override;
    procedure DataEvent(Event: TDataEvent; Info: NativeInt); override;
    procedure RecordChanged(Field: TField); override;
  public
    constructor Create(ADataSet: TDataSet);
    destructor Destroy; override;
    procedure Synchronize(AWithDetails: Boolean = True);
    procedure CancelSync(AWithDetails: Boolean = True);
    procedure DisableDelayedScroll;
    procedure EnableDelayedScroll;
    procedure DisableScroll;
    procedure EnableScroll;
    property DelayedScrollEnabled: Boolean read GetDelayedScrollEnabled;
    property ActualDelayedScrollEnabled: Boolean read GetActualDelayedScrollEnabled;
    property OnMasterChange: TNotifyEvent read FOnMasterChange
      write FOnMasterChange;
    property OnMasterFieldsDefined: TNotifyEvent read FOnMasterFieldsDefined
      write FOnMasterFieldsDefined;
  end;

  TFDIndex = class (TCollectionItem)
  private
    FUpdateCount: Integer;
    FActive: Boolean;
    FFilter: String;
    FFields: String;
    FCaseInsFields: String;
    FExpression: String;
    FDescFields: String;
    FFilterOptions: TFDExpressionOptions;
    FOptions: TFDSortOptions;
    FView: TFDDatSView;
    FName: String;
    FDistinct: Boolean;
    procedure SetCaseInsFields(const AValue: String);
    procedure SetDescFields(const AValue: String);
    procedure SetExpression(const AValue: String);
    procedure SetFields(const AValue: String);
    procedure SetFilter(const AValue: String);
    procedure SetFilterOptions(const AValue: TFDExpressionOptions);
    procedure SetOptions(const AValue: TFDSortOptions);
    procedure SetName(const AValue: String);
    procedure IndexChanged;
    procedure SetActive(const AValue: Boolean);
    function GetActualActive: Boolean;
    procedure CreateView;
    procedure DeleteView;
    function GetDataSet: TFDDataSet;
    function GetSelected: Boolean;
    procedure SetSelected(const AValue: Boolean);
    procedure SetDistinct(const AValue: Boolean);
  protected
    function GetDisplayName: String; override;
    procedure AssignTo(ADest: TPersistent); override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(ASource: TPersistent); override;
    procedure BeginUpdate;
    procedure EndUpdate;
    property ActualActive: Boolean read GetActualActive;
    property DataSet: TFDDataSet read GetDataSet;
  published
    property Active: Boolean read FActive write SetActive default False;
    property Selected: Boolean read GetSelected write SetSelected default False;
    property Name: String read FName write SetName;
    property Fields: String read FFields write SetFields;
    property CaseInsFields: String read FCaseInsFields write SetCaseInsFields;
    property DescFields: String read FDescFields write SetDescFields;
    property Expression: String read FExpression write SetExpression;
    property Options: TFDSortOptions read FOptions write SetOptions default [];
    property Distinct: Boolean read FDistinct write SetDistinct default False;
    property Filter: String read FFilter write SetFilter;
    property FilterOptions: TFDExpressionOptions read FFilterOptions write SetFilterOptions default [];
  end;

  TFDIndexes = class(TCollection)
  private
    [Weak] FDataSet: TFDDataSet;
    function GetItems(AIndex: Integer): TFDIndex;
    procedure SetItems(AIndex: Integer; const AValue: TFDIndex);
  protected
    function GetOwner: TPersistent; override;
    procedure Build;
    procedure Release;
  public
    constructor Create(ADataSet: TFDDataSet);
    function Add: TFDIndex;
    function FindIndex(const AName: String): TFDIndex;
    function IndexByName(const AName: String): TFDIndex;
    function FindIndexForFields(const AFields: String;
      ARequiredOptions: TFDSortOptions = [];
      AProhibitedOptions: TFDSortOptions = []): TFDIndex;
    property Items[AIndex: Integer]: TFDIndex read GetItems write SetItems; default;
  end;

  TFDAggregate = class(TCollectionItem)
  private
    FUpdateCount: Integer;
    FExpression: String;
    FGroupingLevel: Integer;
    FIndexName: String;
    FActive: Boolean;
    FAggregate: TFDDatSAggregate;
    FName: String;
    function GetActualActive: Boolean;
    function GetDataSet: TFDDataSet;
    procedure SetActive(const AValue: Boolean);
    procedure SetExpression(const AValue: String);
    procedure SetGroupingLevel(const AValue: Integer);
    procedure SetIndexName(const AValue: String);
    procedure AggregateChanged;
    procedure CreateAggregate;
    procedure DeleteAggregate;
    function GetValue: Variant;
    function InternalUse(var ARecordIndex: Integer): Boolean;
    function GetInUse: Boolean;
    function GetDataType: TFDDataType;
  protected
    function GetDisplayName: String; override;
  public
    destructor Destroy; override;
    procedure Assign(ASource: TPersistent); override;
    procedure BeginUpdate;
    procedure EndUpdate;
    property ActualActive: Boolean read GetActualActive;
    property DataSet: TFDDataSet read GetDataSet;
    property Value: Variant read GetValue;
    property InUse: Boolean read GetInUse;
    property DataType: TFDDataType read GetDataType;
  published
    property Name: String read FName write FName;
    property Expression: String read FExpression write SetExpression;
    property GroupingLevel: Integer read FGroupingLevel write SetGroupingLevel default 0;
    property IndexName: String read FIndexName write SetIndexName;
    property Active: Boolean read FActive write SetActive default False;
  end;

  TFDAggregates = class(TCollection)
  private
    [Weak] FDataSet: TFDDataSet;
    FGroupingLevel: Integer;
    function GetItems(AIndex: Integer): TFDAggregate;
    procedure SetItems(AIndex: Integer; const AValue: TFDAggregate);
  protected
    function GetOwner: TPersistent; override;
    property GroupingLevel: Integer read FGroupingLevel;
    procedure Build;
    procedure Release;
  public
    constructor Create(ADataSet: TFDDataSet);
    function Add: TFDAggregate;
    function FindAggregate(const AName: String): TFDAggregate;
    function AggregateByName(const AName: String): TFDAggregate;
    property Items[AIndex: Integer]: TFDAggregate read GetItems write SetItems; default;
  end;

  TFDDataSet = class (TDataSet, IFDDataSetReference, IFDStanOptions,
    IFDPhysLocalSQLAdapter, IFDDatSTableDataCallback, IDataSetCommandSupport)
  private
    FTable: TFDDatSTable;
    FView: TFDDatSView;
    FBufferSize: LongWord;
    FRecordIndexToInsert: Integer;
    FPrevRecordIndex: Integer;
    FColumns: array of TFDColMapItem;
    FNewRow: TFDDatSRow;
    FForceRecBuffer: TRecBuf;
    FIndexDefs: TIndexDefs;
    FIndexes: TFDIndexes;
    FSortView: TFDDatSView;
    FFilterView: TFDDatSView;
    FSourceView: TFDDatSView;
    FSourceViewLocator: TFDDatSMechFilter;
    FKeyBuffers: array[TFDKeyIndex] of PFDKeyBuffer;
    FIndexName: String;
    FIndexFieldNames: String;
    FFilterChanges: TFDUpdateRecordTypes;
    FParentDataSet: TFDDataSet;
    FConstDisableCount: Integer;
    FCloneSource: TFDDataSet;
    FCachedUpdates: Boolean;
    FOnReconcileError: TFDReconcileErrorEvent;
    FOnUpdateRecord: TFDUpdateRecordEvent;
    FOnUpdateError: TFDUpdateErrorEvent;
    FUnidirRecsPurged: Integer;
    FMasterLink: TFDMasterDataLink;
    FDetailFields: String;
    [Weak] FLastParentRow: TFDDatSRow;
    FAfterRowRequest: TFDDataSetEvent;
    FAfterExecute: TFDDataSetEvent;
    FAfterApplyUpdates: TFDAfterApplyUpdatesEvent;
    FAfterGetRecords: TFDDataSetEvent;
    FAfterGetRecord: TFDDataSetEvent;
    FBeforeRowRequest: TFDDataSetEvent;
    FBeforeExecute: TFDDataSetEvent;
    FBeforeApplyUpdates: TFDDataSetEvent;
    FBeforeGetRecords: TFDDataSetEvent;
    FAggregatesActive: Boolean;
    FIndexesActive: Boolean;
    FAggregates: TFDAggregates;
    FFieldAggregates: TFDAggregates;
    FDataLoadSave: Pointer;
    FCreatedConstraints: TFDObjList;
    FLocateRow: TFDDatSRow;
    FLocateColumns: TFDDatSColumnSublist;
    FTempIndexViews: TFDObjList;
    FLastSavePoint: LongWord;
    FActiveStoredUsage: TFDStoredActivationUsage;
    [Weak] FLastColumn: TFDDatSColumn;
    [Weak] FLastField: TField;
    FEventListeners: TInterfaceList;
    FOnMasterSetValues: TFDDataSetEvent;
    FWaitCounter: Integer;
    FMasterRelation: TFDDatSRelation;
    function AddFieldDesc(AFmtOpts: TFDFormatOptions; ADefs: TFieldDefs;
      AColumn: TFDDatSColumn; var AFieldId: Integer; APath: TFDPtrList): TFieldDef;
    procedure AddTableDesc(AFmtOpts: TFDFormatOptions; ADefs: TFieldDefs;
      ATable: TFDDatSTable; var AFieldId: Integer; APath: TFDPtrList);
    procedure SetIndexName(const AValue: String);
    function GetIndexFieldNames: String;
    procedure SetIndexFieldNames(const AValue: String);
    procedure RelinkViews;
    function GetIndexField(AIndex: Integer): TField;
    function GetIndexFieldCount: Integer;
    procedure AllocKeyBuffers;
    procedure CheckSetKeyMode;
    procedure CheckIndexed;
    procedure FreeKeyBuffers;
    function GetKeyExclusive: Boolean;
    function GetKeyFieldCount: Integer;
    function InitKeyBuffer(ABuffer: PFDKeyBuffer): PFDKeyBuffer;
    function ClearKeyBuffer(ABuffer: PFDKeyBuffer): PFDKeyBuffer;
    procedure SetKeyRow(ABuffer: PFDKeyBuffer; ARow: TFDDatSRow);
    procedure PostKeyBuffer(ACommit: Boolean);
    function ResetCursorRange: Boolean;
    procedure SetKeyExclusive(AValue: Boolean);
    procedure SetKeyFieldCount(AValue: Integer);
    procedure SetKeyFields(AKeyIndex: TFDKeyIndex;
      const AValues: array of const; AExclusive: Boolean = False);
    procedure AssignKeyBuffer(ADest, ASrc: PFDKeyBuffer);
    function CompareKeyBuffer(ABuff1, ABuff2: PFDKeyBuffer): Boolean;
    procedure ResetViews;
    procedure SetSortView(AView: TFDDatSView);
    procedure SwitchToIndex(const AFieldNames, AIndexName: String);
    procedure SetFilterChanges(const AValue: TFDUpdateRecordTypes);
    procedure SafeFilteringUpdated;
    function GetFieldColumn(ARecBuff: TRecBuf; AFieldNo: Integer;
      var AColumn: TFDDatSColumn; var AColumnIndex: Integer;
      var ARow: TFDDatSRow; AInitNested: Boolean = False): Boolean; overload;
    procedure SetFetchOptions(const AValue: TFDFetchOptions);
    procedure SetFormatOptions(const AValue: TFDFormatOptions);
    procedure SetUpdateOptions(const AValue: TFDBottomUpdateOptions);
    procedure SetResourceOptions(const AValue: TFDBottomResourceOptions);
    function GetFetchOptions: TFDFetchOptions;
    function GetFormatOptions: TFDFormatOptions;
    function GetUpdateOptions: TFDBottomUpdateOptions;
    function GetResourceOptions: TFDBottomResourceOptions;
    function GetData: IFDDataSetReference;
    function GetDelta: IFDDataSetReference;
    procedure SetData(const AValue: IFDDataSetReference);
    procedure SetTableConstraints;
    procedure ResetTableConstraints;
    procedure SetInternalCalcs(ALifeCycles: TFieldLifeCycles);
    procedure SetUpdateFieldAttributes;
    function GetConstraintsEnabled: Boolean;
    procedure SetConstraintsEnabled(const AValue: Boolean);
    function IsCS: Boolean;
    function GetCachedUpdates: Boolean;
    procedure SetCachedUpdates(const AValue: Boolean);
    function GetSavePoint: Int64;
    procedure SetSavePoint(const AValue: Int64);
    function GetUpdates: TFDDatSUpdatesJournal;
    function GetUpdatesPending: Boolean;
    function GetChangeCount: Integer;
    function InternalFetchRows(AAll, AOnDemand: Boolean;
      ADirection: TFDFetchDirection = fdDown): Boolean;
    function InternalFetchNested(ARow: TFDDatSRow; ANestedTable: TFDDatSTable;
      ARowOptions: TFDPhysFillRowOptions): Boolean;
    function RefreshRecordBase(ARowOptions: TFDPhysFillRowOptions): Boolean;
    function GetMasterFields: String;
    procedure SetMasterFields(const AValue: String);
    procedure SetMasterSource(const AValue: TDataSource);
    function GetActualDetailFields: String;
    procedure CheckParentRow;
    procedure ResetIndexes;
    procedure SetAggregatesActive(const AValue: Boolean);
    procedure SetIndexesActive(const AValue: Boolean);
    function GetGroupingLevel: Integer;
    procedure SetAggregates(const AValue: TFDAggregates);
    procedure SetIndexes(const AValue: TFDIndexes);
    function GetActiveRecBufRecordIndex(var AIndex: Integer): Boolean;
    procedure SetViewAggregates;
    procedure ResetViewAggregates;
    function IsAS: Boolean;
    function IsIS: Boolean;
    function GetFilteredData: IFDDataSetReference;
    function RenewColumnMap: Boolean;
    function RenewFieldDesc(AColumn: TFDDatSColumn; var AFieldId: Integer): Boolean;
    function RenewTableDesc(ATable: TFDDatSTable; var AFieldId: Integer): Boolean;
    function CreateChildMech: TFDDatSMechChilds;
    function CreateFilterMech(AFilter: TFDDatSMechFilter): TFDDatSMechFilter;
    function CreateRangeMech: TFDDatSMechRange;
    function CreateStateMech: TFDDatSMechRowState;
    function IsIDS: Boolean;
    procedure SetIndexDefs(const AValue: TIndexDefs);
    procedure UpdateRecordIndex;
    procedure ClearRecordIndex;
    procedure SetParams(const AValue: TFDParams);
    function GetParamsCount: Integer;
    procedure InternalLoadFromStorage;
    procedure InternalSaveToStorage;
    function ResetAtLoading: Boolean;
    function InternalFieldByName(const AFieldName, APlace: String): TField;
    procedure SetBookmarkSize(AValue: Integer);
    function GetRowFromBookmark(ABookmark: TBookmark; out ARowIndex: Integer;
      out AResultSetNum: Integer): TFDDatSRow;
    procedure ReadContent(AReader: TStream);
    procedure WriteContent(AWriter: TStream);
    procedure ReadDataSource(AReader: TReader);
    procedure ReadReadOnly(AReader: TReader);
    procedure StoredActivate(AInherited: TProc);
    procedure CopyRecordBase(ASource: TDataset; AExcludeNewEmptyValues: Boolean);
    function IsRowValid(ARow: TFDDatSRow; AResultSetNum: Integer): Boolean;
    function GetRowError: EFDException;
    procedure InternalClearNested(ADataTypes: TFDDataTypes; AAttributes: TFDDataAttributes);
    procedure BuildMasterRelation;
    procedure ResetMasterRelation;
    procedure DoAfterGetRecords2;
    function GetRecInfo(ABuffer: TRecBuf): PFDRecInfo; overload;
    procedure InternalDefineDatSManager;
    procedure InitChildTable(ADatSManager: TFDDatSManager; AParTable: TFDDatSTable;
      AParColumn: TFDDatSColumn; ADefs: TObject; AArraySize: Integer);
    procedure InitChildTables(ADatSManager: TFDDatSManager;
      AParTable, ASrcTable: TFDDatSTable);
  protected
    FRecordIndex: Integer;
    FClientCursor: Boolean;
    FKeyBuffer: PFDKeyBuffer;
    FRangeFrom, FRangeTo: TFDDatSRow;
    FRangeFromFieldCount, FRangeToFieldCount: Integer;
    FSetToRecBmk: TBookmark;
    FLocalIndexName: String;
    // IProviderSupport
{$WARN SYMBOL_DEPRECATED OFF}
    procedure PSExecute; override;
    function PSGetDefaultOrder: TIndexDef; override;
    function PSGetKeyFields: string; override;
    function PSGetTableName: string; override;
    function PSGetIndexDefs(IndexTypes: TIndexOptions = [ixPrimary..ixNonMaintained]): TIndexDefs; override;
    function PSGetUpdateException(E: Exception; Prev: EUpdateError): EUpdateError; override;
    procedure PSReset; override;
    function PSUpdateRecord(AUpdateKind: TUpdateKind; ADelta: TDataSet): Boolean; override;
{$WARN SYMBOL_DEPRECATED ON}
    function InternalDefaultKeyFieldCount(ABuffer: PFDKeyBuffer; ADefault: Integer): Integer; virtual;
    function InternalGotoKey(ANearest: Boolean): Boolean; virtual;
    function GetKeyRow(ABuffer: PFDKeyBuffer): TFDDatSRow;
    // IFDDataSetReference
    function GetDataView: TFDDatSView;
    // IFDStanOptions
    function GetOptionsIntf: IFDStanOptions; virtual; abstract;
    procedure SetOptionsIntf(const AValue: IFDStanOptions); virtual; abstract;
    // IFDPhysLocalSQLAdapter
    function GetDataSet: TObject;
    procedure SetDataSet(ADataSet: TObject);
    function GetConn: NativeUInt; virtual;
    function IsPKViolation(AExc: Exception): Boolean;
    function GetFeatures: TFDPhysLocalSQLAdapterFeatures; virtual;
    // IFDDatSTableDataCallback
    procedure TableDataChanged(ARow: TFDDatSRow; AChangeKind: TFDDatSRowState);
    // IDataSetCommandSupport
    function GetCommandStates(const ACommand: String): TDataSetCommandStates; virtual;
    procedure ExecuteCommand(const ACommand: String; const AArgs: array of const); virtual;
  protected
    FRecordCount: Integer;
    FSourceEOF: Boolean;
    FFlags: TFDDataSetFlags;
    FStorage: IFDStanStorage;
    FEncoder: TFDEncoder;
    function AllocRecBuf: TRecBuf; {$IFDEF NEXTGEN} override; {$ENDIF}
    procedure FreeRecBuf(var Buffer: TRecBuf); {$IFDEF NEXTGEN} override; {$ENDIF}
    function AllocRecordBuffer: TRecordBuffer; {$IFNDEF NEXTGEN} override; {$ENDIF}
    procedure FreeRecordBuffer(var Buffer: TRecordBuffer); {$IFNDEF NEXTGEN} override; {$ENDIF}
    procedure CheckDeleting;
    procedure CheckEditing;
    procedure CheckInserting;
    procedure CreateFilterView; virtual;
    procedure ClearCalcFields(Buffer: TRecBuf); override;
    procedure CloseBlob(Field: TField); override;
    procedure DataEvent(Event: TDataEvent; Info: NativeInt); override;
    procedure Loaded; override;
    procedure Updated; override;
    procedure DefineProperties(AFiler: TFiler); override;
    procedure DoAfterRefresh; override;
    procedure DoBeforeInsert; override;
    procedure DoBeforeEdit; override;
    procedure DoBeforeDelete; override;
    procedure DoBeforeScroll; override;
    function GetActiveRecBuf(var RecBuf: TRecBuf): Boolean;
    procedure GetBookmarkData(Buffer: TRecBuf; Data: TBookmark); override;
    function GetBookmarkFlag(Buffer: TRecBuf): TBookmarkFlag; override;
    function GetCanModify: Boolean; override;
    function GetCanRefresh: Boolean; override;
    function GetDataSource: TDataSource; override;
    function GetRowIndex(ABuffer: TRecBuf = C_NIL): Integer;
    function GetRecNo: Integer; override;
    function GetRecord(Buffer: TRecBuf; GetMode: TGetMode; DoCheck: Boolean): TGetResult; overload; override;
{$IFNDEF NEXTGEN}
    function GetRecord(Buffer: TRecordBuffer; GetMode: TGetMode; DoCheck: Boolean): TGetResult; overload; override;
{$ENDIF}
    function GetRecordCount: Integer; override;
    function GetRecordSize: Word; override;
    function GetKeyBuffer(AKeyIndex: TFDKeyIndex; ACheckCreateRow: Boolean = True): PFDKeyBuffer;
    function SetCursorRange: Boolean;
    procedure SetKeyBuffer(AKeyIndex: TFDKeyIndex; AClear: Boolean);
    procedure InitRecord(Buffer: TRecBuf); override;
    procedure InitBufferPointers; virtual;
    procedure InternalHandleException; override;
    procedure ClearColumnMap;
    procedure InternalInitFieldDefs; override;
    procedure InternalOpen; override;
    procedure DoAfterOpen; override;
    procedure InternalClose; override;
    procedure InternalAddRecord(Buffer: TRecBuf; Append: Boolean); override;
    procedure InternalCancel; override;
    procedure InternalDelete; override;
    procedure InternalEdit; override;
    procedure InternalFirst; override;
    procedure InternalGotoBookmark(Bookmark: Pointer); overload; {$IFNDEF NEXTGEN} override; {$ENDIF}
    procedure InternalGotoBookmark(Bookmark: TBookmark); overload; override;
    procedure InternalInitRecord(Buffer: TRecBuf); override;
    procedure DoOnNewRecord; override;
    procedure InternalInsert; override;
    procedure InternalLast; override;
    procedure InternalPost; override;
    procedure InternalRefresh; override;
    procedure ResyncViews;
    procedure InternalSetToRecord(Buffer: TRecBuf); override;
    function IsCursorOpen: Boolean; override;
    procedure OpenCursor(InfoQuery: Boolean); override;
    procedure CloseCursor; override;
    procedure OpenIndexes;
    procedure RefreshInternalCalcFields(Buffer: TRecBuf); overload; override;
{$IFNDEF NEXTGEN}
    procedure RefreshInternalCalcFields(Buffer: TRecordBuffer); overload; override; deprecated 'Use overloaded method instead';
{$ENDIF !NEXTGEN}
    function RowState2UpdateStatus(ARowState: TFDDatSRowState): TUpdateStatus;
    procedure SetActive(AValue: Boolean); override;
    procedure SetBookmarkData(Buffer: TRecBuf; Data: TBookmark); override;
    procedure SetBookmarkFlag(Buffer: TRecBuf; AValue: TBookmarkFlag); override;
    procedure SetFieldData(AField: TField; ABuffer: TValueBuffer); overload; override;
    procedure InternalSetRecNo(AValue: Integer); virtual;
    procedure SetRecNo(AValue: Integer); override;
    procedure SetFilterOptions(AValue: TFilterOptions); override;
    procedure SetFilterText(const AValue: string); override;
    procedure SetFiltered(AValue: Boolean); override;
    procedure SetOnFilterRecord(const AValue: TFilterRecordEvent); override;
    procedure InitLocateRow(const AKeyFields: String; const AKeyValues: Variant);
    function FindRecord(Restart, GoForward: Boolean): Boolean; override;
    function LocateRecord(const AKeyFields: string; const AKeyValues: Variant;
      AOptions: TFDDataSetLocateOptions; var AIndex: Integer): Boolean; overload;
    function LocateRecord(const AExpression: string;
      AOptions: TFDDataSetLocateOptions; var AIndex: Integer): Boolean; overload;
    procedure UpdateIndexDefs; override;
    function GetIsIndexField(AField: TField): Boolean; override;
    procedure ResetAggField(AField: TField); override;
    function GetAggregateValue(AField: TField): Variant; override;
    function GetFieldClass(FieldType: TFieldType): TFieldClass; override;
    // introduced
    function CalcBookmarkSize: LongWord; virtual;
    procedure CheckBidirectional;
    procedure CheckTable;
    procedure CheckFetchedAll;
    procedure CheckAsyncOpenComplete;
    procedure CheckAsyncOpenFailed;
    procedure CheckAsyncExecFinished;
    procedure ReleaseBase(AOffline: Boolean); virtual;
    procedure CheckOnline(APrepare: Boolean = True); virtual;
    function MasterRangeChanged: Boolean;
    procedure CheckMasterRange; virtual;
    procedure CheckDetailRecords(AEnforce: Boolean);
    procedure MasterDisabled(Sender: TObject); virtual;
    procedure MasterChanged(Sender: TObject); virtual;
    procedure MasterDefined(Sender: TObject); virtual;
    procedure BeginForceRow(ARow: TFDDatSRow; AReadWrite, AWithCalcFields: Boolean);
    procedure CheckCachedUpdatesMode; virtual;
    function DoApplyUpdates(ATable: TFDDatSTable; AMaxErrors: Integer): Integer; virtual;
    procedure DoCachedUpdatesChanged; virtual;
    function DoFetch(ATable: TFDDatSTable; AAll: Boolean;
      ADirection: TFDFetchDirection = fdDown): Integer; overload; virtual;
    function DoFetch(ARow: TFDDatSRow; AColumn: Integer;
      ARowOptions: TFDPhysFillRowOptions): Boolean; overload; virtual;
    function DoPurge(AView: TFDDatSView; ADirection: TFDFetchDirection = fdDown): Integer; virtual;
    procedure DoClearBeforeRefetch; virtual;
    procedure DoCreateFields; virtual;
    procedure DoFilteringUpdated(AResync: Boolean); virtual;
    function DoFilterRow(AMech: TFDDatSMechFilter;
      ARow: TFDDatSRow; AVersion: TFDDatSRowVersion): Boolean; virtual;
    function DoGetTableName: String; virtual;
    procedure DoMasterDefined; virtual;
    procedure DoMasterReset; virtual;
    function DoMasterParamChanged(AMasterFieldList: TFDFieldList): Boolean; virtual;
    procedure DoMasterParamSetValues(AMasterFieldList: TFDFieldList); virtual;
    function DoMasterParamDependent(AMasterFieldList: TFDFieldList): Boolean; virtual;
    function DoAdjustSortFields(const AFields, AExpression: String;
      var AIndexOptions: TFDSortOptions): String; virtual;
    procedure DoSortOrderChanging; virtual;
    procedure DoSortOrderChanged; virtual;
    procedure DoDefineDatSManager; virtual;
    procedure DoResetDatSManager; virtual;
    procedure DoPrepareSource; virtual;
    procedure DoUnprepareSource; virtual;
    procedure DoOpenSource(ABlocked, AInfoQuery, AStructQuery: Boolean); virtual;
    function DoIsSourceOpen: Boolean; virtual;
    function DoIsSourceAsync: Boolean; virtual;
    function DoIsSourceOnline: Boolean; virtual;
    procedure DoCloseSource; virtual;
    function DoGetDatSManager: TFDDatSManager; virtual;
    procedure DoProcessUpdateRequest(ARequest: TFDUpdateRequest;
      AOptions: TFDUpdateRowOptions); virtual;
    procedure DoExecuteSource(ATimes, AOffset: Integer); virtual;
    procedure DoUpdateErrorHandler(ARow: TFDDatSRow; AException: Exception;
      ARequest: TFDUpdateRequest; var AAction: TFDErrorAction); virtual;
    procedure DoUpdateRecordHandler(ARow: TFDDatSRow; ARequest: TFDUpdateRequest;
      AOptions: TFDUpdateRowOptions; var AAction: TFDErrorAction); virtual;
    procedure DoReconcileErrorHandler(ARow: TFDDatSRow; AException: EFDException;
      AUpdateKind: TFDDatSRowState; var AAction: TFDDAptReconcileAction); virtual;
    procedure DoCloneCursor(AReset, AKeepSettings: Boolean); virtual;
    procedure InitColumnsFromFieldDefs(ADefs: TFieldDefs; ATable: TFDDatSTable;
      ADatSManager: TFDDatSManager; AArraySize: Integer);
    procedure InitTable(ATable: TFDDatSTable; AWithFields: Boolean);
    procedure DoAfterApplyUpdate(AErrors: Integer); virtual;
    procedure ApplyUpdatesComplete(AMaxErrors, AErrors: Integer);
    function DoReconcile(AOnSuccess, ACommitApplied: Boolean): Boolean;
    procedure DoBeforeApplyUpdate; virtual;
    procedure DoBeforeGetRecords; virtual;
    procedure DoAfterGetRecords(AFromRecord, AToRecord: Integer); virtual;
    procedure DoBeforeRowRequest; virtual;
    procedure DoAfterRowRequest; virtual;
    procedure DoBeforeExecute; virtual;
    procedure DoAfterExecute; virtual;
    procedure EndForceRow;
    function GetRowVersion: TFDDatSRowVersion;
    function GetExists: Boolean; virtual;
    function IsForceRowMode: Boolean; inline;
    function BuildViewForIndex(AIndex: TFDIndex): TFDDatSView;
    procedure CheckFetchedAllBeforeSorting;
    function GetParams: TFDParams; virtual;
    procedure SetColumnAttributes(ALifeCycles: TFieldLifeCycles);
    function SaveToDFM(const AAncestor: TFDDataSet): Boolean; virtual;
    procedure StartWait;
    procedure StopWait;
    procedure UpdateRecordCount; virtual;
    function GetDisplayName: String;
    function DoStoredActivation: Boolean; virtual;
    procedure InternalResetRange; virtual;
    function BeginLocate(AOptions: TFDDataSetLocateOptions;
      ApRecordIndex: PInteger): Integer;
    procedure EndLocate(AResult: Boolean; APos: Integer;
      AOptions: TFDDataSetLocateOptions; ApRecordIndex: PInteger);
    function BeginLookup(AOptions: TFDDataSetLocateOptions;
      ApRecordIndex: PInteger): Integer;
    function EndLookup(AResult: Boolean; APos: Integer;
      const AResultFields: string; ApRecordIndex: PInteger): Variant;
    /// <summary> The LoadFromStorage method loads dataset content from
    ///  the specified data storage. When AStream is not nil, then content
    ///  will be loaded from the stream. When AFileName is not empty, then
    ///  from the specified file. </summary>
    procedure LoadFromStorage(AStream: TStream; const AFileName: String;
      AFormat: TFDStorageFormat); virtual;
    /// <summary> The LoadFromStorage method saves dataset content into
    ///  the specified data storage. When AStream is not nil, then content
    ///  will be saved into the stream. When AFileName is not empty, then
    ///  into the specified file. </summary>
    procedure SaveToStorage(const AFileName: String; AStream: TStream;
      AFormat: TFDStorageFormat); virtual;
    property Updates: TFDDatSUpdatesJournal read GetUpdates;
    property Params: TFDParams read GetParams write SetParams stored False;
    property ParamCount: Integer read GetParamsCount;
    property BookmarkSize write SetBookmarkSize;
    property SortView: TFDDatSView read FSortView;

    // IFDStanOptions
    property OptionsIntfImpl: IFDStanOptions read GetOptionsIntf implements IFDStanOptions;
    property FormatOptions: TFDFormatOptions read GetFormatOptions write SetFormatOptions;
    property FetchOptions: TFDFetchOptions read GetFetchOptions write SetFetchOptions;
    property UpdateOptions: TFDBottomUpdateOptions read GetUpdateOptions write SetUpdateOptions;
    property ResourceOptions: TFDBottomResourceOptions read GetResourceOptions write SetResourceOptions;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AddIndex(const AName, AFields, AExpression: string; AOptions: TFDSortOptions;
      const ADescFields: string = ''; const ACaseInsFields: string = ''; ADistinct: Boolean = False);
    procedure ApplyMaster;
    procedure ApplyRange;
    function ApplyUpdates(AMaxErrors: Integer = -1): Integer;
    procedure AttachTable(ATable: TFDDatSTable; AView: TFDDatSView); virtual;
    procedure BeginBatch(AWithDelete: Boolean = False);
    procedure EndBatch;
    function BookmarkValid(ABookmark: TBookmark): Boolean; override;
{$IFNDEF NEXTGEN}
    function BookmarkStrValid(ABookmarkStr: TBookmarkStr): Boolean;
{$ENDIF}
    procedure Cancel; override;
    procedure CancelRange;
    procedure CancelUpdates;
    procedure ClearBlobs;
    procedure ClearDetails;
    procedure CloneCursor(ASource: TFDDataSet; AReset: Boolean = False;
      AKeepSettings: Boolean = False); virtual;
    procedure CommitUpdates;
    function CompareBookmarks(Bookmark1, Bookmark2: TBookmark): Integer; override;
    procedure CopyRecord(ASource: TDataset);
    procedure CopyDataSet(ASource: TDataset; AOptions: TFDCopyDataSetOptions = [coRestart, coAppend]);
    procedure CreateDataSet; virtual;
    function CreateBlobStream(Field: TField; Mode: TBlobStreamMode): TStream; override;
    function CreateExpression(const AExpr: String;
      AOptions: TFDExpressionOptions = []): IFDStanExpressionEvaluator;
    function CreateXMLStream: TStream;
    procedure DeleteIndex(const AName: string);
    procedure DeleteIndexes;
    procedure DisableConstraints;
    procedure Disconnect(AAbortJob: Boolean = False); virtual;
    procedure EditKey;
    procedure EditRangeEnd;
    procedure EditRangeStart;
    procedure EmptyDataSet;
    procedure EmptyView;
    procedure EnableConstraints;
    procedure Execute(ATimes: Integer = 0; AOffset: Integer = 0); virtual;
    function OpenOrExecute: Boolean;
    procedure FetchAgain;
    procedure FetchAll;
    procedure FetchBlobs;
    procedure FetchDetails(ADataSetField: TDataSetField = nil);
    function FetchNext: Integer;
    function FindKey(const AKeyValues: array of const): Boolean;
    procedure FindNearest(const AKeyValues: array of const);
    function FindParam(const AValue: string): TFDParam;
    function GetCurrentRecord(Buffer: TRecBuf): Boolean; override;
    procedure GetDetailLinkFields(AMasterFields, ADetailFields: TFDFieldList); override;
    function GetColumnField(AColumn: TFDDatSColumn): TField;
    function GetFieldColumn(AField: TField): TFDDatSColumn; overload;
    function GetFieldData(AFieldNo: Integer; var ABuffer: TValueBuffer): Boolean; overload; override;
    function GetFieldData(AField: TField; var ABuffer: TValueBuffer): Boolean; overload; override;
    function GetStateFieldValue(AState: TDataSetState; AField: TField): Variant; override;
    function GetGroupState(ALevel: Integer): TGroupPosInds;
    procedure GetIndexNames(AList: TStrings);
    function GetNextPacket: Integer;
    function GetRow(ABuffer: TRecBuf = C_NIL; AForceBufferRead: Boolean = False): TFDDatSRow;
    function GetLocateRow: TFDDatSRow;
    function GetParentRow: TFDDatSRow;
    procedure GotoCurrent(ADataSet: TFDDataSet);
    function GotoKey: Boolean;
    procedure GotoNearest;
    function IsLinkedNested: Boolean;
    function IsLinkedDetail: Boolean;
    function IsLinked: Boolean;
    function IsRanged: Boolean;
    function IsSequenced: Boolean; override;
    function IsIndexed: Boolean;
    function Locate(const AKeyFields: string; const AKeyValues: Variant;
      AOptions: TLocateOptions = []): Boolean; override;
    function LocateEx(const AKeyFields: string; const AKeyValues: Variant;
      AOptions: TFDDataSetLocateOptions = []; ApRecordIndex: PInteger = nil): Boolean; overload; virtual;
    function LocateEx(const AExpression: string;
      AOptions: TFDDataSetLocateOptions = []; ApRecordIndex: PInteger = nil): Boolean; overload; virtual;
    function Lookup(const AKeyFields: string; const AKeyValues: Variant;
      const AResultFields: string): Variant; override;
    function LookupEx(const AKeyFields: string; const AKeyValues: Variant;
      const AResultFields: string; AOptions: TFDDataSetLocateOptions = [];
      ApRecordIndex: PInteger = nil): Variant; overload; virtual;
    function LookupEx(const AExpression, AResultFields: string;
      AOptions: TFDDataSetLocateOptions = []; ApRecordIndex: PInteger = nil): Variant; overload; virtual;
    /// <summary> Merges specified dataset data and metadata into this dataset.
    ///  A data merging mode is controlled by AData parameter. By default it is dmDataMerge.
    ///  A metadata merging mode is controlled by AMeta parameter. By default it is mmNone. </summary>
    procedure MergeDataSet(ASource: TFDDataSet; AData: TFDMergeDataMode = dmDataMerge;
      AMeta: TFDMergeMetaMode = mmNone; AOptions: TFDMergeOptions = []);
    procedure Offline;
    procedure Online;
    procedure Release;
    function ParamByName(const AValue: string): TFDParam;
    procedure Post; override;
    function Reconcile(ACommitApplied: Boolean = False): Boolean;
    function RefreshRecord(AClearRow: Boolean = True): Boolean;
    procedure RefreshUnknownRecord(const AValues: array of Variant;
      AReread: Boolean = True; ASetPos: Boolean = True);
    procedure RevertRecord;
    procedure SetFieldAttributes(AField: TField; AColumn: TFDDatSColumn); overload;
    procedure SetFieldAttributes(ALifeCycles: TFieldLifeCycles; AFields: TFields); overload;
    procedure SetFieldAttributes(ALifeCycles: TFieldLifeCycles); overload;
    procedure SetFieldsKeyIncAttributes;
    procedure SetFieldAutoGenerateValue(AField: TField; AValue: TAutoRefreshFlag);
    procedure SetRangeEnd;
    procedure SetRangeStart;
    procedure SetRange(const AStartValues, AEndValues: array of const;
      AStartExclusive: Boolean = False; AEndExclusive: Boolean = False);
    procedure SetKey;
    function UndoLastChange(AFollowChange: Boolean): Boolean;
    function UpdateStatus: TUpdateStatus; override;
    procedure UpdateConstraints;
    procedure UpdateAttributes;
    procedure LoadFromStream(AStream: TStream; AFormat: TFDStorageFormat = sfAuto);
    procedure LoadFromFile(const AFileName: String = ''; AFormat: TFDStorageFormat = sfAuto);
    procedure SaveToStream(AStream: TStream; AFormat: TFDStorageFormat = sfAuto);
    procedure SaveToFile(const AFileName: String = ''; AFormat: TFDStorageFormat = sfAuto);
    function LoadFromFileAtOpen: Boolean;
    function SaveToFileAtClose: Boolean;

    procedure AddListener(const AListener: IFDDataSetListener);
    procedure RemoveListener(const AListener: IFDDataSetListener);

    property ActiveStoredUsage: TFDStoredActivationUsage read FActiveStoredUsage
      write FActiveStoredUsage default [auDesignTime, auRunTime];
    property ActualDetailFields: String read GetActualDetailFields;
    property Aggregates: TFDAggregates read FAggregates write SetAggregates stored IsAS;
    property AggregatesActive: Boolean read FAggregatesActive write SetAggregatesActive default False;
    property CachedUpdates: Boolean read GetCachedUpdates write SetCachedUpdates default False;
    property ChangeCount: Integer read GetChangeCount;
    property ClientCursor: Boolean read FClientCursor;
    property CloneSource: TFDDataSet read FCloneSource;
    property Constraints stored IsCS;
    property ConstraintsEnabled: Boolean read GetConstraintsEnabled
      write SetConstraintsEnabled default False;
    property Data: IFDDataSetReference read GetData write SetData;
    property Delta: IFDDataSetReference read GetDelta;
    property Exists: Boolean read GetExists;
    property RowError: EFDException read GetRowError;
    property FilteredData: IFDDataSetReference read GetFilteredData;
    property DatSManager: TFDDatSManager read DoGetDatSManager;
    property GroupingLevel: Integer read GetGroupingLevel;
    property UpdatesPending: Boolean read GetUpdatesPending;
    property IndexDefs: TIndexDefs read FIndexDefs write SetIndexDefs stored IsIDS;
    property Indexes: TFDIndexes read FIndexes write SetIndexes stored IsIS;
    property IndexesActive: Boolean read FIndexesActive write SetIndexesActive default True;
    property IndexName: String read FIndexName write SetIndexName;
    property LocalIndexName: String read FLocalIndexName;
    property IndexFieldNames: String read GetIndexFieldNames write SetIndexFieldNames;
    property IndexFields[AIndex: Integer]: TField read GetIndexField;
    property IndexFieldCount: Integer read GetIndexFieldCount;
    property KeyExclusive: Boolean read GetKeyExclusive write SetKeyExclusive;
    property KeyFieldCount: Integer read GetKeyFieldCount write SetKeyFieldCount;
    property MasterLink: TFDMasterDataLink read FMasterLink;
    property MasterSource: TDataSource read GetDataSource write SetMasterSource;
    property MasterFields: String read GetMasterFields write SetMasterFields;
    property DetailFields: String read FDetailFields write FDetailFields;
    property OptionsIntf: IFDStanOptions read GetOptionsIntf write SetOptionsIntf;
    property ParentDataSet: TFDDataSet read FParentDataSet;
    property SavePoint: Int64 read GetSavePoint write SetSavePoint;
    property SourceEOF: Boolean read FSourceEOF;
    property SourceView: TFDDatSView read FSourceView;
    property FilterChanges: TFDUpdateRecordTypes read FFilterChanges write SetFilterChanges
      default [rtUnmodified, rtModified, rtInserted];
    property Table: TFDDatSTable read FTable;
    property View: TFDDatSView read FView;
    property Encoder: TFDEncoder read FEncoder;

    property AfterApplyUpdates: TFDAfterApplyUpdatesEvent read FAfterApplyUpdates write FAfterApplyUpdates;
    property AfterExecute: TFDDataSetEvent read FAfterExecute write FAfterExecute;
    property AfterGetRecords: TFDDataSetEvent read FAfterGetRecords write FAfterGetRecords;
    property AfterGetRecord: TFDDataSetEvent read FAfterGetRecord write FAfterGetRecord;
    property AfterRowRequest: TFDDataSetEvent read FAfterRowRequest write FAfterRowRequest;
    property BeforeApplyUpdates: TFDDataSetEvent read FBeforeApplyUpdates write FBeforeApplyUpdates;
    property BeforeExecute: TFDDataSetEvent read FBeforeExecute write FBeforeExecute;
    property BeforeGetRecords: TFDDataSetEvent read FBeforeGetRecords write FBeforeGetRecords;
    property BeforeRowRequest: TFDDataSetEvent read FBeforeRowRequest write FBeforeRowRequest;
    property OnReconcileError: TFDReconcileErrorEvent read FOnReconcileError
      write FOnReconcileError;
    property OnUpdateRecord: TFDUpdateRecordEvent read FOnUpdateRecord
      write FOnUpdateRecord;
    property OnUpdateError: TFDUpdateErrorEvent read FOnUpdateError
      write FOnUpdateError;
    property OnMasterSetValues: TFDDataSetEvent read FOnMasterSetValues write FOnMasterSetValues;
  end;

  TFDXMLField = class(TWideMemoField)
  private
    function GetSchemaName: String;
  protected
    function GetClassDesc: string; override;
  public
    constructor Create(AOwner: TComponent); override;
    property SchemaName: String read GetSchemaName;
  end;

  TFDAutoIncField = class(TAutoIncField)
  private
    FAutoIncrementSeed: Integer;
    FAutoIncrementStep: Integer;
    FClientAutoIncrement: Boolean;
    FServerAutoIncrement: Boolean;
    FGeneratorName: String;
    procedure SetAutoIncrementSeed(const AValue: Integer);
    procedure SetAutoIncrementStep(const AValue: Integer);
    procedure SetClientAutoIncrement(const AValue: Boolean);
    procedure SetServerAutoIncrement(const AValue: Boolean);
    function GetIdentityInsert: Boolean;
    procedure SetIdentityInsert(const AValue: Boolean);
  public
    constructor Create(AOwner: TComponent); override;
  published
    property AutoGenerateValue default TAutoRefreshFlag.arAutoInc;
    [Default(False)]
    property ReadOnly default True;
    property ProviderFlags default [pfInWhere];
    property ClientAutoIncrement: Boolean read FClientAutoIncrement
      write SetClientAutoIncrement default True;
    property ServerAutoIncrement: Boolean read FServerAutoIncrement
      write SetServerAutoIncrement default True;
    property AutoIncrementSeed: Integer read FAutoIncrementSeed
      write SetAutoIncrementSeed default -1;
    property AutoIncrementStep: Integer read FAutoIncrementStep
      write SetAutoIncrementStep default -1;
    property IdentityInsert: Boolean read GetIdentityInsert
      write SetIdentityInsert default False;
    property GeneratorName: String read FGeneratorName
      write FGeneratorName;
  end;

  TFDSQLTimeIntervalField = class(TField)
  private
    function GetAsInterval: TFDSQLTimeInterval;
    procedure SetAsInterval(AValue: TFDSQLTimeInterval);
    function GetIntervalKind: TFDSQLTimeIntervalKind;
    function GetIntRec(var ARec: TFDSQLTimeInterval): Boolean;
    procedure SetIntRec(var ARec: TFDSQLTimeInterval); inline;
  protected
    function GetClassDesc: string; override;
    function GetAsString: String; override;
    procedure SetAsString(const AValue: String); override;
    function GetAsVariant: Variant; override;
    procedure SetVarValue(const AValue: Variant); override;
  public
    constructor Create(AOwner: TComponent); override;
    property IntervalKind: TFDSQLTimeIntervalKind read GetIntervalKind;
    property AsSQLTimeInterval: TFDSQLTimeInterval read GetAsInterval write SetAsInterval;
  end;

  TFDBlobStream = class(TMemoryStream)
  private
    FField: TField;
    FDataSet: TFDDataSet;
    FBuffer: TRecBuf;
    FModified: Boolean;
    FWritten: Boolean;
    FMode: TBlobStreamMode;
    procedure ReadBlobData;
    procedure CheckWrite;
  protected
    function Realloc(var ANewCapacity: LongInt): Pointer; override;
  public
    constructor Create(AField: TField; AMode: TBlobStreamMode);
    destructor Destroy; override;
    procedure Truncate;
    function Write(const ABuffer; ACount: Longint): Longint; override;
    function Write(const ABuffer: TBytes; AOffset, ACount: Longint): Longint; override;
  end;

  function FDCheckStoredUsage(AComponentState: TComponentState;
    AUsage: TFDStoredActivationUsage): Boolean;

implementation

uses
  System.TypInfo, Data.DBConsts, System.Variants, Data.FmtBcd, Data.SqlTimSt,
{$IFNDEF NEXTGEN}
  System.WideStrUtils, System.AnsiStrings,
{$ENDIF}
  FireDAC.Stan.Consts, FireDAC.Stan.Factory,
  System.Math;

{ ----------------------------------------------------------------------------- }
function FDCheckStoredUsage(AComponentState: TComponentState;
  AUsage: TFDStoredActivationUsage): Boolean;
begin
  Result := not (csDesigning in AComponentState) and (auRunTime in AUsage) or
            (csDesigning in AComponentState) and (auDesignTime in AUsage);
end;

{-------------------------------------------------------------------------------}
{ TFDMasterDataLink                                                             }
{-------------------------------------------------------------------------------}
constructor TFDMasterDataLink.Create(ADataSet: TDataSet);
begin
  inherited Create(ADataSet);
  FDetailDataSet := ADataSet as TFDDataSet;
  inherited OnMasterChange := DoMasterChanged;
end;

{-------------------------------------------------------------------------------}
destructor TFDMasterDataLink.Destroy;
begin
  FTimer := nil;
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TFDMasterDataLink.ActiveChanged;
begin
  if FActiveChangedLocked then
    Exit;
  if (DataSet <> nil) and Active then
    if Assigned(FOnMasterFieldsDefined) then
      try
        FActiveChangedLocked := True;
        FOnMasterFieldsDefined(Self);
      finally
        FActiveChangedLocked := False;
      end;
  if (FTimer <> nil) and FTimer.Enabled and not Active then
    FTimer.Enabled := False;
  inherited ActiveChanged;
end;

{-------------------------------------------------------------------------------}
procedure TFDMasterDataLink.StartDelayedScroll;
begin
  if FDetailDataSet <> nil then begin
    if FTimer = nil then
      FDCreateInterface(IFDGUIxTimer, FTimer);
    FTimer.SetEvent(DoDelayedScroll, FDetailDataSet.FetchOptions.DetailDelay);
    FTimer.Enabled := True;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDMasterDataLink.DoDelayedScroll(ASender: TObject);
begin
  FTimer.Enabled := False;
  if Active then
    try
      Inc(FDelayedScrollDisabled);
      inherited DataEvent(FDelayedEvent, 0);
    finally
      Dec(FDelayedScrollDisabled);
    end;
end;

{-------------------------------------------------------------------------------}
procedure TFDMasterDataLink.DataEvent(Event: TDataEvent; Info: NativeInt);
begin
  if (Event = deDataSetChange) and FFireActiveChanged then
    try
      ActiveChanged;
    finally
      FFireActiveChanged := False;
    end;
  if Event in [deDataSetScroll, deDataSetChange] then
    if FScrollDisabled > 0 then begin
      FDelayedEvent := Event;
      Exit;
    end
    else if ActualDelayedScrollEnabled then begin
      FDelayedEvent := Event;
      StartDelayedScroll;
      Exit;
    end;
  inherited DataEvent(Event, Info);
  if Event = deDisabledStateChange then
    FFireActiveChanged := True;
end;

{-------------------------------------------------------------------------------}
procedure TFDMasterDataLink.DoMasterChanged(ASender: TObject);
begin
  FDetailDataSet.ResetMasterRelation;
  if (FScrollDisabled = 0) and Assigned(OnMasterChange) then
    OnMasterChange(ASender);
end;

{-------------------------------------------------------------------------------}
procedure TFDMasterDataLink.RecordChanged(Field: TField);
begin
  if (FScrollDisabled = 0) and
     (DataSource.State <> dsSetKey) and FDetailDataSet.Active and
     ((Fields.Count > 0) or Assigned(FDetailDataSet.OnMasterSetValues)) and
     ((Field = nil) or (Fields.IndexOf(Field) >= 0)) and
     Assigned(OnMasterChange) then
    OnMasterChange(Self);
end;

{-------------------------------------------------------------------------------}
procedure TFDMasterDataLink.Synchronize(AWithDetails: Boolean = True);
var
  oList: TFDDataSetList;
  i: Integer;
begin
  FDetailDataSet.StartWait;
  try
    if FDetailDataSet.FetchOptions.DetailDelay = 0 then
      FDetailDataSet.ApplyMaster
    else if (FTimer <> nil) and FTimer.Enabled and Active then
      DoDelayedScroll(nil);
    if AWithDetails then begin
      oList := TFDDataSetList.Create;
      try
        FDetailDataSet.GetDetailDataSets(oList);
        for i := 0 to oList.Count - 1 do
          if TDataSet(oList[i]) is TFDDataSet then
            TFDDataSet(oList[i]).MasterLink.Synchronize(True);
      finally
        FDFree(oList);
      end;
    end;
  finally
    FDetailDataSet.StopWait;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDMasterDataLink.CancelSync(AWithDetails: Boolean = True);
var
  oList: TFDDataSetList;
  i: Integer;
begin
  if FTimer <> nil then
    FTimer.Enabled := False;
  if AWithDetails then begin
    oList := TFDDataSetList.Create;
    try
      FDetailDataSet.GetDetailDataSets(oList);
      for i := 0 to oList.Count - 1 do
        if TDataSet(oList[i]) is TFDDataSet then
          TFDDataSet(oList[i]).MasterLink.CancelSync(True);
    finally
      FDFree(oList);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDMasterDataLink.DisableDelayedScroll;
begin
  Inc(FDelayedScrollDisabled);
  if FDelayedScrollDisabled = 1 then
    Synchronize(True);
end;

{-------------------------------------------------------------------------------}
procedure TFDMasterDataLink.EnableDelayedScroll;
begin
  if FDelayedScrollDisabled > 0 then
    Dec(FDelayedScrollDisabled);
end;

{-------------------------------------------------------------------------------}
function TFDMasterDataLink.GetDelayedScrollEnabled: Boolean;
begin
  Result := (FDelayedScrollDisabled = 0);
  if Result and (DataSet <> nil) and (DataSet is TFDDataSet) then
    Result := TFDDataSet(DataSet).MasterLink.DelayedScrollEnabled;
end;

{-------------------------------------------------------------------------------}
function TFDMasterDataLink.GetActualDelayedScrollEnabled: Boolean;
begin
  Result := (DataSet <> nil) and (FDetailDataSet.FetchOptions.DetailDelay > 0) and
    DelayedScrollEnabled;
end;

{-------------------------------------------------------------------------------}
procedure TFDMasterDataLink.DisableScroll;
begin
  Inc(FScrollDisabled);
end;

{-------------------------------------------------------------------------------}
procedure TFDMasterDataLink.EnableScroll;
begin
  if FScrollDisabled > 0 then begin
    Dec(FScrollDisabled);
    if FScrollDisabled = 0 then
      Synchronize(True);
  end;
end;

{-------------------------------------------------------------------------------}
{ TFDDatSTableMetadataCallback                                                  }
{-------------------------------------------------------------------------------}
type
  TFDDatSTableMetadataCallback = class(TInterfacedObject, IFDDatSTableMetadataCallback)
  private
    [weak] FDataSet: TFDDataSet;
  protected
    // IFDDatSTableMetadataCallback
    procedure GetColumnOptions(AColumn: TFDDatSColumn; var AOptions: TFDDataOptions);
    procedure GetColumnAttributes(AColumn: TFDDatSColumn; var AAttributes: TFDDataAttributes);
    procedure GetColumnOrigin(AColumn: TFDDatSColumn; var AOrigin: String);
    procedure GetColumnGenerator(AColumn: TFDDatSColumn; var AGenerator: String);
    procedure GetColumnCaption(AColumn: TFDDatSColumn; var ACaption: String);
    procedure GetTableOrigin(var AOrigin: String);
    function GetOwner: TObject;
  public
    constructor Create(const ADataSet: TFDDataSet);
  end;

{-------------------------------------------------------------------------------}
constructor TFDDatSTableMetadataCallback.Create(const ADataSet: TFDDataSet);
begin
  inherited Create;
  FDataSet := ADataSet;
end;

{-------------------------------------------------------------------------------}
procedure TFDDatSTableMetadataCallback.GetColumnOptions(AColumn: TFDDatSColumn;
  var AOptions: TFDDataOptions);
var
  oFld: TField;
begin
  oFld := FDataSet.GetColumnField(AColumn);
  if oFld <> nil then begin
    if oFld.Required then
      Exclude(AOptions, coAllowNull)
    else
      Include(AOptions, coAllowNull);
    if oFld.ReadOnly then
      Include(AOptions, coReadOnly)
    else
      Exclude(AOptions, coReadOnly);
    if pfInUpdate in oFld.ProviderFlags then
      Include(AOptions, coInUpdate)
    else
      Exclude(AOptions, coInUpdate);
    if pfInWhere in oFld.ProviderFlags then
      Include(AOptions, coInWhere)
    else
      Exclude(AOptions, coInWhere);
    if pfInKey in oFld.ProviderFlags then
      Include(AOptions, coInKey)
    else
      Exclude(AOptions, coInKey);
    if oFld.AutoGenerateValue <> Data.DB.arNone then
      Include(AOptions, coAfterInsChanged)
    else
      Exclude(AOptions, coAfterInsChanged);
  end
  else
    Include(AOptions, coAllowNull);
end;

{-------------------------------------------------------------------------------}
procedure TFDDatSTableMetadataCallback.GetColumnAttributes(
  AColumn: TFDDatSColumn; var AAttributes: TFDDataAttributes);
var
  oFld: TField;
begin
  oFld := FDataSet.GetColumnField(AColumn);
  if oFld <> nil then begin
    if oFld.AutoGenerateValue <> Data.DB.arNone then begin
      case oFld.AutoGenerateValue of
      Data.DB.arAutoInc: Include(AAttributes, caAutoInc);
      Data.DB.arDefault: Include(AAttributes, caDefault);
      end;
    end
    else begin
      Exclude(AAttributes, caAutoInc);
      Exclude(AAttributes, caDefault);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDatSTableMetadataCallback.GetColumnOrigin(AColumn: TFDDatSColumn;
  var AOrigin: String);
var
  oFld: TField;
begin
  oFld := FDataSet.GetColumnField(AColumn);
  if oFld <> nil then
    if oFld.Origin <> '' then
      AOrigin := oFld.Origin;
end;

{-------------------------------------------------------------------------------}
procedure TFDDatSTableMetadataCallback.GetColumnGenerator(
  AColumn: TFDDatSColumn; var AGenerator: String);
var
  oFld: TField;
begin
  oFld := FDataSet.GetColumnField(AColumn);
  if (oFld <> nil) and (oFld is TFDAutoIncField) and
     (TFDAutoIncField(oFld).GeneratorName <> '') then
    AGenerator := TFDAutoIncField(oFld).GeneratorName
  else if FDataSet.UpdateOptions.GeneratorName <> '' then
    AGenerator := FDataSet.UpdateOptions.GeneratorName;
end;

{-------------------------------------------------------------------------------}
procedure TFDDatSTableMetadataCallback.GetColumnCaption(AColumn: TFDDatSColumn;
  var ACaption: String);
var
  oFld: TField;
begin
  oFld := FDataSet.GetColumnField(AColumn);
  if oFld <> nil then
    if (oFld.DisplayLabel <> '') and (oFld.DisplayLabel <> oFld.FieldName) then
      ACaption := oFld.DisplayLabel;
end;

{-------------------------------------------------------------------------------}
procedure TFDDatSTableMetadataCallback.GetTableOrigin(var AOrigin: String);
begin
  if FDataSet.UpdateOptions.UpdateTableName <> '' then
    AOrigin := FDataSet.UpdateOptions.UpdateTableName;
end;

{-------------------------------------------------------------------------------}
function TFDDatSTableMetadataCallback.GetOwner: TObject;
begin
  Result := FDataSet;
end;

{-------------------------------------------------------------------------------}
{ TFDDataSet                                                                    }
{-------------------------------------------------------------------------------}
constructor TFDDataSet.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FIndexes := TFDIndexes.Create(Self);
  FIndexesActive := True;
  FAggregates := TFDAggregates.Create(Self);
  FFieldAggregates := TFDAggregates.Create(Self);
  FAggregatesActive := False;
  FIndexDefs := TIndexDefs.Create(Self);
  FFilterChanges := [rtUnmodified, rtModified, rtInserted];
  FClientCursor := True;
  ObjectView := True;
  FSourceEOF := True;
  FMasterLink := TFDMasterDataLink.Create(Self);
  FMasterLink.OnMasterChange := MasterChanged;
  FMasterLink.OnMasterDisable := MasterDisabled;
  FMasterLink.OnMasterFieldsDefined := MasterDefined;
  FCreatedConstraints := TFDObjList.Create;
  FTempIndexViews := TFDObjList.Create;
  FRecordCount := -1;
  FActiveStoredUsage := [auDesignTime, auRunTime];
  FEventListeners := TInterfaceList.Create;
  ConstraintsEnabled := False;
  FEncoder := TFDEncoder.Create(nil);
  FEncoder.Encoding := ecANSI;
end;

{-------------------------------------------------------------------------------}
destructor TFDDataSet.Destroy;
begin
  AttachTable(nil, nil);
  FDFreeAndNil(FEncoder);
  FDFreeAndNil(FIndexDefs);
  FDFreeAndNil(FAggregates);
  FDFreeAndNil(FFieldAggregates);
  FDFreeAndNil(FIndexes);
  ClearColumnMap;
  FDFreeAndNil(FMasterLink);
  FDFreeAndNil(FCreatedConstraints);
  FDFreeAndNil(FTempIndexViews);
  FDFreeAndNil(FEventListeners);
  SetLength(FSetToRecBmk, 0);
  FSetToRecBmk := nil;
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.GetDataSet: TObject;
begin
  Result := Self;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.SetDataSet(ADataSet: TObject);
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.GetConn: NativeUInt;
begin
  Result := 0;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.IsPKViolation(AExc: Exception): Boolean;
begin
  Result :=
    (AExc is EFDDBEngineException) and (EFDDBEngineException(AExc).Kind = ekUKViolated) or
    (AExc is EFDException) and (EFDException(AExc).FDCode = er_FD_DuplicateRows);
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.GetFeatures: TFDPhysLocalSQLAdapterFeatures;
begin
  Result := [afCachedUpdates, afSavePoints, afIndexFieldNames, afRanges,
    afFilters, afPrimaryKey];
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.AddListener(const AListener: IFDDataSetListener);
begin
  FEventListeners.Add(AListener);
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.RemoveListener(const AListener: IFDDataSetListener);
begin
  FEventListeners.Remove(AListener);
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.DoGetDatSManager: TFDDatSManager;
begin
  Result := nil;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.AttachTable(ATable: TFDDatSTable; AView: TFDDatSView);
var
  i: Integer;
begin
  // It is confusing when SetActive(True) calls AttachTable,
  // and it calls SetActive(False)
  if Active then
    Close;
  if FTable <> ATable then begin
    if FTable <> nil then begin
      for i := 0 to FEventListeners.Count - 1 do
        IFDDataSetListener(FEventListeners[i]).ResultsetReleasing(Self);
      FTable.RemRef;
    end;
    FTable := ATable;
    if FTable <> nil then begin
      FTable.AddRef;
      for i := 0 to FEventListeners.Count - 1 do
        IFDDataSetListener(FEventListeners[i]).ResultsetDefined(Self);
    end;
  end;
  if FView <> AView then begin
    if FView <> nil then
      FView.RemRef;
    FView := AView;
    if FView <> nil then
      FView.AddRef;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.CheckTable;
  procedure ErrorNoTab;
  begin
    FDException(Self, [S_FD_LComp, S_FD_LComp_PDS], er_FD_DSNoDataTable, [GetDisplayName]);
  end;
begin
  if FTable = nil then
    if State in [dsInactive, dsOpening] then begin
      DoDefineDatSManager;
      if FTable = nil then
        ErrorNoTab;
      FTable.Setup(GetOptionsIntf);
    end
    else
      ErrorNoTab;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.InternalHandleException;
var
  oWait: IFDGUIxWaitCursor;
begin
  if not ResourceOptions.ActualSilentMode then begin
    FDCreateInterface(IFDGUIxWaitCursor, oWait);
    oWait.PopWait;
  end;
  try
    FDHandleException;
  finally
    if not ResourceOptions.ActualSilentMode then
      oWait.PushWait;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.DataEvent(Event: TDataEvent; Info: NativeInt);
begin
  case Event of
  deParentScroll:   MasterChanged(Self);
  end;
  inherited DataEvent(Event, Info);
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.GetFetchOptions: TFDFetchOptions;
begin
  Result := OptionsIntf.FetchOptions;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.SetFetchOptions(const AValue: TFDFetchOptions);
begin
  OptionsIntf.FetchOptions.Assign(AValue);
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.GetFormatOptions: TFDFormatOptions;
begin
  Result := OptionsIntf.FormatOptions;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.SetFormatOptions(const AValue: TFDFormatOptions);
begin
  OptionsIntf.FormatOptions.Assign(AValue);
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.GetUpdateOptions: TFDBottomUpdateOptions;
begin
  Result := TFDBottomUpdateOptions(OptionsIntf.UpdateOptions);
  ASSERT((Result <> nil) and (Result is TFDBottomUpdateOptions));
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.SetUpdateOptions(const AValue: TFDBottomUpdateOptions);
begin
  OptionsIntf.UpdateOptions.Assign(AValue);
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.GetResourceOptions: TFDBottomResourceOptions;
begin
  Result := TFDBottomResourceOptions(OptionsIntf.ResourceOptions);
  ASSERT((Result <> nil) and (Result is TFDBottomResourceOptions));
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.SetResourceOptions(const AValue: TFDBottomResourceOptions);
begin
  OptionsIntf.ResourceOptions.Assign(AValue);
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.IsSequenced: Boolean;
begin
  Result := True;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.DoStoredActivation: Boolean;
begin
  Result := FDCheckStoredUsage(ComponentState, ActiveStoredUsage);
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.SetActive(AValue: Boolean);
begin
  if (csReading in ComponentState) or (csUpdating in ComponentState) then
    if AValue then
      Include(FFlags, dfStreamedActive)
    else
      Exclude(FFlags, dfStreamedActive)
  else
    inherited SetActive(AValue);
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.StartWait;
  procedure DoStartWait;
  var
    oWait: IFDGUIxWaitCursor;
  begin
    if not ResourceOptions.ActualSilentMode then begin
      Inc(FWaitCounter);
      if FWaitCounter = 1 then begin
        FDCreateInterface(IFDGUIxWaitCursor, oWait);
        oWait.StartWait;
      end;
    end;
  end;
begin
  if FWaitCounter >= 0 then
    DoStartWait;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.StopWait;
  procedure DoStopWait;
  var
    oWait: IFDGUIxWaitCursor;
  begin
    if FWaitCounter > 0 then begin
      Dec(FWaitCounter);
      if FWaitCounter = 0 then begin
        FDCreateInterface(IFDGUIxWaitCursor, oWait);
        oWait.StopWait;
      end;
    end;
  end;
begin
  if FWaitCounter >= 0 then
    DoStopWait;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.GetParams: TFDParams;
begin
  // nothing
  Result := nil;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.SetParams(const AValue: TFDParams);
begin
  GetParams.Assign(AValue);
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.FindParam(const AValue: string): TFDParam;
begin
  Result := Params.FindParam(AValue);
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.ParamByName(const AValue: string): TFDParam;
begin
  Result := Params.ParamByName(AValue);
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.GetParamsCount: Integer;
begin
  Result := Params.Count;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.GetDisplayName: String;
begin
  if Name <> '' then
    Result := Name
  else
    Result := ClassName + '($' + IntToHex(Integer(Self), 8) + ')';
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.InternalFieldByName(const AFieldName, APlace: String): TField;
  procedure ErrorNoField;
  begin
    FDException(Self, [S_FD_LComp, S_FD_LComp_PDS], er_FD_DSFieldNotFound,
      [AFieldName, APlace, GetDisplayName]);
  end;
begin
  Result := FindField(AFieldName);
  if Result = nil then
    ErrorNoField;
end;

{-------------------------------------------------------------------------------}
{ Master/detail }

function TFDDataSet.GetMasterFields: String;
begin
  Result := FMasterLink.FieldNames;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.SetMasterFields(const AValue: String);
begin
  FMasterLink.FieldNames := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.GetActualDetailFields: String;
var
  oIdx: TFDIndex;
begin
  if fiDetails in FetchOptions.Cache then begin
    if LocalIndexName <> '' then begin
      oIdx := Indexes.FindIndex(LocalIndexName);
      if oIdx <> nil then
        Result := oIdx.Fields
      else
        Result := '';
    end
    else
      Result := IndexFieldNames;
  end
  else
    Result := DetailFields;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.GetDataSource: TDataSource;
begin
  if FMasterLink <> nil then
    Result := FMasterLink.DataSource
  else
    Result := nil;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.SetMasterSource(const AValue: TDataSource);
begin
  if MasterSource <> AValue then begin
    if (AValue <> nil) and (DataSetField <> nil) then
      FDException(Self, [S_FD_LComp, S_FD_LComp_PDS], er_FD_DSNoNestedMasterSource, [GetDisplayName]);
    if IsLinkedTo(AValue) then
      FDException(Self, [S_FD_LComp, S_FD_LComp_PDS], er_FD_DSCircularDataLink, [GetDisplayName]);
    if MasterSource <> nil then
      MasterSource.RemoveFreeNotification(Self);
    FMasterLink.DataSource := AValue;
    if MasterSource <> nil then
      MasterSource.FreeNotification(Self);
    if not (csLoading in ComponentState) and
       (Params <> nil) and (Params.Count > 0) then begin
      MasterFields := '';
      DetailFields := '';
    end;
    DoMasterDefined;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.GetDetailLinkFields(AMasterFields, ADetailFields: TFDFieldList);
var
  sFields: String;
begin
  AMasterFields.Clear;
  ADetailFields.Clear;
  DoMasterDefined;
  if (MasterSource <> nil) and (MasterSource.DataSet <> nil) then begin
    sFields := MasterFields;
    if sFields <> '' then
      MasterSource.DataSet.GetFieldList(AMasterFields, sFields);
    sFields := ActualDetailFields;
    if sFields <> '' then
      GetFieldList(ADetailFields, sFields);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.DoMasterDefined;
var
  s: String;
  i: Integer;
  oParam: TFDParam;
  oField: TField;
begin
  if (MasterSource <> nil) and (MasterSource.DataSet <> nil) and (Params <> nil) then begin
    if MasterFields = '' then begin
      s := '';
      for i := 0 to Params.Count - 1 do begin
        oParam := Params[i];
        oField := MasterSource.DataSet.FindField(oParam.Name);
        if oField <> nil then begin
          if s <> '' then
            s := s + ';';
          s := s + oField.FieldName;
          if oParam.DataType = ftUnknown then
            oParam.AssignFieldValue(oField, Null);
        end;
      end;
      if s <> '' then
        MasterFields := s;
    end;
    if (DetailFields = '') and not (fiDetails in FetchOptions.Cache) then begin
      s := '';
      for i := 0 to Params.Count - 1 do begin
        oParam := Params[i];
        oField := FindField(oParam.Name);
        if oField <> nil then begin
          if s <> '' then
            s := s + ';';
          s := s + oField.FieldName;
        end;
      end;
      if s <> '' then
        DetailFields := s;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.MasterDefined(Sender: TObject);
begin
  DoMasterDefined;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.DoMasterParamChanged(AMasterFieldList: TFDFieldList): Boolean;
var
  i: Integer;
  oParam: TFDParam;
  oField: TField;
begin
  if not FetchOptions.DetailOptimize or Assigned(OnMasterSetValues) or
     (FSourceView = nil) or (FSourceView.Rows.Count = 0) then begin
    Result := True;
    Exit;
  end;
  Result := False;
  if Params <> nil then
    for i := 0 to AMasterFieldList.Count - 1 do begin
      oField := AMasterFieldList[i];
      oParam := Params.FindParam(oField.FieldName);
      if oParam <> nil then begin
        Result := not FDSameVariants(oParam.Value, oField.Value);
        if Result then
          Break;
      end;
    end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.DoMasterParamSetValues(AMasterFieldList: TFDFieldList);
var
  i: Integer;
  oParam: TFDParam;
  oField: TField;
begin
  if Params <> nil then
    for i := 0 to AMasterFieldList.Count - 1 do begin
      oField := AMasterFieldList[i];
      oParam := Params.FindParam(oField.FieldName);
      if oParam <> nil then
        oParam.AssignFieldValue(oField, oField.Value);
    end;
  if Assigned(OnMasterSetValues) then
    OnMasterSetValues(Self);
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.DoMasterParamDependent(AMasterFieldList: TFDFieldList): Boolean;
var
  i: Integer;
  oParam: TFDParam;
  oField: TField;
begin
  if Assigned(OnMasterSetValues) then begin
    Result := True;
    Exit;
  end;
  Result := False;
  if Params <> nil then
    for i := 0 to AMasterFieldList.Count - 1 do begin
      oField := AMasterFieldList[i];
      oParam := Params.FindParam(oField.FieldName);
      if oParam <> nil then begin
        Result := True;
        Break;
      end;
    end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.DoMasterReset;
begin
  ResetMasterRelation;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.MasterDisabled(Sender: TObject);
begin
  if fiDetails in FetchOptions.Cache then
    CancelRange;
  DoMasterReset;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.CheckDetailRecords(AEnforce: Boolean);

  function FetchDetails(AAll: Boolean): Boolean;
  begin
    Result := False;
    if DoIsSourceOnline and (
         DoMasterParamDependent(FMasterLink.Fields) and
         DoMasterParamChanged(FMasterLink.Fields) or
         ((FTable = nil) or (FTable.Rows.Count = 0))
       ) then begin
      if not (fiDetails in FetchOptions.Cache) then
        DoClearBeforeRefetch;
      DoCloseSource;
      DoMasterParamSetValues(FMasterLink.Fields);
      FSourceEOF := False;
      FUnidirRecsPurged := 0;
      FRecordCount := -1;
      DoOpenSource(True, False, (FTable = nil) or (FTable.Columns.Count = 0));
      InternalFetchRows(AAll, False);
      Result := True;
    end;
  end;

var
  lChanged: Boolean;
begin
  lChanged := False;
  if DataSetField = nil then begin
    if AEnforce or
       not MasterSource.DataSet.IsEmpty and
       not (MasterSource.DataSet.State in [dsInsert, dsSetKey]) then begin
      if fiDetails in FetchOptions.Cache then begin
        if not Active or (FSourceView = nil) or (FSourceView.Rows.Count = 0) then
          lChanged := FetchDetails(True);
      end
      else if not DoIsSourceOpen or Active then
        lChanged := FetchDetails(False);
    end
    else if not (fiDetails in FetchOptions.Cache) then begin
      DoClearBeforeRefetch;
      lChanged := True;
    end;
    if Active and lChanged then
      First;
  end
  else begin
    if FetchOptions.Mode in [fmOnDemand, fmAll, fmExactRecsMax] then
      FParentDataSet.FetchDetails;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.MasterRangeChanged: Boolean;
var
  i: Integer;
  iSaveState: TDataSetState;
  oDestFld, oSrcFld: TField;
begin
  iSaveState := SetTempState(dsSetKey);
  try
    FKeyBuffer := ClearKeyBuffer(GetKeyBuffer(kiRangeStart));
    for i := 0 to FMasterLink.Fields.Count - 1 do begin
      oDestFld := GetIndexField(i);
      oSrcFld := FMasterLink.Fields[i];
      oDestFld.Assign(oSrcFld);
    end;
    FKeyBuffer^.FFieldCount := FMasterLink.Fields.Count;
    FKeyBuffer^.FModified := True;
  finally
    RestoreState(iSaveState);
  end;
  AssignKeyBuffer(FKeyBuffers[kiRangeEnd], FKeyBuffers[kiRangeStart]);
  Result := SetCursorRange;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.CheckMasterRange;
begin
  if IsLinkedDetail then begin
    if (IndexFieldCount = 0) and (fiDetails in FetchOptions.Cache) then
      FetchOptions.Cache := FetchOptions.Cache - [fiDetails];
    if fiDetails in FetchOptions.Cache then begin
      if (FMasterRelation = nil) and (DatSManager <> nil) and
         FetchOptions.DetailCascade then
        BuildMasterRelation;
      if ((MasterSource.DataSet.State <> dsEdit) or (FMasterRelation = nil)) and
         MasterRangeChanged() then begin
        CreateFilterView;
        RelinkViews;
        ResyncViews;
      end;
    end;
    if FetchOptions.Mode in [fmOnDemand, fmAll, fmExactRecsMax] then
      CheckDetailRecords(False);
  end
  else begin
    if fiDetails in FetchOptions.Cache then
      CancelRange;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.CheckParentRow;
begin
  if not Active then
    Exit;
  if GetParentRow <> FLastParentRow then begin
    if FetchOptions.Mode in [fmOnDemand, fmAll, fmExactRecsMax] then
      CheckDetailRecords(False);
    DoFilteringUpdated(True);
    First;
  end
  else begin
    UpdateCursorPos;
    Resync([]);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.MasterChanged(Sender: TObject);
begin
  if MasterSource <> nil then
    CheckMasterRange
  else if DataSetField <> nil then
    CheckParentRow;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.ApplyMaster;
begin
  MasterChanged(nil);
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.BuildMasterRelation;

  procedure AddFld(var AFields: String; AField: TField);
  begin
    if AFields <> '' then
      AFields := AFields + ';';
    AFields := AFields + AField.FieldName;
  end;

var
  i: Integer;
  sMast, sDet: String;
  oMan: TFDDatSManager;
  oFK: TFDDatSForeignKeyConstraint;
begin
  if (FMasterRelation <> nil) or (DatSManager = nil) or not FClientCursor or
     (csDesigning in ComponentState) or not (MasterSource.DataSet is TFDDataSet) or
     (TFDDataSet(MasterSource.DataSet).Table = nil) or (Table = nil) or
     (TFDDataSet(MasterSource.DataSet).Table.Manager <> Table.Manager) then
    Exit;
  oMan := DatSManager;
  FMasterRelation := oMan.Relations.FindRelation(TFDDataSet(MasterSource.DataSet).Table,
    Table, False);
  if FMasterRelation = nil then begin
    sMast := '';
    sDet := '';
    for i := 0 to FMasterLink.Fields.Count - 1 do begin
      AddFld(sMast, FMasterLink.Fields[i]);
      AddFld(sDet, GetIndexField(i));
    end;
    FMasterRelation := oMan.Relations.Add('', sMast, sDet, TFDDataSet(MasterSource.DataSet).Table,
      Table, False, True);
    FMasterRelation.CountRef;
    oFK := FMasterRelation.ChildKeyConstraint;
    oFK.InsertRule := crCascade;
    oFK.UpdateRule := crCascade;
    oFK.DeleteRule := crCascade;
  end
  else begin
    FMasterRelation.AddRef;
    oFK := FMasterRelation.ChildKeyConstraint;
  end;
  oFK.CascadeOriginal := FetchOptions.DetailServerCascade;
  ConstraintsEnabled := True;
  TFDDataSet(MasterSource.DataSet).ConstraintsEnabled := True;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.ResetMasterRelation;
begin
  if FMasterRelation = nil then
    Exit;
  FMasterRelation.RemRef;
  FMasterRelation := nil;
end;

{-------------------------------------------------------------------------------}
{ Views management }

procedure TFDDataSet.ResetViews;
begin
  if FSourceView <> nil then begin
    FSourceView.RemRef;
    FSourceView := nil;
    FSourceViewLocator := nil;
  end;
  if FFilterView <> nil then begin
    FFilterView.RemRef;
    FFilterView := nil;
  end;
  if FSortView <> nil then begin
    FSortView.RemRef;
    FSortView := nil;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.CreateFilterMech(AFilter: TFDDatSMechFilter): TFDDatSMechFilter;
var
  expOpts: TFDExpressionOptions;
  evt: TFDFilterRowEvent;
begin
  expOpts := [];
  if foCaseInsensitive in FilterOptions then
    Include(expOpts, ekNoCase);
  if not (foNoPartialCompare in FilterOptions) then
    Include(expOpts, ekPartial);
  if Assigned(OnFilterRecord) then
    evt := DoFilterRow
  else
    evt := nil;
  if AFilter <> nil then
    Result := AFilter
  else
    Result := TFDDatSMechFilter.Create;
  Result.Options := expOpts;
  Result.Expression := Filter;
  Result.OnFilterRow := evt;
  Result.Active := True;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.CreateChildMech: TFDDatSMechChilds;
begin
  Result := TFDDatSMechChilds.Create(GetParentRow);
  FLastParentRow := Result.ParentRow;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.CreateRangeMech: TFDDatSMechRange;
begin
  Result := TFDDatSMechRange.Create;
  Result.Bottom := FRangeFrom;
  Result.BottomExclusive := dfRangeFromExclusive in FFlags;
  Result.BottomColumnCount := FRangeFromFieldCount;
  Result.Top := FRangeTo;
  Result.TopExclusive := dfRangeToExclusive in FFlags;
  Result.TopColumnCount := FRangeToFieldCount;
  Result.Active := True;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.CreateStateMech: TFDDatSMechRowState;
var
  rowStates: TFDDatSRowStates;
begin
  rowStates := [];
  if rtModified in FFilterChanges then
    Include(rowStates, rsModified);
  if rtInserted in FFilterChanges then
    Include(rowStates, rsInserted);
  if rtDeleted in FFilterChanges then
    Include(rowStates, rsDeleted);
  if rtUnmodified in FFilterChanges then
    Include(rowStates, rsUnchanged);
  Result := TFDDatSMechRowState.Create(rowStates);
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.CreateFilterView;
var
  oView: TFDDatSView;

  procedure CheckView;
  begin
    if oView <> nil then
      Exit;
    oView := TFDDatSView.Create(FTable, C_FD_SysNamePrefix + 'FLT',
      vcDataSetFilter, True);
  end;

begin
  oView := nil;
  if FFilterView <> nil then begin
    FFilterView.RemRef;
    FFilterView := nil;
  end;
  try
    if (FParentDataSet <> nil) and (FTable.Manager <> nil) then begin
      CheckView;
      oView.Mechanisms.Add(CreateChildMech);
    end;
    // When range is part of WHERE then local filtering is not needed
    if IsRanged and FClientCursor then begin
      CheckView;
      oView.Mechanisms.Add(CreateRangeMech);
    end;
    if Filtered and ((Filter <> '') or Assigned(OnFilterRecord)) then begin
      CheckView;
      oView.Mechanisms.Add(CreateFilterMech(nil));
    end;
    if FFilterChanges - [rtHasErrors] <>
       [rtUnmodified, rtModified, rtInserted, rtDeleted] then begin
      CheckView;
      oView.Mechanisms.Add(CreateStateMech);
    end;
    if rtHasErrors in FFilterChanges then begin
      CheckView;
      oView.Mechanisms.Add(TFDDatSMechError.Create);
    end;
  except
    if oView <> nil then
      oView.RemRef;
    raise;
  end;
  FFilterView := oView;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.RelinkViews;
begin
  FAggregates.Release;
  FFieldAggregates.Release;
  if FSourceView <> nil then begin
    FSourceView.RemRef;
    FSourceView := nil;
    FSourceViewLocator := nil;
  end;
  if FFilterView <> nil then begin
    if FSortView <> nil then
      FFilterView.SourceView := FSortView
    else
      FFilterView.SourceView := FView;
    FSourceView := FFilterView;
    FSourceView.AddRef;
  end;
  if FSortView <> nil then begin
    FSortView.SourceView := FView;
    FSortView.Active := True;
    if FSourceView = nil then begin
      FSourceView := FSortView;
      FSourceView.AddRef;
    end;
  end;
  if FFilterView <> nil then
    FFilterView.Active := True;
  if FSourceView = nil then begin
    if FView <> nil then
      FSourceView := FView
    else
      FSourceView := FTable.FullView;
    FSourceView.AddRef;
  end;
  FAggregates.Build;
  FFieldAggregates.Build;
  FSourceView.Active := True;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.ResyncViews;
var
  oLastRow: TFDDatSRow;
begin
  if Active then begin
    oLastRow := GetRow;
    if oLastRow <> nil then
      FRecordIndex := FSourceView.IndexOf(oLastRow);
    Include(FFlags, dfLockNoBMK);
    try
      UpdateCursorPos;
      Resync([]);
    finally
      Exclude(FFlags, dfLockNoBMK);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.SetTableConstraints;

  procedure ProcessFields(ATab: TFDDatSTable; AConstraints: TCheckConstraints;
    AFields: TFields);
  var
    i: Integer;
    oCol: TFDDatSColumn;
    oCons: TCheckConstraint;
    oFld: TField;
  begin
    if AConstraints <> nil then
      for i := 0 to AConstraints.Count - 1 do begin
        oCons := AConstraints[i];
        if oCons.ImportedConstraint <> '' then
          FCreatedConstraints.Add(ATab.Constraints.AddChk('', oCons.ImportedConstraint,
            oCons.ErrorMessage, ctAtEditEnd));
        if oCons.CustomConstraint <> '' then
          FCreatedConstraints.Add(ATab.Constraints.AddChk('', oCons.CustomConstraint,
            oCons.ErrorMessage, ctAtEditEnd));
      end;
    if AFields <> nil then
      for i := 0 to AFields.Count - 1 do begin
        oFld := AFields[i];
        if oFld.ImportedConstraint <> '' then
          FCreatedConstraints.Add(ATab.Constraints.AddChk('', oFld.ImportedConstraint,
            oFld.ConstraintErrorMessage, ctAtColumnChange));
        if oFld.CustomConstraint <> '' then
          FCreatedConstraints.Add(ATab.Constraints.AddChk('', oFld.CustomConstraint,
            oFld.ConstraintErrorMessage, ctAtColumnChange));
        if (oFld is TObjectField) and (oFld.DataType in [ftADT, ftArray]) then begin
          oCol := GetFieldColumn(oFld);
          if (oFld.DataType = ftArray) and SparseArrays and (TObjectField(oFld).Fields[0].DataType = ftADT) then
            ProcessFields(oCol.NestedTable, nil, TObjectField(TObjectField(oFld).Fields[0]).Fields)
          else
            ProcessFields(oCol.NestedTable, nil, TObjectField(oFld).Fields);
        end;
      end;
  end;

begin
  ProcessFields(FTable, Constraints, Fields);
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.ResetTableConstraints;
var
  i: Integer;
begin
  for i := 0 to FCreatedConstraints.Count - 1 do
    FDFree(TFDDatSCheckConstraint(FCreatedConstraints[i]));
  FCreatedConstraints.Clear;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.SetFieldAttributes(AField: TField; AColumn: TFDDatSColumn);
var
  oObjFld: TObjectField;
  oFmt: TFDFormatOptions;
begin
  if AField is TObjectField then begin
    oObjFld := TObjectField(AField);
    oObjFld.ObjectType := AColumn.SourceDataTypeName;
    if oObjFld.DataType in [ftADT, ftArray] then begin
      if (oObjFld.DataType = ftArray) and SparseArrays and (oObjFld.Fields[0].DataType = ftADT) then
        SetFieldAttributes([lcAutomatic], TObjectField(oObjFld.Fields[0]).Fields)
      else
        SetFieldAttributes([lcAutomatic], oObjFld.Fields);
    end;
  end;
  AField.Origin := AColumn.OriginColName;
  AField.DefaultExpression := AColumn.Expression;
  if AField is TFDAutoIncField then
    TFDAutoIncField(AField).GeneratorName := AColumn.SourceGenerator;
  AField.ProviderFlags := [];
  if coInUpdate in AColumn.Options then
    AField.ProviderFlags := AField.ProviderFlags + [pfInUpdate];
  if coInWhere in AColumn.Options then
    AField.ProviderFlags := AField.ProviderFlags + [pfInWhere];
  if AField.AutoGenerateValue = TAutoRefreshFlag.arNone then begin
    if caAutoInc in AColumn.Attributes then
      AField.AutoGenerateValue := TAutoRefreshFlag.arAutoInc;
    if ([caCalculated, caDefault, caROWID, caVolatile, caRowVersion, caExpr] * AColumn.Attributes <> []) or
       not (caBase in AColumn.Attributes) then
      AField.AutoGenerateValue := TAutoRefreshFlag.arDefault;
  end;
  if coInKey in AColumn.Options then
    AField.ProviderFlags := AField.ProviderFlags + [pfInKey]
  else
    AField.ProviderFlags := AField.ProviderFlags - [pfInKey];
  AField.ReadOnly := UpdateOptions.CheckReadOnly and (coReadOnly in AColumn.Options);
  oFmt := FormatOptions;
  if AField is TDateField then
    TDateField(AField).DisplayFormat := oFmt.FmtDisplayDate
  else if AField is TTimeField then
    TTimeField(AField).DisplayFormat := oFmt.FmtDisplayTime
  else if AField is TDateTimeField then
    TDateTimeField(AField).DisplayFormat := oFmt.FmtDisplayDateTime
  else if AField is TSQLTimeStampField then
    TSQLTimeStampField(AField).DisplayFormat := oFmt.FmtDisplayDateTime
  else if AField is TNumericField then begin
    TNumericField(AField).DisplayFormat := oFmt.FmtDisplayNumeric;
    TNumericField(AField).EditFormat := oFmt.FmtEditNumeric;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.SetFieldAttributes(ALifeCycles: TFieldLifeCycles; AFields: TFields);
var
  i: Integer;
  oFld: TField;
  oCol: TFDDatSColumn;
begin
  for i := 0 to AFields.Count - 1 do begin
    oFld := AFields[i];
    if (oFld.LifeCycle in ALifeCycles) and (oFld.FieldNo >= 1) then begin
      oCol := GetFieldColumn(oFld);
      SetFieldAttributes(oFld, oCol);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.SetFieldAttributes(ALifeCycles: TFieldLifeCycles);
begin
  SetFieldAttributes(ALifeCycles, Fields);
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.SetFieldsKeyIncAttributes;
var
  oUpdOpts: TFDBottomUpdateOptions;
  i: Integer;
  oFld: TField;
begin
  oUpdOpts := UpdateOptions;
  if oUpdOpts.KeyFields <> '' then begin
    for i := 0 to FieldCount - 1 do begin
      oFld := Fields[i];
      oFld.ProviderFlags := oFld.ProviderFlags - [pfInKey];
    end;
    i := 1;
    while i <= Length(oUpdOpts.KeyFields) do begin
      oFld := InternalFieldByName(FDExtractFieldName(oUpdOpts.KeyFields, i),
                                  'UpdateOptions.KeyFields');
      oFld.ProviderFlags := oFld.ProviderFlags + [pfInKey];
    end;
  end;
  if oUpdOpts.AutoIncFields <> '' then begin
    for i := 0 to FieldCount - 1 do begin
      oFld := Fields[i];
      if oFld.AutoGenerateValue = TAutoRefreshFlag.arAutoInc then
        oFld.AutoGenerateValue := TAutoRefreshFlag.arNone;
    end;
    i := 1;
    while i <= Length(oUpdOpts.AutoIncFields) do begin
      oFld := InternalFieldByName(FDExtractFieldName(oUpdOpts.AutoIncFields, i),
                                  'UpdateOptions.AutoIncFields');
      oFld.AutoGenerateValue := TAutoRefreshFlag.arAutoInc;
      oFld.Required := False;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.SetFieldAutoGenerateValue(AField: TField;
  AValue: TAutoRefreshFlag);
begin
  AField.AutoGenerateValue := AValue;
  if AValue = TAutoRefreshFlag.arAutoInc then begin
    AField.ProviderFlags := AField.ProviderFlags - [pfInUpdate] + [pfInWhere, pfInKey];
    AField.Required := False;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.SetColumnAttributes(ALifeCycles: TFieldLifeCycles);
var
  i: Integer;
  oCol: TFDDatSColumn;
  oFld: TField;
begin
  if dfColumnAttributesUpdated in FFlags then
    Exit;
  Include(FFlags, dfColumnAttributesUpdated);
  for i := 0 to Fields.Count - 1 do begin
    oFld := Fields[I];
    if (oFld.LifeCycle in ALifeCycles) and (oFld.FieldKind = fkData) then begin
      oCol := GetFieldColumn(Fields[I]);
      if oFld.DefaultExpression <> '' then
        oCol.Expression := oFld.DefaultExpression;
      if not oFld.Required then
        oCol.Attributes := oCol.Attributes + [caAllowNull];
      if oFld is TFDAutoIncField then begin
        oCol.AutoIncrement := TFDAutoIncField(oFld).ClientAutoIncrement;
        oCol.ServerAutoIncrement := TFDAutoIncField(oFld).ServerAutoIncrement;
        oCol.AutoIncrementSeed := TFDAutoIncField(oFld).AutoIncrementSeed;
        oCol.AutoIncrementStep := TFDAutoIncField(oFld).AutoIncrementStep;
        oCol.SourceGenerator := TFDAutoIncField(oFld).GeneratorName;
      end
      else if oFld.AutoGenerateValue = arAutoInc then
        oCol.ServerAutoIncrement := True;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.UpdateAttributes;
begin
  Exclude(FFlags, dfColumnAttributesUpdated);
  SetColumnAttributes([lcAutomatic, lcPersistent]);
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.SetInternalCalcs(ALifeCycles: TFieldLifeCycles);
var
  oFmtOpts: TFDFormatOptions;
  i, j: Integer;
  oCol: TFDDatSColumn;
  oFld: TField;
  iDestPrec, iDestScale: Integer;
  iDestSize: LongWord;
  iDestDataType: TFDDataType;
  iDestAttrs: TFDDataAttributes;
begin
  oFmtOpts := FormatOptions;
  for i := 0 to Fields.Count - 1 do begin
    oFld := Fields[i];
    if (oFld.LifeCycle in ALifeCycles) and (oFld.FieldKind = fkInternalCalc) then begin
      j := FTable.Columns.IndexOfName(oFld.FieldName);
      if j = -1 then
        oCol := TFDDatSColumn.Create
      else
        oCol := FTable.Columns.ItemsI[j];
      oFmtOpts.FieldDef2ColumnDef(oFld, iDestDataType, iDestSize,
        iDestPrec, iDestScale, iDestAttrs);
      iDestAttrs := iDestAttrs + [caAllowNull, caCalculated];
      if not (iDestDataType in C_FD_NonSearchableDataTypes) then
        iDestAttrs := iDestAttrs + [caSearchable];

      oCol.Name := oFld.FieldName;
      oCol.Options := [coAllowNull];
      oCol.Attributes := iDestAttrs;
      oCol.Expression := oFld.DefaultExpression;
      if oFld.DataType = ftAutoInc then
        oCol.AutoIncrement := True;
      oCol.DataType := iDestDataType;
      oCol.Size := iDestSize;
      oCol.Precision := iDestPrec;
      oCol.Scale := iDestScale;

      if j = -1 then
        FTable.Columns.Add(oCol);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.SetUpdateFieldAttributes;
var
  oUpdOpts: TFDBottomUpdateOptions;
begin
  if FDataLoadSave <> nil then
    Exit;
  oUpdOpts := UpdateOptions;
  Table.CheckNotNull := oUpdOpts.CheckRequired;
  Table.CheckReadOnly := oUpdOpts.CheckReadOnly;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.SetSortView(AView: TFDDatSView);
var
  i: Integer;
  lRebuildFilter: Boolean;
begin
  if FSortView = AView then
    Exit;
  if Active then
    lRebuildFilter := ResetCursorRange
  else
    lRebuildFilter := False;
  Exclude(FFlags, dfCalcFieldInIndex);
  if FSortView <> nil then
    FSortView.RemRef;
  FSortView := AView;
  if FSortView <> nil then begin
    FSortView.AddRef;
    if State = dsBrowse then
      AllocKeyBuffers;
    if FSortView.SortingMechanism <> nil then
      for i := 0 to FSortView.SortingMechanism.SortColumnList.Count - 1 do
        if caCalculated in FSortView.SortingMechanism.SortColumnList.ItemsI[i].Attributes then begin
          Include(FFlags, dfCalcFieldInIndex);
          Break;
        end;
  end;
  if Active then begin
    if lRebuildFilter then
      CreateFilterView;
    RelinkViews;
    DoSortOrderChanged;
    ResyncViews;
    CheckMasterRange;
  end
  else
    DoSortOrderChanged;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.BuildViewForIndex(AIndex: TFDIndex): TFDDatSView;
var
  sFieldsOrExpr: String;
  eOptions: TFDSortOptions;
begin
  Result := TFDDatSView.Create(FTable, AIndex.Name, vcDataSetIndex, True);
  try
    eOptions := AIndex.Options;
    if AIndex.Fields <> '' then begin
      // make options as var parameter for NullLocation option
      sFieldsOrExpr := DoAdjustSortFields(AIndex.Fields, '', eOptions);
      Result.Mechanisms.AddSort(sFieldsOrExpr, AIndex.DescFields,
        AIndex.CaseInsFields, eOptions);
    end
    else if AIndex.Expression <> '' then begin
      sFieldsOrExpr := DoAdjustSortFields('', AIndex.Expression, eOptions);
      Result.Mechanisms.AddSort(sFieldsOrExpr, eOptions);
    end;
    if AIndex.Distinct then
      Result.Mechanisms.AddDistinct(-1);
    if AIndex.Filter <> '' then
      Result.Mechanisms.AddFilter(AIndex.Filter, AIndex.FilterOptions);
    Result.Active := AIndex.Active;
  except
    FDFree(Result);
    raise;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.CheckFetchedAllBeforeSorting;
begin
  if FClientCursor and
     ((dfDataSetOpened in FFlags) and not (dfDataSetOpening in FFlags) and
     DoIsSourceOpen and (FTable <> nil)) and
     ((MasterSource = nil) or not (fiDetails in FetchOptions.Cache)) and
     (FetchOptions.Mode in [fmOnDemand, fmAll, fmExactRecsMax]) then
    CheckFetchedAll;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.SwitchToIndex(const AFieldNames, AIndexName: String);
var
  oView: TFDDatSView;
  sFields: String;
  eOptions: TFDSortOptions;
begin
  if Active then
    CheckBrowseMode;
  if not IndexesActive then
    Exit;
  if (AFieldNames <> '') or (AIndexName <> '') then
    CheckFetchedAllBeforeSorting;
  if AFieldNames <> '' then begin
    oView := FTable.Views.FindSortedView(AFieldNames, [], [soNoCase, soDescending]);
    if oView = nil then begin
      oView := TFDDatSView.Create(FTable, C_FD_SysNamePrefix + 'IND_' + AFieldNames,
        vcDataSetTempIndex, True);
      try
        eOptions := FormatOptions.SortOptions;
        sFields := DoAdjustSortFields(AFieldNames, '', eOptions);
        oView.Mechanisms.AddSort(sFields, '', '', eOptions);
        oView.Active := True;
      except
        FDFree(oView);
        raise;
      end;
      FTempIndexViews.Add(oView);
    end;
    SetSortView(oView);
  end
  else if AIndexName <> '' then begin
    oView := FTable.Views.ViewByName(AIndexName);
    if oView.SortingMechanism = nil then
      FDException(Self, [S_FD_LComp, S_FD_LComp_PDS], er_FD_DSViewNotSorted, [AIndexName]);
    SetSortView(oView);
  end
  else
    SetSortView(nil);
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.OpenIndexes;
var
  i: Integer;
begin
  if IndexDefs.Count > 0 then begin
    Include(FFlags, dfPreserveCurrentIndex);
    try
      Indexes.Clear;
      for i := 0 to IndexDefs.Count - 1 do
        Indexes.Add.Assign(IndexDefs[i]);
    finally
      Exclude(FFlags, dfPreserveCurrentIndex);
    end;
  end
  else begin
    IndexDefs.Updated := False;
    IndexDefs.Update;
  end;
  Indexes.Build;
  IndexDefs.Updated := True;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.ResetIndexes;
var
  i: Integer;
begin
  if dfClearIndexDefs in FFlags then begin
    IndexDefs.Clear;
    Exclude(FFlags, dfClearIndexDefs);
  end
  else begin
    Include(FFlags, dfPreserveCurrentIndex);
    try
      Indexes.Clear;
    finally
      Exclude(FFlags, dfPreserveCurrentIndex);
    end;
  end;
  Indexes.Release;
  for i := 0 to FTempIndexViews.Count - 1 do
    TFDDatSView(FTempIndexViews[i]).RemRef;
  FTempIndexViews.Clear;
  IndexDefs.Updated := dfClearIndexDefs in FFlags;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.UpdateIndexDefs;
var
  i: Integer;
begin
  if (csDesigning in ComponentState) and (IndexDefs.Count > 0) then
    Exit;
  if not IndexDefs.Updated then begin
    IndexDefs.Clear;
    for i := 0 to Indexes.Count - 1 do
      IndexDefs.AddIndexDef.Assign(Indexes[i]);
    IndexDefs.Updated := True;
    Include(FFlags, dfClearIndexDefs);
  end;
end;

{-------------------------------------------------------------------------------}
{ Open / close }

procedure TFDDataSet.DoPrepareSource;
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.DoUnprepareSource;
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.InternalDefineDatSManager;
var
  oTab: TFDDatSTable;
  i: Integer;
begin
  oTab := nil;
  if (DatSManager <> nil) and (Name <> '') then begin
    i := DatSManager.Tables.IndexOfName(Name);
    if i <> -1 then
      oTab := DatSManager.Tables[i];
  end;
  if (oTab <> nil) or (Fields.Count > 0) or (FieldDefs.Count > 0) then
    InitTable(oTab, (oTab <> nil) and (oTab.Columns.Count > 0) or
                    (FStorage = nil) or not FStorage.IsStored(siMeta));
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.DoDefineDatSManager;
begin
  InternalDefineDatSManager;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.DoOpenSource(ABlocked, AInfoQuery, AStructQuery: Boolean);
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.DoIsSourceOpen: Boolean;
begin
  Result := False;
  // nothing
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.DoIsSourceAsync: Boolean;
begin
  Result := GetResourceOptions.CmdExecMode = amAsync;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.DoIsSourceOnline: Boolean;
begin
  Result := not (dfOfflining in FFlags);
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.DoCloseSource;
begin
  if (Fields.LifeCycles = [lcPersistent]) and (FieldOptions.AutoCreateMode = acExclusive) and
     (ParentDataSet = nil) then begin
    FieldDefs.Clear;
    FieldDefs.Updated := False;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.DoResetDatSManager;
begin
  FAggregates.Release;
  FFieldAggregates.Release;
  FIndexes.Release;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.DoExecuteSource(ATimes, AOffset: Integer);
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.DoClearBeforeRefetch;
begin
  ClearBuffers;
  if FTable <> nil then
    FTable.Clear;
  FSourceEOF := True;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.DoCreateFields;
begin
  CreateFields;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.DoBeforeExecute;
begin
  if Assigned(FBeforeExecute) then
    FBeforeExecute(Self);
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.DoAfterExecute;
begin
  if Assigned(FAfterExecute) then
    FAfterExecute(Self);
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.OpenCursor(InfoQuery: Boolean);
begin
  StartWait;
  try
    if Designer <> nil then
      DoResetDatSManager;
    FFlags := FFlags - [dfColumnAttributesUpdated, dfDataSetOpened, dfDataSetOpening];
    SetUniDirectional(FetchOptions.Unidirectional);
    FSourceEOF := False;
    FUnidirRecsPurged := 0;
    FRecordCount := -1;
    FLastSavePoint := 0;
    FLastColumn := nil;
    FLastField := nil;
    if dfOfflining in FFlags then
      CheckTable
    else
      if DataSetField = nil then begin
        DoMasterDefined;
        if LoadFromFileAtOpen then begin
          FStorage := ResourceOptions.GetStorage(ResourceOptions.PersistentFileName,
            ResourceOptions.DefaultStoreFormat);
          try
            FStorage.Open(ResourceOptions, FEncoder, ResourceOptions.PersistentFileName, nil, smRead);
            InternalLoadFromStorage;
          finally
            FStorage := nil;
          end;
        end
        else if FStorage <> nil then
          InternalLoadFromStorage
        else begin
          if IsLinked then
            DoMasterParamSetValues(FMasterLink.Fields);
          DoPrepareSource;
          if not DoIsSourceAsync or InfoQuery then begin
            CheckTable;
            if lcPersistent in Fields.LifeCycles then
              SetInternalCalcs([lcPersistent]);
          end;
        end;
      end
      else begin
        FParentDataSet := DataSetField.DataSet as TFDDataSet;
        OpenParentDataSet(FParentDataSet);
        if FieldDefs.HiddenFields <> FParentDataSet.FieldDefs.HiddenFields then
          FieldDefs.HiddenFields := FParentDataSet.FieldDefs.HiddenFields;
        AttachTable(FParentDataSet.GetFieldColumn(DataSetField).NestedTable, nil);
      end;
    if (DataSetField = nil) and InfoQuery then begin
      DoOpenSource(True, InfoQuery, True);
      inherited OpenCursor(InfoQuery);
    end
    else if (DataSetField = nil) and DoIsSourceAsync then begin
      DoOpenSource(False, InfoQuery, True);
      SetState(dsOpening);
    end
    else begin
      inherited OpenCursor(InfoQuery);
      if (DataSetField = nil) and (NestedDataSets <> nil) and (NestedDataSets.Count > 0) then
        DataEvent(deDataSetChange, 0);
    end;
  finally
    StopWait;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.IsLinkedNested: Boolean;
begin
  Result := (FParentDataSet <> nil);
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.IsLinkedDetail: Boolean;
begin
  Result := FMasterLink.Active and
    ((FMasterLink.Fields.Count > 0) and
     (not (State in [dsInactive, dsOpening]) and (IndexFieldCount > 0) or
      (State in [dsInactive, dsOpening]) and ((IndexFieldNames <> '') or (LocalIndexName <> '')) or
      DoMasterParamDependent(FMasterLink.Fields)) or
     Assigned(OnMasterSetValues));
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.IsLinked: Boolean;
begin
  Result := IsLinkedNested or IsLinkedDetail;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.CloseCursor;
begin
  StartWait;
  try
    inherited CloseCursor;
  finally
    StopWait;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.InternalOpen;
var
  lDeferOpen, lLoadedFromStorage: Boolean;
begin
  FFlags := FFlags + [dfDataSetOpened, dfDataSetOpening];
  CheckTable;
  lLoadedFromStorage := LoadFromFileAtOpen or (FStorage <> nil);
  lDeferOpen := IsLinked and (Table.Columns.Count > 0);
  if lcPersistent in Fields.LifeCycles then
    if not lLoadedFromStorage then
      SetInternalCalcs([lcPersistent])
    else
                                                                                          ;
  if (FetchOptions.Mode in [fmOnDemand, fmAll, fmExactRecsMax]) and
     (State <> dsOpening) and not lDeferOpen and not FSourceEOF and
     not (dfOfflining in FFlags) then
    DoOpenSource(True, False, True);
  OpenIndexes;
  if (FIndexFieldNames <> '') or (FIndexName <> '') then begin
    DoSortOrderChanging;
    SwitchToIndex(FIndexFieldNames, FLocalIndexName);
  end;
  CreateFilterView;
  RelinkViews;
  FRecordIndex := -1;
  FPrevRecordIndex := -1;
  if not FieldDefs.Updated then
    FieldDefs.Update
  else if not RenewColumnMap then begin
    FieldDefs.Updated := False;
    FieldDefs.Update;
  end;
  DoCreateFields;
  BindFields(True);
  SetViewAggregates;
  SetTableConstraints;
  if lcAutomatic in Fields.LifeCycles then
    SetFieldAttributes([lcAutomatic]);
  if (lcPersistent in Fields.LifeCycles) and not lLoadedFromStorage then begin
    SetFieldsKeyIncAttributes;
    SetColumnAttributes([lcPersistent]);
  end;
  SetUpdateFieldAttributes;
  if FTable.MetadataCallback = nil then
    FTable.MetadataCallback := TFDDatSTableMetadataCallback.Create(Self);
  InitBufferPointers;
  if FSortView <> nil then
    AllocKeyBuffers;
  FTable.Constraints.Enforce := (FConstDisableCount = 0);
  FTable.UpdateLayout;
  if ControlsDisabled and IsLinkedDetail then
    MasterLink.ActiveChanged;
  if (FetchOptions.Mode in [fmOnDemand, fmAll, fmExactRecsMax]) and
     (State <> dsOpening) and lDeferOpen then
    MasterChanged(Self);
  if Assigned(OnFilterRecord) and Filtered and (FFilterView <> nil) then
    FFilterView.Rebuild;
  Exclude(FFlags, dfDataSetOpening);
  if FSortView <> nil then
    CheckFetchedAllBeforeSorting;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.DoAfterOpen;
var
  i: Integer;
begin
  if FetchOptions.RecordCountMode = cmTotal then
    GetRecordCount;
  for i := 0 to FEventListeners.Count - 1 do
    IFDDataSetListener(FEventListeners[i]).ResultsetActivated(Self);
  inherited DoAfterOpen;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.CheckAsyncOpenComplete;
begin
  if DoIsSourceAsync then
    try
      // Perform first fetch in background. This is at first required for the case
      // if FetchOptions.Mode = fmAll, then fetch all records in background.
      CheckTable;
      InternalFetchRows(False, True);
      TFDThread.Synchronize(OpenCursorComplete);
    except
      CheckAsyncOpenFailed;
      raise;
    end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.CheckAsyncOpenFailed;
begin
  if DoIsSourceAsync then begin
    SetState(dsInactive);
    CloseCursor;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.InternalClose;
begin
  if not (dfDataSetOpened in FFlags) then begin
    DoCloseSource;
    Exit;
  end;
  FFlags := FFlags - [dfDataSetOpened, dfDataSetOpening];
  if FDataLoadSave <> nil then
    EndBatch;
  if FTable <> nil then begin
    if (FTable.MetadataCallback <> nil) and (FTable.MetadataCallback.GetOwner = Self) then
      FTable.MetadataCallback := nil;
    FTable.RemoveDataCallback(Self, True);
  end;
  if IsForceRowMode then
    EndForceRow;
  ResetMasterRelation;
  ResetTableConstraints;
  ResetCursorRange;
  FreeKeyBuffers;
  FRecordCount := -1;
  BindFields(False);
  DestroyFields;
  ResetViewAggregates;
  ResetIndexes;
  ResetViews;
  FCloneSource := nil;
  FRecordIndex := -1;
  FPrevRecordIndex := -1;
  FSourceEOF := True;
  FUnidirRecsPurged := 0;
  FLastParentRow := nil;
  if FLocateRow <> nil then begin
    FDFreeAndNil(FLocateRow);
    FDFreeAndNil(FLocateColumns);
  end;
  if FParentDataSet = nil then
    DoCloseSource;
  if SaveToFileAtClose then begin
    FStorage := ResourceOptions.GetStorage(ResourceOptions.PersistentFileName,
      ResourceOptions.DefaultStoreFormat);
    try
      FStorage.Open(ResourceOptions, FEncoder, ResourceOptions.PersistentFileName, nil, smWrite);
      InternalSaveToStorage;
    finally
      FStorage := nil;
    end;
  end;
  if Designer = nil then
    DoResetDatSManager;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.IsCursorOpen: Boolean;
begin
  Result := (FSourceView <> nil) and FSourceView.ActualActive;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.Execute(ATimes: Integer = 0; AOffset: Integer = 0);
begin
  CheckInactive;
  StartWait;
  try
    DoBeforeExecute;
    if DoMasterParamDependent(FMasterLink.Fields) then
      DoMasterParamSetValues(FMasterLink.Fields);
    DoPrepareSource;
    DoExecuteSource(ATimes, AOffset);
    if not DoIsSourceAsync then
      DoAfterExecute;
  finally
    StopWait;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.OpenOrExecute: Boolean;
begin
  try
    Open;
  except
    on E: EFDException do
      if E.FDCode <> er_FD_AccCmdMHRowSet then
        raise;
  end;
  Result := Active;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.CheckAsyncExecFinished;
begin
  if DoIsSourceAsync then
    TFDThread.Synchronize(DoAfterExecute);
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.Disconnect(AAbortJob: Boolean = False);
begin
  if not (dfOfflining in FFlags) then begin
    Active := False;
    if FSourceView <> nil then
      InternalClose
    else if Table <> nil then
      DoResetDatSManager;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.ReleaseBase(AOffline: Boolean);
begin
  if dfOfflining in FFlags then
    Exit;
  Include(FFlags, dfOfflining);
  try
    if Active and not SourceEOF and DoIsSourceOpen and not IsUnidirectional then
      case FetchOptions.AutoFetchAll of
      afAll:      CheckFetchedAll;
      afTruncate: FSourceEOF := True;
      afDisable:  FDException(Self, [S_FD_LComp, S_FD_LComp_PDS],
                              er_FD_DSCantOffline, [GetDisplayName]);
      end;
    if AOffline then
      DoUnprepareSource
    else
      DoCloseSource;
  finally
    Exclude(FFlags, dfOfflining);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.Offline;
begin
  ReleaseBase(True);
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.Release;
begin
  ReleaseBase(False);
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.CheckOnline(APrepare: Boolean = True);
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.Online;
begin
  CheckOnline;
end;

{-------------------------------------------------------------------------------}
{ Field defs }

procedure TFDDataSet.ClearColumnMap;
var
  i: Integer;
begin
  for i := 0 to Length(FColumns) - 1 do
    FDFree(TFDColMapItem(FColumns[i]));
  SetLength(FColumns, 0);
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.AddFieldDesc(AFmtOpts: TFDFormatOptions; ADefs: TFieldDefs;
  AColumn: TFDDatSColumn; var AFieldId: Integer; APath: TFDPtrList): TFieldDef;
var
  i: Integer;
  iSize: LongWord;
  iPrecision, iScale: Integer;
  eType: TFieldType;
  sName: String;
  oChildTab: TFDDatSTable;
  oColMapItem: TFDColMapItem;
begin
  sName := AColumn.Name;
  i := 0;
  while ADefs.IndexOf(sName) >= 0 do begin
    Inc(i);
    sName := Format('%s_%d', [AColumn.Name, i]);
  end;
  AFmtOpts.ColumnDef2FieldDef(AColumn.DataType, AColumn.Size, AColumn.Precision,
    AColumn.Scale, AColumn.Attributes, eType, iSize, iPrecision, iScale);
  if AColumn.DataType in [dtRowSetRef, dtCursorRef, dtRowRef, dtArrayRef] then begin
    oChildTab := AColumn.NestedTable;
    if AColumn.DataType in [dtRowRef, dtArrayRef] then begin
      iSize := 0;
      for i := 0 to oChildTab.Columns.Count - 1 do
        if not (caInternal in oChildTab.Columns.ItemsI[i].Attributes) then
          Inc(iSize);
    end;
  end
  else begin
    oChildTab := nil;
    if (eType in [ftBCD, ftFMTBcd]) and (iSize = 0) and (iScale > 0) then
      iSize := iScale;
  end;
  // Without that code DataSnap converts ftMemo to ftString and writing
  // a MEMO with size more than 8K will fail.
  if AFmtOpts.DataSnapCompatibility and
     (eType in [ftBlob, ftGraphic, ftTypedBinary, ftMemo, ftFmtMemo, ftDBaseOle,
                ftOraBlob, ftOraClob, ftWideMemo]) then
    iSize := 0;

  Result := TFieldDef.Create(ADefs, sName, eType, iSize, False, AFieldId);
  Result.Precision := iPrecision;
  Result.InternalCalcField := (caCalculated in AColumn.Attributes) and (AColumn.SourceID <= 0);
  Result.Attributes := [];
  if not AColumn.AllowDBNull then
    Result.Attributes := Result.Attributes + [TFieldAttribute.faRequired];
  if AColumn.ReadOnly and UpdateOptions.CheckReadOnly then
    Result.Attributes := Result.Attributes + [TFieldAttribute.faReadOnly];
  if caInternal in AColumn.Attributes then
    Result.Attributes := Result.Attributes + [TFieldAttribute.faHiddenCol];
  if caUnnamed in AColumn.Attributes then
    Result.Attributes := Result.Attributes + [TFieldAttribute.faUnnamed];
  if caFixedLen in AColumn.Attributes then
    Result.Attributes := Result.Attributes + [TFieldAttribute.faFixed];

  oColMapItem := TFDColMapItem.Create;
  oColMapItem.FColumn := AColumn;
  oColMapItem.FColumnIndex := AColumn.Index;
  SetLength(oColMapItem.FPath, APath.Count);
  for i := 0 to APath.Count - 1 do
    oColMapItem.FPath[i] := Integer(APath[i]);

  FColumns[AFieldID - 1] := oColMapItem;
  Inc(AFieldID);
  if (oChildTab <> nil) and not (AColumn.DataType in [dtRowSetRef, dtCursorRef]) then begin
    APath.Add(Pointer(AColumn.Index));
    try
      AddTableDesc(AFmtOpts, Result.ChildDefs, oChildTab, AFieldID, APath);
    finally
      APath.Delete(APath.Count - 1);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.AddTableDesc(AFmtOpts: TFDFormatOptions; ADefs: TFieldDefs;
  ATable: TFDDatSTable; var AFieldId: Integer; APath: TFDPtrList);
var
  i: Integer;
  oCol: TFDDatSColumn;
  oPrevCbk: IFDDatSTableMetadataCallback;
begin
  // If do not clear callback here, then opened DataSet will give AV
  // on DataSet.FieldDefs.Update call. Because TFDDatSTableCallback.DescribeColumn
  // calls TFDDataSet.GetColumnField, and there items in FColumns are nil's.
  oPrevCbk := ATable.MetadataCallback;
  ATable.MetadataCallback := nil;
  try
    SetLength(FColumns, Length(FColumns) + ATable.Columns.Count);
    for i := 0 to ATable.Columns.Count - 1 do begin
      oCol := ATable.Columns.ItemsI[i];
      if not (caInternal in oCol.Attributes) then
        AddFieldDesc(AFmtOpts, ADefs, oCol, AFieldId, APath);
    end;
  finally
    ATable.MetadataCallback := oPrevCbk;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.InternalInitFieldDefs;
var
  iFldId: Integer;
  oPath: TFDPtrList;
begin
  iFldId := 1;
  ClearColumnMap;
  FieldDefs.Clear;
  if FTable <> nil then begin
    oPath := TFDPtrList.Create;
    try
      AddTableDesc(FormatOptions, FieldDefs, FTable, iFldId, oPath);
      if iFldId - 1 < Length(FColumns) then
        SetLength(FColumns, iFldId - 1);
    finally
      FDFree(oPath);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.RenewFieldDesc(AColumn: TFDDatSColumn; var AFieldId: Integer): Boolean;
var
  oChildTab: TFDDatSTable;
begin
  Result := (AFieldID - 1 < Length(FColumns)) and
            (FColumns[AFieldID - 1].FColumnIndex = AColumn.Index);
  if Result then begin
    FColumns[AFieldID - 1].FColumn := AColumn;
    Inc(AFieldID);
    if AColumn.DataType in [dtRowRef, dtArrayRef] then begin
      oChildTab := AColumn.NestedTable;
      if oChildTab <> nil then
        Result := RenewTableDesc(oChildTab, AFieldID);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.RenewTableDesc(ATable: TFDDatSTable; var AFieldId: Integer): Boolean;
var
  i: Integer;
  oCol: TFDDatSColumn;
begin
  Result := True;
  for i := 0 to ATable.Columns.Count - 1 do begin
    oCol := ATable.Columns.ItemsI[i];
    if not (caInternal in oCol.Attributes) then
      if not RenewFieldDesc(oCol, AFieldId) then begin
        Result := False;
        Exit;
      end;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.RenewColumnMap: Boolean;
var
  iFldId: Integer;
begin
  iFldId := 1;
  Result := RenewTableDesc(FTable, iFldId);
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.GetFieldClass(FieldType: TFieldType): TFieldClass;
begin
  case FieldType of
  ftFmtMemo:
    Result := TWideMemoField;
  ftDBaseOle:
    Result := TFDXMLField;
  ftAutoInc:
    Result := TFDAutoIncField;
  ftOraInterval,
  ftParadoxOle:
    Result := TFDSQLTimeIntervalField;
  else
    Result := inherited GetFieldClass(FieldType);
  end;
end;

{-------------------------------------------------------------------------------}
{ Record Functions }

function TFDDataSet.CalcBookmarkSize: LongWord;
begin
  Result := SizeOf(TFDBookmarkData);
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.InitBufferPointers;
begin
  BookmarkSize := CalcBookmarkSize;
  FBufferSize := LongWord(CalcFieldsSize + SizeOf(TFDRecInfo));
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.GetRecordSize: Word;
begin
  ASSERT(FTable.Columns.DataOffsets[FTable.Columns.Count] <= $FFFF);
  Result := Word(FTable.Columns.DataOffsets[FTable.Columns.Count]);
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.AllocRecBuf: TRecBuf;
begin
  Result := TRecBuf(AllocRecordBuffer);
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.FreeRecBuf(var Buffer: TRecBuf);
begin
  FreeRecordBuffer(TRecordBuffer(Buffer));
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.AllocRecordBuffer: TRecordBuffer;
begin
  Result := AllocMem(FBufferSize);
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.FreeRecordBuffer(var Buffer: TRecordBuffer);
begin
  FreeMem(Buffer);
  Buffer := nil;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.ClearCalcFields(Buffer: TRecBuf);
begin
  FillChar(TRecordBuffer(Buffer)^, CalcFieldsSize, 0);
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.RefreshInternalCalcFields(Buffer: TRecBuf);
begin
  CalculateFields(Buffer);
end;

{-------------------------------------------------------------------------------}
{$IFNDEF NEXTGEN}
procedure TFDDataSet.RefreshInternalCalcFields(Buffer: TRecordBuffer);
begin
  CalculateFields(NativeInt(Buffer));
end;
{$ENDIF !NEXTGEN}

{-------------------------------------------------------------------------------}
function TFDDataSet.GetRecInfo(ABuffer: TRecBuf): PFDRecInfo;
begin
  Result := PFDRecInfo(TRecordBuffer(ABuffer) + CalcFieldsSize);
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.GetRow(ABuffer: TRecBuf = C_NIL;
  AForceBufferRead: Boolean = False): TFDDatSRow;
var
  pInfo: PFDRecInfo;
begin
  if ABuffer = C_NIL then begin
    if FForceRecBuffer <> C_NIL then
      ABuffer := FForceRecBuffer
    else if not Active or IsEmpty then begin
      Result := nil;
      Exit;
    end
    else
      ABuffer := ActiveBuffer;
  end;
  pInfo := GetRecInfo(ABuffer);
  if (pInfo^.FBookmarkFlag in [bfBOF, bfEOF, bfInserted]) and
     not AForceBufferRead and (ABuffer <> FForceRecBuffer) and
     (FNewRow <> nil) then
    Result := FNewRow
  else
    Result := pInfo^.FRow;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.GetParentRow: TFDDatSRow;
var
  pRecBuf: TRecBuf;
  oCol: TFDDatSColumn;
  iInd: Integer;
  oRow: TFDDatSRow;
begin
  if FParentDataSet = nil then
    Result := nil
  else if (FParentDataSet.State <> dsInsert) and (FParentDataSet.FSourceView <> nil) and
          (FParentDataSet.FSourceView.Rows.Count > 0) then
    if FParentDataSet.Active then
      if FParentDataSet.GetActiveRecBuf(pRecBuf) and
         FParentDataSet.GetFieldColumn(pRecBuf, DataSetField.FieldNo, oCol, iInd,
                                       oRow, FParentDataSet.State in dsEditModes) then
        Result := oRow
      else
        Result := nil
    else
      Result := FParentDataSet.FSourceView.Rows[0]
  else
    Result := nil;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.RowState2UpdateStatus(ARowState: TFDDatSRowState): TUpdateStatus;
const
  rs2us: array [TFDDatSRowState] of TUpdateStatus = (usUnmodified, usUnmodified,
    usInserted, usDeleted, usModified, usUnmodified, usUnmodified, usUnmodified,
    usUnmodified, usUnmodified, usUnmodified, usUnmodified, usUnmodified,
    usUnmodified);
begin
  Result := rs2us[ARowState];
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.GetRecord(Buffer: TRecBuf; GetMode: TGetMode;
  DoCheck: Boolean): TGetResult;
var
  pInfo: PFDRecInfo;
begin
  Result := grOK;
  case GetMode of
  gmCurrent:
    begin
      while (FSourceView <> nil) and
            (FRecordIndex >= FSourceView.Rows.Count) and
            InternalFetchRows(False, True) do
        ;
      if FSourceView = nil then begin
        Result := grError;
        Exit;
      end;
    end;
  gmNext:
    begin
      while (FSourceView <> nil) and
            ((FRecordIndex + 1) >= FSourceView.Rows.Count) and
            InternalFetchRows(False, True) do
        ;
      if FSourceView = nil then begin
        Result := grError;
        Exit;
      end;
      if (FRecordIndex + 1) >= FSourceView.Rows.Count then
        FRecordIndex := FSourceView.Rows.Count
      else
        Inc(FRecordIndex);
    end;
  gmPrior:
    begin
      while (FSourceView <> nil) and
            ((FRecordIndex - 1) < 0) and
            InternalFetchRows(False, True, fdUp) do
        ;
      if FSourceView = nil then begin
        Result := grError;
        Exit;
      end;
      if FRecordIndex >= 0 then
        Dec(FRecordIndex);
    end;
  end;
  if FRecordIndex >= FSourceView.Rows.Count then
    Result := grEOF
  else if FRecordIndex < 0 then
    Result := grBOF
  else if Buffer <> C_NIL then begin
    pInfo := GetRecInfo(Buffer);
    pInfo^.FRow := FSourceView.Rows.ItemsI[FRecordIndex];
    pInfo^.FRowIndex := FRecordIndex;
    pInfo^.FBookmarkFlag := bfCurrent;
    GetCalcFields(Buffer);
    if IsUniDirectional and (Buffer = TempBuffer) then
      Move(Pointer(TempBuffer)^, Pointer(ActiveBuffer)^, FBufferSize);
  end;
end;

{-------------------------------------------------------------------------------}
{$IFNDEF NEXTGEN}
function TFDDataSet.GetRecord(Buffer: TRecordBuffer; GetMode: TGetMode;
  DoCheck: Boolean): TGetResult;
begin
  Result := GetRecord(TRecBuf(Buffer), GetMode, DoCheck);
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
function TFDDataSet.GetActiveRecBufRecordIndex(var AIndex: Integer): Boolean;
var
  pRecBuf: TRecBuf;
begin
  Result := GetActiveRecBuf(pRecBuf) and (GetBookmarkFlag(pRecBuf) = bfCurrent);
  if Result then
    AIndex := GetRowIndex(pRecBuf)
  else
    AIndex := -1;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.GetCurrentRecord(Buffer: TRecBuf): Boolean;
begin
  if not IsEmpty and (GetBookmarkFlag(ActiveBuffer) = bfCurrent) then begin
    UpdateCursorPos;
    try
      GetRecInfo(Buffer)^.FRow := FSourceView.Rows.ItemsI[FRecordIndex];
      Result := True;
    except
      Result := False;
    end;
  end
  else
    Result := False;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.GetRecordCount: Integer;

  procedure UpdateParentCursorPos;
  begin
    if (FParentDataSet <> nil) and (FParentDataSet.State <> dsInsert) then
      FParentDataSet.UpdateCursorPos;
  end;

begin
  Result := 0;
  if not (State in [dsInactive, dsOpening]) then
    case FetchOptions.RecordCountMode of
    cmVisible:
      begin
        UpdateParentCursorPos;
        Result := FSourceView.Rows.Count;
      end;
    cmFetched:
      begin
        UpdateParentCursorPos;
        Result := FUnidirRecsPurged + FTable.Rows.Count;
      end;
    cmTotal:
      begin
        if FRecordCount = -1 then begin
          UpdateParentCursorPos;
          if (FParentDataSet <> nil) and (FTable.Manager <> nil) or
             (FRangeFrom <> nil) or (FRangeTo <> nil) or
             Filtered and ((Filter <> '') or Assigned(OnFilterRecord)) or
             not (rtUnmodified in FFilterChanges) then begin
            CheckFetchedAll;
            FRecordCount := FSourceView.Rows.Count;
          end
          else
            UpdateRecordCount;
        end;
        Result := FRecordCount;
      end;
    end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.UpdateRecordCount;
begin
  CheckFetchedAll;
  FRecordCount := FSourceView.Rows.Count;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.GetRowIndex(ABuffer: TRecBuf = C_NIL): Integer;
begin
  if ABuffer = C_NIL then
    if not Active or IsEmpty then
      // none
    else if State = dsCalcFields then
      ABuffer := CalcBuffer
    else
      ABuffer := ActiveBuffer;
  if ABuffer = C_NIL then
    Result := -1
  else
    Result := GetRecInfo(ABuffer)^.FRowIndex;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.GetRecNo: Integer;
begin
  if State = dsInsert then
    Result := -1
  else
    Result := GetRowIndex() + FUnidirRecsPurged + 1;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.InternalSetRecNo(AValue: Integer);
begin
  Dec(AValue, FUnidirRecsPurged + 1);
  if AValue < 0 then
    FRecordIndex := 0
  else begin
    while (AValue >= FSourceView.Rows.Count) and
          InternalFetchRows(False, True) do
      ;
    if AValue >= FSourceView.Rows.Count then
      FRecordIndex := FSourceView.Rows.Count - 1
    else
      FRecordIndex := AValue;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.SetRecNo(AValue: Integer);
begin
  CheckBrowseMode;
  if (AValue <> RecNo) or
     (Bof and (AValue = 1)) or (Eof and (AValue = RecordCount)) and
     (dfNoRecNoCmp in FFlags) then begin
    DoBeforeScroll;
    InternalSetRecNo(AValue);
    Resync([rmCenter]);
    DoAfterScroll;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.GetActiveRecBuf(var RecBuf: TRecBuf): Boolean;
begin
  if FForceRecBuffer <> C_NIL then
    RecBuf := FForceRecBuffer
  else if State = dsBrowse then
    if IsEmpty then
      RecBuf := C_NIL
    else
      RecBuf := ActiveBuffer
  else
    case State of
      dsBlockRead, dsNewValue, dsOldValue, dsCurValue:
        if IsEmpty then
          RecBuf := C_NIL
        else
          RecBuf := ActiveBuffer;
      dsEdit, dsInsert:
        RecBuf := ActiveBuffer;
      dsSetKey:
        RecBuf := FKeyBuffer^.FRecBuff;
      dsCalcFields:
        RecBuf := CalcBuffer;
      dsFilter:
        RecBuf := TempBuffer;
    else
      RecBuf := C_NIL;
    end;
  Result := RecBuf <> C_NIL;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.BeginForceRow(ARow: TFDDatSRow; AReadWrite, AWithCalcFields: Boolean);
var
  pInfo: PFDRecInfo;
begin
  FForceRecBuffer := AllocRecBuf;
  pInfo := GetRecInfo(FForceRecBuffer);
  pInfo^.FRow := ARow;
  pInfo^.FRowIndex := -1;
  pInfo^.FBookmarkFlag := bfBOF;
  if AReadWrite then
    ARow.BeginForceWrite;
  if AWithCalcFields then
    GetCalcFields(FForceRecBuffer);
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.EndForceRow;
var
  pInfo: PFDRecInfo;
begin
  pInfo := GetRecInfo(FForceRecBuffer);
  if pInfo^.FRow.RowState = rsForceWrite then
    pInfo^.FRow.EndForceWrite;
  FreeRecBuf(FForceRecBuffer);
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.IsForceRowMode: Boolean;
begin
  Result := FForceRecBuffer <> C_NIL;
end;

{-------------------------------------------------------------------------------}
{ Field get / set data }

function TFDDataSet.GetRowVersion: TFDDatSRowVersion;
begin
  if State = dsNewValue then
    Result := rvProposed
  else if State = dsOldValue then
    Result := rvOriginal
  else
    Result := rvDefault;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.GetFieldColumn(ARecBuff: TRecBuf; AFieldNo: Integer;
  var AColumn: TFDDatSColumn; var AColumnIndex: Integer;
  var ARow: TFDDatSRow; AInitNested: Boolean): Boolean;
var
  oColMap: TFDColMapItem;
  i: Integer;
  prevRow: TFDDatSRow;

  function CheckNestedRow: Boolean;
  begin
    Result := True;
    if ARow = nil then
      if AInitNested and (prevRow <> nil) then begin
        ARow := AColumn.Table.NewRow(True);
        ARow.ParentRow := prevRow;
        if prevRow.RowState in [rsInserted, rsModified, rsUnchanged] then
          AColumn.Table.Rows.Add(ARow);
      end
      else
        Result := False;
  end;

begin
  oColMap := TFDColMapItem(FColumns[AFieldNo - 1]);
  if oColMap = nil then
    Result := False
  else begin
    ARow := GetRow(ARecBuff);
    AColumn := oColMap.FColumn;
    AColumnIndex := oColMap.FColumnIndex;
    prevRow := nil;
    if oColMap.FPath <> nil then
      for i := 0 to Length(oColMap.FPath) - 1 do begin
        if not CheckNestedRow then
          Break;
        prevRow := ARow;
        ARow := ARow.NestedRow[oColMap.FPath[i]];
      end;
    Result := CheckNestedRow;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.GetFieldColumn(AField: TField): TFDDatSColumn;
var
  iFieldNo: Integer;
begin
  if FLastField = AField then begin
    Result := FLastColumn;
    Exit;
  end;
  iFieldNo := AField.FieldNo;
  if iFieldNo = 0 then
    iFieldNo := FieldDefList.FieldByName(AField.FieldName).FieldNo;
  Result := TFDColMapItem(FColumns[iFieldNo - 1]).FColumn;
  FLastColumn := Result;
  FLastField := AField;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.GetColumnField(AColumn: TFDDatSColumn): TField;
var
  i: Integer;
begin
  if FLastColumn = AColumn then begin
    Result := FLastField;
    Exit;
  end;
  Result := nil;
  for i := 0 to Length(FColumns) - 1 do
    if TFDColMapItem(FColumns[i]).FColumn = AColumn then begin
      if (i < Fields.Count) and (Fields[i].FieldNo = i + 1) then
        Result := Fields[i]
      else
        Result := Fields.FieldByNumber(i + 1);
      Break;
    end;
  FLastColumn := AColumn;
  FLastField := Result;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.GetFieldData(AFieldNo: Integer; var ABuffer: TValueBuffer): Boolean;
var
  pRecBuf: TRecBuf;
  oColumn: TFDDatSColumn;
  iColIndex: Integer;
  oRow: TFDDatSRow;
  pData: Pointer;
  iDataLen: LongWord;
  oRows: TFDDatSNestedRowList;

  function AdjustSize(ADataLen: Integer; AFieldNo: Integer): Integer;
  var
    oFld: TField;
  begin
    Result := ADataLen;
    if lcPersistent in Fields.LifeCycles then begin
      oFld := FieldByNumber(AFieldNo);
      if (oFld <> nil) and (oFld.LifeCycle = lcPersistent) and (ADataLen > oFld.Size) then
        Result := oFld.Size;
    end;
  end;

  procedure ProcessGUID(ApGUID: PGUID; ABuffer: Pointer);
  var
    s: {$IFDEF NEXTGEN} String {$ELSE} AnsiString {$ENDIF} ;
  begin
  {$IFDEF NEXTGEN}
    s := GUIDToString(ApGUID^);
    FEncoder.Encode(PChar(s), Length(s), ABuffer, ecUTF16, ecANSI);
  {$ELSE}
    s := AnsiString(GUIDToString(ApGUID^));
    System.AnsiStrings.StrCopy(PAnsiChar(ABuffer), PAnsiChar(s));
  {$ENDIF}
  end;

  procedure ProcessBCD(ApBCD: PBcd; ABuffer: Pointer);
  begin
    if (ApBCD^.Precision > MaxFMTBcdDigits) and FormatOptions.DataSnapCompatibility then
      NormalizeBcd(ApBCD^, PBcd(ABuffer)^, MaxFMTBcdDigits, ApBCD^.SignSpecialPlaces and 63)
    else
      PBcd(ABuffer)^ := ApBCD^;
  end;

  function ProcessAnsiString(AData: Pointer; ADataLen: Integer; ABuffer: Pointer): Boolean;
  begin
    if (caFixedLen in oColumn.Attributes) and (ADataLen > 0) and
       (PFDAnsiString(AData)[ADataLen - 1] = TFDAnsiChar(' ')) and FormatOptions.StrsTrim then
      repeat
        Dec(ADataLen);
      until (ADataLen = 0) or (PFDAnsiString(AData)[ADataLen - 1] <> TFDAnsiChar(' '));
    if (ADataLen = 0) and FormatOptions.StrsEmpty2Null then
      Result := False
    else begin
      Result := True;
      Move(PFDAnsiString(AData)^, PFDAnsiString(ABuffer)^, ADataLen * SizeOf(TFDAnsiChar));
      (PFDAnsiString(ABuffer) + ADataLen * SizeOf(TFDAnsiChar))^ := TFDAnsiChar(#0);
    end;
  end;

  function ProcessWideString(AData: Pointer; ADataLen: Integer; ABuffer: Pointer): Boolean;
  var
    p: PByte;
  begin
    if (caFixedLen in oColumn.Attributes) and (ADataLen > 0) and
       (PWideChar(AData)[ADataLen - 1] = ' ') and FormatOptions.StrsTrim then
      repeat
        Dec(ADataLen);
      until (ADataLen = 0) or (PWideChar(AData)[ADataLen - 1] <> ' ');
    if (ADataLen = 0) and FormatOptions.StrsEmpty2Null then
      Result := False
    else begin
      Result := True;
      Move(PWideChar(AData)^, PWideChar(ABuffer)^, ADataLen * SizeOf(WideChar));
      p := PByte(ABuffer) + ADataLen * SizeOf(WideChar);
      p^ := 0;
      (p + 1)^ := 0;
    end;
  end;

  function ProcessByteString(AData: Pointer; ADataLen: Integer; ABuffer: Pointer): Boolean;
  begin
    Result := True;
    if caFixedLen in oColumn.Attributes then begin
      Move(PByte(AData)^, PByte(ABuffer)^, ADataLen);
      if Integer(oColumn.Size) > ADataLen then
        FillChar((PByte(ABuffer) + ADataLen)^, Integer(oColumn.Size) - ADataLen, 0);
    end
    else begin
      if (ADataLen = 0) and FormatOptions.StrsEmpty2Null then
        Result := False
      else begin
        if ADataLen > High(Word) then
          FDException(Self, [S_FD_LDatS], er_FD_VarLenDataMismatch, [oColumn.Name, ADataLen, High(Word)]);
        PWord(ABuffer)^ := Word(ADataLen);
        Move(PByte(AData)^, (PByte(ABuffer) + SizeOf(Word))^, ADataLen);
      end;
    end;
  end;

begin
  Result := GetActiveRecBuf(pRecBuf);
  if not Result then
    Exit;
  oColumn := nil;
  iColIndex := -1;
  oRow := nil;
  if not GetFieldColumn(pRecBuf, AFieldNo, oColumn, iColIndex, oRow) then begin
    Result := False;
    Exit;
  end;
  case oColumn.DataType of
  dtRowSetRef, dtCursorRef:
    begin
      oRows := oRow.NestedRows[iColIndex];
      Result := (oRows <> nil) and (oRows.Count > 0);
    end;
  dtRowRef, dtArrayRef:
    Result := (oRow.NestedRow[iColIndex] <> nil);
  else
    pData := nil;
    iDataLen := 0;
    Result := oRow.GetData(iColIndex, GetRowVersion, pData, 0, iDataLen, False);
    if Result and (ABuffer <> nil) then
      case oColumn.DataType of
      dtBoolean:          PWordBool(ABuffer)^ := PWordBool(pData)^;
      dtSByte:            PShortInt(ABuffer)^ := PShortInt(pData)^;
      dtByte:             PByte(ABuffer)^ := PByte(pData)^;
      dtInt16:            PSmallInt(ABuffer)^ := PSmallInt(pData)^;
      dtUInt16:           PWord(ABuffer)^ := PWord(pData)^;
      dtInt32:            PLongInt(ABuffer)^ := PInteger(pData)^;
      dtUInt32:           PLongWord(ABuffer)^ := PCardinal(pData)^;
      dtInt64:            PLargeInt(ABuffer)^ := PInt64(pData)^;
      dtUInt64:           PULargeInt(ABuffer)^ := PUInt64(pData)^;
      dtSingle:           PSingle(ABuffer)^ := PSingle(pData)^;
      dtDouble:           PDouble(ABuffer)^ := PDouble(pData)^;
      dtExtended:         PExtended(ABuffer)^ := PExtended(pData)^;
      dtCurrency:         PDouble(ABuffer)^ := PCurrency(pData)^;
      dtBCD:              ProcessBCD(PBcd(pData), ABuffer);
      dtFmtBCD:           ProcessBCD(PBcd(pData), ABuffer);
      dtDateTimeStamp:    PSQLTimeStamp(ABuffer)^ := PSQLTimeStamp(pData)^;
      dtTimeIntervalFull,
      dtTimeIntervalYM,
      dtTimeIntervalDS:   PFDSQLTimeInterval(ABuffer)^ := PFDSQLTimeInterval(pData)^;
      dtDateTime:         PDateTimeRec(ABuffer)^.DateTime := PDateTimeRec(pData)^.DateTime;
      dtTime:             PDateTimeRec(ABuffer)^.Time := PInteger(pData)^;
      dtDate:             PDateTimeRec(ABuffer)^.Date := PInteger(pData)^;
      dtAnsiString:       Result := ProcessAnsiString(pData, AdjustSize(iDataLen, AFieldNo), ABuffer);
      dtWideString:       Result := ProcessWideString(pData, AdjustSize(iDataLen, AFieldNo), ABuffer);
      dtByteString:       Result := ProcessByteString(pData, AdjustSize(iDataLen, AFieldNo), ABuffer);
      dtGUID:             ProcessGUID(PGUID(pData), ABuffer);
      dtObject:           PUnknown(ABuffer)^ := PUnknown(pData)^;
      end;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.GetFieldData(AField: TField;
  var ABuffer: TValueBuffer): Boolean;
var
  pRecBuf: TRecBuf;
  pBuff: TRecordBuffer;
begin
  if AField.FieldNo > 0 then
    Result := GetFieldData(AField.FieldNo, ABuffer)
  else begin
    Result := GetActiveRecBuf(pRecBuf);
    if Result and (State in [dsBrowse, dsEdit, dsInsert, dsCalcFields, dsBlockRead, dsFilter]) then begin
      pBuff := TRecordBuffer(pRecBuf);
      Inc(pBuff, AField.Offset);
      Result := Boolean(pBuff[0]);
      if Result and (ABuffer <> nil) then
        if AField.DataType = ftBCD then
          CurrToBCD(PCurrency(pBuff + 1)^, PBcd(ABuffer)^)
        else if AField.DataSize > 0 then
          Move(pBuff[1], PByte(ABuffer)^, AField.DataSize);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.GetStateFieldValue(AState: TDataSetState; AField: TField): Variant;
var
  ePrevState: TDataSetState;
  lPrevModified: Boolean;
begin
  if (AState in [dsOldValue, dsCurValue]) and AField.Validating then begin
    UpdateCursorPos;
    lPrevModified := Modified;
    ePrevState := SetTempState(AState);
    SetValidatingField(False, AField);
    try
      Result := AField.Value;
    finally
      SetValidatingField(True, AField);
      RestoreState(ePrevState);
      SetModified(lPrevModified);
    end;
  end
  else
    Result := inherited GetStateFieldValue(AState, AField);
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.SetFieldData(AField: TField; ABuffer: TValueBuffer);
var
  pRecBuf: TRecBuf;
  pBuff: TRecordBuffer;
  oColumn: TFDDatSColumn;
  oRow: TFDDatSRow;
  iLen, iFieldNo: Integer;
  pData: Pointer;
  crVal: Currency;
  iColIndex: Integer;
  rGUID: TGUID;
  lEndEdit: Boolean;
  lCheckUpdatable: Boolean;

  procedure NotEditingError;
  begin
    DatabaseError(SNotEditing, Self);
  end;

  procedure FieldROError;
  begin
    DatabaseErrorFmt(SFieldReadOnly, [AField.DisplayName]);
  end;

  procedure NotIndexFieldError;
  begin
    DatabaseErrorFmt(SNotIndexField, [AField.DisplayName]);
  end;

  function ProcessGUID(ABuff: TValueBuffer; var AGuid: TGUID): Boolean;
  var
    iLen: Integer;
    s: {$IFDEF NEXTGEN} String {$ELSE} AnsiString {$ENDIF};
  begin
{$IFDEF NEXTGEN}
    iLen := FDAnsiStrLen(PFDAnsiString(ABuff));
    s := FEncoder.Decode(ABuff, iLen, ecANSI);
{$ELSE}
    iLen := System.AnsiStrings.StrLen(PAnsiChar(ABuff));
    SetString(s, PAnsiChar(ABuff), iLen);
{$ENDIF}
    if iLen = 0 then
      Result := False
    else begin
      if (s[1] <> '{') and (s[Length(s)] <> '}') then
        s := '{' + s + '}';
      AGUID := StringToGUID(String(s));
      Result := True;
    end;
  end;

begin
  lCheckUpdatable := not IsForceRowMode and UpdateOptions.CheckUpdatable;
  if lCheckUpdatable then begin
    if not (State in dsWriteModes) then
      NotEditingError;
    if (State = dsSetKey) and not AField.IsIndexField then
      NotIndexFieldError;
  end;
  iFieldNo := AField.FieldNo;
  GetActiveRecBuf(pRecBuf);
  pBuff := TRecordBuffer(pRecBuf);
  if iFieldNo > 0 then begin
    if lCheckUpdatable then begin
      if (State = dsCalcFields) and (AField.FieldKind <> fkInternalCalc) then
        NotEditingError;
      if AField.ReadOnly and not (State in [dsSetKey, dsFilter]) and UpdateOptions.CheckReadOnly then
        FieldROError;
      AField.Validate(ABuffer);
    end;
    oColumn := nil;
    iColIndex := -1;
    oRow := nil;
    if GetFieldColumn(pRecBuf, iFieldNo, oColumn, iColIndex, oRow, True) then begin
      if oRow.RowState = rsDeleted then
        Exit;
      iLen := 0;
      pData := nil;
      if ABuffer <> nil then
        case oColumn.DataType of
        dtCurrency:
          begin
            crVal := PDouble(ABuffer)^;
            pData := @crVal;
          end;
        dtAnsiString:
          begin
            iLen := FDAnsiStrLen(PFDAnsiString(ABuffer));
            if (caFixedLen in oColumn.Attributes) and FormatOptions.StrsTrim then
              while (iLen > 0) and (PFDAnsiString(ABuffer)[iLen - 1] = TFDAnsiChar(' ')) do
                Dec(iLen);
            if (LongWord(iLen) > oColumn.Size) and FormatOptions.StrsTrim2Len then
              iLen := oColumn.Size;
            if (iLen = 0) and FormatOptions.StrsEmpty2Null then
              pData := nil
            else
              pData := ABuffer;
          end;
        dtWideString:
          begin
            iLen := StrLen(PWideChar(ABuffer));
            if (caFixedLen in oColumn.Attributes) and FormatOptions.StrsTrim then
              while (iLen > 0) and (PWideChar(ABuffer)[iLen - 1] = ' ') do
                Dec(iLen);
            if (LongWord(iLen) > oColumn.Size) and FormatOptions.StrsTrim2Len then
              iLen := oColumn.Size;
            if (iLen = 0) and FormatOptions.StrsEmpty2Null then
              pData := nil
            else
              pData := ABuffer;
          end;
        dtByteString:
          begin
            if caFixedLen in oColumn.Attributes then begin
              pData := ABuffer;
              iLen := oColumn.Size;
            end
            else begin
              iLen := PWord(ABuffer)^;
              if (LongWord(iLen) > oColumn.Size) and FormatOptions.StrsTrim2Len then
                iLen := oColumn.Size;
              if (iLen = 0) and FormatOptions.StrsEmpty2Null then
                pData := nil
              else
                pData := PByte(ABuffer) + SizeOf(Word);
            end;
          end;
        dtGUID:
          begin
            pData := @rGUID;
            if not ProcessGUID(ABuffer, rGUID) then
              if FormatOptions.StrsEmpty2Null then
                pData := nil
              else
                FillChar(rGUID, SizeOf(TGUID), 0);
          end;
        dtBoolean,
        dtSByte, dtByte,
        dtInt16, dtInt64,
        dtUInt16, dtUInt64,
        dtInt32, dtUInt32,
        dtSingle, dtDouble, dtExtended,
        dtBCD, dtFmtBCD,
        dtDateTime, dtTime, dtDate, dtDateTimeStamp,
        dtTimeIntervalFull, dtTimeIntervalYM, dtTimeIntervalDS,
        dtObject:
          pData := ABuffer;
        end;
      if oRow.RowState in [rsInserted, rsModified, rsUnchanged] then begin
        lEndEdit := (State in [dsCalcFields, dsInternalCalc, dsInactive]) or
          (State = dsBrowse) and (AField.FieldKind = fkInternalCalc);
        oRow.BeginEdit;
      end
      else
        lEndEdit := False;
      oRow.SetData(iColIndex, pData, iLen);
      if lEndEdit then
        oRow.EndEdit(True);
      if State = dsSetKey then begin
        iFieldNo := SourceView.SortingMechanism.SortColumnList.IndexOfName(AField.FieldName);
        if (iFieldNo >= 0) and (iFieldNo + 1 > FKeyBuffer^.FAssignedFieldCount) then
          FKeyBuffer^.FAssignedFieldCount := iFieldNo + 1;
      end;
    end;
  end
  else begin {fkCalculated, fkLookup}
    Inc(pBuff, AField.Offset);
    Boolean(pBuff[0]) := LongBool(ABuffer <> nil);
    if Boolean(pBuff[0]) then
      if AField.DataType = ftBCD then begin
{$IFDEF CPUARM}
        BCDToCurr(PBcd(ABuffer)^, crVal);
        PCurrency(pBuff + 1)^ := crVal;
{$ELSE}
        BCDToCurr(PBcd(ABuffer)^, PCurrency(pBuff + 1)^);
{$ENDIF}
      end
      else begin
        iLen := Length(ABuffer);
        if iLen > AField.DataSize then
          iLen := AField.DataSize;
        if iLen > 0 then
          Move(PByte(ABuffer)^, pBuff[1], iLen);
      end;
  end;
  if not IsForceRowMode and not (State in [dsCalcFields, dsFilter, dsNewValue]) then
    DataEvent(deFieldChange, NativeInt(AField));
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.CreateBlobStream(Field: TField; Mode: TBlobStreamMode): TStream;
begin
  Result := TFDBlobStream.Create(Field, Mode);
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.CreateXMLStream: TStream;
var
  oXMLChunk: TStream;
begin
  DisableControls;
  try
    Close;
    Open;
    Result := TMemoryStream.Create;
    try
      while not Eof do begin
        oXMLChunk := CreateBlobStream(Fields[0], bmRead);
        try
          Result.CopyFrom(oXMLChunk, 0);
        finally
          FDFree(oXMLChunk);
        end;
        Next;
      end;
      Result.Position := 0;
    except
      FDFree(Result);
      raise;
    end;
  finally
    EnableControls;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.CloseBlob(Field: TField);
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
{ Fetching }

procedure TFDDataSet.CheckBidirectional;
  procedure ErrorUnidir;
  begin
    FDException(Self, [S_FD_LComp, S_FD_LComp_PDS], er_FD_DSCantUnidir, [GetDisplayName]);
  end;
begin
  if IsUnidirectional then
    ErrorUnidir;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.DoFetch(ATable: TFDDatSTable; AAll: Boolean;
  ADirection: TFDFetchDirection = fdDown): Integer;
begin
  // nothing more
  Result := 0;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.DoFetch(ARow: TFDDatSRow; AColumn: Integer;
  ARowOptions: TFDPhysFillRowOptions): Boolean;
begin
  // nothing more
  Result := False;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.DoPurge(AView: TFDDatSView; ADirection:TFDFetchDirection = fdDown): Integer;
begin
  // nothing more
  Result := 0;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.DoAdjustSortFields(const AFields, AExpression: String;
  var AIndexOptions: TFDSortOptions): String;
begin
  // nothing more
  if AFields <> '' then
    Result := AFields
  else
    Result := AExpression;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.DoSortOrderChanging;
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.DoSortOrderChanged;
begin
  ResetMasterRelation;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.DoBeforeGetRecords;
begin
  if Assigned(FBeforeGetRecords) then
    FBeforeGetRecords(Self);
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.DoAfterGetRecords(AFromRecord, AToRecord: Integer);
var
  i: Integer;
begin
  if Assigned(FAfterGetRecords) then
    FAfterGetRecords(Self);
  if Assigned(FAfterGetRecord) then
    for i := AFromRecord to AToRecord do begin
      BeginForceRow(FTable.Rows[i], False, True);
      try
        try
          AfterGetRecord(Self);
        except
          InternalHandleException;
        end;
      finally
        if IsForceRowMode then
          EndForceRow;
      end;
    end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.DoAfterGetRecords2;
begin
  DoAfterGetRecords(0, -1);
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.DoBeforeRowRequest;
begin
  if Assigned(FBeforeRowRequest) then
    FBeforeRowRequest(Self);
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.DoAfterRowRequest;
begin
  if Assigned(FAfterRowRequest) then
    FAfterRowRequest(Self);
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.DoBeforeScroll;
begin
  inherited DoBeforeScroll;
  if not (fiBlobs in FetchOptions.Cache) and (State in [dsBrowse, dsBlockRead]) then
    ClearBlobs;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.CheckFetchedAll;
begin
  CheckBidirectional;
  if FClientCursor then
    InternalFetchRows(True, True);
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.InternalFetchRows(AAll, AOnDemand: Boolean; ADirection: TFDFetchDirection = fdDown): Boolean;
var
  lUnidir, lFetched: Boolean;
  iPurged, iFetched, iLastIndex: Integer;
  iFromRec, iToRec: Integer;
begin
  Result := False;
  if (ADirection = fdUp) and not FClientCursor then
    FSourceEOF := False;
  if ((FParentDataSet <> nil) or not SourceEOF) and
     (not AOnDemand or (FetchOptions.Mode in [fmOnDemand, fmAll, fmExactRecsMax])) then begin
    if FParentDataSet <> nil then
      Result := FParentDataSet.InternalFetchNested(GetParentRow, FTable, [foDetails])
    else if not SourceEOF then begin
      lUnidir := IsUnidirectional;
      StartWait;
      try
        if DoIsSourceAsync then
          TFDThread.Synchronize(DoBeforeGetRecords)
        else
          DoBeforeGetRecords;
        iFromRec := FTable.Rows.Count;
        repeat
          if lUnidir then begin
            Inc(FUnidirRecsPurged, FTable.Rows.Count);
            FTable.Clear;
            FRecordIndex := -1;
            iFromRec := 0;
          end;
          iLastIndex := FRecordIndex;
          iFetched := DoFetch(FTable, AAll and not lUnidir, ADirection);
          if (FSourceView <> nil) and (FRecordIndex < FSourceView.Rows.Count) and
             (FetchOptions.Mode <> fmAll) then
            // maintain specified number of records
            iPurged := DoPurge(FSourceView, ADirection)
          else
            // if FRecordIndex point to last record purging is not needed
            iPurged := 0;
          case ADirection of
          fdUp:
            begin
              FRecordIndex := FRecordIndex + iFetched;
              if FRecordIndex > FSourceView.Rows.Count then
                FRecordIndex := FSourceView.Rows.Count;
            end;
          fdDown:
            begin
              if (FRecordIndex - iPurged < 0) and (iLastIndex <> -1) then
                // only for table make one record 1
                FRecordIndex := 0
              else
                Dec(FRecordIndex, iPurged);
              if iFromRec - iPurged < 0 then
                iFromRec := 0
              else
                Dec(iFromRec, iPurged);
            end;
          end;
          lFetched := (iFetched > 0);
          Result := Result or lFetched;
        until not AAll or not lFetched or (FTable = nil);
        if FTable <> nil then begin
          if not lFetched and (ADirection = fdDown) then
            FSourceEOF := True;
          if lUnidir and (FSourceView.Rows.Count = 0) then
            ClearBuffers;
          iToRec := FTable.Rows.Count - 1;
          if DoIsSourceAsync then
            TFDThread.Synchronize(DoAfterGetRecords2)
          else
            DoAfterGetRecords(iFromRec, iToRec);
        end;
      finally
        StopWait;
      end;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.GetNextPacket: Integer;
begin
  CheckActive;
  if SourceEOF then
    Result := 0
  else begin
    UpdateCursorPos;
    Result := FUnidirRecsPurged + FTable.Rows.Count;
    if IsLinkedDetail then
      CheckDetailRecords(False)
    else
      InternalFetchRows(False, False);
    Result := FUnidirRecsPurged + FTable.Rows.Count - Result;
    Resync([]);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.FetchNext: Integer;
begin
  Result := GetNextPacket;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.FetchAgain;
begin
  CheckActive;
  FSourceEOF := False;
  FUnidirRecsPurged := 0;
  FRecordCount := -1;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.FetchAll;
begin
  CheckBrowseMode;
  UpdateCursorPos;
  if InternalFetchRows(True, False) then
    Resync([]);
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.InternalFetchNested(ARow: TFDDatSRow; ANestedTable: TFDDatSTable;
  ARowOptions: TFDPhysFillRowOptions): Boolean;
var
  iPrevRowCount: Integer;

  procedure CheckNeedFetch(ACheckOpt: TFDPhysFillRowOption;
    var ARowOptions: TFDPhysFillRowOptions; ADataTypes: TFDDataTypes;
    AAttributes: TFDDataAttributes);
  var
    lAllFetched: Boolean;
    i: Integer;
    oCol: TFDDatSColumn;
  begin
    if ACheckOpt in ARowOptions then begin
      lAllFetched := True;
      for i := 0 to FTable.Columns.Count - 1 do begin
        oCol := FTable.Columns.ItemsI[i];
        if ((oCol.DataType in ADataTypes) or (oCol.Attributes * AAttributes <> [])) and
           not ARow.Fetched[i] then begin
          lAllFetched := False;
          Break;
        end;
      end;
      if lAllFetched then
        Exclude(ARowOptions, ACheckOpt);
    end;
  end;

begin
  UpdateCursorPos;
  Result := False;
  if (ANestedTable <> nil) and (ARow = nil) then
    Exit;
  if ARow = nil then
    ARow := GetRow;
  if (ARow = nil) or (ARow.RowState in [rsInserted, rsDetached]) then
    Exit;
  if FParentDataSet <> nil then begin
    if ANestedTable = nil then
      Result := FParentDataSet.InternalFetchNested(GetParentRow, FTable, ARowOptions + [foDetails])
    else begin
      if not ARow.Fetched[ANestedTable.Columns.ParentCol] then begin
        iPrevRowCount := ANestedTable.Rows.Count;
        FParentDataSet.InternalFetchNested(GetParentRow, FTable, ARowOptions + [foDetails]);
        Result := ANestedTable.Rows.Count > iPrevRowCount;
      end;
    end;
  end
  else begin
    CheckOnline;
    DoBeforeRowRequest;
    if foClear in ARowOptions then
      ARow.RejectChanges;
    if ANestedTable = nil then begin
      // If there is foClear, then column values will be erased before fetching,
      // that is equivalent of the case when a column value was not fetched.
      if not (foClear in ARowOptions) then begin
        CheckNeedFetch(foBlobs, ARowOptions, [], [caBlobData]);
        CheckNeedFetch(foDetails, ARowOptions, [dtRowSetRef, dtCursorRef], []);
      end;
      if ARowOptions <> [] then begin
        StartWait;
        try
          Result := DoFetch(ARow, -1, ARowOptions);
        finally
          StopWait;
        end;
      end;
    end
    else begin
      if not ARow.Fetched[ANestedTable.Columns.ParentCol] then begin
        iPrevRowCount := ANestedTable.Rows.Count;
        StartWait;
        try
          DoFetch(ARow, ANestedTable.Columns.ParentCol, ARowOptions);
        finally
          StopWait;
        end;
        Result := ANestedTable.Rows.Count > iPrevRowCount;
      end;
    end;
    DoAfterRowRequest;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.FetchDetails(ADataSetField: TDataSetField = nil);
var
  oDS: TFDDataSet;
  oTab: TFDDatSTable;
  oRow: TFDDatSRow;
begin
  if ADataSetField <> nil then begin
    oDS := ADataSetField.NestedDataSet as TFDDataSet;
    oTab := oDS.FTable;
    oRow := oDS.GetParentRow;
  end
  else begin
    oTab := nil;
    oRow := nil;
  end;
  if InternalFetchNested(oRow, oTab, [foDetails]) and not (dfOpenBlob in FFlags) then
    DataEvent(deDataSetChange, 0);
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.FetchBlobs;
begin
  CheckActive;
  if InternalFetchNested(nil, nil, [foBlobs]) and not (dfOpenBlob in FFlags) then
    DataEvent(deDataSetChange, 0);
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.InternalClearNested(ADataTypes: TFDDataTypes;
  AAttributes: TFDDataAttributes);
var
  i: Integer;
  oRow: TFDDatSRow;
  lEditing: Boolean;
  lErased: Boolean;
  lRefreshing: Boolean;
  oCol: TFDDatSColumn;
begin
  oRow := GetRow;
  if (oRow = nil) or (oRow.RowState = rsDestroying) then
    Exit;
  lRefreshing := (oRow.RowState = rsUnchanged);
  lEditing := not (oRow.RowState in [rsDetached, rsForceWrite]);
  lErased := False;
  for i := 0 to FTable.Columns.Count - 1 do begin
    oCol := FTable.Columns.ItemsI[i];
    if ((oCol.DataType in ADataTypes) or (oCol.Attributes * AAttributes <> [])) and
       oRow.Fetched[i] then begin
      if lEditing and not lErased then
        oRow.BeginEdit;
      oRow.SetData(i, nil, 0);
      oRow.Fetched[i] := False;
      lErased := True;
    end;
  end;
  if lErased and lEditing then begin
    oRow.EndEdit;
    if lRefreshing then
      oRow.AcceptChanges(False);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.ClearBlobs;
begin
  InternalClearNested([], [caBlobData]);
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.ClearDetails;
begin
  InternalClearNested([dtRowSetRef, dtCursorRef], []);
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.RefreshRecordBase(ARowOptions: TFDPhysFillRowOptions): Boolean;
begin
  CheckActive;
  Cancel;
  Result := InternalFetchNested(nil, nil, ARowOptions + FDGetFillRowOptions(GetFetchOptions));
  if Result then begin
    if not (dfOpenBlob in FFlags) then
      DataEvent(deDataSetChange, 0);
  end
  else
    Resync([]);
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.RefreshRecord(AClearRow: Boolean = True): Boolean;
var
  eOpts: TFDPhysFillRowOptions;
begin
  eOpts := [];
  if AClearRow then
    Include(eOpts, foClear);
  Result := RefreshRecordBase(eOpts);
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.RefreshUnknownRecord(const AValues: array of Variant;
  AReread: Boolean = True; ASetPos: Boolean = True);
var
  oRow: TFDDatSRow;
  iPos: Integer;
begin
  CheckActive;
  oRow := Table.NewRow(False);
  try
    oRow.BeginForceWrite;
    oRow.SetValues(AValues);
    oRow.EndForceWrite;
    Table.Rows.Add(oRow);
    oRow.AcceptChanges();
  except
    FDFree(oRow);
    raise;
  end;
  if AReread then begin
    BeginForceRow(oRow, False, True);
    try
      RefreshRecordBase([foClear, foUnkRec]);
    finally
      EndForceRow;
    end;
  end;
  if ASetPos then begin
    iPos := SourceView.IndexOf(oRow);
    if iPos <> -1 then
      RecNo := iPos + FUnidirRecsPurged + 1;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.DoAfterRefresh;
begin
  if Active then
    inherited DoAfterRefresh;
end;

{-------------------------------------------------------------------------------}
{ Data editing }

function TFDDataSet.GetCanModify: Boolean;
begin
  Result := ((DataSetField = nil) or DataSetField.CanModify) and
    (not UpdateOptions.CheckReadOnly or not UpdateOptions.ReadOnly);
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.GetCanRefresh: Boolean;
begin
  Result := not (UpdatesPending or (FDataLoadSave <> nil));
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.DoProcessUpdateRequest(ARequest: TFDUpdateRequest;
  AOptions: TFDUpdateRowOptions);
var
  oRow: TFDDatSRow;
  eAction: TFDErrorAction;
begin
  if UpdateOptions.CheckRequest(ARequest, AOptions, CachedUpdates) then begin
    oRow := GetRow(ActiveBuffer);
    eAction := eaApplied;
    DoUpdateRecordHandler(oRow, ARequest, AOptions, eAction);
    if eAction in [eaApplied, eaDefault] then
      case ARequest of
      arUnLock:
        if uoCancelUnlock in AOptions then
          oRow.RejectChanges
        else
          oRow.AcceptChanges;
      arInsert:
        oRow.AcceptChanges;
      end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.CheckInserting;
  procedure ErrorInsert;
  begin
    FDException(Self, [S_FD_LComp, S_FD_LComp_PDS], er_FD_DSCantInsert, [GetDisplayName]);
  end;
begin
  if not UpdateOptions.EnableInsert then
    ErrorInsert;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.CheckEditing;
  procedure ErrorEdit;
  begin
    FDException(Self, [S_FD_LComp, S_FD_LComp_PDS], er_FD_DSCantEdit, [GetDisplayName]);
  end;
begin
  if not UpdateOptions.EnableUpdate then
    ErrorEdit;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.CheckDeleting;
  procedure ErrorDelete;
  begin
    FDException(Self, [S_FD_LComp, S_FD_LComp_PDS], er_FD_DSCantDelete, [GetDisplayName]);
  end;
begin
  if not UpdateOptions.EnableDelete then
    ErrorDelete;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.InternalFirst;
begin
  if IsUniDirectional then
    FRecordIndex := 0
  else
    FRecordIndex := -1;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.InternalLast;
begin
  CheckFetchedAll;
  FRecordIndex := FSourceView.Rows.Count;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.InternalEdit;
begin
  StartWait;
  try
    ClearRecordIndex;
    DoProcessUpdateRequest(arLock, [uoImmediateUpd]);
    inherited InternalEdit;
  finally
    StopWait;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.InternalInsert;
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.DoBeforeInsert;
begin
  inherited DoBeforeInsert;
  CheckInserting;
  if (FParentDataSet <> nil) and (FParentDataSet.State = dsInsert) then
    FParentDataSet.Post;
  ClearRecordIndex;
  FRecordIndexToInsert := GetRowIndex();
  if FRecordIndexToInsert < 0 then
    FRecordIndexToInsert := 0;
  SetUpdateFieldAttributes;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.DoBeforeEdit;
begin
  CheckEditing;
  SetUpdateFieldAttributes;
  inherited DoBeforeEdit;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.DoBeforeDelete;
begin
  CheckDeleting;
  inherited DoBeforeDelete;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.UpdateRecordIndex;
begin
  if dfCalcFieldInIndex in FFlags then
    GetCalcFields(ActiveBuffer);
  FPrevRecordIndex := FRecordIndex;
  if FSourceView.LastUpdatePosition <> -1 then
    FRecordIndex := FSourceView.LastUpdatePosition;
  ClearRecordIndex;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.ClearRecordIndex;
begin
  FSourceView.LastUpdatePosition := -1;
  FSourceView.ProposedPosition := -1;
  FRecordIndexToInsert := -1;
  FPrevRecordIndex := -1;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.InternalPost;
var
  oRow: TFDDatSRow;
begin
  Include(FFlags, dfPostRow);
  StartWait;
  try
    if UpdateOptions.CheckRequired then
      inherited InternalPost;
    if State = dsEdit then begin
      oRow := GetRow;
      if ctInvars in Table.Columns.HasThings then
        oRow.EndEditNested;
      if oRow.RowState = rsEditing then begin
        FSourceView.ProposedPosition := FRecordIndex;
        oRow.EndEdit;
        UpdateRecordIndex;
      end;
      DoProcessUpdateRequest(arLock,   [uoImmediateUpd, uoDeferredLock]);
      DoProcessUpdateRequest(arUpdate, [uoImmediateUpd]);
      DoProcessUpdateRequest(arUnLock, [uoImmediateUpd]);
      // after posting update the record position may be changed in case of
      // IDENTITY / TRIGGER / etc
      UpdateRecordIndex;
    end
    else if State = dsInsert then
      InternalAddRecord(ActiveBuffer, GetBookmarkFlag(ActiveBuffer) = bfEOF);
  finally
    StopWait;
    Exclude(FFlags, dfPostRow);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.Post;
begin
  if State = dsSetKey then begin
    DataEvent(deUpdateRecord, 0);
    PostKeyBuffer(True);
  end
  else
    inherited Post;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.InternalDelete;
begin
  StartWait;
  Include(FFlags, dfDeleting);
  try
    ClearRecordIndex;
    DoProcessUpdateRequest(arLock, [uoImmediateUpd, uoOneMomLock]);
    FSourceView.ProposedPosition := FRecordIndex;
    GetRow.Delete;
    UpdateRecordIndex;
    try
      DoProcessUpdateRequest(arDelete, [uoImmediateUpd]);
    except
      on E: Exception do begin
        if not (E is EFDDBEngineException) or
           (EFDDBEngineException(E).Kind <> ekNoDataFound) then begin
          DoProcessUpdateRequest(arUnLock, [uoImmediateUpd, uoCancelUnlock]);
          raise;
        end;
      end;
    end;
    DoProcessUpdateRequest(arUnLock, [uoImmediateUpd, uoNoSrvRecord]);
  finally
    Exclude(FFlags, dfDeleting);
    StopWait;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.InternalRefresh;
var
  iLastRecNo, iNewRecNo, i: Integer;
  sKeyFields: String;
  vLastKeyValue: Variant;
  lRecIndSet: Boolean;
  oView: TFDDatSView;
begin
  CheckBrowseMode;
  if not CanRefresh then
    FDException(Self, [S_FD_LComp, S_FD_LComp_PDS], er_FD_DSRefreshError, [GetDisplayName]);

  if IsUniDirectional then begin
    iLastRecNo := GetRecNo;
    sKeyFields := '';
  end
  else if IsEmpty then begin
    iLastRecNo := 0;
    sKeyFields := '';
  end
  else begin
    iLastRecNo := GetRecNo;
    sKeyFields := PSGetKeyFields;
    if sKeyFields <> ''  then
      vLastKeyValue := FieldValues[sKeyFields];
  end;

  // remove temporary indexes to speedup refreshing
  if SourceView <> nil then
    for i := FTempIndexViews.Count - 1 downto 0 do begin
      oView := TFDDatSView(FTempIndexViews[i]);
      if (oView.Creator = vcDataSetTempIndex) and
         (SourceView <> oView) and
         (SourceView.SourceView <> oView) then begin
        oView.RemRef;
        FTempIndexViews.Delete(i);
      end;
    end;

  if IsLinked then begin
    DoClearBeforeRefetch;
    if FetchOptions.Mode in [fmOnDemand, fmAll, fmExactRecsMax] then
      CheckDetailRecords(True);
  end
  else begin
    DoCloseSource;
    DoOpenSource(True, False, False);
    if DoIsSourceOpen then begin
      FTable.Clear;
      FSourceEOF := False;
      FUnidirRecsPurged := 0;
      FRecordCount := -1;
    end
    else
      FTable.Views.Rebuild;
  end;

  iNewRecNo := -1;
  lRecIndSet := False;
  if sKeyFields <> '' then begin
    CheckFetchedAll;
    if LocateRecord(sKeyFields, vLastKeyValue, [], iNewRecNo) then begin
      FRecordIndex := iNewRecNo;
      lRecIndSet := True;
    end;
  end;
  if not lRecIndSet then
    InternalSetRecNo(iLastRecNo);
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.InternalCancel;
var
  oRow: TFDDatSRow;
  pInfo: PFDRecInfo;
begin
  if State = dsEdit then begin
    StartWait;
    try
      oRow := GetRow;
      if oRow.RowState = rsEditing then
        oRow.CancelEdit;
      DoProcessUpdateRequest(arUnLock, [uoImmediateUpd, uoCancelUnlock]);
    finally
      StopWait;
    end;
  end
  else begin
    pInfo := GetRecInfo(ActiveBuffer);
    if pInfo^.FRow = FNewRow then
      pInfo^.FRow := nil;
    FDFreeAndNil(FNewRow);
  end;
  if FPrevRecordIndex <> -1 then begin
    FRecordIndex := FPrevRecordIndex;
    FPrevRecordIndex := -1;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.Cancel;
begin
  inherited Cancel;
  if State = dsSetKey then
    PostKeyBuffer(False);
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.InternalAddRecord(Buffer: TRecBuf; Append: Boolean);
var
  iPrevRecIndToIns: Integer;
begin
  StartWait;
  try
    iPrevRecIndToIns := FRecordIndexToInsert;
    try
      if Append then begin
        if FClientCursor then
          InternalFetchRows(True, True);
        FSourceView.ProposedPosition := FSourceView.Rows.Count;
      end
      else
        FSourceView.ProposedPosition := FRecordIndexToInsert;
      FTable.Rows.Add(FNewRow);
      UpdateRecordIndex;
      DoProcessUpdateRequest(arInsert, [uoImmediateUpd]);
      FNewRow := nil;
      // after posting update the record position may be changed in case of
      // IDENTITY / TRIGGER / etc
      UpdateRecordIndex;
    except
      if FNewRow <> nil then begin
        if FNewRow.Owner = FTable.Rows then
          FNewRow.Delete(True);
        if not (dfPostRow in FFlags) then
          FDFreeAndNil(FNewRow);
      end;
      FRecordIndexToInsert := iPrevRecIndToIns;
      raise;
    end;
  finally
    StopWait;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.InternalInitRecord(Buffer: TRecBuf);
begin
  if State in dsEditModes then
    GetRow(Buffer).Clear(True);
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.InitRecord(Buffer: TRecBuf);
var
  oParentRow: TFDDatSRow;
  oMasterSource: TDataSource;
  pInfo: PFDRecInfo;
begin
  oMasterSource := MasterSource;
  if (oMasterSource <> nil) and (oMasterSource.DataSet <> nil) and
     (oMasterSource.DataSet is TFDDataSet) then
    FNewRow := FTable.NewRow(True, [TFDDataSet(oMasterSource.DataSet).GetRow])
  else
    FNewRow := FTable.NewRow(True);
  if FParentDataSet <> nil then begin
    oParentRow := GetParentRow;
    if oParentRow <> nil then
      try
        FNewRow.ParentRow := oParentRow;
      except
        FDFree(FNewRow);
        FNewRow := nil;
        raise;
      end;
  end;
  inherited InitRecord(Buffer);
  pInfo := GetRecInfo(Buffer);
  pInfo^.FBookmarkFlag := bfInserted;
  pInfo^.FRowIndex := -1;
  pInfo^.FRow := FNewRow;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.DoOnNewRecord;
var
  oMasters, oDetails: TFDFieldList;
  i: Integer;
  iCount: Integer;
begin
  try
    DoProcessUpdateRequest(arFetchGenerators, [uoNoSrvRecord]);
    if (MasterSource <> nil) and (MasterSource.DataSet <> nil) and
       MasterSource.DataSet.Active then begin
      oMasters := TFDFieldList.Create;
      oDetails := TFDFieldList.Create;
      try
        GetDetailLinkFields(oMasters, oDetails);
        iCount := oMasters.Count;
        if iCount > oDetails.Count then
          iCount := oDetails.Count;
        for i := 0 to iCount - 1 do
          if oDetails[i].CanModify then
            oDetails[i].Assign(oMasters[i]);
      finally
        FDFree(oMasters);
        FDFree(oDetails);
      end;
    end;
    inherited DoOnNewRecord;
  except
    InternalCancel;
    raise;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.EmptyDataSet;
var
  i: Integer;
begin
  CheckBrowseMode;
  FTable.Clear;
  for i := 0 to NestedDataSets.Count - 1 do
    NestedDataSets[i].Resync([]);
  Resync([]);
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.EmptyView;
var
  i: Integer;
  rState: TFDDatSLoadState;
begin
  CheckBrowseMode;
  Table.BeginLoadData(rState, lmHavyMove);
  try
    for i := SourceView.Rows.Count - 1 downto 0 do
      Table.Rows.Remove(SourceView.Rows[i]);
  finally
    Table.EndLoadData(rState);
  end;
  Resync([]);
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.CopyRecordBase(ASource: TDataset; AExcludeNewEmptyValues: Boolean);
var
  i: Integer;
  oSrcField: TField;
  oDestField: TField;
begin
  for i := 0 to ASource.FieldCount - 1 do begin
    oSrcField := ASource.Fields[i];
    oDestField := FindField(oSrcField.FieldName);
    if (oDestField <> nil) and oDestField.CanModify and
       not (AExcludeNewEmptyValues and VarIsEmpty(oSrcField.NewValue)) then
      oDestField.Assign(oSrcField);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.CopyRecord(ASource: TDataset);
begin
  CopyRecordBase(ASource, False);
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.CopyDataSet(ASource: TDataset;
  AOptions: TFDCopyDataSetOptions = [coRestart, coAppend]);

  function UpdateDefs(AFields: TFields; ADefs: TFieldDefs): Boolean;
  var
    i: Integer;
    oSrcFld: TField;
    j: Integer;
    oDef: TFieldDef;
    oDS: TDataSet;
  begin
    Result := False;
    for i := 0 to AFields.Count - 1 do begin
      oSrcFld := AFields[i];
      j := ADefs.IndexOf(oSrcFld.FieldName);
      if (coCalcFields in AOptions) and (oSrcFld.FieldKind <> fkData) and (j = -1) then
        ADefs.Add(oSrcFld.FieldName, oSrcFld.DataType, oSrcFld.Size)
      else begin
        if j = -1 then
          Continue;
        oDef := ADefs[j];
        if (oSrcFld.FieldKind = fkData) and (oSrcFld.DataType = ftDataSet) then begin
          oDS := TDataSetField(oSrcFld).NestedDataSet;
          oDef.ChildDefs.Assign(oDS.FieldDefs);
          UpdateDefs(oDS.Fields, oDef.ChildDefs);
          Result := True;
        end
        else if (oSrcFld.FieldKind = fkData) and (oSrcFld.DataType = ftADT) then
          Result := UpdateDefs(TADTField(oSrcFld).Fields, oDef.ChildDefs) or Result;
      end;
    end;
  end;

var
  bm: TBookmark;
  i: Integer;
  oKeyFields: TFDFieldList;
  sKeyFields: String;
  vKeyValues: Variant;
  oFld, oSrcFld: TField;
  eDestStatus, eSrcStatus: TUpdateStatus;
  oSrcRow, oDestRow: TFDDatSRow;
  aMap: TFDArrayOfInteger;
  oIndDefs: TIndexDefs;
  lHasNestedDS: Boolean;
begin
  if (ASource = nil) or (ASource = Self) then
    Exit;

  DisableControls;
  StartWait;
  oKeyFields := nil;
  try
    // Recreate this dataset using ASource structure.
    if coStructure in AOptions then begin
      Disconnect();
      if coIndexesReset in AOptions then begin
        IndexName := '';
        IndexFieldNames := '';
        IndexDefs.Clear;
        Indexes.Clear;
      end;
      if coIndexesCopy in AOptions then
        if ASource is TFDDataSet then begin
          IndexDefs := TFDDataSet(ASource).IndexDefs;
          Indexes := TFDDataSet(ASource).Indexes;
          IndexName := TFDDataSet(ASource).IndexName;
          IndexFieldNames := TFDDataSet(ASource).IndexFieldNames;
          IndexesActive := TFDDataSet(ASource).IndexesActive;
        end
        else begin
          oIndDefs := (ASource as IProviderSupportNG).PSGetIndexDefs();
          if oIndDefs <> nil then
            IndexDefs := oIndDefs;
        end;
      if coAggregatesReset in AOptions then
        Aggregates.Clear;
      if (coAggregatesCopy in AOptions) and (ASource is TFDDataSet) then begin
        Aggregates := TFDDataSet(ASource).Aggregates;
        AggregatesActive := TFDDataSet(ASource).AggregatesActive;
      end;
      if coConstraintsReset in AOptions then
        Constraints.Clear;
      if (coConstraintsCopy in AOptions) and (ASource is TFDDataSet) then begin
        Constraints := TFDDataSet(ASource).Constraints;
        ConstraintsEnabled := TFDDataSet(ASource).ConstraintsEnabled;
      end;
      try
        FormatOptions.MaxBcdPrecision := MaxInt;
        FormatOptions.MaxBcdScale := MaxInt;
        if ASource.Active then
          ASource.FieldDefs.Update;
        FieldDefs.Assign(ASource.FieldDefs);
        lHasNestedDS := UpdateDefs(ASource.Fields, FieldDefs);
        FieldDefList.Update;
        FieldDefs.Updated := True;

        if not lHasNestedDS then begin
          CreateFields;
          for i := 0 to FieldCount - 1 do begin
            oFld := Fields[i];
            oSrcFld := ASource.FindField(oFld.FieldName);
            if oSrcFld <> nil then begin
              oFld.AutoGenerateValue := oSrcFld.AutoGenerateValue;
              oFld.EditMask := oSrcFld.EditMask;
              oFld.Origin := oSrcFld.Origin;
              oFld.ProviderFlags := oSrcFld.ProviderFlags;
              oFld.DefaultExpression := oSrcFld.DefaultExpression;
              oFld.DisplayWidth := oSrcFld.DisplayWidth;
              oFld.DisplayLabel := oSrcFld.DisplayLabel;
              oFld.Required := oSrcFld.Required;
              oFld.ReadOnly := oSrcFld.ReadOnly;
              oFld.Visible := oSrcFld.Visible;
              oFld.Alignment := oSrcFld.Alignment;
              if coConstraintsCopy in AOptions then begin
                oFld.CustomConstraint := oSrcFld.CustomConstraint;
                oFld.ConstraintErrorMessage := oSrcFld.ConstraintErrorMessage;
                oFld.ImportedConstraint := oSrcFld.ImportedConstraint;
              end;
            end;
            if [coAppend, coEdit, coRefresh] * AOptions <> [] then begin
              if oFld is TFDAutoIncField then
                TFDAutoIncField(oFld).IdentityInsert := True;
              oFld.ReadOnly := False;
            end;
          end;
          for i := 0 to ASource.FieldCount - 1 do begin
            oSrcFld := ASource.Fields[i];
            oFld := FindField(oSrcFld.FieldName);
            if oFld <> nil then
              oFld.Index := oSrcFld.Index;
          end;
        end;

        Active := True;
        if not (ASource is TFDDataSet) then begin
          sKeyFields := IProviderSupportNG(ASource).PSGetKeyFields;
          i := 1;
          while i <= Length(sKeyFields) do begin
            oFld := FieldByName(FDExtractFieldName(sKeyFields, i));
            oFld.ProviderFlags := oFld.ProviderFlags + [pfInKey];
          end;
        end;
      finally
        Fields.LifeCycles := [lcAutomatic];
      end;
    end;

    // If do not process a data, then exit.
    if [coAppend, coEdit, coRefresh] * AOptions = [] then
      Exit;
    // Else, check that both datasets are active.
    CheckBrowseMode;
    ASource.CheckBrowseMode;

    if (coRefresh in AOptions) and not (ASource is TFDDataSet) then
      AOptions := AOptions - [coRefresh] + [coEdit];

    // If requested to edit record with the existing key value, then
    // fill a list of the ASource key fields and prepare a key values array.
    if [coEdit, coRefresh] * AOptions <> [] then begin
      sKeyFields := PSGetKeyFields;
      oKeyFields := TFDFieldList.Create;
      ASource.GetFieldList(oKeyFields, sKeyFields);
      if (oKeyFields.Count = 0) or (sKeyFields = '') then
        AOptions := AOptions - [coEdit, coRefresh];
      vKeyValues := VarArrayCreate([0, oKeyFields.Count - 1], varVariant);
    end;

    // Run batch update.
    BeginBatch(ctInvars in Table.Columns.HasThings);
    try
      ASource.DisableControls;
      bm := ASource.GetBookmark;
      try
        if coRestart in AOptions then
          ASource.First;
        while not ASource.Eof do begin
          eDestStatus := usUnmodified;
          eSrcStatus := ASource.UpdateStatus;

          // If merge, then locate record using a ASource key values.
          if [coEdit, coDelete, coRefresh] * AOptions <> [] then begin
            for i := 0 to oKeyFields.Count - 1 do begin
              oFld := oKeyFields[i];
              if eSrcStatus = usInserted then
                vKeyValues[i] := oFld.CurValue
              else
                vKeyValues[i] := oFld.OldValue;
              if VarIsEmpty(vKeyValues[i]) then
                vKeyValues[i] := oFld.Value;
            end;
            if Locate(sKeyFields, vKeyValues, []) then
              if eSrcStatus = usDeleted then begin
                if coDelete in AOptions then
                  eDestStatus := usDeleted;
              end
              else
                eDestStatus := usModified
            else if eSrcStatus <> usDeleted then
              if coAppend in AOptions then
                eDestStatus := usInserted;
          end
          else if eSrcStatus <> usDeleted then
            if coAppend in AOptions then
              eDestStatus := usInserted;

          // Copy data
          if eDestStatus in [usInserted, usModified] then

            // Merge data into main table. Do not produce row version.
            if coRefresh in AOptions then begin
              if eDestStatus = usInserted then begin
                oDestRow := Table.NewRow(False);
                Table.Rows.Add(oDestRow);
              end
              else
                oDestRow := GetRow();
              oSrcRow := TFDDataSet(ASource).GetRow();
              if Length(aMap) = 0 then
                Table.MakeColumnMap(oSrcRow.Table, aMap);
              Table.Import(oSrcRow, oDestRow, aMap);
              oDestRow.AcceptChanges();
            end

            // Edit data. Produce row version and post changes to a DB.
            else begin
              if eDestStatus = usInserted then
                Append
              else
                Edit;
              CopyRecordBase(ASource, False);
              Post;
            end

          // Delete data
          else if eDestStatus = usDeleted then

            // Delete data in main table. Do not produce row version.
            if coRefresh in AOptions then begin
              oDestRow := GetRow();
              oDestRow.Delete;
              oDestRow.AcceptChanges();
              UpdateRecordIndex;
            end
            // Delete data. Produce row version and post changes to a DB.
            else
              Delete;

          ASource.Next;
        end;

      finally
        if ASource.BookmarkValid(bm) then
          ASource.GotoBookmark(bm);
        ASource.FreeBookmark(bm);
        ASource.EnableControls;
      end;
    finally
      EndBatch;
    end;
  finally
    FDFree(oKeyFields);
    StopWait;
    EnableControls;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.MergeDataSet(ASource: TFDDataSet; AData: TFDMergeDataMode;
  AMeta: TFDMergeMetaMode; AOptions: TFDMergeOptions);
var
  lMerge, lCommit: Boolean;
begin
  lMerge := False;
  lCommit := False;
  if not Active then begin
    lCommit := AData in [dmDataSet, dmDataAppend, dmDataMerge];
    if (AData <> dmNone) and (AMeta <> mmNone) then
      Data := ASource.Data
    else if AMeta <> mmNone then begin
      FieldDefs := ASource.FieldDefs;
      Active := True;
    end
    else begin
      Active := True;
      lMerge := True;
    end;
  end
  else begin
    CheckBrowseMode;
    lMerge := True;
  end;
  if lMerge then begin
    Table.Merge(ASource.Table, AData, AMeta, AOptions);
    if (AMeta <> mmNone) and not RenewColumnMap() then
      FieldDefs.Updated := False;
  end;
  if lCommit then
    Table.AcceptChanges;
  if lMerge or lCommit then
    ResyncViews;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.DoUpdateErrorHandler(ARow: TFDDatSRow; AException: Exception;
  ARequest: TFDUpdateRequest; var AAction: TFDErrorAction);
begin
  if (AException is EFDException) and Assigned(FOnUpdateError) then begin
    if (ARow <> nil) and (GetRow <> ARow) then
      BeginForceRow(ARow, False, True);
    try
      try
        FOnUpdateError(Self, EFDException(AException), ARow, ARequest, AAction);
      except
        InternalHandleException;
        AAction := eaFail;
      end;
    finally
      if (ARow <> nil) and IsForceRowMode then
        EndForceRow;
    end;
  end
  else
    AAction := eaDefault;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.DoUpdateRecordHandler(ARow: TFDDatSRow;
  ARequest: TFDUpdateRequest; AOptions: TFDUpdateRowOptions;
  var AAction: TFDErrorAction);
begin
  if Assigned(OnUpdateRecord) then begin
    if (ARow <> nil) and (GetRow <> ARow) then
      BeginForceRow(ARow, False, True);
    try
      try
        AAction := eaApplied;
        OnUpdateRecord(Self, ARequest, AAction, AOptions);
      except
        if not (AAction in [eaApplied, eaDefault]) then
          AAction := eaFail;
        if AAction = eaFail then
          raise;
      end;
    finally
      if (ARow <> nil) and IsForceRowMode then
        EndForceRow;
    end;
  end
  else
    AAction := eaDefault;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.DoReconcileErrorHandler(ARow: TFDDatSRow;
  AException: EFDException; AUpdateKind: TFDDatSRowState;
  var AAction: TFDDAptReconcileAction);
begin
  if Assigned(OnReconcileError) then begin
    if (ARow <> nil) and (GetRow <> ARow) then
      BeginForceRow(ARow, False, True);
    try
      try
        OnReconcileError(Self, AException, AUpdateKind, AAction);
      except
        InternalHandleException;
        AAction := raSkip;
      end;
    finally
      if (ARow <> nil) and IsForceRowMode then
        EndForceRow;
    end;
  end
  else
    AAction := raSkip;
end;

{-------------------------------------------------------------------------------}
{ Bookmarks}

procedure TFDDataSet.SetBookmarkSize(AValue: Integer);
begin
  if BookmarkSize <> AValue then begin
    inherited BookmarkSize := AValue;
    SetLength(FSetToRecBmk, AValue);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.InternalGotoBookmark(Bookmark: Pointer);
  procedure ErrorNoBmk;
  begin
    FDException(Self, [S_FD_LComp, S_FD_LComp_PDS], er_FD_DSNoBookmark, [GetDisplayName]);
  end;
var
  i: Integer;
  pBmk: PFDBookmarkData;
begin
  pBmk := PFDBookmarkData(Bookmark);
  i := FSourceView.IndexOf(pBmk^.FRow, rvDefault, pBmk^.FRowIndex);
  if (i = -1) and not (dfLockNoBMK in FFlags) then
    ErrorNoBmk;
  FRecordIndex := i;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.InternalGotoBookmark(Bookmark: TBookmark);
begin
  InternalGotoBookmark(TRecordBuffer(Bookmark));
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.InternalSetToRecord(Buffer: TRecBuf);
begin
  GetBookmarkData(Buffer, FSetToRecBmk);
  InternalGotoBookmark(FSetToRecBmk);
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.GetBookmarkFlag(Buffer: TRecBuf): TBookmarkFlag;
begin
  Result := GetRecInfo(Buffer)^.FBookmarkFlag;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.SetBookmarkFlag(Buffer: TRecBuf; AValue: TBookmarkFlag);
begin
  GetRecInfo(Buffer)^.FBookmarkFlag := AValue;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.GetBookmarkData(Buffer: TRecBuf; Data: TBookmark);
var
  pBmk: PFDBookmarkData;
begin
  pBmk := PFDBookmarkData(Data);
  pBmk^.FRow := GetRow(Buffer, True);
  pBmk^.FRowIndex := GetRowIndex(Buffer);
  pBmk^.FResultSetNum := Table.Rows.ResultSetNum;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.SetBookmarkData(Buffer: TRecBuf; Data: TBookmark);
var
  pInfo: PFDRecInfo;
  pBmk: PFDBookmarkData;
begin
  pInfo := GetRecInfo(Buffer);
  pBmk := PFDBookmarkData(Data);
  pInfo^.FRow := pBmk^.FRow;
  pInfo^.FRowIndex := pBmk^.FRowIndex;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.GetRowFromBookmark(ABookmark: TBookmark; out ARowIndex: Integer;
  out AResultSetNum: Integer): TFDDatSRow;
var
  pBmk: PFDBookmarkData;
begin
  pBmk := PFDBookmarkData(@ABookmark[0]);
  Result := pBmk^.FRow;
  ARowIndex := pBmk^.FRowIndex;
  AResultSetNum := pBmk^.FResultSetNum;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.IsRowValid(ARow: TFDDatSRow; AResultSetNum: Integer): Boolean;
begin
  Result := (ARow <> nil) and (Table <> nil) and
    ((ARow.Owner = Table.Rows) or (ARow.Owner = Table)) and
    (Table.Rows.ResultSetNum = AResultSetNum);
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.CompareBookmarks(Bookmark1, Bookmark2: TBookmark): Integer;
const
  RetCodes: array[Boolean, Boolean] of ShortInt = ((2, -1), (1, 0));
var
  oRow1, oRow2: TFDDatSRow;
  i1, i2, iRS1, iRS2: Integer;
begin
  Result := RetCodes[Bookmark1 = nil, Bookmark2 = nil];
  if Result = 2 then begin
    oRow1 := GetRowFromBookmark(Bookmark1, i1, iRS1);
    oRow2 := GetRowFromBookmark(Bookmark2, i2, iRS2);
    if not IsRowValid(oRow1, iRS1) or not IsRowValid(oRow2, iRS2) then
      Result := 0
    else begin
      i1 := FSourceView.IndexOf(oRow1, rvDefault, i1);
      i2 := FSourceView.IndexOf(oRow2, rvDefault, i2);
      if i1 < i2 then
        Result := -1
      else if i1 > i2 then
        Result := 1
      else
        Result := 0;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.BookmarkValid(ABookmark: TBookmark): Boolean;
var
  oRow: TFDDatSRow;
  iRow, iRS: Integer;
begin
  Result := False;
  if ABookmark <> nil then begin
    oRow := GetRowFromBookmark(ABookmark, iRow, iRS);
    if IsRowValid(oRow, iRS) then begin
      iRow := FSourceView.IndexOf(oRow, rvDefault, iRow);
      if iRow <> -1 then
        Result := (oRow.RowID = FSourceView.Rows[iRow].RowID);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
{$IFNDEF NEXTGEN}
function TFDDataSet.BookmarkStrValid(ABookmarkStr: TBookmarkStr): Boolean;
var
  pBmkData: PFDBookmarkData;
  i: Integer;
begin
  Result := False;
  if Length(ABookmarkStr) > 0 then begin
    pBmkData := PFDBookmarkData(@ABookmarkStr[1]);
    if IsRowValid(pBmkData^.FRow, pBmkData^.FResultsetNum) then begin
      i := FSourceView.IndexOf(pBmkData^.FRow, rvDefault, pBmkData^.FRowIndex);
      if i <> -1 then
        Result := (pBmkData^.FRow.RowID = FSourceView.Rows[i].RowID);
    end;
  end;
end;
{$ENDIF}

{-------------------------------------------------------------------------------}
{ Aggregates }

procedure TFDDataSet.SetAggregates(const AValue: TFDAggregates);
begin
  FAggregates.Assign(AValue);
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.IsAS: Boolean;
begin
  Result := FAggregates.Count > 0;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.SetAggregatesActive(const AValue: Boolean);
begin
  if FAggregatesActive <> AValue then begin
    FAggregatesActive := AValue;
    if FAggregatesActive and Active then begin
      FAggregates.Build;
      FFieldAggregates.Build;
    end
    else begin
      FAggregates.Release;
      FFieldAggregates.Release;
    end;
    DataEvent(deRecordChange, 0);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.GetAggregateValue(AField: TField): Variant;
var
  oAgg: TFDAggregate;
  oAggFld: TAggregateField;
begin
  oAggFld := AField as TAggregateField;
  oAgg := TFDAggregate(oAggFld.Handle);
  if oAgg <> nil then
    Result := oAgg.Value;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.ResetAggField(AField: TField);
var
  oAgg: TFDAggregate;
  oAggFld: TAggregateField;
begin
  if AggFields.IndexOf(AField) <> -1 then begin
    oAggFld := AField as TAggregateField;
    oAgg := TFDAggregate(oAggFld.Handle);
    if oAgg <> nil then begin
      oAgg.Active := False;
      oAgg.Assign(oAggFld);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.SetViewAggregates;
var
  i: Integer;
  oAggFld: TAggregateField;
  oAgg: TFDAggregate;
  iSize: LongWord;
  iPrecision, iScale: Integer;
  eType: TFieldType;
begin
  for i := 0 to AggFields.Count - 1 do begin
    oAggFld := AggFields[i] as TAggregateField;
    oAgg := FFieldAggregates.Add;
    oAggFld.Handle := oAgg;
    oAgg.Assign(oAggFld);
    FormatOptions.ColumnDef2FieldDef(oAgg.DataType, 0, 0, 0, [], eType, iSize,
      iPrecision, iScale);
    oAggFld.ResultType := eType;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.ResetViewAggregates;
var
  i: Integer;
  oAggFld: TAggregateField;
  oAgg: TFDAggregate;
begin
  for i := 0 to AggFields.Count - 1 do begin
    oAggFld := AggFields[i] as TAggregateField;
    oAgg := TFDAggregate(oAggFld.Handle);
    oAggFld.Handle := nil;
    FDFree(oAgg);
  end;
  Aggregates.Release;
  FFieldAggregates.Release;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.GetGroupingLevel: Integer;
begin
  if FAggregates.GroupingLevel > FFieldAggregates.GroupingLevel then
    Result := FAggregates.GroupingLevel
  else
    Result := FFieldAggregates.GroupingLevel;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.GetGroupState(ALevel: Integer): TGroupPosInds;
begin
  if not (State in [dsInactive, dsOpening, dsInsert, dsSetKey]) and
     AggregatesActive and (LocalIndexName <> '') then begin
    UpdateCursorPos;
    Result := TGroupPosInds(FSourceView.GetGroupState(FRecordIndex, ALevel));
  end
  else
    Result := [];
end;

{-------------------------------------------------------------------------------}
{ Local indexes / keys / ranges }

function TFDDataSet.IsIndexed: Boolean;
begin
  Result := (FSortView <> nil) and (FSortView.SortingMechanism <> nil);
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.SetIndexes(const AValue: TFDIndexes);
begin
  FIndexes.Assign(AValue);
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.IsIS: Boolean;
begin
  Result := FIndexes.Count > 0;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.SetIndexDefs(const AValue: TIndexDefs);
begin
  FIndexDefs.Assign(AValue);
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.IsIDS: Boolean;
begin
  Result := FIndexDefs.Count > 0;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.SetIndexesActive(const AValue: Boolean);
begin
  if FIndexesActive <> AValue then begin
    FIndexesActive := AValue;
    if FIndexesActive then begin
      FIndexes.Build;
      if (FIndexFieldNames <> '') or (FIndexName <> '') then begin
        DoSortOrderChanging;
        SwitchToIndex(FIndexFieldNames, FLocalIndexName);
      end;
    end
    else
      FIndexes.Release;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.SetIndexName(const AValue: String);
begin
  if IndexName <> AValue then begin
    FIndexName := AValue;
    FLocalIndexName := FIndexName;
    FIndexFieldNames := '';
    DoSortOrderChanging;
    if Active then
      try
        SwitchToIndex('', FLocalIndexName);
      except
        IndexName := '';
        raise;
      end;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.GetIndexFieldNames: String;
begin
  Result := FIndexFieldNames;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.SetIndexFieldNames(const AValue: String);
begin
  if IndexFieldNames <> AValue then begin
    FIndexName := '';
    FLocalIndexName := '';
    FIndexFieldNames := AValue;
    DoSortOrderChanging;
    if Active then
      try
        SwitchToIndex(FIndexFieldNames, '');
      except
        IndexFieldNames := '';
        raise;
      end;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.GetIndexFieldCount: Integer;
begin
  if IsIndexed then
    Result := FSortView.SortingMechanism.SortColumnList.Count
  else
    Result := 0;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.GetIndexField(AIndex: Integer): TField;
begin
  if IsIndexed then
    Result := InternalFieldByName(FSortView.SortingMechanism.SortColumnList.
      ItemsI[AIndex].Name, 'FSortView.SortingMechanism')
  else
    Result := nil;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.GetIsIndexField(AField: TField): Boolean;
begin
  if IsIndexed then
    Result := FSortView.SortingMechanism.SortColumnList.FindColumn(AField.FieldName) <> nil
  else
    Result := False;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.CheckSetKeyMode;
begin
  if State <> dsSetKey then
    DatabaseError(SNotEditing, Self);
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.CheckIndexed;
begin
  if not IsIndexed then
    DatabaseError(SNoFieldIndexes, Self);
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.AllocKeyBuffers;
var
  i: TFDKeyIndex;
begin
  if dfKeyBuffersAllocated in FFlags then
    Exit;
  try
    Include(FFlags, dfKeyBuffersAllocated);
    for i := Low(TFDKeyIndex) to High(TFDKeyIndex) do begin
      GetMem(FKeyBuffers[i], SizeOf(TFDKeyBuffer));
      FillChar(FKeyBuffers[i]^, SizeOf(TFDKeyBuffer), 0);
      FKeyBuffers[i]^.FRecBuff := AllocRecBuf;
      InitKeyBuffer(FKeyBuffers[i]);
    end;
  except
    FreeKeyBuffers;
    raise;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.FreeKeyBuffers;
var
  i: TFDKeyIndex;
  oRow: TFDDatSRow;
  pBuff: PFDKeyBuffer;
begin
  if not (dfKeyBuffersAllocated in FFlags) then
    Exit;
  Exclude(FFlags, dfKeyBuffersAllocated);
  for i := Low(TFDKeyIndex) to High(TFDKeyIndex) do begin
    pBuff := GetKeyBuffer(i, False);
    if pBuff <> nil then begin
      oRow := GetKeyRow(pBuff);
      if oRow <> nil then begin
        SetKeyRow(pBuff, nil);
        FDFree(oRow);
      end;
      FreeRecBuf(pBuff^.FRecBuff);
      FreeMem(pBuff, SizeOf(TFDKeyBuffer));
      FKeyBuffers[i] := nil;
    end;
  end;
  FKeyBuffer := nil;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.GetKeyRow(ABuffer: PFDKeyBuffer): TFDDatSRow;
begin
  Result := GetRow(ABuffer.FRecBuff, True);
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.GetLocateRow: TFDDatSRow;
begin
  Result := FLocateRow;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.SetKeyRow(ABuffer: PFDKeyBuffer; ARow: TFDDatSRow);
var
  pInfo: PFDRecInfo;
begin
  pInfo := GetRecInfo(ABuffer.FRecBuff);
{$IFDEF AUTOREFCOUNT}
  if pInfo^.FRow <> nil then
    pInfo^.FRow.__ObjRelease;
{$ENDIF}
  pInfo^.FRow := ARow;
{$IFDEF AUTOREFCOUNT}
  if pInfo^.FRow <> nil then
    pInfo^.FRow.__ObjAddRef;
{$ENDIF}
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.GetKeyBuffer(AKeyIndex: TFDKeyIndex; ACheckCreateRow: Boolean = True): PFDKeyBuffer;
var
  oRow: TFDDatSRow;
begin
  if ACheckCreateRow and (GetKeyRow(FKeyBuffers[AKeyIndex]) = nil) then begin
    oRow := FTable.NewRow(False);
    oRow.BeginForceWrite;
    SetKeyRow(FKeyBuffers[AKeyIndex], oRow);
  end;
  Result := FKeyBuffers[AKeyIndex];
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.InitKeyBuffer(ABuffer: PFDKeyBuffer): PFDKeyBuffer;
begin
  ABuffer^.FModified := False;
  ABuffer^.FExclusive := False;
  ABuffer^.FFieldCount := 0;
  ABuffer^.FAssignedFieldCount := 0;
  FillChar(TRecordBuffer(ABuffer^.FRecBuff)^, FBufferSize, 0);
  Result := ABuffer;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.ClearKeyBuffer(ABuffer: PFDKeyBuffer): PFDKeyBuffer;
var
  oRow: TFDDatSRow;
begin
  oRow := GetKeyRow(ABuffer);
  SetKeyRow(ABuffer, nil);
  Result := InitKeyBuffer(ABuffer);
  SetKeyRow(ABuffer, oRow);
  if oRow <> nil then
    oRow.Clear(False);
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.AssignKeyBuffer(ADest, ASrc: PFDKeyBuffer);
var
  oSrcRow: TFDDatSRow;
  oDestRow: TFDDatSRow;
  pSrcInfo: PFDRecInfo;
  pDestInfo: PFDRecInfo;
begin
  pSrcInfo := GetRecInfo(ASrc^.FRecBuff);
  pDestInfo := GetRecInfo(ADest^.FRecBuff);

  ADest^.FModified := ASrc^.FModified;
  ADest^.FExclusive := ASrc^.FExclusive;
  ADest^.FFieldCount := ASrc^.FFieldCount;
  ADest^.FAssignedFieldCount := ASrc^.FAssignedFieldCount;

  Move(TRecordBuffer(ASrc^.FRecBuff)^, TRecordBuffer(ADest^.FRecBuff)^, CalcFieldsSize);
  pDestInfo^.FRowIndex := pSrcInfo^.FRowIndex;
  pDestInfo^.FBookmarkFlag := pSrcInfo^.FBookmarkFlag;

  oSrcRow := GetKeyRow(ASrc);
  oDestRow := GetKeyRow(ADest);
  if oSrcRow = nil then
    SetKeyRow(ADest, nil)
  else begin
    if oDestRow = nil then begin
      oDestRow := FTable.NewRow(False);
      oDestRow.BeginForceWrite;
      SetKeyRow(ADest, oDestRow);
    end;
    FTable.Import(oSrcRow, oDestRow);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.CompareKeyBuffer(ABuff1, ABuff2: PFDKeyBuffer): Boolean;
var
  oRow1, oRow2: TFDDatSRow;
  oCache: TFDDatSCompareRowsCache;
begin
  if (ABuff1^.FExclusive <> ABuff2^.FExclusive) or (ABuff1^.FFieldCount <> ABuff2^.FFieldCount) then
    Result := False
  else begin
    oRow1 := GetKeyRow(ABuff1);
    oRow2 := GetKeyRow(ABuff2);
    oCache := nil;
    Result := (oRow1.CompareRows(nil, nil, nil, -1, oRow2, nil, rvDefault, [], oCache) = 0);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.SetKeyBuffer(AKeyIndex: TFDKeyIndex; AClear: Boolean);
begin
  CheckBrowseMode;
  CheckIndexed;
  FKeyBuffer := GetKeyBuffer(AKeyIndex);
  AssignKeyBuffer(GetKeyBuffer(kiSave), FKeyBuffer);
  if AClear then
    ClearKeyBuffer(FKeyBuffer);
  SetState(dsSetKey);
  SetModified(FKeyBuffer^.FModified);
  DataEvent(deDataSetChange, 0);
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.GetKeyExclusive: Boolean;
begin
  CheckSetKeyMode;
  Result := FKeyBuffer^.FExclusive;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.SetKeyExclusive(AValue: Boolean);
begin
  CheckSetKeyMode;
  FKeyBuffer^.FExclusive := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.GetKeyFieldCount: Integer;
begin
  CheckSetKeyMode;
  Result := FKeyBuffer^.FFieldCount;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.SetKeyFieldCount(AValue: Integer);
begin
  CheckSetKeyMode;
  FKeyBuffer^.FFieldCount := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.InternalDefaultKeyFieldCount(ABuffer: PFDKeyBuffer; ADefault: Integer): Integer;
begin
  Result := ADefault;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.SetKeyFields(AKeyIndex: TFDKeyIndex; const AValues: array of const;
  AExclusive: Boolean = False);
var
  i: Integer;
  iSaveState: TDataSetState;
begin
  CheckIndexed;
  iSaveState := SetTempState(dsSetKey);
  try
    FKeyBuffer := ClearKeyBuffer(GetKeyBuffer(AKeyIndex));
    FKeyBuffer^.FExclusive := AExclusive;
    for i := 0 to High(AValues) do
      GetIndexField(i).AssignValue(AValues[i]);
    FKeyBuffer^.FFieldCount := High(AValues) + 1;
    FKeyBuffer^.FModified := Modified;
  finally
    RestoreState(iSaveState);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.PostKeyBuffer(ACommit: Boolean);
begin
  CheckIndexed;
  DataEvent(deCheckBrowseMode, 0);
  if ACommit then
    FKeyBuffer^.FModified := Modified
  else
    AssignKeyBuffer(FKeyBuffer, GetKeyBuffer(kiSave));
  SetState(dsBrowse);
  DataEvent(deDataSetChange, 0);
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.SetKey;
begin
  SetKeyBuffer(kiLookup, True);
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.EditKey;
begin
  SetKeyBuffer(kiLookup, False);
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.FindKey(const AKeyValues: array of const): Boolean;
begin
  CheckBrowseMode;
  SetKeyFields(kiLookup, AKeyValues);
  Result := GotoKey;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.FindNearest(const AKeyValues: array of const);
begin
  CheckBrowseMode;
  SetKeyFields(kiLookup, AKeyValues);
  GotoNearest;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.InternalGotoKey(ANearest: Boolean): Boolean;
var
  iPos: Integer;
  oRow: TFDDatSRow;
  keyBuff: PFDKeyBuffer;
  opts: TFDLocateOptions;
  iFldCnt: Integer;
begin
  CheckIndexed;
  iPos := BeginLocate([], nil);
  keyBuff := GetKeyBuffer(kiLookup);
  oRow := GetKeyRow(keyBuff);
  if FKeyBuffer^.FFieldCount <= 0 then
    iFldCnt := InternalDefaultKeyFieldCount(FKeyBuffer,
      FSortView.SortingMechanism.SortColumnList.Count)
  else
    iFldCnt := FKeyBuffer^.FFieldCount;
  if ANearest then
    opts := [loNearest, loPartial]
  else
    opts := [];
  if soNoCase in FSortView.SortingMechanism.SortOptions then
    Include(opts, loNoCase);
  Result := False;
  FSourceView.Search(oRow, FSortView.SortingMechanism.SortColumnList, nil,
    iFldCnt, opts, iPos, Result);
  if Result or ANearest then begin
    if iPos >= FSourceView.Rows.Count then
      iPos := FSourceView.Rows.Count - 1
    else if iPos < 0 then
      iPos := 0;
    EndLocate(True, iPos, [], nil);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.InternalResetRange;
begin
  DoFilteringUpdated(True);
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.GotoKey: Boolean;
begin
  Result := InternalGotoKey(False);
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.GotoNearest;
begin
  InternalGotoKey(True);
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.ApplyRange;
begin
  CheckBrowseMode;
  if SetCursorRange then
    InternalResetRange;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.CancelRange;
begin
  CheckBrowseMode;
  UpdateCursorPos;
  if ResetCursorRange then
    InternalResetRange;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.EditRangeStart;
begin
  SetKeyBuffer(kiRangeStart, False);
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.EditRangeEnd;
begin
  SetKeyBuffer(kiRangeEnd, False);
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.SetRangeStart;
begin
  SetKeyBuffer(kiRangeStart, True);
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.SetRangeEnd;
begin
  SetKeyBuffer(kiRangeEnd, True);
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.SetRange(const AStartValues, AEndValues: array of const;
  AStartExclusive: Boolean = False; AEndExclusive: Boolean = False);
begin
  CheckBrowseMode;
  SetKeyFields(kiRangeStart, AStartValues, AStartExclusive);
  SetKeyFields(kiRangeEnd, AEndValues, AEndExclusive);
  ApplyRange;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.SetCursorRange: Boolean;
var
  keyBuff: PFDKeyBuffer;
begin
  Result := False;
  if (dfKeyBuffersAllocated in FFlags) and not (
    CompareKeyBuffer(GetKeyBuffer(kiRangeStart), GetKeyBuffer(kiCurRangeStart)) and
    CompareKeyBuffer(GetKeyBuffer(kiRangeEnd), GetKeyBuffer(kiCurRangeEnd))) then
  begin
    keyBuff := GetKeyBuffer(kiRangeStart);
    if keyBuff^.FModified then begin
      FRangeFrom := GetKeyRow(keyBuff);
      if keyBuff^.FExclusive then
        Include(FFlags, dfRangeFromExclusive)
      else
        Exclude(FFlags, dfRangeFromExclusive);
      FRangeFromFieldCount := keyBuff^.FFieldCount;
      if FRangeFromFieldCount = 0 then
        FRangeFromFieldCount := InternalDefaultKeyFieldCount(keyBuff, -1);
    end
    else if FRangeFrom <> nil then begin
      FRangeFrom := nil;
      FRangeFromFieldCount := 0;
      Exclude(FFlags, dfRangeFromExclusive);
    end;
    keyBuff := GetKeyBuffer(kiRangeEnd);
    if keyBuff^.FModified then begin
      FRangeTo := GetKeyRow(keyBuff);
      if keyBuff^.FExclusive then
        Include(FFlags, dfRangeToExclusive)
      else
        Exclude(FFlags, dfRangeToExclusive);
      FRangeToFieldCount := keyBuff^.FFieldCount;
      if FRangeToFieldCount = 0 then
        FRangeToFieldCount := InternalDefaultKeyFieldCount(keyBuff, -1);
    end
    else if FRangeTo <> nil then begin
      FRangeTo := nil;
      FRangeToFieldCount := 0;
      Exclude(FFlags, dfRangeToExclusive);
    end;
    AssignKeyBuffer(GetKeyBuffer(kiCurRangeStart), GetKeyBuffer(kiRangeStart));
    AssignKeyBuffer(GetKeyBuffer(kiCurRangeEnd), GetKeyBuffer(kiRangeEnd));
    Result := True;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.ResetCursorRange: Boolean;
begin
  Result := False;
  if (dfKeyBuffersAllocated in FFlags) and (
     GetKeyBuffer(kiCurRangeStart, False)^.FModified or
     GetKeyBuffer(kiCurRangeEnd, False)^.FModified
    ) then
  begin
    if FRangeFrom <> nil then
      FRangeFrom := nil;
    if FRangeTo <> nil then
      FRangeTo := nil;
    ClearKeyBuffer(GetKeyBuffer(kiCurRangeStart));
    ClearKeyBuffer(GetKeyBuffer(kiCurRangeEnd));
    Result := True;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.IsRanged: Boolean;
begin
  Result := (FRangeFrom <> nil) or (FRangeTo <> nil);
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.AddIndex(const AName, AFields, AExpression: string;
  AOptions: TFDSortOptions; const ADescFields, ACaseInsFields: string;
  ADistinct: Boolean);
var
  oInd: TFDIndex;
begin
  if Indexes.FindIndex(AName) = nil then begin
    oInd := Indexes.Add;
    oInd.Name := AName;
    if AFields <> '' then begin
      oInd.Fields := AFields;
      oInd.DescFields := ADescFields;
      oInd.CaseInsFields := ACaseInsFields;
    end
    else if AExpression <> '' then
      oInd.Expression := AExpression;
    oInd.Options := AOptions;
    oInd.Distinct := ADistinct;
    oInd.Active := True;
  end
  else
    FDException(Self, [S_FD_LComp, S_FD_LComp_PDS], er_FD_DuplicatedName, [AName]);
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.DeleteIndex(const AName: string);
begin
  Indexes.Delete(Indexes.IndexByName(AName).Index);
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.DeleteIndexes;
begin
  Indexes.Clear;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.GetIndexNames(AList: TStrings);
begin
  if not IndexDefs.Updated then
    IndexDefs.Update;
  IndexDefs.GetItemNames(AList);
end;

{-------------------------------------------------------------------------------}
{ Lookup & Locate }

function ConditionsToExpression(const AConditions: string;
  const AValues: Variant; APartial: Boolean): string;

  function SingleExpression(const ACondition: string; const AValue: Variant): String;
  var
    iLen: Integer;
  begin
    case VarType(AValue) of
      varEmpty,
      varNull:
        Result := ' IS NULL';
      varSingle,
      varDouble,
      varCurrency:
        Result := ' = ' + FDFloat2Str(AValue, '.');
      varDate:
        Result := ' = CONVERT(''TIMESTAMP'', ''' + VarToStr(AValue) + ''')';
      varUString,
      varOleStr,
      varString:
        begin
          Result := VarToStr(AValue);
          if APartial and (Result <> '') and (Result[Length(Result)] <> '*') then
            Result := Result + '*';
          Result := ' = ' + QuotedStr(VarToStr(Result));
        end;
      else
        if VarType(AValue) = VarSQLTimeStamp then
          Result := ' = CONVERT(''TIMESTAMP'', ''' + VarToStr(AValue) + ''')'
        else if VarType(AValue) = VarFMTBcd then begin
          SetLength(Result, 255);
          FDBCD2Str(PChar(Result), iLen, VarToBcd(AValue), '.');
          SetLength(Result, iLen);
          Result := ' = ' + Result;
        end
        else
          Result := ' = ' + VarToStr(AValue);
    end;
    Result := ACondition + Result;
  end;

var
  iWord, iArray: Integer;
  sExpr: string;
begin
  if VarIsArray(AValues) then begin
    iWord := 1;
    iArray := 0;
    while iWord <= Length(AConditions) do begin
      sExpr := SingleExpression(FDExtractFieldName(AConditions, iWord), AValues[iArray]);
      if iArray = 0 then
        Result := sExpr
      else begin
        if iArray = 1 then
          Result := '(' + Result + ')';
        Result := Result + ' AND (' + sExpr + ')';
      end;
      Inc(iArray);
    end;
  end
  else
    Result := SingleExpression(AConditions, AValues);
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.InitLocateRow(const AKeyFields: String; const AKeyValues: Variant);
var
  V: Variant;
  oFld: TField;
begin
  if FLocateRow = nil then begin
    FLocateRow := FTable.NewRow(False);
    FLocateColumns := TFDDatSColumnSublist.Create;
  end;
  if AKeyFields <> FLocateColumns.Names then
    FLocateColumns.Fill(FTable, AKeyFields);
  BeginForceRow(FLocateRow, True, False);
  try
    if FLocateColumns.Count = 1 then begin
      if VarIsArray(AKeyValues) and not (
          (VarArrayDimCount(AKeyValues) = 1) and
          ((VarType(AKeyValues) and VarTypeMask) = varByte)) then
        V := AKeyValues[0]
      else
        V := AKeyValues;
      oFld := InternalFieldByName(AKeyFields, 'LocateRecord(AKeyFields)');
      if not oFld.Validating then
        oFld.Value := V
      else
        FLocateRow.SetValues(AKeyFields, V);
    end
    else
      FieldValues[AKeyFields] := AKeyValues;
  finally
    EndForceRow;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.LocateRecord(const AKeyFields: string;
  const AKeyValues: Variant; AOptions: TFDDataSetLocateOptions;
  var AIndex: Integer): Boolean;
var
  opts: TFDLocateOptions;
begin
  try
    InitLocateRow(AKeyFields, AKeyValues);
    FLocateColumns.Fill(FTable, AKeyFields);
  except
    on E: EFDException do
      if E.FDCode = er_FD_NameNotFound then begin
        Result := LocateRecord(ConditionsToExpression(AKeyFields, AKeyValues,
          lxoPartialKey in AOptions), AOptions, AIndex);
        Exit;
      end
      else
        raise;
  end;

  opts := [];
  if lxoCaseInsensitive in AOptions then
    Include(opts, loNoCase);
  if lxoPartialKey in AOptions then
    Include(opts, loPartial);
  if lxoFromCurrent in AOptions then
    Include(opts, loFromCurrent);
  if lxoBackward in AOptions then
    Include(opts, loBackward);

  FSourceView.Search(FLocateRow, FLocateColumns, nil, -1, opts, AIndex, Result);
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.LocateRecord(const AExpression: string;
  AOptions: TFDDataSetLocateOptions; var AIndex: Integer): Boolean;
var
  expOpts: TFDExpressionOptions;
begin
  expOpts := [];
  if lxoCaseInsensitive in AOptions then
    Include(expOpts, ekNoCase);
  if lxoPartialKey in AOptions then
    Include(expOpts, ekPartial);

  if FSourceViewLocator = nil then begin
    FSourceViewLocator := TFDDatSMechFilter.Create;
    FSourceViewLocator.Locator := True;
    FSourceView.Mechanisms.Add(FSourceViewLocator);
  end;
  FSourceViewLocator.Expression := AExpression;
  FSourceViewLocator.OnFilterRow := nil;
  FSourceViewLocator.Options := expOpts;
  try
    FSourceViewLocator.Active := True;
  except
    FDFreeAndNil(FSourceViewLocator);
    raise;
  end;

  Result := FSourceView.Locate(AIndex, not (lxoBackward in AOptions),
    not (lxoFromCurrent in AOptions));
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.Locate(const AKeyFields: string; const AKeyValues: Variant;
  AOptions: TLocateOptions = []): Boolean;
var
  eOptions: TFDDataSetLocateOptions;
begin
  eOptions := [];
  if loCaseInsensitive in AOptions then
    Include(eOptions, lxoCaseInsensitive);
  if loPartialKey in AOptions then
    Include(eOptions, lxoPartialKey);
  Result := LocateEx(AKeyFields, AKeyValues, eOptions);
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.BeginLocate(AOptions: TFDDataSetLocateOptions;
  ApRecordIndex: PInteger): Integer;
begin
  CheckActive;
  SetFound(False);
  if ApRecordIndex <> nil then begin
    if not (lxoFromCurrent in AOptions) then
      ApRecordIndex^ := -1;
    Result := ApRecordIndex^;
  end
  else begin
    if not (lxoCheckOnly in AOptions) then begin
      CheckBrowseMode;
      DoBeforeScroll;
    end;
    if not (lxoFromCurrent in AOptions) then
      Result := -1
    else begin
      UpdateCursorPos;
      Result := FRecordIndex;
    end;
    if not (lxoCheckOnly in AOptions) then
      CursorPosChanged;
  end;
  if not (lxoNoFetchAll in AOptions) then
    CheckFetchedAll;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.EndLocate(AResult: Boolean; APos: Integer;
  AOptions: TFDDataSetLocateOptions; ApRecordIndex: PInteger);
var
  eMode: TResyncMode;
begin
  SetFound(AResult);
  if AResult then
    if ApRecordIndex <> nil then
      ApRecordIndex^ := APos
    else
      if not (lxoCheckOnly in AOptions) then begin
        FRecordIndex := APos;
        eMode := [rmCenter];
        if APos <> -1 then
          Include(eMode, rmExact);
        Resync(eMode);
        DoAfterScroll;
      end;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.LocateEx(const AKeyFields: string; const AKeyValues: Variant;
  AOptions: TFDDataSetLocateOptions = []; ApRecordIndex: PInteger = nil): Boolean;
var
  iPos: Integer;
begin
  iPos := BeginLocate(AOptions, ApRecordIndex);
  Result := LocateRecord(AKeyFields, AKeyValues, AOptions, iPos);
  EndLocate(Result, iPos, AOptions, ApRecordIndex);
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.LocateEx(const AExpression: string;
  AOptions: TFDDataSetLocateOptions = []; ApRecordIndex: PInteger = nil): Boolean;
var
  iPos: Integer;
begin
  iPos := BeginLocate(AOptions, ApRecordIndex);
  Result := LocateRecord(AExpression, AOptions, iPos);
  EndLocate(Result, iPos, AOptions, ApRecordIndex);
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.Lookup(const AKeyFields: string; const AKeyValues: Variant;
  const AResultFields: string): Variant;
begin
  Result := LookupEx(AKeyFields, AKeyValues, AResultFields, []);
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.BeginLookup(AOptions: TFDDataSetLocateOptions;
  ApRecordIndex: PInteger): Integer;
begin
  if ApRecordIndex <> nil then begin
    if not (lxoFromCurrent in AOptions) then
      ApRecordIndex^ := -1;
    Result := ApRecordIndex^;
  end
  else begin
    if not (lxoCheckOnly in AOptions) then begin
      CheckBrowseMode;
      CursorPosChanged;
    end;
    if lxoFromCurrent in AOptions then begin
      UpdateCursorPos;
      Result := FRecordIndex;
    end
    else
      Result := -1;
  end;
  if not (lxoNoFetchAll in AOptions) then
    CheckFetchedAll;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.EndLookup(AResult: Boolean; APos: Integer;
  const AResultFields: string; ApRecordIndex: PInteger): Variant;
begin
  if AResult then begin
    if ApRecordIndex <> nil then
      ApRecordIndex^ := APos;
    BeginForceRow(FSourceView.Rows.ItemsI[APos], False, True);
    try
      Result := FieldValues[AResultFields];
    finally
      EndForceRow;
    end;
  end
  else
    Result := Null;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.LookupEx(const AKeyFields: string; const AKeyValues: Variant;
  const AResultFields: string; AOptions: TFDDataSetLocateOptions = [];
  ApRecordIndex: PInteger = nil): Variant;
var
  iPos: Integer;
begin
  iPos := BeginLookup(AOptions, ApRecordIndex);
  Result := EndLookup(LocateRecord(AKeyFields, AKeyValues, AOptions, iPos),
    iPos, AResultFields, ApRecordIndex);
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.LookupEx(const AExpression, AResultFields: string;
  AOptions: TFDDataSetLocateOptions; ApRecordIndex: PInteger): Variant;
var
  iPos: Integer;
begin
  iPos := BeginLookup(AOptions, ApRecordIndex);
  Result := EndLookup(LocateRecord(AExpression, AOptions, iPos),
    iPos, AResultFields, ApRecordIndex);
end;

{-------------------------------------------------------------------------------}
{ Filters }

procedure TFDDataSet.DoFilteringUpdated(AResync: Boolean);
begin
  if Active then begin
    CheckBrowseMode;
    CreateFilterView;
    RelinkViews;
    if AResync then
      ResyncViews;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.SafeFilteringUpdated;
begin
  try
    DoFilteringUpdated(True);
  except
    Filtered := False;
    raise;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.SetFilterOptions(AValue: TFilterOptions);
begin
  if AValue <> FilterOptions then begin
    inherited SetFilterOptions(AValue);
    if Filtered then
      SafeFilteringUpdated;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.SetFilterText(const AValue: string);
begin
  if AValue <> Filter then begin
    inherited SetFilterText(AValue);
    if Filtered then
      SafeFilteringUpdated;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.SetFiltered(AValue: Boolean);
begin
  if AValue <> Filtered then begin
    inherited SetFiltered(AValue);
    SafeFilteringUpdated;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.SetOnFilterRecord(const AValue: TFilterRecordEvent);
begin
  if TMethod(AValue) <> TMethod(OnFilterRecord) then begin
    inherited SetOnFilterRecord(AValue);
    if Filtered then
      SafeFilteringUpdated;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.DoFilterRow(AMech: TFDDatSMechFilter;
  ARow: TFDDatSRow; AVersion: TFDDatSRowVersion): Boolean;
var
  iSaveState: TDataSetState;
begin
  if (FBufferSize = 0) or (Fields.Count = 0) then begin
    Result := True;
    Exit;
  end;
  iSaveState := SetTempState(dsFilter);
  BeginForceRow(ARow, False, True);
  try
    Result := True;
    OnFilterRecord(Self, Result);
  except
    InternalHandleException;
  end;
  EndForceRow;
  RestoreState(iSaveState);
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.SetFilterChanges(const AValue: TFDUpdateRecordTypes);
begin
  if FFilterChanges <> AValue then begin
    CheckCachedUpdatesMode;
    FFilterChanges := AValue;
    DoFilteringUpdated(True);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.FindRecord(Restart, GoForward: Boolean): Boolean;
var
  oLct: TFDDatSMechFilter;
begin
  BeginLocate([lxoFromCurrent], nil);

  if not Filtered then
    try
      oLct := CreateFilterMech(FSourceViewLocator);
      if FSourceViewLocator = nil then begin
        FSourceViewLocator := oLct;
        FSourceViewLocator.Locator := True;
        FSourceView.Mechanisms.Add(FSourceViewLocator);
      end;
    except
      FDFreeAndNil(FSourceViewLocator);
      raise;
    end;

  Result := FSourceView.Locate(FRecordIndex, GoForward, Restart);
  EndLocate(Result, FRecordIndex, [], nil);
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.CreateExpression(const AExpr: String;
  AOptions: TFDExpressionOptions = []): IFDStanExpressionEvaluator;
var
  oParser: IFDStanExpressionParser;
begin
  FDCreateInterface(IFDStanExpressionParser, oParser);
  Result := oParser.Prepare(TFDDatSTableExpressionDS.Create(FTable),
    AExpr, AOptions, [poDefaultExpr], '');
  Result.DataSource.Position := GetRow;
end;

{-------------------------------------------------------------------------------}
{ Constraints }

{-------------------------------------------------------------------------------}
function TFDDataSet.IsCS: Boolean;
begin
  Result := Constraints.Count > 0;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.DisableConstraints;
begin
  if FConstDisableCount = 0 then
    if FTable <> nil then
      FTable.Constraints.Enforce := False;
  Inc(FConstDisableCount);
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.EnableConstraints;
begin
  if FConstDisableCount > 0 then begin
    Dec(FConstDisableCount);
    if FConstDisableCount = 0 then
      if FTable <> nil then
        FTable.Constraints.Enforce := True;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.GetConstraintsEnabled: Boolean;
begin
  Result := FConstDisableCount = 0;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.SetConstraintsEnabled(const AValue: Boolean);
begin
  if AValue <> ConstraintsEnabled then
    if AValue then
      while not ConstraintsEnabled do
        EnableConstraints
    else
      while ConstraintsEnabled do
        DisableConstraints;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.UpdateConstraints;
begin
  ResetTableConstraints;
  SetTableConstraints;
end;

{-------------------------------------------------------------------------------}
{ Cloning }

procedure TFDDataSet.GotoCurrent(ADataSet: TFDDataSet);
begin
  CheckBrowseMode;
  CheckFetchedAll;
  ADataSet.CheckActive;
  BookMark := ADataSet.BookMark;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.DoCloneCursor(AReset, AKeepSettings: Boolean);
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.CloneCursor(ASource: TFDDataSet; AReset,
  AKeepSettings: Boolean);
begin
  DisableControls;
  try
    if not (ASource.State in dsEditModes) then
      ASource.FetchAll;
    AttachTable(ASource.FTable, ASource.FView);
    FCloneSource := ASource;
    FParentDataSet := ASource.FParentDataSet;
    FieldDefs.Updated := False;
    OnFilterRecord := nil;
    if AReset then begin
      CachedUpdates := False;
      Filtered := False;
      Filter := '';
      FilterChanges := [rtUnmodified, rtModified, rtInserted];
      Indexes.Clear;
      IndexesActive := False;
      IndexName := '';
      Aggregates.Clear;
      AggregatesActive := False;
      Constraints.Clear;
      ConstraintsEnabled := True;
      MasterSource := nil;
      MasterFields := '';
      DetailFields := '';
      UpdateOptions.RestoreDefaults;
      FetchOptions.RestoreDefaults;
      ResourceOptions.RestoreDefaults;
      FormatOptions.RestoreDefaults;
    end
    else if not AKeepSettings then begin
      CachedUpdates := CachedUpdates or ASource.CachedUpdates;
      Filter := ASource.Filter;
      FilterOptions := ASource.FilterOptions;
      Filtered := ASource.Filtered;
      FilterChanges := ASource.FilterChanges;
      Indexes := ASource.Indexes;
      IndexesActive := ASource.IndexesActive;
      if ASource.IndexName <> '' then
        IndexName := ASource.IndexName
      else
        IndexFieldNames := ASource.IndexFieldNames;
      Aggregates := ASource.Aggregates;
      AggregatesActive := ASource.AggregatesActive;
      Constraints := ASource.Constraints;
      ConstraintsEnabled := ASource.ConstraintsEnabled;
      MasterSource := ASource.MasterSource;
      MasterFields := ASource.MasterFields;
      DetailFields := ASource.DetailFields;
      UpdateOptions := ASource.UpdateOptions;
      FetchOptions := ASource.FetchOptions;
      ResourceOptions := ASource.ResourceOptions;
      FormatOptions := ASource.FormatOptions;
    end;
    DoCloneCursor(AReset, AKeepSettings);
    Open;
    FTable.AddDataCallback(Self);
    ASource.FTable.AddDataCallback(ASource);
    // Set OnFilterRecord event handler after this dataset is open, otherwise
    // InternalOpen -> RelinkViews will activate FFilterView, it will call
    // OnFilterRecord and that may lead to AV, because there is no fields
    // and buffers.
    if not AReset and not AKeepSettings then
      OnFilterRecord := ASource.OnFilterRecord;
  finally
    EnableControls;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.TableDataChanged(ARow: TFDDatSRow; AChangeKind: TFDDatSRowState);
begin
  try
    // When this dataset was cloned, it has a callback. And GetRow.Delete
    // fires this handler. So, InternalDelete losts position and record
    // remains in change log. dfDeleting protects against that.
    if (State = dsBrowse) and not (dfDeleting in FFlags) then begin
      UpdateCursorPos;
      Resync([]);
      UpdateCursorPos;
    end;
  except
  end;
end;

{-------------------------------------------------------------------------------}
{ Dataset creating }

procedure TFDDataSet.InitChildTable(ADatSManager: TFDDatSManager;
  AParTable: TFDDatSTable; AParColumn: TFDDatSColumn; ADefs: TObject;
  AArraySize: Integer);
var
  oChildTab: TFDDatSTable;
  oChildTabRelCol: TFDDatSColumn;
  oRel: TFDDatSRelation;
begin
  oChildTab := TFDDatSTable.Create;
  oChildTab.CountRef;
  oChildTab.Setup(GetOptionsIntf);
  oChildTab.Name := ADatSManager.Tables.BuildUniqueName(
    C_FD_SysNamePrefix + '#' + AParTable.Name + '#' + AParColumn.Name);
  ADatSManager.Tables.Add(oChildTab);

  if ADefs is TFieldDefs then
    InitColumnsFromFieldDefs(TFieldDefs(ADefs), oChildTab, ADatSManager, AArraySize)
  else if ADefs is TFDDatSTable then begin
    oChildTab.Columns.Assign(TFDDatSTable(ADefs).Columns);
    FDFree(oChildTab.Columns.ItemsI[oChildTab.Columns.Count - 1]);
  end;

  oChildTabRelCol := TFDDatSColumn.Create;
  oChildTabRelCol.Name := oChildTab.Columns.BuildUniqueName(
    C_FD_SysNamePrefix + '#' + AParColumn.Name);
  oChildTabRelCol.DataType := dtParentRowRef;
  oChildTabRelCol.Attributes := AParColumn.Attributes + [caInternal] - [caSearchable];
  oChildTab.Columns.Add(oChildTabRelCol);

  oRel := TFDDatSRelation.Create;
  oRel.Name := ADatSManager.Relations.BuildUniqueName(
    C_FD_SysNamePrefix + '#' + AParTable.Name + '#' + AParColumn.Name);
  oRel.Nested := True;
  oRel.ParentTable := AParTable;
  oRel.ParentColumnNames := AParColumn.Name;
  oRel.ChildTable := oChildTab;
  oRel.ChildColumnNames := oChildTabRelCol.Name;
  ADatSManager.Relations.Add(oRel);

  if ADefs is TFDDatSTable then
    InitChildTables(ADatSManager, oChildTab, TFDDatSTable(ADefs));
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.InitChildTables(ADatSManager: TFDDatSManager;
  AParTable, ASrcTable: TFDDatSTable);
var
  i: Integer;
  oCol: TFDDatSColumn;
  oNestTable: TFDDatSTable;
begin
  for i := 0 to ASrcTable.Columns.Count - 1 do begin
    oCol := ASrcTable.Columns.ItemsI[i];
    if oCol.DataType in [dtRowSetRef, dtCursorRef, dtRowRef, dtArrayRef] then begin
      oNestTable := oCol.NestedTable;
      if oNestTable <> nil then
        InitChildTable(ADatSManager, AParTable, oCol, oNestTable, 1);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.InitColumnsFromFieldDefs(ADefs: TFieldDefs; ATable: TFDDatSTable;
  ADatSManager: TFDDatSManager; AArraySize: Integer);
var
  oFmtOpts: TFDFormatOptions;
  oUpdOpts: TFDBottomUpdateOptions;
  i: Integer;
  oDef: TFieldDef;
  oCol: TFDDatSColumn;
  eDestDataType: TFDDataType;
  iDestScale, iDestPrec: Integer;
  iDestSize: LongWord;
  esDestAttrs: TFDDataAttributes;
begin
  ATable.Setup(GetOptionsIntf);
  oFmtOpts := FormatOptions;
  oUpdOpts := UpdateOptions;
  for i := 0 to ADefs.Count * AArraySize - 1 do begin
    oDef := ADefs[i mod ADefs.Count];
    oFmtOpts.FieldDef2ColumnDef(oDef, eDestDataType, iDestSize, iDestPrec,
      iDestScale, esDestAttrs);
    oCol := TFDDatSColumn.Create;
    if AArraySize > 1 then
      oCol.Name := Format('%s[%d]', [oDef.Name, i div ADefs.Count])
    else
      oCol.Name := oDef.Name;
    oCol.DataType := eDestDataType;
    oCol.Size := iDestSize;
    oCol.Precision := iDestPrec;
    oCol.Scale := iDestScale;
    if not (faRequired in oDef.Attributes) then
      Include(esDestAttrs, caAllowNull);
    if faReadonly in oDef.Attributes then
      Include(esDestAttrs, caReadOnly);
    if faHiddenCol in oDef.Attributes then
      Include(esDestAttrs, caInternal);
    if faUnnamed in oDef.Attributes then
      Include(esDestAttrs, caUnnamed);
    if oDef.InternalCalcField then
      Include(esDestAttrs, caCalculated)
    else
      Include(esDestAttrs, caBase);
    if not (eDestDataType in [dtRowSetRef, dtCursorRef, dtRowRef, dtArrayRef]) then
      Include(esDestAttrs, caSearchable);
    if (oDef.DataType = ftAutoInc) or
       (oUpdOpts.AutoIncFields <> '') and
       FDFieldInFieldNames(oUpdOpts.AutoIncFields, oCol.Name) then begin
      esDestAttrs := esDestAttrs + [caAutoInc, caAllowNull];
      oCol.AutoIncrement := True;
    end;
    oCol.Attributes := esDestAttrs;
    if (oUpdOpts.KeyFields <> '') and
       FDFieldInFieldNames(oUpdOpts.KeyFields, oCol.Name) then
      oCol.Options := oCol.Options + [coInKey];
    oCol.SourceID := oDef.FieldNo;
    ATable.Columns.Add(oCol);

    if ADatSManager <> nil then
      if eDestDataType in [dtRowSetRef, dtCursorRef, dtRowRef] then
        InitChildTable(ADatSManager, ATable, oCol, oDef.ChildDefs, 1)
      else if eDestDataType = dtArrayRef then
        InitChildTable(ADatSManager, ATable, oCol, oDef.ChildDefs, Max(oDef.Size, 1));
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.InitTable(ATable: TFDDatSTable; AWithFields: Boolean);
var
  oTab: TFDDatSTable;
  oSch: TFDDatSManager;
  sName: String;
  lDecRef: Boolean;
begin
  if AWithFields then begin
    if FieldDefs.Count = 0 then
      InitFieldDefsFromFields
  end;
  if ATable <> nil then
    oTab := ATable
  else
    oTab := TFDDatSTable.Create;
  lDecRef := not oTab.IsRefCounted;
  oSch := DoGetDatSManager;
  try
    if lDecRef then
      oTab.CountRef;
    oTab.Setup(GetOptionsIntf);
    sName := Name;
    if sName = '' then
      sName := C_FD_SysNamePrefix + 'TAB';
    if (oSch <> nil) and (oTab.Manager <> oSch) then begin
      oTab.Name := oSch.Tables.BuildUniqueName(sName);
      oSch.Tables.Add(oTab);
    end
    else
      oTab.Name := sName;
    if AWithFields then
      if oTab.Columns.Count = 0 then
        InitColumnsFromFieldDefs(FieldDefs, oTab, oSch, 1);
  except
    if oTab <> ATable then
      FDFree(oTab);
    raise;
  end;
  AttachTable(oTab, nil);
  if lDecRef then
    oTab.RemRef;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.CreateDataSet;
begin
  CheckInactive;
  Active := True;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.GetExists: Boolean;
begin
  Result := True;
end;

{-------------------------------------------------------------------------------}
{ Streaming }

procedure TFDDataSet.LoadFromStorage(AStream: TStream; const AFileName: String;
  AFormat: TFDStorageFormat);
begin
  ASSERT(DatSManager <> nil);
  DisableControls;
  StartWait;
  try
    if ResetAtLoading then begin
      Close;
      FieldDefs.Updated := False;
      IndexDefs.Updated := False;
      DataSetField := nil;
    end
    else
      CheckBrowseMode;
    FStorage := ResourceOptions.GetStorage(AFileName, AFormat);
    try
      FStorage.Open(ResourceOptions, FEncoder, AFileName, AStream, smRead);
      if ResetAtLoading then
        Active := True
      else begin
        InternalLoadFromStorage;
        Resync([]);
      end;
    finally
      FStorage := nil;
    end;
  finally
    StopWait;
    EnableControls;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.SaveToStorage(const AFileName: String; AStream: TStream;
  AFormat: TFDStorageFormat);
begin
  ASSERT(DatSManager <> nil);
  StartWait;
  try
    if Active then begin
      CheckBrowseMode;
      CheckFetchedAll;
    end;
    FStorage := ResourceOptions.GetStorage(AFileName, AFormat);
    try
      FStorage.Open(ResourceOptions, FEncoder, AFileName, AStream, smWrite);
      InternalSaveToStorage;
    finally
      FStorage := nil;
    end;
  finally
    StopWait;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.InternalLoadFromStorage;
var
  oTabs: TFDDatSTableArray;
begin
  if FStorage.IsStored(siMeta) then begin
    DatSManager.LoadFromStorage(FStorage, ResourceOptions.StoreMergeData,
      ResourceOptions.StoreMergeMeta, [moPreserveState]);
    if ResetAtLoading then begin
      oTabs := DatSManager.RootTables;
      if Length(oTabs) > 0 then
        AttachTable(oTabs[0], nil);
    end;
  end
  else begin
    if ResetAtLoading then
      InternalDefineDatSManager;
    DatSManager.LoadFromStorage(FStorage, ResourceOptions.StoreMergeData,
      ResourceOptions.StoreMergeMeta, [moPreserveState]);
  end;
  FLastSavePoint := DatSManager.Updates.SavePoint;
  FSourceEOF := True;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.InternalSaveToStorage;
begin
  try
    if FStorage.IsStored(siVisible) and (SourceView <> nil) then
      FStorage.AddFilterObj(Table, SourceView);
    DatSManager.SaveToStorage(FStorage);
    FLastSavePoint := DatSManager.Updates.SavePoint;
  finally
    FStorage.RemoveFilterObj(Table);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.LoadFromStream(AStream: TStream; AFormat: TFDStorageFormat);
begin
  LoadFromStorage(AStream, '', AFormat);
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.LoadFromFile(const AFileName: String; AFormat: TFDStorageFormat);
begin
  LoadFromStorage(nil, AFileName, AFormat);
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.SaveToStream(AStream: TStream; AFormat: TFDStorageFormat);
begin
  SaveToStorage('', AStream, AFormat);
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.SaveToFile(const AFileName: String; AFormat: TFDStorageFormat);
begin
  SaveToStorage(AFileName, nil, AFormat);
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.LoadFromFileAtOpen: Boolean;
begin
  Result := (DataSetField = nil) and (ParentDataSet = nil) and (DatSManager <> nil) and
    (FStorage = nil) and ResourceOptions.Persistent and FileExists(ResourceOptions.ResolveFileName());
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.SaveToFileAtClose: Boolean;
begin
  Result := (DataSetField = nil) and (ParentDataSet = nil) and (DatSManager <> nil) and
    (FStorage = nil) and ResourceOptions.Persistent and (ResourceOptions.ResolveFileName() <> '') and
    ((FLastSavePoint < DatSManager.Updates.SavePoint) or
     not FileExists(ResourceOptions.ResolveFileName()));
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.ResetAtLoading: Boolean;
begin
  Result := not ResourceOptions.StoreMerge or not Active;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.SaveToDFM(const AAncestor: TFDDataSet): Boolean;
begin
  Result := False; // nothing more
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.DefineProperties(AFiler: TFiler);
var
  oAnc: TFDDataSet;
begin
  inherited DefineProperties(AFiler);
  if AFiler.Ancestor is TFDDataSet then
    oAnc := TFDDataSet(AFiler.Ancestor)
  else
    oAnc := nil;
  AFiler.DefineBinaryProperty('Content', ReadContent, WriteContent, SaveToDFM(oAnc));
  AFiler.DefineProperty('DataSource', ReadDataSource, nil, False);
  AFiler.DefineProperty('ReadOnly', ReadReadOnly, nil, False);
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.ReadContent(AReader: TStream);
var
  oCont: TMemoryStream;
begin
  oCont := TMemoryStream.Create;
  oCont.CopyFrom(AReader, 0);
  oCont.Position := 0;
  FStorage := ResourceOptions.GetStorage('', sfBinary);
  FStorage.Open(ResourceOptions, FEncoder, '', oCont, smRead);
  FStorage.OwnStream := True;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.WriteContent(AWriter: TStream);
begin
  SaveToStream(AWriter, sfBinary);
end;

{-------------------------------------------------------------------------------}
type
  __TReader = class(TReader);

procedure TFDDataSet.ReadDataSource(AReader: TReader);
begin
  __TReader(AReader).ReadPropValue(Self, GetPropInfo(Self, 'MasterSource'));
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.ReadReadOnly(AReader: TReader);
begin
  UpdateOptions.ReadOnly := AReader.ReadBoolean;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.StoredActivate(AInherited: TProc);
begin
  try
    AInherited();
    try
      if (dfStreamedActive in FFlags) and DoStoredActivation then
        Active := True;
    except
      if csDesigning in ComponentState then
        FDHandleException
      else
        raise;
    end;
  finally
    Exclude(FFlags, dfStreamedActive);
    FStorage := nil;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.Loaded;
begin
  StoredActivate(
    procedure
    begin
      inherited Loaded;
    end
  );
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.Updated;
begin
  StoredActivate(
    procedure
    begin
      inherited Updated;
    end
  );
end;

{-------------------------------------------------------------------------------}
{ Delta management }

type
  TFDDataSetIntfImpl = class(TInterfacedObject, IFDDataSetReference)
  private
    FView: TFDDatSView;
  protected
    { IFDDataSetReference }
    function GetDataView: TFDDatSView;
  public
    constructor Create(AView: TFDDatSView);
    destructor Destroy; override;
  end;

{-------------------------------------------------------------------------------}
constructor TFDDataSetIntfImpl.Create(AView: TFDDatSView);
begin
  inherited Create;
  FView := AView;
end;

{-------------------------------------------------------------------------------}
destructor TFDDataSetIntfImpl.Destroy;
begin
  FView := nil;
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TFDDataSetIntfImpl.GetDataView: TFDDatSView;
begin
  Result := FView;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.GetData: IFDDataSetReference;
begin
  CheckBrowseMode;
  if FView <> nil then
    Result := TFDDataSetIntfImpl.Create(FView)
  else if FTable <> nil then
    Result := TFDDataSetIntfImpl.Create(FTable.FullView)
  else
    Result := TFDDataSetIntfImpl.Create(nil);
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.GetFilteredData: IFDDataSetReference;
begin
  CheckBrowseMode;
  if FSourceView <> nil then
    Result := TFDDataSetIntfImpl.Create(FSourceView)
  else
    Result := GetData;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.GetDataView: TFDDatSView;
begin
  Result := FilteredData.GetDataView;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.SetData(const AValue: IFDDataSetReference);
var
  oView: TFDDatSView;
begin
  CheckInactive;
  if (AValue <> nil) and (AValue.DataView <> nil) then begin
    InitTable(nil, False);
    oView := AValue.DataView;
    if oView.Table.HasChanges([rsInserted, rsDeleted, rsModified]) then
      CachedUpdates := True;
    FTable.SourceName := oView.Table.ActualOriginName;
    FTable.Columns.Assign(oView.Table.Columns);
    if DoGetDatSManager <> nil then
      InitChildTables(DoGetDatSManager, FTable, oView.Table);
    FTable.Import(oView);
    FieldDefs.Updated := False;
    Open;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.GetDelta: IFDDataSetReference;
var
  oView: TFDDatSView;
begin
  CheckBrowseMode;
  if FTable <> nil then begin
    oView := FTable.GetChangesView();
    oView.Creator := vsDataSetDelta;
    Result := TFDDataSetIntfImpl.Create(oView);
  end
  else
    Result := TFDDataSetIntfImpl.Create(nil);
end;

{-------------------------------------------------------------------------------}
{ Cached updates }

procedure TFDDataSet.CheckCachedUpdatesMode;
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.DoApplyUpdates(ATable: TFDDatSTable; AMaxErrors: Integer): Integer;
var
  eAction: TFDErrorAction;
  oRow, oNextRow: TFDDatSRow;
  oJournal: TFDDatSUpdatesJournal;
begin
  Result := 0;
  oJournal := Updates;
  if oJournal = nil then
    Exit;
  oJournal.Lock;
  try
    oRow := oJournal.FirstChange(ATable);
    while oRow <> nil do begin
      oNextRow := oJournal.NextChange(oRow, ATable);
      try
        eAction := eaApplied;
        case oRow.RowState of
        rsInserted: DoUpdateRecordHandler(oRow, arInsert, [uoNoSrvRecord], eAction);
        rsDeleted:  DoUpdateRecordHandler(oRow, arDelete, [], eAction);
        rsModified: DoUpdateRecordHandler(oRow, arUpdate, [], eAction);
        else        eAction := eaSkip;
        end;
      except
        on E: Exception do begin
          if E is EFDException then
            oRow.RowError := EFDException(E);
          eAction := eaFail;
        end;
      end;
      if eAction = eaFail then begin
        Inc(Result);
        if (AMaxErrors <> -1) and (Result > AMaxErrors) then
          Exit;
      end;
      oRow := oNextRow;
    end;
  finally
    oJournal.Unlock;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.DoCachedUpdatesChanged;
var
  oFtch: TFDFetchOptions;
begin
  oFtch := FetchOptions;
  if CachedUpdates and not (fiDetails in oFtch.Cache) then
    oFtch.Cache := oFtch.Cache + [fiDetails];
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.GetCachedUpdates: Boolean;
begin
  Result := FCachedUpdates;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.SetCachedUpdates(const AValue: Boolean);
begin
  if FCachedUpdates <> AValue then begin
    if not AValue and UpdatesPending then
      FDException(Self, [S_FD_LComp, S_FD_LComp_PDS], er_FD_DSCantOffCachedUpdates,
        [GetDisplayName]);
    FCachedUpdates := AValue;
    DoCachedUpdatesChanged;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.GetUpdates: TFDDatSUpdatesJournal;
begin
  Result := nil;
  if FTable <> nil then begin
    if FTable.UpdatesRegistry then
      Result := FTable.Updates
    else if (FTable.Manager <> nil) and FTable.Manager.UpdatesRegistry then
      Result := FTable.Manager.Updates;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.GetSavePoint: Int64;
begin
  CheckBrowseMode;
  CheckCachedUpdatesMode;
  if Updates <> nil then
    Result := Updates.SavePoint
  else
    Result := -1;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.SetSavePoint(const AValue: Int64);
begin
  Cancel;
  CheckBrowseMode;
  CheckCachedUpdatesMode;
  UpdateCursorPos;
  if (AValue <> -1) and (Updates <> nil) then begin
    Updates.SavePoint := AValue;
    CursorPosChanged;
    Resync([]);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.GetUpdatesPending: Boolean;
begin
  Result := False;
  if Active and (Updates <> nil) then
    Result := Updates.FirstChange(FTable) <> nil;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.GetChangeCount: Integer;
begin
  Result := 0;
  if Active and (Updates <> nil) then
    Result := Updates.GetCount(FTable);
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.RevertRecord;
var
  oRow: TFDDatSRow;
begin
  Cancel;
  CheckBrowseMode;
  CheckCachedUpdatesMode;
  UpdateCursorPos;
  if (FRecordIndex >= 0) and (FRecordIndex < FSourceView.Rows.Count) then begin
    oRow := FSourceView.Rows.ItemsI[FRecordIndex];
    if oRow.RowState in [rsInserted, rsDeleted, rsModified] then begin
      oRow.RejectChanges;
      CursorPosChanged;
      Resync([]);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.CommitUpdates;
begin
  CheckBrowseMode;
  CheckCachedUpdatesMode;
  if Updates <> nil then begin
    Updates.AcceptChanges(FTable);
    UpdateCursorPos;
    Resync([]);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.UndoLastChange(AFollowChange: Boolean): Boolean;
var
  oRow: TFDDatSRow;
begin
  Cancel;
  CheckBrowseMode;
  CheckCachedUpdatesMode;
  UpdateCursorPos;
  Result := UpdatesPending;
  if Result then begin
    oRow := Updates.LastChange(FTable);
    if oRow.RowState = rsDeleted then begin
      oRow.RejectChanges;
      FRecordIndex := FSourceView.IndexOf(oRow);
    end
    else begin
      FRecordIndex := FSourceView.IndexOf(oRow);
      oRow.RejectChanges;
    end;
    if AFollowChange and (FRecordIndex <> -1) then begin
      CursorPosChanged;
      Resync([]);
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.CancelUpdates;
begin
  SetSavePoint(0);
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.DoBeforeApplyUpdate;
begin
  if Assigned(FBeforeApplyUpdates) then
    FBeforeApplyUpdates(Self);
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.DoAfterApplyUpdate(AErrors: Integer);
begin
  if Assigned(FAfterApplyUpdates) then
    FAfterApplyUpdates(Self, AErrors);
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.ApplyUpdatesComplete(AMaxErrors, AErrors: Integer);
var
  lSuccess: Boolean;
begin
  DoAfterApplyUpdate(AErrors);
  if FParentDataSet = nil then begin
    lSuccess := (AMaxErrors = -1) or (AErrors <= AMaxErrors);
    if lSuccess and UpdateOptions.AutoCommitUpdates or Table.HasErrors then
      DoReconcile(lSuccess, False);
  end
  else
    Resync([]);
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.ApplyUpdates(AMaxErrors: Integer = -1): Integer;
begin
  StartWait;
  try
    DoBeforeApplyUpdate;
    CheckBrowseMode;
    CheckCachedUpdatesMode;
    UpdateCursorPos;
    ClearRecordIndex;
    if FParentDataSet <> nil then
      Result := FParentDataSet.ApplyUpdates(AMaxErrors)
    else
      Result := DoApplyUpdates(FTable, AMaxErrors);
    if not DoIsSourceAsync then
      ApplyUpdatesComplete(AMaxErrors, Result);
  finally
    StopWait;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.DoReconcile(AOnSuccess, ACommitApplied: Boolean): Boolean;
var
  oRow, oNextRow: TFDDatSRow;
  iAction: TFDDAptReconcileAction;
  oWait: IFDGUIxWaitCursor;
  oJournal: TFDDatSUpdatesJournal;
begin
  CheckBrowseMode;
  CheckCachedUpdatesMode;
  oJournal := Updates;
  if oJournal = nil then begin
    Result := True;
    Exit;
  end;
  oJournal.Lock;
  try
    oRow := oJournal.FirstChange(FTable);
    while oRow <> nil do begin
      oNextRow := oJournal.NextChange(oRow, FTable);
      if oRow.HasErrors then begin
        if not ResourceOptions.ActualSilentMode then begin
          FDCreateInterface(IFDGUIxWaitCursor, oWait);
          oWait.PushWait;
        end;
        try
          iAction := raSkip;
          DoReconcileErrorHandler(oRow, oRow.RowError, oRow.RowState, iAction);
        finally
          if not ResourceOptions.ActualSilentMode then
            oWait.PopWait;
        end;
        case iAction of
        raSkip:
          ;
        raAbort:
          Break;
        raMerge:
          begin
            oRow.ClearErrors;
            oRow.AcceptChanges;
          end;
        raCorrect:
          oRow.ClearErrors;
        raCancel:
          begin
            oRow.ClearErrors;
            oRow.RejectChanges;
          end;
        raRefresh:
          begin
            oRow.ClearErrors;
            BeginForceRow(oRow, False, True);
            try
              RefreshRecord;
            finally
              EndForceRow;
            end;
          end;
        end;
      end
      else if AOnSuccess and UpdateOptions.AutoCommitUpdates or ACommitApplied then
        oRow.AcceptChanges;
      oRow := oNextRow;
    end;
  finally
    oJournal.Unlock;
  end;
  Result := not oJournal.HasChanges(FTable);
  UpdateCursorPos;
  Resync([]);
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.Reconcile(ACommitApplied: Boolean = False): Boolean;
begin
  Result := DoReconcile(False, ACommitApplied);
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.UpdateStatus: TUpdateStatus;
var
  pBuff: TRecBuf;
  oRow: TFDDatSRow;
  iRowState: TFDDatSRowState;
begin
  if not Active then
    Result := usUnmodified
  else if State = dsInternalCalc then
    Result := usUnmodified
  else begin
    if State = dsCalcFields then
      pBuff := CalcBuffer
    else
      pBuff := ActiveBuffer;
    oRow := GetRow(pBuff, False);
    if oRow = nil then
      Result := usUnmodified
    else begin
      if oRow.RowState in [rsEditing, rsCalculating, rsChecking] then
        iRowState := oRow.RowPriorState
      else
        iRowState := oRow.RowState;
      if iRowState = rsModified then
        Result := usModified
      else if (iRowState = rsDetached) and (State = dsInsert) then
        Result := usInserted
      else if iRowState in [rsDetached, rsDeleted] then
        Result := usDeleted
      else if iRowState = rsInserted then
        Result := usInserted
      else
        Result := usUnmodified;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.GetRowError: EFDException;
var
  oRow: TFDDatSRow;
  pBuff: TRecBuf;
begin
  Result := nil;
  if Active then begin
    if State in [dsCalcFields, dsInternalCalc] then
      pBuff := CalcBuffer
    else
      pBuff := ActiveBuffer;
    oRow := GetRow(pBuff, False);
    if oRow <> nil then
      Result := oRow.RowError;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.GetCommandStates(const ACommand: String): TDataSetCommandStates;
begin
  if SameText(ACommand, sApplyUpdatesDataSetCommand) or
     SameText(ACommand, sCancelUpdatesDataSetCommand) then begin
    Result := [dcSupported];
    if UpdatesPending then
      Include(Result, dcEnabled);
  end
  else
    Result := [];
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.ExecuteCommand(const ACommand: String; const AArgs: array of const);
var
  iMaxErrors: Integer;
begin
  if SameText(ACommand, sApplyUpdatesDataSetCommand) then begin
    if Length(AArgs) = 1 then
      iMaxErrors := AArgs[0].VInteger
    else
      iMaxErrors := -1;
    ApplyUpdates(iMaxErrors);
  end
  else if SameText(ACommand, sCancelUpdatesDataSetCommand) then
    CancelUpdates;
end;

{-------------------------------------------------------------------------------}
{ Batch changes }
type
  TFDDataSetDataLoadSave = record
    FIndActive: Boolean;
    FAggActive: Boolean;
    FSilentMode: Boolean;
    FWaitCounter: Integer;
    FRefreshMode: TFDRefreshMode;
    FUpdateChangedFields: Boolean;
    FLockMode: TFDLockMode;
    FUpdateMode: TUpdateMode;
    FCheckRequired: Boolean;
    FCheckReadOnly: Boolean;
    FCheckUpdatable: Boolean;
    FState: TFDDatSLoadState;
  end;
  PFDDataSetDataLoadSave = ^TFDDataSetDataLoadSave;

procedure TFDDataSet.BeginBatch(AWithDelete: Boolean = False);
var
  oUpdOpts: TFDUpdateOptions;
  pState: PFDDataSetDataLoadSave;
begin
  CheckBrowseMode;
  if FDataLoadSave <> nil then
    Exit;
  SetUpdateFieldAttributes;
  GetMem(FDataLoadSave, SizeOf(TFDDataSetDataLoadSave));
  FillChar(FDataLoadSave^, SizeOf(TFDDataSetDataLoadSave), 0);
  pState := PFDDataSetDataLoadSave(FDataLoadSave);

  DisableControls;
  DisableConstraints;
  pState^.FIndActive := IndexesActive;
  IndexesActive := False;
  pState^.FAggActive := AggregatesActive;
  AggregatesActive := False;
  if AWithDelete then
    FTable.BeginLoadData(pState^.FState, lmMove)
  else
    FTable.BeginLoadData(pState^.FState);
  pState^.FSilentMode := ResourceOptions.SilentMode;
  ResourceOptions.SilentMode := True;
  pState^.FWaitCounter := FWaitCounter;
  FWaitCounter := -1;
  oUpdOpts := GetUpdateOptions;
  if oUpdOpts <> nil then begin
    pState^.FRefreshMode := oUpdOpts.RefreshMode;
    pState^.FUpdateChangedFields := oUpdOpts.UpdateChangedFields;
    pState^.FLockMode := oUpdOpts.LockMode;
    pState^.FUpdateMode := oUpdOpts.UpdateMode;
    pState^.FCheckRequired := oUpdOpts.CheckRequired;
    pState^.FCheckReadOnly := oUpdOpts.CheckReadOnly;
    pState^.FCheckUpdatable := oUpdOpts.CheckUpdatable;
    oUpdOpts.FastUpdates := True;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.EndBatch;
var
  oUpdOpts: TFDUpdateOptions;
  pState: PFDDataSetDataLoadSave;
begin
  if FDataLoadSave = nil then
    Exit;
  try
    pState := PFDDataSetDataLoadSave(FDataLoadSave);
    oUpdOpts := GetUpdateOptions;
    if oUpdOpts <> nil then begin
      oUpdOpts.RefreshMode := pState^.FRefreshMode;
      oUpdOpts.UpdateChangedFields := pState^.FUpdateChangedFields;
      oUpdOpts.LockMode := pState^.FLockMode;
      oUpdOpts.UpdateMode := pState^.FUpdateMode;
      oUpdOpts.CheckRequired := pState^.FCheckRequired;
      oUpdOpts.CheckReadOnly := pState^.FCheckReadOnly;
      oUpdOpts.CheckUpdatable := pState^.FCheckUpdatable;
    end;
    FWaitCounter := pState^.FWaitCounter;
    ResourceOptions.SilentMode := pState^.FSilentMode;
    if Active then begin
      FTable.EndLoadData(pState^.FState);
      IndexesActive := pState^.FIndActive;
      AggregatesActive := pState^.FAggActive;
    end
    else begin
      FIndexesActive := pState^.FIndActive;
      FAggregatesActive := pState^.FAggActive;
    end;
    EnableConstraints;
    if Active then
      Resync([]);
    EnableControls;
  finally
    FreeMem(FDataLoadSave, SizeOf(TFDDataSetDataLoadSave));
    FDataLoadSave := nil;
  end;
end;

{-------------------------------------------------------------------------------}
{ IProviderSupport }

procedure TFDDataSet.PSExecute;
begin
  Execute;
end;

{-------------------------------------------------------------------------------}
procedure TFDDataSet.PSReset;
begin
  inherited PSReset;
  if Active and FetchOptions.AutoClose then begin
    Close;
    Open;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.PSGetDefaultOrder: TIndexDef;
begin
  Result := nil;
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.PSGetIndexDefs(IndexTypes: TIndexOptions): TIndexDefs;
begin
  Result := GetIndexDefs(IndexDefs, IndexTypes);
end;

{-------------------------------------------------------------------------------}
{$WARN SYMBOL_DEPRECATED OFF}
function TFDDataSet.PSGetKeyFields: String;
begin
  if Fields.Count = 0 then begin
    Result := UpdateOptions.KeyFields;
    Exit;
  end;
  Result := inherited PSGetKeyFields;
end;
{$WARN SYMBOL_DEPRECATED ON}

{-------------------------------------------------------------------------------}
function TFDDataSet.DoGetTableName: String;
begin
  // nothing
  Result := '';
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.PSGetTableName: String;
begin
  Result := UpdateOptions.UpdateTableName;
  if (Result = '') and (FTable <> nil) then
    Result := FTable.ActualOriginName;
  if Result = '' then
    Result := DoGetTableName;
  // Remove '[' and ']', because TSQLResolver.InitTreeData is not recognizing
  // them as the quote chars, and will enclose already quoted table name into '"'.
  if (Result <> '') and (Result[1] = '[') and (Pos(']', Result) = Length(Result)) then
    Result := Copy(Result, 2, Length(Result) - 2);
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.PSGetUpdateException(E: Exception; Prev: EUpdateError): EUpdateError;
var
  PrevErr: Integer;
begin
  if Prev <> nil then
    PrevErr := Prev.ErrorCode
  else
    PrevErr := 0;
  if (E is EFDDBEngineException) and (EFDDBEngineException(E).ErrorCount > 0) then
    Result := EUpdateError.Create(E.Message, '',
      EFDDBEngineException(E).Errors[0].ErrorCode, PrevErr, E)
  else
    Result := inherited PSGetUpdateException(E, Prev);
end;

{-------------------------------------------------------------------------------}
function TFDDataSet.PSUpdateRecord(AUpdateKind: TUpdateKind; ADelta: TDataSet): Boolean;
var
  sPrevPos: TBookmark;

  function LocateRecord: Boolean;
  var
    sField, sKeyFields: String;
    i, j: Integer;
    oFld: TField;
    vKeyValues: Variant;
  begin
    sKeyFields := PSGetKeyFields;
    if sKeyFields = '' then begin
      Result := False;
      Exit;
    end;

    i := 1;
    j := 0;
    vKeyValues := VarArrayCreate([0, 15], varVariant);
    while i <= Length(sKeyFields) do begin
      if j > 15 then begin
        Result := False;
        Exit;
      end;
      sField := FDExtractFieldName(sKeyFields, i);
      if ADelta is TFDDataSet then
        oFld := TFDDataSet(ADelta).InternalFieldByName(sField, 'PSGetKeyFields')
      else
        oFld := ADelta.FieldByName(sField);
      vKeyValues[j] := oFld.OldValue;
      if VarIsEmpty(vKeyValues[j]) then
        vKeyValues[j] := oFld.Value;
      Inc(j);
    end;
    VarArrayRedim(vKeyValues, j - 1);

    Result := Locate(sKeyFields, vKeyValues, []);
  end;

begin
  Result := False;
  if not Active then
    Exit;
  DisableControls;
  sPrevPos := Bookmark;
  try
    case AUpdateKind of
    ukModify:
      if LocateRecord then begin
        Edit;
        CopyRecordBase(ADelta, True);
        Post;
        Result := True;
      end;
    ukInsert:
      begin
        Append;
        CopyRecordBase(ADelta, True);
        Post;
        Result := True;
      end;
    ukDelete:
      if LocateRecord then begin
        Delete;
        Result := True;
      end;
    end;
  finally
    if BookmarkValid(sPrevPos) then
      Bookmark := sPrevPos;
    EnableControls;
  end;
end;

{-------------------------------------------------------------------------------}
{ TFDBlobStream                                                                 }
{-------------------------------------------------------------------------------}
constructor TFDBlobStream.Create(AField: TField; AMode: TBlobStreamMode);
var
  oFtch: TFDFetchOptions;
begin
  inherited Create;
  FField := AField;
  FDataSet := FField.DataSet as TFDDataSet;
  if not (FDataSet.State in [dsInsert, dsSetKey, dsFilter, dsNewValue]) then begin
    oFtch := FDataSet.FetchOptions;
    if (FField is TBlobField) and (oFtch.Mode <> fmManual) and
       (not (fiBlobs in oFtch.Items) or not (fiBlobs in oFtch.Cache)) then begin
      Include(FDataSet.FFlags, dfOpenBlob);
      try
        FDataSet.FetchBlobs;
      finally
        Exclude(FDataSet.FFlags, dfOpenBlob);
      end;
    end;
  end;
  if FDataSet.GetActiveRecBuf(FBuffer) then begin
    if (AMode <> bmRead) and not FDataSet.IsForceRowMode then begin
      if FField.ReadOnly and FDataSet.UpdateOptions.CheckReadOnly then
        DatabaseErrorFmt(SFieldReadOnly, [FField.DisplayName], FDataSet);
      if not (FDataSet.State in [dsEdit, dsInsert, dsNewValue, dsSetKey]) then
        DatabaseError(SNotEditing, FDataSet);
    end;
    FMode := AMode;
    if AMode = bmWrite then
      Truncate
    else
      ReadBlobData;
  end;
  Position := 0;
  FWritten := False;
end;

{-------------------------------------------------------------------------------}
destructor TFDBlobStream.Destroy;
var
  oRow: TFDDatSRow;
  oCol: TFDDatSColumn;
  iColIndex: Integer;
  iLen: LongWord;
  pBuff: Pointer;
begin
  if FModified then
    try
      oCol := nil;
      iColIndex := -1;
      oRow := nil;
      if FDataSet.GetFieldColumn(FBuffer, FField.FieldNo, oCol, iColIndex, oRow, True) then begin
        if oRow.RowState in [rsInserted, rsModified, rsUnchanged] then
          oRow.BeginEdit;
        iLen := LongWord(Size);
        if (FField is TWideStringField) or (FField is TWideMemoField) then
          iLen := iLen div SizeOf(WideChar);
        // Written zero-length value -> Write is called, Memory=nil, FWritten=True
        // Written NULL value -> Write is not called, Memory=nil, FWritten=False
        pBuff := Memory;
        if (pBuff = nil) and (iLen = 0) and FWritten then
          pBuff := Self;
        oRow.SetData(iColIndex, pBuff, iLen);
        if FField is TBlobField then
          TBlobField(FField).Modified := True;
        FDataSet.DataEvent(deFieldChange, NativeInt(FField));
      end;
    except
      FDataSet.InternalHandleException;
    end;
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TFDBlobStream.Realloc(var ANewCapacity: LongInt): Pointer;
begin
  if FMode <> bmRead then
    Result := inherited Realloc(ANewCapacity)
  else
    Result := Memory;
end;

{-------------------------------------------------------------------------------}
procedure TFDBlobStream.ReadBlobData;
var
  oRow: TFDDatSRow;
  oCol: TFDDatSColumn;
  pData: Pointer;
  iLen: LongWord;
  iColIndex: Integer;
begin
  oCol := nil;
  iColIndex := -1;
  oRow := nil;
  if FDataSet.GetFieldColumn(FBuffer, FField.FieldNo, oCol, iColIndex, oRow) then begin
    pData := nil;
    iLen := 0;
    if oRow.GetData(iColIndex, FDataSet.GetRowVersion, pData, 0, iLen, False) then begin
      if (FField is TWideStringField) or (FField is TWideMemoField) then
        iLen := iLen * SizeOf(WideChar);
      if FMode = bmRead then
        SetPointer(pData, iLen)
      else if iLen > 0 then begin
        SetSize(LongInt(iLen));
        Move(pData^, Memory^, iLen);
      end;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDBlobStream.Write(const ABuffer; ACount: Longint): Longint;
begin
  CheckWrite;
  Result := inherited Write(ABuffer, ACount);
  FModified := True;
  FWritten := True;
end;

{-------------------------------------------------------------------------------}
function TFDBlobStream.Write(const ABuffer: TBytes; AOffset, ACount: Longint): Longint;
begin
  CheckWrite;
  Result := inherited Write(ABuffer, AOffset, ACount);
  FModified := True;
  FWritten := True;
end;

{-------------------------------------------------------------------------------}
procedure TFDBlobStream.Truncate;
begin
  CheckWrite;
  Clear;
  FModified := True;
end;

{-------------------------------------------------------------------------------}
procedure TFDBlobStream.CheckWrite;
begin
  if not (FMode in [bmWrite, bmReadWrite]) then
    DatabaseErrorFmt(SFieldReadOnly, [FField.DisplayName], FDataSet);
end;

{-------------------------------------------------------------------------------}
{ TFDXMLField                                                                   }
{-------------------------------------------------------------------------------}
constructor TFDXMLField.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  SetDataType(ftDBaseOle);
end;

{-------------------------------------------------------------------------------}
function TFDXMLField.GetClassDesc: string;
begin
  Result := '(xml)';
  if not IsNull then
    Result := AnsiUpperCase(Result);
end;

{-------------------------------------------------------------------------------}
function TFDXMLField.GetSchemaName: String;
begin
  if (DataSet <> nil) and DataSet.Active then
    Result := TFDDataSet(DataSet).GetFieldColumn(Self).SourceDataTypeName
  else
    Result := '';
end;

{-------------------------------------------------------------------------------}
{ TFDAutoIncField                                                               }
{-------------------------------------------------------------------------------}
constructor TFDAutoIncField.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAutoIncrementSeed := -1;
  FAutoIncrementStep := -1;
  FClientAutoIncrement := True;
  FServerAutoIncrement := True;
  Required := False;
  ProviderFlags := [pfInWhere];
  AutoGenerateValue := TAutoRefreshFlag.arAutoInc;
  ReadOnly := True;
end;

{-------------------------------------------------------------------------------}
procedure TFDAutoIncField.SetAutoIncrementSeed(const AValue: Integer);
begin
  if (DataSet <> nil) and (DataSet.Designer <> nil) then begin
    DataSet.Designer.BeginDesign;
    try
      FAutoIncrementSeed := AValue;
    finally
      DataSet.Designer.EndDesign;
    end;
  end
  else
  begin
    CheckInactive;
    FAutoIncrementSeed := AValue;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDAutoIncField.SetAutoIncrementStep(const AValue: Integer);
begin
  if (DataSet <> nil) and (DataSet.Designer <> nil) then begin
    DataSet.Designer.BeginDesign;
    try
      FAutoIncrementStep := AValue;
    finally
      DataSet.Designer.EndDesign;
    end;
  end
  else
  begin
    CheckInactive;
    FAutoIncrementStep := AValue;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDAutoIncField.SetClientAutoIncrement(const AValue: Boolean);
begin
  if (DataSet <> nil) and (DataSet.Designer <> nil) then begin
    DataSet.Designer.BeginDesign;
    try
      FClientAutoIncrement := AValue;
    finally
      DataSet.Designer.EndDesign;
    end;
  end
  else
  begin
    CheckInactive;
    FClientAutoIncrement := AValue;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDAutoIncField.SetServerAutoIncrement(const AValue: Boolean);

  procedure UpdateProps;
  begin
    if ServerAutoIncrement then begin
      Required := False;
      ProviderFlags := ProviderFlags - [pfInUpdate];
      AutoGenerateValue := TAutoRefreshFlag.arAutoInc;
      FAutoIncrementSeed := -1;
      FAutoIncrementStep := -1;
    end
    else begin
      ProviderFlags := ProviderFlags + [pfInUpdate];
      AutoGenerateValue := TAutoRefreshFlag.arNone;
      FAutoIncrementSeed := 1;
      FAutoIncrementStep := 1;
    end;
  end;

begin
  if ServerAutoIncrement <> AValue then
    if (DataSet <> nil) and (DataSet.Designer <> nil) then begin
      DataSet.Designer.BeginDesign;
      try
        FServerAutoIncrement := AValue;
        UpdateProps;
      finally
        DataSet.Designer.EndDesign;
      end;
    end
    else
    begin
      CheckInactive;
      FServerAutoIncrement := AValue;
      UpdateProps;
    end;
end;

{-------------------------------------------------------------------------------}
function TFDAutoIncField.GetIdentityInsert: Boolean;
begin
  Result := not ReadOnly and (pfInUpdate in ProviderFlags);
end;

{-------------------------------------------------------------------------------}
procedure TFDAutoIncField.SetIdentityInsert(const AValue: Boolean);
begin
  if AValue then begin
    ReadOnly := False;
    ProviderFlags := ProviderFlags + [pfInUpdate];
  end
  else begin
    ReadOnly := True;
    ProviderFlags := ProviderFlags - [pfInUpdate];
  end;
end;

{-------------------------------------------------------------------------------}
{ TFDSQLTimeIntervalField                                                       }
{-------------------------------------------------------------------------------}
constructor TFDSQLTimeIntervalField.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  SetDataType(ftOraInterval);
end;

{-------------------------------------------------------------------------------}
function TFDSQLTimeIntervalField.GetIntervalKind: TFDSQLTimeIntervalKind;
begin
  if (DataSet <> nil) and DataSet.Active then
    if TFDDataSet(DataSet).GetFieldColumn(Self).DataType in [dtTimeIntervalFull, dtTimeIntervalDS] then
      Result := itDay2Second
    else
      Result := itYear2Month
  else
    Result := itUnknown;
end;

{-------------------------------------------------------------------------------}
function TFDSQLTimeIntervalField.GetClassDesc: string;
begin
  Result := '(SQLTimeInterval)';
  if not IsNull then
    Result := AnsiUpperCase(Result);
end;

{-------------------------------------------------------------------------------}
function TFDSQLTimeIntervalField.GetIntRec(var ARec: TFDSQLTimeInterval): Boolean;
var
  aData: TValueBuffer;
begin
  SetLength(aData, SizeOf(TFDSQLTimeInterval));
  Result := GetData(aData, True);
  if Result then
    Move(aData[0], ARec, SizeOf(TFDSQLTimeInterval))
end;

{-------------------------------------------------------------------------------}
procedure TFDSQLTimeIntervalField.SetIntRec(var ARec: TFDSQLTimeInterval);
begin
  SetData(BytesOf(@ARec, SizeOf(TFDSQLTimeInterval)), True);
end;

{-------------------------------------------------------------------------------}
function TFDSQLTimeIntervalField.GetAsString: String;
var
  rInt: TFDSQLTimeInterval;
begin
  if not GetIntRec(rInt) then
    Result := ''
  else
    Result := FDSQLTimeInterval2Str(rInt);
end;

{-------------------------------------------------------------------------------}
procedure TFDSQLTimeIntervalField.SetAsString(const AValue: String);
var
  rInt: TFDSQLTimeInterval;
begin
  if AValue = '' then
    Clear
  else begin
    rInt := FDStr2SQLTimeInterval(AValue);
    SetIntRec(rInt);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDSQLTimeIntervalField.GetAsVariant: Variant;
var
  rInt: TFDSQLTimeInterval;
begin
  if not GetIntRec(rInt) then
    Result := Null
  else
    Result := FDVarSQLTimeIntervalCreate(rInt);
end;

{-------------------------------------------------------------------------------}
procedure TFDSQLTimeIntervalField.SetVarValue(const AValue: Variant);
var
  rInt: TFDSQLTimeInterval;
begin
  rInt := FDVar2SQLTimeInterval(AValue);
  SetIntRec(rInt);
end;

{-------------------------------------------------------------------------------}
function TFDSQLTimeIntervalField.GetAsInterval: TFDSQLTimeInterval;
begin
  if not GetIntRec(Result) then
    Result := C_NullSQLTimeInterval;
end;

{-------------------------------------------------------------------------------}
procedure TFDSQLTimeIntervalField.SetAsInterval(AValue: TFDSQLTimeInterval);
begin
  SetIntRec(AValue);
end;

{-------------------------------------------------------------------------------}
{ TFDIndex                                                                      }
{-------------------------------------------------------------------------------}
constructor TFDIndex.Create(Collection: TCollection);
var
  oDS: TFDDataSet;
begin
  inherited Create(Collection);
  oDS := DataSet;
  if oDS <> nil then
    FOptions := oDS.FormatOptions.SortOptions;
end;

{-------------------------------------------------------------------------------}
destructor TFDIndex.Destroy;
begin
  Selected := False;
  DeleteView;
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TFDIndex.GetDisplayName: string;
begin
  if Name = '' then
    Result := inherited GetDisplayName
  else
    Result := Name;
end;

{-------------------------------------------------------------------------------}
procedure TFDIndex.Assign(ASource: TPersistent);
var
  opts: TFDSortOptions;
  oDS: TFDDataSet;
begin
  if ASource is TFDIndex then begin
    FActive := TFDIndex(ASource).Active;
    FName := TFDIndex(ASource).Name;
    FFields := TFDIndex(ASource).Fields;
    FCaseInsFields := TFDIndex(ASource).CaseInsFields;
    FDescFields := TFDIndex(ASource).DescFields;
    FExpression := TFDIndex(ASource).Expression;
    FOptions := TFDIndex(ASource).Options;
    FFilter := TFDIndex(ASource).Filter;
    FFilterOptions := TFDIndex(ASource).FilterOptions;
    FDistinct := TFDIndex(ASource).Distinct;
    if DataSet = TFDIndex(ASource).DataSet then
      FView := TFDIndex(ASource).FView
    else
      FView := nil;
    if FView <> nil then
      FView.AddRef
    else
      IndexChanged;
  end
  else if ASource is TIndexDef then begin
    FName := TIndexDef(ASource).Name;
    oDS := DataSet;
    if oDS <> nil then
      opts := oDS.FormatOptions.SortOptions
    else
      opts := [];
    if (ixPrimary in TIndexDef(ASource).Options) or (ixUnique in TIndexDef(ASource).Options) then
      Include(opts, soUnique);
    if ixPrimary in TIndexDef(ASource).Options then
      Include(opts, soPrimary);
    if ixDescending in TIndexDef(ASource).Options then
      Include(opts, soDescending);
    if ixCaseInsensitive in TIndexDef(ASource).Options then
      Include(opts, soNoCase);
    FOptions := opts;
    FFields := TIndexDef(ASource).Fields;
    FDescFields := TIndexDef(ASource).DescFields;
    FCaseInsFields := TIndexDef(ASource).CaseInsFields;
    FExpression := TIndexDef(ASource).Expression;
    FFilter := '';
    FFilterOptions := [];
    FDistinct := False;
    FActive := not (ixNonMaintained in TIndexDef(ASource).Options);
    IndexChanged;
  end
  else
    inherited Assign(ASource);
end;

{-------------------------------------------------------------------------------}
procedure TFDIndex.AssignTo(ADest: TPersistent);
var
  opts: TIndexOptions;
begin
  if ADest is TIndexDef then begin
    TIndexDef(ADest).Name := Name;
    if Fields <> '' then begin
      TIndexDef(ADest).Fields := Fields;
      TIndexDef(ADest).CaseInsFields := CaseInsFields;
      TIndexDef(ADest).DescFields := DescFields;
    end
    else if Expression <> '' then
      TIndexDef(ADest).Expression := Expression;
    opts := [];
    if soPrimary in Options then
      Include(opts, ixPrimary);
    if soUnique in Options then
      Include(opts, ixUnique);
    if soDescending in Options then
      Include(opts, ixDescending);
    if soNoCase in Options then
      Include(opts, ixCaseInsensitive);
    if not Active then
      Include(opts, ixNonMaintained);
    TIndexDef(ADest).Options := opts;
  end
  else
    inherited AssignTo(ADest);
end;

{-------------------------------------------------------------------------------}
function TFDIndex.GetDataSet: TFDDataSet;
begin
  if Collection <> nil then
    Result := TFDIndexes(Collection).FDataSet
  else
    Result := nil;
end;

{-------------------------------------------------------------------------------}
function TFDIndex.GetActualActive: Boolean;
begin
  Result := Active and (FUpdateCount = 0) and
    (DataSet <> nil) and (DataSet.FTable <> nil) and DataSet.IndexesActive;
end;

{-------------------------------------------------------------------------------}
function TFDIndex.GetSelected: Boolean;
var
  oDS: TFDDataSet;
begin
  oDS := DataSet;
  Result := (oDS <> nil) and (
    (Name <> '') and ({$IFDEF FireDAC_NOLOCALE_META} CompareText {$ELSE} AnsiCompareText {$ENDIF}
      (oDS.IndexName, Name) = 0) or
    (Fields <> '') and ({$IFDEF FireDAC_NOLOCALE_META} CompareText {$ELSE} AnsiCompareText {$ENDIF}
      (oDS.IndexFieldNames, Fields) = 0));
end;

{-------------------------------------------------------------------------------}
procedure TFDIndex.SetSelected(const AValue: Boolean);
var
  oDS: TFDDataSet;
begin
  oDS := DataSet;
  if (oDS <> nil) and (Selected <> AValue) and
     not (dfPreserveCurrentIndex in oDS.FFlags) then
    if not AValue then begin
      oDS.IndexName := '';
      oDS.IndexFieldNames := '';
    end
    else begin
      Active := True;
      oDS.IndexName := Name;
    end;
end;

{-------------------------------------------------------------------------------}
procedure TFDIndex.DeleteView;
begin
  if FView <> nil then begin
    FView.RemRef;
    FView := nil;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDIndex.CreateView;
begin
  try
    FView := TFDIndexes(Collection).FDataSet.BuildViewForIndex(Self);
  except
    Active := False;
    raise;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDIndex.IndexChanged;
var
  oDS: TFDDataSet;
  lReset: Boolean;

  procedure DeleteCreateView;
  begin
    if ActualActive then begin
      DeleteView;
      CreateView;
    end
    else
      DeleteView;
  end;

begin
  if FUpdateCount = 0 then begin
    oDS := DataSet;
    lReset := (oDS <> nil) and (FView <> nil) and (oDS.FSortView = FView);
    if lReset then begin
      oDS.DisableControls;
      try
        try
          oDS.SetSortView(nil);
          DeleteCreateView;
        finally
          if FView = nil then begin
            oDS.FIndexName := '';
            oDS.FLocalIndexName := '';
            oDS.FIndexFieldNames := '';
            oDS.SetSortView(nil);
          end
          else begin
            oDS.CheckFetchedAllBeforeSorting;
            if oDS.FIndexName <> '' then begin
              oDS.FIndexName := Name;
              oDS.FLocalIndexName := Name;
            end;
            if oDS.FIndexFieldNames <> '' then
              oDS.FIndexFieldNames := Fields;
            oDS.SetSortView(FView);
          end;
        end;
      finally
        oDS.EnableControls;
      end;
    end
    else
      DeleteCreateView;
    if oDS <> nil then
      oDS.IndexDefs.Updated := False;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDIndex.BeginUpdate;
begin
  Inc(FUpdateCount);
end;

{-------------------------------------------------------------------------------}
procedure TFDIndex.EndUpdate;
begin
  if FUpdateCount > 0 then begin
    Dec(FUpdateCount);
    if FUpdateCount = 0 then
      IndexChanged;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDIndex.SetActive(const AValue: Boolean);
begin
  if FActive <> AValue then begin
    FActive := AValue;
    if FActive and
       ((Name = '') or (Fields = '') and (Expression = '') and (Filter = '')) and
       (DataSet <> nil) and not (csReading in DataSet.ComponentState) then
      FDException(Self, [S_FD_LComp, S_FD_LComp_PDS], er_FD_DSIndNotComplete,
        [Name, DataSet.GetDisplayName]);
    IndexChanged;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDIndex.SetCaseInsFields(const AValue: string);
begin
  if FCaseInsFields <> AValue then begin
    FCaseInsFields := AValue;
    FExpression := '';
    IndexChanged;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDIndex.SetDescFields(const AValue: string);
begin
  if FDescFields <> AValue then begin
    FDescFields := AValue;
    FExpression := '';
    IndexChanged;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDIndex.SetExpression(const AValue: string);
begin
  if FExpression <> AValue then begin
    FExpression := AValue;
    FFields := '';
    FDescFields := '';
    FCaseInsFields := '';
    IndexChanged;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDIndex.SetFields(const AValue: string);
begin
  if FFields <> AValue then begin
    FFields := AValue;
    FExpression := '';
    IndexChanged;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDIndex.SetFilter(const AValue: String);
begin
  if FFilter <> AValue then begin
    FFilter := AValue;
    IndexChanged;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDIndex.SetFilterOptions(const AValue: TFDExpressionOptions);
begin
  if FFilterOptions <> AValue then begin
    FFilterOptions := AValue;
    IndexChanged;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDIndex.SetName(const AValue: String);
begin
  if FName <> AValue then begin
    FName := AValue;
    IndexChanged;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDIndex.SetOptions(const AValue: TFDSortOptions);
begin
  if FOptions <> AValue then begin
    FOptions := AValue;
    IndexChanged;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDIndex.SetDistinct(const AValue: Boolean);
begin
  if FDistinct <> AValue then begin
    FDistinct := AValue;
    IndexChanged;
  end;
end;

{-------------------------------------------------------------------------------}
{ TFDIndexes                                                                    }
{-------------------------------------------------------------------------------}
constructor TFDIndexes.Create(ADataSet: TFDDataSet);
begin
  ASSERT(ADataSet <> nil);
  inherited Create(TFDIndex);
  FDataSet := ADataSet;
end;

{-------------------------------------------------------------------------------}
function TFDIndexes.GetOwner: TPersistent;
begin
  Result := FDataSet;
end;

{-------------------------------------------------------------------------------}
function TFDIndexes.Add: TFDIndex;
begin
  Result := TFDIndex(inherited Add);
end;

{-------------------------------------------------------------------------------}
function TFDIndexes.FindIndex(const AName: String): TFDIndex;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Count - 1 do
    if {$IFDEF FireDAC_NOLOCALE_META} CompareText {$ELSE} AnsiCompareText {$ENDIF}
       (Items[i].Name, AName) = 0 then begin
      Result := Items[i];
      Break;
    end;
end;

{-------------------------------------------------------------------------------}
function TFDIndexes.IndexByName(const AName: String): TFDIndex;
begin
  Result := FindIndex(AName);
  if Result = nil then
    FDException(Self, [S_FD_LComp, S_FD_LComp_PDS], er_FD_DSIndNotFound,
      [AName, FDataSet.GetDisplayName]);
end;

{-------------------------------------------------------------------------------}
function TFDIndexes.GetItems(AIndex: Integer): TFDIndex;
begin
  Result := TFDIndex(inherited Items[AIndex]);
end;

{-------------------------------------------------------------------------------}
procedure TFDIndexes.SetItems(AIndex: Integer; const AValue: TFDIndex);
begin
  inherited Items[AIndex] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDIndexes.FindIndexForFields(const AFields: String;
  ARequiredOptions: TFDSortOptions = [];
  AProhibitedOptions: TFDSortOptions = []): TFDIndex;
var
  i: Integer;
  oInd: TFDIndex;
begin
  Result := nil;
  for i := 0 to Count - 1 do begin
    oInd := Items[i];
    if (oInd.Expression = '') and ((oInd.Filter = '') or oInd.Selected) and
       (Pos(AFields, oInd.Fields) = 1) and (
          (Length(AFields) = Length(oInd.Fields)) or
          (oInd.Fields[Length(AFields) + 1] = ';')) and
       (oInd.Options * ARequiredOptions = ARequiredOptions) and
       (oInd.Options * AProhibitedOptions = []) and
       not oInd.Distinct then begin
      Result := oInd;
      Break;
    end;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDIndexes.Build;
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
    Items[i].IndexChanged;
end;

{-------------------------------------------------------------------------------}
procedure TFDIndexes.Release;
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
    Items[i].DeleteView;
end;

{-------------------------------------------------------------------------------}
{ TFDAggregate                                                                  }
{-------------------------------------------------------------------------------}
destructor TFDAggregate.Destroy;
begin
  DeleteAggregate;
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TFDAggregate.GetDisplayName: String;
begin
  if Name = '' then
    Result := inherited GetDisplayName
  else
    Result := Name;
end;

{-------------------------------------------------------------------------------}
procedure TFDAggregate.Assign(ASource: TPersistent);
begin
  if ASource is TFDAggregate then begin
    FExpression := TFDAggregate(ASource).Expression;
    FGroupingLevel := TFDAggregate(ASource).GroupingLevel;
    FIndexName := TFDAggregate(ASource).IndexName;
    FActive := TFDAggregate(ASource).Active;
    FName := TFDAggregate(ASource).Name;
    AggregateChanged;
  end
  else if ASource is TAggregateField then begin
    FExpression := TAggregateField(ASource).Expression;
    FGroupingLevel := TAggregateField(ASource).GroupingLevel;
    FIndexName := TAggregateField(ASource).IndexName;
    FActive := TAggregateField(ASource).Active;
    FName := C_FD_SysNamePrefix + '#' + TAggregateField(ASource).FieldName;
    AggregateChanged;
  end
  else
    inherited Assign(ASource);
end;

{-------------------------------------------------------------------------------}
procedure TFDAggregate.BeginUpdate;
begin
  Inc(FUpdateCount);
end;

{-------------------------------------------------------------------------------}
procedure TFDAggregate.EndUpdate;
begin
  if FUpdateCount > 0 then begin
    Dec(FUpdateCount);
    if FUpdateCount = 0 then
      AggregateChanged;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDAggregate.GetActualActive: Boolean;
begin
  Result := (FExpression <> '') and Active and (FUpdateCount = 0) and
    (DataSet <> nil) and (DataSet.FTable <> nil) and DataSet.AggregatesActive;
end;

{-------------------------------------------------------------------------------}
function TFDAggregate.GetDataSet: TFDDataSet;
begin
  if Collection <> nil then
    Result := TFDAggregates(Collection).FDataSet
  else
    Result := nil;
end;

{-------------------------------------------------------------------------------}
procedure TFDAggregate.DeleteAggregate;
begin
  if FAggregate <> nil then begin
    FAggregate.RemRef;
    FAggregate := nil;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDAggregate.CreateAggregate;
var
  oDS: TFDDataSet;
begin
  oDS := DataSet;
  if (oDS = nil) or        // When we modifying index props we set to nil index view,
                           // and then to some index view. There will be moment when
                           // oDS.IndexName not empty, but there are no FSortView
     (IndexName <> '') and {(IndexName <> oDS.IndexName) then}
     ((oDS.FSortView = nil) or
      ({$IFDEF FireDAC_NOLOCALE_META} CompareText {$ELSE} AnsiCompareText {$ENDIF}
        (IndexName, oDS.FSortView.Name) <> 0)) then
    Exit;
  if TFDAggregates(Collection).FGroupingLevel < GroupingLevel then
    TFDAggregates(Collection).FGroupingLevel := GroupingLevel;
  FAggregate := oDS.FSourceView.Aggregates.Add(Name, Expression, GroupingLevel);
  FAggregate.CountRef;
end;

{-------------------------------------------------------------------------------}
procedure TFDAggregate.AggregateChanged;
begin
  if FUpdateCount = 0 then begin
    if ActualActive then begin
      DeleteAggregate;
      CreateAggregate;
    end
    else
      DeleteAggregate;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDAggregate.SetActive(const AValue: Boolean);
begin
  if FActive <> AValue then begin
    FActive := AValue;
    if FActive and
       ((Name = '') or (Expression = '')) and
       (DataSet <> nil) and not (csReading in DataSet.ComponentState) then
      FDException(Self, [S_FD_LComp, S_FD_LComp_PDS], er_FD_DSAggNotComplete,
        [Name, DataSet.GetDisplayName]);
    AggregateChanged;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDAggregate.SetExpression(const AValue: String);
begin
  if FExpression <> AValue then begin
    FExpression := AValue;
    AggregateChanged;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDAggregate.SetGroupingLevel(const AValue: Integer);
begin
  if FGroupingLevel <> AValue then begin
    FGroupingLevel := AValue;
    AggregateChanged;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDAggregate.SetIndexName(const AValue: String);
begin
  if FIndexName <> AValue then begin
    FIndexName := AValue;
    AggregateChanged;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDAggregate.InternalUse(var ARecordIndex: Integer): Boolean;
var
  oDS: TFDDataSet;
begin
  oDS := DataSet;
  if (oDS <> nil) and oDS.GetActiveRecBufRecordIndex(ARecordIndex) and
     (FAggregate <> nil) and FAggregate.ActualActive then
    Result := True
  else
    Result := False;
end;

{-------------------------------------------------------------------------------}
function TFDAggregate.GetInUse: Boolean;
var
  iRecInd: Integer;
begin
  iRecInd := -1;
  Result := InternalUse(iRecInd);
end;

{-------------------------------------------------------------------------------}
function TFDAggregate.GetValue: Variant;
var
  iRecInd: Integer;
begin
  iRecInd := -1;
  if InternalUse(iRecInd) then
    Result := FAggregate.Value[iRecInd]
  else
    Result := Null;
end;

{-------------------------------------------------------------------------------}
function TFDAggregate.GetDataType: TFDDataType;
begin
  if ActualActive then
    Result := FAggregate.DataType
  else
    Result := dtUnknown;
end;

{-------------------------------------------------------------------------------}
{ TFDAggregates                                                                 }
{-------------------------------------------------------------------------------}
constructor TFDAggregates.Create(ADataSet: TFDDataSet);
begin
  ASSERT(ADataSet <> nil);
  inherited Create(TFDAggregate);
  FDataSet := ADataSet;
end;

{-------------------------------------------------------------------------------}
function TFDAggregates.GetOwner: TPersistent;
begin
  Result := FDataSet;
end;

{-------------------------------------------------------------------------------}
function TFDAggregates.Add: TFDAggregate;
begin
  Result := TFDAggregate(inherited Add);
end;

{-------------------------------------------------------------------------------}
function TFDAggregates.GetItems(AIndex: Integer): TFDAggregate;
begin
  Result := TFDAggregate(inherited Items[AIndex]);
end;

{-------------------------------------------------------------------------------}
procedure TFDAggregates.SetItems(AIndex: Integer; const AValue: TFDAggregate);
begin
  inherited Items[AIndex] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDAggregates.FindAggregate(const AName: String): TFDAggregate;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Count - 1 do
    if {$IFDEF FireDAC_NOLOCALE_META} CompareText {$ELSE} AnsiCompareText {$ENDIF}
       (Items[i].Name, AName) = 0 then begin
      Result := Items[i];
      Break;
    end;
end;

{-------------------------------------------------------------------------------}
function TFDAggregates.AggregateByName(const AName: String): TFDAggregate;
begin
  Result := FindAggregate(AName);
  if Result = nil then
    FDException(Self, [S_FD_LComp, S_FD_LComp_PDS], er_FD_DSAggNotFound,
      [AName, FDataSet.GetDisplayName]);
end;

{-------------------------------------------------------------------------------}
procedure TFDAggregates.Build;
var
  i: Integer;
begin
  FGroupingLevel := -1;
  for i := 0 to Count - 1 do
    Items[i].AggregateChanged;
  if FGroupingLevel = -1 then
    if (FDataSet <> nil) and (FDataSet.IndexName <> '') then
      FGroupingLevel := FDataSet.FSourceView.GroupingLevel
    else
      FGroupingLevel := 0;
end;

{-------------------------------------------------------------------------------}
procedure TFDAggregates.Release;
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
    Items[i].DeleteAggregate;
end;

end.
