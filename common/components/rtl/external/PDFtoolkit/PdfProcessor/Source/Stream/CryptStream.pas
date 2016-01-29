{ ********************************************************************* }
{                                                                       }
{                           Gnostice Streams                            }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

unit CryptStream;

interface

uses
  Stream, FilterStream, gtTypes, EncryptionSettings;

type

  MD5Count = array[0..1] of LongWord;
  MD5State = array[0..3] of LongWord;
  MD5Block = array[0..15] of LongWord;
  MD5Digest = array[0..15] of Byte;
  MD5Buffer = array[0..63] of Byte;
  MD5CBits = array[0..7] of Byte;
  TgtPadding = array[0..31] of Byte;

  TgtRC4Data = record
    Key: array[0..255] of byte; { current key }
    OrgKey: array[0..255] of byte; { original key }
  end;

  TgtMD5Context = record
    State: MD5State;
    Count: MD5Count;
    Buffer: MD5Buffer;
  end;

const
  MAXPASSWORDLENGTH = 32;
  LEVEL40N = 5;
  LEVEL128N = 16;
  EncryptLength: array[TgtPDFEncryptionLevel] of Integer = (5, 16);

  TgtSBox: array[0..255] of Byte = (
    $63, $7C, $77, $7B, $F2, $6B, $6F, $C5, $30, $01, $67, $2B, $FE, $D7, $AB, $76,
    $CA, $82, $C9, $7D, $FA, $59, $47, $F0, $AD, $D4, $A2, $AF, $9C, $A4, $72, $C0,
    $B7, $FD, $93, $26, $36, $3F, $F7, $CC, $34, $A5, $E5, $F1, $71, $D8, $31, $15,
    $04, $C7, $23, $C3, $18, $96, $05, $9A, $07, $12, $80, $E2, $EB, $27, $B2, $75,
    $09, $83, $2C, $1A, $1B, $6E, $5A, $A0, $52, $3B, $D6, $B3, $29, $E3, $2F, $84,
    $53, $D1, $00, $ED, $20, $FC, $B1, $5B, $6A, $CB, $BE, $39, $4A, $4C, $58, $CF,
    $D0, $EF, $AA, $FB, $43, $4D, $33, $85, $45, $F9, $02, $7F, $50, $3C, $9F, $A8,
    $51, $A3, $40, $8F, $92, $9D, $38, $F5, $BC, $B6, $DA, $21, $10, $FF, $F3, $D2,
    $CD, $0C, $13, $EC, $5F, $97, $44, $17, $C4, $A7, $7E, $3D, $64, $5D, $19, $73,
    $60, $81, $4F, $DC, $22, $2A, $90, $88, $46, $EE, $B8, $14, $DE, $5E, $0B, $DB,
    $E0, $32, $3A, $0A, $49, $06, $24, $5C, $C2, $D3, $AC, $62, $91, $95, $E4, $79,
    $E7, $C8, $37, $6D, $8D, $D5, $4E, $A9, $6C, $56, $F4, $EA, $65, $7A, $AE, $08,
    $BA, $78, $25, $2E, $1C, $A6, $B4, $C6, $E8, $DD, $74, $1F, $4B, $BD, $8B, $8A,
    $70, $3E, $B5, $66, $48, $03, $F6, $0E, $61, $35, $57, $B9, $86, $C1, $1D, $9E,
    $E1, $F8, $98, $11, $69, $D9, $8E, $94, $9B, $1E, $87, $E9, $CE, $55, $28, $DF,
    $8C, $A1, $89, $0D, $BF, $E6, $42, $68, $41, $99, $2D, $0F, $B0, $54, $BB, $16
    );

  TgtInvSbox: array[0..255] of Byte = (
    $52, $09, $6A, $D5, $30, $36, $A5, $38, $BF, $40, $A3, $9E, $81, $F3, $D7, $FB,
    $7C, $E3, $39, $82, $9B, $2F, $FF, $87, $34, $8E, $43, $44, $C4, $DE, $E9, $CB,
    $54, $7B, $94, $32, $A6, $C2, $23, $3D, $EE, $4C, $95, $0B, $42, $FA, $C3, $4E,
    $08, $2E, $A1, $66, $28, $D9, $24, $B2, $76, $5B, $A2, $49, $6D, $8B, $D1, $25,
    $72, $F8, $F6, $64, $86, $68, $98, $16, $D4, $A4, $5C, $CC, $5D, $65, $B6, $92,
    $6C, $70, $48, $50, $FD, $ED, $B9, $DA, $5E, $15, $46, $57, $A7, $8D, $9D, $84,
    $90, $D8, $AB, $00, $8C, $BC, $D3, $0A, $F7, $E4, $58, $05, $B8, $B3, $45, $06,
    $D0, $2C, $1E, $8F, $CA, $3F, $0F, $02, $C1, $AF, $BD, $03, $01, $13, $8A, $6B,
    $3A, $91, $11, $41, $4F, $67, $DC, $EA, $97, $F2, $CF, $CE, $F0, $B4, $E6, $73,
    $96, $AC, $74, $22, $E7, $AD, $35, $85, $E2, $F9, $37, $E8, $1C, $75, $DF, $6E,
    $47, $F1, $1A, $71, $1D, $29, $C5, $89, $6F, $B7, $62, $0E, $AA, $18, $BE, $1B,
    $FC, $56, $3E, $4B, $C6, $D2, $79, $20, $9A, $DB, $C0, $FE, $78, $CD, $5A, $F4,
    $1F, $DD, $A8, $33, $88, $07, $C7, $31, $B1, $12, $10, $59, $27, $80, $EC, $5F,
    $60, $51, $7F, $A9, $19, $B5, $4A, $0D, $2D, $E5, $7A, $9F, $93, $C9, $9C, $EF,
    $A0, $E0, $3B, $4D, $AE, $2A, $F5, $B0, $C8, $EB, $BB, $3C, $83, $53, $99, $61,
    $17, $2B, $04, $7E, $BA, $77, $D6, $26, $E1, $69, $14, $63, $55, $21, $0C, $7D
    );

  TgtRcon: array[0..10] of double = (
    $00000000, // unused
    $01000000,
    $02000000,
    $04000000,
    $08000000,
    $10000000,
    $20000000,
    $40000000,
    $80000000,
    $1B000000,
    $36000000
    );

type
  TgtCryptStream = class(TgtFilterStream)
  private
  public
    constructor Create(AStream: TgtStream; ACreateDate: AnsiString; AEncryptSetings: TgtEncryptionSettings;
      AEncryptAlg: TgtCryptAlgorithm; AKeyLength, AObjNum, AGenNum: Integer); overload;
    constructor Create(AString: AnsiString; AFileKey: AnsiString; AEncryptSetings: TgtEncryptionSettings;
      AEncryptAlg: TgtCryptAlgorithm; AKeyLength, AObjNum, AGenNum: Integer); overload;

    destructor Destroy; override;

    class procedure CopyValue(var ToArray: array of Byte;
      FromArray: array of Byte; ToIndex, FromIndex: Integer; ALength: Integer);
    class procedure MD5Init(var AContext: TgtMD5Context);
    class procedure MD5Final(var AContext: TgtMD5Context; var ADigest: MD5Digest);
    class procedure MD5Update(var AContext: TgtMD5Context; AInput: array of Byte;
      ALength: Longword);
    class procedure RC4Init(var AData: TgtRC4Data; var AKey: array of byte; ALen: Integer);
    class procedure RC4Crypt(var AData: TgtRC4Data; const AInData: array of byte; var AOutData: array of byte;
      ALen: Integer);
    class procedure PasswordPadding(const AStr: AnsiString; var ADest: array of Byte);
    class procedure Transform(var ABuffer: array of byte; var AState: MD5State);
    class function Rot(AX: LongWord; AN: LongWord): LongWord;

    function GetSize: Cardinal; override;
    function GetType: TgtStreamType; override;
  end;

var
  Padding: TgtPadding = (
    $28, $BF, $4E, $5E, $4E, $75, $8A, $41,
    $64, $00, $4E, $56, $FF, $FA, $01, $08,
    $2E, $2E, $00, $B6, $D0, $68, $3E, $80,
    $2F, $0C, $A9, $FE, $64, $53, $69, $7A
    );

implementation

uses
  Encrypt, Decrypt, StreamExceptions, gtLogger, gtMethods;
var
  BufferPad: MD5Buffer = (
    $80, $00, $00, $00, $00, $00, $00, $00,
    $00, $00, $00, $00, $00, $00, $00, $00,
    $00, $00, $00, $00, $00, $00, $00, $00,
    $00, $00, $00, $00, $00, $00, $00, $00,
    $00, $00, $00, $00, $00, $00, $00, $00,
    $00, $00, $00, $00, $00, $00, $00, $00,
    $00, $00, $00, $00, $00, $00, $00, $00,
    $00, $00, $00, $00, $00, $00, $00, $00
    );

{ TgtCryptStream }

constructor TgtCryptStream.Create(AStream: TgtStream; ACreateDate: AnsiString; AEncryptSetings: TgtEncryptionSettings;
  AEncryptAlg: TgtCryptAlgorithm; AKeyLength, AObjNum, AGenNum: Integer);
begin
  FRef := 1;
  FStream := AStream;
  FDecoder := TgtDecrypt.Create(AStream, ACreateDate, AEncryptSetings, AEncryptAlg, AKeyLength,
    AObjNum, AGenNum);
  FEncoder := TgtEncrypt.Create(AStream, ACreateDate, AEncryptSetings, AEncryptAlg, AKeyLength,
    AObjNum, AGenNum);
end;

class procedure TgtCryptStream.CopyValue(var ToArray: array of Byte;
  FromArray: array of Byte; ToIndex, FromIndex: Integer; ALength: Integer);
var
  LI: Integer;
begin
  for LI := ToIndex to (ToIndex + ALength) - 1 do
  begin
    ToArray[LI] := FromArray[FromIndex];
    Inc(FromIndex);
  end;
end;

constructor TgtCryptStream.Create(AString, AFileKey: AnsiString; AEncryptSetings: TgtEncryptionSettings;
  AEncryptAlg: TgtCryptAlgorithm; AKeyLength, AObjNum, AGenNum: Integer);
begin
  FDecoder := TgtDecrypt.Create(AString, AFileKey, AEncryptSetings, AEncryptAlg, AKeyLength,
    AObjNum, AGenNum);
  FEncoder := TgtEncrypt.Create(AString, AFileKey, AEncryptSetings, AEncryptAlg, AKeyLength,
    AObjNum, AGenNum);
end;

destructor TgtCryptStream.Destroy;
begin
  if Assigned(FEncoder) then
    FreeObject(FEncoder);
  if Assigned(FDecoder) then
    FreeObject(FDecoder);

  inherited;
end;

function TgtCryptStream.GetSize: Cardinal;
begin
{$IFDEF DEBUG}
  Logger.LogError('Get size cannot be called on CryptStream');
{$ENDIF}
  Result := 0;
end;

function TgtCryptStream.GetType: TgtStreamType;
begin
  Result := stCrypt; ;
end;

class procedure TgtCryptStream.MD5Final(var AContext: TgtMD5Context;
  var ADigest: MD5Digest);
var
  Bits: MD5CBits;
  Index: Longword;
  PadLen: Longword;
begin
 //Decode(@AContext.Count, @Bits, 2);
  Move(AContext.Count, Bits, Sizeof(Bits));
  Index := (AContext.Count[0] shr 3) and $3F;
  if Index < 56 then
    PadLen := 56 - Index
  else
    PadLen := 120 - Index;
  MD5Update(AContext, BufferPad, PadLen);
  MD5Update(AContext, Bits, 8);
 //Decode(@AContext.State, @ADigest, 4);
  Move(AContext.State, ADigest, Sizeof(ADigest));
  FillChar(AContext, SizeOf(TgtMD5Context), 0);
end;

class procedure TgtCryptStream.MD5Init(var AContext: TgtMD5Context);
var
  LI: Integer;
begin
  with AContext do begin
    State[0] := $67452301;
    State[1] := $EFCDAB89;
    State[2] := $98BADCFE;
    State[3] := $10325476;
    Count[0] := 0;
    Count[1] := 0;
    for LI := 0 to 63 do
      Buffer[LI] := 0;
  end;
end;

class procedure TgtCryptStream.MD5Update(var AContext: TgtMD5Context;
  AInput: array of Byte; ALength: Longword);
var
  Index: Longword;
  PartLen: Longword;
  I: Longword;
begin
  with AContext do begin
    Index := (Count[0] shr 3) and $3F;
    Inc(Count[0], ALength shl 3);
    if Count[0] < (ALength shl 3) then
      Inc(Count[1]);
    Inc(Count[1], ALength shr 29);
  end;
  PartLen := 64 - Index;
  if ALength >= PartLen then
  begin
    CopyValue(AContext.Buffer, AInput, Index, 0, PartLen);
    Transform(AContext.Buffer[0], AContext.State);
    I := PartLen;
    while I + 63 < ALength do
    begin
      Transform(AInput[I], AContext.State);
      Inc(I, 64);
    end;
    Index := 0;
  end
  else
    I := 0;
  CopyValue(AContext.Buffer, AInput, Index, I, ALength - I);
end;

class procedure TgtCryptStream.PasswordPadding(const AStr: AnsiString;
  var ADest: array of Byte);
var
  Len: Integer;
begin
{$R-}
  Len := Length(AStr);
  if Len > MAXPASSWORDLENGTH then
    Len := MAXPASSWORDLENGTH;
  Move(AStr[1], ADest[Low(ADest)], Len);
  Move(Padding, ADest[Low(ADest) + Len], MAXPASSWORDLENGTH - Len);
end;

class procedure TgtCryptStream.RC4Crypt(var AData: TgtRC4Data; const AInData: array of byte;
  var AOutData: array of byte; ALen: Integer);
var
  T, I, J: byte;
  K: integer;
begin
  I := 0;
  J := 0;
  for K := 0 to ALen - 1 do
  begin
    I := (I + 1) and $FF;
    J := (J + AData.Key[I]) and $FF;
    T := AData.Key[I];
    AData.Key[I] := AData.Key[J];
    AData.Key[J] := T;
    T := (AData.Key[I] + AData.Key[J]) and $FF;
    AOutData[K] := AInData[K] xor AData.Key[T];
  end;
end;

class procedure TgtCryptStream.RC4Init(var AData: TgtRC4Data; var AKey: array of byte; ALen: Integer);
var
  XKey: array[0..255] of byte;
  I, J: integer;
  T: byte;
  LI: Integer;
begin
  for LI := 0 to 255 do
    XKey[LI] := 0;

  if (ALen <= 0) or (ALen > 256) then
    raise ExInvalidKeyLen.Create(ErrInvalidKeyLen);
  for I := 0 to 255 do
  begin
    AData.Key[I] := I;
    XKey[I] := AKey[I mod ALen];
  end;
  J := 0;
  for I := 0 to 255 do
  begin
    J := (J + AData.Key[I] + XKey[I]) and $FF;
    T := AData.Key[I];
    AData.Key[I] := AData.Key[J];
    AData.Key[J] := T;
  end;
  Move(AData.Key, AData.OrgKey, 256);
end;

class function TgtCryptStream.Rot(AX: LongWord; AN: LongWord): LongWord;
begin
{$OVERFLOWCHECKS Off}
  Result := (AX shl AN) or (AX shr (32 - AN));
end;

class procedure TgtCryptStream.Transform(var ABuffer: array of byte;
  var AState: MD5State);
var
  A, B, C, D: LongWord;
  Block: MD5Block;
begin
{$OVERFLOWCHECKS Off}
  Move(ABuffer, Block, Sizeof(Block));
  A := Astate[0];
  B := Astate[1];
  C := Astate[2];
  D := Astate[3];

  A := B + Rot(A + (D xor (B and (C xor D))) + Block[0] + $D76AA478, 7);
  D := A + Rot(D + (C xor (A and (B xor C))) + Block[1] + $E8C7B756, 12);
  C := D + Rot(C + (B xor (D and (A xor B))) + Block[2] + $242070DB, 17);
  B := C + Rot(B + (A xor (C and (D xor A))) + Block[3] + $C1BDCEEE, 22);
  A := B + Rot(A + (D xor (B and (C xor D))) + Block[4] + $F57C0FAF, 7);
  D := A + Rot(D + (C xor (A and (B xor C))) + Block[5] + $4787C62A, 12);
  C := D + Rot(C + (B xor (D and (A xor B))) + Block[6] + $A8304613, 17);
  B := C + Rot(B + (A xor (C and (D xor A))) + Block[7] + $FD469501, 22);
  A := B + Rot(A + (D xor (B and (C xor D))) + Block[8] + $698098D8, 7);
  D := A + Rot(D + (C xor (A and (B xor C))) + Block[9] + $8B44F7AF, 12);
  C := D + Rot(C + (B xor (D and (A xor B))) + Block[10] + $FFFF5BB1, 17);
  B := C + Rot(B + (A xor (C and (D xor A))) + Block[11] + $895CD7BE, 22);
  A := B + Rot(A + (D xor (B and (C xor D))) + Block[12] + $6B901122, 7);
  D := A + Rot(D + (C xor (A and (B xor C))) + Block[13] + $FD987193, 12);
  C := D + Rot(C + (B xor (D and (A xor B))) + Block[14] + $A679438E, 17);
  B := C + Rot(B + (A xor (C and (D xor A))) + Block[15] + $49B40821, 22);

  A := B + Rot(A + (C xor (D and (B xor C))) + Block[1] + $F61E2562, 5);
  D := A + Rot(D + (B xor (C and (A xor B))) + Block[6] + $C040B340, 9);
  C := D + Rot(C + (A xor (B and (D xor A))) + Block[11] + $265E5A51, 14);
  B := C + Rot(B + (D xor (A and (C xor D))) + Block[0] + $E9B6C7AA, 20);
  A := B + Rot(A + (C xor (D and (B xor C))) + Block[5] + $D62F105D, 5);
  D := A + Rot(D + (B xor (C and (A xor B))) + Block[10] + $02441453, 9);
  C := D + Rot(C + (A xor (B and (D xor A))) + Block[15] + $D8A1E681, 14);
  B := C + Rot(B + (D xor (A and (C xor D))) + Block[4] + $E7D3FBC8, 20);
  A := B + Rot(A + (C xor (D and (B xor C))) + Block[9] + $21E1CDE6, 5);
  D := A + Rot(D + (B xor (C and (A xor B))) + Block[14] + $C33707D6, 9);
  C := D + Rot(C + (A xor (B and (D xor A))) + Block[3] + $F4D50D87, 14);
  B := C + Rot(B + (D xor (A and (C xor D))) + Block[8] + $455A14ED, 20);
  A := B + Rot(A + (C xor (D and (B xor C))) + Block[13] + $A9E3E905, 5);
  D := A + Rot(D + (B xor (C and (A xor B))) + Block[2] + $FCEFA3F8, 9);
  C := D + Rot(C + (A xor (B and (D xor A))) + Block[7] + $676F02D9, 14);
  B := C + Rot(B + (D xor (A and (C xor D))) + Block[12] + $8D2A4C8A, 20);

  A := B + Rot(A + (B xor C xor D) + Block[5] + $FFFA3942, 4);
  D := A + Rot(D + (A xor B xor C) + Block[8] + $8771F681, 11);
  C := D + Rot(C + (D xor A xor B) + Block[11] + $6D9D6122, 16);
  B := C + Rot(B + (C xor D xor A) + Block[14] + $FDE5380C, 23);
  A := B + Rot(A + (B xor C xor D) + Block[1] + $A4BEEA44, 4);
  D := A + Rot(D + (A xor B xor C) + Block[4] + $4BDECFA9, 11);
  C := D + Rot(C + (D xor A xor B) + Block[7] + $F6BB4B60, 16);
  B := C + Rot(B + (C xor D xor A) + Block[10] + $BEBFBC70, 23);
  A := B + Rot(A + (B xor C xor D) + Block[13] + $289B7EC6, 4);
  D := A + Rot(D + (A xor B xor C) + Block[0] + $EAA127FA, 11);
  C := D + Rot(C + (D xor A xor B) + Block[3] + $D4EF3085, 16);
  B := C + Rot(B + (C xor D xor A) + Block[6] + $04881D05, 23);
  A := B + Rot(A + (B xor C xor D) + Block[9] + $D9D4D039, 4);
  D := A + Rot(D + (A xor B xor C) + Block[12] + $E6DB99E5, 11);
  C := D + Rot(C + (D xor A xor B) + Block[15] + $1FA27CF8, 16);
  B := C + Rot(B + (C xor D xor A) + Block[2] + $C4AC5665, 23);

  A := B + Rot(A + (C xor (B or (not D))) + Block[0] + $F4292244, 6);
  D := A + Rot(D + (B xor (A or (not C))) + Block[7] + $432AFF97, 10);
  C := D + Rot(C + (A xor (D or (not B))) + Block[14] + $AB9423A7, 15);
  B := C + Rot(B + (D xor (C or (not A))) + Block[5] + $FC93A039, 21);
  A := B + Rot(A + (C xor (B or (not D))) + Block[12] + $655B59C3, 6);
  D := A + Rot(D + (B xor (A or (not C))) + Block[3] + $8F0CCC92, 10);
  C := D + Rot(C + (A xor (D or (not B))) + Block[10] + $FFEFF47D, 15);
  B := C + Rot(B + (D xor (C or (not A))) + Block[1] + $85845DD1, 21);
  A := B + Rot(A + (C xor (B or (not D))) + Block[8] + $6FA87E4F, 6);
  D := A + Rot(D + (B xor (A or (not C))) + Block[15] + $FE2CE6E0, 10);
  C := D + Rot(C + (A xor (D or (not B))) + Block[6] + $A3014314, 15);
  B := C + Rot(B + (D xor (C or (not A))) + Block[13] + $4E0811A1, 21);
  A := B + Rot(A + (C xor (B or (not D))) + Block[4] + $F7537E82, 6);
  D := A + Rot(D + (B xor (A or (not C))) + Block[11] + $BD3AF235, 10);
  C := D + Rot(C + (A xor (D or (not B))) + Block[2] + $2AD7D2BB, 15);
  B := C + Rot(B + (D xor (C or (not A))) + Block[9] + $EB86D391, 21);

  Inc(Astate[0], A);
  Inc(Astate[1], B);
  Inc(Astate[2], C);
  Inc(Astate[3], D);
end;

end.
