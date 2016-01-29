{Copyright:      Hagen Reddmann  mailto:HaReddmann@AOL.COM
 Author:         Hagen Reddmann
 Remarks:        freeware, but this Copyright must be included
 known Problems: none
 Version:        3.0, Delphi Encryption Compendium
                 Delphi 2-4, BCB 3-4, designed and testet under D3 and D4
 Description:    Utilitys for the DEC Packages

 * THIS SOFTWARE IS PROVIDED BY THE AUTHORS ''AS IS'' AND ANY EXPRESS
 * OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHORS OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
 * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
 * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
 * EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
}

 //-----------------------------------------------------//
 //                                                     //
 //  Modified by ComponentAce, 2003                     //
 //                                                     //
 //-----------------------------------------------------//

unit ZFDecUtil;

{$Include l3XE.inc}

interface

uses SysUtils, Classes;

{$I ZFVer.Inc}
{$I VER.INC}

const
  // String Formats
  fmtDEFAULT = -1;     // use DefaultStringFormat
  fmtNONE    = 0;     // allways an Empty String, nothing Action
  fmtCOPY    = 1;     // One to One binary (input = output)
  fmtHEX     = 16;     // Hexadecimal
  fmtHEXL    = 1016;     // Hexadecimal lowercase
  fmtMIME64  = $1064;     // MIME Base 64
  fmtUU      = $5555;     // UU Coding  $5555 = 'UU'
  fmtXX      = $5858;     // XX Coding  $5858 = 'XX'

 // 2 - 64 reserved for Formats to the Base 2 - 64
 // over 1000 all other Formats

type
{$IFNDEF VER_D4H}
  longword  = longint;
  PLongWord = ^longword;
{$ENDIF}
  PByte     = ^byte;
  PInteger  = ^longword;
  PWord     = ^word;
  PIntArray = ^TIntArray;
  TIntArray = array[0..1023] of longword;

  EProtection = class(Exception);
  EStringFormat = class(Exception);

  // basic Class for all Protection Classes, TCipher, THash, TRandom
  // TProtect can build a chain with varios Encryption Algos.
  // i.E. CodeBuffer() can en/decode the Buffer with more as one Cipher when
  // property Protection is set to a other Cipher :-)
  TPAction  = (paEncode, paDecode, paScramble, paCalc, paWipe);
  TPActions = set of TPAction;

{$IFDEF VER_D3H}
  TProtection = class(TInterfacedObject)
  private
{$ELSE}

  TProtection = class(TObject)
  private
    FRefCount:   integer;
{$ENDIF}
    FProtection: TProtection;
    FActions:    TPActions;
    function GetProtection: TProtection;
    procedure SetProtection(Value: TProtection);
  protected
    procedure CodeInit(Action: TPAction); virtual;
    procedure CodeDone(Action: TPAction); virtual;
    procedure CodeBuf(var Buffer; const BufferSize: integer; Action: TPAction); virtual;
  public
    constructor Create(AProtection: TProtection);
    destructor Destroy; override;

    class function Identity: word;

    function Release: integer;
    function AddRef: integer;

    procedure CodeStream(Source, Dest: TStream; DataSize: integer;
      Action: TPAction); virtual;
    procedure CodeFile(const Source, Dest: AnsiString; Action: TPAction); virtual;
    function CodeString(const Source: AnsiString; Action: TPAction;
      Format: integer): AnsiString; virtual;
    function CodeBuffer(var Buffer; BufferSize: integer; Action: TPAction): integer;
      virtual;
    // Protection Object, to cascade more Protection
    property Protection: TProtection Read GetProtection Write SetProtection;
    property Actions: TPActions Read FActions Write FActions default [paEncode..paWipe];
{$IFNDEF VER_D3H}
    property RefCount: integer Read FRefCount;
{$ENDIF}
  end;

  // String converting

  TStringFormatClass = class of TStringFormat;

  TStringFormat = class(TObject) // for binary one to one convert = fmtCOPY
  public
    class function ToStr(Value: PAnsiChar; Len: integer): AnsiString; virtual;
    class function StrTo(Value: PAnsiChar; Len: integer): AnsiString; virtual;
    class function Name: AnsiString; virtual;
    class function Format: integer; virtual;
    class function IsValid(Value: PAnsiChar; Len: integer; ToStr: boolean): boolean; virtual;
  end;

  TStringFormat_HEX = class(TStringFormat) // Hexadecimal = fmtHEX
  public
    class function ToStr(Value: PAnsiChar; Len: integer): AnsiString; override;
    class function StrTo(Value: PAnsiChar; Len: integer): AnsiString; override;
    class function Name: AnsiString; override;
    class function Format: integer; override;
    class function IsValid(Value: PAnsiChar; Len: integer; ToStr: boolean): boolean;
      override;
    class function CharTable: PAnsiChar; virtual;
  end;

  TStringFormat_HEXL = class(TStringFormat_HEX) // Hexadecimal lowercase = fmtHEXL
  public
    class function Name: AnsiString; override;
    class function Format: integer; override;
    class function CharTable: PAnsiChar; override;
  end;

  TStringFormat_MIME64 = class(TStringFormat_HEX)  // MIME Base 64 = fmtMIME64
  public
    class function ToStr(Value: PAnsiChar; Len: integer): AnsiString; override;
    class function StrTo(Value: PAnsiChar; Len: integer): AnsiString; override;
    class function Name: AnsiString; override;
    class function Format: integer; override;
    class function CharTable: PAnsiChar; override;
  end;

  TStringFormat_UU = class(TStringFormat) // UU Encode = fmtUU
  public
    class function ToStr(Value: PAnsiChar; Len: integer): AnsiString; override;
    class function StrTo(Value: PAnsiChar; Len: integer): AnsiString; override;
    class function Name: AnsiString; override;
    class function Format: integer; override;
    class function IsValid(Value: PAnsiChar; Len: integer; ToStr: boolean): boolean;
      override;
    class function CharTable: PAnsiChar; virtual;
  end;

  TStringFormat_XX = class(TStringFormat_UU) // XX Encode = fmtXX
  public
    class function Name: AnsiString; override;
    class function Format: integer; override;
    class function CharTable: PAnsiChar; override;
  end;

  {Progress (gauge) for Hash and Cipher}
  TProgressEvent = procedure(Sender: TObject; Current, Maximal: integer) of object;

 //calculate CRCR16/CRC32 Checksum, CRC is default $FFFFFFFF,
 //after calc you must inverse Result with NOT
function CRC16(CRC: word; Data: Pointer; DataSize: longword): word;
 // the basicly used TestVector for all Hash/Cipher classes
 // used for SelfTest, random Data, don't modify
function GetTestVector: PAnsiChar; register;

 // String/Format routines
 // convert any String to Format
function StrToFormat(Value: PAnsiChar; Len, Format: integer): AnsiString;
// convert any Format to String
function FormatToStr(Value: PAnsiChar; Len, Format: integer): AnsiString;
// convert any Format to Format
function ConvertFormat(Value: PAnsiChar; Len, FromFormat, ToFormat: integer): AnsiString;
// Check is String convertable to Format
function IsValidString(Value: PAnsiChar; Len, Format: integer): boolean;
// Check is Format an valid Format
function IsValidFormat(Value: PAnsiChar; Len, Format: integer): boolean;
// register a new Format
procedure RegisterStringFormats(const StringFormats: array of TStringFormatClass);
// give all registered Formats in Strings
procedure GetStringFormats(Strings: TStrings);
// the Default, = fmtMIME64
function DefaultStringFormat: integer;
// set the Default
procedure SetDefaultStringFormat(Format: integer);
// give StringFormatClass from Format
function StringFormat(Format: integer): TStringFormatClass;
// insert #13#10 Chars in Blocks from BlockSize
function InsertCR(const Value: AnsiString; BlockSize: integer): AnsiString;
// delete all #13 and #10 Chars
function DeleteCR(const Value: AnsiString): AnsiString;
// format any String to a Block
function InsertBlocks(const Value, BlockStart, BlockEnd: AnsiString;
  BlockSize: integer): AnsiString;
// remove any Block format
function RemoveBlocks(const Value, BlockStart, BlockEnd: AnsiString): AnsiString;
// give back a shorter Name, i.E. THash_MD4 -> "MD4" or TCipher_Blowfish -> "Blowfish"
function GetShortClassName(Value: TClass): AnsiString;

// Result := Value shl Shift or Value shr (32 - Shift)
function ROL(Value: longword; Shift: integer): longword;
// Result := ROL(Value, Shift) + Add
function ROLADD(Value, Add: longword; Shift: integer): longword;
// Result := ROL(Value, Shift) - Sub
function ROLSUB(Value, Sub: longword; Shift: integer): longword;
// Result := Value shr Shift or Value shl (32 - Shift)
function ROR(Value: longword; Shift: integer): longword;
// Result := ROR(Value, Shift) + Add
function RORADD(Value, Add: longword; Shift: integer): longword;
// Result := ROR(Value, Shift) - Sub
function RORSUB(Value, Sub: longword; Shift: integer): longword;
// Reverse the Bitorder from Value
function SwapBits(Value: longword): longword;
// Index of Least Significant Bit from Value
function LSBit(Value: integer): integer;
// Index of Most Significant Bit from Value
function MSBit(Value: integer): integer;
// Check iff only One Bit is set and give back the Index
function OneBit(Value: integer): integer;
// Compare Memory, D2 have no CompareMem, Result can be -1, 0, 1
function MemCompare(P1, P2: Pointer; Size: integer): integer;
// XOR's Buffers I1 and I2 Size Bytes to Dest
procedure XORBuffers(I1, I2: Pointer; Size: integer; Dest: Pointer);
 // Processor Type
function CPUType: integer; {3 = 386, 4 = 486, 5 = Pentium, 6 > Pentium i.E. PII}
 // call a installed Progress Event
procedure DoProgress(Sender: TObject; Current, Maximal: integer);
// saver Test
function IsObject(AObject: Pointer; AClass: TClass): boolean;
// Time Seed produced from GetSystemTime and QueryPerformanceCounter
function RndTimeSeed: integer;
 // XOR Buffer Size Bytes with Seed Randoms,
 // the initial State from Buffer have effect on the Output
function RndXORBuffer(Seed: integer; var Buffer; Size: integer): integer;
// encapsulate QueryPerformanceCounter/Frequency
function PerfCounter: comp;
function PerfFreq: comp;

const
  InitTestIsOk: boolean = True;
  IdentityBase: word    = $1234;

  {this is set to SwapInt for <= 386 and BSwapInt >= 486 CPU, don't modify}
  SwapInteger: function(Value: longword): longword; register = nil;
  {Count of Integers Buffer}
  SwapIntegerBuffer: procedure(Source, Dest: Pointer; Count: integer); register = nil;
  {Progress callback function, set this to your Progresscallback}
  Progress: TProgressEvent = nil;

implementation

uses Windows, ZFDecConst;

const
  FCPUType: integer = 0;
  FStrFMTs: TList   = nil;         // registered Stringformats
  FStrFMT: integer  = fmtMIME64;   // Default Stringformat


function PerfCounter: comp;
begin
{$IFDEF VER_D4H}
  if not QueryPerformanceCounter(Int64(TULargeInteger(Result).QuadPart)) then
{$ELSE}
  if not QueryPerformanceCounter(TLargeInteger(Result)) then
{$ENDIF}
    Result := GetTickCount;
end;

function PerfFreq: comp;
begin
{$IFDEF VER_D4H}
  if not QueryPerformanceFrequency(Int64(TULargeInteger(Result).QuadPart)) then
{$ELSE}
  if not QueryPerformanceFrequency(TLargeInteger(Result)) then
{$ENDIF}
    Result := 1000;
end;

function DefaultStringFormat: integer;
begin
  Result := FStrFMT;
end;

procedure SetDefaultStringFormat(Format: integer);
begin
  if (Format = fmtDEFAULT) or (StringFormat(Format) = nil) then
    FStrFMT := fmtMIME64
  else
    FStrFMT := Format;
end;

// TProtection Class
function TProtection.GetProtection: TProtection;
begin
  if (FProtection <> nil) and not IsObject(FProtection, TProtection) then
    FProtection := nil;
  Result := FProtection;
end;

procedure TProtection.SetProtection(Value: TProtection);

  function CheckProtection(P: TProtection): boolean;
  begin
    Result := True;
    if IsObject(P, TProtection) then
      if P = Self then
        Result := False
      else
        Result := CheckProtection(P.FProtection);
  end;

begin
  if Value <> FProtection then
    if CheckProtection(Value) then
    begin
      FProtection.Release;
      FProtection := Value;
      FProtection.AddRef;
    end
    else
      raise EProtection.Create(sProtectionCircular);
end;

procedure TProtection.CodeInit(Action: TPAction);
begin
  if Protection <> nil then
    Protection.CodeInit(Action);
end;

procedure TProtection.CodeDone(Action: TPAction);
begin
  if Protection <> nil then
    Protection.CodeDone(Action);
end;

procedure TProtection.CodeBuf(var Buffer; const BufferSize: integer; Action: TPAction);
begin
  if Protection <> nil then
    Protection.CodeBuf(Buffer, BufferSize, Action);
end;

function TProtection.Release: integer;
begin
  if IsObject(Self, TProtection) then
  begin
{$IFDEF VER_D3H}
    Result := IUnknown(Self)._Release;
{$ELSE}
    Dec(FRefCount);
    Result := FRefCount;
    if FRefCount = 0 then
      Destroy;
{$ENDIF}
  end
  else
    Result := 0;
end;

function TProtection.AddRef: integer;
begin
  if IsObject(Self, TProtection) then
  begin
{$IFDEF VER_D3H}
    Result := IUnknown(Self)._AddRef;
{$ELSE}
    Inc(FRefCount);
    Result := FRefCount;
{$ENDIF}
  end
  else
    Result := 0;
end;

procedure TProtection.CodeStream(Source, Dest: TStream; DataSize: integer;
  Action: TPAction);
const
  maxBufSize = 1024 * 4;
var
  Buf:  PAnsiChar;
  SPos: integer;
  DPos: integer;
  Len:  integer;
  Size: integer;
begin
  if Source = nil then
    Exit;
  if Dest = nil then
    Dest := Source;
  if DataSize < 0 then
  begin
    DataSize := Source.Size;
    Source.Position := 0;
  end;
  CodeInit(Action);
  Buf  := nil;
  Size := DataSize;
  DoProgress(Self, 0, Size);
  try
    Buf  := AllocMem(maxBufSize);
    DPos := Dest.Position;
    SPos := Source.Position;
    if Action = paCalc then
    begin
      while DataSize > 0 do
      begin
        Len := DataSize;
        if Len > maxBufSize then
          Len := maxBufSize;
        Len := Source.Read(Buf^, Len);
        if Len <= 0 then
          Break;
        CodeBuf(Buf^, Len, paCalc);
        Dec(DataSize, Len);
        DoProgress(Self, Size - DataSize, Size);
      end;
    end
    else
    begin
      while DataSize > 0 do
      begin
        Source.Position := SPos;
        Len := DataSize;
        if Len > maxBufSize then
          Len := maxBufSize;
        Len := Source.Read(Buf^, Len);
        SPos := Source.Position;
        if Len <= 0 then
          Break;
        CodeBuf(Buf^, Len, Action);
        Dest.Position := DPos;
        Dest.Write(Buf^, Len);
        DPos := Dest.Position;
        Dec(DataSize, Len);
        DoProgress(Self, Size - DataSize, Size);
      end;
    end;
  finally
    DoProgress(Self, 0, 0);
    ReallocMem(Buf, 0);
    CodeDone(Action);
  end;
end;

procedure TProtection.CodeFile(const Source, Dest: AnsiString; Action: TPAction);
var
  S, D: TFileStream;
begin
  S := nil;
  D := nil;
  try
    if (AnsiCompareText(String(Source), String(Dest)) <> 0) and ((Trim(String(Dest)) <> '') or
      (Action = paCalc)) then
    begin
      S := TFileStream.Create(String(Source), fmOpenRead or fmShareDenyNone);
      if Action = paCalc then
        D := S
      else
        D := TFileStream.Create(String(Dest), fmCreate);
    end
    else
    begin
      S := TFileStream.Create(String(Source), fmOpenReadWrite);
      D := S;
    end;
    CodeStream(S, D, S.Size, Action);
  finally
    S.Free;
    if S <> D then
    begin
{$IFDEF VER_D3H}
      D.Size := D.Position;
{$ENDIF}
      D.Free;
    end;
  end;
end;

function TProtection.CodeBuffer(var Buffer; BufferSize: integer;
  Action: TPAction): integer;
begin
  Result := BufferSize;
  CodeInit(Action);
  try
    CodeBuf(Buffer, BufferSize, Action);
  finally
    CodeDone(Action);
  end;
end;

function TProtection.CodeString(const Source: AnsiString; Action: TPAction;
  Format: integer): AnsiString;
var
  M: TMemoryStream;
begin
  Result := '';
  if Length(Source) <= 0 then
    Exit;
  M := TMemoryStream.Create;
  try
    if Action <> paDecode then
      Result := Source
    else
      Result := FormatToStr(PAnsiChar(Source), Length(Source), Format);
    M.Write(PAnsiChar(Result)^, Length(Result));
    M.Position := 0;
    CodeStream(M, M, M.Size, Action);
    if Action = paDecode then
    begin
      SetLength(Result, M.Size);
      Move(M.Memory^, PAnsiChar(Result)^, M.Size);
    end
    else
      Result := StrToFormat(M.Memory, M.Size, Format);
  finally
    M.Free;
  end;
end;

constructor TProtection.Create(AProtection: TProtection);
begin
  inherited Create;
  Protection := AProtection;
  FActions   := [paEncode..paWipe];
end;

destructor TProtection.Destroy;
begin
  Protection := nil;
  inherited Destroy;
end;

class function TProtection.Identity: word;
var
  S: AnsiString;
begin
  S      := AnsiString(ClassName);
  Result := not CRC16(IdentityBase, PAnsiChar(S), Length(S));
end;

class function TStringFormat.ToStr(Value: PAnsiChar; Len: integer): AnsiString;
begin
  SetLength(Result, Len);
  Move(Value^, PAnsiChar(Result)^, Len);
end;

class function TStringFormat.StrTo(Value: PAnsiChar; Len: integer): AnsiString;
begin
  SetLength(Result, Len);
  Move(Value^, PAnsiChar(Result)^, Len);
end;

class function TStringFormat.Name: AnsiString;
begin
  if Self = TStringFormat then
    Result := AnsiString(sFMT_COPY)
  else
    Result := AnsiString(GetShortClassName(Self));
end;

class function TStringFormat.Format: integer;
begin
  Result := fmtCOPY;
end;

class function TStringFormat.IsValid(Value: PAnsiChar; Len: integer;
  ToStr: boolean): boolean;
begin
  Result := True;
end;

function TableFind(Value: AnsiChar; Table: PAnsiChar; Len: integer): integer; assembler;
asm // Utility for TStringFormat_XXXXX
  PUSH  EDI
  MOV   EDI,EDX
  REPNE SCASB
  MOV   EAX,0
  JNE   @@1
  MOV   EAX,EDI
  SUB   EAX,EDX
  @@1:  DEC   EAX
  POP   EDI
end;

class function TStringFormat_HEX.ToStr(Value: PAnsiChar; Len: integer): AnsiString;
var
  D:    PByte;
  T:    PAnsiChar;
  I, P: integer;
  HasIdent: boolean;
begin
  Result := '';
  if Value = nil then
    Exit;
  if Len < 0 then
    Len := StrLen(Value);
  if Len = 0 then
    Exit;
  SetLength(Result, Len div 2 + 1);
  T := CharTable;
  D := PByte(Result);
  I := 0;
  HasIdent := False;
  while Len > 0 do
  begin
    P := TableFind(UpCase(Value^), T, 18);
    Inc(Value);
    if P >= 0 then
      if P > 16 then
      begin
        if not HasIdent then
        begin
          HasIdent := True;
          I := 0;
          D := PByte(Result);
        end;
      end
      else
      begin
        if Odd(I) then
        begin
          D^ := D^ or P;
          Inc(D);
        end
        else
          D^ := P shl 4;
        Inc(I);
      end;
    Dec(Len);
  end;
  SetLength(Result, PAnsiChar(D) - PAnsiChar(Result));
end;

class function TStringFormat_HEX.StrTo(Value: PAnsiChar; Len: integer): AnsiString;
var
  D, T: PAnsiChar;
begin
  Result := '';
  if Value = nil then
    Exit;
  if Len < 0 then
    Len := StrLen(Value);
  if Len = 0 then
    Exit;
  SetLength(Result, Len * 2);
  T := CharTable;
  D := PAnsiChar(Result);
  while Len > 0 do
  begin
    D[0] := T[byte(Value^) shr 4];
    D[1] := T[byte(Value^) and $F];
    Inc(D, 2);
    Inc(Value);
    Dec(Len);
  end;
end;

class function TStringFormat_HEX.IsValid(Value: PAnsiChar; Len: integer;
  ToStr: boolean): boolean;
var
  T: PAnsiChar;
  L: integer;
begin
  Result := not ToStr;
  if not Result then
  begin
    T := CharTable;
    L := StrLen(T);
    while Len > 0 do
      if TableFind(Value^, T, L) >= 0 then
      begin
        Dec(Len);
        Inc(Value);
      end
      else
        Exit;
  end;
  Result := True;
end;

class function TStringFormat_HEX.Name: AnsiString;
begin
  Result := AnsiString(sFMT_HEX);
end;

class function TStringFormat_HEX.Format: integer;
begin
  Result := fmtHEX;
end;

class function TStringFormat_HEX.CharTable: PAnsiChar; assembler;
asm
  MOV  EAX,OFFSET @@1
  RET
  @@1:  DB   '0123456789ABCDEF'     // Table must be >= 18 Chars
  DB   'X$ abcdefhHx()[]{},;:-_/\*+"''',9,10,13,0
end;

class function TStringFormat_HEXL.Name: AnsiString;
begin
  Result := AnsiString(sFMT_HEXL);
end;

class function TStringFormat_HEXL.Format: integer;
begin
  Result := fmtHEXL;
end;

class function TStringFormat_HEXL.CharTable: PAnsiChar;
asm
  MOV  EAX,OFFSET @@1
  RET
  @@1:  DB   '0123456789abcdef'     // Table must be >= 18 Chars
  DB   'X$ ABCDEFhHx()[]{},;:-_/\*+"''',9,10,13,0
end;

class function TStringFormat_MIME64.ToStr(Value: PAnsiChar; Len: integer): AnsiString;
var
  B:    cardinal;
  J, I: integer;
  S, D, L, T: PAnsiChar;
begin
  Result := '';
  if Value = nil then
    Exit;
  if Len < 0 then
    Len := Length(Value);
  if Len = 0 then
    Exit;
  SetLength(Result, Len);
  Move(PAnsiChar(Value)^, PAnsiChar(Result)^, Len);
  T := CharTable;
  while Len mod 4 <> 0 do
  begin
    Result := Result + T[64];
    Inc(Len);
  end;
  D   := PAnsiChar(Result);
  S   := D;
  L   := S + Len;
  Len := Len * 3 div 4;
  while Len > 0 do
  begin
    B := 0;
    J := 4;
    while (J > 0) and (S <= L) do
    begin
      I := TableFind(S^, T, 65);
      if I >= 0 then
      begin
        B := B shl 6;
        if I >= 64 then
          Dec(Len)
        else
          B := B or byte(I);
        Dec(J);
      end;
      Inc(S);
    end;
    J := 2;
    repeat
      D[J] := AnsiChar(B);
      B    := B shr 8;
      Dec(J);
    until J < 0;
    if Len > 3 then
      Inc(D, 3)
    else
      Inc(D, Len);
    Dec(Len, 3);
  end;
  SetLength(Result, D - PAnsiChar(Result));
end;

class function TStringFormat_MIME64.StrTo(Value: PAnsiChar; Len: integer): AnsiString;
var
  B:    cardinal;
  I:    integer;
  D, T: PAnsiChar;
begin
  Result := '';
  if Value = nil then
    Exit;
  if Len < 0 then
    Len := StrLen(Value);
  if Len = 0 then
    Exit;
  SetLength(Result, Len * 4 div 3 + 4);
  D := PAnsiChar(Result);
  T := CharTable;
  while Len > 0 do
  begin
    B := 0;
    for I := 0 to 2 do
    begin
      B := B shl 8;
      if Len > 0 then
      begin
        B := B or byte(Value^);
        Inc(Value);
      end;
      Dec(Len);
    end;
    for I := 3 downto 0 do
    begin
      if Len < 0 then
      begin
        D[I] := T[64];
        Inc(Len);
      end
      else
        D[I] := T[B and $3F];
      B := B shr 6;
    end;
    Inc(D, 4);
  end;
  SetLength(Result, D - PAnsiChar(Result));
end;

class function TStringFormat_MIME64.Name: AnsiString;
begin
  Result := AnsiString(sFMT_MIME64);
end;

class function TStringFormat_MIME64.Format: integer;
begin
  Result := fmtMIME64;
end;

class function TStringFormat_MIME64.CharTable: PAnsiChar; assembler;
asm
  MOV  EAX,OFFSET @@1
  RET  // must be >= 65 Chars
  @@1:  DB  'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/='
  DB  ' $()[]{},;:-_\*"''',9,10,13,0
end;

class function TStringFormat_UU.ToStr(Value: PAnsiChar; Len: integer): AnsiString;
var
  T, D, L: PAnsiChar;
  I, E: integer;
  B: cardinal;
begin
  Result := '';
  if Value = nil then
    Exit;
  if Len < 0 then
    Len := StrLen(Value);
  if Len = 0 then
    Exit;
  SetLength(Result, Len);
  L := Value + Len;
  D := PAnsiChar(Result);
  T := CharTable;
  repeat
    Len := TableFind(Value^, T, 64);
    if (Len < 0) or (Len > 45) then
      raise EStringFormat.CreateFMT(sInvalidStringFormat, [Name]);
    Inc(Value);
    while Len > 0 do
    begin
      B := 0;
      I := 4;
      while (I > 0) and (Value <= L) do
      begin
        E := TableFind(Value^, T, 64);
        if E >= 0 then
        begin
          B := B shl 6 or byte(E);
          Dec(I);
        end;
        Inc(Value);
      end;
      I := 2;
      repeat
        D[I] := AnsiChar(B);
        B    := B shr 8;
        Dec(I);
      until I < 0;
      if Len > 3 then
        Inc(D, 3)
      else
        Inc(D, Len);
      Dec(Len, 3);
    end;
  until Value >= L;
  SetLength(Result, D - PAnsiChar(Result));
end;

class function TStringFormat_UU.StrTo(Value: PAnsiChar; Len: integer): AnsiString;
var
  T, D: PAnsiChar;
  L, I: integer;
  B:    cardinal;
begin
  Result := '';
  if Value = nil then
    Exit;
  if Len < 0 then
    Len := StrLen(Value);
  if Len = 0 then
    Exit;
  SetLength(Result, Len * 4 div 3 + Len div 45 + 10);
  D := PAnsiChar(Result);
  T := CharTable;
  while Len > 0 do
  begin
    L := Len;
    if L > 45 then
      L := 45;
    Dec(Len, L);
    D^ := T[L];
    while L > 0 do
    begin
      B := 0;
      for I := 0 to 2 do
      begin
        B := B shl 8;
        if L > 0 then
        begin
          B := B or byte(Value^);
          Inc(Value);
        end;
        Dec(L);
      end;
      for I := 4 downto 1 do
      begin
        D[I] := T[B and $3F];
        B    := B shr 6;
      end;
      Inc(D, 4);
    end;
    Inc(D);
  end;
  SetLength(Result, D - PAnsiChar(Result));
end;

class function TStringFormat_UU.Name: AnsiString;
begin
  Result := AnsiString(sFMT_UU);
end;

class function TStringFormat_UU.Format: integer;
begin
  Result := fmtUU;
end;

class function TStringFormat_UU.IsValid(Value: PAnsiChar; Len: integer;
  ToStr: boolean): boolean;
var
  T: PAnsiChar;
  L, I, P: integer;
begin
  Result := not ToStr;
  if not Result then
  begin
    T := CharTable;
    L := StrLen(T);
    P := 0;
    while Len > 0 do
    begin
      I := TableFind(Value^, T, L);
      if I >= 0 then
      begin
        Dec(Len);
        Inc(Value);
        if P = 0 then
        begin
          if I > 45 then
            Exit;
          P := (I * 4 + 2) div 3;
        end
        else
        if I < 64 then
          Dec(P);
      end
      else
        Exit;
    end;
    if P <> 0 then
      Exit;
  end;
  Result := True;
end;

class function TStringFormat_UU.CharTable: PAnsiChar;
asm
  MOV  EAX,OFFSET @@1
  RET  // must be >= 64 Chars
  @@1:  DB   '`!"#$%&''()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_'
  DB   ' ',9,10,13,0
end;

class function TStringFormat_XX.Name: AnsiString;
begin
  Result := AnsiString(sFMT_XX);
end;

class function TStringFormat_XX.Format: integer;
begin
  Result := fmtXX;
end;

class function TStringFormat_XX.CharTable: PAnsiChar;
asm
  MOV  EAX,OFFSET @@1
  RET
  @@1:  DB   '+-0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'
  DB   ' "()[]''',9,10,13,0
end;

function CPUType: integer;
begin
  Result := FCPUType;
end;

function IsObject(AObject: Pointer; AClass: TClass): boolean;
var
  E: Pointer;
begin
  Result := False;
  if AObject = nil then
    Exit;
  E := ExceptionClass;
  ExceptionClass := nil;
  try
    if TObject(AObject) is AClass then
      Result := True;
  except
  end;
  ExceptionClass := E;
end;

function ROL(Value: longword; Shift: integer): longword; assembler;
asm
  MOV   ECX,EDX
  ROL   EAX,CL
end;

function ROLADD(Value, Add: longword; Shift: integer): longword; assembler;
asm
  ROL   EAX,CL
  ADD   EAX,EDX
end;

function ROLSUB(Value, Sub: longword; Shift: integer): longword; assembler;
asm
  ROL   EAX,CL
  SUB   EAX,EDX
end;

function ROR(Value: longword; Shift: integer): longword; assembler;
asm
  MOV   ECX,EDX
  ROR   EAX,CL
end;

function RORADD(Value, Add: longword; Shift: integer): longword; assembler;
asm
  ROR  EAX,CL
  ADD  EAX,EDX
end;

function RORSUB(Value, Sub: longword; Shift: integer): longword; assembler;
asm
  ROR  EAX,CL
  SUB  EAX,EDX
end;
{swap 4 Bytes Intel, Little/Big Endian Conversion}
function SwapInt(Value: longword): longword; assembler; register;
asm
  XCHG  AH,AL
  ROL   EAX,16
  XCHG  AH,AL
end;

function BSwapInt(Value: longword): longword; assembler; register;
asm
  BSWAP  EAX
end;

procedure SwapIntBuf(Source, Dest: Pointer; Count: integer); assembler; register;
asm
  TEST   ECX,ECX
  JLE    @Exit
  PUSH   EBX
  SUB    EAX,4
  SUB    EDX,4
  @@1:   MOV    EBX,[EAX + ECX * 4]
  XCHG   BL,BH
  ROL    EBX,16
  XCHG   BL,BH
  MOV[EDX + ECX * 4],EBX
  DEC    ECX
  JNZ    @@1
  POP    EBX
  @Exit:
end;

procedure BSwapIntBuf(Source, Dest: Pointer; Count: integer); assembler; register;
asm
  TEST   ECX,ECX
  JLE    @Exit
  PUSH   EBX
  SUB    EAX,4
  SUB    EDX,4
  @@1:   MOV    EBX,[EAX + ECX * 4]
  BSWAP  EBX
  MOV[EDX + ECX * 4],EBX
  DEC    ECX
  JNZ    @@1
  POP    EBX
  @Exit:
end;
{reverse the bit order from a integer}
function SwapBits(Value: longword): longword;
asm
  CMP    FCPUType,3
  JLE    @@1
  BSWAP  EAX
  JMP    @@2
  @@1:   XCHG   AH,AL
  ROL    EAX,16
  XCHG   AH,AL
  @@2:   MOV    EDX,EAX
  and    EAX,0AAAAAAAAh
  shr    EAX,1
  and    EDX,055555555h
  shl    EDX,1
  or     EAX,EDX
  MOV    EDX,EAX
  and    EAX,0CCCCCCCCh
  shr    EAX,2
  and    EDX,033333333h
  shl    EDX,2
  or     EAX,EDX
  MOV    EDX,EAX
  and    EAX,0F0F0F0F0h
  shr    EAX,4
  and    EDX,00F0F0F0Fh
  shl    EDX,4
  or     EAX,EDX
end;

function LSBit(Value: integer): integer; assembler;
asm
  BSF   EAX,EAX
end;

function MSBit(Value: integer): integer; assembler;
asm
  BSR   EAX,EAX
end;

function OneBit(Value: integer): integer; assembler;
asm
  MOV   ECX,EAX
  MOV   EDX,EAX
  BSF   EDX,EDX
  JZ    @@1
  BSR   ECX,ECX
  CMP   ECX,EDX
  JNE   @@1
  MOV   EAX,EDX
  RET
  @@1:   xor   EAX,EAX
end;

function MemCompare(P1, P2: Pointer; Size: integer): integer; assembler; register;
asm
  PUSH    ESI
  PUSH    EDI
  MOV     ESI,P1
  MOV     EDI,P2
  xor     EAX,EAX
  REPE    CMPSB
  JE      @@1
  MOVZX   EAX,byte PTR [ESI-1]
  MOVZX   EDX,byte PTR [EDI-1]
  SUB     EAX,EDX
  @@1:   POP     EDI
  POP     ESI
end;

procedure XORBuffers(I1, I2: Pointer; Size: integer; Dest: Pointer); assembler;
asm
  and   ECX,ECX
  JZ    @@5
  PUSH  ESI
  PUSH  EDI
  MOV   ESI,EAX
  MOV   EDI,Dest
  @@1:   TEST  ECX,3
  JNZ   @@3
  @@2:   SUB   ECX,4
  JL    @@4
  MOV   EAX,[ESI + ECX]
  xor   EAX,[EDX + ECX]
  MOV[EDI + ECX],EAX
  JMP   @@2
  @@3:   DEC   ECX
  MOV   AL,[ESI + ECX]
  xor   AL,[EDX + ECX]
  MOV[EDI + ECX],AL
  JMP   @@1
  @@4:   POP   EDI
  POP   ESI
  @@5:
end;

procedure DoProgress(Sender: TObject; Current, Maximal: integer);
begin
  {saver access}
  if (TMethod(Progress).Code <> nil) and ((TMethod(Progress).Data = nil) or
    IsObject(TMethod(Progress).Data, TObject)) then
    Progress(Sender, Current, Maximal);
end;

function StringFormat(Format: integer): TStringFormatClass;
var
  I: integer;
begin
  if Format = fmtDefault then
    Format := DefaultStringFormat;
  Result := nil;
  if FStrFmts <> nil then
    for I := 0 to FStrFMTs.Count - 1 do
      if TStringFormatClass(FStrFmts[I]).Format = Format then
      begin
        Result := FStrFMTS[I];
        Exit;
      end;
end;

function StrToFormat(Value: PAnsiChar; Len, Format: integer): AnsiString;
var
  Fmt: TStringFormatClass;
begin
  Result := '';
  if (Value = nil) or (Format = fmtNONE) then
    Exit;
  if Len < 0 then
    Len := StrLen(Value);
  if Len <= 0 then
    Exit;
  Fmt := StringFormat(Format);
  if Fmt <> nil then
    if Fmt.IsValid(Value, Len, False) then
      Result := Fmt.StrTo(Value, Len)
    else
      raise EStringFormat.CreateFMT(sInvalidFormatString, [FMT.Name])
  else
    raise EStringFormat.CreateFMT(sStringFormatExists, [Format]);
end;

function FormatToStr(Value: PAnsiChar; Len, Format: integer): AnsiString;
var
  Fmt: TStringFormatClass;
begin
  Result := '';
  if (Value = nil) or (Format = fmtNONE) then
    Exit;
  if Len < 0 then
    Len := StrLen(Value);
  if Len = 0 then
    Exit;
  Fmt := StringFormat(Format);
  if Fmt <> nil then
    if Fmt.IsValid(Value, Len, True) then
      Result := Fmt.ToStr(Value, Len)
    else
      raise EStringFormat.CreateFMT(sInvalidStringFormat, [FMT.Name])
  else
    raise EStringFormat.CreateFMT(sStringFormatExists, [Format]);
end;

function ConvertFormat(Value: PAnsiChar; Len, FromFormat, ToFormat: integer): AnsiString;
begin
  Result := '';
  if (FromFormat = fmtNONE) or (ToFormat = fmtNONE) then
    Exit;
  if FromFormat <> ToFormat then
  begin
    Result := FormatToStr(Value, Len, FromFormat);
    Result := StrToFormat(PAnsiChar(Result), Length(Result), ToFormat);
  end
  else
  begin
    if Value = nil then
      Exit;
    if Len < 0 then
      Len := StrLen(Value);
    if Len = 0 then
      Exit;
    SetLength(Result, Len);
    Move(Value^, PAnsiChar(Result)^, Len);
  end;
end;

function IsValidFormat(Value: PAnsiChar; Len, Format: integer): boolean;
var
  Fmt: TStringFormatClass;
begin
  Result := True;
  if Value = nil then
    Exit;
  if Len < 0 then
    Len := StrLen(Value);
  if Len = 0 then
    Exit;
  Fmt := StringFormat(Format);
  if Fmt = nil then
    Result := False
  else
    Result := Fmt.IsValid(Value, Len, True);
end;

function IsValidString(Value: PAnsiChar; Len, Format: integer): boolean;
var
  Fmt: TStringFormatClass;
begin
  Result := True;
  if Value = nil then
    Exit;
  if Len < 0 then
    Len := StrLen(Value);
  if Len = 0 then
    Exit;
  Fmt := StringFormat(Format);
  if Fmt = nil then
    Result := False
  else
    Result := Fmt.IsValid(Value, Len, False);
end;

procedure RegisterStringFormats(const StringFormats: array of TStringFormatClass);
var
  I, J: integer;
  FMT:  TStringFormatClass;
begin
  if FStrFMTs = nil then
    FStrFMTs := TList.Create;
  for I := Low(StringFormats) to High(StringFormats) do
    if (StringFormats[I] <> nil) and (StringFormats[I].Format <> fmtDEFAULT) then
    begin
      FMT := StringFormat(StringFormats[I].Format);
      if FMT <> nil then
      begin
        J := FStrFMTs.IndexOf(FMT);
        FStrFMTs[J] := StringFormats[I];
      end
      else
        FStrFMTs.Add(StringFormats[I]);
    end;
end;

procedure GetStringFormats(Strings: TStrings);
var
  I: integer;
begin
  if IsObject(Strings, TStrings) and (FStrFMTs <> nil) then
    for I := 0 to FStrFMTs.Count - 1 do
      Strings.AddObject(String(TStringFormatClass(FStrFMTs[I]).Name), FStrFMTs[I]);
end;

function InsertCR(const Value: AnsiString; BlockSize: integer): AnsiString;
var
  I:    integer;
  S, D: PAnsiChar;
begin
  if (BlockSize <= 0) or (Length(Value) <= BlockSize) then
  begin
    Result := Value;
    Exit;
  end;
  I := Length(Value);
  SetLength(Result, I + I * 2 div BlockSize + 2);
  S := PAnsiChar(Value);
  D := PAnsiChar(Result);
  repeat
    Move(S^, D^, BlockSize);
    Inc(S, BlockSize);
    Inc(D, BlockSize);
    D^ := #13;
    Inc(D);
    D^ := #10;
    Inc(D);
    Dec(I, BlockSize);
  until I < BlockSize;
  Move(S^, D^, I);
  Inc(D, I);
  SetLength(Result, D - PAnsiChar(Result));
end;

function DeleteCR(const Value: AnsiString): AnsiString;
var
  S, D: PAnsiChar;
  I:    integer;
begin
  I := Length(Value);
  SetLength(Result, I);
  D := PAnsiChar(Result);
  S := PAnsiChar(Value);
  while I > 0 do
  begin
    if (S^ <> #10) and (S^ <> #13) then
    begin
      D^ := S^;
      Inc(D);
    end;
    Inc(S);
    Dec(I);
  end;
  SetLength(Result, D - PAnsiChar(Result));
end;

function InsertBlocks(const Value, BlockStart, BlockEnd: AnsiString;
  BlockSize: integer): AnsiString;
var
  I, LS, LE: integer;
  D, S:      PAnsiChar;
begin
  if (BlockSize <= 0) or (Length(Value) <= BlockSize) then
  begin
    Result := Value;
    Exit;
  end;
  I  := Length(Value);
  LS := Length(BlockStart);
  LE := Length(BlockEnd);
  SetLength(Result, I + (I div BlockSize + 1) * (LS + LE));
  S := PAnsiChar(Value);
  D := PAnsiChar(Result);
  repeat
    Move(PAnsiChar(BlockStart)^, D^, LS);
    Inc(D, LS);
    Move(S^, D^, BlockSize);
    Inc(D, BlockSize);
    Move(PAnsiChar(BlockEnd)^, D^, LE);
    Inc(D, LE);
    Dec(I, BlockSize);
    Inc(S, BlockSize);
  until I < BlockSize;
  if I > 0 then
  begin
    Move(PAnsiChar(BlockStart)^, D^, LS);
    Inc(D, LS);
    Move(S^, D^, I);
    Inc(D, I);
    Move(PAnsiChar(BlockEnd)^, D^, LE);
    Inc(D, LE);
  end;
  SetLength(Result, D - PAnsiChar(Result));
end;

function RemoveBlocks(const Value, BlockStart, BlockEnd: AnsiString): AnsiString;
var
  LS, LE:     integer;
  S, D, L, K: PAnsiChar;
begin
  SetLength(Result, Length(Value));
  LS := Length(BlockStart);
  LE := Length(BlockEnd);
  D  := PAnsiChar(Result);
  S  := PAnsiChar(Value);
  L  := S + Length(Value);

  repeat
    if S > L then
      Break;
    if LS > 0 then
    begin
      S := StrPos(S, PAnsiChar(BlockStart));
      if S = nil then
        Break;
      Inc(S, LS);
      if S > L then
        Break;
    end;
    K := StrPos(S, PAnsiChar(BlockEnd));
    if K = nil then
      K := L;
    Move(S^, D^, K - S);
    Inc(D, K - S);
    S := K + LE;
  until S >= L;
  SetLength(Result, D - PAnsiChar(Result));
end;

function GetShortClassName(Value: TClass): AnsiString;
var
  I: integer;
begin
  Result := '';
  if Value = nil then
    Exit;
  Result := AnsiString(Value.ClassName);
  I      := Pos('_', String(Result));
  if I > 0 then
    Delete(Result, 1, I);
end;

function RndXORBuffer(Seed: integer; var Buffer; Size: integer): integer; assembler;
asm
  and     EDX,EDX
  JZ      @@2
  and     ECX,ECX
  JLE     @@2
  PUSH    EBX
  @@1:  xor     AL,[EDX]
  IMUL    EAX,EAX,134775813
  INC     EAX
  MOV     EBX,EAX
  shr     EBX,24
  MOV[EDX],BL
  INC     EDX
  DEC     ECX
  JNZ     @@1
  POP     EBX
  @@2:
end;

// use Systemtime and XOR's with Performancecounter
function RndTimeSeed: integer; assembler;
var
  SysTime: record
    Year:     word;
    Month:    word;
    DayOfWeek: word;
    Day:      word;
    Hour:     word;
    Minute:   word;
    Second:   word;
    MilliSeconds: word;
    Reserved: array [0..7] of byte;
  end;
  Counter: record
    Lo, Hi: integer;
  end;
asm
  LEA     EAX,SysTime
  PUSH    EAX
  CALL    GetSystemTime
  MOVZX   EAX,word Ptr SysTime.Hour
  IMUL    EAX,60
  ADD     AX,SysTime.Minute
  IMUL    EAX,60
  MOVZX   EDX,word Ptr SysTime.Second
  ADD     EAX,EDX
  IMUL    EAX,1000
  MOV     DX,SysTime.MilliSeconds
  ADD     EAX,EDX
  PUSH    EAX
  LEA     EAX,Counter
  PUSH    EAX
  CALL    QueryPerformanceCounter
  POP     EAX
  xor     EAX,Counter.Lo
  xor     EAX,Counter.Hi
end;

function CRC16(CRC: word; Data: Pointer; DataSize: longword): word; assembler;
asm
  and    EDX,EDX
  JZ     @Exit
  and    ECX,ECX
  JLE    @Exit
  PUSH   EBX
  PUSH   EDI
  xor    EBX,EBX
  LEA    EDI,CS:[OFFSET @CRC16]
  @Start:  MOV    BL,[EDX]
  xor    BL,AL
  shr    AX,8
  xor    AX,[EDI + EBX * 2]
  INC    EDX
  DEC    ECX
  JNZ    @Start
  POP    EDI
  POP    EBX
  @Exit:   RET
  NOP
  @CRC16:  DW     00000h, 0C0C1h, 0C181h, 00140h, 0C301h, 003C0h, 00280h, 0C241h
  DW     0C601h, 006C0h, 00780h, 0C741h, 00500h, 0C5C1h, 0C481h, 00440h
  DW     0CC01h, 00CC0h, 00D80h, 0CD41h, 00F00h, 0CFC1h, 0CE81h, 00E40h
  DW     00A00h, 0CAC1h, 0CB81h, 00B40h, 0C901h, 009C0h, 00880h, 0C841h
  DW     0D801h, 018C0h, 01980h, 0D941h, 01B00h, 0DBC1h, 0DA81h, 01A40h
  DW     01E00h, 0DEC1h, 0DF81h, 01F40h, 0DD01h, 01DC0h, 01C80h, 0DC41h
  DW     01400h, 0D4C1h, 0D581h, 01540h, 0D701h, 017C0h, 01680h, 0D641h
  DW     0D201h, 012C0h, 01380h, 0D341h, 01100h, 0D1C1h, 0D081h, 01040h
  DW     0F001h, 030C0h, 03180h, 0F141h, 03300h, 0F3C1h, 0F281h, 03240h
  DW     03600h, 0F6C1h, 0F781h, 03740h, 0F501h, 035C0h, 03480h, 0F441h
  DW     03C00h, 0FCC1h, 0FD81h, 03D40h, 0FF01h, 03FC0h, 03E80h, 0FE41h
  DW     0FA01h, 03AC0h, 03B80h, 0FB41h, 03900h, 0F9C1h, 0F881h, 03840h
  DW     02800h, 0E8C1h, 0E981h, 02940h, 0EB01h, 02BC0h, 02A80h, 0EA41h
  DW     0EE01h, 02EC0h, 02F80h, 0EF41h, 02D00h, 0EDC1h, 0EC81h, 02C40h
  DW     0E401h, 024C0h, 02580h, 0E541h, 02700h, 0E7C1h, 0E681h, 02640h
  DW     02200h, 0E2C1h, 0E381h, 02340h, 0E101h, 021C0h, 02080h, 0E041h
  DW     0A001h, 060C0h, 06180h, 0A141h, 06300h, 0A3C1h, 0A281h, 06240h
  DW     06600h, 0A6C1h, 0A781h, 06740h, 0A501h, 065C0h, 06480h, 0A441h
  DW     06C00h, 0ACC1h, 0AD81h, 06D40h, 0AF01h, 06FC0h, 06E80h, 0AE41h
  DW     0AA01h, 06AC0h, 06B80h, 0AB41h, 06900h, 0A9C1h, 0A881h, 06840h
  DW     07800h, 0B8C1h, 0B981h, 07940h, 0BB01h, 07BC0h, 07A80h, 0BA41h
  DW     0BE01h, 07EC0h, 07F80h, 0BF41h, 07D00h, 0BDC1h, 0BC81h, 07C40h
  DW     0B401h, 074C0h, 07580h, 0B541h, 07700h, 0B7C1h, 0B681h, 07640h
  DW     07200h, 0B2C1h, 0B381h, 07340h, 0B101h, 071C0h, 07080h, 0B041h
  DW     05000h, 090C1h, 09181h, 05140h, 09301h, 053C0h, 05280h, 09241h
  DW     09601h, 056C0h, 05780h, 09741h, 05500h, 095C1h, 09481h, 05440h
  DW     09C01h, 05CC0h, 05D80h, 09D41h, 05F00h, 09FC1h, 09E81h, 05E40h
  DW     05A00h, 09AC1h, 09B81h, 05B40h, 09901h, 059C0h, 05880h, 09841h
  DW     08801h, 048C0h, 04980h, 08941h, 04B00h, 08BC1h, 08A81h, 04A40h
  DW     04E00h, 08EC1h, 08F81h, 04F40h, 08D01h, 04DC0h, 04C80h, 08C41h
  DW     04400h, 084C1h, 08581h, 04540h, 08701h, 047C0h, 04680h, 08641h
  DW     08201h, 042C0h, 04380h, 08341h, 04100h, 081C1h, 08081h, 04040h
end;


{a Random generated Testvector 256bit - 32 Bytes, it's used for Self Test}
function GetTestVector: PAnsiChar; assembler; register;
asm
  MOV   EAX,OFFSET @Vector
  RET
  @Vector: DB    030h,044h,0EDh,06Eh,045h,0A4h,096h,0F5h
  DB    0F6h,035h,0A2h,0EBh,03Dh,01Ah,05Dh,0D6h
  DB    0CBh,01Dh,009h,082h,02Dh,0BDh,0F5h,060h
  DB    0C2h,0B8h,058h,0A1h,091h,0F9h,081h,0B1h
  DB    000h,000h,000h,000h,000h,000h,000h,000h
end;

{get the CPU Type from your system}
function GetCPUType: integer; assembler;
asm
  PUSH   EBX
  PUSH   ECX
  PUSH   EDX
  MOV    EBX,ESP
  and    ESP,0FFFFFFFCh
  PUSHFD
  PUSHFD
  POP    EAX
  MOV    ECX,EAX
  xor    EAX,40000h
  PUSH   EAX
  POPFD
  PUSHFD
  POP    EAX
  xor    EAX,ECX
  MOV    EAX,3
  JE     @Exit
  PUSHFD
  POP    EAX
  MOV    ECX,EAX
  xor    EAX,200000h
  PUSH   EAX
  POPFD
  PUSHFD
  POP    EAX
  xor    EAX,ECX
  MOV    EAX,4
  JE     @Exit
  PUSH   EBX
  MOV    EAX,1
  DB     0Fh,0A2h      //CPUID
  MOV    AL,AH
  and    EAX,0Fh
  POP    EBX
  @Exit:   POPFD
  MOV    ESP,EBX
  POP    EDX
  POP    ECX
  POP    EBX
end;

procedure ModuleUnload(Instance: {$IfDef XE}NativeInt{$Else}integer{$EndIf});
var // automaticaly deregistration
  I: integer;
begin
  if FStrFMTs <> nil then
    for I := FStrFMTs.Count - 1 downto 0 do
      if FindClassHInstance(TClass(FStrFMTs[I])) = longword(Instance) then
        FStrFMTs.Delete(I);
end;

initialization
  AddModuleUnloadProc(ModuleUnload);
  FCPUType := GetCPUType;
  if FCPUType > 3 then
  begin
    SwapInteger := BSwapInt;
    SwapIntegerBuffer := BSwapIntBuf;
  end
  else
  begin
    SwapInteger := SwapInt;
    SwapIntegerBuffer := SwapIntBuf;
  end;
  RegisterStringFormats([TStringFormat, TStringFormat_HEX, TStringFormat_HEXL,
    TStringFormat_MIME64, TStringFormat_UU, TStringFormat_XX]);

finalization
  RemoveModuleUnloadProc(ModuleUnload);
  FStrFMTs.Free;
  FStrFMTs := nil;
end.


