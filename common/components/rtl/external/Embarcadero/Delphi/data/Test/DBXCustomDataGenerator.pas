{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit DBXCustomDataGenerator;

interface

uses
  Data.DBXCommon,
  Data.DBXMetaDataProvider,
  System.SysUtils;

type
  TDBXDataGeneratorColumn = class;
  TDBXDataGeneratorException = class;
  TDBXDataGeneratorColumnArray = array of TDBXDataGeneratorColumn;

  TDBXCustomDataGenerator = class
  public
    procedure AddColumn(const Column: TDBXDataGeneratorColumn); virtual;
    destructor Destroy; override;
    function GetColumn(const Ordinal: Integer): TDBXDataGeneratorColumn; virtual;
    procedure Open; virtual;
    function CreateInsertStatement(const Row: Integer): string; overload; virtual;
    function CreateInsertStatement(const InsertColumns: TDBXDataGeneratorColumnArray; const Row: Integer): string; overload; virtual;
    function CreateParameterizedInsertStatement: string; overload; virtual;
    function CreateParameterizedInsertStatement(const InsertColumns: TDBXDataGeneratorColumnArray): string; overload; virtual;
    procedure Next; virtual;
  protected
    function GetColumnCount: Integer; virtual;
    function GetTableName: string; virtual;
    procedure SetTableName(const TableName: string); virtual;
    function GetMetaDataProvider: TDBXMetaDataProvider; virtual;
    procedure SetMetaDataProvider(const MetaDataProvider: TDBXMetaDataProvider); virtual;
  private
    function ColumnNameString(const Columns: TDBXDataGeneratorColumnArray): string;
    function ValueString(const Columns: TDBXDataGeneratorColumnArray; const Row: Integer): string;
    function MarkerString: string;
    function CreateInsertStatement(const InsertColumns: TDBXDataGeneratorColumnArray; const Row: Integer; const Prepare: Boolean): string; overload;
  private
    FTableName: string;
    FRow: Integer;
    FColumns: TDBXDataGeneratorColumnArray;
    FMetaDataProvider: TDBXMetaDataProvider;
  public
    property ColumnCount: Integer read GetColumnCount;
    property TableName: string read GetTableName write SetTableName;
    property MetaDataProvider: TDBXMetaDataProvider read GetMetaDataProvider write SetMetaDataProvider;
  end;

  TDBXDataGeneratedReader = class(TDBXReader)
  public
    constructor Create(const ARowCount: Int64; const AGeneratorColumns: TDBXDataGeneratorColumnArray);
    destructor Destroy; override;
    function Reset: Boolean; override;
    function DerivedNext: Boolean; override;
    function CompareReader(const Reader: TDBXReader): Boolean; virtual;
    procedure DerivedClose; override;
  protected
    function GetByteReader: TDBXByteReader; override;
    function GetPosition: Int64; virtual;
  private
    procedure CreateValues;
    procedure GenerateValues;
  private
    FPosition: Int64;
    FRowCount: Int64;
    FLastOrdinalCompared: Integer;
    FGeneratorColumns: TDBXDataGeneratorColumnArray;
  public
    property Position: Int64 read GetPosition;
    property LastOrdinalCompared: Integer read FLastOrdinalCompared;
  end;

  TDBXDataGeneratedRow = class(TDBXRow)
  public
    constructor Create(const Context: TDBXContext);
  end;

  TDBXDataGeneratorColumn = class abstract
  public
    constructor Create(const InMetaDataColumn: TDBXMetaDataColumn);
    procedure Open; virtual;
    destructor Destroy; override;
    function GetString(const Row: Int64): string; virtual; abstract;
    function GetBoolean(const Row: Int64): Boolean; virtual;
    function GetInt8(const Row: Int64): Byte; virtual;
    function GetInt16(const Row: Int64): SmallInt; virtual;
    function GetInt32(const Row: Int64): Integer; virtual;
    function GetInt64(const Row: Int64): Int64; virtual;
    function GetDouble(const Row: Int64): Double; virtual;
    function GetSingle(const Row: Int64): Single; virtual;
    function GetBytes(const Row: Int64): TArray<Byte>; virtual;
    function GetDecimal(const Row: Int64): string; virtual;
    function GetYear(const Row: Int64): Integer; virtual;
    function GetMonth(const Row: Int64): Integer; virtual;
    function GetDay(const Row: Int64): Integer; virtual;
    function GetHour(const Row: Int64): Integer; virtual;
    function GetMinute(const Row: Int64): Integer; virtual;
    function GetSeconds(const Row: Int64): Integer; virtual;
    function GetMilliseconds(const Row: Int64): Integer; virtual;
    procedure SetValue(const Row: Int64; const Value: TDBXWritableValue); virtual; abstract;
  protected
    procedure SetDataGenerator(const DataGenerator: TDBXCustomDataGenerator); virtual;
    function GetColumnName: string; virtual;
    function GetDataType: Integer; virtual;
    function GetMetaDataColumn: TDBXMetaDataColumn; virtual;
  private
    function TypeNotSupported: TDBXDataGeneratorException;
  protected
    FMetaDataColumn: TDBXMetaDataColumn;
    FDataGenerator: TDBXCustomDataGenerator;
  public
    property DataGenerator: TDBXCustomDataGenerator write SetDataGenerator;
    property ColumnName: string read GetColumnName;
    property DataType: Integer read GetDataType;
    property MetaDataColumn: TDBXMetaDataColumn read GetMetaDataColumn;
  end;

  TDBXBooleanSequenceGenerator = class(TDBXDataGeneratorColumn)
  public
    constructor Create(const MetaData: TDBXMetaDataColumn);
    procedure Open; override;
    function GetBoolean(const Row: Int64): Boolean; override;
    function GetString(const Row: Int64): string; override;
    function GetInt8(const Row: Int64): Byte; override;
    procedure SetValue(const Row: Int64; const Value: TDBXWritableValue); override;
  end;

  TDBXBlobSequenceGenerator = class(TDBXDataGeneratorColumn)
  public
    constructor Create(const MetaData: TDBXMetaDataColumn);
    procedure Open; override;
    function GetString(const Row: Int64): string; override;
    function GetBytes(const Row: Int64): TArray<Byte>; override;
    procedure SetValue(const Row: Int64; const Value: TDBXWritableValue); override;
  end;

  TDBXAnsiStringSequenceGenerator = class(TDBXDataGeneratorColumn)
  public
    constructor Create(const MetaData: TDBXMetaDataColumn);
    procedure Open; override;
    function GetString(const Row: Int64): string; override;
    procedure SetValue(const Row: Int64; const Value: TDBXWritableValue); override;
  end;

  TDBXDataGeneratorException = class(Exception)
  public
    constructor Create(const Message: string);
  end;

  TDBXDateSequenceGenerator = class(TDBXDataGeneratorColumn)
  public
    constructor Create(const MetaData: TDBXMetaDataColumn);
    procedure Open; override;
    function GetYear(const Row: Int64): Integer; override;
    function GetMonth(const Row: Int64): Integer; override;
    function GetDay(const Row: Int64): Integer; override;
    function GetString(const Row: Int64): string; override;
    procedure SetValue(const Row: Int64; const Value: TDBXWritableValue); override;
  end;

  TDBXDecimalSequenceGenerator = class(TDBXDataGeneratorColumn)
  public
    constructor Create(const MetaData: TDBXMetaDataColumn);
    procedure Open; override;
    function GetDecimal(const Row: Int64): string; override;
    function GetString(const Row: Int64): string; override;
    procedure SetValue(const Row: Int64; const Value: TDBXWritableValue); override;
  end;

  TDBXDoubleSequenceGenerator = class(TDBXDataGeneratorColumn)
  public
    constructor Create(const MetaData: TDBXMetaDataColumn);
    procedure Open; override;
    function GetDouble(const Row: Int64): Double; override;
    function GetString(const Row: Int64): string; override;
    procedure SetValue(const Row: Int64; const Value: TDBXWritableValue); override;
  end;

  TDBXInt16SequenceGenerator = class(TDBXDataGeneratorColumn)
  public
    constructor Create(const MetaData: TDBXMetaDataColumn);
    procedure Open; override;
    function GetInt16(const Row: Int64): SmallInt; override;
    function GetString(const Row: Int64): string; override;
    procedure SetValue(const Row: Int64; const Value: TDBXWritableValue); override;
  end;

  TDBXInt32SequenceGenerator = class(TDBXDataGeneratorColumn)
  public
    constructor Create(const MetaData: TDBXMetaDataColumn);
    procedure Open; override;
    function GetInt32(const Row: Int64): Integer; override;
    function GetString(const Row: Int64): string; override;
    procedure SetValue(const Row: Int64; const Value: TDBXWritableValue); override;
  end;

  TDBXInt64SequenceGenerator = class(TDBXDataGeneratorColumn)
  public
    constructor Create(const MetaData: TDBXMetaDataColumn);
    procedure Open; override;
    function GetInt64(const Row: Int64): Int64; override;
    function GetString(const Row: Int64): string; override;
    procedure SetValue(const Row: Int64; const Value: TDBXWritableValue); override;
  end;

  TDBXInt8SequenceGenerator = class(TDBXDataGeneratorColumn)
  public
    constructor Create(const MetaData: TDBXMetaDataColumn);
    procedure Open; override;
    function GetInt8(const Row: Int64): Byte; override;
    function GetString(const Row: Int64): string; override;
    procedure SetValue(const Row: Int64; const Value: TDBXWritableValue); override;
  end;

  TDBXTimeSequenceGenerator = class(TDBXDataGeneratorColumn)
  public
    constructor Create(const MetaData: TDBXMetaDataColumn);
    procedure Open; override;
    function GetHour(const Row: Int64): Integer; override;
    function GetMinute(const Row: Int64): Integer; override;
    function GetSeconds(const Row: Int64): Integer; override;
    function GetString(const Row: Int64): string; override;
    procedure SetValue(const Row: Int64; const Value: TDBXWritableValue); override;
  end;

  TDBXTimestampSequenceGenerator = class(TDBXDataGeneratorColumn)
  public
    constructor Create(const MetaData: TDBXMetaDataColumn);
    procedure Open; override;
    function GetYear(const Row: Int64): Integer; override;
    function GetMonth(const Row: Int64): Integer; override;
    function GetDay(const Row: Int64): Integer; override;
    function GetHour(const Row: Int64): Integer; override;
    function GetMinute(const Row: Int64): Integer; override;
    function GetSeconds(const Row: Int64): Integer; override;
    function GetMilliseconds(const Row: Int64): Integer; override;
    function GetString(const Row: Int64): string; override;
    procedure SetValue(const Row: Int64; const Value: TDBXWritableValue); override;
  end;

  TDBXWideStringSequenceGenerator = class(TDBXDataGeneratorColumn)
  public
    constructor Create(const MetaData: TDBXMetaDataColumn);
    procedure Open; override;
    function GetString(const Row: Int64): string; override;
    procedure SetValue(const Row: Int64; const Value: TDBXWritableValue); override;
  end;

implementation

uses
  Data.DBXPlatform;

function TDBXCustomDataGenerator.GetColumnCount: Integer;
begin
  if FColumns = nil then
    Result := 0
  else 
    Result := Length(FColumns);
end;

procedure TDBXCustomDataGenerator.AddColumn(const Column: TDBXDataGeneratorColumn);
var
  Temp: TDBXDataGeneratorColumnArray;
  Index: Integer;
begin
  if FColumns = nil then
    SetLength(FColumns, 1)
  else
  begin
    SetLength(Temp, Length(FColumns) + 1);
    for Index := 0 to Length(FColumns) - 1 do
      Temp[Index] := FColumns[Index];
    FColumns := Temp;
  end;
  FColumns[Length(FColumns) - 1] := Column;
  Column.Open;
end;

destructor TDBXCustomDataGenerator.Destroy;
var
  Index: Integer;
begin
  if FColumns <> nil then
    for Index := 0 to Length(FColumns) - 1 do
      FreeAndNil(FColumns[Index]);
  FColumns := nil;
  inherited Destroy;
end;

function TDBXCustomDataGenerator.GetColumn(const Ordinal: Integer): TDBXDataGeneratorColumn;
begin
  Result := FColumns[Ordinal];
end;

procedure TDBXCustomDataGenerator.Open;
var
  Index: Integer;
begin
  FRow := 0;
  if FColumns <> nil then
    for Index := 0 to Length(FColumns) - 1 do
    begin
      FColumns[Index].DataGenerator := Self;
      FColumns[Index].Open;
    end;
end;

function TDBXCustomDataGenerator.ColumnNameString(const Columns: TDBXDataGeneratorColumnArray): string;
var
  ColumnNameString: string;
  Ordinal: Integer;
begin
  ColumnNameString := '';
  Ordinal := 0;
  while Ordinal < Length(Columns) do
  begin
    ColumnNameString := ColumnNameString + FMetaDataProvider.QuoteIdentifierIfNeeded(Columns[Ordinal].ColumnName);
    Inc(Ordinal);
    if Ordinal < Length(Columns) then
      ColumnNameString := ColumnNameString + ',';
  end;
  Result := ColumnNameString;
end;

function TDBXCustomDataGenerator.ValueString(const Columns: TDBXDataGeneratorColumnArray; const Row: Integer): string;
var
  ColumnName, ValueString: string;
  Ordinal: Integer;
begin
  ValueString := '';
  Ordinal := 0;
  while Ordinal < Length(Columns) do
  begin
    ColumnName := Columns[Ordinal].GetString(Row);
    if ColumnName.IsEmpty or (ColumnName.Length < 1) then
      raise TDBXDataGeneratorException.Create('ColumnName property not set or set to an empty string for ordinal:  ' + IntToStr(Ordinal));
    ValueString := ValueString + Columns[Ordinal].GetString(Row);
    Inc(Ordinal);
    if Ordinal < Length(Columns) then
      ValueString := ValueString + ',';
  end;
  Result := ValueString;
end;

function TDBXCustomDataGenerator.MarkerString: string;
var
  MarkerString: string;
  Ordinal: Integer;
begin
  MarkerString := '';
  Ordinal := 0;
  while Ordinal < Length(FColumns) do
  begin
    Inc(Ordinal);
    if Ordinal < Length(FColumns) then
      MarkerString := MarkerString + '?,'
    else 
      MarkerString := MarkerString + '?';
  end;
  Result := MarkerString;
end;

function TDBXCustomDataGenerator.GetTableName: string;
begin
  Result := FTableName;
end;

procedure TDBXCustomDataGenerator.SetTableName(const TableName: string);
begin
  self.FTableName := TableName;
end;

function TDBXCustomDataGenerator.CreateInsertStatement(const InsertColumns: TDBXDataGeneratorColumnArray; const Row: Integer; const Prepare: Boolean): string;
var
  InsertStatement: string;
begin
  if (FTableName.IsEmpty) or (FTableName.Length < 1) then
    raise TDBXDataGeneratorException.Create('TableName property not set or set to an empty string');
  if FMetaDataProvider = nil then
    raise TDBXDataGeneratorException.Create('MetaDataProvider property not set');
  InsertStatement := 'INSERT INTO ' + FMetaDataProvider.QuoteIdentifierIfNeeded(FTableName) + ' (' + ColumnNameString(InsertColumns) + ') VALUES (';
  if Prepare then
    InsertStatement := InsertStatement + MarkerString
  else 
    InsertStatement := InsertStatement + ValueString(FColumns, Row);
  Result := InsertStatement + ')';
end;

function TDBXCustomDataGenerator.CreateInsertStatement(const Row: Integer): string;
begin
  Result := CreateInsertStatement(FColumns, Row, False);
end;

function TDBXCustomDataGenerator.CreateInsertStatement(const InsertColumns: TDBXDataGeneratorColumnArray; const Row: Integer): string;
begin
  Result := CreateInsertStatement(InsertColumns, Row, False);
end;

function TDBXCustomDataGenerator.CreateParameterizedInsertStatement: string;
begin
  Result := CreateInsertStatement(FColumns, -1, True);
end;

function TDBXCustomDataGenerator.CreateParameterizedInsertStatement(const InsertColumns: TDBXDataGeneratorColumnArray): string;
begin
  Result := CreateInsertStatement(InsertColumns, -1, True);
end;

procedure TDBXCustomDataGenerator.Next;
begin
  Inc(FRow);
end;

function TDBXCustomDataGenerator.GetMetaDataProvider: TDBXMetaDataProvider;
begin
  Result := FMetaDataProvider;
end;

procedure TDBXCustomDataGenerator.SetMetaDataProvider(const MetaDataProvider: TDBXMetaDataProvider);
begin
  self.FMetaDataProvider := MetaDataProvider;
end;

constructor TDBXDataGeneratedReader.Create(const ARowCount: Int64; const AGeneratorColumns: TDBXDataGeneratorColumnArray);
begin
  inherited Create(nil, TDBXDataGeneratedRow.Create(nil), nil);
  FPosition := -1;
  FGeneratorColumns := AGeneratorColumns;
  FRowCount := ARowCount;
  CreateValues;
end;

destructor TDBXDataGeneratedReader.Destroy;
begin
  FreeAndNil(FGeneratorColumns);
  inherited Destroy;
end;

procedure TDBXDataGeneratedReader.CreateValues;
var
  Column: TDBXDataGeneratorColumn;
  ValueType: TDBXValueType;
  Values: TDBXWritableValueArray;
  MetaDataColumn: TDBXMetaDataColumn;
  Index: Integer;
begin
  SetLength(Values,Length(FGeneratorColumns));
  for Index := 0 to Length(FGeneratorColumns) - 1 do
  begin
    Column := FGeneratorColumns[Index];
    MetaDataColumn := Column.MetaDataColumn;
    ValueType := TDBXValueType.Create;
    ValueType.DataType := MetaDataColumn.DataType;
    ValueType.Precision := MetaDataColumn.Precision;
    ValueType.Scale := MetaDataColumn.Scale;
    ValueType.Name := MetaDataColumn.ColumnName;
    Values[Index] := TDBXWritableValue(TDBXValue.CreateValue(ValueType));
  end;
  SetValues(Values);
end;

function TDBXDataGeneratedReader.Reset: Boolean;
begin
  FPosition := -1;
  Result := True;
end;

procedure TDBXDataGeneratedReader.GenerateValues;
var
  Index: Integer;
begin
  for Index := 0 to Length(FGeneratorColumns) - 1 do
    FGeneratorColumns[Index].SetValue(FPosition, TDBXWritableValue(Value[Index]));
end;

function TDBXDataGeneratedReader.DerivedNext: Boolean;
begin
  Inc(FPosition);
  if FPosition < FRowCount then
  begin
    GenerateValues;
    Exit(True);
  end;
  Dec(FPosition);
  Result := False;
end;

function TDBXDataGeneratedReader.GetByteReader: TDBXByteReader;
begin
  Result := nil;
end;

function TDBXDataGeneratedReader.GetPosition: Int64;
begin
  Result := FPosition;
end;

function TDBXDataGeneratedReader.CompareReader(const Reader: TDBXReader): Boolean;
var
  Index: Integer;
begin
  Reset;
  Reader.Reset;
  FLastOrdinalCompared := -1;
  if Reader.ColumnCount <> ColumnCount then
    Exit(False);
  while Next do
  begin
    if not Reader.Next then
      Exit(False);
    for Index := 0 to Reader.ColumnCount - 1 do
    begin
      if not Reader.Value[Index].EqualsValue(self.Value[Index]) then
      begin
        FLastOrdinalCompared := Index;
        Exit(False);
      end;
    end;
  end;
  FLastOrdinalCompared := -1;
  if Reader.Next then
    Exit(False);
  Result := True;
end;

procedure TDBXDataGeneratedReader.DerivedClose;
begin
end;

constructor TDBXDataGeneratedRow.Create(const Context: TDBXContext);
begin
  inherited Create(Context);
end;

procedure TDBXDataGeneratorColumn.SetDataGenerator(const DataGenerator: TDBXCustomDataGenerator);
begin
  self.FDataGenerator := DataGenerator;
end;

constructor TDBXDataGeneratorColumn.Create(const InMetaDataColumn: TDBXMetaDataColumn);
begin
  inherited Create;
  FMetaDataColumn := TDBXMetaDataColumn.Create(InMetaDataColumn);
end;

function TDBXDataGeneratorColumn.TypeNotSupported: TDBXDataGeneratorException;
begin
  Result := TDBXDataGeneratorException.Create('Type not supported by this implementation of DataGenerationColumn');
end;

procedure TDBXDataGeneratorColumn.Open;
begin
end;

destructor TDBXDataGeneratorColumn.Destroy;
begin
  FreeAndNil(FMetaDataColumn);
  inherited Destroy;
end;

function TDBXDataGeneratorColumn.GetBoolean(const Row: Int64): Boolean;
begin
  raise TypeNotSupported;
end;

function TDBXDataGeneratorColumn.GetInt8(const Row: Int64): Byte;
begin
  raise TypeNotSupported;
end;

function TDBXDataGeneratorColumn.GetInt16(const Row: Int64): SmallInt;
begin
  raise TypeNotSupported;
end;

function TDBXDataGeneratorColumn.GetInt32(const Row: Int64): Integer;
begin
  raise TypeNotSupported;
end;

function TDBXDataGeneratorColumn.GetInt64(const Row: Int64): Int64;
begin
  raise TypeNotSupported;
end;

function TDBXDataGeneratorColumn.GetDouble(const Row: Int64): Double;
begin
  raise TypeNotSupported;
end;

function TDBXDataGeneratorColumn.GetSingle(const Row: Int64): Single;
begin
  raise TypeNotSupported;
end;

function TDBXDataGeneratorColumn.GetBytes(const Row: Int64): TArray<Byte>;
begin
  raise TypeNotSupported;
end;

function TDBXDataGeneratorColumn.GetDecimal(const Row: Int64): string;
begin
  raise TypeNotSupported;
end;

function TDBXDataGeneratorColumn.GetYear(const Row: Int64): Integer;
begin
  raise TypeNotSupported;
end;

function TDBXDataGeneratorColumn.GetMonth(const Row: Int64): Integer;
begin
  raise TypeNotSupported;
end;

function TDBXDataGeneratorColumn.GetDay(const Row: Int64): Integer;
begin
  raise TypeNotSupported;
end;

function TDBXDataGeneratorColumn.GetHour(const Row: Int64): Integer;
begin
  raise TypeNotSupported;
end;

function TDBXDataGeneratorColumn.GetMinute(const Row: Int64): Integer;
begin
  raise TypeNotSupported;
end;

function TDBXDataGeneratorColumn.GetSeconds(const Row: Int64): Integer;
begin
  raise TypeNotSupported;
end;

function TDBXDataGeneratorColumn.GetMilliseconds(const Row: Int64): Integer;
begin
  raise TypeNotSupported;
end;

function TDBXDataGeneratorColumn.GetColumnName: string;
begin
  Result := FMetaDataColumn.ColumnName;
end;

function TDBXDataGeneratorColumn.GetDataType: Integer;
begin
  Result := FMetaDataColumn.DataType;
end;

function TDBXDataGeneratorColumn.GetMetaDataColumn: TDBXMetaDataColumn;
begin
  Result := FMetaDataColumn;
end;

constructor TDBXBooleanSequenceGenerator.Create(const MetaData: TDBXMetaDataColumn);
begin
  inherited Create(MetaData);
end;

procedure TDBXBooleanSequenceGenerator.Open;
begin
  inherited Open;
end;

function TDBXBooleanSequenceGenerator.GetBoolean(const Row: Int64): Boolean;
begin
  Result := (Row and 1) = 1;
end;

function TDBXBooleanSequenceGenerator.GetString(const Row: Int64): string;
begin
  if GetBoolean(Row) then
    Result := 'true'
  else 
    Result := 'false';
end;

function TDBXBooleanSequenceGenerator.GetInt8(const Row: Int64): Byte;
begin
  Result := Byte((Row and 1));
end;

procedure TDBXBooleanSequenceGenerator.SetValue(const Row: Int64; const Value: TDBXWritableValue);
begin
  Value.SetBoolean(GetBoolean(Row));
end;

constructor TDBXBlobSequenceGenerator.Create(const MetaData: TDBXMetaDataColumn);
begin
  inherited Create(MetaData);
end;

procedure TDBXBlobSequenceGenerator.Open;
begin
  inherited Open;
end;

function TDBXBlobSequenceGenerator.GetString(const Row: Int64): string;
var
  Count: Integer;
  Buffer: TStringBuilder;
  StringValue: string;
  Value: Integer;
  Index: Integer;
begin
  Count := FMetaDataColumn.Precision;
  Buffer := TStringBuilder.Create(Count);
  Value := Integer(Row);
  for Index := 0 to Count - 1 do
  begin
    Buffer.Append(WideChar((32 + Value mod 96)));
    Inc(Value);
  end;
  StringValue := Buffer.ToString;
  Buffer.Free;
  Result := StringValue;
end;

function TDBXBlobSequenceGenerator.GetBytes(const Row: Int64): TArray<Byte>;
var
  Count, Index, Value: Integer;
  Buffer: TArray<Byte>;
begin
  Count := FMetaDataColumn.Precision;
  SetLength(Buffer, Count);
  Value := Integer(Row);
  for Index := 0 to Count - 1 do
  begin
    Buffer[Index] := Byte(Value);
    Inc(Value);
  end;
  Result := Buffer;
end;

procedure TDBXBlobSequenceGenerator.SetValue(const Row: Int64; const Value: TDBXWritableValue);
var
  Bytes: TArray<Byte>;
begin
  Bytes := GetBytes(Row);
  Value.SetDynamicBytes(0, Bytes, 0, Length(Bytes));
end;

constructor TDBXAnsiStringSequenceGenerator.Create(const MetaData: TDBXMetaDataColumn);
begin
  inherited Create(MetaData);
end;

procedure TDBXAnsiStringSequenceGenerator.Open;
begin
  inherited Open;
end;

function TDBXAnsiStringSequenceGenerator.GetString(const Row: Int64): string;
var
  Value: string;
begin
  Value := 'A' + IntToStr(Row);
  if FMetaDataColumn.FixedLength then
    while Value.Length < FMetaDataColumn.Precision do
      Value := Value + ' ';
  Result := Value;
end;

procedure TDBXAnsiStringSequenceGenerator.SetValue(const Row: Int64; const Value: TDBXWritableValue);
begin
  Value.SetWideString(GetString(Row));
end;

constructor TDBXDataGeneratorException.Create(const Message: string);
begin
  inherited Create(Message);
end;

constructor TDBXDateSequenceGenerator.Create(const MetaData: TDBXMetaDataColumn);
begin
  inherited Create(MetaData);
end;

procedure TDBXDateSequenceGenerator.Open;
begin
  inherited Open;
end;

function TDBXDateSequenceGenerator.GetYear(const Row: Int64): Integer;
begin
  Result := 1970 + Integer(Row) mod 20;
end;

function TDBXDateSequenceGenerator.GetMonth(const Row: Int64): Integer;
begin
  Result := (Integer(Row) mod 12) + 1;
end;

function TDBXDateSequenceGenerator.GetDay(const Row: Int64): Integer;
begin
  Result := (Integer(Row) mod 28) + 1;
end;

function TDBXDateSequenceGenerator.GetString(const Row: Int64): string;
begin
  Result := '' + IntToStr(GetMonth(Row)) + '/' + IntToStr(GetDay(Row)) + '/' + IntToStr(GetYear(Row));
end;

procedure TDBXDateSequenceGenerator.SetValue(const Row: Int64; const Value: TDBXWritableValue);
begin
  Value.SetWideString(GetString(Row));
end;

constructor TDBXDecimalSequenceGenerator.Create(const MetaData: TDBXMetaDataColumn);
begin
  inherited Create(MetaData);
end;

procedure TDBXDecimalSequenceGenerator.Open;
begin
  inherited Open;
end;

function TDBXDecimalSequenceGenerator.GetDecimal(const Row: Int64): string;
begin
  Result := GetString(Row);
end;

function TDBXDecimalSequenceGenerator.GetString(const Row: Int64): string;
begin
  Result := '' + IntToStr((Row));
end;

procedure TDBXDecimalSequenceGenerator.SetValue(const Row: Int64; const Value: TDBXWritableValue);
begin
  Value.AsString := GetString(Row);
end;

constructor TDBXDoubleSequenceGenerator.Create(const MetaData: TDBXMetaDataColumn);
begin
  inherited Create(MetaData);
end;

procedure TDBXDoubleSequenceGenerator.Open;
begin
  inherited Open;
end;

function TDBXDoubleSequenceGenerator.GetDouble(const Row: Int64): Double;
begin
  Result := Row;
end;

function TDBXDoubleSequenceGenerator.GetString(const Row: Int64): string;
var
  DoubleRow: Double;
begin
  DoubleRow := Row;
  Result := '' + FloatToStr(DoubleRow);
end;

procedure TDBXDoubleSequenceGenerator.SetValue(const Row: Int64; const Value: TDBXWritableValue);
begin
  Value.SetDouble(GetDouble(Row));
end;

constructor TDBXInt16SequenceGenerator.Create(const MetaData: TDBXMetaDataColumn);
begin
  inherited Create(MetaData);
end;

procedure TDBXInt16SequenceGenerator.Open;
begin
  inherited Open;
end;

function TDBXInt16SequenceGenerator.GetInt16(const Row: Int64): SmallInt;
begin
  Result := SmallInt(Row);
end;

function TDBXInt16SequenceGenerator.GetString(const Row: Int64): string;
var
  ShortRow: Integer;
begin
  ShortRow := SmallInt(Row);
  Result := '' + IntToStr(ShortRow);
end;

procedure TDBXInt16SequenceGenerator.SetValue(const Row: Int64; const Value: TDBXWritableValue);
begin
  Value.SetInt16(GetInt16(Row));
end;

constructor TDBXInt32SequenceGenerator.Create(const MetaData: TDBXMetaDataColumn);
begin
  inherited Create(MetaData);
end;

procedure TDBXInt32SequenceGenerator.Open;
begin
  inherited Open;
end;

function TDBXInt32SequenceGenerator.GetInt32(const Row: Int64): Integer;
begin
  Result := Integer(Row);
end;

function TDBXInt32SequenceGenerator.GetString(const Row: Int64): string;
var
  IntRow: Integer;
begin
  IntRow := Integer(Row);
  Result := '' + IntToStr(IntRow);
end;

procedure TDBXInt32SequenceGenerator.SetValue(const Row: Int64; const Value: TDBXWritableValue);
begin
  Value.AsInt32 := GetInt32(Row);
end;

constructor TDBXInt64SequenceGenerator.Create(const MetaData: TDBXMetaDataColumn);
begin
  inherited Create(MetaData);
end;

procedure TDBXInt64SequenceGenerator.Open;
begin
  inherited Open;
end;

function TDBXInt64SequenceGenerator.GetInt64(const Row: Int64): Int64;
begin
  Result := Row;
end;

function TDBXInt64SequenceGenerator.GetString(const Row: Int64): string;
begin
  Result := '' + IntToStr((Row));
end;

procedure TDBXInt64SequenceGenerator.SetValue(const Row: Int64; const Value: TDBXWritableValue);
begin
  Value.SetInt64(GetInt64(Row));
end;

constructor TDBXInt8SequenceGenerator.Create(const MetaData: TDBXMetaDataColumn);
begin
  inherited Create(MetaData);
end;

procedure TDBXInt8SequenceGenerator.Open;
begin
  inherited Open;
end;

function TDBXInt8SequenceGenerator.GetInt8(const Row: Int64): Byte;
begin
  Result := Byte(Row);
end;

function TDBXInt8SequenceGenerator.GetString(const Row: Int64): string;
var
  ByteRow: Integer;
begin
  ByteRow := Integer((Row and 255));
  Result := '' + IntToStr(ByteRow);
end;

procedure TDBXInt8SequenceGenerator.SetValue(const Row: Int64; const Value: TDBXWritableValue);
begin
  Value.SetInt16(GetInt8(Row));
end;

constructor TDBXTimeSequenceGenerator.Create(const MetaData: TDBXMetaDataColumn);
begin
  inherited Create(MetaData);
end;

procedure TDBXTimeSequenceGenerator.Open;
begin
  inherited Open;
end;

function TDBXTimeSequenceGenerator.GetHour(const Row: Int64): Integer;
begin
  Result := Integer(Row) mod 24;
end;

function TDBXTimeSequenceGenerator.GetMinute(const Row: Int64): Integer;
begin
  Result := Integer(Row) mod 60;
end;

function TDBXTimeSequenceGenerator.GetSeconds(const Row: Int64): Integer;
begin
  Result := Integer(Row) mod 60;
end;

function TDBXTimeSequenceGenerator.GetString(const Row: Int64): string;
begin
  Result := '' + IntToStr(GetHour(Row)) + ':' + IntToStr(GetMinute(Row)) + ':' + IntToStr(GetSeconds(Row));
end;

procedure TDBXTimeSequenceGenerator.SetValue(const Row: Int64; const Value: TDBXWritableValue);
begin
  Value.AsString := GetString(Row);
end;

constructor TDBXTimestampSequenceGenerator.Create(const MetaData: TDBXMetaDataColumn);
begin
  inherited Create(MetaData);
end;

procedure TDBXTimestampSequenceGenerator.Open;
begin
  inherited Open;
end;

function TDBXTimestampSequenceGenerator.GetYear(const Row: Int64): Integer;
begin
  Result := 1970 + Integer(Row) mod 20;
end;

function TDBXTimestampSequenceGenerator.GetMonth(const Row: Int64): Integer;
begin
  Result := (Integer(Row) mod 12) + 1;
end;

function TDBXTimestampSequenceGenerator.GetDay(const Row: Int64): Integer;
begin
  Result := (Integer(Row) mod 28) + 1;
end;

function TDBXTimestampSequenceGenerator.GetHour(const Row: Int64): Integer;
begin
  Result := Integer(Row) mod 24;
end;

function TDBXTimestampSequenceGenerator.GetMinute(const Row: Int64): Integer;
begin
  Result := Integer(Row) mod 60;
end;

function TDBXTimestampSequenceGenerator.GetSeconds(const Row: Int64): Integer;
begin
  Result := Integer(Row) mod 60;
end;

function TDBXTimestampSequenceGenerator.GetMilliseconds(const Row: Int64): Integer;
begin
  Result := Integer(Row) mod 1000;
end;

function TDBXTimestampSequenceGenerator.GetString(const Row: Int64): string;
begin
  Result := '' + IntToStr(GetMonth(Row)) + '/' + IntToStr(GetDay(Row)) + '/' + IntToStr(GetYear(Row)) + IntToStr(GetHour(Row)) + ':' + IntToStr(GetMinute(Row)) + ':' + IntToStr(GetSeconds(Row)) + '.' + IntToStr(GetMilliseconds(Row));
end;

procedure TDBXTimestampSequenceGenerator.SetValue(const Row: Int64; const Value: TDBXWritableValue);
begin
  Value.AsString := GetString(Row);
end;

constructor TDBXWideStringSequenceGenerator.Create(const MetaData: TDBXMetaDataColumn);
begin
  inherited Create(MetaData);
end;

procedure TDBXWideStringSequenceGenerator.Open;
begin
  inherited Open;
end;

function TDBXWideStringSequenceGenerator.GetString(const Row: Int64): string;
var
  Value: string;
begin
  Value := 'W' + IntToStr(Row);
  if FMetaDataColumn.FixedLength then
    while Value.Length < FMetaDataColumn.Precision do
      Value := Value + ' ';
  Result := Value;
end;

procedure TDBXWideStringSequenceGenerator.SetValue(const Row: Int64; const Value: TDBXWritableValue);
begin
  Value.AsString := GetString(Row);
end;

end.
