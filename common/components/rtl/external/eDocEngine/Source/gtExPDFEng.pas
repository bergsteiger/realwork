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
unit gtExPDFEng;

interface

uses
  Windows, Classes, Graphics, SysUtils, gtUtils3, gtDocUtils, gtConsts3,
  gtDocConsts, gtCstPlnEng, gtCstDocEng, gtCstPDFEng, gtclasses3, gtPDFFont3,
  forms;

type

  { ------------------------------------------------------------------------------ }
  { Annotations }
  { ------------------------------------------------------------------------------ }

  (*
    Annotation Types
    Text, Link, FreeText, Line, Square, Circle, Highlight, Underline,
    Squiggly, StrikeOut, Stamp, Ink, Popup, FileAttachment, Sound, Movie,
    Widget, PrinterMark, TrapNet
  *)
  TgtAnnotationType = (atText, atLink, atLine, atSquare, atCircle, atTextMarkup,
    atFreeText, atCaret);

  (* Annotation Flags *)
  TgtAnnotationPreferenceType = (apInvisible, apHidden, apPrint, apNoZoom,
    apNoRotate, apNoView, apReadOnly);

  TgtAnnotationPreference = set of TgtAnnotationPreferenceType;

  TgtAnnotHighlightMode = (hmNone, hmInvertContent, hmInvertBorder, hmPushed);

  TgtAnnotBrush = class(TObject)
  private
    FWidth: Integer;
    FStyle: TgtAnnotBrushStyle;
    procedure SetStyle(const Value: TgtAnnotBrushStyle);
    procedure SetWidth(const Value: Integer);

  public
    constructor Create;
    destructor Destroy; override;

    property Style: TgtAnnotBrushStyle read FStyle write SetStyle
      default absSolid;
    property Width: Integer read FWidth write SetWidth default 1;

  end;

  (*
    Annotation Action Types.
    GotTo, GoToR, Launch, Thread, URI, Sound, Movie, Hide, Named

    Additional Form Action Types.
    SubmitForm, ResetForm, ImportData, JavaScript.
  *)

  TgtAnnotActionType = (aaGoTo, aaURI, aaNamed, aaGoToR, aaLaunch,
    aaJavaScript);

  (* Annotation Action Dictionary. *)
  TgtAnnotAction = class(TObject)
  private
    FSubType: TgtAnnotActionType;

  protected
    property SubType: TgtAnnotActionType read FSubType;

  public
    constructor Create;
    destructor Destroy; override;

  end;

  (*
    GoTo Action Options.
    /Fit, /FitH, /FitV, /FitR, /FitB, /FitBH, /FitBV.
  *)
  TgtGoToOptions = (goDefault, goFit, goFitWidth, goFitHeight, goFitRect);

  TgtZoom = 1 .. 16;

  (* GoTo Action. *)
  TgtAnnotGoToAction = class(TgtAnnotAction)
  private
    FPage: Integer;
    FZoom: TgtZoom;
    FOptions: TgtGoToOptions;
    FRect: TgtRect;
    procedure SetOptions(const Value: TgtGoToOptions);
    procedure SetPage(const Value: Integer);
    procedure SetRect(const Value: TgtRect);
    procedure SetZoom(const Value: TgtZoom);

  public
    constructor Create;
    destructor Destroy; override;

    property Page: Integer read FPage write SetPage default 1;
    property Rect: TgtRect read FRect write SetRect;
    property Zoom: TgtZoom read FZoom write SetZoom default 1;
    property Options: TgtGoToOptions read FOptions write SetOptions
      default goDefault;
  end;

  (* Link Action. *)
  TgtAnnotLinkAction = class(TgtAnnotAction)
  private
    FURI: String;
    procedure SetURI(const Value: String);

  protected

  public
    constructor Create;
    destructor Destroy; override;

    property URI: String read FURI write SetURI;

  end;

  TgtActionName = (anNextPage, anPrevPage, anFirstPage, anLastPage);

  TgtAnnotNamedAction = class(TgtAnnotAction)
  private
    FActionName: TgtActionName;
    procedure SetActionName(const Value: TgtActionName);
  public
    constructor Create;
    destructor Destroy; override;
    property ActionName: TgtActionName read FActionName write SetActionName;
  end;

  TgtAnnotRemoteGotoAction = class(TgtAnnotAction)
  private
    FFilePath: String;
    FPage: Integer;
    FOptions: TgtGoToOptions;
    FRect: TgtRect;
    FZoom: TgtZoom;
    FNewWindow: Boolean;
    procedure SetFilePath(const Value: String);
    procedure SetOptions(const Value: TgtGoToOptions);
    procedure SetPage(const Value: Integer);
    procedure SetRect(const Value: TgtRect);
    procedure SetZoom(const Value: TgtZoom);
  public
    constructor Create;
    destructor Destroy; override;
    property FilePath: String read FFilePath write SetFilePath;
    property Page: Integer read FPage write SetPage default 1;
    property Rect: TgtRect read FRect write SetRect;
    property Zoom: TgtZoom read FZoom write SetZoom default 1;
    property Options: TgtGoToOptions read FOptions write SetOptions
      default goDefault;
    property NewWindow: Boolean read FNewWindow write FNewWindow default True;
  end;

  TgtAnnotLaunchAction = class(TgtAnnotAction)
  private
    FFilePath: String;
    FNewWindow: Boolean;
    procedure SetFilePath(const Value: String);
  public
    constructor Create;
    destructor Destroy; override;
    property FilePath: String read FFilePath write SetFilePath;
    property NewWindow: Boolean read FNewWindow write FNewWindow default True;
  end;

  TgtAnnotJSAction = class(TgtAnnotAction)
  private
    FJavaScript: String;
    procedure SetJavaScript(const Value: String);
  public
    constructor Create;
    destructor Destroy; override;
    property JavaScript: String read FJavaScript write SetJavaScript;
  end;

  TgtPDFAnnot = class(TObject)
  private
    FRect: TgtRect;
    FBrush: TgtAnnotBrush;
    FAction: TgtAnnotAction;
    FBackgroundColor: TColor;
    FBorderColor: TColor;
    FContents: WideString;
    FTitle: WideString;
    FSubject: WideString;
    procedure SetRect(const Value: TgtRect);
    procedure SetBrush(const Value: TgtAnnotBrush);
    procedure SetAction(const Value: TgtAnnotAction);
    procedure SetBackgroundColor(const Value: TColor);
    procedure SetBorderColor(const Value: TColor);
    procedure SetContents(const Value: WideString);

  protected
    FPageNo: Integer;
    property Action: TgtAnnotAction read FAction write SetAction;
    property Brush: TgtAnnotBrush read FBrush write SetBrush;
    property BorderColor: TColor read FBorderColor write SetBorderColor
      default clBlack;
    property BackgroundColor: TColor read FBackgroundColor
      write SetBackgroundColor default clWhite;
    property Rect: TgtRect read FRect write SetRect;
    property Contents: WideString read FContents write SetContents;
    property Title: WideString read FTitle write FTitle;
    property Subject: WideString read FSubject write FSubject;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TgtTextNote = (tnComment, tnKey, tnNote, tnHelp, tnNewParagraph, tnParagraph,
    tnInsert);

  TgtPDFTextAnnot = class(TgtPDFAnnot)
  private
    FName: TgtTextNote;
    FOpen: Boolean;
    procedure SetName(const Value: TgtTextNote);
    procedure SetOpen(const Value: Boolean);

  public
    constructor Create;
    destructor Destroy; override;

    property Name: TgtTextNote read FName write SetName default tnNote;
    property Open: Boolean read FOpen write SetOpen default False;
    property Rect;
    property BorderColor;
    property Contents;
    property Title;
    property Subject;
  end;

  TgtAlign = (taLeft, taRight, taCenter);

  TgtPDFFreeTextAnnot = class(TgtPDFAnnot)
  private
    FTextFont: TFont;
    FTextAlign: TgtAlign;
    FTextColor: TColor;
    procedure SetTextAlign(const Value: TgtAlign);
    procedure SetTextFont(const Value: TFont);
    procedure SetTextColor(const Value: TColor);
  public
    constructor Create;
    destructor Destroy; override;

    property TextFont: TFont read FTextFont write SetTextFont;
    property TextAlign: TgtAlign read FTextAlign write SetTextAlign;
    property TextColor: TColor read FTextColor write SetTextColor;
    property Rect;
    property Contents;
    property BorderColor;
  end;

  TgtPDFLinkAnnot = class(TgtPDFAnnot)
  private
    FHighlightMode: TgtAnnotHighlightMode;
    FBorderWidth: Byte;
    procedure SetHighlightMode(const Value: TgtAnnotHighlightMode);
    procedure SetBorderWidth(const Value: Byte);

  public
    constructor Create;
    destructor Destroy; override;

    property BorderColor;

    (*
      In PDF 1.4, all of the standard annotation types except Link
      use BS rather than Border.
    *)
    property BorderWidth: Byte read FBorderWidth write SetBorderWidth default 0;
    property Action;
    property HighlightMode: TgtAnnotHighlightMode read FHighlightMode
      write SetHighlightMode default hmNone;
    property Rect;
  end;

  { TgtLine }
  TgtLine = record
    Left, Top, Right, Bottom: Double;
  end;

  TgtLineStyle = (lsNone, lsButt, lsSquare, lsCircle, lsDiamond, lsOpenArrow,
    lsClosedArrow, lsROpenArrow, lsRClosedArrow);

  TgtBorderStyle = (brSolid, brDashed, brBeveled, brInset, brUnderline);

  TgtPDFLineAnnot = class(TgtPDFAnnot)
  private
    FLine: TgtLine;
    FStartStyle: TgtLineStyle;
    FEndStyle: TgtLineStyle;
    FBorderStyle: TgtBorderStyle;
    FBorderWidth: Byte;
    FBorderPattern: String;
    FInteriorColor: TColor;
    procedure SetBorderStyle(const Value: TgtBorderStyle);
    procedure SetStartStyle(const Value: TgtLineStyle);
    procedure SetEndStyle(const Value: TgtLineStyle);
    procedure SetBorderWidth(const Value: Byte);
    procedure SetBorderPattern(const Value: String);
    procedure SetLine(const Value: TgtLine);
    procedure SetInteriorColor(const Value: TColor);
  public
    constructor Create;
    destructor Destroy; override;
    function gtLine(Left, Top, Right, Bottom: Double): TgtLine;
    property BorderStyle: TgtBorderStyle read FBorderStyle write SetBorderStyle
      default brSolid;
    property BorderWidth: Byte read FBorderWidth write SetBorderWidth default 0;
    property StartStyle: TgtLineStyle read FStartStyle write SetStartStyle
      default lsNone;
    property EndStyle: TgtLineStyle read FEndStyle write SetEndStyle
      default lsNone;
    property BorderPattern: String read FBorderPattern write SetBorderPattern;
    property Line: TgtLine read FLine write SetLine;
    property InteriorColor: TColor read FInteriorColor write SetInteriorColor
      default clWhite;
    property Contents;
    property BorderColor;
    property Title;
    property Subject;
  end;

  TgtIntensity = 0 .. 2;

  TgtPDFSquareAnnot = class(TgtPDFAnnot)
  private
    FBorderWidth: Byte;
    FBorderStyle: TgtBorderStyle;
    FBorderPattern: String;
    FInteriorColor: TColor;
    FCloudy: Boolean;
    FCloudIntensity: TgtIntensity;
    FDifferRect: TgtRect;
    procedure SetBorderStyle(const Value: TgtBorderStyle);
    procedure SetBorderWidth(const Value: Byte);
    procedure SetBorderPattern(const Value: String);
    procedure SetInteriorColor(const Value: TColor);
    procedure SetCloudy(const Value: Boolean);
    procedure SetCloudIntensity(const Value: TgtIntensity);
    procedure SetDifferRect(const Value: TgtRect);

  public
    constructor Create;
    destructor Destroy; override;
    property BorderStyle: TgtBorderStyle read FBorderStyle write SetBorderStyle
      default brSolid;
    property BorderWidth: Byte read FBorderWidth write SetBorderWidth default 0;
    property BorderPattern: String read FBorderPattern write SetBorderPattern;
    property InteriorColor: TColor read FInteriorColor write SetInteriorColor
      default clWhite;
    property Cloudy: Boolean read FCloudy write SetCloudy default False;
    property CloudIntensity: TgtIntensity read FCloudIntensity
      write SetCloudIntensity default 0;
    property DifferRect: TgtRect read FDifferRect write SetDifferRect;
    property Rect;
    property BorderColor;
    property Contents;
    property Title;
    property Subject;
  end;

  TgtPDFCircleAnnot = class(TgtPDFAnnot)
  private
    FBorderWidth: Byte;
    FBorderStyle: TgtBorderStyle;
    FBorderPattern: String;
    FInteriorColor: TColor;
    FCloudy: Boolean;
    FCloudIntensity: TgtIntensity;
    FDifferRect: TgtRect;
    procedure SetBorderStyle(const Value: TgtBorderStyle);
    procedure SetBorderWidth(const Value: Byte);
    procedure SetBorderPattern(const Value: String);
    procedure SetInteriorColor(const Value: TColor);
    procedure SetCloudy(const Value: Boolean);
    procedure SetCloudIntensity(const Value: TgtIntensity);
    procedure SetDifferRect(const Value: TgtRect);

  public
    constructor Create;
    destructor Destroy; override;
    property BorderStyle: TgtBorderStyle read FBorderStyle write SetBorderStyle
      default brSolid;
    property BorderWidth: Byte read FBorderWidth write SetBorderWidth default 0;
    property BorderPattern: String read FBorderPattern write SetBorderPattern;
    property InteriorColor: TColor read FInteriorColor write SetInteriorColor
      default clWhite;
    property Cloudy: Boolean read FCloudy write SetCloudy default False;
    property DifferRect: TgtRect read FDifferRect write SetDifferRect;
    property CloudIntensity: TgtIntensity read FCloudIntensity
      write SetCloudIntensity default 0;
    property Rect;
    property BorderColor;
    property Contents;
    property Title;
    property Subject;
  end;

  TgtPDFPolygonAnnot = class(TgtPDFAnnot)
  private
    FCloudy: Boolean;
    FBorderWidth: Byte;
    FBorderPattern: String;
    FInteriorColor: TColor;
    FBorderStyle: TgtBorderStyle;
    FCloudIntensity: TgtIntensity;
    FVertices: TgtPoints;
    procedure SetBorderPattern(const Value: String);
    procedure SetBorderStyle(const Value: TgtBorderStyle);
    procedure SetBorderWidth(const Value: Byte);
    procedure SetCloudIntensity(const Value: TgtIntensity);
    procedure SetCloudy(const Value: Boolean);
    procedure SetInteriorColor(const Value: TColor);

  public
    constructor Create;
    destructor Destroy; override;

    procedure SetVertices(const Vertices: array of TgtPoint);
    function GetVertices: TgtPoints;

    property BorderStyle: TgtBorderStyle read FBorderStyle write SetBorderStyle
      default brSolid;
    property BorderWidth: Byte read FBorderWidth write SetBorderWidth default 0;
    property BorderPattern: String read FBorderPattern write SetBorderPattern;
    property InteriorColor: TColor read FInteriorColor write SetInteriorColor
      default clWhite;
    property Cloudy: Boolean read FCloudy write SetCloudy default False;
    property CloudIntensity: TgtIntensity read FCloudIntensity
      write SetCloudIntensity default 0;
    property Rect;
    property Contents;
    property BorderColor;
    property Title;
    property Subject;
  end;

  TgtPDFPolylineAnnot = class(TgtPDFAnnot)
  private
    FCloudy: Boolean;
    FBorderWidth: Byte;
    FBorderPattern: String;
    FInteriorColor: TColor;
    FBorderStyle: TgtBorderStyle;
    FCloudIntensity: TgtIntensity;
    FVertices: TgtPoints;
    FEndStyle: TgtLineStyle;
    FStartStyle: TgtLineStyle;
    procedure SetBorderPattern(const Value: String);
    procedure SetBorderStyle(const Value: TgtBorderStyle);
    procedure SetBorderWidth(const Value: Byte);
    procedure SetCloudIntensity(const Value: TgtIntensity);
    procedure SetCloudy(const Value: Boolean);
    procedure SetInteriorColor(const Value: TColor);
    procedure SetEndStyle(const Value: TgtLineStyle);
    procedure SetStartStyle(const Value: TgtLineStyle);

  public
    constructor Create;
    destructor Destroy; override;

    procedure SetVertices(const Vertices: array of TgtPoint);
    property BorderStyle: TgtBorderStyle read FBorderStyle write SetBorderStyle
      default brSolid;
    property BorderWidth: Byte read FBorderWidth write SetBorderWidth default 0;
    property BorderPattern: String read FBorderPattern write SetBorderPattern;
    property InteriorColor: TColor read FInteriorColor write SetInteriorColor
      default clWhite;
    property Cloudy: Boolean read FCloudy write SetCloudy default False;
    property CloudIntensity: TgtIntensity read FCloudIntensity
      write SetCloudIntensity default 0;
    property StartStyle: TgtLineStyle read FStartStyle write SetStartStyle
      default lsNone;
    property EndStyle: TgtLineStyle read FEndStyle write SetEndStyle
      default lsNone;
    property Rect;
    property Contents;
    property BorderColor;
    property Title;
    property Subject;
  end;

  TgtTextStyle = (tsHighlight, tsUnderline, tsSquiggly, tsStrikeOut);

  TgtPDFTextMarkupAnnot = class(TgtPDFAnnot)
  private
    FTextStyle: TgtTextStyle;
    FQuadPoints: TgtPoints;
    procedure SetTextStyle(const Value: TgtTextStyle);
  public
    constructor Create;
    destructor Destroy; override;

    procedure SetQuadPoints(const QuadPoints: array of TgtPoint);

    property TextStyle: TgtTextStyle read FTextStyle write SetTextStyle
      default tsHighlight;
    property BorderColor;
    property Contents;
    property Title;
    property Subject;
  end;

  TgtPDFCaretAnnot = class(TgtPDFAnnot)
  private
    FSymbol: Boolean;
    FDifferRect: TgtRect;
    procedure SetDifferRect(const Value: TgtRect);
  public
    constructor Create;
    destructor Destroy; override;

    property DifferRect: TgtRect read FDifferRect write SetDifferRect;
    property Rect;
    property Contents;
    property BorderColor;
    property Title;
    property Subject;
  end;

  TgtInkPoints = array of TgtPoint;

  TgtPDFInkAnnot = class(TgtPDFAnnot)
  private
    FInkPoints: TgtInkPoints;
  public
    constructor Create;
    destructor Destroy; override;
    procedure SetInkPoints(const InkPoints: array of TgtPoint);
    property BorderColor;
    property Contents;
    property Title;
    property Subject;
  end;

  TgtStampType = (stApproved, stExperimental, stNotApproved, stAsIs, stExpired,
    stNotForPublicRelease, stConfidential, stFinal, stSold, stDepartmental,
    stForComment, stTopSecret, stDraft, stForPublicRelease);

  TgtPDFStampAnnot = class(TgtPDFAnnot)
  private
    FStampType: TgtStampType;
    procedure SetStampType(const Value: TgtStampType);
  public
    constructor Create;
    destructor Destroy; override;
    property StampType: TgtStampType read FStampType write SetStampType
      default stDraft;
    property BorderColor;
    property Rect;
    property Contents;
    property Title;
    property Subject;
  end;

  TgtFileAttachmentIcon = (faGraph, faPaperclip, faPushPin, faTag);

  TgtPDFFileAttachmentAnnot = class(TgtPDFAnnot)
  private
    FFileAttachmentIcon: TgtFileAttachmentIcon;
    FAttachedFileName: String;
    procedure SetAttachedFileName(const Value: String);
  public
    constructor Create;
    destructor Destroy; override;
    property AttachedFileName: String read FAttachedFileName
      write SetAttachedFileName;
    property FileAttachmentIcon: TgtFileAttachmentIcon read FFileAttachmentIcon
      write FFileAttachmentIcon default faPushPin;
    property BorderColor;
    property Title;
    property Contents;
    property Rect;
    property Subject;
  end;

  { ------------------------------------------------------------------------------ }
  { TgtPDFCustomDocInfo }
  { ------------------------------------------------------------------------------ }

  TgtCustomDocInfoSchema = (schAdobePDF, schBasic, schDublinCore, schJobTicket,
    schRightsManagement, schPagedText);

  TgtPDFCustomDocInfo = class(TObject)
  private
    FSchema: TgtCustomDocInfoSchema;
    FURI: String;
    FName: String;
    FValue: String;

  public
    constructor Create;
    destructor Destroy; override;

    // published
    property Schema: TgtCustomDocInfoSchema read FSchema write FSchema
      default schAdobePDF;
    property URI: String read FURI write FURI;
    property Name: String read FName write FName;
    property Value: String read FValue write FValue;
  end;

  { ------------------------------------------------------------------------------ }
  { TgtPDFField }
  { ------------------------------------------------------------------------------ }

  TgtAcroFieldPreferencesType = (afpReadOnly, afpRequired, afpNoExport);

  TgtAcroFieldPreferences = set of TgtAcroFieldPreferencesType;

  TgtAcroFieldRotationAngle = (afra0, afra90, afra180, afra270);

  TgtPDFFormField = class(TObject)
  private
    FFieldName: String;
    FDefaultValue: String;
    FPreferences: TgtAcroFieldPreferences;
    {
      (* To be Implemented *)
      FRotation: TgtAcroFieldRotationAngle;
    }
    FBorderColor: TColor;
    FBackgroundColor: TColor;
    FRect: TgtRect;
    FValue: String;
    FFont: TFont;
    FAltFeildName: String;
    FVisible: Boolean;

    procedure SetFieldName(const Value: String);
    procedure SetBackgroundColor(const Value: TColor);
    procedure SetBorderColor(const Value: TColor);
    procedure SetDefaultValue(const Value: String);
    procedure SetPreferences(const Value: TgtAcroFieldPreferences);
    {
      (* To be Implemented *)
      procedure SetRotation(const Value: TgtAcroFieldRotationAngle);
    }
    procedure SetRect(Value: TgtRect);
    procedure SetValue(const Value: String);
    procedure SetFont(const Value: TFont);
    procedure SetAltFeildName(const Value: String);
    procedure SetVisible(const Value: Boolean);

  protected
    FPageNo: Integer;
    FFontIndex: Integer;

    (*
      Properties not used in PushButton.
    *)
    property Value: String read FValue write SetValue;
    property DefaultValue: String read FDefaultValue write SetDefaultValue;
    property Font: TFont read FFont write SetFont;
    property FieldName: String read FFieldName write SetFieldName;
    property Preferences: TgtAcroFieldPreferences read FPreferences
      write SetPreferences;
    property BorderColor: TColor read FBorderColor write SetBorderColor
      default clBlack;
    property BackgroundColor: TColor read FBackgroundColor
      write SetBackgroundColor default clWhite;
    property Rect: TgtRect read FRect write SetRect;
    property AltFieldName: String read FAltFeildName write SetAltFeildName;
    property Visible: Boolean read FVisible write SetVisible default True;
    property PageNo: Integer read FPageNo write FPageNo;
  public
    {
      (* To be Implemented *)
      property Rotation: TgtAcroFieldRotationAngle read FRotation
      write SetRotation default afra0;
    }
    constructor Create;
    destructor Destroy; override;
  end;

  TgtAcroPushButtonPosition = (apbpCaption, apbpIcon, apbpCaptionBelowIcon,
    apbpCaptionAboveIcon, apbpCaptionRightOfIcon, apbpCaptionLeftOfIcon,
    apbpCaptionOnIcon);

  TgtAcroIconScale = (aisAlways, aisIconBigger, aisIconSmaller, aisNever);
  (*
    Scale Type
    Anamorphic Scale = Fit ignoring aspect ratio.
    Proportional Scale = Maintain aspect ratio.
  *)
  TgtAcroIconScaleType = (aistFit, aistAspectRatio);

  TgtAcroIconAttribute = class(TObject)
  private
    FScale: TgtAcroIconScale;
    FScaleType: TgtAcroIconScaleType;
    FLeftSpace: Double;
    FBottomSpace: Double;
    procedure SetScale(const Value: TgtAcroIconScale);
    procedure SetScaleType(const Value: TgtAcroIconScaleType);
    procedure SetBottomSpace(const Value: Double);
    procedure SetLeftSpace(const Value: Double);

  public
    property Scale: TgtAcroIconScale read FScale write SetScale
      default aisAlways;
    property ScaleType: TgtAcroIconScaleType read FScaleType write SetScaleType
      default aistAspectRatio;
    property LeftSpace: Double read FLeftSpace write SetLeftSpace;
    property BottomSpace: Double read FBottomSpace write SetBottomSpace;

    constructor Create;
    destructor Destroy; override;

  end;

  TgtPushButtonAction = (pbaNone, pbaSubmit, pbaReset, pbaJavaScript);

  TgtFormSubmitFormat = (fsfHTML, fsfFDF, fsfXML);

  TgtPDFFormPushButton = class(TgtPDFFormField)
  private
    FNormalCaption: String;
    FRolloverCaption: String;
    FDownCaption: String;
    {
      (* To be Implemented *)
      FNormalIcon: TGraphic;
      FRolloverIcon: TGraphic;
      FDownIcon: TGraphic;
      FPositionCaption: TgtAcroPushButtonPosition;
      FIconAttribute: TgtAcroIconAttribute;
    }
    FJavaScript: String;
    FSubmitURL: String;
    FAction: TgtPushButtonAction;
    FFormSubmitFormat: TgtFormSubmitFormat;
    procedure SetDownCaption(const Value: String);
    {
      (* To be Implemented *)
      procedure SetDownIcon(const Value: TGraphic);
      procedure SetIconAttribute(const Value: TgtAcroIconAttribute);
    }
    procedure SetNormalCaption(const Value: String);
    {
      (* To be Implemented *)
      procedure SetNormalIcon(const Value: TGraphic);
      procedure SetPositionCaption(const Value: TgtAcroPushButtonPosition);
    }
    procedure SetRolloverCaption(const Value: String);
    {
      (* To be Implemented *)
      procedure SetRolloverIcon(const Value: TGraphic);
    }
    procedure SetAction(const Value: TgtPushButtonAction);
    procedure SetJavaScript(const Value: String);
    procedure SetSubmitURL(const Value: String);
    procedure SetFormSubmitFormat(const Value: TgtFormSubmitFormat);

  public
    property Font;
    property FieldName;
    property Preferences;
    property BorderColor;
    property BackgroundColor;
    property Rect;
    property AltFieldName;
    property Visible;
    property NormalCaption: String read FNormalCaption write SetNormalCaption;
    property RolloverCaption: String read FRolloverCaption
      write SetRolloverCaption;
    property DownCaption: String read FDownCaption write SetDownCaption;
    {
      (* To be Implemented *)
      property NormalIcon: TGraphic read FNormalIcon write SetNormalIcon;
      property RolloverIcon: TGraphic read FRolloverIcon write SetRolloverIcon;
      property DownIcon: TGraphic read FDownIcon write SetDownIcon;
      property PositionCaption: TgtAcroPushButtonPosition read FPositionCaption
      write SetPositionCaption default apbpCaption;
      property IconAttribute: TgtAcroIconAttribute read FIconAttribute
      write SetIconAttribute;
    }
    property Action: TgtPushButtonAction read FAction write SetAction
      default pbaNone;
    property JavaScript: String read FJavaScript write SetJavaScript;
    property SubmitURL: String read FSubmitURL write SetSubmitURL;
    property FormSubmitFormat: TgtFormSubmitFormat read FFormSubmitFormat
      write SetFormSubmitFormat default fsfHTML;

    constructor Create;
    destructor Destroy; override;

  end;

  TgtPDFFormCheckboxSymbol = (pfcsCheck, pfcsCircle, pfcsCross, pfcsDiamond,
    pfcsSquare, pfcsStar);

  TgtPDFFormCheckBox = class(TgtPDFFormField)
  private
    {
      (* To be Implemented *)
      FCaption: String;
    }
    FSymbol: TgtPDFFormCheckboxSymbol;
    FChecked: Boolean;

    {
      (* To be Implemented *)
      procedure SetCaption(const Value: String);
    }
    procedure SetSymbol(const Value: TgtPDFFormCheckboxSymbol);
    procedure SetChecked(const Value: Boolean);

  public
    property Font;
    property FieldName;
    property Preferences;
    property BorderColor;
    property BackgroundColor;
    property Rect;
    {
      (* To be Implemented *)
      property Caption: String read FCaption write SetCaption;
    }
    property Symbol: TgtPDFFormCheckboxSymbol read FSymbol write SetSymbol
      default pfcsCheck;
    property Checked: Boolean read FChecked write SetChecked default False;

    constructor Create;
    destructor Destroy; override;
  end;

  TgtPDFFormRadioItem = class(TgtPDFFormField)
  private

  public
    constructor Create;
    destructor Destroy; override;

    property Value;
    property BorderColor;
    property BackgroundColor;
    property Rect;

  end;

  TgtPDFFormRadioButton = class(TgtPDFFormField)
  private
    {
      (* To be Implemented *)
      FCaption: String;
    }
    FItems: TStringList;
    FSelectedItemIndex: Integer;
    FAtleastOneSelectedItem: Boolean;
    FSymbol: TgtPDFFormCheckboxSymbol;
    {
      (* To be Implemented *)
      procedure SetCaption(const Value: String);
    }
    procedure SetSelectedItemIndex(const Value: Integer);
    procedure SetAtleastOneSelectedItem(const Value: Boolean);
    procedure SetSymbol(const Value: TgtPDFFormCheckboxSymbol);

  public
    property Font;
    property FieldName;
    property Preferences;

    {
      (* To be Implemented *)
      property Caption: String read FCaption write SetCaption;
    }
    property SelectedItemIndex: Integer read FSelectedItemIndex
      write SetSelectedItemIndex default -1;
    property Symbol: TgtPDFFormCheckboxSymbol read FSymbol write SetSymbol
      default pfcsCheck;
    property AtleastOneSelectedItem: Boolean read FAtleastOneSelectedItem
      write SetAtleastOneSelectedItem default False;

    constructor Create;
    destructor Destroy; override;
    function AddItem(RadioItem: TgtPDFFormRadioItem): Integer;

  end;

  TgtPDFFormTextField = class(TgtPDFFormField)
  private
    FIsMultiline: Boolean;
    FIsPassword: Boolean;
    FIsFileSelect: Boolean;
    FIsDoNotSpellCheck: Boolean;
    FIsDoNotScroll: Boolean;
    FMaxLength: Integer;
    FIsBorder: Boolean;
    FHAlignment: TgtAlign;

    procedure SetIsDoNotScroll(const Value: Boolean);
    procedure SetIsDoNotSpellCheck(const Value: Boolean);
    procedure SetIsFileSelect(const Value: Boolean);
    procedure SetIsMultiline(const Value: Boolean);
    procedure SetIsPassword(const Value: Boolean);
    procedure SetMaxLength(const Value: Integer);
    procedure SetIsBorder(const Value: Boolean);
    procedure SetHAlignment(const Value: TgtAlign);

  public
    constructor Create;
    destructor Destroy; override;

    property Value;
    property Font;
    property FieldName;
    property Preferences;
    property BorderColor;
    property BackgroundColor;
    property Rect;

    property IsMultiline: Boolean read FIsMultiline write SetIsMultiline
      default False;
    property IsPassword: Boolean read FIsPassword write SetIsPassword
      default False;
    property IsFileSelect: Boolean read FIsFileSelect write SetIsFileSelect
      default False;
    property IsDoNotSpellCheck: Boolean read FIsDoNotSpellCheck
      write SetIsDoNotSpellCheck default False;
    property IsDoNotScroll: Boolean read FIsDoNotScroll write SetIsDoNotScroll
      default False;
    property MaxLength: Integer read FMaxLength write SetMaxLength default -1;
    property IsBorder: Boolean read FIsBorder write SetIsBorder default True;
    property HAlignment: TgtAlign read FHAlignment write SetHAlignment
      default taLeft;

  end;

  TgtPDFFormSignatureField = class(TgtPDFFormField)
  private
    FSignature: TgtSignature;
    FEnable: Boolean;
  protected
    property Enable: Boolean read FEnable write FEnable;
    property FieldName;
    property Rect;
    property PageNo;
    property Signature: TgtSignature read FSignature write FSignature;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TgtPDFFormComboBox = class(TgtPDFFormField)
  private
    FIsEditable: Boolean;
    FIsSortList: Boolean;
    FSelectedItemIndex: Integer;

    procedure SetIsEditable(const Value: Boolean);
    procedure SetIsSortList(const Value: Boolean);
    procedure SetSelectedItemIndex(const Value: Integer);

  protected
    FItems: array of String;

  public
    property Font;
    property FieldName;
    property Preferences;
    property BorderColor;
    property BackgroundColor;
    property Rect;

    property IsEditable: Boolean read FIsEditable write SetIsEditable
      default False;
    property IsSortList: Boolean read FIsSortList write SetIsSortList
      default False;
    property SelectedItemIndex: Integer read FSelectedItemIndex
      write SetSelectedItemIndex default -1;

    function AddItem(Item: String): Integer;
    constructor Create;
    destructor Destroy; override;
  end;

  TgtPDFFormListBox = class(TgtPDFFormField)
  private
    {
      (* To be Implemented *)
      FTopIndex: Integer;
    }
    FIsSortList: Boolean;
    FIsMultiSelect: Boolean;
    procedure SetIsMultiSelect(const Value: Boolean);
    procedure SetIsSortList(const Value: Boolean);
    {
      (* To be Implemented *)
      procedure SetTopIndex(const Value: Integer);
    }

  protected
    FItems: array of String;

  public
    property Font;
    property FieldName;
    property Preferences;
    property BorderColor;
    property BackgroundColor;
    property Rect;

    {
      (* To be Implemented *)
      property TopIndex: Integer read FTopIndex write SetTopIndex default -1;
    }
    property IsSortList: Boolean read FIsSortList write SetIsSortList
      default False;
    property IsMultiSelect: Boolean read FIsMultiSelect write SetIsMultiSelect
      default False;

    function AddItem(Item: String): Integer;
    constructor Create;
    destructor Destroy; override;
  end;

  { ------------------------------------------------------------------------------ }
  { TgtDocEventJSAction }
  { ------------------------------------------------------------------------------ }

  TgtDocEventJSAction = class(TPersistent)
  private
    FBeforeClose: String;
    FBeforePrint: String;
    FBeforeSave: String;
    FAfterSave: String;
    FAfterPrint: String;
    procedure SetAfterPrint(const Value: String);
    procedure SetAfterSave(const Value: String);
    procedure SetBeforePrint(const Value: String);
    procedure SetBeforeSave(const Value: String);
    procedure SetBeforeClose(const Value: String);
  published
    property BeforeClose: String read FBeforeClose write SetBeforeClose;
    property BeforeSave: String read FBeforeSave write SetBeforeSave;
    property AfterSave: String read FAfterSave write SetAfterSave;
    property BeforePrint: String read FBeforePrint write SetBeforePrint;
    property AfterPrint: String read FAfterPrint write SetAfterPrint;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  { ------------------------------------------------------------------------------ }
  { TgtPageEventAction }
  { ------------------------------------------------------------------------------ }

  TgtPageEventAction = class(TObject)
  private
    FPageNo: Integer;
    FOpenAction: TgtAnnotAction;
    FCloseAction: TgtAnnotAction;
    procedure SetCloseAction(const Value: TgtAnnotAction);
    procedure SetOpenAction(const Value: TgtAnnotAction);
    procedure SetPageNo(const Value: Integer);
  public
    constructor Create;
    destructor Destroy; override;
    // published
    property OpenAction: TgtAnnotAction read FOpenAction write SetOpenAction;
    property CloseAction: TgtAnnotAction read FCloseAction write SetCloseAction;
    property PageNo: Integer read FPageNo write SetPageNo;
  end;

  TgtExPDFEngine = class(TgtCustomPDFEngine)
  private
    (*
      Reference to AcroForm Dictionary.
    *)
    FAcroForms, FCstDocInfo, FDocEventJS: Integer;
    FAnnotList: TStringList;
    FPDFFormFields: TStringList;
    FCstDocInfoList: TList;
    FPageEventActionList: TStringList;
    FDocEventJSAction: TgtDocEventJSAction;
    FSigFormField: TgtPDFFormSignatureField;

    procedure WriteAnnots;
    procedure WriteFormFields;
    procedure WriteCustomDocInfo;
    procedure WriteDocEventJSAction;
    procedure SetDocEventJSAction(const Value: TgtDocEventJSAction);

  protected
    procedure EndPage; override;
    procedure Finish; override;
    procedure Start; override;
    { Digital signature }
    procedure WriteSignatureField; overload;
    procedure CallSignDoc;
    procedure SignDocument(AAuther, APFXFilename, APFXPassword, AFieldName,
      AReason, ALocation, AContactInfo: WideString; TimeStamp: TDateTime;
      AColor: TColor; ADisoptions: TgtSigFieldAppearenceOptions;
      APageNumber: Integer = 1); overload;
    procedure SignDocument(AAuther, APFXFilename, APFXPassword, AFieldName,
      AReason, ALocation, AContactInfo: WideString; TimeStamp: TDateTime;
      APageNumber: Integer; AFieldBounds: TgtRect; ABackgroundColor: TColor;
      ADisoptions: TgtSigFieldAppearenceOptions; AFont: TFont = nil); overload;
    function GetAnnotActionDictionary(Action: TgtAnnotAction;
      ObjNo: Integer): String;
    function GetCatalogDictionary: String; override;
    function GetPageDictionary(AObjNo: Integer): String; override;
{$IFDEF gtPro}
    function GetBitmapAsCCITTStream(ABitmap: TBitmap;
      AFormat: TgtOutputImageFormat): TMemoryStream; override;
{$ENDIF}
    property SigFormField: TgtPDFFormSignatureField read FSigFormField
      write FSigFormField;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure AddAnnotItem(AAnnot: TgtPDFAnnot);
    procedure AddFormItem(AField: TgtPDFFormField);
    procedure AddCustomDocInfo(ACustomDocInfo: TgtPDFCustomDocInfo);
    procedure AddPageEventAction(APageEventAction: TgtPageEventAction);
    property DocEventJSAction: TgtDocEventJSAction read FDocEventJSAction
      write SetDocEventJSAction;

  end;

implementation

uses
  Math;

{ TgtExPDFEngine }

procedure TgtExPDFEngine.CallSignDoc;
var
  LAuther, LPFXFilename, LPFXPassword, LFieldName, LReason, LLocation,
    LContactInfo: WideString;
  LTimeStamp: TDateTime;
  LPageNumber: Integer;
  LRect: TgtRect;
  LColor: TColor;
  LsigDisop: TgtSigFieldAppearenceOptions;
begin
  with DigitalSignature do
  begin
    with FieldProperties do
    begin
      LFieldName := FieldName;
      with FieldBounds do
      begin
        LRect.Left := FieldBounds.FLLeft;
        LRect.Right := FieldBounds.FLRight;
        LRect.Top := FieldBounds.FLTop;
        LRect.Bottom := FieldBounds.FLBotom;
      end;
      LColor := FillColor;
      LPageNumber := PageNumber;
      LsigDisop := FieldAppearenceOptions;
    end;
    with SignatureProperties do
    begin
      LAuther := Author;
      LPFXFilename := CertFileName;
      LPFXPassword := CertPassword;
      LLocation := Location;
      LReason := Reason;
      LContactInfo := ContactInfo;
      LTimeStamp := DateTime;
    end;
  end;
  if (DigitalSignature.FieldProperties.Visible) then
  begin
    if not(LRect.Right > LRect.Left) then
      LRect.Right := LRect.Left + 1;
    if not(LRect.Bottom > LRect.Top) then
      LRect.Bottom := LRect.Top + 1;
  end;

  if (LRect.Right <> 0) or (LRect.Top <> 0) then
    SignDocument(LAuther, LPFXFilename, LPFXPassword, LFieldName, LReason,
      LLocation, LContactInfo, LTimeStamp, LPageNumber, LRect, LColor,
      LsigDisop)
  else
    SignDocument(LAuther, LPFXFilename, LPFXPassword, LFieldName, LReason,
      LLocation, LContactInfo, LTimeStamp, LColor, LsigDisop, LPageNumber);
end;

constructor TgtExPDFEngine.Create(AOwner: TComponent);
begin
  inherited;
  CPixelsPerInch := Screen.PixelsPerInch;
  CPointsToPixels := Screen.PixelsPerInch / 72;
  FDocEventJSAction := TgtDocEventJSAction.Create;
end;

function TgtExPDFEngine.GetCatalogDictionary: String;
Var
  Ls: String;
begin
  Result := inherited GetCatalogDictionary;
  if (FPDFFormFields.Count > 0) or (SignDoc) then
  begin
    Ls := Result + ' /AcroForm ';
    if (FPDFFormFields.Count > 0) then
      Ls := Ls + MakeObjRef(FAcroForms);
    if SignDoc then
      Ls := Ls + MakeObjRef(FAcroForms);
    Result := Ls;
  end;
  if FCstDocInfoList.Count > 0 then
  begin
    Result := Result + ' /Metadata ' + MakeObjRef(FCstDocInfo);
  end;
  with DocEventJSAction do
    if ((BeforeClose + BeforeSave + AfterSave + BeforePrint + AfterPrint) <> '')
    then
    begin
      Result := Result + ' /AA ' + MakeObjRef(FDocEventJS);
    end;
  CPixelsPerInch := Screen.PixelsPerInch;
  CPointsToPixels := Screen.PixelsPerInch / 72;
end;

function TgtExPDFEngine.GetPageDictionary(AObjNo: Integer): String;
const
  NamedActions: array [TgtActionName] of String = (' /NextPage', ' /PrevPage',
    ' /FirstPage', ' /LastPage');
  GoToOptions: array [TgtGoToOptions] of String = ('/XYZ', '/Fit', '/FitH',
    '/FitV', '/FitR');
var
  LI: Integer;

  function GetActionDictionary(AAction: TgtAnnotAction): String;
  begin
    if AAction is TgtAnnotJSAction then
      with TgtAnnotJSAction(AAction) do
        Result := Result + '/JavaScript /JS <FEFF' +
          String(GetHexOfStr(AnsiString(WritePDFString(JavaScript, AObjNo,
          0)) + '>'));
    if AAction is TgtAnnotNamedAction then
      with TgtAnnotNamedAction(AAction) do
        Result := Result + '/Named /N ' + NamedActions[FActionName];
    if AAction is TgtAnnotLinkAction then
      with TgtAnnotLinkAction(AAction) do
        Result := Result + '/URI /URI <' +
          String(GetHexOfStr(AnsiString(WritePDFString(URI, AObjNo, 0)))) + '>';
    if AAction is TgtAnnotLaunchAction then
      with TgtAnnotLaunchAction(AAction) do
      begin
        Result := Result + '/Launch ';
        Result := Result + '/F <' +
          String(GetHexOfStr(AnsiString(WritePDFString(FFilePath, AObjNo, 0))))
          + '> /NewWindow ';
        if FNewWindow then
          Result := Result + 'true'
        else
          Result := Result + 'false';
      end;
    if AAction is TgtAnnotGoToAction then
      with TgtAnnotGoToAction(AAction) do
      begin
        Result := Result + '/GoTo /D [' +
          MakeObjRef(TgtPageInfo(FPageList.Items[Page - 1]).ObjNo) + ' ' +
          GoToOptions[Options] + ' ';
        case Options of
          goDefault:
            Result := Result + NumToStr(GetNativeXPos(Rect.Left)) + ' ' +
              NumToStr(GetNativeYPos(Rect.Top, Page)) + ' ' + IntToStr(Zoom);
          goFitWidth:
            Result := Result + NumToStr(GetNativeYPos(Rect.Top, Page)) + ' ';
          goFitHeight:
            Result := Result + NumToStr(GetNativeXPos(Rect.Left)) + ' ';
          goFitRect:
            Result := Result + NumToStr(GetNativeXPos(Rect.Left)) + ' ' +
              NumToStr(GetNativeYPos(Rect.Bottom, Page)) + ' ' +
              NumToStr(GetNativeXPos(Rect.Right)) + ' ' +
              NumToStr(GetNativeYPos(Rect.Top, Page)) + ' ';
        end;
        Result := Result + ' ]';
      end;
    if AAction is TgtAnnotRemoteGotoAction then
      with TgtAnnotRemoteGotoAction(AAction) do
      begin
        Result := Result + '/GoToR';
        Result := Result + '/F <' +
          String(GetHexOfStr(AnsiString(WritePDFString(FFilePath, AObjNo, 0))))
          + '>' + '/D [' + MakeObjRef(TgtPageInfo(FPageList.Items[Page - 1])
          .ObjNo) + ' ' + GoToOptions[Options] + ' ';
        case Options of
          goDefault:
            Result := Result + NumToStr(GetNativeXPos(Rect.Left)) + ' ' +
              NumToStr(GetNativeYPos(Rect.Top, Page)) + ' ' + IntToStr(Zoom);
          goFitWidth:
            Result := Result + NumToStr(GetNativeYPos(Rect.Top, Page)) + ' ';
          goFitHeight:
            Result := Result + NumToStr(GetNativeXPos(Rect.Left)) + ' ';
          goFitRect:
            Result := Result + NumToStr(GetNativeXPos(Rect.Left)) + ' ' +
              NumToStr(GetNativeYPos(Rect.Bottom, Page)) + ' ' +
              NumToStr(GetNativeXPos(Rect.Right)) + ' ' +
              NumToStr(GetNativeYPos(Rect.Top, Page)) + ' ';
        end;
        if FNewWindow then
          Result := Result + ' ] /NewWindow ' + 'true'
        else
          Result := Result + ' ] /NewWindow ' + 'false';
      end;
  end;

begin
  Result := inherited GetPageDictionary(AObjNo);
  if FPageEventActionList.Count > 0 then
  begin
    with FPageEventActionList do
    begin
      LI := IndexOf(IntToStr(CurrentPage));
      if (LI > -1) then
        with TgtPageEventAction(Objects[LI]) do
        begin
          if (OpenAction = nil) and (CloseAction = nil) then
            Exit;
          Result := Result + '/AA << ';
          if (OpenAction <> nil) then
            Result := Result + '/O <</S ' + GetActionDictionary
              (OpenAction) + '>>';
          if (CloseAction <> nil) then
            Result := Result + '/C <</S ' + GetActionDictionary
              (CloseAction) + '>>';
          Result := Result + ' >>';
        end;
    end;
  end;
end;

procedure TgtExPDFEngine.Finish;
var
  LI: Integer;
  Ls, LS1: String;
begin
  if FAnnotList.Count > 0 then
    WriteAnnots;
  if (FPDFFormFields.Count > 0) or (SignDoc) then
  begin
    FAcroForms := GetNewObjNo;
    if (FPDFFormFields.Count > 0) then
    begin
      WriteFormFields;
      Ls := '/Fields [';
      with FPDFFormFields do
        for LI := 0 to Count - 1 do
          Ls := Ls + Strings[LI] + ' 0 R ';
      Ls := Ls + ']';
      LS1 := '/F' + IntToStr(TgtPDFFormField(FPDFFormFields.Objects[0])
        .FFontIndex) + ' 12 Tf 0 g';
      (* Need Appearance. *)
      Ls := Ls + '/NeedAppearances false';
      (* Default Appearance. *)
      Ls := Ls + '/DA <' +
        String(GetHexOfStr(AnsiString(WritePDFString(LS1, FAcroForms,
        0)))) + '>';
      (* Default Resource Dictionary to be used by appearance stream. *)
      Ls := Ls + '/DR << /Font <<';
      with FPDFFormFields do
        for LI := 0 to Count - 1 do
          with TgtPDFFormField(Objects[LI]) do
            Ls := Ls + ' /F' + IntToStr(FFontIndex) + ' ' +
              MakeObjRef(TgtPDFFont(FFontTable.Items[FFontIndex])
              .FontInfo.FfiFontObjRef);
      Ls := Ls + '>> >>';
      Ls := Ls + CRLF;
    end
    else
      Ls := '/Fields [' + IntToStr(SigObjNumber) +
        ' 0 R ] /NeedAppearances false /' + 'Resources ' +
        MakeObjRef(CResourcesObjNo) + CRLF;
    WriteObj(Ls, FAcroForms, True);
  end;

  if FCstDocInfoList.Count > 0 then
  begin
    FCstDocInfo := GetNewObjNo;
    WriteCustomDocInfo;
  end;

  with DocEventJSAction do
    if BeforeClose + BeforeSave + AfterSave + BeforePrint + AfterPrint <> ''
    then
    begin
      FDocEventJS := GetNewObjNo;
      WriteDocEventJSAction;
    end;

  inherited;

  for LI := 0 to FAnnotList.Count - 1 do
    TgtPDFAnnot(FAnnotList.Objects[LI]).Free;
  FreeAndNil(FAnnotList);

  (* Free Form Field Objects. *)
  for LI := 0 to FPDFFormFields.Count - 1 do
    TgtPDFFormField(FPDFFormFields.Objects[LI]).Free;
  FreeAndNil(FPDFFormFields);

  (* Free DocInfoList Objects. *)
  for LI := 0 to FCstDocInfoList.Count - 1 do
    TgtPDFCustomDocInfo(FCstDocInfoList.Items[LI]).Free;
  FreeAndNil(FCstDocInfoList);

  for LI := 0 to FPageEventActionList.Count - 1 do
    TgtPageEventAction(FPageEventActionList.Objects[LI]).Free;
  FreeAndNil(FPageEventActionList);
end;

procedure TgtExPDFEngine.Start;
begin
  inherited;
  FAnnotList := TStringList.Create;
  FPDFFormFields := TStringList.Create;
  FCstDocInfoList := TList.Create;
  FPageEventActionList := TStringList.Create;
  FDocEventJSAction.BeforeClose := '';
  FDocEventJSAction.BeforeSave := '';
  FDocEventJSAction.BeforePrint := '';
  FDocEventJSAction.AfterSave := '';
  FDocEventJSAction.AfterPrint := '';
  { Digital signature }
  if (DigitalSignature.Enabled) then
    CallSignDoc;

end;

procedure TgtExPDFEngine.AddFormItem(AField: TgtPDFFormField);
var
  LObj: Integer;

  LI, FontObjR: Integer;
  PDFFont: TgtPDFFont;
  LBandType: TgtBandType;
  LField: TgtPDFFormRadioItem;
begin
  if FIsDocumentStarted = False then
  begin
    FreeAndNil(AField);
    Exit;
  end;
  if (AField is TgtPDFFormRadioButton) and
    (TgtPDFFormRadioButton(AField).FItems.Count = 0) then
  begin
    FreeAndNil(AField);
    Exit;
  end;

  (* Convert values from measurement units to native unit (pixels). *)
  with AField do
    Rect := NativeRect(Rect);

  (* Position the form fields within the Content band. *)
  LBandType := BandType;
  BandType := btContent;
  with AField, BandRect do
    if not(AField is TgtPDFFormRadioButton) then
    begin
      Rect := gtRect(Left + Rect.Left, Top + Rect.Top, Left + Rect.Right,
        Top + Rect.Bottom);
      (* If Top-Left is not within the Content Band range donot add. *)
      if (AField.Rect.Left < BandRect.Left) or
        (AField.Rect.Left > BandRect.Right) or (AField.Rect.Top < BandRect.Top)
        or (AField.Rect.Top > BandRect.Bottom) then
      begin
        FreeAndNil(AField);
        BandType := LBandType;
        Exit;
      end
      else
        BandType := LBandType;
    end
    else
    begin
      for LI := 0 to TgtPDFFormRadioButton(AField).FItems.Count - 1 do
      begin
        LField := TgtPDFFormRadioItem(TgtPDFFormRadioButton(AField)
          .FItems.Objects[LI]);
        with LField, BandRect do
        begin
          Rect := NativeRect(Rect);
          Rect := gtRect(Left + Rect.Left, Top + Rect.Top, Left + Rect.Right,
            Top + Rect.Bottom);
        end;
        if (LField.Rect.Left < BandRect.Left) or
          (LField.Rect.Left > BandRect.Right) or
          (LField.Rect.Top < BandRect.Top) or (LField.Rect.Top > BandRect.Bottom)
        then
        begin
          TgtPDFFormRadioButton(AField).FItems.Objects[LI].Free;
          TgtPDFFormRadioButton(AField).FItems.Objects[LI] := nil;
        end;
      end;
    end;

  LObj := GetNewObjNo;
  AField.FPageNo := CurrentPage;

  try
    if (AField is TgtPDFFormCheckBox) or (AField is TgtPDFFormRadioButton) then
    begin
      (* Add Symbol Font to FontTable. *)
      with AField.Font do
      begin
        Name := 'MS Sans Serif';
        Charset := SYMBOL_CHARSET;
      end;
    end;
    for LI := 0 to FFontTable.Count - 1 do
    begin
      if (TgtPDFFont(FFontTable.Items[LI]).IsEqual(AField.Font)) then
        AField.FFontIndex := LI;
    end;
    if AField.FFontIndex = -1 then
    begin
      FontObjR := GetNewObjNo;
      PDFFont := TgtPDFFont.Create(AField.Font, FontObjR,
        (Preferences.EmbedTrueTypeFonts = etfSubset));
      AField.FFontIndex := FFontTable.Add(PDFFont);
    end;
  finally
  end;

  FPDFFormFields.AddObject(IntToStr(LObj), AField);
end;

destructor TgtExPDFEngine.Destroy;
begin
  FDocEventJSAction.Free;
  FSigFormField.Free;
  inherited;
end;

procedure TgtExPDFEngine.EndPage;
var
  LI, LJ, LRadioItemObj: Integer;
begin
  (* Append Annotation Objects. *)
  for LI := 0 to FAnnotList.Count - 1 do
    if TgtPDFAnnot(FAnnotList.Objects[LI]).FPageNo = CurrentPage then
      FAnnots := FAnnots + ' ' + MakeObjRef(StrToInt(FAnnotList.Strings[LI]));

  (* Append Form Widget Annotations. *)
  for LI := 0 to FPDFFormFields.Count - 1 do
  begin
    if TgtPDFFormField(FPDFFormFields.Objects[LI]).FPageNo = CurrentPage then
    begin
      if not(TgtPDFFormField(FPDFFormFields.Objects[LI])
        is TgtPDFFormRadioButton) then
        FAnnots := FAnnots + ' ' + FPDFFormFields.Strings[LI] + ' 0 R';
      if TgtPDFFormField(FPDFFormFields.Objects[LI]) is TgtPDFFormRadioButton
      then
      begin
        with TgtPDFFormRadioButton(FPDFFormFields.Objects[LI]) do
          for LJ := 0 to FItems.Count - 1 do
          begin
            (*
              If some item was removed because it was out of margin, continue.
            *)
            if FItems.Objects[LJ] = nil then
              Continue;
            LRadioItemObj := GetNewObjNo;
            FItems.Strings[LJ] := IntToStr(LRadioItemObj);
            FAnnots := FAnnots + ' ' + FItems.Strings[LJ] + ' 0 R';
          end;
      end;
    end;
  end;
  inherited;
end;

procedure TgtExPDFEngine.WriteFormFields;
const
  CheckSymbol: array [TgtPDFFormCheckboxSymbol] of String = ('4', 'l', '8', 'u',
    'n', 'H');
var
  LI, LJ: Integer;
  Ls, LS1, SValue: String;
  Flags: Cardinal;

  LWidth, LHeight: Double;
  // PageNo: Integer;

  Font: TFont;
  FontIdx: Integer;

  NormalAppObj, DownAppObj, RolloverAppObj: Integer;
  NormalOnStateObj, NormalOffStateObj, DownOnStateObj, DownOffStateObj: Integer;
  LChoiceItems, LChoiceValue: String;

  // TmpObjNumber: Integer;

  procedure DrawButton(Width, Height: Double; Text: String; ObjNo: Integer;
    DownAppearance: Boolean; Background, Border: TColor; AFont: TFont);
  var
    S: String;
    LATemp: AnsiString;
    LStream: TMemoryStream;
    X, Y, TextWidthPts: Double;
  begin
    LStream := TMemoryStream.Create;
    try
      TextWidthPts := TextSize(Text, TgtPDFFont(FFontTable.Items[FontIdx]).Font)
        .cx * FPixelToPointMultiplier;
      X := (Width / 2) - (TextWidthPts / 2);
      Y := Floor((Height - TgtPDFFont(FFontTable.Items[FontIdx])
        .Font.Size) / 2);
      if DownAppearance then
        S := ColorToPDFColor(Background) + ' rg 0 0 ' + NumToStr(Width) + ' ' +
          NumToStr(Height) + ' re f ' + ColorToPDFColor(Border) + ' RG 2 w 1 1 '
          + NumToStr(Width - 2) + ' ' + NumToStr(Height - 2) +
          ' re s 0.502 g 2 2 m 2 ' + NumToStr(Height - 2) + ' l ' +
          NumToStr(Width - 2) + ' ' + NumToStr(Height - 2) + ' l ' +
          NumToStr(Width - 4) + ' ' + NumToStr(Height - 4) + ' l 4 ' +
          NumToStr(Height - 4) + ' l 4 4 l f 1 g ' + NumToStr(Width - 2) + ' ' +
          NumToStr(Height - 2) + ' m ' + NumToStr(Width - 2) +
          ' 2 l 2 2 l 4 4 l ' + NumToStr(Width - 4) + ' 4 l ' +
          NumToStr(Width - 4) + ' ' + NumToStr(Height - 4) + ' l f q 4 4 ' +
          NumToStr(Width - 8) + ' ' + NumToStr(Height - 8) +
          ' re W n 1 0 0 1 2 -2 cm BT /F' + IntToStr(FontIdx) + ' ' +
          IntToStr(AFont.Size) + ' Tf ' + ColorToPDFColor(AFont.Color) + ' rg '
          + ' 1 0 0 1 ' + NumToStr(X) + ' ' + NumToStr(Y) + ' Tm (' + Text +
          ') Tj ET Q'
      else
        S := ColorToPDFColor(Background) + ' rg 0 0 ' + NumToStr(Width) + ' ' +
          NumToStr(Height) + ' re f ' + ColorToPDFColor(Border) + ' RG 2 w 1 1 '
          + NumToStr(Width - 2) + ' ' + NumToStr(Height - 2) +
          ' re s 1 g 2 2 m 2 ' + NumToStr(Height - 2) + ' l ' +
          NumToStr(Width - 2) + ' ' + NumToStr(Height - 2) + ' l ' +
          NumToStr(Width - 4) + ' ' + NumToStr(Height - 4) + ' l 4 ' +
          NumToStr(Height - 4) + ' l 4 4 l f 0.502 g ' + NumToStr(Width - 2) +
          ' ' + NumToStr(Height - 2) + ' m ' + NumToStr(Width - 2) +
          ' 2 l 2 2 l 4 4 l ' + NumToStr(Width - 4) + ' 4 l ' +
          NumToStr(Width - 4) + ' ' + NumToStr(Height - 4) + ' l f q 4 4 ' +
          NumToStr(Width - 8) + ' ' + NumToStr(Height - 8) + ' re W n BT /F' +
          IntToStr(FontIdx) + ' ' + IntToStr(AFont.Size) + ' Tf ' +
          ColorToPDFColor(AFont.Color) + ' rg ' + ' 1 0 0 1 ' + NumToStr(X) +
          ' ' + NumToStr(Y) + ' Tm (' + Text + ') Tj ET Q';
      LATemp := AnsiString(S);
      LStream.Write(LATemp[1], Length(S));
      S := '/Length ' + IntToStr(LStream.Size);
      S := S + '/Subtype/Form ' + '/BBox [ 0 0 ' + NumToStr(Width) + ' ' +
        NumToStr(Height) + ' ] ' + '/Resources << ' + '/ProcSet [ /PDF /Text ] '
        + '/Font << /F' + IntToStr(FontIdx) + ' ' +
        MakeObjRef(TgtPDFFont(FFontTable.Items[FontIdx]).FontInfo.FfiFontObjRef)
        + ' >> ' + ' >>';
      S := S + CRLF;
      WriteObj(S, ObjNo, False);
      S := 'stream' + CRLF;
      LATemp := AnsiString(S);
      FOutputStream.Write(LATemp[1], Length(S));
      WritePDFStream(LStream, LStream.Size, ObjNo, 0);
      FOutputStream.CopyFrom(LStream, 0);
      S := CRLF + 'endstream' + CRLF + 'endobj' + CRLF;
      LATemp := AnsiString(S);
      FOutputStream.Write(LATemp[1], Length(S));
    finally
      FreeAndNil(LStream);
    end;
  end;

  procedure DrawNormalCheckBox(Width, Height: Double; Text: String;
    ObjNo: Integer; OnState: Boolean; Background, Border: TColor; AFont: TFont);
  var
    S: String;
    LATemp: AnsiString;
    LStream: TMemoryStream;
  begin
    LStream := TMemoryStream.Create;
    try
      if OnState then
        S := ColorToPDFColor(Background) + ' rg 0 w 0.6 0.6 ' +
          NumToStr(Width - 2) + ' ' + NumToStr(Height - 2) + ' re f ' +
          ColorToPDFColor(Border) + ' RG 1 w 0.5 0.5 ' + NumToStr(Width - 1) +
          ' ' + NumToStr(Height - 1) + ' re s q 1 1 ' + NumToStr(Width - 2) +
          ' ' + NumToStr(Height - 2) + ' re W n BT /F' + IntToStr(FontIdx) + ' '
          + IntToStr(AFont.Size) + ' Tf ' + ColorToPDFColor(AFont.Color) +
          ' rg ' + ' 1 0 0 1 0.77 1.405 Tm (' + Text + ') Tj ET Q'
      else
        S := ColorToPDFColor(Background) + ' rg 0 w 0.6 0.6 ' +
          NumToStr(Width - 2) + ' ' + NumToStr(Height - 2) + ' re f ' +
          ColorToPDFColor(Border) + ' RG 1 w 0.5 0.5 ' + NumToStr(Width - 1) +
          ' ' + NumToStr(Height - 1) + ' re s';
      LATemp := AnsiString(S);
      LStream.Write(LATemp[1], Length(S));
      S := '/Length ' + IntToStr(LStream.Size);
      S := S + '/Subtype /Form ' + '/BBox [ 0 0 ' + NumToStr(Width) + ' ' +
        NumToStr(Height) + ' ] ';
      if OnState then
        S := S + '/Resources << ' + '/ProcSet [ /PDF /Text ] ' + '/Font << /F' +
          IntToStr(FontIdx) + ' ' +
          MakeObjRef(TgtPDFFont(FFontTable.Items[FontIdx])
          .FontInfo.FfiFontObjRef) + ' >> ' + ' >>'
      else
        S := S + '/Resources << ' + '/ProcSet [ /PDF ]' + '>>';
      S := S + CRLF;
      WriteObj(S, ObjNo, False);
      S := 'stream' + CRLF;
      LATemp := AnsiString(S);
      FOutputStream.Write(LATemp[1], Length(S));
      WritePDFStream(LStream, LStream.Size, ObjNo, 0);
      FOutputStream.CopyFrom(LStream, 0);
      S := CRLF + 'endstream' + CRLF + 'endobj' + CRLF;
      LATemp := AnsiString(S);
      FOutputStream.Write(LATemp[1], Length(S));
    finally
      FreeAndNil(LStream);
    end;
  end;

  procedure DrawDownCheckBox(Width, Height: Double; Text: String;
    ObjNo: Integer; OnState: Boolean; Background, Border: TColor; AFont: TFont);
  var
    S: String;
    LATemp: AnsiString;
    LStream: TMemoryStream;
  begin
    LStream := TMemoryStream.Create;
    try
      if OnState then
        S := ColorToPDFColor(Background) + ' rg 0 w 0.6 0.6 ' +
          NumToStr(Width - 1) + ' ' + NumToStr(Height - 1) + ' re f ' +
          ColorToPDFColor(Border) + ' RG 0 0 ' + NumToStr(Width) + ' ' +
          NumToStr(Height) + ' re f 0 G 1 w 0.5 0.5 ' + NumToStr(Width - 1) +
          ' ' + NumToStr(Height - 1) + ' re s q 1 1 ' + NumToStr(Width - 2) +
          ' ' + NumToStr(Height - 2) + ' re W n BT /F' + IntToStr(FontIdx) + ' '
          + IntToStr(AFont.Size) + ' Tf ' + ColorToPDFColor(AFont.Color) +
          ' rg ' + ' 1 0 0 1 0.77 1.405 Tm (' + Text + ') Tj ET Q'
      else
        S := ColorToPDFColor(Background) + ' rg 0 w 0.6 0.6 ' +
          NumToStr(Width - 1) + ' ' + NumToStr(Height - 1) + ' re f ' +
          ColorToPDFColor(Border) + ' RG 0 0 ' + NumToStr(Width) + ' ' +
          NumToStr(Height) + ' re f 0 G 1 w 0.5 0.5 ' + NumToStr(Width - 1) +
          ' ' + NumToStr(Height - 1) + ' re s';
      LATemp := AnsiString(S);
      LStream.Write(LATemp[1], Length(S));
      S := '/Length ' + IntToStr(LStream.Size);
      S := S + '/Subtype /Form ' + '/BBox [ 0 0 ' + NumToStr(Width) + ' ' +
        NumToStr(Height) + ' ] ';
      if OnState then
        S := S + '/Resources <<' + '/ProcSet [ /PDF /Text ]' + '/Font << /F' +
          IntToStr(FontIdx) + ' ' +
          MakeObjRef(TgtPDFFont(FFontTable.Items[FontIdx])
          .FontInfo.FfiFontObjRef) + ' >> ' + '>>'
      else
        S := S + '/Resources <<' + ' /ProcSet [ /PDF ]' + '>>';
      S := S + CRLF;
      WriteObj(S, ObjNo, False);
      S := 'stream' + CRLF;
      LATemp := AnsiString(S);
      FOutputStream.Write(LATemp[1], Length(S));
      WritePDFStream(LStream, LStream.Size, ObjNo, 0);
      FOutputStream.CopyFrom(LStream, 0);
      S := CRLF + 'endstream' + CRLF + 'endobj' + CRLF;
      LATemp := AnsiString(S);
      FOutputStream.Write(LATemp[1], Length(S));
    finally
      FreeAndNil(LStream);
    end;
  end;

  function GetNewStreamData(const ARect: TgtRect; AValue: String;
    AJust: TgtHAlignment; AFont: TFont): String;
  var
    LLines: TStringList;
    LTextHeight, LTextLen: Double;
    LHeight, LWidth: Double;
    LX, LY: Double;
    LI: Integer;
  begin
    LHeight := ARect.Bottom - ARect.Top;
    LWidth := ARect.Right - ARect.Left;

    if AFont.Size = 0 then
    begin
      AFont.Size := 11;
    end;
    Result := '';

    LTextHeight := PixelsToPoints(TextSize(AValue, AFont).cy);

    LLines := TStringList.Create;
    WrapTextIntoLines(AValue, PointsToPixels(LWidth), PointsToPixels(LWidth),
      LLines, False, AFont);
    LY := LHeight - LTextHeight; // - LY;

    for LI := 0 to LLines.Count - 1 do
    begin
      LTextLen := PixelsToPoints(TextSize(LLines.Strings[LI], AFont).cx);

      if (LI = LLines.Count - 1) then
        LTextLen := LTextLen + PixelsToPoints(TextSize(CR, AFont).cx);

      LTextHeight := PixelsToPoints(TextSize(LLines.Strings[LI], AFont).cy);
      Result := Result + SP + ColorToPDFColor(AFont.Color) + ' rg ';
      LX := 2.000;
      case AJust of
        haCenter:
          begin
            if LTextLen < LWidth then
              LX := LWidth / 2 - LTextLen / 2 + LX;
          end;
        haRight:
          LX := LWidth { - LX - 2 } - LTextLen;
      end;

      Result := Result + '1 0 0 1' + SP + FloattostrLocale(LX) + SP +
        FloattostrLocale(LY) + ' Tm (' + LLines.Strings[LI] + ') Tj';
      LY := LY - LTextHeight;
    end;
    FreeAndNil(LLines);
  end;

  procedure DrawText(Width, Height: Double; Text: String; IsMultiline: Boolean;
    ObjNo: Integer; Background, Border: TColor; AFont: TFont;
    IsBorder: Boolean);
  var
    S: String;
    LATemp: AnsiString;
    LStream: TMemoryStream;
    X, Y, TextWidthPts: Double;
  begin
    LStream := TMemoryStream.Create;
    try
      TextWidthPts := TextSize(Text, TgtPDFFont(FFontTable.Items[FontIdx]).Font)
        .cx * FPixelToPointMultiplier;
      X := (Width / 2) - (TextWidthPts / 2);
      Y := Floor((Height - TgtPDFFont(FFontTable.Items[FontIdx])
        .Font.Size) / 2);
      S := ColorToPDFColor(Background) + ' rg 0 0 ' + NumToStr(Width) + ' ' +
        NumToStr(Height) + ' re f ';
      if IsBorder then
        S := S + ColorToPDFColor(Border) + ' RG 0.5 0.5 ' + NumToStr(Width - 1)
          + ' ' + NumToStr(Height - 1) + ' re S ';

      S := S + '/Tx BMC q 1 1 ' + NumToStr(Width - 2) + ' ' +
        NumToStr(Height - 2) + ' re W n BT /F' + IntToStr(FontIdx) + ' ' +
        IntToStr(AFont.Size) + ' Tf ';
      if IsMultiline then
        S := S + GetNewStreamData(gtRect(X, Y, X + Width, Y + Height), Text,
          haLeft, AFont)
      else
        S := S + ColorToPDFColor(AFont.Color) + ' rg ' + NumToStr(X) + ' ' +
          NumToStr(Y) + ' Td (' + Text + ') Tj';

      S := S + ' ET Q EMC';
      LATemp := AnsiString(S);
      LStream.Write(LATemp[1], Length(S));

      S := '/Length ' + IntToStr(LStream.Size);
      S := S + '/Subtype /Form ' + '/BBox [0 0 ' + NumToStr(Width) + ' ' +
        NumToStr(Height) + ']' + '/Resources << ' + '/ProcSet [/PDF /Text] ' +
        '/Font << /F' + IntToStr(FontIdx) + ' ' +
        MakeObjRef(TgtPDFFont(FFontTable.Items[FontIdx]).FontInfo.FfiFontObjRef)
        + '>> ' + '>>';
      S := S + CRLF;
      WriteObj(S, ObjNo, False);
      S := 'stream' + CRLF;
      LATemp := AnsiString(S);
      FOutputStream.Write(LATemp[1], Length(S));
      WritePDFStream(LStream, LStream.Size, ObjNo, 0);
      FOutputStream.CopyFrom(LStream, 0);
      S := CRLF + 'endstream' + CRLF + 'endobj' + CRLF;
      LATemp := AnsiString(S);
      FOutputStream.Write(LATemp[1], Length(S));
    finally
      FreeAndNil(LStream);
    end;
  end;

  procedure DrawComboBox(Width, Height: Double; Text: String; ObjNo: Integer;
    Background, Border: TColor; AFont: TFont);
  var
    S: String;
    LATemp: AnsiString;
    LStream: TMemoryStream;
  begin
    LStream := TMemoryStream.Create;
    try
      S := ColorToPDFColor(Background) + ' rg 0 0 ' + NumToStr(Width) + ' ' +
        NumToStr(Height) + ' re f ' + ColorToPDFColor(Border) +
        ' RG 1 w 0.5 0.5 ' + NumToStr(Width - 1) + ' ' + NumToStr(Height - 1) +
        ' re s 0.502 g 1 1 m 1 ' + NumToStr(Height - 1) + ' l ' +
        NumToStr(Width - 1) + ' ' + NumToStr(Height - 1) + ' l ' +
        NumToStr(Width - 2) + ' ' + NumToStr(Height - 2) + ' l 2 ' +
        NumToStr(Height - 2) + ' l 2 2 l f 0.7529 g ' + NumToStr(Width - 1) +
        ' ' + NumToStr(Height - 1) + ' m ' + NumToStr(Width - 1) +
        ' 1 l 1 1 l 2 2 l ' + NumToStr(Width - 2) + ' 2 l ' +
        NumToStr(Width - 2) + ' ' + NumToStr(Height - 2) + ' l f /Tx BMC q 2 2 '
        + NumToStr(Width - 4) + ' ' + NumToStr(Height - 4) + ' re W n BT /F' +
        IntToStr(FontIdx) + ' ' + IntToStr(AFont.Size) + ' Tf ' +
        ColorToPDFColor(AFont.Color) + ' rg ' + ' 1 0 0 1 4 4.59 Tm (' + Text +
        ') Tj ET Q EMC';
      LATemp := AnsiString(S);
      LStream.Write(LATemp[1], Length(S));
      S := '/Length ' + IntToStr(LStream.Size);
      S := S + '/Subtype /Form ' + '/BBox [ 0 0 ' + NumToStr(Width) + ' ' +
        NumToStr(Height) + ' ] ' + '/Resources << ' + '/ProcSet [ /PDF /Text ] '
        + '/Font << /F' + IntToStr(FontIdx) + ' ' +
        MakeObjRef(TgtPDFFont(FFontTable.Items[FontIdx]).FontInfo.FfiFontObjRef)
        + ' >> ' + '>>';
      S := S + CRLF;
      WriteObj(S, ObjNo, False);
      S := 'stream' + CRLF;
      LATemp := AnsiString(S);
      FOutputStream.Write(LATemp[1], Length(S));
      WritePDFStream(LStream, LStream.Size, ObjNo, 0);
      FOutputStream.CopyFrom(LStream, 0);
      S := CRLF + 'endstream' + CRLF + 'endobj' + CRLF;
      LATemp := AnsiString(S);
      FOutputStream.Write(LATemp[1], Length(S));
    finally
      FreeAndNil(LStream);
    end;
  end;

  procedure DrawListBox(Width, Height: Double; Items: array of String;
    ObjNo: Integer; Background, Border: TColor; AFont: TFont);
  var
    S: String;
    LATemp: AnsiString;
    LStream: TMemoryStream;
    LTextHeight: Integer;
    ItemIndex: Integer;
    LTempStr: String;
  begin
    LStream := TMemoryStream.Create;
    try
      ItemIndex := 0;
      LTempStr := '';
      if (Length(Items) > 0) then
        LTempStr := Items[0];
      LTextHeight := AFont.Size;
      S := ColorToPDFColor(Background) + ' rg 0 0 ' + NumToStr(Width) + ' ' +
        NumToStr(Height) + ' re f ' + ColorToPDFColor(Border) +
        ' RG 1 w 0.5 0.5 ' + NumToStr(Width - 1) + ' ' + NumToStr(Height - 1) +
        ' re s 0.502 g 1 1 m 1 ' + NumToStr(Height - 1) + ' l ' +
        NumToStr(Width - 1) + ' ' + NumToStr(Height - 1) + ' l ' +
        NumToStr(Width - 2) + ' ' + NumToStr(Height - 2) + ' l 2 ' +
        NumToStr(Height - 2) + ' l 2 2 l f 0.7529 g ' + NumToStr(Width - 1) +
        ' ' + NumToStr(Height - 1) + ' m ' + NumToStr(Width - 1) +
        ' 1 l 1 1 l 2 2 l ' + NumToStr(Width - 2) + ' 2 l ' +
        NumToStr(Width - 2) + ' ' + NumToStr(Height - 2) + ' l f /Tx BMC q 2 2 '
        + NumToStr(Width - 4) + ' ' + NumToStr(Height - 4) +
        ' re W n 0 0 0.502 rg 2 ' + NumToStr(Height - LTextHeight - 2) + ' ' +
        NumToStr(Width - 4) + ' ' + NumToStr(LTextHeight) + ' re f BT /F' +
        IntToStr(FontIdx) + ' ' + IntToStr(AFont.Size) + ' Tf ' +
        ColorToPDFColor(AFont.Color) + ' rg ' + ' 1 0 0 1 2 ' + NumToStr(Height)
        + ' Tm 1 g 2 ' + IntToStr(-AFont.Size) + ' Td (' + LTempStr + ') Tj ';

      while ((LTextHeight + AFont.Size) < Height) and
        (ItemIndex < Length(Items) - 1) do
      begin
        Inc(ItemIndex);
        LTextHeight := LTextHeight + AFont.Size;
        S := S + ColorToPDFColor(AFont.Color) + ' rg 0 ' + IntToStr(-AFont.Size)
          + ' Td (' + Items[ItemIndex] + ') Tj ';
      end;
      S := S + ' ET Q EMC';
      LATemp := AnsiString(S);
      LStream.Write(LATemp[1], Length(S));
      S := '/Length ' + IntToStr(LStream.Size);
      S := S + '/Subtype /Form ' + '/BBox [ 0 0 ' + NumToStr(Width) + ' ' +
        NumToStr(Height) + ' ] ' + '/Resources << ' + '/ProcSet [ /PDF /Text ] '
        + '/Font << /F' + IntToStr(FontIdx) + ' ' +
        MakeObjRef(TgtPDFFont(FFontTable.Items[FontIdx]).FontInfo.FfiFontObjRef)
        + ' >> ' + '>>';
      S := S + CRLF;
      WriteObj(S, ObjNo, False);
      S := 'stream' + CRLF;
      LATemp := AnsiString(S);
      FOutputStream.Write(LATemp[1], Length(S));
      WritePDFStream(LStream, LStream.Size, ObjNo, 0);
      FOutputStream.CopyFrom(LStream, 0);
      S := CRLF + 'endstream' + CRLF + 'endobj' + CRLF;
      LATemp := AnsiString(S);
      FOutputStream.Write(LATemp[1], Length(S));
    finally
      FreeAndNil(LStream);
    end;
  end;

begin
  LChoiceItems := '';
  Font := TFont.Create;
  try
    with FPDFFormFields do
      for LI := 0 to Count - 1 do
      begin
        Ls := '';
        Flags := 0;
        with TgtPDFFormField(Objects[LI]) do
        begin
          if afpReadOnly in Preferences then
            Flags := Flags or 1;
          if afpRequired in Preferences then
            Flags := Flags or 2;
          if afpNoExport in Preferences then
            Flags := Flags or 4;

        end;

        if TgtPDFFormField(Objects[LI]) is TgtPDFFormSignatureField then
        begin
          with TgtPDFFormSignatureField(Objects[LI]) do
          begin
            Ls := '/Type /Annot ' + '/Subtype /Widget ' + '/Rect [ ' +
              NumToStr(GetNativeXPos(Rect.Left) * (CPixelsPerInch / InputXRes))
              + ' ' + NumToStr(GetNativeYPos(Rect.Top, FPageNo) *
              (CPixelsPerInch / InputYRes)) + ' ' +
              NumToStr(GetNativeXPos(Rect.Right) * (CPixelsPerInch / InputXRes))
              + ' ' + NumToStr(GetNativeYPos(Rect.Bottom, FPageNo) *
              (CPixelsPerInch / InputYRes)) + ' ] ' + '/P ' +
              MakeObjRef(TgtPageInfo(FPageList.Items[FPageNo - 1]).ObjNo) +
              '/FT /Sig';
            Ls := Ls + ' /Ff 0' + ' /MK <<>> ';
            SValue := '';
            if FieldName = '' then
              SValue := 'Signature' + IntToStr(LI)
            else
              SValue := FieldName;

            Ls := Ls + '/T (' + WritePDFString(SValue, StrToInt(Strings[LI]),
              0) + ') ';
          end;
        end

        else if TgtPDFFormField(Objects[LI]) is TgtPDFFormPushButton then
        begin
          Flags := Flags or (1 shl 16);
          with TgtPDFFormPushButton(Objects[LI]) do
          begin
            FontIdx := FFontIndex;
            NormalAppObj := GetNewObjNo;
            DownAppObj := GetNewObjNo;
            RolloverAppObj := GetNewObjNo;

            LWidth := (Rect.Right - Rect.Left) * FPixelToPointMultiplier;
            LHeight := (Rect.Bottom - Rect.Top) * FPixelToPointMultiplier;
            SValue := '/F' + IntToStr(FontIdx) + ' ' + IntToStr(Font.Size) +
              ' Tf ' + ColorToPDFColor(Font.Color) + ' rg ';
            Ls := '/Type /Annot ' + '/Subtype /Widget ' + '/Rect [ ' +
              NumToStr(GetNativeXPos(Rect.Left) * (CPixelsPerInch / InputXRes))
              + ' ' + NumToStr(GetNativeYPos(Rect.Top, FPageNo) *
              (CPixelsPerInch / InputYRes)) + ' ' +
              NumToStr(GetNativeXPos(Rect.Right) * (CPixelsPerInch / InputXRes))
              + ' ' + NumToStr(GetNativeYPos(Rect.Bottom, FPageNo) *
              (CPixelsPerInch / InputYRes)) + ' ] ' + GetAnnotBrushStyle(2,
              absBeveled) + '/TU <' +
              String(GetHexOfStr(AnsiString(WritePDFString(AltFieldName,
              StrToInt(Strings[LI]), 0)))) + '> ' + '/DA <' +
              String(GetHexOfStr(AnsiString(WritePDFString(SValue,
              StrToInt(Strings[LI]), 0)))) + '> ' + '/FT /Btn ';
            if Visible then
              Ls := Ls + '/MK << ' + '/BG [ ' + ColorToPDFColor(BackgroundColor)
                + ' ] ' + '/BC [ ' + ColorToPDFColor(BorderColor) + ' ] ' +
                '/AC <' + String
                (GetHexOfStr(AnsiString(WritePDFString(DownCaption,
                StrToInt(Strings[LI]), 0)))) + '> ' + '/RC <' +
                String(GetHexOfStr(AnsiString(WritePDFString(RolloverCaption,
                StrToInt(Strings[LI]), 0)))) + '> ' + '/CA <' +
                String(GetHexOfStr(AnsiString(WritePDFString(NormalCaption,
                StrToInt(Strings[LI]), 0)))) + '>' + '>> ' + '/H /P ' +
                '/AP << /N ' + MakeObjRef(NormalAppObj) + ' /D ' +
                MakeObjRef(DownAppObj) + ' /R ' +
                MakeObjRef(RolloverAppObj) + ' >>'
            else
              Ls := Ls + '/H /N ';
            if FieldName = '' then
              SValue := 'Btn' + IntToStr(LI)
            else
              SValue := FieldName;

            Ls := Ls + '/T <' +
              String(GetHexOfStr(AnsiString(WritePDFString(SValue,
              StrToInt(Strings[LI]), 0)))) + '> ';

            if Action = pbaReset then
              Ls := Ls + '/A << /S /ResetForm >>'
            else if Action = pbaSubmit then
            begin
              Ls := Ls + '/A << /S /SubmitForm ';
              case FFormSubmitFormat of
                fsfHTML:
                  Ls := Ls + '/Flags 4 ';
                fsfXML:
                  Ls := Ls + '/Flags 32 ';
              end;
              Ls := Ls + '/F <' +
                String(GetHexOfStr(AnsiString(WritePDFString(FSubmitURL,
                StrToInt(Strings[LI]), 0)))) + '> >>';
            end
            else if Action = pbaJavaScript then
              Ls := Ls + '/A << /S /JavaScript /JS <' +
                String(GetHexOfStr(AnsiString(WritePDFString(JavaScript,
                StrToInt(Strings[LI]), 0)))) + '> >>';

            DrawButton(LWidth, LHeight, NormalCaption, NormalAppObj, False,
              BackgroundColor, BorderColor, Font);
            DrawButton(LWidth, LHeight, DownCaption, DownAppObj, True,
              BackgroundColor, BorderColor, Font);
            DrawButton(LWidth, LHeight, RolloverCaption, RolloverAppObj, False,
              BackgroundColor, BorderColor, Font);
          end;
        end
        else if TgtPDFFormField(Objects[LI]) is TgtPDFFormCheckBox then
        begin
          with TgtPDFFormCheckBox(Objects[LI]) do
          begin
            FontIdx := FFontIndex;
            LWidth := (Rect.Right - Rect.Left) * FPixelToPointMultiplier;
            LHeight := (Rect.Bottom - Rect.Top) * FPixelToPointMultiplier;

            NormalOnStateObj := GetNewObjNo;
            NormalOffStateObj := GetNewObjNo;
            DownOnStateObj := GetNewObjNo;
            DownOffStateObj := GetNewObjNo;
            SValue := '/F' + IntToStr(FontIdx) + ' ' + IntToStr(Font.Size) +
              ' Tf ' + ColorToPDFColor(Font.Color) + ' rg ';
            Ls := '/Type /Annot ' + '/Rect [ ' +
              NumToStr(GetNativeXPos(Rect.Left) * (CPixelsPerInch / InputXRes))
              + ' ' + NumToStr(GetNativeYPos(Rect.Top, FPageNo) *
              (CPixelsPerInch / InputYRes)) + ' ' +
              NumToStr(GetNativeXPos(Rect.Right) * (CPixelsPerInch / InputXRes))
              + ' ' + NumToStr(GetNativeYPos(Rect.Bottom, FPageNo) *
              (CPixelsPerInch / InputYRes)) + ' ] ' + GetAnnotBrushStyle(1,
              absSolid) + ' ' + '/H /N ' + '/FT /Btn ' + '/Subtype /Widget ' +
              '/DA <' + String(GetHexOfStr(AnsiString(WritePDFString(SValue,
              StrToInt(Strings[LI]), 0)))) + '> ' + '/MK << ' + '/BC [ ' +
              ColorToPDFColor(BorderColor) + ' ] ' + '/BG [ ' +
              ColorToPDFColor(BackgroundColor) + ' ] ' + '/CA <' +
              String(GetHexOfStr(AnsiString(WritePDFString(CheckSymbol[Symbol],
              StrToInt(Strings[LI]), 0)))) + '>' + '>> ' + '/AP << ' + '/N <<' +
              ' /Yes ' + MakeObjRef(NormalOnStateObj) + ' /Off ' +
              MakeObjRef(NormalOffStateObj) + ' >>' + ' /D <<' + ' /Yes ' +
              MakeObjRef(DownOnStateObj) + ' /Off ' +
              MakeObjRef(DownOffStateObj) + ' >>' + ' >> ';

            SValue := '';
            if FieldName = '' then
              SValue := 'ChBtn' + IntToStr(LI)
            else
              SValue := FieldName;

            Ls := Ls + '/T <' +
              String(GetHexOfStr(AnsiString(WritePDFString(SValue,
              StrToInt(Strings[LI]), 0)))) + '> ';

            if Checked then
              Ls := Ls + '/V /Yes ' + '/DV /Yes ' + '/AS /Yes '
            else
              Ls := Ls + '/V /Off ' + '/DV /Off ' + '/AS /Off ';

            DrawNormalCheckBox(LWidth, LHeight, CheckSymbol[Symbol],
              NormalOnStateObj, True, BackgroundColor, BorderColor, Font);
            DrawNormalCheckBox(LWidth, LHeight, CheckSymbol[Symbol],
              NormalOffStateObj, False, BackgroundColor, BorderColor, Font);
            DrawDownCheckBox(LWidth, LHeight, CheckSymbol[Symbol],
              DownOnStateObj, True, BackgroundColor, BorderColor, Font);
            DrawDownCheckBox(LWidth, LHeight, CheckSymbol[Symbol],
              DownOffStateObj, False, BackgroundColor, BorderColor, Font);
          end;
        end
        else if TgtPDFFormField(Objects[LI]) is TgtPDFFormRadioButton then
        begin
          Flags := Flags or (1 shl 15);
          with TgtPDFFormRadioButton(Objects[LI]) do
          begin
            if (FPageList.Count < FPageNo) or
              (FPageList.Items[FPageNo - 1] = nil) then
              Continue;
            if AtleastOneSelectedItem then
              Flags := Flags or (1 shl 14);

            FontIdx := FFontIndex;
            PageNo := FPageNo;
            (*
              If some item is selected as default and the selected item is
              within the margin set Value & DefaultValue.
            *)
            if (SelectedItemIndex <> -1) and
              (FItems.Objects[SelectedItemIndex] <> nil) then
              Ls := '/DV /' + TgtPDFFormRadioItem
                (FItems.Objects[SelectedItemIndex]).Value + ' /V /' +
                TgtPDFFormRadioItem(FItems.Objects[SelectedItemIndex]).Value;

            SValue := '';
            if FieldName = '' then
              SValue := 'RBtn' + IntToStr(LI)
            else
              SValue := FieldName;

            Ls := Ls + '/T <' +
              String(GetHexOfStr(AnsiString(WritePDFString(SValue,
              StrToInt(Strings[LI]), 0)))) + '> ';

            SValue := '/F' + IntToStr(FontIdx) + ' ' + IntToStr(Font.Size) +
              ' Tf ' + ColorToPDFColor(Font.Color) + ' rg ';

            Ls := Ls + '/DA <' +
              String(GetHexOfStr(AnsiString(WritePDFString(SValue,
              StrToInt(Strings[LI]), 0)))) + '> ' + '/FT /Btn' + '/Kids [';
            for LJ := 0 to FItems.Count - 1 do
            begin
              (*
                If Item was removed because it is not within the margin.
                Continue.
              *)
              if FItems.Objects[LJ] = nil then
                Continue;

              Ls := Ls + ' ' + FItems.Strings[LJ] + ' 0 R';

              LS1 := '/Type /Annot' + '/Subtype /Widget' + '/P ' +
                MakeObjRef(TgtPageInfo(FPageList.Items[FPageNo - 1]).ObjNo);

              with TgtPDFFormRadioItem(FItems.Objects[LJ]) do
              begin
                LWidth := (Rect.Right - Rect.Left) * FPixelToPointMultiplier;
                LHeight := (Rect.Bottom - Rect.Top) * FPixelToPointMultiplier;
                LS1 := LS1 + '/Rect [' +
                  NumToStr(GetNativeXPos(Rect.Left) *
                  (CPixelsPerInch / InputXRes)) + ' ' +
                  NumToStr(GetNativeYPos(Rect.Top, PageNo) *
                  (CPixelsPerInch / InputYRes)) + ' ' +
                  NumToStr(GetNativeXPos(Rect.Right) *
                  (CPixelsPerInch / InputXRes)) + ' ' +
                  NumToStr(GetNativeYPos(Rect.Bottom, PageNo) *
                  (CPixelsPerInch / InputYRes)) + ']' + '/Parent ' + Strings[LI]
                  + ' 0 R ' + '/MK <<' + '/BG [' +
                  ColorToPDFColor(BackgroundColor) + ']' + '/BC [' +
                  ColorToPDFColor(BorderColor) + ']' + '/CA <' +
                  String(GetHexOfStr
                  (AnsiString(WritePDFString(CheckSymbol[Symbol],
                  StrToInt(FItems.Strings[LJ]), 0)))) + '>' + '>>';
                if LJ = SelectedItemIndex then
                  LS1 := LS1 + '/AS /' + Value
                else
                  LS1 := LS1 + '/AS /Off';
                (* Set Flag to allow printing. *)
                LS1 := LS1 + '/F 4';
                NormalOnStateObj := GetNewObjNo;
                NormalOffStateObj := GetNewObjNo;
                DownOnStateObj := GetNewObjNo;
                DownOffStateObj := GetNewObjNo;
                LS1 := LS1 + '/AP <<' + '/N <<' + '/' + Value + ' ' +
                  MakeObjRef(NormalOnStateObj) + '/Off ' +
                  MakeObjRef(NormalOffStateObj) + '>>' + ' /D <<' + '/' + Value
                  + ' ' + MakeObjRef(DownOnStateObj) + '/Off ' +
                  MakeObjRef(DownOffStateObj) + '>>' + ' >>';
                DrawNormalCheckBox(LWidth, LHeight, CheckSymbol[Symbol],
                  NormalOnStateObj, True, BackgroundColor, BorderColor,
                  TgtPDFFormRadioButton(Objects[LI]).Font);
                DrawNormalCheckBox(LWidth, LHeight, CheckSymbol[Symbol],
                  NormalOffStateObj, False, BackgroundColor, BorderColor,
                  TgtPDFFormRadioButton(Objects[LI]).Font);
                DrawDownCheckBox(LWidth, LHeight, CheckSymbol[Symbol],
                  DownOnStateObj, True, BackgroundColor, BorderColor,
                  TgtPDFFormRadioButton(Objects[LI]).Font);
                DrawDownCheckBox(LWidth, LHeight, CheckSymbol[Symbol],
                  DownOffStateObj, False, BackgroundColor, BorderColor,
                  TgtPDFFormRadioButton(Objects[LI]).Font);
                LS1 := LS1 + CRLF;
                WriteObj(LS1, StrToInt(FItems.Strings[LJ]), True);
              end;
            end;
            Ls := Ls + ']';
          end;
        end
        else if TgtPDFFormField(Objects[LI]) is TgtPDFFormTextField then
        begin
          with TgtPDFFormTextField(Objects[LI]) do
          begin
            FontIdx := FFontIndex;

            if IsMultiline then
              Flags := Flags or (1 shl 12);
            if IsPassword then
              Flags := Flags or (1 shl 13);
            if IsFileSelect then
              Flags := Flags or (1 shl 20);
            if IsDoNotSpellCheck then
              Flags := Flags or (1 shl 22);
            if IsDoNotScroll then
              Flags := Flags or (1 shl 23);

            NormalAppObj := GetNewObjNo;
            LWidth := (Rect.Right - Rect.Left) * FPixelToPointMultiplier;
            LHeight := (Rect.Bottom - Rect.Top) * FPixelToPointMultiplier;
            SValue := '/F' + IntToStr(FontIdx) + ' ' + IntToStr(Font.Size) +
              ' Tf ' + ColorToPDFColor(Font.Color) + ' rg ';
            Ls := '/Type /Annot ' + '/Subtype /Widget ' +
              GetAnnotBrushStyle(1, absSolid) + ' ' + '/MK << ';
            if IsBorder then
              Ls := Ls + '/BC [ ' + ColorToPDFColor(BorderColor) + ' ] ';
            Ls := Ls + '/BG [ ' + ColorToPDFColor(BackgroundColor) + ' ] ' +
              '>> ' + '/Rect [ ' + NumToStr(GetNativeXPos(Rect.Left) *
              (CPixelsPerInch / InputXRes)) + ' ' +
              NumToStr(GetNativeYPos(Rect.Top, FPageNo) *
              (CPixelsPerInch / InputYRes)) + ' ' +
              NumToStr(GetNativeXPos(Rect.Right) * (CPixelsPerInch / InputXRes))
              + ' ' + NumToStr(GetNativeYPos(Rect.Bottom, FPageNo) *
              (CPixelsPerInch / InputYRes)) + ' ] ' + '/DA <' +
              String(GetHexOfStr(AnsiString(WritePDFString(SValue,
              StrToInt(Strings[LI]), 0)))) + '> ' + '/FT /Tx ';
            case HAlignment of
              taCenter:
                Ls := Ls + '/Q 1';
              taRight:
                Ls := Ls + '/Q 2';
            else
              Ls := Ls + '/Q 0';
            end;
            Ls := Ls + ' /V <' +
              String(GetHexOfStr(AnsiString(WritePDFString(Value,
              StrToInt(Strings[LI]), 0)))) + '> ' + '/DV <' +
              String(GetHexOfStr(AnsiString(WritePDFString(Value,
              StrToInt(Strings[LI]), 0)))) + '>' + '/AP << /N ' +
              MakeObjRef(NormalAppObj) + ' >> ';

            SValue := '';
            if FieldName = '' then
              SValue := 'Text' + IntToStr(LI)
            else
              SValue := FieldName;

            Ls := Ls + '/T <' +
              String(GetHexOfStr(AnsiString(WritePDFString(SValue,
              StrToInt(Strings[LI]), 0)))) + '> ';

            if MaxLength <> -1 then
              Ls := Ls + '/MaxLen ' + IntToStr(MaxLength);

            DrawText(LWidth, LHeight, Value, IsMultiline, NormalAppObj,
              BackgroundColor, BorderColor, Font, IsBorder);
          end;
        end
        else if TgtPDFFormField(Objects[LI]) is TgtPDFFormComboBox then
        begin
          with TgtPDFFormComboBox(Objects[LI]) do
          begin
            Flags := Flags or (1 shl 17);
            if IsEditable then
              Flags := Flags or (1 shl 18);

            LChoiceItems := '';
            for LJ := 0 to Length(FItems) - 1 do
            begin
              LChoiceItems := LChoiceItems + ' <' +
                String(GetHexOfStr(AnsiString(WritePDFString(FItems[LJ],
                StrToInt(Strings[LI]), 0)))) + '>';
            end;
            FontIdx := FFontIndex;
            LWidth := (Rect.Right - Rect.Left) * FPixelToPointMultiplier;
            LHeight := (Rect.Bottom - Rect.Top) * FPixelToPointMultiplier;
            NormalAppObj := GetNewObjNo;

            SValue := '3 14.5 Td ';
            SValue := SValue + '/F' + IntToStr(FontIdx) + ' ' +
              IntToStr(Font.Size) + ' Tf ' +
              ColorToPDFColor(Font.Color) + ' rg ';

            Ls := '/Type /Annot ' + '/Subtype /Widget ' + '/Rect [ ' +
              NumToStr(GetNativeXPos(Rect.Left) * (CPixelsPerInch / InputXRes))
              + ' ' + NumToStr(GetNativeYPos(Rect.Top, FPageNo) *
              (CPixelsPerInch / InputYRes)) + ' ' +
              NumToStr(GetNativeXPos(Rect.Right) * (CPixelsPerInch / InputXRes))
              + ' ' + NumToStr(GetNativeYPos(Rect.Bottom, FPageNo) *
              (CPixelsPerInch / InputYRes)) + ' ]' + GetAnnotBrushStyle(1,
              absSolid) + ' ' + '/Opt [ ' + LChoiceItems + ' ] ' + '/DA <' +
              String(GetHexOfStr(AnsiString(WritePDFString(SValue,
              StrToInt(Strings[LI]), 0)))) + '> ' + '/FT /Ch ' + '/MK << ' +
              '/BC [ ' + ColorToPDFColor(BorderColor) + ' ] ' + '/BG [ ' +
              ColorToPDFColor(BackgroundColor) + ' ] ' + '>> ' + '/AP << /N ' +
              MakeObjRef(NormalAppObj) + ' >> ';

            SValue := '';
            if FieldName = '' then
              SValue := 'Combo' + IntToStr(LI)
            else
              SValue := FieldName;

            Ls := Ls + '/T <' +
              String(GetHexOfStr(AnsiString(WritePDFString(SValue,
              StrToInt(Strings[LI]), 0)))) + '> ';

            if SelectedItemIndex <> -1 then
              LChoiceValue := FItems[SelectedItemIndex]
            else if Value = '' then
              LChoiceValue := 'Choice'
            else
              LChoiceValue := Value;
            Ls := Ls + '/V <' +
              String(GetHexOfStr(AnsiString(WritePDFString(LChoiceValue,
              StrToInt(Strings[LI]), 0)))) + '> ' + '/DV <' +
              String(GetHexOfStr(AnsiString(WritePDFString(LChoiceValue,
              StrToInt(Strings[LI]), 0)))) + '> ';

            DrawComboBox(LWidth, LHeight, LChoiceValue, NormalAppObj,
              BackgroundColor, BorderColor, Font);
          end;
        end
        else if TgtPDFFormField(Objects[LI]) is TgtPDFFormListBox then
        begin
          with TgtPDFFormListBox(Objects[LI]) do
          begin
            if IsMultiSelect then
              Flags := Flags or (1 shl 21);

            LChoiceItems := '';
            for LJ := 0 to Length(FItems) - 1 do
            begin
              LChoiceItems := LChoiceItems + ' <' +
                String(GetHexOfStr(AnsiString(WritePDFString(FItems[LJ],
                StrToInt(Strings[LI]), 0)))) + '>';
            end;

            FontIdx := FFontIndex;
            NormalAppObj := GetNewObjNo;
            LWidth := (Rect.Right - Rect.Left) * FPixelToPointMultiplier;
            LHeight := (Rect.Bottom - Rect.Top) * FPixelToPointMultiplier;

            SValue := '/F' + IntToStr(FontIdx) + ' ' + IntToStr(Font.Size) +
              ' Tf ' + ColorToPDFColor(Font.Color) + ' rg ';
            Ls := '/Type /Annot ' + '/Subtype /Widget ' + '/Rect [ ' +
              NumToStr(GetNativeXPos(Rect.Left) * (CPixelsPerInch / InputXRes))
              + ' ' + NumToStr(GetNativeYPos(Rect.Top, FPageNo) *
              (CPixelsPerInch / InputYRes)) + ' ' +
              NumToStr(GetNativeXPos(Rect.Right) * (CPixelsPerInch / InputXRes))
              + ' ' + NumToStr(GetNativeYPos(Rect.Bottom, FPageNo) *
              (CPixelsPerInch / InputYRes)) + ' ]' + GetAnnotBrushStyle(1,
              absInset) + ' ' + '/Opt [ ' + LChoiceItems + ' ] ' + '/DA <' +
              String(GetHexOfStr(AnsiString(WritePDFString(SValue,
              StrToInt(Strings[LI]), 0)))) + '> ' + '/FT /Ch ' + '/MK << ' +
              '/BC [ ' + ColorToPDFColor(BorderColor) + ' ] ' + '/BG [ ' +
              ColorToPDFColor(BackgroundColor) + ' ] ' + '>> ';
            if (Length(FItems) > 0) then
              Ls := Ls + '/V <' +
                String(GetHexOfStr(AnsiString(WritePDFString(FItems[0],
                StrToInt(Strings[LI]), 0)))) + '> ' + '/DV <' +
                String(GetHexOfStr(AnsiString(WritePDFString(FItems[0],
                StrToInt(Strings[LI]), 0)))) + '> ';
            Ls := Ls + '/AP << /N ' + MakeObjRef(NormalAppObj) + ' >> ';

            SValue := '';
            if FieldName = '' then
              SValue := 'List' + IntToStr(LI)
            else
              SValue := FieldName;

            Ls := Ls + '/T <' +
              String(GetHexOfStr(AnsiString(WritePDFString(SValue,
              StrToInt(Strings[LI]), 0)))) + '> ';

            DrawListBox(LWidth, LHeight, FItems, NormalAppObj, BackgroundColor,
              BorderColor, Font);

          end;
        end;

        (* Set Flag to allow printing. *)
        if (not(TgtPDFFormField(Objects[LI]) is TgtPDFFormRadioButton)) then
          Ls := Ls + '/F 4';
        if (not(TgtPDFFormField(Objects[LI]) is TgtPDFFormSignatureField)) then
          Ls := Ls + '/Ff ' + IntToStr(Flags);
        Ls := Ls + CRLF;
        WriteObj(Ls, StrToInt(Strings[LI]), True);
      end;
  finally
    FreeAndNil(Font);
  end;
end;

procedure TgtExPDFEngine.WriteSignatureField;
begin
  SetSignatureField(SigFormField.Rect, SigFormField.PageNo);
end;

procedure TgtExPDFEngine.AddAnnotItem(AAnnot: TgtPDFAnnot);
var
  LBandType: TgtBandType;
begin
  if FIsDocumentStarted = False then
  begin
    FreeAndNil(AAnnot);
    Exit;
  end;

  (* Convert values from measurement units to native unit (pixels). *)

  with AAnnot do
    Rect := NativeRect(Rect);

  (* Position the form fields within the Content band. *)
  LBandType := BandType;
  BandType := btContent;
  with AAnnot, BandRect do
    Rect := gtRect(Left + Rect.Left, Top + Rect.Top, Left + Rect.Right,
      Top + Rect.Bottom);
  (* If Top-Left is not within the Content Band range donot add. *)
  if (AAnnot.Rect.Left < BandRect.Left) or (AAnnot.Rect.Left > BandRect.Right)
    or (AAnnot.Rect.Top < BandRect.Top) or (AAnnot.Rect.Top > BandRect.Bottom)
  then
  begin
    FreeAndNil(AAnnot);
    BandType := LBandType;
    Exit;
  end
  else
    BandType := LBandType;

  AAnnot.FPageNo := CurrentPage;
  FAnnotList.AddObject(IntToStr(GetNewObjNo), AAnnot);
end;

procedure TgtExPDFEngine.WriteAnnots;
var
  LI, LJ, FileObj: Integer;
  Ls, LS1: String;
  LATemp: AnsiString;
  LMemoryStream, LStream: TMemoryStream;
  LStreamSize: Int64;

  function ToUnicodeNumbers(AStr: WideString): String;
  var
    LK: Integer;
  begin
    Result := '';
    for LK := 1 to Length(AStr) do
    begin
      if Ord(AStr[LK]) > 256 then
        Result := Result + '&#' + IntToStr(Ord(AStr[LK])) + ';'
      else
        Result := Result + AStr[LK];
    end;
  end;

const
  TextNotes: array [TgtTextNote] of String = ('Comment', 'Key', 'Note', 'Help',
    'NewParagraph', 'Paragraph', 'Insert');
  CSHighlightMode: array [TgtAnnotHighlightMode] of String = ('/N', '/I',
    '/O', '/P');
  LineStyles: array [TgtLineStyle] of String = ('None', 'Butt', 'Square',
    'Circle', 'Diamond', 'OpenArrow', 'ClosedArrow', 'ROpenArrow',
    'RClosedArrow');
  BorderStyles: array [TgtBorderStyle] of String = ('/S', '/D', '/B',
    '/I', '/U');
  Cloud: array [Boolean] of String = ('/S', '/C');
  Intensities: array [TgtIntensity] of String = ('0', '1', '2');
  TextStyles: array [TgtTextStyle] of String = ('/Highlight', '/Underline',
    '/Squiggly', '/StrikeOut');
  Symbols: array [Boolean] of String = ('/P', '/None');
  Aligns: array [TgtAlign] of String = ('left', 'right', 'center');
  StampTypes: array [TgtStampType] of String = ('/Approved', '/Experimental',
    '/NotApproved', '/AsIs', '/Expired', '/NotForPublicRelease',
    '/Confidential', '/Final', '/Sold', '/Departmental', '/ForComment',
    '/TopSecret', '/Draft', '/ForPublicRelease');
  Icons: array [TgtFileAttachmentIcon] of String = ('/Graph', '/PushPin',
    '/Paperclip', '/Tag');

begin
  for LI := 0 to FAnnotList.Count - 1 do
    with FAnnotList do
    begin
      with TgtPDFAnnot(Objects[LI]) do
        Ls := '/Type /Annot' + '/Rect [' +
          NumToStr(GetNativeXPos(Rect.Left) * (CPixelsPerInch / InputXRes)) +
          ' ' + NumToStr(GetNativeYPos(Rect.Top, FPageNo) *
          (CPixelsPerInch / InputYRes)) + ' ' +
          NumToStr(GetNativeXPos(Rect.Right) * (CPixelsPerInch / InputXRes)) +
          ' ' + NumToStr(GetNativeYPos(Rect.Bottom, FPageNo) *
          (CPixelsPerInch / InputYRes)) + ']';
      if Objects[LI] is TgtPDFTextAnnot then
        with TgtPDFTextAnnot(Objects[LI]) do
        begin
          Ls := Ls + '/Subtype /Text' + ' /T <' + ToUnicodeHex(Title,
            StrToInt(Strings[LI]), 0) + '>' + '/C [' +
            ColorToPDFColor(BorderColor) + ']' + '/Subj<' +
            ToUnicodeHex(Subject, StrToInt(Strings[LI]), 0) + '>' + '/M(D:' +
            FormatDateTime('YYYYMMDDHHmmSS"+05"' + '"' + #39 + '"' + '"30"' +
            '"' + #39 + '"', Now) + ')' + '/Name /' + TextNotes[Name] +
            '/Contents <' + ToUnicodeHex(Contents,
            StrToInt(Strings[LI]), 0) + '>';
          if Open then
            Ls := Ls + '/Open true'
          else
            Ls := Ls + '/Open false';
        end
      else if Objects[LI] is TgtPDFFreeTextAnnot then
        with TgtPDFFreeTextAnnot(Objects[LI]) do
        begin
          Ls := Ls + '/Subtype /FreeText' + '/Contents <' +
            String(GetHexOfStr(AnsiString(WritePDFString(Contents,
            StrToInt(Strings[LI]), 0)))) + '>' + '/DA <' +
            ToUnicodeHex(ColorToPDFColor(BorderColor) + ' rg',
            StrToInt(Strings[LI]), 0) + '>' + '/DS <' +
            ToUnicodeHex('font: ' + FTextFont.Name + ' ' +
            IntToStr(FTextFont.Size) + 'pt; text-align:' + Aligns[FTextAlign] +
            '; color: #' + ColorBGRToRGB(TextColor),
            StrToInt(Strings[LI]), 0) + '>';
        end
      else if Objects[LI] is TgtPDFLinkAnnot then
        with TgtPDFLinkAnnot(Objects[LI]) do
        begin
          (*
            Border is no more used its just provided for backward compatibality.
            Instead use BS.
          *)
          Ls := Ls + '/Subtype /Link' + '/H ' + CSHighlightMode[HighlightMode] +
            '/Border [0 0 ' + IntToStr(BorderWidth) + ']' + '/C [' +
            ColorToPDFColor(BorderColor) + ']';
        end
      else if Objects[LI] is TgtPDFLineAnnot then
        with TgtPDFLineAnnot(Objects[LI]) do
        begin
          Ls := Ls + '/Subtype /Line' + '/L [' +
            NumToStr(GetNativeXPos(NativeXPos(Line.Left))) + ' ' +
            NumToStr(GetNativeYPos(NativeYPos(Line.Top), FPageNo)) + ' ' +
            NumToStr(GetNativeXPos(NativeXPos(Line.Right))) + ' ' +
            NumToStr(GetNativeYPos(NativeYPos(Line.Bottom), FPageNo)) + ']' +
            '/BS << /W ' + IntToStr(BorderWidth) + '/D [' + FBorderPattern +
            '] /S ' + BorderStyles[BorderStyle] + '>>' + '/LE [/' +
            LineStyles[StartStyle] + ' /' + LineStyles[EndStyle] + ']' + '/C ['
            + ColorToPDFColor(BorderColor) + ']' + '/IC [' +
            ColorToPDFColor(InteriorColor) + ']' + '/Contents <' +
            ToUnicodeHex(Contents, StrToInt(Strings[LI]), 0) + '>' + ' /T <' +
            ToUnicodeHex(Title, StrToInt(Strings[LI]), 0) + '>' + '/Subj<' +
            ToUnicodeHex(Subject, StrToInt(Strings[LI]), 0) + '>' + '/M(D:' +
            FormatDateTime('YYYYMMDDHHmmSS"+05"' + '"' + #39 + '"' + '"30"' +
            '"' + #39 + '"', Now) + ')';
        end
      else if Objects[LI] is TgtPDFSquareAnnot then
        with TgtPDFSquareAnnot(Objects[LI]) do
        begin
          Ls := Ls + '/Subtype /Square' + '/BS << /W ' + IntToStr(BorderWidth) +
            '/D [' + FBorderPattern + '] /S ' + BorderStyles[BorderStyle] + '>>'
            + '/C [' + ColorToPDFColor(BorderColor) + ']' + '/IC [' +
            ColorToPDFColor(InteriorColor) + ']' + '/Contents <' +
            ToUnicodeHex(Contents, StrToInt(Strings[LI]), 0) + '>' + ' /T <' +
            ToUnicodeHex(Title, StrToInt(Strings[LI]), 0) + '>' + '/Subj<' +
            ToUnicodeHex(Subject, StrToInt(Strings[LI]), 0) + '>' +

            ' /BE << /S ' + Cloud[Cloudy] + ' /I ' + Intensities[CloudIntensity]
            + '>> /RD [' + NumToStr(DifferRect.Left) + ' ' +
            NumToStr(DifferRect.Top) + ' ' + NumToStr(DifferRect.Right) + ' ' +
            NumToStr(DifferRect.Bottom) + ']' + ' /T <' +
            ToUnicodeHex(Title, StrToInt(Strings[LI]), 0) + '>' + '/Subj<' +
            ToUnicodeHex(Subject, StrToInt(Strings[LI]), 0) + '>' + '/M(D:' +
            FormatDateTime('YYYYMMDDHHmmSS"+05"' + '"' + #39 + '"' + '"30"' +
            '"' + #39 + '"', Now) + ')';

        end
      else if Objects[LI] is TgtPDFPolygonAnnot then
        with TgtPDFPolygonAnnot(Objects[LI]) do
        begin
          LS1 := '';
          for LJ := 0 to High(FVertices) do
          begin
            LS1 := LS1 + NumToStr(GetNativeXPos(NativeXPos(FVertices[LJ].X))) +
              ' ' + NumToStr(GetNativeYPos(NativeYPos(FVertices[LJ].Y),
              FPageNo)) + ' '
          end;
          Ls := Ls + '/Subtype /Polygon /Vertices [' + LS1 + '] ' + '/BS << /W '
            + IntToStr(BorderWidth) + '/D [' + FBorderPattern + '] /S ' +
            BorderStyles[BorderStyle] + '>>' + '/C [' +
            ColorToPDFColor(BorderColor) + ']' + ' /IC [' +
            ColorToPDFColor(InteriorColor) + ']' + '/Contents <' +
            ToUnicodeHex(Contents, StrToInt(Strings[LI]), 0) + '>' + ' /T <' +
            ToUnicodeHex(Title, StrToInt(Strings[LI]), 0) + '>' + '/Subj<' +
            ToUnicodeHex(Subject, StrToInt(Strings[LI]), 0) + '>' +
            ' /BE << /S ' + Cloud[Cloudy] + ' /I ' + Intensities[CloudIntensity]
            + '>>/T <' + ToUnicodeHex(Title, StrToInt(Strings[LI]), 0) + '>' +
            '/Subj<' + ToUnicodeHex(Subject, StrToInt(Strings[LI]), 0) + '>' +
            '/M(D:' + FormatDateTime('YYYYMMDDHHmmSS"+05"' + '"' + #39 + '"' +
            '"30"' + '"' + #39 + '"', Now) + ')';

        end
      else if Objects[LI] is TgtPDFPolylineAnnot then
        with TgtPDFPolylineAnnot(Objects[LI]) do
        begin
          LS1 := '';
          for LJ := 0 to High(FVertices) do
          begin
            LS1 := LS1 + NumToStr(GetNativeXPos(NativeXPos(FVertices[LJ].X))) +
              ' ' + NumToStr(GetNativeYPos(NativeYPos(FVertices[LJ].Y),
              FPageNo)) + ' '
          end;
          Ls := Ls + '/Subtype /PolyLine /Vertices [' + LS1 + '] ' +
            '/BS << /W ' + IntToStr(BorderWidth) + '/D [' + FBorderPattern +
            '] /S ' + BorderStyles[BorderStyle] + '>>' + '/C [' +
            ColorToPDFColor(BorderColor) + ']' + '/LE [/' + LineStyles
            [StartStyle] + ' /' + LineStyles[EndStyle] + '] /IC [' +
            ColorToPDFColor(InteriorColor) + ']' + ' /BE << /S ' + Cloud[Cloudy]
            + ' /I ' + Intensities[CloudIntensity] + '>> /T <' +
            ToUnicodeHex(Title, StrToInt(Strings[LI]), 0) + '>' + '/Contents <'
            + ToUnicodeHex(Contents, StrToInt(Strings[LI]), 0) + '>' + '/Subj<'
            + ToUnicodeHex(Subject, StrToInt(Strings[LI]), 0) + '>' + '/M(D:' +
            FormatDateTime('YYYYMMDDHHmmSS"+05"' + '"' + #39 + '"' + '"30"' +
            '"' + #39 + '"', Now) + ')';

        end
      else if Objects[LI] is TgtPDFStampAnnot then
        with TgtPDFStampAnnot(Objects[LI]) do
        begin
          Ls := Ls + '/Subtype /Stamp ' + '/Name ' + StampTypes[FStampType] +
            '/C [' + ColorToPDFColor(BorderColor) + '] ' + '/Contents <' +
            ToUnicodeHex(Contents, StrToInt(Strings[LI]), 0) + '>' + '/T <' +
            ToUnicodeHex(Title, StrToInt(Strings[LI]), 0) + '>' + '/Subj<' +
            ToUnicodeHex(Subject, StrToInt(Strings[LI]), 0) + '>' + '/M(D:' +
            FormatDateTime('YYYYMMDDHHmmSS"+05"' + '"' + #39 + '"' + '"30"' +
            '"' + #39 + '"', Now) + ')';

        end
      else if Objects[LI] is TgtPDFCircleAnnot then
        with TgtPDFCircleAnnot(Objects[LI]) do
        begin
          Ls := Ls + '/Subtype /Circle' + '/BS << /W ' + IntToStr(BorderWidth) +
            '/D [' + FBorderPattern + '] /S ' + BorderStyles[BorderStyle] + '>>'
            + '/C [' + ColorToPDFColor(BorderColor) + ']' + '/IC [' +
            ColorToPDFColor(InteriorColor) + ']' + '/Contents <' +
            ToUnicodeHex(Contents, StrToInt(Strings[LI]), 0) + '>' +
            ' /BE << /S ' + Cloud[Cloudy] + ' /I ' + Intensities[CloudIntensity]
            + '>>' + '/RD [' + NumToStr(DifferRect.Left) + ' ' +
            NumToStr(DifferRect.Top) + ' ' + NumToStr(DifferRect.Right) + ' ' +
            NumToStr(DifferRect.Bottom) + ']' + ' /T <' +
            ToUnicodeHex(Title, StrToInt(Strings[LI]), 0) + '>' + '/Subj<' +
            ToUnicodeHex(Subject, StrToInt(Strings[LI]), 0) + '>' + '/M(D:' +
            FormatDateTime('YYYYMMDDHHmmSS"+05"' + '"' + #39 + '"' + '"30"' +
            '"' + #39 + '"', Now) + ')';

        end
      else if Objects[LI] is TgtPDFTextMarkupAnnot then
        with TgtPDFTextMarkupAnnot(Objects[LI]) do
        begin
          LS1 := '';
          for LJ := 0 to High(FQuadPoints) do
          begin
            LS1 := LS1 + NumToStr(GetNativeXPos(NativeXPos(FQuadPoints[LJ].X)))
              + ' ' + NumToStr(GetNativeYPos(NativeYPos(FQuadPoints[LJ].Y),
              FPageNo)) + ' '
          end;
          Ls := Ls + '/Subtype ' + TextStyles[FTextStyle] + '/QuadPoints [' +
            LS1 + ']' + '/Contents <' + ToUnicodeHex(Contents,
            StrToInt(Strings[LI]), 0) + '>' + '/C [' +
            ColorToPDFColor(BorderColor) + '] ' + ' /T <' +
            ToUnicodeHex(Title, StrToInt(Strings[LI]), 0) + '>' + '/Subj<' +
            ToUnicodeHex(Subject, StrToInt(Strings[LI]), 0) + '>' + '/M(D:' +
            FormatDateTime('YYYYMMDDHHmmSS"+05"' + '"' + #39 + '"' + '"30"' +
            '"' + #39 + '"', Now) + ')';
        end
      else if Objects[LI] is TgtPDFCaretAnnot then
        with TgtPDFCaretAnnot(Objects[LI]) do
        begin
          Ls := Ls + '/Subtype /Caret /sy ' + Symbols[FSymbol] + '/C [' +
            ColorToPDFColor(BorderColor) + ']' + '/Contents <' +
            ToUnicodeHex(Contents, StrToInt(Strings[LI]), 0) + '>' + ' /RD [' +
            NumToStr(DifferRect.Left) + ' ' + NumToStr(DifferRect.Top) + ' ' +
            NumToStr(DifferRect.Right) + ' ' + NumToStr(DifferRect.Bottom) + ']'
            + ' /T <' + ToUnicodeHex(Title, StrToInt(Strings[LI]), 0) + '>' +
            '/Subj<' + ToUnicodeHex(Subject, StrToInt(Strings[LI]), 0) + '>' +
            '/M(D:' + FormatDateTime('YYYYMMDDHHmmSS"+05"' + '"' + #39 + '"' +
            '"30"' + '"' + #39 + '"', Now) + ')';

        end
      else if Objects[LI] is TgtPDFInkAnnot then
        with TgtPDFInkAnnot(Objects[LI]) do
        begin
          LS1 := '';
          for LJ := 0 to High(FInkPoints) do
          begin
            LS1 := LS1 + NumToStr(GetNativeXPos(NativeXPos(FInkPoints[LJ].X))) +
              ' ' + NumToStr(GetNativeYPos(NativeYPos(FInkPoints[LJ].Y),
              FPageNo)) + ' '
          end;
          Ls := Ls + '/Subtype /Ink ' + '/InkList [[' + LS1 + ']] /C [' +
            ColorToPDFColor(BorderColor) + ']' + '/Contents <' +
            ToUnicodeHex(Contents, StrToInt(Strings[LI]), 0) + '>' + ' /T <' +
            ToUnicodeHex(Title, StrToInt(Strings[LI]), 0) + '>' + '/Subj<' +
            ToUnicodeHex(Subject, StrToInt(Strings[LI]), 0) + '>' + '/M(D:' +
            FormatDateTime('YYYYMMDDHHmmSS"+05"' + '"' + #39 + '"' + '"30"' +
            '"' + #39 + '"', Now) + ')';
        end
      else if Objects[LI] is TgtPDFFileAttachmentAnnot then
        with TgtPDFFileAttachmentAnnot(Objects[LI]) do
        begin
          if FileExists(AttachedFileName) then
          begin
            FileObj := GetNewObjNo;
            Ls := Ls + '/Subtype /FileAttachment' + '/Name ' +
              Icons[FileAttachmentIcon] + '/C [' + ColorToPDFColor(BorderColor)
              + ']' + '/Subj<' + ToUnicodeHex(Subject, StrToInt(Strings[LI]), 0)
              + '>' + '/Contents <' + ToUnicodeHex(Contents,
              StrToInt(Strings[LI]), 0) + '>' + ' /T <' +
              ToUnicodeHex(Title, StrToInt(Strings[LI]), 0) + '>' + '/M(D:' +
              FormatDateTime('YYYYMMDDHHmmSS"+05"' + '"' + #39 + '"' + '"30"' +
              '"' + #39 + '"', Now) + ')' + '/FS << ' + '/F <' +
              String(GetHexOfStr(AnsiString(WritePDFString(AttachedFileName,
              StrToInt(Strings[LI]), 0)))) + '>' + '/EF<< /F ' +
              MakeObjRef(FileObj) + '/Type /Filespec >>>>';
            LMemoryStream := TMemoryStream.Create;
            LStream := TMemoryStream.Create;
            try
              LMemoryStream.LoadFromFile(AttachedFileName);
              LStreamSize := LMemoryStream.Size;
              if Compression.Enabled then
                LStreamSize := CompressStream(LMemoryStream, LStream,
                  Compression.Enabled, Compression.Level)
              else
              begin
                LStream.CopyFrom(LMemoryStream, 0);
                LStreamSize := LStream.Size;
              end;
              LS1 := '/Length ' + IntToStr(LStreamSize) + CRLF;
              if Compression.Enabled then
                LS1 := LS1 + '/Filter /FlateDecode' + CRLF;
              WriteObj(LS1, FileObj, False);
              LS1 := 'stream' + CRLF;
              LATemp := AnsiString(LS1);
              FOutputStream.Write(LATemp[1], Length(LS1));
              WritePDFStream(LStream, LStream.Size, FileObj, 0);
              FOutputStream.CopyFrom(LStream, 0);
            finally
              LS1 := CRLF + 'endstream' + CRLF + 'endobj' + CRLF;
              LATemp := AnsiString(LS1);
              FOutputStream.Write(LATemp[1], Length(LS1));
              LMemoryStream.Free;
              LStream.Free;
            end;
          end;
        end;
      with TgtPDFAnnot(Objects[LI]) do
      begin
        if Brush <> nil then
          Ls := Ls + GetAnnotBrushStyle(Brush.Width, Brush.Style);
        if Action <> nil then
          Ls := Ls + GetAnnotActionDictionary(Action, StrToInt(Strings[LI]));
      end;
      Ls := Ls + CRLF;
      WriteObj(Ls, StrToInt(Strings[LI]), True);
    end;
end;

function TgtExPDFEngine.GetAnnotActionDictionary(Action: TgtAnnotAction;
  ObjNo: Integer): String;
const
  ActionSubType: array [TgtAnnotActionType] of String = ('/GoTo', '/URI',
    '/Named', '/GoToR', '/Launch', '/JavaScript');
  GoToOptions: array [TgtGoToOptions] of String = ('/XYZ', '/Fit', '/FitH',
    '/FitV', '/FitR');
  NamedActions: array [TgtActionName] of String = (' /NextPage', ' /PrevPage',
    ' /FirstPage', ' /LastPage');
begin
  Result := '';
  Result := '/Type /Action' + '/S ' + ActionSubType[Action.SubType];
  if Action is TgtAnnotGoToAction then
    with TgtAnnotGoToAction(Action) do
    begin
      Rect := NativeRect(Rect);
      if (Page > 0) and (Page <= FPageList.Count) and
        (FPageList.Items[Page - 1] <> nil) then
      begin
        Result := Result + '/D [' +
          MakeObjRef(TgtPageInfo(FPageList.Items[Page - 1]).ObjNo) + ' ' +
          GoToOptions[Options] + ' ';
        case Options of
          goDefault:
            Result := Result + NumToStr(GetNativeXPos(Rect.Left)) + ' ' +
              NumToStr(GetNativeYPos(Rect.Top, Page)) + ' ' + IntToStr(Zoom);
          goFitWidth:
            Result := Result + NumToStr(GetNativeYPos(Rect.Top, Page)) + ' ';
          goFitHeight:
            Result := Result + NumToStr(GetNativeXPos(Rect.Left)) + ' ';
          goFitRect:
            Result := Result + NumToStr(GetNativeXPos(Rect.Left) *
              (CPixelsPerInch / InputXRes)) + ' ' +
              NumToStr(GetNativeYPos(Rect.Bottom, Page) *
              (CPixelsPerInch / InputYRes)) + ' ' +
              NumToStr(GetNativeXPos(Rect.Right) * (CPixelsPerInch / InputXRes))
              + ' ' + NumToStr(GetNativeYPos(Rect.Top, Page) *
              (CPixelsPerInch / InputYRes)) + ' ';
        end;
        Result := Result + ' ]';
      end
      else
      begin
        Result := '';
        Exit;
      end;
    end
  else if Action is TgtAnnotLinkAction then
    with TgtAnnotLinkAction(Action) do
    begin
      Result := Result + ' /URI <' +
        String(GetHexOfStr(AnsiString(WritePDFString(URI, ObjNo, 0)))) + '>';
    end
  else if Action is TgtAnnotNamedAction then
    with TgtAnnotNamedAction(Action) do
    begin
      Result := Result + '/N ' + NamedActions[FActionName];
    end
  else if Action is TgtAnnotRemoteGotoAction then
    with TgtAnnotRemoteGotoAction(Action) do
    begin
      Result := Result + '/F <' +
        String(GetHexOfStr(AnsiString(WritePDFString(FFilePath, ObjNo, 0)))) +
        '>' + '/D [' + MakeObjRef(TgtPageInfo(FPageList.Items[Page - 1]).ObjNo)
        + ' ' + GoToOptions[Options] + ' ';
      case Options of
        goDefault:
          Result := Result + NumToStr(GetNativeXPos(Rect.Left)) + ' ' +
            NumToStr(GetNativeYPos(Rect.Top, Page)) + ' ' + IntToStr(Zoom);
        goFitWidth:
          Result := Result + NumToStr(GetNativeYPos(Rect.Top, Page)) + ' ';
        goFitHeight:
          Result := Result + NumToStr(GetNativeXPos(Rect.Left)) + ' ';
        goFitRect:
          Result := Result + NumToStr(GetNativeXPos(Rect.Left)) + ' ' +
            NumToStr(GetNativeYPos(Rect.Bottom, Page)) + ' ' +
            NumToStr(GetNativeXPos(Rect.Right)) + ' ' +
            NumToStr(GetNativeYPos(Rect.Top, Page)) + ' ';
      end;
      if FNewWindow then
        Result := Result + ' ] /NewWindow ' + 'true'
      else
        Result := Result + ' ] /NewWindow ' + 'false';

    end
  else if Action is TgtAnnotLaunchAction then
    with TgtAnnotLaunchAction(Action) do
    begin
      Result := Result + '/F <' +
        String(GetHexOfStr(AnsiString(WritePDFString(FFilePath, ObjNo, 0)))) +
        '> /NewWindow ';
      if FNewWindow then
        Result := Result + 'true'
      else
        Result := Result + 'false';
    end
  else if Action is TgtAnnotJSAction then
    with TgtAnnotJSAction(Action) do
    begin
      Result := Result + '/JS <FEFF' +
        String(GetHexOfStrW(WritePDFString(JavaScript, ObjNo, 0))) + '>';
    end
  else
  begin
    Result := '';
    Exit;
  end;

  Result := '/A << ' + Result + ' >> ';
end;

procedure TgtExPDFEngine.WriteCustomDocInfo;
var
  LI: Integer;
  Ls, LS1: String;
  LATemp: AnsiString;
begin
  Ls := '<?xpacket begin='''' id=''W5M0MpCehiHzreSzNTczkc9d''?>' + CRLF +
    '<x:xmpmeta xmlns:x=''adobe:ns:meta/''>' + CRLF +
    '<rdf:RDF xmlns:rdf=''http://www.w3.org/1999/02/22-rdf-syntax-ns#''' + CRLF
    + 'xmlns:iX=''http://ns.adobe.com/iX/1.0/''>' + CRLF + CRLF;

  for LI := 0 to FCstDocInfoList.Count - 1 do
    with FCstDocInfoList do
    begin
      Ls := Ls + CRDFDesHeader + CRLF;
      case TgtPDFCustomDocInfo(FCstDocInfoList.Items[LI]).Schema of
        schAdobePDF:
          begin
            Ls := Ls + 'xmlns:' + CAdobePDFNamePrefix + '=' + CAdobePDFSchemaURI
              + '>' + CRLF + '<' + CAdobePDFNamePrefix + ':' +
              TgtPDFCustomDocInfo(FCstDocInfoList.Items[LI]).Name + '>' +
              TgtPDFCustomDocInfo(FCstDocInfoList.Items[LI]).Value + '</' +
              CAdobePDFNamePrefix + '>';
          end;
        schBasic:
          begin
            Ls := Ls + 'xmlns:' + CBasicNamePrefix + '=' + CBasicSchemaURI + '>'
              + CRLF + '<' + CBasicNamePrefix + ':' +
              TgtPDFCustomDocInfo(FCstDocInfoList.Items[LI]).Name + '>' +
              TgtPDFCustomDocInfo(FCstDocInfoList.Items[LI]).Value + '</' +
              CBasicNamePrefix + '>';
          end;
        schDublinCore:
          begin
            Ls := Ls + 'xmlns:' + CDublinCoreNamePrefix + '=' + CBasicSchemaURI
              + '>' + CRLF + '<' + CDublinCoreNamePrefix + ':' +
              TgtPDFCustomDocInfo(FCstDocInfoList.Items[LI]).Name + '>' +
              TgtPDFCustomDocInfo(FCstDocInfoList.Items[LI]).Value + '</' +
              CDublinCoreNamePrefix + '>';
          end;
        schJobTicket:
          begin
            Ls := Ls + 'xmlns:' + CJobTicketNamePrefix + '=' +
              CJobTicketSchemaURI + '>' + CRLF + '<' + CJobTicketNamePrefix +
              ':' + TgtPDFCustomDocInfo(FCstDocInfoList.Items[LI]).Name + '>' +
              TgtPDFCustomDocInfo(FCstDocInfoList.Items[LI]).Value + '</' +
              CJobTicketNamePrefix + '>';
          end;
        schRightsManagement:
          begin
            Ls := Ls + 'xmlns:' + CRightsManageNamePrefix + '=' +
              CRightsManageSchemaURI + '>' + CRLF + '<' +
              CRightsManageNamePrefix + ':' + TgtPDFCustomDocInfo
              (FCstDocInfoList.Items[LI]).Name + '>' +
              TgtPDFCustomDocInfo(FCstDocInfoList.Items[LI]).Value + '</' +
              CRightsManageNamePrefix + '>';
          end;
        schPagedText:
          begin
            Ls := Ls + 'xmlns:' + CPagedTextNamePrefix + '=' + CBasicSchemaURI +
              '>' + CRLF + '<' + CPagedTextNamePrefix + ':' +
              TgtPDFCustomDocInfo(FCstDocInfoList.Items[LI]).Name + '>' +
              TgtPDFCustomDocInfo(FCstDocInfoList.Items[LI]).Value + '</' +
              CPagedTextNamePrefix + '>';
          end;
      end;
      Ls := Ls + CRLF + CRDFDesTrailor + CRLF;
    end;

  Ls := Ls + '</rdf:RDF>' + CRLF + '</x:xmpmeta>' + CRLF +
    '<?xpacket end=''w''?>';

  LS1 := '/Type /Metadata' + CRLF + '/Subtype /XML' + CRLF + '/Length ' +
    IntToStr(Length(Ls)) + CRLF;
  WriteObj(LS1, FCstDocInfo, False);
  LS1 := 'stream' + CRLF;
  LATemp := AnsiString(LS1);
  FOutputStream.Write(LATemp[1], Length(LS1));
  LATemp := AnsiString(Ls);
  FOutputStream.Write(LATemp[1], Length(Ls));
  LS1 := CRLF + 'endstream' + CRLF + 'endobj' + CRLF;
  LATemp := AnsiString(LS1);
  FOutputStream.Write(LATemp[1], Length(LS1));
end;

procedure TgtExPDFEngine.AddCustomDocInfo(ACustomDocInfo: TgtPDFCustomDocInfo);
begin
  if FIsDocumentStarted = False then
  begin
    FreeAndNil(ACustomDocInfo);
    Exit;
  end;
  FCstDocInfoList.Add(ACustomDocInfo);
end;

procedure TgtExPDFEngine.SetDocEventJSAction(const Value: TgtDocEventJSAction);
begin
  FDocEventJSAction := Value;
end;

procedure TgtExPDFEngine.SignDocument(AAuther, APFXFilename, APFXPassword,
  AFieldName, AReason, ALocation, AContactInfo: WideString;
  TimeStamp: TDateTime; APageNumber: Integer; AFieldBounds: TgtRect;
  ABackgroundColor: TColor; ADisoptions: TgtSigFieldAppearenceOptions;
  AFont: TFont);
var
  LRect: TgtRect;
begin
  SigFormField := TgtPDFFormSignatureField.Create;
  with SigFormField do
  begin
    FieldName := string(AFieldName);
    BackgroundColor := ABackgroundColor;
    if (AFont <> nil) then
      Font := AFont;
    if DigitalSignature.FieldProperties.Visible <> False then
      Rect := NativeRect(AFieldBounds);
    { Converitin to user mesurments }
    if AFieldBounds.Right = Rect.Right then
    begin
      LRect.Left := Rect.Left * 96;
      LRect.Top := Rect.Top * 96;
      LRect.Right := Rect.Right * 96;
      LRect.Bottom := Rect.Bottom * 96;
      Rect := LRect;
    end;
    FPageNo := CurrentPage;
    BackgroundColor := ABackgroundColor;
    PageNo := APageNumber;
  end;
  with SigFormField.Signature do
  begin
    Author := AAuther;
    CertFileName := APFXFilename;
    CertPassword := APFXPassword;
    Reason := AReason;
    Location := ALocation;
    ContactInfo := AContactInfo;
    DateTime := TimeStamp;
    SigFieldAppearenceOptions := ADisoptions;
  end;
  SignDoc := True;
  Signature := SigFormField.Signature;
  SigFieldName := SigFormField.FieldName;
  BandType := btContent;
  with SigFormField, BandRect do
    Rect := gtRect(Left + Rect.Left, Top + Rect.Top, Left + Rect.Right,
      Top + Rect.Bottom);
  WriteSignatureField;
end;

procedure TgtExPDFEngine.SignDocument(AAuther, APFXFilename, APFXPassword,
  AFieldName, AReason, ALocation, AContactInfo: WideString;
  TimeStamp: TDateTime; AColor: TColor;
  ADisoptions: TgtSigFieldAppearenceOptions; APageNumber: Integer);
var
  LRect: TgtRect;
begin

  LRect := gtRect(0, 0, 0, 0);
  SignDocument(AAuther, APFXFilename, APFXPassword, AFieldName, AReason,
    ALocation, AContactInfo, TimeStamp, APageNumber, LRect, AColor,
    ADisoptions);
end;

procedure TgtExPDFEngine.AddPageEventAction(APageEventAction
  : TgtPageEventAction);
var
  LI: Integer;
begin
  if FIsDocumentStarted = False then
  begin
    FreeAndNil(APageEventAction);
    Exit;
  end;
  LI := FPageEventActionList.IndexOf(IntToStr(APageEventAction.PageNo));
  if (LI > -1) then
  begin
    TgtPageEventAction(FPageEventActionList.Objects[LI]).Free;
    FPageEventActionList.Delete(LI);
  end;
  FPageEventActionList.AddObject(IntToStr(APageEventAction.PageNo),
    TObject(APageEventAction));
end;

procedure TgtExPDFEngine.WriteDocEventJSAction;
var
  Ls: String;
begin
  with DocEventJSAction do
  begin
    if BeforePrint <> '' then
      Ls := Ls + '/WP << /S /JavaScript' + '/JS <' +
        String(GetHexOfStr(AnsiString(WritePDFString(BeforePrint, FDocEventJS,
        0)))) + '> >>' + CRLF;
    if AfterPrint <> '' then
      Ls := Ls + '/DP << /S /JavaScript' + '/JS <' +
        String(GetHexOfStr(AnsiString(WritePDFString(AfterPrint, FDocEventJS, 0)
        ))) + '> >>' + CRLF;
    if BeforeSave <> '' then
      Ls := Ls + '/WS << /S /JavaScript' + '/JS <' +
        String(GetHexOfStr(AnsiString(WritePDFString(BeforeSave, FDocEventJS, 0)
        ))) + '> >>' + CRLF;
    if AfterSave <> '' then
      Ls := Ls + '/DS << /S /JavaScript' + '/JS <' +
        String(GetHexOfStr(AnsiString(WritePDFString(AfterSave, FDocEventJS, 0))
        )) + '> >>' + CRLF;
    if BeforeClose <> '' then
      Ls := Ls + '/WC << /S /JavaScript' + '/JS <' +
        String(GetHexOfStr(AnsiString(WritePDFString(BeforeClose, FDocEventJS,
        0)))) + '> >>' + CRLF;
  end;
  WriteObj(Ls, FDocEventJS, True);
end;

{$IFDEF gtPro}

function TgtExPDFEngine.GetBitmapAsCCITTStream(ABitmap: TBitmap;
  AFormat: TgtOutputImageFormat): TMemoryStream;
var
  LI, LJ: Integer;
  LByteArray: PByteArray;
  WhiteCount, BlackCount, LSixtyFours: Integer;
  ResCode: String;
  LA0, LA1, LA2, LB1, LB2: Integer;
  CountA, CountB: Integer;
  Cl, Rl: array of Integer;
  LColor: Integer;
const
  CWhiteCodes: array [0 .. 63] of String = ('00110101', '000111', '0111',
    '1000', '1011', '1100', '1110', '1111', '10011', '10100', '00111', '01000',
    '001000', '000011', '110100', '110101', '101010', '101011', '0100111',
    '0001100', '0001000', '0010111', '0000011', '0000100', '0101000', '0101011',
    '0010011', '0100100', '0011000', '00000010', '00000011', '00011010',
    '00011011', '00010010', '00010011', '00010100', '00010101', '00010110',
    '00010111', '00101000', '00101001', '00101010', '00101011', '00101100',
    '00101101', '00000100', '00000101', '00001010', '00001011', '01010010',
    '01010011', '01010100', '01010101', '00100100', '00100101', '01011000',
    '01011001', '01011010', '01011011', '01001010', '01001011', '00110010',
    '00110011', '00110100');
  CBlackCodes: array [0 .. 63] of String = ('0000110111', '010', '11', '10',
    '011', '0011', '0010', '00011', '000101', '000100', '0000100', '0000101',
    '0000111', '00000100', '00000111', '000011000', '0000010111', '0000011000',
    '0000001000', '00001100111', '00001101000', '00001101100', '00000110111',
    '00000101000', '00000010111', '00000011000', '000011001010', '000011001011',
    '000011001100', '000011001101', '000001101000', '000001101001',
    '000001101010', '000001101011', '000011010010', '000011010011',
    '000011010100', '000011010101', '000011010110', '000011010111',
    '000001101100', '000001101101', '000011011010', '000011011011',
    '000001010100', '000001010101', '000001010110', '000001010111',
    '000001100100', '000001100101', '000001010010', '000001010011',
    '000000100100', '000000110111', '000000111000', '000000100111',
    '000000101000', '000001011000', '000001011001', '000000101011',
    '000000101100', '000001011010', '000001100110', '000001100111');
  CWhiteMakeUpCodes: array [0 .. 39] of String = ('11011', '10010', '010111',
    '0110111', '00110110', '00110111', '01100100', '01100101', '01101000',
    '01100111', '011001100', '011001101', '011010010', '011010011', '011010100',
    '011010101', '011010110', '011010111', '011011000', '011011001',
    '011011010', '011011011', '010011000', '010011001', '010011010', '011000',
    '010011011', '00000001000', '00000001100', '00000001101', '000000010010',
    '000000010011', '000000010100', '000000010101', '000000010110',
    '000000010111', '000000011100', '000000011101', '000000011110',
    '000000011111');
  CBlackMakeUpCodes: array [0 .. 39] of String = ('0000001111', '000011001000',
    '000011001001', '000001011011', '000000110011', '000000110100',
    '000000110101', '0000001101100', '0000001101101', '0000001001010',
    '0000001001011', '0000001001100', '0000001001101', '0000001110010',
    '0000001110011', '0000001110100', '0000001110101', '0000001110110',
    '0000001110111', '0000001010010', '0000001010011', '0000001010100',
    '0000001010101', '0000001011010', '0000001011011', '0000001100100',
    '0000001100101', '00000001000', '00000001100', '00000001101',
    '000000010010', '000000010011', '000000010100', '000000010101',
    '000000010110', '000000010111', '000000011100', '000000011101',
    '000000011110', '000000011111');
  procedure WriteByte(var AResCode: String; AImgStream: TMemoryStream);
  var
    LByte: Byte;
    LI: Integer;
  begin
    LByte := 0;
    for LI := 1 to 8 do
    begin
      LByte := (LByte shl 1) or StrToInt(AResCode[LI]);
    end;
    AImgStream.Write(LByte, 1);
  end;

  procedure GetChgColPos(AByteArray: PByteArray; var AArr: array of Integer);
  var
    LInt, LJ1: Integer;
  begin
    LColor := 255;

    if (AByteArray[0] = 255) then
      AArr[0] := -10;
    if (AByteArray[0] = 0) then
      AArr[0] := -20;
    LJ1 := 1;

    for LInt := 0 to ABitmap.Width - 1 do
    begin
      if AByteArray[LInt] <> LColor then
      begin
        AArr[LJ1] := LInt + 1;
        Inc(LJ1);
        LColor := AByteArray[LInt];
      end;
    end;
    AArr[LJ1] := ABitmap.Width + 1;
  end;

  procedure UpdateParams;
  var
    LInt, LClr: Integer;
  begin
    LInt := 0;
    while ((Cl[LInt] <= LA0) and (Cl[LInt] <> -100)) do
      Inc(LInt);
    if ((Cl[LInt] = -10) or (Cl[LInt] = -20)) then
      Inc(LInt);
    if (Cl[LInt] = -100) then
      Dec(LInt);
    LA1 := Cl[LInt];
    LA2 := Cl[LInt + 1];

    LInt := 0;
    if (LA0 = 0) then
      LClr := 255
    else
      LClr := LByteArray[LA0 - 1];

    if (LClr = 255) then
      LInt := 1
    else if (LClr = 0) then
      LInt := 0;
    while ((Rl[LInt] <= LA0) and (Rl[LInt] <> -100)) do
      Inc(LInt, 2);
    if (Rl[LInt] = -100) then
      Dec(LInt);
    LB1 := Rl[LInt];
    LB2 := Rl[LInt + 1];
  end;

begin
  Result := TMemoryStream.Create;
  if AFormat = ifCCITT3 then
  begin
    ABitmap.PixelFormat := pf8bit;
    ResCode := '';
    WhiteCount := 0;
    BlackCount := 0;
    for LI := 0 to ABitmap.Height - 1 do
    begin
      LByteArray := ABitmap.ScanLine[LI];
      LJ := 0;
      while LJ < ABitmap.Width do
      begin
        if (LJ < ABitmap.Width) then
        begin
          While (LJ < ABitmap.Width) and (LByteArray[LJ] <> 0) do
          begin
            Inc(WhiteCount);
            Inc(LJ);
          end;
          while WhiteCount >= 2560 do
          begin
            ResCode := ResCode + '000000011111';
            Dec(WhiteCount, 2560);
          end;
          if WhiteCount > 63 then
          begin
            LSixtyFours := Floor(WhiteCount / 64);
            ResCode := ResCode + CWhiteMakeUpCodes[LSixtyFours - 1];
            WhiteCount := WhiteCount - (64 * LSixtyFours);
          end;
          ResCode := ResCode + CWhiteCodes[WhiteCount];
        end;
        WhiteCount := 0;
        while Length(ResCode) > 8 do
        begin
          WriteByte(ResCode, Result);
          ResCode := MidStr(ResCode, 9, Length(ResCode) - 8);
        end;
        if (LJ < ABitmap.Width) then
        begin
          While (LJ < ABitmap.Width) and (LByteArray[LJ] = 0) do
          begin
            Inc(BlackCount);
            Inc(LJ);
          end;
          while BlackCount >= 2560 do
          begin
            ResCode := ResCode + '000000011111';
            Dec(BlackCount, 2560);
          end;
          if BlackCount > 63 then
          begin
            LSixtyFours := Floor(BlackCount / 64);
            ResCode := ResCode + CBlackMakeUpCodes[LSixtyFours - 1];
            BlackCount := BlackCount - (64 * LSixtyFours);
          end;
          ResCode := ResCode + CBlackCodes[BlackCount];
        end;
        BlackCount := 0;
        while Length(ResCode) > 8 do
        begin
          WriteByte(ResCode, Result);
          ResCode := MidStr(ResCode, 9, Length(ResCode) - 8);
        end;
      end;
    end;
    // To Write Last Byte
    if Length(ResCode) <> 0 then
    begin
      while Length(ResCode) < 8 do
        ResCode := ResCode + '0';
    end;
    WriteByte(ResCode, Result);
  end
  else
  begin

    ABitmap.Monochrome := True;
    ABitmap.PixelFormat := pf8bit;

    SetLength(Cl, ABitmap.Width + 5);
    SetLength(Rl, ABitmap.Width + 5);
    for LJ := 0 to Length(Cl) - 1 do
    begin
      Rl[LJ] := -100;
      Cl[LJ] := -100;
    end;
    Rl[0] := -10;
    Rl[1] := ABitmap.Width + 1;

    for LI := 0 to ABitmap.Height - 1 do
    begin
      LByteArray := ABitmap.ScanLine[LI];
      GetChgColPos(LByteArray, Cl);
      LA0 := 0;
      while (True) do
      begin
        if ((LA0 = ABitmap.Width + 1) or (LA0 = -100)) then
          Break;
        UpdateParams;
        if (LB2 < LA1) and (LB2 <> -100) then
        begin
          ResCode := ResCode + '0001';
          LA0 := LB2;
        end
        else if Abs(LA1 - LB1) < 4 then
        begin
          case (LA1 - LB1) of
            0:
              ResCode := ResCode + '1';
            1:
              ResCode := ResCode + '011';
            2:
              ResCode := ResCode + '000011';
            3:
              ResCode := ResCode + '0000011';
            -1:
              ResCode := ResCode + '010';
            -2:
              ResCode := ResCode + '000010';
            -3:
              ResCode := ResCode + '0000010';
          end;
          LA0 := LA1;
        end
        else
        begin
          if (LA2 = -100) then
            LA2 := LA1;
          CountA := LA1 - LA0;
          CountB := LA2 - LA1;
          ResCode := ResCode + '001';

          if ((LA0 = 0) and (LA1 = 1)) then
          begin
            ResCode := ResCode + CWhiteCodes[0];
            while CountB >= 2560 do
            begin
              ResCode := ResCode + '000000011111';
              Dec(CountB, 2560);
            end;
            if (CountB > 63) then
            begin
              ResCode := ResCode + CBlackMakeUpCodes[Floor(CountB / 64) - 1];
              CountB := CountB - (64 * Floor(CountB / 64));
            end;
            ResCode := ResCode + CBlackCodes[CountB];
          end
          else if (LA0 <> 0) and (LByteArray[LA0 - 1] = 0) then
          begin
            while CountA >= 2560 do
            begin
              ResCode := ResCode + '000000011111';
              Dec(CountA, 2560);
            end;

            if (CountA > 63) then
            begin
              ResCode := ResCode + CBlackMakeUpCodes[Floor(CountA / 64) - 1];
              CountA := CountA - (64 * Floor(CountA / 64));
            end;
            ResCode := ResCode + CBlackCodes[Abs(CountA)];
            while CountB >= 2560 do
            begin
              ResCode := ResCode + '000000011111';
              Dec(CountB, 2560);
            end;

            if (CountB > 63) then
            begin
              ResCode := ResCode + CWhiteMakeUpCodes[Floor(CountB / 64) - 1];
              CountB := CountB - (64 * Floor(CountB / 64));
            end;
            ResCode := ResCode + CWhiteCodes[CountB];
          end
          else if (LA0 = 0) then
          begin
            while CountA >= 2560 do
            begin
              ResCode := ResCode + '000000011111';
              Dec(CountA, 2560);
            end;

            if ((CountA - 1) > 63) then
            begin
              ResCode := ResCode + CWhiteMakeUpCodes
                [Floor((CountA - 1) / 64) - 1];
              CountA := (CountA - 1) - (64 * Floor((CountA - 1) / 64)) + 1;
            end;

            ResCode := ResCode + CWhiteCodes[Abs(CountA - 1)];
            while CountB >= 2560 do
            begin
              ResCode := ResCode + '000000011111';
              Dec(CountB, 2560);
            end;

            if (CountB > 63) then
            begin
              ResCode := ResCode + CBlackMakeUpCodes[Floor(CountB / 64) - 1];
              CountB := CountB - (64 * Floor(CountB / 64));
            end;
            ResCode := ResCode + CBlackCodes[CountB];
          end
          else
          begin
            while CountA >= 2560 do
            begin
              ResCode := ResCode + '000000011111';
              Dec(CountA, 2560);
            end;

            if (CountA > 63) then
            begin
              ResCode := ResCode + CWhiteMakeUpCodes[Floor(CountA / 64) - 1];
              CountA := CountA - (64 * Floor(CountA / 64));
            end;

            ResCode := ResCode + CWhiteCodes[Abs(CountA)];

            while CountB >= 2560 do
            begin
              ResCode := ResCode + '000000011111';
              Dec(CountB, 2560);
            end;

            if (CountB > 63) then
            begin
              ResCode := ResCode + CBlackMakeUpCodes[Floor(CountB / 64) - 1];
              CountB := CountB - (64 * Floor(CountB / 64));
            end;
            ResCode := ResCode + CBlackCodes[CountB];
          end;
          LA0 := LA2;
        end;
      end;
      while Length(ResCode) > 7 do
      begin
        WriteByte(ResCode, Result);
        ResCode := MidStr(ResCode, 9, Length(ResCode) - 8);
      end;
      for LJ := 0 to Length(Cl) - 1 do
      begin
        Rl[LJ] := Cl[LJ];
        Cl[LJ] := -100;
      end;
    end; // end of for loop

    ResCode := ResCode + '000000000001000000000001';

    while Length(ResCode) > 7 do
    begin
      WriteByte(ResCode, Result);
      ResCode := MidStr(ResCode, 9, Length(ResCode) - 8);
    end;

    // write last bit
    if Length(ResCode) <> 0 then
    begin
      while Length(ResCode) < 8 do
        ResCode := ResCode + '0';
      WriteByte(ResCode, Result);
      ResCode := MidStr(ResCode, 9, Length(ResCode) - 8);
    end;
    Result.Position := 0;
  end;
end;
{$ENDIF}
{ TgtPDFFormField }

constructor TgtPDFFormField.Create;
begin
  FPageNo := 0;
  FFontIndex := -1;
  FVisible := True;
  FBorderColor := clBlack;
  FBackgroundColor := clWhite;
  FFont := TFont.Create;
end;

destructor TgtPDFFormField.Destroy;
begin
  FreeAndNil(FFont);
  inherited;
end;

procedure TgtPDFFormField.SetAltFeildName(const Value: String);
begin
  FAltFeildName := Value;
end;

procedure TgtPDFFormField.SetBackgroundColor(const Value: TColor);
begin
  FBackgroundColor := Value;
end;

procedure TgtPDFFormField.SetBorderColor(const Value: TColor);
begin
  FBorderColor := Value;
end;

procedure TgtPDFFormField.SetDefaultValue(const Value: String);
begin
  FDefaultValue := Value;
end;

procedure TgtPDFFormField.SetFieldName(const Value: String);
begin
  FFieldName := Value;
end;

procedure TgtPDFFormField.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
end;

procedure TgtPDFFormField.SetPreferences(const Value: TgtAcroFieldPreferences);
begin
  FPreferences := Value;
end;

procedure TgtPDFFormField.SetRect(Value: TgtRect);
begin
  FRect := Value;
end;

{
  (* To be Implemented *)
  procedure TgtPDFFormField.SetRotation(
  const Value: TgtAcroFieldRotationAngle);
  begin
  FRotation := Value;
  end;
}

procedure TgtPDFFormField.SetValue(const Value: String);
begin
  FValue := Value;
end;

procedure TgtPDFFormField.SetVisible(const Value: Boolean);
begin
  FVisible := Value;
end;

{ TgtAcroIconAttribute }

constructor TgtAcroIconAttribute.Create;
begin
  FScale := aisAlways;
  FScaleType := aistAspectRatio;
  FLeftSpace := 0;
  FBottomSpace := 0;
end;

destructor TgtAcroIconAttribute.Destroy;
begin

  inherited;
end;

procedure TgtAcroIconAttribute.SetBottomSpace(const Value: Double);
begin
  FBottomSpace := Value;
end;

procedure TgtAcroIconAttribute.SetLeftSpace(const Value: Double);
begin
  FLeftSpace := Value;
end;

procedure TgtAcroIconAttribute.SetScale(const Value: TgtAcroIconScale);
begin
  FScale := Value;
end;

procedure TgtAcroIconAttribute.SetScaleType(const Value: TgtAcroIconScaleType);
begin
  FScaleType := Value;
end;

{ TgtPDFFormPushButton }

constructor TgtPDFFormPushButton.Create;
begin
  inherited;
  FNormalCaption := 'Button';
  FRolloverCaption := 'Button';
  FDownCaption := 'Button';
  {
    (* To be Implemented *)
    FNormalIcon := nil;
    FRolloverIcon := nil;
    FDownIcon := nil;
    FPositionCaption := apbpCaption;
    FIconAttribute := TgtAcroIconAttribute.Create;
  }
  FAction := pbaNone;
  FJavaScript := '';
  FSubmitURL := '';
  FFormSubmitFormat := fsfHTML;
end;

destructor TgtPDFFormPushButton.Destroy;
begin
  {
    (* To be Implemented *)
    FreeAndNil(FNormalIcon);
    FreeAndNil(FRolloverIcon);
    FreeAndNil(FDownIcon);
    FreeAndNil(FIconAttribute);
  }
  inherited;
end;

procedure TgtPDFFormPushButton.SetAction(const Value: TgtPushButtonAction);
begin
  FAction := Value;
end;

procedure TgtPDFFormPushButton.SetDownCaption(const Value: String);
begin
  FDownCaption := Value;
end;

{
  (* To be Implemented *)
  procedure TgtPDFFormPushButton.SetDownIcon(const Value: TGraphic);
  begin
  FDownIcon := Value;
  end;

  procedure TgtPDFFormPushButton.SetIconAttribute(
  const Value: TgtAcroIconAttribute);
  begin
  FIconAttribute := Value;
  end;
}

procedure TgtPDFFormPushButton.SetFormSubmitFormat
  (const Value: TgtFormSubmitFormat);
begin
  FFormSubmitFormat := Value;
end;

procedure TgtPDFFormPushButton.SetJavaScript(const Value: String);
begin
  FJavaScript := Value;
end;

procedure TgtPDFFormPushButton.SetNormalCaption(const Value: String);
begin
  FNormalCaption := Value;
end;

{
  (* To be Implemented *)
  procedure TgtPDFFormPushButton.SetNormalIcon(const Value: TGraphic);
  begin
  FNormalIcon := Value;
  end;

  procedure TgtPDFFormPushButton.SetPositionCaption(
  const Value: TgtAcroPushButtonPosition);
  begin
  FPositionCaption := Value;
  end;
}

procedure TgtPDFFormPushButton.SetRolloverCaption(const Value: String);
begin
  FRolloverCaption := Value;
end;

{
  (* To be Implemented *)
  procedure TgtPDFFormPushButton.SetRolloverIcon(const Value: TGraphic);
  begin
  FRolloverIcon := Value;
  end;
}

procedure TgtPDFFormPushButton.SetSubmitURL(const Value: String);
begin
  FSubmitURL := Value;
end;

{ TgtPDFFormCheckBox }

constructor TgtPDFFormCheckBox.Create;
begin
  inherited;
  {
    (* To be Implemented *)
    FCaption := '';
  }
  FSymbol := pfcsCheck;
  FChecked := False;
end;

destructor TgtPDFFormCheckBox.Destroy;
begin

  inherited;
end;

{
  (* To be Implemented *)
  procedure TgtPDFFormCheckBox.SetCaption(const Value: String);
  begin
  FCaption := Value;
  end;
}

procedure TgtPDFFormCheckBox.SetChecked(const Value: Boolean);
begin
  FChecked := Value;
end;

procedure TgtPDFFormCheckBox.SetSymbol(const Value: TgtPDFFormCheckboxSymbol);
begin
  FSymbol := Value;
end;

{ TgtPDFFormRadioButton }

function TgtPDFFormRadioButton.AddItem(RadioItem: TgtPDFFormRadioItem): Integer;
begin
  RadioItem.FPageNo := FPageNo;
  if RadioItem.Value = '' then
    RadioItem.Value := 'RadioItem' + IntToStr(FItems.Count);
  Result := FItems.AddObject('', RadioItem);
end;

constructor TgtPDFFormRadioButton.Create;
begin
  inherited;
  FItems := TStringList.Create;
  FSelectedItemIndex := -1;
  FSymbol := pfcsCheck;
  FAtleastOneSelectedItem := False;
end;

destructor TgtPDFFormRadioButton.Destroy;
var
  I: Integer;
begin
  for I := 0 to FItems.Count - 1 do
    TgtPDFFormRadioItem(FItems.Objects[I]).Free;
  FreeAndNil(FItems);
  inherited;
end;

procedure TgtPDFFormRadioButton.SetAtleastOneSelectedItem(const Value: Boolean);
begin
  FAtleastOneSelectedItem := Value;
end;

{
  (* To be Implemented *)
  procedure TgtPDFFormRadioButton.SetCaption(const Value: String);
  begin
  FCaption := Value;
  end;
}

procedure TgtPDFFormRadioButton.SetSelectedItemIndex(const Value: Integer);
begin
  FSelectedItemIndex := Value;
end;

procedure TgtPDFFormRadioButton.SetSymbol(const Value
  : TgtPDFFormCheckboxSymbol);
begin
  FSymbol := Value;
end;

{ TgtPDFFormRadioItem }

constructor TgtPDFFormRadioItem.Create;
begin
  inherited;
end;

destructor TgtPDFFormRadioItem.Destroy;
begin

  inherited;
end;

{ TgtPDFFormTextField }

constructor TgtPDFFormTextField.Create;
begin
  inherited;
  FIsMultiline := False;
  FIsPassword := False;
  FIsFileSelect := False;
  FIsDoNotSpellCheck := False;
  FIsDoNotScroll := False;
  FMaxLength := -1;
  FIsBorder := True;
  FHAlignment := taLeft;
end;

destructor TgtPDFFormTextField.Destroy;
begin

  inherited;
end;

procedure TgtPDFFormTextField.SetHAlignment(const Value: TgtAlign);
begin
  FHAlignment := Value;
end;

procedure TgtPDFFormTextField.SetIsBorder(const Value: Boolean);
begin
  FIsBorder := Value
end;

procedure TgtPDFFormTextField.SetIsDoNotScroll(const Value: Boolean);
begin
  FIsDoNotScroll := Value;
end;

procedure TgtPDFFormTextField.SetIsDoNotSpellCheck(const Value: Boolean);
begin
  FIsDoNotSpellCheck := Value;
end;

procedure TgtPDFFormTextField.SetIsFileSelect(const Value: Boolean);
begin
  FIsFileSelect := Value;
end;

procedure TgtPDFFormTextField.SetIsMultiline(const Value: Boolean);
begin
  FIsMultiline := Value;
end;

procedure TgtPDFFormTextField.SetIsPassword(const Value: Boolean);
begin
  FIsPassword := Value;
end;

procedure TgtPDFFormTextField.SetMaxLength(const Value: Integer);
begin
  FMaxLength := Value;
end;

{ TgtPDFFormComboBox }

function TgtPDFFormComboBox.AddItem(Item: String): Integer;
begin
  SetLength(FItems, (Length(FItems) + 1));
  FItems[Length(FItems) - 1] := Item;
  Result := Length(FItems) - 1;
end;

constructor TgtPDFFormComboBox.Create;
begin
  inherited;
  FIsEditable := False;
  FIsSortList := False;
  FSelectedItemIndex := -1;
  SetLength(FItems, 0);
end;

destructor TgtPDFFormComboBox.Destroy;
begin
  SetLength(FItems, 0);
  inherited;
end;

procedure TgtPDFFormComboBox.SetIsEditable(const Value: Boolean);
begin
  FIsEditable := Value;
end;

procedure TgtPDFFormComboBox.SetIsSortList(const Value: Boolean);
begin
  FIsSortList := Value;
end;

procedure TgtPDFFormComboBox.SetSelectedItemIndex(const Value: Integer);
begin
  FSelectedItemIndex := Value;
end;

{ TgtPDFFormListBox }

function TgtPDFFormListBox.AddItem(Item: String): Integer;
begin
  SetLength(FItems, (Length(FItems) + 1));
  FItems[Length(FItems) - 1] := Item;
  Result := Length(FItems) - 1;
end;

constructor TgtPDFFormListBox.Create;
begin
  inherited;
  {
    (* To be Implemented *)
    FTopIndex := -1;
  }
  FIsSortList := False;
  FIsMultiSelect := False;
  SetLength(FItems, 0);
end;

destructor TgtPDFFormListBox.Destroy;
begin
  SetLength(FItems, 0);
  inherited;
end;

procedure TgtPDFFormListBox.SetIsMultiSelect(const Value: Boolean);
begin
  FIsMultiSelect := Value;
end;

procedure TgtPDFFormListBox.SetIsSortList(const Value: Boolean);
begin
  FIsSortList := Value;
end;

{
  (* To be Implemented *)
  procedure TgtPDFFormListBox.SetTopIndex(const Value: Integer);
  begin
  FTopIndex := Value;
  end;
}

{ TgtPDFTextAnnot }

constructor TgtPDFTextAnnot.Create;
begin
  inherited;
  FContents := '';
  FName := tnNote;
  FOpen := False;
end;

destructor TgtPDFTextAnnot.Destroy;
begin

  inherited;
end;

procedure TgtPDFTextAnnot.SetName(const Value: TgtTextNote);
begin
  FName := Value;
end;

procedure TgtPDFTextAnnot.SetOpen(const Value: Boolean);
begin
  FOpen := Value;
end;

{ TgtPDFAnnot }

constructor TgtPDFAnnot.Create;
begin
  inherited;
  FBrush := nil;
  FAction := nil;
  FPageNo := 0;
end;

destructor TgtPDFAnnot.Destroy;
begin
  FreeAndNil(FBrush);
  FreeAndNil(FAction);
  inherited;
end;

procedure TgtPDFAnnot.SetAction(const Value: TgtAnnotAction);
begin
  FAction := Value;
end;

procedure TgtPDFAnnot.SetBackgroundColor(const Value: TColor);
begin
  FBackgroundColor := Value;
end;

procedure TgtPDFAnnot.SetBorderColor(const Value: TColor);
begin
  FBorderColor := Value;
end;

procedure TgtPDFAnnot.SetBrush(const Value: TgtAnnotBrush);
begin
  FBrush := Value;
end;

procedure TgtPDFAnnot.SetContents(const Value: WideString);
begin
  FContents := Value;
end;

procedure TgtPDFAnnot.SetRect(const Value: TgtRect);
begin
  FRect := Value;
end;

{ TgtAnnotBrush }

constructor TgtAnnotBrush.Create;
begin
  inherited;
  FStyle := absSolid;
  FWidth := 1;
end;

destructor TgtAnnotBrush.Destroy;
begin

  inherited;
end;

procedure TgtAnnotBrush.SetStyle(const Value: TgtAnnotBrushStyle);
begin
  FStyle := Value;
end;

procedure TgtAnnotBrush.SetWidth(const Value: Integer);
begin
  if Value >= 1 then
    FWidth := Value;
end;

{ TgtAnnotAction }

constructor TgtAnnotAction.Create;
begin
  FSubType := aaGoTo;
end;

destructor TgtAnnotAction.Destroy;
begin

  inherited;
end;

{ TgtAnnotGoToAction }

constructor TgtAnnotGoToAction.Create;
begin
  inherited;
  FSubType := aaGoTo;
  FZoom := 1;
  FOptions := goDefault;
  FRect := gtRect(0, 0, 0, 0);
end;

destructor TgtAnnotGoToAction.Destroy;
begin

  inherited;
end;

procedure TgtAnnotGoToAction.SetOptions(const Value: TgtGoToOptions);
begin
  FOptions := Value;
end;

procedure TgtAnnotGoToAction.SetPage(const Value: Integer);
begin
  if Value > 0 then
    FPage := Value;
end;

procedure TgtAnnotGoToAction.SetRect(const Value: TgtRect);
begin
  FRect := Value;
end;

procedure TgtAnnotGoToAction.SetZoom(const Value: TgtZoom);
begin
  if Value >= 0 then
    FZoom := Value;
end;

{ TgtAnnotLinkAction }

constructor TgtAnnotLinkAction.Create;
begin
  inherited;
  FSubType := aaURI;
  FURI := '';
end;

destructor TgtAnnotLinkAction.Destroy;
begin

  inherited;
end;

procedure TgtAnnotLinkAction.SetURI(const Value: String);
begin
  FURI := Value;
end;

{ TgtPDFLinkAnnot }

constructor TgtPDFLinkAnnot.Create;
begin
  inherited;
  FHighlightMode := hmNone;
  FBorderWidth := 0;
end;

destructor TgtPDFLinkAnnot.Destroy;
begin
  inherited;
end;

procedure TgtPDFLinkAnnot.SetBorderWidth(const Value: Byte);
begin
  FBorderWidth := Value;
end;

procedure TgtPDFLinkAnnot.SetHighlightMode(const Value: TgtAnnotHighlightMode);
begin
  FHighlightMode := Value;
end;

{ TgtPDFFLineAnnot }

constructor TgtPDFLineAnnot.Create;
begin
  inherited;
  FBorderWidth := 0;
  FBorderColor := clBlack;
end;

destructor TgtPDFLineAnnot.Destroy;
begin
  inherited;
end;

function TgtPDFLineAnnot.gtLine(Left, Top, Right, Bottom: Double): TgtLine;
begin
  Result.Left := Left;
  Result.Top := Top;
  Result.Right := Right;
  Result.Bottom := Bottom;
end;

procedure TgtPDFLineAnnot.SetBorderPattern(const Value: String);
begin
  FBorderPattern := Value;
end;

procedure TgtPDFLineAnnot.SetBorderStyle(const Value: TgtBorderStyle);
begin
  FBorderStyle := Value;
end;

procedure TgtPDFLineAnnot.SetBorderWidth(const Value: Byte);
begin
  FBorderWidth := Value;
end;

procedure TgtPDFLineAnnot.SetEndStyle(const Value: TgtLineStyle);
begin
  FEndStyle := Value;
end;

procedure TgtPDFLineAnnot.SetLine(const Value: TgtLine);
begin
  FLine := Value;
end;

procedure TgtPDFLineAnnot.SetStartStyle(const Value: TgtLineStyle);
begin
  FStartStyle := Value;
end;

procedure TgtPDFLineAnnot.SetInteriorColor(const Value: TColor);
begin
  FInteriorColor := Value;
end;

{ TgtPDFSquareAnnot }

constructor TgtPDFSquareAnnot.Create;
begin
  inherited;
  FInteriorColor := clWhite;
end;

destructor TgtPDFSquareAnnot.Destroy;
begin
  inherited;
end;

procedure TgtPDFSquareAnnot.SetBorderPattern(const Value: String);
begin
  FBorderPattern := Value;
end;

procedure TgtPDFSquareAnnot.SetBorderStyle(const Value: TgtBorderStyle);
begin
  FBorderStyle := Value;
end;

procedure TgtPDFSquareAnnot.SetBorderWidth(const Value: Byte);
begin
  FBorderWidth := Value;
end;

procedure TgtPDFSquareAnnot.SetCloudy(const Value: Boolean);
begin
  FCloudy := Value;
end;

procedure TgtPDFSquareAnnot.SetDifferRect(const Value: TgtRect);
begin
  FDifferRect := Value;
end;

procedure TgtPDFSquareAnnot.SetCloudIntensity(const Value: TgtIntensity);
begin
  FCloudIntensity := Value;
end;

procedure TgtPDFSquareAnnot.SetInteriorColor(const Value: TColor);
begin
  FInteriorColor := Value;
end;

{ TgtPDFCircleAnnot }

constructor TgtPDFCircleAnnot.Create;
begin
  inherited;
  FInteriorColor := clWhite;
end;

destructor TgtPDFCircleAnnot.Destroy;
begin
  inherited;
end;

procedure TgtPDFCircleAnnot.SetBorderPattern(const Value: String);
begin
  FBorderPattern := Value;
end;

procedure TgtPDFCircleAnnot.SetBorderStyle(const Value: TgtBorderStyle);
begin
  FBorderStyle := Value;
end;

procedure TgtPDFCircleAnnot.SetBorderWidth(const Value: Byte);
begin
  FBorderWidth := Value;
end;

procedure TgtPDFCircleAnnot.SetCloudIntensity(const Value: TgtIntensity);
begin
  FCloudIntensity := Value;
end;

procedure TgtPDFCircleAnnot.SetCloudy(const Value: Boolean);
begin
  FCloudy := Value;
end;

procedure TgtPDFCircleAnnot.SetDifferRect(const Value: TgtRect);
begin
  FDifferRect := Value;
end;

procedure TgtPDFCircleAnnot.SetInteriorColor(const Value: TColor);
begin
  FInteriorColor := Value;
end;

{ TgtPDFPolygonAnnot }

constructor TgtPDFPolygonAnnot.Create;
begin
  inherited;
  FInteriorColor := clWhite;
end;

destructor TgtPDFPolygonAnnot.Destroy;
begin
  inherited;
end;

function TgtPDFPolygonAnnot.GetVertices: TgtPoints;
begin
  Result := FVertices;
end;

procedure TgtPDFPolygonAnnot.SetBorderPattern(const Value: String);
begin
  FBorderPattern := Value;
end;

procedure TgtPDFPolygonAnnot.SetBorderStyle(const Value: TgtBorderStyle);
begin
  FBorderStyle := Value;
end;

procedure TgtPDFPolygonAnnot.SetBorderWidth(const Value: Byte);
begin
  FBorderWidth := Value;
end;

procedure TgtPDFPolygonAnnot.SetCloudIntensity(const Value: TgtIntensity);
begin
  FCloudIntensity := Value;
end;

procedure TgtPDFPolygonAnnot.SetCloudy(const Value: Boolean);
begin
  FCloudy := Value;
end;

procedure TgtPDFPolygonAnnot.SetInteriorColor(const Value: TColor);
begin
  FInteriorColor := Value;
end;

procedure TgtPDFPolygonAnnot.SetVertices(const Vertices: array of TgtPoint);
var
  NoPoints: Integer;
begin
  NoPoints := SizeOf(Vertices) div SizeOf(TgtPoint);
  SetLength(FVertices, NoPoints);
  CopyMemory(FVertices, @Vertices, SizeOf(Vertices));
end;

{ TgtPDFPolylineAnnot }

constructor TgtPDFPolylineAnnot.Create;
begin
  inherited;
  FInteriorColor := clWhite;
end;

destructor TgtPDFPolylineAnnot.Destroy;
begin
  inherited;
end;

procedure TgtPDFPolylineAnnot.SetBorderPattern(const Value: String);
begin
  FBorderPattern := Value;
end;

procedure TgtPDFPolylineAnnot.SetBorderStyle(const Value: TgtBorderStyle);
begin
  FBorderStyle := Value;
end;

procedure TgtPDFPolylineAnnot.SetBorderWidth(const Value: Byte);
begin
  FBorderWidth := Value;
end;

procedure TgtPDFPolylineAnnot.SetCloudIntensity(const Value: TgtIntensity);
begin
  FCloudIntensity := Value;
end;

procedure TgtPDFPolylineAnnot.SetCloudy(const Value: Boolean);
begin
  FCloudy := Value;
end;

procedure TgtPDFPolylineAnnot.SetEndStyle(const Value: TgtLineStyle);
begin
  FEndStyle := Value;
end;

procedure TgtPDFPolylineAnnot.SetInteriorColor(const Value: TColor);
begin
  FInteriorColor := Value;
end;

procedure TgtPDFPolylineAnnot.SetStartStyle(const Value: TgtLineStyle);
begin
  FStartStyle := Value;
end;

procedure TgtPDFPolylineAnnot.SetVertices(const Vertices: array of TgtPoint);
var
  NoPoints: Integer;
begin
  NoPoints := SizeOf(Vertices) div SizeOf(TgtPoint);
  SetLength(FVertices, NoPoints);
  CopyMemory(FVertices, @Vertices, SizeOf(Vertices));
end;

{ TgtPDFTextMarkupAnnot }

constructor TgtPDFTextMarkupAnnot.Create;
begin
  FTextStyle := tsHighlight;
  inherited;
end;

destructor TgtPDFTextMarkupAnnot.Destroy;
begin
  inherited;
end;

procedure TgtPDFTextMarkupAnnot.SetQuadPoints(const QuadPoints
  : array of TgtPoint);
var
  NoPoints: Integer;
begin
  NoPoints := SizeOf(QuadPoints) div SizeOf(TgtPoint);
  SetLength(FQuadPoints, NoPoints);
  CopyMemory(FQuadPoints, @QuadPoints, SizeOf(QuadPoints));
end;

procedure TgtPDFTextMarkupAnnot.SetTextStyle(const Value: TgtTextStyle);
begin
  FTextStyle := Value;
end;

{ TgtPDFCaretAnnot }

constructor TgtPDFCaretAnnot.Create;
begin
  inherited;
end;

destructor TgtPDFCaretAnnot.Destroy;
begin
  inherited;
end;

procedure TgtPDFCaretAnnot.SetDifferRect(const Value: TgtRect);
begin
  FDifferRect := Value;
end;

{ TgtPDFInkAnnot }

constructor TgtPDFInkAnnot.Create;
begin
  inherited;
end;

destructor TgtPDFInkAnnot.Destroy;
begin
  inherited;
end;

procedure TgtPDFInkAnnot.SetInkPoints(const InkPoints: array of TgtPoint);
var
  NoPoints: Integer;
begin
  NoPoints := SizeOf(InkPoints) div SizeOf(TgtPoint);
  SetLength(FInkPoints, NoPoints);
  CopyMemory(FInkPoints, @InkPoints, SizeOf(InkPoints));
end;

{ TgrAnnotNamedAction }

constructor TgtAnnotNamedAction.Create;
begin
  inherited;
  FActionName := anFirstPage;
  FSubType := aaNamed;
end;

destructor TgtAnnotNamedAction.Destroy;
begin
  inherited;
end;

procedure TgtAnnotNamedAction.SetActionName(const Value: TgtActionName);
begin
  FActionName := Value;
end;

{ TgtAnnotRemoteGotoAction }

constructor TgtAnnotRemoteGotoAction.Create;
begin
  inherited;
  FSubType := aaGoToR;
end;

destructor TgtAnnotRemoteGotoAction.Destroy;
begin
  inherited;
end;

procedure TgtAnnotRemoteGotoAction.SetFilePath(const Value: String);
begin
  FFilePath := Value;
end;

procedure TgtAnnotRemoteGotoAction.SetOptions(const Value: TgtGoToOptions);
begin
  FOptions := Value;
end;

procedure TgtAnnotRemoteGotoAction.SetPage(const Value: Integer);
begin
  if Value > 0 then
    FPage := Value;
end;

procedure TgtAnnotRemoteGotoAction.SetRect(const Value: TgtRect);
begin
  FRect := Value;
end;

procedure TgtAnnotRemoteGotoAction.SetZoom(const Value: TgtZoom);
begin
  if Value > 0 then
    FZoom := Value;
end;

{ TgtAnnotLaunchAction }

constructor TgtAnnotLaunchAction.Create;
begin
  inherited;
  FSubType := aaLaunch;
end;

destructor TgtAnnotLaunchAction.Destroy;
begin
  inherited;
end;

procedure TgtAnnotLaunchAction.SetFilePath(const Value: String);
begin
  FFilePath := Value;
end;

{ TgtPDFFreeTextAnnot }

constructor TgtPDFFreeTextAnnot.Create;
begin
  FTextFont := TFont.Create;
  inherited;
end;

destructor TgtPDFFreeTextAnnot.Destroy;
begin
  FTextFont.Free;
  inherited;
end;

procedure TgtPDFFreeTextAnnot.SetTextAlign(const Value: TgtAlign);
begin
  FTextAlign := Value;
end;

procedure TgtPDFFreeTextAnnot.SetTextColor(const Value: TColor);
begin
  FTextColor := Value;
end;

procedure TgtPDFFreeTextAnnot.SetTextFont(const Value: TFont);
begin
  FTextFont := Value;
  // FTextFont.Assign(Value);
end;

{ TgtAnnotJSAction }

constructor TgtAnnotJSAction.Create;
begin
  inherited;
  FSubType := aaJavaScript;
end;

destructor TgtAnnotJSAction.Destroy;
begin
  inherited;
end;

procedure TgtAnnotJSAction.SetJavaScript(const Value: String);
begin
  FJavaScript := Value;
end;

{ TgtPDFStampAnnot }

constructor TgtPDFStampAnnot.Create;
begin
  inherited;
  FStampType := stDraft;
end;

destructor TgtPDFStampAnnot.Destroy;
begin
  inherited;
end;

procedure TgtPDFStampAnnot.SetStampType(const Value: TgtStampType);
begin
  FStampType := Value;
end;

{ TgtPDFFileAttachmentAnnot }

constructor TgtPDFFileAttachmentAnnot.Create;
begin
  FFileAttachmentIcon := faPaperclip;
end;

destructor TgtPDFFileAttachmentAnnot.Destroy;
begin
  inherited;
end;

procedure TgtPDFFileAttachmentAnnot.SetAttachedFileName(const Value: String);
var
  Ls: String;
begin
  Ls := StringReplace(Value, ':\', '/', [rfIgnoreCase]);
  Ls := StringReplace(Ls, '\', '/', [rfReplaceAll]);
  if (pos('/', Ls) <> 0) and (pos('..', Ls) = 0) then
    Ls := '/' + Ls;
  FAttachedFileName := Value;
end;

{ TgtPDFCustomDocInfo }

constructor TgtPDFCustomDocInfo.Create;
begin
  FName := '';
  FValue := '';
  FURI := CAdobePDFSchemaURI;
  FSchema := schAdobePDF;
end;

destructor TgtPDFCustomDocInfo.Destroy;
begin
  inherited Destroy;
end;

{ TgtDocEventJSAction }

constructor TgtDocEventJSAction.Create;
begin
  BeforeClose := '';
  BeforeSave := '';
  BeforePrint := '';
  AfterSave := '';
  AfterPrint := '';
end;

destructor TgtDocEventJSAction.Destroy;
begin

  inherited;
end;

procedure TgtDocEventJSAction.SetAfterPrint(const Value: String);
begin
  FAfterPrint := Value;
end;

procedure TgtDocEventJSAction.SetAfterSave(const Value: String);
begin
  FAfterSave := Value;
end;

procedure TgtDocEventJSAction.SetBeforePrint(const Value: String);
begin
  FBeforePrint := Value;
end;

procedure TgtDocEventJSAction.SetBeforeSave(const Value: String);
begin
  FBeforeSave := Value;
end;

procedure TgtDocEventJSAction.SetBeforeClose(const Value: String);
begin
  FBeforeClose := Value;
end;

{ TgtPageEventAction }

constructor TgtPageEventAction.Create;
begin
  PageNo := -1;
  OpenAction := nil;
  CloseAction := nil;
end;

destructor TgtPageEventAction.Destroy;
begin
  if OpenAction <> nil then
    OpenAction.Free;
  if CloseAction <> nil then
    CloseAction.Free;
  inherited;
end;

procedure TgtPageEventAction.SetCloseAction(const Value: TgtAnnotAction);
begin
  FCloseAction := Value;
end;

procedure TgtPageEventAction.SetOpenAction(const Value: TgtAnnotAction);
begin
  FOpenAction := Value;
end;

procedure TgtPageEventAction.SetPageNo(const Value: Integer);
begin
  FPageNo := Value;
end;

{ TgtPDFFormSignatureField }

constructor TgtPDFFormSignatureField.Create;
begin
  inherited;
  Enable := False;
  Signature := TgtSignature.Create;
end;

destructor TgtPDFFormSignatureField.Destroy;
begin
  FSignature.Free;
  inherited;
end;

end.
