unit gtHash;

interface

uses
  Classes, Windows, gtClasses3;

type
  MD5Count = array[0..1] of DWORD;
	MD5State = array[0..3] of DWORD;
	MD5Block = array[0..15] of DWORD;
	MD5CBits = array[0..7] of Byte;
	MD5Digest = array[0..15] of Byte;
	MD5Buffer = array[0..63] of Byte;
	MD5Context = record
		State: MD5State;
		Count: MD5Count;
		Buffer: MD5Buffer;
	end;

  TgtMD5Hash = class
  private
    FContext: MD5Context;
    FBufferPad: MD5Buffer;
    procedure Transform(ABuffer: Pointer; var AState: MD5State);
    function F(AX, AY, AZ: DWORD): DWORD;
    procedure FF(var AA: DWORD; AB, AC, AD, AX: DWORD; AByte: BYTE;
      ADWord: DWORD);
    function G(AX, AY, AZ: DWORD): DWORD;
    procedure GG(var AA: DWORD; AB, AC, AD, AX: DWORD; AByte: BYTE;
      ADWord: DWORD);
    function H(AX, AY, AZ: DWORD): DWORD;
    procedure HH(var AA: DWORD; AB, AC, AD, AX: DWORD; AByte: BYTE;
      ADWord: DWORD);
    function I(AX, AY, AZ: DWORD): DWORD;
    procedure II(var AA: DWORD; AB, AC, AD, AX: DWORD; AByte: BYTE;
      ADWord: DWORD);
    procedure Rot(var AX: DWORD; AN: BYTE);
    procedure Decode(ASource, ATarget: Pointer; ACount: Longword);
    procedure Encode(ASource, ATarget: Pointer; ACount: Longword);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Initilize;
    procedure Update(AInput: Pointer; ALength: LongWord); overload;
    function Finalize: MD5Digest;
    class function GetHash(AInput: TgtByteArray; ALength: LongWord): MD5Digest; overload;
    class function GetHash(AInput: TStream): MD5Digest; overload;
  end;

implementation

{ TgtMD5Hash }

constructor TgtMD5Hash.Create;
var
  LI: Integer;
begin
  for LI := 0 to 63 do
    FBufferPad[LI] := $00;
	FBufferPad[0] := $80;
  Initilize;
end;

procedure TgtMD5Hash.Encode(ASource, ATarget: Pointer; ACount: Longword);
var
	S: PByte;
	T: PDWORD;
	I: Longword;
begin
	S := ASource;
	T := ATarget;
	for I := 1 to ACount div 4 do
  begin
		T^ := S^;
		Inc(S);
		T^ := T^ or (S^ shl 8);
		Inc(S);
		T^ := T^ or (S^ shl 16);
		Inc(S);
		T^ := T^ or (S^ shl 24);
		Inc(S);
		Inc(T);
	end;
end;

{------------------------------------------------------------------------------}

// Decode Count DWORDs at Source into (Count * 4) Bytes at Target
procedure TgtMD5Hash.Decode(ASource, ATarget: Pointer; ACount: Longword);
var
	S: PDWORD;
	T: PByte;
	I: Longword;
begin
	S := ASource;
	T := ATarget;
	for I := 1 to ACount do
  begin
		T^ := S^ and $ff;
		Inc(T);
		T^ := (S^ shr 8) and $ff;
		Inc(T);
		T^ := (S^ shr 16) and $ff;
		Inc(T);
		T^ := (S^ shr 24) and $ff;
		Inc(T);
		Inc(S);
	end;
end;

function TgtMD5Hash.Finalize: MD5Digest;
var
	Bits: MD5CBits;
	Index: Longword;
	PadLen: Longword;
begin
	Decode(@FContext.Count, @Bits, 2);
	Index := (FContext.Count[0] shr 3) and $3f;
	if Index < 56 then
    PadLen := 56 - Index
  else
    PadLen := 120 - Index;
	Update(@FBufferPad[0], PadLen);
	Update(@Bits[0], 8);
	Decode(@FContext.State, @Result, 4);
	ZeroMemory(@FContext, SizeOf(MD5Context));
end;

class function TgtMD5Hash.GetHash(AInput: TgtByteArray;
  ALength: LongWord): MD5Digest;
var
  LMD5: TgtMD5Hash;
begin
  LMD5 := TgtMD5Hash.Create;
  try
    LMD5.Update(AInput, ALength);
    Result := LMD5.Finalize;
  finally
    LMD5.Free;
  end;
end;

function TgtMD5Hash.F(AX, AY, AZ: DWORD): DWORD;
begin
	Result := (AX and AY) or ((not AX) and AZ);
end;

function TgtMD5Hash.G(AX, AY, AZ: DWORD): DWORD;
begin
	Result := (AX and AZ) or (AY and (not AZ));
end;

function TgtMD5Hash.H(AX, AY, AZ: DWORD): DWORD;
begin
	Result := AX xor AY xor AZ;
end;

function TgtMD5Hash.I(AX, AY, AZ: DWORD): DWORD;
begin
	Result := AY xor (AX or (not AZ));
end;

procedure TgtMD5Hash.Rot(var AX: DWORD; AN: BYTE);
begin
	AX := (AX shl AN) or (AX shr (32 - AN));
end;

procedure TgtMD5Hash.FF(var AA: DWORD; AB, AC, AD, AX: DWORD; AByte: BYTE; ADWord: DWORD);
begin
	Inc(AA, F(AB, AC, AD) + AX + ADWord);
	Rot(AA, AByte);
	Inc(AA, AB);
end;

procedure TgtMD5Hash.GG(var AA: DWORD; AB, AC, AD, AX: DWORD; AByte: BYTE; ADWord: DWORD);
begin
	Inc(AA, G(AB, AC, AD) + AX + ADWord);
	Rot(AA, AByte);
	Inc(AA, AB);
end;

procedure TgtMD5Hash.HH(var AA: DWORD; AB, AC, AD, AX: DWORD; AByte: BYTE; ADWord: DWORD);
begin
	Inc(AA, H(AB, AC, AD) + AX + ADWord);
	Rot(AA, AByte);
	Inc(AA, AB);
end;

procedure TgtMD5Hash.II(var AA: DWORD; AB, AC, AD, AX: DWORD; AByte: BYTE; ADWord: DWORD);
begin
	Inc(AA, I(AB, AC, AD) + AX + ADWord);
	Rot(AA, AByte);
	Inc(AA, AB);
end;

procedure TgtMD5Hash.Initilize;
begin
	with FContext do begin
		State[0] := $67452301;
		State[1] := $efcdab89;
		State[2] := $98badcfe;
		State[3] := $10325476;
		Count[0] := 0;
		Count[1] := 0;
		ZeroMemory(@Buffer, SizeOf(MD5Buffer));
	end;
end;

procedure TgtMD5Hash.Transform(ABuffer: Pointer; var AState: MD5State);
var
	A, B, C, D: DWORD;
	Block: MD5Block;
begin
	Encode(ABuffer, @Block, 64);
	A := AState[0];
	B := AState[1];
	C := AState[2];
	D := AState[3];
	FF (A, B, C, D, Block[ 0],  7, $d76aa478);
	FF (D, A, B, C, Block[ 1], 12, $e8c7b756);
	FF (C, D, A, B, Block[ 2], 17, $242070db);
	FF (B, C, D, A, Block[ 3], 22, $c1bdceee);
	FF (A, B, C, D, Block[ 4],  7, $f57c0faf);
	FF (D, A, B, C, Block[ 5], 12, $4787c62a);
	FF (C, D, A, B, Block[ 6], 17, $a8304613);
	FF (B, C, D, A, Block[ 7], 22, $fd469501);
	FF (A, B, C, D, Block[ 8],  7, $698098d8);
	FF (D, A, B, C, Block[ 9], 12, $8b44f7af);
	FF (C, D, A, B, Block[10], 17, $ffff5bb1);
	FF (B, C, D, A, Block[11], 22, $895cd7be);
	FF (A, B, C, D, Block[12],  7, $6b901122);
	FF (D, A, B, C, Block[13], 12, $fd987193);
	FF (C, D, A, B, Block[14], 17, $a679438e);
	FF (B, C, D, A, Block[15], 22, $49b40821);
	GG (A, B, C, D, Block[ 1],  5, $f61e2562);
	GG (D, A, B, C, Block[ 6],  9, $c040b340);
	GG (C, D, A, B, Block[11], 14, $265e5a51);
	GG (B, C, D, A, Block[ 0], 20, $e9b6c7aa);
	GG (A, B, C, D, Block[ 5],  5, $d62f105d);
	GG (D, A, B, C, Block[10],  9,  $2441453);
	GG (C, D, A, B, Block[15], 14, $d8a1e681);
	GG (B, C, D, A, Block[ 4], 20, $e7d3fbc8);
	GG (A, B, C, D, Block[ 9],  5, $21e1cde6);
	GG (D, A, B, C, Block[14],  9, $c33707d6);
	GG (C, D, A, B, Block[ 3], 14, $f4d50d87);
	GG (B, C, D, A, Block[ 8], 20, $455a14ed);
	GG (A, B, C, D, Block[13],  5, $a9e3e905);
	GG (D, A, B, C, Block[ 2],  9, $fcefa3f8);
	GG (C, D, A, B, Block[ 7], 14, $676f02d9);
	GG (B, C, D, A, Block[12], 20, $8d2a4c8a);
	HH (A, B, C, D, Block[ 5],  4, $fffa3942);
	HH (D, A, B, C, Block[ 8], 11, $8771f681);
	HH (C, D, A, B, Block[11], 16, $6d9d6122);
	HH (B, C, D, A, Block[14], 23, $fde5380c);
	HH (A, B, C, D, Block[ 1],  4, $a4beea44);
	HH (D, A, B, C, Block[ 4], 11, $4bdecfa9);
	HH (C, D, A, B, Block[ 7], 16, $f6bb4b60);
	HH (B, C, D, A, Block[10], 23, $bebfbc70);
	HH (A, B, C, D, Block[13],  4, $289b7ec6);
	HH (D, A, B, C, Block[ 0], 11, $eaa127fa);
	HH (C, D, A, B, Block[ 3], 16, $d4ef3085);
	HH (B, C, D, A, Block[ 6], 23,  $4881d05);
	HH (A, B, C, D, Block[ 9],  4, $d9d4d039);
	HH (D, A, B, C, Block[12], 11, $e6db99e5);
	HH (C, D, A, B, Block[15], 16, $1fa27cf8);
	HH (B, C, D, A, Block[ 2], 23, $c4ac5665);
	II (A, B, C, D, Block[ 0],  6, $f4292244);
	II (D, A, B, C, Block[ 7], 10, $432aff97);
	II (C, D, A, B, Block[14], 15, $ab9423a7);
	II (B, C, D, A, Block[ 5], 21, $fc93a039);
	II (A, B, C, D, Block[12],  6, $655b59c3);
	II (D, A, B, C, Block[ 3], 10, $8f0ccc92);
	II (C, D, A, B, Block[10], 15, $ffeff47d);
	II (B, C, D, A, Block[ 1], 21, $85845dd1);
	II (A, B, C, D, Block[ 8],  6, $6fa87e4f);
	II (D, A, B, C, Block[15], 10, $fe2ce6e0);
	II (C, D, A, B, Block[ 6], 15, $a3014314);
	II (B, C, D, A, Block[13], 21, $4e0811a1);
	II (A, B, C, D, Block[ 4],  6, $f7537e82);
	II (D, A, B, C, Block[11], 10, $bd3af235);
	II (C, D, A, B, Block[ 2], 15, $2ad7d2bb);
	II (B, C, D, A, Block[ 9], 21, $eb86d391);
	Inc(AState[0], A);
	Inc(AState[1], B);
	Inc(AState[2], C);
	Inc(AState[3], D);
end;

procedure TgtMD5Hash.Update(AInput: Pointer; ALength: LongWord);
var
	Index: Longword;
	PartLen: Longword;
	I: Longword;
  LP: ^Byte;
begin
	with FContext do
  begin
		Index := (Count[0] shr 3) and $3f;
		Inc(Count[0], ALength shl 3);
		if Count[0] < (ALength shl 3) then
      Inc(Count[1]);
		Inc(Count[1], ALength shr 29);
	end;
	PartLen := 64 - Index;
	if ALength >= PartLen then
  begin
		CopyMemory(@FContext.Buffer[Index], AInput, PartLen);
		Transform(@FContext.Buffer, FContext.State);
		I := PartLen;
		while I + 63 < ALength do
    begin
      LP := AInput;
      Inc(LP, I);
			Transform(LP, FContext.State);
			Inc(I, 64);
		end;
		Index := 0;
	end
  else
    I := 0;
  LP := AInput;
  Inc(LP, I);
	CopyMemory(@FContext.Buffer[Index], LP, ALength - I);
end;

destructor TgtMD5Hash.Destroy;
begin
  inherited;
end;

class function TgtMD5Hash.GetHash(AInput: TStream): MD5Digest;
var
  LByteArray: array of Byte;
  LSize: Integer;
begin
  LSize := Integer(AInput.Size);
  SetLength(LByteArray, LSize);
  AInput.Position := 0;
  AInput.Read(LByteArray[0], LSize);
  Result := TgtMD5Hash.GetHash(@LByteArray[0], LSize);
end;

end.
