{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{       Web server application components               }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

// Parse an HTTP header.

unit HTTPParse;

interface

uses System.SysUtils, System.Classes;

const
  toEOF           = AnsiChar(0);
  toSymbol        = AnsiChar(1);
  toString        = AnsiChar(2);
  toInteger       = AnsiChar(3);
  toFloat         = AnsiChar(4);
  toEOL           = AnsiChar(5);
  toGET           = AnsiChar(6);
  toHEAD          = AnsiChar(7);
  toPUT           = AnsiChar(8);
  toDELETE        = AnsiChar(9);
  toPOST          = AnsiChar(10);
  toPATCH         = AnsiChar(11);
  toCOPY          = AnsiChar(12);
  toUserAgent     = AnsiChar(13);
  toAccept        = AnsiChar(14);
  toContentType   = AnsiChar(15);
  toContentLength = AnsiChar(16);
  toReferer       = AnsiChar(17);
  toAuthorization = AnsiChar(18);
  toCacheControl  = AnsiChar(19);
  toDate          = AnsiChar(20);
  toFrom          = AnsiChar(21);
  toHost          = AnsiChar(22);
  toIfModified    = AnsiChar(23);
  toContentEncoding = AnsiChar(24);
  toContentVersion= AnsiChar(25);
  toAllow         = AnsiChar(26);
  toConnection    = AnsiChar(27);
  toCookie        = AnsiChar(28);
  toContentDisposition = AnsiChar(29);

  hcGET            = $14F5;
  hcPUT            = $4AF5;
  hcDELETE         = $92B2;
  hcPOST           = $361D;
  hcCacheControl   = $4FF6;
  hcDate           = $0EE6;
  hcFrom           = $418F;
  hcHost           = $3611;
  hcIfModified     = $DDF0;
  hcAllow          = $3D80;
  hcUserAgent      = $E890;
  hcAccept         = $1844;
  hcContentEncoding= $C586;
  hcContentVersion = $EDF4;
  hcContentType    = $F0E0;
  hcContentLength  = $B0C4;
  hcReferer        = $CEA5;
  hcAuthorization  = $ABCA;
  hcConnection     = $0EDE;
  hcCookie         = $27B3;
  hcContentDisposition = $CBEB;

type

{ THTTPParser }

  THTTPParser = class(TObject)
  private
    FStream: TStream;
    FOrigin: Int64;
    FBuffer: PAnsiChar;
    FBufPtr: PAnsiChar;
    FBufEnd: PAnsiChar;
    FSourcePtr: PAnsiChar;
    FSourceEnd: PAnsiChar;
    FStringPtr: PAnsiChar;
    FSourceLine: Integer;
    FSaveChar: AnsiChar;
    FToken: AnsiChar;
    FHeaderField: Boolean;
    FTokenPtr: PAnsiChar;
    procedure ReadBuffer;
    procedure SkipBlanks;
  public
    constructor Create(Stream: TStream);
    destructor Destroy; override;
    procedure CheckToken(T: AnsiChar);
    procedure CheckTokenSymbol(const S: AnsiString);
    function CopyTo(Length: Integer): AnsiString;
    function CopyToEOL: AnsiString;
    function CopyToEOF: AnsiString;
    procedure Error(const Ident: string);
    procedure ErrorFmt(const Ident: string; const Args: array of const);
    procedure ErrorStr(const Message: string);
    procedure HexToBinary(Stream: TStream);
    function NextToken: AnsiChar;
    procedure SkipEOL;
    function SourcePos: Int64;
    function TokenFloat: Extended;
    function TokenInt: Longint;
    function TokenString: AnsiString;
    function TokenSymbolIs(const S: AnsiString): Boolean;
    function BufferRequest(Length: Integer): TStream;
    property SourceLine: Integer read FSourceLine;
    property Token: AnsiChar read FToken;
    property HeaderField: Boolean read FHeaderField write FHeaderField;
    property SourcePtr: PAnsiChar read FSourcePtr write FSourcePtr;
    property TokenPtr: PAnsiChar read FTokenPtr write FTokenPtr;
    property Stream: TStream read FStream;
    property SourceEnd: PAnsiChar read FSourceEnd;
  end;


implementation

uses System.RTLConsts, Winapi.Windows, System.AnsiStrings;

const
  ParseBufSize = 4096;

{ THTTPParser }

constructor THTTPParser.Create(Stream: TStream);
begin
  FStream := Stream;
  GetMem(FBuffer, ParseBufSize);
  FBuffer[0] := #0;
  FBufPtr := FBuffer;
  FBufEnd := FBuffer + ParseBufSize;
  FSourcePtr := FBuffer;
  FSourceEnd := FBuffer;
  FTokenPtr := FBuffer;
  FSourceLine := 1;
  FHeaderField := True;

  NextToken;
 end;

function THTTPParser.BufferRequest(Length: Integer): TStream;
const
  BufSize = 1000;
var
  Buffer: array[0..BufSize-1] of byte;
  Count: Integer;
  L, R, T, C: Integer;
  P1, P2: PAnsiChar;
begin

  // Get processed contents of parser buffer
  Result := TMemoryStream.Create;
  Count := FSourcePtr - FBuffer;
  Result.Write(Pointer(FBuffer)^, Count);

  // Find end of parser buffer
  if Length > 0 then
  begin
    P1 := FSourcePtr;
    P2 := P1;
    while (P2^ <> #0) do Inc(P2);

    while Length > 0 do
    begin
      if Length > BufSize then
        L := BufSize
      else
        L := Length;
      if P1 < P2 then
      begin
        // Read from parser buffer
        if L > P2 - P1 then
          R := P2 - P1
        else
          R := L;
        Move(P1^, Buffer, R);
        L := R;
        P1 := P1 + R;
      end
      else
      begin
        T := 0;
        R := L;
        repeat
          C := FStream.Read(Buffer[T], R-T);
          T := T + C;
        until (C = 0) or (T = R);
      end;
      Result.Write(Buffer, L);
      Length := Length - R;
    end;
  end;
  Result.Seek(Count, soBeginning);
  FStream := Result;
end;

destructor THTTPParser.Destroy;
begin
  if FBuffer <> nil then
  begin
    FStream.Seek(IntPtr(FTokenPtr) - IntPtr(FSourceEnd), soCurrent);
    FreeMem(FBuffer, ParseBufSize);
  end;
end;

procedure THTTPParser.CheckToken(T: AnsiChar);
begin
  if Token <> T then
    case T of
      toSymbol:
        Error(SIdentifierExpected);
      System.Classes.toString:
        Error(SStringExpected);
      toInteger, toFloat:
        Error(SNumberExpected);
    else
      ErrorFmt(SCharExpected, [T]);
    end;
end;

procedure THTTPParser.CheckTokenSymbol(const S: AnsiString);
begin
  if not TokenSymbolIs(S) then ErrorFmt(SSymbolExpected, [S]);
end;

function THTTPParser.CopyTo(Length: Integer): AnsiString;
var
  P: PAnsiChar;
  Temp: AnsiString;
begin
  Result := '';
  repeat
    P := FTokenPtr;
    while (Length > 0) and (P^ <> #0) do
    begin
      Inc(P);
      Dec(Length);
    end;
    SetString(Temp, FTokenPtr, P - FTokenPtr);
    Result := Result + Temp;
    if Length > 0 then ReadBuffer;
  until (Length = 0) or (Token = toEOF);
  FSourcePtr := P;
end;

function THTTPParser.CopyToEOL: AnsiString;
var
  P: PAnsiChar;
begin
  P := FTokenPtr;
  while not (P^ in [#13, #10, #0]) do Inc(P);
  SetString(Result, FTokenPtr, P - FTokenPtr);
  if P^ = #13 then Inc(P);
  FSourcePtr := P;
  if P^ <> #0 then
    NextToken
  else
    FToken := #0;
end;

function THTTPParser.CopyToEOF: AnsiString;
var
  P: PAnsiChar;
  Temp: AnsiString;
begin
  repeat
    P := FTokenPtr;
    while P^ <> #0 do Inc(P);
    FSourcePtr := P;
    ReadBuffer;
    SetString(Temp, FTokenPtr, P - FTokenPtr);
    Result := Result + Temp;
    NextToken;
  until Token = toEOF;
end;

procedure THTTPParser.Error(const Ident: string);
begin
  ErrorStr(Ident);
end;

procedure THTTPParser.ErrorFmt(const Ident: string; const Args: array of const);
begin
  ErrorStr(Format(Ident, Args));
end;

procedure THTTPParser.ErrorStr(const Message: string);
begin
  raise EParserError.CreateResFmt(@SParseError, [Message, FSourceLine]);
end;

procedure THTTPParser.HexToBinary(Stream: TStream);
var
  Count: Integer;
  Buffer: array[0..255] of AnsiChar;
begin
  SkipBlanks;
  while FSourcePtr^ <> '}' do
  begin
    Count := HexToBin(FSourcePtr, Buffer, SizeOf(Buffer));
    if Count = 0 then Error(SInvalidBinary);
    Stream.Write(Buffer, Count);
    Inc(FSourcePtr, Count * 2);
    SkipBlanks;
  end;
  NextToken;
end;

const
  CharValue: array[Byte] of Byte = (
    $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,
    $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,
    $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,
    $30,$31,$32,$33,$34,$35,$36,$37,$38,$39,$00,$00,$00,$00,$00,$00,
    $00,$41,$42,$43,$44,$45,$46,$47,$48,$49,$4A,$4B,$4C,$4D,$4E,$4F,
    $50,$51,$52,$53,$54,$55,$56,$57,$58,$59,$5A,$00,$00,$00,$00,$5F,
    $00,$41,$42,$43,$44,$45,$46,$47,$48,$49,$4A,$4B,$4C,$4D,$4E,$4F,
    $50,$51,$52,$53,$54,$55,$56,$57,$58,$59,$5A,$00,$00,$00,$00,$00,
    $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,
    $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,
    $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,
    $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,
    $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,
    $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,
    $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,
    $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00);

                                                                            
function GetHashCode(Ident: PAnsiChar; Length: Integer): Word;
begin
  Result := 0;
  while Length > 0 do
  begin
    // when SHL, exclude high-order bits to prevent range check error
    Result := ((Result and (MaxWord SHR 5)) SHL 5) or (Result SHR (16 - 5));
    PByte(@Result)[0] := PByte(@Result)[0] XOR CharValue[Byte(Ident^)];
    Dec(Length);
    Inc(Ident);
  end;
end;

type
  TSymbolEntry = record
    HashCode: Word;
    Symbol: PAnsiChar;
    Token: AnsiChar;
  end;

const
  SymbolTable: array[0..20] of TSymbolEntry = (
    (HashCode: hcGet; Symbol: 'GET'; Token: toGET),
    (HashCode: hcPut; Symbol: 'PUT'; Token: toPUT),
    (HashCode: hcDelete; Symbol: 'DELETE'; Token: toDELETE),
    (HashCode: hcPost; Symbol: 'POST'; Token: toPOST),
    (HashCode: hcCacheControl; Symbol: 'Cache-Control'; Token: toCacheControl),
    (HashCode: hcDate; Symbol: 'Date'; Token: toDate),
    (HashCode: hcFrom; Symbol: 'From'; Token: toFrom),
    (HashCode: hcHost; Symbol: 'Host'; Token: toHost),
    (HashCode: hcIfModified; Symbol: 'If-Modified-Since'; Token: toIfModified),
    (HashCode: hcAllow; Symbol: 'Allow'; Token: toAllow),
    (HashCode: hcUserAgent; Symbol: 'User-Agent'; Token: toUserAgent),
    (HashCode: hcAccept; Symbol: 'Accept'; Token: toAccept),
    (HashCode: hcContentEncoding; Symbol: 'Content-Encoding'; Token: toContentEncoding),
    (HashCode: hcContentVersion; Symbol: 'Content-Version'; Token: toContentVersion),
    (HashCode: hcContentType; Symbol: 'Content-Type'; Token: toContentType),
    (HashCode: hcContentLength; Symbol: 'Content-Length'; Token: toContentLength),
    (HashCode: hcReferer; Symbol: 'Referer'; Token: toReferer),
    (HashCode: hcConnection; Symbol: 'Connection'; Token: toConnection),
    (HashCode: hcCookie; Symbol: 'Cookie'; Token: toCookie),
    (HashCode: hcAuthorization; Symbol: 'Authorization'; Token: toAuthorization),
    (HashCode: hcContentDisposition; Symbol: 'Content-Disposition'; Token: toContentDisposition));

function LookupToken(Sym: PAnsiChar): AnsiChar;
var
  HCode: Word;
  I: Integer;
begin
  Result := toSymbol;
  HCode := GetHashCode(Sym, System.AnsiStrings.StrLen(Sym));
  for I := Low(SymbolTable) to High(SymbolTable) do
    with SymbolTable[I] do
      if HCode = HashCode then
        if System.AnsiStrings.StrIComp(Symbol, Sym) = 0 then
        begin
          Result := Token;
          Break;
        end;
end;

function THTTPParser.NextToken: AnsiChar;
var
  I: Integer;
  P, S: PAnsiChar;
  SaveChar: AnsiChar;
  TokenChars: set of AnsiChar;
begin
  SkipBlanks;
  P := FSourcePtr;
  FTokenPtr := P;
  if FHeaderField then
    TokenChars := ['A'..'Z', 'a'..'z', '0'..'9', '_', '-']
  else TokenChars := ['A'..'Z', 'a'..'z', '0'..'9', '_'];
  case P^ of
    'A'..'Z', 'a'..'z', '_':
      begin
        Inc(P);
        while P^ in TokenChars do Inc(P);
        SaveChar := P^;
        try
          P^ := #0;
          Result := LookupToken(FTokenPtr);
        finally
          P^ := SaveChar;
        end;
      end;
    #10:
      begin
        Inc(P);
        Inc(FSourceLine);
        Result := toEOL;
      end;
    '#', '''':
      begin
        S := P;
        while True do
          case P^ of
            '#':
              begin
                Inc(P);
                I := 0;
                while P^ in ['0'..'9'] do
                begin
                  I := I * 10 + (Ord(P^) - Ord('0'));
                  Inc(P);
                end;
                S^ := AnsiChar(I);
                Inc(S);
              end;
            '''':
              begin
                Inc(P);
                while True do
                begin
                  case P^ of
                    #0, #10, #13:
                      Error(SInvalidString);
                    '''':
                      begin
                        Inc(P);
                        if P^ <> '''' then Break;
                      end;
                  end;
                  S^ := P^;
                  Inc(S);
                  Inc(P);
                end;
              end;
          else
            Break;
          end;
        FStringPtr := S;
        Result := System.Classes.toString;
      end;
    '$':
      begin
        Inc(P);
        while P^ in ['0'..'9', 'A'..'F', 'a'..'f'] do Inc(P);
        Result := toInteger;
      end;
    '0'..'9':
      begin
        Inc(P);
        while P^ in ['0'..'9'] do Inc(P);
        Result := toInteger;
        while P^ in ['0'..'9', '.', 'e', 'E', '+'] do
        begin
          Inc(P);
          Result := toFloat;
        end;
      end;
  else
    Result := P^;
    if Result <> toEOF then Inc(P);
  end;
  FSourcePtr := P;
  FToken := Result;
end;

procedure THTTPParser.ReadBuffer;
var
  Count: Int64;
  P: PAnsiChar;
begin
  Inc(FOrigin, FSourcePtr - FBuffer);
  FSourceEnd[0] := FSaveChar;
  Count := FBufPtr - FSourcePtr;
  if Count <> 0 then Move(FSourcePtr[0], FBuffer[0], Count);
  FBufPtr := FBuffer + Count;
  Inc(FBufPtr, FStream.Read(FBufPtr[0], FBufEnd - FBufPtr));
  FSourcePtr := FBuffer;
  FSourceEnd := FBufPtr;
  if FSourceEnd = FBufEnd then
  begin
    FSourceEnd := LineStart(FBuffer, FSourceEnd - 1);
    if FSourceEnd = FBuffer then Error(SLineTooLong);
  end;
  P := FBuffer;
  while P < FSourceEnd do
  begin
    Inc(P);
  end;
  FSaveChar := FSourceEnd[0];
  FSourceEnd[0] := #0;
end;

procedure THTTPParser.SkipBlanks;
begin
  while True do
  begin
    case FSourcePtr^ of
      #0:
        begin
          ReadBuffer;
          if FSourcePtr^ = #0 then Exit;
          Continue;
        end;
      #10: Exit;
      #33..#255:
        Exit;
    end;
    Inc(FSourcePtr);
  end;
end;

function THTTPParser.SourcePos: Int64;
begin
  Result := FOrigin + (FTokenPtr - FBuffer);
end;

procedure THTTPParser.SkipEOL;
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

function THTTPParser.TokenFloat: Extended;
begin
  Result := StrToFloat(string(TokenString));
end;

function THTTPParser.TokenInt: Longint;
begin
  Result := StrToInt(string(TokenString));
end;

function THTTPParser.TokenString: AnsiString;
var
  L: Int64;
begin
  if FToken = HTTPParse.toString then
    L := FStringPtr - FTokenPtr else
    L := FSourcePtr - FTokenPtr;
  SetString(Result, FTokenPtr, L);
end;

function THTTPParser.TokenSymbolIs(const S: AnsiString): Boolean;
begin
  Result := (Token = toSymbol) and (System.AnsiStrings.AnsiStrComp(PAnsiChar(S), PAnsiChar(TokenString)) = 0);
end;

end.
