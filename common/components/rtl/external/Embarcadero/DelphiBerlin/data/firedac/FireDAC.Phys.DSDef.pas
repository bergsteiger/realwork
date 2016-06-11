{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.Phys.DSDef;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf;

type
  // TFDPhysDSConnectionDefParams
  // Generated for: FireDAC DS driver

  TFDDSProtocol = (prTcp_ip);
  TFDDSCommunicationIPVersion = (cipNone, cipIP_IPv4, cipIP_IPv6);
  TFDDSAuthenticationScheme = (dsaNone, dsaBasic);

  /// <summary> TFDPhysDSConnectionDefParams class implements FireDAC DS driver specific connection definition class. </summary>
  TFDPhysDSConnectionDefParams = class(TFDConnectionDefParams)
  private
    function GetDriverID: String;
    procedure SetDriverID(const AValue: String);
    function GetDBXAdvanced: String;
    procedure SetDBXAdvanced(const AValue: String);
    function GetProtocol: TFDDSProtocol;
    procedure SetProtocol(const AValue: TFDDSProtocol);
    function GetIPImplementationID: String;
    procedure SetIPImplementationID(const AValue: String);
    function GetCommunicationIPVersion: TFDDSCommunicationIPVersion;
    procedure SetCommunicationIPVersion(const AValue: TFDDSCommunicationIPVersion);
    function GetServer: String;
    procedure SetServer(const AValue: String);
    function GetPort: Integer;
    procedure SetPort(const AValue: Integer);
    function GetBufferKBSize: Integer;
    procedure SetBufferKBSize(const AValue: Integer);
    function GetFilters: String;
    procedure SetFilters(const AValue: String);
    function GetLoginTimeout: Integer;
    procedure SetLoginTimeout(const AValue: Integer);
    function GetCommunicationTimeout: Integer;
    procedure SetCommunicationTimeout(const AValue: Integer);
    function GetURLPath: String;
    procedure SetURLPath(const AValue: String);
    function GetDatasnapContext: String;
    procedure SetDatasnapContext(const AValue: String);
    function GetDSProxyHost: String;
    procedure SetDSProxyHost(const AValue: String);
    function GetDSProxyPort: Integer;
    procedure SetDSProxyPort(const AValue: Integer);
    function GetDSProxyUsername: String;
    procedure SetDSProxyUsername(const AValue: String);
    function GetDSProxyPassword: String;
    procedure SetDSProxyPassword(const AValue: String);
    function GetDSAuthenticationScheme: TFDDSAuthenticationScheme;
    procedure SetDSAuthenticationScheme(const AValue: TFDDSAuthenticationScheme);
  published
    property DriverID: String read GetDriverID write SetDriverID stored False;
    property DBXAdvanced: String read GetDBXAdvanced write SetDBXAdvanced stored False;
    property Protocol: TFDDSProtocol read GetProtocol write SetProtocol stored False default prTCP_IP;
    property IPImplementationID: String read GetIPImplementationID write SetIPImplementationID stored False;
    property CommunicationIPVersion: TFDDSCommunicationIPVersion read GetCommunicationIPVersion write SetCommunicationIPVersion stored False;
    property Server: String read GetServer write SetServer stored False;
    property Port: Integer read GetPort write SetPort stored False default 8080;
    property BufferKBSize: Integer read GetBufferKBSize write SetBufferKBSize stored False default 32;
    property Filters: String read GetFilters write SetFilters stored False;
    property LoginTimeout: Integer read GetLoginTimeout write SetLoginTimeout stored False default 10000;
    property CommunicationTimeout: Integer read GetCommunicationTimeout write SetCommunicationTimeout stored False;
    property URLPath: String read GetURLPath write SetURLPath stored False;
    property DatasnapContext: String read GetDatasnapContext write SetDatasnapContext stored False;
    property DSProxyHost: String read GetDSProxyHost write SetDSProxyHost stored False;
    property DSProxyPort: Integer read GetDSProxyPort write SetDSProxyPort stored False default 8888;
    property DSProxyUsername: String read GetDSProxyUsername write SetDSProxyUsername stored False;
    property DSProxyPassword: String read GetDSProxyPassword write SetDSProxyPassword stored False;
    property DSAuthenticationScheme: TFDDSAuthenticationScheme read GetDSAuthenticationScheme write SetDSAuthenticationScheme stored False;
  end;

implementation

uses
  Data.DBXCommon, FireDAC.Stan.Consts;

// TFDPhysDSConnectionDefParams
// Generated for: FireDAC DS driver

{-------------------------------------------------------------------------------}
function TFDPhysDSConnectionDefParams.GetDriverID: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_Common_DriverID];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysDSConnectionDefParams.SetDriverID(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_Common_DriverID] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysDSConnectionDefParams.GetDBXAdvanced: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_TDBX_DBXAdvanced];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysDSConnectionDefParams.SetDBXAdvanced(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_TDBX_DBXAdvanced] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysDSConnectionDefParams.GetProtocol: TFDDSProtocol;
var
  s: String;
begin
  s := FDef.AsString[S_FD_ConnParam_DS_Protocol];
  if CompareText(s, 'tcp/ip') = 0 then
    Result := prTcp_ip
  else
    Result := prTCP_IP;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysDSConnectionDefParams.SetProtocol(const AValue: TFDDSProtocol);
const
  C_Protocol: array[TFDDSProtocol] of String = ('tcp/ip');
begin
  FDef.AsString[S_FD_ConnParam_DS_Protocol] := C_Protocol[AValue];
end;

{-------------------------------------------------------------------------------}
function TFDPhysDSConnectionDefParams.GetIPImplementationID: String;
begin
  Result := FDef.AsString[TDBXPropertyNames.IPImplementationID];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysDSConnectionDefParams.SetIPImplementationID(const AValue: String);
begin
  FDef.AsString[TDBXPropertyNames.IPImplementationID] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysDSConnectionDefParams.GetCommunicationIPVersion: TFDDSCommunicationIPVersion;
var
  s: String;
begin
  s := FDef.AsString[TDBXPropertyNames.CommunicationIPVersion];
  if CompareText(s, '') = 0 then
    Result := cipNone
  else if CompareText(s, 'IP_IPv4') = 0 then
    Result := cipIP_IPv4
  else if CompareText(s, 'IP_IPv6') = 0 then
    Result := cipIP_IPv6
  else
    Result := cipNone;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysDSConnectionDefParams.SetCommunicationIPVersion(const AValue: TFDDSCommunicationIPVersion);
const
  C_CommunicationIPVersion: array[TFDDSCommunicationIPVersion] of String = ('', 'IP_IPv4', 'IP_IPv6');
begin
  FDef.AsString[TDBXPropertyNames.CommunicationIPVersion] := C_CommunicationIPVersion[AValue];
end;

{-------------------------------------------------------------------------------}
function TFDPhysDSConnectionDefParams.GetServer: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_Common_Server];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysDSConnectionDefParams.SetServer(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_Common_Server] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysDSConnectionDefParams.GetPort: Integer;
begin
  if not FDef.HasValue(S_FD_ConnParam_Common_Port) then
    Result := 8080
  else
    Result := FDef.AsInteger[S_FD_ConnParam_Common_Port];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysDSConnectionDefParams.SetPort(const AValue: Integer);
begin
  FDef.AsInteger[S_FD_ConnParam_Common_Port] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysDSConnectionDefParams.GetBufferKBSize: Integer;
begin
  if not FDef.HasValue(TDBXPropertyNames.BufferKBSize) then
    Result := 32
  else
    Result := FDef.AsInteger[TDBXPropertyNames.BufferKBSize];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysDSConnectionDefParams.SetBufferKBSize(const AValue: Integer);
begin
  FDef.AsInteger[TDBXPropertyNames.BufferKBSize] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysDSConnectionDefParams.GetFilters: String;
begin
  Result := FDef.AsString[TDBXPropertyNames.Filters];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysDSConnectionDefParams.SetFilters(const AValue: String);
begin
  FDef.AsString[TDBXPropertyNames.Filters] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysDSConnectionDefParams.GetLoginTimeout: Integer;
begin
  if not FDef.HasValue(S_FD_ConnParam_Common_LoginTimeout) then
    Result := 10000
  else
    Result := FDef.AsInteger[S_FD_ConnParam_Common_LoginTimeout];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysDSConnectionDefParams.SetLoginTimeout(const AValue: Integer);
begin
  FDef.AsInteger[S_FD_ConnParam_Common_LoginTimeout] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysDSConnectionDefParams.GetCommunicationTimeout: Integer;
begin
  Result := FDef.AsInteger[TDBXPropertyNames.CommunicationTimeout];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysDSConnectionDefParams.SetCommunicationTimeout(const AValue: Integer);
begin
  FDef.AsInteger[TDBXPropertyNames.CommunicationTimeout] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysDSConnectionDefParams.GetURLPath: String;
begin
  Result := FDef.AsString[TDBXPropertyNames.URLPath];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysDSConnectionDefParams.SetURLPath(const AValue: String);
begin
  FDef.AsString[TDBXPropertyNames.URLPath] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysDSConnectionDefParams.GetDatasnapContext: String;
begin
  Result := FDef.AsString[TDBXPropertyNames.DatasnapContext];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysDSConnectionDefParams.SetDatasnapContext(const AValue: String);
begin
  FDef.AsString[TDBXPropertyNames.DatasnapContext] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysDSConnectionDefParams.GetDSProxyHost: String;
begin
  Result := FDef.AsString[TDBXPropertyNames.DSProxyHost];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysDSConnectionDefParams.SetDSProxyHost(const AValue: String);
begin
  FDef.AsString[TDBXPropertyNames.DSProxyHost] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysDSConnectionDefParams.GetDSProxyPort: Integer;
begin
  if not FDef.HasValue(TDBXPropertyNames.DSProxyPort) then
    Result := 8888
  else
    Result := FDef.AsInteger[TDBXPropertyNames.DSProxyPort];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysDSConnectionDefParams.SetDSProxyPort(const AValue: Integer);
begin
  FDef.AsInteger[TDBXPropertyNames.DSProxyPort] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysDSConnectionDefParams.GetDSProxyUsername: String;
begin
  Result := FDef.AsString[TDBXPropertyNames.DSProxyUsername];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysDSConnectionDefParams.SetDSProxyUsername(const AValue: String);
begin
  FDef.AsString[TDBXPropertyNames.DSProxyUsername] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysDSConnectionDefParams.GetDSProxyPassword: String;
begin
  Result := FDef.AsString[TDBXPropertyNames.DSProxyPassword];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysDSConnectionDefParams.SetDSProxyPassword(const AValue: String);
begin
  FDef.AsString[TDBXPropertyNames.DSProxyPassword] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysDSConnectionDefParams.GetDSAuthenticationScheme: TFDDSAuthenticationScheme;
var
  s: String;
begin
  s := FDef.AsString[TDBXPropertyNames.DSAuthenticationScheme];
  if CompareText(s, '') = 0 then
    Result := dsaNone
  else if CompareText(s, 'basic') = 0 then
    Result := dsaBasic
  else
    Result := dsaNone;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysDSConnectionDefParams.SetDSAuthenticationScheme(const AValue: TFDDSAuthenticationScheme);
const
  C_DSAuthenticationScheme: array[TFDDSAuthenticationScheme] of String = ('', 'basic');
begin
  FDef.AsString[TDBXPropertyNames.DSAuthenticationScheme] := C_DSAuthenticationScheme[AValue];
end;

end.
