{Copyright:      Hagen Reddmann  mailto:HaReddmann@AOL.COM
 Author:         Hagen Reddmann
 Remarks:        freeware, but this Copyright must be included
 known Problems: none
 Version:        3.0,  Part I from Delphi Encryption Compendium  ( DEC Part I)
                 Delphi 2-4, designed and testet under D3 & D4
 Description:    Include a Selection of various Cipher's (Encryption Algo)
                 impl. Algo:
                   Gost, Blowfish, IDEA, SAFER in 6 Types,
                   SAFER-K40  (konvetional), SAFER-SK40 (with Keyscheduling),
                   SAFER-K64, SAFER-SK64, SAFER-K128, SAFER-SK128,
                   TEA, TEAN (TEA extended), SCOP, Q128, 3Way,
                   Twofish, Shark, Square

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

{$HINTS OFF}
 //-----------------------------------------------------//
 //                                                     //
 //  Modified by ComponentAce, 2003                     //
 //                                                     //
 //-----------------------------------------------------//

unit ZFCipher;

{$Include l3XE.inc}

interface

{$I ZFVer.Inc}
{$I VER.INC}


uses SysUtils, Classes, ZFDecUtil;

const
  Rijndael_Cipher = 1;
  RIPEMD_128_Hash = 0;
  RIPEMD_256_Hash = 1;

  Default_Cipher_Method = Rijndael_Cipher;
  Default_Hash_Method   = RIPEMD_128_Hash;

const {ErrorCode's for ECipherException}
  errGeneric    = 0;  {generic Error}
  errInvalidKey = 1;  {Decode Key is not correct}
  errInvalidKeySize = 2;  {Size of the Key is too large}
  errNotInitialized = 3;  {Methods Init() or InitKey() were not called}
  errInvalidMACMode = 4;  {CalcMAC can't use cmECB, cmOFB}
  errCantCalc   = 5;

type
  ECipherException = class(Exception)
  public
    ErrorCode: integer;
  end;

type


  {all Cipher Classes in this Unit, a good Selection}
  TCipherMode = (cmCTS, cmCBC, cmCFB, cmOFB, cmCTR, cmECB, cmCTSMAC, cmCBCMAC, cmCFBMAC);
{ the Cipher Modes:
  cmCTS     Cipher Text Stealing, a Variant from cmCBC, but relaxes
            the restriction that the DataSize must be a mulitply from BufSize,
            this is the Defaultmode, fast and Bytewise
  cmCBC     Cipher Block Chaining
  cmCFB     K-bit Cipher Feedback, here is K = 8 -> 1 Byte
  cmOFB     K-bit Output Feedback, here is K = 8 -> 1 Byte
  cmECB *   Electronic Codebook, DataSize must be a multiply from BufSize

  cmCTSMAC  Build a Message Authentication Code in cmCTS Mode
  cmCBCMAC  Build a CBC-MAC
  cmCFBMAC  Build a CFB-MAC
}

  TCipherClass = class of TCipher;
  //-------- from hash ------------
  // hash
  {the Base-Class of all Hashs}
  THash = class(TProtection)
  protected
    class function TestVector: Pointer; virtual; {must override}
    procedure CodeInit(Action: TPAction); override;
    {TProtection Methods, You can use a Hash to En/Decode}
    procedure CodeDone(Action: TPAction); override; {TProtection Methods}
    procedure CodeBuf(var Buffer; const BufferSize: integer; Action: TPAction);
      override; {TProtection Methods}
    procedure Protect(IsInit: boolean); {calls any installed Protection}
  public
    destructor Destroy; override;
    procedure Init; virtual;
    procedure Calc(const Data; DataSize: integer); virtual; {must override}
    procedure Done; virtual;
    function DigestKey: Pointer; virtual; {must override}
    function DigestStr(Format: integer): AnsiString;

    class function DigestKeySize: integer; virtual; {must override}
{$IFDEF VER_D4H} // new features from D4
    class function CalcBuffer(const Buffer; BufferSize: Integer; Protection: TProtection = nil; Format: Integer = fmtDEFAULT): AnsiString; overload;
    class function CalcStream(const Stream: TStream; StreamSize: Integer; Protection: TProtection = nil; Format: Integer = fmtDEFAULT): AnsiString; overload;
    class function CalcString(const Data: AnsiString; Protection: TProtection = nil; Format: Integer = fmtDEFAULT): AnsiString; overload;
    class function CalcFile(const FileName: AnsiString; Protection: TProtection = nil; Format: Integer = fmtDEFAULT): AnsiString; overload;
{$ELSE}
    class function CalcBuffer(const Buffer; BufferSize: integer;
      Protection: TProtection; Format: integer): AnsiString;
    class function CalcStream(const Stream: TStream; StreamSize: integer;
      Protection: TProtection; Format: integer): AnsiString;
    class function CalcString(const Data: AnsiString; Protection: TProtection;
      Format: integer): AnsiString;
    class function CalcFile(const FileName: AnsiString; Protection: TProtection;
      Format: integer): AnsiString;
{$ENDIF}
    {test the correct working}
    class function SelfTest: boolean;
  end;

{
// HMAC's - Hash Message Authentication Code's
  TMAC = class(TProtection) // generic MAC, encrypt Password with any AProtection and XOR's with
  protected                 // the Initstate from the Hash (DigestKey)
    FPassword: String;      // final Digest is encrypted with AProtecion
    procedure Init(Hash: THash); virtual;    // Only used in all THash Descends
    procedure Done(Hash: THash); virtual;    // Only used in all THash Descends
  public
    constructor Create(const Password: String; AProtection: TProtection);
    destructor Destroy; override;
  end;
}
  //-------- from hash end ------------

  THashClass = class of THash;

  TCipher = class(TProtection)
  private
    FMode:      TCipherMode;
    FHash:      THash;
    FHashClass: THashClass;
    FKeySize:   integer;
    FBufSize:   integer;
    FUserSize:  integer;
    FBuffer:    Pointer;
    FVector:    Pointer;
    FFeedback:  Pointer;
    FUser:      Pointer;
    FFlags:     integer;

    //fields for CTR mode
    ctrMode_Position : Integer;
    ctrMode_EncryptionBlock : Pointer;
    ctrMode_Nonce : Pointer;

    function GetHash: THash;
    procedure SetHashClass(Value: THashClass);
  protected
    function GetFlag(Index: integer): boolean;
    procedure SetFlag(Index: integer; Value: boolean); virtual;
    {used in method Init()}
    procedure InitBegin(var Size: integer);
    procedure InitEnd(IVector: Pointer); virtual;
    {must override}
    class procedure GetContext(var ABufSize, AKeySize, AUserSize: integer); virtual;
    class function TestVector: Pointer; virtual;
    {override TProtection Methods}
    procedure CodeInit(Action: TPAction); override;
    procedure CodeDone(Action: TPAction); override;
    procedure CodeBuf(var Buffer; const BufferSize: integer; Action: TPAction); override;
    {the encode function, must override}
    procedure Encode(Data: Pointer); virtual;
    {the decode function, must override}
    procedure Decode(Data: Pointer); virtual;
    {the individual Userdata and Buffer}
    property User: Pointer Read FUser;
    property Buffer: Pointer Read FBuffer;
    property UserSize: integer Read FUserSize;
  public
    constructor Create(const Password: AnsiString; AProtection: TProtection); overload;
    constructor Create(var key: PByteArray; keyLength : Word); overload;

    destructor Destroy; override;
    class function MaxKeySize: integer;
    {performs a Test of correct work}
    class function SelfTest: boolean;
    {initialization form the Cipher}
    procedure Init(const Key; Size: integer; IVector: Pointer); virtual;

    procedure InitKey(const Key: AnsiString; IVector: Pointer); overload;
    procedure InitKey(var Key: PByteArray; KeyLength : Word; IVector: Pointer); overload;

    {reset the Feedbackregister with the actual IVector}
    procedure Done; virtual;
    {protect the security Data's, Feedback, Buffer, Vector etc.}
    procedure Protect; virtual;

    procedure EncodeBuffer(const Source; var Dest; DataSize: integer);
    procedure DecodeBuffer(const Source; var Dest; DataSize: integer);


    {the Cipher Mode = cmXXX}
    property Mode: TCipherMode Read FMode Write FMode;
    {the Current Hash-Object, to build a Digest from InitKey()}
    property Hash: THash Read GetHash;
    {the Class of the Hash-Object}
    property HashClass: THashClass Read FHashClass Write SetHashClass;
    {the maximal KeySize and BufSize (Size of Feedback, Buffer and Vector}
    property KeySize: integer Read FKeySize;
    property BufSize: integer Read FBufSize;

    {Init() was called}
    property Initialized: boolean index 1 Read GetFlag Write SetFlag;
    {the actual IVector, BufSize Bytes long}
    property Vector: Pointer Read FVector;
    {the Feedback register, BufSize Bytes long}
    property Feedback: Pointer Read FFeedback;
    {the Key is set from InitKey() and the Hash.DigestKey^ include the encrypted Hash-Key}
    property HasHashKey: boolean index 0 Read GetFlag;
  end;

// now the Cipher's


function DefaultCipherClass: TCipherClass;
procedure SetDefaultCipherClass(CipherClass: TCipherClass);
procedure RaiseCipherException(const ErrorCode: integer; const Msg: string);
function RegisterCipher(const ACipher: TCipherClass;
  const AName, ADescription: string): boolean;
function UnregisterCipher(const ACipher: TCipherClass): boolean;
function CipherList: TStrings;
procedure CipherNames(List: TStrings);
function GetCipherClass(const Name: string): TCipherClass;
function GetCipherName(CipherClass: TCipherClass): string;

const
  CheckCipherKeySize: boolean = False;
{set to True raises Exception when Size of the Key is too large, (Method Init())
 otherwise will truncate the Key, default mode is False}

//------------ from cipher1 -----------
type
  TCipher_Rijndael = class(TCipher)
  private
    FRounds: integer;
  protected
    class procedure GetContext(var ABufSize, AKeySize, AUserSize: integer); override;
    class function TestVector: Pointer; override;
    procedure Encode(Data: Pointer); override;
    procedure Decode(Data: Pointer); override;
  public
    procedure Init(const Key; Size: integer; IVector: Pointer); override;
  end;

  TCipher_RijndaelZF = class(TCipher_Rijndael)
    procedure Init(const Key; Size: integer; IVector: Pointer); override;
  end;

  TCipher_Blowfish = class(TCipher)
  private
{$IFDEF UseASM}
  {$IFNDEF 486GE}  // no Support for <= CPU 386
    procedure Encode386(Data: Pointer);
    procedure Decode386(Data: Pointer);
  {$ENDIF}
{$ENDIF}
  protected
    class procedure GetContext(var ABufSize, AKeySize, AUserSize: integer); override;
    class function TestVector: Pointer; override;
    procedure Encode(Data: Pointer); override;
    procedure Decode(Data: Pointer); override;
  public
    procedure Init(const Key; Size: integer; IVector: Pointer); override;
  end;

  TCipher_1DES = class(TCipher)
  protected
    class procedure GetContext(var ABufSize, AKeySize, AUserSize: integer); override;
    class function TestVector: Pointer; override;
    procedure Encode(Data: Pointer); override;
    procedure Decode(Data: Pointer); override;
    procedure MakeKey(const Data: array of byte; Key_1: pointer; Reverse: boolean);
    //  procedure MakeKey(const Data: array of Byte; Key: PInteger; Reverse: Boolean);
  public
    procedure Init(const Key; Size: integer; IVector: Pointer); override;
  end;

  TCipher_3DES = class(TCipher_1DES)
  protected
    class procedure GetContext(var ABufSize, AKeySize, AUserSize: integer); override;
    class function TestVector: Pointer; override;
    procedure Encode(Data: Pointer); override;
    procedure Decode(Data: Pointer); override;
  public
    procedure Init(const Key; Size: integer; IVector: Pointer); override;
  end;

  TCipher_3TDES = class(TCipher_3DES)
  protected
    class procedure GetContext(var ABufSize, AKeySize, AUserSize: integer); override;
    class function TestVector: Pointer; override;
    procedure Encode(Data: Pointer); override;
    procedure Decode(Data: Pointer); override;
  end;

  TCipher_Twofish = class(TCipher)
  protected
    class procedure GetContext(var ABufSize, AKeySize, AUserSize: integer); override;
    class function TestVector: Pointer; override;
    procedure Encode(Data: Pointer); override;
    procedure Decode(Data: Pointer); override;
  public
    procedure Init(const Key; Size: integer; IVector: Pointer); override;
  end;

  TCipher_Square = class(TCipher)
  protected
    class procedure GetContext(var ABufSize, AKeySize, AUserSize: integer); override;
    class function TestVector: Pointer; override;
    procedure Encode(Data: Pointer); override;
    procedure Decode(Data: Pointer); override;
  public
    procedure Init(const Key; Size: integer; IVector: Pointer); override;
  end;


  //------------ from cipher1 end -----------
  //------------ from hash -----------
  THash_MD4 = class(THash)
  private
    FCount:  longword;
    FBuffer: array[0..63] of byte;
    FDigest: array[0..9] of longword;
  protected
    class function TestVector: Pointer; override;
    procedure Transform(Buffer: PIntArray); virtual;
  public
    class function DigestKeySize: integer; override;
    procedure Init; override;
    procedure Done; override;
    procedure Calc(const Data; DataSize: integer); override;
    function DigestKey: Pointer; override;
  end;

  THash_RipeMD128 = class(THash_MD4)
    {RACE Integrity Primitives Evaluation Message Digest}
  protected
    class function TestVector: Pointer; override;
    procedure Transform(Buffer: PIntArray); override;
  end;

  THash_RipeMD256 = class(THash_MD4)
  protected
    class function TestVector: Pointer; override;
    procedure Transform(Buffer: PIntArray); override;
  public
    {DigestKey-Size 256 bit}
    class function DigestKeySize: integer; override;
    procedure Init; override;
  end;

  // check sum
  TChecksum = class(THash);

// general
function DefaultHashClass: THashClass;
procedure SetDefaultHashClass(HashClass: THashClass);
function RegisterHash(const AHash: THashClass;
  const AName, ADescription: string): boolean;
function UnregisterHash(const AHash: THashClass): boolean;
function HashList: TStrings;
procedure HashNames(List: TStrings);
function GetHashClass(const Name: string): THashClass;
function GetHashName(HashClass: THashClass): string;

//------------ from hash end -----------

implementation

uses ZFDecConst, Windows;

{$I cipher1.inc}

const
  FDefaultHashClass: THashClass = THash_RipeMD256;
  FDefaultCipherClass: TCipherClass = TCipher_Rijndael;
  FCipherList: TStringList = nil;
  FHashList: TStringList   = nil;

function DefaultCipherClass: TCipherClass;
begin
  Result := FDefaultCipherClass;
end;

procedure SetDefaultCipherClass(CipherClass: TCipherClass);
begin
  if CipherClass = nil then
    FDefaultCipherClass := TCipher_Rijndael
  else
    FDefaultCipherClass := CipherClass;
end;

procedure RaiseCipherException(const ErrorCode: integer; const Msg: string);
var
  E: ECipherException;
begin
  E := ECipherException.Create(Msg);
  E.ErrorCode := ErrorCode;
  raise E;
end;

function RegisterCipher(const ACipher: TCipherClass;
  const AName, ADescription: string): boolean;
var
  I: integer;
  S: string;
begin
  Result := False;
  if ACipher = nil then
    Exit;
  S := Trim(AName);
  if S = '' then
  begin
    S := ACipher.ClassName;
    if S[1] = 'T' then
      Delete(S, 1, 1);
    I := Pos('_', S);
    if I > 0 then
      Delete(S, 1, I);
  end;
  S := S + '=' + ADescription;
  I := CipherList.IndexOfObject(Pointer(ACipher));
  if I < 0 then
    CipherList.AddObject(S, Pointer(ACipher))
  else
    CipherList[I] := S;
  Result := True;
end;

function UnregisterCipher(const ACipher: TCipherClass): boolean;
var
  I: integer;
begin
  Result := False;
  repeat
    I := CipherList.IndexOfObject(Pointer(ACipher));
    if I < 0 then
      Break;
    Result := True;
    CipherList.Delete(I);
  until False;
end;

function CipherList: TStrings;
begin
  if not IsObject(FCipherList, TStringList) then
    FCipherList := TStringList.Create;
  Result := FCipherList;
end;

procedure CipherNames(List: TStrings);
var
  I: integer;
begin
  if not IsObject(List, TStrings) then
    Exit;
  for I := 0 to CipherList.Count - 1 do
    List.AddObject(FCipherList.Names[I], FCipherList.Objects[I]);
end;

function GetCipherClass(const Name: string): TCipherClass;
var
  I: integer;
  N: string;
begin
  Result := nil;
  N      := Name;
  I      := Pos('_', N);
  if I > 0 then
    Delete(N, 1, I);
  for I := 0 to CipherList.Count - 1 do
    if AnsiCompareText(N, String(GetShortClassName(TClass(FCipherList.Objects[I])))) = 0 then
    begin
      Result := TCipherClass(FCipherList.Objects[I]);
      Exit;
    end;
  I := FCipherList.IndexOfName(N);
  if I >= 0 then
    Result := TCipherClass(FCipherList.Objects[I]);
end;

function GetCipherName(CipherClass: TCipherClass): string;
var
  I: integer;
begin
  I := CipherList.IndexOfObject(Pointer(CipherClass));
  if I >= 0 then
    Result := FCipherList.Names[I]
  else
    Result := String(GetShortClassName(CipherClass));
end;

function TCipher.GetFlag(Index: integer): boolean;
begin
  Result := FFlags and (1 shl Index) <> 0;
end;

procedure TCipher.SetFlag(Index: integer; Value: boolean);
begin
  Index := 1 shl Index;
  if Value then
    FFlags := FFlags or Index
  else
    FFlags := FFlags and not Index;
end;

procedure TCipher.InitBegin(var Size: integer);
begin
  Initialized := False;
  Protect;
  if Size < 0 then
    Size := 0;
  if Size > KeySize then
    if not CheckCipherKeySize then
      Size := KeySize
    else
      RaiseCipherException(errInvalidKeySize, Format(sInvalidKeySize,
        [ClassName, 0, KeySize]));
end;

procedure TCipher.InitEnd(IVector: Pointer);
begin
  if IVector = nil then
    Encode(Vector)
  else
    Move(IVector^, Vector^, BufSize);
  Move(Vector^, Feedback^, BufSize);
  Initialized := True;
end;

class procedure TCipher.GetContext(var ABufSize, AKeySize, AUserSize: integer);
begin
  ABufSize  := 0;
  AKeySize  := 0;
  AUserSize := 0;
end;

class function TCipher.TestVector: Pointer;
begin
  Result := GetTestVector;
end;

procedure TCipher.Encode(Data: Pointer);
begin
end;

procedure TCipher.Decode(Data: Pointer);
begin
end;

constructor TCipher.Create(const Password: AnsiString; AProtection: TProtection);
begin
  inherited Create(AProtection);
  FHashClass := DefaultHashClass;
  GetContext(FBufSize, FKeySize, FUserSize);
  GetMem(FVector, FBufSize);
  GetMem(FFeedback, FBufSize);
  GetMem(FBuffer, FBufSize);
  GetMem(FUser, FUserSize);
  GetMem(Self.ctrMode_EncryptionBlock, Self.FBufSize);
  GetMem(Self.ctrMode_Nonce, Self.FBufSize);

  Protect;

  Self.ctrMode_Position := Self.FBufSize;

  if Password <> '' then
    InitKey(Password, nil);

end;

constructor TCipher.Create(var key: PByteArray; keyLength : Word);
var i : Integer;
begin
   //FHashClass = DefaultHashClass();
   GetContext(FBufSize, FKeySize, FUserSize);
   GetMem(Self.FVector, FBufSize);
   GetMem(Self.FFeedback, FBufSize);
   GetMem(Self.FBuffer, FBufSize);
   GetMem(Self.FUser, FUserSize);
   GetMem(Self.ctrMode_EncryptionBlock, Self.FBufSize);
   GetMem(Self.ctrMode_Nonce, Self.FBufSize);

   Protect;
      
   Self.ctrMode_Position := Self.FBufSize;

   if (key <> nil) then
   begin
      InitKey(key, keyLength, nil);
   end;

end;

destructor TCipher.Destroy;
begin
  Protect;
  ReallocMem(FVector, 0);
  ReallocMem(FFeedback, 0);
  ReallocMem(FBuffer, 0);
  ReallocMem(FUser, 0);
  ReallocMem(Self.ctrMode_EncryptionBlock, 0);
  ReallocMem(Self.ctrMode_Nonce, 0);
  
  FHash.Release;
  FHash := nil;
  inherited Destroy;
end;

class function TCipher.MaxKeySize: integer;
var
  Dummy: integer;
begin
  GetContext(Dummy, Result, Dummy);
end;

class function TCipher.SelfTest: boolean;
var
  Data: array[0..63] of AnsiChar;
  Key:  AnsiString;
  SaveKeyCheck: boolean;
begin
  Result := InitTestIsOk; {have anonyme modified the testvectors ?}
  {we will use the ClassName as Key :-)}
  Key    := AnsiString(ClassName);
  SaveKeyCheck := CheckCipherKeySize;
  with Self.Create('', nil) do
    try
      CheckCipherKeySize := False;
      Mode := cmCTS;
      Init(PAnsiChar(Key)^, Length(Key), nil);
      EncodeBuffer(GetTestVector^, Data, 32);
      Result := Result and (MemCompare(TestVector, @Data, 32) = 0);
      Done;
      DecodeBuffer(Data, Data, 32);
      Result := Result and (MemCompare(GetTestVector, @Data, 32) = 0);
    finally
      CheckCipherKeySize := SaveKeyCheck;
      Free;
    end;
  FillChar(Data, SizeOf(Data), 0);
end;

procedure TCipher.Init(const Key; Size: integer; IVector: Pointer);
begin
end;

procedure TCipher.InitKey(const Key: AnsiString; IVector: Pointer);
var
  I: integer;
begin
  Hash.Init;
  Hash.Calc(PAnsiChar(Key)^, Length(Key));
  Hash.Done;
  I := Hash.DigestKeySize;
  if I > FKeySize then
    I := FKeySize; {generaly will truncate to large Keys}
  Init(Hash.DigestKey^, I, IVector);
  EncodeBuffer(Hash.DigestKey^, Hash.DigestKey^, Hash.DigestKeySize);
  Done;
  SetFlag(0, True);
end;

procedure TCipher.InitKey(var Key: PByteArray; KeyLength : Word; IVector: Pointer);
var
  I: integer;
  NewKey : PByteArray;
begin
  I := KeyLength;//Length(Key^);
  if I > FKeySize then
    I := FKeySize; {generaly will truncate to large Keys}

  Init(Key^, I, IVector);
  GetMem(NewKey, KeyLength);
  EncodeBuffer(Key^, NewKey^, KeyLength);
  FreeMem(Key);
  Key := NewKey;
  Done;
  SetFlag(0, True);
end;

procedure TCipher.Done;
begin
  if MemCompare(FVector, FFeedback, FBufSize) = 0 then
    Exit;
  Move(FFeedback^, FBuffer^, FBufSize);
  Move(FVector^, FFeedback^, FBufSize);
end;

procedure TCipher.Protect;
begin
  SetFlag(0, False);
  Initialized := False;
  // a Crypto Fanatican say: this is better !!
  FillChar(FVector^, FBufSize, $AA);
  FillChar(FFeedback^, FBufSize, $AA);
  FillChar(FBuffer^, FBufSize, $AA);
  FillChar(FUser^, FUserSize, $AA);

  FillChar(FVector^, FBufSize, $55);
  FillChar(FFeedback^, FBufSize, $55);
  FillChar(FBuffer^, FBufSize, $55);
  FillChar(FUser^, FUserSize, $55);

  FillChar(FVector^, FBufSize, $FF);
  FillChar(FFeedback^, FBufSize, $FF);
  FillChar(FBuffer^, FBufSize, 0);
  FillChar(FUser^, FUserSize, 0);

  FillChar(Self.ctrMode_Nonce^, FBufSize, 0);  
end;

function TCipher.GetHash: THash;
begin
  if not IsObject(FHash, THash) then
  begin
    if FHashClass = nil then
      FHashClass := DefaultHashClass;
    FHash := FHashClass.Create(nil);
    FHash.AddRef;
  end;
  Result := FHash;
end;

procedure TCipher.SetHashClass(Value: THashClass);
begin
  if Value <> FHashClass then
  begin
    FHash.Release;
    FHash      := nil;
    FHashClass := Value;
    if FHashClass = nil then
      FHashClass := DefaultHashClass;
  end;
end;


procedure TCipher.EncodeBuffer(const Source; var Dest; DataSize: integer);
var
  S, D, F: PByte;
  i, j, index : Integer;
begin
  if not Initialized then
    RaiseCipherException(errNotInitialized, Format(sNotInitialized, [ClassName]));
  S := @Source;
  D := @Dest;
  case FMode of
    cmECB:
    begin
      if S <> D then
        Move(S^, D^, DataSize);
      while DataSize >= FBufSize do
      begin
        Encode(D);
        Inc(D, FBufSize);
        Dec(DataSize, FBufSize);
      end;
      if DataSize > 0 then
      begin
        Move(D^, FBuffer^, DataSize);
        Encode(FBuffer);
        Move(FBuffer^, D^, DataSize);
      end;
    end;
    cmCTS:
    begin
      while DataSize >= FBufSize do
      begin
        XORBuffers(S, FFeedback, FBufSize, D);
        Encode(D);
        XORBuffers(D, FFeedback, FBufSize, FFeedback);
        Inc(S, FBufSize);
        Inc(D, FBufSize);
        Dec(DataSize, FBufSize);
      end;
      if DataSize > 0 then
      begin
        Move(FFeedback^, FBuffer^, FBufSize);
        Encode(FBuffer);
        XORBuffers(S, FBuffer, DataSize, D);
        XORBuffers(FBuffer, FFeedback, FBufSize, FFeedback);
      end;
    end;
    cmCBC:
    begin
      F := FFeedback;
      while DataSize >= FBufSize do
      begin
        XORBuffers(S, F, FBufSize, D);
        Encode(D);
        F := D;
        Inc(S, FBufSize);
        Inc(D, FBufSize);
        Dec(DataSize, FBufSize);
      end;
      Move(F^, FFeedback^, FBufSize);
      if DataSize > 0 then
      begin
        Move(FFeedback^, FBuffer^, FBufSize);
        Encode(FBuffer);
        XORBuffers(S, FBuffer, DataSize, D);
        XORBuffers(FBuffer, FFeedback, FBufSize, FFeedback);
      end;
    end;
    cmCTR:
    begin
       Move(S^, D^, DataSize);
       for i := 0 to DataSize -1 do
       begin
         index := 0;
         //if we reach the end of the ctrMode_Nonce
         if Self.ctrMode_Position = Self.FBufSize then
         begin
            //update nonce
            for j :=0 to 7 do
            begin
              if PByteArray(Self.ctrMode_Nonce)[j] < $ff then
              begin
                 PByteArray(Self.ctrMode_Nonce)[j] := Byte(PByteArray(Self.ctrMode_Nonce)[j] + 1);
                 Break;
              end
              else
                 PByteArray(Self.ctrMode_Nonce)[j] := 0;
            end;
            Move(Self.ctrMode_Nonce^, Self.ctrMode_EncryptionBlock^, Self.FBufSize);

            Self.Encode(Self.ctrMode_EncryptionBlock);
            Self.ctrMode_Position := 0;
          end;
          //increase positon
          index := Self.ctrMode_Position;
          Self.ctrMode_Position := Self.ctrMode_Position + 1;
          TByteArray(Dest)[i] := Byte(TByteArray(Dest)[i] xor PByteArray(Self.ctrMode_EncryptionBlock)[index]);
       end;
    end;
    cmCFB:
      while DataSize > 0 do
      begin
        Move(FFeedback^, FBuffer^, FBufSize);
        Encode(FBuffer);
        D^ := S^ xor PByte(FBuffer)^;
        Move(PByteArray(FFeedback)[1], FFeedback^, FBufSize - 1);
        PByteArray(FFeedback)[FBufSize - 1] := D^;
        Inc(D);
        Inc(S);
        Dec(DataSize);
      end;
    cmOFB:
      while DataSize > 0 do
      begin
        Move(FFeedback^, FBuffer^, FBufSize);
        Encode(FBuffer);
        D^ := S^ xor PByte(FBuffer)^;
        Move(PByteArray(FFeedback)[1], FFeedback^, FBufSize - 1);
        PByteArray(FFeedback)[FBufSize - 1] := PByte(FBuffer)^;
        Inc(D);
        Inc(S);
        Dec(DataSize);
      end;
    cmCTSMAC:
    begin
      while DataSize >= FBufSize do
      begin
        XORBuffers(S, FFeedback, FBufSize, FBuffer);
        Encode(FBuffer);
        XORBuffers(FBuffer, FFeedback, FBufSize, FFeedback);
        Inc(S, FBufSize);
        Dec(DataSize, FBufSize);
      end;
      if DataSize > 0 then
      begin
        Move(FFeedback^, FBuffer^, FBufSize);
        Encode(FBuffer);
        XORBuffers(FBuffer, FFeedback, FBufSize, FFeedback);
      end;
    end;
    cmCBCMAC:
    begin
      while DataSize >= FBufSize do
      begin
        XORBuffers(S, FFeedback, FBufSize, FBuffer);
        Encode(FBuffer);
        Move(FBuffer^, FFeedback^, FBufSize);
        Inc(S, FBufSize);
        Dec(DataSize, FBufSize);
      end;
      if DataSize > 0 then
      begin
        Move(FFeedback^, FBuffer^, FBufSize);
        Encode(FBuffer);
        XORBuffers(FBuffer, FFeedback, FBufSize, FFeedback);
      end;
    end;
    cmCFBMAC:
      while DataSize > 0 do
      begin
        Move(FFeedback^, FBuffer^, FBufSize);
        Encode(FBuffer);
        Move(PByteArray(FFeedback)[1], FFeedback^, FBufSize - 1);
        PByteArray(FFeedback)[FBufSize - 1] := S^ xor PByte(FBuffer)^;
        Inc(S);
        Dec(DataSize);
      end;
  end;
end;

procedure TCipher.DecodeBuffer(const Source; var Dest; DataSize: integer);
var
  S, D, F, B: PByte;
  i, j, index : Integer;
begin
  if not Initialized then
    RaiseCipherException(errNotInitialized, Format(sNotInitialized, [ClassName]));
  S := @Source;
  D := @Dest;
  case FMode of
    cmECB:
    begin
      if S <> D then
        Move(S^, D^, DataSize);
      while DataSize >= FBufSize do
      begin
        Decode(D);
        Inc(D, FBufSize);
        Dec(DataSize, FBufSize);
      end;
      if DataSize > 0 then
      begin
        Move(D^, FBuffer^, DataSize);
        Encode(FBuffer);
        Move(FBuffer^, D^, DataSize);
      end;
    end;
    cmCTS:
    begin
      if S <> D then
        Move(S^, D^, DataSize);
      F := FFeedback;
      B := FBuffer;
      while DataSize >= FBufSize do
      begin
        XORBuffers(D, F, FBufSize, B);
        Decode(D);
        XORBuffers(D, F, FBufSize, D);
        S := B;
        B := F;
        F := S;
        Inc(D, FBufSize);
        Dec(DataSize, FBufSize);
      end;
      if F <> FFeedback then
        Move(F^, FFeedback^, FBufSize);
      if DataSize > 0 then
      begin
        Move(FFeedback^, FBuffer^, FBufSize);
        Encode(FBuffer);
        XORBuffers(FBuffer, D, DataSize, D);
        XORBuffers(FBuffer, FFeedback, FBufSize, FFeedback);
      end;
    end;
    cmCTR:
    begin
       Move(S^, D^, DataSize);
       for i := 0 to DataSize -1 do
       begin
         index := 0;
         //if we reach the end of the ctrMode_Nonce
         if Self.ctrMode_Position = Self.FBufSize then
         begin
            //update nonce
            for j :=0 to 7 do
            begin
              if PByteArray(Self.ctrMode_Nonce)[j] < $ff then
              begin
                 PByteArray(Self.ctrMode_Nonce)[j] := Byte(PByteArray(Self.ctrMode_Nonce)[j] + 1);
                 Break;
              end
              else
                 PByteArray(Self.ctrMode_Nonce)[j] := 0;
            end;
            Move(Self.ctrMode_Nonce^, Self.ctrMode_EncryptionBlock^, Self.FBufSize);

            Self.Encode(Self.ctrMode_EncryptionBlock);
            Self.ctrMode_Position := 0;
          end;
          //increase positon
          index := Self.ctrMode_Position;
          Self.ctrMode_Position := Self.ctrMode_Position + 1;
          TByteArray(Dest)[i] := Byte(TByteArray(Dest)[i] xor PByteArray(Self.ctrMode_EncryptionBlock)[index]);
       end;
    end;
    cmCBC:
    begin
      if S <> D then
        Move(S^, D^, DataSize);
      F := FFeedback;
      B := FBuffer;
      while DataSize >= FBufSize do
      begin
        Move(D^, B^, FBufSize);
        Decode(D);
        XORBuffers(F, D, FBufSize, D);
        S := B;
        B := F;
        F := S;
        Inc(D, FBufSize);
        Dec(DataSize, FBufSize);
      end;
      if F <> FFeedback then
        Move(F^, FFeedback^, FBufSize);
      if DataSize > 0 then
      begin
        Move(FFeedback^, FBuffer^, FBufSize);
        Encode(FBuffer);
        XORBuffers(D, FBuffer, DataSize, D);
        XORBuffers(FBuffer, FFeedback, FBufSize, FFeedback);
      end;
    end;
    cmCFB:
      while DataSize > 0 do
      begin
        Move(FFeedback^, FBuffer^, FBufSize);
        Encode(FBuffer);
        Move(PByteArray(FFeedback)[1], FFeedback^, FBufSize - 1);
        PByteArray(FFeedback)[FBufSize - 1] := S^;
        D^ := S^ xor PByte(FBuffer)^;
        Inc(D);
        Inc(S);
        Dec(DataSize);
      end;
    cmOFB:
      while DataSize > 0 do
      begin
        Move(FFeedback^, FBuffer^, FBufSize);
        Encode(FBuffer);
        D^ := S^ xor PByte(FBuffer)^;
        Move(PByteArray(FFeedback)[1], FFeedback^, FBufSize - 1);
        PByteArray(FFeedback)[FBufSize - 1] := PByte(FBuffer)^;
        Inc(D);
        Inc(S);
        Dec(DataSize);
      end;
    cmCTSMAC, cmCBCMAC, cmCFBMAC:
    begin
      EncodeBuffer(Source, Dest, DataSize);
      Exit;
    end;
  end;
end;

procedure TCipher.CodeInit(Action: TPAction);
begin
  if not Initialized then
    RaiseCipherException(errNotInitialized, Format(sNotInitialized, [ClassName]));
{  if (Mode in [cmCBCMAC, cmCTSMAC, cmCFBMAC]) <> (Action = paCalc) then
    RaiseCipherException(errCantCalc, Format(sCantCalc, [ClassName]));}
  if Action <> paCalc then
    if Action <> paWipe then
      Done
    else
      RndXORBuffer(RndTimeSeed, FFeedback^, FBufSize);
  inherited CodeInit(Action);
end;

procedure TCipher.CodeDone(Action: TPAction);
begin
  inherited CodeDone(Action);
  if Action <> paCalc then
    if Action <> paWipe then
      Done
    else
      RndXORBuffer(RndTimeSeed, FFeedback^, FBufSize);
end;

procedure TCipher.CodeBuf(var Buffer; const BufferSize: integer; Action: TPAction);
begin
  if Action = paDecode then
  begin
    if Action in Actions then
      DecodeBuffer(Buffer, Buffer, BufferSize);
    inherited CodeBuf(Buffer, BufferSize, Action);
  end
  else
  begin
    inherited CodeBuf(Buffer, BufferSize, Action);
    if Action in Actions then
      EncodeBuffer(Buffer, Buffer, BufferSize);
  end;
end;



type
  PCipherRec = ^TCipherRec;
  TCipherRec = packed record
    case integer of
      0: (X: array[0..7] of byte);
      1: (A, B: longword);
  end;



{$IFDEF VER_D3H}
procedure ModuleUnload(Module: {$IfDef XE}NativeInt{$Else}Integer{$EndIf});
var
  I: Integer;
begin
  if IsObject(FCipherList, TStringList) then
    for I := FCipherList.Count-1 downto 0 do
      if FindClassHInstance(TClass(FCipherList.Objects[I])) = LongWord(Module) then
        FCipherList.Delete(I);
end;
{$ENDIF}

// ------- from cipher1 -----------------
const
  {don't change this}
  Rijndael_Blocks = 4;
  Rijndael_Rounds = 14;

class procedure TCipher_Rijndael.GetContext(var ABufSize, AKeySize, AUserSize: integer);
begin
  ABufSize  := Rijndael_Blocks * 4;
  AKeySize  := 32;
  AUserSize := (Rijndael_Rounds + 1) * Rijndael_Blocks * SizeOf(integer) * 2;
end;

class function TCipher_Rijndael.TestVector: Pointer;
asm
  MOV   EAX,OFFSET @Vector
  RET
  @Vector: DB    094h,06Dh,02Bh,05Eh,0E0h,0ADh,01Bh,05Ch
  DB    0A5h,023h,0A5h,013h,095h,08Bh,03Dh,02Dh
  DB    093h,087h,0F3h,037h,045h,051h,0F6h,058h
  DB    09Bh,0E7h,090h,01Bh,036h,087h,0F9h,0A9h
end;

procedure TCipher_Rijndael.Encode(Data: Pointer);
var
  P, K: PInteger;
  I, A, B, C, D: integer;
begin
  P := User;
  K := Data;
  for I := 2 to FRounds do
  begin
    A := K^ xor P^;
    Inc(P);
    Inc(K);
    B := K^ xor P^;
    Inc(P);
    Inc(K);
    C := K^ xor P^;
    Inc(P);
    Inc(K);
    D := K^ xor P^;
    Inc(P);

    K^ := Rijndael_T[0, D and $FF] xor Rijndael_T[1,
      A shr 8 and $FF] xor Rijndael_T[2, B shr 16 and $FF] xor
      Rijndael_T[3, C shr 24];
    Dec(K);
    K^ := Rijndael_T[0, C and $FF] xor Rijndael_T[1,
      D shr 8 and $FF] xor Rijndael_T[2, A shr 16 and $FF] xor
      Rijndael_T[3, B shr 24];
    Dec(K);
    K^ := Rijndael_T[0, B and $FF] xor Rijndael_T[1,
      C shr 8 and $FF] xor Rijndael_T[2, D shr 16 and $FF] xor
      Rijndael_T[3, A shr 24];
    Dec(K);
    K^ := Rijndael_T[0, A and $FF] xor Rijndael_T[1,
      B shr 8 and $FF] xor Rijndael_T[2, C shr 16 and $FF] xor
      Rijndael_T[3, D shr 24];
  end;

  A := K^ xor P^;
  Inc(P);
  Inc(K);
  B := K^ xor P^;
  Inc(P);
  Inc(K);
  C := K^ xor P^;
  Inc(P);
  Inc(K);
  D := K^ xor P^;
  Inc(P);

  K^ := Rijndael_S[0, D and $FF] or
    Rijndael_S[0, A shr 8 and $FF] shl 8 or
    Rijndael_S[0, B shr 16 and $FF] shl 16 or
    Rijndael_S[0, C shr 24] shl 24;
  Dec(K);
  K^ := Rijndael_S[0, C and $FF] or
    Rijndael_S[0, D shr 8 and $FF] shl 8 or
    Rijndael_S[0, A shr 16 and $FF] shl 16 or
    Rijndael_S[0, B shr 24] shl 24;
  Dec(K);
  K^ := Rijndael_S[0, B and $FF] or
    Rijndael_S[0, C shr 8 and $FF] shl 8 or
    Rijndael_S[0, D shr 16 and $FF] shl 16 or
    Rijndael_S[0, A shr 24] shl 24;
  Dec(K);
  K^ := Rijndael_S[0, A and $FF] or
    Rijndael_S[0, B shr 8 and $FF] shl 8 or
    Rijndael_S[0, C shr 16 and $FF] shl 16 or
    Rijndael_S[0, D shr 24] shl 24;

  for I := 1 to Rijndael_Blocks do
  begin
    K^ := K^ xor P^;
    Inc(P);
    Inc(K);
  end;
end;

procedure TCipher_Rijndael.Decode(Data: Pointer);
var
  P, K: PInteger;
  I, A, B, C, D: integer;
begin
  P := Pointer(PAnsiChar(User) + UserSize shr 1);
  Inc(P, FRounds * 4 + 3);
  K := Pointer(PAnsiChar(Data) + 12);
  for I := 2 to FRounds do
  begin
    D := K^ xor P^;
    Dec(P);
    Dec(K);
    C := K^ xor P^;
    Dec(P);
    Dec(K);
    B := K^ xor P^;
    Dec(P);
    Dec(K);
    A := K^ xor P^;
    Dec(P);

    K^ := Rijndael_T[4, A and $FF] xor Rijndael_T[5,
      D shr 8 and $FF] xor Rijndael_T[6, C shr 16 and $FF] xor
      Rijndael_T[7, B shr 24];
    Inc(K);
    K^ := Rijndael_T[4, B and $FF] xor Rijndael_T[5,
      A shr 8 and $FF] xor Rijndael_T[6, D shr 16 and $FF] xor
      Rijndael_T[7, C shr 24];
    Inc(K);
    K^ := Rijndael_T[4, C and $FF] xor Rijndael_T[5,
      B shr 8 and $FF] xor Rijndael_T[6, A shr 16 and $FF] xor
      Rijndael_T[7, D shr 24];
    Inc(K);
    K^ := Rijndael_T[4, D and $FF] xor Rijndael_T[5,
      C shr 8 and $FF] xor Rijndael_T[6, B shr 16 and $FF] xor
      Rijndael_T[7, A shr 24];
  end;

  D := K^ xor P^;
  Dec(P);
  Dec(K);
  C := K^ xor P^;
  Dec(P);
  Dec(K);
  B := K^ xor P^;
  Dec(P);
  Dec(K);
  A := K^ xor P^;
  Dec(P);

  K^ := Rijndael_S[1, A and $FF] or
    Rijndael_S[1, D shr 8 and $FF] shl 8 or
    Rijndael_S[1, C shr 16 and $FF] shl 16 or
    Rijndael_S[1, B shr 24] shl 24;
  Inc(K);
  K^ := Rijndael_S[1, B and $FF] or
    Rijndael_S[1, A shr 8 and $FF] shl 8 or
    Rijndael_S[1, D shr 16 and $FF] shl 16 or
    Rijndael_S[1, C shr 24] shl 24;
  Inc(K);
  K^ := Rijndael_S[1, C and $FF] or
    Rijndael_S[1, B shr 8 and $FF] shl 8 or
    Rijndael_S[1, A shr 16 and $FF] shl 16 or
    Rijndael_S[1, D shr 24] shl 24;
  Inc(K);
  K^ := Rijndael_S[1, D and $FF] or
    Rijndael_S[1, C shr 8 and $FF] shl 8 or
    Rijndael_S[1, B shr 16 and $FF] shl 16 or
    Rijndael_S[1, A shr 24] shl 24;

  for I := 0 to 3 do
  begin
    K^ := K^ xor P^;
    Dec(P);
    Dec(K);
  end;
end;

procedure TCipher_Rijndael.Init(const Key; Size: integer; IVector: Pointer);
var
  K: array[0..7] of integer;

  procedure BuildEncodeKey;
  const
    RND_Data: array[0..29] of byte = (
      $01, $02, $04, $08, $10, $20, $40, $80, $1B, $36, $6C, $D8, $AB, $4D, $9A,
      $2F, $5E, $BC, $63, $C6, $97, $35, $6A, $D4, $B3, $7D, $FA, $EF, $C5, $91);
  var
    T, R: integer;

    procedure NextRounds;
    var
      J: integer;
    begin
      J := 0;
      while (J < FRounds - 6) and (R <= FRounds) do
      begin
        while (J < FRounds - 6) and (T < Rijndael_Blocks) do
        begin
          PIntArray(User)[R * Rijndael_Blocks + T] := K[J];
          Inc(J);
          Inc(T);
        end;
        if T = Rijndael_Blocks then
        begin
          T := 0;
          Inc(R);
        end;
      end;
    end;

  var
    RND: PByte;
    B:   PByte;
    I:   integer;
  begin
    R   := 0;
    T   := 0;
    RND := @RND_Data;
    NextRounds;
    while R <= FRounds do
    begin
      B  := @K;
      B^ := B^ xor Rijndael_S[0, K[FRounds - 7] shr 8 and $FF] xor RND^;
      Inc(B);
      B^ := B^ xor Rijndael_S[0, K[FRounds - 7] shr 16 and $FF];
      Inc(B);
      B^ := B^ xor Rijndael_S[0, K[FRounds - 7] shr 24];
      Inc(B);
      B^ := B^ xor Rijndael_S[0, K[FRounds - 7] and $FF];
      Inc(RND);
      if FRounds = 14 then
      begin
        for I := 1 to 3 do
          K[I] := K[I] xor K[I - 1];
        B := @K[4];
        B^ := B^ xor Rijndael_S[0, K[3] and $FF];
        Inc(B);
        B^ := B^ xor Rijndael_S[0, K[3] shr 8 and $FF];
        Inc(B);
        B^ := B^ xor Rijndael_S[0, K[3] shr 16 and $FF];
        Inc(B);
        B^ := B^ xor Rijndael_S[0, K[3] shr 24];
        for I := 5 to 7 do
          K[I] := K[I] xor K[I - 1];
      end
      else
        for I := 1 to FRounds - 7 do
          K[I] := K[I] xor K[I - 1];
      NextRounds;
    end;
  end;

  procedure BuildDecodeKey;
  var
    I: integer;
    D: PInteger;
  begin
    D := Pointer(PAnsiChar(User) + UserSize shr 1);
    Move(User^, D^, UserSize shr 1);
    Inc(D, 4);
    for I := 0 to FRounds * 4 - 5 do
    begin
      D^ := Rijndael_Key[D^ and $FF] xor
        ROL(Rijndael_Key[D^ shr 8 and $FF], 8) xor
        ROL(Rijndael_Key[D^ shr 16 and $FF], 16) xor
        ROL(Rijndael_Key[D^ shr 24], 24);
      Inc(D);
    end;
  end;

begin
  InitBegin(Size);
  if Size <= 16 then
    FRounds := 10
  else
  if Size <= 24 then
    FRounds := 12
  else
    FRounds := 14;
  FillChar(K, SizeOf(K), 0);
  Move(Key, K, Size);
  BuildEncodeKey;
  BuildDecodeKey;
  FillChar(K, SizeOf(K), 0);
  InitEnd(IVector);
end;

procedure TCipher_RijndaelZF.Init(const Key; Size: integer; IVector: Pointer);
var
  K: array[0..7] of integer;

  procedure BuildEncodeKey;
  const
    RND_Data: array[0..29] of byte = (
      $01, $02, $04, $08, $10, $20, $40, $80, $1B, $36, $6C, $D8, $AB, $4D, $9A,
      $2F, $5E, $BC, $63, $C6, $97, $35, $6A, $D4, $B3, $7D, $FA, $EF, $C5, $91);
  var
    T, R: integer;

    procedure NextRounds;
    var
      J: integer;
    begin
      J := 0;
      while (J < FRounds - 6) and (R <= FRounds) do
      begin
        while (J < FRounds - 6) and (T < Rijndael_Blocks) do
        begin
          PIntArray(User)[R * Rijndael_Blocks + T] := K[J];
          Inc(J);
          Inc(T);
        end;
        if T = Rijndael_Blocks then
        begin
          T := 0;
          Inc(R);
        end;
      end;
    end;

  var
    RND: PByte;
    B:   PByte;
    I:   integer;
  begin
    R   := 0;
    T   := 0;
    RND := @RND_Data;
    NextRounds;
    while R <= FRounds do
    begin
      B  := @K;
      B^ := B^ xor Rijndael_S[0, K[FRounds - 7] shr 8 and $FF] xor RND^;
      Inc(B);
      B^ := B^ xor Rijndael_S[0, K[FRounds - 7] shr 16 and $FF];
      Inc(B);
      B^ := B^ xor Rijndael_S[0, K[FRounds - 7] shr 24];
      Inc(B);
      B^ := B^ xor Rijndael_S[0, K[FRounds - 7] and $FF];
      Inc(RND);
      if FRounds = 14 then
      begin
        for I := 1 to 7 do
          K[I] := K[I] xor K[I - 1];
        B := @K[4];
        B^ := B^ xor Rijndael_S[0, K[3] and $FF];
        Inc(B);
        B^ := B^ xor Rijndael_S[0, K[3] shr 8 and $FF];
        Inc(B);
        B^ := B^ xor Rijndael_S[0, K[3] shr 16 and $FF];
        Inc(B);
        B^ := B^ xor Rijndael_S[0, K[3] shr 24];
        for I := 5 to 7 do
          K[I] := K[I] xor K[I - 1];
      end
      else
        for I := 1 to FRounds - 7 do
          K[I] := K[I] xor K[I - 1];
      NextRounds;
    end;
  end;

  procedure BuildDecodeKey;
  var
    I: integer;
    D: PInteger;
  begin
    D := Pointer(PAnsiChar(User) + UserSize shr 1);
    Move(User^, D^, UserSize shr 1);
    Inc(D, 4);
    for I := 0 to FRounds * 4 - 5 do
    begin
      D^ := Rijndael_Key[D^ and $FF] xor
        ROL(Rijndael_Key[D^ shr 8 and $FF], 8) xor
        ROL(Rijndael_Key[D^ shr 16 and $FF], 16) xor
        ROL(Rijndael_Key[D^ shr 24], 24);
      Inc(D);
    end;
  end;

begin
  InitBegin(Size);
  if Size <= 16 then
    FRounds := 10
  else
  if Size <= 24 then
    FRounds := 12
  else
    FRounds := 14;
  FillChar(K, SizeOf(K), 0);
  Move(Key, K, Size);
  BuildEncodeKey;
  BuildDecodeKey;
  FillChar(K, SizeOf(K), 0);
  InitEnd(IVector);
end;


// blowfish
class procedure TCipher_Blowfish.GetContext(var ABufSize, AKeySize, AUserSize: integer);
begin
  ABufSize  := 8;
  AKeySize  := 56;
  AUserSize := SizeOf(Blowfish_Data) + SizeOf(Blowfish_Key);
end;

class function TCipher_Blowfish.TestVector: Pointer;
asm
  MOV   EAX,OFFSET @Vector
  RET
  @Vector: DB    019h,071h,0CAh,0CDh,02Bh,09Ch,085h,029h
  DB    0DAh,081h,047h,0B7h,0EBh,0CEh,016h,0C6h
  DB    091h,00Eh,01Dh,0C8h,040h,012h,03Eh,035h
  DB    070h,0EDh,0BCh,096h,04Ch,013h,0D0h,0B8h
end;

type
  PBlowfish = ^TBlowfish;
  TBlowfish = array[0..3, 0..255] of longword;

{$IFDEF UseASM}
  {$IFNDEF 486GE}  // no Support for <= CPU 386
procedure TCipher_Blowfish.Encode386(Data: Pointer);
asm  // specaly for CPU < 486
        PUSH   EDI
        PUSH   ESI
        PUSH   EBX
        PUSH   EBP
        PUSH   EDX

        MOV    ESI,[EAX].TCipher_Blowfish.FUser

        MOV    EBX,[EDX]         // A
        MOV    EDX,[EDX + 4]     // B

        XCHG   BL,BH       // here BSWAP EBX,EDX
        XCHG   DL,DH
        ROL    EBX,16
        ROL    EDX,16
        XCHG   BL,BH
        XCHG   DL,DH

        XOR    EBX,[ESI + 4 * 256 * 4]
        XOR    EDI,EDI

@@1:    MOV    EAX,EBX
        SHR    EBX,16

        MOVZX  ECX,BH
        MOV    EBP,[ESI + ECX * 4 + 1024 * 0]
        MOVZX  ECX,BL
        ADD    EBP,[ESI + ECX * 4 + 1024 * 1]

        MOVZX  ECX,AH
        XOR    EBP,[ESI + ECX * 4 + 1024 * 2]
        MOVZX  ECX,AL
        ADD    EBP,[ESI + ECX * 4 + 1024 * 3]
        XOR    EDX,[ESI + 4 * 256 * 4 + 4 + EDI * 4]

        XOR    EBP,EDX
        MOV    EDX,EAX
        MOV    EBX,EBP
        INC    EDI
        TEST   EDI,010h
        JZ     @@1

        POP    EAX
        XOR    EDX,[ESI + 4 * 256 * 4 + 17 * 4]

        XCHG   BL,BH        // here BSWAP EBX,EDX
        XCHG   DL,DH
        ROL    EBX,16
        ROL    EDX,16
        XCHG   BL,BH
        XCHG   DL,DH

        MOV    [EAX],EDX
        MOV    [EAX + 4],EBX

        POP    EBP
        POP    EBX
        POP    ESI
        POP    EDI
end;

procedure TCipher_Blowfish.Decode386(Data: Pointer);
asm // specaly for CPU < 486
        PUSH   EDI
        PUSH   ESI
        PUSH   EBX
        PUSH   EBP
        PUSH   EDX

        MOV    ESI,[EAX].TCipher_Blowfish.FUser

        MOV    EBX,[EDX]         // A
        MOV    EDX,[EDX + 4]     // B

        XCHG   BL,BH
        XCHG   DL,DH
        ROL    EBX,16
        ROL    EDX,16
        XCHG   BL,BH
        XCHG   DL,DH

        XOR    EBX,[ESI + 4 * 256 * 4 + 17 * 4]

        MOV    EDI,16

@@1:    MOV    EAX,EBX
        SHR    EBX,16

        MOVZX  ECX,BH
        MOV    EBP,[ESI + ECX * 4 + 1024 * 0]
        MOVZX  ECX,BL
        ADD    EBP,[ESI + ECX * 4 + 1024 * 1]

        MOVZX  ECX,AH
        XOR    EBP,[ESI + ECX * 4 + 1024 * 2]
        MOVZX  ECX,AL
        ADD    EBP,[ESI + ECX * 4 + 1024 * 3]
        XOR    EDX,[ESI + 4 * 256 * 4 + EDI * 4]

        XOR    EBP,EDX
        MOV    EDX,EAX
        MOV    EBX,EBP

        DEC    EDI
        JNZ    @@1

        POP    EAX
        XOR    EDX,[ESI + 4 * 256 * 4]

        XCHG   BL,BH        // BSWAP
        XCHG   DL,DH
        ROL    EBX,16
        ROL    EDX,16
        XCHG   BL,BH
        XCHG   DL,DH

        MOV    [EAX],EDX
        MOV    [EAX + 4],EBX

        POP    EBP
        POP    EBX
        POP    ESI
        POP    EDI
end;
  {$ENDIF} //486GE
{$ENDIF}

procedure TCipher_Blowfish.Encode(Data: Pointer);
{$IFDEF UseASM}  // specialy for CPU >= 486
asm
        PUSH   EDI
        PUSH   ESI
        PUSH   EBX
        PUSH   EBP
        PUSH   EDX

        MOV    ESI,[EAX].TCipher_Blowfish.FUser
        MOV    EBX,[EDX]         // A
        MOV    EBP,[EDX + 4]     // B

        BSWAP  EBX               // CPU >= 486
        BSWAP  EBP

        XOR    EDI,EDI
        XOR    EBX,[ESI + 4 * 256 * 4]
//      XOR    ECX,ECX
@@1:

        MOV    EAX,EBX
        SHR    EBX,16
        MOVZX  ECX,BH     // it's faster with AMD Chips,
//        MOV    CL,BH    // it's faster with PII's
        MOV    EDX,[ESI + ECX * 4 + 1024 * 0]
        MOVZX  ECX,BL
//        MOV    CL,BL
        ADD    EDX,[ESI + ECX * 4 + 1024 * 1]

        MOVZX  ECX,AH
//        MOV    CL,AH
        XOR    EDX,[ESI + ECX * 4 + 1024 * 2]
        MOVZX  ECX,AL
//        MOV    CL,AL
        ADD    EDX,[ESI + ECX * 4 + 1024 * 3]
        XOR    EBP,[ESI + 4 * 256 * 4 + 4 + EDI * 4]

        INC    EDI
        XOR    EDX,EBP
        TEST   EDI,010h
        MOV    EBP,EAX
        MOV    EBX,EDX
        JZ     @@1

        POP    EAX
        XOR    EBP,[ESI + 4 * 256 * 4 + 17 * 4]

        BSWAP  EBX
        BSWAP  EBP

        MOV    [EAX],EBP
        MOV    [EAX + 4],EBX

        POP    EBP
        POP    EBX
        POP    ESI
        POP    EDI
end;
{$ELSE}
var
  I, A, B: longword;
  P: PIntArray;
  D: PBlowfish;
  t0, t1, t2, t3: Cardinal;
begin
  D := User;
  P := Pointer(PAnsiChar(User) + SizeOf(Blowfish_Data));
  A := SwapInteger(PCipherRec(Data).A) xor P[0];
  Inc(PInteger(P));
  B := SwapInteger(PCipherRec(Data).B);

  for I := 0 to 7 do
  begin
    t0 := D[0, A shr 24];
    t1 := D[1, A shr 16 and $FF];
    t2 := D[2, A shr 8 and $FF];
    t3 := D[3, A and $FF];
    B := B xor P[0] xor (t0 + t1 xor t2 + t3);
    t0 := D[0, B shr 24];
    t1 := D[1, B shr 16 and $FF];
    t2 := D[2, B shr 8 and $FF];
    t3 := D[3, B and $FF];
    A := A xor P[1] xor (t0 + t1 xor t2 + t3);
    Inc(PInteger(P), 2);
  end;
  PCipherRec(Data).A := SwapInteger(B xor P[0]);
  PCipherRec(Data).B := SwapInteger(A);
end;

{$ENDIF}

procedure TCipher_Blowfish.Decode(Data: Pointer);
{$IFDEF UseASM}
asm
        PUSH   EDI
        PUSH   ESI
        PUSH   EBX
        PUSH   EBP
        PUSH   EDX

        MOV    ESI,[EAX].TCipher_Blowfish.FUser
        MOV    EBX,[EDX]         // A
        MOV    EBP,[EDX + 4]     // B

        BSWAP  EBX
        BSWAP  EBP

        XOR    EBX,[ESI + 4 * 256 * 4 + 17 * 4]
        MOV    EDI,16
//        XOR    ECX,ECX

@@1:    MOV    EAX,EBX
        SHR    EBX,16

        MOVZX  ECX,BH
//        MOV    CL,BH
        MOV    EDX,[ESI + ECX * 4 + 1024 * 0]
        MOVZX  ECX,BL
//        MOV    CL,BL
        ADD    EDX,[ESI + ECX * 4 + 1024 * 1]

        MOVZX  ECX,AH
//        MOV    CL,AH
        XOR    EDX,[ESI + ECX * 4 + 1024 * 2]
        MOVZX  ECX,AL
//        MOV    CL,AL
        ADD    EDX,[ESI + ECX * 4 + 1024 * 3]
        XOR    EBP,[ESI + 4 * 256 * 4 + EDI * 4]

        XOR    EDX,EBP
        DEC    EDI
        MOV    EBP,EAX
        MOV    EBX,EDX
        JNZ    @@1

        POP    EAX
        XOR    EBP,[ESI + 4 * 256 * 4]

        BSWAP  EBX
        BSWAP  EBP

        MOV    [EAX],EBP
        MOV    [EAX + 4],EBX

        POP    EBP
        POP    EBX
        POP    ESI
        POP    EDI
end;
{$ELSE}
var
  I, A, B: longword;
  P: PIntArray;
  D: PBlowfish;
begin
  D := User;
  P := Pointer(PAnsiChar(User) + SizeOf(Blowfish_Data) + SizeOf(Blowfish_Key) -
    SizeOf(integer));
  A := SwapInteger(PCipherRec(Data).A) xor P[0];
  B := SwapInteger(PCipherRec(Data).B);
  for I := 0 to 7 do
  begin
    Dec(PInteger(P), 2);
    B := B xor P[1] xor (D[0, A shr 24] +
      D[1, A shr 16 and $FF] xor
      D[2, A shr 8 and $FF] +
      D[3, A and $FF]);
    A := A xor P[0] xor (D[0, B shr 24] +
      D[1, B shr 16 and $FF] xor
      D[2, B shr 8 and $FF] +
      D[3, B and $FF]);
  end;
  Dec(PInteger(P));
  PCipherRec(Data).A := SwapInteger(B xor P[0]);
  PCipherRec(Data).B := SwapInteger(A);
end;

{$ENDIF}

procedure TCipher_Blowfish.Init(const Key; Size: integer; IVector: Pointer);
var
  I, J: integer;
  B:    array[0..7] of byte;
  K:    PByteArray;
  P:    PIntArray;
  S:    PBlowfish;
begin
  InitBegin(Size);
  K := @Key;
  S := User;
  P := Pointer(PAnsiChar(User) + SizeOf(Blowfish_Data));
  Move(Blowfish_Data, S^, SizeOf(Blowfish_Data));
  Move(Blowfish_Key, P^, Sizeof(Blowfish_Key));
  J := 0;
  for I := 0 to 17 do
  begin
    P[I] := P[I] xor (K[(J+0) mod Size] shl 24 + K[(J+1) mod Size] shl 16 + K[(J+2) mod Size] shl 8 + K[(J+3) mod Size]);
    J    := (J + 4) mod Size;
  end;
  FillChar(B, SizeOf(B), 0);
  for I := 0 to 8 do
  begin
    Encode(@B);
    P[I * 2]     := SwapInteger(PCipherRec(@B).A);
    P[I * 2 + 1] := SwapInteger(PCipherRec(@B).B);
  end;
  for I := 0 to 3 do
    for J := 0 to 127 do
    begin
      Encode(@B);
      S[I, J * 2]     := SwapInteger(PCipherRec(@B).A);
      S[I, J * 2 + 1] := SwapInteger(PCipherRec(@B).B);
    end;

  FillChar(B, SizeOf(B), 0);
  InitEnd(IVector);
end; {Blowfish}

{DES}
procedure DES_Func(Data: PIntArray; Key: PInteger); register;
var
  L, R, X, Y, I: longword;
begin
  L := SwapInteger(Data[0]);
  R := SwapInteger(Data[1]);

  X := (L shr 4 xor R) and $0F0F0F0F;
  R := R xor X;
  L := L xor X shl 4;
  X := (L shr 16 xor R) and $0000FFFF;
  R := R xor X;
  L := L xor X shl 16;
  X := (R shr 2 xor L) and $33333333;
  L := L xor X;
  R := R xor X shl 2;
  X := (R shr 8 xor L) and $00FF00FF;
  L := L xor X;
  R := R xor X shl 8;

  R := R shl 1 or R shr 31;
  X := (L xor R) and $AAAAAAAA;
  R := R xor X;
  L := L xor X;
  L := L shl 1 or L shr 31;

  for I := 0 to 7 do
  begin
    X := (R shl 28 or R shr 4) xor Key^;
    Inc(Key);
    Y := R xor Key^;
    Inc(Key);
    L := L xor (DES_Data[0, X and $3F] or DES_Data[1, X shr 8 and $3F] or
      DES_Data[2, X shr 16 and $3F] or DES_Data[3, X shr 24 and $3F] or
      DES_Data[4, Y and $3F] or DES_Data[5, Y shr 8 and $3F] or
      DES_Data[6, Y shr 16 and $3F] or DES_Data[7, Y shr 24 and $3F]);

    X := (L shl 28 or L shr 4) xor Key^;
    Inc(Key);
    Y := L xor Key^;
    Inc(Key);
    R := R xor (DES_Data[0, X and $3F] or DES_Data[1, X shr 8 and $3F] or
      DES_Data[2, X shr 16 and $3F] or DES_Data[3, X shr 24 and $3F] or
      DES_Data[4, Y and $3F] or DES_Data[5, Y shr 8 and $3F] or
      DES_Data[6, Y shr 16 and $3F] or DES_Data[7, Y shr 24 and $3F]);
  end;

  R := R shl 31 or R shr 1;
  X := (L xor R) and $AAAAAAAA;
  R := R xor X;
  L := L xor X;
  L := L shl 31 or L shr 1;

  X := (L shr 8 xor R) and $00FF00FF;
  R := R xor X;
  L := L xor X shl 8;
  X := (L shr 2 xor R) and $33333333;
  R := R xor X;
  L := L xor X shl 2;
  X := (R shr 16 xor L) and $0000FFFF;
  L := L xor X;
  R := R xor X shl 16;
  X := (R shr 4 xor L) and $0F0F0F0F;
  L := L xor X;
  R := R xor X shl 4;

  Data[0] := SwapInteger(R);
  Data[1] := SwapInteger(L);
end;

class procedure TCipher_1DES.GetContext(var ABufSize, AKeySize, AUserSize: integer);
begin
  ABufSize  := 8;
  AKeySize  := 8;
  AUserSize := 32 * 4 * 2;
end;

class function TCipher_1DES.TestVector: Pointer;
asm
  MOV   EAX,OFFSET @Vector
  RET
  @Vector: DB    0ADh,069h,042h,0BBh,0F6h,068h,020h,04Dh
  DB    053h,0CDh,0C7h,062h,013h,093h,098h,0C0h
  DB    030h,00Dh,085h,00Bh,0E2h,0AAh,072h,009h
  DB    06Fh,0DBh,05Fh,08Eh,0D3h,0E4h,0CFh,08Ah
end;

procedure TCipher_1DES.Encode(Data: Pointer);
begin
  DES_Func(Data, User);
end;

procedure TCipher_1DES.Decode(Data: Pointer);
begin
  DES_Func(Data, @PIntArray(User)[32]);
end;

procedure TCipher_1DES.MakeKey(const Data: array of byte; Key_1: pointer;
  Reverse: boolean);
//MakeKey(const Data: array of Byte; Key: PInteger; Reverse: Boolean);
const
  ROT: array[0..15] of byte = (1, 2, 4, 6, 8, 10, 12, 14, 15, 17, 19, 21, 23, 25, 27, 28);
var
  I, J, L, M, N: longword;
  PC_M, PC_R: array[0..55] of byte;
  K:   array[0..31] of longword;
  Key: PInteger;
begin
  Key := PInteger(Key_1);
  FillChar(K, SizeOf(K), 0);
  for I := 0 to 55 do
    if Data[DES_PC1[I] shr 3] and ($80 shr (DES_PC1[I] and $07)) <> 0 then
      PC_M[I] := 1
    else
      PC_M[I] := 0;
  for I := 0 to 15 do
  begin
    if Reverse then
      M := (15 - I) shl 1
    else
      M := I shl 1;
    N := M + 1;
    for J := 0 to 27 do
    begin
      L := J + ROT[I];
      if L < 28 then
        PC_R[J] := PC_M[L]
      else
        PC_R[J] := PC_M[L - 28];
    end;
    for J := 28 to 55 do
    begin
      L := J + ROT[I];
      if L < 56 then
        PC_R[J] := PC_M[L]
      else
        PC_R[J] := PC_M[L - 28];
    end;
    L := $1000000;
    for J := 0 to 23 do
    begin
      L := L shr 1;
      if PC_R[DES_PC2[J]] <> 0 then
        K[M] := K[M] or L;
      if PC_R[DES_PC2[J + 24]] <> 0 then
        K[N] := K[N] or L;
    end;
  end;
  for I := 0 to 15 do
  begin
    M    := I shl 1;
    N    := M + 1;
    Key^ := K[M] and $00FC0000 shl 6 or K[M] and $00000FC0 shl
      10 or K[N] and $00FC0000 shr 10 or K[N] and $00000FC0 shr 6;
    Inc(Key);
    Key^ := K[M] and $0003F000 shl 12 or K[M] and $0000003F shl
      16 or K[N] and $0003F000 shr 4 or K[N] and $0000003F;
    Inc(Key);
  end;
end;

procedure TCipher_1DES.Init(const Key; Size: integer; IVector: Pointer);
var
  K: array[0..7] of byte;
begin
  InitBegin(Size);
  FillChar(K, SizeOf(K), 0);
  Move(Key, K, Size);
  MakeKey(K, User, False);
  MakeKey(K, @PIntArray(User)[32], True);
  FillChar(K, SizeOf(K), 0);
  InitEnd(IVector);
end;

class procedure TCipher_3DES.GetContext(var ABufSize, AKeySize, AUserSize: integer);
begin
  ABufSize  := 8;
  AKeySize  := 24;
  AUserSize := 32 * 4 * 2 * 3;
end;

class function TCipher_3DES.TestVector: Pointer;
asm
  MOV   EAX,OFFSET @Vector
  RET
  @Vector: DB    007h,04Ch,014h,0F3h,0E2h,02Eh,008h,0D9h
  DB    064h,0BFh,06Fh,082h,0B5h,0DFh,0F0h,0A2h
  DB    02Fh,02Dh,03Bh,0DBh,017h,0DBh,025h,0B6h
  DB    0B5h,01Eh,0FAh,071h,037h,02Fh,0D1h,072h
end;

procedure TCipher_3DES.Encode(Data: Pointer);
begin
  DES_Func(Data, User);
  DES_Func(Data, @PIntArray(User)[32]);
  DES_Func(Data, @PIntArray(User)[64]);
end;

procedure TCipher_3DES.Decode(Data: Pointer);
begin
  DES_Func(Data, @PIntArray(User)[96]);
  DES_Func(Data, @PIntArray(User)[128]);
  DES_Func(Data, @PIntArray(User)[160]);
end;

procedure TCipher_3DES.Init(const Key; Size: integer; IVector: Pointer);
var
  K: array[0..23] of byte;
  P: PInteger;
begin
  InitBegin(Size);
  FillChar(K, SizeOf(K), 0);
  Move(Key, K, Size);
  P := User;
  MakeKey(K[0], P, False);
  Inc(P, 32);
  MakeKey(K[8], P, True);
  Inc(P, 32);
  MakeKey(K[16], P, False);
  Inc(P, 32);
  MakeKey(K[16], P, True);
  Inc(P, 32);
  MakeKey(K[8], P, False);
  Inc(P, 32);
  MakeKey(K[0], P, True);
  FillChar(K, SizeOf(K), 0);
  InitEnd(IVector);
end;

class procedure TCipher_3TDES.GetContext(var ABufSize, AKeySize, AUserSize: integer);
begin
  inherited GetContext(ABufSize, AKeySize, AUserSize);
  ABufSize := 24;
end;

class function TCipher_3TDES.TestVector: Pointer;
asm
  MOV   EAX,OFFSET @Vector
  RET
  @Vector: DB    00Bh,012h,0E4h,08Bh,0D9h,0CDh,008h,0BFh
  DB    0CAh,0AEh,03Eh,05Fh,0F6h,0FEh,013h,0CDh
  DB    03Fh,070h,06Eh,0CDh,053h,056h,03Fh,05Ah
  DB    080h,00Fh,01Bh,01Eh,0FBh,09Ah,057h,096h
end;

procedure TCipher_3TDES.Encode(Data: Pointer);
var
  T: integer;
begin
  DES_Func(@PIntArray(Data)[0], User);
  DES_Func(@PIntArray(Data)[2], User);
  DES_Func(@PIntArray(Data)[4], User);
  T := PIntArray(Data)[1];
  PIntArray(Data)[1] := PIntArray(Data)[2];
  PIntArray(Data)[2] := T;
  T := PIntArray(Data)[3];
  PIntArray(Data)[3] := PIntArray(Data)[4];
  PIntArray(Data)[3] := T;
  DES_Func(@PIntArray(Data)[0], @PIntArray(User)[32]);
  DES_Func(@PIntArray(Data)[2], @PIntArray(User)[32]);
  DES_Func(@PIntArray(Data)[4], @PIntArray(User)[32]);
  T := PIntArray(Data)[1];
  PIntArray(Data)[1] := PIntArray(Data)[2];
  PIntArray(Data)[2] := T;
  T := PIntArray(Data)[3];
  PIntArray(Data)[3] := PIntArray(Data)[4];
  PIntArray(Data)[3] := T;
  DES_Func(@PIntArray(Data)[0], @PIntArray(User)[64]);
  DES_Func(@PIntArray(Data)[2], @PIntArray(User)[64]);
  DES_Func(@PIntArray(Data)[4], @PIntArray(User)[64]);
end;

procedure TCipher_3TDES.Decode(Data: Pointer);
var
  T: integer;
begin
  DES_Func(@PIntArray(Data)[0], @PIntArray(User)[96]);
  DES_Func(@PIntArray(Data)[2], @PIntArray(User)[96]);
  DES_Func(@PIntArray(Data)[4], @PIntArray(User)[96]);
  T := PIntArray(Data)[1];
  PIntArray(Data)[1] := PIntArray(Data)[2];
  PIntArray(Data)[2] := T;
  T := PIntArray(Data)[3];
  PIntArray(Data)[3] := PIntArray(Data)[4];
  PIntArray(Data)[3] := T;
  DES_Func(@PIntArray(Data)[0], @PIntArray(User)[128]);
  DES_Func(@PIntArray(Data)[2], @PIntArray(User)[128]);
  DES_Func(@PIntArray(Data)[4], @PIntArray(User)[128]);
  T := PIntArray(Data)[1];
  PIntArray(Data)[1] := PIntArray(Data)[2];
  PIntArray(Data)[2] := T;
  T := PIntArray(Data)[3];
  PIntArray(Data)[3] := PIntArray(Data)[4];
  PIntArray(Data)[3] := T;
  DES_Func(@PIntArray(Data)[0], @PIntArray(User)[160]);
  DES_Func(@PIntArray(Data)[2], @PIntArray(User)[160]);
  DES_Func(@PIntArray(Data)[4], @PIntArray(User)[160]);
end;


class procedure TCipher_Twofish.GetContext(var ABufSize, AKeySize, AUserSize: integer);
begin
  ABufSize  := 16;
  AKeySize  := 32;
  AUserSize := 4256;
end;

class function TCipher_Twofish.TestVector: Pointer;
asm
  MOV   EAX,OFFSET @Vector
  RET
  @Vector: DB    0A5h,053h,057h,003h,0EFh,033h,048h,079h
  DB    09Fh,022h,0B4h,054h,097h,005h,084h,019h
  DB    087h,0BDh,083h,01Ch,04Dh,0AEh,012h,013h
  DB    060h,07Ch,07Ch,0D1h,098h,045h,002h,019h
end;

type
  PTwofishBox = ^TTwofishBox;
  TTwofishBox = array[0..3, 0..255] of longword;

  TLongRec = record
    case integer of
      0: (L: longword);
      1: (A, B, C, D: byte);
  end;

procedure TCipher_Twofish.Encode(Data: Pointer);
var
  S:   PIntArray;
  Box: PTwofishBox;
  I, X, Y: longword;
  A, B, C, D: TLongRec;
begin
  S   := User;
  A.L := PIntArray(Data)[0] xor S[0];
  B.L := PIntArray(Data)[1] xor S[1];
  C.L := PIntArray(Data)[2] xor S[2];
  D.L := PIntArray(Data)[3] xor S[3];

  S   := @PIntArray(User)[8];
  Box := @PIntArray(User)[40];
  for I := 0 to 7 do
  begin
    X := Box[0, A.A] xor Box[1, A.B] xor Box[2, A.C] xor Box[3, A.D];
    Y := Box[1, B.A] xor Box[2, B.B] xor Box[3, B.C] xor Box[0, B.D];
    asm
      ROL  D.L,1 end;
    C.L := C.L xor (X + Y + S[0]);
    D.L := D.L xor (X + Y shl 1 + S[1]);
    asm
      ROR  C.L,1 end;

    X := Box[0, C.A] xor Box[1, C.B] xor Box[2, C.C] xor Box[3, C.D];
    Y := Box[1, D.A] xor Box[2, D.B] xor Box[3, D.C] xor Box[0, D.D];
    asm
      ROL  B.L,1 end;
    A.L := A.L xor (X + Y + S[2]);
    B.L := B.L xor (X + Y shl 1 + S[3]);
    asm
      ROR  A.L,1 end;
    Inc(PInteger(S), 4);
  end;
  S := User;
  PIntArray(Data)[0] := C.L xor S[4];
  PIntArray(Data)[1] := D.L xor S[5];
  PIntArray(Data)[2] := A.L xor S[6];
  PIntArray(Data)[3] := B.L xor S[7];
end;

procedure TCipher_Twofish.Decode(Data: Pointer);
var
  S:   PIntArray;
  Box: PTwofishBox;
  I, X, Y: longword;
  A, B, C, D: TLongRec;
begin
  S   := User;
  Box := @PIntArray(User)[40];
  C.L := PIntArray(Data)[0] xor S[4];
  D.L := PIntArray(Data)[1] xor S[5];
  A.L := PIntArray(Data)[2] xor S[6];
  B.L := PIntArray(Data)[3] xor S[7];
  S   := @PIntArray(User)[36];
  for I := 0 to 7 do
  begin
    X := Box[0, C.A] xor Box[1, C.B] xor Box[2, C.C] xor Box[3, C.D];
    Y := Box[0, D.D] xor Box[1, D.A] xor Box[2, D.B] xor Box[3, D.C];
    asm
      ROL  A.L,1 end;
    B.L := B.L xor (X + Y shl 1 + S[3]);
    A.L := A.L xor (X + Y + S[2]);
    asm
      ROR  B.L,1 end;

    X := Box[0, A.A] xor Box[1, A.B] xor Box[2, A.C] xor Box[3, A.D];
    Y := Box[0, B.D] xor Box[1, B.A] xor Box[2, B.B] xor Box[3, B.C];
    asm
      ROL  C.L,1 end;
    D.L := D.L xor (X + Y shl 1 + S[1]);
    C.L := C.L xor (X + Y + S[0]);
    asm
      ROR  D.L,1 end;
    Dec(PByte(S), 16);
  end;
  S := User;
  PIntArray(Data)[0] := A.L xor S[0];
  PIntArray(Data)[1] := B.L xor S[1];
  PIntArray(Data)[2] := C.L xor S[2];
  PIntArray(Data)[3] := D.L xor S[3];
end;

procedure TCipher_Twofish.Init(const Key; Size: integer; IVector: Pointer);
var
  BoxKey: array[0..3] of TLongRec;
  SubKey: PIntArray;
  Box:    PTwofishBox;

  procedure SetupKey;

    function Encode(K0, K1: integer): integer;
    var
      R, I, J, G2, G3: integer;
      B: byte;
    begin
      R := 0;
      for I := 0 to 1 do
      begin
        if I <> 0 then
          R := R xor K0
        else
          R := R xor K1;
        for J := 0 to 3 do
        begin
          B := R shr 24;
          if B and $80 <> 0 then
            G2 := (B shl 1 xor $014D) and $FF
          else
            G2 := B shl 1 and $FF;
          if B and 1 <> 0 then
            G3 := (B shr 1 and $7F) xor $014D shr 1 xor G2
          else
            G3 := (B shr 1 and $7F) xor G2;
          R := R shl 8 xor G3 shl 24 xor G2 shl 16 xor G3 shl 8 xor B;
        end;
      end;
      Result := R;
    end;

    function F32(X: integer; K: array of integer): integer;
    var
      A, B, C, D: integer;
    begin
      A := X and $FF;
      B := X shr 8 and $FF;
      C := X shr 16 and $FF;
      D := X shr 24;
      if Size = 32 then
      begin
        A := Twofish_8x8[1, A] xor K[3] and $FF;
        B := Twofish_8x8[0, B] xor K[3] shr 8 and $FF;
        C := Twofish_8x8[0, C] xor K[3] shr 16 and $FF;
        D := Twofish_8x8[1, D] xor K[3] shr 24;
      end;
      if Size >= 24 then
      begin
        A := Twofish_8x8[1, A] xor K[2] and $FF;
        B := Twofish_8x8[1, B] xor K[2] shr 8 and $FF;
        C := Twofish_8x8[0, C] xor K[2] shr 16 and $FF;
        D := Twofish_8x8[0, D] xor K[2] shr 24;
      end;
      A := Twofish_8x8[0, A] xor K[1] and $FF;
      B := Twofish_8x8[1, B] xor K[1] shr 8 and $FF;
      C := Twofish_8x8[0, C] xor K[1] shr 16 and $FF;
      D := Twofish_8x8[1, D] xor K[1] shr 24;

      A := Twofish_8x8[0, A] xor K[0] and $FF;
      B := Twofish_8x8[0, B] xor K[0] shr 8 and $FF;
      C := Twofish_8x8[1, C] xor K[0] shr 16 and $FF;
      D := Twofish_8x8[1, D] xor K[0] shr 24;

      Result := Twofish_Data[0, A] xor Twofish_Data[1, B] xor
        Twofish_Data[2, C] xor Twofish_Data[3, D];
    end;

  var
    I, J, A, B: integer;
    E, O: array[0..3] of integer;
    K:    array[0..7] of integer;
  begin
    FillChar(K, SizeOf(K), 0);
    Move(Key, K, Size);
    if Size <= 16 then
      Size := 16
    else
    if Size <= 24 then
      Size := 24
    else
      Size := 32;
    J := Size shr 3 - 1;
    for I := 0 to J do
    begin
      E[I] := K[I shl 1];
      O[I] := K[I shl 1 + 1];
      BoxKey[J].L := Encode(E[I], O[I]);
      Dec(J);
    end;
    J := 0;
    for I := 0 to 19 do
    begin
      A := F32(J, E);
      B := ROL(F32(J + $01010101, O), 8);
      SubKey[I shl 1] := A + B;
      B := A + B shr 1;
      SubKey[I shl 1 + 1] := ROL(B, 9);
      Inc(J, $02020202);
    end;
  end;

  procedure DoXOR(D, S: PIntArray; Value: longword);
  var
    I: longword;
  begin
    Value := (Value and $FF) * $01010101;
    for I := 0 to 63 do
      D[I] := S[I] xor Value;
  end;

  procedure SetupBox128;
  var
    L:    array[0..255] of byte;
    A, I: integer;
  begin
    DoXOR(@L, @Twofish_8x8[0], BoxKey[1].L);
    A := BoxKey[0].A;
    for I := 0 to 255 do
      Box[0, I] := Twofish_Data[0, Twofish_8x8[0, L[I]] xor A];
    DoXOR(@L, @Twofish_8x8[1], BoxKey[1].L shr 8);
    A := BoxKey[0].B;
    for I := 0 to 255 do
      Box[1, I] := Twofish_Data[1, Twofish_8x8[0, L[I]] xor A];
    DoXOR(@L, @Twofish_8x8[0], BoxKey[1].L shr 16);
    A := BoxKey[0].C;
    for I := 0 to 255 do
      Box[2, I] := Twofish_Data[2, Twofish_8x8[1, L[I]] xor A];
    DoXOR(@L, @Twofish_8x8[1], BoxKey[1].L shr 24);
    A := BoxKey[0].D;
    for I := 0 to 255 do
      Box[3, I] := Twofish_Data[3, Twofish_8x8[1, L[I]] xor A];
  end;

  procedure SetupBox192;
  var
    L: array[0..255] of byte;
    A, B, I: integer;
  begin
    DoXOR(@L, @Twofish_8x8[1], BoxKey[2].L);
    A := BoxKey[0].A;
    B := BoxKey[1].A;
    for I := 0 to 255 do
      Box[0, I] := Twofish_Data[0, Twofish_8x8[0, Twofish_8x8[0, L[I]] xor B] xor A];
    DoXOR(@L, @Twofish_8x8[1], BoxKey[2].L shr 8);
    A := BoxKey[0].B;
    B := BoxKey[1].B;
    for I := 0 to 255 do
      Box[1, I] := Twofish_Data[1, Twofish_8x8[0, Twofish_8x8[1, L[I]] xor B] xor A];
    DoXOR(@L, @Twofish_8x8[0], BoxKey[2].L shr 16);
    A := BoxKey[0].C;
    B := BoxKey[1].C;
    for I := 0 to 255 do
      Box[2, I] := Twofish_Data[2, Twofish_8x8[1, Twofish_8x8[0, L[I]] xor B] xor A];
    DoXOR(@L, @Twofish_8x8[0], BoxKey[2].L shr 24);
    A := BoxKey[0].D;
    B := BoxKey[1].D;
    for I := 0 to 255 do
      Box[3, I] := Twofish_Data[3, Twofish_8x8[1, Twofish_8x8[1, L[I]] xor B] xor A];
  end;

  procedure SetupBox256;
  var
    L: array[0..255] of byte;
    K: array[0..255] of byte;
    A, B, I: integer;
  begin
    DoXOR(@K, @Twofish_8x8[1], BoxKey[3].L);
    for I := 0 to 255 do
      L[I] := Twofish_8x8[1, K[I]];
    DoXOR(@L, @L, BoxKey[2].L);
    A := BoxKey[0].A;
    B := BoxKey[1].A;
    for I := 0 to 255 do
      Box[0, I] := Twofish_Data[0, Twofish_8x8[0, Twofish_8x8[0, L[I]] xor B] xor A];
    DoXOR(@K, @Twofish_8x8[0], BoxKey[3].L shr 8);
    for I := 0 to 255 do
      L[I] := Twofish_8x8[1, K[I]];
    DoXOR(@L, @L, BoxKey[2].L shr 8);
    A := BoxKey[0].B;
    B := BoxKey[1].B;
    for I := 0 to 255 do
      Box[1, I] := Twofish_Data[1, Twofish_8x8[0, Twofish_8x8[1, L[I]] xor B] xor A];
    DoXOR(@K, @Twofish_8x8[0], BoxKey[3].L shr 16);
    for I := 0 to 255 do
      L[I] := Twofish_8x8[0, K[I]];
    DoXOR(@L, @L, BoxKey[2].L shr 16);
    A := BoxKey[0].C;
    B := BoxKey[1].C;
    for I := 0 to 255 do
      Box[2, I] := Twofish_Data[2, Twofish_8x8[1, Twofish_8x8[0, L[I]] xor B] xor A];
    DoXOR(@K, @Twofish_8x8[1], BoxKey[3].L shr 24);
    for I := 0 to 255 do
      L[I] := Twofish_8x8[0, K[I]];
    DoXOR(@L, @L, BoxKey[2].L shr 24);
    A := BoxKey[0].D;
    B := BoxKey[1].D;
    for I := 0 to 255 do
      Box[3, I] := Twofish_Data[3, Twofish_8x8[1, Twofish_8x8[1, L[I]] xor B] xor A];
  end;

begin
  InitBegin(Size);
  SubKey := User;
  Box    := @SubKey[40];
  SetupKey;
  if Size = 16 then
    SetupBox128
  else
  if Size = 24 then
    SetupBox192
  else
    SetupBox256;
  InitEnd(IVector);
end;

class procedure TCipher_Square.GetContext(var ABufSize, AKeySize, AUserSize: integer);
begin
  ABufSize  := 16;
  AKeySize  := 16;
  AUserSize := 9 * 4 * 2 * SizeOf(longword);
end;

class function TCipher_Square.TestVector: Pointer;
asm
  MOV   EAX,OFFSET @Vector
  RET
  @Vector: DB    043h,09Ch,0A6h,0C4h,067h,0E8h,02Eh,047h
  DB    022h,095h,066h,085h,006h,039h,06Ah,0C9h
  DB    018h,021h,020h,0F7h,044h,036h,0F1h,061h
  DB    07Dh,014h,090h,0B1h,0A9h,068h,056h,0C7h
end;

procedure TCipher_Square.Encode(Data: Pointer);
var
  Key: PIntArray;
  A, B, C, D: longword;
  AA, BB, CC: longword;
  I:   integer;
begin
  Key := User;
  A   := PIntArray(Data)[0] xor Key[0];
  B   := PIntArray(Data)[1] xor Key[1];
  C   := PIntArray(Data)[2] xor Key[2];
  D   := PIntArray(Data)[3] xor Key[3];
  Inc(PInteger(Key), 4);
  for I := 0 to 6 do
  begin
    AA := Square_TE[0, A and $FF] xor Square_TE[1, B and $FF] xor
      Square_TE[2, C and $FF] xor Square_TE[3,
      D and $FF] xor Key[0];
    BB := Square_TE[0, A shr 8 and $FF] xor Square_TE[1, B shr 8 and $FF] xor
      Square_TE[2, C shr 8 and $FF] xor Square_TE[3,
      D shr 8 and $FF] xor Key[1];
    CC := Square_TE[0, A shr 16 and $FF] xor Square_TE[1, B shr 16 and $FF] xor
      Square_TE[2, C shr 16 and $FF] xor Square_TE[3,
      D shr 16 and $FF] xor Key[2];
    D  := Square_TE[0, A shr 24] xor Square_TE[1, B shr 24] xor
      Square_TE[2, C shr 24] xor Square_TE[3,
      D shr 24] xor Key[3];

    Inc(PInteger(Key), 4);

    A := AA;
    B := BB;
    C := CC;
  end;

  PIntArray(Data)[0] := longword(Square_SE[A and $FF]) xor
    longword(Square_SE[B and $FF]) shl
    8 xor longword(Square_SE[C and $FF]) shl
    16 xor longword(Square_SE[D and $FF]) shl 24 xor Key[0];
  PIntArray(Data)[1] := longword(Square_SE[A shr 8 and $FF]) xor
    longword(Square_SE[B shr 8 and $FF]) shl
    8 xor longword(Square_SE[C shr 8 and $FF]) shl
    16 xor longword(Square_SE[D shr 8 and $FF]) shl 24 xor Key[1];
  PIntArray(Data)[2] := longword(Square_SE[A shr 16 and $FF]) xor
    longword(Square_SE[B shr 16 and $FF]) shl
    8 xor longword(Square_SE[C shr 16 and $FF]) shl
    16 xor longword(Square_SE[D shr 16 and $FF]) shl 24 xor Key[2];
  PIntArray(Data)[3] := longword(Square_SE[A shr 24]) xor
    longword(Square_SE[B shr 24]) shl
    8 xor longword(Square_SE[C shr 24]) shl
    16 xor longword(Square_SE[D shr 24]) shl 24 xor Key[3];
end;

procedure TCipher_Square.Decode(Data: Pointer);
var
  Key: PIntArray;
  A, B, C, D: longword;
  AA, BB, CC: longword;
  I:   integer;
begin
  Key := @PIntArray(User)[9 * 4];
  A   := PIntArray(Data)[0] xor Key[0];
  B   := PIntArray(Data)[1] xor Key[1];
  C   := PIntArray(Data)[2] xor Key[2];
  D   := PIntArray(Data)[3] xor Key[3];
  Inc(PInteger(Key), 4);

  for I := 0 to 6 do
  begin
    AA := Square_TD[0, A and $FF] xor Square_TD[1, B and $FF] xor
      Square_TD[2, C and $FF] xor Square_TD[3,
      D and $FF] xor Key[0];
    BB := Square_TD[0, A shr 8 and $FF] xor Square_TD[1, B shr 8 and $FF] xor
      Square_TD[2, C shr 8 and $FF] xor Square_TD[3,
      D shr 8 and $FF] xor Key[1];
    CC := Square_TD[0, A shr 16 and $FF] xor Square_TD[1, B shr 16 and $FF] xor
      Square_TD[2, C shr 16 and $FF] xor Square_TD[3,
      D shr 16 and $FF] xor Key[2];
    D  := Square_TD[0, A shr 24] xor Square_TD[1, B shr 24] xor
      Square_TD[2, C shr 24] xor Square_TD[3,
      D shr 24] xor Key[3];

    Inc(PInteger(Key), 4);
    A := AA;
    B := BB;
    C := CC;
  end;

  PIntArray(Data)[0] := longword(Square_SD[A and $FF]) xor
    longword(Square_SD[B and $FF]) shl
    8 xor longword(Square_SD[C and $FF]) shl
    16 xor longword(Square_SD[D and $FF]) shl 24 xor Key[0];
  PIntArray(Data)[1] := longword(Square_SD[A shr 8 and $FF]) xor
    longword(Square_SD[B shr 8 and $FF]) shl
    8 xor longword(Square_SD[C shr 8 and $FF]) shl
    16 xor longword(Square_SD[D shr 8 and $FF]) shl 24 xor Key[1];
  PIntArray(Data)[2] := longword(Square_SD[A shr 16 and $FF]) xor
    longword(Square_SD[B shr 16 and $FF]) shl
    8 xor longword(Square_SD[C shr 16 and $FF]) shl
    16 xor longword(Square_SD[D shr 16 and $FF]) shl 24 xor Key[2];
  PIntArray(Data)[3] := longword(Square_SD[A shr 24]) xor
    longword(Square_SD[B shr 24]) shl
    8 xor longword(Square_SD[C shr 24]) shl
    16 xor longword(Square_SD[D shr 24]) shl 24 xor Key[3];
end;

procedure TCipher_Square.Init(const Key; Size: integer; IVector: Pointer);
type
  PSquare_Key = ^TSquare_Key;
  TSquare_Key = array[0..8, 0..3] of longword;
var
  E, D: PSquare_Key;
  T, I: integer;
begin
  InitBegin(Size);
  E := User;
  D := User;
  Inc(D);
  Move(Key, E^, Size);
  for T := 1 to 8 do
  begin
    E[T, 0]     := E[T - 1, 0] xor ROR(E[T - 1, 3], 8) xor 1 shl (T - 1);
    D[8 - T, 0] := E[T, 0];
    E[T, 1]     := E[T - 1, 1] xor E[T, 0];
    D[8 - T, 1] := E[T, 1];
    E[T, 2]     := E[T - 1, 2] xor E[T, 1];
    D[8 - T, 2] := E[T, 2];
    E[T, 3]     := E[T - 1, 3] xor E[T, 2];
    D[8 - T, 3] := E[T, 3];
    for I := 0 to 3 do
      E[T - 1, I] := Square_PHI[E[T - 1, I] and $FF] xor
        ROL(Square_PHI[E[T - 1, I] shr 8 and $FF], 8) xor
        ROL(Square_PHI[E[T - 1, I] shr 16 and $FF], 16) xor
        ROL(Square_PHI[E[T - 1, I] shr 24], 24);
  end;
  D[8] := E[0];
  InitEnd(IVector);
end;


//------- from cipher1 end ----------------

 //------------ from hash -----------
 // hash message digest 4
class function THash_MD4.TestVector: Pointer; assembler;
asm
  MOV   EAX,OFFSET @Vector
  RET
  @Vector: DB    025h,0EAh,0BFh,0CCh,08Ch,0C9h,06Fh,0D9h
  DB    02Dh,0CFh,07Eh,0BDh,07Fh,087h,07Ch,07Ch
end;

procedure THash_MD4.Transform(Buffer: PIntArray);
{calculate the Digest, fast}
var
  A, B, C, D: longword;
begin
  A := FDigest[0];
  B := FDigest[1];
  C := FDigest[2];
  D := FDigest[3];

  Inc(A, Buffer[0] + (B and C or not B and D));
  A := A shl 3 or A shr 29;
  Inc(D, Buffer[1] + (A and B or not A and C));
  D := D shl 7 or D shr 25;
  Inc(C, Buffer[2] + (D and A or not D and B));
  C := C shl 11 or C shr 21;
  Inc(B, Buffer[3] + (C and D or not C and A));
  B := B shl 19 or B shr 13;
  Inc(A, Buffer[4] + (B and C or not B and D));
  A := A shl 3 or A shr 29;
  Inc(D, Buffer[5] + (A and B or not A and C));
  D := D shl 7 or D shr 25;
  Inc(C, Buffer[6] + (D and A or not D and B));
  C := C shl 11 or C shr 21;
  Inc(B, Buffer[7] + (C and D or not C and A));
  B := B shl 19 or B shr 13;
  Inc(A, Buffer[8] + (B and C or not B and D));
  A := A shl 3 or A shr 29;
  Inc(D, Buffer[9] + (A and B or not A and C));
  D := D shl 7 or D shr 25;
  Inc(C, Buffer[10] + (D and A or not D and B));
  C := C shl 11 or C shr 21;
  Inc(B, Buffer[11] + (C and D or not C and A));
  B := B shl 19 or B shr 13;
  Inc(A, Buffer[12] + (B and C or not B and D));
  A := A shl 3 or A shr 29;
  Inc(D, Buffer[13] + (A and B or not A and C));
  D := D shl 7 or D shr 25;
  Inc(C, Buffer[14] + (D and A or not D and B));
  C := C shl 11 or C shr 21;
  Inc(B, Buffer[15] + (C and D or not C and A));
  B := B shl 19 or B shr 13;

  Inc(A, Buffer[0] + $5A827999 + (B and C or B and D or C and D));
  A := A shl 3 or A shr 29;
  Inc(D, Buffer[4] + $5A827999 + (A and B or A and C or B and C));
  D := D shl 5 or D shr 27;
  Inc(C, Buffer[8] + $5A827999 + (D and A or D and B or A and B));
  C := C shl 9 or C shr 23;
  Inc(B, Buffer[12] + $5A827999 + (C and D or C and A or D and A));
  B := B shl 13 or B shr 19;
  Inc(A, Buffer[1] + $5A827999 + (B and C or B and D or C and D));
  A := A shl 3 or A shr 29;
  Inc(D, Buffer[5] + $5A827999 + (A and B or A and C or B and C));
  D := D shl 5 or D shr 27;
  Inc(C, Buffer[9] + $5A827999 + (D and A or D and B or A and B));
  C := C shl 9 or C shr 23;
  Inc(B, Buffer[13] + $5A827999 + (C and D or C and A or D and A));
  B := B shl 13 or B shr 19;
  Inc(A, Buffer[2] + $5A827999 + (B and C or B and D or C and D));
  A := A shl 3 or A shr 29;
  Inc(D, Buffer[6] + $5A827999 + (A and B or A and C or B and C));
  D := D shl 5 or D shr 27;
  Inc(C, Buffer[10] + $5A827999 + (D and A or D and B or A and B));
  C := C shl 9 or C shr 23;
  Inc(B, Buffer[14] + $5A827999 + (C and D or C and A or D and A));
  B := B shl 13 or B shr 19;
  Inc(A, Buffer[3] + $5A827999 + (B and C or B and D or C and D));
  A := A shl 3 or A shr 29;
  Inc(D, Buffer[7] + $5A827999 + (A and B or A and C or B and C));
  D := D shl 5 or D shr 27;
  Inc(C, Buffer[11] + $5A827999 + (D and A or D and B or A and B));
  C := C shl 9 or C shr 23;
  Inc(B, Buffer[15] + $5A827999 + (C and D or C and A or D and A));
  B := B shl 13 or B shr 19;

  Inc(A, Buffer[0] + $6ED9EBA1 + (B xor C xor D));
  A := A shl 3 or A shr 29;
  Inc(D, Buffer[8] + $6ED9EBA1 + (A xor B xor C));
  D := D shl 9 or D shr 23;
  Inc(C, Buffer[4] + $6ED9EBA1 + (D xor A xor B));
  C := C shl 11 or C shr 21;
  Inc(B, Buffer[12] + $6ED9EBA1 + (C xor D xor A));
  B := B shl 15 or B shr 17;
  Inc(A, Buffer[2] + $6ED9EBA1 + (B xor C xor D));
  A := A shl 3 or A shr 29;
  Inc(D, Buffer[10] + $6ED9EBA1 + (A xor B xor C));
  D := D shl 9 or D shr 23;
  Inc(C, Buffer[6] + $6ED9EBA1 + (D xor A xor B));
  C := C shl 11 or C shr 21;
  Inc(B, Buffer[14] + $6ED9EBA1 + (C xor D xor A));
  B := B shl 15 or B shr 17;
  Inc(A, Buffer[1] + $6ED9EBA1 + (B xor C xor D));
  A := A shl 3 or A shr 29;
  Inc(D, Buffer[9] + $6ED9EBA1 + (A xor B xor C));
  D := D shl 9 or D shr 23;
  Inc(C, Buffer[5] + $6ED9EBA1 + (D xor A xor B));
  C := C shl 11 or C shr 21;
  Inc(B, Buffer[13] + $6ED9EBA1 + (C xor D xor A));
  B := B shl 15 or B shr 17;
  Inc(A, Buffer[3] + $6ED9EBA1 + (B xor C xor D));
  A := A shl 3 or A shr 29;
  Inc(D, Buffer[11] + $6ED9EBA1 + (A xor B xor C));
  D := D shl 9 or D shr 23;
  Inc(C, Buffer[7] + $6ED9EBA1 + (D xor A xor B));
  C := C shl 11 or C shr 21;
  Inc(B, Buffer[15] + $6ED9EBA1 + (C xor D xor A));
  B := B shl 15 or B shr 17;

  Inc(FDigest[0], A);
  Inc(FDigest[1], B);
  Inc(FDigest[2], C);
  Inc(FDigest[3], D);
end;

class function THash_MD4.DigestKeySize: integer;
begin
  Result := 16;
end;

function THash_MD4.DigestKey: Pointer;
begin
  Result := @FDigest;
end;

procedure THash_MD4.Init;
begin
  FillChar(FBuffer, SizeOf(FBuffer), 0);
  {all Descend from MD4 (MD4, SHA1, RipeMD128, RipeMD160, RipeMD256) use this Init-Key}
  FDigest[0] := $67452301;
  FDigest[1] := $EFCDAB89;
  FDigest[2] := $98BADCFE;
  FDigest[3] := $10325476;
  FDigest[4] := $C3D2E1F0;
  {for RMD320}
  FDigest[5] := $76543210;
  FDigest[6] := $FEDCBA98;
  FDigest[7] := $89ABCDEF;
  FDigest[8] := $01234567;
  FDigest[9] := $3C2D1E0F;
  FCount     := 0;
  Protect(True);
end;

procedure THash_MD4.Done;
var
  I: integer;
  S: comp;
begin
  I := FCount and $3F;
  FBuffer[I] := $80;
  Inc(I);
  if I > 64 - 8 then
  begin
    FillChar(FBuffer[I], 64 - I, 0);
    Transform(@FBuffer);
    I := 0;
  end;
  FillChar(FBuffer[I], 64 - I, 0);
  S := FCount * 8;
  Move(S, FBuffer[64 - 8], SizeOf(S));
  Transform(@FBuffer);
  FillChar(FBuffer, SizeOf(FBuffer), 0);
  Protect(False);
end;

procedure THash_MD4.Calc(const Data; DataSize: integer);
var
  Index: integer;
  P:     PAnsiChar;
begin
  if DataSize <= 0 then
    Exit;
  Index := FCount and $3F;
  Inc(FCount, DataSize);
  if Index > 0 then
  begin
    if DataSize < 64 - Index then
    begin
      Move(Data, FBuffer[Index], DataSize);
      Exit;
    end;
    Move(Data, FBuffer[Index], 64 - Index);
    Transform(@FBuffer);
    Index := 64 - Index;
    Dec(DataSize, Index);
  end;
  P := @TByteArray(Data)[Index];
  Inc(Index, DataSize and not $3F);
  while DataSize >= 64 do
  begin
    Transform(Pointer(P));
    Inc(P, 64);
    Dec(DataSize, 64);
  end;
  Move(TByteArray(Data)[Index], FBuffer, DataSize);
end;

// ripe 128
class function THash_RipeMD128.TestVector: Pointer;
asm
  MOV   EAX,OFFSET @Vector
  RET
  @Vector: DB    0CFh,0A0h,032h,0CFh,0D0h,08Fh,087h,03Ah
  DB    078h,0DFh,013h,0E7h,0EBh,0CDh,098h,00Fh
end;

procedure THash_RipeMD128.Transform(Buffer: PIntArray);
var
  A1, B1, C1, D1: longword;
  A2, B2, C2, D2: longword;
begin
  A1 := FDigest[0];
  B1 := FDigest[1];
  C1 := FDigest[2];
  D1 := FDigest[3];
  A2 := A1;
  B2 := B1;
  C2 := C1;
  D2 := D1;

  Inc(A1, B1 xor C1 xor D1 + Buffer[0]);
  A1 := A1 shl 11 or A1 shr 21;
  Inc(D1, A1 xor B1 xor C1 + Buffer[1]);
  D1 := D1 shl 14 or D1 shr 18;
  Inc(C1, D1 xor A1 xor B1 + Buffer[2]);
  C1 := C1 shl 15 or C1 shr 17;
  Inc(B1, C1 xor D1 xor A1 + Buffer[3]);
  B1 := B1 shl 12 or B1 shr 20;
  Inc(A1, B1 xor C1 xor D1 + Buffer[4]);
  A1 := A1 shl 5 or A1 shr 27;
  Inc(D1, A1 xor B1 xor C1 + Buffer[5]);
  D1 := D1 shl 8 or D1 shr 24;
  Inc(C1, D1 xor A1 xor B1 + Buffer[6]);
  C1 := C1 shl 7 or C1 shr 25;
  Inc(B1, C1 xor D1 xor A1 + Buffer[7]);
  B1 := B1 shl 9 or B1 shr 23;
  Inc(A1, B1 xor C1 xor D1 + Buffer[8]);
  A1 := A1 shl 11 or A1 shr 21;
  Inc(D1, A1 xor B1 xor C1 + Buffer[9]);
  D1 := D1 shl 13 or D1 shr 19;
  Inc(C1, D1 xor A1 xor B1 + Buffer[10]);
  C1 := C1 shl 14 or C1 shr 18;
  Inc(B1, C1 xor D1 xor A1 + Buffer[11]);
  B1 := B1 shl 15 or B1 shr 17;
  Inc(A1, B1 xor C1 xor D1 + Buffer[12]);
  A1 := A1 shl 6 or A1 shr 26;
  Inc(D1, A1 xor B1 xor C1 + Buffer[13]);
  D1 := D1 shl 7 or D1 shr 25;
  Inc(C1, D1 xor A1 xor B1 + Buffer[14]);
  C1 := C1 shl 9 or C1 shr 23;
  Inc(B1, C1 xor D1 xor A1 + Buffer[15]);
  B1 := B1 shl 8 or B1 shr 24;

  Inc(A1, B1 and C1 or not B1 and D1 + Buffer[7] + $5A827999);
  A1 := A1 shl 7 or A1 shr 25;
  Inc(D1, A1 and B1 or not A1 and C1 + Buffer[4] + $5A827999);
  D1 := D1 shl 6 or D1 shr 26;
  Inc(C1, D1 and A1 or not D1 and B1 + Buffer[13] + $5A827999);
  C1 := C1 shl 8 or C1 shr 24;
  Inc(B1, C1 and D1 or not C1 and A1 + Buffer[1] + $5A827999);
  B1 := B1 shl 13 or B1 shr 19;
  Inc(A1, B1 and C1 or not B1 and D1 + Buffer[10] + $5A827999);
  A1 := A1 shl 11 or A1 shr 21;
  Inc(D1, A1 and B1 or not A1 and C1 + Buffer[6] + $5A827999);
  D1 := D1 shl 9 or D1 shr 23;
  Inc(C1, D1 and A1 or not D1 and B1 + Buffer[15] + $5A827999);
  C1 := C1 shl 7 or C1 shr 25;
  Inc(B1, C1 and D1 or not C1 and A1 + Buffer[3] + $5A827999);
  B1 := B1 shl 15 or B1 shr 17;
  Inc(A1, B1 and C1 or not B1 and D1 + Buffer[12] + $5A827999);
  A1 := A1 shl 7 or A1 shr 25;
  Inc(D1, A1 and B1 or not A1 and C1 + Buffer[0] + $5A827999);
  D1 := D1 shl 12 or D1 shr 20;
  Inc(C1, D1 and A1 or not D1 and B1 + Buffer[9] + $5A827999);
  C1 := C1 shl 15 or C1 shr 17;
  Inc(B1, C1 and D1 or not C1 and A1 + Buffer[5] + $5A827999);
  B1 := B1 shl 9 or B1 shr 23;
  Inc(A1, B1 and C1 or not B1 and D1 + Buffer[2] + $5A827999);
  A1 := A1 shl 11 or A1 shr 21;
  Inc(D1, A1 and B1 or not A1 and C1 + Buffer[14] + $5A827999);
  D1 := D1 shl 7 or D1 shr 25;
  Inc(C1, D1 and A1 or not D1 and B1 + Buffer[11] + $5A827999);
  C1 := C1 shl 13 or C1 shr 19;
  Inc(B1, C1 and D1 or not C1 and A1 + Buffer[8] + $5A827999);
  B1 := B1 shl 12 or B1 shr 20;

  Inc(A1, (B1 or not C1) xor D1 + Buffer[3] + $6ED9EBA1);
  A1 := A1 shl 11 or A1 shr 21;
  Inc(D1, (A1 or not B1) xor C1 + Buffer[10] + $6ED9EBA1);
  D1 := D1 shl 13 or D1 shr 19;
  Inc(C1, (D1 or not A1) xor B1 + Buffer[14] + $6ED9EBA1);
  C1 := C1 shl 6 or C1 shr 26;
  Inc(B1, (C1 or not D1) xor A1 + Buffer[4] + $6ED9EBA1);
  B1 := B1 shl 7 or B1 shr 25;
  Inc(A1, (B1 or not C1) xor D1 + Buffer[9] + $6ED9EBA1);
  A1 := A1 shl 14 or A1 shr 18;
  Inc(D1, (A1 or not B1) xor C1 + Buffer[15] + $6ED9EBA1);
  D1 := D1 shl 9 or D1 shr 23;
  Inc(C1, (D1 or not A1) xor B1 + Buffer[8] + $6ED9EBA1);
  C1 := C1 shl 13 or C1 shr 19;
  Inc(B1, (C1 or not D1) xor A1 + Buffer[1] + $6ED9EBA1);
  B1 := B1 shl 15 or B1 shr 17;
  Inc(A1, (B1 or not C1) xor D1 + Buffer[2] + $6ED9EBA1);
  A1 := A1 shl 14 or A1 shr 18;
  Inc(D1, (A1 or not B1) xor C1 + Buffer[7] + $6ED9EBA1);
  D1 := D1 shl 8 or D1 shr 24;
  Inc(C1, (D1 or not A1) xor B1 + Buffer[0] + $6ED9EBA1);
  C1 := C1 shl 13 or C1 shr 19;
  Inc(B1, (C1 or not D1) xor A1 + Buffer[6] + $6ED9EBA1);
  B1 := B1 shl 6 or B1 shr 26;
  Inc(A1, (B1 or not C1) xor D1 + Buffer[13] + $6ED9EBA1);
  A1 := A1 shl 5 or A1 shr 27;
  Inc(D1, (A1 or not B1) xor C1 + Buffer[11] + $6ED9EBA1);
  D1 := D1 shl 12 or D1 shr 20;
  Inc(C1, (D1 or not A1) xor B1 + Buffer[5] + $6ED9EBA1);
  C1 := C1 shl 7 or C1 shr 25;
  Inc(B1, (C1 or not D1) xor A1 + Buffer[12] + $6ED9EBA1);
  B1 := B1 shl 5 or B1 shr 27;

  Inc(A1, B1 and D1 or C1 and not D1 + Buffer[1] + $8F1BBCDC);
  A1 := A1 shl 11 or A1 shr 21;
  Inc(D1, A1 and C1 or B1 and not C1 + Buffer[9] + $8F1BBCDC);
  D1 := D1 shl 12 or D1 shr 20;
  Inc(C1, D1 and B1 or A1 and not B1 + Buffer[11] + $8F1BBCDC);
  C1 := C1 shl 14 or C1 shr 18;
  Inc(B1, C1 and A1 or D1 and not A1 + Buffer[10] + $8F1BBCDC);
  B1 := B1 shl 15 or B1 shr 17;
  Inc(A1, B1 and D1 or C1 and not D1 + Buffer[0] + $8F1BBCDC);
  A1 := A1 shl 14 or A1 shr 18;
  Inc(D1, A1 and C1 or B1 and not C1 + Buffer[8] + $8F1BBCDC);
  D1 := D1 shl 15 or D1 shr 17;
  Inc(C1, D1 and B1 or A1 and not B1 + Buffer[12] + $8F1BBCDC);
  C1 := C1 shl 9 or C1 shr 23;
  Inc(B1, C1 and A1 or D1 and not A1 + Buffer[4] + $8F1BBCDC);
  B1 := B1 shl 8 or B1 shr 24;
  Inc(A1, B1 and D1 or C1 and not D1 + Buffer[13] + $8F1BBCDC);
  A1 := A1 shl 9 or A1 shr 23;
  Inc(D1, A1 and C1 or B1 and not C1 + Buffer[3] + $8F1BBCDC);
  D1 := D1 shl 14 or D1 shr 18;
  Inc(C1, D1 and B1 or A1 and not B1 + Buffer[7] + $8F1BBCDC);
  C1 := C1 shl 5 or C1 shr 27;
  Inc(B1, C1 and A1 or D1 and not A1 + Buffer[15] + $8F1BBCDC);
  B1 := B1 shl 6 or B1 shr 26;
  Inc(A1, B1 and D1 or C1 and not D1 + Buffer[14] + $8F1BBCDC);
  A1 := A1 shl 8 or A1 shr 24;
  Inc(D1, A1 and C1 or B1 and not C1 + Buffer[5] + $8F1BBCDC);
  D1 := D1 shl 6 or D1 shr 26;
  Inc(C1, D1 and B1 or A1 and not B1 + Buffer[6] + $8F1BBCDC);
  C1 := C1 shl 5 or C1 shr 27;
  Inc(B1, C1 and A1 or D1 and not A1 + Buffer[2] + $8F1BBCDC);
  B1 := B1 shl 12 or B1 shr 20;

  Inc(A2, B2 and D2 or C2 and not D2 + Buffer[5] + $50A28BE6);
  A2 := A2 shl 8 or A2 shr 24;
  Inc(D2, A2 and C2 or B2 and not C2 + Buffer[14] + $50A28BE6);
  D2 := D2 shl 9 or D2 shr 23;
  Inc(C2, D2 and B2 or A2 and not B2 + Buffer[7] + $50A28BE6);
  C2 := C2 shl 9 or C2 shr 23;
  Inc(B2, C2 and A2 or D2 and not A2 + Buffer[0] + $50A28BE6);
  B2 := B2 shl 11 or B2 shr 21;
  Inc(A2, B2 and D2 or C2 and not D2 + Buffer[9] + $50A28BE6);
  A2 := A2 shl 13 or A2 shr 19;
  Inc(D2, A2 and C2 or B2 and not C2 + Buffer[2] + $50A28BE6);
  D2 := D2 shl 15 or D2 shr 17;
  Inc(C2, D2 and B2 or A2 and not B2 + Buffer[11] + $50A28BE6);
  C2 := C2 shl 15 or C2 shr 17;
  Inc(B2, C2 and A2 or D2 and not A2 + Buffer[4] + $50A28BE6);
  B2 := B2 shl 5 or B2 shr 27;
  Inc(A2, B2 and D2 or C2 and not D2 + Buffer[13] + $50A28BE6);
  A2 := A2 shl 7 or A2 shr 25;
  Inc(D2, A2 and C2 or B2 and not C2 + Buffer[6] + $50A28BE6);
  D2 := D2 shl 7 or D2 shr 25;
  Inc(C2, D2 and B2 or A2 and not B2 + Buffer[15] + $50A28BE6);
  C2 := C2 shl 8 or C2 shr 24;
  Inc(B2, C2 and A2 or D2 and not A2 + Buffer[8] + $50A28BE6);
  B2 := B2 shl 11 or B2 shr 21;
  Inc(A2, B2 and D2 or C2 and not D2 + Buffer[1] + $50A28BE6);
  A2 := A2 shl 14 or A2 shr 18;
  Inc(D2, A2 and C2 or B2 and not C2 + Buffer[10] + $50A28BE6);
  D2 := D2 shl 14 or D2 shr 18;
  Inc(C2, D2 and B2 or A2 and not B2 + Buffer[3] + $50A28BE6);
  C2 := C2 shl 12 or C2 shr 20;
  Inc(B2, C2 and A2 or D2 and not A2 + Buffer[12] + $50A28BE6);
  B2 := B2 shl 6 or B2 shr 26;

  Inc(A2, (B2 or not C2) xor D2 + Buffer[6] + $5C4DD124);
  A2 := A2 shl 9 or A2 shr 23;
  Inc(D2, (A2 or not B2) xor C2 + Buffer[11] + $5C4DD124);
  D2 := D2 shl 13 or D2 shr 19;
  Inc(C2, (D2 or not A2) xor B2 + Buffer[3] + $5C4DD124);
  C2 := C2 shl 15 or C2 shr 17;
  Inc(B2, (C2 or not D2) xor A2 + Buffer[7] + $5C4DD124);
  B2 := B2 shl 7 or B2 shr 25;
  Inc(A2, (B2 or not C2) xor D2 + Buffer[0] + $5C4DD124);
  A2 := A2 shl 12 or A2 shr 20;
  Inc(D2, (A2 or not B2) xor C2 + Buffer[13] + $5C4DD124);
  D2 := D2 shl 8 or D2 shr 24;
  Inc(C2, (D2 or not A2) xor B2 + Buffer[5] + $5C4DD124);
  C2 := C2 shl 9 or C2 shr 23;
  Inc(B2, (C2 or not D2) xor A2 + Buffer[10] + $5C4DD124);
  B2 := B2 shl 11 or B2 shr 21;
  Inc(A2, (B2 or not C2) xor D2 + Buffer[14] + $5C4DD124);
  A2 := A2 shl 7 or A2 shr 25;
  Inc(D2, (A2 or not B2) xor C2 + Buffer[15] + $5C4DD124);
  D2 := D2 shl 7 or D2 shr 25;
  Inc(C2, (D2 or not A2) xor B2 + Buffer[8] + $5C4DD124);
  C2 := C2 shl 12 or C2 shr 20;
  Inc(B2, (C2 or not D2) xor A2 + Buffer[12] + $5C4DD124);
  B2 := B2 shl 7 or B2 shr 25;
  Inc(A2, (B2 or not C2) xor D2 + Buffer[4] + $5C4DD124);
  A2 := A2 shl 6 or A2 shr 26;
  Inc(D2, (A2 or not B2) xor C2 + Buffer[9] + $5C4DD124);
  D2 := D2 shl 15 or D2 shr 17;
  Inc(C2, (D2 or not A2) xor B2 + Buffer[1] + $5C4DD124);
  C2 := C2 shl 13 or C2 shr 19;
  Inc(B2, (C2 or not D2) xor A2 + Buffer[2] + $5C4DD124);
  B2 := B2 shl 11 or B2 shr 21;

  Inc(A2, B2 and C2 or not B2 and D2 + Buffer[15] + $6D703EF3);
  A2 := A2 shl 9 or A2 shr 23;
  Inc(D2, A2 and B2 or not A2 and C2 + Buffer[5] + $6D703EF3);
  D2 := D2 shl 7 or D2 shr 25;
  Inc(C2, D2 and A2 or not D2 and B2 + Buffer[1] + $6D703EF3);
  C2 := C2 shl 15 or C2 shr 17;
  Inc(B2, C2 and D2 or not C2 and A2 + Buffer[3] + $6D703EF3);
  B2 := B2 shl 11 or B2 shr 21;
  Inc(A2, B2 and C2 or not B2 and D2 + Buffer[7] + $6D703EF3);
  A2 := A2 shl 8 or A2 shr 24;
  Inc(D2, A2 and B2 or not A2 and C2 + Buffer[14] + $6D703EF3);
  D2 := D2 shl 6 or D2 shr 26;
  Inc(C2, D2 and A2 or not D2 and B2 + Buffer[6] + $6D703EF3);
  C2 := C2 shl 6 or C2 shr 26;
  Inc(B2, C2 and D2 or not C2 and A2 + Buffer[9] + $6D703EF3);
  B2 := B2 shl 14 or B2 shr 18;
  Inc(A2, B2 and C2 or not B2 and D2 + Buffer[11] + $6D703EF3);
  A2 := A2 shl 12 or A2 shr 20;
  Inc(D2, A2 and B2 or not A2 and C2 + Buffer[8] + $6D703EF3);
  D2 := D2 shl 13 or D2 shr 19;
  Inc(C2, D2 and A2 or not D2 and B2 + Buffer[12] + $6D703EF3);
  C2 := C2 shl 5 or C2 shr 27;
  Inc(B2, C2 and D2 or not C2 and A2 + Buffer[2] + $6D703EF3);
  B2 := B2 shl 14 or B2 shr 18;
  Inc(A2, B2 and C2 or not B2 and D2 + Buffer[10] + $6D703EF3);
  A2 := A2 shl 13 or A2 shr 19;
  Inc(D2, A2 and B2 or not A2 and C2 + Buffer[0] + $6D703EF3);
  D2 := D2 shl 13 or D2 shr 19;
  Inc(C2, D2 and A2 or not D2 and B2 + Buffer[4] + $6D703EF3);
  C2 := C2 shl 7 or C2 shr 25;
  Inc(B2, C2 and D2 or not C2 and A2 + Buffer[13] + $6D703EF3);
  B2 := B2 shl 5 or B2 shr 27;

  Inc(A2, B2 xor C2 xor D2 + Buffer[8]);
  A2 := A2 shl 15 or A2 shr 17;
  Inc(D2, A2 xor B2 xor C2 + Buffer[6]);
  D2 := D2 shl 5 or D2 shr 27;
  Inc(C2, D2 xor A2 xor B2 + Buffer[4]);
  C2 := C2 shl 8 or C2 shr 24;
  Inc(B2, C2 xor D2 xor A2 + Buffer[1]);
  B2 := B2 shl 11 or B2 shr 21;
  Inc(A2, B2 xor C2 xor D2 + Buffer[3]);
  A2 := A2 shl 14 or A2 shr 18;
  Inc(D2, A2 xor B2 xor C2 + Buffer[11]);
  D2 := D2 shl 14 or D2 shr 18;
  Inc(C2, D2 xor A2 xor B2 + Buffer[15]);
  C2 := C2 shl 6 or C2 shr 26;
  Inc(B2, C2 xor D2 xor A2 + Buffer[0]);
  B2 := B2 shl 14 or B2 shr 18;
  Inc(A2, B2 xor C2 xor D2 + Buffer[5]);
  A2 := A2 shl 6 or A2 shr 26;
  Inc(D2, A2 xor B2 xor C2 + Buffer[12]);
  D2 := D2 shl 9 or D2 shr 23;
  Inc(C2, D2 xor A2 xor B2 + Buffer[2]);
  C2 := C2 shl 12 or C2 shr 20;
  Inc(B2, C2 xor D2 xor A2 + Buffer[13]);
  B2 := B2 shl 9 or B2 shr 23;
  Inc(A2, B2 xor C2 xor D2 + Buffer[9]);
  A2 := A2 shl 12 or A2 shr 20;
  Inc(D2, A2 xor B2 xor C2 + Buffer[7]);
  D2 := D2 shl 5 or D2 shr 27;
  Inc(C2, D2 xor A2 xor B2 + Buffer[10]);
  C2 := C2 shl 15 or C2 shr 17;
  Inc(B2, C2 xor D2 xor A2 + Buffer[14]);
  B2 := B2 shl 8 or B2 shr 24;

  Inc(D2, C1 + FDigest[1]);
  FDigest[1] := FDigest[2] + D1 + A2;
  FDigest[2] := FDigest[3] + A1 + B2;
  FDigest[3] := FDIgest[0] + B1 + C2;
  FDigest[0] := D2;
end;

// ripe 256
class function THash_RipeMD256.TestVector: Pointer;
asm
  MOV   EAX,OFFSET @Vector
  RET
  @Vector: DB    0C3h,0B1h,0D7h,0ACh,0A8h,09Ah,047h,07Ah
  DB    038h,0D3h,06Dh,039h,0EFh,000h,0FBh,045h
  DB    0FCh,04Eh,0C3h,01Ah,071h,021h,0DBh,09Eh
  DB    01Ch,076h,0C5h,0DEh,099h,088h,018h,0C2h
end;

procedure THash_RipeMD256.Transform(Buffer: PIntArray);
var
  A1, B1, C1, D1: longword;
  A2, B2, C2, D2: longword;
  T: longword;
begin
  A1 := FDigest[0];
  B1 := FDigest[1];
  C1 := FDigest[2];
  D1 := FDigest[3];
  A2 := FDigest[4];
  B2 := FDigest[5];
  C2 := FDigest[6];
  D2 := FDigest[7];

  Inc(A1, B1 xor C1 xor D1 + Buffer[0]);
  A1 := A1 shl 11 or A1 shr 21;
  Inc(D1, A1 xor B1 xor C1 + Buffer[1]);
  D1 := D1 shl 14 or D1 shr 18;
  Inc(C1, D1 xor A1 xor B1 + Buffer[2]);
  C1 := C1 shl 15 or C1 shr 17;
  Inc(B1, C1 xor D1 xor A1 + Buffer[3]);
  B1 := B1 shl 12 or B1 shr 20;
  Inc(A1, B1 xor C1 xor D1 + Buffer[4]);
  A1 := A1 shl 5 or A1 shr 27;
  Inc(D1, A1 xor B1 xor C1 + Buffer[5]);
  D1 := D1 shl 8 or D1 shr 24;
  Inc(C1, D1 xor A1 xor B1 + Buffer[6]);
  C1 := C1 shl 7 or C1 shr 25;
  Inc(B1, C1 xor D1 xor A1 + Buffer[7]);
  B1 := B1 shl 9 or B1 shr 23;
  Inc(A1, B1 xor C1 xor D1 + Buffer[8]);
  A1 := A1 shl 11 or A1 shr 21;
  Inc(D1, A1 xor B1 xor C1 + Buffer[9]);
  D1 := D1 shl 13 or D1 shr 19;
  Inc(C1, D1 xor A1 xor B1 + Buffer[10]);
  C1 := C1 shl 14 or C1 shr 18;
  Inc(B1, C1 xor D1 xor A1 + Buffer[11]);
  B1 := B1 shl 15 or B1 shr 17;
  Inc(A1, B1 xor C1 xor D1 + Buffer[12]);
  A1 := A1 shl 6 or A1 shr 26;
  Inc(D1, A1 xor B1 xor C1 + Buffer[13]);
  D1 := D1 shl 7 or D1 shr 25;
  Inc(C1, D1 xor A1 xor B1 + Buffer[14]);
  C1 := C1 shl 9 or C1 shr 23;
  Inc(B1, C1 xor D1 xor A1 + Buffer[15]);
  B1 := B1 shl 8 or B1 shr 24;

  Inc(A2, B2 and D2 or C2 and not D2 + Buffer[5] + $50A28BE6);
  A2 := A2 shl 8 or A2 shr 24;
  Inc(D2, A2 and C2 or B2 and not C2 + Buffer[14] + $50A28BE6);
  D2 := D2 shl 9 or D2 shr 23;
  Inc(C2, D2 and B2 or A2 and not B2 + Buffer[7] + $50A28BE6);
  C2 := C2 shl 9 or C2 shr 23;
  Inc(B2, C2 and A2 or D2 and not A2 + Buffer[0] + $50A28BE6);
  B2 := B2 shl 11 or B2 shr 21;
  Inc(A2, B2 and D2 or C2 and not D2 + Buffer[9] + $50A28BE6);
  A2 := A2 shl 13 or A2 shr 19;
  Inc(D2, A2 and C2 or B2 and not C2 + Buffer[2] + $50A28BE6);
  D2 := D2 shl 15 or D2 shr 17;
  Inc(C2, D2 and B2 or A2 and not B2 + Buffer[11] + $50A28BE6);
  C2 := C2 shl 15 or C2 shr 17;
  Inc(B2, C2 and A2 or D2 and not A2 + Buffer[4] + $50A28BE6);
  B2 := B2 shl 5 or B2 shr 27;
  Inc(A2, B2 and D2 or C2 and not D2 + Buffer[13] + $50A28BE6);
  A2 := A2 shl 7 or A2 shr 25;
  Inc(D2, A2 and C2 or B2 and not C2 + Buffer[6] + $50A28BE6);
  D2 := D2 shl 7 or D2 shr 25;
  Inc(C2, D2 and B2 or A2 and not B2 + Buffer[15] + $50A28BE6);
  C2 := C2 shl 8 or C2 shr 24;
  Inc(B2, C2 and A2 or D2 and not A2 + Buffer[8] + $50A28BE6);
  B2 := B2 shl 11 or B2 shr 21;
  Inc(A2, B2 and D2 or C2 and not D2 + Buffer[1] + $50A28BE6);
  A2 := A2 shl 14 or A2 shr 18;
  Inc(D2, A2 and C2 or B2 and not C2 + Buffer[10] + $50A28BE6);
  D2 := D2 shl 14 or D2 shr 18;
  Inc(C2, D2 and B2 or A2 and not B2 + Buffer[3] + $50A28BE6);
  C2 := C2 shl 12 or C2 shr 20;
  Inc(B2, C2 and A2 or D2 and not A2 + Buffer[12] + $50A28BE6);
  B2 := B2 shl 6 or B2 shr 26;

  T  := A1;
  A1 := A2;
  A2 := T;

  Inc(A1, B1 and C1 or not B1 and D1 + Buffer[7] + $5A827999);
  A1 := A1 shl 7 or A1 shr 25;
  Inc(D1, A1 and B1 or not A1 and C1 + Buffer[4] + $5A827999);
  D1 := D1 shl 6 or D1 shr 26;
  Inc(C1, D1 and A1 or not D1 and B1 + Buffer[13] + $5A827999);
  C1 := C1 shl 8 or C1 shr 24;
  Inc(B1, C1 and D1 or not C1 and A1 + Buffer[1] + $5A827999);
  B1 := B1 shl 13 or B1 shr 19;
  Inc(A1, B1 and C1 or not B1 and D1 + Buffer[10] + $5A827999);
  A1 := A1 shl 11 or A1 shr 21;
  Inc(D1, A1 and B1 or not A1 and C1 + Buffer[6] + $5A827999);
  D1 := D1 shl 9 or D1 shr 23;
  Inc(C1, D1 and A1 or not D1 and B1 + Buffer[15] + $5A827999);
  C1 := C1 shl 7 or C1 shr 25;
  Inc(B1, C1 and D1 or not C1 and A1 + Buffer[3] + $5A827999);
  B1 := B1 shl 15 or B1 shr 17;
  Inc(A1, B1 and C1 or not B1 and D1 + Buffer[12] + $5A827999);
  A1 := A1 shl 7 or A1 shr 25;
  Inc(D1, A1 and B1 or not A1 and C1 + Buffer[0] + $5A827999);
  D1 := D1 shl 12 or D1 shr 20;
  Inc(C1, D1 and A1 or not D1 and B1 + Buffer[9] + $5A827999);
  C1 := C1 shl 15 or C1 shr 17;
  Inc(B1, C1 and D1 or not C1 and A1 + Buffer[5] + $5A827999);
  B1 := B1 shl 9 or B1 shr 23;
  Inc(A1, B1 and C1 or not B1 and D1 + Buffer[2] + $5A827999);
  A1 := A1 shl 11 or A1 shr 21;
  Inc(D1, A1 and B1 or not A1 and C1 + Buffer[14] + $5A827999);
  D1 := D1 shl 7 or D1 shr 25;
  Inc(C1, D1 and A1 or not D1 and B1 + Buffer[11] + $5A827999);
  C1 := C1 shl 13 or C1 shr 19;
  Inc(B1, C1 and D1 or not C1 and A1 + Buffer[8] + $5A827999);
  B1 := B1 shl 12 or B1 shr 20;

  Inc(A2, (B2 or not C2) xor D2 + Buffer[6] + $5C4DD124);
  A2 := A2 shl 9 or A2 shr 23;
  Inc(D2, (A2 or not B2) xor C2 + Buffer[11] + $5C4DD124);
  D2 := D2 shl 13 or D2 shr 19;
  Inc(C2, (D2 or not A2) xor B2 + Buffer[3] + $5C4DD124);
  C2 := C2 shl 15 or C2 shr 17;
  Inc(B2, (C2 or not D2) xor A2 + Buffer[7] + $5C4DD124);
  B2 := B2 shl 7 or B2 shr 25;
  Inc(A2, (B2 or not C2) xor D2 + Buffer[0] + $5C4DD124);
  A2 := A2 shl 12 or A2 shr 20;
  Inc(D2, (A2 or not B2) xor C2 + Buffer[13] + $5C4DD124);
  D2 := D2 shl 8 or D2 shr 24;
  Inc(C2, (D2 or not A2) xor B2 + Buffer[5] + $5C4DD124);
  C2 := C2 shl 9 or C2 shr 23;
  Inc(B2, (C2 or not D2) xor A2 + Buffer[10] + $5C4DD124);
  B2 := B2 shl 11 or B2 shr 21;
  Inc(A2, (B2 or not C2) xor D2 + Buffer[14] + $5C4DD124);
  A2 := A2 shl 7 or A2 shr 25;
  Inc(D2, (A2 or not B2) xor C2 + Buffer[15] + $5C4DD124);
  D2 := D2 shl 7 or D2 shr 25;
  Inc(C2, (D2 or not A2) xor B2 + Buffer[8] + $5C4DD124);
  C2 := C2 shl 12 or C2 shr 20;
  Inc(B2, (C2 or not D2) xor A2 + Buffer[12] + $5C4DD124);
  B2 := B2 shl 7 or B2 shr 25;
  Inc(A2, (B2 or not C2) xor D2 + Buffer[4] + $5C4DD124);
  A2 := A2 shl 6 or A2 shr 26;
  Inc(D2, (A2 or not B2) xor C2 + Buffer[9] + $5C4DD124);
  D2 := D2 shl 15 or D2 shr 17;
  Inc(C2, (D2 or not A2) xor B2 + Buffer[1] + $5C4DD124);
  C2 := C2 shl 13 or C2 shr 19;
  Inc(B2, (C2 or not D2) xor A2 + Buffer[2] + $5C4DD124);
  B2 := B2 shl 11 or B2 shr 21;

  T  := B1;
  B1 := B2;
  B2 := T;

  Inc(A1, (B1 or not C1) xor D1 + Buffer[3] + $6ED9EBA1);
  A1 := A1 shl 11 or A1 shr 21;
  Inc(D1, (A1 or not B1) xor C1 + Buffer[10] + $6ED9EBA1);
  D1 := D1 shl 13 or D1 shr 19;
  Inc(C1, (D1 or not A1) xor B1 + Buffer[14] + $6ED9EBA1);
  C1 := C1 shl 6 or C1 shr 26;
  Inc(B1, (C1 or not D1) xor A1 + Buffer[4] + $6ED9EBA1);
  B1 := B1 shl 7 or B1 shr 25;
  Inc(A1, (B1 or not C1) xor D1 + Buffer[9] + $6ED9EBA1);
  A1 := A1 shl 14 or A1 shr 18;
  Inc(D1, (A1 or not B1) xor C1 + Buffer[15] + $6ED9EBA1);
  D1 := D1 shl 9 or D1 shr 23;
  Inc(C1, (D1 or not A1) xor B1 + Buffer[8] + $6ED9EBA1);
  C1 := C1 shl 13 or C1 shr 19;
  Inc(B1, (C1 or not D1) xor A1 + Buffer[1] + $6ED9EBA1);
  B1 := B1 shl 15 or B1 shr 17;
  Inc(A1, (B1 or not C1) xor D1 + Buffer[2] + $6ED9EBA1);
  A1 := A1 shl 14 or A1 shr 18;
  Inc(D1, (A1 or not B1) xor C1 + Buffer[7] + $6ED9EBA1);
  D1 := D1 shl 8 or D1 shr 24;
  Inc(C1, (D1 or not A1) xor B1 + Buffer[0] + $6ED9EBA1);
  C1 := C1 shl 13 or C1 shr 19;
  Inc(B1, (C1 or not D1) xor A1 + Buffer[6] + $6ED9EBA1);
  B1 := B1 shl 6 or B1 shr 26;
  Inc(A1, (B1 or not C1) xor D1 + Buffer[13] + $6ED9EBA1);
  A1 := A1 shl 5 or A1 shr 27;
  Inc(D1, (A1 or not B1) xor C1 + Buffer[11] + $6ED9EBA1);
  D1 := D1 shl 12 or D1 shr 20;
  Inc(C1, (D1 or not A1) xor B1 + Buffer[5] + $6ED9EBA1);
  C1 := C1 shl 7 or C1 shr 25;
  Inc(B1, (C1 or not D1) xor A1 + Buffer[12] + $6ED9EBA1);
  B1 := B1 shl 5 or B1 shr 27;

  Inc(A2, B2 and C2 or not B2 and D2 + Buffer[15] + $6D703EF3);
  A2 := A2 shl 9 or A2 shr 23;
  Inc(D2, A2 and B2 or not A2 and C2 + Buffer[5] + $6D703EF3);
  D2 := D2 shl 7 or D2 shr 25;
  Inc(C2, D2 and A2 or not D2 and B2 + Buffer[1] + $6D703EF3);
  C2 := C2 shl 15 or C2 shr 17;
  Inc(B2, C2 and D2 or not C2 and A2 + Buffer[3] + $6D703EF3);
  B2 := B2 shl 11 or B2 shr 21;
  Inc(A2, B2 and C2 or not B2 and D2 + Buffer[7] + $6D703EF3);
  A2 := A2 shl 8 or A2 shr 24;
  Inc(D2, A2 and B2 or not A2 and C2 + Buffer[14] + $6D703EF3);
  D2 := D2 shl 6 or D2 shr 26;
  Inc(C2, D2 and A2 or not D2 and B2 + Buffer[6] + $6D703EF3);
  C2 := C2 shl 6 or C2 shr 26;
  Inc(B2, C2 and D2 or not C2 and A2 + Buffer[9] + $6D703EF3);
  B2 := B2 shl 14 or B2 shr 18;
  Inc(A2, B2 and C2 or not B2 and D2 + Buffer[11] + $6D703EF3);
  A2 := A2 shl 12 or A2 shr 20;
  Inc(D2, A2 and B2 or not A2 and C2 + Buffer[8] + $6D703EF3);
  D2 := D2 shl 13 or D2 shr 19;
  Inc(C2, D2 and A2 or not D2 and B2 + Buffer[12] + $6D703EF3);
  C2 := C2 shl 5 or C2 shr 27;
  Inc(B2, C2 and D2 or not C2 and A2 + Buffer[2] + $6D703EF3);
  B2 := B2 shl 14 or B2 shr 18;
  Inc(A2, B2 and C2 or not B2 and D2 + Buffer[10] + $6D703EF3);
  A2 := A2 shl 13 or A2 shr 19;
  Inc(D2, A2 and B2 or not A2 and C2 + Buffer[0] + $6D703EF3);
  D2 := D2 shl 13 or D2 shr 19;
  Inc(C2, D2 and A2 or not D2 and B2 + Buffer[4] + $6D703EF3);
  C2 := C2 shl 7 or C2 shr 25;
  Inc(B2, C2 and D2 or not C2 and A2 + Buffer[13] + $6D703EF3);
  B2 := B2 shl 5 or B2 shr 27;

  T  := C1;
  C1 := C2;
  C2 := T;

  Inc(A1, B1 and D1 or C1 and not D1 + Buffer[1] + $8F1BBCDC);
  A1 := A1 shl 11 or A1 shr 21;
  Inc(D1, A1 and C1 or B1 and not C1 + Buffer[9] + $8F1BBCDC);
  D1 := D1 shl 12 or D1 shr 20;
  Inc(C1, D1 and B1 or A1 and not B1 + Buffer[11] + $8F1BBCDC);
  C1 := C1 shl 14 or C1 shr 18;
  Inc(B1, C1 and A1 or D1 and not A1 + Buffer[10] + $8F1BBCDC);
  B1 := B1 shl 15 or B1 shr 17;
  Inc(A1, B1 and D1 or C1 and not D1 + Buffer[0] + $8F1BBCDC);
  A1 := A1 shl 14 or A1 shr 18;
  Inc(D1, A1 and C1 or B1 and not C1 + Buffer[8] + $8F1BBCDC);
  D1 := D1 shl 15 or D1 shr 17;
  Inc(C1, D1 and B1 or A1 and not B1 + Buffer[12] + $8F1BBCDC);
  C1 := C1 shl 9 or C1 shr 23;
  Inc(B1, C1 and A1 or D1 and not A1 + Buffer[4] + $8F1BBCDC);
  B1 := B1 shl 8 or B1 shr 24;
  Inc(A1, B1 and D1 or C1 and not D1 + Buffer[13] + $8F1BBCDC);
  A1 := A1 shl 9 or A1 shr 23;
  Inc(D1, A1 and C1 or B1 and not C1 + Buffer[3] + $8F1BBCDC);
  D1 := D1 shl 14 or D1 shr 18;
  Inc(C1, D1 and B1 or A1 and not B1 + Buffer[7] + $8F1BBCDC);
  C1 := C1 shl 5 or C1 shr 27;
  Inc(B1, C1 and A1 or D1 and not A1 + Buffer[15] + $8F1BBCDC);
  B1 := B1 shl 6 or B1 shr 26;
  Inc(A1, B1 and D1 or C1 and not D1 + Buffer[14] + $8F1BBCDC);
  A1 := A1 shl 8 or A1 shr 24;
  Inc(D1, A1 and C1 or B1 and not C1 + Buffer[5] + $8F1BBCDC);
  D1 := D1 shl 6 or D1 shr 26;
  Inc(C1, D1 and B1 or A1 and not B1 + Buffer[6] + $8F1BBCDC);
  C1 := C1 shl 5 or C1 shr 27;
  Inc(B1, C1 and A1 or D1 and not A1 + Buffer[2] + $8F1BBCDC);
  B1 := B1 shl 12 or B1 shr 20;

  Inc(A2, B2 xor C2 xor D2 + Buffer[8]);
  A2 := A2 shl 15 or A2 shr 17;
  Inc(D2, A2 xor B2 xor C2 + Buffer[6]);
  D2 := D2 shl 5 or D2 shr 27;
  Inc(C2, D2 xor A2 xor B2 + Buffer[4]);
  C2 := C2 shl 8 or C2 shr 24;
  Inc(B2, C2 xor D2 xor A2 + Buffer[1]);
  B2 := B2 shl 11 or B2 shr 21;
  Inc(A2, B2 xor C2 xor D2 + Buffer[3]);
  A2 := A2 shl 14 or A2 shr 18;
  Inc(D2, A2 xor B2 xor C2 + Buffer[11]);
  D2 := D2 shl 14 or D2 shr 18;
  Inc(C2, D2 xor A2 xor B2 + Buffer[15]);
  C2 := C2 shl 6 or C2 shr 26;
  Inc(B2, C2 xor D2 xor A2 + Buffer[0]);
  B2 := B2 shl 14 or B2 shr 18;
  Inc(A2, B2 xor C2 xor D2 + Buffer[5]);
  A2 := A2 shl 6 or A2 shr 26;
  Inc(D2, A2 xor B2 xor C2 + Buffer[12]);
  D2 := D2 shl 9 or D2 shr 23;
  Inc(C2, D2 xor A2 xor B2 + Buffer[2]);
  C2 := C2 shl 12 or C2 shr 20;
  Inc(B2, C2 xor D2 xor A2 + Buffer[13]);
  B2 := B2 shl 9 or B2 shr 23;
  Inc(A2, B2 xor C2 xor D2 + Buffer[9]);
  A2 := A2 shl 12 or A2 shr 20;
  Inc(D2, A2 xor B2 xor C2 + Buffer[7]);
  D2 := D2 shl 5 or D2 shr 27;
  Inc(C2, D2 xor A2 xor B2 + Buffer[10]);
  C2 := C2 shl 15 or C2 shr 17;
  Inc(B2, C2 xor D2 xor A2 + Buffer[14]);
  B2 := B2 shl 8 or B2 shr 24;

  T  := D1;
  D1 := D2;
  D2 := T;

  Inc(FDigest[0], A1);
  Inc(FDigest[1], B1);
  Inc(FDigest[2], C1);
  Inc(FDigest[3], D1);
  Inc(FDigest[4], A2);
  Inc(FDigest[5], B2);
  Inc(FDigest[6], C2);
  Inc(FDigest[7], D2);
end;

class function THash_RipeMD256.DigestKeySize: integer;
begin
  Result := 32;
end;

procedure THash_RipeMD256.Init;
begin
  FillChar(FBuffer, SizeOf(FBuffer), 0);
  FDigest[0] := $67452301;
  FDigest[1] := $EFCDAB89;
  FDigest[2] := $98BADCFE;
  FDigest[3] := $10325476;
  FDigest[4] := $76543210;
  FDigest[5] := $FEDCBA98;
  FDigest[6] := $89ABCDEF;
  FDigest[7] := $01234567;
  FDigest[8] := $01234567;
  FDigest[9] := $3C2D1E0F;
  FCount     := 0;
  Protect(True);
end;

function DefaultHashClass: THashClass;
begin
  Result := FDefaultHashClass;
end;

procedure SetDefaultHashClass(HashClass: THashClass);
begin
  if HashClass = nil then
    FDefaultHashClass := THash_RipeMD256
  else
    FDefaultHashClass := HashClass;
end;

function RegisterHash(const AHash: THashClass;
  const AName, ADescription: string): boolean;
var
  I: integer;
  S: string;
begin
  Result := False;
  if AHash = nil then
    Exit;
  S := Trim(AName);
  if S = '' then
  begin
    S := AHash.ClassName;
    if S[1] = 'T' then
      Delete(S, 1, 1);
    I := Pos('_', S);
    if I > 0 then
      Delete(S, 1, I);
  end;
  S := S + '=' + ADescription;
  I := HashList.IndexOfObject(Pointer(AHash));
  if I < 0 then
    HashList.AddObject(S, Pointer(AHash))
  else
    HashList[I] := S;
  Result := True;
end;

function UnregisterHash(const AHash: THashClass): boolean;
var
  I: integer;
begin
  Result := False;
  repeat
    I := HashList.IndexOfObject(Pointer(AHash));
    if I < 0 then
      Break;
    Result := True;
    HashList.Delete(I);
  until False;
end;

function HashList: TStrings;
begin
  if not IsObject(FHashList, TStringList) then
    FHashList := TStringList.Create;
  Result := FHashList;
end;

procedure HashNames(List: TStrings);
var
  I: integer;
begin
  if not IsObject(List, TStrings) then
    Exit;
  for I := 0 to HashList.Count - 1 do
    List.AddObject(FHashList.Names[I], FHashList.Objects[I]);
end;

function GetHashClass(const Name: string): THashClass;
var
  I: integer;
  N: string;
begin
  Result := nil;
  N      := Name;
  I      := Pos('_', N);
  if I > 0 then
    Delete(N, 1, I);
  for I := 0 to HashList.Count - 1 do
    if AnsiCompareText(N, String(GetShortClassName(TClass(FHashList.Objects[I])))) = 0 then
    begin
      Result := THashClass(FHashList.Objects[I]);
      Exit;
    end;
  I := FHashList.IndexOfName(N);
  if I >= 0 then
    Result := THashClass(FHashList.Objects[I]);
end;

function GetHashName(HashClass: THashClass): string;
var
  I: integer;
begin
  I := HashList.IndexOfObject(Pointer(HashClass));
  if I >= 0 then
    Result := FHashList.Names[I]
  else
    Result := String(GetShortClassName(HashClass));
end;

destructor THash.Destroy;
begin
  FillChar(DigestKey^, DigestKeySize, 0);
  inherited Destroy;
end;

procedure THash.Init;
begin
  Protect(True);
end;

procedure THash.Calc(const Data; DataSize: integer);
begin
end;

procedure THash.Protect(IsInit: boolean);
begin
{
  if Protection <> nil then
    if IsObject(Protection, TMAC) then
    begin
      with TMAC(Protection) do
        if IsInit then Init(Self) else Done(Self);
    end else
      if not IsInit then
        Protection.CodeBuffer(DigestKey^, DigestKeySize, paScramble);
}
end;

procedure THash.Done;
begin
  Protect(False);
end;

function THash.DigestKey: Pointer;
begin
  Result := GetTestVector;
end;

class function THash.DigestKeySize: integer;
begin
  Result := 0;
end;

function THash.DigestStr(Format: integer): AnsiString;
begin
  Result := StrToFormat(DigestKey, DigestKeySize, Format);
end;

class function THash.TestVector: Pointer;
begin
  Result := GetTestVector;
end;

class function THash.CalcStream(const Stream: TStream; StreamSize: integer;
  Protection: TProtection; Format: integer): AnsiString;
const
  maxBufSize = 1024 * 4;  {Buffersize for File, Stream-Access}
var
  Buf:     Pointer;
  BufSize: integer;
  Size:    integer;
  Hash:    THash;
begin
  Hash := Create(Protection);
  with Hash do
    try
      Buf := AllocMem(maxBufSize);
      Init;
      if StreamSize < 0 then
 {if Size < 0 then reset the Position, otherwise, calc with the specific
  Size and from the aktual Position in the Stream}
      begin
        Stream.Position := 0;
        StreamSize      := Stream.Size;
      end;
      Size := StreamSize;
      DoProgress(Hash, 0, Size);
      repeat
        BufSize := StreamSize;
        if BufSize > maxBufSize then
          BufSize := maxBufSize;
        BufSize := Stream.Read(Buf^, BufSize);
        if BufSize <= 0 then
          Break;
        Calc(Buf^, BufSize);
        Dec(StreamSize, BufSize);
        DoProgress(Hash, Size - StreamSize, Size);
      until BufSize <= 0;
      Done;
      Result := StrToFormat(DigestKey, DigestKeySize, Format);
    finally
      DoProgress(Hash, 0, 0);
      Free;
      ReallocMem(Buf, 0);
    end;
end;

class function THash.CalcString(const Data: AnsiString; Protection: TProtection;
  Format: integer): AnsiString;
begin
  with Create(Protection) do
    try
      Init;
      Calc(PAnsiChar(Data)^, Length(Data));
      Done;
      Result := StrToFormat(DigestKey, DigestKeySize, Format);
    finally
      Free;
    end;
end;

class function THash.CalcFile(const FileName: AnsiString; Protection: TProtection;
  Format: integer): AnsiString;
var
  S: TFileStream;
begin
  S := TFileStream.Create(String(FileName), fmOpenRead or fmShareDenyNone);
  try
    Result := CalcStream(S, S.Size, Protection, Format);
  finally
    S.Free;
  end;
end;

class function THash.CalcBuffer(const Buffer; BufferSize: integer;
  Protection: TProtection; Format: integer): AnsiString;
begin
  with Create(Protection) do {create an Object from my Classtype}
    try
      Init;
      Calc(Buffer, BufferSize);
      Done;
      Result := StrToFormat(DigestKey, DigestKeySize, Format);
    finally
      Free; {destroy it}
    end;
end;

class function THash.SelfTest: boolean;
var
  Test: AnsiString;
begin
  Test   := CalcBuffer(GetTestVector^, 32, nil, fmtCOPY);
  Result := InitTestIsOk and (MemCompare(PAnsiChar(Test), TestVector, Length(Test)) = 0);
end;

procedure THash.CodeInit(Action: TPAction);
begin
  Init;
  if Action = paWipe then
    RndXORBuffer(RndTimeSeed, DigestKey^, DigestKeySize);
  inherited CodeInit(Action);
end;

procedure THash.CodeDone(Action: TPAction);
begin
  inherited CodeDone(Action);
  if (Action <> paCalc) then
    Init
  else
    Done;
end;

procedure THash.CodeBuf(var Buffer; const BufferSize: integer; Action: TPAction);
var
  BPtr: PByte;
  CSize, DSize, BSize: integer;
begin
  if Action <> paDecode then
    inherited CodeBuf(Buffer, BufferSize, Action);
  if Action in Actions then
  begin
    BPtr := @Buffer;
    if BPtr = nil then
      Exit;
    DSize := DigestKeySize;
    CSize := BufferSize;
    if Action = paCalc then
    begin
      Calc(Buffer, BufferSize);
    end
    else
    begin
      if Action in [paScramble, paWipe] then
      begin
        while CSize > 0 do
        begin
          BSize := CSize;
          if BSize > DSize then
            BSize := DSize;
          Calc(BPtr^, BSize);
          Done;
          Move(DigestKey^, BPtr^, BSize);
          Dec(CSize, BSize);
          Inc(BPtr, BSize);
        end;
      end
      else
        while CSize > 0 do
        begin
          BSize := DSize;
          if BSize > CSize then
            BSize := CSize;
          Calc(DigestKey^, DSize);
          Done;
          XORBuffers(DigestKey, BPtr, BSize, BPtr);
          Dec(CSize, BSize);
          Inc(BPtr, BSize);
        end;
    end;
  end;
  if Action = paDecode then
    inherited CodeBuf(Buffer, BufferSize, Action);
end;

//------------ from hash end -----------

 //{$IFDEF UseASM}
 //  {$IFNDEF 486GE}  // no Support for <= CPU 386

{ Ok, follow a BAD BAD dirty Trick, BUT realy realistic and correct

  The Problem:
    I will use for CPU's >= 486 the BSWAP Mnemonic to speedup Blowfish more.
    ( BSWAP swaps the Byteorder from a 32bit Word A,B,C,D to D,C,B,A and back
      and is the fastes Solution, but only for >= 486 CPU)
    I must wrote two assembler optimated function, one for >= 486
    and one for <= 386. -> En/Decode() and En/Decode386().

  The normal Solution:
    See in Hash.pas the SwapInteger proc. We can define a private
    procedural Field in TCipher_Blowfish that contains a pointer to the CPU
    depended code procedure.
    i.E. an implementation:
     TCipher_Blowfish.Encode()
     begin
       FProc(Data);
     end;
   The Program must make a call to the virtual Method Encode() and
   a second call to FProc(Data), and in the Init() or Constructor must
   we initialize these FProc Field.

 The Dirty Solution:
   A virtual Method, and ONLY a virtual Method, is identicaly to a
   private Field in the Object Class.
   This Class Definition is stored in the Code Segment.
   Now, we modifying, when CPU <= 386, these Field, from the Classdefinition
   in the Code Segment !!!, and save a new Methodaddress, the Address from
   TCipher_Blowfish.Encode386 etc.
   This changes have Effect to all TCipher_Blowfish Instances,
   but not descending Classes from TCipher_Blowfish :-)
   This Trick work's theoretical with BP5? upto D4.

 Ok, You say many expense for a little speed more !?
   YES, but have You this here known ? NO ?, but now.
}
{
procedure FindVirtualMethodAndChange(AClass: TClass; MethodAddr, NewAddress: Pointer);
// MethodAddr must explicit exists
type
  PPointer = ^Pointer;
const
  PageSize = SizeOf(Pointer);
var
  Table: PPointer;
  SaveFlag: DWORD;
begin
  Table := PPointer(AClass);
  while Table^ <> MethodAddr do Inc(Table);
  if VirtualProtect(Table, PageSize, PAGE_EXECUTE_READWRITE, @SaveFlag) then
  try
    Table^ := NewAddress;
  finally
    VirtualProtect(Table, PageSize, SaveFlag, @SaveFlag);
  end;
end;
}
 //  {$ENDIF}
 //{$ENDIF}


initialization
  //{$IFDEF UseASM}
  //  {$IFNDEF 486GE}  // no Support for <= CPU 386
  {
  if CPUType <= 3 then  // CPU <= 386
  begin
    FindVirtualMethodAndChange(TCipher_Blowfish, @TCipher_Blowfish.Encode,
                                                 @TCipher_Blowfish.Encode386);
    FindVirtualMethodAndChange(TCipher_Blowfish, @TCipher_Blowfish.Decode,
                                                 @TCipher_Blowfish.Decode386);
  end;
  }
  //  {$ENDIF}
  //{$ENDIF}
{$IFDEF VER_D3H}
  AddModuleUnloadProc(ModuleUnload);
{$ENDIF}
  RegisterCipher(TCipher_Rijndael, '', '');

finalization
{$IFDEF VER_D3H}
  RemoveModuleUnloadProc(ModuleUnload);
{$ENDIF}
  FCipherList.Free;
  FCipherList := nil;
end.


