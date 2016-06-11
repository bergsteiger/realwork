{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.Phys.ASADef;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf;

type
  // TFDPhysASAConnectionDefParams
  // Generated for: FireDAC ASA driver

  /// <summary> TFDPhysASAConnectionDefParams class implements FireDAC ASA driver specific connection definition class. </summary>
  TFDPhysASAConnectionDefParams = class(TFDConnectionDefParams)
  private
    function GetDriverID: String;
    procedure SetDriverID(const AValue: String);
    function GetODBCAdvanced: String;
    procedure SetODBCAdvanced(const AValue: String);
    function GetLoginTimeout: Integer;
    procedure SetLoginTimeout(const AValue: Integer);
    function GetServer: String;
    procedure SetServer(const AValue: String);
    function GetDatabaseFile: TFileName;
    procedure SetDatabaseFile(const AValue: TFileName);
    function GetOSAuthent: Boolean;
    procedure SetOSAuthent(const AValue: Boolean);
    function GetCompress: Boolean;
    procedure SetCompress(const AValue: Boolean);
    function GetEncrypt: String;
    procedure SetEncrypt(const AValue: String);
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
  published
    property DriverID: String read GetDriverID write SetDriverID stored False;
    property ODBCAdvanced: String read GetODBCAdvanced write SetODBCAdvanced stored False;
    property LoginTimeout: Integer read GetLoginTimeout write SetLoginTimeout stored False;
    property Server: String read GetServer write SetServer stored False;
    property DatabaseFile: TFileName read GetDatabaseFile write SetDatabaseFile stored False;
    property OSAuthent: Boolean read GetOSAuthent write SetOSAuthent stored False;
    property Compress: Boolean read GetCompress write SetCompress stored False;
    property Encrypt: String read GetEncrypt write SetEncrypt stored False;
    property ApplicationName: String read GetApplicationName write SetApplicationName stored False;
    property MetaDefCatalog: String read GetMetaDefCatalog write SetMetaDefCatalog stored False;
    property MetaDefSchema: String read GetMetaDefSchema write SetMetaDefSchema stored False;
    property MetaCurCatalog: String read GetMetaCurCatalog write SetMetaCurCatalog stored False;
    property MetaCurSchema: String read GetMetaCurSchema write SetMetaCurSchema stored False;
  end;

implementation

uses
  FireDAC.Stan.Consts;

// TFDPhysASAConnectionDefParams
// Generated for: FireDAC ASA driver

{-------------------------------------------------------------------------------}
function TFDPhysASAConnectionDefParams.GetDriverID: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_Common_DriverID];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysASAConnectionDefParams.SetDriverID(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_Common_DriverID] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysASAConnectionDefParams.GetODBCAdvanced: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_ODBC_ODBCAdvanced];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysASAConnectionDefParams.SetODBCAdvanced(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_ODBC_ODBCAdvanced] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysASAConnectionDefParams.GetLoginTimeout: Integer;
begin
  Result := FDef.AsInteger[S_FD_ConnParam_Common_LoginTimeout];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysASAConnectionDefParams.SetLoginTimeout(const AValue: Integer);
begin
  FDef.AsInteger[S_FD_ConnParam_Common_LoginTimeout] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysASAConnectionDefParams.GetServer: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_Common_Server];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysASAConnectionDefParams.SetServer(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_Common_Server] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysASAConnectionDefParams.GetDatabaseFile: TFileName;
begin
  Result := FDef.AsString[S_FD_ConnParam_ASA_DatabaseFile];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysASAConnectionDefParams.SetDatabaseFile(const AValue: TFileName);
begin
  FDef.AsString[S_FD_ConnParam_ASA_DatabaseFile] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysASAConnectionDefParams.GetOSAuthent: Boolean;
begin
  Result := FDef.AsYesNo[S_FD_ConnParam_Common_OSAuthent];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysASAConnectionDefParams.SetOSAuthent(const AValue: Boolean);
begin
  FDef.AsYesNo[S_FD_ConnParam_Common_OSAuthent] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysASAConnectionDefParams.GetCompress: Boolean;
begin
  Result := FDef.AsYesNo[S_FD_ConnParam_ASA_Compress];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysASAConnectionDefParams.SetCompress(const AValue: Boolean);
begin
  FDef.AsYesNo[S_FD_ConnParam_ASA_Compress] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysASAConnectionDefParams.GetEncrypt: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_ASA_Encrypt];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysASAConnectionDefParams.SetEncrypt(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_ASA_Encrypt] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysASAConnectionDefParams.GetApplicationName: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_Common_ApplicationName];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysASAConnectionDefParams.SetApplicationName(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_Common_ApplicationName] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysASAConnectionDefParams.GetMetaDefCatalog: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_Common_MetaDefCatalog];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysASAConnectionDefParams.SetMetaDefCatalog(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_Common_MetaDefCatalog] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysASAConnectionDefParams.GetMetaDefSchema: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_Common_MetaDefSchema];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysASAConnectionDefParams.SetMetaDefSchema(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_Common_MetaDefSchema] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysASAConnectionDefParams.GetMetaCurCatalog: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_Common_MetaCurCatalog];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysASAConnectionDefParams.SetMetaCurCatalog(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_Common_MetaCurCatalog] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysASAConnectionDefParams.GetMetaCurSchema: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_Common_MetaCurSchema];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysASAConnectionDefParams.SetMetaCurSchema(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_Common_MetaCurSchema] := AValue;
end;

end.
