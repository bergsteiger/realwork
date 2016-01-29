{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

/// <summary> dunit database related extensions.
/// Supports the properties to be specified on the command line.
/// The "connection" command line property directs TDBXTestCase to
/// use the connection in your dbxconnections.ini as the default connection
/// returned by TDBXTestCase.DbxConnection.  This can also be used to
/// specify ado.net connection strings that have been persisted in the dbxconnections.ini
/// file.  ado.net connection strings require an additional section and two
/// property settings as follows:
///
///   [AdoIbLocal]
///   providerName=Borland.Data.AdoDbxClient
///   ConnectionString=ConnectionName=IBLOCAL;
///
/// The IBLOCAL refers to a regular dbexpress connection property section that looks
/// something like this:
///
///   [IBLOCAL]
///   //DelegateConnection=DBXTraceConnection
///   ServerCharSet=UNICODE_FSS
///   drivername=INTERBASE
///   Database=C:\Program Files\Borland\InterBase\examples\database\employee.gdb
///   rolename=RoleName
///   user_name=sysdba
///   Password=masterkey
///   sqldialect=3
///   blobsize=-1
///   commitretain=False
///   waitonlocks=True
///   localecode=0000
///   interbase transisolation=ReadCommitted
///   trim char=False
///
/// There is also a test selection command line option than can be used to only
/// execute tests that start with a specific prefix.  So to run all tests that
/// begin with "Test", a command line option of "-s:Test" should be specified.
/// If you are reporting a bug, the name of your test method should start with the
/// letter "o" to indicate that the test is open.  When the bug is fixed, we will
/// remove the "o" from the name of the test method so that the test will be run
/// automatically with our automated regression test system.
///
/// </summary>

unit DbxTest;

interface

uses
  TestFrameworkExtension, System.Classes, Data.DBXCommon, Data.DbxMetaDataProvider,
  System.Generics.Collections;

const
  //command line property to specify dbxConnection name
  sConnectionName = 'connection';
  sAdoDbxClientProvider ='Borland.Data.AdoDbxClient';

type

  //custom test case to looks for a
  //command line property to setup SQLConnection or ALL
  TDBXTestCase = class(TTestCaseExtension)
  private
    FConnection: TDBXConnection;
    FDBXName: string;
    FMetaDataProvider: TDbxMetaDataProvider;
    FTearDownList: TList<TObject>;
    procedure FreeTearDownList;
  protected
    function  IsExtendedMetaDataBeingUsed(ConnectionName: string): Boolean;
    function  GetDbxConnection: TDbxConnection; virtual;
    procedure ExecuteStatement(const CommandText: string);
    procedure ExecuteStatementIgnoreError(const CommandText: string);
    function  GetMetaDataProvider: TDbxMetaDataProvider;
    function IsTypeSupported(DataType, SubType: Integer): Boolean;
    function GetIsCreateTableInMultiStatementTransactionSupported: Boolean;
    function StartMetaDataTransaction: TObject;
    procedure CommitFreeAndNilMetaDataTransaction(var Transaction: TObject);
    procedure RollbackMetaDataTransaction(var Transaction: TObject);

    ///  <summary>
    ///    Important note on this version of setup.  It uses information passed in
    ///  from the command line to determine which type of dialect to create.  If
    ///  the extended meta data model is being used, which is deteced from the drivers,
    ///  then it will load an TExtendMDDialect.  Otherwise it will use the static
    ///  implementations, TInterbaseDialect, TOracleDialect, etc...
    ///  </summary>
    procedure TearDown; override;
  public
    constructor Create(MethodName: string); override;
    destructor  Destroy; override;

    procedure FreeOnTearDown(Item: TObject);

    function GetName: string; override;
    procedure SetName(AName: string);

    ///<summary>
    ///  Will drop the specified table name if it exists.  Any exceptions
    ///  thrown will be ignored.
    ///</summary>
    procedure DropTable(TableName: string);

    ///<summary>
    /// This method can be used to generate a string id that can be
    /// appended to identifiers such as a table or stored procedures
    /// to help make the identifier more unique.  The return value
    /// is currently not guaranteed to be completely unique.  Using
    /// GetHostId helps to avoid name conflicts when multiple computers
    /// are executing similar tests against the same database server.
    ///</summary>

    function GetHostId: string;

    ///<summary>
    ///  Connection Property that will return a TDBXConnection.
    ///   Note* Since TDBXConnections are returned from the ConnectionFactory
    ///  connected, which may cause problems in a large test environment,
    ///  it is recommended to access Connection as late as possible,
    ///  and to call CloseDbxConnection().  If Close connection is not called, then
    ///  it will be called automatically in TearDown.
    ///  </summary>
    property DbxConnection: TDBXConnection read GetDbxConnection;
    procedure CloseDbxConnection; virtual;
    property MetaDataProvider: TDbxMetaDataProvider read GetMetaDataProvider;
    property IsCreateTableInMultiStatementTransactionSupported: Boolean read GetIsCreateTableInMultiStatementTransactionSupported;
  end;


implementation

uses
  Data.DBXDataExpressMetaDataProvider,
{$IFDEF POSIX}
  Posix.UniStd,
{$ENDIF}
  System.SysUtils
{$IFDEF MACOS}
  , Macapi.CoreFoundation
{$ENDIF MACOS}
;

{ TDBXTestCase }

procedure TDBXTestCase.CommitFreeAndNilMetaDataTransaction(var Transaction: TObject);
begin
  DbxConnection.CommitFreeAndNil(TDBXTransaction(Transaction));
end;

constructor TDBXTestCase.Create(MethodName: string);
begin
  inherited Create(MethodName);
  FTearDownList := TList<TObject>.Create;
  FDBXName := MethodName;
  FConnection := nil;
end;

destructor TDBXTestCase.Destroy;
begin
  FreeTearDownList;
  FreeAndNil(FMetaDataProvider);
  FreeAndNil(FTearDownList);
  FreeAndNil(FConnection);
  inherited;
end;

procedure TDBXTestCase.DropTable(TableName: string);
begin
  try
    MetaDataProvider.DropTable(TableName);
  except
  end;
end;

procedure TDBXTestCase.ExecuteStatement(const CommandText: string);
var
  DBXCommand: TDBXCommand;
begin
  try
    DBXCommand := DbxConnection.CreateCommand;
    DBXCommand.Text := CommandText;
    DBXCommand.ExecuteQuery;
  finally
    FreeAndNil(DBXCommand);
    CloseDbxConnection;
  end;
end;

procedure TDBXTestCase.ExecuteStatementIgnoreError(
  const CommandText: string);
begin
  try
    ExecuteStatement(CommandText);
  except on Ex: Exception do
  end;
end;

procedure TDBXTestCase.FreeOnTearDown(Item: TObject);
begin
  FTearDownList.Add(Item);
end;

procedure TDBXTestCase.FreeTearDownList;
begin
{$IFNDEF NEXTGEN}
  while FTearDownList.Count > 0 do
  begin
    FTearDownList[0].Free;
    FTearDownList[0] := nil;
    FTearDownList.Delete(0);
  end;
{$ENDIF}
  FTearDownList.Clear;
end;

function TDBXTestCase.GetMetaDataProvider: TDbxMetaDataProvider;
var
  Provider: TDBXDataExpressMetaDataProvider;
begin
  if FMetaDataProvider = nil then
  begin
    Provider := TDBXDataExpressMetaDataProvider.Create;
    Provider.Connection := DbxConnection;
    Provider.Open;
    FMetaDataProvider := Provider;
  end;
  Result := FMetaDataProvider;
end;

function TDBXTestCase.GetName: string;
begin
  Result := Properties.Values[sConnectionName] + '_' + FDBXName;
end;

function TDBXTestCase.GetDbxConnection: TDbxConnection;
var
  LConnectionFactory: TDBXConnectionFactory;
begin
  if FConnection = nil then
  begin
    LConnectionFactory := TDBXConnectionFactory.GetConnectionFactory;
    TDBXConnectionFactory.Lock;
    try
      FConnection := LConnectionFactory.GetConnection(Properties.Values[sConnectionName],'','');
    finally
      TDBXConnectionFactory.Unlock;
    end;
  end;
  Result := FConnection;
end;

function TDBXTestCase.GetHostId: string;
{$IFDEF POSIX}
var
  MachName: array[0..7] of Byte;
{$ENDIF}
const
  ComputerName = 'COMPUTERNAME';
  MaxHostLength = 8;
begin
  Result := 'UNKNOWN';
{$IFDEF POSIX}
  if Posix.Unistd.gethostname(MarshaledAString(@MachName[0]), MaxHostLength) = 0 then
    Result := TMarshal.ReadStringAsUTF8(TPtrWrapper.Create(@MachName[0])).ToUpper;
{$ELSE}
  if GetEnvironmentVariable(ComputerName) <> '' then
    Result := GetEnvironmentVariable(ComputerName);
{$ENDIF}
  Result := Result.Replace('.', '');
  Result := Result.Replace(' ', '');
  Result := Result.Replace('-', '');
  if Result.Length > MaxHostLength then
    Result := Result.Remove(MaxHostLength-2);
end;

function TDBXTestCase.GetIsCreateTableInMultiStatementTransactionSupported: Boolean;
begin
  if MetaDataProvider.DatabaseProduct = 'Sybase SQL Server' then
    Result := False
  else
    Result := True;
end;

function TDBXTestCase.IsExtendedMetaDataBeingUsed(ConnectionName: string): Boolean;
var
  CurrentDriver: string;
  MDPackageLoader, MDAssemblyLoader: string;
  LConnectionFactory: TDBXConnectionFactory;
begin
  LConnectionFactory := TDBXConnectionFactory.GetConnectionFactory;
  begin
    TDBXConnectionFactory.Lock;
    try
      //use the current connection to determine which driver it uses
      CurrentDriver := LConnectionFactory.GetConnectionProperties(ConnectionName).Values[TDBXPropertyNames.DriverName];

      //check the dirver params for presence of new Extended MetaData values
      MDPackageLoader := LConnectionFactory.GetDriverProperties(CurrentDriver).Values[TDBXPropertyNames.MetaDataPackageLoader];
      MDAssemblyLoader := LConnectionFactory.GetDriverProperties(CurrentDriver).Values[TDBXPropertyNames.MetaDataAssemblyLoader];
    finally
      TDBXConnectionFactory.Unlock;
    end;
  end;
  Result := MDPackageLoader <> '';
end;

procedure TDBXTestCase.RollbackMetaDataTransaction(var Transaction: TObject);
begin
  DbxConnection.RollbackFreeAndNil(TDBXTransaction(Transaction));
end;

procedure TDBXTestCase.CloseDbxConnection;
begin
  FreeAndNil(FMetaDataProvider);
  FreeAndNil(FConnection);
end;

procedure TDBXTestCase.SetName(AName: string);
begin
  FDBXName := AName;
end;

function TDBXTestCase.StartMetaDataTransaction: TObject;
begin
  Result := DbxConnection.BeginTransaction;
end;

procedure TDBXTestCase.TearDown;
begin
  inherited;
  FreeTearDownList;
  FreeAndNil(FMetaDataProvider);
  FreeAndNil(FConnection);
end;

function TDBXTestCase.IsTypeSupported(DataType, SubType: Integer): Boolean;
begin
  if DbxConnection.GetVendorProperty('DriverDataTypes').IndexOf('{' + IntToStr(DataType) + ',' + IntToStr(SubType)) <> -1 then
    Result := True
  else
    Result := False;
end;

end.
