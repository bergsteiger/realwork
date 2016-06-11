{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Data.DBXMessageHandlerJSonServer;

interface

uses
  System.JSON,
  Data.DBXCommon,
  Data.DBXCommonTable,
  Data.DBXJSON,
  Data.DBXMessageHandlerCommon,
  Data.DBXMessageHandlerJSonCommon,
  Data.DBXPlatform,
  Data.DBXStream,
  System.SysUtils,
  Datasnap.DSSession,
  Datasnap.DSHTTPCommon;

type
  TDBXJSonServerInputConnectionHandler = class(TDBXJSonConnectionHandler)
  public
    constructor Create(const ADbxContext: TDBXContext; const AUsesDbxParameters: Boolean; const ANextHandler: TDBXConnectionHandler; const ADbxStreamReader: TDBXJSonStreamReader; const ADbxStreamWriter: TDBXJSonStreamWriter; const ARowBuffer: TDBXRowBuffer);
    destructor Destroy; override;
    procedure DbxOpen(const Message: TDBXOpenMessage); override;
    function DbxBeforeRequest: Boolean; override;
    function AcquireCommandHandler(const Message: TDBXCommandMessage): TDBXCommandHandler; override;
    procedure HandleProtocol;
    function HandleNonBlockingProtocol: Boolean;
    function HandleDbxRequest: Boolean;
    procedure DbxConnect(const Message: TDBXConnectMessage); override;
    procedure DbxDisconnect(const Message: TDBXDisconnectMessage); override;
    procedure DbxExecute(const Message: TDBXExecuteMessage); override;
    procedure DbxNextResult(const Message: TDBXNextResultMessage); override;
    procedure DbxPrepare(const Message: TDBXPrepareMessage); override;
    procedure DbxNext(const Message: TDBXNextMessage); override;
    procedure DbxMoreBlob(const Message: TDBXMoreBlobMessage); override;
    procedure DbxCommandClose(const Message: TDBXCommandCloseMessage); override;
    procedure DbxReaderClose(const Message: TDBXReaderCloseMessage); override;
    procedure DbxTxBegin(const Message: TDBXTxBeginMessage); override;
    procedure DbxTxEnd(const Message: TDBXTxEndMessage); override;
    procedure DbxVendorProperty(const Message: TDBXVendorPropertyMessage); override;
    procedure DbxErrorMessage(const Message: TDBXErrorMessage); override;
    procedure Close;
  protected
    function GetProductName: string; override;
  private
    procedure UnexpectedError(const Ex: Exception);
    procedure ProcessDisconnect(const Message: TDBXDisconnectMessage);
    function ReadDbxDataTypes: TDBXInt32s;
  protected
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
  private
    FHandleRequests: Boolean;
    FMinRowBufferSize: Integer;
    FActiveStreamerRowList: TDBXActiveTableReaderList;
    FNextHandler: TDBXConnectionHandler;
    FConnectProps: TDBXProperties;
  public
    property MinRowBufferSize: Integer read FMinRowBufferSize;
  end;

  TDBXJSonServerOutputConnectionHandler = class(TDBXJSonConnectionHandler)
  public
    constructor Create(const ADbxContext: TDBXContext; const ADbxStreamReader: TDBXJSonStreamReader; const ADbxStreamWriter: TDBXJSonStreamWriter; const ARowBuffer: TDBXRowBuffer);
    destructor Destroy; override;
    procedure DbxOpen(const Message: TDBXOpenMessage); override;
    function DbxBeforeRequest: Boolean; override;
    procedure DbxExecute(const Message: TDBXExecuteMessage); override;
    procedure DbxPrepare(const Message: TDBXPrepareMessage); override;
    procedure DbxNextResult(const Message: TDBXNextResultMessage); override;
    procedure DbxNext(const Message: TDBXNextMessage); override;
    procedure DbxMoreBlob(const Message: TDBXMoreBlobMessage); override;
    procedure DbxCommandClose(const Message: TDBXCommandCloseMessage); override;
    procedure DbxReaderClose(const Message: TDBXReaderCloseMessage); override;
    procedure DbxErrorMessage(const Message: TDBXErrorMessage); override;
    procedure DbxVendorProperty(const Message: TDBXVendorPropertyMessage); override;
    procedure DbxConnect(const Message: TDBXConnectMessage); override;
    procedure DbxDisconnect(const Message: TDBXDisconnectMessage); override;
    procedure DbxTxBegin(const Message: TDBXTxBeginMessage); override;
    procedure DbxTxEnd(const Message: TDBXTxEndMessage); override;
    function AcquireCommandHandler(const Message: TDBXCommandMessage): TDBXCommandHandler; override;
    function CreateDbxRow: TDBXStreamerRow; override;
    procedure FlushRowBuffer;
  protected
    function GetProductName: string; override;
    procedure SetDbxStreamReader(const DbxStreamReader: TDBXJSonStreamReader);
    procedure SetDbxStreamWriter(const DbxStreamWriter: TDBXJSonStreamWriter);
  private
    function WriteReaderFirst(const Message: TDBXExecuteMessage; const ReturnTableReader: TDBXReader; const SomethingWritten: Boolean): Integer;
    procedure WriteReaderNext(const Message: TDBXExecuteMessage; const Reader: TDBXReader; const RowHandle: Integer);
  public
    property DbxStreamReader: TDBXJSonStreamReader read FDbxStreamReader write SetDbxStreamReader;
    property DbxStreamWriter: TDBXJSonStreamWriter read FDbxStreamWriter write SetDbxStreamWriter;
    property DbxRowBuffer: TDBXRowBuffer read FDbxRowBuffer write FDbxRowBuffer;
  end;

  TDBXJSonServerProtocolHandler = class(TDBXProtocolHandler)
  private
    FDSSession: TDSSession;
    FSessionEvent: TDSSessionEvent;
  public
    constructor Create(const AConnectionHandler: TDBXJSonServerInputConnectionHandler);
    destructor Destroy; override;
    procedure HandleProtocol; override;
    function HandleNonBlockingProtocol: Boolean; override;
    procedure SetUp(const Data: TObject); override;
    property DSSession: TDSSession read FDSSession write FDSSession;
  private
    FConnectionHandler: TDBXJSonServerInputConnectionHandler;
  end;

  
  /// <summary> Used to hold the callback logic in execute method
  /// 
  /// </summary>
  TDBXServerCallback = class(TDBXCallback)
  public
    
    /// <summary> Remote invokes the callback with given argument through the connection 
    ///  handler and expects either a JSON value or an error.
    /// </summary>
    /// <remarks> 
    ///  Assumes argument ownership
    ///  
    /// </remarks>
    /// <param name="arg">- JSON value, freed after call</param>
    /// <returns>JSON value</returns>
    function Execute(const Arg: TJSONValue): TJSONValue; overload; override;
    function Execute(Arg: TObject): TObject; overload; override;
  protected
    function GetConnectionHandler: TObject; virtual;
    procedure SetConnectionHandler(const ConnectionHandler: TObject); override;
    function GetOrdinal: Integer; virtual;
    procedure SetOrdinal(const Ordinal: Integer); override;
    function GetDsServer: TObject; virtual;
    procedure SetDsServer(const DsServer: TObject); override;
    function IsConnectionLost: Boolean; override;
  private
    FConnectionHandler: TObject;
    FDsServer: TObject;
    FOrdinal: Integer;
  public
    property ConnectionHandler: TObject read GetConnectionHandler write SetConnectionHandler;
    property Ordinal: Integer read GetOrdinal write SetOrdinal;
    property DsServer: TObject read GetDsServer write SetDsServer;
  end;

implementation

uses
  Data.DBXStreamPlatform,
  Datasnap.DSServer,
  Data.DBXClientResStrs;

constructor TDBXJSonServerInputConnectionHandler.Create(const ADbxContext: TDBXContext; const AUsesDbxParameters: Boolean; const ANextHandler: TDBXConnectionHandler; const ADbxStreamReader: TDBXJSonStreamReader; const ADbxStreamWriter: TDBXJSonStreamWriter; const ARowBuffer: TDBXRowBuffer);
begin
  inherited Create(ADbxContext, AUsesDbxParameters, ADbxStreamReader, ADbxStreamWriter, ARowBuffer, True);
  FNextHandler := ANextHandler;
  FHandleRequests := True;
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

destructor TDBXJSonServerInputConnectionHandler.Destroy;
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
  FreeAndNil(FActiveStreamerRowList);
  FreeAndNil(FConnectProps);
  inherited Destroy;
end;

procedure TDBXJSonServerInputConnectionHandler.DbxOpen(const Message: TDBXOpenMessage);
begin
  FDbxRowBuffer.DbxStreamReader := FDbxStreamReader;
  FDbxRowBuffer.DbxStreamWriter := FDbxStreamWriter;
end;

function TDBXJSonServerInputConnectionHandler.DbxBeforeRequest: Boolean;
begin
  Result := FNextHandler.DbxBeforeRequest;
end;

function TDBXJSonServerInputConnectionHandler.GetProductName: string;
begin
  Result := FNextHandler.ProductName;
end;

function TDBXJSonServerInputConnectionHandler.AcquireCommandHandler(const Message: TDBXCommandMessage): TDBXCommandHandler;
begin
  Result := FNextHandler.AcquireCommandHandler(Message);
end;

procedure TDBXJSonServerInputConnectionHandler.HandleProtocol;
begin
  try
    try
      while FHandleRequests do
      begin
        FDbxStreamReader.ReadMethod;
        if not HandleDbxRequest then
          FHandleRequests := False;
      end;
    except
      on Ex: Exception do
      begin
        ;
        UnexpectedError(Ex);
      end;
    end;
  finally
    Close;
  end;
end;

function TDBXJSonServerInputConnectionHandler.HandleNonBlockingProtocol: Boolean;
begin
  try
    try
      repeat
        FDbxStreamReader.ReadMethod;
        if not HandleDbxRequest then
          FHandleRequests := False;
      until not (FHandleRequests and FDbxStreamReader.HasMoreBytes);
    except
      on Ex: Exception do
      begin
        UnexpectedError(Ex);
        FHandleRequests := False;
      end;
    end;
  finally
    if not FHandleRequests then
      Close;
  end;
  Result := FHandleRequests;
end;

function TDBXJSonServerInputConnectionHandler.HandleDbxRequest: Boolean;
begin
  try
    if not DbxBeforeRequest then
      Exit(False);
    case FDbxStreamReader.StringCode of
      TDBXStringCodes.Connect:
        DbxConnect(FConnectMessage);
      TDBXStringCodes.Disconnect:
        begin
          DbxDisconnect(FDisconnectMessage);
          Exit(False);
        end;
      TDBXStringCodes.Execute:
        DbxExecute(FExecuteMessage);
      TDBXStringCodes.NextResult:
        DbxNextResult(FNextResultMessage);
      TDBXStringCodes.Prepare:
        DbxPrepare(FPrepareMessage);
      TDBXStringCodes.Next:
        DbxNext(FNextMessage);
      TDBXStringCodes.MoreBlob:
        DbxMoreBlob(FMoreBlobMessage);
      TDBXStringCodes.CommandClose:
        DbxCommandClose(FCommandCloseMessage);
      TDBXStringCodes.ReaderClose:
        DbxReaderClose(FReaderCloseMessage);
      TDBXStringCodes.Txbegin:
        DbxTxBegin(FTxBeginMessage);
      TDBXStringCodes.Txend:
        DbxTxEnd(FTxEndMessage);
      TDBXStringCodes.VendorProperty:
        DbxVendorProperty(FVendorProperMessage);
      else
        begin
          ;
          FDbxStreamReader.SkipToEndOfObject;
        end;
    end;
  except
    on Ex: Exception do
      try
//          if (!connectMessage.isSuccessfulConnect()) {
//            processDisconnect(disconnectMessage);
//            return false;
//          }
        ;
        FErrorMessage.Error := Ex;
        FErrorMessage.HandleMessage(FNextHandler);
      except
        on Ex2: Exception do
          Exit(False);
      end;
  end;
  ;
  Result := True;
end;

procedure TDBXJSonServerInputConnectionHandler.UnexpectedError(const Ex: Exception);
begin
  if FHandleRequests then
  begin
    DBXContext.Error(TDBXErrorCodes.InvalidOperation, '', Ex);
  end;
end;

procedure TDBXJSonServerInputConnectionHandler.DbxConnect(const Message: TDBXConnectMessage);
var
  Key: string;
  DbxReader: TDBXJSonStreamReader;
begin
  DbxReader := FDbxStreamReader;
  Message.SuccessfulConnect := True;
  if DbxReader.ReadParams = TDBXTokens.ArrayStartToken then
  begin
    FreeAndNil(FConnectProps);
    FConnectProps := TDBXProperties.Create;
    Message.ConnectProperties := FConnectProps;
    DbxReader.Next;
    while DbxReader.Next = TDBXTokens.StringStartToken do
    begin
      Key := DbxReader.ReadString;
      DbxReader.Next(TDBXTokens.NameSeparatorToken);
      FConnectProps[Key] := DbxReader.ReadString;
      if DbxReader.Next <> TDBXTokens.ValueSeparatorToken then
        break;
    end;
    DbxReader.Next(TDBXTokens.ArrayEndToken);
  end;
  DbxReader.SkipToEndOfObject;
  Message.HandleMessage(FNextHandler);
end;

procedure TDBXJSonServerInputConnectionHandler.ProcessDisconnect(const Message: TDBXDisconnectMessage);
begin
  Message.HandleMessage(FNextHandler);
end;

procedure TDBXJSonServerInputConnectionHandler.DbxDisconnect(const Message: TDBXDisconnectMessage);
begin
  FDbxStreamReader.SkipToEndOfObject;
  ProcessDisconnect(Message);
end;

function TDBXJSonServerInputConnectionHandler.ReadDbxDataTypes: TDBXInt32s;
var
  DbxReader: TDBXJSonStreamReader;
  Count, DbxType, Ordinal: Integer;
  DbxClientDataTypes: TDBXInt32s;
begin
  DbxReader := FDbxStreamReader;
  DbxClientDataTypes := nil;
  Count := DbxReader.ReadInt;
  if DbxReader.Next = TDBXTokens.ValueSeparatorToken then
  begin
    SetLength(DbxClientDataTypes,Count);
    for Ordinal := 0 to Length(DbxClientDataTypes) - 1 do
    begin
      if Ordinal <> 0 then
        DbxReader.Next(TDBXTokens.ValueSeparatorToken);
      DbxReader.Next(TDBXTokens.ArrayStartToken);
      DbxType := DbxReader.ReadInt;
      DbxReader.Next(TDBXTokens.ValueSeparatorToken);
      DbxType := DbxType or DbxReader.ReadInt shl 16;
      DbxClientDataTypes[Ordinal] := DbxType;
      DbxReader.SkipToEndOfArray;
    end;
  end;
  Result := DbxClientDataTypes;
end;

procedure TDBXJSonServerInputConnectionHandler.DbxExecute(const Message: TDBXExecuteMessage);
var
  DbxReader: TDBXJSonStreamReader;
  StringCode: Integer;
  ExplicitParameters: TDBXParameterList;
  Parameter: TDBXParameter;
  ParameterCount: Integer;
  Ordinal: Integer;
begin
  DbxReader := FDbxStreamReader;
  if FActiveStreamerRowList <> nil then
    FActiveStreamerRowList.CloseAllActiveTableReaders;
  DbxReader.ReadParams;
  Message.Reset;
  repeat
    DbxReader.Next(TDBXTokens.ObjectStartToken);
    DbxReader.Next(TDBXTokens.StringStartToken);
    StringCode := DbxReader.ReadStringCode;
    DbxReader.Next(TDBXTokens.NameSeparatorToken);
    DbxReader.Next(TDBXTokens.ArrayStartToken);
    case StringCode of
      TDBXStringCodes.Handle:
        begin
          Message.CommandHandle := DbxReader.ReadInt;
          DbxReader.SkipToEndOfObject;
        end;
      TDBXStringCodes.Parameters:
        begin
          if FUsesDbxParameters then
          begin
            ExplicitParameters := TDBXParameterList.Create(DBXContext, nil);
            ParameterCount := DbxReader.ReadInt;
            ExplicitParameters.Count := ParameterCount;
            if DbxReader.Next = TDBXTokens.ValueSeparatorToken then
              for Ordinal := 0 to ParameterCount - 1 do
              begin
                if Ordinal <> 0 then
                  DbxReader.Next(TDBXTokens.ValueSeparatorToken);
                Parameter := ReadParameter;
                ExplicitParameters.SetParameter(Ordinal, Parameter);
              end;
            Message.ExplicitParameters := ExplicitParameters;
          end
          else 
          begin
            if DbxReader.Next = TDBXTokens.ValueSeparatorToken then
              Message.ParameterDbxDataTypes := ReadDbxDataTypes;
          end;
          DbxReader.SkipToEndOfObject;
        end;
      TDBXStringCodes.Fields:
        begin
          Message.CommandHandle := DbxReader.ReadInt;
          DbxReader.NextValueSeparator;
          Message.Updatable := DbxReader.ReadBoolean;
          DbxReader.NextValueSeparator;
          Message.CommandType := DbxReader.ReadString;
          DbxReader.NextValueSeparator;
          Message.Command := DbxReader.ReadString;
          DbxReader.SkipToEndOfObject;
        end;
      TDBXStringCodes.Data:
        begin
          FDbxRowBuffer.ReadDataBytes;
          Message.HasParameters := True;
          DbxReader.SkipToEndOfObject;
        end;
      TDBXStringCodes.Table:
        Message.AddTableReader(ReadDBXReader);
    end;
  until DbxReader.Next <> TDBXTokens.ValueSeparatorToken;
  DbxReader.SkipToEndOfObject;
  if not FConnectMessage.SuccessfulConnect then
    ProcessDisconnect(FDisconnectMessage);
  Message.ConnectionHandler := self;
  Message.HandleMessage(FNextHandler);
end;

procedure TDBXJSonServerInputConnectionHandler.DbxNextResult(const Message: TDBXNextResultMessage);
begin
  FDbxStreamReader.ReadParams;
  Message.CommandHandle := FDbxStreamReader.ReadInt;
  FDbxStreamReader.SkipToEndOfObject;
  Message.HandleMessage(FNextHandler);
end;

procedure TDBXJSonServerInputConnectionHandler.DbxPrepare(const Message: TDBXPrepareMessage);
var
  StringCode: Integer;
  DbxReader: TDBXJSonStreamReader;
begin
  DbxReader := FDbxStreamReader;
  Message.Reset;
  DbxReader.ReadParams;
  try
    Message.CommandHandle := DbxReader.ReadInt;
    DbxReader.NextValueSeparator;
    Message.Updatable := DbxReader.ReadBoolean;
    DbxReader.NextValueSeparator;
    Message.CommandType := DbxReader.ReadString;
    DbxReader.NextValueSeparator;
    Message.Command := DbxReader.ReadString;
    while DbxReader.Next = TDBXTokens.ValueSeparatorToken do
    begin
      DbxReader.Next(TDBXTokens.ObjectStartToken);
      StringCode := DbxReader.ReadStringCode;
      case StringCode of
        TDBXStringCodes.Parameters:
          begin
            Message.ExplicitParameters := TDBXParameterList.Create(DBXContext, nil);
            if FUsesDbxParameters then
              ReadParameters(Message)
            else 
            begin
              DbxReader.Next(TDBXTokens.NameSeparatorToken);
              DbxReader.Next(TDBXTokens.ArrayStartToken);
              Message.ParameterDbxDataTypes := ReadDbxDataTypes;
              DbxReader.SkipToEndOfObject;
            end;
          end;
        else
          DbxReader.SkipToEndOfObject;
      end;
    end;
  finally
    DbxReader.SkipToEndOfObject;
  end;
  if not FConnectMessage.SuccessfulConnect then
    ProcessDisconnect(FDisconnectMessage);
  Message.HandleMessage(FNextHandler);
end;

procedure TDBXJSonServerInputConnectionHandler.DbxNext(const Message: TDBXNextMessage);
begin
  FDbxStreamReader.ReadParams;
  Message.RowHandle := FDbxStreamReader.ReadInt;
  FDbxStreamReader.NextValueSeparator;
  Message.Position := FDbxStreamReader.ReadLong;
  if FDbxStreamReader.Next = TDBXTokens.ValueSeparatorToken then
    Message.CommandHandle := FDbxStreamReader.ReadInt
  else 
    Message.CommandHandle := Message.RowHandle;
  FDbxStreamReader.SkipToEndOfObject;
  Message.HandleMessage(FNextHandler);
end;

procedure TDBXJSonServerInputConnectionHandler.DbxMoreBlob(const Message: TDBXMoreBlobMessage);
begin
  FDbxStreamReader.ReadParams;
  Message.CommandHandle := FDbxStreamReader.ReadInt;
  FDbxStreamReader.NextValueSeparator;
  Message.BlobHandle := FDbxStreamReader.ReadInt;
  FDbxStreamReader.NextValueSeparator;
  Message.Row := FDbxStreamReader.ReadLong;
  FDbxStreamReader.NextValueSeparator;
  Message.Ordinal := FDbxStreamReader.ReadInt;
  Message.RowHandle := -1;
  if FDbxStreamReader.Next = TDBXTokens.ValueSeparatorToken then
  begin
    Message.OutParameter := FDbxStreamReader.ReadBoolean;
    if FDbxStreamReader.Next = TDBXTokens.ValueSeparatorToken then
      Message.RowHandle := FDbxStreamReader.ReadInt;
  end
  else 
    Message.OutParameter := False;
  FDbxStreamReader.SkipToEndOfObject;
  Message.HandleMessage(FNextHandler);
end;

procedure TDBXJSonServerInputConnectionHandler.DbxCommandClose(const Message: TDBXCommandCloseMessage);
begin
  FDbxStreamReader.ReadParams;
  Message.CommandHandle := FDbxStreamReader.ReadInt;
  FDbxStreamReader.SkipToEndOfObject;
  Message.HandleMessage(FNextHandler);
end;

procedure TDBXJSonServerInputConnectionHandler.DbxReaderClose(const Message: TDBXReaderCloseMessage);
begin
  FDbxStreamReader.ReadParams;
  Message.ReaderHandle := FDbxStreamReader.ReadInt;
  if FDbxStreamReader.Next = TDBXTokens.ValueSeparatorToken then
    Message.CommandHandle := FDbxStreamReader.ReadInt
  else 
    Message.CommandHandle := Message.ReaderHandle;
  FDbxStreamReader.SkipToEndOfObject;
  Message.HandleMessage(FNextHandler);
end;

procedure TDBXJSonServerInputConnectionHandler.DbxTxBegin(const Message: TDBXTxBeginMessage);
begin
  FDbxStreamReader.ReadParams;
  Message.IsolationLevel := FDbxStreamReader.ReadInt;
  FDbxStreamReader.SkipToEndOfObject;
  Message.HandleMessage(FNextHandler);
end;

procedure TDBXJSonServerInputConnectionHandler.DbxTxEnd(const Message: TDBXTxEndMessage);
begin
  FDbxStreamReader.ReadParams;
  Message.Commit := FDbxStreamReader.ReadBoolean;
  FDbxStreamReader.NextValueSeparator;
  Message.TransactionHandle := FDbxStreamReader.ReadInt;
  FDbxStreamReader.SkipToEndOfObject;
  Message.HandleMessage(FNextHandler);
end;

procedure TDBXJSonServerInputConnectionHandler.DbxVendorProperty(const Message: TDBXVendorPropertyMessage);
begin
  FDbxStreamReader.ReadParams;
  Message.PropertyName := FDbxStreamReader.ReadString;
  FDbxStreamReader.SkipToEndOfObject;
  Message.HandleMessage(FNextHandler);
end;

procedure TDBXJSonServerInputConnectionHandler.DbxErrorMessage(const Message: TDBXErrorMessage);
begin
  Message.HandleMessage(FNextHandler);
end;

procedure TDBXJSonServerInputConnectionHandler.Close;
begin
  if FDbxStreamReader <> nil then
    FDbxStreamReader.Close;
  if FDbxStreamWriter <> nil then
    FDbxStreamWriter.Close;
end;

constructor TDBXJSonServerOutputConnectionHandler.Create(const ADbxContext: TDBXContext; const ADbxStreamReader: TDBXJSonStreamReader; const ADbxStreamWriter: TDBXJSonStreamWriter; const ARowBuffer: TDBXRowBuffer);
begin
  inherited Create(ADbxContext, True, ADbxStreamReader, ADbxStreamWriter, ARowBuffer, False);
end;

destructor TDBXJSonServerOutputConnectionHandler.Destroy;
begin
  inherited Destroy;
end;

procedure TDBXJSonServerOutputConnectionHandler.DbxOpen(const Message: TDBXOpenMessage);
begin
end;

function TDBXJSonServerOutputConnectionHandler.GetProductName: string;
begin
  Result := NullString;
end;

function TDBXJSonServerOutputConnectionHandler.DbxBeforeRequest: Boolean;
begin
  Result := True;
end;

function TDBXJSonServerOutputConnectionHandler.WriteReaderFirst(const Message: TDBXExecuteMessage; const ReturnTableReader: TDBXReader; const SomethingWritten: Boolean): Integer;
var
  ActiveStreamReaderList: TDBXActiveTableReaderList;
  Item: TDBXActiveTableReaderItem;
  DbxJSonRow: TDBXJSonRow;
  RowHandle: Integer;
begin
  ActiveStreamReaderList := Message.ActiveStreamerRowList;
  RowHandle := ActiveStreamReaderList.AllocateRowHandle;
  Item := GetActiveTableReaderItem(ActiveStreamReaderList, Message.CommandHandle, RowHandle);
  DbxJSonRow := TDBXJSonRow(Item.StreamerRow);
  Item.Reader := ReturnTableReader;
  if SomethingWritten then
    FDbxStreamWriter.WriteValueSeparator;
  WriteFirst(Message.CommandHandle, DbxJSonRow.RowHandle, DbxJSonRow, ReturnTableReader, DbxJSonRow.BcdFormat);
  Result := RowHandle;
end;

procedure TDBXJSonServerOutputConnectionHandler.WriteReaderNext(const Message: TDBXExecuteMessage; const Reader: TDBXReader; const RowHandle: Integer);
var
  ActiveStreamReaderList: TDBXActiveTableReaderList;
  Item: TDBXActiveTableReaderItem;
  DbxJSonRow: TDBXJSonRow;
begin
  ActiveStreamReaderList := Message.ActiveStreamerRowList;
  Item := ActiveStreamReaderList.FindStreamerRowItem(RowHandle);
  DbxJSonRow := TDBXJSonRow(Item.StreamerRow);
  Item.ReaderEos := WriteNext(Message.CommandHandle, DbxJSonRow, Reader, True);
end;

procedure TDBXJSonServerOutputConnectionHandler.DbxExecute(const Message: TDBXExecuteMessage);
var
  DbxWriter: TDBXJSonStreamWriter;
  ReturnTableReader: TDBXReader;
  Count: Integer;
  Parameter: TDBXParameter;
  Parameters: TDBXParameterList;
  FirstReaderOrdinal: Integer;
  LastReaderOrdinal: Integer;
  FirstRowHandle: Integer;
  RowHandle: Integer;
  Ordinal: Integer;
  SomethingWritten: Boolean;
  RowsAffected: Int64;
begin
  DbxWriter := FDbxStreamWriter;
  ReturnTableReader := Message.ReturnReader;
  RowsAffected := Message.RowsAffected;
  SomethingWritten := False;
  DbxWriter.WriteResultObjectStart;
  if RowsAffected > -1 then
  begin
    DbxWriter.WriteRowsObjectStart;
    DbxWriter.WriteLong(Message.RowsAffected);
    DbxWriter.WriteArrayEnd;
    DbxWriter.WriteObjectEnd;
    SomethingWritten := True;
  end;
  FirstReaderOrdinal := -1;
  LastReaderOrdinal := -1;
  FirstRowHandle := -1;
  Parameters := Message.Parameters;
  if Message.HasOutOrReturnParameters then
  begin
    if Message.ParameterTypeChanged then
    begin
      WriteParameters(Message, SomethingWritten);
      SomethingWritten := True;
    end;
    if Message.HasDBXTableReaderOutOrReturnParameter then
    begin
      if (Parameters <> nil) and (Parameters.Count > 0) then
      begin
        Count := Parameters.Count;
//          if (!isNoDBXReaderParameterReturn(parameters)) {
        if SomethingWritten then
          FDbxStreamWriter.WriteValueSeparator;
        FlushRowBuffer;
        SomethingWritten := True;
//          }
        Ordinal := 0;
        while Ordinal < Count do
        begin
          Parameter := Parameters.Parameter[Ordinal];
          if IsOutputDBXReader(Parameter) then
          begin
            LastReaderOrdinal := Ordinal;
            if FirstReaderOrdinal < 0 then
              FirstReaderOrdinal := LastReaderOrdinal;
            ReturnTableReader := Parameter.Value.GetDBXReader;
            RowHandle := WriteReaderFirst(Message, ReturnTableReader, SomethingWritten);
            SomethingWritten := True;
            if FirstRowHandle < 0 then
              FirstRowHandle := RowHandle;
          end;
          Ordinal := Ordinal + 1;
        end;
      end;
      if (FirstReaderOrdinal < 0) and (ReturnTableReader <> nil) then
        FirstRowHandle := WriteReaderFirst(Message, ReturnTableReader, SomethingWritten);
    end
    else 
    begin
      if SomethingWritten then
        FDbxStreamWriter.WriteValueSeparator;
      FlushRowBuffer;
//        somethingWritten = true;
    end;
  end;
  DbxWriter.WriteArrayEnd;
  DbxWriter.WriteObjectEnd;
  if FirstReaderOrdinal > -1 then
  begin
    RowHandle := FirstRowHandle;
    for ordinal := FirstReaderOrdinal to LastReaderOrdinal do
    begin
      Parameter := Parameters.Parameter[Ordinal];
      if IsOutputDBXReader(Parameter) then
      begin
        WriteReaderNext(Message, Parameter.Value.GetDBXReader, RowHandle);
        RowHandle := RowHandle + 1;
        if Ordinal <> LastReaderOrdinal then
          DbxWriter.WriteValueSeparator;
      end;
    end;
  end
  else if ReturnTableReader <> nil then
    WriteReaderNext(Message, ReturnTableReader, FirstRowHandle);
  DbxWriter.Flush;
end;

procedure TDBXJSonServerOutputConnectionHandler.DbxPrepare(const Message: TDBXPrepareMessage);
var
  Parameters: TDBXParameterList;
begin
  Parameters := Message.Parameters;
  FDbxStreamWriter.WriteResultObjectStart;
  FDbxStreamWriter.WriteHandleObject(Message.CommandHandle);
  FDbxStreamWriter.WriteValueSeparator;
  FDbxStreamWriter.WriteFieldsObjectStart;
  FDbxStreamWriter.WriteInt(0);
  FDbxStreamWriter.WriteValueSeparator;
  FDbxStreamWriter.WriteBoolean(False);
  FDbxStreamWriter.WriteArrayEnd;
  FDbxStreamWriter.WriteObjectEnd;
  if ((Parameters <> nil) and (Parameters.Count > 0)) then
    WriteParameters(Message, True);
  FDbxStreamWriter.WriteArrayEnd;
  FDbxStreamWriter.WriteObjectEnd;
  FDbxStreamWriter.Flush;
end;

procedure TDBXJSonServerOutputConnectionHandler.DbxNextResult(const Message: TDBXNextResultMessage);
begin
  FDbxStreamWriter.WriteResultObjectStart;
  FDbxStreamWriter.WriteBoolean(False);
  FDbxStreamWriter.WriteValueSeparator;
  FDbxStreamWriter.WriteLong(0);
  FDbxStreamWriter.WriteValueSeparator;
  FDbxStreamWriter.WriteBoolean(False);
  FDbxStreamWriter.WriteValueSeparator;
  FDbxStreamWriter.WriteInt(-1);
  FDbxStreamWriter.WriteArrayEnd;
  FDbxStreamWriter.WriteObjectEnd;
  FDbxStreamWriter.Flush;
end;

procedure TDBXJSonServerOutputConnectionHandler.DbxNext(const Message: TDBXNextMessage);
var
  ActiveStreamReaderList: TDBXActiveTableReaderList;
  DbxJSonRow: TDBXJSonRow;
  Item: TDBXActiveTableReaderItem;
begin
  ActiveStreamReaderList := Message.ActiveStreamerRowList;
  Item := GetActiveTableReaderItem(ActiveStreamReaderList, Message.CommandHandle, Message.RowHandle);
  DbxJSonRow := TDBXJSonRow(Item.StreamerRow);
  Item.ReaderEos := WriteNext(Message.CommandHandle, DbxJSonRow, Item.Reader, False);
  FDbxStreamWriter.Flush;
end;

procedure TDBXJSonServerOutputConnectionHandler.DbxMoreBlob(const Message: TDBXMoreBlobMessage);
begin
  FDbxStreamWriter.WriteResultObjectStart;
  Message.Eos := FDbxStreamWriter.WriteDataObject(Message.StreamReader);
  FDbxStreamWriter.WriteArrayEnd;
  FDbxStreamWriter.WriteObjectEnd;
  FDbxStreamWriter.Flush;
end;

procedure TDBXJSonServerOutputConnectionHandler.DbxCommandClose(const Message: TDBXCommandCloseMessage);
begin
end;

procedure TDBXJSonServerOutputConnectionHandler.DbxReaderClose(const Message: TDBXReaderCloseMessage);
begin
end;

procedure TDBXJSonServerOutputConnectionHandler.DbxErrorMessage(const Message: TDBXErrorMessage);
var
  ErrorMessage: string;
begin
  ErrorMessage := Format(SRemoteError, [Message.ErrorMessage]);
  FDbxStreamWriter.WriteRpcError(Message.ErrorClassName, Message.ErrorCode, ErrorMessage, nil);
  FDbxStreamWriter.Flush;
end;

procedure TDBXJSonServerOutputConnectionHandler.DbxVendorProperty(const Message: TDBXVendorPropertyMessage);
begin
  FDbxStreamWriter.WriteResultObjectStart;
  FDbxStreamWriter.WriteString(Message.PropertyValue);
  FDbxStreamWriter.WriteArrayEnd;
  FDbxStreamWriter.WriteObjectEnd;
  FDbxStreamWriter.Flush;
end;

procedure TDBXJSonServerOutputConnectionHandler.DbxConnect(const Message: TDBXConnectMessage);
var
  DbxWriter: TDBXJSonStreamWriter;
begin
  DbxWriter := FDbxStreamWriter;
  DbxWriter.WriteResultObjectStart;
  DbxWriter.WriteInt(Message.ConnectionHandle);
  DbxWriter.WriteValueSeparator;
  DbxWriter.WriteString(Message.ProductName);
  DbxWriter.WriteValueSeparator;
  DbxWriter.WriteInt(TDBXJSonStreamWriter.ProtocolVersion);
  DbxWriter.WriteArrayEnd;
  DbxWriter.WriteObjectEnd;
  DbxWriter.Flush;
end;

procedure TDBXJSonServerOutputConnectionHandler.DbxDisconnect(const Message: TDBXDisconnectMessage);
begin
end;

procedure TDBXJSonServerOutputConnectionHandler.DbxTxBegin(const Message: TDBXTxBeginMessage);
begin
  FDbxStreamWriter.WriteResultObject(Message.TransactionHandle);
end;

procedure TDBXJSonServerOutputConnectionHandler.DbxTxEnd(const Message: TDBXTxEndMessage);
begin
  FDbxStreamWriter.WriteResultVoidObject;
end;

function TDBXJSonServerOutputConnectionHandler.AcquireCommandHandler(const Message: TDBXCommandMessage): TDBXCommandHandler;
begin
  Result := self;
end;

function TDBXJSonServerOutputConnectionHandler.CreateDbxRow: TDBXStreamerRow;
begin
  Result := TDBXJSonRow.Create(DBXContext, FDbxStreamReader, FDbxStreamWriter, FDbxRowBuffer, False);
end;

procedure TDBXJSonServerOutputConnectionHandler.SetDbxStreamReader(const DbxStreamReader: TDBXJSonStreamReader);
begin
  self.FDbxStreamReader := DbxStreamReader;
  self.FDbxRowBuffer.DbxStreamReader := DbxStreamReader;
end;

procedure TDBXJSonServerOutputConnectionHandler.SetDbxStreamWriter(const DbxStreamWriter: TDBXJSonStreamWriter);
begin
  self.FDbxStreamWriter := DbxStreamWriter;
  self.FDbxRowBuffer.DbxStreamWriter := DbxStreamWriter;
end;

procedure TDBXJSonServerOutputConnectionHandler.FlushRowBuffer;
begin
  FDbxStreamWriter.WriteDataObject(FDbxRowBuffer.buf, FDbxRowBuffer.BufferOffset);
  FDbxRowBuffer.Post;
end;

{TDBXJSonServerProtocolHandler}

constructor TDBXJSonServerProtocolHandler.Create(const AConnectionHandler: TDBXJSonServerInputConnectionHandler);
begin
  inherited Create;
  FConnectionHandler := AConnectionHandler;
end;

destructor TDBXJSonServerProtocolHandler.Destroy;
begin
  if Assigned(FSessionEvent) then
    TDSSessionManager.Instance.RemoveSessionEvent(FSessionEvent);
  FSessionEvent := nil;
  FreeAndNil(FConnectionHandler);
  if FDSSession <> nil then
    TDSSessionManager.Instance.CloseSession(FDSSession.SessionName);
  FDSSession := nil;
  inherited Destroy;
end;

procedure TDBXJSonServerProtocolHandler.HandleProtocol;
begin
  FConnectionHandler.HandleProtocol;
end;

procedure TDBXJSonServerProtocolHandler.SetUp(const Data: TObject);
var
  LSessionEvent: TDSSessionEvent;
begin
  if FDSSession = nil then
  begin
    FDSSession := TDSSessionManager.Instance.CreateSession<TDSTCPSession>(function: TDSSession begin
      Result := TDSTCPSession.Create(Data);
    end, '');
  end;

  LSessionEvent :=
      procedure(Sender: TObject; const EventType: TDSSessionEventType;
                                 const Session: TDSSession)
      begin
        case EventType of
          SessionClose:
          begin
            if FDSSession <> nil then
              if FDSSession.SessionName = Session.SessionName then
              begin
                FDSSession := nil;
                if Assigned(FSessionEvent) then
                  TDSSessionManager.Instance.RemoveSessionEvent(FSessionEvent);
                FSessionEvent := nil;
              end;
          end;
        end;
      end;
   if not Assigned(FSessionEvent) then
   begin
    FSessionEvent := LSessionEvent;
    TDSSessionManager.Instance.AddSessionEvent(LSessionEvent);
   end;
  TDSSessionManager.SetAsThreadSession(FDSSession);
end;

function TDBXJSonServerProtocolHandler.HandleNonBlockingProtocol: Boolean;
begin
  Result := FConnectionHandler.HandleNonBlockingProtocol;
end;

{$IFNDEF J2CS}
{$ENDIF}
function TDBXServerCallback.Execute(const Arg: TJSONValue): TJSONValue;
var
  Args: TJSONArray;
begin
  Args := TJSONArray.Create;
  Args.Add(FOrdinal);
  Args.Add(TDBXCallback.ArgJson);
  Args.AddElement(Arg);
  try
    (TDBXJSonConnectionHandler(FConnectionHandler)).WriteCallbackData(Args, True);
  finally
    Args.Free;
  end;
  Result := (TDBXJSonConnectionHandler(FConnectionHandler)).ReadCallbackData;
end;

function TDBXServerCallback.Execute(Arg: TObject): TObject;
var
  Args: TJSONArray;
  Data: TJSONValue;
  Response: TObject;
begin
{$IFDEF J2CS}
  Response := nil;
{$ENDIF}
  Args := TJSONArray.Create;
  Args.Add(FOrdinal);
  Args.Add(TDBXCallback.ArgObject);
  try
{$IFNDEF J2CS}
    Args.AddElement((TDSServer(FDsServer)).MarshalData(Arg));
{$ENDIF}
    (TDBXJSonConnectionHandler(FConnectionHandler)).WriteCallbackData(Args, True);
  finally
    Arg.Free;
    Args.Free;
  end;
  Data := (TDBXJSonConnectionHandler(FConnectionHandler)).ReadCallbackData;
  try
{$IFNDEF J2CS}
    Response := (TDSServer(FDsServer)).UnmarshalJSON(Data);
{$ENDIF}
    Result := Response;
  finally
    Data.Free;
  end;
end;

function TDBXServerCallback.GetConnectionHandler: TObject;
begin
  Result := FConnectionHandler;
end;

procedure TDBXServerCallback.SetConnectionHandler(const ConnectionHandler: TObject);
begin
  self.FConnectionHandler := ConnectionHandler;
end;

function TDBXServerCallback.GetOrdinal: Integer;
begin
  Result := FOrdinal;
end;

function TDBXServerCallback.IsConnectionLost: Boolean;
begin
  Result := TDBXJSonConnectionHandler(FConnectionHandler).ConnectionLost;
end;

procedure TDBXServerCallback.SetOrdinal(const Ordinal: Integer);
begin
  self.FOrdinal := Ordinal;
end;

function TDBXServerCallback.GetDsServer: TObject;
begin
  Result := FDsServer;
end;

procedure TDBXServerCallback.SetDsServer(const DsServer: TObject);
begin
  self.FDsServer := DsServer;
end;

end.
