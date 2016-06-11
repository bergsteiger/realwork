{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.Phys.MSSQLDef;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf;

type
  // TFDPhysMSSQLConnectionDefParams
  // Generated for: FireDAC MSSQL driver

  TFDMSSQLVariantFormat = (vfString, vfBinary);
  TFDMSSQLMetaCaseInsCat = (mciChoose, mciFalse, mciTrue);

  /// <summary> TFDPhysMSSQLConnectionDefParams class implements FireDAC MSSQL driver specific connection definition class. </summary>
  TFDPhysMSSQLConnectionDefParams = class(TFDConnectionDefParams)
  private
    function GetDriverID: String;
    procedure SetDriverID(const AValue: String);
    function GetODBCAdvanced: String;
    procedure SetODBCAdvanced(const AValue: String);
    function GetLoginTimeout: Integer;
    procedure SetLoginTimeout(const AValue: Integer);
    function GetServer: String;
    procedure SetServer(const AValue: String);
    function GetNetwork: String;
    procedure SetNetwork(const AValue: String);
    function GetAddress: String;
    procedure SetAddress(const AValue: String);
    function GetOSAuthent: Boolean;
    procedure SetOSAuthent(const AValue: Boolean);
    function GetMARS: Boolean;
    procedure SetMARS(const AValue: Boolean);
    function GetWorkstation: String;
    procedure SetWorkstation(const AValue: String);
    function GetLanguage: String;
    procedure SetLanguage(const AValue: String);
    function GetEncrypt: Boolean;
    procedure SetEncrypt(const AValue: Boolean);
    function GetVariantFormat: TFDMSSQLVariantFormat;
    procedure SetVariantFormat(const AValue: TFDMSSQLVariantFormat);
    function GetExtendedMetadata: Boolean;
    procedure SetExtendedMetadata(const AValue: Boolean);
    function GetApplicationName: String;
    procedure SetApplicationName(const AValue: String);
    function GetMetaDefCatalog: String;
    procedure SetMetaDefCatalog(const AValue: String);
    function GetMetaDefSchema: String;
    procedure SetMetaDefSchema(const AValue: String);
    function GetMetaCurCatalog: String;
    procedure SetMetaCurCatalog(const AValue: String);
    function GetMetaCurSchema: String;
    procedure SetMetaCurSchema(const AValue: String);
    function GetMetaCaseIns: Boolean;
    procedure SetMetaCaseIns(const AValue: Boolean);
    function GetMetaCaseInsCat: TFDMSSQLMetaCaseInsCat;
    procedure SetMetaCaseInsCat(const AValue: TFDMSSQLMetaCaseInsCat);
  published
    property DriverID: String read GetDriverID write SetDriverID stored False;
    property ODBCAdvanced: String read GetODBCAdvanced write SetODBCAdvanced stored False;
    property LoginTimeout: Integer read GetLoginTimeout write SetLoginTimeout stored False;
    property Server: String read GetServer write SetServer stored False;
    property Network: String read GetNetwork write SetNetwork stored False;
    property Address: String read GetAddress write SetAddress stored False;
    property OSAuthent: Boolean read GetOSAuthent write SetOSAuthent stored False;
    property MARS: Boolean read GetMARS write SetMARS stored False default True;
    property Workstation: String read GetWorkstation write SetWorkstation stored False;
    property Language: String read GetLanguage write SetLanguage stored False;
    property Encrypt: Boolean read GetEncrypt write SetEncrypt stored False;
    property VariantFormat: TFDMSSQLVariantFormat read GetVariantFormat write SetVariantFormat stored False default vfString;
    property ExtendedMetadata: Boolean read GetExtendedMetadata write SetExtendedMetadata stored False;
    property ApplicationName: String read GetApplicationName write SetApplicationName stored False;
    property MetaDefCatalog: String read GetMetaDefCatalog write SetMetaDefCatalog stored False;
    property MetaDefSchema: String read GetMetaDefSchema write SetMetaDefSchema stored False;
    property MetaCurCatalog: String read GetMetaCurCatalog write SetMetaCurCatalog stored False;
    property MetaCurSchema: String read GetMetaCurSchema write SetMetaCurSchema stored False;
    property MetaCaseIns: Boolean read GetMetaCaseIns write SetMetaCaseIns stored False;
    property MetaCaseInsCat: TFDMSSQLMetaCaseInsCat read GetMetaCaseInsCat write SetMetaCaseInsCat stored False default mciChoose;
  end;

implementation

uses
  FireDAC.Stan.Consts;

// TFDPhysMSSQLConnectionDefParams
// Generated for: FireDAC MSSQL driver

{-------------------------------------------------------------------------------}
function TFDPhysMSSQLConnectionDefParams.GetDriverID: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_Common_DriverID];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMSSQLConnectionDefParams.SetDriverID(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_Common_DriverID] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMSSQLConnectionDefParams.GetODBCAdvanced: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_ODBC_ODBCAdvanced];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMSSQLConnectionDefParams.SetODBCAdvanced(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_ODBC_ODBCAdvanced] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMSSQLConnectionDefParams.GetLoginTimeout: Integer;
begin
  Result := FDef.AsInteger[S_FD_ConnParam_Common_LoginTimeout];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMSSQLConnectionDefParams.SetLoginTimeout(const AValue: Integer);
begin
  FDef.AsInteger[S_FD_ConnParam_Common_LoginTimeout] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMSSQLConnectionDefParams.GetServer: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_Common_Server];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMSSQLConnectionDefParams.SetServer(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_Common_Server] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMSSQLConnectionDefParams.GetNetwork: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_MSSQL_Network];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMSSQLConnectionDefParams.SetNetwork(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_MSSQL_Network] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMSSQLConnectionDefParams.GetAddress: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_MSSQL_Address];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMSSQLConnectionDefParams.SetAddress(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_MSSQL_Address] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMSSQLConnectionDefParams.GetOSAuthent: Boolean;
begin
  Result := FDef.AsYesNo[S_FD_ConnParam_Common_OSAuthent];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMSSQLConnectionDefParams.SetOSAuthent(const AValue: Boolean);
begin
  FDef.AsYesNo[S_FD_ConnParam_Common_OSAuthent] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMSSQLConnectionDefParams.GetMARS: Boolean;
begin
  if not FDef.HasValue(S_FD_ConnParam_MSSQL_MARS) then
    Result := True
  else
    Result := FDef.AsYesNo[S_FD_ConnParam_MSSQL_MARS];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMSSQLConnectionDefParams.SetMARS(const AValue: Boolean);
begin
  FDef.AsYesNo[S_FD_ConnParam_MSSQL_MARS] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMSSQLConnectionDefParams.GetWorkstation: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_MSSQL_Workstation];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMSSQLConnectionDefParams.SetWorkstation(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_MSSQL_Workstation] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMSSQLConnectionDefParams.GetLanguage: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_MSSQL_Language];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMSSQLConnectionDefParams.SetLanguage(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_MSSQL_Language] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMSSQLConnectionDefParams.GetEncrypt: Boolean;
begin
  Result := FDef.AsYesNo[S_FD_ConnParam_MSSQL_Encrypt];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMSSQLConnectionDefParams.SetEncrypt(const AValue: Boolean);
begin
  FDef.AsYesNo[S_FD_ConnParam_MSSQL_Encrypt] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMSSQLConnectionDefParams.GetVariantFormat: TFDMSSQLVariantFormat;
var
  s: String;
begin
  s := FDef.AsString[S_FD_ConnParam_MSSQL_VariantFormat];
  if CompareText(s, 'String') = 0 then
    Result := vfString
  else if CompareText(s, 'Binary') = 0 then
    Result := vfBinary
  else
    Result := vfString;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMSSQLConnectionDefParams.SetVariantFormat(const AValue: TFDMSSQLVariantFormat);
const
  C_VariantFormat: array[TFDMSSQLVariantFormat] of String = ('String', 'Binary');
begin
  FDef.AsString[S_FD_ConnParam_MSSQL_VariantFormat] := C_VariantFormat[AValue];
end;

{-------------------------------------------------------------------------------}
function TFDPhysMSSQLConnectionDefParams.GetExtendedMetadata: Boolean;
begin
  Result := FDef.AsBoolean[S_FD_ConnParam_Common_ExtendedMetadata];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMSSQLConnectionDefParams.SetExtendedMetadata(const AValue: Boolean);
begin
  FDef.AsBoolean[S_FD_ConnParam_Common_ExtendedMetadata] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMSSQLConnectionDefParams.GetApplicationName: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_Common_ApplicationName];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMSSQLConnectionDefParams.SetApplicationName(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_Common_ApplicationName] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMSSQLConnectionDefParams.GetMetaDefCatalog: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_Common_MetaDefCatalog];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMSSQLConnectionDefParams.SetMetaDefCatalog(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_Common_MetaDefCatalog] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMSSQLConnectionDefParams.GetMetaDefSchema: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_Common_MetaDefSchema];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMSSQLConnectionDefParams.SetMetaDefSchema(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_Common_MetaDefSchema] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMSSQLConnectionDefParams.GetMetaCurCatalog: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_Common_MetaCurCatalog];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMSSQLConnectionDefParams.SetMetaCurCatalog(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_Common_MetaCurCatalog] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMSSQLConnectionDefParams.GetMetaCurSchema: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_Common_MetaCurSchema];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMSSQLConnectionDefParams.SetMetaCurSchema(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_Common_MetaCurSchema] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMSSQLConnectionDefParams.GetMetaCaseIns: Boolean;
begin
  Result := FDef.AsBoolean[S_FD_ConnParam_Common_MetaCaseIns];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMSSQLConnectionDefParams.SetMetaCaseIns(const AValue: Boolean);
begin
  FDef.AsBoolean[S_FD_ConnParam_Common_MetaCaseIns] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMSSQLConnectionDefParams.GetMetaCaseInsCat: TFDMSSQLMetaCaseInsCat;
var
  s: String;
begin
  s := FDef.AsString[S_FD_ConnParam_MSSQL_MetaCaseInsCat];
  if CompareText(s, 'Choose') = 0 then
    Result := mciChoose
  else if CompareText(s, 'False') = 0 then
    Result := mciFalse
  else if CompareText(s, 'True') = 0 then
    Result := mciTrue
  else
    Result := mciChoose;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMSSQLConnectionDefParams.SetMetaCaseInsCat(const AValue: TFDMSSQLMetaCaseInsCat);
const
  C_MetaCaseInsCat: array[TFDMSSQLMetaCaseInsCat] of String = ('Choose', 'False', 'True');
begin
  FDef.AsString[S_FD_ConnParam_MSSQL_MetaCaseInsCat] := C_MetaCaseInsCat[AValue];
end;

end.
