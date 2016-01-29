{ ********************************************************************* }
{                                                                       }
{                           Gnostice Streams                            }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

unit Encrypt;

interface

uses
  Stream, gtObject, gtTypes, EncodeIntf, CryptStream, EncryptionSettings;

type
  TgtEncrypt = class(TgtEncode)
  private
    FOwnerPassword: AnsiString;
    FUserPassword: AnsiString;
    FOwnerKey: array[0..31] of Byte;
    FUserKey: array[0..31] of Byte;
    FOwnerPad: array[0..31] of Byte;
    FUserPad: array[0..31] of Byte;
    FFileKey: array[0..15] of Byte;
    FUserPermissions: TgtUserPermissions;
    FLevel: TgtPDFEncryptionLevel;
    FFileID: Bytes;

    FObjNum: Integer;
    FGenNum: integer;
    FStream: TgtStream;
    FString: AnsiString;

    function EncryptInit(AObjNo, AGenNo: Integer): TgtRC4Data;
    procedure MakeOwnerKey;
    function GetPermissionValue: Integer;
    procedure MakeUserKey;
    procedure MakeFileID(AFileName, ACreationTime: AnsiString);
    procedure MakeFileKey;
    function GetFileID: AnsiString;
    function GetUserKey: AnsiString;
    function GetOwnerKey: AnsiString;
  public
    constructor Create(AStream: TgtStream; ACreateDate: AnsiString; Settings: TgtEncryptionSettings;
      AEncryptAlg: TgtCryptAlgorithm; AKeyLength, AObjNum, AGenNum: Integer); overload;
    constructor Create(var AString, ACreateDate: AnsiString; Settings: TgtEncryptionSettings;
      AEncryptAlg: TgtCryptAlgorithm; AKeyLength, AObjNum, AGenNum: Integer); overload;
    constructor Create(AFileName, ACreationTime: AnsiString;
      Settings: TgtEncryptionSettings); overload;

    destructor Destroy; override;

    procedure EncryptBuffer(const ASrc: AnsiString; var ADest: AnsiString;
      ADataSize, AObjNum, AGenNum: Integer);
    procedure EncryptStream(var AStream: TgtStream; ADataSize, AObjNum,
      AGenNum: Integer);

    property PermissionValue: Integer read GetPermissionValue;
    property FileID: AnsiString read GetFileID;
    property OwnerKey: AnsiString read GetOwnerKey;
    property UserKey: AnsiString read GetUserKey;

    function Write(OutStream: TgtStream; Count: Cardinal): Cardinal; overload; override;
    function Write(Buffer: AnsiString; Count: Cardinal): Cardinal; overload; override;
  end;
implementation

{ TgtEncrypt }

constructor TgtEncrypt.Create(AStream: TgtStream; ACreateDate: AnsiString; Settings: TgtEncryptionSettings;
  AEncryptAlg: TgtCryptAlgorithm; AKeyLength, AObjNum, AGenNum: Integer);
begin
  FObjNum := AObjNum;
  FGenNum := AGenNum;
  FStream := AStream;

  FOwnerPassword := Settings.OwnerPassword;
  FUserPassword := Settings.UserPassword;
  FLevel := Settings.Level;
  FUserPermissions := Settings.UserPermissions;
  SetLength(FFileID, 16);
  MakeFileID('Output1.pdf', ACreateDate);
  MakeFileKey;
end;

constructor TgtEncrypt.Create(var AString, ACreateDate: AnsiString; Settings: TgtEncryptionSettings;
  AEncryptAlg: TgtCryptAlgorithm; AKeyLength, AObjNum, AGenNum: Integer);
begin
  FObjNum := AObjNum;
  FGenNum := AGenNum;
  FString := AString;

  FOwnerPassword := Settings.OwnerPassword;
  FUserPassword := Settings.UserPassword;
  FLevel := Settings.Level;
  FUserPermissions := Settings.UserPermissions;
  SetLength(FFileID, 16);
  MakeFileID('Output1.pdf', ACreateDate);
  MakeFileKey;
end;

constructor TgtEncrypt.Create(AFileName, ACreationTime: AnsiString;
  Settings: TgtEncryptionSettings);
begin
  FOwnerPassword := Settings.OwnerPassword;
  FUserPassword := Settings.UserPassword;
  FLevel := Settings.Level;
  FUserPermissions := Settings.UserPermissions;
  SetLength(FFileID, 16);
  MakeFileID(AFileName, ACreationTime);
  MakeFileKey;
end;

destructor TgtEncrypt.Destroy;
begin
  SetLength(FFileID, 0);
  inherited;
end;


procedure TgtEncrypt.EncryptBuffer(const ASrc: AnsiString; var ADest: AnsiString;
  ADataSize, AObjNum, AGenNum: Integer);
var
  RC4Data: TgtRC4Data;
  LInBuff, LOutBuff: Bytes;
  LI: Integer;
begin
  SetLength(LInBuff, length(ASrc));
  SetLength(LOutBuff, length(ASrc));
  Move(Asrc, LInBuff[0], length(ASrc));

  RC4Data := EncryptInit(AObjNum, AGenNum);
  TgtCryptStream.RC4Crypt(RC4Data, LInBuff, LOutBuff, ADataSize);

  for LI := 1 to Length(LOutBuff) do
    ADest := ADest + AnsiChar(LOutBuff[LI - 1]);

  SetLength(LInBuff, 0);
  SetLength(LOutBuff, 0);
end;

function TgtEncrypt.EncryptInit(AObjNo, AGenNo: Integer): TgtRC4Data;
var
  LKey: array[0..20] of Byte;
  LMD5Output: array[0..15] of Byte;
  MD5Data: TgtMD5Context;
  LMD5Digest: MD5Digest;
  LRC4Length: Integer;
begin
  Move(FFileKey, LKey, EncryptLength[FLevel]);
  LKey[EncryptLength[FLevel]] := (AObjNo and $FF);
  LKey[EncryptLength[FLevel] + 1] := (AObjNo shr 8) and $FF;
  LKey[EncryptLength[FLevel] + 2] := (AObjNo shr 16) and $FF;
  LKey[EncryptLength[FLevel] + 3] := AGenNo and $FF;
  LKey[EncryptLength[FLevel] + 4] := (AGenNo shr 8) and $FF;

  TgtCryptStream.MD5Init(MD5Data);
  TgtCryptStream.MD5Update(MD5Data, LKey, (EncryptLength[FLevel] + 5));
  TgtCryptStream.MD5Final(MD5Data, LMD5Digest);
  if (EncryptLength[FLevel] + 5) > 16 then
    LRC4Length := 16
  else
    LRC4Length := EncryptLength[FLevel] + 5;

  Move(LMD5Digest, LMD5Output, LRC4Length);
  TgtCryptStream.RC4Init(Result, LMD5Output, LRC4Length);
end;

procedure TgtEncrypt.EncryptStream(var AStream: TgtStream; ADataSize, AObjNum,
  AGenNum: Integer);
var
  EncryptedStream, LInputBuff: Bytes;
  RC4Data: TgtRC4Data;
  LI: Integer;
  LResultStrm: AnsiString;
begin
  LResultStrm := '';
  SetLength(EncryptedStream, ADataSize);
  SetLength(LInputBuff, ADataSize);

  FStream.Read(LInputBuff, ADataSize);
  RC4Data := EncryptInit(AObjNum, AGenNum);
  TgtCryptStream.RC4Crypt(RC4Data, LInputBuff, EncryptedStream, ADataSize);

  for LI := 1 to Length(EncryptedStream) do
    LResultStrm := LResultStrm + AnsiChar(EncryptedStream[LI - 1]);

  AStream.Write(LResultStrm);

  SetLength(EncryptedStream, 0);
  SetLength(LInputBuff, 0);
end;

function TgtEncrypt.GetFileID: AnsiString;
var
  LI: Integer;
begin
  Result := '';
  for LI := 0 to Length(FFileID) - 1 do
  begin
    Result := Result + AnsiChar(FFileID[LI]);
  end;
end;

function TgtEncrypt.GetOwnerKey: AnsiString;
var
  LI: Integer;
begin
  Result := '';
  for LI := 0 to Length(FOwnerKey) - 1 do
  begin
    Result := Result + AnsiChar(FOwnerKey[LI]);
  end;
end;

(*
    You can obtain Unsigned Short value by setting -
      Return type = Word.
      Result := $FFC0; instead of Result := $FFFFFFC0; &
      Result := $F0C0; instead of Result := $FFFFF0C0;
  *)

function TgtEncrypt.GetPermissionValue: Integer;
begin
{$R-}
  Result := $FFFFFFC0;
  if (EncryptLength[FLevel] > 5) then
    Result := $FFFFF0C0;
  if AllowPrint in FUserPermissions then
    Result := Result or 4;
  if AllowModify in FUserPermissions then
    Result := Result or 8;
  if AllowCopy in FUserPermissions then
    Result := Result or 16;
  if (AllowAnnotation in FUserPermissions) then
    Result := Result or 32;
  if (EncryptLength[FLevel] > 5) then
  begin
    if (AllowFormFill in FUserPermissions) then
      Result := Result or 256;
    if (AllowAccessibility in FUserPermissions) then
      Result := Result or 512;
    if (AllowDocAssembly in FUserPermissions) then
      Result := Result or 1024;
    if ((AllowHighResPrint in FUserPermissions) and
      (AllowPrint in FUserPermissions)) then
      Result := Result or 2048;
  end;
end;

function TgtEncrypt.GetUserKey: AnsiString;
var
  LI: Integer;
begin
  Result := '';
  for LI := 0 to Length(FUserKey) - 1 do
  begin
    Result := Result + AnsiChar(FUserKey[LI]);
  end;
end;

procedure TgtEncrypt.MakeFileID(AFileName, ACreationTime: AnsiString);
var
  LMD5Context: TgtMD5Context;
  LArray: array of Byte;
  LI: Integer;
  LMD5Digest: MD5Digest;
begin
  TgtCryptStream.MD5Init(LMD5Context);

  SetLength(LArray, Length(AFileName));
  for LI := 1 to Length(AFileName) do
    LArray[LI - 1] := Ord(AFileName[LI]);
  TgtCryptStream.MD5Update(LMD5Context, LArray, Length(AFileName));

  SetLength(LArray, 0);

  SetLength(LArray, Length(ACreationTime));
  for LI := 1 to Length(ACreationTime) do
    LArray[LI - 1] := Ord(ACreationTime[LI]);
  TgtCryptStream.MD5Update(LMD5Context, LArray, Length(ACreationTime));

  TgtCryptStream.MD5Final(LMD5Context, LMD5Digest);
  Move(LMD5Digest, FFileID[0], 16);

  SetLength(LArray, 0);
end;

procedure TgtEncrypt.MakeFileKey;
var
  S: array[0..3] of Byte;
  MD5Data: TgtMD5Context;
  LMD5Digest: MD5Digest;
  LI: Integer;
  LEncyptPerm: Cardinal;
begin
{$R-}
  if (FOwnerPassword = '') then
    TgtCryptStream.PasswordPadding(FUserPassword, FOwnerPad)
  else
    TgtCryptStream.PasswordPadding(FOwnerPassword, FOwnerPad);

  TgtCryptStream.PasswordPadding(FUserPassword, FUserPad);

  //Owner Key
  MakeOwnerKey;

  //permissions
  LEncyptPerm := GetPermissionValue;
  S[0] := Byte(LEncyptPerm and $FF);
  S[1] := Byte((LEncyptPerm shr 8) and $FF);
  S[2] := Byte((LEncyptPerm shr 16) and $FF);
  S[3] := Byte((LEncyptPerm shr 24) and $FF);

  //encryption key
  TgtCryptStream.MD5Init(MD5Data);
  TgtCryptStream.MD5Update(MD5Data, FUserPad, SizeOf(FUserPad));
  TgtCryptStream.MD5Update(MD5Data, FOwnerKey, SizeOf(FOwnerKey));
  TgtCryptStream.MD5Update(MD5Data, S, 4);
  TgtCryptStream.MD5Update(MD5Data, FFileID, 16);
  TgtCryptStream.MD5Final(MD5Data, LMD5Digest);

  if (EncryptLength[FLevel] > 5) then begin
    for LI := 0 to 49 do begin
      TgtCryptStream.MD5Init(MD5Data);
      TgtCryptStream.MD5Update(MD5Data, LMD5Digest, 16);
      TgtCryptStream.MD5Final(MD5Data, LMD5Digest);
    end;
  end;

  Move(LMD5Digest, FFileKey, EncryptLength[FLevel]);

  //user key
  MakeUserKey;
end;

procedure TgtEncrypt.MakeOwnerKey;
var
  MD5Data: TgtMD5Context;
  LMD5Digest: MD5Digest;
  LI, LJ: Integer;
  LMD5Output: array[0..15] of Byte;
  RC4Data: TgtRC4Data;
begin
  TgtCryptStream.MD5Init(MD5Data);
  TgtCryptStream.MD5Update(MD5Data, FOwnerPad, 32);
  TgtCryptStream.MD5Final(MD5Data, LMD5Digest);
  if (EncryptLength[FLevel] > 5) then begin
    for LI := 0 to 49 do begin
      TgtCryptStream.MD5Init(MD5Data);
      TgtCryptStream.MD5Update(MD5Data, LMD5Digest, 16);
      TgtCryptStream.MD5Final(MD5Data, LMD5Digest);
    end;
    Move(FUserPad, FOwnerKey, 32);
    for LI := 0 to 19 do begin
      for LJ := 0 to EncryptLength[FLevel] - 1 do
        FFileKey[LJ] := LMD5Digest[LJ] xor LI;
      TgtCryptStream.RC4Init(RC4Data, FFileKey, EncryptLength[FLevel]);
      TgtCryptStream.RC4Crypt(RC4Data, FOwnerKey, FOwnerKey, 32);
    end;
  end
  else begin
    Move(LMD5Digest, LMD5Output, 16);
    TgtCryptStream.RC4Init(RC4Data, LMD5Output, EncryptLength[FLevel]);
    TgtCryptStream.RC4Crypt(RC4Data, FUserPad, FOwnerKey, 32);
  end;
end;

procedure TgtEncrypt.MakeUserKey;
var
  MD5Data: TgtMD5Context;
  LMD5Digest: MD5Digest;
  LMD5Output: array[0..15] of Byte;
  LI, LJ: Integer;
  RC4Data: TgtRC4Data;
begin
  if (EncryptLength[FLevel] > 5) then begin
    TgtCryptStream.MD5Init(MD5Data);
    TgtCryptStream.MD5Update(MD5Data, Padding, 32);
    TgtCryptStream.MD5Update(MD5Data, FFileID, 16);
    TgtCryptStream.MD5Final(MD5Data, LMD5Digest);
    Move(LMD5Digest, FUserKey[0], 16);
    for LI := 16 to 31 do FUserKey[LI] := 0;
    for LI := 0 to 19 do begin
      for LJ := 0 to EncryptLength[FLevel] - 1 do
        LMD5Output[LJ] := FFileKey[LJ] xor LI;
      TgtCryptStream.RC4Init(RC4Data, LMD5Output, EncryptLength[FLevel]);
      TgtCryptStream.RC4Crypt(RC4Data, FUserKey, FUserKey, 16);
    end;
  end
  else begin
    TgtCryptStream.RC4Init(RC4Data, FFileKey, EncryptLength[FLevel]);
    TgtCryptStream.RC4Crypt(RC4Data, Padding, FUserKey, 32);
  end;
end;

function TgtEncrypt.Write(Buffer: AnsiString; Count: Cardinal): Cardinal;
var
  LEncryptedStr: AnsiString;
begin
  EncryptBuffer(Buffer, LEncryptedStr, Count, FObjNum, FGenNum);
  FStream.Reset;
  Result := FStream.Write(LEncryptedStr);
end;

function TgtEncrypt.Write(OutStream: TgtStream; Count: Cardinal): Cardinal;
begin
  Result := Count;
  try
    EncryptStream(OutStream, Count, FObjNum, FGenNum);
  except
    Result := 0;
  end;
end;

end.
