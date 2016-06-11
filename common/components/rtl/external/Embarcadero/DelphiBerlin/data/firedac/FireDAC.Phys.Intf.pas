{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{              FireDAC physical layer API               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.Phys.Intf;

interface

uses
  System.Classes, System.SysUtils,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.Stan.Consts,
  FireDAC.DatS,
  FireDAC.UI.Intf;

type
  IFDPhysManagerMetadata = interface;
  IFDPhysManager = interface;
  IFDPhysDriverMetadata = interface;
  IFDPhysDriverConnectionWizard = interface;
  IFDPhysDriver = interface;
  IFDPhysConnectionMetadata = interface;
  IFDPhysConnectionRecoveryHandler = interface;
  IFDPhysConnection = interface;
  IFDPhysTransactionStateHandler = interface;
  IFDPhysTransaction = interface;
  IFDPhysCommandStateHandler = interface;
  IFDPhysCommandGenerator = interface;
  IFDPhysMappingHandler = interface;
  IFDPhysCommand = interface;
  IFDPhysMetaInfoCommand = interface;
  IFDPhysEventHandler = interface;
  IFDPhysChangeHandler = interface;
  IFDPhysEventAlerter = interface;
  IFDPhysLocalSQLAdapter = interface;
  IFDPhysSQLHandler = interface;
  IFDPhysDataSetParamReader = interface;

  TFDPhysCommandKind = (skUnknown, skSelect, skSelectForLock, skSelectForUnLock,
    skDelete, skInsert, skMerge, skUpdate, skCreate, skAlter, skDrop, skStoredProc,
    skStoredProcWithCrs, skStoredProcNoCrs, skExecute, skStartTransaction,
    skCommit, skRollback, skSet, skSetSchema, skOther, skNotResolved);

  TFDPhysEscapeKind = (eskText, eskString, eskFloat, eskDate, eskTime, eskDateTime,
    eskIdentifier, eskBoolean, eskFunction, eskIF, eskFI, eskElse, eskIIF, eskEscape,
    eskInto);
  TFDPhysEscapeFunction = (efASCII, efLTRIM, efREPLACE, efRTRIM, efABS,
    efCOS, efEXP, efFLOOR, efMOD, efPOWER, efROUND, efSIGN, efSIN, efSQRT, efTAN,
    efDECODE, efBIT_LENGTH, efCHAR, efCHAR_LENGTH, efCONCAT, efINSERT,
    efLCASE, efLEFT, efLENGTH, efLOCATE, efOCTET_LENGTH, efPOSITION, efREPEAT, efRIGHT,
    efSPACE, efSUBSTRING, efUCASE, efACOS, efASIN, efATAN, efATAN2, efCOT, efCEILING,
    efDEGREES, efLOG, efLOG10, efPI, efRADIANS, efRANDOM, efTRUNCATE, efCURDATE,
    efCURTIME, efNOW, efDAYNAME, efDAYOFMONTH, efDAYOFWEEK, efDAYOFYEAR, efEXTRACT,
    efHOUR, efMINUTE, efMONTH, efMONTHNAME, efQUARTER, efSECOND, efTIMESTAMPADD,
    efTIMESTAMPDIFF, efWEEK, efYEAR, efCATALOG, efSCHEMA, efIFNULL, efIF, efCONVERT,
    efLIMIT, efNONE);
  TFDPhysEscapeData = record
    FKind: TFDPhysEscapeKind;
    FFunc: TFDPhysEscapeFunction;
    FName: String;
    FArgs: array of String;
  end;

  TFDPhysNamePart = (npCatalog, npSchema, npDBLink, npBaseObject, npObject);
  TFDPhysNameParts = set of TFDPhysNamePart;
  TFDPhysParsedName = record
    FCatalog,
    FSchema,
    FBaseObject,
    FObject,
    FLink: String;
  end;

  TFDPhysNameQuoteLevel = (ncDefault, ncSecond, ncThird);
  TFDPhysNameQuoteLevels = set of TFDPhysNameQuoteLevel;
  TFDPhysNameQuoteSide = (nsLeft, nsRight);

  TFDPhysDecodeOption = (doUnquote, doNormalize, doSubObj,
    doNotRaise, doMetaParams);
  TFDPhysDecodeOptions = set of TFDPhysDecodeOption;
  TFDPhysEncodeOption = (eoQuote, eoNormalize, eoBeautify);
  TFDPhysEncodeOptions = set of TFDPhysEncodeOption;

  TFDPhysParamMark = (prQMark, prName, prNumber, prDollar, prQNumber);
  TFDPhysDefaultValues = (dvNone, dvDefVals, dvDef);
  TFDPhysLimitOptions = set of (loSkip, loRows);
  TFDPhysSelectOptions = set of (soWithoutFrom, soInlineView);
  TFDPhysMergeAction = (maInsertUpdate, maInsertIgnore);

  TFDPhysNullLocation = (nlAscFirst, nlAscLast, nlDescFirst, nlDescLast);
  TFDPhysNullLocations = set of TFDPhysNullLocation;

  TFDPhysConnectionState = (csDisconnecting, csDisconnected,
    csConnecting, csConnected, csRecovering);

  TFDPhysFillRowOption = (foBlobs, foDetails, foData,
    foAfterIns, foAfterUpd, foUpdatable, foClear, foUnkRec,
    foNoIdentity);
  TFDPhysFillRowOptions = set of TFDPhysFillRowOption;
  TFDPhysCommandGeneratorOptions = set of (goForceQuoteTab, goForceNoQuoteTab,
    goForceQuoteCol, goForceNoQuoteCol, goBeautify, goNoVersion, goSkipUnsupTypes);

  TFDPhysMetaInfoKind = (
    mkNone,
    mkCatalogs, mkSchemas,
    mkTables, mkTableFields,
    mkIndexes, mkIndexFields,
    mkPrimaryKey, mkPrimaryKeyFields,
    mkForeignKeys, mkForeignKeyFields,
    mkPackages, mkProcs, mkProcArgs,
    mkGenerators,
    mkResultSetFields,
    mkTableTypeFields);
  TFDPhysObjectScope = (osMy, osOther, osSystem);
  TFDPhysObjectScopes = set of TFDPhysObjectScope;
  TFDPhysTableKind = (tkSynonym, tkTable, tkView, tkTempTable, tkLocalTable);
  TFDPhysTableKinds = set of TFDPhysTableKind;
  TFDPhysProcedureKind = (pkProcedure, pkFunction);
  TFDPhysIndexKind = (ikNonUnique, ikUnique, ikPrimaryKey);
  TFDPhysCascadeRuleKind = (ckNone, ckCascade, ckRestrict, ckSetNull, ckSetDefault);

  TFDPhysManagerState = (dmsInactive, dmsActive, dmsStoping, dmsTerminating);
  TFDPhysDriverState = (drsUnknown, drsRegistered, drsLoading, drsLoaded,
    drsActive, drsStoping);
  TFDPhysCommandState = (csInactive, csPrepared, csExecuting, csOpen,
    csFetching, csAborting);
  TFDPhysCommandStates = set of TFDPhysCommandState;
  TFDPhysMetaInfoMergeMode = (mmReset, mmOverride, mmRely);
  TFDPhysMissingMetaInfoAction = (maAdd, maIgore, maError);
  TFDPhysCreateTableOptions = set of (ctDefaultFirst, ctNoAlterTableConstraint);
  TFDPhysCreateTableParts = set of (tpTable, tpGenerators, tpTriggers, tpPrimaryKey,
    tpIndexes);

  TFDPhysConnectionRecoverAction = (faDefault, faFail, faRetry, faCloseAbort,
    faOfflineAbort);
  TFDPhysArrayExecMode = (aeNotSupported, aeOnErrorUndoAll, aeUpToFirstError,
    aeCollectAllErrors);

  TFDPhysInsertHBlobMode = (hmInInsert, hmUpdateAfterInsert, hmSetAfterReturning);

  TFDPhysTableCommand = (tcUnknown, tcPageUp, tcPageDown, tcBof, tcEof, tcLocate,
    tcFindKey, tcFindNearest, tcSetRecNo, tcGetRowCount, tcCurrentRecord, tcGetRecNo);

  TFDPhysTableParams = record
    FTableCommand: TFDPhysTableCommand;
    FLastTableCommand: TFDPhysTableCommand;
    FCatalog: String;
    FSchema: String;
    FTable: String;
    FSelectFields: String;
    FPrimaryKeyFields: String;
    FIndexFields: String;
    FDescFields: String;
    FNoCaseFields: String;
    FIndexExpression: String;
    FMasterFields: String;
    FMasterNullFields: String;
    FFilter: String;
    FFilterNoCase: Boolean;
    FFilterPartial: Boolean;
    FRanged: Boolean;
    FRangeStartRow: TFDDatSRow;
    FRangeStartFieldCount: Integer;
    FRangeStartExclusive: Boolean;
    FRangeEndRow: TFDDatSRow;
    FRangeEndFieldCount: Integer;
    FRangeEndExclusive: Boolean;
    FExclusive: Boolean;
    FFiltered: Boolean;
    FReadOnly: Boolean;
    FLocateFields: String;
    FLocateExpression: String;
    FLocateIgnoreCase: Boolean;
    FLocatePartial: Boolean;
    FLocateBackward: Boolean;
    FLocateFromCurrent: Boolean;
    FLocateRow: TFDDatSRow;
    FKeyFieldCount: Integer;
    FRecordCount: Integer;
    FRecordNumber: Integer;
    FNullLocation: TFDPhysNullLocations;
    FCustomWhere: String;
  end;

  IFDPhysManagerMetadata = interface (IUnknown)
    ['{3E9B315B-F456-4175-A864-B2573C4A2100}']
    // private
    function GetDriverCount: Integer;
    function GetDriverID(AIndex: Integer): String;
    function GetBaseDriverID(AIndex: Integer): String; overload;
    // public
    // Drivers
    procedure CreateDriverMetadata(const ADriverID: String; out ADrvMeta: IFDPhysDriverMetadata);
    property DriverCount: Integer read GetDriverCount;
    property DriverID[AIndex: Integer]: String read GetDriverID;
    property BaseDriverID[AIndex: Integer]: String read GetBaseDriverID;
    function GetBaseDriverID(const ADriverID: String): String; overload;
    function GetBaseDriverClass(const ADriverID: String): TClass;
    // RDBMSs
    function GetRDBMSKind(const AName: String): TFDRDBMSKind;
    /// <summary> Returns a database name for the specified RDBMS kind. </summary>
    function GetRDBMSName(AKind: TFDRDBMSKind): String;
    /// <summary> Returns list of registered database names. </summary>
    procedure GetRDBMSNames(ANames: TStrings);
  end;

  IFDPhysManager = interface(IUnknown)
    ['{3E9B315B-F456-4175-A864-B2573C4A2101}']
    // private
    function GetDriverDefs: IFDStanDefinitions;
    function GetConnectionDefs: IFDStanConnectionDefs;
    function GetOptions: IFDStanOptions;
    function GetState: TFDPhysManagerState;
    // public
    procedure CreateDriver(const ADriverID: String;
      out ADrv: IFDPhysDriver; AIntfRequired: Boolean = True);
    procedure CreateConnection(const AConDef: IFDStanConnectionDef;
      out AConn: IFDPhysConnection; AIntfRequired: Boolean = True); overload;
    procedure CreateConnection(const AConDefName: String;
      out AConn: IFDPhysConnection; AIntfRequired: Boolean = True); overload;
    procedure CreateMetadata(out AMeta: IFDPhysManagerMetadata);
    procedure CreateDefaultConnectionMetadata(out AConn: IFDPhysConnectionMetadata);
    procedure Open;
    procedure Close(AWait: Boolean = False);
    procedure CloseConnectionDef(const AConnectionDef: IFDStanConnectionDef);
    procedure RefreshMetadataCache;
    function DriverIDFromSharedCliHandle(ASharedCliHandle: Pointer): String;
    /// <summary> Registers new RDBMS kind constant and associates it with
    ///  specified database name. A database name is used as alias for
    ///  corresponding driver ID and optional RDBMS kind for ODBC or TDBX
    ///  connection. </summary>
    procedure RegisterRDBMSKind(AKind: TFDRDBMSKind; const AName: String);
    procedure RegisterDriverClass(ADriverClass: TClass);
    property DriverDefs: IFDStanDefinitions read GetDriverDefs;
    property ConnectionDefs: IFDStanConnectionDefs read GetConnectionDefs;
    property Options: IFDStanOptions read GetOptions;
    property State: TFDPhysManagerState read GetState;
  end;

  IFDPhysDriverMetadata = interface (IUnknown)
    ['{3E9B315B-F456-4175-A864-B2573C4A2102}']
    // private
    function GetDriverID: String;
    function GetBaseDrvID: String;
    function GetBaseDrvDesc: String;
    function GetDbKind: TFDRDBMSKind;
    // public
    function GetConnParams(AKeys: TStrings; AParams: TFDDatSTable = nil): TFDDatSTable;
    property DriverID: String read GetDriverID;
    property BaseDriverID: String read GetBaseDrvID;
    property BaseDriverDesc: String read GetBaseDrvDesc;
    /// <summary> Returns RDBMS kind for the driver. </summary>
    property RDBMSKind: TFDRDBMSKind read GetDbKind;
  end;

  IFDPhysDriverConnectionWizard = interface (IUnknown)
    ['{3E9B315B-F456-4175-A864-B2573C4A2111}']
    function Run(const AConnDef: IFDStanConnectionDef; AParentWnd: THandle): Boolean;
  end;

  IFDPhysDriver = interface (IUnknown)
    ['{3E9B315B-F456-4175-A864-B2573C4A2103}']
    // private
    function GetDriverID: String;
    function GetBaseDrvID: String;
    function GetConnectionCount: Integer;
    function GetConnections(AIndex: Integer): IFDPhysConnection;
    function GetState: TFDPhysDriverState;
    function GetCliObj: Pointer;
    function GetMessages: TStrings;
    // public
    procedure Load;
    procedure Unload;
    procedure Employ;
    procedure Vacate;
    procedure CreateConnection(const AConnectionDef: IFDStanConnectionDef;
      out AConn: IFDPhysConnection);
    procedure CloseConnectionDef(const AConnectionDef: IFDStanConnectionDef);
    procedure CreateMetadata(out AMeta: IFDPhysDriverMetadata);
    procedure CreateConnectionWizard(out AWizard: IFDPhysDriverConnectionWizard);
    property DriverID: String read GetDriverID;
    property BaseDriverID: String read GetBaseDrvID;
    property State: TFDPhysDriverState read GetState;
    property CliObj: Pointer read GetCliObj;
    property ConnectionCount: Integer read GetConnectionCount;
    property Connections[AIndex: Integer]: IFDPhysConnection read GetConnections;
    property Messages: TStrings read GetMessages;
  end;

  IFDPhysConnectionMetadata = interface (IUnknown)
    ['{3E9B315B-F456-4175-A864-B2573C4A2104}']
    // private
    function GetKind: TFDRDBMSKind;
    function GetClientVersion: TFDVersion;
    function GetServerVersion: TFDVersion;
    function GetIsUnicode: Boolean;
    function GetIsFileBased: Boolean;
    function GetTxSupported: Boolean;
    function GetTxNested: Boolean;
    function GetTxMultiple: Boolean;
    function GetTxSavepoints: Boolean;
    function GetTxAutoCommit: Boolean;
    function GetTxAtomic: Boolean;
    function GetEventSupported: Boolean;
    function GetEventKinds: String;
    function GetGeneratorSupported: Boolean;
    function GetParamNameMaxLength: Integer;
    function GetNameParts: TFDPhysNameParts;
    function GetNameQuotedSupportedParts: TFDPhysNameParts;
    function GetNameQuotedCaseSensParts: TFDPhysNameParts;
    function GetNameCaseSensParts: TFDPhysNameParts;
    function GetNameDefLowCaseParts: TFDPhysNameParts;
    function GetNameQuoteChar(AQuote: TFDPhysNameQuoteLevel; ASide: TFDPhysNameQuoteSide): Char;
    function GetCatalogSeparator: Char;
    function GetSchemaSeparator: Char;
    function GetInsertHBlobMode: TFDPhysInsertHBlobMode;
    function GetIdentitySupported: Boolean;
    function GetIdentityInsertSupported: Boolean;
    function GetIdentityInWhere: Boolean;
    function GetNamedParamMark: TFDPhysParamMark;
    function GetPositionedParamMark: TFDPhysParamMark;
    function GetTruncateSupported: Boolean;
    function GetDefValuesSupported: TFDPhysDefaultValues;
    function GetInlineRefresh: Boolean;
    function GetSelectOptions: TFDPhysSelectOptions;
    function GetLockNoWait: Boolean;
    function GetAsyncAbortSupported: Boolean;
    function GetAsyncNativeTimeout: Boolean;
    function GetCommandSeparator: String;
    function GetLineSeparator: TFDTextEndOfLine;
    function GetArrayExecMode: TFDPhysArrayExecMode;
    function GetLimitOptions: TFDPhysLimitOptions;
    function GetNullLocations: TFDPhysNullLocations;
    function GetServerCursorSupported: Boolean;
    function GetColumnOriginProvided: Boolean;
    function GetCreateTableOptions: TFDPhysCreateTableOptions;
    function GetBackslashEscSupported: Boolean;
    // public
    function DecodeObjName(const AName: String; out AParsedName: TFDPhysParsedName;
      const ACommand: IFDPhysCommand; AOpts: TFDPhysDecodeOptions): Boolean;
    function EncodeObjName(const AParsedName: TFDPhysParsedName;
      const ACommand: IFDPhysCommand; AOpts: TFDPhysEncodeOptions): String;
    function QuoteObjName(const AName: String; APart: TFDPhysNamePart): String;
    function UnQuoteObjName(const AName: String): String;
    function IsKeyword(const AName: String): Boolean;
    function GetNameQuotedCaseSens(const AName: String; APart: TFDPhysNamePart): Boolean;
    function TranslateEscapeSequence(var ASeq: TFDPhysEscapeData): String;
    function GetSQLCommandKind(const ATokens: TStrings): TFDPhysCommandKind;
    function DefineMetadataTableName(AKind: TFDPhysMetaInfoKind): String;
    procedure DefineMetadataStructure(ATable: TFDDatSTable; AKind: TFDPhysMetaInfoKind);
    // object lists
    function GetCatalogs(const AWildCard: String): TFDDatSView;
    function GetSchemas(const ACatalog, AWildCard: String): TFDDatSView;
    function GetTables(AScope: TFDPhysObjectScopes; AKinds: TFDPhysTableKinds;
      const ACatalog, ASchema, AWildCard: String): TFDDatSView;
    function GetTableFields(const ACatalog, ASchema, ATable, AWildCard: String): TFDDatSView;
    function GetTableIndexes(const ACatalog, ASchema, ATable, AWildCard: String): TFDDatSView;
    function GetTableIndexFields(const ACatalog, ASchema, ATable, AIndex, AWildCard: String): TFDDatSView;
    function GetTablePrimaryKey(const ACatalog, ASchema, ATable: String): TFDDatSView;
    function GetTablePrimaryKeyFields(const ACatalog, ASchema, ATable, AWildCard: String): TFDDatSView;
    function GetPackages(AScope: TFDPhysObjectScopes; const ACatalog, ASchema, AWildCard: String): TFDDatSView;
    function GetPackageProcs(const ACatalog, ASchema, APackage, AWildCard: String): TFDDatSView;
    function GetProcs(AScope: TFDPhysObjectScopes; const ACatalog, ASchema, AWildCard: String): TFDDatSView;
    function GetProcArgs(const ACatalog, ASchema, APackage, AProc, AWildCard: String; AOverload: Word): TFDDatSView;
    function GetGenerators(AScope: TFDPhysObjectScopes; const ACatalog, ASchema, AWildCard: string): TFDDatSView;
    function GetResultSetFields(const ASQLKey: String): TFDDatSView;
    function GetTableTypeFields(const ACatalog, ASchema, ATable, AWildCard: String): TFDDatSView;
    procedure RefreshMetadataCache(const AObjName: String = '');
    // props
    property Kind: TFDRDBMSKind read GetKind;
    property ClientVersion: TFDVersion read GetClientVersion;
    property ServerVersion: TFDVersion read GetServerVersion;
    property IsUnicode: Boolean read GetIsUnicode;
    property IsFileBased: Boolean read GetIsFileBased;
    property TxSupported: Boolean read GetTxSupported;
    property TxNested: Boolean read GetTxNested;
    property TxMultiple: Boolean read GetTxMultiple;
    property TxSavepoints: Boolean read GetTxSavepoints;
    property TxAutoCommit: Boolean read GetTxAutoCommit;
    property TxAtomic: Boolean read GetTxAtomic;
    property EventSupported: Boolean read GetEventSupported;
    property EventKinds: String read GetEventKinds;
    property GeneratorSupported: Boolean read GetGeneratorSupported;
    property ParamNameMaxLength: Integer read GetParamNameMaxLength;
    property NameParts: TFDPhysNameParts read GetNameParts;
    property NameQuotedSupportedParts: TFDPhysNameParts read GetNameQuotedSupportedParts;
    property NameQuotedCaseSensParts: TFDPhysNameParts read GetNameQuotedCaseSensParts;
    property NameCaseSensParts: TFDPhysNameParts read GetNameCaseSensParts;
    property NameDefLowCaseParts: TFDPhysNameParts read GetNameDefLowCaseParts;
    property NameQuoteChar[AQuote: TFDPhysNameQuoteLevel; ASide: TFDPhysNameQuoteSide]: Char
      read GetNameQuoteChar;
    property CatalogSeparator: Char read GetCatalogSeparator;
    property SchemaSeparator: Char read GetSchemaSeparator;
    property InsertHBlobMode: TFDPhysInsertHBlobMode read GetInsertHBlobMode;
    property IdentitySupported: Boolean read GetIdentitySupported;
    property IdentityInsertSupported: Boolean read GetIdentityInsertSupported;
    property IdentityInWhere: Boolean read GetIdentityInWhere;
    property NamedParamMark: TFDPhysParamMark read GetNamedParamMark;
    property PositionedParamMark: TFDPhysParamMark read GetPositionedParamMark;
    property TruncateSupported: Boolean read GetTruncateSupported;
    property DefValuesSupported: TFDPhysDefaultValues read GetDefValuesSupported;
    property InlineRefresh: Boolean read GetInlineRefresh;
    property SelectOptions: TFDPhysSelectOptions read GetSelectOptions;
    property LockNoWait: Boolean read GetLockNoWait;
    property AsyncAbortSupported: Boolean read GetAsyncAbortSupported;
    property AsyncNativeTimeout: Boolean read GetAsyncNativeTimeout;
    property CommandSeparator: String read GetCommandSeparator;
    property LineSeparator: TFDTextEndOfLine read GetLineSeparator;
    property ArrayExecMode: TFDPhysArrayExecMode read GetArrayExecMode;
    property LimitOptions: TFDPhysLimitOptions read GetLimitOptions;
    property NullLocations: TFDPhysNullLocations read GetNullLocations;
    property ServerCursorSupported: Boolean read GetServerCursorSupported;
    property ColumnOriginProvided: Boolean read GetColumnOriginProvided;
    property CreateTableOptions: TFDPhysCreateTableOptions read GetCreateTableOptions;
    property BackslashEscSupported: Boolean read GetBackslashEscSupported;
  end;

  IFDPhysConnectionRecoveryHandler = interface (IUnknown)
    ['{3E9B315B-F456-4175-A864-B2573C4A2112}']
    // public
    procedure HandleConnectionRecover(const AInitiator: IFDStanObject;
      AException: Exception; var AAction: TFDPhysConnectionRecoverAction);
    procedure HandleConnectionRestored;
    procedure HandleConnectionLost;
  end;

  TFDPhysLocalSQLAdapterFeatures = set of (afCachedUpdates, afSavePoints,
    afIndexFieldNames, afRanges, afFilters, afPrimaryKey, afTransactions);
  IFDPhysLocalSQLAdapter = interface (IUnknown)
    ['{3E9B315B-F456-4175-A864-B2573C4A2118}']
    // private
    function GetFeatures: TFDPhysLocalSQLAdapterFeatures;
    function GetCachedUpdates: Boolean;
    procedure SetCachedUpdates(const AValue: Boolean);
    function GetSavePoint: Int64;
    procedure SetSavePoint(const AValue: Int64);
    function GetIndexFieldNames: String;
    procedure SetIndexFieldNames(const AValue: String);
    function GetDataSet: TObject;
    procedure SetDataSet(ADataSet: TObject);
    function GetConn: NativeUInt;
    // public
    function ApplyUpdates(AMaxErrors: Integer = -1): Integer;
    procedure CommitUpdates;
    procedure CancelUpdates;
    procedure SetRange(const AStartValues, AEndValues: array of const;
      AStartExclusive: Boolean = False; AEndExclusive: Boolean = False);
    procedure CancelRange;
    function IsPKViolation(AExc: Exception): Boolean;
    property Features: TFDPhysLocalSQLAdapterFeatures read GetFeatures;
    property CachedUpdates: Boolean read GetCachedUpdates write SetCachedUpdates;
    property SavePoint: Int64 read GetSavePoint write SetSavePoint;
    property IndexFieldNames: String read GetIndexFieldNames write SetIndexFieldNames;
    property DataSet: TObject read GetDataSet write SetDataSet;
    property Conn: NativeUInt read GetConn;
  end;

  IFDPhysSQLHandler = interface (IUnknown)
    ['{3E9B315B-F456-4175-A864-B2573C4A2119}']
    function FindAdapter(const ASchema, AName: String): IFDPhysLocalSQLAdapter;
    function GetDataSet(const ASchema, AName: String): Boolean;
    procedure OpenDataSet(const ASchema, AName: String; ADataSet: TObject);
    procedure CloseDataSet(const ASchema, AName: String; ADataSet: TObject);
  end;

  IFDPhysConnection = interface (IUnknown)
    ['{3E9B315B-F456-4175-A864-B2573C4A2105}']
    // private
    function GetDriver: IFDPhysDriver;
    function GetState: TFDPhysConnectionState;
    function GetOptions: IFDStanOptions;
    function GetCommandCount: Integer;
    function GetCommands(AIndex: Integer): IFDPhysCommand;
    function GetErrorHandler: IFDStanErrorHandler;
    function GetRecoveryHandler: IFDPhysConnectionRecoveryHandler;
    function GetLogin: IFDGUIxLoginDialog;
    function GetConnectionDef: IFDStanConnectionDef;
    function GetLoginPrompt: Boolean;
    function GetMessages: EFDDBEngineException;
    function GetCliObj: Pointer;
    function GetSharedCliHandle: Pointer;
    function GetCliHandle: Pointer;
    function GetTransaction: IFDPhysTransaction;
    function GetTransactionCount: Integer;
    function GetTransactions(AIndex: Integer): IFDPhysTransaction;
    function GetCurrentCatalog: String;
    function GetCurrentSchema: String;
    function GetEventCount: Integer;
    function GetEvents(AIndex: Integer): IFDPhysEventAlerter;
    procedure SetOptions(const AValue: IFDStanOptions);
    procedure SetErrorHandler(const AValue: IFDStanErrorHandler);
    procedure SetRecoveryHandler(const AValue: IFDPhysConnectionRecoveryHandler);
    procedure SetLogin(const AValue: IFDGUIxLoginDialog);
    procedure SetLoginPrompt(const AValue: Boolean);
    procedure SetCurrentCatalog(const AValue: String);
    procedure SetCurrentSchema(const AValue: String);
{$IFDEF FireDAC_MONITOR}
    function GetMonitor: IFDMoniClient;
    function GetTracing: Boolean;
    procedure SetTracing(AValue: Boolean);
{$ENDIF}
    procedure SetSharedCliHandle(AValue: Pointer);
    procedure SetTransaction(const AValue: IFDPhysTransaction);
    // public
    procedure CreateMetadata(out AConnMeta: IFDPhysConnectionMetadata);
    procedure CreateCommandGenerator(out AGen: IFDPhysCommandGenerator;
      const ACommand: IFDPhysCommand);
    procedure CreateCommand(out ACmd: IFDPhysCommand);
    procedure CreateMetaInfoCommand(out AMetaCmd: IFDPhysMetaInfoCommand);
    procedure CreateTransaction(out ATx: IFDPhysTransaction);
    procedure CreateEvent(const AEventKind: String; out AEvent: IFDPhysEventAlerter);
    procedure Open;
    procedure Close;
    procedure ForceDisconnect;
    function Ping: Boolean;
    procedure ChangePassword(const ANewPassword: String);
    function GetLastAutoGenValue(const AName: String): Variant;
    procedure SaveLastAutoGenValue(const AValue: Variant);
    function Clone: IFDPhysConnection;
    procedure AnalyzeSession(AMessages: TStrings);
    // R/O
    property Driver: IFDPhysDriver read GetDriver;
    property State: TFDPhysConnectionState read GetState;
    property ConnectionDef: IFDStanConnectionDef read GetConnectionDef;
    property CommandCount: Integer read GetCommandCount;
    property Commands[AIndex: Integer]: IFDPhysCommand read GetCommands;
    property TransactionCount: Integer read GetTransactionCount;
    property Transactions[AIndex: Integer]: IFDPhysTransaction read GetTransactions;
    property EventCount: Integer read GetEventCount;
    property Events[AIndex: Integer]: IFDPhysEventAlerter read GetEvents;
    property Messages: EFDDBEngineException read GetMessages;
    property CliObj: Pointer read GetCliObj;
    property CliHandle: Pointer read GetCliHandle;
    // R/W
    property Options: IFDStanOptions read GetOptions write SetOptions;
    property ErrorHandler: IFDStanErrorHandler read GetErrorHandler write SetErrorHandler;
    property RecoveryHandler: IFDPhysConnectionRecoveryHandler
      read GetRecoveryHandler write SetRecoveryHandler;
    property Login: IFDGUIxLoginDialog read GetLogin write SetLogin;
    property LoginPrompt: Boolean read GetLoginPrompt write SetLoginPrompt;
    property SharedCliHandle: Pointer read GetSharedCliHandle write SetSharedCliHandle;
    property Transaction: IFDPhysTransaction read GetTransaction write SetTransaction;
    property CurrentCatalog: String read GetCurrentCatalog write SetCurrentCatalog;
    property CurrentSchema: String read GetCurrentSchema write SetCurrentSchema;
{$IFDEF FireDAC_MONITOR}
    property Tracing: Boolean read GetTracing write SetTracing;
    property Monitor: IFDMoniClient read GetMonitor;
{$ENDIF}
  end;

  TFDPhysTransactionState = (tsInactive, tsActive, tsStarting, tsCommiting, tsRollingback);
  TFDPhysDisconnectFilter = function (ACmdObj: TObject): Boolean;
  TFDPhysDisconnectMode = (dmOffline, dmRelease);

  IFDPhysTransactionStateHandler = interface(IUnknown)
    ['{3E9B315B-F456-4175-A864-B2573C4A2115}']
    procedure HandleDisconnectCommands(AFilter: TFDPhysDisconnectFilter;
      AMode: TFDPhysDisconnectMode);
    procedure HandleTxOperation(AOperation: TFDPhysTransactionState;
      ABefore: Boolean);
  end;

  IFDPhysTransaction = interface (IUnknown)
    ['{3E9B315B-F456-4175-A864-B2573C4A2113}']
    // private
    function GetOptions: TFDTxOptions;
    function GetActive: Boolean;
    function GetSerialID: LongWord;
    function GetTopSerialID: LongWord;
    function GetNestingLevel: LongWord;
    function GetCliObj: Pointer;
    function GetConnection: IFDPhysConnection;
    function GetState: TFDPhysTransactionState;
    procedure SetOptions(const AValue: TFDTxOptions);
    // public
    function StartTransaction: LongWord;
    procedure Commit;
    procedure CommitRetaining;
    procedure Rollback;
    procedure RollbackRetaining;
    procedure LockAutoStop;
    procedure UnlockAutoStop(ASuccess, AAllowStop: Boolean);
    procedure AddStateHandler(const AHandler: IFDPhysTransactionStateHandler);
    procedure RemoveStateHandler(const AHandler: IFDPhysTransactionStateHandler);
    procedure Disconnect;
    // R/O
    property Connection: IFDPhysConnection read GetConnection;
    property Active: Boolean read GetActive;
    property State: TFDPhysTransactionState read GetState;
    property TopSerialID: LongWord read GetTopSerialID;
    property SerialID: LongWord read GetSerialID;
    property NestingLevel: LongWord read GetNestingLevel;
    property CliObj: Pointer read GetCliObj;
    // R/W
    property Options: TFDTxOptions read GetOptions write SetOptions;
  end;

  TFDPhysMappingResult = (mrDefault, mrMapped, mrNotMapped);
  TFDPhysMappingKind = (nkDefault, nkID, nkSource, nkDatS, nkObj);
  /// <summary> TFDPhysMappingName record represents an universal DatS object
  ///  identifier, used to map the identifier to a DatS object. </summary>
  TFDPhysMappingName = record
    FKind: TFDPhysMappingKind;
    FID: Integer;
    FName: String;
    FObj: TFDDatSObject;
    constructor Create(const AID: Integer; AKind: TFDPhysMappingKind); overload;
    constructor Create(const AName: String; AKind: TFDPhysMappingKind); overload;
    constructor Create(const AObj: TFDDatSObject; AKind: TFDPhysMappingKind); overload;
  end;

  IFDPhysMappingHandler = interface (IUnknown)
    ['{3E9B315B-F456-4175-A864-B2573C4A2108}']
    function MapRecordSet(const ATable: TFDPhysMappingName;
      var ASourceID: Integer; var ASourceName, ADatSName, AUpdateName: String;
      var ADatSTable: TFDDatSTable): TFDPhysMappingResult;
    function MapRecordSetColumn(const ATable, AColumn: TFDPhysMappingName;
      var ASourceID: Integer; var ASourceName, ADatSName, AUpdateName: String;
      var ADatSColumn: TFDDatSColumn): TFDPhysMappingResult;
  end;

  IFDPhysCommandStateHandler = interface(IFDStanAsyncHandler)
    ['{3E9B315B-F456-4175-A864-B2573C4A2114}']
    procedure HandleUnprepare;
  end;

  TFDPhysCommandGeneratorFlags = set of (gfHasHBlob, gfFetchGenerator,
    gfIdentityInsert, gfInlineView, gfCreateIdentityTrigger, gfCreateIdentityGenerator);
  IFDPhysCommandGenerator = interface (IUnknown)
    ['{3E9B315B-F456-4175-A864-B2573C4A2107}']
    // private
    function GetFillRowOptions: TFDPhysFillRowOptions;
    function GetGenOptions: TFDPhysCommandGeneratorOptions;
    function GetFlags: TFDPhysCommandGeneratorFlags;
    function GetParams: TFDParams;
    function GetRow: TFDDatSRow;
    function GetTable: TFDDatSTable;
    function GetUpdateRowOptions: TFDUpdateRowOptions;
    procedure SetParams(const AValue: TFDParams);
    procedure SetRow(const AValue: TFDDatSRow);
    procedure SetTable(const AValue: TFDDatSTable);
    procedure SetUpdateRowOptions(const AValue: TFDUpdateRowOptions);
    function GetCol: TFDDatSColumn;
    procedure SetCol(const AValue: TFDDatSColumn);
    procedure SetFillRowOptions(const AValue: TFDPhysFillRowOptions);
    procedure SetGenOptions(const AValue: TFDPhysCommandGeneratorOptions);
    function GetCommandKind: TFDPhysCommandKind;
    function GetSQLOrderByPos: Integer;
    function GetOptions: IFDStanOptions;
    procedure SetOptions(const AValue: IFDStanOptions);
    function GetMappingHandler: IFDPhysMappingHandler;
    procedure SetMappingHandler(const AValue: IFDPhysMappingHandler);
    function GetSingleRowTable: String;
    // public
    function GenerateDelete: String;
    function GenerateDeleteAll(ANoUndo: Boolean): String;
    function GenerateInsert: String;
    function GenerateMerge(AAction: TFDPhysMergeAction): String;
    function GenerateLock: String;
    function GenerateSavepoint(const AName: String): String;
    function GenerateRollbackToSavepoint(const AName: String): String;
    function GenerateCommitSavepoint(const AName: String): String;
    function GenerateSelect(ARequired: Boolean): String;
    function GenerateUnLock: String;
    function GenerateUpdate: String;
    function GenerateUpdateHBlobs: String;
    function GenerateFetchGenerators: String;
    function GenerateReadGenerator(const AName, AAlias: String;
      ANextValue, AFullSelect: Boolean): String;
    function GenerateCall(const AName: String): String;
    function GenerateEval(const AExpr: String): String;
    function GeneratePing: String;
    function GenerateSelectTable(ATableParams: TFDPhysTableParams): String;
    function GenerateStoredProcParams(const ACatalog, ASchema, APackage, AProc: String;
      AOverload: Word = 0): String;
    function GenerateStoredProcCall(const ACatalog, ASchema, APackage, AProc: String;
      ASPUsage: TFDPhysCommandKind = skStoredProc): String;
    function GenerateSelectMetaInfo(AKind: TFDPhysMetaInfoKind;
      const ACatalog, ASchema, ABaseObj, AObj, AWildcard: String;
      AScopes: TFDPhysObjectScopes; ATableKinds: TFDPhysTableKinds;
      AOverload: Word): String;
    function GenerateLimitSelect(ASkip, ARows: Integer;
      AOneMore: Boolean = False): String;
    function GenerateCountSelect: String;
    function GenerateRowId(out AAlias: String): String;
    function GenerateCreateTable(AParts: TFDPhysCreateTableParts): TStrings;
    function GenerateDropTable(AParts: TFDPhysCreateTableParts): TStrings;
    // R/O
    property Flags: TFDPhysCommandGeneratorFlags read GetFlags;
    property CommandKind: TFDPhysCommandKind read GetCommandKind;
    property SQLOrderByPos: Integer read GetSQLOrderByPos;
    property SingleRowTable: String read GetSingleRowTable;
    // R/W
    property FillRowOptions: TFDPhysFillRowOptions read GetFillRowOptions
      write SetFillRowOptions;
    property UpdateRowOptions: TFDUpdateRowOptions read GetUpdateRowOptions
      write SetUpdateRowOptions;
    property GenOptions: TFDPhysCommandGeneratorOptions read GetGenOptions
      write SetGenOptions;
    property Options: IFDStanOptions read GetOptions write SetOptions;
    property Params: TFDParams read GetParams write SetParams;
    property Column: TFDDatSColumn read GetCol write SetCol;
    property Row: TFDDatSRow read GetRow write SetRow;
    property Table: TFDDatSTable read GetTable write SetTable;
    property MappingHandler: IFDPhysMappingHandler read GetMappingHandler
      write SetMappingHandler;
  end;

  IFDPhysCommand = interface (IUnknown)
    ['{3E9B315B-F456-4175-A864-B2573C4A2109}']
    // private
    function GetSchemaName: String;
    function GetCatalogName: String;
    function GetBaseObjectName: String;
    function GetConnection: IFDPhysConnection;
    function GetOptions: IFDStanOptions;
    function GetState: TFDPhysCommandState;
    function GetCommandText: String;
    function GetCommandKind: TFDPhysCommandKind;
    function GetParams: TFDParams;
    function GetMacros: TFDMacros;
    function GetOverload: Word;
    function GetNextRecordSet: Boolean;
    function GetErrorHandler: IFDStanErrorHandler;
    function GetSourceObjectName: String;
    function GetSourceRecordSetName: String;
    function GetRowsAffected: TFDCounter;
    function GetRowsAffectedReal: Boolean;
    function GetErrorAction: TFDErrorAction;
    function GetMappingHandler: IFDPhysMappingHandler;
    function GetSQLOrderByPos: Integer;
    function GetCliObj: Pointer;
    function GetTransaction: IFDPhysTransaction;
    function GetSQLText: String;
    function GetStateHandler: IFDPhysCommandStateHandler;
    procedure SetSchemaName(const AValue: String);
    procedure SetCatalogName(const AValue: String);
    procedure SetBaseObjectName(const AValue: String);
    procedure SetOptions(const AValue: IFDStanOptions);
    procedure SetCommandText(const AValue: String);
    procedure SetCommandKind(const AValue: TFDPhysCommandKind);
    procedure SetSourceObjectName(const AValues: String);
    procedure SetSourceRecordSetName(const AValues: String);
    procedure SetNextRecordSet(const AValue: Boolean);
    procedure SetErrorHandler(const AValue: IFDStanErrorHandler);
    procedure SetOverload(const AValue: Word);
    procedure SetMappingHandler(const AValue: IFDPhysMappingHandler);
    procedure SetTransaction(const AValue: IFDPhysTransaction);
    procedure SetStateHandler(const AValue: IFDPhysCommandStateHandler);
    procedure SetMacros(AValue: TFDMacros);
    procedure SetParams(AValue: TFDParams);
    // public
    procedure AbortJob(const AWait: Boolean = False);
    procedure Close;
    procedure CloseAll;
    procedure CheckAsyncProgress;
    procedure Disconnect;
    function Define(ADatSManager: TFDDatSManager; ATable: TFDDatSTable = nil;
      AMetaInfoMergeMode: TFDPhysMetaInfoMergeMode = mmReset): TFDDatSTable; overload;
    function Define(ATable: TFDDatSTable = nil;
      AMetaInfoMergeMode: TFDPhysMetaInfoMergeMode = mmReset): TFDDatSTable; overload;
    procedure Execute(ATimes: Integer = 0; AOffset: Integer = 0;
      ABlocked: Boolean = False);
    procedure Fetch(ATable: TFDDatSTable; AAll: Boolean = True;
      ABlocked: Boolean = False); overload;
    procedure Fetch(ADatSManager: TFDDatSManager;
      AMetaInfoMergeMode: TFDPhysMetaInfoMergeMode = mmReset); overload;
    procedure CloseStreams;
    procedure Open(ABlocked: Boolean = False);
    procedure Preprocess;
    procedure Prepare(const ACommandText: String = ''; ACreateParams: Boolean = True);
    procedure Unprepare;
    // R/O
    property Connection: IFDPhysConnection read GetConnection;
    property State: TFDPhysCommandState read GetState;
    property RowsAffected: TFDCounter read GetRowsAffected;
    property RowsAffectedReal: Boolean read GetRowsAffectedReal;
    property ErrorAction: TFDErrorAction read GetErrorAction;
    property SQLOrderByPos: Integer read GetSQLOrderByPos;
    property SQLText: String read GetSQLText;
    property CliObj: Pointer read GetCliObj;
    // R/W
    property Transaction: IFDPhysTransaction read GetTransaction write SetTransaction;
    property Options: IFDStanOptions read GetOptions write SetOptions;
    property SchemaName: String read GetSchemaName write SetSchemaName;
    property CatalogName: String read GetCatalogName write SetCatalogName;
    property BaseObjectName: String read GetBaseObjectName write SetBaseObjectName;
    property CommandKind: TFDPhysCommandKind read GetCommandKind write SetCommandKind;
    property CommandText: String read GetCommandText write SetCommandText;
    property Params: TFDParams read GetParams write SetParams;
    property Macros: TFDMacros read GetMacros write SetMacros;
    property Overload: Word read GetOverload write SetOverload;
    property NextRecordSet: Boolean read GetNextRecordSet write SetNextRecordSet;
    property SourceObjectName: String read GetSourceObjectName write SetSourceObjectName;
    property SourceRecordSetName: String read GetSourceRecordSetName write SetSourceRecordSetName;
    property ErrorHandler: IFDStanErrorHandler read GetErrorHandler write SetErrorHandler;
    property MappingHandler: IFDPhysMappingHandler read GetMappingHandler write SetMappingHandler;
    property StateHandler: IFDPhysCommandStateHandler read GetStateHandler write SetStateHandler;
  end;

  IFDPhysMetaInfoCommand = interface(IFDPhysCommand)
    ['{3E9B315B-F456-4175-A864-B2573C4A2110}']
    // private
    function GetMetaInfoKind: TFDPhysMetaInfoKind;
    procedure SetMetaInfoKind(AValue: TFDPhysMetaInfoKind);
    function GetTableKinds: TFDPhysTableKinds;
    procedure SetTableKinds(AValue: TFDPhysTableKinds);
    function GetWildcard: String;
    procedure SetWildcard(const AValue: String);
    function GetObjectScopes: TFDPhysObjectScopes;
    procedure SetObjectScopes(AValue: TFDPhysObjectScopes);
    // public
    property MetaInfoKind: TFDPhysMetaInfoKind read GetMetaInfoKind write SetMetaInfoKind;
    property TableKinds: TFDPhysTableKinds read GetTableKinds write SetTableKinds;
    property Wildcard: String read GetWildcard write SetWildcard;
    property ObjectScopes: TFDPhysObjectScopes read GetObjectScopes write SetObjectScopes;
  end;

  IFDPhysEventHandler = interface (IUnknown)
    ['{3E9B315B-F456-4175-A864-B2573C4A2116}']
    procedure HandleEvent(const AEventName: String; const AArgument: Variant);
    procedure HandleTimeout(var AContinue: Boolean);
  end;

  /// <summary> IFDPhysChangeHandler interface represents a change notification
  /// listener. </summary>
  IFDPhysChangeHandler = interface (IUnknown)
    ['{3E9B315B-F456-4175-A864-B2573C4A2121}']
    // private
    function GetTrackCommand: IFDPhysCommand;
    function GetTrackEventName: String;
    function GetMergeTable: TFDDatSTable;
    function GetMergeManager: TFDDatSManager;
    function GetContentModified: Boolean;
    procedure SetContentModified(AValue: Boolean);
    // public
    /// <summary> RefreshContent method is called when event alerter needs to
    /// refresh content of the change handler. Eg, as result of receiving a data
    /// change notification. See also IFDPhysEventAlerter.Options.AutoRefresh. </summary>
    procedure RefreshContent;
    /// <summary> ResyncContent method is called when event alerter needs to
    /// resync content of the change handler after updating of MergeTable or
    /// MergeManager. Eg, as result of receiving a data change notification. </summary>
    procedure ResyncContent;
    // R/O
    /// <summary> TrackCommand returns a SQL command, which represent the interested data.
    ///  The command is used for subscription to change notifications and refreshing the
    ///  change handler content. Both usages may be or may not be supported by database.
    ///
    ///  When subscription to change notifications is supported and a data returned by
    ///  this command is changed, then event alerter receives a change notification.
    ///  When not supported, then notifications may be implemented using generic event
    ///  alerters. Only SQL Server and Oracle support that.
    ///
    ///  A database may support incremental refreshing of content, when only changed
    ///  records are returned. Then a data returned by this command will be merged into
    ///  MergeTable or MergeManager content. When not supported, then the full content
    ///  will be reread. Only InterBase XE7 supports that. </summary>
    property TrackCommand: IFDPhysCommand read GetTrackCommand;
    /// <summary> Returns change notification name. By default it is equal to a
    ///  TrackCommand SQL query base table name. </summary>
    property TrackEventName: String read GetTrackEventName;
    /// <summary> Returns client side records table. When FireDAC needs to refresh
    /// content of change handler, it will reload or merge changes into this table.
    /// When MergeManager is not nil, then MergeManager will be used. Otherwise
    /// MergeTable will be used.</summary>
    property MergeTable: TFDDatSTable read GetMergeTable;
    /// <summary> Returns client side records manager. When FireDAC needs to refresh
    /// content of change handler, it will reload or merge changes into this manager.
    /// When MergeManager is not nil, then MergeManager will be used. Otherwise
    /// MergeTable will be used.</summary>
    property MergeManager: TFDDatSManager read GetMergeManager;
    /// <summary> ContentModified property is set to True when event alerter
    /// received a data change notification. This marks change handler content
    /// as modified and requiring refreshing. And it is set to False when
    /// RefreshContent / ResyncContent are called. </summary>
    property ContentModified: Boolean read GetContentModified write SetContentModified;
  end;

  TFDPhysEventAlerterState = (esInactive, esRegistering, esRegistered,
    esUnregistering, esFiring);
  IFDPhysEventAlerter = interface (IUnknown)
    ['{3E9B315B-F456-4175-A864-B2573C4A2117}']
    // private
    function GetConnection: IFDPhysConnection;
    function GetState: TFDPhysEventAlerterState;
    function GetKind: String;
    function GetOptions: TFDEventAlerterOptions;
    function GetNames: TStrings;
    function GetSubscriptionName: String;
    function GetHandler: IFDPhysEventHandler;
    procedure SetOptions(const AValue: TFDEventAlerterOptions);
    procedure SetNames(const AValue: TStrings);
    procedure SetSubscriptionName(const AValue: String);
    procedure SetHandler(const AValue: IFDPhysEventHandler);
    // public
    procedure Register;
    procedure Unregister;
    procedure Signal(const AEvent: String; const AArgument: Variant);
    /// <summary> Refreshes the change handler (eg, TFDAdaptedDataSet) content.
    ///  When AForce=False, then refresh will be performed if alerter received
    ///  a change notification after last refreshing. When AForce=True, then
    ///  refresh will be performed unconditionally.
    ///  When AHandler=nil, then all registered change handlers will be refreshed.
    ///  Otherwise only specified change handler.
    ///  See also Options.AutoRefresh </summary>
    procedure Refresh(const AHandler: IFDPhysChangeHandler; AForce: Boolean);
    /// <summary> Adds a change handler (eg, TFDAdaptedDataSet) to this event alerter.</summary>
    procedure AddChangeHandler(const AHandler: IFDPhysChangeHandler);
    /// <summary> Removes a change handler (eg, TFDAdaptedDataSet) from this event alerter. </summary>
    procedure RemoveChangeHandler(const AHandler: IFDPhysChangeHandler);
    /// <summary> Aborts any currently performing operations. </summary>
    procedure AbortJob;
    // R/O
    property Connection: IFDPhysConnection read GetConnection;
    property State: TFDPhysEventAlerterState read GetState;
    property Kind: String read GetKind;
    // R/W
    property Options: TFDEventAlerterOptions read GetOptions write SetOptions;
    property Names: TStrings read GetNames write SetNames;
    /// <summary> Specifies a change notification subscription name.
    ///  The value depends on a database:
    ///  * InterBase - XE7 Change View subscription name
    ///  * SQL Server - &lt;service&gt;;&lt;queue&gt; </summary>
    property SubscriptionName: String read GetSubscriptionName write SetSubscriptionName;
    property Handler: IFDPhysEventHandler read GetHandler write SetHandler;
  end;

  IFDPhysDataSetParamReader = interface (IUnknown)
    ['{3E9B315B-F456-4175-A864-B2573C4A2120}']
    function Reset: Boolean;
    function Next: Boolean;
    function GetData(const AColumn: Integer; var ABuff: Pointer;
      ABuffLen: LongWord; var ADataLen: LongWord; AByVal: Boolean): Boolean;
  end;

function FDPhysManager: IFDPhysManager;
function FDGetFillRowOptions(AFetchOptions: TFDFetchOptions): TFDPhysFillRowOptions;
procedure FDClearMetaView(var AView: TFDDatSView; AOptions: TFDFetchOptions);

implementation

uses
  FireDAC.Stan.Factory, FireDAC.Stan.Util;

{-------------------------------------------------------------------------------}
{ TFDPhysMappingName                                                            }
{-------------------------------------------------------------------------------}
constructor TFDPhysMappingName.Create(const AID: Integer; AKind: TFDPhysMappingKind);
begin
  FID := AID;
  FKind := AKind;
end;

{-------------------------------------------------------------------------------}
constructor TFDPhysMappingName.Create(const AName: String; AKind: TFDPhysMappingKind);
begin
  FName := AName;
  FKind := AKind;
end;

{-------------------------------------------------------------------------------}
constructor TFDPhysMappingName.Create(const AObj: TFDDatSObject; AKind: TFDPhysMappingKind);
begin
  FObj := AObj;
  FKind := AKind;
end;

{-------------------------------------------------------------------------------}
function FDPhysManager: IFDPhysManager;
begin
  FDCreateInterface(IFDPhysManager, Result);
end;

{-------------------------------------------------------------------------------}
function FDGetFillRowOptions(AFetchOptions: TFDFetchOptions): TFDPhysFillRowOptions;
begin
  if AFetchOptions = nil then
    Result := [foData, foBlobs, foDetails]
  else begin
    Result := [foData];
    if fiBlobs in AFetchOptions.Items then
      Include(Result, foBlobs);
    if fiDetails in AFetchOptions.Items then
      Include(Result, foDetails);
  end;
end;

{-------------------------------------------------------------------------------}
procedure FDClearMetaView(var AView: TFDDatSView; AOptions: TFDFetchOptions);
begin
  if not (fiMeta in AOptions.Cache) then
    AView.DeleteAll(True);
  FDFreeAndNil(AView);
end;

end.
