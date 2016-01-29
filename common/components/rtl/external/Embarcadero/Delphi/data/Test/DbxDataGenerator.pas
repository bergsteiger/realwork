{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit DbxDataGenerator;

interface

uses
  Data.SQLExpr,
  Data.DB,
  Data.DBXCommon,
  DbxCustomDataGenerator,
  Data.FMTBcd,
  System.SysUtils,
  Data.SqlTimSt;

{$HPPEMIT '#ifdef USEPACKAGES'}
{$HPPEMIT '#pragma link "dbtest.bpi"'}
{$HPPEMIT '#pragma link "dbexpress.bpi"'}
{$HPPEMIT '#pragma link "DbxCommonDriver.bpi"'}
{$HPPEMIT '#pragma link "dsnap.bpi"'}
{$HPPEMIT '#pragma link "dbrtl.bpi"'}
{$HPPEMIT '#else'}
{$IFDEF WIN64}
  {$HPPEMIT '#pragma link "dbtest.a"'}
  {$HPPEMIT '#pragma link "dbexpress.a"'}
  {$HPPEMIT '#pragma link "DbxCommonDriver.a"'}
  {$HPPEMIT '#pragma link "dsnap.a"'}
  {$HPPEMIT '#pragma link "dbrtl.a"'}
{$ELSE}
  {$HPPEMIT '#pragma link "dbtest.lib"'}
  {$HPPEMIT '#pragma link "dbexpress.lib"'}
  {$HPPEMIT '#pragma link "DbxCommonDriver.lib"'}
  {$HPPEMIT '#pragma link "dsnap.lib"'}
  {$HPPEMIT '#pragma link "dbrtl.lib"'}
{$ENDIF}
{$HPPEMIT '#endif'}

type
  TDbxDataGenerator = class(TDBXCustomDataGenerator)
  private
    FParam: TParam;
    //Remove once all drivers support Fractions (milliseconds) for timestamp (255605, 255767, 255768, 255769)
    function GetIsFractionsSupported: Boolean;
    procedure SetParameter(Ordinal: Integer; Row: Integer; Param: TParam);
    procedure ValidateParam(Ordinal: Integer; Row: Integer; Param: TParam);
  public
    constructor Create;
    destructor Destroy; override;
    class procedure ValidateAnsiString(Value1, Value2: string); static;
    class procedure ValidateWideString(Value1, Value2: string); static;
    class procedure ValidateBoolean(Value1, Value2: Boolean); static;
    class procedure ValidateInt64(Value1, Value2: Int64); static;
    class procedure ValidateSingle(Value1, Value2: Single); static;
    class procedure ValidateDouble(Value1, Value2: Double); static;
    class procedure ValidateBcd(Value1, Value2: TBcd); static;
    class procedure ValidateDate(Value1, Value2: TDBXDate); static;
    class procedure ValidateTime(Value1, Value2: TDBXTime); static;
    class procedure ValidateTimestamp(Value1, Value2: TSQLTimeStamp); static;
    class procedure ValidateTimestampOffset(Value1, Value2: TSQLTimeStampOffset); static;
    class procedure ValidateDateTime(Value1, Value2: TDateTime); static;
    class procedure ValidateBytes(Value1, Value2: TArray<Byte>); static;
    class function BytesEquals(const Value1: TArray<Byte>; const Value2: TArray<Byte>; Count: Integer): Boolean; static;
    class procedure ReadBytesFromStream(Value: TDBXValue; var Buffer: TArray<Byte>);

    function ValidateRow(const Reader: TDBXReader; Row: Integer): Boolean; overload;
    function ValidateRow(const DataSet: TDataSet; Row: Integer): Boolean; overload;
    procedure ValidateParameters(const Command: TDBXCommand; Row: Integer);
    procedure ValidateParams(const Params: TParams);
    procedure AddParameters(const Command: TDBXCommand); overload;
    procedure AddParameters(const SQLQuery: TSQLQuery); overload;
    procedure SetInsertParameters(const Command: TDBXCommand; Row: Integer); overload;
    procedure SetInsertParameters(const SQLQuery: TSQLQuery; Row: Integer); overload;
    procedure PopulateParams(Params: TParams);
    procedure PopulateDataset(DataSet: TDataSet; RowCount: Integer);
    //Remove once all drivers support Fractions (milliseconds) for timestamp (255605, 255767, 255768, 255769)
    property IsFractionsSupported: Boolean read GetIsFractionsSupported;
  end;

implementation

uses
  System.Classes,
  Data.DBXMetaDataProvider,
  Data.DBXPlatform;

{ TDbxDataGenerator }

procedure TDbxDataGenerator.AddParameters(const Command: TDBXCommand);
var
  ColumnCount: Integer;
  Ordinal: Integer;
  Column: TDBXMetadataColumn;
  Parameter: TDBXParameter;
begin
  ColumnCount := GetColumnCount;
  for Ordinal := 0 to ColumnCount - 1 do
  begin
    Column := GetColumn(Ordinal).MetaDataColumn;
    Parameter := Command.CreateParameter;
    case Column.DataType of
      TDBXDataTypes.BlobType:
      begin
        Parameter.DataType := Column.DataType;
        if Column.UnicodeString then
          Parameter.SubType := TDBXDataTypes.WideMemoSubType
        else if Column.Long then
          Parameter.SubType := TDBXDataTypes.BinarySubType
        else
          Parameter.SubType := TDBXDataTypes.MemoSubType;
      end;
      TDBXDataTypes.SingleType:
        begin
          Parameter.DataType := TDBXDataTypes.SingleType;
        end;
      TDBXDataTypes.Int8Type:
        begin
          Parameter.DataType := TDBXDataTypes.Int8Type;
        end;
      TDBXDataTypes.Uint8Type:
        begin
          Parameter.DataType := TDBXDataTypes.UInt8Type;
        end;
      TDBXDataTypes.CharArrayType:
        begin
          Parameter.DataType := TDBXDataTypes.BlobType;
          Parameter.SubType  := TDBXDataTypes.MemoSubType;
        end;
      TDBXDataTypes.ObjectType,
      TDBXDataTypes.IntervalType:
        begin
          Assert(false, 'Unsupported Type');
        end;
      TDBXDataTypes.AnsiStringType:
        begin
          if Column.Long then
          begin
            Parameter.DataType := TDBXDataTypes.BlobType;
            Parameter.SubType := TDBXDataTypes.MemoSubType;
          end
          else
            Parameter.DataType := Column.DataType;
          if Column.FixedLength then
            Parameter.SubType := TDBXSubDataTypes.FixedSubType;
        end;
      TDBXDataTypes.WideStringType:
        begin
          if Column.Long then
          begin
            Parameter.DataType := TDBXDataTypes.BlobType;
            Parameter.SubType := TDBXDataTypes.WideMemoSubType;
          end
          else
            Parameter.DataType := Column.DataType;
          if Column.FixedLength then
            Parameter.SubType := TDBXSubDataTypes.FixedSubType;
        end;
      else
        Parameter.DataType := Column.DataType;
    end;
    Parameter.Precision := Column.Precision;
    Parameter.Size := Parameter.Precision;
    Parameter.Scale := Column.Scale;
    Parameter.Name := Column.ColumnName;
    Command.Parameters.AddParameter(Parameter);
  end;
end;

procedure TDbxDataGenerator.AddParameters(const SQLQuery: TSQLQuery);
var
  ColumnCount: Integer;
  Ordinal: Integer;
  Column: TDBXMetadataColumn;
  Param: TParam;
begin
  ColumnCount := GetColumnCount;
  for Ordinal := 0 to ColumnCount - 1 do
  begin
    Column := GetColumn(Ordinal).MetaDataColumn;
    case Column.Datatype of
      TDBXDataTypes.AnsiStringType: if Column.Long and Assigned(MetaDataProvider) and not (MetaDataProvider.DatabaseProduct = 'BlackfishSQL') then
                                      Param := SQLQuery.Params.CreateParam(ftMemo, IntToStr(Ordinal), ptInput)
                                    else
                                      Param := SQLQuery.Params.CreateParam(ftString, IntToStr(Ordinal), ptInput);
      TDBXDataTypes.BooleanType: Param := SQLQuery.Params.CreateParam(ftBoolean, IntToStr(Ordinal), ptInput);
      TDBXDataTypes.WideStringType: if Column.Long and Assigned(MetaDataProvider) and not (MetaDataProvider.DatabaseProduct = 'BlackfishSQL') then
                                      Param := SQLQuery.Params.CreateParam(ftWideMemo, IntToStr(Ordinal), ptInput)
                                    else
                                      Param := SQLQuery.Params.CreateParam(ftWideString, IntToStr(Ordinal), ptInput);
      TDBXDataTypes.UInt8Type: Param := SQLQuery.Params.CreateParam(ftByte, IntToStr(Ordinal), ptInput);
      TDBXDataTypes.Int8Type: Param := SQLQuery.Params.CreateParam(ftShortint, IntToStr(Ordinal), ptInput);
      TDBXDataTypes.UInt16Type: Param := SQLQuery.Params.CreateParam(ftWord, IntToStr(Ordinal), ptInput);
      TDBXDataTypes.Int16Type: Param := SQLQuery.Params.CreateParam(ftSmallint, IntToStr(Ordinal), ptInput);
      TDBXDataTypes.Int32Type: Param := SQLQuery.Params.CreateParam(ftInteger, IntToStr(Ordinal), ptInput);
      TDBXDataTypes.Int64Type: Param := SQLQuery.Params.CreateParam(ftLargeint, IntToStr(Ordinal), ptInput);
      TDBXDataTypes.SingleType: Param := SQLQuery.Params.CreateParam(ftSingle, IntToStr(Ordinal), ptInput);
      TDBXDataTypes.DoubleType: Param := SQLQuery.Params.CreateParam(ftFloat, IntToStr(Ordinal), ptInput);
      TDBXDataTypes.BcdType: Param := SQLQuery.Params.CreateParam(ftBCD, IntToStr(Ordinal), ptInput);
      TDBXDataTypes.DateType: Param := SQLQuery.Params.CreateParam(ftDate, IntToStr(Ordinal), ptInput);
      TDBXDataTypes.TimeType: Param := SQLQuery.Params.CreateParam(ftTime, IntToStr(Ordinal), ptInput);
      TDBXDataTypes.TimeStampType: Param := SQLQuery.Params.CreateParam(ftTimeStamp, IntToStr(Ordinal), ptInput);
      TDBXDataTypes.TimeStampOffsetType: Param := SQLQuery.Params.CreateParam(ftTimeStampOffset, IntToStr(Ordinal), ptInput);
      TDBXDataTypes.BlobType: Param := SQLQuery.Params.CreateParam(ftBlob, IntToStr(Ordinal), ptInput);
      TDBXDataTypes.VarBytesType: Param := SQLQuery.Params.CreateParam(ftVarBytes, IntToStr(Ordinal), ptInput);
      TDBXDataTypes.BytesType: Param := SQLQuery.Params.CreateParam(ftBytes, IntToStr(Ordinal), ptInput)
      else
        raise TDBXDataGeneratorException.Create('Parameter could not be created for ' + IntToStr(Column.DataType));
    end;
    SQLQuery.Params.AddParam(Param);
    SQLQuery.Params[Ordinal].Precision := Column.Precision;
    SQLQuery.Params[Ordinal].NumericScale := Column.Scale;
    SQLQuery.Params[Ordinal].Name := Column.ColumnName;
  end;
end;

procedure TDbxDataGenerator.SetInsertParameters(const Command: TDBXCommand;
  Row: Integer);
var
  ColumnCount, Ordinal: Integer;
  Column: TDBXDataGeneratorColumn;
  DbxValue: TDBXWritableValue;
  DateTime: TDateTime;
  TimeStamp: TTimeStamp;
  SqlTimeStamp: TSQLTimeStamp;
  SqlTimeStampOffset: TSQLTimeStampOffset;
  Buffer: TArray<Byte>;
begin
  ColumnCount := GetColumnCount;
  for Ordinal := 0 to ColumnCount - 1 do
  begin
    Column := GetColumn(Ordinal);
    DbxValue := Command.Parameters[Ordinal].Value;
    case Column.Datatype of
      TDBXDataTypes.AnsiStringType: DbxValue.AsString := Column.GetString(Row);
      TDBXDataTypes.BooleanType: DbxValue.SetBoolean(Column.GetBoolean(Row));
      TDBXDataTypes.WideStringType: DbxValue.SetWideString(Column.GetString(Row));
      TDBXDataTypes.UInt8Type: DBXValue.SetUInt8(Column.GetInt8(Row));
      TDBXDataTypes.Int8Type: DBXValue.SetInt8(Column.GetInt8(Row));
      TDBXDataTypes.UInt16Type: DbxValue.SetUInt16(Column.GetInt16(Row));
      TDBXDataTypes.Int16Type: DbxValue.SetInt16(Column.GetInt16(Row));
      TDBXDataTypes.Int32Type: DbxValue.SetInt32(Column.GetInt32(Row));
      TDBXDataTypes.Int64Type: DbxValue.SetInt64(Column.GetInt64(Row));
      TDBXDataTypes.SingleType: DbxValue.SetSingle(Column.GetSingle(Row));
      TDBXDataTypes.DoubleType: DbxValue.SetDouble(Column.GetDouble(Row));
      TDBXDataTypes.BcdType: DbxValue.SetBcd(StrToBcd(Column.GetDecimal(Row)));
      TDBXDataTypes.DateType:
        begin
          DateTime := EncodeDate(Column.GetYear(Row), Column.GetMonth(Row), Column.GetDay(Row));
          TimeStamp := DateTimeToTimeStamp(DateTime);
          DbxValue.SetDate(TimeStamp.Date);
        end;
      TDBXDataTypes.TimeType:
        begin
          DateTime := EncodeTime(Column.GetHour(Row), Column.GetMinute(Row), Column.GetSeconds(Row), 0);
          TimeStamp := DateTimeToTimeStamp(DateTime);
          DbxValue.SetTime(TimeStamp.Time);
        end;
      TDBXDataTypes.TimeStampType:
        begin
          SqlTimeStamp.Year       := Column.GetYear(Row);
          SqlTimeStamp.Month      := Column.GetMonth(Row);
          SqlTimeStamp.Day        := Column.GetDay(Row);
          SqlTimeStamp.Hour       := Column.GetHour(Row);
          SqlTimeStamp.Minute     := Column.GetMinute(Row);
          SqlTimeStamp.Second     := Column.GetSeconds(Row);
          SqlTimeStamp.Fractions  := Column.GetMilliseconds(Row);
          DbxValue.SetTimeStamp(SqlTimeStamp);
        end;
      TDBXDataTypes.TimeStampOffsetType:
        begin
          SqlTimeStampOffset.Year       := Column.GetYear(Row);
          SqlTimeStampOffset.Month      := Column.GetMonth(Row);
          SqlTimeStampOffset.Day        := Column.GetDay(Row);
          SqlTimeStampOffset.Hour       := Column.GetHour(Row);
          SqlTimeStampOffset.Minute     := Column.GetMinute(Row);
          SqlTimeStampOffset.Second     := Column.GetSeconds(Row);
          SqlTimeStampOffset.Fractions  := Column.GetMilliseconds(Row);
                                                                              
          SqlTimeStampOffset.TimeZoneHour := 0;
          SqlTimeStampOffset.TimeZoneMinute := 0;
          DbxValue.SetTimeStampOffset(SqlTimeStampOffset);
        end;
      TDBXDataTypes.BlobType, TDBXDataTypes.VarBytesType, TDBXDataTypes.BytesType:
        begin
          Buffer := Column.GetBytes(Row);
          DbxValue.SetDynamicBytes(0, Buffer, 0, Length(Buffer));
        end
      else
        raise TDbxDataGeneratorException.Create('Unknown DataType: ' + IntToStr(Column.DataType) + '.  Parameter will not be set');
    end;
  end;
end;

procedure TDbxDataGenerator.SetInsertParameters(const SQLQuery: TSQLQuery; Row: Integer);
var
  ColumnCount: Integer;
  Ordinal: Integer;
begin
  ColumnCount := GetColumnCount;
  for Ordinal := 0 to ColumnCount - 1 do
  begin
    SetParameter(Ordinal, Row, SQLQuery.Params[Ordinal]);
  end;
end;

class procedure TDbxDataGenerator.ValidateAnsiString(Value1, Value2: string);
begin
  if Value1 <> Value2 then
    raise TDBXDataGeneratorException.Create(Format('AnsiString values do not match: %s <> %s',[Value1, Value2]));
end;

class procedure TDbxDataGenerator.ValidateWideString(Value1, Value2: string);
begin
  if Value1 <> Value2 then
    raise TDBXDataGeneratorException.Create(Format('WideString values do not match: %s <> %s',[Value1, Value2]));
end;

class procedure TDbxDataGenerator.ValidateBcd(Value1, Value2: TBcd);
begin
  if BcdCompare(Value1,Value2) <> 0 then
    raise TDBXDataGeneratorException.Create(Format('WideString values do not match: %s <> %s',[BcdToStr(Value1), BcdToStr(Value2)]));
end;

class procedure TDbxDataGenerator.ValidateBoolean(Value1, Value2: Boolean);
begin
  if Value1 <> Value2 then
    raise TDBXDataGeneratorException.Create(Format('Boolean values do not match: %s <> %s',[BoolToStr(Value1), BoolToStr(Value2)]));
end;

class function TDbxDataGenerator.BytesEquals(const Value1, Value2: TArray<Byte>;
  Count: Integer): Boolean;
var
  Index: Integer;
begin
  for Index := 0 to Count - 1 do
  begin
    if Value1[Index] <> Value2[Index] then
    begin
      Result := false;
      Writeln(' '+ IntToStr(Value1[Index])+' '+IntToStr(Value2[Index]));
      exit;
    end;
  end;
  Result := true;
end;

constructor TDbxDataGenerator.Create;
begin
  inherited Create;
  FParam := TParam.Create(nil);
end;

destructor TDbxDataGenerator.Destroy;
begin
  FreeAndNil(FParam);
  inherited Destroy;
end;

function TDbxDataGenerator.GetIsFractionsSupported: Boolean;
//Remove once all drivers support Fractions (milliseconds) for timestamp (255605, 255767, 255768, 255769, 255797)
begin
  if Assigned(MetaDataProvider) then
  begin
    if (MetaDataProvider.DatabaseProduct = 'Microsoft SQL Server')
     or (MetaDataProvider.DatabaseProduct = 'InterBase')
     or (MetaDataProvider.DatabaseProduct = 'Firebird')
     or (MetaDataProvider.DatabaseProduct = 'MySQL')
     or (MetaDataProvider.DatabaseProduct = 'Oracle')
     or (MetaDataProvider.DatabaseProduct = 'Sybase SQL Server') then
      Result := False
    else
      Result := True;
  end else
    Result := True;
end;

procedure TDbxDataGenerator.PopulateDataset(DataSet: TDataSet; RowCount: Integer);
var
  Row: Integer;
  Ordinal: Integer;
  Param: TParam;
begin
  Param := TParam.Create(nil);
  try
    for Row := 0 to RowCount - 1 do
    begin
      DataSet.Append;
      for Ordinal := 0 to ColumnCount - 1 do
      begin
        SetParameter(Ordinal, Row, Param);
        DataSet.Fields[Ordinal].Value := Param.Value;
      end;
      DataSet.Post;
    end;
  finally
    Param.Free;
  end;
end;

procedure TDbxDataGenerator.PopulateParams(Params: TParams);
var
  Ordinal: Integer;
begin
  for Ordinal := 0 to ColumnCount - 1 do
    SetParameter(Ordinal, 0, Params[Ordinal]);
end;

class procedure TDbxDataGenerator.ReadBytesFromStream(Value: TDBXValue;
  var Buffer: TArray<Byte>);
var
  ReadBytes, ReadSize, TotalBytes: Integer;
  Stream: TStream;
begin
  ReadSize := 1024;
  ReadBytes := ReadSize;
  SetLength(Buffer, ReadSize);
  TotalBytes := 0;
  Stream := Value.GetStream(False);
  try
    while ReadBytes = ReadSize do
    begin
      ReadSize := Stream.Read(Buffer[TotalBytes], ReadSize);
      Inc(TotalBytes, ReadSize);
      if ReadSize = ReadBytes then
        SetLength(Buffer, TotalBytes + ReadSize);
    end;
  finally
    Stream.Free;
  end;
  SetLength(Buffer, TotalBytes);
end;

procedure TDbxDataGenerator.SetParameter(Ordinal: Integer; Row: Integer; Param: TParam);
var
  Column: TDBXDataGeneratorColumn;
  DateTime: TDateTime;
  SqlTimeStamp: TSQLTimeStamp;
  SqlTimeStampOffset: TSQLTimeStampOffset;
begin
    Column := GetColumn(Ordinal);
    case Column.Datatype of
      TDBXDataTypes.AnsiStringType:
        if Column.MetaDataColumn.Long and Assigned(MetaDataProvider) and not (MetaDataProvider.DatabaseProduct = 'BlackfishSQL') then
          Param.Value := Column.GetString(Row)
        else
          Param.AsString := Column.GetString(Row);
      TDBXDataTypes.BooleanType: Param.AsBoolean := Column.GetBoolean(Row);
      TDBXDataTypes.WideStringType: Param.AsWideString := Column.GetString(Row);
      TDBXDataTypes.UInt8Type: Param.AsByte := Column.GetInt8(Row);
      TDBXDataTypes.Int8Type: Param.AsShortInt := Column.GetInt8(Row);
      TDBXDataTypes.UInt16Type: Param.AsWord := Column.GetInt16(Row);
      TDBXDataTypes.Int16Type: Param.AsSmallInt := Column.GetInt16(Row);
      TDBXDataTypes.Int32Type: Param.AsInteger := Column.GetInt32(Row);
      TDBXDataTypes.Int64Type: Param.AsLargeInt := Column.GetInt64(Row);
      TDBXDataTypes.SingleType: Param.AsSingle := Column.GetSingle(Row);
      TDBXDataTypes.DoubleType: Param.AsFloat := Column.GetDouble(Row);
      TDBXDataTypes.BcdType: Param.AsFMTBCD := StrToBcd(Column.GetDecimal(Row));
      TDBXDataTypes.DateType:
        begin
          DateTime := EncodeDate(Column.GetYear(Row), Column.GetMonth(Row), Column.GetDay(Row));
          Param.AsDate := DateTime;
        end;
      TDBXDataTypes.TimeType:
        begin
          DateTime := EncodeTime(Column.GetHour(Row), Column.GetMinute(Row), Column.GetSeconds(Row), 0);
          Param.AsTime := DateTime;
        end;
      TDBXDataTypes.TimeStampType:
        begin
          SqlTimeStamp.Year       := Column.GetYear(Row);
          SqlTimeStamp.Month      := Column.GetMonth(Row);
          SqlTimeStamp.Day        := Column.GetDay(Row);
          SqlTimeStamp.Hour       := Column.GetHour(Row);
          SqlTimeStamp.Minute     := Column.GetMinute(Row);
          SqlTimeStamp.Second     := Column.GetSeconds(Row);
          SqlTimeStamp.Fractions  := Column.GetMilliseconds(Row);
          Param.AsSQLTimeStamp := SQLTimeStamp;
        end;
      TDBXDataTypes.TimeStampOffsetType:
        begin
          SqlTimeStampOffset.Year       := Column.GetYear(Row);
          SqlTimeStampOffset.Month      := Column.GetMonth(Row);
          SqlTimeStampOffset.Day        := Column.GetDay(Row);
          SqlTimeStampOffset.Hour       := Column.GetHour(Row);
          SqlTimeStampOffset.Minute     := Column.GetMinute(Row);
          SqlTimeStampOffset.Second     := Column.GetSeconds(Row);
          SqlTimeStampOffset.Fractions  := Column.GetMilliseconds(Row);
                                                                              
          SqlTimeStampOffset.TimeZoneHour := 0;
          SqlTimeStampOffset.TimeZoneMinute := 0;
          Param.AsSQLTimeStampOffset := SQLTimeStampOffset;
        end;
      TDBXDataTypes.BlobType: Param.Value := Column.GetBytes(Row);
      TDBXDataTypes.VarBytesType: Param.Value := Column.GetBytes(Row);
      TDBXDataTypes.BytesType: Param.Value := Column.GetBytes(Row);
      TDBXDataTypes.BinaryBlobType: Param.AsStream := TBytesStream.Create(Column.GetBytes(Row));
      else
        raise TDbxDataGeneratorException.Create('Unknown DataType: ' + IntToStr(Column.DataType) + '.  Parameter will not be set');
    end;
end;

class procedure TDbxDataGenerator.ValidateBytes(Value1, Value2: TArray<Byte>);
begin
  if (Length(Value1) <> Length(Value2)) or not BytesEquals(Value1, Value2, Length(Value2)) then
  begin
    raise TDBXDataGeneratorException.Create('TArray<Byte> values do not match');
  end;
end;

class procedure TDbxDataGenerator.ValidateDate(Value1, Value2: TDBXDate);
begin
  if Value1 <> Value2 then
    raise TDBXDataGeneratorException.Create(Format('Date values do not match: %s <> %s',[IntToStr(Value1), IntToStr(Value2)]));

end;

class procedure TDbxDataGenerator.ValidateSingle(Value1, Value2: Single);
begin
  if Value1 <> Value2 then
    raise TDBXDataGeneratorException.Create(Format('Single values do not match: %s <> %s',[FloatToStr(Value1), FloatToStr(Value2)]));

end;

class procedure TDbxDataGenerator.ValidateDouble(Value1, Value2: Double);
begin
  if Value1 <> Value2 then
    raise TDBXDataGeneratorException.Create(Format('Double values do not match: %s <> %s',[FloatToStr(Value1), FloatToStr(Value2)]));

end;

class procedure TDbxDataGenerator.ValidateInt64(Value1, Value2: Int64);
begin
  if Value1 <> Value2 then
    raise TDBXDataGeneratorException.Create(Format('Int64 values do not match: %s <> %s',[IntToStr(Value1), IntToStr(Value2)]));

end;
class procedure TDbxDataGenerator.ValidateTime(Value1, Value2: TDBXTime);
begin
  if Value1 <> Value2 then
    raise TDBXDataGeneratorException.Create(Format('Time values do not match: %s <> %s',[IntToStr(Value1), IntToStr(Value2)]));
end;

class procedure TDbxDataGenerator.ValidateDateTime(Value1, Value2: TDateTime);
begin
  if Value1 <> Value2 then
    raise TDBXDataGeneratorException.Create(Format('DateTime values do not match: %s <> %s',[DateTimeToStr(Value1), DateTimeToStr(Value2)]));
end;

class procedure TDbxDataGenerator.ValidateTimestamp(Value1, Value2: TSQLTimeStamp);
begin
  if CompareTimeStamp(Value1,Value2) <> 0 then
    raise TDBXDataGeneratorException.Create(Format('Timestamp values do not match: %s <> %s',[SQLTimeStampToStr('', Value1), SQLTimeStampToStr('', Value2)]));
end;

class procedure TDbxDataGenerator.ValidateTimestampOffset(Value1,
  Value2: TSQLTimeStampOffset);
begin
  if CompareTimeStampOffset(Value1,Value2) <> 0 then
    raise TDBXDataGeneratorException.Create(Format('Timestamp values do not match: %s <> %s',[SQLTimeStampOffsetToStr('', Value1), SQLTimeStampOffsetToStr('', Value2)]));
end;

procedure TDbxDataGenerator.ValidateParameters(const Command: TDBXCommand;
  Row: Integer);
var
  ColumnCount, Ordinal: Integer;
  Column: TDBXDataGeneratorColumn;
  DbxValue: TDBXWritableValue;
  DateTime: TDateTime;
  TimeStamp: TTimeStamp;
  SqlTimeStamp: TSQLTimeStamp;
  SqlTimeStampOffset: TSQLTimeStampOffset;
  Buffer: TArray<Byte>;
begin
  ColumnCount := GetColumnCount;
  for Ordinal := 0 to ColumnCount - 1 do
  begin
    Column := GetColumn(Ordinal);
    DbxValue := Command.Parameters[Ordinal].Value;
    case Column.Datatype of
      TDBXDataTypes.AnsiStringType:
{$IFNDEF NEXTGEN}
        ValidateAnsiString(string(DbxValue.GetAnsiString), Column.GetString(Row));
{$ELSE}
        ValidateAnsiString(DbxValue.GetWideString, Column.GetString(Row));
{$ENDIF}
      TDBXDataTypes.BooleanType: ValidateBoolean(DbxValue.GetBoolean, Column.GetBoolean(Row));
      TDBXDataTypes.WideStringType: ValidateWideString(DbxValue.GetWideString, Column.GetString(Row));
      TDBXDataTypes.UInt8Type: DbxValue.SetUInt8(Column.GetInt8(Row));
      TDBXDataTypes.Int8Type: DbxValue.SetInt8(Column.GetInt8(Row));
      TDBXDataTypes.UInt16Type: DbxValue.SetUInt16(Column.GetInt16(Row));
      TDBXDataTypes.Int16Type: DbxValue.SetInt16(Column.GetInt16(Row));
      TDBXDataTypes.Int32Type: DbxValue.SetInt32(Column.GetInt32(Row));
      TDBXDataTypes.Int64Type: ValidateInt64(DbxValue.GetInt64, Column.GetInt64(Row));
      TDBXDataTypes.SingleType: ValidateSingle(DbxValue.GetSingle, Column.GetSingle(Row));
      TDBXDataTypes.DoubleType: ValidateDouble(DbxValue.GetDouble, Column.GetDouble(Row));
      TDBXDataTypes.BcdType: ValidateBcd(DbxValue.GetBcd, StrToBcd(Column.GetDecimal(Row)));
      TDBXDataTypes.DateType:
        begin
          DateTime := EncodeDate(Column.GetYear(Row), Column.GetMonth(Row), Column.GetDay(Row));
          DateTimeToTimeStamp(DateTime);
          ValidateDate(DbxValue.GetDate, TimeStamp.Date);
        end;
      TDBXDataTypes.TimeType:
        begin
          DateTime := EncodeTime(Column.GetHour(Row), Column.GetMinute(Row), Column.GetSeconds(Row), Column.GetMilliseconds(Row));
          DateTimeToTimeStamp(DateTime);
          DbxValue.SetTime(TimeStamp.Time);
          ValidateDate(DbxValue.GetTime, TimeStamp.Time);
        end;
      TDBXDataTypes.TimeStampType:
        begin
          SqlTimeStamp.Year       := Column.GetYear(Row);
          SqlTimeStamp.Month      := Column.GetMonth(Row);
          SqlTimeStamp.Day        := Column.GetDay(Row);
          SqlTimeStamp.Hour       := Column.GetHour(Row);
          SqlTimeStamp.Minute     := Column.GetMinute(Row);
          SqlTimeStamp.Second     := Column.GetSeconds(Row);
          SqlTimeStamp.Fractions  := Column.GetMilliseconds(Row);
          ValidateTimestamp(DbxValue.GetTimeStamp, SqlTimeStamp);
        end;
      TDBXDataTypes.TimeStampOffsetType:
        begin
          SqlTimeStampOffset.Year      := Column.GetYear(Row);
          SqlTimeStampOffset.Month      := Column.GetMonth(Row);
          SqlTimeStampOffset.Day        := Column.GetDay(Row);
          SqlTimeStampOffset.Hour       := Column.GetHour(Row);
          SqlTimeStampOffset.Minute     := Column.GetMinute(Row);
          SqlTimeStampOffset.Second     := Column.GetSeconds(Row);
          SqlTimeStampOffset.Fractions  := Column.GetMilliseconds(Row);
                                                                              
          SqlTimeStampOffset.TimeZoneHour := 0;
          SqlTimeStampOffset.TimeZoneMinute := 0;
          ValidateTimeStampOffset(DbxValue.GetTimeStampOffset, SqlTimeStampOffset);
        end;
      TDBXDataTypes.BlobType:
        begin
{$IFNDEF NEXTGEN}
          if DbxValue.ValueType.SubType = TDBXDataTypes.MemoSubType then
            ValidateAnsiString(string(DbxValue.GetAnsiString), Column.GetString(row))
          else if DbxValue.ValueType.SubType = TDBXDataTypes.WideMemoSubType then
            ValidateWideString(string(DbxValue.GetAnsiString), Column.GetString(row));
{$ELSE}
          if DbxValue.ValueType.SubType = TDBXDataTypes.MemoSubType then
            ValidateAnsiString(DbxValue.GetWideString, Column.GetString(row))
          else if DbxValue.ValueType.SubType = TDBXDataTypes.WideMemoSubType then
            ValidateWideString(DbxValue.GetWideString, Column.GetString(row));
{$ENDIF}

          SetLength(Buffer, DbxValue.GetValueSize);
          DbxValue.GetBytes(0, Buffer, 0, Length(Buffer));
          ValidateBytes(Buffer, Column.GetBytes(Row));
        end;
    end;
  end;
end;

procedure TDbxDataGenerator.ValidateParams(const Params: TParams);
var
  Ordinal: Integer;
begin
  for Ordinal := 0 to Params.Count - 1 do
  begin
    ValidateParam(Ordinal, 0, Params[Ordinal]);
  end;
end;

procedure TDbxDataGenerator.ValidateParam(Ordinal, Row: Integer;
  Param: TParam);
var
  SqlTimeStamp: TSQLTimeStamp;
  SqlTimeStampOffset: TSQLTimeStampOffset;
begin
  case Param.DataType of
    ftString:
      if Assigned(MetaDataProvider) then
      begin
        if      (MetaDataProvider.DatabaseProduct = 'MySQL')
            or  (MetaDataProvider.DatabaseProduct = 'Sybase SQL Server') then
          ValidateAnsiString(Param.AsString, Trim(GetColumn(Ordinal).GetString(Row)))
        else
          ValidateAnsiString(Param.AsString, GetColumn(Ordinal).GetString(Row));
      end else
      begin
        ValidateAnsiString(Param.AsString, GetColumn(Ordinal).GetString(Row));
      end;
    ftMemo: ValidateAnsiString(Param.AsString, GetColumn(Ordinal).GetString(Row));
    ftBoolean: ValidateBoolean(Param.AsBoolean, GetColumn(Ordinal).GetBoolean(Row));
    ftWideString:
      if Assigned(MetaDataProvider) then
      begin
        if      (MetaDataProvider.DatabaseProduct = 'MySQL')
            or  (MetaDataProvider.DatabaseProduct = 'Sybase SQL Server') then
          ValidateWideString(Param.AsString, Trim(GetColumn(Ordinal).GetString(Row)))
        else
          ValidateWideString(Param.AsString, GetColumn(Ordinal).GetString(Row));
      end else
      begin
        ValidateWideString(Param.AsString, GetColumn(Ordinal).GetString(Row));
      end;
    ftWideMemo: ValidateWideString(Param.AsString, GetColumn(Ordinal).GetString(Row));
    ftByte: if Param.AsInteger <> GetColumn(Ordinal).GetInt8(Row) then
                   raise TDBXDataGeneratorException.Create('Byte values do not match');
    ftShortint: if Param.AsInteger <> GetColumn(Ordinal).GetInt8(Row) then
                   raise TDBXDataGeneratorException.Create('ShortInt values do not match');
    ftWord: if Param.AsInteger <> GetColumn(Ordinal).GetInt16(Row) then
                             raise TDBXDataGeneratorException.Create('Word values do not match');
    ftSmallint: if Param.AsInteger <> GetColumn(Ordinal).GetInt16(Row) then
                             raise TDBXDataGeneratorException.Create('SmallInt values do not match');
    ftInteger: if Param.AsInteger <> GetColumn(Ordinal).GetInt32(Row) then
                            raise TDBXDataGeneratorException.Create('Integer values do not match');
    ftLargeint: ValidateInt64(Param.AsInteger, GetColumn(Ordinal).GetInt64(Row));
    ftSingle: ValidateSingle(Param.AsSingle, GetColumn(Ordinal).GetSingle(Row));
    ftFloat: ValidateDouble(Param.AsFloat, GetColumn(Ordinal).GetDouble(Row));
    ftBCD, ftFMTBCD: if Param.Size = 0 then
                        ValidateBcd(Param.AsFMTBCD, IntegerToBcd(GetColumn(Ordinal).GetInt32(Row)))
                      else
                        ValidateBcd(Param.AsFMTBCD, StrToBcd(GetColumn(Ordinal).GetDecimal(Row)));
    ftDate: ValidateDate(DateTimeToTimeStamp(Param.AsDateTime).Date, (DateTimeToTimeStamp(EncodeDate(GetColumn(Ordinal).GetYear(Row), GetColumn(Ordinal).GetMonth(Row), GetColumn(Ordinal).GetDay(Row)))).Date);
    ftTime: ValidateTime(DateTimeToTimeStamp(Param.AsDateTime).Time, (DateTimeToTimeStamp(EncodeTime(GetColumn(Ordinal).GetHour(Row), GetColumn(Ordinal).GetMinute(Row), GetColumn(Ordinal).GetSeconds(Row), 0{GetColumn(I).GetMilliseconds(Row)}))).Time);
    ftTimeStamp:
      begin
        SqlTimeStamp.Year       := GetColumn(Ordinal).GetYear(Row);
        SqlTimeStamp.Month      := GetColumn(Ordinal).GetMonth(Row);
        SqlTimeStamp.Day        := GetColumn(Ordinal).GetDay(Row);
        SqlTimeStamp.Hour       := GetColumn(Ordinal).GetHour(Row);
        SqlTimeStamp.Minute     := GetColumn(Ordinal).GetMinute(Row);
        SqlTimeStamp.Second     := GetColumn(Ordinal).GetSeconds(Row);
        SqlTimeStamp.Fractions  := GetColumn(Ordinal).GetMilliseconds(Row);
        if IsFractionsSupported then
          ValidateTimeStamp(DateTimeToSQLTimeStamp(Param.AsDateTime), SqlTimeStamp)
        else
          ValidateAnsiString(SQLTimeStampToStr('yyyy-mm-dd hh:nn:ss',DateTimeToSQLTimeStamp(Param.AsDateTime)), SQLTimeStampToStr('yyyy-mm-dd hh:nn:ss',SqlTimeStamp));
      end;
    ftTimeStampOffset:
      begin
        SqlTimeStampOffset.Year := GetColumn(Ordinal).GetYear(Row);
        SqlTimeStampOffset.Month := GetColumn(Ordinal).GetMonth(Row);
        SqlTimeStampOffset.Day := GetColumn(Ordinal).GetDay(Row);
        SqlTimeStampOffset.Hour := GetColumn(Ordinal).GetHour(Row);
        SqlTimeStampOffset.Second := GetColumn(Ordinal).GetMinute(Row);
        SqlTimeStampOffset.Fractions := GetColumn(Ordinal).GetMilliseconds(Row);
                                                                            
        SqlTimeStampOffset.TimeZoneHour := 0;
        SqlTimeStampOffset.TimeZoneMinute := 0;
        if IsFractionsSupported then
          ValidateTimeStampOffset(DateTimeToSQLTimeStampOffset(Param.AsDateTime), SqlTimeStampOffset)
        else
          ValidateAnsiString(SQLTimeStampOffsetToStr('yyyy-mm-dd hh:nn:ss',DateTimeToSQLTimeStampOffset(Param.AsDateTime)), SQLTimeStampOffsetToStr('yyyy-mm-dd hh:nn:ss',SqlTimeStampOffset));
      end;
                                                                                
    ftBlob: ;//ValidateAnsiString(SQLQuery.Fields[I].Value, GetColumn(I).GetString(Row));
    ftOraClob: ;                   
    ftStream: ;                    
    ftBytes, ftVarBytes: ValidateBytes(Param.AsBytes, GetColumn(Ordinal).GetBytes(Row))
  else
    raise TDBXDataGeneratorException.Create('Unsupported type');
  end;
end;


function TDbxDataGenerator.ValidateRow(const DataSet: TDataSet; Row: Integer): Boolean;
var
  I : Integer;
  SqlTimeStamp: TSQLTimeStamp;
  SqlTimeStampOffset: TSQLTimeStampOffset;
begin
  for I := 0 to DataSet.FieldCount - 1 do
  begin
    case DataSet.Fields[I].DataType of
      ftString:
        if Assigned(MetaDataProvider) then
        begin
          if      (MetaDataProvider.DatabaseProduct = 'MySQL')
              or  (MetaDataProvider.DatabaseProduct = 'Sybase SQL Server') then
            ValidateAnsiString(DataSet.Fields[I].AsString, Trim(GetColumn(I).GetString(Row)))
          else
            ValidateAnsiString(DataSet.Fields[I].AsString, GetColumn(I).GetString(Row));
        end else
        begin
            ValidateAnsiString(DataSet.Fields[I].AsString, GetColumn(I).GetString(Row));
        end;
      ftMemo: ValidateAnsiString(DataSet.Fields[I].AsString, GetColumn(I).GetString(Row));
      ftBoolean: ValidateBoolean(DataSet.Fields[I].AsBoolean, GetColumn(I).GetBoolean(Row));
      ftWideString:
        if Assigned(MetaDataProvider) then
        begin
          if      (MetaDataProvider.DatabaseProduct = 'MySQL')
              or  (MetaDataProvider.DatabaseProduct = 'Sybase SQL Server') then
            ValidateWideString(DataSet.Fields[I].AsString, Trim(GetColumn(I).GetString(Row)))
          else
            ValidateWideString(DataSet.Fields[I].AsString, GetColumn(I).GetString(Row));
        end
        else begin
          ValidateWideString(DataSet.Fields[I].AsString, GetColumn(I).GetString(Row));
        end;
      ftWideMemo:
        if Assigned(MetaDataProvider) then
        begin
          if MetaDataProvider.DatabaseProduct = 'MySQL' then
            ValidateWideString(TMarshal.ReadStringAsAnsi(TPtrWrapper.Create(DataSet.Fields[I].AsBytes)), GetColumn(I).GetString(Row))
          else
            ValidateWideString(DataSet.Fields[I].AsString, GetColumn(I).GetString(Row));
        end
        else
          ValidateWideString(DataSet.Fields[I].AsString, GetColumn(I).GetString(Row));
      ftByte: if DataSet.Fields[I].AsInteger <> GetColumn(I).GetInt8(Row) then
                    raise TDBXDataGeneratorException.Create('Byte values do not match');
      ftShortint: if DataSet.Fields[I].AsInteger <> GetColumn(I).GetInt8(Row) then
                    raise TDBXDataGeneratorException.Create('ShortInt values do not match');
      ftWord: if DataSet.Fields[I].AsInteger <> GetColumn(I).GetInt16(Row) then
                               raise TDBXDataGeneratorException.Create('Word values do not match');
      ftSmallint: if DataSet.Fields[I].AsInteger <> GetColumn(I).GetInt16(Row) then
                               raise TDBXDataGeneratorException.Create('SmallInt values do not match');
      ftInteger: if DataSet.Fields[I].AsInteger <> GetColumn(I).GetInt32(Row) then
                              raise TDBXDataGeneratorException.Create('Integer values do not match');
      ftLargeint: ValidateInt64(DataSet.Fields[I].AsInteger, GetColumn(I).GetInt64(Row));
      ftSingle: ValidateSingle(DataSet.Fields[I].AsSingle, GetColumn(I).GetSingle(Row));
      ftFloat: ValidateDouble(DataSet.Fields[I].AsFloat, GetColumn(I).GetDouble(Row));
      ftBCD, ftFMTBCD: if DataSet.FieldDefs[I].Size = 0 then
                          ValidateBcd(DataSet.Fields[I].AsBCD, IntegerToBcd(GetColumn(I).GetInt32(Row)))
                        else
                          ValidateBcd(DataSet.Fields[I].AsBCD, StrToBcd(GetColumn(I).GetDecimal(Row)));
      ftDate: ValidateDate(DateTimeToTimeStamp(DataSet.Fields[I].AsDateTime).Date, (DateTimeToTimeStamp(EncodeDate(GetColumn(I).GetYear(Row), GetColumn(I).GetMonth(Row), GetColumn(I).GetDay(Row)))).Date);
      ftTime: ValidateTime(DateTimeToTimeStamp(DataSet.Fields[I].AsDateTime).Time, (DateTimeToTimeStamp(EncodeTime(GetColumn(I).GetHour(Row), GetColumn(I).GetMinute(Row), GetColumn(I).GetSeconds(Row), 0{GetColumn(I).GetMilliseconds(Row)}))).Time);
      ftTimeStamp:
        begin
          SqlTimeStamp.Year       := GetColumn(I).GetYear(Row);
          SqlTimeStamp.Month      := GetColumn(I).GetMonth(Row);
          SqlTimeStamp.Day        := GetColumn(I).GetDay(Row);
          SqlTimeStamp.Hour       := GetColumn(I).GetHour(Row);
          SqlTimeStamp.Minute     := GetColumn(I).GetMinute(Row);
          SqlTimeStamp.Second     := GetColumn(I).GetSeconds(Row);
          SqlTimeStamp.Fractions  := GetColumn(I).GetMilliseconds(Row);
          if IsFractionsSupported then
            ValidateTimeStamp(DateTimeToSQLTimeStamp(DataSet.Fields[I].AsDateTime), SqlTimeStamp)
          else
            ValidateAnsiString(SQLTimeStampToStr('yyyy-mm-dd hh:nn:ss',DateTimeToSQLTimeStamp(DataSet.Fields[I].AsDateTime)), SQLTimeStampToStr('yyyy-mm-dd hh:nn:ss',SqlTimeStamp));
        end;
      ftTimeStampOffset:
        begin
          SqlTimeStampOffset.Year       := GetColumn(I).GetYear(Row);
          SqlTimeStampOffset.Month      := GetColumn(I).GetMonth(Row);
          SqlTimeStampOffset.Day        := GetColumn(I).GetDay(Row);
          SqlTimeStampOffset.Hour       := GetColumn(I).GetHour(Row);
          SqlTimeStampOffset.Minute     := GetColumn(I).GetMinute(Row);
          SqlTimeStampOffset.Second     := GetColumn(I).GetSeconds(Row);
          SqlTimeStampOffset.Fractions  := GetColumn(I).GetMilliseconds(Row);
                                                                              
          SqlTimeStampOffset.TimeZoneHour := 0;
          SqlTimeStampOffset.TimeZoneMinute := 0;
          if IsFractionsSupported then
            ValidateTimeStampOffset(DateTimeToSQLTimeStampOffset(DataSet.Fields[I].AsDateTime), SqlTimeStampOffset)
          else
            ValidateAnsiString(SQLTimeStampOffsetToStr('yyyy-mm-dd hh:nn:ss',DateTimeToSQLTimeStampOffset(DataSet.Fields[I].AsDateTime)), SQLTimeStampOffsetToStr('yyyy-mm-dd hh:nn:ss',SqlTimeStampOffset));
        end;
                                                                                  
      ftBlob: ;//ValidateAnsiString(SQLQuery.Fields[I].Value, GetColumn(I).GetString(Row));
      ftOraClob: ;                   
      ftBytes, ftVarBytes: ValidateBytes(DataSet.Fields[I].Value, GetColumn(I).GetBytes(Row))
    else
      raise TDBXDataGeneratorException.Create('Unsupported type');
    end;
  end;
  Result := True;
end;

function TDbxDataGenerator.ValidateRow(const Reader: TDBXReader; Row: Integer): Boolean;
var
  I, Size : Integer;
  SqlTimeStamp: TSQLTimeStamp;
  SqlTimeStampOffset: TSQLTimeStampOffset;
  Buffer: TArray<Byte>;
begin
  for I := 0 to Reader.ColumnCount - 1 do
  begin
    case Reader.Value[I].ValueType.DataType of
      TDBXDataTypes.UInt8Type: if (Reader.Value[I].GetUInt8 <> GetColumn(I).GetInt8(Row)) then
                                  raise TDBXDataGeneratorException.Create('UInt8 values do not match');
      TDBXDataTypes.Int8Type: if (Reader.Value[I].GetInt8 <> ShortInt(GetColumn(I).GetInt8(Row))) then
                                  raise TDBXDataGeneratorException.Create('Int8 values do not match');
      TDBXDataTypes.Int64Type : ValidateInt64(Reader.Value[I].GetInt64, GetColumn(I).GetInt64(Row));
      TDBXDataTypes.Int32Type : if (Reader.Value[I].GetInt32 <> GetColumn(I).GetInt32(Row)) then
                                  raise TDBXDataGeneratorException.Create('Int32 values do not match');
      TDBXDataTypes.UInt16Type : if (Reader.Value[I].GetUInt16 <> Word(GetColumn(I).GetInt16(Row))) then
                                  raise TDBXDataGeneratorException.Create('UInt16 values do not match');
      TDBXDataTypes.Int16Type : if (Reader.Value[I].GetInt16 <> GetColumn(I).GetInt16(Row)) then
                                  raise TDBXDataGeneratorException.Create('Int16 values do not match');
      TDBXDataTypes.SingleType : ValidateSingle(Reader.Value[I].GetSingle, GetColumn(I).GetSingle(Row));
      TDBXDataTypes.DoubleType : ValidateDouble(Reader.Value[I].GetDouble, GetColumn(I).GetDouble(Row));
      TDBXDataTypes.BcdType : if Reader.Value[I].ValueType.Scale = 0 then
                                ValidateBcd(Reader.Value[I].GetBcd, IntegerToBcd(GetColumn(I).GetInt32(Row)))
                              else
                                ValidateBcd(Reader.Value[I].GetBcd, StrToBcd(GetColumn(I).GetDecimal(Row)));
      TDBXDataTypes.DateType : ValidateDate(Reader.Value[I].GetDate, (DateTimeToTimeStamp(EncodeDate(GetColumn(I).GetYear(Row), GetColumn(I).GetMonth(Row), GetColumn(I).GetDay(Row)))).Date);
      TDBXDataTypes.BooleanType : ValidateBoolean(Reader.Value[I].GetBoolean, GetColumn(I).GetBoolean(Row));
      TDBXDataTypes.BlobType: begin
                                if Reader.Value[I].ValueType.SubType = TDBXDataTypes.MemoSubType then
{$IFNDEF NEXTGEN}
                                  ValidateAnsiString(string(Reader.Value[I].GetAnsiString), GetColumn(I).GetString(Row))
{$ELSE}
                                  ValidateAnsiString(Reader.Value[I].GetString, GetColumn(I).GetString(Row))
{$ENDIF}
                                else if Reader.Value[I].ValueType.SubType = TDBXDataTypes.WideMemoSubType then
                                begin
                                  if Assigned(MetaDataProvider) then
                                  begin
                                    if MetaDataProvider.DatabaseProduct = 'MySQL' then
                                    begin
                                      SetLength(Buffer, Reader.Value[I].GetValueSize);
                                      Reader.Value[I].GetBytes(0, Buffer, 0, Length(Buffer));
                                      ValidateWideString(TMarshal.ReadStringAsUnicode(TPtrWrapper.Create(Buffer)), GetColumn(I).GetString(Row));
                                    end
                                    else
                                      ValidateWideString(Reader.Value[I].GetWideString, GetColumn(I).GetString(Row));
                                  end
                                  else
                                    ValidateWideString(Reader.Value[I].GetWideString, GetColumn(I).GetString(Row));
                                end;
                                                                                          
                              end;
      TDBXDataTypes.BytesType : begin
                                  Size := Reader.Value[I].GetValueSize;
                                  if Size < 0 then
                                  begin
                                    ReadBytesFromStream(Reader.Value[I], Buffer);
                                  end else
                                  begin
                                    SetLength(Buffer, Size);
                                    Reader.Value[I].GetBytes(0, Buffer, 0, Size);
                                  end;
                                  ValidateBytes(Buffer, GetColumn(I).GetBytes(Row));
                                end;
      TDBXDataTypes.AnsiStringType :
{$IFNDEF NEXTGEN}
        if Assigned(MetaDataProvider) then
        begin
          if      (MetaDataProvider.DatabaseProduct = 'MySQL')
              or  (MetaDataProvider.DatabaseProduct = 'Sybase SQL Server') then
            ValidateAnsiString(string(Reader.Value[I].GetAnsiString), Trim(GetColumn(I).GetString(Row)))
          else
            ValidateAnsiString(string(Reader.Value[I].GetAnsiString), GetColumn(I).GetString(Row));
        end
        else
          ValidateAnsiString(string(Reader.Value[I].GetAnsiString), GetColumn(I).GetString(Row));
{$ELSE}
        if Assigned(MetaDataProvider) then
        begin
          if      (MetaDataProvider.DatabaseProduct = 'MySQL')
              or  (MetaDataProvider.DatabaseProduct = 'Sybase SQL Server') then
            ValidateAnsiString(Reader.Value[I].GetString, Trim(GetColumn(I).GetString(Row)))
          else
            ValidateAnsiString(Reader.Value[I].GetString, GetColumn(I).GetString(Row));
        end
        else
          ValidateAnsiString(Reader.Value[I].GetString, GetColumn(I).GetString(Row));
{$ENDIF}
      TDBXDataTypes.ObjectType: raise TDBXDataGeneratorException.Create('Unsupported type Object');
      TDBXDataTypes.TimeType : ValidateTime(Reader.Value[I].GetTime, (DateTimeToTimeStamp(EncodeTime(GetColumn(I).GetHour(Row), GetColumn(I).GetMinute(Row), GetColumn(I).GetSeconds(Row), 0{GetColumn(I).GetMilliseconds(Row)}))).Time);
      TDBXDataTypes.TimeStampType : begin
                                      SqlTimeStamp.Year       := GetColumn(I).GetYear(Row);
                                      SqlTimeStamp.Month      := GetColumn(I).GetMonth(Row);
                                      SqlTimeStamp.Day        := GetColumn(I).GetDay(Row);
                                      SqlTimeStamp.Hour       := GetColumn(I).GetHour(Row);
                                      SqlTimeStamp.Minute     := GetColumn(I).GetMinute(Row);
                                      SqlTimeStamp.Second     := GetColumn(I).GetSeconds(Row);
                                      SqlTimeStamp.Fractions  := GetColumn(I).GetMilliseconds(Row);
                                      if IsFractionsSupported then
                                        ValidateTimeStamp(Reader.Value[I].GetTimeStamp, SqlTimeStamp)
                                      else
                                        ValidateAnsiString(SQLTimeStampToStr('yyyy-mm-dd hh:nn:ss',Reader.Value[I].GetTimeStamp), SQLTimeStampToStr('yyyy-mm-dd hh:nn:ss',SqlTimeStamp));
                                    end;
      TDBXDataTypes.TimeStampOffsetType: begin
                                           SqlTimeStampOffset.Year       := GetColumn(I).GetYear(Row);
                                           SqlTimeStampOffset.Month      := GetColumn(I).GetMonth(Row);
                                           SqlTimeStampOffset.Day        := GetColumn(I).GetDay(Row);
                                           SqlTimeStampOffset.Hour       := GetColumn(I).GetHour(Row);
                                           SqlTimeStampOffset.Minute     := GetColumn(I).GetMinute(Row);
                                           SqlTimeStampOffset.Second     := GetColumn(I).GetSeconds(Row);
                                           SqlTimeStampOffset.Fractions  := GetColumn(I).GetMilliseconds(Row);
                                                                              
                                           SqlTimeStampOffset.TimeZoneHour := 0;
                                           SqlTimeStampOffset.TimeZoneMinute := 0;
                                           if IsFractionsSupported then
                                             ValidateTimeStampOffset(Reader.Value[I].GetTimeStampOffset, SqlTimeStampOffset)
                                           else
                                             ValidateAnsiString(SQLTimeStampOffsetToStr('yyyy-mm-dd hh:nn:ss',Reader.Value[I].GetTimeStampOffset), SQLTimeStampOffsetToStr('yyyy-mm-dd hh:nn:ss',SqlTimeStampOffset));
        end;
      TDBXDataTypes.UInt32Type: raise TDBXDataGeneratorException.Create('Unsupported type UInt32');
      TDBXDataTypes.UInt64Type: raise TDBXDataGeneratorException.Create('Unsupported type UInt64');
      TDBXDataTypes.WideStringType :
        if Assigned(MetaDataProvider) then
        begin
          if      (MetaDataProvider.DatabaseProduct = 'MySQL')
              or  (MetaDataProvider.DatabaseProduct = 'Sybase SQL Server') then
            ValidateWideString(Reader.Value[I].GetWideString, Trim(GetColumn(I).GetString(Row)))
          else
            ValidateWideString(Reader.Value[I].GetWideString, GetColumn(I).GetString(Row));
        end
        else
        begin
          ValidateWideString(Reader.Value[I].GetWideString, GetColumn(I).GetString(Row));
        end;
      TDBXDataTypes.VarbytesType: begin
                                    Size := Reader.Value[I].GetValueSize;
                                    SetLength(Buffer, Size);
                                    Reader.Value[I].GetBytes(0, Buffer, 0, Size);
                                    ValidateBytes(Buffer, GetColumn(I).GetBytes(Row));
                                  end
    else
      raise TDBXDataGeneratorException.Create('Unsupported type ' + IntToStr(Reader.Value[I].ValueType.DataType));
    end;
  end;
  Result := True;
end;

end.
