{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{            FireDAC option support classes             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.Stan.Option;

interface

uses
{$IFDEF MSWINDOWS}
  Winapi.Windows,
{$ENDIF}
  System.SysUtils, System.Classes, Data.DB, System.Variants,
  FireDAC.Stan.Intf, FireDAC.Stan.Util, FireDAC.Stan.Consts;

type
  IFDStanOptions = interface;
  TFDCustomOptions = class;
  TFDMapRule = class;
  TFDMapRules = class;
  TFDFormatOptions = class;
  TFDFetchOptions = class;
  TFDFetchOptionsClass = class of TFDFetchOptions;
  TFDUpdateOptions = class;
  TFDBottomUpdateOptions = class;
  TFDUpdateOptionsClass = class of TFDUpdateOptions;
  TFDResourceOptions = class;
  TFDTopResourceOptions = class;
  TFDBottomResourceOptions = class;
  TFDResourceOptionsClass = class of TFDResourceOptions;
  TFDTxOptions = class;
  TFDOptionsContainer = class;
  TFDEventAlerterOptions = class;

  TFDOptionChangeEvent = procedure (AOptions: TFDCustomOptions) of object;

  TFDFormatOptionValue = (fvMapRules, fvSE2Null, fvStrsTrim, fvStrsDivLen2,
    fvMaxStringSize, fvMaxBcdPrecision, fvMaxBcdScale, fvInlineDataSize,
    fvDefaultParamDataType, fvRound2Scale, fvDataSnapCompatibility,
    fvFmtDisplayDateTime, fvFmtDisplayDate, fvFmtDisplayTime, fvFmtDisplayNumeric,
    fvFmtEditNumeric, fvQuoteIdentifiers, fvSortLocale, fvSortOptions,
    fvStrsTrim2Len, fvCheckPrecision);
  TFDFormatOptionValues = set of TFDFormatOptionValue;

  TFDFetchOptionValue = (evMode, evItems, evRecsSkip, evRecsMax, evRowsetSize,
    evCache, evAutoClose, evRecordCountMode, evUnidirectional, evCursorKind,
    evAutoFetchAll, evLiveWindowParanoic, evDetailDelay, evDetailOptimize,
    evDetailCascade, evLiveWindowFastFirst, evDetailServerCascade);
  TFDFetchOptionValues = set of TFDFetchOptionValue;

  TFDFetchMode = (fmManual, fmOnDemand, fmAll, fmExactRecsMax);
  TFDFetchItem = (fiBlobs, fiDetails, fiMeta);
  TFDFetchItems = set of TFDFetchItem;
  TFDCursorKind = (ckAutomatic, ckDefault, ckDynamic, ckStatic, ckForwardOnly);
  TFDAutoFetchAll = (afAll, afTruncate, afDisable);
  TFDRecordCountMode = (cmVisible, cmFetched, cmTotal);

  TFDUpdateOptionValue = (uvEDelete, uvEInsert, uvEUpdate, uvUpdateChngFields,
    uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode,
    uvRefreshDelete, uvCountUpdatedRecords, uvFetchGeneratorsPoint,
    uvGeneratorName, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable,
    uvUpdateNonBaseFields, uvAutoCommitUpdates);
  TFDUpdateOptionValues = set of TFDUpdateOptionValue;

  TFDActionRequest = (arNone, arFromRow, arSelect, arInsert, arUpdate, arDelete,
    arLock, arUnlock, arFetchRow, arUpdateHBlobs, arDeleteAll, arFetchGenerators);
  TFDActionRequests = set of TFDActionRequest;
  TFDUpdateRequest = arInsert .. arFetchGenerators;
  TFDUpdateRequests = set of TFDUpdateRequest;
  TFDUpdateRowOption = (uoCancelUnlock, uoImmediateUpd, uoDeferredLock,
    uoOneMomLock, uoNoSrvRecord, uoDeferredGenGet);
  TFDUpdateRowOptions = set of TFDUpdateRowOption;

  TFDLockMode = (lmNone, lmPessimistic, lmOptimistic);
  TFDLockPoint = (lpImmediate, lpDeferred);

  TFDRefreshMode = (rmManual, rmOnDemand, rmAll);

  TFDFetchGeneratorsPoint = (gpNone, gpImmediate, gpDeferred);

  TFDResourceOptionValue = (rvParamCreate, rvMacroCreate, rvMacroExpand,
    rvParamExpand, rvEscapeExpand, rvMaxCursors, rvCmdExecMode, rvCmdExecTimeout,
    rvDirectExecute, rvDefaultParamType, rvServerOutput, rvServerOutputSize,
    rvPersistent, rvBackup, rvDefaultStoreFolder, rvDefaultStoreFormat,
    rvStoreVersion, rvStoreItems, rvBackupFolder, rvDefaultStoreExt,
    rvBackupExt, rvAutoConnect, rvAutoReconnect, rvArrayDMLSize, rvSilentMode,
    rvUnifyParams, rvKeepConnection, rvStorePrettyPrint, rvStoreMergeData,
    rvStoreMergeMeta);
  TFDResourceOptionValues = set of TFDResourceOptionValue;

  TFDTxIsolation = (xiUnspecified, xiDirtyRead, xiReadCommitted, xiRepeatableRead,
    xiSnapshot, xiSerializible);
  TFDTxAction = (xdNone, xdCommit, xdRollback);
  TFDTxStopOption = (xoIfCmdsInactive, xoIfAutoStarted, xoFinishRetaining);
  TFDTxStopOptions = set of TFDTxStopOption;
  TFDTxValue = (xoIsolation, xoReadOnly, xoParams, xoAutoStart, xoAutoStop,
    xoStopOptions, xoAutoCommit);
  TFDTxValues = set of TFDTxValue;

  TFDAutoRefresh = (afNone, afAlert, afTimeout);

  IFDStanOptions = interface (IUnknown)
    ['{3E9B315B-F456-4175-A864-B2573C4A2018}']
    // private
    function GetFetchOptions: TFDFetchOptions;
    function GetFormatOptions: TFDFormatOptions;
    function GetUpdateOptions: TFDUpdateOptions;
    function GetResourceOptions: TFDResourceOptions;
    function GetParentOptions: IFDStanOptions;
    procedure SetParentOptions(const AValue: IFDStanOptions);
    // public
    procedure ObjectDestroyed(AObj: TPersistent);
    // R/O
    property FetchOptions: TFDFetchOptions read GetFetchOptions;
    property FormatOptions: TFDFormatOptions read GetFormatOptions;
    property UpdateOptions: TFDUpdateOptions read GetUpdateOptions;
    property ResourceOptions: TFDResourceOptions read GetResourceOptions;
    // R/W
    property ParentOptions: IFDStanOptions read GetParentOptions write SetParentOptions;
  end;

  TFDOptionsParentCallback = procedure (var AOpts: IFDStanOptions) of object;
  TFDOptionsContainer = class(TInterfacedObject, IFDStanOptions)
  private
    [Weak] FOwnerObj: TPersistent;
    FFormatOptions: TFDFormatOptions;
    FFetchOptions: TFDFetchOptions;
    FUpdateOptions: TFDUpdateOptions;
    FResourceOptions: TFDResourceOptions;
    FParentOptions: IFDStanOptions;
    FParentOriginalCallback: TFDOptionsParentCallback;
    FParentCallback: TFDOptionsParentCallback;
    procedure InternalParentOptionsCallback(var AOpts: IFDStanOptions);
  protected
    // IFDStanOptions
    function GetFetchOptions: TFDFetchOptions;
    function GetFormatOptions: TFDFormatOptions;
    function GetUpdateOptions: TFDUpdateOptions;
    function GetResourceOptions: TFDResourceOptions;
    function GetParentOptions: IFDStanOptions;
    procedure SetParentOptions(const AValue: IFDStanOptions);
    procedure ObjectDestroyed(AObj: TPersistent);
  public
    constructor Create(AOwnerObj: TPersistent; AFetchClass: TFDFetchOptionsClass;
      AUpdateClass: TFDUpdateOptionsClass; AResourceClass: TFDResourceOptionsClass;
      AParentCallback: TFDOptionsParentCallback);
    destructor Destroy; override;
  end;

  TFDCustomOptions = class (TPersistent)
  private
    [Weak] FContainer: TFDOptionsContainer;
    FVersion: Longword;
    function GetOwnerObj: TPersistent;
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(AContainer: TFDOptionsContainer); virtual;
    procedure Assign(ASource: TPersistent); override;
    procedure RestoreDefaults; virtual;
    property Container: TFDOptionsContainer read FContainer;
    property Version: Longword read FVersion;
    property OwnerObj: TPersistent read GetOwnerObj;
  end;

  TFDMapRule = class (TCollectionItem)
  private
    FPrecMax: Integer;
    FPrecMin: Integer;
    FScaleMax: Integer;
    FScaleMin: Integer;
    FSizeMax: Cardinal;
    FSizeMin: Cardinal;
    FSourceDataType: TFDDataType;
    FTargetDataType: TFDDataType;
    FNameMask: String;
    FTypeMask: String;
    procedure SetSourceDataType(AValue: TFDDataType);
    procedure SetTargetDataType(AValue: TFDDataType);
  protected
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    procedure Assign(Source: TPersistent); override;
  published
    property PrecMax: Integer read FPrecMax write FPrecMax default C_FD_DefMapPrec;
    property PrecMin: Integer read FPrecMin write FPrecMin default C_FD_DefMapPrec;
    property ScaleMax: Integer read FScaleMax write FScaleMax default C_FD_DefMapScale;
    property ScaleMin: Integer read FScaleMin write FScaleMin default C_FD_DefMapScale;
    property SizeMax: Cardinal read FSizeMax write FSizeMax default C_FD_DefMapSize;
    property SizeMin: Cardinal read FSizeMin write FSizeMin default C_FD_DefMapSize;
    property NameMask: String read FNameMask write FNameMask;
    /// <summary> The TypeMask property specified the column type name mask.
    ///  It works similar to NameMask property. The property is useful for the
    ///  databases supporting domain based type systems, like InterBase,
    ///  Firebird and PostgreSQL. </summary>
    property TypeMask: String read FTypeMask write FTypeMask;
    property SourceDataType: TFDDataType read FSourceDataType write
      SetSourceDataType default dtUnknown;
    property TargetDataType: TFDDataType read FTargetDataType write
      SetTargetDataType default dtUnknown;
  end;

  TFDMapRules = class(TCollection)
  private
    [Weak] FFormatOptions: TFDFormatOptions;
    function GetItems(AIndex: Integer): TFDMapRule;
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(AFormatOptions: TFDFormatOptions);
    function Add: TFDMapRule; overload;
    procedure Add(APrecMin, APrecMax, AScaleMin, AScaleMax: Integer;
      ASourceDataType, ATargetDataType: TFDDataType); overload;
    procedure Add(ASizeMin, ASizeMax: Integer;
      ASourceDataType, ATargetDataType: TFDDataType); overload;
    procedure Add(ASourceDataType, ATargetDataType: TFDDataType); overload;
    procedure RemoveForSourceDataType(ADataType: TFDDataType);
    procedure RemoveForTargetDataType(ADataType: TFDDataType);
    property Items[AIndex: Integer]: TFDMapRule read GetItems; default;
  end;

  TFDFormatOptions = class (TFDCustomOptions)
  private
    FMapRules: TFDMapRules;
    FStrsEmpty2Null: Boolean;
    FStrsTrim: Boolean;
    FStrsTrim2Len: Boolean;
    FStrsDivLen2: Boolean;
    FAssignedValues: TFDFormatOptionValues;
    FMaxStringSize: LongWord;
    FMaxBcdPrecision: Integer;
    FMaxBcdScale: Integer;
    FInlineDataSize: Integer;
    FDefaultParamDataType: TFieldType;
    FRound2Scale: Boolean;
    FCheckPrecision: Boolean;
    FDataSnapCompatibility: Boolean;
    FFmtDisplayDateTime: String;
    FFmtDisplayDate: String;
    FFmtDisplayTime: String;
    FFmtDisplayNumeric: String;
    FFmtEditNumeric: String;
    FQuoteIdentifiers: Boolean;
    FSortLocale: TFDLocalID;
    FSortOptions: TFDSortOptions;
    function GetStrsEmpty2Null: Boolean;
    function GetStrsTrim: Boolean;
    procedure SetStrsEmpty2Null(AValue: Boolean);
    procedure SetStrsTrim(AValue: Boolean);
    function GetMapRules: TFDMapRules;
    function IsMRS: Boolean;
    function IsSE2NS: Boolean;
    function IsSTS: Boolean;
    procedure SetMapRules(const AValue: TFDMapRules);
    function GetMaxStringSize: LongWord;
    function IsMSSS: Boolean;
    procedure SetMaxStringSize(const AValue: LongWord);
    function GetMaxBcdPrecision: Integer;
    function GetMaxBcdScale: Integer;
    function IsMBPS: Boolean;
    function IsMBSS: Boolean;
    procedure SetMaxBcdPrecision(const AValue: Integer);
    procedure SetMaxBcdScale(const AValue: Integer);
    procedure SetOwnMapRules(const AValue: Boolean);
    function GetStrsDivLen2: Boolean;
    function IsSDL2S: Boolean;
    procedure SetStrsDivLen2(const AValue: Boolean);
    function GetInlineDataSize: Integer;
    function IsIDSS: Boolean;
    procedure SetInlineDataSize(const AValue: Integer);
    procedure SetDefaultParamDataType(const AValue: TFieldType);
    function GetDefaultParamDataType: TFieldType;
    function IsDPDTS: Boolean;
    function GetRound2Scale: Boolean;
    function IsRSS: Boolean;
    procedure SetRound2Scale(const AValue: Boolean);
    function GetDataSnapCompatibility: Boolean;
    function IsDSCS: Boolean;
    procedure SetDataSnapCompatibility(const AValue: Boolean);
    function GetFmtDisplayDate: String;
    function GetFmtDisplayDateTime: String;
    function GetFmtDisplayNumeric: String;
    function GetFmtDisplayTime: String;
    function GetFmtEditNumeric: String;
    function IsFDDS: Boolean;
    function IsFDDTS: Boolean;
    function IsFDNS: Boolean;
    function IsFDTS: Boolean;
    function IsFENS: Boolean;
    procedure SetFmtDisplayDate(const AValue: String);
    procedure SetFmtDisplayDateTime(const AValue: String);
    procedure SetFmtDisplayNumeric(const AValue: String);
    procedure SetFmtDisplayTime(const AValue: String);
    procedure SetFmtEditNumeric(const AValue: String);
    function GetSortLocale: TFDLocalID;
    function IsSLS: Boolean;
    procedure SetSortLocale(const AValue: TFDLocalID);
    function GetSortOptions: TFDSortOptions;
    function IsSOS: Boolean;
    procedure SetSortOptions(const AValue: TFDSortOptions);
    function GetStrsTrim2Len: Boolean;
    function IsSTTLS: Boolean;
    procedure SetStrsTrim2Len(const AValue: Boolean);
    function GetQuoteIdentifiers: Boolean;
    function IsQIDS: Boolean;
    procedure SetQuoteIdentifiers(const AValue: Boolean);
    function GetCheckPrecision: Boolean;
    function IsCPS: Boolean;
    procedure SetCheckPrecision(const AValue: Boolean);
  public
    constructor Create(AContainer: TFDOptionsContainer); override;
    destructor Destroy; override;
    procedure Assign(ASource: TPersistent); override;
    procedure RestoreDefaults; override;
    function IsValueOwned(AValue: TFDFormatOptionValue; var AParentOpts: IFDStanOptions): Boolean;
    procedure ResolveDataType(const ASrcName, ATypeName: String;
      ASrcDataType: TFDDataType; ASrcSize: LongWord; ASrcPrec, ASrcScale: Integer;
      var ADestDataType: TFDDataType; var ADestSize: LongWord; AForward: Boolean);
    procedure ResolveFieldType(const ASrcName, ATypeName: String; ASrcFieldType: TFieldType;
      ASrcADFieldType: TFDDataType; ASrcSize: LongWord; ASrcPrecision, ASrcScale: Integer;
      var ADestFieldType: TFieldType; var ADestSize: LongWord; var ADestPrecision,
      ADestScale: Integer; var ASrcDataType, ADestDataType: TFDDataType; AForward: Boolean);
    procedure ColumnDef2FieldDef(ASrcDataType: TFDDataType; ASrcSize: LongWord;
      ASrcPrec, ASrcScale: Integer; ASrcAttrs: TFDDataAttributes;
      var ADestFieldType: TFieldType; var ADestSize: LongWord; var ADestPrec, ADestScale: Integer);
    class procedure FieldDef2ColumnDef(ASrcFieldType: TFieldType; ASrcSize: LongWord;
      ASrcPrec, ASrcScale: Integer; var ADestDataType: TFDDataType; var ADestSize: LongWord;
      var ADestPrec, ADestScale: Integer; var ADestAttrs: TFDDataAttributes); overload;
    class procedure FieldDef2ColumnDef(AField: TField; var ADestDataType: TFDDataType;
      var ADestSize: LongWord; var ADestPrec, ADestScale: Integer;
      var ADestAttrs: TFDDataAttributes); overload;
    class procedure FieldDef2ColumnDef(AFieldDef: TFieldDef; var ADestDataType: TFDDataType;
      var ADestSize: LongWord; var ADestPrec, ADestScale: Integer;
      var ADestAttrs: TFDDataAttributes); overload;
    procedure CheckConversion(ASrc, ADest: TFDDataType);
    procedure ConvertRawData(ASrcType, ADestType: TFDDataType; ApSrc: Pointer;
      ASrcSize: LongWord; var ApDest: Pointer; ADestMaxSize: LongWord;
      var ADestSize: LongWord; AEncoder: TFDEncoder);
    // It is for DBX bug workaround
    property StrsDivLen2: Boolean read GetStrsDivLen2 write SetStrsDivLen2
      stored IsSDL2S default False;
  published
    property AssignedValues: TFDFormatOptionValues read FAssignedValues
      write FAssignedValues default [];
    property OwnMapRules: Boolean read IsMRS write SetOwnMapRules default False;
    property MapRules: TFDMapRules read GetMapRules write SetMapRules
      stored IsMRS;
    property StrsEmpty2Null: Boolean read GetStrsEmpty2Null write SetStrsEmpty2Null
      stored IsSE2NS default False;
    property StrsTrim: Boolean read GetStrsTrim write SetStrsTrim
      stored IsSTS default True;
    property StrsTrim2Len: Boolean read GetStrsTrim2Len write SetStrsTrim2Len
      stored IsSTTLS default False;
    property MaxStringSize: LongWord read GetMaxStringSize write SetMaxStringSize
      stored IsMSSS default C_FD_DefMaxStrSize;
    property MaxBcdPrecision: Integer read GetMaxBcdPrecision write SetMaxBcdPrecision
      stored IsMBPS default 18;
    property MaxBcdScale: Integer read GetMaxBcdScale write SetMaxBcdScale
      stored IsMBSS default 4;
    property InlineDataSize: Integer read GetInlineDataSize write
      SetInlineDataSize stored IsIDSS default C_FD_DefInlineDataSize;
    property DefaultParamDataType: TFieldType read GetDefaultParamDataType write
      SetDefaultParamDataType stored IsDPDTS default ftUnknown;
    property Round2Scale: Boolean read GetRound2Scale write SetRound2Scale
      stored IsRSS default False;
    property CheckPrecision: Boolean read GetCheckPrecision write SetCheckPrecision
      stored IsCPS default False;
    property DataSnapCompatibility: Boolean read GetDataSnapCompatibility
      write SetDataSnapCompatibility stored IsDSCS default False;
    property FmtDisplayDateTime: String read GetFmtDisplayDateTime
      write SetFmtDisplayDateTime stored IsFDDTS;
    property FmtDisplayDate: String read GetFmtDisplayDate
      write SetFmtDisplayDate stored IsFDDS;
    property FmtDisplayTime: String read GetFmtDisplayTime
      write SetFmtDisplayTime stored IsFDTS;
    property FmtDisplayNumeric: String read GetFmtDisplayNumeric
      write SetFmtDisplayNumeric stored IsFDNS;
    property FmtEditNumeric: String read GetFmtEditNumeric
      write SetFmtEditNumeric stored IsFENS;
    property QuoteIdentifiers: Boolean read GetQuoteIdentifiers
      write SetQuoteIdentifiers stored IsQIDS default False;
    property SortLocale: TFDLocalID read GetSortLocale write SetSortLocale
      stored IsSLS default LOCALE_USER_DEFAULT;
    property SortOptions: TFDSortOptions read GetSortOptions write SetSortOptions
      stored IsSOS default [];
  end;

  TFDFetchOptions = class (TFDCustomOptions)
  private
    FRecsSkip,
    FRecsMax: Integer;
    FRowsetSize: Integer;
    FMode: TFDFetchMode;
    FItems: TFDFetchItems;
    FAssignedValues: TFDFetchOptionValues;
    FCache: TFDFetchItems;
    FAutoClose: Boolean;
    FAutoFetchAll: TFDAutoFetchAll;
    FRecordCountMode: TFDRecordCountMode;
    FUnidirectional: Boolean;
    FCursorKind: TFDCursorKind;
    FLiveWindowParanoic: Boolean;
    FLiveWindowFastFirst: Boolean;
    FDetailDelay: Integer;
    FDetailOptimize: Boolean;
    FDetailCascade: Boolean;
    FDetailServerCascade: Boolean;
    function GetRecsMax: Integer;
    function GetRowsetSize: Integer;
    function GetItems: TFDFetchItems;
    function GetMode: TFDFetchMode;
    procedure SetRecsMax(const AValue: Integer);
    procedure SetRowsetSize(const AValue: Integer);
    procedure SetItems(const AValue: TFDFetchItems);
    procedure SetMode(const AValue: TFDFetchMode);
    function IsIS: Boolean;
    function IsMS: Boolean;
    function IsRMS: Boolean;
    function IsRSS: Boolean;
    function GetCache: TFDFetchItems;
    function IsCS: Boolean;
    procedure SetCache(const AValue: TFDFetchItems);
    function GetActualRowsetSize: Integer;
    function GetAutoClose: Boolean;
    function IsACS: Boolean;
    procedure SetAutoClose(const AValue: Boolean);
    function GetRecordcountMode: TFDRecordCountMode;
    function IsRCMS: Boolean;
    procedure SetRecordCountMode(const AValue: TFDRecordCountMode);
    function GetUnidirectional: Boolean;
    function IsUS: Boolean;
    procedure SetUnidirectional(const AValue: Boolean);
    function GetCursor: TFDCursorKind;
    procedure SetCursor(const AValue: TFDCursorKind);
    function IsCKS: Boolean;
    function GetRecsSkip: Integer;
    procedure SetRecsSkip(const AValue: Integer);
    function IsESS: Boolean;
    function GetAutoFetchAll: TFDAutoFetchAll;
    procedure SetAutoFetchAll(const AValue: TFDAutoFetchAll);
    function IsAFAS: Boolean;
    function GetLiveWindowParanoic: Boolean;
    procedure SetLiveWindowParanoic(const AValue: Boolean);
    function IsLWP: Boolean;
    function GetDetailDelay: Integer;
    function GetDetailOptimize: Boolean;
    function IsDDS: Boolean;
    function IsDOS: Boolean;
    procedure SetDetailDelay(const AValue: Integer);
    procedure SetDetailOptimize(const AValue: Boolean);
    function GetDetailCascade: Boolean;
    function IsDCS: Boolean;
    procedure SetDetailCascade(const AValue: Boolean);
    function GetLiveWindowFastFirst: Boolean;
    function IsLWFF: Boolean;
    procedure SetLiveWindowFastFirst(const AValue: Boolean);
    function GetDetailServerCascade: Boolean;
    function IsSDCS: Boolean;
    procedure SetDetailServerCascade(const AValue: Boolean);
  public
    procedure Assign(ASource: TPersistent); override;
    procedure RestoreDefaults; override;
    function IsValueOwned(AValue: TFDFetchOptionValue; var AParentOpts: IFDStanOptions): Boolean;
    property ActualRowsetSize: Integer read GetActualRowsetSize;
  published
    property AssignedValues: TFDFetchOptionValues read FAssignedValues
      write FAssignedValues default [];
    property Mode: TFDFetchMode read GetMode write SetMode
      stored IsMS default fmOnDemand;
    property CursorKind: TFDCursorKind read GetCursor write SetCursor
      stored IsCKS default ckAutomatic;
    property Unidirectional: Boolean read GetUnidirectional
      write SetUnidirectional stored IsUS default False;
    property RowsetSize: Integer read GetRowsetSize write SetRowsetSize
      stored IsRSS default C_FD_DefRowSetSize;
    property RecsSkip: Integer read GetRecsSkip write SetRecsSkip
      stored IsESS default -1;
    property RecsMax: Integer read GetRecsMax write SetRecsMax
      stored IsRMS default -1;
    property AutoClose: Boolean read GetAutoClose write SetAutoClose
      stored IsACS default True;
    property AutoFetchAll: TFDAutoFetchAll read GetAutoFetchAll
      write SetAutoFetchAll stored IsAFAS default afAll;
    property RecordCountMode: TFDRecordCountMode read GetRecordcountMode
      write SetRecordCountMode stored IsRCMS default cmVisible;
    property Items: TFDFetchItems read GetItems write SetItems
      stored IsIS default [fiBlobs, fiDetails, fiMeta];
    property Cache: TFDFetchItems read GetCache write SetCache
      stored IsCS default [fiBlobs, fiDetails, fiMeta];
    property LiveWindowParanoic: Boolean read GetLiveWindowParanoic
      write SetLiveWindowParanoic stored IsLWP default True;
    property LiveWindowFastFirst: Boolean read GetLiveWindowFastFirst
      write SetLiveWindowFastFirst stored IsLWFF default False;
    property DetailDelay: Integer read GetDetailDelay
      write SetDetailDelay stored IsDDS default 0;
    property DetailOptimize: Boolean read GetDetailOptimize
      write SetDetailOptimize stored IsDOS default True;
    property DetailCascade: Boolean read GetDetailCascade
      write SetDetailCascade stored IsDCS default False;
    property DetailServerCascade: Boolean read GetDetailServerCascade
      write SetDetailServerCascade stored IsSDCS default False;
  end;

  TFDUpdateOptions = class (TFDCustomOptions)
  private
    FEnableDelete: Boolean;
    FEnableInsert: Boolean;
    FEnableUpdate: Boolean;
    FUpdateChangedFields: Boolean;
    FUpdateMode: TUpdateMode;
    FLockMode: TFDLockMode;
    FLockPoint: TFDLockPoint;
    FLockWait: Boolean;
    FRefreshMode: TFDRefreshMode;
    FrefreshDelete: Boolean;
    FCountUpdatedRecords: Boolean;
    FFetchGeneratorsPoint: TFDFetchGeneratorsPoint;
    FGeneratorName: String;
    FCheckRequired: Boolean;
    FCheckReadOnly: Boolean;
    FCheckUpdatable: Boolean;
    FUpdateNonBaseFields: Boolean;
    FAutoCommitUpdates: Boolean;
    FAssignedValues: TFDUpdateOptionValues;
    function GetEnableDelete: Boolean;
    function GetEnableInsert: Boolean;
    function GetEnableUpdate: Boolean;
    procedure SetEnableDelete(AValue: Boolean);
    procedure SetEnableInsert(AValue: Boolean);
    procedure SetEnableUpdate(AValue: Boolean);
    function GetReadOnly: Boolean;
    procedure SetReadOnly(const AValue: Boolean);
    function IsEDS: Boolean;
    function IsEIS: Boolean;
    function IsEUS: Boolean;
    function GetUpdateChangedFields: Boolean;
    function GetUpdateMode: TUpdateMode;
    function IsUCFS: Boolean;
    function IsUMS: Boolean;
    procedure SetUpdateChangedFields(const AValue: Boolean);
    procedure SetUpdateMode(const AValue: TUpdateMode);
    function IsLMS: Boolean;
    function IsLPS: Boolean;
    procedure SetLockMode(const AValue: TFDLockMode);
    procedure SetLockPoint(const AValue: TFDLockPoint);
    function GetLockMode: TFDLockMode;
    function GetLockPoint: TFDLockPoint;
    function GetLockWait: Boolean;
    function IsLWS: Boolean;
    procedure SetLockWait(const AValue: Boolean);
    function GetRefreshMode: TFDRefreshMode;
    function IsRMS: Boolean;
    procedure SetRefreshMode(const AValue: TFDRefreshMode);
    function GetCountUpdatedRecords: Boolean;
    function IsCURS: Boolean;
    procedure SetCountUpdatedRecords(const AValue: Boolean);
    function GetFastUpdates: Boolean;
    procedure SetFastUpdates(const AValue: Boolean);
    function GetRequestLive: Boolean;
    procedure SetRequestLive(const AValue: Boolean);
    function GetFetchGeneratorsPoint: TFDFetchGeneratorsPoint;
    function IsGGPS: Boolean;
    procedure SetFetchGeneratorsPoint(const AValue: TFDFetchGeneratorsPoint);
    function GetGeneratorName: String;
    function IsGNS: Boolean;
    procedure SetGeneratorName(const AValue: String);
    function GetRefreshDelete: Boolean;
    function IsRDS: Boolean;
    procedure SetRefreshDelete(const AValue: Boolean);
    function GetCheckRequired: Boolean;
    function IsCRS: Boolean;
    procedure SetCheckRequired(const AValue: Boolean);
    function GetCheckReadOnly: Boolean;
    function IsCROS: Boolean;
    procedure SetCheckReadOnly(const AValue: Boolean);
    function GetCheckUpdatable: Boolean;
    function IsCUS: Boolean;
    procedure SetCheckUpdatable(const AValue: Boolean);
    function GetUpdateNonBaseFields: Boolean;
    function IsUNFS: Boolean;
    procedure SetUpdateNonBaseFields(const AValue: Boolean);
    procedure SetAutoCommitUpdates(const AValue: Boolean);
    function GetAutoCommitUpdates: Boolean;
    function IsACUS: Boolean;
  public
    procedure Assign(ASource: TPersistent); override;
    procedure RestoreDefaults; override;
    function IsValueOwned(AValue: TFDUpdateOptionValue; var AParentOpts: IFDStanOptions): Boolean;
    function CheckRequest(ARequest: TFDUpdateRequest; AOptions: TFDUpdateRowOptions;
      ACachedUpdates: Boolean): Boolean;
  published
    property AssignedValues: TFDUpdateOptionValues read FAssignedValues
      write FAssignedValues default [];
    property EnableDelete: Boolean read GetEnableDelete write SetEnableDelete
      stored IsEDS default True;
    property EnableInsert: Boolean read GetEnableInsert write SetEnableInsert
      stored IsEIS default True;
    property EnableUpdate: Boolean read GetEnableUpdate write SetEnableUpdate
      stored IsEUS default True;
    property UpdateChangedFields: Boolean read GetUpdateChangedFields
      write SetUpdateChangedFields stored IsUCFS default True;
    property UpdateNonBaseFields: Boolean read GetUpdateNonBaseFields
      write SetUpdateNonBaseFields stored IsUNFS default False;
    property UpdateMode: TUpdateMode read GetUpdateMode write SetUpdateMode
      stored IsUMS default upWhereKeyOnly;
    property LockMode: TFDLockMode read GetLockMode write SetLockMode
      stored IsLMS default lmNone;
    property LockPoint: TFDLockPoint read GetLockPoint write SetLockPoint
      stored IsLPS default lpDeferred;
    property LockWait: Boolean read GetLockWait write SetLockWait
      stored IsLWS default False;
    property RefreshMode: TFDRefreshMode read GetRefreshMode write SetRefreshMode
      stored IsRMS default rmOnDemand;
    property RefreshDelete: Boolean read GetRefreshDelete write SetRefreshDelete
      stored IsRDS default True;
    property CountUpdatedRecords: Boolean read GetCountUpdatedRecords
      write SetCountUpdatedRecords stored IsCURS default True;
    property FetchGeneratorsPoint: TFDFetchGeneratorsPoint read GetFetchGeneratorsPoint
      write SetFetchGeneratorsPoint stored IsGGPS default gpDeferred;
    property GeneratorName: String read GetGeneratorName write SetGeneratorName
      stored IsGNS;
    property CheckRequired: Boolean read GetCheckRequired write SetCheckRequired
      stored IsCRS default True;
    property CheckReadOnly: Boolean read GetCheckReadOnly write SetCheckReadOnly
      stored IsCROS default True;
    property CheckUpdatable: Boolean read GetCheckUpdatable write SetCheckUpdatable
      stored IsCUS default True;
    /// <summary> AutoCommitUpdates controls when successfully applied changed
    ///  records will be automatically marked as unchanged. When AutoCommitUpdates
    ///  is True, then updates will be automatically commited. This is default
    ///  TClientDataSet behaviour. When it is False, then after applying updates
    ///  an application should call CommitUpdates. This is default BDE behaviour. </summary>
    property AutoCommitUpdates: Boolean read GetAutoCommitUpdates write SetAutoCommitUpdates
      stored IsACUS default False;
    // short-cuts
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly
      stored False default False;
    property FastUpdates: Boolean read GetFastUpdates write SetFastUpdates
      stored False default False;
    property RequestLive: Boolean read GetRequestLive write SetRequestLive
      stored False default False;
  end;

  TFDBottomUpdateOptions = class(TFDUpdateOptions)
  private
    FUpdateTableName: String;
    FKeyFields: String;
    FAutoIncFields: String;
    procedure SetAutoIncFields(const AValue: String);
    procedure SetKeyFields(const AValue: String);
    procedure SetUpdateTableName(const AValue: String);
  public
    procedure Assign(ASource: TPersistent); override;
    procedure RestoreDefaults; override;
  published
    property UpdateTableName: String read FUpdateTableName write SetUpdateTableName;
    property KeyFields: String read FKeyFields write SetKeyFields;
    property AutoIncFields: String read FAutoIncFields write SetAutoIncFields;
  end;

  TFDResourceOptions = class(TFDCustomOptions)
  private
    FParamCreate: Boolean;
    FMacroCreate: Boolean;
    FParamExpand: Boolean;
    FMacroExpand: Boolean;
    FEscapeExpand: Boolean;
    FCmdExecMode: TFDStanAsyncMode;
    FCmdExecTimeout: Cardinal;
    FDirectExecute: Boolean;
    FDefaultParamType: TParamType;
    FPersistent: Boolean;
    FBackup: Boolean;
    FStoreVersion: Integer;
    FStoreItems: TFDStoreItems;
    FStorePrettyPrint: Boolean;
    FStoreMergeData: TFDMergeDataMode;
    FStoreMergeMeta: TFDMergeMetaMode;
    FArrayDMLSize: Integer;
    FSilentMode: Boolean;
    FUnifyParams: Boolean;
    FAssignedValues: TFDResourceOptionValues;
    function GetActualSilentMode: Boolean;
    function GetMacroCreate: Boolean;
    function GetParamCreate: Boolean;
    function IsMCS: Boolean;
    function IsPCS: Boolean;
    procedure SetMacroCreate(const AValue: Boolean);
    procedure SetParamCreate(const AValue: Boolean);
    function GetCmdExecMode: TFDStanAsyncMode;
    function GetCmdExecTimeout: Cardinal;
    function IsCEMS: Boolean;
    function IsCETS: Boolean;
    procedure SetCmdExecMode(const AValue: TFDStanAsyncMode);
    procedure SetCmdExecTimeout(const AValue: Cardinal);
    function GetDirectExecute: Boolean;
    function IsDES: Boolean;
    procedure SetDirectExecute(const AValue: Boolean);
    function GetEscapeExpand: Boolean;
    function GetMacroExpand: Boolean;
    function GetParamExpand: Boolean;
    function IsEPS: Boolean;
    function IsMES: Boolean;
    function IsPES: Boolean;
    procedure SetEscapeExpand(const AValue: Boolean);
    procedure SetMacroExpand(const AValue: Boolean);
    procedure SetParamExpand(const AValue: Boolean);
    function GetDefaultParamType: TParamType;
    function IsDPTS: Boolean;
    procedure SetDefaultParamType(const AValue: TParamType);
    function GetBackup: Boolean;
    function GetPersistent: Boolean;
    function IsBS: Boolean;
    function IsPS: Boolean;
    procedure SetBackup(const AValue: Boolean);
    procedure SetPersistent(const AValue: Boolean);
    function GetBackupExt: String;
    function GetBackupFolder: String;
    function GetDefaultStoreExt: String;
    function GetDefaultStoreFolder: String;
    function GetDefaultStoreFormat: TFDStorageFormat;
    function GetStoreVersion: Integer;
    procedure SetStoreVersion(const AValue: Integer);
    function IsSTV: Boolean;
    function GetPreprocessCmdText: Boolean;
    procedure SetPreprocessCmdText(const AValue: Boolean);
    function GetArrayDMLSize: Integer;
    function IsADSS: Boolean;
    procedure SetArrayDMLSize(const AValue: Integer);
    function GetSilentMode: Boolean;
    function IsSMS: Boolean;
    procedure SetSilentMode(const AValue: Boolean);
    function GetUnifyParams: Boolean;
    procedure SetUnifyParams(const AValue: Boolean);
    function IsUPS: Boolean;
    function GetStoreItems: TFDStoreItems;
    function IsSIS: Boolean;
    procedure SetStoreItems(const AValue: TFDStoreItems);
    function GetStorePrettyPrint: Boolean;
    function IsSPPS: Boolean;
    procedure SetStorePrettyPrint(const AValue: Boolean);
    function GetStoreMergeMeta: TFDMergeMetaMode;
    function GetStoreMergeData: TFDMergeDataMode;
    function IsSMMS: Boolean;
    function IsSMOS: Boolean;
    procedure SetStoreMergeMeta(const AValue: TFDMergeMetaMode);
    procedure SetStoreMergeData(const AValue: TFDMergeDataMode);
    function GetStoreMerge: Boolean;
  public
    procedure Assign(ASource: TPersistent); override;
    procedure RestoreDefaults; override;
    function IsValueOwned(AValue: TFDResourceOptionValue; var AParentOpts: IFDStanOptions): Boolean;
    property DefaultStoreFolder: String read GetDefaultStoreFolder;
    property DefaultStoreExt: String read GetDefaultStoreExt;
    property DefaultStoreFormat: TFDStorageFormat read GetDefaultStoreFormat;
    property BackupFolder: String read GetBackupFolder;
    property BackupExt: String read GetBackupExt;
    property PreprocessCmdText: Boolean read GetPreprocessCmdText
      write SetPreprocessCmdText;
    property ActualSilentMode: Boolean read GetActualSilentMode;
    /// <summary> StoreMerge property returns True, when StoreMergeData and/or
    ///  StoreMergeMeta are not "none". </summary>
    property StoreMerge: Boolean read GetStoreMerge;
  published
    property AssignedValues: TFDResourceOptionValues read FAssignedValues
      write FAssignedValues default [];
    property ParamCreate: Boolean read GetParamCreate write SetParamCreate
      stored IsPCS default True;
    property MacroCreate: Boolean read GetMacroCreate write SetMacroCreate
      stored IsMCS default True;
    property ParamExpand: Boolean read GetParamExpand write SetParamExpand
      stored IsPES default True;
    property MacroExpand: Boolean read GetMacroExpand write SetMacroExpand
      stored IsMES default True;
    property EscapeExpand: Boolean read GetEscapeExpand write SetEscapeExpand
      stored IsEPS default True;
    property CmdExecMode: TFDStanAsyncMode read GetCmdExecMode
      write SetCmdExecMode stored IsCEMS default amBlocking;
    property CmdExecTimeout: Cardinal read GetCmdExecTimeout
      write SetCmdExecTimeout stored IsCETS default $FFFFFFFF;
    property DirectExecute: Boolean read GetDirectExecute
      write SetDirectExecute stored IsDES default False;
    property DefaultParamType: TParamType read GetDefaultParamType
      write SetDefaultParamType stored IsDPTS default ptInput;
    property Persistent: Boolean read GetPersistent write SetPersistent
      stored IsPS default False;
    property Backup: Boolean read GetBackup write SetBackup
      stored IsBS default False;
    property StoreVersion: Integer read GetStoreVersion write SetStoreVersion
      stored IsSTV default -1;
    property StoreItems: TFDStoreItems read GetStoreItems
      write SetStoreItems stored IsSIS default [siMeta, siData, siDelta];
    property StorePrettyPrint: Boolean read GetStorePrettyPrint
      write SetStorePrettyPrint stored IsSPPS default False;
    /// <summary> StoreMergeData property controls data merging mode at loading
    /// a stream or file into an active dataset. By default no merging is performed
    /// and data will be overwritten. </summary>
    property StoreMergeData: TFDMergeDataMode read GetStoreMergeData
      write SetStoreMergeData stored IsSMOS default dmNone;
    /// <summary> StoreMergeMeta property controls metainfo merging mode at loading
    /// a stream or file into an active dataset. By default no merging is performed
    /// and metadata will be overwritten. </summary>
    property StoreMergeMeta: TFDMergeMetaMode read GetStoreMergeMeta
      write SetStoreMergeMeta stored IsSMMS default mmNone;
    property ArrayDMLSize: Integer read GetArrayDMLSize write SetArrayDMLSize
      stored IsADSS default $7FFFFFFF;
    property SilentMode: Boolean read GetSilentMode write SetSilentMode
      stored IsSMS default False;
    property UnifyParams: Boolean read GetUnifyParams
      write SetUnifyParams stored IsUPS default False;
  end;

  TFDTopResourceOptions = class(TFDResourceOptions)
  private
    FMaxCursors: Integer;
    FServerOutput: Boolean;
    FServerOutputSize: Integer;
    FDefaultStoreFolder: String;
    FBackupFolder: String;
    FDefaultStoreExt: String;
    FDefaultStoreFormat: TFDStorageFormat;
    FBackupExt: String;
    FAutoConnect: Boolean;
    FAutoReconnect: Boolean;
    FKeepConnection: Boolean;
    function GetMaxCursors: Integer;
    procedure SetMaxCursors(const AValue: Integer);
    function IsMCS: Boolean;
    function GetServerOutput: Boolean;
    function IsSOS: Boolean;
    procedure SetServerOutput(const AValue: Boolean);
    function GetServerOutputSize: Integer;
    function IsSOSS: Boolean;
    procedure SetServerOutputSize(const AValue: Integer);
    function IsBES: Boolean;
    function IsBFS: Boolean;
    function IsDSES: Boolean;
    function IsDSFS: Boolean;
    function IsDSTS: Boolean;
    procedure SetBackupExt(const AValue: String);
    procedure SetBackupFolder(const AValue: String);
    procedure SetDefaultStoreExt(const AValue: String);
    procedure SetDefaultStoreFolder(const AValue: String);
    procedure SetDefaultStoreFormat(const AValue: TFDStorageFormat);
    function GetAutoReconnect: Boolean;
    function IsARS: Boolean;
    procedure SetAutoReconnect(const AValue: Boolean);
    function GetKeepConnection: Boolean;
    function IsKCS: Boolean;
    procedure SetKeepConnection(const AValue: Boolean);
    function GetAutoConnect: Boolean;
    function IsACS: Boolean;
    procedure SetAutoConnect(const AValue: Boolean);
  public
    procedure Assign(ASource: TPersistent); override;
    procedure RestoreDefaults; override;
  published
    property MaxCursors: Integer read GetMaxCursors write SetMaxCursors
      stored IsMCS default -1;
    property ServerOutput: Boolean read GetServerOutput
      write SetServerOutput stored IsSOS default False;
    property ServerOutputSize: Integer read GetServerOutputSize
      write SetServerOutputSize stored IsSOSS default 20000;
    property DefaultStoreFolder write SetDefaultStoreFolder stored IsDSFS;
    property BackupFolder write SetBackupFolder stored IsBFS;
    property DefaultStoreExt write SetDefaultStoreExt stored IsDSES;
    property DefaultStoreFormat write SetDefaultStoreFormat stored IsDSTS
      default sfAuto;
    property BackupExt write SetBackupExt stored IsBES;
    property AutoConnect: Boolean read GetAutoConnect write SetAutoConnect
      stored IsACS default True;
    property AutoReconnect: Boolean read GetAutoReconnect write SetAutoReconnect
      stored IsARS default False;
    property KeepConnection: Boolean read GetKeepConnection write SetKeepConnection
      stored IsKCS default True;
  end;

  TFDBottomResourceOptions = class(TFDResourceOptions)
  private
    FPersistentFileName: String;
  public
    procedure Assign(ASource: TPersistent); override;
    procedure RestoreDefaults; override;
    function ResolveFileName(const AFileName: String = ''): String;
    function GetStorage(const AFileName: String; AFormat: TFDStorageFormat): IFDStanStorage;
  published
    property PersistentFileName: string read FPersistentFileName
      write FPersistentFileName;
  end;

  TFDTxOptions = class (TPersistent)
  private
    FStopOptions: TFDTxStopOptions;
    FIsolation: TFDTxIsolation;
    FReadOnly: Boolean;
    FParams: TStrings;
    FAutoStart: Boolean;
    FAutoStop: Boolean;
    FDisconnectAction: TFDTxAction;
    FEnableNested: Boolean;
    FChanged: TFDTxValues;
    procedure SetAutoCommit(const AValue: Boolean);
    procedure SetIsolation(const AValue: TFDTxIsolation);
    procedure SetReadOnly(const AValue: Boolean);
    procedure SetParams(const AValue: TStrings);
    procedure DoParamsChanged(ASender: TObject);
    procedure SetAutoStart(const AValue: Boolean);
    procedure SetAutoStop(const AValue: Boolean);
    function GetAutoCommit: Boolean;
    procedure SetStopOptions(const AValue: TFDTxStopOptions);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(ASource: TPersistent); override;
    procedure ClearChanged;
    procedure ResetChanged;
    property Changed: TFDTxValues read FChanged write FChanged;
  published
    property Isolation: TFDTxIsolation read FIsolation write SetIsolation
      default xiReadCommitted;
    property ReadOnly: Boolean read FReadOnly write SetReadOnly default False;
    property Params: TStrings read FParams write SetParams;
    property AutoCommit: Boolean read GetAutoCommit write SetAutoCommit
      stored False default True;
    property AutoStart: Boolean read FAutoStart write SetAutoStart default True;
    property AutoStop: Boolean read FAutoStop write SetAutoStop default True;
    property StopOptions: TFDTxStopOptions read FStopOptions write SetStopOptions
      default [xoIfAutoStarted, xoIfCmdsInactive];
    property DisconnectAction: TFDTxAction read FDisconnectAction write FDisconnectAction
      default xdCommit;
    property EnableNested: Boolean read FEnableNested write FEnableNested default True;
  end;

  TFDEventAlerterOptions = class (TPersistent)
  private
    FKind: String;
    FTimeout: Integer;
    FSynchronize: Boolean;
    FAutoRegister: Boolean;
    FMergeData: TFDMergeDataMode;
    FAutoRefresh: TFDAutoRefresh;
  public
    constructor Create;
    procedure Assign(ASource: TPersistent); override;
  published
    property Kind: String read FKind write FKind;
    property Timeout: Integer read FTimeout write FTimeout default -1;
    property Synchronize: Boolean read FSynchronize write FSynchronize default True;
    property AutoRegister: Boolean read FAutoRegister write FAutoRegister default False;
    /// <summary> MergeData property controls data merging mode at refreshing a
    /// change handler (eg, TFDAdaptedDataSet) content after receiving a change
    /// notification. The property used only when a database supports incremental
    /// refreshing of content, like InterBase XE7. By default incoming changes
    /// will be merged into existing data. </summary>
    property MergeData: TFDMergeDataMode read FMergeData write FMergeData default dmDataMerge;
    /// <summary> AutoRefresh property controls when change handler content
    /// (eg, TFDAdaptedDataSet) will be refreshed. Possible values:
    /// * afNone - content will be not refreshed automatically. Instead application
    ///  may check IFDPhysChangeHandler.ContentModified. For example:
    ///  (FDQuery1 as IFDPhysChangeHandler).ContentModified.
    /// * afAlert - content will be refreshed automatically right after receiving
    ///  a change notification by event alerter.
    /// * afTimeout - content will be refreshed automatically after Timeout timeout
    ///  after receiving a change notification by event alerter. </summary>
    property AutoRefresh: TFDAutoRefresh read FAutoRefresh write FAutoRefresh default afAlert;
  end;

implementation

uses
  Data.FmtBcd, Data.SqlTimSt,
{$IFNDEF NEXTGEN}
  System.AnsiStrings,
{$ENDIF}
  FireDAC.Stan.Error, FireDAC.Stan.SQLTimeInt, FireDAC.Stan.Factory,
  FireDAC.UI.Intf;

{-------------------------------------------------------------------------------}
const
  C_FD_AllowedConversions: array[TFDDataType {src}, TFDDataType {dest}] of Byte = (
    (1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
    (0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
    (0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
    (0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
    (0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
    (0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
    (0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
    (0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
    (0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
    (0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
    (0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
    (0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
    (0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
    (0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
    (0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
    (0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
    (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
    (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
    (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
    (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
    (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
    (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
    (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
    (0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 0),
    (0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 0),
    (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 0),
    (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 0),
    (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0),
    (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0),
    (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0),
    (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 0),
    (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0),
    (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0),
    (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 0),
    (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0),
    (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0),
    (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0),
    (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0),
    (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0),
    (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0),
    (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1)
  );

{-------------------------------------------------------------------------------}
{ TFDOptionsContainer                                                           }
{-------------------------------------------------------------------------------}
constructor TFDOptionsContainer.Create(AOwnerObj: TPersistent;
  AFetchClass: TFDFetchOptionsClass; AUpdateClass: TFDUpdateOptionsClass;
  AResourceClass: TFDResourceOptionsClass; AParentCallback: TFDOptionsParentCallback);
begin
  inherited Create;
  FOwnerObj := AOwnerObj;
  FFormatOptions := TFDFormatOptions.Create(Self);
  FFetchOptions := AFetchClass.Create(Self);
  FUpdateOptions := AUpdateClass.Create(Self);
  FResourceOptions := AResourceClass.Create(Self);
  FParentCallback := AParentCallback;
  FParentOriginalCallback := AParentCallback;
end;

{-------------------------------------------------------------------------------}
destructor TFDOptionsContainer.Destroy;
begin
  FDFreeAndNil(FFormatOptions);
  FDFreeAndNil(FFetchOptions);
  FDFreeAndNil(FUpdateOptions);
  FDFreeAndNil(FResourceOptions);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
function TFDOptionsContainer.GetFetchOptions: TFDFetchOptions;
begin
  Result := FFetchOptions;
end;

{-------------------------------------------------------------------------------}
function TFDOptionsContainer.GetFormatOptions: TFDFormatOptions;
begin
  Result := FFormatOptions;
end;

{-------------------------------------------------------------------------------}
function TFDOptionsContainer.GetResourceOptions: TFDResourceOptions;
begin
  Result := FResourceOptions;
end;

{-------------------------------------------------------------------------------}
function TFDOptionsContainer.GetUpdateOptions: TFDUpdateOptions;
begin
  Result := FUpdateOptions;
end;

{-------------------------------------------------------------------------------}
function TFDOptionsContainer.GetParentOptions: IFDStanOptions;
begin
  if Assigned(FParentCallback) then
    FParentCallback(Result)
  else
    Result := nil;
end;

{-------------------------------------------------------------------------------}
procedure TFDOptionsContainer.InternalParentOptionsCallback(var AOpts: IFDStanOptions);
begin
  AOpts := FParentOptions;
end;

{-------------------------------------------------------------------------------}
procedure TFDOptionsContainer.SetParentOptions(const AValue: IFDStanOptions);
begin
  if FParentOptions <> AValue then begin
    FParentOptions := AValue;
    if FParentOptions = nil then
      FParentCallback := FParentOriginalCallback
    else
      FParentCallback := InternalParentOptionsCallback;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDOptionsContainer.ObjectDestroyed(AObj: TPersistent);
begin
  if AObj = FOwnerObj then
    FOwnerObj := nil;
end;

{-------------------------------------------------------------------------------}
{- TFDCustomOptions                                                            -}
{-------------------------------------------------------------------------------}
{$HINTS OFF}
constructor TFDCustomOptions.Create(AContainer: TFDOptionsContainer);
begin
  inherited Create;
  FContainer := AContainer;
  RestoreDefaults;
end;
{$HINTS ON}

{-------------------------------------------------------------------------------}
procedure TFDCustomOptions.Assign(ASource: TPersistent);
begin
  inherited Assign(ASource);
  // nothing
end;

{-------------------------------------------------------------------------------}
procedure TFDCustomOptions.RestoreDefaults;
begin
  // nothing
end;

{-------------------------------------------------------------------------------}
function TFDCustomOptions.GetOwner: TPersistent;
begin
  if FContainer <> nil then
    Result := FContainer.FOwnerObj
  else
    Result := nil;
end;

{-------------------------------------------------------------------------------}
function TFDCustomOptions.GetOwnerObj: TPersistent;
begin
  Result := GetOwner;
end;

{-------------------------------------------------------------------------------}
{- TFDMapRule                                                                  -}
{-------------------------------------------------------------------------------}
constructor TFDMapRule.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FPrecMax := C_FD_DefMapPrec;
  FPrecMin := C_FD_DefMapPrec;
  FScaleMax := C_FD_DefMapScale;
  FScaleMin := C_FD_DefMapScale;
  FSizeMax := C_FD_DefMapSize;
  FSizeMin := C_FD_DefMapSize;
  FSourceDataType := dtUnknown;
  FTargetDataType := dtUnknown;
end;

{-------------------------------------------------------------------------------}
procedure TFDMapRule.Assign(Source: TPersistent);
begin
  if Source is TFDMapRule then begin
    FPrecMax := TFDMapRule(Source).FPrecMax;
    FPrecMin := TFDMapRule(Source).FPrecMin;
    FScaleMax := TFDMapRule(Source).FScaleMax;
    FScaleMin := TFDMapRule(Source).FScaleMin;
    FSizeMax := TFDMapRule(Source).FSizeMax;
    FSizeMin := TFDMapRule(Source).FSizeMin;
    FSourceDataType := TFDMapRule(Source).FSourceDataType;
    FTargetDataType := TFDMapRule(Source).FTargetDataType;
    FNameMask := TFDMapRule(Source).FNameMask;
    FTypeMask := TFDMapRule(Source).FTypeMask;
  end
  else
    inherited Assign(Source);
end;

{-------------------------------------------------------------------------------}
procedure TFDMapRule.SetSourceDataType(AValue: TFDDataType);
begin
  if FSourceDataType <> AValue then begin
    if (Collection <> nil) and (TFDMapRules(Collection).FFormatOptions <> nil) and
       (AValue <> dtUnknown) and (FTargetDataType <> dtUnknown) then
      TFDMapRules(Collection).FFormatOptions.CheckConversion(AValue, FTargetDataType);
    FSourceDataType := AValue;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDMapRule.SetTargetDataType(AValue: TFDDataType);
begin
  if FTargetDataType <> AValue then begin
    if (Collection <> nil) and (TFDMapRules(Collection).FFormatOptions <> nil) and
       (AValue <> dtUnknown) and (FSourceDataType <> dtUnknown) then
      TFDMapRules(Collection).FFormatOptions.CheckConversion(FSourceDataType, AValue);
    FTargetDataType := AValue;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDMapRule.GetDisplayName: string;
begin
  if (SourceDataType = dtUnknown) and (TargetDataType = dtUnknown) then
    Result := inherited GetDisplayName
  else begin
    if (SourceDataType = dtUnknown) and (NameMask <> '') then
      Result := 'N:' + NameMask
    else if (SourceDataType = dtUnknown) and (TypeMask <> '') then
      Result := 'T:' + TypeMask
    else
      Result := C_FD_DataTypeNames[SourceDataType];
    Result := Result + ' -> ' + C_FD_DataTypeNames[TargetDataType];
  end;
end;

{-------------------------------------------------------------------------------}
{- TFDMapRules                                                                 -}
{-------------------------------------------------------------------------------}
constructor TFDMapRules.Create(AFormatOptions: TFDFormatOptions);
begin
  inherited Create(TFDMapRule);
  FFormatOptions := AFormatOptions;
end;

{-------------------------------------------------------------------------------}
function TFDMapRules.Add: TFDMapRule;
begin
  Result := TFDMapRule(inherited Add);
end;

{-------------------------------------------------------------------------------}
procedure TFDMapRules.Add(APrecMin, APrecMax, AScaleMin,
  AScaleMax: Integer; ASourceDataType, ATargetDataType: TFDDataType);
var
  oRule: TFDMapRule;
begin
  oRule := Add;
  oRule.PrecMin := APrecMin;
  oRule.PrecMax := APrecMax;
  oRule.ScaleMin := AScaleMin;
  oRule.ScaleMax := AScaleMax;
  oRule.SourceDataType := ASourceDataType;
  oRule.TargetDataType := ATargetDataType;
end;

{-------------------------------------------------------------------------------}
procedure TFDMapRules.Add(ASizeMin, ASizeMax: Integer; ASourceDataType,
  ATargetDataType: TFDDataType);
var
  oRule: TFDMapRule;
begin
  oRule := Add;
  oRule.SizeMin := ASizeMin;
  oRule.SizeMax := ASizeMax;
  oRule.SourceDataType := ASourceDataType;
  oRule.TargetDataType := ATargetDataType;
end;

{-------------------------------------------------------------------------------}
procedure TFDMapRules.Add(ASourceDataType, ATargetDataType: TFDDataType);
var
  oRule: TFDMapRule;
begin
  oRule := Add;
  oRule.SourceDataType := ASourceDataType;
  oRule.TargetDataType := ATargetDataType;
end;

{-------------------------------------------------------------------------------}
procedure TFDMapRules.RemoveForSourceDataType(ADataType: TFDDataType);
var
  i: Integer;
begin
  for i := Count - 1 downto 0 do
    if Items[i].SourceDataType = ADataType then
      Delete(i);
end;

{-------------------------------------------------------------------------------}
procedure TFDMapRules.RemoveForTargetDataType(ADataType: TFDDataType);
var
  i: Integer;
begin
  for i := Count - 1 downto 0 do
    if Items[i].TargetDataType = ADataType then
      Delete(i);
end;

{-------------------------------------------------------------------------------}
function TFDMapRules.GetItems(AIndex: Integer): TFDMapRule;
begin
  Result := TFDMapRule(inherited Items[AIndex]);
end;

{-------------------------------------------------------------------------------}
function TFDMapRules.GetOwner: TPersistent;
begin
  Result := FFormatOptions;
end;

{-------------------------------------------------------------------------------}
{- TFDFormatOptions                                                            -}
{-------------------------------------------------------------------------------}
constructor TFDFormatOptions.Create(AContainer: TFDOptionsContainer);
begin
  FMapRules := TFDMapRules.Create(Self);
  inherited Create(AContainer);
end;

{-------------------------------------------------------------------------------}
destructor TFDFormatOptions.Destroy;
begin
  FDFreeAndNil(FMapRules);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TFDFormatOptions.Assign(ASource: TPersistent);
begin
  if (ASource = nil) or (ASource = Self) then
    Exit;
  if ASource is TFDFormatOptions then begin
    if fvMapRules in TFDFormatOptions(ASource).FAssignedValues then
      MapRules.Assign(TFDFormatOptions(ASource).MapRules);
    if fvSE2Null in TFDFormatOptions(ASource).FAssignedValues then
      StrsEmpty2Null := TFDFormatOptions(ASource).StrsEmpty2Null;
    if fvStrsTrim in TFDFormatOptions(ASource).FAssignedValues then
      StrsTrim := TFDFormatOptions(ASource).StrsTrim;
    if fvStrsTrim2Len in TFDFormatOptions(ASource).FAssignedValues then
      StrsTrim2Len := TFDFormatOptions(ASource).StrsTrim2Len;
    if fvMaxStringSize in TFDFormatOptions(ASource).FAssignedValues then
      MaxStringSize := TFDFormatOptions(ASource).MaxStringSize;
    if fvMaxBcdPrecision in TFDFormatOptions(ASource).FAssignedValues then
      MaxBcdPrecision := TFDFormatOptions(ASource).MaxBcdPrecision;
    if fvMaxBcdScale in TFDFormatOptions(ASource).FAssignedValues then
      MaxBcdScale := TFDFormatOptions(ASource).MaxBcdScale;
    if fvInlineDataSize in TFDFormatOptions(ASource).FAssignedValues then
      InlineDataSize := TFDFormatOptions(ASource).InlineDataSize;
    if fvDefaultParamDataType in TFDFormatOptions(ASource).FAssignedValues then
      DefaultParamDataType := TFDFormatOptions(ASource).DefaultParamDataType;
    if fvRound2Scale in TFDFormatOptions(ASource).FAssignedValues then
      Round2Scale := TFDFormatOptions(ASource).Round2Scale;
    if fvCheckPrecision in TFDFormatOptions(ASource).FAssignedValues then
      CheckPrecision := TFDFormatOptions(ASource).CheckPrecision;
    if fvDataSnapCompatibility in TFDFormatOptions(ASource).FAssignedValues then
      DataSnapCompatibility := TFDFormatOptions(ASource).DataSnapCompatibility;
    if fvFmtDisplayDateTime in TFDFormatOptions(ASource).FAssignedValues then
      FmtDisplayDateTime := TFDFormatOptions(ASource).FmtDisplayDateTime;
    if fvFmtDisplayDate in TFDFormatOptions(ASource).FAssignedValues then
      FmtDisplayDate := TFDFormatOptions(ASource).FmtDisplayDate;
    if fvFmtDisplayTime in TFDFormatOptions(ASource).FAssignedValues then
      FmtDisplayTime := TFDFormatOptions(ASource).FmtDisplayTime;
    if fvFmtDisplayNumeric in TFDFormatOptions(ASource).FAssignedValues then
      FmtDisplayNumeric := TFDFormatOptions(ASource).FmtDisplayNumeric;
    if fvFmtEditNumeric in TFDFormatOptions(ASource).FAssignedValues then
      FmtEditNumeric := TFDFormatOptions(ASource).FmtEditNumeric;
    if fvQuoteIdentifiers in TFDFormatOptions(ASource).FAssignedValues then
      QuoteIdentifiers := TFDFormatOptions(ASource).QuoteIdentifiers;
    if fvSortLocale in TFDFormatOptions(ASource).FAssignedValues then
      SortLocale := TFDFormatOptions(ASource).SortLocale;
    if fvSortOptions in TFDFormatOptions(ASource).FAssignedValues then
      SortOptions := TFDFormatOptions(ASource).SortOptions;
  end
  else
    inherited Assign(ASource);
end;

{-------------------------------------------------------------------------------}
procedure TFDFormatOptions.RestoreDefaults;
begin
  inherited RestoreDefaults;
  FAssignedValues := [];
  FStrsEmpty2Null := False;
  FStrsTrim := True;
  FStrsTrim2Len := False;
  FMaxStringSize := C_FD_DefMaxStrSize;
  FMaxBcdPrecision := 18;
  FMaxBcdScale := 4;
  FMapRules.Clear;
  FInlineDataSize := C_FD_DefInlineDataSize;
  FDefaultParamDataType := ftUnknown;
  FRound2Scale := False;
  FCheckPrecision := False;
  FDataSnapCompatibility := False;
  FFmtDisplayDateTime := '';
  FFmtDisplayDate := '';
  FFmtDisplayTime := '';
  FFmtDisplayNumeric := '';
  FFmtEditNumeric := '';
  FQuoteIdentifiers := False;
  FSortLocale := LOCALE_USER_DEFAULT;
  FSortOptions := [];
  Inc(FVersion);
end;

{-------------------------------------------------------------------------------}
function TFDFormatOptions.IsValueOwned(AValue: TFDFormatOptionValue;
  var AParentOpts: IFDStanOptions): Boolean;
begin
  Result := not Assigned(Container.FParentCallback) or (AValue in FAssignedValues);
  if not Result then begin
    Container.FParentCallback(AParentOpts);
    Result := (AParentOpts = nil);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDFormatOptions.GetMapRules: TFDMapRules;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(fvMapRules, oParentOpts) then
    Result := FMapRules
  else
    Result := oParentOpts.FormatOptions.MapRules;
end;

{-------------------------------------------------------------------------------}
procedure TFDFormatOptions.SetMapRules(const AValue: TFDMapRules);
begin
  FMapRules.Assign(AValue);
  Include(FAssignedValues, fvMapRules);
  Inc(FVersion);
end;

{-------------------------------------------------------------------------------}
function TFDFormatOptions.IsMRS: Boolean;
begin
  Result := fvMapRules in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
procedure TFDFormatOptions.SetOwnMapRules(const AValue: Boolean);
var
  oParentOpts: IFDStanOptions;
begin
  if (fvMapRules in FAssignedValues) <> AValue then begin
    if AValue then begin
      if Assigned(Container.FParentCallback) then begin
        Container.FParentCallback(oParentOpts);
        if oParentOpts <> nil then
          FMapRules.Assign(oParentOpts.FormatOptions.MapRules);
      end;
      Include(FAssignedValues, fvMapRules);
    end
    else begin
      if Assigned(Container.FParentCallback) then begin
        Container.FParentCallback(oParentOpts);
        if oParentOpts <> nil then
          FMapRules.Clear;
      end;
      Exclude(FAssignedValues, fvMapRules);
    end;
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDFormatOptions.GetStrsEmpty2Null: Boolean;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(fvSE2Null, oParentOpts) then
    Result := FStrsEmpty2Null
  else
    Result := oParentOpts.FormatOptions.StrsEmpty2Null;
end;

{-------------------------------------------------------------------------------}
procedure TFDFormatOptions.SetStrsEmpty2Null(AValue: Boolean);
begin
  if not (fvSE2Null in FAssignedValues) or (FStrsEmpty2Null <> AValue) then begin
    FStrsEmpty2Null := AValue;
    Include(FAssignedValues, fvSE2Null);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDFormatOptions.IsSE2NS: Boolean;
begin
  Result := fvSE2Null in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDFormatOptions.GetStrsTrim: Boolean;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(fvStrsTrim, oParentOpts) then
    Result := FStrsTrim
  else
    Result := oParentOpts.FormatOptions.StrsTrim;
end;

{-------------------------------------------------------------------------------}
procedure TFDFormatOptions.SetStrsTrim(AValue: Boolean);
begin
  if not (fvStrsTrim in FAssignedValues) or (FStrsTrim <> AValue) then begin
    FStrsTrim := AValue;
    Include(FAssignedValues, fvStrsTrim);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDFormatOptions.IsSTS: Boolean;
begin
  Result := fvStrsTrim in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDFormatOptions.GetStrsTrim2Len: Boolean;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(fvStrsTrim2Len, oParentOpts) then
    Result := FStrsTrim2Len
  else
    Result := oParentOpts.FormatOptions.StrsTrim2Len;
end;

{-------------------------------------------------------------------------------}
procedure TFDFormatOptions.SetStrsTrim2Len(const AValue: Boolean);
begin
  if not (fvStrsTrim2Len in FAssignedValues) or (FStrsTrim2Len <> AValue) then begin
    FStrsTrim2Len := AValue;
    Include(FAssignedValues, fvStrsTrim2Len);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDFormatOptions.IsSTTLS: Boolean;
begin
  Result := fvStrsTrim2Len in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDFormatOptions.GetStrsDivLen2: Boolean;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(fvStrsDivLen2, oParentOpts) then
    Result := FStrsDivLen2
  else
    Result := oParentOpts.FormatOptions.StrsDivLen2;
end;

{-------------------------------------------------------------------------------}
procedure TFDFormatOptions.SetStrsDivLen2(const AValue: Boolean);
begin
  if not (fvStrsDivLen2 in FAssignedValues) or (FStrsDivLen2 <> AValue) then begin
    FStrsDivLen2 := AValue;
    Include(FAssignedValues, fvStrsDivLen2);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDFormatOptions.IsSDL2S: Boolean;
begin
  Result := fvStrsDivLen2 in AssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDFormatOptions.GetMaxStringSize: LongWord;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(fvMaxStringSize, oParentOpts) then
    Result := FMaxStringSize
  else
    Result := oParentOpts.FormatOptions.MaxStringSize;
end;

{-------------------------------------------------------------------------------}
function TFDFormatOptions.GetQuoteIdentifiers: Boolean;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(fvQuoteIdentifiers, oParentOpts) then
    Result := FQuoteIdentifiers
  else
    Result := oParentOpts.FormatOptions.QuoteIdentifiers;
end;

{-------------------------------------------------------------------------------}
procedure TFDFormatOptions.SetQuoteIdentifiers(const AValue: Boolean);
begin
  if not (fvQuoteIdentifiers in FAssignedValues) or (FQuoteIdentifiers <> AValue) then begin
    FQuoteIdentifiers := AValue;
    Include(FAssignedValues, fvQuoteIdentifiers);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDFormatOptions.IsQIDS: Boolean;
begin
  Result := fvQuoteIdentifiers in AssignedValues;
end;

{-------------------------------------------------------------------------------}
procedure TFDFormatOptions.SetMaxStringSize(const AValue: LongWord);
begin
  if not (fvMaxStringSize in FAssignedValues) or (FMaxStringSize <> AValue) then begin
    FMaxStringSize := AValue;
    Include(FAssignedValues, fvMaxStringSize);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDFormatOptions.IsMSSS: Boolean;
begin
  Result := fvMaxStringSize in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDFormatOptions.GetMaxBcdPrecision: Integer;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(fvMaxBcdPrecision, oParentOpts) then
    Result := FMaxBcdPrecision
  else
    Result := oParentOpts.FormatOptions.MaxBcdPrecision;
end;

{-------------------------------------------------------------------------------}
procedure TFDFormatOptions.SetMaxBcdPrecision(const AValue: Integer);
begin
  if not (fvMaxBcdPrecision in FAssignedValues) or (FMaxBcdPrecision <> AValue) then begin
    FMaxBcdPrecision := AValue;
    Include(FAssignedValues, fvMaxBcdPrecision);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDFormatOptions.IsMBPS: Boolean;
begin
  Result := fvMaxBcdPrecision in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDFormatOptions.GetMaxBcdScale: Integer;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(fvMaxBcdScale, oParentOpts) then
    Result := FMaxBcdScale
  else
    Result := oParentOpts.FormatOptions.MaxBcdScale;
end;

{-------------------------------------------------------------------------------}
procedure TFDFormatOptions.SetMaxBcdScale(const AValue: Integer);
begin
  if not (fvMaxBcdScale in FAssignedValues) or (FMaxBcdScale <> AValue) then begin
    FMaxBcdScale := AValue;
    Include(FAssignedValues, fvMaxBcdScale);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDFormatOptions.IsMBSS: Boolean;
begin
  Result := fvMaxBcdScale in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDFormatOptions.GetInlineDataSize: Integer;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(fvInlineDataSize, oParentOpts) then
    Result := FInlineDataSize
  else
    Result := oParentOpts.FormatOptions.InlineDataSize;
end;

{-------------------------------------------------------------------------------}
procedure TFDFormatOptions.SetInlineDataSize(const AValue: Integer);
begin
  if not (fvInlineDataSize in FAssignedValues) or (FInlineDataSize <> AValue) then begin
    FInlineDataSize := AValue;
    Include(FAssignedValues, fvInlineDataSize);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDFormatOptions.IsIDSS: Boolean;
begin
  Result := fvInlineDataSize in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDFormatOptions.GetDefaultParamDataType: TFieldType;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(fvDefaultParamDataType, oParentOpts) then
    Result := FDefaultParamDataType
  else
    Result := oParentOpts.FormatOptions.DefaultParamDataType;
end;

{-------------------------------------------------------------------------------}
procedure TFDFormatOptions.SetDefaultParamDataType(const AValue: TFieldType);
begin
  if not (fvDefaultParamDataType in FAssignedValues) or (FDefaultParamDataType <> AValue) then begin
    FDefaultParamDataType := AValue;
    Include(FAssignedValues, fvDefaultParamDataType);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDFormatOptions.IsDPDTS: Boolean;
begin
  Result := fvDefaultParamDataType in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDFormatOptions.GetRound2Scale: Boolean;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(fvRound2Scale, oParentOpts) then
    Result := FRound2Scale
  else
    Result := oParentOpts.FormatOptions.Round2Scale;
end;

{-------------------------------------------------------------------------------}
procedure TFDFormatOptions.SetRound2Scale(const AValue: Boolean);
begin
  if not (fvRound2Scale in FAssignedValues) or (FRound2Scale <> AValue) then begin
    FRound2Scale := AValue;
    Include(FAssignedValues, fvRound2Scale);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDFormatOptions.IsRSS: Boolean;
begin
  Result := fvRound2Scale in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDFormatOptions.GetCheckPrecision: Boolean;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(fvCheckPrecision, oParentOpts) then
    Result := FCheckPrecision
  else
    Result := oParentOpts.FormatOptions.CheckPrecision;
end;

{-------------------------------------------------------------------------------}
procedure TFDFormatOptions.SetCheckPrecision(const AValue: Boolean);
begin
  if not (fvCheckPrecision in FAssignedValues) or (FCheckPrecision <> AValue) then begin
    FCheckPrecision := AValue;
    Include(FAssignedValues, fvCheckPrecision);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDFormatOptions.IsCPS: Boolean;
begin
  Result := fvCheckPrecision in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDFormatOptions.GetDataSnapCompatibility: Boolean;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(fvDataSnapCompatibility, oParentOpts) then
    Result := FDataSnapCompatibility
  else
    Result := oParentOpts.FormatOptions.DataSnapCompatibility;
end;

{-------------------------------------------------------------------------------}
procedure TFDFormatOptions.SetDataSnapCompatibility(const AValue: Boolean);
begin
  if not (fvDataSnapCompatibility in FAssignedValues) or (FDataSnapCompatibility <> AValue) then begin
    FDataSnapCompatibility := AValue;
    Include(FAssignedValues, fvDataSnapCompatibility);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDFormatOptions.IsDSCS: Boolean;
begin
  Result := fvDataSnapCompatibility in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDFormatOptions.GetFmtDisplayDateTime: String;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(fvFmtDisplayDateTime, oParentOpts) then
    Result := FFmtDisplayDateTime
  else
    Result := oParentOpts.FormatOptions.FmtDisplayDateTime;
end;

{-------------------------------------------------------------------------------}
procedure TFDFormatOptions.SetFmtDisplayDateTime(const AValue: String);
begin
  if not (fvFmtDisplayDateTime in FAssignedValues) or (FFmtDisplayDateTime <> AValue) then begin
    FFmtDisplayDateTime := AValue;
    Include(FAssignedValues, fvFmtDisplayDateTime);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDFormatOptions.IsFDDTS: Boolean;
begin
  Result := fvFmtDisplayDateTime in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDFormatOptions.GetFmtDisplayDate: String;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(fvFmtDisplayDate, oParentOpts) then
    Result := FFmtDisplayDate
  else
    Result := oParentOpts.FormatOptions.FmtDisplayDate;
end;

{-------------------------------------------------------------------------------}
procedure TFDFormatOptions.SetFmtDisplayDate(const AValue: String);
begin
  if not (fvFmtDisplayDate in FAssignedValues) or (FFmtDisplayDate <> AValue) then begin
    FFmtDisplayDate := AValue;
    Include(FAssignedValues, fvFmtDisplayDate);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDFormatOptions.IsFDDS: Boolean;
begin
  Result := fvFmtDisplayDate in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDFormatOptions.GetFmtDisplayTime: String;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(fvFmtDisplayTime, oParentOpts) then
    Result := FFmtDisplayTime
  else
    Result := oParentOpts.FormatOptions.FmtDisplayTime;
end;

{-------------------------------------------------------------------------------}
procedure TFDFormatOptions.SetFmtDisplayTime(const AValue: String);
begin
  if not (fvFmtDisplayTime in FAssignedValues) or (FFmtDisplayTime <> AValue) then begin
    FFmtDisplayTime := AValue;
    Include(FAssignedValues, fvFmtDisplayTime);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDFormatOptions.IsFDTS: Boolean;
begin
  Result := fvFmtDisplayTime in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDFormatOptions.GetFmtDisplayNumeric: String;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(fvFmtDisplayNumeric, oParentOpts) then
    Result := FFmtDisplayNumeric
  else
    Result := oParentOpts.FormatOptions.FmtDisplayNumeric;
end;

{-------------------------------------------------------------------------------}
procedure TFDFormatOptions.SetFmtDisplayNumeric(const AValue: String);
begin
  if not (fvFmtDisplayNumeric in FAssignedValues) or (FFmtDisplayNumeric <> AValue) then begin
    FFmtDisplayNumeric := AValue;
    Include(FAssignedValues, fvFmtDisplayNumeric);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDFormatOptions.IsFDNS: Boolean;
begin
  Result := fvFmtDisplayNumeric in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDFormatOptions.GetFmtEditNumeric: String;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(fvFmtEditNumeric, oParentOpts) then
    Result := FFmtEditNumeric
  else
    Result := oParentOpts.FormatOptions.FmtEditNumeric;
end;

{-------------------------------------------------------------------------------}
procedure TFDFormatOptions.SetFmtEditNumeric(const AValue: String);
begin
  if not (fvFmtEditNumeric in FAssignedValues) or (FFmtEditNumeric <> AValue) then begin
    FFmtEditNumeric := AValue;
    Include(FAssignedValues, fvFmtEditNumeric);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDFormatOptions.IsFENS: Boolean;
begin
  Result := fvFmtEditNumeric in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDFormatOptions.GetSortLocale: TFDLocalID;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(fvSortLocale, oParentOpts) then
    Result := FSortLocale
  else
    Result := oParentOpts.FormatOptions.SortLocale;
end;

{-------------------------------------------------------------------------------}
procedure TFDFormatOptions.SetSortLocale(const AValue: TFDLocalID);
begin
  if not (fvSortLocale in FAssignedValues) or (FSortLocale <> AValue) then begin
    FSortLocale := AValue;
    Include(FAssignedValues, fvSortLocale);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDFormatOptions.IsSLS: Boolean;
begin
  Result := fvSortLocale in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDFormatOptions.GetSortOptions: TFDSortOptions;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(fvSortOptions, oParentOpts) then
    Result := FSortOptions
  else
    Result := oParentOpts.FormatOptions.SortOptions;
end;

{-------------------------------------------------------------------------------}
procedure TFDFormatOptions.SetSortOptions(const AValue: TFDSortOptions);
begin
  if not (fvSortOptions in FAssignedValues) or (FSortOptions <> AValue) then begin
    FSortOptions := AValue;
    Include(FAssignedValues, fvSortOptions);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDFormatOptions.IsSOS: Boolean;
begin
  Result := fvSortOptions in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
procedure TFDFormatOptions.ResolveDataType(const ASrcName, ATypeName: String;
  ASrcDataType: TFDDataType; ASrcSize: LongWord; ASrcPrec, ASrcScale: Integer;
  var ADestDataType: TFDDataType; var ADestSize: LongWord; AForward: Boolean);
var
  i: Integer;
  oRules: TFDMapRules;
  oRule: TFDMapRule;
begin
  ADestDataType := ASrcDataType;
  oRules := MapRules;
  for i := 0 to oRules.Count - 1 do begin
    oRule := oRules[i];
    if (AForward and (
          ((oRule.SourceDataType = dtUnknown) or (oRule.SourceDataType = ASrcDataType)) and
          ((oRule.NameMask = '') or (ASrcName <> '') and FDStrLike(ASrcName, oRule.NameMask, True)) and
          ((oRule.TypeMask = '') or (ATypeName <> '') and FDStrLike(ATypeName, oRule.TypeMask, True))) and
          (oRule.TargetDataType <> dtUnknown) or
        not AForward and
          (oRule.TargetDataType = ASrcDataType) and (oRule.NameMask = '') and (oRule.TypeMask = '') and
          (oRule.SourceDataType <> dtUnknown)
       ) and
       ((oRule.SizeMin = C_FD_DefMapSize) or (ASrcSize <= 0) or (oRule.SizeMin <= ASrcSize)) and
       ((oRule.SizeMax = C_FD_DefMapSize) or (ASrcSize <= 0) or (oRule.SizeMax >= ASrcSize)) and
       ((oRule.PrecMin = C_FD_DefMapPrec) or (ASrcPrec <= 0) or (oRule.PrecMin <= ASrcPrec)) and
       ((oRule.PrecMax = C_FD_DefMapPrec) or (ASrcPrec <= 0) or (oRule.PrecMax >= ASrcPrec)) and
       ((oRule.ScaleMin = C_FD_DefMapScale) or (ASrcScale < 0) or (oRule.ScaleMin <= ASrcScale)) and
       ((oRule.ScaleMax = C_FD_DefMapScale) or (ASrcScale < 0) or (oRule.ScaleMax >= ASrcScale)) then begin
      if AForward then
        ADestDataType := oRule.TargetDataType
      else
        ADestDataType := oRule.SourceDataType;
      Break;
    end;
  end;
  if (ASrcDataType in [dtBlob, dtMemo, dtWideMemo, dtXML, dtHBlob,
                       dtHMemo, dtWideHMemo, dtHBFile]) and
     (ADestDataType in [dtAnsiString, dtWideString, dtByteString]) then
    ADestSize := MaxStringSize
  else
    ADestSize := ASrcSize;
end;

{-------------------------------------------------------------------------------}
procedure TFDFormatOptions.ResolveFieldType(const ASrcName, ATypeName: String; ASrcFieldType: TFieldType;
  ASrcADFieldType: TFDDataType; ASrcSize: LongWord; ASrcPrecision, ASrcScale: Integer;
  var ADestFieldType: TFieldType; var ADestSize: LongWord;
  var ADestPrecision, ADestScale: Integer; var ASrcDataType, ADestDataType: TFDDataType;
  AForward: Boolean);
var
  iSrcScale, iSrcPrec: Integer;
  iSrcSize: LongWord;
  iSrcAttrs: TFDDataAttributes;
begin
  iSrcAttrs := [];
  iSrcSize := 0;
  iSrcPrec := 0;
  iSrcScale := 0;
  FieldDef2ColumnDef(ASrcFieldType, ASrcSize, ASrcPrecision, ASrcScale,
    ASrcDataType, iSrcSize, iSrcPrec, iSrcScale, iSrcAttrs);
  case ASrcDataType of
  dtHMemo, dtWideMemo, dtMemo, dtXML:
    if ASrcADFieldType = dtWideHMemo then
      ASrcDataType := dtWideHMemo;
  dtHBlob, dtBlob:
    if ASrcADFieldType in [dtHBFile, dtHMemo, dtWideHMemo] then
      ASrcDataType := ASrcADFieldType;
  dtDateTime:
    if ASrcADFieldType = dtDateTimeStamp then
      ASrcDataType := dtDateTimeStamp;
  dtTimeIntervalDS:
    if ASrcADFieldType in [dtTimeIntervalFull, dtTimeIntervalYM, dtTimeIntervalDS] then
      ASrcDataType := ASrcADFieldType;
  dtInt64, dtUInt64:
    if ASrcADFieldType in [dtInt64, dtUInt64] then
      ASrcDataType := ASrcADFieldType;
  end;
  ResolveDataType(ASrcName, ATypeName, ASrcDataType, iSrcSize, iSrcPrec, iSrcScale,
    ADestDataType, iSrcSize, AForward);
  ColumnDef2FieldDef(ADestDataType, iSrcSize, iSrcPrec, iSrcScale, iSrcAttrs,
    ADestFieldType, ADestSize, ADestPrecision, ADestScale);
end;

{-------------------------------------------------------------------------------}
procedure TFDFormatOptions.ColumnDef2FieldDef(ASrcDataType: TFDDataType;
  ASrcSize: LongWord; ASrcPrec, ASrcScale: Integer; ASrcAttrs: TFDDataAttributes;
  var ADestFieldType: TFieldType; var ADestSize: LongWord; var ADestPrec, ADestScale: Integer);
begin
  ADestFieldType := ftUnknown;
  ADestSize := 0;
  ADestPrec := 0;
  ADestScale := 0;
  case ASrcDataType of
    dtUnknown:
      ;
    dtBoolean:
      ADestFieldType := ftBoolean;
    dtSByte:
      ADestFieldType := ftShortint;
    dtByte:
      ADestFieldType := ftByte;
    dtInt16:
      ADestFieldType := ftSmallint;
    dtUInt16:
      ADestFieldType := ftWord;
    dtInt32:
      if caAutoInc in ASrcAttrs then
        ADestFieldType := ftAutoInc
      else
        ADestFieldType := ftInteger;
    dtUInt32:
      if caAutoInc in ASrcAttrs then
        ADestFieldType := ftAutoInc
      else
        ADestFieldType := ftLongWord;
    dtInt64:
      ADestFieldType := ftLargeint;
    dtUInt64:
      ADestFieldType := {$IF DEFINED(CPUARM64)} ftLongWord {$ELSE} ftLargeint {$ENDIF};
    dtSingle:
      begin
        ADestFieldType := ftSingle;
        ADestPrec := ASrcPrec;
        ADestScale := ASrcScale;
      end;
    dtDouble:
      begin
        ADestFieldType := ftFloat;
        ADestPrec := ASrcPrec;
        ADestScale := ASrcScale;
      end;
    dtExtended:
      begin
        ADestFieldType := ftExtended;
        ADestPrec := ASrcPrec;
        ADestScale := ASrcScale;
      end;
    dtCurrency:
      begin
        ADestFieldType := ftCurrency;
        ADestPrec := ASrcPrec;
        ADestScale := ASrcScale;
      end;
    dtBCD, dtFmtBCD:
      begin
        if (ASrcDataType = dtFmtBCD) or
           (ASrcPrec > MaxBcdPrecision) or (ASrcScale > MaxBcdScale) then
          ADestFieldType := ftFMTBcd
        else
          ADestFieldType := ftBcd;
        ADestPrec := ASrcPrec;
        ADestScale := ASrcScale;
      end;
    dtDateTimeStamp:
      begin
        ADestFieldType := ftTimeStamp;
        ADestScale := ASrcScale;
      end;
    dtTimeIntervalFull,
    dtTimeIntervalYM,
    dtTimeIntervalDS:
      begin
        ADestFieldType := ftOraInterval;
        ADestScale := ASrcScale;
      end;
    dtDateTime:
      begin
        ADestFieldType := ftDateTime;
        ADestScale := ASrcScale;
      end;
    dtTime:
      begin
        ADestFieldType := ftTime;
        ADestScale := ASrcScale;
      end;
    dtDate:
      begin
        ADestFieldType := ftDate;
        ADestScale := ASrcScale;
      end;
    dtAnsiString:
      begin
        ADestSize := ASrcSize;
        if ASrcSize > MaxStringSize then
          ADestFieldType := ftMemo
        else if caFixedLen in ASrcAttrs then
          ADestFieldType := ftFixedChar
        else
          ADestFieldType := ftString;
      end;
    dtWideString:
      begin
        ADestSize := ASrcSize;
        if ASrcSize > MaxStringSize then
          ADestFieldType := ftWideMemo
        else if caFixedLen in ASrcAttrs then
          ADestFieldType := ftFixedWideChar
        else
          ADestFieldType := ftWideString;
      end;
    dtByteString:
      begin
        ADestSize := ASrcSize;
        if ASrcSize > MaxStringSize then
          ADestFieldType := ftBlob
        else if caFixedLen in ASrcAttrs then
          ADestFieldType := ftBytes
        else
          ADestFieldType := ftVarBytes;
      end;
    dtBlob:
      ADestFieldType := ftBlob;
    dtMemo:
      ADestFieldType := ftMemo;
    dtWideMemo:
      ADestFieldType := ftWideMemo;
    dtXML:
      ADestFieldType := ftDBaseOle;
    dtHBlob:                                                            
      ADestFieldType := ftOraBlob;
    dtHBFile:
      ADestFieldType := ftOraBlob;
    dtHMemo:
      ADestFieldType := ftOraClob;
    dtWideHMemo:
      // Here was ftOraClob, but then will be created TMemoField,
      // which does not know anything about Unicode. So, I have
      // changed to ftFmtMemo. But probably may be problems ...
      ADestFieldType := ftWideMemo;
    dtObject:
      ADestFieldType := ftInterface;
    dtRowSetRef:
      ADestFieldType := ftDataSet;
    dtCursorRef:
      ADestFieldType := ftCursor;
    dtRowRef:
      ADestFieldType := ftAdt;
    dtArrayRef:
      ADestFieldType := ftArray;
    dtParentRowRef:
      ADestFieldType := ftReference;
    dtGUID:
      begin
        ADestFieldType := ftGUID;
        ADestSize := C_FD_GUIDStrLen;
      end;
  end;
end;

{-------------------------------------------------------------------------------}
class procedure TFDFormatOptions.FieldDef2ColumnDef(ASrcFieldType: TFieldType;
  ASrcSize: LongWord; ASrcPrec, ASrcScale: Integer; var ADestDataType: TFDDataType;
  var ADestSize: LongWord; var ADestPrec, ADestScale: Integer;
  var ADestAttrs: TFDDataAttributes);
begin
  ADestDataType := dtUnknown;
  ADestSize := 0;
  ADestPrec := 0;
  ADestScale := 0;
  ADestAttrs := [];
  case ASrcFieldType of
    ftUnknown:
      ;
    ftBoolean:
      ADestDataType := dtBoolean;
    ftShortint:
      ADestDataType := dtSByte;
    ftByte:
      ADestDataType := dtByte;
    ftSmallint:
      ADestDataType := dtInt16;
    ftWord:
      ADestDataType := dtUInt16;
    ftInteger:
      ADestDataType := dtInt32;
    ftLongWord:
      ADestDataType := {$IF DEFINED(CPUARM64)} dtUInt64 {$ELSE} dtUInt32 {$ENDIF};
    ftAutoInc:
      begin
        ADestDataType := dtInt32;
        ADestAttrs := [caAutoInc];
      end;
    ftLargeint:
      ADestDataType := dtInt64;
    ftSingle:
      begin
        ADestDataType := dtSingle;
        ADestPrec := ASrcPrec;
        ADestScale := ASrcScale;
      end;
    ftFloat:
      begin
        ADestDataType := dtDouble;
        ADestPrec := ASrcPrec;
        ADestScale := ASrcScale;
      end;
    ftExtended:
      begin
        ADestDataType := dtExtended;
        ADestPrec := ASrcPrec;
        ADestScale := ASrcScale;
      end;
    ftCurrency:
      begin
        ADestDataType := dtCurrency;
        if ASrcPrec = 0 then
          ADestPrec := 19
        else
          ADestPrec := ASrcPrec;
        if ASrcScale = 0 then
          ADestScale := 4
        else
          ADestScale := ASrcScale;
      end;
    ftBcd:
      begin
        ADestDataType := dtBCD;
        ADestPrec := ASrcPrec;
        ADestScale := ASrcScale;
      end;
    ftFmtBCD:
      begin
        ADestDataType := dtFmtBCD;
        ADestPrec := ASrcPrec;
        ADestScale := ASrcScale;
      end;
    ftTimeStamp:
      begin
        ADestDataType := dtDateTimeStamp;
        ADestScale := ASrcScale;
      end;
    ftOraInterval,
    ftParadoxOle:
      begin
        ADestDataType := dtTimeIntervalDS;
        ADestScale := ASrcScale;
      end;
    ftDateTime:
      begin
        ADestDataType := dtDateTime;
        ADestScale := ASrcScale;
      end;
    ftTime:
      begin
        ADestDataType := dtTime;
        ADestScale := ASrcScale;
      end;
    ftDate:
      begin
        ADestDataType := dtDate;
        ADestScale := ASrcScale;
      end;
    ftFixedChar:
      begin
        ADestDataType := dtAnsiString;
        ADestSize := ASrcSize;
        ADestAttrs := [caFixedLen];
      end;
    ftString:
      begin
        ADestDataType := dtAnsiString;
        ADestSize := ASrcSize;
      end;
    ftFixedWideChar:
      begin
        ADestDataType := dtWideString;
        ADestSize := ASrcSize;
        ADestAttrs := [caFixedLen];
      end;
    ftWideString:
      begin
        ADestDataType := dtWideString;
        ADestSize := ASrcSize;
      end;
    ftBytes:
      begin
        ADestDataType := dtByteString;
        ADestSize := ASrcSize;
        ADestAttrs := [caFixedLen];
      end;
    ftVarBytes:
      begin
        ADestDataType := dtByteString;
        ADestSize := ASrcSize;
        ADestAttrs := [];
      end;
    ftBlob,
    ftGraphic,
    ftTypedBinary:
      begin
        ADestDataType := dtBlob;
        ADestAttrs := [caBlobData];
      end;
    ftMemo:
      begin
        ADestDataType := dtMemo;
        ADestAttrs := [caBlobData];
      end;
    ftWideMemo,
    ftFmtMemo:
      begin
        ADestDataType := dtWideMemo;
        ADestAttrs := [caBlobData];
      end;
    ftDBaseOle:
      begin
        ADestDataType := dtXML;
        ADestAttrs := [caBlobData];
      end;
    ftOraBlob:
      begin
        ADestDataType := dtHBlob;
        ADestAttrs := [caBlobData];
      end;
    ftOraClob:
      begin
        ADestDataType := dtHMemo;
        ADestAttrs := [caBlobData];
      end;
    ftInterface, ftIDispatch:
      ADestDataType := dtObject;
    ftReference, ftVariant:
      ADestDataType := dtUnknown;
    ftCursor:
      ADestDataType := dtCursorRef;
    ftDataSet:
      ADestDataType := dtRowSetRef;
    ftStream:
      ADestDataType := dtHBlob;
    ftAdt:
      ADestDataType := dtRowRef;
    ftArray:
      ADestDataType := dtArrayRef;
    ftGUID:
      ADestDataType := dtGUID;
  end;
end;

{-------------------------------------------------------------------------------}
class procedure TFDFormatOptions.FieldDef2ColumnDef(AField: TField;
  var ADestDataType: TFDDataType; var ADestSize: LongWord; var ADestPrec,
  ADestScale: Integer; var ADestAttrs: TFDDataAttributes);
var
  iPrecision, iScale: Integer;
begin
  iPrecision := 0;
  iScale := 0;
  if AField is TSingleField then
    iPrecision := TSingleField(AField).Precision
  else if AField is TFloatField then
    iPrecision := TFloatField(AField).Precision
  else if AField is TExtendedField then
    iPrecision := TExtendedField(AField).Precision
  else if AField is TBCDField then begin
    iPrecision := TBCDField(AField).Precision;
    iScale := TBCDField(AField).Size;
  end
  else if AField is TFMTBCDField then begin
    iPrecision := TFMTBCDField(AField).Precision;
    iScale := TFMTBCDField(AField).Size;
  end
  else if AField is TCurrencyField then begin
    iPrecision := TCurrencyField(AField).Precision;
    iScale := 4;
  end;
  FieldDef2ColumnDef(AField.DataType, AField.Size, iPrecision, iScale,
    ADestDataType, ADestSize, ADestPrec, ADestScale, ADestAttrs);
end;

{-------------------------------------------------------------------------------}
class procedure TFDFormatOptions.FieldDef2ColumnDef(AFieldDef: TFieldDef;
  var ADestDataType: TFDDataType; var ADestSize: LongWord; var ADestPrec,
  ADestScale: Integer; var ADestAttrs: TFDDataAttributes);
var
  iScale: Integer;
begin
  iScale := 0;
  if AFieldDef.DataType = ftBCD then
    iScale := AFieldDef.Size
  else if AFieldDef.DataType = ftFmtBCD then
    iScale := AFieldDef.Size
  else if AFieldDef.DataType = ftCurrency then
    iScale := 4;
  FieldDef2ColumnDef(AFieldDef.DataType, AFieldDef.Size, AFieldDef.Precision,
    iScale, ADestDataType, ADestSize, ADestPrec, ADestScale, ADestAttrs);
end;

{-------------------------------------------------------------------------------}
procedure TFDFormatOptions.CheckConversion(ASrc, ADest: TFDDataType);
begin
  if C_FD_AllowedConversions[ASrc, ADest] = 0 then
    FDException(nil, [S_FD_LStan], er_FD_ConvIsNotSupported, []);
end;

{-------------------------------------------------------------------------------}
const
  SF_D: String = '%d';
  SF_U: String = '%u';
  SF_F: String = '%f';
  SF_S: String = '%s';
  SF_G: String = '{%.8x-%.4x-%.4x-%.2x%.2x-%.2x%.2x%.2x%.2x%.2x%.2x}';
  RLongDate: TSQLTimeStamp = (Year: 2002; Month: 9; Day: 29; Hour: 23;
    Minute: 59; Second: 59; Fractions: 999);
  RLongInt: TFDSQLTimeInterval = (Sign: -1; Kind: itDay2Second; Days: 29; Hours: 23;
    Minutes: 59; Seconds: 59; Fractions: 999);
var
  C_FD_MaxLenTimeStampStr: Integer = -1;
  C_FD_MaxLenTimeIntStr: Integer = -1;

procedure TFDFormatOptions.ConvertRawData(ASrcType, ADestType: TFDDataType;
  ApSrc: Pointer; ASrcSize: LongWord; var ApDest: Pointer; ADestMaxSize: LongWord;
  var ADestSize: LongWord; AEncoder: TFDEncoder);
var
  lConverted: Boolean;
  rSTS: TSQLTimeStamp;
  c: Currency;
  buff: array [0 .. 255] of Byte;

  function GetStorageSize: Integer;
  begin
    case ADestType of
    dtBoolean:          Result := SizeOf(WordBool);
    dtSByte:            Result := SizeOf(ShortInt);
    dtInt16:            Result := SizeOf(SmallInt);
    dtInt32:            Result := SizeOf(Integer);
    dtInt64:            Result := SizeOf(Int64);
    dtByte:             Result := SizeOf(Byte);
    dtUInt16:           Result := SizeOf(Word);
    dtUInt32:           Result := SizeOf(Cardinal);
    dtUInt64:           Result := SizeOf(UInt64);
    dtSingle:           Result := SizeOf(Single);
    dtDouble:           Result := SizeOf(Double);
    dtExtended:         Result := SizeOf(Extended);
    dtCurrency:         Result := SizeOf(Currency);
    dtBCD,
    dtFmtBCD:           Result := SizeOf(TBcd);
    dtDateTime:         Result := SizeOf(TDateTimeRec);
    dtDateTimeStamp:    Result := SizeOf(TSQLTimeStamp);
    dtTimeIntervalFull,
    dtTimeIntervalYM,
    dtTimeIntervalDS:   Result := SizeOf(TFDSQLTimeInterval);
    dtTime:             Result := SizeOf(Integer);
    dtDate:             Result := SizeOf(Integer);
    dtGUID:             Result := SizeOf(TGUID);
    dtObject:           Result := SizeOf(IFDDataStoredObject);
    else                Result := 0;
    end;
  end;

  procedure Val2WStr(const AFmt: String; const AValues: array of const);
  var
    pBuff: Pointer;
    iLen: Integer;
  begin
    if ApDest = nil then begin
      pBuff := Pointer(@buff[0]);
      iLen := SizeOf(buff);
    end
    else begin
      pBuff := ApDest;
      iLen := ADestMaxSize;
    end;
    ADestSize := WideFormatBuf(pBuff^, iLen div SizeOf(WideChar),
      PWideChar(AFmt)^, Length(AFmt), AValues);
    PWideChar(pBuff)[ADestSize] := #0;
  end;

  procedure Val2AStr(const AFmt: String; const AValues: array of const);
  var
    pBuff: Pointer;
{$IFNDEF NEXTGEN}
    iLen: Integer;
    sFmt: AnsiString;
{$ENDIF}
  begin
{$IFNDEF NEXTGEN}
    if ApDest = nil then begin
      pBuff := Pointer(@buff[0]);
      iLen := SizeOf(buff);
    end
    else begin
      pBuff := ApDest;
      iLen := ADestMaxSize;
    end;
    sFmt := AnsiString(AFmt);
    ADestSize := System.AnsiStrings.FormatBuf(pBuff^, iLen, PAnsiChar(sFmt)^, Length(sFmt), AValues);
    PAnsiChar(pBuff)[ADestSize] := #0;
{$ELSE}
    pBuff := ApDest;
    ApDest := Pointer(@buff[0]);
    Val2WStr(AFmt, AValues);
    ADestSize := AEncoder.Encode(ApDest, ADestSize, pBuff, ecUTF16, ecANSI);
    ApDest := pBuff;
{$ENDIF}
  end;

  procedure Str2Dest;
  var
    s: String;

    procedure GetStr;
    begin
      SetString(s, PChar(ApSrc), ASrcSize);
    end;

  begin
    case ADestType of
    dtBoolean:          PWordBool(ApDest)^ := (PChar(ApSrc)^ = 'T') or (PChar(ApSrc)^ =  't') or
                                              (PChar(ApSrc)^ = 'Y') or (PChar(ApSrc)^ =  'y');
    dtSByte:            FDStr2Int(PChar(ApSrc), ASrcSize, ApDest, SizeOf(ShortInt), False);
    dtInt16:            FDStr2Int(PChar(ApSrc), ASrcSize, ApDest, SizeOf(SmallInt), False);
    dtInt32:            FDStr2Int(PChar(ApSrc), ASrcSize, ApDest, SizeOf(Integer), False);
    dtInt64:            FDStr2Int(PChar(ApSrc), ASrcSize, ApDest, SizeOf(Int64), False);
    dtByte:             FDStr2Int(PChar(ApSrc), ASrcSize, ApDest, SizeOf(Byte), True);
    dtUInt16:           FDStr2Int(PChar(ApSrc), ASrcSize, ApDest, SizeOf(Word), True);
    dtUInt32:           FDStr2Int(PChar(ApSrc), ASrcSize, ApDest, SizeOf(Cardinal), True);
    dtUInt64:           FDStr2Int(PChar(ApSrc), ASrcSize, ApDest, SizeOf(UInt64), True);
    dtSingle:           FDStr2Float(PChar(ApSrc), ASrcSize, ApDest, SizeOf(Single), Char(FormatSettings.DecimalSeparator));
    dtDouble:           FDStr2Float(PChar(ApSrc), ASrcSize, ApDest, SizeOf(Double), Char(FormatSettings.DecimalSeparator));
    dtExtended:         FDStr2Float(PChar(ApSrc), ASrcSize, ApDest, SizeOf(Extended), Char(FormatSettings.DecimalSeparator));
    dtCurrency:         FDStr2Curr(PChar(ApSrc), ASrcSize, PCurrency(ApDest)^, Char(FormatSettings.DecimalSeparator));
    dtBCD,
    dtFmtBCD:           FDStr2BCD(PChar(ApSrc), ASrcSize, PBcd(ApDest)^, Char(FormatSettings.DecimalSeparator));
    dtDateTime:         begin GetStr; PDateTimeRec(ApDest)^.DateTime := FDDateTime2MSecs(StrToDateTime(s)); end;
    dtTime:             begin GetStr; PInteger(ApDest)^ := FDDateTime2Time(StrToDateTime(s)); end;
    dtDate:             begin GetStr; PInteger(ApDest)^ := FDDateTime2Date(StrToDateTime(s)); end;
    dtDateTimeStamp:    begin GetStr; PSQLTimeStamp(ApDest)^ := DateTimeToSQLTimeStamp(StrToDateTime(s)); end;
    dtTimeIntervalFull,
    dtTimeIntervalYM,
    dtTimeIntervalDS:   begin GetStr; PFDSQLTimeInterval(ApDest)^ := FDStr2SQLTimeInterval(s); end;
    dtGUID:             begin GetStr; PGUID(ApDest)^ := StringToGUID(s); end;
    else                lConverted := False;
    end;
  end;

  procedure AStr2Dest;
  var
    pPrevSrc, pDest: Pointer;
    iPrevLen: LongWord;
  begin
    pPrevSrc := ApSrc;
    iPrevLen := ASrcSize;
    try
      pDest := @buff[0];
      ASrcSize := AEncoder.Decode(ApSrc, ASrcSize, pDest, ecDefault, ecANSI);
      ApSrc := pDest;
      Str2Dest;
    finally
      ApSrc := pPrevSrc;
      ASrcSize := iPrevLen;
    end;
  end;

  procedure WStr2Dest;
  var
    pPrevSrc, pDest: Pointer;
    iPrevLen: LongWord;
  begin
    pPrevSrc := ApSrc;
    iPrevLen := ASrcSize;
    try
      pDest := @buff[0];
      ASrcSize := AEncoder.Decode(ApSrc, ASrcSize, pDest, ecDefault, ecUTF16);
      ApSrc := pDest;
      Str2Dest;
    finally
      ApSrc := pPrevSrc;
      ASrcSize := iPrevLen;
    end;
  end;

  procedure BCD2Str(ApValue: PBcd; AEncoding: TFDEncoding);
  var
    iSize: Integer;
  begin
    FDBCD2Str(PChar(@buff[0]), iSize, ApValue^, Char(FormatSettings.DecimalSeparator));
    ADestSize := iSize;
    if ADestSize >= ADestMaxSize then
      ADestSize := ADestMaxSize
    else
      Inc(ADestSize);
    AEncoder.Encode(PChar(@buff[0]), Integer(ADestSize), ApDest, ecDefault, AEncoding);
  end;

  procedure Int2BCD(ApValue: Pointer; ASize: Integer; ANoSign: Boolean);
  var
    pBuff: PChar;
    iLen: Integer;
  begin
    pBuff := PChar(@buff[0]);
    iLen := (SizeOf(buff) - SizeOf(Char)) div SizeOf(Char);
    FDInt2Str(ApValue, ASize, pBuff, iLen, ANoSign, 0);
    FDStr2BCD(pBuff, iLen, PBcd(ApDest)^, Char(FormatSettings.DecimalSeparator));
  end;

  procedure BCD2Int(ADestLen: Integer; ANoSign: Boolean);
  var
    iLen: Integer;
    pBuff: PChar;
  begin
    pBuff := PChar(@buff[0]);
    iLen := 0;
    FDBCD2Str(pBuff, iLen, PBcd(ApSrc)^, Char(FormatSettings.DecimalSeparator));
    FDStr2Int(pBuff, iLen, ApDest, ADestLen, ANoSign);
  end;

  procedure BCD2Dbl(ADestLen: Integer);
  var
    E: Extended;
  begin
    FDBCD2Double(PBcd(ApSrc)^, E);
    case ADestLen of
    SizeOf(Single):   PSingle(ApDest)^ := E;
    SizeOf(Double):   PDouble(ApDest)^ := E;
{$IF SizeOf(EXTENDED) = 10}
    SizeOf(Extended): PExtended(ApDest)^ := E;
{$ENDIF}
    end;
  end;

  procedure STS2AStr(ApValue: PSQLTimeStamp; AKind: TFDDataType);
  var
    sFmt, sVal: String;
  begin
    case AKind of
    dtDateTime,
    dtDateTimeStamp: sFmt := '';
    dtTime:          sFmt := FormatSettings.ShortTimeFormat;
    dtDate:          sFmt := FormatSettings.ShortDateFormat;
    end;
    sVal := '';
    DateTimeToString(sVal, sFmt, SQLTimeStampToDateTime(ApValue^));
    Val2AStr(SF_S, [sVal]);
  end;

  procedure STS2WStr(ApValue: PSQLTimeStamp; AKind: TFDDataType);
  var
    sFmt, sVal: String;
  begin
    case AKind of
    dtDateTime,
    dtDateTimeStamp: sFmt := '';
    dtTime:          sFmt := FormatSettings.ShortTimeFormat;
    dtDate:          sFmt := FormatSettings.ShortDateFormat;
    end;
    sVal := '';
    DateTimeToString(sVal, sFmt, SQLTimeStampToDateTime(ApValue^));
    Val2WStr(SF_S, [sVal]);
  end;

  procedure AStr2WStr;
  var
    sb: TFDByteString;
  begin
    if ApSrc = ApDest then begin
      SetLength(sb, ASrcSize * SizeOf(TFDAnsiChar));
      Move(PFDAnsiString(ApSrc)^, PByte(sb)^, ASrcSize * SizeOf(TFDAnsiChar));
      ApSrc := PByte(sb);
    end;
    AEncoder.Encode(ApSrc, ASrcSize, ApDest, ecANSI, ecUTF16);
  end;

  procedure WStr2AStr;
  var
    sw: String;
  begin
    if ApSrc = ApDest then begin
      SetString(sw, PWideChar(ApSrc), ASrcSize);
      ApSrc := PWideChar(sw);
    end;
    AEncoder.Encode(ApSrc, ASrcSize, ApDest, ecUTF16, ecANSI);
  end;

begin
  if ASrcType = ADestType then begin
    ADestSize := ASrcSize;
    if ApSrc <> nil then
      ApDest := ApSrc;
    Exit;
  end;
  CheckConversion(ASrcType, ADestType);
  ADestSize := GetStorageSize();
  lConverted := True;
  case ASrcType of
  dtBoolean:
    if ADestType = dtAnsiString then begin
      if (ApSrc <> nil) and (ApDest <> nil) then begin
        if PWordBool(ApSrc)^ then
          PChar(ApDest)[0] := 'T'
        else
          PChar(ApDest)[0] := 'F';
        PChar(ApDest)[1] := #0;
      end;
      ADestSize := 1;
    end
    else if ADestType = dtWideString then begin
      if (ApSrc <> nil) and (ApDest <> nil) then begin
        if PWordBool(ApSrc)^ then
          PWideChar(ApDest)[0] := 'T'
        else
          PWideChar(ApDest)[0] := 'F';
        PWideChar(ApDest)[1] := #0;
      end;
      ADestSize := 1;
    end
    else if (ApSrc <> nil) and (ApDest <> nil) then
      case ADestType of
      dtSByte:      PShortInt(ApDest)^ := ShortInt(PWordBool(ApSrc)^);
      dtInt16:      PSmallInt(ApDest)^ := SmallInt(PWordBool(ApSrc)^);
      dtInt32:      PInteger(ApDest)^ := Integer(PWordBool(ApSrc)^);
      dtInt64:      PInt64(ApDest)^ := Int64(PWordBool(ApSrc)^);
      dtByte:       PByte(ApDest)^ := Byte(PWordBool(ApSrc)^);
      dtUInt16:     PWord(ApDest)^ := Word(PWordBool(ApSrc)^);
      dtUInt32:     PCardinal(ApDest)^ := Cardinal(PWordBool(ApSrc)^);
      dtUInt64:     PUInt64(ApDest)^ := UInt64(PWordBool(ApSrc)^);
      dtBCD,
      dtFmtBCD:     Int2BCD(PWordBool(ApSrc), SizeOf(WordBool), True);
      else lConverted := False;
      end;
  dtSByte:
    if ADestType = dtAnsiString then
      if ApSrc <> nil then
        Val2AStr(SF_D, [PShortInt(ApSrc)^])
      else
        ADestSize := 5
    else if ADestType = dtWideString then
      if ApSrc <> nil then
        Val2WStr(SF_D, [PShortInt(ApSrc)^])
      else
        ADestSize := 5
    else if (ApSrc <> nil) and (ApDest <> nil) then
      case ADestType of
      dtBoolean:    PWordBool(ApDest)^ := WordBool(PShortInt(ApSrc)^);
      dtInt16:      PSmallInt(ApDest)^ := PShortInt(ApSrc)^;
      dtInt32:      PInteger(ApDest)^ := PShortInt(ApSrc)^;
      dtInt64:      PInt64(ApDest)^ := PShortInt(ApSrc)^;
      dtByte:       PByte(ApDest)^ := PShortInt(ApSrc)^;
      dtUInt16:     PWord(ApDest)^ := PShortInt(ApSrc)^;
      dtUInt32:     PCardinal(ApDest)^ := PShortInt(ApSrc)^;
      dtUInt64:     PUInt64(ApDest)^ := Word(PShortInt(ApSrc)^);
      dtSingle:     PSingle(ApDest)^ := PShortInt(ApSrc)^;
      dtDouble:     PDouble(ApDest)^ := PShortInt(ApSrc)^;
      dtExtended:   PExtended(ApDest)^ := PShortInt(ApSrc)^;
      dtCurrency:   PCurrency(ApDest)^ := PShortInt(ApSrc)^;
      dtBCD,
      dtFmtBCD:     Int2BCD(PShortInt(ApSrc), SizeOf(ShortInt), False);
      else lConverted := False;
      end;
  dtInt16:
    if ADestType = dtAnsiString then
      if ApSrc <> nil then
        Val2AStr(SF_D, [PSmallInt(ApSrc)^])
      else
        ADestSize := 7
    else if ADestType = dtWideString then
      if ApSrc <> nil then
        Val2WStr(SF_D, [PSmallInt(ApSrc)^])
      else
        ADestSize := 7
    else if (ApSrc <> nil) and (ApDest <> nil) then
      case ADestType of
      dtBoolean:  PWordBool(ApDest)^ := WordBool(PSmallInt(ApSrc)^);
      dtSByte:    PShortInt(ApDest)^ := ShortInt(PSmallInt(ApSrc)^);
      dtInt32:    PInteger(ApDest)^ := PSmallInt(ApSrc)^;
      dtInt64:    PInt64(ApDest)^ := PSmallInt(ApSrc)^;
      dtByte:     PByte(ApDest)^ := Byte(PSmallInt(ApSrc)^);
      dtUInt16:   PWord(ApDest)^ := PSmallInt(ApSrc)^;
      dtUInt32:   PCardinal(ApDest)^ := PSmallInt(ApSrc)^;
      dtUInt64:   PUInt64(ApDest)^ := PSmallInt(ApSrc)^;
      dtSingle:   PSingle(ApDest)^ := PSmallInt(ApSrc)^;
      dtDouble:   PDouble(ApDest)^ := PSmallInt(ApSrc)^;
      dtExtended: PExtended(ApDest)^ := PSmallInt(ApSrc)^;
      dtCurrency: PCurrency(ApDest)^ := PSmallInt(ApSrc)^;
      dtBCD,
      dtFmtBCD:   Int2BCD(PSmallInt(ApSrc), SizeOf(Smallint), False);
      else lConverted := False;
      end;
  dtInt32:
    if ADestType = dtAnsiString then
      if ApSrc <> nil then
        Val2AStr(SF_D, [PInteger(ApSrc)^])
      else
        ADestSize := 12
    else if ADestType = dtWideString then
      if ApSrc <> nil then
        Val2WStr(SF_D, [PInteger(ApSrc)^])
      else
        ADestSize := 12
    else if (ApSrc <> nil) and (ApDest <> nil) then
      case ADestType of
      dtBoolean:  PWordBool(ApDest)^ := WordBool(PInteger(ApSrc)^);
      dtSByte:    PShortInt(ApDest)^ := ShortInt(PInteger(ApSrc)^);
      dtInt16:    PSmallInt(ApDest)^ := SmallInt(PInteger(ApSrc)^);
      dtInt64:    PInt64(ApDest)^ := PInteger(ApSrc)^;
      dtByte:     PByte(ApDest)^ := Byte(PInteger(ApSrc)^);
      dtUInt16:   PWord(ApDest)^ := Word(PInteger(ApSrc)^);
      dtUInt32:   PCardinal(ApDest)^ := PInteger(ApSrc)^;
      dtUInt64:   PUInt64(ApDest)^ := Int64(PInteger(ApSrc)^);
      dtSingle:   PSingle(ApDest)^ := PInteger(ApSrc)^;
      dtDouble:   PDouble(ApDest)^ := PInteger(ApSrc)^;
      dtExtended: PExtended(ApDest)^ := PInteger(ApSrc)^;
      dtCurrency: PCurrency(ApDest)^ := PInteger(ApSrc)^;
      dtBCD,
      dtFmtBCD:   Int2BCD(PInteger(ApSrc), SizeOf(Integer), False);
      else lConverted := False;
      end;
  dtInt64:
    if ADestType = dtAnsiString then
      if ApSrc <> nil then
        Val2AStr(SF_D, [PInt64(ApSrc)^])
      else
        ADestSize := 22
    else if ADestType = dtWideString then
      if ApSrc <> nil then
        Val2WStr(SF_D, [PInt64(ApSrc)^])
      else
        ADestSize := 22
    else if (ApSrc <> nil) and (ApDest <> nil) then
      case ADestType of
      dtBoolean:  PWordBool(ApDest)^ := WordBool(PInt64(ApSrc)^);
      dtSByte:    PShortInt(ApDest)^ := ShortInt(PInt64(ApSrc)^);
      dtInt16:    PSmallInt(ApDest)^ := SmallInt(PInt64(ApSrc)^);
      dtInt32:    PInteger(ApDest)^ := Integer(PInt64(ApSrc)^);
      dtByte:     PByte(ApDest)^ := Byte(PInt64(ApSrc)^);
      dtUInt16:   PWord(ApDest)^ := Word(PInt64(ApSrc)^);
      dtUInt32:   PCardinal(ApDest)^ := Cardinal(PInt64(ApSrc)^);
      dtUInt64:   PUInt64(ApDest)^ := PInt64(ApSrc)^;
      dtSingle:   PSingle(ApDest)^ := PInt64(ApSrc)^;
      dtDouble:   PDouble(ApDest)^ := PInt64(ApSrc)^;
      dtExtended: PExtended(ApDest)^ := PInt64(ApSrc)^;
      dtCurrency: PCurrency(ApDest)^ := PInt64(ApSrc)^;
      dtBCD,
      dtFmtBCD:   Int2BCD(PInt64(ApSrc), SizeOf(Int64), False);
      else lConverted := False;
      end;
  dtByte:
    if ADestType = dtAnsiString then
      if ApSrc <> nil then
        Val2AStr(SF_U, [PByte(ApSrc)^])
      else
        ADestSize := 4
    else if ADestType = dtWideString then
      if ApSrc <> nil then
        Val2WStr(SF_U, [PByte(ApSrc)^])
      else
        ADestSize := 4
    else if (ApSrc <> nil) and (ApDest <> nil) then
      case ADestType of
      dtBoolean:  PWordBool(ApDest)^ := WordBool(PByte(ApSrc)^);
      dtSByte:    PShortInt(ApDest)^ := PByte(ApSrc)^;
      dtInt16:    PSmallInt(ApDest)^ := PByte(ApSrc)^;
      dtInt32:    PInteger(ApDest)^ := PByte(ApSrc)^;
      dtInt64:    PInt64(ApDest)^ := PByte(ApSrc)^;
      dtUInt16:   PWord(ApDest)^ := PByte(ApSrc)^;
      dtUInt32:   PCardinal(ApDest)^ := PByte(ApSrc)^;
      dtUInt64:   PUInt64(ApDest)^ := PByte(ApSrc)^;
      dtSingle:   PSingle(ApDest)^ := PByte(ApSrc)^;
      dtDouble:   PDouble(ApDest)^ := PByte(ApSrc)^;
      dtExtended: PExtended(ApDest)^ := PByte(ApSrc)^;
      dtCurrency: PCurrency(ApDest)^ := PByte(ApSrc)^;
      dtBCD,
      dtFmtBCD:   Int2BCD(PByte(ApSrc), SizeOf(Byte), True);
      else lConverted := False;
      end;
  dtUInt16:
    if ADestType = dtAnsiString then
      if ApSrc <> nil then
        Val2AStr(SF_U, [PWord(ApSrc)^])
      else
        ADestSize := 6
    else if ADestType = dtWideString then
      if ApSrc <> nil then
        Val2WStr(SF_U, [PWord(ApSrc)^])
      else
        ADestSize := 6
    else if (ApSrc <> nil) and (ApDest <> nil) then
      case ADestType of
      dtBoolean:  PWordBool(ApDest)^ := WordBool(PWord(ApSrc)^);
      dtSByte:    PShortInt(ApDest)^ := ShortInt(PWord(ApSrc)^);
      dtInt16:    PSmallInt(ApDest)^ := PWord(ApSrc)^;
      dtInt32:    PInteger(ApDest)^ := PWord(ApSrc)^;
      dtInt64:    PInt64(ApDest)^ := PWord(ApSrc)^;
      dtByte:     PByte(ApDest)^ := Byte(PWord(ApSrc)^);
      dtUInt32:   PCardinal(ApDest)^ := PWord(ApSrc)^;
      dtUInt64:   PUInt64(ApDest)^ := PWord(ApSrc)^;
      dtSingle:   PSingle(ApDest)^ := PWord(ApSrc)^;
      dtDouble:   PDouble(ApDest)^ := PWord(ApSrc)^;
      dtExtended: PExtended(ApDest)^ := PWord(ApSrc)^;
      dtCurrency: PCurrency(ApDest)^ := PWord(ApSrc)^;
      dtBCD,
      dtFmtBCD:   Int2BCD(PWord(ApSrc), SizeOf(Word), True);
      else lConverted := False;
      end;
  dtUInt32:
    if ADestType = dtAnsiString then
      if ApSrc <> nil then
        Val2AStr(SF_U, [PCardinal(ApSrc)^])
      else
        ADestSize := 11
    else if ADestType = dtWideString then
      if ApSrc <> nil then
        Val2WStr(SF_U, [PCardinal(ApSrc)^])
      else
        ADestSize := 11
    else if (ApSrc <> nil) and (ApDest <> nil) then
      case ADestType of
      dtBoolean:  PWordBool(ApDest)^ := WordBool(PCardinal(ApSrc)^);
      dtSByte:    PShortInt(ApDest)^ := ShortInt(PCardinal(ApSrc)^);
      dtInt16:    PSmallInt(ApDest)^ := SmallInt(PCardinal(ApSrc)^);
      dtInt32:    PInteger(ApDest)^ := PCardinal(ApSrc)^;
      dtInt64:    PInt64(ApDest)^ := PCardinal(ApSrc)^;
      dtByte:     PByte(ApDest)^ := Byte(PCardinal(ApSrc)^);
      dtUInt16:   PWord(ApDest)^ := Word(PCardinal(ApSrc)^);
      dtUInt64:   PUInt64(ApDest)^ := PCardinal(ApSrc)^;
      dtSingle:   PSingle(ApDest)^ := PCardinal(ApSrc)^;
      dtDouble:   PDouble(ApDest)^ := PCardinal(ApSrc)^;
      dtExtended: PExtended(ApDest)^ := PCardinal(ApSrc)^;
      dtCurrency: PCurrency(ApDest)^ := PCardinal(ApSrc)^;
      dtBCD,
      dtFmtBCD:   Int2BCD(PCardinal(ApSrc), SizeOf(Cardinal), True);
      else lConverted := False;
      end;
  dtUInt64:
    if ADestType = dtAnsiString then
      if ApSrc <> nil then
        Val2AStr(SF_D, [PUInt64(ApSrc)^])
      else
        ADestSize := 22
    else if ADestType = dtWideString then
      if ApSrc <> nil then
        Val2WStr(SF_D, [PUInt64(ApSrc)^])
      else
        ADestSize := 22
    else if (ApSrc <> nil) and (ApDest <> nil) then
      case ADestType of
      dtBoolean:  PWordBool(ApDest)^ := WordBool(PUInt64(ApSrc)^);
      dtSByte:    PShortInt(ApDest)^ := ShortInt(PUInt64(ApSrc)^);
      dtInt16:    PSmallInt(ApDest)^ := SmallInt(PUInt64(ApSrc)^);
      dtInt32:    PInteger(ApDest)^ := Integer(PUInt64(ApSrc)^);
      dtInt64:    PInt64(ApDest)^ := PUInt64(ApSrc)^;
      dtByte:     PByte(ApDest)^ := Byte(PUInt64(ApSrc)^);
      dtUInt16:   PWord(ApDest)^ := Word(PUInt64(ApSrc)^);
      dtUInt32:   PCardinal(ApDest)^ := Cardinal(PUInt64(ApSrc)^);
      dtSingle:   PSingle(ApDest)^ := PUInt64(ApSrc)^;
      dtDouble:   PDouble(ApDest)^ := PUInt64(ApSrc)^;
      dtExtended: PExtended(ApDest)^ := PUInt64(ApSrc)^;
      dtCurrency: PCurrency(ApDest)^ := PUInt64(ApSrc)^;
      dtBCD,
      dtFmtBCD:   Int2BCD(PUInt64(ApSrc), SizeOf(UInt64), True);
      else lConverted := False;
      end;
  dtSingle:
    if ADestType = dtAnsiString then
      if ApSrc <> nil then
        Val2AStr(SF_F, [PSingle(ApSrc)^])
      else
        ADestSize := 11
    else if ADestType = dtWideString then
      if ApSrc <> nil then
        Val2WStr(SF_F, [PSingle(ApSrc)^])
      else
        ADestSize := 11
    else if (ApSrc <> nil) and (ApDest <> nil) then
      case ADestType of
      dtSByte:    PShortInt(ApDest)^ := ShortInt(Trunc(PSingle(ApSrc)^));
      dtInt16:    PSmallInt(ApDest)^ := SmallInt(Trunc(PSingle(ApSrc)^));
      dtInt32:    PInteger(ApDest)^ := Integer(Trunc(PSingle(ApSrc)^));
      dtInt64:    PInt64(ApDest)^ := Trunc(PSingle(ApSrc)^);
      dtByte:     PByte(ApDest)^ := Byte(Trunc(PSingle(ApSrc)^));
      dtUInt16:   PWord(ApDest)^ := Word(Trunc(PSingle(ApSrc)^));
      dtUInt32:   PCardinal(ApDest)^ := Cardinal(Trunc(PSingle(ApSrc)^));
      dtUInt64:   PUInt64(ApDest)^ := Trunc(PSingle(ApSrc)^);
      dtDouble:   PDouble(ApDest)^ := PSingle(ApSrc)^;
      dtExtended: PExtended(ApDest)^ := PSingle(ApSrc)^;
      dtCurrency: PCurrency(ApDest)^ := PSingle(ApSrc)^;
      dtBCD,
      dtFmtBCD:   FDDouble2BCD(PSingle(ApSrc)^, PBcd(ApDest)^);
      else lConverted := False;
      end;
  dtDouble:
    if ADestType = dtAnsiString then
      if ApSrc <> nil then
        Val2AStr(SF_F, [PDouble(ApSrc)^])
      else
        ADestSize := 19
    else if ADestType = dtWideString then
      if ApSrc <> nil then
        Val2WStr(SF_F, [PDouble(ApSrc)^])
      else
        ADestSize := 19
    else if (ApSrc <> nil) and (ApDest <> nil) then
      case ADestType of
      dtSByte:    PShortInt(ApDest)^ := ShortInt(Trunc(PDouble(ApSrc)^));
      dtInt16:    PSmallInt(ApDest)^ := SmallInt(Trunc(PDouble(ApSrc)^));
      dtInt32:    PInteger(ApDest)^ := Integer(Trunc(PDouble(ApSrc)^));
      dtInt64:    PInt64(ApDest)^ := Trunc(PDouble(ApSrc)^);
      dtByte:     PByte(ApDest)^ := Byte(Trunc(PDouble(ApSrc)^));
      dtUInt16:   PWord(ApDest)^ := Word(Trunc(PDouble(ApSrc)^));
      dtUInt32:   PCardinal(ApDest)^ := Cardinal(Trunc(PDouble(ApSrc)^));
      dtUInt64:   PUInt64(ApDest)^ := Trunc(PDouble(ApSrc)^);
      dtSingle:   PSingle(ApDest)^ := PDouble(ApSrc)^;
      dtExtended: PExtended(ApDest)^ := PDouble(ApSrc)^;
      dtCurrency: PCurrency(ApDest)^ := PDouble(ApSrc)^;
      dtBCD,
      dtFmtBCD:   FDDouble2BCD(PDouble(ApSrc)^, PBcd(ApDest)^);
      else lConverted := False;
      end;
  dtExtended:
    if ADestType = dtAnsiString then
      if ApSrc <> nil then
        Val2AStr(SF_F, [PExtended(ApSrc)^])
      else
        ADestSize := 23
    else if ADestType = dtWideString then
      if ApSrc <> nil then
        Val2WStr(SF_F, [PExtended(ApSrc)^])
      else
        ADestSize := 23
    else if (ApSrc <> nil) and (ApDest <> nil) then
      case ADestType of
      dtSByte:    PShortInt(ApDest)^ := ShortInt(Trunc(PExtended(ApSrc)^));
      dtInt16:    PSmallInt(ApDest)^ := SmallInt(Trunc(PExtended(ApSrc)^));
      dtInt32:    PInteger(ApDest)^ := Integer(Trunc(PExtended(ApSrc)^));
      dtInt64:    PInt64(ApDest)^ := Trunc(PExtended(ApSrc)^);
      dtByte:     PByte(ApDest)^ := Byte(Trunc(PExtended(ApSrc)^));
      dtUInt16:   PWord(ApDest)^ := Word(Trunc(PExtended(ApSrc)^));
      dtUInt32:   PCardinal(ApDest)^ := Cardinal(Trunc(PExtended(ApSrc)^));
      dtUInt64:   PUInt64(ApDest)^ := Trunc(PExtended(ApSrc)^);
      dtSingle:   PSingle(ApDest)^ := PExtended(ApSrc)^;
      dtDouble:   PDouble(ApDest)^ := PExtended(ApSrc)^;
      dtCurrency: PCurrency(ApDest)^ := PExtended(ApSrc)^;
      dtBCD,
      dtFmtBCD:   FDDouble2BCD(PExtended(ApSrc)^, PBcd(ApDest)^);
      else lConverted := False;
      end;
  dtCurrency:
    if ADestType = dtAnsiString then
      if ApSrc <> nil then
        Val2AStr(SF_F, [PCurrency(ApSrc)^])
      else
        ADestSize := 22
    else if ADestType = dtWideString then
      if ApSrc <> nil then
        Val2WStr(SF_F, [PCurrency(ApSrc)^])
      else
        ADestSize := 22
    else if (ApSrc <> nil) and (ApDest <> nil) then
      case ADestType of
      dtSByte:    PShortInt(ApDest)^ := ShortInt(Trunc(PCurrency(ApSrc)^));
      dtInt16:    PSmallInt(ApDest)^ := SmallInt(Trunc(PCurrency(ApSrc)^));
      dtInt32:    PInteger(ApDest)^ := Integer(Trunc(PCurrency(ApSrc)^));
      dtInt64:    PInt64(ApDest)^ := Trunc(PCurrency(ApSrc)^);
      dtByte:     PByte(ApDest)^ := Byte(Trunc(PCurrency(ApSrc)^));
      dtUInt16:   PWord(ApDest)^ := Word(Trunc(PCurrency(ApSrc)^));
      dtUInt32:   PCardinal(ApDest)^ := Cardinal(Trunc(PCurrency(ApSrc)^));
      dtUInt64:   PUInt64(ApDest)^ := Trunc(PCurrency(ApSrc)^);
      dtSingle:   PSingle(ApDest)^ := PCurrency(ApSrc)^;
      dtDouble:   PDouble(ApDest)^ := PCurrency(ApSrc)^;
      dtExtended: PExtended(ApDest)^ := PCurrency(ApSrc)^;
      dtBCD,
      dtFmtBCD:   CurrToBCD(PCurrency(ApSrc)^, PBcd(ApDest)^, 20);
      else lConverted := False;
      end;
  dtBCD,
  dtFmtBCD:
    if ADestType = dtAnsiString then
      if ApSrc <> nil then
        BCD2Str(PBcd(ApSrc), ecANSI)
      else
        ADestSize := 67
    else if ADestType = dtWideString then
      if ApSrc <> nil then
        BCD2Str(PBcd(ApSrc), ecUTF16)
      else
        ADestSize := 67
    else if (ApSrc <> nil) and (ApDest <> nil) then
      case ADestType of
      dtBoolean:  BCD2Int(SizeOf(WordBool), True);
      dtSByte:    BCD2Int(SizeOf(ShortInt), False);
      dtInt16:    BCD2Int(SizeOf(SmallInt), False);
      dtInt32:    BCD2Int(SizeOf(Integer), False);
      dtInt64:    BCD2Int(SizeOf(Int64), False);
      dtByte:     BCD2Int(SizeOf(Byte), True);
      dtUInt16:   BCD2Int(SizeOf(Word), True);
      dtUInt32:   BCD2Int(SizeOf(Cardinal), True);
      dtUInt64:   BCD2Int(SizeOf(UInt64), True);
      dtSingle:   BCD2Dbl(SizeOf(Single));
      dtDouble:   BCD2Dbl(SizeOf(Double));
      dtExtended: BCD2Dbl(SizeOf(Extended));
      dtCurrency: begin BCDToCurr(PBcd(ApSrc)^, c); PCurrency(ApDest)^ := c; end;
      dtFmtBCD,
      dtBCD:      ApDest := ApSrc;
      else lConverted := False;
      end;
  dtDateTime:
    begin
      if ApSrc <> nil then
        rSTS := DateTimeToSQLTimeStamp(FDMSecs2DateTime(PDateTimeRec(ApSrc)^.DateTime));
      if ADestType = dtAnsiString then
        if ApSrc <> nil then
          STS2AStr(@rSTS, dtDateTime)
        else
          ADestSize := C_FD_MaxLenTimeStampStr
      else if ADestType = dtWideString then
        if ApSrc <> nil then
          STS2WStr(@rSTS, dtDateTime)
        else
          ADestSize := C_FD_MaxLenTimeStampStr
      else if (ApSrc <> nil) and (ApDest <> nil) then
        case ADestType of
        dtTime:          PInteger(ApDest)^ := FDSQLTimeStamp2Time(rSTS);
        dtDate:          PInteger(ApDest)^ := FDSQLTimeStamp2Date(rSTS);
        dtDateTimeStamp: PSQLTimeStamp(ApDest)^ := rSTS;
        else lConverted := False;
        end;
    end;
  dtDateTimeStamp:
    if ADestType = dtAnsiString then
      if ApSrc <> nil then
        STS2AStr(PSQLTimeStamp(ApSrc), dtDateTimeStamp)
      else
        ADestSize := C_FD_MaxLenTimeStampStr
    else if ADestType = dtWideString then
      if ApSrc <> nil then
        STS2WStr(PSQLTimeStamp(ApSrc), dtDateTimeStamp)
      else
        ADestSize := C_FD_MaxLenTimeStampStr
    else if (ApSrc <> nil) and (ApDest <> nil) then
      case ADestType of
      dtTime:     PInteger(ApDest)^ := FDSQLTimeStamp2Time(PSQLTimeStamp(ApSrc)^);
      dtDate:     PInteger(ApDest)^ := FDSQLTimeStamp2Date(PSQLTimeStamp(ApSrc)^);
      dtDateTime: PDateTimeRec(ApDest)^.DateTime := FDDateTime2MSecs(
        SQLTimeStampToDateTime(PSQLTimeStamp(ApSrc)^));
      else lConverted := False;
      end;
  dtTimeIntervalFull,
  dtTimeIntervalYM,
  dtTimeIntervalDS:
    if ADestType = dtAnsiString then
      if ApSrc <> nil then
        Val2AStr(SF_S, [FDSQLTimeInterval2Str(PFDSQLTimeInterval(ApSrc)^)])
      else
        ADestSize := C_FD_MaxLenTimeIntStr
    else if ADestType = dtWideString then
      if ApSrc <> nil then
        Val2WStr(SF_S, [FDSQLTimeInterval2Str(PFDSQLTimeInterval(ApSrc)^)])
      else
        ADestSize := C_FD_MaxLenTimeIntStr
    else if ADestType in [dtTimeIntervalFull, dtTimeIntervalYM, dtTimeIntervalDS] then
      ApDest := ApSrc
    else
      lConverted := False;
  dtTime:
    if ADestType = dtAnsiString then
      if ApSrc <> nil then begin
        rSTS := FDTime2SQLTimeStamp(PInteger(ApSrc)^);
        STS2AStr(@rSTS, dtTime);
      end
      else
        ADestSize := C_FD_MaxLenTimeStampStr
    else if ADestType = dtWideString then
      if ApSrc <> nil then begin
        rSTS := FDTime2SQLTimeStamp(PInteger(ApSrc)^);
        STS2WStr(@rSTS, dtTime);
      end
      else
        ADestSize := C_FD_MaxLenTimeStampStr
    else if (ApSrc <> nil) and (ApDest <> nil) then
      case ADestType of
      dtDateTime:      PDateTimeRec(ApDest)^.DateTime := FDDateTime2MSecs(
        SQLTimeStampToDateTime(FDTime2SQLTimeStamp(PInteger(ApSrc)^)));
      dtDateTimeStamp: PSQLTimeStamp(ApDest)^ := FDTime2SQLTimeStamp(PInteger(ApSrc)^)
      else lConverted := False;
      end;
  dtDate:
    if ADestType = dtAnsiString then
      if ApSrc <> nil then begin
        rSTS := FDDate2SQLTimeStamp(PInteger(ApSrc)^);
        STS2AStr(@rSTS, dtDate);
      end
      else
        ADestSize := C_FD_MaxLenTimeStampStr
    else if ADestType = dtWideString then
      if ApSrc <> nil then begin
        rSTS := FDDate2SQLTimeStamp(PInteger(ApSrc)^);
        STS2WStr(@rSTS, dtDate);
      end
      else
        ADestSize := C_FD_MaxLenTimeStampStr
    else if (ApSrc <> nil) and (ApDest <> nil) then
      case ADestType of
      dtDateTime:      PDateTimeRec(ApDest)^.DateTime := FDDateTime2MSecs(
        SQLTimeStampToDateTime(FDDate2SQLTimeStamp(PInteger(ApSrc)^)));
      dtDateTimeStamp: PSQLTimeStamp(ApDest)^ := FDDate2SQLTimeStamp(PInteger(ApSrc)^)
      else lConverted := False;
      end;
  dtAnsiString:
    if ADestType in [dtWideString, dtWideMemo, dtXML, dtWideHMemo] then begin
      ADestSize := ASrcSize;
      if ADestSize > ADestMaxSize div SizeOf(WideChar) then
        ADestSize := ADestMaxSize div SizeOf(WideChar);
      if ApSrc <> nil then
        AStr2WStr;
    end
    else if ADestType in [dtByteString, dtBlob, dtMemo, dtHBlob, dtHBFile, dtHMemo] then begin
      ADestSize := ASrcSize;
      if ADestSize > ADestMaxSize then
        ADestSize := ADestMaxSize;
      if ApSrc <> nil then
        ApDest := ApSrc;
    end
    else if (ApSrc <> nil) and (ApDest <> nil) then
      AStr2Dest;
  dtWideString:
    if ADestType in [dtAnsiString, dtMemo, dtHMemo] then begin
      ADestSize := ASrcSize;
      if ADestSize > ADestMaxSize then
        ADestSize := ADestMaxSize;
      if ApSrc <> nil then
        WStr2AStr;
    end
    else if ADestType in [dtWideMemo, dtXML, dtWideHMemo] then begin
      ADestSize := ASrcSize;
      if ADestSize > ADestMaxSize then
        ADestSize := ADestMaxSize;
      if ApSrc <> nil then
        ApDest := ApSrc;
    end
    else if ADestType in [dtByteString, dtBlob, dtHBlob, dtHBFile] then begin
      ADestSize := ASrcSize;
      ADestSize := ADestSize * SizeOf(WideChar);
      if ADestSize > ADestMaxSize then
        ADestSize := ADestMaxSize;
      if ApSrc <> nil then
        ApDest := ApSrc;
    end
    else if (ApSrc <> nil) and (ApDest <> nil) then
      WStr2Dest;
  dtByteString:
    case ADestType of
    dtAnsiString,
    dtBlob,
    dtMemo,
    dtHBlob,
    dtHBFile,
    dtHMemo,
    dtGUID:
      begin
        ADestSize := ASrcSize;
        if ADestSize > ADestMaxSize then
          ADestSize := ADestMaxSize;
        if ApSrc <> nil then
          ApDest := ApSrc;
      end;
    dtWideString,
    dtWideMemo,
    dtXML,
    dtWideHMemo:
      begin
        ADestSize := ASrcSize div SizeOf(WideChar);
        if ADestSize > ADestMaxSize div SizeOf(WideChar) then
          ADestSize := ADestMaxSize div SizeOf(WideChar);
        if ApSrc <> nil then
          ApDest := ApSrc;
      end;
    else lConverted := False;
    end;
  dtBlob,
  dtHBlob,
  dtHBFile:
    if ADestType in [dtBlob, dtMemo, dtHBlob, dtHBFile, dtHMemo, dtAnsiString, dtByteString, dtGUID] then begin
      ADestSize := ASrcSize;
      if ADestSize > ADestMaxSize then
        ADestSize := ADestMaxSize;
      if ApSrc <> nil then
        ApDest := ApSrc;
    end
    else if ADestType in [dtWideMemo, dtXML, dtWideHMemo] then begin
      ADestSize := ASrcSize div SizeOf(WideChar);
      if ADestSize > ADestMaxSize div SizeOf(WideChar) then
        ADestSize := ADestMaxSize div SizeOf(WideChar);
      if ApSrc <> nil then
        ApDest := ApSrc;
    end
    else lConverted := False;
  dtMemo,
  dtHMemo:
    if ADestType in [dtBlob, dtMemo, dtHBlob, dtHBFile, dtHMemo, dtAnsiString, dtByteString] then begin
      ADestSize := ASrcSize;
      if ADestSize > ADestMaxSize then
        ADestSize := ADestMaxSize;
      if ApSrc <> nil then
        ApDest := ApSrc;
    end
    else if ADestType in [dtWideMemo, dtXML, dtWideHMemo, dtWideString] then begin
      ADestSize := ASrcSize;
      if ADestSize > ADestMaxSize div SizeOf(WideChar) then
        ADestSize := ADestMaxSize div SizeOf(WideChar);
      if ApSrc <> nil then
        AStr2WStr;
    end
    else lConverted := False;
  dtWideMemo,
  dtXML,
  dtWideHMemo:
    if ADestType in [dtAnsiString, dtMemo, dtHMemo] then begin
      ADestSize := ASrcSize;
      if ADestSize > ADestMaxSize then
        ADestSize := ADestMaxSize;
      if ApSrc <> nil then
        WStr2AStr;
    end
    else if ADestType in [dtWideMemo, dtXML, dtWideHMemo, dtWideString] then begin
      ADestSize := ASrcSize;
      if ADestSize > ADestMaxSize then
        ADestSize := ADestMaxSize;
      if ApSrc <> nil then
        ApDest := ApSrc;
    end
    else if ADestType in [dtByteString, dtBlob, dtHBlob, dtHBFile] then begin
      ADestSize := ASrcSize * SizeOf(WideChar);
      if ADestSize > ADestMaxSize then
        ADestSize := ADestMaxSize;
      if ApSrc <> nil then
        ApDest := ApSrc;
    end
    else lConverted := False;
  dtGUID:
    if ADestType = dtAnsiString then
      if ApSrc <> nil then
        Val2AStr(SF_G, [PGUID(ApSrc)^.D1, PGUID(ApSrc)^.D2, PGUID(ApSrc)^.D3,
                        PGUID(ApSrc)^.D4[0], PGUID(ApSrc)^.D4[1], PGUID(ApSrc)^.D4[2],
                        PGUID(ApSrc)^.D4[3], PGUID(ApSrc)^.D4[4], PGUID(ApSrc)^.D4[5],
                        PGUID(ApSrc)^.D4[6], PGUID(ApSrc)^.D4[7]])
      else
        ADestSize := C_FD_GUIDStrLen
    else if ADestType = dtWideString then
      if ApSrc <> nil then
        Val2WStr(SF_G, [PGUID(ApSrc)^.D1, PGUID(ApSrc)^.D2, PGUID(ApSrc)^.D3,
                        PGUID(ApSrc)^.D4[0], PGUID(ApSrc)^.D4[1], PGUID(ApSrc)^.D4[2],
                        PGUID(ApSrc)^.D4[3], PGUID(ApSrc)^.D4[4], PGUID(ApSrc)^.D4[5],
                        PGUID(ApSrc)^.D4[6], PGUID(ApSrc)^.D4[7]])
      else
        ADestSize := C_FD_GUIDStrLen
    else if ADestType in [dtByteString, dtBlob, dtHBlob, dtHBFile] then begin
      ADestSize := ASrcSize;
      if ADestSize > ADestMaxSize then
        ADestSize := ADestMaxSize;
      if ApSrc <> nil then
        ApDest := ApSrc;
    end;
  else
    lConverted := False;
  end;
  ASSERT(lConverted);
end;

{-------------------------------------------------------------------------------}
{- TFDFetchOptions                                                             -}
{-------------------------------------------------------------------------------}
procedure TFDFetchOptions.Assign(ASource: TPersistent);
begin
  if (ASource = nil) or (ASource = Self) then
    Exit;
  if ASource is TFDFetchOptions then begin
    if evMode in TFDFetchOptions(ASource).FAssignedValues then
      Mode := TFDFetchOptions(ASource).Mode;
    if evItems in TFDFetchOptions(ASource).FAssignedValues then
      Items := TFDFetchOptions(ASource).Items;
    if evRecsSkip in TFDFetchOptions(ASource).FAssignedValues then
      RecsSkip := TFDFetchOptions(ASource).RecsSkip;
    if evRecsMax in TFDFetchOptions(ASource).FAssignedValues then
      RecsMax := TFDFetchOptions(ASource).RecsMax;
    if evRowsetSize in TFDFetchOptions(ASource).FAssignedValues then
      RowsetSize := TFDFetchOptions(ASource).RowsetSize;
    if evCache in TFDFetchOptions(ASource).FAssignedValues then
      Cache := TFDFetchOptions(ASource).Cache;
    if evAutoClose in TFDFetchOptions(ASource).FAssignedValues then
      AutoClose := TFDFetchOptions(ASource).AutoClose;
    if evAutoFetchAll in TFDFetchOptions(ASource).FAssignedValues then
      AutoFetchAll := TFDFetchOptions(ASource).AutoFetchAll;
    if evRecordCountMode in TFDFetchOptions(ASource).FAssignedValues then
      RecordCountMode := TFDFetchOptions(ASource).RecordCountMode;
    if evUnidirectional in TFDFetchOptions(ASource).FAssignedValues then
      Unidirectional := TFDFetchOptions(ASource).Unidirectional;
    if evCursorKind in TFDFetchOptions(ASource).FAssignedValues then
      CursorKind := TFDFetchOptions(ASource).CursorKind;
    if evLiveWindowParanoic in TFDFetchOptions(ASource).FAssignedValues then
      LiveWindowParanoic := TFDFetchOptions(ASource).LiveWindowParanoic;
    if evLiveWindowFastFirst in TFDFetchOptions(ASource).FAssignedValues then
      LiveWindowFastFirst := TFDFetchOptions(ASource).LiveWindowFastFirst;
    if evDetailDelay in TFDFetchOptions(ASource).FAssignedValues then
      DetailDelay := TFDFetchOptions(ASource).DetailDelay;
    if evDetailOptimize in TFDFetchOptions(ASource).FAssignedValues then
      DetailOptimize := TFDFetchOptions(ASource).DetailOptimize;
    if evDetailCascade in TFDFetchOptions(ASource).FAssignedValues then
      DetailCascade := TFDFetchOptions(ASource).DetailCascade;
    if evDetailServerCascade in TFDFetchOptions(ASource).FAssignedValues then
      DetailServerCascade := TFDFetchOptions(ASource).DetailServerCascade;
  end
  else
    inherited Assign(ASource);
end;

{-------------------------------------------------------------------------------}
procedure TFDFetchOptions.RestoreDefaults;
begin
  inherited RestoreDefaults;
  FAssignedValues := [];
  FMode := fmOnDemand;
  FRecsSkip := -1;
  FRecsMax := -1;
  FRowsetSize := C_FD_DefRowSetSize;
  FItems := [fiBlobs, fiDetails, fiMeta];
  FCache := [fiBlobs, fiDetails, fiMeta];
  FAutoClose := True;
  FAutoFetchAll := afAll;
  FRecordCountMode := cmVisible;
  FUnidirectional := False;
  FCursorKind := ckAutomatic;
  FLiveWindowParanoic := True;
  FLiveWindowFastFirst := False;
  FDetailDelay := 0;
  FDetailOptimize := True;
  FDetailCascade := False;
  FDetailServerCascade := False;
  Inc(FVersion);
end;

{-------------------------------------------------------------------------------}
function TFDFetchOptions.IsValueOwned(AValue: TFDFetchOptionValue;
  var AParentOpts: IFDStanOptions): Boolean;
begin
  Result := not Assigned(Container.FParentCallback) or (AValue in FAssignedValues);
  if not Result then begin
    Container.FParentCallback(AParentOpts);
    Result := (AParentOpts = nil);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDFetchOptions.GetRecsSkip: Integer;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(evRecsSkip, oParentOpts) then
    Result := FRecsSkip
  else
    Result := oParentOpts.FetchOptions.RecsSkip;
end;

{-------------------------------------------------------------------------------}
procedure TFDFetchOptions.SetRecsSkip(const AValue: Integer);
begin
  if not (evRecsSkip in FAssignedValues) or (FRecsSkip <> AValue) then begin
    FRecsSkip := AValue;
    Include(FAssignedValues, evRecsSkip);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDFetchOptions.IsESS: Boolean;
begin
  Result := evRecsSkip in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDFetchOptions.GetRecsMax: Integer;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(evRecsMax, oParentOpts) then
    Result := FRecsMax
  else
    Result := oParentOpts.FetchOptions.RecsMax;
end;

{-------------------------------------------------------------------------------}
procedure TFDFetchOptions.SetRecsMax(const AValue: Integer);
begin
  if not (evRecsMax in FAssignedValues) or (FRecsMax <> AValue) then begin
    FRecsMax := AValue;
    Include(FAssignedValues, evRecsMax);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDFetchOptions.IsRMS: Boolean;
begin
  Result := evRecsMax in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDFetchOptions.GetRowsetSize: Integer;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(evRowsetSize, oParentOpts) then
    Result := FRowsetSize
  else
    Result := oParentOpts.FetchOptions.RowsetSize;
end;

{-------------------------------------------------------------------------------}
procedure TFDFetchOptions.SetRowsetSize(const AValue: Integer);
begin
  if not (evRowsetSize in FAssignedValues) or (FRowsetSize <> AValue) then begin
    FRowsetSize := AValue;
    Include(FAssignedValues, evRowsetSize);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDFetchOptions.GetActualRowsetSize: Integer;
var
  iRecsMax: Integer;
begin
  Result := RowsetSize;
  iRecsMax := RecsMax;
  if Mode = fmExactRecsMax then begin
    if iRecsMax > 0 then
      Result := iRecsMax;
  end
  else begin
    if (iRecsMax > 0) and (Result > iRecsMax) then
      Result := iRecsMax;
  end;
  if Result <= 0 then
    Result := 1;
end;

{-------------------------------------------------------------------------------}
function TFDFetchOptions.IsRSS: Boolean;
begin
  Result := evRowsetSize in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDFetchOptions.GetItems: TFDFetchItems;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(evItems, oParentOpts) then
    Result := FItems
  else
    Result := oParentOpts.FetchOptions.Items;
end;

{-------------------------------------------------------------------------------}
procedure TFDFetchOptions.SetItems(const AValue: TFDFetchItems);
begin
  if not (evItems in FAssignedValues) or (FItems <> AValue) then begin
    FItems := AValue;
    Include(FAssignedValues, evItems);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDFetchOptions.IsIS: Boolean;
begin
  Result := evItems in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDFetchOptions.GetMode: TFDFetchMode;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(evMode, oParentOpts) then
    Result := FMode
  else
    Result := oParentOpts.FetchOptions.Mode;
end;

{-------------------------------------------------------------------------------}
procedure TFDFetchOptions.SetMode(const AValue: TFDFetchMode);
begin
  if not (evMode in FAssignedValues) or (FMode <> AValue) then begin
    FMode := AValue;
    Include(FAssignedValues, evMode);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDFetchOptions.IsMS: Boolean;
begin
  Result := evMode in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDFetchOptions.GetCache: TFDFetchItems;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(evCache, oParentOpts) then
    Result := FCache
  else
    Result := oParentOpts.FetchOptions.Cache;
end;

{-------------------------------------------------------------------------------}
procedure TFDFetchOptions.SetCache(const AValue: TFDFetchItems);
begin
  if not (evCache in FAssignedValues) or (FCache <> AValue) then begin
    FCache := AValue;
    Include(FAssignedValues, evCache);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDFetchOptions.IsCS: Boolean;
begin
  Result := evCache in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDFetchOptions.GetAutoClose: Boolean;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(evAutoClose, oParentOpts) then
    Result := FAutoClose
  else
    Result := oParentOpts.FetchOptions.AutoClose;
end;

{-------------------------------------------------------------------------------}
procedure TFDFetchOptions.SetAutoClose(const AValue: Boolean);
begin
  if not (evAutoClose in FAssignedValues) or (FAutoClose <> AValue) then begin
    FAutoClose := AValue;
    Include(FAssignedValues, evAutoClose);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDFetchOptions.IsACS: Boolean;
begin
  Result := evAutoClose in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDFetchOptions.GetAutoFetchAll: TFDAutoFetchAll;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(evAutoFetchAll, oParentOpts) then
    Result := FAutoFetchAll
  else
    Result := oParentOpts.FetchOptions.AutoFetchAll;
end;

{-------------------------------------------------------------------------------}
procedure TFDFetchOptions.SetAutoFetchAll(const AValue: TFDAutoFetchAll);
begin
  if not (evAutoFetchAll in FAssignedValues) or (FAutoFetchAll <> AValue) then begin
    FAutoFetchAll := AValue;
    Include(FAssignedValues, evAutoFetchAll);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDFetchOptions.IsAFAS: Boolean;
begin
  Result := evAutoFetchAll in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDFetchOptions.GetRecordcountMode: TFDRecordCountMode;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(evRecordcountMode, oParentOpts) then
    Result := FRecordcountMode
  else
    Result := oParentOpts.FetchOptions.RecordcountMode;
end;

{-------------------------------------------------------------------------------}
procedure TFDFetchOptions.SetRecordCountMode(const AValue: TFDRecordCountMode);
begin
  if not (evRecordCountMode in FAssignedValues) or (FRecordCountMode <> AValue) then begin
    FRecordCountMode := AValue;
    Include(FAssignedValues, evRecordCountMode);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDFetchOptions.IsRCMS: Boolean;
begin
  Result := evRecordCountMode in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDFetchOptions.GetUnidirectional: Boolean;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(evUnidirectional, oParentOpts) then
    Result := FUnidirectional
  else
    Result := oParentOpts.FetchOptions.Unidirectional;
end;

{-------------------------------------------------------------------------------}
procedure TFDFetchOptions.SetUnidirectional(const AValue: Boolean);
begin
  if not (evUnidirectional in FAssignedValues) or (FUnidirectional <> AValue) then begin
    FUnidirectional := AValue;
    Include(FAssignedValues, evUnidirectional);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDFetchOptions.IsUS: Boolean;
begin
  Result := evUnidirectional in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDFetchOptions.GetCursor: TFDCursorKind;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(evCursorKind, oParentOpts) then
    Result := FCursorKind
  else
    Result := oParentOpts.FetchOptions.CursorKind;
end;

{-------------------------------------------------------------------------------}
procedure TFDFetchOptions.SetCursor(const AValue: TFDCursorKind);
begin
  if not (evCursorKind in FAssignedValues) or (FCursorKind <> AValue) then begin
    FCursorKind := AValue;
    Include(FAssignedValues, evCursorKind);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDFetchOptions.IsCKS: Boolean;
begin
  Result := evCursorKind in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDFetchOptions.GetLiveWindowParanoic: Boolean;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(evLiveWindowParanoic, oParentOpts) then
    Result := FLiveWindowParanoic
  else
    Result := oParentOpts.FetchOptions.LiveWindowParanoic;
end;

{-------------------------------------------------------------------------------}
procedure TFDFetchOptions.SetLiveWindowParanoic(const AValue: Boolean);
begin
  if not (evLiveWindowParanoic in FAssignedValues) or (FLiveWindowParanoic <> AValue) then begin
    FLiveWindowParanoic := AValue;
    Include(FAssignedValues, evLiveWindowParanoic);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDFetchOptions.IsLWP: Boolean;
begin
  Result := evLiveWindowParanoic in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDFetchOptions.GetLiveWindowFastFirst: Boolean;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(evLiveWindowFastFirst, oParentOpts) then
    Result := FLiveWindowFastFirst
  else
    Result := oParentOpts.FetchOptions.LiveWindowFastFirst;
end;

{-------------------------------------------------------------------------------}
procedure TFDFetchOptions.SetLiveWindowFastFirst(const AValue: Boolean);
begin
  if not (evLiveWindowFastFirst in FAssignedValues) or (FLiveWindowFastFirst <> AValue) then begin
    FLiveWindowFastFirst := AValue;
    Include(FAssignedValues, evLiveWindowFastFirst);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDFetchOptions.IsLWFF: Boolean;
begin
  Result := evLiveWindowFastFirst in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDFetchOptions.GetDetailDelay: Integer;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(evDetailDelay, oParentOpts) then
    Result := FDetailDelay
  else
    Result := oParentOpts.FetchOptions.DetailDelay;
end;

{-------------------------------------------------------------------------------}
procedure TFDFetchOptions.SetDetailDelay(const AValue: Integer);
begin
  if not (evDetailDelay in FAssignedValues) or (FDetailDelay <> AValue) then begin
    FDetailDelay := AValue;
    Include(FAssignedValues, evDetailDelay);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDFetchOptions.IsDDS: Boolean;
begin
  Result := evDetailDelay in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDFetchOptions.GetDetailOptimize: Boolean;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(evDetailOptimize, oParentOpts) then
    Result := FDetailOptimize
  else
    Result := oParentOpts.FetchOptions.DetailOptimize;
end;

{-------------------------------------------------------------------------------}
procedure TFDFetchOptions.SetDetailOptimize(const AValue: Boolean);
begin
  if not (evDetailOptimize in FAssignedValues) or (FDetailOptimize <> AValue) then begin
    FDetailOptimize := AValue;
    Include(FAssignedValues, evDetailOptimize);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDFetchOptions.IsDOS: Boolean;
begin
  Result := evDetailOptimize in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDFetchOptions.GetDetailCascade: Boolean;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(evDetailCascade, oParentOpts) then
    Result := FDetailCascade
  else
    Result := oParentOpts.FetchOptions.DetailCascade;
end;

{-------------------------------------------------------------------------------}
procedure TFDFetchOptions.SetDetailCascade(const AValue: Boolean);
begin
  if not (evDetailCascade in FAssignedValues) or (FDetailCascade <> AValue) then begin
    FDetailCascade := AValue;
    Include(FAssignedValues, evDetailCascade);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDFetchOptions.IsDCS: Boolean;
begin
  Result := evDetailCascade in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDFetchOptions.GetDetailServerCascade: Boolean;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(evDetailServerCascade, oParentOpts) then
    Result := FDetailServerCascade
  else
    Result := oParentOpts.FetchOptions.DetailServerCascade;
end;

{-------------------------------------------------------------------------------}
procedure TFDFetchOptions.SetDetailServerCascade(const AValue: Boolean);
begin
  if not (evDetailServerCascade in FAssignedValues) or (FDetailServerCascade <> AValue) then begin
    FDetailServerCascade := AValue;
    Include(FAssignedValues, evDetailServerCascade);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDFetchOptions.IsSDCS: Boolean;
begin
  Result := evDetailServerCascade in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
{- TFDUpdateOptions                                                            -}
{-------------------------------------------------------------------------------}
procedure TFDUpdateOptions.RestoreDefaults;
begin
  inherited RestoreDefaults;
  FAssignedValues := [];
  FEnableDelete := True;
  FEnableInsert := True;
  FEnableUpdate := True;
  FUpdateChangedFields := True;
  FUpdateMode := upWhereKeyOnly;
  FLockMode := lmNone;
  FLockPoint := lpDeferred;
  FLockWait := False;
  FRefreshMode := rmOnDemand;
  FrefreshDelete := True;
  FCountUpdatedRecords := True;
  FFetchGeneratorsPoint := gpDeferred;
  FGeneratorName := '';
  FCheckRequired := True;
  FCheckReadOnly := True;
  FCheckUpdatable := True;
  FUpdateNonBaseFields := False;
  FAutoCommitUpdates := False;
  Inc(FVersion);
end;

{-------------------------------------------------------------------------------}
procedure TFDUpdateOptions.Assign(ASource: TPersistent);
begin
  if (ASource = nil) or (ASource = Self) then
    Exit;
  if ASource is TFDUpdateOptions then begin
    if uvEDelete in TFDUpdateOptions(ASource).FAssignedValues then
      EnableDelete := TFDUpdateOptions(ASource).EnableDelete;
    if uvEInsert in TFDUpdateOptions(ASource).FAssignedValues then
      EnableInsert := TFDUpdateOptions(ASource).EnableInsert;
    if uvEUpdate in TFDUpdateOptions(ASource).FAssignedValues then
      EnableUpdate := TFDUpdateOptions(ASource).EnableUpdate;
    if uvUpdateChngFields in TFDUpdateOptions(ASource).FAssignedValues then
      UpdateChangedFields := TFDUpdateOptions(ASource).UpdateChangedFields;
    if uvUpdateMode in TFDUpdateOptions(ASource).FAssignedValues then
      UpdateMode := TFDUpdateOptions(ASource).UpdateMode;
    if uvLockMode in TFDUpdateOptions(ASource).FAssignedValues then
      LockMode := TFDUpdateOptions(ASource).LockMode;
    if uvLockPoint in TFDUpdateOptions(ASource).FAssignedValues then
      LockPoint := TFDUpdateOptions(ASource).LockPoint;
    if uvLockWait in TFDUpdateOptions(ASource).FAssignedValues then
      LockWait := TFDUpdateOptions(ASource).LockWait;
    if uvRefreshMode in TFDUpdateOptions(ASource).FAssignedValues then
      RefreshMode := TFDUpdateOptions(ASource).RefreshMode;
    if uvRefreshDelete in TFDUpdateOptions(ASource).FAssignedValues then
      RefreshDelete := TFDUpdateOptions(ASource).RefreshDelete;
    if uvCountUpdatedRecords in TFDUpdateOptions(ASource).FAssignedValues then
      CountUpdatedRecords := TFDUpdateOptions(ASource).CountUpdatedRecords;
    if uvFetchGeneratorsPoint in TFDUpdateOptions(ASource).FAssignedValues then
      FetchGeneratorsPoint := TFDUpdateOptions(ASource).FetchGeneratorsPoint;
    if uvGeneratorName in TFDUpdateOptions(ASource).FAssignedValues then
      GeneratorName := TFDUpdateOptions(ASource).GeneratorName;
    if uvCheckRequired in TFDUpdateOptions(ASource).FAssignedValues then
      CheckRequired := TFDUpdateOptions(ASource).CheckRequired;
    if uvCheckReadOnly in TFDUpdateOptions(ASource).FAssignedValues then
      CheckReadOnly := TFDUpdateOptions(ASource).CheckReadOnly;
    if uvCheckUpdatable in TFDUpdateOptions(ASource).FAssignedValues then
      CheckUpdatable := TFDUpdateOptions(ASource).CheckUpdatable;
    if uvUpdateNonBaseFields in TFDUpdateOptions(ASource).FAssignedValues then
      UpdateNonBaseFields := TFDUpdateOptions(ASource).UpdateNonBaseFields;
    if uvAutoCommitUpdates in TFDUpdateOptions(ASource).FAssignedValues then
      AutoCommitUpdates := TFDUpdateOptions(ASource).AutoCommitUpdates;
  end
  else
    inherited Assign(ASource);
end;

{-------------------------------------------------------------------------------}
function TFDUpdateOptions.CheckRequest(ARequest: TFDUpdateRequest;
  AOptions: TFDUpdateRowOptions; ACachedUpdates: Boolean): Boolean;
begin
  Result := False;
  if ACachedUpdates and (uoImmediateUpd in AOptions) and
     ((ARequest <> arLock) or (uoDeferredLock in AOptions)) then
    Exit;
  case ARequest of
  arLock:
    case LockPoint of
    lpImmediate:
      if (uoDeferredLock in AOptions) and
         not (uoOneMomLock in AOptions) then
        Exit;
    lpDeferred:
      if not (uoDeferredLock in AOptions) or
         (uoOneMomLock in AOptions) then
        Exit;
    end;
  arFetchGenerators:
    case FetchGeneratorsPoint of
    gpNone:
      Exit;
    gpImmediate:
      if (uoDeferredGenGet in AOptions) then
        Exit;
    gpDeferred:
      if not (uoDeferredGenGet in AOptions) then
        Exit;
    end;
  end;
  Result := True;
end;

{-------------------------------------------------------------------------------}
function TFDUpdateOptions.IsValueOwned(AValue: TFDUpdateOptionValue;
  var AParentOpts: IFDStanOptions): Boolean;
begin
  Result := not Assigned(Container.FParentCallback) or (AValue in FAssignedValues);
  if not Result then begin
    Container.FParentCallback(AParentOpts);
    Result := (AParentOpts = nil);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDUpdateOptions.GetEnableDelete: Boolean;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(uvEDelete, oParentOpts) then
    Result := FEnableDelete
  else
    Result := oParentOpts.UpdateOptions.EnableDelete;
end;

{-------------------------------------------------------------------------------}
procedure TFDUpdateOptions.SetEnableDelete(AValue: Boolean);
begin
  if not (uvEDelete in FAssignedValues) or (FEnableDelete <> AValue) then begin
    FEnableDelete := AValue;
    Include(FAssignedValues, uvEDelete);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDUpdateOptions.IsEDS: Boolean;
begin
  Result := uvEDelete in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDUpdateOptions.GetEnableInsert: Boolean;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(uvEInsert, oParentOpts) then
    Result := FEnableInsert
  else
    Result := oParentOpts.UpdateOptions.EnableInsert;
end;

{-------------------------------------------------------------------------------}
procedure TFDUpdateOptions.SetEnableInsert(AValue: Boolean);
begin
  if not (uvEInsert in FAssignedValues) or (FEnableInsert <> AValue) then begin
    FEnableInsert := AValue;
    Include(FAssignedValues, uvEInsert);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDUpdateOptions.IsEIS: Boolean;
begin
  Result := uvEInsert in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDUpdateOptions.GetEnableUpdate: Boolean;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(uvEUpdate, oParentOpts) then
    Result := FEnableUpdate
  else
    Result := oParentOpts.UpdateOptions.EnableUpdate;
end;

{-------------------------------------------------------------------------------}
procedure TFDUpdateOptions.SetEnableUpdate(AValue: Boolean);
begin
  if not (uvEUpdate in FAssignedValues) or (FEnableUpdate <> AValue) then begin
    FEnableUpdate := AValue;
    Include(FAssignedValues, uvEUpdate);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDUpdateOptions.IsEUS: Boolean;
begin
  Result := uvEUpdate in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDUpdateOptions.GetReadOnly: Boolean;
begin
  Result := not EnableDelete and not EnableInsert and not EnableUpdate;
end;

{-------------------------------------------------------------------------------}
procedure TFDUpdateOptions.SetReadOnly(const AValue: Boolean);
begin
  EnableDelete := not AValue;
  EnableInsert := not AValue;
  EnableUpdate := not AValue;
end;

{-------------------------------------------------------------------------------}
function TFDUpdateOptions.GetUpdateChangedFields: Boolean;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(uvUpdateChngFields, oParentOpts) then
    Result := FUpdateChangedFields
  else
    Result := oParentOpts.UpdateOptions.UpdateChangedFields;
end;

{-------------------------------------------------------------------------------}
procedure TFDUpdateOptions.SetUpdateChangedFields(const AValue: Boolean);
begin
  if not (uvUpdateChngFields in FAssignedValues) or (FUpdateChangedFields <> AValue) then begin
    FUpdateChangedFields := AValue;
    Include(FAssignedValues, uvUpdateChngFields);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDUpdateOptions.IsUCFS: Boolean;
begin
  Result := uvUpdateChngFields in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDUpdateOptions.GetUpdateMode: TUpdateMode;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(uvUpdateMode, oParentOpts) then
    Result := FUpdateMode
  else
    Result := oParentOpts.UpdateOptions.UpdateMode;
end;

{-------------------------------------------------------------------------------}
procedure TFDUpdateOptions.SetUpdateMode(const AValue: TUpdateMode);
begin
  if not (uvUpdateMode in FAssignedValues) or (FUpdateMode <> AValue) then begin
    FUpdateMode := AValue;
    Include(FAssignedValues, uvUpdateMode);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDUpdateOptions.IsUMS: Boolean;
begin
  Result := uvUpdateMode in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDUpdateOptions.GetLockMode: TFDLockMode;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(uvLockMode, oParentOpts) then
    Result := FLockMode
  else
    Result := oParentOpts.UpdateOptions.LockMode;
end;

{-------------------------------------------------------------------------------}
procedure TFDUpdateOptions.SetLockMode(const AValue: TFDLockMode);
begin
  if not (uvLockMode in FAssignedValues) or (FLockMode <> AValue) then begin
    FLockMode := AValue;
    Include(FAssignedValues, uvLockMode);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDUpdateOptions.IsLMS: Boolean;
begin
  Result := uvLockMode in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDUpdateOptions.GetLockPoint: TFDLockPoint;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(uvLockPoint, oParentOpts) then
    Result := FLockPoint
  else
    Result := oParentOpts.UpdateOptions.LockPoint;
end;

{-------------------------------------------------------------------------------}
procedure TFDUpdateOptions.SetLockPoint(const AValue: TFDLockPoint);
begin
  if not (uvLockPoint in FAssignedValues) or (FLockPoint <> AValue) then begin
    FLockPoint := AValue;
    Include(FAssignedValues, uvLockPoint);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDUpdateOptions.IsLPS: Boolean;
begin
  Result := uvLockPoint in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDUpdateOptions.GetLockWait: Boolean;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(uvLockWait, oParentOpts) then
    Result := FLockWait
  else
    Result := oParentOpts.UpdateOptions.LockWait;
end;

{-------------------------------------------------------------------------------}
procedure TFDUpdateOptions.SetLockWait(const AValue: Boolean);
begin
  if not (uvLockWait in FAssignedValues) or (FLockWait <> AValue) then begin
    FLockWait := AValue;
    Include(FAssignedValues, uvLockWait);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDUpdateOptions.IsLWS: Boolean;
begin
  Result := uvLockWait in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDUpdateOptions.GetRefreshMode: TFDRefreshMode;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(uvRefreshMode, oParentOpts) then
    Result := FRefreshMode
  else
    Result := oParentOpts.UpdateOptions.RefreshMode;
end;

{-------------------------------------------------------------------------------}
procedure TFDUpdateOptions.SetRefreshMode(const AValue: TFDRefreshMode);
begin
  if not (uvRefreshMode in FAssignedValues) or (FRefreshMode <> AValue) then begin
    FRefreshMode := AValue;
    Include(FAssignedValues, uvRefreshMode);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDUpdateOptions.IsRMS: Boolean;
begin
  Result := uvRefreshMode in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDUpdateOptions.GetRefreshDelete: Boolean;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(uvRefreshDelete, oParentOpts) then
    Result := FRefreshDelete
  else
    Result := oParentOpts.UpdateOptions.RefreshDelete;
end;

{-------------------------------------------------------------------------------}
procedure TFDUpdateOptions.SetRefreshDelete(const AValue: Boolean);
begin
  if not (uvRefreshDelete in FAssignedValues) or (FRefreshDelete <> AValue) then begin
    FRefreshDelete := AValue;
    Include(FAssignedValues, uvRefreshDelete);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDUpdateOptions.IsRDS: Boolean;
begin
  Result := uvRefreshDelete in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDUpdateOptions.GetCountUpdatedRecords: Boolean;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(uvCountUpdatedRecords, oParentOpts) then
    Result := FCountUpdatedRecords
  else
    Result := oParentOpts.UpdateOptions.CountUpdatedRecords;
end;

{-------------------------------------------------------------------------------}
procedure TFDUpdateOptions.SetCountUpdatedRecords(const AValue: Boolean);
begin
  if not (uvCountUpdatedRecords in FAssignedValues) or (FCountUpdatedRecords <> AValue) then begin
    FCountUpdatedRecords := AValue;
    Include(FAssignedValues, uvCountUpdatedRecords);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDUpdateOptions.IsCURS: Boolean;
begin
  Result := uvCountUpdatedRecords in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDUpdateOptions.GetFastUpdates: Boolean;
begin
  Result := not UpdateChangedFields and (UpdateMode = upWhereKeyOnly) and
    (LockMode = lmNone) and LockWait and (RefreshMode = rmManual) and
    not CheckRequired and not CheckReadOnly and not CheckUpdatable;
end;

{-------------------------------------------------------------------------------}
procedure TFDUpdateOptions.SetFastUpdates(const AValue: Boolean);
begin
  if AValue then begin
    UpdateChangedFields := False;
    UpdateMode := upWhereKeyOnly;
    LockMode := lmNone;
    LockPoint := lpDeferred;
    LockWait := True;
    FetchGeneratorsPoint := gpNone;
    RefreshMode := rmManual;
    CheckRequired := False;
    CheckReadOnly := False;
    CheckUpdatable := False;
  end
  else begin
    FUpdateChangedFields := True;
    FUpdateMode := upWhereKeyOnly;
    FLockMode := lmNone;
    FLockPoint := lpDeferred;
    FLockWait := False;
    FFetchGeneratorsPoint := gpDeferred;
    FRefreshMode := rmOnDemand;
    FCheckRequired := True;
    FCheckReadOnly := True;
    FCheckUpdatable := True;
    FAssignedValues := FAssignedValues - [uvUpdateChngFields, uvUpdateMode,
      uvLockMode, uvLockPoint, uvLockWait, uvFetchGeneratorsPoint, uvRefreshMode,
      uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable];
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDUpdateOptions.GetRequestLive: Boolean;
begin
  Result := (fiMeta in Container.FFetchOptions.Items) and not ReadOnly;
end;

{-------------------------------------------------------------------------------}
procedure TFDUpdateOptions.SetRequestLive(const AValue: Boolean);
begin
  if RequestLive <> AValue then
    if AValue then begin
      Container.FFetchOptions.Items := Container.FFetchOptions.Items + [fiMeta];
      ReadOnly := False;
    end
    else begin
      Container.FFetchOptions.Items := Container.FFetchOptions.Items - [fiMeta];
      ReadOnly := True;
    end;
end;

{-------------------------------------------------------------------------------}
function TFDUpdateOptions.GetFetchGeneratorsPoint: TFDFetchGeneratorsPoint;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(uvFetchGeneratorsPoint, oParentOpts) then
    Result := FFetchGeneratorsPoint
  else
    Result := oParentOpts.UpdateOptions.FetchGeneratorsPoint;
end;

{-------------------------------------------------------------------------------}
procedure TFDUpdateOptions.SetFetchGeneratorsPoint(const AValue: TFDFetchGeneratorsPoint);
begin
  if not (uvFetchGeneratorsPoint in FAssignedValues) or (FFetchGeneratorsPoint <> AValue) then begin
    FFetchGeneratorsPoint := AValue;
    Include(FAssignedValues, uvFetchGeneratorsPoint);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDUpdateOptions.IsGGPS: Boolean;
begin
  Result := uvFetchGeneratorsPoint in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDUpdateOptions.GetGeneratorName: String;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(uvGeneratorName, oParentOpts) then
    Result := FGeneratorName
  else
    Result := oParentOpts.UpdateOptions.GeneratorName;
end;

{-------------------------------------------------------------------------------}
procedure TFDUpdateOptions.SetGeneratorName(const AValue: String);
begin
  if not (uvGeneratorName in FAssignedValues) or (FGeneratorName <> AValue) then begin
    FGeneratorName := AValue;
    Include(FAssignedValues, uvGeneratorName);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDUpdateOptions.IsGNS: Boolean;
begin
  Result := uvGeneratorName in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDUpdateOptions.GetCheckRequired: Boolean;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(uvCheckRequired, oParentOpts) then
    Result := FCheckRequired
  else
    Result := oParentOpts.UpdateOptions.CheckRequired;
end;

{-------------------------------------------------------------------------------}
procedure TFDUpdateOptions.SetCheckRequired(const AValue: Boolean);
begin
  if not (uvCheckRequired in FAssignedValues) or (FCheckRequired <> AValue) then begin
    FCheckRequired := AValue;
    Include(FAssignedValues, uvCheckRequired);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDUpdateOptions.IsCRS: Boolean;
begin
  Result := uvCheckRequired in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDUpdateOptions.GetCheckReadOnly: Boolean;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(uvCheckReadOnly, oParentOpts) then
    Result := FCheckReadOnly
  else
    Result := oParentOpts.UpdateOptions.CheckReadOnly;
end;

{-------------------------------------------------------------------------------}
procedure TFDUpdateOptions.SetCheckReadOnly(const AValue: Boolean);
begin
  if not (uvCheckReadOnly in FAssignedValues) or (FCheckReadOnly <> AValue) then begin
    FCheckReadOnly := AValue;
    Include(FAssignedValues, uvCheckReadOnly);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDUpdateOptions.IsCROS: Boolean;
begin
  Result := uvCheckReadOnly in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDUpdateOptions.GetCheckUpdatable: Boolean;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(uvCheckUpdatable, oParentOpts) then
    Result := FCheckUpdatable
  else
    Result := oParentOpts.UpdateOptions.CheckUpdatable;
end;

{-------------------------------------------------------------------------------}
procedure TFDUpdateOptions.SetCheckUpdatable(const AValue: Boolean);
begin
  if not (uvCheckUpdatable in FAssignedValues) or (FCheckUpdatable <> AValue) then begin
    FCheckUpdatable := AValue;
    Include(FAssignedValues, uvCheckUpdatable);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDUpdateOptions.IsCUS: Boolean;
begin
  Result := uvCheckUpdatable in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDUpdateOptions.GetUpdateNonBaseFields: Boolean;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(uvUpdateNonBaseFields, oParentOpts) then
    Result := FUpdateNonBaseFields
  else
    Result := oParentOpts.UpdateOptions.UpdateNonBaseFields;
end;

{-------------------------------------------------------------------------------}
procedure TFDUpdateOptions.SetUpdateNonBaseFields(const AValue: Boolean);
begin
  if not (uvUpdateNonBaseFields in FAssignedValues) or (FUpdateNonBaseFields <> AValue) then begin
    FUpdateNonBaseFields := AValue;
    Include(FAssignedValues, uvUpdateNonBaseFields);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDUpdateOptions.IsUNFS: Boolean;
begin
  Result := uvUpdateNonBaseFields in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDUpdateOptions.GetAutoCommitUpdates: Boolean;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(uvAutoCommitUpdates, oParentOpts) then
    Result := FAutoCommitUpdates
  else
    Result := oParentOpts.UpdateOptions.AutoCommitUpdates;
end;

{-------------------------------------------------------------------------------}
procedure TFDUpdateOptions.SetAutoCommitUpdates(const AValue: Boolean);
begin
  if not (uvAutoCommitUpdates in FAssignedValues) or (FAutoCommitUpdates <> AValue) then begin
    FAutoCommitUpdates := AValue;
    Include(FAssignedValues, uvAutoCommitUpdates);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDUpdateOptions.IsACUS: Boolean;
begin
  Result := uvAutoCommitUpdates in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
{ TFDBottomUpdateOptions                                                        }
{-------------------------------------------------------------------------------}
procedure TFDBottomUpdateOptions.Assign(ASource: TPersistent);
begin
  inherited Assign(ASource);
  if ASource is TFDBottomUpdateOptions then begin
    UpdateTableName := TFDBottomUpdateOptions(ASource).UpdateTableName;
    KeyFields := TFDBottomUpdateOptions(ASource).KeyFields;
    AutoIncFields := TFDBottomUpdateOptions(ASource).AutoIncFields;
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDBottomUpdateOptions.RestoreDefaults;
begin
  inherited RestoreDefaults;
  FUpdateTableName := '';
  FKeyFields := '';
  FAutoIncFields := '';
end;

{-------------------------------------------------------------------------------}
procedure TFDBottomUpdateOptions.SetAutoIncFields(const AValue: String);
begin
  if FAutoIncFields <> AValue then begin
    FAutoIncFields := AValue;
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDBottomUpdateOptions.SetKeyFields(const AValue: String);
begin
  if FKeyFields <> AValue then begin
    FKeyFields := AValue;
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDBottomUpdateOptions.SetUpdateTableName(const AValue: String);
begin
  if FUpdateTableName <> AValue then begin
    FUpdateTableName := AValue;
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
{ TFDResourceOptions                                                            }
{-------------------------------------------------------------------------------}
procedure TFDResourceOptions.RestoreDefaults;
begin
  inherited RestoreDefaults;
  FAssignedValues := [];
  FParamCreate := True;
  FMacroCreate := True;
  FParamExpand := True;
  FMacroExpand := True;
  FEscapeExpand := True;
  FCmdExecMode := amBlocking;
  FCmdExecTimeout := $FFFFFFFF;
  FDirectExecute := False;
  FDefaultParamType := ptInput;
  FPersistent := False;
  FBackup := False;
  FStoreVersion := -1;
  FStoreItems := [siMeta, siData, siDelta];
  FStorePrettyPrint := False;
  FStoreMergeData := dmNone;
  FStoreMergeMeta := mmNone;
  FArrayDMLSize := $7FFFFFFF;
  FSilentMode := False;
  FUnifyParams := False;
  Inc(FVersion);
end;

{-------------------------------------------------------------------------------}
procedure TFDResourceOptions.Assign(ASource: TPersistent);
begin
  if (ASource = nil) or (ASource = Self) then
    Exit;
  if ASource is TFDResourceOptions then begin
    if rvParamCreate in TFDResourceOptions(ASource).FAssignedValues then
      ParamCreate := TFDResourceOptions(ASource).ParamCreate;
    if rvMacroCreate in TFDResourceOptions(ASource).FAssignedValues then
      MacroCreate := TFDResourceOptions(ASource).MacroCreate;
    if rvParamExpand in TFDResourceOptions(ASource).FAssignedValues then
      ParamExpand := TFDResourceOptions(ASource).ParamExpand;
    if rvMacroExpand in TFDResourceOptions(ASource).FAssignedValues then
      MacroExpand := TFDResourceOptions(ASource).MacroExpand;
    if rvEscapeExpand in TFDResourceOptions(ASource).FAssignedValues then
      EscapeExpand := TFDResourceOptions(ASource).EscapeExpand;
    if rvCmdExecMode in TFDResourceOptions(ASource).FAssignedValues then
      CmdExecMode := TFDResourceOptions(ASource).CmdExecMode;
    if rvCmdExecTimeout in TFDResourceOptions(ASource).FAssignedValues then
      CmdExecTimeout := TFDResourceOptions(ASource).CmdExecTimeout;
    if rvDirectExecute in TFDResourceOptions(ASource).FAssignedValues then
      DirectExecute := TFDResourceOptions(ASource).DirectExecute;
    if rvDefaultParamType in TFDResourceOptions(ASource).FAssignedValues then
      DefaultParamType := TFDResourceOptions(ASource).DefaultParamType;
    if rvPersistent in TFDResourceOptions(ASource).FAssignedValues then
      Persistent := TFDResourceOptions(ASource).Persistent;
    if rvBackup in TFDResourceOptions(ASource).FAssignedValues then
      Backup := TFDResourceOptions(ASource).Backup;
    if rvStoreVersion in TFDResourceOptions(ASource).FAssignedValues then
      StoreVersion := TFDResourceOptions(ASource).StoreVersion;
    if rvStoreItems in TFDResourceOptions(ASource).FAssignedValues then
      StoreItems := TFDResourceOptions(ASource).StoreItems;
    if rvStorePrettyPrint in TFDResourceOptions(ASource).FAssignedValues then
      StorePrettyPrint := TFDResourceOptions(ASource).StorePrettyPrint;
    if rvStoreMergeData in TFDResourceOptions(ASource).FAssignedValues then
      StoreMergeData := TFDResourceOptions(ASource).StoreMergeData;
    if rvStoreMergeMeta in TFDResourceOptions(ASource).FAssignedValues then
      StoreMergeMeta := TFDResourceOptions(ASource).StoreMergeMeta;
    if rvArrayDMLSize in TFDResourceOptions(ASource).FAssignedValues then
      ArrayDMLSize := TFDResourceOptions(ASource).ArrayDMLSize;
    if rvSilentMode in TFDResourceOptions(ASource).FAssignedValues then
      SilentMode := TFDResourceOptions(ASource).SilentMode;
    if rvUnifyParams in TFDResourceOptions(ASource).FAssignedValues then
      UnifyParams := TFDResourceOptions(ASource).UnifyParams;
  end
  else
    inherited Assign(ASource);
end;

{-------------------------------------------------------------------------------}
function TFDResourceOptions.IsValueOwned(AValue: TFDResourceOptionValue;
  var AParentOpts: IFDStanOptions): Boolean;
begin
  Result := not Assigned(Container.FParentCallback) or (AValue in FAssignedValues);
  if not Result then begin
    Container.FParentCallback(AParentOpts);
    Result := (AParentOpts = nil);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDResourceOptions.GetMacroCreate: Boolean;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(rvMacroCreate, oParentOpts) then
    Result := FMacroCreate
  else
    Result := oParentOpts.ResourceOptions.MacroCreate;
end;

{-------------------------------------------------------------------------------}
procedure TFDResourceOptions.SetMacroCreate(const AValue: Boolean);
begin
  if not (rvMacroCreate in FAssignedValues) or (FMacroCreate <> AValue) then begin
    FMacroCreate := AValue;
    Include(FAssignedValues, rvMacroCreate);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDResourceOptions.IsMCS: Boolean;
begin
  Result := rvMacroCreate in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDResourceOptions.GetParamCreate: Boolean;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(rvParamCreate, oParentOpts) then
    Result := FParamCreate
  else
    Result := oParentOpts.ResourceOptions.ParamCreate;
end;

{-------------------------------------------------------------------------------}
procedure TFDResourceOptions.SetParamCreate(const AValue: Boolean);
begin
  if not (rvParamCreate in FAssignedValues) or (FParamCreate <> AValue) then begin
    FParamCreate := AValue;
    Include(FAssignedValues, rvParamCreate);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDResourceOptions.IsPCS: Boolean;
begin
  Result := rvParamCreate in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDResourceOptions.GetParamExpand: Boolean;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(rvParamExpand, oParentOpts) then
    Result := FParamExpand
  else
    Result := oParentOpts.ResourceOptions.ParamExpand;
end;

{-------------------------------------------------------------------------------}
procedure TFDResourceOptions.SetParamExpand(const AValue: Boolean);
begin
  if not (rvParamExpand in FAssignedValues) or (FParamExpand <> AValue) then begin
    FParamExpand := AValue;
    Include(FAssignedValues, rvParamExpand);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDResourceOptions.IsPES: Boolean;
begin
  Result := rvParamExpand in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDResourceOptions.GetMacroExpand: Boolean;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(rvMacroExpand, oParentOpts) then
    Result := FMacroExpand
  else
    Result := oParentOpts.ResourceOptions.MacroExpand;
end;

{-------------------------------------------------------------------------------}
procedure TFDResourceOptions.SetMacroExpand(const AValue: Boolean);
begin
  if not (rvMacroExpand in FAssignedValues) or (FMacroExpand <> AValue) then begin
    FMacroExpand := AValue;
    Include(FAssignedValues, rvMacroExpand);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDResourceOptions.IsMES: Boolean;
begin
  Result := rvMacroExpand in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDResourceOptions.GetEscapeExpand: Boolean;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(rvEscapeExpand, oParentOpts) then
    Result := FEscapeExpand
  else
    Result := oParentOpts.ResourceOptions.EscapeExpand;
end;

{-------------------------------------------------------------------------------}
procedure TFDResourceOptions.SetEscapeExpand(const AValue: Boolean);
begin
  if not (rvEscapeExpand in FAssignedValues) or (FEscapeExpand <> AValue) then begin
    FEscapeExpand := AValue;
    Include(FAssignedValues, rvEscapeExpand);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDResourceOptions.GetPreprocessCmdText: Boolean;
begin
  Result := ParamCreate or MacroCreate or ParamExpand or MacroExpand or EscapeExpand;
end;

{-------------------------------------------------------------------------------}
procedure TFDResourceOptions.SetPreprocessCmdText(const AValue: Boolean);
begin
  ParamCreate := AValue;
  MacroCreate := AValue;
  ParamExpand := AValue;
  MacroExpand := AValue;
  EscapeExpand := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDResourceOptions.IsEPS: Boolean;
begin
  Result := rvEscapeExpand in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDResourceOptions.GetCmdExecMode: TFDStanAsyncMode;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(rvCmdExecMode, oParentOpts) then
    Result := FCmdExecMode
  else
    Result := oParentOpts.ResourceOptions.CmdExecMode;
end;

{-------------------------------------------------------------------------------}
procedure TFDResourceOptions.SetCmdExecMode(const AValue: TFDStanAsyncMode);
begin
  if not (rvCmdExecMode in FAssignedValues) or (FCmdExecMode <> AValue) then begin
    FCmdExecMode := AValue;
    Include(FAssignedValues, rvCmdExecMode);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDResourceOptions.IsCEMS: Boolean;
begin
  Result := rvCmdExecMode in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDResourceOptions.GetCmdExecTimeout: Cardinal;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(rvCmdExecTimeout, oParentOpts) then
    Result := FCmdExecTimeout
  else
    Result := oParentOpts.ResourceOptions.CmdExecTimeout;
end;

{-------------------------------------------------------------------------------}
procedure TFDResourceOptions.SetCmdExecTimeout(const AValue: Cardinal);
begin
  if not (rvCmdExecTimeout in FAssignedValues) or (FCmdExecTimeout <> AValue) then begin
    FCmdExecTimeout := AValue;
    Include(FAssignedValues, rvCmdExecTimeout);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDResourceOptions.IsCETS: Boolean;
begin
  Result := rvCmdExecTimeout in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDResourceOptions.GetDirectExecute: Boolean;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(rvDirectExecute, oParentOpts) then
    Result := FDirectExecute
  else
    Result := oParentOpts.ResourceOptions.DirectExecute;
end;

{-------------------------------------------------------------------------------}
procedure TFDResourceOptions.SetDirectExecute(const AValue: Boolean);
begin
  if not (rvDirectExecute in FAssignedValues) or (FDirectExecute <> AValue) then begin
    FDirectExecute := AValue;
    Include(FAssignedValues, rvDirectExecute);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDResourceOptions.IsDES: Boolean;
begin
  Result := rvDirectExecute in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDResourceOptions.GetDefaultParamType: TParamType;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(rvDefaultParamType, oParentOpts) then
    Result := FDefaultParamType
  else
    Result := oParentOpts.ResourceOptions.DefaultParamType;
end;

{-------------------------------------------------------------------------------}
procedure TFDResourceOptions.SetDefaultParamType(const AValue: TParamType);
begin
  if not (rvDefaultParamType in FAssignedValues) or (FDefaultParamType <> AValue) then begin
    FDefaultParamType := AValue;
    Include(FAssignedValues, rvDefaultParamType);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDResourceOptions.IsDPTS: Boolean;
begin
  Result := rvDefaultParamType in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDResourceOptions.GetBackup: Boolean;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(rvBackup, oParentOpts) then
    Result := FBackup
  else
    Result := oParentOpts.ResourceOptions.Backup;
end;

{-------------------------------------------------------------------------------}
procedure TFDResourceOptions.SetBackup(const AValue: Boolean);
begin
  if not (rvBackup in FAssignedValues) or (FBackup <> AValue) then begin
    FBackup := AValue;
    Include(FAssignedValues, rvBackup);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDResourceOptions.IsBS: Boolean;
begin
  Result := rvBackup in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDResourceOptions.GetPersistent: Boolean;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(rvPersistent, oParentOpts) then
    Result := FPersistent
  else
    Result := oParentOpts.ResourceOptions.Persistent;
end;

{-------------------------------------------------------------------------------}
procedure TFDResourceOptions.SetPersistent(const AValue: Boolean);
begin
  if not (rvPersistent in FAssignedValues) or (FPersistent <> AValue) then begin
    FPersistent := AValue;
    Include(FAssignedValues, rvPersistent);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDResourceOptions.IsPS: Boolean;
begin
  Result := rvPersistent in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDResourceOptions.GetBackupExt: String;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(rvBackupExt, oParentOpts) then
    if Self is TFDTopResourceOptions then
      Result := TFDTopResourceOptions(Self).FBackupExt
    else
      Result := '.BAK'
  else
    Result := oParentOpts.ResourceOptions.BackupExt;
end;

{-------------------------------------------------------------------------------}
function TFDResourceOptions.GetBackupFolder: String;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(rvBackupFolder, oParentOpts) then
    if Self is TFDTopResourceOptions then
      Result := TFDTopResourceOptions(Self).FBackupFolder
    else
      Result := ''
  else
    Result := oParentOpts.ResourceOptions.BackupFolder;
end;

{-------------------------------------------------------------------------------}
function TFDResourceOptions.GetDefaultStoreExt: String;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(rvDefaultStoreExt, oParentOpts) then
    if Self is TFDTopResourceOptions then
      Result := TFDTopResourceOptions(Self).FDefaultStoreExt
    else
      Result := ''
  else
    Result := oParentOpts.ResourceOptions.DefaultStoreExt;
end;

{-------------------------------------------------------------------------------}
function TFDResourceOptions.GetDefaultStoreFolder: String;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(rvDefaultStoreFolder, oParentOpts) then
    if Self is TFDTopResourceOptions then
      Result := TFDTopResourceOptions(Self).FDefaultStoreFolder
    else
      Result := ''
  else
    Result := oParentOpts.ResourceOptions.DefaultStoreFolder;
end;

{-------------------------------------------------------------------------------}
function TFDResourceOptions.GetDefaultStoreFormat: TFDStorageFormat;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(rvDefaultStoreFormat, oParentOpts) then
    if Self is TFDTopResourceOptions then
      Result := TFDTopResourceOptions(Self).FDefaultStoreFormat
    else
      Result := sfAuto
  else
    Result := oParentOpts.ResourceOptions.DefaultStoreFormat;
end;

{-------------------------------------------------------------------------------}
function TFDResourceOptions.GetStoreVersion: Integer;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(rvStoreVersion, oParentOpts) then
    Result := FStoreVersion
  else
    Result := oParentOpts.ResourceOptions.StoreVersion;
end;

{-------------------------------------------------------------------------------}
procedure TFDResourceOptions.SetStoreVersion(const AValue: Integer);
begin
  if not (rvStoreVersion in FAssignedValues) or (FStoreVersion <> AValue) then begin
    FStoreVersion := AValue;
    Include(FAssignedValues, rvStoreVersion);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDResourceOptions.IsSTV: Boolean;
begin
  Result := rvStoreVersion in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDResourceOptions.GetStoreItems: TFDStoreItems;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(rvStoreItems, oParentOpts) then
    Result := FStoreItems
  else
    Result := oParentOpts.ResourceOptions.StoreItems;
end;

{-------------------------------------------------------------------------------}
procedure TFDResourceOptions.SetStoreItems(const AValue: TFDStoreItems);
begin
  if not (rvStoreItems in FAssignedValues) or (FStoreItems <> AValue) then begin
    FStoreItems := AValue;
    Include(FAssignedValues, rvStoreItems);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDResourceOptions.IsSIS: Boolean;
begin
  Result := rvStoreItems in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDResourceOptions.GetStorePrettyPrint: Boolean;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(rvStorePrettyPrint, oParentOpts) then
    Result := FStorePrettyPrint
  else
    Result := oParentOpts.ResourceOptions.StorePrettyPrint;
end;

{-------------------------------------------------------------------------------}
procedure TFDResourceOptions.SetStorePrettyPrint(const AValue: Boolean);
begin
  if not (rvStorePrettyPrint in FAssignedValues) or (FStorePrettyPrint <> AValue) then begin
    FStorePrettyPrint := AValue;
    Include(FAssignedValues, rvStorePrettyPrint);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDResourceOptions.IsSPPS: Boolean;
begin
  Result := rvStorePrettyPrint in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDResourceOptions.GetStoreMergeData: TFDMergeDataMode;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(rvStoreMergeData, oParentOpts) then
    Result := FStoreMergeData
  else
    Result := oParentOpts.ResourceOptions.StoreMergeData;
end;

{-------------------------------------------------------------------------------}
procedure TFDResourceOptions.SetStoreMergeData(const AValue: TFDMergeDataMode);
begin
  if not (rvStoreMergeData in FAssignedValues) or (FStoreMergeData <> AValue) then begin
    FStoreMergeData := AValue;
    Include(FAssignedValues, rvStoreMergeData);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDResourceOptions.IsSMOS: Boolean;
begin
  Result := rvStoreMergeData in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDResourceOptions.GetStoreMergeMeta: TFDMergeMetaMode;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(rvStoreMergeMeta, oParentOpts) then
    Result := FStoreMergeMeta
  else
    Result := oParentOpts.ResourceOptions.StoreMergeMeta;
end;

{-------------------------------------------------------------------------------}
procedure TFDResourceOptions.SetStoreMergeMeta(const AValue: TFDMergeMetaMode);
begin
  if not (rvStoreMergeMeta in FAssignedValues) or (FStoreMergeMeta <> AValue) then begin
    FStoreMergeMeta := AValue;
    Include(FAssignedValues, rvStoreMergeMeta);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDResourceOptions.IsSMMS: Boolean;
begin
  Result := rvStoreMergeMeta in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDResourceOptions.GetStoreMerge: Boolean;
begin
  Result := (StoreMergeData <> dmNone) or (StoreMergeMeta <> mmNone);
end;

{-------------------------------------------------------------------------------}
function TFDResourceOptions.GetArrayDMLSize: Integer;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(rvArrayDMLSize, oParentOpts) then
    Result := FArrayDMLSize
  else
    Result := oParentOpts.ResourceOptions.ArrayDMLSize;
end;

{-------------------------------------------------------------------------------}
procedure TFDResourceOptions.SetArrayDMLSize(const AValue: Integer);
begin
  if not (rvArrayDMLSize in FAssignedValues) or (FArrayDMLSize <> AValue) then begin
    FArrayDMLSize := AValue;
    Include(FAssignedValues, rvArrayDMLSize);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDResourceOptions.IsADSS: Boolean;
begin
  Result := rvArrayDMLSize in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDResourceOptions.GetSilentMode: Boolean;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(rvSilentMode, oParentOpts) then
    Result := FSilentMode
  else
    Result := oParentOpts.ResourceOptions.SilentMode;
end;

{-------------------------------------------------------------------------------}
procedure TFDResourceOptions.SetSilentMode(const AValue: Boolean);
begin
  if not (rvSilentMode in FAssignedValues) or (FSilentMode <> AValue) then begin
    FSilentMode := AValue;
    Include(FAssignedValues, rvSilentMode);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDResourceOptions.IsSMS: Boolean;
begin
  Result := rvSilentMode in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDResourceOptions.GetActualSilentMode: Boolean;
begin
  Result := SilentMode or FDGUIxSilent;
end;

{-------------------------------------------------------------------------------}
function TFDResourceOptions.GetUnifyParams: Boolean;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(rvUnifyParams, oParentOpts) then
    Result := FUnifyParams
  else
    Result := oParentOpts.ResourceOptions.UnifyParams;
end;

{-------------------------------------------------------------------------------}
procedure TFDResourceOptions.SetUnifyParams(const AValue: Boolean);
begin
  if not (rvUnifyParams in FAssignedValues) or (FUnifyParams <> AValue) then begin
    FUnifyParams := AValue;
    Include(FAssignedValues, rvUnifyParams);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDResourceOptions.IsUPS: Boolean;
begin
  Result := rvUnifyParams in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
{ TFDTopResourceOptions                                                         }
{-------------------------------------------------------------------------------}
procedure TFDTopResourceOptions.RestoreDefaults;
begin
  inherited RestoreDefaults;
  FMaxCursors := -1;
  FServerOutput := False;
  FServerOutputSize := 20000;
  FDefaultStoreFolder := '';
  FBackupFolder := '';
  FDefaultStoreExt := '';
  FDefaultStoreFormat := sfAuto;
  FBackupExt := '.BAK';
  FAutoConnect := True;
  FAutoReconnect := False;
  FKeepConnection := True;
end;

{-------------------------------------------------------------------------------}
procedure TFDTopResourceOptions.Assign(ASource: TPersistent);
begin
  if (ASource = nil) or (ASource = Self) then
    Exit;
  inherited Assign(ASource);
  if ASource is TFDTopResourceOptions then begin
    if rvMaxCursors in TFDTopResourceOptions(ASource).FAssignedValues then
      MaxCursors := TFDTopResourceOptions(ASource).MaxCursors;
    if rvServerOutput in TFDTopResourceOptions(ASource).FAssignedValues then
      ServerOutput := TFDTopResourceOptions(ASource).ServerOutput;
    if rvServerOutputSize in TFDTopResourceOptions(ASource).FAssignedValues then
      ServerOutputSize := TFDTopResourceOptions(ASource).ServerOutputSize;
    if rvDefaultStoreFolder in TFDTopResourceOptions(ASource).FAssignedValues then
      DefaultStoreFolder := TFDTopResourceOptions(ASource).DefaultStoreFolder;
    if rvBackupFolder in TFDTopResourceOptions(ASource).FAssignedValues then
      BackupFolder := TFDTopResourceOptions(ASource).BackupFolder;
    if rvDefaultStoreExt in TFDTopResourceOptions(ASource).FAssignedValues then
      DefaultStoreExt := TFDTopResourceOptions(ASource).DefaultStoreExt;
    if rvDefaultStoreFormat in TFDTopResourceOptions(ASource).FAssignedValues then
      DefaultStoreFormat := TFDTopResourceOptions(ASource).DefaultStoreFormat;
    if rvBackupExt in TFDTopResourceOptions(ASource).FAssignedValues then
      BackupExt := TFDTopResourceOptions(ASource).BackupExt;
    if rvAutoConnect in TFDTopResourceOptions(ASource).FAssignedValues then
      AutoConnect := TFDTopResourceOptions(ASource).AutoConnect;
    if rvAutoReconnect in TFDTopResourceOptions(ASource).FAssignedValues then
      AutoReconnect := TFDTopResourceOptions(ASource).AutoReconnect;
    if rvKeepConnection in TFDTopResourceOptions(ASource).FAssignedValues then
      KeepConnection := TFDTopResourceOptions(ASource).KeepConnection;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDTopResourceOptions.GetMaxCursors: Integer;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(rvMaxCursors, oParentOpts) then
    Result := FMaxCursors
  else
    Result := (oParentOpts.ResourceOptions as TFDTopResourceOptions).MaxCursors;
end;

{-------------------------------------------------------------------------------}
procedure TFDTopResourceOptions.SetMaxCursors(const AValue: Integer);
begin
  if not (rvMaxCursors in FAssignedValues) or (FMaxCursors <> AValue) then begin
    FMaxCursors := AValue;
    Include(FAssignedValues, rvMaxCursors);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDTopResourceOptions.IsMCS: Boolean;
begin
  Result := rvMaxCursors in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDTopResourceOptions.GetServerOutput: Boolean;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(rvServerOutput, oParentOpts) then
    Result := FServerOutput
  else
    Result := (oParentOpts.ResourceOptions as TFDTopResourceOptions).ServerOutput;
end;

{-------------------------------------------------------------------------------}
procedure TFDTopResourceOptions.SetServerOutput(const AValue: Boolean);
begin
  if not (rvServerOutput in FAssignedValues) or (FServerOutput <> AValue) then begin
    FServerOutput := AValue;
    Include(FAssignedValues, rvServerOutput);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDTopResourceOptions.IsSOS: Boolean;
begin
  Result := rvServerOutput in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDTopResourceOptions.GetServerOutputSize: Integer;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(rvServerOutputSize, oParentOpts) then
    Result := FServerOutputSize
  else
    Result := (oParentOpts.ResourceOptions as TFDTopResourceOptions).ServerOutputSize;
end;

{-------------------------------------------------------------------------------}
procedure TFDTopResourceOptions.SetServerOutputSize(const AValue: Integer);
begin
  if not (rvServerOutputSize in FAssignedValues) or (FServerOutputSize <> AValue) then begin
    FServerOutputSize := AValue;
    Include(FAssignedValues, rvServerOutputSize);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDTopResourceOptions.IsSOSS: Boolean;
begin
  Result := rvServerOutputSize in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
procedure TFDTopResourceOptions.SetBackupExt(const AValue: String);
begin
  if not (rvBackupExt in FAssignedValues) or (FBackupExt <> AValue) then begin
    FBackupExt := AValue;
    Include(FAssignedValues, rvBackupExt);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDTopResourceOptions.IsBES: Boolean;
begin
  Result := rvBackupExt in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
procedure TFDTopResourceOptions.SetBackupFolder(const AValue: String);
begin
  if not (rvBackupFolder in FAssignedValues) or (FBackupFolder <> AValue) then begin
    FBackupFolder := AValue;
    Include(FAssignedValues, rvBackupFolder);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDTopResourceOptions.IsBFS: Boolean;
begin
  Result := rvBackupFolder in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
procedure TFDTopResourceOptions.SetDefaultStoreExt(const AValue: String);
begin
  if not (rvDefaultStoreExt in FAssignedValues) or (FDefaultStoreExt <> AValue) then begin
    FDefaultStoreExt := AValue;
    Include(FAssignedValues, rvDefaultStoreExt);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDTopResourceOptions.IsDSES: Boolean;
begin
  Result := rvDefaultStoreExt in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
procedure TFDTopResourceOptions.SetDefaultStoreFolder(const AValue: String);
begin
  if not (rvDefaultStoreFolder in FAssignedValues) or (FDefaultStoreFolder <> AValue) then begin
    FDefaultStoreFolder := AValue;
    Include(FAssignedValues, rvDefaultStoreFolder);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDTopResourceOptions.IsDSFS: Boolean;
begin
  Result := rvDefaultStoreFolder in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
procedure TFDTopResourceOptions.SetDefaultStoreFormat(
  const AValue: TFDStorageFormat);
begin
  if not (rvDefaultStoreFormat in FAssignedValues) or (FDefaultStoreFormat <> AValue) then begin
    FDefaultStoreFormat := AValue;
    Include(FAssignedValues, rvDefaultStoreFormat);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDTopResourceOptions.IsDSTS: Boolean;
begin
  Result := rvDefaultStoreFormat in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDTopResourceOptions.GetAutoConnect: Boolean;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(rvAutoConnect, oParentOpts) then
    Result := FAutoConnect
  else
    Result := (oParentOpts.ResourceOptions as TFDTopResourceOptions).AutoConnect;
end;

{-------------------------------------------------------------------------------}
procedure TFDTopResourceOptions.SetAutoConnect(const AValue: Boolean);
begin
  if not (rvAutoConnect in FAssignedValues) or (FAutoConnect <> AValue) then begin
    FAutoConnect := AValue;
    Include(FAssignedValues, rvAutoConnect);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDTopResourceOptions.IsACS: Boolean;
begin
  Result := rvAutoConnect in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDTopResourceOptions.GetAutoReconnect: Boolean;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(rvAutoReconnect, oParentOpts) then
    Result := FAutoReconnect
  else
    Result := (oParentOpts.ResourceOptions as TFDTopResourceOptions).AutoReconnect;
end;

{-------------------------------------------------------------------------------}
procedure TFDTopResourceOptions.SetAutoReconnect(const AValue: Boolean);
begin
  if not (rvAutoReconnect in FAssignedValues) or (FAutoReconnect <> AValue) then begin
    FAutoReconnect := AValue;
    Include(FAssignedValues, rvAutoReconnect);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDTopResourceOptions.IsARS: Boolean;
begin
  Result := rvAutoReconnect in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
function TFDTopResourceOptions.GetKeepConnection: Boolean;
var
  oParentOpts: IFDStanOptions;
begin
  if IsValueOwned(rvKeepConnection, oParentOpts) then
    Result := FKeepConnection
  else
    Result := (oParentOpts.ResourceOptions as TFDTopResourceOptions).KeepConnection;
end;

{-------------------------------------------------------------------------------}
procedure TFDTopResourceOptions.SetKeepConnection(const AValue: Boolean);
begin
  if not (rvKeepConnection in FAssignedValues) or (FKeepConnection <> AValue) then begin
    FKeepConnection := AValue;
    Include(FAssignedValues, rvKeepConnection);
    Inc(FVersion);
  end;
end;

{-------------------------------------------------------------------------------}
function TFDTopResourceOptions.IsKCS: Boolean;
begin
  Result := rvKeepConnection in FAssignedValues;
end;

{-------------------------------------------------------------------------------}
{ TFDBottomResourceOptions                                                      }
{-------------------------------------------------------------------------------}
procedure TFDBottomResourceOptions.Assign(ASource: TPersistent);
begin
  inherited Assign(ASource);
  if ASource is TFDBottomResourceOptions then
    PersistentFileName := TFDBottomResourceOptions(ASource).PersistentFileName;
end;

{-------------------------------------------------------------------------------}
procedure TFDBottomResourceOptions.RestoreDefaults;
begin
  inherited RestoreDefaults;
  FPersistentFileName := '';
end;

{-------------------------------------------------------------------------------}
function TFDBottomResourceOptions.ResolveFileName(const AFileName: String = ''): String;
begin
  Result := FDExpandStr(AFileName);
  if Result = '' then
    Result := FDExpandStr(PersistentFileName);
  if Result <> '' then begin
    if ExtractFileExt(Result) = '' then
      if DefaultStoreExt = '' then
        case DefaultStoreFormat of
        sfXML:    Result := ChangeFileExt(Result, '.XML');
        sfJSON:   Result := ChangeFileExt(Result, '.JSON');
        sfAuto,
        sfBinary: Result := ChangeFileExt(Result, '.FDS');
        end
      else
        Result := ChangeFileExt(Result, DefaultStoreExt);
    if ExtractFilePath(Result) = '' then
      Result := FDNormPath(FDExpandStr(DefaultStoreFolder)) + Result;
  end;
end;

{-------------------------------------------------------------------------------}
function TFDBottomResourceOptions.GetStorage(const AFileName: String;
  AFormat: TFDStorageFormat): IFDStanStorage;
const
  C_Formats: array [TFDStorageFormat] of String = ('BIN', 'XML', 'BIN', 'JSON');
var
  sExt, sMsg: String;
begin
  sExt := '';
  sMsg := '';
  if AFormat = sfAuto then begin
    sExt := ExtractFileExt(AFileName);
    if sExt = '' then
      sExt := DefaultStoreExt;
    if sExt <> '' then begin
      sMsg := sExt;
      FDCreateInterface(IFDStanStorage, Result, False, sExt);
    end;
  end;
  if Result = nil then begin
    if AFormat = sfAuto then
      AFormat := DefaultStoreFormat;
    if sMsg = '' then
      sMsg := C_Formats[AFormat];
    FDCreateInterface(IFDStanStorage, Result, False, C_Formats[AFormat]);
  end;
  if Result = nil then
    FDException(Self, [S_FD_LStan], er_FD_StanStrgUnknownFmt, [sMsg]);
end;

{-------------------------------------------------------------------------------}
{ TFDTxOptions                                                                  }
{-------------------------------------------------------------------------------}
constructor TFDTxOptions.Create;
begin
  inherited Create;
  FIsolation := xiReadCommitted;
  FParams := TFDStringList.Create;
  TFDStringList(FParams).OnChange := DoParamsChanged;
  FAutoStart := True;
  FAutoStop := True;
  FStopOptions := [xoIfAutoStarted, xoIfCmdsInactive];
  FDisconnectAction := xdCommit;
  FEnableNested := True;
  ClearChanged;
end;

{-------------------------------------------------------------------------------}
destructor TFDTxOptions.Destroy;
begin
  FDFreeAndNil(FParams);
  inherited Destroy;
end;

{-------------------------------------------------------------------------------}
procedure TFDTxOptions.Assign(ASource: TPersistent);
begin
  if (ASource = nil) or (ASource = Self) then
    Exit;
  if ASource is TFDTxOptions then begin
    StopOptions := TFDTxOptions(ASource).StopOptions;
    Isolation := TFDTxOptions(ASource).Isolation;
    ReadOnly := TFDTxOptions(ASource).ReadOnly;
    if not Params.Equals(TFDTxOptions(ASource).Params) then
      Params.SetStrings(TFDTxOptions(ASource).Params);
    AutoStart := TFDTxOptions(ASource).AutoStart;
    AutoStop := TFDTxOptions(ASource).AutoStop;
    DisconnectAction := TFDTxOptions(ASource).DisconnectAction;
    EnableNested := TFDTxOptions(ASource).EnableNested;
  end
  else
    inherited Assign(ASource);
end;

{-------------------------------------------------------------------------------}
procedure TFDTxOptions.ClearChanged;
begin
  FChanged := [];
end;

{-------------------------------------------------------------------------------}
procedure TFDTxOptions.ResetChanged;
begin
  FChanged := [];
  if Isolation <> xiReadCommitted then
    Include(FChanged, xoIsolation);
  if ReadOnly then
    Include(FChanged, xoReadOnly);
  if Params.Count > 0 then
    Include(FChanged, xoParams);
  if not AutoCommit then
    Include(FChanged, xoAutoCommit);
end;

{-------------------------------------------------------------------------------}
procedure TFDTxOptions.SetIsolation(const AValue: TFDTxIsolation);
begin
  if FIsolation <> AValue then begin
    FIsolation := AValue;
    Include(FChanged, xoIsolation);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDTxOptions.SetReadOnly(const AValue: Boolean);
begin
  if FReadOnly <> AValue then begin
    FReadOnly := AValue;
    Include(FChanged, xoReadOnly);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDTxOptions.DoParamsChanged(ASender: TObject);
begin
  Include(FChanged, xoParams);
end;

{-------------------------------------------------------------------------------}
procedure TFDTxOptions.SetParams(const AValue: TStrings);
begin
  FParams.SetStrings(AValue);
end;

{-------------------------------------------------------------------------------}
procedure TFDTxOptions.SetAutoStart(const AValue: Boolean);
begin
  if FAutoStart <> AValue then begin
    FAutoStart := AValue;
    Include(FChanged, xoAutoStart);
    Include(FChanged, xoAutoCommit);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDTxOptions.SetAutoStop(const AValue: Boolean);
begin
  if FAutoStop <> AValue then begin
    FAutoStop := AValue;
    Include(FChanged, xoAutoStop);
    Include(FChanged, xoAutoCommit);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDTxOptions.SetStopOptions(const AValue: TFDTxStopOptions);
begin
  if FStopOptions <> AValue then begin
    FStopOptions := AValue;
    Include(FChanged, xoStopOptions);
    Include(FChanged, xoAutoCommit);
  end;
end;

{-------------------------------------------------------------------------------}
procedure TFDTxOptions.SetAutoCommit(const AValue: Boolean);
begin
  if AValue then begin
    AutoStart := True;
    AutoStop := True;
    StopOptions := StopOptions + [xoIfAutoStarted, xoIfCmdsInactive];
  end
  else
    AutoStop := False;
end;

{-------------------------------------------------------------------------------}
function TFDTxOptions.GetAutoCommit: Boolean;
begin
  Result := AutoStart and AutoStop and (xoIfAutoStarted in StopOptions) and
    (xoIfCmdsInactive in StopOptions);
end;

{-------------------------------------------------------------------------------}
{ TFDEventAlerterOptions                                                        }
{-------------------------------------------------------------------------------}
constructor TFDEventAlerterOptions.Create;
begin
  inherited Create;
  FTimeout := -1;
  FSynchronize := True;
  FMergeData := dmDataMerge;
  FAutoRefresh := afAlert;
end;

{-------------------------------------------------------------------------------}
procedure TFDEventAlerterOptions.Assign(ASource: TPersistent);
begin
  if ASource is TFDEventAlerterOptions then begin
    Kind := TFDEventAlerterOptions(ASource).Kind;
    Timeout := TFDEventAlerterOptions(ASource).Timeout;
    Synchronize := TFDEventAlerterOptions(ASource).Synchronize;
    AutoRegister := TFDEventAlerterOptions(ASource).AutoRegister;
    MergeData := TFDEventAlerterOptions(ASource).MergeData;
    AutoRefresh := TFDEventAlerterOptions(ASource).AutoRefresh;
  end
  else
    inherited Assign(ASource);
end;

{-------------------------------------------------------------------------------}
initialization

  C_FD_MaxLenTimeStampStr := Length(DateTimeToStr(SQLTimeStampToDateTime(RLongDate)));
  C_FD_MaxLenTimeIntStr := Length(FDSQLTimeInterval2Str(RLongInt));

end.
