unit PDCMapParser;

interface

uses
  Classes, Contnrs, SysUtils, PDLexer, FileStream;

type
  TgtCIDRange = class
  private
    FCIDEnd: Integer;
    FCIDStart: Integer;
    FCode: Integer;
  public
    property CIDStart: Integer read FCIDStart write FCIDStart;
    property CIDEnd: Integer read FCIDEnd write FCIDEnd;
    property Code: Integer read FCode write FCode;
  end;

  TgtCIDCode = class
  private
    FCode: Integer;
    FCID: Integer;
  public
    property CID: Integer read FCID write FCID;
    property Code: Integer read FCode write FCode;
  end;

  TgtPSTokenizer = class(TObject)
  private
    FStream: TgtFileStream;
    FLexer: TgtPDLexer;
  public
    constructor Create(Stream: TStream);
    destructor Destroy; override;

    function GetNextToken(var Token: AnsiString): Boolean;
  end;

  TgtPDCMapParser = class(TObject)
  private
    FOrdering: AnsiString;
    FRegistry: AnsiString;
    FSupplement: AnsiString;
    FWMode: Integer;
    FCIDList: TObjectList;
    FCodeList: TObjectList;
    procedure AddCIDRanges(Tokenizer: TgtPSTokenizer; aCIDList: TObjectList);
    procedure AddCIDCodes(Tokenizer: TgtPSTokenizer; aCodeList: TObjectList);
    function GetCID(Index: Integer): Integer;
    function GetCode(Index: Integer): Integer;
  public
    constructor Create(Stream: TStream);
    destructor Destroy; override;
    property Registry: AnsiString read FRegistry;
    property Ordering: AnsiString read FOrdering;
    property Supplement: AnsiString read FSupplement;
    property WMode: Integer read FWMode;
    property CID[Index: Integer]: Integer read GetCID;
    property Code[Index: Integer]: Integer read GetCode;
  end;

implementation

uses
  PDBaseObject, PDInteger, PDReal, PDName, PDString, PDCommand;


{ TgtPSTokenizer }

constructor TgtPSTokenizer.Create(Stream: TStream);
begin
  //Don't free FStream. It is owned by Lexer object which will take care of
  //freeing FStream object
  FStream := TgtFileStream.Create(TFileStream(Stream), 0, 0, False);
  FStream.Reset;
  FLexer := TgtPDLexer.Create(FStream);
end;

destructor TgtPSTokenizer.Destroy;
begin
  FreeAndNil(FLexer);
  inherited;
end;

function TgtPSTokenizer.GetNextToken(var Token: AnsiString): Boolean;
var
  LObj: TgtPDBaseObject;
  LType: TgtPDObjTypes;
  LStr: AnsiString;
begin
  Result := True;
  LObj := FLexer.GetObject;

  try
    //We don't need '<<' as it will not be present in an external CMap file, Skip it
    while ((LObj.IsCommand('<<')) or (LObj.IsCommand('>>'))) do
      LObj := FLexer.GetObject;

    //If end of the file reaches or if there is any error occured, exit
    if LObj.IsEOF or LObj.IsError then
    begin
      Result := False;
      Exit;
    end;

    LType := LObj.GetType;
    case LType of
      otInteger:
        begin
          Token := IntToStr(TgtPDInteger(LObj).Value);
          Exit;
        end;
      otReal:
        begin
          Token := FloatToStr(TgtPDReal(LObj).Value);
          Exit;
        end;
      otString:
        begin
          LStr := TgtPDString(LObj).Value;
          if TgtPDString(LObj).IsHexString then
          begin
            if Length(LStr) < 4 then
              LStr := LStr + #0#0;
            Token := '$' + LStr;
          end
          else
            Token := LStr;
        end;
      otName:
        begin
          Token := TgtPDName(LObj).Value;
        end;
      otCommand:
        begin
          Token := TgtPDCommand(LObj).Value;
        end;
    end;
  finally
    FreeAndNil(LObj);
  end;
end;

{ TgtPDCMapParser }

procedure TgtPDCMapParser.AddCIDCodes(Tokenizer: TgtPSTokenizer;
  aCodeList: TObjectList);
var
  Token: AnsiString;
  C1, C2: Integer;
  LCIDCode: TgtCIDCode;
begin
  while Tokenizer.GetNextToken(Token) do
  begin
    if Token = 'endcidchar' then Break;
    if Token = 'endbfchar' then Break;

    C1 := StrToInt(Token);

    Tokenizer.GetNextToken(Token);
    C2 := StrToInt(Token);

    LCIDCode := TgtCIDCode.Create;
    LCIDCode.CID := C1;
    LCIDCode.Code := C2;
    aCodeList.Add(LCIDCode);
  end;
end;

procedure TgtPDCMapParser.AddCIDRanges(Tokenizer: TgtPSTokenizer;
  aCIDList: TObjectList);
var
  Token: AnsiString;
  C1, C2, C3: Integer;
  LCIDRange: TgtCIDRange;
begin
  while Tokenizer.GetNextToken(Token) do
  begin
    if Token = 'endcidrange' then Break;
    if Token = 'endbfrange' then Break;    

    C1 := StrToInt(Token);

    Tokenizer.GetNextToken(Token);
    C2 := StrToInt(Token);

    Tokenizer.GetNextToken(Token);
    if Pos('$', Token) > 0 then
    begin
      C3 := StrToInt(Token);

      LCIDRange := TgtCIDRange.Create;
      LCIDRange.CIDStart := C1;
      LCIDRange.CIDEnd := C2;
      LCIDRange.Code := C3;
      aCIDList.Add(LCIDRange);
    end
    else if Token = '[' then
    begin
      Tokenizer.GetNextToken(Token);
      while Token <> ']' do
      begin
        C3 := StrToInt(Token);

        LCIDRange := TgtCIDRange.Create;
        LCIDRange.CIDStart := C1;
        LCIDRange.CIDEnd := C1;
        LCIDRange.Code := C3;
        aCIDList.Add(LCIDRange);

        Inc(C1);

        Tokenizer.GetNextToken(Token);
      end;
    end
    else
    begin
      C3 := StrToInt(Token);
      LCIDRange := TgtCIDRange.Create;
      LCIDRange.CIDStart := C1;
      LCIDRange.CIDEnd := C2;
      LCIDRange.Code := C3;
      aCIDList.Add(LCIDRange);
    end;
  end;
end;

constructor TgtPDCMapParser.Create(Stream: TStream);
var
  Tokenizer: TgtPSTokenizer;
  Token: AnsiString;
begin
  Tokenizer := TgtPSTokenizer.Create(Stream);
  try
    if not Assigned(FCIDList) then  FCIDList := TObjectList.Create;
    if not Assigned(FCodeList) then FCodeList := TObjectList.Create;

    while Tokenizer.GetNextToken(Token) do
    begin
      if Token = 'Registry' then
        Tokenizer.GetNextToken(FRegistry)
      else if Token = 'Ordering' then
        Tokenizer.GetNextToken(FOrdering)
      else if Token = 'Supplement' then
        Tokenizer.GetNextToken(FSupplement)
      else if Token = 'WMode' then
      begin
        Tokenizer.GetNextToken(Token);
        FWMode := StrToInt(Token);
      end
      else if (Token = 'begincidrange') or (Token = 'beginbfrange') then
        AddCIDRanges(Tokenizer, FCIDList)
      else if (Token = 'begincidchar') or (Token = 'beginbfchar') then
        AddCIDCodes(Tokenizer, FCodeList)
      else if Token = 'endcmap' then Break;
    end;
  finally
    FreeAndNil(Tokenizer);
  end;
end;

destructor TgtPDCMapParser.Destroy;
begin
  if Assigned(FCIDList) then FreeAndNil(FCIDList);
  if Assigned(FCodeList) then FreeAndNil(FCodeList);
  inherited;
end;

function TgtPDCMapParser.GetCID(Index: Integer): Integer;
var
  I: Integer;
begin
  Result := -1;
  if Assigned(FCIDList) then
  begin
    for I := 0 to FCIDList.Count - 1 do
    begin
      if (Index >= TgtCIDRange(FCIDList.Items[I]).CIDStart) and
        (Index <= TgtCIDRange(FCIDList.Items[I]).CIDEnd) then
      begin
        Result := Index - TgtCIDRange(FCIDList.Items[I]).CIDStart
           + TgtCIDRange(FCIDList.Items[I]).Code;
      end;
    end;
  end;
end;

function TgtPDCMapParser.GetCode(Index: Integer): Integer;
var
  I: Integer;
begin
  Result := -1;
  if Assigned(FCodeList) then
  begin
    for I := 0 to FCodeList.Count - 1 do
    begin
      if (Index = TgtCIDCode(FCodeList.Items[I]).CID) then
        Result := TgtCIDCode(FCodeList.Items[I]).Code;
    end;
  end;
  if Result = -1 then
    Result := GetCID(Index);
end;

end.
