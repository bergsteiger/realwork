{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcSyntax;

interface
{$I dc.inc}
{$I dcsyntax.inc}

uses
  Windows, Messages, Controls, Classes, Dialogs, Graphics, SysUtils,
  dcSystem, dcdreamLib, dcConsts, dcMemo;

const
  CurrentSchemeVersion = 3;

type

  { TSyntaxScheme }

  TToken = class(TCollectionItem)
  private
    FAttrID: integer;
    FUseToken: Boolean;
  public
    constructor Create(Collection: TCollection); override;
  published
    property FontID: integer read FAttrID write FAttrID default -1;
    property UseToken: Boolean read FUseToken write FUseToken default True;
  end;

  TLineToken = class(TToken)
  private
    FLeftDelimiter: string;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property LeftDelimiter: string read FLeftDelimiter write FLeftDelimiter;
  end;

  TBlockToken = class(TLineToken)
  private
    FRightDelimiter: string;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property RightDelimiter: string read FRightDelimiter write FRightDelimiter;
  end;

  TKeywordSet = class(TToken)
  private
    FName: string;
    FKeywords: string; //space-separated list
  public
    constructor Create(Collection: TCollection); override;
    procedure Assign(Source: TPersistent); override;
  published
    property Name: string read FName write FName;
    property Keywords: string read FKeywords write FKeywords;
  end;

  TAttrItem = class(TCollectionItem)
  private
    FAttrID: integer;
    FGlobalAttrID: string;
    FBlockID: integer;
    FFont, FUsedFont: TFont;
    FBackColor, FUsedBack: TColor;
    FUseDefFont, FUseDefBack: Boolean;

    procedure SetFont(Value: TFont);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property FontID: integer read FAttrID write FAttrID default -1;
    property GlobalAttrID: string read FGlobalAttrID write FGlobalAttrID;
    property BlockID: integer read FBlockID write FBlockID default 0; //Default block
    property Font: TFont read FFont write SetFont;
    property BackColor: TColor read FBackColor write FBackColor default clWindow;
    property UseDefFont: Boolean read FUseDefFont write FUseDefFont default True;
    property UseDefBack: Boolean read FUseDefBack write FUseDefBack default True;
  end;

  TDelimiters = class(TCollectionItem)
  private
    FUseToken: Boolean;
    FLeftDelimiter, FRightDelimiter: string;
    FDelimitersArePartOfBlock: Boolean;
  public
    constructor Create(Collection: TCollection); override;
    procedure Assign(Source: TPersistent); override;
  published
    property LeftDelimiter: string read FLeftDelimiter write FLeftDelimiter;
    property RightDelimiter: string read FRightDelimiter write FRightDelimiter;
    property DelimitersArePartOfBlock: Boolean read FDelimitersArePartOfBlock write FDelimitersArePartOfBlock default False;
    property UseToken: Boolean read FUseToken write FUseToken default True;
  end;

  TLineTokenList = class(TCollection)
  private
    function GetItem(Index: Integer): TLineToken;
    procedure SetItem(Index: Integer; Value: TLineToken);
  public
    property Items[Index: Integer]: TLineToken read GetItem write SetItem; default;
  end;

  TBlockTokenList = class(TCollection)
  private
    function GetItem(Index: Integer): TBlockToken;
    procedure SetItem(Index: Integer; Value: TBlockToken);
  public
    property Items[Index: Integer]: TBlockToken read GetItem write SetItem; default;
  end;

  TKeywordSetList = class(TCollection)
  private
    function GetItem(Index: Integer): TKeywordSet;
    procedure SetItem(Index: Integer; Value: TKeywordSet);
  public
    property Items[Index: Integer]: TKeywordSet read GetItem write SetItem; default;
  end;

  TDelimitersList = class(TCollection)
  private
    function GetItem(Index: Integer): TDelimiters;
    procedure SetItem(Index: Integer; Value: TDelimiters);
  public
    property Items[Index: Integer]: TDelimiters read GetItem write SetItem; default;
  end;

  TFontList = class(TCollection)
  private
    function GetItem(Index: Integer): TAttrItem;
    procedure SetItem(Index: Integer; Value: TAttrItem);
  public
    function GetUniqueID: integer;
    function GetItemByID(AFontID: integer): TAttrItem;
    function GetFontByID(AFontID: integer): TFont;
    property Items[Index: Integer]: TAttrItem read GetItem write SetItem; default;
  end;

  StrArray = array[byte] of string;
  PStrArray = ^StrArray;
  TCompareStrProc = function(const AToken: PChar): Boolean of object;

  TSyntaxBlock = class(TCollectionItem)
  private
    {for speed only}
    FPredSLCCount, FPredMLCCount, FPredFLCCount, FPredSLSCount, FPredMLSCount,
      FPredPNCount, FPredSNCount, FPredPICount, FPredSICount, FPredKWCount: integer;
    FSLCList, FMLCList, FFLCList, FSLSList, FMLSList, FPNList, FSNList, FPIList,
      FSIList, FKWList: TList;
    FSLCIndexList, FMLCIndexList, FFLCIndexList, FSLSIndexList, FMLSIndexList,
      FKWIndexList: TList;
    FCurPosIsToken: TCompareStrProc;
    FPredInnerBDCount, FPredOuterBDCount: integer;
    FInnerBDList, FOuterBDList, FInnerIIList, FOuterIIList: TList;

    {Common block options}
    FName: string;
    FID, FParentID: integer;
    FBlockDelimiters: TDelimitersList;
    FCaseSensitive, FUseMetaSymbol, FUseMetaToWrapLines: Boolean; // \n, \" in C/C++
    FMetaSymbol: char;
    FFirstIdentChars, FOtherIdentChars: TCharSet;
    {Font Indexes}
    FFIText, FFIIntNum, FFIFloatNum, FFIHexNum, FFIDirective, FFISymbol,
      FFIIdentifier: integer; //remain font indexes are in appr. lists
    {Used rules}
    FUseComments: Boolean;
    FUseSingleLineComments: Boolean;
    FUseMultiLineComments: Boolean;
    FUseFullLineComments: Boolean;
    FUseStrings: Boolean;
    FUseSingleLineStrings: Boolean;
    FUseMultiLineStrings: Boolean;
    FUseNumbers: Boolean;
    FUsePrefixedNumbers: Boolean;
    FUseSuffixedNumbers: Boolean;
    FUseMultipleNumSuffixes: Boolean;
    FUsePrefixedSuffixedNumbers: Boolean;
    FUsePSNumComposition: Boolean;
    FUseLineDirectives: Boolean;
    FUseKeywords: Boolean;
    FUseIdentifiers: Boolean;
    FUsePrefixedIdentifiers: Boolean;
    FUseSuffixedIdentifiers: Boolean;
    FUsePrefixedSuffixedIdentifiers: Boolean;
    FUseSymbols: Boolean;
    {Delimiters & Co.}
    FLineDirectivePrefix: string;
    FSingleLineCommentDelimiters: TLineTokenList;
    FMultiLineCommentDelimiters: TBlockTokenList;
    FFullLineCommentDelimiters: TLineTokenList;
    FSingleLineStringDelimiters: TBlockTokenList;
    FMultiLineStringDelimiters: TBlockTokenList;
    FNumPrefixes: TLineTokenList;
    FNumSuffixes: TLineTokenList;
    FNumPrefixesSuffixes: TBlockTokenList;
    FIdentPrefixes: TLineTokenList;
    FIdentSuffixes: TLineTokenList;
    FIdentPrefixesSuffixes: TBlockTokenList;
    FKeywordSets: TKeywordSetList;

    procedure SetBlockDelimiters(Value: TDelimitersList);
    procedure SetSingleLineCommentDelimiters(Value: TLineTokenList);
    procedure SetMultiLineCommentDelimiters(Value: TBlockTokenList);
    procedure SetFullLineCommentDelimiters(Value: TLineTokenList);
    procedure SetSingleLineStringDelimiters(Value: TBlockTokenList);
    procedure SetMultiLineStringDelimiters(Value: TBlockTokenList);
    procedure SetNumPrefixes(Value: TLineTokenList);
    procedure SetNumSuffixes(Value: TLineTokenList);
    procedure SetNumPrefixesSuffixes(Value: TBlockTokenList);
    procedure SetIdentPrefixes(Value: TLineTokenList);
    procedure SetIdentSuffixes(Value: TLineTokenList);
    procedure SetIdentPrefixesSuffixes(Value: TBlockTokenList);
    procedure SetKeywordSets(Value: TKeywordSetList);

    procedure ClearKeywordsHash;
    procedure ReadFirstIdentChars(Reader: TReader);
    procedure ReadOtherIdentChars(Reader: TReader);
    procedure WriteFirstIdentChars(Writer: TWriter);
    procedure WriteOtherIdentChars(Writer: TWriter);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;

    property FirstIdentChars: TCharSet read FFirstIdentChars write FFirstIdentChars;
    property OtherIdentChars: TCharSet read FOtherIdentChars write FOtherIdentChars;
  published
    property Name: string read FName write FName;
    property ID: integer read FID write FID default -1;
    property ParentID: integer read FParentID write FParentID default -1;
    property CaseSensitive: Boolean read FCaseSensitive write FCaseSensitive default False;
    property UseMetaSymbol: Boolean read FUseMetaSymbol write FUseMetaSymbol default False;
    property UseMetaToWrapLines: Boolean read FUseMetaToWrapLines write FUseMetaToWrapLines stored FUseMetaSymbol;
    property MetaSymbol: char read FMetaSymbol write FMetaSymbol stored FUseMetaSymbol;

    property FIText: integer read FFIText write FFIText default -1;
    property FIIntNum: integer read FFIIntNum write FFIIntNum default -1;
    property FIFloatNum: integer read FFIFloatNum write FFIFloatNum default -1;
    property FIHexNum: integer read FFIHexNum write FFIHexNum default -1;
    property FIDirective: integer read FFIDirective write FFIDirective default -1;
    property FISymbol: integer read FFISymbol write FFISymbol default -1;
    property FIIdentifier: integer read FFIIdentifier write FFIIdentifier default -1;

    property UseSymbols: Boolean read FUseSymbols write FUseSymbols default False;
    property UseLineDirectives: Boolean read FUseLineDirectives write FUseLineDirectives default False;
    property UseComments: Boolean read FUseComments write FUseComments default False;
    property UseSingleLineComments: Boolean read FUseSingleLineComments write FUseSingleLineComments default False;
    property UseMultiLineComments: Boolean read FUseMultiLineComments write FUseMultiLineComments default False;
    property UseFullLineComments: Boolean read FUseFullLineComments write FUseFullLineComments default False;
    property UseStrings: Boolean read FUseStrings write FUseStrings default False;
    property UseSingleLineStrings: Boolean read FUseSingleLineStrings write FUseSingleLineStrings default False;
    property UseMultiLineStrings: Boolean read FUseMultiLineStrings write FUseMultiLineStrings default False;
    property UseNumbers: Boolean read FUseNumbers write FUseNumbers default False;
    property UsePrefixedNumbers: Boolean read FUsePrefixedNumbers write FUsePrefixedNumbers default False;
    property UseSuffixedNumbers: Boolean read FUseSuffixedNumbers write FUseSuffixedNumbers default False;
    property UseMultipleNumSuffixes: Boolean read FUseMultipleNumSuffixes write FUseMultipleNumSuffixes stored FUseSuffixedNumbers;
    property UsePrefixedSuffixedNumbers: Boolean read FUsePrefixedSuffixedNumbers write FUsePrefixedSuffixedNumbers default False;
    property UsePSNumComposition: Boolean read FUsePSNumComposition write FUsePSNumComposition stored FUsePrefixedSuffixedNumbers;
    property UseIdentifiers: Boolean read FUseIdentifiers write FUseIdentifiers default False;
    property UsePrefixedIdentifiers: Boolean read FUsePrefixedIdentifiers write FUsePrefixedIdentifiers default False;
    property UseSuffixedIdentifiers: Boolean read FUseSuffixedIdentifiers write FUseSuffixedIdentifiers default False;
    property UsePrefixedSuffixedIdentifiers: Boolean read FUsePrefixedSuffixedIdentifiers write FUsePrefixedSuffixedIdentifiers default False;
    property UseKeywords: Boolean read FUseKeywords write FUseKeywords default False;

    property BlockDelimiters: TDelimitersList read FBlockDelimiters write SetBlockDelimiters;
    property LineDirectivePrefix: string read FLineDirectivePrefix write FLineDirectivePrefix stored FUseLineDirectives;
    property SingleLineCommentDelimiters: TLineTokenList read FSingleLineCommentDelimiters write SetSingleLineCommentDelimiters stored FUseSingleLineComments;
    property MultiLineCommentDelimiters: TBlockTokenList read FMultiLineCommentDelimiters write SetMultiLineCommentDelimiters stored FUseMultiLineComments;
    property FullLineCommentDelimiters: TLineTokenList read FFullLineCommentDelimiters write SetFullLineCommentDelimiters stored FUseFullLineComments;
    property SingleLineStringDelimiters: TBlockTokenList read FSingleLineStringDelimiters write SetSingleLineStringDelimiters stored FUseSingleLineStrings;
    property MultiLineStringDelimiters: TBlockTokenList read FMultiLineStringDelimiters write SetMultiLineStringDelimiters stored FUseMultiLineStrings;
    property NumPrefixes: TLineTokenList read FNumPrefixes write SetNumPrefixes stored FUsePrefixedNumbers;
    property NumSuffixes: TLineTokenList read FNumSuffixes write SetNumSuffixes stored FUseSuffixedNumbers;
    property NumPrefixesSuffixes: TBlockTokenList read FNumPrefixesSuffixes write SetNumPrefixesSuffixes stored FUsePrefixedSuffixedNumbers;
    property IdentPrefixes: TLineTokenList read FIdentPrefixes write SetIdentPrefixes stored FUsePrefixedIdentifiers;
    property IdentSuffixes: TLineTokenList read FIdentSuffixes write SetIdentSuffixes stored FUseSuffixedIdentifiers;
    property IdentPrefixesSuffixes: TBlockTokenList read FIdentPrefixesSuffixes write SetIdentPrefixesSuffixes stored FUsePrefixedSuffixedIdentifiers;
    property KeywordSets: TKeywordSetList read FKeywordSets write SetKeywordSets stored FUseKeywords;
  end;

  TSyntaxBlockList = class(TCollection)
  private
    function GetItem(Index: Integer): TSyntaxBlock;
    procedure SetItem(Index: Integer; Value: TSyntaxBlock);
  public
    property Items[Index: Integer]: TSyntaxBlock read GetItem write SetItem; default;
  end;

  TBlockInfo = class
  private
    FBlockIndex, FDlmtrIndex: integer;
    FNext: TBlockInfo;
  public
    constructor Create(ANext: TBlockInfo; ABlockIndex, ADlmtrIndex: integer);
    destructor Destroy; override;
  end;

  TSyntaxParser = class;

  TSyntaxScheme = class(TPersistent)
  private
    {for speed only}
    FNotUsedChars: TCharSet;
    FAttrIDHash: array[byte] of TAttrItem; //pointers
    FUrlAttr: TAttrItem;
    FSubstAttr: TAttrItem;

    FParser: TSyntaxParser; //pointer
    FName: string;
    FUseGlobalOptions: Boolean;
    {$IFDEF USEEXTENSIONS}
    FExtensions: TStrings;
    {$ENDIF}
    FSyntaxBlocks: TSyntaxBlockList;
    FAttrTable: TFontList;
    FBlockStackList: TList;
    FSyntaxVersion: integer;

    procedure SetSyntaxBlocks(Value: TSyntaxBlockList);
    procedure SetAttrTable(Value: TFontList);
    {$IFDEF USEEXTENSIONS}
    procedure SetExtensions(const Value: TStrings);
    {$ENDIF}

    procedure CreateAttrIDHash;
    procedure ReadSyVer(Reader: TReader);
    procedure WriteSyVer(Writer: TWriter);
    procedure InitBlockStackList;
    procedure ClearBlockStackList;
  protected
    procedure UpdateSchemeVersion; virtual;
    procedure InitScheme; virtual;
    procedure ClearContents;
    procedure DefineProperties(Filer: TFiler); override;
  public
    function GetUniqueBlockID: integer;

    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;

    procedure SchemeChanged;
    procedure LoadFromFile(const AFileName: string);
    procedure SaveToFile(const AFileName: string);
    procedure LoadFromStream(AStream: TStream);
    procedure SaveToStream(AStream: TStream);
    procedure LoadFromResource(const AResName: string);
    //procedure SaveToResource(const AResName: string);

    property Parser: TSyntaxParser read FParser;
  published
    property Name: string read FName write FName;
    {$IFDEF USEEXTENSIONS}
    property Extensions: TStrings read FExtensions write SetExtensions;
    {$ENDIF}
    property SyntaxBlocks: TSyntaxBlockList read FSyntaxBlocks write SetSyntaxBlocks;
    property FontTable: TFontList read FAttrTable write SetAttrTable;
  end;

  { TSyntaxParser }

  {$IFDEF USEEVENTS}
  TGetTokenEvent = procedure(Sender: TObject; TokenID: integer;
    const TokenStr: string) of object;
  {$ENDIF}

  TDefAttrItem = class;

  TSyntaxParser = class(TSimpleParser)
  private
    FSyntaxScheme: TSyntaxScheme;
    FDefaultAttr: TDefAttrItem;
    {$IFDEF USEEVENTS}
    FOnGetToken: TGetTokenEvent;
    //?FOnGetColorData: TGetColorDataEvent;
    {$ENDIF}

    FUpdateCount: integer;
    FCurBlock: TSyntaxBlock;
    //indexes that uniquely determines current state of parser
    FCurStackIndex, FCurBlockIndex, FCurItemIndex, FCurStateIndex, FCurDlmtrIndex: integer;
    FCurToken: integer; //index of last obtained token
    FCurPos: PChar;
    FCurPartOfBlockOption, FCurCaseSensitive, CanParseLineDirective,
      LineDirectiveWasFound, CanParseFullLineComment, NeedCloseString: Boolean; //flags

    procedure SetSyntaxScheme(Value: TSyntaxScheme);
    procedure SetDefaultAttr(Value: TDefAttrItem);
    function GetUseGlobalOptions: Boolean;
    procedure SetUseGlobalOptions(Value: Boolean);

    procedure CMUpdateOptions(var Message: TMessage); message CM_UPDATEOPTIONS;
  protected
    procedure Loaded; override;

    function SetCurBlock(AIndex, ADirection: integer): integer;
    function CurPosIsTokenS(const AToken: PChar): Boolean;
    function CurPosIsTokenI(const AToken: PChar): Boolean;
    procedure DefaultAttrChanged(Sender: TObject);

    function ParseComment: Boolean; virtual;
    function ParseLineDirective: Boolean; virtual;
    function ParseString: Boolean; virtual;
    function ParseIntNumber: Boolean; virtual;
    function ParseFloatNumber: Boolean; virtual;
    function ParsePSNumber: Boolean; virtual;
    function ParseIdentifiers: Boolean; virtual;

    procedure GetToken;
    function _GetAttrID: byte;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function GetFont(AState: integer): TFont; override;
    function GetBackColor(AState: integer; var Color: TColor): boolean; override;
    function ColorString(const StrData: string; InitState: Integer;
      var AColorData: string): Integer; override;
    procedure InitParser; virtual;
    procedure ParserChanged; virtual;
    procedure BeginUpdate;
    procedure EndUpdate;
  published
    property SyntaxScheme: TSyntaxScheme read FSyntaxScheme write SetSyntaxScheme;
    property DefaultAttr: TDefAttrItem read FDefaultAttr write SetDefaultAttr;
    property UseGlobalOptions: Boolean read GetUseGlobalOptions write SetUseGlobalOptions
      default False;
    {$IFDEF USEEVENTS}
    property OnGetToken: TGetTokenEvent read FOnGetToken write FOnGetToken;
    //?property OnGetColorData: TGetColorDataEvent read FOnGetColorData write FOnGetColorData;
    {$ENDIF}
  end;

  TDefAttrItem = class(TAttrItem)
  private
    FParser: TSyntaxParser; //pointer
    procedure SetBackColor(Value: TColor);
    procedure Fake(Value: Boolean);
  public
    constructor Create2(Collection: TCollection; AParser: TSyntaxParser);
  published
    property UseDefFont write Fake default False;
    property UseDefBack write Fake default False;
    property BackColor write SetBackColor;
  end;

const
  { SyntaxParser token codes: max = 255 }
  sptText = 0; { sptText MUST be first }
  sptCommentSL = 1;
  sptCommentML = 2;
  { tokens that may precede LineDirective at line
    MUST have indexes less than sptLineDirective }
  sptLineDirective = 3;
  sptCommentFL = 4; //FLC can't precede LineDirective
  sptStringSL = 5;
  sptStringML = 6;
  sptIntNumber = 7;
  sptFloatNumber = 8;
  sptHexNumber = 9;
  sptIdentifier = 10;
  sptKeyword = 11;
  sptSymbol = 12;

  { SyntaxParser state codes: max = 255 }
  spsNormal = 0;
  spsCommentML = 1;
  spsStringSL = 2;
  spsStringML = 3;
  spsLineDirective = 4; //can't be passed out of Parser

  { Character sets }
  cSyFirstIdentChars: TCharSet = ['A'..'Z', 'a'..'z', '_'];
  cSyOtherIdentChars: TCharSet = ['A'..'Z', 'a'..'z', '_', '0'..'9'];
  cSyHexDigits: TCharSet = ['0'..'9', 'A'..'F', 'a'..'f'];
  cSySymbolChars: TCharSet = [#33..#127] - ['A'..'Z', 'a'..'z', '_', '0'..'9'];

  { defaults }
  DefaultFontName = 'Courier New';
  DefaultFontSize = 10;
  DefaultFontColor = clWindowText;
  DefaultBackColor = clWindow;
  DefaultBlockName = 'Default';
  DefaultGlobalAttrID = STxtStWhiteSp;

type
  TSyntaxItemInfo = record
    Block: TSyntaxBlock; //pointer
    Attribute: TAttrItem; //pointer
    ItemType: integer; //one of spt... const
    ItemSet: TToken; //pointer
  end;

function GetSyntaxBlockAt(AMemo: TDCMemo; APoint: TPoint): TSyntaxBlock;
function GetSyntaxBlockAtCursor(AMemo: TDCMemo): TSyntaxBlock;
function GetItemInfoAt(AMemo: TDCMemo; Point: TPoint): TSyntaxItemInfo;

function StringToCharSet(const Str: string): TCharSet;
function CharSetToString(const CSet: TCharSet): string;

implementation

uses dcString;

const
  cKeywordsSeparator = ',';

  { Reading of TPersistent from stream }

procedure OnReaderError(ASelf: TObject; Reader: TReader; const Message: string;
  var Handled: Boolean);
begin
  Handled := True;
end;

procedure ReadPersFromStream(Stream: TStream; Instance: TPersistent);
var
  c: TPersHolder;
  Reader: TReader;
  FakeMethod: TMethod;
begin
  c := TPersHolder.Create(nil);
  try
    c.P := Instance;
    Reader := TReader.Create(Stream, 4096);
    try
      FakeMethod.Data := nil;
      FakeMethod.Code := @OnReaderError;
      Reader.OnError := TReaderError(FakeMethod);
      Reader.ReadRootComponent(c);
    finally
      Reader.Free;
    end;
  finally
    c.Free;
  end;
end;

procedure ReadPersFromTextStream(Stream: TStream; Instance: TPersistent);
var
  TempStream: TMemoryStream;
begin
  TempStream := TMemoryStream.Create;
  try
    ObjectTextToBinary(Stream, TempStream);
    TempStream.Seek(0, soFromBeginning);
    ReadPersFromStream(TempStream, Instance);
  finally
    TempStream.Free;
  end;
end;

{ TToken }

constructor TToken.Create(Collection: TCollection);
begin
  inherited;
  FAttrID := -1;
  FUseToken := True;
end;

{ TLineToken }

procedure TLineToken.Assign(Source: TPersistent);
begin
  if Source is TLineToken then
    with TLineToken(Source) do
    begin
      Self.FAttrID := FAttrID;
      Self.FUseToken := FUseToken;
      Self.FLeftDelimiter := FLeftDelimiter;
    end
  else
    inherited;
end;

{ TBlockToken }

procedure TBlockToken.Assign(Source: TPersistent);
begin
  if Source is TBlockToken then
    with TBlockToken(Source) do
    begin
      Self.FAttrID := FAttrID;
      Self.FUseToken := FUseToken;
      Self.FLeftDelimiter := FLeftDelimiter;
      Self.FRightDelimiter := FRightDelimiter;
    end
  else
    inherited;
end;

{ TKeywordSet }

constructor TKeywordSet.Create(Collection: TCollection);
begin
  inherited;
  FName := '';
  FKeywords := '';
end;

procedure TKeywordSet.Assign(Source: TPersistent);
begin
  if Source is TKeywordSet then
    with TKeywordSet(Source) do
    begin
      Self.FAttrID := FAttrID;
      Self.FUseToken := FUseToken;
      Self.FName := FName;
      Self.FKeywords := FKeywords;
    end
  else
    inherited;
end;

{ TLineTokenList }

function TLineTokenList.GetItem(Index: Integer): TLineToken;
begin
  Result := TLineToken(inherited Items[Index]);
end;

procedure TLineTokenList.SetItem(Index: Integer; Value: TLineToken);
begin
  inherited Items[Index] := Value;
end;

{ TBlockTokenList }

function TBlockTokenList.GetItem(Index: Integer): TBlockToken;
begin
  Result := TBlockToken(inherited Items[Index]);
end;

procedure TBlockTokenList.SetItem(Index: Integer; Value: TBlockToken);
begin
  inherited Items[Index] := Value;
end;

{ TKeywordSetList }

function TKeywordSetList.GetItem(Index: Integer): TKeywordSet;
begin
  Result := TKeywordSet(inherited Items[Index]);
end;

procedure TKeywordSetList.SetItem(Index: Integer; Value: TKeywordSet);
begin
  inherited Items[Index] := Value;
end;

{ TDelimitersList }

function TDelimitersList.GetItem(Index: Integer): TDelimiters;
begin
  Result := TDelimiters(inherited Items[Index]);
end;

procedure TDelimitersList.SetItem(Index: Integer; Value: TDelimiters);
begin
  inherited Items[Index] := Value;
end;

{ TAttrItem }

constructor TAttrItem.Create(Collection: TCollection);
begin
  inherited;
  if Assigned(Collection) then
    FAttrID := TFontList(Collection).GetUniqueID
  else
    FAttrID := -1;
  FGlobalAttrID := '';
  FBlockID := 0;
  FBackColor := clWindow;
  FFont := TFont.Create;
  FUsedFont := TFont.Create;
  FUseDefFont := True;
  FUseDefBack := True;
end;

destructor TAttrItem.Destroy;
begin
  FFont.Free;
  FUsedFont.Free;
  inherited;
end;

procedure TAttrItem.Assign(Source: TPersistent);
begin
  if Source.InheritsFrom(TAttrItem) then
    with TAttrItem(Source) do
    begin
      Self.FAttrID := FAttrID;
      Self.FGlobalAttrID := FGlobalAttrID;
      Self.FBlockID := FBlockID;
      Self.FBackColor := FBackColor;
      Self.FFont.Assign(FFont);
      Self.FUseDefFont := FUseDefFont;
      Self.FUseDefBack := FUseDefBack;
    end
  else
    inherited;
end;

procedure TAttrItem.SetFont(Value: TFont);
begin
  FFont.Assign(Value);
end;

{ TDefAttrItem }

constructor TDefAttrItem.Create2(Collection: TCollection; AParser: TSyntaxParser);
begin
  inherited Create(Collection);
  FParser := AParser;
end;

procedure TDefAttrItem.SetBackColor(Value: TColor);
begin
  if Value <> FBackColor then
  begin
    FBackColor := Value;
    FParser.DefaultAttrChanged(nil);
  end;
end;

procedure TDefAttrItem.Fake(Value: Boolean);
begin
  //changing of UseDefFont & UseDefBack for DefaultAttr are prohibited
end;

{ TDelimiters }

constructor TDelimiters.Create(Collection: TCollection);
begin
  inherited;
  FUseToken := True;
end;

procedure TDelimiters.Assign(Source: TPersistent);
begin
  if Source is TDelimiters then
    with TDelimiters(Source) do
    begin
      Self.FUseToken := FUseToken;
      Self.FLeftDelimiter := FLeftDelimiter;
      Self.FRightDelimiter := FRightDelimiter;
      Self.FDelimitersArePartOfBlock := FDelimitersArePartOfBlock;
    end
  else
    inherited;
end;

{ TFontList }

function TFontList.GetUniqueID: integer;
var
  i: integer;
  soi: set of byte;
begin
  soi := [tokUrl];
  for i := 0 to Pred(Count) do
    with Items[i] do
      if FAttrID <> -1 then
        Include(soi, FAttrID);
  for i := Low(byte) to High(byte) do
    if not (i in soi) then
    begin
      Result := i;
      exit;
    end;
  Result := -1;
end;

function TFontList.GetItem(Index: Integer): TAttrItem;
begin
  Result := TAttrItem(inherited Items[Index]);
end;

procedure TFontList.SetItem(Index: Integer; Value: TAttrItem);
begin
  inherited Items[Index] := Value;
end;

function TFontList.GetItemByID(AFontID: integer): TAttrItem;
var
  i: integer;
begin
  for i := 0 to Pred(Count) do
  begin
    Result := GetItem(i);
    if Result.FAttrID = AFontID then
      exit;
  end;
  Result := nil;
end;

function TFontList.GetFontByID(AFontID: integer): TFont;
var
  AItem: TAttrItem;
begin
  AItem := GetItemByID(AFontID);
  if Assigned(AItem) then
    Result := AItem.FFont
  else
    Result := nil;
end;

{ TSyntaxBlock }

constructor TSyntaxBlock.Create(Collection: TCollection);
begin
  inherited;
  FID := -1;
  FParentID := -1;

  FCaseSensitive := False;
  FUseMetaSymbol := False;
  FUseMetaToWrapLines := True;
  FMetaSymbol := #0;
  FFirstIdentChars := cSyFirstIdentChars;
  FOtherIdentChars := cSyOtherIdentChars;

  FFIText := -1;
  FFIIntNum := -1;
  FFIFloatNum := -1;
  FFIHexNum := -1;
  FFIDirective := -1;
  FFISymbol := -1;
  FFIIdentifier := -1;

  FBlockDelimiters := TDelimitersList.Create(TDelimiters);
  FSingleLineCommentDelimiters := TLineTokenList.Create(TLineToken);
  FMultiLineCommentDelimiters := TBlockTokenList.Create(TBlockToken);
  FFullLineCommentDelimiters := TLineTokenList.Create(TLineToken);
  FSingleLineStringDelimiters := TBlockTokenList.Create(TBlockToken);
  FMultiLineStringDelimiters := TBlockTokenList.Create(TBlockToken);
  FNumPrefixes := TLineTokenList.Create(TLineToken);
  FNumSuffixes := TLineTokenList.Create(TLineToken);
  FNumPrefixesSuffixes := TBlockTokenList.Create(TBlockToken);
  FIdentPrefixes := TLineTokenList.Create(TLineToken);
  FIdentSuffixes := TLineTokenList.Create(TLineToken);
  FIdentPrefixesSuffixes := TBlockTokenList.Create(TBlockToken);
  FKeywordSets := TKeywordSetList.Create(TKeywordSet);

  FSLCList := TList.Create;
  FMLCList := TList.Create;
  FFLCList := TList.Create;
  FSLSList := TList.Create;
  FMLSList := TList.Create;
  FPNList := TList.Create;
  FSNList := TList.Create;
  FPIList := TList.Create;
  FSIList := TList.Create;
  FKWList := TList.Create;
  FSLCIndexList := TList.Create;
  FMLCIndexList := TList.Create;
  FFLCIndexList := TList.Create;
  FSLSIndexList := TList.Create;
  FMLSIndexList := TList.Create;
  FKWIndexList := TList.Create;

  FPredInnerBDCount := -1;
  FPredOuterBDCount := -1;
  FInnerBDList := TList.Create;
  FOuterBDList := TList.Create;
  FInnerIIList := TList.Create;
  FOuterIIList := TList.Create;
end;

destructor TSyntaxBlock.Destroy;
begin
  FBlockDelimiters.Free;
  FSingleLineCommentDelimiters.Free;
  FMultiLineCommentDelimiters.Free;
  FFullLineCommentDelimiters.Free;
  FSingleLineStringDelimiters.Free;
  FMultiLineStringDelimiters.Free;
  FNumPrefixes.Free;
  FNumSuffixes.Free;
  FNumPrefixesSuffixes.Free;
  FIdentPrefixes.Free;
  FIdentSuffixes.Free;
  FIdentPrefixesSuffixes.Free;
  FKeywordSets.Free;

  FSLCList.Free;
  FMLCList.Free;
  FFLCList.Free;
  FSLSList.Free;
  FMLSList.Free;
  FPNList.Free;
  FSNList.Free;
  FPIList.Free;
  FSIList.Free;
  ClearKeywordsHash;
  FKWList.Free;
  FSLCIndexList.Free;
  FMLCIndexList.Free;
  FFLCIndexList.Free;
  FSLSIndexList.Free;
  FMLSIndexList.Free;
  FKWIndexList.Free;

  FInnerBDList.Free;
  FOuterBDList.Free;
  FInnerIIList.Free;
  FOuterIIList.Free;

  inherited;
end;

procedure TSyntaxBlock.ClearKeywordsHash;
var
  i, j: integer;
begin
  with FKWList do
    for i := Pred(Count) downto 0 do
    begin
      for j := 0 to 255 do
        PStrArray(Items[i])[j] := '';
      Dispose(Items[i]);
    end;
end;

procedure TSyntaxBlock.ReadFirstIdentChars(Reader: TReader);
begin
  FFirstIdentChars := StringToCharSet(Reader.ReadString);
end;

procedure TSyntaxBlock.ReadOtherIdentChars(Reader: TReader);
begin
  FOtherIdentChars := StringToCharSet(Reader.ReadString);
end;

procedure TSyntaxBlock.WriteFirstIdentChars(Writer: TWriter);
begin
  Writer.WriteString(CharSetToString(FFirstIdentChars));
end;

procedure TSyntaxBlock.WriteOtherIdentChars(Writer: TWriter);
begin
  Writer.WriteString(CharSetToString(FOtherIdentChars));
end;

procedure TSyntaxBlock.DefineProperties(Filer: TFiler);
begin
  Filer.DefineProperty('FirstIdentChars', ReadFirstIdentChars,
    WriteFirstIdentChars, FFirstIdentChars <> cSyFirstIdentChars); //don't resource
  Filer.DefineProperty('OtherIdentChars', ReadOtherIdentChars,
    WriteOtherIdentChars, FOtherIdentChars <> cSyOtherIdentChars); //don't resource
end;

procedure TSyntaxBlock.Assign(Source: TPersistent);
begin
  if Source is TSyntaxBlock then
    with TSyntaxBlock(Source) do
    begin
      Self.FName := FName;
      Self.FID := FID;
      Self.FParentID := FParentID;
      Self.FCaseSensitive := FCaseSensitive;
      Self.FUseMetaSymbol := FUseMetaSymbol;
      Self.FUseMetaToWrapLines := FUseMetaToWrapLines;
      Self.FMetaSymbol := FMetaSymbol;
      Self.FFirstIdentChars := FFirstIdentChars;
      Self.FOtherIdentChars := FOtherIdentChars;

      Self.FFIText := FFIText;
      Self.FFIIntNum := FFIIntNum;
      Self.FFIFloatNum := FFIFloatNum;
      Self.FFIHexNum := FFIHexNum;
      Self.FFIDirective := FFIDirective;
      Self.FFISymbol := FFISymbol;
      Self.FFIIdentifier := FFIIdentifier;

      Self.FUseComments := FUseComments;
      Self.FUseSingleLineComments := FUseSingleLineComments;
      Self.FUseMultiLineComments := FUseMultiLineComments;
      Self.FUseFullLineComments := FUseFullLineComments;
      Self.FUseStrings := FUseStrings;
      Self.FUseSingleLineStrings := FUseSingleLineStrings;
      Self.FUseMultiLineStrings := FUseMultiLineStrings;
      Self.FUseNumbers := FUseNumbers;
      Self.FUsePrefixedNumbers := FUsePrefixedNumbers;
      Self.FUseSuffixedNumbers := FUseSuffixedNumbers;
      Self.FUseMultipleNumSuffixes := FUseMultipleNumSuffixes;
      Self.FUsePrefixedSuffixedNumbers := FUsePrefixedSuffixedNumbers;
      Self.FUsePSNumComposition := FUsePSNumComposition;
      Self.FUseLineDirectives := FUseLineDirectives;
      Self.FUseKeywords := FUseKeywords;
      Self.FUseIdentifiers := FUseIdentifiers;
      Self.FUsePrefixedIdentifiers := FUsePrefixedIdentifiers;
      Self.FUseSuffixedIdentifiers := FUseSuffixedIdentifiers;
      Self.FUsePrefixedSuffixedIdentifiers := FUsePrefixedSuffixedIdentifiers;
      Self.FUseSymbols := FUseSymbols;

      Self.FLineDirectivePrefix := FLineDirectivePrefix;
      Self.FBlockDelimiters.Assign(FBlockDelimiters);
      Self.FSingleLineCommentDelimiters.Assign(FSingleLineCommentDelimiters);
      Self.FMultiLineCommentDelimiters.Assign(FMultiLineCommentDelimiters);
      Self.FFullLineCommentDelimiters.Assign(FFullLineCommentDelimiters);
      Self.FSingleLineStringDelimiters.Assign(FSingleLineStringDelimiters);
      Self.FMultiLineStringDelimiters.Assign(FMultiLineStringDelimiters);
      Self.FNumPrefixes.Assign(FNumPrefixes);
      Self.FNumSuffixes.Assign(FNumSuffixes);
      Self.FNumPrefixesSuffixes.Assign(FNumPrefixesSuffixes);
      Self.FIdentPrefixes.Assign(FIdentPrefixes);
      Self.FIdentSuffixes.Assign(FIdentSuffixes);
      Self.FIdentPrefixesSuffixes.Assign(FIdentPrefixesSuffixes);
      Self.FKeywordSets.Assign(FKeywordSets);
    end
  else
    inherited;
end;

procedure TSyntaxBlock.SetBlockDelimiters(Value: TDelimitersList);
begin
  FBlockDelimiters.Assign(Value);
end;

procedure TSyntaxBlock.SetSingleLineCommentDelimiters(Value: TLineTokenList);
begin
  FSingleLineCommentDelimiters.Assign(Value);
end;

procedure TSyntaxBlock.SetMultiLineCommentDelimiters(Value: TBlockTokenList);
begin
  FMultiLineCommentDelimiters.Assign(Value);
end;

procedure TSyntaxBlock.SetFullLineCommentDelimiters(Value: TLineTokenList);
begin
  FFullLineCommentDelimiters.Assign(Value);
end;

procedure TSyntaxBlock.SetSingleLineStringDelimiters(Value: TBlockTokenList);
begin
  FSingleLineStringDelimiters.Assign(Value);
end;

procedure TSyntaxBlock.SetMultiLineStringDelimiters(Value: TBlockTokenList);
begin
  FMultiLineStringDelimiters.Assign(Value);
end;

procedure TSyntaxBlock.SetNumPrefixes(Value: TLineTokenList);
begin
  FNumPrefixes.Assign(Value);
end;

procedure TSyntaxBlock.SetNumSuffixes(Value: TLineTokenList);
begin
  NumSuffixes.Assign(Value);
end;

procedure TSyntaxBlock.SetNumPrefixesSuffixes(Value: TBlockTokenList);
begin
  FNumPrefixesSuffixes.Assign(Value);
end;

procedure TSyntaxBlock.SetIdentPrefixes(Value: TLineTokenList);
begin
  FIdentPrefixes.Assign(Value);
end;

procedure TSyntaxBlock.SetIdentSuffixes(Value: TLineTokenList);
begin
  FIdentSuffixes.Assign(Value);
end;

procedure TSyntaxBlock.SetIdentPrefixesSuffixes(Value: TBlockTokenList);
begin
  FIdentPrefixesSuffixes.Assign(Value);
end;

procedure TSyntaxBlock.SetKeywordSets(Value: TKeywordSetList);
begin
  FKeywordSets.Assign(Value);
end;

{ TSyntaxBlockList }

function TSyntaxBlockList.GetItem(Index: Integer): TSyntaxBlock;
begin
  Result := TSyntaxBlock(inherited Items[Index]);
end;

procedure TSyntaxBlockList.SetItem(Index: Integer; Value: TSyntaxBlock);
begin
  inherited Items[Index] := Value;
end;

{ TBlockInfo }

constructor TBlockInfo.Create(ANext: TBlockInfo; ABlockIndex, ADlmtrIndex: integer);
begin
  inherited Create;
  FBlockIndex := ABlockIndex;
  FDlmtrIndex := ADlmtrIndex;
  FNext := ANext;
end;

destructor TBlockInfo.Destroy;
begin
  if Assigned(FNext) then
    FNext.Free;
  inherited;
end;

{ TSyntaxScheme }

function TSyntaxScheme.GetUniqueBlockID: integer;
var
  i: integer;
  soi: set of byte;
begin
  soi := [];
  for i := 0 to Pred(FSyntaxBlocks.Count) do
    with FSyntaxBlocks[i] do
      if FID <> -1 then
        Include(soi, FID);
  for i := Low(byte) to High(byte) do
    if not (i in soi) then
    begin
      Result := i;
      exit;
    end;
  Result := 0;
end;

constructor TSyntaxScheme.Create;
begin
  inherited;
  FBlockStackList := TList.Create;
  FParser := nil;
  FSubstAttr := TAttrItem.Create(nil);
  with FSubstAttr do
  begin
    FGlobalAttrID := DefaultGlobalAttrID;
    FBlockID := 0;
    FUseDefFont := False;
    FUseDefBack := False;
  end;
  FUrlAttr := TAttrItem.Create(nil);
  with FUrlAttr do
  begin
    FAttrID := tokUrl;
    FGlobalAttrID := STxtStUrl;
    FBlockID := 0;
    FUseDefFont := False;
    FUseDefBack := False;
  end;
  FAttrTable := TFontList.Create(TAttrItem);
  FSyntaxBlocks := TSyntaxBlockList.Create(TSyntaxBlock);
  with TSyntaxBlock(FSyntaxBlocks.Add) do
  begin //default block always exists
    FName := DefaultBlockName;
    ID := 0;
  end;
  FName := '';
  FUseGlobalOptions := False;
  FSyntaxVersion := 1; //the oldest version
  {$IFDEF USEEXTENSIONS}
  FExtensions := TStringList.Create;
  with TStringList(FExtensions) do
  begin
    Duplicates := dupIgnore;
    Sorted := True;
  end;
  {$ENDIF}
  InitBlockStackList;
end;

destructor TSyntaxScheme.Destroy;
begin
  {$IFDEF USEEXTENSIONS}
  FExtensions.Free;
  {$ENDIF}
  FSyntaxBlocks.Free;
  FUrlAttr.Free;
  FAttrTable.Free;
  FSubstAttr.Free;
  ClearBlockStackList;
  FBlockStackList.Free;
  inherited;
end;

procedure TSyntaxScheme.Assign(Source: TPersistent);
begin
  if (Source is TSyntaxScheme) and (Source <> Self) then
    with TSyntaxScheme(Source) do
    begin
      Self.FSyntaxVersion := FSyntaxVersion;
      Self.FName := FName;
      //Self.FParser := FParser;
      Self.FAttrTable.Assign(FAttrTable);
      Self.FSyntaxBlocks.Assign(FSyntaxBlocks);
      {$IFDEF USEEXTENSIONS}
      Self.FExtensions.Assign(FExtensions);
      {$ENDIF}
      Self.SchemeChanged;
    end
  else
    inherited;
end;

procedure TSyntaxScheme.SetSyntaxBlocks(Value: TSyntaxBlockList);
begin
  FSyntaxBlocks.Assign(Value);
end;

procedure TSyntaxScheme.SetAttrTable(Value: TFontList);
begin
  FAttrTable.Assign(Value);
end;

{$IFDEF USEEXTENSIONS}

procedure TSyntaxScheme.SetExtensions(const Value: TStrings);
begin
  FExtensions.Assign(Value);
end;
{$ENDIF}

procedure TSyntaxScheme.ReadSyVer(Reader: TReader);
begin
  FSyntaxVersion := Reader.ReadInteger;
end;

procedure TSyntaxScheme.WriteSyVer(Writer: TWriter);
begin
  Writer.WriteInteger(FSyntaxVersion);
end;

procedure TSyntaxScheme.DefineProperties(Filer: TFiler);
begin
  Filer.DefineProperty('SyntaxVersion', ReadSyVer, WriteSyVer, True); //don't resource
end;

procedure TSyntaxScheme.InitBlockStackList;
begin
  ClearBlockStackList;
  FBlockStackList.Add(TBlockInfo.Create(nil, 0, -1));
end;

procedure TSyntaxScheme.ClearBlockStackList;
var
  i: integer;
begin
  with FBlockStackList do
  begin
    for i := 0 to Pred(Count) do
      TBlockInfo(List[i]).Free;
    Clear;
  end;
end;

procedure TSyntaxScheme.SchemeChanged;
begin
  if Assigned(FParser) then
    FParser.InitParser
  else
    InitScheme;
end;

procedure TSyntaxScheme.UpdateSchemeVersion;
var
  i, id0, bid: integer;

  procedure CorrectBlockIDOfAttrItem(AItemID, ABlockID: integer);
  begin
    if AItemID >= 0 then
      FAttrTable.GetItemByID(AItemID).FBlockID := ABlockID;
  end;

  procedure CorrectTokenList(AList: TCollection);
  var
    i: integer;
  begin
    with AList do
      for i := 0 to Count - 1 do
        CorrectBlockIDOfAttrItem(TToken(Items[i]).FAttrID, bid);
  end;

begin
  if FSyntaxVersion < 2 then
  begin
    //included blocks not supported in ver. 1 => correct this
    //assign unique IDs to all blocks
    for i := 0 to Pred(FSyntaxBlocks.Count) do
      with FSyntaxBlocks[i] do
        if FID = -1 then
          FID := GetUniqueBlockID;
    //Default block has no parent
    if FSyntaxBlocks.Count > 0 then
      FSyntaxBlocks[0].FParentID := -1;
    //Other blocks are children of Default block
    id0 := FSyntaxBlocks[0].FID;
    for i := 1 to Pred(FSyntaxBlocks.Count) do
      FSyntaxBlocks[i].FParentID := id0;
    //assign BlockIDs to all AttrItems
    for i := 0 to Pred(FSyntaxBlocks.Count) do
      with FSyntaxBlocks[i] do
      begin
        bid := FID;
        CorrectBlockIDOfAttrItem(FFIText, bid);
        CorrectBlockIDOfAttrItem(FFIIntNum, bid);
        CorrectBlockIDOfAttrItem(FFIFloatNum, bid);
        CorrectBlockIDOfAttrItem(FFIHexNum, bid);
        CorrectBlockIDOfAttrItem(FFIDirective, bid);
        CorrectBlockIDOfAttrItem(FFISymbol, bid);
        CorrectBlockIDOfAttrItem(FFIIdentifier, bid);
        CorrectTokenList(FSingleLineCommentDelimiters);
        CorrectTokenList(FMultiLineCommentDelimiters);
        CorrectTokenList(FFullLineCommentDelimiters);
        CorrectTokenList(FSingleLineStringDelimiters);
        CorrectTokenList(FMultiLineStringDelimiters);
        CorrectTokenList(FNumPrefixes);
        CorrectTokenList(FNumSuffixes);
        CorrectTokenList(FNumPrefixesSuffixes);
        CorrectTokenList(FIdentPrefixes);
        CorrectTokenList(FIdentSuffixes);
        CorrectTokenList(FIdentPrefixesSuffixes);
        CorrectTokenList(FKeywordSets);
      end;
  end;
  FSyntaxVersion := CurrentSchemeVersion; //update scheme version to the latest value
end;

procedure TSyntaxScheme.InitScheme;
var
  CurUsedChars: TCharSet;
  i, j, k, idx, c: integer;
  sl: TStringList;
  sa: PStrArray;
  cb: TSyntaxBlock;

  procedure AddStrChars(var ASet: TCharSet; const AStr: string);
  var
    i: integer;
  begin
    for i := 1 to Length(AStr) do
      Include(ASet, AStr[i]);
  end;

  procedure AddCharsFromLineTokenList(AList: TLineTokenList);
  var
    i: integer;
  begin
    with AList do
      for i := 0 to Pred(Count) do
        if Items[i].FUseToken then
          AddStrChars(CurUsedChars, Items[i].FLeftDelimiter);
  end;

  procedure AddCharsFromBlockTokenList(AList: TBlockTokenList);
  var
    i: integer;
  begin
    with AList do
      for i := 0 to Pred(Count) do
        if Items[i].FUseToken then
        begin
          AddStrChars(CurUsedChars, Items[i].FLeftDelimiter);
          AddStrChars(CurUsedChars, Items[i].FRightDelimiter);
        end;
  end;

begin
  UpdateSchemeVersion;
  InitBlockStackList;

  CurUsedChars := [];
  for i := 0 to Pred(FSyntaxBlocks.Count) do
    with FSyntaxBlocks[i] do
    begin
      FInnerBDList.Clear;
      FOuterBDList.Clear;
      FInnerIIList.Clear;
      FOuterIIList.Clear;
      FPredInnerBDCount := -1;
      FPredOuterBDCount := -1;
      //calculate set of not used chars
      CurUsedChars := CurUsedChars + FirstIdentChars + FOtherIdentChars;
      if FUseMetaSymbol then
        AddStrChars(CurUsedChars, FMetaSymbol);
      with FBlockDelimiters do
        for j := 0 to Pred(Count) do
          if Items[j].FUseToken then
          begin
            AddStrChars(CurUsedChars, Items[j].FLeftDelimiter);
            AddStrChars(CurUsedChars, Items[j].FRightDelimiter);
          end;
      if FUseComments then
      begin
        if FUseSingleLineComments then
          AddCharsFromLineTokenList(FSingleLineCommentDelimiters);
        if FUseMultiLineComments then
          AddCharsFromBlockTokenList(FMultiLineCommentDelimiters);
        if FUseFullLineComments then
          AddCharsFromLineTokenList(FFullLineCommentDelimiters);
      end;
      if FUseStrings then
      begin
        if FUseSingleLineStrings then
          AddCharsFromBlockTokenList(FSingleLineStringDelimiters);
        if FUseMultiLineStrings then
          AddCharsFromBlockTokenList(FMultiLineStringDelimiters);
      end;
      if FUseNumbers then
      begin
        if FUsePrefixedNumbers then
          AddCharsFromLineTokenList(FNumPrefixes);
        if FUseSuffixedNumbers then
          AddCharsFromLineTokenList(FNumSuffixes);
        if FUsePrefixedSuffixedNumbers then
          AddCharsFromBlockTokenList(FNumPrefixesSuffixes);
      end;
      if FUsePrefixedIdentifiers then
        AddCharsFromLineTokenList(FIdentPrefixes);
      if FUseSuffixedIdentifiers then
        AddCharsFromLineTokenList(FIdentSuffixes);
      if FUsePrefixedSuffixedIdentifiers then
        AddCharsFromBlockTokenList(FIdentPrefixesSuffixes);
      if FUseLineDirectives then
        AddStrChars(CurUsedChars, FLineDirectivePrefix);

      //create quick lists of block delimiters (separately inner & outer)
      cb := FSyntaxBlocks[i];
      for k := 0 to Pred(FSyntaxBlocks.Count) do
        if FSyntaxBlocks[k].FParentID = cb.FID then
          with FSyntaxBlocks[k] do
            for j := 0 to Pred(FBlockDelimiters.Count) do
              with FBlockDelimiters[j] do
                if FUseToken then
                  if FDelimitersArePartOfBlock then
                  begin
                    cb.FInnerBDList.Add(Pointer(FLeftDelimiter));
                    cb.FInnerIIList.Add(Pointer((integer(FDelimitersArePartOfBlock) shl 17) +
                      (integer(FCaseSensitive) shl 16) + (k shl 8) + j));
                    Inc(cb.FPredInnerBDCount);
                  end
                  else
                  begin
                    cb.FOuterBDList.Add(Pointer(FLeftDelimiter));
                    cb.FOuterIIList.Add(Pointer((integer(FDelimitersArePartOfBlock) shl 17) +
                      (integer(FCaseSensitive) shl 16) + (k shl 8) + j));
                    Inc(cb.FPredOuterBDCount);
                  end;

      //create quick lists of token delimiters & its indexes
      c := -1;
      FSLCList.Clear;
      FSLCIndexList.Clear;
      for j := 0 to Pred(FSingleLineCommentDelimiters.Count) do
        with FSingleLineCommentDelimiters[j] do
          if FUseToken then
          begin
            FSLCList.Add(Pointer(FLeftDelimiter));
            FSLCIndexList.Add(Pointer(j));
            Inc(c);
          end;
      FPredSLCCount := c;
      c := -1;
      FMLCList.Clear;
      FMLCIndexList.Clear;
      for j := 0 to Pred(FMultiLineCommentDelimiters.Count) do
        with FMultiLineCommentDelimiters[j] do
          if FUseToken then
          begin
            FMLCList.Add(Pointer(FLeftDelimiter));
            FMLCIndexList.Add(Pointer(j));
            Inc(c);
          end;
      FPredMLCCount := c;
      c := -1;
      FFLCList.Clear;
      FFLCIndexList.Clear;
      for j := 0 to Pred(FFullLineCommentDelimiters.Count) do
        with FFullLineCommentDelimiters[j] do
          if FUseToken then
          begin
            FFLCList.Add(Pointer(FLeftDelimiter));
            FFLCIndexList.Add(Pointer(j));
            Inc(c);
          end;
      FPredFLCCount := c;
      c := -1;
      FSLSList.Clear;
      FSLSIndexList.Clear;
      for j := 0 to Pred(FSingleLineStringDelimiters.Count) do
        with FSingleLineStringDelimiters[j] do
          if FUseToken then
          begin
            FSLSList.Add(Pointer(FLeftDelimiter));
            FSLSIndexList.Add(Pointer(j));
            Inc(c);
          end;
      FPredSLSCount := c;
      c := -1;
      FMLSList.Clear;
      FMLSIndexList.Clear;
      for j := 0 to Pred(FMultiLineStringDelimiters.Count) do
        with FMultiLineStringDelimiters[j] do
          if FUseToken then
          begin
            FMLSList.Add(Pointer(FLeftDelimiter));
            FMLSIndexList.Add(Pointer(j));
            Inc(c);
          end;
      FPredMLSCount := c;
      c := -1;
      FPNList.Clear;
      for j := 0 to Pred(FNumPrefixes.Count) do
        with FNumPrefixes[j] do
          if FUseToken then
          begin
            FPNList.Add(Pointer(FLeftDelimiter));
            Inc(c);
          end;
      FPredPNCount := c;
      c := -1;
      FSNList.Clear;
      for j := 0 to Pred(FNumSuffixes.Count) do
        with FNumSuffixes[j] do
          if FUseToken then
          begin
            FSNList.Add(Pointer(FLeftDelimiter));
            Inc(c);
          end;
      FPredSNCount := c;
      c := -1;
      FPIList.Clear;
      for j := 0 to Pred(FIdentPrefixes.Count) do
        with FIdentPrefixes[j] do
          if FUseToken then
          begin
            FPIList.Add(Pointer(FLeftDelimiter));
            Inc(c);
          end;
      FPredPICount := c;
      c := -1;
      FSIList.Clear;
      for j := 0 to Pred(FIdentSuffixes.Count) do
        with FIdentSuffixes[j] do
          if FUseToken then
          begin
            FSIList.Add(Pointer(FLeftDelimiter));
            Inc(c);
          end;
      FPredSICount := c;

      ClearKeywordsHash;
      FKWList.Clear;
      FKWIndexList.Clear;
      c := -1;
      //for keywords - create separate lists for each 1st letter
      sl := TStringList.Create;
      try
        for j := 0 to Pred(FKeywordSets.Count) do
          if FKeywordSets[j].FUseToken then
          begin
            FKWIndexList.Add(Pointer(j));
            Inc(c);
            New(sa);
            for k := 0 to 255 do
              sa[k] := '';
            //lowercase keywords if need
            if FCaseSensitive then
              sl.CommaText := FKeywordSets[j].FKeywords
            else
              sl.CommaText := AnsiLowerCase(FKeywordSets[j].FKeywords);
            for k := 0 to Pred(sl.Count) do
            begin
              idx := byte(sl[k][1]);
              if sa[idx] = '' then
                sa[idx] := cKeywordsSeparator;
              sa[idx] := sa[idx] + sl[k] + cKeywordsSeparator;
            end;
            FKWList.Add(sa);
          end;
        FPredKWCount := c;
      finally
        sl.Free;
      end;

      if Assigned(FParser) then
        if FCaseSensitive then
          FCurPosIsToken := FParser.CurPosIsTokenS
        else
          FCurPosIsToken := FParser.CurPosIsTokenI;
    end;
  FNotUsedChars := cSySymbolChars - CurUsedChars;

  if Assigned(FParser) then
    FParser.ParserChanged;
end;

procedure TSyntaxScheme.CreateAttrIDHash;

  function GetNearestParent(SrcID: integer; WantFont: Boolean): TAttrItem;

    function GetBlockByID(AID: integer): TSyntaxBlock;
    var
      i: integer;
    begin
      for i := 0 to FSyntaxBlocks.Count - 1 do
        if FSyntaxBlocks[i].ID = AID then
        begin
          Result := FSyntaxBlocks[i];
          exit;
        end;
      Result := nil;
    end;

  var
    ABlock: TSyntaxBlock;
  begin
    ABlock := GetBlockByID(SrcID);
    while Assigned(ABlock) do
    begin
      if ABlock.FFIText >= 0 then
      begin
        Result := FAttrTable.GetItemByID(ABlock.FFIText);
        with Result do
          if Assigned(Result) and not (WantFont and FUseDefFont or
            not WantFont and FUseDefBack) then
            exit;
      end;
      ABlock := GetBlockByID(ABlock.FParentID);
    end;
    Result := nil;
  end;

var
  AGlobalMemoOptions: TMemoEnvOptions;

  function GetGlobalTextStyle(const AGlobalAttrID: string): TTextStyle;
  var
    idx: integer;
  begin
    with AGlobalMemoOptions.TextStyles do
    begin
      idx := IndexOfName(AGlobalAttrID);
      if idx >= 0 then
        Result := Items[idx]
      else
        Result := nil;
    end;
  end;

var
  DefBackColor, DefFontColor: TColor;
  DefName: string;
  DefSize: integer;

  procedure InitializeSpecAttr(AAttr: TAttrItem; Ignore: Boolean);
  var
    ts: TTextStyle;
  begin
    with AAttr, FUsedFont do
    begin
      Name := DefName;
      Size := DefSize;
      if FUseGlobalOptions or Ignore then
        ts := GetGlobalTextStyle(FGlobalAttrID)
      else
        ts := nil;
      if Assigned(ts) then
        Color := ts.Font.Color
      else
        Color := DefFontColor;
      FUsedBack := DefBackColor;
    end;
  end;

var
  i: integer;
  fi, pi: TAttrItem;
  ts: TTextStyle;
begin
  AGlobalMemoOptions := GlobalMemoOptions;
  for i := 0 to 255 do
    FAttrIDHash[i] := nil;

  if Assigned(FParser) and Assigned(FParser.FDefaultAttr.FFont) then
  begin
    if FUseGlobalOptions then
      with AGlobalMemoOptions.Font do
      begin
        DefName := Name;
        DefSize := Size;
      end
    else
      with FParser.FDefaultAttr, FFont do
      begin
        DefName := Name;
        DefSize := Size;
        DefFontColor := Color;
        DefBackColor := BackColor;
      end;
  end
  else
  begin
    DefName := DefaultFontName;
    DefSize := DefaultFontSize;
    if not FUseGlobalOptions then
    begin
      DefFontColor := DefaultFontColor;
      DefBackColor := DefaultBackColor;
    end;
  end;
  if FUseGlobalOptions then
  begin
    ts := GetGlobalTextStyle(DefaultGlobalAttrID);
    if Assigned(ts) then
      with ts do
      begin
        DefFontColor := Font.Color;
        if UseMemoColor then
          DefBackColor := AGlobalMemoOptions.Color
        else
          DefBackColor := Color;
      end;
  end;

  InitializeSpecAttr(FUrlAttr, True);
  FUrlAttr.FUsedFont.Style := [fsUnderline];
  InitializeSpecAttr(FSubstAttr, False);
  FSubstAttr.FUsedFont.Style := [];

  with FAttrTable do
  begin
    FAttrIDHash[tokUrl] := FUrlAttr;
    if Count = 0 then
      FAttrIDHash[0] := FSubstAttr
    else
      for i := 0 to Pred(Count) do
      begin
        fi := Items[i];
        FAttrIDHash[fi.FAttrID] := fi;
        with fi, FUsedFont do
        begin
          if FUseDefFont then
          begin
            pi := GetNearestParent(FBlockID, True);
            if Assigned(pi) then
            begin
              Name := pi.FFont.Name;
              Size := pi.FFont.Size;
            end
            else
            begin
              Name := DefName;
              Size := DefSize;
            end;
          end
          else
          begin
            Name := FFont.Name;
            Size := FFont.Size;
          end;
          if FUseDefBack then
          begin
            pi := GetNearestParent(FBlockID, False);
            if Assigned(pi) then
              FUsedBack := pi.FUsedBack
            else
              FUsedBack := DefBackColor;
          end
          else
            FUsedBack := FBackColor;
          if FUseGlobalOptions then
            ts := GetGlobalTextStyle(FGlobalAttrID)
          else
            ts := nil;
          if Assigned(ts) then
          begin
            Color := ts.Font.Color;
            Style := ts.Font.Style;
            if ts.UseMemoColor then
              DefBackColor := AGlobalMemoOptions.Color
            else
              DefBackColor := ts.Color;
          end
          else
          begin
            Color := FFont.Color;
            Style := FFont.Style;
          end;
        end;
      end;
  end;
end;

procedure TSyntaxScheme.ClearContents;
begin
  FName := '';
  FSyntaxVersion := 1;
  FSyntaxBlocks.Clear;
  FAttrTable.Clear;
end;

procedure TSyntaxScheme.LoadFromFile(const AFileName: string);
var
  fs: TFileStream;
  sch: TSyntaxScheme;
begin
  fs := TFileStream.Create(AFileName, fmOpenRead);
  try
    sch := TSyntaxScheme.Create;
    try
      try
        ReadPersFromTextStream(fs, sch);
        ClearContents;
        Assign(sch);
      except
        MessageDlg(SCantReadSSchemeFrom + SFromFile + ' "' + AFileName + '".',
          mtError, [mbOK], 0);
        raise;
      end;
    finally
      sch.Free;
    end;
  finally
    fs.Free;
  end;
end;

procedure TSyntaxScheme.SaveToFile(const AFileName: string);
var
  fs: TFileStream;
begin
  fs := TFileStream.Create(AFileName, fmCreate);
  try
    WriteObjToTextStream(fs, Self);
  finally
    fs.Free;
  end;
end;

procedure TSyntaxScheme.LoadFromStream(AStream: TStream);
var
  sch: TSyntaxScheme;
  SavePos: integer;
begin
  sch := TSyntaxScheme.Create;
  try
    SavePos := AStream.Position;
    try
      ReadPersFromStream(AStream, sch);
    except
      try
        AStream.Seek(SavePos, soFromBeginning);
        ReadPersFromTextStream(AStream, sch);
      except
        MessageDlg(SCantReadSSchemeFrom + SFromStream + '.', mtError, [mbOK], 0);
        raise;
      end;
    end;
    ClearContents;
    Assign(sch);
  finally
    sch.Free;
  end;
end;

procedure TSyntaxScheme.SaveToStream(AStream: TStream);
begin
  WriteObjToStream(AStream, Self);
end;

procedure TSyntaxScheme.LoadFromResource(const AResName: string);
var
  rs: TResourceStream;
begin
  rs := TResourceStream.Create(HInstance, AResName, RT_RCDATA);
  try
    LoadFromStream(rs);
  finally
    rs.Free;
  end;
end;

{ TSyntaxParser }

constructor TSyntaxParser.Create(AOwner: TComponent);
begin
  inherited;
  FUpdateCount := 0;
  FDefaultAttr := TDefAttrItem.Create2(nil, Self);
  with FDefaultAttr.FFont do
  begin
    Name := DefaultFontName;
    Size := DefaultFontSize;
    OnChange := DefaultAttrChanged;
  end;
  FDefaultAttr.FBackColor := clWindow;
  FSyntaxScheme := TSyntaxScheme.Create;
  FSyntaxScheme.FParser := Self;
  RegisterMemoEnvOptObject(Self);
  if csDesigning in ComponentState then
    InitParser;
end;

destructor TSyntaxParser.Destroy;
begin
  UnRegisterMemoEnvOptObject(Self);
  FSyntaxScheme.Free;
  FDefaultAttr.Free;
  inherited;
end;

procedure TSyntaxParser.Loaded;
begin
  inherited;
  InitParser;
end;

procedure TSyntaxParser.CMUpdateOptions(var Message: TMessage);
begin
  if FSyntaxScheme.FUseGlobalOptions then
    ParserChanged;
end;

procedure TSyntaxParser.ParserChanged;
begin
  if FUpdateCount = 0 then
  begin
    FSyntaxScheme.CreateAttrIDHash;
    Notifiers.NotifyEvents(Self, 0, 0);
  end;
end;

procedure TSyntaxParser.BeginUpdate;
begin
  Inc(FUpdateCount);
end;

procedure TSyntaxParser.EndUpdate;
begin
  Dec(FUpdateCount);
  ParserChanged;
end;

procedure TSyntaxParser.SetSyntaxScheme(Value: TSyntaxScheme);
begin
  if FSyntaxScheme <> Value then
    with FSyntaxScheme do
    begin
      ClearContents;
      Assign(Value);
      InitParser;
    end;
end;

procedure TSyntaxParser.DefaultAttrChanged(Sender: TObject);
begin
  ParserChanged;
end;

procedure TSyntaxParser.SetDefaultAttr(Value: TDefAttrItem);
begin
  FDefaultAttr.Assign(Value);
  DefaultAttrChanged(nil);
end;

function TSyntaxParser.GetUseGlobalOptions: Boolean;
begin
  Result := FSyntaxScheme.FUseGlobalOptions;
end;

procedure TSyntaxParser.SetUseGlobalOptions(Value: Boolean);
begin
  if FSyntaxScheme.FUseGlobalOptions <> Value then
  begin
    FSyntaxScheme.FUseGlobalOptions := Value;
    ParserChanged;
  end;
end;

procedure TSyntaxParser.InitParser;
begin
  FSyntaxScheme.InitScheme;
  FCurStackIndex := SetCurBlock(0, 0);
  FCurDlmtrIndex := 0;
  FCurItemIndex := 0;
  FCurToken := sptText;
  FCurPos := nil;
end;

function TSyntaxParser.SetCurBlock(AIndex, ADirection: integer): integer;

  function CompareStacks(TopBI1, TopBI2: TBlockInfo): Boolean;

    function CompareBI(bi1, bi2: TBlockInfo): Boolean;
    begin
      Result := (bi1.FBlockIndex = bi2.FBlockIndex) and
        (bi1.FDlmtrIndex = bi2.FDlmtrIndex);
    end;

  begin
    while Assigned(TopBI1) and Assigned(TopBI2) do
      if CompareBI(TopBI1, TopBI2) then
      begin
        TopBI1 := TopBI1.FNext;
        TopBI2 := TopBI2.FNext;
      end
      else
        break;
    Result := (TopBI1 = nil) and (TopBI2 = nil);
  end;

var
  oldBI, newBI: TBlockInfo;
  i, newBlockIndex, newDlmtrIndex: integer;
  Found: Boolean;
begin
  //if ADirection > 0 then AIndex = new state, else it is ignored
  with FSyntaxScheme.FBlockStackList do
  begin
    if (ADirection > 0) or (AIndex >= 0) or (AIndex < Count) then
    begin
      Result := AIndex;
      oldBI := TBlockInfo(List[FCurStackIndex]);
      if ADirection > 0 then
      begin //try to find stack of ready child block
        Found := False;
        newBlockIndex := (AIndex shr 8) and $FF;
        newDlmtrIndex := AIndex and $FF;
        for i := 0 to Pred(Count) do
          with TBlockInfo(List[i]) do
            if CompareStacks(oldBI, FNext) and
              (FBlockIndex = newBlockIndex) and (FDlmtrIndex = newDlmtrIndex) then
            begin
              Found := True;
              Result := i;
              break;
            end;
        if not Found then
        begin
          newBI := TBlockInfo.Create(nil, newBlockIndex, newDlmtrIndex);
          Result := Add(newBI);
          while Assigned(oldBI) do
          begin
            with oldBI do
              newBI.FNext := TBlockInfo.Create(nil, FBlockIndex, FDlmtrIndex);
            oldBI := oldBI.FNext;
            newBI := newBI.FNext;
          end;
        end;
      end
      else if ADirection < 0 then
      begin //try to find stack of parent block
        for i := 0 to Pred(Count) do
          if CompareStacks(oldBI.FNext, TBlockInfo(List[i])) then
          begin
            Result := i;
            break;
          end;
      end;
      {else ADirection = 0: just jump to given stack}
    end
    else
      Result := 0; //default block
    with TBlockInfo(List[Result]) do
    begin
      FCurBlockIndex := FBlockIndex;
      FCurBlock := FSyntaxScheme.FSyntaxBlocks[FCurBlockIndex];
      FCurStateIndex := spsNormal;
      with FCurBlock do
      begin
        FCurDlmtrIndex := FDlmtrIndex;
        FCurCaseSensitive := FCaseSensitive;
        if FCurBlockIndex <> 0 then
          FCurPartOfBlockOption := FBlockDelimiters[FCurDlmtrIndex].FDelimitersArePartOfBlock;
      end;
    end;
  end;
end;

function TSyntaxParser.CurPosIsTokenS(const AToken: PChar): Boolean;
begin
  //AToken always points to long string
  //integer((AToken - 4)^) is equivalent to Length(string(AToken))
  Result := StrLComp(FCurPos, AToken, integer((AToken - 4)^)) = 0;
end;

function TSyntaxParser.CurPosIsTokenI(const AToken: PChar): Boolean;
begin
  //AToken always points to long string
  //integer((AToken - 4)^) is equivalent to Length(string(AToken))
  Result := StrLIComp(FCurPos, AToken, integer((AToken - 4)^)) = 0;
end;

function TSyntaxParser.GetFont(AState: integer): TFont;
begin
  with FSyntaxScheme do
    if (AState >= 0) and Assigned(FAttrIDHash[AState]) then
      Result := FAttrIDHash[AState].FUsedFont
    else
      Result := FSubstAttr.FUsedFont;
end;

function TSyntaxParser.GetBackColor(AState: integer; var Color: TColor): boolean;
begin
  Result := True;
  with FSyntaxScheme do
    if (AState >= 0) and Assigned(FAttrIDHash[AState]) then
      Color := FAttrIDHash[AState].FUsedBack
    else
      Color := FSubstAttr.FUsedBack;
end;

function TSyntaxParser._GetAttrID: byte; //internal function
begin
  with FCurBlock do
  begin
    case FCurToken of
      sptCommentSL:
        Result := FSingleLineCommentDelimiters[integer(FSLCIndexList[FCurItemIndex])].FAttrID;
      sptCommentML:
        Result := FMultiLineCommentDelimiters[integer(FMLCIndexList[FCurItemIndex])].FAttrID;
      sptLineDirective:
        if FUseLineDirectives then
          Result := FFIDirective
        else
          Result := FFIText;
      sptCommentFL:
        Result := FFullLineCommentDelimiters[integer(FFLCIndexList[FCurItemIndex])].FAttrID;
      sptStringSL:
        Result := FSingleLineStringDelimiters[integer(FSLSIndexList[FCurItemIndex])].FAttrID;
      sptStringML:
        Result := FMultiLineStringDelimiters[integer(FMLSIndexList[FCurItemIndex])].FAttrID;
      sptIntNumber:
        if FUseNumbers then
          Result := FFIIntNum
        else
          Result := FFIText;
      sptFloatNumber:
        if FUseNumbers then
          Result := FFIFloatNum
        else
          Result := FFIText;
      sptKeyword:
        Result := FKeywordSets.Items[integer(FKWIndexList[FCurItemIndex])].FAttrID;
      sptSymbol:
        if FUseSymbols then
          Result := FFISymbol
        else
          Result := FFIText;
      sptIdentifier:
        if FUseIdentifiers then
          Result := FFIIdentifier
        else
          Result := FFIText;
      sptHexNumber:
        if FUseNumbers then
          Result := FFIHexNum
        else
          Result := FFIText;
    else {sptText}
      Result := FFIText;
    end;
    if Result = byte(-1) then
      Result := FFIText;
  end;
end;

function TSyntaxParser.ColorString(const StrData: string; InitState: Integer;
  var AColorData: string): Integer;
var
  i, j, CurDlmtrLen, cd, cdl: integer;
  cp, cdp, CurTokenPos, CurDlmtr: PChar;
  Proc: TCompareStrProc;
  ReallyBreak, BlockChanged, ChangedInOuter, SkipCheckEnd: Boolean;
  {$IFDEF USEEVENTS}
  PredState: integer;
  FTokenStr {?, FColorData}: string;
  {$ENDIF}

  function FindBlockEnd: Boolean;
  var
    cp: PChar;
  begin
    Result := False;
    if SkipCheckEnd or (FCurBlockIndex = 0) then
      exit;
    cp := FCurPos;
    CurDlmtr := PChar(Pointer(FSyntaxScheme.FSyntaxBlocks[FCurBlockIndex].
      FBlockDelimiters[FCurDlmtrIndex].FRightDelimiter));
    if CurDlmtr <> nil then
    begin
      //CurDlmtr always points to long string
      //integer((CurDlmtr - 4)^) is equivalent to Length(string(CurDlmtr))
      CurDlmtrLen := integer((CurDlmtr - 4)^);
      if FCurPartOfBlockOption then
      begin
        if cp - PChar(Pointer(StrData)) >= CurDlmtrLen then
        begin
          Dec(cp, CurDlmtrLen);
          FCurPos := cp;
          with FCurBlock do
            Result := FCurPosIsToken(CurDlmtr) and
              not ((cp^ in FFirstIdentChars) and ((cp - 1)^ in FOtherIdentChars));
          if Result then
          begin
            FCurStackIndex := SetCurBlock(0, -1);
            ReallyBreak := False;
          end;
          Inc(cp, CurDlmtrLen);
          FCurPos := cp;
        end;
      end
      else
      begin
        if FSyntaxScheme.FSyntaxBlocks[0].FCaseSensitive then
          Proc := CurPosIsTokenS
        else
          Proc := CurPosIsTokenI;
        with FCurBlock do
          Result := Proc(CurDlmtr) and not ((cp^ in FFirstIdentChars) and
            ((cp + CurDlmtrLen)^ in FOtherIdentChars));
        if Result then
        begin
          FCurStackIndex := SetCurBlock(0, -1);
          ReallyBreak := False;
        end;
      end;
    end;
  end;

begin
  if (AColorData = '') or (StrData = '') or (csLoading in ComponentState) then
  begin
    Result := InitState;
    exit;
  end;
  FCurStackIndex := SetCurBlock((InitState shr 24) and $FF, 0);
  FCurPartOfBlockOption := (InitState and $800000) <> 0;
  FCurCaseSensitive := (InitState and $400000) <> 0;
  FCurDlmtrIndex := (InitState shr 16) and $3F;
  FCurStateIndex := (InitState shr 8) and $FF;
  FCurItemIndex := InitState and $FF;
  CanParseLineDirective := True;
  CanParseFullLineComment := True;
  LineDirectiveWasFound := False;
  NeedCloseString := False;
  ReallyBreak := False;
  SkipCheckEnd := False;
  FCurPos := PChar(Pointer(StrData));
  CurTokenPos := FCurPos;
  {$IFDEF USEEVENTS}
  PredState := FCurStateIndex;
  {$ENDIF}

  repeat
    if FCurPos^ <> #0 then //!added line
      FCurToken := sptText;

    if FCurStateIndex = spsNormal then {parse block delimiters}
    begin
      SkipCheckEnd := FindBlockEnd;
      BlockChanged := False;
      ChangedInOuter := False;
      with FCurBlock do
      begin
        for i := 0 to FPredOuterBDCount do
        begin
          CurDlmtr := FOuterBDList.List[i];
          if CurDlmtr <> nil then
          begin
            //CurDlmtr always points to long string
            //integer((CurDlmtr - 4)^) is equivalent to Length(string(CurDlmtr))
            CurDlmtrLen := integer((CurDlmtr - 4)^);
            if FCurPos - PChar(Pointer(StrData)) >= CurDlmtrLen then
            begin
              Dec(FCurPos, CurDlmtrLen);
              if FCurPosIsToken(CurDlmtr) and
                not ((FCurPos^ in FFirstIdentChars) and
                ((FCurPos - 1)^ in FOtherIdentChars)) then
              begin
                j := integer(FOuterIIList.List[i]);
                FCurStackIndex := SetCurBlock(j, 1);
                FCurPartOfBlockOption := (j and $20000) <> 0;
                FCurCaseSensitive := (j and $10000) <> 0;
                FCurDlmtrIndex := j and $FF;
                Inc(FCurPos, CurDlmtrLen);
                BlockChanged := True;
                ChangedInOuter := not FindBlockEnd;
                break;
              end;
              Inc(FCurPos, CurDlmtrLen);
            end;
          end;
        end;
        for i := 0 to FPredInnerBDCount do
        begin
          CurDlmtr := FInnerBDList.List[i];
          if CurDlmtr <> nil then
          begin
            //CurDlmtr always points to long string
            //integer((CurDlmtr - 4)^) is equivalent to Length(string(CurDlmtr))
            CurDlmtrLen := integer((CurDlmtr - 4)^);
            if FCurCaseSensitive then
              Proc := CurPosIsTokenS
            else
              Proc := CurPosIsTokenI;
            if Proc(CurDlmtr) and not ((FCurPos^ in FFirstIdentChars) and
              ((FCurPos + CurDlmtrLen)^ in FOtherIdentChars)) then
            begin
              j := integer(FInnerIIList.List[i]);
              FCurStackIndex := SetCurBlock(j, 1);
              BlockChanged := True;
              FCurPartOfBlockOption := (j and $20000) <> 0;
              FCurCaseSensitive := (j and $10000) <> 0;
              FCurDlmtrIndex := j and $FF;
              break;
            end;
          end;
        end;
      end;
      //try to find end-of-block for each non-default block
      SkipCheckEnd := ChangedInOuter or not BlockChanged and FindBlockEnd;
      if SkipCheckEnd then
        continue;
    end;
    if NeedCloseString then
    begin
      NeedCloseString := False;
      FCurStateIndex := spsNormal;
    end;
    cp := FCurPos;
    ReallyBreak := ReallyBreak or (cp^ = #0);

    if cp^ <> #0 then
    begin
      GetToken;
      cp := FCurPos;
      CanParseLineDirective := CanParseLineDirective and
        (FCurToken <= sptLineDirective);
      CanParseFullLineComment := CanParseFullLineComment and
        (FCurToken = sptText);
      cd := CurTokenPos - PChar(Pointer(StrData)) {+ 1};
      cdl := cp - CurTokenPos;
      cdp := PChar(Pointer(AColorData)) + cd;
      FillChar(cdp^, cdl, _GetAttrID);
      {$IFDEF USEEVENTS}
      {?
      if Assigned(FOnGetColorData) then
      begin
        SetString(FTokenStr, CurTokenPos, cdl);
        FColorData := Copy(AColorData, cd + 1, cdl);
        FOnGetColorData(Self, FCurToken, FTokenStr, FColorData);
        Move(Pointer(FColorData)^, cdp^, cdl);
      end;
      }
      if Assigned(FOnGetToken) then
      begin
        if PredState = 0 then
          SetString(FTokenStr, CurTokenPos, cdl)
        else
          FTokenStr := FTokenStr + Copy(CurTokenPos, 1, cdl);
        if FCurStateIndex = 0 then
          FOnGetToken(Self, FCurToken, FTokenStr);
        PredState := FCurStateIndex;
      end;
      {$ENDIF}
      CurTokenPos := cp;
      FCurPos := cp;
    end
    else if ReallyBreak then
      break
    else
      ReallyBreak := True;
  until False;

  Result := ((FCurStackIndex and $FF) shl 24) + (integer(FCurPartOfBlockOption) shl 23) +
    (integer(FCurCaseSensitive) shl 22) + ((FCurDlmtrIndex and $3F) shl 16) +
    ((FCurStateIndex and $FF) shl 8) + (FCurItemIndex and $FF);
end;

procedure TSyntaxParser.GetToken;
var
  CurDlmtr: string;
  _pos, MetaCount, sLen: integer;
  cp, MetaPos: PChar;
  ums: Boolean;
  ms: char;

begin
  case FCurStateIndex of
    spsStringSL, spsStringML:
      begin
        cp := FCurPos;
        if FCurStateIndex = spsStringSL then
          FCurToken := sptStringSL
        else
          FCurToken := sptStringML;
        with FCurBlock do
        begin
          ums := FUseMetaSymbol;
          ms := FMetaSymbol;
          if FCurStateIndex = spsStringSL then
            CurDlmtr := FSingleLineStringDelimiters[integer(FSLSIndexList[FCurItemIndex])].FRightDelimiter
          else
            CurDlmtr := FMultiLineStringDelimiters[integer(FMLSIndexList[FCurItemIndex])].FRightDelimiter;
          sLen := Length(CurDlmtr);
          _pos := Pos(CurDlmtr, cp);
          MetaPos := PChar(cp + _pos - 2);
        end;
        with FCurBlock do
          if (_pos > 0) and not ((CurDlmtr[1] in FFirstIdentChars) and
            (((cp + _pos + sLen - 1)^ in FOtherIdentChars) or
            ((cp + _pos - 2)^ in FOtherIdentChars))) then
            //check for escape a-la '\"'
            if ums and (_pos > 1) and (MetaPos^ = ms) then
            begin
              MetaCount := 1;
              Dec(MetaPos);
              while (MetaCount < _pos) and (MetaPos^ = ms) do
              begin
                Inc(MetaCount);
                Dec(MetaPos);
              end;
              if (MetaPos <> nil) and Odd(MetaCount) then
              begin
                Inc(cp, _pos);
                //FCurStateIndex changed only if EOL, else skip token like \"
                if cp^ = #0 then
                  FCurStateIndex := spsNormal;
              end
              else
              begin
                FCurStateIndex := spsNormal;
                //jump after string right delimiter
                Inc(cp, _pos + sLen - 1);
              end;
            end
            else
            begin
              FCurStateIndex := spsNormal;
              //jump after string right delimiter
              Inc(cp, _pos + sLen - 1);
            end
          else
          begin
            while cp^ <> #0 do
              Inc(cp);
            //check for '\eol'
            NeedCloseString := (FCurStateIndex = spsStringSL) and
              not (ums and FCurBlock.FUseMetaToWrapLines and (PChar(cp - 1)^ = ms));
            //!FCurStateIndex := spsNormal;
            //break non-closed single-line string at eol
            //else FCurStateIndex not changed
          end;
        FCurPos := cp;
      end;
    spsCommentML:
      begin
        cp := FCurPos;
        FCurToken := sptCommentML;
        with FCurBlock do
          CurDlmtr := FMultiLineCommentDelimiters[integer(FMLCIndexList[FCurItemIndex])].FRightDelimiter;
        sLen := Length(CurDlmtr);
        _pos := Pos(CurDlmtr, cp);
        //if CurDlmtr is identifier then besides itself check 1 char before &
        //1 char after CurDlmtr to avoid
        with FCurBlock do
          if (_pos > 0) and not ((CurDlmtr[1] in FFirstIdentChars) and
            (((cp + _pos + sLen - 1)^ in FOtherIdentChars) or
            ((cp + _pos - 2)^ in FOtherIdentChars))) then
          begin
            //jump after comment right delimiter
            Inc(cp, _pos + sLen - 1);
            if LineDirectiveWasFound and (cp^ <> #0) then
              FCurStateIndex := spsLineDirective
            else
              FCurStateIndex := spsNormal;
          end
          else //FCurState not changed
            while cp^ <> #0 do
              Inc(cp);
        FCurPos := cp;
      end;
    spsLineDirective:
      with FCurBlock do
      begin
        if FUseComments and ParseComment then
          exit;
        cp := FCurPos;
        FCurToken := sptLineDirective;
        Inc(cp);
        //check for '\eol'
        if (cp^ = #0) and not (FUseMetaSymbol and FUseMetaToWrapLines and
          (PChar(cp - 1)^ = FMetaSymbol)) then
          FCurStateIndex := spsNormal;
        //else FCurStateIndex not changed
        FCurPos := cp;
      end;
  else {spsNormal}
    begin
      cp := FCurPos;
      if cp^ < #33 then
      begin
        //FCurState & FCurToken not changed
        while (cp^ > #0) and (cp^ < #33) do
          Inc(cp);
        FCurPos := cp;
        exit;
      end;

      //skip all non-used symbols
      if cp^ in FSyntaxScheme.FNotUsedChars then
      begin
        //FCurState not changed
        FCurToken := sptSymbol;
        while cp^ in FSyntaxScheme.FNotUsedChars do
          Inc(cp);
        FCurPos := cp;
        exit;
      end;

      FCurPos := cp;

      if FCurBlock.FUseComments and ParseComment then
        exit;

      if FCurBlock.FUseStrings and ParseString then
        exit;

      if FCurBlock.FUseNumbers then
      begin
        if ParsePSNumber then //check for ps-numbers should be before int & float
          exit;
        if ParseFloatNumber then
          exit;
        //integers are parsed within ParseFloatNumber
      end
      else if ParseIntNumber then
        //skip sequences of digits
      begin
        FCurToken := sptIntNumber;
        exit
      end;

      if FCurBlock.FUseLineDirectives and CanParseLineDirective and ParseLineDirective then
        exit;

      if ParseIdentifiers then //identifiers are parsed always
        exit;

      cp := FCurPos;
      if cp^ in cSySymbolChars then //symbols are parsed always
      begin
        //FCurState not changed
        FCurToken := sptSymbol;
        Inc(cp);
        FCurPos := cp;
        exit;
      end;

      //else -> sptText
      Inc(cp);
      FCurPos := cp;
    end;
  end;
end;

function TSyntaxParser.ParseComment: Boolean;
var
  i, sLen: integer;
  cp, s: PChar;
begin
  Result := False;
  with FCurBlock do
  begin
    //parse multi-line comments
    if FUseMultiLineComments then
      for i := 0 to FPredMLCCount do
      begin
        s := FMLCList.List[i];
        //s points to long string
        //integer((s - 4)^) is equivalent to Length(string(s))
        sLen := integer((s - 4)^);
        cp := FCurPos;
        with FCurBlock do
          if FCurPosIsToken(s) and not ((cp^ in FFirstIdentChars) and
            ((cp + sLen)^ in FOtherIdentChars)) then
          begin
            FCurToken := sptCommentML;
            FCurStateIndex := spsCommentML;
            FCurItemIndex := i;
            Inc(cp, sLen);
            FCurPos := cp;
            Result := True;
            exit;
          end;
      end;
    //parse full-line comments
    if FUseFullLineComments and CanParseFullLineComment then
      for i := 0 to FPredFLCCount do
      begin
        s := FFLCList.List[i];
        //s points to long string
        //integer((s - 4)^) is equivalent to Length(string(s))
        sLen := integer((s - 4)^);
        cp := FCurPos;
        with FCurBlock do
          if FCurPosIsToken(s) and not ((cp^ in FFirstIdentChars) and
            ((cp + sLen)^ in FOtherIdentChars)) then
          begin
            FCurToken := sptCommentFL;
            //FCurStateIndex := spsNormal;
            FCurItemIndex := i;
            while cp^ <> #0 do
              Inc(cp);
            FCurPos := cp;
            Result := True;
            exit;
          end;
      end;
    //parse single-line comments
    if FUseSingleLineComments then
      for i := 0 to FPredSLCCount do
      begin
        s := FSLCList.List[i];
        //s points to long string
        //integer((s - 4)^) is equivalent to Length(string(s))
        sLen := integer((s - 4)^);
        cp := FCurPos;
        with FCurBlock do
          if FCurPosIsToken(s) and not ((cp^ in FFirstIdentChars) and
            ((cp + sLen)^ in FOtherIdentChars)) then
          begin
            FCurToken := sptCommentSL;
            FCurStateIndex := spsNormal; //to break directive
            FCurItemIndex := i;
            while cp^ <> #0 do
              Inc(cp);
            FCurPos := cp;
            Result := True;
            exit;
          end;
      end;
  end;
end;

function TSyntaxParser.ParseLineDirective: Boolean;
begin
  with FCurBlock do
  begin
    Result := FCurPosIsToken(PChar(Pointer(FLineDirectivePrefix)));
    if Result then
    begin
      Inc(FCurPos, Length(FLineDirectivePrefix));
      LineDirectiveWasFound := True;
      FCurToken := sptLineDirective;
      if FCurPos^ <> #0 then
        FCurStateIndex := spsLineDirective;
    end;
  end;
end;

function TSyntaxParser.ParseString: Boolean;
var
  i, sLen: integer;
  cp, s: PChar;
begin
  Result := False;
  with FCurBlock do
  begin
    //parse multi-line strings
    if FUseMultiLineStrings then
      for i := 0 to FPredMLSCount do
      begin
        s := FMLSList.List[i];
        //s points to long string
        //integer((s - 4)^) is equivalent to Length(string(s))
        sLen := integer((s - 4)^);
        cp := FCurPos;
        with FCurBlock do
          if FCurPosIsToken(s) and not ((cp^ in FFirstIdentChars) and
            ((cp + sLen)^ in FOtherIdentChars)) then
          begin
            FCurToken := sptStringML;
            FCurStateIndex := spsStringML;
            FCurItemIndex := i;
            Inc(cp, sLen);
            FCurPos := cp;
            Result := True;
            exit;
          end;
      end;
    //parse single-line strings
    if FUseSingleLineStrings then
      for i := 0 to FPredSLSCount do
      begin
        s := FSLSList.List[i];
        //s points to long string
        //integer((s - 4)^) is equivalent to Length(string(s))
        sLen := integer((s - 4)^);
        cp := FCurPos;
        with FCurBlock do
          if FCurPosIsToken(s) and not ((cp^ in FFirstIdentChars) and
            ((cp + sLen - 1)^ in FOtherIdentChars) and
            ((cp + sLen)^ in FOtherIdentChars)) then
          begin
            FCurToken := sptStringSL;
            FCurItemIndex := i;
            Inc(cp, sLen);
            if cp^ <> #0 then
              FCurStateIndex := spsStringSL;
            //else FCurStateIndex not changed
            FCurPos := cp;
            Result := True;
            exit;
          end;
      end;
  end;
end;

{
 IntNumber - simple decimal
 FloatNumber - floats in general & scientific form
 PrefixedNumber, SuffixedNumber & PrefixedSuffixedNumber - hexadecimal or float
}

function TSyntaxParser.ParseIntNumber: Boolean;
var
  cp: PChar;
begin
  //?hard coded charset -> cDigits: TCharSet = ['0'..'9'];
  cp := FCurPos;
  Result := cp^ in ['0'..'9'];
  if Result then
  begin
    while cp^ in ['0'..'9'] do
      Inc(cp);
    FCurPos := cp;
    FCurToken := sptIntNumber;
  end;
end;

function TSyntaxParser.ParseFloatNumber: Boolean;
var
  FloatFound: Boolean;
  cp, SavePos: PChar;
begin
  Result := ParseIntNumber;
  if Result then
  begin
    FloatFound := False;
    if FCurPos^ = '.' then
    begin
      Result := True;
      Inc(FCurPos);
      ParseIntNumber;
      FloatFound := True;
    end;
    cp := FCurPos;
    if (cp^ = 'e') or (cp^ = 'E') then
    begin
      SavePos := cp;
      Inc(cp);
      if (cp^ = '-') or (cp^ = '+') then
        Inc(cp);
      FCurPos := cp;
      if ParseIntNumber then
        FloatFound := True
      else
        FCurPos := SavePos;
    end;
    if FloatFound then
      FCurToken := sptFloatNumber
    else
      FCurToken := sptIntNumber;
  end;
end;

function TSyntaxParser.ParsePSNumber: Boolean;
var
  StartPos, SavePos, pc: PChar;
  i: integer;

  function ParseHexNumber: Boolean;
  var
    cp: PChar;
  begin
    cp := FCurPos;
    Result := cp^ in cSyHexDigits;
    if Result then
    begin
      while cp^ in cSyHexDigits do
        Inc(cp);
      FCurToken := sptHexNumber;
    end;
    FCurPos := cp;
  end;

  function ParseNumPrefix: Boolean; //parse prefix & following number
  var
    i: integer;
    b: Boolean;
  begin
    with FCurBlock do
      for i := 0 to FPredPNCount do
      begin
        pc := FPNList.List[i];
        Result := (pc <> nil) and FCurPosIsToken(pc);
        if Result then
        begin
          //pc points to long string
          //integer((pc - 4)^) is equivalent to Length(string(pc))
          Inc(FCurPos, integer((pc - 4)^));
          b := ParseFloatNumber;
          if b then
          begin
            if FCurToken = sptIntNumber then
              ParseHexNumber;
          end
          else
            b := ParseHexNumber;
          if b then
          begin
            FCurStateIndex := spsNormal;
            FCurItemIndex := i;
          end
          else
            FCurToken := sptSymbol;
          exit;
        end;
      end;
    Result := False;
  end;

  function ParseNumSuffix: Boolean; //parse suffix only
  var
    i: integer;
  begin
    Result := False;
    with FCurBlock do
      for i := 0 to FPredSNCount do
      begin
        pc := FSNList.List[i];
        if (pc <> nil) and FCurPosIsToken(pc) then
        begin
          FCurStateIndex := spsNormal;
          FCurItemIndex := i;
          //pc points to long string
          //integer((pc - 4)^) is equivalent to Length(string(pc))
          Inc(FCurPos, integer((pc - 4)^));
          Result := True;
          exit;
        end;
      end;
  end;

begin
  StartPos := FCurPos;
  with FCurBlock do
    if FUsePrefixedSuffixedNumbers then
      if FUsePSNumComposition then
      begin //parse prefix, then number, then suffix(es)
        if ParseNumPrefix then
        begin
          if ParseNumSuffix then
            if FCurBlock.FUseMultipleNumSuffixes then
              while ParseNumSuffix do {nothing}
                ;
          Result := True;
          exit;
        end;
      end
      else
        with FNumPrefixesSuffixes do //parse prefixed & suffixed numbers
          for i := 0 to Pred(Count) do
          begin
            pc := PChar(Pointer(Items[i].FLeftDelimiter));
            Result := (pc <> nil) and FCurPosIsToken(pc);
            if Result then
            begin
              SavePos := FCurPos;
              //pc points to long string
              //integer((pc - 4)^) is equivalent to Length(string(pc))
              Inc(FCurPos, integer((pc - 4)^));
              if ParseHexNumber then //only ints & hex can be PS
              begin
                pc := PChar(Pointer(Items[i].FRightDelimiter));
                if (pc <> nil) and FCurPosIsToken(pc) then
                begin
                  FCurStateIndex := spsNormal;
                  FCurItemIndex := i;
                  //pc points to long string
                  //integer((pc - 4)^) is equivalent to Length(string(pc))
                  Inc(FCurPos, integer((pc - 4)^));
                  exit;
                end
                else
                  FCurPos := SavePos;
              end
              else
                FCurPos := SavePos;
            end;
          end;

  with FCurBlock do
    if not (FUsePrefixedSuffixedNumbers and FUsePSNumComposition)
      and FUsePrefixedNumbers then //parse prefixed numbers
    begin
      Result := ParseNumPrefix;
      if Result then
        exit;
    end;

  if FCurBlock.FUseSuffixedNumbers then
  begin //parse suffixed numbers
    Result := FCurPos^ in ['0'..'9'];
    if Result then
      ParseFloatNumber //only ints & floats can be suffixes
    else
      exit;
    if ParseNumSuffix then
    begin
      if FCurBlock.FUseMultipleNumSuffixes then
        while ParseNumSuffix do {nothing}
          ;
      exit;
    end;
  end;

  FCurPos := StartPos;
  Result := False;
end;

function TSyntaxParser.ParseIdentifiers: Boolean;
var
  StartPos, SavePos, pc: PChar;
  i: integer;

  function ParseIdent: Boolean;
  var
    cp: PChar;
    oic: TCharSet;
  begin
    cp := FCurPos;
    with FCurBlock do
    begin
      Result := cp^ in FFirstIdentChars;
      oic := FOtherIdentChars;
      if Result then
        repeat
          Inc(cp);
        until not (cp^ in oic);
    end;
    FCurPos := cp;
  end;

  function ParseKeywords: Boolean;
  var
    curKW: string;
    i: integer;
    pc: PChar;
  begin
    Result := False;
    //following lines are equivalent to
    //curKW := cKeywordsSeparator + Copy(StartPos, 1, FCurPos - StartPos) + cKeywordsSeparator;
    //but more quickly
    i := FCurPos - StartPos;
    SetLength(curKW, i + 2);
    pc := Pointer(curKW);
    pc^ := cKeywordsSeparator;
    Inc(pc);
    Move(StartPos^, pc^, i);
    Inc(pc, i);
    pc^ := cKeywordsSeparator;

    with FCurBlock do
    begin
      if not FCaseSensitive then
        CharLowerBuff(Pointer(curKW), i + 2);
      for i := 0 to FPredKWCount do
        if Pos(curKW, StrArray(FKWList.List[i]^)[byte(curKW[2])]) > 0 then
        begin
          FCurToken := sptKeyword;
          FCurStateIndex := spsNormal;
          FCurItemIndex := i;
          Result := True;
          exit;
        end;
    end;
  end;

begin
  { try to parse identifier with all possible prefixes, suffixes or both;
    then, if need, check obtained ident for is it keyword }
  Result := False;
  StartPos := FCurPos;
  with FCurBlock do
  try
    if FUsePrefixedSuffixedIdentifiers then
      with FIdentPrefixesSuffixes do //parse prefixed & suffixed identifiers
        for i := 0 to Pred(Count) do
        begin
          pc := PChar(Pointer(Items[i].FLeftDelimiter));
          Result := (pc <> nil) and FCurPosIsToken(pc);
          if Result then
          begin
            SavePos := FCurPos;
            //pc points to long string
            //integer((pc - 4)^) is equivalent to Length(string(pc))
            Inc(FCurPos, integer((pc - 4)^));
            if ParseIdent then
            begin
              pc := PChar(Pointer(Items[i].FRightDelimiter));
              if (pc <> nil) and FCurPosIsToken(pc) then
              begin
                FCurItemIndex := i;
                //pc points to long string
                //integer((pc - 4)^) is equivalent to Length(string(pc))
                Inc(FCurPos, integer((pc - 4)^));
                exit;
              end
              else
                FCurPos := SavePos;
            end
            else
              FCurPos := SavePos;
          end;
        end;

    if FUsePrefixedIdentifiers then //parse prefixed identifiers
      for i := 0 to FPredPICount do
      begin
        pc := FPIList.List[i];
        if (pc <> nil) and FCurPosIsToken(pc) then
        begin
          //pc points to long string
          //integer((pc - 4)^) is equivalent to Length(string(pc))
          Inc(FCurPos, integer((pc - 4)^));
          Result := ParseIdent;
          if Result then
          begin
            FCurItemIndex := i;
            exit;
          end
          else
            FCurToken := sptSymbol;
        end;
      end;

    Result := ParseIdent; //parse simple identifiers

    //try parse suffixed identifiers, if fail then simple ident already found
    if FUseSuffixedIdentifiers then
      for i := 0 to FPredSICount do
      begin
        pc := FSIList.List[i];
        if (pc <> nil) and FCurPosIsToken(pc) then
        begin
          FCurItemIndex := i;
          //pc points to long string
          //integer((pc - 4)^) is equivalent to Length(string(pc))
          Inc(FCurPos, integer((pc - 4)^));
          exit;
        end;
      end;
  finally
    if Result then
    begin
      if not (FUseKeywords and ParseKeywords) then
      begin
        FCurToken := sptIdentifier;
        FCurStateIndex := spsNormal;
      end;
    end
    else
      FCurPos := StartPos;
  end;
end;

{ Global procedures & functions }

type
  T_MemoSource = class(TCustomMemoSource)
  end;

function GetItemInfoAt(AMemo: TDCMemo; Point: TPoint): TSyntaxItemInfo;
var
  StrData, ColorData: string;
  InitState: integer;
begin
  with Result do
  begin
    Block := nil;
    Attribute := nil;
    ItemType := sptText;
    ItemSet := nil;
  end;
  if Assigned(AMemo) then
    with AMemo do
    begin
      if Point.Y >= Lines.Count then
        exit;
      if Assigned(SyntaxParser) and SyntaxParser.InheritsFrom(TSyntaxParser) then
      begin
        StrData := Copy(Lines[Point.y], 1, Point.x);
        InitState := T_MemoSource(GetSource).StringItem[Point.y].ParserState;
        with TSyntaxParser(SyntaxParser) do
        begin
          if StrData <> '' then
          begin
            ColorData := StrData;
            UniqueString(ColorData);
            SyntaxParser.ColorString(StrData, InitState, ColorData);
            with Result do
            begin
              Attribute := FSyntaxScheme.FAttrTable.GetItemByID(_GetAttrID);
              ItemType := FCurToken;
              with FCurBlock do
                case ItemType of
                  sptCommentSL: ItemSet := FSingleLineCommentDelimiters[integer(FSLCIndexList[FCurItemIndex])];
                  sptCommentML: ItemSet := FMultiLineCommentDelimiters[integer(FMLCIndexList[FCurItemIndex])];
                  sptCommentFL: ItemSet := FFullLineCommentDelimiters[integer(FFLCIndexList[FCurItemIndex])];
                  sptStringSL: ItemSet := FSingleLineStringDelimiters[integer(FSLSIndexList[FCurItemIndex])];
                  sptStringML: ItemSet := FMultiLineStringDelimiters[integer(FMLSIndexList[FCurItemIndex])];
                  sptKeyword: ItemSet := FKeywordSets[integer(FKWIndexList[FCurItemIndex])];
                end;
            end;
          end
          else
          begin
            TSyntaxParser(SyntaxParser).SetCurBlock((InitState shr 24) and $FF, 0);
            Result.ItemType := sptText;
          end;
          Result.Block := FCurBlock;
        end;
      end;
    end;
end;

function GetSyntaxBlockAt(AMemo: TDCMemo; APoint: TPoint): TSyntaxBlock;
begin
  Result := GetItemInfoAt(AMemo, APoint).Block;
end;

function GetSyntaxBlockAtCursor(AMemo: TDCMemo): TSyntaxBlock;
begin
  Result := GetItemInfoAt(AMemo, AMemo.CaretPoint).Block;
end;

function StringToCharSet(const Str: string): TCharSet;
var
  i: integer;
  c, l: char;
begin
  Result := [];
  c := #0;
  i := 1;
  while i <= Length(Str) do
  begin
    case Str[i] of
      '\':
        begin
          Inc(i);
          c := Str[i];
          Include(Result, c);
        end;
      '-':
        begin
          Inc(i);
          for l := c to Str[i] do
            Include(Result, l);
        end;
    else
      begin
        c := Str[i];
        Include(Result, c);
      end;
    end;
    Inc(i);
  end;
end;

function CharSetToString(const CSet: TCharSet): string;
var
  l, c: char;
begin
  Result := '';
  l := #0;
  while l <= #255 do
  begin
    if l in CSet then
    begin
      if (l = '\') or (l = '-') then
        Result := Result + '\' + l
      else
        Result := Result + l;
      c := l;
      while l in CSet do
      begin
        Inc(l);
        if l = #0 then
          break;
      end;
      if Pred(l) <> c then
        Result := Result + '-' + Pred(l);
    end
    else
      Inc(l);
    if l = #0 then
      break;
  end;
end;

{
Bit-structure of InitState:
  0..7 - CurItem (index of token from list (comments, strings, etc.))
  8..15 - CurState (code of token)
  16..21 - CurDlmtr (index of delimiters pair of current block)
  22 - CaseSensitive (of current block)
  23 - ArePartOfBlock (whether current dlmtr pair is part of current block)
  24..31 - CurStack (index of current stack used)

Bit-structure of Index-list:
  0..7 - index of delimiters pair of block
  8..15 - index of block
  16 - FCaseSensitive of block
  17 - FDelimitersArePartOfBlock of delimiters pair
  18..31 - reserved
}

end.
