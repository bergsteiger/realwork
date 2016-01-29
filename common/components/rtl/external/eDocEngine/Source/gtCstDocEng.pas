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
{$DEFINE eDocEngine30}
unit gtCstDocEng;

interface

uses
  Classes, Windows, Graphics, Math, Dialogs, Forms, SysUtils, Controls,
  StdCtrls,
  ShellAPI, jpeg, gtClasses3, gtUtils3, gtConsts3, gtFilters3, gtDocConsts,
  gtDocResStrs {$IFDEF WIN32}, gtdzlib3 {$ENDIF} {$IFDEF WIN64},
  System.ZLib {$ENDIF},
  Printers, ComCtrls, RichEdit
{$IFDEF gtFileMaker}
    , gtEngineStatus
{$ENDIF}
{$IFDEF JediRichEdit}
    , JvExStdCtrls, JvRichEdit
{$ENDIF}
{$IFDEF RichEdit98}
    , RichEdit2
{$ENDIF}
{$IFDEF GIFByJEDI}
    , JvGIF
{$ELSE}
{$IFDEF GIFByRx}
    , RxGIF
{$ELSE}
{$IFDEF GIFByAM}
    , GIFImage
{$ELSE}
{$IFDEF GIFIMG}
    , GIFImg
{$ENDIF}
{$ENDIF}
{$ENDIF}
{$ENDIF}
{$IFDEF PNGDelphi}
    , PngImage
{$ENDIF}
{$IFDEF EMailWithFastNet}
    , Psock, NMsmtp
{$ENDIF}
    ;
// {$IFDEF EMailWithIndy}
// , IdComponent;
// {$IFDEF Indy1000Up}
// , IdAttachmentfile
// {$ENDIF}
// {$ENDIF};

type

  { Enumeration Types }

  TgtUnitType = (muPixels, muInches, muMM, muPoints, muTwips);

  TgtBandType = (btContent, btHeader, btFooter, btWatermark, btStamp);

  TgtShapeType = (stLine, stRectangle, stRoundRect, stEllipse, stPolygon,
    stPolyLine, stArc, stChord, stPie, stPolyBezier, stRectangleRgn);

  TgtPenJoinStyle = (pjsNone, pjsBevel, pjsMiter, pjsRound);

  TgtPenCapStyle = (pcsNone, pcsRound, pcsSquare, pcsFlat);

  TgtPathOperation = (poBeginPath, poEndPath, poCloseFigure, poAbortPath,
    poFillPath, poStrokeAndFillPath, poStrokePath, poSelectClipPath);

  TgtHAlignment = (haLeft, haRight, haCenter, haJustify, haGeneral);

  TgtVAlignment = (vaTop, vaCenter, vaBottom);

  TgtOutputImageFormat = (ifBMP, ifJPEG, ifGIF, ifPNG, ifMetafile
{$IFDEF gtPro}, ifCCITT3, ifCCITT4 {$ENDIF});

  TgtItemsToRenderKind = (irText, irImage, irShape);

  TgtItemsToRender = set of TgtItemsToRenderKind;

  TgtCapabilityKind = (ckText, ckImage, ckShape, ckHeader, ckFooter,
    ckWatermark, ckStamp, ckImageStretch, ckImageFrame, ckInputRes,
    ckImageReusable);

  TgtCapabilities = set of TgtCapabilityKind;

  TgtBackgroundDisplayType = (dtTile, dtTopLeft, dtTopCenter, dtTopRight,
    dtCenterLeft, dtCenter, dtCenterRight, dtBottomLeft, dtBottomCenter,
    dtBottomRight);

  TgtPaperSize = (Letter, LetterSmall, Tabloid, Ledger, Legal, Statement,
    Executive, A3, A4, A4Small, A5, B4, B5, Folio, Quarto, ps10X14, ps11X17,
    Note, Env10, Env11, Env12, Env14, CSheet, DSheet, ESheet, EnvDL, EnvC5,
    EnvC3, EnvC4, EnvC6, EnvC65, EnvB4, EnvB5, EnvB6, EnvItaly, EnvMonarch,
    EnvPersonal, FanfoldUS, FanfoldStdGerman, ISOB4, Custom);

  TgtEngineStatus = (esNone, esStarted, esFinished, esCancelled, esError);

  TgtReferencePoint = (rpPage, rpMargin, rpBand);

  TgtTextRenderMode = (trmFill, trmStroke, trmFillStroke);

  TgtTextRise = (trNormal, trSuperscript, trSubscript);

  { TgtPoint }
  TgtPoint = record
    X, Y: Double;
  end;

  TgtPoints = array of TgtPoint;

const
  { All dimension of Papers are mentioned in Inches }
  CPaperDimensions: array [TgtPaperSize, 0 .. 1] of Double = ((8.5, 11),
    (8.5, 11), (11, 17), (17, 11), (8.5, 14), (5.5, 8.5), (7.25, 10.5),
    (11.6929, 16.5354), (8.2677, 11.6929), (8.2677, 11.6929), (5.8267, 8.2677),
    (9.8425, 13.8976), (6.9291, 9.8425), (8.5, 13), (8.4645, 10.8267), (10, 14),
    (10, 17), (8.5, 11), (4.125, 9.5), (4.5, 10.375), (4.75, 11), (5, 11.5),
    (17, 22), (22, 34), (34, 44), (4.3307, 8.6614), (6.3779, 9.0157),
    (12.7559, 18.0314), (9.1057, 12.7559), (4.4881, 6.3779), (4.4881, 9.0157),
    (9.8425, 13.8976), (6.9291, 9.8425), (6.9291, 4.9212), (4.3307, 9.0551),
    (3.875, 7.5), (3.625, 6.5), (14.875, 11), (8.5, 12),
    (9.8425, 13.8976), (0, 0));

  { ---- Place Holder Constants ------------------------------------------------- }
  CphPageNo = '<%Pg#%>';
  CphTotalPages = '<%PgCnt%>';
  CphShortDate = '<%ShortDate%>';
  CphShortTime = '<%ShortTime%>';
  CphLongDate = '<%LongDate%>';
  CphLongTime = '<%LongTime%>';
  CphAuthor = '<%Author%>';
  CphCreator = '<%Creator%>';
  CphSubject = '<%Subject%>';
  CphTitle = '<%Title%>';

  { ---- Measurement Unit Names ------------------------------------------------- }
  CUnitNames: array [TgtUnitType] of string = (SUnitTypePixels, SUnitTypeInches,
    SUnitTypeMM, SUnitTypePoints, SUnitTypeTwips);

type
  { Forword decleration }
  TgtBaseDlg = class;
  TgtCustomDocumentEngine = class;
  TgtFrame = class;
  TgtEmailSettings = class;
  TgtDocSettings = class;

  { Events }

  TgtNotifyEvent = procedure(Sender: TgtCustomDocumentEngine) of object;

  TgtOnNeedFileNameEvent = procedure(Sender: TgtCustomDocumentEngine;
    var FileName: String; PageNo: Integer) of object;

  TgtEmailEvent = procedure(Sender: TgtCustomDocumentEngine;
    EMailSettings: TgtEmailSettings; var Continue, CancelEMail: Boolean)
    of object;

  TgtEmailErrorEvent = procedure(Sender: TgtCustomDocumentEngine;
    const ErrMsg: String) of object;

  TgtErrorMessageEvent = procedure(Sender: TgtCustomDocumentEngine;
    const AException: Exception) of object;
{$IFDEF gtActiveX}
  TgtOnCellDrawEvent = procedure(Sender: TgtCustomDocumentEngine;
    Row, Column: Integer; Pen: TPen; Brush: TBrush; Font: TFont;
    Frame: TgtFrame) of object;

  TgtOnCellDrawExEvent = procedure(Sender: TgtCustomDocumentEngine;
    Row, Column: Integer; Pen: TPen; Brush: TBrush; Font: TFont;
    Frame: TgtFrame; var Align: TgtHAlignment) of object;
{$ELSE}
  TgtOnCellDrawEvent = procedure(Sender: TgtCustomDocumentEngine;
    Row, Column: Integer; Pen: TPen; Brush: TBrush; Font: TFont;
    Frame: TgtFrame; var Align: TgtHAlignment) of object;
{$ENDIF}
  TgtOnCalcVariablesEvent = procedure(Sender: TgtCustomDocumentEngine;
    Variable: String; var Value: String) of object;

  TgtOnChangeValue = procedure(var Value: Double) of object;

  TgtEmailAdapter = class(TgtBaseComponent)
  Private
    FEmailSettings: TgtEmailSettings;
    FOnEmailConnected: TNotifyEvent;
    FOnEmailDisConnected: TNotifyEvent;
    // FOnEmailStatus: TNotifyEvent;
    FOnEmailSuccess: TNotifyEvent;
    function GetEMailSettings: TgtEmailSettings;
    procedure SetEMailSettings(const Value: TgtEmailSettings);
  published
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property EMailSettings: TgtEmailSettings read GetEMailSettings
      write SetEMailSettings;

    property OnEmailConnected: TNotifyEvent read FOnEmailConnected
      write FOnEmailConnected;
    property OnEmailDisConnected: TNotifyEvent read FOnEmailDisConnected
      write FOnEmailDisConnected;
    // property OnEmailStatus: TNotifyEvent read FOnEmailStatus
    // write FOnEmailStatus;
    property OnEmailSuccess: TNotifyEvent read FOnEmailSuccess
      write FOnEmailSuccess;
  protected
    procedure SendMail; virtual;
  end;

  TgtTextEffects = class(TPersistent)
  private
    FTextRenderMode: TgtTextRenderMode;
    FTextRise: TgtTextRise;
    procedure SetTextRenderMode(const Value: TgtTextRenderMode);
    procedure SetTextRise(const Value: TgtTextRise);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property TextRenderMode: TgtTextRenderMode read FTextRenderMode
      write SetTextRenderMode default trmFill;
    property TextRise: TgtTextRise read FTextRise write SetTextRise
      default trNormal;
  end;

  { TgtDocumentItem }

  { Base class for all document items }
  TgtDocumentItem = class(TObject);

  { TgtTextItem }

  TgtTextItem = class(TgtDocumentItem)
  private
    FX, FY: Double;
    FLines: TWideStrings;
    FRotationAngle: Integer;
    FFont: TFont;
    FBrush: TBrush;
    FTextEffects: TgtTextEffects;
    FIsClipRect: Boolean;
    FClipRect: TgtRect;
    FAlignment: TgtHAlignment;
    FIsFromMetafile: Boolean;
    FIsWideString: Boolean;
    FBiDiMode: TBiDiMode;

    procedure SetRotationAngle(Value: Integer);
    procedure SetFont(Value: TFont);
    procedure SetBrush(Value: TBrush);
    procedure SetTextEffects(const Value: TgtTextEffects);
    procedure SetClipRect(const Value: TgtRect);
    procedure SetIsClipRect(const Value: Boolean);
    procedure SetAlignment(const Value: TgtHAlignment);

  public
    FCharSpaceArray: array of Double;
    constructor Create; virtual;
    destructor Destroy; override;

    property X: Double read FX write FX;
    property Y: Double read FY write FY;
    property Lines: TWideStrings read FLines write FLines;
    property RotationAngle: Integer read FRotationAngle write SetRotationAngle;
    property Font: TFont read FFont write SetFont;
    property Brush: TBrush read FBrush write SetBrush;
    property TextEffects: TgtTextEffects read FTextEffects write SetTextEffects;
    property IsClipRect: Boolean read FIsClipRect write SetIsClipRect
      default False;
    property ClipRect: TgtRect read FClipRect write SetClipRect;
    property Alignment: TgtHAlignment read FAlignment write SetAlignment
      default haLeft;
    property IsFromMetafile: Boolean read FIsFromMetafile write FIsFromMetafile
      default False;
    property IsWideString: Boolean read FIsWideString write FIsWideString
      default False;
    property BiDiMode: TBiDiMode read FBiDiMode write FBiDiMode
      default bdLeftToRight;
  end;

  { TgtTextBoxItem }

  TgtTextBoxItem = class(TgtTextItem)
  private
    FBoxWidth: Double;
    FBoxHeight: Double;
    FFrame: TgtFrame;
    FHAlign: TgtHAlignment;
    FVAlign: TgtVAlignment;
    FPen: TPen;

    procedure SetPen(Value: TPen);
    procedure SetFrame(const Value: TgtFrame);

  public
    constructor Create; override;
    destructor Destroy; override;

    property BoxWidth: Double read FBoxWidth write FBoxWidth;
    property Boxheight: Double read FBoxHeight write FBoxHeight;
    property Pen: TPen read FPen write SetPen;
    property Frame: TgtFrame read FFrame write SetFrame;
    property HAlign: TgtHAlignment read FHAlign write FHAlign;
    property VAlign: TgtVAlignment read FVAlign write FVAlign;
  end;

  { TgtImageSettings }

  TgtImageSettings = class(TPersistent)
  private
    FParent: TObject;
    FCenter: Boolean;
    FAutosize: Boolean;
    FStretch: Boolean;
    FTransparent: Boolean;
    FKeepAspectRatio: Boolean;
    FInclination: Integer;
    FIsFrame: Boolean;
    FOutputImageFormat: TgtOutputImageFormat;
    FImagePixelFormat: TPixelFormat;
    FJPEGQuality: TJPEGQualityRange;
    FSourceDPI: Integer;

    procedure SetOutputImageFormat(const Value: TgtOutputImageFormat);
    procedure SetSourceDPI(const Value: Integer);

  public
    constructor Create(AParent: TObject); overload;
    constructor Create; overload; virtual;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;

    property Center: Boolean read FCenter write FCenter;
    property Stretch: Boolean read FStretch write FStretch;
    property AutoSize: Boolean read FAutosize write FAutosize;
    property Transparent: Boolean read FTransparent write FTransparent;
    property KeepAspectRatio: Boolean read FKeepAspectRatio
      write FKeepAspectRatio;
    property Inclination: Integer read FInclination write FInclination;
    property IsFrame: Boolean read FIsFrame write FIsFrame;

  published
    property SourceDPI: Integer read FSourceDPI write SetSourceDPI;
    property OutputImageFormat: TgtOutputImageFormat read FOutputImageFormat
      write SetOutputImageFormat;
    property ImagePixelFormat: TPixelFormat read FImagePixelFormat
      write FImagePixelFormat default pf24bit;
    property JPEGQuality: TJPEGQualityRange read FJPEGQuality write FJPEGQuality
      default 100;
  end;

  { TgtImageItem }

  TgtImageItem = class(TgtDocumentItem)
  private
    FX: Double;
    FY: Double;
    FWidth: Double;
    FHeight: Double;
    FIndexNo: Integer;
    FFrame: TgtFrame;
    FPen: TPen;
    FBrush: TBrush;
    FSettings: TgtImageSettings;
    FDisplayRect: TgtRect;

    procedure SetPen(Value: TPen);
    procedure SetSettings(Value: TgtImageSettings);
    procedure SetFrame(const Value: TgtFrame);
    procedure SetBrush(const Value: TBrush);

  public
    constructor Create; overload;
    constructor Create(AImageRect: TgtRect); overload;
    destructor Destroy; override;

    property X: Double read FX write FX;
    property Y: Double read FY write FY;
    property Width: Double read FWidth write FWidth;
    property Height: Double read FHeight write FHeight;
    property DisplayRect: TgtRect read FDisplayRect write FDisplayRect;

    property IndexNo: Integer read FIndexNo write FIndexNo;
    property Frame: TgtFrame read FFrame write SetFrame;
    property Pen: TPen read FPen write SetPen;
    property Brush: TBrush read FBrush write SetBrush;
    property Settings: TgtImageSettings read FSettings write SetSettings;
  end;

  { TgtImageStream }

  TgtImageStream = class(TgtImageItem)
  private
    FStream: TStream;
    FImageWidth: Integer;
    FImageHeight: Integer;
  public
    constructor Create; overload;
    constructor Create(AImageRect: TgtRect); overload;
    destructor Destroy; override;
    property Stream: TStream read FStream write FStream;
    property ImageHeight: Integer read FImageHeight write FImageHeight;
    property ImageWidth: Integer read FImageWidth write FImageWidth;
  end;

  { TgtShapeItem }

  TgtShapeItem = class(TgtDocumentItem)
  private
    FBrush: TBrush;
    FPen: TPen;
    FShapeType: TgtShapeType;
    FPoints: TgtPoints;
    FNoPoints: Integer;
    FPenJoinStyle: TgtPenJoinStyle;
    FPenCapStyle: TgtPenCapStyle;
    procedure SetPen(Value: TPen);
    procedure SetBrush(Value: TBrush);

  public
    constructor Create(IsFill: Boolean; ShapeType: TgtShapeType);
    destructor Destroy; override;
    function GetPoints: TgtPoints;
    procedure SetPoints(Points: array of TgtPoint);

    property NoPoints: Integer read FNoPoints write FNoPoints;
    property ShapeType: TgtShapeType read FShapeType write FShapeType;
    property Pen: TPen read FPen write SetPen;
    property Brush: TBrush read FBrush write SetBrush;
    property PenJoinStyle: TgtPenJoinStyle read FPenJoinStyle
      write FPenJoinStyle default pjsNone;
    property PenCapStyle: TgtPenCapStyle read FPenCapStyle write FPenCapStyle
      default pcsNone;
  end;

  { TgtClipItem }

  TgtClipItem = class(TgtDocumentItem)
  private
    FBrush: TBrush;
    FPen: TPen;
    FRestore: Boolean;
    FNoRects: Integer;
    FMode: Cardinal;

    procedure SetPen(Value: TPen);
    procedure SetBrush(Value: TBrush);

  public

    FClipRects: array of TRect;

    constructor Create;
    destructor Destroy; override;
    function GetRects(Position: Integer): TRect;
    procedure SetRects(FRectNo: Integer);

    property NoRects: Integer read FNoRects write FNoRects;
    property Restore: Boolean read FRestore write FRestore;
    property Mode: Cardinal read FMode write FMode;
    property Pen: TPen read FPen write SetPen;
    property Brush: TBrush read FBrush write SetBrush;
  end;

  { TgtEOFItem }

  TgtEOFItem = class(TgtDocumentItem)
  private
    FStatus: Boolean;
  public
    constructor Create;
    destructor Destroy; override;
    property Status: Boolean read FStatus write FStatus;
  end;

  { TgtPathItem }

  TgtPathItem = class(TgtDocumentItem)
  private
    FBrush: TBrush;
    FPen: TPen;
    FPathOperation: TgtPathOperation;
    FMode: Cardinal;
    FFillAlternate: Boolean; // Poly Fill Mode

    procedure SetPen(Value: TPen);
    procedure SetBrush(Value: TBrush);
    procedure SetFillAlternate(const Value: Boolean);

  public

    constructor Create;
    destructor Destroy; override;

    property PathOperation: TgtPathOperation read FPathOperation
      write FPathOperation;
    property Mode: Cardinal read FMode write FMode;
    property Pen: TPen read FPen write SetPen;
    property Brush: TBrush read FBrush write SetBrush;
    property FillAlternate: Boolean read FFillAlternate write SetFillAlternate
      default False;
  end;

  { TgtPolyShapeItem }

  TgtPolyShapeItem = class(TgtDocumentItem)
  private
    FShapes: TList;
    FFillAlternate: Boolean;
    procedure SetFillAlternate(const Value: Boolean);
  public
    constructor Create;
    destructor Destroy; override;
    property Shapes: TList read FShapes;
    property FillAlternate: Boolean read FFillAlternate write SetFillAlternate
      default False;
  end;

  { TgtPolyPolygonItem }

  TgtPolyPolygonItem = class(TgtDocumentItem)
  private
    FBrush: TBrush;
    FPen: TPen;
    FNoPoly: Integer; // Number Of Polygons
    FFillAlternate: Boolean; // Poly Fill Mode

    procedure SetPen(Value: TPen);
    procedure SetBrush(Value: TBrush);
    procedure SetFillAlternate(const Value: Boolean);
  public
    FNoPoints: array of Integer; // Number Of Vertices In Each Polygons
    FPoints: array of TgtPoint; // The Vertices

    constructor Create();
    destructor Destroy; override;
    function GetPoints(Position: Integer): TgtPoint;
    procedure SetPoints();
    procedure SetNoPoints();
    property NoPoly: Integer read FNoPoly write FNoPoly;
    property Pen: TPen read FPen write SetPen;
    property Brush: TBrush read FBrush write SetBrush;
    property FillAlternate: Boolean read FFillAlternate write SetFillAlternate
      default False;
  end;

  { TgtPolyDrawItem }

  TgtPolyDrawItem = class(TgtDocumentItem)
  private
    FBrush: TBrush;
    FPen: TPen;

    procedure SetPen(Value: TPen);
    procedure SetBrush(Value: TBrush);
  public
    FNoPoints: Integer;
    FOperations: array of Byte; // The Operations On the Points
    FPoints: array of TgtPoint; // The Points

    constructor Create();
    destructor Destroy; override;
    procedure SetPoints();

    property Pen: TPen read FPen write SetPen;
    property Brush: TBrush read FBrush write SetBrush;
  end;

  { TgtBorder }

  TgtBorder = class(TPersistent)
  private
    FDrawBottom: Boolean;
    FDrawLeft: Boolean;
    FDrawTop: Boolean;
    FDrawRight: Boolean;
    FWidth: Integer;
    FColor: TColor;
    FStyle: TPenStyle;
    procedure SetColor(const Value: TColor);
    procedure SetDrawBottom(const Value: Boolean);
    procedure SetDrawLeft(const Value: Boolean);
    procedure SetDrawRight(const Value: Boolean);
    procedure SetDrawTop(const Value: Boolean);
    procedure SetStyle(const Value: TPenStyle);
    procedure SetWidth(const Value: Integer);

  public
    constructor Create;
    procedure Assign(Source: TPersistent); override;

  published
    property DrawLeft: Boolean read FDrawLeft write SetDrawLeft default False;
    property DrawRight: Boolean read FDrawRight write SetDrawRight
      default False;
    property DrawTop: Boolean read FDrawTop write SetDrawTop default False;
    property DrawBottom: Boolean read FDrawBottom write SetDrawBottom
      default False;
    property Color: TColor read FColor write SetColor default clBlack;
    property Style: TPenStyle read FStyle write SetStyle default psSolid;
    property Width: Integer read FWidth write SetWidth default 1;
  end;

  { TgtParaBorder }
  TgtParaBorder = class(TgtBorder)
  private
    FSpaceFromText: Integer;
    procedure SetSpaceFromText(const Value: Integer);
  public
    procedure Assign(Source: TPersistent); override;
    property SpaceFromText: Integer read FSpaceFromText write SetSpaceFromText;

  end;

  { TgtTextFormatting }

  TgtTextFormatting = class(TPersistent)
  private
    FBeforeSpace, FLeftIndent, FRightIndent, FFirstLineIndent,
      FLineSpacing: Double;
    FAlignment: TgtHAlignment;
    FNativeFactor: Double;
    FBorder: TgtParaBorder;

    procedure SetBeforeSpace(const Value: Double);
    procedure SetFirstLineIndent(const Value: Double);
    procedure SetLeftIndent(const Value: Double);
    procedure SetRightIndent(const Value: Double);

    function GetBeforeSpace: Double;
    function GetFirstLineIndent: Double;
    function GetLeftIndent: Double;
    function GetRightIndent: Double;
    procedure SetBorder(const Value: TgtParaBorder);

  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;

    property BeforeSpace: Double read GetBeforeSpace write SetBeforeSpace;
    property LeftIndent: Double read GetLeftIndent write SetLeftIndent;
    property RightIndent: Double read GetRightIndent write SetRightIndent;
    property FirstLineIndent: Double read GetFirstLineIndent
      write SetFirstLineIndent;
    property LineSpacing: Double read FLineSpacing write FLineSpacing;
    property Alignment: TgtHAlignment read FAlignment write FAlignment;
    property Border: TgtParaBorder read FBorder write SetBorder;
  end;

  { TgtParagraphItem }

  TgtParagraphItem = class(TgtDocumentItem)
  private
    FX: Double;
    FY: Double;
    FWidth: Double;
    FHeight: Double;
    FFont: TFont;
    FBrush: TBrush;
    FLines: TWideStrings;
    FSettings: TgtTextFormatting;
    FTextEffects: TgtTextEffects;

    procedure SetFont(Value: TFont);
    procedure SetBrush(Value: TBrush);
    procedure SetSettings(Value: TgtTextFormatting);
    procedure SetTextEffects(const Value: TgtTextEffects);

  public
    constructor Create;
    destructor Destroy; override;

    property X: Double read FX write FX;
    property Y: Double read FY write FY;
    property Width: Double read FWidth write FWidth;
    property Height: Double read FHeight write FHeight;

    property Font: TFont read FFont write SetFont;
    property Brush: TBrush read FBrush write SetBrush;
    property TextEffects: TgtTextEffects read FTextEffects write SetTextEffects;
    property Lines: TWideStrings read FLines write FLines;
    property Settings: TgtTextFormatting read FSettings write SetSettings;
  end;

  // TgtTransformationItem = Class(TgtDocumentItem)
  // private
  // FTranformation: TXForm;
  // procedure SetTransformation(Value: TXForm);
  // public
  // constructor Create;
  // destructor Destroy; override;
  // property Transformation: TXForm read FTranformation write SetTransformation;
  //
  // End;

  { TgtTableSettings }

  TgtTableSettings = class(TPersistent)
  private
    FColumnWidth, FRowHeight: Double;
    FInternalMargin: TgtRect;
    FAutoAdjustColumnWidth: Boolean;
    FEnableTitle: Boolean;
    FTitleHeight: Double;
    FNativeFactor: Double;

    procedure SetColumnWidth(const Value: Double);
    procedure SetInternalMargin(const Value: TgtRect);
    procedure SetRowHeight(const Value: Double);
    procedure SetTitleHeight(const Value: Double);

    function GetColumnWidth: Double;
    function GetInternalMargin: TgtRect;
    function GetRowHeight: Double;
    function GetTitleHeight: Double;

  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;

    property ColumnWidth: Double read GetColumnWidth write SetColumnWidth;
    property RowHeight: Double read GetRowHeight write SetRowHeight;
    property InternalMargin: TgtRect read GetInternalMargin
      write SetInternalMargin;

    property AutoAdjustColumnWidth: Boolean read FAutoAdjustColumnWidth
      write FAutoAdjustColumnWidth default False;
    property EnableTitle: Boolean read FEnableTitle write FEnableTitle
      default True;
    property TitleHeight: Double read GetTitleHeight write SetTitleHeight;
  end;

  { TgtColumn }

  TgtColumn = class(TObject)
  private
    FWidth: Double;
    FAlignment: TgtHAlignment;
    FTitle: WideString;
    FOnchange: TgtOnChangeValue;
    procedure SetWidth(const Value: Double);
  public
    constructor Create;
    property Width: Double read FWidth write SetWidth;
    property Alignment: TgtHAlignment read FAlignment write FAlignment;
    property Title: WideString read FTitle write FTitle;
    property Onchange: TgtOnChangeValue read FOnchange write FOnchange;
  end;

  { TgtTableItem }

  TgtTableItem = class(TgtDocumentItem)
  private
    FParent: TgtCustomDocumentEngine;
    FX, FY: Double;
    FRowCount, FColCount: Integer;
    FFont: TFont;
    FBrush: TBrush;
    FPen: TPen;
    FRowHeights: TList;
    FColumns: TList;
    FRowItemsList: TList;
    FSettings: TgtTableSettings;
    FMaxWidth: Double;
    FMaxHeight: Double;
    FTextEffects: TgtTextEffects;

    procedure ChangeValue(var AValue: Double);

    procedure SetBrush(Value: TBrush);
    procedure SetPen(Value: TPen);
    procedure SetFont(Value: TFont);
    procedure SetColumns(Index: Integer; Value: TgtColumn);
    procedure SetSettings(Value: TgtTableSettings);
    procedure SetRowItemsList(Index: Integer; const Value: TList);

    function GetColumns(Index: Integer): TgtColumn;
    function GetRowItemsList(Index: Integer): TList;
    procedure SetTextEffects(const Value: TgtTextEffects);

  public
    constructor Create(NoColumns: Integer; AParent: TgtCustomDocumentEngine);
    destructor Destroy; override;
    function GetColumnsList: TList;
    function CalculateRowHeight: Double;

    property X: Double read FX write FX;
    property Y: Double read FY write FY;
    property MaxWidth: Double read FMaxWidth write FMaxWidth;
    property MaxHeight: Double read FMaxHeight write FMaxHeight;
    property RowCount: Integer read FRowCount write FRowCount;
    property ColCount: Integer read FColCount;
    property Brush: TBrush read FBrush write SetBrush;
    property Pen: TPen read FPen write SetPen;
    property Font: TFont read FFont write SetFont;
    property TextEffects: TgtTextEffects read FTextEffects write SetTextEffects;
    property RowHeights: TList read FRowHeights write FRowHeights;
    property Columns[Index: Integer]: TgtColumn read GetColumns
      write SetColumns;
    property RowItemsList[Index: Integer]: TList read GetRowItemsList
      write SetRowItemsList;
    property Settings: TgtTableSettings read FSettings write SetSettings;
  end;

  { TgtFrame }

  TgtFrame = class(TPersistent)
  private
    FParent: TObject;
    FIsLeft, FIsRight, FIsTop, FIsBottom: Boolean;
    FInternalMargin: TgtRect;
    procedure SetInternalMargin(const Value: TgtRect);
    function GetInternalMargin: TgtRect;
  public
    constructor Create(AParent: TObject);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;

    property IsLeft: Boolean read FIsLeft write FIsLeft default True;
    property IsTop: Boolean read FIsTop write FIsTop default True;
    property IsRight: Boolean read FIsRight write FIsRight default True;
    property IsBottom: Boolean read FIsBottom write FIsBottom default True;
    property InternalMargin: TgtRect read GetInternalMargin
      write SetInternalMargin;
  end;

  { TgtPageSettings }

  TgtPageSettings = class(TPersistent)
  private
    FFooterHeight: Double;
    FWidth: Double;
    FBottomMargin: Double;
    FTopMargin: Double;
    FHeight: Double;
    FRightMargin: Double;
    FLeftMargin: Double;
    FHeaderHeight: Double;
    FPaperSize: TgtPaperSize;
    FOrientation: TPrinterOrientation;
    FBinNumber: Integer;
    FParent: TObject;
    FNativeFactor: Double;

    procedure SetBottomMargin(const Value: Double);
    procedure SetFooterHeight(const Value: Double);
    procedure SetHeaderHeight(const Value: Double);
    procedure SetHeight(const Value: Double);
    procedure SetLeftMargin(const Value: Double);
    procedure SetOrientation(const Value: TPrinterOrientation);
    procedure SetPaperSize(const Value: TgtPaperSize);
    procedure SetRightMargin(const Value: Double);
    procedure SetTopMargin(const Value: Double);
    procedure SetWidth(const Value: Double);
    function GetBinNumber: Integer;
    procedure SetBinNumber(Value: Integer);
    function GetBottomMargin: Double;
    function GetFooterHeight: Double;
    function GetHeaderHeight: Double;
    function GetHeight: Double;
    function GetLeftMargin: Double;
    function GetRightMargin: Double;
    function GetTopMargin: Double;
    function GetWidth: Double;
  public
    constructor Create(AParent: TObject);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;

  published
    property PaperSize: TgtPaperSize read FPaperSize write SetPaperSize
      default A4;
    property Width: Double read GetWidth write SetWidth;
    property Height: Double read GetHeight write SetHeight;
    property Orientation: TPrinterOrientation read FOrientation
      write SetOrientation default poPortrait;

    property LeftMargin: Double read GetLeftMargin write SetLeftMargin;
    property RightMargin: Double read GetRightMargin write SetRightMargin;
    property TopMargin: Double read GetTopMargin write SetTopMargin;
    property BottomMargin: Double read GetBottomMargin write SetBottomMargin;
    property BinNumber: Integer read GetBinNumber write SetBinNumber;
    property HeaderHeight: Double read GetHeaderHeight write SetHeaderHeight;
    property FooterHeight: Double read GetFooterHeight write SetFooterHeight;
  end;

  { TgtEmailSettings }

  TgtEmailSettings = class(TPersistent)
  private
    FHost: String;
    FUserID: String;
    FPassword: String;
    FAttachments: TStringList;
    FBody: TStringList;
    FDate: TDateTime;
    FFromAddress: String;
    FFromName: String;
    FReplyTo: String;
    FSubject: String;
    FRecipientList: TStringList;
    FReceiptRecipient: String;
    FCCList: TStringList;
    FBCCList: TStringList;
    FAuthenticationRequired: Boolean;
    FPort: Integer;
    procedure SetRecipientList(const Value: TStringList);
    procedure SetAttachments(const Value: TStringList);
    procedure SetBCCList(const Value: TStringList);
    procedure SetBody(const Value: TStringList);
    procedure SetCCList(const Value: TStringList);
  public
    constructor Create;
    destructor Destroy; override;

    function Clone: TgtEmailSettings;
    procedure Assign(Source: TPersistent); override;

  published
    property Attachments: TStringList read FAttachments write SetAttachments;
    property Body: TStringList read FBody write SetBody;
    property RecipientList: TStringList read FRecipientList
      write SetRecipientList;
    property ReceiptRecipient: String read FReceiptRecipient
      write FReceiptRecipient;
    property CCList: TStringList read FCCList write SetCCList;
    property BCCList: TStringList read FBCCList write SetBCCList;
    property ReplyTo: String read FReplyTo write FReplyTo;
    property Host: String read FHost write FHost;
    property UserID: String read FUserID write FUserID;
    property Password: String read FPassword write FPassword;
    property AuthenticationRequired: Boolean read FAuthenticationRequired
      write FAuthenticationRequired;
    property Date: TDateTime read FDate write FDate;
    property FromAddress: String read FFromAddress write FFromAddress;
    property FromName: String read FFromName write FFromName;
    property Subject: String read FSubject write FSubject;
    property Port: Integer read FPort write FPort default 25;
  end;

  TgtPreferencesClass = class of TgtPreferences;

  { TgtPreferences }

  TgtPreferences = class(TPersistent)
  private
    FParent: TgtDocSettings;
    FProcessAfterEachPage: Boolean;
    FOutputToUserStream: Boolean;
    FOpenAfterCreate: Boolean;
    FEmailAfterCreate: Boolean;
    FShowSetupDialog: Boolean;
    FCalculateVariables: Boolean;
    FUseImagesAsResources: Boolean;

    procedure SetEmailAfterCreate(const Value: Boolean);
    procedure SetOpenAfterCreate(const Value: Boolean);
    procedure SetOutputToUserStream(const Value: Boolean);
    procedure SetProcessAfterEachPage(const Value: Boolean);
    procedure SetShowSetupDialog(const Value: Boolean);
    procedure SetCalculateVariables(const Value: Boolean);
    procedure SetUseImagesAsResources(const Value: Boolean);

  public
    constructor Create; overload; virtual;
    constructor Create(AParent: TgtDocSettings); overload;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;

  published
    property OpenAfterCreate: Boolean read FOpenAfterCreate
      write SetOpenAfterCreate default True;
    property EmailAfterCreate: Boolean read FEmailAfterCreate
      write SetEmailAfterCreate default False;
    property OutputToUserStream: Boolean read FOutputToUserStream
      write SetOutputToUserStream default False;
    property ProcessAfterEachPage: Boolean read FProcessAfterEachPage
      write SetProcessAfterEachPage default False;
    property ShowSetupDialog: Boolean read FShowSetupDialog
      write SetShowSetupDialog default True;
    property CalculateVariables: Boolean read FCalculateVariables
      write SetCalculateVariables default True;
    property UseImagesAsResources: Boolean read FUseImagesAsResources
      write SetUseImagesAsResources default True;
  end;

  { TgtDocInfo }

  TgtDocInfo = class(TPersistent)
  private
    FParent: TgtDocSettings;
    FCreator: WideString;
    FTitle: WideString;
    FKeywords: WideString;
    FAuthor: WideString;
    FSubject: WideString;
    procedure SetAuthor(const Value: WideString);
    procedure SetCreator(const Value: WideString);
    procedure SetKeywords(const Value: WideString);
    procedure SetSubject(const Value: WideString);
    procedure SetTitle(const Value: WideString);

  public
    constructor Create(AParent: TgtDocSettings);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;

  published
    property Author: WideString read FAuthor write SetAuthor;
    property Subject: WideString read FSubject write SetSubject;
    property Creator: WideString read FCreator write SetCreator;
    property Title: WideString read FTitle write SetTitle;
    property Keywords: WideString read FKeywords write SetKeywords;
  end;

  { TgtBandItem }

  TgtBandItem = class(TObject)
  private
    FDocumentItems: TList;
    FTextItems: TList;
    FOffsetY: Double;

  public
    constructor Create;
    destructor Destroy; override;
  end;

  { TgtPageItem }

  TgtPageItem = class(TgtBandItem)
  private
    FParent: TgtCustomDocumentEngine;
    FSettings: TgtPageSettings;
    procedure SetSettings(Value: TgtPageSettings);

  public
    constructor Create(AParent: TgtCustomDocumentEngine);
    destructor Destroy; override;
    property Settings: TgtPageSettings read FSettings write SetSettings;
  end;

  { TgtEngineState }

  TgtEngineState = class(TObject)
  private
    FFont: TFont;
    FPen: TPen;
    FBrush: TBrush;
    FImageSettings: TgtImageSettings;
    FTextFormatting: TgtTextFormatting;
    FTableSettings: TgtTableSettings;
    FPage: TgtPageSettings;
    FTextEffects: TgtTextEffects;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  { IgtDocumentSettings }

  IgtDocumentSettings = Interface(IUnknown) // Due to compatibility with D5

    function GetBackgroundColor: TColor;
    function GetBackgroundImage: TPicture;
    function GetBackgroundDisplayType: TgtBackgroundDisplayType;
    function GetBrush: TBrush;
    function GetDefaultFont: TFont;
    function GetFileDescription: String;
    function GetDocInfo: TgtDocInfo;
    function GetFileExtension: String;
    function GetFileName: String;
    function GetFont: TFont;
    function GetFrame: TgtFrame;
    function GetImageSettings: TgtImageSettings;
    function GetPage: TgtPageSettings;
    function GetPageBorder: TgtBorder;
    function GetPen: TPen;
    function GetPreferences: TgtPreferences;
    function GetTableSettings: TgtTableSettings;
    function GetTextFormatting: TgtTextFormatting;

    procedure SetBackgroundColor(const Value: TColor);
    procedure SetBackgroundImage(const Value: TPicture);
    procedure SetBackgroundDisplayType(const Value: TgtBackgroundDisplayType);
    procedure SetBrush(const Value: TBrush);
    procedure SetDefaultFont(const Value: TFont);
    procedure SetFileDescription(const Value: String);
    procedure SetDocInfo(const Value: TgtDocInfo);
    procedure SetFileExtension(const Value: String);
    procedure SetFileName(const Value: String);
    procedure SetFont(const Value: TFont);
    procedure SetFrame(const Value: TgtFrame);
    procedure SetImageSettings(const Value: TgtImageSettings);
    procedure SetPage(const Value: TgtPageSettings);
    procedure SetPageBorder(const Value: TgtBorder);
    procedure SetPen(const Value: TPen);
    procedure SetPreferences(const Value: TgtPreferences);
    procedure SetTableSettings(const Value: TgtTableSettings);
    procedure SetTextFormatting(const Value: TgtTextFormatting);

    property FileName: String read GetFileName write SetFileName;
    property Font: TFont read GetFont write SetFont;
    property Pen: TPen read GetPen write SetPen;
    property Brush: TBrush read GetBrush write SetBrush;
    property Frame: TgtFrame read GetFrame write SetFrame;
    property DefaultFont: TFont read GetDefaultFont write SetDefaultFont;

    property BackgroundColor: TColor read GetBackgroundColor
      write SetBackgroundColor;
    property BackgroundImage: TPicture read GetBackgroundImage
      write SetBackgroundImage;
    property BackgroundImageDisplayType: TgtBackgroundDisplayType
      read GetBackgroundDisplayType write SetBackgroundDisplayType;

    property TextFormatting: TgtTextFormatting read GetTextFormatting
      write SetTextFormatting;
    property ImageSettings: TgtImageSettings read GetImageSettings
      write SetImageSettings;
    property TableSettings: TgtTableSettings read GetTableSettings
      write SetTableSettings;
    property Preferences: TgtPreferences read GetPreferences
      write SetPreferences;

    property Page: TgtPageSettings read GetPage write SetPage;
    property PageBorder: TgtBorder read GetPageBorder write SetPageBorder;
    property FileExtension: String read GetFileExtension write SetFileExtension;
    Property FileDescription: String read GetFileDescription
      write SetFileDescription;
    property DocInfo: TgtDocInfo read GetDocInfo write SetDocInfo;
  end;

  { IgtDocumentEngine }

  IgtDocumentEngine = Interface(IgtDocumentSettings)
{$IFDEF gtFileMaker}
    function ActivateLicense(ALicenseKey: String): Boolean;
{$ENDIF}
    procedure BeginDoc;
    procedure EndDoc;
    procedure NewPage;

    procedure HTMLTextOut(X, Y: Double; HTMLStr: WideString);
    procedure TextOutV(X, Y: Double; Text: WideString; TopDown: Boolean = True);
    procedure TextOut(X, Y: Double; Text: WideString); overload;
    procedure TextOut(ColumnNo: Integer; Text: WideString); overload;
    function TextOut(Text: WideString): Double; overload;
    procedure TextRect(Rect: TgtRect; X, Y: Double; Text: WideString);
    procedure DrawRichText(RichEdit: TRichEdit;
      ALeft, ATop, ARight, ABottom: Double; StartPos, EndPos: Integer;
      BackgroundColor: TColor); overload;
{$IFDEF JediRichEdit}
    procedure DrawRichText(RichEdit: TJvRichEdit;
      ALeft, ATop, ARight, ABottom: Double; StartPos, EndPos: Integer;
      BackgroundColor: TColor); overload;
{$ENDIF}
{$IFDEF RichEdit98}
    procedure DrawRichText(RichEdit: TRichEdit98;
      ALeft, ATop, ARight, ABottom: Double; StartPos, EndPos: Integer;
      BackgroundColor: TColor); overload;
{$ENDIF}
    procedure ExportRichText(FilePath: String;
      ALeft, ATop, ARight, ABottom: Double; StartPos, EndPos: Integer;
      BackgroundColor: TColor); overload;
    procedure ExportRichText(FileStream: TStream;
      ALeft, ATop, ARight, ABottom: Double; StartPos, EndPos: Integer;
      BackgroundColor: TColor); overload;

    procedure TextBox(TextRect: TgtRect; Text: WideString;
      HAlignment: TgtHAlignment; VAlignment: TgtVAlignment);
    procedure SetTextRotation(Angle: Integer);
    procedure SetTextAlignment(Alignment: TgtHAlignment);

    procedure DrawJPEGDirect(ARect: TgtRect;
      AImagePixelWidth, AImagePixelHeight: Integer; AStream: TStream); overload;
    procedure DrawJPEGDirect(ImageRect: TgtRect; AGraphic: TGraphic); overload;
    procedure DrawImage(X, Y: Double; AGraphic: TGraphic); overload;
    procedure DrawImage(ImageRect: TgtRect; AGraphic: TGraphic); overload;
    procedure DrawImage(ImageRect: TgtRect; Index: Integer); overload;
    procedure DrawImage(ColumnNo: Integer; Width, Height: Double;
      AGraphic: TGraphic); overload;
    function AddImageAsResource(AGraphic: TGraphic): Integer;

    procedure Line(X1, Y1, X2, Y2: Double);
    procedure Rectangle(X1, Y1, X2, Y2: Double; IsFill: Boolean);
    procedure RoundRect(X1, Y1, X2, Y2, X3, Y3: Double; IsFill: Boolean);
    procedure Ellipse(X1, Y1, X2, Y2: Double; IsFill: Boolean);
    procedure Polygon(Points: array of TgtPoint; IsFill: Boolean);
    procedure PolyLine(Points: array of TgtPoint);
    procedure Arc(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Double);
    procedure Pie(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Double; IsFill: Boolean);
    procedure Chord(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Double; IsFill: Boolean);
    procedure PolyBezier(Points: array of TgtPoint);

    procedure BeginPara;
    procedure EndPara;
    function BeginTable(X, Y: Double; NoColumns: Integer): TList;
    function NewRow(Height: Double): Double; overload;
    function NewRow: Double; overload;
    procedure EndTable;

    procedure PlayMetafile(Metafile: TMetafile); overload;
    procedure PlayMetafile(DestRect: TgtRect; Metafile: TMetafile); overload;
    procedure PlayMetafile(X, Y: Double; Metafile: TMetafile); overload;

    procedure BeginHeader;
    procedure EndHeader;
    procedure ClearHeader;
    procedure BeginFooter;
    procedure EndFooter;
    procedure ClearFooter;
    procedure BeginWaterMark;
    procedure EndWaterMark;
    procedure ClearWaterMark;
    procedure BeginStamp;
    procedure EndStamp;
    procedure ClearStamp;

    function SaveEngineState: Integer;
    procedure RestoreEngineState(Index: Integer);
    procedure ClearEngineStates;
    procedure SetWorkingPage(PageNo: Integer);
    function TextSize(const Text: WideString; AFont: TFont): TSize; overload;
    // {$IFDEF gtDelphi6Up}
    // function TextSize(const Text: AnsiString; AFont: TFont): TSize; overload;
    // {$ENDIF}
  end;

  { TgtHashValue }

  TgtHashValue = class(TObject)
  private
    FHashValue: MD5Digest;

  public
    constructor Create;
    destructor Destroy; override;
{$IFDEF gtDelphi2009Up}
    property HashValue: MD5Digest read FHashValue write FHashValue;
{$ENDIF}
  end;

  { TgtHashValueList }

  // TgtHashValueList = class(TList)
  // private
  // function GetItem(Index: Integer): TgtHashValue;

  // public
  // To aviod the need to typecast
  // property Items[Index: Integer]: TgtHashValue read GetItem; default;
  // end;

  { TgtCustomDocumentEngine }

  TgtCustomDocumentEngine = class(TgtBaseComponent, IgtDocumentEngine)
  private
{$IFDEF gtFileMaker}
    FStatusMgr: TgtStatusEngine;
{$ENDIF}
    { Fields used by the Engine }
    FPages: TList;
    FTextRotationAngle: Integer;
    FTextAlignment: TgtHAlignment;
    FBandRect: TgtRect;
    FCurrentPage: Integer;
    FPageCount: Integer;
    FDefaultState: Integer;

    FNativeConversionFactor: Double;

    FHeaderItem: TgtBandItem;
    FFooterItem: TgtBandItem;
    FWatermarkItem: TgtBandItem;
    FStampItem: TgtBandItem;

    FEngineStateList: TList;
    FCurrentDocumentItemList: TList;
    FCurrentTextItemList: TList;
    FCurrentOffsetY: Double;

    FFont: TFont;
    FBrush: TBrush;
    FTextEffects: TgtTextEffects;
    FPen: TPen;
    FFrame: TgtFrame;
    FCanvas: TMetafileCanvas;
    FMetafile: TMetafile;

    FTextItem: TgtTextItem;
    FImageItem: TgtImageItem;
    FImageStream: TgtImageStream;
    FShapeItem: TgtShapeItem;
    FParagraphItem: TgtParagraphItem;
    FParaItem: array of TgtParagraphItem;

    FImageSettings: TgtImageSettings;
    FTextFormatting: TgtTextFormatting;
    FTableSettings: TgtTableSettings;
    FPreferences: TgtPreferences;
    FFileName: String;
    FMeasurementUnit: TgtUnitType;
    FUserStream: TStream;
    FDescription: String;
    FFileExtension: String;

    FDocInfo: TgtDocInfo;
    FPage: TgtPageSettings;
    FPageBorder: TgtBorder;
    FCapabilities: TgtCapabilities;
    FDefaultFont: TFont;
    FBackgroundColor: TColor;
    FBackgroundDisplayType: TgtBackgroundDisplayType;
    FBackgroundImage: TPicture;

    FItemsToRender: TgtItemsToRender;
    FPagesToRender: String;
    FSettings: TgtDocSettings;
    FEngineFileNames: TStringList;
    FEngineStatus: TgtEngineStatus;
    FSetupDialog: TgtBaseDlg;
    FReferencePoint: TgtReferencePoint;
    FInputXRes, FInputYRes: Integer;
    FAbortCreation: Boolean;

    FOnNeedFileName: TgtOnNeedFileNameEvent;
{$IFDEF gtActiveX}
    FOnCellDraw: TgtOnCellDrawEvent;
    FOnCellDrawEx: TgtOnCellDrawExEvent;
{$ELSE}
    FOnCellDraw: TgtOnCellDrawEvent;
{$ENDIF}
    FOnBeforeEndDoc: TgtNotifyEvent;
    FOnAfterEndDoc: TgtNotifyEvent;
    FOnBeforeBeginDoc: TgtNotifyEvent;
    FOnAfterBeginDoc: TgtNotifyEvent;
    FOnBeforeEndPage: TgtNotifyEvent;
    FOnAfterEndPage: TgtNotifyEvent;
    FOnBeforeBeginPage: TgtNotifyEvent;
    FOnAfterBeginPage: TgtNotifyEvent;
    FOnErrorMessage: TgtErrorMessageEvent;
    FOnCalcVariables: TgtOnCalcVariablesEvent;

    FEmailAdapter: TgtEmailAdapter;
    FEmailSettings: TgtEmailSettings;
    FOnEmail: TgtEmailEvent;
    FOnEmailError: TgtEmailErrorEvent;

    // {$IFDEF EMailWithFastNet}
    // FOnEmailConnect: TNotifyEvent;
    // FOnEmailConnectionFailed: TNotifyEvent;
    // FOnEmailDisConnect: TNotifyEvent;
    // FOnEmailInvalidHost: THandlerEvent;
    // FOnEmailFailure: TNotifyEvent;
    // FOnEmailSendStart: TNotifyEvent;
    // FOnEmailStatus: TOnStatus;
    // FOnEmailSuccess: TNotifyEvent;
    // {$ENDIF}
{$IFDEF EMailWithIndy}
    FOnEmailConnected: TNotifyEvent;
    FOnEmailDisConnected: TNotifyEvent;
    // FOnEmailStatus: TNotifyEvent;
    FOnEmailSuccess: TNotifyEvent;
{$ENDIF}
{$IFDEF gtActiveX}
    FBackgroundImageEnabled: Boolean;
    FLocalizationFile: TFileName;
{$ENDIF}
    FMD5ImageHash: TgtMD5;
    { Get methods of properties and Events }
    function GetFileName: String;
    function GetPages(Index: Integer): TgtPageItem;
    function GetBackgroundColor: TColor;
    function GetBackgroundDisplayType: TgtBackgroundDisplayType;
    function GetBackgroundImage: TPicture;
    function GetBrush: TBrush;
    function GetCanvas: TMetafileCanvas;
    function GetCurrentPage: Integer;
    function GetDefaultFont: TFont;
    function GetFileDescription: String;
    function GetDocInfo: TgtDocInfo;

    function GetEMailSettings: TgtEmailSettings;

    function GetFileExtension: String;
    function GetFont: TFont;
    function GetFrame: TgtFrame;
    function GetImageSettings: TgtImageSettings;
    function GetMeasurementUnit: TgtUnitType;
    function GetPage: TgtPageSettings;
    function GetPageBorder: TgtBorder;
    function GetTextFormatting: TgtTextFormatting;
    function GetPen: TPen;
    function GetPreferences: TgtPreferences;
    function GetTableSettings: TgtTableSettings;
    function GetUserStream: TStream;

    { Set methods of properties and Events }
    procedure SetBackgroundColor(const Value: TColor);
    procedure SetBackgroundDisplayType(const Value: TgtBackgroundDisplayType);
    procedure SetBackgroundImage(const Value: TPicture);
    procedure SetBrush(const Value: TBrush);
    procedure SetCanvas(const Value: TMetafileCanvas);
    procedure SetDefaultFont(const Value: TFont);
    procedure SetFileDescription(const Value: String);
    procedure SetDocInfo(const Value: TgtDocInfo);

    procedure SetEMailSettings(const Value: TgtEmailSettings);

    procedure SetEngineFileNames(const Value: TStringList);
    procedure SetFileName(const Value: String);
    procedure SetFrame(const Value: TgtFrame);
    procedure SetFont(const Value: TFont);
    procedure SetFileExtension(const Value: String);
    procedure SetImageSettings(const Value: TgtImageSettings);
    procedure SetItemsToRender(const Value: TgtItemsToRender);
    procedure SetMeasurementUnit(const Value: TgtUnitType);
    procedure SetPen(const Value: TPen);
    procedure SetPreferences(const Value: TgtPreferences);
    procedure SetPage(const Value: TgtPageSettings);
    procedure SetPagesToRender(const Value: String);
    procedure SetSettings(const Value: TgtDocSettings);
    procedure SetSetupDialog(const Value: TgtBaseDlg);
    procedure SetTextFormatting(const Value: TgtTextFormatting);
    procedure SetTableSettings(const Value: TgtTableSettings);
    procedure SetUserStream(const Value: TStream);
{$IFDEF gtActiveX}
    procedure SetOnCellDraw(const Value: TgtOnCellDrawEvent);
    procedure SetOnCellDrawEx(const Value: TgtOnCellDrawExEvent);
{$ELSE}
    procedure SetOnCellDraw(const Value: TgtOnCellDrawEvent);
{$ENDIF}
    procedure SetOnCalcVariables(const Value: TgtOnCalcVariablesEvent);
    procedure SetBandType(const Value: TgtBandType);
    procedure SetReferencePoint(const Value: TgtReferencePoint);
    procedure SetInputXRes(const Value: Integer);
    procedure SetInputYRes(const Value: Integer);
    procedure SetAbortCreation(const Value: Boolean);
    procedure SetPageBorder(const Value: TgtBorder);
    procedure SetTextEffects(const Value: TgtTextEffects);

    { Used to clip shape coordinates if they are out of range }
    procedure ClipShapeCoordinates(Points: TgtPoints; NoPoints: Integer);

    { This method used to calculate Current BandRect
      Supported Band are Header, Footer, Watermark, Stamp or Content }
    procedure CalculateBandRect;

    { Used to Create New Image Item and Fill with current Engine values }
    procedure CreateImageItem(ImageRect: TgtRect; Index: Integer);

    { Frees all document items in a list }
    procedure FreeItemsList(AList: TList);
    procedure FreeJpegImageResource;
    procedure FreeImageResourceList;

    { Check weather Item in valid range or not }
    function IsDocumentItemInRange(X, Y: Double): Boolean;

    { To check weather Page is in user selected range or not }
    function IsPageInRange(APageNo: Integer): Boolean;

    { Used to Encode all document items in List }
    procedure ProcessItemsList(AList: TList);

    { Called for processing each page }
    procedure ProcessPage;

    { Used to encode rectangular region of Text }
    procedure ProcessTextRect(ATextItem: TgtTextItem; HAlign: TgtHAlignment;
      VAlign: TgtVAlignment; MaxWidth, MaxHeight: Double; Margin: TgtRect);

    { Used to Allocate and initialize resources. }
    procedure InitializeEngine;

    { Used to free up resources. }
    procedure FinalizeEngine;
    Procedure SendMail;
    // procedure SetBmpDPI(Bitmap: TBitmap; DPI: Integer);
{$IFDEF gtActiveX}
    { Load the strings from the LocalizationFile }
    procedure LoadLocalizedStrings;

{$ENDIF}
  protected
    { Can be used by descendent Engines and metafile Processor. }
    FNoSorting: Boolean;
    FTableItem: TgtTableItem;
    FIsDocumentStarted: Boolean;
    FIsTableStarted: Boolean;
    FIsParagraphStarted: Boolean;
    FIsParaStarted: array of Boolean;
    TableOnLastpage: array of Boolean;
    RowsOnPage: array of array of Integer;
    FTablenumber: Integer;
    FSortTextItems: Boolean;
    FImageResourceList: TList;
    FImageResourceHashList: TList; // TgtHashValueList; // To manage image reuse
    FBandType: TgtBandType;
    FYFactor: Double;
    FIsAutoPaginate: Boolean;
    FPenJoin: TgtPenJoinStyle;
    FPenCap: TgtPenCapStyle;
    FBiDiMode: TBiDiMode;
    // FSupportsTransformation: Boolean;

    // ::EDIT::BEGIN::gs-soft
    procedure PreProcessPages;
    // ::EDIT::END::gs-soft

    { Document creation Methods. }
    procedure BeginDoc; virtual;
    procedure EndDoc; virtual;
    procedure NewPage; virtual;

    procedure SetAutoPaginate(const Value: Boolean);
    procedure HTMLTextOut(X, Y: Double; HTMLStr: WideString); virtual;
    procedure TextOutV(X, Y: Double; Text: WideString;
      TopDown: Boolean = True); virtual;
    procedure TextOut(X, Y: Double; Text: WideString); overload; virtual;
    procedure TextOut(ColumnNo: Integer; Text: WideString); overload; virtual;
    function TextOut(Text: WideString): Double; overload; virtual;
    procedure TextRect(Rect: TgtRect; X, Y: Double; Text: WideString); virtual;
    procedure TextBox(TextRect: TgtRect; Text: WideString;
      HAlignment: TgtHAlignment; VAlignment: TgtVAlignment); virtual;
    procedure SetTextRotation(Angle: Integer); virtual;
    procedure SetTextAlignment(Alignment: TgtHAlignment); virtual;

    procedure DrawJPEGDirect(ARect: TgtRect;
      AImagePixelWidth, AImagePixelHeight: Integer; AStream: TStream);
      overload; virtual;
    procedure DrawJPEGDirect(ImageRect: TgtRect; AGraphic: TGraphic);
      overload; virtual;
    procedure DrawImage(X, Y: Double; AGraphic: TGraphic); overload; virtual;
    procedure DrawImage(ImageRect: TgtRect; AGraphic: TGraphic);
      overload; virtual;
    procedure DrawImage(ImageRect: TgtRect; Index: Integer); overload; virtual;
    procedure DrawImage(ColumnNo: Integer; Width, Height: Double;
      AGraphic: TGraphic); overload; virtual;
    function AddImageAsResource(AGraphic: TGraphic): Integer; overload; virtual;
    function AddImageAsResource(AGraphic: TGraphic; AResource: Boolean)
      : Integer; overload; virtual;

    procedure Line(X1, Y1, X2, Y2: Double); virtual;
    procedure Rectangle(X1, Y1, X2, Y2: Double; IsFill: Boolean); virtual;
    procedure RoundRect(X1, Y1, X2, Y2, X3, Y3: Double;
      IsFill: Boolean); virtual;
    procedure Ellipse(X1, Y1, X2, Y2: Double; IsFill: Boolean); virtual;
    procedure Polygon(Points: array of TgtPoint; IsFill: Boolean); virtual;
    procedure PolyLine(Points: array of TgtPoint); virtual;

    procedure Arc(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Double); virtual;
    procedure Pie(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Double;
      IsFill: Boolean); virtual;
    procedure Chord(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Double;
      IsFill: Boolean); virtual;
    procedure PolyBezier(Points: array of TgtPoint); virtual;

    procedure BeginPara; virtual;
    procedure EndPara; virtual;

    function BeginTable(X, Y: Double; NoColumns: Integer): TList; virtual;
    function NewRow(Height: Double): Double; overload; virtual;
    function NewRow: Double; overload; virtual;
    procedure EndTable; virtual;

    procedure PlayMetafile(Metafile: TMetafile); overload; virtual;
    procedure PlayMetafile(DestRect: TgtRect; Metafile: TMetafile);
      overload; virtual;
    procedure PlayMetafile(X, Y: Double; Metafile: TMetafile);
      overload; virtual;

    procedure BeginHeader; virtual;
    procedure EndHeader; virtual;
    procedure ClearHeader; virtual;

    procedure BeginFooter; virtual;
    procedure EndFooter; virtual;
    procedure ClearFooter; virtual;

    procedure BeginWaterMark; virtual;
    procedure EndWaterMark; virtual;
    procedure ClearWaterMark; virtual;

    procedure BeginStamp; virtual;
    procedure EndStamp; virtual;
    procedure ClearStamp; virtual;

    function SaveEngineState: Integer; virtual;
    procedure RestoreEngineState(Index: Integer); virtual;
    procedure ClearEngineStates; virtual;

    procedure SetWorkingPage(PageNo: Integer); virtual;
    function TextSize(const Text: WideString; AFont: TFont): TSize; overload;
    function TextSizeW(const Text: WideString; AFont: TFont): TSize; overload;

    // {$IFDEF gtDelphi6Up}
    // function TextSize(const Text: AnsiString; AFont: TFont): TSize; overload;
    // {$ENDIF}
    {
      Document Processing Methods:
      These methods can be overridden by each Engines, to create document.
    }
    procedure BeginPage; virtual;
    procedure EndPage; virtual;
    procedure Start; virtual;
    procedure Finish; virtual;

    procedure EncodeText(AObject: TgtTextItem); virtual;
    procedure EncodeTextBox(AObject: TgtTextBoxItem); virtual;
    procedure EncodeParagraph(AObject: TgtParagraphItem); virtual;

    procedure EncodeImage(AObject: TgtImageItem); virtual;
    procedure EncodeImageStream(ImgStream: TgtImageStream); virtual;
    procedure EncodeTable(AObject: TgtTableItem); virtual;
    procedure EncodeCustomItem(AObject: TgtDocumentItem); virtual;
    procedure EncodeShape(AObject: TgtShapeItem);
    procedure EncodeClipRect(AObject: TgtClipItem); virtual;
    procedure EncodePathItem(AObject: TgtPathItem); virtual;
    procedure EncodePolyShape(AObject: TgtPolyShapeItem);
    procedure EncodePolyPolygon(AObject: TgtPolyPolygonItem); virtual;
    procedure EncodeEOF(AObject: TgtEOFItem); virtual;
    procedure EncodePolyDraw(AObject: gtCstDocEng.TgtPolyDrawItem); virtual;
    // procedure EncodeTransformationItem(AObject: TgtTransformationItem); virtual;
    // In Below methods, if Brush <> nil then fill the shape
    procedure EncodeLine(X1, Y1, X2, Y2: Double; Pen: TPen); virtual;
    procedure EncodeRect(X1, Y1, X2, Y2: Double; Pen: TPen;
      Brush: TBrush); virtual;
    procedure EncodeRoundRect(X1, Y1, X2, Y2, X3, Y3: Double; Pen: TPen;
      Brush: TBrush); virtual;
    procedure EncodeEllipse(X1, Y1, X2, Y2: Double; Pen: TPen;
      Brush: TBrush); virtual;
    procedure EncodePolyLine(Points: TgtPoints; NoPoints: Integer;
      IsClosed: Boolean; Pen: TPen; Brush: TBrush); virtual;
    procedure EncodePolyPolyline(AObject: gtCstDocEng.TgtPolyShapeItem;
      IsClosed: Boolean); virtual;
    procedure EncodeArc(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Double;
      Pen: TPen); virtual;
    procedure EncodePie(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Double; Pen: TPen;
      Brush: TBrush); virtual;
    procedure EncodeChord(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Double; Pen: TPen;
      Brush: TBrush); virtual;
    procedure EncodePolyBezier(Points: TgtPoints; NoPoints: Integer;
      Pen: TPen); virtual;
    {
      Image resource can be get by the other classes also
    }
    function GetImageResourceIndex(AGraphic: TGraphic): Integer; overload;
    function GetImageResourceIndex(AStream: TStream): Integer; overload;
    {
      This Method will be called for all the shapes which are not
      supported in descendent engines.
    }
    procedure EncodeShapeBitmap(X, Y: Double; Bitmap: TBitmap); virtual;
    procedure EncodePageBorder; virtual;

    { Helper Methods for descendent Engines. }

    { Called to get Bitmap image from ImageItem }
    function GetImageAsBitmap(AImageObject: TgtImageItem): TBitmap;

    { Called to get Metafile image from ImageItem }
    function GetImageAsMetafile(AImageObject: TgtImageItem;
      SupportsStretch: Boolean = False; AutoFormat: Boolean = True): TMetafile;

    { Called to get GIF or JPEG stream from already created bitmap image }
    function GetBitmapAsJPGGIFStream(ABitmap: TBitmap; IsJPEG: Boolean;
      JPEGQuality: Integer): TStream;

    { Called to get PNG stream from already created bitmap image }
    function GetBitmapAsPNGStream(ABitmap: TBitmap;
      ATransColor: TColor): TStream;

    { Call this method to get rotated text as bitmap, if text rotation in
      not supported in descendent engines. }
    function GetRotatedTextBitmap(ATextObject: TgtTextItem): TBitmap;

    { Used to Break String of text into Multiple Lines }
    function WrapTextIntoLines(Text: String; Width, FirstLineWidth: Double;
      Lines: TStringList; AutoResize: Boolean; AFont: TFont): Integer; overload;

    { in case of unicode characters }
    function WrapTextIntoLines(Text: WideString; Width, FirstLineWidth: Double;
      Lines: TWideStrings; AutoResize: Boolean; AFont: TFont): Integer;
      overload;

    { Used to Convert the texts based on place hoders. }
    function ReplacePlaceHolders(AText: WideString; AReplacePageInfo: Boolean)
      : WideString; virtual;
    function ReplacePageInfo(AText: WideString): WideString; virtual;

    { This method will return linked text }
    function GetHyperLinkText(AText: String; var AStartPos: Integer): String;

    { This method breaks paragraph item into multiple TextItems and add to the
      document list.
    }
    procedure BreakParagraphIntoText;

    function GetGraphicResource(Index: Integer): TGraphic;
    function NativeRect(ARect: TgtRect): TgtRect;
    function NativeXPos(AX: Double): Double;
    function NativeYPos(AY: Double): Double;
    procedure ProcessTextList(AList: TList); virtual;
    procedure ProcessMetafile(AX, AY: Double; AMetafile: TMetafile); virtual;
    procedure AdjustTextItemList(AList: TList); virtual;
    procedure AddDocumentItem(AItem: TgtDocumentItem);
    function CreateFile(AFileName: String): TStream;
    procedure CancelCreate;

    {
      This method should be overidden in descendent Engines if any output
      Image format is not supported.
    }
    function CheckOutputImageFormat(Value: TgtOutputImageFormat; var S: String)
      : Boolean; virtual;

    { Used to create and show setup dialog. }
    function ShowSetupModal: Word; virtual;

    { To know Preferences class name }
    function GetPreferencesClassName: TgtPreferencesClass; virtual;

    procedure CreateEMailSettingsObj; virtual;

    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
{$IFNDEF gtRegistered}
    procedure PutTrialNote; virtual;
    procedure PutTrialNoteOnTop;
{$ENDIF}
    { Fun 2 arrange R2L/L2R chars in a line }
    function R2LString(OriginalStr: WideString): WideString; virtual;
{$IFDEF gtFileMaker}
    property StatusMgr: TgtStatusEngine read FStatusMgr;
{$ENDIF}
    { Internal use properties }
    // property Pages[Index: Integer]: TgtPageItem read GetPages;
    property Capabilities: TgtCapabilities read FCapabilities
      write FCapabilities;
    property CurrentTextItemList: TList read FCurrentTextItemList
      write FCurrentTextItemList;
    property CurrentDocumentItemList: TList read FCurrentDocumentItemList
      write FCurrentDocumentItemList;
    property EngineFileNames: TStringList read FEngineFileNames
      write SetEngineFileNames;
    property BandType: TgtBandType read FBandType write SetBandType;
    property BandRect: TgtRect read FBandRect;
    property NativeConversionFactor: Double read FNativeConversionFactor;

    { Properties which can be used by the users. }
    property FileName: String read GetFileName write SetFileName;

    property DefaultFont: TFont read GetDefaultFont write SetDefaultFont;
    property Font: TFont read GetFont write SetFont;
    property Pen: TPen read GetPen write SetPen;
    property Brush: TBrush read GetBrush write SetBrush;
    property TextEffects: TgtTextEffects read FTextEffects write SetTextEffects;
    property Frame: TgtFrame read GetFrame write SetFrame;

    property Page: TgtPageSettings read GetPage write SetPage;
    property PageBorder: TgtBorder read GetPageBorder write SetPageBorder;
    property DocInfo: TgtDocInfo read GetDocInfo write SetDocInfo;

    property TextFormatting: TgtTextFormatting read GetTextFormatting
      write SetTextFormatting;
    property ImageSettings: TgtImageSettings read GetImageSettings
      write SetImageSettings;
    property TableSettings: TgtTableSettings read GetTableSettings
      write SetTableSettings;
    property Preferences: TgtPreferences read GetPreferences
      write SetPreferences;

    property BackgroundColor: TColor read GetBackgroundColor
      write SetBackgroundColor default CBackgroundColor;
    property BackgroundImage: TPicture read GetBackgroundImage
      write SetBackgroundImage;
    property BackgroundImageDisplayType: TgtBackgroundDisplayType
      read GetBackgroundDisplayType write SetBackgroundDisplayType
      default dtCenter;

    { Used by the engines which support each page in different file. }
    property OnNeedFileName: TgtOnNeedFileNameEvent read FOnNeedFileName
      write FOnNeedFileName;
    property BiDiMode: TBiDiMode read FBiDiMode write FBiDiMode
      default bdLeftToRight;
    function FindImageResourceIndex(AStream: TStream;
      var AImageHashValue: TgtHashValue): Integer;
    property ImageResourceList: TList read FImageResourceList
      write FImageResourceList;
    property Pages[Index: Integer]: TgtPageItem read GetPages;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
{$IFDEF gtFileMaker}
    function ActivateLicense(ALicenseKey: String): Boolean;
{$ENDIF}
    procedure DrawRichText(RichEdit: TRichEdit;
      ALeft, ATop, ARight, ABottom: Double; StartPos, EndPos: Integer;
      BackgroundColor: TColor); overload;
{$IFDEF JediRichEdit}
    procedure DrawRichText(RichEdit: TJvRichEdit;
      ALeft, ATop, ARight, ABottom: Double; StartPos, EndPos: Integer;
      BackgroundColor: TColor); overload;
{$ENDIF}
{$IFDEF RichEdit98}
    procedure DrawRichText(RichEdit: TRichEdit98;
      ALeft, ATop, ARight, ABottom: Double; StartPos, EndPos: Integer;
      BackgroundColor: TColor); overload;
{$ENDIF}
    procedure ExportRichText(FilePath: String;
      ALeft, ATop, ARight, ABottom: Double; StartPos, EndPos: Integer;
      BackgroundColor: TColor); overload;
    procedure ExportRichText(FileStream: TStream;
      ALeft, ATop, ARight, ABottom: Double; StartPos, EndPos: Integer;
      BackgroundColor: TColor); overload;
    function TextWidth(Text: WideString): Double; overload;
    function TextHeight(Text: WideString): Double; overload;

    property Canvas: TMetafileCanvas read GetCanvas write SetCanvas;
    property UserStream: TStream read GetUserStream write SetUserStream;
    property CurrentPage: Integer read GetCurrentPage;
    property PageCount: Integer read FPageCount;
    property AbortCreation: Boolean read FAbortCreation write SetAbortCreation
      default False;
    property EngineStatus: TgtEngineStatus read FEngineStatus;
{$IFDEF gtActiveX}
    procedure Paint; override;
{$ENDIF}
  published

    property FileExtension: String read GetFileExtension write SetFileExtension;
    Property FileDescription: String read GetFileDescription
      write SetFileDescription;
    property InputXRes: Integer read FInputXRes write SetInputXRes;
    property InputYRes: Integer read FInputYRes write SetInputYRes;
    property ItemsToRender: TgtItemsToRender read FItemsToRender
      write SetItemsToRender default [irText, irImage, irShape];
    property PagesToRender: String read FPagesToRender write SetPagesToRender;
    property MeasurementUnit: TgtUnitType read GetMeasurementUnit
      write SetMeasurementUnit default muInches;
    property ReferencePoint: TgtReferencePoint read FReferencePoint
      write SetReferencePoint;
    property SetupDialog: TgtBaseDlg read FSetupDialog write SetSetupDialog;
    property Settings: TgtDocSettings read FSettings write SetSettings;
    property AutoPaginate: Boolean read FIsAutoPaginate write SetAutoPaginate
      default True;

    property OnBeforeBeginDoc: TgtNotifyEvent read FOnBeforeBeginDoc
      write FOnBeforeBeginDoc;
    property OnAfterBeginDoc: TgtNotifyEvent read FOnAfterBeginDoc
      write FOnAfterBeginDoc;
    property OnBeforeEndDoc: TgtNotifyEvent read FOnBeforeEndDoc
      write FOnBeforeEndDoc;
    property OnAfterEndDoc: TgtNotifyEvent read FOnAfterEndDoc
      write FOnAfterEndDoc;
    property OnBeforeBeginPage: TgtNotifyEvent read FOnBeforeBeginPage
      write FOnBeforeBeginPage;
    property OnAfterBeginPage: TgtNotifyEvent read FOnAfterBeginPage
      write FOnAfterBeginPage;
    property OnBeforeEndPage: TgtNotifyEvent read FOnBeforeEndPage
      write FOnBeforeEndPage;
    property OnAfterEndPage: TgtNotifyEvent read FOnAfterEndPage
      write FOnAfterEndPage;
    property OnErrorMessage: TgtErrorMessageEvent read FOnErrorMessage
      write FOnErrorMessage;
{$IFDEF gtActiveX}
    property OnCellDraw: TgtOnCellDrawEvent read FOnCellDraw
      write SetOnCellDraw;
    property OnCellDrawEx: TgtOnCellDrawExEvent read FOnCellDrawEx
      write SetOnCellDrawEx;
{$ELSE}
    property OnCellDraw: TgtOnCellDrawEvent read FOnCellDraw
      write SetOnCellDraw;
{$ENDIF}
    property OnCalcVariables: TgtOnCalcVariablesEvent read FOnCalcVariables
      write SetOnCalcVariables;

    property EmailAdapter: TgtEmailAdapter read FEmailAdapter
      write FEmailAdapter;
    property EMailSettings: TgtEmailSettings read GetEMailSettings
      write SetEMailSettings;
    property OnEmail: TgtEmailEvent read FOnEmail write FOnEmail;
    property OnEmailError: TgtEmailErrorEvent read FOnEmailError
      write FOnEmailError;

    // {$IFDEF EMailWithFastNet}
    // property OnEmailConnect: TNotifyEvent read FOnEmailConnect
    // write FOnEmailConnect;
    // property OnEmailDisConnect: TNotifyEvent read FOnEmailDisConnect
    // write FOnEmailDisConnect;
    // property OnEmailSendStart: TNotifyEvent read FOnEmailSendStart
    // write FOnEmailSendStart;
    // property OnEmailStatus: TOnStatus read FOnEmailStatus write FOnEmailStatus;
    // property OnEmailFailure: TNotifyEvent read FOnEmailFailure
    // write FOnEmailFailure;
    // property OnEmailSuccess: TNotifyEvent read FOnEmailSuccess
    // write FOnEmailSuccess;
    // property OnEmailConnectionFailed: TNotifyEvent read FOnEmailConnectionFailed
    // write FOnEmailConnectionFailed;
    // property OnEmailInvalidHost: THandlerEvent read FOnEmailInvalidHost
    // write FOnEmailInvalidHost;
    // {$ENDIF}
{$IFDEF EMailWithIndy}
    property OnEmailConnected: TNotifyEvent read FOnEmailConnected
      write FOnEmailConnected;
    property OnEmailDisConnected: TNotifyEvent read FOnEmailDisConnected
      write FOnEmailDisConnected;
    // property OnEmailStatus: TNotifyEvent read FOnEmailStatus
    // write FOnEmailStatus;
    property OnEmailSuccess: TNotifyEvent read FOnEmailSuccess
      write FOnEmailSuccess;
{$ENDIF}
{$IFDEF gtActiveX}
    property BackgroundImageEnabled: Boolean read FBackgroundImageEnabled
      write FBackgroundImageEnabled;
    property LocalizationFile: TFileName read FLocalizationFile
      write FLocalizationFile;
{$ENDIF}
  end;

  { TgtBaseDlg }

  TgtBaseDlg = class(TForm)
  private
    FEngine: TgtCustomDocumentEngine;
    procedure SetEngine(const Value: TgtCustomDocumentEngine);
  public
    constructor Create(AOwner: TComponent); override;

    property Engine: TgtCustomDocumentEngine read FEngine write SetEngine;
  end;

  { TgtCommonSettings }

  TgtDocSettings = class(TgtBaseComponent)
  private
    FEngineList: TList;
    FBackgroundColor: TColor;
    FBackgroundDisplayType: TgtBackgroundDisplayType;
    FDocInfo: TgtDocInfo;
    FPreferences: TgtPreferences;
    FBackgroundImage: TPicture;
    FPage: TgtPageSettings;
    FMeasurementUnit: TgtUnitType;
    FNativeConversionFactor: Double;

    procedure SetBackgroundColor(const Value: TColor);
    procedure SetBackgroundDisplayType(const Value: TgtBackgroundDisplayType);
    procedure SetBackgroundImage(const Value: TPicture);
    procedure SetMeasurementUnit(const Value: TgtUnitType);

    procedure AddEngineToList(AEngine: TgtCustomDocumentEngine);
    procedure RemoveEngineFromList(AEngine: TgtCustomDocumentEngine);

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

  published
    property BackgroundColor: TColor read FBackgroundColor
      write SetBackgroundColor default CBackgroundColor;
    property BackgroundImage: TPicture read FBackgroundImage
      write SetBackgroundImage;
    property BackgroundImageDisplayType: TgtBackgroundDisplayType
      read FBackgroundDisplayType write SetBackgroundDisplayType;
    property MeasurementUnit: TgtUnitType read FMeasurementUnit
      write SetMeasurementUnit;

    property DocInfo: TgtDocInfo read FDocInfo write FDocInfo;
    property Page: TgtPageSettings read FPage write FPage;
    property Preferences: TgtPreferences read FPreferences write FPreferences;
  end;

  { Global Methods }

function gtPoint(X, Y: Double): TgtPoint;

implementation

uses gtMetafileProcessor, gtDocUtils
{$IFDEF gtActiveX}
    , IniFiles
{$ENDIF};
{ TgtEmailAdapter }

constructor TgtEmailAdapter.Create(AOwner: TComponent);
begin
  inherited;
  FEmailSettings := TgtEmailSettings.Create;
end;

destructor TgtEmailAdapter.Destroy;
begin
  inherited;
  FreeAndNil(FEmailSettings);
end;

function TgtEmailAdapter.GetEMailSettings: TgtEmailSettings;
begin
  Result := FEmailSettings;
end;

procedure TgtEmailAdapter.SetEMailSettings(const Value: TgtEmailSettings);
begin
  FEmailSettings.Assign(Value);
end;

procedure TgtEmailAdapter.SendMail;
begin

end;
{ TgtDocInfo }

procedure TgtDocInfo.Assign(Source: TPersistent);
begin
  if Source is TgtDocInfo then
  begin
    FAuthor := TgtDocInfo(Source).FAuthor;
    FCreator := TgtDocInfo(Source).FCreator;
    FKeywords := TgtDocInfo(Source).FKeywords;
    FSubject := TgtDocInfo(Source).FSubject;
    FTitle := TgtDocInfo(Source).FTitle;
    exit;
  end;
  inherited Assign(Source);
end;

constructor TgtDocInfo.Create(AParent: TgtDocSettings);
begin
  FParent := AParent;
end;

destructor TgtDocInfo.Destroy;
begin

  inherited;
end;

procedure TgtDocInfo.SetAuthor(const Value: WideString);
var
  I: Integer;
begin
  if FParent is TgtDocSettings then
    for I := 0 to TgtDocSettings(FParent).FEngineList.Count - 1 do
      with TgtCustomDocumentEngine(TgtDocSettings(FParent).FEngineList[I]) do
        if (FAuthor = DocInfo.FAuthor) then
          DocInfo.FAuthor := Value;
  FAuthor := Value
end;

procedure TgtDocInfo.SetCreator(const Value: WideString);
var
  I: Integer;
begin
  if FParent is TgtDocSettings then
    for I := 0 to TgtDocSettings(FParent).FEngineList.Count - 1 do
      with TgtCustomDocumentEngine(TgtDocSettings(FParent).FEngineList[I]) do
        if (FCreator = DocInfo.FCreator) then
          DocInfo.FCreator := Value;
  FCreator := Value
end;

procedure TgtDocInfo.SetKeywords(const Value: WideString);
var
  I: Integer;
begin
  if FParent is TgtDocSettings then
    for I := 0 to TgtDocSettings(FParent).FEngineList.Count - 1 do
      with TgtCustomDocumentEngine(TgtDocSettings(FParent).FEngineList[I]) do
        if (FKeywords = DocInfo.FKeywords) then
          DocInfo.FKeywords := Value;
  FKeywords := Value
end;

procedure TgtDocInfo.SetSubject(const Value: WideString);
var
  I: Integer;
begin
  if FParent is TgtDocSettings then
    for I := 0 to TgtDocSettings(FParent).FEngineList.Count - 1 do
      with TgtCustomDocumentEngine(TgtDocSettings(FParent).FEngineList[I]) do
        if (FSubject = DocInfo.FSubject) then
          DocInfo.FSubject := Value;
  FSubject := Value
end;

procedure TgtDocInfo.SetTitle(const Value: WideString);
var
  I: Integer;
begin
  if FParent is TgtDocSettings then
    for I := 0 to TgtDocSettings(FParent).FEngineList.Count - 1 do
      with TgtCustomDocumentEngine(TgtDocSettings(FParent).FEngineList[I]) do
        if (FTitle = DocInfo.FTitle) then
          DocInfo.FTitle := Value;
  FTitle := Value
end;

{ TgtPreferences }

procedure TgtPreferences.Assign(Source: TPersistent);
begin
  if Source is TgtPreferences then
  begin
    FEmailAfterCreate := TgtPreferences(Source).EmailAfterCreate;
    FOpenAfterCreate := TgtPreferences(Source).FOpenAfterCreate;
    FOutputToUserStream := TgtPreferences(Source).FOutputToUserStream;
    FProcessAfterEachPage := TgtPreferences(Source).FProcessAfterEachPage;
    FShowSetupDialog := TgtPreferences(Source).FShowSetupDialog;
    FCalculateVariables := TgtPreferences(Source).FCalculateVariables;
    FUseImagesAsResources := TgtPreferences(Source).FUseImagesAsResources;
    exit;
  end;
  inherited Assign(Source);
end;

constructor TgtPreferences.Create;
begin
  Create(nil)
end;

constructor TgtPreferences.Create(AParent: TgtDocSettings);
begin
  FParent := AParent;
  FShowSetupDialog := True;
  FOpenAfterCreate := True;
  FCalculateVariables := True;
  FUseImagesAsResources := True;
end;

destructor TgtPreferences.Destroy;
begin

  inherited;
end;

procedure TgtPreferences.SetEmailAfterCreate(const Value: Boolean);
var
  I: Integer;
begin
  if FParent is TgtDocSettings then
    for I := 0 to TgtDocSettings(FParent).FEngineList.Count - 1 do
      with TgtCustomDocumentEngine(TgtDocSettings(FParent).FEngineList[I]) do
        if (FEmailAfterCreate = Preferences.FEmailAfterCreate) then
          Preferences.FEmailAfterCreate := Value;
  FEmailAfterCreate := Value
end;

procedure TgtPreferences.SetOpenAfterCreate(const Value: Boolean);
var
  I: Integer;
begin
  if FParent is TgtDocSettings then
    for I := 0 to TgtDocSettings(FParent).FEngineList.Count - 1 do
      with TgtCustomDocumentEngine(TgtDocSettings(FParent).FEngineList[I]) do
        if (FOpenAfterCreate = Preferences.FOpenAfterCreate) then
          Preferences.FOpenAfterCreate := Value;
  FOpenAfterCreate := Value
end;

procedure TgtPreferences.SetOutputToUserStream(const Value: Boolean);
var
  I: Integer;
begin
  if FParent is TgtDocSettings then
    for I := 0 to TgtDocSettings(FParent).FEngineList.Count - 1 do
      with TgtCustomDocumentEngine(TgtDocSettings(FParent).FEngineList[I]) do
        if (FOutputToUserStream = Preferences.FOutputToUserStream) then
          Preferences.FOutputToUserStream := Value;
  FOutputToUserStream := Value
end;

procedure TgtPreferences.SetProcessAfterEachPage(const Value: Boolean);
var
  I: Integer;
begin
  if FParent is TgtDocSettings then
    for I := 0 to TgtDocSettings(FParent).FEngineList.Count - 1 do
      with TgtCustomDocumentEngine(TgtDocSettings(FParent).FEngineList[I]) do
        if (FProcessAfterEachPage = Preferences.FProcessAfterEachPage) then
          Preferences.FProcessAfterEachPage := Value;
  FProcessAfterEachPage := Value
end;

procedure TgtPreferences.SetShowSetupDialog(const Value: Boolean);
var
  I: Integer;
begin
  if FParent is TgtDocSettings then
    for I := 0 to TgtDocSettings(FParent).FEngineList.Count - 1 do
      with TgtCustomDocumentEngine(TgtDocSettings(FParent).FEngineList[I]) do
        if (FShowSetupDialog = Preferences.FShowSetupDialog) then
          Preferences.FShowSetupDialog := Value;
  FShowSetupDialog := Value
end;

procedure TgtPreferences.SetCalculateVariables(const Value: Boolean);
begin
  FCalculateVariables := Value;
end;

procedure TgtPreferences.SetUseImagesAsResources(const Value: Boolean);
var
  I: Integer;
begin
  if FParent is TgtDocSettings then
    for I := 0 to TgtDocSettings(FParent).FEngineList.Count - 1 do
      with TgtCustomDocumentEngine(TgtDocSettings(FParent).FEngineList[I]) do
        if (FUseImagesAsResources = Preferences.FUseImagesAsResources) then
          Preferences.FUseImagesAsResources := Value;
  FUseImagesAsResources := Value
end;

{ TgtCustomDocumentEngine }

constructor TgtCustomDocumentEngine.Create(AOwner: TComponent);
begin

  inherited Create(AOwner);
{$IFDEF gtFileMaker}
{$IFDEF gtActiveX}
{$IFDEF gtPro}
{$I gteDocStatusXPro.INC}
{$ELSE}
{$I gteDocStatusXStd.INC}
{$ENDIF}
{$ELSE}
{$I gteDocStatus.INC}
{$ENDIF}
{$ENDIF}
  CPixelsPerInch := Screen.PixelsPerInch;
  CPointsToPixels := Screen.PixelsPerInch / 72;

  FPreferences := GetPreferencesClassName.Create;

  FFont := TFont.Create;
  FDefaultFont := TFont.Create;
  FPen := TPen.Create;
  FBrush := TBrush.Create;
  FTextEffects := TgtTextEffects.Create;
  FFrame := TgtFrame.Create(Self);

  FPage := TgtPageSettings.Create(Self);
  FPageBorder := TgtBorder.Create;
  FImageSettings := TgtImageSettings.Create(Self);
  FTextFormatting := TgtTextFormatting.Create;
  FTableSettings := TgtTableSettings.Create;
  FBackgroundImage := TPicture.Create;
  FDocInfo := TgtDocInfo.Create(nil);

  FEmailSettings := TgtEmailSettings.Create;
  FEmailAdapter := nil;

  MeasurementUnit := muInches;
  FIsAutoPaginate := True;

  FSetupDialog := nil;
  FSettings := nil;

  FIsDocumentStarted := False;
  FItemsToRender := [irText, irImage, irShape];
  FCapabilities := [ckText, ckImage, ckShape];
  FBackgroundDisplayType := dtCenter;
  FBackgroundColor := CBackgroundColor;
  FReferencePoint := rpBand;
  FInputXRes := Screen.PixelsPerInch;
  FInputYRes := Screen.PixelsPerInch;

  // FSupportsTransformation := False;
{$IFDEF gtActiveX}
  FBackgroundImageEnabled := False;
  FLocalizationFile := 'eDocStrsEN.elf';
{$ENDIF}
  FMD5ImageHash := TgtMD5.Create;
end;

destructor TgtCustomDocumentEngine.Destroy;
begin
  FreeAndNil(FFont);
  FreeAndNil(FDefaultFont);
  FreeAndNil(FPen);
  FreeAndNil(FBrush);
  FreeAndNil(FTextEffects);
  FreeAndNil(FFrame);
  FreeAndNil(FBackgroundImage);
  FreeAndNil(FPage);
  FreeAndNil(FPageBorder);
  FreeAndNil(FImageSettings);
  FreeAndNil(FTableSettings);
  FreeAndNil(FTextFormatting);
  FreeAndNil(FDocInfo);

  FreeAndNil(FEmailSettings);
  // FreeAndNil(FEmailAdapter);
  FreeAndNil(FPreferences);
{$IFDEF gtFileMaker}
  FreeAndNil(FStatusMgr);
{$ENDIF}
  FreeAndNil(FMD5ImageHash);
  inherited;
end;

procedure TgtCustomDocumentEngine.HTMLTextOut(X, Y: Double;
  HTMLStr: WideString);
var
  LFont: TFont;
  LJ, LK: Integer;
  LText, LTag: WideString;
  muCurr: TgtUnitType;
  LB, LI, LU, LS, LSlash: Boolean;
  procedure PrintText(Text: WideString);
  begin
    if not FIsDocumentStarted or not(ckText in Capabilities) or
      not(irText in ItemsToRender) then
      exit;
{$IFNDEF gtRegistered}
{$IFDEF gtFileMaker}
    if (not FStatusMgr.IsException) then
{$ENDIF}
      if FPageCount > CMaxPages then
        exit;
{$ENDIF}
    if IsDocumentItemInRange(X, Y) then
    begin
      FTextItem := TgtTextItem.Create;
      FTextItem.X := X;
      FTextItem.Y := Y;
      FTextItem.Lines.Add(Text);
      FTextItem.Font := Font;
      FTextItem.Brush := Brush;
      FTextItem.RotationAngle := FTextRotationAngle;
      FTextItem.Alignment := FTextAlignment;
      FTextItem.TextEffects := TextEffects;
      AddDocumentItem(FTextItem);
      X := X + (TextSize(Text, Font)).cx;
    end;
  end;

  function SetProperTag(): Boolean;
  begin
    Result := True;
    if AnsiCompareText(LTag, '<B>') = 0 then
    begin
      LFont.Style := LFont.Style + [fsBold];
      LB := True;
    end
    else if AnsiCompareText(LTag, '<U>') = 0 then
    begin
      LFont.Style := LFont.Style + [fsUnderline];
      LU := True;
    end
    else if AnsiCompareText(LTag, '<I>') = 0 then
    begin
      LFont.Style := LFont.Style + [fsItalic];
      LI := True;
    end
    else if AnsiCompareText(LTag, '<S>') = 0 then
    begin
      LFont.Style := LFont.Style + [fsStrikeOut];
      LS := True;
    end
    else if AnsiCompareText(LTag, '</B>') = 0 then
    begin
      LFont.Style := LFont.Style - [fsBold];
      LB := False;
    end
    else if AnsiCompareText(LTag, '</U>') = 0 then
    begin
      LFont.Style := LFont.Style - [fsUnderline];
      LU := False;
    end
    else if AnsiCompareText(LTag, '</I>') = 0 then
    begin
      LFont.Style := LFont.Style - [fsItalic];
      LI := False;
    end
    else if AnsiCompareText(LTag, '</S>') = 0 then
    begin
      LFont.Style := LFont.Style - [fsStrikeOut];
      LS := False;
    end
    else
      Result := False;
  end;

begin
  FNoSorting := False;
  muCurr := Self.MeasurementUnit;
  case muCurr of
    muInches:
      begin
        X := X * CInchesToPoints;
        Y := Y * CInchesToPoints;
      end;
    muMM:
      begin
        X := X * CMMToPoints;
        Y := Y * CMMToPoints;
      end;
    muTwips:
      begin
        X := X * CTwipsToPoints;
        Y := Y * CTwipsToPoints;
      end;
  end;
  if Ord(muCurr) <> Ord(muPixels) then
  begin
    X := PointsToPixels(X);
    Y := PointsToPixels(Y);
  end;
  // Holds the current Measurement Unit
  Self.MeasurementUnit := muPixels;
  LFont := Self.Font;
  LK := 1;
  // Setting the 'X' and 'Y' Co-ordinates
  X := NativeXPos(X) + FBandRect.Left;
  Y := NativeYPos(Y) + FBandRect.Top;
  // Flags for each tag.
  LB := False;
  LI := False;
  LU := False;
  LS := False;
  LSlash := False;
  while LK <= Length(HTMLStr) do
  begin
    case HTMLStr[LK] of
      '<':
        if (LK <> 1) and (HTMLStr[LK - 1] = '/') and not LSlash then
        begin
          LText := LText + HTMLStr[LK];
        end
        else
        begin
          PrintText(LText);
          LText := '';
          LJ := 0;
          LTag := '';
          while (HTMLStr[LK + LJ] <> '>') and (HTMLStr[LK + LJ] <> ' ') and
            ((LK + LJ) <= Length(HTMLStr)) do
          begin
            LTag := LTag + HTMLStr[LK + LJ];
            Inc(LJ);
          end;
          if (HTMLStr[LK + LJ] = '>') then
          begin
            LTag := LTag + HTMLStr[LK + LJ];
            LK := LK + LJ;
            SetProperTag;
          end;
        end;
      '/':
        if (HTMLStr[LK + 1] = '/') then
        begin
          LText := LText + HTMLStr[LK];
          Inc(LK);
          LSlash := True;
        end
        else
          LSlash := False;
      '>':
        if (LK <> 0) and (HTMLStr[LK - 1] = '/') and not LSlash then
        begin
          LText := LText + HTMLStr[LK];
        end;
    else
      LText := LText + HTMLStr[LK];
    end;
    Inc(LK);
  end;
  PrintText(LText);
  // If any of the tags have not been ended they are ended here.
  if LK > Length(HTMLStr) then
  begin
    if LB = True then
      LFont.Style := LFont.Style - [fsBold];
    if LU = True then
      LFont.Style := LFont.Style - [fsUnderline];
    if LI = True then
      LFont.Style := LFont.Style - [fsItalic];
    if LS = True then
      LFont.Style := LFont.Style - [fsStrikeOut];
  end;
  MeasurementUnit := muCurr;
end;

procedure TgtCustomDocumentEngine.TextOut(X, Y: Double; Text: WideString);
begin
  if not FIsDocumentStarted or not(ckText in Capabilities) or
    not(irText in ItemsToRender) then
    exit;
  FNoSorting := False;
{$IFNDEF gtRegistered}
{$IFDEF gtFileMaker}
  if (not FStatusMgr.IsException) then
{$ENDIF}
    if FPageCount > CMaxPages then
      exit;
{$ENDIF}
  X := NativeXPos(X) + FBandRect.Left;
  Y := NativeYPos(Y) + FBandRect.Top;
  if IsDocumentItemInRange(X, Y) then
  begin
    FTextItem := TgtTextItem.Create;
    FTextItem.X := X;
    FTextItem.Y := Y;
    FTextItem.Lines.Add(Text);
    FTextItem.Font := Font;
    FTextItem.Brush := Brush;
    FTextItem.RotationAngle := FTextRotationAngle;
    FTextItem.Alignment := FTextAlignment;
    FTextItem.TextEffects := TextEffects;
    FTextItem.BiDiMode := BiDiMode;
    AddDocumentItem(FTextItem);
  end;
end;

procedure TgtCustomDocumentEngine.SetTextRotation(Angle: Integer);
begin
  FTextRotationAngle := Angle mod 360;
end;

procedure TgtCustomDocumentEngine.TextBox(TextRect: TgtRect; Text: WideString;
  HAlignment: TgtHAlignment; VAlignment: TgtVAlignment);
var
  FTextBoxItem: TgtTextBoxItem;
  LWidth: Double;
begin
  if not FIsDocumentStarted or not(ckText in Capabilities) or
    not(irText in ItemsToRender) then
    exit;
  FNoSorting := False;
{$IFNDEF gtRegistered}
{$IFDEF gtFileMaker}
  if (not FStatusMgr.IsException) then
{$ENDIF}
    if FPageCount > CMaxPages then
      exit;
{$ENDIF}
  TextRect := NativeRect(TextRect);
  TextRect.Left := TextRect.Left + FBandRect.Left;
  TextRect.Top := TextRect.Top + FBandRect.Top;

  if IsDocumentItemInRange(TextRect.Left, TextRect.Top) then
  begin
    TextRect.Right := TextRect.Right + FBandRect.Left;
    if TextRect.Right > FBandRect.Right then
      TextRect.Right := FBandRect.Right;

    TextRect.Bottom := TextRect.Bottom + FBandRect.Top;
    if TextRect.Bottom > FBandRect.Bottom then
      TextRect.Bottom := FBandRect.Bottom;

    FTextBoxItem := TgtTextBoxItem.Create;
    FTextBoxItem.X := TextRect.Left;
    FTextBoxItem.Y := TextRect.Top;
    FTextBoxItem.Font := Font;
    FTextBoxItem.Brush := Brush;
    FTextBoxItem.Pen := Pen;
    FTextBoxItem.Frame := FFrame;
    FTextBoxItem.BoxWidth := TextRect.Right - TextRect.Left;
    FTextBoxItem.Boxheight := TextRect.Bottom - TextRect.Top;
    FTextBoxItem.HAlign := HAlignment;
    FTextBoxItem.VAlign := VAlignment;

    with FTextBoxItem do
    begin
      LWidth := BoxWidth - Frame.InternalMargin.Left -
        Frame.InternalMargin.Right;
      WrapTextIntoLines(ReplacePlaceHolders(Text, False), LWidth, LWidth, Lines,
        False, Font);
    end;
    AddDocumentItem(FTextBoxItem);
  end;
end;

procedure TgtCustomDocumentEngine.ExportRichText(FilePath: String;
  ALeft, ATop, ARight, ABottom: Double; StartPos, EndPos: Integer;
  BackgroundColor: TColor);
var
{$IFDEF JediRichEdit}
  RichEdit: TJvRichEdit;
{$ELSE} {$IFDEF RichEdit98}
  RichEdit: TRichEdit98;
{$ELSE}
  RichEdit: TRichEdit;
{$ENDIF}
{$ENDIF}
  LForm: TForm;
begin
  LForm := TForm.Create(Self);
{$IFDEF JediRichEdit}
  RichEdit := TJvRichEdit.Create(Self);
{$ELSE} {$IFDEF RichEdit98}
  RichEdit := TRichEdit98.Create(Self);;
{$ELSE}
  RichEdit := TRichEdit.Create(Self);;
{$ENDIF}
{$ENDIF}
  try
    RichEdit.Parent := LForm;
    RichEdit.Visible := False;
    RichEdit.Lines.LoadFromFile(FilePath);
    DrawRichText(RichEdit, ALeft, ATop, ARight, ABottom, StartPos, EndPos,
      BackgroundColor);
  finally
    RichEdit.Destroy;
    LForm.Free;
  end;
end;

procedure TgtCustomDocumentEngine.ExportRichText(FileStream: TStream;
  ALeft, ATop, ARight, ABottom: Double; StartPos, EndPos: Integer;
  BackgroundColor: TColor);
var
{$IFDEF JediRichEdit}
  RichEdit: TJvRichEdit;
{$ELSE} {$IFDEF RichEdit98}
  RichEdit: TRichEdit98;
{$ELSE}
  RichEdit: TRichEdit;
{$ENDIF}
{$ENDIF}
  LForm: TForm;
begin
  LForm := TForm.Create(Self);
{$IFDEF JediRichEdit}
  RichEdit := TJvRichEdit.Create(Self);
{$ELSE} {$IFDEF RichEdit98}
  RichEdit := TRichEdit98.Create(Self);;
{$ELSE}
  RichEdit := TRichEdit.Create(Self);;
{$ENDIF}
{$ENDIF}
  try
    RichEdit.Parent := LForm;
    RichEdit.Visible := False;
    FileStream.Position := 0;

    RichEdit.Lines.LoadFromStream(FileStream);
    DrawRichText(RichEdit, ALeft, ATop, ARight, ABottom, StartPos, EndPos,
      BackgroundColor);

  finally
    RichEdit.Destroy;
    LForm.Destroy;
  end;
end;
{$IFDEF JediRichEdit}

function PrintToCanvas(ACanvas: TCanvas; FromChar, ToChar: Integer;
  RichHandle: HWND; DisplayRect: TRect; Measure: Boolean): Longint;
var
  Range: TFormatRange;
begin
  FillChar(Range, SizeOf(TFormatRange), 0);
  Range.hdc := ACanvas.handle;
  Range.hdcTarget := ACanvas.handle;
  Range.rc.Left := DisplayRect.Left * 1440 div CPixelsPerInch;;
  Range.rc.Top := DisplayRect.Top * 1440 div CPixelsPerInch;;
  Range.rc.Right := Range.rc.Left + Round(DisplayRect.Right - DisplayRect.Left)
    * 1440 div CPixelsPerInch;
  Range.rc.Bottom := Range.rc.Top + Round(DisplayRect.Bottom - DisplayRect.Top)
    * 1440 div CPixelsPerInch;
  Range.rcPage := Range.rc;
  Range.chrg.cpMax := ToChar;
  Range.chrg.cpMin := FromChar;
  if Measure then
    Result := SendMessage(RichHandle, EM_FORMATRANGE, 1, Longint(@Range))
  else
    Result := SendMessage(RichHandle, EM_FORMATRANGE, 0, Longint(@Range));
  SendMessage(RichHandle, EM_FORMATRANGE, 0, 0);
end;

procedure TgtCustomDocumentEngine.DrawRichText(RichEdit: TJvRichEdit;
  ALeft, ATop, ARight, ABottom: Double; StartPos, EndPos: Integer;
  BackgroundColor: TColor);
var
  LI, LTemp: Integer;
  LStartPres: Integer;
  LDisplayRect: TRect;
  LMetafile: TMetafile;
  LMetafileCanvas: TMetafileCanvas;
  LUnit: TgtUnitType;
begin
  if not FIsDocumentStarted then
    exit;

  if (Canvas = nil) then
    exit;

  ALeft := NativeXPos(ALeft) + FBandRect.Left;
  ATop := NativeXPos(ATop) + FBandRect.Top;
  ARight := NativeYPos(ARight) + FBandRect.Left;
  ABottom := NativeYPos(ABottom) + FBandRect.Top;

  for LI := 0 to RichEdit.Lines.Count do
  begin
    RichEdit.CaretPos := Point(0, LI);
    if RichEdit.Paragraph.Alignment = paJustify then
      RichEdit.Paragraph.Alignment := paJustify;
  end;

  LDisplayRect := Rect(0, 0, Round(Abs(ALeft - ARight)),
    Round(Abs(ATop - ABottom)));
  LStartPres := StartPos;
  while (True) do
  begin
    LMetafile := TMetafile.Create;
    try
      LMetafile.Width := Round(Abs(ALeft - ARight));
      LMetafile.Height := Round(Abs(ATop - ABottom));
      LMetafileCanvas := TMetafileCanvas.Create(LMetafile, 0);

      try
        if BackgroundColor <> clWhite then
        begin
          LMetafileCanvas.Brush.Color := BackgroundColor;
          LMetafileCanvas.FillRect(LDisplayRect);
        end;
        LStartPres := PrintToCanvas(LMetafileCanvas, LStartPres, EndPos,
          RichEdit.handle, LDisplayRect, True);
        LTemp := PrintToCanvas(LMetafileCanvas, LStartPres, EndPos,
          RichEdit.handle, LDisplayRect, False);
      finally
        LMetafileCanvas.Free;
      end;

      LUnit := MeasurementUnit;
      MeasurementUnit := muPixels;
      PlayMetafile(ALeft, ATop, LMetafile);
    finally
      LMetafile.Free;
    end;
    MeasurementUnit := LUnit;
    if (LTemp - LStartPres > 1) then
      NewPage
    else
      Break;
  end;
end;
{$ENDIF}
{$IFDEF RichEdit98}

procedure TgtCustomDocumentEngine.DrawRichText(RichEdit: TRichEdit98;
  ALeft, ATop, ARight, ABottom: Double; StartPos, EndPos: Integer;
  BackgroundColor: TColor);
var
  LFmtRange: TFormatRange;
  SaveRect: TRect;
  LastChar, MaxLen: Integer;
  LRect: TRect;
begin
  if not FIsDocumentStarted then
    exit;

  if (Canvas = nil) then
    exit;

  ALeft := NativeXPos(ALeft);
  ATop := NativeXPos(ATop);
  ARight := NativeYPos(ARight);
  ABottom := NativeYPos(ABottom);

  with LFmtRange, RichEdit do
  begin
    rc.Left := Round(ALeft) * 1440 div CPixelsPerInch;
    rc.Top := Round(ATop) * 1440 div CPixelsPerInch;
    rc.Right := rc.Left + Round(ARight - ALeft) * 1440 div CPixelsPerInch;
    rc.Bottom := rc.Top + Round(ABottom - ATop) * 1440 div CPixelsPerInch;
    rcPage := rc;
    // Assign Engine's Canvas.Handle to hdc
    hdc := Canvas.handle;
    hdcTarget := hdc;
    rcPage := rc;
    SaveRect := rc;
    LastChar := StartPos;
    MaxLen := GetTextLen - 1;
    chrg.cpMax := EndPos;
    repeat
      if BackgroundColor <> clWhite then
      begin
        Canvas.Brush.Color := BackgroundColor;
        with LRect do
        begin
          LRect.Left := Round((rc.Left * 96) / 1440);
          LRect.Top := Round((rc.Top * 96) / 1440);
          LRect.Right := Round((rc.Right * 96) / 1440);
          LRect.Bottom := Round((rc.Bottom * 96) / 1440);
        end;
        Canvas.FillRect(LRect);
      end;
      rc := SaveRect;
      chrg.cpMin := LastChar;
      RichEdit.Color := BackgroundColor;
      LastChar := SendMessage(RichEdit.handle, EM_FORMATRANGE, 1,
        Longint(@LFmtRange));
      if (LastChar < MaxLen) and (LastChar <> -1) then
      begin
        // Call NewPage if more characters are there
        NewPage;
        hdc := Canvas.handle;
        hdcTarget := hdc;
      end;
    until (LastChar >= MaxLen) or (LastChar = -1);
    SendMessage(RichEdit.handle, EM_FORMATRANGE, 0, 0);
  end;
end;
{$ENDIF}

procedure TgtCustomDocumentEngine.DrawRichText(RichEdit: TRichEdit;
  ALeft, ATop, ARight, ABottom: Double; StartPos, EndPos: Integer;
  BackgroundColor: TColor);
var
  LFmtRange: TFormatRange;
  SaveRect: TRect;
  LastChar, MaxLen: Integer;
  LRect: TRect;
begin
  if not FIsDocumentStarted then
    exit;

  if (Canvas = nil) then
    exit;

  ALeft := NativeXPos(ALeft);
  ATop := NativeXPos(ATop);
  ARight := NativeYPos(ARight);
  ABottom := NativeYPos(ABottom);

  with LFmtRange, RichEdit do
  begin
    rc.Left := Round(ALeft) * 1440 div CPixelsPerInch;
    rc.Top := Round(ATop) * 1440 div CPixelsPerInch;
    rc.Right := rc.Left + Round(ARight - ALeft) * 1440 div CPixelsPerInch;
    rc.Bottom := rc.Top + Round(ABottom - ATop) * 1440 div CPixelsPerInch;
    rcPage := rc;
    // Assign Engine's Canvas.Handle to hdc
    hdc := Canvas.handle;
    hdcTarget := hdc;
    rcPage := rc;
    SaveRect := rc;
    LastChar := StartPos;
    MaxLen := GetTextLen - (Lines.Count * 2);
    // MaxLen := GetTextLen-1;
    chrg.cpMax := EndPos;
    repeat
      if BackgroundColor <> clWhite then
      begin
        Canvas.Brush.Color := BackgroundColor;
        with LRect do
        begin
          LRect.Left := Round((rc.Left * 96) / 1440);
          LRect.Top := Round((rc.Top * 96) / 1440);
          LRect.Right := Round((rc.Right * 96) / 1440);
          LRect.Bottom := Round((rc.Bottom * 96) / 1440);
        end;
        Canvas.FillRect(LRect);
      end;
      rc := SaveRect;
      chrg.cpMin := LastChar;
      RichEdit.Color := BackgroundColor;

      LastChar := SendMessage(RichEdit.handle, EM_FORMATRANGE, 1,
        Longint(@LFmtRange));
      MaxLen := MaxLen - LastChar;
      if ((LastChar < MaxLen) and (LastChar <> -1) and
        (LastChar >= chrg.cpMin)) then
      begin
        SendMessage(RichEdit.handle, EM_FORMATRANGE, 0, 0);
        // Call NewPage if more characters are there
        NewPage;
        hdc := Canvas.handle;
        hdcTarget := hdc;
      end
      else
        Break;
    until (False);
    SendMessage(RichEdit.handle, EM_FORMATRANGE, 0, 0);
  end;
end;

function TgtCustomDocumentEngine.TextOut(Text: WideString): Double;
var
  LCount, I, ParaNo, Temppos: Integer;
  TmpStr: WideString;
  Res, LY1: Double;
begin
  Result := 0;
  ParaNo := 0;
  if not FIsDocumentStarted or not(ckText in Capabilities) or
    not(irText in ItemsToRender) or not FIsParagraphStarted then
    exit;
  FNoSorting := False;
{$IFNDEF gtRegistered}
{$IFDEF gtFileMaker}
  if (not FStatusMgr.IsException) then
{$ENDIF}
    if FPageCount > CMaxPages then
      exit;
{$ENDIF}
  if not FIsParaStarted[0] then
  begin
    with FParagraphItem do
    begin
      WrapTextIntoLines(ReplacePlaceHolders(Text, False), Width,
        Width - Settings.FirstLineIndent, Lines, False, Font);
      Result := Height - Lines.Count * TextSize('W', Font).cy *
        Settings.LineSpacing;
    end;
  end;

  if FIsParaStarted[0] then
  begin
    I := 0;
    while FIsParaStarted[I] do
    begin
      I := I + 1;
    end;
    ParaNo := I - 1;
    with FParaItem[ParaNo] do
    begin
      WrapTextIntoLines(ReplacePlaceHolders(Text, False), Width,
        Width - Settings.FirstLineIndent, Lines, False, Font);
      Result := Height - Lines.Count * TextSize('W', Font).cy *
        Settings.LineSpacing;
    end;
    ParaNo := ParaNo + 1;
  end;

  if (Result <= 0) then
  begin
    Res := Result;
    while (Res <= 0) do
    begin
      LY1 := FBandRect.Top;
      SetLength(FParaItem, ParaNo + 2);
      FParaItem[ParaNo] := TgtParagraphItem.Create;
      SetLength(FIsParaStarted, ParaNo + 2);
      FIsParaStarted[ParaNo] := True;
      FIsParaStarted[ParaNo + 1] := False;

      FParaItem[ParaNo].X := FBandRect.Left;
      FParaItem[ParaNo].Y := LY1;
      FParaItem[ParaNo].Settings := FTextFormatting;
      FParaItem[ParaNo].Font := Font;
      FParaItem[ParaNo].Brush := Brush;
      FParaItem[ParaNo].TextEffects := TextEffects;

      FParaItem[ParaNo].Width := FBandRect.Right - FParaItem[ParaNo].X -
        FParaItem[ParaNo].Settings.RightIndent - FParaItem[ParaNo]
        .Settings.LeftIndent;
      FParaItem[ParaNo].Height := FBandRect.Bottom - FParaItem[ParaNo].Y;

      // Put extra text to new para
      TmpStr := '';
      if ParaNo = 0 then
      begin
        LCount := Ceil(Abs(Res) / (TextSize('W', Font).cy *
          FParagraphItem.Settings.LineSpacing));
        Temppos := FParagraphItem.Lines.Count - LCount;
        for I := Temppos to FParagraphItem.Lines.Count - 1 do
        begin
          if I = Temppos then
            TmpStr := TmpStr + FParagraphItem.Lines.Strings[Temppos]
          else
            TmpStr := TmpStr + FParagraphItem.Lines.Strings[Temppos];
          FParagraphItem.Lines.Delete(Temppos);
        end;
      end;

      if ParaNo > 0 then
      begin
        LCount := Ceil(Abs(Res) / (TextSize('W', Font).cy * FParaItem
          [ParaNo - 1].Settings.LineSpacing));
        Temppos := FParaItem[ParaNo - 1].Lines.Count - LCount - 1;
        for I := Temppos to FParaItem[ParaNo - 1].Lines.Count - 1 do
        begin
          if I = Temppos then
            TmpStr := TmpStr + FParaItem[ParaNo - 1].Lines.Strings[Temppos]
          else
            TmpStr := TmpStr + FParaItem[ParaNo - 1].Lines.Strings[Temppos];
          FParaItem[ParaNo - 1].Lines.Delete(Temppos);
        end;
      end;
      if (FBandType = btFooter) then
      begin
        Result := -1;
        Break;
      end
      else
      begin
        with FParaItem[ParaNo] do
        begin
          WrapTextIntoLines(ReplacePlaceHolders(TmpStr, False), Width,
            Width - Settings.FirstLineIndent, Lines, False, Font);
          Res := Height - Lines.Count * TextSize('W', Font).cy *
            Settings.LineSpacing;
        end;
        ParaNo := ParaNo + 1;
        Result := Res;
      end;
    end;
  end;
  Result := Result / FNativeConversionFactor;
end;

procedure TgtCustomDocumentEngine.TextOut(ColumnNo: Integer; Text: WideString);
var
  LHeight, LWidth: Longint;
begin
  if not FIsDocumentStarted or not(ckText in Capabilities) or
    not(irText in ItemsToRender) then
    exit;
  FNoSorting := False;

  if FIsTableStarted and (FTableItem.RowCount >= 0) and
    ((ColumnNo >= 0) and (ColumnNo < FTableItem.ColCount)) then
  begin
    FTextItem := TgtTextItem.Create;
    FTextItem.X := ColumnNo;
    FTextItem.Y := FTableItem.RowCount;
    FTextItem.Font := Font;
    FTextItem.Brush := Brush;
    FTextItem.BiDiMode := BiDiMode;

    with FTableItem do
    begin
      LWidth := Round(Columns[ColumnNo].Width) -
        Round(Settings.InternalMargin.Left) -
        Round(Settings.InternalMargin.Right);

      LWidth := WrapTextIntoLines(ReplacePlaceHolders(Text, False), LWidth,
        LWidth, FTextItem.Lines, Settings.AutoAdjustColumnWidth, FTextItem.Font)
        + Round(Settings.InternalMargin.Left) +
        Round(Settings.InternalMargin.Right);

      if (Settings.AutoAdjustColumnWidth and
        (Columns[ColumnNo].Width < LWidth)) then
        Columns[ColumnNo].Width := LWidth;

      LHeight := Round(FTextItem.Lines.Count * TextSize('W', FTextItem.Font).cy)
        + Round(Settings.InternalMargin.Top) +
        Round(Settings.InternalMargin.Bottom);
      if Int64(RowHeights[RowCount]) < LHeight then
        RowHeights[RowCount] := TObject(LHeight);
      RowItemsList[RowCount].Add(FTextItem);
    end;
  end;
end;

procedure TgtCustomDocumentEngine.BeginDoc;
var
  LStatus: Integer;
begin
  FNoSorting := False;
  if FIsDocumentStarted then
    exit;

  LStatus := mrOk;
{$IFDEF gtActiveX}
  LoadLocalizedStrings;
{$ENDIF}
  if Assigned(FOnBeforeBeginDoc) then
    OnBeforeBeginDoc(Self);

  if Preferences.ShowSetupDialog then
  begin
    if Assigned(FSetupDialog) then
    begin
      FSetupDialog.Engine := Self;
      Application.NormalizeTopMosts;
      LStatus := FSetupDialog.ShowModal;
      Application.RestoreTopMosts;
      FSetupDialog.Engine := nil;
    end
    else
      LStatus := ShowSetupModal;
  end;

  if LStatus = mrCancel then { If Creation is cancelled. }
  begin
    FEngineStatus := esCancelled;
    exit;
  end;
  { //Wrong ?
    if Assigned(FOnBeforeBeginDoc) then
    OnBeforeBeginDoc(Self);
  }
  InitializeEngine;

  NewPage; // To create blanck page

  Start;

  FEngineStatus := esStarted;
  FTablenumber := -1;
{$IFNDEF gtRegistered}
{$IFDEF gtFileMaker}
  if (not FStatusMgr.IsException) then
{$ENDIF}
    PutTrialNote;
{$ENDIF}
  if Assigned(FOnAfterBeginDoc) then
    OnAfterBeginDoc(Self);
end;

procedure TgtCustomDocumentEngine.EndDoc;
var
  I: Integer;
  // {$IFDEF EMailSupport}
  // LContinue, LCancelEMail: Boolean;
  // LEMailSettings: TgtEmailSettings;
  // {$ENDIF}
  // {$IFDEF EMailWithIndy}
  // IdMessage: TIdMessage;
  // IdSMTP: TIdSMTP;
  //
  // function GetAddressString(AText: String): String;
  // begin
  // if Length(AText) = 0 then
  // begin
  // Result := '';
  // exit;
  // end;
  // Result := Trim(AText);
  // Result := StringReplace(Result, CRLF, ';', [rfReplaceAll]);
  // if (Result <> '') and (Result[Length(Result)] = ';') then
  // System.Delete(Result, Length(Result), 1);
  // end;
  // {$ENDIF}

begin
  if not FIsDocumentStarted then
    exit;
  if FPages.Count >= FCurrentPage then
  begin
    if not(Preferences.ProcessAfterEachPage) then
    begin
      Canvas.Free;
      Canvas := nil;
      ProcessMetafile(0, 0, FMetafile);
    end;

    // Wrong?
    // if Assigned(FOnBeforeEndDoc) then  {Trigger : Document is Created}
    // OnBeforeEndDoc(Self);

    if Preferences.ProcessAfterEachPage then
      ProcessPage // Process last page.
    else
      for I := 1 to FPages.Count do
      begin
        FCurrentPage := I;
        ProcessPage; // Process each page.
      end;

    if Assigned(FOnBeforeEndDoc) then { Trigger : Document is Created }
      OnBeforeEndDoc(Self);

    FPages.Clear;

    Finish; { Document processing is complete }
    if Assigned(FOnAfterEndDoc) then
      OnAfterEndDoc(Self);

    { To open created document. }
    if Preferences.OpenAfterCreate and (EngineFileNames.Count <> 0) then
      ShellExecute(Application.handle, 'Open', PChar(EngineFileNames[0]), nil,
        nil, SW_SHOWNORMAL);

    // { To EMail created document. }

    if Preferences.EmailAfterCreate then
    begin
      CreateEMailSettingsObj;
      SendMail;
    end;
    FinalizeEngine;
    FEngineStatus := esFinished;
  end;
end;

procedure TgtCustomDocumentEngine.NewPage;
var
  PageItem: TgtPageItem;
begin
  if not FIsDocumentStarted then
    exit;
{$IFNDEF gtRegistered}
{$IFDEF gtFileMaker}
  if (not FStatusMgr.IsException) then
{$ENDIF}
    if FPageCount > CMaxPages then
      exit;
{$ENDIF}
  if AbortCreation then
  begin
    Preferences.OpenAfterCreate := False;
    EndDoc;
    AbortCreation := False;
    exit;
  end;
  if FCurrentPage > 0 then
  begin
    Pages[FCurrentPage - 1].FOffsetY := FCurrentOffsetY;
    if not(Preferences.ProcessAfterEachPage) then
    begin
      Canvas.Free;
      Canvas := nil;
      ProcessMetafile(0, 0, FMetafile);
    end;
  end;

  if Preferences.ProcessAfterEachPage and (FCurrentPage <> 0) then
  begin
    ProcessPage; // Process current page.
  end;

  Inc(FPageCount);

  FCurrentPage := FPageCount;
  PageItem := TgtPageItem.Create(Self);

  PageItem.Settings := FPage;
  with PageItem do
  begin
    FCurrentDocumentItemList := FDocumentItems;
    FCurrentTextItemList := FTextItems;
    FCurrentOffsetY := FOffsetY;
  end;

  with PageItem.Settings do
  begin
    FMetafile.Width := Round(Width);
    FMetafile.Height := Round(Height);
  end;
  Canvas := TMetafileCanvas.Create(FMetafile, 0);

  FPages.Add(PageItem);
  BandType := btContent;
end;

procedure TgtCustomDocumentEngine.SetPreferences(const Value: TgtPreferences);
begin
  FPreferences.Assign(Value);
end;

procedure TgtCustomDocumentEngine.SetImageSettings
  (const Value: TgtImageSettings);
begin
  FImageSettings.Assign(Value);
end;

procedure TgtCustomDocumentEngine.SetTextFormatting
  (const Value: TgtTextFormatting);
begin
  FTextFormatting := Value;
  with FTextFormatting do
  begin
    FLeftIndent := FLeftIndent * FNativeConversionFactor;
    FRightIndent := FRightIndent * FNativeConversionFactor;
    FFirstLineIndent := FFirstLineIndent * FNativeConversionFactor;
  end;
end;

procedure TgtCustomDocumentEngine.SetTableSettings
  (const Value: TgtTableSettings);
begin
  with FTableSettings do
  begin
    FColumnWidth := Value.FColumnWidth * FNativeConversionFactor;
    FRowHeight := Value.FRowHeight * FNativeConversionFactor;
    FTitleHeight := Value.FTitleHeight * FNativeConversionFactor;
    FAutoAdjustColumnWidth := Value.FAutoAdjustColumnWidth;
    FEnableTitle := Value.FEnableTitle;
    FInternalMargin := gtRect(Value.FInternalMargin, FNativeConversionFactor);
  end;
end;

procedure TgtCustomDocumentEngine.EndPage;
begin
end;

procedure TgtCustomDocumentEngine.FreeItemsList(AList: TList);
var
  I: Integer;
  DocItem: TgtDocumentItem;
begin
  for I := 0 to AList.Count - 1 do
  begin
    DocItem := TgtDocumentItem(AList.Items[I]);
    if DocItem is TgtTableItem then
    begin
      if TableOnLastpage[FTablenumber] then
        TgtDocumentItem(AList.Items[I]).Free;
    end
    else
      TgtDocumentItem(AList.Items[I]).Free;
  end;
end;

// ::EDIT::BEGIN::gs-soft
procedure TgtCustomDocumentEngine.PreProcessPages;
var
  iPages: Integer;
begin
  AdjustTextItemList(FHeaderItem.FTextItems);
  AdjustTextItemList(FFooterItem.FTextItems);
  AdjustTextItemList(FWatermarkItem.FTextItems);
  AdjustTextItemList(FStampItem.FTextItems);

  for iPages := 0 to FPages.Count - 1 do
    AdjustTextItemList(TgtPageItem(FPages.Items[iPages]).FTextItems);
end;
// ::EDIT::END::gs-soft

procedure TgtCustomDocumentEngine.ProcessItemsList(AList: TList);
var
  I: Integer;
  l_ShapeItem: TgtShapeItem;
  DocItem: TgtDocumentItem;
begin
  for I := 0 to AList.Count - 1 do
  begin
    DocItem := TgtDocumentItem(AList.Items[I]);
    if DocItem is TgtTextBoxItem then
      EncodeTextBox(TgtTextBoxItem(DocItem))
    else if DocItem is TgtTextItem then
      EncodeText(TgtTextItem(DocItem))
    else if DocItem is TgtImageStream then
      EncodeImageStream(TgtImageStream(DocItem))
    else if DocItem is TgtImageItem then
      EncodeImage(TgtImageItem(DocItem))
    else if DocItem is TgtShapeItem then
    begin
      l_ShapeItem := TgtShapeItem(DocItem);
      FPenJoin := l_ShapeItem.FPenJoinStyle;
      FPenCap := l_ShapeItem.FPenCapStyle;
      EncodeShape(l_ShapeItem);
    end
    else if DocItem is TgtPolyShapeItem then
      EncodePolyShape(TgtPolyShapeItem(DocItem))
    else if DocItem is TgtTableItem then
      EncodeTable(TgtTableItem(DocItem))
    else if DocItem is TgtParagraphItem then
      EncodeParagraph(TgtParagraphItem(DocItem))
    else if DocItem is TgtClipItem then
      EncodeClipRect(TgtClipItem(DocItem))
    else if DocItem is TgtPathItem then
      EncodePathItem(TgtPathItem(DocItem))
    else if DocItem is TgtPolyPolygonItem then
      EncodePolyPolygon(TgtPolyPolygonItem(DocItem))
    else if DocItem is TgtEOFItem then
      EncodeEOF(TgtEOFItem(DocItem))
    else if DocItem is TgtPolyDrawItem then
      EncodePolyDraw(TgtPolyDrawItem(DocItem))
      // else if DocItem is TgtTransformationItem then
      // EncodeTransformationItem(TgtTransformationItem(DocItem))
    else
      EncodeCustomItem(DocItem);
  end;
end;

procedure TgtCustomDocumentEngine.EncodeImage(AObject: TgtImageItem);
begin

end;

procedure TgtCustomDocumentEngine.EncodeImageStream;
begin

end;

procedure TgtCustomDocumentEngine.EncodeClipRect(AObject: TgtClipItem);
begin

end;

procedure TgtCustomDocumentEngine.EncodePathItem(AObject: TgtPathItem);
begin

end;

{
  Write paragraph if it is not supported as paragraph in descendent engines.
  For each line calculate Proper X and Y values and then call EncodeText.
}
procedure TgtCustomDocumentEngine.EncodeParagraph(AObject: TgtParagraphItem);
var
  I: Integer;
  LTextItem: TgtTextItem;
  LWidth: Extended;
  LS: WideString;
begin
  LTextItem := TgtTextItem.Create;
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
      case AObject.Settings.Alignment of
        haRight:
          begin
            LTextItem.X := LTextItem.X + LWidth - TextSize(Lines[I], Font).cx;
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

{ For each shape item, according to shape type call methods to
  encode perticular shape. }
procedure TgtCustomDocumentEngine.EncodeShape(AObject: TgtShapeItem);
var
  LPoints: TgtPoints;
begin
  LPoints := AObject.GetPoints;
  if (Length(LPoints)) = 0 then
    exit;
  case AObject.ShapeType of
    stLine:
      EncodeLine(LPoints[0].X, LPoints[0].Y, LPoints[1].X, LPoints[1].Y,
        AObject.Pen);

    stRectangle, stRectangleRgn:
      EncodeRect(LPoints[0].X, LPoints[0].Y, LPoints[1].X, LPoints[1].Y,
        AObject.Pen, AObject.Brush);

    stRoundRect:
      EncodeRoundRect(LPoints[0].X, LPoints[0].Y, LPoints[1].X, LPoints[1].Y,
        LPoints[2].X, LPoints[2].Y, AObject.Pen, AObject.Brush);

    stEllipse:
      EncodeEllipse(LPoints[0].X, LPoints[0].Y, LPoints[1].X, LPoints[1].Y,
        AObject.Pen, AObject.Brush);

    stPolygon:
      EncodePolyLine(LPoints, AObject.NoPoints, True, AObject.Pen,
        AObject.Brush);

    stPolyLine:
      EncodePolyLine(LPoints, AObject.NoPoints, False, AObject.Pen,
        AObject.Brush);

    stArc:
      EncodeArc(LPoints[0].X, LPoints[0].Y, LPoints[1].X, LPoints[1].Y,
        LPoints[2].X, LPoints[2].Y, LPoints[3].X, LPoints[3].Y, AObject.Pen);

    stChord:
      EncodeChord(LPoints[0].X, LPoints[0].Y, LPoints[1].X, LPoints[1].Y,
        LPoints[2].X, LPoints[2].Y, LPoints[3].X, LPoints[3].Y, AObject.Pen,
        AObject.Brush);

    stPie:
      EncodePie(LPoints[0].X, LPoints[0].Y, LPoints[1].X, LPoints[1].Y,
        LPoints[2].X, LPoints[2].Y, LPoints[3].X, LPoints[3].Y, AObject.Pen,
        AObject.Brush);

    stPolyBezier:
      EncodePolyBezier(LPoints, AObject.NoPoints, AObject.Pen);
  end;
end;

{
  Write Table if it is not supported as table in descendent engine.
  For each cell call EncodeRect, followed by encode item.
}
procedure TgtCustomDocumentEngine.EncodeTable(AObject: TgtTableItem);
var
  I, J, K: Integer;
  LTextItem: TgtTextItem;
  LDocItem: TgtDocumentItem;
  LX, LY, LWidth, LHeight, LTitleHeight, TmpX, TmpY, LTmpHt: Double;
  LPen, LTmpPen: TPen;
  LBrush: TBrush;
  LFont: TFont;
  LAlign: TgtHAlignment;
  LFrame: TgtFrame;
  L, SrtPa, SrtRn, CuRn: Integer;
begin
  LPen := TPen.Create;
  LTmpPen := TPen.Create;
  LBrush := TBrush.Create;
  LFont := TFont.Create;
  LFrame := TgtFrame.Create(Self);
  L := 0;
  FTablenumber := L;
  while (TableOnLastpage[L] = True) do
  begin
    L := L + 1;
    FTablenumber := L;
  end;
  SrtPa := RowsOnPage[FTablenumber][0]; // Starting page number
  SrtRn := 0;
  CuRn := RowsOnPage[FTablenumber][(FCurrentPage - SrtPa) + 1];
  // Number of rows on current page
  L := 1;
  while (L < (FCurrentPage - SrtPa) + 1) do
  begin
    SrtRn := SrtRn + RowsOnPage[FTablenumber][L];
    L := L + 1;
  end;

  if (FCurrentPage = SrtPa) then
  begin
    if (AObject.Settings.EnableTitle) then
    begin
      SrtRn := -1;
      CuRn := CuRn + 1;
    end;
  end;
  if (FCurrentPage = SrtPa + 1) then
  begin
    AObject.Y := (FPage.TopMargin + FPage.HeaderHeight) *
      FNativeConversionFactor;
  end;
  if (RowsOnPage[FTablenumber][(FCurrentPage - SrtPa) + 1 + 1] = 0) then
    TableOnLastpage[FTablenumber] := True
  else
    TableOnLastpage[FTablenumber] := False;
  with AObject do
  begin
    LTextItem := nil;
    if Settings.EnableTitle then
    begin
      LTextItem := TgtTextItem.Create;
      LTextItem.Font := Font;
      LTextItem.TextEffects := TextEffects;
    end;
    LY := Y;
    LTitleHeight := Settings.TitleHeight;
    for J := 0 to ColCount - 1 do
    begin
      if Settings.EnableTitle then
      begin
        LTextItem.Lines.Clear;
        with Settings.InternalMargin do
          WrapTextIntoLines(ReplacePlaceHolders(Columns[J].Title, True),
            Columns[J].Width - Left - Right, 0, LTextItem.Lines,
            Settings.AutoAdjustColumnWidth, Font);
        if LTextItem.Lines[0] = '' then
          LTextItem.Lines.Delete(0);
        with Settings.InternalMargin do
          LTmpHt := LTextItem.Lines.Count * TextSize('W', Font).cy +
            Top + Bottom;
        if (LTitleHeight < LTmpHt) then
          LTitleHeight := LTmpHt;
      end;
    end;
    for I := SrtRn to SrtRn + CuRn - 1 do
    begin
      if I = -1 then
        LHeight := LTitleHeight
      else
        LHeight := Int64(RowHeights[I]);

      LX := X;
      for J := 0 to ColCount - 1 do
      begin
        if J <> 0 then
          LX := LX + Columns[J - 1].Width;
        if (LX - X) >= MaxWidth then
          Break;
        LWidth := Columns[J].Width;

        LPen.Assign(Pen);
        LBrush.Assign(Brush);
        LFont.Assign(Font);
        LFrame.IsLeft := True;
        LFrame.IsTop := True;
        LFrame.IsRight := True;
        LFrame.IsBottom := True;
        LAlign := Columns[J].Alignment;
{$IFDEF gtActiveX}
        if Assigned(OnCellDraw) then
          OnCellDraw(Self, I, J, LPen, LBrush, LFont, LFrame);
        if Assigned(OnCellDrawEx) then
          OnCellDrawEx(Self, I, J, LPen, LBrush, LFont, LFrame, LAlign);
{$ELSE}
        if Assigned(OnCellDraw) then
          OnCellDraw(Self, I, J, LPen, LBrush, LFont, LFrame, LAlign);
{$ENDIF}
        LTmpPen.Assign(LPen);
        LTmpPen.Style := psClear;
        if (I = -1) then
        begin
          if Settings.EnableTitle then
          begin
            LTextItem.Font.Assign(LFont);
            LTextItem.Lines.Clear;
            with Settings.InternalMargin do
              WrapTextIntoLines(ReplacePlaceHolders(Columns[J].Title, True),
                LWidth - Left - Right, 0, LTextItem.Lines,
                Settings.AutoAdjustColumnWidth, LFont);
            if LTextItem.Lines[0] = '' then
              LTextItem.Lines.Delete(0);
            with Settings.InternalMargin do
              LTmpHt := LTextItem.Lines.Count * TextSize('W', LFont).cy +
                Top + Bottom;
            if (LHeight < LTmpHt) then
              LHeight := LTmpHt;
            EncodeRect(LX, LY, LX + LWidth, LY + LHeight, LTmpPen, LBrush);
            if LFrame.IsLeft then
              EncodeLine(LX, LY, LX, LY + LHeight, LPen);
            if LFrame.IsTop then
              EncodeLine(LX, LY, LX + LWidth, LY, LPen);
            if LFrame.IsRight then
              EncodeLine(LX + LWidth, LY, LX + LWidth, LY + LHeight, LPen);
            if LFrame.IsBottom then
              EncodeLine(LX, LY + LHeight, LX + LWidth, LY + LHeight, LPen);
            LTextItem.X := LX;
            LTextItem.Y := LY;
            LTextItem.Brush := LBrush;
            ProcessTextRect(LTextItem, LAlign, vaTop, LWidth, LHeight,
              Settings.InternalMargin);
          end;
        end
        else
        begin
          EncodeRect(LX, LY, LX + LWidth, LY + LHeight, LTmpPen, LBrush);
          if LFrame.IsLeft then
            EncodeLine(LX, LY, LX, LY + LHeight, LPen);
          if LFrame.IsTop then
            EncodeLine(LX, LY, LX + LWidth, LY, LPen);
          if LFrame.IsRight then
            EncodeLine(LX + LWidth, LY, LX + LWidth, LY + LHeight, LPen);
          if LFrame.IsBottom then
            EncodeLine(LX, LY + LHeight, LX + LWidth, LY + LHeight, LPen);
          for K := 0 to RowItemsList[I].Count - 1 do
          begin
            with AObject.Settings.InternalMargin do
            begin
              if (LWidth <= (Left + Right)) or (LHeight <= (Top + Bottom)) then
                Break;
              LDocItem := TgtDocumentItem(RowItemsList[I].Items[K]);
              if (LDocItem is TgtTextItem) and
                (TgtTextItem(LDocItem).X = J) then
              begin
                TgtTextItem(LDocItem).Font := LFont;
                TgtTextItem(LDocItem).Brush := LBrush;
                TgtTextItem(LDocItem).Lines.Strings[0] :=
                  ReplacePlaceHolders(TgtTextItem(LDocItem).Lines.Strings
                  [0], True);
                TmpX := TgtTextItem(LDocItem).X;
                TmpY := TgtTextItem(LDocItem).Y;
                TgtTextItem(LDocItem).X := LX;
                TgtTextItem(LDocItem).Y := LY;
                ProcessTextRect(TgtTextItem(LDocItem), LAlign, vaTop, LWidth,
                  LHeight, Settings.InternalMargin);
                TgtTextItem(LDocItem).X := TmpX;
                TgtTextItem(LDocItem).Y := TmpY;
                Break;
              end
              else if (LDocItem is TgtImageItem) and
                (TgtImageItem(LDocItem).X = J) then
              begin
                TgtImageItem(LDocItem).Pen := LPen;
                TgtImageItem(LDocItem).Brush := LBrush;
                TmpX := TgtImageItem(LDocItem).X;
                TmpY := TgtImageItem(LDocItem).Y;
                TgtImageItem(LDocItem).X := LX + Left;
                TgtImageItem(LDocItem).Y := LY + Top;
                if TgtImageItem(LDocItem).Width > (LWidth - Left - Right) then
                  TgtImageItem(LDocItem).Width := LWidth - Left - Right;
                if TgtImageItem(LDocItem).Height > (LHeight - Top - Bottom) then
                  TgtImageItem(LDocItem).Height := LHeight - Top - Bottom;
                with TgtImageItem(LDocItem) do
                  DisplayRect := gtRect(X, Y, X + Width, Y + Height);
                EncodeImage(TgtImageItem(LDocItem));
                TgtImageItem(LDocItem).X := TmpX;
                TgtImageItem(LDocItem).Y := TmpY;
                Break;
              end;
            end;
          end;
        end;
      end;
      LY := LY + LHeight;
    end;
    if Settings.EnableTitle then
      FreeAndNil(LTextItem);
  end;
  LFont.Free;
  LFrame.Free;
  LPen.Free;
  LTmpPen.Free;
  LBrush.Free;
end;

procedure TgtCustomDocumentEngine.EncodeText(AObject: TgtTextItem);
var
  LOriginalText: WideString;

  function GetTextForWidth(AFromPos, AToPos: Double): WideString;
  var
    LI: Integer;
    LChangeX: Boolean;
  begin
    Result := '';
    LI := 1;
    LChangeX := False;
    with AObject do
    begin
      while (LI <= Length(Lines[0])) and
        (TextSize(Result, Font).cx < (AFromPos - X)) do
      begin
        Result := Result + Lines[0][LI];
        Inc(LI);
        LChangeX := True;
      end;
      if LChangeX then
        X := AFromPos;
      Result := '';
      if (LI > 1) then
        Dec(LI);
      while (LI <= Length(Lines[0])) and
        (TextSize(Result, Font).cx < (AToPos - X - 1)) do
      begin
        Result := Result + Lines[0][LI];
        Inc(LI);
      end;
    end;
  end;

begin
  with AObject do
  begin
    LOriginalText := Lines.Strings[0];
    Lines.Strings[0] := ReplacePlaceHolders(Lines.Strings[0], True);
    if (IsClipRect) then
    begin
      if (Y >= ClipRect.Top) and
        (Y <= (ClipRect.Bottom - TextSize(Lines[0], Font).cy / 2)) and
        (X < ClipRect.Right) then
        Lines[0] := GetTextForWidth(ClipRect.Left, ClipRect.Right)
      else
        Lines[0] := '';
    end;
    Lines.Strings[0] := LOriginalText;
  end;
end;

{
  Write TextBox if it is not supported as TextBox in descendent engines.
}
procedure TgtCustomDocumentEngine.EncodeTextBox(AObject: TgtTextBoxItem);
begin
  with AObject do
  begin
    if Frame.IsLeft then
      EncodeLine(X, Y, X, Y + Boxheight, Pen);
    if Frame.IsTop then
      EncodeLine(X, Y, X + BoxWidth, Y, Pen);
    if Frame.IsRight then
      EncodeLine(X + BoxWidth, Y, X + BoxWidth, Y + Boxheight, Pen);
    if Frame.IsBottom then
      EncodeLine(X, Y + Boxheight, X + BoxWidth, Y + Boxheight, Pen);
    Pen.Style := psClear;
    EncodeRect(X, Y, X + BoxWidth, Y + Boxheight, Pen, Brush);
    Brush.Style := bsClear;
    ProcessTextRect(TgtTextItem(AObject), HAlign, VAlign, BoxWidth, Boxheight,
      Frame.InternalMargin);
  end;
end;

// procedure TgtCustomDocumentEngine.EncodeTransformationItem
// (AObject: TgtTransformationItem);
// begin
//
// end;

procedure TgtCustomDocumentEngine.SetFileName(const Value: String);
begin
  if FIsDocumentStarted = True then
    exit;
  if UpperCase(ExtractFileExt(Value)) = '.' + UpperCase(FFileExtension) then
    FFileName := ChangeFileExt(Value, '')
  else
    FFileName := Value;
end;

procedure TgtCustomDocumentEngine.SetCanvas(const Value: TMetafileCanvas);
begin
  FCanvas := Value;
end;

procedure TgtCustomDocumentEngine.SetMeasurementUnit(const Value: TgtUnitType);
begin
  FMeasurementUnit := Value;
  FNativeConversionFactor := CalculateNativeUnitFactor(FMeasurementUnit);
  FPage.FNativeFactor := FNativeConversionFactor;
  FTextFormatting.FNativeFactor := FNativeConversionFactor;
  FTableSettings.FNativeFactor := FNativeConversionFactor;
end;

procedure TgtCustomDocumentEngine.SetUserStream(const Value: TStream);
begin
  if (FIsDocumentStarted <> True) then
    FUserStream := Value;
end;

procedure TgtCustomDocumentEngine.AddDocumentItem(AItem: TgtDocumentItem);
begin
  if FSortTextItems and not(AItem is TgtTextBoxItem) and
    (AItem is TgtTextItem) then
    FCurrentTextItemList.Add(AItem)
  else
    FCurrentDocumentItemList.Add(AItem);
end;

procedure TgtCustomDocumentEngine.Arc(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Double);
begin
  if not FIsDocumentStarted or not(ckShape in Capabilities) { or not
    (irShape in ItemsToRender) } then
    exit;
{$IFNDEF gtRegistered}
{$IFDEF gtFileMaker}
  if (not FStatusMgr.IsException) then
{$ENDIF}
    if FPageCount > CMaxPages then
      exit;
{$ENDIF}
  FShapeItem := TgtShapeItem.Create(False, stArc);
  FShapeItem.SetPoints([gtPoint(X1, Y1), gtPoint(X2, Y2), gtPoint(X3, Y3),
    gtPoint(X4, Y4)]);
  ClipShapeCoordinates(FShapeItem.GetPoints, FShapeItem.NoPoints);
  FShapeItem.Pen := Pen;
  AddDocumentItem(FShapeItem);
end;

procedure TgtCustomDocumentEngine.Chord(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Double;
  IsFill: Boolean);
begin
  if not FIsDocumentStarted or not(ckShape in Capabilities) or
    not(irShape in ItemsToRender) then
    exit;
{$IFNDEF gtRegistered}
{$IFDEF gtFileMaker}
  if (not FStatusMgr.IsException) then
{$ENDIF}
    if FPageCount > CMaxPages then
      exit;
{$ENDIF}
  FShapeItem := TgtShapeItem.Create(IsFill, stChord);
  FShapeItem.SetPoints([gtPoint(X1, Y1), gtPoint(X2, Y2), gtPoint(X3, Y3),
    gtPoint(X4, Y4)]);
  ClipShapeCoordinates(FShapeItem.GetPoints, FShapeItem.NoPoints);
  FShapeItem.Pen := Pen;
  if IsFill then
    FShapeItem.Brush := Brush;
  AddDocumentItem(FShapeItem);
end;

procedure TgtCustomDocumentEngine.Ellipse(X1, Y1, X2, Y2: Double;
  IsFill: Boolean);
begin
  if not FIsDocumentStarted or not(ckShape in Capabilities) or
    not(irShape in ItemsToRender) then
    exit;
  if not FIsDocumentStarted or not(ckShape in Capabilities) then
    exit;
{$IFNDEF gtRegistered}
{$IFDEF gtFileMaker}
  if (not FStatusMgr.IsException) then
{$ENDIF}
    if FPageCount > CMaxPages then
      exit;
{$ENDIF}
  FShapeItem := TgtShapeItem.Create(IsFill, stEllipse);
  FShapeItem.SetPoints([gtPoint(X1, Y1), gtPoint(X2, Y2)]);
  ClipShapeCoordinates(FShapeItem.GetPoints, FShapeItem.NoPoints);
  FShapeItem.Pen := Pen;
  if IsFill then
    FShapeItem.Brush := Brush;
  AddDocumentItem(FShapeItem);
end;

procedure TgtCustomDocumentEngine.Line(X1, Y1, X2, Y2: Double);
begin
  if not FIsDocumentStarted or not(ckShape in Capabilities) or
    not(irShape in ItemsToRender) then
    exit;
  if not FIsDocumentStarted or not(ckShape in Capabilities) then
    exit;
{$IFNDEF gtRegistered}
{$IFDEF gtFileMaker}
  if (not FStatusMgr.IsException) then
{$ENDIF}
    if FPageCount > CMaxPages then
      exit;
{$ENDIF}
  FShapeItem := TgtShapeItem.Create(False, stLine);
  FShapeItem.SetPoints([gtPoint(X1, Y1), gtPoint(X2, Y2)]);
  ClipShapeCoordinates(FShapeItem.GetPoints, FShapeItem.NoPoints);
  FShapeItem.Pen := Pen;
  AddDocumentItem(FShapeItem);
end;

procedure TgtCustomDocumentEngine.Pie(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Double;
  IsFill: Boolean);
begin
  if not FIsDocumentStarted or not(ckShape in Capabilities) or
    not(irShape in ItemsToRender) then
    exit;
{$IFNDEF gtRegistered}
{$IFDEF gtFileMaker}
  if (not FStatusMgr.IsException) then
{$ENDIF}
    if FPageCount > CMaxPages then
      exit;
{$ENDIF}
  FShapeItem := TgtShapeItem.Create(IsFill, stPie);
  FShapeItem.SetPoints([gtPoint(X1, Y1), gtPoint(X2, Y2), gtPoint(X3, Y3),
    gtPoint(X4, Y4)]);
  ClipShapeCoordinates(FShapeItem.GetPoints, FShapeItem.NoPoints);
  FShapeItem.Pen := Pen;
  if IsFill then
    FShapeItem.Brush := Brush;
  AddDocumentItem(FShapeItem);
end;

procedure TgtCustomDocumentEngine.Rectangle(X1, Y1, X2, Y2: Double;
  IsFill: Boolean);
begin
  if not FIsDocumentStarted or not(ckShape in Capabilities) or
    not(irShape in ItemsToRender) then
    exit;
{$IFNDEF gtRegistered}
{$IFDEF gtFileMaker}
  if (not FStatusMgr.IsException) then
{$ENDIF}
    if FPageCount > CMaxPages then
      exit;
{$ENDIF}
  FShapeItem := TgtShapeItem.Create(IsFill, stRectangle);
  FShapeItem.SetPoints([gtPoint(X1, Y1), gtPoint(X2, Y2)]);
  ClipShapeCoordinates(FShapeItem.GetPoints, FShapeItem.NoPoints);
  FShapeItem.Pen := Pen;
  if IsFill then
    FShapeItem.Brush := Brush;
  AddDocumentItem(FShapeItem);
end;

procedure TgtCustomDocumentEngine.RoundRect(X1, Y1, X2, Y2, X3, Y3: Double;
  IsFill: Boolean);
begin
  if not FIsDocumentStarted or not(ckShape in Capabilities) or
    not(irShape in ItemsToRender) then
    exit;
{$IFNDEF gtRegistered}
{$IFDEF gtFileMaker}
  if (not FStatusMgr.IsException) then
{$ENDIF}
    if FPageCount > CMaxPages then
      exit;
{$ENDIF}
  X3 := NativeXPos(X3);
  Y3 := NativeYPos(Y3);
  FShapeItem := TgtShapeItem.Create(IsFill, stRoundRect);
  FShapeItem.SetPoints([gtPoint(X1, Y1), gtPoint(X2, Y2), gtPoint(X3, Y3)]);
  ClipShapeCoordinates(FShapeItem.GetPoints, FShapeItem.NoPoints - 1);
  FShapeItem.Pen := Pen;
  if IsFill then
    FShapeItem.Brush := Brush;
  AddDocumentItem(FShapeItem);
end;

procedure TgtCustomDocumentEngine.PolyBezier(Points: array of TgtPoint);
begin
  if not FIsDocumentStarted or not(ckShape in Capabilities) or
    not(irShape in ItemsToRender) then
    exit;
{$IFNDEF gtRegistered}
{$IFDEF gtFileMaker}
  if (not FStatusMgr.IsException) then
{$ENDIF}
    if FPageCount > CMaxPages then
      exit;
{$ENDIF}
  FShapeItem := TgtShapeItem.Create(False, stPolyBezier);
  FShapeItem.SetPoints(Points);
  ClipShapeCoordinates(FShapeItem.GetPoints, FShapeItem.NoPoints);
  FShapeItem.Pen := Pen;
  AddDocumentItem(FShapeItem);
end;

procedure TgtCustomDocumentEngine.Polygon(Points: array of TgtPoint;
  IsFill: Boolean);
begin
  if not FIsDocumentStarted or not(ckShape in Capabilities) or
    not(irShape in ItemsToRender) then
    exit;
{$IFNDEF gtRegistered}
{$IFDEF gtFileMaker}
  if (not FStatusMgr.IsException) then
{$ENDIF}
    if FPageCount > CMaxPages then
      exit;
{$ENDIF}
  FShapeItem := TgtShapeItem.Create(IsFill, stPolygon);
  FShapeItem.SetPoints(Points);
  ClipShapeCoordinates(FShapeItem.GetPoints, FShapeItem.NoPoints);
  FShapeItem.Pen := Pen;
  if IsFill then
    FShapeItem.Brush := Brush;
  AddDocumentItem(FShapeItem);
end;

procedure TgtCustomDocumentEngine.PolyLine(Points: array of TgtPoint);
begin
  if not FIsDocumentStarted or not(ckShape in Capabilities) or
    not(irShape in ItemsToRender) then
    exit;
{$IFNDEF gtRegistered}
{$IFDEF gtFileMaker}
  if (not FStatusMgr.IsException) then
{$ENDIF}
    if FPageCount > CMaxPages then
      exit;
{$ENDIF}
  FShapeItem := TgtShapeItem.Create(False, stPolyLine);
  FShapeItem.SetPoints(Points);
  ClipShapeCoordinates(FShapeItem.GetPoints, FShapeItem.NoPoints);
  FShapeItem.Pen := Pen;
  AddDocumentItem(FShapeItem);
end;

procedure TgtCustomDocumentEngine.BeginFooter;
begin
  if not FIsDocumentStarted then
    exit;
  BandType := btFooter;
  FCurrentDocumentItemList := FFooterItem.FDocumentItems;
  FCurrentTextItemList := FFooterItem.FTextItems;
  FCurrentOffsetY := FFooterItem.FOffsetY;
end;

procedure TgtCustomDocumentEngine.BeginHeader;
begin
  if not FIsDocumentStarted then
    exit;
  BandType := btHeader;
  FCurrentDocumentItemList := FHeaderItem.FDocumentItems;
  FCurrentTextItemList := FHeaderItem.FTextItems;
  FCurrentOffsetY := FHeaderItem.FOffsetY;
end;

procedure TgtCustomDocumentEngine.BeginPara;
var
  LY: Double;
begin
  if not FIsDocumentStarted then
    exit;
{$IFNDEF gtRegistered}
{$IFDEF gtFileMaker}
  if (not FStatusMgr.IsException) then
{$ENDIF}
    if FPageCount > CMaxPages then
      exit;
{$ENDIF}
  FNoSorting := False;
  FCurrentOffsetY := FCurrentOffsetY + FTextFormatting.FBeforeSpace;
  LY := FBandRect.Top + FCurrentOffsetY;

  while not IsDocumentItemInRange(FBandRect.Left, LY) do
  begin
    LY := Abs(LY - FBandRect.Bottom);
    NewPage;
    LY := LY + FBandRect.Top + FCurrentOffsetY;
  end;

  if IsDocumentItemInRange(FBandRect.Left, LY) then
  begin
    FIsParagraphStarted := True;
    FParagraphItem := TgtParagraphItem.Create;
    FParagraphItem.X := FBandRect.Left;
    FParagraphItem.Y := LY;
    FParagraphItem.Settings := FTextFormatting;
    FParagraphItem.Font := Font;
    FParagraphItem.Brush := Brush;
    FParagraphItem.TextEffects := TextEffects;
    with FParagraphItem do
    begin
      Width := FBandRect.Right - X - Settings.RightIndent - Settings.LeftIndent;
      Height := FBandRect.Bottom - Y;
    end;
    SetLength(FIsParaStarted, 1);
    FIsParaStarted[0] := False;
  end;
end;

function TgtCustomDocumentEngine.BeginTable(X, Y: Double;
  NoColumns: Integer): TList;
begin
  Result := nil;
  if not FIsDocumentStarted then
    exit;
{$IFNDEF gtRegistered}
{$IFDEF gtFileMaker}
  if (not FStatusMgr.IsException) then
{$ENDIF}
    if FPageCount > CMaxPages then
      exit;
{$ENDIF}
  X := NativeXPos(X) + FBandRect.Left;
  Y := NativeYPos(Y) + FBandRect.Top;
  if IsDocumentItemInRange(X, Y) then
  begin
    FIsTableStarted := True;
    FTableItem := TgtTableItem.Create(NoColumns, Self);
    FTableItem.Settings := FTableSettings;
    FTableItem.X := X;
    FTableItem.Y := Y;
    FTableItem.MaxWidth := FBandRect.Right - X;
    FTableItem.MaxHeight := FBandRect.Bottom - Y;
    FTableItem.Font := Font;
    FTableItem.Pen := Pen;
    FTableItem.Brush := Brush;
    Result := FTableItem.GetColumnsList;
  end;
end;

procedure TgtCustomDocumentEngine.BeginWaterMark;
begin
  if not FIsDocumentStarted then
    exit;
  BandType := btWatermark;
  FCurrentDocumentItemList := FWatermarkItem.FDocumentItems;
  FCurrentTextItemList := FWatermarkItem.FTextItems;
  FCurrentOffsetY := FWatermarkItem.FOffsetY;
end;

procedure TgtCustomDocumentEngine.BeginStamp;
begin
  if not FIsDocumentStarted then
    exit;
  BandType := btStamp;
  FCurrentDocumentItemList := FStampItem.FDocumentItems;
  FCurrentTextItemList := FStampItem.FTextItems;
  FCurrentOffsetY := FStampItem.FOffsetY;
end;

procedure TgtCustomDocumentEngine.ClearEngineStates;
var
  I: Integer;
begin
  if not FIsDocumentStarted then
    exit;
  for I := 0 to FEngineStateList.Count - 1 do
    TgtEngineState(FEngineStateList.Items[I]).Free;
  FEngineStateList.Clear;
end;

procedure TgtCustomDocumentEngine.EncodeArc(X1, Y1, X2, Y2, X3, Y3, X4,
  Y4: Double; Pen: TPen);
var
  LBitmap: TBitmap;
  LX, LY: Double;
begin
  LBitmap := TBitmap.Create;
  with LBitmap do
  begin
    LX := Min(X1, X2);
    LY := Min(Y1, Y2);
    Width := Round(Abs(X2 - X1));
    Height := Round(Abs(Y2 - Y1));

    Canvas.Pen.Assign(Pen);
    if Brush <> nil then
      Canvas.Brush.Assign(Brush);
    Transparent := True;
    Canvas.Arc(Round(X1 - LX), Round(Y1 - LY), Round(X2 - LX), Round(Y2 - LY),
      Round(X3 - LX), Round(Y3 - LY), Round(X4 - LX), Round(Y4 - LY));
  end;
  EncodeShapeBitmap(LX, LY, LBitmap);
  FreeAndNil(LBitmap);
end;

procedure TgtCustomDocumentEngine.EncodeChord(X1, Y1, X2, Y2, X3, Y3, X4,
  Y4: Double; Pen: TPen; Brush: TBrush);
var
  LBitmap: TBitmap;
  LX, LY: Double;
begin
  LBitmap := TBitmap.Create;
  with LBitmap do
  begin
    LX := Min(X1, X2);
    LY := Min(Y1, Y2);
    Width := Round(Abs(X2 - X1));
    Height := Round(Abs(Y2 - Y1));

    Canvas.Pen.Assign(Pen);
    if Brush <> nil then
      Canvas.Brush.Assign(Brush);
    Transparent := True;
    Canvas.Chord(Round(X1 - LX), Round(Y1 - LY), Round(X2 - LX), Round(Y2 - LY),
      Round(X3 - LX), Round(Y3 - LY), Round(X4 - LX), Round(Y4 - LY));
  end;
  EncodeShapeBitmap(LX, LY, LBitmap);
  FreeAndNil(LBitmap);
end;

procedure TgtCustomDocumentEngine.EncodeEllipse(X1, Y1, X2, Y2: Double;
  Pen: TPen; Brush: TBrush);
var
  LBitmap: TBitmap;
  LX, LY: Double;
begin
  LBitmap := TBitmap.Create;
  with LBitmap do
  begin
    LX := Min(X1, X2);
    LY := Min(Y1, Y2);
    Width := Round(Abs(X2 - X1));
    Height := Round(Abs(Y2 - Y1));

    Canvas.Pen.Assign(Pen);
    if Brush <> nil then
      Canvas.Brush.Assign(Brush);
    Transparent := True;
    Canvas.Ellipse(Round(X1 - LX), Round(Y1 - LY), Round(X2 - LX),
      Round(Y2 - LY));
  end;
  EncodeShapeBitmap(LX, LY, LBitmap);
  FreeAndNil(LBitmap);
end;

procedure TgtCustomDocumentEngine.EncodeLine(X1, Y1, X2, Y2: Double; Pen: TPen);
var
  LBitmap: TBitmap;
  LX, LY: Double;
begin
  LBitmap := TBitmap.Create;
  with LBitmap do
  begin
    LX := Min(X1, X2);
    LY := Min(Y1, Y2);

    Transparent := True;
    Canvas.Pen.Assign(Pen);
    Width := Round(Abs(X2 - X1));
    Height := Round(Abs(Y2 - Y1));
    Canvas.MoveTo(Round(X1 - LX), Round(Y1 - LY));
    Canvas.LineTo(Round(X2 - LX), Round(Y2 - LY));
  end;
  EncodeShapeBitmap(LX, LY, LBitmap);
  FreeAndNil(LBitmap);
end;

procedure TgtCustomDocumentEngine.EncodePie(X1, Y1, X2, Y2, X3, Y3, X4,
  Y4: Double; Pen: TPen; Brush: TBrush);
var
  LBitmap: TBitmap;
  LX, LY: Double;
begin
  LBitmap := TBitmap.Create;
  with LBitmap do
  begin
    LX := Min(X1, X2);
    LY := Min(Y1, Y2);
    Width := Round(Abs(X2 - X1));
    Height := Round(Abs(Y2 - Y1));

    Canvas.Pen.Assign(Pen);
    if Brush <> nil then
      Canvas.Brush.Assign(Brush);
    Transparent := True;
    Canvas.Pie(Round(X1 - LX), Round(Y1 - LY), Round(X2 - LX), Round(Y2 - LY),
      Round(X3 - LX), Round(Y3 - LY), Round(X4 - LX), Round(Y4 - LY));
  end;
  EncodeShapeBitmap(LX, LY, LBitmap);
  FreeAndNil(LBitmap);
end;

procedure TgtCustomDocumentEngine.EncodePolyBezier(Points: TgtPoints;
  NoPoints: Integer; Pen: TPen);
var
  TempArray: array of TPoint;
  LBitmap: TBitmap;
  I: Integer;
  X1, X2, Y1, Y2: Double;
begin
  LBitmap := TBitmap.Create;
  X1 := 0;
  Y1 := 0;
  X2 := 0;
  Y2 := 0;
  with LBitmap do
  begin
    for I := 0 to NoPoints - 1 do
    begin
      if I = 0 then
      begin
        X1 := Points[I].X;
        Y1 := Points[I].Y;
      end;
      if X1 > Points[I].X then
        X1 := Points[I].X;
      if X2 < Points[I].X then
        X2 := Points[I].X;
      if Y1 > Points[I].Y then
        Y1 := Points[I].Y;
      if Y2 < Points[I].Y then
        Y2 := Points[I].Y;
    end;
    SetLength(TempArray, NoPoints);
    for I := 0 to NoPoints - 1 do
    begin
      TempArray[I].X := Round(Points[I].X - X1);
      TempArray[I].Y := Round(Points[I].Y - Y1);
    end;
    Canvas.Pen.Assign(Pen);
    Width := Round(Abs(X2 - X1));
    Height := Round(Abs(Y2 - Y1));
    Transparent := True;
    Canvas.PolyBezier(TempArray);
  end;
  EncodeShapeBitmap(X1, Y1, LBitmap);
  FreeAndNil(LBitmap);
end;

procedure TgtCustomDocumentEngine.EncodePolyLine(Points: TgtPoints;
  NoPoints: Integer; IsClosed: Boolean; Pen: TPen; Brush: TBrush);
var
  TempArray: array of TPoint;
  LBitmap: TBitmap;
  I: Integer;
  X1, X2, Y1, Y2: Double;
begin
  LBitmap := TBitmap.Create();
  X1 := 0;
  Y1 := 0;
  X2 := 0;
  Y2 := 0;
  with LBitmap do
  begin
    for I := 0 to NoPoints - 1 do
    begin
      if I = 0 then
      begin
        X1 := Points[I].X;
        Y1 := Points[I].Y;
      end;
      if X1 > Points[I].X then
        X1 := Points[I].X;
      if X2 < Points[I].X then
        X2 := Points[I].X;
      if Y1 > Points[I].Y then
        Y1 := Points[I].Y;
      if Y2 < Points[I].Y then
        Y2 := Points[I].Y;
    end;
    SetLength(TempArray, NoPoints);
    for I := 0 to NoPoints - 1 do
    begin
      TempArray[I].X := Round(Points[I].X - X1);
      TempArray[I].Y := Round(Points[I].Y - Y1);
    end;
    Canvas.Pen.Assign(Pen);
    PixelFormat := pf24bit;
    Width := Round(Abs(X2 - X1) + 2);
    Height := Round(Abs(Y2 - Y1) + 2);
    if IsClosed and (Brush <> nil) then
      Canvas.Brush.Assign(Brush);
    Transparent := True;
    if IsClosed then
      Canvas.Polygon(TempArray)
    else
      Canvas.PolyLine(TempArray);
  end;
  EncodeShapeBitmap(X1, Y1, LBitmap);
  FreeAndNil(LBitmap);
end;

procedure TgtCustomDocumentEngine.EncodeRect(X1, Y1, X2, Y2: Double; Pen: TPen;
  Brush: TBrush);
var
  LBitmap: TBitmap;
  LX, LY: Double;
begin
  LBitmap := TBitmap.Create;
  with LBitmap do
  begin
    LX := Min(X1, X2);
    LY := Min(Y1, Y2);
    Width := Round(Abs(X2 - X1));
    Height := Round(Abs(Y2 - Y1));

    Canvas.Pen.Assign(Pen);
    if Brush <> nil then
      Canvas.Brush.Assign(Brush);
    Transparent := True;
    Canvas.Rectangle(Round(X1 - LX), Round(Y1 - LY), Round(X2 - LX),
      Round(Y2 - LY));
  end;
  EncodeShapeBitmap(LX, LY, LBitmap);
  FreeAndNil(LBitmap);
end;

procedure TgtCustomDocumentEngine.EncodeRoundRect(X1, Y1, X2, Y2, X3,
  Y3: Double; Pen: TPen; Brush: TBrush);
var
  LBitmap: TBitmap;
  LX, LY: Double;
begin
  LBitmap := TBitmap.Create;
  with LBitmap do
  begin
    LX := Min(X1, X2);
    LY := Min(Y1, Y2);
    Width := Round(Abs(X2 - X1));
    Height := Round(Abs(Y2 - Y1));

    Canvas.Pen.Assign(Pen);
    if Brush <> nil then
      Canvas.Brush.Assign(Brush);
    Transparent := True;
    Canvas.RoundRect(Round(X1 - LX), Round(Y1 - LY), Round(X2 - LX),
      Round(Y2 - LY), Round(X3), Round(Y3));
  end;
  EncodeShapeBitmap(LX, LY, LBitmap);
  FreeAndNil(LBitmap);
end;

procedure TgtCustomDocumentEngine.EncodeShapeBitmap(X, Y: Double;
  Bitmap: TBitmap);
begin

end;

procedure TgtCustomDocumentEngine.EndFooter;
begin
  if not FIsDocumentStarted then
    exit;
  FFooterItem.FOffsetY := FCurrentOffsetY;
  BandType := btContent;
  with TgtPageItem(FPages.Items[FCurrentPage - 1]) do
  begin
    FCurrentDocumentItemList := FDocumentItems;
    FCurrentTextItemList := FTextItems;
    FCurrentOffsetY := FOffsetY;
  end;
end;

procedure TgtCustomDocumentEngine.EndHeader;
begin
  if not FIsDocumentStarted then
    exit;
  FHeaderItem.FOffsetY := FCurrentOffsetY;
  BandType := btContent;
  with TgtPageItem(FPages.Items[FCurrentPage - 1]) do
  begin
    FCurrentDocumentItemList := FDocumentItems;
    FCurrentTextItemList := FTextItems;
    FCurrentOffsetY := FOffsetY;
  end;
end;

procedure TgtCustomDocumentEngine.EndPara;
var
  I: Integer;
begin
  I := 0;
  if not FIsDocumentStarted then
    exit;
  if FIsParagraphStarted then
  begin
    with FParagraphItem do
    begin
      FHeight := Lines.Count * TextSize('W', Font).cy * Settings.LineSpacing;
      FCurrentOffsetY := FCurrentOffsetY + FHeight;
    end;
    FIsParagraphStarted := False;
    AddDocumentItem(FParagraphItem);
    if FIsAutoPaginate then
    begin
      while FIsParaStarted[I] do
      begin
        NewPage;
        AddDocumentItem(FParaItem[I]);
        FIsParaStarted[I] := False;
        Inc(I);
      end;
      if (I > 0) then
      begin
        with FParaItem[I - 1] do
        begin
          FHeight := Lines.Count * TextSize('W', Font).cy *
            Settings.LineSpacing;
          FCurrentOffsetY := FCurrentOffsetY + FHeight;
        end;
      end;
    end;
  end;
end;

procedure TgtCustomDocumentEngine.EndTable;
var
  RowNo, RowsPerPage, I, J: Integer;
  LY, TableHeight: Double;
begin
  if not FIsDocumentStarted then
    exit;
  if FIsTableStarted then
  begin
    FTablenumber := FTablenumber + 1;
    SetLength(RowsOnPage, FTablenumber + 2);
    SetLength(TableOnLastpage, FTablenumber + 2);
    SetLength(RowsOnPage[FTablenumber], 2);
    LY := FTableItem.Y;
    RowNo := FTableItem.FRowCount;
    TableHeight := LY;
    RowsPerPage := 0;
    RowsOnPage[FTablenumber][0] := CurrentPage;
    J := 1;

    if FTableItem.Settings.FEnableTitle then
    begin
      TableHeight := TableHeight + FTableItem.Settings.TitleHeight
    end;
    I := 0;
    while (I <= RowNo) do
    begin
      with TgtPageItem(FPages.Items[FCurrentPage - 1]).FSettings do
      begin
        TableHeight := TableHeight + Int64(FTableItem.RowHeights[I]);
        if Int64(FTableItem.RowHeights[I]) >
          (FHeight - (FTopMargin + FHeaderHeight + FBottomMargin +
          FFooterHeight)) then
        begin
          FTableItem.RowHeights[I] :=
            TObject(Floor(FHeight - (FTopMargin + FHeaderHeight + FBottomMargin
            + FFooterHeight)));
        end;
        RowsPerPage := RowsPerPage + 1;
        if TableHeight > (FHeight - (FBottomMargin + FFooterHeight)) then
        begin
          I := I - 1;
          RowsOnPage[FTablenumber][J] := RowsPerPage - 1;
          SetLength(RowsOnPage[FTablenumber], J + 3);
          RowsPerPage := 0;
          J := J + 1;
          AddDocumentItem(FTableItem);
          FIsTableStarted := False;
          if FIsAutoPaginate then
            NewPage;
          TableHeight := FTopMargin + FHeaderHeight;
          FIsTableStarted := True;
        end;
      end;
      I := I + 1;
    end;
    SetLength(RowsOnPage[FTablenumber], J + 2);
    RowsOnPage[FTablenumber][J] := RowsPerPage;
    RowsOnPage[FTablenumber][J + 1] := 0;
    TableOnLastpage[FTablenumber] := False;
    AddDocumentItem(FTableItem);
    FIsTableStarted := False;
  end;
end;

procedure TgtCustomDocumentEngine.EndWaterMark;
begin
  if not FIsDocumentStarted then
    exit;
  FWatermarkItem.FOffsetY := FCurrentOffsetY;
  BandType := btContent;
  with TgtPageItem(FPages.Items[FCurrentPage - 1]) do
  begin
    FCurrentDocumentItemList := FDocumentItems;
    FCurrentTextItemList := FTextItems;
    FCurrentOffsetY := FOffsetY;
  end;
end;

procedure TgtCustomDocumentEngine.EndStamp;
begin
  if not FIsDocumentStarted then
    exit;
  FStampItem.FOffsetY := FCurrentOffsetY;
  BandType := btContent;
  with TgtPageItem(FPages.Items[FCurrentPage - 1]) do
  begin
    FCurrentDocumentItemList := FDocumentItems;
    FCurrentTextItemList := FTextItems;
    FCurrentOffsetY := FOffsetY;
  end;
end;

function TgtCustomDocumentEngine.GetBitmapAsJPGGIFStream(ABitmap: TBitmap;
  IsJPEG: Boolean; JPEGQuality: Integer): TStream;
var
  LGraphic: TGraphic;
begin
  if IsJPEG then
    LGraphic := TJPEGImage.Create
  else

{$IFDEF GIFSupport}
{$IFDEF GIFByJEDI}
    LGraphic := TJvGIFImage.Create;
{$ENDIF}
  LGraphic := TGIFImage.Create;
{$ELSE}
    LGraphic := TJPEGImage.Create;
{$ENDIF}
  Result := TMemoryStream.Create;
  try
    if LGraphic is TJPEGImage then
    begin
      if ABitmap.Height = 1 then
        ABitmap.Height := 2;
      TJPEGImage(LGraphic).CompressionQuality := JPEGQuality;
    end;
    LGraphic.Assign(ABitmap);
    LGraphic.SaveToStream(Result);
  finally
    FreeAndNil(LGraphic);
  end;
end;

function TgtCustomDocumentEngine.GetHyperLinkText(AText: String;
  var AStartPos: Integer): String;
const
  HyperLinkKeywords: array [0 .. 5] of String = (Swww, Sftp, Shttp, '@', ':\',
    'https://');
var
  I, J, LPos, LLength, TempInt: Integer;
  Flag, TempFlag: Boolean;
  TempStr: String;
begin
  Result := '';
  TempStr := AnsiLowerCase(System.Copy(AText, AStartPos,
    Length(AText) - AStartPos));
  LPos := Length(TempStr);
  Flag := False;
  TempFlag := False;
  for I := Low(HyperLinkKeywords) to High(HyperLinkKeywords) do
  begin
    J := System.Pos(HyperLinkKeywords[I], TempStr);
    if (J <> 0) and (J < LPos) then
      if (HyperLinkKeywords[I] = '@') and (J > 0) then
      begin
        for TempInt := J to LPos do
          if (TempStr[TempInt] = '.') then
            TempFlag := True;
        while J <> 0 do
{$IFDEF gtDelphi2009Up}
          if ((J > 1) and SysUtils.CharInSet(TempStr[J - 1],
            ['0' .. '9', 'a' .. 'z', 'A' .. 'Z', '_', '-', '.'])) then
{$ELSE}
          if ((J > 1) and (TempStr[J - 1] in ['0' .. '9', 'a' .. 'z',
            'A' .. 'Z', '_', '-', '.'])) then
{$ENDIF}
            J := J - 1
          else
            Break;
        if (TempFlag = False) then
          LPos := 0;
      end
      else if (HyperLinkKeywords[I] = ':\') and (J > 0) then
      begin
        Flag := True;
        J := J - 1;
      end
      else
        LPos := J;

    if (J <> 0) and (J < LPos) then
      LPos := J;
  end;
  if LPos <> Length(TempStr) then
  begin
    if AStartPos <> 0 then
      Dec(LPos);
    AStartPos := AStartPos + LPos;
    LPos := AStartPos;
    LLength := Length(AText);
    for I := LPos to LLength do
      if Flag <> True then
{$IFDEF gtDelphi2009Up}
        if (I > 0) and SysUtils.CharInSet(AText[I],
          ['0' .. '9', 'a' .. 'z', 'A' .. 'Z', '&', '?', '%', '+', '.', ':',
          '-', '_', '/', '@', '=', ',', ';']) then
{$ELSE}
        if (I > 0) and (AText[I] in ['0' .. '9', 'a' .. 'z', 'A' .. 'Z', '&',
          '?', '%', '+', '.', ':', '-', '_', '/', '@', '=', ',', ';']) then
{$ENDIF}
          LPos := LPos + 1
        else
          Break
      else
      begin
        LPos := GetFilePathFromText(TempStr, J);
        Break;
      end;
    Result := System.Copy(AText, AStartPos, LPos - AStartPos);
  end;
end;

function TgtCustomDocumentEngine.GetImageAsBitmap(AImageObject
  : TgtImageItem): TBitmap;
var
  LGraphic: TGraphic;
begin
  with AImageObject do
  begin
    Result := TBitmap.Create;
    LGraphic := GetGraphicResource(IndexNo);

    Result.PixelFormat := Settings.ImagePixelFormat;
    Result.Width := LGraphic.Width;
    Result.Height := LGraphic.Height;
    // SetBmpDPI(Result, Settings.SourceDPI);
    Result.Canvas.Brush.Assign(Brush);
    Result.Canvas.FillRect(Rect(0, 0, Result.Width, Result.Height));

    if Settings.Transparent then
    begin
      Result.Canvas.CopyMode := cmSrcAnd;
      Result.TransparentColor := Brush.Color;
      Result.TransparentMode := tmFixed;
      Result.Transparent := True;
    end;

    if Settings.AutoSize then
    begin
      Result.Width := Round(Width);
      Result.Height := Round(Height);
      Result.Canvas.StretchDraw(Rect(0, 0, Round(Width), Round(Height)),
        LGraphic) { Due to SourceDPI, using StretchDraw }
    end
    else if Settings.Stretch then
    begin
      if not(ckImageStretch in Capabilities) then
      begin
        Result.Width := Round(Width);
        Result.Height := Round(Height);
        Result.Canvas.StretchDraw(Rect(0, 0, Round(Width), Round(Height)
          ), LGraphic)
      end
      else
        Result.Canvas.Draw(0, 0, LGraphic);
    end
    else if Settings.Center then
    begin
      if (ckImageFrame in Capabilities) then
      begin
        if ((DisplayRect.Right - DisplayRect.Left) > LGraphic.Width) and
          ((DisplayRect.Bottom - DisplayRect.Top) > LGraphic.Height) then
          Result.Canvas.Draw(0, 0, LGraphic)
        else if ((DisplayRect.Right - DisplayRect.Left) < LGraphic.Width) and
          ((DisplayRect.Bottom - DisplayRect.Top) < LGraphic.Height) then
        begin
          Result.Width := Round(Width);
          Result.Height := Round(Height);
          Result.Canvas.Draw(Round((Width - LGraphic.Width) / 2),
            Round((Height - LGraphic.Height) / 2), LGraphic);
        end
        else if ((DisplayRect.Bottom - DisplayRect.Top) < LGraphic.Height) then
        begin
          Result.Height := Round(Height);
          Result.Canvas.Draw(0, Round((Height - LGraphic.Height) / 2), LGraphic)
        end
        else
        begin
          Result.Width := Round(Width);
          Result.Canvas.Draw(Round((Width - LGraphic.Width) / 2), 0, LGraphic);
        end;
      end
      else
      begin
        Result.Width := Round(Width);
        Result.Height := Round(Height);
        Result.Canvas.FillRect(Rect(0, 0, Result.Width, Result.Height));
        Result.Canvas.Draw(Round((Width - LGraphic.Width) / 2),
          Round((Height - LGraphic.Height) / 2), LGraphic);
      end;
    end
    else
    begin
      if (ckImageFrame in Capabilities) then
      begin
        if (DisplayRect.Right - DisplayRect.Left) < LGraphic.Width then
          Result.Width := Round(Width);
        if (DisplayRect.Bottom - DisplayRect.Top) < LGraphic.Height then
          Result.Height := Round(Height);
      end
      else
      begin
        Result.Width := Round(Width);
        Result.Height := Round(Height);
        Result.Canvas.FillRect(Rect(0, 0, Result.Width, Result.Height));
      end;
      Result.Canvas.Draw(0, 0, LGraphic);
    end;
  end;
end;

function TgtCustomDocumentEngine.GetImageAsMetafile(AImageObject: TgtImageItem;
  SupportsStretch: Boolean; AutoFormat: Boolean): TMetafile;
var
  LMetafileCanvas: TMetafileCanvas;
  LGraphic: TGraphic;
  LIsStretch: Boolean;
  LWidth, LHeight, LOffsetX, LOffsetY: Integer;
begin
  LIsStretch := False;
  LOffsetX := 0;
  LOffsetY := 0;
  with AImageObject do
  begin
    LGraphic := GetGraphicResource(IndexNo);
    LWidth := Round(Width);
    LHeight := Round(Height);

    if Settings.AutoSize then
      LIsStretch := True { Due to Source DPI }
    else if Settings.Stretch then
    begin
      if not(ckImageStretch in Capabilities) then
        LIsStretch := True
      else
      begin
        LWidth := LGraphic.Width;
        LHeight := LGraphic.Height;
      end;
    end
    else if Settings.Center then
    begin
      LOffsetX := Round((Width - LGraphic.Width) / 2);
      LOffsetY := Round((Height - LGraphic.Height) / 2);
    end;

    Result := TMetafile.Create;
    Result.Width := LWidth;
    Result.Height := LHeight;
    Result.Enhanced := True;
    LMetafileCanvas := TMetafileCanvas.Create(Result, 0);
    LMetafileCanvas.Brush.Assign(Brush);
    LMetafileCanvas.FillRect(Rect(0, 0, LWidth, LHeight));
    if not LIsStretch then
      LMetafileCanvas.Draw(LOffsetX, LOffsetY, LGraphic)
    else
      LMetafileCanvas.StretchDraw(Rect(0, 0, LWidth, LHeight), LGraphic);
    FreeAndNil(LMetafileCanvas);
  end
end;

function TgtCustomDocumentEngine.GetImageResourceIndex
  (AGraphic: TGraphic): Integer;
var
  LImageHashValue: TgtHashValue;
  LStream: TMemoryStream;
begin
  Result := -1;
  if (AGraphic <> nil) then
  begin
    LImageHashValue := TgtHashValue.Create;
    LStream := TMemoryStream.Create;
    try
      AGraphic.SaveToStream(LStream);
      Result := FindImageResourceIndex(LStream, LImageHashValue);
      if (Result = -1) then
      begin
        Result := FImageResourceList.Add(AGraphic);
        FImageResourceHashList.Insert(Result, LImageHashValue);
      end
      else
        FreeAndNil(LImageHashValue)
    finally
      if Assigned(LStream) then
        LStream.Free;
    end;
  end;
end;

function TgtCustomDocumentEngine.GetImageResourceIndex
  (AStream: TStream): Integer;
var
  LImageHashValue: TgtHashValue;
begin
  LImageHashValue := TgtHashValue.Create;
  Result := FindImageResourceIndex(AStream, LImageHashValue);
  if (Result = -1) then
  begin
    Result := FImageResourceList.Add(AStream);
    FImageResourceHashList.Insert(Result, LImageHashValue);
  end
  else
    FreeAndNil(LImageHashValue);

end;

function TgtCustomDocumentEngine.NewRow(Height: Double): Double;
var
  PageHeight, PageBottomMargin, PageFooterHeight, PageTopMargin,
    PageHeaderHeight, ConversionFactor: Double;
begin
  ConversionFactor := NativeConversionFactor;
  PageHeight := Page.Height * ConversionFactor;
  PageBottomMargin := Page.BottomMargin * ConversionFactor;
  PageFooterHeight := Page.FooterHeight * ConversionFactor;
  PageTopMargin := Page.TopMargin * ConversionFactor;
  PageHeaderHeight := Page.HeaderHeight * ConversionFactor;
  Result := -1;

  if FIsTableStarted then
    with FTableItem do
    begin
      FRowItemsList.Add(TList.Create);
      Result := FBandRect.Bottom - Y - CalculateRowHeight;
      RowCount := RowCount + 1;
      if ((Height * ConversionFactor) >
        (PageHeight - (PageBottomMargin + PageFooterHeight + PageTopMargin +
        PageHeaderHeight)) - Settings.TitleHeight) then
      begin
        Height := (PageHeight - (PageBottomMargin + PageFooterHeight +
          PageTopMargin + PageHeaderHeight)) - Settings.TitleHeight;
        RowHeights.Add(TObject(Floor(Height)));
      end
      else
        RowHeights.Add(TObject(Round(NativeYPos(Height))));
      Result := Result - Height;
    end;
  Result := Result / FNativeConversionFactor;
end;

function TgtCustomDocumentEngine.NewRow: Double;
var
  PageHeight, PageBottomMargin, PageFooterHeight, PageTopMargin,
    PageHeaderHeight: Double;
begin
  PageHeight := Page.Height * NativeConversionFactor;
  PageBottomMargin := Page.BottomMargin * NativeConversionFactor;
  PageFooterHeight := Page.FooterHeight * NativeConversionFactor;
  PageTopMargin := Page.TopMargin * NativeConversionFactor;
  PageHeaderHeight := Page.HeaderHeight * NativeConversionFactor;
  Result := -1;
  if FIsTableStarted then
    with FTableItem do
    begin
      FRowItemsList.Add(TList.Create);
      Result := FBandRect.Bottom - Y - CalculateRowHeight;
      RowCount := RowCount + 1;
      if (Settings.RowHeight > (PageHeight - (PageBottomMargin +
        PageFooterHeight + PageTopMargin + PageHeaderHeight)) -
        Settings.TitleHeight) then
      begin
        Settings.RowHeight := PageHeight -
          (PageBottomMargin + PageFooterHeight + PageTopMargin +
          PageHeaderHeight) - Settings.TitleHeight - 1;
        RowHeights.Add(TObject(Round(Settings.RowHeight)));
      end
      else
        RowHeights.Add(TObject(Round(Settings.RowHeight)));
      Result := Result - Settings.RowHeight;
    end;
  Result := Result / FNativeConversionFactor;
end;

procedure TgtCustomDocumentEngine.PlayMetafile(Metafile: TMetafile);
begin
  if not FIsDocumentStarted then
    exit;
  FNoSorting := False;
{$IFNDEF gtRegistered}
{$IFDEF gtFileMaker}
  if (not FStatusMgr.IsException) then
{$ENDIF}
    if FPageCount > CMaxPages then
      exit;
{$ENDIF}
  ProcessMetafile(0, 0, Metafile);
end;

procedure TgtCustomDocumentEngine.PlayMetafile(DestRect: TgtRect;
  Metafile: TMetafile);
var
  LRect: TRect;
  Value: Double;
begin
  if not FIsDocumentStarted then
    exit;
  FNoSorting := False;
{$IFNDEF gtRegistered}
{$IFDEF gtFileMaker}
  if (not FStatusMgr.IsException) then
{$ENDIF}
    if FPageCount > CMaxPages then
      exit;
{$ENDIF}
  Value := CalculateNativeUnitFactor(FMeasurementUnit);

  LRect.Left := Round(DestRect.Left * Value);
  LRect.Top := Round(DestRect.Top * Value);
  LRect.Right := Round(DestRect.Right * Value);
  LRect.Bottom := Round(DestRect.Bottom * Value);

  Canvas.StretchDraw(LRect, Metafile);
end;

procedure TgtCustomDocumentEngine.PlayMetafile(X, Y: Double;
  Metafile: TMetafile);
begin
  if not FIsDocumentStarted then
    exit;
  FNoSorting := False;
{$IFNDEF gtRegistered}
{$IFDEF gtFileMaker}
  if (not FStatusMgr.IsException) then
{$ENDIF}
    if FPageCount > CMaxPages then
      exit;
{$ENDIF}
  ProcessMetafile(NativeXPos(X), NativeYPos(Y), Metafile);
end;

procedure TgtCustomDocumentEngine.RestoreEngineState(Index: Integer);
var
  LEngineState: TgtEngineState;
begin
  if not FIsDocumentStarted then
    exit;
  if (Index >= -1) and (Index < FEngineStateList.Count) then
  begin
    if Index = -1 then { Restore last stored state }
      Index := FEngineStateList.Count - 1;
    LEngineState := TgtEngineState(FEngineStateList.Items[Index]);
    Font.Assign(LEngineState.FFont);
    Pen.Assign(LEngineState.FPen);
    Brush.Assign(LEngineState.FBrush);
    ImageSettings.Assign(LEngineState.FImageSettings);
    FTextFormatting.Assign(LEngineState.FTextFormatting);
    FTableSettings.Assign(LEngineState.FTableSettings);
    FPage.Assign(LEngineState.FPage);
    FTextEffects.Assign(LEngineState.FTextEffects);
  end
  else if Assigned(FOnErrorMessage) then
    OnErrorMessage(Self, EInvalidEngineState.Create(SInvalidEngineState))
  else
    raise EInvalidEngineState.Create(SInvalidEngineState);
end;

function TgtCustomDocumentEngine.SaveEngineState: Integer;
var
  LEngineState: TgtEngineState;
begin
  Result := -1;
  if not FIsDocumentStarted then
    exit;
  LEngineState := TgtEngineState.Create;
  LEngineState.FFont.Assign(Font);
  LEngineState.FBrush.Assign(Brush);
  LEngineState.FPen.Assign(Pen);
  LEngineState.FImageSettings.Assign(ImageSettings);
  LEngineState.FTextFormatting.Assign(FTextFormatting);
  LEngineState.FTableSettings.Assign(FTableSettings);
  LEngineState.FTextEffects.Assign(TextEffects);
  LEngineState.FPage.Assign(Page);
  Result := FEngineStateList.Add(LEngineState);
end;

procedure TgtCustomDocumentEngine.SetFileDescription(const Value: String);
begin
  FDescription := Value;
end;

procedure TgtCustomDocumentEngine.SetDocInfo(const Value: TgtDocInfo);
begin
  FDocInfo.Assign(Value);
end;

procedure TgtCustomDocumentEngine.SetEMailSettings
  (const Value: TgtEmailSettings);
begin
  FEmailSettings.Assign(Value);
end;

procedure TgtCustomDocumentEngine.SetFileExtension(const Value: String);
begin
  FFileExtension := Value;
end;

procedure TgtCustomDocumentEngine.SetWorkingPage(PageNo: Integer);
begin
  if Preferences.ProcessAfterEachPage then
    exit;

  if ((PageNo > 0) and (PageNo <= FPageCount)) then
  begin

    if FCurrentPage > 0 then { Render current canvas }
    begin
      Pages[FCurrentPage - 1].FOffsetY := FCurrentOffsetY;
      Canvas.Free;
      Canvas := nil;
      ProcessMetafile(0, 0, FMetafile);

      FMetafile.Width := Round(Pages[FCurrentPage - 1].Settings.Width);
      FMetafile.Height := Round(Pages[FCurrentPage - 1].Settings.Height);
      Canvas := TMetafileCanvas.Create(FMetafile, 0);
    end;

    FCurrentPage := PageNo;

    with TgtPageItem(FPages.Items[FCurrentPage - 1]) do
    begin
      FCurrentDocumentItemList := FDocumentItems;
      FCurrentTextItemList := FTextItems;
      FCurrentOffsetY := FOffsetY;
    end;
  end
  else if Assigned(FOnErrorMessage) then
    OnErrorMessage(Self, EInvalidPageNumber.Create(SInvalidPageNo))
  else
    raise EInvalidPageNumber.Create(SInvalidPageNo);
end;

function TgtCustomDocumentEngine.TextSize(const Text: WideString;
  AFont: TFont): TSize;
var
  DC: hdc;
  SaveFont: HFont;
  LSize: TSize;
  LStr: AnsiString;
begin
  Result.cx := 0;
  Result.cy := 0;
  if Text = '' then
  begin
    LSize := TextSize(' ', AFont);
    LSize.cx := 1;
  end
  else
  begin
    if (not IsDBCSLeadByte(Byte(Text[1]))) then
    begin
      LStr := AnsiString(Text);
      LStr := RemoveTerminalCRLF(LStr);
    end;
    DC := GetDC(0);
    SaveFont := SelectObject(DC, AFont.handle);
    if (not IsDBCSLeadByte(Byte(Text[1]))) then
      GetTextExtentPoint32A(DC, PAnsiChar(LStr), Length(LStr), LSize)
    else
      GetTextExtentPoint32W(DC, PWideChar(Text), Length(Text), LSize);
    SelectObject(DC, SaveFont);
    ReleaseDC(0, DC);
  end;
  Result := LSize;

end;

function TgtCustomDocumentEngine.TextSizeW(const Text: WideString;
  AFont: TFont): TSize;
var
  DC: hdc;
  SaveFont: HFont;
  LSize: TSize;
begin
  Result.cx := 0;
  Result.cy := 0;

  DC := GetDC(0);
  SaveFont := SelectObject(DC, AFont.handle);
  GetTextExtentPoint32W(DC, PWideChar(Text), Length(Text), LSize);
  SelectObject(DC, SaveFont);
  ReleaseDC(0, DC);
  Result := LSize;
end;
// {$IFDEF gtDelphi6Up}
//
// function TgtCustomDocumentEngine.TextSize(const Text: AnsiString;
// AFont: TFont): TSize;
// var
// DC: hdc;
// SaveFont: HFont;
// LSize: TSize;
// LStr: String;
// begin
// Result.cx := 0;
// Result.cy := 0;
// if Text = '' then
// begin
// LSize := TextSize(' ', AFont);
// LSize.cx := 1;
// end
// else
// begin
// if (not IsDBCSLeadByte(Byte(Text[1]))) then
// begin
// LStr := String(Text);
// LStr := String(RemoveTerminalCRLF(AnsiString(LStr)));
// end;
// DC := GetDC(0);
// SaveFont := SelectObject(DC, AFont.handle);
// if (not IsDBCSLeadByte(Byte(Text[1]))) then
// GetTextExtentPoint32(DC, PChar(LStr), Length(LStr), LSize)
// else
// GetTextExtentPoint32A(DC, PAnsiChar(Text), Length(Text), LSize);
// SelectObject(DC, SaveFont);
// ReleaseDC(0, DC);
// end;
// Result := LSize;
// end;
// {$ENDIF}

procedure TgtCustomDocumentEngine.DrawJPEGDirect(ARect: TgtRect;
  AImagePixelWidth, AImagePixelHeight: Integer; AStream: TStream);
begin
  if not FIsDocumentStarted or not(ckImage in Capabilities) or
    not(irImage in ItemsToRender) then
    exit;
{$IFNDEF gtRegistered}
{$IFDEF gtFileMaker}
  if (not FStatusMgr.IsException) then
{$ENDIF}
    if FPageCount > CMaxPages then
      exit;
{$ENDIF}
  ARect := NativeRect(ARect);
  FImageStream := TgtImageStream.Create(ARect);
  FImageStream.X := ARect.Left;
  FImageStream.Y := ARect.Top;
  FImageStream.DisplayRect := ARect;
  AStream.Position := 0;
  FImageStream.IndexNo := GetImageResourceIndex(AStream);
  FImageStream.Stream.CopyFrom(AStream, 0);
  FImageStream.ImageHeight := AImagePixelHeight;
  FImageStream.ImageWidth := AImagePixelWidth;
  FImageStream.Settings := ImageSettings;
  AddDocumentItem(FImageStream);
end;

procedure TgtCustomDocumentEngine.DrawImage(ImageRect: TgtRect;
  AGraphic: TGraphic);
begin
  if not FIsDocumentStarted or not(ckImage in Capabilities) or
    not(irImage in ItemsToRender) then
    exit;
{$IFNDEF gtRegistered}
{$IFDEF gtFileMaker}
  if (not FStatusMgr.IsException) then
{$ENDIF}
    if FPageCount > CMaxPages then
      exit;
{$ENDIF}
  ImageRect := NativeRect(ImageRect);
  CreateImageItem(ImageRect, AddImageAsResource(AGraphic,
    Preferences.UseImagesAsResources));
end;

procedure TgtCustomDocumentEngine.DrawImage(X, Y: Double; AGraphic: TGraphic);
begin

  if not FIsDocumentStarted or not(ckImage in Capabilities) or
    not(irImage in ItemsToRender) then
    exit;
{$IFNDEF gtRegistered}
{$IFDEF gtFileMaker}
  if (not FStatusMgr.IsException) then
{$ENDIF}
    if FPageCount > CMaxPages then
      exit;
{$ENDIF}
  X := NativeXPos(X);
  Y := NativeYPos(Y);
  CreateImageItem(gtRect(X, Y, X + (AGraphic.Width * CPixelsPerInch /
    InputXRes), Y + (AGraphic.Height * CPixelsPerInch / InputXRes)),
    AddImageAsResource(AGraphic, Preferences.UseImagesAsResources));
end;

procedure TgtCustomDocumentEngine.DrawImage(ColumnNo: Integer;
  Width, Height: Double; AGraphic: TGraphic);
var
  LWidth, LHeight: Longint;
begin
  if not FIsDocumentStarted or not(ckImage in Capabilities) or
    not(irImage in ItemsToRender) then
    exit;

  if FIsTableStarted and (FTableItem.RowCount >= 0) and
    ((ColumnNo >= 0) and (ColumnNo < FTableItem.ColCount)) then
  begin

    FImageItem := TgtImageItem.Create;
    FImageItem.Settings := ImageSettings;
    if ImageSettings.IsFrame then
    begin
      FImageItem.Frame := Frame;
      FImageItem.Pen := Pen;
    end;
    FImageItem.Brush := Brush;
    FImageItem.IndexNo := AddImageAsResource(AGraphic,
      Preferences.UseImagesAsResources);

    FImageItem.X := ColumnNo;
    FImageItem.Y := FTableItem.RowCount;

    with FTableItem.Settings.InternalMargin do
    begin
      if ImageSettings.AutoSize then
      begin
        Width := AGraphic.Width;
        Height := AGraphic.Height;
      end
      else
      begin
        Width := NativeXPos(Width);
        Height := NativeYPos(Height);
      end;

      LWidth := Round(Left + Right + Width);
      LHeight := Round(Top + Bottom + Height);

      if FTableItem.Settings.AutoAdjustColumnWidth then
      begin
        if FTableItem.Columns[ColumnNo].Width < LWidth then
          FTableItem.Columns[ColumnNo].Width := LWidth;
      end
      else
      begin
        if FTableItem.Columns[ColumnNo].Width < LWidth then
          LWidth := Round(FTableItem.Columns[ColumnNo].Width);
        LHeight := Round((LWidth - Left - Right) * (Height / Width) + Top
          + Bottom);
      end;

      if Int64(FTableItem.RowHeights[FTableItem.RowCount]) < LHeight then
        FTableItem.RowHeights.Items[FTableItem.RowCount] := TObject(LHeight);

      FImageItem.Settings.AutoSize := False;

      FImageItem.Width := LWidth - Left - Right;
      FImageItem.Height := LHeight - Top - Bottom;

      FImageItem.DisplayRect := gtRect(0, 0, FImageItem.Width,
        FImageItem.Height);

      FTableItem.RowItemsList[FTableItem.RowCount].Add(FImageItem);
    end;
  end;
end;

procedure TgtCustomDocumentEngine.CreateImageItem(ImageRect: TgtRect;
  Index: Integer);
var
  LGraphic: TGraphic;
  LW, LH, LDW, LDH, LAspectRatio: Double;
begin
  with ImageRect do
  begin
    Left := FBandRect.Left + Left;
    Right := FBandRect.Left + Right;
    Top := FBandRect.Top + Top;
    Bottom := FBandRect.Top + Bottom;
  end;
  if (Index >= FImageResourceList.Count) or (Index < 0) then
    exit;
  if IsDocumentItemInRange(ImageRect.Left, ImageRect.Top) then
  begin
    FImageItem := TgtImageItem.Create(ImageRect);
    FImageItem.Settings := ImageSettings;

    with FImageItem do
    begin
      LGraphic := GetGraphicResource(Index);
      if Settings.AutoSize then
      begin { Adjust width and Height accoding to SourceDPI }
        if (Settings.SourceDPI <> -1) then
        begin
          Width := LGraphic.Width / (Settings.SourceDPI / CPixelsPerInch);
          Height := LGraphic.Height / (Settings.SourceDPI / CPixelsPerInch);
        end
        else
        begin
          Width := LGraphic.Width;
          Height := LGraphic.Height;
        end;
        DisplayRect := gtRect(X, Y, X + Width, Y + Height);
      end
      else
      begin
        LW := LGraphic.Width;
        LH := LGraphic.Height;
        LDW := DisplayRect.Right - DisplayRect.Left;
        LDH := DisplayRect.Bottom - DisplayRect.Top;
        if Settings.Stretch or (Settings.KeepAspectRatio and
          ((LW > LDW) or (LH > LDH))) then
        begin
          if Settings.KeepAspectRatio and (LW > 0) and (LH > 0) then
          begin
            LAspectRatio := LW / LH;
            if LW > LH then
            begin
              LW := LDW;
              LH := LDW / LAspectRatio;
              if LH > LDH then
              begin
                LH := LDH;
                LW := LDH * LAspectRatio;
              end;
            end
            else
            begin
              LH := LDH;
              LW := LDH * LAspectRatio;
              if LW > LDW then
              begin
                LW := LDW;
                LH := LDW / LAspectRatio;
              end;
            end;
          end
          else
          begin
            LW := LDW;
            LH := LDH;
          end;
        end
        else
        begin
          if (LDW < LW) or (LDH < LH) then
          begin
            LW := LDW;
            LH := LDH;
          end;
        end;
        Width := Round(LW);
        Height := Round(LH);
        if Settings.Center then
        begin
          X := X + (LDW - LW) / 2;
          Y := Y + (LDH - LH) / 2;
        end;
      end;
    end;
    if ImageSettings.IsFrame then
    begin
      FImageItem.Frame := FFrame;
      FImageItem.Pen := Pen;
    end;
    if LGraphic is TBitmap then
    begin
      FImageItem.Brush := TBitmap(LGraphic).Canvas.Brush;
    end
    else
      FImageItem.Brush := Brush;

    FImageItem.IndexNo := Index;
    AddDocumentItem(FImageItem);
  end;
end;

procedure TgtCustomDocumentEngine.DrawImage(ImageRect: TgtRect; Index: Integer);
begin
  if not FIsDocumentStarted or not(ckImage in Capabilities) or
    not(irImage in ItemsToRender) then
    exit;
{$IFNDEF gtRegistered}
{$IFDEF gtFileMaker}
  if (not FStatusMgr.IsException) then
{$ENDIF}
    if FPageCount > CMaxPages then
      exit;
{$ENDIF}
  ImageRect := NativeRect(ImageRect);
  CreateImageItem(ImageRect, Index);
end;

function TgtCustomDocumentEngine.NativeXPos(AX: Double): Double;
begin
  Result := AX * FNativeConversionFactor;
  if FNativeConversionFactor = 1 then
    Result := AX * FNativeConversionFactor * (CPixelsPerInch / InputXRes);
end;

function TgtCustomDocumentEngine.NativeYPos(AY: Double): Double;
begin
  Result := AY * FNativeConversionFactor;
  if FNativeConversionFactor = 1 then
    Result := AY * FNativeConversionFactor * (CPixelsPerInch / InputYRes);
end;

function TgtCustomDocumentEngine.NativeRect(ARect: TgtRect): TgtRect;
begin
  Result.Left := NativeXPos(ARect.Left);
  Result.Right := NativeXPos(ARect.Right);
  Result.Top := NativeYPos(ARect.Top);
  Result.Bottom := NativeYPos(ARect.Bottom);
end;

function TgtCustomDocumentEngine.IsDocumentItemInRange(X, Y: Double): Boolean;
begin
  Result := False;
  with FBandRect do
    if ((Y >= Top) and (Y < Bottom)) and ((X >= Left) and (X < Right)) then
      Result := True;
end;

function TgtCustomDocumentEngine.WrapTextIntoLines(Text: String;
  Width, FirstLineWidth: Double; Lines: TStringList; AutoResize: Boolean;
  AFont: TFont): Integer;
var
  I, J: Integer;
  TextLength, LastWordPosn: Integer;
  LineWidth, WordLength: Double;
  TempStr: String;
  Flag: Boolean;
begin
  Result := Round(Width);
  if AutoResize then { For Tables if AutoAdjustcolumn is true then }
  begin
    Lines.Clear;
    Lines.Add(Text);
    // Result := WrapTextIntoLines(Text, Width, Width, Lines, AutoResize, AFont);
    Result := Round(TextSize(Text + ' ', AFont).cx + 2 * Pen.Width);
  end
  else
  begin
    if Width <= 0 then
      exit;
    LastWordPosn := 0;
    TextLength := Length(Text);
    Flag := False;

    if Lines.Count <= 1 then
      LineWidth := FirstLineWidth
    else
      LineWidth := Width;
    if Lines.Count <> 0 then
      LineWidth := LineWidth - TextSize(Lines[Lines.Count - 1], AFont).cx
    else
      Lines.Append('');
    for I := 1 to TextLength do
{$IFDEF gtDelphi2009Up}
      if (I = TextLength) or (not Flag and SysUtils.CharInSet(Text[I],
        [SP, CR, LF, NUL])) then
      begin
        if SysUtils.CharInSet(Text[I], [CR, LF]) then
{$ELSE}
      if (I = TextLength) or (not Flag and (Text[I] in [SP, CR, LF, NUL])) then
      begin
        if Text[I] in [CR, LF] then
{$ENDIF}
          TempStr := System.Copy(Text, LastWordPosn + 1, I - LastWordPosn - 1)
        else
          TempStr := System.Copy(Text, LastWordPosn + 1, I - LastWordPosn);

        WordLength := TextSize(TempStr, AFont).cx;
        if WordLength <> 0 then
          if WordLength <= LineWidth then
          begin
            Lines[Lines.Count - 1] := Lines[Lines.Count - 1] + TempStr;
            LineWidth := LineWidth - WordLength;
          end
          else
          begin
            if WordLength > Width then
            begin
              repeat
                J := I;
                repeat
                  Dec(J);
                until TextSize(System.Copy(Text, LastWordPosn,
                  J - LastWordPosn), AFont).cx <= Width;
                Lines.Append(System.Copy(Text, LastWordPosn, J - LastWordPosn));
                LastWordPosn := J;
                TempStr := System.Copy(Text, LastWordPosn, I - LastWordPosn);
                WordLength := TextSize(TempStr, AFont).cx;
              until WordLength <= Width;
            end;
            LineWidth := Width - WordLength;
            Lines.Append(TempStr);
          end;
{$IFDEF gtDelphi2009Up}
        if SysUtils.CharInSet(Text[I], [CR, LF]) then
{$ELSE}
        if Text[I] in [CR, LF] then
{$ENDIF}
        begin
          Lines[Lines.Count - 1] := Lines[Lines.Count - 1] + CR + LF;
          Lines.Append('');
          LineWidth := Width;
        end;
        LastWordPosn := I;
        Flag := True;
      end
      else
      begin
{$IFDEF gtDelphi2009Up}
        if SysUtils.CharInSet(Text[I], [CR, LF]) then
{$ELSE}
        if Text[I] in [CR, LF] then
{$ENDIF}
          LastWordPosn := I;
        Flag := False;
      end;
  end;
  if Lines[Lines.Count - 1] = '' then
    Lines.Delete(Lines.Count - 1);
end;

function TgtCustomDocumentEngine.WrapTextIntoLines(Text: WideString;
  Width, FirstLineWidth: Double; Lines: TWideStrings; AutoResize: Boolean;
  AFont: TFont): Integer;
var
  I, J: Integer;
  TextLength, LastWordPosn: Integer;
  LineWidth, WordLength: Double;
  TempStr, LStr: WideString;
  Flag: Boolean;
begin
  Result := Round(Width);

  if AutoResize then { For Tables if AutoAdjustcolumn is true then }
  begin
    Lines.Clear;
    Lines.Add(Text);
    // Result := WrapTextIntoLines(Text, Width, Width, Lines, AutoResize, AFont);
    Result := Round(TextSize(Text + ' ', AFont).cx + 2 * Pen.Width);
  end
  else
  begin
    if Width <= 0 then
      exit;
    LastWordPosn := 0;
    TextLength := Length(Text);
    Flag := False;

    if Lines.Count <= 1 then
      LineWidth := FirstLineWidth
    else
      LineWidth := Width;
    if Lines.Count <> 0 then
      LineWidth := LineWidth - TextSize(Lines[Lines.Count - 1], AFont).cx;
    // else Lines.Add('');
    for I := 1 to TextLength do
      if (I = TextLength) or
        (not Flag and ((Text[I] = SP) or (Text[I] = CR) or (Text[I] = LF) or
        (Text[I] = NUL))) then
      begin
        if ((Text[I] = CR) or (Text[I] = LF)) then
          TempStr := System.Copy(Text, LastWordPosn + 1, I - LastWordPosn - 1)
        else
          TempStr := System.Copy(Text, LastWordPosn + 1, I - LastWordPosn);

        WordLength := TextSize(TempStr, AFont).cx;
        if WordLength <> 0 then
          if WordLength <= LineWidth then
          begin
            if Lines.Count = 0 then
              Lines.Add(TempStr)
            else
              Lines[Lines.Count - 1] := Lines[Lines.Count - 1] + TempStr;
            LineWidth := LineWidth - WordLength;
          end
          else
          begin
            if WordLength > Width then
            begin
              repeat
                J := I;
                repeat
                  LStr := System.Copy(Text, LastWordPosn + 1,
                    J - LastWordPosn - 1);
                  Dec(J);
                until TextSize(LStr, AFont).cx <= Width;
                if (LStr <> '') then
                begin
                  // Lines.Add(System.Copy(Text, LastWordPosn, J - LastWordPosn));
                  Lines.Add(LStr);
                  LastWordPosn := J;
                  TempStr := System.Copy(Text, LastWordPosn + 1,
                    I - LastWordPosn);
                  WordLength := TextSize(TempStr, AFont).cx;
                end
                else
                begin
                  WordLength := -1;
                  Break;
                end;
              until WordLength <= Width;
            end;
            if (WordLength <> -1) then
            begin
              LineWidth := Width - WordLength;
              Lines.Add(TempStr);
            end
            else
              Break;
          end;
        if ((Text[I] = CR) or (Text[I] = LF)) then
        begin
          Lines[Lines.Count - 1] := Lines[Lines.Count - 1] + CR + LF;
          Lines.Add('');
          LineWidth := Width;
        end;
        LastWordPosn := I;
        Flag := True;
      end
      else
      begin
        if ((Text[I] = CR) or (Text[I] = LF)) then
          LastWordPosn := I;
        Flag := False;
      end;
  end;
  if Lines.Strings[Lines.Count - 1] = '' then
    Lines.Delete(Lines.Count - 1);
end;

function TgtCustomDocumentEngine.GetPages(Index: Integer): TgtPageItem;
begin
  Result := TgtPageItem(FPages.Items[Index]);
end;

function TgtCustomDocumentEngine.GetFileName: String;
begin
  Result := FFileName;
end;

function TgtCustomDocumentEngine.GetBackgroundColor: TColor;
begin
  Result := FBackgroundColor;
end;

function TgtCustomDocumentEngine.GetBackgroundDisplayType
  : TgtBackgroundDisplayType;
begin
  Result := FBackgroundDisplayType;
end;

function TgtCustomDocumentEngine.GetBackgroundImage: TPicture;
begin
  Result := FBackgroundImage;
end;

function TgtCustomDocumentEngine.GetBrush: TBrush;
begin
  Result := FBrush;
end;

function TgtCustomDocumentEngine.GetCanvas: TMetafileCanvas;
begin
  Result := FCanvas;
end;

function TgtCustomDocumentEngine.GetCurrentPage: Integer;
begin
  Result := FCurrentPage;
end;

function TgtCustomDocumentEngine.GetDefaultFont: TFont;
begin
  Result := FDefaultFont;
end;

function TgtCustomDocumentEngine.GetFileDescription: String;
begin
  Result := FDescription;
end;

function TgtCustomDocumentEngine.GetDocInfo: TgtDocInfo;
begin
  Result := FDocInfo;
end;

function TgtCustomDocumentEngine.GetEMailSettings: TgtEmailSettings;
begin
  Result := FEmailSettings;
end;

function TgtCustomDocumentEngine.GetFileExtension: String;
begin
  Result := FFileExtension;
end;

function TgtCustomDocumentEngine.GetFont: TFont;
begin
  Result := FFont;
end;

function TgtCustomDocumentEngine.GetFrame: TgtFrame;
begin
  Result := FFrame;
end;

function TgtCustomDocumentEngine.GetImageSettings: TgtImageSettings;
begin
  Result := FImageSettings;
end;

function TgtCustomDocumentEngine.GetMeasurementUnit: TgtUnitType;
begin
  Result := FMeasurementUnit;
end;

function TgtCustomDocumentEngine.GetPage: TgtPageSettings;
begin
  Result := FPage;
end;

function TgtCustomDocumentEngine.GetTextFormatting: TgtTextFormatting;
begin
  Result := FTextFormatting;
end;

function TgtCustomDocumentEngine.GetPen: TPen;
begin
  Result := FPen;
end;

function TgtCustomDocumentEngine.GetPreferences: TgtPreferences;
begin
  Result := FPreferences;
end;

function TgtCustomDocumentEngine.GetTableSettings: TgtTableSettings;
begin
  Result := FTableSettings;
end;

function TgtCustomDocumentEngine.GetUserStream: TStream;
begin
  Result := FUserStream;
end;

procedure TgtCustomDocumentEngine.SetBrush(const Value: TBrush);
begin
  FBrush.Assign(Value);
end;

procedure TgtCustomDocumentEngine.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
end;

procedure TgtCustomDocumentEngine.SetDefaultFont(const Value: TFont);
begin
  FDefaultFont.Assign(Value);
end;

procedure TgtCustomDocumentEngine.SetPen(const Value: TPen);
begin
  FPen.Assign(Value);
end;

procedure TgtCustomDocumentEngine.SetPage(const Value: TgtPageSettings);
begin
  FPage.Assign(Value);
end;

function TgtCustomDocumentEngine.GetGraphicResource(Index: Integer): TGraphic;
begin
  Result := nil;
  if (Index >= 0) and (Index < FImageResourceList.Count) then
    Result := TGraphic(FImageResourceList.Items[Index]);
end;

procedure TgtCustomDocumentEngine.CalculateBandRect;
begin
  if not FIsDocumentStarted then
    exit;
  if FPages.Count >= FCurrentPage then
  begin
    with TgtPageItem(FPages.Items[FCurrentPage - 1]).FSettings do
    begin
      if FReferencePoint = rpPage then
        FBandRect := gtRect(0, 0, Width, Height)
      else if FReferencePoint = rpMargin then
        FBandRect := gtRect(LeftMargin, TopMargin, Width - RightMargin,
          Height - BottomMargin)
      else
      begin
        case FBandType of
          btHeader:
            begin
              FBandRect.Top := TopMargin * (InputYRes / CPixelsPerInch);
              FBandRect.Bottom := (TopMargin + HeaderHeight) *
                (InputYRes / CPixelsPerInch);
            end;
          btFooter:
            begin
              FBandRect.Top := (Height - FooterHeight - BottomMargin) *
                (InputYRes / CPixelsPerInch);
              FBandRect.Bottom := (FBandRect.Top + FooterHeight) *
                (InputYRes / CPixelsPerInch);
            end;
          btContent:
            begin
              FBandRect.Top := (TopMargin + HeaderHeight) *
                (InputYRes / CPixelsPerInch);
              FBandRect.Bottom := (Height - FooterHeight - BottomMargin) *
                (InputYRes / CPixelsPerInch);
            end;
          btWatermark, btStamp:
            begin
              FBandRect.Top := TopMargin * (InputYRes / CPixelsPerInch);
              FBandRect.Bottom := (Height - BottomMargin) *
                (InputYRes / CPixelsPerInch);
            end;
        end;
        FBandRect.Left := LeftMargin * (InputYRes / CPixelsPerInch);
        FBandRect.Right := (Width - RightMargin) * (InputYRes / CPixelsPerInch);
      end;
    end;
  end;
end;

procedure TgtCustomDocumentEngine.ClipShapeCoordinates(Points: TgtPoints;
  NoPoints: Integer);
var
  I: Integer;
begin
  for I := 0 to NoPoints - 1 do
  begin
    Points[I].X := NativeXPos(Points[I].X) + FBandRect.Left;
    Points[I].Y := NativeYPos(Points[I].Y) + FBandRect.Top;
    { if Points[I].X < FBandRect.Left then
      Points[I].X := FBandRect.Left
      else
      if Points[I].X > FBandRect.Right then
      Points[I].X := FBandRect.Right;

      Points[I].Y := NativeYPos(Points[I].Y) + FBandRect.Top;
      if Points[I].Y < FBandRect.Top then
      Points[I].Y := FBandRect.Top
      else
      if Points[I].Y > FBandRect.Bottom then
      Points[I].Y := FBandRect.Bottom; }
  end;
end;

procedure TgtCustomDocumentEngine.ProcessTextRect(ATextItem: TgtTextItem;
  HAlign: TgtHAlignment; VAlign: TgtVAlignment; MaxWidth, MaxHeight: Double;
  Margin: TgtRect);
var
  I, LineCount: Integer;
  LTextItem: TgtTextItem;
  LS: WideString;
begin
  LTextItem := TgtTextItem.Create;
  with ATextItem do
  begin
    LTextItem.Font := Font;
    LTextItem.Brush := Brush;
    LTextItem.TextEffects := TextEffects;
    LTextItem.RotationAngle := RotationAngle;
    LTextItem.Alignment := Alignment;
    MaxWidth := MaxWidth - Margin.Left - Margin.Right;
    MaxHeight := MaxHeight - Margin.Top - Margin.Bottom;

    LineCount := Round(MaxHeight / TextSize('W', Font).cy);

    if LineCount > Lines.Count then
      LineCount := Lines.Count;

    case VAlign of
      vaBottom:
        LTextItem.Y := Y + MaxHeight - LineCount * TextSize('W', Font).cy;
      vaCenter:
        LTextItem.Y := Y + (MaxHeight - LineCount * TextSize('W', Font).cy) / 2;
    else
      LTextItem.Y := Y + Margin.Top;
    end;

    for I := 0 to LineCount - 1 do
    begin
      LTextItem.X := X + Margin.Left;
      LS := Lines[I];
      case HAlign of
        haRight:
          LTextItem.X := X + Margin.Left + MaxWidth -
            TextSize(Lines[I], Font).cx;
        haCenter:
          LTextItem.X := X + Margin.Left +
            (MaxWidth - TextSize(Lines[I], Font).cx) / 2;
        haJustify:
          if I <> (Lines.Count - 1) then
            LS := GetJustifiedText(LS, Font, MaxWidth);
      end;

      LTextItem.Lines.Add(LS);
      EncodeText(LTextItem);
      LTextItem.Y := LTextItem.Y + TextSize(LS, Font).cy;
      LTextItem.Lines.Clear;
    end;
  end;
  FreeAndNil(LTextItem);
end;

procedure TgtCustomDocumentEngine.EncodeCustomItem(AObject: TgtDocumentItem);
begin

end;

function TgtCustomDocumentEngine.AddImageAsResource(AGraphic: TGraphic)
  : Integer;
begin
  Result := AddImageAsResource(AGraphic, True);
end;

procedure TgtCustomDocumentEngine.AdjustTextItemList(AList: TList);
var
  I, J: Integer;
  LTextItem: TgtTextItem;
  LPrevY: Double;
begin
  // Sort according to Y
  if not FNoSorting then
  begin
    for I := 0 to AList.Count - 1 do
    begin
      J := I;
      LTextItem := TgtTextItem(AList.Items[I]);
      while (J > 0) and (TgtTextItem(AList.Items[J - 1]).FY > LTextItem.FY) do
      begin
        AList.Items[J] := AList.Items[J - 1];
        Dec(J);
      end;
      AList.Items[J] := LTextItem;
    end;
  end;
  // Sort according to X
  LPrevY := -FYFactor;
  for I := 0 to AList.Count - 1 do
  begin
    LTextItem := TgtTextItem(AList.Items[I]);
    if (LTextItem.FY >= (LPrevY + FYFactor)) then
    begin
      LPrevY := LTextItem.FY;
    end
    else
    begin
      if (LPrevY <> LTextItem.FY) then
      begin
        LPrevY := LTextItem.FY;
      end
      else
      begin
        LPrevY := LTextItem.FY;
        J := I - 1;
        while (J >= 0) and ((TgtTextItem(AList.Items[J]).FY >= LPrevY) and
          (TgtTextItem(AList.Items[J]).FX > LTextItem.FX)) do
        begin
          AList.Items[J + 1] := AList.Items[J];
          Dec(J);
        end;
        AList.Items[J + 1] := LTextItem;
      end;
    end;
  end;
end;

function TgtCustomDocumentEngine.GetBitmapAsPNGStream(ABitmap: TBitmap;
  ATransColor: TColor): TStream;
const
  CDataSize = 10240;
var
  LN: Integer;
  LC, LI, LJ, LDataLeft: Cardinal;
  LImgStream, LTmpStream, LDatTmpStream, LPNGStream, LMem: TgtExtMemStream;
  LM: Byte;
  LL: Longint;
  LFlateFilter: TgtFlateFilter;
  LLen, LSize, LCrc: Cardinal;
  LRed, LGreen, LBlue: Byte;
  LCrcTable: array [0 .. 255] of Cardinal;

  function GetCRC(AStream: TgtExtMemStream): Cardinal;
  var
    LI: Integer;
    LSize: Int64;
    LBytes: array of Byte;
  begin
    LSize := AStream.Size;
    SetLength(LBytes, Integer(LSize));
    AStream.Position := 0;
    Result := $FFFFFFFF;
    for LI := 0 to (LSize - 1) do
    begin
      Result := LCrcTable[(Result xor AStream.ReadByte) and $FF]
        xor (Result shr 8);
    end;
    Result := Result xor $FFFFFFFF;
    AStream.Position := 0;
  end;

  procedure GetRGB(const AColor: Integer; out ARed, AGreen, ABlue: Byte);
  begin
    ABlue := Byte(AColor shr 16);
    AGreen := Byte((AColor shl 16) shr 24);
    ARed := Byte((AColor shl 24) shr 24);
  end;

begin
  inherited;
  Result := TgtExtMemStream.Create;
  LDatTmpStream := TgtExtMemStream.Create;
  LPNGStream := TgtExtMemStream(Result);
  LMem := TgtExtMemStream.Create;
  try
    // init CRC Table
    for LN := 0 to 255 do
    begin
      LC := Cardinal(LN);
      for LI := 0 to 7 do
      begin
        if (LC and 1) <> 0 then
          LC := ($EDB88320) xor (LC shr 1)
        else
          LC := LC shr 1;
        LCrcTable[LN] := LC;
      end;
    end;
    LPNGStream.WriteByteArray([137, 80, 78, 71, 13, 10, 26, 10]);

    // header chunk
    LMem.WriteString('IHDR');
    LMem.WriteULongArray([ABitmap.Width, ABitmap.Height]);
    LMem.WriteByteArray([8, 2, 0, 0, 0]); // 2 for RGB
    LPNGStream.WriteULong(13);
    LPNGStream.CopyFrom(LMem, 0);
    LPNGStream.WriteULong(GetCRC(LMem));
    LMem.Clear;
    // trns chunk
    GetRGB(ATransColor, LRed, LGreen, LBlue);
    LLen := 6;
    LMem.WriteString('tRNS');
    LMem.WriteUShortArray([LRed, LGreen, LBlue]);
    LCrc := GetCRC(LMem);
    LMem.Clear;

    LPNGStream.WriteULong(LLen);
    LPNGStream.WriteString('tRNS');
    LPNGStream.WriteUShortArray([LRed, LGreen, LBlue]);
    LPNGStream.WriteULong(LCrc);

    // compressed image data chunk
    LImgStream := TgtExtMemStream.Create;
    LTmpStream := TgtExtMemStream.Create;
    for LI := 0 to (ABitmap.Height - 1) do
    begin
      LM := 0; // Preceeding Filter Bit : always 0 in this case
      LImgStream.WriteByte(LM);
      for LJ := 0 to (ABitmap.Width - 1) do
      begin
        LL := ABitmap.Canvas.Pixels[LJ, LI];
        LImgStream.WriteByteArray([((LL shl 24) shr 24), ((LL shl 16) shr 24),
          (LL shr 16)]);
      end;
    end;
    LFlateFilter := TgtFlateFilter.Create;
    LTmpStream.CopyFrom(LFlateFilter.Encode(LImgStream, clMax), 0);
    FreeAndNil(LFlateFilter);
    LTmpStream.Position := 0;
    for LI := 1 to ((LTmpStream.Size div CDataSize) + 1) do
    begin
      LDatTmpStream.Clear;
      if (LI = (Cardinal(LTmpStream.Size div CDataSize) + 1)) then
        LDataLeft := (LTmpStream.Size mod CDataSize)
      else
        LDataLeft := CDataSize;
      LDatTmpStream.CopyFrom(LTmpStream, LDataLeft);
      // WriteIDAT(LDatTmpStream);
      LSize := LDatTmpStream.Size;
      LDatTmpStream.Position := 0;
      LMem.WriteString('IDAT');
      LMem.CopyFrom(LDatTmpStream, 0);
      LPNGStream.WriteULong(LSize);
      LPNGStream.WriteString('IDAT');
      LPNGStream.CopyFrom(LDatTmpStream, 0);
      LPNGStream.WriteULong(GetCRC(LMem));
      LMem.Clear;
    end;
    FreeAndNil(LTmpStream);
    FreeAndNil(LImgStream);
    FreeAndNil(LDatTmpStream);
    // end chunk
    LMem.WriteString('IEND');
    LPNGStream.WriteULong(0);
    LPNGStream.WriteString('IEND');
    LPNGStream.WriteULong(GetCRC(LMem));
  finally
    FreeAndNil(LMem);
  end;
end;

procedure TgtCustomDocumentEngine.BeginPage;
begin
end;

procedure TgtCustomDocumentEngine.ProcessPage;
begin
{$IFNDEF gtRegistered}
{$IFNDEF gtFileMaker}
  if (FCurrentPage <= CMaxPages) then
{$ENDIF}
{$ENDIF}
    if IsPageInRange(FCurrentPage) then { If Page is not valid then Exit }
    begin

      if Assigned(FOnBeforeBeginPage) then
        OnBeforeBeginPage(Self);
      if (Preferences.ProcessAfterEachPage) then
      begin
        Canvas.Free;
        Canvas := nil;
        ProcessMetafile(0, 0, FMetafile);
      end;
      FBandType := btContent;
      BeginPage; // Notification for the start of page
      if Assigned(FOnAfterBeginPage) then
        OnAfterBeginPage(Self);

      EncodePageBorder; // Draw Page borders

      if FSortTextItems and (FCurrentPage = 1) then
      begin
        AdjustTextItemList(FHeaderItem.FTextItems);
        AdjustTextItemList(FFooterItem.FTextItems);
      end;

      if not(ckHeader in Capabilities) or (FCurrentPage = 1) then
      begin
        FBandType := btHeader;
        ProcessItemsList(FHeaderItem.FDocumentItems);
        ProcessTextList(FHeaderItem.FTextItems);
      end;

      if not(ckWatermark in Capabilities) or (FCurrentPage = 1) then
      begin
        FBandType := btWatermark;
        AdjustTextItemList(FWatermarkItem.FTextItems);
        ProcessItemsList(FWatermarkItem.FDocumentItems);
        ProcessTextList(FWatermarkItem.FTextItems);
      end;

      FBandType := btContent;
      AdjustTextItemList(TgtPageItem(FPages.Items[FCurrentPage - 1])
        .FTextItems);

      ProcessItemsList(TgtPageItem(FPages.Items[FCurrentPage - 1])
        .FDocumentItems);
      ProcessTextList(TgtPageItem(FPages.Items[FCurrentPage - 1]).FTextItems);

      if not(ckFooter in Capabilities) or (FCurrentPage = 1) then
      begin
        FBandType := btFooter;
        ProcessItemsList(FFooterItem.FDocumentItems);
        ProcessTextList(FFooterItem.FTextItems);
      end;

      if not(ckStamp in Capabilities) or (FCurrentPage = 1) then
      begin
        FBandType := btStamp;
        AdjustTextItemList(FStampItem.FTextItems);
        ProcessItemsList(FStampItem.FDocumentItems);
        ProcessTextList(FStampItem.FTextItems);
      end;

      FBandType := btContent;
      if Assigned(FOnBeforeEndPage) then
        OnBeforeEndPage(Self);

      EndPage; // End of page
      if Assigned(FOnAfterEndPage) then
        OnAfterEndPage(Self);
    end;

  if (not IsPageInRange(FCurrentPage)) then { If Page is not valid then Exit }
  begin
    if (Preferences.ProcessAfterEachPage) then
    begin
      if Assigned(Canvas) then
      begin
        Canvas.Free;
        Canvas := nil;
      end;
    end;
  end;

  FreeItemsList(TgtPageItem(FPages.Items[FCurrentPage - 1]).FTextItems);
  FreeJpegImageResource;
  FreeItemsList(TgtPageItem(FPages.Items[FCurrentPage - 1]).FDocumentItems);
  // if (Preferences.ProcessAfterEachPage) then
  // FreeImageResourceList;
  TgtPageItem(FPages.Items[FCurrentPage - 1]).Free; // to free page contents
end;

procedure TgtCustomDocumentEngine.SetBackgroundDisplayType
  (const Value: TgtBackgroundDisplayType);
begin
  FBackgroundDisplayType := Value;
end;

procedure TgtCustomDocumentEngine.SetBackgroundImage(const Value: TPicture);
begin
  FBackgroundImage.Assign(Value);
end;

function TgtCustomDocumentEngine.CheckOutputImageFormat
  (Value: TgtOutputImageFormat; var S: String): Boolean;
begin
  Result := True;
end;

procedure TgtCustomDocumentEngine.BreakParagraphIntoText;
var
  LTextItem: TgtTextItem;
  I: Integer;
  LWidth: Double;
  LS: String;
begin
  if not FIsDocumentStarted or not FIsParagraphStarted then
    exit;
  with FParagraphItem do
  begin
    FHeight := Lines.Count * TextSize('W', Font).cy * Settings.LineSpacing;
    FCurrentOffsetY := FCurrentOffsetY + FHeight;

    FIsParagraphStarted := False;

    for I := 0 to Lines.Count - 1 do
    begin
      LS := Trim(Lines[I]);

      LTextItem := TgtTextItem.Create;
      LTextItem.Font := Font;
      LTextItem.Brush := Brush;

      LTextItem.X := X + Settings.LeftIndent;
      LWidth := Width;

      if I = 0 then
      begin
        LTextItem.X := LTextItem.X + Settings.FirstLineIndent;
        LWidth := LWidth - Settings.FirstLineIndent;
      end;

      case Settings.Alignment of
        haRight:
          LTextItem.X := LTextItem.X + LWidth - TextSize(Lines[I], Font).cx;
        haCenter:
          LTextItem.X := LTextItem.X +
            (LWidth - TextSize(Lines[I], Font).cx) / 2;
        haJustify:
          if I <> (Lines.Count - 1) then
            LS := GetJustifiedText(LS, Font, LWidth);
      end;

      LTextItem.Y := Y + I * TextSize(Lines[I], Font).cy * Settings.LineSpacing;
      LTextItem.Lines.Add(LS);
      AddDocumentItem(LTextItem);
    end;
  end;
  FreeAndNil(FParagraphItem);
end;

procedure TgtCustomDocumentEngine.ProcessTextList(AList: TList);
var
  I: Integer;
begin
  for I := 0 to AList.Count - 1 do
    if TgtDocumentItem(AList.Items[I]) is TgtTextItem then
      EncodeText(TgtTextItem(AList.Items[I]))
end;

procedure TgtCustomDocumentEngine.SetFrame(const Value: TgtFrame);
begin
  FFrame.Assign(Value);
end;

procedure TgtCustomDocumentEngine.SetEngineFileNames(const Value: TStringList);
begin
  FEngineFileNames := Value;
end;

procedure TgtCustomDocumentEngine.SetSetupDialog(const Value: TgtBaseDlg);
begin
  FSetupDialog := Value;
end;

procedure TgtCustomDocumentEngine.Finish;
begin

end;

procedure TgtCustomDocumentEngine.Start;
begin

end;

function TgtCustomDocumentEngine.ShowSetupModal: Word;
begin
  Result := mrOk;
end;
{$IFNDEF gtRegistered}

procedure TgtCustomDocumentEngine.PutTrialNote;
var
  LX1, LX2, LY: Double;
  LI, LRotAng: Integer;
  LS1, LS2: String;
  LSize1, LSize2: TSize;
  LUnit: TgtUnitType;
const
  CTop = 15;
begin
  if FCurrentPage <= 0 then
    exit;
  LI := SaveEngineState;
  LRotAng := FTextRotationAngle;
  LUnit := MeasurementUnit;
  MeasurementUnit := muPixels;
  BeginStamp;
  Font.Size := 16;
  Font.Name := 'Arial';
  Font.Charset := ANSI_CHARSET;
  Font.Style := [fsBold];
  Brush.Style := bsClear;
  LS1 := 'This document was created using Gnostice eDocEngine Trial';
  LSize1 := TextSize(LS1, Font);
  LS2 := 'www.gnostice.com';
  LSize2 := TextSize(LS2, Font);

  with Pages[FCurrentPage - 1].Settings do
  begin
    // Left side
    LX1 := CTop + LeftMargin;
    LX2 := CTop + LeftMargin + LSize1.cy;
    LY := (Height + LSize1.cx) / 2;
    Font.Color := clRed;
    SetTextRotation(90);
    TextOut(LX1, LY, LS1);
    LY := (Height + LSize2.cx) / 2;
    Font.Color := clBlue;
    TextOut(LX2, LY, LS2);
    // Right side
    LX1 := Width - (CTop + LeftMargin + RightMargin);
    LX2 := Width - (CTop + LeftMargin + RightMargin + LSize1.cy);
    LY := (Height - LSize1.cx) / 2;
    Font.Color := clRed;
    SetTextRotation(270);
    TextOut(LX1, LY, LS1);
    LY := (Height - LSize2.cx) / 2;
    Font.Color := clBlue;
    TextOut(LX2, LY, LS2);
  end;
  EndStamp;
  MeasurementUnit := LUnit;
  FTextRotationAngle := LRotAng;
  RestoreEngineState(LI);
end;
{$ENDIF}

function TgtCustomDocumentEngine.GetPreferencesClassName: TgtPreferencesClass;
begin
  Result := TgtPreferences;
end;

function TgtCustomDocumentEngine.GetRotatedTextBitmap
  (ATextObject: TgtTextItem): TBitmap;
var
  LTextSize: TSize;
begin
  with ATextObject do
  begin
    LTextSize := TextSize(Lines[0], Font);

    Result := TBitmap.Create;
    Result.Width := Round(LTextSize.cx);
    Result.Height := Round(LTextSize.cy);
    Result.Transparent := True;
    Result.Canvas.Font.Assign(Font);

    gtAngleText(Lines[0], RotationAngle, Result, FX, FY);
  end;
end;

procedure TgtCustomDocumentEngine.SetItemsToRender
  (const Value: TgtItemsToRender);
begin
  FItemsToRender := Value;
end;

procedure TgtCustomDocumentEngine.CreateEMailSettingsObj;
begin
  with FEmailSettings do
    FAttachments.AddStrings(EngineFileNames);
end;

procedure TgtCustomDocumentEngine.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FSetupDialog) then
    FSetupDialog := nil;
  if (Operation = opRemove) and (AComponent = FSettings) then
    FSettings := nil;
  if (Operation = opRemove) and (AComponent = FEmailAdapter) then
    FEmailAdapter := nil;
end;

procedure TgtCustomDocumentEngine.SetSettings(const Value: TgtDocSettings);
begin
  if FSettings <> nil then
    FSettings.RemoveEngineFromList(Self);
  FSettings := Value;
  if Value <> nil then
    Value.AddEngineToList(Self);
end;

procedure TgtCustomDocumentEngine.SetBackgroundColor(const Value: TColor);
begin
  FBackgroundColor := Value;
end;

procedure TgtCustomDocumentEngine.ProcessMetafile(AX, AY: Double;
  AMetafile: TMetafile);
var
  FMetafileProcessor: TgtMetafileProcessor;
  LMetafile: TMetafile;
  LMetaCanvas: TMetafileCanvas;
begin
  FMetafileProcessor := TgtMetafileProcessor.Create(Self);
  FMetafileProcessor.FCombineCharsToSentence := True;

  // if (FSupportsTransformation) then
  // FMetafileProcessor.FApplyTransformation := True;

  if ((not(ckInputRes in Capabilities)) and ((InputXRes <> CPixelsPerInch) or
    (InputYRes <> CPixelsPerInch))) then
  begin
    LMetafile := TMetafile.Create;
    try
      LMetaCanvas := TMetafileCanvas.Create(LMetafile, 0);
      PlayEnhMetaFile(LMetaCanvas.handle, AMetafile.handle,
        Rect(0, 0, Round(NativeXPos(Page.Width)),
        Round(NativeYPos(Page.Height))));
      LMetaCanvas.Free;
      FMetafileProcessor.Execute(LMetafile, FBandRect.Left + AX,
        FBandRect.Top + AY);
    finally
      LMetafile.Free;
    end;
  end
  else
    FMetafileProcessor.Execute(AMetafile, FBandRect.Left + AX,
      FBandRect.Top + AY);
  FreeAndNil(FMetafileProcessor);
end;

procedure TgtCustomDocumentEngine.SetPagesToRender(const Value: String);
begin
  FPagesToRender := Value;
end;

function TgtCustomDocumentEngine.IsPageInRange(APageNo: Integer): Boolean;
var
  I, J, K, LF, LL: Integer;
  LStrLst: TStringList;
  LFlag: Boolean;
begin
  Result := False;
{$IFDEF gtFileMaker}
  if ((not FStatusMgr.IsException) and (FCurrentPage > CMaxPages)) then
    exit;
{$ENDIF}
  if PagesToRender = '' then
  begin
    Result := True;
    exit;
  end;
  LStrLst := TStringList.Create;
  LStrLst.CommaText := PagesToRender;
  for I := 0 to LStrLst.Count - 1 do
  begin
    LFlag := False;
    for K := 1 to Length(LStrLst.Strings[I]) do
    begin
{$IFDEF gtDelphi2009Up}
      if (not(SysUtils.CharInSet(LStrLst.Strings[I][K],
        ['0' .. '9', '-']))) then
{$ELSE}
      if (not(LStrLst.Strings[I][K] in ['0' .. '9', '-'])) then
{$ENDIF}
        LFlag := True;
    end;
    if LFlag then
      Continue;
    J := System.Pos('-', LStrLst.Strings[I]);
    if (J = 0) then
    begin
      if (StrToInt(LStrLst.Strings[I]) = APageNo) then
      begin
        Result := True;
        LStrLst.Free;
        exit;
      end;
    end
    else
    begin
      LF := StrToInt(System.Copy(LStrLst.Strings[I], 1, J - 1));
      LL := StrToInt(System.Copy(LStrLst.Strings[I], J + 1,
        Length(PagesToRender)));
      if ((APageNo >= LF) and (APageNo <= LL)) then
      begin
        Result := True;
        LStrLst.Free;
        exit;
      end;
    end;
  end;
  LStrLst.Free;
end;

procedure TgtCustomDocumentEngine.SetBandType(const Value: TgtBandType);
begin
  FBandType := Value;
  CalculateBandRect;
end;

// procedure TgtCustomDocumentEngine.SetBmpDPI(Bitmap: TBitmap; DPI: Integer);
// var
// Stream: TMemoryStream;
// Data: Word;
// begin
// try
// Stream := TMemoryStream.Create;
// Bitmap.SaveToStream(Stream);
// Data := Round(DPI * 39.370079) + 1;
// Stream.Position := 38;
// if Stream.Write(Data, 2) = 2 then
// begin
// Stream.Position := 42;
// if Stream.Write(Data, 2) = 2 then
// begin
// Stream.Position := 0;
// Bitmap.LoadFromStream(Stream);
// end
// else
// { Error writing to Stream... }
// exit;
// end
// else
// { Error writing to Stream... }
// exit;
// finally
// Stream.Free;
// end;
// end;

procedure TgtCustomDocumentEngine.FinalizeEngine;
var
  I: Integer;
begin
  RestoreEngineState(FDefaultState); // Restore engine to default state

  { Release resources }

  FreeItemsList(FHeaderItem.FDocumentItems);

  FreeItemsList(FHeaderItem.FTextItems);
  FreeItemsList(FFooterItem.FDocumentItems);
  FreeItemsList(FFooterItem.FTextItems);
  FreeItemsList(FWatermarkItem.FDocumentItems);
  FreeItemsList(FWatermarkItem.FTextItems);
  FreeItemsList(FStampItem.FDocumentItems);
  FreeItemsList(FStampItem.FTextItems);
  FreeAndNil(FHeaderItem);
  FreeAndNil(FFooterItem);
  FreeAndNil(FWatermarkItem);
  FreeAndNil(FStampItem);
  FreeAndNil(FMetafile);
  // if (Not Preferences.FUseImagesAsResources) or
  // (Preferences.ProcessAfterEachPage) then
  FreeImageResourceList;
  FreeAndNil(FImageResourceList);
  FreeAndNil(FImageResourceHashList);

  if AbortCreation then
  begin
    for I := 0 to EngineFileNames.Count - 1 do
    begin
      if FileExists(EngineFileNames.Strings[I]) then
        SysUtils.DeleteFile(EngineFileNames.Strings[I]);
    end;
  end;

  FreeAndNil(FEngineFileNames);

  FEmailSettings.Attachments.Clear;

  ClearEngineStates;
  FreeAndNil(FEngineStateList);
  FreeAndNil(FPages);

  FCurrentPage := 0;
  FPageCount := 0;
  FTextRotationAngle := 0;
  FTextAlignment := haLeft;
  FIsDocumentStarted := False;
end;

function TgtCustomDocumentEngine.FindImageResourceIndex(AStream: TStream;
  var AImageHashValue: TgtHashValue): Integer;
var
  LI: Integer;
  LtmpDist: MD5Digest;
begin
  Result := -1;
  // Reuse Images only if format supports the capability

  if (ckImageReusable in Capabilities) and
    (Preferences.UseImagesAsResources) then
  begin
{$IFDEF gtDelphi2009Up}
    LtmpDist := AImageHashValue.HashValue;
    FMD5ImageHash.GetHash(AStream, LtmpDist);
    AImageHashValue.HashValue := LtmpDist;
    if FImageResourceHashList.Count > -1 then
      for LI := 0 to FImageResourceHashList.Count - 1 do
        if FMD5ImageHash.CompareHash(AImageHashValue.HashValue,
          TgtHashValue(FImageResourceHashList[LI]).HashValue) then
        begin
          Result := LI;
          exit;
        end;
{$ELSE}
    LtmpDist := AImageHashValue.FHashValue;
    FMD5ImageHash.GetHash(AStream, LtmpDist);
    AImageHashValue.FHashValue := LtmpDist;
    if FImageResourceHashList.Count > -1 then
      for LI := 0 to FImageResourceHashList.Count - 1 do
        if FMD5ImageHash.CompareHash(AImageHashValue.FHashValue,
          TgtHashValue(FImageResourceHashList[LI]).FHashValue) then
        begin
          Result := LI;
          exit;
        end;
{$ENDIF}
  end;
end;

procedure TgtCustomDocumentEngine.InitializeEngine;
begin
  FIsDocumentStarted := True;
  FPages := TList.Create;

  FMetafile := TMetafile.Create;
  FMetafile.Enhanced := True;

  FHeaderItem := TgtBandItem.Create;
  FFooterItem := TgtBandItem.Create;
  FWatermarkItem := TgtBandItem.Create;
  FStampItem := TgtBandItem.Create;

  FImageResourceList := TList.Create;
  FImageResourceHashList := TList.Create; // TgtHashValueList.Create;
  FEngineStateList := TList.Create; // Engine States list
  FDefaultState := SaveEngineState; // Initial state is stored

  FEngineFileNames := TStringList.Create;
  FCurrentPage := 0;
  FPageCount := 0;
end;

function TgtCustomDocumentEngine.CreateFile(AFileName: String): TStream;
begin
  try
    if FileExists(FileName) then
      SysUtils.DeleteFile(AFileName);
    Result := TFileStream.Create(AFileName, fmCreate);
  except
    FEngineStatus := esError;
    CancelCreate;
    raise EFileCreateError.Create(SFileCreateError);
  end;
end;

procedure TgtCustomDocumentEngine.CancelCreate;
var
  I: Integer;
begin
  for I := 0 to EngineFileNames.Count - 1 do
  begin
    if FileExists(EngineFileNames.Strings[I]) then
      SysUtils.DeleteFile(EngineFileNames.Strings[I]);
  end;
  FinalizeEngine;
end;

function TgtCustomDocumentEngine.TextWidth(Text: WideString): Double;
var
  LText: String;
begin
  Result := 0;
  LText := String(Text);
  if Text <> '' then
    if Text[1] <> '' then
      if IsDBCSLeadByte(Byte(Text[1])) then
        Result := TextSize(Text, Font).cx / NativeXPos(1)
        // TextSize will take care
      else
        Result := TextSize(LText, Font).cx / NativeXPos(1);
end;

function TgtCustomDocumentEngine.TextHeight(Text: WideString): Double;
var
  LText: String;
begin
  LText := String(Text);
  if (Text <> '') and (IsDBCSLeadByte(Byte(Text[1]))) then
    Result := TextSize(Text, Font).cy / NativeYPos(1)
  else
    Result := TextSize(LText, Font).cy / NativeYPos(1);
end;

procedure TgtCustomDocumentEngine.SetReferencePoint
  (const Value: TgtReferencePoint);
begin
  FReferencePoint := Value;
  CalculateBandRect;
end;

procedure TgtCustomDocumentEngine.SetInputXRes(const Value: Integer);
begin
  FInputXRes := Value;
end;

procedure TgtCustomDocumentEngine.SetInputYRes(const Value: Integer);
begin
  FInputYRes := Value;
end;

procedure TgtCustomDocumentEngine.SetPageBorder(const Value: TgtBorder);
begin
  FPageBorder := Value;
end;

procedure TgtCustomDocumentEngine.EncodePageBorder;
var
  LPen: TPen;
begin
  with Pages[FCurrentPage - 1].Settings do
  begin
    if PageBorder.DrawLeft or PageBorder.DrawRight or PageBorder.DrawTop or
      PageBorder.DrawBottom then
    begin
      LPen := TPen.Create;
      LPen.Width := PageBorder.Width;
      LPen.Color := PageBorder.Color;
      LPen.Style := PageBorder.Style;

      if PageBorder.DrawLeft then
        EncodeLine(LeftMargin, TopMargin, LeftMargin,
          Height - BottomMargin, LPen);

      if PageBorder.DrawRight then
        EncodeLine(Width - RightMargin, TopMargin, Width - RightMargin,
          Height - BottomMargin, LPen);

      if PageBorder.DrawTop then
        EncodeLine(LeftMargin, TopMargin, Width - RightMargin, TopMargin, LPen);

      if PageBorder.DrawBottom then
        EncodeLine(LeftMargin, Height - BottomMargin, Width - RightMargin,
          Height - BottomMargin, LPen);
      LPen.Free;
    end;
  end;
end;

procedure TgtCustomDocumentEngine.EncodePolyPolyline
  (AObject: gtCstDocEng.TgtPolyShapeItem; IsClosed: Boolean);
var
  LJ, LI, LK: Integer;
  LShapePoints: TgtPoints;
  LPoints: array of TPoint;
  LnPts: array of Integer;
  LTotalPoints: Integer;
  Bmp: TBitmap;
  X1, X2, Y1, Y2: Double;
begin
  if (AObject.Shapes.Count = 0) then
    exit;
  with TgtShapeItem(AObject.Shapes.Items[0]) do
    if ((Pen.Width = 0) or (Pen.Style = psClear)) then
    begin
      if (IsClosed and ((Brush = nil) or (Brush.Style = bsClear))) then
        exit
      else if (IsClosed = False) then
        exit;
    end;
  LK := 0;
  LTotalPoints := 0;
  SetLength(LnPts, AObject.Shapes.Count);
  for LJ := 0 to AObject.Shapes.Count - 1 do
  begin
    with TgtShapeItem(AObject.Shapes.Items[LJ]) do
    begin
      LTotalPoints := LTotalPoints + NoPoints;
      LnPts[LJ] := NoPoints;
    end;
    if IsClosed then
    begin
      LnPts[LJ] := LnPts[LJ] + 1;
      Inc(LTotalPoints);
    end;
  end;
  SetLength(LPoints, LTotalPoints);
  for LJ := 0 to AObject.Shapes.Count - 1 do
  begin
    with TgtShapeItem(AObject.Shapes.Items[LJ]) do
    begin
      SetLength(LShapePoints, NoPoints);
      LShapePoints := GetPoints;
      for LI := 0 to NoPoints - 1 do
      begin
        LPoints[LK].X := Round(LShapePoints[LI].X);
        LPoints[LK].Y := Round(LShapePoints[LI].Y);
        Inc(LK);
      end;
      if IsClosed then
      begin
        LPoints[LK].X := Round(LShapePoints[0].X);
        LPoints[LK].Y := Round(LShapePoints[0].Y);
        Inc(LK);
      end;
    end;
  end;

  X1 := 0;
  Y1 := 0;
  X2 := 0;
  Y2 := 0;
  for LI := 0 to LTotalPoints - 1 do
  begin
    if LI = 0 then
    begin
      X1 := LPoints[LI].X;
      Y1 := LPoints[LI].Y;
    end;
    if X1 > LPoints[LI].X then
      X1 := LPoints[LI].X;
    if X2 < LPoints[LI].X then
      X2 := LPoints[LI].X;
    if Y1 > LPoints[LI].Y then
      Y1 := LPoints[LI].Y;
    if Y2 < LPoints[LI].Y then
      Y2 := LPoints[LI].Y;
  end;
  for LI := 0 to LTotalPoints - 1 do
  begin
    LPoints[LI].X := Round(LPoints[LI].X - X1);
    LPoints[LI].Y := Round(LPoints[LI].Y - Y1);
  end;

  Bmp := TBitmap.Create;
  try
    Bmp.Width := Round(Abs(X2 - X1) + 2);
    Bmp.Height := Round(Abs(Y2 - Y1) + 2);
    with Bmp.Canvas do
    begin
      Pen.Assign(TgtShapeItem(AObject.Shapes.Items[0]).Pen);
      if (IsClosed and (TgtShapeItem(AObject.Shapes.Items[0]).Brush <>
        nil)) then
      begin
        Brush.Assign(TgtShapeItem(AObject.Shapes.Items[0]).Brush);
        if AObject.FFillAlternate then
          SetPolyFillMode(handle, ALTERNATE)
        else
          SetPolyFillMode(handle, WINDING);
      end;
      PolyPolygon(Bmp.Canvas.handle, LPoints[0], LnPts[0],
        AObject.Shapes.Count);
    end;
    EncodeShapeBitmap(X1, Y1, Bmp);
  finally
    FreeAndNil(Bmp);
  end;
end;

procedure TgtCustomDocumentEngine.EncodePolyShape(AObject: TgtPolyShapeItem);
begin
  if (AObject.Shapes.Count = 0) then
    exit;
  case TgtShapeItem(AObject.Shapes.Items[0]).ShapeType of
    stPolygon:
      EncodePolyPolyline(AObject, True);
    stPolyLine:
      EncodePolyPolyline(AObject, False);
  end;
end;

procedure TgtCustomDocumentEngine.EncodePolyPolygon
  (AObject: gtCstDocEng.TgtPolyPolygonItem);
var
  LJ, LI: Integer;
  LPoints: array of TPoint;
  LnPts: array of Integer;
  LTotalPoints: Integer;
  X1, X2, Y1, Y2: Double;
  Bmp: TBitmap;
begin

  SetLength(LPoints, AObject.FNoPoints[0]);
  for LJ := 0 to AObject.FNoPoints[0] - 1 do
  begin
    LPoints[LJ].X := Round(AObject.FPoints[LJ].X);
    LPoints[LJ].Y := Round(AObject.FPoints[LJ].Y);
  end;

  SetLength(LnPts, AObject.FNoPoly);
  for LJ := 0 to AObject.FNoPoly - 1 do
  begin
    LnPts[LJ] := AObject.FNoPoints[LJ + 1];
  end;

  LTotalPoints := AObject.FNoPoints[0];
  X1 := 0;
  Y1 := 0;
  X2 := 0;
  Y2 := 0;
  for LI := 0 to LTotalPoints - 1 do
  begin
    if LI = 0 then
    begin
      X1 := LPoints[LI].X;
      Y1 := LPoints[LI].Y;
    end;
    if X1 > LPoints[LI].X then
      X1 := LPoints[LI].X;
    if X2 < LPoints[LI].X then
      X2 := LPoints[LI].X;
    if Y1 > LPoints[LI].Y then
      Y1 := LPoints[LI].Y;
    if Y2 < LPoints[LI].Y then
      Y2 := LPoints[LI].Y;
  end;

  for LI := 0 to LTotalPoints - 1 do
  begin
    LPoints[LI].X := Round(LPoints[LI].X - X1);
    LPoints[LI].Y := Round(LPoints[LI].Y - Y1);
  end;

  Bmp := TBitmap.Create;
  try
    Bmp.Width := Round(Abs(X2 - X1) + 2);
    Bmp.Height := Round(Abs(Y2 - Y1) + 2);
    with Bmp.Canvas do
    begin
      Pen := AObject.Pen;
      if TgtPolyPolygonItem(AObject.Brush) <> nil then
      begin
        Brush := AObject.Brush;
        if AObject.FFillAlternate then
          SetPolyFillMode(handle, ALTERNATE)
        else
          SetPolyFillMode(handle, WINDING);
      end;
      PolyPolygon(Bmp.Canvas.handle, LPoints[0], LnPts[0], AObject.FNoPoly);
    end;
    EncodeShapeBitmap(X1, Y1, Bmp);
  finally
    FreeAndNil(Bmp);
  end;
end;

procedure TgtCustomDocumentEngine.EncodeEOF(AObject: TgtEOFItem);
begin
end;

procedure TgtCustomDocumentEngine.EncodePolyDraw
  (AObject: gtCstDocEng.TgtPolyDrawItem);
begin
end;

procedure TgtCustomDocumentEngine.SetTextEffects(const Value: TgtTextEffects);
begin
  FTextEffects.TextRenderMode := Value.TextRenderMode;
  FTextEffects.TextRise := Value.TextRise;
end;
{$IFDEF gtActiveX}

procedure TgtCustomDocumentEngine.Paint;
begin
  inherited;
  ControlCanvas.Draw(2, 2, IconBmp);
end;

procedure TgtCustomDocumentEngine.LoadLocalizedStrings;

{ Decode the stream using ZLib DeCompression }
  function DecodeStream(AStream: TMemoryStream): TMemoryStream;
  var
    LDeCmprStream: TDecompressionStream;
    LBuf: Pointer;
    LCnt: Cardinal;
  begin
    AStream.Position := 0;
    Result := TMemoryStream.Create;
    LDeCmprStream := TDecompressionStream.Create(AStream);
    LBuf := AllocMem(10240);
    try
      repeat
        LCnt := LDeCmprStream.Read(LBuf^, 10240);
        Result.Write(PChar(LBuf^), LCnt);
      until (LCnt < 10240);
    finally
      FreeMemory(LBuf);
      LDeCmprStream.Free;
      Result.Position := 0;
    end;
  end;

var
  IniFile: TIniFile;
  OutStream, SrcStream: TMemoryStream;
  TempFile: TFileName;
const
  SFileNotFound = 'Localization file not found. Using default strings...';
  SInvalidFormat =
    'Unrecognized Localization File Format! Using default strings...';
begin
  // Make the temporary file name.
  TempFile := ExtractFilePath(FLocalizationFile) + '\' +
    MidStr(ExtractFileName(FLocalizationFile), 1,
    Length(ExtractFileName(FLocalizationFile)) - 4) + '.~lf';

  // Decode the input file.
  OutStream := nil;

  if FileExists(FLocalizationFile) then
  begin
    SrcStream := TMemoryStream.Create;
    try
      SrcStream.LoadFromFile(FLocalizationFile);

      try
        OutStream := DecodeStream(SrcStream);
        OutStream.SaveToFile(TempFile);
      except
        on E: Exception do
          if Assigned(FOnErrorMessage) then
            OnErrorMessage(Self, Exception.Create(SInvalidFormat))
          else
            ShowMessage(SInvalidFormat);
      end;
    finally
      if Assigned(OutStream) then
        FreeAndNil(OutStream);
      FreeAndNil(SrcStream);
    end;
  end
  else
  begin
    if Assigned(FOnErrorMessage) then
      OnErrorMessage(Self, Exception.Create(SFileNotFound))
    else
      ShowMessage(SFileNotFound);
  end;

  IniFile := TIniFile.Create(TempFile);
  With IniFile do
  begin
    { ----Document Dialog------------------------------------------------------- }
    SgbPageRange := ReadString('Document Dialog', 'SgbPageRange', 'Page Range');
    SrbtnAll := ReadString('Document Dialog', 'SrbtnAll', 'All Pages');
    SrbtnPages := ReadString('Document Dialog', 'SrbtnPages', 'Pages:');
    StsPreferences := ReadString('Document Dialog', 'StsPreferences',
      'Preferences');
    StsContent := ReadString('Document Dialog', 'StsContent', 'Content');
    SchkOpenAfterCreate := ReadString('Document Dialog', 'SchkOpenAfterCreate',
      'Open After Create');
    SchkEMailAfterCreate := ReadString('Document Dialog',
      'SchkEMailAfterCreate', 'EMail After Create');
    SchkProcessAfterEachPage := ReadString('Document Dialog',
      'SchkProcessAfterEachPage', 'Process After Each Page');
    SchkUseImagesAsResources := ReadString('Document Dialog',
      'SchkUseImagesAsResources', 'Use Images As Resources');
    SgbItemsToRender := ReadString('Document Dialog', 'SgbItemsToRender',
      'Items To Render');
    SchkText := ReadString('Document Dialog', 'SchkText', 'Text');
    SchkShape := ReadString('Document Dialog', 'SchkShape', 'Shape');
    SlblOutputImageFormat := ReadString('Document Dialog',
      'SlblOutputImageFormat', 'Output Image Format:');
    SlblJPEGQuality := ReadString('Document Dialog', 'SlblJPEGQuality',
      'JPEG Quality:');
    SlblImagePixelFormat := ReadString('Document Dialog',
      'SlblImagePixelFormat', 'Image Pixel Format:');
    SlblSourceDPI := ReadString('Document Dialog', 'SlblSourceDPI',
      'Source DPI:');
    SchkImage := ReadString('Document Dialog', 'SchkImage', 'Image');
    StsBackground := ReadString('Document Dialog', 'StsBackground',
      'Background');
    SlblBackgroundImage := ReadString('Document Dialog', 'SlblBackgroundImage',
      'Background Image:');
    SlblBackgroundDisplayType := ReadString('Document Dialog',
      'SlblBackgroundDisplayType', 'Background Display Type:');
    SbtnSelectImage := ReadString('Document Dialog', 'SbtnSelectImage',
      'Select Image');
    SbtnClear := ReadString('Document Dialog', 'SbtnClear', 'Clear');
    SbtnImgPrvw := ReadString('Document Dialog', 'SbtnImgPrvw', 'Preview');
    SlblBackgroundColor := ReadString('Document Dialog', 'SlblBackgroundColor',
      'Background Color:');
    SgbDocInfo := ReadString('Document Dialog', 'SgbDocInfo',
      'Document Information');
    SlblAuthor := ReadString('Document Dialog', 'SlblAuthor', 'Author:');
    SlblCreator := ReadString('Document Dialog', 'SlblCreator', 'Creator:');
    SlblKeywords := ReadString('Document Dialog', 'SlblKeywords', 'Keywords:');
    SlblSubject := ReadString('Document Dialog', 'SlblSubject', 'Subject:');
    SlblTitle := ReadString('Document Dialog', 'SlblTitle', 'Title:');
    SbtnOK := ReadString('Document Dialog', 'SbtnOK', 'OK');
    SbtnCancel := ReadString('Document Dialog', 'SbtnCancel', 'Cancel');

    { ----Plain Sheet Dialog------------------------------------------------------ }
    SchkActiveHyperLinks := ReadString('Plain Sheet Dialog',
      'SchkActiveHyperLinks', 'Active HyperLinks');
    SQualityScaling := ReadString('Plain Sheet Dialog', 'SQualityScaling',
      'Quality & Scaling');

    { ----Spread Sheet Dialog----------------------------------------------------- }
    StsFormatting := ReadString('Spread Sheet Dialog', 'StsFormatting',
      'Formatting');
    SchkAutoFormatCells := ReadString('Spread Sheet Dialog',
      'SchkAutoFormatCells', 'Auto Format Cells');
    SlblColumnSpacing := ReadString('Spread Sheet Dialog', 'SlblColumnSpacing',
      'Column Spacing:');
    SlblRowSpacing := ReadString('Spread Sheet Dialog', 'SlblRowSpacing',
      'Row Spacing:');
    SlblScaleX := ReadString('Spread Sheet Dialog', 'SlblScaleX', 'Scale X:');
    SlblScaleY := ReadString('Spread Sheet Dialog', 'SlblScaleY', 'Scale Y:');
    SlblFormatting := ReadString('Spread Sheet Dialog', 'SlblFormatting',
      'Formatting');

    { ----Graphics Dialog--------------------------------------------------------- }
    StsQualityAndScaling := ReadString('Graphics Dialog',
      'StsQualityAndScaling', 'Quality And Scaling');
    SchkMonochrome := ReadString('Graphics Dialog', 'SchkMonochrome',
      'Monochrome');
    SlblPixelFormat := ReadString('Graphics Dialog', 'SlblPixelFormat',
      'Pixel Format:');

    { ----PDF Dialog------------------------------------------------------------ }
    SPDFDlgCaption := ReadString('PDF Dialog', 'SPDFDlgCaption', 'PDF Setup');
    SlblAdvanced := ReadString('PDF Dialog', 'SlblAdvanced', 'Advanced');
    SchkCompressDocument := ReadString('PDF Dialog', 'SchkCompressDocument',
      'Compress Document');
    SlblCompressionLevel := ReadString('PDF Dialog', 'SlblCompressionLevel',
      'Compression Level:');
    SchkEnableEncryption := ReadString('PDF Dialog', 'SchkEnableEncryption',
      'Encrypt Document');
    SlblOwnerPassword := ReadString('PDF Dialog', 'SlblOwnerPassword',
      'Owner Password:');
    SlblConfirmOwnerPassword := ReadString('PDF Dialog',
      'SlblConfirmOwnerPassword', 'Confirm Owner Password:');
    SlblUserPassword := ReadString('PDF Dialog', 'SlblUserPassword',
      'User Password:');
    SlblConfirmUserPassword := ReadString('PDF Dialog',
      'SlblConfirmUserPassword', 'Confirm User Password:');
    SlblEncryptionLevel := ReadString('PDF Dialog', 'SlblEncryptionLevel',
      'Level:');
    SgbUserPermissions := ReadString('PDF Dialog', 'SgbUserPermissions',
      'User Permissions');
    SchkCopy := ReadString('PDF Dialog', 'SchkCopy', 'Copy');
    SchkModify := ReadString('PDF Dialog', 'SchkModify', 'Modify');
    SchkPrint := ReadString('PDF Dialog', 'SchkPrint', 'Print');
    SchkFormFill := ReadString('PDF Dialog', 'SchkFormFill', 'Form Fill');
    SchkAnnotation := ReadString('PDF Dialog', 'SchkAnnotation', 'Annotation');
    SchkAccessibility := ReadString('PDF Dialog', 'SchkAccessibility',
      'Accessibility');
    SchkDocumentAssembly := ReadString('PDF Dialog', 'SchkDocumentAssembly',
      'Document Assembly');
    SchkHighResolutionPrint := ReadString('PDF Dialog',
      'SchkHighResolutionPrint', 'High Resolution Print');
    SlblFontEncoding := ReadString('PDF Dialog', 'SlblFontEncoding',
      'Font Encoding:');
    SlblViewerPreferences := ReadString('PDF Dialog', 'SlblViewerPreferences',
      'Viewer Preferences');
    SlblPageLayout := ReadString('PDF Dialog', 'SlblPageLayout',
      'Page Layout:');
    SlblPageMode := ReadString('PDF Dialog', 'SlblPageMode', 'Page Mode:');
    SgbHideUIElements := ReadString('PDF Dialog', 'SgbHideUIElements',
      'Hide UI Elements');
    SchkMenuBar := ReadString('PDF Dialog', 'SchkMenuBar', 'Menu Bar');
    SchkToolBar := ReadString('PDF Dialog', 'SchkToolBar', 'Tool Bar');
    SchkNavigationControls := ReadString('PDF Dialog', 'SchkNavigationControls',
      'Navigation Controls');
    SgbPresentationMode := ReadString('PDF Dialog', 'SgbPresentationMode',
      'Presentation Mode');
    SlblPageTransitionEffect := ReadString('PDF Dialog',
      'SlblPageTransitionEffect', 'Page Transition Effect:');
    SlblPageTransitionDuration := ReadString('PDF Dialog',
      'SlblPageTransitionDuration', 'Page Transition Duration:');
    SrgpEmbedTrueTypeFonts := ReadString('PDF Dialog', 'SrgpEmbedTrueTypeFonts',
      'Embed Used TrueType Fonts');
    SPasswordMissMatch := ReadString('PDF Dialog', 'SPasswordMissMatch',
      'The %s Passwords do not match.' + #13#10 + 'Please re-enter.');

    { ----RTF Dialog------------------------------------------------------------ }
    SRTFDlgCaption := ReadString('RTF Dialog', 'SRTFDlgCaption', 'RTF Setup');
    SchkGraphicDataInBinary := ReadString('RTF Dialog',
      'SchkGraphicDataInBinary', 'Graphic Data In Binary');
    SrgpEncodingType := ReadString('RTF Dialog', 'SrgpEncodingType',
      'Encoding Type');

    { ----HTML Dialog----------------------------------------------------------- }
    SHTMLDlgCaption := ReadString('HTML Dialog', 'SHTMLDlgCaption',
      'HTML Setup');
    SchkAutoScrollDocument := ReadString('HTML Dialog',
      'SchkAutoScrollDocument', 'Auto Sroll Document');
    StsFileLocationAndOptimization := ReadString('HTML Dialog',
      'StsFileLocationAndOptimization', 'File Location && Optimization');
    SchkOptimizeforIE := ReadString('HTML Dialog', 'SchkOptimizeforIE',
      'Optimize For Internet Explorer');
    SlblCSSFile := ReadString('HTML Dialog', 'SlblCSSFile', 'CSS File:');
    SsbtnCSSFileName := ReadString('HTML Dialog', 'SsbtnCSSFileName', '...');
    SchkOutputStylesToCSSFile := ReadString('HTML Dialog',
      'SchkOutputStylesToCSSFile', 'Output Style To CSS File');
    SchkPageEndLines := ReadString('HTML Dialog', 'SchkPageEndLines',
      'Page End Lines');
    SlblJSFile := ReadString('HTML Dialog', 'SlblJSFile', 'JS File:');
    SsbtnJSFileName := ReadString('HTML Dialog', 'SsbtnJSFileName', '...');
    SchkOutputScriptsToJSFile := ReadString('HTML Dialog',
      'SchkOutputScriptsToJSFile', 'Output Script To JavaScript File');
    StsNavigatorOptions := ReadString('HTML Dialog', 'StsNavigatorOptions',
      'Navigator Options');
    SlblNavigatorBackgroundColor := ReadString('HTML Dialog',
      'SlblNavigatorBackgroundColor', 'Navigator Background Color:');
    SlblHoverForeColor := ReadString('HTML Dialog', 'SlblHoverForeColor',
      'Navigator Hover Foreground Color:');
    SlblHoverBackColor := ReadString('HTML Dialog', 'SlblHoverBackColor',
      'Navigator Hover Background Color:');
    SlblNavigatorType := ReadString('HTML Dialog', 'SlblNavigatorType',
      'Navigator Type:');
    SlblNavigatorOrientation := ReadString('HTML Dialog',
      'SlblNavigatorOrientation', 'Navigator Orientation:');
    SlblNavigatorPosition := ReadString('HTML Dialog', 'SlblNavigatorPosition',
      'Navigator Position:');
    StsUseTextLinks := ReadString('HTML Dialog', 'StsUseTextLinks',
      'Use Text Links');
    SlblFirst := ReadString('HTML Dialog', 'SlblFirst', 'First:');
    SlblLast := ReadString('HTML Dialog', 'SlblLast', 'Last:');
    SlblNext := ReadString('HTML Dialog', 'SlblNext', 'Next:');
    SlblPrevious := ReadString('HTML Dialog', 'SlblPrevious', 'Previous:');
    SlblLinkCaptions := ReadString('HTML Dialog', 'SlblLinkCaptions',
      'Link Captions:');
    SbtnSetFont := ReadString('HTML Dialog', 'SbtnSetFont', 'Set Font');
    StsUseGraphicLinks := ReadString('HTML Dialog', 'StsUseGraphicLinks',
      'Use Graphic Links');
    SlblUseGraphicLinksFirst := ReadString('HTML Dialog',
      'SlblUseGraphicLinksFirst', 'First:');
    SlblUseGraphicLinksPrevious := ReadString('HTML Dialog',
      'SlblUseGraphicLinksPrevious', 'Previous:');
    SlblUseGraphicLinksNext := ReadString('HTML Dialog',
      'SlblUseGraphicLinksNext', 'Next:');
    SlblUseGraphicLinksLast := ReadString('HTML Dialog',
      'SlblUseGraphicLinksLast', 'Last:');
    SsbtnFirst := ReadString('HTML Dialog', 'SsbtnFirst', '...');
    SsbtnPrevious := ReadString('HTML Dialog', 'SsbtnPrevious', '...');
    SsbtnNext := ReadString('HTML Dialog', 'SsbtnNext', '...');
    SsbtnLast := ReadString('HTML Dialog', 'SsbtnLast', '...');
    SlblImageSource := ReadString('HTML Dialog', 'SlblImageSource',
      'Image Source:');
    SrbtnUseTextLinks := ReadString('HTML Dialog', 'SrbtnUseTextLinks',
      'Use Text Links');
    SrbtnUseGraphicLinks := ReadString('HTML Dialog', 'SrbtnUseGraphicLinks',
      'Use Graphic Links');
    SchkShowNavigator := ReadString('HTML Dialog', 'SchkShowNavigator',
      'Show Navigator');
    SchkSingleFile := ReadString('HTML Dialog', 'SchkSingleFile',
      'Single File');
    StsTOCPageSettings := ReadString('HTML Dialog', 'StsTOCPageSettings',
      'TOC Page Settings');
    SlblDefaultFont := ReadString('HTML Dialog', 'SlblDefaultFont',
      'Default Font:');
    SlblItemFont := ReadString('HTML Dialog', 'SlblItemFont', 'Item Font:');
    SlblTOCTitle := ReadString('HTML Dialog', 'SlblTOCTitle', 'TOC Title:');
    SlblAlignment := ReadString('HTML Dialog', 'SlblAlignment', 'Alignment:');
    SlblTitleFont := ReadString('HTML Dialog', 'SlblTitleFont', 'Title Font:');
    SOpenDialogFilterJSSFile := ReadString('HTML Dialog',
      'SOpenDialogFilterJSSFile', 'Java Script File Name (*.js)|*.js');
    SOpenDialogFilterCSSFile := ReadString('HTML Dialog',
      'SOpenDialogFilterCSSFile', 'Cascaded Style Sheets (*.css)|*.css');

    { ----XHTML Dialog---------------------------------------------------------- }
    SXHTMLDlgCaption := ReadString('XHTML Dialog', 'SXHTMLDlgCaption',
      'XHTML Setup');

    { ----SVG Dialog------------------------------------------------------------ }
    SSVGDlgCaption := ReadString('SVG Dialog', 'SSVGDlgCaption', 'SVG Setup');

    { ----Text Dialog----------------------------------------------------------- }
    STXTDlgCaption := ReadString('Text Dialog', 'STXTDlgCaption', 'Text Setup');
    StsTextFormatting := ReadString('Text Dialog', 'StsTextFormatting',
      'Formatting');
    SlblTextLineSpacing := ReadString('Text Dialog', 'SlblTextLineSpacing',
      'Line Spacing:');
    SlblTextColumnSpacing := ReadString('Text Dialog', 'SlblTextColumnSpacing',
      'Column Spacing:');
    SchkSeparatorMode := ReadString('Text Dialog', 'SchkSeparatorMode',
      'Separator Mode');
    SlblSeparator := ReadString('Text Dialog', 'SlblSeparator', 'Separator:');
    SlblTextDefaultFont := ReadString('Text Dialog', 'SlblTextDefaultFont',
      'Default Document Font:');
    SchkTextPageEndLines := ReadString('Text Dialog', 'SchkTextPageEndLines',
      'Page End Lines');
    SchkInsertPageBreaks := ReadString('Text Dialog', 'SchkInsertPageBreaks',
      'Insert Page Breaks');
    SchkTextSingleFile := ReadString('Text Dialog', 'SchkTextSingleFile',
      'Single File');

    { ----Excel Dialog---------------------------------------------------------- }
    SXLSDlgCaption := ReadString('Excel Dialog', 'SXLSDlgCaption',
      'Excel Setup');
    SlblPagesPerWorkSheet := ReadString('Excel Dialog', 'SlblPagesPerWorkSheet',
      'Pages Per WorkSheet:');
    SchkPageMargins := ReadString('Excel Dialog', 'SchkPageMargins',
      'Page Margins');
    SchkPrintGridLines := ReadString('Excel Dialog', 'SchkPrintGridLines',
      'Print Grid Lines');

    { ----Quattro Pro Dialog---------------------------------------------------- }
    SQProDlgCaption := ReadString('Quattro Pro Dialog', 'SQProDlgCaption',
      'Quattro Pro Setup');

    { ----DIF Dialog------------------------------------------------------------ }
    SDIFDlgCaption := ReadString('DIF Dialog', 'SDIFDlgCaption', 'DIF Setup');

    { ----Lotus Dialog---------------------------------------------------------- }
    SLotusDlgCaption := ReadString('Lotus Dialog', 'SLotusDlgCaption',
      'Lotus Setup');

    { ----SYLK Dialog----------------------------------------------------------- }
    SSLKDlgCaption := ReadString('SYLK Dialog', 'SSLKDlgCaption', 'SYLK Setup');

    { ----BMP Dialog------------------------------------------------------------ }
    SBMPDlgCaption := ReadString('BMP Dialog', 'SBMPDlgCaption', 'BMP Setup');

    { ----JPEG Dialog----------------------------------------------------------- }
    SJPEGDlgCaption := ReadString('JPEG Dialog', 'SJPEGDlgCaption',
      'JPEG Setup');
    SchkProgressiveEncoding := ReadString('JPEG Dialog',
      'SchkProgressiveEncoding', 'Progressive Encoding');
    SlblQuality := ReadString('JPEG Dialog', 'SlblQuality', 'Quality:');

    { ----GIF Dialog------------------------------------------------------------ }
    SGIFDlgCaption := ReadString('GIF Dialog', 'SGIFDlgCaption', 'GIF Setup');

    { ----EMF Dialog------------------------------------------------------------ }
    SEMFDlgCaption := ReadString('EMF Dialog', 'SEMFDlgCaption', 'EMF Setup');

    { ----WMF Dialog------------------------------------------------------------ }
    SWMFDlgCaption := ReadString('WMF Dialog', 'SWMFDlgCaption', 'WMF Setup');

    { ----TIFF Dialog----------------------------------------------------------- }
    STIFFDlgCaption := ReadString('TIFF Dialog', 'STIFFDlgCaption',
      'TIFF Setup');
    SchkGrayscale := ReadString('TIFF Dialog', 'SchkGrayscale', 'Grayscale');
    SchkMultiPage := ReadString('TIFF Dialog', 'SchkMultiPage', 'Multi-Page');
    SlblCompressionType := ReadString('TIFF Dialog', 'SlblCompressionType',
      'Compression Type:');

    { ----PNG Dialog------------------------------------------------------------ }
    SPNGDlgCaption := ReadString('PNG Dialog', 'SPNGDlgCaption', 'PNG Setup');
    SlblColorType := ReadString('PNG Dialog', 'SlblColorType', 'Color Type:');
    SchkPixelDimensions := ReadString('PNG Dialog', 'SchkPixelDimensions',
      'Pixel Dimensions');
    SlblXPixelsPerUnit := ReadString('PNG Dialog', 'SlblXPixelsPerUnit',
      'X Pixels Per Unit:');
    SlblYPixelsPerUnit := ReadString('PNG Dialog', 'SlblYPixelsPerUnit',
      'Y Pixels Per Unit:');
    SlblUnitSpecifier := ReadString('PNG Dialog', 'SlblUnitSpecifier',
      'Unit Specifier:');
    SchkTransparency := ReadString('PNG Dialog', 'SchkTransparency',
      'Transparency');
    SlblImageAlpha := ReadString('PNG Dialog', 'SlblImageAlpha',
      'Image Alpha:');
    SlblTransparencyColor := ReadString('PNG Dialog', 'SlblTransparencyColor',
      'Transparency Color:');

    { ----Image Preview Dialog-------------------------------------------------- }
    SImgPrvwDlgCaption := ReadString('Image Preview Dialog',
      'SImgPrvwDlgCaption', 'Preview');

    { ---------------------------- HTML Engine --------------------------------- }
    // Link Hint (only appears in IE)
    STitleTextTOC := ReadString('HTML Engine', 'STitleTextTOC',
      'Table Of Contents');
    STitleTextFirst := ReadString('HTML Engine', 'STitleTextFirst', 'First');
    STitleTextPrev := ReadString('HTML Engine', 'STitleTextPrev', 'Previous');
    STitleTextNext := ReadString('HTML Engine', 'STitleTextNext', 'Next');
    STitleTextLast := ReadString('HTML Engine', 'STitleTextLast', 'Last');

    { -------------------------- Filter Description ---------------------------- }
    SPDFDescription := ReadString('Filter Description', 'SPDFDescription',
      'Adobe PDF Files');
    SRTFDescription := ReadString('Filter Description', 'SRTFDescription',
      'Rich Text Format');
    SBMPDescription := ReadString('Filter Description', 'SBMPDescription',
      'Windows Bitmap');
    STIFFDescription := ReadString('Filter Description', 'STIFFDescription',
      'Tagged Image File Format');
    SPNGDescription := ReadString('Filter Description', 'SPNGDescription',
      'Portable Network Graphics');
    SJPEGDescription := ReadString('Filter Description', 'SJPEGDescription',
      'JPEG File Interchange Format');
    SWMFDescription := ReadString('Filter Description', 'SWMFDescription',
      'Windows Metafiles');
    SEMFDescription := ReadString('Filter Description', 'SEMFDescription',
      'Enhanced Metafiles');
    SGIFDescription := ReadString('Filter Description', 'SGIFDescription',
      'Graphics Interchange Format');
    SSVGDescription := ReadString('Filter Description', 'SSVGDescription',
      'Scalable Vector Graphics');
    SHTMLDescription := ReadString('Filter Description', 'SHTMLDescription',
      'HyperText Markup Language');
    SXHTMLDescription := ReadString('Filter Description', 'SXHTMLDescription',
      'Extended HyperText Markup Language');
    SExcelDescription := ReadString('Filter Description', 'SExcelDescription',
      'Microsoft Excel Workbook');
    SQuattroProDescription := ReadString('Filter Description',
      'SQuattroProDescription', 'Quattro Pro for Windows');
    SLotusDescription := ReadString('Filter Description', 'SLotusDescription',
      'Lotus 1-2-3');
    SDIFDescription := ReadString('Filter Description', 'SDIFDescription',
      'Data Interchange Format');
    SSYLKDescription := ReadString('Filter Description', 'SSYLKDescription',
      'Symbolic Link');
    STextDescription := ReadString('Filter Description', 'STextDescription',
      'Text Document');
    SClipboardDescription := ReadString('Filter Description',
      'SClipboardDescription', 'Windows Clipboard');

    { ------------------------- Error Descriptions ----------------------------- }
    SFileCreateError := ReadString('Error Descriptions', 'SFileCreateError',
      'File could not be created!' + CRLF + CRLF +
      'Possible cause: It could be in use by some other application');
    SInvalidPageNo := ReadString('Error Descriptions', 'SInvalidPageNo',
      'Invalid Page Number');
    SInvalidEngineState := ReadString('Error Descriptions',
      'SInvalidEngineState', 'Not a valid Engine State identifier');
    SEMailError := ReadString('Error Descriptions', 'SEMailError',
      'Report could not be E-Mailed!' + CRLF + CRLF +
      'Possible cause: Internet/Mail server Connection' +
      ' could not be established.' + CRLF + CRLF +
      'Solution: Check Mail server connection properties' +
      ' and your Internet connection.');
    SUnsupportedGraphics := ReadString('Error Descriptions',
      'SUnsupportedGraphics', 'Unknown Graphics format');
    SUnsupportedPDFImageFormat := ReadString('Error Descriptions',
      'SUnsupportedPDFImageFormat',
      'The PDF Engine does not support image format');
    SUnsupportedBackgroundDisplayType := ReadString('Error Descriptions',
      'SUnsupportedBackgroundDisplayType',
      'The RTF Engine does not support Tile display type');
    SUnsupportedExcelImageFormat := ReadString('Error Descriptions',
      'SUnsupportedExcelImageFormat',
      'The Excel Engine supports only  BMP and Metafile image formats');
    SUnsupportedRTFImageFormat := ReadString('Error Descriptions',
      'SUnsupportedRTFImageFormat',
      'The RTF Engine does not support GIF format');
    STransparencyNotAllowed := ReadString('Error Descriptions',
      'STransparencyNotAllowed', 'Transparency Chunk Not Allowed');
    SUnsupportedSVGImageFormat := ReadString('Error Descriptions',
      'SUnsupportedSVGImageFormat',
      'The SVG supports only JPEG and PNG image formats');
    SCSSFileCreationError := ReadString('Error Descriptions',
      'SCSSFileCreationError', 'CSS File Creation Error');
    SJSFileCreationError := ReadString('Error Descriptions',
      'SJSFileCreationError', 'JavaScript File Creation Error');
    SUnsupportedHTMLImageFormat := ReadString('Error Descriptions',
      'SUnsupportedHTMLImageFormat',
      'HTML Engine does not support this image format');
  end;
  FreeAndNil(IniFile);
  DeleteFile(TempFile);
end;

{$ENDIF}

procedure TgtCustomDocumentEngine.TextRect(Rect: TgtRect; X, Y: Double;
  Text: WideString);
begin
  if not FIsDocumentStarted or not(ckText in Capabilities) or
    not(irText in ItemsToRender) then
    exit;
  FNoSorting := False;
{$IFNDEF gtRegistered}
{$IFDEF gtFileMaker}
  if (not FStatusMgr.IsException) then
{$ENDIF}
    if FPageCount > CMaxPages then
      exit;
{$ENDIF}
  X := NativeXPos(X) + FBandRect.Left;
  Y := NativeYPos(Y) + FBandRect.Top;
  if IsDocumentItemInRange(X, Y) then
  begin
    FTextItem := TgtTextItem.Create;
    FTextItem.X := X;
    FTextItem.Y := Y;
    FTextItem.Lines.Add(Text);
    FTextItem.Font := Font;
    FTextItem.Brush := Brush;
    FTextItem.IsClipRect := True;
    FTextItem.ClipRect := gtRect(NativeRect(Rect), 1);
    FTextItem.RotationAngle := FTextRotationAngle;
    FTextItem.Alignment := FTextAlignment;
    FTextItem.TextEffects := TextEffects;
    AddDocumentItem(FTextItem);
  end;
end;

procedure TgtCustomDocumentEngine.SendMail;
{$IFDEF EMailSupport}
Var
  LContinue, LCancelEMail: Boolean;
  LEMailSettings: TgtEmailSettings;
{$ENDIF EMailSupport}  
begin
{$IFDEF EMailSupport}
  LEMailSettings := FEmailSettings.Clone;
  LContinue := False;
  LCancelEMail := False;
  repeat
    if LCancelEMail then
      Break;
    if Assigned(FOnEmail) then
    begin
      FOnEmail(Self, LEMailSettings, LContinue, LCancelEMail);
      EmailAdapter.EMailSettings := LEMailSettings;
    end
    else
      FEmailAdapter.FEmailSettings := FEmailSettings;
    EmailAdapter.FOnEmailConnected := OnEmailConnected;
    EmailAdapter.FOnEmailDisConnected := OnEmailDisConnected;
    // EmailAdapter.FOnEmailStatus := OnEmailStatus;
    try
      FEmailAdapter.SendMail;
      if Assigned(OnEmailSuccess) then
        OnEmailSuccess(Self);
    except
      on E: Exception do
      begin
        // Trigger OnEMailError Event.
        if Assigned(OnEmailError) then
          OnEmailError(Self, E.Message);
        LContinue := False;
      end;
    end;
  until not LContinue;
  LEMailSettings.Free;
{$ENDIF}
end;

procedure TgtCustomDocumentEngine.SetAbortCreation(const Value: Boolean);
begin
  FAbortCreation := Value;
end;

function TgtCustomDocumentEngine.ReplacePlaceHolders(AText: WideString;
  AReplacePageInfo: Boolean): WideString;
var
  LI, LStart, LEnd: Integer;
  LVarStr, LValStr: String;
begin
  Result := AText;
  if (not Preferences.CalculateVariables) then
    exit;
  if (AText = '') then
    exit;
  if AReplacePageInfo then
    Result := ReplacePageInfo(Result);
  Result := ReplaceString(Result, CphShortDate, FormatDateTime(
{$IFDEF gtDelphiXEUp} FormatSettings.
{$ENDIF} ShortDateFormat, Now));
  Result := ReplaceString(Result, CphShortTime, FormatDateTime(
{$IFDEF gtDelphiXEUp} FormatSettings.
{$ENDIF} ShortTimeFormat, Now));
  Result := ReplaceString(Result, CphLongDate, FormatDateTime(
{$IFDEF gtDelphiXEUp} FormatSettings.
{$ENDIF} LongDateFormat, Now));
  Result := ReplaceString(Result, CphLongTime, FormatDateTime(
{$IFDEF gtDelphiXEUp} FormatSettings.
{$ENDIF} LongTimeFormat, Now));
  Result := ReplaceString(Result, CphAuthor, DocInfo.Author);
  Result := ReplaceString(Result, CphCreator, DocInfo.Creator);
  Result := ReplaceString(Result, CphSubject, DocInfo.Subject);
  Result := ReplaceString(Result, CphTitle, DocInfo.Title);
  // CustomPlaceHolders
  if Assigned(OnCalcVariables) then
  begin
    LStart := -1;
    while (LStart < Length(Result)) do
    begin
      LStart := PosEx('<%', Result, LStart + 2);
      if (LStart = 0) then
        Break;
      LEnd := PosEx('%>', Result, LStart);
      if (LEnd = 0) then
        Break;
      if ((LEnd - LStart) < 3) then
      begin
        LStart := LEnd;
        Continue;
      end;
      LI := PosEx('<%', Result, LStart + 2);
      if ((LI < LEnd) and (LI > 0)) then
      begin
        Inc(LStart, 2);
        Continue;
      end;
      LVarStr := System.Copy(Result, LStart + 2, LEnd - LStart - 2);
      if (CphPageNo = ('<%' + LVarStr + '%>')) or
        (CphTotalPages = ('<%' + LVarStr + '%>')) then
      begin
        LStart := LEnd;
        Continue;
      end;
      LValStr := '';
      OnCalcVariables(Self, LVarStr, LValStr);
      Result := ReplaceString(Result, '<%' + LVarStr + '%>', LValStr);
    end;
  end;
end;

procedure TgtCustomDocumentEngine.SetOnCalcVariables
  (const Value: TgtOnCalcVariablesEvent);
begin
  FOnCalcVariables := Value;
end;

procedure TgtCustomDocumentEngine.SetTextAlignment(Alignment: TgtHAlignment);
begin
  FTextAlignment := Alignment;
end;

procedure TgtCustomDocumentEngine.TextOutV(X, Y: Double; Text: WideString;
  TopDown: Boolean);
var
  I: Integer;
  LHeight: Double;
  RadAngle: Double;
begin
  RadAngle := DegreesToRadians(FTextRotationAngle);
  LHeight := TextHeight(Text);
  for I := 1 to Length(Text) do
  begin
    TextOut(X, Y, Text[I]);
    if (TopDown = True) then
      Y := Y + LHeight * Cos(RadAngle)
    else
      Y := Y - LHeight * Cos(RadAngle);
    if (TopDown = True) then
      X := X + LHeight * Sin(RadAngle)
    else
      X := X - LHeight * Sin(RadAngle);
  end;
end;
{$IFNDEF gtRegistered}

procedure TgtCustomDocumentEngine.PutTrialNoteOnTop;
var
  LX, LY, LM: Double;
  LI: Integer;
  LS: String;
  LSize: TSize;
  LUnit: TgtUnitType;
begin
  if CurrentPage <= 0 then
    exit;
  LI := SaveEngineState;
  LUnit := MeasurementUnit;
  MeasurementUnit := muPixels;
  BeginStamp;
  Font.Size := 16;
  Font.Name := 'Arial';
  Font.Charset := ANSI_CHARSET;
  Font.Color := clRed;
  Font.Style := [fsBold];
  Brush.Style := bsClear;
  with Pages[CurrentPage - 1].Settings do
  begin
    LM := LeftMargin + (Width - LeftMargin - RightMargin) / 2;
    LY := TopMargin;
  end;
  LS := 'This document was created using Gnostice eDocEngine Trial';
  LSize := TextSize(LS, Font);
  LX := LM - LSize.cx / 2;
  TextOut(LX, LY, LS);
  LY := LY + LSize.cy;
  Font.Color := clBlue;
  LS := 'www.gnostice.com';
  LX := LM - TextSize(LS, Font).cx / 2;
  TextOut(LX, LY, LS);
  EndStamp;
  MeasurementUnit := LUnit;
  RestoreEngineState(LI);
end;
{$ENDIF}

function TgtCustomDocumentEngine.ReplacePageInfo(AText: WideString): WideString;
begin
  Result := AText;
  Result := ReplaceString(Result, CphPageNo, IntToStr(CurrentPage));
  Result := ReplaceString(Result, CphTotalPages, IntToStr(PageCount));
end;

function TgtCustomDocumentEngine.GetPageBorder: TgtBorder;
begin
  Result := FPageBorder;
end;

function TgtCustomDocumentEngine.R2LString(OriginalStr: WideString): WideString;
var
  LLen, LCnt, LCurrent, LInserIndex: Integer;
  LStr, L2RString, LNumString: WideString;
  LOutputList: TWideStrings;

  // Fun 2 check hebrew/arabic
  function CheckR2L(Ordinal: Integer): Boolean;
  begin
    Result := ((Ordinal >= $0590) and (Ordinal <= $05FF) or // HEBREW RANGE
      (Ordinal >= $FB1E) and (Ordinal <= $FB4F) or (Ordinal >= $0600) and
      (Ordinal <= $06FF) or // ARABIC RANGE
      (Ordinal >= $FB50) and (Ordinal <= $FDFF) or (Ordinal >= $FE70) and
      (Ordinal <= $FEFF));
  end;

// Fun 2 check numbers
  function CheckNumber(Ordinal: Integer): Boolean;
  begin
    Result := ((Ordinal >= $0030) and (Ordinal <= $0039));
  end;

// Fun 2 check special chars
  function CheckSplChar(Ordinal: Integer): Boolean;
  begin
    Result := (((Ordinal >= $0020) and (Ordinal <= $002F)) or
      ((Ordinal >= $003A) and (Ordinal <= $0040)) or
      ((Ordinal >= $005B) and (Ordinal <= $0060)) or
      ((Ordinal >= $007B) and (Ordinal <= $007E)));
  end;

begin
  LCurrent := 0;
  LInserIndex := 0;
  L2RString := '';
  LOutputList := TWideStrings.Create;
  for LLen := 1 to Length(OriginalStr) do
  begin
    if (CheckNumber(Ord(OriginalStr[LLen]))) then
    begin
      if (LCurrent <> 1) then
      begin
        case LCurrent of
          2:
            if ((L2RString <> '') or (LOutputList.Count = 0)) then
              L2RString := L2RString + LStr
            else if LNumString = '' then
              LOutputList.Insert(LInserIndex, LStr);
          3:
            LOutputList.Insert(LInserIndex, LStr);
          4:
            L2RString := L2RString + LStr
        end;
        LStr := '';
      end;
      LCurrent := 1;
      LStr := LStr + OriginalStr[LLen];
    end
    else if (CheckSplChar(Ord(OriginalStr[LLen]))) then
    begin
      if ((LOutputList.Count > 0) and (LLen < Length(OriginalStr) - 1)) then
      begin
        case Ord(OriginalStr[LLen]) of
          40:
            OriginalStr[LLen] := ')';
          41:
            OriginalStr[LLen] := '(';
          60:
            OriginalStr[LLen] := '>';
          62:
            OriginalStr[LLen] := '<';
          91:
            OriginalStr[LLen] := ']';
          93:
            OriginalStr[LLen] := '[';
          123:
            OriginalStr[LLen] := '}';
          125:
            OriginalStr[LLen] := '{';
        end
      end;
      if (LCurrent <> 2) then
      begin
        case LCurrent of
          1:
            if ((L2RString <> '') or (LOutputList.Count = 0)) then
              L2RString := L2RString + LStr
            else if LNumString <> '' then
            begin
              LNumString := LNumString + LStr;
              if (not CheckSplChar(Ord(OriginalStr[LLen]))) then
              begin
                LOutputList.Insert(LInserIndex, LNumString);
                LNumString := '';
              end;
              LNumString := LNumString + OriginalStr[LLen];
            end
            else
            begin
              // test 4 decimal/thousand separator
              if (((Char(OriginalStr[LLen]) =
{$IFDEF gtDelphiXEUp} FormatSettings.
{$ENDIF} ThousandSeparator) or (Char(OriginalStr[LLen]) =
{$IFDEF gtDelphiXEUp} FormatSettings.
{$ENDIF} DecimalSeparator) or (OriginalStr[LLen] = '$') or
                (Char(OriginalStr[LLen]) =
{$IFDEF gtDelphiXEUp} FormatSettings.
{$ENDIF} TimeSeparator) or (Char(OriginalStr[LLen]) =
{$IFDEF gtDelphiXEUp} FormatSettings.
{$ENDIF} DateSeparator)) and (CheckNumber(Ord(OriginalStr[LLen + 1])))) or
                (OriginalStr[LLen] = '%') then
              begin
                LNumString := LNumString + LStr + OriginalStr[LLen];
                LStr := '';
                Continue;
              end
              else
                LOutputList.Insert(LInserIndex, LStr);
            end;
          3:
            LOutputList.Insert(LInserIndex, LStr);
          4:
            L2RString := L2RString + LStr
        end;
        LStr := '';
      end;
      LCurrent := 2;
      if (OriginalStr[LLen] =
{$IFDEF gtDelphiXEUp} FormatSettings.{$ENDIF} CurrencyString) then
        LNumString := LNumString + OriginalStr[LLen]
      else
        LStr := LStr + OriginalStr[LLen];
    end
    else if (CheckR2L(Ord(OriginalStr[LLen]))) then
    begin
      if (LCurrent <> 3) then
      begin
        case LCurrent of
          1:
            if ((L2RString <> '') or (LOutputList.Count = 0)) then
            begin
              L2RString := L2RString + LStr;
              LOutputList.Add(L2RString);
              L2RString := '';
              LInserIndex := LOutputList.Count;
            end
            else if LNumString <> '' then
            begin
              LNumString := LNumString + LStr;
              LOutputList.Insert(LInserIndex, LNumString);
              LNumString := '';
            end
            else
              LOutputList.Insert(LInserIndex, LStr);
          2:
            if ((L2RString <> '') or (LOutputList.Count = 0)) then
            begin
              L2RString := L2RString + LStr;
              LOutputList.Add(L2RString);
              L2RString := '';
              LInserIndex := LOutputList.Count;
            end
            else
              LOutputList.Insert(LInserIndex, ReverseString(LStr));
          4:
            begin
              L2RString := L2RString + LStr;
              LOutputList.Add(L2RString);
              L2RString := '';
              LInserIndex := LOutputList.Count;
            end;
        end;
        LStr := '';
      end;
      LCurrent := 3;
      LStr := OriginalStr[LLen] + LStr;
    end
    else
    Begin
      if (LCurrent <> 4) then
      begin
        case LCurrent of
          1:
            if ((L2RString <> '') or (LOutputList.Count = 0)) then
              L2RString := L2RString + LStr
            else if LNumString <> '' then
            begin
              LNumString := LNumString + LStr;
              LOutputList.Insert(LInserIndex, LNumString);
              LNumString := '';
            end
            else
              LOutputList.Insert(LInserIndex, LStr);
          2:
            if ((L2RString <> '') or (LOutputList.Count = 0)) then
              L2RString := L2RString + LStr
            else
              L2RString := L2RString + LStr;
          3:
            LOutputList.Insert(LInserIndex, LStr);
        end;
        LStr := '';
      end;
      LCurrent := 4;
      LStr := LStr + OriginalStr[LLen];
    end;
  end;

  if (LStr <> '') and (LCurrent = 1) then
  begin
    if ((L2RString <> '') or (LOutputList.Count = 0)) then
    begin
      L2RString := L2RString + LStr;
      LOutputList.Add(L2RString);
      L2RString := '';
    end
    else if LNumString <> '' then
    begin
      LNumString := LNumString + LStr;
      LOutputList.Insert(LInserIndex, LNumString);
      LNumString := '';
    end
    else
      LOutputList.Insert(LInserIndex, LStr);
  end
  else if (LStr <> '') and (LCurrent = 2) then
  begin
    if ((L2RString <> '') or (LOutputList.Count = 0)) then
    begin
      L2RString := L2RString + LStr;
      LOutputList.Add(L2RString);
      L2RString := '';
    end
    else
      LOutputList.Add(LStr);
  end
  else if (LStr <> '') and (LCurrent = 3) then
  begin
    LOutputList.Insert(LInserIndex, LStr);
  end
  else if (LStr <> '') and (LCurrent = 4) then
  begin
    L2RString := L2RString + LStr;
    LOutputList.Add(L2RString);
    L2RString := '';
  end;
  for LCnt := 0 to LOutputList.Count - 1 do
    Result := Result + LOutputList[LCnt];
end;

procedure TgtCustomDocumentEngine.SetAutoPaginate(const Value: Boolean);
begin
  FIsAutoPaginate := Value;
end;

procedure TgtCustomDocumentEngine.FreeJpegImageResource;
var
  LI: Integer;
begin
  for LI := 0 to FImageResourceList.Count - 1 do
  begin
    if ((FImageResourceList.Items[LI] <> nil) and
      (TObject(FImageResourceList.Items[LI]) is TStream)) then
    begin
      // Just assign nil so that the Document Item list will free it later
      FImageResourceList.Items[LI] := nil;
      TgtHashValue(FImageResourceHashList[LI]).Free;
    end;
  end;
end;

procedure TgtCustomDocumentEngine.FreeImageResourceList;
var
  I: Integer;
begin
  for I := 0 to FImageResourceList.Count - 1 do
    if (FImageResourceList.Items[I] <> nil) then
    begin
      TGraphic(FImageResourceList.Items[I]).Free;
      if (I <= FImageResourceHashList.Count - 1) then
      begin
        if (FImageResourceHashList.Count <> 0) and
          (Assigned(TgtHashValue(FImageResourceHashList[I]))) then
          TgtHashValue(FImageResourceHashList[I]).Free;
      end;
      FImageResourceList.Items[I] := nil;
    end;

end;

procedure TgtCustomDocumentEngine.DrawJPEGDirect(ImageRect: TgtRect;
  AGraphic: TGraphic);
var
  LImageStream: TgtImageStream;
  LStream: TMemoryStream;
begin
  if not FIsDocumentStarted or not(ckImage in Capabilities) or
    not(irImage in ItemsToRender) then
    exit;
{$IFNDEF gtRegistered}
{$IFDEF gtFileMaker}
  if (not FStatusMgr.IsException) then
{$ENDIF}
    if FPageCount > CMaxPages then
      exit;
{$ENDIF}
  LStream := TMemoryStream.Create;
  ImageRect := NativeRect(ImageRect);
  LImageStream := TgtImageStream.Create(ImageRect);
  LImageStream.X := ImageRect.Left;
  LImageStream.Y := ImageRect.Top;
  LImageStream.DisplayRect := ImageRect;

  AGraphic.SaveToStream(LStream);
  LStream.Position := 0;
  LImageStream.Stream.CopyFrom(LStream, 0);
  LImageStream.ImageHeight := AGraphic.Height;
  LImageStream.ImageWidth := AGraphic.Width;
  LImageStream.Settings := ImageSettings;
  LImageStream.IndexNo := GetImageResourceIndex(LImageStream.Stream);
  AddDocumentItem(LImageStream);
  LStream.Free;
end;

procedure TgtCustomDocumentEngine.ClearStamp;
var
  I: Integer;

begin
  for I := 0 to FStampItem.FDocumentItems.Count - 1 do
  begin
    TgtDocumentItem(FStampItem.FDocumentItems.Items[I]).Free;
  end;
  FStampItem.FDocumentItems.Clear;
  for I := 0 to FStampItem.FTextItems.Count - 1 do
  begin
    TgtDocumentItem(FStampItem.FTextItems.Items[I]).Free;
  end;
  FStampItem.FTextItems.Clear;
  FStampItem.FOffsetY := 0;
end;

procedure TgtCustomDocumentEngine.ClearWaterMark;
var
  I: Integer;
begin
  for I := 0 to FWatermarkItem.FDocumentItems.Count - 1 do
  begin
    TgtDocumentItem(FWatermarkItem.FDocumentItems.Items[I]).Free;
  end;
  FWatermarkItem.FDocumentItems.Clear;
  for I := 0 to FWatermarkItem.FTextItems.Count - 1 do
  begin
    TgtDocumentItem(FWatermarkItem.FTextItems.Items[I]).Free;
  end;
  FWatermarkItem.FTextItems.Clear;
  FWatermarkItem.FOffsetY := 0;
end;

procedure TgtCustomDocumentEngine.ClearFooter;
var
  I: Integer;
begin
  for I := 0 to FFooterItem.FDocumentItems.Count - 1 do
  begin
    TgtDocumentItem(FFooterItem.FDocumentItems.Items[I]).Free;
  end;
  FFooterItem.FDocumentItems.Clear;
  for I := 0 to FFooterItem.FTextItems.Count - 1 do
  begin
    TgtDocumentItem(FFooterItem.FTextItems.Items[I]).Free;
  end;
  FFooterItem.FTextItems.Clear;
  FFooterItem.FOffsetY := 0;
end;

procedure TgtCustomDocumentEngine.ClearHeader;
var
  I: Integer;
begin
  for I := 0 to FHeaderItem.FDocumentItems.Count - 1 do
  begin
    TgtDocumentItem(FHeaderItem.FDocumentItems.Items[I]).Free;
  end;
  FHeaderItem.FDocumentItems.Clear;
  for I := 0 to FHeaderItem.FTextItems.Count - 1 do
  begin
    TgtDocumentItem(FHeaderItem.FTextItems.Items[I]).Free;
  end;
  FHeaderItem.FTextItems.Clear;
  FHeaderItem.FOffsetY := 0;
end;
{$IFDEF gtActiveX}

procedure TgtCustomDocumentEngine.SetOnCellDraw(const Value
  : TgtOnCellDrawEvent);
begin
  FOnCellDraw := Value;
end;

procedure TgtCustomDocumentEngine.SetOnCellDrawEx
  (const Value: TgtOnCellDrawExEvent);
begin
  FOnCellDrawEx := Value;
end;
{$ELSE}

procedure TgtCustomDocumentEngine.SetOnCellDraw(const Value
  : TgtOnCellDrawEvent);
begin
  FOnCellDraw := Value;
end;
{$ENDIF}
{$IFDEF gtFileMaker}

function TgtCustomDocumentEngine.ActivateLicense(ALicenseKey: String): Boolean;
begin
  Result := False;
  if (FEngineStatus <> esStarted) then
    Result := FStatusMgr.StatusChanged(ALicenseKey);
end;
{$ENDIF}

function TgtCustomDocumentEngine.AddImageAsResource(AGraphic: TGraphic;
  AResource: Boolean): Integer;
var
  LGraphic: TGraphic;
begin
  Result := -1;
  if not FIsDocumentStarted or not(ckImage in Capabilities) then
    exit;
  Preferences.UseImagesAsResources := AResource;
  with Pages[FCurrentPage - 1] do
  begin
    LGraphic := TGraphicClass(AGraphic.ClassType).Create;
  end;
  try
    LGraphic.Assign(AGraphic)
  except
    LGraphic.Free;
    if Assigned(FOnErrorMessage) then
      OnErrorMessage(Self, EUnsupportedGraphics.Create(SUnsupportedGraphics))
    else
      raise EUnsupportedGraphics.Create(SUnsupportedGraphics);
    exit;
  end;
  Result := GetImageResourceIndex(LGraphic);

end;

{ TgtPageItem }

constructor TgtPageItem.Create(AParent: TgtCustomDocumentEngine);
begin
  inherited Create;
  FParent := AParent;
  FSettings := TgtPageSettings.Create(nil);
end;

destructor TgtPageItem.Destroy;
begin
  FreeAndNil(FSettings);
  inherited;
end;

procedure TgtPageItem.SetSettings(Value: TgtPageSettings);
begin
  FSettings.Assign(Value);
end;

{ TgtEngineState }

constructor TgtEngineState.Create;
begin
  FFont := TFont.Create;
  FPen := TPen.Create;
  FBrush := TBrush.Create;
  FImageSettings := TgtImageSettings.Create(Self);
  FTextFormatting := TgtTextFormatting.Create;
  FTableSettings := TgtTableSettings.Create;
  FTextEffects := TgtTextEffects.Create;
  FPage := TgtPageSettings.Create(nil);
end;

destructor TgtEngineState.Destroy;
begin
  FreeAndNil(FFont);
  FreeAndNil(FPen);
  FreeAndNil(FBrush);
  FreeAndNil(FImageSettings);
  FreeAndNil(FTextFormatting);
  FreeAndNil(FTableSettings);
  FreeAndNil(FTextEffects);
  FreeAndNil(FPage);
  inherited;
end;

{ TgtPageSettings }

procedure TgtPageSettings.Assign(Source: TPersistent);
var
  LSettings: TgtPageSettings;
begin
  if Source is TgtPageSettings then
  begin
    LSettings := TgtPageSettings(Source);
    FPaperSize := LSettings.FPaperSize;
    FWidth := LSettings.FWidth;
    FHeight := LSettings.FHeight;
    FFooterHeight := LSettings.FFooterHeight;
    FHeaderHeight := LSettings.FHeaderHeight;
    FLeftMargin := LSettings.FLeftMargin;
    FBinNumber := LSettings.FBinNumber;
    FRightMargin := LSettings.FRightMargin;
    FTopMargin := LSettings.FTopMargin;
    FBottomMargin := LSettings.FBottomMargin;
    FOrientation := LSettings.FOrientation;
    exit;
  end;
  inherited Assign(Source);
end;

constructor TgtPageSettings.Create(AParent: TObject);
begin
  FParent := AParent;
  FNativeFactor := 1;
  FOrientation := poPortrait;
  FBinNumber := 0;
  PaperSize := A4;
end;

destructor TgtPageSettings.Destroy;
begin

  inherited;
end;

function TgtPageSettings.GetBottomMargin: Double;
begin
  Result := FBottomMargin / FNativeFactor;
end;

function TgtPageSettings.GetFooterHeight: Double;
begin
  Result := FFooterHeight / FNativeFactor;
end;

function TgtPageSettings.GetBinNumber: Integer;
begin
  Result := FBinNumber;
end;

procedure TgtPageSettings.SetBinNumber(Value: Integer);
begin
  FBinNumber := Value;
end;

function TgtPageSettings.GetHeaderHeight: Double;
begin
  Result := FHeaderHeight / FNativeFactor;
end;

function TgtPageSettings.GetHeight: Double;
begin
  Result := FHeight / FNativeFactor;
end;

function TgtPageSettings.GetLeftMargin: Double;
begin
  Result := FLeftMargin / FNativeFactor;
end;

function TgtPageSettings.GetRightMargin: Double;
begin
  Result := FRightMargin / FNativeFactor;
end;

function TgtPageSettings.GetTopMargin: Double;
begin
  Result := FTopMargin / FNativeFactor;
end;

function TgtPageSettings.GetWidth: Double;
begin
  Result := FWidth / FNativeFactor;
end;

procedure TgtPageSettings.SetBottomMargin(const Value: Double);
var
  I: Integer;
begin
  if (FParent = nil) then
    FBottomMargin := Value * FNativeFactor
  else
  begin
    if FParent is TgtDocSettings then
      for I := 0 to TgtDocSettings(FParent).FEngineList.Count - 1 do
        with TgtCustomDocumentEngine(TgtDocSettings(FParent).FEngineList[I]) do
          if (FBottomMargin = Page.FBottomMargin) then
            Page.FBottomMargin := Value * FNativeFactor;
    FBottomMargin := Value * FNativeFactor;
  end;
end;

procedure TgtPageSettings.SetFooterHeight(const Value: Double);
var
  I: Integer;
begin
  if (FParent = nil) then
    FFooterHeight := Value * FNativeFactor
  else
  begin
    if FParent is TgtDocSettings then
      for I := 0 to TgtDocSettings(FParent).FEngineList.Count - 1 do
        with TgtCustomDocumentEngine(TgtDocSettings(FParent).FEngineList[I]) do
          if (FFooterHeight = FPage.FFooterHeight) then
            FPage.FFooterHeight := Value * FNativeFactor;
    FFooterHeight := Value * FNativeFactor;
  end;
end;

procedure TgtPageSettings.SetHeaderHeight(const Value: Double);
var
  I: Integer;
begin
  if (FParent = nil) then
    FHeaderHeight := Value * FNativeFactor
  else
  begin
    if FParent is TgtDocSettings then
      for I := 0 to TgtDocSettings(FParent).FEngineList.Count - 1 do
        with TgtCustomDocumentEngine(TgtDocSettings(FParent).FEngineList[I]) do
          if (FHeaderHeight = Page.FHeaderHeight) then
            Page.FHeaderHeight := Value * FNativeFactor;
    FHeaderHeight := Value * FNativeFactor;
  end;
end;

procedure TgtPageSettings.SetHeight(const Value: Double);
var
  I: Integer;
begin
  if FPaperSize = Custom then
    if (FParent = nil) then
      FHeight := Value * FNativeFactor
    else
    begin
      if FParent is TgtDocSettings then
        for I := 0 to TgtDocSettings(FParent).FEngineList.Count - 1 do
          with TgtCustomDocumentEngine(TgtDocSettings(FParent)
            .FEngineList[I]) do
            if (FHeight = Page.FHeight) and (Page.PaperSize = Custom) then
              Page.FHeight := Value * FNativeFactor;
      FHeight := Value * FNativeFactor;
    end;
end;

procedure TgtPageSettings.SetLeftMargin(const Value: Double);
var
  I: Integer;
begin
  if (FParent = nil) then
    FLeftMargin := Value * FNativeFactor
  else
  begin
    if FParent is TgtDocSettings then
      for I := 0 to TgtDocSettings(FParent).FEngineList.Count - 1 do
        with TgtCustomDocumentEngine(TgtDocSettings(FParent).FEngineList[I]) do
          if (FLeftMargin = Page.FLeftMargin) then
            Page.FLeftMargin := Value * FNativeFactor;
    FLeftMargin := Value * FNativeFactor;
  end;
end;

procedure TgtPageSettings.SetOrientation(const Value: TPrinterOrientation);
var
  I: Integer;
  LTemp: Double;
begin
  if FOrientation = Value then
    exit;

  if FParent is TgtDocSettings then
    for I := 0 to TgtDocSettings(FParent).FEngineList.Count - 1 do
      with TgtCustomDocumentEngine(TgtDocSettings(FParent).FEngineList[I]) do
        if (FOrientation = Page.FOrientation) then
          Page.Orientation := Value;
  LTemp := FWidth;
  FWidth := FHeight;
  FHeight := LTemp;
  FOrientation := Value;
end;

procedure TgtPageSettings.SetPaperSize(const Value: TgtPaperSize);
var
  I: Integer;
begin

  if (FParent = nil) then
    FPaperSize := Value
  else
  begin
    if FParent is TgtDocSettings then
      for I := 0 to TgtDocSettings(FParent).FEngineList.Count - 1 do
        with TgtCustomDocumentEngine(TgtDocSettings(FParent).FEngineList[I]) do
          if (FPaperSize = Page.FPaperSize) then
            Page.PaperSize := Value;
    FPaperSize := Value;
  end;

  if Value = Custom then
    exit;

  if FOrientation = poPortrait then
  begin
    FWidth := (CPaperDimensions[Value, 0] * CInchesToPoints * CPointsToPixels);
    FHeight := (CPaperDimensions[Value, 1] * CInchesToPoints * CPointsToPixels);
  end
  else
  begin
    FWidth := CPaperDimensions[Value, 1] * CInchesToPoints * CPointsToPixels;
    FHeight := CPaperDimensions[Value, 0] * CInchesToPoints * CPointsToPixels;
  end;
end;

procedure TgtPageSettings.SetRightMargin(const Value: Double);
var
  I: Integer;
begin
  if (FParent = nil) then
    FRightMargin := Value * FNativeFactor
  else
  begin
    if FParent is TgtDocSettings then
      for I := 0 to TgtDocSettings(FParent).FEngineList.Count - 1 do
        with TgtCustomDocumentEngine(TgtDocSettings(FParent).FEngineList[I]) do
          if (FRightMargin = Page.FRightMargin) then
            Page.FRightMargin := Value * FNativeFactor;
    FRightMargin := Value * FNativeFactor;
  end;
end;

procedure TgtPageSettings.SetTopMargin(const Value: Double);
var
  I: Integer;
begin
  if (FParent = nil) then
    FTopMargin := Value * FNativeFactor
  else
  begin
    if FParent is TgtDocSettings then
      for I := 0 to TgtDocSettings(FParent).FEngineList.Count - 1 do
        with TgtCustomDocumentEngine(TgtDocSettings(FParent).FEngineList[I]) do
          if (FTopMargin = Page.FTopMargin) then
            Page.FTopMargin := Value * FNativeFactor;
    FTopMargin := Value * FNativeFactor;
  end;
end;

procedure TgtPageSettings.SetWidth(const Value: Double);
var
  I: Integer;
begin
  if FPaperSize = Custom then
    if (FParent = nil) then
      FWidth := Value * FNativeFactor
    else
    begin
      if FParent is TgtDocSettings then
        for I := 0 to TgtDocSettings(FParent).FEngineList.Count - 1 do
          with TgtCustomDocumentEngine(TgtDocSettings(FParent)
            .FEngineList[I]) do
            if (FWidth = Page.FWidth) and (Page.PaperSize = Custom) then
              Page.FWidth := Value * FNativeFactor;
      FWidth := Value * FNativeFactor;
    end;
end;

{ TgtFrame }

procedure TgtFrame.Assign(Source: TPersistent);
begin
  if Source is TgtFrame then
  begin
    FIsLeft := TgtFrame(Source).FIsLeft;
    FIsRight := TgtFrame(Source).FIsRight;
    FIsTop := TgtFrame(Source).FIsTop;
    FIsBottom := TgtFrame(Source).FIsBottom;
    FInternalMargin := TgtFrame(Source).FInternalMargin;
    exit;
  end;
  inherited Assign(Source);
end;

constructor TgtFrame.Create(AParent: TObject);
begin
  FParent := AParent;
  FIsLeft := True;
  FIsRight := True;
  FIsTop := True;
  FIsBottom := True;
end;

destructor TgtFrame.Destroy;
begin

  inherited;
end;

function TgtFrame.GetInternalMargin: TgtRect;
begin
  if FParent is TgtCustomDocumentEngine then
    with FParent as TgtCustomDocumentEngine do
      Result := gtRect(FInternalMargin, FNativeConversionFactor)
  else
    Result := FInternalMargin;
end;

procedure TgtFrame.SetInternalMargin(const Value: TgtRect);
begin
  if FParent is TgtCustomDocumentEngine then
    with FParent as TgtCustomDocumentEngine do
      FInternalMargin := gtRect(Value, FNativeConversionFactor)
  else
    FInternalMargin := Value;
end;

{ TgtTableItem }

function TgtTableItem.CalculateRowHeight: Double;
var
  I: Integer;
begin
  Result := 0;
  if Settings.EnableTitle then
    Result := Result + Settings.TitleHeight;
  for I := 0 to RowCount do
    Result := Result + Int64(RowHeights.Items[I]);
end;

procedure TgtTableItem.ChangeValue(var AValue: Double);
begin
  AValue := AValue;
end;

constructor TgtTableItem.Create(NoColumns: Integer;
  AParent: TgtCustomDocumentEngine);
var
  I: Integer;
  LColumn: TgtColumn;
begin
  FParent := AParent;
  FBrush := TBrush.Create;
  FFont := TFont.Create;
  FPen := TPen.Create;
  FTextEffects := TgtTextEffects.Create;
  FRowHeights := TList.Create;
  FColumns := TList.Create;
  FSettings := TgtTableSettings.Create;
  FColCount := NoColumns;
  FRowCount := -1;
  for I := 0 to FColCount - 1 do
  begin
    LColumn := TgtColumn.Create;
    LColumn.FOnchange := ChangeValue;
    FColumns.Add(LColumn);
  end;
  FRowItemsList := TList.Create;
end;

destructor TgtTableItem.Destroy;
var
  I, J: Integer;
begin
  FreeAndNil(FBrush);
  FreeAndNil(FFont);
  FreeAndNil(FPen);
  FreeAndNil(FTextEffects);
  FreeAndNil(FRowHeights);
  FreeAndNil(FSettings);

  for I := 0 to FColCount - 1 do
    TgtColumn(FColumns.Items[I]).Free;

  for I := 0 to FRowCount do
  begin
    for J := 0 to RowItemsList[I].Count - 1 do
      TgtDocumentItem(RowItemsList[I].Items[J]).Free;
    TList(FRowItemsList[I]).Free;
  end;

  FreeAndNil(FRowItemsList);
  FreeAndNil(FColumns);
  inherited;
end;

function TgtTableItem.GetColumns(Index: Integer): TgtColumn;
begin
  Result := nil;
  if Index < FColCount then
    Result := TgtColumn(FColumns.Items[Index]);
end;

function TgtTableItem.GetColumnsList: TList;
var
  I: Integer;
begin
  for I := 0 to FColCount - 1 do
    TgtColumn(FColumns.Items[I]).FWidth := Settings.FColumnWidth;
  Result := FColumns;
end;

function TgtTableItem.GetRowItemsList(Index: Integer): TList;
begin
  Result := TList(FRowItemsList.Items[Index]);
end;

procedure TgtTableItem.SetBrush(Value: TBrush);
begin
  FBrush.Assign(Value);
end;

procedure TgtTableItem.SetColumns(Index: Integer; Value: TgtColumn);
begin
  if Index < FColCount then
  begin
    FColumns.Items[Index] := Value;
  end;
end;

procedure TgtTableItem.SetFont(Value: TFont);
begin
  FFont.Assign(Value);
end;

procedure TgtTableItem.SetPen(Value: TPen);
begin
  FPen.Assign(Value);
end;

procedure TgtTableItem.SetRowItemsList(Index: Integer; const Value: TList);
begin
  FRowItemsList.Items[Index] := Value;
end;

procedure TgtTableItem.SetSettings(Value: TgtTableSettings);
begin
  FSettings.Assign(Value);
end;

procedure TgtTableItem.SetTextEffects(const Value: TgtTextEffects);
begin
  FTextEffects.TextRenderMode := Value.TextRenderMode;
  FTextEffects.TextRise := Value.TextRise;
end;

{ TgtTableSettings }

procedure TgtTableSettings.Assign(Source: TPersistent);
var
  LSettings: TgtTableSettings;
begin
  if Source is TgtTableSettings then
  begin
    LSettings := TgtTableSettings(Source);
    FAutoAdjustColumnWidth := LSettings.FAutoAdjustColumnWidth;
    FColumnWidth := LSettings.FColumnWidth;
    FRowHeight := LSettings.FRowHeight;
    FInternalMargin := LSettings.FInternalMargin;
    FEnableTitle := LSettings.FEnableTitle;
    FTitleHeight := LSettings.FTitleHeight;
    exit;
  end;
  inherited Assign(Source);
end;

constructor TgtTableSettings.Create;
begin
  FTitleHeight := 0;
  FNativeFactor := 1;
end;

destructor TgtTableSettings.Destroy;
begin

  inherited;
end;

function TgtTableSettings.GetColumnWidth: Double;
begin
  Result := FColumnWidth / FNativeFactor;
end;

function TgtTableSettings.GetInternalMargin: TgtRect;
begin
  Result := gtRect(FInternalMargin, 1 / FNativeFactor);
end;

function TgtTableSettings.GetRowHeight: Double;
begin
  Result := FRowHeight / FNativeFactor;

end;

function TgtTableSettings.GetTitleHeight: Double;
begin
  Result := FTitleHeight / FNativeFactor;
end;

procedure TgtTableSettings.SetColumnWidth(const Value: Double);
begin
  FColumnWidth := Value * FNativeFactor;
end;

procedure TgtTableSettings.SetInternalMargin(const Value: TgtRect);
begin
  FInternalMargin := gtRect(Value, FNativeFactor);
end;

procedure TgtTableSettings.SetRowHeight(const Value: Double);
begin
  FRowHeight := Value * FNativeFactor;
end;

procedure TgtTableSettings.SetTitleHeight(const Value: Double);
begin
  FTitleHeight := Value * FNativeFactor;
end;

{ TgtParagraphItem }

constructor TgtParagraphItem.Create;
begin
  inherited;
  FFont := TFont.Create;
  FBrush := TBrush.Create;
  FTextEffects := TgtTextEffects.Create;
  FSettings := TgtTextFormatting.Create;
  FLines := TWideStrings.Create;
end;

destructor TgtParagraphItem.Destroy;
begin
  FreeAndNil(FFont);
  FreeAndNil(FBrush);
  FreeAndNil(FTextEffects);
  FreeAndNil(FLines);
  FreeAndNil(FSettings);
  inherited;
end;

procedure TgtParagraphItem.SetBrush(Value: TBrush);
begin
  FBrush.Assign(Value);
end;

procedure TgtParagraphItem.SetFont(Value: TFont);
begin
  FFont.Assign(Value);
end;

procedure TgtParagraphItem.SetSettings(Value: TgtTextFormatting);
begin
  FSettings.Assign(Value);
end;

procedure TgtParagraphItem.SetTextEffects(const Value: TgtTextEffects);
begin
  FTextEffects.TextRenderMode := Value.TextRenderMode;
  FTextEffects.TextRise := Value.TextRise;
end;

{ TgtTextFormatting }

procedure TgtTextFormatting.Assign(Source: TPersistent);
var
  LSettings: TgtTextFormatting;
begin
  if Source is TgtTextFormatting then
  begin
    LSettings := TgtTextFormatting(Source);
    FBeforeSpace := LSettings.FBeforeSpace;
    FFirstLineIndent := LSettings.FFirstLineIndent;
    FLeftIndent := LSettings.FLeftIndent;
    FRightIndent := LSettings.FRightIndent;
    FLineSpacing := LSettings.FLineSpacing;
    FAlignment := LSettings.FAlignment;
    Border := LSettings.FBorder;
    exit;
  end;
  inherited Assign(Source);
end;

constructor TgtTextFormatting.Create;
begin
  FLineSpacing := 1;
  FNativeFactor := 1;
  FBorder := TgtParaBorder.Create;
end;

destructor TgtTextFormatting.Destroy;
begin
  FBorder.Free;
  inherited;
end;

function TgtTextFormatting.GetBeforeSpace: Double;
begin
  Result := FBeforeSpace / FNativeFactor;
end;

function TgtTextFormatting.GetFirstLineIndent: Double;
begin
  Result := FFirstLineIndent / FNativeFactor;
end;

function TgtTextFormatting.GetLeftIndent: Double;
begin
  Result := FLeftIndent / FNativeFactor;
end;

function TgtTextFormatting.GetRightIndent: Double;
begin
  Result := FRightIndent / FNativeFactor;
end;

procedure TgtTextFormatting.SetBeforeSpace(const Value: Double);
begin
  FBeforeSpace := Value * FNativeFactor;
end;

procedure TgtTextFormatting.SetBorder(const Value: TgtParaBorder);
begin
  FBorder.Assign(Value);
end;

procedure TgtTextFormatting.SetFirstLineIndent(const Value: Double);
begin
  FFirstLineIndent := Value * FNativeFactor;
end;

procedure TgtTextFormatting.SetLeftIndent(const Value: Double);
begin
  FLeftIndent := Value * FNativeFactor;
end;

procedure TgtTextFormatting.SetRightIndent(const Value: Double);
begin
  FRightIndent := Value * FNativeFactor;
end;

{ TgtImageSettings }

procedure TgtImageSettings.Assign(Source: TPersistent);
var
  LSettings: TgtImageSettings;
begin
  if Source is TgtImageSettings then
  begin
    LSettings := TgtImageSettings(Source);
    Center := LSettings.Center;
    AutoSize := LSettings.AutoSize;
    Stretch := LSettings.Stretch;
    Transparent := LSettings.Transparent;
    KeepAspectRatio := LSettings.KeepAspectRatio;
    Inclination := LSettings.Inclination;
    OutputImageFormat := LSettings.OutputImageFormat;
    ImagePixelFormat := LSettings.ImagePixelFormat;
    JPEGQuality := LSettings.JPEGQuality;
    SourceDPI := LSettings.SourceDPI;
    IsFrame := LSettings.IsFrame;
    exit;
  end;
  inherited Assign(Source);
end;

constructor TgtImageSettings.Create(AParent: TObject);
begin
  FParent := AParent;
  FSourceDPI := CPixelsPerInch;
  FJPEGQuality := 100;
  FImagePixelFormat := pf24bit;
  FOutputImageFormat := ifJPEG;
end;

constructor TgtImageSettings.Create;
begin
  FParent := nil;
  FSourceDPI := CPixelsPerInch;
  FJPEGQuality := 100;
  FImagePixelFormat := pf24bit;
  FOutputImageFormat := ifJPEG;
end;

destructor TgtImageSettings.Destroy;
begin

  inherited;
end;

procedure TgtImageSettings.SetOutputImageFormat(const Value
  : TgtOutputImageFormat);
var
  LS: String;
begin
  if (FParent <> nil) and (FParent is TgtCustomDocumentEngine) and
    not TgtCustomDocumentEngine(FParent).CheckOutputImageFormat(Value, LS) then
    // MessageDlg(LS, mtError, [mbOK], 0)
    raise ExInvalidImageFormat.Create(ErrInvalidImageFormat)
  else
    FOutputImageFormat := Value;
end;

procedure TgtImageSettings.SetSourceDPI(const Value: Integer);
begin
  FSourceDPI := Value;
end;

{ TgtTextItem }

constructor TgtTextItem.Create;
begin
  FLines := TWideStrings.Create;
  FFont := TFont.Create;
  FBrush := TBrush.Create;
  FTextEffects := TgtTextEffects.Create;
  FIsClipRect := False;
  FAlignment := haLeft;
  FClipRect := gtRect(0, 0, 0, 0);
  FIsFromMetafile := False;
  FIsWideString := False;
end;

destructor TgtTextItem.Destroy;
begin
  FreeAndNil(FLines);
  FreeAndNil(FFont);
  FreeAndNil(FBrush);
  FreeAndNil(FTextEffects);
  inherited;
end;

procedure TgtTextItem.SetAlignment(const Value: TgtHAlignment);
begin
  FAlignment := Value;
end;

procedure TgtTextItem.SetBrush(Value: TBrush);
begin
  FBrush.Assign(Value);
end;

procedure TgtTextItem.SetClipRect(const Value: TgtRect);
begin
  FClipRect := gtRect(Value, 1);
end;

procedure TgtTextItem.SetFont(Value: TFont);
begin
  FFont.Assign(Value);
end;

procedure TgtTextItem.SetIsClipRect(const Value: Boolean);
begin
  FIsClipRect := Value;
  if (not FIsClipRect) then
    FClipRect := gtRect(0, 0, 0, 0);
end;

procedure TgtTextItem.SetRotationAngle(Value: Integer);
begin
  FRotationAngle := Value;
end;

procedure TgtTextItem.SetTextEffects(const Value: TgtTextEffects);
begin
  FTextEffects.TextRenderMode := Value.TextRenderMode;
  FTextEffects.TextRise := Value.TextRise;
end;

{ TgtImageItem }

constructor TgtImageItem.Create;
begin
  FPen := TPen.Create;
  FBrush := TBrush.Create;
  FFrame := TgtFrame.Create(nil);
  FSettings := TgtImageSettings.Create(Self);
end;

constructor TgtImageItem.Create(AImageRect: TgtRect);
begin
  FPen := TPen.Create;
  FFrame := TgtFrame.Create(nil);
  FBrush := TBrush.Create;
  FSettings := TgtImageSettings.Create(Self);
  with AImageRect do
  begin
    if Left < Right then
      X := Left
    else
      X := Right;
    if Top < Bottom then
      Y := Top
    else
      Y := Bottom;
    Width := Abs(Right - Left);
    Height := Abs(Bottom - Top);
    DisplayRect := gtRect(X, Y, X + Width, Y + Height);
  end;
end;

destructor TgtImageItem.Destroy;
begin
  FreeAndNil(FPen);
  FreeAndNil(FBrush);
  FreeAndNil(FFrame);
  FreeAndNil(FSettings);
  inherited;
end;

procedure TgtImageItem.SetBrush(const Value: TBrush);
begin
  FBrush.Assign(Value);
end;

procedure TgtImageItem.SetFrame(const Value: TgtFrame);
begin
  FFrame.Assign(Value);
end;

procedure TgtImageItem.SetPen(Value: TPen);
begin
  FPen.Assign(Value);
end;

procedure TgtImageItem.SetSettings(Value: TgtImageSettings);
begin
  FSettings.Assign(Value);
end;

{ TgtShapeItem }

constructor TgtShapeItem.Create(IsFill: Boolean; ShapeType: TgtShapeType);
begin
  FPen := TPen.Create;
  FShapeType := ShapeType;
  if IsFill then
    FBrush := TBrush.Create;
end;

destructor TgtShapeItem.Destroy;
begin
  FreeAndNil(FPen);
  if FBrush <> nil then
    FreeAndNil(FBrush);
  Finalize(FPoints);
{$IFNDEF gtDelphi2005Up}
  FreeMem(FPoints);
{$ENDIF}
  inherited;
end;

function TgtShapeItem.GetPoints: TgtPoints;
begin
  Result := FPoints;
end;

procedure TgtShapeItem.SetBrush(Value: TBrush);
begin
  FBrush.Assign(Value);
end;

procedure TgtShapeItem.SetPen(Value: TPen);
begin
  FPen.Assign(Value);
end;

procedure TgtShapeItem.SetPoints(Points: array of TgtPoint);
begin
  NoPoints := SizeOf(Points) div SizeOf(TgtPoint);

  SetLength(FPoints, NoPoints);
  CopyMemory(FPoints, @Points, SizeOf(Points)); { check this routine }
end;

{ TgtClipItem }
constructor TgtClipItem.Create;
begin
  FBrush := TBrush.Create;
  FPen := TPen.Create;
  Restore := False;
end;

destructor TgtClipItem.Destroy;
begin
  FreeAndNil(FPen);
  FreeAndNil(FBrush);
  Finalize(FClipRects);
{$IFNDEF gtDelphi2005Up}
  FreeMem(FClipRects);
{$ENDIF}
  inherited;
end;

procedure TgtClipItem.SetBrush(Value: TBrush);
begin
  FBrush.Assign(Value);
end;

procedure TgtClipItem.SetPen(Value: TPen);
begin
  FPen.Assign(Value);
end;

procedure TgtClipItem.SetRects(FRectNo: Integer);
begin
  FNoRects := FRectNo;
  SetLength(FClipRects, FNoRects);
end;

function TgtClipItem.GetRects(Position: Integer): TRect;
begin
  Result := Rect(FClipRects[Position].Left, FClipRects[Position].Top,
    FClipRects[Position].Right, FClipRects[Position].Bottom);
end;

{ TgtEOFItem }

constructor TgtEOFItem.Create;
begin
  FStatus := False;
end;

destructor TgtEOFItem.Destroy;
begin
  inherited;
end;

{ TgtPathItem }

constructor TgtPathItem.Create;
begin
  FMode := 0;
  FBrush := nil;
  FPen := nil;
end;

destructor TgtPathItem.Destroy;
begin
  inherited;
  if Assigned(FBrush) then
    FBrush.Free;
  if Assigned(FPen) then
    FPen.Free;
end;

procedure TgtPathItem.SetBrush(Value: TBrush);
begin
  FBrush := TBrush.Create;
  FBrush.Assign(Value);
end;

procedure TgtPathItem.SetPen(Value: TPen);
begin
  FPen := TPen.Create;
  FPen.Assign(Value);
end;

procedure TgtPathItem.SetFillAlternate(const Value: Boolean);
begin
  FFillAlternate := Value;
end;

{ TgtColumn }

constructor TgtColumn.Create;
begin
end;

procedure TgtColumn.SetWidth(const Value: Double);
begin
  FWidth := Value;
  if Assigned(FOnchange) then
    FOnchange(FWidth);
end;

{ TgtTextBoxItem }

constructor TgtTextBoxItem.Create;
begin
  inherited;
  FPen := TPen.Create;
  FFrame := TgtFrame.Create(nil);
end;

destructor TgtTextBoxItem.Destroy;
begin
  inherited;
  FreeAndNil(FPen);
  FreeAndNil(FFrame);
end;

procedure TgtTextBoxItem.SetFrame(const Value: TgtFrame);
begin
  FFrame.Assign(Value);
end;

procedure TgtTextBoxItem.SetPen(Value: TPen);
begin
  FPen.Assign(Value);
end;

{ General Procedure }
function gtPoint(X, Y: Double): TgtPoint;
begin
  Result.X := X;
  Result.Y := Y;
end;

{ TgtBaseDlg }

constructor TgtBaseDlg.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

procedure TgtBaseDlg.SetEngine(const Value: TgtCustomDocumentEngine);
begin
  FEngine := Value;
end;

{ TgtEMailSettings }

procedure TgtEmailSettings.Assign(Source: TPersistent);
begin
  if Source is TgtEmailSettings then
  begin
    FHost := TgtEmailSettings(Source).FHost;
    FUserID := TgtEmailSettings(Source).FUserID;
    FPassword := TgtEmailSettings(Source).FPassword;
    FAttachments.Assign(TgtEmailSettings(Source).FAttachments);
    FBody.Assign(TgtEmailSettings(Source).FBody);
    FDate := TgtEmailSettings(Source).FDate;
    FFromAddress := TgtEmailSettings(Source).FFromAddress;
    FFromName := TgtEmailSettings(Source).FFromName;
    FReplyTo := TgtEmailSettings(Source).FReplyTo;
    FSubject := TgtEmailSettings(Source).FSubject;
    FRecipientList.Assign(TgtEmailSettings(Source).FRecipientList);
    FReceiptRecipient := TgtEmailSettings(Source).FReceiptRecipient;
    FCCList.Assign(TgtEmailSettings(Source).FCCList);
    FBCCList.Assign(TgtEmailSettings(Source).FBCCList);
    FAuthenticationRequired := TgtEmailSettings(Source).FAuthenticationRequired;
    FPort := TgtEmailSettings(Source).FPort;
    exit;
  end;
  inherited Assign(Source);
end;

function TgtEmailSettings.Clone: TgtEmailSettings;
begin
  Result := TgtEmailSettings.Create;
  Result.Host := Host;
  Result.UserID := UserID;
  Result.Password := Password;
  Result.Attachments.AddStrings(Attachments);
  Result.Body.Assign(Body);
  Result.Date := Date;
  Result.FromAddress := FromAddress;
  Result.FromName := FromName;
  Result.ReplyTo := ReplyTo;
  Result.Subject := Subject;
  Result.RecipientList.Assign(RecipientList);
  Result.CCList.Assign(CCList);
  Result.BCCList.Assign(BCCList);
  Result.AuthenticationRequired := AuthenticationRequired;
  Result.Port := Port;
end;

constructor TgtEmailSettings.Create;
begin
  FPort := 25;
  FAttachments := TStringList.Create;
  FBody := TStringList.Create;
  FRecipientList := TStringList.Create;
  FBCCList := TStringList.Create;
  FCCList := TStringList.Create;
end;

destructor TgtEmailSettings.Destroy;
begin
  FreeAndNil(FAttachments);
  FreeAndNil(FBody);
  FreeAndNil(FRecipientList);
  FreeAndNil(FBCCList);
  FreeAndNil(FCCList);
  inherited;
end;

procedure TgtEmailSettings.SetAttachments(const Value: TStringList);
begin
  FAttachments.Assign(Value);
end;

procedure TgtEmailSettings.SetBCCList(const Value: TStringList);
begin
  FBCCList.Assign(Value);
end;

procedure TgtEmailSettings.SetBody(const Value: TStringList);
begin
  FBody.Assign(Value);
end;

procedure TgtEmailSettings.SetCCList(const Value: TStringList);
begin
  FCCList.Assign(Value);
end;

procedure TgtEmailSettings.SetRecipientList(const Value: TStringList);
begin
  FRecipientList.Assign(Value);
end;

{ TgtDocSettings }

procedure TgtDocSettings.AddEngineToList(AEngine: TgtCustomDocumentEngine);
begin
  FEngineList.Add(AEngine);
  AEngine.BackgroundColor := FBackgroundColor;
  AEngine.BackgroundImage := FBackgroundImage;
  AEngine.BackgroundImageDisplayType := FBackgroundDisplayType;
  AEngine.DocInfo := DocInfo;
  AEngine.Page := Page;
  AEngine.Preferences := Preferences;
  AEngine.MeasurementUnit := MeasurementUnit;
end;

constructor TgtDocSettings.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FEngineList := TList.Create;
  FDocInfo := TgtDocInfo.Create(Self);
  FPage := TgtPageSettings.Create(Self);
  FPreferences := TgtPreferences.Create(Self);
  FBackgroundImage := TPicture.Create;
  FBackgroundColor := clWhite;
  FBackgroundDisplayType := dtCenter;
end;

destructor TgtDocSettings.Destroy;
begin
  FreeAndNil(FEngineList);
  FreeAndNil(FDocInfo);
  FreeAndNil(FPage);
  FreeAndNil(FPreferences);
  FreeAndNil(FBackgroundImage);
  inherited;
end;

procedure TgtDocSettings.RemoveEngineFromList(AEngine: TgtCustomDocumentEngine);
begin
  FEngineList.Remove(AEngine);
end;

procedure TgtDocSettings.SetBackgroundColor(const Value: TColor);
var
  I: Integer;
begin
  for I := 0 to FEngineList.Count - 1 do
    if (FBackgroundColor = TgtCustomDocumentEngine(FEngineList[I])
      .FBackgroundColor) then
      TgtCustomDocumentEngine(FEngineList[I]).FBackgroundColor := Value;
  FBackgroundColor := Value;
end;

procedure TgtDocSettings.SetBackgroundDisplayType
  (const Value: TgtBackgroundDisplayType);
var
  I: Integer;
begin
  for I := 0 to FEngineList.Count - 1 do
    if (FBackgroundDisplayType = TgtCustomDocumentEngine(FEngineList[I])
      .FBackgroundDisplayType) then
      TgtCustomDocumentEngine(FEngineList[I]).FBackgroundDisplayType := Value;
  FBackgroundDisplayType := Value;
end;

procedure TgtDocSettings.SetBackgroundImage(const Value: TPicture);
var
  I: Integer;
begin
  for I := 0 to FEngineList.Count - 1 do
    TgtCustomDocumentEngine(FEngineList[I]).BackgroundImage := Value;
  FBackgroundImage.Assign(Value);
end;

procedure TgtDocSettings.SetMeasurementUnit(const Value: TgtUnitType);
var
  I: Integer;
begin
  for I := 0 to FEngineList.Count - 1 do
    if FMeasurementUnit = TgtCustomDocumentEngine(FEngineList[I])
      .MeasurementUnit then
      TgtCustomDocumentEngine(FEngineList[I]).MeasurementUnit := Value;
  FMeasurementUnit := Value;
  FNativeConversionFactor := CalculateNativeUnitFactor(FMeasurementUnit);
  FPage.FNativeFactor := FNativeConversionFactor;
end;

{ TgtBandItem }

constructor TgtBandItem.Create;
begin
  FDocumentItems := TList.Create;
  FTextItems := TList.Create;
  FOffsetY := 0;
end;

destructor TgtBandItem.Destroy;
begin
  FDocumentItems.Clear;
  FreeAndNil(FDocumentItems);
  FreeAndNil(FTextItems);
  inherited;
end;

{ TgtPageBorder }

procedure TgtBorder.Assign(Source: TPersistent);
var
  LSettings: TgtBorder;
begin
  if Source is TgtBorder then
  begin
    LSettings := TgtBorder(Source);
    FDrawLeft := LSettings.FDrawLeft;
    FDrawRight := LSettings.FDrawRight;
    FDrawTop := LSettings.FDrawTop;
    FDrawBottom := LSettings.FDrawBottom;
    FWidth := LSettings.FWidth;
    FColor := LSettings.FColor;
    FStyle := LSettings.FStyle;
    exit;
  end;
  inherited Assign(Source);
end;

constructor TgtBorder.Create;
begin
  FColor := clBlack;
  FStyle := psSolid;
  FWidth := 1;
end;

procedure TgtBorder.SetColor(const Value: TColor);
begin
  FColor := Value;
end;

procedure TgtBorder.SetDrawBottom(const Value: Boolean);
begin
  FDrawBottom := Value;
end;

procedure TgtBorder.SetDrawLeft(const Value: Boolean);
begin
  FDrawLeft := Value;
end;

procedure TgtBorder.SetDrawRight(const Value: Boolean);
begin
  FDrawRight := Value;
end;

procedure TgtBorder.SetDrawTop(const Value: Boolean);
begin
  FDrawTop := Value;
end;

procedure TgtBorder.SetStyle(const Value: TPenStyle);
begin
  FStyle := Value;
end;

procedure TgtBorder.SetWidth(const Value: Integer);
begin
  FWidth := Value;
end;

{ TgtParaBorder }

procedure TgtParaBorder.Assign(Source: TPersistent);
begin
  if Source is TgtParaBorder then
    FSpaceFromText := TgtParaBorder(Source).FSpaceFromText;
  inherited Assign(Source);
end;

procedure TgtParaBorder.SetSpaceFromText(const Value: Integer);
begin
  FSpaceFromText := Value;
end;

{ TgtPolyShapeItem }

constructor TgtPolyShapeItem.Create;
begin
  FShapes := TList.Create;
end;

destructor TgtPolyShapeItem.Destroy;
var
  I: Integer;
begin
  for I := 0 to FShapes.Count - 1 do
    TgtShapeItem(FShapes.Items[I]).Free;
  FShapes.Free;
  inherited;
end;

procedure TgtPolyShapeItem.SetFillAlternate(const Value: Boolean);
begin
  FFillAlternate := Value;
end;

{ TgtPolyPolygonItem }

constructor TgtPolyPolygonItem.Create();
begin
  FBrush := TBrush.Create;
  FPen := TPen.Create;
end;

destructor TgtPolyPolygonItem.Destroy;
begin
  FreeAndNil(FPen);
  if FBrush <> nil then
    FreeAndNil(FBrush);
  Finalize(FNoPoints);
{$IFNDEF gtDelphi2005Up}
  FreeMem(FNoPoints);
{$ENDIF}
  Finalize(FPoints);
{$IFNDEF gtDelphi2005Up}
  FreeMem(FPoints);
{$ENDIF}
  inherited;
end;

procedure TgtPolyPolygonItem.SetPen(Value: TPen);
begin
  FPen.Assign(Value);
end;

procedure TgtPolyPolygonItem.SetBrush(Value: TBrush);
begin
  FBrush.Assign(Value);
end;

procedure TgtPolyPolygonItem.SetFillAlternate(const Value: Boolean);
begin
  FFillAlternate := Value;
end;

procedure TgtPolyPolygonItem.SetNoPoints();
begin
  SetLength(FNoPoints, NoPoly + 1);
end;

procedure TgtPolyPolygonItem.SetPoints();
begin
  SetLength(FPoints, FNoPoints[0]);
end;

function TgtPolyPolygonItem.GetPoints(Position: Integer): TgtPoint;
begin
  if Position < FNoPoly then
  begin
    Result := FPoints[Position];
  end;
end;

{ TgtTextEffects }

procedure TgtTextEffects.Assign(Source: TPersistent);
var
  LTextEffects: TgtTextEffects;
begin
  if Source is TgtTextEffects then
  begin
    LTextEffects := TgtTextEffects(Source);
    FTextRenderMode := LTextEffects.FTextRenderMode;
    FTextRise := LTextEffects.FTextRise;
    exit;
  end;
  inherited Assign(Source);
end;

constructor TgtTextEffects.Create;
begin
  FTextRenderMode := trmFill;
  FTextRise := trNormal;
end;

destructor TgtTextEffects.Destroy;
begin

  inherited;
end;

procedure TgtTextEffects.SetTextRenderMode(const Value: TgtTextRenderMode);
begin
  FTextRenderMode := Value;
end;

procedure TgtTextEffects.SetTextRise(const Value: TgtTextRise);
begin
  FTextRise := Value;
end;

{ TgtImageStream }

constructor TgtImageStream.Create;
begin
  inherited;
  FStream := TMemoryStream.Create;
end;

constructor TgtImageStream.Create(AImageRect: TgtRect);
begin
  inherited;
  FStream := TMemoryStream.Create;
end;

destructor TgtImageStream.Destroy;
begin
  FStream.Free;
  inherited;
end;

{ TgtPolyDrawItem }

constructor TgtPolyDrawItem.Create;
begin
  FBrush := TBrush.Create;
  FPen := TPen.Create;
end;

destructor TgtPolyDrawItem.Destroy;
begin
  FreeAndNil(FPen);
  if FBrush <> nil then
    FreeAndNil(FBrush);
  Finalize(FOperations);
{$IFNDEF gtDelphi2005Up}
  FreeMem(FOperations);
{$ENDIF}
  Finalize(FPoints);
{$IFNDEF gtDelphi2005Up}
  FreeMem(FPoints);
{$ENDIF}
  inherited;
end;

procedure TgtPolyDrawItem.SetBrush(Value: TBrush);
begin
  FBrush.Assign(Value);
end;

procedure TgtPolyDrawItem.SetPen(Value: TPen);
begin
  FPen.Assign(Value);
end;

procedure TgtPolyDrawItem.SetPoints;
begin
  SetLength(FOperations, FNoPoints);
  SetLength(FPoints, FNoPoints);
end;

{ TgtTransformationItem }

// constructor TgtTransformationItem.Create;
// begin
// with FTranformation do
// begin
// eM11 := 1;
// eM12 := 0;
// eM21 := 0;
// eM22 := 1;
// eDx := 0;
// eDy := 0;
// end;
// end;
//
// destructor TgtTransformationItem.Destroy;
// begin
// inherited;
// end;
//
// procedure TgtTransformationItem.SetTransformation(Value: TXForm);
// begin
// with FTranformation do
// begin
// eM11 := Value.eM11;
// eM12 := Value.eM12;
// eM21 := Value.eM21;
// eM22 := Value.eM22;
// eDx := Value.eDx;
// eDy := Value.eDy;
// end;
// end;

{ TgtHashValue }

constructor TgtHashValue.Create;
begin

end;

{ TgtHashValueList }

// function TgtHashValueList.GetItem(Index: Integer): TgtHashValue;
// begin
// Result := TgtHashValue( inherited Items[Index]);
// end;

destructor TgtHashValue.Destroy;
begin
  inherited;
end;

end.
