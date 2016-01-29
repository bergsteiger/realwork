{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Soap.EncdDecd;

interface

uses System.Classes, System.SysUtils;

procedure EncodeStream(Input, Output: TStream);
procedure DecodeStream(Input, Output: TStream);
function  EncodeString(const Input: string): string;
function  DecodeString(const Input: string): string;

{$IFDEF NEXTGEN}
function  DecodeBase64(const Input: string): TBytes;
function  EncodeBase64(const Input: Pointer; Size: Integer): string;
{$ELSE !NEXTGEN}
function  DecodeBase64(const Input: AnsiString): TBytes;
function  EncodeBase64(const Input: Pointer; Size: Integer): AnsiString;
{$ENDIF NEXTGEN}

implementation

uses System.RTLConsts;

const
{$IFDEF NEXTGEN}
  EncodeTable: array[0..63] of Byte = (
    Ord('A'),Ord('B'),Ord('C'),Ord('D'),Ord('E'),Ord('F'),Ord('G'),Ord('H'),Ord('I'),
    Ord('J'),Ord('K'),Ord('L'),Ord('M'),Ord('N'),Ord('O'),Ord('P'),Ord('Q'),Ord('R'),
    Ord('S'),Ord('T'),Ord('U'),Ord('V'),Ord('W'),Ord('X'),Ord('Y'),Ord('Z'),
    Ord('a'),Ord('b'),Ord('c'),Ord('d'),Ord('e'),Ord('f'),Ord('g'),Ord('h'),Ord('i'),
    Ord('j'),Ord('k'),Ord('l'),Ord('m'),Ord('n'),Ord('o'),Ord('p'),Ord('q'),Ord('r'),
    Ord('s'),Ord('t'),Ord('u'),Ord('v'),Ord('w'),Ord('x'),Ord('y'),Ord('z'),
    Ord('0'),Ord('1'),Ord('2'),Ord('3'),Ord('4'),Ord('5'),Ord('6'),Ord('7'),Ord('8'),Ord('9'),Ord('+'),Ord('/'));
{$ELSE !NEXTGEN}
  EncodeTable: array[0..63] of AnsiChar =
    AnsiString('ABCDEFGHIJKLMNOPQRSTUVWXYZ') +
    AnsiString('abcdefghijklmnopqrstuvwxyz') +
    AnsiString('0123456789+/');
{$ENDIF NEXTGEN}

{$IFDEF NEXTGEN}
  DecodeTable: array[Ord(#0)..Ord(#127)] of Integer = (
{$ELSE !NEXTGEN}
  DecodeTable: array[#0..#127] of Integer = (
{$ENDIF NEXTGEN}
    Byte('='), 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64,
           64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64,
           64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 62, 64, 64, 64, 63,
           52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 64, 64, 64, 64, 64, 64,
           64,  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14,
           15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 64, 64, 64, 64, 64,
           64, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
           41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 64, 64, 64, 64, 64);

type
  PPacket = ^TPacket;
  TPacket = packed record
    case Integer of
      0: (b0, b1, b2, b3: Byte);
      1: (i: Integer);
      2: (a: array[0..3] of Byte);
{$IFNDEF NEXTGEN}
      3: (c: array[0..3] of AnsiChar);
{$ENDIF !NEXTGEN}
  end;

  TPointerStream = class(TCustomMemoryStream)
  public
    constructor Create(P: Pointer; Size: Integer);
    function Write(const Buffer; Count: Longint): Longint; override;
  end;

{$IFDEF NEXTGEN}
procedure EncodePacket(const Packet: TPacket; NumChars: Integer; OutBuf: PByte);
{$ELSE !NEXTGEN}
procedure EncodePacket(const Packet: TPacket; NumChars: Integer; OutBuf: PAnsiChar);
{$ENDIF NEXTGEN}
begin
  OutBuf[0] := EnCodeTable[Packet.a[0] shr 2];
  OutBuf[1] := EnCodeTable[((Packet.a[0] shl 4) or (Packet.a[1] shr 4)) and $0000003f];
  if NumChars < 2 then
{$IFDEF NEXTGEN}
    OutBuf[2] := Ord('=')
{$ELSE !NEXTGEN}
    OutBuf[2] := '='
{$ENDIF NEXTGEN}
  else OutBuf[2] := EnCodeTable[((Packet.a[1] shl 2) or (Packet.a[2] shr 6)) and $0000003f];
  if NumChars < 3 then
{$IFDEF NEXTGEN}
    OutBuf[3] := Ord('=')
{$ELSE !NEXTGEN}
    OutBuf[3] := '='
{$ENDIF NEXTGEN}
  else OutBuf[3] := EnCodeTable[Packet.a[2] and $0000003f];
end;

{$IFDEF NEXTGEN}
function DecodePacket(InBuf: PByte; var nChars: Integer): TPacket;
begin
  Result.a[0] := (DecodeTable[InBuf[0]] shl 2) or
    (DecodeTable[InBuf[1]] shr 4);
  NChars := 1;
  if InBuf[2] <> Ord('=') then
  begin
    Inc(NChars);
    Result.a[1] := Byte((DecodeTable[InBuf[1]] shl 4) or (DecodeTable[InBuf[2]] shr 2));
  end;
  if InBuf[3] <> Ord('=') then
  begin
    Inc(NChars);
    Result.a[2] := Byte((DecodeTable[InBuf[2]] shl 6) or DecodeTable[InBuf[3]]);
  end;
end;
{$ELSE !NEXTGEN}
function DecodePacket(InBuf: PAnsiChar; var nChars: Integer): TPacket;
begin
  Result.a[0] := (DecodeTable[InBuf[0]] shl 2) or
    (DecodeTable[InBuf[1]] shr 4);
  NChars := 1;
  if InBuf[2] <> '=' then
  begin
    Inc(NChars);
    Result.a[1] := Byte((DecodeTable[InBuf[1]] shl 4) or (DecodeTable[InBuf[2]] shr 2));
  end;
  if InBuf[3] <> '=' then
  begin
    Inc(NChars);
    Result.a[2] := Byte((DecodeTable[InBuf[2]] shl 6) or DecodeTable[InBuf[3]]);
  end;
end;
{$ENDIF NEXTGEN}

procedure EncodeStream(Input, Output: TStream);
type
  PInteger = ^Integer;
var
  InBuf: array[0..509] of Byte;
{$IFDEF NEXTGEN}
  OutBuf: array[0..1023] of Byte;
  BufPtr: PByte;
{$ELSE !NEXTGEN}
  OutBuf: array[0..1023] of AnsiChar;
  BufPtr: PAnsiChar;
{$ENDIF NEXTGEN}
  I, J, K, BytesRead: Integer;
  Packet: TPacket;
begin
  K := 0;
  repeat
    BytesRead := Input.Read(InBuf, SizeOf(InBuf));
    I := 0;
{$IFDEF NEXTGEN}
    BufPtr := @OutBuf[0];
{$ELSE !NEXTGEN}
    BufPtr := OutBuf;
{$ENDIF NEXTGEN}
    while I < BytesRead do
    begin
      if BytesRead - I < 3 then
        J := BytesRead - I
      else J := 3;
      Packet.i := 0;
      Packet.b0 := InBuf[I];
      if J > 1 then
        Packet.b1 := InBuf[I + 1];
      if J > 2 then
        Packet.b2 := InBuf[I + 2];
      EncodePacket(Packet, J, BufPtr);
      Inc(I, 3);
      Inc(BufPtr, 4);
      Inc(K, 4);
      if K > 75 then
      begin
{$IFDEF NEXTGEN}
        BufPtr[0] := $0D;
        BufPtr[1] := $0A;
{$ELSE !NEXTGEN}
        BufPtr[0] := #$0D;
        BufPtr[1] := #$0A;
{$ENDIF NEXTGEN}
        Inc(BufPtr, 2);
        K := 0;
      end;
    end;
    Output.Write(Outbuf, BufPtr - PChar(@OutBuf));
  until BytesRead = 0;
end;

procedure DecodeStream(Input, Output: TStream);
var
{$IFDEF NEXTGEN}
  InBuf: array[0..75] of Byte;
  OutBuf: array[0..60] of Byte;
  InBufPtr, OutBufPtr: PByte;
{$ELSE !NEXTGEN}
  InBuf: array[0..75] of AnsiChar;
  OutBuf: array[0..60] of Byte;
  InBufPtr, OutBufPtr: PAnsiChar;
{$ENDIF NEXTGEN}
  I, J, K, BytesRead: Integer;
  Packet: TPacket;

  procedure SkipWhite;
  var
    C: Byte;
    NumRead: Integer;
  begin
    while True do
    begin
      NumRead := Input.Read(C, 1);
      if NumRead = 1 then
      begin
        if C in [Ord('0')..Ord('9'),Ord('A')..Ord('Z'),Ord('a')..Ord('z'),Ord('+'),Ord('/'),Ord('=')] then
        begin
          Input.Position := Input.Position - 1;
          Break;
        end;
      end else Break;
    end;
  end;

  function ReadInput: Integer;
  var
    WhiteFound, EndReached : Boolean;
    CntRead, Idx, IdxEnd: Integer;
  begin
    IdxEnd:= 0;
    repeat
      WhiteFound := False;
      CntRead := Input.Read(InBuf[IdxEnd], (SizeOf(InBuf)-IdxEnd));
      EndReached := CntRead < (SizeOf(InBuf)-IdxEnd);
      Idx := IdxEnd;
      IdxEnd := CntRead + IdxEnd;
      while (Idx < IdxEnd) do
      begin
        if not (Byte(InBuf[Idx]) in [Ord('0')..Ord('9'),Ord('A')..Ord('Z'),Ord('a')..Ord('z'),Ord('+'),Ord('/'),Ord('=')]) then
        begin
          Dec(IdxEnd);
          if Idx < IdxEnd then
            Move(InBuf[Idx+1], InBuf[Idx], IdxEnd-Idx);
          WhiteFound := True;
        end
        else
          Inc(Idx);
      end;
    until (not WhiteFound) or (EndReached);
    Result := IdxEnd;
  end;

begin
  repeat
    SkipWhite;
    BytesRead := ReadInput;
    InBufPtr := @InBuf[0];
    OutBufPtr := @OutBuf;
    I := 0;
    while I < BytesRead do
    begin
      Packet := DecodePacket(InBufPtr, J);
      K := 0;
      while J > 0 do
      begin
{$IFDEF NEXTGEN}
        OutBufPtr^ := Packet.a[K];
{$ELSE !NEXTGEN}
        OutBufPtr^ := AnsiChar(Packet.a[K]);
{$ENDIF NEXTGEN}
        Inc(OutBufPtr);
        Dec(J);
        Inc(K);
      end;
      Inc(InBufPtr, 4);
      Inc(I, 4);
    end;
{$IFDEF NEXTGEN}
    Output.Write(OutBuf, OutBufPtr - PByte(@OutBuf[0]));
{$ELSE !NEXTGEN}
    Output.Write(OutBuf, OutBufPtr - PAnsiChar(@OutBuf));
{$ENDIF NEXTGEN}
  until BytesRead = 0;
end;

function EncodeString(const Input: string): string;
var
  InStr, OutStr: TStringStream;
begin
  InStr := TStringStream.Create(Input);
  try
    OutStr := TStringStream.Create('');
    try
      EncodeStream(InStr, OutStr);
      Result := OutStr.DataString;
    finally
      OutStr.Free;
    end;
  finally
    InStr.Free;
  end;
end;

function DecodeString(const Input: string): string;
var
  InStr, OutStr: TStringStream;
begin
  InStr := TStringStream.Create(Input);
  try
    OutStr := TStringStream.Create('');
    try
      DecodeStream(InStr, OutStr);
      Result := OutStr.DataString;
    finally
      OutStr.Free;
    end;
  finally
    InStr.Free;
  end;
end;

constructor TPointerStream.Create(P: Pointer; Size: Integer);
begin
  SetPointer(P, Size);
end;

function TPointerStream.Write(const Buffer; Count: Longint): Longint;
var
  Pos, EndPos, Size: Longint;
  Mem: Pointer;
begin
  Pos := Self.Position;

  if (Pos >= 0) and (Count > 0) then
  begin
    EndPos := Pos + Count;
    Size:= Self.Size;
    if EndPos > Size then
      raise EStreamError.CreateRes(@SMemoryStreamError);

    Mem := Self.Memory;
    System.Move(Buffer, Pointer(Longint(Mem) + Pos)^, Count);
    Self.Position := Pos;
    Result := Count;
    Exit;
  end;
  Result := 0;
end;

{$IFDEF NEXTGEN}
function DecodeBase64(const Input: string): TBytes;
{$ELSE !NEXTGEN}
function DecodeBase64(const Input: AnsiString): TBytes;
{$ENDIF NEXTGEN}
var
  InStr: TPointerStream;
  OutStr: TBytesStream;
  Len: Integer;
{$IFDEF NEXTGEN}
  M: TMarshaller;
{$ENDIF NEXTGEN}
begin
{$IFDEF NEXTGEN}
  InStr := TPointerStream.Create(M.AsAnsi(PWideChar(Input)).ToPointer, Length(Input));
{$ELSE !NEXTGEN}
  InStr := TPointerStream.Create(PAnsiChar(Input), Length(Input));
{$ENDIF NEXTGEN}
  try
    OutStr := TBytesStream.Create;
    try
      DecodeStream(InStr, OutStr);
      Result := OutStr.Bytes;
      Len := OutStr.Size;
    finally
      OutStr.Free;
    end;
  finally
    InStr.Free;
  end;
  SetLength(Result, Len);
end;

{$IFDEF NEXTGEN}
function EncodeBase64(const Input: Pointer; Size: Integer): string;
{$ELSE !NEXTGEN}
function EncodeBase64(const Input: Pointer; Size: Integer): AnsiString;
{$ENDIF NEXTGEN}
var
  InStr: TPointerStream;
  OutStr: TBytesStream;
begin
  InStr := TPointerStream.Create(Input, Size);
  try
    OutStr := TBytesStream.Create;
    try
      EncodeStream(InStr, OutStr);
{$IFDEF NEXTGEN}
      SetString(Result, MarshaledAString(OutStr.Memory), OutStr.Size);
{$ELSE !NEXTGEN}
      SetString(Result, PAnsiChar(OutStr.Memory), OutStr.Size);
{$ENDIF NEXTGEN}
    finally
      OutStr.Free;
    end;
  finally
    InStr.Free;
  end;
end;


end.
