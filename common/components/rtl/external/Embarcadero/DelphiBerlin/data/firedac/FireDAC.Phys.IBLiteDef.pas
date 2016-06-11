{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.Phys.IBLiteDef;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Phys.IBWrapper;

type
  // TFDPhysIBLiteConnectionDefParams
  // Generated for: FireDAC IBLite driver

  /// <summary> TFDPhysIBLiteConnectionDefParams class implements FireDAC IBLite driver specific connection definition class. </summary>
  TFDPhysIBLiteConnectionDefParams = class(TFDConnectionDefParams)
  private
    function GetDriverID: String;
    procedure SetDriverID(const AValue: String);
    function GetCharacterSet: TIBCharacterSet;
    procedure SetCharacterSet(const AValue: TIBCharacterSet);
    function GetExtendedMetadata: Boolean;
    procedure SetExtendedMetadata(const AValue: Boolean);
    function GetOpenMode: TIBOpenMode;
    procedure SetOpenMode(const AValue: TIBOpenMode);
    function GetPageSize: TIBPageSize;
    procedure SetPageSize(const AValue: TIBPageSize);
    function GetDropDatabase: Boolean;
    procedure SetDropDatabase(const AValue: Boolean);
    function GetIBAdvanced: String;
    procedure SetIBAdvanced(const AValue: String);
  published
    property DriverID: String read GetDriverID write SetDriverID stored False;
    property CharacterSet: TIBCharacterSet read GetCharacterSet write SetCharacterSet stored False default csNONE;
    property ExtendedMetadata: Boolean read GetExtendedMetadata write SetExtendedMetadata stored False;
    property OpenMode: TIBOpenMode read GetOpenMode write SetOpenMode stored False default omOpen;
    property PageSize: TIBPageSize read GetPageSize write SetPageSize stored False default ps4096;
    property DropDatabase: Boolean read GetDropDatabase write SetDropDatabase stored False;
    property IBAdvanced: String read GetIBAdvanced write SetIBAdvanced stored False;
  end;

implementation

uses
  FireDAC.Stan.Consts;

// TFDPhysIBLiteConnectionDefParams
// Generated for: FireDAC IBLite driver

{-------------------------------------------------------------------------------}
function TFDPhysIBLiteConnectionDefParams.GetDriverID: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_Common_DriverID];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysIBLiteConnectionDefParams.SetDriverID(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_Common_DriverID] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysIBLiteConnectionDefParams.GetCharacterSet: TIBCharacterSet;
var
  s: String;
begin
  s := FDef.AsString[S_FD_ConnParam_Common_CharacterSet];
  if CompareText(s, 'NONE') = 0 then
    Result := csNONE
  else if CompareText(s, 'ASCII') = 0 then
    Result := csASCII
  else if CompareText(s, 'BIG_5') = 0 then
    Result := csBIG_5
  else if CompareText(s, 'CYRL') = 0 then
    Result := csCYRL
  else if CompareText(s, 'DOS437') = 0 then
    Result := csDOS437
  else if CompareText(s, 'DOS850') = 0 then
    Result := csDOS850
  else if CompareText(s, 'DOS852') = 0 then
    Result := csDOS852
  else if CompareText(s, 'DOS857') = 0 then
    Result := csDOS857
  else if CompareText(s, 'DOS860') = 0 then
    Result := csDOS860
  else if CompareText(s, 'DOS861') = 0 then
    Result := csDOS861
  else if CompareText(s, 'DOS863') = 0 then
    Result := csDOS863
  else if CompareText(s, 'DOS865') = 0 then
    Result := csDOS865
  else if CompareText(s, 'EUCJ_0208') = 0 then
    Result := csEUCJ_0208
  else if CompareText(s, 'GB_2312') = 0 then
    Result := csGB_2312
  else if CompareText(s, 'ISO8859_1') = 0 then
    Result := csISO8859_1
  else if CompareText(s, 'ISO8859_2') = 0 then
    Result := csISO8859_2
  else if CompareText(s, 'KSC_5601') = 0 then
    Result := csKSC_5601
  else if CompareText(s, 'NEXT') = 0 then
    Result := csNEXT
  else if CompareText(s, 'OCTETS') = 0 then
    Result := csOCTETS
  else if CompareText(s, 'SJIS_0208') = 0 then
    Result := csSJIS_0208
  else if CompareText(s, 'UNICODE_FSS') = 0 then
    Result := csUNICODE_FSS
  else if CompareText(s, 'WIN1250') = 0 then
    Result := csWIN1250
  else if CompareText(s, 'WIN1251') = 0 then
    Result := csWIN1251
  else if CompareText(s, 'WIN1252') = 0 then
    Result := csWIN1252
  else if CompareText(s, 'WIN1253') = 0 then
    Result := csWIN1253
  else if CompareText(s, 'WIN1254') = 0 then
    Result := csWIN1254
  else if CompareText(s, 'DOS737') = 0 then
    Result := csDOS737
  else if CompareText(s, 'DOS775') = 0 then
    Result := csDOS775
  else if CompareText(s, 'DOS858') = 0 then
    Result := csDOS858
  else if CompareText(s, 'DOS862') = 0 then
    Result := csDOS862
  else if CompareText(s, 'DOS864') = 0 then
    Result := csDOS864
  else if CompareText(s, 'DOS866') = 0 then
    Result := csDOS866
  else if CompareText(s, 'DOS869') = 0 then
    Result := csDOS869
  else if CompareText(s, 'WIN1255') = 0 then
    Result := csWIN1255
  else if CompareText(s, 'WIN1256') = 0 then
    Result := csWIN1256
  else if CompareText(s, 'WIN1257') = 0 then
    Result := csWIN1257
  else if CompareText(s, 'ISO8859_3') = 0 then
    Result := csISO8859_3
  else if CompareText(s, 'ISO8859_4') = 0 then
    Result := csISO8859_4
  else if CompareText(s, 'ISO8859_5') = 0 then
    Result := csISO8859_5
  else if CompareText(s, 'ISO8859_6') = 0 then
    Result := csISO8859_6
  else if CompareText(s, 'ISO8859_7') = 0 then
    Result := csISO8859_7
  else if CompareText(s, 'ISO8859_8') = 0 then
    Result := csISO8859_8
  else if CompareText(s, 'ISO8859_9') = 0 then
    Result := csISO8859_9
  else if CompareText(s, 'ISO8859_13') = 0 then
    Result := csISO8859_13
  else if CompareText(s, 'ISO8859_15') = 0 then
    Result := csISO8859_15
  else if CompareText(s, 'KOI8R') = 0 then
    Result := csKOI8R
  else if CompareText(s, 'KOI8U') = 0 then
    Result := csKOI8U
  else if CompareText(s, 'UTF8') = 0 then
    Result := csUTF8
  else if CompareText(s, 'UNICODE_LE') = 0 then
    Result := csUNICODE_LE
  else if CompareText(s, 'UNICODE_BE') = 0 then
    Result := csUNICODE_BE
  else
    Result := csNONE;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysIBLiteConnectionDefParams.SetCharacterSet(const AValue: TIBCharacterSet);
const
  C_CharacterSet: array[TIBCharacterSet] of String = ('NONE', 'ASCII', 'BIG_5', 'CYRL', 'DOS437', 'DOS850', 'DOS852', 'DOS857', 'DOS860', 'DOS861', 'DOS863', 'DOS865', 'EUCJ_0208', 'GB_2312', 'ISO8859_1', 'ISO8859_2', 'KSC_5601', 'NEXT', 'OCTETS', 'SJIS_0208', 'UNICODE_FSS', 'WIN1250', 'WIN1251', 'WIN1252', 'WIN1253', 'WIN1254', 'DOS737', 'DOS775', 'DOS858', 'DOS862', 'DOS864', 'DOS866', 'DOS869', 'WIN1255', 'WIN1256', 'WIN1257', 'ISO8859_3', 'ISO8859_4', 'ISO8859_5', 'ISO8859_6', 'ISO8859_7', 'ISO8859_8', 'ISO8859_9', 'ISO8859_13', 'ISO8859_15', 'KOI8R', 'KOI8U', 'UTF8', 'UNICODE_LE', 'UNICODE_BE');
begin
  FDef.AsString[S_FD_ConnParam_Common_CharacterSet] := C_CharacterSet[AValue];
end;

{-------------------------------------------------------------------------------}
function TFDPhysIBLiteConnectionDefParams.GetExtendedMetadata: Boolean;
begin
  Result := FDef.AsBoolean[S_FD_ConnParam_Common_ExtendedMetadata];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysIBLiteConnectionDefParams.SetExtendedMetadata(const AValue: Boolean);
begin
  FDef.AsBoolean[S_FD_ConnParam_Common_ExtendedMetadata] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysIBLiteConnectionDefParams.GetOpenMode: TIBOpenMode;
var
  s: String;
begin
  s := FDef.AsString[S_FD_ConnParam_IB_OpenMode];
  if CompareText(s, 'Open') = 0 then
    Result := omOpen
  else if CompareText(s, 'Create') = 0 then
    Result := omCreate
  else if CompareText(s, 'OpenOrCreate') = 0 then
    Result := omOpenOrCreate
  else
    Result := omOpen;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysIBLiteConnectionDefParams.SetOpenMode(const AValue: TIBOpenMode);
const
  C_OpenMode: array[TIBOpenMode] of String = ('Open', 'Create', 'OpenOrCreate');
begin
  FDef.AsString[S_FD_ConnParam_IB_OpenMode] := C_OpenMode[AValue];
end;

{-------------------------------------------------------------------------------}
function TFDPhysIBLiteConnectionDefParams.GetPageSize: TIBPageSize;
var
  s: String;
begin
  s := FDef.AsString[S_FD_ConnParam_IB_PageSize];
  if CompareText(s, '1024') = 0 then
    Result := ps1024
  else if CompareText(s, '2048') = 0 then
    Result := ps2048
  else if CompareText(s, '4096') = 0 then
    Result := ps4096
  else if CompareText(s, '8192') = 0 then
    Result := ps8192
  else if CompareText(s, '16384') = 0 then
    Result := ps16384
  else
    Result := ps4096;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysIBLiteConnectionDefParams.SetPageSize(const AValue: TIBPageSize);
const
  C_PageSize: array[TIBPageSize] of String = ('1024', '2048', '4096', '8192', '16384');
begin
  FDef.AsString[S_FD_ConnParam_IB_PageSize] := C_PageSize[AValue];
end;

{-------------------------------------------------------------------------------}
function TFDPhysIBLiteConnectionDefParams.GetDropDatabase: Boolean;
begin
  Result := FDef.AsYesNo[S_FD_ConnParam_IB_DropDatabase];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysIBLiteConnectionDefParams.SetDropDatabase(const AValue: Boolean);
begin
  FDef.AsYesNo[S_FD_ConnParam_IB_DropDatabase] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysIBLiteConnectionDefParams.GetIBAdvanced: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_IB_IBAdvanced];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysIBLiteConnectionDefParams.SetIBAdvanced(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_IB_IBAdvanced] := AValue;
end;

end.
