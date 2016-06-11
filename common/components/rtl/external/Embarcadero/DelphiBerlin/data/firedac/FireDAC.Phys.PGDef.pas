{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.Phys.PGDef;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf;

type
  // TFDPhysPGConnectionDefParams
  // Generated for: FireDAC PG driver

  TFDPGCharacterSet = (csNone, csBIG5, csEUC_CN, csEUC_JP, csEUC_KR, csEUC_TW, csGB18030, csGBK, csISO_8859_5, csISO_8859_6, csISO_8859_7, csISO_8859_8, csJOHAB, csKOI8, csLATIN1, csLATIN2, csLATIN3, csLATIN4, csLATIN5, csLATIN6, csLATIN7, csLATIN8, csLATIN9, csLATIN10, csMULE_INTERNAL, csSJIS, csSQL_ASCII, csUHC, csUTF8, csWIN866, csWIN874, csWIN1250, csWIN1251, csWIN1252, csWIN1256, csWIN1258);
  TFDPGOidAsBlob = (oabNo, oabYes, oabChoose);
  TFDPGUnknownFormat = (ufError, ufBYTEA);

  /// <summary> TFDPhysPGConnectionDefParams class implements FireDAC PG driver specific connection definition class. </summary>
  TFDPhysPGConnectionDefParams = class(TFDConnectionDefParams)
  private
    function GetDriverID: String;
    procedure SetDriverID(const AValue: String);
    function GetServer: String;
    procedure SetServer(const AValue: String);
    function GetPort: Integer;
    procedure SetPort(const AValue: Integer);
    function GetLoginTimeout: Integer;
    procedure SetLoginTimeout(const AValue: Integer);
    function GetCharacterSet: TFDPGCharacterSet;
    procedure SetCharacterSet(const AValue: TFDPGCharacterSet);
    function GetExtendedMetadata: Boolean;
    procedure SetExtendedMetadata(const AValue: Boolean);
    function GetOidAsBlob: TFDPGOidAsBlob;
    procedure SetOidAsBlob(const AValue: TFDPGOidAsBlob);
    function GetUnknownFormat: TFDPGUnknownFormat;
    procedure SetUnknownFormat(const AValue: TFDPGUnknownFormat);
    function GetArrayScanSample: String;
    procedure SetArrayScanSample(const AValue: String);
    function GetApplicationName: String;
    procedure SetApplicationName(const AValue: String);
    function GetPGAdvanced: String;
    procedure SetPGAdvanced(const AValue: String);
    function GetMetaDefSchema: String;
    procedure SetMetaDefSchema(const AValue: String);
    function GetMetaCurSchema: String;
    procedure SetMetaCurSchema(const AValue: String);
  published
    property DriverID: String read GetDriverID write SetDriverID stored False;
    property Server: String read GetServer write SetServer stored False;
    property Port: Integer read GetPort write SetPort stored False default 5432;
    property LoginTimeout: Integer read GetLoginTimeout write SetLoginTimeout stored False default 0;
    property CharacterSet: TFDPGCharacterSet read GetCharacterSet write SetCharacterSet stored False;
    property ExtendedMetadata: Boolean read GetExtendedMetadata write SetExtendedMetadata stored False;
    property OidAsBlob: TFDPGOidAsBlob read GetOidAsBlob write SetOidAsBlob stored False default oabChoose;
    property UnknownFormat: TFDPGUnknownFormat read GetUnknownFormat write SetUnknownFormat stored False default ufError;
    property ArrayScanSample: String read GetArrayScanSample write SetArrayScanSample stored False;
    property ApplicationName: String read GetApplicationName write SetApplicationName stored False;
    property PGAdvanced: String read GetPGAdvanced write SetPGAdvanced stored False;
    property MetaDefSchema: String read GetMetaDefSchema write SetMetaDefSchema stored False;
    property MetaCurSchema: String read GetMetaCurSchema write SetMetaCurSchema stored False;
  end;

implementation

uses
  FireDAC.Stan.Consts;

// TFDPhysPGConnectionDefParams
// Generated for: FireDAC PG driver

{-------------------------------------------------------------------------------}
function TFDPhysPGConnectionDefParams.GetDriverID: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_Common_DriverID];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysPGConnectionDefParams.SetDriverID(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_Common_DriverID] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysPGConnectionDefParams.GetServer: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_Common_Server];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysPGConnectionDefParams.SetServer(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_Common_Server] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysPGConnectionDefParams.GetPort: Integer;
begin
  if not FDef.HasValue(S_FD_ConnParam_Common_Port) then
    Result := 5432
  else
    Result := FDef.AsInteger[S_FD_ConnParam_Common_Port];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysPGConnectionDefParams.SetPort(const AValue: Integer);
begin
  FDef.AsInteger[S_FD_ConnParam_Common_Port] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysPGConnectionDefParams.GetLoginTimeout: Integer;
begin
  Result := FDef.AsInteger[S_FD_ConnParam_Common_LoginTimeout];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysPGConnectionDefParams.SetLoginTimeout(const AValue: Integer);
begin
  FDef.AsInteger[S_FD_ConnParam_Common_LoginTimeout] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysPGConnectionDefParams.GetCharacterSet: TFDPGCharacterSet;
var
  s: String;
begin
  s := FDef.AsString[S_FD_ConnParam_Common_CharacterSet];
  if CompareText(s, '') = 0 then
    Result := csNone
  else if CompareText(s, 'BIG5') = 0 then
    Result := csBIG5
  else if CompareText(s, 'EUC_CN') = 0 then
    Result := csEUC_CN
  else if CompareText(s, 'EUC_JP') = 0 then
    Result := csEUC_JP
  else if CompareText(s, 'EUC_KR') = 0 then
    Result := csEUC_KR
  else if CompareText(s, 'EUC_TW') = 0 then
    Result := csEUC_TW
  else if CompareText(s, 'GB18030') = 0 then
    Result := csGB18030
  else if CompareText(s, 'GBK') = 0 then
    Result := csGBK
  else if CompareText(s, 'ISO_8859_5') = 0 then
    Result := csISO_8859_5
  else if CompareText(s, 'ISO_8859_6') = 0 then
    Result := csISO_8859_6
  else if CompareText(s, 'ISO_8859_7') = 0 then
    Result := csISO_8859_7
  else if CompareText(s, 'ISO_8859_8') = 0 then
    Result := csISO_8859_8
  else if CompareText(s, 'JOHAB') = 0 then
    Result := csJOHAB
  else if CompareText(s, 'KOI8') = 0 then
    Result := csKOI8
  else if CompareText(s, 'LATIN1') = 0 then
    Result := csLATIN1
  else if CompareText(s, 'LATIN2') = 0 then
    Result := csLATIN2
  else if CompareText(s, 'LATIN3') = 0 then
    Result := csLATIN3
  else if CompareText(s, 'LATIN4') = 0 then
    Result := csLATIN4
  else if CompareText(s, 'LATIN5') = 0 then
    Result := csLATIN5
  else if CompareText(s, 'LATIN6') = 0 then
    Result := csLATIN6
  else if CompareText(s, 'LATIN7') = 0 then
    Result := csLATIN7
  else if CompareText(s, 'LATIN8') = 0 then
    Result := csLATIN8
  else if CompareText(s, 'LATIN9') = 0 then
    Result := csLATIN9
  else if CompareText(s, 'LATIN10') = 0 then
    Result := csLATIN10
  else if CompareText(s, 'MULE_INTERNAL') = 0 then
    Result := csMULE_INTERNAL
  else if CompareText(s, 'SJIS') = 0 then
    Result := csSJIS
  else if CompareText(s, 'SQL_ASCII') = 0 then
    Result := csSQL_ASCII
  else if CompareText(s, 'UHC') = 0 then
    Result := csUHC
  else if CompareText(s, 'UTF8') = 0 then
    Result := csUTF8
  else if CompareText(s, 'WIN866') = 0 then
    Result := csWIN866
  else if CompareText(s, 'WIN874') = 0 then
    Result := csWIN874
  else if CompareText(s, 'WIN1250') = 0 then
    Result := csWIN1250
  else if CompareText(s, 'WIN1251') = 0 then
    Result := csWIN1251
  else if CompareText(s, 'WIN1252') = 0 then
    Result := csWIN1252
  else if CompareText(s, 'WIN1256') = 0 then
    Result := csWIN1256
  else if CompareText(s, 'WIN1258') = 0 then
    Result := csWIN1258
  else
    Result := csNone;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysPGConnectionDefParams.SetCharacterSet(const AValue: TFDPGCharacterSet);
const
  C_CharacterSet: array[TFDPGCharacterSet] of String = ('', 'BIG5', 'EUC_CN', 'EUC_JP', 'EUC_KR', 'EUC_TW', 'GB18030', 'GBK', 'ISO_8859_5', 'ISO_8859_6', 'ISO_8859_7', 'ISO_8859_8', 'JOHAB', 'KOI8', 'LATIN1', 'LATIN2', 'LATIN3', 'LATIN4', 'LATIN5', 'LATIN6', 'LATIN7', 'LATIN8', 'LATIN9', 'LATIN10', 'MULE_INTERNAL', 'SJIS', 'SQL_ASCII', 'UHC', 'UTF8', 'WIN866', 'WIN874', 'WIN1250', 'WIN1251', 'WIN1252', 'WIN1256', 'WIN1258');
begin
  FDef.AsString[S_FD_ConnParam_Common_CharacterSet] := C_CharacterSet[AValue];
end;

{-------------------------------------------------------------------------------}
function TFDPhysPGConnectionDefParams.GetExtendedMetadata: Boolean;
begin
  Result := FDef.AsBoolean[S_FD_ConnParam_Common_ExtendedMetadata];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysPGConnectionDefParams.SetExtendedMetadata(const AValue: Boolean);
begin
  FDef.AsBoolean[S_FD_ConnParam_Common_ExtendedMetadata] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysPGConnectionDefParams.GetOidAsBlob: TFDPGOidAsBlob;
var
  s: String;
begin
  s := FDef.AsString[S_FD_ConnParam_PG_OidAsBlob];
  if CompareText(s, 'No') = 0 then
    Result := oabNo
  else if CompareText(s, 'Yes') = 0 then
    Result := oabYes
  else if CompareText(s, 'Choose') = 0 then
    Result := oabChoose
  else
    Result := oabChoose;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysPGConnectionDefParams.SetOidAsBlob(const AValue: TFDPGOidAsBlob);
const
  C_OidAsBlob: array[TFDPGOidAsBlob] of String = ('No', 'Yes', 'Choose');
begin
  FDef.AsString[S_FD_ConnParam_PG_OidAsBlob] := C_OidAsBlob[AValue];
end;

{-------------------------------------------------------------------------------}
function TFDPhysPGConnectionDefParams.GetUnknownFormat: TFDPGUnknownFormat;
var
  s: String;
begin
  s := FDef.AsString[S_FD_ConnParam_PG_UnknownFormat];
  if CompareText(s, 'Error') = 0 then
    Result := ufError
  else if CompareText(s, 'BYTEA') = 0 then
    Result := ufBYTEA
  else
    Result := ufError;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysPGConnectionDefParams.SetUnknownFormat(const AValue: TFDPGUnknownFormat);
const
  C_UnknownFormat: array[TFDPGUnknownFormat] of String = ('Error', 'BYTEA');
begin
  FDef.AsString[S_FD_ConnParam_PG_UnknownFormat] := C_UnknownFormat[AValue];
end;

{-------------------------------------------------------------------------------}
function TFDPhysPGConnectionDefParams.GetArrayScanSample: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_PG_ArrayScanSample];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysPGConnectionDefParams.SetArrayScanSample(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_PG_ArrayScanSample] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysPGConnectionDefParams.GetApplicationName: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_Common_ApplicationName];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysPGConnectionDefParams.SetApplicationName(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_Common_ApplicationName] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysPGConnectionDefParams.GetPGAdvanced: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_PG_PGAdvanced];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysPGConnectionDefParams.SetPGAdvanced(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_PG_PGAdvanced] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysPGConnectionDefParams.GetMetaDefSchema: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_Common_MetaDefSchema];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysPGConnectionDefParams.SetMetaDefSchema(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_Common_MetaDefSchema] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysPGConnectionDefParams.GetMetaCurSchema: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_Common_MetaCurSchema];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysPGConnectionDefParams.SetMetaCurSchema(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_Common_MetaCurSchema] := AValue;
end;

end.
