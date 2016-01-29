{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
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
{$IFDEF NEXTGEN}
  toEOL     = Char(5);
  toEOF     = Char(0);
  toSymbol  = Char(1);
  toString  = Char(2);
  toInteger = Char(3);
  toFloat   = Char(4);
{$ELSE !NEXTGEN}
  toEOL     = AnsiChar(5);
  toEOF     = AnsiChar(0);
  toSymbol  = AnsiChar(1);
  toString  = AnsiChar(2);
  toInteger = AnsiChar(3);
  toFloat   = AnsiChar(4);
{$ENDIF NEXTGEN}

type
{ TCopyParser }

{$IFDEF NEXTGEN}
  TCopyParser = class(TObject)
  private
    FStream: TStream;
    FOutStream: TStream;
    FOrigin: Int64;
    FBuffer: PChar;
    FBufPtr: PChar;
    FBufEnd: PChar;
    FSourcePtr: PChar;
    FSourceEnd: PChar;
    FTokenPtr: PChar;
    FStringPtr: PChar;
    FSourceLine: Integer;
    FSaveChar: Char;
    FToken: Char;
    procedure ReadBuffer;
    procedure SkipBlanks(DoCopy: Boolean);
    function SkipToNextToken(CopyBlanks, DoCopy: Boolean): Char;
    function CopySkipTo(Length: Integer; DoCopy: Boolean): string;
    function CopySkipToToken(AToken: Char; DoCopy: Boolean): string;
    function CopySkipToEOL(DoCopy: Boolean): string;
    function CopySkipToEOF(DoCopy: Boolean): string;
    procedure UpdateOutStream(StartPos: PChar);
  public
    constructor Create(Stream, OutStream: TStream);
    destructor Destroy; override;
    procedure CheckToken(T: Char);
    procedure CheckTokenSymbol(const S: string);
    function CopyTo(Length: Integer): string;
    function CopyToToken(AToken: Char): string;
    function CopyToEOL: string;
    function CopyToEOF: string;
    procedure CopyTokenToOutput;
    procedure Error(const Ident: string);
    procedure ErrorFmt(const Ident: string; const Args: array of const);
    procedure ErrorStr(const Message: string);
    function NextToken: Char;
    function SkipToken(CopyBlanks: Boolean): Char;
    procedure SkipEOL;
    function SkipTo(Length: Integer): string;
    function SkipToToken(AToken: Char): string;
    function SkipToEOL: string;
    function SkipToEOF: string;
    function SourcePos: Int64;
    function TokenComponentIdent: string;
    function TokenFloat: Extended;
    function TokenInt: Longint;
    function TokenString: string;
    function TokenSymbolIs(const S: string): Boolean;
    property SourceLine: Integer read FSourceLine;
    property Token: Char read FToken;
    property OutputStream: TStream read FOutStream write FOutStream;
  end;
{$ELSE !NEXTGEN}
  TCopyParser = class(TObject)
  private
    FStream: TStream;
    FOutStream: TStream;
    FOrigin: Int64;
    FBuffer: PAnsiChar;
    FBufPtr: PAnsiChar;
    FBufEnd: PAnsiChar;
    FSourcePtr: PAnsiChar;
    FSourceEnd: PAnsiChar;
    FTokenPtr: PAnsiChar;
    FStringPtr: PAnsiChar;
    FSourceLine: Integer;
    FSaveChar: AnsiChar;
    FToken: AnsiChar;
    procedure ReadBuffer;
    procedure SkipBlanks(DoCopy: Boolean);
    function SkipToNextToken(CopyBlanks, DoCopy: Boolean): AnsiChar;
    function CopySkipTo(Length: Integer; DoCopy: Boolean): AnsiString;
    function CopySkipToToken(AToken: AnsiChar; DoCopy: Boolean): AnsiString;
    function CopySkipToEOL(DoCopy: Boolean): AnsiString;
    function CopySkipToEOF(DoCopy: Boolean): AnsiString;
    procedure UpdateOutStream(StartPos: PAnsiChar);
  public
    constructor Create(Stream, OutStream: TStream);
    destructor Destroy; override;
    procedure CheckToken(T: AnsiChar);
    procedure CheckTokenSymbol(const S: AnsiString);
    function CopyTo(Length: Integer): AnsiString;
    function CopyToToken(AToken: AnsiChar): AnsiString;
    function CopyToEOL: AnsiString;
    function CopyToEOF: AnsiString;
    procedure CopyTokenToOutput;
    procedure Error(const Ident: string);
    procedure ErrorFmt(const Ident: string; const Args: array of const);
    procedure ErrorStr(const Message: string);
    function NextToken: AnsiChar;
    function SkipToken(CopyBlanks: Boolean): AnsiChar;
    procedure SkipEOL;
    function SkipTo(Length: Integer): AnsiString;
    function SkipToToken(AToken: AnsiChar): AnsiString;
    function SkipToEOL: AnsiString;
    function SkipToEOF: AnsiString;
    function SourcePos: Int64;
    function TokenComponentIdent: AnsiString;
    function TokenFloat: Extended;
    function TokenInt: Longint;
    function TokenString: AnsiString;
    function TokenSymbolIs(const S: AnsiString): Boolean;
    property SourceLine: Integer read FSourceLine;
    property Token: AnsiChar read FToken;
    property OutputStream: TStream read FOutStream write FOutStream;
  end;
{$ENDIF NEXTGEN}

implementation

uses
  {$IFDEF POSIX}
  Posix.String_,
  {$ENDIF POSIX}
  System.SysUtils,
{$IFNDEF NEXTGEN}  System.AnsiStrings, {$ENDIF !NEXTGEN}
  System.RTLConsts;

{ TCopyParser }

const
  ParseBufSize = 4096;

constructor TCopyParser.Create(Stream, OutStream: TStream);
var
  I: Integer;
begin
  FStream := Stream;
  FOutStream := OutStream;
{$IFDEF NEXTGEN}
  GetMem(FBuffer, ParseBufSize * sizeof(Char));
{$ELSE !NEXTGEN}
  GetMem(FBuffer, ParseBufSize * sizeof(AnsiChar));
{$ENDIF NEXTGEN}
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

{$IFDEF NEXTGEN}
procedure TCopyParser.CheckToken(T: Char);
{$ELSE !NEXTGEN}
procedure TCopyParser.CheckToken(T: AnsiChar);
{$ENDIF NEXTGEN}
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

{$IFDEF NEXTGEN}
procedure TCopyParser.CheckTokenSymbol(const S: string);
{$ELSE !NEXTGEN}
procedure TCopyParser.CheckTokenSymbol(const S: AnsiString);
{$ENDIF NEXTGEN}
begin
  if not TokenSymbolIs(S) then ErrorFmt(SSymbolExpected, [S]);
end;

{$IFDEF NEXTGEN}
function TCopyParser.CopySkipTo(Length: Integer; DoCopy: Boolean): string;
var
  P: PChar;
  Temp: string;
{$ELSE !NEXTGEN}
function TCopyParser.CopySkipTo(Length: Integer; DoCopy: Boolean): AnsiString;
var
  P: PAnsiChar;
  Temp: AnsiString;
{$ENDIF NEXTGEN}
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

{$IFDEF NEXTGEN}
function TCopyParser.CopySkipToEOL(DoCopy: Boolean): string;
var
  P: PChar;
{$ELSE !NEXTGEN}
function TCopyParser.CopySkipToEOL(DoCopy: Boolean): AnsiString;
var
  P: PAnsiChar;
{$ENDIF NEXTGEN}
begin
  P := FTokenPtr;
  while not (Byte(P^) in [Ord(#13), Ord(#10), Ord(#0)]) do Inc(P);
  SetString(Result, FTokenPtr, P - FTokenPtr);
  if P^ = #13 then Inc(P);
  FSourcePtr := P;
  if DoCopy then UpdateOutStream(FTokenPtr);
  NextToken;
end;

{$IFDEF NEXTGEN}
function TCopyParser.CopySkipToEOF(DoCopy: Boolean): string;
var
  P: PChar;
  Temp: string;
{$ELSE !NEXTGEN}
function TCopyParser.CopySkipToEOF(DoCopy: Boolean): AnsiString;
var
  P: PAnsiChar;
  Temp: AnsiString;
{$ENDIF NEXTGEN}
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

{$IFDEF NEXTGEN}
function TCopyParser.CopySkipToToken(AToken: Char; DoCopy: Boolean): string;
var
  S: PChar;
  Temp: string;
{$ELSE !NEXTGEN}
function TCopyParser.CopySkipToToken(AToken: AnsiChar; DoCopy: Boolean): AnsiString;
var
  S: PAnsiChar;
  Temp: AnsiString;
{$ENDIF NEXTGEN}

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

{$IFDEF NEXTGEN}
function TCopyParser.CopyTo(Length: Integer): string;
{$ELSE !NEXTGEN}
function TCopyParser.CopyTo(Length: Integer): AnsiString;
{$ENDIF NEXTGEN}
begin
  Result := CopySkipTo(Length, True);
end;

{$IFDEF NEXTGEN}
function TCopyParser.CopyToToken(AToken: Char): string;
{$ELSE !NEXTGEN}
function TCopyParser.CopyToToken(AToken: AnsiChar): AnsiString;
{$ENDIF NEXTGEN}
begin
  Result := CopySkipToToken(AToken, True);
end;

{$IFDEF NEXTGEN}
function TCopyParser.CopyToEOL: string;
{$ELSE !NEXTGEN}
function TCopyParser.CopyToEOL: AnsiString;
{$ENDIF NEXTGEN}
begin
  Result := CopySkipToEOL(True);
end;

{$IFDEF NEXTGEN}
function TCopyParser.CopyToEOF: string;
{$ELSE !NEXTGEN}
function TCopyParser.CopyToEOF: AnsiString;
{$ENDIF NEXTGEN}
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

{$IFDEF NEXTGEN}
function TCopyParser.NextToken: Char;
{$ELSE !NEXTGEN}
function TCopyParser.NextToken: AnsiChar;
{$ENDIF NEXTGEN}
begin
  Result := SkipToNextToken(True, True);
end;

{$IFDEF NEXTGEN}
function TCopyParser.SkipTo(Length: Integer): string;
{$ELSE !NEXTGEN}
function TCopyParser.SkipTo(Length: Integer): AnsiString;
{$ENDIF NEXTGEN}
begin
  Result := CopySkipTo(Length, False);
end;

{$IFDEF NEXTGEN}
function TCopyParser.SkipToToken(AToken: Char): string;
{$ELSE !NEXTGEN}
function TCopyParser.SkipToToken(AToken: AnsiChar): AnsiString;
{$ENDIF NEXTGEN}
begin
  Result := CopySkipToToken(AToken, False);
end;

{$IFDEF NEXTGEN}
function TCopyParser.SkipToEOL: string;
{$ELSE !NEXTGEN}
function TCopyParser.SkipToEOL: AnsiString;
{$ENDIF NEXTGEN}
begin
  Result := CopySkipToEOL(False);
end;

{$IFDEF NEXTGEN}
function TCopyParser.SkipToEOF: string;
{$ELSE !NEXTGEN}
function TCopyParser.SkipToEOF: AnsiString;
{$ENDIF NEXTGEN}
begin
  Result := CopySkipToEOF(False);
end;

{$IFDEF NEXTGEN}
function TCopyParser.SkipToNextToken(CopyBlanks, DoCopy: Boolean): Char;
var
  P, StartPos: PChar;
{$ELSE !NEXTGEN}
function TCopyParser.SkipToNextToken(CopyBlanks, DoCopy: Boolean): AnsiChar;
var
  P, StartPos: PAnsiChar;
{$ENDIF NEXTGEN}
begin
  SkipBlanks(CopyBlanks);
  P := FSourcePtr;
  FTokenPtr := P;
  case P^ of
    'A'..'Z', 'a'..'z', '_':
      begin
        Inc(P);
        while Byte(P^) in [Ord('A')..Ord('Z'), Ord('a')..Ord('z'), Ord('0')..Ord('9'), Ord('_')] do Inc(P);
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

{$IFDEF NEXTGEN}
function TCopyParser.SkipToken(CopyBlanks: Boolean): Char;
{$ELSE !NEXTGEN}
function TCopyParser.SkipToken(CopyBlanks: Boolean): AnsiChar;
{$ENDIF NEXTGEN}
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
{$IFDEF NEXTGEN}
  Inc(FBufPtr, FStream.Read(FBufPtr[0], (FBufEnd - FBufPtr) * sizeof(Char)));
{$ELSE !NEXTGEN}
  Inc(FBufPtr, FStream.Read(FBufPtr[0], (FBufEnd - FBufPtr) * sizeof(AnsiChar)));
{$ENDIF NEXTGEN}
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
{$IFDEF NEXTGEN}
  Start: PChar;
{$ELSE !NEXTGEN}
  Start: PAnsiChar;
{$ENDIF NEXTGEN}
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
    while Byte(FTokenPtr^) in [Ord(#13), Ord(#10)] do Inc(FTokenPtr);
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

{$IFDEF NEXTGEN}
function TCopyParser.TokenString: string;
{$ELSE !NEXTGEN}
function TCopyParser.TokenString: AnsiString;
{$ENDIF NEXTGEN}
var
  L: Int64;
begin
  if FToken = Web.CopyPrsr.toString then
    L := FStringPtr - FTokenPtr else
    L := FSourcePtr - FTokenPtr;
  SetString(Result, FTokenPtr, L);
end;

{$IFDEF NEXTGEN}
function TCopyParser.TokenSymbolIs(const S: string): Boolean;
begin
  Result := (Token = toSymbol) and (StrComp(PChar(S), PChar(TokenString)) = 0);
end;
{$ELSE !NEXTGEN}
function TCopyParser.TokenSymbolIs(const S: AnsiString): Boolean;
begin
  Result := (Token = toSymbol) and (System.AnsiStrings.AnsiStrComp(PAnsiChar(S), PAnsiChar(TokenString)) = 0);
end;
{$ENDIF NEXTGEN}

{$IFDEF NEXTGEN}
function TCopyParser.TokenComponentIdent: string;
var
  P: PChar;
{$ELSE !NEXTGEN}
function TCopyParser.TokenComponentIdent: AnsiString;
var
  P: PAnsiChar;
{$ENDIF NEXTGEN}
begin
  CheckToken(toSymbol);
  P := FSourcePtr;
  while P^ = '.' do
  begin
    Inc(P);
    if not (Byte(P^) in [Ord('A')..Ord('Z'), Ord('a')..Ord('z'), Ord('_')]) then
      Error(SIdentifierExpected);
    repeat
      Inc(P)
    until not (Byte(P^) in [Ord('A')..Ord('Z'), Ord('a')..Ord('z'), Ord('0')..Ord('9'), ORd('_')]);
  end;
  FSourcePtr := P;
  Result := TokenString;
end;

{$IFDEF NEXTGEN}
procedure TCopyParser.UpdateOutStream(StartPos: PChar);
{$ELSE !NEXTGEN}
procedure TCopyParser.UpdateOutStream(StartPos: PAnsiChar);
{$ENDIF NEXTGEN}
begin
  if FOutStream <> nil then
    FOutStream.WriteBuffer(StartPos^, FSourcePtr - StartPos);
end;

end.
