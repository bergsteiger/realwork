{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.Phys.TDBXDef;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Phys.Intf;

type
  // TFDPhysTDBXConnectionDefParams
  // Generated for: FireDAC TDBX driver

  /// <summary> TFDPhysTDBXConnectionDefParams class implements FireDAC TDBX driver specific connection definition class. </summary>
  TFDPhysTDBXConnectionDefParams = class(TFDConnectionDefParams)
  private
    function GetDriverID: String;
    procedure SetDriverID(const AValue: String);
    function GetDBXAdvanced: String;
    procedure SetDBXAdvanced(const AValue: String);
    function GetDriverName: String;
    procedure SetDriverName(const AValue: String);
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
    property DBXAdvanced: String read GetDBXAdvanced write SetDBXAdvanced stored False;
    property DriverName: String read GetDriverName write SetDriverName stored False;
    property MetaDefCatalog: String read GetMetaDefCatalog write SetMetaDefCatalog stored False;
    property MetaDefSchema: String read GetMetaDefSchema write SetMetaDefSchema stored False;
    property MetaCurCatalog: String read GetMetaCurCatalog write SetMetaCurCatalog stored False;
    property MetaCurSchema: String read GetMetaCurSchema write SetMetaCurSchema stored False;
    property RDBMS: TFDRDBMSKind read GetRDBMS write SetRDBMS stored False;
  end;

implementation

uses
  Data.DBXCommon, FireDAC.Stan.Consts;

// TFDPhysTDBXConnectionDefParams
// Generated for: FireDAC TDBX driver

{-------------------------------------------------------------------------------}
function TFDPhysTDBXConnectionDefParams.GetDriverID: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_Common_DriverID];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTDBXConnectionDefParams.SetDriverID(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_Common_DriverID] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDBXConnectionDefParams.GetDBXAdvanced: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_TDBX_DBXAdvanced];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTDBXConnectionDefParams.SetDBXAdvanced(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_TDBX_DBXAdvanced] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDBXConnectionDefParams.GetDriverName: String;
begin
  Result := FDef.AsString[TDBXPropertyNames.DriverName];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTDBXConnectionDefParams.SetDriverName(const AValue: String);
begin
  FDef.AsString[TDBXPropertyNames.DriverName] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDBXConnectionDefParams.GetMetaDefCatalog: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_Common_MetaDefCatalog];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTDBXConnectionDefParams.SetMetaDefCatalog(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_Common_MetaDefCatalog] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDBXConnectionDefParams.GetMetaDefSchema: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_Common_MetaDefSchema];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTDBXConnectionDefParams.SetMetaDefSchema(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_Common_MetaDefSchema] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDBXConnectionDefParams.GetMetaCurCatalog: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_Common_MetaCurCatalog];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTDBXConnectionDefParams.SetMetaCurCatalog(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_Common_MetaCurCatalog] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDBXConnectionDefParams.GetMetaCurSchema: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_Common_MetaCurSchema];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTDBXConnectionDefParams.SetMetaCurSchema(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_Common_MetaCurSchema] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDBXConnectionDefParams.GetRDBMS: TFDRDBMSKind;
var
  oManMeta: IFDPhysManagerMetadata;
begin
  FDPhysManager.CreateMetadata(oManMeta);
  Result := oManMeta.GetRDBMSKind(FDef.AsString[S_FD_ConnParam_Common_RDBMS]);
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTDBXConnectionDefParams.SetRDBMS(const AValue: TFDRDBMSKind);
var
  oManMeta: IFDPhysManagerMetadata;
begin
  FDPhysManager.CreateMetadata(oManMeta);
  FDef.AsString[S_FD_ConnParam_Common_RDBMS] := oManMeta.GetRDBMSName(AValue);
end;

end.
