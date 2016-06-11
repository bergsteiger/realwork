{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit System.Hash;

interface

uses
  System.SysUtils;

type
  /// <summary> Hash related Exceptions </summary>
  EHashException = class(Exception);

  /// <summary> Record with common functionality to all Hash functions</summary>
  THash = record
    /// <summary>Convert a Digest into an Integer if it's length its four</summary>
    class function DigestAsInteger(const ADigest: TBytes): Integer; static;
    /// <summary>Convert a Digest into a hexadecimal value string</summary>
    class function DigestAsString(const ADigest: TBytes): string; static;
    /// <summary>Convert a Digest into a GUID if it's length its sixteen</summary>
    class function DigestAsStringGUID(const ADigest: TBytes): string; static;
    /// <summary> Gets a random string with the given length</summary>
    class function GetRandomString(const ALen: Integer = 10): string; static;
    /// <summary> Gets the BigEndian memory representation of a cardinal value</summary>
    class function ToBigEndian(AValue: Cardinal): Cardinal; overload; static; inline;
    /// <summary> Gets the BigEndian memory representation of a UInt64 value</summary>
    class function ToBigEndian(AValue: UInt64): UInt64; overload; static; inline;
  end;


  /// <summary> Record to generate MD5 Hash values from data. Stores internal state of the process</summary>
  THashMD5 = record
  private type
    TContextState = array [0..15] of Cardinal;
    TContextBuffer = array [0..63] of Byte;
  private
    FPadding: TContextBuffer;
    FContextState: array [0..3] of Cardinal;
    FContextCount: array [0..1] of Cardinal;
    FContextBuffer: TContextBuffer;
    FFinalized: Boolean;
    procedure Transform(const ABlock: PByte; AShift: Integer);
    procedure Decode(const Dst: PCardinal; const Src: PByte; Len: Integer; AShift: Integer);
    procedure Encode(const Dst: PByte; const Src: PCardinal; Len: Integer);
    procedure FinalizeHash;
    procedure Update(const AData: PByte; ALength: Cardinal); overload;

    function GetDigest: TBytes;
  public

    /// <summary> Creates an instance to generate MD5 hashes</summary>
    class function Create: THashMD5; static; inline;
    /// <summary> Puts the state machine of the generator in it's initial state.</summary>
    procedure Reset;
    /// <summary> Update the Hash with the provided bytes</summary>
    procedure Update(const AData; ALength: Cardinal); overload;
    procedure Update(const AData: TBytes; ALength: Cardinal = 0); overload; inline;
    procedure Update(const Input: string); overload; inline;

    /// <summary> Returns the BlockSize for this hash instance</summary>
    function GetBlockSize: Integer; inline;
    /// <summary> Returns the HashSize for this hash instance</summary>
    function GetHashSize: Integer; inline;

    /// <summary> Returns the hash value as a TBytes</summary>
    function HashAsBytes: TBytes; inline;
    /// <summary> Returns the hash value as string</summary>
    function HashAsString: string; inline;

    /// <summary> Hash the given string and returns it's hash value as integer</summary>
    class function GetHashBytes(const AData: string): TBytes; static;
    /// <summary> Hash the given string and returns it's hash value as string</summary>
    class function GetHashString(const AString: string): string; static;

    /// <summary>Gets the string associated to the HMAC authentication</summary>
    class function GetHMAC(const AData, AKey: string): string; static; inline;
    /// <summary>Gets the Digest associated to the HMAC authentication</summary>
    class function GetHMACAsBytes(const AData, AKey: string): TBytes; overload;  static;
    class function GetHMACAsBytes(const AData: string; const AKey: TBytes): TBytes; overload; static;
    class function GetHMACAsBytes(const AData: TBytes; const AKey: string): TBytes; overload; static;
    class function GetHMACAsBytes(const AData, AKey: TBytes): TBytes; overload; static;
  end;

  /// <summary> Record to generate SHA1 Hash values from data</summary>
  THashSHA1 = record
  private
    FHash: array[0..4] of Cardinal;
    FBitLength: Int64;
    FBuffer: array [0..63] of Byte;
    FIndex: Integer;
    FFinalized: Boolean;
    procedure Initialize;
    procedure CheckFinalized;
    procedure Compress;
    procedure Finalize;

    function GetDigest: TBytes;
    procedure Update(const AData: PByte; ALength: Cardinal); overload;
  public
    /// <summary>Initialize the Record used to calculate the SHA1 Hash</summary>
    class function Create: THashSHA1; static; inline;

    /// <summary> Puts the state machine of the generator in it's initial state.</summary>
    procedure Reset; inline;

    /// <summary> Update the Hash value with the given Data. </summary>
    procedure Update(const AData; ALength: Cardinal); overload;
    procedure Update(const AData: TBytes; ALength: Cardinal = 0); overload; inline;
    procedure Update(const Input: string); overload; inline;

    /// <summary> Returns the BlockSize for this hash instance</summary>
    function GetBlockSize: Integer; inline;
    /// <summary> Returns the HashSize for this hash instance</summary>
    function GetHashSize: Integer; inline;

    /// <summary> Returns the hash value as a TBytes</summary>
    function HashAsBytes: TBytes; inline;
    /// <summary> Returns the hash value as string</summary>
    function HashAsString: string; inline;

    /// <summary> Hash the given string and returns it's hash value as integer</summary>
    class function GetHashBytes(const AData: string): TBytes; static;
    /// <summary> Hash the given string and returns it's hash value as string</summary>
    class function GetHashString(const AString: string): string; static;

    /// <summary>Gets the string associated to the HMAC authentication</summary>
    class function GetHMAC(const AData, AKey: string): string; static; inline;
    /// <summary>Gets the Digest associated to the HMAC authentication</summary>
    class function GetHMACAsBytes(const AData, AKey: string): TBytes; overload;  static;
    class function GetHMACAsBytes(const AData: string; const AKey: TBytes): TBytes; overload; static;
    class function GetHMACAsBytes(const AData: TBytes; const AKey: string): TBytes; overload; static;
    class function GetHMACAsBytes(const AData, AKey: TBytes): TBytes; overload; static;
  end;

  /// <summary> Record to generate SHA2 Hash values from data</summary>
  THashSHA2 = record
  public type
    TSHA2Version = (SHA224, SHA256, SHA384, SHA512, SHA512_224, SHA512_256);
  private const
    CBuffer32Length = 64;
    CBuffer64Length = 128;
  private
    FBuffer: array [0..127] of Byte;
    FBitLength: UInt64;
    FIndex: Cardinal;
    FFinalized: Boolean;

    procedure Initialize(AVersion: TSHA2Version);
    procedure CheckFinalized; inline;
    procedure Compress; inline;
    procedure Compress32;
    procedure Compress64;
    procedure Finalize; inline;
    procedure Finalize32;
    procedure Finalize64;

    function GetDigest: TBytes;
    procedure Update(const AData: PByte; ALength: Cardinal); overload;
  public
    /// <summary>Initialize the Record used to calculate the SHA2 Hash</summary>
    class function Create(AHashVersion: TSHA2Version = TSHA2Version.SHA256): THashSHA2; static; inline;

    /// <summary> Puts the state machine of the generator in it's initial state.</summary>
    procedure Reset; inline;

    /// <summary> Update the Hash value with the given Data. </summary>
    procedure Update(const AData; ALength: Cardinal); overload;
    procedure Update(const AData: TBytes; ALength: Cardinal = 0); overload; inline;
    procedure Update(const Input: string); overload; inline;

    /// <summary> Returns the BlockSize for this hash instance</summary>
    function GetBlockSize: Integer; inline;
    /// <summary> Returns the HashSize for this hash instance</summary>
    function GetHashSize: Integer; inline;

    /// <summary> Returns the hash value as a TBytes</summary>
    function HashAsBytes: TBytes; inline;
    /// <summary> Returns the hash value as string</summary>
    function HashAsString: string; inline;

    /// <summary> Hash the given string and returns it's hash value as integer</summary>
    class function GetHashBytes(const AData: string; AHashVersion: TSHA2Version = TSHA2Version.SHA256): TBytes; static;
    /// <summary> Hash the given string and returns it's hash value as string</summary>
    class function GetHashString(const AString: string; AHashVersion: TSHA2Version = TSHA2Version.SHA256): string; static;

    /// <summary>Gets the string associated to the HMAC authentication</summary>
    class function GetHMAC(const AData, AKey: string; AHashVersion: TSHA2Version = TSHA2Version.SHA256): string; static; inline;
    /// <summary>Gets the Digest associated to the HMAC authentication</summary>
    class function GetHMACAsBytes(const AData, AKey: string; AHashVersion: TSHA2Version = TSHA2Version.SHA256): TBytes; overload;  static;
    class function GetHMACAsBytes(const AData: string; const AKey: TBytes; AHashVersion: TSHA2Version = TSHA2Version.SHA256): TBytes; overload; static;
    class function GetHMACAsBytes(const AData: TBytes; const AKey: string; AHashVersion: TSHA2Version = TSHA2Version.SHA256): TBytes; overload; static;
    class function GetHMACAsBytes(const AData, AKey: TBytes; AHashVersion: TSHA2Version = TSHA2Version.SHA256): TBytes; overload; static;

  private
  case FVersion: TSHA2Version of
    TSHA2Version.SHA224,
    TSHA2Version.SHA256: (FHash: array[0..7] of Cardinal);
    TSHA2Version.SHA384,
    TSHA2Version.SHA512,
    TSHA2Version.SHA512_224,
    TSHA2Version.SHA512_256: (FHash64: array[0..7] of UInt64);
  end;

  /// <summary> Record to generate BobJenkins Hash values from data. Stores internal state of the process</summary>
  THashBobJenkins = record
  private
    FHash: Integer;
    function GetDigest: TBytes;

    class function HashLittle(const Data; Len, InitVal: Integer): Integer; static;
  public
    /// <summary>Initialize the Record used to calculate the BobJenkins Hash</summary>
    class function Create: THashBobJenkins; static;

    /// <summary> Puts the state machine of the generator in it's initial state.</summary>
    procedure Reset(AInitialValue: Integer = 0);

    /// <summary> Update the Hash value with the given Data. </summary>
    procedure Update(const AData; ALength: Cardinal); overload; inline;
    procedure Update(const AData: TBytes; ALength: Cardinal = 0); overload; inline;
    procedure Update(const Input: string); overload; inline;

    /// <summary> Returns the hash value as a TBytes</summary>
    function HashAsBytes: TBytes;
    /// <summary> Returns the hash value as integer</summary>
    function HashAsInteger: Integer;
    /// <summary> Returns the hash value as string</summary>
    function HashAsString: string;

    /// <summary> Hash the given string and returns it's hash value as integer</summary>
    class function GetHashBytes(const AData: string): TBytes; static;
    /// <summary> Hash the given string and returns it's hash value as string</summary>
    class function GetHashString(const AString: string): string; static;
    /// <summary> Hash the given string and returns it's hash value as integer</summary>
    class function GetHashValue(const AData: string): Integer; overload; static; inline;
    /// <summary> Hash the given Data and returns it's hash value as integer</summary>
    class function GetHashValue(const AData; ALength: Integer; AInitialValue: Integer = 0): Integer; overload; static; inline;
  end;


implementation

uses
  System.Types,
  System.RTLConsts;


{ THashMD5 }

class function THashMD5.Create: THashMD5;
begin
  Result.Reset;
end;

procedure THashMD5.Reset;
begin
  FillChar(FPadding, 64, 0);
  FPadding[0] := $80;
  FContextCount[0] := 0;
  FContextCount[1] := 0;
  FContextState[0] := $67452301;
  FContextState[1] := $efcdab89;
  FContextState[2] := $98badcfe;
  FContextState[3] := $10325476;
  FillChar(FContextBuffer, 64, 0);
  FFinalized := False;
end;

procedure THashMD5.Transform(const ABlock: PByte; AShift: Integer);

  function F(x, y, z: Cardinal): Cardinal; inline;
  begin
    Result := (x and y) or ((not x) and z);
  end;

  function G(x, y, z: Cardinal): Cardinal; inline;
  begin
    Result := (x and z) or (y and (not z));
  end;

  function H(x, y, z: Cardinal): Cardinal; inline;
  begin
    Result := x xor y xor z;
  end;

  function I(x, y, z: Cardinal): Cardinal; inline;
  begin
    Result := y xor (x or (not z));
  end;

  procedure RL(var x: Cardinal; n: Byte); inline;
  begin
    x := (x shl n) or (x shr (32 - n));
  end;

  procedure FF(var a: Cardinal; b, c, d, x: Cardinal; s: Byte; ac: Cardinal);
  begin
    Inc(a, F(b, c, d) + x + ac);
    RL(a, s);
    Inc(a, b);
  end;

  procedure GG(var a: Cardinal; b, c, d, x: Cardinal; s: Byte; ac: Cardinal);
  begin
    Inc(a, G(b, c, d) + x + ac);
    RL(a, s);
    Inc(a, b);
  end;

  procedure HH(var a: Cardinal; b, c, d, x: Cardinal; s: Byte; ac: Cardinal);
  begin
    Inc(a, H(b, c, d) + x + ac);
    RL(a, s);
    Inc(a, b);
  end;

  procedure II(var a: Cardinal; b, c, d, x: Cardinal; s: Byte; ac: Cardinal);
  begin
    Inc(a, I(b, c, d) + x + ac);
    RL(a, s);
    Inc(a, b);
  end;

const
  S11 =  7;
  S12 = 12;
  S13 = 17;
  S14 = 22;

  S21 =  5;
  S22 =  9;
  S23 = 14;
  S24 = 20;

  S31 =  4;
  S32 = 11;
  S33 = 16;
  S34 = 23;

  S41 =  6;
  S42 = 10;
  S43 = 15;
  S44 = 21;

var
  a, b, c, d: Cardinal;
  x: TContextState;
begin
  a := FContextState[0];
  b := FContextState[1];
  c := FContextState[2];
  d := FContextState[3];

  Decode(PCardinal(@x[0]), ABlock, 64, AShift);

  { Round 1 }
  FF( a, b, c, d, x[ 0], S11, $d76aa478); { 1 }
  FF( d, a, b, c, x[ 1], S12, $e8c7b756); { 2 }
  FF( c, d, a, b, x[ 2], S13, $242070db); { 3 }
  FF( b, c, d, a, x[ 3], S14, $c1bdceee); { 4 }
  FF( a, b, c, d, x[ 4], S11, $f57c0faf); { 5 }
  FF( d, a, b, c, x[ 5], S12, $4787c62a); { 6 }
  FF( c, d, a, b, x[ 6], S13, $a8304613); { 7 }
  FF( b, c, d, a, x[ 7], S14, $fd469501); { 8 }
  FF( a, b, c, d, x[ 8], S11, $698098d8); { 9 }
  FF( d, a, b, c, x[ 9], S12, $8b44f7af); { 10 }
  FF( c, d, a, b, x[10], S13, $ffff5bb1); { 11 }
  FF( b, c, d, a, x[11], S14, $895cd7be); { 12 }
  FF( a, b, c, d, x[12], S11, $6b901122); { 13 }
  FF( d, a, b, c, x[13], S12, $fd987193); { 14 }
  FF( c, d, a, b, x[14], S13, $a679438e); { 15 }
  FF( b, c, d, a, x[15], S14, $49b40821); { 16 }

  { Round 2 }
  GG( a, b, c, d, x[ 1], S21, $f61e2562); { 17 }
  GG( d, a, b, c, x[ 6], S22, $c040b340); { 18 }
  GG( c, d, a, b, x[11], S23, $265e5a51); { 19 }
  GG( b, c, d, a, x[ 0], S24, $e9b6c7aa); { 20 }
  GG( a, b, c, d, x[ 5], S21, $d62f105d); { 21 }
  GG( d, a, b, c, x[10], S22,  $2441453); { 22 }
  GG( c, d, a, b, x[15], S23, $d8a1e681); { 23 }
  GG( b, c, d, a, x[ 4], S24, $e7d3fbc8); { 24 }
  GG( a, b, c, d, x[ 9], S21, $21e1cde6); { 25 }
  GG( d, a, b, c, x[14], S22, $c33707d6); { 26 }
  GG( c, d, a, b, x[ 3], S23, $f4d50d87); { 27 }
  GG( b, c, d, a, x[ 8], S24, $455a14ed); { 28 }
  GG( a, b, c, d, x[13], S21, $a9e3e905); { 29 }
  GG( d, a, b, c, x[ 2], S22, $fcefa3f8); { 30 }
  GG( c, d, a, b, x[ 7], S23, $676f02d9); { 31 }
  GG( b, c, d, a, x[12], S24, $8d2a4c8a); { 32 }

  { Round 3 }
  HH( a, b, c, d, x[ 5], S31, $fffa3942); { 33 }
  HH( d, a, b, c, x[ 8], S32, $8771f681); { 34 }
  HH( c, d, a, b, x[11], S33, $6d9d6122); { 35 }
  HH( b, c, d, a, x[14], S34, $fde5380c); { 36 }
  HH( a, b, c, d, x[ 1], S31, $a4beea44); { 37 }
  HH( d, a, b, c, x[ 4], S32, $4bdecfa9); { 38 }
  HH( c, d, a, b, x[ 7], S33, $f6bb4b60); { 39 }
  HH( b, c, d, a, x[10], S34, $bebfbc70); { 40 }
  HH( a, b, c, d, x[13], S31, $289b7ec6); { 41 }
  HH( d, a, b, c, x[ 0], S32, $eaa127fa); { 42 }
  HH( c, d, a, b, x[ 3], S33, $d4ef3085); { 43 }
  HH( b, c, d, a, x[ 6], S34,  $4881d05); { 44 }
  HH( a, b, c, d, x[ 9], S31, $d9d4d039); { 45 }
  HH( d, a, b, c, x[12], S32, $e6db99e5); { 46 }
  HH( c, d, a, b, x[15], S33, $1fa27cf8); { 47 }
  HH( b, c, d, a, x[ 2], S34, $c4ac5665); { 48 }

  { Round 4 }
  II( a, b, c, d, x[ 0], S41, $f4292244); { 49 }
  II( d, a, b, c, x[ 7], S42, $432aff97); { 50 }
  II( c, d, a, b, x[14], S43, $ab9423a7); { 51 }
  II( b, c, d, a, x[ 5], S44, $fc93a039); { 52 }
  II( a, b, c, d, x[12], S41, $655b59c3); { 53 }
  II( d, a, b, c, x[ 3], S42, $8f0ccc92); { 54 }
  II( c, d, a, b, x[10], S43, $ffeff47d); { 55 }
  II( b, c, d, a, x[ 1], S44, $85845dd1); { 56 }
  II( a, b, c, d, x[ 8], S41, $6fa87e4f); { 57 }
  II( d, a, b, c, x[15], S42, $fe2ce6e0); { 58 }
  II( c, d, a, b, x[ 6], S43, $a3014314); { 59 }
  II( b, c, d, a, x[13], S44, $4e0811a1); { 60 }
  II( a, b, c, d, x[ 4], S41, $f7537e82); { 61 }
  II( d, a, b, c, x[11], S42, $bd3af235); { 62 }
  II( c, d, a, b, x[ 2], S43, $2ad7d2bb); { 63 }
  II( b, c, d, a, x[ 9], S44, $eb86d391); { 64 }

  Inc(FContextState[0], a);
  Inc(FContextState[1], b);
  Inc(FContextState[2], c);
  Inc(FContextState[3], d);
end;

procedure THashMD5.Update(const AData; ALength: Cardinal);
begin
  Update(PByte(@AData), ALength);
end;

procedure THashMD5.Update(const AData: TBytes; ALength: Cardinal = 0);
var
  LLen: Cardinal;
begin
  LLen := ALength;
  if LLen = 0 then
    LLen := Length(AData);
  Update(PByte(AData), LLen);
end;

procedure THashMD5.Update(const AData: PByte; ALength: Cardinal);
var
  Index, PartLen, I, Start: Cardinal;
begin
  if FFinalized then
    raise EHashException.CreateRes(@SHashCanNotUpdateMD5);

  { Compute number of bytes mod 64 }
  Index := (FContextCount[0] shr 3) and $3f;
  { Update number of bits }
  Inc(FContextCount[0], ALength shl 3);
  if FContextCount[0] < (ALength shl 3) then
    Inc(FContextCount[1]);
  Inc(FContextCount[1], ALength shr 29);
  PartLen := 64 - Index;

  { Transform (as many times as possible) }
  if ALength >= PartLen then
  begin
    for I := 0 to PartLen - 1 do
      FContextBuffer[I + Index] := AData[I];

    Transform(PByte(@FContextBuffer[0]), 0);
    I := PartLen;
    while (I + 63) < ALength do
    begin
      Transform(AData, I);
      Inc(I, 64);
    end;
    Index := 0;
  end
  else
    I := 0;

  { Input remaining input }
  if I < ALength then
  begin
    Start := I;
    while I < ALength do
    begin
      FContextBuffer[Index + I - Start] := AData[I];
      Inc(I);
    end;
  end;
end;

procedure THashMD5.Update(const Input: string);
begin
  Update(TEncoding.UTF8.GetBytes(Input));
end;

{$POINTERMATH ON}
procedure THashMD5.Encode(const Dst: PByte; const Src: PCardinal; Len: Integer);
var
  I, J: Integer;
begin
  I := 0;
  J := 0;
  while J < Len do
  begin
    Dst[J]   := Byte((Src[I]       ) and $ff);
    Dst[J+1] := Byte((Src[I] shr  8) and $ff);
    Dst[J+2] := Byte((Src[I] shr 16) and $ff);
    Dst[J+3] := Byte((Src[I] shr 24) and $ff);
    Inc(J, 4);
    Inc(I);
  end;
end;

function THashMD5.GetBlockSize: Integer;
begin
  Result := 64;
end;

function THashMD5.GetDigest: TBytes;
begin
  if not FFinalized then
    FinalizeHash;
  { Store state in digest }
  SetLength(Result, GetHashSize);
  Encode(PByte(Result), PCardinal(@FContextState[0]), GetHashSize);
end;

class function THashMD5.GetHashBytes(const AData: string): TBytes;
var
  LMD5: THashMD5;
begin
  LMD5 := THashMD5.Create;
  LMD5.Update(AData);
  Result := LMD5.GetDigest;
end;

function THashMD5.GetHashSize: Integer;
begin
  Result := 16;
end;

class function THashMD5.GetHashString(const AString: string): string;
var
  LMD5: THashMD5;
begin
  LMD5 := THashMD5.Create;
  LMD5.Update(AString);
  Result := LMD5.HashAsString;
end;

class function THashMD5.GetHMAC(const AData, AKey: string): string;
begin
  Result := THash.DigestAsString(GetHMACAsBytes(AData, AKey));
end;

class function THashMD5.GetHMACAsBytes(const AData, AKey: string): TBytes;
begin
  Result := GetHMACAsBytes(TEncoding.UTF8.GetBytes(AData), TEncoding.UTF8.GetBytes(AKey));
end;

class function THashMD5.GetHMACAsBytes(const AData: string; const AKey: TBytes): TBytes;
begin
  Result := GetHMACAsBytes(TEncoding.UTF8.GetBytes(AData), AKey);
end;

class function THashMD5.GetHMACAsBytes(const AData: TBytes; const AKey: string): TBytes;
begin
  Result := GetHMACAsBytes(AData, TEncoding.UTF8.GetBytes(AKey));
end;

class function THashMD5.GetHMACAsBytes(const AData, AKey: TBytes): TBytes;
const
  CInnerPad : Byte = $36;
  COuterPad : Byte = $5C;
var
  TempBuffer1: TBytes;
  TempBuffer2: TBytes;
  FKey: TBytes;
  LKey: TBytes;
  I: Integer;
  FHash: THashMD5;
  LBuffer: TBytes;
begin
  FHash := THashMD5.Create;

  LBuffer := AData;

  FKey := AKey;
  if Length(FKey) > FHash.GetBlockSize then
  begin
    FHash.Update(FKey);
    FKey := Copy(FHash.GetDigest);
  end;

  LKey := Copy(FKey, 0, MaxInt);
  SetLength(LKey, FHash.GetBlockSize);
  SetLength(TempBuffer1, FHash.GetBlockSize + Length(LBuffer));
  for I := Low(LKey) to High(LKey) do begin
    TempBuffer1[I] := LKey[I] xor CInnerPad;
  end;
  if Length(LBuffer) > 0 then
    Move(LBuffer[0], TempBuffer1[Length(LKey)], Length(LBuffer));

  FHash.Reset;
  FHash.Update(TempBuffer1);
  TempBuffer2 := FHash.GetDigest;

  SetLength(TempBuffer1, FHash.GetBlockSize + FHash.GetHashSize);
  for I := Low(LKey) to High(LKey) do begin
    TempBuffer1[I] := LKey[I] xor COuterPad;
  end;
  Move(TempBuffer2[0], TempBuffer1[Length(LKey)], Length(TempBuffer2));

  FHash.Reset;
  FHash.Update(TempBuffer1);
  Result := FHash.GetDigest;
end;

function THashMD5.HashAsBytes: TBytes;
begin
  Result := GetDigest;
end;

function THashMD5.HashAsString: string;
begin
  Result := THash.DigestAsString(GetDigest);
end;

procedure THashMD5.FinalizeHash;
var
  Bits: TContextBuffer;
  Index: Integer;
  PadLen: Cardinal;
begin
  { Save number of bits }
  Encode(PByte(@Bits[0]), PCardinal(@FContextCount[0]), 8);
  { Pad out to 56 mod 64 }
  Index := (FContextCount[0] shr 3) and $3F;
  if Index < 56 then
    PadLen := 56 - Index
  else
    PadLen := 120 - Index;
  Update(PByte(@FPadding[0]), PadLen);
  { Append length (before padding) }
  Update(PByte(@Bits[0]), 8);
  FFinalized := True;
end;

procedure THashMD5.Decode(const Dst: PCardinal; const Src: PByte; Len: Integer; AShift: Integer);
var
  I, J: Integer;
  a, b, c, d: Byte;
begin
  J := 0;
  I := 0;
  while (J < Len) do
  begin
    a := Src[J+AShift];
    b := Src[J+AShift+1];
    c := Src[J+AShift+2];
    d := Src[J+AShift+3];
    Dst[I] := Cardinal(a and $ff)         or
             (Cardinal(b and $ff) shl 8)  or
             (Cardinal(c and $ff) shl 16) or
             (Cardinal(d and $ff) shl 24);
    Inc(J, 4);
    Inc(I);
  end;
end;

{$POINTERMATH OFF}

{ THashSHA1 }

procedure THashSHA1.CheckFinalized;
begin
  if FFinalized then
    raise EHashException.CreateRes(@SHashCanNotUpdateSHA1);
end;

procedure THashSHA1.Update(const Input: string);
begin
  Update(TEncoding.UTF8.GetBytes(Input));
end;

procedure THashSHA1.Compress;

  function F1(X, Y, Z: Cardinal): Cardinal; inline;
  begin
    Result := (X and Y) or ((not X) and Z);
  end;

  function F2(X, Y, Z: Cardinal): Cardinal; inline;
  begin
    Result := X xor Y xor Z;
  end;

  function F3(X, Y, Z: Cardinal): Cardinal; inline;
  begin
    Result := (X and Y) or (X and Z) or (Y and Z);
  end;

  function LeftRotate(Value: Cardinal; N: Integer): Cardinal; inline;
  begin
    Result := (Value shl N) or (Value shr (32 - N));
  end;

var
  A, B, C, D, E, T: Cardinal;
  W: array[0..79] of Cardinal;
  I: Integer;
begin
  Move(FBuffer, W, Sizeof(FBuffer));
  for I := 0 to 15 do
    W[I] := THash.ToBigEndian(W[I]);
  for I := 16 to 79 do
    W[I] := LeftRotate(W[I - 3] xor W[I - 8] xor W[I - 14] xor W[I - 16], 1);
  A := FHash[0]; B := FHash[1]; C := FHash[2]; D := FHash[3]; E := FHash[4];
  for I := 0 to 19 do
  begin
    T := LeftRotate(A, 5) + F1(B, C, D) + E + W[I] + $5A827999;
    E := D; D := C; C := LeftRotate(B, 30); B := A; A := T;
  end;
  for I := 20 to 39 do
  begin
    T := LeftRotate(A, 5) + F2(B, C, D) + E + W[I] + $6ED9EBA1;
    E := D; D := C; C := LeftRotate(B, 30); B := A; A := T;
  end;
  for I := 40 to 59 do
  begin
    T := LeftRotate(A, 5) + F3(B, C, D) + E + W[I] + $8F1BBCDC;
    E := D; D:= C; C := LeftRotate(B, 30); B := A; A := T;
  end;
  for I := 60 to 79 do
  begin
    T := LeftRotate(A, 5) + F2(B, C, D) + E + W[I] + $CA62C1D6;
    E := D; D := C; C := LeftRotate(B, 30); B := A; A := T;
  end;
  FHash[0] := FHash[0] + A;
  FHash[1] := FHash[1] + B;
  FHash[2] := FHash[2] + C;
  FHash[3] := FHash[3] + D;
  FHash[4] := FHash[4] + E;
  FillChar(FBuffer, Sizeof(FBuffer), 0);
end;

class function THashSHA1.Create: THashSHA1;
begin
  Result.Initialize;
end;

class function THashSHA1.GetHashBytes(const AData: string): TBytes;
var
  LSHA1: THashSHA1;
begin
  LSHA1 := THashSHA1.Create;
  LSHA1.Update(AData);
  Result := LSHA1.GetDigest;
end;

function THashSHA1.GetHashSize: Integer;
begin
  Result := 20;
end;

class function THashSHA1.GetHashString(const AString: string): string;
var
  LSHA1: THashSHA1;
begin
  LSHA1 := THashSHA1.Create;
  LSHA1.Update(AString);
  Result := LSHA1.HashAsString;
end;

class function THashSHA1.GetHMAC(const AData, AKey: string): string;
begin
  Result := THash.DigestAsString(GetHMACAsBytes(AData, AKey));
end;

class function THashSHA1.GetHMACAsBytes(const AData: string; const AKey: TBytes): TBytes;
begin
  Result := GetHMACAsBytes(TEncoding.UTF8.GetBytes(AData), AKey);
end;

class function THashSHA1.GetHMACAsBytes(const AData, AKey: string): TBytes;
begin
  Result := GetHMACAsBytes(TEncoding.UTF8.GetBytes(AData), TEncoding.UTF8.GetBytes(AKey));
end;

class function THashSHA1.GetHMACAsBytes(const AData: TBytes; const AKey: string): TBytes;
begin
  Result := GetHMACAsBytes(AData, TEncoding.UTF8.GetBytes(AKey));
end;

class function THashSHA1.GetHMACAsBytes(const AData, AKey: TBytes): TBytes;
const
  CInnerPad : Byte = $36;
  COuterPad : Byte = $5C;
var
  TempBuffer1: TBytes;
  TempBuffer2: TBytes;
  FKey: TBytes;
  LKey: TBytes;
  I: Integer;
  FHash: THashSHA1;
  LBuffer: TBytes;
begin
  FHash := THashSHA1.Create;

  LBuffer := AData;

  FKey := AKey;
  if Length(FKey) > FHash.GetBlockSize then
  begin
    FHash.Update(FKey);
    FKey := Copy(FHash.GetDigest);
  end;

  LKey := Copy(FKey, 0, MaxInt);
  SetLength(LKey, FHash.GetBlockSize);
  SetLength(TempBuffer1, FHash.GetBlockSize + Length(LBuffer));
  for I := Low(LKey) to High(LKey) do begin
    TempBuffer1[I] := LKey[I] xor CInnerPad;
  end;
  if Length(LBuffer) > 0 then
    Move(LBuffer[0], TempBuffer1[Length(LKey)], Length(LBuffer));

  FHash.Reset;
  FHash.Update(TempBuffer1);
  TempBuffer2 := FHash.GetDigest;

  SetLength(TempBuffer1, FHash.GetBlockSize + FHash.GetHashSize);
  for I := Low(LKey) to High(LKey) do begin
    TempBuffer1[I] := LKey[I] xor COuterPad;
  end;
  Move(TempBuffer2[0], TempBuffer1[Length(LKey)], Length(TempBuffer2));

  FHash.Reset;
  FHash.Update(TempBuffer1);
  Result := FHash.GetDigest;
end;

procedure THashSHA1.Finalize;
begin
  CheckFinalized;
  FBuffer[FIndex] := $80;
  if FIndex >= 56 then
    Compress;
  PCardinal(@FBuffer[56])^ := THash.ToBigEndian(Cardinal(FBitLength shr 32));
  PCardinal(@FBuffer[60])^ := THash.ToBigEndian(Cardinal(FBitLength));
  Compress;
  FHash[0] := THash.ToBigEndian(FHash[0]);
  FHash[1] := THash.ToBigEndian(FHash[1]);
  FHash[2] := THash.ToBigEndian(FHash[2]);
  FHash[3] := THash.ToBigEndian(FHash[3]);
  FHash[4] := THash.ToBigEndian(FHash[4]);
  FFinalized := True;
end;

function THashSHA1.GetBlockSize: Integer;
begin
  Result := 64;
end;

function THashSHA1.GetDigest: TBytes;
begin
  if not FFinalized then
    Finalize;
  SetLength(Result, GetHashSize); // Size of Hash...
  Move(PByte(@FHash[0])^, PByte(@Result[0])^, GetHashSize);
end;

procedure THashSHA1.Initialize;
begin
  FillChar(Self, SizeOf(Self), 0);
  FHash[0] := $67452301;
  FHash[1] := $EFCDAB89;
  FHash[2] := $98BADCFE;
  FHash[3] := $10325476;
  FHash[4] := $C3D2E1F0;
end;

procedure THashSHA1.Reset;
begin
  Initialize;
end;

procedure THashSHA1.Update(const AData; ALength: Cardinal);
begin
  Update(PByte(@AData), ALength);
end;

procedure THashSHA1.Update(const AData: PByte; ALength: Cardinal);
var
  Buffer: PByte;
begin
  CheckFinalized;
  Buffer := AData;

  Inc(FBitLength, ALength * 8);
  while ALength > 0 do
  begin
    FBuffer[FIndex] := Buffer[0];
    Inc(Buffer);
    Inc(FIndex);
    Dec(ALength);
    if FIndex = 64 then
    begin
      FIndex := 0;
      Compress;
    end;
  end;
end;

procedure THashSHA1.Update(const AData: TBytes; ALength: Cardinal = 0);
var
  Len: Integer;
begin
  if ALength = 0 then
    Len := Length(AData)
  else
    Len := ALength;
  Update(PByte(AData), Len);
end;

function THashSHA1.HashAsBytes: TBytes;
begin
  Result := GetDigest;
end;

function THashSHA1.HashAsString: string;
begin
  Result := THash.DigestAsString(GetDigest);
end;


{ THashSHA2 }

class function THashSHA2.Create(AHashVersion: TSHA2Version): THashSHA2;
begin
  Result.Initialize(AHashVersion);
end;

procedure THashSHA2.CheckFinalized;
begin
  if FFinalized then
    raise EHashException.CreateRes(@SHashCanNotUpdateSHA2);
end;

procedure THashSHA2.Update(const Input: string);
begin
  Update(TEncoding.UTF8.GetBytes(Input));
end;

procedure THashSHA2.Compress;
begin
  case FVersion of
    THashSHA2.TSHA2Version.SHA224,
    THashSHA2.TSHA2Version.SHA256: Compress32;
    THashSHA2.TSHA2Version.SHA384,
    THashSHA2.TSHA2Version.SHA512,
    THashSHA2.TSHA2Version.SHA512_224,
    THashSHA2.TSHA2Version.SHA512_256: Compress64;
  end;
end;

procedure THashSHA2.Compress32;
const
  K_256: array[0..63] of Cardinal = (
   $428a2f98, $71374491, $b5c0fbcf, $e9b5dba5, $3956c25b, $59f111f1, $923f82a4, $ab1c5ed5,
   $d807aa98, $12835b01, $243185be, $550c7dc3, $72be5d74, $80deb1fe, $9bdc06a7, $c19bf174,
   $e49b69c1, $efbe4786, $0fc19dc6, $240ca1cc, $2de92c6f, $4a7484aa, $5cb0a9dc, $76f988da,
   $983e5152, $a831c66d, $b00327c8, $bf597fc7, $c6e00bf3, $d5a79147, $06ca6351, $14292967,
   $27b70a85, $2e1b2138, $4d2c6dfc, $53380d13, $650a7354, $766a0abb, $81c2c92e, $92722c85,
   $a2bfe8a1, $a81a664b, $c24b8b70, $c76c51a3, $d192e819, $d6990624, $f40e3585, $106aa070,
   $19a4c116, $1e376c08, $2748774c, $34b0bcb5, $391c0cb3, $4ed8aa4a, $5b9cca4f, $682e6ff3,
   $748f82ee, $78a5636f, $84c87814, $8cc70208, $90befffa, $a4506ceb, $bef9a3f7, $c67178f2);

  function Ch_(X, Y, Z: Cardinal): Cardinal; inline;
  begin
    Result := (X and Y) xor ((not X) and Z);
  end;
  function Maj(X, Y, Z: Cardinal): Cardinal; inline;
  begin
    Result := (X and Y) xor (X and Z) xor (Y and Z);
  end;
  function ROR(x: Cardinal; n: Byte): Cardinal; inline;
  begin
    Result := (x shl (32 - n) or (x shr n));
  end;

var
  I: Integer;
  s0, s1, t1, t2: Cardinal;
  W: array[0..63] of Cardinal;
  a, b, c, d, e, f, g, h: Cardinal;
begin
  a := FHash[0];
  b := FHash[1];
  c := FHash[2];
  d := FHash[3];
  e := FHash[4];
  f := FHash[5];
  g := FHash[6];
  h := FHash[7];

  Move(FBuffer, W, CBuffer32Length);
  // Initialize message schedule
  for I := 0 to 15 do
    W[I] := THash.ToBigEndian(W[I]);

  for I := 16 to 63 do
  begin
    s0   := ROR(W[I - 15],  7) xor ROR(W[I - 15], 18) xor (W[I - 15] shr  3);
    s1   := ROR(W[I -  2], 17) xor ROR(W[I -  2], 19) xor (W[I -  2] shr 10);
    W[I] := W[I - 16] + s0 + W[I - 7] + s1;
  end;

  // Process the data to generate the change for the next intermediate hash
  for I := 0 to 63 do
  begin
    s0 := ROR(a, 2) xor ROR(a, 13) xor ROR(a, 22);
    t2 := s0 + Maj(a, b, c);
    s1 := ROR(e, 6) xor ROR(e, 11) xor ROR(e, 25);

    t1 := h + s1 + Ch_(e, f, g) + K_256[I] + W[I];
    h := g;
    g := f;
    f := e;
    e := d + t1;
    d := c;
    c := b;
    b := a;
    a := t1 + t2;
  end;

  // Update hash value.
  FHash[0] := FHash[0] + a;
  FHash[1] := FHash[1] + b;
  FHash[2] := FHash[2] + c;
  FHash[3] := FHash[3] + d;
  FHash[4] := FHash[4] + e;
  FHash[5] := FHash[5] + f;
  FHash[6] := FHash[6] + g;
  FHash[7] := FHash[7] + h;
end;

procedure THashSHA2.Compress64;
const
  K_512: array[0..79] of UInt64 = (
      $428a2f98d728ae22, $7137449123ef65cd, $b5c0fbcfec4d3b2f, $e9b5dba58189dbbc,
      $3956c25bf348b538, $59f111f1b605d019, $923f82a4af194f9b, $ab1c5ed5da6d8118,
      $d807aa98a3030242, $12835b0145706fbe, $243185be4ee4b28c, $550c7dc3d5ffb4e2,
      $72be5d74f27b896f, $80deb1fe3b1696b1, $9bdc06a725c71235, $c19bf174cf692694,
      $e49b69c19ef14ad2, $efbe4786384f25e3, $0fc19dc68b8cd5b5, $240ca1cc77ac9c65,
      $2de92c6f592b0275, $4a7484aa6ea6e483, $5cb0a9dcbd41fbd4, $76f988da831153b5,
      $983e5152ee66dfab, $a831c66d2db43210, $b00327c898fb213f, $bf597fc7beef0ee4,
      $c6e00bf33da88fc2, $d5a79147930aa725, $06ca6351e003826f, $142929670a0e6e70,
      $27b70a8546d22ffc, $2e1b21385c26c926, $4d2c6dfc5ac42aed, $53380d139d95b3df,
      $650a73548baf63de, $766a0abb3c77b2a8, $81c2c92e47edaee6, $92722c851482353b,
      $a2bfe8a14cf10364, $a81a664bbc423001, $c24b8b70d0f89791, $c76c51a30654be30,
      $d192e819d6ef5218, $d69906245565a910, $f40e35855771202a, $106aa07032bbd1b8,
      $19a4c116b8d2d0c8, $1e376c085141ab53, $2748774cdf8eeb99, $34b0bcb5e19b48a8,
      $391c0cb3c5c95a63, $4ed8aa4ae3418acb, $5b9cca4f7763e373, $682e6ff3d6b2b8a3,
      $748f82ee5defb2fc, $78a5636f43172f60, $84c87814a1f0ab72, $8cc702081a6439ec,
      $90befffa23631e28, $a4506cebde82bde9, $bef9a3f7b2c67915, $c67178f2e372532b,
      $ca273eceea26619c, $d186b8c721c0c207, $eada7dd6cde0eb1e, $f57d4f7fee6ed178,
      $06f067aa72176fba, $0a637dc5a2c898a6, $113f9804bef90dae, $1b710b35131c471b,
      $28db77f523047d84, $32caab7b40c72493, $3c9ebe0a15c9bebc, $431d67c49c100d4c,
      $4cc5d4becb3e42b6, $597f299cfc657e2a, $5fcb6fab3ad6faec, $6c44198c4a475817);

  function Ch_(X, Y, Z: UInt64): UInt64; inline;
  begin
    Result := (X and Y) xor ((not X) and Z);
  end;
  function Maj(X, Y, Z: UInt64): UInt64; inline;
  begin
    Result := (X and Y) xor (X and Z) xor (Y and Z);
  end;
  function ROR(x: UInt64; n: Byte): UInt64; inline;
  begin
    Result := (x shl (64 - n)) or (x shr n);
  end;

var
  I: Integer;
  s0, s1, t1, t2: UInt64;
  W: array[0..79] of UInt64;
  a, b, c, d, e, f, g, h: UInt64;
begin
  a := FHash64[0];
  b := FHash64[1];
  c := FHash64[2];
  d := FHash64[3];
  e := FHash64[4];
  f := FHash64[5];
  g := FHash64[6];
  h := FHash64[7];

  Move(FBuffer, W, CBuffer64Length);
  // Initialize message schedule
  for I := 0 to 15 do
    W[I] := THash.ToBigEndian(W[I]);

  for I := 16 to 79 do
  begin
    s0   := ROR(W[I - 15],  1) xor ROR(W[I - 15],  8) xor (W[I - 15] shr 7);
    s1   := ROR(W[I -  2], 19) xor ROR(W[I -  2], 61) xor (W[I -  2] shr 6);
    W[I] := W[I - 16] + s0 + W[I - 7] + s1;
  end;

  // Process the data to generate the change for the next intermediate hash
  for I := 0 to 79 do
  begin
    s0 := ROR(a, 28) xor ROR(a, 34) xor ROR(a, 39);
    t2 := s0 + Maj(a, b, c);
    s1 := ROR(e, 14) xor ROR(e, 18) xor ROR(e, 41);

    t1 := h + s1 + Ch_(e, f, g) + K_512[I] + W[I];
    h := g;
    g := f;
    f := e;
    e := d + t1;
    d := c;
    c := b;
    b := a;
    a := t1 + t2;
  end;

  FHash64[0] := FHash64[0] + a;
  FHash64[1] := FHash64[1] + b;
  FHash64[2] := FHash64[2] + c;
  FHash64[3] := FHash64[3] + d;
  FHash64[4] := FHash64[4] + e;
  FHash64[5] := FHash64[5] + f;
  FHash64[6] := FHash64[6] + g;
  FHash64[7] := FHash64[7] + h;
end;

class function THashSHA2.GetHashBytes(const AData: string; AHashVersion: TSHA2Version): TBytes;
var
  LSHA2: THashSHA2;
begin
  LSHA2 := THashSHA2.Create(AHashVersion);
  LSHA2.Update(AData);
  Result := LSHA2.GetDigest;
end;

function THashSHA2.GetHashSize: Integer;
begin
  case FVersion of
    TSHA2Version.SHA224: Result := 28;
    TSHA2Version.SHA256: Result := 32;
    TSHA2Version.SHA384: Result := 48;
    TSHA2Version.SHA512: Result := 64;
    TSHA2Version.SHA512_224: Result := 28;
    TSHA2Version.SHA512_256: Result := 32;
  else
    Result := 0; // This will never happen, but makes happy the compiler about Undefined result of function.
  end;
end;

class function THashSHA2.GetHashString(const AString: string; AHashVersion: TSHA2Version): string;
var
  LSHA2: THashSHA2;
begin
  LSHA2 := THashSHA2.Create(AHashVersion);
  LSHA2.Update(AString);
  Result := LSHA2.HashAsString;
end;

class function THashSHA2.GetHMAC(const AData, AKey: string; AHashVersion: TSHA2Version): string;
begin
  Result := THash.DigestAsString(GetHMACAsBytes(AData, AKey, AHashVersion));
end;

class function THashSHA2.GetHMACAsBytes(const AData: string; const AKey: TBytes; AHashVersion: TSHA2Version): TBytes;
begin
  Result := THashSHA2.GetHMACAsBytes(TEncoding.UTF8.GetBytes(AData), AKey, AHashVersion);
end;

class function THashSHA2.GetHMACAsBytes(const AData, AKey: string; AHashVersion: TSHA2Version): TBytes;
begin
  Result := THashSHA2.GetHMACAsBytes(TEncoding.UTF8.GetBytes(AData), TEncoding.UTF8.GetBytes(AKey), AHashVersion);
end;

class function THashSHA2.GetHMACAsBytes(const AData: TBytes; const AKey: string; AHashVersion: TSHA2Version): TBytes;
begin
  Result := GetHMACAsBytes(AData, TEncoding.UTF8.GetBytes(AKey), AHashVersion);
end;

class function THashSHA2.GetHMACAsBytes(const AData, AKey: TBytes; AHashVersion: TSHA2Version): TBytes;
const
  CInnerPad : Byte = $36;
  COuterPad : Byte = $5C;
var
  TempBuffer1: TBytes;
  TempBuffer2: TBytes;
  FKey: TBytes;
  LKey: TBytes;
  I: Integer;
  FHash: THashSHA2;
  LBuffer: TBytes;
  LHashSize: Integer;
  LBlockSize: Integer;
begin
  FHash := THashSHA2.Create(AHashVersion);
  LBlockSize := FHash.GetBlockSize;

  LBuffer := AData;

  FKey := AKey;
  if Length(FKey) > LBlockSize then
  begin
    FHash.Update(FKey);
    FKey := Copy(FHash.GetDigest);
  end;

  LKey := Copy(FKey, 0, MaxInt);
  SetLength(LKey, LBlockSize);
  SetLength(TempBuffer1, LBlockSize + Length(LBuffer));
  for I := Low(LKey) to High(LKey) do
    TempBuffer1[I] := LKey[I] xor CInnerPad;

  if Length(LBuffer) > 0 then
    Move(LBuffer[0], TempBuffer1[Length(LKey)], Length(LBuffer));

  FHash.Reset;
  FHash.Update(TempBuffer1);
  TempBuffer2 := FHash.GetDigest;

  LHashSize := Length(TempBuffer2);

  SetLength(TempBuffer1, LBlockSize + LHashSize);
  for I := Low(LKey) to High(LKey) do
    TempBuffer1[I] := LKey[I] xor COuterPad;

  Move(TempBuffer2[0], TempBuffer1[Length(LKey)], Length(TempBuffer2));

  FHash.Reset;
  FHash.Update(TempBuffer1);
  Result := FHash.GetDigest;
end;

procedure THashSHA2.Finalize;
begin
  CheckFinalized;
  case FVersion of
    THashSHA2.TSHA2Version.SHA224,
    THashSHA2.TSHA2Version.SHA256: Finalize32;
    THashSHA2.TSHA2Version.SHA384,
    THashSHA2.TSHA2Version.SHA512,
    THashSHA2.TSHA2Version.SHA512_224,
    THashSHA2.TSHA2Version.SHA512_256: Finalize64;
  end;
  FFinalized := True;
end;

procedure THashSHA2.Finalize32;
var
  I: Integer;
begin
  FBuffer[FIndex] := $80;
  if FIndex >= 56 then
  begin
    for I := FIndex + 1 to CBuffer32Length - 1 do
      FBuffer[I] := $00;
    Compress;
    FIndex := 0;
  end
  else
    Inc(FIndex);

  // No need to clean the bytes used for the BitLength
  FillChar(FBuffer[FIndex], (CBuffer32Length - 8) - FIndex, 0);

  PCardinal(@FBuffer[56])^ := THash.ToBigEndian(Cardinal(FBitLength shr 32));
  PCardinal(@FBuffer[60])^ := THash.ToBigEndian(Cardinal(FBitLength));
  Compress;
  FHash[0] := THash.ToBigEndian(FHash[0]);
  FHash[1] := THash.ToBigEndian(FHash[1]);
  FHash[2] := THash.ToBigEndian(FHash[2]);
  FHash[3] := THash.ToBigEndian(FHash[3]);
  FHash[4] := THash.ToBigEndian(FHash[4]);
  FHash[5] := THash.ToBigEndian(FHash[5]);
  FHash[6] := THash.ToBigEndian(FHash[6]);
  FHash[7] := THash.ToBigEndian(FHash[7]);
end;

procedure THashSHA2.Finalize64;
var
  I: Integer;
begin
  FBuffer[FIndex] := $80;
  if FIndex >= 112 then
  begin
    for I := FIndex + 1 to CBuffer64Length - 1 do
      FBuffer[I] := $00;
    Compress;
    FIndex := 0;
  end
  else
    Inc(FIndex);

  // No need to clean the bytes used for the BitLength
  FillChar(FBuffer[FIndex], (CBuffer64Length - 16) - FIndex, 0);

                                                                                                                           
  PCardinal(@FBuffer[112])^ := 0; //THash.ToBigEndian(Cardinal(FBitLength shr 32));
  PCardinal(@FBuffer[116])^ := 0; //THash.ToBigEndian(Cardinal(FBitLength));
  PCardinal(@FBuffer[120])^ := THash.ToBigEndian(Cardinal(FBitLength shr 32));
  PCardinal(@FBuffer[124])^ := THash.ToBigEndian(Cardinal(FBitLength));
  Compress;
  FHash64[0] := THash.ToBigEndian(FHash64[0]);
  FHash64[1] := THash.ToBigEndian(FHash64[1]);
  FHash64[2] := THash.ToBigEndian(FHash64[2]);
  FHash64[3] := THash.ToBigEndian(FHash64[3]);
  FHash64[4] := THash.ToBigEndian(FHash64[4]);
  FHash64[5] := THash.ToBigEndian(FHash64[5]);
  FHash64[6] := THash.ToBigEndian(FHash64[6]);
  FHash64[7] := THash.ToBigEndian(FHash64[7]);
end;

function THashSHA2.GetBlockSize: Integer;
begin
  case FVersion of
    THashSHA2.TSHA2Version.SHA224,
    THashSHA2.TSHA2Version.SHA256: Result := 64;
    THashSHA2.TSHA2Version.SHA384,
    THashSHA2.TSHA2Version.SHA512,
    THashSHA2.TSHA2Version.SHA512_224,
    THashSHA2.TSHA2Version.SHA512_256: Result := 128;
  else
    Result := 0; // This will never happen, but makes happy the compiler about Undefined result of function.
  end;
end;

function THashSHA2.GetDigest: TBytes;
var
  LHashSize: Integer;
begin
  if not FFinalized then
    Finalize;
  LHashSize := GetHashSize;
  SetLength(Result, LHashSize);
  Move(PByte(@FHash64[0])^, PByte(@Result[0])^, LHashSize);
end;

procedure THashSHA2.Initialize(AVersion: TSHA2Version);
begin
  FillChar(Self, SizeOf(Self), 0);
  FVersion := AVersion;
  case FVersion of
    TSHA2Version.SHA224:
    begin
      FHash[0]:= $c1059ed8;
      FHash[1]:= $367cd507;
      FHash[2]:= $3070dd17;
      FHash[3]:= $f70e5939;
      FHash[4]:= $ffc00b31;
      FHash[5]:= $68581511;
      FHash[6]:= $64f98fa7;
      FHash[7]:= $befa4fa4;
    end;

    TSHA2Version.SHA256:
    begin
      FHash[0]:= $6a09e667;
      FHash[1]:= $bb67ae85;
      FHash[2]:= $3c6ef372;
      FHash[3]:= $a54ff53a;
      FHash[4]:= $510e527f;
      FHash[5]:= $9b05688c;
      FHash[6]:= $1f83d9ab;
      FHash[7]:= $5be0cd19;
    end;

    TSHA2Version.SHA384:
    begin
      FHash64[0]:= $cbbb9d5dc1059ed8;
      FHash64[1]:= $629a292a367cd507;
      FHash64[2]:= $9159015a3070dd17;
      FHash64[3]:= $152fecd8f70e5939;
      FHash64[4]:= $67332667ffc00b31;
      FHash64[5]:= $8eb44a8768581511;
      FHash64[6]:= $db0c2e0d64f98fa7;
      FHash64[7]:= $47b5481dbefa4fa4;
    end;

    TSHA2Version.SHA512:
    begin
      FHash64[0]:= $6a09e667f3bcc908;
      FHash64[1]:= $bb67ae8584caa73b;
      FHash64[2]:= $3c6ef372fe94f82b;
      FHash64[3]:= $a54ff53a5f1d36f1;
      FHash64[4]:= $510e527fade682d1;
      FHash64[5]:= $9b05688c2b3e6c1f;
      FHash64[6]:= $1f83d9abfb41bd6b;
      FHash64[7]:= $5be0cd19137e2179;
    end;

    TSHA2Version.SHA512_224:
    begin
      FHash64[0]:= $8C3D37C819544DA2;
      FHash64[1]:= $73E1996689DCD4D6;
      FHash64[2]:= $1DFAB7AE32FF9C82;
      FHash64[3]:= $679DD514582F9FCF;
      FHash64[4]:= $0F6D2B697BD44DA8;
      FHash64[5]:= $77E36F7304C48942;
      FHash64[6]:= $3F9D85A86A1D36C8;
      FHash64[7]:= $1112E6AD91D692A1;
    end;

    TSHA2Version.SHA512_256:
    begin
      FHash64[0]:= $22312194FC2BF72C;
      FHash64[1]:= $9F555FA3C84C64C2;
      FHash64[2]:= $2393B86B6F53B151;
      FHash64[3]:= $963877195940EABD;
      FHash64[4]:= $96283EE2A88EFFE3;
      FHash64[5]:= $BE5E1E2553863992;
      FHash64[6]:= $2B0199FC2C85B8AA;
      FHash64[7]:= $0EB72DDC81C52CA2;
    end;
  end;
end;

procedure THashSHA2.Reset;
begin
  Initialize(FVersion);
end;

procedure THashSHA2.Update(const AData: PByte; ALength: Cardinal);
var
  PBuffer: PByte;
  I: Integer;
  Count: Integer;
  LBufLen: Cardinal;
  LRest: Integer;
begin
  CheckFinalized;
  PBuffer := AData;
  LBufLen := GetBlockSize;

                                                                                                                           
  Inc(FBitLength, ALength * 8);

  // Code Option A
  Count := (ALength + FIndex) div LBufLen;
  if Count > 0  then
  begin
    LRest := LBufLen - FIndex;
    Move(PBuffer^, FBuffer[FIndex], LRest);
    Inc(PBuffer, LRest);
    Dec(ALength, LRest);
    Compress;
    for I := 1 to Count - 1 do
    begin
      Move(PBuffer^, FBuffer[0], LBufLen);
      Inc(PBuffer, LBufLen);
      Dec(ALength, LBufLen);
      Compress;
    end;
    FIndex := 0;
  end;
  Move(PBuffer^, FBuffer[FIndex], ALength);
  Inc(FIndex, ALength);

//  // Code Option B
//  while ALength > 0 do
//  begin
//    FBuffer[FIndex] := PBuffer^;
//    Inc(PBuffer);
//    Inc(FIndex);
//    Dec(ALength);
//    if FIndex = LBufLen then
//    begin
//      FIndex := 0;
//      Compress;
//    end;
//  end;
end;

procedure THashSHA2.Update(const AData; ALength: Cardinal);
begin
  Update(PByte(@AData), ALength);
end;

procedure THashSHA2.Update(const AData: TBytes; ALength: Cardinal = 0);
var
  Len: Integer;
begin
  if ALength = 0 then
    Len := Length(AData)
  else
    Len := ALength;
  Update(PByte(AData), Len);
end;

function THashSHA2.HashAsBytes: TBytes;
begin
  Result := GetDigest;
end;

function THashSHA2.HashAsString: string;
begin
  Result := THash.DigestAsString(GetDigest);
end;


{ THashBobJenkins }

class function THashBobJenkins.HashLittle(const Data; Len, InitVal: Integer): Integer;
  function Rot(x, k: Cardinal): Cardinal; inline;
  begin
    Result := (x shl k) or (x shr (32 - k));
  end;

  procedure Mix(var a, b, c: Cardinal); inline;
  begin
    Dec(a, c); a := a xor Rot(c, 4); Inc(c, b);
    Dec(b, a); b := b xor Rot(a, 6); Inc(a, c);
    Dec(c, b); c := c xor Rot(b, 8); Inc(b, a);
    Dec(a, c); a := a xor Rot(c,16); Inc(c, b);
    Dec(b, a); b := b xor Rot(a,19); Inc(a, c);
    Dec(c, b); c := c xor Rot(b, 4); Inc(b, a);
  end;

  procedure Final(var a, b, c: Cardinal); inline;
  begin
    c := c xor b; Dec(c, Rot(b,14));
    a := a xor c; Dec(a, Rot(c,11));
    b := b xor a; Dec(b, Rot(a,25));
    c := c xor b; Dec(c, Rot(b,16));
    a := a xor c; Dec(a, Rot(c, 4));
    b := b xor a; Dec(b, Rot(a,14));
    c := c xor b; Dec(c, Rot(b,24));
  end;

{$POINTERMATH ON}
var
  pb: PByte;
  pd: PCardinal absolute pb;
  a, b, c: Cardinal;
label
  case_1, case_2, case_3, case_4, case_5, case_6,
  case_7, case_8, case_9, case_10, case_11, case_12;
begin
  a := Cardinal($DEADBEEF) + Cardinal(Len) + Cardinal(InitVal);
  b := a;
  c := a;

  pb := @Data;

  // 4-byte aligned data
  if (Cardinal(pb) and 3) = 0 then
  begin
    while Len > 12 do
    begin
      Inc(a, pd[0]);
      Inc(b, pd[1]);
      Inc(c, pd[2]);
      Mix(a, b, c);
      Dec(Len, 12);
      Inc(pd, 3);
    end;

    case Len of
      0: Exit(Integer(c));
      1: Inc(a, pd[0] and $FF);
      2: Inc(a, pd[0] and $FFFF);
      3: Inc(a, pd[0] and $FFFFFF);
      4: Inc(a, pd[0]);
      5:
      begin
        Inc(a, pd[0]);
        Inc(b, pd[1] and $FF);
      end;
      6:
      begin
        Inc(a, pd[0]);
        Inc(b, pd[1] and $FFFF);
      end;
      7:
      begin
        Inc(a, pd[0]);
        Inc(b, pd[1] and $FFFFFF);
      end;
      8:
      begin
        Inc(a, pd[0]);
        Inc(b, pd[1]);
      end;
      9:
      begin
        Inc(a, pd[0]);
        Inc(b, pd[1]);
        Inc(c, pd[2] and $FF);
      end;
      10:
      begin
        Inc(a, pd[0]);
        Inc(b, pd[1]);
        Inc(c, pd[2] and $FFFF);
      end;
      11:
      begin
        Inc(a, pd[0]);
        Inc(b, pd[1]);
        Inc(c, pd[2] and $FFFFFF);
      end;
      12:
      begin
        Inc(a, pd[0]);
        Inc(b, pd[1]);
        Inc(c, pd[2]);
      end;
    end;
  end
  else
  begin
    // Ignoring rare case of 2-byte aligned data. This handles all other cases.
    while Len > 12 do
    begin
      Inc(a, pb[0] + pb[1] shl 8 + pb[2] shl 16 + pb[3] shl 24);
      Inc(b, pb[4] + pb[5] shl 8 + pb[6] shl 16 + pb[7] shl 24);
      Inc(c, pb[8] + pb[9] shl 8 + pb[10] shl 16 + pb[11] shl 24);
      Mix(a, b, c);
      Dec(Len, 12);
      Inc(pb, 12);
    end;

    case Len of
      0: Exit(Integer(c));
      1: goto case_1;
      2: goto case_2;
      3: goto case_3;
      4: goto case_4;
      5: goto case_5;
      6: goto case_6;
      7: goto case_7;
      8: goto case_8;
      9: goto case_9;
      10: goto case_10;
      11: goto case_11;
      12: goto case_12;
    end;

case_12:
    Inc(c, pb[11] shl 24);
case_11:
    Inc(c, pb[10] shl 16);
case_10:
    Inc(c, pb[9] shl 8);
case_9:
    Inc(c, pb[8]);
case_8:
    Inc(b, pb[7] shl 24);
case_7:
    Inc(b, pb[6] shl 16);
case_6:
    Inc(b, pb[5] shl 8);
case_5:
    Inc(b, pb[4]);
case_4:
    Inc(a, pb[3] shl 24);
case_3:
    Inc(a, pb[2] shl 16);
case_2:
    Inc(a, pb[1] shl 8);
case_1:
    Inc(a, pb[0]);
  end;

  Final(a, b, c);
  Result := Integer(c);
end;

{$POINTERMATH OFF}

class function THashBobJenkins.Create: THashBobJenkins;
begin
  Result.FHash := 0;
end;

function THashBobJenkins.GetDigest: TBytes;
begin
  SetLength(Result, 4);
  PCardinal(@Result[0])^ := THash.ToBigEndian(Cardinal(FHash));
end;

class function THashBobJenkins.GetHashString(const AString: string): string;
begin
  Result := Integer(GetHashValue(AString)).ToHexString(8);
end;

class function THashBobJenkins.GetHashValue(const AData: string): Integer;
begin
  Result := HashLittle(PChar(AData)^, AData.Length * SizeOf(Char), 0);
end;

class function THashBobJenkins.GetHashValue(const AData; ALength: Integer; AInitialValue: Integer): Integer;
begin
  Result := HashLittle(AData, ALength, AInitialValue);
end;

function THashBobJenkins.HashAsBytes: TBytes;
begin
  Result := GetDigest;
end;

function THashBobJenkins.HashAsInteger: Integer;
begin
  Result := FHash;
end;

function THashBobJenkins.HashAsString: string;
begin
  Result := FHash.ToHexString(8);
end;

class function THashBobJenkins.GetHashBytes(const AData: string): TBytes;
var
  LHash: Integer;
begin
  SetLength(Result, 4);
  LHash := HashLittle(PChar(AData)^, AData.Length * SizeOf(Char), 0);
  PCardinal(@Result[0])^ := THash.ToBigEndian(Cardinal(LHash));
end;

procedure THashBobJenkins.Reset(AInitialValue: Integer);
begin
  FHash := AInitialValue;
end;

procedure THashBobJenkins.Update(const Input: string);
begin
  FHash := HashLittle(PChar(Input)^, Input.Length * SizeOf(Char), FHash);
end;

procedure THashBobJenkins.Update(const AData; ALength: Cardinal);
begin
  FHash := HashLittle(AData, ALength, FHash);
end;

procedure THashBobJenkins.Update(const AData: TBytes; ALength: Cardinal);
begin
  if ALength = 0 then
    ALength := Length(Adata);
  FHash := HashLittle(PByte(AData)^, ALength, FHash);
end;

{ THash }

class function THash.DigestAsInteger(const ADigest: TBytes): Integer;
begin
  if Length(ADigest) <> 4 then
    raise EHashException.Create('Digest size must be 4 to Generate a Integer');
  Result := PInteger(@ADigest[0])^;
end;

class function THash.DigestAsString(const ADigest: TBytes): string;
const
  XD: array[0..15] of char = ('0', '1', '2', '3', '4', '5', '6', '7',
                              '8', '9', 'a', 'b', 'c', 'd', 'e', 'f');
var
  I: Integer;
begin
  Result := '';
  for I := 0 to Length(ADigest) - 1 do
    Result := Result + XD[(ADigest[I] shr 4) and $0f] + XD[ADigest[I] and $0f];
end;

class function THash.DigestAsStringGUID(const ADigest: TBytes): string;
var
  LGUID: TGUID;
begin
  LGUID := TGUID.Create(ADigest);
  LGUID.D1 := ToBigEndian(LGUID.D1);
  LGUID.D2 := Word((WordRec(LGUID.D2).Lo shl 8) or WordRec(LGUID.D2).Hi);
  LGUID.D3 := Word((WordRec(LGUID.D3).Lo shl 8) or WordRec(LGUID.D3).Hi);
  Result := LGUID.ToString;
end;

class function THash.GetRandomString(const ALen: Integer): string;
const
  ValidChars = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz+-/*_';
var
  I: Integer;
begin
  Result := '';
  for I := 1 to ALen do
    Result := Result + ValidChars[Random(ValidChars.Length) + Low(string)];
end;

class function THash.ToBigEndian(AValue: UInt64): UInt64;
begin
  Result := UInt64(ToBigEndian(Cardinal(AValue))) shl 32 or ToBigEndian(Cardinal(AValue shr 32));
end;

class function THash.ToBigEndian(AValue: Cardinal): Cardinal;
begin
  Result := (AValue shr 24) or (AValue shl 24) or ((AValue shr 8) and $FF00) or ((AValue shl 8) and $FF0000);
end;

end.
