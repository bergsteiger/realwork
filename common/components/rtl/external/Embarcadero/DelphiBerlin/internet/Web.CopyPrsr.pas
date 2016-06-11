{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{ *************************************************************************** }
{                                                                             }
{ Licensees holding a valid Borland No-Nonsense License for this Software may }
{ use this file in accordance with such license, which appears in the file    }
{ license.txt that came with this Software.                                   }
{                                                                             }
{ *************************************************************************** }

unit Web.CopyPrsr;

interface

uses System.Classes;

const
  toEOL     = UTF8Char(5);
  toEOF     = UTF8Char(0);
  toSymbol  = UTF8Char(1);
  toString  = UTF8Char(2);
  toInteger = UTF8Char(3);
  toFloat   = UTF8Char(4);

type
{ TCopyParser }

  TCopyParser = class(TObject)
  private
    FStream: TStream;
    FOutStream: TStream;
    FOrigin: Int64;
    FBuffer: PUTF8Char;
    FBufPtr: PUTF8Char;
    FBufEnd: PUTF8Char;
    FSourcePtr: PUTF8Char;
    FSourceEnd: PUTF8Char;
    FTokenPtr: PUTF8Char;
    FStringPtr: PUTF8Char;
    FSourceLine: Integer;
    FSaveChar: UTF8Char;
    FToken: UTF8Char;
    procedure ReadBuffer;
    procedure SkipBlanks(DoCopy: Boolean);
    function SkipToNextToken(CopyBlanks, DoCopy: Boolean): UTF8Char;
    function CopySkipTo(Length: Integer; DoCopy: Boolean): UTF8String;
    function CopySkipToToken(AToken: UTF8Char; DoCopy: Boolean): UTF8String;
    function CopySkipToEOL(DoCopy: Boolean): UTF8String;
    function CopySkipToEOF(DoCopy: Boolean): UTF8String;
    procedure UpdateOutStream(StartPos: PUTF8Char);
  public
    constructor Create(Stream, OutStream: TStream);
    destructor Destroy; override;
    procedure CheckToken(T: UTF8Char);
    procedure CheckTokenSymbol(const S: UTF8String);
    function CopyTo(Length: Integer): UTF8String;
    function CopyToToken(AToken: UTF8Char): UTF8String;
    function CopyToEOL: UTF8String;
    function CopyToEOF: UTF8String;
    procedure CopyTokenToOutput;
    procedure Error(const Ident: string);
    procedure ErrorFmt(const Ident: string; const Args: array of const);
    procedure ErrorStr(const Message: string);
    function NextToken: UTF8Char;
    function SkipToken(CopyBlanks: Boolean): UTF8Char;
    procedure SkipEOL;
    function SkipTo(Length: Integer): UTF8String;
    function SkipToToken(AToken: UTF8Char): UTF8String;
    function SkipToEOL: UTF8String;
    function SkipToEOF: UTF8String;
    function SourcePos: Int64;
    function TokenComponentIdent: UTF8String;
    function TokenFloat: Extended;
    function TokenInt: Longint;
    function TokenString: UTF8String;
    function TokenSymbolIs(const S: UTF8String): Boolean;
    property SourceLine: Integer read FSourceLine;
    property Token: UTF8Char read FToken;
    property OutputStream: TStream read FOutStream write FOutStream;
  end;

implementation

uses
  {$IFDEF POSIX}
  Posix.String_,
  {$ENDIF POSIX}
  System.SysUtils,
  System.RTLConsts;

{ TCopyParser }

const
  ParseBufSize = 4096;

function LineStart(Buffer, BufPos: PUTF8Char): PUTF8Char;
var
  C: NativeInt;
begin
  Result := Buffer;
  C := (BufPos - Buffer) - 1;
  while (C > 0) and (Buffer[C] <> #10) do
    Dec(C);

  if C > 0 then
    Result := @Buffer[C + 1];
end;

function StrComp(const Str1, Str2: PUTF8Char): Integer;
var
  P1, P2: PUTF8Char;
begin
  P1 := Str1;
  P2 := Str2;
  while True do
  begin
    if (P1^ <> P2^) or (P1^ = #0) then
      Exit(Ord(P1^) - Ord(P2^));
    Inc(P1);
    Inc(P2);
  end;
end;

constructor TCopyParser.Create(Stream, OutStream: TStream);
var
  I: Integer;
begin
  FStream := Stream;
  FOutStream := OutStream;
  GetMem(FBuffer, ParseBufSize * sizeof(UTF8Char));
  for I := ParseBufSize-1 downto 0 do  // testing
    FBuffer[I] := #0;
  FBuffer[0] := #0;
  FBufPtr := FBuffer;
  FBufEnd := FBuffer + ParseBufSize;
  FSourcePtr := FBuffer;
  FSourceEnd := FBuffer;
  FTokenPtr := FBuffer;
  FSourceLine := 1;
  SkipToken(True);
end;

destructor TCopyParser.Destroy;
begin
  if FBuffer <> nil then
  begin
    FStream.Seek(IntPtr(FTokenPtr) - IntPtr(FBufPtr), soCurrent);
    FreeMem(FBuffer, ParseBufSize);
  end;
end;

procedure TCopyParser.CheckToken(T: UTF8Char);
begin
  if Token <> T then
    case T of
      toSymbol:
        Error(SIdentifierExpected);
      Web.CopyPrsr.toString:
        Error(SStringExpected);
      toInteger, toFloat:
        Error(SNumberExpected);
    else
      ErrorFmt(SCharExpected, [T]);
    end;
end;

procedure TCopyParser.CheckTokenSymbol(const S: UTF8String);
begin
  if not TokenSymbolIs(S) then ErrorFmt(SSymbolExpected, [S]);
end;

function TCopyParser.CopySkipTo(Length: Integer; DoCopy: Boolean): UTF8String;
var
  P: PUTF8Char;
  Temp: UTF8String;
begin
  Result := '';
  repeat
    P := FTokenPtr;
    while (Length > 0) and (P^ <> #0) do
    begin
      Inc(P);
      Dec(Length);
    end;
    if DoCopy and (FOutStream <> nil) then
        FOutStream.WriteBuffer(FTokenPtr^, P - FTokenPtr);
    SetString(Temp, FTokenPtr, P - FTokenPtr);
    Result := Result + Temp;
    if Length > 0 then ReadBuffer;
  until (Length = 0) or (Token = toEOF);
  FSourcePtr := P;
end;

function TCopyParser.CopySkipToEOL(DoCopy: Boolean): UTF8String;
var
  P: PUTF8Char;
begin
  P := FTokenPtr;
  while not (P^ in [#13, #10, #0]) do Inc(P);
  SetString(Result, FTokenPtr, P - FTokenPtr);
  if P^ = #13 then Inc(P);
  FSourcePtr := P;
  if DoCopy then UpdateOutStream(FTokenPtr);
  NextToken;
end;

function TCopyParser.CopySkipToEOF(DoCopy: Boolean): UTF8String;
var
  P: PUTF8Char;
  Temp: UTF8String;
begin
  repeat
    P := FTokenPtr;
    while P^ <> #0 do Inc(P);
    FSourcePtr := P;
    SetString(Temp, FTokenPtr, P - FTokenPtr);
    Result := Result + Temp;
    if DoCopy then
    begin
      UpdateOutStream(FTokenPtr);
      NextToken;
    end else SkipToken(False);
    FTokenPtr := FSourcePtr;
  until Token = toEOF;
end;

function TCopyParser.CopySkipToToken(AToken: UTF8Char; DoCopy: Boolean): UTF8String;
var
  S: PUTF8Char;
  Temp: UTF8String;

  procedure InternalSkipBlanks;
  begin
    while True do
    begin
      case FSourcePtr^ of
        #0:
          begin
            SetString(Temp, S, FSourcePtr - S);
            Result := Result + Temp;
            if DoCopy then UpdateOutStream(S);
            ReadBuffer;
            if FSourcePtr^ = #0 then Exit;
            S := FSourcePtr;
            Continue;
          end;
        #10:
          Inc(FSourceLine);
        #33..#255:
          Break;
      end;
      Inc(FSourcePtr);
    end;
    if DoCopy then UpdateOutStream(S);
  end;

var
  InSingleQuote, InDoubleQuote: Boolean;
  Found: Boolean;
begin
  InSingleQuote := False;
  InDoubleQuote := False;
  Found := False;
  Result := '';
  while (not Found) and (Token <> toEOF) do
  begin
    S := FSourcePtr;
    InternalSkipBlanks;
    if S <> FSourcePtr then
    begin
      SetString(Temp, S, FSourcePtr - S);
      Result := Result + Temp;
    end;
    SkipToNextToken(DoCopy, DoCopy);
    if Token = '"' then
      InDoubleQuote := not InDoubleQuote and not InSingleQuote
    else if Token = '''' then
      InSingleQuote := not InSingleQuote and not InDoubleQuote;
    Found := (Token = AToken) and
         (((Token = '"') and (not InSingleQuote)) or
          ((Token = '''') and (not InDoubleQuote)) or
           not (InDoubleQuote or InSingleQuote));
    if not Found then
    begin
      SetString(Temp, FTokenPtr, FSourcePtr - FTokenPtr);
      Result := Result + Temp;
    end;
  end;
end;

function TCopyParser.CopyTo(Length: Integer): UTF8String;
begin
  Result := CopySkipTo(Length, True);
end;

function TCopyParser.CopyToToken(AToken: UTF8Char): UTF8String;
begin
  Result := CopySkipToToken(AToken, True);
end;

function TCopyParser.CopyToEOL: UTF8String;
begin
  Result := CopySkipToEOL(True);
end;

function TCopyParser.CopyToEOF: UTF8String;
begin
  Result := CopySkipToEOF(True);
end;

procedure TCopyParser.CopyTokenToOutput;
begin
  UpdateOutStream(FTokenPtr);
end;

procedure TCopyParser.Error(const Ident: string);
begin
  ErrorStr(Ident);
end;

procedure TCopyParser.ErrorFmt(const Ident: string; const Args: array of const);
begin
  ErrorStr(Format(Ident, Args));
end;

procedure TCopyParser.ErrorStr(const Message: string);
begin
  raise EParserError.CreateResFmt(@SParseError, [Message, FSourceLine]);
end;

function TCopyParser.NextToken: UTF8Char;
begin
  Result := SkipToNextToken(True, True);
end;

function TCopyParser.SkipTo(Length: Integer): UTF8String;
begin
  Result := CopySkipTo(Length, False);
end;

function TCopyParser.SkipToToken(AToken: UTF8Char): UTF8String;
begin
  Result := CopySkipToToken(AToken, False);
end;

function TCopyParser.SkipToEOL: UTF8String;
begin
  Result := CopySkipToEOL(False);
end;

function TCopyParser.SkipToEOF: UTF8String;
begin
  Result := CopySkipToEOF(False);
end;

function TCopyParser.SkipToNextToken(CopyBlanks, DoCopy: Boolean): UTF8Char;
var
  P, StartPos: PUTF8Char;
begin
  SkipBlanks(CopyBlanks);
  P := FSourcePtr;
  FTokenPtr := P;
  case P^ of
    'A'..'Z', 'a'..'z', '_':
      begin
        Inc(P);
        while P^ in ['A'..'Z', 'a'..'z', '0'..'9', '_'] do Inc(P);
        Result := toSymbol;
      end;
    #10:
      begin
        Inc(P);
        Inc(FSourceLine);
        Result := toEOL;
      end;
  else
    Result := P^;
    if Result <> toEOF then Inc(P);
  end;
  StartPos := FSourcePtr;
  FSourcePtr := P;
  if DoCopy then UpdateOutStream(StartPos);
  FToken := Result;
end;

function TCopyParser.SkipToken(CopyBlanks: Boolean): UTF8Char;
begin
  Result := SkipToNextToken(CopyBlanks, False);
end;

procedure TCopyParser.ReadBuffer;
var
  Count: Integer;
begin
  Inc(FOrigin, FSourcePtr - FBuffer);
  FSourceEnd[0] := FSaveChar;
  Count := FBufPtr - FSourcePtr;
  if Count <> 0 then Move(FSourcePtr[0], FBuffer[0], Count);
  FBufPtr := FBuffer + Count;
  Inc(FBufPtr, FStream.Read(FBufPtr[0], (FBufEnd - FBufPtr) * sizeof(UTF8Char)));
  FSourcePtr := FBuffer;
  FSourceEnd := FBufPtr;
  if FSourceEnd = FBufEnd then
  begin
    FSourceEnd := LineStart(FBuffer, FSourceEnd - 1);
    if FSourceEnd = FBuffer then Error(SLineTooLong);
  end;
  FSaveChar := FSourceEnd[0];
  FSourceEnd[0] := #0;
end;

procedure TCopyParser.SkipBlanks(DoCopy: Boolean);
var
  Start: PUTF8Char;
begin
  Start := FSourcePtr;
  while True do
  begin
    case FSourcePtr^ of
      #0:
        begin
          if DoCopy then UpdateOutStream(Start);
          ReadBuffer;
          if FSourcePtr^ = #0 then Exit;
          Start := FSourcePtr;
          Continue;
        end;
      #10:
        Inc(FSourceLine);
      #33..#255:
        Break;
    end;
    Inc(FSourcePtr);
  end;
  if DoCopy then UpdateOutStream(Start);
end;

function TCopyParser.SourcePos: Int64;
begin
  Result := FOrigin + (FTokenPtr - FBuffer);
end;

procedure TCopyParser.SkipEOL;
begin
  if Token = toEOL then
  begin
    while FTokenPtr^ in [#13, #10] do Inc(FTokenPtr);
    FSourcePtr := FTokenPtr;
    if FSourcePtr^ <> #0 then
      NextToken
    else FToken := #0;
  end;
end;

function TCopyParser.TokenFloat: Extended;
begin
  Result := StrToFloat(string(TokenString));
end;

function TCopyParser.TokenInt: Longint;
begin
  Result := StrToInt(string(TokenString));
end;

function TCopyParser.TokenString: UTF8String;
var
  L: Int64;
begin
  if FToken = Web.CopyPrsr.toString then
    L := FStringPtr - FTokenPtr else
    L := FSourcePtr - FTokenPtr;
  SetString(Result, FTokenPtr, L);
end;

function TCopyParser.TokenSymbolIs(const S: UTF8String): Boolean;
begin
  Result := (Token = toSymbol) and (StrComp(PUTF8Char(S), PUTF8Char(TokenString)) = 0);
end;

function TCopyParser.TokenComponentIdent: UTF8String;
var
  P: PUTF8Char;
begin
  CheckToken(toSymbol);
  P := FSourcePtr;
  while P^ = '.' do
  begin
    Inc(P);
    if not (P^ in ['A'..'Z', 'a'..'z', '_']) then
      Error(SIdentifierExpected);
    repeat
      Inc(P)
    until not (P^ in ['A'..'Z', 'a'..'z', '0'..'9', '_']);
  end;
  FSourcePtr := P;
  Result := TokenString;
end;

procedure TCopyParser.UpdateOutStream(StartPos: PUTF8Char);
begin
  if FOutStream <> nil then
    FOutStream.WriteBuffer(StartPos^, FSourcePtr - StartPos);
end;

end.
