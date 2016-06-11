{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

  ///<summary>
  /// This unit contains several <c>TDBXReader</c> implementations for the TParams
  /// class as well as the TDataSet and TClientDataSet components.  These TDBXReader
  /// implementations allow the contents of these classes and components to be
  /// used as parameters for a <c>TDBXCommand</c>.  DataSnap server methods support
  /// <c>TDBXReader</c> parameters.
  ///</summary>

unit Data.DBXDBReaders;

interface

uses
  Data.DB,
  System.Classes,
  Data.DBXCommon,
  Data.DBXPlatform,
  Data.DBXCommonTable,
  System.SysUtils,
  Data.SqlTimSt,
  Data.FmtBcd,
  System.Generics.Collections
  ;

type
  /// <summary>Not used directly by applications.</summary>
  TDBXParamsRow = class(TDBXRow)
  private
    [Weak]FParams:  TParams;
  public
    constructor Create(Params: TParams);
    function CreateCustomValue(const ValueType: TDBXValueType): TDBXValue; override;
    ///<summary>Returns a string from the row in the Value parameter or sets IsNull to true.</summary>
    procedure GetWideString(DbxValue: TDBXWideStringValue;
      var Value: string; var IsNull: LongBool); override;
    ///<summary>Returns a LongBool from the row in the Value parameter or sets IsNull to true.</summary>
    procedure GetBoolean(DbxValue: TDBXBooleanValue; var Value: LongBool;
      var IsNull: LongBool); override;
    ///<summary>Returns a Byte from the row in the Value parameter or sets IsNull to true.</summary>
    procedure GetUInt8(DbxValue: TDBXUInt8Value; var Value: Byte;
      var IsNull: LongBool); override;
    ///<summary>Returns a ShortInt from the row in the Value parameter or sets IsNull to true.</summary>
    procedure GetInt8(DbxValue: TDBXInt8Value; var Value: ShortInt;
      var IsNull: LongBool); override;
    ///<summary>Returns a Word from the row in the Value parameter or sets IsNull to true.</summary>
    procedure GetUInt16(DbxValue: TDBXUInt16Value; var Value: Word;
      var IsNull: LongBool); override;
    ///<summary>Returns a SmallInt from the row in the Value parameter or sets IsNull to true.</summary>
    procedure GetInt16(DbxValue: TDBXInt16Value; var Value: SmallInt;
      var IsNull: LongBool); override;
    ///<summary>Returns an Integer from the row in the Value parameter or sets IsNull to true.</summary>
    procedure GetInt32(DbxValue: TDBXInt32Value; var Value: TInt32;
      var IsNull: LongBool); override;
    ///<summary>Returns an Int64 from the row in the Value parameter or sets IsNull to true.</summary>
    procedure GetInt64(DbxValue: TDBXInt64Value; var Value: Int64;
      var IsNull: LongBool); override;
    ///<summary>Returns a Single from the row in the Value parameter or sets IsNull to true.</summary>
    procedure GetSingle(DbxValue: TDBXSingleValue; var Value: Single;
      var IsNull: LongBool); override;
    ///<summary>Returns a Double from the row in the Value parameter or sets IsNull to true.</summary>
    procedure GetDouble(DbxValue: TDBXDoubleValue; var Value: Double;
      var IsNull: LongBool); override;
    ///<summary>Returns a PAnsiChar from the row in the AnsiStringBuilder parameter or sets IsNull to true.</summary>
{$IFNDEF NEXTGEN}
    procedure GetAnsiString(DbxValue: TDBXAnsiStringValue;
      var AnsiStringBuilder: TDBXAnsiStringBuilder; var IsNull: LongBool); override;
{$ENDIF !NEXTGEN}
    ///<summary>Returns a TDBXDate from the row in the Value parameter or sets IsNull to true.</summary>
    procedure GetDate(DbxValue: TDBXDateValue; var Value: TDBXDate;
      var IsNull: LongBool); override;
    ///<summary>Returns an array of byte from the row in the Buffer parameter, and the number
    ///  of bytes copied into the Buffer in the ReturnLength parameter or sets IsNull to true.</summary>
    procedure GetBytes(DbxValue: TDBXByteArrayValue; Offset: Int64;
      const Buffer: TArray<Byte>; BufferOffset: Int64; Length: Int64;
      var ReturnLength: Int64; var IsNull: LongBool); override;
    ///<summary>Returns the DataSize from the row in the ByteLength parameter or sets IsNull to true.</summary>
    procedure GetByteLength(DbxValue: TDBXByteArrayValue; var ByteLength: Int64;
      var IsNull: LongBool); override;
    ///<summary>Returns a TDBXTime from the row in the Value parameter or sets IsNull to true.</summary>
    procedure GetTime(DbxValue: TDBXTimeValue; var Value: TDBXTime;
      var IsNull: LongBool); override;
    ///<summary>Returns a TBcd from the row in the Value parameter or sets IsNull to true.</summary>
    procedure GetBcd(DbxValue: TDBXBcdValue; var Value: TBcd;
      var IsNull: LongBool); override;
    ///<summary>Returns a TSQLTimeStamp from the row in the Value parameter or sets IsNull to true.</summary>
    procedure GetTimeStamp(DbxValue: TDBXTimeStampValue;
      var Value: TSQLTimeStamp; var IsNull: LongBool); override;
    ///<summary>Returns a TSQLTimeStampOffset from the row in the Value parameter or sets IsNull to true.</summary>
    procedure GetTimeStampOffset(DbxValue: TDBXTimeStampOffsetValue;
      var Value: TSQLTimeStampOffset; var IsNull: LongBool); override;
    ///<summary>Returns a TStream from the row in the Value parameter or sets IsNull to true.</summary>
    procedure GetStream(DbxValue: TDBXStreamValue; var Stream: TStream;
      var IsNull: LongBool); overload; override;
    ///<summary>Sets the param value to null.</summary>
    procedure SetNull(DbxValue: TDBXValue); override;
    ///<summary>Sets the param value to the string Value.</summary>
    procedure SetWideString(DbxValue: TDBXWideStringValue;
      const Value: string); override;
    ///<summary>Sets the param value to the Boolean Value.</summary>
    procedure SetBoolean(DbxValue: TDBXBooleanValue; Value: Boolean); override;
    ///<summary>Sets the param value to the Byte Value.</summary>
    procedure SetUInt8(DbxValue: TDBXUInt8Value; Value: Byte); override;
    ///<summary>Sets the param value to the ShortInt Value.</summary>
    procedure SetInt8(DbxValue: TDBXInt8Value; Value: ShortInt); override;
    ///<summary>Sets the param value to the Word Value.</summary>
    procedure SetUInt16(DbxValue: TDBXUInt16Value; Value: Word); override;
    ///<summary>Sets the param value to the SmallInt Value.</summary>
    procedure SetInt16(DbxValue: TDBXInt16Value; Value: SmallInt); override;
    ///<summary>Sets the param value to the Integer Value.</summary>
    procedure SetInt32(DbxValue: TDBXInt32Value; Value: TInt32); override;
    ///<summary>Sets the param value to the Int64 Value.</summary>
    procedure SetInt64(DbxValue: TDBXInt64Value; Value: Int64); override;
    ///<summary>Sets the param value to the Single Value.</summary>
    procedure SetSingle(DbxValue: TDBXSingleValue; Value: Single); override;
    ///<summary>Sets the param value to the Double Value.</summary>
    procedure SetDouble(DbxValue: TDBXDoubleValue; Value: Double); override;
{$IFNDEF NEXTGEN}
    ///<summary>Sets the param value to the AnsiString Value.</summary>
    procedure SetAnsiString(DbxValue: TDBXAnsiStringValue;
      const Value: AnsiString); override;
    ///<summary>Sets the param value to the AnsiString Value.</summary>
    procedure SetString(DbxValue: TDBXAnsiStringValue; const Value: AnsiString); override;
{$ELSE}
    procedure SetString(DbxValue: TDBXAnsiStringValue; const Value: string); override;
{$ENDIF !NEXTGEN}
    ///<summary>Sets the param value to the TDBXDate Value.</summary>
    procedure SetDate(DbxValue: TDBXDateValue; Value: TDBXDate); override;
    ///<summary>Sets the param value to the TDBXTime Value.</summary>
    procedure SetTime(DbxValue: TDBXTimeValue; Value: TDBXTime); override;
    ///<summary>Sets the param value to the TBcd Value.</summary>
    procedure SetBCD(DbxValue: TDBXBcdValue; var Value: TBcd); override;
    ///<summary>Sets the param value to the TSQLTimeStamp Value unless the DataType
    ///  of the DbxValue is TDBXDataTypes.DateTimeType.  In that case, the field value
    ///  is set to a TDateTime after converting Value.
    ///</summary>
    procedure SetTimestamp(DbxValue: TDBXTimeStampValue;
      var Value: TSQLTimeStamp); override;
    ///<summary>Sets the param value to the TSQLTimeStampOffset Value unless the DataType
    ///  of the DbxValue is TDBXDataTypes.DateTimeType.  In that case, the param value
    ///  is set to a TDateTime after converting Value.
    ///</summary>
    procedure SetTimestampOffset(DbxValue: TDBXTimeStampOffsetValue;
      var Value: TSQLTimeStampOffset); override;
    ///<summary>Sets the param value to the TDBXStreamReader Value.</summary>
    procedure SetStream(DbxValue: TDBXStreamValue;
      StreamReader: TDBXStreamReader); override;
    procedure ValueSet(Value: TDBXWritableValue); override;
    procedure SetDynamicBytes(DbxValue:     TDBXValue;
                        Offset:       Int64;
                        const Buffer: TArray<Byte>;
                        BufferOffset: Int64;
                        Length:       Int64); override;
  end;

  /// <summary>TDBXMemoryTable implements a database-independent
  /// dataset.</summary>
  TDBXMemoryTable = class(TDBXTable)
  private
    FIndex: Integer;
    FOrderByColumn: Integer;
    FName: string;
    FValueTypes: TDBXValueTypeArray;
    FValueRows: TList<TDBXWritableValueArray>;

    function CreateWritableValueArray: TDBXWritableValueArray;
    procedure ClearValues(AValues: TDBXWritableValueArray);
    procedure ClearValueTypes(AValueTypes: TDBXValueTypeArray);
  protected
    function GetTableCount: Integer; override;
    procedure OrderByColumn(Column: Integer); virtual;
  public
    procedure Close; override;
    constructor Create;
    destructor Destroy; override;
    procedure Insert; override;
    procedure Post; override;
    procedure Clear; override;
    function InBounds: Boolean; override;
    function Next: Boolean; override;
    function First: Boolean; override;
    procedure SetColumns(const Columns: TDBXValueTypeArray); override;
    function GetColumns: TDBXValueTypeArray; override;
    procedure SetDBXTableName(const AName: string); override;
    function GetDBXTableName: string; override;
    procedure AcceptChanges; override;
    function CreateTableView(const OrderByColumnName: string): TDBXTable; override;
    ///<summary>Checks whether the string key Value is in the Ordinal column.</summary>
    ///<returns>True if the string key is found and False otherwise</returns>
    function FindStringKey(const Ordinal: Integer; const Value: string): Boolean; override;
  end;

  TDBXCache = class
  private
    FOwnsValues: Boolean;
    FValueTypes: TDBXValueTypeArray;
    FValueRows: TList<TDBXWritableValueArray>;
    FInsertedRows: TList<TDBXWritableValueArray>;
    FDeletedRows: TList<TDBXWritableValueArray>;
    FUpdatedRows: TList<TDBXWritableValueArray>;
    procedure ClearChangeLog;
    procedure ClearValues(AValues: TDBXWritableValueArray);
    function CreateWritableValueArray: TDBXWritableValueArray;
    procedure ClearValueTypes(AValueTypes: TDBXValueTypeArray);
  public
    procedure AcceptChanges;
    procedure AddRow(ARow: TDBXWritableValueArray);
    procedure Clear;
    constructor Create; overload;
    constructor Create(AOwnsValues: Boolean); overload;
    procedure DeleteRow(AIndex: Integer);
    destructor Destroy; override;
    function GetColumns: TDBXValueTypeArray;
    procedure Insert(AIndex: Integer);
    procedure SetColumns(Columns: TDBXValueTypeArray);
    property DeletedRows: TList<TDBXWritableValueArray> read FDeletedRows;
    property InsertedRows: TList<TDBXWritableValueArray> read FInsertedRows;
    property OwnsValues: Boolean read FOwnsValues;
    property UpdatedRows: TList<TDBXWritableValueArray> read FUpdatedRows;
    property ValueRows: TList<TDBXWritableValueArray> read FValueRows;
    property ValueTypes: TDBXValueTypeArray read FValueTypes;
  end;

  TDBXTableStorage = class(TDBXTable)
  private
    FIndex: Integer;
    FName: string;
    FCache: TDBXCache;
    FOriginalRow: TDBXTableRow;
    FDeletedTable: TDBXTable;
    FInsertedTable: TDBXTable;
    FUpdatedTable: TDBXTable;
    procedure ClearValues(AValues: TDBXWritableValueArray);
    function CloneRow(const ARow: TDBXWritableValueArray): TDBXWritableValueArray;
    procedure AddRow(const ATable: TDBXTable;
      const ARow: TDBXWritableValueArray; const AClone: Boolean);
    procedure UpdateCurrentRow;
  protected
    function GetDeletedRows: TDBXTable; override;
    function GetInsertedRows: TDBXTable; override;
    function GetUpdatedRows: TDBXTable; override;
    function GetOriginalRow: TDBXTableRow; override;
    function GetTableCount: Integer; override;
    procedure OrderByColumn(Column: Integer); virtual;
  public
    procedure Close; override;
    constructor Create; overload;
    constructor Create(const AOwnsValues: Boolean); overload;
    destructor Destroy; override;
    procedure Insert; overload; override;
    procedure Insert(const AIndex: Integer); reintroduce; overload;
    procedure DeleteRow; overload; override;
    procedure DeleteRow(const AIndex: Integer); reintroduce; overload;
    function GetRow(const AIndex: Integer): TDBXWritableValueArray;
    function Edit: Boolean; override;
    procedure Cancel; override;
    procedure Post; override;
    procedure Clear; override;
    function InBounds: Boolean; override;
    function Next: Boolean; override;
    function First: Boolean; override;
    procedure SetColumns(const Columns: TDBXValueTypeArray); override;
    function GetColumns: TDBXValueTypeArray; override;
    procedure SetDBXTableName(const AName: string); override;
    function GetDBXTableName: string; override;
    procedure AcceptChanges; override;
    procedure CopyFrom(const Source: TDBXTable); override;
    function CreateTableView(const OrderByColumnName: string): TDBXTable; override;
    ///<summary>Checks whether the string key Value is in the Ordinal column.</summary>
    ///<returns>True if the string key is found and False otherwise</returns>
    function FindStringKey(const Ordinal: Integer; const Value: string): Boolean; override;
  end;

  /// <summary>Not used directly by applications.</summary>
  TDBXDBTable = class(TDBXRowTable)
  private
    FCollectionName: string;
    FValueTypes: TDBXValueTypeArray;
    ///<summary> TFieldType to DBX type mapper</summary>
    class function ToDataType(FieldType: TFieldType): Integer; static;
    ///<summary> TFieldType to DBX subtype mapper</summary>
    class function ToDataSubType(FieldType: TFieldType): Integer; static;
    class function ToFieldType(ValueType: TDBXValueType): TFieldType; static;
    class function ToDBXParameterDirection(ParameterType: TParamType): Integer; static;
    class function ToParameterType(ParameterDirection: Integer): TParamType; static;
  protected
    procedure FreeValueTypes;
    property ValueTypes: TDBXValueTypeArray read FValueTypes write FValueTypes;
    property CollectionName: string read FCollectionName;
    procedure SetDBXTableName(const CollectionName: string); override;
    function GetDBXTableName: string; override;
  end;

  /// <summary>TDBXTable implementation for TParams object used by
  /// TDBXParamsReader.</summary>
  TDBXParamsTable = class(TDBXDBTable)
  private
    FParams:        TParams;
    FAtEnd:         Boolean;
    FInstanceOwner: Boolean;

    class procedure CopyValueTypes(const ValueTypes: TDBXValueTypeArray; const Params: TParams); static;
    class procedure CopyValueType(Ordinal: Integer; ValueType: TDBXValueType; Param: TParam); static;
  protected
    function GetColumns: TDBXValueTypeArray; override;
    procedure SetColumns(const Columns: TDBXValueTypeArray); override;
    function GetStorage: TObject; override;
  public
    constructor Create; overload;
    constructor Create(Params: TParams; InstanceOwner: Boolean = true); overload;
    destructor Destroy; override;
    function First: Boolean; override;
    function Next: Boolean; override;
    function InBounds: Boolean; override;
    procedure Close; override;
    function GetOrdinal(const ColumnName: string): Integer; override;
  end;


  /// <summary>TDBXReader implementation for TParams object.</summary>
  TDBXParamsReader = class(TDBXTableReader)
  public
    /// <summary>
    /// Creates a <c>TDBXReader</c> for a <c>TParams</c> instance.  If
    /// <c>InstanceOwner</c> is true, the <c>TParams</c> instance will be
    /// freed when this <c>TDBXParamsReader</c> instance is freed.
    /// </summary>
    constructor Create(Params: TParams; InstanceOwner: Boolean = true);
    /// <summary>
    /// Copies the contents of the current <c>Reader</c> row into the <c>Params</c>
    /// instance.
    /// </summary>
    class procedure CopyReaderToParams(Reader: TDBXReader; Params: TParams); static;
    /// <summary>
    /// Copies the contents of the current <c>Reader</c> row into a new <c>TParams</c>
    /// instance.  The new <c>TParams</c> instance will constructed with the
    /// <c>AOwner</c> instance as its owner.
    /// </summary>
    class function ToParams(AOwner: TPersistent; Reader: TDBXReader;
      AOwnsInstance: Boolean): TParams; static;
    destructor Destroy; override;
  end;

  /// <summary>Not used directly by applications.</summary>
  TDBXDataSetRow = class(TDBXRow)
  private
    [Weak]FTable: TDataset;
    function EnsureEditState: Boolean;
  public
    constructor Create(Table: TDataset);
    ///<summary>Returns a TDBXWideStringBuiler from the row in the WideStringBuilder
    ///  parameter or sets IsNull to true.</summary>
    procedure GetWideString(DbxValue: TDBXWideStringValue;
      var WideStringBuilder: TDBXWideStringBuilder; var IsNull: LongBool); override;
    ///<summary>Returns a LongBool from the row in the Value parameter or sets IsNull to true.</summary>
    procedure GetBoolean(DbxValue: TDBXBooleanValue; var Value: LongBool;
      var IsNull: LongBool); override;
    ///<summary>Returns a Byte from the row in the Value parameter or sets IsNull to true.</summary>
    procedure GetUInt8(DbxValue: TDBXUInt8Value; var Value: Byte;
      var IsNull: LongBool); override;
    ///<summary>Returns a ShortInt from the row in the Value parameter or sets IsNull to true.</summary>
    procedure GetInt8(DbxValue: TDBXInt8Value; var Value: ShortInt;
      var IsNull: LongBool); override;
    ///<summary>Returns a Word from the row in the Value parameter or sets IsNull to true.</summary>
    procedure GetUInt16(DbxValue: TDBXUInt16Value; var Value: Word;
      var IsNull: LongBool); override;
    ///<summary>Returns a SmallInt from the row in the Value parameter or sets IsNull to true.</summary>
    procedure GetInt16(DbxValue: TDBXInt16Value; var Value: SmallInt;
      var IsNull: LongBool); override;
    ///<summary>Returns an Integer from the row in the Value parameter or sets IsNull to true.</summary>
    procedure GetInt32(DbxValue: TDBXInt32Value; var Value: TInt32;
      var IsNull: LongBool); override;
    ///<summary>Returns an Int64 from the row in the Value parameter or sets IsNull to true.</summary>
    procedure GetInt64(DbxValue: TDBXInt64Value; var Value: Int64;
      var IsNull: LongBool); override;
    ///<summary>Returns a Single from the row in the Value parameter or sets IsNull to true.</summary>
    procedure GetSingle(DbxValue: TDBXSingleValue; var Value: Single;
      var IsNull: LongBool); override;
    ///<summary>Returns a Double from the row in the Value parameter or sets IsNull to true.</summary>
    procedure GetDouble(DbxValue: TDBXDoubleValue; var Value: Double;
      var IsNull: LongBool); override;
    ///<summary>Returns a PAnsiChar from the row in the AnsiStringBuilder parameter
    ///  or sets IsNull to true.</summary>
{$IFNDEF NEXTGEN}
    procedure GetAnsiString(DbxValue: TDBXAnsiStringValue;
      var AnsiStringBuilder: TDBXAnsiStringBuilder; var IsNull: LongBool); override;
{$ENDIF !NEXTGEN}
    ///<summary>Returns a TDBXDate from the row in the Value parameter or sets IsNull to true.</summary>
    procedure GetDate(DbxValue: TDBXDateValue; var Value: TDBXDate;
      var IsNull: LongBool); override;
    ///<summary>Returns a TDBXTime from the row in the Value parameter or sets IsNull to true.</summary>
    procedure GetTime(DbxValue: TDBXTimeValue; var Value: TDBXTime;
      var IsNull: LongBool); override;
    ///<summary>Returns a TSQLTimeStamp from the row in the Value parameter or sets IsNull to true.</summary>
    procedure GetTimeStamp(DbxValue: TDBXTimeStampValue;
      var Value: TSQLTimeStamp; var IsNull: LongBool); override;
    ///<summary>Returns a TSQLTimeStampOffset from the row in the Value parameter or sets IsNull to true.</summary>
    procedure GetTimeStampOffset(DbxValue: TDBXTimeStampOffsetValue;
      var Value: TSQLTimeStampOffset; var IsNull: LongBool); override;
    ///<summary>Returns a TBcd from the row in the Value parameter or sets IsNull to true.</summary>
    procedure GetBcd(DbxValue: TDBXBcdValue; var Value: TBcd;
      var IsNull: LongBool); override;
    ///<summary>Returns an array of byte from the row in the Buffer parameter, and the number
    ///  of bytes copied into the Buffer in the ReturnLength parameter or sets IsNull to true.
    ///</summary>
    procedure GetBytes(DbxValue: TDBXByteArrayValue; Offset: Int64;
      const Buffer: TArray<Byte>; BufferOffset: Int64; Length: Int64;
      var ReturnLength: Int64; var IsNull: LongBool); override;
    ///<summary>Returns the DataSize or the BlobSize from the row in the ByteLength
    ///  parameter or sets IsNull to true.</summary>
    procedure GetByteLength(DbxValue: TDBXByteArrayValue; var ByteLength: Int64;
      var IsNull: LongBool); override;
    ///<summary>Returns a TStream from the row in the Stream parameter or sets IsNull to true.</summary>
    procedure GetStream(DbxValue: TDBXStreamValue; var Stream: TStream;
      var IsNull: LongBool); overload; override;
    ///<summary>Sets the field value to null.</summary>
    procedure SetNull(DbxValue: TDBXValue); override;
    ///<summary>Sets the field value to the string Value.</summary>
    procedure SetWideString(DbxValue: TDBXWideStringValue;
      const Value: string); override;
    ///<summary>Sets the field value to the Boolean Value.</summary>
    procedure SetBoolean(DbxValue: TDBXBooleanValue; Value: Boolean); override;
    ///<summary>Sets the field value to the Byte Value.</summary>
    procedure SetUInt8(DbxValue: TDBXUInt8Value; Value: Byte); override;
    ///<summary>Sets the field value to the ShortInt Value.</summary>
    procedure SetInt8(DbxValue: TDBXInt8Value; Value: ShortInt); override;
    ///<summary>Sets the field value to the Word Value.</summary>
    procedure SetUInt16(DbxValue: TDBXUInt16Value; Value: Word); override;
    ///<summary>Sets the field value to the SmallInt Value.</summary>
    procedure SetInt16(DbxValue: TDBXInt16Value; Value: SmallInt); override;
    ///<summary>Sets the field value to the Integer Value.</summary>
    procedure SetInt32(DbxValue: TDBXInt32Value; Value: TInt32); override;
    ///<summary>Sets the field value to the Int64 Value.</summary>
    procedure SetInt64(DbxValue: TDBXInt64Value; Value: Int64); override;
    ///<summary>Sets the field value to the Single Value.</summary>
    procedure SetSingle(DbxValue: TDBXSingleValue; Value: Single); override;
    ///<summary>Sets the field value to the Double Value.</summary>
    procedure SetDouble(DbxValue: TDBXDoubleValue; Value: Double); override;
{$IFNDEF NEXTGEN}
    ///<summary>Sets the field value to AnsiString Value.</summary>
    procedure SetAnsiString(DbxValue: TDBXAnsiStringValue;
      const Value: AnsiString); override;
    ///<summary>Sets the field value to the Value.</summary>
    procedure SetString(DbxValue: TDBXAnsiStringValue; const Value: AnsiString); override;
{$ELSE}
    procedure SetString(DbxValue: TDBXAnsiStringValue; const Value: string); override;
{$ENDIF !NEXTGEN}
    ///<summary>Sets the field value to a TDateTime after converting Value.</summary>
    procedure SetDate(DbxValue: TDBXDateValue; Value: TDBXDate); override;
    ///<summary>Sets the field value to a TDateTime after converting Value.</summary>
    procedure SetTime(DbxValue: TDBXTimeValue; Value: TDBXTime); override;
    ///<summary>Sets the field value to the TBcd Value.</summary>
    procedure SetBCD(DbxValue: TDBXBcdValue; var Value: TBcd); override;
    procedure SetStream(DbxValue:     TDBXStreamValue;
                        StreamReader: TDBXStreamReader); override;
    procedure SetDynamicBytes(DbxValue: TDBXValue;
                              Offset: Int64;
                              const Buffer: TArray<Byte>;
                              BufferOffset: Int64;
                              Length: Int64); override;
    ///<summary>Sets the field value to the TSQLTimeStamp Value unless the DataType
    ///  of the DbxValue is TDBXDataTypes.DateTimeType.  In that case, the field value
    ///  is set to a TDateTime after converting Value.
    ///</summary>
    procedure SetTimestamp(DbxValue: TDBXTimeStampValue;
      var Value: TSQLTimeStamp); override;
    ///<summary>Sets the field value to the TSQLTimeStampOffset Value unless the DataType
    ///  of the DbxValue is TDBXDataTypes.DateTimeType.  In that case, the field value
    ///  is set to a TDateTime after converting Value.
    ///</summary>
    procedure SetTimestampOffset(DbxValue: TDBXTimeStampOffsetValue;
      var Value: TSQLTimeStampOffset); override;
    procedure ValueSet(Value: TDBXWritableValue); override;
  end;

  /// <summary>TDBXTable implementation for TParams.</summary>
  TDBXDataSetTable = class(TDBXDBTable)
  private
    FOwnsTable: Boolean;
    FTable: TDataset;
  protected
    constructor Create(const CollectionName: string; Table: TDataset;
      OwnsTable: Boolean; ValuesNeedCreate: Boolean); overload;
    property Table: TDataset read FTable;
    procedure SkipOriginalRow; virtual;
    procedure SetDBXTableName(const CollectionName: string); override;
    function GetDBXTableName: string; override;
    function GetColumns: TDBXValueTypeArray; override;
    function GetStorage: TObject; override;
    function GetDataSize(FieldDef: TFieldDef; Field: TField): Integer;
  public
    constructor Create(Dataset: TDataset; InstanceOwner: Boolean = true); overload;
    destructor Destroy; override;
    function First: Boolean; override;
    function Next: Boolean; override;
    function InBounds: Boolean; override;
    procedure Insert; override;
    procedure Post; override;
    procedure DeleteRow; override;
    procedure Close; override;
    function GetOrdinal(const ColumnName: string): Integer; override;
    procedure FailIfRowIsNew;
    procedure CopyValueTypeProperties(FieldDef: TFieldDef;
      ValueType: TDBXValueType; Ordinal: Integer);
  end;

  /// <summary>TDBXReader implementation for TDataSet object.</summary>
  TDBXDataSetReader = class(TDBXTableReader)
  public
    /// <summary>
    /// Creates a <c>TDBXReader</c> for a <c>TDataSet</c> instance.  If
    /// <c>InstanceOwner</c> is true, the <c>TDataSet</c> instance will be
    /// freed when this <c>TDBXDataSetReader</c> instance is freed.
    /// </summary>
    constructor Create(Params: TDataset; InstanceOwner: Boolean = true); overload; virtual;
    constructor Create(Params: TDBXDataSetTable); overload;
  end;

implementation

uses
  System.Variants,
  System.Generics.Defaults,
  System.JSON,
  Data.DBXJSON,
  Data.DBXCommonResStrs
;

type
  TDBXMemoryValue = class(TDBXWritableValue)
  private
    FValue: TDBXWritableValue;
    FOriginalValue: TDBXWritableValue;
    FInitialized: Boolean;
//    FOwner: TDBXCache;
  public
    procedure SetOriginal;
    procedure ClearOriginal;
    procedure Cancel;
    procedure AcceptChanges;
    constructor Create(const AOriginalValue: TDBXWritableValue{; Owner: TDBXCache});
    destructor Destroy; override;
    function GetValueSize: Int64; override;
{$IFNDEF NEXTGEN}
    function GetAnsiString: AnsiString; override;
{$ENDIF !NEXTGEN}
    function GetDate: TDBXDate; override;
    function GetBoolean: Boolean; override;
    function GetTime: TDBXTime; override;
    function GetWideString: string; override;
    function GetString: string; override;
    function GetUInt8: Byte; override;
    function GetInt8: ShortInt; override;
    function GetUInt16: Word; override;
    function GetInt16: SmallInt; override;
    function GetInt32: TInt32; override;
    function GetInt64: Int64; override;
    function GetSingle: Single; override;
    function GetDouble: Double; override;
    function GetBytes(Offset: Int64; const Buffer: TArray<Byte>; BufferOffset, Length: Int64): Int64; override;
    function GetTimeStamp: TSQLTimeStamp; override;
    function GetTimeStampOffset: TSQLTimeStampOffset; override;
    function GetBcd: TBcd; override;
    function GetDBXReader(AInstanceOwner: Boolean): TDBXReader; override;
    function GetDBXReader: TDBXReader; override;
    function GetDBXConnection: TDBXConnection; override;
    function GetStream(AInstanceOwner: Boolean): TStream; override;
    function GetStream: TStream; override;
    function GetJSONValue: TJSONValue; override;
    function GetJSONValue(AInstanceOwner: Boolean): TJSONValue; override;
    function GetCallbackValue: TDBXCallback; override;
    function GetObjectValue: TObject; override;
    function GetObjectValue(AInstanceOwner: Boolean): TObject; override;
    function GetWideString(defaultValue: string): string; override;
    function GetBoolean(defaultValue: Boolean): Boolean; override;
    function GetUInt8(defaultValue: Byte): Byte; override;
    function GetInt8(defaultValue: Shortint): Shortint; override;
    function GetUInt16(defaultValue: Word): Word; override;
    function GetInt16(defaultValue: Smallint): Smallint; override;
    function GetInt32(defaultValue: TInt32): TInt32; override;
    function GetInt64(defaultValue: Int64): Int64; override;
    function EqualsValue(Other: TDBXValue): Boolean; override;
    function Compare(Other: TDBXValue): Smallint; override;

    function IsNull: Boolean; override;
    procedure SetNull; override;
    procedure SetTimeStamp(const Value: TSQLTimeStamp); override;
    procedure SetTimeStampOffset(const Value: TSQLTimeStampOffset); override;
    procedure SetBcd(const Value: TBcd); override;
{$IFNDEF NEXTGEN}
    procedure SetAnsiString(const Value: AnsiString); override;
{$ENDIF !NEXTGEN}
    procedure SetBoolean(const Value: Boolean); override;
    procedure SetDate(const Value: TDBXDate); override;
    procedure SetTime(const Value: TDBXTime); override;
    procedure SetWideString(const Value: string); override;
    procedure SetString(const Value: string); override;
    procedure SetUInt8(const Value: Byte); override;
    procedure SetInt8(const Value: ShortInt); override;
    procedure SetUInt16(const Value: Word); override;
    procedure SetInt16(const Value: SmallInt); override;
    procedure SetInt32(const Value: TInt32); override;
    procedure SetInt64(const Value: Int64); override;
    procedure SetSingle(const Value: Single); override;
    procedure SetDouble(const Value: Double); override;
    procedure SetStaticBytes( Offset:       Int64;
                        const Buffer: array of Byte;
                        BufferOffset: Int64;
                        Length:       Int64); override;
    procedure SetDynamicBytes( Offset:       Int64;
                        const Buffer:   TArray<Byte>;
                        BufferOffset: Int64;
                        Length:       Int64); override;
    procedure SetDBXReader(const Value: TDBXReader; const AInstanceOwner: Boolean); overload; override;
    procedure SetStream(const Stream: TStream; const AInstanceOwner: Boolean); override;
    procedure SetDBXConnection(const Value: TDBXConnection); override;
    procedure SetJSONValue(const Value: TJSONValue; const AInstanceOwner: Boolean); override;
    procedure SetObjectValue(const Value: TObject; const AInstanceOwner: Boolean); override;
    procedure SetCallbackValue(const Value: TDBXCallback); override;
    procedure SetValue(const Value: TDBXValue); override;
  end;

  TDBXWritableValueArrayComparer = class(TInterfacedObject, IComparer<TDBXWritableValueArray>)
  private
    FColumnIndex: Integer;
  public
    constructor Create(AColumnIndex: Integer);
    function Compare(const Left, Right: TDBXWritableValueArray): Integer; overload;
    class function CompareArrays(const Left, Right: TDBXWritableValueArray): Boolean; overload;
    property ColumnIndex: Integer read FColumnIndex;
    class function FindStringKey(const AValuesList: TList<TDBXWritableValueArray>;
      const Ordinal: Integer; const Value: string): Integer;
  end;

  { TDBXDataSetTable }

constructor TDBXDataSetTable.Create(const CollectionName: string; Table: TDataSet; OwnsTable: Boolean; ValuesNeedCreate: Boolean);
begin
  inherited Create(nil, TDBXDataSetRow.Create(Table));
  FTable := Table;
  FCollectionName := CollectionName;
  FOwnsTable := OwnsTable;
  if ValuesNeedCreate then
    CreateValues;
end;

destructor TDBXDataSetTable.Destroy;
begin
  if FOwnsTable then
    FreeAndNil(FTable);
  FreeValueTypes;
  inherited Destroy;
end;

function TDBXDataSetTable.First: Boolean;
begin
  RowNavigated;
  // Some implementations don't support this.
  //
  if FTable.IsUniDirectional then
    Result := not FTable.IsEmpty
  else
  begin
    FTable.First;
    SkipOriginalRow;
    Result := FTable.RecordCount > 0;
  end;
end;

function TDBXDataSetTable.Next: Boolean;
begin
  FailIfRowIsNew();
  FTable.Next;
  SkipOriginalRow;
  RowNavigated;
  Result := not FTable.Eof;
end;

function TDBXDataSetTable.InBounds: Boolean;
begin
  FailIfRowIsNew();
  Result := not FTable.Eof and (FTable.RecordCount > 0);
//  if Result and FTable.Bof then
//    FTable.Next;
end;

procedure TDBXDataSetTable.Insert;
begin
  FailIfRowIsNew();
  FTable.Append;
end;

procedure TDBXDataSetTable.Post;
begin
  if FTable.State <> dsInsert then
    raise TDBXError.Create(SInsertNotCalled);
  FTable.Post;
end;

procedure TDBXDataSetTable.DeleteRow;
begin
  if FTable.State = dsInsert then
    FTable.Cancel
  else
    FTable.Delete;
end;

procedure TDBXDataSetTable.Close;
begin
  Clear;
end;

function TDBXDataSetTable.GetOrdinal(const ColumnName: string): Integer;
var
  FieldDef: TFieldDef;
begin
  FieldDef := FTable.FieldDefs.Find(ColumnName);
  Result := FieldDef.FieldNo - 1;
end;

function TDBXDataSetTable.GetDataSize(FieldDef: TFieldDef;
  Field: TField): Integer;
begin
  case FieldDef.DataType of
    ftVarBytes:
      Result := Field.DataSize - sizeof(Word);
  else
    if Field is TBlobField then
      Result := (Field as TBlobField).BlobSize
    else
      Result := Field.DataSize;
  end;
end;

function TDBXDataSetTable.GetDBXTableName: string;
begin
  Result := FCollectionName;
end;

procedure TDBXDataSetTable.SetDBXTableName(const CollectionName: string);
begin
  FCollectionName := CollectionName;
end;

procedure TDBXDataSetTable.SkipOriginalRow;
begin

end;

function TDBXDataSetTable.GetColumns: TDBXValueTypeArray;
var
  Ordinal:        Integer;
  FieldDef:       TFieldDef;
  ValueType:      TDBXValueType;
  Field:          TField;
begin
  if FValueTypes = nil then
  begin
    SetLength(FValueTypes, FTable.FieldDefs.Count);
    for Ordinal := Low(FValueTypes) to High(FValueTypes) do
    begin
      FieldDef                := FTable.FieldDefs[Ordinal];
      Field                   := FTable.Fields[Ordinal];
      ValueType               := TDBXValueType.Create;
      ValueType.Name          := FieldDef.Name;
      ValueType.DisplayName   := FieldDef.DisplayName;
      ValueType.DataType      := ToDataType(FieldDef.DataType);
      ValueType.SubType       := ToDataSubType(FieldDef.DataType);
      ValueType.Size          := GetDataSize(FieldDef, Field);
      ValueType.Precision     := FieldDef.Precision;
      if ValueType.Precision = 0 then
        case ValueType.DataType of
        TDBXDataTypes.WideStringType, TDBXDataTypes.BlobType:
          ValueType.Precision := ValueType.Size;
        end;
      ValueType.Scale         := FieldDef.Size;
      FValueTypes[Ordinal]    := ValueType;
    end;
  end;
  Result := FValueTypes;
end;

function TDBXDataSetTable.GetStorage: TObject;
begin
  Result := FTable;
end;

procedure TDBXDataSetTable.FailIfRowIsNew;
begin
  if FTable.State = dsInsert then
    raise TDBXError.Create(SPostNotCalled);
end;

procedure TDBXDataSetTable.CopyValueTypeProperties(FieldDef: TFieldDef; ValueType: TDBXValueType; Ordinal: Integer);
begin
  FieldDef.Name := ValueType.Name;
  FieldDef.DisplayName := ValueType.DisplayName;
  FieldDef.DataType := ToFieldType(ValueType);
  FieldDef.FieldNo := Ordinal;
  if (ValueType.DataType = TDBXDataTypes.WideStringType) or (ValueType.DataType = TDBXDataTypes.AnsiStringType) then
  begin
    if ValueType.Size <= 0 then
      FieldDef.Size := 128 // default size (make constant)
    else
      FieldDef.Size := ValueType.Size;
  end;

// Don't set the size. It is error prone and not neccessary:
//  FieldDef.Size := Descriptor.DataSize;
// Don't set the hidden attribute. Field access is forbidden to hidden fields !!
//  if Descriptor.Hidden then
//    FieldDef.Attributes := FieldDef.Attributes + [faHiddenCol];
end;

constructor TDBXDataSetTable.Create(Dataset: TDataSet; InstanceOwner: Boolean);
begin
  Create('', DataSet, InstanceOwner, true);
end;

{ TDBXDataSetRow }

constructor TDBXDataSetRow.Create(Table: TDataSet);
begin
  inherited Create(nil);
  FTable := Table;
end;

procedure TDBXDataSetRow.GetBoolean(DbxValue: TDBXBooleanValue;
  var Value, IsNull: LongBool);
var
  Field: TField;
begin
  Field := FTable.Fields[DbxValue.ValueType.Ordinal];
  IsNull := Field.IsNull;
  if not IsNull then
    Value := Field.AsBoolean;
end;

procedure TDBXDataSetRow.GetInt16(DbxValue: TDBXInt16Value; var Value: SmallInt;
  var IsNull: LongBool);
var
  Field: TField;
begin
  Field := FTable.Fields[DbxValue.ValueType.Ordinal];
  IsNull := Field.IsNull;
  if not IsNull then
    Value := Field.Value;
end;

procedure TDBXDataSetRow.GetInt32(DbxValue: TDBXInt32Value; var Value: TInt32;
  var IsNull: LongBool);
var
  Field: TField;
begin
  Field := FTable.Fields[DbxValue.ValueType.Ordinal];
  IsNull := Field.IsNull;
  if not IsNull then
    Value := Field.AsInteger;
end;

procedure TDBXDataSetRow.GetInt64(DbxValue: TDBXInt64Value; var Value: Int64;
  var IsNull: LongBool);
var
  Field: TField;
begin
  Field := FTable.Fields[DbxValue.ValueType.Ordinal];
  IsNull := Field.IsNull;
  if not IsNull then
    Value := Field.Value;
end;

procedure TDBXDataSetRow.GetInt8(DbxValue: TDBXInt8Value; var Value: ShortInt;
  var IsNull: LongBool);
var
  Field: TField;
begin
  Field := FTable.Fields[DbxValue.ValueType.Ordinal];
  IsNull := Field.IsNull;
  if not IsNull then
    Value := Field.Value;
end;

procedure TDBXDataSetRow.GetDouble(DbxValue: TDBXDoubleValue; var Value: Double; var IsNull: LongBool);
var
  Field: TField;
begin
  Field := FTable.Fields[DbxValue.ValueType.Ordinal];
  IsNull := Field.IsNull;
  if not IsNull then
    Value := Field.Value;
end;

procedure TDBXDataSetRow.GetWideString(DbxValue: TDBXWideStringValue;
  var WideStringBuilder: TDBXWideStringBuilder; var IsNull: LongBool);
var
  Field: TField;
  Value: string;
begin
  Field := FTable.Fields[DbxValue.ValueType.Ordinal];
  IsNull := Field.IsNull;
  if not IsNull then
  begin
    Value := Field.AsWideString;
    TDBXPlatform.CopyWideStringToBuilder(Value, Value.Length+1, WideStringBuilder);
  end;
end;

{$IFNDEF NEXTGEN}
procedure TDBXDataSetRow.GetAnsiString(DbxValue: TDBXAnsiStringValue; var AnsiStringBuilder: TDBXAnsiStringBuilder; var IsNull: LongBool);
var
  Field: TField;
  Value: AnsiString;
begin
  Field := FTable.Fields[DbxValue.ValueType.Ordinal];
  IsNull := Field.IsNull;
  if not IsNull then
  begin
    Value := Field.AsAnsiString;
    TDBXPlatform.CopyStringToBuilder(Value, Length(Value)+1, AnsiStringBuilder);
  end;
end;
{$ENDIF !NEXTGEN}

procedure TDBXDataSetRow.GetDate(DbxValue: TDBXDateValue; var Value: TDBXDate; var IsNull: LongBool);
var
  Field: TField;
begin
  Field := FTable.Fields[DbxValue.ValueType.Ordinal];
  IsNull := Field.IsNull;
  if not IsNull then
    Value := DateTimeToTimeStamp(Field.AsDateTime).Date;
end;

procedure TDBXDataSetRow.GetTime(DbxValue: TDBXTimeValue; var Value: TDBXTime; var IsNull: LongBool);
var
  Field: TField;
begin
  Field := FTable.Fields[DbxValue.ValueType.Ordinal];
  IsNull := Field.IsNull;
  if not IsNull then
    Value := DateTimeToTimeStamp(Field.AsDateTime).Time;
end;

procedure TDBXDataSetRow.GetTimeStamp(DbxValue: TDBXTimeStampValue; var Value: TSQLTimeStamp; var IsNull: LongBool);
var
  Field: TField;
begin
  Field := FTable.Fields[DbxValue.ValueType.Ordinal];
  IsNull := Field.IsNull;
  if not IsNull then
    Value := Field.AsSQLTimeStamp;
end;

procedure TDBXDataSetRow.GetTimeStampOffset(DbxValue: TDBXTimeStampOffsetValue;
  var Value: TSQLTimeStampOffset; var IsNull: LongBool);
var
  Field: TField;
begin
  Field := FTable.Fields[DbxValue.ValueType.Ordinal];
  IsNull := Field.IsNull;
  if not IsNull then
    Value := Field.AsSQLTimeStampOffset;
end;

procedure TDBXDataSetRow.GetUInt16(DbxValue: TDBXUInt16Value; var Value: Word;
  var IsNull: LongBool);
var
  Field: TField;
begin
  Field := FTable.Fields[DbxValue.ValueType.Ordinal];
  IsNull := Field.IsNull;
  if not IsNull then
    Value := Field.Value;
end;

procedure TDBXDataSetRow.GetUInt8(DbxValue: TDBXUInt8Value; var Value: Byte;
  var IsNull: LongBool);
var
  Field: TField;
begin
  Field := FTable.Fields[DbxValue.ValueType.Ordinal];
  IsNull := Field.IsNull;
  if not IsNull then
    Value := Field.Value;
end;

procedure TDBXDataSetRow.GetBcd(DbxValue: TDBXBcdValue; var Value: TBcd; var IsNull: LongBool);
var
  Field: TField;
begin
  Field := FTable.Fields[DbxValue.ValueType.Ordinal];
  IsNull := Field.IsNull;
  if not IsNull then
    Value := Field.AsBCD;
end;

procedure TDBXDataSetRow.GetBytes(DbxValue: TDBXByteArrayValue; Offset: Int64; const Buffer: TArray<Byte>; BufferOffset: Int64; Length: Int64; var ReturnLength: Int64; var IsNull: LongBool);
var
  Field: TField;
  DataSize: Integer;
begin
  Field := FTable.Fields[DbxValue.ValueType.Ordinal];
  IsNull := Field.IsNull;
  if not IsNull then
  begin
    if Field is TBlobField then
      DataSize := (Field as TBlobField).BlobSize
    else
      DataSize := Field.DataSize;
    if Length + BufferOffset > DataSize then
      ReturnLength := DataSize - BufferOffset
    else
      ReturnLength := Length;

    Move(Field.AsBytes[0], Buffer[BufferOffset], ReturnLength);
  end;
end;

procedure TDBXDataSetRow.GetByteLength(DbxValue: TDBXByteArrayValue; var ByteLength: Int64; var IsNull: LongBool);
var
  Field: TField;
begin
  Field := FTable.Fields[DbxValue.ValueType.Ordinal];
  IsNull := Field.IsNull;
  if not IsNull then
    if Field is TBlobField then
      ByteLength := (Field as TBlobField).BlobSize
    else
      ByteLength := Field.DataSize;
end;

procedure TDBXDataSetRow.GetSingle(DbxValue: TDBXSingleValue; var Value: Single;
  var IsNull: LongBool);
var
  Field: TField;
begin
  Field := FTable.Fields[DbxValue.ValueType.Ordinal];
  IsNull := Field.IsNull;
  if not IsNull then
    Value := Field.Value;
end;

procedure TDBXDataSetRow.GetStream(DbxValue: TDBXStreamValue;
  var Stream: TStream; var IsNull: LongBool);
var
  ByteLength: Int64;
  Bytes: TArray<Byte>;
  ReturnLength: Int64;
begin
  GetByteLength(DbxValue, ByteLength, IsNull);
  if not IsNull then
  begin
    SetLength(Bytes, Integer(ByteLength));
    GetBytes(DbxValue, 0, Bytes, 0, Integer(ByteLength), ReturnLength, IsNull);
    Stream := TBytesStream.Create(Bytes);
  end;
end;

procedure TDBXDataSetRow.SetBoolean(DbxValue: TDBXBooleanValue; Value: Boolean);
begin
  EnsureEditState;
  FTable.Fields[DbxValue.ValueType.Ordinal].Value := Value;
end;

procedure TDBXDataSetRow.SetInt16(DbxValue: TDBXInt16Value; Value: SmallInt);
begin
  EnsureEditState;
  FTable.Fields[DbxValue.ValueType.Ordinal].Value := Value;
end;

procedure TDBXDataSetRow.SetInt32(DbxValue: TDBXInt32Value; Value: TInt32);
begin
  EnsureEditState;
  FTable.Fields[DbxValue.ValueType.Ordinal].Value := Value;
end;

procedure TDBXDataSetRow.SetInt64(DbxValue: TDBXInt64Value; Value: Int64);
begin
  EnsureEditState;
  FTable.Fields[DbxValue.ValueType.Ordinal].Value := Value;
end;

procedure TDBXDataSetRow.SetInt8(DbxValue: TDBXInt8Value; Value: ShortInt);
begin
  EnsureEditState;
  FTable.Fields[DbxValue.ValueType.Ordinal].Value := Value;
end;

procedure TDBXDataSetRow.SetDouble(DbxValue: TDBXDoubleValue; Value: Double);
begin
  EnsureEditState;
  FTable.Fields[DbxValue.ValueType.Ordinal].Value := Value;
end;

procedure TDBXDataSetRow.SetNull(DbxValue: TDBXValue);
begin
  EnsureEditState;
  FTable.Fields[DbxValue.ValueType.Ordinal].Value := Null;
end;

procedure TDBXDataSetRow.SetSingle(DbxValue: TDBXSingleValue; Value: Single);
begin
  EnsureEditState;
  FTable.Fields[DbxValue.ValueType.Ordinal].Value := Value;
end;

procedure TDBXDataSetRow.SetStream(DbxValue: TDBXStreamValue;
  StreamReader: TDBXStreamReader);
var
  LData: TArray<Byte>;
  LRead: Integer;
  LTotalRead: Integer;
const
  sMaxRead = 32000;                                                 
begin
  EnsureEditState;

  if StreamReader.Size > 0 then
  begin
    SetLength(LData, StreamReader.Size);
    LTotalRead := StreamReader.Read(LData, 0, StreamReader.Size);
    if LTotalRead < StreamReader.Size then
      SetLength(LData, LTotalRead);
  end
  else
  begin
    LTotalRead := 0;
    while not StreamReader.Eos do
    begin
      SetLength(LData, sMaxRead+LTotalRead);
      LRead := StreamReader.Read(LData, LTotalRead, sMaxRead);
      if LRead < sMaxRead then
        SetLength(LData, LTotalRead + LRead);
      LTotalRead := LTotalRead + LRead;
    end;
  end;
  FTable.Fields[DbxValue.ValueType.Ordinal].AsBytes := LData;
end;

{$IFNDEF NEXTGEN}
procedure TDBXDataSetRow.SetAnsiString(DbxValue: TDBXAnsiStringValue; const Value: AnsiString);
begin
  EnsureEditState;
  FTable.Fields[DbxValue.ValueType.Ordinal].Value := Value;
end;

procedure TDBXDataSetRow.SetString(DbxValue: TDBXAnsiStringValue;
  const Value: AnsiString);
begin
  EnsureEditState;
  FTable.Fields[DbxValue.ValueType.Ordinal].Value := Value;
end;
{$ELSE}
procedure TDBXDataSetRow.SetString(DbxValue: TDBXAnsiStringValue;
  const Value: string);
begin
  EnsureEditState;
  FTable.Fields[DbxValue.ValueType.Ordinal].Value := Value;
end;
{$ENDIF !NEXTGEN}

procedure TDBXDataSetRow.SetWideString(DbxValue: TDBXWideStringValue;
  const Value: string);
begin
  EnsureEditState;
  FTable.Fields[DbxValue.ValueType.Ordinal].Value := Value;
end;

procedure TDBXDataSetRow.SetDate(DbxValue: TDBXDateValue; Value: TDBXDate);
var
  TimeStamp: TTimeStamp;
begin
  TimeStamp.Date := Value;
  TimeStamp.Time := 0;
  EnsureEditState;
  FTable.Fields[DBXValue.ValueType.Ordinal].AsDateTime := TimeStampToDateTime(TimeStamp);
end;

procedure TDBXDataSetRow.SetTime(DbxValue: TDBXTimeValue; Value: TDBXTime);
var
  TimeStamp: TTimeStamp;
begin
  TimeStamp.Date := DateDelta;
  TimeStamp.Time := Value;
  EnsureEditState;
  FTable.Fields[DBXValue.ValueType.Ordinal].AsDateTime := TimeStampToDateTime(TimeStamp);
end;

procedure TDBXDataSetRow.SetTimestamp(DbxValue: TDBXTimeStampValue;
  var Value: TSQLTimeStamp);
begin
  EnsureEditState;
  if DbxValue.ValueType.DataType = TDBXDataTypes.DateTimeType then
    FTable.Fields[DBXValue.ValueType.Ordinal].AsDateTime := SQLTimeStampToDateTime(Value)
  else
    FTable.Fields[DbxValue.ValueType.Ordinal].AsSQLTimeStamp := Value;
end;

procedure TDBXDataSetRow.SetTimestampOffset(DbxValue: TDBXTimeStampOffsetValue;
  var Value: TSQLTimeStampOffset);
begin
  EnsureEditState;
  if DbxValue.ValueType.DataType = TDBXDataTypes.DateTimeType then
    FTable.Fields[DBXValue.ValueType.Ordinal].AsDateTime := SQLTimeStampOffsetToDateTime(Value)
  else
    FTable.Fields[DbxValue.ValueType.Ordinal].AsSQLTimeStampOffset := Value;
end;

procedure TDBXDataSetRow.SetUInt16(DbxValue: TDBXUInt16Value; Value: Word);
begin
  EnsureEditState;
  FTable.Fields[DbxValue.ValueType.Ordinal].Value := Value;
end;

procedure TDBXDataSetRow.SetUInt8(DbxValue: TDBXUInt8Value; Value: Byte);
begin
  EnsureEditState;
  FTable.Fields[DbxValue.ValueType.Ordinal].Value := Value;
end;

procedure TDBXDataSetRow.SetBCD(DbxValue: TDBXBcdValue; var Value: TBcd);
begin
  EnsureEditState;
  FTable.Fields[DbxValue.ValueType.Ordinal].AsBCD := Value;
end;

procedure TDBXDataSetRow.SetDynamicBytes(DbxValue: TDBXValue; Offset: Int64;
  const Buffer: TArray<Byte>; BufferOffset, Length: Int64);
var
  LData: TArray<Byte>;
begin
  EnsureEditState;

  SetLength(LData, Length);
  TDBXPlatform.CopyByteArray(Buffer, BufferOffset, LData, 0, Length);
  if FTable.Fields[DbxValue.ValueType.Ordinal].DataType = ftString then
    FTable.Fields[DbxValue.ValueType.Ordinal].AsString :=
      TMarshal.ReadStringAsAnsi(TPtrWrapper.Create(LData), Length)
  else
    FTable.Fields[DbxValue.ValueType.Ordinal].AsBytes := LData;
end;

procedure TDBXDataSetRow.ValueSet(Value: TDBXWritableValue);
begin
  TDBXDriverHelp.SetPendingValue(Value);
end;

function TDBXDataSetRow.EnsureEditState: Boolean;
begin
  Result := False;
  if not(FTable.State in dsEditModes) then
  begin
    FTable.Edit;
    Result := True;
  end;
end;

constructor TDBXParamsRow.Create(Params: TParams);
begin
  inherited Create(nil);
  FParams := Params;
end;

function TDBXParamsRow.CreateCustomValue(const ValueType: TDBXValueType): TDBXValue;
begin
  Result := nil;
  case ValueType.DataType of
    TDBXDataTypes.WideStringType:
      Result := TDBXStringValue.Create(ValueType);
//    TDBXDataTypes.AnsiStringType:
//      Result := TDBXAnsiCharsValue.Create(ValueType);
    TDBXDataTypes.BlobType:
      case ValueType.SubType of
        TDBXDataTypes.HMemoSubType,
        TDBXDataTypes.MemoSubType,
        TDBXDataTypes.WideMemoSubType:
          Result := TDBXStringValue.Create(ValueType);
      end;
  end;
end;

procedure TDBXParamsRow.GetBoolean(DbxValue: TDBXBooleanValue;
  var Value, IsNull: LongBool);
var
  Param: TParam;
begin
  Param := FParams[DbxValue.ValueType.Ordinal];
  IsNull := Param.IsNull;
  if not IsNull then
    Value := Param.AsBoolean;
end;

procedure TDBXParamsRow.GetInt16(DbxValue: TDBXInt16Value; var Value: SmallInt;
  var IsNull: LongBool);
var
  Param: TParam;
begin
  Param := FParams[DbxValue.ValueType.Ordinal];
  IsNull := Param.IsNull;
  if not IsNull then
    Value := Param.Value;
end;

procedure TDBXParamsRow.GetInt32(DbxValue: TDBXInt32Value; var Value: TInt32;
  var IsNull: LongBool);
var
  Param: TParam;
begin
  Param := FParams[DbxValue.ValueType.Ordinal];
  IsNull := Param.IsNull;
  if not IsNull then
    Value := Param.AsInteger;
end;

procedure TDBXParamsRow.GetInt64(DbxValue: TDBXInt64Value; var Value: Int64;
  var IsNull: LongBool);
var
  Param: TParam;
begin
  Param := FParams[DbxValue.ValueType.Ordinal];
  IsNull := Param.IsNull;
  if not IsNull then
    Value := Param.Value;
end;

procedure TDBXParamsRow.GetInt8(DbxValue: TDBXInt8Value; var Value: ShortInt;
  var IsNull: LongBool);
var
  Param: TParam;
begin
  Param := FParams[DbxValue.ValueType.Ordinal];
  IsNull := Param.IsNull;
  if not IsNull then
    Value := Param.Value;
end;

procedure TDBXParamsRow.GetSingle(DbxValue: TDBXSingleValue; var Value: Single;
  var IsNull: LongBool);
var
  Param: TParam;
begin
  Param := FParams[DbxValue.ValueType.Ordinal];
  IsNull := Param.IsNull;
  if not IsNull then
    Value := Param.Value;
end;

procedure TDBXParamsRow.GetStream(DbxValue: TDBXStreamValue;
  var Stream: TStream; var IsNull: LongBool);
var
  Param: TParam;
begin
  Param := FParams[DbxValue.ValueType.Ordinal];
  IsNull := Param.IsNull;
  if not IsNull then
  begin
    Stream := Param.AsStream;
    // release ownership.  Row implementations should not
    // maintain ownership of objects.
    //
    Param.SetStream(Stream, False);
  end;
end;

procedure TDBXParamsRow.GetDouble(DbxValue: TDBXDoubleValue; var Value: Double;
  var IsNull: LongBool);
var
  Param: TParam;
begin
  Param := FParams[DbxValue.ValueType.Ordinal];
  IsNull := Param.IsNull;
  if not IsNull then
    Value := Param.Value;
end;

procedure TDBXParamsRow.GetWideString(DbxValue: TDBXWideStringValue;
  var Value: string; var IsNull: LongBool);
var
  Param: TParam;
begin
  Param := FParams[DbxValue.ValueType.Ordinal];
  IsNull := Param.IsNull;
  if not IsNull then
    Value := Param.AsWideString
  else
    Value := '';
end;

{$IFNDEF NEXTGEN}
procedure TDBXParamsRow.GetAnsiString(DbxValue: TDBXAnsiStringValue;
  var AnsiStringBuilder: TDBXAnsiStringBuilder; var IsNull: LongBool);
var
  Param: TParam;
  Value: AnsiString;
begin
  Param := FParams[DbxValue.ValueType.Ordinal];
  IsNull := Param.IsNull;
  if not IsNull then
  begin
    Value := Param.AsAnsiString;
    TDBXPlatform.CopyStringToBuilder(Value, Length(Value)+1, AnsiStringBuilder);
  end;
end;
{$ENDIF !NEXTGEN}

procedure TDBXParamsRow.GetDate(DbxValue: TDBXDateValue; var Value: TDBXDate; var IsNull: LongBool);
var
  Param: TParam;
  LValue: Variant;
begin
  Param := FParams[DbxValue.ValueType.Ordinal];
  IsNull := Param.IsNull;
  if not IsNull then
  begin
    LValue := Param.Value;
    case VarType(LValue) of
      varDate, varDouble: Value := DateTimeToTimeStamp(LValue).Date
      else Value := LValue;
    end;
  end;
end;

procedure TDBXParamsRow.GetTime(DbxValue: TDBXTimeValue; var Value: TDBXTime; var IsNull: LongBool);
var
  Param: TParam;
  LValue: Variant;
begin
  Param := FParams[DbxValue.ValueType.Ordinal];
  IsNull := Param.IsNull;
  if not IsNull then
  begin
    LValue := Param.Value;
    case VarType(LValue) of
      varDate, varDouble: Value := DateTimeToTimeStamp(LValue).Time
      else Value := LValue;
    end;
  end;
end;

procedure TDBXParamsRow.GetTimeStamp(DbxValue: TDBXTimeStampValue;
  var Value: TSQLTimeStamp; var IsNull: LongBool);
var
  Param: TParam;
begin
  Param := FParams[DbxValue.ValueType.Ordinal];
  IsNull := Param.IsNull;
  if not IsNull then
    Value := Param.AsSQLTimeStamp;
end;

procedure TDBXParamsRow.GetTimeStampOffset(DbxValue: TDBXTimeStampOffsetValue;
  var Value: TSQLTimeStampOffset; var IsNull: LongBool);
var
  Param: TParam;
begin
  Param := FParams[DbxValue.ValueType.Ordinal];
  IsNull := Param.IsNull;
  if not IsNull then
    Value := Param.AsSQLTimeStampOffset;
end;

procedure TDBXParamsRow.GetUInt16(DbxValue: TDBXUInt16Value; var Value: Word;
  var IsNull: LongBool);
var
  Param: TParam;
begin
  Param := FParams[DbxValue.ValueType.Ordinal];
  IsNull := Param.IsNull;
  if not IsNull then
    Value := Param.Value;
end;

procedure TDBXParamsRow.GetUInt8(DbxValue: TDBXUInt8Value; var Value: Byte;
  var IsNull: LongBool);
var
  Param: TParam;
begin
  Param := FParams[DbxValue.ValueType.Ordinal];
  IsNull := Param.IsNull;
  if not IsNull then
    Value := Param.Value;
end;

procedure TDBXParamsRow.GetBcd(DbxValue: TDBXBcdValue; var Value: TBcd; var IsNull: LongBool);
var
  Param: TParam;
begin
  Param := FParams[DbxValue.ValueType.Ordinal];
  IsNull := Param.IsNull;
  if not IsNull then
    Value := Param.AsFMTBCD;
end;

procedure TDBXParamsRow.GetBytes(DbxValue: TDBXByteArrayValue; Offset: Int64; const Buffer: TArray<Byte>; BufferOffset: Int64; Length: Int64; var ReturnLength: Int64; var IsNull: LongBool);
var
  Param: TParam;
begin
  Param := FParams[DbxValue.ValueType.Ordinal];
  IsNull := Param.IsNull;
  if not IsNull then
  begin
    if Length + BufferOffset > Param.GetDataSize then
      ReturnLength := Param.GetDataSize - BufferOffset
    else
      ReturnLength := Length;

    Move(Param.AsBytes[0], Buffer[BufferOffset], ReturnLength);
  end;
end;

procedure TDBXParamsRow.GetByteLength(DbxValue: TDBXByteArrayValue; var ByteLength: Int64; var IsNull: LongBool);
var
  Param: TParam;
begin
  Param := FParams[DbxValue.ValueType.Ordinal];
  IsNull := Param.IsNull;
  if not IsNull then
    ByteLength := Param.GetDataSize;
end;

procedure TDBXParamsRow.SetBoolean(DbxValue: TDBXBooleanValue; Value: Boolean);
begin
  FParams[DbxValue.ValueType.Ordinal].Value := Value;
end;

procedure TDBXParamsRow.SetInt16(DbxValue: TDBXInt16Value; Value: SmallInt);
begin
  FParams[DbxValue.ValueType.Ordinal].Value := Value;
end;

procedure TDBXParamsRow.SetInt32(DbxValue: TDBXInt32Value; Value: TInt32);
begin
  FParams[DbxValue.ValueType.Ordinal].Value := Value;
end;

procedure TDBXParamsRow.SetInt64(DbxValue: TDBXInt64Value; Value: Int64);
begin
  FParams[DbxValue.ValueType.Ordinal].Value := Value;
end;

procedure TDBXParamsRow.SetInt8(DbxValue: TDBXInt8Value; Value: ShortInt);
begin
  FParams[DbxValue.ValueType.Ordinal].Value := Value;
end;

procedure TDBXParamsRow.SetDouble(DbxValue: TDBXDoubleValue; Value: Double);
begin
  FParams[DbxValue.ValueType.Ordinal].Value := Value;
end;

procedure TDBXParamsRow.SetDynamicBytes(DbxValue: TDBXValue; Offset: Int64;
  const Buffer: TArray<Byte>; BufferOffset, Length: Int64);
var
  LData: TArray<Byte>;
begin
  SetLength(LData, Length);
  TDBXPlatform.CopyByteArray(Buffer, BufferOffset, LData, 0, Length);
  if FParams[DbxValue.ValueType.Ordinal].DataType = ftString then
    FParams[DbxValue.ValueType.Ordinal].Value :=
      TMarshal.ReadStringAsAnsi(TPtrWrapper.Create(LData), Length)
  else
    FParams[DbxValue.ValueType.Ordinal].AsBytes := LData;
end;

procedure TDBXParamsRow.SetNull(DbxValue: TDBXValue);
begin
  FParams[DbxValue.ValueType.Ordinal].Value := Null;
end;

procedure TDBXParamsRow.SetSingle(DbxValue: TDBXSingleValue; Value: Single);
begin
  FParams[DbxValue.ValueType.Ordinal].Value := Value;
end;

procedure TDBXParamsRow.SetStream(DbxValue: TDBXStreamValue;
  StreamReader: TDBXStreamReader);
var
  MemoryStream: TMemoryStream;
  Buffer: TArray<Byte>;
  BytesRead: Integer;
begin
  MemoryStream := TMemoryStream.Create;
  SetLength(Buffer, 512);
  BytesRead := 1;
  while BytesRead > 0 do
  begin
    BytesRead := StreamReader.Read(Buffer, 0, Length(Buffer));
    if BytesRead > 0 then
      MemoryStream.Write(Buffer[0], BytesRead);
  end;
  MemoryStream.Seek(0, soBeginning);
  FParams[DBXValue.ValueType.Ordinal].SetStream(MemoryStream, True, MemoryStream.Size);
end;

procedure TDBXParamsRow.SetWideString(DbxValue: TDBXWideStringValue;
  const Value: string);
begin
  FParams[DbxValue.ValueType.Ordinal].Value := Value;
end;

{$IFNDEF NEXTGEN}
procedure TDBXParamsRow.SetAnsiString(DbxValue: TDBXAnsiStringValue; const Value: AnsiString);
begin
  FParams[DbxValue.ValueType.Ordinal].Value := Value;
end;

procedure TDBXParamsRow.SetString(DbxValue: TDBXAnsiStringValue;
  const Value: AnsiString);
begin
  FParams[DbxValue.ValueType.Ordinal].Value := Value;
end;
{$ELSE}
procedure TDBXParamsRow.SetString(DbxValue: TDBXAnsiStringValue;
  const Value: string);
begin
  FParams[DbxValue.ValueType.Ordinal].Value := Value;
end;
{$ENDIF !NEXTGEN}

procedure TDBXParamsRow.SetDate(DbxValue: TDBXDateValue; Value: TDBXDate);
var
  LTimeStamp: TTimeStamp;
begin
  LTimeStamp.Date := Value;
  LTimeStamp.Time := 0;
  FParams[DbxValue.ValueType.Ordinal].Value := TimeStampToDateTime(LTimeStamp);
end;

procedure TDBXParamsRow.SetTime(DbxValue: TDBXTimeValue; Value: TDBXTime);
var
  LTimeStamp: TTimeStamp;
begin
  LTimeStamp.Date := DateDelta;
  LTimeStamp.Time := Value;
  FParams[DbxValue.ValueType.Ordinal].Value := TimeStampToDateTime(LTimeStamp);
end;

procedure TDBXParamsRow.SetTimestamp(DbxValue: TDBXTimeStampValue;
  var Value: TSQLTimeStamp);
begin
  if DbxValue.ValueType.DataType = TDBXDataTypes.DateTimeType then
    FParams[DBXValue.ValueType.Ordinal].AsDateTime := SQLTimeStampToDateTime(Value)
  else
    FParams[DbxValue.ValueType.Ordinal].AsSQLTimeStamp := Value;
end;

procedure TDBXParamsRow.SetTimestampOffset(DbxValue: TDBXTimeStampOffsetValue;
  var Value: TSQLTimeStampOffset);
begin
  if DbxValue.ValueType.DataType = TDBXDataTypes.DateTimeType then
    FParams[DBXValue.ValueType.Ordinal].AsDateTime := SQLTimeStampOffsetToDateTime(Value)
  else
    FParams[DbxValue.ValueType.Ordinal].AsSQLTimeStampOffset := Value;
end;

procedure TDBXParamsRow.SetUInt16(DbxValue: TDBXUInt16Value; Value: Word);
begin
  FParams[DbxValue.ValueType.Ordinal].Value := Value;
end;

procedure TDBXParamsRow.SetUInt8(DbxValue: TDBXUInt8Value; Value: Byte);
begin
  FParams[DbxValue.ValueType.Ordinal].Value := Value;
end;

procedure TDBXParamsRow.SetBCD(DbxValue: TDBXBcdValue; var Value: TBcd);
begin
  FParams[DbxValue.ValueType.Ordinal].AsFMTBCD := Value;
end;

procedure TDBXParamsRow.ValueSet(Value: TDBXWritableValue);
begin
  TDBXDriverHelp.SetPendingValue(Value);
end;

constructor TDBXParamsTable.Create;
begin
  FParams := TParams.Create(nil);
  inherited Create(nil, TDBXParamsRow.Create(FParams));
end;

constructor TDBXParamsTable.Create(Params: TParams; InstanceOwner: Boolean);
begin
  inherited Create(nil, TDBXParamsRow.Create(Params));
  FParams := Params;
  FInstanceOwner := InstanceOwner;
  CreateValues;
end;

destructor TDBXParamsTable.Destroy;
begin
  if FInstanceOwner then
    FreeAndNil(FParams);
  FreeValueTypes;
  inherited Destroy;
end;

function TDBXParamsTable.First: Boolean;
begin
  RowNavigated;
  FAtEnd := False;
  Result := true;
end;

function TDBXParamsTable.Next: Boolean;
begin
    FAtEnd := True;
    Result := False;
//  if FAtEnd then
//    Result := false
//  else
//  begin
//    FAtEnd := true;
//    Result := true;
//  end;
end;

function TDBXParamsTable.InBounds: Boolean;
begin
  Result := not FAtEnd;
end;

procedure TDBXParamsTable.Close;
begin
end;

function TDBXParamsTable.GetOrdinal(const ColumnName: string): Integer;
begin
  Result := FParams.ParamByName(ColumnName).Index;
end;

function TDBXParamsTable.GetColumns: TDBXValueTypeArray;
var
  Ordinal: Integer;
  Param: TParam;
  ValueType: TDBXValueType;
begin
  if FValueTypes = nil then
  begin
    SetLength(FValueTypes, FParams.Count);
    for Ordinal := Low(FValueTypes) to High(FValueTypes) do
    begin
      Param := FParams[Ordinal];
      ValueType := TDBXValueType.Create(DBXContext);
      ValueType.Name                := Param.Name;
      ValueType.DisplayName         := Param.DisplayName;
      ValueType.DataType            := ToDataType(Param.DataType);
      ValueType.SubType             := ToDataSubType(Param.DataType);
      ValueType.Precision           := Param.Precision;
      ValueType.Scale               := Param.NumericScale;
      ValueType.Size                := Param.GetDataSize;
      ValueType.ParameterDirection  := ToDBXParameterDirection(Param.ParamType);
      FValueTypes[Ordinal]          := ValueType;
    end;
  end;
  Result := FValueTypes;
end;

procedure TDBXParamsTable.SetColumns(const Columns: TDBXValueTypeArray);
begin
  FreeValueTypes;
  FValueTypes := Columns;
  if FParams <> nil then
    CopyValueTypes(Columns, FParams);
end;

class procedure TDBXParamsTable.CopyValueTypes(const ValueTypes: TDBXValueTypeArray; const Params: TParams);
var
  Ordinal: Integer;
begin
  Params.Clear;
  for Ordinal := Low(ValueTypes) to High(ValueTypes) do
  begin
    if Ordinal >= Params.Count then
      CopyValueType(Ordinal, ValueTypes[Ordinal], Params[Ordinal])
    else if not(Params[Ordinal].Name = ValueTypes[Ordinal].Name) then
      raise TDBXError.Create(SMustKeepOriginalColumnOrder);
  end;
end;

function TDBXParamsTable.GetStorage: TObject;
begin
  Result := FParams;
end;


class procedure TDBXParamsTable.CopyValueType(Ordinal: Integer; ValueType: TDBXValueType; Param: TParam);
begin
  Param.Name          := ValueType.Name;
  Param.DisplayName   := ValueType.DisplayName;
  Param.DataType      := ToFieldType(ValueType);
  Param.ParamType     := ToParameterType(ValueType.ParameterDirection);
  Param.Precision     := ValueType.Precision;
  Param.NumericScale  := ValueType.Scale;
  Param.Size          := ValueType.Size;
//  if ValueType.DataType = TDBXDataTypes.WideStringType then
//  begin
//    if ValueType.Size <= 0 then
//      Param.Size := 128  // default size (make constant)
//    else
//      Param.Size := ValueType.Size;
//  end;
end;

procedure TDBXDBTable.FreeValueTypes;
begin
  ClearValues;
  FValueTypes := nil;
end;

class function TDBXDBTable.ToDataSubType(FieldType: TFieldType): Integer;
begin
  case FieldType of
  ftWideMemo:
    Result := TDBXDataTypes.WideMemoSubType;
  else
    Result := 0;
  end;
end;

class function TDBXDBTable.ToDataType(FieldType: TFieldType): Integer;
begin
  case FieldType of
    ftBoolean:
      Result := TDBXDataTypes.BooleanType;
    ftByte:
      Result := TDBXDataTypes.UInt8Type;
    ftShortint:
      Result := TDBXDataTypes.Int8Type;
    ftSmallInt:
      Result := TDBXDataTypes.Int16Type;
    ftInteger, ftAutoInc:
      Result := TDBXDataTypes.Int32Type;
    ftLargeint:
      Result := TDBXDataTypes.Int64Type;
    ftSingle:
      Result := TDBXDataTypes.SingleType;
    ftFloat:
      Result := TDBXDataTypes.DoubleType;
    ftGuid, ftOraInterval:
      Result := TDBXDataTypes.AnsiStringType;
    ftString, ftFixedChar:
      Result := TDBXDataTypes.AnsiStringType;
    ftWideString, ftFixedWideChar:
      Result := TDBXDataTypes.WideStringType;
    ftMemo, ftWideMemo, ftBlob, ftGraphic, ftFmtMemo, ftParadoxOle, ftDBaseOle,
      ftTypedBinary, ftOraBlob, ftOraClob:
      Result := TDBXDataTypes.BlobType;
    ftFMTBcd:
      Result := TDBXDataTypes.BcdType;
    ftBcd:
      Result := TDBXDataTypes.CurrencyType;
    ftBytes:
      Result := TDBXDataTypes.BytesType;
    ftDate:
      Result := TDBXDataTypes.DateType;
    ftTime:
      Result := TDBXDataTypes.TimeType;
    ftTimeStamp, ftOraTimeStamp:
      Result := TDBXDataTypes.TimeStampType;
    ftTimeStampOffset:
      Result := TDBXDataTypes.TimeStampOffsetType;
    ftDateTime:
      Result := TDBXDataTypes.DateTimeType;
    ftStream:
      Result := TDBXDataTypes.BinaryBlobType;
    ftVarBytes:
      Result := TDBXDataTypes.VarBytesType;
    ftWord:
      Result := TDBXDataTypes.UInt16Type;
    ftCurrency:
      Result := TDBXDataTypes.DoubleType; // TDBXDataTypes.CurrencyType;
    ftCursor:
      Result := TDBXDataTypes.CursorType;
    ftADT:
      Result := TDBXDataTypes.AdtType;
    ftArray:
      Result := TDBXDataTypes.ArrayType;
    ftReference:
      Result := TDBXDataTypes.RefType;
    ftDataSet, ftParams:
      Result := TDBXDataTypes.TableType;
    ftVariant:
      Result := TDBXDataTypes.VariantType;
    ftConnection:
      Result := TDBXDataTypes.DBXConnectionType;
    {
      ftDataSet:
      Result := TDBXDataTypes.TableType;
    }
  else
    raise TDBXError.Create(SUnexpectedMetaDataType);
  end;
end;

class function TDBXDBTable.ToFieldType(ValueType: TDBXValueType): TFieldType;
begin
  case ValueType.DataType of
    TDBXDataTypes.BooleanType:
      Result := ftBoolean;
    TDBXDataTypes.UInt8Type:
      Result := ftByte;
    TDBXDataTypes.Int8Type:
      Result := ftShortint;
    TDBXDataTypes.Int16Type:
      Result := ftSmallInt;
    TDBXDataTypes.Int32Type:
      Result := ftInteger;
    TDBXDataTypes.Int64Type:
      Result := ftLargeint;
    TDBXDataTypes.SingleType:
      Result := ftSingle;
    TDBXDataTypes.DoubleType:
      Result := ftFloat;
    TDBXDataTypes.WideStringType:
    // Switched back to this because metadata layer cannot create
    // Unicode identifiers without it.  If there ar issues, we need
    // to find the root cause.  TClientDataSet does support Unicode.
    //
    Result := ftWideString;   // All strings are truncated to the empty string (bug!)
//    Result := ftWideMemo;     // Cannot create an index for this column type (needed for keyword search)
//      Result := ftString;       // Cannot hold unicode chars (bad)
    TDBXDataTypes.AnsiStringType:
      Result := ftString;
    TDBXDataTypes.DateType:
      Result := ftDate;
    TDBXDataTypes.TimeStampType:
      Result := ftTimeStamp;
    TDBXDataTypes.TimeStampOffsetType:
      Result := ftTimeStampOffset;
    TDBXDataTypes.BlobType:
      case ValueType.SubType of
      TDBXDataTypes.WideMemoSubType:
        Result := ftWideMemo;
      else
        Result := ftBlob;
      end;
    TDBXDataTypes.BcdType:
      Result := ftFMTBcd;
    TDBXDataTypes.CurrencyType:
      Result := ftCurrency;
    TDBXDataTypes.BytesType:
      Result := ftBytes;
    TDBXDataTypes.TimeType:
      Result := ftTime;
    TDBXDataTypes.BinaryBlobType:
      Result := ftStream;
    TDBXDataTypes.UInt16Type:
      Result := ftWord;
    TDBXDataTypes.CursorType:
      Result := ftCursor;
    TDBXDataTypes.AdtType:
      Result := ftADT;
    TDBXDataTypes.ArrayType:
      Result := ftArray;
    TDBXDataTypes.RefType:
      Result := ftReference;
    TDBXDataTypes.TableType:
      Result := ftDataSet;
    TDBXDataTypes.VariantType:
      Result := ftVariant;
    TDBXDataTypes.VarBytesType:
      Result := ftVarBytes;
    TDBXDataTypes.DBXConnectionType:
      Result := ftConnection;
    TDBXDataTypes.DateTimeType:
      Result := ftDateTime;
  else
    raise TDBXError.Create(SUnexpectedMetaDataType);
  end;
end;

function TDBXDBTable.GetDBXTableName: string;
begin
  Result := FCollectionName;
end;

procedure TDBXDBTable.SetDBXTableName(const CollectionName: string);
begin
  FCollectionName := CollectionName;
end;

class function TDBXDBTable.ToDBXParameterDirection(ParameterType: TParamType): Integer;
begin
  case ParameterType of
    ptInput:        Result := TDBXParameterDirections.InParameter;
    ptOutput:       Result := TDBXParameterDirections.OutParameter;
    ptInputOutput:  Result := TDBXParameterDirections.InOutParameter;
    ptResult:       Result := TDBXParameterDirections.ReturnParameter;
    else
      Result := TDBXParameterDirections.Unknown;
  end;
end;

class function TDBXDBTable.ToParameterType(ParameterDirection: Integer): TParamType;
begin
  case ParameterDirection of
    TDBXParameterDirections.InParameter:      Result := ptInput;
    TDBXParameterDirections.OutParameter:     Result := ptOutput;
    TDBXParameterDirections.InOutParameter:   Result := ptInputOutput;
    TDBXParameterDirections.ReturnParameter:  Result := ptResult;
    else
      Result := ptUnknown;
  end;
end;

constructor TDBXDataSetReader.Create(Params: TDBXDataSetTable);
begin
  inherited Create(Params);
end;

constructor TDBXDataSetReader.Create(Params: TDataset; InstanceOwner: Boolean);
begin
  inherited Create(TDBXDataSetTable.Create(Params.Name, Params, InstanceOwner, true));
end;

{ TDBXParamsReader }

class procedure TDBXParamsReader.CopyReaderToParams(Reader: TDBXReader;
  Params: TParams);
var
  Ordinal: Integer;
  Count: Integer;
  Param: TParam;
  DBXRow: TDBXParamsRow;
begin
  Reader.Next;
  Params.Clear;
  Count := Reader.ColumnCount;
  for Ordinal := 0 to Count - 1 do
  begin
    Param := TParam.Create(Params);
    TDBXParamsTable.CopyValueType(Ordinal, Reader.ValueType[Ordinal], Param);
  end;
  DBXRow := TDBXParamsRow.Create(Params);
  try
    for Ordinal := 0 to Count - 1 do
    begin
      TDBXDriverHelp.CopyRowValue(Reader.Value[Ordinal], DBXRow);
    end;
  finally
    FreeAndNil(DBXRow);
  end;
end;

class function TDBXParamsReader.ToParams(AOwner: TPersistent; Reader: TDBXReader; AOwnsInstance: Boolean): TParams;
begin
  Result := TParams.Create(AOwner);
  CopyReaderToParams(Reader, Result);
  if AOwnsInstance then
    Reader.Free;
end;

constructor TDBXParamsReader.Create(Params: TParams; InstanceOwner: Boolean);
begin
  inherited Create(TDBXParamsTable.Create(Params, InstanceOwner));
end;

destructor TDBXParamsReader.Destroy;
begin

  inherited;
end;

{ TDBXMemoryTable }

procedure TDBXMemoryTable.AcceptChanges;
begin
  // do nothing for memory tables
end;

procedure TDBXMemoryTable.Clear;
begin
  //no op
end;

procedure TDBXMemoryTable.ClearValues(AValues: TDBXWritableValueArray);
var
  I: Integer;
begin
  for I := 0 to Length(AValues) - 1 do
    AValues[I].Free;
end;

procedure TDBXMemoryTable.ClearValueTypes(AValueTypes: TDBXValueTypeArray);
var
  I: Integer;
begin
  for I := 0 to Length(AValueTypes) - 1 do
    AValueTypes[I].Free;
end;

procedure TDBXMemoryTable.Close;
var
  I: Integer;
begin
  if Assigned(FValueRows) then
  begin
    // Free rows
    for I := FValueRows.Count - 1 downto 0 do
      ClearValues(FValueRows[I]);
    // Prevent ancestor from freeing current row
    SetValues(TDBXWritableValueArray(nil));
    FreeAndNil(FValueRows);
  end;
end;

constructor TDBXMemoryTable.Create;
begin
  FValueRows := TList<TDBXWritableValueArray>.Create;
  FIndex := 0;
  FOrderByColumn := -1;
end;

function TDBXMemoryTable.CreateTableView(
  const OrderByColumnName: string): TDBXTable;
var
  Column: Integer;
begin
  // get the column index
  Column := ColumnIndex(OrderByColumnName);
  if Column = -1 then
    raise TDBXError.Create(Format(SInvalidOrderByColumn, [OrderByColumnName]));

  Result := TDBXMemoryTable.Create;
  Result.Columns := CopyColumns;
  FIndex := -1;
  Result.CopyFrom(self);

  // sort the list based on the column value
  (Result as TDBXMemoryTable).OrderByColumn(Column);
end;

function TDBXMemoryTable.CreateWritableValueArray: TDBXWritableValueArray;
var
  Value: TDBXWritableValue;
  Values: TDBXWritableValueArray;
  Ordinal: Integer;
begin
  SetLength(Values, Length(Columns));
  for Ordinal := 0 to Length(Values) - 1 do
  begin
    if Columns[Ordinal] <> nil then
    begin
      // Note that we must clone the column here because a TDBXValue owns the TDBXValueType.
      // Would be nice to add ownership control
      Value := TDBXWritableValue(TDBXValue.CreateValue(nil, Columns[Ordinal].Clone, nil, False));
      Value.ValueType.Ordinal := Ordinal;
      Values[Ordinal] := Value;
    end;
  end;
  Result := Values;
end;

destructor TDBXMemoryTable.Destroy;
begin
  Close;
  // Free column types
  ClearValueTypes(FValueTypes);
  inherited;
end;

function TDBXMemoryTable.FindStringKey(const Ordinal: Integer;
  const Value: string): Boolean;
var
  refRow: TDBXWritableValueArray;
  Comparer: TDBXWritableValueArrayComparer;
begin
  // false for an empty table
  if FValueRows.Count = 0 then
    exit(False);
  // sort if not sorted on the column, thinking is there is a repeat
  if Ordinal <> FOrderByColumn then
    OrderByColumn(Ordinal);
  // prepare the reference row, only Ordinal column is important
  SetLength(refRow, Ordinal + 1);
  refRow[Ordinal] := TDBXValue.CreateValue(FValueRows[0][Ordinal].ValueType.Clone);
  refRow[Ordinal].AsString := Value;
  // allocate the comparer and perform a binary search
  // if success, move index to the found column
  Comparer := TDBXWritableValueArrayComparer.Create(Ordinal);
  Result := FValueRows.BinarySearch(refRow, FIndex, Comparer);
  if Result then
    SetValues(FValueRows[FIndex]);
  // clean up
  Comparer.Free;
  refRow[Ordinal].Free;
end;

function TDBXMemoryTable.First: Boolean;
begin
  FIndex := 0;
  Result := FIndex < FValueRows.Count;
  if Result then
    SetValues(FValueRows[FIndex]);
end;

function TDBXMemoryTable.GetColumns: TDBXValueTypeArray;
begin
  Result := FValueTypes;
end;

function TDBXMemoryTable.GetDBXTableName: string;
begin
  Result := FName;
end;

function TDBXMemoryTable.GetTableCount: Integer;
begin
  Result := FValueRows.Count
end;

function TDBXMemoryTable.InBounds: Boolean;
begin
  Result := (FIndex >= 0) and (FIndex < FValueRows.Count);
end;

procedure TDBXMemoryTable.Insert;
var
  LRow: TDBXWritableValueArray;
begin
  LRow := CreateWritableValueArray;
  SetValues(LRow, Length(LRow));
  FValueRows.Add(LRow);
  FIndex := FValueRows.Count - 1;
end;

function TDBXMemoryTable.Next: Boolean;
begin
  Inc(FIndex);
  Result := FIndex < FValueRows.Count;
  if Result then
    SetValues(FValueRows[FIndex]);
end;

procedure TDBXMemoryTable.OrderByColumn(Column: Integer);
var
  Comparer: TDBXWritableValueArrayComparer;
begin
  Comparer := TDBXWritableValueArrayComparer.Create(Column);
  try
    FValueRows.Sort(Comparer);
    FOrderByColumn := Column;
  finally
    Comparer.Free;
  end;
end;

procedure TDBXMemoryTable.Post;
begin
  // Nothing to do because data is written to the actual row rather than a buffer row
end;

procedure TDBXMemoryTable.SetColumns(const Columns: TDBXValueTypeArray);
begin
  FValueTypes := Columns;
end;

procedure TDBXMemoryTable.SetDBXTableName(const AName: string);
begin
  FName := AName;
end;

{ TDBXWritableValueArrayComparer }

function TDBXWritableValueArrayComparer.Compare(const Left, Right: TDBXWritableValueArray): Integer;
var
  LeftValue, RightValue: TDBXValue;
begin
  LeftValue := Left[ColumnIndex];
  RightValue := Right[ColumnIndex];
  if LeftValue.IsNull or RightValue.IsNull then
    if LeftValue.IsNull then
      if RightValue.IsNull then
        Result := 0
      else
        Result := -1
    else
      Result := 1
  else
    Result := LeftValue.Compare(RightValue);
end;

class function TDBXWritableValueArrayComparer.CompareArrays(const Left,
  Right: TDBXWritableValueArray): Boolean;
var
  LeftValue, RightValue: TDBXValue;
  LColumnIndex: Integer;
begin
  Result := False;
  if Length(Right) <> Length(Left) then
    Exit;
  for LColumnIndex := 0 to Length(Left) - 1 do
  begin
    LeftValue := Left[LColumnIndex];
    RightValue := Right[LColumnIndex];
    if LeftValue.IsNull or RightValue.IsNull then
      if LeftValue.IsNull then
        if RightValue.IsNull then
          Result := True
        else
          Result := False
      else
        Result := False
    else
      Result := LeftValue.Compare(RightValue) = 0;
  end;
end;

constructor TDBXWritableValueArrayComparer.Create(AColumnIndex: Integer);
begin
  FColumnIndex := AColumnIndex;
end;

class function TDBXWritableValueArrayComparer.FindStringKey(
  const AValuesList: TList<TDBXWritableValueArray>; const Ordinal: Integer;
  const Value: string): Integer;
var
  refRow: TDBXWritableValueArray;
  Comparer: TDBXWritableValueArrayComparer;
begin
  Result := -1;
  if AValuesList.Count = 0 then
    Exit;

  // allocate the comparer and perform a binary search
  // if success, move index to the found column
  Comparer := TDBXWritableValueArrayComparer.Create(Ordinal);
  try
    // sort if not sorted on the column, thinking is there is a repeat
    AValuesList.Sort(Comparer);

    // prepare the reference row, only Ordinal column is important
    SetLength(refRow, Ordinal + 1);
    refRow[Ordinal] := TDBXValue.CreateValue(AValuesList[0][Ordinal].ValueType.Clone);
    refRow[Ordinal].AsString := Value;

    if not AValuesList.BinarySearch(refRow, Result, Comparer) then
      Result := -1;
  finally
    // clean up
    Comparer.Free;
    refRow[Ordinal].Free;
  end;
end;

{ TDBXMemoryValue }

procedure TDBXMemoryValue.ClearOriginal;
begin
  FreeAndNil(FOriginalValue);
end;

function TDBXMemoryValue.Compare(Other: TDBXValue): Smallint;
begin
  Result := FValue.Compare(Other)
end;

constructor TDBXMemoryValue.Create(const AOriginalValue: TDBXWritableValue{; Owner: TDBXCache});
begin
  inherited Create(AOriginalValue.ValueType.Clone);
  FValue := AOriginalValue;
  FInitialized := False;
//  FOwner := Owner;
end;

destructor TDBXMemoryValue.Destroy;
begin
  FreeAndNil(FValue);
  FreeAndNil(FOriginalValue);
  inherited;
end;

function TDBXMemoryValue.EqualsValue(Other: TDBXValue): Boolean;
begin
  Result := FValue.EqualsValue(Other)
end;

{$IFNDEF NEXTGEN}
function TDBXMemoryValue.GetAnsiString: AnsiString;
begin
  Result := AnsiString(FValue.AsString);
end;
{$ENDIF !NEXTGEN}

function TDBXMemoryValue.GetBcd: TBcd;
begin
  Result := FValue.AsBcd
end;

function TDBXMemoryValue.GetBoolean: Boolean;
begin
  Result := FValue.AsBoolean;
end;

function TDBXMemoryValue.GetBoolean(defaultValue: Boolean): Boolean;
begin
  Result := FValue.GetBoolean(defaultValue)
end;

function TDBXMemoryValue.GetBytes(Offset: Int64; const Buffer: TArray<Byte>;
  BufferOffset, Length: Int64): Int64;
begin
  Result := FValue.GetBytes(Offset, Buffer, BufferOffset, Length)
end;

function TDBXMemoryValue.GetCallbackValue: TDBXCallback;
begin
  Result := FValue.GetCallbackValue
end;

function TDBXMemoryValue.GetDate: TDBXDate;
begin
  Result := FValue.AsDate;
end;

function TDBXMemoryValue.GetDBXConnection: TDBXConnection;
begin
  Result := FValue.GetDBXConnection
end;

function TDBXMemoryValue.GetDBXReader: TDBXReader;
begin
  Result := FValue.GetDBXReader
end;

function TDBXMemoryValue.GetDBXReader(AInstanceOwner: Boolean): TDBXReader;
begin
  Result := FValue.GetDBXReader(AInstanceOwner)
end;

function TDBXMemoryValue.GetDouble: Double;
begin
  Result := FValue.AsDouble
end;

function TDBXMemoryValue.GetInt16: SmallInt;
begin
  Result := FValue.AsInt16
end;

function TDBXMemoryValue.GetInt16(defaultValue: Smallint): Smallint;
begin
  Result := FValue.GetInt16(defaultValue)
end;

function TDBXMemoryValue.GetInt32: TInt32;
begin
  Result := FValue.AsInt32
end;

function TDBXMemoryValue.GetInt32(defaultValue: TInt32): TInt32;
begin
  Result := FValue.GetInt32(defaultValue)
end;

function TDBXMemoryValue.GetInt64(defaultValue: Int64): Int64;
begin
  Result := FValue.GetInt64(defaultValue)
end;

function TDBXMemoryValue.GetInt64: Int64;
begin
  Result := FValue.AsInt64
end;

function TDBXMemoryValue.GetInt8: ShortInt;
begin
  Result := FValue.AsInt8
end;

function TDBXMemoryValue.GetInt8(defaultValue: Shortint): Shortint;
begin
  Result := FValue.GetInt8(defaultValue)
end;

function TDBXMemoryValue.GetJSONValue: TJSONValue;
begin
  Result := FValue.GetJSONValue
end;

function TDBXMemoryValue.GetJSONValue(AInstanceOwner: Boolean): TJSONValue;
begin
  Result := FValue.GetJSONValue(AInstanceOwner)
end;

function TDBXMemoryValue.GetObjectValue(AInstanceOwner: Boolean): TObject;
begin
  Result := FValue.GetObjectValue(AInstanceOwner)
end;

function TDBXMemoryValue.GetObjectValue: TObject;
begin
  Result := FValue.GetObjectValue
end;

function TDBXMemoryValue.GetSingle: Single;
begin
  Result := FValue.AsSingle
end;

function TDBXMemoryValue.GetStream(AInstanceOwner: Boolean): TStream;
begin
  Result := FValue.GetStream(AInstanceOwner)
end;

function TDBXMemoryValue.GetStream: TStream;
begin
  Result := FValue.GetStream
end;

function TDBXMemoryValue.GetString: string;
begin
  Result := FValue.AsString
end;

function TDBXMemoryValue.GetTime: TDBXTime;
begin
  Result := FValue.AsTime
end;

function TDBXMemoryValue.GetTimeStamp: TSQLTimeStamp;
begin
  Result := FValue.AsTimeStamp
end;

function TDBXMemoryValue.GetTimeStampOffset: TSQLTimeStampOffset;
begin
  Result := FValue.GetTimeStampOffset;
end;

function TDBXMemoryValue.GetUInt16: Word;
begin
  Result := FValue.AsUInt16
end;

function TDBXMemoryValue.GetUInt16(defaultValue: Word): Word;
begin
  Result := FValue.GetUInt16(defaultValue)
end;

function TDBXMemoryValue.GetUInt8: Byte;
begin
  Result := FValue.AsUInt8
end;

function TDBXMemoryValue.GetUInt8(defaultValue: Byte): Byte;
begin
  Result := FValue.GetUInt8(defaultValue)
end;

function TDBXMemoryValue.GetValueSize: Int64;
begin
  Result := FValue.GetValueSize
end;

function TDBXMemoryValue.GetWideString(defaultValue: string): string;
begin
  Result := FValue.GetWideString(defaultValue)
end;

function TDBXMemoryValue.GetWideString: string;
begin
  Result := FValue.AsString
end;

function TDBXMemoryValue.IsNull: Boolean;
begin
  Result := FValue.IsNull;
end;

procedure TDBXMemoryValue.AcceptChanges;
begin
  FreeAndNil(FOriginalValue);
  if FValue <> nil then
  begin
    FOriginalValue := TDBXValue.CreateValue(nil, FValue.ValueType.Clone, nil, False);
    FOriginalValue.SetValue(FValue);
  end;
end;

procedure TDBXMemoryValue.Cancel;
begin
  if FOriginalValue <> nil then
  begin
    FValue.SetValue(FOriginalValue);
    ClearOriginal;              
  end;
end;

procedure TDBXMemoryValue.SetOriginal;
begin
  if FInitialized then
  begin
    if FOriginalValue = nil then
      AcceptChanges;
  end
  else
    FInitialized := True;
end;

{$IFNDEF NEXTGEN}
procedure TDBXMemoryValue.SetAnsiString(const Value: AnsiString);
begin
  SetOriginal;
  FValue.AsString := string(Value);
end;
{$ENDIF !NEXTGEN}

procedure TDBXMemoryValue.SetBcd(const Value: TBcd);
begin
  SetOriginal;
  FValue.AsBcd := Value;
end;

procedure TDBXMemoryValue.SetBoolean(const Value: Boolean);
begin
  SetOriginal;
  FValue.AsBoolean := Value;
end;

procedure TDBXMemoryValue.SetCallbackValue(const Value: TDBXCallback);
begin
  SetOriginal;
  FValue.SetCallbackValue(Value);
end;

procedure TDBXMemoryValue.SetDate(const Value: TDBXDate);
begin
  SetOriginal;
  FValue.AsDate := Value;
end;

procedure TDBXMemoryValue.SetDBXConnection(const Value: TDBXConnection);
begin
  SetOriginal;
  FValue.SetDBXConnection(Value);
end;

procedure TDBXMemoryValue.SetDBXReader(const Value: TDBXReader;
  const AInstanceOwner: Boolean);
begin
  SetOriginal;
  FValue.SetDBXReader(Value, AInstanceOwner);
end;

procedure TDBXMemoryValue.SetDouble(const Value: Double);
begin
  SetOriginal;
  FValue.AsDouble := Value;
end;

procedure TDBXMemoryValue.SetDynamicBytes(Offset: Int64; const Buffer: TArray<Byte>;
  BufferOffset, Length: Int64);
begin
  SetOriginal;
  FValue.SetDynamicBytes(Offset, Buffer, BufferOffset, Length);
end;

procedure TDBXMemoryValue.SetInt16(const Value: SmallInt);
begin
  SetOriginal;
  FValue.AsInt16 := Value;
end;

procedure TDBXMemoryValue.SetInt32(const Value: TInt32);
begin
  SetOriginal;
  FValue.AsInt32 := Value;
end;

procedure TDBXMemoryValue.SetInt64(const Value: Int64);
begin
  SetOriginal;
  FValue.AsInt64 := Value;
end;

procedure TDBXMemoryValue.SetInt8(const Value: ShortInt);
begin
  SetOriginal;
  FValue.AsInt8 := Value;
end;

procedure TDBXMemoryValue.SetJSONValue(const Value: TJSONValue;
  const AInstanceOwner: Boolean);
begin
  SetOriginal;
  FValue.SetJSONValue(Value, AInstanceOwner);
end;

procedure TDBXMemoryValue.SetNull;
begin
  SetOriginal;
  FValue.SetNull;
end;

procedure TDBXMemoryValue.SetObjectValue(const Value: TObject;
  const AInstanceOwner: Boolean);
begin
  SetOriginal;
  FValue.SetObjectValue(Value, AInstanceOwner);
end;

procedure TDBXMemoryValue.SetSingle(const Value: Single);
begin
  SetOriginal;
  FValue.AsSingle := Value;
end;

procedure TDBXMemoryValue.SetStaticBytes(Offset: Int64;
  const Buffer: array of Byte; BufferOffset, Length: Int64);
begin
  SetOriginal;
  FValue.SetStaticBytes(Offset, Buffer, BufferOffset, Length);
end;

procedure TDBXMemoryValue.SetStream(const Stream: TStream;
  const AInstanceOwner: Boolean);
begin
  SetOriginal;
  FValue.SetStream(Stream, AInstanceOwner);
end;

procedure TDBXMemoryValue.SetString(const Value: string);
begin
  SetOriginal;
  FValue.AsString := Value;
end;

procedure TDBXMemoryValue.SetTime(const Value: TDBXTime);
begin
  SetOriginal;
  FValue.AsTime := Value;
end;

procedure TDBXMemoryValue.SetTimeStamp(const Value: TSQLTimeStamp);
begin
  SetOriginal;
  FValue.AsTimeStamp := Value;
end;

procedure TDBXMemoryValue.SetTimeStampOffset(const Value: TSQLTimeStampOffset);
begin
  SetOriginal;
  FValue.SetTimeStampOffset(Value);
end;

procedure TDBXMemoryValue.SetUInt16(const Value: Word);
begin
  SetOriginal;
  FValue.AsUInt16 := Value;
end;

procedure TDBXMemoryValue.SetUInt8(const Value: Byte);
begin
  SetOriginal;
  FValue.AsUInt8 := Value;
end;

procedure TDBXMemoryValue.SetValue(const Value: TDBXValue);
begin
  SetOriginal;
  if Value is TDBXMemoryValue then
    if TDBXMemoryValue(Value).FOriginalValue <> nil then
    begin
      if not Assigned(FOriginalValue) then
        FOriginalValue := TDBXValue.CreateValue(nil, TDBXMemoryValue(Value).ValueType.Clone, nil, False);
      FOriginalValue.SetValue(TDBXMemoryValue(Value).FOriginalValue);
    end;
  FValue.SetValue(Value);
end;

procedure TDBXMemoryValue.SetWideString(const Value: string);
begin
  SetOriginal;
  FValue.AsString := Value;
end;

{ TDBXTableStorage }

procedure TDBXTableStorage.AcceptChanges;
begin
  FCache.AcceptChanges;
end;

procedure TDBXTableStorage.AddRow(const ATable: TDBXTable;
  const ARow: TDBXWritableValueArray; const AClone: Boolean);
var
  LValueArray: TDBXWritableValueArray;
  I: Integer;
begin
  ATable.Insert;
  if AClone then
    LValueArray := CloneRow(ARow)
  else
    LValueArray := ARow;
  TDBXTableStorage(ATable).SetValues(LValueArray, Length(LValueArray));
  I := TDBXTableStorage(ATable).FIndex;
  ClearValues(TDBXTableStorage(ATable).FCache.ValueRows.Items[I]);
  TDBXTableStorage(ATable).FCache.ValueRows.Items[I] := LValueArray;
  ATable.Post;
end;

procedure TDBXTableStorage.Cancel;
begin
  inherited;
end;

procedure TDBXTableStorage.Clear;
begin
  FCache.Clear;
  FIndex := 0;
  // Prevent ancestor from freeing current row
  SetValues(TDBXWritableValueArray(nil));
end;

procedure TDBXTableStorage.ClearValues(AValues: TDBXWritableValueArray);
var
  I: Integer;
begin
  for I := 0 to Length(AValues) - 1 do
    AValues[I].Free;
end;

function TDBXTableStorage.CloneRow(
  const ARow: TDBXWritableValueArray): TDBXWritableValueArray;
var
  I: Integer;
begin
  SetLength(Result, Length(ARow));
  for I := 0 to Length(Result) - 1 do
  begin
    if ARow[I] is TDBXMemoryValue then
      Result[I] := TDBXMemoryValue.Create(TDBXValue.CreateValue(ARow[I].ValueType.Clone))
    else
      Result[I] := TDBXValue.CreateValue(ARow[I].ValueType.Clone);
    Result[I].SetValue(ARow[I]);
  end;
end;

procedure TDBXTableStorage.Close;
begin
  //No-op
end;

procedure TDBXTableStorage.CopyFrom(const Source: TDBXTable);
var
  Row: TDBXWritableValueArray;
begin
  if Source.First then
  begin
    if Source.InBounds then
      repeat
        Row := CloneRow(Source.Values);
        FCache.AddRow(Row);
        SetValues(Row, Length(Source.Values));
//        for Ordinal := 0 to ColumnCount - 1 do
//          Self.Value[Ordinal].SetValue(Source.Value[Ordinal]);
      until not Source.Next;
  end;
end;

constructor TDBXTableStorage.Create;
begin
  Create(True);
end;

constructor TDBXTableStorage.Create(const AOwnsValues: Boolean);
begin
  inherited Create(nil);
  FIndex := -1;
  FCache := TDBXCache.Create(AOwnsValues);
  FOriginalRow := nil;
  FInsertedTable := nil;
  FUpdatedTable := nil;
  FDeletedTable := nil;
end;

function TDBXTableStorage.CreateTableView(
  const OrderByColumnName: string): TDBXTable;
var
  Column: Integer;
begin
  // get the column index
  Column := ColumnIndex(OrderByColumnName);

  Result := TDBXTableStorage.Create;
  try
    Result.Columns := CopyColumns;
    //TDBXTableStorage(Result).SetColumns(Result.Columns);
    FIndex := -1;
    Result.CopyFrom(Self);

    // sort the list based on the column value
    if Column <> -1 then
      (Result as TDBXTableStorage).OrderByColumn(Column);
  except
    Result.Free;
    raise;
  end;
end;

procedure TDBXTableStorage.DeleteRow;
begin
  DeleteRow(FIndex);
end;

procedure TDBXTableStorage.DeleteRow(const AIndex: Integer);
begin
  FCache.DeleteRow(AIndex);
  UpdateCurrentRow;
end;

destructor TDBXTableStorage.Destroy;
begin
  if FCache.OwnsValues then
    SetValues(nil, 0);
  FOriginalRow.Free;
  FInsertedTable.Free;
  FUpdatedTable.Free;
  FDeletedTable.Free;
  FCache.Free;
  inherited;
end;

function TDBXTableStorage.Edit: Boolean;
begin
  Result := False;
end;

function TDBXTableStorage.FindStringKey(const Ordinal: Integer;
  const Value: string): Boolean;
begin
  Result := False;
  FIndex := TDBXWritableValueArrayComparer.FindStringKey(FCache.ValueRows, Ordinal, Value);
  if FIndex <> -1 then
  begin
    Result := True;
    UpdateCurrentRow;
  end;
end;

function TDBXTableStorage.First: Boolean;
begin
  FIndex := 0;
  Result := FIndex < FCache.ValueRows.Count;
  if Result then
    UpdateCurrentRow;
end;

function TDBXTableStorage.GetColumns: TDBXValueTypeArray;
begin
  Result := FCache.GetColumns;
end;

function TDBXTableStorage.GetDBXTableName: string;
begin
  Result := FName;
end;

function TDBXTableStorage.GetDeletedRows: TDBXTable;
var
  I: Integer;
begin
  FDeletedTable.Free;
  FDeletedTable := TDBXTableStorage.Create;
  Result := FDeletedTable;
  try
    Result.Columns := CopyColumns;
    TDBXTableStorage(Result).SetColumns(Result.Columns);
    for I := 0 to FCache.DeletedRows.Count - 1 do
      AddRow(Result, FCache.DeletedRows.Items[I], True);
    Result.AcceptChanges;
  except
    FDeletedTable := nil;
    Result.Free;
    raise;
  end;
end;


function TDBXTableStorage.GetInsertedRows: TDBXTable;
var
  I: Integer;
begin
  FInsertedTable.Free;
  FInsertedTable := TDBXTableStorage.Create;
  Result := FInsertedTable;
  try
    Result.Columns := CopyColumns;
    TDBXTableStorage(Result).SetColumns(Result.Columns);
    for I := 0 to FCache.InsertedRows.Count - 1 do
      AddRow(Result, FCache.InsertedRows.Items[I], True);
    Result.AcceptChanges;
  except
    FInsertedTable := nil;
    Result.Free;
    raise;
  end;
end;

function TDBXTableStorage.GetOriginalRow: TDBXTableRow;
var
  LRow: TDBXWritableValueArray;
  I: Integer;
begin
  FOriginalRow.Free;
  FOriginalRow := TDBXTableStorage.Create;
  Result := FOriginalRow;
  try
    Result.Columns := CopyColumns;
    if FCache.UpdatedRows.Count = 0 then
      AddRow(TDBXTable(Result), FCache.ValueRows[FIndex], True)
    else
      for LRow in FCache.UpdatedRows do
      begin
        if LRow = FCache.ValueRows[FIndex] then
        begin
          AddRow(TDBXTable(Result), LRow, True);
          //make sure the table here contains the original values!
          for I := 0 to Length(Result.Values) - 1 do
            if Result.Values[I] is TDBXMemoryValue then
              TDBXMemoryValue(Result.Values[I]).Cancel;
        end;
      end;
  except
    FOriginalRow := nil;
    Result.Free;
    raise;
  end;
end;

function TDBXTableStorage.GetRow(const AIndex: Integer): TDBXWritableValueArray;
begin
  Result := FCache.ValueRows.Items[AIndex];
end;

function TDBXTableStorage.GetTableCount: Integer;
begin
  Result := FCache.ValueRows.Count;
end;

function TDBXTableStorage.GetUpdatedRows: TDBXTable;
var
  I: Integer;
begin
  FUpdatedTable.Free;
  FUpdatedTable := TDBXTableStorage.Create;
  Result := FUpdatedTable;
  try
    Result.Columns := CopyColumns;
    TDBXTableStorage(Result).SetColumns(Result.Columns);
    for I := 0 to FCache.UpdatedRows.Count - 1 do
      AddRow(Result, FCache.UpdatedRows.Items[I], True);
  except
    FUpdatedTable := nil;
    Result.Free;
    raise;
  end;
end;

function TDBXTableStorage.InBounds: Boolean;
begin
  Result := (FIndex >= 0) and (FIndex < FCache.ValueRows.Count);
end;

procedure TDBXTableStorage.Insert(const AIndex: Integer);
begin
  FIndex := AIndex;
  FCache.Insert(AIndex);
  UpdateCurrentRow;
end;

procedure TDBXTableStorage.Insert;
begin
  Insert(FIndex + 1);
end;

function TDBXTableStorage.Next: Boolean;
begin
  Inc(FIndex);
  Result := FIndex < FCache.ValueRows.Count;
  if Result then
    UpdateCurrentRow;
end;

procedure TDBXTableStorage.OrderByColumn(Column: Integer);
var
  Comparer: TDBXWritableValueArrayComparer;
begin
  Comparer := TDBXWritableValueArrayComparer.Create(Column);
  try
    FCache.ValueRows.Sort(Comparer);
  finally
    Comparer.Free;
  end;
end;

procedure TDBXTableStorage.Post;
var
  LValue: TDBXWritableValue;
  I: Integer;
begin
  for I := 0 to Length(Values) - 1 do
  begin
    LValue := Values[I];
    if TDBXMemoryValue(LValue).FOriginalValue <> nil then
      if not TDBXMemoryValue(LValue).FOriginalValue.EqualsValue(LValue) then
      begin
        if not FCache.InsertedRows.Contains(Values) then
          if not FCache.UpdatedRows.Contains(Values) then
            FCache.UpdatedRows.Add(Values);
        break;
      end;
  end;
end;

procedure TDBXTableStorage.SetColumns(const Columns: TDBXValueTypeArray);
begin
  FCache.SetColumns(Columns);
end;

procedure TDBXTableStorage.SetDBXTableName(const AName: string);
begin
  FName := AName;
end;

procedure TDBXTableStorage.UpdateCurrentRow;
begin
  if FIndex < FCache.ValueRows.Count then
    SetValues(FCache.ValueRows[FIndex], Length(FCache.ValueRows[FIndex]))
end;

{ TDBXCache }

constructor TDBXCache.Create;
begin
  Create(True);
end;

procedure TDBXCache.AcceptChanges;
var
  I, J: Integer;
begin
  // Make sure all TDBXMemoryValue contains the correct "original value"
  //  at this point before clearing the lists

                                                                 

  for I := 0 to FInsertedRows.Count - 1 do
    for J := 0 to Length(FInsertedRows.Items[I]) - 1 do
      if FInsertedRows.Items[I][J] is TDBXMemoryValue then
        TDBXMemoryValue(FInsertedRows.Items[I][J]).AcceptChanges;
  for I := 0 to FUpdatedRows.Count - 1 do
    for J := 0 to Length(FUpdatedRows.Items[I]) - 1 do
      if FUpdatedRows.Items[I][J] is TDBXMemoryValue then
        TDBXMemoryValue(FUpdatedRows.Items[I][J]).AcceptChanges;
  ClearChangeLog;
end;

procedure TDBXCache.AddRow(ARow: TDBXWritableValueArray);
begin
  FValueRows.Add(ARow);
end;

procedure TDBXCache.Clear;
var
  I: Integer;
begin
  ClearChangeLog;
  if Assigned(FValueRows) then
  begin
    // Free rows
    if FOwnsValues then
      for I := FValueRows.Count - 1 downto 0 do
      begin
        ClearValues(FValueRows[I]);
        FValueRows.Delete(I);
      end;
  end;
end;

procedure TDBXCache.ClearChangeLog;
var
  I: Integer;
begin
  //cleanup after merge
  for I := 0 to FDeletedRows.Count - 1 do
    ClearValues(FDeletedRows[I]);
  FDeletedRows.Clear;
  FInsertedRows.Clear;
  FUpdatedRows.Clear;
end;

procedure TDBXCache.ClearValues(AValues: TDBXWritableValueArray);
var
  I: Integer;
begin
  for I := 0 to Length(AValues) - 1 do
    AValues[I].Free;
end;

constructor TDBXCache.Create(AOwnsValues: Boolean);
begin
  inherited Create;
  FOwnsValues := AOwnsValues;
  FValueRows := TList<TDBXWritableValueArray>.Create;
  FInsertedRows := TList<TDBXWritableValueArray>.Create;
  FUpdatedRows := TList<TDBXWritableValueArray>.Create;
  FDeletedRows := TList<TDBXWritableValueArray>.Create;
end;

function TDBXCache.CreateWritableValueArray: TDBXWritableValueArray;
var
  Value: TDBXWritableValue;
  Values: TDBXWritableValueArray;
  Ordinal: Integer;
begin
  SetLength(Values, Length(FValueTypes));
  for Ordinal := 0 to Length(Values) - 1 do
  begin
    if FValueTypes[Ordinal] <> nil then
    begin
      // Note that we must clone the column here because a TDBXValue owns the TDBXValueType.
      // Would be nice to add ownership control
      Value := TDBXMemoryValue.Create(TDBXValue.CreateValue(nil, FValueTypes[Ordinal].Clone, nil, False){, Self});
      Value.ValueType.Ordinal := Ordinal;
      Values[Ordinal] := Value;
    end;
  end;
  Result := Values;
end;

procedure TDBXCache.DeleteRow(AIndex: Integer);
var
  LRow: TDBXWritableValueArray;
begin
  if (AIndex < FValueRows.Count) and (AIndex > -1) then
  begin
    LRow := FValueRows.Items[AIndex];
    if FUpdatedRows.Contains(LRow) then
      FUpdatedRows.Remove(LRow);
    if FInsertedRows.Contains(LRow) then
      FInsertedRows.Remove(LRow)
    else
      FDeletedRows.Add(LRow);
    FValueRows.Delete(AIndex);
    if FOwnsValues then
    begin
      //only free if the row was not added to the list of
      //  DeletedRows which will be freed at TearDown
      if not FDeletedRows.Contains(LRow) then
        ClearValues(LRow);
    end;
  end
  else
                         
    raise Exception.Create('Invalid index');
end;

procedure TDBXCache.ClearValueTypes(AValueTypes: TDBXValueTypeArray);
var
  I: Integer;
begin
  for I := 0 to Length(AValueTypes) - 1 do
    AValueTypes[I].Free;
end;

destructor TDBXCache.Destroy;
begin
  Clear;
  ClearValueTypes(FValueTypes);
  FDeletedRows.Free;
  FInsertedRows.Free;
  FUpdatedRows.Free;
  FValueRows.Free;
  inherited;
end;

function TDBXCache.GetColumns: TDBXValueTypeArray;
begin
  Result := FValueTypes;
end;

procedure TDBXCache.Insert(AIndex: Integer);
var
  LRow: TDBXWritableValueArray;
begin
  LRow := CreateWritableValueArray;
  FValueRows.Insert(AIndex, LRow);
  FInsertedRows.Add(LRow);
end;

procedure TDBXCache.SetColumns(Columns: TDBXValueTypeArray);
begin
  FValueTypes := Columns;
end;

end.
