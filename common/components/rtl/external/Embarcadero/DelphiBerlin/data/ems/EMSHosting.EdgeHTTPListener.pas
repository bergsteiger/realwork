{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit EMSHosting.EdgeHTTPListener;

{$HPPEMIT LINKUNIT}
interface

uses EMSHosting.EdgeService, EMSHosting.EdgeHTTPServer,
  System.Classes, System.JSON;

type
  TCustomEMSEdgeHTTPListener = class(TEMSEdgeListener)
  public type
    TCreateModuleEvent = reference to function: TEMSEdgeListener.TModule;
  private
    FServer: TEMSEdgeHTTPServer;
    FHost: string;
    FModule: TEMSEdgeListener.TModule;
    function Getport: Cardinal;
    procedure Setport(const Value: Cardinal);
  protected
    function GetActive: Boolean; override;
    procedure SetActive(const Value: Boolean); override;
    function GetModule: TEMSEdgeListener.TModule; override;
    procedure AddProtocolProps(const AProtocolProps: TJSONObject); override;
    property Server: TEMSEdgeHTTPServer read FServer;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Host: string read FHost write FHost;
    property Port: Cardinal read Getport write Setport;
  end;

  TEMSEdgeHTTPListener = class(TCustomEMSEdgeHTTPListener)
  published
    property Port;
    property Host;
                                 
  end;

  TCustomEMSEdgeHTTPSListener = class(TCustomEMSEdgeHTTPListener)
  public type
    TGetPasswordEvent = procedure(Sender: TObject; var APassword: string) of object;
  private
    FOnGetKeyPassword: TGetPasswordEvent;
    function GetCertFile: string;
    function GetKeyFile: string;
    function GetRootCertFile: string;
    procedure SetCertFile(const Value: string);
    procedure SetKeyFile(const Value: string);
    procedure SetRootCertFile(const Value: string);
  protected
    procedure DoGetKeyPassword(var APassword: string); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    /// <summary>File of the X.509 certificate</summary>
    property CertFile: string read GetCertFile write SetCertFile;
    /// <summary>File of the X.509 private key</summary>
    property KeyFile: string read GetKeyFile write SetKeyFile;
    /// <summary>File of the X.509 root certificate</summary>
    property RootCertFile: string read GetRootCertFile write SetRootCertFile;
    /// <summary>Event handler to provide the string used to encrypt the private key in KeyFile</summary>
    property OnGetKeyPassword: TGetPasswordEvent read FOnGetKeyPassword write FOnGetKeyPassword;
  end;

  TEMSEdgeHTTPSListener = class(TCustomEMSEdgeHTTPSListener)
  published
    property Port;
    property Host;
    property CertFile;
    property KeyFile;
    property OnGetKeyPassword;
    property RootCertFile;
  end;

implementation

uses EMSHosting.EdgeListeners, System.SysUtils;

{ TCustomEMSEdgHTTPListenerFactory }

type
  TCustomEMSEdgHTTPListenerFactory = class(TEMSEdgeListenerFactory)
  protected
    function DoCreateListener(const AOwner: TComponent; const AProtocolName: string): TEMSEdgeListener; override;
  end;

  TCustomEMSEdgHTTPSListenerFactory = class(TEMSEdgeListenerFactory)
  protected
    function DoCreateListener(const AOwner: TComponent; const AProtocolName: string): TEMSEdgeListener; override;
  end;

const
  sHttp = 'http';
  sHttps = 'https';
  sPort = 'port';
  sHost = 'host';

{ TCustomEMSEdgeHTTPListener }

constructor TCustomEMSEdgeHTTPListener.Create(AOwner: TComponent);
begin
  inherited;
  FServer := TEMSEdgeHTTPServer.Create;
end;

destructor TCustomEMSEdgeHTTPListener.Destroy;
begin
  FServer.Free;
  inherited;
end;

function TCustomEMSEdgeHTTPListener.GetActive: Boolean;
begin
  Result := FServer.Active;
end;

function TCustomEMSEdgeHTTPListener.GetModule: TEMSEdgeListener.TModule;
begin
  if FModule = nil then
    FModule := CreateModule;
  Result := FModule;
end;

function TCustomEMSEdgeHTTPListener.Getport: Cardinal;
begin
  Result := FServer.Port;
end;

procedure TCustomEMSEdgeHTTPListener.AddProtocolProps(const AProtocolProps: TJSONObject);
begin
  AProtocolProps.AddPair(sPort, TJSONNumber.Create(Port));
  AProtocolProps.AddPair(sHost, TJSONString.Create(Host));
end;

procedure TCustomEMSEdgeHTTPListener.SetActive(const Value: Boolean);
begin
  if FServer.Active <> Value then
  begin
    FServer.Module := nil;
    FreeAndNil(FModule);
    if Value then
      FServer.Module := Module;
    FServer.Active := Value;
  end;
end;

procedure TCustomEMSEdgeHTTPListener.Setport(const Value: Cardinal);
begin
  FServer.Port := Value;
end;

{ TCustomEMSEdgHTTPListenerFactory }

function TCustomEMSEdgHTTPListenerFactory.DoCreateListener(
  const AOwner: TComponent; const AProtocolName: string): TEMSEdgeListener;
begin
  Result := TEMSEdgeHTTPListener.Create(AOwner);
end;

{ TCustomEMSEdgHTTPSListenerFactory }

function TCustomEMSEdgHTTPSListenerFactory.DoCreateListener(
  const AOwner: TComponent; const AProtocolName: string): TEMSEdgeListener;
begin
  Result := TEMSEdgeHTTPSListener.Create(AOwner);
end;

const
  sUnit = 'EMSHosting.EdgeHTTPListener';
{ TCustomEMSEdgeHTTPSListener }

constructor TCustomEMSEdgeHTTPSListener.Create(AOwner: TComponent);
begin
  inherited;
  Server.OnGetSSLPassword := DoGetKeyPassword;
  Server.HTTPS := True;
end;

procedure TCustomEMSEdgeHTTPSListener.DoGetKeyPassword(var APassword: string);
begin
  if Assigned(FOnGetKeyPassword) then
    FOnGetKeyPassword(Self, APassword);


end;

function TCustomEMSEdgeHTTPSListener.GetCertFile: string;
begin
  Result := FServer.CertFile;
end;

function TCustomEMSEdgeHTTPSListener.GetKeyFile: string;
begin
  Result := FServer.KeyFile;
end;

function TCustomEMSEdgeHTTPSListener.GetRootCertFile: string;
begin
  Result := FServer.RootCertFile;
end;

procedure TCustomEMSEdgeHTTPSListener.SetCertFile(const Value: string);
begin
  FServer.CertFile := Value;
end;

procedure TCustomEMSEdgeHTTPSListener.SetKeyFile(const Value: string);
begin
  FServer.KeyFile := Value;
end;

procedure TCustomEMSEdgeHTTPSListener.SetRootCertFile(const Value: string);
begin
  FServer.RootCertFile := Value;
end;

initialization
  TEMSEdgeListenerFactories.Instance.Add(sHttp, sUnit, // Do not localize
    TCustomEMSEdgHTTPListenerFactory.Create);
  TEMSEdgeListenerFactories.Instance.Add(sHttps, sUnit, // Do not localize
    TCustomEMSEdgHTTPSListenerFactory.Create);
finalization
  TEMSEdgeListenerFactories.Instance.Remove(sHttp);
end.
