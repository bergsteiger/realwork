{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Data.DBXMetaDataReader;

interface

uses
  Data.DBXCommon,
  Data.DBXCommonTable,
  Data.DBXPlatform,
  Data.DBXSqlScanner,
  System.SysUtils;

type
  TDBXDataTypeDescription = class;
  TDBXBaseMetaDataReader = class;
  TDBXPlatformTypeNames = class;
  TDBXProviderContext = class;
  TDBXDataTypeDescriptionArray = array of TDBXDataTypeDescription;

  TDBXColumnsTableCursor = class(TDBXDelegateTable)
  public
    constructor Create; overload;
    constructor Create(const Reader: TDBXBaseMetaDataReader; const CheckBase: Boolean; const Cursor: TDBXTable); overload;
    destructor Destroy; override;
    function Next: Boolean; override;
  protected
    FOrdinalOffset: Integer;
    FOrdinalTypeName: Integer;
    [Weak]FReader: TDBXBaseMetaDataReader;
    [Weak]FDataTypeHash: TDBXObjectStore;
    [Weak]FDataType: TDBXDataTypeDescription;
    FCheckBase: Boolean;
    function GetWritableValue(const Ordinal: Integer): TDBXWritableValue; override;
  private
    FDataTypesRow: TDBXSingleValueRow;
  end;

  TDBXCustomMetaDataTable = class(TDBXRowTable)
  public
    constructor Create(const TypeNames: TDBXPlatformTypeNames; const MetaDataCollectionName: string; const Columns: TDBXValueTypeArray; const Cursor: TDBXTable);
    destructor Destroy; override;
    function First: Boolean; override;
    function Next: Boolean; override;
    function InBounds: Boolean; override;
    procedure Close; override;
    function GetOrdinal(const ColumnName: string): Integer; override;
  protected
    function GetCommand: TObject; override;
    function FindStringSize(const Ordinal: Integer; const SourceColumns: TDBXValueTypeArray): Integer; overload; virtual;
    function FindStringSize(const Column: TDBXValueType): Integer; overload; virtual;
    function GetDBXTableName: string; override;
    function GetColumns: TDBXValueTypeArray; override;
    procedure CheckColumn(const Ordinal: Integer); virtual;
    function GetWritableValue(const Ordinal: Integer): TDBXWritableValue; override;
    function GetInt32(const Cursor: TDBXTable; const Ordinal: Integer; const DefaultValue: Integer): Integer; virtual;
    function GetInt64(const Cursor: TDBXTable; const Ordinal: Integer; const DefaultValue: Int64): Int64; virtual;
    function GetAsString(const Cursor: TDBXTable; const Ordinal: Integer; const DefaultValue: string): string; virtual;
    function GetBoolean(const Cursor: TDBXTable; const Ordinal: Integer; const DefaultValue: Boolean): Boolean; virtual;
  private
    procedure AdjustColumnSize;
  protected
    [Weak]FTypeNames: TDBXPlatformTypeNames;
    FMetaDataCollectionName: string;
    FCursor: TDBXTable;
    FColumns: TDBXValueTypeArray;
  private
    FColumnsSizeAdjusted: Boolean;
    FHasIndexColumn: Boolean;
  end;

  TDBXDataTypeCursor = class(TDBXRowTable)
  public
    constructor Create(const Reader: TDBXBaseMetaDataReader; const Columns: TDBXValueTypeArray; const Types: TDBXArrayList);
    destructor Destroy; override;
    function GetOrdinal(const Name: string): Integer; override;
    procedure Close; override;
    function First: Boolean; override;
    function InBounds: Boolean; override;
    function Next: Boolean; override;
  protected
    function GetDBXTableName: string; override;
    function GetColumns: TDBXValueTypeArray; override;
    function GetWritableValue(const Ordinal: Integer): TDBXWritableValue; override;
  protected
    [Weak]FReader: TDBXBaseMetaDataReader;
    [Weak]FTypes: TDBXArrayList;
    [Weak]FCurrent: TDBXDataTypeDescription;
    FRowIndex: Integer;
  private
    FTypeRow: TDBXSingleValueRow;
  end;

  TDBXDataTypeDescription = class
  public
    constructor Create(const TypeName: string; const DataType: Integer; const ColumnSize: Int64; const CreateFormat: string; const CreateParams: string; const MaxScale: Integer; const MinScale: Integer; const LiteralPrefix: string; const LiteralSuffix: string; const MaxVersion: string; const MinVersion: string; const Flags: Integer); overload;
    constructor Create(const Original: TDBXDataTypeDescription); overload;
    function GetDataType(const TypeNames: TDBXPlatformTypeNames): string;
  protected
    function IsAutoIncrementable: Boolean;
    function IsBestMatch: Boolean;
    function IsCaseSensitive: Boolean;
    function IsFixedLength: Boolean;
    function IsFixedPrecisionScale: Boolean;
    function IsLong: Boolean;
    function IsNullable: Boolean;
    function IsSearchable: Boolean;
    function IsSearchableWithLike: Boolean;
    function IsUnsigned: Boolean;
    function IsUnicode: Boolean;
    function IsUnicodeOptionSupported: Boolean;
    procedure SetUnicodeOptionSupported(const Supported: Boolean);
    function IsUnsignedOptionSupported: Boolean;
    function IsStringOptionSupported: Boolean;
    function IsLongOptionSupported: Boolean;
    function GetMaximumScale: SmallInt;
    function GetMinimumScale: SmallInt;
    function IsConcurrencyType: Boolean;
    function IsLiteralSupported: Boolean;
  private
    function IsFlagSet(const Flag: Integer): Boolean;
    procedure SetFlag(const bOn: Boolean; const Flag: Integer);
  private
    FTypeName: string;
    FDataType: Integer;
    FColumnSize: Int64;
    FFlags: Integer;
    FMaxVersion: string;
    FMinVersion: string;
    FCreateFormat: string;
    FCreateParams: string;
    FLiteralPrefix: string;
    FLiteralSuffix: string;
    FMaxScale: Integer;
    FMinScale: Integer;
  public
    property TypeName: string read FTypeName;
    property DbxDataType: Integer read FDataType;
    property ColumnSize: Int64 read FColumnSize;
    property CreateFormat: string read FCreateFormat;
    property CreateParameters: string read FCreateParams;
    property AutoIncrementable: Boolean read IsAutoIncrementable;
    property BestMatch: Boolean read IsBestMatch;
    property CaseSensitive: Boolean read IsCaseSensitive;
    property FixedLength: Boolean read IsFixedLength;
    property FixedPrecisionScale: Boolean read IsFixedPrecisionScale;
    property Long: Boolean read IsLong;
    property Nullable: Boolean read IsNullable;
    property Searchable: Boolean read IsSearchable;
    property SearchableWithLike: Boolean read IsSearchableWithLike;
    property Unsigned: Boolean read IsUnsigned;
    property Unicode: Boolean read IsUnicode;
    property UnicodeOptionSupported: Boolean read IsUnicodeOptionSupported write SetUnicodeOptionSupported;
    property UnsignedOptionSupported: Boolean read IsUnsignedOptionSupported;
    property StringOptionSupported: Boolean read IsStringOptionSupported;
    property LongOptionSupported: Boolean read IsLongOptionSupported;
    property MaximumScale: SmallInt read GetMaximumScale;
    property MinimumScale: SmallInt read GetMinimumScale;
    property ConcurrencyType: Boolean read IsConcurrencyType;
    property MaximumVersion: string read FMaxVersion;
    property MinimumVersion: string read FMinVersion;
    property LiteralSupported: Boolean read IsLiteralSupported;
    property LiteralPrefix: string read FLiteralPrefix;
    property LiteralSuffix: string read FLiteralSuffix;
  end;

  TDBXEmptyTableCursor = class(TDBXTable)
  public
    constructor Create(const MetaDataCollectionName: string; const Columns: TDBXValueTypeArray);
    destructor Destroy; override;
    function GetOrdinal(const ColumnName: string): Integer; override;
    function First: Boolean; override;
    function InBounds: Boolean; override;
    function Next: Boolean; override;
    procedure Close; override;
  protected
    function IsUpdateable: Boolean; override;
    function GetDBXTableName: string; override;
    function GetWritableValue(const Ordinal: Integer): TDBXWritableValue; override;
    function GetColumns: TDBXValueTypeArray; override;
  public
    FColumns: TDBXValueTypeArray;
  private
    FMetaDataCollectionName: string;
  end;

  TDBXFilterProps = class(TDBXProperties)
  private
    
    /// <summary> 
    /// </summary>
    const FSerialVersionUID = -2989215426292773724;
  end;

  TDBXMetaDataCollectionColumns = class
  public
    class function CreateDataTypesColumns: TDBXValueTypeArray; static;
    class function CreateCatalogsColumns: TDBXValueTypeArray; static;
    class function CreateSchemasColumns: TDBXValueTypeArray; static;
    class function CreateTablesColumns: TDBXValueTypeArray; static;
    class function CreateViewsColumns: TDBXValueTypeArray; static;
    class function CreateSynonymsColumns: TDBXValueTypeArray; static;
    class function CreateColumnsColumns: TDBXValueTypeArray; static;
    class function CreateColumnConstraintsColumns: TDBXValueTypeArray; static;
    class function CreateIndexesColumns: TDBXValueTypeArray; static;
    class function CreateIndexColumnsColumns: TDBXValueTypeArray; static;
    class function CreateForeignKeysColumns: TDBXValueTypeArray; static;
    class function CreateForeignKeyColumnsColumns: TDBXValueTypeArray; static;
    class function CreateProceduresColumns: TDBXValueTypeArray; static;
    class function CreateProcedureSourcesColumns: TDBXValueTypeArray; static;
    class function CreateProcedureParametersColumns: TDBXValueTypeArray; static;
    class function CreatePackagesColumns: TDBXValueTypeArray; static;
    class function CreatePackageProceduresColumns: TDBXValueTypeArray; static;
    class function CreatePackageProcedureParametersColumns: TDBXValueTypeArray; static;
    class function CreatePackageSourcesColumns: TDBXValueTypeArray; static;
    class function CreateUsersColumns: TDBXValueTypeArray; static;
    class function CreateRolesColumns: TDBXValueTypeArray; static;
    class function CreateReservedWordsColumns: TDBXValueTypeArray; static;
    class function CreateValueType(const ColumnName: string; const ColumnCaption: string; const ColumnType: Integer): TDBXValueType; overload; static;
    class function CreateValueType(const ColumnName: string; const ColumnCaption: string; const ColumnType: Integer; const Hidden: Boolean): TDBXValueType; overload; static;
    class function DefaultDataSize(const ColumnType: Integer): Integer; static;
  private
    const DefaultAnsiDataSize = 128;
    const DefaultWideDataSize = 256;
  end;

  TDBXMetaDataCommandParseResult = class
  public
    constructor Create(const CommandToken: Integer; const Parameters: TDBXStringArray);
  private
    FCommandToken: Integer;
    FParameters: TDBXStringArray;
  public
    property CommandToken: Integer read FCommandToken;
    property Parameters: TDBXStringArray read FParameters;
  end;

  TDBXMetaDataReader = class abstract
  public
    function FetchCollection(const MetaDataCommand: string): TDBXTable; virtual; abstract;
    function FetchCollectionWithStorage(const MetaDataCommand: string): TDBXTable; virtual; abstract;
  protected
    procedure SetContext(const Context: TDBXProviderContext); virtual; abstract;
    function GetContext: TDBXProviderContext; virtual; abstract;
    function GetProductName: string; virtual; abstract;
    function GetVersion: string; virtual; abstract;
    procedure SetVersion(const Version: string); virtual; abstract;
    function GetSqlIdentifierQuotePrefix: string; virtual; abstract;
    function GetSqlIdentifierQuoteSuffix: string; virtual; abstract;
    function IsLowerCaseIdentifiersSupported: Boolean; virtual; abstract;
    function IsUpperCaseIdentifiersSupported: Boolean; virtual; abstract;
    function IsQuotedIdentifiersSupported: Boolean; virtual; abstract;
    function IsDescendingIndexSupported: Boolean; virtual; abstract;
    function IsDescendingIndexColumnsSupported: Boolean; virtual; abstract;
    function GetSqlIdentifierQuoteChar: string; virtual; abstract;
    function GetSqlProcedureQuoteChar: string; virtual; abstract;
    function IsMultipleCommandsSupported: Boolean; virtual; abstract;
    function IsTransactionsSupported: Boolean; virtual; abstract;
    function IsNestedTransactionsSupported: Boolean; virtual; abstract;
    function IsSetRowSizeSupported: Boolean; virtual; abstract;
    
    /// <summary> Returns true of the vendor supports return code value in stored procedures.
    /// </summary>
    /// <remarks> 
    ///  Default is false.
    ///  
    /// </remarks>
    /// <returns>true if the return code is supported by vendor</returns>
    function IsSPReturnCodeSupported: Boolean; virtual; abstract;
    function IsParameterMetadataSupported: Boolean; virtual; abstract;
    function AreCatalogFunctionsSupported: Boolean; virtual; abstract;
    function AreCatalogsSupported: Boolean; virtual; abstract;
    function AreSchemasSupported: Boolean; virtual; abstract;
  public
    property Context: TDBXProviderContext read GetContext write SetContext;
    property ProductName: string read GetProductName;
    property Version: string read GetVersion write SetVersion;
    property SqlIdentifierQuotePrefix: string read GetSqlIdentifierQuotePrefix;
    property SqlIdentifierQuoteSuffix: string read GetSqlIdentifierQuoteSuffix;
    property LowerCaseIdentifiersSupported: Boolean read IsLowerCaseIdentifiersSupported;
    property UpperCaseIdentifiersSupported: Boolean read IsUpperCaseIdentifiersSupported;
    property QuotedIdentifiersSupported: Boolean read IsQuotedIdentifiersSupported;
    property DescendingIndexSupported: Boolean read IsDescendingIndexSupported;
    property DescendingIndexColumnsSupported: Boolean read IsDescendingIndexColumnsSupported;
    property SqlIdentifierQuoteChar: string read GetSqlIdentifierQuoteChar;
    property SqlProcedureQuoteChar: string read GetSqlProcedureQuoteChar;
    property MultipleCommandsSupported: Boolean read IsMultipleCommandsSupported;
    property TransactionsSupported: Boolean read IsTransactionsSupported;
    property NestedTransactionsSupported: Boolean read IsNestedTransactionsSupported;
    property SetRowSizeSupported: Boolean read IsSetRowSizeSupported;
    
    /// <summary> Returns true of the vendor supports return code value in stored procedures.
    /// </summary>
    /// <remarks> 
    ///  Default is false.
    ///  
    /// </remarks>
    /// <returns>true if the return code is supported by vendor</returns>
    property SPReturnCodeSupported: Boolean read IsSPReturnCodeSupported;
    property ParameterMetadataSupported: Boolean read IsParameterMetadataSupported;
    property CatalogFunctionsSupported: Boolean read AreCatalogFunctionsSupported;
    property CatalogsSupported: Boolean read AreCatalogsSupported;
    property SchemasSupported: Boolean read AreSchemasSupported;
  end;

  TDBXBaseMetaDataReader = class(TDBXMetaDataReader)
  public
    destructor Destroy; override;
    function CompareVersion(const OtherVersion: string): Integer; virtual;
    function FetchCollection(const MetaDataCommand: string): TDBXTable; override;
    function MakeStorage(var Cursor: TDBXTable): TDBXTable; virtual;
    function FetchCollectionWithStorage(const MetaDataCommand: string): TDBXTable; override;
    function FetchDataTypes: TDBXTable; virtual;
    function FetchCatalogs: TDBXTable; virtual;
    function FetchSchemas(const Catalog: string): TDBXTable; virtual;
    function FetchTables(const Catalog: string; const Schema: string; const TableName: string; const TableType: string): TDBXTable; virtual;
    function FetchViews(const Catalog: string; const Schema: string; const View: string): TDBXTable; virtual;
    function FetchColumns(const Catalog: string; const Schema: string; const Table: string): TDBXTable; virtual;
    function FetchColumnConstraints(const Catalog: string; const Schema: string; const Table: string): TDBXTable; virtual;
    function FetchIndexes(const Catalog: string; const Schema: string; const Table: string): TDBXTable; virtual;
    function FetchIndexColumns(const Catalog: string; const Schema: string; const Table: string; const Index: string): TDBXTable; virtual;
    function FetchForeignKeys(const Catalog: string; const Schema: string; const Table: string): TDBXTable; virtual;
    function FetchForeignKeyColumns(const Catalog: string; const Schema: string; const Table: string; const ForeignKeyName: string; const PrimaryCatalog: string; const PrimarySchema: string; const PrimaryTable: string; const PrimaryKeyName: string): TDBXTable; virtual;
    function FetchSynonyms(const Catalog: string; const Schema: string; const Synonym: string): TDBXTable; virtual;
    function FetchProcedures(const Catalog: string; const Schema: string; const ProcedureName: string; const ProcedureType: string): TDBXTable; virtual;
    function FetchProcedureSources(const Catalog: string; const Schema: string; const Proc: string): TDBXTable; virtual;
    function FetchProcedureParameters(const Catalog: string; const Schema: string; const Proc: string; const Parameter: string): TDBXTable; virtual;
    function FetchPackages(const Catalog: string; const Schema: string; const PackageName: string): TDBXTable; virtual;
    function FetchPackageProcedures(const Catalog: string; const Schema: string; const PackageName: string; const ProcedureName: string; const ProcedureType: string): TDBXTable; virtual;
    function FetchPackageProcedureParameters(const Catalog: string; const Schema: string; const PackageName: string; const ProcedureName: string; const ParameterName: string): TDBXTable; virtual;
    function FetchPackageSources(const Catalog: string; const Schema: string; const PackageName: string): TDBXTable; virtual;
    function FetchUsers: TDBXTable; virtual;
    function FetchRoles: TDBXTable; virtual;
    function FetchReservedWords: TDBXTable; virtual;
  protected
    procedure SetContext(const Context: TDBXProviderContext); override;
    function GetContext: TDBXProviderContext; override;
    function GetProductName: string; override;
    function GetVersion: string; override;
    procedure SetVersion(const Version: string); override;
    function GetSqlDefaultParameterMarker: string; virtual;
    function GetSqlIdentifierQuotePrefix: string; override;
    function GetSqlIdentifierQuoteSuffix: string; override;
    function IsQuotedIdentifiersSupported: Boolean; override;
    function IsLowerCaseIdentifiersSupported: Boolean; override;
    function IsUpperCaseIdentifiersSupported: Boolean; override;
    function IsDescendingIndexSupported: Boolean; override;
    function IsDescendingIndexColumnsSupported: Boolean; override;
    
    /// <summary> Returns true of the vendor supports return code value in stored procedures.
    /// </summary>
    /// <remarks> 
    ///  Default is false.
    ///  
    /// </remarks>
    /// <returns>true if the return code is supported by vendor</returns>
    function IsSPReturnCodeSupported: Boolean; override;
    function IsParameterMetadataSupported: Boolean; override;
    function AreCatalogFunctionsSupported: Boolean; override;
    function AreCatalogsSupported: Boolean; override;
    function AreSchemasSupported: Boolean; override;
    function GetSqlIdentifierQuoteChar: string; override;
    function GetSqlProcedureQuoteChar: string; override;
    function IsMultipleCommandsSupported: Boolean; override;
    function IsTransactionsSupported: Boolean; override;
    function IsNestedTransactionsSupported: Boolean; override;
    function IsSetRowSizeSupported: Boolean; override;
    function GetTableType: string; virtual;
    function GetViewType: string; virtual;
    function GetSystemTableType: string; virtual;
    function GetSystemViewType: string; virtual;
    function GetSynonymType: string; virtual;
    function MakeTableTypeString(const InTableTypeCode: Integer; const Flags: Integer): string;
    function GetDataTypeHash: TDBXObjectStore;
    function GetDataTypes: TDBXArrayList;
    procedure PopulateDataTypes(const Hash: TDBXObjectStore; const Types: TDBXArrayList; const Descr: TDBXDataTypeDescriptionArray); virtual;
    function GetDataTypeDescriptions: TDBXDataTypeDescriptionArray; virtual;
    function GetReservedWords: TDBXStringArray; virtual;
    function GetSqlForDataTypes: string; virtual;
    function GetSqlForCatalogs: string; virtual;
    function GetSqlForSchemas: string; virtual;
    function GetSqlForTables: string; virtual;
    function GetSqlForViews: string; virtual;
    function GetSqlForColumns: string; virtual;
    function GetSqlForColumnConstraints: string; virtual;
    function GetSqlForIndexes: string; virtual;
    function GetSqlForIndexColumns: string; virtual;
    function GetSqlForForeignKeys: string; virtual;
    function GetSqlForForeignKeyColumns: string; virtual;
    function GetSqlForSynonyms: string; virtual;
    function GetSqlForProcedures: string; virtual;
    function GetSqlForProcedureSources: string; virtual;
    function GetSqlForProcedureParameters: string; virtual;
    function GetSqlForPackages: string; virtual;
    function GetSqlForPackageProcedures: string; virtual;
    function GetSqlForPackageProcedureParameters: string; virtual;
    function GetSqlForPackageSources: string; virtual;
    function GetSqlForUsers: string; virtual;
    function GetSqlForRoles: string; virtual;
    function GetSqlForReservedWords: string; virtual;
  private
    function CountDigits(const Version: string; const FromIndex: Integer): Integer;
    procedure AppendVersionSection(const Buffer: TStringBuilder; const Version: string; const InStart: Integer; const EndIndex: Integer; const ExpectedLength: Integer; const AddDot: Boolean);
    function MakeStandardVersionFormat(const Version: string): string;
    function FindSourceLineColumn(const Cursor: TDBXTable; const ExpectedColumns: Integer): Integer;
    procedure InitScanner;
    function ParseMetaDataCommand(const MetaDataCommand: string): TDBXMetaDataCommandParseResult;
    function ParseId: string;
    procedure ParseSqlObjectName(const Parameters: TDBXStringArray; const MaxIds: Integer);
    function ParseParameter(const CommandToken: Integer; const Command: string): TDBXMetaDataCommandParseResult;
    function ParseGetObjectName(const CommandToken: Integer; const MaxIds: Integer; const Command: string): TDBXMetaDataCommandParseResult;
    function ParseGetTables(const CommandToken: Integer; const Command: string): TDBXMetaDataCommandParseResult;
    function ParseForeignKeyColumns(const CommandToken: Integer; const Command: string): TDBXMetaDataCommandParseResult;
    function ParseIndexColumns(const CommandToken: Integer; const Command: string): TDBXMetaDataCommandParseResult;
    function ParseProcedures(const CommandToken: Integer; const MaxIds: Integer; const Command: string): TDBXMetaDataCommandParseResult;
    function ParseProcedureParameters(const CommandToken: Integer; const MaxIds: Integer; const Command: string): TDBXMetaDataCommandParseResult;
    function ParseDone(const CommandToken: Integer; const Command: string; const Parameters: TDBXStringArray): TDBXMetaDataCommandParseResult;
  private
    FContext: TDBXProviderContext;
    FDataTypeHash: TDBXObjectStore;
    FScanner: TDBXSqlScanner;
    FVersion: string;
    FTypes: TDBXArrayList;
  public
    property SqlDefaultParameterMarker: string read GetSqlDefaultParameterMarker;
    property TableType: string read GetTableType;
    property ViewType: string read GetViewType;
    property SystemTableType: string read GetSystemTableType;
    property SystemViewType: string read GetSystemViewType;
    property SynonymType: string read GetSynonymType;
    property DataTypeHash: TDBXObjectStore read GetDataTypeHash;
    property DataTypes: TDBXArrayList read GetDataTypes;
  protected
    property DataTypeDescriptions: TDBXDataTypeDescriptionArray read GetDataTypeDescriptions;
    property ReservedWords: TDBXStringArray read GetReservedWords;
    property SqlForDataTypes: string read GetSqlForDataTypes;
    property SqlForCatalogs: string read GetSqlForCatalogs;
    property SqlForSchemas: string read GetSqlForSchemas;
    property SqlForTables: string read GetSqlForTables;
    property SqlForViews: string read GetSqlForViews;
    property SqlForColumns: string read GetSqlForColumns;
    property SqlForColumnConstraints: string read GetSqlForColumnConstraints;
    property SqlForIndexes: string read GetSqlForIndexes;
    property SqlForIndexColumns: string read GetSqlForIndexColumns;
    property SqlForForeignKeys: string read GetSqlForForeignKeys;
    property SqlForForeignKeyColumns: string read GetSqlForForeignKeyColumns;
    property SqlForSynonyms: string read GetSqlForSynonyms;
    property SqlForProcedures: string read GetSqlForProcedures;
    property SqlForProcedureSources: string read GetSqlForProcedureSources;
    property SqlForProcedureParameters: string read GetSqlForProcedureParameters;
    property SqlForPackages: string read GetSqlForPackages;
    property SqlForPackageProcedures: string read GetSqlForPackageProcedures;
    property SqlForPackageProcedureParameters: string read GetSqlForPackageProcedureParameters;
    property SqlForPackageSources: string read GetSqlForPackageSources;
    property SqlForUsers: string read GetSqlForUsers;
    property SqlForRoles: string read GetSqlForRoles;
    property SqlForReservedWords: string read GetSqlForReservedWords;
  private
    const SourceLineNumber = 'SOURCE_LINE_NUMBER';
    const Colon = ':';
    const Dot = '.';
    const DoubleQuote = '"';
    const TokenDatabase = 500;
    const TokenTable = 501;
    const TokenView = 502;
    const TokenSystemTable = 503;
    const TokenSystemView = 504;
    const TokenSynonym = 505;
    const TokenProcedureType = 506;
    const TokenFunctionType = 507;
    const TokenPrimaryKey = 508;
    const TokenForeignKey = 509;
  end;

  TDBXParameterName = class
  public
    const DefaultMarker = ':';
    const CatalogName = 'CATALOG_NAME';
    const SchemaName = 'SCHEMA_NAME';
    const TableName = 'TABLE_NAME';
    const NewSchemaName = 'NEW_SCHEMA_NAME';
    const NewTableName = 'NEW_TABLE_NAME';
    const Tables = 'TABLES';
    const Views = 'VIEWS';
    const SystemTables = 'SYSTEM_TABLES';
    const SystemViews = 'SYSTEM_VIEWS';
    const Synonyms = 'SYNONYMS';
    const ViewName = 'VIEW_NAME';
    const IndexName = 'INDEX_NAME';
    const ForeignKeyName = 'FOREIGN_KEY_NAME';
    const PrimaryCatalogName = 'PRIMARY_CATALOG_NAME';
    const PrimarySchemaName = 'PRIMARY_SCHEMA_NAME';
    const PrimaryTableName = 'PRIMARY_TABLE_NAME';
    const PrimaryKeyName = 'PRIMARY_KEY_NAME';
    const SynonymName = 'SYNONYM_NAME';
    const ProcedureType = 'PROCEDURE_TYPE';
    const ProcedureName = 'PROCEDURE_NAME';
    const PackageName = 'PACKAGE_NAME';
    const ParameterName = 'PARAMETER_NAME';
  end;

  TDBXPlatformTypeNames = class abstract
  public
    function GetPlatformTypeName(const DataType: Integer; const IsUnsigned: Boolean): string; virtual; abstract;
  end;

  TDBXProcedureType = class
  public
    const ProcedureType = 'PROCEDURE';
    const FunctionType = 'FUNCTION';
  end;

  TDBXProviderContext = class abstract(TDBXPlatformTypeNames)
  public
    function ExecuteQuery(const Sql: string; const ParameterNames: TDBXStringArray; const ParameterValues: TDBXStringArray): TDBXTable; virtual; abstract;
    function CreateTableStorage(const MetaDataCollectionName: string; const Columns: TDBXValueTypeArray): TDBXTable; virtual; abstract;
    function CreateRowStorage(const MetaDataCollectionName: string; const Columns: TDBXValueTypeArray): TDBXTableRow; virtual; abstract;
    procedure StartSerializedTransaction; virtual; abstract;
    procedure StartTransaction; virtual; abstract;
    procedure Commit; virtual; abstract;
    procedure Rollback; virtual; abstract;
    function GetVendorProperty(const Name: string): string; virtual; abstract;
    class function UseAnsiString(const ProductName: string): Boolean; static;
  end;

  TDBXReservedWordsCursor = class(TDBXTable)
  public
    constructor Create(const TypeNames: TDBXPlatformTypeNames; const Columns: TDBXValueTypeArray; const Keywords: TDBXStringArray);
    function GetOrdinal(const Name: string): Integer; override;
    destructor Destroy; override;
    function First: Boolean; override;
    function Next: Boolean; override;
    function InBounds: Boolean; override;
    procedure Close; override;
  protected
    function GetDBXTableName: string; override;
    function GetColumns: TDBXValueTypeArray; override;
    function GetWritableValue(const Ordinal: Integer): TDBXWritableValue; override;
  protected
    [Weak]FTypeNames: TDBXPlatformTypeNames;
    FKeywords: TDBXStringArray;
    FRowIndex: Integer;
  private
    FReservedRow: TDBXSingleValueRow;
  end;

  TDBXSourceTableCursor = class(TDBXCustomMetaDataTable)
  public
    constructor Create(const Context: TDBXProviderContext; const MetaDataCollectionName: string; const Columns: TDBXValueTypeArray; const Cursor: TDBXTable; const OrdinalDefinition: Integer; const OrdinalLineNumber: Integer);
    destructor Destroy; override;
    function Next: Boolean; override;
  protected
    function GetWritableValue(const Ordinal: Integer): TDBXWritableValue; override;
  private
    FRowStorage: TDBXSingleValueRow;
    FBuffer: TStringBuilder;
    FOrdinalLineNumber: Integer;
    FOrdinalDefinition: Integer;
    FBeforeEnd: Boolean;
    FBeforeFirst: Boolean;
  end;

  TDBXTableType = class
  public
    const Table = 'TABLE';
    const View = 'VIEW';
    const Synonym = 'SYNONYM';
    const SystemTable = 'SYSTEM TABLE';
    const SystemView = 'SYSTEM VIEW';
  end;

  TDBXTableTypeFlag = class
  public
    const Table = 1;
    const View = 2;
    const SystemTable = 4;
    const SystemView = 8;
    const Synonym = 16;
    const All = 31;
  end;

  TDBXTableTypeParser = class
  public
    class function ParseTableTypes(const TableTypes: string): Integer; static;
  end;

  TDBXTypeFlag = class
  public
    const AutoIncrementable = 1;
    const BestMatch = 2;
    const FixedLength = 4;
    const CaseSensitive = 8;
    const FixedPrecisionScale = 16;
    const Long = 32;
    const Nullable = 64;
    const Searchable = 128;
    const SearchableWithLike = 256;
    const Unsigned = 512;
    const ConcurrencyType = 1024;
    const LiteralSupported = 2048;
    const Unicode = 4096;
    const UnicodeOption = 8192;
    const UnsignedOption = 16384;
    const StringOption = 32768;
    const LongOption = 65536;
  end;

  TDBXVersion = class
  public
    const FMySQL4_1 = '04.01.0000';
    const FMySQL5 = '05.00.0000';
    const FMySQL5_0_6 = '05.00.0006';
    const FVersion10 = '10.00.0000';
  end;

  TDBXMetaDataError = class(TDBXError)
  public
    constructor Create(const Message: string);
  end;

implementation

uses
  Data.DBXMetaDataNames,
  Data.DBXMetaDataProvider,
  System.Math,
  Data.DBXCommonResStrs
{$IFDEF MACOS}
  , Macapi.CoreFoundation
{$ENDIF MACOS}
;

constructor TDBXColumnsTableCursor.Create;
begin
  inherited Create;
end;

constructor TDBXColumnsTableCursor.Create(const Reader: TDBXBaseMetaDataReader; const CheckBase: Boolean; const Cursor: TDBXTable);
var
  DataTypeColumns: TDBXValueTypeArray;
  Ordinal: Integer;
begin
  inherited Create;
  Table := Cursor;
  FDataTypeHash := Reader.DataTypeHash;
  FReader := Reader;
  FCheckBase := CheckBase;
  FOrdinalOffset := 0;
  FOrdinalTypeName := TDBXColumnsIndex.TypeName;
  if (DBXTableName = TDBXMetaDataCollectionName.ProcedureParameters) then
  begin
    FOrdinalOffset := TDBXColumnsIndex.DbxDataType - TDBXProcedureParametersIndex.DbxDataType;
    FOrdinalTypeName := TDBXProcedureParametersIndex.TypeName;
  end
  else if (DBXTableName = TDBXMetaDataCollectionName.PackageProcedureParameters) then
  begin
    FOrdinalOffset := TDBXColumnsIndex.DbxDataType - TDBXPackageProcedureParametersIndex.DbxDataType;
    FOrdinalTypeName := TDBXPackageProcedureParametersIndex.TypeName;
  end;
  SetLength(DataTypeColumns,TDBXColumnsIndex.Last - TDBXColumnsIndex.DbxDataType + 1);
  for Ordinal := 0 to Length(DataTypeColumns) - 1 do
    DataTypeColumns[Ordinal] := TDBXValueType(Cursor.Columns[Ordinal + TDBXColumnsIndex.DbxDataType - FOrdinalOffset].Clone());
  FDataTypesRow := TDBXSingleValueRow.Create;
  FDataTypesRow.Columns := DataTypeColumns;
end;

destructor TDBXColumnsTableCursor.Destroy;
begin
  FreeAndNil(FDataTypesRow);
  inherited Destroy;
end;

function TDBXColumnsTableCursor.Next: Boolean;
var
  ReturnValue: Boolean;
begin
  ReturnValue := inherited Next;
  if ReturnValue then
  begin
    FDataType := TDBXDataTypeDescription(FDataTypeHash[inherited GetWritableValue(FOrdinalTypeName).AsString]);
    if FDataType = nil then
    begin
      FDataTypesRow.Value[0].AsInt32 := TDBXDataTypes.UnknownType;
      FDataTypesRow.Value[TDBXColumnsIndex.IsFixedLength - TDBXColumnsIndex.DbxDataType].AsBoolean := False;
      FDataTypesRow.Value[TDBXColumnsIndex.IsUnicode - TDBXColumnsIndex.DbxDataType].AsBoolean := False;
      FDataTypesRow.Value[TDBXColumnsIndex.IsLong - TDBXColumnsIndex.DbxDataType].AsBoolean := False;
      FDataTypesRow.Value[TDBXColumnsIndex.IsUnsigned - TDBXColumnsIndex.DbxDataType].AsBoolean := False;
    end
    else 
    begin
      FDataTypesRow.Value[0].AsInt32 := FDataType.DbxDataType;
      FDataTypesRow.Value[TDBXColumnsIndex.IsFixedLength - TDBXColumnsIndex.DbxDataType].AsBoolean := FDataType.FixedLength;
      FDataTypesRow.Value[TDBXColumnsIndex.IsUnicode - TDBXColumnsIndex.DbxDataType].AsBoolean := FDataType.Unicode;
      FDataTypesRow.Value[TDBXColumnsIndex.IsLong - TDBXColumnsIndex.DbxDataType].AsBoolean := FDataType.Long;
      FDataTypesRow.Value[TDBXColumnsIndex.IsUnsigned - TDBXColumnsIndex.DbxDataType].AsBoolean := FDataType.Unsigned;
    end;
  end;
  Result := ReturnValue;
end;

function TDBXColumnsTableCursor.GetWritableValue(const Ordinal: Integer): TDBXWritableValue;
begin
  if Ordinal + FOrdinalOffset >= TDBXColumnsIndex.DbxDataType then
    Result := FDataTypesRow.Value[Ordinal - (TDBXColumnsIndex.DbxDataType - FOrdinalOffset)]
  else 
    Result := inherited GetWritableValue(Ordinal);
end;

constructor TDBXCustomMetaDataTable.Create(const TypeNames: TDBXPlatformTypeNames; const MetaDataCollectionName: string; const Columns: TDBXValueTypeArray; const Cursor: TDBXTable);
begin
  inherited Create(nil, nil);
  FTypeNames := TypeNames;
  FMetaDataCollectionName := MetaDataCollectionName;
  FCursor := Cursor;
  FColumns := Columns;
  if (MetaDataCollectionName = TDBXMetaDataCollectionName.Columns) then
    FHasIndexColumn := True;
end;

destructor TDBXCustomMetaDataTable.Destroy;
begin
  FreeAndNil(FCursor);
  FreeObjectArray(TDBXFreeArray(FColumns));
  inherited Destroy;
end;

function TDBXCustomMetaDataTable.GetCommand: TObject;
begin
  if FCursor = nil then
    Result := nil
  else 
    Result := FCursor.Command;
end;

function TDBXCustomMetaDataTable.FindStringSize(const Ordinal: Integer; const SourceColumns: TDBXValueTypeArray): Integer;
begin
  Result := FindStringSize(SourceColumns[Ordinal]);
end;

function TDBXCustomMetaDataTable.FindStringSize(const Column: TDBXValueType): Integer;
begin
  case Column.DataType of
    TDBXDataTypes.WideStringType:
      Result := Column.Size;
    TDBXDataTypes.AnsiStringType:
      Result := 2 * Column.Size;
    TDBXDataTypes.Int8Type:
      Result := 4;
    TDBXDataTypes.Int16Type:
      Result := 6;
    TDBXDataTypes.Int32Type:
      Result := 11;
    TDBXDataTypes.Int64Type:
      Result := 20;
    TDBXDataTypes.BooleanType:
      Result := 5;
    else
      Result := 0;
  end;
end;

procedure TDBXCustomMetaDataTable.AdjustColumnSize;
var
  Ordinal, StringSize: Integer;
  ValueTypes: TDBXValueTypeArray;
begin
  if FCursor <> nil then
  begin
    ValueTypes := FCursor.Columns;
    for Ordinal := 0 to Length(FColumns) - 1 do
      case FColumns[Ordinal].DataType of
        TDBXDataTypes.WideStringType:
          begin
            if ValueTypes = nil then
              StringSize := FindStringSize(FCursor.Value[Ordinal].ValueType)
            else
              if not (Ordinal >= Length(ValueTypes)) then
                StringSize := FindStringSize(Ordinal, ValueTypes)
              else
                StringSize := FColumns[Ordinal].Size;
            if StringSize > 0 then
              FColumns[Ordinal].Size := StringSize;
          end;
        TDBXDataTypes.Int8Type:
          FColumns[Ordinal].Size := 1;
        TDBXDataTypes.Int16Type:
          FColumns[Ordinal].Size := 2;
        TDBXDataTypes.Int32Type:
          FColumns[Ordinal].Size := 4;
        TDBXDataTypes.Int64Type:
          FColumns[Ordinal].Size := 8;
        TDBXDataTypes.BooleanType:
          FColumns[Ordinal].Size := 2;
      end;
  end;
end;

function TDBXCustomMetaDataTable.GetDBXTableName: string;
begin
  Result := FMetaDataCollectionName;
end;

function TDBXCustomMetaDataTable.First: Boolean;
begin
  Result := FCursor.First;
end;

function TDBXCustomMetaDataTable.Next: Boolean;
begin
  Result := FCursor.Next;
end;

function TDBXCustomMetaDataTable.InBounds: Boolean;
begin
  Result := FCursor.InBounds;
end;

procedure TDBXCustomMetaDataTable.Close;
begin
  if FCursor <> nil then
  begin
    FCursor.Close;
    FreeAndNil(FCursor);
  end;
end;

function TDBXCustomMetaDataTable.GetColumns: TDBXValueTypeArray;
begin
  if not FColumnsSizeAdjusted then
  begin
    AdjustColumnSize;
    FColumnsSizeAdjusted := True;
  end;
  Result := FColumns;
end;

procedure TDBXCustomMetaDataTable.CheckColumn(const Ordinal: Integer);
begin
  if (Ordinal < 0) or (Ordinal > Length(FColumns)) then
    raise TDBXMetaDataError.Create(SOrdinalOutOfRange);
end;

function TDBXCustomMetaDataTable.GetWritableValue(const Ordinal: Integer): TDBXWritableValue;
begin
  CheckColumn(Ordinal);
  Result := FCursor.Value[Ordinal];
end;

function TDBXCustomMetaDataTable.GetOrdinal(const ColumnName: string): Integer;
begin
  Result := FCursor.GetOrdinal(ColumnName);
end;

function TDBXCustomMetaDataTable.GetInt32(const Cursor: TDBXTable; const Ordinal: Integer; const DefaultValue: Integer): Integer;
var
  Value: TDBXWritableValue;
begin
  Value := Cursor.Value[Ordinal];
  if Value.IsNull then
    Exit(DefaultValue);
  Result := Value.AsInt32;
end;

function TDBXCustomMetaDataTable.GetInt64(const Cursor: TDBXTable; const Ordinal: Integer; const DefaultValue: Int64): Int64;
var
  Value: TDBXWritableValue;
begin
  Value := Cursor.Value[Ordinal];
  if Value.IsNull then
    Exit(DefaultValue);
  Result := Value.AsInt64;
end;

function TDBXCustomMetaDataTable.GetAsString(const Cursor: TDBXTable; const Ordinal: Integer; const DefaultValue: string): string;
var
  Value: TDBXWritableValue;
begin
  Value := Cursor.Value[Ordinal];
  if Value.IsNull then
    Exit(DefaultValue);
  Result := Value.AsString;
end;

function TDBXCustomMetaDataTable.GetBoolean(const Cursor: TDBXTable; const Ordinal: Integer; const DefaultValue: Boolean): Boolean;
var
  Value: TDBXWritableValue;
begin
  Value := Cursor.Value[Ordinal];
  if Value.IsNull then
    Exit(DefaultValue);
  Result := Value.GetBoolean;
end;

constructor TDBXDataTypeCursor.Create(const Reader: TDBXBaseMetaDataReader; const Columns: TDBXValueTypeArray; const Types: TDBXArrayList);
begin
  inherited Create(nil, nil);
  FReader := Reader;
  FTypes := Types;
  FTypeRow := TDBXSingleValueRow.Create;
  FTypeRow.Columns := Columns;
  FRowIndex := -1;
end;

destructor TDBXDataTypeCursor.Destroy;
begin
  FreeAndNil(FTypeRow);
  inherited Destroy;
end;

function TDBXDataTypeCursor.GetOrdinal(const Name: string): Integer;
begin
  Result := FTypeRow.GetOrdinal(Name);
end;

function TDBXDataTypeCursor.GetDBXTableName: string;
begin
  Result := TDBXMetaDataCollectionName.DataTypes;
end;

function TDBXDataTypeCursor.GetColumns: TDBXValueTypeArray;
begin
  Result := FTypeRow.Columns;
end;

procedure TDBXDataTypeCursor.Close;
begin
end;

function TDBXDataTypeCursor.First: Boolean;
begin
  FRowIndex := 0;
  Result := FRowIndex < FTypes.Count;
end;

function TDBXDataTypeCursor.GetWritableValue(const Ordinal: Integer): TDBXWritableValue;
begin
  if FRowIndex < 0 then
    raise TDBXMetaDataError.Create(SMustCallNextFirst);
  if FRowIndex >= FTypes.Count then
    raise TDBXMetaDataError.Create(SPastEndOfCursor);
  Result := FTypeRow.Value[Ordinal];
end;

function TDBXDataTypeCursor.InBounds: Boolean;
begin
  Result := FRowIndex < FTypes.Count;
end;

function TDBXDataTypeCursor.Next: Boolean;
begin
  IncrAfter(FRowIndex);
  if FRowIndex >= FTypes.Count then
    Exit(False);
  FCurrent := TDBXDataTypeDescription(FTypes[FRowIndex]);
  FTypeRow.Value[TDBXDataTypesIndex.TypeName].AsString := FCurrent.TypeName;
  FTypeRow.Value[TDBXDataTypesIndex.CreateFormat].AsString := FCurrent.CreateFormat;
  FTypeRow.Value[TDBXDataTypesIndex.CreateParameters].AsString := FCurrent.CreateParameters;
  FTypeRow.Value[TDBXDataTypesIndex.DataType].AsString := FCurrent.GetDataType(FReader.Context);
  FTypeRow.Value[TDBXDataTypesIndex.MaximumVersion].AsString := FCurrent.MaximumVersion;
  FTypeRow.Value[TDBXDataTypesIndex.MinimumVersion].AsString := FCurrent.MinimumVersion;
  FTypeRow.Value[TDBXDataTypesIndex.LiteralPrefix].AsString := FCurrent.LiteralPrefix;
  FTypeRow.Value[TDBXDataTypesIndex.LiteralSuffix].AsString := FCurrent.LiteralSuffix;
  FTypeRow.Value[TDBXDataTypesIndex.MaximumScale].SetInt16(FCurrent.MaximumScale);
  FTypeRow.Value[TDBXDataTypesIndex.MinimumScale].SetInt16(FCurrent.MinimumScale);
  FTypeRow.Value[TDBXDataTypesIndex.DbxDataType].AsInt32 := FCurrent.DbxDataType;
  FTypeRow.Value[TDBXDataTypesIndex.ProviderDbType].AsInt32 := FCurrent.DbxDataType;
  FTypeRow.Value[TDBXDataTypesIndex.ColumnSize].SetInt64(FCurrent.ColumnSize);
  FTypeRow.Value[TDBXDataTypesIndex.IsAutoIncrementable].AsBoolean := FCurrent.AutoIncrementable;
  FTypeRow.Value[TDBXDataTypesIndex.IsBestMatch].AsBoolean := FCurrent.BestMatch;
  FTypeRow.Value[TDBXDataTypesIndex.IsCaseSensitive].AsBoolean := FCurrent.CaseSensitive;
  FTypeRow.Value[TDBXDataTypesIndex.IsFixedLength].AsBoolean := FCurrent.FixedLength;
  FTypeRow.Value[TDBXDataTypesIndex.IsFixedPrecisionScale].AsBoolean := FCurrent.FixedPrecisionScale;
  FTypeRow.Value[TDBXDataTypesIndex.IsLong].AsBoolean := FCurrent.Long;
  FTypeRow.Value[TDBXDataTypesIndex.IsNullable].AsBoolean := FCurrent.Nullable;
  FTypeRow.Value[TDBXDataTypesIndex.IsSearchable].AsBoolean := FCurrent.Searchable;
  FTypeRow.Value[TDBXDataTypesIndex.IsSearchableWithLike].AsBoolean := FCurrent.SearchableWithLike;
  FTypeRow.Value[TDBXDataTypesIndex.IsUnsigned].AsBoolean := FCurrent.Unsigned;
  FTypeRow.Value[TDBXDataTypesIndex.IsConcurrencyType].AsBoolean := FCurrent.ConcurrencyType;
  FTypeRow.Value[TDBXDataTypesIndex.IsLiteralSupported].AsBoolean := FCurrent.LiteralSupported;
  FTypeRow.Value[TDBXDataTypesIndex.IsUnicode].AsBoolean := FCurrent.Unicode;
  Result := True;
end;

constructor TDBXDataTypeDescription.Create(const TypeName: string; const DataType: Integer; const ColumnSize: Int64; const CreateFormat: string; const CreateParams: string; const MaxScale: Integer; const MinScale: Integer; const LiteralPrefix: string; const LiteralSuffix: string; const MaxVersion: string; const MinVersion: string; const Flags: Integer);
begin
  inherited Create;
  FTypeName := TypeName;
  FDataType := DataType;
  FColumnSize := ColumnSize;
  FMaxVersion := MaxVersion;
  FMinVersion := MinVersion;
  FFlags := Flags;
  FCreateFormat := CreateFormat;
  FCreateParams := CreateParams;
  FLiteralPrefix := LiteralPrefix;
  FLiteralSuffix := LiteralSuffix;
  FMaxScale := MaxScale;
  FMinScale := MinScale;
end;

constructor TDBXDataTypeDescription.Create(const Original: TDBXDataTypeDescription);
begin
  inherited Create;
  FTypeName := Original.FTypeName;
  FDataType := Original.FDataType;
  FColumnSize := Original.FColumnSize;
  FMaxVersion := Original.FMaxVersion;
  FMinVersion := Original.FMinVersion;
  FFlags := Original.FFlags;
  FCreateFormat := Original.FCreateFormat;
  FCreateParams := Original.FCreateParams;
  FLiteralPrefix := Original.FLiteralPrefix;
  FLiteralSuffix := Original.FLiteralSuffix;
  FMaxScale := Original.FMaxScale;
  FMinScale := Original.FMinScale;
end;

function TDBXDataTypeDescription.GetDataType(const TypeNames: TDBXPlatformTypeNames): string;
begin
  Result := TypeNames.GetPlatformTypeName(FDataType, Unsigned);
end;

function TDBXDataTypeDescription.IsFlagSet(const Flag: Integer): Boolean;
begin
  Result := (FFlags and Flag) = Flag;
end;

procedure TDBXDataTypeDescription.SetFlag(const bOn: Boolean; const Flag: Integer);
begin
  if bOn then
    FFlags := FFlags or Flag
  else 
    FFlags := FFlags and not Flag;
end;

function TDBXDataTypeDescription.IsAutoIncrementable: Boolean;
begin
  Result := IsFlagSet(TDBXTypeFlag.AutoIncrementable);
end;

function TDBXDataTypeDescription.IsBestMatch: Boolean;
begin
  Result := IsFlagSet(TDBXTypeFlag.BestMatch);
end;

function TDBXDataTypeDescription.IsCaseSensitive: Boolean;
begin
  Result := IsFlagSet(TDBXTypeFlag.CaseSensitive);
end;

function TDBXDataTypeDescription.IsFixedLength: Boolean;
begin
  Result := IsFlagSet(TDBXTypeFlag.FixedLength);
end;

function TDBXDataTypeDescription.IsFixedPrecisionScale: Boolean;
begin
  Result := IsFlagSet(TDBXTypeFlag.FixedPrecisionScale);
end;

function TDBXDataTypeDescription.IsLong: Boolean;
begin
  Result := IsFlagSet(TDBXTypeFlag.Long);
end;

function TDBXDataTypeDescription.IsNullable: Boolean;
begin
  Result := IsFlagSet(TDBXTypeFlag.Nullable);
end;

function TDBXDataTypeDescription.IsSearchable: Boolean;
begin
  Result := IsFlagSet(TDBXTypeFlag.Searchable);
end;

function TDBXDataTypeDescription.IsSearchableWithLike: Boolean;
begin
  Result := IsFlagSet(TDBXTypeFlag.SearchableWithLike);
end;

function TDBXDataTypeDescription.IsUnsigned: Boolean;
begin
  Result := IsFlagSet(TDBXTypeFlag.Unsigned);
end;

function TDBXDataTypeDescription.IsUnicode: Boolean;
begin
  Result := IsFlagSet(TDBXTypeFlag.Unicode);
end;

function TDBXDataTypeDescription.IsUnicodeOptionSupported: Boolean;
begin
  Result := IsFlagSet(TDBXTypeFlag.UnicodeOption);
end;

procedure TDBXDataTypeDescription.SetUnicodeOptionSupported(const Supported: Boolean);
begin
  SetFlag(Supported, TDBXTypeFlag.UnicodeOption);
end;

function TDBXDataTypeDescription.IsUnsignedOptionSupported: Boolean;
begin
  Result := IsFlagSet(TDBXTypeFlag.UnsignedOption);
end;

function TDBXDataTypeDescription.IsStringOptionSupported: Boolean;
begin
  Result := IsFlagSet(TDBXTypeFlag.StringOption);
end;

function TDBXDataTypeDescription.IsLongOptionSupported: Boolean;
begin
  Result := IsFlagSet(TDBXTypeFlag.LongOption);
end;

function TDBXDataTypeDescription.GetMaximumScale: SmallInt;
begin
  Result := SmallInt(FMaxScale);
end;

function TDBXDataTypeDescription.GetMinimumScale: SmallInt;
begin
  Result := SmallInt(FMinScale);
end;

function TDBXDataTypeDescription.IsConcurrencyType: Boolean;
begin
  Result := IsFlagSet(TDBXTypeFlag.ConcurrencyType);
end;

function TDBXDataTypeDescription.IsLiteralSupported: Boolean;
begin
  Result := IsFlagSet(TDBXTypeFlag.LiteralSupported);
end;

constructor TDBXEmptyTableCursor.Create(const MetaDataCollectionName: string; const Columns: TDBXValueTypeArray);
begin
  inherited Create(nil);
  FColumns := Columns;
  FMetaDataCollectionName := MetaDataCollectionName;
end;

function TDBXEmptyTableCursor.IsUpdateable: Boolean;
begin
  Result := False;
end;

destructor TDBXEmptyTableCursor.Destroy;
begin
  FreeObjectArray(TDBXFreeArray(FColumns));
  inherited Destroy;
end;

function TDBXEmptyTableCursor.GetDBXTableName: string;
begin
  Result := FMetaDataCollectionName;
end;

function TDBXEmptyTableCursor.GetOrdinal(const ColumnName: string): Integer;
begin
  raise Exception.Create(SUnsupportedOperation);
end;

function TDBXEmptyTableCursor.GetWritableValue(const Ordinal: Integer): TDBXWritableValue;
begin
  Result := nil;
end;

function TDBXEmptyTableCursor.GetColumns: TDBXValueTypeArray;
begin
  Result := FColumns;
end;

function TDBXEmptyTableCursor.First: Boolean;
begin
  Result := False;
end;

function TDBXEmptyTableCursor.InBounds: Boolean;
begin
  Result := False;
end;

function TDBXEmptyTableCursor.Next: Boolean;
begin
  Result := False;
end;

procedure TDBXEmptyTableCursor.Close;
begin
end;

class function TDBXMetaDataCollectionColumns.CreateValueType(const ColumnName: string; const ColumnCaption: string; const ColumnType: Integer): TDBXValueType;
var
  ValueType: TDBXValueType;
begin
  ValueType := TDBXValueType.Create;
  ValueType.Name := ColumnName;
  ValueType.DisplayName := ColumnCaption;
  ValueType.DataType := ColumnType;
  ValueType.Size := DefaultDataSize(ColumnType);
  ValueType.Nullable := True;
  Result := ValueType;
end;

class function TDBXMetaDataCollectionColumns.CreateValueType(const ColumnName: string; const ColumnCaption: string; const ColumnType: Integer; const Hidden: Boolean): TDBXValueType;
var
  ValueType: TDBXValueType;
begin
  ValueType := TDBXValueType.Create;
  ValueType.Name := ColumnName;
  ValueType.DisplayName := ColumnCaption;
  ValueType.DataType := ColumnType;
  ValueType.Size := DefaultDataSize(ColumnType);
  ValueType.Hidden := Hidden;
  Result := ValueType;
end;

class function TDBXMetaDataCollectionColumns.DefaultDataSize(const ColumnType: Integer): Integer;
begin
  case ColumnType of
    TDBXDataTypes.BooleanType,
    TDBXDataTypes.Int8Type:
      Result := 1;
    TDBXDataTypes.Int16Type:
      Result := 2;
    TDBXDataTypes.Int32Type:
      Result := 4;
    TDBXDataTypes.Int64Type:
      Result := 8;
    TDBXDataTypes.WideStringType:
      Result := DefaultWideDataSize;
    TDBXDataTypes.AnsiStringType:
      Result := DefaultAnsiDataSize;
    else
      Result := 0;
  end;
end;

class function TDBXMetaDataCollectionColumns.CreateDataTypesColumns: TDBXValueTypeArray;
var
  Columns: TDBXValueTypeArray;
begin
  SetLength(Columns,26);
  Columns[0] := CreateValueType(TDBXDataTypesColumns.TypeName, STypeName, TDBXDataTypes.WideStringType);
  Columns[1] := CreateValueType(TDBXDataTypesColumns.DbxDataType, SDbxDataType, TDBXDataTypes.Int32Type);
  Columns[2] := CreateValueType(TDBXDataTypesColumns.ColumnSize, SColumnSize, TDBXDataTypes.Int64Type);
  Columns[3] := CreateValueType(TDBXDataTypesColumns.CreateFormat, SCreateFormat, TDBXDataTypes.WideStringType);
  Columns[4] := CreateValueType(TDBXDataTypesColumns.CreateParameters, SCreateParameters, TDBXDataTypes.WideStringType);
  Columns[5] := CreateValueType(TDBXDataTypesColumns.DataType, SDataType, TDBXDataTypes.WideStringType);
  Columns[6] := CreateValueType(TDBXDataTypesColumns.IsAutoIncrementable, SIsAutoIncrementable, TDBXDataTypes.BooleanType);
  Columns[7] := CreateValueType(TDBXDataTypesColumns.IsBestMatch, SIsBestMatch, TDBXDataTypes.BooleanType);
  Columns[8] := CreateValueType(TDBXDataTypesColumns.IsCaseSensitive, SIsCaseSensitive, TDBXDataTypes.BooleanType);
  Columns[9] := CreateValueType(TDBXDataTypesColumns.IsFixedLength, SIsFixedLength, TDBXDataTypes.BooleanType);
  Columns[10] := CreateValueType(TDBXDataTypesColumns.IsFixedPrecisionScale, SIsFixedPrecisionScale, TDBXDataTypes.BooleanType);
  Columns[11] := CreateValueType(TDBXDataTypesColumns.IsLong, SIsLong, TDBXDataTypes.BooleanType);
  Columns[12] := CreateValueType(TDBXDataTypesColumns.IsNullable, SIsNullable, TDBXDataTypes.BooleanType);
  Columns[13] := CreateValueType(TDBXDataTypesColumns.IsSearchable, SIsSearchable, TDBXDataTypes.BooleanType);
  Columns[14] := CreateValueType(TDBXDataTypesColumns.IsSearchableWithLike, SIsSearchableWithLike, TDBXDataTypes.BooleanType);
  Columns[15] := CreateValueType(TDBXDataTypesColumns.IsUnsigned, SIsUnsigned, TDBXDataTypes.BooleanType);
  Columns[16] := CreateValueType(TDBXDataTypesColumns.MaximumScale, SMaximumScale, TDBXDataTypes.Int16Type);
  Columns[17] := CreateValueType(TDBXDataTypesColumns.MinimumScale, SMinimumScale, TDBXDataTypes.Int16Type);
  Columns[18] := CreateValueType(TDBXDataTypesColumns.IsConcurrencyType, SIsConcurrencyType, TDBXDataTypes.BooleanType);
  Columns[19] := CreateValueType(TDBXDataTypesColumns.MaximumVersion, SMaximumVersion, TDBXDataTypes.WideStringType);
  Columns[20] := CreateValueType(TDBXDataTypesColumns.MinimumVersion, SMinimumVersion, TDBXDataTypes.WideStringType);
  Columns[21] := CreateValueType(TDBXDataTypesColumns.IsLiteralSupported, SIsLiteralSupported, TDBXDataTypes.BooleanType);
  Columns[22] := CreateValueType(TDBXDataTypesColumns.LiteralPrefix, SLiteralPrefix, TDBXDataTypes.WideStringType);
  Columns[23] := CreateValueType(TDBXDataTypesColumns.LiteralSuffix, SLiteralSuffix, TDBXDataTypes.WideStringType);
  Columns[24] := CreateValueType(TDBXDataTypesColumns.IsUnicode, SIsUnicode, TDBXDataTypes.BooleanType);
  Columns[25] := CreateValueType(TDBXDataTypesColumns.ProviderDbType, SProviderDbType, TDBXDataTypes.Int32Type, True);
  Result := Columns;
end;

class function TDBXMetaDataCollectionColumns.CreateCatalogsColumns: TDBXValueTypeArray;
var
  Columns: TDBXValueTypeArray;
begin
  SetLength(Columns,1);
  Columns[0] := CreateValueType(TDBXCatalogsColumns.CatalogName, SCatalogName, TDBXDataTypes.WideStringType);
  Result := Columns;
end;

class function TDBXMetaDataCollectionColumns.CreateSchemasColumns: TDBXValueTypeArray;
var
  Columns: TDBXValueTypeArray;
begin
  SetLength(Columns,2);
  Columns[0] := CreateValueType(TDBXSchemasColumns.CatalogName, SCatalogName, TDBXDataTypes.WideStringType);
  Columns[1] := CreateValueType(TDBXSchemasColumns.SchemaName, SSchemaName, TDBXDataTypes.WideStringType);
  Result := Columns;
end;

class function TDBXMetaDataCollectionColumns.CreateTablesColumns: TDBXValueTypeArray;
var
  Columns: TDBXValueTypeArray;
begin
  SetLength(Columns,4);
  Columns[0] := CreateValueType(TDBXTablesColumns.CatalogName, SCatalogName, TDBXDataTypes.WideStringType);
  Columns[1] := CreateValueType(TDBXTablesColumns.SchemaName, SSchemaName, TDBXDataTypes.WideStringType);
  Columns[2] := CreateValueType(TDBXTablesColumns.TableName, STableName, TDBXDataTypes.WideStringType);
  Columns[3] := CreateValueType(TDBXTablesColumns.TableType, STableType, TDBXDataTypes.WideStringType);
  Result := Columns;
end;

class function TDBXMetaDataCollectionColumns.CreateViewsColumns: TDBXValueTypeArray;
var
  Columns: TDBXValueTypeArray;
begin
  SetLength(Columns,4);
  Columns[0] := CreateValueType(TDBXViewsColumns.CatalogName, SCatalogName, TDBXDataTypes.WideStringType);
  Columns[1] := CreateValueType(TDBXViewsColumns.SchemaName, SSchemaName, TDBXDataTypes.WideStringType);
  Columns[2] := CreateValueType(TDBXViewsColumns.ViewName, SViewName, TDBXDataTypes.WideStringType);
  Columns[3] := CreateValueType(TDBXViewsColumns.Definition, SDefinition, TDBXDataTypes.WideStringType);
  Result := Columns;
end;

class function TDBXMetaDataCollectionColumns.CreateSynonymsColumns: TDBXValueTypeArray;
var
  Columns: TDBXValueTypeArray;
begin
  SetLength(Columns,6);
  Columns[0] := CreateValueType(TDBXSynonymsColumns.CatalogName, SCatalogName, TDBXDataTypes.WideStringType);
  Columns[1] := CreateValueType(TDBXSynonymsColumns.SchemaName, SSchemaName, TDBXDataTypes.WideStringType);
  Columns[2] := CreateValueType(TDBXSynonymsColumns.SynonymName, SSynonymName, TDBXDataTypes.WideStringType);
  Columns[3] := CreateValueType(TDBXSynonymsColumns.TableCatalogName, STableCatalogName, TDBXDataTypes.WideStringType);
  Columns[4] := CreateValueType(TDBXSynonymsColumns.TableSchemaName, STableSchemaName, TDBXDataTypes.WideStringType);
  Columns[5] := CreateValueType(TDBXSynonymsColumns.TableName, STableName, TDBXDataTypes.WideStringType);
  Result := Columns;
end;

class function TDBXMetaDataCollectionColumns.CreateColumnsColumns: TDBXValueTypeArray;
var
  Columns: TDBXValueTypeArray;
begin
  SetLength(Columns,17);
  Columns[0] := CreateValueType(TDBXColumnsColumns.CatalogName, SCatalogName, TDBXDataTypes.WideStringType);
  Columns[1] := CreateValueType(TDBXColumnsColumns.SchemaName, SSchemaName, TDBXDataTypes.WideStringType);
  Columns[2] := CreateValueType(TDBXColumnsColumns.TableName, STableName, TDBXDataTypes.WideStringType);
  Columns[3] := CreateValueType(TDBXColumnsColumns.ColumnName, SColumnName, TDBXDataTypes.WideStringType);
  Columns[4] := CreateValueType(TDBXColumnsColumns.TypeName, STypeName, TDBXDataTypes.WideStringType);
  Columns[5] := CreateValueType(TDBXColumnsColumns.Precision, SPrecision, TDBXDataTypes.Int64Type);
  Columns[6] := CreateValueType(TDBXColumnsColumns.Scale, SScale, TDBXDataTypes.Int32Type);
  Columns[7] := CreateValueType(TDBXColumnsColumns.Ordinal, SOrdinal, TDBXDataTypes.Int32Type);
  Columns[8] := CreateValueType(TDBXColumnsColumns.DefaultValue, SDefaultValue, TDBXDataTypes.WideStringType);
  Columns[9] := CreateValueType(TDBXColumnsColumns.IsNullable, SIsNullable, TDBXDataTypes.BooleanType);
  Columns[10] := CreateValueType(TDBXColumnsColumns.IsAutoIncrement, SIsAutoIncrement, TDBXDataTypes.BooleanType);
  Columns[11] := CreateValueType(TDBXColumnsColumns.MaxInline, SMaxInline, TDBXDataTypes.Int32Type, True);
  Columns[12] := CreateValueType(TDBXColumnsColumns.DbxDataType, SDbxDataType, TDBXDataTypes.Int32Type, True);
  Columns[13] := CreateValueType(TDBXColumnsColumns.IsFixedLength, SIsFixedLength, TDBXDataTypes.BooleanType, True);
  Columns[14] := CreateValueType(TDBXColumnsColumns.IsUnicode, SIsUnicode, TDBXDataTypes.BooleanType, True);
  Columns[15] := CreateValueType(TDBXColumnsColumns.IsLong, SIsLong, TDBXDataTypes.BooleanType, True);
  Columns[16] := CreateValueType(TDBXColumnsColumns.IsUnsigned, SIsUnsigned, TDBXDataTypes.BooleanType, True);
  Result := Columns;
end;

class function TDBXMetaDataCollectionColumns.CreateColumnConstraintsColumns: TDBXValueTypeArray;
var
  Columns: TDBXValueTypeArray;
begin
  SetLength(Columns,5);
  Columns[0] := CreateValueType(TDBXColumnConstraintsColumns.CatalogName, SCatalogName, TDBXDataTypes.WideStringType);
  Columns[1] := CreateValueType(TDBXColumnConstraintsColumns.SchemaName, SSchemaName, TDBXDataTypes.WideStringType);
  Columns[2] := CreateValueType(TDBXColumnConstraintsColumns.TableName, STableName, TDBXDataTypes.WideStringType);
  Columns[3] := CreateValueType(TDBXColumnConstraintsColumns.ConstraintName, SConstraintName, TDBXDataTypes.WideStringType);
  Columns[4] := CreateValueType(TDBXColumnConstraintsColumns.ColumnName, SColumnName, TDBXDataTypes.WideStringType);
  Result := Columns;
end;

class function TDBXMetaDataCollectionColumns.CreateIndexesColumns: TDBXValueTypeArray;
var
  Columns: TDBXValueTypeArray;
begin
  SetLength(Columns,8);
  Columns[0] := CreateValueType(TDBXIndexesColumns.CatalogName, SCatalogName, TDBXDataTypes.WideStringType);
  Columns[1] := CreateValueType(TDBXIndexesColumns.SchemaName, SSchemaName, TDBXDataTypes.WideStringType);
  Columns[2] := CreateValueType(TDBXIndexesColumns.TableName, STableName, TDBXDataTypes.WideStringType);
  Columns[3] := CreateValueType(TDBXIndexesColumns.IndexName, SIndexName, TDBXDataTypes.WideStringType);
  Columns[4] := CreateValueType(TDBXIndexesColumns.ConstraintName, SConstraintName, TDBXDataTypes.WideStringType, True);
  Columns[5] := CreateValueType(TDBXIndexesColumns.IsPrimary, SIsPrimary, TDBXDataTypes.BooleanType);
  Columns[6] := CreateValueType(TDBXIndexesColumns.IsUnique, SIsUnique, TDBXDataTypes.BooleanType);
  Columns[7] := CreateValueType(TDBXIndexesColumns.IsAscending, SIsAscending, TDBXDataTypes.BooleanType, True);
  Result := Columns;
end;

class function TDBXMetaDataCollectionColumns.CreateIndexColumnsColumns: TDBXValueTypeArray;
var
  Columns: TDBXValueTypeArray;
begin
  SetLength(Columns,7);
  Columns[0] := CreateValueType(TDBXIndexColumnsColumns.CatalogName, SCatalogName, TDBXDataTypes.WideStringType);
  Columns[1] := CreateValueType(TDBXIndexColumnsColumns.SchemaName, SSchemaName, TDBXDataTypes.WideStringType);
  Columns[2] := CreateValueType(TDBXIndexColumnsColumns.TableName, STableName, TDBXDataTypes.WideStringType);
  Columns[3] := CreateValueType(TDBXIndexColumnsColumns.IndexName, SIndexName, TDBXDataTypes.WideStringType);
  Columns[4] := CreateValueType(TDBXIndexColumnsColumns.ColumnName, SColumnName, TDBXDataTypes.WideStringType);
  Columns[5] := CreateValueType(TDBXIndexColumnsColumns.Ordinal, SOrdinal, TDBXDataTypes.Int32Type);
  Columns[6] := CreateValueType(TDBXIndexColumnsColumns.IsAscending, SIsAscending, TDBXDataTypes.BooleanType);
  Result := Columns;
end;

class function TDBXMetaDataCollectionColumns.CreateForeignKeysColumns: TDBXValueTypeArray;
var
  Columns: TDBXValueTypeArray;
begin
  SetLength(Columns,4);
  Columns[0] := CreateValueType(TDBXForeignKeysColumns.CatalogName, SCatalogName, TDBXDataTypes.WideStringType);
  Columns[1] := CreateValueType(TDBXForeignKeysColumns.SchemaName, SSchemaName, TDBXDataTypes.WideStringType);
  Columns[2] := CreateValueType(TDBXForeignKeysColumns.TableName, STableName, TDBXDataTypes.WideStringType);
  Columns[3] := CreateValueType(TDBXForeignKeysColumns.ForeignKeyName, SForeignKeyName, TDBXDataTypes.WideStringType);
  Result := Columns;
end;

class function TDBXMetaDataCollectionColumns.CreateForeignKeyColumnsColumns: TDBXValueTypeArray;
var
  Columns: TDBXValueTypeArray;
begin
  SetLength(Columns,11);
  Columns[0] := CreateValueType(TDBXForeignKeyColumnsColumns.CatalogName, SCatalogName, TDBXDataTypes.WideStringType);
  Columns[1] := CreateValueType(TDBXForeignKeyColumnsColumns.SchemaName, SSchemaName, TDBXDataTypes.WideStringType);
  Columns[2] := CreateValueType(TDBXForeignKeyColumnsColumns.TableName, STableName, TDBXDataTypes.WideStringType);
  Columns[3] := CreateValueType(TDBXForeignKeyColumnsColumns.ForeignKeyName, SForeignKeyName, TDBXDataTypes.WideStringType);
  Columns[4] := CreateValueType(TDBXForeignKeyColumnsColumns.ColumnName, SColumnName, TDBXDataTypes.WideStringType);
  Columns[5] := CreateValueType(TDBXForeignKeyColumnsColumns.PrimaryCatalogName, SPrimaryCatalogName, TDBXDataTypes.WideStringType);
  Columns[6] := CreateValueType(TDBXForeignKeyColumnsColumns.PrimarySchemaName, SPrimarySchemaName, TDBXDataTypes.WideStringType);
  Columns[7] := CreateValueType(TDBXForeignKeyColumnsColumns.PrimaryTableName, SPrimaryTableName, TDBXDataTypes.WideStringType);
  Columns[8] := CreateValueType(TDBXForeignKeyColumnsColumns.PrimaryKeyName, SPrimaryKeyName, TDBXDataTypes.WideStringType);
  Columns[9] := CreateValueType(TDBXForeignKeyColumnsColumns.PrimaryColumnName, SPrimaryColumnName, TDBXDataTypes.WideStringType);
  Columns[10] := CreateValueType(TDBXForeignKeyColumnsColumns.Ordinal, SOrdinal, TDBXDataTypes.Int32Type);
  Result := Columns;
end;

class function TDBXMetaDataCollectionColumns.CreateProceduresColumns: TDBXValueTypeArray;
var
  Columns: TDBXValueTypeArray;
begin
  SetLength(Columns,4);
  Columns[0] := CreateValueType(TDBXProceduresColumns.CatalogName, SCatalogName, TDBXDataTypes.WideStringType);
  Columns[1] := CreateValueType(TDBXProceduresColumns.SchemaName, SSchemaName, TDBXDataTypes.WideStringType);
  Columns[2] := CreateValueType(TDBXProceduresColumns.ProcedureName, SProcedureName, TDBXDataTypes.WideStringType);
  Columns[3] := CreateValueType(TDBXProceduresColumns.ProcedureType, SProcedureType, TDBXDataTypes.WideStringType);
  Result := Columns;
end;

class function TDBXMetaDataCollectionColumns.CreateProcedureSourcesColumns: TDBXValueTypeArray;
var
  Columns: TDBXValueTypeArray;
begin
  SetLength(Columns,6);
  Columns[0] := CreateValueType(TDBXProcedureSourcesColumns.CatalogName, SCatalogName, TDBXDataTypes.WideStringType);
  Columns[1] := CreateValueType(TDBXProcedureSourcesColumns.SchemaName, SSchemaName, TDBXDataTypes.WideStringType);
  Columns[2] := CreateValueType(TDBXProcedureSourcesColumns.ProcedureName, SProcedureName, TDBXDataTypes.WideStringType);
  Columns[3] := CreateValueType(TDBXProcedureSourcesColumns.ProcedureType, SProcedureType, TDBXDataTypes.WideStringType);
  Columns[4] := CreateValueType(TDBXProcedureSourcesColumns.Definition, SDefinition, TDBXDataTypes.WideStringType);
  Columns[5] := CreateValueType(TDBXProcedureSourcesColumns.ExternalDefinition, SExternalDefinition, TDBXDataTypes.WideStringType);
  Result := Columns;
end;

class function TDBXMetaDataCollectionColumns.CreateProcedureParametersColumns: TDBXValueTypeArray;
var
  Columns: TDBXValueTypeArray;
begin
  SetLength(Columns,15);
  Columns[0] := CreateValueType(TDBXProcedureParametersColumns.CatalogName, SCatalogName, TDBXDataTypes.WideStringType);
  Columns[1] := CreateValueType(TDBXProcedureParametersColumns.SchemaName, SSchemaName, TDBXDataTypes.WideStringType);
  Columns[2] := CreateValueType(TDBXProcedureParametersColumns.ProcedureName, SProcedureName, TDBXDataTypes.WideStringType);
  Columns[3] := CreateValueType(TDBXProcedureParametersColumns.ParameterName, SParameterName, TDBXDataTypes.WideStringType);
  Columns[4] := CreateValueType(TDBXProcedureParametersColumns.ParameterMode, SParameterMode, TDBXDataTypes.WideStringType);
  Columns[5] := CreateValueType(TDBXProcedureParametersColumns.TypeName, STypeName, TDBXDataTypes.WideStringType);
  Columns[6] := CreateValueType(TDBXProcedureParametersColumns.Precision, SPrecision, TDBXDataTypes.Int64Type);
  Columns[7] := CreateValueType(TDBXProcedureParametersColumns.Scale, SScale, TDBXDataTypes.Int32Type);
  Columns[8] := CreateValueType(TDBXProcedureParametersColumns.Ordinal, SOrdinal, TDBXDataTypes.Int32Type);
  Columns[9] := CreateValueType(TDBXProcedureParametersColumns.IsNullable, SIsNullable, TDBXDataTypes.BooleanType);
  Columns[10] := CreateValueType(TDBXProcedureParametersColumns.DbxDataType, SDbxDataType, TDBXDataTypes.Int32Type, True);
  Columns[11] := CreateValueType(TDBXProcedureParametersColumns.IsFixedLength, SIsFixedLength, TDBXDataTypes.BooleanType, True);
  Columns[12] := CreateValueType(TDBXProcedureParametersColumns.IsUnicode, SIsUnicode, TDBXDataTypes.BooleanType, True);
  Columns[13] := CreateValueType(TDBXProcedureParametersColumns.IsLong, SIsLong, TDBXDataTypes.BooleanType, True);
  Columns[14] := CreateValueType(TDBXProcedureParametersColumns.IsUnsigned, SIsUnsigned, TDBXDataTypes.BooleanType, True);
  Result := Columns;
end;

class function TDBXMetaDataCollectionColumns.CreatePackagesColumns: TDBXValueTypeArray;
var
  Columns: TDBXValueTypeArray;
begin
  SetLength(Columns,3);
  Columns[0] := CreateValueType(TDBXPackagesColumns.CatalogName, SCatalogName, TDBXDataTypes.WideStringType);
  Columns[1] := CreateValueType(TDBXPackagesColumns.SchemaName, SSchemaName, TDBXDataTypes.WideStringType);
  Columns[2] := CreateValueType(TDBXPackagesColumns.PackageName, SPackageName, TDBXDataTypes.WideStringType);
  Result := Columns;
end;

class function TDBXMetaDataCollectionColumns.CreatePackageProceduresColumns: TDBXValueTypeArray;
var
  Columns: TDBXValueTypeArray;
begin
  SetLength(Columns,5);
  Columns[0] := CreateValueType(TDBXPackageProceduresColumns.CatalogName, SCatalogName, TDBXDataTypes.WideStringType);
  Columns[1] := CreateValueType(TDBXPackageProceduresColumns.SchemaName, SSchemaName, TDBXDataTypes.WideStringType);
  Columns[2] := CreateValueType(TDBXPackageProceduresColumns.PackageName, SPackageName, TDBXDataTypes.WideStringType);
  Columns[3] := CreateValueType(TDBXPackageProceduresColumns.ProcedureName, SProcedureName, TDBXDataTypes.WideStringType);
  Columns[4] := CreateValueType(TDBXPackageProceduresColumns.ProcedureType, SProcedureType, TDBXDataTypes.WideStringType);
  Result := Columns;
end;

class function TDBXMetaDataCollectionColumns.CreatePackageProcedureParametersColumns: TDBXValueTypeArray;
var
  Columns: TDBXValueTypeArray;
begin
  SetLength(Columns,16);
  Columns[0] := CreateValueType(TDBXPackageProcedureParametersColumns.CatalogName, SCatalogName, TDBXDataTypes.WideStringType);
  Columns[1] := CreateValueType(TDBXPackageProcedureParametersColumns.SchemaName, SSchemaName, TDBXDataTypes.WideStringType);
  Columns[2] := CreateValueType(TDBXPackageProcedureParametersColumns.PackageName, SPackageName, TDBXDataTypes.WideStringType);
  Columns[3] := CreateValueType(TDBXPackageProcedureParametersColumns.ProcedureName, SProcedureName, TDBXDataTypes.WideStringType);
  Columns[4] := CreateValueType(TDBXPackageProcedureParametersColumns.ParameterName, SParameterName, TDBXDataTypes.WideStringType);
  Columns[5] := CreateValueType(TDBXPackageProcedureParametersColumns.ParameterMode, SParameterMode, TDBXDataTypes.WideStringType);
  Columns[6] := CreateValueType(TDBXPackageProcedureParametersColumns.TypeName, STypeName, TDBXDataTypes.WideStringType);
  Columns[7] := CreateValueType(TDBXPackageProcedureParametersColumns.Precision, SPrecision, TDBXDataTypes.Int64Type);
  Columns[8] := CreateValueType(TDBXPackageProcedureParametersColumns.Scale, SScale, TDBXDataTypes.Int32Type);
  Columns[9] := CreateValueType(TDBXPackageProcedureParametersColumns.Ordinal, SOrdinal, TDBXDataTypes.Int32Type);
  Columns[10] := CreateValueType(TDBXPackageProcedureParametersColumns.IsNullable, SIsNullable, TDBXDataTypes.BooleanType);
  Columns[11] := CreateValueType(TDBXPackageProcedureParametersColumns.DbxDataType, SDbxDataType, TDBXDataTypes.Int32Type, True);
  Columns[12] := CreateValueType(TDBXPackageProcedureParametersColumns.IsFixedLength, SIsFixedLength, TDBXDataTypes.BooleanType, True);
  Columns[13] := CreateValueType(TDBXPackageProcedureParametersColumns.IsUnicode, SIsUnicode, TDBXDataTypes.BooleanType, True);
  Columns[14] := CreateValueType(TDBXPackageProcedureParametersColumns.IsLong, SIsLong, TDBXDataTypes.BooleanType, True);
  Columns[15] := CreateValueType(TDBXPackageProcedureParametersColumns.IsUnsigned, SIsUnsigned, TDBXDataTypes.BooleanType, True);
  Result := Columns;
end;

class function TDBXMetaDataCollectionColumns.CreatePackageSourcesColumns: TDBXValueTypeArray;
var
  Columns: TDBXValueTypeArray;
begin
  SetLength(Columns,4);
  Columns[0] := CreateValueType(TDBXPackageSourcesColumns.CatalogName, SCatalogName, TDBXDataTypes.WideStringType);
  Columns[1] := CreateValueType(TDBXPackageSourcesColumns.SchemaName, SSchemaName, TDBXDataTypes.WideStringType);
  Columns[2] := CreateValueType(TDBXPackageSourcesColumns.PackageName, SPackageName, TDBXDataTypes.WideStringType);
  Columns[3] := CreateValueType(TDBXPackageSourcesColumns.Definition, SDefinition, TDBXDataTypes.WideStringType);
  Result := Columns;
end;

class function TDBXMetaDataCollectionColumns.CreateUsersColumns: TDBXValueTypeArray;
var
  Columns: TDBXValueTypeArray;
begin
  SetLength(Columns,1);
  Columns[0] := CreateValueType(TDBXUsersColumns.UserName, SUserName, TDBXDataTypes.WideStringType);
  Result := Columns;
end;

class function TDBXMetaDataCollectionColumns.CreateRolesColumns: TDBXValueTypeArray;
var
  Columns: TDBXValueTypeArray;
begin
  SetLength(Columns,1);
  Columns[0] := CreateValueType(TDBXRolesColumns.RoleName, SRoleName, TDBXDataTypes.WideStringType);
  Result := Columns;
end;

class function TDBXMetaDataCollectionColumns.CreateReservedWordsColumns: TDBXValueTypeArray;
var
  Columns: TDBXValueTypeArray;
begin
  SetLength(Columns,1);
  Columns[0] := CreateValueType(TDBXReservedWordsColumns.ReservedWord, SReservedWord, TDBXDataTypes.WideStringType);
  Result := Columns;
end;

constructor TDBXMetaDataCommandParseResult.Create(const CommandToken: Integer; const Parameters: TDBXStringArray);
begin
  inherited Create;
  FCommandToken := CommandToken;
  FParameters := Parameters;
end;

destructor TDBXBaseMetaDataReader.Destroy;
begin
  FreeAndNil(FContext);
  FreeAndNil(FScanner);
  FreeAndNil(FDataTypeHash);
  FreeAndNil(FTypes);
  inherited Destroy;
end;

procedure TDBXBaseMetaDataReader.SetContext(const Context: TDBXProviderContext);
begin
  FContext := Context;
end;

function TDBXBaseMetaDataReader.GetContext: TDBXProviderContext;
begin
  Result := FContext;
end;

function TDBXBaseMetaDataReader.GetProductName: string;
begin
  raise TDBXMetaDataError.Create(SMissingImplementation);
end;

function TDBXBaseMetaDataReader.GetVersion: string;
begin
  Result := FVersion;
end;

procedure TDBXBaseMetaDataReader.SetVersion(const Version: string);
begin
  FVersion := MakeStandardVersionFormat(Version);
end;

function TDBXBaseMetaDataReader.CountDigits(const Version: string; const FromIndex: Integer): Integer;
var
  Index: Integer;
  IsDigit: Boolean;
  Ch: WideChar;
begin
  Index := FromIndex;
  IsDigit := True;
  while IsDigit and (Index < Version.Length) do
  begin
    Ch := Version.Chars[Index];
    IsDigit := ((Ch >= '0') and (Ch <= '9'));
    IncrAfter(Index);
  end;
  if not IsDigit then
    DecrAfter(Index);
  Result := Index - FromIndex;
end;

procedure TDBXBaseMetaDataReader.AppendVersionSection(const Buffer: TStringBuilder; const Version: string; const InStart: Integer; const EndIndex: Integer; const ExpectedLength: Integer; const AddDot: Boolean);
var
  Index: Integer;
  MaxLength: Integer;
  Start: Integer;
begin
  MaxLength := Min(Version.Length,EndIndex);
  Start := InStart;
  while (Start < MaxLength) and (Version.Chars[Start] = '0') do
    IncrAfter(Start);
  if EndIndex - Start > ExpectedLength then
    for Index := 0 to ExpectedLength - 1 do
      Buffer.Append('9')
  else 
  begin
    for Index := EndIndex - Start to ExpectedLength - 1 do
      Buffer.Append('0');
    for Index := Start to EndIndex - 1 do
      Buffer.Append(Version.Chars[Index]);
  end;
  if AddDot then
    Buffer.Append(Dot);
end;

function TDBXBaseMetaDataReader.MakeStandardVersionFormat(const Version: string): string;
var
  FirstDotIndex, SecondDotIndex, EndIndex, Index: Integer;
  Buffer: TStringBuilder;
  Standard: string;
begin
  FirstDotIndex := Version.IndexOf(Dot);
  SecondDotIndex := Version.IndexOf(Dot, FirstDotIndex + 1);
  EndIndex := SecondDotIndex + 1 + CountDigits(Version, SecondDotIndex + 1);
  if (FirstDotIndex > 0) and (SecondDotIndex > FirstDotIndex) and (EndIndex > SecondDotIndex) and ((FirstDotIndex <> 2)
     or (SecondDotIndex - FirstDotIndex <> 3) or (EndIndex - SecondDotIndex <> 4)) then
  begin
    Buffer := TStringBuilder.Create;
    try
      AppendVersionSection(Buffer, Version, 0, FirstDotIndex, 2, True);
      AppendVersionSection(Buffer, Version, FirstDotIndex + 1, SecondDotIndex, 2, True);
      AppendVersionSection(Buffer, Version, SecondDotIndex + 1, EndIndex, 4, False);
      for Index := EndIndex to Version.Length - 1 do
        Buffer.Append(Version.Chars[Index]);
      Standard := Buffer.ToString;
    finally
      Buffer.Free;
    end;
    Result := Standard;
  end
  else 
    Result := Version;
end;

function TDBXBaseMetaDataReader.GetSqlDefaultParameterMarker: string;
begin
  Result := Colon;
end;

function TDBXBaseMetaDataReader.CompareVersion(const OtherVersion: string): Integer;
begin
  if (not FVersion.IsEmpty) and (not OtherVersion.IsEmpty) then
    Result := CompareStr(FVersion,OtherVersion)
  else 
    Result := 0;
end;

function TDBXBaseMetaDataReader.GetSqlIdentifierQuotePrefix: string;
begin
  Result := DoubleQuote;
end;

function TDBXBaseMetaDataReader.GetSqlIdentifierQuoteSuffix: string;
begin
  Result := DoubleQuote;
end;

function TDBXBaseMetaDataReader.IsQuotedIdentifiersSupported: Boolean;
begin
  Result := (SqlIdentifierQuoteChar.Length > 0) or ((SqlIdentifierQuotePrefix.Length > 0) and (SqlIdentifierQuoteSuffix.Length > 0));
end;

function TDBXBaseMetaDataReader.IsLowerCaseIdentifiersSupported: Boolean;
begin
  Result := False;
end;

function TDBXBaseMetaDataReader.IsUpperCaseIdentifiersSupported: Boolean;
begin
  Result := True;
end;

function TDBXBaseMetaDataReader.IsDescendingIndexSupported: Boolean;
begin
  Result := False;
end;

function TDBXBaseMetaDataReader.IsDescendingIndexColumnsSupported: Boolean;
begin
  Result := True;
end;

function TDBXBaseMetaDataReader.IsSPReturnCodeSupported: Boolean;
begin
  Result := False;
end;

function TDBXBaseMetaDataReader.IsParameterMetadataSupported: Boolean;
begin
  Result := False;
end;

function TDBXBaseMetaDataReader.AreCatalogFunctionsSupported: Boolean;
begin
  Result := False;
end;

function TDBXBaseMetaDataReader.AreCatalogsSupported: Boolean;
begin
  Result := False;
end;

function TDBXBaseMetaDataReader.AreSchemasSupported: Boolean;
begin
  Result := False;
end;

function TDBXBaseMetaDataReader.GetSqlIdentifierQuoteChar: string;
begin
  Result := DoubleQuote;
end;

function TDBXBaseMetaDataReader.GetSqlProcedureQuoteChar: string;
begin
  Result := SqlIdentifierQuoteChar;
end;

function TDBXBaseMetaDataReader.IsMultipleCommandsSupported: Boolean;
begin
  Result := True;
end;

function TDBXBaseMetaDataReader.IsTransactionsSupported: Boolean;
begin
  Result := True;
end;

function TDBXBaseMetaDataReader.IsNestedTransactionsSupported: Boolean;
begin
  Result := False;
end;

function TDBXBaseMetaDataReader.IsSetRowSizeSupported: Boolean;
begin
  Result := False;
end;

function TDBXBaseMetaDataReader.GetTableType: string;
begin
  Result := TDBXTableType.Table;
end;

function TDBXBaseMetaDataReader.GetViewType: string;
begin
  Result := TDBXTableType.View;
end;

function TDBXBaseMetaDataReader.GetSystemTableType: string;
begin
  Result := TDBXTableType.SystemTable;
end;

function TDBXBaseMetaDataReader.GetSystemViewType: string;
begin
  Result := TDBXTableType.SystemView;
end;

function TDBXBaseMetaDataReader.GetSynonymType: string;
begin
  Result := TDBXTableType.Synonym;
end;

function TDBXBaseMetaDataReader.MakeTableTypeString(const InTableTypeCode: Integer; const Flags: Integer): string;
var
  TableTypeCode: Integer;
begin
  TableTypeCode := InTableTypeCode;
  if ((TableTypeCode and Flags) = 0) and (Flags <> 0) then
    TableTypeCode := 0;
  case TableTypeCode of
    TDBXTableTypeFlag.Table:
      Result := TableType;
    TDBXTableTypeFlag.View:
      Result := ViewType;
    TDBXTableTypeFlag.SystemTable:
      Result := SystemTableType;
    TDBXTableTypeFlag.SystemView:
      Result := SystemViewType;
    TDBXTableTypeFlag.Synonym:
      Result := SynonymType;
    else
      Result := '0';
  end;
end;

function TDBXBaseMetaDataReader.FindSourceLineColumn(const Cursor: TDBXTable; const ExpectedColumns: Integer): Integer;
var
  Columns: TDBXValueTypeArray;
  Ordinal: Integer;
begin
  Columns := Cursor.Columns;
  for Ordinal := ExpectedColumns to Length(Columns) - 1 do
  begin
    if (Columns[Ordinal].Name.ToUpper = SourceLineNumber) then
      Exit(Ordinal);
  end;
  Result := -1;
end;

procedure TDBXBaseMetaDataReader.InitScanner;
var
  QuoteChar, QuotePrefix, QuoteSuffix: string;
  Scan: TDBXSqlScanner;
begin
  if FScanner = nil then
  begin
    QuoteChar := SqlIdentifierQuoteChar;
    QuotePrefix := SqlIdentifierQuotePrefix;
    QuoteSuffix := SqlIdentifierQuoteSuffix;
    if (QuoteChar = '') then
      QuoteChar := DoubleQuote;
    if (QuotePrefix = '') then
      QuotePrefix := DoubleQuote;
    if (QuoteSuffix = '') then
      QuoteSuffix := DoubleQuote;
    Scan := TDBXSqlScanner.Create(QuoteChar, QuotePrefix, QuoteSuffix);
    Scan.RegisterId(TDBXMetaDataCommands.GetDatabase, TokenDatabase);
    Scan.RegisterId(TDBXMetaDataCommands.GetDatatypes, TDBXMetaDataCollectionIndex.DataTypes);
    Scan.RegisterId(TDBXMetaDataCommands.GetCatalogs, TDBXMetaDataCollectionIndex.Catalogs);
    Scan.RegisterId(TDBXMetaDataCommands.GetSchemas, TDBXMetaDataCollectionIndex.Schemas);
    Scan.RegisterId(TDBXMetaDataCommands.GetTables, TDBXMetaDataCollectionIndex.Tables);
    Scan.RegisterId(TDBXMetaDataCommands.GetViews, TDBXMetaDataCollectionIndex.Views);
    Scan.RegisterId(TDBXMetaDataCommands.GetSynonyms, TDBXMetaDataCollectionIndex.Synonyms);
    Scan.RegisterId(TDBXMetaDataCommands.GetColumns, TDBXMetaDataCollectionIndex.Columns);
    Scan.RegisterId(TDBXMetaDataCommands.GetIndexes, TDBXMetaDataCollectionIndex.Indexes);
    Scan.RegisterId(TDBXMetaDataCommands.GetIndexColumns, TDBXMetaDataCollectionIndex.IndexColumns);
    Scan.RegisterId(TDBXMetaDataCommands.GetForeignKeys, TDBXMetaDataCollectionIndex.ForeignKeys);
    Scan.RegisterId(TDBXMetaDataCommands.GetForeignKeyColumns, TDBXMetaDataCollectionIndex.ForeignKeyColumns);
    Scan.RegisterId(TDBXMetaDataCommands.GetProcedures, TDBXMetaDataCollectionIndex.Procedures);
    Scan.RegisterId(TDBXMetaDataCommands.GetProcedureSources, TDBXMetaDataCollectionIndex.ProcedureSources);
    Scan.RegisterId(TDBXMetaDataCommands.GetProcedureParameters, TDBXMetaDataCollectionIndex.ProcedureParameters);
    Scan.RegisterId(TDBXMetaDataCommands.GetPackages, TDBXMetaDataCollectionIndex.Packages);
    Scan.RegisterId(TDBXMetaDataCommands.GetPackageProcedures, TDBXMetaDataCollectionIndex.PackageProcedures);
    Scan.RegisterId(TDBXMetaDataCommands.GetPackageProcedureParameters, TDBXMetaDataCollectionIndex.PackageProcedureParameters);
    Scan.RegisterId(TDBXMetaDataCommands.GetPackageSources, TDBXMetaDataCollectionIndex.PackageSources);
    Scan.RegisterId(TDBXMetaDataCommands.GetUsers, TDBXMetaDataCollectionIndex.Users);
    Scan.RegisterId(TDBXMetaDataCommands.GetRoles, TDBXMetaDataCollectionIndex.Roles);
    Scan.RegisterId(TDBXMetaDataCommands.GetReservedWords, TDBXMetaDataCollectionIndex.ReservedWords);
    Scan.RegisterId(TDBXMetaDataTableTypes.Table, TokenTable);
    Scan.RegisterId(TDBXMetaDataTableTypes.View, TokenView);
    Scan.RegisterId(TDBXMetaDataTableTypes.SystemTable, TokenSystemTable);
    Scan.RegisterId(TDBXMetaDataTableTypes.SystemView, TokenSystemView);
    Scan.RegisterId(TDBXMetaDataTableTypes.Synonym, TokenSynonym);
    Scan.RegisterId(TDBXProcedureType.ProcedureType, TokenProcedureType);
    Scan.RegisterId(TDBXProcedureType.FunctionType, TokenFunctionType);
    Scan.RegisterId(TDBXMetaDataKeyword.PrimaryKey, TokenPrimaryKey);
    Scan.RegisterId(TDBXMetaDataKeyword.ForeignKey, TokenForeignKey);
    FScanner := Scan;
  end;
end;

function TDBXBaseMetaDataReader.GetDataTypeHash: TDBXObjectStore;
var
  Hash: TDBXObjectStore;
  Descr: TDBXDataTypeDescriptionArray;
  AddedTypes: TDBXArrayList;
begin
  if FDataTypeHash = nil then
  begin
    Hash := TDBXObjectStore.Create(True);
    Descr := DataTypeDescriptions;
    AddedTypes := TDBXArrayList.Create;
    PopulateDataTypes(Hash, AddedTypes, Descr);
    FreeObjectArray(TDBXFreeArray(Descr));
    FDataTypeHash := Hash;
    FTypes := AddedTypes;
  end;
  Result := FDataTypeHash;
end;

function TDBXBaseMetaDataReader.GetDataTypes: TDBXArrayList;
begin
  DataTypeHash;
  Result := FTypes;
end;

procedure TDBXBaseMetaDataReader.PopulateDataTypes(const Hash: TDBXObjectStore; const Types: TDBXArrayList; const Descr: TDBXDataTypeDescriptionArray);
var
  Index: Integer;
  DataType: TDBXDataTypeDescription;
  MaximumVersion, MinimumVersion, TypeName: string;
begin
  for Index := 0 to Length(Descr) - 1 do
  begin
    DataType := Descr[Index];
    if DataType <> nil then
    begin
      TypeName := DataType.TypeName;
      MinimumVersion := DataType.MinimumVersion;
      MaximumVersion := DataType.MaximumVersion;
      if (not Hash.ContainsKey(TypeName) and (MinimumVersion.IsEmpty or (CompareVersion(MinimumVersion) >= 0)) and
         (MaximumVersion.IsEmpty or (CompareVersion(MaximumVersion) <= 0))) then
      begin
        Hash[TypeName] := DataType;
        Types.Add(DataType);
        Descr[Index] := nil;
      end;
    end;
  end;
end;

function TDBXBaseMetaDataReader.ParseMetaDataCommand(const MetaDataCommand: string): TDBXMetaDataCommandParseResult;
var
  Token: Integer;
begin
  InitScanner;
  FScanner.Init(MetaDataCommand);
  Token := FScanner.NextToken;
  case Token of
    TokenDatabase:
      Result := ParseDone(Token, TDBXMetaDataCommands.GetDatabase, nil);
    TDBXMetaDataCollectionIndex.DataTypes:
      Result := ParseDone(Token, TDBXMetaDataCommands.GetDatatypes, nil);
    TDBXMetaDataCollectionIndex.Catalogs:
      Result := ParseDone(Token, TDBXMetaDataCommands.GetCatalogs, nil);
    TDBXMetaDataCollectionIndex.Schemas:
      Result := ParseParameter(Token, TDBXMetaDataCommands.GetSchemas);
    TDBXMetaDataCollectionIndex.Tables:
      Result := ParseGetTables(Token, TDBXMetaDataCommands.GetTables);
    TDBXMetaDataCollectionIndex.Views:
      Result := ParseGetObjectName(Token, 3, TDBXMetaDataCommands.GetViews);
    TDBXMetaDataCollectionIndex.Synonyms:
      Result := ParseGetObjectName(Token, 3, TDBXMetaDataCommands.GetSynonyms);
    TDBXMetaDataCollectionIndex.Columns:
      Result := ParseGetObjectName(Token, 3, TDBXMetaDataCommands.GetColumns);
    TDBXMetaDataCollectionIndex.Indexes:
      Result := ParseGetObjectName(Token, 3, TDBXMetaDataCommands.GetIndexes);
    TDBXMetaDataCollectionIndex.IndexColumns:
      Result := ParseIndexColumns(Token, TDBXMetaDataCommands.GetIndexColumns);
    TDBXMetaDataCollectionIndex.ForeignKeys:
      Result := ParseGetObjectName(Token, 3, TDBXMetaDataCommands.GetForeignKeys);
    TDBXMetaDataCollectionIndex.ForeignKeyColumns:
      Result := ParseForeignKeyColumns(Token, TDBXMetaDataCommands.GetForeignKeyColumns);
    TDBXMetaDataCollectionIndex.Procedures:
      Result := ParseProcedures(Token, 3, TDBXMetaDataCommands.GetProcedures);
    TDBXMetaDataCollectionIndex.ProcedureSources:
      Result := ParseGetObjectName(Token, 3, TDBXMetaDataCommands.GetProcedureSources);
    TDBXMetaDataCollectionIndex.ProcedureParameters:
      Result := ParseProcedureParameters(Token, 3, TDBXMetaDataCommands.GetProcedureParameters);
    TDBXMetaDataCollectionIndex.Packages:
      Result := ParseGetObjectName(Token, 3, TDBXMetaDataCommands.GetPackages);
    TDBXMetaDataCollectionIndex.PackageProcedures:
      Result := ParseProcedures(Token, 4, TDBXMetaDataCommands.GetPackageProcedures);
    TDBXMetaDataCollectionIndex.PackageProcedureParameters:
      Result := ParseProcedureParameters(Token, 4, TDBXMetaDataCommands.GetPackageProcedureParameters);
    TDBXMetaDataCollectionIndex.PackageSources:
      Result := ParseGetObjectName(Token, 3, TDBXMetaDataCommands.GetPackageSources);
    TDBXMetaDataCollectionIndex.Users:
      Result := ParseDone(Token, TDBXMetaDataCommands.GetUsers, nil);
    TDBXMetaDataCollectionIndex.Roles:
      Result := ParseDone(Token, TDBXMetaDataCommands.GetRoles, nil);
    TDBXMetaDataCollectionIndex.ReservedWords:
      Result := ParseDone(Token, TDBXMetaDataCommands.GetReservedWords, nil);
    else
      raise TDBXMetaDataError.Create(SMetaDataCommandExpected);
  end;
end;

function TDBXBaseMetaDataReader.ParseId: string;
var
  Token: Integer;
begin
  Token := FScanner.LookAtNextToken;
  case Token of
    TDBXSqlScanner.TokenId:
      begin
        FScanner.NextToken;
        Exit(FScanner.Id);
      end;
    TDBXSqlScanner.TokenSymbol:
      if FScanner.Symbol = '%' then
        FScanner.NextToken;
    else
      if Token > TDBXSqlScanner.TokenEos then
      begin
        FScanner.NextToken;
        Exit(FScanner.Id);
      end;
  end;
  Result := NullString;
end;

procedure TDBXBaseMetaDataReader.ParseSqlObjectName(const Parameters: TDBXStringArray; const MaxIds: Integer);
var
  Parameter: Integer;
  Token: Integer;
  Index: Integer;
begin
  Parameters[MaxIds - 1] := ParseId;
  Parameter := 1;
  Token := FScanner.LookAtNextToken;
  while (Parameter < MaxIds) and (Token = TDBXSqlScanner.TokenPeriod) do
  begin
    FScanner.NextToken;
    for index := 0 to Parameter - 1 do
      Parameters[MaxIds - Parameter + Index - 1] := Parameters[MaxIds - Parameter + Index];
    Parameters[MaxIds - 1] := ParseId;
    IncrAfter(Parameter);
    Token := FScanner.LookAtNextToken;
  end;
end;

function TDBXBaseMetaDataReader.ParseParameter(const CommandToken: Integer; const Command: string): TDBXMetaDataCommandParseResult;
var
  Parameters: TDBXStringArray;
begin
  SetLength(Parameters,1);
  Parameters[0] := ParseId;
  Result := ParseDone(CommandToken, Command, Parameters);
end;

function TDBXBaseMetaDataReader.ParseGetObjectName(const CommandToken: Integer; const MaxIds: Integer; const Command: string): TDBXMetaDataCommandParseResult;
var
  Parameters: TDBXStringArray;
begin
  SetLength(Parameters,MaxIds);
  ParseSqlObjectName(Parameters, MaxIds);
  Result := ParseDone(CommandToken, Command, Parameters);
end;

function TDBXBaseMetaDataReader.ParseGetTables(const CommandToken: Integer; const Command: string): TDBXMetaDataCommandParseResult;
var
  Parameters: TDBXStringArray;
  Types: TStringBuilder;
  TableType: string;
  Token: Integer;
begin
  SetLength(Parameters,4);
  ParseSqlObjectName(Parameters, 3);
  Types := nil;
  try
    TableType := TDBXTableType.Table;
    while not TableType.IsEmpty do
    begin
      Token := FScanner.LookAtNextToken;
      case Token of
        TokenTable:
          TableType := TDBXTableType.Table;
        TokenView:
          TableType := TDBXTableType.View;
        TokenSystemTable:
          TableType := TDBXTableType.SystemTable;
        TokenSystemView:
          TableType := TDBXTableType.SystemView;
        TokenSynonym:
          TableType := TDBXTableType.Synonym;
        else
          TableType := NullString;
      end;
      if not TableType.IsEmpty then
      begin
        FScanner.NextToken;
        if Types = nil then
          Types := TStringBuilder.Create
        else
          Types.Append(',');
        Types.Append(TableType);
        Token := FScanner.LookAtNextToken;
        if (Token = TDBXSqlScanner.TokenSemicolon) or (Token = TDBXSqlScanner.TokenComma) then
          FScanner.NextToken;
      end;
    end;
    if Types <> nil then
      Parameters[3] := Types.ToString;
    Result := ParseDone(CommandToken, Command, Parameters);
  finally
    Types.Free;
  end;
end;

function TDBXBaseMetaDataReader.ParseForeignKeyColumns(const CommandToken: Integer; const Command: string): TDBXMetaDataCommandParseResult;
var
  Parameters: TDBXStringArray;
  KeySpecificationFound, UsePrimaryKey: Boolean;
  Index, Token: Integer;
begin
  SetLength(Parameters,8);
  ParseSqlObjectName(Parameters, 3);
  KeySpecificationFound := True;
  UsePrimaryKey := False;
  Token := FScanner.LookAtNextToken;
  if (Token <> TokenPrimaryKey) and (Token <> TokenForeignKey) then
  begin
    if Token = TDBXSqlScanner.TokenPeriod then
      FScanner.NextToken;
    Parameters[3] := ParseId;
    Token := FScanner.LookAtNextToken;
  end;
  case Token of
    TokenPrimaryKey:
      UsePrimaryKey := True;
    TokenForeignKey:
      UsePrimaryKey := False;
    else
      KeySpecificationFound := False;
  end;
  if KeySpecificationFound then
    FScanner.NextToken;
  if UsePrimaryKey then
    for Index := 0 to 3 do
    begin
      Parameters[Index + 4] := Parameters[4];
      Parameters[Index] := NullString;
    end;
  Result := ParseDone(CommandToken, Command, Parameters);
end;

function TDBXBaseMetaDataReader.ParseIndexColumns(const CommandToken: Integer; const Command: string): TDBXMetaDataCommandParseResult;
var
  Parameters: TDBXStringArray;
  Token: Integer;
begin
  SetLength(Parameters,4);
  ParseSqlObjectName(Parameters, 3);
  Token := FScanner.LookAtNextToken;
  if Token = TDBXSqlScanner.TokenPeriod then
    FScanner.NextToken;
  Parameters[3] := ParseId;
  Result := ParseDone(CommandToken, Command, Parameters);
end;

function TDBXBaseMetaDataReader.ParseProcedures(const CommandToken: Integer; const MaxIds: Integer; const Command: string): TDBXMetaDataCommandParseResult;
var
  Parameters: TDBXStringArray;
  ProcType: string;
  Token: Integer;
begin
  SetLength(Parameters,MaxIds + 1);
  ParseSqlObjectName(Parameters, MaxIds);
  ProcType := NullString;
  Token := FScanner.LookAtNextToken;
  if (Token = TDBXSqlScanner.TokenSemicolon) or (Token = TDBXSqlScanner.TokenComma) then
  begin
    FScanner.NextToken;
    Token := FScanner.LookAtNextToken;
  end;
  case Token of
    TokenProcedureType:
      ProcType := TDBXProcedureType.ProcedureType;
    TokenFunctionType:
      ProcType := TDBXProcedureType.FunctionType;
  end;
  if not ProcType.IsEmpty then
  begin
    FScanner.NextToken;
    Parameters[MaxIds] := ProcType;
  end;
  Result := ParseDone(CommandToken, Command, Parameters);
end;

function TDBXBaseMetaDataReader.ParseProcedureParameters(const CommandToken: Integer; const MaxIds: Integer; const Command: string): TDBXMetaDataCommandParseResult;
var
  Parameters: TDBXStringArray;
  Token: Integer;
begin
  SetLength(Parameters,MaxIds + 1);
  ParseSqlObjectName(Parameters, MaxIds);
  Token := FScanner.LookAtNextToken;
  if Token = TDBXSqlScanner.TokenPeriod then
  begin
    FScanner.NextToken;
    Parameters[MaxIds] := ParseId;
  end;
  Result := ParseDone(CommandToken, Command, Parameters);
end;

function TDBXBaseMetaDataReader.ParseDone(const CommandToken: Integer; const Command: string; const Parameters: TDBXStringArray): TDBXMetaDataCommandParseResult;
var
  Token: Integer;
  Culprint: string;
begin
  Token := FScanner.NextToken;
  while Token = TDBXSqlScanner.TokenSemicolon do
    Token := FScanner.NextToken;
  if Token <> TDBXSqlScanner.TokenEos then
  begin
    if Token = TDBXSqlScanner.TokenError then
      raise TDBXMetaDataError.Create(Format(SUnclosedQuotes, [FScanner.SqlQuery]));
    Culprint := NullString;
    if (Token < TDBXSqlScanner.TokenEos) and (Token <> TDBXSqlScanner.TokenId) and (Token <> TDBXSqlScanner.TokenNumber) then
      Culprint := FScanner.Symbol
    else 
      Culprint := FScanner.Id;
    raise TDBXMetaDataError.Create(Format(SUnexpectedSymbol, [Culprint,Command,FScanner.SqlQuery]));
  end;
  Result := TDBXMetaDataCommandParseResult.Create(CommandToken, Parameters);
end;

function TDBXBaseMetaDataReader.FetchCollection(const MetaDataCommand: string): TDBXTable;
var
  Command: TDBXMetaDataCommandParseResult;
  CommandToken: Integer;
  Parameters: TDBXStringArray;
begin
  Command := ParseMetaDataCommand(MetaDataCommand);
  CommandToken := Command.CommandToken;
  Parameters := Command.Parameters;
  FreeAndNil(Command);
  case CommandToken of
    TokenDatabase:
      Result := nil;
    TDBXMetaDataCollectionIndex.DataTypes:
      Result := FetchDataTypes;
    TDBXMetaDataCollectionIndex.Catalogs:
      Result := FetchCatalogs;
    TDBXMetaDataCollectionIndex.Schemas:
      Result := FetchSchemas(Parameters[0]);
    TDBXMetaDataCollectionIndex.Tables:
      Result := FetchTables(Parameters[0], Parameters[1], Parameters[2], Parameters[3]);
    TDBXMetaDataCollectionIndex.Views:
      Result := FetchViews(Parameters[0], Parameters[1], Parameters[2]);
    TDBXMetaDataCollectionIndex.Synonyms:
      Result := FetchSynonyms(Parameters[0], Parameters[1], Parameters[2]);
    TDBXMetaDataCollectionIndex.Columns:
      Result := FetchColumns(Parameters[0], Parameters[1], Parameters[2]);
    TDBXMetaDataCollectionIndex.Indexes:
      Result := FetchIndexes(Parameters[0], Parameters[1], Parameters[2]);
    TDBXMetaDataCollectionIndex.IndexColumns:
      Result := FetchIndexColumns(Parameters[0], Parameters[1], Parameters[2], Parameters[3]);
    TDBXMetaDataCollectionIndex.ForeignKeys:
      Result := FetchForeignKeys(Parameters[0], Parameters[1], Parameters[2]);
    TDBXMetaDataCollectionIndex.ForeignKeyColumns:
      Result := FetchForeignKeyColumns(Parameters[0], Parameters[1], Parameters[2], Parameters[3], Parameters[4], Parameters[5], Parameters[6], Parameters[7]);
    TDBXMetaDataCollectionIndex.Procedures:
      Result := FetchProcedures(Parameters[0], Parameters[1], Parameters[2], Parameters[3]);
    TDBXMetaDataCollectionIndex.ProcedureSources:
      Result := FetchProcedureSources(Parameters[0], Parameters[1], Parameters[2]);
    TDBXMetaDataCollectionIndex.ProcedureParameters:
      Result := FetchProcedureParameters(Parameters[0], Parameters[1], Parameters[2], Parameters[3]);
    TDBXMetaDataCollectionIndex.Packages:
      Result := FetchPackages(Parameters[0], Parameters[1], Parameters[2]);
    TDBXMetaDataCollectionIndex.PackageProcedures:
      Result := FetchPackageProcedures(Parameters[0], Parameters[1], Parameters[2], Parameters[3], Parameters[4]);
    TDBXMetaDataCollectionIndex.PackageProcedureParameters:
      Result := FetchPackageProcedureParameters(Parameters[0], Parameters[1], Parameters[2], Parameters[3], Parameters[4]);
    TDBXMetaDataCollectionIndex.PackageSources:
      Result := FetchPackageSources(Parameters[0], Parameters[1], Parameters[2]);
    TDBXMetaDataCollectionIndex.Users:
      Result := FetchUsers;
    TDBXMetaDataCollectionIndex.Roles:
      Result := FetchRoles;
    TDBXMetaDataCollectionIndex.ReservedWords:
      Result := FetchReservedWords;
    else
      Result := nil;
  end;
end;

function TDBXBaseMetaDataReader.MakeStorage(var Cursor: TDBXTable): TDBXTable;
var
  Storage: TDBXTable;
begin
  Storage := FContext.CreateTableStorage(Cursor.DBXTableName, Cursor.CopyColumns);
  Storage.CopyFrom(Cursor);
  Cursor.Close;
  Cursor.Free;
  Storage.AcceptChanges;
  Result := Storage;
end;

function TDBXBaseMetaDataReader.FetchCollectionWithStorage(const MetaDataCommand: string): TDBXTable;
var
  LCollectionTable: TDBXTable;
begin
  LCollectionTable := FetchCollection(MetaDataCommand);
  Result := MakeStorage(LCollectionTable);
end;

function TDBXBaseMetaDataReader.FetchDataTypes: TDBXTable;
var
  Columns: TDBXValueTypeArray;
begin
  Columns := TDBXMetaDataCollectionColumns.CreateDataTypesColumns;
  Result := TDBXDataTypeCursor.Create(self, Columns, DataTypes);
end;

function TDBXBaseMetaDataReader.FetchCatalogs: TDBXTable;
var
  Cursor: TDBXTable;
  Columns: TDBXValueTypeArray;
begin
  Cursor := FContext.ExecuteQuery(SqlForCatalogs, nil, nil);
  Columns := TDBXMetaDataCollectionColumns.CreateCatalogsColumns;
  Result := TDBXCustomMetaDataTable.Create(FContext, TDBXMetaDataCollectionName.Catalogs, Columns, Cursor);
end;

function TDBXBaseMetaDataReader.FetchSchemas(const Catalog: string): TDBXTable;
var
  ParameterNames, ParameterValues: TDBXStringArray;
  Cursor: TDBXTable;
  Columns: TDBXValueTypeArray;
begin
  SetLength(ParameterNames,1);
  ParameterNames[0] := TDBXParameterName.CatalogName;
  SetLength(ParameterValues,1);
  ParameterValues[0] := Catalog;
  Cursor := FContext.ExecuteQuery(SqlForSchemas, ParameterNames, ParameterValues);
  Columns := TDBXMetaDataCollectionColumns.CreateSchemasColumns;
  Result := TDBXCustomMetaDataTable.Create(FContext, TDBXMetaDataCollectionName.Schemas, Columns, Cursor);
end;

function TDBXBaseMetaDataReader.FetchTables(const Catalog: string; const Schema: string; const TableName: string; const TableType: string): TDBXTable;
var
  TypeMask: Integer;
  Synonyms, SystemTables, SystemViews, Tables, Views: string;
  ParameterNames, ParameterValues: TDBXStringArray;
  Cursor: TDBXTable;
  Columns: TDBXValueTypeArray;
begin
  TypeMask := TDBXTableTypeParser.ParseTableTypes(TableType);
  Tables := MakeTableTypeString(TDBXTableTypeFlag.Table, TypeMask);
  Views := MakeTableTypeString(TDBXTableTypeFlag.View, TypeMask);
  SystemTables := MakeTableTypeString(TDBXTableTypeFlag.SystemTable, TypeMask);
  SystemViews := MakeTableTypeString(TDBXTableTypeFlag.SystemView, TypeMask);
  Synonyms := MakeTableTypeString(TDBXTableTypeFlag.Synonym, TypeMask);
  SetLength(ParameterNames,8);
  ParameterNames[0] := TDBXParameterName.CatalogName;
  ParameterNames[1] := TDBXParameterName.SchemaName;
  ParameterNames[2] := TDBXParameterName.TableName;
  ParameterNames[3] := TDBXParameterName.Tables;
  ParameterNames[4] := TDBXParameterName.Views;
  ParameterNames[5] := TDBXParameterName.SystemTables;
  ParameterNames[6] := TDBXParameterName.SystemViews;
  ParameterNames[7] := TDBXParameterName.Synonyms;
  SetLength(ParameterValues,8);
  ParameterValues[0] := Catalog;
  ParameterValues[1] := Schema;
  ParameterValues[2] := TableName;
  ParameterValues[3] := Tables;
  ParameterValues[4] := Views;
  ParameterValues[5] := SystemTables;
  ParameterValues[6] := SystemViews;
  ParameterValues[7] := Synonyms;
  Cursor := FContext.ExecuteQuery(SqlForTables, ParameterNames, ParameterValues);
  Columns := TDBXMetaDataCollectionColumns.CreateTablesColumns;
  Result := TDBXCustomMetaDataTable.Create(FContext, TDBXMetaDataCollectionName.Tables, Columns, Cursor);
end;

function TDBXBaseMetaDataReader.FetchViews(const Catalog: string; const Schema: string; const View: string): TDBXTable;
var
  ParameterNames, ParameterValues: TDBXStringArray;
  Cursor: TDBXTable;
  Columns: TDBXValueTypeArray;
  OrdinalLineNumber: Integer;
begin
  SetLength(ParameterNames,3);
  ParameterNames[0] := TDBXParameterName.CatalogName;
  ParameterNames[1] := TDBXParameterName.SchemaName;
  ParameterNames[2] := TDBXParameterName.ViewName;
  SetLength(ParameterValues,3);
  ParameterValues[0] := Catalog;
  ParameterValues[1] := Schema;
  ParameterValues[2] := View;
  Cursor := FContext.ExecuteQuery(SqlForViews, ParameterNames, ParameterValues);
  Columns := TDBXMetaDataCollectionColumns.CreateViewsColumns;
  OrdinalLineNumber := FindSourceLineColumn(Cursor, Length(Columns));
  if OrdinalLineNumber > 0 then
    Result := TDBXSourceTableCursor.Create(FContext, TDBXMetaDataCollectionName.Views, Columns, Cursor, TDBXViewsIndex.Definition, OrdinalLineNumber)
  else 
    Result := TDBXCustomMetaDataTable.Create(FContext, TDBXMetaDataCollectionName.Views, Columns, Cursor);
end;

function TDBXBaseMetaDataReader.FetchColumns(const Catalog: string; const Schema: string; const Table: string): TDBXTable;
var
  ParameterNames, ParameterValues: TDBXStringArray;
  Cursor: TDBXTable;
  Columns: TDBXValueTypeArray;
begin
  DataTypeHash;
  SetLength(ParameterNames,3);
  ParameterNames[0] := TDBXParameterName.CatalogName;
  ParameterNames[1] := TDBXParameterName.SchemaName;
  ParameterNames[2] := TDBXParameterName.TableName;
  SetLength(ParameterValues,3);
  ParameterValues[0] := Catalog;
  ParameterValues[1] := Schema;
  ParameterValues[2] := Table;
  Cursor := FContext.ExecuteQuery(SqlForColumns, ParameterNames, ParameterValues);
  Columns := TDBXMetaDataCollectionColumns.CreateColumnsColumns;
  Cursor := TDBXCustomMetaDataTable.Create(FContext, TDBXMetaDataCollectionName.Columns, Columns, Cursor);
  Result := TDBXColumnsTableCursor.Create(self, False, Cursor);
end;

function TDBXBaseMetaDataReader.FetchColumnConstraints(const Catalog: string; const Schema: string; const Table: string): TDBXTable;
var
  ParameterNames, ParameterValues: TDBXStringArray;
  Cursor: TDBXTable;
  Columns: TDBXValueTypeArray;
begin
  SetLength(ParameterNames,3);
  ParameterNames[0] := TDBXParameterName.CatalogName;
  ParameterNames[1] := TDBXParameterName.SchemaName;
  ParameterNames[2] := TDBXParameterName.TableName;
  SetLength(ParameterValues,3);
  ParameterValues[0] := Catalog;
  ParameterValues[1] := Schema;
  ParameterValues[2] := Table;
  Cursor := FContext.ExecuteQuery(SqlForColumnConstraints, ParameterNames, ParameterValues);
  Columns := TDBXMetaDataCollectionColumns.CreateColumnConstraintsColumns;
  Result := TDBXCustomMetaDataTable.Create(FContext, TDBXMetaDataCollectionName.ColumnConstraints, Columns, Cursor);
end;

function TDBXBaseMetaDataReader.FetchIndexes(const Catalog: string; const Schema: string; const Table: string): TDBXTable;
var
  ParameterNames, ParameterValues: TDBXStringArray;
  Cursor: TDBXTable;
  Columns: TDBXValueTypeArray;
begin
  SetLength(ParameterNames,3);
  ParameterNames[0] := TDBXParameterName.CatalogName;
  ParameterNames[1] := TDBXParameterName.SchemaName;
  ParameterNames[2] := TDBXParameterName.TableName;
  SetLength(ParameterValues,3);
  ParameterValues[0] := Catalog;
  ParameterValues[1] := Schema;
  ParameterValues[2] := Table;
  Cursor := FContext.ExecuteQuery(SqlForIndexes, ParameterNames, ParameterValues);
  Columns := TDBXMetaDataCollectionColumns.CreateIndexesColumns;
  Columns[TDBXIndexesIndex.IsAscending].Hidden := DescendingIndexSupported;
  Result := TDBXCustomMetaDataTable.Create(FContext, TDBXMetaDataCollectionName.Indexes, Columns, Cursor);
end;

function TDBXBaseMetaDataReader.FetchIndexColumns(const Catalog: string; const Schema: string; const Table: string; const Index: string): TDBXTable;
var
  ParameterNames, ParameterValues: TDBXStringArray;
  Cursor: TDBXTable;
  Columns: TDBXValueTypeArray;
begin
  SetLength(ParameterNames,4);
  ParameterNames[0] := TDBXParameterName.CatalogName;
  ParameterNames[1] := TDBXParameterName.SchemaName;
  ParameterNames[2] := TDBXParameterName.TableName;
  ParameterNames[3] := TDBXParameterName.IndexName;
  SetLength(ParameterValues,4);
  ParameterValues[0] := Catalog;
  ParameterValues[1] := Schema;
  ParameterValues[2] := Table;
  ParameterValues[3] := Index;
  Cursor := FContext.ExecuteQuery(SqlForIndexColumns, ParameterNames, ParameterValues);
  Columns := TDBXMetaDataCollectionColumns.CreateIndexColumnsColumns;
  Columns[TDBXIndexColumnsIndex.IsAscending].Hidden := DescendingIndexColumnsSupported;
  Result := TDBXCustomMetaDataTable.Create(FContext, TDBXMetaDataCollectionName.IndexColumns, Columns, Cursor);
end;

function TDBXBaseMetaDataReader.FetchForeignKeys(const Catalog: string; const Schema: string; const Table: string): TDBXTable;
var
  ParameterNames, ParameterValues: TDBXStringArray;
  Cursor: TDBXTable;
  Columns: TDBXValueTypeArray;
begin
  SetLength(ParameterNames,3);
  ParameterNames[0] := TDBXParameterName.CatalogName;
  ParameterNames[1] := TDBXParameterName.SchemaName;
  ParameterNames[2] := TDBXParameterName.TableName;
  SetLength(ParameterValues,3);
  ParameterValues[0] := Catalog;
  ParameterValues[1] := Schema;
  ParameterValues[2] := Table;
  Cursor := FContext.ExecuteQuery(SqlForForeignKeys, ParameterNames, ParameterValues);
  Columns := TDBXMetaDataCollectionColumns.CreateForeignKeysColumns;
  Result := TDBXCustomMetaDataTable.Create(FContext, TDBXMetaDataCollectionName.ForeignKeys, Columns, Cursor);
end;

function TDBXBaseMetaDataReader.FetchForeignKeyColumns(const Catalog: string; const Schema: string; const Table: string; const ForeignKeyName: string; const PrimaryCatalog: string; const PrimarySchema: string; const PrimaryTable: string; const PrimaryKeyName: string): TDBXTable;
var
  ParameterNames, ParameterValues: TDBXStringArray;
  Cursor: TDBXTable;
  Columns: TDBXValueTypeArray;
begin
  SetLength(ParameterNames,8);
  ParameterNames[0] := TDBXParameterName.CatalogName;
  ParameterNames[1] := TDBXParameterName.SchemaName;
  ParameterNames[2] := TDBXParameterName.TableName;
  ParameterNames[3] := TDBXParameterName.ForeignKeyName;
  ParameterNames[4] := TDBXParameterName.PrimaryCatalogName;
  ParameterNames[5] := TDBXParameterName.PrimarySchemaName;
  ParameterNames[6] := TDBXParameterName.PrimaryTableName;
  ParameterNames[7] := TDBXParameterName.PrimaryKeyName;
  SetLength(ParameterValues,8);
  ParameterValues[0] := Catalog;
  ParameterValues[1] := Schema;
  ParameterValues[2] := Table;
  ParameterValues[3] := ForeignKeyName;
  ParameterValues[4] := PrimaryCatalog;
  ParameterValues[5] := PrimarySchema;
  ParameterValues[6] := PrimaryTable;
  ParameterValues[7] := PrimaryKeyName;
  Cursor := FContext.ExecuteQuery(SqlForForeignKeyColumns, ParameterNames, ParameterValues);
  Columns := TDBXMetaDataCollectionColumns.CreateForeignKeyColumnsColumns;
  Result := TDBXCustomMetaDataTable.Create(FContext, TDBXMetaDataCollectionName.ForeignKeyColumns, Columns, Cursor);
end;

function TDBXBaseMetaDataReader.FetchSynonyms(const Catalog: string; const Schema: string; const Synonym: string): TDBXTable;
var
  ParameterNames, ParameterValues: TDBXStringArray;
  Cursor: TDBXTable;
  Columns: TDBXValueTypeArray;
begin
  SetLength(ParameterNames,3);
  ParameterNames[0] := TDBXParameterName.CatalogName;
  ParameterNames[1] := TDBXParameterName.SchemaName;
  ParameterNames[2] := TDBXParameterName.SynonymName;
  SetLength(ParameterValues,3);
  ParameterValues[0] := Catalog;
  ParameterValues[1] := Schema;
  ParameterValues[2] := Synonym;
  Cursor := FContext.ExecuteQuery(SqlForSynonyms, ParameterNames, ParameterValues);
  Columns := TDBXMetaDataCollectionColumns.CreateSynonymsColumns;
  Result := TDBXCustomMetaDataTable.Create(FContext, TDBXMetaDataCollectionName.Synonyms, Columns, Cursor);
end;

function TDBXBaseMetaDataReader.FetchProcedures(const Catalog: string; const Schema: string; const ProcedureName: string; const ProcedureType: string): TDBXTable;
var
  ParameterNames, ParameterValues: TDBXStringArray;
  Cursor: TDBXTable;
  Columns: TDBXValueTypeArray;
begin
  SetLength(ParameterNames,4);
  ParameterNames[0] := TDBXParameterName.CatalogName;
  ParameterNames[1] := TDBXParameterName.SchemaName;
  ParameterNames[2] := TDBXParameterName.ProcedureName;
  ParameterNames[3] := TDBXParameterName.ProcedureType;
  SetLength(ParameterValues,4);
  ParameterValues[0] := Catalog;
  ParameterValues[1] := Schema;
  ParameterValues[2] := ProcedureName;
  ParameterValues[3] := ProcedureType;
  Cursor := FContext.ExecuteQuery(SqlForProcedures, ParameterNames, ParameterValues);
  Columns := TDBXMetaDataCollectionColumns.CreateProceduresColumns;
  Result := TDBXCustomMetaDataTable.Create(FContext, TDBXMetaDataCollectionName.Procedures, Columns, Cursor);
end;

function TDBXBaseMetaDataReader.FetchProcedureSources(const Catalog: string; const Schema: string; const Proc: string): TDBXTable;
var
  ParameterNames, ParameterValues: TDBXStringArray;
  Cursor: TDBXTable;
  Columns: TDBXValueTypeArray;
  OrdinalLineNumber: Integer;
begin
  SetLength(ParameterNames,3);
  ParameterNames[0] := TDBXParameterName.CatalogName;
  ParameterNames[1] := TDBXParameterName.SchemaName;
  ParameterNames[2] := TDBXParameterName.ProcedureName;
  SetLength(ParameterValues,3);
  ParameterValues[0] := Catalog;
  ParameterValues[1] := Schema;
  ParameterValues[2] := Proc;
  Cursor := FContext.ExecuteQuery(SqlForProcedureSources, ParameterNames, ParameterValues);
  Columns := TDBXMetaDataCollectionColumns.CreateProcedureSourcesColumns;
  OrdinalLineNumber := FindSourceLineColumn(Cursor, Length(Columns));
  if OrdinalLineNumber > 0 then
    Result := TDBXSourceTableCursor.Create(FContext, TDBXMetaDataCollectionName.ProcedureSources, Columns, Cursor, TDBXProcedureSourcesIndex.Definition, OrdinalLineNumber)
  else 
    Result := TDBXCustomMetaDataTable.Create(FContext, TDBXMetaDataCollectionName.ProcedureSources, Columns, Cursor);
end;

function TDBXBaseMetaDataReader.FetchProcedureParameters(const Catalog: string; const Schema: string; const Proc: string; const Parameter: string): TDBXTable;
var
  ParameterNames, ParameterValues: TDBXStringArray;
  Cursor: TDBXTable;
  Columns: TDBXValueTypeArray;
begin
  DataTypeHash;
  SetLength(ParameterNames,4);
  ParameterNames[0] := TDBXParameterName.CatalogName;
  ParameterNames[1] := TDBXParameterName.SchemaName;
  ParameterNames[2] := TDBXParameterName.ProcedureName;
  ParameterNames[3] := TDBXParameterName.ParameterName;
  SetLength(ParameterValues,4);
  ParameterValues[0] := Catalog;
  ParameterValues[1] := Schema;
  ParameterValues[2] := Proc;
  ParameterValues[3] := Parameter;
  Cursor := FContext.ExecuteQuery(SqlForProcedureParameters, ParameterNames, ParameterValues);
  Columns := TDBXMetaDataCollectionColumns.CreateProcedureParametersColumns;
  Cursor := TDBXCustomMetaDataTable.Create(FContext, TDBXMetaDataCollectionName.ProcedureParameters, Columns, Cursor);
  Result := TDBXColumnsTableCursor.Create(self, False, Cursor);
end;

function TDBXBaseMetaDataReader.FetchPackages(const Catalog: string; const Schema: string; const PackageName: string): TDBXTable;
var
  ParameterNames, ParameterValues: TDBXStringArray;
  Cursor: TDBXTable;
  Columns: TDBXValueTypeArray;
begin
  SetLength(ParameterNames,3);
  ParameterNames[0] := TDBXParameterName.CatalogName;
  ParameterNames[1] := TDBXParameterName.SchemaName;
  ParameterNames[2] := TDBXParameterName.PackageName;
  SetLength(ParameterValues,3);
  ParameterValues[0] := Catalog;
  ParameterValues[1] := Schema;
  ParameterValues[2] := PackageName;
  Cursor := FContext.ExecuteQuery(SqlForPackages, ParameterNames, ParameterValues);
  Columns := TDBXMetaDataCollectionColumns.CreatePackagesColumns;
  Result := TDBXCustomMetaDataTable.Create(FContext, TDBXMetaDataCollectionName.Packages, Columns, Cursor);
end;

function TDBXBaseMetaDataReader.FetchPackageProcedures(const Catalog: string; const Schema: string; const PackageName: string; const ProcedureName: string; const ProcedureType: string): TDBXTable;
var
  ParameterNames, ParameterValues: TDBXStringArray;
  Cursor: TDBXTable;
  Columns: TDBXValueTypeArray;
begin
  SetLength(ParameterNames,5);
  ParameterNames[0] := TDBXParameterName.CatalogName;
  ParameterNames[1] := TDBXParameterName.SchemaName;
  ParameterNames[2] := TDBXParameterName.PackageName;
  ParameterNames[3] := TDBXParameterName.ProcedureName;
  ParameterNames[4] := TDBXParameterName.ProcedureType;
  SetLength(ParameterValues,5);
  ParameterValues[0] := Catalog;
  ParameterValues[1] := Schema;
  ParameterValues[2] := PackageName;
  ParameterValues[3] := ProcedureName;
  ParameterValues[4] := ProcedureType;
  Cursor := FContext.ExecuteQuery(SqlForPackageProcedures, ParameterNames, ParameterValues);
  Columns := TDBXMetaDataCollectionColumns.CreatePackageProceduresColumns;
  Result := TDBXCustomMetaDataTable.Create(FContext, TDBXMetaDataCollectionName.PackageProcedures, Columns, Cursor);
end;

function TDBXBaseMetaDataReader.FetchPackageProcedureParameters(const Catalog: string; const Schema: string; const PackageName: string; const ProcedureName: string; const ParameterName: string): TDBXTable;
var
  ParameterNames, ParameterValues: TDBXStringArray;
  Cursor: TDBXTable;
  Columns: TDBXValueTypeArray;
begin
  DataTypeHash;
  SetLength(ParameterNames,5);
  ParameterNames[0] := TDBXParameterName.CatalogName;
  ParameterNames[1] := TDBXParameterName.SchemaName;
  ParameterNames[2] := TDBXParameterName.PackageName;
  ParameterNames[3] := TDBXParameterName.ProcedureName;
  ParameterNames[4] := TDBXParameterName.ParameterName;
  SetLength(ParameterValues,5);
  ParameterValues[0] := Catalog;
  ParameterValues[1] := Schema;
  ParameterValues[2] := PackageName;
  ParameterValues[3] := ProcedureName;
  ParameterValues[4] := ParameterName;
  Cursor := FContext.ExecuteQuery(SqlForPackageProcedureParameters, ParameterNames, ParameterValues);
  Columns := TDBXMetaDataCollectionColumns.CreatePackageProcedureParametersColumns;
  Cursor := TDBXCustomMetaDataTable.Create(FContext, TDBXMetaDataCollectionName.PackageProcedureParameters, Columns, Cursor);
  Result := TDBXColumnsTableCursor.Create(self, False, Cursor);
end;

function TDBXBaseMetaDataReader.FetchPackageSources(const Catalog: string; const Schema: string; const PackageName: string): TDBXTable;
var
  ParameterNames, ParameterValues: TDBXStringArray;
  Cursor: TDBXTable;
  Columns: TDBXValueTypeArray;
begin
  SetLength(ParameterNames,3);
  ParameterNames[0] := TDBXParameterName.CatalogName;
  ParameterNames[1] := TDBXParameterName.SchemaName;
  ParameterNames[2] := TDBXParameterName.PackageName;
  SetLength(ParameterValues,3);
  ParameterValues[0] := Catalog;
  ParameterValues[1] := Schema;
  ParameterValues[2] := PackageName;
  Cursor := FContext.ExecuteQuery(SqlForPackageSources, ParameterNames, ParameterValues);
  Columns := TDBXMetaDataCollectionColumns.CreatePackageSourcesColumns;
  Result := TDBXCustomMetaDataTable.Create(FContext, TDBXMetaDataCollectionName.PackageSources, Columns, Cursor);
end;

function TDBXBaseMetaDataReader.FetchUsers: TDBXTable;
var
  Cursor: TDBXTable;
  Columns: TDBXValueTypeArray;
begin
  Cursor := FContext.ExecuteQuery(SqlForUsers, nil, nil);
  Columns := TDBXMetaDataCollectionColumns.CreateUsersColumns;
  Result := TDBXCustomMetaDataTable.Create(FContext, TDBXMetaDataCollectionName.Users, Columns, Cursor);
end;

function TDBXBaseMetaDataReader.FetchRoles: TDBXTable;
var
  Cursor: TDBXTable;
  Columns: TDBXValueTypeArray;
begin
  Cursor := FContext.ExecuteQuery(SqlForRoles, nil, nil);
  Columns := TDBXMetaDataCollectionColumns.CreateRolesColumns;
  Result := TDBXCustomMetaDataTable.Create(FContext, TDBXMetaDataCollectionName.Roles, Columns, Cursor);
end;

function TDBXBaseMetaDataReader.FetchReservedWords: TDBXTable;
var
  ReservedSqlWords: TDBXStringArray;
  Columns: TDBXValueTypeArray;
  Cursor: TDBXTable;
begin
  ReservedSqlWords := ReservedWords;
  Columns := TDBXMetaDataCollectionColumns.CreateReservedWordsColumns;
  if ReservedSqlWords = nil then
  begin
    Cursor := FContext.ExecuteQuery(SqlForReservedWords, nil, nil);
    Result := TDBXCustomMetaDataTable.Create(FContext, TDBXMetaDataCollectionName.ReservedWords, Columns, Cursor);
  end
  else 
    Result := TDBXReservedWordsCursor.Create(FContext, Columns, ReservedSqlWords);
end;

function TDBXBaseMetaDataReader.GetDataTypeDescriptions: TDBXDataTypeDescriptionArray;
begin
  Result := nil;
end;

function TDBXBaseMetaDataReader.GetReservedWords: TDBXStringArray;
begin
  Result := nil;
end;

function TDBXBaseMetaDataReader.GetSqlForDataTypes: string;
begin
  raise TDBXMetaDataError.Create(SMissingImplementation);
end;

function TDBXBaseMetaDataReader.GetSqlForCatalogs: string;
begin
  raise TDBXMetaDataError.Create(SMissingImplementation);
end;

function TDBXBaseMetaDataReader.GetSqlForSchemas: string;
begin
  raise TDBXMetaDataError.Create(SMissingImplementation);
end;

function TDBXBaseMetaDataReader.GetSqlForTables: string;
begin
  raise TDBXMetaDataError.Create(SMissingImplementation);
end;

function TDBXBaseMetaDataReader.GetSqlForViews: string;
begin
  raise TDBXMetaDataError.Create(SMissingImplementation);
end;

function TDBXBaseMetaDataReader.GetSqlForColumns: string;
begin
  raise TDBXMetaDataError.Create(SMissingImplementation);
end;

function TDBXBaseMetaDataReader.GetSqlForColumnConstraints: string;
begin
  Result := NullString;
end;

function TDBXBaseMetaDataReader.GetSqlForIndexes: string;
begin
  raise TDBXMetaDataError.Create(SMissingImplementation);
end;

function TDBXBaseMetaDataReader.GetSqlForIndexColumns: string;
begin
  raise TDBXMetaDataError.Create(SMissingImplementation);
end;

function TDBXBaseMetaDataReader.GetSqlForForeignKeys: string;
begin
  raise TDBXMetaDataError.Create(SMissingImplementation);
end;

function TDBXBaseMetaDataReader.GetSqlForForeignKeyColumns: string;
begin
  raise TDBXMetaDataError.Create(SMissingImplementation);
end;

function TDBXBaseMetaDataReader.GetSqlForSynonyms: string;
begin
  raise TDBXMetaDataError.Create(SMissingImplementation);
end;

function TDBXBaseMetaDataReader.GetSqlForProcedures: string;
begin
  raise TDBXMetaDataError.Create(SMissingImplementation);
end;

function TDBXBaseMetaDataReader.GetSqlForProcedureSources: string;
begin
  raise TDBXMetaDataError.Create(SMissingImplementation);
end;

function TDBXBaseMetaDataReader.GetSqlForProcedureParameters: string;
begin
  raise TDBXMetaDataError.Create(SMissingImplementation);
end;

function TDBXBaseMetaDataReader.GetSqlForPackages: string;
begin
  raise TDBXMetaDataError.Create(SMissingImplementation);
end;

function TDBXBaseMetaDataReader.GetSqlForPackageProcedures: string;
begin
  raise TDBXMetaDataError.Create(SMissingImplementation);
end;

function TDBXBaseMetaDataReader.GetSqlForPackageProcedureParameters: string;
begin
  raise TDBXMetaDataError.Create(SMissingImplementation);
end;

function TDBXBaseMetaDataReader.GetSqlForPackageSources: string;
begin
  raise TDBXMetaDataError.Create(SMissingImplementation);
end;

function TDBXBaseMetaDataReader.GetSqlForUsers: string;
begin
  raise TDBXMetaDataError.Create(SMissingImplementation);
end;

function TDBXBaseMetaDataReader.GetSqlForRoles: string;
begin
  raise TDBXMetaDataError.Create(SMissingImplementation);
end;

function TDBXBaseMetaDataReader.GetSqlForReservedWords: string;
begin
  raise TDBXMetaDataError.Create(SMissingImplementation);
end;

class function TDBXProviderContext.UseAnsiString(const ProductName: string): Boolean;
begin
  if (ProductName = TDBXProductNames.Db2_Product) or (ProductName = TDBXProductNames.InformixProduct) or
     (ProductName = TDBXProductNames.SybaseAseProduct) then
    Result := True
  else
    Result := False;
end;

constructor TDBXReservedWordsCursor.Create(const TypeNames: TDBXPlatformTypeNames; const Columns: TDBXValueTypeArray; const Keywords: TDBXStringArray);
begin
  inherited Create(nil);
  FTypeNames := TypeNames;
  FKeywords := Keywords;
  FReservedRow := TDBXSingleValueRow.Create;
  FReservedRow.Columns := Columns;
  FRowIndex := -1;
end;

function TDBXReservedWordsCursor.GetOrdinal(const Name: string): Integer;
begin
  Result := FReservedRow.GetOrdinal(Name);
end;

destructor TDBXReservedWordsCursor.Destroy;
begin
  FreeAndNil(FReservedRow);
  FKeywords := nil;
  inherited Destroy;
end;

function TDBXReservedWordsCursor.GetDBXTableName: string;
begin
  Result := TDBXMetaDataCollectionName.ReservedWords;
end;

function TDBXReservedWordsCursor.GetColumns: TDBXValueTypeArray;
begin
  Result := FReservedRow.Columns;
end;

function TDBXReservedWordsCursor.First: Boolean;
begin
  FRowIndex := 0;
  Result := FRowIndex < Length(FKeywords);
end;

function TDBXReservedWordsCursor.GetWritableValue(const Ordinal: Integer): TDBXWritableValue;
begin
  if FRowIndex < 0 then
    raise TDBXMetaDataError.Create(SMustCallNextFirst);
  if FRowIndex >= Length(FKeywords) then
    raise TDBXMetaDataError.Create(SPastEndOfCursor);
  Result := FReservedRow.Value[Ordinal];
end;

function TDBXReservedWordsCursor.Next: Boolean;
begin
  IncrAfter(FRowIndex);
  if FRowIndex < Length(FKeywords) then
  begin
    FReservedRow.Value[TDBXReservedWordsIndex.ReservedWord].AsString := FKeywords[FRowIndex];
    Exit(True);
  end;
  Result := False;
end;

function TDBXReservedWordsCursor.InBounds: Boolean;
begin
  Result := (FRowIndex < Length(FKeywords));
end;

procedure TDBXReservedWordsCursor.Close;
begin
end;

constructor TDBXSourceTableCursor.Create(const Context: TDBXProviderContext; const MetaDataCollectionName: string; const Columns: TDBXValueTypeArray; const Cursor: TDBXTable; const OrdinalDefinition: Integer; const OrdinalLineNumber: Integer);
begin
  inherited Create(Context, MetaDataCollectionName, Columns, Cursor);
  FOrdinalLineNumber := OrdinalLineNumber;
  FOrdinalDefinition := OrdinalDefinition;
  FRowStorage := TDBXSingleValueRow.Create;
  FRowStorage.Columns := CopyColumns;
  FBuffer := TStringBuilder.Create;
  FBeforeFirst := True;
end;

destructor TDBXSourceTableCursor.Destroy;
begin
  FreeAndNil(FRowStorage);
  FreeAndNil(FBuffer);
  inherited Destroy;
end;

function TDBXSourceTableCursor.Next: Boolean;
var
  LineNumber, Ordinal, PrevLineNumber: Integer;
begin
  if FBeforeFirst then
  begin
    FBeforeEnd := FCursor.Next;
    FBeforeFirst := False;
  end;
  if not FBeforeEnd then
    Exit(False);
  LineNumber := FCursor.Value[FOrdinalLineNumber].AsInt32;
  PrevLineNumber := LineNumber - 1;
  for Ordinal := 0 to Length(FColumns) - 1 do
    FRowStorage.Value[Ordinal].SetValue(Value[Ordinal]);
  FBuffer.Length := 0;
  while FBeforeEnd and (LineNumber > PrevLineNumber) do
  begin
    FBuffer.Append(FCursor.Value[FOrdinalDefinition].AsString);
    FBeforeEnd := FCursor.Next;
    if FBeforeEnd then
    begin
      PrevLineNumber := LineNumber;
      LineNumber := FCursor.Value[FOrdinalLineNumber].AsInt32;
    end;
  end;
  FRowStorage.Value[FOrdinalDefinition].AsString := FBuffer.ToString;
  Result := True;
end;

function TDBXSourceTableCursor.GetWritableValue(const Ordinal: Integer): TDBXWritableValue;
begin
  Result := FRowStorage.Value[Ordinal];
end;

class function TDBXTableTypeParser.ParseTableTypes(const TableTypes: string): Integer;
var
  Flags: Integer;
  Tokenizer: TDBXTokenizer;
  TableType: string;
begin
  Flags := 0;
  if not TableTypes.IsEmpty then
  begin
    Tokenizer := TDBXTokenizer.Create(TableTypes, ',');
    try
      while Tokenizer.HasMoreTokens do
      begin
        TableType := Tokenizer.NextToken.Trim;
        if (TableType = TDBXTableType.Table) then
          Flags := Flags or TDBXTableTypeFlag.Table
        else if (TableType = TDBXTableType.SystemTable) then
          Flags := Flags or TDBXTableTypeFlag.SystemTable
        else if (TableType = TDBXTableType.View) then
          Flags := Flags or TDBXTableTypeFlag.View
        else if (TableType = TDBXTableType.Synonym) then
          Flags := Flags or TDBXTableTypeFlag.Synonym
        else if TableType.Length > 0 then
          raise TDBXMetaDataError.Create(SUnknownTableType + TableType);
      end;
    finally
      Tokenizer.Free;
    end;
  end;
  if Flags = 0 then
    Flags := TDBXTableTypeFlag.All;
  Result := Flags;
end;

constructor TDBXMetaDataError.Create(const Message: string);
begin
  inherited Create(TDBXErrorCodes.InvalidOperation, Message);
end;

end.
