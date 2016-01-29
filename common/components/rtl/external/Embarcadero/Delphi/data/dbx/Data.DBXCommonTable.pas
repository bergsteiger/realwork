{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Data.DBXCommonTable;

interface

uses
  Data.DBXCommon,
  Data.DBXDelegate,
  Data.DBXJSON,
  Data.DBXPlatform;

type
  TDBXStreamerRow = class;
  TDBXTable = class;

  TDBXActiveTableReaderItem = class
  public
    destructor Destroy; override;
    procedure ResetEos;
    procedure SetParameterEos(const ParameterOrdinal: Integer; const Eos: Boolean);
    function IsParameterEos(const ParameterOrdinal: Integer): Boolean;
  protected
    function IsReaderEos: Boolean;
    procedure SetParameterList(const AParameterList: TDBXParameterList);
    procedure SetReader(const AReader: TDBXReader);
    procedure SetStreamerRow(const StreamerRow: TDBXStreamerRow); virtual;
    function GetStreamerRow: TDBXStreamerRow; virtual;
    procedure SetReaderEos(const Eos: Boolean); virtual;
  private
    procedure InitEos;
  public
    FStreamerRowHandle: Integer;
    FNext: TDBXActiveTableReaderItem;
  private
    FStreamerRow: TDBXStreamerRow;
    [Weak]FParameterList: TDBXParameterList;
    [Weak]FReader: TDBXReader;
    FEos: Boolean;
    FEosParams: TDBXBooleans;
    FOwnsRow: Boolean;
    FIsParameterRow: Boolean;
  public
    property ParameterList: TDBXParameterList read FParameterList write SetParameterList;
    property ReaderEos: Boolean read IsReaderEos write SetReaderEos;
    property Reader: TDBXReader read FReader write SetReader;
    property StreamerRow: TDBXStreamerRow read GetStreamerRow write SetStreamerRow;
    property OwnsRow: Boolean write FOwnsRow;
    property ParameterRow: Boolean read FIsParameterRow write FIsParameterRow;
  end;

  TDBXActiveTableReaderList = class
  public
    destructor Destroy; override;
    function AllocateRowHandle: Integer;
    function AddDBXStreamerRow(const Row: TDBXStreamerRow; const RowHandle: Integer; const OwnsRow: Boolean; const IsParameterRow: Boolean): TDBXActiveTableReaderItem;
    function FindStreamerRowItem(const StreamerRowHandle: Integer): TDBXActiveTableReaderItem;
    procedure CloseAllActiveTableReaders;
  protected
    function IsEos: Boolean;
  private
    FFirst: TDBXActiveTableReaderItem;
    FLastRowHandle: Integer;
  public
    property Eos: Boolean read IsEos;
  end;

  TDBXJSONTableReader = class(TDBXReader)
  public
    constructor Create(const DbxContext: TDBXContext; const Table: TJSONObject; const OwnsJSONObject: Boolean = false);
    destructor Destroy; override;
    function DerivedNext: Boolean; override;
    procedure DerivedClose; override;
    function GetValueType(const Ordinal: Integer): TDBXValueType; override;
    function GetValue(const Ordinal: Integer): TDBXValue; override;
  protected
    function GetByteReader: TDBXByteReader; override;
    function GetColumnCount: Integer; override;
  private
    procedure CleanRowValues;
    procedure CleanValueTypes;
    function CreateWritableValue(const Ordinal: Integer): TDBXWritableValue;
    function GetColumnDataPair(AIndex: Integer): TJSONPair;
  private
    FJsonTableByteReader: TDBXByteReader;
    FJsonTable: TJSONObject;
    FRowNb: Integer;
    FValueTypes: TDBXValueTypeArray;
    FRow: TDBXWritableValueArray;
    FColumnCount: Integer;
    FOwnsJsonTable: Boolean;
  end;

  TDBXSQLColumnFlags = class
  public
    const FlagReadonly = 1;
    const FlagSearchable = 2;
    const FlagCurrency = 4;
    const FlagNullable = 8;
    const FlagSigned = 16;
    const FlagCasesensitive = 32;
    const FlagAutoincrement = 64;
    const FlagInternalrow = 128;
  end;

  TDBXStreamerRow = class abstract(TDBXRow)
  public
    constructor Create(const AContext: TDBXContext);
    procedure RecordDBXReaderSet(const ValueType: TDBXValueType);
  protected
    procedure ValueNotSet(const Value: TDBXWritableValue); override;
  private
    FRowHandle: Integer;
    FFirstDBXReaderOrdinal: Integer;
    FLastDBXReaderOrdinal: Integer;
    FNeedsNext: Boolean;
  public
    property RowHandle: Integer read FRowHandle write FRowHandle;
    property FirstDBXReaderOrdinal: Integer read FFirstDBXReaderOrdinal;
    property LastDBXReaderOrdinal: Integer read FLastDBXReaderOrdinal;
    property NeedsNext: Boolean read FNeedsNext write FNeedsNext;
  end;

  TDBXNoOpRow = class(TDBXStreamerRow)
  public
    constructor Create(const AContext: TDBXContext);
    function CreateCustomValue(const ValueType: TDBXValueType): TDBXValue; override;
  protected
    procedure NotImplemented; override;
    function GetGeneration: Integer; override;
  end;

  TDBXTableEntity = class
  public
    constructor Create(const ATable: TDBXTable; const AOwnTable: Boolean);
    destructor Destroy; override;
  private
    FTable: TDBXTable;
    FOwnTable: Boolean;
  public
    property Table: TDBXTable read FTable;
  end;

  TDBXTableReader = class(TDBXReader)
  public
    constructor Create(const DbxTable: TDBXTable); overload;
    constructor Create(const Context: TDBXContext; const DbxTable: TDBXTable); overload;
    destructor Destroy; override;
    function GetValue(const Ordinal: Integer): TDBXValue; override;
    function GetValueType(const Ordinal: Integer): TDBXValueType; override;
    function GetValueByName(const Name: string): TDBXValue; override;
    function DerivedNext: Boolean; override;
    function Next: Boolean; override;
    procedure DerivedClose; override;
  protected
    function GetColumnCount: Integer; override;
    function GetByteReader: TDBXByteReader; override;
  private
    FTable: TDBXTable;
    FBeforeFirst: Boolean;
  end;

  TDBXTableRow = class abstract(TDBXWritableValueList)
  public
    constructor Create(const DbxContext: TDBXContext);
    function CopyColumns: TDBXValueTypeArray; virtual; abstract;
  protected
    function GetColumns: TDBXValueTypeArray; virtual; abstract;
    procedure SetColumns(const Columns: TDBXValueTypeArray); virtual; abstract;
    procedure SetDBXTableName(const Name: string); virtual; abstract;
    function GetDBXTableName: string; virtual; abstract;
    function GetOriginalRow: TDBXTableRow; virtual; abstract;

    /// <summary> Returns column zero-based index based on column name
    ///
    /// </summary>
    /// <param name="columnName">String - column name, case insensitive</param>
    /// <returns>int - column index, -1 if not found</returns>
    function ColumnIndex(const ColumnName: string): Integer; virtual;
  public
    property Columns: TDBXValueTypeArray read GetColumns write SetColumns;
    property DBXTableName: string read GetDBXTableName write SetDBXTableName;
    property OriginalRow: TDBXTableRow read GetOriginalRow;
  end;

  TDBXTableState = (tsInactive, tsBrowsing, tsInserting, tsEditing);
  TDBXTable = class abstract(TDBXTableRow)
  public
    constructor Create(const DbxContext: TDBXContext);
    function InBounds: Boolean; virtual; abstract;
    function Next: Boolean; virtual; abstract;
    function First: Boolean; virtual; abstract;
    function CopyColumns: TDBXValueTypeArray; override;
    procedure CopyFrom(const Source: TDBXTable); overload; virtual;
    procedure CopyFrom(const Source: TDBXReader); overload; virtual;
    function GetState: TDBXTableState; virtual;
    procedure Insert; virtual;
    function Edit: Boolean; virtual;
    procedure Cancel; virtual;
    procedure Post; virtual;
    procedure Close; virtual;
    procedure Clear; virtual;
    procedure DeleteRow; virtual;
    function FindStringKey(const Ordinal: Integer; const Value: string): Boolean; virtual;
    procedure AcceptChanges; virtual;
    function CreateTableView(const OrderByColumnName: string): TDBXTable; virtual;
  protected
    procedure SetDBXTableName(const Name: string); override;
    function GetDBXTableName: string; override;
    function GetOriginalRow: TDBXTableRow; override;
    procedure SetColumns(const Columns: TDBXValueTypeArray); override;
    function IsUpdateable: Boolean; virtual;
    function GetStorage: TObject; virtual;
    function GetCommand: TObject; virtual;
    function GetDeletedRows: TDBXTable; virtual;
    function GetInsertedRows: TDBXTable; virtual;
    function GetUpdatedRows: TDBXTable; virtual;
    function GetTableId: Integer; virtual;
    function GetTableCount: Integer; virtual;
  public
    property State: TDBXTableState read GetState;
    property Updateable: Boolean read IsUpdateable;
    property Storage: TObject read GetStorage;
    property Command: TObject read GetCommand;
    property DeletedRows: TDBXTable read GetDeletedRows;
    property InsertedRows: TDBXTable read GetInsertedRows;
    property UpdatedRows: TDBXTable read GetUpdatedRows;
    property TableId: Integer read GetTableId;
    property TableCount: Integer read GetTableCount;
  end;

  TDBXDelegateTable = class(TDBXTable)
  public
    constructor Create;
    destructor Destroy; override;
    function ReplaceStorage(const Table: TDBXTable): TDBXTable; virtual;
    function InBounds: Boolean; override;
    function First: Boolean; override;
    function Next: Boolean; override;
    procedure Insert; override;
    function Edit: Boolean; override;
    procedure Cancel; override;
    procedure Post; override;
    procedure CopyFrom(const Source: TDBXTable); override;
    procedure Close; override;
    procedure Clear; override;
    procedure DeleteRow; override;
    function FindStringKey(const Ordinal: Integer; const Value: string): Boolean; override;
    procedure AcceptChanges; override;
    function CreateTableView(const OrderByColumnName: string): TDBXTable; override;
    function GetOrdinal(const ColumnName: string): Integer; override;
  protected
    function GetWritableValue(const Ordinal: Integer): TDBXWritableValue; override;
    procedure SetTable(const Table: TDBXTable); virtual;
    function IsUpdateable: Boolean; override;
    function GetStorage: TObject; override;
    function GetCommand: TObject; override;
    function GetDeletedRows: TDBXTable; override;
    function GetInsertedRows: TDBXTable; override;
    function GetUpdatedRows: TDBXTable; override;
    function GetColumns: TDBXValueTypeArray; override;
    procedure SetColumns(const Columns: TDBXValueTypeArray); override;
    function GetDBXTableName: string; override;
    function GetOriginalRow: TDBXTableRow; override;
  protected
    FTable: TDBXTable;
  public
    property Table: TDBXTable write SetTable;
  end;

  TDBXStringTrimTable = class(TDBXDelegateTable)
  public
    constructor Create(const Table: TDBXTable; const TrimValues: TDBXWritableValueArray);
    class function CreateTrimTableIfNeeded(const Table: TDBXTable): TDBXTable; static;
    destructor Destroy; override;
  protected
    function GetWritableValue(const Ordinal: Integer): TDBXWritableValue; override;
  private
    class function HasCharTypes(const Columns: TDBXValueTypeArray): Boolean; static;
  public
    FTrimValues: TDBXWritableValueArray;
  end;

  TDBXTrimStringValue = class(TDBXDelegateWritableValue)
  public
    constructor Create(const Value: TDBXWritableValue);
    function GetWideString: string; override;
  protected
    function GetAsString: string; override;
  end;

  TDBXReaderTable = class(TDBXTable)
  public
    constructor Create(const AReader: TDBXReader);
    function First: Boolean; override;
    function InBounds: Boolean; override;
    function Next: Boolean; override;
    function GetOrdinal(const ColumnName: string): Integer; override;
    procedure Close; override;
  protected
    function GetColumns: TDBXValueTypeArray; override;
    function GetWritableValue(const Ordinal: Integer): TDBXWritableValue; override;
  private
    FReader: TDBXReader;
    FNextCount: Integer;
    FLastNext: Boolean;
  end;

  /// <summary> Models persisted-able table. It is based on a current row being handled
  /// </summary>
  /// <remarks> It is based on a current row being handled
  /// by a DBXRow instance. Having a null DBXRow is supported but not encouraged;
  /// a DBXMemoryTable should be used instead.
  ///
  /// It assumes DBXRow ownership.
  /// </remarks>
  TDBXRowTable = class abstract(TDBXTable)
  public

    /// <param name="dbxContext"></param>
    /// <param name="row"></param>
    constructor Create(const DbxContext: TDBXContext; const Row: TDBXRow);
    destructor Destroy; override;
  protected
    procedure RowNavigated; virtual;
    procedure CreateValues; overload; virtual;
  private
    class function CreateValues(const Context: TDBXContext; const LocalColumns: TDBXValueTypeArray; const Row: TDBXRow): TDBXWritableValueArray; overload; static;
  protected
    FRow: TDBXRow;
  end;

  TDBXCustomValueRow = class(TDBXRowTable)
  public
    constructor Create(const DbxContext: TDBXContext; const Row: TDBXRow);
    function InBounds: Boolean; override;
    function Next: Boolean; override;
    function First: Boolean; override;
    function GetOrdinal(const ColumnName: string): Integer; override;
  protected
    function GetOriginalRow: TDBXTableRow; override;
    function GetColumns: TDBXValueTypeArray; override;
    procedure SetColumns(const ValueTypes: TDBXValueTypeArray); override;
    procedure SetDBXTableName(const Name: string); override;
    function GetDBXTableName: string; override;
  private
    FValueTypes: TDBXValueTypeArray;
  end;

  TDBXSingleValueRow = class(TDBXCustomValueRow)
  public
    constructor Create;
  protected
    procedure SetColumns(const ValueTypes: TDBXValueTypeArray); override;
  end;

implementation

uses
  Data.DBXJSONCommon,
  System.SysUtils,
  Data.DBXCommonResStrs
{$IFDEF MACOS}
  , Macapi.CoreFoundation
{$ENDIF MACOS}
;

destructor TDBXActiveTableReaderItem.Destroy;
begin
  if FOwnsRow then
    FreeAndNil(FStreamerRow);
  FEosParams := nil;
  inherited Destroy;
end;

function TDBXActiveTableReaderItem.IsReaderEos: Boolean;
var
  Ordinal: Integer;
begin
  if not FEos and not FIsParameterRow then
    Exit(False);
  if FIsParameterRow then
    InitEos;
  if FEosParams <> nil then
    for Ordinal := 0 to Length(FEosParams) - 1 do
      if not FEosParams[Ordinal] then
        Exit(False);
  Result := True;
end;

procedure TDBXActiveTableReaderItem.SetParameterList(const AParameterList: TDBXParameterList);
begin
  FEosParams := nil;
  self.FParameterList := AParameterList;
end;

procedure TDBXActiveTableReaderItem.ResetEos;
begin
  FEosParams := nil;
end;

procedure TDBXActiveTableReaderItem.InitEos;
var
  Parameter: TDBXParameter;
  Ordinal: Integer;
begin
  if (FEosParams = nil) and (FParameterList <> nil) then
  begin
    SetLength(FEosParams, FParameterList.Count);
    for Ordinal := 0 to Length(FEosParams) - 1 do
    begin
      Parameter := FParameterList.Parameter[Ordinal];
      case Parameter.DataType of
        TDBXDataTypes.AnsiStringType,
        TDBXDataTypes.WideStringType,
        TDBXDataTypes.BinaryBlobType:
          if (Parameter.ParameterDirection = TDBXParameterDirections.OutParameter) or (Parameter.ParameterDirection = TDBXParameterDirections.InOutParameter) or (Parameter.ParameterDirection = TDBXParameterDirections.ReturnParameter) then
            FEosParams[Ordinal] := not TDBXDriverHelp.HasOverflowBytes(Parameter.Value)
          else 
            FEosParams[Ordinal] := True;
      else
        FEosParams[Ordinal] := True;
      end;
    end;
  end;
end;

procedure TDBXActiveTableReaderItem.SetParameterEos(const ParameterOrdinal: Integer; const Eos: Boolean);
begin
  if FParameterList <> nil then
  begin
    InitEos;
    FEosParams[ParameterOrdinal] := Eos;
  end;
end;

function TDBXActiveTableReaderItem.IsParameterEos(const ParameterOrdinal: Integer): Boolean;
begin
  InitEos;
  if FEosParams = nil then
    Exit(False);
  Result := FEosParams[ParameterOrdinal];
end;

procedure TDBXActiveTableReaderItem.SetReader(const AReader: TDBXReader);
begin
  self.ReaderEos := False;
  self.FReader := AReader;
end;

procedure TDBXActiveTableReaderItem.SetStreamerRow(const StreamerRow: TDBXStreamerRow);
begin
  self.FStreamerRow := StreamerRow;
end;

function TDBXActiveTableReaderItem.GetStreamerRow: TDBXStreamerRow;
begin
  self.ReaderEos := False;
  Result := FStreamerRow;
end;

procedure TDBXActiveTableReaderItem.SetReaderEos(const Eos: Boolean);
begin
  self.FEos := Eos;
end;

destructor TDBXActiveTableReaderList.Destroy;
begin
  CloseAllActiveTableReaders;
  FreeAndNil(FFirst);
  inherited Destroy;
end;

function TDBXActiveTableReaderList.IsEos: Boolean;
var
  Item: TDBXActiveTableReaderItem;
begin
  Item := FFirst;
  while Item <> nil do
  begin
    if not Item.ReaderEos then
      Exit(False);
    Item := Item.FNext;
  end;
  Result := True;
end;

function TDBXActiveTableReaderList.AllocateRowHandle: Integer;
begin
  Inc(FLastRowHandle);
  Result := FLastRowHandle;
end;

function TDBXActiveTableReaderList.AddDBXStreamerRow(const Row: TDBXStreamerRow; const RowHandle: Integer; const OwnsRow: Boolean; const IsParameterRow: Boolean): TDBXActiveTableReaderItem;
var
  Item: TDBXActiveTableReaderItem;
begin
  Item := TDBXActiveTableReaderItem.Create;
  Item.StreamerRow := Row;
  Item.OwnsRow := OwnsRow;
  Item.ParameterRow := IsParameterRow;
  Item.FStreamerRowHandle := RowHandle;
  Row.RowHandle := RowHandle;
  Item.FNext := FFirst;
  FFirst := Item;
  Result := Item;
end;

function TDBXActiveTableReaderList.FindStreamerRowItem(const StreamerRowHandle: Integer): TDBXActiveTableReaderItem;
var
  Item: TDBXActiveTableReaderItem;
begin
  Item := FFirst;
  while Item <> nil do
  begin
    if Item.FStreamerRowHandle = StreamerRowHandle then
      Exit(Item);
    Item := Item.FNext;
  end;
  Result := nil;
end;

procedure TDBXActiveTableReaderList.CloseAllActiveTableReaders;
var
  Item: TDBXActiveTableReaderItem;
  TempItem: TDBXActiveTableReaderItem;
begin
  Item := FFirst;
  if Item <> nil then
  begin
    Item.ResetEos;
    Item := Item.FNext;
    FFirst.FNext := nil;
  end;
  while Item <> nil do
  begin
    TempItem := Item;
    Item := Item.FNext;
    FreeAndNil(TempItem);
  end;
  FLastRowHandle := 0;
end;

constructor TDBXJSONTableReader.Create(const DbxContext: TDBXContext; const Table: TJSONObject;
  const OwnsJSONObject: Boolean);
var
  MetaPair: TJSONPair;
  I: Integer;
  LValues: TDBXWritableValueArray;
begin
  inherited Create(DbxContext, TDBXNoOpRow.Create(DbxContext), nil);
  FJsonTableByteReader := nil;
  FOwnsJsonTable := OwnsJSONObject;
  FJsonTable := Table;
  FRowNb := -1;
  FColumnCount := 0;
  MetaPair := Table.Get(TABLE_PAIR);
  if MetaPair <> nil then
  begin
    FColumnCount := (TJSONArray(MetaPair.JsonValue)).Size;
    SetLength(FValueTypes, FColumnCount);
    SetLength(FRow, FColumnCount);
    SetLength(LValues, FColumnCount);
    for I := 0 to FColumnCount - 1 do
    begin
      FValueTypes[I] := TDBXJSONTools.JSONToValueType(TJSONArray((TJSONArray(MetaPair.JsonValue)).Get(I)));
      LValues[I] := CreateWritableValue(I);
    end;
  end
  else
  begin
    SetLength(FRow, FColumnCount);
    SetLength(FValueTypes, FColumnCount);
    SetLength(LValues, FColumnCount);
  end;
  SetValues(LValues);
end;

destructor TDBXJSONTableReader.Destroy;
begin
  CleanRowValues;
  CleanValueTypes;
  if FOwnsJsonTable then
    FJsonTable.Free;
  FJsonTableByteReader.Free;
  inherited Destroy;
end;

procedure TDBXJSONTableReader.CleanRowValues;
var
  I: Integer;
begin
  for I := 0 to Length(FRow) - 1 do
  begin
    FRow[I].Free;
    FRow[I] := nil;
  end;
end;

procedure TDBXJSONTableReader.CleanValueTypes;
var
  I: Integer;
begin
  for I := 0 to Length(FValueTypes) - 1 do
  begin
    FValueTypes[I].Free;
    FValueTypes[I] := nil;
  end;
end;

// Find the column data based on an index, but assume JSONObject has unordered pairs.
// Tables look like this:
// '{"table":[["Column1",6,0,0,0,0,0,0,false,false,0,false,false]],"Column1":[0,1,2,3,4,5,6,7,8,9]}'
function TDBXJSONTableReader.GetColumnDataPair(AIndex: Integer): TJSONPair;
var
  ColMetaData: TJSONValue;
  JsonPair: TJSONPair;
  ColName: TJSONValue;
begin
  Result := nil;
  JsonPair := FJsonTable.Get(TABLE_PAIR);
  if JsonPair <>  nil then
    if JsonPair.JsonValue is TJSONArray then
    begin
      ColMetaData := TJSONArray(JsonPair.JsonValue).Get(AIndex);
      if ColMetaData is TJSONArray then
      begin
        ColName := TJSONArray(ColMetaData).Get(0);
        if ColName is TJSONString then
          Result := FJsonTable.Get(ColName.Value);
      end;
    end;
end;

function TDBXJSONTableReader.DerivedNext: Boolean;
var
  Col1: TJSONPair;
begin
  Col1 := GetColumnDataPair(0);

  if Col1 = nil then
    Exit(False);
  if FRowNb < (TJSONArray(Col1.JsonValue)).Size - 1 then
  begin
    IncrAfter(FRowNb);
    CleanRowValues;
    Result := True;
  end
  else
    Result := False;
end;

procedure TDBXJSONTableReader.DerivedClose;
begin
  FRowNb := -1;
  CleanRowValues;
end;

function TDBXJSONTableReader.GetByteReader: TDBXByteReader;
begin
  if FJsonTableByteReader = nil then
    FJsonTableByteReader := TDBXReaderByteReader.Create(DBXContext, Self);
  Result := FJsonTableByteReader;
end;

function TDBXJSONTableReader.GetValueType(const Ordinal: Integer): TDBXValueType;
begin
  if Ordinal < FColumnCount then
    Exit(FValueTypes[Ordinal]);
  Result := nil;
end;

function TDBXJSONTableReader.CreateWritableValue(const Ordinal: Integer): TDBXWritableValue;
begin
  Result := nil;
  if Ordinal < FColumnCount then
  begin
    Result := TDBXValue.CreateValue(DBXContext, TDBXValueType(self.ValueType[Ordinal].Clone()), GetRow, False);
  end;
end;

function TDBXJSONTableReader.GetValue(const Ordinal: Integer): TDBXValue;
var
  JCell: TJSONValue;
  JSonPair: TJSONPair;
begin
  if Ordinal < FColumnCount then
  begin
    if FRow[Ordinal] = nil then
    begin
      JsonPair := GetColumnDataPair(Ordinal);
      JCell := nil;
      if (JsonPair <> nil) and (JsonPair.JsonValue is TJSONArray) then
        JCell := TJSONArray(JsonPair.JSonValue).Get(FRowNb);
      if JCell = nil then
        Exit(nil);
      FRow[Ordinal] := CreateWritableValue(Ordinal); //TDBXValue.CreateValue(DBXContext, TDBXValueType(self.ValueType[Ordinal].Clone()), GetRow, False);
      TDBXJSONTools.JSONToDBX(JCell, FRow[Ordinal], self.ValueType[Ordinal].DataType, False);
    end;
    Exit(FRow[Ordinal]);
  end;
  Result := nil;
end;

function TDBXJSONTableReader.GetColumnCount: Integer;
begin
  Result := FColumnCount;
end;

constructor TDBXStreamerRow.Create(const AContext: TDBXContext);
begin
  inherited Create(AContext);
  FFirstDBXReaderOrdinal := -1;
end;

procedure TDBXStreamerRow.RecordDBXReaderSet(const ValueType: TDBXValueType);
var
  Ordinal: Integer;
begin
  Ordinal := ValueType.Ordinal;
  if (FFirstDBXReaderOrdinal < 0) or (FFirstDBXReaderOrdinal > Ordinal) then
    FFirstDBXReaderOrdinal := Ordinal;
  if FLastDBXReaderOrdinal < Ordinal then
    FLastDBXReaderOrdinal := Ordinal;
end;

procedure TDBXStreamerRow.ValueNotSet(const Value: TDBXWritableValue);
begin
  case Value.ValueType.ParameterDirection of
    TDBXParameterDirections.OutParameter,
    TDBXParameterDirections.ReturnParameter:
      raise TDBXError.Create(TDBXErrorCodes.ParameterNotSet, Format(SParameterNotSet, [IntToStr(Value.ValueType.Ordinal)]));
  end;
  SetNull(Value);
end;

constructor TDBXNoOpRow.Create(const AContext: TDBXContext);
begin
  inherited Create(AContext);
end;

procedure TDBXNoOpRow.NotImplemented;
begin
end;

function TDBXNoOpRow.CreateCustomValue(const ValueType: TDBXValueType): TDBXValue;
begin
  case ValueType.DataType of
    TDBXDataTypes.WideStringType:
      Exit(TDBXStringValue.Create(ValueType));
  end;
  Result := nil;
end;

function TDBXNoOpRow.GetGeneration: Integer;
begin
  Result := -1;
end;

constructor TDBXTableEntity.Create(const ATable: TDBXTable; const AOwnTable: Boolean);
begin
  inherited Create;
  FTable := ATable;
  FOwnTable := AOwnTable;
end;

destructor TDBXTableEntity.Destroy;
begin
  if FOwnTable then
    FreeAndNil(FTable);
  inherited Destroy;
end;

constructor TDBXTableReader.Create(const DbxTable: TDBXTable);
begin
  Create(nil, DbxTable);
end;

constructor TDBXTableReader.Create(const Context: TDBXContext; const DbxTable: TDBXTable);
begin
  inherited Create(Context, nil, nil);
  FTable := DbxTable;
  FBeforeFirst := DbxTable.First;
  SetValues(DbxTable.Values);
end;

destructor TDBXTableReader.Destroy;
var
  Empty: TDBXWritableValueArray;
begin
  SetLength(Empty, 0);
  SetValues(Empty);
  FreeAndNil(FTable);
  inherited Destroy;
end;

function TDBXTableReader.GetColumnCount: Integer;
begin
  Result := Length(FTable.Columns);
end;

function TDBXTableReader.GetValue(const Ordinal: Integer): TDBXValue;
begin
  Result := FTable.Value[Ordinal];
end;

function TDBXTableReader.GetValueType(const Ordinal: Integer): TDBXValueType;
begin
  Result := FTable.Columns[Ordinal];
end;

function TDBXTableReader.GetValueByName(const Name: string): TDBXValue;
begin
  Result := FTable.Value[FTable.GetOrdinal(Name)];
end;

function TDBXTableReader.GetByteReader: TDBXByteReader;
begin
  Result := nil;
end;

function TDBXTableReader.DerivedNext: Boolean;
begin
  if FBeforeFirst then
  begin
    FBeforeFirst := False;
    Result := True;
  end
  else
    Result := FTable.Next;
end;

function TDBXTableReader.Next: Boolean;
begin
  Result := DerivedNext;
end;

procedure TDBXTableReader.DerivedClose;
begin
  FTable := nil;
end;

constructor TDBXTableRow.Create(const DbxContext: TDBXContext);
begin
  inherited Create(DbxContext);
end;

function TDBXTableRow.ColumnIndex(const ColumnName: string): Integer;
var
  J: Integer;
begin
  for J := 0 to Length(Columns) - 1 do
  begin
    if string.Compare(Columns[J].Name, ColumnName, True) = 0 then
      Exit(J);
  end;
  Result := -1;
end;

constructor TDBXTable.Create(const DbxContext: TDBXContext);
begin
  inherited Create(DbxContext);
end;

procedure TDBXTable.SetDBXTableName(const Name: string);
begin
  raise Exception.Create(SUnsupportedOperation);
end;

function TDBXTable.GetDBXTableName: string;
begin
  raise Exception.Create(SUnsupportedOperation);
end;

function TDBXTable.GetOriginalRow: TDBXTableRow;
begin
  raise Exception.Create(SUnsupportedOperation);
end;

procedure TDBXTable.SetColumns(const Columns: TDBXValueTypeArray);
begin
  raise Exception.Create(SUnsupportedOperation);
end;

function TDBXTable.CopyColumns: TDBXValueTypeArray;
var
  CopyColumns, CurrentColumns: TDBXValueTypeArray;
  Ordinal: Integer;
begin
  CurrentColumns := Columns;
  SetLength(CopyColumns, Length(CurrentColumns));
  for Ordinal := 0 to Length(CurrentColumns) - 1 do
    CopyColumns[Ordinal] := TDBXValueType(CurrentColumns[Ordinal].Clone);
  Result := CopyColumns;
end;

procedure TDBXTable.CopyFrom(const Source: TDBXTable);
var
  ColumnCount, Ordinal: Integer;
begin
  ColumnCount := Length(Columns);
  while Source.Next do
  begin
    Insert;
    for Ordinal := 0 to ColumnCount - 1 do
      Value[Ordinal].SetValue(Source.Value[Ordinal]);
    Post;
  end;
end;

procedure TDBXTable.CopyFrom(const Source: TDBXReader);
var
  ColumnCount, Ordinal: Integer;
begin
  ColumnCount := Length(Columns);
  while Source.Next do
  begin
    Insert;
    for Ordinal := 0 to ColumnCount - 1 do
      Value[Ordinal].SetValue(Source.Value[Ordinal]);
    Post;
  end;
end;

function TDBXTable.IsUpdateable: Boolean;
begin
  Result := False;
end;

procedure TDBXTable.Insert;
begin
  raise Exception.Create(SUnsupportedOperation);
end;

procedure TDBXTable.Post;
begin
  raise Exception.Create(SUnsupportedOperation);
end;

procedure TDBXTable.Close;
begin
  raise Exception.Create(SUnsupportedOperation);
end;

procedure TDBXTable.Cancel;
begin
  raise Exception.Create(SUnsupportedOperation);
end;

procedure TDBXTable.Clear;
begin
  raise Exception.Create(SUnsupportedOperation);
end;

procedure TDBXTable.DeleteRow;
begin
  raise Exception.Create(SUnsupportedOperation);
end;

function TDBXTable.Edit: Boolean;
begin
  raise Exception.Create(SUnsupportedOperation);
end;

function TDBXTable.GetState: TDBXTableState;
begin
  raise Exception.Create(SUnsupportedOperation);
end;

function TDBXTable.GetStorage: TObject;
begin
  Result := nil;
end;

function TDBXTable.GetCommand: TObject;
begin
  Result := nil;
end;

function TDBXTable.FindStringKey(const Ordinal: Integer; const Value: string): Boolean;
begin
  raise Exception.Create(SUnsupportedOperation);
end;

procedure TDBXTable.AcceptChanges;
begin
  raise Exception.Create(SUnsupportedOperation);
end;

function TDBXTable.CreateTableView(const OrderByColumnName: string): TDBXTable;
begin
  raise Exception.Create(SUnsupportedOperation);
end;

function TDBXTable.GetDeletedRows: TDBXTable;
begin
  raise Exception.Create(SUnsupportedOperation);
end;

function TDBXTable.GetInsertedRows: TDBXTable;
begin
  raise Exception.Create(SUnsupportedOperation);
end;

function TDBXTable.GetUpdatedRows: TDBXTable;
begin
  raise Exception.Create(SUnsupportedOperation);
end;

function TDBXTable.GetTableId: Integer;
begin
  Result := 0;
end;

function TDBXTable.GetTableCount: Integer;
begin
  Result := 1;
end;

constructor TDBXDelegateTable.Create;
begin
  inherited Create(nil);
end;

function TDBXDelegateTable.GetWritableValue(const Ordinal: Integer): TDBXWritableValue;
begin
  Result := FTable.Value[Ordinal];
end;

procedure TDBXDelegateTable.SetTable(const Table: TDBXTable);
begin
  self.FTable := Table;
end;

destructor TDBXDelegateTable.Destroy;
begin
  FreeAndNil(FTable);
  inherited Destroy;
end;

function TDBXDelegateTable.Edit: Boolean;
begin
  Result := FTable.Edit;
end;

function TDBXDelegateTable.ReplaceStorage(const Table: TDBXTable): TDBXTable;
var
  OldTable: TDBXTable;
begin
  OldTable := self.FTable;
  self.FTable := Table;
  Result := OldTable;
end;

function TDBXDelegateTable.IsUpdateable: Boolean;
begin
  Result := FTable.Updateable;
end;

function TDBXDelegateTable.InBounds: Boolean;
begin
  Result := FTable.InBounds;
end;

function TDBXDelegateTable.First: Boolean;
begin
  Result := FTable.First;
end;

function TDBXDelegateTable.Next: Boolean;
begin
  Result := FTable.Next;
end;

procedure TDBXDelegateTable.Insert;
begin
  FTable.Insert;
end;

procedure TDBXDelegateTable.Post;
begin
  FTable.Post;
end;

procedure TDBXDelegateTable.CopyFrom(const Source: TDBXTable);
begin
  FTable.CopyFrom(Source);
end;

procedure TDBXDelegateTable.Close;
begin
  FTable.Close;
end;

procedure TDBXDelegateTable.Cancel;
begin
  FTable.Cancel;
end;

procedure TDBXDelegateTable.Clear;
begin
  FTable.Clear;
end;

procedure TDBXDelegateTable.DeleteRow;
begin
  FTable.DeleteRow;
end;

function TDBXDelegateTable.GetStorage: TObject;
begin
  Result := FTable.Storage;
end;

function TDBXDelegateTable.GetCommand: TObject;
begin
  Result := FTable.Command;
end;

function TDBXDelegateTable.FindStringKey(const Ordinal: Integer; const Value: string): Boolean;
begin
  Result := FTable.FindStringKey(Ordinal, Value);
end;

procedure TDBXDelegateTable.AcceptChanges;
begin
  FTable.AcceptChanges;
end;

function TDBXDelegateTable.CreateTableView(const OrderByColumnName: string): TDBXTable;
begin
  Result := FTable.CreateTableView(OrderByColumnName);
end;

function TDBXDelegateTable.GetDeletedRows: TDBXTable;
begin
  Result := FTable.DeletedRows;
end;

function TDBXDelegateTable.GetInsertedRows: TDBXTable;
begin
  Result := FTable.InsertedRows;
end;

function TDBXDelegateTable.GetUpdatedRows: TDBXTable;
begin
  Result := FTable.UpdatedRows;
end;

function TDBXDelegateTable.GetColumns: TDBXValueTypeArray;
begin
  Result := FTable.Columns;
end;

procedure TDBXDelegateTable.SetColumns(const Columns: TDBXValueTypeArray);
begin
  FTable.Columns := Columns;
end;

function TDBXDelegateTable.GetDBXTableName: string;
begin
  Result := FTable.DBXTableName;
end;

function TDBXDelegateTable.GetOrdinal(const ColumnName: string): Integer;
begin
  Result := FTable.GetOrdinal(ColumnName);
end;

function TDBXDelegateTable.GetOriginalRow: TDBXTableRow;
begin
  Result := FTable.OriginalRow;
end;

constructor TDBXStringTrimTable.Create(const Table: TDBXTable; const TrimValues: TDBXWritableValueArray);
begin
  inherited Create;
  self.FTable := Table;
  self.FTrimValues := TrimValues;
end;

class function TDBXStringTrimTable.HasCharTypes(const Columns: TDBXValueTypeArray): Boolean;
var
  Column: TDBXValueType;
  Ordinal: Integer;
begin
  for Ordinal := 0 to Length(Columns) - 1 do
  begin
    Column := Columns[Ordinal];
    if Column.SubType = TDBXDataTypes.CharArrayType then
      Exit(True);
  end;
  Result := False;
end;

class function TDBXStringTrimTable.CreateTrimTableIfNeeded(const Table: TDBXTable): TDBXTable;
var
  Columns: TDBXValueTypeArray;
  TrimValues: TDBXWritableValueArray;
  Ordinal: Integer;
begin
  Columns := Table.Columns;
  if HasCharTypes(Columns) then
  begin
    SetLength(TrimValues, Length(Columns));
    for Ordinal := 0 to Length(Columns) - 1 do
      TrimValues[Ordinal] := nil;
    Exit(TDBXStringTrimTable.Create(Table, TrimValues));
  end;
  Result := Table;
end;

function TDBXStringTrimTable.GetWritableValue(const Ordinal: Integer): TDBXWritableValue;
var
  Value: TDBXWritableValue;
begin
  Value := FTrimValues[Ordinal];
  if Value = nil then
  begin
    Value := FTable.Value[Ordinal];
    if Value.ValueType.SubType = TDBXDataTypes.CharArrayType then
    begin
      Value := TDBXTrimStringValue.Create(FTable.Value[Ordinal]);
      FTrimValues[Ordinal] := Value;
    end;
  end;
  Result := Value;
end;

destructor TDBXStringTrimTable.Destroy;
begin
  FreeObjectArray(TDBXFreeArray(FTrimValues));
  inherited Destroy;
end;

constructor TDBXTrimStringValue.Create(const Value: TDBXWritableValue);
begin
  inherited Create(TDBXValueType(Value.ValueType.Clone()), Value);
end;

function TDBXTrimStringValue.GetWideString: string;
var
  Value: string;
begin
  Value := inherited GetWideString;
  Result := Trim(Value);
end;

function TDBXTrimStringValue.GetAsString: string;
var
  Value: string;
begin
  Value := inherited GetAsString;
  Result := Trim(Value);
end;

constructor TDBXReaderTable.Create(const AReader: TDBXReader);
begin
  inherited Create(nil);
  FReader := AReader;
end;

function TDBXReaderTable.First: Boolean;
begin
  if FNextCount = 0 then
  begin
    Inc(FNextCount);
    if FReader.Next then
    begin
      FLastNext := True;
      Exit(True);
    end;
  end
  else 
    FLastNext := False;
  Result := FLastNext;
end;

function TDBXReaderTable.InBounds: Boolean;
begin
  if FNextCount = 0 then
    Exit(First);
  Result := FLastNext;
end;

function TDBXReaderTable.Next: Boolean;
begin
  Inc(FNextCount);
  FLastNext := FReader.Next;
  Result := FLastNext;
end;

function TDBXReaderTable.GetColumns: TDBXValueTypeArray;
begin
  Result := nil;
end;

function TDBXReaderTable.GetOrdinal(const ColumnName: string): Integer;
begin
  Result := FReader.GetOrdinal(ColumnName);
end;

function TDBXReaderTable.GetWritableValue(const Ordinal: Integer): TDBXWritableValue;
begin
  Result := TDBXWritableValue(FReader.Value[Ordinal]);
end;

procedure TDBXReaderTable.Close;
begin
  FReader.Close;
  FReader := nil;
end;

constructor TDBXRowTable.Create(const DbxContext: TDBXContext; const Row: TDBXRow);
begin
  inherited Create(DbxContext);
  self.FRow := Row;
  if Row <> nil then
    Row.NewRowGeneration;
end;

destructor TDBXRowTable.Destroy;
begin
  FreeAndNil(FRow);
  inherited Destroy;
end;

procedure TDBXRowTable.RowNavigated;
begin
  if FRow <> nil then
    FRow.NewRowGeneration;
end;

class function TDBXRowTable.CreateValues(const Context: TDBXContext; const LocalColumns: TDBXValueTypeArray; const Row: TDBXRow): TDBXWritableValueArray;
var
  Value: TDBXWritableValue;
  Values: TDBXWritableValueArray;
  Ordinal: Integer;
begin
  SetLength(Values, Length(LocalColumns));
  for Ordinal := 0 to Length(Values) - 1 do
  begin
    if LocalColumns[Ordinal] <> nil then
    begin
      Value := TDBXWritableValue(TDBXValue.CreateValue(Context, LocalColumns[Ordinal], Row, False));
      Value.ValueType.Ordinal := Ordinal;
      Values[Ordinal] := Value;
    end;
  end;
  if Row <> nil then
    Row.NewRowGeneration;
  Result := Values;
end;

procedure TDBXRowTable.CreateValues;
var
  List: TDBXWritableValueArray;
begin
  List := CreateValues(FDbxContext, Columns, FRow);
  SetValues(List, Length(List));
end;

constructor TDBXCustomValueRow.Create(const DbxContext: TDBXContext; const Row: TDBXRow);
begin
  inherited Create(DbxContext, Row);
end;

function TDBXCustomValueRow.InBounds: Boolean;
begin
  Result := True;
end;

function TDBXCustomValueRow.Next: Boolean;
begin
  Result := False;
end;

function TDBXCustomValueRow.First: Boolean;
begin
  Result := True;
end;

function TDBXCustomValueRow.GetOriginalRow: TDBXTableRow;
begin
  raise Exception.Create(SUnsupportedOperation);
end;

function TDBXCustomValueRow.GetColumns: TDBXValueTypeArray;
begin
  Result := FValueTypes;
end;

procedure TDBXCustomValueRow.SetColumns(const ValueTypes: TDBXValueTypeArray);
begin
  FValueTypes := ValueTypes;
end;

function TDBXCustomValueRow.GetOrdinal(const ColumnName: string): Integer;
var
  Index: Integer;
begin
  for Index := 0 to Length(FValueTypes) - 1 do
  begin
    if string.Compare(FValueTypes[Index].Name, ColumnName, True) = 0 then
      Exit(Index);
  end;
  Result := -1;
end;

procedure TDBXCustomValueRow.SetDBXTableName(const Name: string);
begin
  raise Exception.Create(SUnsupportedOperation);
end;

function TDBXCustomValueRow.GetDBXTableName: string;
begin
  raise Exception.Create(SUnsupportedOperation);
end;

constructor TDBXSingleValueRow.Create;
begin
  inherited Create(nil, nil);
end;

procedure TDBXSingleValueRow.SetColumns(const ValueTypes: TDBXValueTypeArray);
begin
  inherited SetColumns(ValueTypes);
  CreateValues;
end;

end.

