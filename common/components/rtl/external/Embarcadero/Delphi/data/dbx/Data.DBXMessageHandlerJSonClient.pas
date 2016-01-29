{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Data.DBXMessageHandlerJSonClient;

interface

uses
  Data.DBXCommon,
  Data.DBXCommonTable,
  Data.DBXJSON,
  Data.DBXMessageHandlerCommon,
  Data.DBXMessageHandlerJSonCommon,
  Data.DBXStream;

type
  TDBXJSonClientInputConnectionHandler = class(TDBXJSonConnectionHandler)
  public
    constructor Create(const ADbxContext: TDBXContext; const ADbxStreamReader: TDBXJSonStreamReader; const ADbxStreamWriter: TDBXJSonStreamWriter; const ARowBuffer: TDBXRowBuffer);
    function AcquireCommandHandler(const Message: TDBXCommandMessage): TDBXCommandHandler; override;
    function DbxBeforeRequest: Boolean; override;
    procedure DbxConnect(const Message: TDBXConnectMessage); override;
    procedure DbxDisconnect(const Message: TDBXDisconnectMessage); override;
    procedure DbxOpen(const Message: TDBXOpenMessage); override;
    procedure DbxTxBegin(const Message: TDBXTxBeginMessage); override;
    procedure DbxTxEnd(const Message: TDBXTxEndMessage); override;
    procedure DbxVendorProperty(const Message: TDBXVendorPropertyMessage); override;
    procedure DbxCommandClose(const Message: TDBXCommandCloseMessage); override;
    procedure DbxErrorMessage(const Message: TDBXErrorMessage); override;
    procedure DbxExecute(const Message: TDBXExecuteMessage); override;
    procedure DbxMoreBlob(const Message: TDBXMoreBlobMessage); override;
    procedure DbxNext(const Message: TDBXNextMessage); override;
    procedure DbxNextResult(const Message: TDBXNextResultMessage); override;
    procedure DbxPrepare(const Message: TDBXPrepareMessage); override;
    procedure DbxReaderClose(const Message: TDBXReaderCloseMessage); override;
  protected
    function GetProductName: string; override;
  private
    procedure HandleParameterMoreBlobRequest(const Parameters: TDBXParameterList);
    
    /// <summary> Client receives a callback request. It retrieves the parameter ordinal and the 
    /// </summary>
    /// <remarks> It retrieves the parameter ordinal and the 
    ///  input JSON object and performs the call. The JSON response is returned
    ///  immediately.
    ///   
    /// </remarks>
    /// <param name="parameters">- parameters list</param>
    procedure HandleCallbackRequest(const Parameters: TDBXParameterList);
    procedure HandleParameterNextRequest(const Message: TDBXExecuteMessage);
    function InvokeClientCallback(argType: Integer; Parameter: TDBXParameter; rawInput: TJSONValue): TJSONValue;
    function FindNextReaderOrdinal(const Parameters: TDBXParameterList; const InLastReaderOrdinal: Integer): Integer;
  end;

  TDBXJSonClientOutputConnectionHandler = class(TDBXJSonConnectionHandler)
  public
    constructor Create(const ADbxContext: TDBXContext; const ANextHandler: TDBXConnectionHandler; const ADbxStreamReader: TDBXJSonStreamReader; const ADbxStreamWriter: TDBXJSonStreamWriter; const ARowBuffer: TDBXRowBuffer);
    destructor Destroy; override;
    function AcquireCommandHandler(const Message: TDBXCommandMessage): TDBXCommandHandler; override;
    function DbxBeforeRequest: Boolean; override;
    procedure DbxConnect(const Message: TDBXConnectMessage); override;
    procedure DbxDisconnect(const Message: TDBXDisconnectMessage); override;
    procedure DbxOpen(const Message: TDBXOpenMessage); override;
    procedure DbxTxBegin(const Message: TDBXTxBeginMessage); override;
    procedure DbxTxEnd(const Message: TDBXTxEndMessage); override;
    procedure DbxVendorProperty(const Message: TDBXVendorPropertyMessage); override;
    procedure DbxCommandClose(const Message: TDBXCommandCloseMessage); override;
    procedure DbxErrorMessage(const Message: TDBXErrorMessage); override;
    procedure DbxExecute(const Message: TDBXExecuteMessage); override;
    procedure DbxMoreBlob(const Message: TDBXMoreBlobMessage); override;
    procedure DbxNext(const Message: TDBXNextMessage); override;
    procedure DbxNextResult(const Message: TDBXNextResultMessage); override;
    procedure DbxPrepare(const Message: TDBXPrepareMessage); override;
    procedure DbxReaderClose(const Message: TDBXReaderCloseMessage); override;
  protected
    function GetProductName: string; override;
  private
    procedure WriteInputStreamerParameters(const CommandHandle: Integer; const StreamerRow: TDBXStreamerRow; const ActiveStreamerList: TDBXActiveTableReaderList; const Parameters: TDBXParameterList; const DataWritten: Boolean);
  private
    FCommandCloseMessage: TDBXCommandCloseMessage;
    FConnectMessage: TDBXConnectMessage;
    FDisconnectMessage: TDBXDisconnectMessage;
    FExecuteMessage: TDBXExecuteMessage;
    FMoreBlobMessage: TDBXMoreBlobMessage;
    FNextMessage: TDBXNextMessage;
    FNextResultMessage: TDBXNextResultMessage;
    FPrepareMessage: TDBXPrepareMessage;
    FReaderCloseMessage: TDBXReaderCloseMessage;
    FTxBeginMessage: TDBXTxBeginMessage;
    FTxEndMessage: TDBXTxEndMessage;
    FVendorProperMessage: TDBXVendorPropertyMessage;
    FErrorMessage: TDBXErrorMessage;
    FNextHandler: TDBXConnectionHandler;
  public
    property CommandCloseMessage: TDBXCommandCloseMessage read FCommandCloseMessage write FCommandCloseMessage;
    property ConnectMessage: TDBXConnectMessage read FConnectMessage write FConnectMessage;
    property DisconnectMessage: TDBXDisconnectMessage read FDisconnectMessage write FDisconnectMessage;
    property ExecuteMessage: TDBXExecuteMessage read FExecuteMessage write FExecuteMessage;
    property MoreBlobMessage: TDBXMoreBlobMessage read FMoreBlobMessage write FMoreBlobMessage;
    property NextMessage: TDBXNextMessage read FNextMessage write FNextMessage;
    property NextResultMessage: TDBXNextResultMessage read FNextResultMessage write FNextResultMessage;
    property PrepareMessage: TDBXPrepareMessage read FPrepareMessage write FPrepareMessage;
    property ReaderCloseMessage: TDBXReaderCloseMessage read FReaderCloseMessage write FReaderCloseMessage;
    property TxBeginMessage: TDBXTxBeginMessage read FTxBeginMessage write FTxBeginMessage;
    property TxEndMessage: TDBXTxEndMessage read FTxEndMessage write FTxEndMessage;
    property VendorProperMessage: TDBXVendorPropertyMessage read FVendorProperMessage write FVendorProperMessage;
    property ErrorMessage: TDBXErrorMessage read FErrorMessage write FErrorMessage;
  end;

implementation

uses
  Data.DBXClient,
  Data.DBXJSONReflect,
  Data.DBXPlatform,
  Data.DBXStreamPlatform,
  System.SysUtils,
  Data.DBXClientResStrs
{$IFNDEF J2CS}
  , Data.DBXMetadataCommon
{$ENDIF}
;

constructor TDBXJSonClientInputConnectionHandler.Create(const ADbxContext: TDBXContext; const ADbxStreamReader: TDBXJSonStreamReader; const ADbxStreamWriter: TDBXJSonStreamWriter; const ARowBuffer: TDBXRowBuffer);
begin
  inherited Create(ADbxContext, True, ADbxStreamReader, ADbxStreamWriter, ARowBuffer, False);
end;

function TDBXJSonClientInputConnectionHandler.AcquireCommandHandler(const Message: TDBXCommandMessage): TDBXCommandHandler;
begin
  Result := nil;
end;

function TDBXJSonClientInputConnectionHandler.DbxBeforeRequest: Boolean;
begin
  Result := False;
end;

procedure TDBXJSonClientInputConnectionHandler.DbxConnect(const Message: TDBXConnectMessage);
begin
end;

procedure TDBXJSonClientInputConnectionHandler.DbxDisconnect(const Message: TDBXDisconnectMessage);
begin
end;

procedure TDBXJSonClientInputConnectionHandler.DbxOpen(const Message: TDBXOpenMessage);
begin
end;

procedure TDBXJSonClientInputConnectionHandler.DbxTxBegin(const Message: TDBXTxBeginMessage);
begin
  Message.TransactionHandle := FDbxStreamReader.ReadIntResultObject;
end;

procedure TDBXJSonClientInputConnectionHandler.DbxTxEnd(const Message: TDBXTxEndMessage);
begin
  FDbxStreamReader.NextResultObjectStart;
  FDbxStreamReader.SkipToEndOfObject;
end;

procedure TDBXJSonClientInputConnectionHandler.DbxVendorProperty(const Message: TDBXVendorPropertyMessage);
begin
end;

function TDBXJSonClientInputConnectionHandler.GetProductName: string;
begin
  Result := NullString;
end;

procedure TDBXJSonClientInputConnectionHandler.DbxCommandClose(const Message: TDBXCommandCloseMessage);
begin
end;

procedure TDBXJSonClientInputConnectionHandler.DbxErrorMessage(const Message: TDBXErrorMessage);
begin
end;

procedure TDBXJSonClientInputConnectionHandler.HandleParameterMoreBlobRequest(const Parameters: TDBXParameterList);
var
  Ordinal: Integer;
  RowHandle: Integer;
  ParamHandle: Integer;
  Value: TDBXValue;
  ReaderValue: TDBXReaderValue;
  Parameter: TDBXParameter;
  ParameterOrdinal: Integer;
begin
  FDbxStreamReader.Next(TDBXTokens.NameSeparatorToken);
  FDbxStreamReader.Next(TDBXTokens.ArrayStartToken);
  FDbxStreamReader.ReadInt;
  FDbxStreamReader.NextValueSeparator;
  FDbxStreamReader.ReadInt;
  FDbxStreamReader.NextValueSeparator;
  FDbxStreamReader.ReadLong;
  FDbxStreamReader.NextValueSeparator;
  Ordinal := FDbxStreamReader.ReadInt;
  FDbxStreamReader.NextValueSeparator;
  RowHandle := FDbxStreamReader.ReadInt;
  FDbxStreamReader.SkipToEndOfObject;
  Value := nil;
  ParamHandle := 0;
  for parameterOrdinal := 0 to Parameters.Count - 1 do
  begin
    Parameter := Parameters.Parameter[ParameterOrdinal];
    if Parameter.DataType = TDBXDataTypes.TableType then
    begin
      case Parameter.ParameterDirection of
        TDBXParameterDirections.InOutParameter,
        TDBXParameterDirections.InParameter:
          ParamHandle := ParamHandle + 1;
      end;
      if ParamHandle = RowHandle then
      begin
        ReaderValue := TDBXReaderValue(Parameter.Value);
        Value := ReaderValue.GetDBXReader.Value[Ordinal];
        break;
      end;
    end;
  end;
  if Value = nil then
    Value := Parameters.Parameter[Ordinal].Value;
  FDbxStreamWriter.WriteDataObject(TDBXDriverHelp.GetStreamReader(Value));
end;

procedure TDBXJSonClientInputConnectionHandler.HandleCallbackRequest(const Parameters: TDBXParameterList);
var
  ArgType, Count: Integer;
  Buffer: TArray<Byte>;
  CallbackParam, OutputArg: TJSONValue;
  Parameter: TDBXParameter;
begin
  OutputArg := nil;
  FDbxStreamReader.Next(TDBXTokens.NameSeparatorToken);
  FDbxStreamReader.Next(TDBXTokens.ArrayStartToken);
  Count := FDbxStreamReader.ReadInt;
  FDbxStreamReader.NextValueSeparator;
  SetLength(Buffer,Count);
  FDbxStreamReader.ReadDataBytes(Buffer, 0, Count);
  FDbxStreamReader.SkipToEndOfObject;
  try
    CallbackParam := TJSONObject.ParseJSONValue(Buffer, 0);
    if CallbackParam = nil then
      raise TDBXError.Create(TDBXErrorCodes.CallbackError, SCallbackBadInput);
    try
      Count := StrToInt((TJSONNumber((TJSONArray(CallbackParam)).Get(0))).Value);
      ArgType := (TJSONNumber((TJSONArray(CallbackParam)).Get(1))).AsInt;
      Parameter := Parameters.Parameter[Count];
      if (Parameter = nil) or (Parameter.DataType <> TDBXDataTypes.CallbackType) then
        raise TDBXError.Create(TDBXErrorCodes.CallbackError, SBadCallbackParameter);
      OutputArg := InvokeClientCallback(ArgType, Parameter, (TJSONArray(CallbackParam)).Get(2));
    finally
      CallbackParam.Free;
    end;
    if OutputArg = nil then
      OutputArg := TJSONNull.Create;
    try
      FDbxStreamWriter.WriteCallbackResponse(OutputArg);
    finally
      OutputArg.Free;
    end;
  except
    on Ex: Exception do
      FDbxStreamWriter.WriteRpcError(TDBXPlatform.GetClassName(Ex), 0, Ex.Message, nil);
  end;
  FDbxStreamWriter.Flush;
end;

procedure TDBXJSonClientInputConnectionHandler.HandleParameterNextRequest(const Message: TDBXExecuteMessage);
var
  CommandHandle: Integer;
  RowHandle: Integer;
  List: TDBXActiveTableReaderList;
  Item: TDBXActiveTableReaderItem;
begin
  FDbxStreamReader.Next(TDBXTokens.NameSeparatorToken);
  FDbxStreamReader.Next(TDBXTokens.ArrayStartToken);
  RowHandle := FDbxStreamReader.ReadInt;
  FDbxStreamReader.NextValueSeparator;
  FDbxStreamReader.ReadLong;
  FDbxStreamReader.NextValueSeparator;
  CommandHandle := FDbxStreamReader.ReadInt;
  FDbxStreamReader.SkipToEndOfObject;
  List := Message.ActiveStreamerRowList;
  Item := List.FindStreamerRowItem(RowHandle);
  WriteNext(CommandHandle, TDBXJSonRow(Item.StreamerRow), Item.Reader, False);
  FDbxStreamWriter.Flush;
end;

function TDBXJSonClientInputConnectionHandler.InvokeClientCallback(argType: Integer;
                     Parameter: TDBXParameter; rawInput: TJSONValue): TJSONValue;
var
  Marshal: TJSONMarshal;
  UnMarshal: TJSONUnMarshal;
  InputObj, Data: TObject;
begin
  if argType = TDBXCallback.ArgJson then
    exit(TDBXCallbackValue(parameter.Value).GetCallbackValue.Execute(rawInput))
  else
  begin
    UnMarshal := TDBXClientCommand(Parameter.ConnectionHandler).GetJSONUnMarshaler;
    InputObj := nil;
    try
      InputObj := UnMarshal.UnMarshal(rawInput);
      Data := TDBXCallbackValue(parameter.Value).GetCallbackValue.Execute(InputObj);
      Marshal := TDBXClientCommand(Parameter.ConnectionHandler).GetJSONMarshaler;
      try
        exit(Marshal.Marshal(Data));
      finally
        Data.Free;
        Marshal.Free;
      end;
    finally
      InputObj.Free;
      UnMarshal.Free;
    end;
  end;
end;

function TDBXJSonClientInputConnectionHandler.FindNextReaderOrdinal(const Parameters: TDBXParameterList; const InLastReaderOrdinal: Integer): Integer;
var
  Count: Integer;
  LastReaderOrdinal: Integer;
begin
  Count := Parameters.Count;
  LastReaderOrdinal := InLastReaderOrdinal + 1;
  if IsNoDBXReaderParameterReturn(Parameters) then
    Exit(0);
  while LastReaderOrdinal < Count do
  begin
    if IsOutputDBXReader(Parameters.Parameter[LastReaderOrdinal]) then
      Exit(LastReaderOrdinal);
    LastReaderOrdinal := LastReaderOrdinal + 1;
  end;
  if (InLastReaderOrdinal < 0) and (LastReaderOrdinal = Count) then
    Exit(InLastReaderOrdinal);
  raise TDBXError.Create(TDBXErrorCodes.InvalidOperation, SNotEnoughReaders);
end;

procedure TDBXJSonClientInputConnectionHandler.DbxExecute(const Message: TDBXExecuteMessage);
var
  ParameterRow: TDBXJSonRow;
  ParameterRowBuffer: TDBXRowBuffer;
  NeedsPrepare: Boolean;
  Parameter: TDBXParameter;
  Parameters: TDBXParameterList;
  ClientReader: TDBXReader;
  FirstReaderOrdinal: Integer;
  LastReaderOrdinal: Integer;
  FirstToken: Boolean;
  Ordinal: Integer;
begin
  NeedsPrepare := False;
  Parameters := Message.Parameters;
  Message.IsolationLevel := -1;
  Message.RowsAffected := -1;
  repeat
    FDbxStreamReader.Next(TDBXTokens.ObjectStartToken);
    FDbxStreamReader.Next(TDBXTokens.StringStartToken);
    case FDbxStreamReader.ReadStringCode of
      TDBXStringCodes.MoreBlob:
        HandleParameterMoreBlobRequest(Parameters);
      TDBXStringCodes.Next:
        HandleParameterNextRequest(Message);
      TDBXStringCodes.Result:;
      TDBXStringCodes.Error:
        FDbxStreamReader.ReadErrorBody;
      TDBXStringCodes.Callback:
        HandleCallbackRequest(Parameters);
      TDBXStringCodes.Metadata:
        HandleMetadataData;
    end;
  until FDbxStreamReader.StringCode = TDBXStringCodes.Result;
  FDbxStreamReader.Next(TDBXTokens.NameSeparatorToken);
  FDbxStreamReader.Next(TDBXTokens.ArrayStartToken);
  ClientReader := nil;
  FirstReaderOrdinal := -1;
  LastReaderOrdinal := -1;
  if FDbxStreamReader.Next = TDBXTokens.ObjectStartToken then
  begin
    try
      FirstToken := True;
      repeat
        if FirstToken then
          FirstToken := False
        else 
          FDbxStreamReader.Next(TDBXTokens.ObjectStartToken);
        FDbxStreamReader.Next(TDBXTokens.StringStartToken);
        case FDbxStreamReader.ReadStringCode of
          TDBXStringCodes.Handle:
            begin
              FDbxStreamReader.Next(TDBXTokens.NameSeparatorToken);
              FDbxStreamReader.Next(TDBXTokens.ArrayStartToken);
              Message.CommandHandle := FDbxStreamReader.ReadInt;
              FDbxStreamReader.SkipToEndOfObject;
            end;
          TDBXStringCodes.Session:
            begin
              FDbxStreamReader.Next(TDBXTokens.NameSeparatorToken);
              FDbxStreamReader.Next(TDBXTokens.ArrayStartToken);
              FDbxStreamReader.ReadBoolean;
              FDbxStreamReader.Next(TDBXTokens.ValueSeparatorToken);
              Message.IsolationLevel := FDbxStreamReader.ReadInt;
              FDbxStreamReader.Next(TDBXTokens.ValueSeparatorToken);
              FDbxStreamReader.ReadString;
              FDbxStreamReader.SkipToEndOfObject;
            end;
          TDBXStringCodes.Table:
            begin
              FDbxStreamReader.Next(TDBXTokens.NameSeparatorToken);
              FDbxStreamReader.Next(TDBXTokens.ArrayStartToken);
              if (Parameters = nil) or (Message.Row = nil) or (Parameters.Count < 1) then
                ClientReader := ReadDBXReaderMetaData
              else 
              begin
                if LastReaderOrdinal < 0 then
                  Message.Row.NewRowGeneration;
                LastReaderOrdinal := FindNextReaderOrdinal(Parameters, LastReaderOrdinal);
                if LastReaderOrdinal < 0 then
                  ClientReader := ReadDBXReaderMetaData
                else 
                begin
                  if FirstReaderOrdinal < 0 then
                    FirstReaderOrdinal := LastReaderOrdinal;
                  Parameter := Parameters.Parameter[LastReaderOrdinal];
                  Parameter.Value.SetDBXReader(ReadDBXReaderMetaData, True);
                end;
              end;
            end;
          TDBXStringCodes.Rows:
            begin
              FDbxStreamReader.Next(TDBXTokens.NameSeparatorToken);
              FDbxStreamReader.Next(TDBXTokens.ArrayStartToken);
              Message.RowsAffected := FDbxStreamReader.ReadLong;
              FDbxStreamReader.SkipToEndOfObject;
            end;
          TDBXStringCodes.Parameters:
            ReadParameters(Message);
          TDBXStringCodes.Data:
            begin
              FDbxStreamReader.Next(TDBXTokens.NameSeparatorToken);
              FDbxStreamReader.Next(TDBXTokens.ArrayStartToken);
              ParameterRow := TDBXJSonRow(Message.Row);
              if ParameterRow = nil then
                ParameterRowBuffer := nil
              else 
                ParameterRowBuffer := ParameterRow.RowBuffer;
              if ParameterRowBuffer = nil then
              begin
                Ordinal := 0;
                while not NeedsPrepare and (Ordinal < Parameters.Count) do
                begin
                  Parameter := Parameters.Parameter[Ordinal];
                  case Parameter.ParameterDirection of
                    TDBXParameterDirections.OutParameter:
                      NeedsPrepare := True;
                    TDBXParameterDirections.ReturnParameter:
                      if Parameter.DataType <> TDBXDataTypes.TableType then
                        NeedsPrepare := True;
                  end;
                  Inc(Ordinal);
                end;
              end
              else 
                ParameterRowBuffer.ReadDataBytes;
              FDbxStreamReader.SkipToEndOfObject;
            end;
          else
            FDbxStreamReader.SkipToEndOfObject;
        end;
      until FDbxStreamReader.Next <> TDBXTokens.ValueSeparatorToken;
    finally
      FDbxStreamReader.SkipToEndOfObject;
    end;
    if LastReaderOrdinal > -1 then
      for ordinal := FirstReaderOrdinal to LastReaderOrdinal do
      begin
        Parameter := Parameters.Parameter[Ordinal];
        if Parameter.DataType = TDBXDataTypes.TableType then
        begin
          ClientReader := Parameters.Parameter[Ordinal].Value.GetDBXReader;
          (TDBXJSonReader(ClientReader)).ReadFirstData;
          if Ordinal <> LastReaderOrdinal then
            FDbxStreamReader.NextValueSeparator;
        end;
      end
    else if ClientReader <> nil then
      (TDBXJSonReader(ClientReader)).ReadFirstData;
  end
  else 
    FDbxStreamReader.SkipToEndOfObject;
  Message.ReturnReader := ClientReader;
  if NeedsPrepare then
    raise TDBXError.Create(TDBXErrorCodes.InvalidOperation, SNeedsPrepare);
end;

procedure TDBXJSonClientInputConnectionHandler.DbxMoreBlob(const Message: TDBXMoreBlobMessage);
begin
end;

procedure TDBXJSonClientInputConnectionHandler.DbxNext(const Message: TDBXNextMessage);
begin
end;

procedure TDBXJSonClientInputConnectionHandler.DbxNextResult(const Message: TDBXNextResultMessage);
var
  HasMore: Boolean;
  ResultHandle: Integer;
begin
  FDbxStreamReader.NextResultObjectStart;
  FDbxStreamReader.Next(TDBXTokens.ArrayStartToken);
  HasMore := FDbxStreamReader.ReadBoolean;
  FDbxStreamReader.NextValueSeparator;
  Message.RowsAffected := FDbxStreamReader.ReadLong;
  FDbxStreamReader.NextValueSeparator;
  Message.Updateable := FDbxStreamReader.ReadBoolean;
  FDbxStreamReader.NextValueSeparator;
  ResultHandle := FDbxStreamReader.ReadInt;
  FDbxStreamReader.SkipToEndOfObject;
  if HasMore and (ResultHandle > -1) then
  begin
    FDbxStreamReader.Next(TDBXTokens.ObjectStartToken);
    FDbxStreamReader.Next(TDBXTokens.StringStartToken);
    FDbxStreamReader.ReadStringCode;
    FDbxStreamReader.Next(TDBXTokens.NameSeparatorToken);
    FDbxStreamReader.Next(TDBXTokens.ArrayStartToken);
    Message.NextResult := ReadDBXReader;
  end
  else 
    Message.NextResult := nil;
end;

procedure TDBXJSonClientInputConnectionHandler.DbxPrepare(const Message: TDBXPrepareMessage);
begin
  FDbxStreamReader.NextResultObjectStart;
  FDbxStreamReader.Next(TDBXTokens.ArrayStartToken);
  try
    repeat
      FDbxStreamReader.Next(TDBXTokens.ObjectStartToken);
      FDbxStreamReader.Next(TDBXTokens.StringStartToken);
      case FDbxStreamReader.ReadStringCode of
        TDBXStringCodes.Fields:
          begin
            FDbxStreamReader.Next(TDBXTokens.NameSeparatorToken);
            FDbxStreamReader.Next(TDBXTokens.ArrayStartToken);
            FDbxStreamReader.ReadInt;
            FDbxStreamReader.NextValueSeparator;
            FDbxStreamReader.ReadBoolean;
            FDbxStreamReader.SkipToEndOfObject;
          end;
        TDBXStringCodes.Handle:
          begin
            FDbxStreamReader.Next(TDBXTokens.NameSeparatorToken);
            FDbxStreamReader.Next(TDBXTokens.ArrayStartToken);
            Message.CommandHandle := FDbxStreamReader.ReadInt;
            FDbxStreamReader.SkipToEndOfObject;
          end;
        TDBXStringCodes.Parameters:
          ReadParameters(Message);
      end;
    until FDbxStreamReader.Next <> TDBXTokens.ValueSeparatorToken;
  finally
    FDbxStreamReader.SkipToEndOfObject;
  end;
end;

procedure TDBXJSonClientInputConnectionHandler.DbxReaderClose(const Message: TDBXReaderCloseMessage);
begin
end;

constructor TDBXJSonClientOutputConnectionHandler.Create(const ADbxContext: TDBXContext; const ANextHandler: TDBXConnectionHandler; const ADbxStreamReader: TDBXJSonStreamReader; const ADbxStreamWriter: TDBXJSonStreamWriter; const ARowBuffer: TDBXRowBuffer);
begin
  inherited Create(ADbxContext, True, ADbxStreamReader, ADbxStreamWriter, ARowBuffer, True);
  FNextHandler := ANextHandler;
  NextOwnedHandler := ANextHandler;
  FCommandCloseMessage := TDBXCommandCloseMessage.Create;
  FConnectMessage := TDBXConnectMessage.Create;
  FDisconnectMessage := TDBXDisconnectMessage.Create;
  FExecuteMessage := TDBXExecuteMessage.Create;
  FMoreBlobMessage := TDBXMoreBlobMessage.Create;
  FNextMessage := TDBXNextMessage.Create;
  FNextResultMessage := TDBXNextResultMessage.Create;
  FPrepareMessage := TDBXPrepareMessage.Create;
  FReaderCloseMessage := TDBXReaderCloseMessage.Create;
  FTxBeginMessage := TDBXTxBeginMessage.Create;
  FTxEndMessage := TDBXTxEndMessage.Create;
  FVendorProperMessage := TDBXVendorPropertyMessage.Create;
  FErrorMessage := TDBXErrorMessage.Create;
end;

destructor TDBXJSonClientOutputConnectionHandler.Destroy;
begin
  FreeAndNil(FCommandCloseMessage);
  FreeAndNil(FConnectMessage);
  FreeAndNil(FDisconnectMessage);
  FreeAndNil(FExecuteMessage);
  FreeAndNil(FMoreBlobMessage);
  FreeAndNil(FNextMessage);
  FreeAndNil(FNextResultMessage);
  FreeAndNil(FPrepareMessage);
  FreeAndNil(FReaderCloseMessage);
  FreeAndNil(FTxBeginMessage);
  FreeAndNil(FTxEndMessage);
  FreeAndNil(FVendorProperMessage);
  FreeAndNil(FErrorMessage);
  inherited Destroy;
end;

function TDBXJSonClientOutputConnectionHandler.AcquireCommandHandler(const Message: TDBXCommandMessage): TDBXCommandHandler;
begin
  Result := nil;
end;

function TDBXJSonClientOutputConnectionHandler.DbxBeforeRequest: Boolean;
begin
  Result := False;
end;

procedure TDBXJSonClientOutputConnectionHandler.DbxConnect(const Message: TDBXConnectMessage);
begin
end;

procedure TDBXJSonClientOutputConnectionHandler.DbxDisconnect(const Message: TDBXDisconnectMessage);
begin
end;

procedure TDBXJSonClientOutputConnectionHandler.DbxOpen(const Message: TDBXOpenMessage);
begin
end;

procedure TDBXJSonClientOutputConnectionHandler.DbxTxBegin(const Message: TDBXTxBeginMessage);
begin
  FDbxStreamWriter.WriteTxBegin(Message.IsolationLevel);
  Message.HandleMessage(FNextHandler);
end;

procedure TDBXJSonClientOutputConnectionHandler.DbxTxEnd(const Message: TDBXTxEndMessage);
begin
  FDbxStreamWriter.WriteTxEnd(Message.Commit, Message.TransactionHandle);
  Message.HandleMessage(FNextHandler);
end;

procedure TDBXJSonClientOutputConnectionHandler.DbxVendorProperty(const Message: TDBXVendorPropertyMessage);
begin
end;

function TDBXJSonClientOutputConnectionHandler.GetProductName: string;
begin
  Result := NullString;
end;

procedure TDBXJSonClientOutputConnectionHandler.DbxCommandClose(const Message: TDBXCommandCloseMessage);
begin
end;

procedure TDBXJSonClientOutputConnectionHandler.DbxErrorMessage(const Message: TDBXErrorMessage);
begin
end;

procedure TDBXJSonClientOutputConnectionHandler.WriteInputStreamerParameters(const CommandHandle: Integer; const StreamerRow: TDBXStreamerRow; const ActiveStreamerList: TDBXActiveTableReaderList; const Parameters: TDBXParameterList; const DataWritten: Boolean);
var
  FirstOrdinal: Integer;
  LastOrdinal: Integer;
  Item: TDBXActiveTableReaderItem;
  Parameter: TDBXParameter;
  Ordinal: Integer;
begin
  FirstOrdinal := StreamerRow.FirstDBXReaderOrdinal;
  LastOrdinal := StreamerRow.LastDBXReaderOrdinal;
  if FirstOrdinal > -1 then
    for ordinal := FirstOrdinal to LastOrdinal do
    begin
      Parameter := Parameters.Parameter[Ordinal];
      if Parameter.DataType = TDBXDataTypes.TableType then
        case Parameter.ParameterDirection of
          TDBXParameterDirections.InParameter,
          TDBXParameterDirections.InOutParameter:
            if not Parameter.Value.IsNull then
            begin
              Item := GetActiveTableReaderItem(ActiveStreamerList, CommandHandle, ActiveStreamerList.AllocateRowHandle);
              Item.Reader := Parameter.Value.GetDBXReader;
              if DataWritten or (Ordinal > FirstOrdinal) then
                FDbxStreamWriter.WriteValueSeparator;
              WriteDBXReader(CommandHandle, Item);
            end;
        end;
    end;
end;

procedure TDBXJSonClientOutputConnectionHandler.DbxExecute(const Message: TDBXExecuteMessage);
var
  DataWritten: Boolean;
  Parameters: TDBXParameterList;
  ParameterRow: TDBXJSonRow;
  ParameterRowBuffer: TDBXRowBuffer;
begin
  DataWritten := False;
  FDbxStreamWriter.WriteExecuteStart;
  ParameterRow := nil;
  Parameters := nil;
  if Message.Prepared then
  begin
    FDbxStreamWriter.WriteHandleObject(Message.CommandHandle);
    Parameters := Message.Parameters;
    if (Parameters <> nil) and (Parameters.Count > 0) then
    begin
      if Message.ParameterTypeChanged then
        WriteParameters(Message, True);
      ParameterRow := TDBXJSonRow(Message.Row);
      ParameterRowBuffer := ParameterRow.RowBuffer;
      if ParameterRowBuffer.offset > 0 then
        try
          FDbxStreamWriter.WriteValueSeparator;
          FDbxStreamWriter.WriteDataObject(ParameterRowBuffer.Buffer, ParameterRowBuffer.BufferOffset);
          DataWritten := True;
        finally
          ParameterRowBuffer.Post;
        end;
    end;
  end
  else 
    FDbxStreamWriter.WriteExecuteFieldsObject(Message.CommandHandle, False, Message.CommandType, Message.Command);
  if ParameterRow <> nil then
    WriteInputStreamerParameters(Message.CommandHandle, ParameterRow, Message.ActiveStreamerRowList, Parameters, DataWritten);
  FDbxStreamWriter.WriteArrayEnd;
  FDbxStreamWriter.WriteObjectEnd;
{$IFNDEF J2CS}
  if not Message.Prepared then
    TInvocationMetadataDelegate.WriteMetadata(Self);
{$ENDIF}
  FDbxStreamWriter.Flush;
  Message.HandleMessage(FNextHandler);
end;

procedure TDBXJSonClientOutputConnectionHandler.DbxMoreBlob(const Message: TDBXMoreBlobMessage);
begin
end;

procedure TDBXJSonClientOutputConnectionHandler.DbxNext(const Message: TDBXNextMessage);
begin
end;

procedure TDBXJSonClientOutputConnectionHandler.DbxNextResult(const Message: TDBXNextResultMessage);
begin
  FDbxStreamWriter.WriteNextResultObject(Message.CommandHandle);
  FDbxStreamWriter.Flush;
  Message.HandleMessage(FNextHandler);
end;

procedure TDBXJSonClientOutputConnectionHandler.DbxPrepare(const Message: TDBXPrepareMessage);
begin
  FDbxStreamWriter.WritePrepareStart(Message.CommandHandle, False, Message.CommandType, Message.Command);
  WriteParameters(Message, True);
  FDbxStreamWriter.WriteArrayEnd;
  FDbxStreamWriter.WriteObjectEnd;
  FDbxStreamWriter.Flush;
  Message.HandleMessage(FNextHandler);
end;

procedure TDBXJSonClientOutputConnectionHandler.DbxReaderClose(const Message: TDBXReaderCloseMessage);
begin
end;

end.
