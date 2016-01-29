{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Data.DBXMessageHandlerCommon;

interface

uses
  Data.DBXCommon,
  Data.DBXCommonTable,
  Data.DBXPlatform,
  System.SysUtils;

type
  TDBXCommandHandler = class;
  TDBXConnectionHandler = class;
  TDBXErrorMessage = class;
  TDBXDisconnectMessage = class;
  TDBXConnectMessage = class;
  TDBXCommandMessage = class;
  TDBXExecuteMessage = class;
  TDBXCommandCloseMessage = class;
  TDBXMoreBlobMessage = class;
  TDBXNextMessage = class;
  TDBXNextResultMessage = class;
  TDBXOpenMessage = class;
  TDBXPrepareMessage = class;
  TDBXReaderCloseMessage = class;
  TDBXTxBeginMessage = class;
  TDBXTxEndMessage = class;
  TDBXVendorPropertyMessage = class;
  TDBXCommandHandlerArray = array of TDBXCommandHandler;
  TDBXConnectionHandlerArray = array of TDBXConnectionHandler;

  TDBXCommandHandler = class abstract
  public
    constructor Create(const ADbxContext: TDBXContext);
    destructor Destroy; override;
    procedure DbxExecute(const Message: TDBXExecuteMessage); virtual; abstract;
    procedure DbxPrepare(const Message: TDBXPrepareMessage); virtual; abstract;
    procedure DbxNextResult(const Message: TDBXNextResultMessage); virtual; abstract;
    procedure DbxNext(const Message: TDBXNextMessage); virtual; abstract;
    procedure DbxMoreBlob(const Message: TDBXMoreBlobMessage); virtual; abstract;
    procedure DbxCommandClose(const Message: TDBXCommandCloseMessage); virtual; abstract;
    procedure DbxReaderClose(const Message: TDBXReaderCloseMessage); virtual; abstract;
    procedure DbxErrorMessage(const Message: TDBXErrorMessage); virtual; abstract;
    function CreateDbxRow: TDBXStreamerRow; virtual;
    function ClearResources: Boolean; virtual;
  protected
    function GetActiveStreamerRowList: TDBXActiveTableReaderList;
    function GetCommandHandle: Integer; virtual;
    procedure SetCommandHandle(const Handle: Integer); virtual;
  private
    FCommandHandle: Integer;
    [Weak]FDbxContext: TDBXContext;
    FActiveStreamerRowList: TDBXActiveTableReaderList;
    FNextOwnedHandler: TDBXCommandHandler;
  public
    property NextOwnedHandler: TDBXCommandHandler write FNextOwnedHandler;
    property ActiveStreamerRowList: TDBXActiveTableReaderList read GetActiveStreamerRowList;
    property CommandHandle: Integer read GetCommandHandle write SetCommandHandle;
    property DBXContext: TDBXContext read FDbxContext;
  end;

  TDBXConnectionHandler = class abstract(TDBXCommandHandler)
  public
    constructor Create(const ADbxContext: TDBXContext);
    procedure DbxConnect(const Message: TDBXConnectMessage); virtual; abstract;
    procedure DbxDisconnect(const Message: TDBXDisconnectMessage); virtual; abstract;
    procedure DbxTxBegin(const Message: TDBXTxBeginMessage); virtual; abstract;
    procedure DbxTxEnd(const Message: TDBXTxEndMessage); virtual; abstract;
    procedure DbxVendorProperty(const Message: TDBXVendorPropertyMessage); virtual; abstract;
    procedure DbxOpen(const Message: TDBXOpenMessage); virtual; abstract;
    function AcquireCommandHandler(const Message: TDBXCommandMessage): TDBXCommandHandler; virtual; abstract;
    function DbxBeforeRequest: Boolean; virtual; abstract;
  protected
    function GetProductName: string; virtual; abstract;
    function GetCommandHandle: Integer; override;
    procedure SetCommandHandle(const Handle: Integer); override;
  private
    function InvalidOperationError: TDBXError;
  public
    property ProductName: string read GetProductName;
  end;

  TDBXDisconnectHandler = class abstract
  public
    procedure Disconnect(const Handler: TDBXConnectionHandler); virtual; abstract;
  end;

  TDBXMessage = class abstract
  end;

  TDBXErrorMessage = class(TDBXMessage)
  public
    procedure HandleMessage(const Handler: TDBXCommandHandler); virtual;
  protected
    procedure SetError(const Ex: Exception);
  private
    function GetNestedMessage(const Message: string; const Ex: Exception; const Level: Integer): string;
    procedure InitDBXErrorMessage(const Message: TDBXErrorMessage);
  private
    FEx: Exception;
    FErrorCode: Integer;
    FErrorMessage: string;
    FErrorClassName: string;
  public
    property Error: Exception read FEx write SetError;
    property ErrorCode: Integer read FErrorCode write FErrorCode;
    property ErrorClassName: string read FErrorClassName write FErrorClassName;
    property ErrorMessage: string read FErrorMessage write FErrorMessage;
  end;

  TDBXDisconnectMessage = class(TDBXMessage)
  public
    procedure HandleMessage(const Handler: TDBXConnectionHandler);
  end;

  TDBXConnectMessage = class(TDBXMessage)
  public
    procedure HandleMessage(const Handler: TDBXConnectionHandler);
  private
    [Weak]FConnectProperties: TDBXProperties;
    FConnectionHandle: Integer;
    FProductName: string;
    FSuccessfulConnect: Boolean;
  public
    property ProductName: string read FProductName write FProductName;
    property ConnectProperties: TDBXProperties read FConnectProperties write FConnectProperties;
    property ConnectionHandle: Integer read FConnectionHandle write FConnectionHandle;
    property SuccessfulConnect: Boolean read FSuccessfulConnect write FSuccessfulConnect;
  end;

  TDBXCommandMessage = class abstract(TDBXMessage)
  public
    destructor Destroy; override;
  protected
    procedure SetExplicitParameters(const ExplicitParameters: TDBXParameterList);
  private
    FCommandHandle: Integer;
    FUpdatable: Boolean;
    FCommandType: string;
    FCommand: string;
    FParameterTypeChanged: Boolean;
    [Weak]FParameters: TDBXParameterList;
    FExplicitParameters: TDBXParameterList;
    FParameterDbxDataTypes: TDBXInt32s;
    FServerSideCommand: Boolean;
  public
    property Command: string read FCommand write FCommand;
    property CommandHandle: Integer read FCommandHandle write FCommandHandle;
    property CommandType: string read FCommandType write FCommandType;
    property Updatable: Boolean read FUpdatable write FUpdatable;
    property ParameterTypeChanged: Boolean read FParameterTypeChanged write FParameterTypeChanged;
    property Parameters: TDBXParameterList read FParameters write FParameters;
    property ExplicitParameters: TDBXParameterList read FExplicitParameters write SetExplicitParameters;
    property ParameterDbxDataTypes: TDBXInt32s read FParameterDbxDataTypes write FParameterDbxDataTypes;
    property ServerSideCommand: Boolean read FServerSideCommand write FServerSideCommand;
  end;

  TDBXExecuteMessage = class(TDBXCommandMessage)
  public
    destructor Destroy; override;
    procedure HandleMessage(const Handler: TDBXCommandHandler); overload;
    procedure HandleMessage(const Handler: TDBXConnectionHandler); overload;
    procedure Reset;
    procedure AddTableReader(const Table: TDBXReader);
    function GetTableReader(const Ordinal: Integer): TDBXReader;
    procedure FreeTableReaders;
  protected
    procedure SetConnectionHandler(const ConnectionHandler: TObject); virtual;
    function GetConnectionHandler: TObject; virtual;
  private
    FPrepared: Boolean;
    FTableCount: Integer;
    FTables: TDBXReaderArray;
    FHasParameters: Boolean;
    FHasOutOrReturnParameters: Boolean;
    FHasDBXTableReaderOutOrReturnParameter: Boolean;
    [Weak]FRow: TDBXStreamerRow;
    FReturnReader: TDBXReader;
    [Weak]FActiveStreamerRowList: TDBXActiveTableReaderList;
    FIsolationLevel: Integer;
    FRowsAffected: Int64;
    [Weak]FConnectionHandler: TObject;
  public
    property RowsAffected: Int64 read FRowsAffected write FRowsAffected;
    property IsolationLevel: Integer read FIsolationLevel write FIsolationLevel;
    property TableReaderCount: Integer read FTableCount;
    property HasParameters: Boolean read FHasParameters write FHasParameters;
    property HasDBXTableReaderOutOrReturnParameter: Boolean read FHasDBXTableReaderOutOrReturnParameter write FHasDBXTableReaderOutOrReturnParameter;
    property HasOutOrReturnParameters: Boolean read FHasOutOrReturnParameters write FHasOutOrReturnParameters;
    property Row: TDBXStreamerRow read FRow write FRow;
    property ReturnReader: TDBXReader read FReturnReader write FReturnReader;
    property ActiveStreamerRowList: TDBXActiveTableReaderList read FActiveStreamerRowList write FActiveStreamerRowList;
    property Prepared: Boolean read FPrepared write FPrepared;
    property ConnectionHandler: TObject read GetConnectionHandler write SetConnectionHandler;
  end;

  TDBXCommandCloseMessage = class(TDBXMessage)
  public
    procedure HandleMessage(const Handler: TDBXCommandHandler);
  private
    FCommandHandle: Integer;
  public
    property CommandHandle: Integer read FCommandHandle write FCommandHandle;
  end;

  TDBXMoreBlobMessage = class(TDBXMessage)
  public
    procedure HandleMessage(const Handler: TDBXConnectionHandler); overload;
    procedure HandleMessage(const Handler: TDBXCommandHandler); overload;
  private
    FCommandHandle: Integer;
    FRowHandle: Integer;
    FBlobHandle: Integer;
    FRow: Int64;
    FOrdinal: Integer;
    FOutParameter: Boolean;
    [Weak]FStreamReader: TDBXStreamReader;
    FEos: Boolean;
  public
    property CommandHandle: Integer read FCommandHandle write FCommandHandle;
    property BlobHandle: Integer read FBlobHandle write FBlobHandle;
    property Ordinal: Integer read FOrdinal write FOrdinal;
    property Row: Int64 read FRow write FRow;
    property OutParameter: Boolean read FOutParameter write FOutParameter;
    property StreamReader: TDBXStreamReader read FStreamReader write FStreamReader;
    property RowHandle: Integer read FRowHandle write FRowHandle;
    property Eos: Boolean read FEos write FEos;
  end;

  TDBXNextMessage = class(TDBXMessage)
  public
    procedure HandleMessage(const Handler: TDBXCommandHandler);
  private
    FCommandHandle: Integer;
    FRowHandle: Integer;
    FPosition: Int64;
    [Weak]FActiveStreamerRowList: TDBXActiveTableReaderList;
  public
    property CommandHandle: Integer read FCommandHandle write FCommandHandle;
    property Position: Int64 read FPosition write FPosition;
    property RowHandle: Integer read FRowHandle write FRowHandle;
    property ActiveStreamerRowList: TDBXActiveTableReaderList read FActiveStreamerRowList write FActiveStreamerRowList;
  end;

  TDBXNextResultMessage = class(TDBXMessage)
  public
    procedure HandleMessage(const Handler: TDBXCommandHandler);
  private
    FCommandHandle: Integer;
    FUpdateable: Boolean;
    FRowsAffected: Int64;
    [Weak]FNextResult: TDBXReader;
  public
    property CommandHandle: Integer read FCommandHandle write FCommandHandle;
    property NextResult: TDBXReader read FNextResult write FNextResult;
    property Updateable: Boolean read FUpdateable write FUpdateable;
    property RowsAffected: Int64 read FRowsAffected write FRowsAffected;
  end;

  TDBXOpenMessage = class(TDBXMessage)
  public
    procedure HandleMessage(const Handler: TDBXConnectionHandler);
  private
    FConnectionHandle: Integer;
  public
    property ConnectionHandle: Integer read FConnectionHandle write FConnectionHandle;
  end;

  TDBXPrepareMessage = class(TDBXCommandMessage)
  public
    procedure Reset;
    procedure HandleMessage(const Handler: TDBXCommandHandler);
  end;

  TDBXProtocolHandler = class abstract
  public
    procedure HandleProtocol; virtual; abstract;
    function HandleNonBlockingProtocol: Boolean; virtual; abstract;
    procedure SetUp(const Data: TObject); virtual; abstract;
  end;

  TDBXReaderCloseMessage = class(TDBXMessage)
  public
    procedure HandleMessage(const Handler: TDBXCommandHandler);
  private
    FReaderHandle: Integer;
    FCommandHandle: Integer;
  public
    property CommandHandle: Integer read FCommandHandle write FCommandHandle;
    property ReaderHandle: Integer read FReaderHandle write FReaderHandle;
  end;

  TDBXTxBeginMessage = class(TDBXMessage)
  public
    procedure HandleMessage(const Handler: TDBXConnectionHandler);
  private
    FIsolationLevel: Integer;
    FTransactionHandle: Integer;
  public
    property IsolationLevel: Integer read FIsolationLevel write FIsolationLevel;
    property TransactionHandle: Integer read FTransactionHandle write FTransactionHandle;
  end;

  TDBXTxEndMessage = class(TDBXMessage)
  public
    procedure HandleMessage(const Handler: TDBXConnectionHandler);
  private
    FCommit: Boolean;
    FTransactionHandle: Integer;
  public
    property TransactionHandle: Integer read FTransactionHandle write FTransactionHandle;
    property Commit: Boolean read FCommit write FCommit;
  end;

  TDBXVendorPropertyMessage = class(TDBXMessage)
  public
    procedure HandleMessage(const Handler: TDBXConnectionHandler);
  private
    FPropertyName: string;
    FPropertyValue: string;
  public
    property PropertyName: string read FPropertyName write FPropertyName;
    property PropertyValue: string read FPropertyValue write FPropertyValue;
  end;

implementation

uses
  Data.DBXStream,
  Data.DBXClientResStrs
;

constructor TDBXCommandHandler.Create(const ADbxContext: TDBXContext);
begin
  inherited Create;
  FDbxContext := ADbxContext;
end;

destructor TDBXCommandHandler.Destroy;
begin
  FreeAndNil(FNextOwnedHandler);
  FreeAndNil(FActiveStreamerRowList);
  inherited Destroy;
end;

function TDBXCommandHandler.GetActiveStreamerRowList: TDBXActiveTableReaderList;
begin
  if FActiveStreamerRowList = nil then
    FActiveStreamerRowList := TDBXActiveTableReaderList.Create;
  Result := FActiveStreamerRowList;
end;

function TDBXCommandHandler.CreateDbxRow: TDBXStreamerRow;
begin
  raise TDBXError.Create(TDBXErrorCodes.InvalidOperation, '');
end;

function TDBXCommandHandler.GetCommandHandle: Integer;
begin
  Result := FCommandHandle;
end;

procedure TDBXCommandHandler.SetCommandHandle(const Handle: Integer);
begin
  self.FCommandHandle := Handle;
end;

function TDBXCommandHandler.ClearResources: Boolean;
begin
  Result := True;
end;

constructor TDBXConnectionHandler.Create(const ADbxContext: TDBXContext);
begin
  inherited Create(ADbxContext);
end;

function TDBXConnectionHandler.InvalidOperationError: TDBXError;
begin
  Result := TDBXError.Create(TDBXErrorCodes.InvalidOperation, '');
end;

function TDBXConnectionHandler.GetCommandHandle: Integer;
begin
  raise InvalidOperationError;
end;

procedure TDBXConnectionHandler.SetCommandHandle(const Handle: Integer);
begin
  raise InvalidOperationError;
end;

procedure TDBXErrorMessage.HandleMessage(const Handler: TDBXCommandHandler);
begin
  Handler.DbxErrorMessage(self);
end;

procedure TDBXErrorMessage.SetError(const Ex: Exception);
begin
  self.FEx := Ex;
  if Ex <> nil then
    InitDBXErrorMessage(self);
end;

function TDBXErrorMessage.GetNestedMessage(const Message: string; const Ex: Exception; const Level: Integer): string;
var
  ErrorMessage, ExMessage: string;
begin
  if (Ex = nil) or (Level > 10) then
    Result := Message
  else 
  begin
    ExMessage := Ex.Message;
    if ExMessage.IsEmpty then
      ExMessage := Ex.ToString;
    if (Level > 0) and (Message.IndexOf(ExMessage) < 0) then
      ErrorMessage := Message + string.Format(SCausedBy, [ExMessage])
    else 
      ErrorMessage := ExMessage;
    Result := GetNestedMessage(ErrorMessage, TDBXPlatform.GetNestedException(Ex), Level + 1);
  end;
end;

procedure TDBXErrorMessage.InitDBXErrorMessage(const Message: TDBXErrorMessage);
var
  ErrorMessage: string;
  Ex: Exception;
  DbxErrorCode: Integer;
  RpcEx: TDBXError;
  ErrorClassName: string;
begin
  DbxErrorCode := TDBXJSonErrorCodes.ServiceError;
  Ex := Message.Error;
  ErrorMessage := Ex.Message;
  if Ex is TDBXError then
  begin
    RpcEx := TDBXError(Ex);
    DbxErrorCode := RpcEx.ErrorCode;
    ErrorMessage := RpcEx.Message;
  end;
  ErrorMessage := GetNestedMessage('', Ex, 0);
  if Ex = nil then
    ErrorClassName := 'error(null)'
  else 
    ErrorClassName := TDBXPlatform.GetClassName(Ex);
  Message.ErrorClassName := ErrorClassName;
  Message.ErrorCode := DbxErrorCode;
  Message.ErrorMessage := ErrorMessage;
end;

procedure TDBXDisconnectMessage.HandleMessage(const Handler: TDBXConnectionHandler);
begin
  Handler.DbxDisconnect(self);
end;

procedure TDBXConnectMessage.HandleMessage(const Handler: TDBXConnectionHandler);
begin
  Handler.DbxConnect(self);
end;

destructor TDBXCommandMessage.Destroy;
begin
  FParameterDbxDataTypes := nil;
  FreeAndNil(FExplicitParameters);
  inherited Destroy;
end;

procedure TDBXCommandMessage.SetExplicitParameters(const ExplicitParameters: TDBXParameterList);
begin
  if FExplicitParameters <> ExplicitParameters then
  begin
    FreeAndNil(FExplicitParameters);
    FExplicitParameters := ExplicitParameters;
  end;
end;

destructor TDBXExecuteMessage.Destroy;
begin
  FreeObjectArray(TDBXFreeArray(FTables));
  inherited Destroy;
end;

procedure TDBXExecuteMessage.HandleMessage(const Handler: TDBXCommandHandler);
begin
  Handler.DbxExecute(self);
end;

procedure TDBXExecuteMessage.HandleMessage(const Handler: TDBXConnectionHandler);
begin
  Handler.DbxExecute(self);
end;

procedure TDBXExecuteMessage.Reset;
begin
  CommandHandle := -1;
  Updatable := False;
  CommandType := NullString;
  Command := NullString;
  HasParameters := False;
  ExplicitParameters := nil;
  Parameters := nil;
  ParameterDbxDataTypes := nil;
  ParameterTypeChanged := False;
  FReturnReader := nil;
  FTableCount := 0;
  FHasParameters := False;
  FHasOutOrReturnParameters := False;
  FHasDBXTableReaderOutOrReturnParameter := False;
  ParameterDbxDataTypes := nil;
  ConnectionHandler := nil;
end;

procedure TDBXExecuteMessage.AddTableReader(const Table: TDBXReader);
var
  NewTables: TDBXReaderArray;
  Index: Integer;
begin
  if FTables = nil then
    SetLength(FTables,1)
  else if Length(FTables) <= FTableCount then
  begin
    SetLength(NewTables,Length(FTables) + 1);
    for Index := 0 to Length(FTables) - 1 do
      NewTables[Index] := FTables[Index];
    FTables := NewTables;
  end;
  FTables[FTableCount] := Table;
  Inc(FTableCount);
end;

function TDBXExecuteMessage.GetTableReader(const Ordinal: Integer): TDBXReader;
begin
  Result := FTables[Ordinal];
end;

procedure TDBXExecuteMessage.FreeTableReaders;
var
  Ordinal: Integer;
begin
  if FTables <> nil then
  begin
    for Ordinal := 0 to Length(FTables) - 1 do
    begin
      FTables[Ordinal].Free;
      FTables[Ordinal] := nil;
    end;
    FTableCount := 0;
  end;
end;

procedure TDBXExecuteMessage.SetConnectionHandler(const ConnectionHandler: TObject);
begin
  FConnectionHandler := ConnectionHandler;
end;

function TDBXExecuteMessage.GetConnectionHandler: TObject;
begin
  Result := FConnectionHandler;
end;

procedure TDBXCommandCloseMessage.HandleMessage(const Handler: TDBXCommandHandler);
begin
  Handler.DbxCommandClose(self);
end;

procedure TDBXMoreBlobMessage.HandleMessage(const Handler: TDBXConnectionHandler);
begin
  Handler.DbxMoreBlob(self);
end;

procedure TDBXMoreBlobMessage.HandleMessage(const Handler: TDBXCommandHandler);
begin
  Handler.DbxMoreBlob(self);
end;

procedure TDBXNextMessage.HandleMessage(const Handler: TDBXCommandHandler);
begin
  Handler.DbxNext(self);
end;

procedure TDBXNextResultMessage.HandleMessage(const Handler: TDBXCommandHandler);
begin
  Handler.DbxNextResult(self);
end;

procedure TDBXOpenMessage.HandleMessage(const Handler: TDBXConnectionHandler);
begin
  Handler.DbxOpen(self);
end;

procedure TDBXPrepareMessage.Reset;
begin
  CommandHandle := -1;
  Updatable := False;
  CommandType := NullString;
  Command := NullString;
  Parameters := nil;
  ExplicitParameters := nil;
  ParameterDbxDataTypes := nil;
end;

procedure TDBXPrepareMessage.HandleMessage(const Handler: TDBXCommandHandler);
begin
  Handler.DbxPrepare(self);
end;

procedure TDBXReaderCloseMessage.HandleMessage(const Handler: TDBXCommandHandler);
begin
  Handler.DbxReaderClose(self);
end;

procedure TDBXTxBeginMessage.HandleMessage(const Handler: TDBXConnectionHandler);
begin
  Handler.DbxTxBegin(self);
end;

procedure TDBXTxEndMessage.HandleMessage(const Handler: TDBXConnectionHandler);
begin
  Handler.DbxTxEnd(self);
end;

procedure TDBXVendorPropertyMessage.HandleMessage(const Handler: TDBXConnectionHandler);
begin
  Handler.DbxVendorProperty(self);
end;

end.
