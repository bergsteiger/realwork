{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Data.DBXMemoryRow;

interface

uses System.Classes, System.JSON, Data.DBXCommon, Data.DBXPlatform, Data.FmtBcd, Data.SqlTimSt;

type
  // Types needed for REST
//      FSupportedTypes.Add(TDBXDataTypes.AnsiStringType);
//    FSupportedTypes.Add(TDBXDataTypes.WideStringType);   get/set
//    FSupportedTypes.Add(TDBXDataTypes.BooleanType);    get/set
//    FSupportedTypes.Add(TDBXDataTypes.Int8Type);        get/set
//    FSupportedTypes.Add(TDBXDataTypes.Int16Type);     get/set
//    FSupportedTypes.Add(TDBXDataTypes.Int32Type);      get/set
//    FSupportedTypes.Add(TDBXDataTypes.Int64Type);     get/set
//    FSupportedTypes.Add(TDBXDataTypes.UInt8Type);      get/set
//    FSupportedTypes.Add(TDBXDataTypes.UInt16Type);     get /set
//    FSupportedTypes.Add(TDBXDataTypes.UInt32Type);
//    FSupportedTypes.Add(TDBXDataTypes.UInt64Type);
//    FSupportedTypes.Add(TDBXDataTypes.DoubleType);    get/set
//    FSupportedTypes.Add(TDBXDataTypes.SingleType);    get/set
//    FSupportedTypes.Add(TDBXDataTypes.CurrencyType);  BcdType is used
//    FSupportedTypes.Add(TDBXDataTypes.BcdType);     get/set
//    FSupportedTypes.Add(TDBXDataTypes.DateType);  get/set
//    FSupportedTypes.Add(TDBXDataTypes.DatetimeType); TimeStampType is used
//    FSupportedTypes.Add(TDBXDataTypes.TimeType);   get/set
//    FSupportedTypes.Add(TDBXDataTypes.TimeStampType); get/set
//    FSupportedTypes.Add(TDBXDataTypes.JsonValueType);   get/set
//    FSupportedTypes.Add(TDBXDataTypes.ArrayType);   Stream get/set?
//    FSupportedTypes.Add(TDBXDataTypes.ObjectType);
//    FSupportedTypes.Add(TDBXDataTypes.TableType);    get/set reader
//    FSupportedTypes.Add(TDBXDataTypes.BinaryBlobType);  get/set stream

  TDBXMemoryRow = class(TDBXRow)
  private
    FValueRow: TDBXWritableValueArray;
    procedure ClearValues(AValues: TDBXWritableValueArray);
  protected
    {$IFNDEF NEXTGEN}
    procedure SetAnsiString(DbxValue: TDBXAnsiStringValue; const Value: AnsiString); override;
    procedure GetAnsiString(DbxValue: TDBXAnsiStringValue; var AnsiStringBuilder: TDBXAnsiStringBuilder; var IsNull: LongBool); override;
    {$ENDIF}
    procedure GetJSONValue(DbxValue: TDBXJSONValue; var Value: TJSONValue; var IsNull: LongBool); override;
    procedure SetJSONValue(DbxValue: TDBXJSONValue; Value: TJSONValue); override;
    procedure SetTimestamp(DbxValue: TDBXTimeStampValue;
      var Value: TSQLTimeStamp); override;
    procedure GetTimeStamp(DbxValue: TDBXTimeStampValue;
      var Value: TSQLTimeStamp; var IsNull: LongBool); override;
    procedure GetTime(DbxValue: TDBXTimeValue; var Value: TDBXTime;
      var IsNull: LongBool); override;
    procedure SetTime(DbxValue: TDBXTimeValue; Value: TDBXTime); override;
    procedure SetDate(DbxValue: TDBXDateValue; Value: TDBXDate); override;
    procedure GetDate(DbxValue: TDBXDateValue; var Value: TDBXDate;
      var IsNull: LongBool); override;
    procedure GetBoolean(DbxValue: TDBXBooleanValue; var Value,
      IsNull: LongBool); override;
    procedure SetBoolean(DbxValue: TDBXBooleanValue; Value: Boolean); override;
    procedure GetInt16(DbxValue: TDBXInt16Value; var Value: SmallInt;
      var IsNull: LongBool); override;
    procedure SetInt16(DbxValue: TDBXInt16Value; Value: SmallInt); override;
    procedure GetInt32(DbxValue: TDBXInt32Value; var Value: TInt32;
      var IsNull: LongBool); override;
    procedure SetInt32(DbxValue: TDBXInt32Value; Value: TInt32); override;
    procedure GetInt64(DbxValue: TDBXInt64Value; var Value: Int64;
      var IsNull: LongBool); override;
    procedure SetInt64(DbxValue: TDBXInt64Value; Value: Int64); override;
    procedure GetInt8(DbxValue: TDBXInt8Value; var Value: Int8;
      var IsNull: LongBool); override;
    procedure SetInt8(DbxValue: TDBXInt8Value; Value: ShortInt); override;
    procedure SetUInt8(DbxValue: TDBXUInt8Value; Value: Byte); override;
    procedure GetUInt8(DbxValue: TDBXUInt8Value; var Value: Byte;
      var IsNull: LongBool); override;
    procedure GetUInt16(DbxValue: TDBXUInt16Value; var Value: Word;
      var IsNull: LongBool); override;
    procedure SetUInt16(DbxValue: TDBXUInt16Value; Value: UInt16); override;
    procedure GetBcd(DbxValue: TDBXBcdValue; var Value: TBcd;
      var IsNull: LongBool); override;
    procedure SetBCD(DbxValue: TDBXBcdValue; var Value: TBcd); override;
                                                                             
    procedure GetWideString(DbxValue: TDBXWideStringValue; var WideStringBuilder: TDBXWideStringBuilder; var IsNull: LongBool); override;
    procedure SetWideString(DbxValue: TDBXWideStringValue;
      const Value: string); override;
    procedure SetValueType(ValueType: TDBXValueType); override;
    procedure GetDBXReader(DbxValue: TDBXReaderValue; var Value: TDBXReader; var IsNull: LongBool); override;
    procedure SetDBXReader(DbxValue: TDBXReaderValue; Value: TDBXReader); override;
    procedure GetSingle(DbxValue: TDBXSingleValue; var Value: Single; var IsNull: LongBool); override;
    procedure SetSingle(DbxValue: TDBXSingleValue; Value: Single); override;
    procedure GetDouble(DbxValue: TDBXDoubleValue; var Value: Double; var IsNull: LongBool); override;
    procedure SetDouble(DbxValue: TDBXDoubleValue; Value: Double); override;
    procedure SetStream(DbxValue: TDBXStreamValue;
      StreamReader: TDBXStreamReader); override;
    procedure GetStream(DbxValue: TDBXStreamValue; var Stream: TStream;
      var IsNull: LongBool); overload; override;
  public
    constructor Create(DBXContext: TDBXContext; Values: TDBXValueTypeArray);
    destructor Destroy; override;
  end;

implementation

uses System.SysUtils;

constructor TDBXMemoryRow.Create(DBXContext: TDBXContext; Values: TDBXValueTypeArray);
var
  LValue: TDBXValueType;
  LWritableValue: TDBXWritableValue;
  LOrdinal: Integer;
begin
  inherited Create(DBXContext);
  SetLength(FValueRow, Length(Values));
  LOrdinal := 0;
  for LValue in Values do
  begin
    LWritableValue := TDBXWritableValue(TDBXValue.CreateValue(FDBXContext, LValue.Clone, nil, False));
    LWritableValue.ValueType.Ordinal := LOrdinal;
    FValueRow[LOrdinal] := LWritableValue;
    Inc(LOrdinal);
  end;
end;

destructor TDBXMemoryRow.Destroy;
begin
  ClearValues(FValueRow);
  inherited;
end;

procedure TDBXMemoryRow.ClearValues(AValues: TDBXWritableValueArray);
var
  I: Integer;
begin
  if Length(AValues) > 0 then
    for I := 0 to Length(AValues) - 1 do
      AValues[I].DisposeOf;
end;

procedure TDBXMemoryRow.GetBoolean(DbxValue: TDBXBooleanValue; var Value: LongBool; var IsNull: LongBool);
var
  Ordinal: Integer;
begin
  Ordinal := DbxValue.ValueType.Ordinal;
  IsNull := FValueRow[Ordinal].IsNull;
  if not IsNull then
    Value := FValueRow[Ordinal].AsBoolean
  else
    Value := False;
end;

procedure TDBXMemoryRow.GetDate(DbxValue: TDBXDateValue; var Value: TDBXDate; var IsNull: LongBool);
var
  Ordinal: Integer;
begin
  Ordinal := DbxValue.ValueType.Ordinal;
  IsNull := FValueRow[Ordinal].IsNull;
  if not IsNull then
    Value := FValueRow[Ordinal].GetDate
end;

procedure TDBXMemoryRow.GetInt8(DbxValue: TDBXInt8Value; var Value: Int8; var IsNull: LongBool);
var
  Ordinal: Integer;
begin
  Ordinal := DbxValue.ValueType.Ordinal;
  IsNull := FValueRow[Ordinal].IsNull;
  if not IsNull then
    Value := FValueRow[Ordinal].GetInt8
  else
    Value := 0;
end;

procedure TDBXMemoryRow.GetJSONValue(DbxValue: TDBXJSONValue;
  var Value: TJSONValue; var IsNull: LongBool);
var
  Ordinal: Integer;
begin
  Ordinal := DbxValue.ValueType.Ordinal;
  IsNull := FValueRow[Ordinal].IsNull;
  if not IsNull then
  begin
    // release ownership.  Row implementations should not
    // maintain ownership of objects.
    //
    Value := FValueRow[Ordinal].GetJSONValue(False);
  end
end;

procedure TDBXMemoryRow.GetSingle(DbxValue: TDBXSingleValue; var Value: Single;
  var IsNull: LongBool);
var
  Ordinal: Integer;
begin
  Ordinal := DbxValue.ValueType.Ordinal;
  IsNull := FValueRow[Ordinal].IsNull;
  if not IsNull then
    Value := FValueRow[Ordinal].GetSingle
  else
    Value := 0;
end;

procedure TDBXMemoryRow.GetStream(DbxValue: TDBXStreamValue;
  var Stream: TStream; var IsNull: LongBool);
var
  Ordinal: Integer;
begin
  Ordinal := DbxValue.ValueType.Ordinal;
  IsNull := FValueRow[Ordinal].IsNull;
  if not IsNull then
  begin
    Stream :=  FValueRow[Ordinal].AsStream;
    // release ownership.  Row implementations should not
    // maintain ownership of objects.
    //
    FValueRow[Ordinal].SetStream(Stream, False);
  end;
end;

procedure TDBXMemoryRow.GetTime(DbxValue: TDBXTimeValue; var Value: TDBXTime;
  var IsNull: LongBool);
var
  Ordinal: Integer;
begin
  Ordinal := DbxValue.ValueType.Ordinal;
  IsNull := FValueRow[Ordinal].IsNull;
  if not IsNull then
    Value := FValueRow[Ordinal].GetTime;
end;

procedure TDBXMemoryRow.GetTimeStamp(DbxValue: TDBXTimeStampValue;
  var Value: TSQLTimeStamp; var IsNull: LongBool);
var
  Ordinal: Integer;
begin
  Ordinal := DbxValue.ValueType.Ordinal;
  IsNull := FValueRow[Ordinal].IsNull;
  if not IsNull then
    Value := FValueRow[Ordinal].GetTimeStamp
end;

procedure TDBXMemoryRow.GetBcd(DbxValue: TDBXBcdValue; var Value: TBcd; var IsNull: LongBool);
var
  Ordinal: Integer;
begin
  Ordinal := DbxValue.ValueType.Ordinal;
  IsNull := FValueRow[Ordinal].IsNull;
  if not IsNull then
    Value := FValueRow[Ordinal].GetBcd
end;

procedure TDBXMemoryRow.GetInt16(DbxValue: TDBXInt16Value; var Value: SmallInt; var IsNull: LongBool);
var
  Ordinal: Integer;
begin
  Ordinal := DbxValue.ValueType.Ordinal;
  IsNull := FValueRow[Ordinal].IsNull;
  if not IsNull then
    Value := FValueRow[Ordinal].GetInt16
  else
    Value := 0;
end;

procedure TDBXMemoryRow.GetInt32(DbxValue: TDBXInt32Value; var Value: TInt32; var IsNull: LongBool);
var
  Ordinal: Integer;
begin
  Ordinal := DbxValue.ValueType.Ordinal;
  IsNull := FValueRow[Ordinal].IsNull;
  if not IsNull then
    Value := FValueRow[Ordinal].AsInt32
  else
    Value := 0;
end;

procedure TDBXMemoryRow.GetInt64(DbxValue: TDBXInt64Value; var Value: Int64; var IsNull: LongBool);
var
  Ordinal: Integer;
begin
  Ordinal := DbxValue.ValueType.Ordinal;
  IsNull := FValueRow[Ordinal].IsNull;
  if not IsNull then
    Value := FValueRow[Ordinal].GetInt64
  else
    Value := 0;
end;

procedure TDBXMemoryRow.GetUInt16(DbxValue: TDBXUInt16Value; var Value: Word;
  var IsNull: LongBool);
var
  Ordinal: Integer;
begin
  Ordinal := DbxValue.ValueType.Ordinal;
  IsNull := FValueRow[Ordinal].IsNull;
  if not IsNull then
    Value := FValueRow[Ordinal].GetUInt16
  else
    Value := 0;
end;

procedure TDBXMemoryRow.GetUInt8(DbxValue: TDBXUInt8Value; var Value: Byte;
  var IsNull: LongBool);
var
  Ordinal: Integer;
begin
  Ordinal := DbxValue.ValueType.Ordinal;
  IsNull := FValueRow[Ordinal].IsNull;
  if not IsNull then
    Value := FValueRow[Ordinal].GetUInt8
  else
    Value := 0;
end;

procedure TDBXMemoryRow.GetDBXReader(DbxValue: TDBXReaderValue;
  var Value: TDBXReader; var IsNull: LongBool);
var
  Ordinal: Integer;
begin
  Ordinal := DbxValue.ValueType.Ordinal;
  IsNull := FValueRow[Ordinal].IsNull;
  if not IsNull then
  begin
    DbxValue.SetDBXReader(FValueRow[Ordinal].GetDBXReader(False), False);
  end
end;

procedure TDBXMemoryRow.GetDouble(DbxValue: TDBXDoubleValue; var Value: Double;
  var IsNull: LongBool);
var
  Ordinal: Integer;
begin
  Ordinal := DbxValue.ValueType.Ordinal;
  IsNull := FValueRow[Ordinal].IsNull;
  if not IsNull then
    Value := FValueRow[Ordinal].GetDouble
  else
    Value := 0;
end;

procedure TDBXMemoryRow.GetWideString(DbxValue: TDBXWideStringValue; var WideStringBuilder: TDBXWideStringBuilder; var IsNull: LongBool);
var
  Ordinal, SourceSize: Integer;
  Source: string;
begin
  Ordinal := DbxValue.ValueType.Ordinal;
  IsNull := FValueRow[Ordinal].IsNull;
  if not IsNull then
  begin
    Source := FValueRow[Ordinal].AsString;
    SourceSize := Source.Length;
    if SourceSize >= DbxValue.ValueType.Size then
      TDBXPlatform.ResizeWideStringBuilder(WideStringBuilder, SourceSize + 2);
    TDBXPlatform.CopyWideStringToBuilder(Source, SourceSize + 2, WideStringBuilder);
  end
end;

{$IFNDEF NEXTGEN}
procedure TDBXMemoryRow.GetAnsiString(DbxValue: TDBXAnsiStringValue;
  var AnsiStringBuilder: TDBXAnsiStringBuilder; var IsNull: LongBool);
var
  Ordinal, SourceSize: Integer;
  Source: AnsiString;
begin
  Ordinal := DbxValue.ValueType.Ordinal;
  IsNull := FValueRow[Ordinal].IsNull;
  if not IsNull then
  begin
    Source := FValueRow[Ordinal].GetAnsiString;
    SourceSize := Length(Source);
    if SourceSize >= DbxValue.ValueType.Size then
      TDBXPlatform.ResizeStringBuilder(AnsiStringBuilder, SourceSize + 2);
    TDBXPlatform.CopyStringToBuilder(Source, SourceSize + 2, AnsiStringBuilder);
  end
end;
{$ENDIF !NEXTGEN}

procedure TDBXMemoryRow.SetWideString(DbxValue: TDBXWideStringValue;
  const Value: string);
var
  Ordinal: Integer;
begin
  Ordinal := DbxValue.ValueType.Ordinal;
  FValueRow[Ordinal].SetWideString(Value);
end;

{$IFNDEF NEXTGEN}
procedure TDBXMemoryRow.SetAnsiString(DbxValue: TDBXAnsiStringValue;
  const Value: AnsiString);
var
  Ordinal: Integer;
begin
  Ordinal := DbxValue.ValueType.Ordinal;
  FValueRow[Ordinal].SetAnsiString(Value);
end;
{$ENDIF !NEXTGEN}

procedure TDBXMemoryRow.SetBoolean(DbxValue: TDBXBooleanValue; Value: Boolean);
var
  Ordinal: Integer;
begin
  Ordinal := DbxValue.ValueType.Ordinal;
  FValueRow[Ordinal].SetBoolean(Value);
end;

procedure TDBXMemoryRow.SetBCD(DbxValue: TDBXBcdValue; var Value: TBcd);
var
  Ordinal: Integer;
begin
  Ordinal := DbxValue.ValueType.Ordinal;
  FValueRow[Ordinal].SetBcd(Value);
end;

procedure TDBXMemoryRow.SetDate(DbxValue: TDBXDateValue; Value: TDBXDate);
var
  Ordinal: Integer;
begin
  Ordinal := DbxValue.ValueType.Ordinal;
  FValueRow[Ordinal].SetDate(Value);
end;

procedure TDBXMemoryRow.SetDBXReader(DbxValue: TDBXReaderValue;
  Value: TDBXReader);
var
  Ordinal: Integer;
begin
  Ordinal := DbxValue.ValueType.Ordinal;
  if Value = nil then
    FValueRow[Ordinal].SetNull
  else
    FValueRow[Ordinal].SetDBXReader(Value, False);
end;

procedure TDBXMemoryRow.SetDouble(DbxValue: TDBXDoubleValue; Value: Double);
var
  Ordinal: Integer;
begin
  Ordinal := DbxValue.ValueType.Ordinal;
  FValueRow[Ordinal].SetDouble(Value);
end;

procedure TDBXMemoryRow.SetInt16(DbxValue: TDBXInt16Value; Value: SmallInt);
var
  Ordinal: Integer;
begin
  Ordinal := DbxValue.ValueType.Ordinal;
  FValueRow[Ordinal].SetInt16(Value);
end;

procedure TDBXMemoryRow.SetInt32(DbxValue: TDBXInt32Value; Value: TInt32);
var
  Ordinal: Integer;
begin
  Ordinal := DbxValue.ValueType.Ordinal;
  FValueRow[Ordinal].SetInt32(Value);
end;

procedure TDBXMemoryRow.SetInt64(DbxValue: TDBXInt64Value; Value: Int64);
var
  Ordinal: Integer;
begin
  Ordinal := DbxValue.ValueType.Ordinal;
  FValueRow[Ordinal].SetInt64(Value);
end;

procedure TDBXMemoryRow.SetInt8(DbxValue: TDBXInt8Value; Value: ShortInt);
var
  Ordinal: Integer;
begin
  Ordinal := DbxValue.ValueType.Ordinal;
  FValueRow[Ordinal].SetInt8(Value);
end;

procedure TDBXMemoryRow.SetJSONValue(DbxValue: TDBXJSONValue;
  Value: TJSONValue);
var
  Ordinal: Integer;
begin
  Ordinal := DbxValue.ValueType.Ordinal;
  if Value = nil then
    FValueRow[Ordinal].SetNull
  else
  begin
                              
    FValueRow[Ordinal].SetJSONValue(TJSONValue(Value.Clone), True);
  end;
end;

procedure TDBXMemoryRow.SetSingle(DbxValue: TDBXSingleValue; Value: Single);
var
  Ordinal: Integer;
begin
  Ordinal := DbxValue.ValueType.Ordinal;
  FValueRow[Ordinal].SetSingle(Value);
end;

procedure TDBXMemoryRow.SetStream(DbxValue: TDBXStreamValue;
  StreamReader: TDBXStreamReader);
var
  Ordinal: Integer;
  MemoryStream: TMemoryStream;
  Buffer: TArray<Byte>;
  BytesRead: Integer;
begin
  Ordinal := DbxValue.ValueType.Ordinal;
  if StreamReader = nil then
    FValueRow[Ordinal].SetNull
  else
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
    FValueRow[Ordinal].SetStream(MemoryStream, True);
  end;
end;

procedure TDBXMemoryRow.SetTime(DbxValue: TDBXTimeValue; Value: TDBXTime);
var
  Ordinal: Integer;
begin
  Ordinal := DbxValue.ValueType.Ordinal;
  FValueRow[Ordinal].SetTime(Value);
end;

procedure TDBXMemoryRow.SetTimestamp(DbxValue: TDBXTimeStampValue;
  var Value: TSQLTimeStamp);
var
  Ordinal: Integer;
begin
  Ordinal := DbxValue.ValueType.Ordinal;
  FValueRow[Ordinal].SetTimeStamp(Value);
end;

procedure TDBXMemoryRow.SetUInt8(DbxValue: TDBXUInt8Value; Value: Byte);
var
  Ordinal: Integer;
begin
  Ordinal := DbxValue.ValueType.Ordinal;
  FValueRow[Ordinal].SetUInt8(Value);
end;

procedure TDBXMemoryRow.SetUInt16(DbxValue: TDBXUInt16Value; Value: UInt16);
var
  Ordinal: Integer;
begin
  Ordinal := DbxValue.ValueType.Ordinal;
  FValueRow[Ordinal].SetUInt16(Value);
end;

procedure TDBXMemoryRow.SetValueType(ValueType: TDBXValueType);
begin

end;

end.
