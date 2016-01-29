{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Data.DBXSqlScanner;

interface

uses
  Data.DBXPlatform;

type
  TDBXSqlScanner = class
  public
    constructor Create(const QuoteChar: string; const QuotePrefix: string; const QuoteSuffix: string);
    destructor Destroy; override;
    procedure RegisterId(const Id: string; const Token: Integer);
    procedure Init(const Query: string); overload;
    procedure Init(const Query: string; const StartIndex: Integer); overload;
    function LookAtNextToken: Integer;
    function NextToken: Integer;
    function IsKeyword(const Keyword: string): Boolean;
  protected
    function GetId: string;
  private
    class function ToQuoteChar(const QuoteString: string): Char; static;
    procedure ResetId;
    function ScanNumber: Integer;
    function QuotedToken: Integer;
    function PrefixQuotedToken: Integer;
    function UnquotedToken: Integer;
    function ScanSymbol: Integer;
    procedure SkipToEndOfLine;
  private
    FQuotePrefix: string;
    FQuoteSuffix: string;
    FQuote: string;
    FQuotePrefixChar: Char;
    FQuoteSuffixChar: Char;
    FQuoteChar: Char;
    FKeywords: TDBXObjectStore;
    FQuery: string;
    FQueryLength: Integer;
    FIndex: Integer;
    FStartOfId: Integer;
    FEndOfId: Integer;
    FId: string;
    FWasId: Boolean;
    FWasQuoted: Boolean;
    FSymbol: Char;
  public
    property Id: string read GetId;
    property Quoted: Boolean read FWasQuoted;
    property Symbol: Char read FSymbol;
    property SqlQuery: string read FQuery;
    property NextIndex: Integer read FIndex;
  public
    const TokenEos = -1;
    const TokenId = -2;
    const TokenComma = -3;
    const TokenPeriod = -4;
    const TokenSemicolon = -5;
    const TokenOpenParen = -6;
    const TokenCloseParen = -7;
    const TokenNumber = -8;
    const TokenSymbol = -9;
    const TokenError = -10;
  end;

implementation

uses
  Data.DBXMetaDataUtil,
  System.SysUtils,
  Data.DBXCommonResStrs;

constructor TDBXSqlScanner.Create(const QuoteChar: string; const QuotePrefix: string; const QuoteSuffix: string);
begin
  inherited Create;
  FQuotePrefix := QuotePrefix;
  FQuoteSuffix := QuoteSuffix;
  FQuote := QuoteChar;
  FQuotePrefixChar := ToQuoteChar(QuotePrefix);
  FQuoteSuffixChar := ToQuoteChar(QuoteSuffix);
  FQuoteChar := ToQuoteChar(QuoteChar);
end;

destructor TDBXSqlScanner.Destroy;
begin
  FreeAndNil(FKeywords);
  inherited Destroy;
end;

procedure TDBXSqlScanner.RegisterId(const Id: string; const Token: Integer);
begin
  if FKeywords = nil then
    FKeywords := TDBXObjectStore.Create(True);
  FKeywords[LowerCase(Id)] := TDBXInt32Object.Create(Token);
end;

procedure TDBXSqlScanner.Init(const Query: string);
begin
  Init(Query, 0);
end;

procedure TDBXSqlScanner.Init(const Query: string; const StartIndex: Integer);
begin
  FQuery := Query;
  FQueryLength := Query.Length;
  FIndex := StartIndex;
  ResetId;
end;

class function TDBXSqlScanner.ToQuoteChar(const QuoteString: string): Char;
begin
  if QuoteString.IsEmpty or (QuoteString.Length = 0) then
    Result := #$0
  else if QuoteString.Length > 1 then
    raise Exception.Create(SIllegalArgument)
  else 
    Result := QuoteString.Chars[0];
end;

function TDBXSqlScanner.LookAtNextToken: Integer;
var
  Save: Integer;
  Token: Integer;
begin
  Save := FIndex;
  Token := NextToken;
  FIndex := Save;
  Result := Token;
end;

function TDBXSqlScanner.NextToken: Integer;
var
  Ch: Char;
begin
  ResetId;
  while FIndex < FQueryLength do
  begin
    Ch := FQuery.Chars[IncrAfter(FIndex)];
    case Ch of
      ' ',
      #$9,
      #$d,
      #$a:;
      '(':
        begin
          FSymbol := Ch;
          Exit(TokenOpenParen);
        end;
      ')':
        begin
          FSymbol := Ch;
          Exit(TokenCloseParen);
        end;
      ',':
        begin
          FSymbol := Ch;
          Exit(TokenComma);
        end;
      '.':
        begin
          FSymbol := Ch;
          Exit(TokenPeriod);
        end;
      ';':
        begin
          FSymbol := Ch;
          Exit(TokenSemicolon);
        end;
      '0',
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9':
        Exit(ScanNumber);
      else
        if Ch = FQuoteChar then
          Exit(QuotedToken)
        else if Ch = FQuotePrefixChar then
          Exit(PrefixQuotedToken)
        else if IsIdentifierStart(Ch) then
          Exit(UnquotedToken)
        else if (Ch = '-') and (FIndex < FQueryLength) and (FQuery.Chars[FIndex] = '-') then
          SkipToEndOfLine
        else 
          Exit(ScanSymbol);
    end;
  end;
  Result := TokenEos;
end;

function TDBXSqlScanner.GetId: string;
begin
  if FId.IsEmpty then
  begin
    FId := FQuery.Substring(FStartOfId, FEndOfId - FStartOfId);
    if FWasQuoted then
      FId := TDBXMetaDataUtil.UnquotedIdentifier(FId, FQuote, FQuotePrefix, FQuoteSuffix);
  end;
  Result := FId;
end;

function TDBXSqlScanner.IsKeyword(const Keyword: string): Boolean;
begin
  Result := FWasId and (Keyword = Id);
end;

procedure TDBXSqlScanner.ResetId;
begin
  FId := NullString;
  FStartOfId := 0;
  FEndOfId := 0;
  FWasId := False;
  FWasQuoted := False;
  FSymbol := #$0;
end;

function TDBXSqlScanner.ScanNumber: Integer;
var
  Ch: Char;
begin
  FStartOfId := FIndex - 1;
  while FIndex < FQueryLength do
  begin
    Ch := FQuery.Chars[IncrAfter(FIndex)];
    case Ch of
      '.',
      '0',
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9':;
      else
        begin
          Dec(FIndex);
          FEndOfId := FIndex;
          Exit(TokenNumber);
        end;
    end;
  end;
  FEndOfId := FIndex - 1;
  Result := TokenNumber;
end;

function TDBXSqlScanner.QuotedToken: Integer;
var
  Ch: Char;
begin
  FStartOfId := FIndex - 1;
  while FIndex < FQueryLength do
  begin
    Ch := FQuery.Chars[IncrAfter(FIndex)];
    if Ch = FQuoteChar then
    begin
      if (FIndex = FQueryLength) or (FQuery.Chars[FIndex] <> FQuoteChar) then
      begin
        FEndOfId := FIndex;
        FWasId := True;
        FWasQuoted := True;
        Exit(TokenId);
      end;
      IncrAfter(FIndex);
    end;
  end;
  Result := TokenError;
end;

function TDBXSqlScanner.PrefixQuotedToken: Integer;
var
  Ch: Char;
begin
  FStartOfId := FIndex - 1;
  while FIndex < FQueryLength do
  begin
    Ch := FQuery.Chars[IncrAfter(FIndex)];
    if Ch = FQuoteSuffixChar then
    begin
      FEndOfId := FIndex;
      FWasId := True;
      FWasQuoted := True;
      Exit(TokenId);
    end;
  end;
  Result := TokenError;
end;

function TDBXSqlScanner.UnquotedToken: Integer;
var
  Token: Integer;
  Ch: Char;
  Keyword: TDBXInt32Object;
begin
  Token := TokenId;
  FStartOfId := FIndex - 1;
  while FIndex < FQueryLength do
  begin
    Ch := FQuery.Chars[IncrAfter(FIndex)];
    if not IsIdentifierPart(Ch) then
    begin
      Dec(FIndex);
      break;
    end;
  end;
  FEndOfId := FIndex;
  FWasId := True;
  if FKeywords <> nil then
  begin
    Keyword := TDBXInt32Object(FKeywords[LowerCase(Id)]);
    if Keyword <> nil then
      Token := Keyword.IntValue;
  end;
  Result := Token;
end;

function TDBXSqlScanner.ScanSymbol: Integer;
begin
  FSymbol := FQuery.Chars[FIndex - 1];
  Result := TokenSymbol;
end;

procedure TDBXSqlScanner.SkipToEndOfLine;
var
  Ch: Char;
begin
  Ch := '-';
  while ((Ch <> #$d) and (Ch <> #$a)) and (FIndex < FQueryLength) do
    Ch := FQuery.Chars[IncrAfter(FIndex)];
end;

end.
