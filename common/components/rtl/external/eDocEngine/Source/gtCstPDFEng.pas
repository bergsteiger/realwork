{ *************************************************************************** }
{ }
{ Gnostice eDocEngine }
{ }
{ Copyright © 2002-2013 Gnostice Information Technologies Private Limited }
{ http://www.gnostice.com }
{ }
{ *************************************************************************** }

{ ------------------------------------ }
{ Editor Options }
{ ------------------------------------ }
{ }
{ Tab Stops = 2 }
{ Use Tab Character = True }
{ }
{ ------------------------------------ }

{$I gtDefines.inc}
{$I gtDocDefines.inc}
{$IFDEF gtActiveX}
{$R eDocEngineX.res}
{$ENDIF}
unit gtCstPDFEng;

interface

uses
  Windows, Classes, Graphics, SysUtils, Forms, gtConsts3, gtDocConsts,
  gtCstPlnEng, gtCstDocEng, gtDocUtils {$IFDEF WIN32} , gtdzlib3{$ENDIF}
{$IFDEF WIN64}, System.ZLib{$ENDIF}, gtClasses3, gtPDFFont3,
  gtUtils3, gtDocResStrs, gtPDFCrypt3, jpeg, gtGlyphInfo, Dialogs,
  gtDigitalSignature3;
// gtEnvelope3,
// gtJwaWinCrypt3;

type
  TgtPDFPattern = (pHorizontal, pVertical, pFDiagonal, pBDiagonal,
    pCross, pDCross);

  TgtAnnotBrushStyle = (absSolid, absDashed, absBeveled, absInset,
    absUnderline);

  TgtPathStatus = (psPathBegins, psPathEnds, psNoPath);

  (* Compression Levels *)
  TgtCompressionLevel = (clFastest, clNormal, clMaxCompress);

  (* Ellipse Control Points. *)
  TgtEllipseCtrlPoints = record
    X1, X2, X3, X4, X5, Y1, Y2, Y3, Y4, Y5: Double;
  end;

  (*
    Line Type: Underline or Strikeout.
    Indicates whether font style is underline/strikeout.
  *)
  TgtLineType = (ltUnderline, ltStrikeOut);

  (* PDF Font Encoding Types. *)
  TgtPDFFontEncoding = (feWinAnsiEncoding, feMacRomanEncoding,
    feMacExpertEncoding, feStandardEncoding, fePDFDocEncoding);

  TgtTransitionEffect = (teNone, teSplitHorizontalInward,
    teSplitHorizontalOutward, teSplitVerticalInward, teSplitVerticalOutward,
    teBlindsHorizontal, teBlindsVertical, teBoxInward, teBoxOutward,
    teWipeLeftToRight, teWipeBottomToTop, teWipeRightToLeft, teWipeTopToBottom,
    teDissolve, teGlitterLeftToRight, teGlitterTopToBottom,
    teGlitterTopLeftToBottomRight);
  { ----------------------Digital Signature--------------------------------- }
  // signature display options
  TgtSigFieldAppearenceOptions = set of TgtSigFieldAppearenceOption;

  { TgtSigBounds }

  TgtSigFieldBounds = class(TPersistent)
  private
    FFLLeft: Double;
    FFLTop: Double;
    FFLRight: Double;
    FFLBotom: Double;
  public
    constructor Create; overload;
  published
    property FLLeft: Double read FFLLeft write FFLLeft;
    property FLTop: Double read FFLTop write FFLTop;
    property FLRight: Double read FFLRight write FFLRight;
    property FLBotom: Double read FFLBotom write FFLBotom;
  end;

  { TgtFieldProperties }

  TgtFieldProperties = class(TPersistent)
  private
    FVisible: boolean;
    FFieldName: WideString;
    FFieldBounds: TgtSigFieldBounds;
    FBackColor: TColor;
    FPageNumber: Integer;
    FFieldAppearenceOptions: TgtSigFieldAppearenceOptions;
    FFont: TFont;
  protected
    function ReadFieldBounds: TgtSigFieldBounds;
    procedure WriteFieldBounds(AFieldBounds: TgtSigFieldBounds);
  public
    constructor Create; overload;
    destructor Destroy; override;
    property Font: TFont read FFont write FFont;
  published
    property Visible: boolean read FVisible write FVisible;
    property FieldName: WideString read FFieldName write FFieldName;
    property FieldBounds: TgtSigFieldBounds read ReadFieldBounds
      write WriteFieldBounds;
    property FillColor: TColor read FBackColor write FBackColor default clWhite;
    property PageNumber: Integer read FPageNumber write FPageNumber;
    property FieldAppearenceOptions: TgtSigFieldAppearenceOptions
      read FFieldAppearenceOptions write FFieldAppearenceOptions;
  end;

  { TgtSignature }

  TgtSignature = class(TPersistent)
  Private
    FAuther: WideString;
    FReason: WideString;
    FLocation: WideString;
    FContactInfo: WideString;
    FCertFileName: TFileName;
    FCertPassword: WideString;
    FFilter: WideString;
    FSubFilter: WideString;
    FCirtificationLevel: TgtSigCertLevel;
    FSigFieldAppearenceOptions: TgtSigFieldAppearenceOptions;
    FOffset1, FOffset2, FOffset3, FOffset4: Int64;
    FDateTime: TDateTime;
  protected
    property Filter: WideString read FFilter write FFilter;
    property SubFilter: WideString read FSubFilter write FSubFilter;
    property CirtificationLevel: TgtSigCertLevel read FCirtificationLevel
      write FCirtificationLevel;
    property Offset1: Int64 read FOffset1 write FOffset1;
    property Offset2: Int64 read FOffset2 write FOffset2;
    property Offset3: Int64 read FOffset3 write FOffset3;
    property Offset4: Int64 read FOffset4 write FOffset4;
  public
    property SigFieldAppearenceOptions: TgtSigFieldAppearenceOptions
      read FSigFieldAppearenceOptions write FSigFieldAppearenceOptions;
    constructor Create; overload;
  published
    property CertFileName: TFileName read FCertFileName write FCertFileName;
    property CertPassword: WideString read FCertPassword write FCertPassword;
    property Author: WideString read FAuther write FAuther;
    Property Reason: WideString read FReason write FReason;
    property Location: WideString read FLocation write FLocation;
    property ContactInfo: WideString read FContactInfo write FContactInfo;
    property DateTime: TDateTime read FDateTime write FDateTime;
  end;

  { TgtDate Record }

  TgtDate = record
    Year: Word;
    Month: Word;
    Day: Word;
    Hour: Word;
    Minutes: Word;
    Seconds: Word;
    MilliSeconds: Word;
  end;

  TgtDigitalSignature = class(TPersistent)
  private
    FEnabled: boolean;
    FFieldProperties: TgtFieldProperties;
    FSignatureProperties: TgtSignature;
  public
    constructor Create; overload;
    destructor Destroy; override;
  published
    property Enabled: boolean read FEnabled write FEnabled default False;
    property FieldProperties: TgtFieldProperties read FFieldProperties
      write FFieldProperties;
    property SignatureProperties: TgtSignature read FSignatureProperties
      write FSignatureProperties;

  end;

  TgtPresentationMode = class(TPersistent)
  private
    FDuration: Integer;
    FTransitionEffect: TgtTransitionEffect;
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Duration: Integer read FDuration write FDuration default 1;
    property TransitionEffect: TgtTransitionEffect read FTransitionEffect
      write FTransitionEffect default teNone;
  end;

  TgtRunStore = class
  private
    FRunText: WideString;
    FFont: TFont;
    FGlyphInfoList: TgtGlyphInfoList;
    FRunInfo: TgtRunInfo;
    FLogClust: TgtWordArray;
    FAngle: Integer;
    procedure SetAngle(const Value: Integer);
    procedure SetLogClust(const Value: TgtWordArray);
    procedure SetGlyphInfoList(const Value: TgtGlyphInfoList);
    procedure SetFont(const Value: TFont);
    procedure SetRunInfo(const Value: TgtRunInfo);
    procedure SetRunText(const Value: WideString);
  public
    property RunText: WideString read FRunText write SetRunText;
    property Font: TFont read FFont write SetFont;
    property GlyphInfoList: TgtGlyphInfoList read FGlyphInfoList
      write SetGlyphInfoList;
    property RunInfo: TgtRunInfo read FRunInfo write SetRunInfo;
    property LogClust: TgtWordArray read FLogClust write SetLogClust;
    property Angle: Integer read FAngle write SetAngle;
    constructor Create;
    destructor Destroy; override;
  end;

  TgtPageLayout = (plSinglePage, plOneColumn, plTwoColumnLeft,
    plTwoColumnRight);

  TgtPageMode = (pmUseNone, pmUseOutlines, pmUseThumbs, pmFullScreen);

  TgtNonFullScreenPageMode = (nfspmUseNone, nfspmUseOutlines, nfspmUseThumbs);

  TgtViewerPreferences = class(TPersistent)
  private
    FPageLayout: TgtPageLayout;
    FPageMode: TgtPageMode;
    FHideToolBar: boolean;
    FHideMenuBar: boolean;
    FHideWindowUI: boolean;
    FFitWindow: boolean;
    FCenterWindow: boolean;
    FNonFullScreenPageMode: TgtNonFullScreenPageMode;
    FPresentationMode: TgtPresentationMode;
    procedure SetPresentationMode(AValue: TgtPresentationMode);
    procedure SetCenterWindow(const Value: boolean);
    procedure SetFitWindow(const Value: boolean);
    procedure SetHideMenuBar(const Value: boolean);
    procedure SetHideToolBar(const Value: boolean);
    procedure SetHideWindowUI(const Value: boolean);
    procedure SetNonFullScreenPageMode(const Value: TgtNonFullScreenPageMode);
    procedure SetPageLayout(const Value: TgtPageLayout);
    procedure SetPageMode(const Value: TgtPageMode);
  public
    constructor Create;
    destructor Destroy; override;
    function GetViewerPreferences(APageMode: TgtPageMode;
      APageLayout: TgtPageLayout; ACenterWindow, AFitWindow, AHideWindowUI,
      AHideMenuBar, AHideToolBar: boolean;
      ANonFullScreenPageMode: TgtNonFullScreenPageMode): String;
    function GetTransitionEffectAndDuration(ADuration: Integer;
      ATransitionEffect: TgtTransitionEffect): String;
  published
    property PageLayout: TgtPageLayout read FPageLayout write SetPageLayout
      default plOneColumn;
    property PageMode: TgtPageMode read FPageMode write SetPageMode
      default pmUseNone;
    property HideToolBar: boolean read FHideToolBar write SetHideToolBar
      default False;
    property HideMenuBar: boolean read FHideMenuBar write SetHideMenuBar
      default False;
    property HideWindowUI: boolean read FHideWindowUI write SetHideWindowUI
      default False;
    property FitWindow: boolean read FFitWindow write SetFitWindow
      default False;
    property CenterWindow: boolean read FCenterWindow write SetCenterWindow
      default False;
    property NonFullScreenPageMode: TgtNonFullScreenPageMode
      read FNonFullScreenPageMode write SetNonFullScreenPageMode
      default nfspmUseNone;
    property PresentationMode: TgtPresentationMode read FPresentationMode
      write SetPresentationMode;
  end;

  (*
    Thumbnail Object similar to TgtImageItem.
    Thumbnails doesnot support image properties like -
    Center, Stretch or Autosize
  *)
  TgtPDFThumbnailItem = class;

  TgtPDFThumbnailItem = class(TgtDocumentItem)
  private
    FOutputImageFormat: TgtOutputImageFormat;
    FImagePixelFormat: TPixelFormat;
    FJPEGQuality: Integer;
    FIndexNo: Integer;
    FObjNo: Integer;
    procedure SetImagePixelFormat(const Value: TPixelFormat);
    procedure SetIndexNo(const Value: Integer);
    procedure SetJPEGQuality(const Value: Integer);
    procedure SetOutputImageFormat(const Value: TgtOutputImageFormat);
    procedure SetObjNo(const Value: Integer);

  public
    constructor Create;
    destructor Destroy; override;

    property OutputImageFormat: TgtOutputImageFormat read FOutputImageFormat
      write SetOutputImageFormat;
    property ImagePixelFormat: TPixelFormat read FImagePixelFormat
      write SetImagePixelFormat;
    property JPEGQuality: Integer read FJPEGQuality write SetJPEGQuality;
    property IndexNo: Integer read FIndexNo write SetIndexNo;
    property ObjNo: Integer read FObjNo write SetObjNo;
    function IsEqual(AThumbnail: TgtPDFThumbnailItem): boolean;

  end;

  (*
    Required for reuse image.
    Holds the settings of an already rendered image along with its assigned
    object no.
  *)
  TgtPDFImageSettings = class(TgtImageSettings)
  private
    FObjNo: Integer;

    (* Next 4 fields Required for Center. *)
    FImageWidth, FImageHeight, FDisplayWidth, FDisplayHeight: Double;
    procedure SetObjNo(const Value: Integer);
    procedure SetDisplayHeight(const Value: Double);
    procedure SetDisplayWidth(const Value: Double);
    procedure SetImageHeight(const Value: Double);
    procedure SetImageWidth(const Value: Double);
  public
    constructor Create; override;
    destructor Destroy; override;
    (*
      This functions checks whether the existing image can be reuseable
      for current image.
    *)
    function IsEqual(AObject: TgtImageItem;
      AOriginalWidth, AOriginalHeight: Integer): boolean;

    property ObjNo: Integer read FObjNo write SetObjNo;
    property ImageWidth: Double read FImageWidth write SetImageWidth;
    property ImageHeight: Double read FImageHeight write SetImageHeight;
    property DisplayWidth: Double read FDisplayWidth write SetDisplayWidth;
    property DisplayHeight: Double read FDisplayHeight write SetDisplayHeight;

  end;

  TgtTTFontEmbedding = (etfNone, etfFull, etfSubset);

  { TgtPDFPreferences }

  TgtPDFPreferences = class(TgtPlainSheetPreferences)
  private
    FEmbedTrueTypeFonts: TgtTTFontEmbedding;
    FApplyEmfCharSpacing: boolean;
    procedure SetEmbedTrueTypeFonts(const Value: TgtTTFontEmbedding);
    procedure SetApplyEmfCharSpacing(const Value: boolean);

  public
    constructor Create; override;
    destructor Destroy; override;

  published
    property EmbedTrueTypeFonts: TgtTTFontEmbedding read FEmbedTrueTypeFonts
      write SetEmbedTrueTypeFonts default etfNone;
    Property ApplyEmfCharSpacing: boolean read FApplyEmfCharSpacing
      write SetApplyEmfCharSpacing default True;

  end;

  { ------------------------------------------------------------------------------ }
  { TgtPDFEngine }
  { ------------------------------------------------------------------------------ }

  (*
    This class maintains ObjectNo, Width & Height of each page.
    This will be used in Outlines and other places in general.
  *)
  TgtPageInfo = class(TObject)
  private
    FObjNo: Integer;
    FWidth, FHeight: Double;
    procedure SetHeight(const Value: Double);
    procedure SetObjNo(const Value: Integer);
    procedure SetWidth(const Value: Double);
  public
    property ObjNo: Integer read FObjNo write SetObjNo;
    property Width: Double read FWidth write SetWidth;
    property Height: Double read FHeight write SetHeight;

  end;

  TgtCompression = class(TPersistent)
  private
    FEnabled: boolean;
    FLevel: TgtCompressionLevel;
    procedure SetEnabled(const Value: boolean);
    procedure SetLevel(const Value: TgtCompressionLevel);

  public
    constructor Create;
    destructor Destroy; override;

  published
    property Enabled: boolean read FEnabled write SetEnabled default True;
    property Level: TgtCompressionLevel read FLevel write SetLevel
      default clMaxCompress;

  end;

  // TgtWritingMode = (wmHorizontal, wmVertical);

  TgtCustomPDFEngine = class(TgtCustomPlainSheetEngine)
  private
    (* Actual Encryption Object which does Encryption. *)
    FPDFEncrypt: TgtPDFEncryption;
    FEncryptionObjNo: Integer;
    (*
      Reference to Outline Dictionary.
    *)
    FOutlines: Integer;
    FThumbnailList: TStringList;
    FThumbnailReuseList: array of TStringList;
    (* FStream is used throughout to write the contents *)
    FContentStream: TMemoryStream;
    (*
      XReference Table which contains object no and stream position of the
      object.
    *)
    FXRefTable: TStringList;
    (* Holds background image object no. index. *)
    FBGImageObj: Integer;
    FBackgroundImageWidth: Extended;
    FBackgroundImageHeight: Extended;
    FBackgroundImageLeft: Extended;
    FBackgroundImageTop: Extended;
    (* Holds current page content object no. *)
    FContentsObjNo: Integer;
    (* Holds current page content stream length object no. *)
    FLengthObjNo: Integer;
    (* Holds the last object no. *)
    FLastObjNo: Integer;
    (* Holds the reference to and position of image object in FImageStream. *)
    FImageXRefList: TStringList;
    (*
      Required for image reuse.
      For each TGraphic object in FImageResourceList, list of different settings
      is maintained.
    *)
    FImageSettings: array of TList;
    (*
      Stream used to store image objects.
      On EndPage, contents of FImageStream will be moved to FStream and cleared.
    *)
    FImageStream: TStream;
    FPattern: TStringList;

    FFontEncoding: TgtPDFFontEncoding;
    FFontEmbedExcludeList: TStringList;
    FCompression: TgtCompression;
    FViewerPreferences: TgtViewerPreferences;
    FEncryption: TgtPDFEncryptionSettings;
    // digital signature
    FDigitalSignature: TgtDigitalSignature;
    FIsClipState: boolean;
    FPathStatus: TgtPathStatus;
    FIsPathClosed: boolean;
    FFirstPoint: boolean;
    FInitialPos: TgtPoint;
    FPath: String;
    FIsClipPath: boolean;
    // Required for Script Run processing
    FCurrentTextObj: TgtTextItem;
    FRunTextX, FRunTextY: Double;
    FRunFont: TFont;
    FSysFonts: TStringList;
    FMapFont: TgtMapFont;
    FRunStoreList: TList;
    FRunStore: TgtRunStore;
    // Digital sinature
    { These were used to store offset temporarly }
    FTmpSigOffset1, FTmpSigOffset2: Integer;
    FObjNumSigPage, FObjNumSig: Integer;
    FSignDoc: boolean;
    FSignature: TgtSignature;
    FSigObjNumber: Integer;
    FSigPageNumber: Integer;
    FSigPageObjNumber: Integer;
    FRect: TgtRect;
    FSigFieldName: String;

    procedure SetFontEncoding(const Value: TgtPDFFontEncoding);

    procedure AppendXRef(APos, AObjNo: Integer);
    (*
      Gets the stroke and fill operator ( n, s, f, b* )
      based on Pen and Brush styles.
    *)
    function CompletePDFPath(APen: TPen; ABrush: TBrush;
      CloseAndStroke: boolean = False): String;
    function DrawBorder(AObject: TgtImageItem): String;
    function EncodeImageObjectRef(AIndex: String;
      AObject: TgtImageItem): String;
    (*
      Since EncodeArc can be used for EncodeChord, EncodePie; EncodePDFArc is
      just a wraper which will be used in EncodeArc, EncodeChord & EncodePie.
    *)
    function EncodePDFArc(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Double;
      Pen: TPen): String;
    function GetEllipseCtrlPts(PosX1, PosY1, PosX2, PosY2: Double)
      : TgtEllipseCtrlPoints;
    (* Gets PDF Line Dash Pattern. *)
    function GetLineStyle(AStyle: TPenStyle): String;
    function PDFCurveto(X1, Y1, X2, Y2, X3, Y3: Double): String;
    function PDFShortArc(X, Y, RX, RY: Double; Alpha, Beta: Double): String;
    procedure WriteBackground;
    procedure WritePattern;
    (* Function to write outlines. *)
    procedure WriteOutlines;
    (* Function to write thumbnails. *)
    procedure WriteThumbnails;
    function SaveImageContents(ABitmap: TBitmap): Integer;
    procedure SetFontEmbedExcludeList(const Value: TStringList);
    procedure SetCompression(const Value: TgtCompression);
    function GetPreferences: TgtPDFPreferences;
    procedure SetPreferences(const Value: TgtPDFPreferences);
    procedure SetVeiwerPreferences(const Value: TgtViewerPreferences);
    procedure SetEncryption(const Value: TgtPDFEncryptionSettings);
    function ConvertDelimiters(AString: String): String;
    procedure ScriptRunProc(AText: WideString; ARunIndex, ARunCount: Integer;
      var AGlyphInfoList: TgtGlyphInfoList; ARunInfo: TgtRunInfo;
      ALogClust: TgtWordArray);
    procedure EncodeTextPart(const AText: WideString; AFont: TFont;
      AX, AY: Double; ARunIndex, ARunCount: Integer;
      AGlyphInfoList: TgtGlyphInfoList; ARunInfo: TgtRunInfo;
      ALogClust: TgtWordArray; ACharSpace: Double; AAngle: Integer = 0);

    { function GetTextWidth(const AText: WideString; AFont: TFont;
      AGlyphInfoList: TgtGlyphInfoList; ARunInfo: TgtRunInfo;
      ALogClust: TgtWordArray; ACharSpace: Double): Double; }

    { Digital signature }

    procedure WriteSignatureDigest(AOffset1, AOffset2, AOffset3,
      AOffset4: Int64);

    function GetHexOfStr1(ASourceString: AnsiString; ALength: Integer)
      : AnsiString;
    function DateToPDFString(Value: TgtDate): AnsiString;
    function DateToAppearenceString(Value: TgtDate): AnsiString;
    function IntegerToString(AValue: Integer): AnsiString;

  protected
    (* Fields that will be used in Pro. *)
    (*
      Contains a list of references to annots in current page.
      This is used in Page dictionary.
    *)
    FAnnots: String;
    (* List of fonts used in the PDF file. *)
    FFontTable: TList;
    (* Holds page object nos. *)
    FPageList: TList;
    (*
      Unit used in PDF is Points.
      Convert all pixels units to points.
    *)
    FPixelToPointMultiplier: Double;
    (* FOutputStream will be set to o/p file or to specified UserStream *)
    FOutputStream: TStream;
    FCreationTime: String;

    function ToUnicodeHex(AStr: WideString; AObjNo, AGenNo: Integer): String;

    procedure AddSignatureSpace(AObjectNumber: Integer);

    procedure EncodeEOF(AObject: TgtEOFItem); override;
    procedure EncodeText(AObject: TgtTextItem); override;
    procedure EncodeImage(AObject: TgtImageItem); override;
    procedure EncodeClipRect(AObject: TgtClipItem); override;
    procedure EncodePathItem(AObject: TgtPathItem); override;
    // procedure EncodeParagraph(AObject: TgtParagraphItem); override;
    // procedure EncodeTransformationItem(AObject: TgtTransformationItem);
    // override;
    procedure EncodePolyDraw(AObject: TgtPolyDrawItem); override;
    procedure EncodeImageStream(ImgStream: TgtImageStream); override;
    procedure EncodeLine(X1, Y1, X2, Y2: Double; Pen: TPen); override;
    procedure EncodeRect(X1, Y1, X2, Y2: Double; Pen: TPen;
      Brush: TBrush); override;
    procedure EncodeRoundRect(X1, Y1, X2, Y2, X3, Y3: Double; Pen: TPen;
      Brush: TBrush); override;
    procedure EncodeEllipse(X1, Y1, X2, Y2: Double; Pen: TPen;
      Brush: TBrush); override;
    procedure EncodePolyLine(Points: TgtPoints; NoPoints: Integer;
      IsClosed: boolean; Pen: TPen; Brush: TBrush); override;
    procedure EncodePolyPolyline(AObject: TgtPolyShapeItem;
      IsClosed: boolean); override;
    procedure EncodePolyPolygon(AObject: TgtPolyPolygonItem); override;
    procedure EncodeArc(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Double;
      Pen: TPen); override;
    procedure EncodePie(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Double; Pen: TPen;
      Brush: TBrush); override;
    procedure EncodeChord(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Double; Pen: TPen;
      Brush: TBrush); override;
    procedure EncodePolyBezier(Points: TgtPoints; NoPoints: Integer;
      Pen: TPen); override;
    procedure EndPage; override;
    procedure BeginPage; override;
    procedure Start; override;
    procedure Finish; override;
    function CheckOutputImageFormat(Value: TgtOutputImageFormat; var S: String)
      : boolean; override;
    function ShowSetupModal: Word; override;
    function GetPreferencesClassName: TgtPreferencesClass; override;
    function GetPattern(AStyle: TBrushStyle): String;

    (* Methods that will be used in Pro. *)
    (* Compress stream using ZLib. *)
    function CompressStream(InputStream, OutputStream: TStream;
      ACompressed: boolean = True;
      ACompressionLevel: TgtCompressionLevel = clMaxCompress): Integer;
    function GetAnnotBrushStyle(Width: Integer = 1;
      Style: TgtAnnotBrushStyle = absSolid): String;
    function GetImageFilter(OutputImageFormat: TgtOutputImageFormat): String;
    function GetNativeText(AStr: String): String;
    function GetNativeXPos(X: Extended): Extended;
    function GetNativeYPos(Y: Extended; PageNo: Integer): Extended;
    function GetNewObjNo: Integer;
    (* Function to return bitmap GRB stream. *)
    function GetPDFBitmapStream(ABitmap: TBitmap): TMemoryStream;
    function MakeObjHead(AObjNo: Integer): String;
    function MakeObjRef(AObjNo: Integer): String;
    (* Get No. in the regional settings format. *)
    function NumToStr(AN: Extended): String;
    procedure WriteObj(const AStr: String; AObjNo: Integer;
      AIsObjectComplete: boolean);

    { Digital signature }
    procedure WriteSignature;
    procedure WriteSignatureField(ARect: TgtRect; APageNo: Integer); overload;
    procedure SetSignatureField(ARect: TgtRect; APageNo: Integer);
    function CreateSignatureItem: Integer;
    function GetBorderStyle: string;
    function GetMKEntries: string;
    function GetAPEntries: string;
    procedure writeAppearance(AObjNo: Integer);
    function GetSigText(ASig: TgtSignature): TStringList;
    function GetSigStream(AList: TStringList): TMemoryStream;
    function FloatToStringLocale(AValue: Double): AnsiString;
    function FitTextToWidth(AList: TStringList; AFont: TFont; AWidth: Integer;
      AUpdatedList: TStringList): boolean;
    function FitTextToHeight(AList: TStringList; AFont: TFont; AHeight: Integer;
      ALineSpace: Integer; AUpdatedList: TStringList): boolean;

    (* Methods that will be overriden in Pro. *)
    function GetCatalogDictionary: String; virtual;
    function GetPageDictionary(AObjNo: Integer): String; virtual;
    procedure WriteEncryptionDictionary; virtual;
    function GetTrailer: String; virtual;
    procedure WritePDFStream(var InputStream: TMemoryStream;
      StreamSize, ObjNo, GenNo: Integer); virtual;
    function WritePDFString(InputString: String; ObjNo, GenNo: Integer)
      : String; virtual;
{$IFDEF gtPro}
    function GetBitmapAsCCITTStream(ABitmap: TBitmap;
      AFormat: TgtOutputImageFormat): TMemoryStream; virtual;
{$ENDIF}
    // Digital Signature
    { Properties for temporary variables }
    property TmpSigOffset1: Integer read FTmpSigOffset1 write FTmpSigOffset1;
    property TmpSigOffset2: Integer read FTmpSigOffset2 write FTmpSigOffset2;
    Property ObjNumSigPage: Integer read FObjNumSigPage write FObjNumSigPage;
    property ObjNumSig: Integer read FObjNumSig write FObjNumSig;
    property SignDoc: boolean read FSignDoc write FSignDoc;
    property Signature: TgtSignature read FSignature write FSignature;
    property SigObjNumber: Integer read FSigObjNumber write FSigObjNumber;
    property SigPageNumber: Integer read FSigPageNumber write FSigPageNumber;
    Property SigPageObjNumber: Integer read FSigPageObjNumber
      write FSigPageObjNumber;
    property Rect: TgtRect read FRect write FRect;
    property SigFieldName: String read FSigFieldName write FSigFieldName;
  published
    // BiDi is replaced with a new property called BiDiMode of type TBiDiMode
    property BiDiMode;
    property FileExtension;
    property FileDescription;
    property BackgroundColor;
    property BackgroundImage;
    property BackgroundImageDisplayType;
    property TextEffects;
    property FontEmbedExcludeList: TStringList read FFontEmbedExcludeList
      write SetFontEmbedExcludeList;
    property Compression: TgtCompression read FCompression write SetCompression;
    property Preferences: TgtPDFPreferences read GetPreferences
      write SetPreferences;
    property ViewerPreferences: TgtViewerPreferences read FViewerPreferences
      write SetVeiwerPreferences;
    property FontEncoding: TgtPDFFontEncoding read FFontEncoding
      write SetFontEncoding;
    property Encryption: TgtPDFEncryptionSettings read FEncryption
      write SetEncryption;
    property DigitalSignature: TgtDigitalSignature read FDigitalSignature
      write FDigitalSignature;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure BeginDoc; override;
    procedure EndDoc; override;
    procedure TextOutV(X, Y: Double; Text: WideString;
      TopDown: boolean = True); override;
    procedure DrawJPEGDirect(ARect: TgtRect;
      AImagePixelWidth, AImagePixelHeight: Integer; AStream: TStream); override;
    procedure DrawJPEGDirect(ImageRect: TgtRect; AGraphic: TGraphic); override;
    function AddTOCItem(Title: WideString; ParentNode, PageNumber: Integer;
      Top: Double): Integer; override;
    function AddTOCItem(Title: WideString; ParentNode: Integer; URL: String)
      : Integer; override;
    procedure AddThumbnailImage(AGraphic: TGraphic; PageNo: Integer); overload;
    procedure AddThumbnailImage(Index, PageNo: Integer); overload;
  end;

const
  PDFFontEncodeStrings: array [TgtPDFFontEncoding] of String =
    ('WinAnsiEncoding', 'MacRomanEncoding', 'MacExpertEncoding',
    'StandardEncoding', 'PDFDocEncoding');
  ImageFilter: array [TgtOutputImageFormat] of String = ('/FlateDecode',
    '/DCTDecode', '/LZWDecode', '', ''
{$IFDEF gtPro}, '[/CCITTFaxDecode]', '[/CCITTFaxDecode]' {$ENDIF});

implementation

uses
  Math, gtPDFEngDlg;

{ TgtCustomPDFEngine }

procedure TgtCustomPDFEngine.AppendXRef(APos, AObjNo: Integer);
begin
  FXRefTable.AddObject(IntToStr(APos), TObject(AObjNo));
end;

procedure TgtCustomPDFEngine.BeginDoc;
begin
  inherited;
end;

procedure TgtCustomPDFEngine.BeginPage;
var
  LS: String;
  LATemp: AnsiString;
  LPageInfo: TgtPageInfo;
  LI: Integer;

begin
  inherited;
  FIsClipState := False;
  FPathStatus := psNoPath;
  FIsPathClosed := False;

  FFirstPoint := True;
  FIsClipPath := False;
  FPath := '';
  FImageXRefList.Clear;
  TMemoryStream(FImageStream).Clear;
  TMemoryStream(FContentStream).Clear;

  (*
    resolution transformation matrix: 96/rx  0  0  96/ry  0  0
    rx - input x-resolution
    ry - input y-resolution
  *)

   LS := 'q ' + NumToStr(CPixelsPerInch / InputXRes) + ' 0 0 ' +
   NumToStr(CPixelsPerInch / InputYRes) + ' 0 0 cm' + CRLF;

  LATemp := AnsiString(LS);
  FContentStream.Write(LATemp[1], Length(LS));

  LPageInfo := TgtPageInfo.Create;
  with LPageInfo do
  begin
    ObjNo := GetNewObjNo;
    Width := Pages[CurrentPage - 1].Settings.Width * FPixelToPointMultiplier;
    Height := Pages[CurrentPage - 1].Settings.Height * FPixelToPointMultiplier;
  end;

  LI := FPageList.Count;
  while (LI < CurrentPage) do
  begin
    FPageList.Add(nil);
    Inc(LI);
  end;
  FPageList.Items[CurrentPage - 1] := LPageInfo;

  FContentsObjNo := GetNewObjNo;
  FAnnots := '';
  FLengthObjNo := GetNewObjNo;
  { Digital Signature }
  if ((SigPageNumber = CurrentPage) and (SignDoc)) then
  begin
    WriteSignatureField(Rect, SigPageNumber);
    FAnnots := FAnnots + ' ' + MakeObjRef(SigObjNumber);
  end;

  WriteBackground;
end;

function TgtCustomPDFEngine.CompletePDFPath(APen: TPen; ABrush: TBrush;
  CloseAndStroke: boolean): String;
begin
  (* n - No Filling/Stroking *)
  Result := 'n';

  (*
    If Brush Style <> bsClear AND Pen Style <> psClear then
    b* - Close, Fill & Stroke the path using even-odd rule.
    Else If Brush Style <> bsClear then
    f* - Fill path using even-odd rule. Applies to Complex Shapes.
    Note: Use f - Fill path using Nonzero Winding rule. For simple shapes.
    Else If Pen Style <> psClear then
    s - Close and Stroke path.
    S - Stroke path.
  *)
  if (ABrush <> nil) and (ABrush.Style <> bsClear) and (APen <> nil) and
    (APen.Style <> psClear) then
    Result := 'b*'
  else if (ABrush <> nil) and (ABrush.Style <> bsClear) then
    Result := 'f*'
  else if (APen <> nil) and (APen.Style <> psClear) then
  begin
    if CloseAndStroke then
      Result := 's'
    else
      Result := 'S';
  end
end;

function TgtCustomPDFEngine.CompressStream(InputStream, OutputStream: TStream;
  ACompressed: boolean; ACompressionLevel: TgtCompressionLevel): Integer;
var
  LCmprStream: TCompressionStream;
begin
{$IFNDEF gtRegistered}
  ACompressed := True;
  ACompressionLevel := clMaxCompress;
{$ENDIF}
  Result := InputStream.Size;
  if ACompressed then
  begin
    // Create Compression Stream.
    LCmprStream := TCompressionStream.Create
      (TCompressionLevel(ACompressionLevel), OutputStream);
    try
      Result := OutputStream.Size;
      InputStream.Position := 0;
      LCmprStream.Write(TMemoryStream(InputStream).Memory^, InputStream.Size);
    finally
      FreeAndNil(LCmprStream);
      Result := OutputStream.Size - Result;
    end;
  end
  else
    OutputStream.CopyFrom(InputStream, 0);
end;

constructor TgtCustomPDFEngine.Create(AOwner: TComponent);
begin
  inherited;
  CPixelsPerInch := Screen.PixelsPerInch;
  CPointsToPixels := Screen.PixelsPerInch / 72;
  FileExtension := 'pdf';
  FileDescription := SPDFDescription;
  (* 1 pixel = 0.75 points *)
  // FPixelToPointMultiplier := CInchesToPoints / Screen.PixelsPerInch;
  FPixelToPointMultiplier := 72 / Screen.PixelsPerInch;
  FCompression := TgtCompression.Create;
  FFontEmbedExcludeList := TStringList.Create;
  Capabilities := [ckText, ckImage, ckShape, ckImageStretch, ckImageFrame,
    ckInputRes, ckImageReusable];
  FViewerPreferences := TgtViewerPreferences.Create;
  FEncryption := TgtPDFEncryptionSettings.Create;
{$IFDEF gtActiveX}
  IconBmp.LoadFromResourceID(HInstance, 101);
{$ENDIF}
  FSysFonts := TStringList.Create;
  FMapFont := TgtMapFont.Create;
  FRunStoreList := TList.Create;
  // Digital Signature
  SignDoc := False;
  TmpSigOffset1 := 0;
  TmpSigOffset2 := 0;
  ObjNumSigPage := 0;
  ObjNumSig := 0;
  DigitalSignature := TgtDigitalSignature.Create;
  // CPixelsPerInch := Screen.PixelsPerInch;
  // CPointsToPixels := Screen.PixelsPerInch / 72;
end;

function TgtCustomPDFEngine.CreateSignatureItem: Integer;
begin
  Result := GetNewObjNo;
  AddSignatureSpace(Result);
end;

destructor TgtCustomPDFEngine.Destroy;
begin
  if (FOutputStream <> nil) and (not Preferences.OutputToUserStream) then
    FreeAndNil(FOutputStream);
  FreeAndNil(FCompression);
  FreeAndNil(FFontEmbedExcludeList);
  FreeAndNil(FViewerPreferences);
  FreeAndNil(FEncryption);
  FreeAndNil(FSysFonts);
  FMapFont.Free;
  FRunStoreList.Free;
  FDigitalSignature.Free;

  inherited;
end;

function TgtCustomPDFEngine.DrawBorder(AObject: TgtImageItem): String;
var
  LPath: String;
  DispWidth, DispHeight: Double;
  X1, Y1, X2, Y2, X3, Y3, X4, Y4, Diagonal, DSin, DCos, Alpha: Double;
begin
  Result := '';
  with AObject do
  begin
    X1 := GetNativeXPos(DisplayRect.Left);
    Y1 := GetNativeYPos(DisplayRect.Top, CurrentPage);
    DispWidth := (DisplayRect.Right - DisplayRect.Left) *
      FPixelToPointMultiplier;
    DispHeight := (DisplayRect.Bottom - DisplayRect.Top) *
      FPixelToPointMultiplier;

    DSin := Sin(DegreesToRadians(Settings.Inclination));
    DCos := Cos(DegreesToRadians(Settings.Inclination));

    X2 := X1 + DispHeight * DSin;
    Y2 := Y1 - DispHeight * DCos;

    X4 := X1 + DispWidth * DCos;
    Y4 := Y1 + DispWidth * DSin;

    if DispWidth = 0 then
      Alpha := DegreesToRadians(Settings.Inclination) - PI
    else
      Alpha := DegreesToRadians(Settings.Inclination) -
        ArcTan(DispHeight / DispWidth);
    Diagonal := Sqrt((DispHeight * DispHeight) + (DispWidth * DispWidth));

    X3 := X1 + Diagonal * Cos(Alpha);
    Y3 := Y1 + Diagonal * Sin(Alpha);

    LPath := NumToStr(X1) + ' ' + NumToStr(Y1) + ' m ' + NumToStr(X2) + ' ' +
      NumToStr(Y2) + ' l ' + NumToStr(X3) + ' ' + NumToStr(Y3) + ' l ' +
      NumToStr(X4) + ' ' + NumToStr(Y4) + ' l ' + NumToStr(X1) + ' ' +
      NumToStr(Y1) + ' l ';

    (* Fill Rect. *)
    if (Brush <> nil) then
    begin
      if (Brush.Style = bsSolid) then
        Result := CRLF + 'q' + CRLF + ColorToPDFColor(Brush.Color) + ' rg' +
          CRLF + LPath + CRLF + 'f' + CRLF + 'Q'
      else if (Brush.Style <> bsClear) then
        (*
          Select color space - cs.
          Select color for non-stroking pattern - scn.
        *)
        Result := CRLF + 'q' + CRLF + '/CSP cs ' + ColorToPDFColor(Brush.Color)
          + ' /' + GetPattern(Brush.Style) + ' scn' + CRLF + 'n' + CRLF + LPath
          + CRLF + 'h' + CRLF + 'f' + CRLF + 'Q';
    end;

    if Settings.IsFrame and (Pen.Style <> psClear) then
    begin
      // Line Style.
      Result := Result + CRLF + 'q' + CRLF + GetLineStyle(Pen.Style);

      // Border width, spacing and color.
      Result := Result + NumToStr(Pen.Width * FPixelToPointMultiplier) + ' w' +
        CR + ColorToPDFColor(Pen.Color) + ' RG';

      with Frame do
      begin
        if IsLeft and IsTop and IsRight and IsBottom then
          // Left, Bottom, width, height encoded as strings.
          Result := Result + CRLF + LPath + CRLF + ' s Q'
        else
        begin
          if IsLeft then
            Result := Result + CRLF + NumToStr(X2) + ' ' + NumToStr(Y2) + ' m '
              + CRLF + NumToStr(X1) + ' ' + NumToStr(Y1) + ' l ';
          if IsTop then
            Result := Result + CRLF + NumToStr(X1) + ' ' + NumToStr(Y1) + ' m '
              + CRLF + NumToStr(X4) + ' ' + NumToStr(Y4) + ' l ';
          if IsRight then
            Result := Result + CRLF + NumToStr(X4) + ' ' + NumToStr(Y4) + ' m '
              + CRLF + NumToStr(X3) + ' ' + NumToStr(Y3) + ' l ';
          if IsBottom then
            Result := Result + CRLF + NumToStr(X3) + ' ' + NumToStr(Y3) + ' m '
              + CRLF + NumToStr(X2) + ' ' + NumToStr(Y2) + ' l ';
          Result := Result + CRLF + 'S' + CRLF + 'Q';
        end;
      end;
    end; (* End if Pen.Style <> psClear *)
  end;
end;

procedure TgtCustomPDFEngine.EncodeArc(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Double;
  Pen: TPen);
var
  LS: String;
  LATemp: AnsiString;
begin
  if ((Pen.Width = 0) or (Pen.Style = psClear)) then
    Exit;

  // Line style.
  LS := GetLineStyle(Pen.Style) +
  // Width, spacing and color.
    NumToStr(Pen.Width * FPixelToPointMultiplier) + ' w ' +
    ColorToPDFColor(Pen.Color) + ' RG ' + EncodePDFArc(GetNativeXPos(X1),
    GetNativeYPos(Y1, CurrentPage), GetNativeXPos(X2),
    GetNativeYPos(Y2, CurrentPage), GetNativeXPos(X3),
    GetNativeYPos(Y3, CurrentPage), GetNativeXPos(X4),
    GetNativeYPos(Y4, CurrentPage), Pen) + ' S';
  if FIsClipState then
    LS := CRLF + LS + CRLF
  else
    LS := CRLF + 'q' + CRLF + LS + CRLF + 'Q';
  if (LS <> '') then
  begin
    LATemp := AnsiString(LS);
    FContentStream.Write(LATemp[1], Length(LS));
  end;
end;

procedure TgtCustomPDFEngine.EncodeChord(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Double;
  Pen: TPen; Brush: TBrush);
var
  LS, LPath: String;
  LATemp: AnsiString;
  LPosX1, LPosY1, LPosX2, LPosY2, LPosX3, LPosY3, LPosX4, LPosY4: Extended;
begin
  if ((Pen.Width = 0) or (Pen.Style = psClear)) and
    ((Brush = nil) or ((Brush <> nil) and (Brush.Style = bsClear))) then
    Exit;
  LS := '';
  LPosX1 := GetNativeXPos(X1);
  LPosY1 := GetNativeYPos(Y1, CurrentPage);
  LPosX2 := GetNativeXPos(X2);
  LPosY2 := GetNativeYPos(Y2, CurrentPage);
  LPosX3 := GetNativeXPos(X3);
  LPosY3 := GetNativeYPos(Y3, CurrentPage);
  LPosX4 := GetNativeXPos(X4);
  LPosY4 := GetNativeYPos(Y4, CurrentPage);

  LPath := EncodePDFArc(LPosX1, LPosY1, LPosX2, LPosY2, LPosX3, LPosY3, LPosX4,
    LPosY4, Pen);

  if (Brush <> nil) then
  begin
    if (Brush.Style = bsSolid) then
      LS := LS + ColorToPDFColor(Brush.Color) + ' rg ' + LPath + ' f '
    else if Brush.Style <> bsClear then
      (*
        Select color space - cs.
        Select color for non-stroking pattern - scn.
      *)
      LS := LS + '/CSP cs ' + ColorToPDFColor(Brush.Color) + ' /' +
        GetPattern(Brush.Style) + ' scn n ' + EncodePDFArc(LPosX1, LPosY1,
        LPosX2, LPosY2, LPosX3, LPosY3, LPosX4, LPosY4, Pen) + ' f ';
  end;

  if ((Pen.Width <> 0) and (Pen.Style <> psClear)) then
  begin
    // Line style.
    LS := LS + GetLineStyle(Pen.Style) +
    // Width, spacing and color.
      NumToStr(Pen.Width * FPixelToPointMultiplier) + ' w ' +
      ColorToPDFColor(Pen.Color) + ' RG ' + LPath + ' s';
  end;
  if (LS <> '') then
  begin
    if FIsClipState then
      LS := CRLF + LS + CRLF
    else
      LS := CRLF + 'q' + CRLF + LS + CRLF + 'Q';
    LATemp := AnsiString(LS);
    FContentStream.Write(LATemp[1], Length(LS));
  end;
end;

procedure TgtCustomPDFEngine.EncodeEllipse(X1, Y1, X2, Y2: Double; Pen: TPen;
  Brush: TBrush);
var
  EllipseCtrlPts: TgtEllipseCtrlPoints;
  LS, LPath: String;
  LATemp: AnsiString;
  LPosX1, LPosY1, LPosX2, LPosY2: Extended;
begin
  if FPathStatus <> psPathBegins then
  begin
    LS := '';
    LPosX1 := GetNativeXPos(X1);
    LPosY1 := GetNativeYPos(Y1, CurrentPage);
    LPosX2 := GetNativeXPos(X2);
    LPosY2 := GetNativeYPos(Y2, CurrentPage);

    EllipseCtrlPts := GetEllipseCtrlPts(LPosX1, LPosY1, LPosX2, LPosY2);
    with EllipseCtrlPts do
    begin
      // Move to starting point.
      LPath := NumToStr(X3) + ' ' + NumToStr(Y1) + ' m ' +
      // Draw four Bezier curves to approximate an Ellipse.
        PDFCurveto(X4, Y1, X5, Y2, X5, Y3) + ' ' + PDFCurveto(X5, Y4, X4, Y5,
        X3, Y5) + ' ' + PDFCurveto(X2, Y5, X1, Y4, X1, Y3) + ' ' +
        PDFCurveto(X1, Y2, X2, Y1, X3, Y1) + ' ';

      if Brush <> nil then
      begin
        if Brush.Style = bsSolid then
          LS := LS + ColorToPDFColor(Brush.Color) + ' rg ' + LPath + ' f '
        else if Brush.Style <> bsClear then
          (*
            Select color space - cs.
            Select color for non-stroking pattern - scn.
          *)
          LS := LS + '/CSP cs ' + ColorToPDFColor(Brush.Color) + ' /' +
            GetPattern(Brush.Style) + ' scn n ' + LPath + ' f';
      end;

      if (Pen.Style <> psClear) then
      begin
        // Line Style.
        LS := LS + GetLineStyle(Pen.Style) +
        // Width, spacing and color.
          NumToStr(Pen.Width * FPixelToPointMultiplier) + ' w ' +
          ColorToPDFColor(Pen.Color) + ' RG ' + LPath + ' s';
      end;
      if (LS <> '') then
      begin
        if FIsClipState then
          LS := CRLF + LS + CRLF
        else
          LS := CRLF + 'q' + CRLF + LS + CRLF + 'Q';
        LATemp := AnsiString(LS);
        FContentStream.Write(LATemp[1], Length(LS));
      end;
    end;
  end
  else
  begin
    EllipseCtrlPts := GetEllipseCtrlPts(X1, Y1, X2, Y2);
    with EllipseCtrlPts do
    begin
      if FFirstPoint then // Move to starting point.
      begin
        FPath := FPath + NumToStr(GetNativeXPos(X3)) + ' ' +
          NumToStr(GetNativeYPos(Y1, CurrentPage)) + ' m ';
        FInitialPos := gtPoint(X3, Y1);
        FFirstPoint := False;
      end;
      X1 := GetNativeXPos(X1);
      X2 := GetNativeXPos(X2);
      X3 := GetNativeXPos(X3);
      X4 := GetNativeXPos(X4);
      X5 := GetNativeXPos(X5);
      Y1 := GetNativeYPos(Y1, CurrentPage);
      Y2 := GetNativeYPos(Y2, CurrentPage);
      Y3 := GetNativeYPos(Y3, CurrentPage);
      Y4 := GetNativeYPos(Y4, CurrentPage);
      Y5 := GetNativeYPos(Y5, CurrentPage);

      FPath := FPath + // Draw four Bezier curves to approximate an Ellipse.
        PDFCurveto(X4, Y1, X5, Y2, X5, Y3) + ' ' + PDFCurveto(X5, Y4, X4, Y5,
        X3, Y5) + ' ' + PDFCurveto(X2, Y5, X1, Y4, X1, Y3) + ' ' +
        PDFCurveto(X1, Y2, X2, Y1, X3, Y1) + ' ';
    end;
  end;
end;

procedure TgtCustomPDFEngine.EncodeEOF(AObject: TgtEOFItem);
var
  LS: String;
  LATemp: AnsiString;
begin
  LS := '';
  if AObject.Status then
  begin
    if FIsClipState then
    begin
      LS := ' Q ';
      FIsClipState := False;
    end;
    if FIsClipPath then
      LS := LS;
  end;
  if (LS <> '') then
  begin
    LATemp := AnsiString(LS);
    FContentStream.Write(LATemp[1], Length(LS));
  end;
end;

procedure TgtCustomPDFEngine.EncodeImage(AObject: TgtImageItem);
var
  LS: String;
  LATemp: AnsiString;
  LBitmap: TBitmap;
  LPDFBitmap: TMemoryStream; (* Stores PDF GRB sequence. *)
  LImgStream: TMemoryStream; (* Holds the final Image Stream. *)
  ImgObjNo: Integer;
  ImageIndex: String;

  (* Required for image reuse. *)
  LI: Integer;
  LImageSettings: TgtPDFImageSettings;

begin
  LS := '';
  LBitmap := nil;
  LPDFBitmap := nil;
  LImgStream := nil;
  ImageIndex := '';

  try
    with AObject do
    begin
      if not(irImage in ItemsToRender) then
        Exit;

      if TGraphic(FImageResourceList[IndexNo]) = nil then
        Exit;

      if (TGraphic(FImageResourceList[IndexNo]) <> nil) and
        TGraphic(FImageResourceList[IndexNo]).Empty then
        Exit;

      // Handling source DPI
      // if Settings.SourceDPI <> InputXRes then
      // TGraphic(FImageResourceList.Items[IndexNo]).Width :=
      // Round(TGraphic(FImageResourceList.Items[IndexNo]).Width /
      // Settings.SourceDPI * InputXRes);
      // if Settings.SourceDPI <> InputYRes then
      // TGraphic(FImageResourceList.Items[IndexNo]).Height :=
      // Round(TGraphic(FImageResourceList.Items[IndexNo]).Height /
      // Settings.SourceDPI * InputYRes);
      (*
        Different image items can point to same TGraphic object in
        FImageResourceList, but can have different settings.
        Hence for each TGraphic object in FImageResourceList,
        check if an image stream is already written with same setting.
      *)

      if Length(FImageSettings) >= (IndexNo + 1) then
      begin
        if (FImageSettings[IndexNo] <> nil) then
        begin
          with FImageSettings[IndexNo] do
            for LI := 0 to Count - 1 do
              if TgtPDFImageSettings(Items[LI])
                .IsEqual(AObject, GetGraphicResource(IndexNo).Width,
                GetGraphicResource(IndexNo).Height) then
              begin
                with TgtPDFImageSettings(Items[LI]) do
                  ImageIndex := IntToStr(IndexNo) + IntToStr(LI);
                Break;
              end;
        end

        (*
          If IndexNo is not in sorted order, then
          just create an empty list.
        *)
        else
          FImageSettings[IndexNo] := TList.Create;
      end
      else
      begin
        SetLength(FImageSettings, (IndexNo + 1));
        FImageSettings[IndexNo] := TList.Create;
      end;

      (* If new image setting, render new image stream. *)
      if ImageIndex = '' then
      begin
        case Settings.OutputImageFormat of
          ifBMP:
            begin
              LBitmap := GetImageAsBitmap(AObject);
              LPDFBitmap := GetPDFBitmapStream(LBitmap);
              LImgStream := TMemoryStream.Create;
              CompressStream(LPDFBitmap, LImgStream, Compression.Enabled,
                Compression.Level);
              LImgStream.Position := 0;
            end;
          ifJPEG:
            begin
              LBitmap := GetImageAsBitmap(AObject);
              LImgStream := TMemoryStream(GetBitmapAsJPGGIFStream(LBitmap, True,
                Settings.JPEGQuality));
              LImgStream.Position := 0;
            end;
{$IFDEF gtPro}
          ifCCITT3:
            begin
              TgtImageItem(AObject).Settings.ImagePixelFormat := pf1bit;
              LBitmap := GetImageAsBitmap(AObject);
              LImgStream := GetBitmapAsCCITTStream(LBitmap, ifCCITT3);
              LImgStream.Position := 0;
            end;
          ifCCITT4:
            begin
              TgtImageItem(AObject).Settings.ImagePixelFormat := pf1bit;
              LBitmap := GetImageAsBitmap(AObject);
              LImgStream := GetBitmapAsCCITTStream(LBitmap, ifCCITT4);
              LImgStream.Position := 0;
            end;
{$ENDIF}
        end;
        ImgObjNo := GetNewObjNo;

        ImageIndex := IntToStr(IndexNo);

        LImageSettings := TgtPDFImageSettings.Create;
        with LImageSettings do
        begin
          Assign(Settings);
          ObjNo := ImgObjNo;
          DisplayWidth := DisplayRect.Right - DisplayRect.Left;
          DisplayHeight := DisplayRect.Bottom - DisplayRect.Top;
          ImageWidth := Width;
          ImageHeight := Height;
        end;

        ImageIndex := ImageIndex +
          IntToStr(FImageSettings[IndexNo].Add(LImageSettings));

        // Add obj to list so it can be reused where possible.
        FImageXRefList.AddObject(IntToStr(FImageStream.Size),
          TObject(ImgObjNo));

        (* Write Image Dictionary. *)
        LS := MakeObjHead(ImgObjNo) + CRLF + '<< ' + '/Type/XObject' +
          '/Subtype/Image' + '/Name/Img' + ImageIndex + '/Width ' +
          IntToStr(LBitmap.Width) + '/Height ' + IntToStr(LBitmap.Height) +
          '/BitsPerComponent ';
{$IFDEF gtPro}
        if (Settings.OutputImageFormat = ifCCITT3) or
          (Settings.OutputImageFormat = ifCCITT4) then
          LS := LS + '1'
        else
{$ENDIF}
          LS := LS + '8';
        LS := LS + GetImageFilter(Settings.OutputImageFormat);

{$IFDEF gtPro}
        if (Settings.OutputImageFormat = ifCCITT3) or
          (Settings.OutputImageFormat = ifCCITT4) then
        begin
          LS := LS + '/ColorSpace/DeviceGray /DecodeParms [<</K ';
          if Settings.OutputImageFormat = ifCCITT3 then
            LS := LS + '0'
          else
            LS := LS + '-1';
          LS := LS + ' /Columns ' + IntToStr(LBitmap.Width) + ' /Rows ' +
            IntToStr(LBitmap.Height) + ' >>]';
        end
        else
{$ENDIF}
          LS := LS + '/ColorSpace/DeviceRGB';

        LS := LS + '/Length ' + IntToStr(LImgStream.Size) + '>>' + CRLF +
          'stream' + CRLF;
        LATemp := AnsiString(LS);
        FImageStream.Write(LATemp[1], Length(LS));
        LImgStream.Position := 0;
        WritePDFStream(LImgStream, LImgStream.Size, ImgObjNo, 0);

        (* Save the image to a temp stream to write later. *)
        FImageStream.CopyFrom(LImgStream, 0);
        LS := CRLF + 'endstream' + CRLF + 'endobj' + CRLF;
        LATemp := AnsiString(LS);
        FImageStream.Write(LATemp[1], Length(LS));
      end; (* End If *)

      (*
        Get PDF Image rendering operators to be written into content.
        Also draw any frame if required.
      *)
      LS := EncodeImageObjectRef(ImageIndex, AObject);
      LATemp := AnsiString(LS);
      FContentStream.Write(LATemp[1], Length(LS));
    end; (* End with *)
  finally
    FreeAndNil(LBitmap);
    FreeAndNil(LPDFBitmap);
    FreeAndNil(LImgStream);
  end;
end;

function TgtCustomPDFEngine.EncodeImageObjectRef(AIndex: String;
  AObject: TgtImageItem): String;
var
  LCos, LSin: Double;
  ImageLeft, ImageBottom, ImageAlpha, ImageLeftDx, ImageBottomDy,
    ImageDglDst: Double;
begin
  Result := '';
  with AObject do
  begin
    if Width = 0 then
      Width := 1;
    if Height = 0 then
      Height := 1;
    if (Settings.Inclination = 0) or (Settings.Inclination = 360) then
      Result := CRLF + 'q' + CRLF +
        NumToStr(Abs(Width) * FPixelToPointMultiplier *
        (InputXRes / CPixelsPerInch)) + ' 0 0 ' +
        NumToStr(Abs(Height) * FPixelToPointMultiplier *
        (InputYRes / CPixelsPerInch)) + ' ' + NumToStr(GetNativeXPos(X)) + ' ' +
        NumToStr(GetNativeYPos(Y + Abs(Height), CurrentPage)) + ' cm' + CRLF +
        '/Img' + AIndex + ' Do' + CRLF + 'Q'
    else
    begin
      ImageLeftDx := X - DisplayRect.Left;
      ImageBottomDy := (Y + Height) - DisplayRect.Top;
      ImageDglDst := Sqrt((ImageLeftDx * ImageLeftDx) +
        (ImageBottomDy * ImageBottomDy));
      if ImageBottomDy = 0 then
        ImageAlpha := DegreesToRadians(Settings.Inclination) + PI
      else
        ImageAlpha := DegreesToRadians(Settings.Inclination) +
          ArcTan(ImageLeftDx / ImageBottomDy);
      ImageLeft := DisplayRect.Left + (ImageDglDst * Sin(ImageAlpha));
      ImageBottom := DisplayRect.Top + (ImageDglDst * Cos(ImageAlpha));

      LCos := Cos(DegreesToRadians(Settings.Inclination));
      LSin := Sin(DegreesToRadians(Settings.Inclination));

      // Translate
      Result := CRLF + 'q 1 0 0 1 ' + NumToStr(GetNativeXPos(ImageLeft)) + ' ' +
        NumToStr(GetNativeYPos(ImageBottom, CurrentPage)) + ' cm' + CR;

      // Rotate
      Result := Result + NumToStr(LCos) + ' ' + NumToStr(LSin) + ' ' +
        NumToStr(-LSin) + ' ' + NumToStr(LCos) + ' ' + '0 0' + ' cm' + CR;

      // Scale
      Result := Result + NumToStr(Abs(Width) * FPixelToPointMultiplier *
        (InputXRes / CPixelsPerInch)) + ' ' + NumToStr(0) + ' ' + NumToStr(0) +
        ' ' + NumToStr(Abs(Height) * FPixelToPointMultiplier *
        (InputYRes / CPixelsPerInch)) + ' ' + '0 0 cm' + CR;

      Result := Result + ' /Img' + AIndex + ' Do' + CRLF + 'Q';
    end;

    if Settings.IsFrame then
      Result := DrawBorder(AObject) + CRLF + Result;
  end;
end;

procedure TgtCustomPDFEngine.EncodeLine(X1, Y1, X2, Y2: Double; Pen: TPen);
var
  LS: String;
  LATemp: AnsiString;
{$IFDEF ONEView}
  LX, LY: Double;
{$ENDIF}
begin
  // Line Style.
{$IFDEF ONEView}
  if (X2 < X1) then
  begin
    LX := X2;
    LY := Y2;
    X2 := X1;
    Y2 := Y1;
    X1 := LX;
    Y1 := LY;
  end;
  if (X1 > (Page.Width - Page.LeftMargin)) then
    Exit;
  if (X2 > (Page.Width - Page.LeftMargin)) then
    X2 := (Page.Width - Page.LeftMargin);
{$ENDIF}
  if FPathStatus <> psPathBegins then
  begin
    if Pen.Style = psClear then
      Exit;

    if FIsClipState then
      LS := CRLF
    else
      LS := CRLF + 'q ';
    LS := LS + GetLineStyle(Pen.Style) +
    // Line width, spacing and color.
      NumToStr(Pen.Width * FPixelToPointMultiplier) + ' w ' +
      ColorToPDFColor(Pen.Color) + ' RG ' + NumToStr(GetNativeXPos(X1)) + ' ' +
      NumToStr(GetNativeYPos(Y1, CurrentPage)) + ' m ' +
      NumToStr(GetNativeXPos(X2)) + ' ' +
      NumToStr(GetNativeYPos(Y2, CurrentPage)) + ' l ' +
      CompletePDFPath(Pen, nil);
    if FIsClipState then
      LS := LS + CRLF
    else
      LS := LS + CRLF + 'Q';
    if (LS <> '') then
    begin
      LATemp := AnsiString(LS);
      FContentStream.Write(LATemp[1], Length(LS));
    end;
  end
  else
  begin
    if FFirstPoint then
    begin
      FPath := FPath + NumToStr(GetNativeXPos(X1)) + ' ' +
        NumToStr(GetNativeYPos(Y1, CurrentPage)) + ' m ' +
        NumToStr(GetNativeXPos(X2)) + ' ' +
        NumToStr(GetNativeYPos(Y2, CurrentPage)) + ' l ';
      FInitialPos := gtPoint(X1, X2);
      FFirstPoint := False;
    end
    else
      FPath := FPath + NumToStr(GetNativeXPos(X2)) + ' ' +
        NumToStr(GetNativeYPos(Y2, CurrentPage)) + ' l '
  end;
end;

function TgtCustomPDFEngine.EncodePDFArc(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Double;
  Pen: TPen): String;

  function CalculateAngle(XCenter, YCenter, X, Y: Double): Double;
  begin
    if X > XCenter then
    begin
      Result := 360.0 + RadiansToDegrees(ArcTan((Y - YCenter) / (X - XCenter)));
      If Result >= 360.0 then
        Result := Result - 360.0;
    end
    else if X < XCenter then
      Result := 180.0 + RadiansToDegrees(ArcTan((Y - YCenter) / (X - XCenter)))
    else
    begin
      if Y > YCenter then
        Result := 90.0
      else
        Result := 270.0;
    end;
  end;

var
  XCenter, YCenter, RadiusX, RadiusY, StartX, StartY: Double;
  Alpha, Beta, TempAngle: Double;

begin
  // Calculate center & radius.
  XCenter := (X1 + X2) / 2.0;
  YCenter := (Y1 + Y2) / 2.0;
  RadiusX := Abs(X1 - X2) / 2.0;
  RadiusY := Abs(Y1 - Y2) / 2.0;

  Alpha := CalculateAngle(XCenter, YCenter, X3, Y3) + 180;
  Beta := CalculateAngle(XCenter, YCenter, X4, Y4) + 180;

  while (Beta <= Alpha) do
    Beta := Beta + 360;

  // Get starting point.
  StartX := XCenter - RadiusX * Cos(DegreesToRadians(Alpha));
  StartY := YCenter - RadiusY * Sin(DegreesToRadians(Alpha));

  if Pen.Style <> psClear then
  begin
    // Line style.
    Result := GetLineStyle(Pen.Style) +
    // Width, spacing and color.
      NumToStr(Pen.Width * FPixelToPointMultiplier) + ' w ' +
      ColorToPDFColor(Pen.Color) + ' RG ';
  end;

  // Move to starting point.
  Result := Result + NumToStr(StartX) + ' ' + NumToStr(StartY) + ' m';

  while (Beta - Alpha > 90) do
  begin
    TempAngle := Alpha + 90;
    Result := Result + ' ' + PDFShortArc(XCenter, YCenter, RadiusX, RadiusY,
      Alpha, TempAngle);
    Alpha := TempAngle;
  end;
  if (Alpha <> Beta) then
    Result := Result + ' ' + PDFShortArc(XCenter, YCenter, RadiusX, RadiusY,
      Alpha, Beta);
end;

procedure TgtCustomPDFEngine.EncodePie(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Double;
  Pen: TPen; Brush: TBrush);
var
  LS, LPath: String;
  LATemp: AnsiString;
  LPosX1, LPosY1, LPosX2, LPosY2, LPosX3, LPosY3, LPosX4, LPosY4: Extended;
begin
  if ((Pen.Width = 0) or (Pen.Style = psClear)) and
    ((Brush = nil) or (Brush.Style = bsClear)) then
    Exit;
  LS := '';
  LPosX1 := GetNativeXPos(X1);
  LPosY1 := GetNativeYPos(Y1, CurrentPage);
  LPosX2 := GetNativeXPos(X2);
  LPosY2 := GetNativeYPos(Y2, CurrentPage);
  LPosX3 := GetNativeXPos(X3);
  LPosY3 := GetNativeYPos(Y3, CurrentPage);
  LPosX4 := GetNativeXPos(X4);
  LPosY4 := GetNativeYPos(Y4, CurrentPage);

  LPath := EncodePDFArc(LPosX1, LPosY1, LPosX2, LPosY2, LPosX3, LPosY3, LPosX4,
    LPosY4, Pen) + ' ' + NumToStr((LPosX1 + LPosX2) / 2.0) + ' ' +
    NumToStr((LPosY1 + LPosY2) / 2.0) + ' l';

  if Brush <> nil then
  begin
    if Brush.Style = bsSolid then
      LS := LS + ColorToPDFColor(Brush.Color) + ' rg ' + LPath + ' f '
    else if Brush.Style <> bsClear then
      (*
        Select color space - cs.
        Select color for non-stroking pattern - scn.
      *)
      LS := LS + '/CSP cs ' + ColorToPDFColor(Brush.Color) + ' /' +
        GetPattern(Brush.Style) + ' scn n ' + LPath + ' f ';
  end;

  if ((Pen.Width <> 0) and (Pen.Style <> psClear)) then
  begin
    // Line Style.
    LS := LS + GetLineStyle(Pen.Style) +
    // Width, spacing and color.
      NumToStr(Pen.Width * FPixelToPointMultiplier) + ' w ' +
      ColorToPDFColor(Pen.Color) + ' RG ' + LPath + ' s';
  end;
  if (LS <> '') then
  begin
    if FIsClipState then
      LS := CRLF + LS + CRLF
    else
      LS := CRLF + 'q' + CRLF + LS + CRLF + 'Q';
    LATemp := AnsiString(LS);
    FContentStream.Write(LATemp[1], Length(LS));
  end;
end;

procedure TgtCustomPDFEngine.EncodePolyBezier(Points: TgtPoints;
  NoPoints: Integer; Pen: TPen);
var
  LI, LMax: Integer;
  LS: String;
  LATemp: AnsiString;
begin
  LI := 1;
  LMax := (( High(Points) div 3) * 3);
  if FPathStatus <> psPathBegins then
  begin
    if ((Pen.Width = 0) or (Pen.Style = psClear)) then
      Exit;
    LS := '';

    // Line style.
    LS := GetLineStyle(Pen.Style);
    // Width, spacing and color.
    if ((Pen.Width = 0) or (Pen.Style = psClear)) then
      LS := LS + NumToStr(0) + ' w ' + ColorToPDFColor(BackgroundColor) + ' RG '
    else
      LS := LS + NumToStr(Pen.Width * FPixelToPointMultiplier) + ' w ' +
        ColorToPDFColor(Pen.Color) + ' RG ';

    LS := LS + NumToStr(GetNativeXPos(Points[0].X)) + ' ' +
      NumToStr(GetNativeYPos(Points[0].Y, CurrentPage)) + ' m ';

    while LI <= LMax do
    begin
      LS := LS + NumToStr(GetNativeXPos(Points[LI].X)) + ' ' +
        NumToStr(GetNativeYPos(Points[LI].Y, CurrentPage)) + ' ' +
        NumToStr(GetNativeXPos(Points[LI + 1].X)) + ' ' +
        NumToStr(GetNativeYPos(Points[LI + 1].Y, CurrentPage)) + ' ' +
        NumToStr(GetNativeXPos(Points[LI + 2].X)) + ' ' +
        NumToStr(GetNativeYPos(Points[LI + 2].Y, CurrentPage)) + ' c ';
      LI := LI + 3;
    end;
    if FIsClipState then
      LS := CRLF + LS + 'S' + CRLF
    else
      LS := CRLF + 'q' + CRLF + LS + 'S' + CRLF + 'Q ';
    if (NoPoints > 3) then
    begin
      if (LS <> '') then
      begin
        LATemp := AnsiString(LS);
        FContentStream.Write(LATemp[1], Length(LS));
      end;
    end;
  end
  else
  begin
    if FFirstPoint then
    begin
      FPath := FPath + NumToStr(GetNativeXPos(Points[0].X)) + ' ' +
        NumToStr(GetNativeYPos(Points[0].Y, CurrentPage)) + ' m ';
      FInitialPos := gtPoint(Points[0].X, Points[0].Y);
      FFirstPoint := False;
    end;
    while LI <= LMax do
    begin
      FPath := FPath + NumToStr(GetNativeXPos(Points[LI].X)) + ' ' +
        NumToStr(GetNativeYPos(Points[LI].Y, CurrentPage)) + ' ' +
        NumToStr(GetNativeXPos(Points[LI + 1].X)) + ' ' +
        NumToStr(GetNativeYPos(Points[LI + 1].Y, CurrentPage)) + ' ' +
        NumToStr(GetNativeXPos(Points[LI + 2].X)) + ' ' +
        NumToStr(GetNativeYPos(Points[LI + 2].Y, CurrentPage)) + ' c ';
      LI := LI + 3;
    end;

  end;
end;

procedure TgtCustomPDFEngine.EncodePolyLine(Points: TgtPoints;
  NoPoints: Integer; IsClosed: boolean; Pen: TPen; Brush: TBrush);
var
  LI: Integer;
  LS, LPath: String;
  LATemp: AnsiString;
  Stroke: boolean;
  Fill: boolean;
begin

  if (FPathStatus <> psPathBegins) then
  begin
    if IsClosed then
    begin
      if ((Pen.Width = 0) and (Pen.Style = psClear)) then
        if ((Brush = nil) or (Brush.Style = bsClear)) then
          Exit;
      LS := '';
      LPath := NumToStr(GetNativeXPos(Points[0].X)) + ' ' +
        NumToStr(GetNativeYPos(Points[0].Y, CurrentPage)) + ' m ';
      for LI := 1 to NoPoints - 1 do
        LPath := LPath + NumToStr(GetNativeXPos(Points[LI].X)) + ' ' +
          NumToStr(GetNativeYPos(Points[LI].Y, CurrentPage)) + ' l ';
      LPath := LPath + NumToStr(GetNativeXPos(Points[0].X)) + ' ' +
        NumToStr(GetNativeYPos(Points[0].Y, CurrentPage)) + ' l ';
      Stroke := False;
      Fill := False;
      if (Brush <> nil) then
      begin
        if Brush.Style = bsSolid then
        begin
          LS := LS + ColorToPDFColor(Brush.Color) + ' rg ';
          Fill := True;
        end
        else if Brush.Style <> bsClear then
          (*
            Select color space - cs.
            Select color for non-stroking pattern - scn.
          *)
          LS := LS + '/CSP cs ' + ColorToPDFColor(Brush.Color) + ' /' +
            GetPattern(Brush.Style) + ' scn n ';
      end;
      if ((Pen.Style <> psClear)) then
      begin
        // Line Style.
        LS := LS + GetLineStyle(Pen.Style) +
        // Line width, spacing and color.
          NumToStr(Pen.Width * FPixelToPointMultiplier) + ' w ' +
          ColorToPDFColor(Pen.Color) + ' RG ';
        Stroke := True;
      end;
      if Stroke then
      begin
        if Fill then
          LS := LS + LPath + 'B* '
        else
          LS := LS + LPath + ' S '
      end
      else if Fill then
        LS := LS + LPath + ' f ';
    end
    else
    begin

      if Pen.Style = psClear then
        Exit;
      LS := '';
      LPath := NumToStr(GetNativeXPos(Points[0].X)) + ' ' +
        NumToStr(GetNativeYPos(Points[0].Y, CurrentPage)) + ' m ';
      for LI := 1 to NoPoints - 1 do
        LPath := LPath + NumToStr(GetNativeXPos(Points[LI].X)) + ' ' +
          NumToStr(GetNativeYPos(Points[LI].Y, CurrentPage)) + ' l ';
      // Line Style.
      LS := LS + GetLineStyle(Pen.Style) +
      // Line width, spacing and color.
        NumToStr(Pen.Width * FPixelToPointMultiplier) + ' w ' +
        ColorToPDFColor(Pen.Color) + ' RG ';
      LS := LS + LPath + ' S ';
    end;
    if (LS <> '') then
    begin
      if FIsClipState then
        LS := CRLF + LS + CRLF
      else
        LS := CRLF + 'q' + CRLF + LS + CRLF + 'Q ';
      LATemp := AnsiString(LS);
      FContentStream.Write(LATemp[1], Length(LS));
    end;

  end
  else
  begin
    if FFirstPoint then
    begin
      LPath := NumToStr(GetNativeXPos(Points[0].X)) + ' ' +
        NumToStr(GetNativeYPos(Points[0].Y, CurrentPage)) + ' m ';
      FInitialPos := gtPoint(Points[0].X, Points[0].Y);
      FFirstPoint := False;
    end;
    for LI := 1 to NoPoints - 1 do
      LPath := LPath + NumToStr(GetNativeXPos(Points[LI].X)) + ' ' +
        NumToStr(GetNativeYPos(Points[LI].Y, CurrentPage)) + ' l ';
    FPath := FPath + LPath;
  end;
end;

procedure TgtCustomPDFEngine.EncodeRect(X1, Y1, X2, Y2: Double; Pen: TPen;
  Brush: TBrush);
var
  LS, LPath: String;
  LATemp: AnsiString;
begin
  LS := '';
  LPath := '';
  if FPathStatus <> psPathBegins then
  begin
    LPath := NumToStr(GetNativeXPos(X1)) + ' ' +
      NumToStr(GetNativeYPos(Y2, CurrentPage)) + ' ' +
      NumToStr((X2 - X1) * FPixelToPointMultiplier *
      (InputXRes / CPixelsPerInch)) + ' ' +
      NumToStr((Y2 - Y1) * FPixelToPointMultiplier *
      (InputYRes / CPixelsPerInch)) + ' re';

    if (Brush <> nil) then
    begin
      if (Brush.Style = bsSolid) then
        LS := ColorToPDFColor(Brush.Color) + ' rg ' + LPath + ' f '
      else if Brush.Style <> bsClear then
        (*
          Select color space - cs.
          Select color for non-stroking pattern - scn.
        *)
        LS := '/CSP cs ' + ColorToPDFColor(Brush.Color) + ' /' +
          GetPattern(Brush.Style) + ' scn n ' + LPath + ' f ';
    end;

    (* If Pen style is psClear, set stroke color (RG) to background color. *)
    if (Pen.Style <> psClear) then
    begin
      // Line Style.
      LS := LS + GetLineStyle(Pen.Style) +
      // Border width, spacing and color.
        NumToStr(Pen.Width * FPixelToPointMultiplier) + ' w ' +
        ColorToPDFColor(Pen.Color) + ' RG ' + LPath + ' s';
    end;
    if (LS <> '') then
    begin
      if FIsClipState then
        LS := CRLF + LS + CRLF
      else
        LS := CRLF + 'q' + CRLF + LS + CRLF + 'Q';
      LATemp := AnsiString(LS);
      FContentStream.Write(LATemp[1], Length(LS));
    end;
  end
  else
  begin
    LPath := NumToStr(GetNativeXPos(X1)) + ' ' +
      NumToStr(GetNativeYPos(Y2, CurrentPage)) + ' ' +
      NumToStr((X2 - X1) * FPixelToPointMultiplier *
      (InputXRes / CPixelsPerInch)) + ' ' +
      NumToStr((Y2 - Y1) * FPixelToPointMultiplier *
      (InputYRes / CPixelsPerInch)) + ' re';

    FPath := FPath + LPath;
  end;
end;

procedure TgtCustomPDFEngine.EncodeClipRect(AObject: TgtClipItem);
var
  LTempRect: TRect;
  LI, LNo, LK, LJ: Integer;
  LS, LPath: String;
  LATemp: AnsiString;
  LClipPoints: array of TgtPoint;
begin
  LS := '';
  LPath := '';
  if not AObject.Restore then
  begin
    LNo := AObject.NoRects;
    if LNo > 1 then
    begin
      SetLength(LClipPoints, LNo * 5);
      LK := 0;
      for LI := 1 to LNo - 1 do
      begin
        LTempRect := AObject.GetRects(LI);
        LClipPoints[LK] := gtPoint(LTempRect.Left, LTempRect.Top);
        LClipPoints[LK + 1] := gtPoint(LTempRect.Right, LTempRect.Top);
        LClipPoints[LK + 2] := gtPoint(LTempRect.Right, LTempRect.Bottom);
        LClipPoints[LK + 3] := gtPoint(LTempRect.Left, LTempRect.Bottom);
        LClipPoints[LK + 4] := gtPoint(LTempRect.Left, LTempRect.Top);
        LK := LK + 5;
      end;
      LJ := 0;
      for LK := 0 to LNo - 1 do
      begin
        LPath := LPath + NumToStr(GetNativeXPos(LClipPoints[LJ].X)) + ' ' +
          NumToStr(GetNativeYPos(LClipPoints[LJ].Y, CurrentPage)) +
          ' m ' + CRLF;
        LPath := LPath + NumToStr(GetNativeXPos(LClipPoints[LJ + 1].X)) + ' ' +
          NumToStr(GetNativeYPos(LClipPoints[LJ + 1].Y, CurrentPage)) +
          ' l ' + CRLF;
        LPath := LPath + NumToStr(GetNativeXPos(LClipPoints[LJ + 2].X)) + ' ' +
          NumToStr(GetNativeYPos(LClipPoints[LJ + 2].Y, CurrentPage)) +
          ' l ' + CRLF;
        LPath := LPath + NumToStr(GetNativeXPos(LClipPoints[LJ + 3].X)) + ' ' +
          NumToStr(GetNativeYPos(LClipPoints[LJ + 3].Y, CurrentPage)) +
          ' l ' + CRLF;
        LPath := LPath + NumToStr(GetNativeXPos(LClipPoints[LJ + 4].X)) + ' ' +
          NumToStr(GetNativeYPos(LClipPoints[LJ + 4].Y, CurrentPage)) +
          ' l ' + CRLF;
        LJ := LJ + 5;
      end;
    end
    else
    begin
      LK := 0;
      LTempRect := AObject.GetRects(0);
      SetLength(LClipPoints, 5);

      LClipPoints[LK] := gtPoint(LTempRect.Left, LTempRect.Top);
      LClipPoints[LK + 1] := gtPoint(LTempRect.Right, LTempRect.Top);
      LClipPoints[LK + 2] := gtPoint(LTempRect.Right, LTempRect.Bottom);
      LClipPoints[LK + 3] := gtPoint(LTempRect.Left, LTempRect.Bottom);
      LClipPoints[LK + 4] := gtPoint(LTempRect.Left, LTempRect.Top);

      LK := 0;

      LPath := LPath + NumToStr(GetNativeXPos(LClipPoints[LK].X)) + ' ' +
        NumToStr(GetNativeYPos(LClipPoints[LK].Y, CurrentPage)) + ' m ' + CRLF;
      LPath := LPath + NumToStr(GetNativeXPos(LClipPoints[LK + 1].X)) + ' ' +
        NumToStr(GetNativeYPos(LClipPoints[LK + 1].Y, CurrentPage)) +
        ' l ' + CRLF;
      LPath := LPath + NumToStr(GetNativeXPos(LClipPoints[LK + 2].X)) + ' ' +
        NumToStr(GetNativeYPos(LClipPoints[LK + 2].Y, CurrentPage)) +
        ' l ' + CRLF;
      LPath := LPath + NumToStr(GetNativeXPos(LClipPoints[LK + 3].X)) + ' ' +
        NumToStr(GetNativeYPos(LClipPoints[LK + 3].Y, CurrentPage)) +
        ' l ' + CRLF;
      LPath := LPath + NumToStr(GetNativeXPos(LClipPoints[LK + 4].X)) + ' ' +
        NumToStr(GetNativeYPos(LClipPoints[LK + 4].Y, CurrentPage)) +
        ' l ' + CRLF;
    end;
    if FIsClipState then
    begin
      if AObject.Mode = RGN_AND then
      begin
        if AObject.NoRects > 1 then
          LS := ' q ' + LPath + ' W* n ' + CRLF
        else
          LS := '';
      end
      else if AObject.Mode = RGN_COPY then
      begin
        LS := '';
      end;
    end
    else
    begin
      if AObject.Mode = RGN_AND then
      begin
        LS := ' q ' + LPath + ' W* n ' + CRLF
      end
      else if AObject.Mode = RGN_COPY then
      begin
        // LS := ' q ' + LPath + ' W* n ' + CRLF
        LS := ' q ' + CRLF;
      end;
      FIsClipState := True;
    end;
  end
  else
  begin
    if FIsClipState then
    begin
      LS := ' Q ' + CRLF;
      FIsClipState := False;
    end;
  end;
  if (LS <> '') then
  begin
    LATemp := AnsiString(LS);
    FContentStream.Write(LATemp[1], Length(LS));
  end;
end;

{ This code is commented becuse  YouTrack Id EDOC-126 isue  is caused because of
  this and if we add this code EDOC-93 is working fine
  procedure TgtCustomPDFEngine.EncodeParagraph(AObject: TgtParagraphItem);
  var
  I: Integer;
  LTextItem: TgtTextItem;
  LWidth: Extended;
  LS: WideString;
  begin
  LTextItem := TgtTextItem.create;
  with AObject do
  begin
  LTextItem.Font := Font;
  LTextItem.Brush := Brush;
  LTextItem.TextEffects := TextEffects;
  LTextItem.X := X + Settings.LeftIndent + Settings.FirstLineIndent;
  LWidth := Width - Settings.FirstLineIndent;

  for I := 0 to AObject.Lines.Count - 1 do
  begin
  LS := Lines.Strings[I];
  LS := ReplaceString(LS, CRLF, '');
  case AObject.Settings.Alignment of
  haRight:
  begin
  LTextItem.X := LTextItem.X + LWidth;
  LTextItem.Alignment := haRight;
  end;
  haCenter:
  begin
  LTextItem.X := LTextItem.X +
  (LWidth - TextSize(Lines[I], Font).cx) / 2;
  LTextItem.Alignment := haCenter;
  end;
  haJustify:
  begin
  if I <> (AObject.Lines.Count - 1) then
  LS := GetJustifiedText(LS, Font, LWidth);
  LTextItem.Alignment := haJustify;
  end;
  end;
  LTextItem.Y := Y + I * TextSize('W', Font).cy * Settings.LineSpacing;
  LTextItem.Lines.Clear;
  LTextItem.Lines.Add(LS);
  EncodeText(LTextItem);
  LTextItem.X := X + Settings.LeftIndent;
  LWidth := Width;
  end;
  end;
  FreeAndNil(LTextItem);
  end;
}
procedure TgtCustomPDFEngine.EncodePathItem(AObject: TgtPathItem);
var
  LS: String;
  LATemp: AnsiString;
begin
  LS := '';
  with AObject do
  begin
    case PathOperation of
      poBeginPath:
        begin
          FPathStatus := psPathBegins;
          FFirstPoint := True;
          FPath := '';
        end;
      poEndPath:
        begin
          // Added...
          if FPathStatus = psPathBegins then
          begin
            FIsPathClosed := False;
            FPathStatus := psPathEnds;
          end;
        end;
      poCloseFigure:
        begin
          if FPathStatus = psPathBegins then
          // Added...
          begin
            FIsPathClosed := True;
            FFirstPoint := True;
            // FPathStatus := psPathEnds;
          end;
        end;
      poAbortPath:
        begin
          FPath := ' n ' + CRLF;
          FPathStatus := psNoPath;
          LS := FPath;
        end;
      poFillPath:
        begin
          if FillAlternate then
            FPath := FPath + 'h f*' + CRLF
          else
            FPath := FPath + 'h f' + CRLF;
          FPathStatus := psNoPath;
          if Pen.Style = psClear then
            LS := ColorToPDFColor(AObject.Brush.Color) + ' rg' + CRLF + FPath
          else
          begin
            if Brush.Style = bsClear then
            begin
              LS := GetLineStyle(Pen.Style) +
                NumToStr(Pen.Width * FPixelToPointMultiplier) + ' w ' +
                ColorToPDFColor(Pen.Color) + ' RG ' + CRLF + FPath;
            end
            else
            begin
              LS := GetLineStyle(Pen.Style) +
                NumToStr(Pen.Width * FPixelToPointMultiplier) + ' w ' +
                ColorToPDFColor(Pen.Color) + ' RG ' +
                ColorToPDFColor(Brush.Color) + ' rg ' + CRLF + FPath;
            end;
          end;
          FPath := '';
        end;
      poStrokeAndFillPath:
        begin
          {
            if FIsPathClosed then
            begin
            if FillAlternate then
            FPath := FPath + 'b* + CRLF'
            else
            FPath := FPath + 'b' + CRLF;
            end
            else
            begin
            if FillAlternate then
            FPath := FPath + 'B*' + CRLF
            else
            FPath := FPath + 'B' + CRLF;
            end;
          }
          FPathStatus := psNoPath;
          if Pen.Style = psClear then
          begin
            if FIsPathClosed then
            begin
              if FillAlternate then
                FPath := FPath + 'f* + CRLF'
              else
                FPath := FPath + 'f' + CRLF;
            end
            else
            begin
              if FillAlternate then
                FPath := FPath + 'F*' + CRLF
              else
                FPath := FPath + 'F' + CRLF;
            end;
            LS := ColorToPDFColor(AObject.Brush.Color) + ' rg' + CRLF + FPath;
          end
          else
          begin
            if Brush.Style = bsClear then
            begin
              if FIsPathClosed then
              begin
                if FillAlternate then
                  FPath := FPath + 's* + CRLF'
                else
                  FPath := FPath + 's' + CRLF;
              end
              else
              begin
                if FillAlternate then
                  FPath := FPath + 'S*' + CRLF
                else
                  FPath := FPath + 'S' + CRLF;
              end;
              LS := GetLineStyle(Pen.Style) +
                NumToStr(Pen.Width * FPixelToPointMultiplier) + ' w ' +
                ColorToPDFColor(Pen.Color) + ' RG ' + CRLF + FPath;
            end
            else
            begin
              if FIsPathClosed then
              begin
                if FillAlternate then
                  FPath := FPath + 'b* + CRLF'
                else
                  FPath := FPath + 'b' + CRLF;
              end
              else
              begin
                if FillAlternate then
                  FPath := FPath + 'B*' + CRLF
                else
                  FPath := FPath + 'B' + CRLF;
              end;
              LS := GetLineStyle(Pen.Style) +
                NumToStr(Pen.Width * FPixelToPointMultiplier) + ' w ' +
                ColorToPDFColor(Pen.Color) + ' RG ' +
                ColorToPDFColor(Brush.Color) + ' rg ' + CRLF + FPath;
            end;
          end;
          FPath := '';
        end;
      poStrokePath:
        begin
          if FIsPathClosed then
            FPath := FPath + 's' + CRLF
          else
            FPath := FPath + 'S' + CRLF;
          FPathStatus := psNoPath;
          if Pen.Style = psClear then
            LS := ColorToPDFColor(AObject.Brush.Color) + ' rg' + CRLF + FPath
          else
          begin
            if Brush.Style = bsClear then
            begin
              LS := GetLineStyle(Pen.Style) +
                NumToStr(Pen.Width * FPixelToPointMultiplier) + ' w ' +
                ColorToPDFColor(Pen.Color) + ' RG ' + CRLF + FPath;
            end
            else
            begin
              LS := GetLineStyle(Pen.Style) +
                NumToStr(Pen.Width * FPixelToPointMultiplier) + ' w ' +
                ColorToPDFColor(Pen.Color) + ' RG ' +
                ColorToPDFColor(Brush.Color) + ' rg ' + CRLF + FPath;
            end;
          end;
          FPath := '';
        end;
      poSelectClipPath:
        begin
          if FIsPathClosed then
            FPath := FPath + NumToStr(GetNativeXPos(FInitialPos.X)) + ' ' +
              NumToStr(GetNativeYPos(FInitialPos.Y, CurrentPage)) + ' l ';
          if Mode = RGN_COPY then
          begin
            if FIsClipPath then
              FPath := CRLF + ' q ' + CRLF + FPath + ' W* n ' + CRLF
            else
            begin
              FPath := CRLF + ' q ' + CRLF + FPath + ' W* n ' + CRLF;
              FIsClipPath := True;
            end;
          end
          else if Mode = RGN_AND then
          // The new clipping region includes the intersection (overlapping areas)
          // of the current clipping region and the current path.
          // This means use non-zero winding rule.
          begin
            if FIsClipPath then
              FPath := CRLF + ' q ' + CRLF + FPath + ' W n ' + CRLF
            else
            begin
              FPath := CRLF + FPath + ' W* n ' + CRLF;
              FIsClipPath := True;
            end;
          end;
          FIsClipState := True;
          FPathStatus := psNoPath;
          LS := FPath;
          FPath := '';
        end;
    end;
    if (LS <> '') then
    begin
      LATemp := AnsiString(LS);
      FContentStream.Write(LATemp[1], Length(LS));
    end;
  end;
end;

procedure TgtCustomPDFEngine.EncodePolyDraw(AObject: TgtPolyDrawItem);
var
  LI: Integer;
begin
  with AObject do
  begin
    LI := 0;
    if FPathStatus = psPathBegins then
    begin
      while LI < FNoPoints do
      begin
        case FOperations[LI] of
          PT_MOVETO:
            begin
              FPath := FPath + NumToStr(GetNativeXPos(FPoints[LI].X)) + ' ' +
                NumToStr(GetNativeYPos(FPoints[LI].Y, CurrentPage)) +
                ' m ' + CRLF;
              LI := LI + 1;
            end;
          PT_LINETO:
            begin
              FPath := FPath + NumToStr(GetNativeXPos(FPoints[LI].X)) + ' ' +
                NumToStr(GetNativeYPos(FPoints[LI].Y, CurrentPage)) +
                ' l ' + CRLF;
              LI := LI + 1;
            end;
          PT_BEZIERTO:
            begin
              FPath := FPath + NumToStr(GetNativeXPos(FPoints[LI].X)) + ' ' +
                NumToStr(GetNativeYPos(FPoints[LI].Y, CurrentPage)) + ' ' +
                NumToStr(GetNativeXPos(FPoints[LI + 1].X)) + ' ' +
                NumToStr(GetNativeYPos(FPoints[LI + 1].Y, CurrentPage)) + ' ' +
                NumToStr(GetNativeXPos(FPoints[LI + 2].X)) + ' ' +
                NumToStr(GetNativeYPos(FPoints[LI + 2].Y, CurrentPage)) + ' c ';
              LI := LI + 3;
              if (FOperations[LI] = (PT_BEZIERTO or PT_CLOSEFIGURE)) then
                FIsPathClosed := True;
            end;
          PT_LINETO or PT_CLOSEFIGURE:
            begin
              FPath := FPath + NumToStr(GetNativeXPos(FPoints[LI].X)) + ' ' +
                NumToStr(GetNativeYPos(FPoints[LI].Y, CurrentPage)) +
                ' l ' + CRLF;
              FIsPathClosed := True;
              LI := LI + 1;
            end;
          PT_BEZIERTO or PT_CLOSEFIGURE:
            begin
              LI := LI + 1;
            end;
        end;
      end;
    end;
  end;
end;

procedure TgtCustomPDFEngine.EncodeRoundRect(X1, Y1, X2, Y2, X3, Y3: Double;
  Pen: TPen; Brush: TBrush);
var
  EllipseCtrlPts: TgtEllipseCtrlPoints;
  LS, LPath: String;
  LATemp: AnsiString;
  RoundRectLineWidth, RoundRectLineHeight: Extended;
  LPosX1, LPosY1, LPosX3, LPosY3: Extended;
begin
  LS := '';
  if (Abs(Y2 - Y1) < Y3) then
    Y3 := Abs(Y2 - Y1) + 1;
  if (Abs(X2 - X1) < X3) then
    X3 := Abs(X2 - X1) + 1;
  LPosX1 := GetNativeXPos(X1);
  LPosY1 := GetNativeYPos(Y1, CurrentPage);
  LPosX3 := GetNativeXPos(X1 + X3);
  LPosY3 := GetNativeYPos(Y1 + Y3, CurrentPage);

  EllipseCtrlPts := GetEllipseCtrlPts(LPosX1, LPosY1, LPosX3, LPosY3);
  RoundRectLineWidth := GetNativeXPos(X2 - X1 - X3);
  RoundRectLineHeight := (Y2 - Y1 - Y3) * FPixelToPointMultiplier *
    (InputYRes / CPixelsPerInch);

  with EllipseCtrlPts do
  begin
    // Move to starting point.
    LPath := NumToStr(X3) + ' ' + NumToStr(Y1) + ' m ' +
    // Draw RoundRect.
      NumToStr(X3 + RoundRectLineWidth) + ' ' + NumToStr(Y1) + ' l ' +
      PDFCurveto(X4 + RoundRectLineWidth, Y1, X5 + RoundRectLineWidth, Y2,
      X5 + RoundRectLineWidth, Y3) + ' ' + NumToStr(X5 + RoundRectLineWidth) +
      ' ' + NumToStr(Y3 - RoundRectLineHeight) + ' l ' +
      PDFCurveto(X5 + RoundRectLineWidth, Y4 - RoundRectLineHeight,
      X4 + RoundRectLineWidth, Y5 - RoundRectLineHeight,
      X3 + RoundRectLineWidth, Y5 - RoundRectLineHeight) + ' ' + NumToStr(X3) +
      ' ' + NumToStr(Y5 - RoundRectLineHeight) + ' l ' +
      PDFCurveto(X2, Y5 - RoundRectLineHeight, X1, Y4 - RoundRectLineHeight, X1,
      Y3 - RoundRectLineHeight) + ' ' + NumToStr(X1) + ' ' + NumToStr(Y3) +
      ' l ' + PDFCurveto(X1, Y2, X2, Y1, X3, Y1);
  end;

  if Brush <> nil then
  begin
    if Brush.Style = bsSolid then
      LS := LS + ColorToPDFColor(Brush.Color) + ' rg ' + LPath + ' f '
    else if Brush.Style <> bsClear then
      (*
        Select color space - cs.
        Select color for non-stroking pattern - scn.
      *)
      LS := LS + '/CSP cs ' + ColorToPDFColor(Brush.Color) + ' /' +
        GetPattern(Brush.Style) + ' scn n ' + LPath + ' f ';
  end;

  // if ((Pen.Width <> 0) and (Pen.Style <> psClear)) then
  if (Pen.Style <> psClear) then
  begin
    // Line Style.
    LS := LS + GetLineStyle(Pen.Style) +
    // width, spacing and color.
      NumToStr(Pen.Width * FPixelToPointMultiplier) + ' w ' +
      ColorToPDFColor(Pen.Color) + ' RG ' + LPath + ' s';
  end;
  if (LS <> '') then
  begin
    if FIsClipState then
      LS := CRLF + LS + CRLF
    else
      LS := CRLF + 'q' + CRLF + LS + CRLF + 'Q';
    LATemp := AnsiString(LS);
    FContentStream.Write(LATemp[1], Length(LS));
  end;
end;

procedure TgtCustomPDFEngine.EncodeText(AObject: TgtTextItem);
var
  LI: Integer;
  LOriginalText: WideString;
  LIsVerticalFont: boolean;
{$IFDEF ONEView}
  LTextWidth: Double;
{$ENDIF}
  LFont: TFont;
  LStringAnalyzer: TgtStringAnalyzer;

{$IFDEF ONEView}
  function GetTextForWidth(AWidth: Double): String;
  var
    LI: Integer;
  begin
    Result := '';
    with AObject do
      for LI := 1 to Length(Lines[0]) do
      begin
        if TextSize(Result, Font).cx <= AWidth then
          Result := Result + Lines[0][LI]
        else
          Break;
      end;
  end;
{$ENDIF}

begin
  with AObject do
  begin
    LOriginalText := Lines[0];
    // String analysis takes care of determining reading direction based on
    // language of parts of the string.

    Lines[0] := ReplacePlaceHolders(Lines[0], True);

{$IFDEF ONEView}
    LTextWidth := (Page.Width - X - Page.LeftMargin);
    if LTextWidth < 0 then
    begin
      LTextWidth := 0;
      Lines[0] := '';
    end;
    if (((X + Page.LeftMargin + TextSize(Lines[0], Font).cx) > (Page.Width)) and
      (LTextWidth > 0)) then
      Lines[0] := GetTextForWidth(LTextWidth);
{$ENDIF}
    // Find used font among installed fonts and set exact font.name to
    // used font so text case is same as installed fontname - PDF is case
    // sensitive and Adobe reader is very strict on case sensitivity
    LI := FSysFonts.IndexOf(AObject.Font.Name);

    LIsVerticalFont := False;
    if (AObject.Font.Name[1] = '@') then
      LIsVerticalFont := True;

    if (LI <> -1) then
      AObject.Font.Name := FSysFonts.Strings[LI];

    AObject.Font := FMapFont.GetTrueTypeFont(AObject.Lines[0], AObject.Font);

    if LIsVerticalFont and (AObject.Font.Name[1] <> '@') then
    begin
      AObject.Font.Name := '@' + AObject.Font.Name;
    end;

    if (AObject.Font.Size < 0) then
      AObject.Font.Size := FMapFont.GetFontSize(AObject.Font);

    { *** Unicode string handling and font mapping *** }

    // If font is 'Arial Unicode MS', use 'Arial' to start with for analysis of
    // string.
    // String analysis breaks up the input string by the language of each char in
    // the string (keeping successive chars of a language together) and returns
    // the font for each string part that was broken up according to language.
    // 'Arial Unicode MS' slows down this process and 'Arial' is an appropriate
    // equivalent. Languages that use non-latin chars, will be mapped to other
    // appropriate fonts (giving opportunity to developer to specify font). If
    // no suitable font mapping takes place (which is highly unlikely, except when
    // font specified is 'Arial Unicode MS' and chars in string only exist in
    // 'Arial Unicode MS'), try with 'Arial Unicode MS'.
    LFont := TFont.Create;
    FRunFont := TFont.Create;
    LStringAnalyzer := TgtStringAnalyzer.Create;
    try
      LFont.Assign(AObject.Font);
      // if UpperCase(LFont.Name) = UpperCase('Arial Unicode MS') then
      // LFont.Name := 'Arial';
      FRunFont.Assign(LFont);
      LFont.Size := 1000;
      FCurrentTextObj := AObject;
      FRunTextX := AObject.X;
      FRunTextY := AObject.Y;

      // ScriptRunProc is called for every change in language in the string,
      // passing details of the string part from the last change to just before
      // the new change
      LStringAnalyzer.StringAnalyze(Lines[0], AObject.BiDiMode, LFont,
        ScriptRunProc, FMapFont);
      // EncodeText is always called with only one line of text. Lines[0] contains
      // the full input text string.

    finally
      FreeAndNil(LFont);
      FreeAndNil(FRunFont);
      FreeAndNil(LStringAnalyzer);
    end;
    Lines[0] := LOriginalText;
  end;
end;

procedure TgtCustomPDFEngine.EndDoc;
begin
  inherited;
end;

procedure TgtCustomPDFEngine.EndPage;
var
  LS: String;
  LATemp: AnsiString;
  LStreamSize, LImgOffset: Int64;
  (* Required for encryption. *)
  LStream: TMemoryStream;

  LI, LJ, LThumbnailObj: Integer;
  LThumbnail, LCThumbnail: TgtPDFThumbnailItem;
begin

  LThumbnail := nil;
  LCThumbnail := nil;

  (* Set object no. for thumbnail items checking for reuse of image. *)
  if FThumbnailList.IndexOf(IntToStr(CurrentPage)) <> -1 then
  begin
    LCThumbnail := TgtPDFThumbnailItem.Create;
    with TgtPDFThumbnailItem(FThumbnailList.Objects
      [FThumbnailList.IndexOf(IntToStr(CurrentPage))]) do
    begin
      LCThumbnail.OutputImageFormat := OutputImageFormat;
      LCThumbnail.ImagePixelFormat := ImagePixelFormat;
      LCThumbnail.JPEGQuality := JPEGQuality;
      LCThumbnail.IndexNo := IndexNo;
    end;

    LThumbnailObj := 0;
    (*
      Loop through the already rendered pages to check if the image is
      already used.
    *)
    for LI := 1 to CurrentPage - 1 do
    begin
      if LThumbnailObj <> 0 then
        Break;

      (* If Page LI has no thumbnail image, continue the search. *)
      if FThumbnailList.IndexOf(IntToStr(LI)) <> -1 then
        LThumbnail := TgtPDFThumbnailItem
          (FThumbnailList.Objects[FThumbnailList.IndexOf(IntToStr(LI))])
      else
        Continue;

      (*
        If the image is already used, then compare settings.
      *)
      if LThumbnail.IndexNo = LCThumbnail.IndexNo then
      begin
        (*
          Loop through the ImageIndex setting list.
        *)
        if Length(FThumbnailReuseList) >= LCThumbnail.IndexNo + 1 then
          with FThumbnailReuseList[LThumbnail.IndexNo] do
            for LJ := 0 to Count - 1 do
              if TgtPDFThumbnailItem(Objects[LJ]).IsEqual(LCThumbnail) then
                LThumbnailObj := StrToInt(Strings[LJ]);
      end;
    end;
    if LThumbnailObj = 0 then
    begin
      LThumbnailObj := GetNewObjNo;
      if Length(FThumbnailReuseList) < LCThumbnail.IndexNo + 1 then
      begin
        SetLength(FThumbnailReuseList, LCThumbnail.IndexNo + 1);
      end;
      if FThumbnailReuseList[LCThumbnail.IndexNo] = nil then
        FThumbnailReuseList[LCThumbnail.IndexNo] := TStringList.Create;
      LCThumbnail.ObjNo := LThumbnailObj;
      TgtPDFThumbnailItem(FThumbnailList.Objects
        [FThumbnailList.IndexOf(IntToStr(CurrentPage))]).ObjNo := LThumbnailObj;
      FThumbnailReuseList[LCThumbnail.IndexNo].AddObject
        (IntToStr(LThumbnailObj), LCThumbnail);
    end
    else
    begin
      TgtPDFThumbnailItem(FThumbnailList.Objects
        [FThumbnailList.IndexOf(IntToStr(CurrentPage))]).ObjNo := LThumbnailObj;
      FreeAndNil(LCThumbnail);
    end;
  end;

  (* Write Page object. *)
  LS := GetPageDictionary
    (TgtPageInfo(FPageList.Items[FPageList.Count - 1]).ObjNo);
  LS := LS + CRLF;
  WriteObj(LS, TgtPageInfo(FPageList.Items[FPageList.Count - 1]).ObjNo, True);

  (*
    Write
    Page Length object.
    Compression Filter if ZLib turned on.
  *)
  LS := '/Length ' + MakeObjRef(FLengthObjNo);
{$IFDEF gtRegistered}
  if Compression.Enabled then
{$ENDIF}
    LS := LS + '/Filter /FlateDecode';
  LS := LS + CRLF;
  WriteObj(LS, FContentsObjNo, False);

  (* Write actual page Content Stream. *)
  {
    Digital Signature
  }

  (* resolution ends *)

  if FIsClipState then
    LS := CRLF + 'Q' + CRLF
  else
    LS := CRLF + CRLF;

  LATemp := AnsiString(LS);
  FContentStream.Write(LATemp[1], Length(LS));

  LS := 'stream' + CRLF;
  LATemp := AnsiString(LS);
  FOutputStream.Write(LATemp[1], Length(LS));

  LStream := TMemoryStream.Create;
  try
{$IFDEF gtRegistered}
    if Compression.Enabled then
{$ENDIF}
      LStreamSize := CompressStream(FContentStream, LStream,
        Compression.Enabled, Compression.Level)
{$IFDEF gtRegistered}
    else
    begin
      LStream.CopyFrom(FContentStream, 0);
      LStreamSize := LStream.Size;
    end
{$ENDIF}
      ;
    WritePDFStream(LStream, LStream.Size, FContentsObjNo, 0);
    FOutputStream.CopyFrom(LStream, 0);
  finally
    FreeAndNil(LStream);
  end;

  LS := CRLF + 'endstream' + CRLF + 'endobj' + CRLF;
  LATemp := AnsiString(LS);
  FOutputStream.Write(LATemp[1], Length(LS));

  (* Write page stream length object. *)
  LS := '0';
  LS := IntToStr(LStreamSize);
  WriteObj(LS, FLengthObjNo, True);

  (*
    Offset all image XRefs by (page + page length object sizes)
    and add to XRef list.
  *)
  for LI := 0 to FImageXRefList.Count - 1 do
  begin
    LImgOffset := StrToIntDef(FImageXRefList[LI], 0);
    Inc(LImgOffset, FOutputStream.Position);
    AppendXRef(LImgOffset, Integer(FImageXRefList.Objects[LI]));
  end;
  // Write all saved images to main stream.
  if FImageStream.Size > 0 then
    FOutputStream.CopyFrom(FImageStream, 0);
  inherited;

end;

function TgtCustomPDFEngine.GetEllipseCtrlPts(PosX1, PosY1, PosX2,
  PosY2: Double): TgtEllipseCtrlPoints;
var
  cpFactor: Double;
begin
  // cpFactor := 4/3 * (1-cos 45°)/sin 45° := 4/3 * sqrt(2) - 1
  cpFactor := (4.0 / 3.0) * (Sqrt(2) - 1.0);

  with Result do
  begin
    if PosX1 < PosX2 then
      X1 := PosX1
    else
      X1 := PosX2;
    if PosX1 > PosX2 then
      X5 := PosX1
    else
      X5 := PosX2;
    X3 := (PosX1 + PosX2) / 2.0;
    X2 := X3 - cpFactor * (X3 - X1);
    X4 := X3 + cpFactor * (X3 - X1);

    if PosY1 < PosY2 then
      Y5 := PosY1
    else
      Y5 := PosY2;
    if PosY1 > PosY2 then
      Y1 := PosY1
    else
      Y1 := PosY2;
    Y3 := (PosY1 + PosY2) / 2.0;
    Y2 := Y3 - cpFactor * (Y3 - Y1);
    Y4 := Y3 + cpFactor * (Y3 - Y1);
  end;
end;

function TgtCustomPDFEngine.GetImageFilter(OutputImageFormat
  : TgtOutputImageFormat): String;
begin
  Result := '';
  if (OutputImageFormat = ifJPEG) then
    Result := '/Filter' + ImageFilter[OutputImageFormat]
  else if (OutputImageFormat = ifBMP)
{$IFDEF gtRegistered} and (Compression.Enabled) {$ENDIF} then
    Result := '/Filter' + ImageFilter[OutputImageFormat]
{$IFDEF gtPro}
  else if (OutputImageFormat = ifCCITT3) then
    Result := '/Filter' + ImageFilter[OutputImageFormat]
  else if (OutputImageFormat = ifCCITT4) then
    Result := '/Filter' + ImageFilter[OutputImageFormat];
{$ENDIF}
end;

function TgtCustomPDFEngine.GetLineStyle(AStyle: TPenStyle): String;
const
{$IFDEF gtBDS2006}
  LineType: array [TPenStyle] of String = ('[]0', '[16 8]0', '[3 4]0',
    '[8 4 2 4]0', '[8 4 2 4 2 8]0', '', '', '', '');
{$ELSE}
  LineType: array [TPenStyle] of String = ('[]0', '[16 8]0', '[3 4]0',
    '[8 4 2 4]0', '[8 4 2 4 2 8]0', '', '');
{$ENDIF}
begin
  Result := LineType[AStyle];
  if Result <> '' then
    Result := Result + ' d ';
  case FPenJoin of
    pjsBevel:
      Result := Result + '2 j ';
    pjsMiter:
      Result := Result + '0 j ';
    pjsRound:
      Result := Result + '1 j ';
  end;
  case FPenCap of
    pcsRound:
      Result := Result + '1 J ';
    pcsSquare:
      Result := Result + '2 J ';
    pcsFlat:
      Result := Result + '0 J ';
  end;
end;

function TgtCustomPDFEngine.GetMKEntries: string;
var
  LS: String;
begin
  LS := LS + ' /MK <</BG [';
  LS := LS + ColorToPDFColor(DigitalSignature.FFieldProperties.FillColor);
  LS := LS + '] /BC [ 0 0 0 ] /R 0 >>';
  Result := LS;
end;

function TgtCustomPDFEngine.GetNativeXPos(X: Extended): Extended;
begin
  Result := X * FPixelToPointMultiplier * (InputXRes / CPixelsPerInch);
end;

function TgtCustomPDFEngine.GetNativeYPos(Y: Extended; PageNo: Integer)
  : Extended;
begin
  Result := Y * FPixelToPointMultiplier * (InputYRes / CPixelsPerInch);
  // Convert from pixels to points.
  // Y0 is at bottom of screen in PDF.
  if (PageNo <> 0) and (FPageList.Count >= PageNo) and
    (FPageList.Items[PageNo - 1] <> nil) and
    (TgtPageInfo(FPageList.Items[PageNo - 1]).Height <> 0) then
    Result := TgtPageInfo(FPageList.Items[PageNo - 1]).Height *
      (InputYRes / CPixelsPerInch) - Result;
end;

function TgtCustomPDFEngine.GetNewObjNo: Integer;
begin
  Inc(FLastObjNo);
  Result := FLastObjNo;
end;

function TgtCustomPDFEngine.GetPDFBitmapStream(ABitmap: TBitmap): TMemoryStream;
var
  LX, LY: Integer;
  ScanLine: PByteArray;
  LByte: Byte;
  LBitmap: TBitmap;
begin
  Result := TMemoryStream.Create;
  LBitmap := TBitmap.Create;
  try
    LBitmap.Assign(ABitmap);
    LBitmap.PixelFormat := pf24Bit;

    Result.Size := LBitmap.Width * LBitmap.Height * 3;
    for LY := 0 to LBitmap.Height - 1 do
    begin
      ScanLine := LBitmap.ScanLine[LY];
      LX := 0;
      while LX < (LBitmap.Width * 3 - 1) do
      begin
        LByte := ScanLine[LX];
        ScanLine[LX] := ScanLine[LX + 2];
        ScanLine[LX + 2] := LByte;
        Inc(LX, 3);
      end;
      Result.Write(ScanLine[0], (LBitmap.Width * 3));
    end;
  finally
    FreeAndNil(LBitmap);
  end;
end;

function TgtCustomPDFEngine.MakeObjHead(AObjNo: Integer): String;
begin
  Result := IntToStr(AObjNo) + ' 0 obj';
end;

function TgtCustomPDFEngine.MakeObjRef(AObjNo: Integer): String;
begin
  Result := IntToStr(AObjNo) + ' 0 R';
end;

function TgtCustomPDFEngine.NumToStr(AN: Extended): String;
begin
  // Convert to native String.
  Result := FloatToStrFLocale(AN, ffFixed, 18, 4);
end;

function TgtCustomPDFEngine.PDFCurveto(X1, Y1, X2, Y2, X3, Y3: Double): String;
begin
  // Second control point coincides with final point.
  if (X2 = X3) and (Y2 = Y3) then
    (*
      The curve extends from the current point to the point (x3, y3),
      using (x1, y1) and (x3, y3) as the Bézier control points
    *)
    Result := Format('%s %s %s %s y', [NumToStr(X1), NumToStr(Y1), NumToStr(X3),
      NumToStr(Y3)])
  else
    (*
      The curve extends from the current point to the point (x3, y3),
      using (x1, y1) and (x2, y2) as the Bézier control points
    *)
    Result := Format('%s %s %s %s %s %s c', [NumToStr(X1), NumToStr(Y1),
      NumToStr(X2), NumToStr(Y2), NumToStr(X3), NumToStr(Y3)]);
end;

function TgtCustomPDFEngine.PDFShortArc(X, Y, RX, RY, Alpha,
  Beta: Double): String;
var
  cpFactor: Double;
  AlphaRad, BetaRad, cosAlpha, cosBeta, sinAlpha, sinBeta: Double;
begin
  // Convert from degrees to radians.
  AlphaRad := DegreesToRadians(Alpha);
  BetaRad := DegreesToRadians(Beta);
  // This factor is used to calculate control points.
  if AlphaRad = BetaRad then
    cpFactor := 0
  else
    cpFactor := (4.0 / 3 * (1 - Cos((BetaRad - AlphaRad) / 2)) /
      Sin((BetaRad - AlphaRad) / 2));

  sinAlpha := Sin(AlphaRad);
  sinBeta := Sin(BetaRad);
  cosAlpha := Cos(AlphaRad);
  cosBeta := Cos(BetaRad);

  Result := PDFCurveto(X - RX * (cosAlpha - cpFactor * sinAlpha), // X1.
    Y - RY * (sinAlpha + cpFactor * cosAlpha), // Y1.
    X - RX * (cosBeta + cpFactor * sinBeta), // X2.
    Y - RY * (sinBeta - cpFactor * cosBeta), // Y2.
    X - RX * cosBeta, // X3.
    Y - RY * sinBeta); // Y3.
end;

procedure TgtCustomPDFEngine.SetFontEncoding(const Value: TgtPDFFontEncoding);
begin
  FFontEncoding := Value;
end;

procedure TgtCustomPDFEngine.WriteObj(const AStr: String; AObjNo: Integer;
  AIsObjectComplete: boolean);
var
  LObjText: String;
  LATemp: AnsiString;
begin
  LObjText := AStr;
  if System.Pos(CRLF, LObjText) <> 0 then
    LObjText := '<<' + CRLF + LObjText + '>>';
  LObjText := MakeObjHead(AObjNo) + CRLF + LObjText + CRLF;
  if AIsObjectComplete then
    LObjText := LObjText + 'endobj' + CRLF;
  AppendXRef(FOutputStream.Position, AObjNo);   //AppendXRef(FOutputStream.Size, AObjNo);
  LATemp := AnsiString(LObjText);
  FOutputStream.Write(LATemp[1], Length(LObjText));
end;

function TgtCustomPDFEngine.GetNativeText(AStr: String): String;
begin
  Result := AStr;
  Result := ReplaceString(Result, '(', '\(');
  Result := ReplaceString(Result, ')', '\)');
end;

function TgtCustomPDFEngine.CheckOutputImageFormat(Value: TgtOutputImageFormat;
  var S: String): boolean;
begin
  Result := False;
  if (Value in [ifBMP, ifJPEG {$IFDEF gtPro}, ifCCITT3, ifCCITT4 {$ENDIF}]) then
    Result := True
  else
    S := SUnsupportedPDFImageFormat;
end;

procedure TgtCustomPDFEngine.Finish;
var
  LStartXRef, LI, LJ: Integer;
  LS, LS1, LReg, LOrdering: String;
  LATemp: AnsiString;
  LCompStream: TMemoryStream;
  LStream: TgtExtMemStream;
  Stream: TStream;
  (* Required for TrueType Font Embedding. *)
  LFontFile2, LStreamLengthObj: Integer;
  LFont: TFont;
  LStreamSize: Int64;

  (* Required for Fonts. *)
  DescriptorObjNo: Integer;
  DesFontsObjNo, ToUnicodeObjNo: Integer;

  PatternObjNo: Integer;
  (* Function to get the formated cross-reference entrie values. *)
  function MakeXRef(AOffset: Integer; AGenNum: Integer; Afn: Char): String;
  begin
    Result := Format('%.10d %.5d %s', [AOffset, AGenNum, Afn]);
  end;

begin
  inherited;
  FSysFonts.Clear;
  // Write Root object.
  LS := GetCatalogDictionary;
  LS := LS + CRLF;
  WriteObj(LS, cRootObjNo, True);

  if FThumbnailList.Count > 0 then
    WriteThumbnails;
  if FTOCItemList.Count > 0 then
    WriteOutlines;

  for LI := 0 to FThumbnailList.Count - 1 do
    TgtPDFThumbnailItem(FThumbnailList.Objects[LI]).Free;
  FreeAndNil(FThumbnailList);

  for LI := 0 to Length(FThumbnailReuseList) - 1 do
    if FThumbnailReuseList[LI] <> nil then
    begin
      with FThumbnailReuseList[LI] do
        for LJ := 0 to Count - 1 do
          TgtPDFThumbnailItem(Objects[LJ]).Free;
      FreeAndNil(FThumbnailReuseList[LI]);
    end;
  SetLength(FThumbnailReuseList, 0);

  LFontFile2 := 0;
{$IFDEF gtRegistered}
  LStreamLengthObj := 0;
{$ENDIF}
  (* Write Pages Dictionary. *)
  LS1 := '';
  LJ := 0;
  for LI := 0 to FPageList.Count - 1 do
    if FPageList.Items[LI] <> nil then
    begin
      LS1 := LS1 + ' ' + MakeObjRef(TgtPageInfo(FPageList.Items[LI]).ObjNo);
      Inc(LJ);
    end;
  LS := '/Type/Pages' + '/Count ' + IntToStr(LJ) + '/Kids [' + Trim(LS1) +
    ']' + CRLF;
  WriteObj(LS, CPagesTreeObjNo, True);

  LS := '';
  if (BackgroundImage.Graphic <> nil) and
    (not BackgroundImage.Graphic.Empty) then
  begin
    PatternObjNo := GetNewObjNo;
    FPattern.AddObject('PI', TObject(PatternObjNo));
  end;

  if FPattern.Count > 0 then
  begin
    LS := '/ColorSpace <</CSP [/Pattern /DeviceRGB]>>';
    LS := LS + CRLF + '/Pattern <<';
    for LI := 0 to FPattern.Count - 1 do
      LS := LS + '/' + FPattern.Strings[LI] + ' ' +
        MakeObjRef(Integer(FPattern.Objects[LI]));
    LS := LS + '>>' + CRLF;
  end;

  (* Write Resource Dictionary *)
  (* Font Resource *)
  if (FFontTable.Count > 0) then
  begin
    LS := LS + '/Font <<';
    with FFontTable do
      for LI := 0 to Count - 1 do
        LS := LS + '/F' + IntToStr(LI) + ' ' +
          MakeObjRef(TgtPDFFont(Items[LI]).FontInfo.FfiFontObjRef) + ' ';
    // Procset & Image references.
    LS := LS + '>>' + CRLF;
  end;
  (* ProcSet Reference *)
  LS := LS + '/ProcSet ' + MakeObjRef(CProcSetObjNo);
  (* Image Resource *)
  if (Length(FImageSettings) > 0) or ((BackgroundImage.Graphic <> nil) and
    (not BackgroundImage.Graphic.Empty)) then
  begin
    LS := LS + '/XObject <<';
    for LI := Low(FImageSettings) to High(FImageSettings) do
      if FImageSettings[LI] <> nil then
        for LJ := 0 to FImageSettings[LI].Count - 1 do
          LS := LS + '/Img' + IntToStr(LI) + IntToStr(LJ) + ' ' +
            MakeObjRef(TgtPDFImageSettings(FImageSettings[LI].Items[LJ]).ObjNo);

    if (BackgroundImage.Graphic <> nil) and
      (not BackgroundImage.Graphic.Empty) then
      LS := LS + ' /Img0 ' + MakeObjRef(FBGImageObj);
    LS := LS + ' >>';
  end;
  LS := LS + CRLF;
  WriteObj(LS, CResourcesObjNo, True);

  (* ProcSet object. *)
  LS := '[/PDF';
  if (irText in ItemsToRender) then
    LS := LS + ' /Text';
  if (irImage in ItemsToRender) then
    LS := LS + ' /ImageC';
  LS := LS + ']';
  WriteObj(LS, CProcSetObjNo, True);

  WritePattern;

  (* Write Font Data *)
  with FFontTable do
    for LI := 0 to Count - 1 do
    begin
      LS1 := '';
      with TgtPDFFont(Items[LI]) do
      begin
        if (FontEncoding = feWinAnsi) then
        begin
          (*
            ANSI Charset Font Encoding.
          *)
          { if ((Font.Charset = ANSI_CHARSET) or
            ((Font.Charset = DEFAULT_CHARSET) and (GetACP = CANSIWinCode))) or
            (Font.Charset = SYMBOL_CHARSET) then }
          DescriptorObjNo := GetNewObjNo;
          (* If not fixed pitch font, write /W widths value. *)
          for LJ := Low(FontInfo.FfiWidths) to High(FontInfo.FfiWidths) do
            LS1 := LS1 + IntToStr(FontInfo.FfiWidths[LJ]) + ' ';

          (* If TrueType write TrueType font dictionary. *)
          if FontInfo.FfiType = ftTrueType then
          begin
            (* TrueType Font Dictionary *)
            LS := '/Type /Font' + '/Subtype /TrueType' + '/Name /F' +
              IntToStr(LI);
            (* If embed subset prefix fontname with some random 6 characters. *)
            if (Preferences.EmbedTrueTypeFonts = etfSubset) and
              (FontEmbedExcludeList.IndexOf(Font.Name) = -1) then
              LS := LS + '/BaseFont /WYOIAS+' + ConvertDelimiters(BaseFont)
            else
              LS := LS + '/BaseFont /' + ConvertDelimiters(BaseFont);
            LS := LS + ' /Encoding /' + PDFFontEncodeStrings[feWinAnsiEncoding]
              + '/FirstChar ' + IntToStr( Low(FontInfo.FfiWidths)) +
              '/LastChar ' + IntToStr( High(FontInfo.FfiWidths));
            LS := LS + '/Widths ' + '[' + Trim(LS1) + ']';
            LS := LS + '/FontDescriptor ' + MakeObjRef(DescriptorObjNo) + CRLF;
            WriteObj(LS, FontInfo.FfiFontObjRef, True);
            (* Font Descriptor Dictionary *)
            with FontInfo do
            begin
              LS := '/Type /FontDescriptor';
              (*
                If embed subset prefix fontname with some random 6 characters.
              *)
              if (Preferences.EmbedTrueTypeFonts = etfSubset) and
                (FontEmbedExcludeList.IndexOf(Font.Name) = -1) then
                LS := LS + '/FontName /WYOIAS+' + ConvertDelimiters(BaseFont)
              else
                LS := LS + '/FontName /' + ConvertDelimiters(BaseFont);
              LS := LS + ' /Flags ' + IntToStr(FfiFlags) +
                Format('/FontBBox' + '[%d %d %d %d]',
                [FfiFontBBox.Left, FfiFontBBox.Bottom, FfiFontBBox.Right,
                FfiFontBBox.Top]) + '/Ascent ' + FloatToStrLocale(FfiAscent) +
                '/Descent ' + FloatToStrLocale(FfiDescent) + '/CapHeight ' +
                FloatToStrLocale(FfiCapHeight) + '/AvgWidth ' +
                IntToStr(FfiAvgWidth) + '/MaxWidth ' + IntToStr(FfiMaxWidth) +
                '/MissingWidth ' + IntToStr(FfiMaxWidth) + '/StemH ' +
                IntToStr(FfiStemV) + '/StemV ' + IntToStr(FfiStemV) +
                '/FontWeight ' + IntToStr(FfiFontWeight);
              if (fsItalic in Font.Style) and (FfiItalicAngle = 0) then
                LS := LS + '/ItalicAngle ' + IntToStr(-12)
              else
                LS := LS + '/ItalicAngle ' + IntToStr(FfiItalicAngle);
              if (Preferences.EmbedTrueTypeFonts <> etfNone) and
                (FontEmbedExcludeList.IndexOf(Font.Name) = -1) then
              begin
                LFontFile2 := GetNewObjNo;
                LS := LS + '/FontFile2 ' + MakeObjRef(LFontFile2);
              end;
              LS := LS + CRLF;
              WriteObj(LS, DescriptorObjNo, True);
            end;
          end;
        end (* End TrueType font dictionary. *)
        { else
          (* If font is not TrueType, write Type1 font dictionary. *)
          begin
          LS :=
          '/Type /Font' +
          '/Subtype /Type1' +
          '/Name /F' + IntToStr(LI) +
          '/BaseFont /' + ConvertDelimiters(BaseFont) +
          '/Encoding /' + PDFFontEncodeStrings[FontEncoding] +
          '/FirstChar ' + IntToStr(Low(FontInfo.FfiWidths)) +
          '/LastChar ' + IntToStr(High(FontInfo.FfiWidths));
          //if not FontInfo.FfiIsFixedPitch then
          LS := LS +
          '/Widths ' + '[' + Trim(LS1) + ']';
          LS := LS +
          '/FontDescriptor ' + MakeObjRef(DescriptorObjNo) +
          CRLF;
          WriteObj(LS, FontInfo.FfiFontObjRef, True);

          (* Font Descriptor Dictionary *)
          with FontInfo do
          begin
          LS :=
          '/Type /FontDescriptor' +
          '/FontName /' + ConvertDelimiters(BaseFont) +
          '/Flags ' + IntToStr(FfiFlags) +
          Format('/FontBBox' + '[%d %d %d %d]', [
          FfiFontBBox.Left,
          FfiFontBBox.Bottom,
          FfiFontBBox.Right,
          FfiFontBBox.Top ]) +
          '/Ascent ' + FloatToStrLocale(FfiAscent) +
          '/Descent ' + FloatToStrLocale(FfiDescent) +
          '/CapHeight ' + FloatToStrLocale(FfiCapHeight) +
          '/AvgWidth ' + IntToStr(FfiAvgWidth) +
          '/MaxWidth ' + IntToStr(FfiMaxWidth) +
          '/StemH ' + IntToStr(FfiStemV) +
          '/StemV ' + IntToStr(FfiStemV);
          (*
          if Preferences.EmbedTrueTypeFonts then
          begin
          LFontFile2 := GetNewObjNo;
          LS := LS + '/FontFile2 ' +
          MakeObjRef(LFontFile2);
          end;
          *)
          LS := LS + CRLF;
          WriteObj(LS, DescriptorObjNo, True);
          end;

          end;
          end (* End ANSI Charset Font Encoding. *) }
        else
        (*
          CID Font Encoding.
        *)
        begin
          if FontInfo.FfiType = ftTrueType then
          begin
            // if (ToUnicodeObjNo = -1) then
            ToUnicodeObjNo := GetNewObjNo;

            DesFontsObjNo := GetNewObjNo;

            LS := GetType0FontDictionary(LI, MakeObjRef(ToUnicodeObjNo),
              MakeObjRef(DesFontsObjNo));
            WriteObj(LS, FontInfo.FfiFontObjRef, True);

            DescriptorObjNo := GetNewObjNo;

            LReg := '<' +
              String(GetHexOfStr
              (AnsiString(WritePDFString(GetCIDFontRegistryEntry(),
              DesFontsObjNo, 0)))) + '>';
            LOrdering := '<' +
              String(GetHexOfStr
              (AnsiString(WritePDFString(GetCIDFontOrderingEntry(),
              DesFontsObjNo, 0)))) + '>';
            LS := '<<' + GetCIDFontDictionary(MakeObjRef(DescriptorObjNo), LReg,
              LOrdering) + '>>';

            // LS := ReplaceString(LS,'(Adobe)',  '<' + GetHexOfStr(WritePDFString('Adobe',
            // DesFontsObjNo, 0)) + '>');
            // LS := ReplaceString(LS,'(Identity)', '<' + GetHexOfStr(
            // WritePDFString('Identity', DesFontsObjNo, 0)) + '>');
            WriteObj(LS, DesFontsObjNo, True);

            if (Preferences.EmbedTrueTypeFonts <> etfNone) and
              (FontEmbedExcludeList.IndexOf(Font.Name) = -1) then
            begin
              LFontFile2 := GetNewObjNo;
              LS := GetFontDescriptor(MakeObjRef(LFontFile2));
            end
            else
              LS := GetFontDescriptor('');
            WriteObj(LS, DescriptorObjNo, True);
            if (ToUnicodeObjNo <> -1) then
            begin
              LStream := TgtExtMemStream.Create;
              try
                TgtPDFFont(FFontTable.Items[LI]).GetCMap(LStream);

                LStreamLengthObj := GetNewObjNo;
                LS := '/Length' + CRLF + MakeObjRef(LStreamLengthObj);
{$IFDEF gtRegistered}
                if Compression.Enabled then
{$ENDIF}
                  LS := LS + '/Filter/FlateDecode';
                WriteObj(LS, ToUnicodeObjNo, False);

                LS := 'stream' + CRLF;
                LATemp := AnsiString(LS);
                FOutputStream.Write(LATemp[1], Length(LS));
                LCompStream := TMemoryStream.Create;
                LStreamSize := CompressStream(LStream, LCompStream,
                  Compression.Enabled, Compression.Level);
                WritePDFStream(LCompStream, LStreamSize, ToUnicodeObjNo, 0);
                FOutputStream.CopyFrom(LCompStream, 0);
                LS := CRLF + 'endstream' + CRLF + 'endobj' + CRLF;
                LATemp := AnsiString(LS);
                FOutputStream.Write(LATemp[1], Length(LS));
                LS := '0';
                LS := IntToStr(LStreamSize);
                WriteObj(LS, LStreamLengthObj, True);
              finally
                LStream.Free;
                LCompStream.Free;
              end;
            end;

          end; (* End if TrueType. *)
          { else
            begin
            LS :=
            '/Type/Font' +
            '/Subtype /Type1' +
            '/Name /F' + IntToStr(LI) +
            '/BaseFont /' + ConvertDelimiters(BaseFont) +
            '/Encoding /' + PDFFontEncodeStrings[FontEncoding] +
            CRLF;
            WriteObj(LS, FontInfo.FfiFontObjRef, True);
            end; (* End else for CID. *)
          }
        end; (* End CID. *)

        if (FontEmbedExcludeList.IndexOf(Font.Name) = -1) and
          (FontInfo.FfiType = ftTrueType) and
          (Preferences.EmbedTrueTypeFonts <> etfNone) then
        begin
          LStream := TgtExtMemStream.Create;
          LFont := TFont.Create;
          LFont.Assign(Font);
          if Preferences.EmbedTrueTypeFonts = etfFull then
            GetFontFile2(TMemoryStream(LStream))
          else
            GetFontFile2Subset(LStream);
          try
            LStreamSize := LStream.Size;
            LStream.Position := 0;

            LS := '/Length1 ' + IntToStr(LStreamSize);
{$IFDEF gtRegistered}
            if Compression.Enabled then
{$ENDIF}
            begin
              LStreamLengthObj := GetNewObjNo;
              LS := LS + '/Length' + CRLF + MakeObjRef(LStreamLengthObj);
              LS := LS + '/Filter/FlateDecode';
            end
{$IFDEF gtRegistered}
            else
              LS := LS + '/Length' + CRLF + IntToStr(LStreamSize)
{$ENDIF}
                ;
            WriteObj(LS, LFontFile2, False);

            LS := 'stream' + CRLF;
            LATemp := AnsiString(LS);
            FOutputStream.Write(LATemp[1], Length(LS));
            LCompStream := TMemoryStream.Create;
            LStreamSize := CompressStream(LStream, LCompStream,
              Compression.Enabled, Compression.Level);
            WritePDFStream(LCompStream, LStreamSize, LFontFile2, 0);
            FOutputStream.CopyFrom(LCompStream, 0);
            LS := CRLF + 'endstream' + CRLF + 'endobj' + CRLF;
            LATemp := AnsiString(LS);
            FOutputStream.Write(LATemp[1], Length(LS));

            LS := '0';
            LS := IntToStr(LStreamSize);
            WriteObj(LS, LStreamLengthObj, True);
          finally
            FreeAndNil(LStream);
            FreeAndNil(LFont);
            FreeAndNil(LCompStream);
          end;
        end; (* End EmbedTrueTypeFont *)
      end; (* End With *)
    end; (* End PDF Fonts Processing. *)

  WriteEncryptionDictionary;

  (* Document Info object. *)
  LS := '';

  LS := LS + '/CreationDate <';
  LS := LS + String(GetHexOfStr(AnsiString(WritePDFString(FCreationTime,
    CInfoObjNo, 0)))) + '>';

  LS := LS + '/ModDate <';
  LS := LS + String(GetHexOfStr(AnsiString(WritePDFString(FCreationTime,
    CInfoObjNo, 0)))) + '>';

  LS := LS + '/Producer <';
  LS1 := 'Gnostice eDocEngine V' + CVersion;
  LS := LS + ToUnicodeHex(LS1, CInfoObjNo, 0) + '>';

  { LS := LS + String(GetHexOfStr(AnsiString(WritePDFString(LS1,
    CInfoObjNo, 0)))) + '>'; }

  if (Trim(DocInfo.Author) <> '') then
  begin
    LS := LS + '/Author <' + ToUnicodeHex(DocInfo.Author, CInfoObjNo, 0) + '>';
  end;

  if (Trim(DocInfo.Keywords) <> '') then
  begin
    LS := LS + '/Keywords <' + ToUnicodeHex(DocInfo.Keywords,
      CInfoObjNo, 0) + '>';
  end;

  if (Trim(DocInfo.Creator) <> '') then
  begin
    LS := LS + '/Creator <' + ToUnicodeHex(DocInfo.Creator, CInfoObjNo,
      0) + '>';
  end;

  if (Trim(DocInfo.Title) <> '') then
  begin
    LS := LS + '/Title <' + ToUnicodeHex(DocInfo.Title, CInfoObjNo, 0) + '>';
  end;

  if (Trim(DocInfo.Subject) <> '') then
  begin
    LS := LS + '/Subject <' + ToUnicodeHex(DocInfo.Subject, CInfoObjNo,
      0) + '>';
  end;
  LS := LS + CRLF;
  WriteObj(LS, CInfoObjNo, True);

  LStartXRef := FOutputStream.Position;

  (* XRef table. *)
  (* Write Default First cross-reference entry. *)
  LS := 'xref' + CRLF + '0 ' + IntToStr(FLastObjNo + 1) + CRLF +
    MakeXRef(0, 65535, 'f') + CRLF;
  with FXRefTable do
    for LI := 0 to FLastObjNo - 1 do
      if IndexOfObject(TObject(LI + 1)) <> -1 then
        LS := LS + MakeXRef(StrToIntDef(Strings[IndexOfObject(TObject(LI + 1))],
          0), 0, 'n') + CRLF;
  LATemp := AnsiString(LS);
  FOutputStream.Write(LATemp[1], Length(LS));

  (* Trailer *)
  LS := 'trailer' + CRLF + '<<' + CRLF;
  LS := LS + GetTrailer + CRLF;
  LS := LS + '>>' + CRLF + 'startxref' + CRLF + IntToStr(LStartXRef) + CRLF
    + '%%EOF';
  LATemp := AnsiString(LS);
  FOutputStream.Write(LATemp[1], Length(LS));
  if DigitalSignature.Enabled then
    WriteSignature;

  (* Code to free resources continues... *)
  (* Free cross-reference table *)
  FreeAndNil(FXRefTable);

  FreeAndNil(FPattern);

  (* Free font information list *)
  for LI := 0 to FFontTable.Count - 1 do
    TgtPDFFont(FFontTable.Items[LI]).Free;
  FreeAndNil(FFontTable);

  (* Free image cross-reference table. *)
  FreeAndNil(FImageXRefList);
  for LI := 0 to Length(FImageSettings) - 1 do
  begin
    if FImageSettings[LI] <> nil then
      with FImageSettings[LI] do
        for LJ := 0 to Count - 1 do
          TgtImageSettings(Items[LJ]).Free;
    FreeAndNil(FImageSettings[LI]);
  end;

  for LI := 0 to FPageList.Count - 1 do
    TgtPageInfo(FPageList.Items[LI]).Free;
  FreeAndNil(FPageList);

  FreeAndNil(FImageStream);
  FreeAndNil(FContentStream);

  if not Preferences.OutputToUserStream then
    FreeAndNil(FOutputStream);
  FreeAndNil(FPDFEncrypt);
end;

procedure TgtCustomPDFEngine.Start;
var
  LS: String;
  LTmZone: TTimeZoneInformation;
  LATemp: AnsiString;
begin
  inherited;

  FThumbnailList := TStringList.Create;

  if not Preferences.OutputToUserStream then
  begin
    FOutputStream := CreateFile(FileName + '.' + FileExtension);
    EngineFileNames.Add(FileName + '.' + FileExtension);
  end
  else
    FOutputStream := UserStream;

  FXRefTable := TStringList.Create;
  FImageXRefList := TStringList.Create;
  SetLength(FImageSettings, 0);
  FImageStream := TMemoryStream.Create;
  FContentStream := TMemoryStream.Create;
  FPageList := TList.Create;

  FFontTable := TList.Create;

  FPattern := TStringList.Create;
  FLastObjNo := CLastReservedObjNo;
  FBGImageObj := -1;

  // Get Creation Date-Time
  GetTimeZoneInformation(LTmZone);
  LS := Format('%.2d', [LTmZone.Bias div -60]);
  if LS[1] <> '-' then
  begin
    LS := '+' + LS;
    LTmZone.Bias := LTmZone.Bias * -1;
  end;
  LS := LS + '''' + Format('%.2d', [LTmZone.Bias mod 60]) + '''';
  FCreationTime := 'D:' + FormatDateTime('yyyymmddhhnnss', Now) + LS;

  if (Encryption.Enabled) then
    FPDFEncrypt := TgtPDFEncryption.Create(AnsiString((FileName + FileExtension)
      ), AnsiString(FCreationTime), Encryption);
  // Write header.
  LS := '%PDF-1.4' + CRLF + '%âãÏÓ' + CRLF;
  LATemp := AnsiString(LS);
  FOutputStream.Write(LATemp[1], Length(LATemp));
  FSysFonts.Clear;
  FSysFonts.AddStrings(Screen.Fonts);
end;

procedure TgtCustomPDFEngine.WritePDFStream(var InputStream: TMemoryStream;
  StreamSize, ObjNo, GenNo: Integer);
begin
  if Encryption.Enabled then
    FPDFEncrypt.EncryptStream(InputStream, StreamSize, ObjNo, GenNo);
end;

function TgtCustomPDFEngine.WritePDFString(InputString: String;
  ObjNo, GenNo: Integer): String;
var
  LStr: TgtExtMemStream;
  LSize: Integer;
begin
  Result := '';
  LSize := Length(InputString);
  SetLength(Result, LSize);
  if Encryption.Enabled then
  begin
    LStr := TgtExtMemStream.Create;
    try
      LStr.WriteString(AnsiString(InputString));
      LStr.Position := 0;
      FPDFEncrypt.EncryptStream(TMemoryStream(LStr), LSize, ObjNo, GenNo);
      LStr.Position := 0;
      Result := String(LStr.ReadString(LSize));
    finally
      LStr.Free;
    end;
  end
  else
    Result := InputString;
end;

procedure TgtCustomPDFEngine.WriteSignature;
var
  LOffset1, LOffset2, LOffset3, LOffset4: Int64;
  LI: Integer;
  LStr: AnsiString;
  LTmpSig: TgtSignature;
  LDate: TgtDate;
  LDateStr: WideString;
  LStr2: WideString;
begin
  LTmpSig := Signature;
  TmpSigOffset2 := FOutputStream.Position;
  FOutputStream.Write(LStr[1], Length(string(LStr)));
  LStr := '';
  FOutputStream.Position := TmpSigOffset1;
  LStr := LStr + '/Type ' + '/Sig' + ' /Filter /' + AnsiString(LTmpSig.Filter) +
    ' /SubFilter /' + AnsiString(LTmpSig.SubFilter);
  if LTmpSig.Author <> '' then
    LStr := LStr + ' /Name (' + AnsiString(LTmpSig.Author) + ')';
  if LTmpSig.Reason <> '' then
    LStr := LStr + ' /Reason (' + AnsiString(LTmpSig.Reason) + ')';
  if LTmpSig.Location <> '' then
    LStr := LStr + ' /Location (' + AnsiString(LTmpSig.Location) + ')';
  if LTmpSig.ContactInfo <> '' then
    LStr := LStr + ' /ContactInfo (' + AnsiString(LTmpSig.ContactInfo) + ')';
  if LTmpSig.DateTime <> 0 then
  begin
    DecodeDate(LTmpSig.DateTime, LDate.Year, LDate.Month, LDate.Day);
    DecodeTime(LTmpSig.DateTime, LDate.Hour, LDate.Minutes, LDate.Seconds,
      LDate.MilliSeconds);
    if LDate.Hour = 0 then
      DecodeTime(Now, LDate.Hour, LDate.Minutes, LDate.Seconds,
        LDate.MilliSeconds);
    LDateStr := WideString(DateToPDFString(LDate));
    LStr := LStr + ' /M (' + AnsiString(LDateStr) + ')';
  end;
  LStr := LStr + ' /Contents<';
  FOutputStream.Write(LStr[1], Length(string(LStr)));
  LOffset1 := 0;
  LOffset2 := FOutputStream.Position - 1;
  LStr := '';
  for LI := FOutputStream.Position to (FOutputStream.Position +
    PDF_DOC_ENVELOPELENGTH) - 1 do // negating >
    LStr := LStr + ' ';
  FOutputStream.Write(LStr[1], Length(string(LStr)));
  LOffset3 := FOutputStream.Position + 1;
  LOffset4 := TmpSigOffset2 - LOffset3;
  LStr2 := '>/ByteRange ' + '[' + IntToStr(LOffset1) + ' ' + IntToStr(LOffset2)
    + ' ' + IntToStr(LOffset3) + ' ' + IntToStr(LOffset4) + ']';
  LStr := AnsiString(LStr2);
  FOutputStream.Write(LStr[1], Length(string(LStr)));
  WriteSignatureDigest(LOffset1, LOffset2, LOffset3, LOffset4);

end;

procedure TgtCustomPDFEngine.WriteSignatureDigest(AOffset1, AOffset2, AOffset3,
  AOffset4: Int64);
var
  LBytes: array of Byte;
  LEnvelope: TgtDigitalIntf;
  LTFileStream: TStream;
  // LCertContext: PCertContext;
  LSignedData: AnsiString;
  LHashMessage: AnsiString;
  LHexdata: AnsiString;
  pHash: PByte;
  LI: Integer;
  LDataLength: Integer;
begin
  Signature.Offset1 := AOffset1;
  Signature.Offset2 := AOffset2;
  Signature.Offset3 := AOffset3;
  Signature.Offset4 := AOffset4;
  FOutputStream.Position := TmpSigOffset2;
  LTFileStream := FOutputStream;
{$IFDEF VCL6ORABOVE}
  LTFileStream.Seek(AOffset1, soBeginning);
{$ELSE}
  LTFileStream.Seek(AOffset1, soFromBeginning);
{$ENDIF}
  SetLength(LBytes, (AOffset2 - AOffset1 + AOffset4));
  LTFileStream.Read(LBytes[0], AOffset2 - AOffset1);
{$IFDEF VCL6ORABOVE}
  LTFileStream.Seek(AOffset3, soBeginning);
{$ELSE}
  LTFileStream.Seek(AOffset3, soFromBeginning);
{$ENDIF}
  LTFileStream.Read(LBytes[Integer(AOffset2) - AOffset1], AOffset4);
  LEnvelope := TgtDigitalIntf.Create;
  try
    LEnvelope.CertContext := (LEnvelope.PKCS7).GetPFXCertWithPvtKey
      (AnsiString(Signature.CertFileName), AnsiString(Signature.CertPassword));
    LHashMessage := (LEnvelope.PKCS7).ComputeHash(@LBytes[0], Length(LBytes));
    Finalize(LBytes);
    GetMem(pHash, Length(LHashMessage));
    System.Move(Pointer(LHashMessage)^, pHash^, Length(LHashMessage));
    LSignedData := (LEnvelope.PKCS7).SignMessage(LEnvelope.CertContext, pHash,
      Length(LHashMessage), False);
    FreeMem(pHash);
    LHexdata := GetHexOfStr1(LSignedData, Length(LSignedData));
  finally
    LEnvelope.Free;
  end;
  LDataLength := Length(LHexdata);
  SetLength(LHexdata, PDF_DOC_ENVELOPELENGTH);
  for LI := LDataLength + 1 to Length(LHexdata) do
  begin
    LHexdata[LI] := '0';
  end;
  FOutputStream.Position := AOffset2 + 1;
  FOutputStream.Write(LHexdata[1], Length(string(LHexdata)));
  Finalize(LHexdata);

end;

function TgtCustomPDFEngine.GetHexOfStr1(ASourceString: AnsiString;
  ALength: Integer): AnsiString;
const
  Convert: array [0 .. 15] of AnsiChar = '0123456789ABCDEF';
var
  LI: Integer;
begin
  Result := '';
  for LI := 1 to ALength do
  begin
    Result := Result + Convert[Byte(ASourceString[LI]) shr 4];
    Result := Result + Convert[Byte(ASourceString[LI]) and $F];
  end;
end;

function TgtCustomPDFEngine.DateToPDFString(Value: TgtDate): AnsiString;
var
  Month: AnsiString;
  Day: AnsiString;
  Hour: AnsiString;
  Minutes: AnsiString;
  Seconds: AnsiString;
begin
  Month := IntegerToString(Value.Month);
  if Value.Month < 10 then
    Month := '0' + Month;

  Day := IntegerToString(Value.Day);
  if Value.Day < 10 then
    Day := '0' + Day;

  Hour := IntegerToString(Value.Hour);
  if Value.Hour < 10 then
    Hour := '0' + Hour;

  Minutes := IntegerToString(Value.Minutes);
  if Value.Minutes < 10 then
    Minutes := '0' + Minutes;

  Seconds := IntegerToString(Value.Seconds);
  if Value.Seconds < 10 then
    Seconds := '0' + Seconds;

  Result := 'D:' + IntegerToString(Value.Year) + Month + Day + Hour + Minutes
    + Seconds;
end;

function TgtCustomPDFEngine.DateToAppearenceString(Value: TgtDate): AnsiString;
var
  Month: AnsiString;
  Day: AnsiString;
  Hour: AnsiString;
  Minutes: AnsiString;
  Seconds: AnsiString;
  Time: AnsiString;
begin
  Month := IntegerToString(Value.Month);
  if Value.Month < 10 then
    Month := '0' + Month;
  Month := Month + '/';
  Day := IntegerToString(Value.Day);
  if Value.Day < 10 then
    Day := '0' + Day;
  // Day := Day + '/';
  Hour := IntegerToString(Value.Hour);
  if Value.Hour < 10 then
    Hour := '0' + Hour;
  Hour := Hour + ':';

  Minutes := IntegerToString(Value.Minutes);
  if Value.Minutes < 10 then
    Minutes := '0' + Minutes;
  Minutes := Minutes + ':';

  Seconds := IntegerToString(Value.Seconds);
  if Value.Seconds < 10 then
    Seconds := '0' + Seconds;
  if (CompareStr(string(Hour), '00:') = 0) then
    Time := ''
  else
    Time := ' T:' + Hour + Minutes + Seconds;
  Result := 'D:' + IntegerToString(Value.Year) + '/' + Month + Day + Time;
end;

function TgtCustomPDFEngine.IntegerToString(AValue: Integer): AnsiString;
begin
  try
{$IFNDEF DOTNET}
    Result := AnsiString(IntToStr(AValue));
{$ELSE}
    Result = Convert.ToString(AValue);
{$ENDIF}
  except
    on E: Exception do
    begin
      Result := '';
{$IFDEF GTDEBUG}
      Logger.LogError('Could not Convert Integer To AnsiString');
      Logger.LogError('Exception Raised with %s', [E.Message]);
{$ENDIF}
      Exit;
    end;
  end;
end;

procedure TgtCustomPDFEngine.WriteSignatureField(ARect: TgtRect;
  APageNo: Integer);
var
  LI: Integer;
  LS: String;
  LS1: AnsiString;
  LNum: Integer;
  LEntries: String;
begin

  LNum := CreateSignatureItem;
  LEntries := GetAPEntries;
  LI := GetNewObjNo;
  SigObjNumber := LI;
  AppendXRef(FOutputStream.Position, LI); //AppendXRef(FOutputStream.Size, LI);
  LS1 := AnsiString(MakeObjHead(LI) + CRLF + '<<');
  FOutputStream.Write(LS1[1], Length(string(LS1)));
  SigPageObjNumber := (TgtPageInfo(FPageList.Items[FPageList.Count - 1]).ObjNo);
  LS := '/Type /Annot ' + '/Subtype /Widget ' + '/Rect [ ' +
    NumToStr(GetNativeXPos(ARect.Left) * (CPixelsPerInch / InputXRes)) + ' ' +
    NumToStr(GetNativeYPos(ARect.Top, APageNo) * (CPixelsPerInch / InputYRes)) +
    ' ' + NumToStr(GetNativeXPos(ARect.Right) * (CPixelsPerInch / InputXRes)) +
    ' ' + NumToStr(GetNativeYPos(ARect.Bottom, APageNo) *
    (CPixelsPerInch / InputYRes)) + ' ]' + GetBorderStyle + GetMKEntries +
    LEntries + ' /FT /Sig /' + 'P ' + IntToStr(SigPageObjNumber) + ' 0 R /' +
    'V ' + IntToStr(LNum) + ' 0 R /T (';
  if SigFieldName <> '' then
    LS := LS + SigFieldName + ')'
  else
    LS := LS + 'Signature)';
  LS := LS + ' /Ff 0 /F 4';
  LS := LS + CRLF + '>>' + CRLF + 'endobj' + CRLF;
  LS1 := AnsiString(LS);
  FOutputStream.Write(LS1[1], Length(string(LS1)));
end;

function TgtCustomPDFEngine.GetPageDictionary(AObjNo: Integer): String;
var
  LPageWidth, LPageHeight: Double;
begin
  (* Current Page Dimensions. *)
  LPageWidth := Pages[CurrentPage - 1].Settings.Width * FPixelToPointMultiplier;
  LPageHeight := Pages[CurrentPage - 1].Settings.Height *
    FPixelToPointMultiplier;

  Result := '';
  Result := '/Type/Page' + '/Parent ' + MakeObjRef(CPagesTreeObjNo) +
    '/MediaBox [0 0 ' + NumToStr(LPageWidth) + ' ' + NumToStr(LPageHeight) + ']'
    + '/Resources ' + MakeObjRef(CResourcesObjNo) + '/Contents ' +
    MakeObjRef(FContentsObjNo);
  if (FAnnots <> '') then
    Result := Result + '/Annots [' + Trim(FAnnots) + ']';
  with ViewerPreferences do
    Result := Result + GetTransitionEffectAndDuration(PresentationMode.Duration,
      PresentationMode.TransitionEffect);
  (* Write Thumbnail. *)
  with FThumbnailList do
  begin
    if (Count > 0) and (IndexOf(IntToStr(CurrentPage)) > -1) then
    begin
      Result := Result + '/Thumb ' +
        MakeObjRef(TgtPDFThumbnailItem(Objects[IndexOf(IntToStr(CurrentPage)
        )]).ObjNo);
    end;
  end;
end;

procedure TgtCustomPDFEngine.WriteEncryptionDictionary;
var
  LS: String;
begin
  if Encryption.Enabled then
  begin
    LS := '';
    FEncryptionObjNo := GetNewObjNo;
    case Encryption.Level of
      el40bit:
        begin
          LS := LS + '/V 1';
          LS := LS + '/R 2';
        end;
      el128bit:
        begin
          LS := LS + '/V 2';
          LS := LS + '/R 3';
        end
    end;
    {
      EncryptionPermission := Not EncryptionPermission;
      EncryptionPermission := EncryptionPermission + 1;
    }
    LS := LS + '/P ' + IntToStr(FPDFEncrypt.PermissionValue);

    if Encryption.Level = el128bit then
      LS := LS + '/Length 128';
    LS := LS + '/Filter/Standard' + '/O <' +
      String(GetHexOfStr(FPDFEncrypt.OwnerKey)) + '>' + '/U <' +
      String(GetHexOfStr(FPDFEncrypt.UserKey)) + '>';
    LS := LS + CRLF;
    WriteObj(LS, FEncryptionObjNo, True);
  end;
end;
{ This code is commented becuse  YouTrack Id EDOC-126 isue  is caused because of
  this and if we add this code EDOC-93 is working fine }
// function TgtCustomPDFEngine.GetTextWidth(const AText: WideString; AFont: TFont;
// AGlyphInfoList: TgtGlyphInfoList; ARunInfo: TgtRunInfo;
// ALogClust: TgtWordArray; ACharSpace: Double): Double;
// var
// J, LTextLength: Integer;
// LPDFFont: TgtPDFFont;
// LI, LFontIdx, LFontObjR: Integer;
// LFontEncoding: TgtFontEncoding;
// LIsIdentityH: Boolean;
// begin
// LIsIdentityH := True;
//
// if ARunInfo.ScriptProcessingRequired then
// LFontEncoding := feCID
// else
// LFontEncoding := feWinAnsi;
//
// // Font already added to used fonts list? Then get the index of font in the list
// LFontIdx := -1;
// for LI := 0 to FFontTable.Count - 1 do
// begin
// if (TgtPDFFont(FFontTable.Items[LI]).IsEqual(AFont, LFontEncoding,
// LIsIdentityH)) then
// begin
// LFontIdx := LI;
// Break;
// end;
// end;
//
// // Else add it and get its index and the PDF font obj in the used fonts list
// if LFontIdx = -1 then
// begin
// LFontObjR := GetNewObjNo;
// if LFontEncoding = feCID then
// LPDFFont := TgtPDFFont.Create(AFont, LFontObjR, True,
// (Preferences.EmbedTrueTypeFonts = etfSubset) and
// (FontEmbedExcludeList.IndexOf(AFont.Name) = -1))
// else
// begin
// LPDFFont := TgtPDFFont.Create(AFont, LFontObjR, False,
// (Preferences.EmbedTrueTypeFonts = etfSubset) and
// (FontEmbedExcludeList.IndexOf(AFont.Name) = -1));
// end;
// FFontTable.Add(LPDFFont);
// end
// else
// LPDFFont := TgtPDFFont(FFontTable.Items[LFontIdx]);
// // Store used GlyphIDs for each font
// if LFontEncoding = feCID then
// LPDFFont.AddUsedGlyphs(AText, AGlyphInfoList)
// else
// LPDFFont.AddUsedCharacters(AText);
// Result := 0;
// try
// // get char width from glyph information
// if ARunInfo.ScriptProcessingRequired then
// begin
// for J := 0 to AGlyphInfoList.Count - 1 do
// Result := Result + AGlyphInfoList[J].AdvWidth;
// end
// else
// begin
// for J := 0 to Length(AText) - 1 do
// Result := Result + PointsToPixels(LPDFFont.FontInfo.FfiWidths
// [Ord(AText[J + 1])]);
// end; // else
// Result := Result * Abs(FCurrentTextObj.Font.Size) / 1000;
// LTextLength := Length(FCurrentTextObj.Lines[0]) - 1;
// Result := ACharSpace * LTextLength + Result;
// finally
//
// end;
// end;

function TgtCustomPDFEngine.GetTrailer: String;
begin
  Result := '/Root ' + MakeObjRef(cRootObjNo) + '/Info ' +
    MakeObjRef(CInfoObjNo) + '/Size ' + IntToStr(FLastObjNo + 1);
  if Encryption.Enabled then
  begin
    Result := Result + '/ID [<' + String(GetHexOfStr(FPDFEncrypt.FileID)) + '><'
      + String(GetHexOfStr(FPDFEncrypt.FileID)) + '>]';
    Result := Result + '/Encrypt ' + MakeObjRef(FEncryptionObjNo);
  end;
end;

function TgtCustomPDFEngine.GetCatalogDictionary: String;
begin
  Result := '/Type/Catalog' + '/Pages ' + MakeObjRef(CPagesTreeObjNo);
  (* Outlines Dictionary Reference. *)
  if FTOCItemList.Count > 0 then
  begin
    FOutlines := GetNewObjNo;
    Result := Result + '/Outlines ' + MakeObjRef(FOutlines);
  end;
  with ViewerPreferences do
    Result := Result + GetViewerPreferences(PageMode, PageLayout, CenterWindow,
      FitWindow, HideWindowUI, HideMenuBar, HideToolBar, NonFullScreenPageMode);
end;

function TgtCustomPDFEngine.GetAPEntries: string;
var
  LS: string;
  LI: Integer;
begin
  if DigitalSignature.FieldProperties.Visible then
  begin
    LI := GetNewObjNo;
    writeAppearance(LI);
    LS := ' /AP <</N ' + IntToStr(LI) + ' 0 R >> ';
  end;
  Result := LS;

end;

function TgtCustomPDFEngine.GetBorderStyle: string;
begin
  Result := ' /BS <</Type /Border /S /S /W 1 >>';
end;

function TgtCustomPDFEngine.GetAnnotBrushStyle(Width: Integer;
  Style: TgtAnnotBrushStyle): String;
const
  BS: array [TgtAnnotBrushStyle] of String = ('S', 'D', 'B', 'I', 'U');
begin
  Result := '';
  Result := '/BS << ';
  Result := Result + '/W ' + IntToStr(Width);
  Result := Result + '/S /' + BS[Style];
  Result := Result + ' >>';
end;

procedure TgtCustomPDFEngine.WriteBackground;
var
  LS: String;
  LATemp: AnsiString;
  PaperWidth, PaperHeight, PaperWidthCenter, PaperHeightCenter: Extended;
  LTop, LLeft, LWidth { , LCommonVale } , LDecreased, LHeight, LTHT,
    LTWT: Double;
  Bmp: TBitmap;
begin
  PaperWidth := TgtPageInfo(FPageList.Items[FPageList.Count - 1]).Width;
  PaperHeight := TgtPageInfo(FPageList.Items[FPageList.Count - 1]).Height;
  PaperWidthCenter := PaperWidth / 2.0;
  PaperHeightCenter := PaperHeight / 2.0;
  LTop := 0; // For dtTile, dtTopLeft, dtTopCenter, dtTopRight
  LLeft := 0; // For dtTile, dtTopLeft, dtCenterLeft, dtBottomLeft
  LWidth := PaperWidth;
  LHeight := PaperHeight;
  // if PaperWidth > PaperHeight then
  // LCommonVale := PaperWidth/PaperHeight
  // else
  // LCommonVale := PaperHeight/PaperWidth;
  if (BackgroundColor <> Graphics.clNone) then
    LS := ColorToPDFColor(BackgroundColor) + ' rg n ' + NumToStr(0) + ' ' +
      NumToStr(0) + ' ' + NumToStr(LWidth) + ' ' + NumToStr(LHeight) +
      ' re f ' + CRLF
  else
    LS := '';

  if (BackgroundImage.Graphic <> nil) and
    (not BackgroundImage.Graphic.Empty) then
    with BackgroundImage do
    begin
      if BackgroundImageDisplayType in [dtCenterLeft, dtCenter,
        dtCenterRight] then
        LTop := PaperHeightCenter - (Height / 2.0)
      else if BackgroundImageDisplayType in [dtTopCenter, dtTopRight,
        dtTopLeft] then
        LTop := PaperHeight - Height;

      if BackgroundImageDisplayType in [dtTopCenter, dtCenter,
        dtBottomCenter] then
        LLeft := PaperWidthCenter - (Width / 2.0)
      else if BackgroundImageDisplayType in [dtTopRight, dtCenterRight,
        dtBottomRight] then
        LLeft := PaperWidth - Width;
      if CurrentPage = 1 then
      begin
        Bmp := TBitmap.Create;
        try
          Bmp.Width := Width;
          Bmp.Height := Height;
          Bmp.Canvas.Draw(0, 0, Graphic);
          FBGImageObj := SaveImageContents(Bmp);
        finally
          Bmp.Free;
        end;
      end;
      LTHT := Height;
      LTWT := Width;
      if LLeft < 0 then
        FBackgroundImageLeft := 0
      else
        FBackgroundImageLeft := LLeft;
      if LTop < 0 then
        FBackgroundImageTop := 0
      else
        FBackgroundImageTop := LTop;
      if ((FBackgroundImageLeft + Width) > PaperWidth) and
        ((FBackgroundImageTop + Height) < PaperHeight) then
      begin
        LDecreased := PaperWidth - FBackgroundImageLeft;
        LTWT := LDecreased;
        LTHT := (LDecreased * (PaperWidth / PaperHeight));
      end;
      if ((FBackgroundImageTop + Height) > PaperHeight) and
        ((FBackgroundImageLeft + Width) < PaperWidth) then
      begin
        LDecreased := PaperHeight - FBackgroundImageTop;
        LTHT := PaperWidth - LDecreased;
        LTWT := PaperHeight - (LDecreased * (PaperHeight / PaperWidth));
      end;
      if ((FBackgroundImageLeft + Width) > PaperWidth) and
        ((FBackgroundImageTop + Height) > PaperHeight) then
      begin
        LTWT := PaperWidth;
        LTHT := PaperHeight;
      end;
      FBackgroundImageWidth := LTWT;
      FBackgroundImageHeight := LTHT;

      LS := LS + '/CSP cs /PI scn n ' + NumToStr(FBackgroundImageLeft) + ' ' +
        NumToStr(FBackgroundImageTop) + ' ' + NumToStr(FBackgroundImageWidth) +
        ' ' + NumToStr(FBackgroundImageHeight) + ' re f';
    end;
  LS := CRLF + 'q' + CRLF + LS + CRLF + 'Q ';
  LATemp := AnsiString(LS);
  FContentStream.Write(LATemp[1], Length(LS));
end;

function TgtCustomPDFEngine.SaveImageContents(ABitmap: TBitmap): Integer;
var
  S: String;
  LATemp: AnsiString;
  BmpStream, Stream: TStream;
  ImageObjNo: Integer;

  // For Encryption
  StreamSize: Integer;
  TmpStream: TMemoryStream;
begin
  S := '';
  BmpStream := nil;
  if ImageSettings.OutputImageFormat <> ifBMP then
    Stream := GetBitmapAsJPGGIFStream(ABitmap,
      (ImageSettings.OutputImageFormat = ifJPEG), ImageSettings.JPEGQuality)
  else
  begin
    Stream := TMemoryStream.Create;
    try
      BmpStream := GetPDFBitmapStream(ABitmap);
      CompressStream(BmpStream, Stream, Compression.Enabled, Compression.Level)
    finally
      FreeAndNil(BmpStream);
    end;
  end;

  try
    ImageObjNo := GetNewObjNo;
    Result := ImageObjNo;
    FImageXRefList.AddObject(IntToStr(FImageStream.Size), TObject(ImageObjNo));

    Stream.Position := 0;

    S := MakeObjHead(ImageObjNo) + CRLF + '<<' + CRLF + '/Type/XObject' +
      '/Subtype/Image' + '/Name/Img0' + '/Width ' + IntToStr(ABitmap.Width) +
      '/Height ' + IntToStr(ABitmap.Height) + '/BitsPerComponent 8' +
      '/ColorSpace/DeviceRGB' +
      Trim(GetImageFilter(ImageSettings.OutputImageFormat)) + '/Length ' +
      IntToStr(Stream.Size) + CRLF + '>>' + CRLF + 'stream' + CRLF;
    LATemp := AnsiString(S);
    FImageStream.Write(LATemp[1], Length(S));

    TmpStream := TMemoryStream.Create;
    TmpStream.CopyFrom(Stream, 0);
    StreamSize := TmpStream.Size;
    WritePDFStream(TmpStream, StreamSize, ImageObjNo, 0);

    FImageStream.CopyFrom(TmpStream, 0);

    S := CRLF + 'endstream' + CRLF + 'endobj' + CRLF;
    LATemp := AnsiString(S);
    FImageStream.Write(LATemp[1], Length(S));
  finally
    Stream.Free;
    TmpStream.Free;
  end;
end;

function TgtCustomPDFEngine.ShowSetupModal: Word;
begin
  with TgtPDFEngineDlg.Create(nil) do
    try
      Engine := Self;
      Result := ShowModal;
    finally
      Free;
    end;
end;

procedure TgtCustomPDFEngine.SetFontEmbedExcludeList(const Value: TStringList);
begin
  FFontEmbedExcludeList.Assign(Value);
end;

procedure TgtCustomPDFEngine.SetCompression(const Value: TgtCompression);
begin
  FCompression := Value;
end;

function TgtCustomPDFEngine.GetPreferences: TgtPDFPreferences;
begin
  Result := TgtPDFPreferences( inherited Preferences);
end;

procedure TgtCustomPDFEngine.SetPreferences(const Value: TgtPDFPreferences);
begin
  inherited Preferences := Value;
end;

procedure TgtCustomPDFEngine.SetSignatureField(ARect: TgtRect;
  APageNo: Integer);
begin
  Rect := ARect;
  SigPageNumber := APageNo;
end;

function TgtCustomPDFEngine.GetPreferencesClassName: TgtPreferencesClass;
begin
  Result := TgtPDFPreferences;
end;

function TgtCustomPDFEngine.GetPattern(AStyle: TBrushStyle): String;
begin
  Result := '';
  case AStyle of
    bsHorizontal:
      begin
        Result := 'PH';
        if FPattern.IndexOf('PH') = -1 then
          FPattern.AddObject('PH', TObject(GetNewObjNo));
      end;
    bsVertical:
      begin
        Result := 'PV';
        if FPattern.IndexOf('PV') = -1 then
          FPattern.AddObject('PV', TObject(GetNewObjNo));
      end;
    bsFDiagonal:
      begin
        Result := 'PFD';
        if FPattern.IndexOf('PFD') = -1 then
          FPattern.AddObject('PFD', TObject(GetNewObjNo));
      end;
    bsBDiagonal:
      begin
        Result := 'PBD';
        if FPattern.IndexOf('PBD') = -1 then
          FPattern.AddObject('PBD', TObject(GetNewObjNo));
      end;
    bsCross:
      begin
        Result := 'PC';
        if FPattern.IndexOf('PC') = -1 then
          FPattern.AddObject('PC', TObject(GetNewObjNo));
      end;
    bsDiagCross:
      begin
        Result := 'PDC';
        if FPattern.IndexOf('PDC') = -1 then
          FPattern.AddObject('PDC', TObject(GetNewObjNo));
      end;
  end;
end;

procedure TgtCustomPDFEngine.WritePattern;
var
  I, LStreamSize: Integer;
  StreamLengthObj: Integer;
  LDict, LStr: String;
  LATemp: AnsiString;
  LStream, LCompStream: TMemoryStream;
begin
  LDict := '/Type /Pattern' + CRLF + '/Resources << /ProcSet [/PDF ] >>' + CRLF
    + '/PatternType 1' + CRLF + '/PaintType 2' + CRLF + '/TilingType 1' + CRLF +
    '/BBox [0 0 5 5]' + CRLF + '/XStep 5' + CRLF + '/YStep 5' + CRLF;
  for I := 0 to FPattern.Count - 1 do
  begin
    if FPattern.Strings[I] = 'PH' then
      LStr := '2 J 2 j 0.3 w 0 2.5 m 5 2.5 l S'
    else if FPattern.Strings[I] = 'PV' then
      LStr := '2 J 2 j 0.3 w 2.5 0 m 2.5 5 l S'
    else if FPattern.Strings[I] = 'PFD' then
      LStr := '2 J 2 j 0.3 w 0 2.5 m 2.5 0 l 5 2.5 m 2.5 5 l S'
    else if FPattern.Strings[I] = 'PBD' then
      LStr := '2 J 2 j 0.3 w 0 2.5 m 2.5 5 l 2.5 0 m 5 2.5 l S'
    else if FPattern.Strings[I] = 'PC' then
      LStr := '2 J 2 j 0.3 w 0 2.5 m 5 2.5 l 2.5 0 m 2.5 5 l S'
    else if FPattern.Strings[I] = 'PDC' then
      LStr := '2 J 2 j 0.3 w 2.5 0 m 5 2.5 l 2.5 5 l 0 2.5 l s'
    else if FPattern.Strings[I] = 'PI' then
    begin
      LStr := CRLF + 'q' + CRLF + NumToStr(FBackgroundImageWidth) + ' 0 0 ' +
        NumToStr(FBackgroundImageHeight) + ' 0 0 ' + 'cm' + CRLF + '/Img0' +
        ' Do' + CRLF + 'Q';
      LDict := '/Type/Pattern' + '/PatternType 1' + '/PaintType 1' +
        '/Resources << ' + '/ProcSet [/PDF /ImageC] /XObject << /Img0 ' +
        MakeObjRef(FBGImageObj) + ' >> ' + CRLF + '>>' + '/TilingType 1' +
        '/BBox [0 0 ' + NumToStr(FBackgroundImageWidth) + ' ' +
        NumToStr(FBackgroundImageHeight) + ']' + '/Matrix [1 0 0 1 ' +
        NumToStr(FBackgroundImageLeft) + ' ' + NumToStr(FBackgroundImageTop) +
        ']' + '/XStep ' + NumToStr(FBackgroundImageWidth) + '/YStep ' +
        NumToStr(FBackgroundImageHeight);
    end;
    LStream := TMemoryStream.Create;
    LCompStream := TMemoryStream.Create;
    LATemp := AnsiString(LStr);
    LStream.Write(LATemp[1], Length(LStr));
    try
{$IFDEF gtRegistered}
      StreamLengthObj := -1;
      if Compression.Enabled then
{$ENDIF}
      begin
        StreamLengthObj := GetNewObjNo;
        LDict := LDict + '/Length' + CRLF + MakeObjRef(StreamLengthObj);
        LDict := LDict + '/Filter/FlateDecode';
      end;
      LDict := LDict + '/Length ' + IntToStr(LStream.Size) + CRLF;
      WriteObj(LDict, Integer(FPattern.Objects[I]), False);
      LStr := 'stream' + CRLF;
      LATemp := AnsiString(LStr);
      FOutputStream.Write(LATemp[1], Length(LStr));
{$IFDEF gtRegistered}
      LStreamSize := LStream.Size;
      if Compression.Enabled then
{$ENDIF}
        LStreamSize := CompressStream(LStream, LCompStream, Compression.Enabled,
          Compression.Level)
{$IFDEF gtRegistered}
      else
        LCompStream.CopyFrom(LStream, 0)
{$ENDIF}
          ;
      WritePDFStream(LCompStream, LStreamSize, Integer(FPattern.Objects[I]), 0);
      FOutputStream.CopyFrom(LCompStream, 0);
      LStr := CRLF + 'endstream' + CRLF + 'endobj' + CRLF;
      LATemp := AnsiString(LStr);
      FOutputStream.Write(LATemp[1], Length(LStr));
{$IFDEF gtRegistered}
      if Compression.Enabled then
{$ENDIF}
      begin
        LStr := IntToStr(LStreamSize);
        if LStr = '' then
          LStr := '0';
        WriteObj(LStr, StreamLengthObj, True);
      end;
    finally
      FreeAndNil(LStream);
      FreeAndNil(LCompStream);
    end;
  end;
end;

procedure TgtCustomPDFEngine.EncodePolyPolyline(AObject: TgtPolyShapeItem;
  IsClosed: boolean);
var
  LJ, LI: Integer;
  LS, LPath: String;
  LATemp: AnsiString;
  LPoints: TgtPoints;
begin
  if (AObject.Shapes.Count = 0) then
    Exit;

  with TgtShapeItem(AObject.Shapes.Items[0]) do
    if ((Pen.Width = 0) or (Pen.Style = psClear)) then
    begin
      if (IsClosed and ((Brush = nil) or (Brush.Style = bsClear))) then
        Exit
      else if (IsClosed = False) then
        Exit;
    end;
  for LJ := 0 to AObject.Shapes.Count - 1 do
  begin
    with TgtShapeItem(AObject.Shapes.Items[LJ]) do
    begin
      SetLength(LPoints, NoPoints);
      LPoints := GetPoints;
      for LI := 0 to NoPoints - 1 do
      begin
        LPath := LPath + NumToStr(GetNativeXPos(LPoints[LI].X)) + ' ' +
          NumToStr(GetNativeYPos(LPoints[LI].Y, CurrentPage)) + ' ';
        if (LI = 0) then
          LPath := LPath + 'm '
        else
          LPath := LPath + 'l ';
      end;
      if IsClosed then
      begin
        LPath := LPath + NumToStr(GetNativeXPos(LPoints[0].X)) + ' ' +
          NumToStr(GetNativeYPos(LPoints[0].Y, CurrentPage)) + ' l '
      end;
    end;
  end;
  with TgtShapeItem(AObject.Shapes.Items[0]) do
  begin
    LS := '';
    if ((Pen.Width <> 0) and (Pen.Style <> psClear)) then
      LS := LS + GetLineStyle(Pen.Style) +
        NumToStr(Pen.Width * FPixelToPointMultiplier) + ' w ' +
        ColorToPDFColor(Pen.Color) + ' RG ';
    if (IsClosed and (Brush <> nil) and (Brush.Style = bsSolid)) then
    begin
      LS := LS + ColorToPDFColor(Brush.Color) + ' rg' + CRLF + LPath + CRLF;
      if (AObject.FillAlternate) then
        LS := LS + 'f*'
      else
        LS := LS + 'f';
    end
    else if (Brush.Style <> bsClear) then
    begin
      LS := LS + '/CSP cs ' + ColorToPDFColor(Brush.Color) + ' /' +
        GetPattern(Brush.Style) + ' scn n' + CRLF + LPath + CRLF;
      if (AObject.FillAlternate) then
        LS := LS + 'f*'
      else
        LS := LS + 'f';
    end;
  end;
  // Added...
  LS := LS + LPath + 's';
  if FIsClipState then
    LS := LS + CRLF
  else
    LS := CRLF + 'q' + CRLF + LS + CRLF + 'Q';
  if (LS <> '') then
  begin
    LATemp := AnsiString(LS);
    FContentStream.Write(LATemp[1], Length(LS));
  end;
end;

procedure TgtCustomPDFEngine.EncodePolyPolygon(AObject: TgtPolyPolygonItem);
var
  LJ, LI, LK: Integer;
  LS, LPath: String;
  LATemp: AnsiString;
begin
  LS := CRLF;
  LPath := '';
  LK := 0;
  LI := 0;
  for LJ := 0 to AObject.FNoPoints[0] - 1 do
  begin
    LPath := LPath + NumToStr(GetNativeXPos(AObject.FPoints[LJ].X)) + ' ' +
      NumToStr(GetNativeYPos(AObject.FPoints[LJ].Y, CurrentPage)) + ' ';
    if (LJ = 0) or (LK = AObject.FNoPoints[LI + 1]) then
    begin
      LPath := LPath + 'm ' + CRLF;
      if (LJ <> 0) then
      begin
        LI := LI + 1;
        LK := 0;
      end;
    end
    else
      LPath := LPath + 'l ' + CRLF;
    LK := LK + 1;
  end;
  LPath := LPath + CRLF;

  if (AObject.Brush <> nil) and (AObject.Brush.Style = bsSolid) then
  begin
    LS := LS + ColorToPDFColor(AObject.Brush.Color) + ' rg' + CRLF +
      LPath + CRLF;
    if (AObject.FillAlternate) then
      LS := LS + 'f*'
    else
      LS := LS + 'f';
  end
  else if (AObject.Brush.Style <> bsClear) then
  begin
    LS := LS + '/CSP cs ' + ColorToPDFColor(AObject.Brush.Color) + ' /' +
      GetPattern(AObject.Brush.Style) + ' scn n' + CRLF + LPath + CRLF;
    if (AObject.FillAlternate) then
      LS := LS + 'f*'
    else
      LS := LS + 'f';
  end;
  if (AObject.Pen.Style <> psClear) then
  begin
    // Line Style.
    LS := LS + GetLineStyle(AObject.Pen.Style) +
    // Border width, spacing and color.
      NumToStr(AObject.Pen.Width * FPixelToPointMultiplier) + ' w ' +
      ColorToPDFColor(AObject.Pen.Color) + ' RG ' + LPath + ' s';
  end;

  if (LS <> '') then
  begin
    if FIsClipState then
      LS := CRLF + LS + CRLF
    else
      LS := CRLF + 'q' + CRLF + LS + CRLF + 'Q ';
    LATemp := AnsiString(LS);
    FContentStream.Write(LATemp[1], Length(LS));
  end;
end;

(* Encoding Direct JPEG stream given *)
procedure TgtCustomPDFEngine.EncodeImageStream(ImgStream: TgtImageStream);
var
  LS: String;
  LATemp: AnsiString;
  ImgObjNo: Integer;
  ImageIndex: String;
  LStream: TMemoryStream;
  LImageSettings: TgtPDFImageSettings;
  LImgItem: TgtImageItem;
  LColorSpace, LPixelFormat: String;

  procedure GetImageProperties;
  var
    LImage: TJPEGImage;
  begin
    if LStream <> nil then
    begin
      LImage := TJPEGImage.Create;
      try
        LStream.Position := 0;
        LImage.LoadFromStream(LStream);
        if LImage.Grayscale then
          LColorSpace := 'DeviceGray'
        else
          LColorSpace := 'DeviceRGB';
        (* TJPEGImage does not consider PixelFormat while loading.
          case LImage.PixelFormat of
          jf24Bit: LPixelFormat := '24';
          jf8Bit: LPixelFormat := '8';
          else
          LPixelFormat := '8';
          end;
        *)
        LPixelFormat := '8';
      finally
        LImage.Free;
      end;
    end;
  end;

begin
  LImgItem := TgtImageItem.Create;
  LStream := TMemoryStream.Create;
  try
    ImgStream.Stream.Position := 0;
    LStream.LoadFromStream(ImgStream.Stream);
    LImgItem.X := ImgStream.X;
    LImgItem.Y := ImgStream.Y;
    LImgItem.Width := ImgStream.Width;
    LImgItem.Height := ImgStream.Height;

    LImgItem.IndexNo := ImgStream.IndexNo;
    LImgItem.Settings := ImgStream.Settings;

    LS := '';
    ImageIndex := '';

    if not(irImage in ItemsToRender) then
      Exit;

    with LImgItem do
    begin
      SetLength(FImageSettings, (IndexNo + 1));
      FImageSettings[IndexNo] := TList.Create;

      (* If new image setting, render new image stream. *)
      if ImageIndex = '' then
      begin
        LStream.Position := 0;

        ImgObjNo := GetNewObjNo;

        ImageIndex := IntToStr(IndexNo);
        LImageSettings := TgtPDFImageSettings.Create;
        with LImageSettings do
        begin
          Assign(Settings);
          ObjNo := ImgObjNo;
          DisplayWidth := DisplayRect.Right - DisplayRect.Left;
          DisplayHeight := DisplayRect.Bottom - DisplayRect.Top;
          ImageWidth := Width;
          ImageHeight := Height;
        end;

        ImageIndex := ImageIndex +
          IntToStr(FImageSettings[IndexNo].Add(LImageSettings));

        // Add obj to list so it can be reused where possible.
        FImageXRefList.AddObject(IntToStr(FImageStream.Size),
          TObject(ImgObjNo));

        (* Get the ColorSpace and the BitsPerComponent properties *)
        GetImageProperties;
        (* Write Image Dictionary. *)
        LS := MakeObjHead(ImgObjNo) + CRLF + '<< ' + '/Type/XObject' +
          '/Subtype/Image' + '/Name/Img' + ImageIndex + '/Width ' +
          IntToStr(ImgStream.ImageWidth) + '/Height ' +
          IntToStr(ImgStream.ImageHeight) + '/BitsPerComponent ' + LPixelFormat
          + '/ColorSpace/' + LColorSpace + GetImageFilter(ifJPEG);
        LS := LS + '/Length ' + IntToStr(LStream.Size) + '>>' + CRLF +
          'stream' + CRLF;
        LATemp := AnsiString(LS);
        FImageStream.Write(LATemp[1], Length(LS));
        LStream.Position := 0;
        WritePDFStream(LStream, LStream.Size, ImgObjNo, 0);
        (* Save the image to a temp stream to write later. *)
        FImageStream.CopyFrom(LStream, 0);

        LS := CRLF + 'endstream' + CRLF + 'endobj' + CRLF;
        LATemp := AnsiString(LS);
        FImageStream.Write(LATemp[1], Length(LS));
      end; (* End If *)

      (*
        Get PDF Image rendering operators to be written into content.
        Also draw any frame if required.
      *)
      LS := EncodeImageObjectRef(ImageIndex, LImgItem);
      if LS <> '' then
      begin
        LATemp := AnsiString(LS);
        FContentStream.Write(LATemp[1], Length(LS));
      end;
    end; (* End with *)
  finally
    LStream.Free;
    LImgItem.Free;
  end;
end;

procedure TgtCustomPDFEngine.DrawJPEGDirect(ARect: TgtRect;
  AImagePixelWidth, AImagePixelHeight: Integer; AStream: TStream);
begin
  inherited;
end;

{$IFDEF gtPro}

function TgtCustomPDFEngine.GetBitmapAsCCITTStream(ABitmap: TBitmap;
  AFormat: TgtOutputImageFormat): TMemoryStream;
begin
  Result := nil;
end;
{$ENDIF}

function TgtCustomPDFEngine.AddTOCItem(Title: WideString;
  ParentNode, PageNumber: Integer; Top: Double): Integer;
begin
  Result := inherited AddTOCItem(Title, ParentNode, PageNumber, Top);
end;

function TgtCustomPDFEngine.AddTOCItem(Title: WideString; ParentNode: Integer;
  URL: String): Integer;
begin
  Result := inherited AddTOCItem(Title, ParentNode, URL);
end;

procedure TgtCustomPDFEngine.WriteOutlines;
var
  LStr: String;
  LInt, LCnt: Integer;

  function FindNextOutline(AStartIndex, AParent: Integer): Integer;
  var
    LFN: Integer;
  begin
    Result := -1;
    with FTOCItemList do
      for LFN := AStartIndex to Count - 1 do
        if TgtTOCItem(Items[LFN]).ParentNode = AParent then
        begin
          Result := LFN;
          Break;
        end;
  end;

  function BuildOutline(CurOutlineIndex, ParentObjNo, PrevObjNo: Integer;
    var LastObjNo, OpenCount: Integer): Integer;
  var
    LS: String;
    LTOCItem: TgtTOCItem;
    Child, Next, LLast, LCount: Integer;
  begin
    LTOCItem := TgtTOCItem(FTOCItemList.Items[CurOutlineIndex]);
    Result := GetNewObjNo;
    LastObjNo := Result;

    LS := LS + '/Title <' + ToUnicodeHex(LTOCItem.Title, Result, 0) + '>';

    if LTOCItem.URL <> '' then
    begin
      (* Point 2 URL *)
      LS := LS + '/A <</S /URI /URI<' +
        String(GetHexOfStr(AnsiString(WritePDFString(Trim(LTOCItem.URL), Result,
        0)))) + '> >>';
    end
    else
    (* Point to a location in file. *)
    (* To include zoom replace null with values from 1 to 16. *)
      if (FPageList.Count >= LTOCItem.PageNumber) and
      (FPageList.Items[LTOCItem.PageNumber - 1] <> nil) then
      LS := LS + '/Dest [' +
        MakeObjRef(TgtPageInfo(FPageList.Items[LTOCItem.PageNumber - 1]).ObjNo)
        + ' /XYZ ' + NumToStr(GetNativeXPos(LTOCItem.X)) + ' ' +
        NumToStr(GetNativeYPos(LTOCItem.Y, LTOCItem.PageNumber)) + ' null]';

    (*
      Include the below code to add
      /F 1 - Italic
      /F 2 - Bold
      /F 3 - Bold+Italic.
      /C Color.
      LS := LS + '/F 3' + '/C [1 0 0]';
    *)

    if ParentObjNo <> -1 then
      LS := LS + '/Parent ' + MakeObjRef(ParentObjNo);

    if PrevObjNo <> -1 then
      LS := LS + '/Prev ' + MakeObjRef(PrevObjNo);

    (* Find Next Outline Item. *)
    Next := FindNextOutline(CurOutlineIndex + 1, LTOCItem.ParentNode);
    if Next <> -1 then
    begin
      Inc(OpenCount);
      LS := LS + '/Next ' + MakeObjRef(BuildOutline(Next, ParentObjNo, Result,
        LastObjNo, OpenCount));
    end;

    (* Find Next Child Outline Item. *)
    Child := FindNextOutline((CurOutlineIndex + 1), CurOutlineIndex);
    if Child <> -1 then
    begin
      LLast := Result;
      LCount := 1;
      LS := LS + '/First ' + MakeObjRef(BuildOutline(Child, Result, -1,
        LLast, LCount));
      LS := LS + '/Last ' + MakeObjRef(LLast);
      (*
        Check if current node is the topmost node; if yes write +ve value for
        count such that the root nodes will be expanded and set to -ve to not
        expand the node.
      *)
      if LTOCItem.ParentNode = -1 then
        LS := LS + '/Count ' + IntToStr(LCount)
      else
        LS := LS + '/Count -' + IntToStr(LCount)
    end;

    LS := LS + CRLF;
    WriteObj(LS, Result, True);
  end;

begin
  LInt := FOutlines;
  LCnt := 1;
  LStr := '/First ' + MakeObjRef(BuildOutline(FindNextOutline(0, -1), FOutlines,
    -1, LInt, LCnt));
  LStr := LStr + '/Last ' + MakeObjRef(LInt);
  LStr := LStr + '/Count ' + IntToStr(LCnt);
  LStr := LStr + CRLF;
  WriteObj(LStr, FOutlines, True);
end;

function TgtCustomPDFEngine.ToUnicodeHex(AStr: WideString;
  AObjNo, AGenNo: Integer): String;
var
  LStr: String;
  LI: Integer;
  LByte: Byte;
begin
  Result := '';
  for LI := 1 to Length(AStr) do
  begin
    LStr := LStr + IntToHex((Ord(AStr[LI])), 4);
  end;

  LI := 1;
  while (LI <= Length(LStr)) do
  begin

    HexToByteValue(LStr[LI] + LStr[LI + 1], LByte);
    Result := Result + Char(LByte);
    Inc(LI, 2);
    {
      HexToByteValue(LStr[LI] + LStr[LI + 1] + LStr[LI + 2] +
      LStr[LI + 3], LByte);
      Result := Result + Char(LByte);
      Inc(LI, 4);
    }
  end;

  Result := String(GetHexOfStr(AnsiString(WritePDFString(#254#255 + Result,
    AObjNo, AGenNo))));
  // Result := String(GetHexOfStr(AnsiString(WritePDFString(Result, AObjNo,
  // AGenNo))));
end;

procedure TgtCustomPDFEngine.writeAppearance(AObjNo: Integer);
var
  LFont: TFont;
  LRect: TgtRect;
  LHieght, LWidth: Double;
  LS1: AnsiString;
  LStream: TMemoryStream;
begin
  AppendXRef(FOutputStream.Position, AObjNo); //AppendXRef(FOutputStream.Size, AObjNo);
  LS1 := AnsiString(MakeObjHead(AObjNo) + CRLF + '<<');
  FOutputStream.Write(LS1[1], Length(string(LS1)));

  LFont := TFont.Create;
  LFont.Name := DigitalSignature.FFieldProperties.Font.Name;
  LFont.Size := DigitalSignature.FFieldProperties.Font.Size;
  LFont.Style := DigitalSignature.FFieldProperties.Font.Style;
  { bounds caliculation }

  LRect.Top := GetNativeXPos(Rect.Top);
  LRect.Left := GetNativeXPos(Rect.Left);
  LRect.Bottom := GetNativeXPos(Rect.Bottom);
  LRect.Right := GetNativeXPos(Rect.Right);
  Rect := LRect;
  LHieght := LRect.Bottom - LRect.Top;
  LWidth := LRect.Right - LRect.Left;

  { font caliculation }
  if DigitalSignature.FFieldProperties.Font.Name = '' then
    DigitalSignature.FFieldProperties.Font.Name := 'Arial';

  LStream := GetSigStream(GetSigText(Signature));

  LS1 := ' /BBox [ 0 0 ' + AnsiString(FloatToStr(LHieght)) + ' ' +
    AnsiString(FloatToStr(LWidth)) + ' ]';
  LS1 := LS1 + ' /Matrix [ 1 0 0 1 0 0 ]';
  LS1 := LS1 + ' /Resources ' + AnsiString(MakeObjRef(CResourcesObjNo)) +
    ' /Subtype /Form /Length ' + IntegerToString(LStream.Size);
  LS1 := LS1 + '>>' + CRLF + 'stream' + CRLF;
  FOutputStream.Write(LS1[1], Length(string(LS1)));
  FOutputStream.CopyFrom(LStream, 0);
  LS1 := CRLF + 'endstream' + CRLF + 'endobj' + CRLF;
  FOutputStream.Write(LS1[1], Length(string(LS1)));
  LStream.Free;
  LFont.Free;

end;

function TgtCustomPDFEngine.GetSigStream(AList: TStringList): TMemoryStream;
var
  LStr, LStr1: AnsiString;
  LFont: TFont;
  I: Integer;
  LStream, Lstream2: TMemoryStream;
  LModSigText: TStringList;
  LIsFitToRect: boolean;
  LWidth { , LHeight } : Integer;
begin
  LStr := AnsiString
    (ColorToPDFColor(DigitalSignature.FFieldProperties.FillColor)) + ' rg 0 0 '
    + FloatToStringLocale(Rect.Bottom - Rect.Top) + ' ' +
    FloatToStringLocale(Rect.Right - Rect.Left) + ' re f ' + '0 0 0' +
    ' RG' + #13#10;

  LFont := DigitalSignature.FieldProperties.Font;
  LWidth := Abs(Round(Rect.Right - Rect.Left));
  // LHeight := abs(Round(Rect.Bottom - Rect.Top));

  { code should be return for fitting the rect }
  LModSigText := TStringList.Create;
  LModSigText.Clear;
  LIsFitToRect := FitTextToWidth(AList, LFont, LWidth - 4, LModSigText);
  if not LIsFitToRect then
    // LIsFitToRect := FitTextToHeight(LModSigText, LFont, LHeight -
    // 4, LFont.Size, LModSigText);

    // repeat
    // LModSigText.Clear;
    // LIsFitToRect := FitTextToWidth(Alist, LFont, LWidth - 4,
    // LModSigText);
    // if not LIsFitToRect then
    // LIsFitToRect := FitTextToHeight(LModSigText, LFont, LHeight -
    // 4, LFont.Size, LModSigText);
    // until (LIsFitToRect = True) or (LFont.Size < 4);

    LStr := LStr + ' BT /' + 'F0' + ' ' + AnsiString(IntToStr(Round(LFont.Size))
      ) + ' Tf ' + AnsiString(ColorToPDFColor(LFont.Color)) + ' rg ' +
      ' 1 0 0 1 ' + FloatToStringLocale(1) + ' ' + FloatToStringLocale
      (LWidth - 2) + ' Tm ' + '0 ' + '-' +
      AnsiString(IntToStr(Round(LFont.Size))) + ' TD';

  for I := 0 to LModSigText.Count - 1 do
  begin
    if LModSigText[I] <> '' then
    begin
      LStr1 := LStr1 + '(' + AnsiString(LModSigText[I]) + ') Tj' + CRLF;
      if I < LModSigText.Count - 1 then
        LStr1 := LStr1 + 'T*' + CRLF;
    end;
  end;
  LStr1 := LStr1 + 'ET Q';

  LStr := LStr + LStr1;
  LStream := TMemoryStream.Create;
  LStream.Write(Pointer(LStr)^, Length(LStr));
  Lstream2 := TMemoryStream.Create;
  { if Compression.Enabled then
    CompressStream(Lstream, Lstream2, true, Compression.Level)
    else }
  Lstream2.CopyFrom(LStream, 0);
  WritePDFStream(Lstream2, Lstream2.Size, FContentsObjNo, 0);
  Result := Lstream2;

  LModSigText.Free;
  LStream.Free;
  AList.Free;
end;

function TgtCustomPDFEngine.FloatToStringLocale(AValue: Double): AnsiString;
var
  LDesSep: AnsiChar;
begin
  LDesSep := AnsiChar({$IFDEF gtDelphiXEUp}FormatSettings.{$ENDIF}DecimalSeparator);
  LockDecimalSep.Acquire;
  try
{$IFDEF gtDelphiXEUp}FormatSettings.{$ENDIF}DecimalSeparator := '.';
    Result := AnsiString(FloatToStr(AValue));
{$IFDEF gtDelphiXEUp}FormatSettings.{$ENDIF}DecimalSeparator := Char(LDesSep);
  finally
    LockDecimalSep.Release;
  end;
end;

function TgtCustomPDFEngine.GetSigText(ASig: TgtSignature): TStringList;
var
  LSigOptions: TgtSigFieldAppearenceOptions;
  LStr, LDateStr: AnsiString;
  LDate: TgtDate;
begin
  Result := TStringList.Create;
  LSigOptions := ASig.SigFieldAppearenceOptions;
  LStr := '';

  if sfaoshowName in LSigOptions then
  begin
    if sfaoshowLabels in LSigOptions then
      LStr := 'Digitally signed by: ';
    LStr := LStr + AnsiString(ASig.Author);
    Result.Add(string(LStr));
    LStr := '';
  end;

  if sfaoshowReason in LSigOptions then
  begin
    if sfaoshowLabels in LSigOptions then
      LStr := 'Reason: ';
    LStr := LStr + AnsiString(ASig.Reason);
    Result.Add(string(LStr));
    LStr := '';
  end;

  if sfaoshowLocation in LSigOptions then
  begin
    if sfaoshowLabels in LSigOptions then
      LStr := 'Location: ';
    LStr := LStr + AnsiString(ASig.Location);
    Result.Add(string(LStr));
    LStr := '';
  end;

  if sfaoshowDate in LSigOptions then
  begin
    if ASig.DateTime <> 0 then
    begin
      DecodeDate(ASig.DateTime, LDate.Year, LDate.Month, LDate.Day);
      DecodeTime(ASig.DateTime, LDate.Hour, LDate.Minutes, LDate.Seconds,
        LDate.MilliSeconds);
      if LDate.Hour = 0 then
        DecodeTime(Now, LDate.Hour, LDate.Minutes, LDate.Seconds,
          LDate.MilliSeconds);

      LDateStr := DateToAppearenceString(LDate);
    end;
    if sfaoshowLabels in LSigOptions then
      LStr := 'Date: ';
    LStr := LStr + LDateStr;
    Result.Add(String(LStr));
  end;
end;

function TgtCustomPDFEngine.FitTextToWidth(AList: TStringList; AFont: TFont;
  AWidth: Integer; AUpdatedList: TStringList): boolean;
var
  LWidth: Double;
  I, J, K, L: Integer;
  LList: TStringList;
  LFont: TFont;
  LTmpString, LTmpString2: string;
begin
  Result := True;
  LFont := TFont.Create;
  LFont.Name := AFont.Name;
  LFont.Size := AFont.Size;
  LFont.Style := AFont.Style;
  LFont.Color := AFont.Color;
  LList := TStringList.Create;
  I := 0;
  while (I <> AList.Count) do
  begin
    LWidth := Round(72 / 96 * TextSize(AList[I], LFont).cx);
    if LWidth > AWidth then
    begin
      // Split the line, take the last word to next line
      Result := False;
      AUpdatedList.Add('');
      LList.Clear;
      LList.DelimitedText := AList[I];
      LWidth := 0;
      J := -1;
      AUpdatedList[AUpdatedList.Count - 1] :=
        Trim(AUpdatedList[AUpdatedList.Count - 1]);
      while (LWidth < AWidth) do
      begin
        Inc(J);
        AUpdatedList[AUpdatedList.Count - 1] :=
          AUpdatedList[AUpdatedList.Count - 1] + LList[J] + ' ';
        if (J = (LList.Count - 1)) then
          Break
        else
          LWidth := Round(72 / 96 * TextSize(AUpdatedList[AUpdatedList.Count -
            1] + LList[J + 1], LFont).cx);
      end;
      // Move remaining words to the first position of source list
      if J <> LList.Count - 1 then
      begin
        LTmpString := '';
        L := I + 1;
        for K := J + 1 to LList.Count - 1 do
          LTmpString := LTmpString + LList[K] + ' ';
        for K := L to AList.Count - 1 do
        begin
          LTmpString2 := AList[K];
          AList[K] := LTmpString;
          LTmpString := LTmpString2;
        end;
        AList.Add(LTmpString);
      end;
    end
    else
      AUpdatedList.Add(AList[I]);
    Inc(I);
  end;
  LList.Free;
  LFont.Free;
end;

function TgtCustomPDFEngine.FitTextToHeight(AList: TStringList; AFont: TFont;
  AHeight: Integer; ALineSpace: Integer; AUpdatedList: TStringList): boolean;
var
  LHeight: Double;
  I: Integer;
  LFont: TFont;
begin
  Result := False;
  LHeight := 0;
  LFont := TFont.Create;
  LFont.Name := AFont.Name;
  LFont.Size := AFont.Size;
  LFont.Style := AFont.Style;
  LFont.Color := AFont.Color;
  for I := 0 to AList.Count - 1 do
  begin
    LHeight := LHeight + TextHeight(AList[I]);
  end;
  LHeight := LHeight + ALineSpace * (AList.Count - 1);
  if LHeight > AHeight then
    AFont.Size := AFont.Size - 2
  else
    Result := True;
  LFont.Free;
end;

procedure TgtCustomPDFEngine.SetVeiwerPreferences
  (const Value: TgtViewerPreferences);
begin
  FViewerPreferences := Value;
end;

procedure TgtCustomPDFEngine.AddThumbnailImage(AGraphic: TGraphic;
  PageNo: Integer);
begin
  if FIsDocumentStarted = False then
    Exit;
  AddThumbnailImage(AddImageAsResource(AGraphic,
    Preferences.UseImagesAsResources), PageNo);
end;

{ Adding signature template }
procedure TgtCustomPDFEngine.AddSignatureSpace(AObjectNumber: Integer);
var
  LATemp: AnsiString;
  LObjText: string;
  I: Integer;
begin
  AppendXRef(FOutputStream.Position, AObjectNumber); //AppendXRef(FOutputStream.Size, AObjectNumber);
  LObjText := MakeObjHead(AObjectNumber) + CRLF + '<<';
  LATemp := AnsiString(LObjText);
  FOutputStream.Write(LATemp[1], Length(LObjText));
  TmpSigOffset1 := FOutputStream.Position;
  LObjText := '';
  for I := TmpSigOffset1 to TmpSigOffset1 + PDF_DOC_SIGVALUELENGTH do
    LObjText := LObjText + ' ';
  LObjText := LObjText + '>>' + CRLF + 'endobj' + CRLF;
  LATemp := AnsiString(LObjText);
  FOutputStream.Write(LATemp[1], Length(LObjText));
end;

procedure TgtCustomPDFEngine.AddThumbnailImage(Index, PageNo: Integer);
var
  LThumbnail: TgtPDFThumbnailItem;
begin
  if FIsDocumentStarted = False then
    Exit;

  LThumbnail := TgtPDFThumbnailItem.Create;
  with LThumbnail do
  begin
    OutputImageFormat := ImageSettings.OutputImageFormat;
    ImagePixelFormat := ImageSettings.ImagePixelFormat;
    JPEGQuality := ImageSettings.JPEGQuality;
    IndexNo := Index;
  end;

  (*
    If ProcessAfterEachPage = True,
    new image cannot be set for already rendered page.
    If ProcessAfterEachPage = False, thumbnail for a page can be changed.
  *)
  if Preferences.ProcessAfterEachPage = False then
  begin
    if (FThumbnailList.IndexOf(IntToStr(PageNo)) <> -1) then
    begin
      TgtPDFThumbnailItem(FThumbnailList.Objects
        [FThumbnailList.IndexOf(IntToStr(PageNo))]).Free;
      FThumbnailList.Delete(FThumbnailList.IndexOf(IntToStr(PageNo)));
    end;
    FThumbnailList.AddObject(IntToStr(PageNo), LThumbnail);
  end
  else if (FThumbnailList.IndexOf(IntToStr(PageNo)) = -1) then
    FThumbnailList.AddObject(IntToStr(PageNo), LThumbnail);
end;

procedure TgtCustomPDFEngine.WriteThumbnails;
var
  LI: Integer;
  LProcessedObjs: TList;
  LStream, LCompressedStream: TMemoryStream;
  LBitmap: TBitmap;
  LS: String;
  LATemp: AnsiString;
begin
  LProcessedObjs := TList.Create;
  LCompressedStream := TMemoryStream.Create;
  LBitmap := TBitmap.Create;
  try
    (* Write Thumbnail Content. *)
    with FThumbnailList do
      for LI := 0 to Count - 1 do
      begin
        LCompressedStream.Clear;
        with TgtPDFThumbnailItem(Objects[LI]) do
          if LProcessedObjs.IndexOf(TObject(ObjNo)) = -1 then
          begin
            LProcessedObjs.Add(TObject(ObjNo));
            case OutputImageFormat of
              ifBMP:
                begin
                  LBitmap.Assign(GetGraphicResource(IndexNo));
                  LBitmap.PixelFormat := ImagePixelFormat;
                  LStream := GetPDFBitmapStream(LBitmap);
                  CompressStream(LStream, LCompressedStream,
                    Compression.Enabled, Compression.Level);
                  LCompressedStream.Position := 0;
                  if (LStream <> nil) then
                    LStream.Clear;
                end;
              ifJPEG:
                begin
                  LBitmap.Assign(GetGraphicResource(IndexNo));
                  LBitmap.PixelFormat := ImagePixelFormat;
                  LCompressedStream :=
                    TMemoryStream(GetBitmapAsJPGGIFStream(LBitmap, True,
                    JPEGQuality));
                  LCompressedStream.Position := 0;
                end;
            end; (* End case. *)
            WritePDFStream(LCompressedStream, LCompressedStream.Size, ObjNo, 0);
            LS := '/Width ' + IntToStr(LBitmap.Width) + '/Height ' +
              IntToStr(LBitmap.Height) + '/ColorSpace /DeviceRGB ' +
              '/BitsPerComponent 8 ' + '/Length ' +
              IntToStr(LCompressedStream.Size);
            LS := LS + GetImageFilter(OutputImageFormat);
            LS := LS + CRLF;
            WriteObj(LS, ObjNo, False);
            LS := 'stream' + CRLF;
            LATemp := AnsiString(LS);
            FOutputStream.Write(LATemp[1], Length(LS));
            FOutputStream.CopyFrom(LCompressedStream, 0);
            LS := CRLF + 'endstream' + CRLF + 'endobj' + CRLF;
            LATemp := AnsiString(LS);
            FOutputStream.Write(LATemp[1], Length(LS));
          end; (* End found Index. *)
      end;
  finally
    FreeAndNil(LProcessedObjs);
    if (LStream <> nil) then
      FreeAndNil(LStream);
    FreeAndNil(LCompressedStream);
    FreeAndNil(LBitmap);
  end;
end;

procedure TgtCustomPDFEngine.SetEncryption(const Value
  : TgtPDFEncryptionSettings);
begin
  FEncryption := Value;
end;

procedure TgtCustomPDFEngine.TextOutV(X, Y: Double; Text: WideString;
  TopDown: boolean);
begin
  inherited;

end;

procedure TgtCustomPDFEngine.DrawJPEGDirect(ImageRect: TgtRect;
  AGraphic: TGraphic);
begin
  inherited;

end;

function TgtCustomPDFEngine.ConvertDelimiters(AString: String): String;
const
  CDelimiters: array [1 .. 10] of Char = ('(', ')', '<', '>', '[', ']', '{',
    '}', '/', '%');
var
  LI: Integer;
begin
  Result := AString;
  for LI := Low(CDelimiters) to High(CDelimiters) do
  begin
    Result := ReplaceString(Result, CDelimiters[LI],
      '#' + IntToHex(Ord(CDelimiters[LI]), 2));
  end;
end;

procedure TgtCustomPDFEngine.ScriptRunProc(AText: WideString;
  ARunIndex, ARunCount: Integer; var AGlyphInfoList: TgtGlyphInfoList;
  ARunInfo: TgtRunInfo; ALogClust: TgtWordArray);
var
  LRunFontName: string;

  procedure CopyGlyphInfos;
  var
    LI: Integer;
  begin
{$IFDEF WIN64}
    if (Assigned(AGlyphInfoList)) And (AGlyphInfoList.Count <> 0) And
      (AGlyphInfoList <> nil) then
{$ELSE}
    if (AGlyphInfoList <> nil) And (AGlyphInfoList.Count <> 0) then
{$ENDIF}
    begin
      for LI := 0 to AGlyphInfoList.Count - 1 do
        FRunStore.FGlyphInfoList.Add(AGlyphInfoList.Items[LI]);

      if AGlyphInfoList.Count > 0 then
        FreeAndNil(AGlyphInfoList);
    end;
  end;

  procedure CopyLogClustAndRunInfo;
  var
    LI, LJ, LPos: Integer;
  begin
    // Add to the existing list
    with FRunStore do
    begin
      LJ := Length(FLogClust);
      SetLength(FLogClust, Length(FLogClust) + Length(ALogClust));

      if LJ = 0 then
        LPos := 0
      else
        LPos := FLogClust[LJ - 1] + 1;

      // Incrementing the values by 'Length(FLogClust)', and storing in ALogClust
      // This is required since the current string is merged with Prev string

      // FLogClust holds the mapping values from input char to output glyph.
      for LI := 0 to Length(ALogClust) - 1 do
      begin
        FLogClust[LJ] := ALogClust[LI] + LPos;
        Inc(LJ);
      end;

      // Run Info : VisAttr
      LJ := Length(FRunInfo.VisAttr);
      SetLength(FRunInfo.VisAttr, Length(FRunInfo.VisAttr) +
        Length(ARunInfo.VisAttr));
      // Incrementing the values by 'Length(FLogClust)', and storing in ALogClust
      // This is required since the current string is merged with Prev string

      // FLogClust holds the mapping values from input char to output glyph.

      for LI := 0 to Length(ARunInfo.VisAttr) - 1 do
      begin
        FRunInfo.VisAttr[LJ] := ARunInfo.VisAttr[LI];
        Inc(LJ);
      end;
    end;
  end;

  function GetPDFFont(ARunStore: TgtRunStore): TgtPDFFont;
  var
    J, LFontIdx: Integer;
    LFontEncoding: TgtFontEncoding;
    LFontObjR: Integer;
    LPDFFont: TgtPDFFont;
  begin
    // *******To get font object
    // get char width from PDFFont object
    if ARunStore.FRunInfo.ScriptProcessingRequired then
      LFontEncoding := feCID
    else
      LFontEncoding := feWinAnsi;
    // Font already added to used fonts list? Then get the index of font in the list
    LFontIdx := -1;
    for J := 0 to FFontTable.Count - 1 do
    begin
      if (TgtPDFFont(FFontTable.Items[J]).IsEqual(ARunStore.Font,
        LFontEncoding)) then
      begin
        LFontIdx := J;
        Break;
      end;
    end;

    // Else add it and get its index and the PDF font obj in the used fonts list
    if LFontIdx = -1 then
    begin
      LFontObjR := GetNewObjNo;
      if LFontEncoding = feCID then
        LPDFFont := TgtPDFFont.Create(ARunStore.Font, LFontObjR, True,
          (Preferences.EmbedTrueTypeFonts = etfSubset) and
          (FontEmbedExcludeList.IndexOf(ARunStore.Font.Name) = -1))
      else
      begin
        LPDFFont := TgtPDFFont.Create(ARunStore.Font, LFontObjR, False,
          (Preferences.EmbedTrueTypeFonts = etfSubset) and
          (FontEmbedExcludeList.IndexOf(ARunStore.Font.Name) = -1));
      end;
      FFontTable.Add(LPDFFont);
    end
    else
      LPDFFont := TgtPDFFont(FFontTable.Items[LFontIdx]);
    // *******To get font object
    Result := LPDFFont;
  end;

  function GetPDFCharSpacing: Double;
  var
    I, J, LTextLength: Integer;
    LTextSize: Double;
    LRunStore: TgtRunStore;
    LPDFFont: TgtPDFFont;
  begin
    Result := 0;
    try
      // Add PDF widths of all the characters, then calculate char spacing
      // using the difference with TextSize().cx value
      for I := 0 to FRunStoreList.Count - 1 do
      begin
        LRunStore := TgtRunStore(FRunStoreList[I]);

        // get char width from glyph information
        if LRunStore.FRunInfo.ScriptProcessingRequired then
        begin
          for J := 0 to LRunStore.GlyphInfoList.Count - 1 do
            Result := Result + LRunStore.GlyphInfoList[J].AdvWidth;
        end
        else
        begin
          LPDFFont := GetPDFFont(LRunStore);

          for J := 0 to Length(LRunStore.FRunText) - 1 do
            Result := Result + PointsToPixels
              (LPDFFont.FontInfo.FfiWidths[Ord(LRunStore.FRunText[J + 1])]);
        end; // else
      end; // for
      Result := Result * Abs(FCurrentTextObj.Font.Size) / 1000;
      LTextSize := TextSizeW(FCurrentTextObj.Lines[0], FRunFont).cx;
      Result := LTextSize - Result;
      LTextLength := Length(FCurrentTextObj.Lines[0]) - 1;
      if LTextLength > 0 then
        Result := Result / LTextLength
      else
        Result := 0;
    finally

    end;
  end;

  function GetTextWidthForBiDiMode(ACharSpace: Double): Double;
  var
    I, J: Integer;
    LRunStore: TgtRunStore;
    LPDFFont: TgtPDFFont;
    LWidth: Double;
  begin
    Result := 0;
    LWidth := 0;
    try
      with FCurrentTextObj do
      begin
        if (BiDiMode = bdRightToLeft) and (not IsFromMetafile) then
        begin
          for I := 0 to FRunStoreList.Count - 1 do
          begin
            Result := Result + LWidth;
            LWidth := 0;
            LRunStore := TgtRunStore(FRunStoreList[I]);
            if not LRunStore.FRunInfo.ScriptProcessingRequired then
            begin
              LPDFFont := GetPDFFont(LRunStore);
              for J := 0 to Length(LRunStore.FRunText) - 1 do
                LWidth := LWidth + PointsToPixels
                  (LPDFFont.FontInfo.FfiWidths[Ord(LRunStore.FRunText[J + 1])]);
              LWidth := LWidth * Abs(FCurrentTextObj.Font.Size) / 1000;

              LWidth := LWidth + ACharSpace * Length(LRunStore.FRunText) - 1;
            end
            else
            begin
              for J := 0 to LRunStore.GlyphInfoList.Count - 1 do
                LWidth := LWidth + LRunStore.GlyphInfoList[J].AdvWidth;
              LWidth := LWidth * Abs((FCurrentTextObj.Font.Size)) / 1000;
            end;
          end;
          Result := Result + LWidth;
        end;
      end;
    finally

    end;
  end;

  procedure WriteTextItems;
  var
    LI: Integer;
    LRunStore: TgtRunStore;
    LSpace: Double;
    LReqStrprocessing: boolean;
  begin
    LReqStrprocessing := False;
    for LI := 0 to FRunStoreList.Count - 1 do
    begin
      LRunStore := TgtRunStore(FRunStoreList[LI]);
      if LRunStore.RunInfo.ScriptProcessingRequired then
      begin
        LReqStrprocessing := True;
        Break;
      end;
    end;
    LSpace := 0;
    if not LReqStrprocessing and not FCurrentTextObj.IsFromMetafile then
      LSpace := GetPDFCharSpacing;
    FRunTextX := FRunTextX - GetTextWidthForBiDiMode(LSpace);
    LSpace := PixelsToPoints(LSpace);
    { This code is commented becuse  YouTrack Id EDOC-126 isue  is caused because of
      this and if we add this code EDOC-93 is working fine }
    // LTextWidth := 0;
    // if not FCurrentTextObj.IsFromMetafile then
    // begin
    // for LI := 0 to FRunStoreList.Count - 1 do
    // begin
    // LRunStore := TgtRunStore(FRunStoreList[LI]);
    // with LRunStore do
    // LTextWidth := LTextWidth + GetTextWidth(LRunStore.FRunText, Font,
    // LRunStore.FGlyphInfoList, LRunStore.FRunInfo,
    // LRunStore.LogClust, LSpace);
    // end;
    // if (FCurrentTextObj.Alignment = haRight) then
    // FRunTextX := FRunTextX - LTextWidth
    // end;

    for LI := 0 to FRunStoreList.Count - 1 do
    begin
      LRunStore := TgtRunStore(FRunStoreList[LI]);
      with LRunStore do
      begin
        EncodeTextPart(RunText, Font, FRunTextX, FRunTextY, LI,
          FRunStoreList.Count - 1, FGlyphInfoList, RunInfo, LogClust,
          LSpace, Angle);
      end;
    end;
    for LI := 0 to FRunStoreList.Count - 1 do
    begin
      LRunStore := TgtRunStore(FRunStoreList[LI]);
      LRunStore.Free;
    end;
    FRunStoreList.Clear;
  end;
  procedure AddToRunStore;
  begin
    FRunStore.Angle := FCurrentTextObj.RotationAngle;
    FRunStoreList.Add(FRunStore);
  end;

begin
  // We get Glyph info with Glyph ID for each character in string.
  // One call is made for every change in language in the string.
  // Along with the Glyph info we also get the suitable font that can render the
  // Text part. Font can change across languages, but it can also stay the same.

  // Add contiguous text parts that are mapped to the same font and
  // encode them into the PDF as one string, calling EncodeTextPart

  if (ARunInfo.ScriptProcessingRequired) then
  begin
    if (AGlyphInfoList = nil) then
      Exit;
    if (AGlyphInfoList.Count = 0) then
    begin
      FreeAndNil(AGlyphInfoList);
      Exit;
    end;
  end;

  LRunFontName := ARunInfo.MappedFontName;

  // First run, init text
  if (ARunIndex = 0) then
  begin
    FRunStore := TgtRunStore.Create;
    with FRunStore do
    begin
      RunText := AText;
      FFont.Assign(FRunFont);
      FFont.Name := LRunFontName;
      FRunInfo := ARunInfo;
    end;

    CopyGlyphInfos;
    CopyLogClustAndRunInfo;
  end
  else // Not first run
  begin
    if (FRunStore.FFont.Name = LRunFontName) and
      (FRunStore.FRunInfo.GlyphType = ARunInfo.GlyphType) and
      (FRunStore.FRunInfo.ScriptProcessingRequired = ARunInfo.
      ScriptProcessingRequired) and
      (ARunInfo.StartPos = FRunStore.FRunInfo.EndPos) then
    begin // same font, merge with prev text
      FRunStore.FRunText := FRunStore.FRunText + AText;
      CopyGlyphInfos;
      CopyLogClustAndRunInfo;
      FRunStore.FRunInfo.EndPos := ARunInfo.EndPos;
    end
    else // diff font, write prev text, store curr text
    begin
      AddToRunStore;
      FRunStore := TgtRunStore.Create;
      with FRunStore do
      begin
        FFont.Assign(FRunFont);
        FFont.Name := LRunFontName;
        FRunInfo := ARunInfo;
        FRunText := AText;
      end;
      CopyGlyphInfos;
      CopyLogClustAndRunInfo;
    end;
  end;
  // last run, write text, clear list
  if (ARunIndex = (ARunCount - 1)) then
  begin
    AddToRunStore;
    WriteTextItems;
  end;
end;

procedure TgtCustomPDFEngine.EncodeTextPart(const AText: WideString;
  AFont: TFont; AX, AY: Double; ARunIndex, ARunCount: Integer;
  AGlyphInfoList: TgtGlyphInfoList; ARunInfo: TgtRunInfo;
  ALogClust: TgtWordArray; ACharSpace: Double; AAngle: Integer);
var
  LCosA, LSinA: Double;
  LI, LFontIdx, LFontObjR, LCharVal: Integer;
  LTextSize: TSize;
  LS: String;
  LATemp: AnsiString;
  TempStr: String;
  LTempCharSpace: array of Double;
  LParseEncodeText, LLinkText: String;
  LLinkObjNo: Integer;
  LStartPos, LGlyPos, LPrev, LTempPos { , LLogPos } : Integer;
  LStartPt, LEndPt: Extended;
  LPDFFont: TgtPDFFont;
  LUseInterCharSpacing, LIsIdentityH: Boolean;
  LFontEncoding: TgtFontEncoding;
  LTextWidth: Double;

  LSX1, LSY1, LSX2, LSY2, LSX3, LSY3, LSX4, LSY4: Double;
  LTxtLeft, LTxtBottom: Double;
  
const
  CCJK_Unified_Ideographs_Start = $4E00;
  CCJK_Unified_Ideographs_End = $9FFF;

  function GetTextAsPDFString: String;
  var
    LI: Integer;
  begin
    // Make PDF string of Text, from GlyphIDs
    Result := '';
    for LI := 0 to AGlyphInfoList.Count - 1 do
      Result := Result + IntToHex(AGlyphInfoList.Items[LI].ID, 4);
  end;

  function GetTextAsPDFStringWithCharSpacing(): String;
  var
    LI, LJ: Integer;
  begin
    // Make PDF string of Text, from GlyphIDs
    Result := '';
    LJ := 0;
    for LI := 0 to AGlyphInfoList.Count - 1 do
    begin
      if (LI > 0) and (svClusterStart in ARunInfo.VisAttr[LI]) then
      begin
        Result := Result + NumToStr((LTempCharSpace[LJ]) *
          FPixelToPointMultiplier);
        Inc(LJ);
      end;
      Result := Result + '<';
      Result := Result + IntToHex(AGlyphInfoList.Items[LI].ID, 4);
      Result := Result + '>';
    end;
  end;

  function GetTextWithCharSpacing: String;
  var
    LI: Integer;
  begin
    // Make PDF string of Text, from GlyphIDs
    Result := '';
    for LI := 0 to Length(AText) - 1 do
    begin
      if (LI > 0) then
        Result := Result + NumToStr((LTempCharSpace[LI - 1]) *
          FPixelToPointMultiplier);

      Result := Result + '(';
      if (AText[LI + 1] = '(') or (AText[LI + 1] = ')') or
        (AText[LI + 1] = '\') then
        Result := Result + '\' + AText[LI + 1]
      else
        Result := Result + AText[LI + 1];
      Result := Result + ')';
    end;
  end;

  function EncodeTextDecor(ALineType: TgtLineType;
    AFontInfo: TgtPDFFont): String;
  var
    W, Y: Extended;
    LX1, LY1, LLeftX, LLeftY, LRightX, LRightY, LDx, LDy, LDgl, LAlpha: Double;
  begin
    try
      // Get accurate line width and position for underscore and strikeout, using
      // GDI functions. Enhanced in version 2.0.
      if ALineType = ltUnderline then
      begin
        W := AFontInfo.FontInfo.FfiUnderscoreSize;
        Y := AFontInfo.FontInfo.FfiUnderscorePosition;
      end
      else
      begin
        W := AFontInfo.FontInfo.FfiStrikeoutSize;
        Y := AFontInfo.FontInfo.FfiStrikeoutPosition;
      end;
      LX1 := GetNativeXPos(AX);
      LY1 := GetNativeYPos(AY, CurrentPage) + Y;
      LY1 := LY1 - FCurrentTextObj.Font.Size;

      (* Calculate Left X, Y *)
      LDy := GetNativeYPos(AY, CurrentPage) - LY1;
      LDgl := LDy;
      LAlpha := DegreesToRadians(AAngle);
      LLeftX := LX1 + (LDgl * Sin(LAlpha));
      LLeftY := GetNativeYPos(AY, CurrentPage) - (LDgl * Cos(LAlpha));

      (* Calculate Right X, Y *)
      LDx := LTextWidth * FPixelToPointMultiplier;
      if not(FCurrentTextObj.IsFromMetafile) then
        LDx := LDx * 96 / CPixelsPerInch;
      LDy := GetNativeYPos(AY, CurrentPage) - LY1;
      LDgl := Sqrt((LDx * LDx) + (LDy * LDy));
      if LDy = 0 then
        LAlpha := DegreesToRadians(AAngle) + PI
      else
        LAlpha := DegreesToRadians(AAngle) + ArcTan(LDx / LDy);
      LRightX := LX1 + (LDgl * Sin(LAlpha));
      LRightY := GetNativeYPos(AY, CurrentPage) - (LDgl * Cos(LAlpha));

      Result := NumToStr(W) + ' w ' + NumToStr(LLeftX) + ' ' + NumToStr(LLeftY)
        + ' m ' + NumToStr(LRightX) + ' ' + NumToStr(LRightY) + ' l S';
    finally
    end;
  end;

  function GetTextEffect: String;
  begin
    Result := '';
    with FCurrentTextObj.TextEffects do
    begin
      case TextRenderMode of
        trmFill:
          Result := Result + '0 Tr';
        trmStroke:
          Result := Result + '1 Tr';
        trmFillStroke:
          Result := Result + '2 Tr';
      end;
      case TextRise of
        trSuperscript:
          Result := Result + ' ' + NumToStr(FCurrentTextObj.Font.Size /
            2) + ' Ts';
        trSubscript:
          Result := Result + ' ' + NumToStr(-FCurrentTextObj.Font.Size /
            2) + ' Ts'
      end;
    end;
  end;

  function ShadeText: String;
  var
    LPath: String;
  begin
    Result := '';
    LPath := NumToStr(LSX2) + ' ' + NumToStr(LSY2) + ' m ' + NumToStr(LSX3) +
      ' ' + NumToStr(LSY3) + ' l ' + NumToStr(LSX4) + ' ' + NumToStr(LSY4) +
      ' l ' + NumToStr(LSX1) + ' ' + NumToStr(LSY1) + ' l ';

    with FCurrentTextObj do
      if (Brush.Style = bsSolid) then
        Result := CRLF + 'q' + CRLF + ColorToPDFColor(Brush.Color) + ' rg ' +
          LPath + ' f' + CRLF + 'Q'
      else if (Brush.Style <> bsClear) then
        (*
          Select color space - cs.
          Select color for non-stroking pattern - scn.
        *)
        Result := CRLF + 'q' + CRLF + '/CSP cs ' + ColorToPDFColor(Brush.Color)
          + ' /' + GetPattern(Brush.Style) + ' scn n ' + LPath + ' f' +
          CRLF + 'Q';
  end;

  function GetPDFCharSpacing(AText: AnsiString): Extended;
  var
    I: Integer;
  begin
    Result := 0;
    if AText = '' then
      Exit;
    for I := 1 to Length(AText) do
    begin
      if (Ord(AText[I]) >= Low(LPDFFont.FontInfo.FfiWidths)) then
        Result := Result + LPDFFont.FontInfo.FfiWidths[Ord(AText[I])];
    end;
    Result := Result * Abs(FCurrentTextObj.Font.Size) / 1000;
    Result := PixelsToPoints(LTextSize.cx) - Result;
    if Result = 0 then
      Exit;
    Result := Result / Length(AText);
  end;

  procedure Initialize;
  var
   LTxtDx, LTxtDy: Double;
   LTxtAlpha, LTxtDgl: Double;
   LFontHeight, LTxtY1: Double;
   LTxtX1: Double;
   LSW, LSH: Double;
   LSAlpha, LSDgl: Double;
  begin
    LTxtDx := 0;
    // LFontHeight is calculated from the PDF's FontBBox.Top property inorder to
    // get the accurate font height

    LFontHeight := ((PointsToPixels(LPDFFont.FontInfo.FfiFontBBox.Top) / 1000) *
      Abs(AFont.Size)) / (InputXRes / CPixelsPerInch);
    LTxtY1 := GetNativeYPos(FRunTextY + LFontHeight, CurrentPage);
    LTxtX1 := GetNativeXPos(FRunTextX);
    
    LTxtDy := GetNativeYPos(FRunTextY, CurrentPage) - LTxtY1;
    LTxtDgl := LTxtDy;
    LTxtAlpha := DegreesToRadians(AAngle);
    LTxtLeft := LTxtX1 + (LTxtDgl * Sin(LTxtAlpha));
    LTxtBottom := GetNativeYPos(FRunTextY, CurrentPage) -
      (LTxtDgl * Cos(LTxtAlpha));

    LSX1 := GetNativeXPos(FRunTextX);
    LSY1 := GetNativeYPos(FRunTextY, CurrentPage);
    LSW := LTextSize.cx * FPixelToPointMultiplier;
    LSH := LTextSize.cy * FPixelToPointMultiplier;
    LSX2 := LSX1 + LSH * LSinA;
    LSY2 := LSY1 - LSH * LCosA;
    LSX4 := LSX1 + LSW * LCosA;
    LSY4 := LSY1 + LSW * LSinA;
    if LSW = 0 then
      LSAlpha := DegreesToRadians(AAngle) - PI
    else
      LSAlpha := DegreesToRadians(AAngle) - ArcTan(LSH / LSW);
    LSDgl := Sqrt((LSH * LSH) + (LSW * LSW));
    LSX3 := LSX1 + LSDgl * Cos(LSAlpha);
    LSY3 := LSY1 + LSDgl * Sin(LSAlpha);
    if LTextWidth <> 0 then
    begin
     LSX3 := GetNativeXPos(FRunTextX + LTextWidth);
     LSX4 := GetNativeXPos(FRunTextX + LTextWidth);
    end; // if LTextWidth <> 0 then
  end;

  function GetTextClipRect: String;
  var
    LWd, LHt: Double;
  begin
    Result := '';
    with FCurrentTextObj do
    begin
      if (not IsClipRect) then
        Exit;
      LWd := ((ClipRect.Right - ClipRect.Left) * FPixelToPointMultiplier *
        (InputXRes / CPixelsPerInch));
      LHt := ((ClipRect.Bottom - ClipRect.Top) * FPixelToPointMultiplier *
        (InputYRes / CPixelsPerInch));
      Result := NumToStr(GetNativeXPos(ClipRect.Left)) + ' ' +
        NumToStr(GetNativeYPos(ClipRect.Bottom, CurrentPage)) + ' ' +
        NumToStr(LWd) + ' ' + NumToStr(LHt) + ' re W n' + CRLF;
    end;
  end;

  function GetTextWidth: Double;
  var
    J, LTextLength: Integer;
  begin
    Result := 0;
    // get char width from glyph information
    if ARunInfo.ScriptProcessingRequired then
    begin
      for J := 0 to AGlyphInfoList.Count - 1 do
        Result := Result + AGlyphInfoList[J].AdvWidth;
    end
    else
    begin
      for J := 0 to Length(AText) - 1 do
        Result := Result + PointsToPixels
          (LPDFFont.FontInfo.FfiWidths[Ord(AText[J + 1])]);
    end; // else
    Result := Result * Abs(FCurrentTextObj.Font.Size) / 1000;
    LTextLength := Length(FCurrentTextObj.Lines[0]) - 1;
    Result := ACharSpace * LTextLength + Result;
  end;

  function CalcMetafileCharSpacing: Double;
  var
    LI: Integer;
    LWidth: Double;
    LGlyphID: Integer;
    LCharWidth: Double;
    LCharSpace: Double;
  begin
    Result := 0;
    LCharSpace := 0;
    LCharWidth := 0;
    LGlyPos := 0;
    LPrev := 0;
    LStartPos := 0;
    LTempPos := 0;
    if (ARunInfo.StartPos > 0) then
      LStartPos := ARunInfo.StartPos;
    if LFontEncoding = feCID then
    begin
      SetLength(LTempCharSpace, AGlyphInfoList.Count);
      if (Abs(FCurrentTextObj.Font.Size) = 0) then
        Exit;
      // ALogClust: for each character in the input, the index of the first
      // glyph in pwOutGlyphs that was generated from it.

      // If it is ligature, then number of glyphs are lesser than the
      // characters. ALogClust will be having the mapped values. In the case of
      // ligature, multiple input characters will map to a single glyph ID.
      // Example: fi, ffi ==> single glyph
      // Using this information, calculating the char spacing values.
      for LI := 0 to Length(ALogClust) - 1 do
      begin
        // If the value of ALogClust[LI] is different from ALogClust[LI -1]
        // then, it is the start of a new glyph.
        if (ALogClust[LI] <> LPrev) or (LI = 0) then
        begin
          LPrev := ALogClust[LI];
          // Add prev char spacing to the LTempCharSpace array
          if (LI > 0) then
          begin
            Result := Result + LCharSpace;
            LCharSpace := (LCharWidth - LCharSpace);
            LTempCharSpace[LTempPos] := LCharSpace /
              Abs(FCurrentTextObj.Font.Size) * 1000;
            Inc(LTempPos);
          end;
          if (LGlyPos < AGlyphInfoList.Count) then
          begin
            LGlyphID := LPDFFont.FCID.IndexOf
              (Pointer(AGlyphInfoList.Items[LGlyPos].ID));
            LWidth := Integer(LPDFFont.FWidths[LGlyphID]);
            LWidth := PointsToPixels(LWidth);
            LCharWidth := (LWidth / 1000) * Abs(FCurrentTextObj.Font.Size);
          end;
          LCharSpace := FCurrentTextObj.FCharSpaceArray[LStartPos + LI];
          Inc(LGlyPos);
        end
        else
        begin
          if ((LI < Length(ARunInfo.VisAttr) - 1) and
            (svClusterStart in ARunInfo.VisAttr[ALogClust[LI] + 1])) or
            (LI = Length(ARunInfo.VisAttr) - 1) then
          begin
            // Ligatures
            LCharSpace := LCharSpace + FCurrentTextObj.FCharSpaceArray
              [LStartPos + LI];
          end
          else
          begin
            LCharSpace := LCharSpace + FCurrentTextObj.FCharSpaceArray
              [LStartPos + LI];
            if (LGlyPos < AGlyphInfoList.Count) then
            begin
              LGlyphID := LPDFFont.FCID.IndexOf
                (Pointer(AGlyphInfoList.Items[LGlyPos].ID));
              LWidth := Integer(LPDFFont.FWidths[LGlyphID]);
              LWidth := PointsToPixels(LWidth);
              LCharWidth := LCharWidth + (LWidth / 1000) *
                Abs(FCurrentTextObj.Font.Size);
            end;
            Inc(LGlyPos);
          end;
        end; // if
      end; // for
      // For the last character
      LWidth := Integer(LPDFFont.FWidths
        [LPDFFont.FCID.IndexOf(Pointer(AGlyphInfoList.Items[AGlyphInfoList.Count
        - 1].ID))]);
      LWidth := PointsToPixels(LWidth);
      LCharWidth := (LWidth / 1000) * Abs(FCurrentTextObj.Font.Size);
      Result := Result + LCharWidth;
      LStartPos := 0;
    end
    else
    begin
      LCharSpace := 0;
      SetLength(LTempCharSpace, Length(AText));
      if (FCurrentTextObj.Font.Size = 0) then
        Exit;
      for LI := 0 to Length(AText) - 1 do
      begin
        LCharSpace := FCurrentTextObj.FCharSpaceArray[LStartPos + LI];
        if (LPDFFont <> nil) then
        begin
          LCharVal := Ord(AText[LI + 1]);
          if (LPDFFont <> nil) and (LPDFFont.FWidths <> nil) and
            ((LCharVal >= 32) and (LCharVal <= 255)) then
          begin
            LCharWidth := PointsToPixels(LPDFFont.FontInfo.FfiWidths[LCharVal])
              * Abs(FCurrentTextObj.Font.Size) / 1000;
          end
          else
            LCharWidth := TextSize(AText[LI + 1], AFont).cx;
        end
        else
          LCharWidth := TextSize(AText[LI + 1], AFont).cx;
        Result := Result + LCharSpace;
        LCharSpace := (LCharWidth - LCharSpace);
        LTempCharSpace[LI] := LCharSpace /
          Abs(FCurrentTextObj.Font.Size) * 1000;;
      end;
    end;
  end;

  function lp_CalcLTextWidth: Double;
  begin
   Result := 0;
   LUseInterCharSpacing := False;
   if (TgtPDFFont(FFontTable.Items[LFontIdx]).FontInfo.FfiType = ftTrueType) then
    if Preferences.FApplyEmfCharSpacing and FCurrentTextObj.IsFromMetafile and
      (Length(FCurrentTextObj.FCharSpaceArray) >= AGlyphInfoList.Count)
    then
      LUseInterCharSpacing := True;

    // To calculate inter char spacing for Metafile. text width is also calculated
    // in the same method
    if LUseInterCharSpacing then
      Result := CalcMetafileCharSpacing
    else
      Result := GetTextWidth;   
  end;               

begin

  // with FCurrentTextObj do
  begin

    // About Vertical Fonts:
    // To display text vertically on Windows, enumerate the available fonts
    // as usual and select a font whose typeface name begins with the at (@)
    // character. Then create a LOGFONT structure, setting both the
    // escapement and the orientation to 270 degrees. Calls to TextOut are
    // the same as for horizontal text.

    LIsIdentityH := True;

    // CJK Range
    if (((Ord(AText[1]) >= CCJK_Unified_Ideographs_Start) and
      (Ord(AText[1]) <= CCJK_Unified_Ideographs_End)) and (AFont.Name[1] = '@')
      // is vertical
      ) then
    begin
      LIsIdentityH := False;
      AAngle := AAngle + 90;
    end;

    if ARunInfo.ScriptProcessingRequired then
      LFontEncoding := feCID
    else
      LFontEncoding := feWinAnsi;

    // Font already added to used fonts list? Then get the index of font in the list
    LFontIdx := -1;
    for LI := 0 to FFontTable.Count - 1 do
    begin
      if (TgtPDFFont(FFontTable.Items[LI]).IsEqual(AFont, LFontEncoding,
        LIsIdentityH)) then
      begin
        LFontIdx := LI;
        Break;
      end;
    end;

    // Else add it and get its index and the PDF font obj in the used fonts list
    if LFontIdx = -1 then
    begin
      LFontObjR := GetNewObjNo;
      if LFontEncoding = feCID then
        LPDFFont := TgtPDFFont.Create(AFont, LFontObjR, True,
          (Preferences.EmbedTrueTypeFonts = etfSubset) and
          (FontEmbedExcludeList.IndexOf(AFont.Name) = -1))
      else
      begin
        LPDFFont := TgtPDFFont.Create(AFont, LFontObjR, False,
          (Preferences.EmbedTrueTypeFonts = etfSubset) and
          (FontEmbedExcludeList.IndexOf(AFont.Name) = -1));
      end;
      LPDFFont.IsIdentityH := LIsIdentityH;

      LFontIdx := FFontTable.Add(LPDFFont);
    end
    else
      LPDFFont := TgtPDFFont(FFontTable.Items[LFontIdx]);
    // Store used GlyphIDs for each font
    if LFontEncoding = feCID then
      LPDFFont.AddUsedGlyphs(AText, AGlyphInfoList)
    else
      LPDFFont.AddUsedCharacters(AText);
    // ***
    LTextSize := TextSizeW(AText, AFont);

    (*
      Render the text at LRunTextX, LRunTextY; LRunTextY indicates the Baseline
      of the text.
      AFont.Size gives the whole text size including underline.
      To confirm this -
      Ex.: Draw Text (with underline) and a Line at (x, y) to a Bitmap and
      compare the results.
    *)

    LCosA := Cos(DegreesToRadians(AAngle));
    LSinA := Sin(DegreesToRadians(AAngle));

    LTextWidth := lp_CalcLTextWidth;

    Initialize;

    LS := CRLF + ShadeText + CRLF;
    LATemp := AnsiString(LS);
    if LATemp <> '' then
      FContentStream.Write(LATemp[1], Length(LATemp));
    LS := '';

    if (TgtPDFFont(FFontTable.Items[LFontIdx]).FontInfo.FfiType = ftTrueType) then
    begin
      // char space and word space
      if ARunIndex = 0 then
      begin
        LS := NumToStr(ACharSpace) + ' Tc' + CRLF + LS;
        LS := ' 0 Tw' + CRLF + LS;
      end;

      // Construct PDF content stream data for text part and commit it to the PDF
      if LFontEncoding = feCID then
      begin
        if LUseInterCharSpacing then
          LS := LS + '[' + GetTextAsPDFStringWithCharSpacing + ']' + ' TJ'
        else
          LS := LS + '<' + GetTextAsPDFString + '>' + ' Tj';
      end
      else
      begin
        if LUseInterCharSpacing then
          LS := LS + '[' + GetTextWithCharSpacing + ']' + ' TJ'
        else
          LS := LS + Format('(%s) Tj', [StringToEscapeString(AText)]);
      end;

      // Rotation for Uni+code text
      if (AAngle <> 0) and (AAngle <> 360) then
        LS := Format('%s %s %s %s %s %s Tm ', [NumToStr(LCosA), NumToStr(LSinA),
          NumToStr(-LSinA), NumToStr(LCosA), NumToStr(LTxtLeft),
          NumToStr(LTxtBottom)]) + CRLF + LS + CRLF + 'ET Q ' + CRLF
      else
        LS := NumToStr(LTxtLeft) + ' ' + NumToStr(LTxtBottom) + ' Td ' + LS +
          CRLF + 'ET Q ' + CRLF;

      LS := CRLF + ' q ' + GetTextClipRect + 'BT' + CRLF + GetTextEffect + CRLF
        + ColorToPDFColor(AFont.Color) + ' rg' + CRLF +
        Format('/F%d %d Tf', [LFontIdx, Abs(AFont.Size)]) + CRLF + LS;
      LATemp := AnsiString(LS);
      FContentStream.Write(LATemp[1], Length(LS));
    end;

    // Set starting point for the next text run

    // for a circle with origin (j, k) and radius r[r=width]:
    // x(t) = j + r cos(t)        y(t) = k - r sin(t)

    FRunTextX := FRunTextX + ((LTextWidth * (CPixelsPerInch / InputXRes))) *
      Cos(AAngle * PI / 180.0);
    FRunTextY := FRunTextY - (LTextWidth * (CPixelsPerInch / InputXRes)) *
      Sin(AAngle * PI / 180.0);

    // If last text run,
    // apply text decoration and perform text hyper linking to whole string at once
    // if ARunIndex = ARunCount - 1 then
    begin
      // Get width of full text string this time
      LTextSize := TextSizeW(FCurrentTextObj.Lines[0], FCurrentTextObj.Font);

      // Underline and strikeout - PDF does not have any font property for this.
      // we need to draw it ourselves.
      LS := '';
      if fsUnderline in AFont.Style then
        LS := LS + CRLF + 'q' + CRLF + ColorToPDFColor(AFont.Color) + ' RG ' +
          EncodeTextDecor(ltUnderline, LPDFFont) + CRLF + 'Q';
      if fsStrikeOut in AFont.Style then
        LS := LS + CRLF + 'q' + CRLF + ColorToPDFColor(AFont.Color) + ' RG ' +
          EncodeTextDecor(ltStrikeOut, LPDFFont) + CRLF + 'Q';
      if (LS <> '') then
      begin
        LS := LS + CRLF;
        LATemp := AnsiString(LS);
        FContentStream.Write(LATemp[1], Length(LS));
      end;

      // Automatic conversion of http, ftp, email references in text to
      // clickable hyperlinks.
      // Parse string and when supported link pattern is found, make that text
      // a hyperlink through use of link annotation.

      if Preferences.ActiveHyperLinks and (AAngle mod 360 = 0) then
      begin
        LParseEncodeText :=
          String(RemoveTerminalCRLF(AnsiString(FCurrentTextObj.Lines[0])));
        LStartPt := LSX1;
        LEndPt := LSX1;
        while (LParseEncodeText <> '') do
        begin
          LLinkText := GetHyperLinkText(LParseEncodeText, LStartPos);
          if LLinkText <> '' then
          begin
            LLinkObjNo := GetNewObjNo;
            // Add the link annotation object no. to String
            FAnnots := FAnnots + ' ' + MakeObjRef(LLinkObjNo);

            LTextSize := TextSizeW(System.Copy(LParseEncodeText, 0,
              LStartPos - 1), FCurrentTextObj.Font);

            LStartPt := LStartPt + (LTextSize.cx * FPixelToPointMultiplier);
            LEndPt := LEndPt + (LTextSize.cx * FPixelToPointMultiplier) +
              (TextSizeW(Trim(LLinkText), FCurrentTextObj.Font).cx *
              FPixelToPointMultiplier);

            LS := '/Type/Annot' + '/Border [0 0 0]' + '/H/I' + '/Subtype/Link' +
              '/F 0' + '/C [00 00 00]' + '/Rect [' + NumToStr(LStartPt) + ' ' +
              NumToStr(GetNativeYPos(FRunTextY, CurrentPage)) + ' ' +
              NumToStr(LEndPt) + ' ' + NumToStr(LSY3) + ']' + CRLF + '/A' + CRLF
              + '<<' + CRLF;
            if (AnsiPos('@', LLinkText) <> 0) then
              LS := LS + '/S/URI /URI<' +
                String(GetHexOfStr(AnsiString(WritePDFString(Trim('mailto:' +
                LLinkText), LLinkObjNo, 0)))) + '>' + CRLF
            else if (AnsiPos(':\', LLinkText) <> 0) then
            begin
              TempStr := StringReplace(LLinkText, ':\', '/', [rfIgnoreCase]);
              TempStr := StringReplace(TempStr, '\', '/', [rfReplaceAll]);
              if (AnsiPos('/', TempStr) <> 0) and
                (AnsiPos('..', TempStr) = 0) then
                TempStr := '/' + TempStr;
              LS := LS + '/Type /Action/S /Launch/F (' + TempStr +
                ') /NewWindow true';
            end
            else
              LS := LS + '/S/URI /URI<' +
                String(GetHexOfStr(AnsiString(WritePDFString(Trim(LLinkText),
                LLinkObjNo, 0)))) + '>' + CRLF;
            LS := LS + '>>';

            WriteObj(LS, LLinkObjNo, True);
          end;
          if LLinkText <> '' then
          begin
            LStartPt := LEndPt;
            LParseEncodeText := System.Copy(LParseEncodeText,
              LStartPos + Length(LLinkText),
              (Length(LParseEncodeText) - (LStartPos + Length(LLinkText) - 1)));
            LStartPos := 0;
            LLinkText := '';
          end
          else
            Break;
        end;
      end;
    end;
  end;
end;

// procedure TgtCustomPDFEngine.EncodeTransformationItem
// (AObject: TgtTransformationItem);
// var
// LS: String;
// LATemp: AnsiString;
// begin
// inherited;
// LS :=CRLF+ 'q ' + NumToStr(AObject.Transformation.eM11) +' ' +
// NumToStr(AObject.Transformation.eM12) +' ' +
// NumToStr(AObject.Transformation.eM21) +' ' +
// NumToStr(AObject.Transformation.eM22) +' ' + NumToStr(AObject.Transformation.eDx)
// + ' ' +NumToStr(AObject.Transformation.eDy) + ' cm' + CRLF;
// if (LS <> '') then
// begin
// LATemp := AnsiString(LS);
// FContentStream.Write(LATemp[1], Length(LS));
// end;
// end;

{ TgtPDFImageSettings }

constructor TgtPDFImageSettings.Create;
begin
  inherited;
  FObjNo := 0;
end;

destructor TgtPDFImageSettings.Destroy;
begin
  inherited;
end;

function TgtPDFImageSettings.IsEqual(AObject: TgtImageItem;
  AOriginalWidth, AOriginalHeight: Integer): boolean;
begin
  Result := False;
  with AObject do
  begin
    (* Image settings are different. *)
    if OutputImageFormat = Settings.OutputImageFormat then
    begin
      if (OutputImageFormat = ifJPEG) and
        (JPEGQuality <> Settings.JPEGQuality) then
        Exit;
    end
    else
      Exit;
    if ImagePixelFormat <> Settings.ImagePixelFormat then
      Exit;
    if SourceDPI <> Settings.SourceDPI then
      Exit;
    if AutoSize <> Settings.AutoSize then
      Exit;
    (*
      Stretch will include the original image.
      Hence if one is Stretch and other is Center/AutoSize/OriginalImage.
    *)
    if Stretch <> Settings.Stretch then
    begin
      (*
        If existing image is stretched, then check the dimensions of the
        current image to check if the current width and height is equal to
        original image width and height respectively.
      *)
      if Stretch then
      begin
        if (Width = AOriginalWidth) or (Height = AOriginalHeight) then
          Result := True;
        Exit;
      end
      else
      (*
        If current image is stretched, then check the dimensions of the
        existing image to check if the existing width and height is equal to
        original image width and height respectively.
      *)
      begin
        if (ImageWidth = AOriginalWidth) or (ImageHeight = AOriginalHeight) then
          Result := True;
        Exit;
      end;
    end
    else if (Stretch) and (Settings.Stretch) then
    begin
      Result := True;
      Exit;
    end;
    if Center <> Settings.Center then
    begin
      (*
        If either existing/current image is centered, then
        if width & height of both images is equal to original image, reuse.
      *)

      if (ImageWidth <> Width) or (ImageHeight <> Height) or
        (ImageWidth <> AOriginalWidth) or (ImageHeight <> AOriginalHeight) then
        Exit;
    end
    else if (Center) and (Settings.Center) then
    begin
      (*
        If both current & existing images are centered.
      *)
      (*
        If existing image is the original image AND
        if current image width and height is equal to original image width and
        height, then reuse.
      *)
      if (ImageWidth = AOriginalWidth) and (ImageHeight = AOriginalHeight) then
      begin
        if (Width < AOriginalWidth) or (Height < AOriginalHeight) then
          Exit;
      end
      else
      (*
        If existing image is not the original image, i.e., the existing image
        is clipped, then compare the clipped rectangle (display rectangle) to
        determine whether both the clipped images are the same.
      *)
      begin
        if (ImageWidth <> Width) or (ImageHeight <> Height) then
          Exit;
      end;
    end;
    (* All settings are false. *)
    if (ImageWidth <> Width) or (ImageHeight <> Height) then
      Exit;

    Result := True;
  end;
end;

procedure TgtPDFImageSettings.SetDisplayHeight(const Value: Double);
begin
  FDisplayHeight := Value;
end;

procedure TgtPDFImageSettings.SetDisplayWidth(const Value: Double);
begin
  FDisplayWidth := Value;
end;

procedure TgtPDFImageSettings.SetImageHeight(const Value: Double);
begin
  FImageHeight := Value;
end;

procedure TgtPDFImageSettings.SetImageWidth(const Value: Double);
begin
  FImageWidth := Value;
end;

procedure TgtPDFImageSettings.SetObjNo(const Value: Integer);
begin
  FObjNo := Value;
end;

{ TgtPageInfo }

procedure TgtPageInfo.SetHeight(const Value: Double);
begin
  FHeight := Value;
end;

procedure TgtPageInfo.SetObjNo(const Value: Integer);
begin
  FObjNo := Value;
end;

procedure TgtPageInfo.SetWidth(const Value: Double);
begin
  FWidth := Value;
end;

{ TgtCompression }

constructor TgtCompression.Create;
begin
  FEnabled := True;
  FLevel := clMaxCompress;
end;

destructor TgtCompression.Destroy;
begin

  inherited;
end;

procedure TgtCompression.SetEnabled(const Value: boolean);
begin
  FEnabled := Value;
end;

procedure TgtCompression.SetLevel(const Value: TgtCompressionLevel);
begin
  FLevel := Value;
end;

{ TgtPDFPreferences }

constructor TgtPDFPreferences.Create;
begin
  inherited;
  FEmbedTrueTypeFonts := etfNone;
  FApplyEmfCharSpacing := True;
end;

destructor TgtPDFPreferences.Destroy;
begin

  inherited;
end;

procedure TgtPDFPreferences.SetApplyEmfCharSpacing(const Value: boolean);
begin
  FApplyEmfCharSpacing := Value;
end;

procedure TgtPDFPreferences.SetEmbedTrueTypeFonts
  (const Value: TgtTTFontEmbedding);
begin
  FEmbedTrueTypeFonts := Value;
end;

{ TgtPresentationMode }

constructor TgtPresentationMode.Create;
begin
  FDuration := 1;
  FTransitionEffect := teNone;
end;

destructor TgtPresentationMode.Destroy;
begin
  inherited;
end;

constructor TgtViewerPreferences.Create;
begin
  FPageLayout := plOneColumn;
  FPageMode := pmUseNone;
  FHideToolBar := False;
  FHideMenuBar := False;
  FHideWindowUI := False;
  FFitWindow := False;
  FCenterWindow := False;
  FNonFullScreenPageMode := nfspmUseNone;
  FPresentationMode := TgtPresentationMode.Create;
end;

destructor TgtViewerPreferences.Destroy;
begin
  FreeAndNil(FPresentationMode);
  inherited;
end;

function TgtViewerPreferences.GetTransitionEffectAndDuration(ADuration: Integer;
  ATransitionEffect: TgtTransitionEffect): String;
begin
  Result := '';
  Result := '/Dur ' + IntToStr(ADuration);
  Result := Result + '/Trans <<';
  Result := Result + '/Type/Trans' + '/D ' + IntToStr(ADuration) + '/S';
  case ATransitionEffect of
    teSplitHorizontalInward:
      Result := Result + '/Split' + '/Dm/H' + '/M/I';
    teSplitHorizontalOutward:
      Result := Result + '/Split' + '/Dm/H' + '/M/O';
    teSplitVerticalInward:
      Result := Result + '/Split' + '/Dm/V' + '/M/I';
    teSplitVerticalOutward:
      Result := Result + '/Split' + '/Dm/V' + '/M/O';
    teBlindsHorizontal:
      Result := Result + '/Blinds' + '/Dm/H';
    teBlindsVertical:
      Result := Result + '/Blinds' + '/Dm/V';
    teBoxInward:
      Result := Result + '/Box' + '/M/I';
    teBoxOutward:
      Result := Result + '/Box' + '/M/O';
    teWipeLeftToRight:
      Result := Result + '/Wipe' + '/Di 0';
    teWipeRightToLeft:
      Result := Result + '/Wipe' + '/Di 180';
    teWipeBottomToTop:
      Result := Result + '/Wipe' + '/Di 90';
    teWipeTopToBottom:
      Result := Result + '/Wipe' + '/Di 270';
    teDissolve:
      Result := Result + '/Dissolve';
    teGlitterLeftToRight:
      Result := Result + '/Glitter' + '/Di 0';
    teGlitterTopToBottom:
      Result := Result + '/Glitter' + '/Di 270';
    teGlitterTopLeftToBottomRight:
      Result := Result + '/Glitter' + '/Di 315';
  else
    Result := Result + '/R';
  end;
  Result := Result + ' >>';
end;

function TgtViewerPreferences.GetViewerPreferences(APageMode: TgtPageMode;
  APageLayout: TgtPageLayout; ACenterWindow, AFitWindow, AHideWindowUI,
  AHideMenuBar, AHideToolBar: boolean;
  ANonFullScreenPageMode: TgtNonFullScreenPageMode): String;
begin
  Result := '';
  Result := '/PageMode';
  case APageMode of
    pmUseOutlines:
      Result := Result + '/UseOutlines';
    pmUseThumbs:
      Result := Result + '/UseThumbs';
    pmFullScreen:
      Result := Result + '/FullScreen';
  else
    Result := Result + '/UseNone';
  end;
  Result := Result + '/PageLayout';
  case PageLayout of
    plSinglePage:
      Result := Result + '/SinglePage';
    plTwoColumnLeft:
      Result := Result + '/TwoColumnLeft';
    plTwoColumnRight:
      Result := Result + '/TwoColumnRight';
  else
    Result := Result + '/OneColumn';
  end;
  Result := Result + '/ViewerPreferences <<';
  if ACenterWindow then
    Result := Result + '/CenterWindow true';
  if AFitWindow then
    Result := Result + '/FitWindow true';
  if AHideWindowUI then
    Result := Result + '/HideWindowUI true';
  if AHideMenuBar then
    Result := Result + '/HideMenubar true';
  if AHideToolBar then
    Result := Result + '/HideToolbar true';
  if (APageMode = pmFullScreen) then
  begin
    Result := Result + '/NonFullScreenPageMode';
    case ANonFullScreenPageMode of
      nfspmUseOutlines:
        Result := Result + '/UseOutlines';
      nfspmUseThumbs:
        Result := Result + '/UseThumbs';
    else
      Result := Result + '/UseNone';
    end;
  end;
  Result := Result + ' >>';
end;

procedure TgtViewerPreferences.SetCenterWindow(const Value: boolean);
begin
  FCenterWindow := Value;
end;

procedure TgtViewerPreferences.SetFitWindow(const Value: boolean);
begin
  FFitWindow := Value;
end;

procedure TgtViewerPreferences.SetHideMenuBar(const Value: boolean);
begin
  FHideMenuBar := Value;
end;

procedure TgtViewerPreferences.SetHideToolBar(const Value: boolean);
begin
  FHideToolBar := Value;
end;

procedure TgtViewerPreferences.SetHideWindowUI(const Value: boolean);
begin
  FHideWindowUI := Value;
end;

procedure TgtViewerPreferences.SetNonFullScreenPageMode
  (const Value: TgtNonFullScreenPageMode);
begin
  FNonFullScreenPageMode := Value;
end;

procedure TgtViewerPreferences.SetPageLayout(const Value: TgtPageLayout);
begin
  FPageLayout := Value;
end;

procedure TgtViewerPreferences.SetPageMode(const Value: TgtPageMode);
begin
  FPageMode := Value;
end;

procedure TgtViewerPreferences.SetPresentationMode(AValue: TgtPresentationMode);
begin
  FPresentationMode := AValue;
end;

{ TgtPDFThumbnailItem }

constructor TgtPDFThumbnailItem.Create;
begin
  inherited;
  FObjNo := 0;
  FIndexNo := -1;
  FOutputImageFormat := ifBMP;
  FImagePixelFormat := pf24Bit;
  FJPEGQuality := 100;
end;

destructor TgtPDFThumbnailItem.Destroy;
begin
  inherited;
end;

function TgtPDFThumbnailItem.IsEqual(AThumbnail: TgtPDFThumbnailItem): boolean;
begin
  Result := True;

  if (ImagePixelFormat <> AThumbnail.ImagePixelFormat) or
    (OutputImageFormat <> AThumbnail.OutputImageFormat) then
    Result := False;
  if (OutputImageFormat = AThumbnail.OutputImageFormat) and
    (OutputImageFormat = ifJPEG) and
    (JPEGQuality <> AThumbnail.JPEGQuality) then
    Result := False;
end;

procedure TgtPDFThumbnailItem.SetImagePixelFormat(const Value: TPixelFormat);
begin
  FImagePixelFormat := Value;
end;

procedure TgtPDFThumbnailItem.SetIndexNo(const Value: Integer);
begin
  FIndexNo := Value;
end;

procedure TgtPDFThumbnailItem.SetJPEGQuality(const Value: Integer);
begin
  FJPEGQuality := Value;
end;

procedure TgtPDFThumbnailItem.SetObjNo(const Value: Integer);
begin
  FObjNo := Value;
end;

procedure TgtPDFThumbnailItem.SetOutputImageFormat
  (const Value: TgtOutputImageFormat);
begin
  FOutputImageFormat := Value;
end;

{ TgtRunStore }

constructor TgtRunStore.Create;
begin
  FGlyphInfoList := TgtGlyphInfoList.Create;
  FFont := TFont.Create;
end;

destructor TgtRunStore.Destroy;
begin
  if Assigned(FGlyphInfoList) then
    FreeAndNil(FGlyphInfoList);

  if Assigned(FFont) then
    FreeAndNil(FFont);
end;

procedure TgtRunStore.SetAngle(const Value: Integer);
begin
  FAngle := Value;
end;

procedure TgtRunStore.SetLogClust(const Value: TgtWordArray);
begin
  FLogClust := Value;
end;

procedure TgtRunStore.SetGlyphInfoList(const Value: TgtGlyphInfoList);
begin
  FGlyphInfoList := Value;
end;

procedure TgtRunStore.SetFont(const Value: TFont);
begin
  FFont := Value;
end;

procedure TgtRunStore.SetRunInfo(const Value: TgtRunInfo);
begin
  FRunInfo := Value;
end;

procedure TgtRunStore.SetRunText(const Value: WideString);
begin
  FRunText := Value;
end;

{ TgtSignature }

constructor TgtSignature.Create;
begin
  FFilter := PDF_DOC_ADOBEHANDLER;
  FSubFilter := 'adbe.pkcs7.sha1';
  FCirtificationLevel := clFillFormFields;
  FSigFieldAppearenceOptions := [sfaoshowName, sfaoshowReason, sfaoshowLocation,
    sfaoshowDate, sfaoshowLabels];
  FAuther := '';
  FReason := '';
  FLocation := '';
  FContactInfo := '';
  DateTime := Now;
end;

{ TgtDigitalSignature }

constructor TgtDigitalSignature.Create;
begin
  Enabled := False;
  FSignatureProperties := TgtSignature.Create;
  FFieldProperties := TgtFieldProperties.Create;
end;

destructor TgtDigitalSignature.Destroy;
begin
  FFieldProperties.Free;
  FSignatureProperties.Free;
  inherited;
end;

{ TgtFieldProperties }

constructor TgtFieldProperties.Create;
begin
  FieldName := '';
  Visible := True;
  FillColor := clWhite;
  Font := TFont.Create;
  FieldAppearenceOptions := [sfaoshowName, sfaoshowReason, sfaoshowLocation,
    sfaoshowDate, sfaoshowLabels];
  PageNumber := 1;
  FFieldBounds := TgtSigFieldBounds.Create;

end;

destructor TgtFieldProperties.Destroy;
begin
  FFieldBounds.Free;
  Font.Free;
  inherited;
end;

function TgtFieldProperties.ReadFieldBounds: TgtSigFieldBounds;
begin
  Result := FFieldBounds;
  { Result := TgtSigFieldBounds.create;
    Result.FLLeft := FFieldBounds.FLLeft;
    Result.FLTop := FFieldBounds.FLTop;
    Result.FLRight := FFieldBounds.FLRight;
    Result.FFLBotom := FFieldBounds.FLBotom; }
end;

procedure TgtFieldProperties.WriteFieldBounds(AFieldBounds: TgtSigFieldBounds);
begin
  FFieldBounds.FLLeft := AFieldBounds.FLLeft;
  FFieldBounds.FLTop := AFieldBounds.FLTop;
  FFieldBounds.FLRight := AFieldBounds.FLRight;
  FFieldBounds.FLBotom := AFieldBounds.FLBotom;
end;

{ TgtSigFieldBounds }

constructor TgtSigFieldBounds.Create;
begin
  inherited;
  FLLeft := 0;
  FLTop := 0;
  FLRight := 0;
  FLBotom := 0;
end;

end.
