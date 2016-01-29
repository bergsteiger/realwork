{ ********************************************************************* }
{                                                                       }
{                           Gnostice Streams                            }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

unit Decrypt;

interface

uses
  Stream, gtObject, gtTypes, DecodeIntf, CryptStream, EncryptionSettings;

type
  TgtDecrypt = class(TgtDecode)
  private
    FLevel: TgtPDFEncryptionLevel;
    FFileID: Bytes;
    FOwnerKey: array[0..31] of Byte;
    FUserKey: array[0..31] of Byte;
    FFileKey: array[0..15] of Byte;
    FPadding: array[0..31] of Byte;
    FUserPermissions: TgtUserPermissions;
    FPermissions: array[0..3] of Byte;
    FIsOwner: Boolean;
//    FEncryptSetings: TgtEncryptionSettings;
    FBuffer: AnsiString;
    FPos: Integer;

    FStream: TgtStream;
    FString: AnsiString;
    FEncryptAlg: TgtCryptAlgorithm;
    FKeyLength: Integer;
    FObjNum: Integer;
    FGenNum: Integer;

    procedure SetLevel(const Value: TgtPDFEncryptionLevel);
    procedure SetFileID(const Value: AnsiString);
    procedure SetUserKey(const Value: AnsiString);
    procedure SetOwnerKey(const Value: AnsiString);
    procedure SetUserPermissions;
    procedure SetPermissions(const Value: Int64);
    function IsHex(const Value: AnsiString): Boolean;
    function CheckUserPassword(AUserPassword: AnsiString): Integer;
    function CheckOwnerPassword(AOwnerPassword: AnsiString; var AUserPassword: AnsiString): Integer;
  public
    constructor Create(AStream: TgtStream; ACreateDate: AnsiString; AEncryptSetings: TgtEncryptionSettings;
      AEncryptAlg: TgtCryptAlgorithm; AKeyLength, AObjNum, AGenNum: Integer); overload;
    constructor Create(var AString, ACreateDate: AnsiString; AEncryptSetings: TgtEncryptionSettings;
      AEncryptAlg: TgtCryptAlgorithm; AKeyLength, AObjNum, AGenNum: Integer); overload;
    destructor Destroy; override;

    function CheckPassword(var Settings: TgtEncryptionSettings;
      Password: AnsiString): Boolean; override;
    procedure DecryptStream(var AStream: TgtStream; AOutStream: TgtStream; ADataSize, AObjNo,
      AGenNo: Integer);
    procedure DecryptString(const ASrc: AnsiString; var ADest: AnsiString; ADataSize, AObjNo,
      AGenNo: Integer);

    property Level: TgtPDFEncryptionLevel read FLevel write SetLevel
      default el128bit;
    property FileID: AnsiString write SetFileID;
    property OwnerKey: AnsiString write SetOwnerKey;
    property UserKey: AnsiString write SetUserKey;
    property UserPermissions: TgtUserPermissions read FUserPermissions
      default [AllowCopy, AllowModify, AllowPrint, AllowAnnotation,
      AllowFormFill, AllowAccessibility, AllowDocAssembly, AllowHighResPrint];
    property Permissions: Int64 write SetPermissions;

    procedure Reset; override;
    function GetChar: Integer; override;
    function LookChar: Integer; override;
  end;

implementation

uses
  gtMethods, StreamExceptions, StreamConsts{$IFNDEF DOTNET}, SysUtils{$ENDIF};

{ TgtDecrypt }

constructor TgtDecrypt.Create(AStream: TgtStream; ACreateDate: AnsiString; AEncryptSetings: TgtEncryptionSettings;
  AEncryptAlg: TgtCryptAlgorithm; AKeyLength, AObjNum, AGenNum: Integer);
var
  LI: Integer;
begin
  FStream := AStream;
  FKeyLength := AKeyLength;
  FObjNum := AObjNum;
  FGenNum := AGenNum;
  FEncryptAlg := AEncryptAlg;

  OwnerKey := AEncryptSetings.OwnerPassword;
  UserKey := AEncryptSetings.UserPassword;
  Level := AEncryptSetings.Level;
  Permissions := AEncryptSetings.Permission;
  FileID := AEncryptSetings.FileID;

  FUserPermissions := [AllowCopy, AllowModify, AllowPrint, AllowAnnotation,
    AllowFormFill, AllowAccessibility, AllowDocAssembly, AllowHighResPrint];

  for LI := 0 to Length(Padding) - 1 do
    FPadding[LI] := Padding[LI];
end;

function TgtDecrypt.CheckOwnerPassword(AOwnerPassword: AnsiString;
  var AUserPassword: AnsiString): Integer;
var
  LOwnerPad: array[0..31] of Byte;
  LContext: TgtMD5Context;
  LDigest: MD5Digest;

  LRC4Data: TgtRC4Data;

  LRC4Output: array[0..31] of Byte;

  LI, LJ, LEncryptionLength: Integer;

  LEncryptionKey, LEncryptionKeyXor: array[0..15] of Byte;
  LUserPassword: AnsiString;
begin
  Result := -1;
  LEncryptionLength := EncryptLength[Level];

  if Level = el40bit then
  begin
    if (AOwnerPassword <> '') then
      TgtCryptStream.PasswordPadding(AOwnerPassword, LOwnerPad)
    else
      Move(FPadding, LOwnerPad, Length(Padding));

    TgtCryptStream.MD5Init(LContext);
    TgtCryptStream.MD5Update(LContext, LOwnerPad, Length(LOwnerPad));
    TgtCryptStream.MD5Final(LContext, LDigest);

    TgtCryptStream.RC4Init(LRC4Data, LDigest[0], LEncryptionLength);

    TgtCryptStream.RC4Crypt(LRC4Data, FOwnerKey[0], LRC4Output[0], 32);

    SetLength(LUserPassword, 32);

    for LI := 1 to 33 do
      LUserPassword[LI] := AnsiChar(LRC4Output[LI - 1]);

    // Obtain the User Password
    AUserPassword := '';
    for LJ := 1 to Length(LUserPassword) do
    begin
      if ((LUserPassword[LJ] = AnsiChar(FPadding[0])) and
        (LUserPassword[LJ + 1] = AnsiChar(FPadding[1]))) then break;
      AUserPassword := AUserPassword + LUserPassword[LJ]
    end;

    if (CheckUserPassword(LUserPassword) <> 0) then
      Exit;
  end
  else
  begin
    if (AOwnerPassword <> '') then
      TgtCryptStream.PasswordPadding(AOwnerPassword, LOwnerPad)
    else
      Move(FPadding, LOwnerPad, Length(FPadding));

    TgtCryptStream.MD5Init(LContext);
    TgtCryptStream.MD5Update(LContext, LOwnerPad, Length(LOwnerPad));
    TgtCryptStream.MD5Final(LContext, LDigest);

    for LI := 0 to 49 do
    begin
      TgtCryptStream.MD5Init(LContext);
      TgtCryptStream.MD5Update(LContext, LDigest, 16);
      TgtCryptStream.MD5Final(LContext, LDigest);
    end;
    Move(LDigest, LEncryptionKey, LEncryptionLength);

    Move(FOwnerKey, LRC4Output, 32);

    for LI := 19 downto 0 do
    begin
      for LJ := 0 to LEncryptionLength - 1 do
        LEncryptionKeyXor[LJ] := LDigest[LJ] xor LI;

      TgtCryptStream.RC4Init(LRC4Data, LEncryptionKeyXor, LEncryptionLength);
      TgtCryptStream.RC4Crypt(LRC4Data, LRC4Output, LRC4Output, 32);
    end;

    SetLength(LUserPassword, 32);

    for LI := 1 to 32 do
      LUserPassword[LI] := AnsiChar(LRC4Output[LI - 1]);

    // Obtain the User Password
    AUserPassword := '';
    for LJ := 1 to Length(LUserPassword) do
    begin
      if ((LUserPassword[LJ] = AnsiChar(FPadding[0])) and
        (LUserPassword[LJ + 1] = AnsiChar(FPadding[1]))) then break;
      AUserPassword := AUserPassword + LUserPassword[LJ]
    end;

    if (CheckUserPassword(LUserPassword) <> 0) then
      Exit;
  end;
  SetLength(LUserPassword, 0);
  Result := 0;
end;

function TgtDecrypt.CheckPassword(var Settings: TgtEncryptionSettings;
  Password: AnsiString): Boolean;
var
  LUserPassword: AnsiString;
begin
  Result := False;
  if (CheckOwnerPassword(Password, LUserPassword) = 0) then
  begin
    FIsOwner := True;
    Result := True;

    Settings.Enabled := True;
    Settings.OwnerPassword := Password;
    Settings.UserPassword := LUserPassword;
    Settings.UserPermissions := UserPermissions;
    Settings.Level := Level;
  end
  else if (CheckUserPassword(Password) = 0) then
  begin
    SetUserPermissions;
    Result := True;
    Settings.Enabled := True;
    Settings.UserPassword := Password;
    Randomize;
    Settings.OwnerPassword := 'Gnostice' +
      FormatDateTime('yyyymmddhhnnss', Now) + IntToStr(Random(MaxInt)); // Check This line
    Settings.UserPermissions := UserPermissions;
    Settings.Level := Level;
    Settings.IsOwner := False;
  end;
end;

function TgtDecrypt.CheckUserPassword(AUserPassword: AnsiString): Integer;
var
  LUserPad: array[0..31] of Byte;
  LContext: TgtMD5Context;
  LDigest: MD5Digest;
  LEncryptionKey, LEncryptionKeyXor: array[0..15] of Byte;

  LRC4Data: TgtRC4Data;
  LRC4Output: array[0..31] of Byte;
  LMD5Output: MD5Digest;

  LI, LJ, LEncryptionLength: Integer;
begin
  Result := -1;
  LEncryptionLength := EncryptLength[Level];

  if Level = el40bit then
  begin
    TgtCryptStream.PasswordPadding(AUserPassword, LUserPad);
    TgtCryptStream.MD5Init(LContext);
    TgtCryptStream.MD5Update(LContext, LUserPad, Length(LUserPad));
    TgtCryptStream.MD5Update(LContext, FOwnerKey, Length(FOwnerKey));
    TgtCryptStream.MD5Update(LContext, FPermissions, Length(FPermissions));
    if Length(FFileId) <> 0 then
      TgtCryptStream.MD5Update(LContext, FFileId, Length(FFileId));
    TgtCryptStream.MD5Final(LContext, LDigest);
    Move(LDigest, LEncryptionKey, LEncryptionLength);

    TgtCryptStream.RC4Init(LRC4Data, LEncryptionKey, LEncryptionLength);
    TgtCryptStream.RC4Crypt(LRC4Data, FUserKey, LRC4Output, 32);

    for LI := 0 to 31 do
      if (LRC4Output[LI] <> FPadding[LI]) then
        Exit;

    for LI := 0 to (LEncryptionLength - 1) do
      FFileKey[LI] := LEncryptionKey[LI];

    for LI := 5 to 15 do
      FFileKey[LI] := 0;
  end
  else
  begin
    TgtCryptStream.PasswordPadding(AUserPassword, LUserPad);
    TgtCryptStream.MD5Init(LContext);
    TgtCryptStream.MD5Update(LContext, LUserPad, Length(LUserPad));
    TgtCryptStream.MD5Update(LContext, FOwnerKey, Length(FOwnerKey));
    TgtCryptStream.MD5Update(LContext, FPermissions, Length(FPermissions));
    if Length(FFileId) <> 0 then
      TgtCryptStream.MD5Update(LContext, FFileId, Length(FFileId));
    TgtCryptStream.MD5Final(LContext, LDigest);
    for LI := 0 to 49 do
    begin
      TgtCryptStream.MD5Init(LContext);
      TgtCryptStream.MD5Update(LContext, LDigest, 16);
      TgtCryptStream.MD5Final(LContext, LDigest);
    end;
    Move(LDigest, LEncryptionKey, LEncryptionLength);
    Move(FUserKey, LRC4Output, 32);

    for LI := 19 downto 0 do
    begin
      for LJ := 0 to LEncryptionLength - 1 do
        LEncryptionKeyXor[LJ] := LEncryptionKey[LJ] xor LI;

      TgtCryptStream.RC4Init(LRC4Data, LEncryptionKeyXor, LEncryptionLength);
      TgtCryptStream.RC4Crypt(LRC4Data, LRC4Output, LRC4Output, 32);
    end;

    TgtCryptStream.MD5Init(LContext);
    TgtCryptStream.MD5Update(LContext, FPadding, Length(FPadding));
    if Length(FFileId) <> 0 then
      TgtCryptStream.MD5Update(LContext, FFileId, Length(FFileId));
    TgtCryptStream.MD5Final(LContext, LMD5Output);

    for LI := 0 to 15 do
      if (LRC4Output[LI] <> LMD5Output[LI]) then
        Exit;

    for LI := 0 to (LEncryptionLength - 1) do
      FFileKey[LI] := LEncryptionKey[LI];
  end;

  Result := 0;
end;

constructor TgtDecrypt.Create(var AString, ACreateDate: AnsiString; AEncryptSetings: TgtEncryptionSettings;
  AEncryptAlg: TgtCryptAlgorithm; AKeyLength, AObjNum, AGenNum: Integer);
var
  LI: Integer;
begin
  FEncryptAlg := AEncryptAlg;
  FKeyLength := AKeyLength;
  FObjNum := AObjNum;
  FGenNum := AGenNum;
  FString := AString;

  OwnerKey := AEncryptSetings.OwnerPassword;
  UserKey := AEncryptSetings.UserPassword;
  Level := AEncryptSetings.Level;
  Permissions := AEncryptSetings.Permission;
  FileID := AEncryptSetings.FileID;

  FUserPermissions := [AllowCopy, AllowModify, AllowPrint, AllowAnnotation,
    AllowFormFill, AllowAccessibility, AllowDocAssembly, AllowHighResPrint];

  for LI := 0 to Length(Padding) - 1 do
    FPadding[LI] := Padding[LI];
end;

procedure TgtDecrypt.DecryptStream(var AStream: TgtStream; AOutStream: TgtStream;
  ADataSize, AObjNo, AGenNo: Integer);
var
  LKey: array[0..20] of Byte;
  LMD5Output: array[0..15] of Byte;
  LMD5Data: TgtMD5Context;
  LMD5Digest: MD5Digest;

  LRC4Data: TgtRC4Data;
  EncryptedStream: Bytes;
  LInputBuff: Bytes;
  LResultStrm: AnsiString;
  LI: Integer;
begin
  LResultStrm := '';
  if Level = el128bit then
  begin
    Move(FFileKey[0], LKey[0], Level128N);
    LKey[Level128N] := (AObjNo and $FF);
    LKey[Level128N + 1] := (AObjNo shr 8) and $FF;
    LKey[Level128N + 2] := (AObjNo shr 16) and $FF;
    LKey[Level128N + 3] := AGenNo and $FF;
    LKey[Level128N + 4] := (AGenNo shr 8) and $FF;
  end
  else
  begin
    Move(FFileKey[0], LKey[0], Level40N);
    LKey[Level40N] := (AObjNo and $FF);
    LKey[Level40N + 1] := (AObjNo shr 8) and $FF;
    LKey[Level40N + 2] := (AObjNo shr 16) and $FF;
    LKey[Level40N + 3] := AGenNo and $FF;
    LKey[Level40N + 4] := (AGenNo shr 8) and $FF;
  end;

  TgtCryptStream.MD5Init(LMD5Data);
  if Level = el128bit then
    TgtCryptStream.MD5Update(LMD5Data, LKey, Level128N + 5)
  else
    TgtCryptStream.MD5Update(LMD5Data, LKey, Level40N + 5);
  TgtCryptStream.MD5Final(LMD5Data, LMD5Digest);

  if Level = el128bit then
  begin
    Move(LMD5Digest, LMD5Output, SizeOf(LMD5Output));
    TgtCryptStream.RC4Init(LRC4Data, LMD5Output, SizeOf(LMD5Output));
  end
  else
  begin
    Move(LMD5Digest, LMD5Output, Level40N + 5);
    TgtCryptStream.RC4Init(LRC4Data, LMD5Output, Level40N + 5);
  end;

  SetLength(LInputBuff, ADataSize);
  SetLength(EncryptedStream, ADataSize);

  AStream.Read(LInputBuff, ADataSize);
  TgtCryptStream.RC4Crypt(LRC4Data, LInputBuff, EncryptedStream, ADataSize);

  for LI := 1 to Length(EncryptedStream) do
    LResultStrm := LResultStrm + AnsiChar(EncryptedStream[LI - 1]);

  AOutStream.Write(EncryptedStream, Length(EncryptedStream));

  SetLength(EncryptedStream, 0);
  SetLength(LInputBuff, 0);
end;

procedure TgtDecrypt.DecryptString(const ASrc: AnsiString; var ADest: AnsiString; ADataSize, AObjNo,
  AGenNo: Integer);
var
  LKey: array[0..20] of Byte;
  LMD5Output: array[0..15] of Byte;
  LMD5Data: TgtMD5Context;
  LMD5Digest: MD5Digest;
  LInputBuff: Bytes;
  LOutputBuff: Bytes;

  LRC4Data: TgtRC4Data;
  LI: Integer;
begin
  if Level = el128bit then
  begin
    Move(FFileKey[0], LKey[0], Level128N);
    LKey[Level128N] := (AObjNo and $FF);
    LKey[Level128N + 1] := (AObjNo shr 8) and $FF;
    LKey[Level128N + 2] := (AObjNo shr 16) and $FF;
    LKey[Level128N + 3] := AGenNo and $FF;
    LKey[Level128N + 4] := (AGenNo shr 8) and $FF;
  end
  else
  begin
    Move(FFileKey[0], LKey[0], Level40N);
    LKey[Level40N] := (AObjNo and $FF);
    LKey[Level40N + 1] := (AObjNo shr 8) and $FF;
    LKey[Level40N + 2] := (AObjNo shr 16) and $FF;
    LKey[Level40N + 3] := AGenNo and $FF;
    LKey[Level40N + 4] := (AGenNo shr 8) and $FF;
  end;

  TgtCryptStream.MD5Init(LMD5Data);
  if Level = el128bit then
    TgtCryptStream.MD5Update(LMD5Data, LKey, Level128N + 5)
  else
    TgtCryptStream.MD5Update(LMD5Data, LKey, Level40N + 5);
  TgtCryptStream.MD5Final(LMD5Data, LMD5Digest);

  if Level = el128bit then
  begin
    Move(LMD5Digest, LMD5Output, SizeOf(LMD5Output));
    TgtCryptStream.RC4Init(LRC4Data, LMD5Output, SizeOf(LMD5Output));
  end
  else
  begin
    Move(LMD5Digest, LMD5Output, Level40N + 5);
    TgtCryptStream.RC4Init(LRC4Data, LMD5Output, Level40N + 5);
  end;

  SetLength(LInputBuff, Length(ASrc));
  SetLength(LOutputBuff, Length(ASrc));

  for LI := 0 to Length(ASrc) - 1 do
    LInputBuff[LI] := Ord(ASrc[LI + 1]);

  TgtCryptStream.RC4Crypt(LRC4Data, LInputBuff, LOutputBuff, ADataSize);

  for LI := 1 to Length(LOutputBuff) do
  begin
    {if (LOutputBuff[LI - 1] <> 0) and (LOutputBuff[LI - 1] <> 255)
      and (LOutputBuff[LI - 1] <> 254) then}
    ADest := ADest + AnsiChar(LOutputBuff[LI - 1]);
  end;

  SetLength(LInputBuff, 0);
  SetLength(LOutputBuff, 0);
end;

destructor TgtDecrypt.Destroy;
begin

  inherited;
end;

function TgtDecrypt.GetChar: Integer;
begin
  Result := ENDOFFILE;
  if FPos < Length(FBuffer) then
    Result := Ord(FBuffer[FPos + 1]);
  Inc(FPos);
end;

function TgtDecrypt.IsHex(const Value: AnsiString): Boolean;
begin
  Result := False;
  if (Value[1] = '<') and (Value[Length(Value)] = '>') then
    Result := True;
end;

function TgtDecrypt.LookChar: Integer;
begin
  Result := ENDOFFILE;
  if FPos < Length(FBuffer) then
    Result := Ord(FBuffer[FPos + 1]);
end;

procedure TgtDecrypt.Reset;
var
  LChar: Integer;
  LEncryptedStr: AnsiString;
begin
  LEncryptedStr := '';
  if (FStream <> nil) then
  begin
    FStream.Reset;
    FPos := 0;
    LChar := FStream.GetChar;
    while (LChar <> ENDOFFILE) do
    begin
      LEncryptedStr := LEncryptedStr + AnsiChar(LChar);
      LChar := FStream.GetChar;
    end;
  end
  else
    LEncryptedStr := FString;

  DecryptString(LEncryptedStr, FBuffer, Length(LEncryptedStr), FObjNum, FGenNum);
end;

procedure TgtDecrypt.SetFileID(const Value: AnsiString);
var
  lstr: AnsiString;
begin
  if Value = '' then
    Exit;

  if (not IsHex(Value)) and (Length(Value) < 32) then
    lstr :=GetHexOfStr(Value, Length(Value))
  else
    lstr := Value;

  if Length(lstr) = 32 then
    FFileID := HexToByteArray(lstr)
  else
    raise ExInvalidFileID.Create(ErrInvalidFileID);
end;

procedure TgtDecrypt.SetLevel(const Value: TgtPDFEncryptionLevel);
begin
  FLevel := Value;
end;

procedure TgtDecrypt.SetOwnerKey(const Value: AnsiString);
var
  LOwnerKey, LChar: AnsiString;
  LByteArray: Bytes;
  LI, LLength: Integer;
begin
  SetLength(LByteArray, 0);
  if Value <> '' then
  begin
//  if Value = '' then
//  begin
//    raise ExInvalidOwnerKey.Create(ErrInvalidOwnerKey);
//    Exit;
//  end;
    LOwnerKey := Copy(Value, 2, Length(Value) - 2);
    if IsHex(Value) then
    begin
      LByteArray := HexToByteArray(LOwnerKey);
      for LI := 0 to Length(LByteArray) - 1 do
        FOwnerKey[LI] := LByteArray[LI];
    end
    else
    begin
      LLength := Length(LOwnerKey);
      if (LLength <> 0) then
      begin
        LI := 1;
        repeat
          LChar := LOwnerKey[LI];
          FOwnerKey[LI - 1] := Ord(LChar[1]);
          Inc(LI);
        until (LI > LLength);
      end;
    end;
  end;
  SetLength(LByteArray, 0);
end;

procedure TgtDecrypt.SetPermissions(const Value: Int64);
var
  I: Int64;
begin
  if (Value < 0) or (Value <= High(Word)) then
    I := Value
  else
    I := LongInt(Value);

  FPermissions[0] := I and $FF;
  FPermissions[1] := (I shr 8) and $FF;
  if (Value < 0) or (Value > High(Word)) then
  begin
    FPermissions[2] := $FF;
    FPermissions[3] := $FF;
  end
  else
  begin
    FPermissions[2] := $00;
    FPermissions[3] := $00;
  end;
end;

procedure TgtDecrypt.SetUserKey(const Value: AnsiString);
var
  LUserKey, LChar: AnsiString;
  LByteArray: Bytes;
  LI, LLength: Integer;
begin
  SetLength(LByteArray, 0);
  if Value <> '' then
  begin
//  if Value = '' then
//  begin
//    raise ExInvalidUserKey.Create(ErrInvalidUserKey);
//    Exit;
//  end;
    LUserKey := Copy(Value, 2, Length(Value) - 2);
    if IsHex(Value) then
    begin
      LByteArray := HexToByteArray(LUserKey);
      for LI := 0 to Length(LByteArray) - 1 do
        FUserKey[LI] := LByteArray[LI];
    end
    else
    begin
      LLength := Length(LUserKey);
      if (LLength <> 0) then
      begin
        LI := 1;
        repeat
          LChar := LUserKey[LI];
          FUserKey[LI - 1] := Ord(LChar[1]);
          Inc(LI);
        until (LI > LLength);
      end;
    end;
  end;
  SetLength(LByteArray, 0);
end;

procedure TgtDecrypt.SetUserPermissions;
begin
  if FPermissions[0] and 4 = 0 then
    FUserPermissions := FUserPermissions - [AllowPrint];
  if FPermissions[0] and 8 = 0 then
    FUserPermissions := FUserPermissions - [AllowModify];
  if FPermissions[0] and 16 = 0 then
    FUserPermissions := FUserPermissions - [AllowCopy];
  if FPermissions[0] and 32 = 0 then
    FUserPermissions := FUserPermissions - [AllowAnnotation];
  if FLevel = el128bit then
  begin
    if FPermissions[1] and 1 = 0 then
      FUserPermissions := FUserPermissions - [AllowFormFill];
    if FPermissions[1] and 2 = 0 then
      FUserPermissions := FUserPermissions - [AllowAccessibility];
    if FPermissions[1] and 4 = 0 then
      FUserPermissions := FUserPermissions - [AllowDocAssembly];
    if FPermissions[1] and 8 = 0 then
      FUserPermissions := FUserPermissions - [AllowHighResPrint];
  end;
end;

end.
