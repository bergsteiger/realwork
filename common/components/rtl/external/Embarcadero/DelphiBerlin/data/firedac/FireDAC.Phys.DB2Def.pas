{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.Phys.DB2Def;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf;

type
  // TFDPhysDB2ConnectionDefParams
  // Generated for: FireDAC DB2 driver

  TFDDB2StringFormat = (sfChoose, sfUnicode);
  TFDDB2TxSupported = (tsYes, tsNo);

  /// <summary> TFDPhysDB2ConnectionDefParams class implements FireDAC DB2 driver specific connection definition class. </summary>
  TFDPhysDB2ConnectionDefParams = class(TFDConnectionDefParams)
  private
    function GetDriverID: String;
    procedure SetDriverID(const AValue: String);
    function GetODBCAdvanced: String;
    procedure SetODBCAdvanced(const AValue: String);
    function GetLoginTimeout: Integer;
    procedure SetLoginTimeout(const AValue: Integer);
    function GetAlias: String;
    procedure SetAlias(const AValue: String);
    function GetServer: String;
    procedure SetServer(const AValue: String);
    function GetPort: Integer;
    procedure SetPort(const AValue: Integer);
    function GetProtocol: String;
    procedure SetProtocol(const AValue: String);
    function GetOSAuthent: Boolean;
    procedure SetOSAuthent(const AValue: Boolean);
    function GetStringFormat: TFDDB2StringFormat;
    procedure SetStringFormat(const AValue: TFDDB2StringFormat);
    function GetExtendedMetadata: Boolean;
    procedure SetExtendedMetadata(const AValue: Boolean);
    function GetTxSupported: TFDDB2TxSupported;
    procedure SetTxSupported(const AValue: TFDDB2TxSupported);
    function GetMetaDefSchema: String;
    procedure SetMetaDefSchema(const AValue: String);
    function GetMetaCurSchema: String;
    procedure SetMetaCurSchema(const AValue: String);
  published
    property DriverID: String read GetDriverID write SetDriverID stored False;
    property ODBCAdvanced: String read GetODBCAdvanced write SetODBCAdvanced stored False;
    property LoginTimeout: Integer read GetLoginTimeout write SetLoginTimeout stored False;
    property Alias: String read GetAlias write SetAlias stored False;
    property Server: String read GetServer write SetServer stored False;
    property Port: Integer read GetPort write SetPort stored False;
    property Protocol: String read GetProtocol write SetProtocol stored False;
    property OSAuthent: Boolean read GetOSAuthent write SetOSAuthent stored False;
    property StringFormat: TFDDB2StringFormat read GetStringFormat write SetStringFormat stored False default sfChoose;
    property ExtendedMetadata: Boolean read GetExtendedMetadata write SetExtendedMetadata stored False;
    property TxSupported: TFDDB2TxSupported read GetTxSupported write SetTxSupported stored False default tsYes;
    property MetaDefSchema: String read GetMetaDefSchema write SetMetaDefSchema stored False;
    property MetaCurSchema: String read GetMetaCurSchema write SetMetaCurSchema stored False;
  end;

implementation

uses
  FireDAC.Stan.Consts;

// TFDPhysDB2ConnectionDefParams
// Generated for: FireDAC DB2 driver

{-------------------------------------------------------------------------------}
function TFDPhysDB2ConnectionDefParams.GetDriverID: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_Common_DriverID];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysDB2ConnectionDefParams.SetDriverID(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_Common_DriverID] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysDB2ConnectionDefParams.GetODBCAdvanced: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_ODBC_ODBCAdvanced];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysDB2ConnectionDefParams.SetODBCAdvanced(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_ODBC_ODBCAdvanced] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysDB2ConnectionDefParams.GetLoginTimeout: Integer;
begin
  Result := FDef.AsInteger[S_FD_ConnParam_Common_LoginTimeout];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysDB2ConnectionDefParams.SetLoginTimeout(const AValue: Integer);
begin
  FDef.AsInteger[S_FD_ConnParam_Common_LoginTimeout] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysDB2ConnectionDefParams.GetAlias: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_DB2_Alias];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysDB2ConnectionDefParams.SetAlias(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_DB2_Alias] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysDB2ConnectionDefParams.GetServer: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_Common_Server];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysDB2ConnectionDefParams.SetServer(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_Common_Server] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysDB2ConnectionDefParams.GetPort: Integer;
begin
  Result := FDef.AsInteger[S_FD_ConnParam_Common_Port];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysDB2ConnectionDefParams.SetPort(const AValue: Integer);
begin
  FDef.AsInteger[S_FD_ConnParam_Common_Port] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysDB2ConnectionDefParams.GetProtocol: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_DB2_Protocol];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysDB2ConnectionDefParams.SetProtocol(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_DB2_Protocol] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysDB2ConnectionDefParams.GetOSAuthent: Boolean;
begin
  Result := FDef.AsYesNo[S_FD_ConnParam_Common_OSAuthent];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysDB2ConnectionDefParams.SetOSAuthent(const AValue: Boolean);
begin
  FDef.AsYesNo[S_FD_ConnParam_Common_OSAuthent] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysDB2ConnectionDefParams.GetStringFormat: TFDDB2StringFormat;
var
  s: String;
begin
  s := FDef.AsString[S_FD_ConnParam_DB2_StringFormat];
  if CompareText(s, 'Choose') = 0 then
    Result := sfChoose
  else if CompareText(s, 'Unicode') = 0 then
    Result := sfUnicode
  else
    Result := sfChoose;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysDB2ConnectionDefParams.SetStringFormat(const AValue: TFDDB2StringFormat);
const
  C_StringFormat: array[TFDDB2StringFormat] of String = ('Choose', 'Unicode');
begin
  FDef.AsString[S_FD_ConnParam_DB2_StringFormat] := C_StringFormat[AValue];
end;

{-------------------------------------------------------------------------------}
function TFDPhysDB2ConnectionDefParams.GetExtendedMetadata: Boolean;
begin
  Result := FDef.AsBoolean[S_FD_ConnParam_Common_ExtendedMetadata];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysDB2ConnectionDefParams.SetExtendedMetadata(const AValue: Boolean);
begin
  FDef.AsBoolean[S_FD_ConnParam_Common_ExtendedMetadata] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysDB2ConnectionDefParams.GetTxSupported: TFDDB2TxSupported;
var
  s: String;
begin
  s := FDef.AsString[S_FD_ConnParam_DB2_TxSupported];
  if CompareText(s, 'Yes') = 0 then
    Result := tsYes
  else if CompareText(s, 'No') = 0 then
    Result := tsNo
  else
    Result := tsYes;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysDB2ConnectionDefParams.SetTxSupported(const AValue: TFDDB2TxSupported);
const
  C_TxSupported: array[TFDDB2TxSupported] of String = ('Yes', 'No');
begin
  FDef.AsString[S_FD_ConnParam_DB2_TxSupported] := C_TxSupported[AValue];
end;

{-------------------------------------------------------------------------------}
function TFDPhysDB2ConnectionDefParams.GetMetaDefSchema: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_Common_MetaDefSchema];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysDB2ConnectionDefParams.SetMetaDefSchema(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_Common_MetaDefSchema] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysDB2ConnectionDefParams.GetMetaCurSchema: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_Common_MetaCurSchema];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysDB2ConnectionDefParams.SetMetaCurSchema(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_Common_MetaCurSchema] := AValue;
end;

end.
