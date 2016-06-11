{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{$HPPEMIT LINKUNIT}
unit Data.DbxDatasnap;

interface

uses
  Data.DBXClient,
  Data.DBXCommon,
  Data.DBXJSON,
  Data.DBXTransport,
  System.Classes;

const
  DS_CONTEXT = 'datasnap/';

type
  TDBXDatasnapProperties = class(TDBXProperties)
  strict private
    FFilters: TTransportFilterCollection;

    function GetHostName: string;
    function GetPassword: string;
    function GetUserName: string;
    function GetPort: Integer;
    function GetBufferKBSize: Integer;
    function GetServerConnection: string;
    function GetCommunicationProtocol: string;
    function GetCommunicationIPVersion: string;
    function GetURLPath: string;
    function GetDSAuthenticationUser: String;
    function GetDSAuthenticationPassword: String;
    function GetConnectTimeout: string;
    function GetCommunicationTimeout: string;
    function GetFilters: TTransportFilterCollection;
    function GetDatasnapContext: string;
    function GetDSAuthenticationScheme: string;
    function GetDSProxyHost: String;
    function GetDSProxyPort: Integer;
    function GetDSProxyUsername: String;
    function GetDSProxyPassword: String;

    procedure SetPort(const Value: Integer);
    procedure SetHostName(const Value: string);
    procedure SetPassword(const Value: string);
    procedure SetUserName(const Value: string);
    procedure SetBufferKBSize(const Value: Integer);
    procedure SetServerConnection(const Value: string);
    procedure SetCommunicationProtocol(const Value: string);
    procedure SetCommunicationIPVersion(const Value: string);
    procedure SetURLPath(const Value: string);
    procedure SetDSAuthenticationUser(const Value: string);
    procedure SetDSAuthenticationPassword(const Value: string);
    procedure SetConnectTimeout(const Value: string);
    procedure SetCommunicationTimeout(const Value: string);
    procedure SetFilters(const Value: TTransportFilterCollection);
    procedure SetDatasnapContext(const Value: string);
    procedure SetDSAuthenticationScheme(const Value: string);
    procedure SetDSProxyHost(const Value: String);
    procedure SetDSProxyPort(const Value: Integer);
    procedure SetDSProxyUsername(const Value: String);
    procedure SetDSProxyPassword(const Value: String);

    procedure OnFiltersChange(source: TObject);
    function GetValidateCertificate: TValidateCertificate;
    procedure SetValidateCertificate(Cert: TValidateCertificate);
  protected
    procedure Init; virtual;
  published

  public
    constructor Create(DBXContext: TDBXContext); override;
    constructor Create; override;

    destructor Destroy; override;
    ///<summary>Returns the ValidatePeerCertificate event from the Events collection, if one exists.</summary>
    property OnValidatePeerCertificate: TValidateCertificate read GetValidateCertificate write SetValidateCertificate;
  published
    ///  <summary>Machine name where a DataSnap Server is running and to be connected to</summary>
    property HostName: string read GetHostName write SetHostName;
    ///  <summary>Database user name when a remote database connection is expected to be
    ///    created</summary>
    property UserName: string read GetUserName write SetUserName;
    ///  <summary>Database user password required for the database connection</summary>
    property Password: string read GetPassword write SetPassword;
    ///  <summary>Port number where the DataSnap Server instance listens to</summary>
    ///  <remarks>Default value is 211</remarks>
    [Default(211)]
    property Port: Integer read GetPort write SetPort default 211;
    ///  <summary>Buffer size for a unit of communication transport</summary>
    ///  <remarks>The buffer size can affect performance, default value is 32 and
    ///    was chosen so to match the TCP/IP default packet size</remarks>
    [Default(32)]
    property BufferKBSize: Integer read GetBufferKBSize write SetBufferKBSize default 32;
    ///  <summary>Database server connectection name that is expected to be used remotely</summary>
    ///  <remarks>UserName and Password properties are used for database authentication</remarks>
    property ServerConnection: string read GetServerConnection write SetServerConnection;
    ///  <summary>Communication protocol type used for data exchange with the DataSnap Server.</summary>
    ///  <remarks>Current supported values are http and tcp/ip. Default value is tcp/ip</remarks>
    property CommunicationProtocol: string read GetCommunicationProtocol write SetCommunicationProtocol;
    ///  <summary>Communication IP version used in Indy with the DataSnap Server.</summary>
    ///  <remarks>Options are IPv6 and IPv4. Default value is IPv4</remarks>
    property CommunicationIPVersion: string read GetCommunicationIPVersion write SetCommunicationIPVersion;
    ///  <summary>URL path used for HTTP DataSnap Service when http protocol is used</summary>
    property URLPath: string read GetURLPath write SetURLPath;
    ///  <summary>DataSnap user name.</summary>
    ///  <remarks>Used for DataSnap user authentication when an
    ///    server has an authentication manager present.</remarks>
    property DSAuthUser: string read GetDSAuthenticationUser write SetDSAuthenticationUser;
    ///  <summary>DataSnap user password.</summary>
    ///  <remarks>Used in conjunction with DataSnap user name for authentication
    ///    when server has an authentication manager</remarks>
    property DSAuthPassword: string read GetDSAuthenticationPassword write SetDSAuthenticationPassword;
    ///  <summary>DataSnap authentication scheme.</summary>
    ///  <remarks>Used in conjunction with DataSnap user name and password for
    ///    authentication using the HTTP protocol.  Set to "basic" in order to
    ///    send DSAuthUser/DSAuthPassword values using basic HTTP authentication,
    //     in addition to sending these values in the DBX connection string.
    ///    Basic HTTP authentication may be used to pass credentials to 
    ///    an inter-process DataSnap HTTP tunnel server</remarks>
    property DSAuthScheme: string read GetDSAuthenticationScheme write SetDSAuthenticationScheme;
    ///  <summary>Connect timeout value.</summary>
    ///  <remarks>The values provides the number of milliseconds the client waits
    ///    for the connection to be possible. The value provides the time out for the
    ///    first server response acknowledgment rather than for the entire connect/authenticate
    ///    phase. It should be used in order to avoid application freeze when
    ///    it may be possible to attempt connections to older DataSnap Server versions
    ///    or different application that will not acknowledge current communication
    ///    protocol.</remarks>
    property ConnectTimeout: string read GetConnectTimeout write SetConnectTimeout;
    ///   <summary>Timeout value in miliseconds for a response after the connection is established</summary>
    property CommunicationTimeout: string read GetCommunicationTimeout write SetCommunicationTimeout;
    ///   <summary>Client filters, used to store the filter configuration</summary>
    property Filters: TTransportFilterCollection read GetFilters write SetFilters;
    ///   <summary>path toward the DS HTTP Service, used to compose the URL</summary>
    ///  <remarks>The current convention is: http://x.com/datasnap/provider/classname/method/params.
    ///    The user may change or delete datasnap word from it.</remarks>
    property DatasnapContext: String read GetDatasnapContext write SetDatasnapContext;
    /// <summary>The host to proxy requests through, or empty string to not use a proxy.</summary>
    property DSProxyHost: String read GetDSProxyHost write SetDSProxyHost;
    /// <summary>The port on the proxy host to proxy requests through. Ignored if DSProxyHost isn't set.
    /// </summary>
    property DSProxyPort: Integer read GetDSProxyPort write SetDSProxyPort;
    /// <summary>User name for proxy authentication.</summary>
    property DSProxyUsername: String read GetDSProxyUsername write SetDSProxyUsername;
    /// <summary>Password for proxy authentication</summary>
    property DSProxyPassword: String read GetDSProxyPassword write SetDSProxyPassword;
  end;

  TDBXDatasnapDriver = class(TDBXClientDriver)
  public
    constructor Create(DriverDef: TDBXDriverDef); override;
  end;

implementation


uses
  System.SysUtils
  , Data.DBXJSONReflect
;

const
  sDriverName = 'DataSnap';

{ TDBXDatasnapDriver }

constructor TDBXDatasnapDriver.Create(DriverDef: TDBXDriverDef);
var
  Props: TDBXDatasnapProperties;
  I, Index: Integer;
begin
  Props := TDBXDatasnapProperties.Create(DriverDef.FDBXContext);
  if DriverDef.FDriverProperties <> nil then
  begin
    for I := 0 to DriverDef.FDriverProperties.Count - 1 do
    begin
      Index := Props.Properties.IndexOfName(DriverDef.FDriverProperties.Properties.Names[I]);
      if Index > -1 then
        Props.Properties.Strings[Index] := DriverDef.FDriverProperties.Properties.Strings[I];
    end;
    Props.AddUniqueProperties(DriverDef.FDriverProperties.Properties);
    DriverDef.FDriverProperties.AddUniqueProperties(Props.Properties);
  end;
  inherited Create(DriverDef, Props);
end;

{ TDBXDatasnapProperties }


constructor TDBXDatasnapProperties.Create(DBXContext: TDBXContext);
begin
  inherited Create(DBXContext);
  Init;
end;

constructor TDBXDatasnapProperties.Create;
begin
  inherited;
  Init;
end;

destructor TDBXDatasnapProperties.Destroy;
begin
  if FFilters <> nil then
  begin
    // FFilters has content ownership
    FFilters.Clear;
    // release the container
    FFilters.Free;
  end;
  inherited;
end;

function TDBXDatasnapProperties.GetBufferKBSize: Integer;
begin
  Result := StrToIntDef(Values[TDBXPropertyNames.BufferKBSize], 32);
end;


function TDBXDatasnapProperties.GetHostName: string;
begin
  Result := Values[TDBXPropertyNames.HostName];
end;

function TDBXDatasnapProperties.GetPassword: string;
begin
  Result := Values[TDBXPropertyNames.Password];
end;


function TDBXDatasnapProperties.GetPort: Integer;
begin
  Result := StrToIntDef(Values[TDBXPropertyNames.Port], 211);
end;

function TDBXDatasnapProperties.GetServerConnection: string;
begin
  Result := Values[TDBXPropertyNames.ServerConnection];
end;

function TDBXDatasnapProperties.GetUserName: string;
begin
  Result := Values[TDBXPropertyNames.UserName];
end;

function TDBXDatasnapProperties.GetValidateCertificate: TValidateCertificate;
begin
  Result := TValidateCertificate(Events.Events[sValidatePeerCertificate]);
end;

procedure TDBXDatasnapProperties.SetValidateCertificate(Cert: TValidateCertificate);
begin
  Events.Events[sValidatePeerCertificate] := TEventPointer(Cert);
end;

procedure TDBXDatasnapProperties.Init;
begin
  Values[TDBXPropertyNames.DriverUnit] := 'Data.DbxDatasnap';
  Values[TDBXPropertyNames.HostName] := 'localhost';
  Values[TDBXPropertyNames.Port] := '211';
  Values[TDBXPropertyNames.CommunicationProtocol] := 'tcp/ip';
  Values[TDBXPropertyNames.Filters] := EmptyStr;
  Values[TDBXPropertyNames.DatasnapContext] := DS_CONTEXT;
end;

procedure TDBXDatasnapProperties.OnFiltersChange(source: TObject);
begin
  Values[TDBXPropertyNames.Filters] := FFilters.ToJSON
end;

function TDBXDatasnapProperties.GetCommunicationIPVersion: string;
begin
  Result := Values[TDBXPropertyNames.CommunicationIPVersion];
end;

function TDBXDatasnapProperties.GetCommunicationProtocol: string;
begin
  Result := Values[TDBXPropertyNames.CommunicationProtocol];
end;

function TDBXDatasnapProperties.GetCommunicationTimeout: string;
begin
  Result := Values[TDBXPropertyNames.CommunicationTimeout];
end;

function TDBXDatasnapProperties.GetConnectTimeout: string;
begin
  Result := Values[TDBXPropertyNames.ConnectTimeout];
end;

function TDBXDatasnapProperties.GetDatasnapContext: string;
begin
 Result := Values[TDBXPropertyNames.DatasnapContext];
end;

function TDBXDatasnapProperties.GetDSAuthenticationPassword: String;
begin
  Result := Values[TDBXPropertyNames.DSAuthenticationPassword];
end;

function TDBXDatasnapProperties.GetDSAuthenticationScheme: string;
begin
  Result := Values[TDBXPropertyNames.DSAuthenticationScheme];
end;

function TDBXDatasnapProperties.GetDSAuthenticationUser: String;
begin
  Result := Values[TDBXPropertyNames.DSAuthenticationUser];
end;

function TDBXDatasnapProperties.GetDSProxyHost: String;
begin
  Result := Values[TDBXPropertyNames.DSProxyHost];
end;

function TDBXDatasnapProperties.GetDSProxyPassword: String;
begin
  Result := Values[TDBXPropertyNames.DSProxyPassword];
end;

function TDBXDatasnapProperties.GetDSProxyPort: Integer;
begin
  Result := StrToIntDef(Values[TDBXPropertyNames.DSProxyPort], 8888);
end;

function TDBXDatasnapProperties.GetDSProxyUsername: String;
begin
  Result := Values[TDBXPropertyNames.DSProxyUsername];
end;

function TDBXDatasnapProperties.GetFilters: TTransportFilterCollection;
var
  json: String;
begin
  FFilters.Free;
  json := Values[TDBXPropertyNames.Filters];
  if json <> EmptyStr then
    FFilters := TTransportFilterCollection.FromJSON(json)
  else
    FFilters := TTransportFilterCollection.Create;
  FFilters.OnChange := OnFiltersChange;
  Result := FFilters;
end;

function TDBXDatasnapProperties.GetURLPath: string;
begin
  Result := Values[TDBXPropertyNames.URLPath];
end;

procedure TDBXDatasnapProperties.SetBufferKBSize(const Value: Integer);
begin
  Values[TDBXPropertyNames.BufferKBSize] := IntToStr(Value);
end;


procedure TDBXDatasnapProperties.SetHostName(const Value: string);
begin
  Values[TDBXPropertyNames.HostName] := Value;
end;

procedure TDBXDatasnapProperties.SetPassword(const Value: string);
begin
  Values[TDBXPropertyNames.Password] := Value;
end;

procedure TDBXDatasnapProperties.SetPort(const Value: Integer);
begin
  Values[TDBXPropertyNames.Port] := IntToStr(Value);
end;

procedure TDBXDatasnapProperties.SetServerConnection(const Value: string);
begin
  Values[TDBXPropertyNames.ServerConnection] := Value;
end;

procedure TDBXDatasnapProperties.SetUserName(const Value: string);
begin
  Values[TDBXPropertyNames.UserName] := Value;
end;

procedure TDBXDatasnapProperties.SetCommunicationIPVersion(const Value: string);
begin
  Values[TDBXPropertyNames.CommunicationIPVersion] := Value;
end;

procedure TDBXDatasnapProperties.SetCommunicationProtocol(const Value: string);
begin
  Values[TDBXPropertyNames.CommunicationProtocol] := Value;
end;

procedure TDBXDatasnapProperties.SetCommunicationTimeout(const Value: string);
begin
  Values[TDBXPropertyNames.CommunicationTimeout] := Value;
end;

procedure TDBXDatasnapProperties.SetConnectTimeout(const Value: string);
begin
  Values[TDBXPropertyNames.ConnectTimeout] := Value;
end;

procedure TDBXDatasnapProperties.SetDatasnapContext(const Value: string);
begin
  Values[TDBXPropertyNames.DatasnapContext] := Value;
end;

procedure TDBXDatasnapProperties.SetDSAuthenticationPassword(
  const Value: string);
begin
  Values[TDBXPropertyNames.DSAuthenticationPassword] := Value;
end;

procedure TDBXDatasnapProperties.SetDSAuthenticationUser(const Value: string);
begin
  Values[TDBXPropertyNames.DSAuthenticationUser] := Value;
end;

procedure TDBXDatasnapProperties.SetDSProxyHost(const Value: String);
begin
  Values[TDBXPropertyNames.DSProxyHost] := Value;
end;

procedure TDBXDatasnapProperties.SetDSProxyPassword(const Value: String);
begin
  Values[TDBXPropertyNames.DSProxyPassword] := Value;
end;

procedure TDBXDatasnapProperties.SetDSProxyPort(const Value: Integer);
begin
  Values[TDBXPropertyNames.DSProxyPort] := IntToStr(Value);
end;

procedure TDBXDatasnapProperties.SetDSProxyUsername(const Value: String);
begin
  Values[TDBXPropertyNames.DSProxyUsername] := Value;
end;

procedure TDBXDatasnapProperties.SetDSAuthenticationScheme(const Value: string);
begin
  Values[TDBXPropertyNames.DSAuthenticationScheme] := Value;
end;

procedure TDBXDatasnapProperties.SetFilters(
  const Value: TTransportFilterCollection);
begin
  FFilters.Free;
  FFilters := Value;
  if Assigned(Value) then
    Values[TDBXPropertyNames.Filters] := Value.ToJSON
  else
    Values[TDBXPropertyNames.Filters] := EmptyStr
end;

procedure TDBXDatasnapProperties.SetURLPath(const Value: string);
begin
  Values[TDBXPropertyNames.URLPath] := Value;
end;

initialization
  TDBXDriverRegistry.RegisterDriverClass(sDriverName, TDBXDatasnapDriver);
finalization
  TDBXDriverRegistry.UnloadDriver(sDriverName);
end.

