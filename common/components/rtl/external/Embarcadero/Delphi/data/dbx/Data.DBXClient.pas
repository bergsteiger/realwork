{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

/// <summary> DBX Client </summary>

unit Data.DBXClient;

{$Z+}

interface

uses
  Data.DBXCommon,
  Data.DBXTransport,
  Data.DBXCommonTable,
  Data.DBXMessageHandlerJSonClient,
  Data.DBXStream,
  Data.DBXStreamPlatform,
  Data.DBXPlatform,
  System.Classes,
  System.SysUtils,
  Data.DBXJSONReflect,
  System.Generics.Collections
;

type
  TDBXClientDriverLoaderClass = class of TObject;
  TDBXClientConnection = class;
  TDBXClientCommand = class;
  TDBXClientDriverLoader = class(TDBXDriverLoader)
    public
      constructor Create; override;
      function Load(DriverDef: TDBXDriverDef): TDBXDriver; override;
  end;

  TDBXClientDriver = class(TDBXDriver)
    private
      function  CreateClientCommand(DbxContext: TDBXContext; Connection: TDBXConnection; MorphicCommand: TDBXCommand): TDBXCommand;
    protected
      procedure Close; override;
      function CreateConnection(ConnectionBuilder: TDBXConnectionBuilder): TDBXConnection; override;
      function CreateChannel: TDbxChannel; virtual;
    public
      constructor Create(DriverDef: TDBXDriverDef); overload; override;
      constructor Create(DriverDef: TDBXDriverDef; DriverProps: TDBXProperties); overload;
      function GetDriverVersion: string; override;
  end;

  TDBXClientTransaction = class(TDBXTransaction)
    private
      FTransactionHandle: Integer;
      constructor Create(Connection: TDBXClientConnection; IsolationLevel: TDBXIsolation; TransactionHandle: Integer);
  end;

  TDBXClientConnection = class(TDBXConnection)
    strict private
      FChannel:           TDBXChannel;
    private
      [Weak]FDriver:      TDBXClientDriver;
      FDBXConHandler:     TDBXJSonClientOutputConnectionHandler;
      [Weak]FDbxReader:   TDbxJSonStreamReader;
      [Weak]FDbxWriter:   TDbxJSonStreamWriter;
      FConnectionHandle:  Integer;
      FProductName:       string;
      FProtocolVersion:   Integer;
      FVendorProps:       TStringList;
      procedure updateIsolationLevel(IsolationLevel: TDBXIsolation);
    protected
      function  CreateAndBeginTransaction(const Isolation: TDBXIsolation): TDBXTransaction; override;
      procedure Commit(const InTransaction: TDBXTransaction); override;
      procedure Rollback(const InTransaction: TDBXTransaction); override;
      procedure SetTraceInfoEvent(const TraceInfoEvent: TDBXTraceEvent); override;
      procedure DerivedOpen; override;
      procedure DerivedGetCommandTypes(const List: TStrings); override;
      procedure DerivedGetCommands(const CommandType: string; const List: TStrings); override;
      procedure DerivedClose; override;
      function  GetProductName: string; override;
    public
      constructor Create(ConnectionBuilder: TDBXConnectionBuilder);
      destructor Destroy; override;
      function  GetVendorProperty(const Name: string): string; override;
  end;

  TDBXClientCommand = class(TDBXCommand)
    strict private
      [Weak]FDbxReader:           TDbxJSonStreamReader;
      [Weak]FDbxWriter:           TDbxJSonStreamWriter;
      FConnectionHandle:          Integer;
      FCommandHandle:             Integer;
      FRowsAffected:              Int64;
      FUpdateable:                Boolean;
      [Weak]FConnection:          TDBXClientConnection;
      FDbxReaderBuffer:           TDBXRowBuffer;
      FDBXActiveTableReaderList:  TDBXActiveTableReaderList;
      function Execute: TDBXReader;
    private
      FDbxParameterBuffer:  TDBXRowBuffer;
      FParameterTypeChange: Boolean;
      [Weak]FParameterRow:  TDBXJSonRow;
      constructor Create( DBXContext: TDBXContext;
                          Connection: TDBXClientConnection;
                          ConnectionHandle: Integer;
                          DbxReader: TDbxJSonStreamReader;
                          DbxWriter: TDbxJSonStreamWriter
                          );
    protected
      procedure SetRowSetSize(const RowSetSize: Int64); override;
      procedure SetMaxBlobSize(const MaxBlobSize: Int64); override;
      function GetRowsAffected: Int64; override;
      function CreateParameterRow: TDBXRow; override;
      function DerivedExecuteQuery: TDBXReader; override;
      procedure DerivedExecuteUpdate; override;
      procedure DerivedPrepare; override;
      procedure DerivedOpen; override;
      procedure DerivedClose; override;
      function DerivedGetNextReader: TDBXReader; override;
      procedure DerivedClearParameters; override;
      procedure SetText(const Value: string); override;
  public
      destructor Destroy; override;
      function GetJSONMarshaler: TJSONMarshal;
      function GetJSONUnMarshaler: TJSONUnMarshal;
      class procedure AddConverter(event: TConverterEvent);
      class procedure AddReverter(event: TReverterEvent);
  end;

  TDBXJSonByteReader = class(TDBXReaderByteReader)
    private
      FReaderHandle:          Integer;
      [Weak]FDbxRowBuffer:    TDBXRowBuffer;
      [Weak]FDbxClientReader: TDBXJSonReader;
    public
      constructor Create( DBXContext: TDBXContext;
                          ReaderHandle: Integer;
                          ClientReader: TDBXJSonReader;
                          DbxReader: TDbxJSonStreamReader;
                          DbxWriter: TDbxJSonStreamWriter;
                          DbxRowBuffer: TDBXRowBuffer);
      {$IFNDEF NEXTGEN}
      procedure GetAnsiString(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool); override;
      {$ENDIF}
      procedure GetWideString(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool); override;
      procedure GetUInt8(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool); override;
      procedure GetInt8(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool); override;
      procedure GetUInt16(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool); override;
      procedure GetInt16(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool); override;
      procedure GetInt32(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool); override;
      procedure GetInt64(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool); override;
      procedure GetDouble(Ordinal: TInt32; const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool); override;
  end;

  TDBXClientParameterRow = class(TDBXJSonRow)
    private
      [Weak]FDbxClientCommand: TDBXClientCommand;
    protected
      constructor Create(DBXContext: TDBXContext; ReaderHandle: Integer;
                          DbxClientCommand: TDBXClientCommand;
                          DbxStreamReader: TDbxJSonStreamReader; DbxStreamWriter: TDbxJSonStreamWriter;
                          DbxRowBuffer: TDBXRowBuffer);
      procedure SetValueType( ValueType: TDBXValueType); override;
      procedure ValueNotSet(const Value: TDBXWritableValue); override;
    public
      destructor Destroy; override;
  end;


implementation

uses
  Data.DbxSocketChannelNative,
  Data.DBXTransportFilter,
  Data.DBXMessageHandlerCommon,
  Data.DBXCommonResStrs
;

{ TDBXClientDriver }

procedure TDBXClientDriver.Close;
begin
  inherited;
end;

constructor TDBXClientDriver.Create(DriverDef: TDBXDriverDef);
begin
  inherited Create(DriverDef);
  rpr;
  // '' makes this the default command factory.
  //
  AddCommandFactory('', CreateClientCommand);

  if (DriverProperties = nil) or not DriverProperties.GetBoolean(TDBXPropertyNames.AutoUnloadDriver) then
    CacheUntilFinalization;

end;

constructor TDBXClientDriver.Create(DriverDef: TDBXDriverDef; DriverProps: TDBXProperties);
begin
  inherited Create(DriverDef);
  rpr;
  // '' makes this the default command factory.
  //
  AddCommandFactory('', CreateClientCommand);
  InitDriverProperties(DriverProps);
  if (DriverProperties = nil) or not DriverProperties.GetBoolean(TDBXPropertyNames.AutoUnloadDriver) then
    CacheUntilFinalization;

end;

function TDBXClientDriver.CreateChannel: TDbxChannel;
var
  FilterChannel: TDBXFilterSocketChannel;
begin
  if AnsiCompareText( self.DriverName, 'DataSnap' ) = 0 then
  begin
    FilterChannel := TDBXFilterSocketChannel.Create;
    FilterChannel.Channel := TDBXSocketChannel.Create;

    Result := FilterChannel;
  end
  else
  begin
    Result := TDBXSocketChannel.Create;
  end;
end;

function TDBXClientDriver.CreateClientCommand(DbxContext: TDBXContext;
  Connection: TDBXConnection; MorphicCommand: TDBXCommand): TDBXCommand;
var
  ClientConnection: TDBXClientConnection;
begin
  ClientConnection := TDBXClientConnection(Connection);
  Result := TDBXClientCommand.Create(DbxContext, ClientConnection,
                                     ClientConnection.FConnectionHandle,
                                     ClientConnection.FDbxReader,
                                     ClientConnection.FDbxWriter);
end;

function TDBXClientDriver.CreateConnection(
  ConnectionBuilder: TDBXConnectionBuilder): TDBXConnection;
var
  Connection: TDBXClientConnection;
begin
  Connection := TDBXClientConnection.Create(ConnectionBuilder);
  Connection.FDriver := Self;
  Result := Connection;
end;

function TDBXClientDriver.GetDriverVersion: string;
begin
  Result := DBXVersion40;
end;

{ TDBXClientDriverLoader }

constructor TDBXClientDriverLoader.Create;
begin
  inherited Create;
end;

function TDBXClientDriverLoader.Load(DriverDef: TDBXDriverDef): TDBXDriver;
var
  DriverUnit: string;
begin
  DriverUnit := DriverDef.FDriverProperties[TDBXPropertyNames.DriverUnit];
  if SameText(DriverUnit, 'DBXClient') or SameText(DriverUnit, 'DBXDatasnap')
    or SameText(DriverUnit, 'Data.DBXClient') or SameText(DriverUnit, 'Data.DBXDatasnap') then
    Result := TDBXClientDriver.Create(DriverDef)
  else
    Result := nil;
end;

{ TDBXClientConnection }

constructor TDBXClientConnection.Create(
  ConnectionBuilder: TDBXConnectionBuilder);
begin
  inherited Create(ConnectionBuilder);
  FVendorProps := TStringList.Create;
  FConnectionHandle := -1;
end;

procedure TDBXClientConnection.DerivedClose;
begin
  if FConnectionHandle >= 0 then
  try
    FDbxWriter.WriteDisconnectObject(FConnectionHandle);
    // Keep ASP.NET app from complaining about unhandled exception.
    // Write failes when server closes socket.
    //
    try
      FDbxWriter.Flush;
    except
    end;
    FConnectionHandle := -1;
    inherited;
  except
    // ignore eventual I/O exceptions here to free the allocated memory
  end;

  FConnectionHandle := -1;

  FreeAndNil(FChannel);
  FreeAndNil(FDBXConHandler);
end;

procedure TDBXClientConnection.Commit(const InTransaction: TDBXTransaction);
var
  Message:      TDBXTxEndMessage;
begin
  Message := FDBXConHandler.TxEndMessage;
  Message.Commit := true;
  Message.TransactionHandle := TDBXClientTransaction(InTransaction).FTransactionHandle;

  FDBXConHandler.DbxTxEnd(Message);
end;

procedure TDBXClientConnection.Rollback(const InTransaction: TDBXTransaction);
var
  Message:      TDBXTxEndMessage;
begin
  Message := FDBXConHandler.TxEndMessage;
  Message.Commit := false;
  Message.TransactionHandle := TDBXClientTransaction(InTransaction).FTransactionHandle;

  FDBXConHandler.DbxTxEnd(Message);
end;

function TDBXClientConnection.CreateAndBeginTransaction(
  const Isolation: TDBXIsolation): TDBXTransaction;
var
  Message:      TDBXTxBeginMessage;
begin
  Message := FDBXConHandler.TxBeginMessage;
  Message.IsolationLevel := Isolation;

  FDBXConHandler.DbxTxBegin(Message);

  Result := TDBXClientTransaction.Create(Self, Isolation, Message.TransactionHandle);
end;

procedure TDBXClientConnection.DerivedGetCommands(const CommandType: string;
  const List: TStrings);
const
  GetServerMethodsStr = 'DSAdmin.GetServerMethods';
  MethodAliasStr = 'MethodAlias';
var
  Command: TDBXCommand;
  MethodReader: TDBXReader;
  NameOrdinal: Integer;
begin
  if CommandType = TDBXCommandTypes.DSServerMethod then
  begin
    MethodReader := nil;
    Command := CreateCommand;
    Command.CommandType := TDBXCommandTypes.DSServerMethod;
    Command.Text := GetServerMethodsStr;
    try
      MethodReader := Command.ExecuteQuery;
      NameOrdinal := MethodReader.GetOrdinal(MethodAliasStr);
      while MethodReader.Next do
        List.Add(MethodReader.Value[NameOrdinal].GetWideString);
    finally
      FreeAndNil(MethodReader);
      FreeAndNil(Command);
    end;
  end;
end;

function TDBXClientConnection.GetProductName: string;
begin
  Result := FProductName;
end;

function TDBXClientConnection.GetVendorProperty(
  const Name: string): string;
var
  Index: Integer;
begin
  if FProtocolVersion >= TDbxJSonStreamWriter.ProtocolVersion2 then
  begin
    Index := FVendorProps.IndexOfName(Name);
    if Index > -1 then
    begin
      Result := FVendorProps.ValueFromIndex[Index];
    end else
    begin
      FDbxWriter.WriteVendorProperty(Name);

      FDbxReader.NextResultObjectStart;
      FDBXReader.Next(TDBXTokens.ArrayStartToken);
      Result := FDBXReader.ReadString;
      FDbxReader.SkipToEndOfObject;
      FVendorProps.Add(Name+'='+Result);
    end;
  end else
    inherited GetVendorProperty(Name);
end;

procedure TDBXClientConnection.DerivedGetCommandTypes(const List: TStrings);
begin
  List.Add(TDBXCommandTypes.DSServerMethod);
end;

procedure TDBXClientConnection.DerivedOpen;
var
  Complete:                   Boolean;
  BufferKBSize, Index, Token: Integer;
  Count:                      TInt32;
  Names, Values:              TWideStringArray;
  DBXRowBuffer:               TDBXRowBuffer;
  DBXInConHandler:            TDBXJSonClientInputConnectionHandler;
  LDbxReader:                 TDbxJSonStreamReader;
  LDbxWriter:                 TDbxJSonStreamWriter;
begin
  Complete := false;
  try
    FChannel := FDriver.CreateChannel();
    FChannel.DbxProperties := FConnectionProperties;
    FChannel.Open;

    BufferKBSize := FConnectionProperties.GetInteger(TDBXPropertyNames.BufferKBSize);
    if BufferKBSize < 1 then
      BufferKBSize := 32;

    LDbxReader := TDbxJSonStreamReader.Create;
    FDbxReader := LDbxReader;
    FDbxReader.DbxChannel := FChannel;
    FDbxReader.DbxContext := FDBXContext;
    FDbxReader.ReadBufferSize := BufferKBSize * 1024;
    FDbxReader.Open;

    LDbxWriter := TDbxJSonStreamWriter.Create;
    FDbxWriter := LDbxWriter;
    FDbxWriter.DbxChannel := FChannel;
    FDbxWriter.WriteBufferSize := BufferKBSize * 1024;
    FDbxWriter.Open;

    DBXRowBuffer := nil;

// A separate row buffer is allocated for each commmand, so this one should
// not be needed.
//    DbxRowBuffer := TDBXRowBuffer.Create;
//    DbxRowBuffer.Client := true;
//    DbxRowBuffer.DbxStreamReader := FDbxReader;
//    DbxRowBuffer.DbxStreamWriter := FDbxWriter;
//    DbxRowBuffer.MinBufferSize := FDBXWriter.CalcRowBufferSize;

    DBXInConHandler := TDBXJSonClientInputConnectionHandler.Create(FDBXContext, FDbxReader, FDbxWriter, DbxRowBuffer);
    FDBXConHandler := TDBXJSonClientOutputConnectionHandler.Create(FDBXContext, DBXInConHandler, FDbxReader, FDbxWriter, DbxRowBuffer);

    FDbxWriter.WriteConnectObjectStart;
    FDbxWriter.WriteParamsStart;
    Count := FConnectionProperties.Properties.Count;
    FConnectionProperties.GetLists(Names, Values);
    Index := 0;
    FDbxWriter.WriteObjectStart;
    while Index < Count do
    begin
      FDbxWriter.WriteNamedString(Names[Index], Values[Index]);
      inc(Index);
      if Index < Count then
        FDBXWriter.WriteValueSeparator;
    end;
    FDbxWriter.WriteObjectEnd;
    FDbxWriter.WriteArrayEnd;
    FDbxWriter.WriteObjectEnd;

    FDbxWriter.Flush;

    FDbxReader.NextResultObjectStart;
    FDBXReader.Next(TDBXTokens.ArrayStartToken);
    FConnectionHandle := FDBXReader.ReadInt;
    FDbxReader.Next(TDBXTokens.ValueSeparatorToken);
    FProductName := FDbxReader.ReadString;
    Token := FDbxReader.Next;
    if Token = TDBXTokens.ValueSeparatorToken then
      FProtocolVersion := FDBXReader.ReadInt;

    FDbxReader.SkipToEndOfObject;

    Complete := true;
  finally
    if not Complete then
      Close;
  end;
end;

destructor TDBXClientConnection.Destroy;
begin
  FreeAndNil(FVendorProps);
  inherited;
end;

procedure TDBXClientConnection.SetTraceInfoEvent(
  const TraceInfoEvent: TDBXTraceEvent);
begin
  inherited;

end;

procedure TDBXClientConnection.updateIsolationLevel(IsolationLevel: TDBXIsolation);
begin
  FIsolationLevel := IsolationLevel;
end;

{ TDBXClientCommand }

procedure TDBXClientCommand.DerivedClearParameters;
var
  NewCommandHandle: TDBXInt32s;
begin
  if  FDbxParameterBuffer <> nil then
  begin
    FDbxParameterBuffer.Cancel;
    SetLength(NewCommandHandle, 1);
    // This will invalidate anything that refers to the old commanhandle array.
    // Simple way to invalidate any TStreams that are kept open and un freed
    // by the app.
    //
    NewCommandHandle[0] := FCommandHandle;
    FDbxParameterBuffer.CommandHandle[0] := -1;
    FDbxParameterBuffer.CommandHandle := NewCommandHandle;

    FDBXActiveTableReaderList.CloseAllActiveTableReaders;
  end;
end;

class procedure TDBXClientCommand.AddConverter(event: TConverterEvent);
begin
  TJSONConverters.AddConverter(event);
end;

class procedure TDBXClientCommand.AddReverter(event: TReverterEvent);
begin
  TJSONConverters.AddReverter(event);
end;

constructor TDBXClientCommand.Create(DBXContext: TDBXContext;
  Connection: TDBXClientConnection;
  ConnectionHandle: Integer; DbxReader: TDbxJSonStreamReader;
  DbxWriter: TDbxJSonStreamWriter);
begin
  inherited Create(DBXContext);
  FConnectionHandle := ConnectionHandle;
  FDbxReader := DbxReader;
  FDbxWriter := DbxWriter;
  FConnection := Connection;
end;

function TDBXClientCommand.CreateParameterRow: TDBXRow;
begin
  if FDbxParameterBuffer = nil then
  begin
    FDbxParameterBuffer := TDBXRowBuffer.Create;
    FDbxParameterBuffer.Client := true;
    FDbxParameterBuffer.DbxStreamReader := FDbxReader;
    FDbxParameterBuffer.DbxStreamWriter := FDbxWriter;
    FDbxParameterBuffer.MinBufferSize := FDbxWriter.CalcRowBufferSize;
    FDbxParameterBuffer.ParameterBuffer := true;
  end;
  FDbxParameterBuffer.CommandHandle[0] := FCommandHandle;

  Assert(FDBXActiveTableReaderList = nil);
  FDBXActiveTableReaderList := TDBXActiveTableReaderList.Create;

  Result := TDBXClientParameterRow.Create(FDBXContext, FCommandHandle, Self, FDbxReader, FDbxWriter, FDbxParameterBuffer);
  FParameterRow := TDBXClientParameterRow(Result);
end;

procedure TDBXClientCommand.DerivedClose;
begin
  if (FDbxWriter <> nil) and (FCommandHandle >= 0) then
    try
      FDbxWriter.WriteCommandCloseObject(FCommandHandle);
    except
    end;
  FreeAndNil(FDBXActiveTableReaderList);
end;

function TDBXClientCommand.DerivedExecuteQuery: TDBXReader;
begin
  Result := Execute;
  // this will cause ownership to be released so that the reader will not
  // be automatically freed.
  //
  if      (Result <> nil)
      and (FParameters <> nil)
      and (FParameters.Count > 0)
      and (FParameters[FParameters.Count-1].ParameterDirection = TDBXParameterDirections.ReturnParameter)
      and (FParameters[FParameters.Count-1].Value is TDBXReaderValue) then
    FParameters[FParameters.Count-1].Value.SetDBXReader(Result, False);

end;

procedure TDBXClientCommand.DerivedExecuteUpdate;
begin
  Execute;
end;

function TDBXClientCommand.DerivedGetNextReader: TDBXReader;
var
  Message:      TDBXNextResultMessage;
begin
  if (FCommandHandle > 0) then
  begin
    Message := FConnection.FDBXConHandler.NextResultMessage;
    Message.CommandHandle := FCommandHandle;
    FConnection.FDBXConHandler.DbxNextResult(Message);
    FRowsAffected := Message.RowsAffected;
    FUpdateable := Message.Updateable;
    Result := Message.NextResult;
  end
  else
    Result := nil;
end;

procedure TDBXClientCommand.DerivedOpen;
begin
  FCommandHandle := -1; // Initialized on execute and/or prepare.
end;

procedure TDBXClientCommand.DerivedPrepare;
var
  Message:      TDBXPrepareMessage;
  I: Integer;
begin
  Message := FConnection.FDBXConHandler.PrepareMessage;
  Message.Parameters := Parameters;
  Message.CommandHandle := FCommandHandle;
  Message.CommandType := CommandType;
  Message.Command := Text;
  Message.ParameterTypeChanged := FParameterTypeChange;

  FConnection.FDBXConHandler.DbxPrepare(Message);
  for I := 0 to FParameters.Count - 1 do
    if FParameters.Parameter[I] <> nil then
      FParameters.Parameter[I].ConnectionHandler := self
    else
      break; // parameters are not existing

  FCommandHandle := Message.CommandHandle;
  if Assigned(FDbxParameterBuffer) then
    FDbxParameterBuffer.CommandHandle[0] := FCommandHandle;
  FParameterTypeChange := Message.ParameterTypeChanged;
end;

destructor TDBXClientCommand.Destroy;
begin
  FreeAndNil(FDbxReaderBuffer);
  FreeAndNil(FDbxParameterBuffer);
  FreeAndNil(FDBXActiveTableReaderList);
  inherited Destroy;
end;

function TDBXClientCommand.Execute: TDBXReader;
var
  Message: TDBXExecuteMessage;
begin
  Message := FConnection.FDBXConHandler.ExecuteMessage;
  Message.CommandHandle := FCommandHandle;
  Message.Prepared := IsPrepared;
  Message.Parameters := GetParameters;
  Message.Row := FParameterRow;
  Message.CommandType := CommandType;
  Message.Command := Text;
  Message.ActiveStreamerRowList := FDBXActiveTableReaderList;
  Message.ParameterTypeChanged := FParameterTypeChange;

  FConnection.FDBXConHandler.dbxExecute(Message);

  FRowsAffected := Message.RowsAffected;
  FCommandHandle := Message.CommandHandle;
  if Message.IsolationLevel > -1 then
    FConnection.updateIsolationLevel(Message.IsolationLevel); // Isolation level.
  FParameterTypeChange := false;
  Result := Message.ReturnReader;
  Message.ReturnReader := nil;
end;

function TDBXClientCommand.GetJSONMarshaler: TJSONMarshal;
begin
  Result := TJSONConverters.GetJSONMarshaler;
end;

function TDBXClientCommand.GetJSONUnMarshaler: TJSONUnMarshal;
begin
  Result := TJSONConverters.GetJSONUnMarshaler;
end;

function TDBXClientCommand.GetRowsAffected: Int64;
begin
  Result := FRowsAffected;
end;

procedure TDBXClientCommand.SetMaxBlobSize(const MaxBlobSize: Int64);
begin
// Ignore blob size
//  Assert(false, 'Not Implemented yet');
end;

procedure TDBXClientCommand.SetRowSetSize(const RowSetSize: Int64);
begin
//  Assert(false, 'Not Implemented yet');
end;

procedure TDBXClientCommand.SetText(const Value: string);
var
  Temp: string;
  Count: Integer;
begin
  // VCL code can some times terminate string with
  // an null.  Ok for c drivers, but not those that
  // are Delphi.
  //
  Count := Value.IndexOf(#0) + 1;
  if Count > 0 then
  begin
    Temp := Value;
    SetLength(Temp, Count-1);
    inherited SetText(Temp);
  end else
    inherited SetText(Value);
end;

{ TDBXJSonByteReader }

constructor TDBXJSonByteReader.Create(DBXContext: TDBXContext;
  ReaderHandle: Integer;
  ClientReader: TDBXJSonReader;
  DbxReader: TDbxJSonStreamReader;
  DbxWriter: TDbxJSonStreamWriter;
  DbxRowBuffer: TDBXRowBuffer);
begin
  inherited Create(DBXContext, ClientReader);
  FReaderHandle     := ReaderHandle;
  FDbxRowBuffer     := DbxRowBuffer;
  FDbxClientReader  := ClientReader;
end;

{$IFNDEF NEXTGEN}
procedure TDBXJSonByteReader.GetAnsiString(Ordinal: TInt32;
  const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool);
begin
  FDbxRowBuffer.GoToField(Ordinal);
  if FDbxRowBuffer.Null then
    IsNull := true
  else
  begin
    IsNull := false;
    FDbxRowBuffer.ReadAnsiStringBytes(FDbxClientReader.RowHandle, Value, Offset);
  end;
end;
{$ENDIF}

procedure TDBXJSonByteReader.GetDouble(Ordinal: TInt32;
  const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool);
begin
  if FDbxClientReader[Ordinal].ValueType.SubType = TDBXDataTypes.SingleType then
    inherited
  else
  begin
    FDbxRowBuffer.GoToField(Ordinal);
    if FDbxRowBuffer.Null then
      IsNull := true
    else
    begin
      IsNull := false;
      TDBXPlatform.CopyInt64(FDbxRowBuffer.ReadDoubleAsInt64, Value, 0);
    end;
  end;
end;

procedure TDBXJSonByteReader.GetInt16(Ordinal: TInt32;
  const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool);
var
  ValueObject: TDBXValue;
begin
  FDbxRowBuffer.GoToField(Ordinal);
  if FDbxRowBuffer.Null then
    IsNull := true
  else
  begin
    IsNull := false;
    ValueObject := FDbxClientReader[Ordinal];
    if ValueObject.ValueType.DataType = TDBXDataTypes.BooleanType then
    begin
      if FDbxRowBuffer.ReadBoolean then
      begin
        value[Offset]   := $FF;
        value[Offset+1] := $FF;
      end else
      begin
        value[Offset]   := 0;
        value[Offset+1] := 0;
      end;
    end else
    begin
      TDBXPlatform.CopyInt16(FDbxRowBuffer.ReadInt16, Value, 0);
    end;
  end;
end;

procedure TDBXJSonByteReader.GetInt32(Ordinal: TInt32;
  const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool);
begin
  FDbxRowBuffer.GoToField(Ordinal);
  if FDbxRowBuffer.Null then
    IsNull := true
  else
  begin
    IsNull := false;
    TDBXPlatform.CopyInt32(FDbxRowBuffer.ReadInt32, Value, 0);
  end;
end;

procedure TDBXJSonByteReader.GetInt64(Ordinal: TInt32;
  const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool);
begin
  FDbxRowBuffer.GoToField(Ordinal);
  if FDbxRowBuffer.Null then
    IsNull := true
  else
  begin
    IsNull := false;
    TDBXPlatform.CopyInt64(FDbxRowBuffer.ReadInt64, Value, 0);
  end;
end;

procedure TDBXJSonByteReader.GetInt8(Ordinal: TInt32; const Value: TArray<Byte>;
  Offset: TInt32; var IsNull: LongBool);
begin
  FDbxRowBuffer.GoToField(Ordinal);
  if FDbxRowBuffer.Null then
    IsNull := true
  else
  begin
    IsNull := false;
    TDBXPlatform.CopyInt8(FDbxRowBuffer.ReadByte, Value, 0);
  end;
end;

procedure TDBXJSonByteReader.GetUInt16(Ordinal: TInt32; const Value: TArray<Byte>;
  Offset: TInt32; var IsNull: LongBool);
var
  ValueObject: TDBXValue;
begin
  FDbxRowBuffer.GoToField(Ordinal);
  if FDbxRowBuffer.Null then
    IsNull := true
  else
  begin
    IsNull := false;
    ValueObject := FDbxClientReader[Ordinal];
    if ValueObject.ValueType.DataType = TDBXDataTypes.BooleanType then
    begin
      if FDbxRowBuffer.ReadBoolean then
      begin
        value[Offset]   := $FF;
        value[Offset+1] := $FF;
      end else
      begin
        value[Offset]   := 0;
        value[Offset+1] := 0;
      end;
    end else
    begin
      TDBXPlatform.CopyUInt16(FDbxRowBuffer.ReadInt16, Value, 0);
    end;
  end;
end;

procedure TDBXJSonByteReader.GetUInt8(Ordinal: TInt32; const Value: TArray<Byte>;
  Offset: TInt32; var IsNull: LongBool);
begin
  FDbxRowBuffer.GoToField(Ordinal);
  if FDbxRowBuffer.Null then
    IsNull := true
  else
  begin
    IsNull := false;
    TDBXPlatform.CopyUInt8(FDbxRowBuffer.ReadByte, Value, 0);
  end;
end;

procedure TDBXJSonByteReader.GetWideString(Ordinal: TInt32;
  const Value: TArray<Byte>; Offset: TInt32; var IsNull: LongBool);
begin
  FDbxRowBuffer.GoToField(Ordinal);
  if FDbxRowBuffer.Null then
    IsNull := true
  else
  begin
    IsNull := false;
    FDbxRowBuffer.ReadStringBytes(FDbxClientReader.RowHandle, Value, Offset);
  end;
end;

{ TDBXClientTransaction }

constructor TDBXClientTransaction.Create(Connection: TDBXClientConnection;
  IsolationLevel: TDBXIsolation; TransactionHandle: Integer);
begin
  inherited Create(Connection);
  FTransactionHandle := TransactionHandle;
  FIsolationLevel := IsolationLevel;
end;

{ TDBXClientParameterRow }

constructor TDBXClientParameterRow.Create(DBXContext: TDBXContext;
  ReaderHandle: Integer; DbxClientCommand: TDBXClientCommand;
  DbxStreamReader: TDbxJSonStreamReader; DbxStreamWriter: TDbxJSonStreamWriter;
  DbxRowBuffer: TDBXRowBuffer);
begin
  inherited Create(DBXContext,DBXStreamReader, DBXStreamWriter, DBXRowBuffer, false);
  FDbxClientCommand := DbxClientCommand;
end;

destructor TDBXClientParameterRow.Destroy;
begin
  if FDbxClientCommand <> nil then
    FDbxClientCommand.FParameterRow := nil;
  inherited;
end;

procedure TDBXClientParameterRow.ValueNotSet(const Value: TDBXWritableValue);
begin
  case value.ValueType.ParameterDirection of
    TDBXParameterDirections.OutParameter,
    TDBXParameterDirections.ReturnParameter:
      SetNull(Value);
    else
      FDbxContext.Error(TDBXErrorCodes.ParameterNotSet, Format(SParameterNotSet, [IntToStr(Value.ValueType.Ordinal)]), nil);
  end;
end;

procedure TDBXClientParameterRow.SetValueType(ValueType: TDBXValueType);
begin
  FDbxClientCommand.FParameterTypeChange := True;
end;

end.

