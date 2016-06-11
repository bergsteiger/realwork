{*******************************************************}
{                                                       }
{               Delphi FireDAC Framework                }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$I FireDAC.inc}

unit FireDAC.Phys.MySQLDef;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf;

type
  // TFDPhysMySQLConnectionDefParams
  // Generated for: FireDAC MySQL driver

  TFDMySQLResultMode = (rmStore, rmUse, rmChoose);
  TFDMySQLCharacterSet = (csNone, csBig5, csDec8, csCp850, csHp8, csKoi8r, csLatin1, csLatin2, csSwe7, csAscii, csUjis, csSjis, csCp1251, csHebrew, csTis620, csEuckr, csKoi8u, csGb2312, csGreek, csCp1250, csGbk, csLatin5, csArmscii8, csCp866, csKeybcs2, csMacce, csMacroman, csCp852, csLatin7, csCp1256, csCp1257, csBinary, csUtf8);
  TFDMySQLTinyIntFormat = (tifBoolean, tifInteger);

  /// <summary> TFDPhysMySQLConnectionDefParams class implements FireDAC MySQL driver specific connection definition class. </summary>
  TFDPhysMySQLConnectionDefParams = class(TFDConnectionDefParams)
  private
    function GetDriverID: String;
    procedure SetDriverID(const AValue: String);
    function GetServer: String;
    procedure SetServer(const AValue: String);
    function GetPort: Integer;
    procedure SetPort(const AValue: Integer);
    function GetCompress: Boolean;
    procedure SetCompress(const AValue: Boolean);
    function GetUseSSL: Boolean;
    procedure SetUseSSL(const AValue: Boolean);
    function GetLoginTimeout: Integer;
    procedure SetLoginTimeout(const AValue: Integer);
    function GetReadTimeout: Integer;
    procedure SetReadTimeout(const AValue: Integer);
    function GetWriteTimeout: Integer;
    procedure SetWriteTimeout(const AValue: Integer);
    function GetResultMode: TFDMySQLResultMode;
    procedure SetResultMode(const AValue: TFDMySQLResultMode);
    function GetCharacterSet: TFDMySQLCharacterSet;
    procedure SetCharacterSet(const AValue: TFDMySQLCharacterSet);
    function GetTinyIntFormat: TFDMySQLTinyIntFormat;
    procedure SetTinyIntFormat(const AValue: TFDMySQLTinyIntFormat);
    function GetMetaDefCatalog: String;
    procedure SetMetaDefCatalog(const AValue: String);
    function GetMetaCurCatalog: String;
    procedure SetMetaCurCatalog(const AValue: String);
    function GetSSL_key: String;
    procedure SetSSL_key(const AValue: String);
    function GetSSL_cert: String;
    procedure SetSSL_cert(const AValue: String);
    function GetSSL_ca: String;
    procedure SetSSL_ca(const AValue: String);
    function GetSSL_capath: String;
    procedure SetSSL_capath(const AValue: String);
    function GetSSL_cipher: String;
    procedure SetSSL_cipher(const AValue: String);
  published
    property DriverID: String read GetDriverID write SetDriverID stored False;
    property Server: String read GetServer write SetServer stored False;
    property Port: Integer read GetPort write SetPort stored False default 3306;
    property Compress: Boolean read GetCompress write SetCompress stored False;
    property UseSSL: Boolean read GetUseSSL write SetUseSSL stored False;
    property LoginTimeout: Integer read GetLoginTimeout write SetLoginTimeout stored False;
    property ReadTimeout: Integer read GetReadTimeout write SetReadTimeout stored False;
    property WriteTimeout: Integer read GetWriteTimeout write SetWriteTimeout stored False;
    property ResultMode: TFDMySQLResultMode read GetResultMode write SetResultMode stored False default rmStore;
    property CharacterSet: TFDMySQLCharacterSet read GetCharacterSet write SetCharacterSet stored False;
    property TinyIntFormat: TFDMySQLTinyIntFormat read GetTinyIntFormat write SetTinyIntFormat stored False default tifBoolean;
    property MetaDefCatalog: String read GetMetaDefCatalog write SetMetaDefCatalog stored False;
    property MetaCurCatalog: String read GetMetaCurCatalog write SetMetaCurCatalog stored False;
    property SSL_key: String read GetSSL_key write SetSSL_key stored False;
    property SSL_cert: String read GetSSL_cert write SetSSL_cert stored False;
    property SSL_ca: String read GetSSL_ca write SetSSL_ca stored False;
    property SSL_capath: String read GetSSL_capath write SetSSL_capath stored False;
    property SSL_cipher: String read GetSSL_cipher write SetSSL_cipher stored False;
  end;

implementation

uses
  FireDAC.Stan.Consts;

// TFDPhysMySQLConnectionDefParams
// Generated for: FireDAC MySQL driver

{-------------------------------------------------------------------------------}
function TFDPhysMySQLConnectionDefParams.GetDriverID: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_Common_DriverID];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMySQLConnectionDefParams.SetDriverID(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_Common_DriverID] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLConnectionDefParams.GetServer: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_Common_Server];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMySQLConnectionDefParams.SetServer(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_Common_Server] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLConnectionDefParams.GetPort: Integer;
begin
  if not FDef.HasValue(S_FD_ConnParam_Common_Port) then
    Result := 3306
  else
    Result := FDef.AsInteger[S_FD_ConnParam_Common_Port];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMySQLConnectionDefParams.SetPort(const AValue: Integer);
begin
  FDef.AsInteger[S_FD_ConnParam_Common_Port] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLConnectionDefParams.GetCompress: Boolean;
begin
  if not FDef.HasValue(S_FD_ConnParam_MySQL_Compress) then
    Result := True
  else
    Result := FDef.AsBoolean[S_FD_ConnParam_MySQL_Compress];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMySQLConnectionDefParams.SetCompress(const AValue: Boolean);
begin
  FDef.AsBoolean[S_FD_ConnParam_MySQL_Compress] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLConnectionDefParams.GetUseSSL: Boolean;
begin
  Result := FDef.AsBoolean[S_FD_ConnParam_MySQL_UseSSL];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMySQLConnectionDefParams.SetUseSSL(const AValue: Boolean);
begin
  FDef.AsBoolean[S_FD_ConnParam_MySQL_UseSSL] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLConnectionDefParams.GetLoginTimeout: Integer;
begin
  Result := FDef.AsInteger[S_FD_ConnParam_Common_LoginTimeout];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMySQLConnectionDefParams.SetLoginTimeout(const AValue: Integer);
begin
  FDef.AsInteger[S_FD_ConnParam_Common_LoginTimeout] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLConnectionDefParams.GetReadTimeout: Integer;
begin
  Result := FDef.AsInteger[S_FD_ConnParam_MySQL_ReadTimeout];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMySQLConnectionDefParams.SetReadTimeout(const AValue: Integer);
begin
  FDef.AsInteger[S_FD_ConnParam_MySQL_ReadTimeout] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLConnectionDefParams.GetWriteTimeout: Integer;
begin
  Result := FDef.AsInteger[S_FD_ConnParam_MySQL_WriteTimeout];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMySQLConnectionDefParams.SetWriteTimeout(const AValue: Integer);
begin
  FDef.AsInteger[S_FD_ConnParam_MySQL_WriteTimeout] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLConnectionDefParams.GetResultMode: TFDMySQLResultMode;
var
  s: String;
begin
  s := FDef.AsString[S_FD_ConnParam_MySQL_ResultMode];
  if CompareText(s, 'Store') = 0 then
    Result := rmStore
  else if CompareText(s, 'Use') = 0 then
    Result := rmUse
  else if CompareText(s, 'Choose') = 0 then
    Result := rmChoose
  else
    Result := rmStore;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMySQLConnectionDefParams.SetResultMode(const AValue: TFDMySQLResultMode);
const
  C_ResultMode: array[TFDMySQLResultMode] of String = ('Store', 'Use', 'Choose');
begin
  FDef.AsString[S_FD_ConnParam_MySQL_ResultMode] := C_ResultMode[AValue];
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLConnectionDefParams.GetCharacterSet: TFDMySQLCharacterSet;
var
  s: String;
begin
  s := FDef.AsString[S_FD_ConnParam_Common_CharacterSet];
  if CompareText(s, '') = 0 then
    Result := csNone
  else if CompareText(s, 'big5') = 0 then
    Result := csBig5
  else if CompareText(s, 'dec8') = 0 then
    Result := csDec8
  else if CompareText(s, 'cp850') = 0 then
    Result := csCp850
  else if CompareText(s, 'hp8') = 0 then
    Result := csHp8
  else if CompareText(s, 'koi8r') = 0 then
    Result := csKoi8r
  else if CompareText(s, 'latin1') = 0 then
    Result := csLatin1
  else if CompareText(s, 'latin2') = 0 then
    Result := csLatin2
  else if CompareText(s, 'swe7') = 0 then
    Result := csSwe7
  else if CompareText(s, 'ascii') = 0 then
    Result := csAscii
  else if CompareText(s, 'ujis') = 0 then
    Result := csUjis
  else if CompareText(s, 'sjis') = 0 then
    Result := csSjis
  else if CompareText(s, 'cp1251') = 0 then
    Result := csCp1251
  else if CompareText(s, 'hebrew') = 0 then
    Result := csHebrew
  else if CompareText(s, 'tis620') = 0 then
    Result := csTis620
  else if CompareText(s, 'euckr') = 0 then
    Result := csEuckr
  else if CompareText(s, 'koi8u') = 0 then
    Result := csKoi8u
  else if CompareText(s, 'gb2312') = 0 then
    Result := csGb2312
  else if CompareText(s, 'greek') = 0 then
    Result := csGreek
  else if CompareText(s, 'cp1250') = 0 then
    Result := csCp1250
  else if CompareText(s, 'gbk') = 0 then
    Result := csGbk
  else if CompareText(s, 'latin5') = 0 then
    Result := csLatin5
  else if CompareText(s, 'armscii8') = 0 then
    Result := csArmscii8
  else if CompareText(s, 'cp866') = 0 then
    Result := csCp866
  else if CompareText(s, 'keybcs2') = 0 then
    Result := csKeybcs2
  else if CompareText(s, 'macce') = 0 then
    Result := csMacce
  else if CompareText(s, 'macroman') = 0 then
    Result := csMacroman
  else if CompareText(s, 'cp852') = 0 then
    Result := csCp852
  else if CompareText(s, 'latin7') = 0 then
    Result := csLatin7
  else if CompareText(s, 'cp1256') = 0 then
    Result := csCp1256
  else if CompareText(s, 'cp1257') = 0 then
    Result := csCp1257
  else if CompareText(s, 'binary') = 0 then
    Result := csBinary
  else if CompareText(s, 'utf8') = 0 then
    Result := csUtf8
  else
    Result := csNone;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMySQLConnectionDefParams.SetCharacterSet(const AValue: TFDMySQLCharacterSet);
const
  C_CharacterSet: array[TFDMySQLCharacterSet] of String = ('', 'big5', 'dec8', 'cp850', 'hp8', 'koi8r', 'latin1', 'latin2', 'swe7', 'ascii', 'ujis', 'sjis', 'cp1251', 'hebrew', 'tis620', 'euckr', 'koi8u', 'gb2312', 'greek', 'cp1250', 'gbk', 'latin5', 'armscii8', 'cp866', 'keybcs2', 'macce', 'macroman', 'cp852', 'latin7', 'cp1256', 'cp1257', 'binary', 'utf8');
begin
  FDef.AsString[S_FD_ConnParam_Common_CharacterSet] := C_CharacterSet[AValue];
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLConnectionDefParams.GetTinyIntFormat: TFDMySQLTinyIntFormat;
var
  s: String;
begin
  s := FDef.AsString[S_FD_ConnParam_MySQL_TinyIntFormat];
  if CompareText(s, 'Boolean') = 0 then
    Result := tifBoolean
  else if CompareText(s, 'Integer') = 0 then
    Result := tifInteger
  else
    Result := tifBoolean;
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMySQLConnectionDefParams.SetTinyIntFormat(const AValue: TFDMySQLTinyIntFormat);
const
  C_TinyIntFormat: array[TFDMySQLTinyIntFormat] of String = ('Boolean', 'Integer');
begin
  FDef.AsString[S_FD_ConnParam_MySQL_TinyIntFormat] := C_TinyIntFormat[AValue];
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLConnectionDefParams.GetMetaDefCatalog: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_Common_MetaDefCatalog];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMySQLConnectionDefParams.SetMetaDefCatalog(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_Common_MetaDefCatalog] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLConnectionDefParams.GetMetaCurCatalog: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_Common_MetaCurCatalog];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMySQLConnectionDefParams.SetMetaCurCatalog(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_Common_MetaCurCatalog] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLConnectionDefParams.GetSSL_key: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_MySQL_SSL_key];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMySQLConnectionDefParams.SetSSL_key(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_MySQL_SSL_key] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLConnectionDefParams.GetSSL_cert: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_MySQL_SSL_cert];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMySQLConnectionDefParams.SetSSL_cert(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_MySQL_SSL_cert] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLConnectionDefParams.GetSSL_ca: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_MySQL_SSL_ca];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMySQLConnectionDefParams.SetSSL_ca(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_MySQL_SSL_ca] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLConnectionDefParams.GetSSL_capath: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_MySQL_SSL_capath];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMySQLConnectionDefParams.SetSSL_capath(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_MySQL_SSL_capath] := AValue;
end;

{-------------------------------------------------------------------------------}
function TFDPhysMySQLConnectionDefParams.GetSSL_cipher: String;
begin
  Result := FDef.AsString[S_FD_ConnParam_MySQL_SSL_cipher];
end;

{-------------------------------------------------------------------------------}
procedure TFDPhysMySQLConnectionDefParams.SetSSL_cipher(const AValue: String);
begin
  FDef.AsString[S_FD_ConnParam_MySQL_SSL_cipher] := AValue;
end;

end.
