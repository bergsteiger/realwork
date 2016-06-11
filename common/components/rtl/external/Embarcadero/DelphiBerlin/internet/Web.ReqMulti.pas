{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{       Web server application components               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

// Parse a multipart form data request which may contain
// uploaded files.  use ReqMulti to register this parser.

unit Web.ReqMulti;

{$WARN IMPLICIT_STRING_CAST OFF}

interface

uses System.SysUtils, System.Classes, System.Masks, System.Generics.Collections, Web.HTTPApp,
  Web.ReqFiles, Web.HTTPParse;

type

{ TMultipartContentParser }

  TMultipartContentParser = class(TAbstractContentParser)
  private
    FContentFields: TStrings;
    FFiles: TWebRequestFiles;
    FContentBuffer: TBytes;
  protected
    function GetContentFields: TStrings; override;
    function GetFiles: TAbstractWebRequestFiles; override;

    procedure ExtractContentTypeFields(Strings: TStrings);
    procedure ParseMultiPartContent;
    procedure ParseMultiPart(APart: PByte; ASize: Integer);
    procedure BufferContent;
    procedure ParseMultipartHeaders(Parser: THTTPParser; AContent: PByte;
      AContentLength: Integer);
    procedure ExtractMultipartContentFields;
  public
    destructor Destroy; override;
    class function CanParse(AWebRequest: TWebRequest): Boolean; override;
  end;

implementation

uses Web.WebConst, Web.BrkrConst, Winapi.Windows;

const
  sMultiPartFormData = string('multipart/form-data');

function IsMultipartForm(ARequest: TWebRequest): Boolean;
begin
  Result := StrComp(PChar(Copy(ARequest.ContentType, 1, Length(sMultiPartFormData))),
    PChar(sMultiPartFormData)) = 0;
end;

{ TMultipartContentParser }

destructor TMultipartContentParser.Destroy;
begin
  FContentFields.Free;
  FFiles.Free;
  inherited Destroy;
end;

procedure TMultipartContentParser.BufferContent;
begin
  if (WebRequest.ContentLength > 0) and (Length(FContentBuffer) = 0) then
  begin
    WebRequest.ReadTotalContent;
    FContentBuffer := WebRequest.RawContent;
  end;
end;

procedure TMultipartContentParser.ExtractMultipartContentFields;
begin
  if WebRequest.ContentLength > 0 then
  begin
    BufferContent;
    ParseMultiPartContent;
  end;
end;

procedure TMultipartContentParser.ExtractContentTypeFields(Strings: TStrings);
begin
  ExtractHeaderFields([';'], [' '], WebRequest.ContentType, Strings, True, True);
end;

procedure TMultipartContentParser.ParseMultiPartContent;

  function IndexOfPattern(const ABoundary: TBytes; const ABuffer: TBytes; AOffset: Integer): Integer; overload;
  var
    I, LIterCnt, L, J: Integer;
  begin
    L := Length(ABoundary);
    { Calculate the number of possible iterations. Not valid if AOffset < 1. }
    LIterCnt := Length(ABuffer) - AOffset - L + 1;

    { Only continue if the number of iterations is positive or zero (there is space to check) }
    if (AOffset >= 0) and (LIterCnt >= 0) and (L > 0) then
    begin
      for I := 0 to LIterCnt do
      begin
        J := 0;
        while (J >= 0) and (J < L) do
        begin
          if ABuffer[I + J + AOffset] = ABoundary[J] then
            Inc(J)
          else
            J := -1;
        end;
        if J >= L then
          Exit(I + AOffset);
      end;
    end;

    Result := -1;
  end;

type
  TMultipartBoundaries = array of Integer;

  function FindBoundaries(const Boundary: TBytes): TMultipartBoundaries;
  var
    P1: Integer;
    Boundaries: TMultipartBoundaries;
    Count: Integer;
  begin
    Count := 0;
    P1 := IndexOfPattern(Boundary, FContentBuffer, 0);
    while P1 >= 0 do
    begin
      Inc(Count);
      SetLength(Boundaries, Count);
      Boundaries[Count-1] := P1;
      P1 := IndexOfPattern(Boundary, FContentBuffer, P1 + Length(Boundary));
    end;
    Result := Boundaries;
  end;
var
  ContentTypeFields: TStrings;
  Boundaries: TMultipartBoundaries;
  Temp: string;
  Boundary: TBytes;
  I: Integer;
  P: Integer;
begin
  SetLength(Boundaries, 0);
  ContentTypeFields := TStringList.Create;
  try
    ExtractContentTypeFields(ContentTypeFields);
    Temp := ContentTypeFields.Values['boundary'];
    if Temp <> '' then
    begin
      Temp := string('--') + Temp;
      Boundary := TEncoding.ASCII.GetBytes(Temp);
    end;
 finally
    ContentTypeFields.Free;
  end;
  if Length(Boundary) = 0 then
    Exit;
  Boundaries := FindBoundaries(Boundary);
  for I := Low(Boundaries) to High(Boundaries)-1 do
  begin
    P := Boundaries[I] + Length(Boundary) + 2;
    ParseMultiPart(@FContentBuffer[P],
      Boundaries[I+1] - P);
  end;
end;

procedure TMultipartContentParser.ParseMultipartHeaders(Parser: THTTPParser;
  AContent: PByte; AContentLength: Integer);
var
  PartContentType: string;
  PartFileName: string;
  PartName: string;
  ContentDisposition: string;

  procedure SkipLine;
  begin
    Parser.CopyToEOL;
    Parser.SkipEOL;
  end;

  function TrimLeft(const S: UTF8String): UTF8String;
  var
    I, L: Integer;
  begin
    L := Length(S);
    I := 1;
    while (I <= L) and (S[I] <= ' ') do Inc(I);
    Result := Copy(S, I, Maxint);
  end;

  procedure ParseContentType;
  begin
    with Parser do
    begin
      NextToken;
      if Token = ':' then NextToken;
      if PartContentType = '' then
        PartContentType := TrimLeft(CopyToEOL)
      else CopyToEOL;
      NextToken;
    end;
  end;

  procedure ExtractContentDispositionFields;
  var
    S: UTF8String;
    Strings: TStrings;
  begin
    S := ContentDisposition;
    Strings := TStringList.Create;
    try
      ExtractHeaderFields([';'], [' '], S, Strings, True, True);
      PartName := string(Strings.Values['name']);
      PartFileName := string(Strings.Values['filename']);
    finally
      Strings.Free;
    end;
  end;

  procedure ParseContentDisposition;
  begin
    with Parser do
    begin
      NextToken;
      if Token = ':' then NextToken;
      if ContentDisposition = '' then
        ContentDisposition := TrimLeft(CopyToEOL)
      else CopyToEOL;
      NextToken;
      ExtractContentDispositionFields;
    end;
  end;

var
  Temp: UTF8String;
begin
  while Parser.Token <> toEOF do with Parser do
  begin
    case Token of
      toContentType: ParseContentType;
      toContentDisposition: ParseContentDisposition;
      toEOL: Break; // At content
    else
      SkipLine;
    end;
  end;
  if PartName <> '' then
  begin
    if PartFileName <> '' then
    begin
      // Note.  Filename is not added as content field
      // FContentFields.Add(PartName + '=' + PartFileName);
      if FFiles = nil then
        FFiles := TWebRequestFiles.Create;
      FFiles.Add(PartName, PartFileName, PartContentType,
        AContent, AContentLength-2); // Exclude the cr/lf pair
    end
    else if PartContentType = '' then
    begin
      Temp := '';
      if AContentLength > 0 then
      begin
        Assert(AContentLength >= 2);
        Temp := TEncoding.UTF8.GetString(BytesOf(AContent, AContentLength-2), 0, AContentLength-2);
      end;
      FContentFields.Add(string(PartName + Char('=') + Temp));
    end
  end;
end;


procedure TMultipartContentParser.ParseMultiPart(APart: PByte; ASize: Integer);

  function StrPos(const Str1, Str2: PUTF8Char): PUTF8Char;
  var
    MatchStart, LStr1, LStr2: PUTF8Char;
  begin
    Result := nil;
    if (Str1^ = #0) or (Str2^ = #0) then
      Exit;

    MatchStart := Str1;
    while MatchStart^<> #0 do
    begin
      if MatchStart^ = Str2^ then
      begin
        LStr1 := MatchStart+1;
        LStr2 := Str2+1;
        while True do
        begin
          if LStr2^ = #0 then
            Exit(MatchStart);
          if (LStr1^ <> LStr2^) or (LStr1^ = #0) then
            Break;
          Inc(LStr1);
          Inc(LStr2);
        end;
      end;
      Inc(MatchStart);
    end;
  end;

var
  PEndHeader: PUTF8Char;
  S: TStream;
  HeaderLen: Integer;
  Parser: THTTPParser;
begin
                                  
  PEndHeader := StrPos(PUTF8Char(APart), #13#10#13#10);
  if PEndHeader <> nil then
  begin
    HeaderLen := PEndHeader-APart+4;
    S := TWebRequestFileStream.Create(APart, HeaderLen);
    try
      Parser := THTTPParser.Create(S);
      try
        ParseMultiPartHeaders(Parser, APart + HeaderLen, ASize - HeaderLen);
      finally
        Parser.Free;
      end;
    finally
      S.Free;
    end;
  end;
end;

function TMultipartContentParser.GetContentFields: TStrings;
begin
  if FContentFields = nil then
  begin
    FContentFields := TStringList.Create;
    if IsMultiPartForm(WebRequest) then
      ExtractMultipartContentFields
    else
      WebRequest.ExtractContentFields(FContentFields);
  end;
  Result := FContentFields;
end;

function TMultipartContentParser.GetFiles: TAbstractWebRequestFiles;
begin
  GetContentFields;
  if FFiles = nil then
    FFiles := TWebRequestFiles.Create;
  Result := FFiles;
end;

class function TMultipartContentParser.CanParse(
  AWebRequest: TWebRequest): Boolean;
begin
  Result := IsMultipartForm(AWebRequest);
end;

initialization
  RegisterContentParser(TMultipartContentParser);
end.
