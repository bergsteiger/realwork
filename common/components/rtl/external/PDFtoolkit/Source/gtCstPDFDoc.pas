{ ********************************************************************* }
{                                                                       }
{                       Gnostice PDFtoolkit v3.0                        }
{                       Copyright (c) 2002-2009                         }
{          Gnostice Information Technologies Private Limited            }
{                       http://www.gnostice.com                         }
{                                                                       }
{ ********************************************************************* }

{$I gtDefines.inc}
{$I gtPTKDefines.inc}

unit gtCstPDFDoc;

interface

uses
{$IFDEF COPYPROTECT}
  EXECryptor, gtTypes,
{$ENDIF}
  Classes, SysUtils, Windows, Graphics, gtPDFClasses, gtPDFUtils, gtCrypt,
  gtPDFResStrs, gtPDFConsts, ShellAPI, Forms, Dialogs, Controls, JPEG, Contnrs,
  PDDocument, PDTypes, PDDocInfo, PDImage, PDBookmark, PDDestination, PDAction,
  PDURIAction, PDGoToRemoteAction, PDGoToAction, PDRect, PDLaunchAction,
  PDJavaScriptAction, PDViewerPreference
{$IFDEF EMailWithFastNet}
  , Psock, NMsmtp
{$ENDIF}
{$IFDEF EMailWithIndy}
  , IdComponent, IdTCPConnection, IdTCPClient, IdMessageClient, IdSMTP,
  IdBaseComponent, IdMessage
{$IFDEF Indy1000Up}
  , IdAttachmentfile
{$ENDIF}
{$ENDIF}
{$IFDEF WebAppServices}
  , HTTPApp,
{$ENDIF}
  ;

const
  CM_PDFtoolkit = $BF32;
  CM_PDFDocumentChanged = CM_PDFtoolkit + 0;
  CM_PDFDocumentDestroying = CM_PDFtoolkit + 1;

type

  TArray = array of AnsiString;

  //Forward Declarations
  TgtCustomPDFDocument = class;
  TgtEMailInfo = class;

  //records
  TgtPageSize = record
    Width: Double;
    Height: Double;
  end;

  //enums
  TgtNeedAppearanceState = (naEnable, naDisable, naNoChange);
  TgtMeasurementUnit = (muPixels, muPoints, muInches, muMM, muTwips);
  TgtRotationAngle = (ra0, raCW90, raCW180, raCW270,
    raACW90, raACW180, raACW270);
  TgtMergeOptionsType = (moIncludeOutlines, moIncludeFormFields,
    moRenameLikeNameFields);
  TgtMergeOptions = set of TgtMergeOptionsType;
  TgtOperation = (opMerge, opAppend, opInsert, opExtract, opDelete);
  TgtPDFVersion = (pvPDF10, pvPDF11, pvPDF12, pvPDF13, pvPDF14,
    pvPDF15, pvPDF16, pvPDF17);
  TgtPageMode = (pmNone, pmUseOutlines, pmUseThumbs, pmFullScreen,
    pmUseAttachments, pmUseOC);
  TgtPageLayout = (plNone, plSinglePage, plOneColumn, plTwoColumnLeft,
    plTwoColumnRight, plTwoPageLeft, plTwoPageRight);
  TgtPDFFormFieldType = (ftText, ftCheckBox, ftRadio, ftButton, ftSignature,
    ftChoice);
  TgtPDFDestinationType = (dtXYZ, dtFit, dtFitH, dtFitV, dtFitR, dtFitB,
    dtFitBH, dtFitBV);
  TgtTransitionEffect = (teNone, teSplitHorizontalInward,
    teSplitHorizontalOutward, teSplitVerticalInward,
    teSplitVerticalOutward, teBlindsHorizontal,
    teBlindsVertical, teBoxInward, teBoxOutward,
    teWipeLeftToRight, teWipeBottomToTop,
    teWipeRightToLeft, teWipeTopToBottom, teDissolve,
    teGlitterLeftToRight, teGlitterTopToBottom,
    teGlitterTopLeftToBottomRight);
  TgtPDFFieldJustification = (fjLeftJustified, fjCentered, fjRightJustified);
  TgtImageFormat = (ifDefault, ifBMP, ifJPEG);

    // The render mode for text watermark.
  TgtRenderMode = (rmFill, rmStroke, rmFillStroke);

    //The Writing mode for text writing in water Mark.
  TgtWrtMode = (wmHorizontal, wmVertical);

  TgtHorizontalPosition = (hpLeft, hpCenter, hpRight, hpCustom);

  TgtVerticalPosition = (vpTop, vpMiddle, vpBottom, vpCustom);

   // PDF Font Encoding Types.
  TgtFontEmbedding = (tfeNone, tfeFull, tfeSubset);

  TgtFontEncoding = (feWinAnsiEncoding, feMacRomanEncoding,
    feMacExpertEncoding, feStandardEncoding, fePDFDocEncoding);

   // The information abt Compression.
  TgtCompressionFilter = (cfFlate, cfRunLength);

  TgtCompressionLevel = (clNone, clFastest, clDefault, clMax);
  //Arrays
  TgtPageNumbers = array of Integer;

  TgtLaunchActionType = (atOpen, atPrint);

  //Events
  // Indicates the progress of merging a list of documents
  TgtOperationProgressEvent = procedure(Sender: TgtCustomPDFDocument;
    CurrentOperation: TgtOperation; const CurrentCount: Integer;
    const TotalCount: Integer) of object;

  // Indicates the progress of reading or saving the document
  TgtProgressEvent = procedure(Sender: TgtCustomPDFDocument;
    const Percentage: Integer) of object;

  // Provides status messages of activities taking places.
  TgtStatusMessageEvent = procedure(Sender: TgtCustomPDFDocument;
    const StatMsg: string) of object;

  // Provides any warning related to the PDF document
  TgtWarningEvent = procedure(Sender: TgtCustomPDFDocument;
    const Warning: string) of object;

  // Takes in the password for encrypted documents
  TgtPasswordEvent = procedure(Sender: TObject;
    var Password: string; var Continue: Boolean; const Tries: Integer) of object;

  TgtOnRenameFieldEvent = procedure(Sender: TgtCustomPDFDocument;
    const OldFieldName: string; var NewFieldName: string;
    const PageNumber: Integer; var Rename: Boolean) of object;

  TgtOnCalcVariablesEvent = procedure(Sender: TgtCustomPDFDocument;
    const Variable: WideString; var Value: WideString; PageNo: Integer) of object;

  TgtEMailEvent = procedure(Sender: TgtCustomPDFDocument; EMailInfo:
    TgtEMailInfo; var Continue, CancelEmail: Boolean) of object;

  TgtEMailErrorEvent = procedure(Sender: TgtCustomPDFDocument;
    const ErrMsg: string) of object;

  { Exceptions }

//  EPDFException = class(Exception);
  EProFeatureError = class(EPDFException);
  ECrossReferenceError = class(EPDFException);
  EPDFFileCorruptedError = class(EPDFException);
  EUnexpectedObjectError = class(EPDFException);
  EUnexpectedDestType = class(EPDFException);
  EOutlineError = class(EPDFException);
  EAcroFormError = class(EPDFException);
  EPasswordError = class(EPDFException);
  EInvalidFieldValue = class(EAcroFormError);
  EFormFieldReadOnly = class(EAcroFormError);
  ENoAcroFields = class(EAcroFormError);
  EInvalidPageError = class(EPDFException);
  EUnsupportedImageError = class(EPDFException);
  EFieldNotFound = class(EAcroFormError);
  EUnsupportedFontError = class(EPDFException);
  EInvalidBinNameError = class(EPDFException);
  EInvalidBinIndexError = class(EPDFException);
  EUnsupportedDuplexError = class(EPDFException);
  EInvalidXResolutionError = class(EPDFException);
  EInvalidYResolutionError = class(EPDFException);
  EUnsupportedColorError = class(EPDFException);
  EUnsupportedLandScapeError = class(EPDFException);
  EImproperPNGAlgorithm = class(Exception);
  EFileNotFound = class(Exception);
  EFileOpenError = class(Exception);

{$IFNDEF gtRegistered}
  ETrialPeriodElapsed = class(Exception);
{$ENDIF}

  TgtPDFViewerPreferences = class(TPersistent)
  private
    FPDFViewerPref: TgtPDViewerPref;

    function GetCenterWindow: Boolean;
    function GetDisplayDocTitle: Boolean;
    function GetFitWindow: Boolean;
    function GetHideMenubar: Boolean;
    function GetHideToolbar: Boolean;
    function GetHideWindowUI: Boolean;

    procedure SetCenterWindow(const Value: Boolean);
    procedure SetDisplayDocTitle(const Value: Boolean);
    procedure SetFitWindow(const Value: Boolean);
    procedure SetHideMenubar(const Value: Boolean);
    procedure SetHideToolbar(const Value: Boolean);
    procedure SetHideWindowUI(const Value: Boolean);
  public
    constructor Create; overload;
    constructor Create(Doc: TgtPDDocument); overload;
    destructor Destroy; override;
    function Clone: TgtPDFViewerPreferences;

    property HideToolbar: Boolean read GetHideToolbar write SetHideToolbar;
    property HideMenubar: Boolean read GetHideMenubar write SetHideMenubar;
    property HideWindowUI: Boolean read GetHideWindowUI write SetHideWindowUI;
    property FitWindow: Boolean read GetFitWindow write SetFitWindow;
    property CenterWindow: Boolean read GetCenterWindow write SetCenterWindow;
    property DisplayDocTitle: Boolean read GetDisplayDocTitle
      write SetDisplayDocTitle;
  end;

  TgtPDFAction = class(TObject)
  protected
    FAction: TgtPDAction;
    constructor Create(AObject: TgtPDAction);
  end;

{ TgtURIAction Class}

  TgtPDFURIAction = class(TgtPDFAction)
  private
    procedure SetURI(const Value: string);
    function GetURI: string;
  public
    constructor Create;
    destructor Destroy; override;
    property URI: string read GetURI write SetURI;
  end;

{ Class for GoTo Action}

  TgtPDFGoToAction = class(TgtPDFAction)
  private
    FPageNo: Integer;
    function GetZoom: Double;
    procedure SetZoom(const Value: Double);
    function GetBottom: Double;
    function GetLeft: Double;
    function GetPageNo: Integer; virtual;
    function GetRight: Double;
    function GetTop: Double;
    procedure SetBottom(const Value: Double);
    procedure SetLeft(const Value: Double);
    procedure SetPageNo(const Value: Integer); virtual;
    procedure SetRight(const Value: Double);
    procedure SetTop(const Value: Double);
    function GetDestinationType: TgtPDFDestinationType;
    procedure SetDestinationType(const Value: TgtPDFDestinationType);  ///////////
  public
    constructor Create; overload;
    constructor Create(APageNo: Integer; ADestinationType: TgtPDFDestinationType;
      ALeft, ATop, AZoom: Double); overload;
    constructor Create(APageNo: Integer; ADestinationType: TgtPDFDestinationType);
      overload;
    constructor Create(APageNo: Integer; ADestinationType: TgtPDFDestinationType;
      ATopOrLeft: Double); overload;
    constructor Create(APageNo: Integer; ADestinationType: TgtPDFDestinationType;
      ALeft, ABottom, ARight, ATop: Double); overload;
    destructor Destroy; override;
    property PageNo: Integer read GetPageNo write SetPageNo;
    property DestinationType: TgtPDFDestinationType read GetDestinationType
      write SetDestinationType;

    property Left: Double read GetLeft write SetLeft;
    property Bottom: Double read GetBottom write SetBottom;
    property Right: Double read GetRight write SetRight;
    property Top: Double read GetTop write SetTop;
    property Zoom: Double read GetZoom write SetZoom;
  end;

{TgtPDFGoToRAction class }

  TgtPDFGoToRAction = class(TgtPDFGoToAction)
  private
    FPageNo: Integer;
    function GetFileName: string;
    function GetOpenInNewWindow: boolean;
    procedure SetFileName(const Value: string);
    procedure SetOpenInNewWindow(const Value: boolean);
    function GetPageNo: Integer; override;
    procedure SetPageNo(const Value: Integer); override;
  public
    constructor Create; overload;
    constructor Create(APageNo: Integer; ADestinationType: TgtPDFDestinationType;
      ALeft, ATop, AZoom: Double); overload;
    constructor Create(APageNo: Integer; ADestinationType: TgtPDFDestinationType);
      overload;
    constructor Create(APageNo: Integer; ADestinationType: TgtPDFDestinationType;
      ATopOrLeft: Double); overload;
    constructor Create(APageNo: Integer; ADestinationType: TgtPDFDestinationType;
      ALeft, ABottom, ARight, ATop: Double); overload;
    destructor Destroy; override;
    property FileName: string read GetFileName write SetFileName;
    property OpenInNewWindow: Boolean read GetOpenInNewWindow write SetOpenInNewWindow;
  end;

{TgtPDFLaunchAction class}

  TgtPDFLaunchAction = class(TgtPDFAction)
  private
    function GetApplicationToLaunch: string;
    function GetLaunchActionType: TgtLaunchActionType;
    function GetOpenInNewWindow: Boolean;
    function GetParameterToApplication: string;
    procedure SetApplicationToLaunch(const Value: string);
    procedure SetLaunchActionType(const Value: TgtLaunchActionType);
    procedure SetOpenInNewWindow(const Value: Boolean);
    procedure SetParameterToApplication(const Value: string); // the /O entry
  public
    constructor Create;
    destructor Destroy; override;
    property ApplicationToLaunch: string read GetApplicationToLaunch
      write SetApplicationToLaunch;
    property OpenInNewWindow: Boolean read GetOpenInNewWindow
      write SetOpenInNewWindow;
    property ParameterToApplication: string read GetParameterToApplication
      write SetParameterToApplication;
    property LaunchActionType: TgtLaunchActionType read GetLaunchActionType
      write SetLaunchActionType;
  end;

{ TgtPDFJavaScriptAction Class }

  TgtPDFJavaScriptAction = class(TgtPDFAction)
  private
    function GetJavaScript: string;
    procedure SetJavaScript(const Value: string);
  public
    constructor Create;
    destructor Destroy; override;
    property JavaScript: string read GetJavaScript write SetJavaScript;
  end;


  TgtPDFDestination = class(TObject)
  private
    procedure SetDestination(const Value: TgtPDDestination);
  protected
    FDestination: TgtPDDestination;
    property Destination: TgtPDDestination read FDestination write SetDestination;
  private
    FRect: TgtPDRect;
    FPageNo: Integer;
    FToFree: Boolean;

    function GetBottom: Double;
    function GetDestinationType: TgtPDFDestinationType;
    function GetLeft: Double;
    function GetPageNo: Integer;
    function GetRight: Double;
    function GetTop: Double;
    function GetZoom: Double;
    procedure SetBottom(const Value: Double);
    procedure SetDestinationType(const Value: TgtPDFDestinationType);
    procedure SetLeft(const Value: Double);
    procedure SetPageNo(const Value: Integer);
    procedure SetRight(const Value: Double);
    procedure SetTop(const Value: Double);
    procedure SetZoom(const Value: Double);
  published
  public
    constructor Create; overload;
    constructor Create(PageNo: Integer; DestinationType: TgtPDFDestinationType;
      Left, Top, Zoom: Double); overload;
    constructor Create(PageNo: Integer; DestinationType: TgtPDFDestinationType);
      overload;
    constructor Create(PageNo: Integer; DestinationType: TgtPDFDestinationType;
      TopOrLeft: Double); overload;
    constructor Create(PageNo: Integer; DestinationType: TgtPDFDestinationType;
      Left, Bottom, Right, Top: Double); overload;
    destructor Destroy; override;

    property PageNo: Integer read GetPageNo write SetPageNo;
    property DestinationType: TgtPDFDestinationType
      read GetDestinationType write SetDestinationType;
    property Left: Double read GetLeft write SetLeft;
    property Bottom: Double read GetBottom write SetBottom;
    property Right: Double read GetRight write SetRight;
    property Top: Double read GetTop write SetTop;
    property Zoom: Double read GetZoom write SetZoom;
  end;

  TgtBookmarkAttribute = class(Tobject)
  private
    FFontStyles: TFontStyles;
    FOutlineColor: TColor;
  public
    constructor Create; overload;
    constructor Create(AFontStyle: TFontStyles; AOutlinecolor: TColor);  overload;

    property FontStyles: TFontStyles read FFontStyles write FFontStyles;
    property OutlineColor: TColor read FoutlineColor write FoutlineColor;
  end;

  TgtOutlineList = class;

  TgtBookmarkTraversalType = (bttDepthFirst);
                                {preorder, levelorder}
  TgtBookmarkTraversalDepth = (btdSiblingsOnly, btdChildrenOnly, btdFullSubTree);


  TgtPDFOutline = class(TPersistent)
  private
    FPDBookmark: TgtPDBookmark;
    FBookmarkList: TgtOutlineList;
    FParent: TgtPDFOutline;
    FParentDoc: TgtCustomPDFDocument;
    FDestination: TgtPDFDestination;
    FOutlineAction: TgtPDFAction;
    FTitleFound: Boolean;
    function GetAction: TgtPDFAction;
    function GetChild: TgtPDFOutline;
    function GetDestination: TgtPDFDestination;
    function GetNext: TgtPDFOutline;
    function GetParent: TgtPDFOutline;
    function GetPrev: TgtPDFOutline;
    function GetTitle: AnsiString;
    constructor Create(AParentDoc: TgtCustomPDFDocument; AParent:TgtPDFOutLine);
    function GetBookmarkIndex: Integer;
    function GetLevel: Integer;
    function GetLastChild: TgtPDFoutline;
    procedure GetBookmarkProperties(Attribute: TgtBookmarkAttribute;
      var AOutlineFlag: TgtPDOutlineFlag; var AColor:TgtPDColorValue);
    function TraverseDepthFirst(ABookmark: TgtPDFOutline; const ATitle: Ansistring;
      ADepth: TgtBookmarkTraversalDepth): TgtPDFOutline;
  published
  public
    destructor Destroy; override;
    function GetFirstChild: TgtPDFOutline;{$IFDEF gtDelphi6Up} deprecated; {$ENDIF}
    function GetNextNode: TgtPDFOutline;{$IFDEF gtDelphi6Up} deprecated; {$ENDIF}
    function GetPrevNode: TgtPDFOutline;{$IFDEF gtDelphi6Up} deprecated; {$ENDIF}

    function AppendChild(Title: WideString; ADestination: TgtPDFDestination;
      OutLineAttribute: TgtBookmarkAttribute): TgtPDFOutline; overload;
      {$IFDEF gtDelphi6Up} deprecated; {$ENDIF}
    function AppendChild(Title: WideString; Action: TgtPDFAction;
      OutLineAttribute: TgtBookmarkAttribute): TgtPDFOutline; overload;
      {$IFDEF gtDelphi6Up} deprecated; {$ENDIF}

    function AddChild(Title: WideString; ADestination: TgtPDFDestination;
      OutLineAttribute: TgtBookmarkAttribute): TgtPDFOutline; overload;
    function AddChild(Title: WideString; Action: TgtPDFAction;
      OutLineAttribute: TgtBookmarkAttribute): TgtPDFOutline; overload;

    function AddNext(Title: WideString; ADestination: TgtPDFDestination;
      OutLineAttribute: TgtBookmarkAttribute): TgtPDFOutline; overload;
    function AddNext(Title: WideString; Action: TgtPDFAction; OutLineAttribute:
      TgtBookmarkAttribute): TgtPDFOutline; overload;

    function AddPrev(Title: WideString; ADestination: TgtPDFDestination;
      OutLineAttribute: TgtBookmarkAttribute): TgtPDFOutline; overload;
    function AddPrev(Title: WideString; Action: TgtPDFAction; OutLineAttribute:
      TgtBookmarkAttribute): TgtPDFOutline; overload;

    procedure Modify(Title: WideString; ADestination: TgtPDFDestination;
      OutLineAttribute: TgtBookmarkAttribute); overload;
    procedure Modify(Title: WideString; Action: TgtPDFAction; OutLineAttribute:
      TgtBookmarkAttribute); overload;

    procedure ModifyNext(Title: WideString; ADestination: TgtPDFDestination;
      OutLineAttribute: TgtBookmarkAttribute); overload;
    procedure ModifyNext(Title: WideString; Action: TgtPDFAction;
      OutLineAttribute: TgtBookmarkAttribute); overload;

    procedure ModifyPrev(Title: WideString; ADestination: TgtPDFDestination;
      OutLineAttribute: TgtBookmarkAttribute); overload;
    procedure ModifyPrev(Title: WideString; Action: TgtPDFAction;
      OutLineAttribute: TgtBookmarkAttribute); overload;

    procedure DeleteChild;
    procedure DeletePrev;
    procedure DeleteNext;

    function GetByTitle(ATitle: AnsiString;
      ATraversalType: TgtBookmarkTraversalType;
      AMaxDepth: TgtBookmarkTraversalDepth): TgtPDFOutline;

    property Parent: TgtPDFOutline read GetParent;
    property Child: TgtPDFOutline read GetChild;
    property LastChild: TgtPDFOutline read GetLastChild;
    property Prev: TgtPDFOutline read GetPrev;
    property Next: TgtPDFOutline read GetNext;
    property Title: AnsiString read GetTitle;
    property Destination: TgtPDFDestination read GetDestination;
    property Action: TgtPDFAction read GetAction;
    property BookmarkIndex: Integer read GetBookmarkIndex;
    property Level: Integer read GetLevel;
  end;

  TgtOutlineList = class(TList)
    function Get(Index: Integer): TgtPDFOutline;
  public
    procedure Notify(Ptr: Pointer; Action: TListNotification); override;
    property Items[Index: Integer]: TgtPDFOutline read Get;
  end;

  //Classes
  TgtEMailInfo = class(TPersistent)
  private
    FHost: string;
    FUserID: string;
    FPassword: string;
    FAttachments: TStringList;
    FBody: TStringList;
    FDate: TDateTime;
    FFromAddress: string;
    FFromName: string;
    FReplyTo: string;
    FSubject: string;
    FRecipientList: TStringList;
    FCCList: TStringList;
    FBCCList: TStringList;
    FAuthenticationRequired: Boolean;
    FPort: Integer;
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Host: string read FHost write FHost;
    property UserID: string read FUserID write FUserID;
    property Password: string read FPassword write FPassword;
    property Attachments: TStringList read FAttachments write FAttachments;
    property Body: TStringList read FBody write FBody;
    property Date: TDateTime read FDate write FDate;
    property FromAddress: string read FFromAddress write FFromAddress;
    property FromName: string read FFromName write FFromName;
    property ReplyTo: string read FReplyTo write FReplyTo;
    property Subject: string read FSubject write FSubject;
    property RecipientList: TStringList read FRecipientList write FRecipientList;
    property CCList: TStringList read FCCList write FCCList;
    property BCCList: TStringList read FBCCList write FBCCList;
    property AuthenticationRequired: Boolean read FAuthenticationRequired
      write FAuthenticationRequired default False;
    property Port: Integer read FPort write FPort default 25;
  end;


{ TgtPDFInfo }

  TgtPDFInfo = class(TPersistent)
  private
    FPDInfo: TgtPDDocInfo;

    function GetAuthor: WideString;
    function GetCreationDate: string;
    function GetCreator: WideString;
    function GetModDate: string;
    function GetProducer: WideString;
    function GetSubject: WideString;
    function GetTitle: WideString;
    function GetKeywords: WideString;

    procedure SetAuthor(const Value: WideString);
    procedure SetCreationDate(const Value: string);
    procedure SetCreator(const Value: WideString);
    procedure SetModDate(const Value: string);
    procedure SetSubject(const Value: WideString);
    procedure SetTitle(const Value: WideString);
    procedure SetKeywords(const Value: WideString);
    function GetXMLMetaData: string;
  published
    property Title: WideString read GetTitle write SetTitle;
    property Author: WideString read GetAuthor write SetAuthor;
    property Subject: WideString read GetSubject write SetSubject;
    property Keywords: WideString read GetKeywords write SetKeywords;
    property Creator: WideString read GetCreator write SetCreator;
    property Producer: WideString read GetProducer;
    property CreationDate: string read GetCreationDate write SetCreationDate;
    property ModDate: string read GetModDate write SetModDate;
  end;

  TgtWatermarkTemplate = class(TObject)
  private
    FName: string;
  public
    constructor Create;
    property Name: string read FName write FName;
  end;

  TgtCustomWatermarkTemplate = class(TgtWatermarkTemplate)
  private
    FAngle: Integer;
    FOverlay: Boolean;
    FX: Double;
    FY: Double;
    FHorizPos: TgtHorizontalPosition;
    FVertPos: TgtVerticalPosition;
    procedure GetXY(APageWidth, APageHeight: Double; var AXPos,
      AYPos: Double; AWidth, AHeight: Double; AMeasurementUnit: TgtMeasurementUnit);

  public
    constructor Create;
    property Angle: Integer read FAngle write FAngle;
    property Overlay: Boolean read FOverlay write FOverlay;
    property X: Double read FX write FX;
    property Y: Double read FY write FY;
    property HorizPos: TgtHorizontalPosition read FHorizPos write FHorizPos;
    property VertPos: TgtVerticalPosition read FVertPos write FVertPos;
  end;

  TgtTextWatermarkTemplate = class(TgtCustomWatermarkTemplate)
  private
    FText: WideString;
    FFont: TFont;
    FFontEncoding: TgtFontEncoding;
    FEmbedTrueTypeFonts: TgtFontEmbedding;
    FStrokeColor: TColor;
    FRenderMode: TgtRenderMode;
    FWritingMode: TgtWrtMode;
    FStrokeOpacity: Integer;

    procedure SetFont(const aFont: TFont);
  public
    constructor Create;
    destructor Destroy; override;
    property Text: WideString read FText write FText;
    property Font: TFont read FFont write SetFont;
    property FontEncoding: TgtFontEncoding read FFontEncoding write FFontEncoding;
    property EmbedTrueTypeFonts: TgtFontEmbedding read FEmbedTrueTypeFonts write FEmbedTrueTypeFonts;
    property StrokeColor: TColor read FStrokeColor write FStrokeColor;
    property RenderMode: TgtRenderMode read FRenderMode write FRenderMode;
    property WritingMode: TgtWrtMode read FWritingMode write FWritingMode;
    property OpacityStroke: Integer read FStrokeOpacity write FStrokeOpacity;
  end;

  TgtShapeWatermark = class(TgtWatermarkTemplate)
  private
    FStrokeColor: TColor;
    FPenWidth: Double;
    FStrokeOpacity: Integer;
  public
    constructor Create;
    property StrokeColor: TColor read FStrokeColor write FStrokeColor;
    property PenWidth: Double read FPenWidth write FPenWidth;
    property OpacityStroke: Integer read FStrokeOpacity write FStrokeOpacity;
  end;

  TgtOpenShapeWatermark = class(TgtShapeWatermark)
  private
    FInitialPoint: TgtPoint;
    FEndPoint: TgtPoint;
  public
    constructor Create;
    destructor Destroy; override;
    property InitialPoint: TgtPoint read FInitialPoint write FInitialPoint;
    property EndPoint: TgtPoint read FEndPoint write FEndPoint;
  end;

  { TgtLineWatermarkTemplate}
  TgtLineWatermarkTemplate = class(TgtOpenShapeWatermark);

  TgtClosedShapeWatermark = class(TgtShapeWatermark)
  private
    FFillcolor: TColor;
    FFillOpacity: Integer;
  public
    constructor Create;
    property Fillcolor: TColor read FFillcolor write FFillcolor;
    property OpacityFill: Integer read FFillOpacity write FFillOpacity;
  end;

  TgtRectangleWatermarkTemplate = class(TgtClosedShapeWatermark)
  private
    FInitialPoint: TgtPoint;
    FEndPoint: TgtPoint;
  public
    constructor Create;
    destructor Destroy; override;
    property InitialPoint: TgtPoint read FInitialPoint write FInitialPoint;
    property EndPoint: TgtPoint read FEndPoint write FEndPoint;
  end;

  TgtCircleWaterMarkTemplate = class(TgtClosedShapeWatermark)
  private
    FRadius: Double;
    FCenter: TgtPoint;
  public
    constructor Create;
    destructor Destroy; override;
    property Radius: Double read FRadius write FRadius;
    property Center: TgtPoint read FCenter write FCenter;
  end;

  TgtEllipseWaterMarkTemplate = class(TgtClosedShapeWatermark)
  private
    FCenter: TgtPoint;
    FMajorRadius: Double;
    FMinorRadius: Double;
  public
    constructor Create;
    destructor destroy; override;
    property Center: TgtPoint read FCenter write FCenter;
    property MajorRadius: Double read FMajorRadius write FMajorRadius;
    property MinorRadius: Double read FMinorRadius write FMinorRadius;

  end;

  TgtPolygonWatermark = class(TgtClosedShapeWatermark)
  private
    FCenter: TgtPoint;
    FNoOfSides: Integer;
    FSideLength: Double;
  public
    constructor Create;
    destructor destroy; override;
    property Center: TgtPoint read FCenter write FCenter;
    property NoOfSides: Integer read FNoOfSides write FNoOfSides;
    property SideLength: Double read FSideLength write FSideLength;
  end;

  TgtCurveWaterMarkTemplate = class(TgtOpenShapeWatermark)
  private
    FFirstControlPoint: TgtPoint;
    FSecondControlPoint: TgtPoint;
  public
    constructor Create;
    destructor destroy; override;
    property FirstControlPoint: TgtPoint read FFirstControlPoint write FFirstControlPoint;
    property SecondControlPoint: TgtPoint read FSecondControlPoint write FSecondControlPoint;
  end;

  TgtImageWatermarkTemplate = class(TgtCustomWatermarkTemplate)
  private
    FWidth: Double;
    FHeight: Double;
    FFillOpacity: Integer;
    FImage: TGraphic;
    FImageFormat: TgtOutFormat;
    FInLine: Boolean;
    function GetImage: TGraphic;
    procedure SetImage(AGraphic: TGraphic);
  public
    constructor Create;
    destructor Destroy; override;
    property Image: TGraphic read GetImage write SetImage;
    property Width: Double read FWidth write FWidth;
    property Height: Double read FHeight write FHeight;
    property OpacityFill: Integer read FFillOpacity write FFillOpacity;
    property ImageFormat: TgtOutFormat read FImageFormat write FImageFormat;
  end;

  TgtCompositeWatermarkTemplate = class(TgtWatermarkTemplate)
  private
    FWatermarkTemplates: TList;
    function GetWatermarkAt(AIndex: Integer): TgtWatermarkTemplate;
    procedure SetWatermarkAt(AIndex: Integer; AValue: TgtWatermarkTemplate);
    function GetCount: Integer;
  public
    constructor Create;
    destructor Destroy; override;
    function AddWatermark(AWatermarkTemplate: TgtWatermarkTemplate): Integer;
    property WatermarkAt[Index: Integer]: TgtWatermarkTemplate read GetWatermarkAt
      write SetWatermarkAt; default;
    property Count: Integer read GetCount;
  end;

  { TgtBaseDlg }

  TgtBaseDlg = class(TForm)
  private
    FPDFDoc: TgtCustomPDFDocument;
    procedure SetPDFDoc(const Value: TgtCustomPDFDocument);
  public
    constructor Create(AOwner: TComponent); override;
    property PDFDoc: TgtCustomPDFDocument read FPDFDoc write SetPDFDoc;
  end;

  TgtCustomPDFDocument = class(TgtPDFBaseComponent)
  private
    FAbout: string;
    FVersion: string;
    FPDFInfo: TgtPDFInfo;
    FViewerPref: TgtPDFViewerPreferences;
    FOpenAfterSave: Boolean;
    FMergeOptions: TgtMergeOptions;
    FMeasurementUnit: TgtMeasurementUnit;
    FFilename, FWorkFilename: string;
    FIsEncrypted: Boolean;
    FIsLoaded: Boolean;
    FFileSize: Int64;
    FEncryption: TgtPDFEncryptionSettings;
    FEmailInfo: TgtEmailInfo;
    FEmailAfterSave: Boolean;
    FFormFieldCount: Integer;
    FSetupDialog: TgtBaseDlg;
    FShowSetupDialog: Boolean;
    FPermissions: TgtPDPermissions;
////    FCalculateVariables: Boolean;
    FOutlines: TgtPDFOutline;
    //Events
    FOnOperationProgress: TgtOperationProgressEvent;
    FOnStatusMessage: TgtStatusMessageEvent;
    FOnIOProgress: TgtProgressEvent;
    FOnWarning: TgtWarningEvent;
    FOnCalcVariables: TgtOnCalcVariablesEvent;
    FOnRenameField: TgtOnRenameFieldEvent;
    FOnPassword: TgtPasswordEvent;
    FOnBeginRead: TNotifyEvent;
    FOnEndRead: TNotifyEvent;
    FPassword: string;
    FTries: Integer;
    FContinue: Boolean;
    FMergeObjectList, FAppendPagesObjList: TObjectList;
    FInsertPagesObjList: TObjectList;
    FLinkedControls: TList;
    FStream: TStream;
    FIsStreamOwned: Boolean;
    FIsSaveStreamOwned: Boolean;
    FOutputStream: TStream;
    FOutputFilename: string;
    FCMapPath: string;

{$IFDEF EMailSupport}
    FOnEMail: TgtEmailEvent;
    FOnEMailError: TgtEMailErrorEvent;
{$ENDIF}
{$IFDEF EMailWithFastNet}
    FOnEMailConnect: TNotifyEvent;
    FOnEMailConnectionFailed: TNotifyEvent;
    FOnEMailDisConnect: TNotifyEvent;
    FOnEMailInvalidHost: THandlerEvent;
    FOnEMailFailure: TNotifyEvent;
    FOnEMailSendStart: TNotifyEvent;
    FOnEMailStatus: TOnStatus;
    FOnEMailSuccess: TNotifyEvent;
{$ENDIF}
{$IFDEF EMailWithIndy}
    FOnEMailConnected: TNotifyEvent;
    FOnEMailDisConnected: TNotifyEvent;
    FOnEMailStatus: TIdStatusEvent;
    FOnEMailSuccess: TNotifyEvent;
{$ENDIF}
    procedure SetAbout(const Value: string);
    procedure SetComVersion(const Value: string);
    procedure DoDocumentChanged(AMsg: Cardinal = CM_PDFDocumentChanged);
    function GetPageCount: Integer;
    procedure SetFilename(const Value: string);
    function GetIsOwner: Boolean;
    function GetViewerPreferences: TgtPDFViewerPreferences;
    procedure SetEmailInfo(const Value: TgtEMailInfo);
    function GetDocInfo: TgtPDFInfo;
    function InvokeSetupDialog: TModalResult;
    function GetPageMode: TgtPageMode;
    procedure SetPageMode(mode: TgtPageMode);
    function GetPDFVersion: TgtPDFVersion;
    procedure SetPDFVersion(const Value: TgtPDFVersion);
    procedure SetWorkFileName(const Value: string);
    function GetPageLayout: TgtPageLayout;
    function GetCMapPath: string;
    procedure SetCMapPath(const Value: string);
    procedure SetPageLayout(const Value: TgtPageLayout);
    function ReplacePlaceHolders(AText: WideString;
      APageNo: Integer): WideString;
    function ProcessControlStrings(AText: AnsiString; out ALineStrings: TArray): Boolean;

////    procedure SetCalculateVariables(const Value: Boolean);
//    function GetIsEncrypted: Boolean;
{$IFNDEF gtRegistered}
    procedure StampTrialMark(var AWaterMark: TgtTextWatermarkTemplate);
{$ENDIF}

    procedure GetTrueTypeFontData(AFont: TFont; var AStream: TMemoryStream);
    procedure AddTextWaterMark(ATemplate: TgtTextWatermarkTemplate; APageNum: Integer);
    procedure AddLineWaterMark(ATemplate: TgtLineWatermarkTemplate; APageNum: Integer);
    procedure AddRectangleWaterMark(ATemplate: TgtRectangleWatermarkTemplate; APageNum: Integer);
    procedure AddCircleWaterMark(ATemplate: TgtCircleWaterMarkTemplate; APageNum: Integer);
    procedure AddEllipseWaterMark(ATemplate: TgtEllipseWaterMarkTemplate; APageNum: Integer);
    procedure AddPolygonWaterMark(ATemplate: TgtPolygonWatermark; APageNum: Integer);
    procedure AddCurveWaterMark(ATemplate: TgtCurveWaterMarkTemplate; APageNum: Integer);
    procedure AddImageWaterMark(ATemplate: TgtImageWatermarkTemplate; APageNum: Integer);
    procedure SaveDoc(Stream: TStream; SaveFlags: TgtPDSaveFlags);
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

//
  protected
    FPDDoc: TgtPDDocument;
//    procedure RaiseException(AErrNum: ShortInt);
    procedure Authorize(AForDocOpen: Boolean);
    procedure AddDestination(Action: TgtPDFAction);
  public
    {$IFDEF COPYPROTECT}
      function _ActivateLicense(const RegName: widestring;
        const RegKey: widestring): Boolean;
    {$ENDIF}
    //constructor
    constructor Create(AOwner: TComponent); override;
    //destructor
    destructor Destroy; override;
    // Load a document from file or stream.
    function LoadFromFile(const FileName: string): Boolean;
    function LoadFromStream(Stream: TStream): Boolean;
//
//    // Save the document to file.
    procedure SaveToFile(const FileName: string; NeedAppearance:
      TgtNeedAppearanceState); overload; {$IFDEF gtDelphi6Up} deprecated; {$ENDIF}
    procedure SaveToFile(const FileName: string; aIncremental: Boolean = False); overload;
    // Save the document to stream.
    procedure SaveToStream(Stream: TStream; aIncremental: Boolean = False); overload;
    procedure SaveToStream(Stream: TStream; NeedAppearance:
      TgtNeedAppearanceState); overload; {$IFDEF gtDelphi6Up} deprecated; {$ENDIF}
    // All controls that link to document and need to be notified when document changes
    // should call RegisterLinkedControl passing self, when a document is linked
    // to them
    procedure RegisterLinkedControl(AControl: TControl);
    // Then also should unregister themsleves when they are delinked from a document
    procedure UnRegisterLinkedControl(AControl: TControl);
//
//    //Get XML metadata as string
    function GetXMLMetadata: string;

    //Get the Mediabox of the page <PageNo>
    function GetPageMediaBox(PageNo: Integer): TgtRect; overload;
    //Get the Mediabox of <PageNo> converted to the <AMeasurementUnit>
    function GetPageMediaBox(AMeasurementUnit: TgtMeasurementUnit;
      PageNo: Integer): TgtRect; overload;
    //Get the CropBox of <PageNo> converted to <MMUnit>
    function GetPageCropBox(PageNo: Integer; MMUnit: TgtMeasurementUnit):
      TgtRect;
    //Get the Page Size of <PageNo> in <MMUnit>
    function GetPageSize(PageNo: Integer; MMUnit: TgtMeasurementUnit):
      TgtPageSize;
    // Get the Rotation Angle used in a page.
    function GetPageRotate(PageNo: Integer): Integer;

    {Form Filling Functions}
    // Obtain the name of the field, provided field no.

    function GetFormFieldName(FieldNo: Integer): string;
    {$IFDEF gtDELPHI6up}
      deprecated;
    {$ENDIF}

    // Obtain the value of the form field.
    function GetFormFieldValue(FieldNo: Integer): string; overload;
    {$IFDEF gtDELPHI6up}
        deprecated;
    {$ENDIF}

    function GetFormFieldValue(FieldName: string): string; overload;
    {$IFDEF gtDELPHI6up}
        deprecated;
    {$ENDIF}

    // Obtain the type of the form field.
    function GetFormFieldType(FieldNo: Integer): TgtPDFFormFieldType; overload;
    {$IFDEF gtDELPHI6up}
        deprecated;
    {$ENDIF}

    function GetFormFieldType(FieldName: string): TgtPDFFormFieldType; overload;
    {$IFDEF gtDELPHI6up}
        deprecated;
    {$ENDIF}

    // Obtain the form fields description
    function GetFormFieldDescription(FieldNo: Integer): string; overload;
    {$IFDEF gtDELPHI6up}
        deprecated;
    {$ENDIF}

    function GetFormFieldDescription(FieldName: string): string; overload;
    {$IFDEF gtDELPHI6up}
        deprecated;
    {$ENDIF}

    // Obtain the index of the field, given the field name.
    function GetFieldIndexOf(FieldName: string): Integer;
    // Obtain the number of modifiable form fields.
    function GetFormFieldCount: Integer;
    // Obtain the allowed values for a field.
    function GetFormFieldAllowedValues(FieldNo: Integer): TStrings; overload;
    {$IFDEF gtDELPHI6up}
        deprecated;
    {$ENDIF}
    function GetFormFieldAllowedValues(FieldName: string): TStrings; overload;
    {$IFDEF gtDELPHI6up}
        deprecated;
    {$ENDIF}

    // Obtain all the fields and values in a string list.
    function GetFormFieldValues: TStringList; //renamed -GetFormFields to GetFormFieldValues

    // Check if the field is read-only type
    function IsFormFieldReadOnly(FieldNo: Integer): Boolean; overload;
    {$IFDEF gtDELPHI6up}
        deprecated;
    {$ENDIF}

    function IsFormFieldReadOnly(FieldName: string): Boolean; overload;
    {$IFDEF gtDELPHI6up}
        deprecated;
    {$ENDIF}

    // Get the Root Bookmark Node.
    function GetBookmarkRoot: TgtPDFOutline;
//    function CreateNewBookmark(Title: WideString;
//      Destination: TgtPDFDestination; OutLineAttribute: TgtBookmarkAttribute):
//      TgtPDFOutline; overload;
//    function CreateNewBookmark(Title: WideString;
//      Action: TgtPDFAction; OutLineAttribute: TgtBookmarkAttribute):
//      TgtPDFOutline; overload;
    procedure RemoveBookmark;

{$IFDEF WebAppServices}
    procedure SaveToHTTPResponse(Response: TWebResponse);
{$ENDIF}


    // Start a new Document
    procedure Reset;
//
    // Remove a form field from document
    procedure RemoveFormField(FieldNo: Integer); overload;
    procedure RemoveFormField(FieldName: string); overload;

    // Set the value of form fields, provided the values in a StringList.
    procedure SetFormFields(Data: TStringList);

    // Set the value of a form field.
    procedure SetFormFieldValue(FieldNo: Integer; Value: WideString); overload;
    {$IFDEF gtDELPHI6up}
        deprecated;
    {$ENDIF}

    procedure SetFormFieldValue(FieldName: string; Value: WideString); overload;
    {$IFDEF gtDELPHI6up}
        deprecated;
    {$ENDIF}

    // Alter the name of the field.
    procedure RenameFormField(FieldNo: Integer; NewName: string); overload;
    {$IFDEF gtDELPHI6up}
        deprecated;
    {$ENDIF}

    procedure RenameFormField(FieldName: string; NewName: string); overload;
    {$IFDEF gtDELPHI6up}
        deprecated;
    {$ENDIF}

    //Make a form field read only.
    procedure SetFormFieldReadOnly(FieldNo: Integer; Value: Boolean); overload;
    {$IFDEF gtDELPHI6up}
        deprecated;
    {$ENDIF}

    procedure SetFormFieldReadOnly(FieldName: string; Value: Boolean); overload;
    {$IFDEF gtDELPHI6up}
        deprecated;
    {$ENDIF}

    // Extract Pages from a document.
    procedure ExtractPagesTo(Document: TgtCustomPDFDocument;
      PageRange: string); overload;
    procedure ExtractPagesTo(FileName: string; PageRange: string); overload;
    // Insert pages into a document
    procedure InsertPagesFrom(Document: TgtCustomPDFDocument; Pages: string;
      InsertAfterPage: Integer); overload;
    // Insert pages into a document
    procedure InsertPagesFrom(FileName: string; Pages: string;
      InsertAfterPage: Integer); overload;

    // Append a Document to the end of a  file
    procedure AppendPagesFrom(Document: TgtCustomPDFDocument;
      PageRange: string); overload;
     //Append a pages from a doc to the end of a  file
    procedure AppendPagesFrom(FileName: string; PageRange: string); overload;
//
    // Insert watermark into a document
    procedure InsertWatermark(Template: TgtWatermarkTemplate); overload;
    procedure InsertWatermark(Template: TgtWatermarkTemplate; PageRange:
      string); overload;
//
    // Add thumbnails to a document
    procedure AddThumbnail(Page: Integer; Image: TGraphic); overload;
    procedure AddThumbnail(Images: TList); overload;

    // Set the Page's Transition Effect.
    procedure SetPageTransitionEffect(PageRange: string; Duration: Single;
      TransitionEffect: TgtTransitionEffect);

    // Merge Documents
    procedure MergeDocs(DocList: TStrings);
//
    // Delete pages from a document
    procedure DeletePages(PageRange: string);

    // Change CropBox values for pages
    procedure SetPageCropBox(PageRange: string; CropRect: TgtRect);
    // Change MediaBox values for pages
    procedure SetPageMediaBox(PageRange: string; PageRect: TgtRect);
//
    // Compress a document
    procedure CompressDocument(CompressionType: TgtCompressionFilter;
      CompressionLevel: TgtCompressionLevel);

    procedure DecompressDocument;

     // Rotate the pages in the document. The Angle must be a multiple of 90.
    procedure RotatePages(PageRange: string; Angle: TgtRotationAngle);

    procedure MaskRect(PageNo: Integer; Rect: TRect; Color: TColor);

    // The Document Information
    property DocInfo: TgtPDFInfo read GetDocInfo;
    //Below properties to be made published
    property ViewerPreferences: TgtPDFViewerPreferences read GetViewerPreferences;
    property PDFVersion: TgtPDFVersion read GetPDFVersion write SetPDFVersion;
    property PageCount: Integer read GetPageCount;
    property PageMode: TgtPageMode read GetPageMode write SetPageMode;
    property PageLayout: TgtPageLayout read GetPageLayout write SetPageLayout;
    property CMapPath: string read GetCMapPath write SetCMapPath;
{$IFDEF gtActiveX}
    procedure Paint; override;
{$ENDIF}
  published
    property About: string read FAbout write SetAbout;

    property Version: string read FVersion write SetComVersion;

    // Whether to open the document after saving
    property OpenAfterSave: Boolean read FOpenAfterSave write FOpenAfterSave;

    property MergeOptions: TgtMergeOptions read FMergeOptions write FMergeOptions;

    // The Measurement unit accepted from the user for all operations.
    property MeasurementUnit: TgtMeasurementUnit
      read FMeasurementUnit write FMeasurementUnit default muPixels;

    // Progress of any operation performed.
    property OnOperationProgress: TgtOperationProgressEvent
      read FOnOperationProgress write FOnOperationProgress;

    // The progress of reading or saving document.
    property OnIOProgress: TgtProgressEvent read FOnIOProgress write FOnIOProgress;

    property OnStatusMessage: TgtStatusMessageEvent
      read FOnStatusMessage write FOnStatusMessage;
    property OnWarning: TgtWarningEvent read FOnWarning write FOnWarning;
    property OnPassword: TgtPasswordEvent read FOnPassword write FOnPassword;
    property OnCalcVariables: TgtOnCalcVariablesEvent read FOnCalcVariables
      write FOnCalcVariables;
    property OnRenameField: TgtOnRenameFieldEvent read FOnRenameField
      write FOnRenameField;

    property OnBeginRead: TNotifyEvent read FOnBeginRead write FOnBeginRead;
    property OnEndRead: TNotifyEvent read FOnEndRead write FOnEndRead;

    property IsLoaded: Boolean read FIsLoaded;
    property IsEncrypted: Boolean read FIsEncrypted;

    property Filename: string read FFilename write SetFilename;
    property FileSize: Int64 read FFileSize;
    property WorkFileName: string read FWorkFilename write SetWorkFileName;

    //The Encryption Settings
    property IsOwner: Boolean read GetIsOwner;
    property Encryption: TgtPDFEncryptionSettings read FEncryption;

    property EMailAfterSave: Boolean read FEmailAfterSave write FEmailAfterSave;
    // Information required for Emailing document.
    property EMailInfo: TgtEMailInfo read FEmailInfo write SetEmailInfo;

    property ShowSetupDialog: Boolean read FShowSetupDialog
      write FShowSetupDialog;
{$IFDEF EMailSupport}
    property OnEMail: TgtEMailEvent read FOnEmail write FOnEmail;
    property OnEMailError: TgtEMailErrorEvent read FOnEMailError write FOnEMailError;
{$ENDIF}

{$IFDEF EMailWithFastNet}
    property OnEMailConnect: TNotifyEvent read FOnEMailConnect
      write FOnEMailConnect;
    property OnEMailDisConnect: TNotifyEvent read FOnEMailDisConnect
      write FOnEMailDisConnect;
    property OnEMailSendStart: TNotifyEvent read FOnEMailSendStart
      write FOnEMailSendStart;
    property OnEMailStatus: TOnStatus read FOnEMailStatus
      write FOnEMailStatus;
    property OnEMailFailure: TNotifyEvent read FOnEMailFailure
      write FOnEMailFailure;
    property OnEMailSuccess: TNotifyEvent read FOnEMailSuccess
      write FOnEMailSuccess;
    property OnEMailConnectionFailed: TNotifyEvent
      read FOnEMailConnectionFailed write FOnEMailConnectionFailed;
    property OnEMailInvalidHost: THandlerEvent read FOnEMailInvalidHost
      write FOnEMailInvalidHost;
{$ENDIF}

{$IFDEF EMailWithIndy}
    property OnEMailConnected: TNotifyEvent read FOnEMailConnected
      write FOnEMailConnected;
    property OnEMailDisConnected: TNotifyEvent read FOnEMailDisConnected
      write FOnEMailDisConnected;
    property OnEMailStatus: TIdStatusEvent read FOnEMailStatus
      write FOnEMailStatus;
    property OnEMailSuccess: TNotifyEvent read FOnEMailSuccess
      write FOnEMailSuccess;
{$ENDIF}
  end;
{ Global functions }

//Gets pages from PageRange
function GetPages(PageRange: string; PageCount: Integer): TgtPageNumbers;
function ConvertToMU(MeasurementUnit: TgtMeasurementUnit; Value: Double): Double;
function ConvertToPDFUnit(MeasurementUnit: TgtMeasurementUnit; Value: Double): Double;
{$IFDEF COPYPROTECT}
function activateLicense(const RegName: PWideChar; const Serial: PWideChar):
  Integer; export; stdcall;
function trialPeriodLeft: Integer; export; stdcall;
{$ENDIF}
implementation

uses
  PDBaseExceptions, PDPage, PDPageTree, gtFont, PDFont, PDFormField,
  PDFormCheckBox, {$IFDEF gtDelphi6up}StrUtils{$ELSE} gtStrUtils{$ENDIF},
  gtSettingsDlg, PDModelException;

{ TgtCustomPDFDocument }

procedure TgtCustomPDFDocument.AppendPagesFrom(Document: TgtCustomPDFDocument;
  PageRange: string);
var
  LPages: TgtPageNumbers;
  Li: Integer;
begin
  if Assigned(FPDDoc) then
  begin
    if Assigned(FOnStatusMessage) then
      FOnStatusMessage(self, SAppendingPages);
    try
      LPages := GetPages(PageRange, Document.PageCount);
      for Li := 0 to Length(LPages) - 1 do
      begin
        FPDDoc.AppendPages(Document.FPDDoc, Lpages[Li], 1, InsertAll);
        //Triggers the OnOperationProgress event
        if Assigned(FOnOperationProgress) then
          FOnOperationProgress(self, opAppend, LI + 1, Length(LPages));
      end;
    finally
      //
    end;
  end;
end;
{------------------------------------------------------------------------------}
{$IFDEF WebAppServices}

procedure TgtCustomPDFDocument.SaveToHTTPResponse(Response: TWebResponse);
begin
  with Response do
  begin
    ContentType := 'application/pdf';
    ContentStream := TMemoryStream.Create;
    SaveToStream(ContentStream);
    ContentStream.Position := 0;
  end;
end;
{$ENDIF}
{------------------------------------------------------------------------------}

procedure TgtCustomPDFDocument.AddThumbnail(Page: Integer; Image: TGraphic);
var
  LMemStrm: TStream;
  LBitMap: TBitmap;
  LJpeg: TJPEGImage;
  Width, Height: Integer;
begin
  if not Assigned(FPDDoc) then Exit;

  if (Page >= 1) and (Page <= FPDDoc.PageCount) then
  begin
    try
      LMemStrm := TMemoryStream.Create;
      if (Image is TBitmap) then
      begin
        LBitmap := TBitmap.Create;
        LBitmap.Assign(Image);
        Width := LBitMap.Width;
        Height := LBitMap.Height;
        LBitMap.SaveToStream(LMemStrm);
        LMemStrm.Position := 0;
        LBitMap.Free;
      end
      else if (Image is TJPEGImage) then
      begin
        LJpeg := TJPEGImage.Create;
        LJpeg.Assign(Image);
        Width := LJpeg.Width;
        Height := LJpeg.Height;
        LBitmap := TBitmap.Create;
        LBitMap.Assign(LJpeg);
        LBitMap.SaveToStream(LMemStrm);
        LMemStrm.Position := 0;
        LJpeg.free;
        LBitMap.Free;
      end;
      LMemStrm.Position := 0;
      FPDDoc.Pages[Page].AddThumbnail(LMemStrm, Width, Height);
    finally
      LMemStrm.Free;
    end;
  end
  else
    raise EInvalidPageError.CreateFmt(SInvalidPageNumber, [Page]);
end;
{------------------------------------------------------------------------------}

procedure TgtCustomPDFDocument.AddCircleWaterMark(
  ATemplate: TgtCircleWaterMarkTemplate; APageNum: Integer);
const Kappa = 0.5522847498;
begin
  if not Assigned(FPDDoc) then Exit;
  with ATemplate do
  begin
    FPDDoc.Pages[APageNum].MoveTo(
      ConvertToPDFUnit(MeasurementUnit, Center.X),
      (ConvertToPDFUnit(MeasurementUnit, Center.Y)
      + ConvertToPDFUnit(MeasurementUnit, Radius)));
    FPDDoc.Pages[APageNum].CurveTo(
      (ConvertToPDFUnit(MeasurementUnit, Center.X) +
      (Kappa * ConvertToPDFUnit(MeasurementUnit, Radius))),
      (ConvertToPDFUnit(MeasurementUnit, Center.Y) +
      (ConvertToPDFUnit(MeasurementUnit, Radius))),
      (ConvertToPDFUnit(MeasurementUnit, Center.X) +
      ConvertToPDFUnit(MeasurementUnit, Radius)),
      (ConvertToPDFUnit(MeasurementUnit, Center.Y) +
      (Kappa * ConvertToPDFUnit(MeasurementUnit, Radius))),
      (ConvertToPDFUnit(MeasurementUnit, Center.X) +
      ConvertToPDFUnit(MeasurementUnit, Radius)),
      ConvertToPDFUnit(MeasurementUnit, Center.Y));
    FPDDoc.Pages[APageNum].CurveTo(
      (ConvertToPDFUnit(MeasurementUnit, Center.X) +
      ConvertToPDFUnit(MeasurementUnit, Radius)),
      (ConvertToPDFUnit(MeasurementUnit, Center.Y) -
      (Kappa * ConvertToPDFUnit(MeasurementUnit, Radius))),
      (ConvertToPDFUnit(MeasurementUnit, Center.X) +
      (Kappa * ConvertToPDFUnit(MeasurementUnit, Radius))),
      (ConvertToPDFUnit(MeasurementUnit, Center.Y) -
      ConvertToPDFUnit(MeasurementUnit, Radius)),
      ConvertToPDFUnit(MeasurementUnit, Center.X),
      (ConvertToPDFUnit(MeasurementUnit, Center.Y) -
      ConvertToPDFUnit(MeasurementUnit, Radius)));
    FPDDoc.Pages[APageNum].CurveTo(
      (ConvertToPDFUnit(MeasurementUnit, Center.X) -
      (Kappa * ConvertToPDFUnit(MeasurementUnit, Radius))),
      (ConvertToPDFUnit(MeasurementUnit, Center.Y) -
      ConvertToPDFUnit(MeasurementUnit, Radius)),
      (ConvertToPDFUnit(MeasurementUnit, Center.X) -
      ConvertToPDFUnit(MeasurementUnit, Radius)),
      (ConvertToPDFUnit(MeasurementUnit, Center.Y) -
      (Kappa * ConvertToPDFUnit(MeasurementUnit, Radius))),
      (ConvertToPDFUnit(MeasurementUnit, Center.X) -
      ConvertToPDFUnit(MeasurementUnit, Radius)),
      ConvertToPDFUnit(MeasurementUnit, Center.Y));
    FPDDoc.Pages[APageNum].CurveTo(
      (ConvertToPDFUnit(MeasurementUnit, Center.X) -
      ConvertToPDFUnit(MeasurementUnit, Radius)),
      (ConvertToPDFUnit(MeasurementUnit, Center.Y) +
      (Kappa * ConvertToPDFUnit(MeasurementUnit, Radius))),
      (ConvertToPDFUnit(MeasurementUnit, Center.X) -
      (Kappa * ConvertToPDFUnit(MeasurementUnit, Radius))),
      (ConvertToPDFUnit(MeasurementUnit, Center.Y) +
      ConvertToPDFUnit(MeasurementUnit, Radius)),
      ConvertToPDFUnit(MeasurementUnit, Center.X),
      (ConvertToPDFUnit(MeasurementUnit, Center.Y) +
      ConvertToPDFUnit(MeasurementUnit, Radius)));
    FPDDoc.Pages[APageNum].SetPenWidth(PenWidth);
    FPDDoc.Pages[APageNum].SetOpacity(OpacityStroke, OpacityFill);
    FPDDoc.Pages[APageNum].SetPenColor(
      GetRValue(StrokeColor),
      GetGValue(StrokeColor),
      GetBValue(StrokeColor));
    FPDDoc.Pages[APageNum].SetBrushColor(
      GetRValue(Fillcolor),
      GetGValue(Fillcolor),
      GetBValue(Fillcolor));
    FPDDoc.Pages[APageNum].SetEvenOddFillMode(True);
    if ((StrokeColor <> Graphics.clNone) and (Fillcolor <> Graphics.clNone)) then
      FPDDoc.Pages[APageNum].FillAndStrokePath
    else if ((StrokeColor <> Graphics.clNone) and (Fillcolor = Graphics.clNone)) then
      FPDDoc.Pages[APageNum].StrokePath
    else if ((StrokeColor = Graphics.clNone) and (Fillcolor <> Graphics.clNone)) then
      FPDDoc.Pages[APageNum].FillPath
    else
      FPDDoc.Pages[APageNum].StrokePath;
  end;
end;
{------------------------------------------------------------------------------}

procedure TgtCustomPDFDocument.AddCurveWaterMark(
  ATemplate: TgtCurveWaterMarkTemplate; APageNum: Integer);
begin
  if not Assigned(FPDDoc) then Exit;

  with ATemplate do
  begin
    if ((FirstControlPoint.X = 0) and (FirstControlPoint.Y = 0)) then
    begin
      FPDDoc.Pages[APageNum].MoveTo(
        ConvertToPDFUnit(MeasurementUnit, InitialPoint.X),
        ConvertToPDFUnit(MeasurementUnit, InitialPoint.Y));
      FPDDoc.Pages[APageNum].CurveTo(
        ConvertToPDFUnit(MeasurementUnit, InitialPoint.X),
        ConvertToPDFUnit(MeasurementUnit, InitialPoint.Y),
        ConvertToPDFUnit(MeasurementUnit, SecondControlPoint.X),
        ConvertToPDFUnit(MeasurementUnit, SecondControlPoint.Y),
        ConvertToPDFUnit(MeasurementUnit, EndPoint.X),
        ConvertToPDFUnit(MeasurementUnit, EndPoint.Y));
    end
    else if ((SecondControlPoint.X = 0) and (SecondControlPoint.Y = 0)) then
    begin
      FPDDoc.Pages[APageNum].MoveTo(
        ConvertToPDFUnit(MeasurementUnit, InitialPoint.X),
        ConvertToPDFUnit(MeasurementUnit, InitialPoint.Y));
      FPDDoc.Pages[APageNum].CurveTo(
        ConvertToPDFUnit(MeasurementUnit, FirstControlPoint.X),
        ConvertToPDFUnit(MeasurementUnit, FirstControlPoint.Y),
        ConvertToPDFUnit(MeasurementUnit, EndPoint.X),
        ConvertToPDFUnit(MeasurementUnit, EndPoint.Y),
        ConvertToPDFUnit(MeasurementUnit, EndPoint.X),
        ConvertToPDFUnit(MeasurementUnit, EndPoint.Y));
    end
    else
    begin
      FPDDoc.Pages[APageNum].MoveTo(
        ConvertToPDFUnit(MeasurementUnit, InitialPoint.X),
        ConvertToPDFUnit(MeasurementUnit, InitialPoint.Y));
      FPDDoc.Pages[APageNum].CurveTo(
        ConvertToPDFUnit(MeasurementUnit, FirstControlPoint.X),
        ConvertToPDFUnit(MeasurementUnit, FirstControlPoint.Y),
        ConvertToPDFUnit(MeasurementUnit, SecondControlPoint.X),
        ConvertToPDFUnit(MeasurementUnit, SecondControlPoint.Y),
        ConvertToPDFUnit(MeasurementUnit, EndPoint.X),
        ConvertToPDFUnit(MeasurementUnit, EndPoint.Y));
    end;
    FPDDoc.Pages[APageNum].SetPenWidth(PenWidth);
    FPDDoc.Pages[APageNum].SetOpacity(OpacityStroke, 100);
    FPDDoc.Pages[APageNum].SetPenColor(
      GetRValue(StrokeColor),
      GetGValue(StrokeColor),
      GetBValue(StrokeColor));
    FPDDoc.Pages[APageNum].StrokePath;
  end;
end;

procedure TgtCustomPDFDocument.AddDestination(Action: TgtPDFAction);
var
  LDest: TgtPDDestination;
begin
  if not Assigned(FPDDoc) then Exit;

  LDest := TgtPDGoToAction(Action.FAction).Destination;

  LDest.Rect.Left := ConvertToPDFUnit(MeasurementUnit, LDest.Rect.Left);
  LDest.Rect.Top := ConvertToPDFUnit(MeasurementUnit, LDest.Rect.Top);
  LDest.Rect.Bottom := ConvertToPDFUnit(MeasurementUnit, LDest.Rect.Bottom);
  // if fit zoom then right is taken as zoom factor
  if LDest.DisplayOptions <> FitZoom then
    LDest.Rect.Right := ConvertToPDFUnit(MeasurementUnit, LDest.Rect.Right);

  case Action.FAction.ActionType of
    actionGoTo:
    begin
      LDest.Page := FPDDoc.Pages[TgtPDFGoToAction(Action).PageNo];
    end;
    actionGotoR:
    begin
//        LDoc :=
//        TPDGoToRAction(THackgtPDFAction(LAction).FAction).Destination.Page :=
//          FPDDoc.Pages[TgtPDFGoToRAction(LAction).PageNo]
    end;
  end;
end;

{------------------------------------------------------------------------------}

procedure TgtCustomPDFDocument.AddEllipseWaterMark(
  ATemplate: TgtEllipseWaterMarkTemplate; APageNum: Integer);
const Kappa = 0.5522847498;
begin
  if not Assigned(FPDDoc) then Exit;

  with ATemplate do
  begin
    FPDDoc.Pages[APageNum].MoveTo(
      ConvertToPDFUnit(MeasurementUnit, Center.X),
      (ConvertToPDFUnit(MeasurementUnit, Center.Y)
      + ConvertToPDFUnit(MeasurementUnit, MinorRadius)));
    FPDDoc.Pages[APageNum].CurveTo(
      (ConvertToPDFUnit(MeasurementUnit, Center.X) +
      (Kappa * ConvertToPDFUnit(MeasurementUnit, MajorRadius))),
      (ConvertToPDFUnit(MeasurementUnit, Center.Y) +
      (ConvertToPDFUnit(MeasurementUnit, MinorRadius))),
      (ConvertToPDFUnit(MeasurementUnit, Center.X) +
      ConvertToPDFUnit(MeasurementUnit, MajorRadius)),
      (ConvertToPDFUnit(MeasurementUnit, Center.Y) +
      (Kappa * ConvertToPDFUnit(MeasurementUnit, MinorRadius))),
      (ConvertToPDFUnit(MeasurementUnit, Center.X) +
      ConvertToPDFUnit(MeasurementUnit, MajorRadius)),
      ConvertToPDFUnit(MeasurementUnit, Center.Y));
    FPDDoc.Pages[APageNum].CurveTo(
      (ConvertToPDFUnit(MeasurementUnit, Center.X) +
      ConvertToPDFUnit(MeasurementUnit, MajorRadius)),
      (ConvertToPDFUnit(MeasurementUnit, Center.Y) -
      (Kappa * ConvertToPDFUnit(MeasurementUnit, MinorRadius))),
      (ConvertToPDFUnit(MeasurementUnit, Center.X) +
      (Kappa * ConvertToPDFUnit(MeasurementUnit, MajorRadius))),
      (ConvertToPDFUnit(MeasurementUnit, Center.Y) -
      ConvertToPDFUnit(MeasurementUnit, MinorRadius)),
      ConvertToPDFUnit(MeasurementUnit, Center.X),
      (ConvertToPDFUnit(MeasurementUnit, Center.Y) -
      ConvertToPDFUnit(MeasurementUnit, MinorRadius)));
    FPDDoc.Pages[APageNum].CurveTo(
      (ConvertToPDFUnit(MeasurementUnit, Center.X) -
      (Kappa * ConvertToPDFUnit(MeasurementUnit, MajorRadius))),
      (ConvertToPDFUnit(MeasurementUnit, Center.Y) -
      ConvertToPDFUnit(MeasurementUnit, MinorRadius)),
      (ConvertToPDFUnit(MeasurementUnit, Center.X) -
      ConvertToPDFUnit(MeasurementUnit, MajorRadius)),
      (ConvertToPDFUnit(MeasurementUnit, Center.Y) -
      (Kappa * ConvertToPDFUnit(MeasurementUnit, MinorRadius))),
      (ConvertToPDFUnit(MeasurementUnit, Center.X) -
      ConvertToPDFUnit(MeasurementUnit, MajorRadius)),
      ConvertToPDFUnit(MeasurementUnit, Center.Y));
    FPDDoc.Pages[APageNum].CurveTo(
      (ConvertToPDFUnit(MeasurementUnit, Center.X) -
      ConvertToPDFUnit(MeasurementUnit, MajorRadius)),
      (ConvertToPDFUnit(MeasurementUnit, Center.Y) +
      (Kappa * ConvertToPDFUnit(MeasurementUnit, MinorRadius))),
      (ConvertToPDFUnit(MeasurementUnit, Center.X) -
      (Kappa * ConvertToPDFUnit(MeasurementUnit, MajorRadius))),
      (ConvertToPDFUnit(MeasurementUnit, Center.Y) +
      ConvertToPDFUnit(MeasurementUnit, MinorRadius)),
      ConvertToPDFUnit(MeasurementUnit, Center.X),
      (ConvertToPDFUnit(MeasurementUnit, Center.Y) +
      ConvertToPDFUnit(MeasurementUnit, MinorRadius)));
    FPDDoc.Pages[APageNum].SetPenWidth(PenWidth);
    FPDDoc.Pages[APageNum].SetOpacity(OpacityStroke, OpacityFill);
    FPDDoc.Pages[APageNum].SetPenColor(
      GetRValue(StrokeColor),
      GetGValue(StrokeColor),
      GetBValue(StrokeColor));
    FPDDoc.Pages[APageNum].SetBrushColor(
      GetRValue(Fillcolor),
      GetGValue(Fillcolor),
      GetBValue(Fillcolor));
    FPDDoc.Pages[APageNum].SetEvenOddFillMode(True);
    if ((StrokeColor <> Graphics.clNone) and (Fillcolor <> Graphics.clNone)) then
      FPDDoc.Pages[APageNum].FillAndStrokePath
    else if ((StrokeColor <> Graphics.clNone) and (Fillcolor = Graphics.clNone)) then
      FPDDoc.Pages[APageNum].StrokePath
    else if ((StrokeColor = Graphics.clNone) and (Fillcolor <> Graphics.clNone)) then
      FPDDoc.Pages[APageNum].FillPath
    else
      FPDDoc.Pages[APageNum].StrokePath;
  end;
end;
{------------------------------------------------------------------------------}

procedure TgtCustomPDFDocument.AddImageWaterMark(
  ATemplate: TgtImageWatermarkTemplate; APageNum: Integer);
var
  LFX, LFY, LWidth, LHeight, LPageWidth, LPageHeight: Double;
  LMemStream: TMemoryStream;
begin
  if not Assigned(FPDDoc) then Exit;

  with ATemplate do
  begin

    if Overlay then
      FPDDoc.Pages[APageNum].SetRenderMode(rmOverlay)
    else
      FPDDoc.Pages[APageNum].SetRenderMode(rmUnderlay);

    FPDDoc.Pages[APageNum].SetOpacity(100, OpacityFill);

    if ((FPDDoc.Pages[APageNum].Rotate <> 0) and
      (FPDDoc.Pages[APageNum].Rotate <> 360)) then
    begin
      LPageWidth := FPDDoc.Pages[APageNum].GetPageSize.Height;
      LPageHeight := FPDDoc.Pages[APageNum].GetPageSize.Width;
    end
    else
    begin
      LPageWidth := FPDDoc.Pages[APageNum].GetPageSize.Width;
      LPageHeight := FPDDoc.Pages[APageNum].GetPageSize.Height;
    end;

    LFX := FX;
    LFY := FY;
    //Width and Height
    if FWidth = 0 then
      LWidth := ConvertToPDFUnit(muPixels, Image.Width)
    else
      LWidth := ConvertToPDFUnit(MeasurementUnit, FWidth);
    if FHeight = 0 then
      LHeight := ConvertToPDFUnit(muPixels, Image.Height)
    else
      LHeight := ConvertToPDFUnit(MeasurementUnit, FHeight);
    GetXY(LPageWidth, LPageHeight, LFX, LFY, LWidth, LHeight, MeasurementUnit);

    //Image Stream
    LMemStream := TMemoryStream.Create;
    Image.SaveToStream(LMemStream);
    FPDDoc.Pages[APageNum].InsertImage(LFX, LFY,
      LMemStream, ImageFormat, FInLine, LWidth, LHeight, Angle);
    FreeAndNil(LMemStream);
  end;
end;
{------------------------------------------------------------------------------}

procedure TgtCustomPDFDocument.AddLineWaterMark(
  ATemplate: TgtLineWatermarkTemplate; APageNum: Integer);
begin
  if not Assigned(FPDDoc) then Exit;

  with ATemplate do
  begin
    FPDDoc.Pages[APageNum].SetPenColor(
      GetRValue(StrokeColor),
      GetGValue(StrokeColor),
      GetBValue(StrokeColor));
    FPDDoc.Pages[APageNum].SetOpacity(OpacityStroke, 100);
    FPDDoc.Pages[APageNum].SetPenWidth(PenWidth);
    FPDDoc.Pages[APageNum].MoveTo(
      ConvertToPDFUnit(MeasurementUnit, InitialPoint.X),
      ConvertToPDFUnit(MeasurementUnit, InitialPoint.Y));
    FPDDoc.Pages[APageNum].LineTo(
      ConvertToPDFUnit(MeasurementUnit, EndPoint.X),
      ConvertToPDFUnit(MeasurementUnit, EndPoint.Y));
    FPDDoc.Pages[APageNum].StrokePath;
  end;
end;
{------------------------------------------------------------------------------}

procedure TgtCustomPDFDocument.AddPolygonWaterMark(
  ATemplate: TgtPolygonWatermark; APageNum: Integer);
var
  LRadius: Double;
  LJ: Integer;
begin
  if not Assigned(FPDDoc) then Exit;

  with ATemplate do
  begin
    LRadius := ConvertToPDFUnit(MeasurementUnit, SideLength) / 2 *
      Csc(Pi / NoOfSides);
    for LJ := 0 to NoOfSides - 1 do
    begin
      if (LJ = 0) then
        FPDDoc.Pages[APageNum].MoveTo(
          ConvertToPDFUnit(MeasurementUnit, Center.X) +
          ConvertToPDFUnit(MeasurementUnit, LRadius) * cos(PI / 2),
          ConvertToPDFUnit(MeasurementUnit, Center.Y) -
          ConvertToPDFUnit(MeasurementUnit, LRadius) * sin(PI / 2))
      else
      begin
        FPDDoc.Pages[APageNum].LineTo(
          ConvertToPDFUnit(MeasurementUnit, Center.X) +
          ConvertToPDFUnit(MeasurementUnit, LRadius) *
          cos(PI / 2 + LJ * (2 * PI / NoOfSides)),
          ConvertToPDFUnit(MeasurementUnit, Center.Y) -
          ConvertToPDFUnit(MeasurementUnit, LRadius) *
          sin(PI / 2 + LJ * (2 * PI / NoOfSides)));
      end;
    end;
    FPDDoc.Pages[APageNum].LineTo(
      ConvertToPDFUnit(MeasurementUnit, Center.X) +
      ConvertToPDFUnit(MeasurementUnit, LRadius) * Cos(PI / 2),
      ConvertToPDFUnit(MeasurementUnit, Center.Y) -
      ConvertToPDFUnit(MeasurementUnit, LRadius) * sin(PI / 2));
    FPDDoc.Pages[APageNum].SetPenWidth(PenWidth);
    FPDDoc.Pages[APageNum].SetOpacity(OpacityStroke, OpacityFill);
    FPDDoc.Pages[APageNum].SetPenColor(
      GetRValue(StrokeColor),
      GetGValue(StrokeColor),
      GetBValue(StrokeColor));
    FPDDoc.Pages[APageNum].SetBrushColor(
      GetRValue(Fillcolor),
      GetGValue(Fillcolor),
      GetBValue(Fillcolor));
    FPDDoc.Pages[APageNum].SetEvenOddFillMode(True);
    if ((StrokeColor <> Graphics.clNone) and (Fillcolor <> Graphics.clNone)) then
      FPDDoc.Pages[APageNum].FillAndStrokePath
    else if ((StrokeColor <> Graphics.clNone) and (Fillcolor = Graphics.clNone)) then
      FPDDoc.Pages[APageNum].StrokePath
    else if ((StrokeColor = Graphics.clNone) and (Fillcolor <> Graphics.clNone)) then
      FPDDoc.Pages[APageNum].FillPath
    else
      FPDDoc.Pages[APageNum].StrokePath;
  end;
end;
{------------------------------------------------------------------------------}

procedure TgtCustomPDFDocument.AddRectangleWaterMark(
  ATemplate: TgtRectangleWatermarkTemplate; APageNum: Integer);
begin
  if not Assigned(FPDDoc) then Exit;

  with ATemplate do
  begin
    FPDDoc.Pages[APageNum].SetPenColor(
      GetRValue(StrokeColor),
      GetGValue(StrokeColor),
      GetBValue(StrokeColor));
    FPDDoc.Pages[APageNum].SetBrushColor(
      GetRValue(Fillcolor),
      GetGValue(Fillcolor),
      GetBValue(Fillcolor));
    FPDDoc.Pages[APageNum].SetOpacity(OpacityStroke, OpacityFill);
    FPDDoc.Pages[APageNum].SetPenWidth(PenWidth);
    FPDDoc.Pages[APageNum].Rectangle(
      ConvertToPDFUnit(MeasurementUnit, InitialPoint.X),
      ConvertToPDFUnit(MeasurementUnit, InitialPoint.Y),
      ConvertToPDFUnit(MeasurementUnit, EndPoint.X),
      ConvertToPDFUnit(MeasurementUnit, EndPoint.Y));
    FPDDoc.Pages[APageNum].FillAndStrokePath;
  end;
end;
{------------------------------------------------------------------------------}

procedure TgtCustomPDFDocument.AddTextWaterMark(
  ATemplate: TgtTextWatermarkTemplate; APageNum: Integer);
var
  LPDgtFont: TgtFont;
  LTxtWidth, LTxtHeight, LPageWidth, LPageHeight, LX, LY: Double;
  LStream, LStream1: TMemoryStream;
  LTempStr: WideString;
  LFontEncoding: Shortint;
  LRenderMode: TTextRenderMode;
  LWritingMode: TgtWritingMode;
  LMLineStrings: TArray;
  LI, LMaxTextWidth, LWidth1, LWidth2: Integer;
begin
  LStream := nil;
  if not Assigned(FPDDoc) then
    Exit;
  
  with ATemplate do
  begin
    LPDgtFont := TgtFont.Create;
    LPDgtFont.Name := Font.Name;
    LPDgtFont.Size := Font.Size;
    LPDgtFont.Style := Font.Style;
    LPDgtFont.Color := Font.Color;
    LFontEncoding := ShortInt(FontEncoding);
    LPDgtFont.Encoding := gtFont.TgtFontEncoding(Integer(LFontEncoding));

    if EmbedTrueTypeFonts = tfeFull then
    begin
      LStream := TMemoryStream.Create;
      GetTrueTypeFontData(Font, LStream);
      LPDgtFont.Stream := LStream;
    end;

    if Overlay = False then
      FPDDoc.Pages[APageNum].SetRenderMode(rmUnderlay)
    else
      FPDDoc.Pages[APageNum].SetRenderMode(rmOverlay);

    FPDDoc.Pages[APageNum].SetPenColor(
      GetRValue(StrokeColor),
      GetGValue(StrokeColor),
      GetBValue(StrokeColor));

    FPDDoc.Pages[APageNum].SetBrushColor(
      GetRValue(Font.Color),
      GetGValue(Font.Color),
      GetBValue(Font.Color));

    FPDDoc.Pages[APageNum].SetOpacity(OpacityStroke, OpacityStroke);
    case RenderMode of
      rmFill: LRenderMode := trmFill;
      rmStroke: LRenderMode := trmStroke;
      rmFillStroke: LRenderMode := trmFillStroke;
    end;
    FPDDoc.Pages[APageNum].SetTextRenderMode(LRenderMode);

    if ((FPDDoc.Pages[APageNum].Rotate = 90) or
      (FPDDoc.Pages[APageNum].Rotate = 270)) then
    begin
      LPageWidth := FPDDoc.Pages[APageNum].GetPageSize.Height;
      LPageHeight := FPDDoc.Pages[APageNum].GetPageSize.Width;
    end
    else
    begin
      LPageWidth := FPDDoc.Pages[APageNum].GetPageSize.Width;
      LPageHeight := FPDDoc.Pages[APageNum].GetPageSize.Height;
    end;

    //Replacing the placeholders in the input string
    LTempStr := ReplacePlaceHolders(Text, APageNum);
    //CR and LF are processed into array of strings
    //and the maxwidth among the array of strings is found 
    if ProcessControlStrings(LTempStr, LMLineStrings) then
    begin
      LMaxTextWidth := TextSize(LMLineStrings[0], Font).cx;
      for LI := 0 to Length(LMLineStrings) - 2 do
      begin
        LWidth1 := TextSize(LMLineStrings[LI + 1], Font).cx;
        if (LMaxTextWidth < LWidth1) then
          LMaxTextWidth := LWidth1
      end;
      LTxtWidth := ConvertToPDFUnit(muPixels, LMaxTextWidth);
    end
    else
      LTxtWidth := ConvertToPDFUnit(muPixels, TextSize(LTempStr, Font).cx);

    LTxtHeight := ConvertToPDFUnit(muPixels, Font.Size);
    LX := X;
    LY := Y;

    GetXY(LPageWidth, LPageHeight, LX, LY, LTxtWidth, LTxtHeight, MeasurementUnit);

    case WritingMode of
      wmHorizontal: LWritingMode := PDFont.wmHorizontal;
      wmVertical: LWritingMode := PDFont.wmVertical;
    end;
    FPDDoc.Pages[APageNum].UniCodeTextOut(LTempStr, LPDgtFont, LX, LY,
      LWritingMode, Angle);
    if Assigned(LStream) then
      FreeAndNil(LStream);

    if Assigned(LPDgtFont) then
      FreeAndNil(LPDgtFont);
  end;
end;
{------------------------------------------------------------------------------}

procedure TgtCustomPDFDocument.AddThumbnail(Images: TList);
var
  LI: Integer;
begin
  for LI := 0 to Images.Count - 1 do
    AddThumbnail(LI + 1, TGraphic(Images.Items[LI]));
end;
procedure TgtCustomPDFDocument.AfterConstruction;
begin
  inherited;
{$IFNDEF EXPOSEGDIINIT}
  TgtPDDocument.StartGDIPlus;
{$ENDIF}
end;

{------------------------------------------------------------------------------}

procedure TgtCustomPDFDocument.AppendPagesFrom(FileName, PageRange: string);
var
  LPDDoc: TgtPDDocument;
  LPages: TgtPageNumbers;
  Li: Integer;
begin
  if Assigned(FPDDoc) then
  begin
    if Assigned(FOnStatusMessage) then
      FOnStatusMessage(self, SAppendingPages);
    try
      LPDDoc := TgtPDDocument.Create;
      LPDDoc.LoadDocument(FileName, False);
      //Gets page array from pagerange
      LPages := GetPages(PageRange, LPDDoc.PageCount);
      FAppendPagesObjList := TObjectList.Create;
      for LI := 0 to Length(LPages) - 1 do
      begin
        FPDDoc.AppendPages(LPDDoc, Lpages[Li], 1, InsertAll);
        //Triggers the OnOperationProgress event
        if Assigned(FOnOperationProgress) then
          FOnOperationProgress(self, opAppend, LI + 1, Length(LPages));
      end;
    finally
      FAppendPagesObjList.Add(LPDDoc);
    end;
  end;
end;
{------------------------------------------------------------------------------}

procedure TgtCustomPDFDocument.Authorize(AForDocOpen: Boolean);
begin
  if Assigned(FOnPassword) or (Encryption.Enabled) then
  begin
    if AForDocOpen then
      FOnPassword(Self, FPassword, FContinue, FTries);
    Inc(FTries);

    if FContinue or Encryption.Enabled then
    begin
      FPermissions.OwnerPassword := Encryption.OwnerPassword;
      FPermissions.UserPassword := Encryption.UserPassword;
      case Encryption.Level of
        el40bit: FPermissions.Level := el40Bits;
        el128bit: FPermissions.Level := el128Bits;
      end;
      if AllowCopy in Encryption.UserPermissions then
        FPermissions.CopyText := True;
      if AllowModify in Encryption.UserPermissions then
        FPermissions.ModifyContents := True;
      if AllowPrint in Encryption.UserPermissions then
        FPermissions.Print := True;
      if AllowAnnotation in Encryption.UserPermissions then
        FPermissions.ModifyTextAnnots := True;
      if AllowFormFill in Encryption.UserPermissions then
        FPermissions.FillForms := True;
      if AllowAccessibility in Encryption.UserPermissions then
        FPermissions.AssmbleDoc := True;
      if AllowDocAssembly in Encryption.UserPermissions then
        FPermissions.AssmbleDoc := True;
      if AllowHighResPrint in Encryption.UserPermissions then
        FPermissions.PrintHighQuality := True;

      FPermissions.Enable := Encryption.Enabled;
    end;
  end;
end;
procedure TgtCustomPDFDocument.BeforeDestruction;
begin
  inherited;
{$IFNDEF EXPOSEGDIINIT}
  TgtPDDocument.StopGDIPlus;
{$ENDIF}

end;

{------------------------------------------------------------------------------}

procedure TgtCustomPDFDocument.CompressDocument(
  CompressionType: TgtCompressionFilter; CompressionLevel: TgtCompressionLevel);
begin
  //Full rewrite
end;
{------------------------------------------------------------------------------}

constructor TgtCustomPDFDocument.Create(AOwner: TComponent);
begin
  inherited;
  FStream := nil;
  FOutputStream := nil;
  FAbout := SProductName;
  FVersion := CVersion;
  FFilename := '';
  FWorkFilename := '';
  FIsStreamOwned := False;
  FIsSaveStreamOwned := False;
  FIsLoaded := False;
  FEmailInfo := TgtEMailInfo.Create;
  FEncryption := TgtPDFEncryptionSettings.Create;
  FOnCalcVariables := nil;
  FLinkedControls := TList.Create;
  with FEncryption do
  begin
    Level := el40bit;
    OwnerPassword := '';
    UserPassword := '';
    Enabled := False;
  end;
  FViewerPref := nil;
  FTries := 0;
  FContinue := True;
  FPassword := '';
  FOutputFilename := '';
end;
{------------------------------------------------------------------------------}

//function TgtCustomPDFDocument.CreateNewBookmark(Title: WideString;
//  Destination: TgtPDFDestination;  OutLineAttribute: TgtBookmarkAttribute): TgtPDFOutline;
//var
//  LOutlineAttribute: TgtPDOutlineFlag;
//begin
//  Result := nil;
//  if Assigned(FPDDoc) then
//  begin
//    if (fsBold in (OutLineAttribute.FFontStyles)) then
//      LOutlineAttribute.Bold := True
//    else
//      LOutlineAttribute.Bold := False;
//    if (fsItalic in (OutLineAttribute.FFontStyles)) then
//      LOutlineAttribute.Italic := True
//    else
//      LOutlineAttribute.Italic := False;
//    if (fsUnderline in (OutLineAttribute.FFontStyles)) then
//      LOutlineAttribute.Underline := True
//    else
//      LOutlineAttribute.Underline := False;
//    if (fsStrikeOut in (OutLineAttribute.FFontStyles)) then
//      LOutlineAttribute.StrikeOut := True
//    else
//      LOutlineAttribute.StrikeOut := False;
//
//    Destination.FDestination.Page := FPDDoc.Pages[Destination.FPageNo];
//    Result := TgtPDFOutline.Create(Self);
//
//    Result.FPDBookmark := FPDDoc.CreateBookmarkRoot(Title, Destination.FDestination, LOutlineAttribute);
//  end;
//end;
{------------------------------------------------------------------------------}

//
//function TgtCustomPDFDocument.CreateNewBookmark(Title: WideString;
//  Action: TgtPDFAction; OutLineAttribute: TgtBookmarkAttribute): TgtPDFOutline;
//var
//  LOutlineAttribute: TgtPDOutlineFlag;
//begin
//  if Assigned(FPDDoc) then
//  begin
//      if (fsBold in (OutLineAttribute.FFontStyles)) then
//      LOutlineAttribute.Bold := True
//    else
//      LOutlineAttribute.Bold := False;
//    if (fsItalic in (OutLineAttribute.FFontStyles)) then
//      LOutlineAttribute.Italic := True
//    else
//      LOutlineAttribute.Italic := False;
//    if (fsUnderline in (OutLineAttribute.FFontStyles)) then
//      LOutlineAttribute.Underline := True
//    else
//      LOutlineAttribute.Underline := False;
//    if (fsStrikeOut in (OutLineAttribute.FFontStyles)) then
//      LOutlineAttribute.StrikeOut := True
//    else
//      LOutlineAttribute.StrikeOut := False;
//
//    Result := TgtPDFOutline.Create(Self);
//    Result.FPDBookmark := FPDDoc.CreateBookmarkRoot(Title, Action.FAction, LOutlineAttribute);
////  end;
//end;
{------------------------------------------------------------------------------}
procedure TgtCustomPDFDocument.DecompressDocument;
begin

end;
{------------------------------------------------------------------------------}

procedure TgtCustomPDFDocument.DeletePages(PageRange: string);
var
  LPages: TgtPageNumbers;
  LI: Integer;
begin
  if Assigned(FPDDoc) then
  begin
    //Gets page array from pagerange
    LPages := GetPages(PageRange, PageCount);
    for LI := Length(LPages) - 1 downto 0 do
    begin
    //Call DeletePage of PDFProcessor
      FPDDoc.DeletePage(LPages[LI]);
    end;
    //Trigger's the OnStatusMessage event
    if Assigned(OnStatusMessage) then
      OnStatusMessage(self, Format(SNPagesDeleted, [Length(LPages)]));
  end;
end;
{------------------------------------------------------------------------------}

destructor TgtCustomPDFDocument.Destroy;
begin
  DoDocumentChanged(CM_PDFDocumentDestroying);
  FLinkedControls.Clear;
  FLinkedControls.Free;
  if Assigned(FEmailInfo) then
    FEmailInfo.Free;
  if Assigned(FEncryption) then
    FEncryption.Free;
  if Assigned(FPDFInfo) then
    FPDFInfo.Free;
//  if Assigned(FOutlines) then
//    FOutlines.Free;
  if Assigned(FViewerPref) then
    FViewerPref.Free;
  if Assigned(FPDDoc) then
    FPDDoc.Free;
  if FIsStreamOwned then
    FreeAndNil(FStream);
  if FIsSaveStreamOwned and Assigned(FOutputStream) then
    FreeAndNil(FOutputStream);
  inherited;
end;

procedure TgtCustomPDFDocument.DoDocumentChanged(AMsg: Cardinal);
var
  I: Integer;
begin
  for I := 0 to FLinkedControls.Count - 1 do
    if Assigned(TControl(FLinkedControls[I])) then
      TControl(FLinkedControls[I]).Perform(AMsg, LongInt(Self), 0);
end;

{------------------------------------------------------------------------------}

procedure TgtCustomPDFDocument.ExtractPagesTo(Document: TgtCustomPDFDocument;
  PageRange: string);
var
  LPageRange: TgtPageNumbers;
  LI: Integer;
  LBlankDoc: TStringStream;
begin
  if Assigned(FPDDoc) and (Self.IsLoaded) then
  begin
    LBlankDoc := TStringStream.Create(BlankDoc);
    try
      if Assigned(FOnStatusMessage) then
        FOnStatusMessage(self, SExtractingPages);

      Document.LoadFromStream(LBlankDoc);
      Document.DeletePages('1');
      LPageRange := Getpages(PageRange, PageCount);
      for LI := 0 to Length(LPageRange) - 1 do
      begin
        Document.FPDDoc.AppendPages(Self.FPDDoc, LPageRange[LI], 1, InsertAll);

        //Gives the information about the extraction process
        if Assigned(FOnOperationProgress) then
          FOnOperationProgress(self, opExtract, LI + 1, Length(LPageRange));
      end;
    finally
//      LBlankDoc.Free;
    end;
  end;
end;
{------------------------------------------------------------------------------}

procedure TgtCustomPDFDocument.ExtractPagesTo(FileName, PageRange: string);
var
  LTmpDoc: TgtCustomPDFDocument;
begin
  if Assigned(FPDDoc) then
  begin
    LTmpDoc := TgtCustomPDFDocument.Create(nil);
    try
      ExtractPagesTo(LTmpDoc, PageRange);
      LTmpDoc.SaveToFile(FileName);
    finally
      FreeAndNil(LTmpDoc);
    end;
  end;
end;
{------------------------------------------------------------------------------}

function TgtCustomPDFDocument.GetBookmarkRoot: TgtPDFOutline;
begin
  if not Assigned(FPDDoc) then Exit;
  if not Assigned(FOutlines) then
  begin
    FOutlines := TgtPDFOutline.Create(Self, nil);
    FOutlines.FPDBookmark := FPDDoc.GetBookmarkRoot;
  end;
  Result := FOutlines;
end;

function TgtCustomPDFDocument.GetCMapPath: string;
begin
  Result := FPDDoc.CMapPath;
end;

{------------------------------------------------------------------------------}

function TgtCustomPDFDocument.GetDocInfo: TgtPDFInfo;
begin
  Result := nil;
  if not Assigned(FPDDoc) then Exit;

  if not Assigned(FPDFInfo) then
  begin
    FPDFInfo := TgtPDFInfo.Create;
    FPDFInfo.FPDInfo := FPDDoc.DocInfo;
  end;
  Result := FPDFInfo;
end;
{------------------------------------------------------------------------------}

function TgtCustomPDFDocument.GetFieldIndexOf(FieldName: string): Integer;
var
  LPageIterator, LFieldIterator, LFieldCount: Integer;
begin
  Result := 0;
  if not Assigned(FPDDoc) then Exit;

  LFieldCount := 1;
//  if (FFormFieldCount <> 0) then
//  begin
    for LPageIterator := 1 to FPDDoc.PageCount do
    begin
      for LFieldIterator := 1 to FPDDoc.Pages[LPageIterator].GetFormFieldCount do
      begin
        if (FPDDoc.GetFormField(LPageIterator, LFieldIterator).FieldName = FieldName) then
        begin
          Result := LFieldCount;
          Exit;
        end;
        LFieldCount := LFieldCount + 1;
      end;
    end;
//  end;
end;
{------------------------------------------------------------------------------}

function TgtCustomPDFDocument.GetFormFieldAllowedValues(
  FieldNo: Integer): TStrings;
begin
  Result := nil;
end;
{------------------------------------------------------------------------------}

function TgtCustomPDFDocument.GetFormFieldAllowedValues(
  FieldName: string): TStrings;
begin
  Result := nil;
end;
{------------------------------------------------------------------------------}

function TgtCustomPDFDocument.GetFormFieldCount: Integer;
var
  LPageIterator, LFieldIterator: Integer;
begin
  if not Assigned(FPDDoc) then Exit;

  FFormFieldCount := 0;
  for LPageIterator := 1 to FPDDoc.PageCount do
  begin
    for LFieldIterator := 1 to FPDDoc.Pages[LPageIterator].GetFormFieldCount do
    begin
      Inc(FFormFieldCount);
    end;
  end;

  Result := FFormFieldCount;
end;
{------------------------------------------------------------------------------}

function TgtCustomPDFDocument.GetFormFieldDescription(FieldNo: Integer): string;
begin

end;
{------------------------------------------------------------------------------}

function TgtCustomPDFDocument.GetFormFieldDescription(
  FieldName: string): string;
begin

end;
{------------------------------------------------------------------------------}

function TgtCustomPDFDocument.GetFormFieldName(FieldNo: Integer): string;
begin

end;
{------------------------------------------------------------------------------}

function TgtCustomPDFDocument.GetFormFieldType(
  FieldName: string): TgtPDFFormFieldType;
begin

end;
{------------------------------------------------------------------------------}

function TgtCustomPDFDocument.GetFormFieldType(
  FieldNo: Integer): TgtPDFFormFieldType;
begin

end;
{------------------------------------------------------------------------------}

function TgtCustomPDFDocument.GetFormFieldValue(FieldNo: Integer): string;
begin

end;
{------------------------------------------------------------------------------}

function TgtCustomPDFDocument.GetFormFieldValue(FieldName: string): string;
begin

end;
{------------------------------------------------------------------------------}

function TgtCustomPDFDocument.GetFormFieldValues: TStringList;
var
  LPageIterator, LFieldIterator: Integer;
begin
  if not Assigned(FPDDoc) then
  begin
    Result := nil;
    Exit;
  end;

  Result := TStringList.Create;

  if FFormFieldCount = 0 then
  begin
    for LPageIterator := 1 to FPDDoc.PageCount do
    begin
      for LFieldIterator := 1 to FPDDoc.Pages[LPageIterator].GetFormFieldCount do
      begin
        Result.Add(FPDDoc.GetFormField(LPageIterator, LFieldIterator).FieldName +
          '=' + FPDDoc.GetFormField(LPageIterator, LFieldIterator).Value);
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
//(*
//function TgtCustomPDFDocument.GetIsEncrypted: Boolean;
//begin
//  Result := FIsEncrypted;
//end;
//*)
//{------------------------------------------------------------------------------}
//
function TgtCustomPDFDocument.GetIsOwner: Boolean;
begin
  Result := False;
  if Assigned(FPDDoc) then
  begin
    if IsLoaded then
      Result := FPDDoc.IsOwner;
  end;
end;
{------------------------------------------------------------------------------}

function TgtCustomPDFDocument.GetPageCount: Integer;
begin
  //Returns the number of pages in the document
  if Assigned(FPDDoc) and IsLoaded then
    Result := FPDDoc.PageCount
  else
    Result := 0;
end;
{------------------------------------------------------------------------------}

function TgtCustomPDFDocument.GetPageCropBox(PageNo: Integer;
  MMUnit: TgtMeasurementUnit): TgtRect;
var
  LPDPage: TgtPDPage;
  LPDRect: TgtPDRect;
begin
  if Assigned(FPDDoc) then
  begin
    if (PageNo < 0) or (PageNo > GetPageCount) then
    begin
      raise EInvalidPageError.CreateFmt(SInvalidPageNumber, [PageNo]);
      Exit;
    end;
    //Gets a particular page from PDF Processor
    LPDPage := FPDDoc.Pages[PageNo];
    if Assigned(LPDPage) then
    begin
      //Retrieve the CropBox entry form the page
      LPDRect := LPDPage.CropBox;
      if Assigned(LPDRect) then
      begin
        Result.Left := ConvertToMU(MMUnit, LPDRect.Left);
        Result.Top := ConvertToMU(MMUnit, LPDRect.Top);
        Result.Right := ConvertToMU(MMUnit, LPDRect.Right);
        Result.Bottom := ConvertToMU(MMUnit, LPDRect.Bottom);
      end
      else
      begin
        Result.Left := 0;
        Result.Top := 0;
        Result.Right := 0;
        Result.Bottom := 0;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}

function TgtCustomPDFDocument.GetPageLayout: TgtPageLayout;
var
  LPDPageLayout: TgtPDLayoutMode;
begin
  if Assigned(FPDDoc) then
  begin
    LPDPageLayout := FPDDoc.GetLayoutMode;
    case LPDPageLayout of
      lmNone: Result := plNone;
      lmSinglePage: Result := plSinglePage;
      lmOneColumn: Result := plOneColumn;
      lmTwoColumnLeft: Result := plTwoColumnLeft;
      lmTwoColumnRight: Result := plTwoColumnRight;
      lmTwoPageLeft: Result := plTwoPageLeft;
      lmTwoPageRight: Result := plTwoPageRight;
    end;
  end;
end;
{------------------------------------------------------------------------------}

function TgtCustomPDFDocument.GetPageMediaBox(
  AMeasurementUnit: TgtMeasurementUnit; PageNo: Integer): TgtRect;
begin
  if Assigned(FPDDoc) then
  begin
    Result := GetPageMediaBox(PageNo);
    Result.Left := ConvertToMU(AMeasurementUnit, Result.Left);
    Result.Top := ConvertToMU(AMeasurementUnit, Result.Top);
    Result.Right := ConvertToMU(AMeasurementUnit, Result.Right);
    Result.Bottom := ConvertToMU(AMeasurementUnit, Result.Bottom);
  end;
end;
{------------------------------------------------------------------------------}

function TgtCustomPDFDocument.GetPageMode: TgtPageMode;
var
  LPDPageMode: TgtPDPageMode;
begin
  if not Assigned(FPDDoc) then
  begin
    Result := gtCstPDFDoc.pmNone;
    Exit;
  end;

  LPDPageMode := FPDDoc.GetPageMode;
  case LPDPageMode of
    pmUseNone: Result := gtCstPDFDoc.pmNone;
    PDTypes.pmUseThumbs: Result := gtCstPDFDoc.pmUseThumbs;
    pmUseBookmarks: Result := pmUseOutlines;
    PDTypes.pmFullScreen: Result := gtCstPDFDoc.pmFullScreen;
    pmOCVisible: Result := pmUseOC;
    pmAttachmentsVisible: Result := pmUseAttachments;
  end;
end;
{------------------------------------------------------------------------------}

function TgtCustomPDFDocument.GetPageMediaBox(PageNo: Integer): TgtRect;
var
  LPDPage: TgtPDPage;
  LPDRect: TgtPDRect;
begin
  Result.Left := 0;
  Result.Top := 0;
  Result.Right := 0;
  Result.Bottom := 0;

  if Assigned(FPDDoc) then
  begin
    if (PageNo < 0) or (PageNo > GetPageCount) then
    begin
      raise EInvalidPageError.CreateFmt(SInvalidPageNumber, [PageNo]);
      Exit;
    end;
    //Gets a particular page from PDF Processor
    LPDPage := FPDDoc.pages[PageNo];
    if Assigned(LPDPage) then
    begin
      //Retrieve the CropBox entry form the page
      LPDRect := LPDPage.MediaBox;
      if Assigned(LPDRect) then
      begin
        Result.Left := ConvertToMu(FMeasurementUnit, LPDRect.Left);
        Result.Top := ConvertToMu(FMeasurementUnit, LPDRect.Top);
        Result.Right := ConvertToMu(FMeasurementUnit, LPDRect.Right);
        Result.Bottom := ConvertToMu(FMeasurementUnit, LPDRect.Bottom);
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}

function TgtCustomPDFDocument.GetPageRotate(PageNo: Integer): Integer;
var
  LPDPage: TgtPDPage;
begin
  Result := -1;
  if Assigned(FPDDoc) then
  begin
    if (PageNo < 0) or (PageNo > GetPageCount) then
    begin
      raise EInvalidPageError.CreateFmt(SInvalidPageNumber, [PageNo]);
      Exit;
    end;
    LPDPage := FPDDoc.Pages[PageNo];
    //Returns rotation angle specified for a page
    Result := LPDPage.Rotate;
  end;
end;
{------------------------------------------------------------------------------}

function TgtCustomPDFDocument.GetPageSize(PageNo: Integer;
  MMUnit: TgtMeasurementUnit): TgtPageSize;
var
  LPDPage: TgtPDPage;
  LRotateAngle: Integer;
begin
  Result.Width := 0;
  Result.Height := 0;

  if Assigned(FPDDoc) then
  begin
    if (PageNo <= 0) or (PageNo > GetPageCount) then
    begin
      raise EInvalidPageError.CreateFmt(SInvalidPageNumber, [PageNo]);
      Exit;
    end;
    //Gets page from PDFProcessor
    LPDPage := FPDDoc.Pages[PageNo];
    if Assigned(LPDPage) then
    begin
    //Returns page size
      LRotateAngle := Abs(GetPageRotate(PageNo));

      if (LRotateAngle = 0) or (LRotateAngle = 180) then
      begin
        Result.Width := ConvertToMU(MMUnit, LPDPage.GetPageSize.Width);
        Result.Height := ConvertToMU(MMUnit, LPDPage.GetPageSize.Height);
      end
      else if (LRotateAngle = 90) or (LRotateAngle = 270) then
      begin
        Result.Width := ConvertToMU(MMUnit, LPDPage.GetPageSize.Height);
        Result.Height := ConvertToMU(MMUnit, LPDPage.GetPageSize.Width);
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}

function TgtCustomPDFDocument.GetPDFVersion: TgtPDFVersion;
begin
  if Assigned(FPDDoc) then
  begin
    case FPDDoc.Version of
      V10: Result := pvPDF10;
      V11: Result := pvPDF11;
      V12: Result := pvPDF12;
      V13: Result := pvPDF13;
      V14: Result := pvPDF14;
      V15: Result := pvPDF15;
      V16: Result := pvPDF16;
      V17: Result := pvPDF17;
    end;
  end;
end;
{------------------------------------------------------------------------------}

procedure TgtCustomPDFDocument.GetTrueTypeFontData(AFont: TFont; var AStream: TMemoryStream);
var
  LDC: HDC;
  LFontStream: Cardinal;
begin
  LDC := GetDC(0);
  SelectObject(LDC, AFont.Handle);
  LFontStream := GetFontData(LDC, 0, 0, nil, 0);
  if LFontStream <> GDI_ERROR then
  begin
    AStream.SetSize(LFontStream);
    GetFontData(LDC, 0, 0, AStream.Memory, LFontStream);
  end;
  ReleaseDC(0, LDC);
end;
{------------------------------------------------------------------------------}

function TgtCustomPDFDocument.GetViewerPreferences: TgtPDFViewerPreferences;
begin
  if not Assigned(FViewerPref) then
    FViewerPref := TgtPDFViewerPreferences.Create(FPDDoc);
  Result := FViewerPref;
end;

{------------------------------------------------------------------------------}

function TgtCustomPDFDocument.GetXMLMetadata: string;
begin
  if Assigned(DocInfo) then
  begin
    Result := DocInfo.GetXMLMetaData;
  end;
end;
{------------------------------------------------------------------------------}

procedure TgtCustomPDFDocument.InsertPagesFrom(FileName, Pages: string;
  InsertAfterPage: Integer);
var
  LPDDoc: TgtPDDocument;
  LPages: TgtPageNumbers;
  LI, LJ: Integer;
begin
  if Assigned(FPDDoc) then
  begin
    //Triggers the OnStatusMessage Event
    if Assigned(FOnStatusMessage) then
      FOnStatusMessage(self, SInsertingPages);
    try
      LPDDoc := TgtPDDocument.Create;
      LPDDoc.LoadDocument(FileName, False);
      //Gets page array from pagerange
      LJ := 0;
      LPages := GetPages(Pages, LPDDoc.PageCount); //Page count to be added
      FInsertPagesObjList := TObjectList.Create(True);
      for LI := 0 to Length(LPages) - 1 do
      begin
        //Calls InsertPages from PDFProcessor
        FPDDoc.InsertPages(InsertAfterPage + LJ, LPDDoc, LPages[LI], 1, InsertAll);
        Inc(LJ);
        //Triggers the OnOperationProgress event
        if Assigned(FOnOperationProgress) then
          FOnOperationProgress(self, opInsert, LI + 1, Length(LPages));
      end;
    finally
      FInsertPagesObjList.Add(LPDDoc);
    end;
  end;
end;
{------------------------------------------------------------------------------}

procedure TgtCustomPDFDocument.InsertWatermark(Template: TgtWatermarkTemplate);
begin
  InsertWatermark(Template, '1-' + IntToStr(PageCount));
end;
{------------------------------------------------------------------------------}

procedure TgtCustomPDFDocument.InsertWatermark(Template: TgtWatermarkTemplate;
  PageRange: string);
var
  LPages: TgtPageNumbers;
  LI, LJ: Integer;
  LRadius: Double;
begin
  if not Assigned(FPDDoc) then Exit;

  LPages := GetPages(PageRange, PageCount);
  for LI := 0 to Length(LPages) - 1 do
  begin
    if Template is TgtTextWatermarkTemplate then
    begin
      AddTextWaterMark(Template as TgtTextWatermarkTemplate, LPages[LI]);
    end
    else if Template is TgtLineWatermarkTemplate then
    begin
      FPDDoc.Pages[LPages[LI]].SetRenderMode(rmOverlay);
      AddLineWaterMark(Template as TgtLineWatermarkTemplate, LPages[LI]);
    end
    else if Template is TgtRectangleWatermarkTemplate then
    begin
      FPDDoc.Pages[LPages[LI]].SetRenderMode(rmOverlay);
      AddRectangleWaterMark(Template as TgtRectangleWatermarkTemplate, LPages[LI]);
    end
    else if Template is TgtCircleWaterMarkTemplate then
    begin
      FPDDoc.Pages[LPages[LI]].SetRenderMode(rmOverlay);
      AddCircleWaterMark(Template as TgtCircleWaterMarkTemplate, LPages[LI]);
    end
    else if Template is TgtEllipseWaterMarkTemplate then
    begin
      FPDDoc.Pages[LPages[LI]].SetRenderMode(rmOverlay);
      AddEllipseWaterMark(Template as TgtEllipseWaterMarkTemplate, LPages[LI]);
    end
    else if Template is TgtPolygonWatermark then
    begin
      FPDDoc.Pages[LPages[LI]].SetRenderMode(rmOverlay);
      AddPolygonWaterMark(Template as TgtPolygonWatermark, LPages[LI]);
    end
    else if Template is TgtCurveWaterMarkTemplate then
    begin
      FPDDoc.Pages[LPages[LI]].SetRenderMode(rmOverlay);
      AddCurveWaterMark(Template as TgtCurveWaterMarkTemplate, LPages[LI]);
    end
    else if Template is TgtImageWatermarkTemplate then
    begin
      AddImageWaterMark(Template as TgtImageWatermarkTemplate, LPages[LI]);
    end
    else if Template is TgtCompositeWatermarkTemplate then
    begin
      with TgtCompositeWatermarkTemplate(Template) do
      begin
        for LJ := 0 to Count - 1 do
          InsertWatermark(WatermarkAt[LJ], PageRange);
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}

function TgtCustomPDFDocument.InvokeSetupDialog: TModalResult;
begin
{$IFDEF gtActiveX}
//  LoadLocalizedStrings;
{$ENDIF}
  if Assigned(FSetupDialog) then
  begin
    FSetupDialog.PDFDoc := Self;
    Application.NormalizeAllTopMosts;
    Result := FSetupDialog.ShowModal;
    Application.RestoreTopMosts;
    FSetupDialog.PDFDoc := nil;
  end
  else
    with TgtPDFSettingsDlg.Create(nil) do
    try
      PDFDoc := Self;
      Result := ShowModal;
    finally
      Free;
    end;
end;
{------------------------------------------------------------------------------}

function TgtCustomPDFDocument.IsFormFieldReadOnly(FieldNo: Integer): Boolean;
begin

end;
{------------------------------------------------------------------------------}

function TgtCustomPDFDocument.IsFormFieldReadOnly(FieldName: string): Boolean;
begin

end;
{------------------------------------------------------------------------------}

procedure TgtCustomPDFDocument.InsertPagesFrom(Document: TgtCustomPDFDocument;
  Pages: string; InsertAfterPage: Integer);
var
  LPages: TgtPageNumbers;
  LI, LJ: Integer;
begin
  if Assigned(FPDDoc) then
  begin
    //Triggers the OnStatusMessage Event
    if Assigned(FOnStatusMessage) then
      FOnStatusMessage(self, SInsertingPages);
    //Gets page array from pagerange
    LPages := GetPages(Pages, PageCount);
    LJ := 0;
    for LI := 0 to Length(LPages) - 1 do
    begin
      //Calls InsertPages from PDFProcessor
      FPDDoc.InsertPages(InsertAfterPage + LJ, Document.FPDDoc, LPages[LI], 1, InsertAll);
      Inc(LJ);
      //Triggers the OnOperationProgress event
      if Assigned(FOnOperationProgress) then
        FOnOperationProgress(self, opInsert, LI + 1, Length(LPages));
    end;
  end;
end;
{------------------------------------------------------------------------------}

function TgtCustomPDFDocument.LoadFromFile(const FileName: string): Boolean;
begin
  if not FileExists(Filename) then
    raise EFileNotFound.Create(ErrFileNotFound);
  if IsLoaded then
    Reset;
  FStream := TFileStream.Create(FileName, fmShareDenyWrite);
  FIsStreamOwned := True;
  Result := LoadFromStream(FStream);
  FWorkFilename := FileName;
  FFilename := FileName;
  FFileSize := FStream.Size;
end;
{------------------------------------------------------------------------------}

function TgtCustomPDFDocument.LoadFromStream(Stream: TStream): Boolean;
var
  LResult: shortint;
  LPassword: AnsiString;
begin
  {$IFDEF COPYPROTECT}
    if not IsReg then
    begin
      if trialPeriodLeft = 0 then
      begin
        Result := False;
        ShowMessage('Trial Period Expired');
        Exit;
      end;
    end;
  {$ENDIF}
  
  if not Assigned(FPDDoc) then
  begin
    FPDDoc := TgtPDDocument.Create;
  end;

  //Already loaded, then reset the document
  if FIsLoaded then
    Reset;
  try
    FPDDoc.LoadDocument(Stream, False);
  except
    on E: ExPasswordRequired do   //On encrypted documents this exception
    begin                        //will be thrown, Hadle this exception and provide the password
      if Assigned(FOnPassword) then
      begin
        Authorize(True);
        LPassword := AnsiString(FPassword);
        FPDDoc.Authorize(FPermissions, LPassword);
        FPassword := LPassword;
        if not FContinue then
        begin
          FContinue := True;
          Exit;
        end;
        LoadFromStream(Stream);
        Exit;
      end;
    end;
  end;
  FIsEncrypted := FPDDoc.IsEncrypted;   //Indicates whether the document is Encrypted or not
  FIsloaded := True;                    //Indicates whether the document is Loaded or not
  FContinue := True;
  Result := FIsLoaded;
  FFileSize := Stream.Size;
end;
{------------------------------------------------------------------------------}
{$IFDEF gtActiveX}

procedure TgtCustomPDFDocument.Paint;
begin
  inherited;
  if assigned(IconBmp) then
    IconBmp.LoadFromResourceID(HInstance, 1);
  Canvas.Draw(2, 2, IconBmp);
end;
{$ENDIF}

procedure TgtCustomPDFDocument.MaskRect(PageNo: Integer; Rect: TRect;
  Color: TColor);
var
  LPDPage: TgtPDPage;
begin
  if Assigned(FPDDoc) then
  begin
    LPDPage := FPDDoc.Pages[PageNo];
    if Assigned(LPDPage) then
    begin
      LPDPage.SetRenderMode(rmOverlay);
      LPDPage.Rectangle(ConvertToPDFUnit(MeasurementUnit, Rect.Left),
        ConvertToPDFUnit(MeasurementUnit, Rect.Top),
        ConvertToPDFUnit(MeasurementUnit, Rect.Right),
        ConvertToPDFUnit(MeasurementUnit, Rect.Bottom));
      LPDPage.SetBrushColor(GetRValue(ColorToRGB(Color)),
        GetGValue(ColorToRGB(Color)), GetBValue(ColorToRGB(Color)));
      LPDPage.FillPath;
    end;
  end;
end;
{------------------------------------------------------------------------------}

procedure TgtCustomPDFDocument.MergeDocs(DocList: TStrings);
var
  LTmpPDDoc: TgtCustomPDFDocument;
  LI, LDocCount: Integer;
  LStartIndex: Integer;
begin
  LStartIndex := 0;
  if not Assigned(FPDDoc) then
    FPDDoc := TgtPDDocument.Create;

  if Assigned(FPDDoc) then
  begin
    if  not Self.IsLoaded then
    begin
      LoadFromFile(DocList[0]);
      LStartIndex := 1;
    end;
    //Trigger the OnStatusMessage event
    if Assigned(OnStatusMessage) then
    begin
      OnStatusMessage(self, Format(SMergingFile,
        [ExtractFileName(DocList.Strings[0])]));
    end;
    if Assigned(FOnOperationProgress) then
      FOnOperationProgress(self, opMerge, 1, DocList.Count);
    LDocCount := DocList.Count;
    FMergeObjectList := TObjectList.Create(True);
    //Load other files from DocList and Merge it to the first file
    for LI := LStartIndex to LDocCount - 1 do
    begin
      if Assigned(OnStatusMessage) then
        OnStatusMessage(self, Format(SMergingFile,
          [ExtractFileName(DocList.Strings[LI])]));
      LTmpPDDoc := TgtCustomPDFDocument.Create(nil);
      try
        LTmpPDDoc.OnPassword := OnPassword;
        LTmpPDDoc.LoadFromFile(DocList.Strings[LI]);
        Self.FPDDoc.InsertPages(Self.PageCount, LTmpPDDoc.FPDDoc, 1, LTmpPDDoc.PageCount, InsertAll);
      finally
        FMergeObjectList.Add(LTmpPDDoc);
      end;
      if Assigned(FOnOperationProgress) then
        FOnOperationProgress(self, opMerge, LI + 1, DocList.Count);
    end;
    if Assigned(OnStatusMessage) then
      OnStatusMessage(self, Format(SNDocumentsMerged, [DocList.Count]));
  end;
end;
{------------------------------------------------------------------------------}

procedure TgtCustomPDFDocument.RemoveFormField(FieldNo: Integer);
var
  LPageIterator, LFieldIterator, LFieldCount: Integer;
begin
  if not Assigned(FPDDoc) then Exit;

  LFieldCount := 1;
  if FFormFieldCount = 0 then
    LFieldCount := 1;
  begin
    for LPageIterator := 1 to FPDDoc.PageCount do
    begin
      for LFieldIterator := 1 to FPDDoc.Pages[LPageIterator].GetFormFieldCount do
      begin
        if LFieldCount = FieldNo then
        begin
          FPDDoc.RemoveFormField(LPageIterator, LFieldIterator);
          Exit;
        end
        else
          LFieldCount := LFieldCount + 1;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}
//
//procedure TgtCustomPDFDocument.RaiseException(AErrNum: ShortInt);
//begin
////  case AErrNum of
////    0: raise E.Create('Error in Processing');
////    ERRFILENOTFOUND: raise EFileNotFound.Create('File Not Found');
////    ERRFILEOPENERROR: raise EFileOpenError.Create('File Open error');
////    ERRPASSWORDREQUIRED: raise EPasswordError.Create('Password Required');
////    ERRINVALIDOBJECT: raise EUnexpectedObjectError.Create('Invalid Object');
////  end;
//end;
{------------------------------------------------------------------------------}

procedure TgtCustomPDFDocument.RegisterLinkedControl(AControl: TControl);
begin
  FLinkedControls.Add(AControl);
end;

procedure TgtCustomPDFDocument.RemoveBookmark;
begin

end;
{------------------------------------------------------------------------------}

procedure TgtCustomPDFDocument.RemoveFormField(FieldName: string);
var
  LPageIterator, LFieldIterator: Integer;
begin
  if not Assigned(FPDDoc) then Exit;

//  if FFormFieldCount <> 0 then
  begin
    for LPageIterator := 1 to FPDDoc.PageCount do
    begin
      for LFieldIterator := FPDDoc.Pages[LPageIterator].GetFormFieldCount downto 1 do
      begin
        if (FPDDoc.GetFormField(LPageIterator, LFieldIterator).FieldName = FieldName) then
        begin
          FPDDoc.RemoveFormField(LPageIterator, FieldName);
          Exit;
        end;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}

procedure TgtCustomPDFDocument.RenameFormField(FieldName, NewName: string);
begin

end;
{------------------------------------------------------------------------------}

function TgtCustomPDFDocument.ReplacePlaceHolders(AText: WideString;
  APageNo: Integer): WideString;
var
  LI, LStart, LEnd: Integer;
  LVarStr, LValStr: WideString;
begin
  Result := AText;
//  if (not CalculateVariables) then Exit;
  if (AText = '') then Exit;
//  if AReplacePageInfo then
//    Result := ReplacePageInfo(Result);
  Result := ReplaceString(Result, CphPageNo, IntToStr(APageNo));
  Result := ReplaceString(Result, CphTotalPages, IntToStr(PageCount));
  Result := ReplaceString(Result, CphShortDate, FormatDateTime(ShortDateFormat, Now));
  Result := ReplaceString(Result, CphShortTime, FormatDateTime(ShortTimeFormat, Now));
  Result := ReplaceString(Result, CphLongDate, FormatDateTime(LongDateFormat, Now));
  Result := ReplaceString(Result, CphLongTime, FormatDateTime(LongTimeFormat, Now));
  Result := ReplaceString(Result, CphAuthor, DocInfo.Author);
  Result := ReplaceString(Result, CphCreator, DocInfo.Creator);
  Result := ReplaceString(Result, CphSubject, DocInfo.Subject);
  Result := ReplaceString(Result, CphTitle, DocInfo.Title);
  //CustomPlaceHolders
  if Assigned(FOnCalcVariables) then
  begin
    LStart := -1;
    while (LStart < Length(Result)) do
    begin
      {$IFDEF gtDelphi7up}
      LStart := PosEx('<%', Result, LStart + 2);
      {$ELSE }
      LStart := PosExx('<%', Result, LStart + 2);
      {$ENDIF}
      if (LStart = 0) then Break;
      {$IFDEF gtDelphi7up}
      LEnd := PosEx('%>', Result, LStart);
      {$ELSE }
      LEnd := PosExx('%>', Result, LStart);
      {$ENDIF}
      if (LEnd = 0) then Break;
      if ((LEnd - LStart) < 3) then
      begin
        LStart := LEnd;
        Continue;
      end;
      {$IFDEF gtDelphi7up}
      LI := PosEx('<%', Result, LStart + 2);
      {$ELSE }
      LI := PosExx('<%', Result, LStart + 2);
      {$ENDIF}
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
      OnCalcVariables(Self, LVarStr, LValStr, APageNo);
      Result := ReplaceString(Result, '<%' + LVarStr + '%>', LValStr);
    end;
  end;
end;
{------------------------------------------------------------------------------}

procedure TgtCustomPDFDocument.RenameFormField(FieldNo: Integer;
  NewName: string);
begin

end;
{------------------------------------------------------------------------------}

procedure TgtCustomPDFDocument.Reset;
begin
  if Assigned(FPDDoc) then
  begin
    FPDDoc.Free;
    FPDDoc := TgtPDDocument.Create;
  end;
  if FIsStreamOwned then
    FreeAndNil(FStream);
  if Assigned(FOutputStream) and FIsSaveStreamOwned then
    FreeAndNil(FOutputStream);
  Self.FIsLoaded := False;
  FTries := 0;
  FPassword := '';
  FFormFieldCount := 0;
  FOutputFilename := '';
  FFilename := '';
  FWorkFilename := ''; 
  with FPermissions do
  begin
    Print := False;
    PrintHighQuality := False;
    ModifyContents := False;
    CopyText := False;
    ModifyTextAnnots := False;
    FillForms := False;
    AssmbleDoc := False;
    PrintToDigitalCopy := False;
    OwnerPassword := '';
    UserPassword := '';
    Level := PDTypes.el40Bits;
    Enable := False;
  end;
  if Assigned(FPDFInfo) then
    FreeAndNil(FPDFInfo);
  if Assigned(FOutlines) then
    FreeAndNil(FOutlines);
  if Assigned(FViewerPref) then
    FreeAndNil(FViewerPref);
end;
{------------------------------------------------------------------------------}

procedure TgtCustomPDFDocument.RotatePages(PageRange: string;
  Angle: TgtRotationAngle);
var
  LPDpage: TgtPDPage;
  Pages: TgtPageNumbers;
  LI, LAngle: Integer;
begin
  if Assigned(FPDDoc) then
  begin
    Pages := GetPages(PageRange, PageCount);
    LAngle := 0;
    //Calculate the angle to be set
    if (Angle = raCW90) or (Angle = raACW270) then
      LAngle := 90
    else if (Angle = raCW180) or (Angle = raACW180) then
      LAngle := 180
    else if (Angle = raCW270) or (Angle = raACW90) then
      LAngle := 270;
    //Rotates pages by the specified angle
    for LI := 0 to Length(Pages) - 1 do
    begin
      LPDpage := FPDDoc.Pages[pages[LI]];
      LPDpage.Rotate := LAngle;
    end;
  end
  else
    Exit;
end;
{------------------------------------------------------------------------------}
type
THackFileStream = class(TFileStream)

end;

procedure TgtCustomPDFDocument.SaveDoc(Stream: TStream; SaveFlags: TgtPDSaveFlags);
var
  LStatus: TModalResult;
  LWatermark: TgtTextWatermarkTemplate;
  LCurrUnit: TgtMeasurementUnit;
  LPassword: AnsiString;
{$IFDEF EMailSupport}
  LContinue, LCancelEmail: Boolean;
{$ENDIF}
{$IFDEF EMailWithIndy}
  LI: Integer;
  IdMessage: TIdMessage;
  IdSMTP: TIdSMTP;
  function GetAddressString(AText: string): string;
  begin
    Result := Trim(AText);
    Result := StringReplace(Result, CRLF, ';', [rfReplaceAll]);
    if (Result <> '') and (Result[Length(Result)] = ';') then
      System.Delete(Result, Length(Result), 1);
  end;
{$ENDIF}
begin
//Begining of SaveToFile
  if not Assigned(FPDDoc) then Exit;

  if ShowSetupDialog then
  begin
    LStatus := InvokeSetupDialog();
    if (LStatus = mrCancel) then
      exit;
  end;

  //Triggers the OnStatusMessage event
  if Assigned(OnStatusMessage) then
    OnStatusMessage(self, Format(SSavingFile, [FOutputFilename]));

{$IFNDEF gtRegistered}
  //Stamp a trial mark
  LCurrUnit := MeasurementUnit;
  MeasurementUnit := muPoints;
  LWatermark := TgtTextWatermarkTemplate.Create;
  StampTrialMark(LWatermark);
  LWatermark.VertPos := vpTop;
  InsertWatermark(LWatermark);
  LWatermark.VertPos := vpBottom;
  InsertWatermark(LWatermark);
  MeasurementUnit := LCurrUnit;
  if Assigned(LWatermark) then
    FreeAndNil(LWatermark);
{$ENDIF}

  //Save the document the file
  Authorize(False);
  LPassword := AnsiString(FPassword);
  FPDDoc.Authorize(FPermissions, LPassword);
  FPassword := LPassword;
  FPDDoc.SaveDocument(Stream, SaveFlags);

  FIsLoaded := False;
  //If MergeDocs is called then free all the stray objects
  if Assigned(FMergeObjectList) then
  begin
    FMergeObjectList.Free;
    FMergeObjectList := nil;
  end;

  if Assigned(FAppendPagesObjList) then
  begin
    FAppendPagesObjList.Free;
    FAppendPagesObjList := nil;
  end;

   if Assigned(FAppendPagesObjList) then
  begin
    FInsertPagesObjList.Free;
    FInsertPagesObjList := nil;
  end;

  //Trigger save complete event
  if Assigned(OnStatusMessage) then
    OnStatusMessage(self, SSaveComplete);

  if FIsSaveStreamOwned and (Stream is TFileStream) then
  begin
    FreeAndNil(Stream);
    FIsSaveStreamOwned := False;
  end;
      
  //Open the file after saving
  if FOpenAfterSave then
    ShellExecute(Application.Handle, 'Open', PChar(FOutputFilename), nil, nil, SW_SHOWNORMAL);

{$IFDEF EMailSupport}
  {Email created document}
  if EMailAfterSave and (FOutputFilename <> '') then
  begin
    FEmailInfo.Attachments.Add(FOutputFilename);
    LContinue := False;
    LCancelEmail := False;
    repeat
{$IFDEF EMailWithFastNet}
        // Trigger OnEMail Event.
      if Assigned(FOnEMail) then
        FOnEMail(Self, FEMailInfo, LContinue, LCancelEmail);
      if LCancelEmail then
        Break;
      with TNMSMTP.Create(nil) do
      try
     { Assign user event handlers to E-Mail component. }
        OnConnect := OnEMailConnect;
        OnConnectionFailed := OnEMailConnectionFailed;
        OnDisconnect := OnEMailDisConnect;
        OnInvalidHost := OnEMailInvalidHost;
        OnFailure := OnEMailFailure;
        OnSendStart := OnEMailSendStart;
        OnStatus := OnEMailStatus;
        OnSuccess := OnEMailSuccess;

        Host := FEMailInfo.FHost;
        UserID := FEMailInfo.FUserID;
        PostMessage.Attachments.Assign(FEMailInfo.FAttachments);
        PostMessage.Body.Assign(FEMailInfo.FBody);
        PostMessage.Date := DateToStr(FEMailInfo.FDate);
        PostMessage.FromName := FEMailInfo.FFromName;
        PostMessage.FromAddress := FEMailInfo.FFromAddress;
        PostMessage.ReplyTo := FEMailInfo.FReplyTo;
        PostMessage.Subject := FEMailInfo.FSubject;
        PostMessage.ToAddress.Assign(FEMailInfo.FRecipientList);
        PostMessage.ToCarbonCopy.Assign(FEMailInfo.FCCList);
        PostMessage.ToBlindCarbonCopy.Assign(FEMailInfo.FBCCList);
        try
          Connect;
          SendMail;
        except
          on E: Exception do
          begin
            if Assigned(OnEMailError) then
              OnEMailError(Self, E.Message);
            LContinue := False;
          end;
        end;
      finally
        Disconnect;
        Free;
      end;
{$ELSE}
{$IFDEF EMailWithIndy}
        // Trigger OnEMail Event.
      if Assigned(FOnEMail) then
        FOnEMail(Self, FEMailInfo, LContinue, LCancelEmail);
      if LCancelEmail then
        Break;
      IdMessage := TIdMessage.Create(nil);
      IdSMTP := TIdSMTP.Create(nil);
      with IdMessage do
      try
     { Assign user event handlers to E-Mail component. }
{$IFDEF Indy900Up}
{$IFDEF Indy1000Up}
        IdSMTP.OnConnected := OnEMailConnected;
{$ENDIF}
{$ENDIF}
        IdSMTP.OnDisconnected := OnEMailDisConnected;
        IdSMTP.OnStatus := OnEMailStatus;
        IdSMTP.Port := FEMailInfo.Port;
        IdSMTP.Host := FEMailInfo.FHost;
{$IFDEF Indy1000Up}
        IdSMTP.PipeLine := False;
        if (FEMailInfo.AuthenticationRequired) then
        begin
          IdSMTP.AuthType := atDefault;
          IdSMTP.UseEhlo := True;
        end
        else
        begin
          IdSMTP.AuthType := atNone;
          IdSMTP.UseEhlo := False;
        end;
{$ELSE}
        if (FEMailInfo.AuthenticationRequired) then
          IdSMTP.AuthenticationType := atLogin
        else
          IdSMTP.AuthenticationType := atNone;
{$ENDIF}

{$IFDEF Indy900Up}
{$IFDEF Indy1000Up}
        IdSMTP.UserID := FEMailInfo.FUserID;
{$ENDIF}
{$ELSE}
        IdSMTP.UserName := FEMailInfo.FUserID;
{$ENDIF}
        IdSMTP.Password := FEMailInfo.FPassword;

        for LI := 0 to FEMailInfo.FAttachments.Count - 1 do
{$IFDEF Indy1000Up}
          TIDAttachmentfile.Create(MessageParts, FEMailInfo.FAttachments[LI]);
{$ELSE}
        TIDAttachment.Create(MessageParts, FEMailInfo.FAttachments[LI]);
{$ENDIF}

        Body.Assign(FEMailInfo.FBody);
        UseNowForDate := True;
        FEmailInfo.Date :=  Now;
        Date := FEMailInfo.FDate;
        From.Name := FEMailInfo.FFromName;
        From.Text := FEMailInfo.FFromAddress;
        ReplyTo.EMailAddresses := FEMailInfo.FReplyTo;
        Subject := FEMailInfo.FSubject;
        Recipients.EMailAddresses := GetAddressString(FEMailInfo.FRecipientList.Text);
        CCList.EMailAddresses := GetAddressString(FEMailInfo.FCCList.Text);
        BCCList.EMailAddresses := GetAddressString(FEMailInfo.FBCCList.Text);
        try
          IdSMTP.Connect;
          IdSMTP.Send(IdMessage);
      // Trigger OnEMailSuccess Event.
          if Assigned(OnEMailSuccess) then
            OnEMailSuccess(Self);
        except
          on E: Exception do
          begin
       // Trigger OnEMailError Event.
            if Assigned(OnEMailError) then
              OnEMailError(Self, E.Message);
            LContinue := False;
          end;
        end;
      finally
        IdSMTP.DisConnect;
        IdSMTP.Free;
        Free;
      end;
{$ENDIF}
{$ENDIF}
    until not LContinue;
  end;
{$ENDIF}

//End of SaveToFile
end;
{------------------------------------------------------------------------------}

procedure TgtCustomPDFDocument.SaveToFile(const FileName: string;
  NeedAppearance: TgtNeedAppearanceState);
begin
  SaveToFile(FileName);
end;
{------------------------------------------------------------------------------}

procedure TgtCustomPDFDocument.SaveToStream(Stream: TStream; aIncremental: Boolean);
var
  LSaveFlags: TgtPDSaveFlags;
begin
  with LSaveFlags do
  begin
    Full := not aIncremental;
    Copy := False;
    Incremental := aIncremental;
    Linearize := False;
    UniDirectional := False;
    KeepModDate := False;
    Compressed := False;
  end;
  SaveDoc(Stream, LSaveFlags);
end;
{------------------------------------------------------------------------------}
//(*
//procedure TgtCustomPDFDocument.SetCalculateVariables(const Value: Boolean);
//begin
//  FCalculateVariables := Value;
//end;
//*)
{------------------------------------------------------------------------------}

procedure TgtCustomPDFDocument.SetAbout(const Value: string);
begin
  //
end;

procedure TgtCustomPDFDocument.SetCMapPath(const Value: string);
begin
  FPDDoc.CMapPath := Value;
end;

procedure TgtCustomPDFDocument.SetComVersion(const Value: string);
begin
  //
end;

procedure TgtCustomPDFDocument.SetEmailInfo(const Value: TgtEMailInfo);
begin
  EMailInfo := Value;
end;
{------------------------------------------------------------------------------}

procedure TgtCustomPDFDocument.SetFilename(const Value: string);
begin
  if Value <> '' then
  begin
    FFilename := Value;
    LoadFromFile(Value);
  end
  else
    FFilename := '';
end;
{------------------------------------------------------------------------------}

procedure TgtCustomPDFDocument.SetFormFieldReadOnly(FieldName: string;
  Value: Boolean);
begin

end;
{------------------------------------------------------------------------------}

procedure TgtCustomPDFDocument.SetFormFieldReadOnly(FieldNo: Integer;
  Value: Boolean);
begin

end;
{------------------------------------------------------------------------------}

procedure TgtCustomPDFDocument.SetFormFields(Data: TStringList);
var
  LPageIterator, LFieldIterator, LFieldCount: Integer;
  LFormField: TgtPDFormField;
begin
  if not Assigned(FPDDoc) then Exit;

  LFieldCount := 0;
  if FFormFieldCount <> 0 then
  begin
    for LFieldCount := 0 to Data.Count - 1 do
    begin
      for LPageIterator := 1 to FPDDoc.PageCount do
      begin
        for LFieldIterator := 1 to FPDDoc.Pages[LPageIterator].GetFormFieldCount do
        begin
          LFormField := FPDDoc.GetFormField(LPageIterator, LFieldIterator);
          if (LFormField.FieldName = Data.Names[LFieldCount]) then
          begin
            with LFormField do
            begin
              if FormFieldType = PDFormField.ftText then
                Value := Data.Values[Data.Names[LFieldCount]]
              else if (FormFieldType = PDFormField.ftCheckBox) then
              begin
                if (Data.Values[Data.Names[LFieldCount]] = TgtPDFormCheckBox(LFormField).Option[0]) then
                  Value := Data.Values[Data.Names[LFieldCount]]
                else if (Data.Values[Data.Names[LFieldCount]] = TgtPDFormCheckBox(LFormField).Option[1]) then
                  Value := Data.Values[Data.Names[LFieldCount]]
              end
              else if (FormFieldType = PDFormField.ftRadio) then
                Value := Data.Values[Data.Names[LFieldCount]]
              else if (FormFieldType = PDFormField.ftButton) then
                Value := Data.Values[Data.Names[LFieldCount]]
              else if (FormFieldType = PDFormField.ftSignature) then
                Value := Data.Values[Data.Names[LFieldCount]]
              else if (FormFieldType = PDFormField.ftListBox) then
                Value := Data.Values[Data.Names[LFieldCount]]
              else if (FormFieldType = PDFormField.ftComboBox) then
                Value := Data.Values[Data.Names[LFieldCount]];
            end;
          end;
        end;
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}

procedure TgtCustomPDFDocument.SetFormFieldValue(FieldName: string;
  Value: WideString);
begin

end;
{------------------------------------------------------------------------------}

procedure TgtCustomPDFDocument.SetFormFieldValue(FieldNo: Integer;
  Value: WideString);
begin

end;
{------------------------------------------------------------------------------}

procedure TgtCustomPDFDocument.SetPageCropBox(PageRange: string;
  CropRect: TgtRect);
var
  LPages: TgtPageNumbers;
  Li: Integer;
begin
  if not Assigned(FPDDoc) then Exit;

  CropRect.Left := ConvertToPDFUnit(FMeasurementUnit, CropRect.Left);
  CropRect.Top := ConvertToPDFUnit(FMeasurementUnit, CropRect.Top);
  CropRect.Right := ConvertToPDFUnit(FMeasurementUnit, CropRect.Right);
  CropRect.Bottom := ConvertToPDFUnit(FMeasurementUnit, CropRect.Bottom);

  LPages := GetPages(PageRange, PageCount);
  for Li := 1 to Length(LPages) do
  begin
    if Assigned(FPDDoc.Pages[Li].CropBox) then
    begin
      with FPDDoc.Pages[Li].CropBox do
      begin
        Left := CropRect.Left;
        Top := CropRect.Top;
        Right := CropRect.Right;
        Bottom := CropRect.Bottom;
      end;
    end
    else
    begin
      FPDDoc.Pages[Li].SetCropBox(CropRect.Left, CropRect.Top,
        CropRect.Right, CropRect.Bottom);
    end;
  end;
end;
{------------------------------------------------------------------------------}

procedure TgtCustomPDFDocument.SetPageLayout(const Value: TgtPageLayout);
var
  LPDPageLayout: TgtPDLayoutMode;
begin
  if not Assigned(FPDDoc) then Exit;

  case Value of
    plNone: LPDPageLayout := PDTypes.lmNone;
    plSinglePage: LPDPageLayout := PDTypes.lmSinglePage;
    plOneColumn: LPDPageLayout := PDTypes.lmOneColumn;
    plTwoColumnLeft: LPDPageLayout := PDTypes.lmTwoColumnLeft;
    plTwoColumnRight: LPDPageLayout := PDTypes.lmTwoColumnRight;
    plTwoPageLeft: LPDPageLayout := PDTypes.lmTwoPageLeft;
    plTwoPageRight: LPDPageLayout := PDTypes.lmTwoPageRight;
  end;
  FPDDoc.SetLayoutMode(LPDPageLayout);
end;
{------------------------------------------------------------------------------}

procedure TgtCustomPDFDocument.SetPageMode(mode: TgtPageMode);
var
  LPDPageMode: TgtPDPageMode;
begin
  LPDPageMode := PDTypes.pmnone;
  case mode of
    pmNone: LPDPageMode := PDTypes.pmnone;
    pmUseOutlines: LPDPageMode := PDTypes.pmUseBookmarks;
    pmUseThumbs: LPDPageMode := PDTypes.pmUseThumbs;
    pmFullScreen: LPDPageMode := PDTypes.pmFullScreen;
    pmUseAttachments: LPDPageMode := pmAttachmentsVisible;
    pmUseOC: LPDPageMode := pmOCVisible;
  end;
  FPDDoc.SetPageMode(LPDPageMode);
end;
{------------------------------------------------------------------------------}

procedure TgtCustomPDFDocument.SetPageMediaBox(PageRange: string;
  PageRect: TgtRect);
var
  LPages: TgtPageNumbers;
  Li: Integer;
begin
  if not Assigned(FPDDoc) then Exit;

  PageRect.Left := ConvertToMU(FMeasurementUnit, PageRect.Left);
  PageRect.Top := ConvertToMU(FMeasurementUnit, PageRect.Top);
  PageRect.Right := ConvertToMU(FMeasurementUnit, PageRect.Right);
  PageRect.Bottom := ConvertToMU(FMeasurementUnit, PageRect.Bottom);

  LPages := GetPages(PageRange, PageCount);

  for Li := 1 to Length(LPages) do
  begin
    if Assigned(FPDDoc.Pages[Li].MediaBox) then
    begin
      with FPDDoc.Pages[Li].MediaBox do
      begin
        Left := PageRect.Left;
        Top := PageRect.Top;
        Right := PageRect.Right;
        Bottom := PageRect.Bottom;
      end;
    end
    else
    begin
      FPDDoc.Pages[Li].SetMediaBox(PageRect.Left, PageRect.Top, PageRect.Right,
        PageRect.Bottom);
    end;
  end;
end;
{------------------------------------------------------------------------------}

procedure TgtCustomPDFDocument.SetPageTransitionEffect(PageRange: string;
  Duration: Single; TransitionEffect: TgtTransitionEffect);
var
  LPages: TgtPageNumbers;
  Li: Integer;
  LTransitionEffect: TgtPDTransitionEffect;
begin
  if not Assigned(FPDDoc) then Exit;

  LPages := GetPages(PageRange, PageCount);

  case TransitionEffect of
    teNone: LTransitionEffect := PDTypes.teNone;
    teSplitHorizontalInward: LTransitionEffect := PDTypes.teSplitHorizontalInward;
    teSplitHorizontalOutward: LTransitionEffect := PDTypes.teSplitHorizontalOutward;
    teSplitVerticalInward: LTransitionEffect := PDTypes.teSplitVerticalInward;
    teSplitVerticalOutward: LTransitionEffect := PDTypes.teSplitVerticalOutward;
    teBlindsHorizontal: LTransitionEffect := PDTypes.teBlindsHorizontal;
    teBlindsVertical: LTransitionEffect := PDTypes.teBlindsVertical;
    teBoxInward: LTransitionEffect := PDTypes.teBoxInward;
    teBoxOutward: LTransitionEffect := PDTypes.teBoxOutward;
    teWipeLeftToRight: LTransitionEffect := PDTypes.teWipeLeftToRight;
    teWipeBottomToTop: LTransitionEffect := PDTypes.teWipeBottomToTop;
    teWipeRightToLeft: LTransitionEffect := PDTypes.teWipeRightToLeft;
    teWipeTopToBottom: LTransitionEffect := PDTypes.teWipeTopToBottom;
    teDissolve: LTransitionEffect := PDTypes.teDissolve;
    teGlitterLeftToRight: LTransitionEffect := PDTypes.teGlitterLeftToRight;
    teGlitterTopToBottom: LTransitionEffect := PDTypes.teGlitterTopToBottom;
    teGlitterTopLeftToBottomRight: LTransitionEffect := PDTypes.teGlitterTopLeftToBottomRight;
  end;
  for Li := 0 to Length(LPages) - 1 do
  begin
    FPDDoc.Pages[LPages[Li]].SetPageTransitionEffect(Duration, LTransitionEffect);
  end;

end;
{------------------------------------------------------------------------------}

procedure TgtCustomPDFDocument.SetPDFVersion(const Value: TgtPDFVersion);
begin
  if not Assigned(FPDDoc) then Exit;

  case value of
    pvPDF10: FPDDoc.Version := V10;
    pvPDF11: FPDDoc.Version := V11;
    pvPDF12: FPDDoc.Version := V12;
    pvPDF13: FPDDoc.Version := V13;
    pvPDF14: FPDDoc.Version := V14;
    pvPDF15: FPDDoc.Version := V15;
    pvPDF16: FPDDoc.Version := V16;
    pvPDF17: FPDDoc.Version := V17;
  end;
end;
{------------------------------------------------------------------------------}

procedure TgtCustomPDFDocument.SetWorkFileName(const Value: string);
begin
  FWorkFilename := Value;
end;
{------------------------------------------------------------------------------}

{$IFNDEF gtRegistered}
procedure TgtCustomPDFDocument.StampTrialMark(var AWaterMark: TgtTextWatermarkTemplate);
begin
  with AWaterMark do
  begin
    Overlay := True;
    Text := 'Gnostice PDFtoolkit 3.0';
    Font.Name := 'Verdana';
    Font.Size := 20;
    Font.Color := clRed;
    Font.Style := [fsBold];
    HorizPos := hpCenter;
  end;
end;
{$ENDIF}

{$IFDEF COPYPROTECT}
{$I ..\..\PDFProcessor\Source\PDFProcessorDLL\gtActivateLicense.inc}
function TgtCustomPDFDocument._ActivateLicense(const RegName: widestring;
  const RegKey: widestring): Boolean;
begin

  // Retuns True if activated or trial period is left
  try
    if (activateLicense(PWideChar(RegName), PWideChar(RegKey)) = ACOK) then
      Result := True
    else
    begin
     if trialperiodLeft = 0 then
        Result := False
     else
      Result := True;
    end;
  except
    Result := False;
  end;
end;
{$ENDIF}

{------------------------------------------------------------------------------}
procedure TgtCustomPDFDocument.UnRegisterLinkedControl(AControl: TControl);
begin
  FLinkedControls.Delete(FLinkedControls.IndexOf(AControl));
end;
{------------------------------------------------------------------------------}

procedure TgtCustomPDFDocument.SaveToStream(Stream: TStream;
  NeedAppearance: TgtNeedAppearanceState);
begin
  SaveToStream(Stream);
end;
{------------------------------------------------------------------------------}

procedure TgtCustomPDFDocument.SaveToFile(const FileName: string; aIncremental: Boolean);
var
  LSaveFlags: TgtPDSaveFlags;
begin
  try
    FOutputStream := TFileStream.Create(FileName, fmCreate);
    FIsSaveStreamOwned := True;
    FOutputFilename := FileName;
  except
    on E: Exception do
      raise EFileOpenError.Create('Could not create file');
  end;
  with LSaveFlags do
  begin
    Full := not aIncremental;
    Copy := False;
    Incremental := aIncremental;
    Linearize := False;
    UniDirectional := False;
    KeepModDate := False;
    Compressed := False;
  end;

  SaveDoc(FOutputStream, LSaveFlags);
  if FIsSaveStreamOwned then
    FreeAndNil(FOutputStream);
end;

{------------------------------------------------------------------------------}
{ TgtEMailInfo }

constructor TgtEMailInfo.Create;
begin
  FAttachments := TStringList.Create;
  FBody := TStringList.Create;
  FRecipientList := TStringList.Create;
  FBCCList := TStringList.Create;
  FCCList := TStringList.Create;
  FPort := 25;
end;
{------------------------------------------------------------------------------}

destructor TgtEMailInfo.Destroy;
begin
  FreeAndNil(FAttachments);
  FreeAndNil(FBody);
  FreeAndNil(FRecipientList);
  FreeAndNil(FBCCList);
  FreeAndNil(FCCList);
  inherited;
end;
{------------------------------------------------------------------------------}

{ TgtPDFInfo }

function TgtPDFInfo.GetAuthor: WideString;
begin
  Result := FPDInfo.Author;
  if IsHex(Result) then
  begin
    Result := UnicodeHexToString(Result);
  end;
end;
{------------------------------------------------------------------------------}

function TgtPDFInfo.GetCreationDate: string;
begin
  Result := FPDInfo.CreateDate;
  if IsHex(Result) then
  begin
    Result := UnicodeHexToString(Result);
  end;
end;
{------------------------------------------------------------------------------}

function TgtPDFInfo.GetCreator: WideString;
begin
  Result := FPDInfo.Creator;
  if IsHex(Result) then
  begin
    Result := UnicodeHexToString(Result);
  end;
end;
{------------------------------------------------------------------------------}

function TgtPDFInfo.GetKeywords: WideString;
begin
  Result := FPDInfo.Keyword;
  if IsHex(Result) then
  begin
    Result := UnicodeHexToString(Result);
  end;
end;
{------------------------------------------------------------------------------}

function TgtPDFInfo.GetModDate: string;
begin
  Result := FPDInfo.ModeDate;
  if IsHex(Result) then
  begin
    Result := UnicodeHexToString(Result);
  end;
end;
{------------------------------------------------------------------------------}

function TgtPDFInfo.GetProducer: WideString;
begin
  Result := FPDInfo.Producer;
  if IsHex(Result) then
  begin
    Result := UnicodeHexToString(Result);
  end;
end;
{------------------------------------------------------------------------------}

function TgtPDFInfo.GetSubject: WideString;
begin
  Result := FPDInfo.Subject;
  if IsHex(Result) then
  begin
    Result := UnicodeHexToString(Result);
  end;
end;
{------------------------------------------------------------------------------}

function TgtPDFInfo.GetTitle: WideString;
begin
  Result := FPDInfo.Title;
  if IsHex(Result) then
  begin
    Result := UnicodeHexToString(Result);
  end;
end;
{------------------------------------------------------------------------------}

function TgtPDFInfo.GetXMLMetaData: string;
begin
  Result := FPDInfo.GetXMLMetaData;
end;
{------------------------------------------------------------------------------}

procedure TgtPDFInfo.SetAuthor(const Value: WideString);
begin
  FPDInfo.Author := Value;
end;
{------------------------------------------------------------------------------}

procedure TgtPDFInfo.SetCreationDate(const Value: string);
begin
  FPDInfo.CreateDate := Value;
end;
{------------------------------------------------------------------------------}
procedure TgtPDFInfo.SetCreator(const Value: WideString);
begin
  FPDInfo.Creator := Value;
end;
{------------------------------------------------------------------------------}
procedure TgtPDFInfo.SetKeywords(const Value: WideString);
begin
  FPDInfo.Keyword := Value;
end;
{------------------------------------------------------------------------------}
procedure TgtPDFInfo.SetModDate(const Value: string);
begin
  FPDInfo.ModeDate := Value;
end;
{------------------------------------------------------------------------------}
procedure TgtPDFInfo.SetSubject(const Value: WideString);
begin
  FPDInfo.Subject := Value;
end;
{------------------------------------------------------------------------------}
procedure TgtPDFInfo.SetTitle(const Value: WideString);
begin
  FPDInfo.Title := Value;
end;
{------------------------------------------------------------------------------}
function GetPages(PageRange: string; PageCount: Integer): TgtPageNumbers;
var
  LStrLst: TStringList;
  LI, LCnt: Integer;
  LPageNo: Integer;
  LTemp: Integer;
  LRange1, LRange2, LTmpStr: string;
  LLeftRange, LRightRange: Integer;
begin
  LRightRange := 0;
  LLeftRange := 0;
  if PageRange = '' then
    PageRange := '1-' + IntToStr(PageCount);
  try
    LStrLst := TStringList.Create;
    LStrLst.CommaText := PageRange;
    LCnt := 0;
    // if string is not found then zero is returned
    for LI := 0 to LStrLst.Count - 1 do
    // Checking the position of the '-' using the System.pos and returning it status to Ltemp
    begin
      LTemp := System.Pos('-', LStrLst.Strings[LI]);
      if LTemp = 0 then
      begin
        if not TryStrToInt(LStrLst.Strings[LI], LPageNo) then
        begin
          LTmpStr := LStrLst.Strings[LI];
          FreeAndNil(LStrLst);
          raise EInvalidPageError.CreateFmt(SInvalidPageRange, [PageRange]);
        end;

        if ((LPageNo < 1) or (LPageNo > PageCount)) then
        begin
          FreeAndNil(LStrLst);
          raise EInvalidPageError.CreateFmt(SInvalidPageNumber, [LPageNo]);
        end;
        // Storing it into Result variable and Dynamically Expanding the string
        SetLength(Result, LCnt + 1);
        Result[LCnt] := LPageNo;
        Inc(LCnt);

      end // End of Ltemp checking Condition
      else
      begin
        // Extracting the left Range and Right range
        LRange1 := Trim(gtPDFUtils.LeftStr(LStrLst.Strings[LI], LTemp - 1));
        if LRange1 = '' then
          LRange1 := '1';
        LRange2 := Trim(gtPDFUtils.RightStr(LStrLst.Strings[LI],
          Length(LStrLst.Strings[LI]) - LTemp));
        if LRange2 = '' then
          LRange2 := IntToStr(PageCount);

        if not TryStrToInt(LRange1, LPageNo) then
        begin
          LTmpStr := LStrLst.Strings[LI];
          FreeAndNil(LStrLst);
          raise EInvalidPageError.CreateFmt(SInvalidPageRange, [PageRange]);
        end
        else
          LLeftRange := StrToInt(LRange1);

        if not TryStrToInt(LRange2, LPageNo) then
        begin
          LTmpStr := LStrLst.Strings[LI];
          FreeAndNil(LStrLst);
          raise EInvalidPageError.CreateFmt(SInvalidPageRange, [PageRange]);
        end
        else
        begin
          if (LRange2 = SP) or (LRange2 = '') or (LRange2 = CR) or (LRange2 = LF)
            or (LRange2 = nul) then
            LRightRange := PageCount
          else
            LRightRange := StrToInt(LRange2);
        end;
        // Checking left and right range
        if (LLeftRange < 1) or (LLeftRange > LRightRange) then
        begin
          LTmpStr := LStrLst.Strings[LI];
          FreeAndNil(LStrLst);
          raise EInvalidPageError.CreateFmt(SInvalidPageRange, [LTmpStr])
        end
        else
        begin
          SetLength(Result, LCnt + (LRightRange - LLeftRange + 1));
          // Checking right range is greater or not the maximum value
          if LRightRange > PageCount then
          begin
            LTmpStr := LStrLst.Strings[LI];
            FreeAndNil(LStrLst);
            raise EInvalidPageError.CreateFmt(SInvalidPageRange, [LTmpStr]);
          end;
          // storing page no in the result set
          for LPageNo := LLeftRange to LRightRange do
          begin
            Result[LCnt] := LPageNo;
            Inc(LCnt);
          end;
        end;
      end;
    end;
  finally
    // freeing the LStrLst class
    FreeAndNil(LStrLst);
  end;
end;
{------------------------------------------------------------------------------}

{ TgtPDFDestination }

constructor TgtPDFDestination.Create;
begin
  PageNo := 1;
  FDestination := TgtPDDestination.Create;
  FToFree := True;
  case DestinationType of
    dtXYZ: FDestination.DisplayOptions := FitZoom;
    dtFit: FDestination.DisplayOptions :=  FitAll;
    dtFitH: FDestination.DisplayOptions := FitHeight;
    dtFitV: FDestination.DisplayOptions := FitWidth;
    dtFitR: FDestination.DisplayOptions :=  FitRect;
    dtFitB: FDestination.DisplayOptions := FitBoundingBox;
    dtFitBH: FDestination.DisplayOptions := FitBoundingBoxHeight;
    dtFitBV: FDestination.DisplayOptions := FitBoundingBoxWidth;
  end;
end;
{------------------------------------------------------------------------------}

constructor TgtPDFDestination.Create(PageNo: Integer;
  DestinationType: TgtPDFDestinationType);
begin
  FDestination := TgtPDDestination.Create;
  FToFree := True;
  FPageNo := PageNo;

  case DestinationType of
    dtXYZ: FDestination.DisplayOptions := FitZoom;
    dtFit: FDestination.DisplayOptions := FitAll;
    dtFitH: FDestination.DisplayOptions := FitHeight;
    dtFitV: FDestination.DisplayOptions := FitWidth;
    dtFitR: FDestination.DisplayOptions := FitRect;
    dtFitB: FDestination.DisplayOptions := FitBoundingBox;
    dtFitBH: FDestination.DisplayOptions := FitBoundingBoxHeight;
    dtFitBV: FDestination.DisplayOptions := FitBoundingBoxWidth;
  end;
end;
{------------------------------------------------------------------------------}

constructor TgtPDFDestination.Create(PageNo: Integer;
  DestinationType: TgtPDFDestinationType; Left, Top, Zoom: Double);
begin
  FDestination := TgtPDDestination.Create;
  FToFree := True;
  FPageNo := PageNo;
  TgtPDRect(FDestination.Rect).Left := Left;
  TgtPDRect(FDestination.Rect).Top := Top;
  TgtPDRect(FDestination.Rect).Bottom := -1;
  TgtPDRect(FDestination.Rect).Right := -1;
  TgtPDRect(FDestination.Rect).Right := Zoom;
  case DestinationType of
    dtXYZ: FDestination.DisplayOptions := FitZoom;
    dtFit: FDestination.DisplayOptions := FitAll;
    dtFitH: FDestination.DisplayOptions := FitHeight;
    dtFitV: FDestination.DisplayOptions := FitWidth;
    dtFitR: FDestination.DisplayOptions := FitRect;
    dtFitB: FDestination.DisplayOptions := FitBoundingBox;
    dtFitBH: FDestination.DisplayOptions := FitBoundingBoxHeight;
    dtFitBV: FDestination.DisplayOptions := FitBoundingBoxWidth;
  end;
end;
{------------------------------------------------------------------------------}

constructor TgtPDFDestination.Create(PageNo: Integer;
  DestinationType: TgtPDFDestinationType; TopOrLeft: Double);
begin
  FDestination := TgtPDDestination.Create;
  FToFree := True;
  FPageNo := PageNo;
  TgtPDRect(FDestination.Rect).Left := Left;
  TgtPDRect(FDestination.Rect).Top := Top;
  case DestinationType of
    dtXYZ: FDestination.DisplayOptions := FitZoom;
    dtFit: FDestination.DisplayOptions := FitAll;
    dtFitH: FDestination.DisplayOptions := FitHeight;
    dtFitV: FDestination.DisplayOptions := FitWidth;
    dtFitR: FDestination.DisplayOptions := FitRect;
    dtFitB: FDestination.DisplayOptions := FitBoundingBox;
    dtFitBH: FDestination.DisplayOptions := FitBoundingBoxHeight;
    dtFitBV: FDestination.DisplayOptions := FitBoundingBoxWidth;
  end;
end;
{------------------------------------------------------------------------------}

constructor TgtPDFDestination.Create(PageNo: Integer;
  DestinationType: TgtPDFDestinationType; Left, Bottom, Right, Top: Double);
begin
  FPageNo := PageNo;
  FDestination := TgtPDDestination.Create;
  FToFree := True;
  FDestination.Rect.Left := Left;
  FDestination.Rect.Right := Right;
  FDestination.Rect.Top := Top;
  FDestination.Rect.Bottom := Bottom;
  case DestinationType of
    dtXYZ: FDestination.DisplayOptions := FitZoom;
    dtFit: FDestination.DisplayOptions := FitAll;
    dtFitH: FDestination.DisplayOptions := FitHeight;
    dtFitV: FDestination.DisplayOptions := FitWidth;
    dtFitR: FDestination.DisplayOptions := FitRect;
    dtFitB: FDestination.DisplayOptions := FitBoundingBox;
    dtFitBH: FDestination.DisplayOptions := FitBoundingBoxHeight;
    dtFitBV: FDestination.DisplayOptions := FitBoundingBoxWidth;
  end;
end;
{------------------------------------------------------------------------------}

destructor TgtPDFDestination.Destroy;
begin
  if FToFree and Assigned(FDestination) then
    FreeAndNil(FDestination);
  inherited;
end;
{------------------------------------------------------------------------------}


function TgtPDFDestination.GetRight: Double;
begin
  Result := FDestination.Rect.Right;
end;
{------------------------------------------------------------------------------}

function TgtPDFDestination.GetTop: Double;
begin
  Result := FDestination.Rect.Top;
end;
{------------------------------------------------------------------------------}
function TgtPDFDestination.GetBottom: Double;
begin
  Result := FDestination.Rect.Bottom;
end;
{------------------------------------------------------------------------------}
function TgtPDFDestination.GetLeft: Double;
begin
  Result := FDestination.Rect.Left;
end;
{------------------------------------------------------------------------------}

function TgtPDFDestination.GetDestinationType: TgtPDFDestinationType;
begin
  Result := dtFit;
  case FDestination.DisplayOptions of
    None: ;
    FitZoom: Result := dtXYZ;
    FitAll: Result := dtFit;
    FitHeight: Result := dtFitH;
    FitWidth: Result := dtFitV;
    FitRect: Result := dtFitR;
    FitBoundingBox: Result := dtFitB;
    FitBoundingBoxHeight: Result := dtFitBH;
    FitBoundingBoxWidth: Result := dtFitBV;
  end;
end;
{------------------------------------------------------------------------------}
function TgtPDFDestination.GetPageNo: Integer;
begin
  Result := FPageNo;
end;

{------------------------------------------------------------------------------}
function TgtPDFDestination.GetZoom: Double;
begin
   // In this case the Zoom value is assignes to Right
  Result := FDestination.Rect.Right;
end;
{------------------------------------------------------------------------------}
procedure TgtPDFDestination.SetDestination(const Value: TgtPDDestination);
begin
  if Assigned(FDestination) then
    FreeAndNil(FDestination);
  FDestination := Value;
  FToFree := False;
end;

procedure TgtPDFDestination.SetDestinationType(const Value: TgtPDFDestinationType);
begin
  case Value of
    dtXYZ: FDestination.DisplayOptions := FitZoom;
    dtFit: FDestination.DisplayOptions := FitAll;
    dtFitH: FDestination.DisplayOptions := FitHeight;
    dtFitV: FDestination.DisplayOptions := FitWidth;
    dtFitR: FDestination.DisplayOptions := FitRect;
    dtFitB: FDestination.DisplayOptions := FitBoundingBox;
    dtFitBH: FDestination.DisplayOptions := FitBoundingBoxHeight;
    dtFitBV: FDestination.DisplayOptions := FitBoundingBoxWidth;
  end;
end;
{------------------------------------------------------------------------------}
procedure TgtPDFDestination.SetPageNo(const Value: Integer);
begin
  FPageNo := Value;
end;

{------------------------------------------------------------------------------}
procedure TgtPDFDestination.SetZoom(const Value: Double);
begin
// In this case the Zoom value is assignes to Right
  FDestination.Rect.Right := Value;
end;
{------------------------------------------------------------------------------}
procedure TgtPDFDestination.SetLeft(const Value: Double);
begin
  FDestination.Rect.Left := Value;
end;
{------------------------------------------------------------------------------}
procedure TgtPDFDestination.SetRight(const Value: Double);
begin
  FDestination.Rect.Right := Value;
end;
{------------------------------------------------------------------------------}
procedure TgtPDFDestination.SetTop(const Value: Double);
begin
  FDestination.Rect.Top := Value;
end;
{------------------------------------------------------------------------------}
procedure TgtPDFDestination.SetBottom(const Value: Double);
begin
  FDestination.Rect.Bottom := Value;
end;


{ TgtBookmarkAttribute }

constructor TgtBookmarkAttribute.Create;
begin

end;
{------------------------------------------------------------------------------}
constructor TgtBookmarkAttribute.Create(AFontStyle: TFontStyles;
  AOutlinecolor: TColor);
begin
  FFontStyles := AFontStyle;
  FOutlineColor := AOutlinecolor;
end;
{------------------------------------------------------------------------------}

{ TgtWatermarkTemplate }

constructor TgtWatermarkTemplate.Create;
begin

end;
{------------------------------------------------------------------------------}

function ConvertToMU(
  MeasurementUnit: TgtMeasurementUnit; Value: Double): Double;
begin
  case MeasurementUnit of
    muPixels: Result := PointsToPixels(Value);
    muInches: Result := Value / CInchesToPoints;
    muMM: Result := Value / CMMToPoints;
    muTwips: Result := Value / CTwipsToPoints;
  else Result := Value;
  end;
end;
{------------------------------------------------------------------------------}

{ TgtPDFOutline }

function TgtPDFOutline.AddChild(Title: WideString; ADestination: TgtPDFDestination;
  OutLineAttribute: TgtBookmarkAttribute): TgtPDFOutline;
var
  LOutlineAttribute: TgtPDOutlineFlag;
  LBookmark: TgtPDBookmark;
  LOutlineList: TgtOutlineList;
  LColor: TgtPDColorValue;
begin
  Result := nil;
  if not Assigned(FParentDoc.FPDDoc) then
  begin
    Exit;
  end;

  if Assigned(FPDBookmark) then
  begin
    GetBookmarkProperties(OutLineAttribute, LOutlineAttribute, LColor);
    ADestination.Destination.Page := FParentDoc.FPDDoc.Pages[ADestination.PageNo];
    LBookmark := FPDBookmark.AddNewChild(Title, ADestination.Destination,
      LOutlineAttribute);
    LBookmark.SetColor(LColor);
    if Assigned(LBookmark) then
    begin
      Result := TgtPDFOutline.Create(FParentDoc, Self);
      Result.FPDBookmark := LBookmark;
      LOutlineList := Self.FBookmarkList;
      if Assigned(LOutlineList) then
        LOutlineList.Add(Result);
    end;
  end;
end;
{------------------------------------------------------------------------------}

function TgtPDFOutline.AddChild(Title: WideString; Action: TgtPDFAction;
  OutLineAttribute: TgtBookmarkAttribute): TgtPDFOutline;
var
  LOutlineAttribute: TgtPDOutlineFlag;
  LOutlineList: TgtOutlineList;
  LBookmark: TgtPDBookmark;
  LColor: TgtPDColorValue;
begin
  Result := nil;
  if not Assigned(FParentDoc.FPDDoc) then
  begin
    Exit;
  end;

  if Assigned(FPDBookmark) then
  begin
    GetBookmarkProperties(OutLineAttribute, LOutlineAttribute, LColor);
    if (Action.FAction.ActionType = actionGoTo) or
      (Action.FAction.ActionType = actionGoToR)  then
    begin
      FParentDoc.AddDestination(Action);
    end;
    LBookmark := FPDBookmark.AddNewChild(Title, Action.FAction,
      LOutlineAttribute);
    LBookmark.SetColor(LColor);
    if Assigned(LBookmark) then
    begin
      Result := TgtPDFOutline.Create(FParentDoc, Self);
      Result.FPDBookmark := LBookmark;
      LOutlineList := Self.FBookmarkList;
      if Assigned(LOutlineList) then
        LOutlineList.Add(Result);
    end;
  end;
end;
{------------------------------------------------------------------------------}

function TgtPDFOutline.AddNext(Title: WideString; Action: TgtPDFAction;
  OutLineAttribute: TgtBookmarkAttribute): TgtPDFOutline;
var
  LOutlineAttribute: TgtPDOutlineFlag;
  LBookmark: TgtPDBookmark;
  LOutlineList: TgtOutlineList;
  LColor: TgtPDColorValue;
begin
  Result := nil;
  if Assigned(FPDBookmark) then
  begin
    GetBookmarkProperties(OutLineAttribute, LOutlineAttribute, LColor);
    if (Action.FAction.ActionType = actionGoTo) or
      (Action.FAction.ActionType = actionGoToR)  then
    begin
      FParentDoc.AddDestination(Action);
    end;
    LBookmark := FPDBookmark.AddNewNext(Title, Action.FAction,
      LOutlineAttribute);
    LBookmark.SetColor(LColor);
    if Assigned(LBookmark) then
    begin
      Result := TgtPDFOutline.Create(FParentDoc, Self.Parent);
      Result.FPDBookmark := LBookmark;
      LOutlineList := Self.Parent.FBookmarkList;
      if Assigned(LOutlineList) then
      begin
        LOutlineList.Insert(Self.BookmarkIndex + 1, Result);
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}

function TgtPDFOutline.AddNext(Title: WideString; ADestination: TgtPDFDestination;
  OutLineAttribute: TgtBookmarkAttribute): TgtPDFOutline;
var
  LOutlineAttribute: TgtPDOutlineFlag;
  LOutlineList: TgtOutlineList;
  LBookmark: TgtPDBookmark;
  LColor: TgtPDColorValue;
begin
  Result := nil;
  if Assigned(FPDBookmark) then
  begin
    GetBookmarkProperties(OutLineAttribute, LOutlineAttribute, LColor);
    ADestination.Destination.Page := FParentDoc.FPDDoc.Pages[ADestination.PageNo];
    LBookmark := FPDBookmark.AddNewNext(Title, ADestination.Destination,
      LOutlineAttribute);
    LBookmark.SetColor(LColor);
    if Assigned(LBookmark) then
    begin
      Result := TgtPDFOutline.Create(FParentDoc, Self.Parent);
      Result.FPDBookmark := LBookmark;
      LOutlineList := Self.Parent.FBookmarkList;
      if Assigned(LOutlineList) then
      begin
        LOutlineList.Insert(Self.BookmarkIndex + 1, Result);
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}

function TgtPDFOutline.AddPrev(Title: WideString; Action: TgtPDFAction;
  OutLineAttribute: TgtBookmarkAttribute): TgtPDFOutline;
var
  LOutlineAttribute: TgtPDOutlineFlag;
  LBookmark: TgtPDBookmark;
  LOutlineList: TgtOutlineList;
  LColor: TgtPDColorValue;
begin
  Result := nil;
  if Assigned(FPDBookmark) then
  begin
    GetBookmarkProperties(OutLineAttribute, LOutlineAttribute, LColor);
    if (Action.FAction.ActionType = actionGoTo) or
      (Action.FAction.ActionType = actionGoToR)  then
    begin
      FParentDoc.AddDestination(Action);
    end;
    LBookmark := FPDBookmark.AddNewPrev(Title, Action.FAction,
      LOutlineAttribute);
    LBookmark.SetColor(LColor);
    if Assigned(LBookmark) then
    begin
      Result := TgtPDFOutline.Create(FParentDoc, Self.Parent);
      Result.FPDBookmark := LBookmark;
      LOutlineList := Self.Parent.FBookmarkList;
      if Assigned(LOutlineList) then
      begin
        LOutlineList.Insert(Self.BookmarkIndex + 1, Result);
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}

function TgtPDFOutline.AddPrev(Title: WideString; ADestination: TgtPDFDestination;
  OutLineAttribute: TgtBookmarkAttribute): TgtPDFOutline;
var
  LOutlineAttribute: TgtPDOutlineFlag;
  LOutlineList: TgtOutlineList;
  LBookmark: TgtPDBookmark;
  LColor: TgtPDColorValue;
begin
  Result := nil;
  if Assigned(FPDBookmark) then
  begin
    GetBookmarkProperties(OutLineAttribute, LOutlineAttribute, LColor);
    ADestination.Destination.Page := FParentDoc.FPDDoc.Pages[ADestination.PageNo];
    LBookmark := FPDBookmark.AddNewPrev(Title, ADestination.Destination,
      LOutlineAttribute);
    LBookmark.SetColor(LColor);
    if Assigned(LBookmark) then
    begin
      Result := TgtPDFOutline.Create(FParentDoc, Self.Parent);
      Result.FPDBookmark := LBookmark;
      LOutlineList := Self.Parent.FBookmarkList;
      if Assigned(LOutlineList) then
      begin
        LOutlineList.Insert(Self.BookmarkIndex, Result);
      end;
    end;
  end;
end;
{------------------------------------------------------------------------------}


function TgtPDFOutline.AppendChild(Title: WideString; ADestination: TgtPDFDestination;
  OutLineAttribute: TgtBookmarkAttribute): TgtPDFOutline;
begin
  Result := AddChild(Title, ADestination, OutLineAttribute);
end;
{------------------------------------------------------------------------------}

function TgtPDFOutline.AppendChild(Title: WideString; Action: TgtPDFAction;
  OutLineAttribute: TgtBookmarkAttribute): TgtPDFOutline;
begin
  Result := AddChild(Title, Action, OutLineAttribute);
end;
{------------------------------------------------------------------------------}

procedure TgtPDFOutline.Modify(Title: WideString;
  ADestination: TgtPDFDestination; OutLineAttribute: TgtBookmarkAttribute);
var
  LOutlineFlag: TgtPDOutlineFlag;
  LColor: TgtPDColorValue;
begin
  if not Assigned(TgtCustomPDFDocument(FParentDoc).FPDDoc) then Exit;
  if Assigned(FPDBookmark) then
  begin
    GetBookmarkProperties(OutLineAttribute, LOutlineFlag, LColor);
    ADestination.Destination.Page := FParentDoc.FPDDoc.Pages[ADestination.PageNo];
    FPDBookmark.Title := Title;
    FPDBookmark.SetColor(LColor);
    FPDBookmark.Destination := ADestination.FDestination;
    FPDBookmark.Flags := LOutlineFlag;
  end;
end;
{------------------------------------------------------------------------------}

procedure TgtPDFOutline.Modify(Title: WideString; Action: TgtPDFAction;
  OutLineAttribute: TgtBookmarkAttribute);
var
  LOutlineFlag: TgtPDOutlineFlag;
  LColor: TgtPDColorValue;
begin
  if Assigned(FPDBookmark) then
  begin
    GetBookmarkProperties(OutLineAttribute, LOutlineFlag, LColor);
    FPDBookmark.Title := Title;
    FPDBookmark.Flags := LOutlineFlag;
    FPDBookmark.SetColor(LColor);
    if (Action.FAction.ActionType = actionGoTo) or
      (Action.FAction.ActionType = actionGoToR)  then
    begin
      FParentDoc.AddDestination(Action);
    end;
    FPDBookmark.SetAction(Action.FAction);
  end;
end;
{------------------------------------------------------------------------------}

procedure TgtPDFOutline.ModifyNext(Title: WideString; Action: TgtPDFAction;
  OutLineAttribute: TgtBookmarkAttribute);
var
  LNext: TgtPDFOutline;
begin
  LNext := Next;
  if Assigned(LNext) then
    LNext.Modify(Title, Action, OutLineAttribute);
end;
{------------------------------------------------------------------------------}

procedure TgtPDFOutline.ModifyNext(Title: WideString;
  ADestination: TgtPDFDestination; OutLineAttribute: TgtBookmarkAttribute);
var
  LNext: TgtPDFOutline;
begin
  LNext := Next;
  if Assigned(LNext) then
    LNext.Modify(Title, Destination, OutLineAttribute);
end;
{------------------------------------------------------------------------------}

procedure TgtPDFOutline.ModifyPrev(Title: WideString; Action: TgtPDFAction;
  OutLineAttribute: TgtBookmarkAttribute);
var
  LPrev: TgtPDFOutline;
begin
  LPrev := Prev;
  if Assigned(LPrev) then
    LPrev.Modify(Title, Action, OutLineAttribute);
end;
function TgtPDFOutline.TraverseDepthFirst(ABookmark: TgtPDFOutline;
  const ATitle: Ansistring; ADepth: TgtBookmarkTraversalDepth): TgtPDFOutline;
var
  LBkmrk: TgtPDFOutline;
  LDepth: Integer;
begin
  Result := nil;
  if Assigned(ABookmark) then
  begin
    if AnsiStrIComp(PAnsichar(ABookmark.Title), PAnsichar(ATitle)) = 0 then
    begin
      FTitleFound := True;
      Result := ABookmark;
    end
    else
    begin
      LDepth := Self.Level + 1;
      case ADepth of
        btdSiblingsOnly:
        begin
          Result := TraverseDepthFirst(ABookmark.Next, ATitle, ADepth);
        end;
        btdChildrenOnly:
        begin
          LBkmrk := ABookmark.GetFirstChild;
          if Assigned(LBkmrk) then
          begin
            if LBkmrk.Level <= LDepth then
              Result := TraverseDepthFirst(LBkmrk, ATitle, ADepth)
          end;
          if not FTitleFound then
            Result := TraverseDepthFirst(ABookmark.Next, ATitle, ADepth)
        end;
        btdFullSubtree:
        begin
          LBkmrk := ABookmark.GetFirstChild;
          if Assigned(LBkmrk) then
            Result := TraverseDepthFirst(LBkmrk, ATitle, ADepth);
          if not FTitleFound then
            Result := TraverseDepthFirst(ABookmark.Next, ATitle, ADepth);
        end;
      end;
    end;
  end;
end;

{------------------------------------------------------------------------------}

procedure TgtPDFOutline.ModifyPrev(Title: WideString;
  ADestination: TgtPDFDestination; OutLineAttribute: TgtBookmarkAttribute);
var
  LPrev: TgtPDFOutline;
begin
  LPrev := Prev;
  if Assigned(LPrev) then
    LPrev.Modify(Title, Destination, OutLineAttribute);
end;
{------------------------------------------------------------------------------}

constructor TgtPDFOutline.Create(AParentDoc: TgtCustomPDFDocument;
  AParent:TgtPDFOutLine);
begin
  FParentDoc := AParentDoc;
  FParent := AParent;
  FPDBookmark := nil;
  FDestination := nil;
end;
{------------------------------------------------------------------------------}
procedure TgtPDFOutline.DeleteChild;
begin
  if Assigned(FPDBookmark) then
    if FPDBookmark.DeleteChild(0) then
      FBookmarkList.Delete(0);
end;
{------------------------------------------------------------------------------}
procedure TgtPDFOutline.DeleteNext;
var
  LIndex: Integer;
begin
  if Assigned(FPDBookmark) then
  begin
    LIndex := Self.BookmarkIndex;
    if FPDBookmark.DeleteNext then
    begin
      if Self.Parent.FBookmarkList.Count > LIndex + 1 then
        Self.Parent.FBookmarkList.Delete(LIndex + 1);
    end;
  end;
end;
{------------------------------------------------------------------------------}
procedure TgtPDFOutline.DeletePrev;
var
  LIndex: Integer;
begin
  if Assigned(FPDBookmark) then
  begin
    LIndex := Self.BookmarkIndex;
    if FPDBookmark.DeletePrev then
    begin
      if Self.Parent.FBookmarkList.Count >= LIndex then
        Self.Parent.FBookmarkList.Delete(LIndex - 1);
    end;
  end;
end;
{------------------------------------------------------------------------------}
destructor TgtPDFOutline.Destroy;
begin
  if Assigned(FBookmarkList) then
    FreeAndnil(FBookmarkList);
  if Assigned(FDestination) then
    FreeAndNil(FDestination);
  if Assigned(FOutlineAction) then
    FreeAndNil(FOutlineAction);
  inherited;
end;
{------------------------------------------------------------------------------}

function TgtPDFOutline.GetAction: TgtPDFAction;
begin
  if not Assigned(FOutlineAction) and Assigned(FPDBookmark.Action) then
  begin
    case FPDBookmark.Action.ActionType of
      actionNone: ;
      actionGoTo: FOutlineAction := TgtPDFGoToAction.Create;
      actionGoToR: FOutlineAction := TgtPDFGoToRAction.Create;
      actionGoToE: ;
      actionLaunch: FOutlineAction := TgtPDFLaunchAction.Create;
      actionThread: ;
      actionURI: FOutlineAction := TgtPDFURIAction.Create;
      actionSound: ;
      actionMovie: ;
      actionHide: ;
      actionNamed: ;
      actionSubmitForm: ;
      actionResetForm: ;
      actionImportData: ;
      actionJavaScript: FOutlineAction := TgtPDFJavaScriptAction.Create;
      actionSetOCGState: ;
      actionRendition: ;
      actionTrans: ;
      actionGoTo3DView: ;
    end;
    if Assigned(FOutlineAction) then
      FOutlineAction.FAction := FPDBookmark.Action;
  end;
  Result := FOutlineAction;
end;
function TgtPDFOutline.GetBookmarkIndex: Integer;
begin
  if Assigned(FPDBookmark) then
    Result := FPDBookmark.BookmarkIndex
  else
    Result := 0;
end;

procedure TgtPDFOutline.GetBookmarkProperties(Attribute: TgtBookmarkAttribute;
  var AOutlineFlag: TgtPDOutlineFlag; var AColor: TgtPDColorValue);
begin
  AOutlineFlag.Bold := fsBold in (Attribute.FFontStyles);
  AOutlineFlag.Italic := fsItalic in (Attribute.FFontStyles);
  AOutlineFlag.Underline := fsUnderline in (Attribute.FFontStyles);
  AOutlineFlag.StrikeOut := fsStrikeOut in (Attribute.FFontStyles);
  AColor.ColorSpace := DeviceRGB;
  AColor.Value[0] := GetRValue(Attribute.OutlineColor) / 255;
  AColor.Value[1] := GetGValue(Attribute.OutlineColor) / 255;
  AColor.Value[2] := GetBValue(Attribute.OutlineColor) / 255;
end;

function TgtPDFOutline.GetByTitle(ATitle: AnsiString;
  ATraversalType: TgtBookmarkTraversalType;
  AMaxDepth: TgtBookmarkTraversalDepth): TgtPDFOutline;
begin
  Result := nil;
  FTitleFound := False;
  case ATraversalType of
    bttDepthFirst:
    begin
      Result := TraverseDepthFirst(Self, ATitle, AMaxDepth);
    end;
  end;
end;

{------------------------------------------------------------------------------}
function TgtPDFOutline.GetDestination: TgtPDFDestination;
var
  LPageNum: Integer;
begin
  if not Assigned(FDestination) then
  begin
    if Assigned(FPDBookmark) and Assigned(FPDBookmark.Destination) then
    begin
      FDestination := TgtPDFDestination.Create(
        TgtPDPage(FPDBookmark.Destination.Page).PageNum, dtXYZ);
      FDestination.Destination := FPDBookmark.Destination;
    end
    else if Assigned(FPDBookmark) and Assigned(FPDBookmark.Action) then
    begin
      case FPDBookmark.Action.ActionType of
        actionGoTo:
        begin
          LPageNum := TgtPDPage(TgtPDGoToAction(FPDBookmark.Action).
            Destination.Page).PageNum;
          FDestination := TgtPDFDestination.Create(LPageNum, dtXYZ);
        end;
      end;
    end;
  end;
  Result := FDestination;
end;
{------------------------------------------------------------------------------}

function TgtPDFOutline.GetParent: TgtPDFOutline;
begin
  Result := FParent;
end;
{------------------------------------------------------------------------------}

function TgtPDFOutline.GetChild: TgtPDFOutline;
var
  LOutline: TgtPDFOutline;
begin
  Result := nil;
  if not Assigned(FBookmarkList) or (FBookmarkList.Count = 0) then
  begin
    FBookmarkList := TgtOutlineList.Create;
    if Assigned(FPDBookmark) and Assigned(FPDBookmark.FirstChild) then
    begin
      LOutline := TgtPDFOutline.Create(FParentDoc, Self);
      LOutline.FPDBookmark := FPDBookmark.FirstChild;
      FBookmarkList.Add(LOutline);
    end;
  end;
  if FBookmarkList.Count > 0 then
    Result := FBookmarkList.Items[0];
end;

function TgtPDFOutline.GetFirstChild: TgtPDFOutline;
begin
  Result := Child;
end;
function TgtPDFOutline.GetLastChild: TgtPDFoutline;
var
  LOutline: TgtPDFOutline;
begin
  Result := nil;
  if not Assigned(FBookmarkList) or (FBookmarkList.Count = 0) then
  begin
    FBookmarkList := TgtOutlineList.Create;
    if Assigned(FPDBookmark) and Assigned(FPDBookmark.LastChild) then
    begin
      LOutline := TgtPDFOutline.Create(FParentDoc, Self);
      LOutline.FPDBookmark := FPDBookmark.LastChild;
      FBookmarkList.Add(LOutline);
    end;
  end;
  if FBookmarkList.Count > 0 then
    Result := FBookmarkList.Items[FBookmarkList.Count - 1];
end;

function TgtPDFOutline.GetLevel: Integer;
begin
  if Assigned(FPDBookmark) then
    Result := FPDBookmark.Level
  else
    Result := 0;
end;

{------------------------------------------------------------------------------}

function TgtPDFOutline.GetNext: TgtPDFOutline;
var
  LList: TgtOutlineList;
  LOutline: TgtPDFOutline;
begin
  Result := nil;
  if not Assigned(Parent) then Exit;
  LList := nil;
  LList := Parent.FBookmarkList;
  if not Assigned(LList) then Exit;

  if LList.Count > BookmarkIndex + 1 then
    Result := LList.Items[BookmarkIndex + 1]
  else
  begin
    if Assigned(FPDBookmark) and Assigned(FPDBookmark.Next) then
    begin
      LOutline := TgtPDFOutline.Create(FParentDoc, Self.Parent);
      LOutline.FPDBookmark := FPDBookmark.Next;
      LList.Add(LOutline);
      Result := LOutline;
    end;
  end;
end;
{------------------------------------------------------------------------------}

function TgtPDFOutline.GetNextNode: TgtPDFOutline;
begin
  Result := GetNext;
end;
{------------------------------------------------------------------------------}
function TgtPDFOutline.GetPrev: TgtPDFOutline;
var
  LList: TgtOutlineList;
  LOutline: TgtPDFOutline;
begin
  Result := nil;
  if not Assigned(Parent) then Exit;
  LList := nil;
  LList := Parent.FBookmarkList;
  if not Assigned(LList) then Exit;

  if (LList.Count > Self.BookmarkIndex) and (Self.BookmarkIndex > 0) then
    Result := LList.Items[BookmarkIndex - 1]
  else
  begin
    if Assigned(FPDBookmark) and Assigned(FPDBookmark.Prev) then
    begin
      LOutline := TgtPDFOutline.Create(FParentDoc, Self.Parent);
      LOutline.FPDBookmark := FPDBookmark.Prev;
      LList.Add(LOutline);
      Result := LOutline;
    end;
  end;
end;
{------------------------------------------------------------------------------}
function TgtPDFOutline.GetPrevNode: TgtPDFOutline;
begin
  Result := GetPrev;
end;
{------------------------------------------------------------------------------}

function TgtPDFOutline.GetTitle: AnsiString;
begin
  Result := FPDBookmark.Title;
end;

function ConvertToPDFUnit(MeasurementUnit: TgtMeasurementUnit; Value: Double): Double;
begin
  case MeasurementUnit of
    muPixels: Result := PixelsToPoints(Value);
    muInches: Result := Value * CInchesToPoints;
    muMM: Result := Value * CMMToPoints;
    muTwips: Result := Value * CTwipsToPoints;
  else Result := Value;
  end;
end;
{------------------------------------------------------------------------------}
{ TgtBaseDlg }

constructor TgtBaseDlg.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

end;
{------------------------------------------------------------------------------}
procedure TgtBaseDlg.SetPDFDoc(const Value: TgtCustomPDFDocument);
begin
  FPDFDoc := Value;
end;
{------------------------------------------------------------------------------}

//{ TgtTextWatermarkTemplate }
//
//constructor TgtTextWatermarkTemplate.Create;
//begin
//  inherited;
//  FFont := TFont.Create;
//  FStrokeOpacity := 100;
//  FFont.Charset := ANSI_CHARSET;
//  FFontEncoding := feWinAnsiEncoding;
//  FEmbedTrueTypeFonts := tfeNone;
//  FWritingMode := wmHorizontal;
//end;
//{------------------------------------------------------------------------------}
//destructor TgtTextWatermarkTemplate.Destroy;
//begin
//  FreeAndNil(FFont);
//  inherited;
//end;
//{------------------------------------------------------------------------------}
//procedure TgtTextWatermarkTemplate.SetFont(const aFont: TFont);
//begin
//  FFont.Assign(aFont);
//end;
//{------------------------------------------------------------------------------}
{ TgtImageWatermarkTemplate }

constructor TgtImageWatermarkTemplate.Create;
begin
  inherited;
  FImage := nil;
  FWidth := 0;
  FHeight := 0;
  FFillOpacity := 100;
  FInLine := False;
end;
{------------------------------------------------------------------------------}
destructor TgtImageWatermarkTemplate.Destroy;
begin
  if Assigned(FImage) then
    FreeAndNil(FImage);
  inherited;
end;
{------------------------------------------------------------------------------}
function TgtImageWatermarkTemplate.GetImage: TGraphic;
begin
  Result := FImage;
end;
{------------------------------------------------------------------------------}
procedure TgtImageWatermarkTemplate.SetImage(AGraphic: TGraphic);
begin
  try
    if AGraphic is TBitmap then
      FImage := TBitmap.Create
    else if AGraphic is TJPEGImage then
      FImage := TJPEGImage.Create
    else
      raise EUnsupportedImage.CreateFmt('Unsupported image format (%s)',
        [AGraphic.ClassName]);
  except
    on E: EUnsupportedImage do
      raise EUnsupportedImageError.Create(E.Message);
  else raise;
  end;
  if Assigned(FImage) then FImage.Assign(AGraphic);
end;
{------------------------------------------------------------------------------}
{ TgtCompositeWatermarkTemplate }

function TgtCompositeWatermarkTemplate.AddWatermark(
  AWatermarkTemplate: TgtWatermarkTemplate): Integer;
begin
  Result := FWatermarkTemplates.Add(AWatermarkTemplate);
end;
{------------------------------------------------------------------------------}
constructor TgtCompositeWatermarkTemplate.Create;
begin
  inherited;
  FWatermarkTemplates := TList.Create;
end;
{------------------------------------------------------------------------------}
destructor TgtCompositeWatermarkTemplate.Destroy;
begin
  FreeAndNil(FWatermarkTemplates);
  inherited;
end;
 {------------------------------------------------------------------------------}
function TgtCompositeWatermarkTemplate.GetCount: Integer;
begin
  Result := FWatermarkTemplates.Count;
end;
{------------------------------------------------------------------------------}
function TgtCompositeWatermarkTemplate.GetWatermarkAt(
  AIndex: Integer): TgtWatermarkTemplate;
begin
  Result := TgtWatermarkTemplate(FWatermarkTemplates.Items[AIndex]);
end;
{------------------------------------------------------------------------------}
procedure TgtCompositeWatermarkTemplate.SetWatermarkAt(AIndex: Integer;
  AValue: TgtWatermarkTemplate);
begin
  FWatermarkTemplates.Items[AIndex] := AValue;
end;
{------------------------------------------------------------------------------}
//{ TgtRectangleWatermarkTemplate }
//
//constructor TgtRectangleWatermarkTemplate.Create;
//begin
//  FInitialPoint := TgtPoint.Create;
//  FEndPoint:= TgtPoint.Create;
//  FInitialPoint.X := 0;
//  FInitialPoint.Y := 0;
//  FEndPoint.X := 0;
//  FEndPoint.Y := 0;
//end;
//{------------------------------------------------------------------------------}
//destructor TgtRectangleWatermarkTemplate.Destroy;
//begin
//
//  inherited;
//    if Assigned(FInitialPoint) then
//      FreeAndNil(FInitialPoint);
//    if Assigned(FEndPoint) then
//      FreeAndNil(FEndPoint);
//end;
//{------------------------------------------------------------------------------}
//{ TgtShapeWatermark }
//
//constructor TgtShapeWatermark.Create;
//begin
//  FStrokeColor := clBlack;
//  FPenWidth := 1;
//  FStrokeOpacity := 100;
//end;
//{------------------------------------------------------------------------------}
//{ TgtOpenShapeWatermark }
//
//constructor TgtOpenShapeWatermark.Create;
//begin
//  inherited;
//  FInitialPoint:= TgtPoint.Create;
//  FEndPoint:= TgtPoint.Create;
//  FInitialPoint.X := 0;
//  FInitialPoint.Y := 0;
//  FEndPoint.X := 0;
//  FEndPoint.Y := 0;
//end;
//{------------------------------------------------------------------------------}
//destructor TgtOpenShapeWatermark.Destroy;
//begin
//  inherited;
//  if Assigned(FInitialPoint) then
//    FreeAndNil(FInitialPoint);
//  if Assigned (FEndPoint) then
//    FreeAndNil(FEndPoint);
//end;
//
//{ TgtClosedShapeWatermark }
//
//constructor TgtClosedShapeWatermark.Create;
//begin
//  inherited;
//  FFillcolor := Graphics.clNone;
//  FFillOpacity := 100;
//end;
//{------------------------------------------------------------------------------}
//{ TgtCircleWaterMarkTemplate }
//
//constructor TgtCircleWaterMarkTemplate.Create;
//begin
//  inherited;
//    FCenter := TgtPoint.Create;
//    FCenter.X := 0;
//    FCenter.Y := 0;
//end;
//{------------------------------------------------------------------------------}
//destructor TgtCircleWaterMarkTemplate.Destroy;
//begin
//  inherited;
//  if Assigned(FCenter) then
//  begin
//    FreeAndNil(FCenter);
//  end;
//end;
//
//{ TgtEllipseWaterMarkTemplate }
//
//constructor TgtEllipseWaterMarkTemplate.Create;
//begin
//  inherited;
//    FCenter:= TgtPoint.Create;
//    FCenter.X := 0;
//    FCenter.Y := 0;
//end;
//{------------------------------------------------------------------------------}
//destructor TgtEllipseWaterMarkTemplate.destroy;
//begin
//  inherited;
//  if Assigned(FCenter) then
//    FreeAndNil(FCenter);
//end;
//
//{ TgtPolygonWatermark }
//
//constructor TgtPolygonWatermark.Create;
//begin
//  inherited;
//    FCenter := TgtPoint.create;
//    FCenter.X := 0;
//    FCenter.Y := 0;
//end;
//{------------------------------------------------------------------------------}
//destructor TgtPolygonWatermark.destroy;
//begin
//  inherited;
//  if Assigned(FCenter) then
//    FreeAndNil(FCenter);
//end;
//
{ TgtCurveWaterMarkTemplate }

constructor TgtCurveWaterMarkTemplate.Create;
begin
  inherited;
  FFirstControlPoint := TgtPoint.Create;
  FSecondControlPoint := TgtPoint.Create;
  FFirstControlPoint.X := 0;
  FFirstControlPoint.Y := 0;
  FSecondControlPoint.X := 0;
  FSecondControlPoint.Y := 0;
end;
{------------------------------------------------------------------------------}
destructor TgtCurveWaterMarkTemplate.destroy;
begin
  inherited;
    if Assigned(FFirstControlPoint) then
      FreeAndNil(FFirstControlPoint);
    if Assigned(FSecondControlPoint) then
      FreeAndNil(FSecondControlPoint);
end;

//{ TgtCustomWatermarkTemplate }
//
//constructor TgtCustomWatermarkTemplate.Create;
//begin
//  inherited;
//  FOverlay := False;
//  FHorizPos := hpCustom;
//  FVertPos := vpCustom;
//end;
//{------------------------------------------------------------------------------}
//procedure TgtCustomWatermarkTemplate.GetXY(APageWidth, APageHeight: Double; var AXPos,
//  AYPos: Double; AWidth, AHeight: Double; AMeasurementUnit: TgtMeasurementUnit);
//begin
//  // The Horizontal Position
//  case HorizPos of
//    hpCustom: AXPos := ConvertToPDFUnit(AMeasurementUnit, X);
//    hpLeft: AXPos := 0;
//    hpCenter: AXPos := (APageWidth / 2.0) - (AWidth / 2.0);
//    hpRight: AXPos := APageWidth - AWidth;
//  end;
//
//  // The Vertical Position
//  case VertPos of
//    vpCustom: AYPos := ConvertToPDFUnit(AMeasurementUnit, Y);
//    vpTop: AYPos := 0;
//    vpMiddle: AYPos := (APageHeight / 2.0) - (AHeight / 2.0);
//    vpBottom: AYPos := APageHeight - AHeight;
//  end;
//end;
//{------------------------------------------------------------------------------}
//constructor TgtBaseDlg.Create(AOwner: TComponent);
//begin
//  inherited Create(AOwner);
//
//end;
//{------------------------------------------------------------------------------}
//procedure TgtBaseDlg.SetPDFDoc(const Value: TgtCustomPDFDocument);
//begin
//  FPDFDoc := Value;
//end;
//{------------------------------------------------------------------------------}
{ TgtTextWatermarkTemplate }

constructor TgtTextWatermarkTemplate.Create;
begin
  inherited;
  FFont := TFont.Create;
  FStrokeOpacity := 100;
  FFont.Charset := ANSI_CHARSET;
  FFontEncoding := feWinAnsiEncoding;
  FEmbedTrueTypeFonts := tfeNone;
  FWritingMode := wmHorizontal;
end;
{------------------------------------------------------------------------------}
destructor TgtTextWatermarkTemplate.Destroy;
begin
  FreeAndNil(FFont);
  inherited;
end;
{------------------------------------------------------------------------------}
procedure TgtTextWatermarkTemplate.SetFont(const aFont: TFont);
begin
  FFont.Assign(aFont);
end;

{------------------------------------------------------------------------------}
{ TgtRectangleWatermarkTemplate }

constructor TgtRectangleWatermarkTemplate.Create;
begin
  FInitialPoint := TgtPoint.Create;
  FEndPoint:= TgtPoint.Create;
  FInitialPoint.X := 0;
  FInitialPoint.Y := 0;
  FEndPoint.X := 0;
  FEndPoint.Y := 0;
end;
{------------------------------------------------------------------------------}
destructor TgtRectangleWatermarkTemplate.Destroy;
begin

  inherited;
    if Assigned(FInitialPoint) then
      FreeAndNil(FInitialPoint);
    if Assigned(FEndPoint) then
      FreeAndNil(FEndPoint);
end;
{------------------------------------------------------------------------------}
{ TgtShapeWatermark }

constructor TgtShapeWatermark.Create;
begin
  FStrokeColor := clBlack;
  FPenWidth := 1;
  FStrokeOpacity := 100;
end;
{------------------------------------------------------------------------------}
{ TgtOpenShapeWatermark }

constructor TgtOpenShapeWatermark.Create;
begin
  inherited;
  FInitialPoint:= TgtPoint.Create;
  FEndPoint:= TgtPoint.Create;
  FInitialPoint.X := 0;
  FInitialPoint.Y := 0;
  FEndPoint.X := 0;
  FEndPoint.Y := 0;
end;
{------------------------------------------------------------------------------}
destructor TgtOpenShapeWatermark.Destroy;
begin
  inherited;
  if Assigned(FInitialPoint) then
    FreeAndNil(FInitialPoint);
  if Assigned (FEndPoint) then
    FreeAndNil(FEndPoint);
end;

{ TgtClosedShapeWatermark }

constructor TgtClosedShapeWatermark.Create;
begin
  inherited;
  FFillcolor := Graphics.clNone;
  FFillOpacity := 100;
end;
{------------------------------------------------------------------------------}
{ TgtCircleWaterMarkTemplate }

constructor TgtCircleWaterMarkTemplate.Create;
begin
  inherited;
    FCenter := TgtPoint.Create;
    FCenter.X := 0;
    FCenter.Y := 0;
end;
{------------------------------------------------------------------------------}
destructor TgtCircleWaterMarkTemplate.Destroy;
begin
  inherited;
  if Assigned(FCenter) then
  begin
    FreeAndNil(FCenter);
  end;
end;

{ TgtEllipseWaterMarkTemplate }

constructor TgtEllipseWaterMarkTemplate.Create;
begin
  inherited;
    FCenter:= TgtPoint.Create;
    FCenter.X := 0;
    FCenter.Y := 0;
end;
{------------------------------------------------------------------------------}
destructor TgtEllipseWaterMarkTemplate.destroy;
begin
  inherited;
  if Assigned(FCenter) then
    FreeAndNil(FCenter);
end;

{ TgtPolygonWatermark }

constructor TgtPolygonWatermark.Create;
begin
  inherited;
    FCenter := TgtPoint.create;
    FCenter.X := 0;
    FCenter.Y := 0;
end;
{------------------------------------------------------------------------------}
destructor TgtPolygonWatermark.destroy;
begin
  inherited;
  if Assigned(FCenter) then
    FreeAndNil(FCenter);
end;

{ TgtCustomWatermarkTemplate }

constructor TgtCustomWatermarkTemplate.Create;
begin
  inherited;
  FOverlay := False;
  FHorizPos := hpCustom;
  FVertPos := vpCustom;
end;
{------------------------------------------------------------------------------}
procedure TgtCustomWatermarkTemplate.GetXY(APageWidth, APageHeight: Double; var AXPos,
  AYPos: Double; AWidth, AHeight: Double; AMeasurementUnit: TgtMeasurementUnit);
begin
  // The Horizontal Position
  case HorizPos of
    hpCustom: AXPos := ConvertToPDFUnit(AMeasurementUnit, X);
    hpLeft: AXPos := 0;
    hpCenter: AXPos := (APageWidth / 2.0) - (AWidth / 2.0);
    hpRight: AXPos := APageWidth - AWidth;
  end;

  // The Vertical Position
  case VertPos of
    vpCustom: AYPos := ConvertToPDFUnit(AMeasurementUnit, Y);
    vpTop: AYPos := 0;
    vpMiddle: AYPos := (APageHeight / 2.0) - (AHeight / 2.0);
    vpBottom: AYPos := APageHeight - AHeight;
  end;
end;

function TgtCustomPDFDocument.ProcessControlStrings(AText: AnsiString;
  out ALineStrings: TArray): Boolean;
var
  LI, LJ: Integer;
  Ltempstr: AnsiString;
begin
  Result := False;
  Ltempstr := '';
  LJ := 0;

  for LI := 1 to Length(AText) do
  begin
    if ((AText[LI] = #10) or ((AText[LI] = #13) and (AText[LI + 1] <> #10))) then
    begin
      Result := True;
      SetLength(ALineStrings, Length(ALineStrings) + 1);
      ALineStrings[LJ] := Ltempstr;
      Inc(LJ);
      Ltempstr := '';
    end
    else if (AText[LI] <> #13) then
      Ltempstr := Ltempstr + AText[LI];

    if LI >= Length(AText) then
    begin
      SetLength(ALineStrings, Length(ALineStrings) + 1);
      ALineStrings[LJ] := Ltempstr;
      Ltempstr := '';
    end;
  end;
end;

{------------------------------------------------------------------------------}
//{ TgtAnnotationList }


{ TgtPDFURIAction }

constructor TgtPDFURIAction.Create;
begin
  FAction := TgtPDURIAction.Create;

end;
{------------------------------------------------------------------------------}
destructor TgtPDFURIAction.Destroy;
begin
  if Assigned(FAction) then
    FreeAndNil(FAction);
end;
{------------------------------------------------------------------------------}
function TgtPDFURIAction.GetURI: string;
begin
  Result := TgtPDURIAction(FAction).URI;
end;
{------------------------------------------------------------------------------}

procedure TgtPDFURIAction.SetURI(const Value: string);
begin
  TgtPDURIAction(FAction).URI := Value;
end;
{------------------------------------------------------------------------------}
{ TgtPDFGoToAction }

constructor TgtPDFGoToAction.Create(APageNo: Integer;
  ADestinationType: TgtPDFDestinationType; ATopOrLeft: Double);
begin
  FAction := TgtPDGoToAction.Create;
  PageNo := APageNo;
  DestinationType := ADestinationType;
  if ADestinationType = dtFitH then
    Top := ATopOrLeft
  else if ADestinationType = dtFitV then
    Left := ATopOrLeft;   
end;
{------------------------------------------------------------------------------}
constructor TgtPDFGoToAction.Create(APageNo: Integer;
  ADestinationType: TgtPDFDestinationType; ALeft, ABottom, ARight, ATop: Double);
begin
  FAction := TgtPDGoToAction.Create;
  PageNo := APageNo;
  DestinationType := ADestinationType;
  Left := ALeft;
  Bottom := ABottom;
  Right := ARight;
  Top := ATop;
end;
{------------------------------------------------------------------------------}
destructor TgtPDFGoToAction.Destroy;
begin
  if Assigned(FAction) then
    FreeAndNil(FAction);
end;
{------------------------------------------------------------------------------}
constructor TgtPDFGoToAction.Create(APageNo: Integer;
  ADestinationType: TgtPDFDestinationType);
begin
  FAction := TgtPDGoToAction.Create;
  PageNo := APageNo;
  DestinationType := ADestinationType;
end;
{------------------------------------------------------------------------------}
constructor TgtPDFGoToAction.Create;
begin
  FAction := TgtPDGoToAction.Create;
end;
{------------------------------------------------------------------------------}
constructor TgtPDFGoToAction.Create(APageNo: Integer;
  ADestinationType: TgtPDFDestinationType; ALeft, ATop, AZoom: Double);
var
  LRect: TgtPDRect;
begin
  FAction := TgtPDGoToAction.Create;
  PageNo := APageNo;
  DestinationType := ADestinationType;
  LRect := TgtPDGoToAction(FAction).Destination.Rect;
  LRect.Left := ALeft;
  LRect.Top := ATop;
  LRect.Right := AZoom;
end;
{------------------------------------------------------------------------------}
function TgtPDFGoToAction.GetBottom: Double;
begin
  Result := 0.0;
  if Assigned(TgtPDGoToAction(FAction).Destination.Rect) then
    Result := TgtPDGoToAction(FAction).Destination.Rect.Bottom;
end;
{------------------------------------------------------------------------------}
function TgtPDFGoToAction.GetDestinationType: TgtPDFDestinationType;
var
  LDest: TgtPDDestination;
begin
  Result := dtXYZ;
  LDest := TgtPDGoToAction(FAction).Destination;
  case LDest.DisplayOptions of
    FitZoom: Result := dtXYZ;
    FitAll: Result := dtFit;
    FitHeight: Result := dtFitH;
    FitWidth: Result := dtFitV;
    FitRect: Result := dtFitR;
    FitBoundingBox: Result := dtFitB;
    FitBoundingBoxHeight: Result := dtFitBH;
    FitBoundingBoxWidth: Result := dtFitBV;
  end;
end;
{------------------------------------------------------------------------------}
function TgtPDFGoToAction.GetLeft: Double;
begin
  Result := 0.0;
  if Assigned(TgtPDGoToAction(FAction).Destination.Rect) then
    Result := TgtPDGoToAction(FAction).Destination.Rect.Left;
end;
{------------------------------------------------------------------------------}
function TgtPDFGoToAction.GetPageNo: Integer;
begin
  Result := FPageNo;
end;
{------------------------------------------------------------------------------}
function TgtPDFGoToAction.GetRight: Double;
begin
  Result := 0.0;
  if Assigned(TgtPDGoToAction(FAction).Destination.Rect) then
    Result := TgtPDGoToAction(FAction).Destination.Rect.Right;
end;
{------------------------------------------------------------------------------}
function TgtPDFGoToAction.GetTop: Double;
begin
  Result := 0.0;
  if Assigned(TgtPDGoToAction(FAction).Destination.Rect) then
    Result := TgtPDGoToAction(FAction).Destination.Rect.Top;
end;
{------------------------------------------------------------------------------}
function TgtPDFGoToAction.GetZoom: Double;
begin
  Result := 0;
  if Assigned(TgtPDGoToAction(FAction).Destination.Rect) then
    Result := TgtPDGoToAction(FAction).Destination.Rect.Right;
end;
{------------------------------------------------------------------------------}
procedure TgtPDFGoToAction.SetBottom(const Value: Double);
begin
  if Assigned(TgtPDGoToAction(FAction).Destination.Rect) then
    TgtPDGoToAction(FAction).Destination.Rect.Bottom := Value;
end;
{------------------------------------------------------------------------------}
procedure TgtPDFGoToAction.SetDestinationType(
  const Value: TgtPDFDestinationType);
var
  LDest: TgtPDDestination;
begin
  LDest := TgtPDGoToAction(FAction).Destination;
  LDest.DisplayOptions := None;
  case Value of
    dtXYZ: LDest.DisplayOptions := FitZoom;
    dtFit: LDest.DisplayOptions := FitAll;
    dtFitH: LDest.DisplayOptions := FitHeight;
    dtFitV: LDest.DisplayOptions := FitWidth;
    dtFitR: LDest.DisplayOptions := FitRect;
    dtFitB: LDest.DisplayOptions := FitBoundingBox;
    dtFitBH: LDest.DisplayOptions := FitBoundingBoxHeight;
    dtFitBV: LDest.DisplayOptions := FitBoundingBoxWidth;
  end;
end;
{------------------------------------------------------------------------------}
procedure TgtPDFGoToAction.SetLeft(const Value: Double);
begin
  if Assigned(TgtPDGoToAction(FAction).Destination.Rect) then
    TgtPDGoToAction(FAction).Destination.Rect.Left := Value;
end;
{------------------------------------------------------------------------------}
procedure TgtPDFGoToAction.SetPageNo(const Value: Integer);
begin
  FPageNo := Value;
end;
{------------------------------------------------------------------------------}
procedure TgtPDFGoToAction.SetRight(const Value: Double);
begin
  if Assigned(TgtPDGoToAction(FAction).Destination.Rect) then
    TgtPDGoToAction(FAction).Destination.Rect.Right := Value;
end;
{------------------------------------------------------------------------------}
procedure TgtPDFGoToAction.SetTop(const Value: Double);
begin
  if Assigned(TgtPDGoToAction(FAction).Destination.Rect) then
    TgtPDGoToAction(FAction).Destination.Rect.Top := Value;
end;
{------------------------------------------------------------------------------}
procedure TgtPDFGoToAction.SetZoom(const Value: Double);
begin

  if Assigned(TgtPDGoToAction(FAction).Destination.Rect) then
    TgtPDGoToAction(FAction).Destination.Rect.Right := Value;
end;
{------------------------------------------------------------------------------}
{ TgtPDFGoToRAction }

constructor TgtPDFGoToRAction.Create(APageNo: Integer;
  ADestinationType: TgtPDFDestinationType);
begin
  FAction := TgtPDGoToRemoteAction.Create;
  PageNo := APageNo;
  DestinationType := ADestinationType;
end;
{------------------------------------------------------------------------------}
constructor TgtPDFGoToRAction.Create(APageNo: Integer;
  ADestinationType: TgtPDFDestinationType; ALeft, ATop, AZoom: Double);
begin
  FAction := TgtPDGoToRemoteAction.Create;
  PageNo := APageNo;
  DestinationType := ADestinationType;
  Left := ALeft;
  Top := ATop;
  Zoom := AZoom;
end;
{------------------------------------------------------------------------------}

constructor TgtPDFGoToRAction.Create(APageNo: Integer;
  ADestinationType: TgtPDFDestinationType; ALeft, ABottom, ARight, ATop: Double);
begin
  FAction := TgtPDGoToRemoteAction.Create;
  PageNo := APageNo;
  DestinationType := ADestinationType;
  Left := ALeft;
  Top := ATop;
  Right := ARight;
  Bottom := ABottom;
end;
{------------------------------------------------------------------------------}

constructor TgtPDFGoToRAction.Create(APageNo: Integer;
  ADestinationType: TgtPDFDestinationType; ATopOrLeft: Double);
begin
  FAction := TgtPDGoToRemoteAction.Create;
  PageNo := APageNo;
  DestinationType := ADestinationType;
  if ADestinationType = dtFitH then
    Top := ATopOrLeft
  else if ADestinationType = dtFitV then
    Left := ATopOrLeft;   
end;
{------------------------------------------------------------------------------}

constructor TgtPDFGoToRAction.Create;
begin
  FAction := TgtPDGoToRemoteAction.Create;
end;

destructor TgtPDFGoToRAction.Destroy;
begin
  if Assigned(FAction) then
    FreeAndNil(FAction);
  inherited;
end;
{------------------------------------------------------------------------------}

function TgtPDFGoToRAction.GetFileName: string;
begin
  Result := TgtPDGoToRemoteAction(FAction).FileName;
end;
{------------------------------------------------------------------------------}
function TgtPDFGoToRAction.GetOpenInNewWindow: boolean;
begin
  Result := TgtPDGoToRemoteAction(FAction).OpenInNewWindow;
end;
function TgtPDFGoToRAction.GetPageNo: Integer;
begin
  // For RGoto Action page number starts from 0
  Result := FPageNo + 1;
end;

{------------------------------------------------------------------------------}
procedure TgtPDFGoToRAction.SetFileName(const Value: string);
begin
  TgtPDGoToRemoteAction(FAction).FileName := Value;
end;
{------------------------------------------------------------------------------}
procedure TgtPDFGoToRAction.SetOpenInNewWindow(const Value: boolean);
begin
  TgtPDGoToRemoteAction(FAction).OpenInNewWindow := Value;
end;
procedure TgtPDFGoToRAction.SetPageNo(const Value: Integer);
begin
  // For RGoto Action page number starts from 0
  TgtPDGoToRemoteAction(FAction).PageNum := Value - 1;
  FPageNo := Value - 1;
end;

{------------------------------------------------------------------------------}
{ TgtPDFLaunchAction }

constructor TgtPDFLaunchAction.Create;
begin
  FAction := TgtPDLaunchAction.Create;
end;
{------------------------------------------------------------------------------}
destructor TgtPDFLaunchAction.Destroy;
begin
  if Assigned(FAction) then
    FreeAndNil(FAction);
end;
{------------------------------------------------------------------------------}
function TgtPDFLaunchAction.GetApplicationToLaunch: string;
begin
  Result := TgtPDLaunchAction(FAction).ApplicationToLaunch;
end;
{------------------------------------------------------------------------------}
function TgtPDFLaunchAction.GetLaunchActionType: TgtLaunchActionType;
begin
  Result := TgtLaunchActionType(TgtPDLaunchAction(FAction).LaunchActionType);
end;
{------------------------------------------------------------------------------}
function TgtPDFLaunchAction.GetOpenInNewWindow: Boolean;
begin
  Result := TgtPDLaunchAction(FAction).OpenInNewWindow;
end;
{------------------------------------------------------------------------------}
function TgtPDFLaunchAction.GetParameterToApplication: string;
begin
  Result := TgtPDLaunchAction(FAction).ApplicationParameter;
end;
{------------------------------------------------------------------------------}
procedure TgtPDFLaunchAction.SetApplicationToLaunch(const Value: string);
begin
  TgtPDLaunchAction(FAction).ApplicationToLaunch := Value;
end;
{------------------------------------------------------------------------------}
procedure TgtPDFLaunchAction.SetLaunchActionType(
  const Value: TgtLaunchActionType);
begin
  case Value of
    atOpen: TgtPDLaunchAction(FAction).LaunchActionType := ltOpen;
    atPrint: TgtPDLaunchAction(FAction).LaunchActionType := ltPrint;
  end;
end;
{------------------------------------------------------------------------------}
procedure TgtPDFLaunchAction.SetOpenInNewWindow(const Value: Boolean);
begin
  TgtPDLaunchAction(FAction).OpenInNewWindow := Value;
end;
{------------------------------------------------------------------------------}
procedure TgtPDFLaunchAction.SetParameterToApplication(const Value: string);
begin
  TgtPDLaunchAction(FAction).ApplicationParameter := Value;
end;
{------------------------------------------------------------------------------}
{ TgtPDFJavaScriptAction }

constructor TgtPDFJavaScriptAction.Create;
begin
  FAction := TgtPDJavaScriptAction.Create;
end;
{------------------------------------------------------------------------------}
destructor TgtPDFJavaScriptAction.Destroy;
begin
  if Assigned(FAction) then
    FreeAndNil(FAction);
end;
{------------------------------------------------------------------------------}
function TgtPDFJavaScriptAction.GetJavaScript: string;
begin
  Result := TgtPDJavaScriptAction(FAction).JavaScript;
end;
{------------------------------------------------------------------------------}
procedure TgtPDFJavaScriptAction.SetJavaScript(const Value: string);
begin
  TgtPDJavaScriptAction(FAction).JavaScript := Value;
end;
{------------------------------------------------------------------------------}

//initialization
////  startGDIPlus;
//
//finalization
//  stopGDIPlus;

{------------------------------------------------------------------------------}

{ TgtPDFViewerPreferences }

function TgtPDFViewerPreferences.Clone: TgtPDFViewerPreferences;
begin
  Result := TgtPDFViewerPreferences.Create;
  Result.FPDFViewerPref := Self.FPDFViewerPref;
end;

constructor TgtPDFViewerPreferences.Create;
begin

end;

constructor TgtPDFViewerPreferences.Create(Doc: TgtPDDocument);
begin
  FPDFViewerPref := Doc.GetViewerPref;
end;

destructor TgtPDFViewerPreferences.Destroy;
begin
  inherited;
end;

function TgtPDFViewerPreferences.GetCenterWindow: Boolean;
begin
  Result := FPDFViewerPref.CenterWindow;
end;

function TgtPDFViewerPreferences.GetDisplayDocTitle: Boolean;
begin
  Result := FPDFViewerPref.DisplayDocTitle;
end;

function TgtPDFViewerPreferences.GetFitWindow: Boolean;
begin
  Result := FPDFViewerPref.FitWindow;
end;

function TgtPDFViewerPreferences.GetHideMenubar: Boolean;
begin
  Result := FPDFViewerPref.HideMenuBar;
end;

function TgtPDFViewerPreferences.GetHideToolbar: Boolean;
begin
  Result := FPDFViewerPref.HideToolBar;
end;

function TgtPDFViewerPreferences.GetHideWindowUI: Boolean;
begin
  Result := FPDFViewerPref.HideWindowUI;
end;

procedure TgtPDFViewerPreferences.SetCenterWindow(const Value: Boolean);
begin
  FPDFViewerPref.CenterWindow := Value;
end;

procedure TgtPDFViewerPreferences.SetDisplayDocTitle(const Value: Boolean);
begin
  FPDFViewerPref.DisplayDocTitle := Value;
end;

procedure TgtPDFViewerPreferences.SetFitWindow(const Value: Boolean);
begin
  FPDFViewerPref.FitWindow := Value;
end;

procedure TgtPDFViewerPreferences.SetHideMenubar(const Value: Boolean);
begin
  FPDFViewerPref.HideMenuBar := Value;
end;

procedure TgtPDFViewerPreferences.SetHideToolbar(const Value: Boolean);
begin
  FPDFViewerPref.HideToolBar := Value;
end;

procedure TgtPDFViewerPreferences.SetHideWindowUI(const Value: Boolean);
begin
  FPDFViewerPref.HideWindowUI := Value;
end;

{------------------------------------------------------------------------------}

{ TgtPDFAction }

constructor TgtPDFAction.Create(AObject: TgtPDAction);
begin
  FAction := AObject;
end;

{ TgtOutlineList }

function TgtOutlineList.Get(Index: Integer): TgtPDFOutline;
begin
  Result := TgtPDFOutline(inherited Get(Index));
end;

procedure TgtOutlineList.Notify(Ptr: Pointer; Action: TListNotification);
begin
  if Action in [lnExtracted, lnDeleted] then
    if Assigned(Ptr) then
      TgtPDFOutline(Ptr).Free;
end;

initialization;
//  TgtPDDocument.StartGDIPlus;

finalization;
//  TgtPDDocument.StopGDIPlus;

end.
{------------------------------------------------------------------------------}
