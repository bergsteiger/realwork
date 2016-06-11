{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.Phys.ODBCDef;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Phys.Intf;

type
  // TFDPhysODBCConnectionDefParams
  // Generated for: FireDAC ODBC driver

  TFDODBCNumericFormat = (nfBinary, nfString);
  TFDODBCVersion = (ov3_8, ov3_0);

  /// <summary> TFDPhysODBCConnectionDefParams class implements FireDAC ODBC driver specific connection definition class. </summary>
  TFDPhysODBCConnectionDefParams = class(TFDConnectionDefParams)
  private
    function GetDriverID: String;
    procedure SetDriverID(const AValue: String);
    function GetODBCAdvanced: String;
    procedure SetODBCAdvanced(const AValue: String);
    function GetLoginTimeout: Integer;
    procedure SetLoginTimeout(const AValue: Integer);
    function GetODBCDriver: String;
    procedure SetODBCDriver(const AValue: String);
    function GetDataSource: String;
    procedure SetDataSource(const AValue: String);
    function GetNumericFormat: TFDODBCNumericFormat;
    procedure SetNumericFormat(const AValue: TFDODBCNumericFormat);
    function GetODBCVersion: TFDODBCVersion;
    procedure SetODBCVersion(const AValue: TFDODBCVersion);
    function GetMetaDefCatalog: String;
    procedure SetMetaDefCatalog(const AValue: String);
    function GetMetaDefSchema: String;
    procedure SetMetaDefSchema(const AValue: String);
    function GetMetaCurCatalog: String;
    procedure SetMetaCurCatalog(const AValue: String);
    function GetMetaCurSchema: String;
    procedure SetMetaCurSchema(const AValue: String);
    function GetRDBMS: TFDRDBMSKind;
    procedure SetRDBMS(const AValue: TFDRDBMSKind);
  published
    property DriverID: String read GetDriverID write SetDriverID stored False;
    property ODBCAdvanced: String read GetODBCAdvanced write SetODBCAdvanced stored False;
    property LoginTimeout: Integer read GetLoginTimeout write SetLoginTimeout stored False;
    property ODBCDriver: String read GetODBCDriver write SetODBCDriver stored False;
    property DataSource: String read GetDataSource write SetDataSource stored False;
    property NumericFormat: TFDODBCNumericFormat read GetNumericFormat write SetNumericFormat stored False default nfString;
    property ODBCVersion: TFDODBCVersion read GetODBCVersion write SetODBCVersion stored False default ov3_0;
    property MetaDefCatalog: String read GetMetaDefCatalog write SetMetaDefCatalog stored False;
    property MetaDefSchema: String read GetMetaDefSchema write SetMetaDefSchema stored False;
    property MetaCurCatalog: String read GetMetaCurCatalog write SetMetaCurCatalog stored False;
    property MetaCurSchema: String read GetMetaCurSchema write SetMetaCurSchema stored False;
    property RDBMS: TFDRDBMSKind read GetRDBMS write SetRDBMS stored False;
  end;

implementation

uses
  FireDAC.Stan.Consts;

// TFDPhysODBCConnectionDefParams
// Generated for: FireDAC ODBC driver

{-------------------------------------------------------------------------------}
function TFDPhysODBCConnectionDefParams.GetDriverID: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_Common_DriverID];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysODBCConnectionDefParams.SetDriverID(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_Common_DriverID] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysODBCConnectionDefParams.GetODBCAdvanced: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_ODBC_ODBCAdvanced];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysODBCConnectionDefParams.SetODBCAdvanced(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_ODBC_ODBCAdvanced] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysODBCConnectionDefParams.GetLoginTimeout: Integer;
begin
  Result := FDef.AsInteger[S_FD_ConnParam_Common_LoginTimeout];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysODBCConnectionDefParams.SetLoginTimeout(const AValue: Integer);
begin
  FDef.AsInteger[S_FD_ConnParam_Common_LoginTimeout] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysODBCConnectionDefParams.GetODBCDriver: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_ODBC_ODBCDriver];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysODBCConnectionDefParams.SetODBCDriver(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_ODBC_ODBCDriver] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysODBCConnectionDefParams.GetDataSource: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_ODBC_DataSource];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysODBCConnectionDefParams.SetDataSource(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_ODBC_DataSource] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysODBCConnectionDefParams.GetNumericFormat: TFDODBCNumericFormat;
var
  s: String;
begin
  s := FDef.AsString[S_FD_ConnParam_ODBC_NumericFormat];
  if CompareText(s, 'Binary') = 0 then
    Result := nfBinary
  else if CompareText(s, 'String') = 0 then
    Result := nfString
  else
    Result := nfString;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysODBCConnectionDefParams.SetNumericFormat(const AValue: TFDODBCNumericFormat);
const
  C_NumericFormat: array[TFDODBCNumericFormat] of String = ('Binary', 'String');
begin
  FDef.AsString[S_FD_ConnParam_ODBC_NumericFormat] := C_NumericFormat[AValue];
end;

{-------------------------------------------------------------------------------}
function TFDPhysODBCConnectionDefParams.GetODBCVersion: TFDODBCVersion;
var
  s: String;
begin
  s := FDef.AsString[S_FD_ConnParam_ODBC_ODBCVersion];
  if CompareText(s, '3.8') = 0 then
    Result := ov3_8
  else if CompareText(s, '3.0') = 0 then
    Result := ov3_0
  else
    Result := ov3_0;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysODBCConnectionDefParams.SetODBCVersion(const AValue: TFDODBCVersion);
const
  C_ODBCVersion: array[TFDODBCVersion] of String = ('3.8', '3.0');
begin
  FDef.AsString[S_FD_ConnParam_ODBC_ODBCVersion] := C_ODBCVersion[AValue];
end;

{-------------------------------------------------------------------------------}
function TFDPhysODBCConnectionDefParams.GetMetaDefCatalog: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_Common_MetaDefCatalog];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysODBCConnectionDefParams.SetMetaDefCatalog(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_Common_MetaDefCatalog] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysODBCConnectionDefParams.GetMetaDefSchema: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_Common_MetaDefSchema];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysODBCConnectionDefParams.SetMetaDefSchema(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_Common_MetaDefSchema] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysODBCConnectionDefParams.GetMetaCurCatalog: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_Common_MetaCurCatalog];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysODBCConnectionDefParams.SetMetaCurCatalog(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_Common_MetaCurCatalog] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysODBCConnectionDefParams.GetMetaCurSchema: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_Common_MetaCurSchema];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysODBCConnectionDefParams.SetMetaCurSchema(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_Common_MetaCurSchema] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysODBCConnectionDefParams.GetRDBMS: TFDRDBMSKind;
var
  oManMeta: IFDPhysManagerMetadata;
begin
  FDPhysManager.CreateMetadata(oManMeta);
  Result := oManMeta.GetRDBMSKind(FDef.AsString[S_FD_ConnParam_Common_RDBMS]);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysODBCConnectionDefParams.SetRDBMS(const AValue: TFDRDBMSKind);
var
  oManMeta: IFDPhysManagerMetadata;
begin
  FDPhysManager.CreateMetadata(oManMeta);
  FDef.AsString[S_FD_ConnParam_Common_RDBMS] := oManMeta.GetRDBMSName(AValue);
end;

end.
