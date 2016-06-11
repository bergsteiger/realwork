{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{       Message-digest algorithm based on C sample      }
{       provided in Appendix section of                 }
{          Rivest-MD5.TXT available at:                 }
{     http://theory.lcs.mit.edu/~rivest/Rivest-MD5.txt  }
{                                                       }
{*******************************************************}
unit MessageDigest_5;

interface

uses Types;

type

  IMD5 = interface
  ['{887C9EF0-15B9-41B4-A403-0431793B6E41}']
    procedure   Init;
    procedure   Update(const Input: TByteDynArray; Len: Longword); overload;
    procedure   Update(const Input: string); overload;
    function    Final: TByteDynArray;
    function    AsString: string;
    function    AsGUID: string;
  end;

function GetMD5: IMD5;

implementation

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
  padding: TByteDynArray;

type

  ArrayOfLWord= array of Longword;

  TMD5 = class(TInterfacedObject, IMD5)
  private
    FContextState: ArrayOfLWord;
    FContextCount: ArrayOfLWord;
    FContextBuffer: TByteDynArray;
  public
    constructor Create;
    procedure   Init; virtual;
    procedure   Update(const Input: TByteDynArray; Len: Longword); overload; virtual;
    procedure   Update(const Input: string); overload; virtual;
    function    Final: TByteDynArray; virtual;
    procedure   Transform(const block: TByteDynArray; shift: Integer);
    procedure   Decode(var Dst: ArrayOfLWord; const Src: TByteDynArray; Len: Integer; shift: Integer);
    procedure   Encode(var Dst: TByteDynArray; const Src: ArrayOfLWord; Len: Integer);
    function    AsString: string;
    function    AsGUID: string;
  end;

function GetMD5: IMD5;
begin
  Result := TMD5.Create;
end;

constructor TMD5.Create;
begin
  inherited Create;
  Init;
end;

procedure TMD5.Init;
begin
  SetLength(FContextCount, 2);
  FContextCount[0] := 0;
  FContextCount[1] := 0;
  SetLength(FContextState, 4);
  FContextState[0] := $67452301;
  FContextState[1] := $efcdab89;
  FContextState[2] := $98badcfe;
  FContextState[3] := $10325476;
  SetLength(FContextBuffer, 64);
end;

procedure TMD5.Update(const Input: string);
var
{$IFDEF UNICODE}
  utf8Str: UTF8String;
{$ENDIF}
  Bytes: TByteDynArray;
  Len: Integer;
  Str: PAnsiChar;
begin
{$IFDEF UNICODE}
  utf8Str := UTF8Encode(Input);
  Len := Length(utf8Str);
{$ELSE}
  Len := Length(Input);
{$ENDIF}
  if Len > 0 then
  begin
    SetLength(Bytes, Len);
{$IFDEF UNICODE}
    Str := PAnsiChar(utf8Str);
{$ELSE}
    Str := PAnsiChar(Input);
{$ENDIF}
    Move(Str^, Pointer(Bytes)^, Len);
    Update(Bytes, Len);
  end;
end;

procedure TMD5.Update(const Input: TByteDynArray; Len: Longword);
var
  index, partlen, I, start: Longword;
begin
  { Compute number of bytes mod 64 }
  index := (FContextCount[0] shr 3) and $3f;
  { Update number of bits }
  Inc(FContextCount[0], Len shl 3);
  if (FContextCount[0] < (Len shl 3)) then
    Inc(FContextCount[1]);
  Inc(FContextCount[1], Len shr 29);
  partlen := 64 - index;

  { Transform (as many times as possible) }
  if Len >= partLen then
  begin
    for I := 0 to partLen-1 do
      FContextBuffer[I+index] := Input[I];

    Transform(FContextBuffer, 0);
    I := partLen;
    while (I + 63) < Len do
    begin
      Transform(Input, I);
      Inc(I, 64);
    end;
    index := 0;
  end
  else
    I := 0;

  { Input remaining input }
  if (I < Len) then
  begin
    start := I;
    while (I < Len) do
    begin
      FContextBuffer[index+I-start] := Input[I];
      Inc(I);
    end;
  end;
end;

function TMD5.Final: TByteDynArray;
var
  bits: TByteDynArray;
  index, padlen: Integer;
begin
  { Save number of bits }
  Encode(bits, FContextCount, 8);
  { Pad out to 56 mod 64 }
  index := (FContextCount[0] shr 3) and $3f;
  if index < 56 then
    padlen := 56 - index
  else
    padlen := 120- index;

  Update(padding, padLen);
  { Append length (before padding) }
  Update(bits, 8);
  { Store state in digest }
  Encode(Result, FContextState, 16);
end;

function TMD5.AsString: string;
const
  XD: array[0..15] of char = ('0', '1', '2', '3', '4', '5', '6', '7',
                              '8', '9', 'A', 'B', 'C', 'D', 'E', 'F');
var
  digest: TByteDynArray;
  I: Integer;
begin
  Result := '';
  digest := Final;
  for I := 0 to Length(digest)-1 do
    Result := Result + XD[(digest[I] shr 4) and $0f] +
                       XD[digest[I] and $0f];
end;

function TMD5.AsGUID: string;
const
  XD: array[0..15] of char = ('0', '1', '2', '3', '4', '5', '6', '7',
                              '8', '9', 'A', 'B', 'C', 'D', 'E', 'F');
var
  digest: TByteDynArray;
  I: Integer;
begin
  Result := '';
  digest := Final;
  for I := 0 to Length(digest)-1 do
  begin
    case I of
      0:            Result := Result + '{';
      4, 6, 8, 10:  Result := Result + '-';
    end;
    Result := Result + XD[(digest[I] shr 4) and $0f] +
                       XD[digest[I] and $0f];
    if I = 15 then
      Result := Result + '}';
  end;
end;

procedure TMD5.Transform(const block: TByteDynArray; shift: Integer);

  function F(x, y, z: Longword): Longword;
  begin
    Result := (x and y) or ((not x) and z);
  end;

  function G(x, y, z: Longword): Longword;
  begin
    Result := (x and z) or (y and (not z));
  end;

  function H(x, y, z: Longword): Longword;
  begin
    Result := x xor y xor z;
  end;

  function I(x, y, z: Longword): Longword;
  begin
    Result := y xor (x or (not z));
  end;

  procedure RL(var x: Longword; n: Byte);
  begin
    x := (x shl n) or (x shr (32 - n));
  end;

  procedure FF(var a: Longword; b, c, d, x: Longword; s: Byte; ac: Longword);
  begin
    Inc(a, F(b, c, d) + x + ac);
    RL(a, s);
    Inc(a, b);
  end;

  procedure GG(var a: Longword; b, c, d, x: Longword; s: Byte; ac: Longword);
  begin
    Inc(a, G(b, c, d) + x + ac);
    RL(a, s);
    Inc(a, b);
  end;

  procedure HH(var a: Longword; b, c, d, x: Longword; s: Byte; ac: Longword);
  begin
    Inc(a, H(b, c, d) + x + ac);
    RL(a, s);
    Inc(a, b);
  end;

  procedure II(var a: Longword; b, c, d, x: Longword; s: Byte; ac: Longword);
  begin
    Inc(a, I(b, c, d) + x + ac);
    RL(a, s);
    Inc(a, b);
  end;

var
  a, b, c, d: Longword;
  x: ArrayOfLWord;

begin
  a := FContextState[0];
  b := FContextState[1];
  c := FContextState[2];
  d := FContextState[3];

  Decode(x, block, 64, shift);

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

procedure TMD5.Encode(var Dst: TByteDynArray; const Src: ArrayOfLWord; Len: Integer);
var
  i, j: Integer;
begin
  i := 0;
  j := 0;
  SetLength(Dst, Len);
  while (j < Len) do
  begin
    Dst[j]  := Byte((Src[i] and $ff));
    Dst[j+1]:= Byte((Src[i] shr 8)  and $ff);
    Dst[j+2]:= Byte((Src[i] shr 16) and $ff);
    Dst[J+3]:= Byte((Src[i] shr 24) and $ff);
    Inc(j, 4);
    Inc(i);
  end;
end;


procedure TMD5.Decode(var Dst: ArrayOfLWord; const Src: TByteDynArray; Len: Integer; shift: Integer);
var
  I, J: Integer;
  a, b, c, d: Byte;
begin
  J := 0;
  I := 0;
  SetLength(Dst, 16);
  while (J < Len) do
  begin
    a := Src[J+shift];
    b := Src[J+shift+1];
    c := Src[J+shift+2];
    d := Src[J+shift+3];
    Dst[I] :=Longword(a and $ff)         or
            (Longword(b and $ff) shl 8)  or
            (Longword(c and $ff) shl 16) or
            (Longword(d and $ff) shl 24);
    Inc(J, 4);
    Inc(I);
  end;
end;

initialization
  SetLength(padding, 64);
  padding[0] := $80;

{
MD5 test suite:
MD5 ("") = d41d8cd98f00b204e9800998ecf8427e
MD5 ("a") = 0cc175b9c0f1b6a831c399e269772661
MD5 ("abc") = 900150983cd24fb0d6963f7d28e17f72
MD5 ("message digest") = f96b697d7cb7938d525a2f31aaf161d0
MD5 ("abcdefghijklmnopqrstuvwxyz") = c3fcd3d76192e4007dfb496cca67e13b
MD5 ("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789") =
d174ab98d277d9f5a5611c2c9f419d9f
MD5 ("123456789012345678901234567890123456789012345678901234567890123456
78901234567890") = 57edf4a22be3c955ac49da2e2107b67a
}

end.

