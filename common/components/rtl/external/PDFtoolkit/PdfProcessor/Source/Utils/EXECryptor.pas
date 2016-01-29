unit EXECryptor;

{ EXECryptor API v. 2.3 }

{$DEFINE USE_API}
{$DEFINE USE_CRYPT_REG}
{$DEFINE USE_STD_SERIALS}

{$DEFINE ANTIDEBUG_ON_INIT}

interface

uses Windows, SysUtils;

{$IFDEF USE_API}

function IsAppProtected: Boolean; stdcall;
function GetEXECryptorVersion: string;

function SafeGetDate: TDateTime;
function GetHardwareID: DWORD; stdcall;
function GetReleaseDate: TDateTime;

function EncryptStr(const s: string): string;
function EncryptStrW(const s: WideString): WideString;
function DecryptStr(const s: string): string;
function DecryptStrW(const s: WideString): WideString;

function SecureWrite(const Name,Value: string): Boolean;
function SecureWriteW(const Name,Value: WideString): Boolean;
function SecureRead(const Name: string; var Value: string): Boolean;
function SecureReadW(const Name: WideString; var Value: WideString): Boolean;

function SafeMessageBox(hWnd: HWND; lpText, lpCaption: PAnsiChar; uType: UINT): Integer; stdcall;
function SafeGetProcAddr(h: THandle; Name: PChar): TFarProc; stdcall;

procedure AntiDebug; stdcall;
procedure ProtectImport; stdcall;

function GetTrialDaysLeft(TrialPeriod: integer): integer; stdcall;
function GetTrialRunsLeft(TrialRuns: integer): integer; stdcall;

{$ENDIF}

{$IFDEF USE_CRYPT_REG}

type
  TVerifyResult = (vrInvalid, vrExpired, vrStolen, vrOK);

function IsRegistered: TVerifyResult; stdcall;

{$IFDEF USE_STD_SERIALS}

type
  TSerialNumberInfo = packed record
    LicType: integer;    //0..15
    // if LicType = 1 then we get ExpiryMonth/ExpiryYear
    // otherwise we get UserParam
    UserParam: integer;  //0..1023
    ExpiryMonth,         //1..12
    ExpiryYear: integer; //2004..2024
    F1,F2,F3,F4,F5,F6: Boolean;
  end;
  
function VerifySerialNumber(const RegistrationName,
  SerialNumber: string; const HardwareID: string = ''): TVerifyResult;

function VerifySerialNumberEx(const RegistrationName,
  SerialNumber: string; var SerialNumberInfo: TSerialNumberInfo;
  const HardwareID: string = ''): TVerifyResult;

function VerifySerialNumberW(const RegistrationName, SerialNumber: WideString;
  const HardwareID: WideString = ''): TVerifyResult;

function VerifySerialNumberExW(const RegistrationName, SerialNumber: WideString;
  var SerialNumberInfo: TSerialNumberInfo;
  const HardwareID: WideString = ''): TVerifyResult;

function DecodeSerialNumber(const RegistrationName,
  SerialNumber: string; var SerialNumberInfo: TSerialNumberInfo;
  const HardwareID: string = ''): TVerifyResult;

function DecodeSerialNumberW(const RegistrationName,SerialNumber: WideString;
  var SerialNumberInfo: TSerialNumberInfo;
  const HardwareID: WideString = ''): TVerifyResult;

{$ELSE}

procedure SetCodeKey(Key: Pointer; Size: integer); stdcall;

{$ENDIF}

function RegConst_0: DWORD; stdcall;
function RegConst_1: DWORD; stdcall;
function RegConst_2: DWORD; stdcall;
function RegConst_3: DWORD; stdcall;
function RegConst_4: DWORD; stdcall;
function RegConst_5: DWORD; stdcall;
function RegConst_6: DWORD; stdcall;
function RegConst_7: DWORD; stdcall;

{$ENDIF}

// need for correct entry point protection
procedure EXECryptor_halt;

implementation

{$O-}
{$IFDEF USE_API}
function GetHardwareID: DWORD; stdcall;
begin
  asm
    db $90,$90,$90,$90
  end;
  Result:=0;
end;

function EXECryptor_GetDate: DWORD; stdcall;
var t1,t2: TFileTime;
    dt,tt: WORD;
begin
  GetSystemTimeAsFileTime(t1);
  FileTimeToLocalFileTime(t1,t2);
  FileTimeToDosDateTime(t2,dt,tt);
  Result:=dt;
end;

function SafeGetDate: TDateTime;
var dt: DWORD;
begin
  dt:=EXECryptor_GetDate;
  Result:=EncodeDate((dt shr 9)+1980,(dt shr 5) and $F,dt and $1F);
end;

function EXECryptor_GetEXECryptorVersion: PChar; stdcall;
begin
  Result:='UNPROTECTED';
end;

function GetEXECryptorVersion: string;
begin
  Result:=EXECryptor_GetEXECryptorVersion;
end;

function IsAppProtected: Boolean; stdcall;
begin
  Result:=False;
end;

function EXECryptor_GetReleaseDate: DWORD; stdcall;
var t1,t2: TFileTime;
    dt,tt: WORD;
begin
  GetSystemTimeAsFileTime(t1);
  FileTimeToLocalFileTime(t1,t2);
  FileTimeToDosDateTime(t2,dt,tt);
  Result:=dt;
end;

function GetReleaseDate: TDateTime;
var dt: DWORD;
begin
  dt:=EXECryptor_GetDate;
  Result:=EncodeDate((dt shr 9)+1980,(dt shr 5) and $F,dt and $1F);
end;

procedure EXECryptor_EncryptStr(Src,Dst: PChar); stdcall;
begin
  StrCopy(Dst,Src);
end;

function EncryptStr(const s: string): string;
begin
  SetLength(Result,Length(s)*2+4);
  EXECryptor_EncryptStr(PChar(s),PChar(Result));
  Result:=PChar(Result);
end;

procedure EXECryptor_DecryptStr(Src,Dst: PChar); stdcall;
begin
  StrCopy(Dst,Src);
end;

function DecryptStr(const s: string): string;
begin
  SetLength(Result,Length(s));
  EXECryptor_DecryptStr(PChar(s),PChar(Result));
  Result:=PChar(Result);
end;

procedure EXECryptor_EncryptStrW(Src,Dst: PWideChar); stdcall;
begin
  repeat
    Dst^:=Src^;
    Inc(Dst); Inc(Src);
  until Src^ = #0
end;

function EncryptStrW(const s: WideString): WideString;
begin
  SetLength(Result,Length(s)*2+4);
  EXECryptor_EncryptStrW(PWideChar(s),PWideChar(Result));
  Result:=PWideChar(Result);
end;

procedure EXECryptor_DecryptStrW(Src,Dst: PWideChar); stdcall;
begin
  repeat
    Dst^:=Src^;
    Inc(Dst); Inc(Src);
  until Src^ = #0
end;

function DecryptStrW(const s: WideString): WideString;
begin
  SetLength(Result,Length(s));
  EXECryptor_DecryptStrW(PWideChar(s),PWideChar(Result));
  Result:=PWideChar(Result);
end;

const
  TestKeyPath = 'Software\EXECryptorTestKeys';

function EXECryptor_SecureWrite(Name,Value: PChar): Boolean; stdcall;
var Disposition: integer;
    KeyHandle: HKEY;
begin
  Result:=False;
  if RegCreateKeyExA(HKEY_CURRENT_USER, TestKeyPath, 0, nil,
      REG_OPTION_NON_VOLATILE, KEY_SET_VALUE, nil, KeyHandle, @Disposition) = ERROR_SUCCESS then begin
    RegSetValueExA(KeyHandle, Name, 0, REG_BINARY, PByte(Value), strlen(Value)+1);
    Result:=True;
    RegCloseKey(KeyHandle);
  end;
end;

function SecureWrite(const Name,Value: string): Boolean;
begin
  Result:=EXECryptor_SecureWrite(PChar(Name),PChar(Value));
end;

function EXECryptor_SecureRead(Name,Value: PChar): Boolean; stdcall;
var KeyHandle: HKEY;
    sz,tp: DWORD;
begin
  Result:=False;
  if RegOpenKeyExA(HKEY_CURRENT_USER, TestKeyPath, 0, KEY_QUERY_VALUE, KeyHandle) = ERROR_SUCCESS then begin
    tp:=REG_BINARY;
    if RegQueryValueExA(KeyHandle, Name, nil, @tp, nil, @sz) = ERROR_SUCCESS then begin
      RegQueryValueExA(KeyHandle, Name, nil, @tp, PByte(Value), @sz);
      Result:=True;
    end;
    RegCloseKey(KeyHandle);
  end;
end;

function SecureRead(const Name: string; var Value: string): Boolean;
begin
  SetLength(Value,1024);
  Result:=EXECryptor_SecureRead(PChar(Name),PChar(Value));
  if Result then Value:=PChar(Value)
  else Value:='';
end;

function EXECryptor_SecureWriteW(Name,Value: PWideChar): Boolean; stdcall;
var Disposition: integer;
    KeyHandle: HKEY;
    p: PWideChar;
    sz: integer;
begin
  Result:=False;
  if RegCreateKeyExW(HKEY_CURRENT_USER, TestKeyPath, 0, nil,
      REG_OPTION_NON_VOLATILE, KEY_SET_VALUE, nil, KeyHandle, @Disposition) = ERROR_SUCCESS then begin
    p:=Value; sz:=1;
    while p^ <> #0 do begin
      Inc(sz); Inc(p);
    end;
    RegSetValueExW(KeyHandle, Name, 0, REG_BINARY, PByte(Value), sz*2);
    Result:=True;
    RegCloseKey(KeyHandle);
  end;
end;

function SecureWriteW(const Name,Value: WideString): Boolean;
begin
  Result:=EXECryptor_SecureWriteW(PWideChar(Name),PWideChar(Value));
end;

function EXECryptor_SecureReadW(Name,Value: PWideChar): Boolean; stdcall;
var KeyHandle: HKEY;
    sz,tp: DWORD;
begin
  Result:=False;
  if RegOpenKeyExW(HKEY_CURRENT_USER, TestKeyPath, 0, KEY_QUERY_VALUE, KeyHandle) = ERROR_SUCCESS then begin
    tp:=REG_BINARY;
    if RegQueryValueExW(KeyHandle, Name, nil, @tp, nil, @sz) = ERROR_SUCCESS then begin
      RegQueryValueExW(KeyHandle, Name, nil, @tp, PByte(Value), @sz);
      Result:=True;
    end;
    RegCloseKey(KeyHandle);
  end;
end;

function SecureReadW(const Name: WideString; var Value: WideString): Boolean;
begin
  SetLength(Value,1024);
  Result:=EXECryptor_SecureReadW(PWideChar(Name),PWideChar(Value));
  if Result then Value:=PWideChar(Value)
  else Value:='';
end;

function SafeMessageBox(hWnd: HWND; lpText, lpCaption: PAnsiChar; uType: UINT): Integer; stdcall;
begin
  Result:=MessageBoxA(hWnd,lpText,lpCaption,uType);
end;

function SafeGetProcAddr(h: THandle; Name: PChar): TFarProc; stdcall;
begin
  Result:=GetProcAddress(h,Name);
end;

procedure AntiDebug; stdcall;
begin
  asm
    db $90,$90,$90,$90,$90
  end;
end;

procedure ProtectImport; stdcall;
begin
  asm
    db $90,$90,$90,$90,$90
  end;
end;

function GetTrialDaysLeft(TrialPeriod: integer): integer; stdcall;
begin
  Result:=TrialPeriod;
end;

function GetTrialRunsLeft(TrialRuns: integer): integer; stdcall;
begin
  Result:=TrialRuns;
end;

{$ENDIF}

{$IFDEF USE_CRYPT_REG}

function IsRegistered: TVerifyResult; stdcall;
begin
  asm
    db $90,$90,$90,$90
  end;
  Result:=vrOK;
end;

{$IFDEF USE_STD_SERIALS}

type
  PSerialNumberInfo = ^TSerialNumberInfo;

function EXECryptor_VerifySerialNumber(RegName,SN: PChar;
  SNInfo: PSerialNumberInfo; HWID: PChar): integer; stdcall;
begin
  asm
    db $90,$90,$90,$90
  end;
  Result:=3;//vrOK;
end;

function EXECryptor_VerifySerialNumberW(RegName,SN: PWideChar;
  SNInfo: PSerialNumberInfo; HWID: PWideChar): integer; stdcall;
begin
  asm
    db $90,$90,$90,$90
  end;
  Result:=3;//vrOK;
end;

function EXECryptor_DecodeSerialNumber(RegName,SN: PChar;
  SNInfo: PSerialNumberInfo; HWID: PChar): integer; stdcall;
begin
  asm
    db $90,$90,$90,$90
  end;
  Result:=3;//vrOK;
end;

function EXECryptor_DecodeSerialNumberW(RegName,SN: PWideChar;
  SNInfo: PSerialNumberInfo; HWID: PWideChar): integer; stdcall;
begin
  asm
    db $90,$90,$90,$90
  end;
  Result:=3;//vrOK;
end;

function VerifySerialNumber(const RegistrationName,
  SerialNumber: string; const HardwareID: string): TVerifyResult;
begin
  Result:=TVerifyResult(EXECryptor_VerifySerialNumber(PChar(RegistrationName),
      PChar(SerialNumber),nil,PChar(HardwareID)));
end;

function VerifySerialNumberEx(const RegistrationName,
  SerialNumber: string; var SerialNumberInfo: TSerialNumberInfo;
  const HardwareID: string): TVerifyResult;
begin
  Result:=TVerifyResult(EXECryptor_VerifySerialNumber(PChar(RegistrationName),
      PChar(SerialNumber),@SerialNumberInfo,PChar(HardwareID)));
end;

function VerifySerialNumberW(const RegistrationName, SerialNumber: WideString;
  const HardwareID: WideString): TVerifyResult;
begin
  Result:=TVerifyResult(EXECryptor_VerifySerialNumberW(PWideChar(RegistrationName),
      PWideChar(SerialNumber),nil,PWideChar(HardwareID)));
end;

function VerifySerialNumberExW(const RegistrationName, SerialNumber: WideString;
  var SerialNumberInfo: TSerialNumberInfo;
  const HardwareID: WideString): TVerifyResult;
begin
  Result:=TVerifyResult(EXECryptor_VerifySerialNumberW(PWideChar(RegistrationName),
      PWideChar(SerialNumber),@SerialNumberInfo,PWideChar(HardwareID)));
end;

function DecodeSerialNumber(const RegistrationName,
  SerialNumber: string; var SerialNumberInfo: TSerialNumberInfo;
  const HardwareID: string): TVerifyResult;
begin
  Result:=TVerifyResult(EXECryptor_DecodeSerialNumber(PChar(RegistrationName),
      PChar(SerialNumber),@SerialNumberInfo,PChar(HardwareID)));
end;

function DecodeSerialNumberW(const RegistrationName,SerialNumber: WideString;
  var SerialNumberInfo: TSerialNumberInfo;
  const HardwareID: WideString): TVerifyResult;
begin
  Result:=TVerifyResult(EXECryptor_DecodeSerialNumberW(PWideChar(RegistrationName),
      PWideChar(SerialNumber),@SerialNumberInfo,PWideChar(HardwareID)));
end;

{$ELSE}

procedure SetCodeKey(Key: Pointer; Size: integer); stdcall;
begin
  asm
    db $90,$90,$90,$90,$90
  end;
end;
{$ENDIF}

function RegConst_0: DWORD; stdcall;
begin
  asm
    db $90,$90,$90,$90
  end;
  Result:=0;
end;

function RegConst_1: DWORD; stdcall;
begin
  asm
    db $90,$90,$90,$90
  end;
  Result:=1;
end;

function RegConst_2: DWORD; stdcall;
begin
  asm
    db $90,$90,$90,$90
  end;
  Result:=2;
end;

function RegConst_3: DWORD; stdcall;
begin
  asm
    db $90,$90,$90,$90
  end;
  Result:=3;
end;

function RegConst_4: DWORD; stdcall;
begin
  asm
    db $90,$90,$90,$90
  end;
  Result:=4;
end;

function RegConst_5: DWORD; stdcall;
begin
  asm
    db $90,$90,$90,$90
  end;
  Result:=5;
end;

function RegConst_6: DWORD; stdcall;
begin
  asm
    db $90,$90,$90,$90
  end;
  Result:=6;
end;

function RegConst_7: DWORD; stdcall;
begin
  asm
    db $90,$90,$90,$90
  end;
  Result:=7;
end;
{$ENDIF}
{$O+}

procedure EXECryptor_halt;
begin
  Halt;
end;

{$IFDEF USE_CRYPT_REG}
exports
  IsRegistered name 'EXECryptor_IsRegistered';
{$IFDEF USE_STD_SERIALS}
exports
  EXECryptor_VerifySerialNumber,
  EXECryptor_VerifySerialNumberW,
  EXECryptor_DecodeSerialNumber,
  EXECryptor_DecodeSerialNumberW,
  VerifySerialNumber name 'EXECryptor_FN_10',
  VerifySerialNumberEx name 'EXECryptor_FN_11',
  VerifySerialNumberW name 'EXECryptor_FN_12',
  VerifySerialNumberExW name 'EXECryptor_FN_13',
  DecodeSerialNumber name 'EXECryptor_FN_14',
  DecodeSerialNumberW name 'EXECryptor_FN_15';
{$ELSE}
exports
  SetCodeKey name 'EXECryptor_SetCodeKey';
{$ENDIF}
exports
  RegConst_0 name 'EXECryptor_RegConst_0',
  RegConst_1 name 'EXECryptor_RegConst_1',
  RegConst_2 name 'EXECryptor_RegConst_2',
  RegConst_3 name 'EXECryptor_RegConst_3',
  RegConst_4 name 'EXECryptor_RegConst_4',
  RegConst_5 name 'EXECryptor_RegConst_5',
  RegConst_6 name 'EXECryptor_RegConst_6',
  RegConst_7 name 'EXECryptor_RegConst_7';
{$ENDIF}
{$IFDEF USE_API}
exports
  GetHardwareID name 'EXECryptor_GetHardwareID',
  IsAppProtected name 'EXECryptor_IsAppProtected',
  EXECryptor_GetDate,
  EXECryptor_GetEXECryptorVersion,
  EXECryptor_GetReleaseDate,
  EXECryptor_EncryptStr,
  EXECryptor_DecryptStr,
  EXECryptor_EncryptStrW,
  EXECryptor_DecryptStrW,
  EXECryptor_SecureWrite,
  EXECryptor_SecureRead,
  EXECryptor_SecureWriteW,
  EXECryptor_SecureReadW,
  SafeMessageBox name 'EXECryptor_MessageBox',
  SafeGetProcAddr name 'EXECryptor_GetProcAddr',
  AntiDebug name 'EXECryptor_AntiDebug',
  ProtectImport name 'EXECryptor_ProtectImport',
  GetTrialDaysLeft name 'EXECryptor_GetTrialDaysLeft',
  GetTrialRunsLeft name 'EXECryptor_GetTrialRunsLeft',
  GetEXECryptorVersion name 'EXECryptor_FN_0',
  GetReleaseDate name 'EXECryptor_FN_1',
  EncryptStr name 'EXECryptor_FN_2',
  DecryptStr name 'EXECryptor_FN_3',
  EncryptStrW name 'EXECryptor_FN_4',
  DecryptStrW name 'EXECryptor_FN_5',
  SecureWrite name 'EXECryptor_FN_6',
  SecureRead name 'EXECryptor_FN_7',
  SecureWriteW name 'EXECryptor_FN_8',
  SecureReadW name 'EXECryptor_FN_9',
  SafeGetDate name 'EXECryptor_FN_16';
{$ENDIF}
exports
  EXECryptor_halt name 'EXECryptor_halt';

{$IFDEF ANTIDEBUG_ON_INIT}
{$IFDEF USE_API}
initialization
  {$I crypt_start.inc}
  ProtectImport;
  AntiDebug;
  {$I crypt_end.inc}
{$ENDIF}
{$ENDIF}
end.
