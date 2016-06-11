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

unit Web.HTTPProd;     

{$WARN SYMBOL_DEPRECATED OFF}
{$WARN IMPLICIT_STRING_CAST OFF}

interface

uses System.SysUtils, System.Classes, Web.HTTPApp, System.Masks;

/// <summary>Qualify a relative path using the location of the executable</summary>
function QualifyFileName(const AFileName: string): string;

type

{ THTMLTagAttributes }

  THTMLAlign = (haDefault, haLeft, haRight, haCenter);
  THTMLVAlign = (haVDefault, haTop, haMiddle, haBottom, haBaseline);
  THTMLBgColor = type string;

  IDesignerFileManager = interface
  ['{1DF271BF-F2EC-11D4-A559-00C04F6BB853}']
    function QualifyFileName(const AFileName: string): string;
    function GetStream(const AFileName: string; var AOwned: Boolean): TStream;
  end;

  THTMLTagAttributes = class(TPersistent)
  private
    FProducer: TCustomContentProducer;
    FCustom: string;
    FOnChange: TNotifyEvent;
    procedure SetCustom(const Value: string);
  protected
    procedure Changed;
  public
    constructor Create(Producer: TCustomContentProducer);
    procedure RestoreDefaults; virtual;
    property Producer: TCustomContentProducer read FProducer;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  published
    property Custom: string read FCustom write SetCustom;
  end;

  THTMLTableAttributes = class(THTMLTagAttributes)
  private
    FAlign: THTMLAlign;
    FBorder: Integer;
    FBgColor: THTMLBgColor;
    FCellSpacing: Integer;
    FCellPadding: Integer;
    FWidth: Integer;
    procedure SetAlign(Value: THTMLAlign);
    procedure SetBorder(Value: Integer);
    procedure SetBGColor(Value: THTMLBgColor);
    procedure SetCellSpacing(Value: Integer);
    procedure SetCellPadding(Value: Integer);
    procedure SetWidth(Value: Integer);
  protected
    procedure AssignTo(Dest: TPersistent); override;
  public
    constructor Create(Producer: TCustomContentProducer);
    procedure RestoreDefaults; override;
  published
    property Align: THTMLAlign read FAlign write SetAlign default haDefault;
    property BgColor: THTMLBgColor read FBgColor write SetBgColor;
    property Border: Integer read FBorder write SetBorder default -1;
    property CellSpacing: Integer read FCellSpacing write SetCellSpacing default -1;
    property CellPadding: Integer read FCellPadding write SetCellPAdding default -1;
    property Width: Integer read FWidth write SetWidth default 100;
  end;

  THTMLTableElementAttributes = class(THTMLTagAttributes)
  private
    FAlign: THTMLAlign;
    FBgColor: THTMLBgColor;
    FVAlign: THTMLVAlign;
    procedure SetAlign(Value: THTMLAlign);
    procedure SetBGColor(Value: THTMLBgColor);
    procedure SetVAlign(Value: THTMLVAlign);
  protected
    procedure AssignTo(Dest: TPersistent); override;
  public  
    procedure RestoreDefaults; override;
  published
    property Align: THTMLAlign read FAlign write SetAlign default haDefault;
    property BgColor: THTMLBgColor read FBgColor write SetBgColor;
    property VAlign: THTMLVAlign read FVAlign write SetVAlign default haVDefault;
  end;

  THTMLTableHeaderAttributes = class(THTMLTableElementAttributes)
  private
    FCaption: string;
    procedure SetCaption(Value: string);
  protected
    procedure AssignTo(Dest: TPersistent); override;
  public
    procedure RestoreDefaults; override;
  published
    property Caption: string read FCaption write SetCaption;
  end;

  THTMLTableRowAttributes = class(THTMLTableElementAttributes);
  THTMLTableCellAttributes = class(THTMLTableElementAttributes);

  TTag = (tgCustom, tgLink, tgImage, tgTable, tgImageMap, tgObject, tgEmbed);

  THTMLTagEvent = procedure (Sender: TObject; Tag: TTag; const TagString: string;
    TagParams: TStrings; var ReplaceText: string) of object;

  IGetProducerTemplate = interface
  ['{44AA3FC1-FEB9-11D4-A566-00C04F6BB853}']
    function GetProducerTemplateStream(out AOwned: Boolean): TStream;
    function GetProducerTemplateFileName: string;
  end;

{ TBasePageProducer }

  TWebModuleContext = TObject;

  TBasePageProducer = class(TCustomContentProducer, IGetProducerTemplate)
  private
    FOnHTMLTag: THTMLTagEvent;
    FScriptEngine: string;
    FStripParamQuotes: Boolean;
    function GetWebModuleContext: TWebModuleContext; deprecated;
    procedure ReadScriptEngine(AReader: TReader);
  protected
    function GetScriptEngine: string; virtual; deprecated;
    function UseScriptEngine: Boolean; virtual; deprecated;
    function GetTagID(const TagString: string): TTag;
    function HandleTag(const TagString: string;
      TagParams: TStrings): string; virtual;
    function ImplHandleTag(const TagString: string;
      TagParams: TStrings): string;
    procedure DoTagEvent(Tag: TTag; const TagString: string; TagParams: TStrings;
      var ReplaceText: string); dynamic;
    function HandleScriptTag(const TagString: string;
      TagParams: TStrings; var ReplaceString: string): Boolean; virtual; deprecated;
    function ServerScriptFromStream(Stream: TStream): string; deprecated;
    function GetProducerTemplateStream(out AOwned: Boolean): TStream;
    function GetProducerTemplateFileName: string;
    function GetTemplateFileName: string; virtual;
    function GetTemplateStream(out AOwned: Boolean): TStream; virtual;
    property OnHTMLTag: THTMLTagEvent read FOnHTMLTag write FOnHTMLTag;
    procedure DefineProperties(Filer: TFiler);  override;
  public
    constructor Create(AOwner: TComponent); override;
    function Content: string; override;
    function ContentFromStream(Stream: TStream): string; override;
    function ContentFromString(const S: string): string; override;
    property WebModuleContext: TWebModuleContext read GetWebModuleContext;
    property StripParamQuotes: Boolean read FStripParamQuotes write FStripParamQuotes default True;
    property ScriptEngine: string read GetScriptEngine;
  end;

  { TCustomPageProducer }

  TCustomPageProducer = class(TBasePageProducer)
  private
    FHTMLFile: TFileName;
    FHTMLDoc: TStrings;
    procedure SetHTMLFile(const Value: TFileName);
    procedure SetHTMLDoc(Value: TStrings);
  protected
    function GetTemplateStream(out AOwned: Boolean): TStream; override;
    function HandleTag(const TagString: string;
      TagParams: TStrings): string; override;
    function GetTemplateFileName: string; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property HTMLDoc: TStrings read FHTMLDoc write SetHTMLDoc;
    property HTMLFile: TFileName read FHTMLFile write SetHTMLFile;
  end;

{ TPageProducer }

  TPageProducer = class(TCustomPageProducer)
  published
    property HTMLDoc;
    property HTMLFile;
    property StripParamQuotes;
    property OnHTMLTag;
  end;

  THandleTagProc = function(const TagString: string; TagParams: TStrings): string of object;
  THandledTagProc = function(const TagString: string; TagParams: TStrings; var ReplaceString: string): Boolean of object;


  function GetTagID(const TagString: string): TTag;
  function ContentFromStream(AStream: TStream;
    AStripParamQuotes: Boolean; AHandleTag: THandleTagProc; AHandledTag: THandledTagProc): string;
  function ContentFromString(const AValue: string;
    AStripParamQuotes: Boolean; AHandleTag: THandleTagProc; AHandledTag: THandledTagProc): string;
  function GetEncodingOfStream(AStream: TStream; out ASignatureSize: Integer): TEncoding;

const
  HTMLAlign: array[THTMLAlign] of string =
    ('',
     ' Align="left"',
     ' Align="right"',
     ' Align="center"');
  HTMLVAlign: array[THTMLVAlign] of string =
    ('',
     ' VAlign="top"',
     ' VAlign="middle"',
     ' VAlign="bottom"',
     ' VAlign="baseline"');
var
  DesignerFileManager: IDesignerFileManager = nil;

implementation

uses
  Web.CopyPrsr, Web.WebConst;

{ THTMLTagAttributes }

constructor THTMLTagAttributes.Create(Producer: TCustomContentProducer);
begin
  inherited Create;
  FProducer := Producer;
end;

procedure THTMLTagAttributes.Changed;
begin
  if Assigned(FOnChange) then FOnChange(Self);
end;

procedure THTMLTagAttributes.RestoreDefaults;
begin
  FCustom := '';
  Changed;
end;

procedure THTMLTagAttributes.SetCustom(const Value: string);
begin
  if Value <> FCustom then
  begin
    FCustom := Value;
    Changed;
  end;
end;

{ THTMLTableAttributes }

constructor THTMLTableAttributes.Create(Producer: TCustomContentProducer);
begin
  inherited Create(Producer);
  FWidth := 100;
  FBorder := -1;
  FCellPadding := -1;
  FCellSpacing := -1;
end;

procedure THTMLTableAttributes.AssignTo(Dest: TPersistent);
begin
  if Dest is THTMLTableAttributes then
    with THTMLTableAttributes(Dest) do
    begin
      FWidth := Self.FWidth;
      FAlign := Self.FAlign;
      FBorder := Self.FBorder;
      FBgColor := Self.FBgColor;
      FCellSpacing := Self.FCellSpacing;
      FCellPadding := Self.FCellPadding;
      Changed;
    end else inherited AssignTo(Dest);
end;

procedure THTMLTableAttributes.RestoreDefaults;
begin
  FCustom := '';
  FAlign := haDefault;
  FWidth := 100;
  FBorder := -1;
  FCellPadding := -1;
  FCellSpacing := -1;
  Changed;
end;

procedure THTMLTableAttributes.SetAlign(Value: THTMLAlign);
begin
  if Value <> FAlign then
  begin
    FAlign := Value;
    Changed;
  end;
end;

procedure THTMLTableAttributes.SetBorder(Value: Integer);
begin
  if Value <> FBorder then
  begin
    FBorder := Value;
    Changed;
  end;
end;

procedure THTMLTableAttributes.SetBGColor(Value: THTMLBgColor);
begin
  if Value <> FBgColor then
  begin
    FBgColor := Value;
    Changed;
  end;
end;

procedure THTMLTableAttributes.SetCellSpacing(Value: Integer);
begin
  if Value <> FCellSpacing then
  begin
    FCellSpacing := Value;
    Changed;
  end;
end;

procedure THTMLTableAttributes.SetCellPadding(Value: Integer);
begin
  if Value <> FCellPadding then
  begin
    FCellPadding := Value;
    Changed;
  end;
end;

procedure THTMLTableAttributes.SetWidth(Value: Integer);
begin
  if Value <> FWidth then
  begin
    FWidth := Value;
    Changed;
  end;
end;

{ THTMLTableElementAttributes }

procedure THTMLTableElementAttributes.AssignTo(Dest: TPersistent);
begin
  if Dest is THTMLTableElementAttributes then
    with THTMLTableElementAttributes(Dest) do
    begin
      FAlign := Self.FAlign;
      FVAlign := Self.FVAlign;
      FBgColor := Self.FBgColor;
      Changed;
    end else inherited AssignTo(Dest);
end;

procedure THTMLTableElementAttributes.RestoreDefaults;
begin
  FCustom := '';
  FAlign := haDefault;
  FVAlign := haVDefault;
  FBgColor := '';
  Changed;
end;

procedure THTMLTableElementAttributes.SetAlign(Value: THTMLAlign);
begin
  if Value <> FAlign then
  begin
    FAlign := Value;
    Changed;
  end;
end;

procedure THTMLTableElementAttributes.SetBGColor(Value: THTMLBgColor);
begin
  if Value <> FBgColor then
  begin
    FBgColor := Value;
    Changed;
  end;
end;

procedure THTMLTableElementAttributes.SetVAlign(Value: THTMLVAlign);
begin
  if Value <> FVAlign then
  begin
    FVAlign := Value;
    Changed;
  end;
end;

{ THTMLTableHeaderAttributes }

procedure THTMLTableHeaderAttributes.AssignTo(Dest: TPersistent);
begin
  if Dest is THTMLTableHeaderAttributes then
    with THTMLTableHeaderAttributes(Dest) do
    begin
      FAlign := Self.FAlign;
      FVAlign := Self.FVAlign;
      FBgColor := Self.FBgColor;
      FCaption := Self.FCaption;
      Changed;
    end else inherited AssignTo(Dest);
end;

procedure THTMLTableHeaderAttributes.RestoreDefaults;
begin
  FCustom := '';
  FAlign := haDefault;
  FVAlign := haVDefault;
  FBgColor := '';
  FCaption := '';
  Changed;
end;

procedure THTMLTableHeaderAttributes.SetCaption(Value: string);
begin
  if CompareStr(Value, FCaption) <> 0 then
  begin
    FCaption := Value;
    Changed;
  end;
end;

{ TBasePageProducer }

constructor TBasePageProducer.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FStripParamQuotes := True;
  RPR;
end;

function TBasePageProducer.ContentFromStream(Stream: TStream): string;
begin
    Result := Web.HttpProd.ContentFromStream(Stream,
       StripParamQuotes, HandleTag, nil);
end;

function TBasePageProducer.ServerScriptFromStream(Stream: TStream): string;
begin
  Result := Web.HttpProd.ContentFromStream(Stream,
       StripParamQuotes, nil, nil);
end;

function TBasePageProducer.ContentFromString(const S: string): string;
var
  InStream: TStream;
begin
  InStream := TStringStream.Create(S, TEncoding.UTF8);
  try
    Result := ContentFromStream(InStream);
  finally
    InStream.Free;
  end;
end;

function TBasePageProducer.HandleTag(const TagString: string; TagParams: TStrings): string;
begin
  Result := Format('<#%s>', [TagString]);
end;

function TBasePageProducer.HandleScriptTag(const TagString: string; TagParams: TStrings;
  var ReplaceString: string): Boolean;
begin
  Result := False;
end;

function TBasePageProducer.GetTagID(const TagString: string): TTag;
begin
  Result := Web.HTTPProd.GetTagID(TagString);
end;

var
  TagSymbols: array[TTag] of string =
    ('', 'LINK', 'IMAGE', 'TABLE', 'IMAGEMAP', 'OBJECT', 'EMBED');
function GetTagID(const TagString: string): TTag;
begin
  Result := High(TTag);
  while Result >= Low(TTag) do
  begin
    if (Result = tgCustom) or (CompareText(TagSymbols[Result], TagString) = 0) then Break;
    Dec(Result);
  end;
end;

function TBasePageProducer.Content: string;
var
  InStream: TStream;
  Owned: Boolean;
begin
  Result := '';
  InStream := GetTemplateStream(Owned);
  try
    if InStream <> nil then
      Result := ContentFromStream(InStream);
  finally
    if Owned then
      InStream.Free;
  end;
end;

procedure TBasePageProducer.DoTagEvent(Tag: TTag; const TagString: string;
  TagParams: TStrings; var ReplaceText: string);
begin
  if Assigned(FOnHTMLTag) then
    FOnHTMLTag(Self, Tag, TagString, TagParams, ReplaceText);
end;

function TBasePageProducer.ImplHandleTag(const TagString: string;
  TagParams: TStrings): string;
var
  Tag: TTag;
begin
  Tag := GetTagID(TagString);
  Result := '';
  DoTagEvent(Tag, TagString, TagParams, Result);
end;

function TBasePageProducer.GetScriptEngine: string;
begin
  Result := FScriptEngine;
end;

function TBasePageProducer.UseScriptEngine: Boolean;
begin
  Result := False;
end;

function TBasePageProducer.GetTemplateStream(out AOwned: Boolean): TStream;
begin
  Result := nil;
end;

function TBasePageProducer.GetWebModuleContext: TWebModuleContext;
begin
  // Deprecated
  Result := nil;
end;

function TBasePageProducer.GetProducerTemplateStream(
  out AOwned: Boolean): TStream;
var
  S: string;
begin
  Result := nil;
  if DesignerFileManager <> nil then
  begin
    S := GetProducerTemplateFileName;
    if S <> '' then
      Result := DesignerFileManager.GetStream(S, AOwned);
  end;
  if Result = nil then
    Result := GetTemplateStream(AOwned);
end;

function TBasePageProducer.GetProducerTemplateFileName: string;
begin
  Result := GetTemplateFileName;
  if DesignerFileManager <> nil then
  begin
    if Result <> '' then
      Result := DesignerFileManager.QualifyFileName(Result);
  end
  else
  begin
    // Expand relative path
    if not (((Length(Result) >= 3) and (Result[1+Low(string)] = ':')) or
      ((Length(Result) >= 2) and (Result[Low(string)] = PathDelim) and (Result[1+Low(string)] = PathDelim))) then
      if not ((Length(Result) >= 1) and (Result[Low(string)] = PathDelim)) then
        Result := IncludeTrailingPathDelimiter(WebApplicationDirectory) + Result
      else
        Result := ExtractFileDrive(WebApplicationDirectory) + Result
  end;
end;

function TBasePageProducer.GetTemplateFileName: string;
begin
  Result := '';
end;

procedure TBasePageProducer.DefineProperties(Filer: TFiler);
begin
  inherited;
  // For backwards compatibility
  Filer.DefineProperty('ScriptEngine', ReadScriptEngine, nil, False);
end;

procedure TBasePageProducer.ReadScriptEngine(AReader: TReader);
begin
  FScriptEngine := AReader.ReadString;
end;

{ TCustomPageProducer }

constructor TCustomPageProducer.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FHTMLDoc := TStringList.Create;
end;

destructor TCustomPageProducer.Destroy;
begin
  FHTMLDoc.Free;
  inherited Destroy;
end;

function TCustomPageProducer.GetTemplateStream(out AOwned: Boolean): TStream;
begin
  if FHTMLFile <> '' then
  begin
    Result :=  TFileStream.Create(GetProducerTemplateFileName {Qualified name}, fmOpenRead + fmShareDenyWrite);
    AOwned := True;
  end
  else
  begin
    Result := TStringStream.Create(FHTMLDoc.Text, TEncoding.UTF8);
    AOwned := True;
  end;
end;

procedure TCustomPageProducer.SetHTMLFile(const Value: TFileName);
begin
  if CompareText(FHTMLFile, Value) <> 0 then
  begin
    FHTMLDoc.Clear;
    FHTMLFile := Value;
  end;
end;

procedure TCustomPageProducer.SetHTMLDoc(Value: TStrings);
begin
  FHTMLDoc.Assign(Value);
  FHTMLFile := '';
end;

function TCustomPageProducer.HandleTag(const TagString: string;
  TagParams: TStrings): string;
begin
  Result := ImplHandleTag(TagString, TagParams);
end;

function GetEncodingOfStream(AStream: TStream; out ASignatureSize: Integer): TEncoding;
  function ContainsPreamble(AStream: TStream; Encoding: TEncoding; var ASignatureSize: Integer): Boolean;
  var
    I: Integer;
    Signature: TBytes;
    Bytes: TBytes;
  begin
    Result := False;
    Signature := Encoding.GetPreamble;
    if Signature <> nil then
    begin
      if AStream.Size >= Length(Signature) then
      begin
        SetLength(Bytes, Length(Signature));
        AStream.Read(Bytes[0], Length(Bytes));
        Result := True;
        ASignatureSize := Length(Signature);
        for I := 0 to Length(Signature)-1 do
          if Bytes[I] <> Signature [I] then
          begin
            ASignatureSize := 0;
            Result := False;
            Break;
          end;
      end;
    end
  end;
var
  SavePos: Integer;
begin
  ASignatureSize := 0;
  if AStream is TStringStream then
    Result := TStringStream(AStream).Encoding
  else
  begin
    SavePos := AStream.Position;
    AStream.Position := 0;
    try
      if ContainsPreamble(AStream, TEncoding.UTF8, ASignatureSize) then
        Result := TEncoding.UTF8
      else
        Result := TEncoding.ANSI
    finally
      AStream.Position := SavePos;
    end;
  end;
end;

function ContentFromStream(AStream: TStream;
  AStripParamQuotes: Boolean; AHandleTag: THandleTagProc; AHandledTag: THandledTagProc): string;
var
  Parser: TCopyParser;
  OutStream: TStringStream;
  ParamStr, ReplaceStr, TokenStr, SaveParamStr: UTF8String;
  ParamList: TStringList;
  Encoding: TEncoding;
  SignatureSize: Integer;
  Temp: string;         
begin
  Encoding := GetEncodingOfStream(AStream, SignatureSize);
  AStream.Position := SignatureSize;
  OutStream := TStringStream.Create('', Encoding);
  try
    Parser := TCopyParser.Create(AStream, OutStream);
    with Parser do
    try
      while True do
      begin
        while not (Token in [toEof, '<']) do
        begin
          CopyTokenToOutput;
          SkipToken(True);
        end;
        if Token = toEOF then Break;
        if Token = '<' then
        begin
          if SkipToken(False) = '#' then
          begin
            SkipToken(False);
            TokenStr := Encoding.GetString(BytesOf(TokenString));  
            ParamStr := TrimLeft(TrimRight(Encoding.GetString(BytesOf(SkipToToken('>')))));                  
            ParamList := TStringList.Create;
            try
              if Assigned(AHandledTag) then
              begin
                SaveParamStr := ParamStr;  // ExtractHTTPFields modifies ParamStr
                if Length(SaveParamStr) > 0 then
                  SaveParamStr := ' ' + SaveParamStr;
                Temp := SaveParamStr;
                UniqueString(Temp);
                SaveParamStr := Temp;
              end;
              ExtractHTTPFields([' '], [' '], ParamStr, ParamList, AStripParamQuotes);
              if Assigned(AHandledTag) then
              begin
                Temp := ReplaceStr;        
                if not AHandledTag(TokenStr, ParamList, Temp) then
                  ReplaceStr := '<#' + TokenStr + SaveParamStr + '>'
                else
                  ReplaceStr := Temp;
              end
              else if Assigned(AHandleTag) then
                ReplaceStr := AHandleTag(TokenStr, ParamList)
              else
                { Replace tag with empty string}
                ReplaceStr := '';
              OutStream.WriteString(ReplaceStr);
            finally
              ParamList.Free;
            end;
            SkipToken(True);
          end else
          begin
            OutStream.WriteString('<');
            CopyTokenToOutput;
            SkipToken(True);
          end;
        end;
      end;
    finally
      Parser.Free;
    end;
    Result := OutStream.DataString;
  finally
    OutStream.Free;
  end;
end;

function ContentFromString(const AValue: string;
  AStripParamQuotes: Boolean; AHandleTag: THandleTagProc; AHandledTag: THandledTagProc): string;
var
  InStream: TStream;
begin
  InStream := TStringStream.Create(AValue, TEncoding.UTF8);
  try
    Result := ContentFromStream(InStream, AStripParamQuotes, AHandleTag, AHandledTag);
  finally
    InStream.Free;
  end;
end;

function TCustomPageProducer.GetTemplateFileName: string;
begin
  Result := HTMLFile;
end;

function ModulePath: string;
var
  ModuleName: string;
begin
  if Assigned(GetModuleFileNameProc) then
  begin
    ModuleName := GetModuleFileNameProc;
    Result := ExtractFilePath(ModuleName);
  end
  else
    Result := '';
end;

function QualifyFileName(const AFileName: string): string;
begin
  if DesignerFileManager <> nil then
    Result := DesignerFileManager.QualifyFileName(AFileName)
  else
  begin
    if IsRelativePath(AFileName) then
      Result := ExpandFileName(ModulePath + AFileName)
    else
      Result := AFileName;
  end;
end;

end.
