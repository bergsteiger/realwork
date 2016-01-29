{ ********************************************************************* }
{                                                                       }
{                       Gnostice PDFtoolkit v3.0                        }
{                       Copyright (c) 2002-2009                         }
{          Gnostice Information Technologies Private Limited            }
{                       http://www.gnostice.com                         }
{                                                                       }
{ ********************************************************************* }
{$I gtDefines.inc}

unit gtExPDFDoc;

interface

uses
  Classes, Graphics, Windows, FontProcessor, gtPDFUtils, PDTypes, gtCstPDFDoc,
  PDFormField, gtPDFResStrs, Contnrs, PDAction, PDAnnot, PDRadioItem, PDFont,
  gtWidestrings;

type
{ Forward Declarations }

  TgtExPDFDocument = class;

  {Event}
  TgtChangeAttachmentNameEvent = procedure(Sender: TgtCustomPDFDocument; const AFileName: string;
    var ANewFileName: string) of object;

  // enum for different Trigger Types in Form Fields
  TgtAcroFieldPreferencesType = (afpReadOnly, afpRequired, afpNoExport);

  TgtAcroFieldPreferences = set of TgtAcroFieldPreferencesType;

  TgtAdditionalPreferencesType = (afpInvisible, afpHidden, afpPrint, afpNoPrint,
    afpNoZoom, afpNoRotate, afpNoView, afpReadOnlyAnnots, afpLocked, afpToggleNoView);

  TgtAdditionalPreferences = set of TgtAdditionalPreferencesType;

  TgtPushButtonAction = (pbaNone, pbaSubmit, pbaReset, pbaJavaScript);

  TgtPDFFormCheckboxSymbol = (pfcsCheck, pfcsCircle, pfcsCross, pfcsDiamond,
    pfcsSquare, pfcsStar);

  //enum for Annotation Border Style
  TgtAnnotBorderStyle = (bsSolid, bsDashed, bsBeveled, bsInset, bsUnderline);

  // enum for different Trigger Types in Form Fields
  TgtFormFieldActionTriggers = (fftOnEnter, fftOnExit, fftMouseDown,
    fftMouseUp, fftGotFocus, fftLostFocus, fftOnKeyPress,
    fftFormat, fftValidate, fftCalculate);

  TgtPDFFormFieldOrientation = (ffo0, ffo90, ffo180, ffo270);

  TgtCustomInfoSchema = (scAdobePDF,
    scBasic,
    scDublinCore,
    scJobTicket,
    scRightsManagement,
    scPagedText
    );

  TgtDocActionTriggers = (aatBeforeDocClose,
    aatBeforeDocSave,
    aatAfterDocSave,
    aatBeforeDocPrint,
    aatAfterDocPrint);

  TgtFormSubmitFormat = (fsfHTML, fsfFDF, fsfXML);

  //Enum for Aditional Actions Trigger Types.
  TgtPageActionTriggers = (aatBeforePageOpen, aatAfterPageClose);

  TgtFileAttachmentIcon = (faGraph, faPaperclip, faPushPin, faTag);

  TgtPDAnnotType = (annotText, annotLink, annotFreeText, annotLine,
    annotSquare, annotCircle, annotPolygon, annotPolyLine, annotHighlight,
    annotUnderline, annotSquiggly, annotStrikeOut, annotStamp, annotCaret,
    annotInk, annotPopup, annotFileAttachment, annotSound, annotMovie, annotWidget,
    annotScreen, annotPrinterMark, annotTrapNet, annotWatermark, annot3D);

  // enum for different highlight style in link annotation
  TgtLinkHighlightType = (laInvert, laOutline, laPush, laNoHighLight);

  //enum for different markup annotation
  TgtMarkUpType = (maHighlight, maUnderline, maSquiggly, maStrikeOut);

  TgtLineStyle = (laSquare, laCircle, laDiamond, laOpenArrow, laClosedArrow, laNone);

  //enum for caret annotation symbol
  TgtCaretSymbol = (caParagraph, caNoSymbol);

  TgtFreeTextAllignment = (ftaLeftJustified, ftaCentered, ftaRightJustified);

    //enum for annotation flags
  TgtAnnotationFlag = (annotInvisible, annotHidden, annotPrint,
    annotNoZoom, annotNoRotate, annotNoView, annotReadOnly);
  // Sub Filter for signature  
  TgtSigSubfilter = (sfX509RsaSha1, sfPkcs7Detached, sfPkcs7Sha1);

  // Signature Appearance options
  TgtDisplayTextOption = (dtoReason, dtoName, dtoDate, dtoLabels,
    dtoLocation);

  TgtDisplayTextOptions = set of TgtDisplayTextOption;
  (*
    Holds information about fonts that are used in the created PDF file.
    Contains information required for Type1,
      TrueType (Without Font Embedding) fonts.
  *)

  TgtPDFFont = class(TObject)
  private
  public
  end;

{ TgtPDFPageFont }
  TgtPDFFontObject = class(TgtPDFFont)
  private
    function GetFontName: WideString;
    function GetFontType: string;
    function GetIsBold: Boolean;
    function GetIsItalic: Boolean;
    function GetEncodingName: string;
    function GetBaseFont: string;
    function GetEmbeddingType: TgtFontEmbedding;
    constructor Create(AObject: TgtPDFont); overload;
  protected
    FPDFont: TgtPDFont;
  public
    constructor Create; overload;
    destructor Destroy; override;
    property FontName: WideString read GetFontName;
    property FontType: string read GetFontType;
    property IsBold: Boolean read GetIsBold;
    property IsItalic: Boolean read GetIsItalic;
    property EncodingName: string read GetEncodingName;
    property BaseFont: string read GetBaseFont;
    property EmbeddingType: TgtFontEmbedding read GetEmbeddingType;
  end;

  { TgtPDFFontList }
  TgtPDFFontList = class(Tlist)
  private
    function Get(Index: Integer): TgtPDFFontObject;
  public
    property Items[Index: Integer]: TgtPDFFontObject read Get;
  end;

{ TgtBorderattribute }
  TgtBorderAttribute = class
  private
    FBorderWidth: Double;
    FBorderStyle: TgtAnnotBorderStyle;
    FFormField: TgtPDFormField;
    function GetBorderWidth: Double;
    procedure SetBorderWidth(AValue: Double);
    function GetBorderStyle: TgtAnnotBorderStyle;
    procedure SetBorderStyle(AValue: TgtAnnotBorderStyle);
    constructor Create(AFormField: TgtPDFormField); overload;
  public
    constructor Create; overload;
    destructor Destroy; override;
    property BorderWidth: Double read GetBorderWidth write
      SetBorderWidth;
    property BorderStyle: TgtAnnotBorderStyle read GetBorderStyle
      write SetBorderStyle;
  end;

  //Class used to update Metadata XML contents to reflect custom document info
  TgtCustomPDFInfo = class(TObject)
  private
    FSchema: TgtCustomInfoSchema;
    FURI: string;
    FName: string;
    FValue: string;
  public
    constructor Create; overload;
    constructor Create(Schema: TgtCustomInfoSchema); overload;
    destructor Destroy; override;
    property Schema: TgtCustomInfoSchema read FSchema write FSchema;
    property URI: string read FURI write FURI;
    property Name: string read FName write FName;
    property Value: string read FValue write FValue;
  end;


{ TgtPDFFormField }

  TgtPDFFormField = class(TObject)
  private
    FMeasurementUnit: TgtMeasurementUnit;
    FFont: TFont;
    FBorderAttribute: TgtBorderAttribute;
    function GetAdditionalPreferences: TgtAdditionalPreferences;
    function GetAltFieldName: string;
    function GetBackgroundColor: TColor;
    function GetBorderAttribute: TgtBorderAttribute;
    function GetBorderColor: TColor;
    function GetDefaultValue: string;
    function GetFieldName: string;
    function GetFont: TFont;
    function GetJustification: TgtPDFFieldJustification;
    function GetPreferences: TgtAcroFieldPreferences;
    function GetRect: TgtRect;
    function GetTransparent: Boolean;
    function GetTrigger: TgtFormFieldActionTriggers;
    function GetValue: string;
    function GetAction: TgtPDFAction;
    procedure SetAction(const Value: TgtPDFAction);
    procedure SetAdditionalPreferences(const Value: TgtAdditionalPreferences);
    procedure SetAltFieldName(const Value: string);
    procedure SetBackgroundColor(const Value: TColor);
    procedure SetBorderAttribute(const Value: TgtBorderAttribute);
    procedure SetBorderColor(const Value: TColor);
    procedure SetDefaultValue(const Value: string);
    procedure SetFieldJustification(const Value: TgtPDFFieldJustification);
    procedure SetFieldName(const Value: string);
    procedure SetFont(const Value: TFont);
    procedure SetPreferences(const Value: TgtAcroFieldPreferences);
    procedure SetRect(const Value: TgtRect);
    procedure SetTransparent(const Value: Boolean);
    procedure SetTrigger(const Value: TgtFormFieldActionTriggers);
    procedure SetValue(const Value: string);
    function GetOrientation: TgtPDFormFieldOrientation;
    procedure SetOrientation(const Value: TgtPDFormFieldOrientation);
  protected
    FFormField: TgtPDFormField;
    FAction: TgtPDFAction;

    FIsSetMeasurementUnit: Boolean;
    procedure SetMeasurementUnit(const Value: TgtMeasurementUnit); virtual;
    property MeasurementUnit: TgtMeasurementUnit write SetMeasurementUnit;

    property Value: string read GetValue write SetValue;
    property DefaultValue: string read GetDefaultValue write SetDefaultValue;
    property Font: TFont read GetFont write SetFont;
    property FieldName: string read GetFieldName write SetFieldName;
    property Preferences: TgtAcroFieldPreferences read GetPreferences
      write SetPreferences;
    property AdditionalPreferences: TgtAdditionalPreferences read GetAdditionalPreferences
      write SetAdditionalPreferences;
    property BorderColor: TColor read GetBorderColor write SetBorderColor
      default clBlack;
    property Justification: TgtPDFFieldJustification read GetJustification write SetFieldJustification;
    property BackgroundColor: TColor read GetBackgroundColor
      write SetBackgroundColor default clWhite;
    property Rect: TgtRect read GetRect write SetRect;
    property AltFieldName: string read GetAltFieldName write SetAltFieldName;
    property Transparent: Boolean read GetTransparent write SetTransparent;
    property BorderAttribute: TgtBorderAttribute read GetBorderAttribute write SetBorderAttribute;
  public
    constructor Create;
    destructor Destroy; override;
    property TriggerType: TgtFormFieldActionTriggers read GetTrigger write SetTrigger;
    property Action: TgtPDFAction read GetAction write SetAction;
    property Orientation: TgtPDFormFieldOrientation read GetOrientation write SetOrientation;
  end;

  TgtPDFFormPushButton = class(TgtPDFFormField)
  private
    FPushButtonAction: TgtPDAction;
    function GetDownCaption: string;
    function GetFormSubmitFormat: TgtFormSubmitFormat;
    function GetJavaScript: string;
    function GetNormalCaption: string;
    function GetRolloverCaption: string;
    function GetSubmitURL: WideString;
    function GetAction: TgtPushButtonAction;
    procedure SetAction(const Value: TgtPushButtonAction);
    procedure SetDownCaption(const Value: string);
    procedure SetFormSubmitFormat(const Value: TgtFormSubmitFormat);
    procedure SetJavaScript(const Value: string);
    procedure SetNormalCaption(const Value: string);
    procedure SetRolloverCaption(const Value: string);
    procedure SetSubmitURL(const Value: WideString);
  public
    constructor Create;
    destructor Destroy; override;

    property Font;
    property FieldName;
    property AltFieldName;
    property Preferences;
    property AdditionalPreferences;
    property BorderColor;
    property BackgroundColor;
    property Transparent;
    property Rect;
    property NormalCaption: string read GetNormalCaption write SetNormalCaption;
    property RolloverCaption: string read GetRolloverCaption
      write SetRolloverCaption;
    property DownCaption: string read GetDownCaption write SetDownCaption;
    property Action: TgtPushButtonAction read GetAction write SetAction
      default pbaNone;
    property JavaScript: string read GetJavaScript write SetJavaScript;
    property SubmitURL: WideString read GetSubmitURL write SetSubmitURL;
    property FormSubmitFormat: TgtFormSubmitFormat read GetFormSubmitFormat
      write SetFormSubmitFormat default fsfHTML;
    property BorderAttribute;
  end;

{ TgtPDFFormCheckBox }

  TgtPDFFormCheckBox = class(TgtPDFFormField)
  private
    function GetChecked: Boolean;
    function GetSymbol: TgtPDFFormCheckboxSymbol;
    procedure SetChecked(const Value: Boolean);
    procedure SetSymbol(const Value: TgtPDFFormCheckboxSymbol);
  public
    constructor Create;
    destructor Destroy; override;

    property Font;
    property FieldName;
    property AltFieldName;
    property Preferences;
    property AdditionalPreferences;
    property BorderColor;
    property BackgroundColor;
    property Transparent;
    property Rect;
    property Symbol: TgtPDFFormCheckboxSymbol read GetSymbol write SetSymbol
      default pfcsCheck;
    property Checked: Boolean read GetChecked write SetChecked default False;
    property BorderAttribute;
  end;

{ TgtPDFFormRadioItem }

  TgtPDFFormRadioItem = class(TgtPDFFormField)
  public
    constructor Create;
    destructor Destroy; override;

    property Value;
    property BorderColor;
    property BackgroundColor;
    property Rect;
  end;

{ TgtPDFFormRadioButton }

  TgtPDFFormRadioButton = class(TgtPDFFormField)
  private
    function GetAtleastOneSelectedItem: Boolean;
    function GetSelectedItemIndex: Integer;
    function GetSymbol: TgtPDFFormCheckboxSymbol;
    procedure SetAtleastOneSelectedItem(const Value: Boolean);
    procedure SetSelectedItemIndex(const Value: Integer);
    procedure SetSymbol(const Value: TgtPDFFormCheckboxSymbol);
    function GetOptionCount: Integer;
  protected
    property OptionCount: Integer read GetOptionCount;
  public
    constructor Create;
    destructor Destroy; override;

    function AddItem(RadioItem: TgtPDFFormRadioItem): Integer;

    property Font;
    property FieldName;
    property AltFieldName;
    property Preferences;
    property AdditionalPreferences;
    property Value;
    property DefaultValue;
    property Transparent;
    property BorderAttribute;
    property SelectedItemIndex: Integer read GetSelectedItemIndex
      write SetSelectedItemIndex default -1;
    property Symbol: TgtPDFFormCheckboxSymbol read GetSymbol write SetSymbol
      default pfcsCheck;
    property AtleastOneSelectedItem: Boolean read GetAtleastOneSelectedItem
      write SetAtleastOneSelectedItem default False;
  end;

{ TgtPDFFormTextField }

  TgtPDFFormTextField = class(TgtPDFFormField)
  private
    function GetIsDoNotScroll: Boolean;
    function GetIsDoNotSpellCheck: Boolean;
    function GetIsFileSelect: Boolean;
    function GetIsMultiline: Boolean;
    function GetIsPassword: Boolean;
    function GetMaxLength: Integer;
    procedure SetIsDoNotScroll(const Value: Boolean);
    procedure SetIsDoNotSpellCheck(const Value: Boolean);
    procedure SetIsFileSelect(const Value: Boolean);
    procedure SetIsMultiline(const Value: Boolean);
    procedure SetIsPassword(const Value: Boolean);
    procedure SetMaxLength(const Value: Integer);
    function GetIsComb: Boolean;
    procedure SetIsComb(const Value: Boolean);
  public
    constructor Create;
    destructor Destroy; override;

    property Value;
    property Font;
    property FieldName;
    property AltFieldName;
    property Preferences;
    property AdditionalPreferences;
    property BorderColor;
    property BackgroundColor;
    property Transparent;
    property Rect;
    property DefaultValue;
    property IsMultiline: Boolean read GetIsMultiline write SetIsMultiline
      default False;
    property IsPassword: Boolean read GetIsPassword write SetIsPassword
      default False;
    property IsFileSelect: Boolean read GetIsFileSelect write SetIsFileSelect
      default False;
    property IsDoNotSpellCheck: Boolean read GetIsDoNotSpellCheck
      write SetIsDoNotSpellCheck default False;
    property IsDoNotScroll: Boolean read GetIsDoNotScroll write SetIsDoNotScroll
      default False;
    property MaxLength: Integer read GetMaxLength write SetMaxLength
      default -1;
    property IsComb: Boolean read GetIsComb write SetIsComb;
    property BorderAttribute;
    property Justification;
  end;

{ TgtPDFFormComboBox }

  TgtPDFFormComboBox = class(TgtPDFFormField)
  private
    function GetIsEditable: Boolean;
    function GetIsSortList: Boolean;
    function GetSelectedItemIndex: Integer;
    procedure SetIsEditable(const Value: Boolean);
    procedure SetIsSortList(const Value: Boolean);
    procedure SetSelectedItemIndex(const Value: Integer);
  protected
    FItems: array of string;
  public
    function AddItem(Item: string): Integer;
    constructor Create;
    destructor Destroy; override;

    property Font;
    property FieldName;
    property AltFieldName;
    property Preferences;
    property AdditionalPreferences;
    property BorderColor;
    property BackgroundColor;
    property Transparent;
    property Rect;
    property Value;
    property DefaultValue;
    property IsEditable: Boolean read GetIsEditable write SetIsEditable
      default False;
    property IsSortList: Boolean read GetIsSortList write SetIsSortList
      default False;
    property SelectedItemIndex: Integer read GetSelectedItemIndex
      write SetSelectedItemIndex default -1;
    property BorderAttribute;
    property Justification;
  end;

{ TgtPDFFormListBox }

  TgtPDFFormListBox = class(TgtPDFFormField)
  private
    function GetIsMultiSelect: Boolean;
    function GetIsSortList: Boolean;
    procedure SetIsMultiSelect(const Value: Boolean);
    procedure SetIsSortList(const Value: Boolean);
  protected
    FItems: array of string;
  public
    function AddItem(Item: string): Integer;
    constructor Create;
    destructor Destroy; override;

    property Font;
    property FieldName;
    property AltFieldName;
    property Preferences;
    property AdditionalPreferences;
    property Transparent;
    property BorderColor;
    property BackgroundColor;
    property Rect;
    property Value;
    property DefaultValue;
    property IsSortList: Boolean read GetIsSortList write SetIsSortList
      default False;
    property IsMultiSelect: Boolean read GetIsMultiSelect write SetIsMultiSelect
      default False;
    property BorderAttribute;
    property Justification;
  end;

  TgtPDSignature = class
  private
    FAuthor,
    FContactInfo,
    FLocation,
    FReason: AnsiString;
    FHandler: AnsiString;
    FSubfilter: TgtSigSubfilter;
    FDateTime: TDateTime;
  public
    constructor Create; overload;
    destructor Destroy; override;

    //GetSignedVersion;
    property Author: AnsiString read FAuthor;
    property ContactInfo: AnsiString read FContactInfo;
    property Location: AnsiString read FLocation;
    property Reason: AnsiString read FReason;
    property Handler: AnsiString read FHandler;
    property SubFilter: TgtSigSubfilter read FSubfilter;
    property DateTime: TDateTime read FDateTime;
  end;

{ TgtPDFFormSignature }

  TgtPDFFormSignature = class(TgtPDFFormField)
  private
    FSignature: TgtPDSignature;
    function GetSignature: TgtPDSignature;
  public
    constructor Create;
    destructor Destroy;

    property Signature:TgtPDSignature read GetSignature;
  end;

{ TgtFontInfo }

  TgtFontInfo = class(TObject)
  private
    FName: string;
    FFont: TFont;
    FColor: string;
    FActualSize: Double;

    procedure SetName(AName: string);
    procedure SetFont(AFont: TFont);
    procedure SetColor(AColor: string);
    function GetName: string;
    function GetFont: TFont;
    function GetColor: string;
  public
    constructor Create;
    destructor Destroy; override;
    property Name: string read GetName write SetName;
    property Font: TFont read GetFont write SetFont;
    property Color: string read GetColor write SetColor;
    property ActualSize: Double read FActualSize write FActualSize;
  end;

  { TgtFormField  }

  TgtFormField = class(TObject)
  private
    FPageNum: Integer;
    FBorderAttribute: TgtBorderAttribute;
    FDefaultFont: TgtFontInfo;
    FAllowedValues: TStringList;

    function GetFieldName: string;
    function GetQualifiedName: string;
    function GetFieldValue: WideString;
    function GetIsReadOnly: Boolean;
    function GetMultiLine: Boolean;
    function GetDefaultFieldValue: string;
    function GetAllowedValues: TStringList;
    function GetTransparent: Boolean;
    function GetFieldType: TgtPDFFormFieldType;
    function GetJustification: TgtPDFFieldJustification;
    function GetMaxLen: Integer;
    function GetFieldDescription: string;
    function GetVisible: boolean;
    function GetPrint: boolean;
    function GetSubmitURL: string;
    function GetAdditionalPreferences: TgtAdditionalPreferences;
    function GetBackGroundColor: TColor;
    function GetBorderAttribute: TgtBorderAttribute;
    function GetRequired: Boolean;
    function GetFieldRect: TgtRect;
    function GetDefaultFont: TgtFontInfo;
    function GetPageNum: Integer;

    procedure SetFieldName(const Value: string);
    procedure SetQualifiedName(const Value: string);
    procedure SetFieldValue(const Value: WideString);
    procedure SetIsReadOnly(const Value: Boolean);
    procedure SetMultiLine(const Value: Boolean);
    procedure SetJustification(const Value: TgtPDFFieldJustification);
    procedure SetAllowedValues(const Value: TStringList);
    procedure SetMaxLen(const Value: Integer);
    procedure SetFieldDescription(const Value: string);
    procedure SetVisible(const Value: boolean);
    procedure SetPrint(const Value: boolean);
    procedure SetSubmitURL(const Value: string);
    procedure SetAdditionalPreferences(const Value: TgtAdditionalPreferences);
    procedure SetTransparent(const Value: Boolean);
    procedure SetBackGroundColor(const Value: TColor);
    procedure SetBorderAttribute(const Value: TgtBorderAttribute);
    procedure SetRequired(const Value: Boolean);
    procedure SetDefaultFieldValue(const Value: string);
    function GetIsComb: Boolean;
    procedure SetIsComb(const Value: Boolean);
    function GetOrientation: TgtPDFFormFieldOrientation;
  protected
    FFormField: TgtPDFormField;

  public
    constructor Create;
    destructor Destroy; override;
    procedure Fill(APFXFileName, APFXPassword: AnsiString; AReason: AnsiString = '';
      ALocation: AnsiString = ''; AContactInfo: AnsiString = ''); overload;
    procedure Fill(APFXFileName, APFXPassword: AnsiString;
      ADateTime: TDateTime; AReason, ALocation, AContactInfo: AnsiString); overload;
    property PageNum: Integer read GetPageNum;
    property FieldName: string read GetFieldName write SetFieldName;
    property QualifiedName: string read GetQualifiedName write SetQualifiedName;
    property FieldValue: WideString read GetFieldValue write SetFieldValue;
    property DefaultValue: string read GetDefaultFieldValue
      write SetDefaultFieldValue;
    property FieldType: TgtPDFFormFieldType read GetFieldType;
    property MaxLen: Integer read GetMaxLen write SetMaxLen;
    property IsComb: Boolean read GetIsComb write SetIsComb;
    property FieldDescription: string read GetFieldDescription
      write SetFieldDescription;
    property AllowedValues: TStringList read GetAllowedValues
      write SetAllowedValues;
    property DefaultFont: TgtFontInfo read GetDefaultFont;
    property Justification: TgtPDFFieldJustification read GetJustification
      write SetJustification;
    property ReadOnly: Boolean read GetIsReadOnly write SetIsReadOnly;
    property MultiLine: Boolean read GetMultiLine write SetMultiline; // only for text fields
    property Visible: Boolean read GetVisible write SetVisible default true;
    property Printable: Boolean read GetPrint write SetPrint default true;
    property SubmitURL: string read GetSubmitURL write SetSubmitURL;
    property FieldRect: TgtRect read GetFieldRect;
    property AdditionalPreferences: TgtAdditionalPreferences
      read GetAdditionalPreferences write SetAdditionalPreferences;
    property Transparent: Boolean read GetTransparent write SetTransparent;
    property BackgroundColor: TColor read GetBackGroundColor
      write SetBackGroundColor;
    property BorderAttribute: TgtBorderAttribute read GetBorderAttribute
      write SetBorderAttribute;
    property Required: Boolean read GetRequired write SetRequired;
    property Orientation: TgtPDFFormFieldOrientation read GetOrientation;
  end;

  TgtPDFAnnotation = class(TObject)
  private
    FMeasurementUnit: TgtMeasurementUnit;

    constructor Create(AObject: TgtPDAnnot); overload;
    procedure SetBackgroundColor(const Value: TColor);
    procedure SetContents(const Value: WideString);
    function GetBackgroundColor: TColor;
    function GetBorderStyle: TgtAnnotBorderStyle;
    function GetBorderWidth: Double;
    function GetContents: WideString;
    function GetName: string;
    function GetRectBottom: Double;
    function GetRectLeft: Double;
    function GetRectRight: Double;
    function GetRectTop: Double;
    function GetTitle: WideString;
    procedure SetBorderStyle(const Value: TgtAnnotBorderStyle);
    procedure SetBorderWidth(const Value: Double);
    procedure SetName(const Value: string);
    procedure SetRectBottom(const Value: Double);
    procedure SetRectLeft(const Value: Double);
    procedure SetRectRight(const Value: Double);
    procedure SetRectTop(const Value: Double);
    procedure SetTitle(const Value: WideString);
    function GetAnnotType: TgtPDAnnotType;

  protected
    FPageNo: Integer;
    FAnnot: TgtPDAnnot;

    FIsSetMeasurementUnit: Boolean;
    procedure SetMeasurementUnit(const Value: TgtMeasurementUnit); virtual;
    property MeasurementUnit: TgtMeasurementUnit write SetMeasurementUnit;
  public
    constructor Create; overload;
    destructor Destroy; override;

    procedure SetBounds(Left, Top, Right, Bottom: Double);
    property Contents: WideString read GetContents write SetContents;
    property RectTop: Double read GetRectTop write SetRectTop;
    property RectLeft: Double read GetRectLeft write SetRectLeft;
    property RectRight: Double read GetRectRight write SetRectRight;
    property RectBottom: Double read GetRectBottom write SetRectBottom;
    property BackgroundColor: TColor read GetBackgroundColor
      write SetBackgroundColor default clBlue;
    property BorderWidth: Double read GetBorderWidth write SetBorderWidth;
    property BorderStyle: TgtAnnotBorderStyle read GetBorderStyle
      write SetBorderStyle;
    property AnnotTitle: WideString read GetTitle write SetTitle;
    property Name: string read GetName write SetName;
    property AnnotType: TgtPDAnnotType read GetAnnotType;
  end;

  TgtPDFFileAttachment = class(TgtPDFAnnotation)
  private
    FFileName: WideString;
    FFileAttachmentIcon: TgtFileAttachmentIcon;
    FIconColor: TColor;
    FContents: WideString;
    FSubject: WideString;
    FAuthor: WideString;
    FAttachName: WideString;

    procedure SetIconColor(const Value: TColor);
    function GetIconColor: TColor;
    function GetIcon: TgtFileAttachmentIcon;
    procedure SetIcon(const Value: TgtFileAttachmentIcon);
    function GetAttachName: WideString;
    function GetFileName: WideString;
    procedure SetAttachName(const Value: WideString);
    procedure SetFileName(const Value: WideString);
  public
    constructor Create;
    destructor Destroy; override;

    property FileName: WideString read GetFileName write SetFileName;
    property FileAttachmentIcon: TgtFileAttachmentIcon read GetIcon write SetIcon;
    property IconColor: TColor read GetIconColor write SetIconColor;
    property AttachmentName: WideString read GetAttachName write SetAttachName;
  end;

  TgtPDFLineAnnotation = class(TgtPDFAnnotation)
  private
//    FLineInteriorColor: TColor;
    function GetLineBeginingStyle: TgtLineStyle;
    function GetLineEndingStyle: TgtLineStyle;
    function GetLineInteriorColor: TColor;
    function GetX1: Double;
    function GetX2: Double;
    function GetY1: Double;
    function GetY2: Double;
    procedure SetLineBeginingStyle(const Value: TgtLineStyle);
    procedure SetLineEndingStyle(const Value: TgtLineStyle);
    procedure SetLineInteriorColor(const Value: TColor);
    procedure SetX1(const Value: Double);
    procedure SetX2(const Value: Double);
    procedure SetY1(const Value: Double);
    procedure SetY2(const Value: Double);
  protected
    procedure SetMeasurementUnit(const Value: TgtMeasurementUnit); override;
  public
    constructor Create;
    destructor Destroy; override;

    procedure gtLine(XX1, YY1, XX2, YY2: Double);
    property X1: Double read GetX1 write SetX1;
    property Y1: Double read GetY1 write SetY1;
    property X2: Double read GetX2 write SetX2;
    property Y2: Double read GetY2 write SetY2;
    property LineBeginingStyle: TgtLineStyle read GetLineBeginingStyle
      write SetLineBeginingStyle default laNone;
    property LineEndingStyle: TgtLineStyle read GetLineEndingStyle
      write SetLineEndingStyle;
    property LineInteriorColor: TColor read GetLineInteriorColor write SetLineInteriorColor;
  end;

  TgtPDFCircleAnnotation = class(TgtPDFAnnotation)
  private
    function GetCircleInteriorColor: TColor;
    function GetIntensity: Double;
    function GetIsCloudy: Boolean;
    procedure SetCircleInteriorColor(const Value: TColor);
    procedure SetIntensity(const Value: Double);
    procedure SetIsCloudy(const Value: Boolean);
  public
    constructor Create;
    destructor Destroy; override;

    property CircleInteriorColor: TColor read GetCircleInteriorColor
      write SetCircleInteriorColor;
    property IsCloudy: Boolean read GetIsCloudy write SetIsCloudy default False;
    property Intensity: Double read GetIntensity write SetIntensity;
  end;

  TgtPDFSquareAnnotation = class(TgtPDFAnnotation)
  private
    function GetIntensity: Double;
    function GetIsCloudy: Boolean;
    function GetSquareInteriorColor: TColor;
    procedure SetIntensity(const Value: Double);
    procedure SetIsCloudy(const Value: Boolean);
    procedure SetSquareInteriorColor(const Value: TColor);
  public
    constructor Create;
    destructor Destroy; override;

    property SquareInteriorColor: TColor read GetSquareInteriorColor
      write SetSquareInteriorColor;
    property IsCloudy: Boolean read GetIsCloudy
      write SetIsCloudy default False;
    property Intensity: Double read GetIntensity write SetIntensity;
  end;

  TgtPDFLinkAnnotation = class(TgtPDFAnnotation)
  private
    FLinkAction: TgtPDFAction;
    function GetAction: TgtPDFAction;
    function GetHighlightType: TgtLinkHighlightType;
    procedure SetAction(const Value: TgtPDFAction);
    procedure SetHighlightType(const Value: TgtLinkHighlightType);
  public
    constructor Create;
    destructor Destroy; override;
    property LinkHighlightType: TgtLinkHighlightType
      read GetHighlightType write SetHighlightType;
    property Action: TgtPDFAction read GetAction write SetAction;
  end;

  TgtPDFStampAnnotation = class(TgtPDFAnnotation)
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TgtAnnotationList = class(TObjectList)
  private
    function GetAnnotation(I: Integer): TgtPDFAnnotation;
  public
    property Items[Index: Integer]: TgtPDFAnnotation read GetAnnotation;
  end;

{ TgtPDFPolygonAnnotation }

  TgtPDFPolygonAnnotation = class(TgtPDFAnnotation)
  private
    function GetIntensity: Double;
    function GetIsCloudy: Boolean;
    procedure SetIntensity(const Value: Double);
    procedure SetIsCloudy(const Value: Boolean);
    function GetVertices: WideString;
  protected
    procedure SetMeasurementUnit(const Value: TgtMeasurementUnit); override;
  public
    constructor Create;
    destructor Destroy; override;

    procedure SetVertices(AVerticesString: string);

    property IsCloudy: Boolean read GetIsCloudy
      write SetIsCloudy default False;
    property Intensity: Double read GetIntensity write SetIntensity;
  end;

  TgtPDFPolylineAnnotation = class(TgtPDFAnnotation)
  private
    function GetLineEndingStyle: TgtLineStyle;
    procedure SetLineEndingStyle(const Value: TgtLineStyle);
    function GetVertices: WideString;
  protected
    procedure SetMeasurementUnit(const Value: TgtMeasurementUnit); override;
  public
    constructor Create;
    destructor Destroy; override;

    procedure SetVertices(AVerticesString: string);

    property PolyLineEndingStyle: TgtLineStyle read GetLineEndingStyle
      write SetLineEndingStyle;
  end;

  TgtPDFCaretAnnotation = class(TgtPDFAnnotation)
  private
    function GetCaretSymbol: TgtCaretSymbol;
    procedure SetCaretSymbol(const Value: TgtCaretSymbol);
  public
    constructor Create;
    destructor Destroy; override;

    property CaretSymbol: TgtCaretSymbol read GetCaretSymbol write SetCaretSymbol;
  end;

{ TgtPDFTextAnnotaion }

  TgtPDFTextAnnotation = class(TgtPDFAnnotation)
  private
    FVerticalCorner, FHorizontalCorner: Integer;
    FAnnotationFlag: TgtAnnotationFlag;
    procedure setOpen(const Value: Boolean);
    function GetOpen: Boolean;
    function GetFlag: TgtAnnotationFlag;
    procedure SetFlag(const Value: TgtAnnotationFlag);
  public
    constructor Create;
    destructor Destroy; override;

    property Open: Boolean read GetOpen write setOpen default False;
    property BorderHorizontalCornerRadius: Integer read FHorizontalCorner
      write FHorizontalCorner default 0;
    property BorderVerticalCornerRadius: Integer read FVerticalCorner
      write FVerticalCorner default 0;
    property AnnotationFlag: TgtAnnotationFlag read GetFlag
      write SetFlag;
  end;

{ TgtPDFFreeTextAnnotaton }

  TgtPDFFreeTextAnnotation = class(TgtPDFAnnotation)
  private
//    FBorderColor: Tcolor;
    FFreeTextFont: TFont;
//    FTgtFreeTextAllignment: TgtFreeTextAllignment;
    function GetBorderColor: Tcolor;
    function GetFont: TFont; // pending
    function GetTextAllignment: TgtFreeTextAllignment;
    procedure SetBorderColor(const Value: Tcolor);
    procedure SetTextAllignment(const Value: TgtFreeTextAllignment);
    procedure SetTextFont(const Value: TFont); // pending

  public
    constructor Create;
    destructor Destroy; override;

    property BorderColor: Tcolor read GetBorderColor write SetBorderColor default clBlack;
    property FreeTextAllignment: TgtFreeTextAllignment read GetTextAllignment
      write SetTextAllignment default ftaLeftJustified;
    property FreeTextFont: TFont read GetFont write SetTextFont;
  end;

{ TgtPDFInkAnnotation }

  TgtPDFInkAnnotation = class(TgtPDFAnnotation)
  private
    function GetInkList: string;
    procedure SetInkList(const Value: string);
  protected
    procedure SetMeasurementUnit(const Value: TgtMeasurementUnit); override;
  public
    constructor Create;
    destructor Destroy; override;

    property InkList: string read GetInkList write SetInkList;
  end;

{ TgtPDFMarkUpAnnotation }

  TgtPDFMarkUpAnnotation = class(TgtPDFAnnotation)
  private
    // For measurement unit Conversion
    FX1, FY1,
    FX2, FY2,
    FX3, FY3,
    FX4, FY4: Double;
    function GetMarkUpType: TgtMarkUpType;
    procedure SetMarkUpType(const Value: TgtMarkUpType);
  protected
    procedure SetMeasurementUnit(const Value: TgtMeasurementUnit); override;
  public
    constructor Create;
    destructor Destroy; override;
    procedure SetQuad(X1, Y1, X2, Y2, X3, Y3, X4, Y4: Double);
    property MarkUpType: TgtMarkUpType read GetMarkUpType write SetMarkUpType;
  end;

{ TgtPDFPageLevelAction }

  TgtPDFPageLevelAction = class(TObject)
  private
    FAdditionalAction: TgtPDFAction;
    FTriggerType: TgtPageActionTriggers;
  public
    constructor Create;
    destructor Destroy; override;

    property AdditionalAction: TgtPDFAction
      read FAdditionalAction write FAdditionalAction;
    property TriggerType: TgtPageActionTriggers
      read FTriggerType write FTriggerType;
  end;

{ TgtPDFDocumentLevelAction }

  TgtPDFDocumentLevelAction = class(TgtPDFPageLevelAction)
  private
    FOpenAction: TgtPDFAction;
    FTriggerType: TgtDocActionTriggers;
  public
    constructor Create;
    destructor Destroy; override;
    property TriggerType: TgtDocActionTriggers
      read FTriggerType write FTriggerType;
    property OpenAction: TgtPDFAction read FOpenAction write FOpenAction;
  end;

  TgtExPDFDocument = class(TgtCustomPDFDocument)
  private
//    FFontList: TStrings;
    FFontList: TgtPDFFontList;
    FAnnotList: TgtAnnotationList;
    FStreamDoc: TMemoryStream;
//
    FOnAttachmentNameChange: TgtChangeAttachmentNameEvent;
////    function GetAllInstalledFonts: TStrings;
    procedure FlattenFormFieldByPage(APageNo: Integer);
    procedure FlattenFormField(AFormField: TgtFormField);
  protected
    function GetFonts: TStrings;
  public
//    constructor
    constructor Create(AOwner: TComponent); override;
    //destructor
    destructor Destroy; override;

    function ExtractText(FromPages: string; WysiwygSpacing: Boolean = False;
      PageBreak: Boolean = True): TgtWideStringList; overload;
    function ExtractText(FromPage, ToPage: Integer; WysiwygSpacing: Boolean = False;
      PageBreak: Boolean = True): TgtWideStringList; overload;
    function ExtractTextFromPage(PageNo: Integer;
      WysiwygSpacing: Boolean = False): TgtWideStringList; overload;
    procedure InsertBlankPageAt(APageNumber: Integer; PageWidth,
      PageHeight: Double);
    //Gets form fields from a page
    function GetFormField(FieldNo: Integer): TgtFormField; overload;
    function GetFormField(FieldName: string): TgtFormField; overload;

    procedure Stitch(AStitchToPageNo, AStitchFromPageNo: Integer);
    procedure StitchSideBySide(AStitchToPageNo, AStitchFromPageNo: Integer);

    procedure AddCustomPDFInfo(CustomDocInfo: TgtCustomPDFInfo);

    procedure InsertFileAttachment(AFile: TgtPDFFileAttachment; PageNumber: Integer);

    procedure InsertAnnotation(Annot: TgtPDFAnnotation; PageNumber: Integer);

    function GetAnnotations(PageNum: Integer): TgtAnnotationList;

    procedure FlattenFormFields(FieldNo: Integer); overload;
    procedure FlattenFormFields(FieldName: string); overload;
    procedure FlattenFormFieldsOnPage(APageRange: string);
    procedure SaveFileAttachmentTo(APathName: string);
    //Textout
    procedure TextOut(HTMLStr: WideString; PageRange: string;
      XPos, YPos: Double); overload; virtual;
    procedure TextOut(HTMLStr: WideString; XPos, YPos: Double); overload; virtual;

    procedure AddDocumentLevelAction(AAction: TgtPDFDocumentLevelAction);
    procedure AddPageLevelAction(AAction: TgtPDFPageLevelAction; APageNo: Integer);

    procedure RemoveExistingPageActions(APageNo: Integer; ATriggerType: TgtPageActionTriggers);
    procedure RemoveExistingDocActions(ATriggerType: TgtDocActionTriggers);
    //Font embedding
    procedure EmbedUsedTrueTypeFonts(AFontName: string; AFontStyles: TFontStyles); overload;
    procedure EmbedUsedTrueTypeFonts(); overload;

    function GetFontList(): TgtPDFFontList; overload;
    function GetFontList(APageNo: Integer): TgtPDFFontList; overload;

    //Adding FormField
    procedure AddFormField(AFormField: TgtPDFFormField; APageNumber: Integer);
    procedure ExportFDFDataTo(AFileName: string);

    procedure AddSignature(PFXFileName, PFXPassword: AnsiString; Reason: AnsiString = '';
      Location: AnsiString = ''; ContactInfo: AnsiString = '';
      PageNumber: Integer = 1; FieldName: AnsiString = ''); overload;
    procedure AddSignature(PFXFileName, PFXPassword: AnsiString; TimeStamp: TDateTime;
      Reason, Location, ContactInfo: AnsiString; PageNumber: Integer; FieldName: AnsiString;
      FieldBounds: TgtRect; DisplayTextOptions: TgtDisplayTextOptions = [];
      Backgroundcolor: TColor = clWhite; Font: TFont = nil); overload;
    procedure AddSignature(PFXFileName, PFXPassword: AnsiString; TimeStamp: TDateTime;
      Reason: AnsiString = ''; Location: AnsiString = ''; ContactInfo: AnsiString = '';
      PageNumber: Integer = 1; FieldName: AnsiString = ''); overload;
    procedure AddSignature(PFXFileName, PFXPassword: AnsiString;
      Reason, Location, ContactInfo: AnsiString; PageNumber: Integer; FieldName: AnsiString;
      FieldBounds: TgtRect; DisplayTextOptions: TgtDisplayTextOptions = [];
      Backgroundcolor: TColor = clWhite; Font: TFont = nil); overload;

  published
    property OnAttachmentNameChange: TgtChangeAttachmentNameEvent read
      FOnAttachmentNameChange write FOnAttachmentNameChange;
  end;

implementation

uses
  SysUtils, PDFormTextField, PDFormListBox, PDFormComboBox, PDFormRadioButton,
  PDSubmitFormAction, PDJavaScriptAction, PDFormPushButton, PDResetFormAction,
  PDFormCheckBox, gtFont, PDTextExportDev, Forms, gtPDFConsts, PDRect,
  PDGoToAction, PDDestination, PDLineAnnot, PDCircleAnnot, PDSquareAnnot, PDLinkAnnot, PDPolygonAnnot,
  PDPolyLineAnnot, PDCaretAnnot, PDRubberStampAnnot, PDTextAnnot, PDFreeTextAnnot,
  PDInkAnnot, PDMarkUpAnnot, PDDocument, PDFileAttachmentAnnot, PDPage,
  PDSignatureField, PDSignature,
  {$IFDEF gtDelphi6up} 
    StrUtils 
  {$ELSE} 
    gtStrUtils
  {$ENDIF}
  ;

type

  THackgtPDFormField = class(TgtPDFormField)

  end;

  THackgtPDFAction = class(TgtPDFAction)

  end;
  
{ TgtExPDFDocument }

procedure TgtExPDFDocument.AddCustomPDFInfo(CustomDocInfo: TgtCustomPDFInfo);
var
  LXMLContent: string;

  procedure UpdateMetaData(AXMLMetaData: string; ANamespace: string;
    CustomDocInfo: TgtCustomPDFInfo);
  var
    LCustProp: string;
    LPrevString, LNextString: string;
    LIndex: Integer;
  begin
    LCustProp := '<' + ANamespace + ':';
    {$IFDEF gtDelphi7Up}
    LIndex := PosEx(LCustProp, AXMLMetaData);
    {$ELSE}
    LIndex := PosExx(LCustProp, AXMLMetaData);
    {$ENDIF}
    if LIndex = 0 then
    begin
      LCustProp := ANamespace + ':';
    {$IFDEF gtDelphi7Up}
    LIndex := PosEx(LCustProp, AXMLMetaData);
    {$ELSE}
    LIndex := PosExx(LCustProp, AXMLMetaData);
    {$ENDIF}
    end;
    if LIndex <> 0 then
    begin
      LPrevString := System.Copy(AXMLMetaData, 1, LIndex - 1);
      if LCustProp = '<' + ANamespace + ':' then
      begin
        LCustProp := LCustProp + CustomDocInfo.FName + '>';
        LCustProp := LCustProp + CustomDocInfo.FValue + '</' + ANamespace + ':';
        LCustProp := LCustProp + CustomDocInfo.FName + '>' + CR + LF;
      end
      else
      begin
        LCustProp := LCustProp + CustomDocInfo.FName + '=';
        LCustProp := LCustProp + '''' + CustomDocInfo.FValue + '''' + SP;
      end;
      LNextString := System.Copy(AXMLMetaData, LIndex, Length(AXMLMetaData) - LIndex + 1);
      AXMLMetaData := LPrevString + LCustProp + LNextString;
    end
    else //this is a new schema
    begin
      LCustProp := '';
      {$IFDEF gtDelphi7up}
      LIndex := PosEx(CRDFHeader2, AXMLMetaData);
      {$ELSE}
      LIndex := PosExx(CRDFHeader2, AXMLMetaData);
      {$ENDIF}
      repeat LIndex := LIndex + 1 until AXMLMetaData[LIndex] = '>';
      LIndex := LIndex + 1;
      LPrevString := System.Copy(AXMLMetaData, 1, LIndex - 1);
      LCustProp := LCustProp + CR + LF + CR + LF + CRDFDesHeader + CR + LF + 'xmlns:';
      LCustProp := LCustProp + ANamespace + '=''';
      if ANamespace = 'pdf' then LCustProp := LCustProp + CAdobePDFSchemaURI + '''>' + CR + LF
      else if ANamespace = 'xmp' then LCustProp := LCustProp + CBasicSchemaURI + '''>' + CR + LF
      else if ANamespace = 'dc' then LCustProp := LCustProp + CDublinCoreSchemaURI + '''>' + CR + LF
      else if ANamespace = 'xmpBJ' then LCustProp := LCustProp + CJobTicketSchemaURI + '''>' + CR + LF
      else if ANamespace = 'xmpRights' then LCustProp := LCustProp + CRightsManageSchemaURI + '''>' + CR + LF
      else if ANamespace = 'xmpTPg' then LCustProp := LCustProp + CPagedTextSchemaURI + '''>' + CR + LF;
      LCustProp := LCustProp + '<' + ANamespace + ':';
      LCustProp := LCustProp + CustomDocInfo.FName + '>';
      LCustProp := LCustProp + CustomDocInfo.FValue + '</' + ANamespace + ':';
      LCustProp := LCustProp + CustomDocInfo.FName + '>' + CR + LF + CRDFDesTrailor;
      LNextString := System.Copy(AXMLMetaData, LIndex, Length(AXMLMetaData) - LIndex + 1);
      AXMLMetaData := LPrevString + LCustProp + LNextString;
    end;

    //Update the bytes entry in the XMP packet header
    {$IFDEF gtDelphi7up}
    LIndex := PosEx('bytes=''', AXMLMetaData);
    {$ELSE}
    LIndex := PosExx('bytes=''', AXMLMetaData);
    {$ENDIF}
    if LIndex <> 0 then
    begin
      LIndex := LIndex + 6;
      LPrevString := System.Copy(AXMLMetaData, 1, LIndex);
      repeat LIndex := LIndex + 1 until AXMLMetaData[LIndex] = '''';
      LNextString := System.Copy(AXMLMetaData, LIndex, Length(AXMLMetaData) - LIndex + 1);
      AXMLMetaData := LPrevString + IntToStr(Length(AXMLMetaData)) + LNextString;
    end;
    { Call SetXMPMetadata from PDFprocessor with the metadata string }
    FPDDoc.SetXMPMetadata(AXMLMetaData);
  end;
begin
//  if not Assigned(FPDDoc) or (FPDDoc.GetHandle = 0) then Exit;

  LXMLContent := GetXMLMetadata;

  if LXMLContent = '' then //there is no /Metadata entry in the Catalog
  begin
    LXMLContent := CXMPPacketHeader + CXmpMetaHeader + CRDFHeader1 + CRDFHeader2 + CR + LF;
    LXMLContent := LXMLContent + CRDFTrailer + CXMPMetaTrailer + CXMPPacketTrailer;
  end;

  case CustomDocInfo.Schema of
    scAdobePDF:
      UpdateMetaData(LXMLContent, CAdobePDFNamePrefix, CustomDocInfo);
    scBasic:
      UpdateMetaData(LXMLContent, CBasicNamePrefix, CustomDocInfo);
    scDublinCore:
      UpdateMetaData(LXMLContent, CDublinCoreNamePrefix, CustomDocInfo);
    scJobTicket:
      UpdateMetaData(LXMLContent, CJobTicketNamePrefix, CustomDocInfo);
    scPagedText:
      UpdateMetaData(LXMLContent, CPagedTextNamePrefix, CustomDocInfo);
    scRightsManagement:
      UpdateMetaData(LXMLContent, CRightsManageNamePrefix, CustomDocInfo);
  end;
end;

procedure TgtExPDFDocument.AddDocumentLevelAction(
  AAction: TgtPDFDocumentLevelAction);
var
  LAction: TgtPDAction;
begin
  if not Assigned(FPDDoc)  then Exit;

  LAction := nil;
  if Assigned(AAction.OpenAction) then
  begin
    LAction := THackgtPDFAction(AAction.OpenAction).FAction;
    if (LAction.ActionType = actionGoTo) or (LAction.ActionType = actionGoToR) then
    begin
      AddDestination(AAction.OpenAction);
    end;
    FPDDoc.AddAction(LAction, atBeforeDocOpen);
  end;

  if Assigned(AAction.AdditionalAction) then
  begin
    LAction := THackgtPDFAction(AAction.AdditionalAction).FAction;
    if Assigned(LAction) then
    begin
      if (LAction.ActionType = actionGoTo) or (LAction.ActionType = actionGoToR) then
      begin
        AddDestination(AAction.AdditionalAction);
      end;

      case AAction.TriggerType of
        aatBeforeDocClose: FPDDoc.AddAction(LAction, atBeforeDocClose);
        aatBeforeDocSave: FPDDoc.AddAction(LAction, atBeforeDocSave);
        aatAfterDocSave: FPDDoc.AddAction(LAction, atAfterDocSave);
        aatBeforeDocPrint: FPDDoc.AddAction(LAction, atBeforeDocPrint);
        aatAfterDocPrint: FPDDoc.AddAction(LAction, atAfterDocPrint);
      end;
    end;
  end;
end;

procedure TgtExPDFDocument.AddFormField(AFormField: TgtPDFFormField;
  APageNumber: Integer);
begin
  if not Assigned(FPDDoc) then Exit;
  AFormField.MeasurementUnit := Self.MeasurementUnit;
  FPDDoc.AddFormField(AFormField.FFormField, APageNumber);
end;

procedure TgtExPDFDocument.AddPageLevelAction(AAction: TgtPDFPageLevelAction;
  APageNo: Integer);
var
  LTriggerType: TgtPageActionTrigger;
begin
  if not Assigned(FPDDoc) then
    Exit;

  case AAction.TriggerType of
    aatBeforePageOpen: LTriggerType := atBeforePageOpen;
    aatAfterPageClose: LTriggerType := atAfterPageClose;
  end;

  if Assigned(THackgtPDFAction(AAction.AdditionalAction).FAction) then
    FPDDoc.Pages[APageNo].AddAction(THackgtPDFAction(AAction.AdditionalAction).FAction,
      LTriggerType);
end;

procedure TgtExPDFDocument.AddSignature(PFXFileName, PFXPassword: AnsiString;
  TimeStamp: TDateTime; Reason, Location, ContactInfo: AnsiString;
  PageNumber: Integer; FieldName: AnsiString; FieldBounds: TgtRect;
  DisplayTextOptions: TgtDisplayTextOptions = [];
  Backgroundcolor: TColor = clWhite; Font: TFont = nil);
var
  LRect: TgtPDRect;
  LPgHt: Double;
  LDispOptions: TgtSigDisplayOptions;
  LColor: TgtPDColorValue;
begin
  LDispOptions := [];

  if dtoReason in DisplayTextOptions then
    LDispOptions := LDispOptions + [sdoReason];
  if dtoName in DisplayTextOptions then
    LDispOptions := LDispOptions + [sdoName];
  if dtoDate in DisplayTextOptions then
    LDispOptions := LDispOptions + [sdoDate];
  if dtoLabels in DisplayTextOptions then
    LDispOptions := LDispOptions + [sdoLabels];
  if dtoLocation in DisplayTextOptions then
    LDispOptions := LDispOptions + [sdoLocation];
  LColor.ColorSpace := DeviceRGB;

  LColor.Value[0] := GetRValue(Backgroundcolor) / 255;
  LColor.Value[1] := GetGValue(Backgroundcolor) / 255;
  LColor.Value[2] := GetBValue(Backgroundcolor) / 255;


  if not Assigned(FPDDoc) then Exit;
  if (FieldBounds.Left = 0) and (FieldBounds.Top = 0) and
    (FieldBounds.Right = 0) and (FieldBounds.Bottom = 0) then
  begin
    // To Make Rect in pdf come as 0,0,0,0
    LPgHt := FPDDoc.Pages[PageNumber].GetPageHeight;
    LPgHt := ConvertToMU(MeasurementUnit, LPgHt);
    LRect := TgtPDRect.Create(FieldBounds.Left, LPgHt,
      FieldBounds.Right, LPgHt);
  end
  else
    FieldBounds.Left := ConvertToPDFUnit(MeasurementUnit, FieldBounds.Left);
    FieldBounds.Top := ConvertToPDFUnit(MeasurementUnit, FieldBounds.Top);
    FieldBounds.Right := ConvertToPDFUnit(MeasurementUnit, FieldBounds.Right);
    FieldBounds.Bottom := ConvertToPDFUnit(MeasurementUnit, FieldBounds.Bottom);
    LRect := TgtPDRect.Create(FieldBounds.Left, FieldBounds.Top,
      FieldBounds.Right, FieldBounds.Bottom);
  if FieldName = '' then
    FieldName := 'Signature';
  try
    FPDDoc.AddSignature(PFXFileName, PFXPassword, PageNumber, LRect, FieldName,
    Reason, Location, ContactInfo, TimeStamp, LDispOptions, LColor, Font);
  finally
    LRect.Free;
  end;
end;

procedure TgtExPDFDocument.AddSignature(PFXFileName, PFXPassword, Reason,
  Location, ContactInfo: AnsiString; PageNumber: Integer; FieldName: AnsiString);
var
  LRect: TgtRect;
begin
  LRect := gtRect(0, 0, 0, 0);
  AddSignature(PFXFileName, PFXPassword, 0, Reason, Location, ContactInfo,
  PageNumber, FieldName, LRect);
end;

procedure TgtExPDFDocument.AddSignature(PFXFileName, PFXPassword, Reason,
  Location, ContactInfo: AnsiString; PageNumber: Integer; FieldName: AnsiString;
  FieldBounds: TgtRect; DisplayTextOptions: TgtDisplayTextOptions = [];
  Backgroundcolor: TColor = clWhite; Font: TFont = nil);
var
  LRect: TgtRect;
begin
  LRect := gtRect(FieldBounds.Left, FieldBounds.Top,
    FieldBounds.Right, FieldBounds.Bottom);
  AddSignature(PFXFileName, PFXPassword, 0, Reason, Location, ContactInfo,
  PageNumber, FieldName, LRect, DisplayTextOptions, Backgroundcolor, Font);
end;

procedure TgtExPDFDocument.AddSignature(PFXFileName, PFXPassword: AnsiString;
  TimeStamp: TDateTime; Reason, Location, ContactInfo: AnsiString;
  PageNumber: Integer; FieldName: AnsiString);
var
  LRect: TgtRect;
begin
  LRect := gtRect(0, 0, 0, 0);
  AddSignature(PFXFileName, PFXPassword, TimeStamp, Reason, Location, ContactInfo,
  PageNumber, FieldName, LRect);
end;

constructor TgtExPDFDocument.Create(AOwner: TComponent);
begin
  inherited;
end;

destructor TgtExPDFDocument.Destroy;
var
  LI: Integer;
begin
  if Assigned(FFontList) then
  begin
    for LI := 0 to FFontList.Count - 1 do
      FFontList.Items[LI].Free;
    FFontList.Free;
  end;

  if Assigned(FStreamDoc) then
    FreeAndNil(FStreamDoc);
  inherited;
end;

function TgtExPDFDocument.GetFonts: TStrings;
var
  I: Integer;
  LS: string;
begin
  Result := TStringList.Create;
 // Result.NameValueSeparator := ':';
  for I := 0 to Screen.Fonts.Count - 1 do
  begin
    LS := StringReplace(Screen.Fonts.Strings[I], ' ', '', [rfReplaceAll]);
    Result.Values[LS] := Screen.Fonts.Strings[I];
  end;
end;

function TgtExPDFDocument.ExtractText(FromPages: string;
  WysiwygSpacing: Boolean = False; PageBreak: Boolean = True): TgtWideStringList;
var
  LPages: TgtPageNumbers;
  I, J: Integer;
  LTextExportDev: TgtTextExport;
  LStrList: TgtWideStringList;
begin
  Result := TgtWideStringList.Create;
  LPages := GetPages(FromPages, FPDDoc.PageCount);
  for I := 0 to (Length(LPages) - 1) do
  begin
    try
      LStrList := ExtractTextFromPage(LPages[I], WysiwygSpacing);
      for J := 0 to LStrList.Count - 1 do
        Result.Add(LStrList[J]);
      if PageBreak then
        Result.Add(FF);
    finally
      LStrList.Free;
    end;
  end;
end;

procedure TgtExPDFDocument.EmbedUsedTrueTypeFonts(AFontName: string;
  AFontStyles: TFontStyles);
begin
  if not Assigned(FPDDoc) then Exit;

  FPDDoc.EmbedUsedTrueTypeFonts(AFontName, AFontStyles);
end;

procedure TgtExPDFDocument.EmbedUsedTrueTypeFonts;
begin
  if not Assigned(FPDDoc) then Exit;
  
  FPDDoc.EmbedUsedTrueTypeFonts;
end;

procedure TgtExPDFDocument.ExportFDFDataTo(AFileName: string);
begin
  if not Assigned(FPDDoc) then Exit;
  FPDDoc.ExportToFDF(AFileName);
end;

function TgtExPDFDocument.ExtractText(FromPage, ToPage: Integer;
  WysiwygSpacing: Boolean = False; PageBreak: Boolean = True): TgtWideStringList;
var
  LStream: TStream;
  LPages: string;
begin
  Result := nil;
  if Assigned(FPDDoc) then
  begin
    LPages := IntToStr(FromPage) + '-' + IntToStr(ToPage);
    Result := ExtractText(LPages, WysiwygSpacing, PageBreak);
  end;
end;

function TgtExPDFDocument.ExtractTextFromPage(PageNo: Integer;
  WysiwygSpacing: Boolean = False): TgtWideStringList;
var
  LTextExportDev: TgtTextExport;
  I: Integer;
begin
  if Assigned(FPDDoc) then
  begin
    Result := TgtWideStringList.Create;
    LTextExportDev := TgtTextExport.Create(Result, WysiwygSpacing);
    try
      if not Assigned(FPDDoc.FontList) then
        FPDDoc.FontList := GetFonts;
      LTextExportDev.FontList := FPDDoc.FontList;
      FPDDoc.DisplayPage(LTextExportDev, PageNo, 72, 72, 0, True, False,
        False, False);
    finally
      FreeAndNil(LTextExportDev);
    end;
  end;

end;

procedure TgtExPDFDocument.FlattenFormFields(FieldNo: Integer);
var
  LFormField: TgtFormField;
begin
  LFormField := GetFormField(FieldNo);
  FlattenFormField(LFormField);
  RemoveFormField(FieldNo);
  FreeAndNil(LFormField);
end;

procedure TgtExPDFDocument.FlattenFormField(AFormField: TgtFormField);
var
  LTextWaterMark: TgtTextWatermarkTemplate;
  LRect: TgtRect;
  LFieldValue, LSelectedValue, LTempStr, LTempStr2: AnsiString;
  LFont: TFont;
  LI, LK, LN, LPageNo, LSPIndex, LPrevSPindex, LLFIndex, LPrevLFindex: Integer;
  LRadioItem: TgtPDRadioItem;
  LCurrUnit: TgtMeasurementUnit;
  LRectWidth, LTextHorzLen, LFontHeight: Double;
  LSPFound, LLFFound, LHidden : Boolean;

  function CalculateTopCorner: Double;
  var
    LRotation: Integer;
  begin
    Result := LRect.Top;
    LRotation := GetPageRotate(LPageNo);
    if (LRotation = 0) or (LRotation = 180) then
    begin
      if LRect.Top > LRect.Bottom then
        Result := LRect.Bottom
      else
        Result := LRect.Top;
    end;
    if (LRotation = 90) or (LRotation = 270) then
      Result := LRect.Top;
  end;

  function CalculateBottomCorner: Double;
  var
    LRotation: Integer;
  begin
    Result := LRect.Bottom;
    LRotation := GetPageRotate(LPageNo);
    if (LRotation = 0) or (LRotation = 180) then
    begin
      if LRect.Top > LRect.Bottom then
        Result := LRect.Bottom
      else
        Result := LRect.Top;
    end;
    if (LRotation = 90) or (LRotation = 270) then
      Result := LRect.Top;
  end;

  function CalculateLeftCorner(AText: AnsiString; AFont: TFont): Double;
  var
    LFont: TFont;
  begin
    Result := 0;
    if AFormField.Justification = gtCstPDFDoc.fjLeftJustified then
      Result := 0
    else if AFormField.Justification = gtCstPDFDoc.fjCentered then
      LRect.Left := AFormField.FFormField.Rect.Left +
        (Abs(AFormField.FFormField.Rect.Left - AFormField.FFormField.Rect.Right) -
        ((TextSize(LFieldValue, LFont).cx / 2) * 72/96))
    else if AFormField.Justification = gtCstPDFDoc.fjRightJustified then
      LRect.Left := AFormField.FFormField.Rect.Right - (TextSize(LFieldValue, LFont).cx * 72/96);
  end;

  function GetTextWidth(AText: AnsiString; AFont: TFont): Double;
  var
    LFontProc: TgtFontProcessor;
    ErrorCode: ErrorCodes;
  begin
    Result := 0;
    LFontProc := TgtFontProcessor.Create(AFont, ErrorCode);
    try
      if ErrorCode = Success then
      begin
        Result := LFontProc.GetTextWidth(AText);
      end
      else
      begin
        Result := PixelsToPoints(TextSize(AText, AFont).cx);
      end;
    finally
      FreeAndNil(LFontProc);
    end;
  end;

  function GetTextHeight(AText: AnsiString; AFont: TFont): Double;
  var
    LFontProc: TgtFontProcessor;
    ErrorCode: ErrorCodes;
  begin
    Result := 0;
    LFontProc := TgtFontProcessor.Create(AFont, ErrorCode);
    try
      if ErrorCode = Success then
      begin
        Result := LFontProc.GetTextHeight(AText);
      end
      else
      begin
        Result := PixelsToPoints(TextSize(AText, AFont).cy);
      end;
    finally
      FreeAndNil(LFontProc);
    end;
  end;

  procedure InsertText(AString: AnsiString);
  begin
    LTextWaterMark := TgtTextWatermarkTemplate.Create;

    LTextWaterMark.Overlay := True;
    LTextWaterMark.OpacityStroke := 100;

    LTextWaterMark.Text := AString;

    LTextWaterMark.X := LRect.Left + CalculateLeftCorner(AString, LFont) + 2;
    LTextWaterMark.Y := CalculateTopCorner + LFontHeight + (LFont.Size / 2) + 1;

    LTextWaterMark.Font := LFont;

    LCurrUnit := MeasurementUnit;
    MeasurementUnit := muPoints;

    //check for Hidden flag
    LHidden := False;
    if (afpHidden in AFormField.AdditionalPreferences) then
      LHidden := True;

    //Flatten only if not hidden and not invisible
    if ((AFormField.Visible) and not (LHidden)) then
      InsertWatermark(LTextWaterMark, IntToStr(AFormField.PageNum));

    MeasurementUnit := LCurrUnit;

    FreeAndNil(LTextWaterMark);
  end;

begin
  LFontHeight := 0;
  LFieldValue := '';
  LFont := TFont.Create;

  if Assigned(AFormField.FFormField) then
  begin
    LPageNo := AFormField.PageNum;
    //Common attrributes
    //Get the text to be displayed when flattened
    LFieldValue := AFormField.FieldValue;

    //Get the Rect for positioning the flattened FF
    if ((AFormField.FFormField.FormFieldType <> ftRadio){ and
      (AFormField.FFormField.FormFieldType <> ftListBox)}) then
    begin
      LRect.Top := AFormField.FFormField.Rect.Top;
      LRect.Left := AFormField.FFormField.Rect.Left;
      LRect.Right := AFormField.FFormField.Rect.Right;
      LRect.Bottom := AFormField.FFormField.Rect.Bottom;
    end;

    //Get the Font Info
    LFont.Name := AFormField.DefaultFont.Name;
    LFont.Size := Round(AFormField.DefaultFont.ActualSize);
    LFont.Color := StringToColor(AFormField.DefaultFont.Color);
    LFont.Style := THackgtPDFormField(AFormField.FFormField).Font.Style;

    case AFormField.FFormField.FormFieldType of
      ftButton:
      begin
        LFieldValue := TgtPDFormPushButton(AFormField.FFormField).NormalCaption;

        InsertText(LFieldValue);
      end;
      ftRadio:
      begin
        if ((AFormField.FieldValue <> '') and
          (TgtPDFormRadioButton(AFormField.FFormField).AtleastOneSelectedItem)) then
        begin
          LRadioItem := TgtPDFormRadioButton(AFormField.FFormField).
            GetRadioItem(TgtPDFormRadioButton(AFormField.FFormField).SelectedItemIndex);

          if Assigned(LRadioItem) then
          begin
            LRect.Left := LRadioItem.Rect.Left;
            LRect.Top := LRadioItem.Rect.Top;
            LRect.Right := LRadioItem.Rect.Right;
            LRect.Bottom := LRadioItem.Rect.Bottom;
          //LRect.Top := (LRadioItem.Rect.Bottom + LRadioItem.Rect.Top) / 2;
          end
          else
          begin
            LRect.Top := AFormField.FFormField.Rect.Top;
            LRect.Left := AFormField.FFormField.Rect.Left;
            LRect.Right := AFormField.FFormField.Rect.Right;
            LRect.Bottom := AFormField.FFormField.Rect.Bottom;
          end;

          case TgtPDFormRadioButton(AFormField.FFormField).Symbol of
            csCheck: LFieldValue := '4';
            csCircle: LFieldValue := 'l';
            csCross: LFieldValue := '6';
            csDiamond: LFieldValue := 'u';
            csSquare: LFieldValue := 'n';
            csStar: LFieldValue := 'H';
          end;
          //LRect.Top := LRect.Top - ConvertToPDFUnit(muPixels, LFont.Size) / 2;

          if LFont.Name <> 'ZapfDingbats' then
            LFont.Name := 'ZapfDingbats';
          if LFont.Size = 0 then
            LFont.Size := 8;

          InsertText(LFieldValue);
        end;
      end;
      ftCheckBox:
      begin
        LFieldValue := '';
        if TgtPDFormCheckBox(AFormField.FFormField).IsChecked then
        begin

          case TgtPDFormCheckBox(AFormField.FFormField).Symbol of
            csCheck: LFieldValue := '4';
            csCircle: LFieldValue := 'l';
            csCross: LFieldValue := '6';
            csDiamond: LFieldValue := 'u';
            csSquare: LFieldValue := 'n';
            csStar: LFieldValue := 'H';
          end;
          //LRect.Top := LRect.Top - ConvertToPDFUnit(muPixels, LFont.Size) / 2;

          InsertText(LFieldValue);
        end;
      end;
      ftText:
      begin
        //WrapTextIntoLines
        LRectWidth := Abs(LRect.Left - LRect.Right);
        //check if textwidth > rectwidth
        if (GetTextWidth(LFieldValue, LFont)) > LRectWidth then
        begin
          //initialize the variables
          LTempStr := '';
          LTextHorzLen := 0;
          LK := 1;
          LSPFound := False;
          LSPIndex := 0;
          LPrevSPindex := 0;
          LLFFound := False;
          LLFIndex := 0;
          LPrevLFindex := 0;
          //process each char of the text
          while LK <= Length(LFieldValue) do
          begin
            //if character is Space
            if LFieldValue[LK] = SP then
            begin
              LSPIndex := LK;
              LSPFound := True;
            end;
            //if character is linefeed
            if LFieldValue[LK] = LF then
            begin
              LLFIndex := LK;
              LLFFound := True;
            end;
            //appending each char to tempstr
            LTempStr := LTempStr + LFieldValue[LK];
            //adding up each char width in points
            LTextHorzLen := LTextHorzLen + (GetTextWidth(LFieldValue[LK], LFont));

            //if width(ltempstr) exceeds rectwidth
            if (LTextHorzLen >= LRectWidth) then
            begin
              //handling the last previous SP and LF in tempstr
              if ( LSPFound and (not LLFFound) ) then
              begin
                LTempStr2 := '';
                for LN := 1 to (LSPIndex - LPrevSPIndex) do
                begin
                  LTempStr2 := LTempStr2 + LTempStr[LN];
                end;

                LTempStr := LTempStr2;
                LK := LSPIndex;
                LPrevSPIndex := LSPIndex;
                LTempStr2 := '';
                LSPFound := false;
              end
              else if LLFFound then
              begin
                LTempStr2 := '';
                for LN := 1 to (LLFIndex - LPrevLFindex) do
                begin
                  LTempStr2 := LTempStr2 + LTempStr[LN];
                end;

                LTempStr := LTempStr2;
                LK := LLFIndex;
                LPrevLFindex := LLFIndex;
                LTempStr2 := '';
                LLFFound := false;
              end;

              //adding the text watermark
              InsertText(LTempStr);
              //LFontHeight := LFontHeight + LFont.Size;
              LFontHeight := LFontHeight + GetTextHeight(LTempStr, LFont) + 1;
              LTempStr := '';
              LTextHorzLen := 0;
            end;

            if (LK = Length(LFieldValue)) and (LTempStr <> '') then
              InsertText(LTempStr);
            Inc(LK);
          end;//end of for
        end
        //if textwidth <= rectwidth
        else
          InsertText(LFieldValue);
      end;
      ftListBox:
      begin
  //      LRect.Left := AFormField.FFormField.Rect.Left;
  //      LRect.Top := AFormField.FFormField.Rect.Top;
        InsertText(LFieldValue);
      end;
      ftComboBox:
      begin
        InsertText(LFieldValue);
      end;
    end;
  end;

  if Assigned(LFont) then
    FreeAndNil(LFont);
end;

procedure TgtExPDFDocument.FlattenFormFieldByPage(APageNo: Integer);
var
  LI: Integer;
  LFormField: TgtFormField;
begin
  if not Assigned(FPDDoc) then Exit;
  for LI := FPDDoc.Pages[APageNo].GetFormFieldCount downto 1 do
  begin
    LFormField := TgtFormField.Create;
    LFormField.FFormField := FPDDoc.Pages[APageNo].GetFormField(LI);
    LFormField.FPageNum := APageNo;
    if Assigned(LFormField.FFormField) then
    begin
      FlattenFormField(LFormField);
      FPDDoc.Pages[APageNo].RemoveFormField(LI);
    end;
    FreeAndNil(LFormField);
  end;
end;

procedure TgtExPDFDocument.FlattenFormFields(FieldName: string);
var
  LFormField: TgtFormField;
begin
  LFormField := GetFormField(FieldName);
  try
    if Assigned(LFormField) then
    begin
      FlattenFormField(LFormField);
      RemoveFormField(FieldName);
    end;
  finally
    if Assigned(LFormField) then
      FreeAndNil(LFormField);
  end;
end;

procedure TgtExPDFDocument.FlattenFormFieldsOnPage(APageRange: string);
var
  LPages: TgtPageNumbers;
  LI: Integer;
begin
  LPages := GetPages(APageRange, PageCount);
  for LI := 0 to Length(LPages) - 1 do
  begin
    FlattenFormFieldByPage(LPages[LI]);
  end;
end;

function TgtExPDFDocument.GetFormField(FieldNo: Integer): TgtFormField;
var
  LPageIterator, LFieldIterator, LFieldCount: Integer;
begin
  if not Assigned(FPDDoc) then
  begin
    Result := nil;
    Exit;
  end;

  try
    LFieldCount := 0;
    Result := TgtFormField.Create;
    //Outer loop iterates through the pages of PDF document
    for LPageIterator := 1 to FPDDoc.PageCount do
    begin
      //Inner loop iterates through the fields in a page
      for LFieldIterator := 1 to FPDDoc.Pages[LPageIterator].GetFormFieldCount do
      begin
        Inc(LFieldCount);
        if LFieldCount = FieldNo then
        begin
          //Get the form field from PDF processor
          Result.FFormField := FPDDoc.GetFormField(LPageIterator, LFieldIterator);
          Result.FPageNum := LPageIterator;
          Exit;
        end; //end of outer if
      end; //end of inner for
    end; //end of outer for
  except
    Result := nil;
  end; //end of try
end;

////function TgtExPDFDocument.GetAllInstalledFonts: TStrings;
//////var
//////  I: Integer;
//////  LS: string;
////begin
////  Result := nil;
//////  if not Assigned(FFontList) then
//////  begin
//////    FFontList := TStringList.Create;
//////    FFontList.NameValueSeparator := ':';
//////
//////    for I := 0 to Screen.Fonts.Count - 1 do
//////    begin
//////      LS := StringReplace(Screen.Fonts.Strings[I], ' ', '', [rfReplaceAll]);
//////      FFontList.Values[LS] := Screen.Fonts.Strings[I];
//////    end;
//////  end;
//////  Result := FFontList;
////end;

function TgtExPDFDocument.GetAnnotations(PageNum: Integer): TgtAnnotationList;
var
  LList: TObjectList;
  I: Integer;
  LAnnot: TgtPDFAnnotation;
begin
  if not Assigned(FPDDoc) then
  begin
    Result := nil;
    Exit;
  end;

  LList := FPDDoc.Pages[PageNum].GetAnnots;

  if Assigned(FAnnotList) then
    FreeAndNil(FAnnotList);

  FAnnotList := TgtAnnotationList.Create;

  for I := 0 to LList.Count - 1 do
  begin
    LAnnot := TgtPDFAnnotation.Create(TgtPDAnnot(LList.Items[I]));
    FAnnotList.Add(LAnnot);
  end;

  Result := FAnnotList;
end;

function TgtExPDFDocument.GetFontList: TgtPDFFontList;
var
  LFontObject: TgtPDFFontObject;
  LFontList: TObjectList;
  LI: Integer;
begin
  if not Assigned(FPDDoc) then
  begin
    Result := nil;
    Exit;
  end;

  if not Assigned(FFontList) then
  begin
    LFontList := FPDDoc.GetFontList();

    FFontList := TgtPDFFontList.Create;

    for LI := 0 to LFontList.Count - 1 do
    begin
      LFontObject := TgtPDFFontObject.Create(TgtPDFont(LFontList.Items[LI]));
      FFontList.Add(LFontObject);
    end;

  end;

  Result := FFontList;
end;

function TgtExPDFDocument.GetFontList(APageNo: Integer): TgtPDFFontList;
var
  LFontObject: TgtPDFFontObject;
  LFontList: TObjectList;
  LI: Integer;
begin
  if not Assigned(FPDDoc) then
  begin
    Result := nil;
    Exit;
  end;

  if not Assigned(FFontList) then
  begin
    LFontList := FPDDoc.GetFontList(APageNo);

    FFontList := TgtPDFFontList.Create;

    for LI := 0 to LFontList.Count - 1 do
    begin
      LFontObject := TgtPDFFontObject.Create(TgtPDFont(LFontList.Items[LI]));
      FFontList.Add(LFontObject);
    end;
  end;

  Result := FFontList;
end;

function TgtExPDFDocument.GetFormField(FieldName: string): TgtFormField;
var
  LPageIterator, LFieldIterator, FFormFieldCount: Integer;
  LgtFormField: TgtFormField;
begin
  if not Assigned(FPDDoc) then
  begin
    Result := nil;
    Exit;
  end;

  FFormFieldCount := 0;

  for LPageIterator := 1 to FPDDoc.PageCount do
  begin
    for LFieldIterator := FPDDoc.Pages[LPageIterator].GetFormFieldCount downto 1 do
    begin
      Inc(FFormFieldCount);
      LgtFormField := GetFormField(FFormFieldCount);
      if LowerCase(LgtFormField.FieldName) = LowerCase(FieldName) then
      begin
        Result := LgtFormField;
        Result.FPageNum := LPageIterator;
        Exit;
      end //end of if
      else
        if Assigned(LgtFormField) then
          FreeAndNil(LgtFormField);
    end; //end of inner for
  end; //end of outer for
  raise EFieldNotFound.CreateFmt(SFieldNameError, [FieldName]);
end;
//end of function

procedure TgtExPDFDocument.InsertAnnotation(Annot: TgtPDFAnnotation;
  PageNumber: Integer);
var
  LAction: TgtPDFAction;
  LDoc: TgtPDDocument;
begin
  if not Assigned(FPDDoc) then
  begin
    Exit;
  end;

  if Annot.AnnotType = annotLink then
  begin
    LAction := TgtPDFLinkAnnotation(Annot).Action;
    if (THackgtPDFAction(LAction).FAction.ActionType = actionGoTo) or
      (THackgtPDFAction(LAction).FAction.ActionType = actionGoToR)  then
    begin
      AddDestination(LAction);
    end;
  end;
  Annot.MeasurementUnit := Self.MeasurementUnit;
  if Annot is TgtPDFLineAnnotation then
    FPDDoc.Pages[PageNumber].InsertAnnotation(TgtPDFLineAnnotation(Annot).FAnnot)
  else if Annot is TgtPDFCircleAnnotation then
    FPDDoc.Pages[PageNumber].InsertAnnotation(TgtPDFCircleAnnotation(Annot).FAnnot)
  else if Annot is TgtPDFSquareAnnotation then
    FPDDoc.Pages[PageNumber].InsertAnnotation(TgtPDFSquareAnnotation(Annot).FAnnot)
  else if Annot is TgtPDFPolygonAnnotation then
    FPDDoc.Pages[PageNumber].InsertAnnotation(TgtPDFPolygonAnnotation(Annot).FAnnot)
  else if Annot is TgtPDFPolylineAnnotation then
    FPDDoc.Pages[PageNumber].InsertAnnotation(TgtPDFPolylineAnnotation(Annot).FAnnot)
  else if Annot is TgtPDFLinkAnnotation then
    FPDDoc.Pages[PageNumber].InsertAnnotation(TgtPDFLinkAnnotation(Annot).FAnnot)
  else if Annot is TgtPDFCaretAnnotation then
    FPDDoc.Pages[PageNumber].InsertAnnotation(TgtPDFCaretAnnotation(Annot).FAnnot)
  else if Annot is TgtPDFStampAnnotation then
    FPDDoc.Pages[PageNumber].InsertAnnotation(TgtPDFStampAnnotation(Annot).FAnnot)
  else if Annot is TgtPDFTextAnnotation then
    FPDDoc.Pages[PageNumber].InsertAnnotation(TgtPDFTextAnnotation(Annot).FAnnot)
  else if Annot is TgtPDFFreeTextAnnotation then
    FPDDoc.Pages[PageNumber].InsertAnnotation(TgtPDFFreeTextAnnotation(Annot).FAnnot)
  else if Annot is TgtPDFInkAnnotation then
    FPDDoc.Pages[PageNumber].InsertAnnotation(TgtPDFInkAnnotation(Annot).FAnnot)
  else if Annot is TgtPDFMarkUpAnnotation then
    FPDDoc.Pages[PageNumber].InsertAnnotation(TgtPDFMarkUpAnnotation(Annot).FAnnot)
  else if Annot is TgtPDFFileAttachment then
    FPDDoc.Pages[PageNumber].InsertAnnotation(TgtPDFFileAttachment(Annot).FAnnot)
end;

procedure TgtExPDFDocument.InsertBlankPageAt(APageNumber: Integer; PageWidth,
  PageHeight: Double);
var
  LPageSize: TgtPDRect;
  LDoc: TMemoryStream;
  LStr: string;
  LPageNo: Integer;
begin
  //Insert a blank doc from the template if the doc is not loaded.
  if not Assigned(FPDDoc) then
  begin
    if Assigned(FStreamDoc) then
      FreeAndNil(FStreamDoc);
    FStreamDoc := TMemoryStream.Create;
    LStr := BlankDoc;
    FStreamDoc.Write(LStr[1], Length(BlankDoc));
    FStreamDoc.Position := 0;
    LoadFromStream(FStreamDoc);
    Exit;
  end;

  //Specify size of the Page i.e mediabox
  LPageSize := TgtPDRect.Create;
  try
    LPageSize.Left := 0;
    LPageSize.Top := 0;
    LPageSize.Right := ConvertToPDFUnit(MeasurementUnit, PageWidth);
    LPageSize.Bottom := ConvertToPDFUnit(MeasurementUnit, PageHeight);
    if Self.IsLoaded then
    //Create a blank page at the specified location
      FPDDoc.CreatePage(APageNumber, LPageSize);
  finally
    LPageSize.Free;
  end;
end;

procedure TgtExPDFDocument.InsertFileAttachment(AFile: TgtPDFFileAttachment;
  PageNumber: Integer);
begin
  InsertAnnotation(AFile, PageNumber);
end;

procedure TgtExPDFDocument.RemoveExistingDocActions(
  ATriggerType: TgtDocActionTriggers);
var
  LTrigger: TgtDocActionTrigger;
begin
  if not Assigned(FPDDoc) then
  begin
    Exit;
  end; 
  case ATriggerType of
    aatBeforeDocClose: LTrigger := atBeforeDocClose;
    aatBeforeDocSave: LTrigger := atBeforeDocSave;
    aatAfterDocSave: LTrigger := atAfterDocSave;
    aatBeforeDocPrint: LTrigger := atBeforeDocPrint;
    aatAfterDocPrint: LTrigger := atAfterDocPrint;
  end;
  FPDDoc.RemoveAction(LTrigger);
end;

procedure TgtExPDFDocument.RemoveExistingPageActions(APageNo: Integer;
  ATriggerType: TgtPageActionTriggers);
begin
  if not Assigned(FPDDoc) then
  begin
    Exit;
  end;
  case ATriggerType of
    aatBeforePageOpen: FPDDoc.Pages[APageNo].RemoveAction(atBeforePageOpen);
    aatAfterPageClose: FPDDoc.Pages[APageNo].RemoveAction(atAfterPageclose);
  end;
end;

procedure TgtExPDFDocument.SaveFileAttachmentTo(APathName: string);
var
  I, LCount, LJ: Integer;
  LAttachment: TgtPDFileAttachmentAnnot;
  LNewFileName, LPath: string;
  LFileStream: TFileStream;
begin
  if Assigned(FPDDoc) then
  begin
    for I := 1 to PageCount do
    begin
      LCount := FPDDoc.Pages[I].AttachmentCount;
      for LJ := 0 to LCount - 1 do
      begin
        LNewFileName := '';
        LPath := APathName;
        LAttachment := FPDDoc.Pages[I].FileAttachment[LJ];
        if Assigned(FOnAttachmentNameChange) then
          FOnAttachmentNameChange(Self, LAttachment.FileName, LNewFileName);
        if LNewFileName <> '' then
          LPath := LPath + '\' + LNewFileName
        else
          LPath := LPath + '\' + LAttachment.FileName;
        LFileStream := TFileStream.Create(LPath, fmCreate);
        FPDDoc.SaveAttachments(LFileStream, I, LJ);
      end;
    end;
  end;
end;

procedure TgtExPDFDocument.Stitch(AStitchToPageNo, AStitchFromPageNo: Integer);
begin
  if Assigned(FPDDoc) then
  begin
    FPDDoc.Stitch(AStitchToPageNo, AStitchFromPageNo);
  end;
end;

procedure TgtExPDFDocument.StitchSideBySide(AStitchToPageNo,
  AStitchFromPageNo: Integer);
begin
  if Assigned(FPDDoc) then
  begin
    FPDDoc.StitchPagesSideBySide(AStitchToPageNo, AStitchFromPageNo);
  end;
end;

procedure TgtExPDFDocument.TextOut(HTMLStr: WideString; XPos, YPos: Double);
begin
  TextOut(HTMLStr, '1-' + IntToStr(PageCount), XPos, YPos);
end;

procedure TgtExPDFDocument.TextOut(HTMLStr: WideString; PageRange: string; XPos,
  YPos: Double);
var
  FontList: TStack;
  LFont: TFont;
  LI, LS: Integer;
  LText, LCmp: WideString;
  LWText: TgtTextWatermarkTemplate;
  muCurr: TgtMeasurementUnit;
begin
  muCurr := Self.MeasurementUnit;
  case muCurr of
    muInches:
      begin
        XPos := XPos * CInchesToPoints;
        YPos := YPos * CInchesToPoints;
      end;
    muMM:
      begin
        XPos := XPos * CMMToPoints;
        YPos := YPos * CMMToPoints;
      end;
    muTwips:
      begin
        XPos := XPos * CTwipsToPoints;
        YPos := YPos * CTwipsToPoints;
      end;
  end;
  if Ord(muCurr) <> Ord(muPixels) then
  begin
    XPos := PointsToPixels(XPos);
    YPos := PointsToPixels(YPos);
  end;
  self.MeasurementUnit := muPixels;
  FontList := TStack.Create;
  LFont := TFont.Create;
  //LFont.Name := 'Times New Roman';
  LFont.Name := 'Arial';
  LFont.Charset := ANSI_CHARSET;
  LFont.Size := 12;
  FontList.Push(LFont);
  LI := 1;
  LText := '';
  LWText := TgtTextWatermarkTemplate.Create;
  LWText.X := XPos;
  LWText.Y := YPos;
  LWText.Text := '';
  LWText.Font := LFont;
  while LI <= Length(HTMLStr) do
  begin
    if HTMLStr[LI] = '<' then
    begin
      LCmp := '';
      while (HTMLStr[LI] <> '>') and (HTMLStr[LI] <> ' ') and (LI <= Length(HTMLStr)) do
      begin
        LCmp := LCmp + HTMLStr[LI];
        Inc(LI, 1);
      end;
      if (AnsiCompareText(LCmp, '</B') <> 0) and (AnsiCompareText(LCmp, '</I') <> 0)
        and (AnsiCompareText(LCmp, '</U') <> 0) and (AnsiCompareText(LCmp, '</S') <> 0)
        and (AnsiCompareText(LCmp, '</FONT') <> 0) and (AnsiCompareText(LCmp, '<B') <> 0)
        and (AnsiCompareText(LCmp, '<I') <> 0) and (AnsiCompareText(LCmp, '<U') <> 0)
        and (AnsiCompareText(LCmp, '<S') <> 0)
        and (AnsiCompareText(LCmp, '<FONT') <> 0) then
      begin
        LText := LText + LCmp;
        while (HTMLStr[LI] <> '<') and (LI <= Length(HTMLStr)) do
        begin
          LText := LText + HTMLStr[LI];
          Inc(LI, 1);
        end;
        Dec(LI, 1);
      end
      else
      begin
        LFont := TFont.Create;
        LFont.Assign(TFont(FontList.Peek));
        if (LText <> '') then
        begin
          with LWText do
          begin
            RenderMode := TgtRenderMode(trmFill);
            Overlay := True;
            HorizPos := hpCustom;
            VertPos := vpCustom;
            X := X + (TextSize(Text, Font).cx);
//            if LWText.Text <> '' then
//              Y := Y {+ TextSize(Text, Font).cy} - TextSize(LText, LFont).cy
//            else
            Y := YPos;
            Font := LFont;
            Text := LText;
          end;
          InsertWatermark(LWText, PageRange);
          LText := '';
        end;
        if AnsiCompareText(LCmp, '</B') = 0 then
          TFont(FontList.Peek).Style := TFont(FontList.Peek).Style - [fsBold]
        else if AnsiCompareText(LCmp, '</U') = 0 then
          TFont(FontList.Peek).Style := TFont(FontList.Peek).Style - [fsUnderline]
        else if AnsiCompareText(LCmp, '</I') = 0 then
          TFont(FontList.Peek).Style := TFont(FontList.Peek).Style - [fsItalic]
        else if AnsiCompareText(LCmp, '</S') = 0 then
          TFont(FontList.Peek).Style := TFont(FontList.Peek).Style - [fsStrikeOut]
        else if (AnsiCompareText(LCmp, '</Font') = 0) and (FontList.Count > 1) then
          TFont(FontList.Pop).Free;
      end;
      if AnsiCompareText(LCmp, '<FONT') = 0 then
      begin
        LFont := TFont.Create;
        //LFont.Name := 'Times New Roman';
        LFont.Name := 'Arial';
        LFont.Size := 12;
        LFont.Charset := ANSI_CHARSET;
        LFont.Style := TFont(FontList.Peek).Style;
        while HTMLStr[LI] <> '>' do
        begin
          while (HTMLStr[LI] = ' ') or (HTMLStr[LI] = '"') do Inc(LI, 1);
          LCmp := '';
          while (HTMLStr[LI] <> ' ') and (HTMLStr[LI] <> '=') and (HTMLStr[LI] <> '>') do
          begin
            LCmp := LCmp + HTMLStr[LI];
            Inc(LI, 1);
          end;
          if AnsiCompareText(LCmp, 'SIZE') = 0 then
          begin
            while HTMLStr[LI] = ' ' do Inc(LI, 1);
            if HTMLStr[LI] = '=' then
            begin
              Inc(LI, 1);
              while (HTMLStr[LI] = ' ') or (HTMLStr[LI] = '"') do Inc(LI, 1);
              LCmp := '';
              while (HTMLStr[LI] <> ' ') and (HTMLStr[LI] <> '"') and (HTMLStr[LI] <> '>') do
              begin
                LCmp := LCmp + HTMLStr[LI];
                Inc(LI, 1);
              end;
              LS := StrToInt(LCmp);
              LFont.Size := LS;
            end;
          end
          else if AnsiCompareText(LCmp, 'COLOR') = 0 then
          begin
            while HTMLStr[LI] = ' ' do Inc(LI, 1);
            if HTMLStr[LI] = '=' then
            begin
              Inc(LI, 1);
              while (HTMLStr[LI] = ' ') or (HTMLStr[LI] = '"') do Inc(LI, 1);
              LCmp := '';
              while (HTMLStr[LI] <> ' ') and (HTMLStr[LI] <> '"') and (HTMLStr[LI] <> '>') do
              begin
                LCmp := LCmp + HTMLStr[LI];
                Inc(LI, 1);
              end;
            end;
            if AnsiCompareText(LCmp, 'aqua') = 0 then LFont.Color := clAqua
            else if AnsiCompareText(LCmp, 'black') = 0 then LFont.Color := clBlack
            else if AnsiCompareText(LCmp, 'blue') = 0 then LFont.Color := clBlue
            else if AnsiCompareText(LCmp, 'fuchsia') = 0 then LFont.Color := clFuchsia
            else if AnsiCompareText(LCmp, 'green') = 0 then LFont.Color := clGreen
            else if AnsiCompareText(LCmp, 'gray') = 0 then LFont.Color := clGray
            else if AnsiCompareText(LCmp, 'lime') = 0 then LFont.Color := clLime
            else if AnsiCompareText(LCmp, 'maroon') = 0 then LFont.Color := clMaroon
            else if AnsiCompareText(LCmp, 'navy') = 0 then LFont.Color := clNavy
            else if AnsiCompareText(LCmp, 'olive') = 0 then LFont.Color := clOlive
            else if AnsiCompareText(LCmp, 'purple') = 0 then LFont.Color := clPurple
            else if AnsiCompareText(LCmp, 'red') = 0 then LFont.Color := clRed
            else if AnsiCompareText(LCmp, 'silver') = 0 then LFont.Color := clSilver
            else if AnsiCompareText(LCmp, 'teal') = 0 then LFont.Color := clTeal
            else if AnsiCompareText(LCmp, 'white') = 0 then LFont.Color := clWhite
            else if AnsiCompareText(LCmp, 'yellow') = 0 then LFont.Color := clYellow
            else
            begin
              LCmp := '$00' + LCmp[6] + LCmp[7] + LCmp[4] + LCmp[5] + LCmp[2] + LCmp[3];
              try
                LFont.Color := StrToInt(LCmp);
              except on EConvertError do LFont.Color := clBlack;
              end;
            end;
          end
          else if AnsiCompareText(LCmp, 'FACE') = 0 then
          begin
            while HTMLStr[LI] = ' ' do Inc(LI, 1);
            if HTMLStr[LI] = '=' then
            begin
              Inc(LI, 1);
              while (HTMLStr[LI] = ' ') or (HTMLStr[LI] = '"') do Inc(LI, 1);
              LCmp := '';
              while (HTMLStr[LI] <> '"') do
              begin
                LCmp := LCmp + HTMLStr[LI];
                Inc(LI, 1);
              end;
              LFont.Name := LCmp;
            end;
          end
          else if AnsiCompareText(LCmp, 'CHARSET') = 0 then
          begin
            while HTMLStr[LI] = ' ' do Inc(LI, 1);
            if HTMLStr[LI] = '=' then
            begin
              Inc(LI, 1);
              while (HTMLStr[LI] = ' ') or (HTMLStr[LI] = '"') do Inc(LI, 1);
              LCmp := '';
              while (HTMLStr[LI] <> '"') do
              begin
                LCmp := LCmp + HTMLStr[LI];
                Inc(LI, 1);
              end;
              if AnsiCompareText(LCmp, 'ANSI_CHARSET') = 0 then LFont.Charset := ANSI_CHARSET
              else if AnsiCompareText(LCmp, 'RUSSIAN_CHARSET') = 0 then LFont.Charset := RUSSIAN_CHARSET
              else if AnsiCompareText(LCmp, 'SYMBOL_CHARSET') = 0 then LFont.Charset := SYMBOL_CHARSET
              else if AnsiCompareText(LCmp, 'SHIFTJIS_CHARSET') = 0 then LFont.Charset := SHIFTJIS_CHARSET
              else if AnsiCompareText(LCmp, 'HANGEUL_CHARSET') = 0 then LFont.Charset := HANGEUL_CHARSET
              else if AnsiCompareText(LCmp, 'GB2312_CHARSET') = 0 then LFont.Charset := GB2312_CHARSET
              else if AnsiCompareText(LCmp, 'CHINESEBIG5_CHARSET') = 0 then LFont.Charset := CHINESEBIG5_CHARSET
              else if AnsiCompareText(LCmp, 'OEM_CHARSET') = 0 then LFont.Charset := OEM_CHARSET
              else if AnsiCompareText(LCmp, 'JOHAB_CHARSET') = 0 then LFont.Charset := JOHAB_CHARSET
              else if AnsiCompareText(LCmp, 'HEBREW_CHARSET') = 0 then LFont.Charset := HEBREW_CHARSET
              else if AnsiCompareText(LCmp, 'ARABIC_CHARSET') = 0 then LFont.Charset := ARABIC_CHARSET
              else if AnsiCompareText(LCmp, 'GREEK_CHARSET') = 0 then LFont.Charset := GREEK_CHARSET
              else if AnsiCompareText(LCmp, 'TURKISH_CHARSET') = 0 then LFont.Charset := TURKISH_CHARSET
              else if AnsiCompareText(LCmp, 'VIETNAMESE_CHARSET') = 0 then LFont.Charset := VIETNAMESE_CHARSET
              else if AnsiCompareText(LCmp, 'EASTEUROPE_CHARSET') = 0 then LFont.Charset := EASTEUROPE_CHARSET
              else if AnsiCompareText(LCmp, 'DEFAULT_CHARSET') = 0 then LFont.Charset := DEFAULT_CHARSET
              else if AnsiCompareText(LCmp, 'MAC_CHARSET') = 0 then LFont.Charset := MAC_CHARSET
              else if AnsiCompareText(LCmp, 'BALTIC_CHARSET') = 0 then LFont.Charset := BALTIC_CHARSET
              else if AnsiCompareText(LCmp, 'THAI_CHARSET') = 0 then LFont.Charset := THAI_CHARSET;
            end;
          end;
        end;
        FontList.Push(LFont);
      end
      else if AnsiCompareText(LCmp, '<B') = 0 then
      begin
        TFont(FontList.Peek).Style := TFont(FontList.Peek).Style + [fsBold];
        while HTMLStr[LI] <> '>' do Inc(LI, 1);
      end
      else if AnsiCompareText(LCmp, '<U') = 0 then
      begin
        TFont(FontList.Peek).Style := TFont(FontList.Peek).Style + [fsUnderline];
        while HTMLStr[LI] <> '>' do Inc(LI, 1);
      end
      else if AnsiCompareText(LCmp, '<I') = 0 then
      begin
        TFont(FontList.Peek).Style := TFont(FontList.Peek).Style + [fsItalic];
        while HTMLStr[LI] <> '>' do Inc(LI, 1);
      end
      else if AnsiCompareText(LCmp, '<S') = 0 then
      begin
        TFont(FontList.Peek).Style := TFont(FontList.Peek).Style + [fsStrikeOut];
        while HTMLStr[LI] <> '>' do Inc(LI, 1);
      end;
      Inc(LI, 1);
    end
    else
    begin
      LText := LText + HTMLStr[LI];
      Inc(LI, 1);
    end;
  end;
  LFont := TFont.Create;
  LFont.Assign(TFont(FontList.Peek));
  if (LText <> '') then
  begin
    with LWText do
    begin
      RenderMode := TgtRenderMode(trmFill);
      Overlay := True;
      HorizPos := hpCustom;
      VertPos := vpCustom;
      X := X + (TextSize(Text, Font).cx);
//      if LWText.Text <> '' then
//        Y := Y {+ TextSize(Text, Font).cy} - TextSize(LText, LFont).cy
//      else
      Y := YPos;
      Font := LFont;
      Text := LText;
    end;
    InsertWatermark(LWText, PageRange);
    LText := '';
  end;
  LWText.Free;
  while FontList.Count <> 0 do
    TFont(FontList.Pop).Free;
  if Assigned(LFont) then FreeAndNil(LFont);
  if Assigned(FontList) then FreeAndNil(FontList);
  Self.MeasurementUnit := muCurr;
end;

{ TgtPDFFormTextField }

constructor TgtPDFFormTextField.Create;
begin
  inherited;
  FFormField := TgtPDFormTextField.Create;
end;

destructor TgtPDFFormTextField.Destroy;
begin
  inherited;
end;

function TgtPDFFormTextField.GetIsComb: Boolean;
begin
  Result := TgtPDFormTextField(FFormField).IsComb;
end;

function TgtPDFFormTextField.GetIsDoNotScroll: Boolean;
begin
  Result := TgtPDFormTextField(FFormField).IsDoNotScroll;
end;

function TgtPDFFormTextField.GetIsDoNotSpellCheck: Boolean;
begin
  Result := TgtPDFormTextField(FFormField).IsDoNotSpellCheck;
end;

function TgtPDFFormTextField.GetIsFileSelect: Boolean;
begin
  Result := TgtPDFormTextField(FFormField).IsFileSelect;
end;

function TgtPDFFormTextField.GetIsMultiline: Boolean;
begin
  Result := TgtPDFormTextField(FFormField).IsMultiLine;
end;

function TgtPDFFormTextField.GetIsPassword: Boolean;
begin
  Result := TgtPDFormTextField(FFormField).IsPasswordField;
end;

function TgtPDFFormTextField.GetMaxLength: Integer;
begin
  Result := TgtPDFormTextField(FFormField).MaxLength;
end;

procedure TgtPDFFormTextField.SetIsComb(const Value: Boolean);
begin
  TgtPDFormTextField(FFormField).IsComb := Value;
end;

procedure TgtPDFFormTextField.SetIsDoNotScroll(const Value: Boolean);
begin
  TgtPDFormTextField(FFormField).IsDoNotScroll := Value;
end;

procedure TgtPDFFormTextField.SetIsDoNotSpellCheck(const Value: Boolean);
begin
  TgtPDFormTextField(FFormField).IsDoNotSpellCheck := Value;
end;

procedure TgtPDFFormTextField.SetIsFileSelect(const Value: Boolean);
begin
  TgtPDFormTextField(FFormField).IsFileSelect := Value;
end;

procedure TgtPDFFormTextField.SetIsMultiline(const Value: Boolean);
begin
  TgtPDFormTextField(FFormField).IsMultiLine := Value;
end;

procedure TgtPDFFormTextField.SetIsPassword(const Value: Boolean);
begin
  TgtPDFormTextField(FFormField).IsPasswordField := Value;
end;

procedure TgtPDFFormTextField.SetMaxLength(const Value: Integer);
begin
  TgtPDFormTextField(FFormField).MaxLength := Value;
end;

{ TgtBorderAttribute }

constructor TgtBorderAttribute.Create;
begin
  FBorderWidth := 1;
  FBorderStyle := bsSolid;
end;

constructor TgtBorderAttribute.Create(AFormField: TgtPDFormField);
begin
  FFormField := AFormField;
end;

destructor TgtBorderAttribute.Destroy;
begin
  inherited;
end;

function TgtBorderAttribute.GetBorderStyle: TgtAnnotBorderStyle;
begin
  if Assigned(FFormField) then
  begin
    case FFormField.BorderStyle of
      absSolid: Result := bsSolid;
      absDashed: Result := bsDashed;
      absBeveled: Result := bsBeveled;
      absInset: Result := bsInset;
      absUnderline: Result := bsUnderline;
    end;
  end
  else
    Result := FBorderStyle;
end;

function TgtBorderAttribute.GetBorderWidth: Double;
begin
  if Assigned(FFormField) then
    Result := FFormField.BorderWidth
  else
    Result := FBorderWidth;
end;

procedure TgtBorderAttribute.SetBorderStyle(AValue: TgtAnnotBorderStyle);
begin
  if Assigned(FFormField) then
  begin
    case AValue of
      bsSolid: THackgtPDFormField(FFormField).BorderStyle := absSolid;
      bsDashed: THackgtPDFormField(FFormField).BorderStyle := absDashed;
      bsBeveled: THackgtPDFormField(FFormField).BorderStyle := absBeveled;
      bsInset: THackgtPDFormField(FFormField).BorderStyle := absInset;
      bsUnderline: THackgtPDFormField(FFormField).BorderStyle := absUnderline;
    end;
  end
  else
    FBorderStyle := AValue;
end;

procedure TgtBorderAttribute.SetBorderWidth(AValue: Double);
begin
  if Assigned(FFormField) then
    FFormField.BorderWidth := AValue
  else
    FBorderWidth := AValue;
end;

{ TgtPDFFormField }

constructor TgtPDFFormField.Create;
begin
  FIsSetMeasurementUnit := False;
  FFont := TFont.Create;
end;

destructor TgtPDFFormField.Destroy;
begin
  if Assigned(FFont) then
    FreeAndNil(FFont);
  if Assigned(FBorderAttribute) then
    FreeAndNil(FBorderAttribute);
  if Assigned(FFormField) then
    FreeAndNil(FFormField);
  if Assigned(FAction) then
    FreeAndNil(FAction);
  inherited;
end;

function TgtPDFFormField.GetAction: TgtPDFAction;
begin
//check
  if not Assigned(FAction) then
  begin
    FAction := THackgtPDFAction.Create(FFormField.Action);
  end;
  Result := FAction;
end;

function TgtPDFFormField.GetAdditionalPreferences: TgtAdditionalPreferences;
var
  LPref: TgtPDAnnotFlags;
begin
  Result := [];
  LPref := FFormField.Flags;
  if (afInvisible in LPref) then
    Result := Result + [afpInvisible];
  if (afHidden in LPref) then
    Result := Result + [afpHidden];
  if (afPrint in LPref) then
    Result := Result + [afpPrint]
  else
    Result := Result + [afpNoPrint];
  if (afNoZoom in LPref) then
    Result := Result + [afpNoZoom];
  if (afNoRotate in LPref) then
    Result := Result + [afpNoRotate];
  if (afNoView in LPref) then
    Result := Result + [afpNoView];
  if (afReadOnly in LPref) then
    Result := Result + [afpReadOnlyAnnots];
  if (afLocked in LPref) then
    Result := Result + [afpLocked];
  if (afToggleNoView in LPref) then
    Result := Result + [afpToggleNoView];
  if (afLockedContents in LPref) then
    Result := Result + [afpLocked];
end;

function TgtPDFFormField.GetAltFieldName: string;
begin
  Result := THackgtPDFormField(FFormField).AltFieldName;
end;

function TgtPDFFormField.GetBackgroundColor: TColor;
var
  R, G, B: Byte;
  LColorValue: TgtPDColorValue;
begin
  LColorValue := THackgtPDFormField(FFormField).BackGroundColor;
  R := Round(LColorValue.Value[0] * 255);
  G := Round(LColorValue.Value[1] * 255);
  B := Round(LColorValue.Value[2] * 255);
  Result := RGB(R, G, B);
end;

function TgtPDFFormField.GetBorderAttribute: TgtBorderAttribute;
begin
  if not Assigned(FBorderAttribute) then
    FBorderAttribute := TgtBorderAttribute.Create(FFormField);
  Result := FBorderAttribute;
end;

function TgtPDFFormField.GetBorderColor: TColor;
var
  R, G, B: Byte;
  LColor: TgtPDColorValue;
begin
  LColor := THackgtPDFormField(FFormField).BorderColor;
  R := Round(LColor.Value[0] * 255);
  G := Round(LColor.Value[1] * 255);
  B := Round(LColor.Value[2] * 255);
  Result := RGB(R, G, B);
end;

function TgtPDFFormField.GetDefaultValue: string;
begin
  Result := THackgtPDFormField(FFormField).DefaultValue;
end;

function TgtPDFFormField.GetFieldName: string;
begin
  Result := FFormField.FieldName;
end;

function TgtPDFFormField.GetFont: TFont;
var
  LgtFont: TgtFont;
begin
  LgtFont := THackgtPDFormField(FFormField).Font;
  if Assigned(LgtFont) then
  begin
    FFont.Name := LgtFont.Name;
    FFont.Style := LgtFont.Style;
    FFont.Size := LgtFont.Size;
    FFont.Color := LgtFont.Color;
  end;
  Result := FFont;
end;

function TgtPDFFormField.GetJustification: TgtPDFFieldJustification;
begin
  case (THackgtPDFormField(FFormField).Justification) of
    fjLeftJustified: Result := gtCstPDFDoc.fjLeftJustified;
    fjCentered: Result := gtCstPDFDoc.fjCentered;
    fjRightJustified: Result := gtCstPDFDoc.fjRightJustified;
  end;
end;

function TgtPDFFormField.GetOrientation: TgtPDFormFieldOrientation;
begin
  Result := FFormField.Orientation;
end;

function TgtPDFFormField.GetPreferences: TgtAcroFieldPreferences;
begin
  Result := [];
  if (PDTypes.afpReadOnly in THackgtPDFormField(FFormField).Preferences) then
    Result := Result + [afpReadOnly];
  if (PDTypes.afpRequired in THackgtPDFormField(FFormField).Preferences) then
    Result := Result + [afpRequired];
  if (PDTypes.afpNoExport in THackgtPDFormField(FFormField).Preferences) then
    Result := Result + [afpNoExport];
end;

function TgtPDFFormField.GetRect: TgtRect;
begin
  if Assigned(FFormField.Rect) then
  begin
    if FIsSetMeasurementUnit then
    begin
      Result.Left := ConvertToMU(FMeasurementUnit, FFormField.Rect.Left);
      Result.Top := ConvertToMU(FMeasurementUnit, FFormField.Rect.Top);
      Result.Right := ConvertToMU(FMeasurementUnit, FFormField.Rect.Right);
      Result.Bottom := ConvertToMU(FMeasurementUnit, FFormField.Rect.Bottom);
    end
    else
    begin
      Result.Left := FFormField.Rect.Left;
      Result.Top := FFormField.Rect.Top;
      Result.Right := FFormField.Rect.Right;
      Result.Bottom := FFormField.Rect.Bottom;
    end;
  end;
end;

function TgtPDFFormField.GetTransparent: Boolean;
begin
  Result := THackgtPDFormField(FFormField).Transparent;
end;

function TgtPDFFormField.GetTrigger: TgtFormFieldActionTriggers;
begin
  case FFormField.TriggerType of
    PDTypes.fftOnEnter: Result := fftOnEnter;
    PDTypes.fftOnExit: Result := fftOnExit;
    PDTypes.fftMouseDown: Result := fftMouseDown;
    PDTypes.fftMouseUp: Result := fftMouseUp;
    PDTypes.fftGotFocus: Result := fftGotFocus;
    PDTypes.fftLostFocus: Result := fftLostFocus;
    PDTypes.fftOnKeyPress: Result := fftOnKeyPress;
    PDTypes.fftFormat: Result := fftFormat;
    PDTypes.fftValidate: Result := fftValidate;
    PDTypes.fftCalculate: Result := fftCalculate;
  end;
end;

function TgtPDFFormField.GetValue: string;
begin
  Result := FFormField.Value;
end;

procedure TgtPDFFormField.SetAction(const Value: TgtPDFAction);
begin
  FAction := Value;
  FFormField.Action := THackgtPDFAction(Value).FAction;
end;

procedure TgtPDFFormField.SetAdditionalPreferences(
  const Value: TgtAdditionalPreferences);
var
  LPref: TgtPDAnnotFlags;
begin
  LPref := [];
  if afpInvisible in Value then
    LPref := LPref + [afInvisible];
  if afpHidden in Value then
    LPref := LPref + [afHidden];
  if afpPrint in Value then
    LPref := LPref + [afPrint];
  if afpNoPrint in Value then
    LPref := LPref;
  if afpNoZoom in Value then
    LPref := LPref + [afNoZoom];
  if afpNoRotate in Value then
    LPref := LPref + [afNoRotate];
  if afpNoView in Value then
    LPref := LPref + [afNoView];
  if afpReadOnlyAnnots in Value then
    LPref := LPref + [afReadOnly];
  if afpLocked in Value then
    LPref := LPref + [afLocked];
  if afpToggleNoView in Value then
    LPref := LPref + [afToggleNoView];
  if afpLocked in Value then
    LPref := LPref + [afLockedContents];

  FFormField.Flags := LPref;
end;

procedure TgtPDFFormField.SetAltFieldName(const Value: string);
begin
  THackgtPDFormField(FFormField).AltFieldName := Value;
end;

procedure TgtPDFFormField.SetBackgroundColor(const Value: TColor);
var
  LColor: TgtPDColorValue;
begin
  LColor.ColorSpace := DeviceRGB; {RGB}
  LColor.Value[0] := GetRValue(ColorToRGB(Value)) / 255;
  LColor.Value[1] := GetGValue(ColorToRGB(Value)) / 255;
  LColor.Value[2] := GetBValue(ColorToRGB(Value)) / 255;
  THackgtPDFormField(FFormField).BackGroundColor := LColor;
end;

procedure TgtPDFFormField.SetBorderAttribute(const Value: TgtBorderAttribute);
begin
  FBorderAttribute := Value;

  FFormField.BorderWidth := Value.BorderWidth;
  case Value.BorderStyle of
    bsSolid: FFormField.BorderStyle := absSolid;
    bsDashed: FFormField.BorderStyle := absDashed;
    bsBeveled: FFormField.BorderStyle := absBeveled;
    bsInset: FFormField.BorderStyle := absInset;
    bsUnderline: FFormField.BorderStyle := absUnderline;
  end;
end;

procedure TgtPDFFormField.SetBorderColor(const Value: TColor);
var
  LColor: TgtPDColorValue;
begin
  LColor.ColorSpace := DeviceRGB; {RGB}
  LColor.Value[0] := GetRValue(ColorToRGB(Value)) / 255;
  LColor.Value[1] := GetGValue(ColorToRGB(Value)) / 255;
  LColor.Value[2] := GetBValue(ColorToRGB(Value)) / 255;
  THackgtPDFormField(FFormField).BorderColor := LColor;
end;

procedure TgtPDFFormField.SetDefaultValue(const Value: string);
begin
  THackgtPDFormField(FFormField).DefaultValue := Value;
end;

procedure TgtPDFFormField.SetFieldJustification(
  const Value: TgtPDFFieldJustification);
begin
  case Value of
    gtCstPDFDoc.fjLeftJustified:
      THackgtPDFormField(FFormField).Justification := fjLeftJustified;
    gtCstPDFDoc.fjCentered:
      THackgtPDFormField(FFormField).Justification := fjCentered;
    gtCstPDFDoc.fjRightJustified:
      THackgtPDFormField(FFormField).Justification := fjRightJustified;
  end;
end;

procedure TgtPDFFormField.SetFieldName(const Value: string);
begin
  FFormField.FieldName := Value;
end;

procedure TgtPDFFormField.SetFont(const Value: TFont);
begin
  //check
  FFont.Assign(Value);
  THackgtPDFormField(FFormField).Font.Name := Value.Name;
  THackgtPDFormField(FFormField).Font.Style := Value.Style;
  THackgtPDFormField(FFormField).Font.Size := Value.Size;
  THackgtPDFormField(FFormField).Font.Color := Value.Color;
end;

procedure TgtPDFFormField.SetMeasurementUnit(const Value: TgtMeasurementUnit);
var
  LLeft, LTop, LRight, LBottom: Double;
  LRect: TgtRect;
begin
  FMeasurementUnit := Value;
  LRect.Left := ConvertToPDFUnit(FMeasurementUnit, Rect.Left);
  LRect.Top := ConvertToPDFUnit(FMeasurementUnit, Rect.Top);
  LRect.Right := ConvertToPDFUnit(FMeasurementUnit, Rect.Right);
  LRect.Bottom := ConvertToPDFUnit(FMeasurementUnit, Rect.Bottom);
  Rect := LRect;
  BorderAttribute.BorderWidth := ConvertToPDFUnit(FMeasurementUnit, BorderAttribute.BorderWidth);
  FIsSetMeasurementUnit := True;
end;

procedure TgtPDFFormField.SetOrientation(
  const Value: TgtPDFormFieldOrientation);
begin
  FFormField.Orientation := Value;
end;

procedure TgtPDFFormField.SetPreferences(const Value: TgtAcroFieldPreferences);
var
  LPref: PDFormField.TgtAcroFieldPreferences;
begin
  LPref := [];
  if afpReadOnly in Value then
    LPref := LPref + [PDTypes.afpReadOnly];
  if afpRequired in Value then
    LPref := LPref + [PDTypes.afpRequired];
  if afpNoExport in Value then
    LPref := LPref + [PDTypes.afpNoExport];

  THackgtPDFormField(FFormField).Preferences := LPref;
end;

procedure TgtPDFFormField.SetRect(const Value: TgtRect);
begin
  //check
  if Assigned(FFormField.Rect) then
  begin
    FFormField.Rect.Left := Value.Left;
    FFormField.Rect.Top := Value.Top;
    FFormField.Rect.Right := Value.Right;
    FFormField.Rect.Bottom := Value.Bottom;
  end;
end;

procedure TgtPDFFormField.SetTransparent(const Value: Boolean);
begin
  THackgtPDFormField(FFormField).Transparent := Value;
end;

procedure TgtPDFFormField.SetTrigger(const Value: TgtFormFieldActionTriggers);
begin
  case Value of
    fftOnEnter: FFormField.TriggerType := PDTypes.fftOnEnter;
    fftOnExit: FFormField.TriggerType := PDTypes.fftOnExit;
    fftMouseDown: FFormField.TriggerType := PDTypes.fftMouseDown;
    fftMouseUp: FFormField.TriggerType := PDTypes.fftMouseUp;
    fftGotFocus: FFormField.TriggerType := PDTypes.fftGotFocus;
    fftLostFocus: FFormField.TriggerType := PDTypes.fftLostFocus;
    fftOnKeyPress: FFormField.TriggerType := PDTypes.fftOnKeyPress;
    fftFormat: FFormField.TriggerType := PDTypes.fftFormat;
    fftValidate: FFormField.TriggerType := PDTypes.fftValidate;
    fftCalculate: FFormField.TriggerType := PDTypes.fftCalculate;
  end;
end;

procedure TgtPDFFormField.SetValue(const Value: string);
begin
  FFormField.Value := Value;
end;

{ TgtPDFFormPushButton }

constructor TgtPDFFormPushButton.Create;
begin
  inherited;
  FFormField := TgtPDFormPushButton.Create;
end;

destructor TgtPDFFormPushButton.Destroy;
begin
//  if Assigned(FPushButtonAction) then
//    FreeAndNil(FPushButtonAction);
  inherited;
end;

function TgtPDFFormPushButton.GetAction: TgtPushButtonAction;
begin
  Result := pbaNone;
  if Assigned(FPushButtonAction) then
  begin
    case FPushButtonAction.ActionType of
      actionNone: Result := pbaNone;
      actionSubmitForm: Result := pbaSubmit;
      actionResetForm: Result := pbaReset;
      actionJavaScript: Result := pbaJavaScript;
    end;
  end;
end;

function TgtPDFFormPushButton.GetDownCaption: string;
begin
  TgtPDFormPushButton(FFormField).DownCaption;
end;

function TgtPDFFormPushButton.GetFormSubmitFormat: TgtFormSubmitFormat;
begin
  Result := fsfHTML;
  if (Assigned(FFormField.Action) and
    (FFormField.Action is TgtPDSubmitFormAction)) then
  begin
    case TgtPDSubmitFormAction(FFormField.Action).Format of
      PDSubmitFormAction.fsfHTML: Result := fsfHTML;
      PDSubmitFormAction.fsfFDF: Result := fsfFDF;
      PDSubmitFormAction.fsfXML: Result := fsfXML;
    end;
  end;
end;

function TgtPDFFormPushButton.GetJavaScript: string;
begin
  Result := '';
  if (Assigned(FPushButtonAction) and
    (FPushButtonAction is TgtPDJavaScriptAction)) then
  begin
    Result := TgtPDJavaScriptAction(FPushButtonAction).JavaScript;
  end;
end;

function TgtPDFFormPushButton.GetNormalCaption: string;
begin
  Result := TgtPDFormPushButton(FFormField).NormalCaption;
end;

function TgtPDFFormPushButton.GetRolloverCaption: string;
begin
  Result := TgtPDFormPushButton(FFormField).RollOverCaption;
end;

function TgtPDFFormPushButton.GetSubmitURL: WideString;
begin
  Result := '';
  if (Assigned(FPushButtonAction) and
    (FPushButtonAction is TgtPDSubmitFormAction)) then
  begin
    Result := TgtPDSubmitFormAction(FPushButtonAction).URL;
  end;
end;

procedure TgtPDFFormPushButton.SetAction(const Value: TgtPushButtonAction);
begin
  case Value of
    pbaNone:
      begin

      end;
    pbaSubmit:
      begin
        FPushButtonAction := TgtPDSubmitFormAction.Create;
        TgtPDSubmitFormAction(FPushButtonAction).ActionType := actionSubmitForm;
        FFormField.Action := FPushButtonAction;
      end;
    pbaReset:
      begin
        FPushButtonAction := TgtPDResetFormAction.Create;
        TgtPDResetFormAction(FPushButtonAction).ActionType := actionResetForm;
        FFormField.Action := FPushButtonAction;
      end;
    pbaJavaScript:
      begin
        FPushButtonAction := TgtPDJavaScriptAction.Create;
        TgtPDJavaScriptAction(FPushButtonAction).ActionType := actionJavaScript;
        FFormField.Action := FPushButtonAction;
      end;
  end;
end;

procedure TgtPDFFormPushButton.SetDownCaption(const Value: string);
begin
  TgtPDFormPushButton(FFormField).DownCaption := Value;
end;

procedure TgtPDFFormPushButton.SetFormSubmitFormat(
  const Value: TgtFormSubmitFormat);
begin
  if not Assigned(FPushButtonAction) then
    SetAction(pbaSubmit);
  case Value of
    fsfHTML: TgtPDSubmitFormAction(FPushButtonAction).Format := PDSubmitFormAction.fsfHTML;
    fsfFDF: TgtPDSubmitFormAction(FPushButtonAction).Format := PDSubmitFormAction.fsfFDF;
    fsfXML: TgtPDSubmitFormAction(FPushButtonAction).Format := PDSubmitFormAction.fsfXML;
  end;
end;

procedure TgtPDFFormPushButton.SetJavaScript(const Value: string);
begin
  if not Assigned(FPushButtonAction) then
    SetAction(pbaJavaScript);
  TgtPDJavaScriptAction(FPushButtonAction).JavaScript := Value;
end;

procedure TgtPDFFormPushButton.SetNormalCaption(const Value: string);
begin
  TgtPDFormPushButton(FFormField).NormalCaption := Value;
end;

procedure TgtPDFFormPushButton.SetRolloverCaption(const Value: string);
begin
  TgtPDFormPushButton(FFormField).RollOverCaption := Value;
end;

procedure TgtPDFFormPushButton.SetSubmitURL(const Value: WideString);
begin
  if not Assigned(FPushButtonAction) then
    SetAction(pbaSubmit);
  TgtPDSubmitFormAction(FPushButtonAction).URL := Value;
end;

{ TgtPDFFormCheckBox }

constructor TgtPDFFormCheckBox.Create;
begin
  inherited;
  FFormField := TgtPDFormCheckBox.Create;
end;

destructor TgtPDFFormCheckBox.Destroy;
begin
  inherited;
end;

function TgtPDFFormCheckBox.GetChecked: Boolean;
begin
  Result := TgtPDFormCheckBox(FFormField).IsChecked;
end;

function TgtPDFFormCheckBox.GetSymbol: TgtPDFFormCheckboxSymbol;
begin
  case TgtPDFormCheckBox(FFormField).Symbol of
    csCheck: Result := pfcsCheck;
    csCircle: Result := pfcsCircle;
    csCross: Result := pfcsCross;
    csDiamond: Result := pfcsDiamond;
    csSquare: Result := pfcsSquare;
    csStar: Result := pfcsStar;
  end;
end;

procedure TgtPDFFormCheckBox.SetChecked(const Value: Boolean);
begin
  TgtPDFormCheckBox(FFormField).IsChecked := Value;
end;

procedure TgtPDFFormCheckBox.SetSymbol(const Value: TgtPDFFormCheckboxSymbol);
begin
  case Value of
    pfcsCheck: TgtPDFormCheckBox(FFormField).Symbol := csCheck;
    pfcsCircle: TgtPDFormCheckBox(FFormField).Symbol := csCircle;
    pfcsCross: TgtPDFormCheckBox(FFormField).Symbol := csCross;
    pfcsDiamond: TgtPDFormCheckBox(FFormField).Symbol := csDiamond;
    pfcsSquare: TgtPDFormCheckBox(FFormField).Symbol := csSquare;
    pfcsStar: TgtPDFormCheckBox(FFormField).Symbol := csStar;
  end;
end;

{ TgtPDFFormRadioItem }

constructor TgtPDFFormRadioItem.Create;
begin
  inherited;
  FFormField := TgtPDRadioItem.Create;
end;

destructor TgtPDFFormRadioItem.Destroy;
begin
  inherited;
end;

{ TgtPDFFormRadioButton }

function TgtPDFFormRadioButton.AddItem(RadioItem: TgtPDFFormRadioItem): Integer;
begin
  Result := TgtPDFormRadioButton(FFormField).
    AddRadioItem(TgtPDRadioItem(RadioItem.FFormField));
end;

constructor TgtPDFFormRadioButton.Create;
begin
  inherited;
  FFormField := TgtPDFormRadioButton.Create;
end;

destructor TgtPDFFormRadioButton.Destroy;
begin
  inherited;
end;

function TgtPDFFormRadioButton.GetAtleastOneSelectedItem: Boolean;
begin
  Result := TgtPDFormRadioButton(FFormField).AtleastOneSelectedItem;
end;

function TgtPDFFormRadioButton.GetOptionCount: Integer;
begin
  Result := TgtPDFormRadioButton(FFormField).OptionCount;
end;

function TgtPDFFormRadioButton.GetSelectedItemIndex: Integer;
begin
  Result := TgtPDFormRadioButton(FFormField).SelectedItemIndex;
end;

function TgtPDFFormRadioButton.GetSymbol: TgtPDFFormCheckboxSymbol;
begin
  case TgtPDFormRadioButton(FFormField).Symbol of
    csCheck: Result := pfcsCheck;
    csCircle: Result := pfcsCircle;
    csCross: Result := pfcsCross;
    csDiamond: Result := pfcsDiamond;
    csSquare: Result := pfcsSquare;
    csStar: Result := pfcsStar;
  end;
end;

procedure TgtPDFFormRadioButton.SetAtleastOneSelectedItem(const Value: Boolean);
begin
  TgtPDFormRadioButton(FFormField).AtleastOneSelectedItem := Value;
end;

procedure TgtPDFFormRadioButton.SetSelectedItemIndex(const Value: Integer);
begin
  TgtPDFormRadioButton(FFormField).SelectedItemIndex := Value;
end;

procedure TgtPDFFormRadioButton.SetSymbol(
  const Value: TgtPDFFormCheckboxSymbol);
begin
  case Value of
    pfcsCheck: TgtPDFormRadioButton(FFormField).Symbol := csCheck;
    pfcsCircle: TgtPDFormRadioButton(FFormField).Symbol := csCircle;
    pfcsCross: TgtPDFormRadioButton(FFormField).Symbol := csCross;
    pfcsDiamond: TgtPDFormRadioButton(FFormField).Symbol := csDiamond;
    pfcsSquare: TgtPDFormRadioButton(FFormField).Symbol := csSquare;
    pfcsStar: TgtPDFormRadioButton(FFormField).Symbol := csStar;
  end;
end;

{ TgtPDFFormComboBox }

function TgtPDFFormComboBox.AddItem(Item: string): Integer;
begin
  Result := TgtPDFormComboBox(FFormField).AddItem(Item);
end;

constructor TgtPDFFormComboBox.Create;
begin
  inherited;
  FFormField := TgtPDFormComboBox.Create;
end;

destructor TgtPDFFormComboBox.Destroy;
begin
  inherited;
end;

function TgtPDFFormComboBox.GetIsEditable: Boolean;
begin
  Result := TgtPDFormComboBox(FFormField).IsEditable;
end;

function TgtPDFFormComboBox.GetIsSortList: Boolean;
begin
  Result := TgtPDFormComboBox(FFormField).IsSortedList;
end;

function TgtPDFFormComboBox.GetSelectedItemIndex: Integer;
begin
  Result := TgtPDFormComboBox(FFormField).SelectedItemIndex;
end;

procedure TgtPDFFormComboBox.SetIsEditable(const Value: Boolean);
begin
  TgtPDFormComboBox(FFormField).IsEditable := Value;
end;

procedure TgtPDFFormComboBox.SetIsSortList(const Value: Boolean);
begin
  TgtPDFormComboBox(FFormField).IsSortedList := Value;
end;

procedure TgtPDFFormComboBox.SetSelectedItemIndex(const Value: Integer);
begin
  TgtPDFormComboBox(FFormField).SelectedItemIndex := Value;
end;

{ TgtPDFFormListBox }

function TgtPDFFormListBox.AddItem(Item: string): Integer;
begin
  Result := TgtPDFormListBox(FFormField).AddItem(Item);
end;

constructor TgtPDFFormListBox.Create;
begin
  inherited;
  FFormField := TgtPDFormListBox.Create;
end;

destructor TgtPDFFormListBox.Destroy;
begin
  inherited;
end;

function TgtPDFFormListBox.GetIsMultiSelect: Boolean;
begin
  Result := TgtPDFormListBox(FFormField).IsMultiSelect;
end;

function TgtPDFFormListBox.GetIsSortList: Boolean;
begin
  Result := TgtPDFormListBox(FFormField).IsSortedList;
end;

procedure TgtPDFFormListBox.SetIsMultiSelect(const Value: Boolean);
begin
  TgtPDFormListBox(FFormField).IsMultiSelect := Value;
end;

procedure TgtPDFFormListBox.SetIsSortList(const Value: Boolean);
begin
  TgtPDFormListBox(FFormField).IsSortedList := Value;
end;

{ TgtFormField }

constructor TgtFormField.Create;
begin
  inherited;
  FBorderAttribute := TgtBorderAttribute.Create;
//  FBorderAttribute.BorderWidth := 2;
  FDefaultFont := TgtFontInfo.Create;
  FAllowedValues := nil;
end;

destructor TgtFormField.Destroy;
var
  LI: Integer;
begin
  if Assigned(FDefaultFont) then
    FreeAndNil(FDefaultFont);
  if Assigned(FBorderAttribute) then
    FreeAndNil(FBorderAttribute);
  if Assigned(FAllowedValues) then
    FreeAndNil(FAllowedValues);
  inherited;
end;

procedure TgtFormField.Fill(APFXFileName, APFXPassword: AnsiString;
  ADateTime: TDateTime; AReason, ALocation, AContactInfo: AnsiString);
begin
  TgtPDSignatureField(FFormField).Fill(APFXFileName, APFXPassword, ADateTime, AReason,
    ALocation, AContactInfo);
end;

procedure TgtFormField.Fill(APFXFileName, APFXPassword, AReason, ALocation,
  AContactInfo: AnsiString);
begin
  TgtPDSignatureField(FFormField).Fill(APFXFileName, APFXPassword, AReason,
    ALocation, AContactInfo);
end;

function TgtFormField.GetAdditionalPreferences: TgtAdditionalPreferences;
var
  LPref: TgtPDAnnotFlags;
begin
  Result := [];
  LPref := FFormField.Flags;
  if (afInvisible in LPref) then
    Result := Result + [afpInvisible];
  if (afHidden in LPref) then
    Result := Result + [afpHidden];
  if (afPrint in LPref) then
    Result := Result + [afpPrint]
  else
    Result := Result + [afpNoPrint];
  if (afNoZoom in LPref) then
    Result := Result + [afpNoZoom];
  if (afNoRotate in LPref) then
    Result := Result + [afpNoRotate];
  if (afNoView in LPref) then
    Result := Result + [afpNoView];
  if (afReadOnly in LPref) then
    Result := Result + [afpReadOnlyAnnots];
  if (afLocked in LPref) then
    Result := Result + [afpLocked];
  if (afToggleNoView in LPref) then
    Result := Result + [afpToggleNoView];
  if (afLocked in LPref) then
    Result := Result + [afpLocked];
end;

function TgtFormField.GetAllowedValues: TStringList;
var
  LI: Integer;
  LOptionCount: Integer;
begin
  if Assigned(FAllowedValues) then
    FreeAndNil(FAllowedValues);

  if ((FFormField is TgtPDFormListBox) or (FFormField is TgtPDFormComboBox) or
    (FFormField is TgtPDFormRadioButton)) then
  begin
    FAllowedValues := TStringList.Create;

    if FFormField is TgtPDFormListBox then
      LOptionCount := TgtPDFormListBox(FFormField).OptionCount
    else if FFormField is TgtPDFormComboBox then
      LOptionCount := TgtPDFormComboBox(FFormField).OptionCount
    else if FFormField is TgtPDFormRadioButton then
      LOptionCount := TgtPDFormRadioButton(FFormField).OptionCount;

    for LI := 0 to LOptionCount - 1 do
    begin
      if FFormField is TgtPDFormListBox then
        FAllowedValues.Add(TgtPDFormListBox(FFormField).Options[LI])
      else if FFormField is TgtPDFormComboBox then
        FAllowedValues.Add(TgtPDFormComboBox(FFormField).Options[LI])
      else if FFormField is TgtPDFormRadioButton then
        FAllowedValues.Add(TgtPDFormRadioButton(FFormField).Options[LI]);
    end;
  end;

  Result := FAllowedValues;
end;

function TgtFormField.GetBackGroundColor: TColor;
var
  R, G, B: Byte;
begin
  R := Round(THackgtPDFormField(FFormField).BackGroundColor.value[0] * 255);
  G := Round(THackgtPDFormField(FFormField).BackGroundColor.value[1] * 255);
  B := Round(THackgtPDFormField(FFormField).BackGroundColor.value[2] * 255);
  Result := RGB(R, G, B);
end;

function TgtFormField.GetBorderAttribute: TgtBorderAttribute;
begin
  Result.BorderWidth := FFormField.BorderWidth;
  case FFormField.BorderStyle of
    absSolid: Result.BorderStyle := bsSolid;
    absDashed: Result.BorderStyle := bsDashed;
    absBeveled: Result.BorderStyle := bsBeveled;
    absInset: Result.BorderStyle := bsInset;
    absUnderline: Result.BorderStyle := bsUnderline;
  end;
end;

function TgtFormField.GetDefaultFieldValue: string;
begin
  Result := THackgtPDFormField(FFormField).DefaultValue;
end;

function TgtFormField.GetDefaultFont: TgtFontInfo;
begin
  FDefaultFont.Name := THackgtPDFormField(FFormField).Font.Name;
  FDefaultFont.ActualSize := THackgtPDFormField(FFormField).Font.Size;
  FDefaultFont.Color := ColorToString(THackgtPDFormField(FFormField).Font.Color);
  Result := FDefaultFont;
end;

function TgtFormField.GetFieldDescription: string;
begin
  Result := THackgtPDFormField(FFormField).AltFieldName;
end;

function TgtFormField.GetFieldName: string;
begin
  Result := FFormField.FieldName;
end;

function TgtFormField.GetFieldRect: TgtRect;
begin
  if Assigned(FFormField.Rect) then
  begin
    Result.Left := FFormField.Rect.Left;
    Result.Top := FFormField.Rect.Top;
    Result.Right := FFormField.Rect.Right;
    Result.Bottom := FFormField.Rect.Bottom;
  end;
end;

function TgtFormField.GetFieldType: TgtPDFFormFieldType;
begin
  case FFormField.FormFieldType of
    ftText: Result := gtCstPDFDoc.ftText;
    ftCheckBox: Result := gtCstPDFDoc.ftCheckBox;
    ftRadio: Result := gtCstPDFDoc.ftRadio;
    ftButton: Result := gtCstPDFDoc.ftButton;
    ftSignature: Result := gtCstPDFDoc.ftSignature;
    ftListBox: Result := gtCstPDFDoc.ftChoice;
    ftComboBox: Result := gtCstPDFDoc.ftChoice;
  end;
end;

function TgtFormField.GetFieldValue: WideString;
begin
//   if IsHex(FFormField.Value) then
//    Result := UnicodeHexToString(FFormField.Value)
//  else
  if Assigned(FFormField) then
    Result := FFormField.Value;
end;

function TgtFormField.GetIsComb: Boolean;
begin
  if FFormField.FormFieldType = ftText then
    Result := TgtPDFormTextField(FFormField).IsComb;
end;

function TgtFormField.GetIsReadOnly: Boolean;
begin
  Result := THackgtPDFormField(FFormField).IsReadOnly;
end;

function TgtFormField.GetJustification: TgtPDFFieldJustification;
begin
  case THackgtPDFormField(FFormField).Justification of
    fjLeftJustified: Result := gtCstPDFDoc.fjLeftJustified;
    fjCentered: Result := gtCstPDFDoc.fjCentered;
    fjRightJustified: Result := gtCstPDFDoc.fjRightJustified;
  end;
end;

function TgtFormField.GetMaxLen: Integer;
begin
  if FFormField.FormFieldType = ftText then
    Result := TgtPDFormTextField(FFormField).MaxLength;
end;

function TgtFormField.GetMultiLine: Boolean;
begin
  if FFormField.FormFieldType = ftText then
    Result := TgtPDFormTextField(FFormField).IsMultiLine;
end;

function TgtFormField.GetOrientation: TgtPDFFormFieldOrientation;
begin
  Result := TgtPDFFormFieldOrientation(FFormField.Orientation);
end;

function TgtFormField.GetPageNum: Integer;
begin
  Result := FPageNum;
end;

function TgtFormField.GetPrint: boolean;
begin
  if afpPrint in AdditionalPreferences then
    Result := True
  else if afpNoPrint in AdditionalPreferences then
    Result := False;
end;

function TgtFormField.GetQualifiedName: string;
begin
  Result := FFormField.FullQualifiedName;
end;

////function TgtFormField.GetReadOnly: Boolean;
////begin
////  if FFormField.FormFieldType = PDTypes.ftText then
////    Result := TPDFormTextField(FFormField).IsReadOnly
////  else if FFormField.FormFieldType = PDTypes.ftCheckBox then
////    Result := TPDFormCheckBox(FFormField).IsReadOnly
////  else if FFormField.FormFieldType = PDTypes.ftRadio then
////    Result := TPDFormRadioButton(FFormField).IsReadOnly;
////end;

function TgtFormField.GetRequired: Boolean;
var
  LPref: Integer;
begin
  Result := False;
  if PDTypes.afpRequired in THackgtPDFormField(FFormField).Preferences then
    Result := True;
end;

function TgtFormField.GetSubmitURL: string;
var
  LAction: TgtPDAction;
begin
  Result := '';
  LAction := FFormField.Action;
  if Assigned(LAction) then
  begin
    if LAction.ActionType = actionSubmitForm then
    begin
      Result := TgtPDSubmitFormAction(LAction).URL;
    end;
  end;
end;

function TgtFormField.GetTransparent: Boolean;
begin
  Result := THackgtPDFormField(FFormField).Transparent;
end;

function TgtFormField.GetVisible: boolean;
begin
  Result := True;
  if (afpInvisible in AdditionalPreferences) then
    Result := False;
end;

procedure TgtFormField.SetAdditionalPreferences(
  const Value: TgtAdditionalPreferences);
var
  LPref: TgtPDAnnotFlags;
begin
  LPref := FFormField.Flags;
  if afpInvisible in Value then
    LPref := LPref + [afInvisible];
  if afpHidden in Value then
    LPref := LPref + [afHidden];
  if afpPrint in Value then
    LPref := LPref + [afPrint];
  if afpNoPrint in Value then
    LPref := LPref;
  if afpNoZoom in Value then
    LPref := LPref + [afNoZoom];
  if afpNoRotate in Value then
    LPref := LPref + [afNoRotate];
  if afpNoView in Value then
    LPref := LPref + [afNoView];
  if afpReadOnlyAnnots in Value then
    LPref := LPref + [afReadOnly];
  if afpLocked in Value then
    LPref := LPref + [afLocked];
  if afpToggleNoView in Value then
    LPref := LPref + [afToggleNoView];
  if afpLocked in Value then
    LPref := LPref + [afLockedContents];
  FFormField.Flags := LPref;
end;

procedure TgtFormField.SetAllowedValues(const Value: TStringList);
var
  LI: Integer;
begin
  if Assigned(FAllowedValues) then
  begin
    FAllowedValues.Clear;
    FAllowedValues := Value;
  end;

  for LI := 0 to Value.Count - 1 do
  begin
    if FFormField is TgtPDFormListBox then
      TgtPDFormListBox(FFormField).Options[LI] := Value[LI]
    else if FFormField is TgtPDFormComboBox then
      TgtPDFormComboBox(FFormField).Options[LI] := Value[LI]
    else if FFormField is TgtPDFormRadioButton then
      TgtPDFormRadioButton(FFormField).Options[LI] := Value[LI];
  end;
end;

procedure TgtFormField.SetBackGroundColor(const Value: TColor);
var
  LColor: TgtPDColorValue;
begin
  LColor.ColorSpace := DeviceRGB; {RGB}
  LColor.Value[0] := GetRValue(Value) / 255;
  LColor.Value[1] := GetGValue(Value) / 255;
  LColor.Value[2] := GetBValue(Value) / 255;
  THackgtPDFormField(FFormField).BackGroundColor := LColor;
end;

procedure TgtFormField.SetBorderAttribute(const Value: TgtBorderAttribute);
begin
  THackgtPDFormField(FFormField).BorderWidth := Value.BorderWidth;
  case Value.BorderStyle of
    bsSolid: THackgtPDFormField(FFormField).BorderStyle := absSolid;
    bsDashed: THackgtPDFormField(FFormField).BorderStyle := absDashed;
    bsBeveled: THackgtPDFormField(FFormField).BorderStyle := absBeveled;
    bsInset: THackgtPDFormField(FFormField).BorderStyle := absInset;
    bsUnderline: THackgtPDFormField(FFormField).BorderStyle := absUnderline;
  end;
end;

procedure TgtFormField.SetDefaultFieldValue(const Value: string);
begin
  THackgtPDFormField(FFormField).DefaultValue := Value;
end;

procedure TgtFormField.SetFieldDescription(const Value: string);
begin
  THackgtPDFormField(FFormField).AltFieldName := Value;
end;

procedure TgtFormField.SetFieldName(const Value: string);
begin
  FFormField.FieldName := Value;
end;

procedure TgtFormField.SetFieldValue(const Value: WideString);
begin
  FFormField.Value := Value;
end;

procedure TgtFormField.SetIsComb(const Value: Boolean);
begin
  if FFormField.FormFieldType = ftText then
    TgtPDFormTextField(FFormField).IsComb := Value;
end;

procedure TgtFormField.SetIsReadOnly(const Value: Boolean);
begin
  THackgtPDFormField(FFormField).IsReadOnly := Value;
end;

procedure TgtFormField.SetJustification(const Value: TgtPDFFieldJustification);
begin
  case Value of
    gtCstPDFDoc.fjLeftJustified:
      THackgtPDFormField(FFormField).Justification := fjLeftJustified;
    gtCstPDFDoc.fjCentered:
      THackgtPDFormField(FFormField).Justification := fjCentered;
    gtCstPDFDoc.fjRightJustified:
      THackgtPDFormField(FFormField).Justification := fjRightJustified;
  end;
end;

procedure TgtFormField.SetMaxLen(const Value: Integer);
begin
  if FFormField.FormFieldType = ftText then
    TgtPDFormTextField(FFormField).MaxLength := Value;
end;

procedure TgtFormField.SetMultiLine(const Value: Boolean);
begin
  if FFormField.FormFieldType = ftText then
    TgtPDFormTextField(FFormField).IsMultiLine := Value;
end;

procedure TgtFormField.SetPrint(const Value: boolean);
var
  LPref: TgtAdditionalPreferences;
begin
  LPref := AdditionalPreferences;
  if Value then
  begin
    if not (afpPrint in LPref) then
      AdditionalPreferences := AdditionalPreferences + [afpPrint];
    if afpNoPrint in LPref then
      AdditionalPreferences := AdditionalPreferences - [afpNoPrint];
  end
  else
  begin
    if afpPrint in LPref then
      AdditionalPreferences := AdditionalPreferences - [afpPrint];
    if not (afpNoPrint in LPref) then
      AdditionalPreferences := AdditionalPreferences + [afpNoPrint];
  end;
end;

procedure TgtFormField.SetQualifiedName(const Value: string);
begin
  FFormField.FullQualifiedName := Value;
end;

procedure TgtFormField.SetRequired(const Value: Boolean);
begin
  if (Value) then
  begin
    if not (PDTypes.afpRequired in THackgtPDFormField(FFormField).Preferences) then
    THackgtPDFormField(FFormField).Preferences :=
      THackgtPDFormField(FFormField).Preferences + [PDTypes.afpRequired];
  end
  else
  begin
    if (PDTypes.afpRequired in THackgtPDFormField(FFormField).Preferences) then
    THackgtPDFormField(FFormField).Preferences :=
      THackgtPDFormField(FFormField).Preferences - [PDTypes.afpRequired];
  end;
end;

procedure TgtFormField.SetSubmitURL(const Value: string);
var
  LAction: TgtPDAction;
begin
  LAction := FFormField.Action;
  if Assigned(LAction) then
  begin
    if LAction.ActionType = actionSubmitForm then
    begin
      TgtPDSubmitFormAction(FFormField.Action).URL := Value;
    end;
  end;
end;

procedure TgtFormField.SetTransparent(const Value: Boolean);
begin
  THackgtPDFormField(FFormField).Transparent := Value;
end;

procedure TgtFormField.SetVisible(const Value: boolean);
begin
  if (not Value) then
    AdditionalPreferences := [afpInvisible];
end;

{ TgtCustomPDFInfo }

constructor TgtCustomPDFInfo.Create;
begin

end;

constructor TgtCustomPDFInfo.Create(Schema: TgtCustomInfoSchema);
begin

end;

destructor TgtCustomPDFInfo.Destroy;
begin

  inherited;
end;

// FileAttachment

constructor TgtPDFFileAttachment.Create;
begin
  FAnnot := TgtPDFileAttachmentAnnot.Create;
  FFileAttachmentIcon := faPaperclip;
  FIconColor := clBlue;
end;

{------------------------------------------------------------------------------}

destructor TgtPDFFileAttachment.Destroy;
begin
  if Assigned(FAnnot) then
    FreeAndNil(FAnnot);
  inherited;
end;

function TgtPDFFileAttachment.GetAttachName: WideString;
begin
  Result := TgtPDFileAttachmentAnnot(FAnnot).AttachmentName;
end;

function TgtPDFFileAttachment.GetFileName: WideString;
begin
  Result := TgtPDFileAttachmentAnnot(FAnnot).FileName;
end;

function TgtPDFFileAttachment.GetIcon: TgtFileAttachmentIcon;
begin
  Result := TgtFileAttachmentIcon(TgtPDFileAttachmentAnnot(FAnnot).AttachmentIcon);
end;

function TgtPDFFileAttachment.GetIconColor: TColor;
var
  R, G, B: Byte;
begin
  R := Round(TgtPDFileAttachmentAnnot(FAnnot).IconColor.value[0]);
  G := Round(TgtPDFileAttachmentAnnot(FAnnot).IconColor.value[1]);
  B := Round(TgtPDFileAttachmentAnnot(FAnnot).IconColor.value[2]);
  Result := RGB(R, G, B);
end;

{------------------------------------------------------------------------------}

procedure TgtPDFFileAttachment.SetAttachName(const Value: WideString);
begin
  TgtPDFileAttachmentAnnot(FAnnot).AttachmentName := Value;
end;

procedure TgtPDFFileAttachment.SetFileName(const Value: WideString);
begin
  TgtPDFileAttachmentAnnot(FAnnot).FileName := Value;
end;

procedure TgtPDFFileAttachment.SetIcon(const Value: TgtFileAttachmentIcon);
var
  LAttachmentIcon: PDFileAttachmentAnnot.TgtFileAttachmentIcon;
begin
  case Value of
    faGraph: LAttachmentIcon := PDFileAttachmentAnnot.faGraph;
    faPaperclip: LAttachmentIcon := PDFileAttachmentAnnot.faPaperclip;
    faPushPin: LAttachmentIcon := PDFileAttachmentAnnot.faPushPin;
    faTag: LAttachmentIcon := PDFileAttachmentAnnot.faTag;
  end;
  TgtPDFileAttachmentAnnot(FAnnot).AttachmentIcon := LAttachmentIcon;
end;

procedure TgtPDFFileAttachment.SetIconColor(const Value: TColor);
var
  LColor: TgtPDColorValue;
begin
  LColor.ColorSpace := DeviceRGB; {RGB}
  LColor.Value[0] := GetRValue(Value) / 255;
  LColor.Value[1] := GetGValue(Value) / 255;
  LColor.Value[2] := GetBValue(Value) / 255;
  TgtPDFileAttachmentAnnot(FAnnot).IconColor := LColor;
end;

//TgtPDFAnnotation

constructor TgtPDFAnnotation.Create;
begin
//  FBorderWidth := 1.0;
  FIsSetMeasurementUnit := False;
end;

constructor TgtPDFAnnotation.Create(AObject: TgtPDAnnot);
begin
  FAnnot := AObject;
end;

destructor TgtPDFAnnotation.Destroy;
begin
  inherited;
end;

function TgtPDFAnnotation.GetAnnotType: TgtPDAnnotType;
begin
  case FAnnot.AnnotType of
    PDAnnot.annotText: Result := annotText;
    PDAnnot.annotLink: Result := annotLink;
    PDAnnot.annotFreeText: Result := annotFreeText;
    PDAnnot.annotLine: Result := annotLine;
    PDAnnot.annotSquare: Result := annotSquare;
    PDAnnot.annotCircle: Result := annotCircle;
    PDAnnot.annotPolygon: Result := annotPolygon;
    PDAnnot.annotPolyLine: Result := annotPolyLine;
    PDAnnot.annotHighlight: Result := annotHighlight;
    PDAnnot.annotUnderline: Result := annotUnderline;
    PDAnnot.annotSquiggly: Result := annotSquiggly;
    PDAnnot.annotStrikeOut: Result := annotStrikeOut;
    PDAnnot.annotStamp: Result := annotStamp;
    PDAnnot.annotCaret: Result := annotCaret;
    PDAnnot.annotInk: Result := annotInk;
    PDAnnot.annotPopup: Result := annotPopup;
    PDAnnot.annotFileAttachment: Result := annotFileAttachment;
    PDAnnot.annotSound: Result := annotSound;
    PDAnnot.annotMovie: Result := annotMovie;
    PDAnnot.annotWidget: Result := annotWidget;
    PDAnnot.annotScreen: Result := annotScreen;
    PDAnnot.annotPrinterMark: Result := annotPrinterMark;
    PDAnnot.annotTrapNet: Result := annotTrapNet;
    PDAnnot.annotWatermark: Result := annotWatermark;
    PDAnnot.annot3D: Result := annot3D;
  end;
end;

function TgtPDFAnnotation.GetBackgroundColor: TColor;
var
  R, G, B: Byte;
begin
  R := Round(FAnnot.Color.value[0] * 255);
  G := Round(FAnnot.Color.value[1] * 255);
  B := Round(FAnnot.Color.value[2] * 255);
  Result := RGB(R, G, B);
end;

function TgtPDFAnnotation.GetBorderStyle: TgtAnnotBorderStyle;
begin
  case FAnnot.BorderStyle of
    absSolid: Result := bsSolid;
    absDashed: Result := bsDashed;
    absBeveled: Result := bsBeveled;
    absInset: Result := bsInset;
    absUnderline: Result := bsUnderline;
  end;
end;

function TgtPDFAnnotation.GetBorderWidth: Double;
begin
  if FIsSetMeasurementUnit then
    Result := ConvertToMU(FMeasurementUnit, FAnnot.BorderWidth)
  else
    Result := FAnnot.BorderWidth;
end;

function TgtPDFAnnotation.GetContents: WideString;
begin
  Result := FAnnot.Contents;
end;

function TgtPDFAnnotation.GetName: string;
begin
  Result := FAnnot.Name;
end;

function TgtPDFAnnotation.GetRectBottom: Double;
begin
  if Assigned(FAnnot.Rect) then
  begin
    if FIsSetMeasurementUnit then
      Result := ConvertToMU(FMeasurementUnit, FAnnot.Rect.Bottom)
    else
      Result := FAnnot.Rect.Bottom;
  end;
end;

function TgtPDFAnnotation.GetRectLeft: Double;
begin
  if Assigned(FAnnot.Rect) then
  begin
    if FIsSetMeasurementUnit then
      Result := ConvertToMU(FMeasurementUnit, FAnnot.Rect.Left)
    else
      Result := FAnnot.Rect.Left;
  end;
end;

function TgtPDFAnnotation.GetRectRight: Double;
begin
  if Assigned(FAnnot.Rect) then
  begin
    if FIsSetMeasurementUnit then
      Result := ConvertToMU(FMeasurementUnit, FAnnot.Rect.Right)
    else
      Result := FAnnot.Rect.Right;
  end;
end;

function TgtPDFAnnotation.GetRectTop: Double;
begin
  if Assigned(FAnnot.Rect) then
  begin
    if FIsSetMeasurementUnit then
      Result := ConvertToMU(FMeasurementUnit, FAnnot.Rect.Top)
    else
      Result := FAnnot.Rect.Top;
  end;
end;

function TgtPDFAnnotation.GetTitle: WideString;
begin
  Result := FAnnot.Title;
end;

{------------------------------------------------------------------------------}

procedure TgtPDFAnnotation.SetBackgroundColor(const Value: TColor);
var
  LColor: TgtPDColorValue;
begin
  LColor.ColorSpace := DeviceRGB; {RGB}
  LColor.Value[0] := GetRValue(Value) / 255;
  LColor.Value[1] := GetGValue(Value) / 255;
  LColor.Value[2] := GetBValue(Value) / 255;
  FAnnot.Color := LColor;
end;

procedure TgtPDFAnnotation.SetBorderStyle(const Value: TgtAnnotBorderStyle);
begin
  case Value of
    bsSolid: FAnnot.BorderStyle := absSolid;
    bsDashed: FAnnot.BorderStyle := absDashed;
    bsBeveled: FAnnot.BorderStyle := absBeveled;
    bsInset: FAnnot.BorderStyle := absInset;
    bsUnderline: FAnnot.BorderStyle := absUnderline;
  end;
end;

procedure TgtPDFAnnotation.SetBorderWidth(const Value: Double);
begin
  FAnnot.BorderWidth := Value;
end;

procedure TgtPDFAnnotation.SetBounds(Left, Top, Right, Bottom: Double);
begin
  if Assigned(FAnnot.Rect) then
  begin
    FAnnot.Rect.Top := Top;
    FAnnot.Rect.Left := Left;
    FAnnot.Rect.Right := Right;
    FAnnot.Rect.Bottom := Bottom;
  end;
end;

{------------------------------------------------------------------------------}

procedure TgtPDFAnnotation.SetContents(const Value: WideString);
begin
  FAnnot.Contents := Value;
end;

procedure TgtPDFAnnotation.SetMeasurementUnit(const Value: TgtMeasurementUnit);
begin
  FMeasurementUnit := Value;
  RectLeft := ConvertToPDFUnit(FMeasurementUnit, RectLeft);
  RectTop := ConvertToPDFUnit(FMeasurementUnit, RectTop);
  RectRight := ConvertToPDFUnit(FMeasurementUnit, RectRight);
  RectBottom := ConvertToPDFUnit(FMeasurementUnit, RectBottom);
  BorderWidth := ConvertToPDFUnit(FMeasurementUnit, BorderWidth);
  FIsSetMeasurementUnit := True;
end;

procedure TgtPDFAnnotation.SetName(const Value: string);
begin
  FAnnot.Name := Value;
end;

procedure TgtPDFAnnotation.SetRectBottom(const Value: Double);
begin
  FAnnot.Rect.Bottom := Value;
end;

procedure TgtPDFAnnotation.SetRectLeft(const Value: Double);
begin
  FAnnot.Rect.Left := Value;
end;

procedure TgtPDFAnnotation.SetRectRight(const Value: Double);
begin
  FAnnot.Rect.Right := Value;
end;

procedure TgtPDFAnnotation.SetRectTop(const Value: Double);
begin
  FAnnot.Rect.Top := Value;
end;

procedure TgtPDFAnnotation.SetTitle(const Value: WideString);
begin
  FAnnot.Title := Value;
end;

//TgtPDFLineAnnotation

constructor TgtPDFLineAnnotation.Create;
begin
  inherited;
  FAnnot := TgtPDLineAnnot.Create;
//  FLineBeginingStyle := laNone;
//  FLineEndingStyle := laNone;
end;

destructor TgtPDFLineAnnotation.Destroy;
begin
  if Assigned(FAnnot) then
    FreeAndNil(FAnnot);
  inherited;
end;

function TgtPDFLineAnnotation.GetLineBeginingStyle: TgtLineStyle;
begin
  case TgtPDLineAnnot(FAnnot).LineBeginningStyle of
    PDAnnot.laSquare: Result := laSquare;
    PDAnnot.laCircle: Result := laCircle;
    PDAnnot.laDiamond: Result := laDiamond;
    PDAnnot.laOpenArrow: Result := laOpenArrow;
    PDAnnot.laClosedArrow: Result := laClosedArrow;
    PDAnnot.laNone: Result := laNone;
//    PDAnnot.laButt: Result := ;
//    PDAnnot.laROpenArrow: Result := ;
//    PDAnnot.laRClosedArrow: Result := ;
//    PDAnnot.laSlash: Result := ;
  end;
end;

function TgtPDFLineAnnotation.GetLineEndingStyle: TgtLineStyle;
begin
  case TgtPDLineAnnot(FAnnot).LineEndingStyle of
    PDAnnot.laSquare: Result := laSquare;
    PDAnnot.laCircle: Result := laCircle;
    PDAnnot.laDiamond: Result := laDiamond;
    PDAnnot.laOpenArrow: Result := laOpenArrow;
    PDAnnot.laClosedArrow: Result := laClosedArrow;
    PDAnnot.laNone: Result := laNone;
  end;
end;

function TgtPDFLineAnnotation.GetLineInteriorColor: TColor;
var
  R, G, B: Byte;
begin
  R := Round(TgtPDLineAnnot(FAnnot).InteriorColor.value[0] * 255);
  G := Round(TgtPDLineAnnot(FAnnot).InteriorColor.value[1] * 255);
  B := Round(TgtPDLineAnnot(FAnnot).InteriorColor.value[2] * 255);
  Result := RGB(R, G, B);
end;

function TgtPDFLineAnnotation.GetX1: Double;
begin
  if FIsSetMeasurementUnit then
    Result := ConvertToMU(FMeasurementUnit, TgtPDLineAnnot(FAnnot).X1)
  else
    Result := TgtPDLineAnnot(FAnnot).X1;
end;

function TgtPDFLineAnnotation.GetX2: Double;
begin
  if FIsSetMeasurementUnit then
    Result := ConvertToMU(FMeasurementUnit, TgtPDLineAnnot(FAnnot).X2)
  else
    Result := TgtPDLineAnnot(FAnnot).X2;
end;

function TgtPDFLineAnnotation.GetY1: Double;
begin
  if FIsSetMeasurementUnit then
    Result := ConvertToMU(FMeasurementUnit, TgtPDLineAnnot(FAnnot).Y1)
  else
    Result := TgtPDLineAnnot(FAnnot).Y1;
end;

function TgtPDFLineAnnotation.GetY2: Double;
begin
  if FIsSetMeasurementUnit then
    Result := ConvertToMU(FMeasurementUnit, TgtPDLineAnnot(FAnnot).Y2)
  else
    Result := TgtPDLineAnnot(FAnnot).Y2;
end;

{------------------------------------------------------------------------------}

procedure TgtPDFLineAnnotation.gtLine(XX1, YY1, XX2, YY2: Double);
begin
  TgtPDLineAnnot(FAnnot).X1 := XX1;
  TgtPDLineAnnot(FAnnot).Y1 := YY1;
  TgtPDLineAnnot(FAnnot).X2 := XX2;
  TgtPDLineAnnot(FAnnot).Y2 := YY2;
end;

procedure TgtPDFLineAnnotation.SetLineBeginingStyle(const Value: TgtLineStyle);
begin
  case Value of
    laSquare: TgtPDLineAnnot(FAnnot).LineBeginningStyle := PDAnnot.laSquare;
    laCircle: TgtPDLineAnnot(FAnnot).LineBeginningStyle := PDAnnot.laCircle;
    laDiamond: TgtPDLineAnnot(FAnnot).LineBeginningStyle := PDAnnot.laDiamond;
    laOpenArrow: TgtPDLineAnnot(FAnnot).LineBeginningStyle := PDAnnot.laOpenArrow;
    laClosedArrow: TgtPDLineAnnot(FAnnot).LineBeginningStyle := PDAnnot.laClosedArrow;
    laNone: TgtPDLineAnnot(FAnnot).LineBeginningStyle := PDAnnot.laNone;
  end;
end;

procedure TgtPDFLineAnnotation.SetLineEndingStyle(const Value: TgtLineStyle);
begin
  case Value of
    laSquare: TgtPDLineAnnot(FAnnot).LineEndingStyle := PDAnnot.laSquare;
    laCircle: TgtPDLineAnnot(FAnnot).LineEndingStyle := PDAnnot.laCircle;
    laDiamond: TgtPDLineAnnot(FAnnot).LineEndingStyle := PDAnnot.laDiamond;
    laOpenArrow: TgtPDLineAnnot(FAnnot).LineEndingStyle := PDAnnot.laOpenArrow;
    laClosedArrow: TgtPDLineAnnot(FAnnot).LineEndingStyle := PDAnnot.laClosedArrow;
    laNone: TgtPDLineAnnot(FAnnot).LineEndingStyle := PDAnnot.laNone;
  end;
end;

procedure TgtPDFLineAnnotation.SetLineInteriorColor(const Value: TColor);
var
  LColor: TgtPDColorValue;
begin
  LColor.ColorSpace := DeviceRGB; {RGB}
  LColor.Value[0] := GetRValue(Value) / 255;
  LColor.Value[1] := GetGValue(Value) / 255;
  LColor.Value[2] := GetBValue(Value) / 255;
  TgtPDLineAnnot(FAnnot).InteriorColor := LColor;
end;

procedure TgtPDFLineAnnotation.SetMeasurementUnit(
  const Value: TgtMeasurementUnit);
begin
  inherited;
  TgtPDLineAnnot(FAnnot).X1 := ConvertToPDFUnit(FMeasurementUnit,
    TgtPDLineAnnot(FAnnot).X1);
  TgtPDLineAnnot(FAnnot).X2 := ConvertToPDFUnit(FMeasurementUnit,
    TgtPDLineAnnot(FAnnot).X2);
  TgtPDLineAnnot(FAnnot).Y1 := ConvertToPDFUnit(FMeasurementUnit,
    TgtPDLineAnnot(FAnnot).Y1);
  TgtPDLineAnnot(FAnnot).Y2 := ConvertToPDFUnit(FMeasurementUnit,
    TgtPDLineAnnot(FAnnot).Y2);
end;

procedure TgtPDFLineAnnotation.SetX1(const Value: Double);
begin
  TgtPDLineAnnot(FAnnot).X1 := Value;
end;

procedure TgtPDFLineAnnotation.SetX2(const Value: Double);
begin
  TgtPDLineAnnot(FAnnot).X2 := Value;
end;

procedure TgtPDFLineAnnotation.SetY1(const Value: Double);
begin
  TgtPDLineAnnot(FAnnot).Y1 := Value;
end;

procedure TgtPDFLineAnnotation.SetY2(const Value: Double);
begin
  TgtPDLineAnnot(FAnnot).Y2 := Value;
end;

// Circle Annotation

constructor TgtPDFCircleAnnotation.Create;
begin
  FAnnot := TgtPDCircleAnnot.Create;
end;

destructor TgtPDFCircleAnnotation.Destroy;
begin
  if Assigned(FAnnot) then
    FreeAndNil(FAnnot);
  inherited;
end;

function TgtPDFCircleAnnotation.GetCircleInteriorColor: TColor;
var
  R, G, B: Byte;
begin
  R := Round(TgtPDCircleAnnot(FAnnot).InteriorColor.Value[0] * 255);
  G := Round(TgtPDCircleAnnot(FAnnot).InteriorColor.Value[1] * 255);
  B := Round(TgtPDCircleAnnot(FAnnot).InteriorColor.Value[2] * 255);
  Result := RGB(R, G, B);
end;

function TgtPDFCircleAnnotation.GetIntensity: Double;
begin
  Result := TgtPDCircleAnnot(FAnnot).Intensity;
end;

function TgtPDFCircleAnnotation.GetIsCloudy: Boolean;
begin
  Result := TgtPDCircleAnnot(FAnnot).IsCloudy;
end;

procedure TgtPDFCircleAnnotation.SetCircleInteriorColor(const Value: TColor);
var
  LColor: TgtPDColorValue;
begin
  LColor.ColorSpace := DeviceRGB; {RGB}
  LColor.Value[0] := GetRValue(Value) / 255;
  LColor.Value[1] := GetGValue(Value) / 255;
  LColor.Value[2] := GetBValue(Value) / 255;
  TgtPDCircleAnnot(FAnnot).InteriorColor := LColor;
end;

procedure TgtPDFCircleAnnotation.SetIntensity(const Value: Double);
begin
  TgtPDCircleAnnot(FAnnot).Intensity := Value;
end;

procedure TgtPDFCircleAnnotation.SetIsCloudy(const Value: Boolean);
begin
  TgtPDCircleAnnot(FAnnot).IsCloudy := Value;
end;

// Square Annotation

constructor TgtPDFSquareAnnotation.Create;
begin
  FAnnot := TgtPDSquareAnnot.Create;
end;

destructor TgtPDFSquareAnnotation.Destroy;
begin
  if Assigned(FAnnot) then
    FreeAndNil(FAnnot);
  inherited;
end;

function TgtPDFSquareAnnotation.GetIntensity: Double;
begin
  Result := TgtPDSquareAnnot(FAnnot).Intensity;
end;

function TgtPDFSquareAnnotation.GetIsCloudy: Boolean;
begin
  Result := TgtPDSquareAnnot(FAnnot).IsCloudy;
end;

function TgtPDFSquareAnnotation.GetSquareInteriorColor: TColor;
var
  R, G, B: Byte;
begin
  R := Round(TgtPDSquareAnnot(FAnnot).InteriorColor.value[0] * 255);
  G := Round(TgtPDSquareAnnot(FAnnot).InteriorColor.value[1] * 255);
  B := Round(TgtPDSquareAnnot(FAnnot).InteriorColor.value[2] * 255);
  Result := RGB(R, G, B);
end;

procedure TgtPDFSquareAnnotation.SetIntensity(const Value: Double);
begin
  TgtPDSquareAnnot(FAnnot).Intensity := Value;
end;

procedure TgtPDFSquareAnnotation.SetIsCloudy(const Value: Boolean);
begin
  TgtPDSquareAnnot(FAnnot).IsCloudy := Value;
end;

procedure TgtPDFSquareAnnotation.SetSquareInteriorColor(const Value: TColor);
var
  LColor: TgtPDColorValue;
begin
  LColor.ColorSpace := DeviceRGB; {RGB}
  LColor.Value[0] := GetRValue(Value) / 255;
  LColor.Value[1] := GetGValue(Value) / 255;
  LColor.Value[2] := GetBValue(Value) / 255;
  TgtPDSquareAnnot(FAnnot).InteriorColor := LColor;
end;

{ TgtAnnotationList }

function TgtAnnotationList.GetAnnotation(I: Integer): TgtPDFAnnotation;
begin
  Result := TgtPDFAnnotation(inherited Get(I));
end;

{ TgtPDFLinkAnnotation }

constructor TgtPDFLinkAnnotation.Create;
begin
  inherited;
  FAnnot := TgtPDLinkAnnot.Create;
end;

destructor TgtPDFLinkAnnotation.Destroy;
begin
  if Assigned(FAnnot) then
    FreeAndNil(FAnnot);
//  if Assigned(FLinkAction) then
//    FreeAndNil(FLinkAction);
  inherited;
end;

function TgtPDFLinkAnnotation.GetAction: TgtPDFAction;
begin
  if not Assigned(FLinkAction) then
  begin
    FLinkAction := TgtPDFAction.Create;
    THackgtPDFAction(FLinkAction).FAction := TgtPDLinkAnnot(FAnnot).Action;
  end;
  Result := FLinkAction;
end;

function TgtPDFLinkAnnotation.GetHighlightType: TgtLinkHighlightType;
begin
  case TgtPDLinkAnnot(FAnnot).HighLightType of
    lhInvert: Result := laInvert;
    lhOutline: Result := laOutline;
    lhPush: Result := laPush;
    //lhNone: Result := ;
  end;
end;

procedure TgtPDFLinkAnnotation.SetAction(const Value: TgtPDFAction);
begin
  FLinkAction := Value;
  TgtPDLinkAnnot(FAnnot).Action := THackgtPDFAction(FLinkAction).FAction;
end;

procedure TgtPDFLinkAnnotation.SetHighlightType(
  const Value: TgtLinkHighlightType);
begin
  case Value of
    laInvert: TgtPDLinkAnnot(FAnnot).HighLightType := lhInvert;
    laOutline: TgtPDLinkAnnot(FAnnot).HighLightType := lhOutline;
    laPush: TgtPDLinkAnnot(FAnnot).HighLightType := lhPush;
//    laNoHighLight: TgtPDLinkAnnot(FAnnot).HighLightType := ;
  end;
end;

{ TgtPDFPolygonAnnotation }

constructor TgtPDFPolygonAnnotation.Create;
begin
  FAnnot := TgtPDPolygonAnnot.Create;
end;

destructor TgtPDFPolygonAnnotation.Destroy;
begin
  if Assigned(FAnnot) then
    FreeAndNil(FAnnot);
  inherited;
end;

function TgtPDFPolygonAnnotation.GetIntensity: Double;
begin
  Result := TgtPDPolygonAnnot(FAnnot).Intensity;
end;

function TgtPDFPolygonAnnotation.GetIsCloudy: Boolean;
begin
  Result := TgtPDPolygonAnnot(FAnnot).IsCloudy;
end;

function TgtPDFPolygonAnnotation.GetVertices: WideString;
begin
  Result := TgtPDPolygonAnnot(FAnnot).GetVertices;
end;

procedure TgtPDFPolygonAnnotation.SetIntensity(const Value: Double);
begin
  TgtPDPolygonAnnot(FAnnot).Intensity := Value;
end;

procedure TgtPDFPolygonAnnotation.SetIsCloudy(const Value: Boolean);
begin
  TgtPDPolygonAnnot(FAnnot).IsCloudy := Value;
end;

procedure TgtPDFPolygonAnnotation.SetMeasurementUnit(
  const Value: TgtMeasurementUnit);
var
  LStringList: TStringList;
  I: Integer;
begin
  inherited;
  LStringList := TStringList.Create;
  try
    LStringList.CommaText := GetVertices;
    for I := 0 to LStringList.Count - 1 do
    begin
      LStringList[I] := FloatToStrLocale(ConvertToPDFUnit(FMeasurementUnit,
         StrToFloatLocale(LStringList[I])));
    end;
    SetVertices(LStringList.CommaText);
  finally
    LStringList.Free;
  end;
end;

procedure TgtPDFPolygonAnnotation.SetVertices(AVerticesString: string);
begin
  TgtPDPolygonAnnot(FAnnot).SetVertices(AVerticesString);
end;

{ TgtPDFPolylineAnnotation }

constructor TgtPDFPolylineAnnotation.Create;
begin
  FAnnot := TgtPDPolyLineAnnot.Create;
  TgtPDPolyLineAnnot(FAnnot).LineBeginningStyle := PDAnnot.laNone;
  TgtPDPolyLineAnnot(FAnnot).LineEndingStyle := PDAnnot.laNone;
end;

destructor TgtPDFPolylineAnnotation.Destroy;
begin
  if Assigned(FAnnot) then
    FreeAndNil(FAnnot);
  inherited;
end;

function TgtPDFPolylineAnnotation.GetLineEndingStyle: TgtLineStyle;
begin
  case TgtPDPolyLineAnnot(FAnnot).LineEndingStyle of
    PDAnnot.laSquare: Result := laSquare;
    PDAnnot.laCircle: Result := laCircle;
    PDAnnot.laDiamond: Result := laDiamond;
    PDAnnot.laOpenArrow: Result := laOpenArrow;
    PDAnnot.laClosedArrow: Result := laClosedArrow;
    PDAnnot.laNone: Result := laNone;
  end;
end;

function TgtPDFPolylineAnnotation.GetVertices: WideString;
begin
  Result := TgtPDPolyLineAnnot(FAnnot).GetVertices;
end;

procedure TgtPDFPolylineAnnotation.SetLineEndingStyle(
  const Value: TgtLineStyle);
begin
  case Value of
    laSquare: TgtPDPolyLineAnnot(FAnnot).LineEndingStyle := PDAnnot.laSquare;
    laCircle: TgtPDPolyLineAnnot(FAnnot).LineEndingStyle := PDAnnot.laCircle;
    laDiamond: TgtPDPolyLineAnnot(FAnnot).LineEndingStyle := PDAnnot.laDiamond;
    laOpenArrow: TgtPDPolyLineAnnot(FAnnot).LineEndingStyle := PDAnnot.laOpenArrow;
    laClosedArrow: TgtPDPolyLineAnnot(FAnnot).LineEndingStyle := PDAnnot.laClosedArrow;
    laNone: TgtPDPolyLineAnnot(FAnnot).LineEndingStyle := PDAnnot.laNone;
  end;
end;

procedure TgtPDFPolylineAnnotation.SetMeasurementUnit(
  const Value: TgtMeasurementUnit);
var
  LStringList: TStringList;
  I: Integer;
begin
  inherited;
  LStringList := TStringList.Create;
  try
    LStringList.CommaText := GetVertices;
    for I := 0 to LStringList.Count - 1 do
    begin
      LStringList[I] := FloatToStrLocale(ConvertToPDFUnit(FMeasurementUnit,
         StrToFloatLocale(LStringList[I])));
    end;
    SetVertices(LStringList.CommaText);
  finally
    LStringList.Free;
  end;
end;

procedure TgtPDFPolylineAnnotation.SetVertices(AVerticesString: string);
begin
  TgtPDPolyLineAnnot(FAnnot).SetVertices(AVerticesString);
end;

{ TgtPDFCaretAnnotation }

constructor TgtPDFCaretAnnotation.Create;
begin
  FAnnot := TgtPDCaretAnnot.Create;
end;

destructor TgtPDFCaretAnnotation.Destroy;
begin
  if Assigned(FAnnot) then
    FreeAndNil(FAnnot);
  inherited;
end;

function TgtPDFCaretAnnotation.GetCaretSymbol: TgtCaretSymbol;
begin
  case TgtPDCaretAnnot(FAnnot).CaretSymbol of
    csParagraph: Result := caParagraph;
    csNone: Result := caNoSymbol;
  end;
end;

procedure TgtPDFCaretAnnotation.SetCaretSymbol(const Value: TgtCaretSymbol);
begin
  case Value of
    caParagraph: TgtPDCaretAnnot(FAnnot).CaretSymbol := csParagraph;
    caNoSymbol: TgtPDCaretAnnot(FAnnot).CaretSymbol := csNone;
  end;
end;

{ TgtPDFStampAnnotation }

constructor TgtPDFStampAnnotation.Create;
begin
  FAnnot := TgtPDRubberStampAnnot.Create;
end;

destructor TgtPDFStampAnnotation.Destroy;
begin
  if Assigned(FAnnot) then
    FreeAndNil(FAnnot);
  inherited;
end;

{ TgtPDFTextAnnotation }

constructor TgtPDFTextAnnotation.Create;
begin
  FAnnot := TgtPDTextAnnot.Create;
end;

destructor TgtPDFTextAnnotation.Destroy;
begin
  if Assigned(FAnnot) then
    FreeAndNil(FAnnot);
  inherited;
end;

function TgtPDFTextAnnotation.GetFlag: TgtAnnotationFlag;
var
  LFlag: TgtPDAnnotFlags;
begin
  LFlag := TgtPDTextAnnot(FAnnot).Flags;
  if PDAnnot.afInvisible in LFlag then
    Result := annotInvisible
  else if PDAnnot.afHidden in LFlag then
    Result := annotHidden
  else if PDAnnot.afPrint in LFlag then
    Result := annotPrint
  else if PDAnnot.afNoZoom in LFlag then
    Result := annotNoZoom
  else if PDAnnot.afNoRotate in LFlag then
    Result := annotNoRotate
  else if PDAnnot.afNoView in LFlag then
    Result := annotNoView
  else if PDAnnot.afReadOnly in LFlag then
    Result := annotReadOnly;
end;

function TgtPDFTextAnnotation.GetOpen: Boolean;
begin
  Result := TgtPDTextAnnot(FAnnot).Open;
end;

procedure TgtPDFTextAnnotation.SetFlag(const Value: TgtAnnotationFlag);
begin
  case value of
    annotInvisible: TgtPDTextAnnot(FAnnot).Flags :=
      TgtPDTextAnnot(FAnnot).Flags + [afInvisible];
    annotHidden: TgtPDTextAnnot(FAnnot).Flags :=
      TgtPDTextAnnot(FAnnot).Flags + [afHidden];
    annotPrint: TgtPDTextAnnot(FAnnot).Flags :=
      TgtPDTextAnnot(FAnnot).Flags + [afPrint];
    annotNoZoom: TgtPDTextAnnot(FAnnot).Flags :=
      TgtPDTextAnnot(FAnnot).Flags + [afNoZoom];
    annotNoRotate: TgtPDTextAnnot(FAnnot).Flags :=
      TgtPDTextAnnot(FAnnot).Flags + [afNoRotate];
    annotNoView: TgtPDTextAnnot(FAnnot).Flags :=
      TgtPDTextAnnot(FAnnot).Flags + [afNoView];
    annotReadOnly: TgtPDTextAnnot(FAnnot).Flags :=
      TgtPDTextAnnot(FAnnot).Flags + [afReadOnly];
  end;
end;

procedure TgtPDFTextAnnotation.setOpen(const Value: Boolean);
begin
  TgtPDTextAnnot(FAnnot).Open := Value;
end;

{ TgtPDFFreeTextAnnotation }

constructor TgtPDFFreeTextAnnotation.Create;
begin
  FAnnot := TgtPDFreeTextAnnot.Create;
end;

destructor TgtPDFFreeTextAnnotation.Destroy;
begin
  if Assigned(FAnnot) then
    FreeAndNil(FAnnot);
  inherited;
end;

function TgtPDFFreeTextAnnotation.GetBorderColor: Tcolor;
var
  R, G, B: Byte;
begin
  R := Round(FAnnot.Color.value[0] * 255);
  G := Round(FAnnot.Color.value[1] * 255);
  B := Round(FAnnot.Color.value[2] * 255);
  Result := RGB(R, G, B);
end;

function TgtPDFFreeTextAnnotation.GetFont: TFont;
begin
  //Result := TgtPDFreeTextAnnot(FAnnot).Font;
end;

function TgtPDFFreeTextAnnotation.GetTextAllignment: TgtFreeTextAllignment;
begin
  case TgtPDFreeTextAnnot(FAnnot).TextAllign of
    PDFreeTextAnnot.ftLeftJustified: Result := ftaLeftJustified;
    PDFreeTextAnnot.ftCentered: Result := ftaCentered;
    PDFreeTextAnnot.ftRightJustified: Result := ftaRightJustified;
  end;
end;

procedure TgtPDFFreeTextAnnotation.SetBorderColor(const Value: Tcolor);
var
  LColor: TgtPDColorValue;
begin
  LColor.ColorSpace := DeviceRGB; {RGB}
  LColor.Value[0] := GetRValue(Value) / 255;
  LColor.Value[1] := GetGValue(Value) / 255;
  LColor.Value[2] := GetBValue(Value) / 255;
  FAnnot.Color := LColor;
end;

procedure TgtPDFFreeTextAnnotation.SetTextAllignment(
  const Value: TgtFreeTextAllignment);
begin
  case Value of
    ftaLeftJustified: TgtPDFreeTextAnnot(FAnnot).TextAllign := ftLeftJustified;
    ftaCentered: TgtPDFreeTextAnnot(FAnnot).TextAllign := ftCentered;
    ftaRightJustified: TgtPDFreeTextAnnot(FAnnot).TextAllign := ftRightJustified;
  end;
end;

procedure TgtPDFFreeTextAnnotation.SetTextFont(const Value: TFont);
begin
  if Assigned(TgtPDFreeTextAnnot(FAnnot).Font) then
  begin
    with TgtPDFreeTextAnnot(FAnnot).Font do
    begin
      Name := Value.Name;
      Size := Value.Size;
      Color := Value.Size;
      Style := Value.Style;
    end;
  end;
end;

{ TgtPDFInkAnnotation }

constructor TgtPDFInkAnnotation.Create;
begin
  FAnnot := TgtPDInkAnnot.Create;
end;

destructor TgtPDFInkAnnotation.Destroy;
begin
  if Assigned(FAnnot) then
    FreeAndNil(FAnnot);
  inherited;
end;

function TgtPDFInkAnnotation.GetInkList: string;
begin
  Result := TgtPDInkAnnot(FAnnot).InkList;
end;

procedure TgtPDFInkAnnotation.SetInkList(const Value: string);
begin
  TgtPDInkAnnot(FAnnot).InkList := Value;
end;

procedure TgtPDFInkAnnotation.SetMeasurementUnit(
  const Value: TgtMeasurementUnit);
var
  LStringList: TStringList;
  I: Integer;
begin
  inherited;
  LStringList := TStringList.Create;
  try
    LStringList.CommaText := InkList;
    for I := 0 to LStringList.Count - 1 do
    begin
      LStringList[I] := FloatToStrLocale(ConvertToPDFUnit(FMeasurementUnit,
        StrToFloatLocale(LStringList[I])));
    end;
    InkList := LStringList.CommaText;
  finally
    LStringList.Free;
  end;
end;

{ TgtPDFMarkUpAnnotation }

constructor TgtPDFMarkUpAnnotation.Create;
begin
  FAnnot := TgtPDMarkUpAnnot.Create(PDMarkUpAnnot.maHighlight)
end;

destructor TgtPDFMarkUpAnnotation.Destroy;
begin
  if Assigned(FAnnot) then
    FreeAndNil(FAnnot);
  inherited;
end;

function TgtPDFMarkUpAnnotation.GetMarkUpType: TgtMarkUpType;
begin
  Result := maHighLight;
  case TgtPDMarkUpAnnot(FAnnot).AnnotType of
    PDAnnot.annotHighlight: Result := maHighlight;
    PDAnnot.annotUnderline: Result := maUnderline;
    PDAnnot.annotSquiggly: Result := maSquiggly;
    PDAnnot.annotStrikeOut: Result := maStrikeOut;
  end;
end;

procedure TgtPDFMarkUpAnnotation.SetMarkUpType(const Value: TgtMarkUpType);
begin
  case Value of
    maHighlight: TgtPDMarkUpAnnot(FAnnot).AnnotType := PDAnnot.annotHighlight;
    maUnderline: TgtPDMarkUpAnnot(FAnnot).AnnotType := PDAnnot.annotUnderline;
    maSquiggly: TgtPDMarkUpAnnot(FAnnot).AnnotType := PDAnnot.annotSquiggly;
    maStrikeOut: TgtPDMarkUpAnnot(FAnnot).AnnotType := PDAnnot.annotStrikeOut;
  end;
end;

procedure TgtPDFMarkUpAnnotation.SetMeasurementUnit(
  const Value: TgtMeasurementUnit);
begin
  inherited;
  FX1 := ConvertToPDFUnit(FMeasurementUnit, FX1);
  FY1 := ConvertToPDFUnit(FMeasurementUnit, FY1);
  FX2 := ConvertToPDFUnit(FMeasurementUnit, FX2);
  FY2 := ConvertToPDFUnit(FMeasurementUnit, FY2);
  FX3 := ConvertToPDFUnit(FMeasurementUnit, FX3);
  FY3 := ConvertToPDFUnit(FMeasurementUnit, FY3);
  FX4 := ConvertToPDFUnit(FMeasurementUnit, FX4);
  FY4 := ConvertToPDFUnit(FMeasurementUnit, FY4);
  SetQuad(FX1, FY1, FX2, FY2, FX3, FY3, FX4, FY4);
end;

procedure TgtPDFMarkUpAnnotation.SetQuad(X1, Y1, X2, Y2, X3, Y3, X4,
  Y4: Double);
begin
  // For measurement unit Conversion
  FX1 := X1;
  FY1 := Y1;
  FX2 := X2;
  FY2 := Y2;
  FX3 := X3;
  FY3 := Y3;
  FX4 := X4;
  FY4 := Y4;
  TgtPDMArkUPAnnot(FAnnot).SetQuadPoints(X1, Y1, X2, Y2, X3, Y3, X4, Y4);
end;

constructor TgtPDFDocumentLevelAction.Create;
begin
  inherited;
end;

destructor TgtPDFDocumentLevelAction.Destroy;
begin

  inherited;
end;

{ TgtPDFPageLevelAction }

constructor TgtPDFPageLevelAction.Create;
begin
  inherited;
end;

destructor TgtPDFPageLevelAction.Destroy;
begin

  inherited;
end;

{ TgtFontInfo }

constructor TgtFontInfo.Create;
begin

end;

destructor TgtFontInfo.Destroy;
begin
  if Assigned(FFont) then
    FreeAndNil(FFont);
  inherited;
end;

function TgtFontInfo.GetColor: string;
begin
  Result := FColor;
end;

function TgtFontInfo.GetFont: TFont;
begin
  Result := FFont;
end;

function TgtFontInfo.GetName: string;
begin
  Result := FName;
end;

procedure TgtFontInfo.SetColor(AColor: string);
begin
  FColor := AColor;
end;

procedure TgtFontInfo.SetFont(AFont: TFont);
begin
  if not Assigned(FFont) then
    FFont := TFont.Create;
  FFont.Assign(AFont);
end;

procedure TgtFontInfo.SetName(AName: string);
begin
  FName := AName;
end;

{ TgtPDFFontList }

function TgtPDFFontList.Get(Index: Integer): TgtPDFFontObject;
begin
  Result := TgtPDFFontObject(inherited Get(Index));
end;

{ TgtPDFFontObject }

constructor TgtPDFFontObject.Create(AObject: TgtPDFont);
begin
  FPDFont := AObject;
end;

constructor TgtPDFFontObject.Create;
begin

end;

destructor TgtPDFFontObject.Destroy;
begin
  inherited;
end;

function TgtPDFFontObject.GetBaseFont: string;
begin
  Result := FPDFont.BaseFont;
end;

function TgtPDFFontObject.GetEmbeddingType: TgtFontEmbedding;
begin
  case FPDFont.EmbeddingType of
    etNone: Result := tfeNone;
    etFull: Result := tfeFull;
    etSubset: Result := tfeSubset;
  end;
end;

function TgtPDFFontObject.GetEncodingName: string;
begin
  Result := FPDFont.EncodingName;
end;

function TgtPDFFontObject.GetFontName: WideString;
begin
  Result := FPDFont.Name;
end;

function TgtPDFFontObject.GetFontType: string;
begin
  case FPDFont.FontType of
    UnknowType: Result := 'UnknowType';
    Type1: Result := 'Type1';
    Type1C: Result := 'Type1C';
    Type1COT: Result := 'Type1COT';
    Type3: Result := 'Type3';
    TrueType: Result := 'TrueType';
    TrueTypeOT: Result := 'TrueTypeOT';
    CIDType0: Result := 'CIDType0';
    CIDType0C: Result := 'CIDType0C';
    CIDType0COT: Result := 'CIDType0COT';
    CIDType2: Result := 'CIDType2';
    CIDType2OT: Result := 'CIDType2OT';
  end;
end;

function TgtPDFFontObject.GetIsBold: Boolean;
begin
  Result := FPDFont.IsBold;
end;

function TgtPDFFontObject.GetIsItalic: Boolean;
begin
  Result := FPDFont.IsItalic;
end;

{ TgtPDFFormSignature }

constructor TgtPDFFormSignature.Create;
begin
  FFormField := TgtPDSignatureField.Create;
end;

destructor TgtPDFFormSignature.Destroy;
begin
  if Assigned(FSignature) then FreeAndNil(FSignature);
end;

function TgtPDFFormSignature.GetSignature: TgtPDSignature;
begin
  if not Assigned(FSignature) then
  begin
    FSignature := TgtPDSignature.Create;
    with TgtPDSignatureField(FFormField).Signature do
    begin
      FSignature.FAuthor := Author;
      FSignature.FContactInfo := ContactInfo;
      FSignature.FLocation := Location;
      FSignature.FReason := Reason;
      FSignature.FHandler := Handler;
      Result.FSubfilter := TgtSigSubfilter(Ord(SubFilter));
      FSignature.FDateTime := DateTime;
    end;
  end;
  Result := FSignature;
end;

{ TgtPDSignature }

constructor TgtPDSignature.Create;
begin

end;

destructor TgtPDSignature.Destroy;
begin

  inherited;
end;

end.
