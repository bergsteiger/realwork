{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{       Web server application components               }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

// TUTF8ContentParser is a WebRequest content parser that parses UTF-8 requests.
// TUTF8ContentParser class automatically replace the default content parser when this unit (UTF8ContentParser)
// is used in a web application.  You should only use UTF8ContentParser in web applications that generate UTF-8
// responses.
//
// To generated UTF-8 encoded responses, set Response.ContentType as follows before setting Response.Content.
//    Response.ContentType := 'text/html; charset=UTF-8';
//
// Note that, if your application uses the ReqMulti unit to parse multipart content, ReqMulti must appear in the application
// uses list after UTF8ContentParser.


{$HPPEMIT '#pragma link "UTF8ContentParser"'}    {Do not Localize}
unit UTF8ContentParser;

interface

uses System.SysUtils, System.Classes, System.Masks, System.Contnrs, Web.HTTPApp,
  ReqFiles, HTTPParse;

type

{ TUTF8ContentParser }

  TUTF8ContentParser = class(TContentParser)
  private
    FContentFields: TStrings;
  public
    destructor Destroy; override;
    function GetContentFields: TStrings; override;
    class function CanParse(AWebRequest: TWebRequest): Boolean; override;
  end;

implementation

uses Web.WebConst, WebComp, Web.BrkrConst, Winapi.Windows;


{ TUTF8ContentParser }

class function TUTF8ContentParser.CanParse(AWebRequest: TWebRequest): Boolean;
begin
  Result := True;
end;

destructor TUTF8ContentParser.Destroy;
begin
  FContentFields.Free;
  inherited Destroy;
end;

procedure ExtractHeaderFields(Separators, WhiteSpace: TSysCharSet; Content: PAnsiChar;
  Strings: TStrings; Decode: Boolean; Encoding: TEncoding; StripQuotes: Boolean = False); forward;

function TUTF8ContentParser.GetContentFields: TStrings;
begin
  if FContentFields = nil then
  begin
    FContentFields := TStringList.Create;
    if WebRequest.ContentLength > 0 then
    begin
      ExtractHeaderFields(['&'], [], PAnsiChar(WebRequest.RawContent), FContentFields, True, TEncoding.UTF8);
    end;
  end;
  Result := FContentFields;
end;

// Version of HTTP.ExtractHeaderFields that supports encoding parameter
procedure ExtractHeaderFields(Separators, WhiteSpace: TSysCharSet; Content: PAnsiChar;
  Strings: TStrings; Decode: Boolean; Encoding: TEncoding; StripQuotes: Boolean = False);
var
  Head, Tail: PAnsiChar;
  EOS, InQuote, LeadQuote: Boolean;
  QuoteChar: AnsiChar;
  ExtractedField: AnsiString;
  WhiteSpaceWithCRLF: TSysCharSet;
  SeparatorsWithCRLF: TSysCharSet;

  procedure AddString(const S: AnsiString);
  var
    LBytes: TBytes;
    LString: string;
  begin
    LBytes := BytesOf(S);
    LString := Encoding.GetString(LBytes);
    Strings.Add(LString);
  end;

  function DoStripQuotes(const S: AnsiString): AnsiString;
  var
    I: Integer;
    InStripQuote: Boolean;
    StripQuoteChar: AnsiChar;
  begin
    Result := S;
    InStripQuote := False;
    StripQuoteChar := #0;
    if StripQuotes then
      for I := Length(Result) downto 1 do
        if CharInSet(Result[I], ['''', '"']) then
          if InStripQuote and (StripQuoteChar = Result[I]) then
          begin
          Delete(Result, I, 1);
            InStripQuote := False;
          end
          else if not InStripQuote then
          begin
            StripQuoteChar := Result[I];
            InStripQuote := True;
            Delete(Result, I, 1);
          end
  end;

begin
  if (Content = nil) or (Content^ = #0) then Exit;
  WhiteSpaceWithCRLF := WhiteSpace + [#13, #10];
  SeparatorsWithCRLF := Separators + [#0, #13, #10, '"'];
  Tail := Content;
  QuoteChar := #0;
  repeat
    while CharInSet(Tail^, WhiteSpaceWithCRLF) do Inc(Tail);
    Head := Tail;
    InQuote := False;
    LeadQuote := False;
    while True do
    begin
     while (InQuote and not CharInSet(Tail^, [#0, '"'])) or
        not CharInSet(Tail^, SeparatorsWithCRLF) do Inc(Tail);
      if Tail^ = '"' then
      begin
        if (QuoteChar <> #0) and (QuoteChar = Tail^) then
          QuoteChar := #0
        else
        begin
          LeadQuote := Head = Tail;
          QuoteChar := Tail^;
          if LeadQuote then Inc(Head);
        end;
        InQuote := QuoteChar <> #0;
        if InQuote then
          Inc(Tail)
        else Break;
      end else Break;
    end;
    if not LeadQuote and (Tail^ <> #0) and (Tail^ = '"') then
      Inc(Tail);
    EOS := Tail^ = #0;
    if Head^ <> #0 then
    begin
      SetString(ExtractedField, Head, Tail-Head);
      if Decode then
        AddString(HTTPDecode(AnsiString(DoStripQuotes(ExtractedField))))
      else AddString(DoStripQuotes(ExtractedField));
    end;
    Inc(Tail);
  until EOS;
end;

initialization
  RegisterContentParser(TUTF8ContentParser);
end.
