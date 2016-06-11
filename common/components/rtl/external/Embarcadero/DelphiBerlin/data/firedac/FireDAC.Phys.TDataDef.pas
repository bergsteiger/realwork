{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.Phys.TDataDef;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Phys.TDataMeta;

type
  // TFDPhysTDataConnectionDefParams
  // Generated for: FireDAC TData driver

  TFDTDataCharacterSet = (csASCII, csUTF8, csUTF16, csLATIN1252_0A, csLATIN9_0A, csLATIN1_0A, csKANJISJIS_0S, csKANJIEUC_0U, csTCHBIG5_1R0, csSCHGB2312_1T0, csHANGULKSC5601_2R4);

  /// <summary> TFDPhysTDataConnectionDefParams class implements FireDAC TData driver specific connection definition class. </summary>
  TFDPhysTDataConnectionDefParams = class(TFDConnectionDefParams)
  private
    function GetDriverID: String;
    procedure SetDriverID(const AValue: String);
    function GetODBCAdvanced: String;
    procedure SetODBCAdvanced(const AValue: String);
    function GetLoginTimeout: Integer;
    procedure SetLoginTimeout(const AValue: Integer);
    function GetServer: String;
    procedure SetServer(const AValue: String);
    function GetOSAuthent: Boolean;
    procedure SetOSAuthent(const AValue: Boolean);
    function GetCharacterSet: TFDTDataCharacterSet;
    procedure SetCharacterSet(const AValue: TFDTDataCharacterSet);
    function GetSessionMode: TFDTDataSessionMode;
    procedure SetSessionMode(const AValue: TFDTDataSessionMode);
    function GetEncrypt: Boolean;
    procedure SetEncrypt(const AValue: Boolean);
    function GetExtendedMetadata: Boolean;
    procedure SetExtendedMetadata(const AValue: Boolean);
    function GetMetaDefSchema: String;
    procedure SetMetaDefSchema(const AValue: String);
    function GetMetaCurSchema: String;
    procedure SetMetaCurSchema(const AValue: String);
  published
    property DriverID: String read GetDriverID write SetDriverID stored False;
    property ODBCAdvanced: String read GetODBCAdvanced write SetODBCAdvanced stored False;
    property LoginTimeout: Integer read GetLoginTimeout write SetLoginTimeout stored False;
    property Server: String read GetServer write SetServer stored False;
    property OSAuthent: Boolean read GetOSAuthent write SetOSAuthent stored False;
    property CharacterSet: TFDTDataCharacterSet read GetCharacterSet write SetCharacterSet stored False default csASCII;
    property SessionMode: TFDTDataSessionMode read GetSessionMode write SetSessionMode stored False default tmTeradata;
    property Encrypt: Boolean read GetEncrypt write SetEncrypt stored False;
    property ExtendedMetadata: Boolean read GetExtendedMetadata write SetExtendedMetadata stored False;
    property MetaDefSchema: String read GetMetaDefSchema write SetMetaDefSchema stored False;
    property MetaCurSchema: String read GetMetaCurSchema write SetMetaCurSchema stored False;
  end;

implementation

uses
  FireDAC.Stan.Consts;

// TFDPhysTDataConnectionDefParams
// Generated for: FireDAC TData driver

{-------------------------------------------------------------------------------}
function TFDPhysTDataConnectionDefParams.GetDriverID: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_Common_DriverID];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTDataConnectionDefParams.SetDriverID(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_Common_DriverID] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDataConnectionDefParams.GetODBCAdvanced: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_ODBC_ODBCAdvanced];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTDataConnectionDefParams.SetODBCAdvanced(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_ODBC_ODBCAdvanced] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDataConnectionDefParams.GetLoginTimeout: Integer;
begin
  Result := FDef.AsInteger[S_FD_ConnParam_Common_LoginTimeout];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTDataConnectionDefParams.SetLoginTimeout(const AValue: Integer);
begin
  FDef.AsInteger[S_FD_ConnParam_Common_LoginTimeout] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDataConnectionDefParams.GetServer: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_Common_Server];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTDataConnectionDefParams.SetServer(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_Common_Server] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDataConnectionDefParams.GetOSAuthent: Boolean;
begin
  Result := FDef.AsYesNo[S_FD_ConnParam_Common_OSAuthent];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTDataConnectionDefParams.SetOSAuthent(const AValue: Boolean);
begin
  FDef.AsYesNo[S_FD_ConnParam_Common_OSAuthent] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDataConnectionDefParams.GetCharacterSet: TFDTDataCharacterSet;
var
  s: String;
begin
  s := FDef.AsString[S_FD_ConnParam_Common_CharacterSet];
  if CompareText(s, 'ASCII') = 0 then
    Result := csASCII
  else if CompareText(s, 'UTF8') = 0 then
    Result := csUTF8
  else if CompareText(s, 'UTF16') = 0 then
    Result := csUTF16
  else if CompareText(s, 'LATIN1252_0A') = 0 then
    Result := csLATIN1252_0A
  else if CompareText(s, 'LATIN9_0A') = 0 then
    Result := csLATIN9_0A
  else if CompareText(s, 'LATIN1_0A') = 0 then
    Result := csLATIN1_0A
  else if CompareText(s, 'KANJISJIS_0S') = 0 then
    Result := csKANJISJIS_0S
  else if CompareText(s, 'KANJIEUC_0U') = 0 then
    Result := csKANJIEUC_0U
  else if CompareText(s, 'TCHBIG5_1R0') = 0 then
    Result := csTCHBIG5_1R0
  else if CompareText(s, 'SCHGB2312_1T0') = 0 then
    Result := csSCHGB2312_1T0
  else if CompareText(s, 'HANGULKSC5601_2R4') = 0 then
    Result := csHANGULKSC5601_2R4
  else
    Result := csASCII;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTDataConnectionDefParams.SetCharacterSet(const AValue: TFDTDataCharacterSet);
const
  C_CharacterSet: array[TFDTDataCharacterSet] of String = ('ASCII', 'UTF8', 'UTF16', 'LATIN1252_0A', 'LATIN9_0A', 'LATIN1_0A', 'KANJISJIS_0S', 'KANJIEUC_0U', 'TCHBIG5_1R0', 'SCHGB2312_1T0', 'HANGULKSC5601_2R4');
begin
  FDef.AsString[S_FD_ConnParam_Common_CharacterSet] := C_CharacterSet[AValue];
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDataConnectionDefParams.GetSessionMode: TFDTDataSessionMode;
var
  s: String;
begin
  s := FDef.AsString[S_FD_ConnParam_TData_SessionMode];
  if CompareText(s, 'Teradata') = 0 then
    Result := tmTeradata
  else if CompareText(s, 'ANSI') = 0 then
    Result := tmANSI
  else
    Result := tmTeradata;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTDataConnectionDefParams.SetSessionMode(const AValue: TFDTDataSessionMode);
const
  C_SessionMode: array[TFDTDataSessionMode] of String = ('Teradata', 'ANSI');
begin
  FDef.AsString[S_FD_ConnParam_TData_SessionMode] := C_SessionMode[AValue];
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDataConnectionDefParams.GetEncrypt: Boolean;
begin
  Result := FDef.AsYesNo[S_FD_ConnParam_TData_Encrypt];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTDataConnectionDefParams.SetEncrypt(const AValue: Boolean);
begin
  FDef.AsYesNo[S_FD_ConnParam_TData_Encrypt] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDataConnectionDefParams.GetExtendedMetadata: Boolean;
begin
  Result := FDef.AsBoolean[S_FD_ConnParam_Common_ExtendedMetadata];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTDataConnectionDefParams.SetExtendedMetadata(const AValue: Boolean);
begin
  FDef.AsBoolean[S_FD_ConnParam_Common_ExtendedMetadata] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDataConnectionDefParams.GetMetaDefSchema: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_Common_MetaDefSchema];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTDataConnectionDefParams.SetMetaDefSchema(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_Common_MetaDefSchema] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysTDataConnectionDefParams.GetMetaCurSchema: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_Common_MetaCurSchema];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysTDataConnectionDefParams.SetMetaCurSchema(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_Common_MetaCurSchema] := AValue;
end;

end.
