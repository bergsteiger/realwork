{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Data.DBXJSONCommon;

interface

uses
  System.Classes,
  System.JSON,
  Data.DBXCommon,
  Data.DBXJSON;

type
  TDBXJSONTools = class
  public

    /// <summary> Returns the JSONValue equivalent of a TDBXValueType instance.
    /// </summary>
    /// <remarks>
    ///  The caller assumes the JSON object ownership
    ///
    /// </remarks>
    /// <param name="dataType">DBX value type instance, not null</param>
    /// <returns>JSON equivalent</returns>
    class function ValueTypeToJSON(const DataType: TDBXValueType): TJSONArray; static;

    /// <summary> Creates TDBXValueType out of its JSON equivalent.
    /// </summary>
    /// <remarks>
    /// </remarks>
    /// <param name="jsonArray">JSON value type representation, normally created by
    ///    valueTypeToJSON function</param>
    /// <returns>TDBXValueType instance </returns>
    class function JSONToValueType(const JsonArray: TJSONArray): TDBXValueType; static;

    /// <summary> Creates the JSON equivalent of a DBX table. The result is suitable for asynchronous
    /// </summary>
    /// <remarks> The result is suitable for asynchronous
    ///  calls and should not be used for large table. It is recommended use of Data Converters
    ///  if the table is expected to be large
    ///
    ///  The caller assumes JSON object ownership
    ///
    /// </remarks>
    /// <param name="value">DBXReader object, never null</param>
    /// <param name="RowCount">Number of rows to populate</param>
    /// <param name="isLocalConnection">true if the connection is in-process, dictates memory ownership policy</param>
    /// <returns>JSON equivalent</returns>
    class function TableToJSON(var Value: TDBXReader; const RowCount: Integer; const IsLocalConnection: Boolean): TJSONObject; static;

    /// <summary> Creates JSON representation of a DBX value.
    /// </summary>
    /// <remarks>
    ///  JSON value will most likely not carry meta-data with it hence the need for
    ///  data type.
    ///
    /// </remarks>
    /// <param name="value">DBX value, never null</param>
    /// <param name="dataType">value type</param>
    /// <param name="IsLocalConnection">true if the connection is in-process, dictates memory ownership policy</param>
    /// <returns>JSONValue</returns>
    class function DBXToJSON(const Value: TDBXValue; const DataType: Integer; const IsLocalConnection: Boolean): TJSONValue; static;

    /// <summary> Assigns DBXValue with proper content out of a JSON object. The method works
    /// </summary>
    /// <remarks> The method works
    ///  in tandem with DBXToJSON.
    ///
    ///  Supports limited implicit conversion across types. For example the string
    ///  'False' means DBX false (observe the case sensitivity). Also in DBX 'True'
    ///  means boolean true.
    ///
    /// </remarks>
    /// <param name="data">JSONValue, never null</param>
    /// <param name="value">value DBX container</param>
    /// <param name="dataType">DBX expected type</param>
    /// <param name="isLocalConnection">true if the DBX value is to be used with a local DSServer</param>
    /// <param name="OwnsJSONValue">true if the JSON value is to be automically freed when no longer is use</param>
    class procedure JSONToDBX(const Data: TJSONValue; const Value: TDBXWritableValue; const DataType: Integer; const IsLocalConnection: Boolean;
        const OwnsJSONValue: Boolean = False); overload; static;
    class procedure JSONToDBX(const Data: TJSONValue; const Value: TDBXWritableValue; const DataType: Integer; const IsLocalConnection: Boolean;
        const OwnsJSONValue: Boolean; out ACanFreeJSON: Boolean); overload; static;

    /// <summary> Assigns DBXValue with text from TSJONString. 
    /// </summary>
    /// <remarks> The method may also be used to assign a segment from a REST url.
    ///
    /// </remarks>
    /// <param name="AStringValue">string value</param>
    /// <param name="ADBXValue">value DBX container</param>
    /// <param name="ADataType">DBX expected type</param>
    class procedure JSONStringToDBX(const AStringValue: string;
      const ADBXValue: TDBXWritableValue; const ADataType: Integer); static;
    class procedure JSONNullToDBX(
      const ADBXValue: TDBXWritableValue; const ADataType: Integer); static;
    /// <summary> Creates the JSON equivalent of a DBX stream.
    /// </summary>
    /// <remarks> The result is suitable for asynchronous calls and should not be used for large streams.
    ///  The use of Data Converters is recommended if the stream is expected to be large.
    ///
    ///  The caller assumes JSON array ownership
    ///
    /// </remarks>
    /// <param name="stream">InputStream object, never null</param>
    /// <param name="offset">the zero-based index of the first byte to read from</param>
    /// <param name="byteCount">the number of bytes to limit the result to</param>
    /// <returns>JSON array equivalent of the stream</returns>
    class function StreamToJSON(const Stream: TStream; const Offset: Integer; const ByteCount: Integer): TJSONArray; static;
    /// <summary> Creates a stream from the JSON byte array provided.
    /// </summary>
    /// <param name="data">the JSON Array of bytes to create the stream from. Must not be null.</param>
    /// <returns>the Stream created from the JSON Array</returns>
    class function JSONToStream(const Data: TJSONArray): TStream; static;
  end;

const
  TABLE_PAIR = 'table';

implementation

uses
  Data.DBXCommonTable,
  Data.DBXPlatform,
  System.SysUtils,
  Data.DBXCommonResStrs
;

class function TDBXJSONTools.ValueTypeToJSON(const DataType: TDBXValueType): TJSONArray;
var
  Meta: TJSONArray;
begin
  Meta := TJSONArray.Create;
  Meta.Add(DataType.Name);
//  Meta.Add(DataType.DisplayName);
  Meta.Add(DataType.DataType);
  Meta.Add(DataType.Ordinal);
  Meta.Add(DataType.SubType);
  Meta.Add(DataType.Scale);
  Meta.Add(DataType.Size);
  Meta.Add(DataType.Precision);
  Meta.Add(DataType.ChildPosition);
//    meta.add(dataType.getValueTypeFlags());
  Meta.Add(DataType.Nullable);
  Meta.Add(DataType.Hidden);
  Meta.Add(DataType.ParameterDirection);
  Meta.Add(DataType.ValueParameter);
  Meta.Add(DataType.Literal);
  Result := Meta;
end;

class function TDBXJSONTools.JSONToValueType(const JsonArray: TJSONArray): TDBXValueType;
var
  DataType: TDBXValueType;
begin
  DataType := TDBXValueType.Create;
  DataType.Name := TJSONString(JsonArray.Items[0]).Value;
  //DataType.DisplayName := (TJSONString(JsonArray.Items[1])).Value;
  DataType.DataType := TJSONNumber(JsonArray.Items[1]).AsInt;
  DataType.Ordinal := TJSONNumber(JsonArray.Items[2]).AsInt;
  DataType.SubType := TJSONNumber(JsonArray.Items[3]).AsInt;
  DataType.Scale := TJSONNumber(JsonArray.Items[4]).AsInt;
  DataType.Size := TJSONNumber(JsonArray.Items[5]).AsInt;
  DataType.Precision := TJSONNumber(JsonArray.Items[6]).AsInt;
  DataType.ChildPosition := TJSONNumber(JsonArray.Items[7]).AsInt;
//    dataType.setValueTypeFlags(((JSONNumber)jsonArray.Items[9]).getAsInt());
  DataType.Nullable := JsonArray.Items[8] is TJSONTrue;
  DataType.Hidden := JsonArray.Items[9] is TJSONTrue;
  DataType.ParameterDirection := TJSONNumber(JsonArray.Items[10]).AsInt;
  DataType.ValueParameter := JsonArray.Items[11] is TJSONTrue;
  DataType.Literal := JsonArray.Items[12] is TJSONTrue;
  Result := DataType;
end;

class function TDBXJSONTools.TableToJSON(var Value: TDBXReader; const RowCount: Integer; const IsLocalConnection: Boolean): TJSONObject;
var
  I: Integer;
  C: Integer;
  JTable: TJSONObject;
  Count: Integer;
  JsonCols: array of TJSONArray;
  Meta: TJSONArray;
  Header: Boolean;
  JsonCell: TJSONValue;
begin
  if Value = nil then
    Exit(TJSONObject.Create);
  JTable := TJSONObject.Create;
  Count := Value.ColumnCount;
  SetLength(JsonCols,Count);
  Meta := TJSONArray.Create;
  JTable.AddPair(TABLE_PAIR, Meta);

  Header := True;
  C := RowCount;
  while Value.Next and (C > 0) do
  begin
    for I := 0 to Count - 1 do
    begin
      if Header then
      begin
        JsonCols[I] := TJSONArray.Create;
        JTable.AddPair(Value.ValueType[I].Name, JsonCols[I]);
        Meta.AddElement(ValueTypeToJSON(Value.ValueType[I]));
      end;
      JsonCell := DBXToJSON(Value.Value[I], Value.ValueType[I].DataType, IsLocalConnection);
      JsonCols[I].AddElement(JsonCell);
    end;
    Header := False;
    DecrAfter(C);
  end;
  Value.Close;
  if IsLocalConnection then
    Value.Free;
  Result := JTable;
end;

class function TDBXJSONTools.DBXToJSON(const Value: TDBXValue; const DataType: Integer; const IsLocalConnection: Boolean): TJSONValue;
var
  LReader: TDBXReader;
begin
  if Value = nil then
    Result := nil
  else if Value.IsNull then
    Result := TJSONNull.Create
  else 
    case DataType of
      TDBXDataTypes.JsonValueType:
        Result := Value.GetJSONValue(False);
      TDBXDataTypes.Int8Type,
      TDBXDataTypes.Int16Type,
      TDBXDataTypes.Int32Type,
      TDBXDataTypes.UInt16Type,
      TDBXDataTypes.UInt32Type,
      TDBXDataTypes.DoubleType,
      TDBXDataTypes.CurrencyType,
      TDBXDataTypes.BcdType:
        Result := TJSONNumber.Create(Value.AsDouble);
      TDBXDataTypes.UInt64Type,
      TDBXDataTypes.Int64Type:
        Result := TJSONNumber.Create(Value.AsInt64);
      TDBXDataTypes.SingleType:
        Result := TJSONNumber.Create(Value.AsSingle);
      TDBXDataTypes.UInt8Type:
        Result := TJSONNumber.Create(Value.AsUInt8);
      TDBXDataTypes.BooleanType:
        if Value.GetBoolean then
          Result := TJSONTrue.Create
        else 
          Result := TJSONFalse.Create;
      TDBXDataTypes.AnsiStringType,
      TDBXDataTypes.TimeStampType,
      TDBXDataTypes.WideStringType,
      TDBXDataTypes.DateType,
      TDBXDataTypes.DatetimeType,
      TDBXDataTypes.TimeType:
        Result := TJSONString.Create(Value.AsString);
      TDBXDataTypes.TableType:
        if IsLocalConnection then
        begin
          LReader := Value.GetDBXReader(False);
          Result := TableToJSON(LReader, High(Integer), IsLocalConnection);
        end
        else
        begin
          LReader := Value.GetDBXReader;
          Result := TableToJSON(LReader, High(Integer), IsLocalConnection);
        end;
      TDBXDataTypes.BlobType,
      TDBXDataTypes.BinaryBlobType:
        Result := StreamToJSON(Value.GetStream(True), 0, High(Integer));
      else
        raise TDBXError.Create(0, Format(SNoConversionToJSON, [TDBXValueType.DataTypeName(DataType)]));
    end;
end;

class procedure TDBXJSONTools.JSONStringToDBX(const AStringValue: string; const ADBXValue: TDBXWritableValue; const ADataType: Integer);

var
  BoolValue: Boolean;
begin
  case ADataType of
{$IFNDEF NEXTGEN}
    TDBXDataTypes.AnsiStringType:
      ADBXValue.SetAnsiString(AnsiString(AStringValue));
{$ELSE}
    TDBXDataTypes.AnsiStringType,
{$ENDIF !NEXTGEN}
    TDBXDataTypes.TimeStampType,
    TDBXDataTypes.WideStringType,
    TDBXDataTypes.DateType,
    TDBXDataTypes.TimeType,
    TDBXDataTypes.DatetimeType:
      ADBXValue.AsString := AStringValue;
    TDBXDataTypes.Int16Type,
    TDBXDataTypes.Int32Type,
    TDBXDataTypes.UInt16Type,
    TDBXDataTypes.UInt32Type,
    TDBXDataTypes.Int8Type,
    TDBXDataTypes.Int64Type,
    TDBXDataTypes.DoubleType,
    TDBXDataTypes.SingleType,
    TDBXDataTypes.CurrencyType,
    TDBXDataTypes.BcdType:
      if TDBXPlatform.IsBoolean(AStringValue) then
      begin
        BoolValue := StrToBool(AStringValue);
        if BoolValue then
          ADBXValue.AsDouble := 1
        else
          ADBXValue.AsDouble := 0;
      end
      else
        case ADataType of
          TDBXDataTypes.DoubleType,
          TDBXDataTypes.CurrencyType,
          TDBXDataTypes.SingleType,
          TDBXDataTypes.BcdType:
            ADBXValue.AsDouble := TDBXPlatform.JsonToFloat(AStringValue);
        else
          ADBXValue.AsString := AStringValue;
        end;
    TDBXDataTypes.BooleanType:
      ADBXValue.AsBoolean := StrToBool(AStringValue);
    TDBXDataTypes.UInt8Type:
      if TDBXPlatform.IsBoolean(AStringValue) then
      begin
        BoolValue := StrToBool(AStringValue);
        if BoolValue then
          ADBXValue.AsUInt8 := 1
        else
          ADBXValue.AsUInt8 := 0;
      end
      else
        ADBXValue.AsUInt8 := StrToInt(AStringValue);
    TDBXDataTypes.JsonValueType:
      ADBXValue.SetObjectValue(TJSONString.Create(AStringValue), True); (* Owns *)
  else
    raise TDBXError.Create(0, Format(SNoConversionToDBX, [AStringValue ,TDBXValueType.DataTypeName(ADataType)]));
  end

end;

class procedure TDBXJSONTools.JSONNullToDBX(const ADBXValue: TDBXWritableValue; const ADataType: Integer);

begin
  case ADataType of
    TDBXDataTypes.JsonValueType:
      ADBXValue.SetObjectValue(TJSONNull.Create, True); (* Owns *)
  else
    ADBXValue.SetNull;
  end

end;


class procedure TDBXJSONTools.JSONToDBX(const Data: TJSONValue; const Value: TDBXWritableValue; const DataType: Integer; const IsLocalConnection: Boolean;
  const OwnsJSONValue: Boolean);
var
  LCanFreeJSON: Boolean;
begin
  JSONToDBX(Data, Value, DataType, IsLocalConnection, OwnsJSONValue, LCanFreeJSON);
  if LCanFreeJSON then
    Data.Free;

end;

class procedure TDBXJSONTools.JSONToDBX(const Data: TJSONValue; const Value: TDBXWritableValue; const DataType: Integer; const IsLocalConnection: Boolean;
  const OwnsJSONValue: Boolean; out ACanFreeJSON: Boolean);
var
  DataToFree: TJSONValue;

  procedure SetObjectValueData;
  begin
    if DataToFree = Data then
    begin
      DataToFree := nil;
      Value.SetObjectValue(Data, True);
    end
    else
      Value.SetObjectValue(Data, False);
  end;

var
  LStream: TStream;
  LBuffer: TArray<Byte>;
  BoolValue: Boolean;
  Num: Integer;
begin
  if OwnsJSONValue then
    DataToFree := Data
  else
    DataToFree := nil;
  if Data = nil then
    Value.SetNull
  else if Data is TJSONNull then
  begin
    if DataType = TDBXDataTypes.JsonValueType then
      SetObjectValueData // Value.SetObjectValue(Data, False)
    else
      Value.SetNull;
  end
  else if Data is TJSONNumber then
    case DataType of
      TDBXDataTypes.AnsiStringType,
      TDBXDataTypes.TimeStampType,
      TDBXDataTypes.Int8Type,
      TDBXDataTypes.Int16Type,
      TDBXDataTypes.Int32Type,
      TDBXDataTypes.UInt8Type,
      TDBXDataTypes.UInt16Type,
      TDBXDataTypes.UInt32Type,
      TDBXDataTypes.Int64Type,
      TDBXDataTypes.UInt64Type,
      TDBXDataTypes.WideStringType:
        Value.AsString := (TJSONNumber(Data)).ToString;
      TDBXDataTypes.DoubleType,
      TDBXDataTypes.CurrencyType,
      TDBXDataTypes.BcdType,
      TDBXDataTypes.SingleType:
        Value.AsDouble := (TJSONNumber(Data)).AsDouble;
      TDBXDataTypes.BooleanType:
        Value.AsBoolean := (TJSONNumber(Data)).AsInt = 1;
      TDBXDataTypes.JsonValueType:
        SetObjectValueData //  Value.SetObjectValue(Data, False);
      else
        raise TDBXError.Create(0, Format(SNoConversionToDBX, [Data.ToString,TDBXValueType.DataTypeName(DataType)]));
    end
  else if Data is TJSONString then
  begin
    case DataType of
      TDBXDataTypes.JsonValueType:
        SetObjectValueData;
    else
      JSONStringToDBX(Data.Value, Value, DataType);
    end;
  end
  else if (Data is TJSONTrue) or (Data is TJSONFalse) then
  begin
    BoolValue := (Data is TJSONTrue);
    if BoolValue then
      Num := 1
    else 
      Num := 0;
    case DataType of
      TDBXDataTypes.BooleanType:
        Value.AsBoolean := BoolValue;
      TDBXDataTypes.Int8Type,
      TDBXDataTypes.Int16Type,
      TDBXDataTypes.Int32Type,
      TDBXDataTypes.Int64Type,
      TDBXDataTypes.UInt16Type,
      TDBXDataTypes.UInt32Type,
      TDBXDataTypes.UInt64Type,
      TDBXDataTypes.DoubleType,
      TDBXDataTypes.CurrencyType,
      TDBXDataTypes.BcdType,
      TDBXDataTypes.SingleType:
        Value.AsDouble := Num;
      TDBXDataTypes.UInt8Type:
        Value.AsUInt8 := Num;
      TDBXDataTypes.TimeStampType:
        Value.AsDateTime := Num;
{$IFNDEF NEXTGEN}
      TDBXDataTypes.AnsiStringType:
        Value.SetAnsiString(AnsiString((BoolToStr(BoolValue))));
{$ELSE}
      TDBXDataTypes.AnsiStringType,
{$ENDIF !NEXTGEN}
      TDBXDataTypes.WideStringType:
        Value.SetWideString(BoolToStr(BoolValue));
      TDBXDataTypes.JsonValueType:
        SetObjectValueData // Value.SetObjectValue(Data, False);
      else
        raise TDBXError.Create(0, Format(SNoConversionToDBX, [Data.ToString,TDBXValueType.DataTypeName(DataType)]));
    end;
  end
  else if Data is TJSONObject then
    case DataType of
      TDBXDataTypes.JsonValueType:
        if Value.ValueType.SubType = TDBXDataTypes.UserSubType then
          Value.SetObjectValue(TJSONValue(Data.Clone), not IsLocalConnection)
        else
          SetObjectValueData; // Value.SetObjectValue(Data, OwnsJSONValue);
      TDBXDataTypes.TableType:
      begin
        Value.SetDBXReader(TDBXJSONTableReader.Create(nil, TJSONObject(Data), OwnsJSONValue), True);
        DataToFree := nil;
      end
      else
        raise TDBXError.Create(0, Format(SNoConversionToDBX, [Data.ToString,TDBXValueType.DataTypeName(DataType)]));
    end
  else if Data is TJSONArray then
    case DataType of
      TDBXDataTypes.JsonValueType:
        SetObjectValueData; // Value.SetObjectValue(Data, OwnsJSONValue);
      TDBXDataTypes.BlobType,
      TDBXDataTypes.BinaryBlobType:
        begin
          LStream := JSONToStream(TJSONArray(Data));
          try
            SetLength(LBuffer, LStream.Size);
            if LStream.Size > 0 then    
              LStream.Read(LBuffer[0], LStream.Size);
            Value.SetDynamicBytes(0, LBuffer, 0, LStream.Size);
          finally
            LStream.Free;
          end;
        end;
      else
        raise TDBXError.Create(0, Format(SNoConversionToDBX, [Data.ToString,TDBXValueType.DataTypeName(DataType)]));
    end
  else 
    raise TDBXError.Create(0, Format(SNoJSONConversion, [Data.ToString]));
  ACanFreeJSON := DataToFree <> nil;
  Assert(not ((OwnsJSONValue = False) and ACanFreeJSON));
  Assert((DataToFree = nil) or (DataToFree = Data));
end;

class function TDBXJSONTools.JSONToStream(const Data: TJSONArray): TStream;
var
  Bytes: TArray<Byte>;
  I: Integer;
  Num: TJSONNumber;
  ByteVal: Integer;
begin
  SetLength(Bytes,Data.Count);
  for I := 0 to Data.Count - 1 do
  begin
    if Data.Items[I] is TJSONNumber then
    begin
      Num := TJSONNumber(Data.Items[I]);
      ByteVal := Num.AsInt;
      if (ByteVal >= 0) and (ByteVal <= 255) then
        Bytes[I] := Byte(ByteVal)
      else
        raise TDBXError.Create(0, SInvalidJsonStream);
    end
    else
      raise TDBXError.Create(0, SInvalidJsonStream);
  end;
  Result := TBytesStream.Create(Bytes);
end;

class function TDBXJSONTools.StreamToJSON(const Stream: TStream; const Offset: Integer; const ByteCount: Integer): TJSONArray;
var
  JArray: TJSONArray;
  Data: TArray<Byte>;
  Iterations: Integer;
  Appended: Integer;
begin
  JArray := TJSONArray.Create;
  if Stream = nil then
    Exit(JArray);
  SetLength(Data,1);
  Iterations := 0;
  Appended := 0;
  while Appended < ByteCount do
  begin
    try
      if Stream.Read(Data[0],1) > 0 then
      begin
        if Iterations >= Offset then
        begin
          JArray.Add(Integer(Data[0]));
          IncrAfter(Appended);
        end;
      end
      else 
        break;
    except
      on E: Exception do
        raise TDBXError.Create(0, E.Message, E);
    end;
    IncrAfter(Iterations);
  end;
  Result := JArray;
end;

end.
