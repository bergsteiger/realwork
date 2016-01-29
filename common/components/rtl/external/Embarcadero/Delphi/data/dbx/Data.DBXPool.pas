{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{$HPPEMIT '#pragma link "Data.DBXPool"'}    {Do not Localize}
unit Data.DBXPool;

interface

uses
  Data.DBXCommon,
  Data.DBXPlatform,
  System.Classes,
  Data.DBXDelegate,
  System.Generics.Collections,
  System.SyncObjs
;


const
  sDriverName = 'DBXPool';

type

  ///<summary>the DBXPool delegate driver specific connection properties</summary>
  TDBXPoolPropertyNames = class
  const
    /// <remarks>Maximum number of connections allocated in a connection pool.</remarks>
    MaxConnections = 'MaxConnections'; { do not localize }
    /// <remarks>Minimum number of connections allocated in a connection pool.</remarks>
    MinConnections = 'MinConnections'; { do not localize }
    /// <remarks>Number of wait time seconds to wait for a connection.</remarks>
    ConnectTimeout = 'ConnectTimeout'; { do not localize }

  end;

  /// <summary>
  /// DBXCommand instances that are created with the TDBXCommandType.DBXConnectionPool
  /// command type can have their TDBXCommand.Text property set to one of the commands
  /// below.
  /// </summary>
  TDBXPoolCommands = class
  const
    /// <summary>Returns a TDBXReader instance with the TDBXPoolsTable columns.</summary>
    GetPools = 'GetPools'; { Do not localize }
  end;

  /// <summary>Columns returned by executing the TDBXPoolCommands.GetPools command</summary>
  TDBXPoolsTable = class
  const
    /// <summary>Name of connection if any.</summary>
    ConnectionName = 'ConnectionName'; { Do not localize }
    /// <summary>Name of driver for this connection.</summary>
    DriverName = 'DriverName'; { Do not localize }
    /// <summary>Name of database for this connection.</summary>
    DatabaseName = 'DatabaseName'; { Do not localize }
    /// <summary>Name of user for this connection.</summary>
    UserName = 'UserName'; { Do not localize }
    /// <summary>Unique path of all delegate drivers used for this connection.</summary>
    DelegateSignature = 'DelegateSignature'; { Do not localize }
    /// <summary>Integer time out in milliseconds for this connection.</summary>
    ConnectTimeout = 'ConnectTimeout'; { Do not localize }
    /// <summary>Integer count open connections in the pool available for use.</summary>
    AvailableConnections = 'AvailableConnections'; { Do not localize }
    /// <summary>Integer count of the total connections in the pool.</summary>
    TotalConnections = 'TotalConnections'; { Do not localize }
    /// <summary>Integer count of the maximum connections in the pool.</summary>
    MaxConnections = 'MaxConnections'; { Do not localize }

  end;

  TDBXPool = class;
  TDBXPoolDriver = class;

  TDBXPoolConnection = class(TDBXDelegateConnection)
  private
    [Weak]FPoolDriver: TDBXPoolDriver;
    [Weak]FPool: TDBXPool;
  protected
    procedure DerivedGetCommandTypes(const List: TStrings); override;
    procedure DerivedGetCommands(const CommandType: string;
      const List: TStrings); override;
    procedure Open; override;
  public
    constructor Create(Pool: TDBXPool; ConnectionBuilder: TDBXConnectionBuilder;
      PoolDriver: TDBXPoolDriver; Connection: TDBXConnection);
    destructor Destroy; override;
    function CreateCommand: TDBXCommand; overload; override;
  end;

  TDBXPoolCommand = class(TDBXCommand)
  private
    [Weak]FPool: TDBXPool;
    function ExecuteGetPools: TDBXReader;
  protected
    procedure SetMaxBlobSize(const MaxBlobSize: Int64); override;
    procedure SetRowSetSize(const Value: Int64); override;
    procedure DerivedOpen; override;
    procedure DerivedClose; override;

    function DerivedGetNextReader: TDBXReader; override;
    function DerivedExecuteQuery: TDBXReader; override;
    procedure DerivedExecuteUpdate; override;
    procedure DerivedPrepare; override;
    function GetRowsAffected: Int64; override;
    constructor Create(DBXContext: TDBXContext; Pool: TDBXPool);
  public
    destructor Destroy; override;
  end;

  TDBXPoolReader = class(TDBXReader)
  private
    FByteReader: TDBXReaderByteReader;
  protected
    function DerivedNext: Boolean; override;
    procedure DerivedClose; override;
    function GetByteReader: TDBXByteReader; override;
  public
    constructor Create(DBXContext: TDBXContext; DbxRow: TDBXRow;
      ByteReader: TDBXByteReader);
    destructor Destroy; override;
  end;

  TDBXPoolRow = class(TDBXRow)
  private
    [Weak]FPoolList: TList<TDBXPool>;
    FRow: Integer;
    function Next: Boolean;
  protected
    procedure GetWideString(DbxValue: TDBXWideStringValue;
      var WideStringBuilder: TDBXWideStringBuilder; var IsNull: LongBool); override;
    procedure GetInt32(DbxValue: TDBXInt32Value; var Value: TInt32;
      var IsNull: LongBool); override;
  public
    constructor Create(PoolList: TList<TDBXPool>; DBXContext: TDBXContext);
  end;

  TDBXPool = class
  private
    FSemaphore: TDBXSemaphore;
    FCriticalSection: TCriticalSection;

    FAllConnectionArray: array of TDBXConnection;
    FAvailableConnectionArray: array of TDBXConnection;

    [Weak]FPoolDriver: TDBXPoolDriver;
    FConnectionName: string;
    FDriverName: string;
    FDatabaseName: string;
    FUserName: string;
    FDelegateSignature: string;
    FConnectTimeout: Integer;
    FTotalConnections: Integer;
    FAvailableConnections: Integer;
    FMaxConnections: Integer;

    constructor Create(Driver: TDBXPoolDriver;
      ConnectionBuilder: TDBXConnectionBuilder);
    function IsEqual(ConnectionBuilder: TDBXConnectionBuilder; const ConnectionName: string;
                     const DelegateSignature: string; const DriverName: string;
                     const DatabaseName: string; const UserName: string): Boolean;

    function GetConnection(ConnectionBuilder: TDBXConnectionBuilder): TDBXConnection;
    procedure ReleaseConnection(Connection: TDBXConnection);
    procedure ClearPool;
  public
    destructor Destroy; override;
  end;

  TDBXPoolDriver = class(TDBXDriver)
  private
    FPoolList: TList<TDBXPool>;

    function FindPool(ConnectionBuilder: TDBXConnectionBuilder): TDBXPool;
    procedure ClearPools;
    function CreatePoolCommand(DBXContext: TDBXContext;
      Connection: TDBXConnection; MorphicCommand: TDBXCommand): TDBXCommand;
  protected
    procedure Close; override;
  public
    destructor Destroy; override;
    constructor Create(DriverDef: TDBXDriverDef); override;
    function CreateConnection(ConnectionBuilder: TDBXConnectionBuilder): TDBXConnection; override;
    function GetDriverVersion: string; override;
  end;

  TDBXPoolProperties = class(TDBXProperties)
  strict private
  const
    StrMaxConnections = 'MaxConnections';

  const
    StrMinConnections = 'MinConnections';

  const
    StrConnectTimeout = 'ConnectTimeout';
    function GetConnectTimeout: Integer;
    function GetMaxConnections: Integer;
    function GetMinConnections: Integer;
    procedure SetConnectTimeout(const Value: Integer);
    procedure SetMaxConnections(const Value: Integer);
    procedure SetMinConnections(const Value: Integer);
  public
    constructor Create(DBXContext: TDBXContext); override;
  published
    property MaxConnections: Integer read GetMaxConnections write SetMaxConnections;
    property MinConnections: Integer read GetMinConnections write SetMinConnections;
    property ConnectTimeout: Integer read GetConnectTimeout write SetConnectTimeout;
  end;


implementation

uses
  System.SysUtils,
  Data.DBXCommonResStrs
;

type

  TDBXColumnDef = record
    Name: string;
    DataType: TDBXType;
    SubType: TDBXType;
    Precision: TInt32;
    Scale: TInt32;
    Size: TInt32;
    ValueTypeFlags: TInt32;
  end;

  TDBXAccessorConnection = class(TDBXConnection)
  end;

const
  WideStringPrecision = 96;
  PoolValueTypeFlags =
    TDBXValueTypeFlags.Nullable or TDBXValueTypeFlags.ReadOnly or
    TDBXValueTypeFlags.Searchable;
  PoolColumnDefs: array [0 .. 8] of TDBXColumnDef =
    (
      (Name: TDBXPoolsTable.ConnectionName; DataType: TDBXDataTypes.WideStringType; SubType: TDBXDataTypes.UnknownType; Precision: WideStringPrecision; Scale: -1; Size: WideStringPrecision; ValueTypeFlags: PoolValueTypeFlags),
      (Name: TDBXPoolsTable.DriverName;           DataType: TDBXDataTypes.WideStringType; SubType: TDBXDataTypes.UnknownType; Precision: WideStringPrecision; Scale: -1; Size: WideStringPrecision; ValueTypeFlags: PoolValueTypeFlags),
      (Name: TDBXPoolsTable.DatabaseName;         DataType: TDBXDataTypes.WideStringType; SubType: TDBXDataTypes.UnknownType; Precision: WideStringPrecision; Scale: -1; Size: WideStringPrecision; ValueTypeFlags: PoolValueTypeFlags),
      (Name: TDBXPoolsTable.UserName;             DataType: TDBXDataTypes.WideStringType; SubType: TDBXDataTypes.UnknownType; Precision: WideStringPrecision; Scale: -1; Size: WideStringPrecision; ValueTypeFlags: PoolValueTypeFlags),
      (Name: TDBXPoolsTable.DelegateSignature;    DataType: TDBXDataTypes.WideStringType; SubType: TDBXDataTypes.UnknownType; Precision: WideStringPrecision; Scale: -1; Size: WideStringPrecision; ValueTypeFlags: PoolValueTypeFlags),
      (Name: TDBXPoolsTable.ConnectTimeout;       DataType: TDBXDataTypes.Int32Type;      SubType: TDBXDataTypes.UnknownType; Precision: WideStringPrecision; Scale: -1; Size: WideStringPrecision; ValueTypeFlags: PoolValueTypeFlags),
      (Name: TDBXPoolsTable.AvailableConnections; DataType: TDBXDataTypes.Int32Type;      SubType: TDBXDataTypes.UnknownType; Precision: WideStringPrecision; Scale: -1; Size: WideStringPrecision; ValueTypeFlags: PoolValueTypeFlags),
      (Name: TDBXPoolsTable.TotalConnections;     DataType: TDBXDataTypes.Int32Type;      SubType: TDBXDataTypes.UnknownType; Precision: WideStringPrecision; Scale: -1; Size: WideStringPrecision; ValueTypeFlags: PoolValueTypeFlags),
      (Name: TDBXPoolsTable.MaxConnections;       DataType: TDBXDataTypes.Int32Type;      SubType: TDBXDataTypes.UnknownType; Precision: WideStringPrecision; Scale: -1; Size: WideStringPrecision; ValueTypeFlags: PoolValueTypeFlags)
    );

{ TDBXPoolDriver }

constructor TDBXPoolDriver.Create(DriverDef: TDBXDriverDef);
begin
  inherited Create(DriverDef);
  FPoolList :=  TList<TDBXPool>.Create;
  CacheUntilFinalization;
  AddCommandFactory(TDBXCommandTypes.DbxPool, CreatePoolCommand);
  InitDriverProperties(TDBXPoolProperties.Create(DriverDef.FDBXContext));
end;

function TDBXPoolDriver.CreateConnection(
  ConnectionBuilder: TDBXConnectionBuilder): TDBXConnection;
var
  Pool: TDBXPool;
begin
  Pool := FindPool(ConnectionBuilder);
  if Pool = nil then
  begin
    Pool := TDBXPool.Create(Self, ConnectionBuilder);
    FPoolList.Add(Pool);
  end;
  Result := Pool.GetConnection(ConnectionBuilder);
end;

function TDBXPoolDriver.CreatePoolCommand(DbxContext: TDBXContext;
  Connection: TDBXConnection; MorphicCommand: TDBXCommand): TDBXCommand;
begin
  Result := TDBXPoolCommand.Create(DBXContext, TDBXPoolConnection(Connection).FPool);
end;

destructor TDBXPoolDriver.Destroy;
var
  Pool: TDBXPool;
  Index: Integer;
begin
  for Index := 0 to FPoolList.Count - 1 do
  begin
    Pool := FPoolList[Index];
    Pool.Destroy;
  end;
  FreeAndNil(FPoolList);
  inherited;
end;

function TDBXPoolDriver.FindPool(
  ConnectionBuilder: TDBXConnectionBuilder): TDBXPool;
var
  Index: Integer;
  Pool: TDBXPool;
  DatabaseName, DelegateSignature, DriverName: string;
begin
  DelegateSignature := ConnectionBuilder.DelegationSignature;
  DriverName        := ConnectionBuilder.InputConnectionProperties[TDBXPropertyNames.DriverName];
  DatabaseName      := ConnectionBuilder.InputConnectionProperties[TDBXPropertyNames.Database];
  for Index := 0 to FPoolList.Count - 1 do
  begin
    Pool := FPoolList[Index];
    if Pool.IsEqual(ConnectionBuilder,
                    ConnectionBuilder.InputConnectionName,
                    DelegateSignature,
                    DriverName,
                    DatabaseName,
                    ConnectionBuilder.InputUserName) then
    begin
      Result := Pool;
      Exit;
    end;
  end;
  Result := nil;
end;

function TDBXPoolDriver.GetDriverVersion: string;
begin
  Result := 'DBXPoolDriver 1.0'; {Do not localize}
end;

{ TDBXPool }

constructor TDBXPool.Create(Driver: TDBXPoolDriver; ConnectionBuilder: TDBXConnectionBuilder);
var
  Properties: TDBXProperties;
begin
  inherited Create;
  FPoolDriver         := Driver;
  FConnectionName     := ConnectionBuilder.InputConnectionName;
  FDelegateSignature  := ConnectionBuilder.DelegationSignature;
  FDriverName         := ConnectionBuilder.InputConnectionProperties[TDBXPropertyNames.DriverName];
  FDatabaseName       := ConnectionBuilder.InputConnectionProperties[TDBXPropertyNames.Database];
  FUserName           := ConnectionBuilder.InputUserName;
  Properties          := ConnectionBuilder.ConnectionProperties;
  FTotalConnections   := Properties.GetInteger(TDBXPoolPropertyNames.MinConnections);


  if FTotalConnections < 0 then
    FTotalConnections := 0;
  FMaxConnections := Properties.GetInteger(TDBXPoolPropertyNames.MaxConnections);
  if FMaxConnections < 1 then
    FMaxConnections := 16;
  FConnectTimeout     := Properties.GetInteger(TDBXPoolPropertyNames.ConnectTimeout);
  if FConnectTimeout < 0 then
    FConnectTimeout := 0;

  FSemaphore          := TDBXSemaphore.Create(FMaxConnections);
  FCriticalSection    := TCriticalSection.Create;

  SetLength(FAllConnectionArray, FTotalConnections);
  SetLength(FAvailableConnectionArray, FTotalConnections);
end;

procedure TDBXPoolDriver.ClearPools;
var
  Pool: TDBXPool;
  Index: Integer;
begin
  if FPoolList <> nil then
  begin
    for Index := 0 to FPoolList.Count - 1 do
    begin
      Pool := FPoolList[Index];
      Pool.ClearPool;
    end;
  end;
end;

procedure TDBXPoolDriver.Close;
begin
  ClearPools;
end;

procedure TDBXPool.ClearPool;
var
  Index: Integer;
begin
  for Index := 0 to FTotalConnections-1 do
      FAllConnectionArray[Index].Free;
  FTotalConnections       := 0;
  FAvailableConnections   := 0;
end;

destructor TDBXPool.Destroy;
begin
  ClearPool;
  SetLength(FAllConnectionArray, 0);
  SetLength(FAvailableConnectionArray, 0);
  FreeandNil(FCriticalSection);
  FreeAndNil(FSemaphore);
  inherited;
end;

function TDBXPool.IsEqual(
  ConnectionBuilder:  TDBXConnectionBuilder;
  const ConnectionName:     string;
  const DelegateSignature:  string;
  const DriverName:         string;
  const DatabaseName:       string;
  const UserName:           string): Boolean;

begin
  if (FConnectionName = ConnectionName) and (ConnectionName <> '') then
  begin
    if FUserName = UserName then
      Result := true
    else
      Result := false;
  end else
  begin
    if FDatabaseName <> DatabaseName then
      Result := false
    else if FUserName <> UserName then
      Result := false
    else if FDriverName <> DriverName then
      Result := false
    else if FDelegateSignature <> DelegateSignature then
      Result := false
    else
      Result := true;
  end;
end;

function TDBXPool.GetConnection(
  ConnectionBuilder: TDBXConnectionBuilder): TDBXConnection;
begin
  Result := nil;
  if not FSemaphore.Acquire(FConnectTimeout) then
    ConnectionBuilder.DBXContext.Error(TDBXErrorCodes.ConnectionFailed,
                                      Format(SConnectTimeout, [IntToStr(FConnectTimeout)]));
  try
    FCriticalSection.Acquire;
    try
      if FAvailableConnections < 1 then
      begin
        SetLength(FAllConnectionArray, FTotalConnections+1);
        SetLength(FAvailableConnectionArray, FTotalConnections+1);
        FAllConnectionArray[FTotalConnections] := ConnectionBuilder.CreateDelegateeConnection;
        FAvailableConnectionArray[0]   := FAllConnectionArray[FTotalConnections];
        Inc(FTotalConnections);
        Inc(FAvailableConnections);
      end;
      Result := TDBXPoolConnection.Create(Self, ConnectionBuilder, FPoolDriver, FAvailableConnectionArray[FAvailableConnections-1]);
      dec(FAvailableConnections);
    finally
      FCriticalSection.Release;
    end;
  finally
    // Something went wrong, let go of the semaphore.
    //
    if Result = nil then
      FSemaphore.Release;
  end;
end;

procedure TDBXPool.ReleaseConnection(Connection: TDBXConnection);
begin
  FCriticalSection.Acquire;
  try
    FAvailableConnectionArray[FAvailableConnections] := Connection;
    Inc(FAvailableConnections);
  finally
    FCriticalSection.Release;
  end;
  FSemaphore.Release;
end;

{ TDBXPoolConnection }

constructor TDBXPoolConnection.Create(Pool: TDBXPool; ConnectionBuilder: TDBXConnectionBuilder;
  PoolDriver: TDBXPoolDriver; Connection: TDBXConnection);
begin
  inherited Create(ConnectionBuilder, Connection);
  FPoolDriver := PoolDriver;
  FPool := Pool;
end;

function TDBXPoolConnection.CreateCommand: TDBXCommand;
begin
  Result := TDBXMorphicCommand.Create(FDBXContext, Self);
end;


procedure TDBXPoolConnection.DerivedGetCommands(const CommandType: string;
  const List: TStrings);
begin
  if CommandType = TDBXCommandTypes.DbxPool then
    List.Add(TDBXPoolCommands.GetPools);
  inherited;
end;

procedure TDBXPoolConnection.Open;
begin
  TDBXAccessorConnection(FConnection).Open;
end;

procedure TDBXPoolConnection.DerivedGetCommandTypes(const List: TStrings);
begin
  if List.IndexOf(TDBXCommandTypes.DbxPool) < 0 then
    List.Add(TDBXCommandTypes.DbxPool);
  inherited;
end;

destructor TDBXPoolConnection.Destroy;
begin
  FPool.ReleaseConnection(FConnection);
  FConnection := nil; // Prevent if from being freed.
  inherited;
end;


{ TDBXPoolCommand }


constructor TDBXPoolCommand.Create(DBXContext: TDBXContext; Pool: TDBXPool);
begin
  inherited Create(DBXContext);
  FPool       := Pool;
end;


destructor TDBXPoolCommand.Destroy;
begin
  inherited;
end;

function TDBXPoolCommand.ExecuteGetPools: TDBXReader;
var
  Column: TDBXValueType;
  ColumnDef: TDBXColumnDef;
  Values: TDBXValueArray;
  ColumnCount, Ordinal: Integer;
  DbxPoolReader: TDBXPoolReader;
  DbxPoolRow: TDBXPoolRow;
begin
    DbxPoolRow          := TDBXPoolRow.Create(FPool.FPoolDriver.FPoolList, FDBXContext);
    DbxPoolReader       := TDBXPoolReader.Create(FDBXContext, DbxPoolRow, nil);
    try
      ColumnCount         := Length(PoolColumnDefs);
      SetLength(Values, ColumnCount);
      for Ordinal := 0 to ColumnCount-1 do
      begin
        Column                := TDBXDriverHelp.CreateTDBXValueType(FDBXContext);
        ColumnDef             := PoolColumnDefs[Ordinal];
        Column.DataType       := ColumnDef.DataType;
        Column.SubType        := ColumnDef.SubType;
        Column.Ordinal        := Ordinal;
        Column.Precision      := ColumnDef.Precision;
        Column.Scale          := ColumnDef.Scale;
        Column.Size           := ColumnDef.Size;
        Column.ValueTypeFlags := ColumnDef.ValueTypeFlags;
        Column.Name           := ColumnDef.Name;

        Values[Ordinal] := TDBXValue.CreateValue(FDBXContext, Column, DbxPoolRow, true);

      end;

      DbxPoolReader.SetValues(Values);

      Result := DbxPoolReader;

      DbxPoolReader := nil;
    finally
      DbxPoolReader.Free;
    end;
end;


function TDBXPoolCommand.GetRowsAffected: Int64;
begin
  Result := -1;
end;

procedure TDBXPoolCommand.DerivedClose;
begin
end;

procedure TDBXPoolCommand.SetMaxBlobSize(const MaxBlobSize: Int64);
begin
  NotImplemented;
end;

procedure TDBXPoolCommand.SetRowSetSize(const Value: Int64);
begin
  NotImplemented;
end;

function TDBXPoolCommand.DerivedExecuteQuery: TDBXReader;
begin
    if (Text = TDBXPoolCommands.GetPools) then
    begin
      Result := ExecuteGetPools;
    end
    else
    begin
      FDBXContext.Error(TDBXErrorCodes.NotImplemented,
                   Format(SInvalidCommand, [Text]));
      Result := nil;
    end;
end;


procedure TDBXPoolCommand.DerivedExecuteUpdate;
begin
  NotImplemented;
end;

function TDBXPoolCommand.DerivedGetNextReader: TDBXReader;
begin
  Result := nil;
end;

procedure TDBXPoolCommand.DerivedOpen;
begin
end;

procedure TDBXPoolCommand.DerivedPrepare;
begin
end;

{ TDBXPoolReader }

constructor TDBXPoolReader.Create(DBXContext: TDBXContext; DbxRow: TDBXRow;
  ByteReader: TDBXByteReader);
begin
  inherited Create(DBXContext, DbxRow, ByteReader);

end;

destructor TDBXPoolReader.Destroy;
begin

  inherited;
end;

function TDBXPoolReader.GetByteReader: TDBXByteReader;
begin
  if FByteReader = nil then
    FByteReader := TDBXReaderByteReader.Create(FDbxContext, Self);
  Result := FByteReader;
end;

procedure TDBXPoolReader.DerivedClose;
begin
  FreeAndNil(FDbxRow);
  FreeAndNil(FByteReader);
end;

function TDBXPoolReader.DerivedNext: Boolean;
begin
  if FDbxRow = nil then
    Result := False
  else
    Result := TDBXPoolRow(FDbxRow).Next;
end;

{ TDBXPoolRow }

constructor TDBXPoolRow.Create(PoolList: TList<TDBXPool>; DBXContext: TDBXContext);
begin
  inherited Create(DBXContext);
  FRow := -1;
  FPoolList := PoolList;
end;

procedure TDBXPoolRow.GetInt32(DbxValue: TDBXInt32Value; var Value: TInt32;
  var IsNull: LongBool);
var
  Pool: TDBXPool;
begin
  IsNull := false;
  Pool := FPoolList[FRow];
  case DbxValue.ValueType.Ordinal of
    5: Value := Pool.FConnectTimeout;
    6: Value := Pool.FAvailableConnections;
    7: Value := Pool.FTotalConnections;
    8: Value := Pool.FMaxConnections;
    else
      Assert(False);
  end;
end;

procedure TDBXPoolRow.GetWideString(DbxValue: TDBXWideStringValue;
  var WideStringBuilder: TDBXWideStringBuilder; var IsNull: LongBool);
var
  Pool: TDBXPool;
  Value: string;
begin
  IsNull := False;
  Pool := FPoolList[FRow];
  case DbxValue.ValueType.Ordinal of
    0: Value := Pool.FConnectionName;
    1: Value := Pool.FDriverName;
    2: Value := Pool.FDatabaseName;
    3: Value := Pool.FUserName;
    4: Value := Pool.FDelegateSignature;
    else
      Assert(False);
  end;
  TDBXPlatform.CopyWideStringToBuilder(Value, DBXValue.ValueType.Size, WideStringBuilder);
end;

function TDBXPoolRow.Next: Boolean;
begin
  if (FRow+1) >= FPoolList.Count then
    Result := False
  else
  begin
    Inc(FRow);
    Inc(FGeneration);
    Result := True;
  end;
end;

{ TDBXPoolProperties }

function TDBXPoolProperties.GetConnectTimeout: Integer;
begin
  Result := StrToIntDef(Values[StrConnectTimeout], -1);
end;

function TDBXPoolProperties.GetMaxConnections: Integer;
begin
  Result := StrToIntDef(Values[StrMaxConnections], -1);
end;

function TDBXPoolProperties.GetMinConnections: Integer;
begin
  Result := StrToIntDef(Values[StrMinConnections], -1);
end;

procedure TDBXPoolProperties.SetConnectTimeout(const Value: Integer);
begin
  Values[StrConnectTimeout] := IntToStr(Value);
end;

procedure TDBXPoolProperties.SetMaxConnections(const Value: Integer);
begin
  Values[StrMaxConnections] := IntToStr(Value);
end;

procedure TDBXPoolProperties.SetMinConnections(const Value: Integer);
begin
  Values[StrMinConnections] := IntToStr(Value);
end;

constructor TDBXPoolProperties.Create(DBXContext: TDBXContext);
begin
  inherited Create(DBXContext);

  MaxConnections := 20;
  MinConnections := 1;
  ConnectTimeout := 1000;

  Values[TDBXPropertyNames.DriverUnit] := 'Data.DBXPool';
  Values[TDBXPropertyNames.DelegateDriver] := BoolToStr(True, True);
end;


initialization
  TDBXDriverRegistry.RegisterDriverClass(sDriverName, TDBXPoolDriver);

end.







