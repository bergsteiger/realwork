{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.Phys.ADSDef;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Phys.ADSWrapper;

type
  // TFDPhysADSConnectionDefParams
  // Generated for: FireDAC ADS driver

  TFDADSServerTypes = (stNone, stRemote, stLocal, stInternet);
  TFDADSProtocol = (prNone, prUDP, prIPX, prTCPIP, prTLS);
  TFDADSCharacterSet = (csANSI, csOEM);
  TFDADSCompress = (cmNone, cmInternet, cmAlways, cmNever);
  TFDADSLocking = (lcNone, lcProprietary, lcCompatible);

  /// <summary> TFDPhysADSConnectionDefParams class implements FireDAC ADS driver specific connection definition class. </summary>
  TFDPhysADSConnectionDefParams = class(TFDConnectionDefParams)
  private
    function GetDriverID: String;
    procedure SetDriverID(const AValue: String);
    function GetAlias: String;
    procedure SetAlias(const AValue: String);
    function GetServerTypes: TFDADSServerTypes;
    procedure SetServerTypes(const AValue: TFDADSServerTypes);
    function GetProtocol: TFDADSProtocol;
    procedure SetProtocol(const AValue: TFDADSProtocol);
    function GetServer: String;
    procedure SetServer(const AValue: String);
    function GetPort: Integer;
    procedure SetPort(const AValue: Integer);
    function GetCharacterSet: TFDADSCharacterSet;
    procedure SetCharacterSet(const AValue: TFDADSCharacterSet);
    function GetCompress: TFDADSCompress;
    procedure SetCompress(const AValue: TFDADSCompress);
    function GetTableType: TADSTableType;
    procedure SetTableType(const AValue: TADSTableType);
    function GetTablePassword: String;
    procedure SetTablePassword(const AValue: String);
    function GetLocking: TFDADSLocking;
    procedure SetLocking(const AValue: TFDADSLocking);
    function GetADSAdvanced: String;
    procedure SetADSAdvanced(const AValue: String);
    function GetMetaDefCatalog: String;
    procedure SetMetaDefCatalog(const AValue: String);
    function GetMetaCurCatalog: String;
    procedure SetMetaCurCatalog(const AValue: String);
  published
    property DriverID: String read GetDriverID write SetDriverID stored False;
    property Alias: String read GetAlias write SetAlias stored False;
    property ServerTypes: TFDADSServerTypes read GetServerTypes write SetServerTypes stored False;
    property Protocol: TFDADSProtocol read GetProtocol write SetProtocol stored False;
    property Server: String read GetServer write SetServer stored False;
    property Port: Integer read GetPort write SetPort stored False;
    property CharacterSet: TFDADSCharacterSet read GetCharacterSet write SetCharacterSet stored False default csANSI;
    property Compress: TFDADSCompress read GetCompress write SetCompress stored False;
    property TableType: TADSTableType read GetTableType write SetTableType stored False default ttDefault;
    property TablePassword: String read GetTablePassword write SetTablePassword stored False;
    property Locking: TFDADSLocking read GetLocking write SetLocking stored False;
    property ADSAdvanced: String read GetADSAdvanced write SetADSAdvanced stored False;
    property MetaDefCatalog: String read GetMetaDefCatalog write SetMetaDefCatalog stored False;
    property MetaCurCatalog: String read GetMetaCurCatalog write SetMetaCurCatalog stored False;
  end;

implementation

uses
  FireDAC.Stan.Consts;

// TFDPhysADSConnectionDefParams
// Generated for: FireDAC ADS driver

{-------------------------------------------------------------------------------}
function TFDPhysADSConnectionDefParams.GetDriverID: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_Common_DriverID];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysADSConnectionDefParams.SetDriverID(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_Common_DriverID] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSConnectionDefParams.GetAlias: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_ADS_Alias];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysADSConnectionDefParams.SetAlias(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_ADS_Alias] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSConnectionDefParams.GetServerTypes: TFDADSServerTypes;
var
  s: String;
begin
  s := FDef.AsString[S_FD_ConnParam_ADS_ServerTypes];
  if CompareText(s, '') = 0 then
    Result := stNone
  else if CompareText(s, 'Remote') = 0 then
    Result := stRemote
  else if CompareText(s, 'Local') = 0 then
    Result := stLocal
  else if CompareText(s, 'Internet') = 0 then
    Result := stInternet
  else
    Result := stNone;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysADSConnectionDefParams.SetServerTypes(const AValue: TFDADSServerTypes);
const
  C_ServerTypes: array[TFDADSServerTypes] of String = ('', 'Remote', 'Local', 'Internet');
begin
  FDef.AsString[S_FD_ConnParam_ADS_ServerTypes] := C_ServerTypes[AValue];
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSConnectionDefParams.GetProtocol: TFDADSProtocol;
var
  s: String;
begin
  s := FDef.AsString[S_FD_ConnParam_ADS_Protocol];
  if CompareText(s, '') = 0 then
    Result := prNone
  else if CompareText(s, 'UDP') = 0 then
    Result := prUDP
  else if CompareText(s, 'IPX') = 0 then
    Result := prIPX
  else if CompareText(s, 'TCPIP') = 0 then
    Result := prTCPIP
  else if CompareText(s, 'TLS') = 0 then
    Result := prTLS
  else
    Result := prNone;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysADSConnectionDefParams.SetProtocol(const AValue: TFDADSProtocol);
const
  C_Protocol: array[TFDADSProtocol] of String = ('', 'UDP', 'IPX', 'TCPIP', 'TLS');
begin
  FDef.AsString[S_FD_ConnParam_ADS_Protocol] := C_Protocol[AValue];
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSConnectionDefParams.GetServer: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_Common_Server];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysADSConnectionDefParams.SetServer(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_Common_Server] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSConnectionDefParams.GetPort: Integer;
begin
  Result := FDef.AsInteger[S_FD_ConnParam_Common_Port];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysADSConnectionDefParams.SetPort(const AValue: Integer);
begin
  FDef.AsInteger[S_FD_ConnParam_Common_Port] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSConnectionDefParams.GetCharacterSet: TFDADSCharacterSet;
var
  s: String;
begin
  s := FDef.AsString[S_FD_ConnParam_Common_CharacterSet];
  if CompareText(s, 'ANSI') = 0 then
    Result := csANSI
  else if CompareText(s, 'OEM') = 0 then
    Result := csOEM
  else
    Result := csANSI;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysADSConnectionDefParams.SetCharacterSet(const AValue: TFDADSCharacterSet);
const
  C_CharacterSet: array[TFDADSCharacterSet] of String = ('ANSI', 'OEM');
begin
  FDef.AsString[S_FD_ConnParam_Common_CharacterSet] := C_CharacterSet[AValue];
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSConnectionDefParams.GetCompress: TFDADSCompress;
var
  s: String;
begin
  s := FDef.AsString[S_FD_ConnParam_ADS_Compress];
  if CompareText(s, '') = 0 then
    Result := cmNone
  else if CompareText(s, 'Internet') = 0 then
    Result := cmInternet
  else if CompareText(s, 'Always') = 0 then
    Result := cmAlways
  else if CompareText(s, 'Never') = 0 then
    Result := cmNever
  else
    Result := cmNone;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysADSConnectionDefParams.SetCompress(const AValue: TFDADSCompress);
const
  C_Compress: array[TFDADSCompress] of String = ('', 'Internet', 'Always', 'Never');
begin
  FDef.AsString[S_FD_ConnParam_ADS_Compress] := C_Compress[AValue];
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSConnectionDefParams.GetTableType: TADSTableType;
var
  s: String;
begin
  s := FDef.AsString[S_FD_ConnParam_ADS_TableType];
  if CompareText(s, 'Default') = 0 then
    Result := ttDefault
  else if CompareText(s, 'CDX') = 0 then
    Result := ttCDX
  else if CompareText(s, 'VFP') = 0 then
    Result := ttVFP
  else if CompareText(s, 'ADT') = 0 then
    Result := ttADT
  else if CompareText(s, 'NTX') = 0 then
    Result := ttNTX
  else
    Result := ttDefault;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysADSConnectionDefParams.SetTableType(const AValue: TADSTableType);
const
  C_TableType: array[TADSTableType] of String = ('Default', 'CDX', 'VFP', 'ADT', 'NTX');
begin
  FDef.AsString[S_FD_ConnParam_ADS_TableType] := C_TableType[AValue];
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSConnectionDefParams.GetTablePassword: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_ADS_TablePassword];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysADSConnectionDefParams.SetTablePassword(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_ADS_TablePassword] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSConnectionDefParams.GetLocking: TFDADSLocking;
var
  s: String;
begin
  s := FDef.AsString[S_FD_ConnParam_ADS_Locking];
  if CompareText(s, '') = 0 then
    Result := lcNone
  else if CompareText(s, 'Proprietary') = 0 then
    Result := lcProprietary
  else if CompareText(s, 'Compatible') = 0 then
    Result := lcCompatible
  else
    Result := lcNone;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysADSConnectionDefParams.SetLocking(const AValue: TFDADSLocking);
const
  C_Locking: array[TFDADSLocking] of String = ('', 'Proprietary', 'Compatible');
begin
  FDef.AsString[S_FD_ConnParam_ADS_Locking] := C_Locking[AValue];
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSConnectionDefParams.GetADSAdvanced: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_ADS_ADSAdvanced];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysADSConnectionDefParams.SetADSAdvanced(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_ADS_ADSAdvanced] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSConnectionDefParams.GetMetaDefCatalog: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_Common_MetaDefCatalog];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysADSConnectionDefParams.SetMetaDefCatalog(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_Common_MetaDefCatalog] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysADSConnectionDefParams.GetMetaCurCatalog: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_Common_MetaCurCatalog];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysADSConnectionDefParams.SetMetaCurCatalog(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_Common_MetaCurCatalog] := AValue;
end;

end.
