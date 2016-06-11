{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.Phys.OracleDef;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf;

type
  // TFDPhysOracleConnectionDefParams
  // Generated for: FireDAC Oracle driver

  TFDOracleAuthMode = (amNormal, amSysDBA, amSysOper, amSysASM, amSysBackup, amSysDG, amSysKM);
  TFDOracleCharacterSet = (cs_NLS_LANG_, csUTF8);
  TFDOracleBooleanFormat = (bfChoose, bfInteger, bfString);

  /// <summary> TFDPhysOracleConnectionDefParams class implements FireDAC Oracle driver specific connection definition class. </summary>
  TFDPhysOracleConnectionDefParams = class(TFDConnectionDefParams)
  private
    function GetDriverID: String;
    procedure SetDriverID(const AValue: String);
    function GetOSAuthent: Boolean;
    procedure SetOSAuthent(const AValue: Boolean);
    function GetAuthMode: TFDOracleAuthMode;
    procedure SetAuthMode(const AValue: TFDOracleAuthMode);
    function GetReadTimeout: Integer;
    procedure SetReadTimeout(const AValue: Integer);
    function GetWriteTimeout: Integer;
    procedure SetWriteTimeout(const AValue: Integer);
    function GetCharacterSet: TFDOracleCharacterSet;
    procedure SetCharacterSet(const AValue: TFDOracleCharacterSet);
    function GetBooleanFormat: TFDOracleBooleanFormat;
    procedure SetBooleanFormat(const AValue: TFDOracleBooleanFormat);
    function GetApplicationName: String;
    procedure SetApplicationName(const AValue: String);
    function GetOracleAdvanced: String;
    procedure SetOracleAdvanced(const AValue: String);
    function GetMetaDefSchema: String;
    procedure SetMetaDefSchema(const AValue: String);
    function GetMetaCurSchema: String;
    procedure SetMetaCurSchema(const AValue: String);
  published
    property DriverID: String read GetDriverID write SetDriverID stored False;
    property OSAuthent: Boolean read GetOSAuthent write SetOSAuthent stored False;
    property AuthMode: TFDOracleAuthMode read GetAuthMode write SetAuthMode stored False default amNormal;
    property ReadTimeout: Integer read GetReadTimeout write SetReadTimeout stored False;
    property WriteTimeout: Integer read GetWriteTimeout write SetWriteTimeout stored False;
    property CharacterSet: TFDOracleCharacterSet read GetCharacterSet write SetCharacterSet stored False default cs_NLS_LANG_;
    property BooleanFormat: TFDOracleBooleanFormat read GetBooleanFormat write SetBooleanFormat stored False default bfInteger;
    property ApplicationName: String read GetApplicationName write SetApplicationName stored False;
    property OracleAdvanced: String read GetOracleAdvanced write SetOracleAdvanced stored False;
    property MetaDefSchema: String read GetMetaDefSchema write SetMetaDefSchema stored False;
    property MetaCurSchema: String read GetMetaCurSchema write SetMetaCurSchema stored False;
  end;

implementation

uses
  FireDAC.Stan.Consts;

// TFDPhysOracleConnectionDefParams
// Generated for: FireDAC Oracle driver

{-------------------------------------------------------------------------------}
function TFDPhysOracleConnectionDefParams.GetDriverID: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_Common_DriverID];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysOracleConnectionDefParams.SetDriverID(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_Common_DriverID] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysOracleConnectionDefParams.GetOSAuthent: Boolean;
begin
  Result := FDef.AsYesNo[S_FD_ConnParam_Common_OSAuthent];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysOracleConnectionDefParams.SetOSAuthent(const AValue: Boolean);
begin
  FDef.AsYesNo[S_FD_ConnParam_Common_OSAuthent] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysOracleConnectionDefParams.GetAuthMode: TFDOracleAuthMode;
var
  s: String;
begin
  s := FDef.AsString[S_FD_ConnParam_Oracle_AuthMode];
  if CompareText(s, 'Normal') = 0 then
    Result := amNormal
  else if CompareText(s, 'SysDBA') = 0 then
    Result := amSysDBA
  else if CompareText(s, 'SysOper') = 0 then
    Result := amSysOper
  else if CompareText(s, 'SysASM') = 0 then
    Result := amSysASM
  else if CompareText(s, 'SysBackup') = 0 then
    Result := amSysBackup
  else if CompareText(s, 'SysDG') = 0 then
    Result := amSysDG
  else if CompareText(s, 'SysKM') = 0 then
    Result := amSysKM
  else
    Result := amNormal;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysOracleConnectionDefParams.SetAuthMode(const AValue: TFDOracleAuthMode);
const
  C_AuthMode: array[TFDOracleAuthMode] of String = ('Normal', 'SysDBA', 'SysOper', 'SysASM', 'SysBackup', 'SysDG', 'SysKM');
begin
  FDef.AsString[S_FD_ConnParam_Oracle_AuthMode] := C_AuthMode[AValue];
end;

{-------------------------------------------------------------------------------}
function TFDPhysOracleConnectionDefParams.GetReadTimeout: Integer;
begin
  Result := FDef.AsInteger[S_FD_ConnParam_Oracle_ReadTimeout];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysOracleConnectionDefParams.SetReadTimeout(const AValue: Integer);
begin
  FDef.AsInteger[S_FD_ConnParam_Oracle_ReadTimeout] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysOracleConnectionDefParams.GetWriteTimeout: Integer;
begin
  Result := FDef.AsInteger[S_FD_ConnParam_Oracle_WriteTimeout];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysOracleConnectionDefParams.SetWriteTimeout(const AValue: Integer);
begin
  FDef.AsInteger[S_FD_ConnParam_Oracle_WriteTimeout] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysOracleConnectionDefParams.GetCharacterSet: TFDOracleCharacterSet;
var
  s: String;
begin
  s := FDef.AsString[S_FD_ConnParam_Common_CharacterSet];
  if CompareText(s, '<NLS_LANG>') = 0 then
    Result := cs_NLS_LANG_
  else if CompareText(s, 'UTF8') = 0 then
    Result := csUTF8
  else
    Result := cs_NLS_LANG_;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysOracleConnectionDefParams.SetCharacterSet(const AValue: TFDOracleCharacterSet);
const
  C_CharacterSet: array[TFDOracleCharacterSet] of String = ('<NLS_LANG>', 'UTF8');
begin
  FDef.AsString[S_FD_ConnParam_Common_CharacterSet] := C_CharacterSet[AValue];
end;

{-------------------------------------------------------------------------------}
function TFDPhysOracleConnectionDefParams.GetBooleanFormat: TFDOracleBooleanFormat;
var
  s: String;
begin
  s := FDef.AsString[S_FD_ConnParam_Oracle_BooleanFormat];
  if CompareText(s, 'Choose') = 0 then
    Result := bfChoose
  else if CompareText(s, 'Integer') = 0 then
    Result := bfInteger
  else if CompareText(s, 'String') = 0 then
    Result := bfString
  else
    Result := bfChoose;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysOracleConnectionDefParams.SetBooleanFormat(const AValue: TFDOracleBooleanFormat);
const
  C_BooleanFormat: array[TFDOracleBooleanFormat] of String = ('Choose', 'Integer', 'String');
begin
  FDef.AsString[S_FD_ConnParam_Oracle_BooleanFormat] := C_BooleanFormat[AValue];
end;

{-------------------------------------------------------------------------------}
function TFDPhysOracleConnectionDefParams.GetApplicationName: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_Common_ApplicationName];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysOracleConnectionDefParams.SetApplicationName(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_Common_ApplicationName] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysOracleConnectionDefParams.GetOracleAdvanced: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_Oracle_OracleAdvanced];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysOracleConnectionDefParams.SetOracleAdvanced(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_Oracle_OracleAdvanced] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysOracleConnectionDefParams.GetMetaDefSchema: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_Common_MetaDefSchema];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysOracleConnectionDefParams.SetMetaDefSchema(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_Common_MetaDefSchema] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysOracleConnectionDefParams.GetMetaCurSchema: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_Common_MetaCurSchema];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysOracleConnectionDefParams.SetMetaCurSchema(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_Common_MetaCurSchema] := AValue;
end;

end.
