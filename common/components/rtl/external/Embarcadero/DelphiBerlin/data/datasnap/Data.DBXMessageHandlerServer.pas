{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Data.DBXMessageHandlerServer;

interface

uses
  Data.DBXCommon,
  Data.DBXCommonTable,
  Data.DBXMessageHandlerCommon,
  Data.DBXPlatform;

type
  TDBXServerParameterList = class;

  TDBXDatabaseCommandHandler = class(TDBXCommandHandler)
  public
    constructor Create(const ADbxContext: TDBXContext; const ANextHandler: TDBXCommandHandler; const ACommand: TDBXCommand);
    procedure DbxErrorMessage(const Message: TDBXErrorMessage); override;
    destructor Destroy; override;
    procedure DbxCommandClose(const Message: TDBXCommandCloseMessage); override;
    procedure DbxExecute(const Message: TDBXExecuteMessage); override;
    procedure DbxMoreBlob(const Message: TDBXMoreBlobMessage); override;
    procedure DbxNext(const Message: TDBXNextMessage); override;
    procedure DbxNextResult(const Message: TDBXNextResultMessage); override;
    procedure CreateParameterList;
    procedure DbxPrepare(const Message: TDBXPrepareMessage); override;
    procedure DbxReaderClose(const Message: TDBXReaderCloseMessage); override;
  private
    FCommand: TDBXCommand;
    FReader: TDBXReader;
    FParameterList: TDBXServerParameterList;
    FDbxRow: TDBXStreamerRow;
    FCommandParameter: TDBXParameter;
    FNextHandler: TDBXCommandHandler;
  end;

  TDBXDatabaseConnectionHandler = class(TDBXConnectionHandler)
  public
    constructor Create(const ADbxContext: TDBXContext; const ANextHandler: TDBXConnectionHandler);
    destructor Destroy; override;
    function DbxBeforeRequest: Boolean; override;
    procedure DbxErrorMessage(const Message: TDBXErrorMessage); override;
    function AcquireCommandHandler(const Message: TDBXCommandMessage): TDBXCommandHandler; override;
    procedure DbxConnect(const Message: TDBXConnectMessage); override;
    procedure DbxDisconnect(const Message: TDBXDisconnectMessage); override;
    procedure DbxTxBegin(const Message: TDBXTxBeginMessage); override;
    procedure EndTransaction(const Depth: Integer; const Commit: Boolean);
    procedure DbxTxEnd(const Message: TDBXTxEndMessage); override;
    procedure DbxVendorProperty(const Message: TDBXVendorPropertyMessage); override;
    procedure DbxOpen(const Message: TDBXOpenMessage); override;
    procedure DbxCommandClose(const Message: TDBXCommandCloseMessage); override;
    procedure DbxExecute(const Message: TDBXExecuteMessage); override;
    procedure DbxMoreBlob(const Message: TDBXMoreBlobMessage); override;
    procedure DbxNext(const Message: TDBXNextMessage); override;
    procedure DbxNextResult(const Message: TDBXNextResultMessage); override;
    procedure DbxPrepare(const Message: TDBXPrepareMessage); override;
    procedure DbxReaderClose(const Message: TDBXReaderCloseMessage); override;
  protected
    function GetProductName: string; override;
  private
    FCon: TDBXConnection;
    FTransactionStack: TDBXArrayList;
    FNextHandler: TDBXConnectionHandler;
  public
    property DBXConnection: TDBXConnection read FCon write FCon;
  end;

  TDBXServerParameterList = class(TDBXParameterList)
  public
    constructor Create(const DbxContext: TDBXContext; const Row: TDBXRow);
    procedure NewRowGeneration;
    procedure SetOutParameters;
  end;

implementation

uses
  System.SysUtils;

constructor TDBXDatabaseCommandHandler.Create(const ADbxContext: TDBXContext; const ANextHandler: TDBXCommandHandler; const ACommand: TDBXCommand);
begin
  inherited Create(ADbxContext);
  FNextHandler := ANextHandler;
  FCommand := ACommand;
end;

procedure TDBXDatabaseCommandHandler.DbxErrorMessage(const Message: TDBXErrorMessage);
begin
  Message.HandleMessage(FNextHandler);
end;

destructor TDBXDatabaseCommandHandler.Destroy;
begin
  FreeAndNil(FParameterList);
  FreeAndNil(FCommand);
  FreeAndNil(FReader);
  inherited Destroy;
end;

procedure TDBXDatabaseCommandHandler.DbxCommandClose(const Message: TDBXCommandCloseMessage);
begin
  if FCommand <> nil then
  begin
    FCommand.Close;
    FreeAndNil(FCommand);
    FreeAndNil(FReader);
  end;
end;

procedure TDBXDatabaseCommandHandler.DbxExecute(const Message: TDBXExecuteMessage);
var
  CommandParameterList: TDBXParameterList;
  Parameter: TDBXParameter;
  Ordinal: Integer;
  Count: Integer;
  ParameterCount: Integer;
  ExplicitParameters: TDBXParameterList;
begin
  if not Message.Command.IsEmpty then
  begin
    FCommand.Text := Message.Command;
    FCommand.CommandType := Message.CommandType;
  end;
  ExplicitParameters := Message.ExplicitParameters;
  if ExplicitParameters <> nil then
  begin
    CommandParameterList := FCommand.Parameters;
    CommandParameterList.ClearParameters;
    ParameterCount := ExplicitParameters.Count;
    CommandParameterList.Count := ParameterCount;
    for Ordinal := 0 to ParameterCount - 1 do
      CommandParameterList.SetParameter(Ordinal, ExplicitParameters.Parameter[Ordinal]);
    CreateParameterList;
    ExplicitParameters.RemoveParameters;
    Message.ExplicitParameters := nil;
  end;
  if FParameterList <> nil then
  begin
    FDbxRow.NewRowGeneration;
    Count := FParameterList.Count;
    CommandParameterList := FCommand.Parameters;
    CommandParameterList.Count := Count;
    if (Count > 0) and (FParameterList.Parameter[0] <> nil) then
      for Ordinal := 0 to Count - 1 do
      begin
        Parameter := FParameterList.Parameter[Ordinal];
        case Parameter.ParameterDirection of
          TDBXParameterDirections.InParameter,
          TDBXParameterDirections.InOutParameter:
            CommandParameterList.Parameter[Ordinal].Value.SetValue(Parameter.Value);
        end;
      end;
  end;
  FReader := FCommand.ExecuteQuery;
  Message.RowsAffected := FCommand.RowsAffected;
  if FParameterList <> nil then
  begin
    CommandParameterList := FCommand.Parameters;
    Message.HasOutOrReturnParameters := False;
    Count := CommandParameterList.Count;
    for Ordinal := 0 to Count - 1 do
    begin
      FCommandParameter := CommandParameterList.Parameter[Ordinal];
      case FCommandParameter.ParameterDirection of
        TDBXParameterDirections.OutParameter,
        TDBXParameterDirections.InOutParameter,
        TDBXParameterDirections.ReturnParameter:
          begin
            FParameterList.Parameter[Ordinal].Value.SetValue(FCommandParameter.Value);
            Message.HasOutOrReturnParameters := True;
          end;
      end;
    end;
  end;
  if FReader <> nil then
  begin
    Message.HasOutOrReturnParameters := True;
    Message.HasDBXTableReaderOutOrReturnParameter := True;
    Message.ActiveStreamerRowList := ActiveStreamerRowList;
  end;
  Message.Row := FDbxRow;
  Message.Parameters := FParameterList;
  Message.ReturnReader := FReader;
  if (FParameterList <> nil) and Message.HasOutOrReturnParameters then
    FParameterList.SetOutParameters;
  FNextHandler.DbxExecute(Message);
end;

procedure TDBXDatabaseCommandHandler.DbxMoreBlob(const Message: TDBXMoreBlobMessage);
var
  ActivRowList: TDBXActiveTableReaderList;
  Item: TDBXActiveTableReaderItem;
  Value: TDBXValue;
begin
  ActivRowList := ActiveStreamerRowList;
  Item := ActivRowList.FindStreamerRowItem(Message.RowHandle);
  if Item <> nil then
    Value := Item.Reader.Value[Message.Ordinal]
  else if Assigned(FParameterList) then
    Value := FParameterList.Parameter[Message.Ordinal].Value
  else
    raise TDBXError.Create(TDBXErrorCodes.InvalidOperation, 'Invalid row handle.  Reader is closed.');
  Message.StreamReader := TDBXDriverHelp.GetStreamReader(Value);
  FNextHandler.DbxMoreBlob(Message);
end;
//    throw new DBXError(DBXErrorCodes.INVALID_OPERATION, "dbxMoreBlob not supported yet");

procedure TDBXDatabaseCommandHandler.DbxNext(const Message: TDBXNextMessage);
begin
  Message.ActiveStreamerRowList := ActiveStreamerRowList;
  FNextHandler.DbxNext(Message);
end;

procedure TDBXDatabaseCommandHandler.DbxNextResult(const Message: TDBXNextResultMessage);
begin
  Message.NextResult := nil;
  Message.Updateable := False;
  Message.RowsAffected := 0;
  FNextHandler.DbxNextResult(Message);
end;

procedure TDBXDatabaseCommandHandler.CreateParameterList;
var
  Count: Integer;
  CommandParameters: TDBXParameterList;
  CommandParameter: TDBXParameter;
  Parameter: TDBXParameter;
  Ordinal: Integer;
begin
  CommandParameters := FCommand.Parameters;
  Count := CommandParameters.Count;
  if (Count > 0) and (CommandParameters.Parameter[0] <> nil) then
  begin
    FreeAndNil(FParameterList);
    FDbxRow := nil;
    FParameterList := nil;
    FDbxRow := FNextHandler.CreateDbxRow;
    FParameterList := TDBXServerParameterList.Create(DBXContext, FDbxRow);
    FParameterList.Count := Count;
    for Ordinal := 0 to Count - 1 do
    begin
      CommandParameter := CommandParameters.Parameter[Ordinal];
      Parameter := TDBXParameter.Create(DBXContext, FDbxRow, CommandParameter);
      FParameterList.SetParameter(Ordinal, Parameter);
    end;
  end;
end;

procedure TDBXDatabaseCommandHandler.DbxPrepare(const Message: TDBXPrepareMessage);
var
  Parameters: TDBXParameterList;
  Count: Integer;
  Ordinal: Integer;
begin
  FCommand.CommandType := Message.CommandType;
  FCommand.Text := Message.Command;
  Parameters := Message.Parameters;
  if Parameters = nil then
    Parameters := Message.ExplicitParameters;
  if Parameters <> nil then
  begin
    Count := Parameters.Count;
    if Count > 0 then
    begin
      FCommand.Parameters.ClearParameters;
      FCommand.Parameters.Count := Parameters.Count;
      if Parameters.Parameter[0] <> nil then
        for Ordinal := 0 to Count - 1 do
          FCommand.Parameters.SetParameter(Ordinal, Parameters.Parameter[Ordinal]);
      Parameters.RemoveParameters;
    end;
  end;
  FCommand.Prepare;
  CreateParameterList;
  Message.Parameters := FCommand.Parameters;
  FNextHandler.DbxPrepare(Message);
end;

procedure TDBXDatabaseCommandHandler.DbxReaderClose(const Message: TDBXReaderCloseMessage);
begin
  if FReader <> nil then
  begin
    FReader.Close;
    FreeAndNil(FReader);
    FReader := nil;
  end;
end;

constructor TDBXDatabaseConnectionHandler.Create(const ADbxContext: TDBXContext; const ANextHandler: TDBXConnectionHandler);
begin
  inherited Create(ADbxContext);
  FTransactionStack := TDBXArrayList.Create;
  FNextHandler := ANextHandler;
end;

destructor TDBXDatabaseConnectionHandler.Destroy;
begin
  FreeAndNil(FTransactionStack);
  inherited Destroy;
end;

function TDBXDatabaseConnectionHandler.DbxBeforeRequest: Boolean;
begin
  Result := False;
end;

procedure TDBXDatabaseConnectionHandler.DbxErrorMessage(const Message: TDBXErrorMessage);
begin
  FNextHandler.DbxErrorMessage(Message);
end;

function TDBXDatabaseConnectionHandler.GetProductName: string;
begin
  Result := FCon.ProductName;
end;

function TDBXDatabaseConnectionHandler.AcquireCommandHandler(const Message: TDBXCommandMessage): TDBXCommandHandler;
begin
  Result := TDBXDatabaseCommandHandler.Create(DBXContext, FNextHandler.AcquireCommandHandler(Message), FCon.CreateCommand);
end;

procedure TDBXDatabaseConnectionHandler.DbxConnect(const Message: TDBXConnectMessage);
begin
  raise TDBXError.Create(TDBXErrorCodes.InvalidOperation, 'dbxConnect not supported yet');
end;

procedure TDBXDatabaseConnectionHandler.DbxDisconnect(const Message: TDBXDisconnectMessage);
begin
  EndTransaction(0, False);
end;

procedure TDBXDatabaseConnectionHandler.DbxTxBegin(const Message: TDBXTxBeginMessage);
var
  Transaction: TDBXTransaction;
begin
  Transaction := FCon.BeginTransaction(Message.IsolationLevel);
  FTransactionStack.Add(Transaction);
  Message.TransactionHandle := FTransactionStack.Count;
end;

procedure TDBXDatabaseConnectionHandler.EndTransaction(const Depth: Integer; const Commit: Boolean);
var
  CurrentDepth: Integer;
  Index: Integer;
  Transaction: TDBXTransaction;
begin
  CurrentDepth := FTransactionStack.Count;
  while (Depth <= CurrentDepth) and (CurrentDepth > 0) do
  begin
    Index := CurrentDepth - 1;
    Transaction := TDBXTransaction(FTransactionStack[Index]);
    FTransactionStack.RemoveAt(Index);
    if Commit then
      FCon.CommitFreeAndNil(Transaction)
    else 
      FCon.RollbackFreeAndNil(Transaction);
    Dec(CurrentDepth);
  end;
end;

procedure TDBXDatabaseConnectionHandler.DbxTxEnd(const Message: TDBXTxEndMessage);
begin
  EndTransaction(Message.TransactionHandle, Message.Commit);
end;

procedure TDBXDatabaseConnectionHandler.DbxVendorProperty(const Message: TDBXVendorPropertyMessage);
begin
  Message.PropertyValue := FCon.GetVendorProperty(Message.PropertyName);
end;

procedure TDBXDatabaseConnectionHandler.DbxOpen(const Message: TDBXOpenMessage);
begin
end;

procedure TDBXDatabaseConnectionHandler.DbxCommandClose(const Message: TDBXCommandCloseMessage);
begin
  raise TDBXError.Create(TDBXErrorCodes.InvalidOperation, 'dbxCommandClose not supported yet');
end;

procedure TDBXDatabaseConnectionHandler.DbxExecute(const Message: TDBXExecuteMessage);
begin
  raise TDBXError.Create(TDBXErrorCodes.InvalidOperation, 'dbxExecute not supported yet');
end;

procedure TDBXDatabaseConnectionHandler.DbxMoreBlob(const Message: TDBXMoreBlobMessage);
begin
  raise TDBXError.Create(TDBXErrorCodes.InvalidOperation, 'dbxMoreBlob not supported yet');
end;

procedure TDBXDatabaseConnectionHandler.DbxNext(const Message: TDBXNextMessage);
begin
  raise TDBXError.Create(TDBXErrorCodes.InvalidOperation, 'dbxNext not supported yet');
end;

procedure TDBXDatabaseConnectionHandler.DbxNextResult(const Message: TDBXNextResultMessage);
begin
  raise TDBXError.Create(TDBXErrorCodes.InvalidOperation, 'dbxNextResult not supported yet');
end;

procedure TDBXDatabaseConnectionHandler.DbxPrepare(const Message: TDBXPrepareMessage);
begin
  raise TDBXError.Create(TDBXErrorCodes.InvalidOperation, 'dbxPrepare not supported yet');
end;

procedure TDBXDatabaseConnectionHandler.DbxReaderClose(const Message: TDBXReaderCloseMessage);
begin
  raise TDBXError.Create(TDBXErrorCodes.InvalidOperation, 'dbxReaderClose not supported yet');
end;

constructor TDBXServerParameterList.Create(const DbxContext: TDBXContext; const Row: TDBXRow);
begin
  inherited Create(DbxContext, Row);
end;

procedure TDBXServerParameterList.NewRowGeneration;
begin
  GetRow.NewRowGeneration;
end;

procedure TDBXServerParameterList.SetOutParameters;
var
  Parameter: TDBXParameter;
  ParamCount: Integer;
  Ordinal: Integer;
begin
  ParamCount := Count;
  GetRow.ClearParameters;
  for Ordinal := 0 to ParamCount - 1 do
  begin
    Parameter := Self.Parameter[Ordinal];
    case Parameter.ParameterDirection of
      TDBXParameterDirections.OutParameter,
      TDBXParameterDirections.InOutParameter,
      TDBXParameterDirections.ReturnParameter:;
      else
        Parameter.Value.SetNull;
    end;
    SetPendingOutParameter(Ordinal);
  end;
end;

end.
