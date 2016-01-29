{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Data.DBXMessageHandlerJSonCommon;

interface

uses
  Data.DBXCommon,
  Data.DBXCommonTable,
  Data.DBXJSON,
  Data.DBXMessageHandlerCommon,
  Data.DBXStream,
  Data.DBXStreamPlatform;

type
  TDBXJSonConnectionHandler = class abstract(TDBXConnectionHandler)
  public
    constructor Create(const ADbxContext: TDBXContext; const AUsesDbxParameters: Boolean; const ADbxStreamReader: TDBXJSonStreamReader; const ADbxStreamWriter: TDBXJSonStreamWriter; const ARowBuffer: TDBXRowBuffer; const AOwnsStreamers: Boolean);
    destructor Destroy; override;
    function GetActiveTableReaderItem(const ActiveStreamerRowList: TDBXActiveTableReaderList; const CommandHandle: Integer; const RowHandle: Integer): TDBXActiveTableReaderItem;
    function CreateJSonRow(const CommandHandle: Integer; const OwnsRow: Boolean): TDBXJSonRow;
    function ReadDBXReader: TDBXReader;
    function ReadDBXReaderMetaData: TDBXJSonReader;
    procedure HandleMetadataData;
    
    /// <summary> Parse part past "metadata" from: {"metadata":{data}}
    ///  
    /// </summary>
    /// <returns>JSONObject</returns>
    function ReadMetadataData: TJSONObject;
    
    /// <summary> Parse part past "data" from: {"data":[LEN,JSONVALUE]}. If the callback failed 
    /// </summary>
    /// <remarks> If the callback failed 
    ///  with exception a DBXError is raised.
    ///  
    /// </remarks>
    /// <returns>JSONValue</returns>
    function ReadCallbackData: TJSONValue;
    procedure WriteFirst(const CommandHandle: Integer; const RowHandle: Integer; const DbxRow: TDBXJSonRow; const Value: TDBXReader; const BcdFormat: Integer);
    function WriteNext(const CommandHandle: Integer; const DbxStreamerRow: TDBXJSonRow; const Value: TDBXReader; const FirstRows: Boolean): Boolean;
    procedure WriteDBXReader(const CommandHandle: Integer; const Item: TDBXActiveTableReaderItem);
    function ReadParameter: TDBXParameter;
    procedure ReadParameters(const Message: TDBXCommandMessage);
    procedure WriteParameters(const Message: TDBXCommandMessage; const SomethingWritten: Boolean);
    
    /// <summary> Writes the JSON value into the output stream. May or may not flush the
    /// </summary>
    /// <remarks> May or may not flush the
    ///  data depending on argument.
    ///  
    /// </remarks>
    /// <param name="data">- JSON value to be serialized and stored into the output stream</param>
    /// <param name="flush">- controls the flush operation</param>
    procedure WriteCallbackData(const Data: TJSONValue; const Flush: Boolean);
    
    /// <summary> Writes the Metadata value into the output stream. May or may not flush the
    /// </summary>
    /// <remarks> May or may not flush the
    ///  data depending on argument.
    ///  
    /// </remarks>
    /// <param name="data">- JSON object of metadata to be serialized and stored into the output stream</param>
    /// <param name="flush">- controls the flush operation</param>
    procedure WriteMetadataData(const Data: TJSONObject; const Flush: Boolean);
  protected
    function IsNoDBXReaderParameterReturn(const Parameters: TDBXParameterList): Boolean;
    function IsOutputDBXReader(const Parameter: TDBXParameter): Boolean;
    function IsConnectionLost: Boolean;
  private
    function CreateRowBuffer(const CommandHandle: Integer): TDBXRowBuffer;
    function ReadValueTypes(const Context: TDBXContext; const Row: TDBXRow; const ColumnCount: Integer; const UseDbxFlags: Boolean): TDBXWritableValueArray;
    procedure FlushStreamWriterIfNeeded;
    procedure WriteParameter(const Parameter: TDBXParameter);
  protected
    FDbxStreamReader: TDBXJSonStreamReader;
    FDbxStreamWriter: TDBXJSonStreamWriter;
    FDbxRowBuffer: TDBXRowBuffer;
    FUsesDbxParameters: Boolean;
    FOwnsStreamers: Boolean;
  public
    property ConnectionLost: Boolean read IsConnectionLost;
  end;

implementation

uses
  Data.DBXPlatform,
  System.SysUtils,
  Data.DBXClientResStrs,
  Data.DBXMetadataCommon;

constructor TDBXJSonConnectionHandler.Create(const ADbxContext: TDBXContext; const AUsesDbxParameters: Boolean; const ADbxStreamReader: TDBXJSonStreamReader; const ADbxStreamWriter: TDBXJSonStreamWriter; const ARowBuffer: TDBXRowBuffer; const AOwnsStreamers: Boolean);
begin
  inherited Create(ADbxContext);
  FDbxStreamReader := ADbxStreamReader;
  FDbxStreamWriter := ADbxStreamWriter;
  FDbxRowBuffer := ARowBuffer;
  FUsesDbxParameters := AUsesDbxParameters;
  FOwnsStreamers := AOwnsStreamers;
end;

destructor TDBXJSonConnectionHandler.Destroy;
begin
  if FOwnsStreamers then
  begin
    FreeAndNil(FDbxStreamReader);
    FreeAndNil(FDbxStreamWriter);
    FreeAndNil(FDbxRowBuffer);
  end;
  inherited Destroy;
end;

function TDBXJSonConnectionHandler.IsConnectionLost: Boolean;
begin
  Result := FDbxStreamReader.ConnectionLost or FDbxStreamWriter.ConnectionLost;
end;

function TDBXJSonConnectionHandler.IsNoDBXReaderParameterReturn(const Parameters: TDBXParameterList): Boolean;
var
  Parameter: TDBXParameter;
begin
  if Parameters.Count = 1 then
  begin
    Parameter := Parameters.Parameter[0];
    if Parameter.ParameterDirection = TDBXParameterDirections.ReturnParameter then
    begin
      if Parameter.DataType = TDBXDataTypes.TableType then
        Exit(True);
    end;
  end;
  Result := False;
end;

function TDBXJSonConnectionHandler.IsOutputDBXReader(const Parameter: TDBXParameter): Boolean;
begin
  if Parameter.DataType = TDBXDataTypes.TableType then
    case Parameter.ParameterDirection of
      TDBXParameterDirections.ReturnParameter,
      TDBXParameterDirections.OutParameter,
      TDBXParameterDirections.InOutParameter:
        Exit(not Parameter.Value.IsNull);
    end;
  Result := False;
end;

function TDBXJSonConnectionHandler.CreateRowBuffer(const CommandHandle: Integer): TDBXRowBuffer;
var
  RowBuffer: TDBXRowBuffer;
  Complete: Boolean;
  Handle: TDBXInt32s;
begin
  Complete := False;
  RowBuffer := TDBXRowBuffer.Create;
  try
    RowBuffer.DbxStreamReader := FDbxStreamReader;
    RowBuffer.DbxStreamWriter := FDbxStreamWriter;
    SetLength(Handle,1);
    Handle[0] := CommandHandle;
    RowBuffer.CommandHandle := Handle;
    if (FDbxRowBuffer = nil) or FDbxRowBuffer.Client then
      RowBuffer.Client := True
    else 
      RowBuffer.Client := False;
    RowBuffer.MinBufferSize := FDbxStreamWriter.CalcRowBufferSize;
    Complete := True;
    Result := RowBuffer;
  finally
    if not Complete then
      RowBuffer.Free;
  end;
end;

function TDBXJSonConnectionHandler.GetActiveTableReaderItem(const ActiveStreamerRowList: TDBXActiveTableReaderList; const CommandHandle: Integer; const RowHandle: Integer): TDBXActiveTableReaderItem;
var
  Row: TDBXJSonRow;
  Item: TDBXActiveTableReaderItem;
begin
  Item := ActiveStreamerRowList.FindStreamerRowItem(RowHandle);
  if Item = nil then
  begin
    Row := CreateJSonRow(CommandHandle, True);
    Item := ActiveStreamerRowList.AddDBXStreamerRow(Row, RowHandle, True, False);
  end;
  Result := Item;
end;

function TDBXJSonConnectionHandler.CreateJSonRow(const CommandHandle: Integer; const OwnsRow: Boolean): TDBXJSonRow;
begin
  Result := TDBXJSonRow.Create(DBXContext, FDbxStreamReader, FDbxStreamWriter, CreateRowBuffer(CommandHandle), OwnsRow);
end;

function TDBXJSonConnectionHandler.ReadDBXReader: TDBXReader;
var
  Reader: TDBXJSonReader;
begin
  Reader := ReadDBXReaderMetaData;
  Reader.ReadFirstData;
  Result := Reader;
end;

function TDBXJSonConnectionHandler.ReadDBXReaderMetaData: TDBXJSonReader;
var
  Reader: TDBXJSonReader;
  Context: TDBXContext;
  Updateable: Boolean;
  Values: TDBXWritableValueArray;
  Row: TDBXJSonRow;
  ColumnCount: Integer;
  RowHandle: Integer;
  CommandHandle: Integer;
  BcdFormat: Integer;
  UseDbxFlags: Boolean;
begin
  Values := nil;
  RowHandle := 0;
  Row := nil;
  Updateable := False;
  CommandHandle := -1;
  Context := DBXContext;
  BcdFormat := TDBXBcdFormat.BinaryRead;
  UseDbxFlags := False;
  repeat
    case FDbxStreamReader.ReadStringCode of
      TDBXStringCodes.Fields:
        begin
          FDbxStreamReader.Next(TDBXTokens.NameSeparatorToken);
          FDbxStreamReader.Next(TDBXTokens.ArrayStartToken);
          CommandHandle := FDbxStreamReader.ReadInt;
          FDbxStreamReader.Next(TDBXTokens.ValueSeparatorToken);
          Updateable := FDbxStreamReader.ReadBoolean;
          if FDbxStreamReader.Next = TDBXTokens.ValueSeparatorToken then
          begin
            RowHandle := FDbxStreamReader.ReadInt;
            if FDbxStreamReader.Next = TDBXTokens.ValueSeparatorToken then
            begin
              BcdFormat := FDbxStreamReader.ReadInt;
              if FDbxStreamReader.Next = TDBXTokens.ValueSeparatorToken then
                UseDbxFlags := FDbxStreamReader.ReadBoolean;
            end;
          end;
        end;
      TDBXStringCodes.Columns:
        begin
          FDbxStreamReader.Next(TDBXTokens.NameSeparatorToken);
          FDbxStreamReader.Next(TDBXTokens.ArrayStartToken);
          ColumnCount := FDbxStreamReader.ReadInt;
          Row := CreateJSonRow(CommandHandle, False);
          Row.BcdFormat := BcdFormat;
          Values := ReadValueTypes(Context, Row, ColumnCount, UseDbxFlags);
        end;
    end;
    FDbxStreamReader.SkipToEndOfObject;
  until FDbxStreamReader.Next <> TDBXTokens.ValueSeparatorToken;
  FDbxStreamReader.SkipToEndOfObject;
  Row.RowHandle := RowHandle;
  Reader := TDBXJSonReader.Create(Context, Row, RowHandle, CommandHandle, Values, FDbxStreamReader, FDbxStreamWriter, Row.RowBuffer, Updateable);
  Result := Reader;
end;

procedure TDBXJSonConnectionHandler.HandleMetadataData;
var
  MetaData: TJSONObject;
begin
  MetaData := ReadMetadataData;

  {$IFNDEF J2CS}
  TInvocationMetadataDelegate.StoreMetadata(MetaData);
  MetaData := nil;
  {$ENDIF}

  MetaData.Free;
end;

function TDBXJSonConnectionHandler.ReadMetadataData: TJSONObject;
var
  Count: Integer;
  Buffer: TArray<Byte>;
  MetadataData: TJSONObject;
begin
  MetadataData := nil;
  FDbxStreamReader.Next(TDBXTokens.NameSeparatorToken);
  FDbxStreamReader.Next(TDBXTokens.ArrayStartToken);
  Count := FDbxStreamReader.ReadInt;
  FDbxStreamReader.Next(TDBXTokens.ValueSeparatorToken);
  SetLength(Buffer,Count);
  FDbxStreamReader.ReadDataBytes(Buffer, 0, Count);
  FDbxStreamReader.SkipToEndOfObject;
  try
    MetadataData := TJSONObject(TJSONObject.ParseJSONValue(Buffer, 0));
  except
  end;
  if MetadataData = nil then
    raise TDBXError.Create(TDBXErrorCodes.InvalidArgument, SMetadataParseError);
  Result := MetadataData;
end;

function TDBXJSonConnectionHandler.ReadCallbackData: TJSONValue;
var
  Count: Integer;
  Buffer: TArray<Byte>;
  CallbackParam: TJSONValue;
begin
  FDbxStreamReader.Next(TDBXTokens.ObjectStartToken);
  FDbxStreamReader.Next(TDBXTokens.StringStartToken);
  case FDbxStreamReader.ReadStringCode of
    TDBXStringCodes.Data: ;
    TDBXStringCodes.Error:
      FDbxStreamReader.ReadErrorBody;
    else
      raise TDBXError.Create(TDBXErrorCodes.CallbackError, SInvalidCallbackMessageFormat);
  end;
  FDbxStreamReader.Next(TDBXTokens.NameSeparatorToken);
  FDbxStreamReader.Next(TDBXTokens.ArrayStartToken);
  Count := FDbxStreamReader.ReadInt;
  FDbxStreamReader.Next(TDBXTokens.ValueSeparatorToken);
  SetLength(Buffer,Count);
  FDbxStreamReader.ReadDataBytes(Buffer, 0, Count);
  FDbxStreamReader.SkipToEndOfObject;
  CallbackParam := TJSONObject.ParseJSONValue(Buffer, 0);
  if CallbackParam = nil then
    raise TDBXError.Create(TDBXErrorCodes.CallbackError, SCallbackArgParseError);
  Result := CallbackParam;
end;

function TDBXJSonConnectionHandler.ReadValueTypes(const Context: TDBXContext; const Row: TDBXRow; const ColumnCount: Integer; const UseDbxFlags: Boolean): TDBXWritableValueArray;
var
  Values: TDBXWritableValueArray;
  ValueType: TDBXValueType;
  DbxReaderLocal: TDBXJSonStreamReader;
  DataType, DbxFlags, Flags, Ordinal, SubType: Integer;
begin
  DbxReaderLocal := FDbxStreamReader;
  if ColumnCount < 1 then
    Result := nil
  else 
  begin
    SetLength(Values,ColumnCount);
    for Ordinal := 0 to ColumnCount - 1 do
    begin
      DbxReaderLocal.Next(TDBXTokens.ValueSeparatorToken);
      DbxReaderLocal.Next(TDBXTokens.ArrayStartToken);
      ValueType := TDBXValueType.Create(Context);
      ValueType.Ordinal := Ordinal;
      ValueType.Name := DbxReaderLocal.ReadString;
      DbxReaderLocal.Next(TDBXTokens.ValueSeparatorToken);
      DataType := DbxReaderLocal.ReadInt;
      ValueType.DataType := DataType;
      DbxReaderLocal.Next(TDBXTokens.ValueSeparatorToken);
      SubType := DbxReaderLocal.ReadInt;
      ValueType.SubType := SubType;
      DbxReaderLocal.Next(TDBXTokens.ValueSeparatorToken);
      ValueType.Precision := DbxReaderLocal.ReadInt;
      DbxReaderLocal.Next(TDBXTokens.ValueSeparatorToken);
      ValueType.Scale := DbxReaderLocal.ReadInt;
      DbxReaderLocal.Next(TDBXTokens.ValueSeparatorToken);
      ValueType.Size := DbxReaderLocal.ReadInt;
      DbxReaderLocal.Next(TDBXTokens.ValueSeparatorToken);
      Flags := DbxReaderLocal.ReadInt;
      if UseDbxFlags then
        ValueType.ValueTypeFlags := Flags
      else 
      begin
        DbxFlags := TDBXValueTypeFlags.ExtendedType;
        if (Flags and TDBXSQLColumnFlags.FlagReadonly) <> 0 then
          DbxFlags := DbxFlags or TDBXValueTypeFlags.ReadOnly;
        if (Flags and TDBXSQLColumnFlags.FlagSearchable) <> 0 then
          DbxFlags := DbxFlags or TDBXValueTypeFlags.Searchable;
        if (Flags and TDBXSQLColumnFlags.FlagNullable) <> 0 then
          DbxFlags := DbxFlags or TDBXValueTypeFlags.Nullable;
        if (Flags and TDBXSQLColumnFlags.FlagAutoincrement) <> 0 then
          DbxFlags := DbxFlags or TDBXValueTypeFlags.Autoincrement;
        ValueType.ValueTypeFlags := DbxFlags;
      end;
      if DbxReaderLocal.Next <> TDBXTokens.ArrayEndToken then
      begin
        ValueType.ParameterDirection := DbxReaderLocal.ReadInt;
        DbxReaderLocal.SkipToEndOfArray;
      end;
      Values[Ordinal] := TDBXValue.CreateValue(Context, ValueType, Row, True);
    end;
    Result := Values;
  end;
end;

procedure TDBXJSonConnectionHandler.WriteFirst(const CommandHandle: Integer; const RowHandle: Integer; const DbxRow: TDBXJSonRow; const Value: TDBXReader; const BcdFormat: Integer);
var
  Table: TDBXReader;
  Count: Integer;
  Ordinal: Integer;
  ValueType: TDBXValueType;
begin
  Table := Value;
  Count := Table.ColumnCount;
  DbxRow.NeedsNext := False;
  FDbxStreamWriter.WriteTableObjectStart;
  FDbxStreamWriter.WriteFieldsObjectStart;
  FDbxStreamWriter.WriteInt(CommandHandle);
  FDbxStreamWriter.WriteValueSeparator;
  FDbxStreamWriter.WriteBoolean(Table.Updateable);
  FDbxStreamWriter.WriteValueSeparator;
  FDbxStreamWriter.WriteInt(RowHandle);
  FDbxStreamWriter.WriteValueSeparator;
  FDbxStreamWriter.WriteInt(BcdFormat);
  FDbxStreamWriter.WriteValueSeparator;
  FDbxStreamWriter.WriteBoolean(True);
  FDbxStreamWriter.WriteArrayEnd;
  FDbxStreamWriter.WriteObjectEnd;
  FDbxStreamWriter.WriteValueSeparator;
  FDbxStreamWriter.WriteColumnsObjectStart;
  FDbxStreamWriter.WriteInt(Count);
  if Count > 0 then
  begin
    FDbxStreamWriter.WriteValueSeparator;
    Ordinal := 0;
    while True do
    begin
      ValueType := Table.ValueType[Ordinal];
      FDbxStreamWriter.WriteArrayStart;
      FDbxStreamWriter.WriteString(ValueType.Name);
      FDbxStreamWriter.WriteValueSeparator;
      FDbxStreamWriter.WriteInt(ValueType.DataType);
      FDbxStreamWriter.WriteValueSeparator;
      FDbxStreamWriter.WriteInt(ValueType.SubType);
      FDbxStreamWriter.WriteValueSeparator;
      FDbxStreamWriter.WriteLong(ValueType.Precision);
      FDbxStreamWriter.WriteValueSeparator;
      FDbxStreamWriter.WriteInt(ValueType.Scale);
      FDbxStreamWriter.WriteValueSeparator;
      FDbxStreamWriter.WriteInt(ValueType.Size);
      FDbxStreamWriter.WriteValueSeparator;
      FDbxStreamWriter.WriteInt(ValueType.ValueTypeFlags);
      FDbxStreamWriter.WriteValueSeparator;
      FDbxStreamWriter.WriteInt(ValueType.ParameterDirection);
      FDbxStreamWriter.WriteArrayEnd;
      Inc(Ordinal);
      if Ordinal < Count then
        FDbxStreamWriter.WriteValueSeparator
      else 
        break;
    end;
  end;
  FDbxStreamWriter.WriteArrayEnd;
  FDbxStreamWriter.WriteObjectEnd;
  FDbxStreamWriter.WriteArrayEnd;
  FDbxStreamWriter.WriteObjectEnd;
end;

procedure TDBXJSonConnectionHandler.FlushStreamWriterIfNeeded;
var
  Buffer: TArray<Byte>;
  SizeOff: Integer;
begin
  Buffer := FDbxStreamWriter.Buffer;
  SizeOff := FDbxStreamWriter.BufferPosition;
  if (Length(Buffer) - SizeOff) < 128 then
    FDbxStreamWriter.Flush;
end;

function TDBXJSonConnectionHandler.WriteNext(const CommandHandle: Integer; const DbxStreamerRow: TDBXJSonRow; const Value: TDBXReader; const FirstRows: Boolean): Boolean;
var
  HasRows: Boolean;
  Table: TDBXReader;
  RowBuffer: TDBXRowBuffer;
  MinBufSize: Integer;
  ColumnCount: Integer;
  Ordinal: Integer;
  BytesWritten: Integer;
begin
  HasRows := True;
  Table := Value;
  RowBuffer := DbxStreamerRow.RowBuffer;
  MinBufSize := RowBuffer.MinBufferSize;
  if FirstRows and not Table.Next then
  begin
    FDbxStreamWriter.WriteDataObjectStart;
    FDbxStreamWriter.WriteInt(0);
    FDbxStreamWriter.WriteArrayEnd;
    FDbxStreamWriter.WriteObjectEnd;
    Exit(True);
  end;
  FlushStreamWriterIfNeeded;
  RowBuffer.Post;
  if DbxStreamerRow.NeedsNext then
  begin
    DbxStreamerRow.NeedsNext := False;
    HasRows := Table.Next;
  end;
  ColumnCount := Table.ColumnCount;
  try
    while HasRows and (RowBuffer.offset < MinBufSize) do
    begin
      for ordinal := 0 to ColumnCount - 1 do
        TDBXDriverHelp.CopyRowValue(Table.Value[Ordinal], DbxStreamerRow);
      if RowBuffer.offset < MinBufSize then
        HasRows := Table.Next
      else 
        DbxStreamerRow.NeedsNext := True;
    end;
  except
    on Ex: Exception do
    begin
      RowBuffer.Cancel;
      raise TDBXError.Create(TDBXErrorCodes.InvalidOperation, Ex.Message, Ex);
    end;
  end;
  if FDbxStreamWriter <> nil then
  begin
    BytesWritten := RowBuffer.offset;
    FDbxStreamWriter.WriteDataObjectStart;
    if HasRows then
      FDbxStreamWriter.WriteInt(BytesWritten)
    else 
      FDbxStreamWriter.WriteInt(-BytesWritten);
    FDbxStreamWriter.WriteValueSeparator;
    FDbxStreamWriter.WriteDataBytes(RowBuffer.buf, 0, RowBuffer.offset);
    RowBuffer.Post;
    FDbxStreamWriter.WriteArrayEnd;
    FDbxStreamWriter.WriteObjectEnd;
  end;
  Result := not HasRows;
end;

procedure TDBXJSonConnectionHandler.WriteDBXReader(const CommandHandle: Integer; const Item: TDBXActiveTableReaderItem);
var
  DbxJSonRow: TDBXJSonRow;
begin
  DbxJSonRow := TDBXJSonRow(Item.StreamerRow);
  WriteFirst(CommandHandle, DbxJSonRow.RowHandle, DbxJSonRow, Item.Reader, DbxJSonRow.BcdFormat);
  Item.ReaderEos := WriteNext(CommandHandle, DbxJSonRow, Item.Reader, True);
end;

function TDBXJSonConnectionHandler.ReadParameter: TDBXParameter;
var
  Parameter: TDBXParameter;
begin
  Parameter := TDBXParameter.Create(DBXContext);
  FDbxStreamReader.Next(TDBXTokens.ArrayStartToken);
  Parameter.DataType := FDbxStreamReader.ReadInt;
  FDbxStreamReader.NextValueSeparator;
  Parameter.SubType := FDbxStreamReader.ReadInt;
  FDbxStreamReader.NextValueSeparator;
  Parameter.ParameterDirection := FDbxStreamReader.ReadInt;
  FDbxStreamReader.NextValueSeparator;
  Parameter.Precision := FDbxStreamReader.ReadLong;
  FDbxStreamReader.NextValueSeparator;
  Parameter.Scale := FDbxStreamReader.ReadInt;
  FDbxStreamReader.NextValueSeparator;
  Parameter.Name := FDbxStreamReader.ReadString;
  FDbxStreamReader.NextValueSeparator;
  Parameter.ChildPosition := FDbxStreamReader.ReadInt;
  FDbxStreamReader.NextValueSeparator;
  Parameter.Size := FDbxStreamReader.ReadInt;
  //Size of 0 is never valid for string types.  
  //Use precision as the size value if it is nonzero in this case to prevent invalid memory writes
  if (Parameter.Size = 0) and 
     (Parameter.DataType in [TDBXDataTypes.AnsiStringType, TDBXDataTypes.WideStringType]) then
  begin
    if (Parameter.ParameterDirection in 
      [TDBXParameterDirections.OutParameter,
       TDBXParameterDirections.InOutParameter,
       TDBXParameterDirections.ReturnParameter
      ]) then
    begin
      if Parameter.Precision <> 0 then
        Parameter.Size := Parameter.Precision;
    end;
  end;
  if FDbxStreamReader.Next = TDBXTokens.ValueSeparatorToken then
  begin
    Parameter.ValueTypeFlags := FDbxStreamReader.ReadInt;
    if Parameter.Literal then
    begin
      FDbxStreamReader.NextValueSeparator;
      Parameter.Value.SetWideString(FDbxStreamReader.ReadString);
    end;
    ;
    FDbxStreamReader.SkipToEndOfArray;
  end;
  ;
  Parameter.ValueTypeFlags := Parameter.ValueTypeFlags or TDBXValueTypeFlags.ExtendedType;
  Result := Parameter;
end;

procedure TDBXJSonConnectionHandler.ReadParameters(const Message: TDBXCommandMessage);
var
  ParameterCount: Integer;
  Ordinal: Integer;
  Parameter: TDBXParameter;
  Parameters: TDBXParameterList;
  ExistingParameterCount: Integer;
begin
  Parameters := Message.Parameters;
  if Parameters = nil then
    Parameters := Message.ExplicitParameters;
  FDbxStreamReader.Next(TDBXTokens.NameSeparatorToken);
  FDbxStreamReader.Next(TDBXTokens.ArrayStartToken);
  try
    ParameterCount := FDbxStreamReader.ReadInt;
    if ParameterCount > 0 then
    begin
      ExistingParameterCount := Parameters.Count;
      if ExistingParameterCount = 0 then
        Parameters.Count := ParameterCount;
      if FDbxStreamReader.Next = TDBXTokens.ValueSeparatorToken then
        for ordinal := 0 to ParameterCount - 1 do
        begin
          if Ordinal <> 0 then
            FDbxStreamReader.NextValueSeparator;
          Parameter := ReadParameter;
          if ExistingParameterCount = 0 then
          begin
            Parameters.SetParameter(Ordinal, Parameter);
            if FUsesDbxParameters then
              TDBXDriverHelp.UpdateParameterType(Parameter);
          end
          else 
            Parameter.Free;
        end;
      if ExistingParameterCount = 0 then
        Message.ParameterTypeChanged := False;
    end;
  finally
    FDbxStreamReader.SkipToEndOfObject;
  end;
end;

procedure TDBXJSonConnectionHandler.WriteParameter(const Parameter: TDBXParameter);
var
  StreamWriter: TDBXJSonStreamWriter;
begin
  StreamWriter := FDbxStreamWriter;
  StreamWriter.WriteValueSeparator;
  StreamWriter.WriteArrayStart;
  StreamWriter.WriteInt(Parameter.DataType);
  StreamWriter.WriteValueSeparator;
  StreamWriter.WriteInt(Parameter.SubType);
  StreamWriter.WriteValueSeparator;
  StreamWriter.WriteInt(Parameter.ParameterDirection);
  StreamWriter.WriteValueSeparator;
  StreamWriter.WriteLong(Parameter.Precision);
  StreamWriter.WriteValueSeparator;
  StreamWriter.WriteInt(Parameter.Scale);
  StreamWriter.WriteValueSeparator;
  StreamWriter.WriteString(Parameter.Name);
  StreamWriter.WriteValueSeparator;
  StreamWriter.WriteInt(Parameter.ChildPosition);
  StreamWriter.WriteValueSeparator;
  StreamWriter.WriteInt(Parameter.Size);
  StreamWriter.WriteValueSeparator;
  StreamWriter.WriteInt(Parameter.ValueTypeFlags);
  if Parameter.Literal then
  begin
    StreamWriter.WriteValueSeparator;
    StreamWriter.WriteString(Parameter.Value.GetWideString);
  end;
  StreamWriter.WriteArrayEnd;
end;

procedure TDBXJSonConnectionHandler.WriteParameters(const Message: TDBXCommandMessage; const SomethingWritten: Boolean);
var
  Parameters: TDBXParameterList;
  ParamListCount: Integer;
  Ordinal: Integer;
begin
  Parameters := Message.Parameters;
  ParamListCount := Parameters.Count;
  if ParamListCount > 0 then
  begin
    if SomethingWritten then
      FDbxStreamWriter.WriteValueSeparator;
    FDbxStreamWriter.WriteParametersObjectStart(ParamListCount);
    if Parameters.Parameter[0] <> nil then
      for ordinal := 0 to ParamListCount - 1 do
        WriteParameter(Parameters.Parameter[Ordinal]);
    FDbxStreamWriter.WriteArrayEnd;
    FDbxStreamWriter.WriteObjectEnd;
    Message.ParameterTypeChanged := False;
  end;
end;

procedure TDBXJSonConnectionHandler.WriteCallbackData(const Data: TJSONValue; const Flush: Boolean);
begin
  FDbxStreamWriter.WriteCallback(Data);
  if Flush then
    FDbxStreamWriter.Flush;
end;

procedure TDBXJSonConnectionHandler.WriteMetadataData(const Data: TJSONObject; const Flush: Boolean);
begin
  FDbxStreamWriter.WriteMetadata(Data);
  if Flush then
    FDbxStreamWriter.Flush;
end;

end.
