{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcexport;

interface
{$I dc.inc}
uses
  {$IFNDEF CLX}
  windows, graphics,
  {$ELSE}
  QGraphics,
  {$ENDIF}
  classes, sysutils, dcsystem, dcdreamlib, dcparser;

type
  TWindowStyle = (wsDefault , wsPopup, wsSecondary);
  TParagraphAlign = (paLeft,paCenter,paRight,paJustify);
  TTableFrame = (tfvoid,tfabove,tfbelow,tfhsides,tflhs,tfrhs,tfvsides,tfbox,tfborder);
  TTableRules = (trnone,trgroups,trrows,trcols,trall);
  TTableParams = record
    width       : integer;
    border      : integer;
    frame       : TTableFrame;
    rules       : TTableRules;
    cellspacing : integer;
    cellpadding : integer;
  end;

  {$IFDEF D3}
  IDCExporter =  interface
  ['{4E99D241-6E79-11D2-812C-0000E8DA6AC4}']
    procedure WriteString(const S : string);
    function  TranslateString(const S : string) : string;

    procedure StartParagraph(Align : TParagraphAlign);
    procedure FinishParagraph;

    procedure StartNonScrolledArea;
    procedure FinishNonScrolledArea;

    procedure NewLine;

    procedure StartFont(const FontName : string);
    procedure StartFontWithCharSet(const FontName : string; CharSet : TFontCharSet);

    procedure FinishFont;

    procedure StartBigFont;
    procedure FinishBigFont;

    procedure StartSmallFont;
    procedure FinishSmallFont;

    procedure StartFontSize(Size : integer);
    procedure FinishFontSize;

    procedure StartItalic;
    procedure FinishItalic;

    procedure StartBold;
    procedure FinishBold;

    procedure StartUnderline;
    procedure FinishUnderline;

    procedure StartStrikeOut;
    procedure FinishStrikeOut;
    
    procedure StartNumberedList;
    procedure FinishNumberedList;

    procedure StartBulletedList;
    procedure FinishBulletedList;

    procedure StartBulletListItem ;
    procedure FinishBulletListItem ;

    procedure StartNumberedListItem ;
    procedure FinishNumberedListItem ;

    procedure StartQuote;
    procedure FinishQuote;

    procedure StartSubScript;
    procedure FinishSubScript;

    procedure StartSuperScript;
    procedure FinishSuperScript;

    procedure StartColor(Color : TColor);
    procedure FinishColor;

    procedure StartBackground(Color : TColor);
    procedure FinishBackground;

    procedure StartBackColor(Color : TColor);
    procedure FinishBackColor;

    procedure StartHRef(const Reference : string; Style : TWindowStyle);
    procedure FinishHRef;

    procedure StartTable (const Params : TTableParams);
    procedure FinishTable;

    procedure StartTableRow;
    procedure FinishTableRow;

    procedure StartTableDataCell(width : integer);
    procedure FinishTableDataCell;

    procedure StartDocument(const Title : string);
    procedure FinishDocument;

    procedure StartPage(const Title : string);
    procedure FinishPage;

    procedure AddSpaces(count : integer);
    procedure AddImage(const ImageName : string ; Width , Height : integer);
    function  UseTabCharacter : boolean;

    procedure DrawHorzLine;
    procedure WriteExternalURL( const Caption, URL : string );
  end;
  {$ENDIF}

  TDCExporter = class {$IFDEF D3}(TInterfacedObject,IDCExporter) {$ENDIF}
  private
    FParSpaceBefore : integer;
    FParSpaceAfter  : integer;
  protected
    FStream : TStream;
  public
    constructor Create(Stream : TStream); virtual;
    procedure WriteString(const S : string); virtual;

    function  TranslateString(const S : string) : string; virtual; abstract;

    procedure StartParagraph(Align : TParagraphAlign); virtual; abstract;
    procedure FinishParagraph; virtual; abstract;

    procedure StartNonScrolledArea; virtual; abstract;
    procedure FinishNonScrolledArea; virtual; abstract;

    procedure NewLine; virtual; abstract;

    procedure StartFont(const FontName : string); virtual; abstract;
    procedure StartFontWithCharSet(const FontName : string; CharSet : TFontCharSet); virtual; abstract;

    procedure FinishFont; virtual; abstract;

    procedure StartBigFont; virtual; abstract;
    procedure FinishBigFont; virtual; abstract;

    procedure StartSmallFont; virtual; abstract;
    procedure FinishSmallFont; virtual; abstract;

    procedure StartFontSize(Size : integer); virtual; abstract;
    procedure FinishFontSize; virtual; abstract;

    procedure StartItalic; virtual; abstract;
    procedure FinishItalic; virtual; abstract;

    procedure StartBold; virtual; abstract;
    procedure FinishBold; virtual; abstract;

    procedure StartUnderline; virtual; abstract;
    procedure FinishUnderline; virtual; abstract;

    procedure StartStrikeOut; virtual; abstract;
    procedure FinishStrikeOut; virtual; abstract;

    procedure StartNumberedList; virtual; abstract;
    procedure FinishNumberedList; virtual; abstract;

    procedure StartBulletedList; virtual; abstract;
    procedure FinishBulletedList; virtual; abstract;

    procedure StartBulletListItem ; virtual; abstract;
    procedure FinishBulletListItem ; virtual; abstract;

    procedure StartNumberedListItem ; virtual; abstract;
    procedure FinishNumberedListItem ; virtual; abstract;

    procedure StartQuote; virtual; abstract;
    procedure FinishQuote; virtual; abstract;

    procedure StartSubScript; virtual; abstract;
    procedure FinishSubScript; virtual; abstract;

    procedure StartSuperScript; virtual; abstract;
    procedure FinishSuperScript; virtual; abstract;

    procedure StartColor(Color : TColor); virtual; abstract;
    procedure FinishColor; virtual; abstract;

    procedure StartBackground(Color : TColor); virtual; abstract;
    procedure FinishBackground; virtual; abstract;

    procedure StartBackColor(Color : TColor);virtual; abstract;
    procedure FinishBackColor; virtual; abstract;

    procedure StartHRef(const Reference : string; Style : TWindowStyle); virtual; abstract;
    procedure FinishHRef; virtual; abstract;

    procedure StartTable (const Params : TTableParams); virtual; abstract;
    procedure FinishTable; virtual; abstract;

    procedure StartTableRow; virtual; abstract;
    procedure FinishTableRow; virtual; abstract;

    procedure StartTableDataCell(width : integer); virtual; abstract;
    procedure FinishTableDataCell; virtual; abstract;

    procedure StartDocument(const Title : string); virtual; abstract;
    procedure FinishDocument; virtual; abstract;

    procedure StartPage(const Title : string); virtual; abstract;
    procedure FinishPage; virtual; abstract;

    procedure AddSpaces(count : integer); virtual; abstract;
    procedure AddImage(const ImageName : string ; Width , Height : integer); virtual; abstract;

    function  UseTabCharacter : boolean; virtual; abstract;

    procedure DrawHorzLine; virtual; abstract;
    procedure WriteExternalURL( const Caption, URL : string ); virtual; abstract;

    Property ParSpaceBefore : integer Read FParSpaceBefore Write FParSpaceBefore;
    Property ParSpaceAfter  : integer Read FParSpaceAfter  Write FParSpaceAfter;
  end;

  TDCExporterClass=Class Of TDCExporter;

  TDCHTMLExporter = class(TDCExporter)
  private
    FLastTag : string;
    procedure BeginComplexTag(const Tag , S : string);
    procedure BeginTagWithLine(const Tag : string);
  protected
    procedure BeginTag(const Tag : string);
    procedure EndTag(const Tag : string);
    procedure BeginTagEx(const Tag : string ; const Names,Values : Array of string);
  public
    function  TranslateString(const S : string): string; override;

    procedure StartParagraph(Align : TParagraphAlign); override;
    procedure FinishParagraph; override;

    procedure StartNonScrolledArea; override;
    procedure FinishNonScrolledArea; override;

    procedure NewLine; override;

    procedure StartFont(const FontName : string); override;
    procedure StartFontWithCharSet(const FontName : string; CharSet : TFontCharSet); override;

    procedure FinishFont; override;

    procedure StartBigFont; override;
    procedure FinishBigFont; override;

    procedure StartSmallFont; override;
    procedure FinishSmallFont; override;

    procedure StartFontSize(Size : integer); override;
    procedure FinishFontSize; override;

    procedure StartItalic; override;
    procedure FinishItalic; override;

    procedure StartBold; override;
    procedure FinishBold; override;

    procedure StartUnderline; override;
    procedure FinishUnderline; override;

    procedure StartStrikeOut; override;
    procedure FinishStrikeOut; override;


    procedure StartNumberedList; override;
    procedure FinishNumberedList; override;

    procedure StartBulletedList; override;
    procedure FinishBulletedList; override;

    procedure StartBulletListItem ; override;
    procedure FinishBulletListItem ; override;

    procedure StartNumberedListItem ; override;
    procedure FinishNumberedListItem ; override;

    procedure StartQuote; override;
    procedure FinishQuote; override;

    procedure StartSubScript; override;
    procedure FinishSubScript; override;

    procedure StartSuperScript; override;
    procedure FinishSuperScript; override;

    procedure StartColor(Color : TColor); override;
    procedure FinishColor; override;

    procedure StartBackground(Color : TColor); override;
    procedure FinishBackground; override;

    procedure StartBackColor(Color : TColor); override;
    procedure FinishBackColor; override;

    procedure StartHRef(const Reference : string; Style : TWindowStyle); override;
    procedure FinishHRef; override;

    procedure StartTable (const Params : TTableParams); override;
    procedure FinishTable; override;

    procedure StartTableRow; override;
    procedure FinishTableRow; override;

    procedure StartTableDataCell(width : integer); override;
    procedure FinishTableDataCell; override;

    procedure StartDocument(const Title : string); override;
    procedure FinishDocument; override;

    procedure StartPage(const Title : string); override;
    procedure FinishPage; override;

    procedure AddImage(const ImageName : string ; Width , Height : integer); override;
    procedure AddSpaces(count : integer); override;

    function  UseTabCharacter : boolean; override;

    procedure DrawHorzLine; override;
    procedure WriteExternalURL( const Caption, URL : string ); override;
  end;

  THTMLExporter = class(TDCHTMLExporter)
  public
    destructor Destroy; override;
  end;

  TRTFWriterList = class;
  TRTFWriterListClass = class of TRTFWriterList;

  TDCRTFExporter = class(TDCExporter)
  private
    fsize         : integer;
    FReference    : string;
    FStyle        : TWindowStyle;
    procedure StartListItem;
  protected
    FWriterList   : TRTFWriterList;
    procedure BeginTag(const Tag : string);
    procedure EndTag(const Tag : string);
    procedure WriteTag(const Tag : string);
    function  GetRTFWriterClass : TRTFWriterListClass; virtual;
  public

    procedure StartParagraph(Align : TParagraphAlign); override;
    procedure FinishParagraph; override;

    procedure StartNonScrolledArea; override;
    procedure FinishNonScrolledArea; override;

    procedure NewLine; override;

    procedure StartFont(const FontName : string); override;
    procedure StartFontWithCharSet(const FontName : string; CharSet : TFontCharSet); override;
    procedure FinishFont; override;

    procedure StartBigFont; override;
    procedure FinishBigFont; override;

    procedure StartSmallFont; override;
    procedure FinishSmallFont; override;

    procedure StartFontSize(Size : integer); override;
    procedure FinishFontSize; override;

    procedure StartItalic; override;
    procedure FinishItalic; override;

    procedure StartBold; override;
    procedure FinishBold; override;

    procedure StartUnderline; override;
    procedure FinishUnderline; override;

    procedure StartStrikeOut; override;
    procedure FinishStrikeOut; override;

    procedure StartNumberedList; override;
    procedure FinishNumberedList; override;

    procedure StartBulletedList; override;
    procedure FinishBulletedList; override;

    procedure StartBulletListItem ; override;
    procedure FinishBulletListItem ; override;

    procedure StartNumberedListItem ; override;
    procedure FinishNumberedListItem ; override;

    procedure StartQuote; override;
    procedure FinishQuote; override;

    procedure StartSubScript; override;
    procedure FinishSubScript; override;

    procedure StartSuperScript; override;
    procedure FinishSuperScript; override;

    procedure StartColor(Color : TColor); override;
    procedure FinishColor; override;
    
    procedure StartBackground(Color : TColor); override;
    procedure FinishBackground; override;

    procedure StartBackColor(Color : TColor); override;
    procedure FinishBackColor; override;

    procedure StartHRef(const Reference : string; Style : TWindowStyle); override;
    procedure FinishHRef; override;

    procedure StartTable (const Params : TTableParams); override;
    procedure FinishTable; override;

    procedure StartTableRow; override;
    procedure FinishTableRow; override;

    procedure StartTableDataCell(width : integer); override;
    procedure FinishTableDataCell; override;

    procedure StartDocument(const Title : string); override;
    procedure FinishDocument; override;

    procedure StartPage(const Title : string); override;
    procedure FinishPage; override;

    procedure AddSpaces(count : integer); override;
    procedure AddImage(const ImageName : string ; Width , Height : integer); override;

    function  UseTabCharacter : boolean; override;

    procedure DrawHorzLine; override;
    procedure WriteExternalURL( const Caption, URL : string ); override;

    procedure WriteString(const S : string);  override;
    function  TranslateString(const S : string): string; override;

    constructor Create (Stream: TStream); override;
    destructor Destroy ; override;
  end;

{------------------------------------------------------------------}

  {$IFDEF D3}
  IDCSectionWriter =  interface
  ['{A37E75B1-7A0E-11D2-813D-0000E8DA6AC4}']
    procedure StartSection(const Section , URL :string);
    procedure FinishSection;
  end;                         

  TDCSectionKind = ( skTitle, skClassesGroup, skInterfacesGroup, skTypesGroup,
                     skProceduresGroup, {skVariableGroup, }skUnitsGroup, skUnitHeader, skAuxiliaryGroup, skIndex,
                     skClass, skInterface, skType, skProcedure,
                     skVariable, skUnit, skMethod, skProperty, skEvent,
                  {- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
                     skCategorySectionClass, skCategoryGroupSectionIntf,
                     skCategoryGroupSectionType, skCategoryGroupSectionProc,
                     skCategoryGroupSectionVar, skSubCategorySection, skDefCategorySection,
                  {- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
                     skUserDefinedGroup, skUserDefinedNode, skVariableGroup );

  IDCSectionWriterEx = interface( IDCSectionWriter )
  ['{7810CEA1-FCF9-11D3-A1FD-444553540000}']
    procedure StartSectionEx( const Section, URL : string; SectionKind : TDCSectionKind;
                              const AUnit, ADeclaration : string );
  end;
  {$ENDIF}

{------------------------------------------------------------------}

  THTMLContentWriter = class(TDCHTMLExporter{$IFDEF D3} , IDCSectionWriterEx {$ENDIF})
  public
    constructor Create (Stream: TStream); override;
    destructor Destroy ; override;
    procedure StartSection(const Section , URL :string);
    procedure StartSectionEx( const Section, URL : string; SectionKind : TDCSectionKind;
                               const AUnit, ADeclaration : string );
    procedure FinishSection;
  end;

  TRTFContentWriter = class {$IFDEF D3}(TInterfacedObject , IDCSectionWriterEx) {$ENDIF}
  private
    FCounter  : integer;
    FStream   : TStream;
    FWriter   : TDCRTFExporter;
  public
    constructor Create(Writer : TDCRTFExporter; Stream : TStream);
    destructor  Destroy ; override;
    procedure StartSection(const Section , URL :string);
    procedure StartSectionEx( const Section , URL :string; SectionKind : TDCSectionKind;
                              const AUnit, ADeclaration : string);
    procedure FinishSection;
  end;


  THTMLIndexWriter = class(TDCHTMLExporter {$IFDEF D3} ,IDCSectionWriter {$ENDIF})
  private
    FIndexList : TStringList;
    FSections  : TStrings;
    FCurrentlevel : integer;
    procedure SetCurrentLevel(Section : string);
    procedure Flush;
    function  CurrentSection : string;
  public
    constructor Create (Stream: TStream);override;
    destructor  Destroy ; override;
    procedure   StartSection(const Section , URL :string);
    procedure   FinishSection;
  end;

  TRTFIndexWriter = class {$IFDEF D3} (TInterfacedObject,IDCSectionWriter) {$ENDIF}
  private
    FWriter   : TDCRTFExporter;
    FSections : TStrings;
    function CurrentSection(const S : string) : string;
    procedure Flush;
  public
    constructor Create(Writer : TDCRTFExporter);
    destructor Destroy ; override;
    procedure StartSection(const Section , URL :string);
    procedure FinishSection;
  end;

  TDCRtfParser = class(TCustomDCParser)
  private
    FResWord    : integer;
    FSpecialChar: char;
    FAfterGroup : string;
  protected
    function  ParseGroupBegin : integer;
    function  ParseGroupEnd : integer;
    function  ParseKeyWord : integer;
    function  ParseRtfStrConst:   integer;
    procedure SkipRtfDigits;
  public
    constructor Create(AOwner : TComponent); override;
    procedure  InitRtfSyntax;
    property  ResWordId : integer read FResWord write FResWord;
    property  SpecialChar: char read FSpecialChar;
  end;

  TColorReference = record
    red   : byte;
    green : byte;
    blue  : byte;
  end;

  TDCRtfParserClass = class of  TDCRtfParser;

  TRTFConverter = class(TObject)
  private
    FParser : TDCRtfParser;
    FColorTable : TStrings;
    FFontTable : TStrings;
    fcolor : integer;
 protected
    procedure ProcessFontTable;
    procedure SkipToFontTable;
    procedure ProcessColorTable;
    procedure SkipGroup;
    function  GetParserClass : TDCRtfParserClass ; virtual;
  public
    constructor Create(const rtf : string);
    destructor Destroy ; override;
    function ParseDigits : string;
    property Parser : TDCRtfParser read FParser;
    property ColorTable : TStrings read FColorTable;
    property FontTable : TStrings read FFontTable;
  end;

  TWriterObject = class
  private
    FObjectData : variant;
  public
    procedure BeginTag(const Tag : string); virtual;
    procedure EndTag(const Tag : string); virtual;
    function  IsEmbeddedTag(const Tag : string) : boolean; virtual;
    procedure WriteString(Stream:TStream ; const S : string); virtual;
    procedure WritelnString(Stream:TStream ; const S : string);
    procedure Flush(Stream : TStream); virtual ;
    function  IsEmbeddedString(const S :string) : boolean; virtual;
  end;

  TWriterFontObject = class(TWriterObject)
  private
    FFontTable     : TStrings;
    FIgnoreCharSet : Boolean;
  public
    constructor Create;
    destructor  Destroy; override;
    function    IsEmbeddedTag(const Tag : string) : boolean; override;
    function    AddFont(const FontName : string; CharSet : byte) : integer;
    procedure   Flush(Stream : TStream); override;

    Property IgnoreCharSet : Boolean Read FIgnoreCharSet Write FIgnoreCharSet;
  end;

  TWriterColorObject = class(TWriterObject)
  private
    FColorTable : TStrings;
  public
    constructor Create;
    destructor  Destroy; override;
    function    AddColor(Color : TColor) : integer;
    function    IsEmbeddedTag(const Tag : string) : boolean; override;
    procedure   Flush(Stream : TStream); override;
  end;

  TWriterTableObject = class(TWriterObject)
  private
    FParams : TTableParams;
    FRows   : TStrings;
  public
    constructor Create(const Params : TTableParams);
    destructor Destroy ; override;
    procedure BeginTag(const Tag : string); override;
    procedure EndTag(const Tag : string); override;
    function  IsEmbeddedTag(const Tag : string) : boolean; override;
    procedure StartTableRow;
    procedure FinishTableRow;
    procedure StartTableDataCell(width : integer);
    procedure FinishTableDataCell;
    procedure Flush(Stream : TStream); override;
    function  IsEmbeddedString(const S :string) : boolean; override;
  end;

  TRTFWriterList = class(TStringList)
  private
    Stack           : TStrings;
    FFontObject     : TWriterFontObject;
    FColorObject    : TWriterColorObject;
    FVarData        : variant;
    FParam          : integer;
    FContent        : TStrings;
    FIndexes        : TStrings;
    FRemoveBrackets : boolean;
    function  GetOpenBracket : string;
    function  GetCloseBracket : string;
    function GetIgnoreCharSet: Boolean;
    procedure SetIgnoreCharSet(const Value: Boolean);
  public
    procedure StartWriterObject(AObject :TObject);
    procedure FinishWriterObject;
    procedure WriteString(const S : string);
    procedure Flush(Stream : TStream);
    constructor Create ;
    destructor Destroy ; override;
    function  StackPointer : TWriterObject;
    function  Pop : Pointer;
    procedure Push(Item : Pointer);
    procedure BeginTag(const Tag : string);
    procedure EndTag(const Tag : string);
    property  RemoveBrackets : boolean read FRemoveBrackets write FRemoveBrackets;
    property  VarData : Variant read FVarData write FVarData;
    Property  IgnoreCharSet : Boolean Read GetIgnoreCharSet Write SetIgnoreCharSet;
  end;


  TDCRTFConverter = class(TRTFConverter)
  private
    FWriter : TDCRTFExporter;
    FRes : string;
    procedure ParseRtf;
  public
    constructor Create(const rtf : string ; Writer : TDCRTFExporter);
  end;

  TDCHtmlConverter = class(TRTFConverter)
  private
//    FHtml : string;
    FStack : TStrings;
    FDefColor : integer;
    FHtml     : string;
    FColorStr : string;
    procedure ParseRtf;
    procedure Push;
    procedure Pop;
    procedure ProcessColorTable;
    procedure AddToStack(const Tag : string);
    procedure WriteTag(const Tag : string);
    procedure WriteTagEx(const Tag : string ; const Names,Values : Array of string);
    procedure ChangeTag(const FromTag,ToTag : string ; const Names,Values : Array of string);
    procedure FlushTag(const Names : Array of string);
    function  CombineTag(const Names,Values : Array of string) : string;
  public
    constructor Create(const rtf : string );
    destructor Destroy ; override;
  end;


  TParseTextEvent = procedure(Sender : TObject; const s : string; Font : TFont; Color : TColor) of object;

  TDCImporter = class
  private
    FFont        : TFont;
    FOnParseText : TParseTextEvent;
  protected
    procedure TextChanged(const s : string; CurrentFont : TFont; CurrentColor : TColor); virtual;
  public
    function IsValidStream(Stream : TStream) : boolean; virtual; abstract;
    constructor Create;
    destructor Destroy; override;
    procedure ParseText(const Text : string); virtual; abstract;
    property OnParseText : TParseTextEvent read FOnParseText write FOnParseText;
  end;

  TDCRtfImporter = class(TDCImporter)
    procedure ParseText(const Text : string); override;
    function  IsValidStream(Stream : TStream) : boolean; override;
  end;

  TDCHTMLImporter = class(TDCImporter)
    procedure ParseText(const Text : string); override;
    function  IsValidStream(Stream : TStream) : boolean; override;
  end;

  TDCImporterClass = class of TDCImporter;


//BeginSkipConst

const
  SHtmlExt             = '.html';
  SParagraphTag        = 'P';
  SAlignTag            = 'Align';
  SLeftAlignTag        = 'left';
  SCenterAlignTag      = 'center';
  SRightAlignTag       = 'right';
  SJustifyAlignTag     = 'justify';

  SLineBreakTag        = 'BR';
  SParTag              = 'P';
  SFontTag             = 'font';
  SFontFaceTag         = 'face';
  SBigFontTag          = 'BIG';
  SSmallFontTag        = 'SMALL';
  SFontSizeTag         = 'SIZE';
  SBoldFontTag         = 'B';
  SItalicFontTag       = 'I';
  SUnderlineFontTag    = 'U';
  SStrikeOutFontTag    = 'S';
  SFontColorTag        = 'color';
  SBackColorTag        = 'BGCOLOR';

  SDefaultFont         : string  = 'Times New Roman';

  SNumberedListTag     = 'ol';
  SBulletedListTag     = 'ul';
  SListItemTag         = 'li';

  SQuoteTag            = 'blockquote';
  SubScriptTag         = 'sub';
  SupperScriptTag      = 'sup';

  SRefTag              = 'A';
  SHRefTag             = 'href';
  sRefTarget           = 'target';
  sRefTargetNewWindow  = '_blank';
  SLinkTag             = 'link';

  SHtmlTag             = 'Html';
  SHeadTag             = 'Head';
  SBodyTag             = 'Body';
  STitleTag            = 'Title';
  SSpaceTag            = '&nbsp;';
  SLtTag               = '&lt;';
  SQtTag               = '&gt;';
  SAmpTag              = '&amp;';
  SQuotTag             = '&quot;';
  SBRTag               = '<BR>';
  SStrongTag           = 'STRONG';
  SEMTag               = 'EM';

  STableTag            = 'TABLE';
  STablewidthTag       = 'width';
  STableborderTag      = 'border';
  STableframeTag       = 'frame';
  STablerulesTag       = 'rules';
  STablecellspacingTag = 'cellspacing';
  STablecellpaddingTag = 'cellpadding';

  SFramevoidTag        = 'void';
  SFrameaboveTag       = 'above';
  SFramebelowTag       = 'below';
  SFramehsidesTag      = 'hsides';
  SFramelhsTag         = 'lhs';
  SFramerhsTag         = 'rhs';
  SFramevsidesTag      = 'vsides';
  SFrameboxTag         = 'box';
  SFrameborderTag      = 'border';

  SRulesnone           = 'none';
  SRulesgroups         = 'groups';
  SRulesrows           = 'rows';
  SRulescols           = 'cols';
  SRulesall            = 'all';
  STableRowTag         = 'TR';
  STableDataTag        = 'TD';
  SImageTag            = 'img';
  SImageWidth          = 'WIDTH';
  SImageHeight         = 'HEIGHT';
  SImageNameTag        = 'src';

//----------  RTF-----------------
  SRedColor               = 'red';
  SGreenColor             = 'green';
  SBlueColor              = 'blue';
  SNewLine                =  #13#10;
  SRtfStartDocTag         = 'rtf1\ansi' ;

  sRTFBorderAtTop         = 'brdrt';
  sRTFSingleBorder        = 'brdrs';

  SRtfParagraphTag        = 'par';
  SRtfLeftAlignTag        = 'ql';
  SRtfCenterAlignTag      = 'qc';
  SRtfRightAlignTag       = 'qr';
  SRtfJustifyAlignTag     = 'qj';
  SRTFDefaultParagraphTag = 'pard';
  SRtfLineBreakTag        = 'line';
  SRtfFontNameTag         = 'f%d %s;';
  SRtfFontNameCharsetTag  = 'f%d\fcharset%d %s;';
  SRtfFontTag             = 'f';
  SRtfFontTableTag        = 'fonttbl';
  SRtfFontColorTable      = 'colortbl';
  SRTFNewPageTag          = 'page';
  SRTFNew_PageTag         = '_page';
  SRtfNonScrollTag        = 'keepn\par';
  SRtfPlainTag            = 'plain';
  SRtfFonSizeTag          = 'fs';
  SRtfBoldFontTag         = 'b';
  SRtfItalicFontTag       = 'i';
  SRtfUnderlineFontTag    = 'ul';
  SRtfStrikeOutFontTag    = 'strike';
  SRtfHiddenTag           = 'v';
  sRtfSeeAlsoTag          = 'uld0';
  sRtfALinkTag            = '!Al';
  sRtfJumpTag             = '!JumpId';
  sRtfBaseTag             = 'Base';

  sParagraphVertBeforeShift = 'sb';
  sParagraphVertAfterShift  = 'sa';

  SRtfDefaultFont : string  = '\fnil Times New Roman';
  SRtfCharSetTag          = 'fcharset';

  SRtfListTag             = 'pntext';
  SRtfNumberedListTag     = 'pn\pnlvlbody\pnstart1{\pntxta .}';
  SRtfBulletedListTag     = 'pn\pnlvlblt';
  SRtfBulletListItemTag   = 'pntxtb\''b7';
  SRtfNumberListItemTag   = 'pntxtb\pndec';

  SRtfQuoteTag            = 'pard\li';
  SRtfsubScriptTag        = 'sub';
  SRtfsuperScriptTag     = 'super';

  SRtffootnoteTag         = 'footnote';
  SRtfRefTag              = 'uldb';
  SRtfHRefTag             = 'v';
  StfImageTag             = 'bmc';

  SRTFTableRowTag         = '\trowd\';
  SRTFTableCellWidth      = 'cellx';
  SRtfFontColorTag        = 'cf';
  SRtfBackColorTag        = 'highlight';

  SRTFTableDataCellTag    = 'cell';
  SRTFTableIntableTag     = 'intbl';
  SRTFRowEndTag           =  'row';

  SRtfFramevoidTag        = 'void';
  SRtfFrameaboveTag       = 'trbrdrt';
  SRtfFramebelowTag       = 'trbrdrb';
  SRtfFramehsidesTag      = 'trbrdrh';
  SRtfFramelhsTag         = 'trbrdrl';
  SRtfFramerhsTag         = 'trbrdrr';
  SRtfFramevsidesTag      = 'trbrdrv';
  SRtfFrameboxTag         = 'trbrdrt\trbrdrb\trbrdrh\trbrdrl\trbrdrr\trbrdrv';
  SRtfTabTag              = '\tab ';
  SRtfFrameborderTag      = SRtfFrameboxTag;
  DefaultCellWidth        = 250;
  SDefaultQuoteWidth      = 500;

//------------ Content & Index------------

  SContentTag         = 'Content';
  SIndexTag           = 'Index';
  SObjectTag          = 'OBJECT';
  STypeTag            = 'type';
  STextStampTag       = 'text/sitemap';
  SParamNameTag       = 'param name';
  SValueTag           = 'value';
  SNameTag            = 'Name';
  SLocalTag           = 'Local';

  SMainStyleTag       = 'main';
  SSecondStlyTag      = 'second';


  TokGroupBegin = 20;
  TokGroupEnd = 21;
  tokUnknownResWord = 22;
  tokSpecialChar = 23;
  tokHtmlString = 24;

  cRtfIdentChars : TCharSet =['A'..'Z','a'..'z','_', '*'];
  cNotStrChars : TCharSet = ['{','}','\',#00..#31]; //'<','>'

  cNotHtmlStrChars : TCharSet =  ['<', '>', #00..#31];

  SMaxRtfResWors = 39;

  SRtfResWords  : Array[0 .. SMaxRtfResWors - 1] of string = ( '\b' , '\blue', '\cell',
  '\cf', '\colortbl', '\deff','\deflang', '\endash', '\f', '\fonttbl', '\fs', '\green', '\highlight' , '\i',
  '\line', '\lquote', '\nosupersub', '\par', '\pard', '\plain', '\pnf' ,'\pnlvlblt', '\pnlvlbody',
  '\pntext','\qc','\qr','\red', '\row', '\rquote', '\rtf', '\strike', '\sub', '\super', '\trowd',
  '\tab', '\u', '\ul', '\ulnone', '\v');


//EndSkipConst

  id_bold       = 0;
  id_blue       = id_bold + 1;
  id_cell       = id_blue + 1;
  id_cf         = id_cell + 1;
  id_colortbl   = id_cf + 1;
  id_deff       = id_colortbl + 1;
  id_deflang    = id_deff + 1;
  id_endash     = id_deflang + 1;
  id_f          = id_endash + 1;
  id_fonttbl    = id_f + 1;
  id_fs         = id_fonttbl + 1;
  id_green      = id_fs + 1;
  id_highlight  = id_green + 1;
  id_i          = id_highlight + 1;
  id_line       = id_i + 1;
  id_lquote     = id_line + 1;
  id_nosupersub = id_lquote + 1;
  id_par        = id_nosupersub + 1;
  id_pard       = id_par + 1;
  id_plain      = id_pard + 1;
  id_pnf        = id_plain + 1;
  id_pnlvlblt   = id_pnf + 1;
  id_pnlvlbody  = id_pnlvlblt + 1;
  id_pntext     = id_pnlvlbody + 1;
  id_qc         = id_pntext + 1;
  id_qr         = id_qc + 1;
  id_red        = id_qr + 1;
  id_row        = id_red + 1;
  id_rquote     = id_row + 1;
  id_rtf        = id_rquote + 1;
  id_strike     = id_rtf + 1;
  id_sub        = id_strike + 1;
  id_super      = id_sub + 1;
  id_tab        = id_super + 1;
  id_trowd      = id_tab + 1;
  id_u          = id_trowd + 1;
  id_ul         = id_u + 1;
  id_ulnone     = id_ul + 1;
  id_v          = id_ulnone + 1;

  id_big        = id_v + 1;
  id_small      = id_big + 1;
  id_href       = id_small + 1;
  id_head       = id_href + 1;
  id_body       = id_head + 1;
  id_strong     = id_body + 1;
  id_em         = id_strong + 1;

function AddFont( Writer : TDCRTFExporter; FontName : string ) : integer;
function AddColor( Writer : TDCRTFExporter; Color : TColor ) : integer;

function RtfToHtml(const RTF:string) : string;
function Rtf2Rtf(const RTF:string; Writer : TDCRTFExporter) : string;
procedure DCProcessHTMLSysSymbols( Var AText : string );

function  DCExportToRTF( const Contents : string ) : string;
procedure DCExportToRTFStream( Stream : TStream; const Contents : string );
procedure DCExportTo( Exporter : TDCRTFExporter; const Contents : string );

function  DCExportToHTML( const Contents : string ) : string;

function DCRemoveSlash(const s : string; DeleteSpace : boolean) : string;

Function DCGetGroupSectionKind( AKind : TDCSectionKind ) : TDCSectionKind;

const
  SkipHtmlHeader : boolean = false;
implementation
const
  wrongwords = '\stylesheet;\pntxta;\pntxtb;\propname;\staticval;\object;\*;\title;\author;\operator;\pict';
type

  PImportRecord = ^TImportRecord;
  TImportRecord = record
    Id            : integer;
    FFontName     : string;
    FFontCharSet  : TFontCharSet;
    FFontStyle    : TFontStyles;
    FExcludeStyle : TFontStyles;
    FFontColor    : TColor;
    FFontSize     : integer;
    FColor        : TColor;
    FStyleValid   : boolean;
    FColorValid   : boolean;
  end;

  TInternalImporter = class
  private
    FStack       : TStrings;
    FFont        : TFont;
    FOwner       : TDCImporter;
    FFontTable   : TStrings;
    FDefaultFont : string;
    FAddSpace    : boolean;
    procedure Push(id : integer);
    procedure Pop(id : integer);
    procedure WriteFontStyle(Style : TFontStyle; turnOn : boolean);
    procedure WriteColor(Color : TColor);
    procedure WriteFontColor(Color : TColor);
    procedure WriteFontName(FontName : string; FontCharSet : TFontCharset);
    procedure WriteFontSize(FontSize : integer);
    procedure ClearFont;
    function  DefaultFont(var CharSet : TFontCharset) : string;
    procedure WriteString(const s : string);
    procedure ClearRecord(Value : PImportRecord);
    function  CheckStackPoint : PImportRecord;
    procedure CurrentFont(Font : TFont ; var Color : TColor);
  public
    constructor Create(AOwner : TDCImporter);
    destructor Destroy; override;
  end;

  TRtfImporter = class(TRTFConverter)
  private
    FIntImporter : TInternalImporter;
  public
    constructor Create(AOwner : TDCImporter; const rtf : string);
    destructor Destroy; override;
    procedure ParseText;
  end;


  TIntHTMLParser = class(TCustomDCParser)
  private
    Importer   : TInternalImporter;
    function ParseHtmlString : integer;
    function ParseHtmlParam : integer;
    function ParseHTMLTag : integer;
    function ParseHTMLComment : integer;
    function ParseHTMLTagEnd : integer;
    function ParseHTMLCommentEnd : integer;
    function ParseNewLine : integer;
    function ParseHTMLColor : integer;
  public
    constructor Create(AOwner : TComponent); override;
    procedure InitSyntax;
  end;

  THTMLImporter = class
  private
    FLinkColor   : TColor;
    FParser      : TIntHTMLParser;
    FIntImporter : TInternalImporter;
    function  TokenStringToResWord(s : string; var Negate : boolean) : integer;
  public
    constructor Create(AOwner : TDCImporter; const html : string);
    destructor Destroy; override;
    procedure ParseText;
  end;

{------------------------------------------------------------------}

procedure _inc(var P : Pchar);
begin
  {$IFDEF DCMBCS}
    if (SysLocale.FarEast) and (P^ in LeadBytes) then
      inc(P, 2)
    else
      inc(P);
  {$ELSE}
    inc(P);
  {$ENDIF}
end;

{------------------------------------------------------------------}

function DCRemoveSlash(const s : string; DeleteSpace : boolean) : string;
var
  P : integer;
begin
  result := s;

  if DeleteSpace and (result <> '') and (result[1] = ' ') then
    delete(result, 1, 1);

  P := Pos('\', result);
  while P <> 0 do
  begin
    if (P < length(result)) and (result[P + 1] in ['\','{','}']) then
      delete(result, P, 1);
    inc(P);
    P := PosEx('\', result, P);
  end;

  (*
  if (length(result) = 2) and (result[1] = '\') and (result[2] in ['\','{','}']) then
    result := result[2]
  *)
end;

{------------------------------------------------------------------}

function RemoveQuotes(const s : string) : string;
var
  len : integer;
begin
  result := s;
  if (result <> '') then
  begin
    len := length(result);
    if ((result[1] = '''') or (result[1] = '"')) and ((result[len] = '''') or (result[len] = '"')) then
      result := Copy(result, 2, len - 2);
  end;    
end;

{------------------------------------------------------------------}

function FontSizeToHTMLSize(size : integer) : integer;
begin
  case size of
    1 .. 8   : result := 1;
    9 .. 11  : result := 2;
    12 .. 13 : result := 3;
    14 .. 17 : result := 4;
    18 .. 23 : result := 5;
    24 .. 35 : result := 6;
    else result := 7;
  end;
end;

{------------------------------------------------------------------}

function HTMLSizeToFontSize(size : integer) : integer;
begin
  case size of
    1 : result := 8;
    2 : result := 10;
    3 : result := 12;
    4 : result := 14;
    5 : result := 18;
    6 : result := 24;
    7 : result := 36;
    else result := 48;
  end;
end;

{------------------------------------------------------------------}

function WidthToRtfWidth(pixels : integer) : integer;
begin
  result := round(56.7 * pixels / 2);
end;

{------------------------------------------------------------------}

function ColorToRgbColor(Color : TColor) : TColorReference;
var
  rgb  : Longint;
begin
  rgb := ColorToRgb(Color);
  with result do
  begin
    red   := Byte(rgb);
    green := Byte(rgb shr 8);
    blue  := Byte(rgb shr 16);
  end;
end;

{------------------------------------------------------------------}

function WindowStyleToString(Style : TWindowStyle) : string;
const
  WindowArray : array [TWindowStyle] of string =
  (
    SMainStyleTag,
    '',
    SSecondStlyTag
  );
begin
  result :=  WindowArray[Style];
end;

{------------------------------------------------------------------}

function ColorToHTMLString(Color : TColor) : string;
begin
  with ColorToRgbColor(Color) do
    result :='#' + IntToHex(red,2) + IntToHex(green,2) + IntToHex(blue,2);
end;

{------------------------------------------------------------------}

function ColorToRTFString(Color : TColor) : string;
begin
  with ColorToRgbColor(Color) do
    result :=SRedColor + IntToStr(red) + '\' + SGreenColor + IntToStr(green) +
             '\' + SBlueColor + IntToStr(blue);
end;

{------------------------------------------------------------------}

function HTMLStringToColor(s : string) : TColor;
begin
  if s[1] = '#' then
    delete(s, 1, 1);
  result := StrToIntDef('$' + Copy(s, 1, 2), 0) + (StrToIntDef('$' + Copy(s, 3, 2), 0) shl 8) + (StrToIntDef('$' + Copy(s, 5, 2), 0) shl 16);
end;

{------------------------------------------------------------------}

function ParagraphAlignToString(Align : TParagraphAlign) :string ;
const
  AlignArray : array [TParagraphAlign] of string =
  (
    SLeftAlignTag,
    SCenterAlignTag,
    SRightAlignTag,
    SJustifyAlignTag
  );
begin
  result := AlignArray[Align];
end;

{------------------------------------------------------------------}

function ParagraphAlignToRTFString(Align : TParagraphAlign) :string ;
const
  AlignArray : array [TParagraphAlign] of string =
  (
    SRtfLeftAlignTag,
    SRtfCenterAlignTag,
    SRtfRightAlignTag,
    SRtfJustifyAlignTag
  );
begin
  result := AlignArray[Align];
end;

{------------------------------------------------------------------}

function FrameToString(Frame : TTableFrame) : string;
const
  FrameArray : array [TTableFrame] of string =
  (
    SFramevoidTag,
    SFrameaboveTag,
    SFramebelowTag,
    SFramehsidesTag,
    SFramelhsTag,
    SFramerhsTag,
    SFramevsidesTag,
    SFrameboxTag,
    SFrameborderTag
  );
begin
  result := FrameArray[Frame];
end;

{------------------------------------------------------------------}

function FrameToRtfString(Frame : TTableFrame) : string;
const
  FrameArray : array [TTableFrame] of string =
  (
     SRtfFramevoidTag,
     SRtfFrameaboveTag,
     SRtfFramebelowTag,
     SRtfFramehsidesTag,
     SRtfFramelhsTag,
     SRtfFramerhsTag,
     SRtfFramevsidesTag,
     SRtfFrameboxTag,
     SRtfFrameborderTag
   );
begin
  result := FrameArray[Frame];
end;

{------------------------------------------------------------------}

function RulesToString(Rules :TTableRules) : string;
const
  RuleArray : array [TTableRules] of string =
  (
    SRulesnone,
    SRulesgroups,
    SRulesrows,
    SRulescols,
    SRulesall
  );
begin
  result := RuleArray[Rules];
end;

{------------------------------------------------------------------}

function IntToS(value : integer): string;
begin
  if value <> 0 then
    result := IntToStr(value)
  else
    result := '';
end;

{------------------------------------------------------------------}

function TranslateHtmlString(const S : string): string;
var
  i   : integer;
  len : integer;
begin
  result := '';
  i := 1;
  len := length(s);
  while i <= len do
  begin
    {$IFDEF DCMBCS}
    if SysLocale.FarEast and (s[i] in LeadBytes) then
    begin
      result := result + s[i];
      if i + 1 <= len then
        result := result + s[i + 1];
      inc(i, 2);
      continue;
    end;
    {$ENDIF}

    case S[i] of
      ' ' : result := result + SSpaceTag;
      '<' : result := result + SLtTag;
      '>' : result := result + SQtTag;
      '&' : result := result + SAmpTag;
      '"' : result := result + SQuotTag;
//      #9  : result := result + STabTag;
      else
        result := result + S[i];
    end;
    inc(i)
  end;
end;

{------------------------------------------------------------------}

function HtmlToString(const S : string): string;

  {------------------------------------------------------}

  procedure ChangeTag(FromTag : string; Char : char);
  var
    P : integer;
  begin
    P := Pos(FromTag, result);
    while P <> 0 do
    begin
      Delete(result, P, length(FromTag));
      Insert(Char, result, P);
      P := PosEx(FromTag, result, P);
    end;
  end;

  {------------------------------------------------------}

begin
  result := s;
  ChangeTag(SSpaceTag, ' ');
  ChangeTag(SLtTag, '<');
  ChangeTag(SQtTag, '>');
  ChangeTag(SAmpTag, '&');
  ChangeTag(SQuotTag, '"');
end;

{-----------TDCExporter--------------------------------------------}

constructor TDCExporter.Create(Stream : TStream);
begin
  inherited Create;
  FStream := Stream;
  FParSpaceBefore := 0;
  FParSpaceAfter  := 0;
end;

{------------------------------------------------------------------}

procedure  TDCExporter.WriteString(const S : string);
begin
  If S <>'' Then
    FStream.Write(S[1],length(S));
end;

{---------TDCHTMLExporter--------------------------------------------}

function TDCHTMLExporter.TranslateString(const S : string): string;
begin
  result := TranslateHtmlString(S);
end;

{------------------------------------------------------------------}

procedure TDCHTMLExporter.BeginComplexTag(const Tag , S : string);
begin
  if (FLastTag <> Tag) and (FLastTag <> '') then
    WriteString(SNewLine);
  if S <> '' then
    WriteString('<' + S + '>')
  else
    WriteString('<' + Tag + '>');
  FLastTag := Tag;
end;

{------------------------------------------------------------------}

procedure TDCHTMLExporter.BeginTagWithLine(const Tag : string);
begin
  BeginComplexTag(Tag, '');
end;

{------------------------------------------------------------------}

procedure TDCHTMLExporter.BeginTag(const Tag : string);
begin
  WriteString('<' + Tag + '>');
end;

{------------------------------------------------------------------}

procedure TDCHTMLExporter.EndTag(const Tag : string);
begin
  WriteString('</' + Tag + '>');
end;

{------------------------------------------------------------------}

procedure TDCHTMLExporter.BeginTagEx(const Tag : string ; const Names,Values : Array of string);
var
  S : string;
  i : integer;
  Sub : string;
begin
  S := Tag;
  for i:= Low(Names) to High(Names) do
    if Values[i] <> '' then
    begin
      sub := Names[i] + '=' + '"' + Values[i] +  '"';
      if S = '' then
        S := Sub
      else
        S := S + ' ' + Sub;
    end;
  BeginComplexTag(Tag,S);
end;

{------------------------------------------------------------------}

procedure TDCHTMLExporter.StartParagraph(Align : TParagraphAlign);
begin
  BeginTagEx(SParagraphTag,[SAlignTag],[ParagraphAlignToString(Align)]);
end;

{------------------------------------------------------------------}

procedure TDCHTMLExporter.FinishParagraph;
begin
  EndTag(SParagraphTag);
end;

{------------------------------------------------------------------}

procedure TDCHTMLExporter.StartNonScrolledArea;
begin
  StartParagraph(paLeft);
end;

{------------------------------------------------------------------}

procedure TDCHTMLExporter.FinishNonScrolledArea;
begin
  FinishParagraph;
end;

{------------------------------------------------------------------}

procedure TDCHTMLExporter.NewLine;
begin
  BeginTag(SLineBreakTag);
  WriteString(SNewLine);
end;

{------------------------------------------------------------------}

procedure TDCHTMLExporter.StartFontWithCharSet(const FontName : string; CharSet : TFontCharSet);
begin
  StartFont(FontName);
end;

{------------------------------------------------------------------}

procedure TDCHTMLExporter.StartFont(const FontName : string);
begin
  BeginTagEx(SFontTag,[SFontFaceTag],[FontName]);
end;

{------------------------------------------------------------------}

procedure TDCHTMLExporter.FinishFont;
begin
  EndTag(SFontTag);
end;

{------------------------------------------------------------------}

procedure TDCHTMLExporter.StartBigFont;
begin
  BeginTag(SBigFontTag);
end;

{------------------------------------------------------------------}

procedure TDCHTMLExporter.FinishBigFont;
begin
  EndTag(SBigFontTag);
end;

{------------------------------------------------------------------}

procedure TDCHTMLExporter.StartSmallFont;
begin
  BeginTag(SSmallFontTag);
end;

{------------------------------------------------------------------}

procedure TDCHTMLExporter.FinishSmallFont;
begin
  EndTag(SSmallFontTag);
end;

{------------------------------------------------------------------}

procedure TDCHTMLExporter.StartFontSize(Size : integer);
begin
  BeginTagEx(SFontTag,[SFontSizeTag],[IntToStr(FontSizeToHTMLSize(size))]);
end;

{------------------------------------------------------------------}

procedure TDCHTMLExporter.FinishFontSize;
begin
  EndTag(SFontTag)
end;

{------------------------------------------------------------------}

procedure TDCHTMLExporter.StartItalic;
begin
  BeginTag(SItalicFontTag);
end;

{------------------------------------------------------------------}

procedure TDCHTMLExporter.FinishItalic;
begin
  EndTag(SItalicFontTag);
end;

{------------------------------------------------------------------}

procedure TDCHTMLExporter.StartBold;
begin
  BeginTag(SBoldFontTag);
end;

{------------------------------------------------------------------}

procedure TDCHTMLExporter.FinishBold;
begin
  EndTag(SBoldFontTag);
end;

{------------------------------------------------------------------}

procedure TDCHTMLExporter.StartUnderline;
begin
  BeginTag(SUnderLineFontTag);
end;

{------------------------------------------------------------------}

procedure TDCHTMLExporter.FinishUnderline;
begin
  EndTag(SUnderLineFontTag);
end;

{------------------------------------------------------------------}

procedure TDCHTMLExporter.StartStrikeOut;
begin
  BeginTag(SStrikeOutFontTag);
end;

{------------------------------------------------------------------}

procedure TDCHTMLExporter.FinishStrikeOut;
begin
  EndTag(SStrikeOutFontTag);
end;

{------------------------------------------------------------------}

procedure TDCHTMLExporter.StartNumberedList;
begin
  BeginTagWithLine(SNumberedListTag);
end;

{------------------------------------------------------------------}

procedure TDCHTMLExporter.FinishNumberedList;
begin
  EndTag(SNumberedListTag);
end;

{------------------------------------------------------------------}

procedure TDCHTMLExporter.StartBulletedList;
begin
  BeginTagWithLine(SBulletedListTag);
end;

{------------------------------------------------------------------}

procedure TDCHTMLExporter.FinishBulletedList;
begin
  EndTag(SBulletedListTag);
end;

{------------------------------------------------------------------}

procedure TDCHTMLExporter.StartBulletListItem ;
begin
  BeginTagWithLine(SListItemTag);
end;

{------------------------------------------------------------------}

procedure TDCHTMLExporter.FinishBulletListItem ;
begin
  EndTag(SListItemTag);
end;

{------------------------------------------------------------------}

procedure TDCHTMLExporter.StartNumberedListItem ;
begin
  BeginTagWithLine(SListItemTag);
end;

{------------------------------------------------------------------}

procedure TDCHTMLExporter.FinishNumberedListItem ;
begin
  EndTag(SListItemTag);
end;

{------------------------------------------------------------------}

procedure TDCHTMLExporter.StartQuote;
begin
  BeginTag(SQuoteTag);
end;

{------------------------------------------------------------------}

procedure TDCHTMLExporter.FinishQuote;
begin
  EndTag(SQuoteTag);
end;

{------------------------------------------------------------------}

procedure TDCHTMLExporter.StartSubScript;
begin
  BeginTag(SubScriptTag);
end;

{------------------------------------------------------------------}

procedure TDCHTMLExporter.FinishSubScript;
begin
  EndTag(SubScriptTag);
end;

{------------------------------------------------------------------}

procedure TDCHTMLExporter.StartSuperScript;
begin
  BeginTag(SupperScriptTag);
end;

{------------------------------------------------------------------}

procedure TDCHTMLExporter.FinishSuperScript;
begin
  EndTag(SupperScriptTag);
end;

{------------------------------------------------------------------}

procedure TDCHTMLExporter.StartColor(Color : TColor);
begin
  BeginTagEx(SFontTag, [SFontColorTag] ,[ColorToHTMLString(Color)]);
end;

{------------------------------------------------------------------}

procedure TDCHTMLExporter.FinishColor;
begin
  EndTag(SFontTag);
end;

{------------------------------------------------------------------}

procedure TDCHTMLExporter.StartBackground(Color : TColor);
begin
  if not SkipHtmlHeader then
    BeginTagEx(SBodyTag, [SBackColorTag] ,[ColorToHTMLString(Color)]);
end;

{------------------------------------------------------------------}

procedure TDCHTMLExporter.FinishBackground;
begin
  if not SkipHtmlHeader then
    EndTag(SBodyTag);
end;

{------------------------------------------------------------------}

procedure TDCHTMLExporter.StartBackColor(Color : TColor);
begin
 //
end;

{------------------------------------------------------------------}

procedure TDCHTMLExporter.FinishBackColor;
begin
//
end;

{------------------------------------------------------------------}

procedure TDCHTMLExporter.StartHRef(const Reference : string; Style : TWindowStyle);
begin
  BeginTagEx(SRefTag,[SHRefTag],[Reference + SHtmlExt]);
end;

{------------------------------------------------------------------}

procedure TDCHTMLExporter.FinishHRef;
begin
  EndTag(SRefTag);
end;

{------------------------------------------------------------------}

procedure TDCHTMLExporter.StartTable (const Params : TTableParams);
begin
  with Params do
    BeginTagEx(STableTag,[STablewidthTag,STableborderTag,STableframeTag,STablerulesTag,
               STablecellspacingTag,STablecellpaddingTag],
               [IntToS(width),IntToS(border),FrameToString(frame),
               RulesToString(rules), IntToS(cellspacing),IntToS(cellpadding)]);

end;

{------------------------------------------------------------------}

procedure TDCHTMLExporter.FinishTable;
begin
  EndTag(STableTag);
end;

{------------------------------------------------------------------}


procedure TDCHTMLExporter.StartTableRow;
begin
  BeginTagWithLine(STableRowTag);
end;

{------------------------------------------------------------------}

procedure TDCHTMLExporter.FinishTableRow;
begin
  EndTag(STableRowTag);
end;

{------------------------------------------------------------------}

procedure TDCHTMLExporter.StartTableDataCell(width : integer);
begin
  if Width <> 0 then
    BeginTagEx(STableDataTag,[STablewidthTag],[intToStr(width)])
  else
    BeginTagWithLine(STableDataTag);
end;

{------------------------------------------------------------------}

procedure TDCHTMLExporter.FinishTableDataCell;
begin
  EndTag(STableDataTag);
end;

{------------------------------------------------------------------}

procedure TDCHTMLExporter.AddImage(const ImageName : string ; Width , Height : integer);
begin
  if ImageName <> '' then
  begin
    if (Width = 0) and (Height = 0) then
      BeginTagEx(SImageTag,[SImageNameTag],[ImageName])
    else
      BeginTagEx(SImageTag,[SImageNameTag , SImageWidth,SImageHeight],[ ImageName ,IntToStr(Width) , IntToStr(Height)]);
  end;
end;

{------------------------------------------------------------------}

function  TDCHTMLExporter.UseTabCharacter : boolean;
begin
  result := false;
end;

{------------------------------------------------------------------}

procedure TDCHTMLExporter.DrawHorzLine;
begin
  WriteString( '<HR>' );
end;

{------------------------------------------------------------------}

procedure TDCHTMLExporter.WriteExternalURL( const Caption, URL : string );
begin
  BeginTagEx( SRefTag, [SHRefTag, sRefTarget], [URL, sRefTargetNewWindow] );
  WriteString( Caption );
  EndTag( SRefTag );
end;

{------------------------------------------------------------------}

procedure TDCHTMLExporter.AddSpaces(count : integer) ;
var
  i : integer;
  S : string;
begin
  S := '';
  for i := 0 to Count - 1 do
    S := S + SSpaceTag;
  WriteString(S);
end;

{------------------------------------------------------------------}

procedure TDCHTMLExporter.StartDocument(const Title : string);
begin
  if not SkipHtmlHeader then
  begin
    BeginTag(SHtmlTag);
    BeginTag(SHeadTag);
    EndTag(SHeadTag);
    BeginTag(STitleTag);
    WriteString(Title);
    EndTag(STitleTag);
    BeginTag(SBodyTag);
  end;
  StartFont(SDefaultFont);
end;

{------------------------------------------------------------------}

procedure TDCHTMLExporter.FinishDocument;
begin
  FinishFont;
  if not SkipHtmlHeader then
  begin
    EndTag(SBodyTag);
    EndTag(SHtmlTag);
  end;
end;

{------------------------------------------------------------------}

procedure TDCHTMLExporter.StartPage(const Title : string);
begin
  StartDocument(Title);
end;

{------------------------------------------------------------------}

procedure TDCHTMLExporter.FinishPage;
begin
  FinishDocument;
end;

{------------------------------------------------------------------}

destructor THTMLExporter.Destroy ;
begin
  FStream.Free;
  inherited Destroy;
end;

{---------TWriterObject---------------------------------------------}

procedure TWriterObject.WriteString(Stream:TStream ; const S : string);
begin
  if S <> '' then
    Stream.Write(S[1],length(S));
end;

{------------------------------------------------------------------}

procedure TWriterObject.BeginTag(const Tag : string);
begin
end;

{------------------------------------------------------------------}

procedure TWriterObject.EndTag(const Tag : string); 
begin
end;

{------------------------------------------------------------------}

procedure TWriterObject.WritelnString(Stream:TStream ; const S : string);
begin
  WriteString(Stream , S);
  WriteString(Stream , SNewLine);
end;

{------------------------------------------------------------------}

function  TWriterObject.IsEmbeddedTag(const Tag : string) : boolean;
begin
  result := false;
end;

{------------------------------------------------------------------}

function  TWriterObject.IsEmbeddedString(const S :string) : boolean;
begin
  result := false;
end;

{------------------------------------------------------------------}

procedure TWriterObject.Flush;
begin
end;

{-----------TWriterFontObject--------------------------------------}

constructor TWriterFontObject.Create;
begin
  FFontTable := TStringList.Create;
  inherited Create;
end;

{------------------------------------------------------------------}

destructor  TWriterFontObject.Destroy;
begin
  FFontTable.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------}

function  TWriterFontObject.AddFont(const FontName : string; CharSet : byte) :integer;
begin
  with FFontTable  do
  begin
    result := IndexOf(FontName);
    if result < 0 then
      result := AddObject(FontName, pointer(charset));
  end;
end;

{------------------------------------------------------------------}

function  TWriterFontObject.IsEmbeddedTag(const Tag : string) : boolean;
begin
  result := Tag = SRtfFontTag;
end;

{------------------------------------------------------------------}

procedure TWriterFontObject.Flush(Stream : TStream);
var
  i : integer;
begin
  with FFontTable do
    if Count  <> 0  then
    begin
      WritelnString(Stream , '{\' + SRtfFontTableTag);
      for i := 0 to Count - 1 do
        If IgnoreCharSet Then
          WritelnString(Stream , '{\' + Format(SRtfFontNameTag,[i,Strings[i]]) + '}')
        Else
          WritelnString(Stream , '{\' + Format(SRtfFontNameCharsetTag, [i, byte(Objects[i]), Strings[i]]) + '}');
      WritelnString(Stream , '}');
    end;
end;

{-----------TWriterColorObject---------------------------------------}

constructor TWriterColorObject.Create;
begin
  FColorTable := TStringList.Create;
  inherited Create;
end;

{------------------------------------------------------------------}

destructor  TWriterColorObject.Destroy;
begin
  FColorTable.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------}

function  TWriterColorObject.IsEmbeddedTag(const Tag : string) : boolean;
begin
  result := (Tag = SRtfFontColorTag) or (Tag = SRtfBackColorTag) ;
end;

{------------------------------------------------------------------}

function  TWriterColorObject.AddColor(Color : TColor) : integer;
var
  cs : string;
begin
  with FColorTable  do
  begin
    cs := ColorToRTFString(Color);
    result := IndexOf(cs);
    if result < 0 then
      result := Add(cs);
  end;
end;

{------------------------------------------------------------------}

procedure  TWriterColorObject.Flush(Stream : TStream);
var
  i : integer;
begin
  with FColorTable do
    if Count  <> 0  then
    begin
      WritelnString(Stream , '{\' + SRtfFontColorTable);
      for i := 0 to Count - 1 do
        WritelnString(Stream , '\' +Strings[i] + ';');
      WritelnString(Stream , '}');
    end;
end;

{-----------TWriterTableObject---------------------------------------}

constructor TWriterTableObject.Create(const Params : TTableParams);
begin
  inherited Create;
  FRows := TStringList.Create;
  FParams  := Params;
end;

{------------------------------------------------------------------}

destructor TWriterTableObject.Destroy;
begin
  FreeStrings(FRows);
  inherited Destroy;
end;

{------------------------------------------------------------------}

function  TWriterTableObject.IsEmbeddedTag(const Tag : string) : boolean;
begin
  result := (Tag = SRTFTableRowTag) or (Tag = SRTFTableDataCellTag);
end;

{------------------------------------------------------------------}

procedure TWriterTableObject.StartTableRow;
begin
  FRows.AddObject('{' + SRTFTableRowTag + FrameToRtfString(Fparams.Frame),TStringList.Create);
end;

{------------------------------------------------------------------}

procedure TWriterTableObject.FinishTableRow;
begin
  //
end;

{------------------------------------------------------------------}

procedure TWriterTableObject.BeginTag(const Tag : string);
begin
  if Tag = SRTFTableRowTag then
    StartTableRow
  else
  if Tag = SRTFTableDataCellTag then
    StartTableDataCell(FObjectData);
end;
{------------------------------------------------------------------}

function  TWriterTableObject.IsEmbeddedString(const S :string) : boolean;
begin
  result := true;
  with FRows do
    if Count > 0 then
      with TStrings(Objects[Count - 1]) do
        if Count > 0 then
           Strings[Count - 1 ] := Strings[Count - 1 ] + S;

end;

{------------------------------------------------------------------}

procedure TWriterTableObject.EndTag(const Tag : string);
begin
  if Tag = SRTFTableRowTag then
    FinishTableRow
  else
  if Tag = SRTFTableDataCellTag then
    FinishTableDataCell
end;

{------------------------------------------------------------------}

procedure TWriterTableObject.StartTableDataCell(width : integer);
var
  W : integer;
begin
  with FRows do
    if Count > 0 then
    begin
      W := width ;
      if W = 0 then
        W := DefaultCellWidth;
      TStrings(Objects[Count - 1]).Add(IntToStr(W) + '=');
    end;
end;

{------------------------------------------------------------------}

procedure TWriterTableObject.FinishTableDataCell;
begin
end;

{------------------------------------------------------------------}

procedure TWriterTableObject.Flush(Stream : TStream);
var
  i, j, width : integer;
  sl : TStrings;
  s : string;
begin
  if FRows.Count = 0 then
  begin
    WriteString(Stream , '{');
    exit;
  end;
  WritelnString(Stream , '{\' + SRtfParagraphTag);
  with FRows do
    if Count > 0 then
    begin
      for i := 0 to Count - 1 do
      begin
        WritelnString(Stream , Strings[i]);
        sl := TStrings(Objects[i]);
        width := 0;
        for j := 0 to sl.Count - 1  do
        begin
          width := width + StrToInt(sl.Names[j]);
          WritelnString(Stream, '\' + SRTFTableCellWidth + IntToStr(WidthToRtfWidth(width)));
        end;
        for j := 0 to sl.Count - 1 do
        begin
          s := sl[j];
          if pos('=',s) <>0  then
            System.delete(s, 1, pos('=',s));
          WritelnString(Stream , '\' + SRTFDefaultParagraphTag + ' \' +
                        SRTFTableIntableTag + ' ' +  s + '\' + SRTFTableDataCellTag);
        end;
        WritelnString(Stream , '\' + SRTFRowEndTag  + '\' + SRTFDefaultParagraphTag + '}');
      end;
    end;
end;


{-------TRTFWriterList---------------------------------------------}

procedure TRTFWriterList.Flush(Stream : TStream);
var
  i  : integer;
  S  : string;
  S1 : string;

  {-------------------------------------------------}

  procedure WriteWithDelimeter(const Str, Delimeter : string);
  var
    S : string;
  begin
    s := '\' + SRtfsuperScriptTag + delimeter  + '{\' + SRtffootnoteTag + ' {\' +
    SRtfsuperScriptTag + delimeter +' }' + Str + '}';
    Stream.Write(S[1],length(S));
  end;

  {-------------------------------------------------}

  procedure WritePage(Sl :Tstrings; const Str :string ;  createindex : boolean );
  var
    Idx : integer;
    S   : string;
    S1  : string;

    {-----------------------------------------}

    function ValidIndex(i : integer) : boolean;
    begin
      with Sl do
        result := (i >= 0 ) and (i < Count) and
       (Copy(Strings[i],1,Pos('!',Strings[i])- 1) = Str);
    end;
    
    {-----------------------------------------}

  begin
    if  not CreateIndex then
    begin
      WriteWithDelimeter(Str,' #');
      exit;
    end;

    with TStringList(Sl) do
    begin
      Find(Str,Idx);
      while ValidIndex(Idx) do
        dec(Idx);
      inc(Idx);

      S := '';
      while ValidIndex(Idx) do
      begin
        S1 := Strings[Idx];
        System.delete(S1 ,1, pos('!',S1));
        if S = '' then
          S := S1
        else
          S := S + ';' + S1;
        inc(Idx);
      end;
    end;
    WriteWithDelimeter(RemoveCharSet(['0'..'9'],Str),' $'); //don't resource;
    if S <> '' then
    begin
      S := '{'  + S + '}';
      WriteWithDelimeter(S,' K'); //don't resource;
    end;
    WriteWithDelimeter(Str,' A'); //don't resource;

  end;

  {-------------------------------------------------}

begin
  for i:= 0 to Count - 1 do
    if Objects[i] is TWriterObject then
      TWriterObject(Objects[i]).Flush(Stream)
    else
    begin
      S := Strings[i];
      if Pos(SRtfStartDocTag,S) <> 0 then
      begin
        Stream.Write(S[1],length(S));
        FFontObject.Flush(Stream);
        FColorObject.Flush(Stream);
      end
      else
      if Pos(SRTFNew_PageTag,S) <> 0 then
      begin
        S1 := '{\' + SRTFNewPageTag + '}';
        Stream.Write(S1[1],length(S1));
        System.Delete(S,1,Pos(SRTFNew_PageTag,S) + length(SRTFNew_PageTag));
        s := RemoveCharSet(['{','}'],S);
        WritePage(FContent,S, false);
        WritePage(FIndexes,S, true);
      end
      else
      if S <> '' then
        Stream.Write(S[1],length(S));
    end;
end;

{------------------------------------------------------------------}

constructor TRTFWriterList.Create;
begin
  inherited Create;
  Stack := TStringList.Create;
  FFontObject := TWriterFontObject.Create;
  FFontObject.AddFont(SRtfDefaultFont, 1);
  FColorObject := TWriterColorObject.Create;
  FContent  := CreateSortedStringList;
  FIndexes  := CreateSortedStringList;
end;

{------------------------------------------------------------------}

destructor TRTFWriterList.Destroy ;
begin
  Stack.Free;
  ClearStrings(Self);
  FFontObject.Free;
  FColorObject.Free;
  FContent.Free;
  FIndexes.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------}

function  TRTFWriterList.StackPointer : TWriterObject;
begin
  with Stack do
    if Count = 0 then
      result := nil
    else
      result := TWriterObject(Objects[Count - 1]);
end;

{------------------------------------------------------------------}

function  TRTFWriterList.Pop : Pointer;
begin
  result := StackPointer;
  if result <> nil then
    Stack.Delete(Stack.Count - 1);
end;

{------------------------------------------------------------------}

procedure TRTFWriterList.Push(Item : Pointer);
begin
  Stack.AddObject('',Item);
end;

{------------------------------------------------------------------}

procedure TRTFWriterList.WriteString(const S : string);
begin
  if (S = '') then
    exit;
  if (StackPointer = nil) or not StackPointer.IsEmbeddedString(S) then
    Add(S);
end;

{------------------------------------------------------------------}

procedure TRTFWriterList.StartWriterObject(AObject :TObject);
begin
  AddObject('',AObject);
  Push(AObject);
end;

{------------------------------------------------------------------}

procedure TRTFWriterList.FinishWriterObject;
begin
  Pop;
end;

{------------------------------------------------------------------}

function  TRTFWriterList.GetOpenBracket : string;
begin
  if FRemoveBrackets then
    result := ''
  else
    result := '{';
end;

{------------------------------------------------------------------}

function  TRTFWriterList.GetCloseBracket : string;
begin
  if FRemoveBrackets then
    result := ''
  else
    result := '}';
end;

{------------------------------------------------------------------}

procedure TRTFWriterList.BeginTag(const Tag : string);
var
  i : integer;
begin
  if FFontObject.IsEmbeddedTag(Tag) then
  begin
    i := FFontObject.AddFont(FVarData, FParam);
    WriteString(GetOpenBracket + '\' + Tag + IntToStr(i) + ' ');
    exit;
  end;

  if FColorObject.IsEmbeddedTag(Tag) then
  begin
    i := FColorObject.AddColor(FVarData);
    WriteString(GetOpenBracket + '\' + Tag + IntToStr(i) + ' ');
    exit;
  end;

  for i := Stack.Count - 1 downto 0  do
    with TWriterObject(Stack.Objects[i]) do
      if IsEmbeddedTag(Tag) then
      begin
        FObjectData := FVarData;
        BeginTag(Tag);
        exit;
      end;

  if Tag = '' then
    WriteString(GetOpenBracket)
  else
    WriteString(GetOpenBracket + '\' + Tag + ' ');
  WriteString(SNewLine);
end;

{------------------------------------------------------------------}

procedure TRTFWriterList.EndTag(const Tag : string);
var
  i : integer;
begin
  for i := Stack.Count - 1 downto 0  do
    with TWriterObject(Stack.Objects[i]) do
      if IsEmbeddedTag(Tag) then
      begin
        EndTag(Tag);
        exit;
      end;
  if Tag = '' then
    WriteString(GetCloseBracket)
  else
    WriteString('\' + Tag + GetCloseBracket);
end;


{---------TDCRTFExporter-------------------------------------------}

constructor TDCRTFExporter.Create (Stream: TStream);
begin
  inherited Create(Stream);
  FWriterList := GetRTFWriterClass.Create;
  fsize := 24;
end;

{------------------------------------------------------------------}

function  TDCRTFExporter.GetRTFWriterClass : TRTFWriterListClass;
begin
  result := TRTFWriterList;
end;

{------------------------------------------------------------------}

destructor TDCRTFExporter.Destroy;
begin
  FWriterList.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------}

procedure TDCRTFExporter.WriteString(const S : string);
var
  s2 : string;
begin
  s2 := S;
  ReplaceAllOccur(s2, 'ÿ', '\''FF');
  FWriterList.WriteString(s2);
end;

{------------------------------------------------------------------}

function TDCRTFExporter.TranslateString(const S : string) : string;
var
  i   : integer;
  {$IFDEF DCMBCS}
  ts : string;
  {$ENDIF}
begin
  result := S;
  i := 1;
  while i <= length(result)  do
  begin
    {$IFDEF DCMBCS}
    if SysLocale.FarEast and (result[i] in LeadBytes) then
    begin
      ts := '\''' + IntToHex(Byte(result[i]), 2);
      if i < length(result) then
        ts := ts + '\''' + IntToHex(Byte(result[i + 1]), 2);
      delete(result, i, 2);
      insert(ts, result, i);
      inc(i, length(ts));
      continue;
    end;
    {$ENDIF}
    case result[i] of
      '\','{','}' :
      begin
        insert('\', result, i);
        inc(i);
      end;
      #9 :
      begin
        delete(result, i, 1);
        insert(SRtfTabTag, result, i);
        inc(i, length(SRtfTabTag) - 1);
      end;
    end;
    inc(i);
  end;
end;

{------------------------------------------------------------------}

procedure TDCRTFExporter.BeginTag(const Tag : string);
begin
  FWriterList.BeginTag(Tag);
end;

{------------------------------------------------------------------}

procedure TDCRTFExporter.EndTag(const Tag : string);
begin
  FWriterList.EndTag(Tag);
end;

{------------------------------------------------------------------}

procedure TDCRTFExporter.WriteTag(const Tag : string);
begin
  WriteString('{\' + Tag + '}');
  WriteString(SNewLine);
end;

{------------------------------------------------------------------}

procedure TDCRTFExporter.StartParagraph(Align : TParagraphAlign);
begin
  BeginTag(SRtfParagraphTag + ' \' + ParagraphAlignToRTFString(Align));
end;

{------------------------------------------------------------------}

procedure TDCRTFExporter.FinishParagraph;
begin
  EndTag(SRtfParagraphTag + '\' + SRTFDefaultParagraphTag );
end;

{------------------------------------------------------------------}

procedure TDCRTFExporter.StartNonScrolledArea;
begin
  BeginTag('');
end;

{------------------------------------------------------------------}

procedure TDCRTFExporter.FinishNonScrolledArea;
begin
  WriteTag(SRtfNonScrollTag);
  EndTag('');
end;

{------------------------------------------------------------------}

procedure TDCRTFExporter.NewLine;
begin
  BeginTag(SRtfLineBreakTag);
  EndTag('');
end;

{------------------------------------------------------------------}

procedure TDCRTFExporter.StartFont(const FontName : string);
begin
  FWriterList.FVarData := FontName;
  FWriterList.FParam := 1;
  BeginTag(SRtfFontTag);
end;

{------------------------------------------------------------------}

procedure TDCRTFExporter.StartFontWithCharSet(const FontName : string; CharSet : TFontCharSet);
begin
  FWriterList.FVarData := FontName;
  FWriterList.FParam := Integer(CharSet);
  BeginTag(SRtfFontTag);
end;
{------------------------------------------------------------------}

procedure TDCRTFExporter.FinishFont;
begin
  EndTag('');
end;

{------------------------------------------------------------------}

procedure TDCRTFExporter.StartBigFont;
begin
  inc(fsize,6);
  BeginTag(SRtfFonSizeTag+IntToStr(fsize));
end;

{------------------------------------------------------------------}

procedure TDCRTFExporter.FinishBigFont;
begin
  dec(fsize,6);
  EndTag('');
end;

{------------------------------------------------------------------}

procedure TDCRTFExporter.StartSmallFont;
begin
  dec(fsize,6);
  if fsize < 1 then
    BeginTag(SRtfFonSizeTag + '1')
  else
    BeginTag(SRtfFonSizeTag + IntToStr(fsize));
end;

{------------------------------------------------------------------}

procedure TDCRTFExporter.FinishSmallFont;
begin
  inc(fsize,6);
  EndTag('');
end;

{------------------------------------------------------------------}

procedure TDCRTFExporter.StartFontSize(Size : integer);
begin
  BeginTag(SRtfFonSizeTag + IntToStr(Size * 2 ));
end;

{------------------------------------------------------------------}

procedure TDCRTFExporter.FinishFontSize;
begin
  EndTag('');
end;

{------------------------------------------------------------------}

procedure TDCRTFExporter.StartItalic;
begin
  BeginTag(SRtfItalicFontTag);
end;

{------------------------------------------------------------------}

procedure TDCRTFExporter.FinishItalic;
begin
  EndTag('');
end;

{------------------------------------------------------------------}

procedure TDCRTFExporter.StartBold;
begin
  BeginTag(SRtfBoldFontTag);
end;

{------------------------------------------------------------------}

procedure TDCRTFExporter.FinishBold;
begin
  EndTag('');
end;

{------------------------------------------------------------------}

procedure TDCRTFExporter.StartUnderline;
begin
  BeginTag(SRtfUnderlineFontTag);
end;

{------------------------------------------------------------------}

procedure TDCRTFExporter.FinishUnderline;
begin
  EndTag('');
end;

{------------------------------------------------------------------}

procedure TDCRTFExporter.StartStrikeOut;
begin
  BeginTag(SRtfStrikeOutFontTag);
end;

{------------------------------------------------------------------}

procedure TDCRTFExporter.FinishStrikeOut;
begin
  EndTag('');
end;

{------------------------------------------------------------------}

procedure TDCRTFExporter.StartNumberedList;
begin
  BeginTag('');
  WriteTag(SRtfParagraphTag);
  WriteTag(SRtfListTag);
  WriteTag(SRtfNumberedListTag);
end;

{------------------------------------------------------------------}

procedure TDCRTFExporter.FinishNumberedList;
begin
  EndTag('');
end;

{------------------------------------------------------------------}

procedure TDCRTFExporter.StartBulletedList;
begin
  BeginTag('');
  WriteTag(SRtfParagraphTag);
  WriteTag(SRtfListTag);
  WriteTag(SRtfBulletedListTag);
end;

{------------------------------------------------------------------}

procedure TDCRTFExporter.FinishBulletedList;
begin
  EndTag('');
end;

{------------------------------------------------------------------}

procedure TDCRTFExporter.StartListItem;
begin
  BeginTag('');
  WriteTag(SRtfListTag);
end;

{------------------------------------------------------------------}

procedure TDCRTFExporter.StartBulletListItem ;
begin
  StartListItem;
  WriteTag(SRtfBulletListItemTag)
end;

{------------------------------------------------------------------}

procedure TDCRTFExporter.FinishBulletListItem ;
begin
  EndTag(SRtfParagraphTag);
end;

{------------------------------------------------------------------}

procedure TDCRTFExporter.StartNumberedListItem ;
begin
  StartListItem;
  WriteTag(SRtfNumberListItemTag);
end;

{------------------------------------------------------------------}

procedure TDCRTFExporter.FinishNumberedListItem ;
begin
  EndTag(SRtfParagraphTag);
end;

{------------------------------------------------------------------}

procedure TDCRTFExporter.StartQuote;
begin
  BeginTag(SRtfQuoteTag + IntToStr(SDefaultQuoteWidth));
end;

{------------------------------------------------------------------}

procedure TDCRTFExporter.FinishQuote;
begin
  EndTag(SRtfParagraphTag);
end;

{------------------------------------------------------------------}

procedure TDCRTFExporter.StartSubScript;
begin
  BeginTag(SRtfsubScriptTag);
end;

{------------------------------------------------------------------}

procedure TDCRTFExporter.FinishSubScript;
begin
  EndTag('');
end;

{------------------------------------------------------------------}

procedure TDCRTFExporter.StartSuperScript;
begin
  BeginTag(SRtfsuperScriptTag);
end;

{------------------------------------------------------------------}

procedure TDCRTFExporter.FinishSuperScript;
begin
  EndTag('');
end;

{------------------------------------------------------------------}

procedure TDCRTFExporter.StartColor(Color : TColor);
begin
  FWriterList.FVarData := Color;
  BeginTag(SRtfFontColorTag);
end;

{------------------------------------------------------------------}

procedure TDCRTFExporter.FinishColor;
begin
  EndTag('');
end;

{------------------------------------------------------------------}

procedure TDCRTFExporter.StartBackGround(Color : TColor);
begin
  //
end;

{------------------------------------------------------------------}

procedure TDCRTFExporter.FinishBackGround;
begin
  //
end;

{------------------------------------------------------------------}

procedure TDCRTFExporter.StartBackColor(Color : TColor);
begin
  FWriterList.FVarData := Color;
  BeginTag(SRtfBackColorTag);
end;

{------------------------------------------------------------------}

procedure TDCRTFExporter.FinishBackColor;
begin
  EndTag('');
end;

{------------------------------------------------------------------}

procedure TDCRTFExporter.StartHRef(const Reference : string; Style : TWindowStyle);
begin
  if Style = wsPopup then
    BeginTag(SRtfUnderlineFontTag)
  else
    BeginTag(SRtfRefTag);
  FStyle := Style;
  FReference := Reference;
end;

{------------------------------------------------------------------}

procedure TDCRTFExporter.FinishHRef;
begin
  if FStyle <> wsPopup then
    WriteTag(SRtfHRefTag + ' ' + FReference + '>' + WindowStyleToString(FStyle))
  else
    WriteTag(SRtfHRefTag + ' ' + FReference);
  EndTag('');
end;




{------------------------------------------------------------------}

procedure TDCRTFExporter.StartTable(const Params : TTableParams);
begin
  FWriterList.StartWriterObject(TWriterTableObject.Create(Params));
end;

{------------------------------------------------------------------}

procedure TDCRTFExporter.FinishTable;
begin
  FWriterList.FinishWriterObject;
  EndTag('');
end;

{------------------------------------------------------------------}

procedure TDCRTFExporter.StartTableRow;
begin
  BeginTag(SRTFTableRowTag);
end;

{------------------------------------------------------------------}

procedure TDCRTFExporter.FinishTableRow;
begin
  EndTag(SRTFTableRowTag);
end;

{------------------------------------------------------------------}

procedure TDCRTFExporter.StartTableDataCell(width : integer);
begin
  FWriterList.FVarData := width;
  BeginTag(SRTFTableDataCellTag);
end;

{------------------------------------------------------------------}

procedure TDCRTFExporter.FinishTableDataCell;
begin
  EndTag(SRTFTableDataCellTag);
end;

{------------------------------------------------------------------}

procedure TDCRTFExporter.StartDocument(const Title : string);
Var
  ParStr : string;
begin
  BeginTag(SRtfStartDocTag);
  ParStr := SRtfPlainTag;
  if ParSpaceBefore > 0 then
    ParStr := ParStr + '\' + sParagraphVertBeforeShift + IntToStr( ParSpaceBefore );
  if ParSpaceAfter > 0 then
    ParStr := ParStr + '\' + sParagraphVertAfterShift + IntToStr( ParSpaceAfter );
  BeginTag( ParStr );
end;

{------------------------------------------------------------------}

procedure TDCRTFExporter.FinishDocument;
begin
   EndTag('');
   EndTag('');
   FWriterList.Flush(FStream);
end;

{------------------------------------------------------------------}

procedure TDCRTFExporter.StartPage(const Title : string);
begin
  BeginTag('');
  WriteTag(SRTFNew_PageTag + '\' + Title);
end;

{------------------------------------------------------------------}

procedure TDCRTFExporter.FinishPage;
begin
  EndTag('');
end;

{------------------------------------------------------------------}

procedure TDCRTFExporter.AddSpaces(count : integer);
var
  s  : string;
  i : integer;
begin
  for i :=0 to count - 1 do
    s:= s + ' ';
  WriteString(s);
end;

{------------------------------------------------------------------}

procedure TDCRTFExporter.AddImage(const ImageName : string ; Width , Height : integer);
begin
  WriteString(' \{' + StfImageTag + ' ' + ImageName + '\}');
end;

{------------------------------------------------------------------}

function  TDCRTFExporter.UseTabCharacter : boolean;
begin
  result := true;
end;

procedure TDCRTFExporter.DrawHorzLine;
begin
  WriteString( '\' + sRTFParagraphTag + '\' + sRTFDefaultParagraphTag + '\' +
               sRTFBorderAtTop + '\' + sRTFSingleBorder + '{\f0\fs2\cf0  }\' +
               sRTFParagraphTag + '\' + sRTFDefaultParagraphTag + ' ' );
end;

{------------------------------------------------------------------}

procedure TDCRTFExporter.WriteExternalURL( const Caption, URL : string );
begin
//  StartColor( clBlue );
//  StartBold;
  WriteString( '{\uldb ' + Caption + '}{\v *!ExecFile(''' + URL + ''')}' );
//  FinishBold;
//  FinishColor;
end;

{-------THTMLContentWriter-----------------------------------------}

constructor  THTMLContentWriter.Create(Stream : TStream);
begin
  inherited Create(Stream);
  StartDocument(SContentTag);
end;

{------------------------------------------------------------------}

destructor  THTMLContentWriter.Destroy ;
begin
  FinishDocument;
  FStream.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------}

procedure   THTMLContentWriter.StartSection(const Section , URL :string);
begin
  NewLine;
  StartBulletedList;
  StartBulletListItem;
  FLastTag := SObjectTag;
  BeginTagEx(SObjectTag,[STypeTag],[STextStampTag]);
  BeginTagEx('',[SParamNameTag,SValueTag],[SNameTag,Section]);
  if URL <> '' then
    BeginTagEx('',[SParamNameTag,SValueTag],[SLocalTag, URL + SHtmlExt]);
  EndTag(SObjectTag);
  FinishBulletListItem;
end;

{------------------------------------------------------------------}

procedure THTMLContentWriter.StartSectionEx(const Section,
  URL: string; SectionKind: TDCSectionKind; const AUnit, ADeclaration : string);
begin
  StartSection( Section, URL );
end;

{---------------------------------------------------------------------------}

procedure THTMLContentWriter.FinishSection;
begin
  FinishBulletedList;
end;

{-------------TDCHTMLIndexWriter------------------------------------}

function GetEndString(const s :string): string;
begin
  result := s;
  while pos('.',result) <> 0 do
    delete(result,1,pos('.',result));
end;

{------------------------------------------------------------------}

constructor THTMLIndexWriter.Create(Stream : TStream);
begin
  inherited Create(Stream);
  StartDocument(SIndexTag);
  FSections := TStringList.Create;
  FIndexList := CreateSortedStringList;
end;

{------------------------------------------------------------------}

destructor  THTMLIndexWriter.Destroy ;
begin
  Flush;
  FSections.Free;
  FreeStrings(FIndexList);
  inherited Destroy;
end;

{------------------------------------------------------------------}

procedure  THTMLIndexWriter.SetCurrentLevel(Section : string);
var
  level : integer;
  i     : integer;
  p : integer;
begin
  level := 0;
  p :=  pos('.',Section);
  while p <> 0 do
  begin
    inc(level);
    delete(Section,1,p);
    p := pos('.',Section)
  end;

  for i := min(level, FCurrentlevel) to max(level, FCurrentlevel) - 1 do
    if level > FCurrentlevel then
      StartBulletedList
    else
      FinishBulletedList;
  FCurrentlevel := level;
end;

{------------------------------------------------------------------}

procedure  THTMLIndexWriter.Flush;
var
  i       : integer;
  j       : integer;
  aname   : string;
  subname : string;
  svalue  : string;
begin
  for i := 0 to FIndexList.Count - 1 do
  begin
    SetCurrentLevel(FIndexList[i]);
    aname := FIndexList[i];
    with TStrings(FIndexList.Objects[i]) do
      if Count >0 then
      begin
        StartBulletListItem;
        FLastTag := SObjectTag;
        BeginTagEx(SObjectTag,[STypeTag],[STextStampTag]);
        BeginTagEx('',[SParamNameTag,SValueTag],[SNameTag,GetEndString(aname)]);
        for j := 0 to Count - 1 do
        begin
          subname := Copy(Strings[j],1, pos('!',Strings[j]) - 1);
          svalue := Strings[j];
          System.delete(svalue,1,pos('!',Strings[j]));
          BeginTagEx('',[SParamNameTag,SValueTag],[SNameTag,subname]);
          BeginTagEx('',[SParamNameTag,SValueTag],[SLocalTag,svalue]);
        end;
        EndTag(SObjectTag);
        FinishBulletListItem;
      end;
  end;
  SetCurrentLevel('');
  FinishDocument;
  FStream.Free;
end;

{------------------------------------------------------------------}

function THTMLIndexWriter.CurrentSection : string;
var
  i : integer;
begin
  result := '';
  for i := 0 to FSections.Count - 1 do
    result := result +'.' + FSections[i];
end;

{------------------------------------------------------------------}

procedure  THTMLIndexWriter.StartSection(const Section , URL :string);
var
  i    : integer;
  Sect : string;
  S    : string;
begin
  Sect := GetEndString(Section);
  if ( Sect <> '' ) and ( Sect[Length( Sect )] = ',' ) then
    SetLength( Sect, Length( Sect ) - 1 );
  FSections.Add(Sect);
  Sect := GetEndString( Section );
  if (Sect <> '') and (URL <> '') then
  begin
    S := CurrentSection;
    with FIndexList do
    begin
      if not Find(S ,i) then
        i := AddObject(S,CreateSortedStringList);
      TStrings(Objects[i]).Add(Section + '!' + URL + SHtmlExt)
    end;
  end;
end;

{------------------------------------------------------------------}

procedure   THTMLIndexWriter.FinishSection;
begin
  with FSections do
    if Count >0 then
      Delete(Count - 1);
end;

{------TRTFContentWriter-------------------------------------------}

constructor TRTFContentWriter.Create(Writer : TDCRTFExporter; Stream : TStream);
begin
  inherited Create;
  FStream := Stream;
  FWriter := Writer;
end;

{------------------------------------------------------------------}

destructor  TRTFContentWriter.Destroy ;
begin
//  Fstream.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------}

procedure TRTFContentWriter.StartSection(const Section , URL :string);
var
  S : string;
begin
  inc(FCounter);
  S := InttoStr(FCounter) + ' ' + Section;
  if URL <> '' then
    S := S + '=' + URL + SNewLine
  else
    S := S + SNewLine;
  FStream.Write(s[1],length(S));
  with FWriter.FWriterList do
    FContent.Add(URL + '!' + GetEndString(Section));
end;

{------------------------------------------------------------------}

procedure TRTFContentWriter.StartSectionEx(const Section, URL: string;
  SectionKind: TDCSectionKind; const AUnit, ADeclaration : string);
begin
  StartSection( Section, URL );
end;

{---------------------------------------------------------------------------}

procedure TRTFContentWriter.FinishSection;
begin
  dec(FCounter);
end;

{--------TRTFIndexWriter-------------------------------------------}

constructor TRTFIndexWriter.Create(Writer : TDCRTFExporter);
begin
  inherited Create;
  FWriter := Writer;
  FSections := TStringList.Create;
end;

{------------------------------------------------------------------}

destructor TRTFIndexWriter.Destroy ;
begin
  Flush;
  FSections.Free;
  inherited Create;
end;

{------------------------------------------------------------------}

function TRTFIndexWriter.CurrentSection(const S : string) : string;
begin
  with FSections do
    if Count = 0 then
      result := GetEndString(S)
    else
      result := Strings[Count - 1] + ',' + GetEndString(S); // Dmitriy
end;

{------------------------------------------------------------------}

procedure TRTFIndexWriter.StartSection(const Section , URL :string);
var
  EndStr : string;
begin
  with FWriter.FWriterList do
    FIndexes.Add(URL + '!' + CurrentSection(Section));
  EndStr := GetEndString( Section );
{Dmitriy}
  if EndStr[ Length( EndStr ) ] = ',' then
    SetLength( EndStr, Length( EndStr ) - 1 );
{/Dmitriy}
  FSections.Add( EndStr );
end;

{------------------------------------------------------------------}

procedure TRTFIndexWriter.FinishSection;
begin
  with FSections do
    if Count <> 0 then
      FSections.Delete(Count - 1);
end;

{------------------------------------------------------------------}

procedure TRTFIndexWriter.Flush;
begin
//
end;

{------------------------------------------------------------------}

function AddFont(Writer : TDCRTFExporter ; FontName :string) : integer;
begin
  result := Writer.FWriterList.FFontObject.AddFont(FontName, 1);
end;

{------------------------------------------------------------------}

function AddColor(Writer : TDCRTFExporter ; Color : TColor) : integer;
begin
  result := Writer.FWriterList.FColorObject.AddColor(Color);
end;


{------------TDCRtfParser------------------------------------------}

constructor  TDCRtfParser.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  InitRtfSyntax;
end;

{------------------------------------------------------------------}

procedure TDCRtfParser.InitRtfSyntax;
begin
  StrArrayToStrings(ResWords,SRtfResWords);
  InitCommon;
  RegisterProc([psNormal],cValidChar ,ParseRtfStrConst);
  RegisterProc([psNormal],['{'],ParseGroupBegin);
  RegisterProc([psNormal],['}'],ParseGroupEnd);
  RegisterProc([psNormal],['\'],ParseKeyWord);
//  RegisterProc([psNormal],[' '],ParseRtfStrConst);
//  RegisterProc([psNormal],CFirstIdentChar,ParseRtfStrConst);
  RegisterProc([psNormal],cDigit,ParseNumConst);
  InitEolState(psNormal);
end;

{------------------------------------------------------------------}

function TDCRtfParser.ParseRtfStrConst:Integer;
begin
  Result:=tokString;
  _inc(FSourcePtr);
  while not (FSourcePtr^ in cNotStrChars) do
    _inc(FSourcePtr);
end;

{------------------------------------------------------------------}

procedure TDCRtfParser.SkipRtfDigits;
begin
  if (FSourcePtr^ = '-') and  ((FSourcePtr + 1)^ in cDigit) then
    _inc(FSourcePtr);
  SkipDigits;
end;

{------------------------------------------------------------------}

function PStr2ToHex(Ptr : pointer) : integer; assembler;
asm
    xor  ecx,ecx
    mov  edx,eax
    mov  al,[edx]
    test al,al
    jz   @@exit
    and  al,$DF
    sub  al,55
    jnc  @@hex1
    add  al,39
  @@hex1:
    movzx  ecx,al
    inc  edx

    mov  al,[edx]
    test al,al
    jz   @@exit
    and  al,$DF
    sub  al,55
    jnb  @@hex2
    add  al,39
  @@hex2:
    shl  ecx,4
    add  cl,al
  @@exit:
    mov  eax,ecx
end;

function TDCRtfParser.ParseKeyWord : integer;
begin
  _inc(FSourcePtr);
  case FSourcePtr^ of
  '{','}','\' :
    begin
      inc(FTokenPtr);
      result := ParseRtfStrConst;
    end;
  '''' :
    begin
      FSpecialChar := chr(PStr2ToHex(FSourcePtr + 1));
      inc(FSourcePtr, 3);
      result := tokSpecialChar;
    end;
  else
    begin
      while (FSourcePtr^ in cRtfIdentChars) do
        _inc(FSourcePtr);

      if TStringList(SortedResWords).Find(TokenString,FResWord) then
        Result:=tokResWord
      else
      begin
        Result := tokUnknownResWord;
        FResWord := - 1;
      end;
    end;
  end;

end;

{------------------------------------------------------------------}

function TDCRtfParser.ParseGroupBegin : integer;
begin
  _inc(FSourcePtr);
  result := TokGroupBegin;
  if (not ((FSourcePtr)^ in ['\', '{', '}'])) then
  begin
    while not (FSourcePtr^ in cNotStrChars) do
      _inc(FSourcePtr);
    SetString(FAfterGroup, FTokenPtr + 1, FSourcePtr - FTokenPtr - 1);
  end
  else
    FAfterGroup := '';
end;

{------------------------------------------------------------------}

function TDCRtfParser.ParseGroupEnd : integer;
begin
  _inc(FSourcePtr);
  result := TokGroupEnd;
end;

{------------------------------------------------------------------}

constructor TRTFConverter.Create(const rtf : string );
begin
  inherited  Create;
  FColorTable := TStringList.Create;
  FFontTable := TStringList.Create;
  FParser := GetParserClass.Create(nil);
  FParser.LinePtr := PChar(rtf);
end;

{------------------------------------------------------------------}

function  TRTFConverter.GetParserClass : TDCRtfParserClass ;
begin
  result := TDCRtfParser;
end;

{------------------------------------------------------------------}

destructor TRTFConverter.Destroy ;
begin
  Fparser.Free;
  FColorTable.Free;
  FFontTable.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------}

function TRTFConverter.ParseDigits : string;
begin
  result := '';
  with FParser do
    while FSourcePtr^ in cDigit do
    begin
      result := result + FSourcePtr^;
      _inc(FSourcePtr);
    end;
end;

{------------------------------------------------------------------}

procedure TRTFConverter.ProcessFontTable;
var
  fgroup     : integer;
  CurCharSet : integer;
  cnum       : integer;
  {---------------------------------------------------------}

  procedure CheckFontTable(Index : integer);
  begin
    with FFontTable do
      while Index >= Count do
        Add('');
  end;

  {------------------------------------------------------}
begin
  fgroup := 0;
  CurCharSet := 1;
  cnum := - 1;
  with FParser do
    while not (ParserEof) do
      case NextToken of
        TokGroupBegin : inc(fgroup);
        TokGroupEnd   :
        begin
          if (fgroup = 0) then
            break;
          dec(fgroup);
        end;
        tokResWord :
          if FResWord = id_f then
          begin
            NextToken;
            cnum := StrToInt(TokenString);
          end;
        tokUnknownResWord :
          with FFontTable do
            if CompareText(TokenString , '\' + SRtfCharSetTag) = 0 then
              CurCharSet := StrToIntDef(ParseDigits, 0);
        tokString :
          if (fgroup <=1) and (Trim(TokenString) <> '') then
          begin
            if cnum = - 1 then
              FFontTable.AddObject(RemoveCharSet([';'], Trim(TokenString)), Pointer(CurCharSet))
            else
            begin
              CheckFontTable(cnum);
              with FFontTable do
              begin
                Strings[cnum] := RemoveCharSet([';'], Trim(TokenString));
                Objects[cnum] := Pointer(CurCharSet);
              end;  
            end;
            CurCharSet := 0;
          end;
      end;
end;

{------------------------------------------------------------------}

procedure TRTFConverter.ProcessColorTable;
var
  fgroup    : integer;
  S         : string;
  firsttime : boolean;
begin
  fgroup := 0;
  firsttime := true;
  with FParser do
    while not (ParserEof) do
      case NextToken of
        TokWhiteChar, TokString  :
          if firsttime and (Trim(TokenString) = ';') then
          begin
            FColorTable.Add('0');
            firsttime := false;
          end;
        TokGroupBegin : inc(fgroup);
        TokGroupEnd   :
        begin
          if (fgroup = 0) then
            break;
          dec(fgroup);
        end;
        tokResWord:
        begin
          S:= TokenString;
          firsttime :=  firsttime and (s = '\colortbl');
          if S = '\red'then
          begin
            NextToken;
            fcolor := StrToInt(TokenString);
          end
          else
          if S = '\green'then
          begin
            NextToken;
            fcolor := fcolor + StrToInt(TokenString) shl 8;
          end
          else if S = '\blue' then
          begin
            NextToken;
            fcolor := fcolor + StrToInt(TokenString) shl 16;
            FColorTable.Add(intToStr(fcolor));
          end;
        end;
      end;
end;

{------------------------------------------------------------------}

procedure TRTFConverter.SkipGroup;
var
  fgroup    : integer;
begin
  fgroup := 0;
  with FParser do
    while not (ParserEof) do
      case NextToken of
        TokGroupBegin : inc(fgroup);
        TokGroupEnd   :
        begin
          if (fgroup = 0) then
            break;
          dec(fgroup);
        end;
      end;
end;

{------------------------------------------------------------------}

procedure TRTFConverter.SkipToFontTable;
begin
  with FParser do
  begin
    while not (ParserEof) do
       if PeekTokenStr = '\fonttbl' then
         break
       else
         NextToken;
    NextToken;
    ProcessFontTable;
  end;
end;

{-----------TDCRTFConverter----------------------------------------}

constructor TDCRTFConverter.Create(const rtf : string ; Writer : TDCRTFExporter);
begin
  inherited  Create(rtf);
  FWriter := Writer;
end;

{------------------------------------------------------------------}

procedure TDCRTFConverter.ParseRtf;
var
  I : integer;
  s : string;
begin
  FRes := '';
  with FParser do
    while not (ParserEof) do
    begin
      case NextToken of
        tokResWord : FRes := FRes + #13#10;
        TokGroupBegin :
          if (PeekTokenStr = '\colortbl') then
          begin
            ProcessColorTable;
            Continue;
          end
      end;
      s := TokenString;
      if (s = '\f') or (s = '\pnf') then
      begin
        NextToken;
        I := AddFont(FWriter,'\fnil ' + FFontTable.Strings[StrToInt(TokenString)]);
        FRes := FRes + s + IntToStr(i);
      end
      else if  (s = '\cf') then
      begin
        NextToken;
        I := AddColor(FWriter,StrToInt(FColorTable.Strings[StrToInt(TokenString)]));
        FRes := FRes + s + IntToStr(i);
      end
      else  if (s = '\rtf') then
        SkipToFontTable
      else
        FRes := FRes + TokenString;
    end;
end;


{-----------TDCHtmlConverter---------------------------------------}

constructor TDCHtmlConverter.Create(const rtf : string );
begin
  inherited Create(rtf);
  FStack := TStringList.Create;
  FDefColor := - 1;
end;

{------------------------------------------------------------------}

destructor TDCHtmlConverter.Destroy ;
begin
  FStack.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------}

procedure TDCHtmlConverter.Push;
begin
  FStack.Add('');
end;

{------------------------------------------------------------------}

procedure TDCHtmlConverter.Pop;
var
  s : string;
  sub : string;
begin
  with FStack do
    if Count > 0 then
    begin
      s := Strings[Count - 1];
      sub := '</' + SLineBreakTag + '>';
      while pos(sub,s) <> 0 do
        System.delete(s,pos(sub,s),length(sub));
      FHtml := FHtml + s;
      delete(Count - 1);
    end;
end;

{------------------------------------------------------------------}

procedure TDCHtmlConverter.AddToStack(const Tag : string);
begin
  with FStack do
    if Count > 0 then
      Strings[Count - 1] := Strings[Count - 1] + '</' + Tag + '>';
end;

{------------------------------------------------------------------}

procedure TDCHtmlConverter.WriteTag(const Tag : string);
begin
  Fhtml := Fhtml + '<' + Tag + '>' + SNewLine;
  AddToStack(Tag);
end;

{------------------------------------------------------------------}

function TDCHtmlConverter.CombineTag(const Names,Values : Array of string) : string;
var
  i   : integer;
  Sub : string;
begin
  for i:= Low(Names) to High(Names) do
    if Values[i] <> '' then
    begin
      sub := Names[i] + '=' + '"' + Values[i] +  '"';
      if result = '' then
        result := Sub
      else
        result := result + ' ' + Sub;
    end;
end;

{------------------------------------------------------------------}

procedure TDCHtmlConverter.WriteTagEx(const Tag : string ; const Names,Values : Array of string);
var
  S : string;
begin
  S := CombineTag(Names,Values);
  if S <> '' then
    S := Tag + ' ' + S
  else
    S := Tag;
  Fhtml := Fhtml + '<' + S + '>';// + SNewLine;
  AddToStack(Tag);
end;

{------------------------------------------------------------------}

function _PosEx(Sub,S : string) : integer;
begin
  result := BackPosEx(sub,S,Length(S));
end;

{------------------------------------------------------------------}

procedure TDCHtmlConverter.FlushTag(const Names : Array of string);
var
  s   : string;
  Sub : string;
  i   : integer;

begin
  if FStack.Count > 0 then
  begin
    S := FStack[FStack.Count - 1];
    for i := Low(Names) to High(Names) do
    begin
      sub := '</' + Names[i] + '>';
      if _PosEx(sub,S) <> 0 then
      begin
        FHtml := FHtml + sub;
        delete(S, _PosEx(sub,S) , length(sub));
      end;
    end;
    FStack[FStack.Count - 1] := S;
  end;
end;

{------------------------------------------------------------------}

procedure TDCHtmlConverter.ChangeTag(const FromTag,ToTag : string ; const Names,Values : Array of string);
var
  S   : string;
  P   : integer;
  Sub : string;
  STag : string;

  {-----------------------------------------------}

  function ChangeStr(const fromS,toS,S : string ) : string;
  var
    P : integer;
  begin
    result := s;
    P := pos(fromS,S);
    if P <> 0 then
      result := copy(S, 1 , P - 1)  + toS + copy(S, P + length(fromS) , length(S) - P - length(fromS) + 1);
  end;

  {-----------------------------------------------}

begin
  S := CombineTag(Names, Values);
  if S <> '' then
    S := ToTag + ' ' + S
  else
    S := ToTag;

  with FStack do
    if Count > 0 then
    begin
      Sub := Strings[Count - 1];
      Stag :='<' + FromTag + '>';
      if pos(FromTag , Sub) <> 0  then
      begin
        P := _posEx(STag,FHtml);
        if P <> 0 then
        begin
          FHtml := ChangeStr(Stag,'<' + S + '>',FHtml);
          Strings[Count - 1] := ChangeStr(Stag,'<' + ToTag + '>',Strings[Count - 1]);
        end;
      end;
    end;
end;

{------------------------------------------------------------------}

procedure TDCHtmlConverter.ProcessColorTable;
var
  fgroup    : integer;
  S         : string;
  firsttime : boolean;
begin
  firsttime := true;
  fgroup := 0;
  with FParser do
    while not (ParserEof) do
      case NextToken of
        TokWhiteChar  :
          if firsttime and (TokenString = ';') then
          begin
            FColorTable.Add('0');
            firsttime := false;
          end;
        TokGroupBegin : inc(fgroup);
        TokGroupEnd   :
        begin
          if (fgroup = 0) then
            break;
          dec(fgroup);
        end;
        tokResWord:
        begin
          S:= TokenString;
          firsttime :=  firsttime and (s = '\colortbl');
          if S = '\red'then
          begin
            NextToken;
            fcolorStr := IntToHex(StrToInt(TokenString),2);
          end
          else
          if S = '\green'then
          begin
            NextToken;
            fcolorStr :=  fcolorStr +  IntToHex(StrToInt(TokenString),2);
          end
          else if S = '\blue' then
          begin
            NextToken;
            fcolorStr := '#' + fcolorStr + IntToHex(StrToInt(TokenString),2);
            FColorTable.Add(fcolorStr);
          end;
        end;
      end;
end;

{------------------------------------------------------------------}

procedure TDCHtmlConverter.ParseRtf;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
  function RemoveSlash(const s : string) : string;
  begin
    if (Length(s) = 2) and (s[1] = '\') and (s[2] in ['\','{','}']) then
      result := s[2]
    else
      result := s;
  end;
{- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -}
Var
  Tok : integer;
begin
  FHtml := '';
  with FParser do
    while not (ParserEof) do
    begin
      Tok := NextToken;
      Case Tok Of
        TokGroupBegin :
        begin
          if (PeekTokenStr = '\colortbl') then
          begin
            ProcessColorTable;
            Continue;
          end;
          Push;
        end;
        TokGroupEnd   : Pop;
        tokResWord    :
          case FResWord of
            id_bold :
              WriteTag(SBoldFontTag);
            id_cf :
            begin
              NextToken;
              WriteTagEx(SFontTag,[SFontColorTag],[FColorTable[StrToInt(TokenString)]]);
            end;
            id_deflang :
            begin
              NextToken;
              FDefColor := StrToInt(TokenString);
            end;
            id_f , id_pnf :
            begin
              NextToken;
              FlushTag([SFontTag]);
              WriteTagEx(SFontTag,[SFontFaceTag],[FFontTable[StrToInt(TokenString)]]);
            end;
            id_fs :
            begin
              NextToken;
              //FlushTag([SFontTag]);
              WriteTagEx(SFontTag,[SFontSizeTag],[IntToStr(FontSizeToHTMLSize(StrToInt(TokenString) div 2))]);
            end;

            id_i : WriteTag(SItalicFontTag);
            id_par :
            begin
              FlushTag([SParagraphTag]);
              WriteTag(SLineBreakTag);
            end;
            id_pard : ChangeTag(SParagraphTag,SParagraphTag ,[SAlignTag],[SLeftAlignTag]);
            id_plain : FlushTag([SBoldFontTag,SItalicFontTag,SUnderlineFontTag,SBigFontTag,SSmallFontTag,SFontTag]);
            id_pnlvlblt : WriteTag(SBulletedListTag);
            id_pnlvlbody : WriteTag(SNumberedListTag);
            id_pntext : WriteTag(SListItemTag);
            id_qc : ChangeTag(SLineBreakTag, SParagraphTag,[SAlignTag],[SCenterAlignTag]);
            id_qr : ChangeTag(SLineBreakTag, SParagraphTag,[SAlignTag],[SRightAlignTag]);
            id_rtf :
            begin
              SkipToFontTable;
              if FDefColor <> - 1 then
                WriteTagEx(SFontTag,[SFontFaceTag],[FFontTable[0]]);
            end;
            id_tab: FHtml := FHtml +#9;
            id_ul : WriteTag(SUnderlineFontTag);
{--DM--}
            id_line : FHtml := FHtml + SBRTag;
{------}
            else
              FParser.SkipDigits;
          end;
{--DM--}
        tokWhiteChar :
          if TokenString <> '\' then
            FHtml := FHtml + RemoveSlash( TokenString );
//        22 : // ?????????????? i don't know exactly what this item mean.
//          FHtml := FHtml + RemoveSlash( TokenString );
{------}
        tokString :
          if CompareText(TokenString , 'b7') <> 0 then
            FHtml := FHtml + TranslateHtmlString(DCRemoveSlash(TokenString, true));

      end;
    end;
  while FStack.Count > 0 do
    Pop;
end;


{------------------------------------------------------------------}

function Rtf2Rtf(const rtf : string; Writer :TDCRTFExporter) : string;
begin
  with TDCRTFConverter.Create(rtf,writer) do
  try
    ParseRtf;
    result := FRes;
  finally
    free;
  end;
end;

{------------------------------------------------------------------}

procedure DCProcessHTMLSysSymbols( Var AText : string );
begin
  ReplaceAllOccur( AText, SBRTag, #1 );
  ReplaceAllOccur( AText, '<', SLtTag );
  ReplaceAllOccur( AText, '>', SQtTag );

{ ?????? In future make from this part table generation }
  While PosEx( #9#9, AText, 1 ) <> 0 Do
    ReplaceAllOccur( AText, #9#9, #9 );
  ReplaceAllOccur( AText, #9, SSpaceTag + '-' + SSpaceTag );
{ ?????? }

  ReplaceAllOccur( AText, #1, SBRTag );
end;

{------------------------------------------------------------------}

function RtfToHtml(const rtf:string):string;
begin
  with TDCHtmlConverter.Create(rtf) do
  try
    ParseRtf;
    result := FHtml;
//    DCProcessHTMLSysSymbols( Result );
  finally
    free;
  end;
end;

function DCExportToRTF( const Contents : string ) : string;
Var
  Stream : TMemoryStream;
begin
  Stream := Nil;
  Result := '';
  try
    Stream := TMemoryStream.Create;
    DCExportToRTFStream( Stream, Contents );
    SetLength( Result, Stream.Size );
    Move( Stream.Memory^, Result[ 1 ], Stream.Size );
{    Stream.Position := 0;
    Stream.Read( Result, Stream.Size );}
  finally
    FreeObject( Stream ,Stream );
  end;
end;

{---------------------------------------------------------------------------}

procedure DCExportToRTFStream( Stream : TStream; const Contents : string );
Var
  RTF : TDCRTFExporter;
begin
  RTF := TDCRTFExporter.Create( Stream );
  try
    DCExportTo( RTF, Contents );
  finally
    FreeObject( RTF ,RTF );
  end;
end;

{---------------------------------------------------------------------------}

procedure DCExportTo( Exporter : TDCRTFExporter; const Contents : string );

{------------------------------------------------------}

  procedure ProcessString( Exporter : TDCExporter; Data : string );
  begin
    Data := Exporter.TranslateString( Data );
    Exporter.WriteString( Data );
  end;

{------------------------------------------------------}

Var
  I     : integer;
  Lines : TStringList;

begin
  Exporter.StartDocument( '' );
//  Exporter.StartBackground( clWindow );
//  Exporter.StartFont( Font.Name );
  Exporter.StartFontSize( 10 );
  Lines := Nil;
  try
    Lines := TStringList.Create;
    Lines.Text := Contents;
    For I := 0 To Lines.Count - 1 Do
    begin
      if I <> 0 then
        Exporter.NewLine;
      ProcessString( Exporter, Lines[ I ] );
    end;
  finally
    FreeObject( Lines ,Lines );
    Exporter.FinishFontSize;
//    FinishColor;
//    FinishFont;
//    FinishBackground;
    Exporter.FinishDocument;
  end;
end;

{---------------------------------------------------------------------------}

function DCExportToHTML( const Contents : string ) : string;

begin
  Result := Contents;
  ReplaceAllOccur( Result, '<', SLtTag );
  ReplaceAllOccur( Result, '>', SQtTag );
  ReplaceAllOccur( Result, #10, SBRTag );
  ReplaceAllOccur( Result, #13, '' );
  While PosEx( '  ', Result, 1 ) <> 0 Do
    ReplaceAllOccur( Result, '  ', SSpaceTag + ' ' );
end;

{---------TDCImporter-----------------------------------------------}

procedure TDCImporter.TextChanged(const s : string; CurrentFont : TFont; CurrentColor : TColor);
begin
  if Assigned(FOnParseText) then
    FOnParseText(Self, s, CurrentFont, CurrentColor);
end;

{------------------------------------------------------------------}

constructor TDCImporter.Create;
begin
  inherited Create;
  FFont := TFont.Create;
end;

{------------------------------------------------------------------}

destructor TDCImporter.Destroy;
begin
  FFont.Free;
  inherited Destroy;
end;

{---------TDCRtfImporter-------------------------------------------}

procedure TDCRtfImporter.ParseText(const Text : string);
begin
  with TRtfImporter.Create(Self, Text) do
  try
    ParseText;
  finally
    Free;
  end;
end;

{------------------------------------------------------------------}

function TDCRtfImporter.IsValidStream(Stream : TStream) : boolean;
var
  s : string;
begin
  result := Stream.Size >= 5;
  if not result then
    exit;
  SetLength(s, 5);
  with Stream do
  begin
    Read(s[1], 5);
    Seek(0, 0);
  end;
  result := s = '{\rtf'; //don't resource
end;

{------------------------------------------------------------------}

procedure TDCHTMLImporter.ParseText(const Text : string);
begin
  with THTMLImporter.Create(Self, Text) do
  try
    ParseText;
  finally
    Free;
  end;
end;

{------------------------------------------------------------------}

function  TDCHTMLImporter.IsValidStream(Stream : TStream) : boolean;
begin
  result := true;
end;

{------------------------------------------------------------------}


constructor TIntHTMLParser.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  InitSyntax;
end;

{------------------------------------------------------------------}

function TIntHTMLParser.ParseHTMLColor : integer;
begin
  result := tokInteger;
  _inc(FSourcePtr);
  while FSourcePtr^ in cHexDigit do
    _inc(FSourcePtr);
end;

{------------------------------------------------------------------}

function TIntHTMLParser.ParseHtmlString : integer;
begin
  Result := tokHtmlString;
  _inc(FSourcePtr);
  while not (FSourcePtr^ in cNotHtmlStrChars) do
    _inc(FSourcePtr);
end;

{------------------------------------------------------------------}

function TIntHTMLParser.ParseHtmlParam : integer;
begin
  repeat
    _inc(FSourcePtr);
  until not (FSourcePtr^ in COtherIdentChars);
  result := tokHtmlParam;
end;

{-----------------------------------------------------------}

function TIntHTMLParser.ParseHTMLTag : Integer;
begin
  _inc(FSourcePtr);
  if (FSourcePtr^ = '!') and ((FSourcePtr + 1)^ = '-') and ((FSourcePtr + 2)^ = '-')then
    result := ParseHTMLComment
  else
  begin
    repeat
      _inc(FSourcePtr);
    until not (FSourcePtr^ in COtherIdentChars);
    result := tokHtmlTag;
    ParserState := psHtmlTag;
  end;
end;

{-----------------------------------------------------------}

function TIntHTMLParser.ParseHTMLTagEnd : integer;
begin
  _inc(FSourcePtr);
  result := tokHtmlTag;
  ParserState := psNormal;
end;


{-----------------------------------------------------------}

function TIntHTMLParser.ParseHTMLComment:Integer;
begin
  if FSourcePtr^  = '!' then
  begin
    _inc(FSourcePtr);
    Result := ParseHTMLCommentEnd;
  end
  else
    Result := tokWhiteChar;
end;

{-----------------------------------------------------------}

function TIntHTMLParser.ParseHTMLCommentEnd:Integer;
begin
  if SkipToCharOrEol('-') then
  begin
    if ((FSourcePtr + 1)^ = '-') and  ((FSourcePtr + 2)^ = '>') then
    begin
      inc(FSourcePtr, 3);
      ParserState := psNormal;
    end
    else
    begin
      _inc(FSourcePtr);
      ParserState := psComment2;
    end;
  end
  else
    ParserState := psComment2;
  Result:=tokComment;
end;

{-----------------------------------------------------------}

function TIntHTMLParser.ParseNewLine : integer;
begin
  result := tokWhiteChar;
  _inc(FSourcePtr);
  Importer.FAddSpace := true;
end;

{-----------------------------------------------------------}

procedure TIntHTMLParser.InitSyntax;
begin
  InitCommon;
  RegisterProc([psNormal], ['"'], ParseVBStrConst);
  RegisterProc([psHtmlTag], ['"'],ParseVBStrConst);
  RegisterProc([psNormal], [#0..#255] - cNotHtmlStrChars, ParseHtmlString);
  RegisterProc([psHtmlTag], cFirstIdentChar, ParseHtmlParam);
  RegisterProc([psNormal], ['<'], ParseHTMLTag);
  RegisterProc([psHtmlTag], ['>'], ParseHTMLTagEnd);
  RegisterProc([psNormal], [#13, #10], ParseNewLine);
  RegisterProc([psNormal], cDigit,ParseNumConst);
  RegisterProc([psHtmlTag], cDigit,ParseNumConst);
  RegisterProc([psHtmlTag], ['#'], ParseHTMLColor);
  RegisterProc([psComment2], cWhiteChar, ParseHTMLCommentEnd);
  InitEolState(psComment2);
  InitEolState(psHtmlTag);
end;


{-----------THTMLImporter------------------------------------------}

constructor THTMLImporter.Create(AOwner : TDCImporter; const html : string);
begin
  inherited Create;
  FLinkColor := clBlue;
  FIntImporter := TInternalImporter.Create(AOwner);
  FIntImporter.FDefaultFont := SDefaultFont;

  FParser := TIntHTMLParser.Create(nil);
  TIntHTMLParser(FParser).Importer := FIntImporter;
  FParser.FSourcePtr := Pchar(Html);
end;

{------------------------------------------------------------------}

destructor THTMLImporter.Destroy;
begin
  FIntImporter.Free;
  FParser.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------}

function  THTMLImporter.TokenStringToResWord(s : string; var Negate : boolean) : integer;
begin
  delete(s, 1, 1);
  Negate := (s <> '') and (s[1] = '/');
  if Negate then
    delete(s, 1, 1);
  if CompareText(s, SLineBreakTag) = 0 then
    result := id_line
  else
  if CompareText(s, SParTag) = 0 then
    result := id_par
  else
  if CompareText(s, SFontTag)  = 0 then
    result := id_f
  else
  if CompareText(s, SBigFontTag) = 0 then
    result := id_big
  else
  if CompareText(s, SSmallFontTag) = 0 then
    result := id_small
  else
  if CompareText(s, SBoldFontTag) = 0 then
    result := id_bold
  else
  if CompareText(s, SItalicFontTag) = 0 then
    result := id_i
  else
  if CompareText(s, SUnderlineFontTag) = 0 then
    result := id_ul
  else
  if CompareText(s, SStrikeOutFontTag) = 0 then
    result := id_strike
  else
  if CompareText(s, SRefTag) = 0 then
    result := id_href
  else
  if CompareText(s, SHeadTag) = 0 then
    result := id_head
  else
  if CompareText(s, SBodyTag) = 0 then
    result := id_body
  else
  if CompareText(s, SStrongTag) = 0 then
    result := id_strong
  else
  if CompareText(s, SEmTag) = 0 then
    result := id_em
  else
    result := - 1;

 {
  SNumberedListTag     = 'ol';
  SBulletedListTag     = 'ul';
  SListItemTag         = 'li';
  SQuoteTag            = 'blockquote';
 }
end;

{------------------------------------------------------------------}

procedure THTMLImporter.ParseText;
var
  AToken   : integer;
  FResWord : integer;
  Negate   : boolean;
  FCurSize : integer;

  {---------------------------------------------------------}

  procedure ParseParams;
  var
    AToken : integer;
  begin
    with FParser do
    begin
      AToken := Token;
      while not ParserEof do
      begin
        if (AToken = tokHtmlTag) and (ParserState = psNormal) then
          break;
        AToken := NextToken;
      end;
    end;  
  end;

  {---------------------------------------------------------}

  procedure ParseFontParams;
  var
    Val : string;
  begin
    with FParser, FIntImporter do
      while not ParserEof do
      begin
        AToken := NextToken;
        if (AToken = tokHtmlTag) and (ParserState = psNormal) then
          break;
        if AToken = tokHtmlParam then
        begin
          Val := RemoveQuotes(PeekTokenStr);
          if CompareText(TokenString, SFontFaceTag)  = 0 then
            WriteFontName(RemoveQuotes(Val), DEFAULT_CHARSET)
          else
          if CompareText(TokenString, SFontSizeTag)  = 0 then
          begin
            FCurSize := StrToIntDef(Val, 1);
            WriteFontSize(HtmlSizeToFontSize(FCurSize));
          end
          else
          if CompareText(TokenString, SFontColorTag) = 0 then
            WriteFontColor(HTMLStringToColor(Val))
        end;
      end;
  end;

  {---------------------------------------------------------}

  procedure ParseBodyParams;
  begin
    with FParser, FIntImporter do
      while not ParserEof do
      begin
        AToken := NextToken;
        if (AToken = tokHtmlTag) and (ParserState = psNormal) then
          break;
        if (AToken = tokHtmlParam) and (CompareText(TokenString, SLinkTag) = 0) then
        begin
          NextToken;
          FLinkColor := HTMLStringToColor(RemoveQuotes(TokenString));
        end;
      end;
  end;

  {---------------------------------------------------------}

  procedure WriteStr(const s : string);
  begin
    with FIntImporter do
      if (s = sNewLine) then
        WriteString(' ')
      else
      if (s <> '') then
        WriteString(HtmlToString(s))
  end;

  {---------------------------------------------------------}

begin
  FCurSize := 1;
  with FParser, FIntImporter do
    while not (ParserEof) do
    begin
      AToken := NextToken;
      case AToken of
        tokHtmlTag   :
          begin
            FAddSpace := false;
            FResWord := TokenStringToResWord(trim(TokenString), Negate);
            if FResWord = id_head then
            begin
              while not ParserEof do
                if (NextToken = tokHtmlTag) and (CompareText(TokenString, '</' + SheadTag)  = 0) then
                  break;
              continue;
            end
            else
            if FResWord = id_body then
            begin
              ParseBodyParams;
              continue;
            end
            else
            if FResWord >= 0 then
              if not Negate then
              begin
                Push(FResWord);
                case FResWord of
                  id_bold, id_strong :
                    WriteFontStyle(fsBold, true);
                  id_f :
                  begin
                    ParseFontParams;
                    continue;
                  end;
                  id_i, id_em : WriteFontStyle(fsItalic, true);
                  id_line :
                    WriteString(SNewLine);
                  id_par :
                  begin
                    WriteString(SNewLine);
                    WriteString(SNewLine);
                  end;
                  id_strike : WriteFontStyle(fsStrikeOut, true);
                  id_ul : WriteFontStyle(fsUnderLine, true);
                  id_href :
                  begin
                    WriteFontStyle(fsUnderLine, true);
                    WriteFontColor(FLinkColor);
                  end;
                  id_big :
                  begin
                    inc(FCurSize);
                    WriteFontSize(HtmlSizeToFontSize(FCurSize));
                  end;
                  id_small :
                  begin
                    if FCurSize > 1 then
                      dec(FCurSize);
                    WriteFontSize(HtmlSizeToFontSize(FCurSize));
                  end;
                end;
              end
              else
              begin
                Pop(FResWord);
                case FResWord of
                  id_big : dec(FCurSize);
                  id_small : inc(FCurSize);
                end;
              end;
             ParseParams;
          end;
        tokInteger, tokHtmlString :
        begin
          if FAddSpace then
            WriteStr(TrimLeft(TokenString))
          else
            WriteStr(TokenString);
        end
        else
          FAddSpace := false;
      end;
    end;
  with FIntImporter, FStack do
    while Count > 0 do
      Pop(- 1);
end;

{---------TRtfImporter----------------------------------------------}

constructor TRtfImporter.Create(AOwner : TDCImporter; const rtf : string);
begin
  inherited Create(rtf);
  FIntImporter := TInternalImporter.Create(AOwner);
  FIntImporter.FFontTable := FFontTable;
end;

{------------------------------------------------------------------}

destructor TRtfImporter.Destroy;
begin
  FIntImporter.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------}

procedure TRtfImporter.ParseText;
var
  s         : string;
  AIndex    : integer;
  AColor    : TColor;
  AToken    : integer;
  PrevToken : integer;
  Unicode   : integer;

  {------------------------------------------------------------------}

  procedure WriteSpecialChar;
  var
    s      : string;
    AIndex : integer;
  begin
    with FParser, FIntImporter do
    begin
      s := '';

      while not ParserEof do
      begin
        s := s + FSpecialChar;
        if (FSourcePtr^ = '\') and ((FSourcePtr + 1)^ = '''') then
          NextToken
        else
          break;
      end;
      WriteString(s);
      AIndex := 0;
      while not ((FSourcePtr + AIndex)^ in cNotStrChars) do
      begin
        {$IFDEF DCMBCS}
        if SysLocale.FarEast and ((FSourcePtr + AIndex)^ in LeadBytes) then
          break;
        {$ENDIF}
        inc(AIndex);
      end;  
      if AIndex <> 0 then
      begin
        SetString(s, FSourcePtr, AIndex);
        if s <> '' then
           WriteString(s);
        inc(FSourcePtr, AIndex);
      end;
    end;
  end;
  {------------------------------------------------------------------}

  procedure WriteStr(const s : string);
  begin
    if (s <> '') and (s <> sNewLine) then
      FIntImporter.WriteString(s);
  end;

  {------------------------------------------------------------------}

  {$IFNDEF CLX}
  procedure WriteUnicode(Unicode : word);
  var
    Ch : WideChar;
    s  : string;
  begin
    Ch := WideChar(Unicode);
    SetLength(s, 2);
    WideCharToMultiByte(CP_ACP, 0, @Ch, 1, Pointer(s), 2, nil, nil);
    if s[2] = #0 then
      SetLength(s, 1);
    WriteStr(s);
  end;
  {$ENDIF}

  {------------------------------------------------------------------}


begin

  PrevToken := tokWhiteChar;
  with FParser, FIntImporter do
    while not (ParserEof) do
    begin
      AToken := NextToken;
      case AToken of
        TokGroupBegin :
        begin
          s := PeekTokenStr;
          if (s = '\colortbl') then
          begin
            ProcessColorTable;
            Continue;
          end
          else
            if (trim(s) <> '\') and (Pos(s, wrongwords) <> 0) then
            begin
              SkipGroup;
              Continue;
            end;
          Push(- 1);
          WriteStr(FAfterGroup);
        end;
        TokGroupEnd   : Pop(- 1);
        tokResWord    :
          begin
            case FResWord of
              id_bold :
                WriteFontStyle(fsBold, FSourcePtr^ <> '0');
              id_cf :
              begin
                AIndex := StrToIntDef(PeekTokenStr, - 1);
                if AIndex <> - 1 then
                begin
                  NextToken;
                  with FColorTable do
                    if (AIndex >= 0) and (AIndex < Count) then
                      WriteFontColor(StrToInt(Strings[AIndex]));
                end;
              end;
              id_f , id_pnf :
              begin
                NextToken;
                AIndex := StrToInt(TokenString);
                with FFontTable do
                  if (AIndex >= 0) and (AIndex < Count) then
                    WriteFontName(Strings[AIndex], TFontCharSet(Objects[AIndex]));
              end;
              id_fs :
              begin
                NextToken;
                if TokenString = '-' then
                begin
                  NextToken;
                  WriteFontSize(72);
                end
                else
                  WriteFontSize(StrToIntDef(TokenString, 24) div 2);
              end;
              id_i : WriteFontStyle(fsItalic, FSourcePtr^ <> '0');
              id_highlight :
              begin
                NextToken;
                AIndex := StrToInt(TokenString);
                with FColorTable do
                  if (AIndex >= 0) and (AIndex < Count) then
                    AColor := StrToInt(Strings[AIndex])
                  else
                    AColor := - 1;
                if (AIndex = 0) and (AColor = 0) then
                  WriteColor(- 1)
                else
                  WriteColor(AColor);
              end;
              id_par, id_line, id_row :
              begin
                WriteString(SNewLine);
              end;
              id_lquote, id_rquote :
                WriteString('''');
              id_endash :
                WriteString('-');
              id_plain : ClearFont;
              id_rtf : SkipToFontTable;
              id_strike : WriteFontStyle(fsStrikeOut, FSourcePtr^ <> '0');
              id_tab, id_cell : WriteString(#9);
              id_u :
              begin
                NextToken;
                Unicode := StrToIntDef(TokenString, - 1);
                {$IFNDEF CLX}
                if Unicode <> -1 then
                  WriteUnicode(Unicode);
                {$ENDIF}  
                case NextToken of
                  tokString :
                    if Unicode = -1 then
                      WriteString(s);
                  tokSpecialChar :
                    if Unicode = -1 then
                      WriteSpecialChar;
                end;
              end;
              id_ul : WriteFontStyle(fsUnderLine, FSourcePtr^ <> '0');
              id_ulnone : WriteFontStyle(fsUnderLine, false);
            end;
            FParser.SkipRtfDigits;
          end;
        tokUnknownResword :
          if FSourcePtr^ = '~' then
          begin
            WriteStr(' ');
            _inc(FSourcePtr);
          end
          else
            SkipRtfDigits;
        tokSpecialChar : WriteSpecialChar;
        tokString, tokInteger, tokFloat :
        begin
          s := DCRemoveSlash(TokenString, (FTokenPtr <> FLinePtr) and ((PrevToken = tokResWord) or (PrevToken = tokUnknownResword)));
          WriteStr(s)
        end;
      end;
      PrevToken := AToken;
    end;
  with FIntImporter, FStack do
    while Count > 0 do
      Pop(- 1);
end;

{-------TInternalImporter-----------------------------------------}

constructor TInternalImporter.Create(AOwner : TDCImporter);
begin
  inherited Create;
  FStack := TStringList.Create;
  FFont  := TFont.Create;
  FOwner := AOwner;
end;

{------------------------------------------------------------------}

destructor TInternalImporter.Destroy;
var
  rec : PImportRecord;
  i   : integer;
begin
  with FStack do
    for i := Count - 1 downto 0 do
    begin
      rec := PImportRecord(Objects[i]);
      rec^.FFontName := '';
      dispose(rec);
    end;
  FStack.Free;
  FFont.Free;
end;

{------------------------------------------------------------------}

procedure TInternalImporter.Push(id : integer);
var
  Rec : PImportRecord;
begin
  new(Rec);
  ClearRecord(Rec);
  Rec.Id := Id;
  FStack.AddObject('', Pointer(Rec));
end;

{------------------------------------------------------------------}

procedure TInternalImporter.Pop(id : integer);
var
  rec : PImportRecord;
  i   : integer;
begin
  with FStack do
    if Count > 0 then
    begin
      i := Count - 1;
      if id <> -1 then
        while (i >=0) and (PImportRecord(Objects[i])^.id <> id)  do
          dec(i);
      if i >= 0 then
      begin
        rec := PImportRecord(Objects[i]);
        rec^.FFontName := '';
        Dispose(rec);
        Delete(i);
      end;
    end;
end;

{------------------------------------------------------------------}

procedure TInternalImporter.WriteFontStyle(Style : TFontStyle; turnOn : boolean);
var
  Current : PImportRecord;
begin
  Current := CheckStackPoint;
  with Current^ do
  begin
    FStyleValid := true;
    if turnOn then
    begin
      if Style in FExcludeStyle then
        exclude(FExcludeStyle, Style);
      include(FFontStyle, Style)
    end
    else
    begin
      if Style in FFontStyle then
        exclude(FFontStyle, Style);
      include(FExcludeStyle, Style);
    end;
  end;
end;

{------------------------------------------------------------------}

procedure TInternalImporter.WriteColor(Color : TColor);
var
  Current : PImportRecord;
begin
  Current := CheckStackPoint;
  with Current^ do
  begin
    FColor := Color;
    FColorValid := true;
  end;
end;

{------------------------------------------------------------------}

procedure TInternalImporter.WriteFontColor(Color : TColor);
var
  Current : PImportRecord;
begin
  Current := CheckStackPoint;
  with Current^ do
    FFontColor := Color;
end;

{------------------------------------------------------------------}

procedure TInternalImporter.WriteFontName(FontName : string; FontCharSet : TFontCharSEt);
var
  Current : PImportRecord;
begin
  Current := CheckStackPoint;
  with Current^ do
  begin
    FFontName := FontName;
    FFontCharSet := FontCharSet;
  end;
end;

{------------------------------------------------------------------}

procedure TInternalImporter.WriteFontSize(FontSize : integer);
var
  Current : PImportRecord;
begin
  Current := CheckStackPoint;
  with Current^ do
    FFontSize := FontSize;
end;

{------------------------------------------------------------------}

procedure TInternalImporter.ClearRecord(Value : PImportRecord);
begin
  with Value^ do
  begin
    FFontSize := - 1;
    FFontName := '';
    FFontCharSet := DEFAULT_CHARSET;
    FColor := - 1;
    FFontColor := - 1;
    FFontStyle := [];
    FExcludeStyle := [];
    FStyleValid := false;
    FColorValid := false;
  end;
end;

{------------------------------------------------------------------}

procedure TInternalImporter.ClearFont;
var
  Current : PImportRecord;
begin
  Current := CheckStackPoint;
  with Current^ do
  begin
    FFontName := DefaultFont(FFontCharSet);
    FFontSize := 12;
    FColor := - 1;
    FFontColor := 0;
    FFontStyle := [];
    FExcludeStyle := [];
    FStyleValid := true;
    FColorValid := false;
  end;
end;

{------------------------------------------------------------------}

function TInternalImporter.DefaultFont(var CharSet : TFontCharSet) : string;
begin
  result := FDefaultFont;
  CharSet := DEFAULT_CHARSET;
  if FFontTable <> nil then
    with FFontTable do
      if Count > 0 then
      begin
        result := Strings[0];
        CharSet := TFontCharset(Objects[0]);
      end;
end;

{------------------------------------------------------------------}

procedure TInternalImporter.CurrentFont(Font : TFont ; var Color : TColor);
var
  Rec    : PImportRecord;
  i      : integer;
  AName  : boolean;
  Cs     : TFontCharset;
begin

  with Font do
  begin
    Name := '';
    Size := - 1;
    Color := - 1;
    Style := [];
  end;

  Color := - 1;
  AName := false;
  with FStack do
    for i := 0 to Count - 1 do
    begin
      rec := PImportRecord(Objects[i]);
      with rec^ do
      begin
        if (FFontName <> '') then
        begin
          Font.Name := FFontName;
          {$IFDEF D3}
          Font.CharSet := FFontCharSet;
          {$ENDIF}
          AName := true;
        end;
        if (FFontSize <> - 1) then
          Font.Size := FFontSize;
        if (FFontColor <> - 1) then
          Font.Color := FFontColor;
        if FStyleValid then
          if (FFontStyle = []) and (FExcludeStyle = []) then
            Font.Style := []
          else
            Font.Style := Font.Style + FFontStyle - FExcludeStyle;
        if FColorValid then
          Color := FColor;
      end;
    end;
  if not AName then
    Font.Name := DefaultFont(Cs);
  if Font.Size < 0 then
    Font.Size := 12;
  if Font.Color < 0 then
    Font.Color := 0;
end;

{------------------------------------------------------------------}

procedure TInternalImporter.WriteString(const s : string);
var
  AColor : TColor;
begin
  if (s <> '') then
  begin
    CurrentFont(FFont, AColor);
    if FAddSpace and (s <> SNewLine) then
      FOwner.TextChanged(' ' + s, FFont, AColor)
    else
      FOwner.TextChanged(s, FFont, AColor);
  end;
  FAddSpace := false;
end;

{------------------------------------------------------------------}


function  TInternalImporter.CheckStackPoint : PImportRecord;
begin
  with FStack do
  begin
    if Count = 0 then
      Push(- 1);
    result := Pointer(Objects[Count - 1]);
  end;
end;

{------------------------------------------------------------------}


function TRTFWriterList.GetIgnoreCharSet: Boolean;
begin
  Result := FFontObject.IgnoreCharSet;
end;

{---------------------------------------------------------------------------}

procedure TRTFWriterList.SetIgnoreCharSet(const Value: Boolean);
begin
  FFontObject.IgnoreCharSet := Value;
end;

{---------------------------------------------------------------------------}

Function DCGetGroupSectionKind( AKind : TDCSectionKind ) : TDCSectionKind;
begin
  Case AKind Of
    skClass     : Result := skClassesGroup;
    skInterface : Result := skInterfacesGroup;
    skType      : Result := skTypesGroup;
    skProcedure : Result := skProceduresGroup;
    skVariable  : Result := skVariableGroup;
    skUnit      : Result := skUnitsGroup;
    Else  Result := AKind;
  End;
end;

{---------------------------------------------------------------------------}

end.
