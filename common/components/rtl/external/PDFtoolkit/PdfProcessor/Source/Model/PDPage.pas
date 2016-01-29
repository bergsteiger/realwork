{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Model                   }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

{$I ..\Utils\gtCompilerDefines.inc}

unit PDPage;

interface

uses
  Classes, gtObject, PDElement, PDBaseObject, PDAnnot, PDAction, PDResource,
  PDFont, PDXObject, PDColorSpace, Contnrs, PDRect, PDInteger, PDExportDevice,
  PDMatrix, PDContents, PDContentStream, PDTypes, PDInheritedProperty,
  PDFormField, Graphics, PDImage, PDFileAttachmentAnnot, PDLineAnnot,
  PDCircleAnnot, PDSquareAnnot, PDLinkAnnot, PDDictionary, PDPolygonAnnot,
  PDPolyLineAnnot, PDCaretAnnot, gtFont, PDRubberStampAnnot, PDInkAnnot,
  PDTextAnnot, PDFreeTextAnnot, PDIndirectRef, PDFormPushButton,
  PDFormCheckBox, PDFormRadioButton, PDFormComboBox, PDFormListBox,
  PDFormTextField, PDArray, PDRadioItem, PDFormChoiceBox, PDMarkUpAnnot,
  PDSignatureField, PDSignature, gtTypes, PDStream;


type

  TRenderMode = (rmUnderLay, rmOverLay);

  TgtPageActionTrigger = (atBeforePageOpen, atAfterPageClose);

  	(* Ellipse Control Points. *)
	TgtEllipseCtrlPoints = record
		X11, X22, X33, X44, X55,
		Y11, Y22, Y33, Y44, Y55: Double;
  end;

  TgtPathStatus = (psPathBegins, psPathEnds, psNoPath);

  TgtHackPDFormField = class(TgtPDFormField)

  end;

  TgtHackPDFormRadioButton = class(TgtPDFormRadioButton)

  end;

  TgtHackPDFormChoiceBox = class(TgtPDFormChoiceBox)

  end;

  TgtShapeType = (stLine, stRectangle, stRoundRect, stEllipse, stPolygon,
    stPolyLine, stArc, stChord, stPie, stPolyBezier);

   { TgtShapeItem }

  TgtShapeItem = class
  private
    FBrush: TBrush;
    FPen: TPen;
    FShapeType: TgtShapeType;
    FPoints: TPDPoints;
    FNoPoints: Integer;
    FPenJoinStyle: TgtPenJoinStyle;
    FPenCapStyle: TgtPenCapStyle;
    procedure SetPen(Value: TPen);
    procedure SetBrush(Value: TBrush);

  public
    constructor Create(IsFill: Boolean; ShapeType: TgtShapeType);
    destructor Destroy; override;
    function GetPoints: TPDPoints;
    procedure SetPoints(Points: array of TPDPoint);

    property NoPoints: Integer read FNoPoints write FNoPoints;
    property ShapeType: TgtShapeType read FShapeType write FShapeType;
    property Pen: TPen read FPen write SetPen;
    property Brush: TBrush read FBrush write SetBrush;
    property PenJoinStyle: TgtPenJoinStyle read FPenJoinStyle write FPenJoinStyle default pjsNone;
    property PenCapStyle: TgtPenCapStyle read FPenCapStyle write FPenCapStyle default pcsNone;
  end;

  { TgtPolyShapeItem }

  TgtPolyShapeItem = class
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

  { TgtPolyDrawItem }

  TgtPolyDrawItem = class
  private
    FBrush: TBrush;
    FPen: TPen;

    procedure SetPen(Value: TPen);
    procedure SetBrush(Value: TBrush);
  public
    FNoPoints: Integer;
    FOperations: array of Byte;       //The Operations On the Points
    FPoints: array of TPDPoint;       //The Points

    constructor Create();
    destructor Destroy; override;
    procedure SetPoints();

    property Pen: TPen read FPen write SetPen;
    property Brush: TBrush read FBrush write SetBrush;
  end;

  { TgtPolyPolygonItem }

  TgtPolyPolygonItem = class
  private
    FBrush: TBrush;
    FPen: TPen;
    FNoPoly: Integer;                   //Number Of Polygons
    FFillAlternate: Boolean;            //Poly Fill Mode

    procedure SetPen(Value: TPen);
    procedure SetBrush(Value: TBrush);
    procedure SetFillAlternate(const Value: Boolean);
  public
    FNoPoints: array of Integer;        //Number Of Vertices In Each Polygons
    FPoints: array of TPDPoint;         //The Vertices

    constructor Create();
    destructor Destroy; override;
    function GetPoints(Position : Integer):TPDPoint;
    procedure SetPoints();
    procedure SetNoPoints();
    property NoPoly: Integer read FNoPoly write FNoPoly;
    property Pen: TPen read FPen write SetPen;
    property Brush: TBrush read FBrush write SetBrush;
    property FillAlternate: Boolean read FFillAlternate write SetFillAlternate
    	default False;
  end;


  TgtPDPage = class(TgtPDElement)
  private
    LMemStream: TMemoryStream;
//    FIsChanged: Boolean;
    FAnnotList: TObjectList;
    FAdditionalAction: TgtPDAction;
    FMediaBox: TgtPDRect;
    FCropBox: TgtPDRect;
    FBleedBox: TgtPDRect;
    FTrimBox: TgtPDRect;
    FDuration: TgtPDInteger;
    FRotate: TgtPDInteger;
    FContents: TgtPDContents;
    FResource: TgtPDResource;
    FPageNum: Integer;
    FAttachmentList: TgtPDAnnotList;
//    FPageSize: TgtPageSize;
    FFormFieldCount: Integer;
    FCurrentCS: TgtPDContentStream;
//    FRenderMode: TRenderMode;
    FRenderedFields: TList;
    FIsInheritedCropBox: Boolean;
    FIsInheritedMediaBox: Boolean;
    FPathStatus  : TgtPathStatus;
    FFirstPoint : Boolean;

    function GetBleedBox: TgtPDRect;
    function GetCropBox: TgtPDRect;
    function GetMediaBox: TgtPDRect;
    function GetAttachmentCount: Integer;
    function GetAttachment(Index: Integer): TgtPDFileAttachmentAnnot;
    function GetDuration: Integer;
    function GetRotate: Integer;
    function GetTrimBox: TgtPDRect;
    function GetContents: TgtPDContents;
    procedure SetDuration(const Value: Integer);
    procedure SetRotate(const Value: Integer);
    function GetResource: TgtPDResource;
    procedure UpdatePDStreamLength;
    procedure AddCommonAnnotEntries(AAnnot: TgtPDAnnot; ADict: TgtPDDictionary);
    procedure InsertFileAttachment(FileAttachment: TgtPDFileAttachmentAnnot);
    function CreateFileSpec(FileAttachment: TgtPDFileAttachmentAnnot): TgtPDBaseObject;
    procedure InsertLineAnnot(ALineAnnot: TgtPDLineAnnot);
    procedure InsertCircleAnnot(ACircleAnnot: TgtPDCircleAnnot);
    procedure InsertSqaureAnnot(ASquareAnnot: TgtPDSquareAnnot);
    procedure InsertPolygonAnnot(APolygonAnnot: TgtPDPolygonAnnot);
    function GetTransitionDict(ADuration: Single;
      ATransitionEffect: TgtPDTransitionEffect): TgtPDDictionary;
    procedure InsertLinkAnnot(ALinkAnnot: TgtPDLinkAnnot);
    procedure InsertPolyLineAnnot(APolylineAnnot: TgtPDPolyLineAnnot);
    function CreateActionDict(Action: TgtPDAction): TgtPDBaseObject;
    procedure InsertCaretAnnot(ACaretAnnot: TgtPDCaretAnnot);
    procedure InsertStampAnnot(AStampAnnot: TgtPDRubberStampAnnot);
    procedure InsertInkAnnot(AinkAnnot: TgtPDInkAnnot);
    procedure InsertTextAnnot(ATextAnnot: TgtPDTextAnnot);
    procedure InsertFreeTextAnnot(AFreeTextAnnot: TgtPDFreeTextAnnot);
    procedure InsertMarkUpAnnot(AMarkUpAnnot: TgtPDMarkUpAnnot);

    function GetNativeYPos(AY: Double): Double;
    procedure GetTransformedRect(AInputRect: TgtPDRect;
      AAngle: TgtPDFormFieldOrientation; var AOutputRect: TgtPDRect);

    function GetFontObject(AParentDoc: TgtObject;
      AParentElt: TgtPDElement; AgtFont: TgtFont): TgtPDFont;

    function CreateFormFieldAActionDict(AAction: TgtPDAction;
      ATriggerType: TgtFormFieldActionTriggers): TgtPDBaseObject;
    procedure AddCommonWidgetEntries(AFormField: TgtPDFormField; ADict: TgtPDDictionary);
    procedure InsertBSDictEntries(AFormField: TgtPDFormField; ADict: TgtPDDictionary);
    procedure InsertMKDictEntries(AFormField: TgtPDFormField; ADict: TgtPDDictionary);
    procedure InsertDADictEntries(AFormField: TgtPDFormField; ADict: TgtPDDictionary; AFontTag: AnsiString);
    procedure SetWidgetFlagBits(AFormField: TgtPDFormField;
      var AFieldFlag, AAnnotFlag: Integer);

    function CreateFormObject(AFormField: TgtPDFormField;  var AFontTag: AnsiString;
      AI: Integer = 0; AFormItem: TgtPDRadioItem = nil; ADef: Boolean = False): TgtPDIndirectRef;
    function GetPushButtonFormStream(AX, AY, AWidth, AHeight: Double;
      AFontTag: AnsiString; AI: Integer; AFormField: TgtPDFormPushButton): TMemoryStream;
    function GetCheckBoxFormStream(AWidth, AHeight: Double;
      AFontTag: AnsiString; AI: Integer; AFormField: TgtPDFormCheckBox): TMemoryStream;
    function GetRadioItemFormStream(AWidth, AHeight: Double;
      AFontTag: AnsiString; AI: Integer; AFormField: TgtPDFormRadioButton;
      AFormItem: TgtPDRadioItem; ADef: Boolean): TMemoryStream;
    function GetTextFieldFormStream(AY, AWidth, AHeight: Double;
      AFontTag: AnsiString; AI: Integer; AFormField: TgtPDFormTextField): TMemoryStream;
    function GetComboBoxFormStream(AWidth, AHeight: Double;
      AFontTag: AnsiString; AFormField: TgtPDFormComboBox): TMemoryStream;
    function GetListBoxFormStream(AWidth, AHeight: Double;
      AFontTag: AnsiString; AFormField: TgtPDFormListBox): TMemoryStream;
    function GetSigAppearance(AImgStream: TStream;
      AImageFormat: TgtOutFormat; ASigField: TgtPDSignatureField): TgtPDStream;
    function GetSigFormStream(AWidth, AHeight: Double;
      AFontTag: AnsiString; AI: Integer; AFormField: TgtPDSignatureField): TMemoryStream;
    function GetSigText(ASig: TgtPDSignature): TStringList;
    function CreatePushButtonDict(AFormField: TgtPDFormPushButton; var AFontTag: AnsiString): TgtPDIndirectRef;
    function CreateCheckBoxDict(AFormField: TgtPDFormCheckBox; var AFontTag: AnsiString): TgtPDIndirectRef;
    function CreateRadioBtnDict(AFormField: TgtPDFormRadioButton; var AFontTag: AnsiString): TgtPDIndirectRef;
    function CreateRadioKidsArray(AFormField: TgtPDFormRadioButton; var AFontTag: AnsiString;
      ARadioBtnRef: TgtPDIndirectRef): TgtPDArray;
    function CreateTextFieldDict(AFormField: TgtPDFormTextField; var AFontTag: AnsiString): TgtPDIndirectRef;
    function CreateComboBoxDict(AFormField: TgtPDFormComboBox; var AFontTag: AnsiString): TgtPDIndirectRef;
    function CreateListBoxDict(AFormField: TgtPDFormListBox; var AFontTag: AnsiString): TgtPDIndirectRef;
    function CreateSigFieldDict(AFormField: TgtPDSignatureField; var AFontTag: AnsiString): TgtPDIndirectRef;
    function CreateSigDict(ASig: TgtPDSignature): TgtPDIndirectRef;
    function DuplicateObject(Source: TgtPDBaseObject): TgtPDBaseObject;
    function FindInAcroForms(ObjNumber: Cardinal): AnsiString;
    procedure RenderField(FormField: TgtPDBaseObject; const Value: AnsiString;
      OutDev: TgtPDExportDevice; hDPI, vDPI: Double; PageRect: TgtPDRect);

    procedure FreeAnnotList;
    //For Image insertion
    function GetPDFBitmapStream(ABitmap: Graphics.TBitmap): TStream;
    //For translation of XandY according to CROPBOX or MEDIABOX
    procedure TranslateXY(var AX, AY: Double);

    function FitTextToWidth(AList: TStringList; AFont: TgtFont;
      AWidth: Integer; AUpdatedList: TStringList): Boolean;
    function FitTextToHeight(AList: TStringList; AFont: TgtFont;
      AHeight: Integer; ALineSpace: Integer; AUpdatedList: TStringList): Boolean;
    function CalculateAngle(XCenter, YCenter, X, Y: Double): Double;
    // Unit Conversion Functions.
    function DegreesToRadians(Degrees: Extended): Extended;
    function RadiansToDegrees(Radians: Extended): Extended;
    function GetEllipseCtrlPts(PosX1, PosY1, PosX2,
  PosY2: Double): TgtEllipseCtrlPoints;


  protected
    FInheritedProp: TgtPDInheritedProperty;

    function CreateAppDict(AFormField: TgtPDFormField; var AFontTag: AnsiString;
      ARadioItem: TgtPDRadioItem = nil): TgtPDDictionary;

  public
    constructor Create(AParentDoc: TgtObject; AParentElement: TgtPDElement;
      ABaseObject: TgtPDBaseObject);
    destructor Destroy; override;
    procedure Update; override;
    procedure Assign(Page: TgtPDPage);
    procedure FreeResources;

    procedure AddAnnot(AddAfter: Integer; Annot: TgtPDAnnot);
    function AddNewAnnot(AddAfter: Integer; AnnotType: TgtPDAnnotType;
      InitialRect: TgtPDRect): TgtPDAnnot;
    function CreateAnnot(AnnotType: TgtPDAnnotType;
      InitialLocation: TgtPDRect): TgtPDAnnot;

    function GetFormField(Index: Integer): TgtPDFormField; overload;
    function GetFormField(AFieldName: AnsiString): TgtPDFormField; overload;
    function GetFormFieldCount: Integer;
    procedure RemoveFormField(Index: Integer); overload;
    procedure RemoveFormField(AFieldName: AnsiString); overload;
    procedure AddFormField(AFormField: TgtPDFormField);

    function GetPageSize: TgtPageSize;
    function GetPageHeight: Double;
    function GetPageWidth: Double;
    function GetAnnots: TgtPDAnnotList;
    function GetActions: TgtPDAction;
    procedure ReplaceContents(NewContents: TgtPDBaseObject);
    procedure AddResource(ResType: TgtPDResourceType; const ResName: AnsiString;
      ResObject: TgtPDBaseObject);
//    procedure SetResource(Resource: TgtPDResource);

    procedure EnumFontResources(FontEnumEvent: TgtPDEnumFontEvent);
    procedure EnumXObjectResources(XObjectEnumEvent: TgtPDEnumXObjectEvent);
    procedure EnumColorSpaceResources(ColorSpaceEnumEvent:
      TgtPDEnumColorSpaceEvent);
    procedure EnumProcSetResources(ProcSetEnumEvent: TgtPDEnumProcSetEvent);

    property AttachmentCount: Integer read GetAttachmentCount;
    property FileAttachment[I: Integer]: TgtPDFileAttachmentAnnot read GetAttachment;
    property PageNum: Integer read FPageNum write FPageNum;
    property Mediabox: TgtPDRect read GetMediaBox;
    property Cropbox: TgtPDRect read GetCropBox;
    property Bleedbox: TgtPDRect read GetBleedBox;
    property TrimBox: TgtPDRect read GetTrimBox;
    property Rotate: Integer read GetRotate write SetRotate;
    property Duration: Integer read GetDuration write SetDuration;
    property Contents: TgtPDContents read GetContents;
    property Resource: TgtPDResource read GetResource;
    property IsInheritedCropBox: Boolean read FIsInheritedCropBox;
    property IsInheritedMediaBox:  Boolean read FIsInheritedMediaBox;

    procedure Display(OutDev: TgtPDExportDevice; hDPI, vDPI: Double;
      Rotate: Integer; UseMediaBox: Boolean; Crop: Boolean; Printing: Boolean;
      RenderAnnots: Boolean = True);
    procedure RenderAnnots(OutDev: TgtPDExportDevice; hDPI, vDPI: Double;
      PageRect: TgtPDRect);
    procedure DisplaySlice(OutDev: TgtPDExportDevice; hDPI: Double; vDPI: Double;
      Rotate: Integer; UseMediaBox: Boolean; Crop: Boolean; SliceX: Integer;
      SliceY: Integer; SliceW: Integer; SliceH: Integer; Printing: Boolean;
      RenderAnnots: Boolean = True);
    procedure MakeBox(hDPI: Double; vDPI: Double; Rotate: Integer;
      UseMediaBox: Boolean; UpsideDown: Boolean; SliceX: Integer;
      SliceY: Integer; SliceW: Integer; SliceH: Integer; Box: TgtPDRect;
      var Crop: Boolean);
    procedure ProcessLinks(OutDev: TgtPDExportDevice; Catatlog: TgtPDElement);
    procedure GetDefaultCTM(Matix: TgtPDMatrix; hDPI: Double; vDPI: Double;
      Rotate: Integer; uSeMediaBox, UpsideDown: Boolean);

    procedure SetOpacity(AStrokeValue, AFillValue: Integer);
    procedure SetTextRenderMode(AValue: TTextRenderMode);
    procedure SetPenWidth(AValue: Double);

    procedure SetRenderMode(RenderMode: TRenderMode);
    procedure SetEvenOddFillMode(AValue: Boolean);

    procedure TextOut(const Text: WideString; aFont: TgtFont; aX, aY: Double;
      AWritingMode: TgtWritingMode = wmHorizontal; AAngle: Integer = 0); Overload;
    //TextOut with clip rect. The text will be visible only if it is inside
    //the specified region
    procedure TextOut(const Text: WideString; aFont: TgtFont; aX, aY: Double;
      aClipRect: TgtPDRect; AWritingMode: TgtWritingMode = wmHorizontal;
      AAngle: Integer = 0); Overload;
    //TextOut inside the specified rect, the coordinates will be with reference
    //to the rect specified
    procedure TextOut(const Text: WideString;
      aClipRect: TgtPDRect;
      aX, aY: Double;
      aFont: TgtFont;
      aJustify, aJustifyLastLine: Boolean;
      aPointOfRotationX, aPointOfRotationY: Double;
      AWritingMode: TgtWritingMode = wmHorizontal;
      aHAlign: TgtHAlignment = haLeft; aVAlign: TgtVAlignment = vaCenter;
      AAngle: Integer = 0); Overload;
    procedure TextOutU(const Text: WideString; AFont: TgtFont; aX, aY: Double;
      AWritingMode: TgtWritingMode = wmHorizontal; AAngle: Integer = 0); Overload;
    procedure UniCodeTextOut(const Text: WideString;
      AFont: TgtFont; aX, aY: Double; AWritingMode: TgtWritingMode;
      AAngle: Integer);
    procedure MoveTo(AX, AY: Double);Overload;
    procedure MoveTo(AX, AY: Double;isNative:Boolean); Overload;
    procedure LineTo(AX, AY: Double);Overload;
    procedure LineTo(AX, AY: Double;isNative:Boolean); Overload;
    procedure Rectangle(X1, Y1, X2, Y2: Double);
    procedure CurveTo(X1, Y1, X2, Y2, X3, Y3: Double);Overload;
    procedure CurveTo(X1, Y1, X2, Y2, X3, Y3: Double;isNative:Boolean); Overload;
    procedure SetBrushColor(AR, AG, AB: Byte);
    procedure SetPenColor(AR, AG, AB: Byte);
    procedure ClosePath;
    procedure FillPath;
    procedure StrokePath;
    procedure FillAndStrokePath;
    procedure CloseAndStrokePath;
    procedure CloseFillAndStrokePath;
    procedure EndPath;
    procedure InsertImage(AX, AY: Double; AStream: TStream;
      AImageFormat: TgtOutFormat; AInLine: Boolean;
      AWidth, AHeight: Double; AAngle: Integer);
    procedure AddThumbnail(AImageStream: TStream; AImageWidth, AImageHeight: Extended);
    procedure InsertAnnotation(Annot: TgtPDAnnot);
    procedure SetPageTransitionEffect(Duration: Single;
      TransitionEffect: TgtPDTransitionEffect);
    procedure AddAction(AAction: TgtPDAction; ATriggerType: TgtPageActionTrigger);
    procedure RemoveAction(ATriggerType: TgtPageActionTrigger);
    procedure SetMediaBox(ALeft, ATop, ARight, Abottom: Double);
    procedure SetCropBox(ALeft, ATop, ARight, Abottom: Double);

    procedure SetDashPattern(aPenStyle: TPenStyle; aPenJoinStyle: TgtPenJoinStyle;
      aPenCapStyle: TgtPenCapStyle);
    procedure SetBrushStyle(aBrush: TBrush);

    procedure DrawLine(aX1, aY1, aX2, aY2: Double; aPenWidth: Integer;
      aPenColor: TColor; aOpacityStroke, aOpacityFill: Integer); overload;
    procedure DrawLine(aX1, aY1, aX2, aY2: Double; APen:TPen; aOpacityStroke,
      aOpacityFill: Integer); overload;

    procedure DrawRectangle(aX1, aY1, aX2, aY2: Double; aPenWidth: Integer;
      aPenColor, aBrushColor: TColor; aOpacityStroke, aOpacityFill: Integer); overload;
    procedure DrawRectangle(aX1, aY1, aX2, aY2: Double; aPen: TPen; aBrush: TBrush;
      aOpacityStroke, aOpacityFill: Integer); overload;

    procedure DrawEllipse(aCenterX, aCenterY, aMajorRadius, aMinorRadius: Double;
      aPenWidth: Integer; aPenColor, aBrushColor: TColor; aOpacityStroke, aOpacityFill: Integer); overload;
    procedure DrawEllipse(aCenterX, aCenterY, aMajorRadius, aMinorRadius: Double;
      aPen: TPen; ABrush: TBrush; aOpacityStroke, aOpacityFill: Integer); overload;

    procedure DrawPolygon(aCenterX, aCenterY, aSideLength: Double; aNumOfSides,
      aPenWidth: Integer; aPenColor, aFillColor: TColor; aOpacityStroke,
      aOpacityFill: Integer); overload;
    procedure DrawPolygon(aCoordinates: array of TPDPoint; aNumOfSides,
      aPenWidth: Integer; aPenColor, aFillColor: TColor; aOpacityStroke,
      aOpacityFill: Integer); overload;
    procedure DrawPolygon(aCoordinates: array of TPDPoint; aNumOfSides: Integer;
      aPen: TPen; aBrush: TBrush; aOpacityStroke,
      aOpacityFill: Integer); overload;

    procedure DrawPolyline(aPen:TPen; aBrush:TBrush; aPoints:array of TPDPoint ;aOpacityStroke, aOpacityFill: Integer);

    procedure DrawArc(X1, Y1, X2, y2, X3, Y3, X4, Y4: Double;
       aPen: TPen);

    procedure DrawPie(X1, Y1, X2, y2, X3, Y3, X4, Y4: Double;
       aPen:TPen; aBrush:TBrush; aOpacityStroke, aOpacityFill: Integer);

    procedure DrawChord(X1, Y1, X2, y2, X3, Y3, X4, Y4: Double;
       aPen:TPen; aBrush:TBrush; aOpacityStroke, aOpacityFill: Integer);

    procedure DrawRoundRect(X1, Y1, X2, y2, X3, Y3: Double;
       aPen:TPen; aBrush:TBrush; aOpacityStroke, aOpacityFill: Integer);

    procedure DrawPolyBezier(aPoints: array of TPDPoint; aPen:TPen);

    procedure DrawPolyPolyline(AObject: TgtPolyShapeItem; IsClosed: Boolean);

    procedure PolyDraw(AObject: TgtPolyDrawItem);

    procedure DrawPolyPolygon(AObject: TgtPolyPolygonItem);

  end;

implementation

uses
{$IFDEF DEBUG}
  gtLogger,
{$ENDIF}
  gtMethods, gtConstants, PDDocument, PDReal, PDBoolean,
  MemoryStream, PDModelException, PDPageTree, PDNull,
  PDName, JPEG, PDCatalog, PDGState, PDString, {$IFDEF VCL6ORABOVE}DateUtils,{$ENDIF} SysUtils,
  PDLaunchAction, PDGoToAction, PDGOToRemoteAction, PDURIAction, PDJavaScriptAction,
  FontProcessor, Math, PD8bitFont, Windows, PDSubmitFormAction, Stream,
  PDAppearanceStream, PDState, PDForm, PDXFADocument, PDEnvelope, gtJwaWinCrypt;

  type
  THackPDCatalog = class(TgtPDCatalog)

  end;

{ TgtPDPage }

 (**
  * Adds an annotation at the specified location in a page's annotation array.
  *
  * @param  AddAfter The index into the page's annotation array where the
  *         annotation is added. See Section 8.4 in the PDF Reference for a
  *         description of the annotation array. The first annotation in the
  *         array has an index of zero. Passing a value of -2 adds the
  *         annotation to the end of the array. Passing a value of -1 adds the
  *         annotation to the beginning of the array.Passing other negative
  *         values produces undefined results.
  * @param  Annot The annotation to add.
  * @exception EOprationNotPermitted Raised if The annotation is of subtype Text
  *           and the document's permissions do not include PermEditNotes or The
  *           annotation is of any other subtype and the document's permissions
  *           do not include PermEdit.
  *)

procedure TgtPDPage.AddAction(AAction: TgtPDAction;
  ATriggerType: TgtPageActionTrigger);
var
  LObj: TgtPDBaseObject;
begin
  LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_AA);
  if Assigned(LObj) and LObj.IsDict then
  begin
    if ATriggerType = atBeforePageOpen then
    begin
      TgtPDDictionary(LObj).SetKeyValue(PDF_O, CreateActionDict(AAction))
    end
    else if ATriggerType = atAfterPageClose then
    begin
      TgtPDDictionary(LObj).SetKeyValue(PDF_C, CreateActionDict(AAction));
    end;
  end
  else
  begin
    LObj := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);
    if ATriggerType = atBeforePageOpen then
      TgtPDDictionary(LObj).Add(PDF_O, CreateActionDict(AAction))
    else if ATriggerType = atAfterPageClose then
      TgtPDDictionary(LObj).Add(PDF_C, CreateActionDict(AAction));
    TgtPDDictionary(FBaseObject).Add(PDF_AA, LObj);
        // update Action list ???
  end;
end;

procedure TgtPDPage.AddAnnot(AddAfter: Integer; Annot: TgtPDAnnot);
begin

end;

 (**
  * Adds an annotation to the page. This method is equivalent to calling
  * CreateAnnot followed by AddAnnot.
  *
  * @param  AddAfter Where to add the annotation in the page's annotation array.
  *         See Section 8.4 in the PDF Reference for a description of the
  *         annotation array. Passing a value of -2 adds the annotation to the
  *         end of the array (this is generally what you should do unless you
  *         have a need to place the annotation at a special location in the
  *         array). Passing a value of -1 adds the annotation to the beginning
  *         of the array. Passing other negative values produces undefined
  *         results.
  * @param  AnnotType The type of the annotation to add.
  * @param  InitialRect Rectangle specifying the annotation's bounds, specified
  *         in user space coordinates.
  * @return The newly created annotation.
  * @exception EOprationNotPermitted Raised if The annotation is of subtype Text
  *           and the document's permissions do not include PermEditNotes or The
  *           annotation is of any other subtype and the document's permissions
  *           do not include PermEdit.
  *
  *
  *)

procedure TgtPDPage.InsertBSDictEntries(AFormField: TgtPDFormField; ADict: TgtPDDictionary);
var
  LBorderStyle: AnsiString;
  LBorderStyleDict: TgtPDDictionary;
begin
  case AFormField.BorderStyle of
    absSolid: LBorderStyle := PDF_S;
    absDashed: LBorderStyle := PDF_D;
    absBeveled: LBorderStyle := PDF_B;
    absInset: LBorderStyle := PDF_I;
    absUnderline: LBorderStyle := PDF_U;
  end;
  // set Border Style
  LBorderStyleDict := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);
  LBorderStyleDict.Add(PDF_TYPE, TgtPDName.Create(PDF_BORDER));
  LBorderStyleDict.Add(PDF_S, TgtPDName.Create(LBorderStyle));
  LBorderStyleDict.Add(PDF_W, TgtPDReal.Create(AFormField.BorderWidth));
  ADict.Add(PDF_BS, LBorderStyleDict);
end;

procedure TgtPDPage.AddCommonWidgetEntries(AFormField: TgtPDFormField;
  ADict: TgtPDDictionary);
var
  LArray: TgtPDArray;
  LRect: TgtPDRect;
begin
  ADict.Add(PDF_Type, TgtPDName.Create(PDF_Annot));
  ADict.Add(PDF_Subtype, TgtPDName.Create(PDF_WIDGET));
  
  LRect := TgtPDRect.Create;
  try
    GetTransformedRect(AFormField.Rect, AFormField.Orientation, LRect);

    LArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
    LArray.Add(TgtPDReal.Create(LRect.Left));
    LArray.Add(TgtPDReal.Create(GetNativeYPos(LRect.Top)));
    LArray.Add(TgtPDReal.Create(LRect.Right));
    LArray.Add(TgtPDReal.Create(GetNativeYPos(LRect.Bottom)));
    ADict.Add(PDF_Rect, LArray);
  finally
    FreeAndNil(LRect);
  end;
  
  //BorderStyle
  InsertBSDictEntries(AFormField, ADict);
  if not (AFormField is TgtPDRadioItem) then
  begin
    ADict.Add(PDF_T, TgtPDString.Create(AFormField.FieldName, False));
    ADict.Add(PDF_TU,
      TgtPDString.Create(TgtHackPDFormField(AFormField).AltFieldName, False));
  end;
end;

procedure TgtPDPage.AddCommonAnnotEntries(AAnnot: TgtPDAnnot; ADict: TgtPDDictionary);
var
  LArray: TgtPDArray;
  LDate: TgtDate;
  LBorderStyle: AnsiString;
  LBorderStyleDict: TgtPDDictionary;
  LFlagInt: Integer;
  LFlag: TgtPDAnnotFlags;
begin
  LArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
  with AAnnot do
  begin
    // Rect
    LArray.Add(TgtPDReal.Create(Rect.Left));
    LArray.Add(TgtPDReal.Create(GetPageHeight - Rect.Top));
    LArray.Add(TgtPDReal.Create(Rect.Right));
    LArray.Add(TgtPDReal.Create(GetPageHeight - Rect.Bottom));
    ADict.Add(PDF_RECT, LArray);

    // set color
    LArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
    LArray.Add(TgtPDReal.Create(color.Value[0]));
    LArray.Add(TgtPDReal.Create(color.Value[1]));
    LArray.Add(TgtPDReal.Create(color.Value[2]));
    ADict.Add(PDF_C, LArray);

    // Flags
    LFlagInt := 0;
    LFlag := Flags;
    if afInvisible in LFlag then
      LFlagInt := LFlagInt or 1;
    if afHidden in LFlag then
      LFlagInt := LFlagInt or (1 shl 1);
    if afPrint in LFlag then
      LFlagInt := LFlagInt or (1 shl 2);
    if afNoZoom in LFlag then
      LFlagInt := LFlagInt or (1 shl 3);
    if afNoRotate in LFlag then
      LFlagInt := LFlagInt or (1 shl 4);
    if afNoView in LFlag then
      LFlagInt := LFlagInt or (1 shl 5);
    if afReadOnly in LFlag then
      LFlagInt := LFlagInt or (1 shl 6);
    if afLocked in LFlag then
      LFlagInt := LFlagInt or (1 shl 7);
    if afToggleNoView in LFlag then
      LFlagInt := LFlagInt or (1 shl 8);
    if afLockedContents in LFlag then
      LFlagInt := LFlagInt or (1 shl 9);

    ADict.Add(PDF_F, TgtPDInteger.Create(LFlagInt));

    ADict.Add(PDF_TYPE, TgtPDName.Create(PDF_ANNOT));

    // Set Title
    ADict.Add(PDF_T, TgtPDString.Create(Title, False));

    // Set Name
    ADict.Add(PDF_NM, TgtPDString.Create(Name, False));

    // Set Contents
    ADict.Add(PDF_CONTENTS, TgtPDString.Create(Contents, False));

    // Set Border Style

    LBorderStyleDict := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);
    case BorderStyle of
      absSolid: LBorderStyle := PDF_S;
      absDashed:
      begin
        LBorderStyle := PDF_D;
        // Dash Array
        LArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
        LArray.Add(TgtPDInteger.Create(3));
        LArray.Add(TgtPDInteger.Create(2));
        LBorderStyleDict.Add(PDF_D, LArray);
      end;
      absBeveled: LBorderStyle := PDF_B;
      absInset: LBorderStyle := PDF_I;
      absUnderline: LBorderStyle := PDF_U;
    end;

    LBorderStyleDict.Add(PDF_TYPE, TgtPDName.Create(PDF_BORDER));
    LBorderStyleDict.Add(PDF_S, TgtPDName.Create(LBorderStyle));
    LBorderStyleDict.Add(PDF_W, TgtPDReal.Create(BorderWidth));
    ADict.Add(PDF_BS, LBorderStyleDict);


    //set Date
    {$IFDEF VCL6ORABOVE}
    DecodeDateTime(Now, LDate.Year, LDate.Month, LDate.Day, LDate.Hour,
      LDate.Minutes, LDate.Seconds, LDate.MilliSeconds);
    {$ENDIF}
    {$IFDEF DELPHI5}
      DecodeDate(Now, LDate.Year, LDate.Month, LDate.Day);
      DecodeTime(Now, LDate.Hour, LDate.Minutes, LDate.Seconds, LDate.MilliSeconds);
    {$ENDIF}

    ADict.Add(PDF_M, TgtPDString.Create(DateToPDFString(LDate), False));
  end;
end;

procedure TgtPDPage.AddFormField(AFormField: TgtPDFormField);
var
  LCatalog, LAnnotsObj, LDRDict, LFontDict, LFontObj: TgtPDBaseObject;
  LFieldsArray: TgtPDArray;
  LAcroForm: TgtPDDictionary;
  LIndRef, LFontIndRef: TgtPDIndirectRef;
  LFontTag: AnsiString;
  LFormField: TgtPDFormField;
begin
  LCatalog := TgtPDDocument(FParentDoc).BaseDoc.GetDocRoot;
  LAcroForm := TgtPDDictionary(LCatalog).LookUp(PDF_ACROFORM) as TgtPDDictionary;
  if not Assigned(LAcroForm) then
  begin
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber :=
      TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber + 1;

    LAcroForm := TgtPDDictionary.Create(
      TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber, 0,
      TgtPDDocument(FParentDoc).BaseDoc);

    TgtPDDocument(FParentDoc).BaseDoc.AddToCollection(LAcroForm);

    LIndRef := TgtPDIndirectRef.Create(LAcroForm.ObjNumber, LAcroForm.GenNumber);

    TgtPDDictionary(LCatalog).Add(PDF_ACROFORM, LIndRef);
  end;
  LIndRef := nil;
  LFieldsArray := TgtPDDictionary(LAcroForm).LookUp(PDF_FIELDS) as TgtPDArray;
  if not Assigned(LFieldsArray) then
  begin
    LFieldsArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
    TgtPDDictionary(LAcroForm).Add(PDF_FIELDS, LFieldsArray);
  end;
  if Assigned(LAcroForm.LookUp(PDF_NEEDAPPEARANCES)) then
    LAcroForm.SetKeyValue(PDF_NEEDAPPEARANCES, TgtPDBoolean.Create(False))
  else
    LAcroForm.Add(PDF_NEEDAPPEARANCES, TgtPDBoolean.Create(False));

  if AFormField is TgtPDFormPushButton then
  begin
    LIndRef := CreatePushButtonDict(TgtPDFormPushButton(AFormField), LFontTag);
  end
  else if AFormField is TgtPDFormCheckBox then
  begin
    LIndRef := CreateCheckBoxDict(TgtPDFormCheckBox(AFormField), LFontTag);
  end
  else if AFormField is TgtPDFormRadioButton then
  begin
    LIndRef := CreateRadioBtnDict(TgtPDFormRadioButton(AFormField), LFontTag);
  end
  else if AFormField is TgtPDFormTextField then
  begin
    LIndRef := CreateTextFieldDict(TgtPDFormTextField(AFormField), LFontTag);
  end
  else if AFormField is TgtPDFormComboBox then
  begin
    LIndRef := CreateComboBoxDict(TgtPDFormComboBox(AFormField), LFontTag);
  end
  else if AFormField is TgtPDFormListBox then
  begin
    LIndRef := CreateListBoxDict(TgtPDFormListBox(AFormField), LFontTag);
  end
  else if AFormField is TgtPDSignatureField then
  begin
    LIndRef := CreateSigFieldDict(TgtPDSignatureField(AFormField), LFontTag);
  end;

  if LIndRef <> nil then
  begin
    //Add widget dict into fields array
    LFieldsArray.Add(LIndRef);
    //Also add the widget dict into the current page annot array only if it is
    //not a RadioBtn
    if not (AFormField is TgtPDFormRadioButton) then
    begin
      LAnnotsObj := TgtPDDictionary(FBaseObject).LookUp(PDF_ANNOTS);
      if not Assigned(LAnnotsObj) then
      begin
        LAnnotsObj := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
        TgtPDDictionary(FBaseObject).Add(PDF_ANNOTS, LAnnotsObj);
      end;
      TgtPDArray(LAnnotsObj).Add(LIndRef.Clone);
    end;

    LDRDict := TgtPDDictionary(LAcroForm).LookUp(PDF_DR);
    if not Assigned(LDRDict) then
    begin
      LDRDict := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);
      LAcroForm.Add(PDF_DR, LDRDict);
    end;
    LFontDict := TgtPDDictionary(LDRDict).LookUp(PDF_FONT);
    if not Assigned(LFontDict) then
    begin
      LFontDict := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);
      TgtPDDictionary(LDRDict).Add(PDF_FONT, LFontDict);
    end;

    if Assigned(TgtPDDictionary(FBaseObject).LookUp(PDF_RESOURCES)) then
    begin
      LFontObj := TgtPDDictionary(TgtPDDictionary(FBaseObject).LookUp(PDF_RESOURCES)).LookUp(PDF_FONT);
      if Assigned(LFontObj) then
      begin
        LFontObj := TgtPDDictionary(LFontObj).LookUp(LFontTag);
        if Assigned(LFontObj) then
        begin
          LFontIndRef := TgtPDIndirectRef.Create(LFontObj.ObjNumber, LFontObj.GenNumber);
          TgtPDDictionary(LFontDict).Add(LFontTag, LFontIndRef);
        end;
      end;
    end;
  end;

  //For updating the newly added FF into List.

  //Create ref for the user passed TgtPDFormField
  LFormField := AFormField.Clone;
  //Set the newly created ff dict object to Lformfield
  LFormField.SetBaseObject(TgtPDDocument(FParentDoc).BaseDoc.GetObject(LIndRef.ObjNumber));
  LFormField.SetParentElement(Self);
  LFormField.SetParentDoc(FParentDoc);

  //Update both FormFieldList and AnnotList
  if Assigned(THackPDCatalog(TgtPDDocument(FParentDoc).Catalog).FFormFieldList) then
  begin
    THackPDCatalog(TgtPDDocument(FParentDoc).Catalog).FFormFieldList.Add(LFormField);
    Inc(FFormFieldCount);
    if Assigned(FAnnotList) then
      FAnnotList.Add(LFormField);
  end;
  if Assigned(LFormField) then
    LFormField.Free;
end;

function TgtPDPage.AddNewAnnot(AddAfter: Integer;
  AnnotType: TgtPDAnnotType; InitialRect: TgtPDRect): TgtPDAnnot;
begin
  Result := nil;
end;

 (**
  * Adds a Base resource object to a page object. See Section 3.7.2 in the PDF
  * Reference for a description of page resources. The necessary dictionaries
  * are created automatically if the page does not already have any resources
  * of the type specified by resType, or does not have a Resources dictionary.
  * For example, if you specify a font resource, but the page does not already
  * have a font resource dictionary, this method automatically creates one and
  * puts the font you specify into it.
  *
  * ProcSet resources cannot be added using this method; they must be added
  * using Base-level methods to:
  *   Get the page's Resources dictionary.
  *   Get the ProcSet array from the Resources dictionary.
  *   Add an element to the ProcSet array.
  *
  * @param  ResType The resource type.
  * @param  ResName The resource name (for example, the name of a font might
  *         be F1).
  * @param  ResObject The Base object being added as a resource to page.
  *
  *
  *)

procedure TgtPDPage.AddResource(ResType: TgtPDResourceType;
  const ResName: AnsiString; ResObject: TgtPDBaseObject);
var
  LDict, LObj, LObj2: TgtPDBaseObject;
  LResObj: TgtPDElement;
begin
  LObj := nil;
  if not Assigned(Resource) then
  begin
    TgtPDDocument(FParentDoc).LastObjectNumber :=
      TgtPDDocument(FParentDoc).LastObjectNumber + 1;
    LDict := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).LastObjectNumber, 0,
      TgtPDDocument(FParentDoc).BaseDoc);
    FResource := TgtPDResource.Create(FParentDoc, Self, LDict);
    TgtPDDocument(FParentDoc).BaseDoc.AddToCollection(LDict);
    //Recently added, Ex:- If a text is added to a blank doc which has no resource
    //A new resource has to be created and added to the page.
    TgtPDDictionary(self.BaseObject).Add(PDF_RESOURCES,
      TgtPDIndirectRef.Create(FResource.BaseObject.ObjNumber,
        FResource.BaseObject.GenNumber));
  end;

  case ResType of
    resExtGState:
      begin
        LObj := TgtPDDictionary(Resource.BaseObject).LookUp(PDF_EXTGSTATE);
        if not Assigned(LObj) then
        begin
          LObj := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);
          TgtPDDictionary(Resource.BaseObject).Add(PDF_EXTGSTATE, LObj);
        end;
        //To initiate the Resource list
        Resource.LookUpGState(ResName);
        LResObj := TgtPDGState.Create(FParentDoc, Resource, ResObject, ResName);
        Resource.AddExtGState(TgtPDGState(LResObj));
      end;

    resColorSpace:
      begin
        LObj := TgtPDDictionary(Resource.BaseObject).LookUp(PDF_COLORSPACE);
        if not Assigned(LObj) then
        begin
          LObj := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);
          TgtPDDictionary(Resource.BaseObject).Add(PDF_COLORSPACE, LObj);
        end;
        //To initiate the Resource list
        Resource.LookUpColorSpace(ResName);
        LResObj := TgtPDColorSpace.MakeColorSpace(ResObject, ResName);
        Resource.AddColorSpace(TgtPDColorSpace(LResObj));
      end;
    resPattern: ;
    resShading: ;

    resXObject:
      begin
        LObj := TgtPDDictionary(Resource.BaseObject).LookUp(PDF_XOBJECT);
        if not Assigned(LObj) then
        begin
          LObj := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);
          TgtPDDictionary(Resource.BaseObject).Add(PDF_XOBJECT, LObj);
        end;
        //To initiate the Resource list
        Resource.LookUpXObject(ResName);
        LResObj := TgtPDXObject.MakeXObject(FParentDoc, Resource, ResObject, ResName);
        Resource.AddXObject(TgtPDXObject(LResObj));
      end;

    resFont:
      begin
        LObj := TgtPDDictionary(Resource.BaseObject).LookUp(PDF_FONT);
        if not Assigned(LObj) then
        begin
          LObj := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);
          TgtPDDictionary(Resource.BaseObject).Add(PDF_FONT, LObj);
        end;
        //To initiate the Resource list
        Resource.LookUpFont(ResName);
        LResObj := TgtPDFont.MakeFont(FParentDoc, Resource, ResName, ResObject);
        Resource.AddFont(TgtPDFont(LResObj));
      end;
    resProcSet: ;
    resProperties: ;
  end;
  LObj2 := TgtPDIndirectRef.Create(ResObject.ObjNumber, ResObject.GenNumber);
  TgtPDDictionary(LObj).Add(ResName, LObj2);
end;

procedure TgtPDPage.AddThumbnail(AImageStream: TStream; AImageWidth, AImageHeight: Extended);
var
  LMemStrm: TMemoryStream;
  LgtMemStrm: TgtMemoryStream;
  LDict, LIndRef, LImageStrm: TgtPDBaseObject;
begin

  LMemStrm := TMemoryStream.Create;
  LgtMemStrm := TgtMemoryStream.Create(LMemStrm, 0, 0, False);
  LMemStrm.LoadFromStream(AImageStream);
  LgtMemStrm.Reset;

  LDict := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);
  TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber :=
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber + 1;
  LImageStrm := TgtPDStream.Create(LgtMemStrm, LDict,
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber, 0);
  TgtPDDocument(FParentDoc).BaseDoc.AddToCollection(LImageStrm);

  TgtPDDictionary(LDict).Add(PDF_LENGTH, TgtPDInteger.Create(LMemStrm.Size));
  TgtPDDictionary(LDict).Add(PDF_TYPE, TgtPDName.Create(PDF_XOBJECT));
  TgtPDDictionary(LDict).Add(PDF_SUBTYPE, TgtPDName.Create(PDF_IMAGE));
  TgtPDDictionary(LDict).Add(PDF_WIDTH, TgtPDReal.Create(AImageWidth));
  TgtPDDictionary(LDict).Add(PDF_HEIGHT, TgtPDReal.Create(AImageHeight));
  TgtPDDictionary(LDict).Add(PDF_BITSPERCOMP, TgtPDInteger.Create(8));
  TgtPDDictionary(LDict).Add(PDF_COLORSPACE, TgtPDName.Create(PDF_DEVICERGB));

  LIndRef := TgtPDIndirectRef.Create(LImageStrm.ObjNumber, LImageStrm.GenNumber);
  TgtPDDictionary(FBaseObject).Add(PDF_THUMB, LIndRef);

end;

procedure TgtPDPage.Assign(Page: TgtPDPage);
var
  LObj: TgtPDBaseObject;
begin
  LObj := DuplicateObject(Page.BaseObject);
  FBaseObject := TgtPDDocument(FParentDoc).BaseDoc.GetObject(LObj.ObjNumber);
//  LObj.Free;

  // Inherited MediaBox
  LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_MEDIABOX);
  if not Assigned(LObj) then
  begin
    LObj := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc, MAXOBJNUM,
      MAXGENNUM);
    TgtPDArray(LObj).Add(TgtPDReal.Create(Page.Mediabox.Left));
    TgtPDArray(LObj).Add(TgtPDReal.Create(Page.Mediabox.Top));
    TgtPDArray(LObj).Add(TgtPDReal.Create(Page.Mediabox.Right));
    TgtPDArray(LObj).Add(TgtPDReal.Create(Page.Mediabox.Bottom));
    TgtPDDictionary(FBaseObject).Add(PDF_MEDIABOX, LObj);
  end;
end;

(**
   * @param AParentDoc is the parent document with which this object need to
   *         be created
   * @param AParentElement is the the parent element from where this object
   *         was called
   * @param ABaseObject is the page object
   *
   * Algorithm
   *    a.	Assign parameter AParentDoc to FParentDoc
   *    b.	Assign parameter AParentElement to FParentElement
   *    c.	Assign parameter ABaseObject to FBaseObject
   *)

function TgtPDPage.CalculateAngle(XCenter, YCenter, X, Y: Double): Double;
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

procedure TgtPDPage.CloseAndStrokePath;
begin
  FCurrentCS.CloseAndStrokePath;
  UpdatePDStreamLength;
end;

procedure TgtPDPage.CloseFillAndStrokePath;
begin
  FCurrentCS.CloseFillAndStrokePath;
  UpdatePDStreamLength;
end;

procedure TgtPDPage.ClosePath;
begin
  FCurrentCS.ClosePath;
  UpdatePDStreamLength;
end;

constructor TgtPDPage.Create(AParentDoc: TgtObject;
  AParentElement: TgtPDElement; ABaseObject: TgtPDBaseObject);
begin
  FParentDoc := AParentDoc;
  FParentElement := AParentElement;
  FBaseObject := ABaseObject;
  FInheritedProp := nil;
  FFormFieldCount := 0;
  FCurrentCS := nil;
  FIsInheritedCropBox := False;
  FIsInheritedMediaBox := False;
end;

 (**
  * Creates a new annotation, associated with the specified page's BaseDoc, but
  * not added to the page. Use AddAnnot to add the annotation to the page.
  *
  *
  * @exclude  If you want to create an annotation that prints even if the
  *           annotation handler is not present, you must provide an appearance
  *           for it. To do this, add an appearance key (AP) to the annotation
  *           dictionary, in which you place the Forms XObject for the Normal
  *           (N), Rollover (R), and Down (D) appearances; only the Normal
  *           appearance is required. Also, add a flags field (F) to the
  *           annotation dictionary and set the appropriate value for the bit
  *           field. A value of 4, which displays the annotation if the handler
  *           is not present, shows the annotation, and allows printing it,
  *           is recommended.
  *
  * @param  AnnotType The type of the annotation to add.
  * @param  InitialLocation Rectangle specifying the annotation's bounds, specified
  *         in user space coordinates.
  * @return The newly created annotation.
  * @exception EOprationNotPermitted Raised if The annotation is of subtype Text
  *           and the document's permissions do not include PermEditNotes or The
  *           annotation is of any other subtype and the document's permissions
  *           do not include PermEdit.
  *
  *
  *)

function TgtPDPage.CreateActionDict(Action: TgtPDAction): TgtPDBaseObject;
var
  LDict: TgtPDDictionary;
  LArray: TgtPDArray;
  LPage: TgtPDPage;
  LFlagsValue: Integer;
begin
  LFlagsValue := 0;
  Result := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);
  with TgtPDDictionary(Result) do
  begin
    Add(PDF_Type, TgtPDName.Create(PDF_ACTION));
    case Action.ActionType of
      actionNone: ;
      actionGoTo:
        begin
          Add(PDF_S, TgtPDName.Create(PDF_GOTO));
          LArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
          with TgtPDGoToAction(Action).Destination do
          begin
            Rect.Top := GetPageHeight - Rect.Top;
            Rect.Bottom := GetPageHeight - Rect.Top;
            LPage := TgtPDPage(Page);
            case DisplayOptions of
              FitZoom:
                begin
                  LArray.Add(TgtPDIndirectRef.Create(LPage.BaseObject.ObjNumber,
                    LPage.BaseObject.GenNumber));
                  LArray.Add(TgtPDName.Create(PDF_XYZ));
                  LArray.Add(TgtPDReal.Create(Rect.Left));
                  LArray.Add(TgtPDReal.Create(Rect.Top));
                  LArray.Add(TgtPDReal.Create(Rect.Right)); // Zoom is taken as right ??????
                end;
              FitAll:
                begin
                  LArray.Add(TgtPDIndirectRef.Create(LPage.BaseObject.ObjNumber,
                    LPage.BaseObject.GenNumber));
                  LArray.Add(TgtPDName.Create(PDF_FIT));
                end;
              FitHeight:
                begin
                  LArray.Add(TgtPDIndirectRef.Create(LPage.BaseObject.ObjNumber,
                    LPage.BaseObject.GenNumber));
                  LArray.Add(TgtPDName.Create(PDF_FITH));
                  LArray.Add(TgtPDReal.Create(Rect.Top));
                end;
              FitWidth:
                begin
                  LArray.Add(TgtPDIndirectRef.Create(LPage.BaseObject.ObjNumber,
                    LPage.BaseObject.GenNumber));
                  LArray.Add(TgtPDName.Create(PDF_FITV));
                  LArray.Add(TgtPDReal.Create(Rect.Left));
                end;
              FitRect:
                begin
                  LArray.Add(TgtPDIndirectRef.Create(LPage.BaseObject.ObjNumber,
                    LPage.BaseObject.GenNumber));
                  LArray.Add(TgtPDName.Create(PDF_FITR));
                  LArray.Add(TgtPDReal.Create(Rect.Left));
                  LArray.Add(TgtPDReal.Create(Rect.Bottom));
                  LArray.Add(TgtPDReal.Create(Rect.Right));
                  LArray.Add(TgtPDReal.Create(Rect.Top));
                end;
              FitBoundingBox:
                begin
                  LArray.Add(TgtPDIndirectRef.Create(LPage.BaseObject.ObjNumber,
                    LPage.BaseObject.GenNumber));
                  LArray.Add(TgtPDName.Create(PDF_FITB));
                end;
              FitBoundingBoxHeight:
                begin
                  LArray.Add(TgtPDIndirectRef.Create(LPage.BaseObject.ObjNumber,
                    LPage.BaseObject.GenNumber));
                  LArray.Add(TgtPDName.Create(PDF_FITBH));
                  LArray.Add(TgtPDReal.Create(Rect.Top));
                end;
              FitBoundingBoxWidth:
                begin
                  LArray.Add(TgtPDIndirectRef.Create(LPage.BaseObject.ObjNumber,
                    LPage.BaseObject.GenNumber));
                  LArray.Add(TgtPDName.Create(PDF_FITBV));
                  LArray.Add(TgtPDReal.Create(Rect.Left));
                end;
            end;
          end;
          Add(PDF_D, LArray);
        end;
      actionGoToR:
        begin
          Add(PDF_S, TgtPDName.Create(PDF_GOTOR));
          LArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
          with TgtPDGoToRemoteAction(Action).Destination do
          begin
            Rect.Top := GetPageHeight - Rect.Top;
            Rect.Bottom := GetPageHeight - Rect.Bottom;
            case DisplayOptions of
              FitZoom:
                begin
                  LArray.Add(TgtPDInteger.Create(TgtPDGoToRemoteAction(Action).PageNum));
                  LArray.Add(TgtPDName.Create(PDF_XYZ));
                  LArray.Add(TgtPDReal.Create(Rect.Left));
                  LArray.Add(TgtPDReal.Create(Rect.Top));
                  LArray.Add(TgtPDReal.Create(Rect.Right)); // Zoom is taken as right ??????
                end;
              FitAll:
                begin
                  LArray.Add(TgtPDInteger.Create(TgtPDGoToRemoteAction(Action).PageNum));
                  LArray.Add(TgtPDName.Create(PDF_FIT));
                end;
              FitHeight:
                begin
                  LArray.Add(TgtPDInteger.Create(TgtPDGoToRemoteAction(Action).PageNum));
                  LArray.Add(TgtPDName.Create(PDF_FITH));
                  LArray.Add(TgtPDReal.Create(Rect.Top));
                end;
              FitWidth:
                begin
                  LArray.Add(TgtPDInteger.Create(TgtPDGoToRemoteAction(Action).PageNum));
                  LArray.Add(TgtPDName.Create(PDF_FITV));
                  LArray.Add(TgtPDReal.Create(Rect.Left));
                end;
              FitRect:
                begin
                  LArray.Add(TgtPDInteger.Create(TgtPDGoToRemoteAction(Action).PageNum));
                  LArray.Add(TgtPDName.Create(PDF_FITR));
                  LArray.Add(TgtPDReal.Create(Rect.Left));
                  LArray.Add(TgtPDReal.Create(Rect.Bottom));
                  LArray.Add(TgtPDReal.Create(Rect.Right));
                  LArray.Add(TgtPDReal.Create(Rect.Top));
                end;
              FitBoundingBox:
                begin
                  LArray.Add(TgtPDInteger.Create(TgtPDGoToRemoteAction(Action).PageNum));
                  LArray.Add(TgtPDName.Create(PDF_FITB));
                end;
              FitBoundingBoxHeight:
                begin
                  LArray.Add(TgtPDInteger.Create(TgtPDGoToRemoteAction(Action).PageNum));
                  LArray.Add(TgtPDName.Create(PDF_FITBH));
                  LArray.Add(TgtPDReal.Create(Rect.Top));
                end;
              FitBoundingBoxWidth:
                begin
                  LArray.Add(TgtPDInteger.Create(TgtPDGoToRemoteAction(Action).PageNum));
                  LArray.Add(TgtPDName.Create(PDF_FITBV));
                  LArray.Add(TgtPDReal.Create(Rect.Left));
                end;
            end;
          end;
          Add(PDF_D, LArray);
          Add(PDF_F, TgtPDString.Create(TgtPDGoToRemoteAction(Action).FileName, False));
          Add(PDF_NEWWINDOW, TgtPDBoolean.Create(TgtPDGoToRemoteAction(Action).
            OpenInNewWindow));
        end;
      actionGoToE: ;
      actionLaunch:
        begin
          LDict := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);
          Add(PDF_S, TgtPDName.Create(PDF_LAUNCH));
          if TgtPDLaunchAction(Action).OpenInNewWindow then
            Add(PDF_NEWWINDOW, TgtPDBoolean.Create(True))
          else
            Add(PDF_NEWWINDOW, TgtPDBoolean.Create(False));
          LDict.Add(PDF_F, TgtPDString.Create(TgtPDLaunchAction(Action).ApplicationToLaunch,
            False));
          case TgtPDLaunchAction(Action).LaunchActionType of
            ltOpen: LDict.Add(PDF_O, TgtPDString.Create(PDF_OPEN, False));
            ltPrint: LDict.Add(PDF_O, TgtPDString.Create(PDF_PRINT, False));
          end;
          Add(PDF_WIN, LDict);
        end;
      actionThread: ;
      actionURI:
        begin
          Add(PDF_S, TgtPDName.Create(PDF_URI));
          Add(PDF_URI, TgtPDString.Create(TgtPDURIAction(Action).URI, False));
          if TgtPDURIAction(Action).TrackMousePointer then
            Add(PDF_ISMAP, TgtPDBoolean.Create(True))
          else
            Add(PDF_ISMAP, TgtPDBoolean.Create(False));
        end;
      actionSound: ;
      actionMovie: ;
      actionHide: ;
      actionNamed: ;
      actionSubmitForm:
        begin
          Add(PDF_S, TgtPDName.Create(PDF_SubmitForm));
          Add(PDF_F, TgtPDString.Create(TgtPDSubmitFormAction(Action).URL, False));

        //If Fields entry is ignored then all the fields in the document are submitted
        //except for those fields whose NoExport flag is set.
        //If the submit-form action dictionary contains no Fields entry,
        //such pushbutton fields are not submitted at all.
        //Add(PDF_FIELDS, TgtArray.Create());

        //Field names and values may be submitted in any of the following formats:
          if TgtPDSubmitFormAction(Action).Format = fsfHTML then
          begin
          //9-bit, SubmitPDF, is made clear
            LFlagsValue := LFlagsValue and not (1 shl 8);
          //6-bit, XFDF is made clear
            LFlagsValue := LFlagsValue and not (1 shl 5);
          //3-bit, ExportFormat is set, for html format.
            LFlagsValue := LFlagsValue or (1 shl 2);
          //4-bit, GetMethod is set, field names and values are submitted using
          //an HTTP GET request.
            LFlagsValue := LFlagsValue or (1 shl 3);
          end
          else if TgtPDSubmitFormAction(Action).Format = fsfFDF then
          begin
          //9-bit, SubmitPDF, is made clear
            LFlagsValue := LFlagsValue and not (1 shl 8);
          //6-bit, XFDF is made clear
            LFlagsValue := LFlagsValue and not (1 shl 5);
          //3-bit, ExportFormat is unset, for FDF format.
            LFlagsValue := LFlagsValue and not (1 shl 2);
          //4-bit, GetMethod is unset, bcouz 3-bit is unset, for POST request.
            LFlagsValue := LFlagsValue and not (1 shl 3);
          end
          else if TgtPDSubmitFormAction(Action).Format = fsfXML then
          begin
          //9-bit, SubmitPDF, is made clear
            LFlagsValue := LFlagsValue and not (1 shl 8);
          //6-bit, XFDF is set for XML FDF format.
            LFlagsValue := LFlagsValue or (1 shl 5);
          end;
          Add(PDF_FLAGS, TgtPDInteger.Create(LFlagsValue));
        end;
      actionResetForm:
        begin
          Add(PDF_S, TgtPDName.Create(PDF_RESETFORM));
          Add(PDF_FLAGS, TgtPDInteger.Create(LFlagsValue));
        end;
      actionImportData: ;
      actionJavaScript:
        begin
          Add(PDF_S, TgtPDName.Create(PDF_JAVASCRIPT));
          Add(PDF_JS, TgtPDString.Create(TgtPDJavaScriptAction(Action).JavaScript, False));
        end;
      actionSetOCGState: ;
      actionRendition: ;
      actionTrans: ;
      actionGoTo3DView: ;
    end;
  end;
end;

function TgtPDPage.CreateAnnot(AnnotType: TgtPDAnnotType;
  InitialLocation: TgtPDRect): TgtPDAnnot;
begin
  Result := nil;
end;

function TgtPDPage.CreateAppDict(AFormField: TgtPDFormField; var AFontTag: AnsiString;
  ARadioItem: TgtPDRadioItem = nil): TgtPDDictionary;
var
  LApDict, LNApDict, LDefAppDict: TgtPDDictionary;
begin
  //create new Apperance Dictionary
  LApDict := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);

  if AFormField.FormFieldType = ftButton then
  begin
    LApDict.Add(PDF_N, CreateFormObject(AFormField, AFontTag, 0));
    LApDict.Add(PDF_D, CreateFormObject(AFormField, AFontTag, 2));
    LApDict.Add(PDF_R, CreateFormObject(AFormField, AFontTag, 1));
  end
  else if AFormField.FormFieldType = ftText then
  begin
    if TgtPDFormTextField(AFormField).IsMultiline then
      LApDict.Add(PDF_N, CreateFormObject(AFormField, AFontTag, 0))
    else
      LApDict.Add(PDF_N, CreateFormObject(AFormField, AFontTag, 1));
  end
  else if AFormField.FormFieldType = ftListBox then
  begin
    LApDict.Add(PDF_N, CreateFormObject(AFormField, AFontTag));
  end
  else if AFormField.FormFieldType = ftSignature then
  begin
    LApDict.Add(PDF_N, CreateFormObject(AFormField, AFontTag));
  end
  else if AFormField.FormFieldType = ftComboBox then
  begin
    LApDict.Add(PDF_N, CreateFormObject(AFormField, AFontTag));
  end
  else if AFormField.FormFieldType = ftCheckBox then
  begin
    //Normal appearence
    LNApDict := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);
    LNApDict.Add(PDF_YES, CreateFormObject(AFormField, AFontTag, 0));
    LNApDict.Add(PDF_OFF, CreateFormObject(AFormField, AFontTag, 1));

    //Apperance Dictionary
    LApDict.Add(PDF_N, LNApDict);
    LApDict.Add(PDF_D, CreateFormObject(AFormField, AFontTag, 2));
  end
  else if AFormField.FormFieldType = ftRadio then
  begin
    //Normal appearence
    LNApDict := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);
    LNApDict.Add(ARadioItem.Value,
      CreateFormObject(AFormField, AFontTag, 0, ARadioItem, False));
    LNApDict.Add(PDF_OFF,
      CreateFormObject(AFormField, AFontTag, 1, ARadioItem, False));

    //Default Appearance
    LDefAppDict := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);
    LDefAppDict.Add(ARadioItem.Value,
      CreateFormObject(AFormField, AFontTag, 0, ARadioItem, True));
    LDefAppDict.Add(PDF_OFF,
      CreateFormObject(AFormField, AFontTag, 1, ARadioItem, True));

    //Adding of Apperance Dictionary
    LApDict.Add(PDF_N, LNApDict);
    LApDict.Add(PDF_D, LDefAppDict);
  end;
  Result := LApDict;
end;

function TgtPDPage.CreateCheckBoxDict(
  AFormField: TgtPDFormCheckBox; var AFontTag: AnsiString): TgtPDIndirectRef;
var
  LWidgetDict, LMKDict, LActionDict: TgtPDDictionary;
  LFieldFlag, LAnnotFlag: Integer;
begin
  TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber :=
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber + 1;
  //Widget dictionary
  LWidgetDict := TgtPDDictionary.Create(
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber, 0,
    TgtPDDocument(FParentDoc).BaseDoc);
  TgtPDDocument(FParentDoc).BaseDoc.AddToCollection(LWidgetDict);

  //Add common entries
  AddCommonWidgetEntries(AFormField, LWidgetDict);
  //Justification
  LWidgetDict.Add(PDF_Q, TgtPDInteger.Create(
    Ord(TgtHackPDFormField(AFormField).Justification)));
  //Add Flag entry
  SetWidgetFlagBits(AFormField, LFieldFlag, LAnnotFlag);
  LWidgetDict.Add(PDF_FF, TgtPDInteger.Create(LFieldFlag));
  LWidgetDict.Add(PDF_F, TgtPDInteger.Create(LAnnotFlag));
  //FieldType
  LWidgetDict.Add(PDF_FT, TgtPDName.Create(PDF_Btn));
  //Adding aditional Action Dictionary
  if Assigned(AFormField.Action) then
  begin
    LActionDict := TgtPDDictionary(
      CreateFormFieldAActionDict(AFormField.Action, AFormField.TriggerType));
    LWidgetDict.Add(PDF_AA, LActionDict);
  end;
  LWidgetDict.Add(PDF_H, TgtPDName.Create(PDF_N));
  if AFormField.IsChecked = True then
  begin
    LWidgetDict.Add(PDF_V, TgtPDName.Create(PDF_YES));
    LWidgetDict.Add(PDF_AS, TgtPDName.Create(PDF_YES));
    LWidgetDict.Add(PDF_DV, TgtPDName.Create(PDF_YES));
  end
  else
  begin
    LWidgetDict.Add(PDF_V, TgtPDName.Create(PDF_OFF));
    LWidgetDict.Add(PDF_AS, TgtPDName.Create(PDF_OFF));
    LWidgetDict.Add(PDF_DV, TgtPDName.Create(PDF_OFF));
  end;
//  //Normal appearence
//  LNApDict := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);
//  LNApDict.Add(PDF_YES, CreateFormObject(AFormField, 0));
//  LNApDict.Add(PDF_OFF, CreateFormObject(AFormField, 1));
//  //Apperance Dictionary
//  LApDict := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);
//  LApDict.Add(PDF_N, LNApDict);
//  LApDict.Add(PDF_D, CreateFormObject(AFormField, 2));
//  //Add Appearance dict
//  LWidgetDict.Add(PDF_AP, LApDict);
  LWidgetDict.Add(PDF_AP, CreateAppDict(AFormField, AFontTag));
  //MKDict
  LMKDict := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);
  InsertMKDictEntries(AFormField, LMKDict);
  LWidgetDict.Add(PDF_MK, LMKDict);
  //DA entry
  InsertDADictEntries(AFormField, LWidgetDict, AFontTag);
  Result := TgtPDIndirectRef.Create(LWidgetDict.ObjNumber, LWidgetDict.GenNumber);
end;

function TgtPDPage.CreateComboBoxDict(
  AFormField: TgtPDFormComboBox; var AFontTag: AnsiString): TgtPDIndirectRef;
var
  LWidgetDict, LMKDict, LActionDict: TgtPDDictionary;
  LI, LFieldFlag, LAnnotFlag: Integer;
  LOptionArray: TgtPDArray;
begin
  TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber :=
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber + 1;
  //Widget dictionary
  LWidgetDict := TgtPDDictionary.Create(
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber, 0,
    TgtPDDocument(FParentDoc).BaseDoc);
  TgtPDDocument(FParentDoc).BaseDoc.AddToCollection(LWidgetDict);
  //Common entries
  AddCommonWidgetEntries(AFormField, LWidgetDict);
  //justification
  LWidgetDict.Add(PDF_Q, TgtPDInteger.Create(Ord(AFormField.Justification)));

  //Adding Aditional Action Dictionary
  if Assigned(AFormField.Action) then
  begin
    LActionDict := TgtPDDictionary(
      CreateFormFieldAActionDict(AFormField.Action, AFormField.TriggerType));
    LWidgetDict.Add(PDF_AA, LActionDict);
  end;

  if AFormField.IsSortedList then
    TgtHackPDFormChoiceBox(AFormField).FValueList.Sort;

  LOptionArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
  for LI := 0 to (TgtHackPDFormChoiceBox(AFormField).FValueList.Count - 1) do
    LOptionArray.Add(TgtPDString.Create(
      TgtHackPDFormChoiceBox(AFormField).FValueList[LI], False));
  LWidgetDict.Add(PDF_OPT, LOptionArray);

  //Field Type
  LWidgetDict.Add(PDF_FT, TgtPDName.Create(PDF_CH));
  //Adding of MK Dictionary
  LMKDict := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);
  InsertMKDictEntries(AFormField, LMKDict);
  LWidgetDict.Add(PDF_MK, LMKDict);
  //Adding of Apperance Dictionary
//  LApDict := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);
//  LApDict.Add(PDF_N, CreateFormObject(AFormField));
//  LWidgetDict.Add(PDF_AP, LApDict);
  LWidgetDict.Add(PDF_AP, CreateAppDict(AFormField, AFontTag));
  //DA entry
  InsertDADictEntries(AFormField, LWidgetDict, AFontTag);
  //Field Value
  if ((AFormField.SelectedItemIndex >= 0) and
    (AFormField.SelectedItemIndex <= AFormField.OptionCount - 1)) then
  begin
    LWidgetDict.Add(PDF_V, TgtPDString.Create(
      AFormField.Options[AFormField.SelectedItemIndex], False));
  end
  else
    LWidgetDict.Add(PDF_V, TgtPDString.Create(AFormField.Value, False));
  //Default Field Value
  LWidgetDict.Add(PDF_DV, TgtPDString.Create(AFormField.DefaultValue, False));
  //Set Flag bits
  SetWidgetFlagBits(AFormField, LFieldFlag, LAnnotFlag);
  LWidgetDict.Add(PDF_FF, TgtPDInteger.Create(LFieldFlag));
  LWidgetDict.Add(PDF_F, TgtPDInteger.Create(LAnnotFlag));
  //Return indref of ComboBox dict
  Result := TgtPDIndirectRef.Create(LWidgetDict.ObjNumber, LWidgetDict.GenNumber);
end;

function TgtPDPage.CreateFileSpec(
  FileAttachment: TgtPDFileAttachmentAnnot): TgtPDBaseObject;
var
  LMemStrm: TMemoryStream;
  LgtMemStrm: TgtMemoryStream;
  LFileSpecDict, LEFDict, LFStrm,
    LFStrmDict, LIndRef, LParams: TgtPDBaseObject;
  LFileName: AnsiString;
  LDate: TgtDate;
begin
  //Update the Last object number for using
  TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber :=
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber + 1;
  //Create FileSpec Dictionary
  LFileSpecDict := TgtPDDictionary.Create(
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber, 0,
    TgtPDDocument(FParentDoc).BaseDoc);
  //Add the FileSpec Dict to the Collection to get the object from diffrent place
  TgtPDDocument(FParentDoc).BaseDoc.AddToCollection(LFileSpecDict);
  //Type this Dictionary defines
  TgtPDDictionary(LFileSpecDict).Add(PDF_TYPE, TgtPDName.Create(PDF_FILESPEC));
  //Get the Attachment file name from user after stripping the path
  LFileName := ExtractFileName(FileAttachment.FileName);
  //Add file name to the Dictionary
  TgtPDDictionary(LFileSpecDict).Add(PDF_F, TgtPDString.Create(LFileName, False));
  //Add file name (Unicode Filename) to Dictionary
  TgtPDDictionary(LFileSpecDict).Add(PDF_UF, TgtPDString.Create(LFileName, False));

  //Dictionary in the F Stream object
  LFStrmDict := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);
  //Memory stream which will load the File to be Embedded
  LMemStrm := TMemoryStream.Create;
  LgtMemStrm := TgtMemoryStream.Create(LMemStrm, 0, 0, False);
  //Load the file to be Embedded into the memory stream
  LMemStrm.LoadFromFile(FileAttachment.FileName);
  LgtMemStrm.Reset;
  //Update the Last object number for using
  TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber :=
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber + 1;
  //Create F Stream object
  LFStrm := TgtPDStream.Create(LgtMemStrm, LFStrmDict,
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber, 0);
  //Add the F stream object to the Collection to get the object from diffrent place
  TgtPDDocument(FParentDoc).BaseDoc.AddToCollection(LFStrm);
  //Add Length of the Stream
  TgtPDDictionary(LFStrmDict).Add(PDF_LENGTH, TgtPDInteger.Create(LMemStrm.Size));

  {$IFDEF VCL6ORABOVE}
  DecodeDateTime(Now, LDate.Year, LDate.Month, LDate.Day, LDate.Hour,
    LDate.Minutes, LDate.Seconds, LDate.MilliSeconds);
  {$ENDIF}
  {$IFDEF DELPHI5}
    DecodeDate(Now, LDate.Year, LDate.Month, LDate.Day);
    DecodeTime(Now, LDate.Hour, LDate.Minutes, LDate.Seconds, LDate.MilliSeconds);
  {$ENDIF}

  //Create Params Dictionary
  LParams := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);
  //Add Creation date to Param Dict
  TgtPDDictionary(LParams).Add(PDF_CREATIONDATE, TgtPDString.Create(DateToPDFString(LDate), False));
  //Add ModDate to Params Dictionary
  TgtPDDictionary(LParams).Add(PDF_MODDATE, TgtPDString.Create(DateToPDFString(LDate), False));
  //Add the Size of the Stream to Params Dict
  TgtPDDictionary(LParams).Add(PDF_SIZE, TgtPDInteger.Create(LMemStrm.Size));
  //Add Params Dict to F stream object
  TgtPDDictionary(LFStrmDict).Add(PDF_PARAMS, LParams);

  //Create EF Dict
  LEFDict := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);
  //Create an Indirect Ref for adding it to EF Dict
  LIndRef := TgtPDIndirectRef.Create(LFStrm.ObjNumber, LFStrm.GenNumber);
  TgtPDDictionary(LEFDict).Add(PDF_F, LIndRef);
 //
 //   vyshak's code begin
  TgtPDDictionary(LFileSpecDict).Add(PDF_EF, LEFDict);
 //  vyshak's code end
  //Return the Indirect Ref for FileSpec
  Result := TgtPDIndirectRef.Create(LFileSpecDict.ObjNumber, LFileSpecDict.GenNumber);
end;

function TgtPDPage.CreateFormFieldAActionDict(AAction: TgtPDAction;
  ATriggerType: TgtFormFieldActionTriggers): TgtPDBaseObject;
begin
  //create AAction dict
  Result := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);
  //add the event and the corresponding action to be performed.
  case ATriggerType of
    fftOnEnter: TgtPDDictionary(Result).Add(PDF_E, CreateActionDict(AAction));
    fftOnExit: TgtPDDictionary(Result).Add(PDF_X, CreateActionDict(AAction));
    fftMouseDown: TgtPDDictionary(Result).Add(PDF_D, CreateActionDict(AAction));
    fftMouseUp: TgtPDDictionary(Result).Add(PDF_U, CreateActionDict(AAction));
    fftGotFocus: TgtPDDictionary(Result).Add(PDF_FO, CreateActionDict(AAction));
    fftLostFocus: TgtPDDictionary(Result).Add(PDF_BL, CreateActionDict(AAction));
    fftOnKeyPress: TgtPDDictionary(Result).Add(PDF_K, CreateActionDict(AAction));
    fftFormat: TgtPDDictionary(Result).Add(PDF_F, CreateActionDict(AAction));
    fftValidate: TgtPDDictionary(Result).Add(PDF_V, CreateActionDict(AAction));
    fftCalculate: TgtPDDictionary(Result).Add(PDF_C, CreateActionDict(AAction));
  end;
end;

function TgtPDPage.CreateFormObject(AFormField: TgtPDFormField; var AFontTag: AnsiString;
  AI: Integer = 0; AFormItem: TgtPDRadioItem = nil; ADef: Boolean = False): TgtPDIndirectRef;
var
  LStream: TMemoryStream;
  LStr: AnsiString;
  LHeight, LWidth, LX, LY: Double;
  LFontProc: TgtFontProcessor;
  LFont: TFont;
  LEC: ErrorCodes;
  LFormDict, LResDict, LDict: TgtPDDictionary;
  LFormStream: TgtPDStream;
  LgtPDFont: TgtPDFont;
  LArray: TgtPDArray;
  LgtMemStream: TgtMemoryStream;
  LRect: TgtPDRect;
  LTempWidth, LTempHeight, LTemp: Double;
  LResource: TgtPDResource;
begin
  LX := 0;
  LY := 0;

  LFont := TFont.Create;
  LFont.Name := TgtHackPDFormField(AFormField).Font.Name;
  LFont.Size := TgtHackPDFormField(AFormField).Font.Size;
  LFont.Style := TgtHackPDFormField(AFormField).Font.Style;

  //Get the PSName using Font Proc
  LFontProc := TgtFontProcessor.Create(LFont, LEC);
  
  LRect := TgtPDRect.Create;
  try
    if Assigned(AFormItem) then
      GetTransformedRect(AFormItem.Rect, AFormField.Orientation, LRect)
    else
      GetTransformedRect(AFormField.Rect, AFormField.Orientation, LRect);

    LHeight := LRect.Bottom - LRect.Top;
    LWidth := LRect.Right - LRect.Left;
  finally
    FreeAndNil(LRect);
  end;

  if TgtHackPDFormField(AFormField).Font.Name = '' then
    TgtHackPDFormField(AFormField).Font.Name := 'Arial';

  //Get gtPDFont obj
  LgtPDFont := GetFontObject(FParentDoc, Resource,
    TgtHackPDFormField(AFormField).Font);

  AFontTag := LgtPDFont.Tag;

  //Create FormField Dict and add common entries
  LFormDict := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);
  with LFormDict do
  begin
    //subtype
    Add(PDF_SUBTYPE, TgtPDName.Create(PDF_FORM));

    //formfield BBox
    LTempWidth := LWidth;
    LTempHeight := LHeight;
    //swap LTempWidth & LTempHeight
    if ((AFormField.Orientation = ffo90) or
      (AFormField.Orientation = ffo270)) then
    begin
      LTemp := LTempWidth;
      LTempWidth := LTempHeight;
      LTempHeight := LTemp;
    end;

    LArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
    LArray.Add(TgtPDReal.Create(0));
    LArray.Add(TgtPDReal.Create(0));
    LArray.Add(TgtPDReal.Create(LTempWidth));
    LArray.Add(TgtPDReal.Create(LTempHeight));
    Add(PDF_BBOX, LArray);

    //add matrix entry based on Orientation set
    case AFormField.Orientation of
      ffo0:
      begin
        LArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
        LArray.Add(TgtPDReal.Create(1));
        LArray.Add(TgtPDReal.Create(0));
        LArray.Add(TgtPDReal.Create(0));
        LArray.Add(TgtPDReal.Create(1));
        LArray.Add(TgtPDReal.Create(0));
        LArray.Add(TgtPDReal.Create(0));
        Add(PDF_MATRIX, LArray);
      end;
      ffo90:
      begin
        LArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
        LArray.Add(TgtPDReal.Create(0));
        LArray.Add(TgtPDReal.Create(1));
        LArray.Add(TgtPDReal.Create(-1));
        LArray.Add(TgtPDReal.Create(0));
        LArray.Add(TgtPDReal.Create(LTempHeight));
        LArray.Add(TgtPDReal.Create(0));
        Add(PDF_MATRIX, LArray);
      end;
      ffo180:
      begin
        LArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
        LArray.Add(TgtPDReal.Create(-1));
        LArray.Add(TgtPDReal.Create(0));
        LArray.Add(TgtPDReal.Create(0));
        LArray.Add(TgtPDReal.Create(-1));
        LArray.Add(TgtPDReal.Create(LTempWidth));
        LArray.Add(TgtPDReal.Create(LTempHeight));
        Add(PDF_MATRIX, LArray);
      end;
      ffo270:
      begin
        LArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
        LArray.Add(TgtPDReal.Create(0));
        LArray.Add(TgtPDReal.Create(-1));
        LArray.Add(TgtPDReal.Create(1));
        LArray.Add(TgtPDReal.Create(0));
        LArray.Add(TgtPDReal.Create(0));
        LArray.Add(TgtPDReal.Create(LTempWidth));
        Add(PDF_MATRIX, LArray);
      end;
    end;
    //form res dict
    LResDict := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);
    Add(PDF_RESOURCES, LResDict);
    //add procset array to the res dict
    LArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
    LArray.Add(TgtPDName.Create(PDF_PDF));
    LArray.Add(TgtPDName.Create(PDF_TEXT));
    LResDict.Add(PDF_PROCSET, LArray);
    //add font dict only if it is not a radioitem with AI <> 0
    if not (Assigned(AFormItem) and (AI <> 0)) then
    begin
      //add font dict to the res dict
      LDict := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);
      LResDict.Add(PDF_FONT, LDict);
      LDict.Add(LgtPDFont.Tag, TgtPDIndirectRef.Create(
        LgtPDFont.BaseObject.ObjNumber, LgtPDFont.BaseObject.GenNumber));
    end;
  end;

  //Get the corresponding FormField stream
  LStream := nil;
  if AFormField is TgtPDFormPushButton then
  begin
    if LEC = Success then
    begin
      LX := (LWidth - LFontProc.GetTextWidth(
        TgtPDFormPushButton(AFormField).NormalCaption)) / 2;
      LY := LHeight - (Floor(abs(LHeight - (
        TgtPDFormPushButton(AFormField).Font.Size)) / 2) +
        ((72 / 96) * (TgtPDFormPushButton(AFormField).Font.Size)));
    end;
    LStream := GetPushButtonFormStream(LX, LY, LWidth, LHeight, LgtPDFont.Tag, AI,
      AFormField as TgtPDFormPushButton);
  end
  else if AFormField is TgtPDFormCheckBox then
  begin
    if (TgtPDFormCheckBox(AFormField).Font.Size = 0) then
      TgtPDFormCheckBox(AFormField).Font.Size := 16;
    LStream := GetCheckBoxFormStream(LWidth, LHeight, LgtPDFont.Tag, AI,
      AFormField as TgtPDFormCheckBox);
  end
  else if AFormField is TgtPDFormRadioButton then
  begin
    LStream := GetRadioItemFormStream(LWidth, LHeight, LgtPDFont.Tag, AI,
      AFormField as TgtPDFormRadioButton, AFormItem, ADef);
  end
  else if AFormField is TgtPDFormTextField then
  begin
    LY := ((LHeight - abs(TgtPDFormTextField(AFormField).Font.Size)) / 2)
      + (3 * TgtPDFormTextField(AFormField).Font.Size / 20);
    LStream := GetTextFieldFormStream(LY, LWidth, LHeight, LgtPDFont.Tag, AI,
      AFormField as TgtPDFormTextField);
  end
  else if AFormField is TgtPDFormComboBox then
  begin
    LStream := GetComboBoxFormStream(LWidth, LHeight, LgtPDFont.Tag,
      AFormField as TgtPDFormComboBox);
  end
  else if AFormField is TgtPDFormListBox then
  begin
    LStream := GetListBoxFormStream(LWidth, LHeight, LgtPDFont.Tag,
      AFormField as TgtPDFormListBox);
  end
  else if AFormField is TgtPDSignatureField then
  begin
    LStream := GetSigFormStream(LWidth, LHeight, LgtPDFont.Tag, 0,
      AFormField as TgtPDSignatureField);
  end;

//  if not (AFormField is TgtPDSignatureField) then
  begin
    //Return indirect ref of the FormField obj
    LgtMemStream := TgtMemoryStream.Create(LStream, 0, 0, False);
    LgtMemStream.Reset;

  LFormDict.Add(PDF_LENGTH, TgtPDInteger.Create(LStream.Size));

    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber :=
      TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber + 1;

    LFormStream := TgtPDStream.Create(LgtMemStream, LFormDict,
      TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber, 0);
  end;

  TgtPDDocument(FParentDoc).BaseDoc.AddToCollection(LFormStream);
  Result := TgtPDIndirectRef.Create(LFormStream.ObjNumber, LFormStream.GenNumber);

  if Assigned(LFontProc) then
    FreeAndNil(LFontProc);
  if Assigned(LFont) then
    FreeAndNil(LFont);
end;

function TgtPDPage.CreateListBoxDict(
  AFormField: TgtPDFormListBox; var AFontTag: AnsiString): TgtPDIndirectRef;
var
  LWidgetDict, LMKDict, LActionDict: TgtPDDictionary;
  LOptionArray: TgtPDArray;
  LI, LFieldFlag, LAnnotFlag: Integer;
begin
  TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber :=
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber + 1;
  //Widget dictionary
  LWidgetDict := TgtPDDictionary.Create(
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber, 0,
    TgtPDDocument(FParentDoc).BaseDoc);
  TgtPDDocument(FParentDoc).BaseDoc.AddToCollection(LWidgetDict);
  //Common entries
  AddCommonWidgetEntries(AFormField, LWidgetDict);
  //justification
  LWidgetDict.Add(PDF_Q, TgtPDInteger.Create(Ord(AFormField.Justification)));

  //Adding Additional Action Dictionary
  if Assigned(AFormField.Action) then
  begin
    LActionDict := TgtPDDictionary(
      CreateFormFieldAActionDict(AFormField.Action, AFormField.TriggerType));
    LWidgetDict.Add(PDF_AA, LActionDict);
  end;

  if AFormField.IsSortedList then
    TgtHackPDFormChoiceBox(AFormField).FValueList.Sort;

  //Option array
  LOptionArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
  for LI := 0 to (TgtHackPDFormChoiceBox(AFormField).FValueList.Count - 1) do
    LOptionArray.Add(TgtPDString.Create(
      TgtHackPDFormChoiceBox(AFormField).FValueList[LI], False));
  LWidgetDict.Add(PDF_OPT, LOptionArray);
  //Field Type
  LWidgetDict.Add(PDF_FT, TgtPDName.Create(PDF_CH));
  //Adding of MK Dictionary
  LMKDict := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);
  InsertMKDictEntries(AFormField, LMKDict);
  LWidgetDict.Add(PDF_MK, LMKDict);
  //Adding of Apperance Dictionary
//  LApDict := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);
//  LApDict.Add(PDF_N, CreateFormObject(AFormField));
//  LWidgetDict.Add(PDF_AP, LApDict);
  LWidgetDict.Add(PDF_AP, CreateAppDict(AFormField, AFontTag));
  //DA entry
  InsertDADictEntries(AFormField, LWidgetDict, AFontTag);
  //Field Value
  LWidgetDict.Add(PDF_V, TgtPDString.Create(AFormField.Value, False));
  //Default Field Value
  LWidgetDict.Add(PDF_DV, TgtPDString.Create(AFormField.DefaultValue, False));
  //Set Flag bits
  SetWidgetFlagBits(AFormField, LFieldFlag, LAnnotFlag);
  LWidgetDict.Add(PDF_FF, TgtPDInteger.Create(LFieldFlag));
  LWidgetDict.Add(PDF_F, TgtPDInteger.Create(LAnnotFlag));
  //Return indref of listbox dict
  Result := TgtPDIndirectRef.Create(LWidgetDict.ObjNumber, LWidgetDict.GenNumber);
end;

function TgtPDPage.CreatePushButtonDict(
  AFormField: TgtPDFormPushButton; var AFontTag: AnsiString): TgtPDIndirectRef;
var
  LWidgetDict, LActionDict, LMKDict: TgtPDDictionary;
  LFieldFlag, LAnnotFlag: Integer;
begin
  TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber :=
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber + 1;
  //Widget dictionary
  LWidgetDict := TgtPDDictionary.Create(
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber, 0,
    TgtPDDocument(FParentDoc).BaseDoc);
  TgtPDDocument(FParentDoc).BaseDoc.AddToCollection(LWidgetDict);
  AddCommonWidgetEntries(AFormField, LWidgetDict);
  LWidgetDict.Add(PDF_Q, TgtPDInteger.Create(Ord(AFormField.Justification)));
  LWidgetDict.Add(PDF_FT, TgtPDName.Create(PDF_Btn));
  SetWidgetFlagBits(AFormField, LFieldFlag, LAnnotFlag);
  LWidgetDict.Add(PDF_FF, TgtPDInteger.Create(LFieldFlag));
  LWidgetDict.Add(PDF_F, TgtPDInteger.Create(LAnnotFlag));
  //Adding Action Dictionary
  if Assigned(AFormField.Action) then
  begin
    LActionDict := TgtPDDictionary(CreateActionDict(AFormField.Action));
    LWidgetDict.Add(PDF_A, LActionDict);
  end;
  //Adding of MK Dictionary
  LMKDict := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);
  InsertMKDictEntries(AFormField, LMKDict);
  LWidgetDict.Add(PDF_MK, LMKDict);
  LWidgetDict.Add(PDF_H, TgtPDName.Create(PDF_P));
  //Adding of Apperance Dictionary
  LWidgetDict.Add(PDF_AP, CreateAppDict(AFormField, AFontTag));
  InsertDADictEntries(AFormField, LWidgetDict, AFontTag);
  Result := TgtPDIndirectRef.Create(LWidgetDict.ObjNumber, LWidgetDict.GenNumber);
end;

function TgtPDPage.CreateRadioBtnDict(
  AFormField: TgtPDFormRadioButton; var AFontTag: AnsiString): TgtPDIndirectRef;
var
  LFieldFlag, LAnnotFlag: Integer;
  LRadioBtnDict: TgtPDDictionary;
  LKidsArray: TgtPDArray;
  LIndRef: TgtPDIndirectRef;
  LRadioItemList: TObjectList;
begin
  LAnnotFlag := 4;
  LFieldFlag := 0;
  LFieldFlag := LFieldFlag and not (1 shl 16); //17-bit if set, specifies pushbutton
  LFieldFlag := LFieldFlag or (1 shl 15); //16-bit specifies set of radio buttons
  LFieldFlag := LFieldFlag or (1 shl 14); //15-bit specifies only one radiobutton selected always

  TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber :=
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber + 1;
  //Widget dictionary
  LRadioBtnDict := TgtPDDictionary.Create(
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber, 0,
    TgtPDDocument(FParentDoc).BaseDoc);
  TgtPDDocument(FParentDoc).BaseDoc.AddToCollection(LRadioBtnDict);
  //-----------Check again--------------//
  //Default value
  LRadioBtnDict.Add(PDF_DV, TgtPDName.Create(AFormField.DefaultValue));
  LRadioItemList := TgtHackPDFormRadioButton(AFormField).FRadioItemList;
  //Field value
  if ((AFormField.SelectedItemIndex >= 0) and
    (AFormField.SelectedItemIndex <= LRadioItemList.Count - 1) and
    (AFormField.AtleastOneSelectedItem)) then
  begin
    LRadioBtnDict.Add(PDF_V, TgtPDName.Create(
      TgtPDRadioItem(LRadioItemList[AFormField.SelectedItemIndex]).Value));
  end
  else
    LRadioBtnDict.Add(PDF_V, TgtPDName.Create(PDF_OFF));
  //------------------------------------//
  //Fieldtype
  LRadioBtnDict.Add(PDF_FT, TgtPDName.Create(PDF_BTN));
  //Fieldname
  LRadioBtnDict.Add(PDF_T, TgtPDString.Create(AFormField.FieldName, False));
  //Alternate Fieldname
  LRadioBtnDict.Add(PDF_TU, TgtPDString.Create(AFormField.AltFieldName, False));
  //BorderStyle
  //InsertBSDictEntries(AFormField, LRadioBtnDict);
  //Add radio items
  LIndRef := TgtPDIndirectRef.Create(LRadioBtnDict.ObjNumber,
    LRadioBtnDict.GenNumber);
  LKidsArray := CreateRadioKidsArray(AFormField, AFontTag, LIndRef);
  LRadioBtnDict.Add(PDF_KIDS, LKidsArray);
  //AnnotsFlag
  LRadioBtnDict.Add(PDF_F, TgtPDInteger.Create(LAnnotFlag));
  //FieldsFlag
  if not AFormField.AtleastOneSelectedItem then
    LFieldFlag := LFieldFlag and not (1 shl 14); //none is selected
  LRadioBtnDict.Add(PDF_FF, TgtPDInteger.Create(LFieldFlag));
  //Return indref of radiobutton dict
  Result := LIndRef;
end;

function TgtPDPage.CreateRadioKidsArray(
  AFormField: TgtPDFormRadioButton; var AFontTag: AnsiString; ARadioBtnRef: TgtPDIndirectRef): TgtPDArray;
var
  LI, LFieldFlag, LAnnotFlag: Integer;
  LRadioItem: TgtPDRadioItem;
  LWidgetDict, LMKDict, LActionDict: TgtPDDictionary;
  LIndRef: TgtPDIndirectRef;
  LAnnotsObj: TgtPDBaseObject;
  LCh: AnsiChar;
begin
  Result := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
  for LI := 0 to (TgtHackPDFormRadioButton(AFormField).FRadioItemList.Count - 1) do
  begin
    //fetch individual radio item
    LRadioItem := TgtPDRadioItem(TgtHackPDFormRadioButton(AFormField).
      FRadioItemList[LI]);

    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber :=
      TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber + 1;
    //Widget dictionary
    LWidgetDict := TgtPDDictionary.Create(
      TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber, 0,
      TgtPDDocument(FParentDoc).BaseDoc);
    TgtPDDocument(FParentDoc).BaseDoc.AddToCollection(LWidgetDict);

    //Field value
    //LWidgetDict.Add(PDF_V, TgtPDName.Create(AFormField.Value));
    //Common entries
    AddCommonWidgetEntries(LRadioItem, LWidgetDict);
    //Set flag
    SetWidgetFlagBits(AFormField, LFieldFlag, LAnnotFlag);
    LWidgetDict.Add(PDF_FF, TgtPDInteger.Create(LFieldFlag));
    LWidgetDict.Add(PDF_F, TgtPDInteger.Create(LAnnotFlag));
    LWidgetDict.Add(PDF_PARENT, ARadioBtnRef.Clone as TgtPDIndirectRef);
    //Adding of MK Dictionary
    LMKDict := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);
    InsertMKDictEntries(LRadioItem, LMKDict);
    //Symbol into MKDict
    case TgtPDFormRadioButton(AFormField).Symbol of
      csCheck: LCh := '4';
      csCircle: LCh := 'l';
      csCross: LCh := '8';
      csDiamond: LCh := 'u';
      csSquare: LCh := 'n';
      csStar: LCh := 'H';
    else
      LCh := 'l';
    end;

    LMKDict.Add(PDF_CA, TgtPDString.Create(LCh, False));
    LWidgetDict.Add(PDF_MK, LMKDict);

    //Adding Aditional Action Dictionary
    if Assigned(AFormField.Action) then
    begin
      LActionDict := TgtPDDictionary(
        CreateFormFieldAActionDict(AFormField.Action, AFormField.TriggerType));
      LWidgetDict.Add(PDF_AA, LActionDict);
    end;

    //Appearance State
    if (LI = AFormField.SelectedItemIndex) then
      LWidgetDict.Add(PDF_AS, TgtPDName.Create(LRadioItem.Value))
    else
      LWidgetDict.Add(PDF_AS, TgtPDName.Create(PDF_OFF));
    
    LWidgetDict.Add(PDF_H, TgtPDName.Create(PDF_P));

//    //Normal appearence
//    LNormAppDict := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);
//    LNormAppDict.Add(LRadioItem.Value,
//      CreateFormObject(AFormField, 0, LRadioItem, False));
//    LNormAppDict.Add(PDF_OFF,
//      CreateFormObject(AFormField, 1, LRadioItem, False));
//    //Default Appearance
//    LDefAppDict := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);
//    LDefAppDict.Add(LRadioItem.Value,
//      CreateFormObject(AFormField, 0, LRadioItem, True));
//    LDefAppDict.Add(PDF_OFF,
//      CreateFormObject(AFormField, 1, LRadioItem, True));
//    //Adding of Apperance Dictionary
//    LApDict := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);
//    LApDict.Add(PDF_N, LNormAppDict);
//    LApDict.Add(PDF_D, LDefAppDict);
//    LWidgetDict.Add(PDF_AP, LApDict);

    LWidgetDict.Add(PDF_AP, CreateAppDict(AFormField, AFontTag, LRadioItem));
    //DA entry
    InsertDADictEntries(AFormField, LWidgetDict, AFontTag);
    //Add the RadioItem Dict into the Array
    LIndRef := TgtPDIndirectRef.Create(LWidgetDict.ObjNumber, LWidgetDict.GenNumber);
    Result.Add(LIndRef);
    //Also add the RadioItem Dict to current page annots array
    LAnnotsObj := TgtPDDictionary(FBaseObject).LookUp(PDF_ANNOTS);
    if not Assigned(LAnnotsObj) then
    begin
      LAnnotsObj := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
      TgtPDDictionary(FBaseObject).Add(PDF_ANNOTS, LAnnotsObj);
    end;
    TgtPDArray(LAnnotsObj).Add(LIndRef.Clone);
  end;
end;

function TgtPDPage.CreateSigDict(ASig: TgtPDSignature): TgtPDIndirectRef;
var
  LSigDict: TgtPDDictionary;
  LStr: Ansistring;
  LArray: TgtPDArray;
  LContents: array[1..PDF_SIGVALUELENGTH] of AnsiChar;
begin
  TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber :=
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber + 1;
  //Sig dictionary
  LSigDict := TgtPDDictionary.Create(
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber, 0,
    TgtPDDocument(FParentDoc).BaseDoc);
  TgtPDDocument(FParentDoc).BaseDoc.AddToCollection(LSigDict);

  case ASig.SubFilter of
    sfX509RsaSha1: LStr := PDF_RSASHA1;
    sfPkcs7Detached: LStr := PDF_DETACHED;
    sfPkcs7Sha1: LStr := PDF_SHA1;
  end;
  with TgtPDDocument(FParentDoc).BaseDoc.Signature do
  begin
    Author := ASig.Author;
    ContactInfo := ASig.Author;
    Location := ASig.Location;
    Reason := ASig.Reason;
    Filter := ASig.Handler;
    PFXFileName := ASig.PFXFileName;
    PFXPassWord := ASig.PFXPassWord;
    Subfilter := LStr;
    DateTime := ASig.DateTime;
  end;
//  GetMem(LContents, PDF_SIGVALUELENGTH);
  FillChar(LContents, PDF_SIGVALUELENGTH, Ord(' '));
  // Dummy key to add place holder and tag for finding the offset for sig dict
  LSigDict.Add(PDF_GNOSTICETAG, TgtPDName.Create(LContents));
//  FreeMem(LContents);
  Result := TgtPDIndirectRef.Create(LSigDict.ObjNumber, LSigDict.GenNumber);
end;

function TgtPDPage.CreateSigFieldDict(AFormField: TgtPDSignatureField;
  var AFontTag: AnsiString): TgtPDIndirectRef;
var
  LSigDict, LActionDict, LApDict, LMKDict: TgtPDDictionary;
  LAnnotFlag, LFieldFlag: Integer;
  LFntName: Ansistring;
begin
  TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber :=
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber + 1;
  //Widget dictionary
  LSigDict := TgtPDDictionary.Create(
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber, 0,
    TgtPDDocument(FParentDoc).BaseDoc);
  TgtPDDocument(FParentDoc).BaseDoc.AddToCollection(LSigDict);
  //Common entries
  AddCommonWidgetEntries(AFormField, LSigDict);

  // Write Appearance
//  LApDict := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);
//  LResDict := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);
  //Adding of MK Dictionary
  LMKDict := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);
  InsertMKDictEntries(AFormField, LMKDict);
  LSigDict.Add(PDF_MK, LMKDict);

  LSigDict.Add(PDF_AP, CreateAppDict(AFormField, AFontTag));
  
//  LSigDict.Add(PDF_AP, LApDict);
  //FieldType
  LSigDict.Add(PDF_FT, TgtPDName.Create(PDF_SIG));
  //DA entry
//  InsertDADictEntries(AFormField, LSigDict, AFontTag);
  // Parent entry, otherwise in reader it will not be shown properly in signature tab
  LSigDict.Add(PDF_P, TgtPDIndirectRef.Create(Self.BaseObject.ObjNumber,
    Self.BaseObject.GenNumber));

  //Field Value
  // if not pfx file name is given, add a blank signature
  if AFormField.Signature.PFXFileName <> '' then
    LSigDict.Add(PDF_V, CreateSigDict(AFormField.Signature));
  //Default Field Value
//  LSigDict.Add(PDF_DV, TgtPDString.Create(AFormField.DefaultValue, False));
  //Set Flag bits
  SetWidgetFlagBits(AFormField, LFieldFlag, LAnnotFlag);

  LSigDict.Add(PDF_FF, TgtPDInteger.Create(LFieldFlag));
  LSigDict.Add(PDF_F, TgtPDInteger.Create(LAnnotFlag));

  Result := TgtPDIndirectRef.Create(LSigDict.ObjNumber, LSigDict.GenNumber);
end;

function TgtPDPage.CreateTextFieldDict(
  AFormField: TgtPDFormTextField; var AFontTag: AnsiString): TgtPDIndirectRef;
var
  LWidgetDict, LMKDict, LActionDict: TgtPDDictionary;
  LAnnotFlag, LFieldFlag: Integer;
begin
  TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber :=
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber + 1;
  //Widget dictionary
  LWidgetDict := TgtPDDictionary.Create(
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber, 0,
    TgtPDDocument(FParentDoc).BaseDoc);
  TgtPDDocument(FParentDoc).BaseDoc.AddToCollection(LWidgetDict);
  //Common entries
  AddCommonWidgetEntries(AFormField, LWidgetDict);
  //justification
  LWidgetDict.Add(PDF_Q, TgtPDInteger.Create(Ord(AFormField.Justification)));
  //Adding Aditional Action Dictionary
  if Assigned(AFormField.Action) then
  begin
    LActionDict := TgtPDDictionary(
      CreateFormFieldAActionDict(AFormField.Action, AFormField.TriggerType));
    LWidgetDict.Add(PDF_AA, LActionDict);
  end;
  //Adding of MK Dictionary
  LMKDict := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);
  InsertMKDictEntries(AFormField, LMKDict);
  LWidgetDict.Add(PDF_MK, LMKDict);
  //Adding of Apperance Dictionary

//  LApDict := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);
//  if (AFormField.IsMultiline) then
//    LApDict.Add(PDF_N, CreateFormObject(AFormField, 0))
//  else
//    LApDict.Add(PDF_N, CreateFormObject(AFormField, 1));
//  LWidgetDict.Add(PDF_AP, LApDict);

  LWidgetDict.Add(PDF_AP, CreateAppDict(AFormField, AFontTag));
  //FieldType
  LWidgetDict.Add(PDF_FT, TgtPDName.Create(PDF_TX));
  //DA entry
  InsertDADictEntries(AFormField, LWidgetDict, AFontTag);
  //Field Value
  LWidgetDict.Add(PDF_V, TgtPDString.Create(AFormField.Value, False));
  //Default Field Value
  LWidgetDict.Add(PDF_DV, TgtPDString.Create(AFormField.DefaultValue, False));
  //Maximum Length of the text to be inserted
  if AFormField.MaxLength > 0 then
    LWidgetDict.Add(PDF_MAXLEN, TgtPDInteger.Create(AFormField.MaxLength));
  //Set Flag bits
  SetWidgetFlagBits(AFormField, LFieldFlag, LAnnotFlag);
  LWidgetDict.Add(PDF_FF, TgtPDInteger.Create(LFieldFlag));
  LWidgetDict.Add(PDF_F, TgtPDInteger.Create(LAnnotFlag));
  //Return indref of textfield dict
  Result := TgtPDIndirectRef.Create(LWidgetDict.ObjNumber, LWidgetDict.GenNumber);
end;

procedure TgtPDPage.CurveTo(X1, Y1, X2, Y2, X3, Y3: Double);
begin
  FCurrentCS.CurveTo(X1, GetNativeYPos(Y1), X2, GetNativeYPos(Y2),
    X3, GetNativeYPos(Y3));
  UpdatePDStreamLength;
end;

procedure TgtPDPage.CurveTo(X1, Y1, X2, Y2, X3, Y3: Double; isNative: Boolean);
begin
 if isNAtive then
 begin
  FCurrentCS.CurveTo(X1, (Y1), X2, (Y2),
    X3, (Y3));
    UpdatePDStreamLength;
 end
 else
 begin
   CurveTo( X1, Y1, X2, Y2, X3, Y3);
 end;
end;

function TgtPDPage.DegreesToRadians(Degrees: Extended): Extended;
begin
  Result := Degrees * (PI / 180);
end;

destructor TgtPDPage.Destroy;
var
  LI: Integer;
begin
  FreeResources;

  inherited;
end;

procedure TgtPDPage.Display(OutDev: TgtPDExportDevice; hDPI, vDPI: Double;
  Rotate: Integer; UseMediaBox, Crop: Boolean; Printing: Boolean;
  RenderAnnots: Boolean);
begin
  DisplaySlice(OutDev, hDPI, vDPI, Rotate, UseMediaBox, Crop, -1, -1, -1, -1,
    Printing, RenderAnnots);
end;

procedure TgtPDPage.DisplaySlice(OutDev: TgtPDExportDevice; hDPI, vDPI: Double;
  Rotate: Integer; UseMediaBox, Crop: Boolean; SliceX, SliceY, SliceW,
  SliceH: Integer; Printing: Boolean; RenderAnnots: Boolean);
var
  LBox: TgtPDRect;
  LCrop: Boolean;
//  I: Integer;
begin
  if not OutDev.CheckPageSlice(Self, hDPI, vDPI, Rotate, UseMediaBox, Crop,
    SliceX, SliceY, SliceW, SliceH) then
    Exit;

  Rotate := Rotate + GetRotate;

  if Rotate >= 360 then
    Rotate := Rotate - 360
  else if Rotate < 0 then
    Rotate := Rotate + 360;

  LBox := TgtPDRect.Create;
  LCrop := Crop;
  MakeBox(hDPI, vDPI, Rotate, UseMediaBox, OutDev.UpsideDown, SliceX, SliceY,
    SliceW, SliceH, LBox, LCrop);

  if Assigned(Contents) then
  begin
    if Assigned(Cropbox) then
      Contents.Display(OutDev, hDPI, vDPI, PageNum, Rotate, LBox, Cropbox, RenderAnnots)
    else
      Contents.Display(OutDev, hDPI, vDPI, PageNum, Rotate, LBox, Mediabox, RenderAnnots);
  end;
  if Assigned(LBox) then
    LBox.Free;
end;

procedure TgtPDPage.DrawEllipse(aCenterX, aCenterY, aMajorRadius,
  aMinorRadius: Double; aPenWidth: Integer; aPenColor, aBrushColor: TColor; aOpacityStroke,
  aOpacityFill: Integer);
const
  Kappa = 0.5522847498;
begin
  if not Assigned(FContents) then
    SetRenderMode(rmOverLay);
  MoveTo(aCenterX, aCenterY + aMinorRadius);
  CurveTo(aCenterX + (Kappa * aMajorRadius),
    (aCenterY + aMinorRadius),
    (aCenterX + aMajorRadius),
    (aCenterY + (Kappa * aMinorRadius)),
    (aCenterX + aMajorRadius),
    aCenterY);
  CurveTo(aCenterX + aMajorRadius,
    (aCenterY - (Kappa * aMinorRadius)),
    (aCenterX + (Kappa * aMajorRadius)),
    (aCenterY - aMinorRadius),
    aCenterX,
    (aCenterY - aMinorRadius));
  CurveTo(aCenterX - (Kappa * aMajorRadius),
    (aCenterY - aMinorRadius),
    (aCenterX - aMajorRadius),
    (aCenterY - (Kappa * aMinorRadius)),
    (aCenterX - aMajorRadius),
    aCenterY);
  CurveTo(aCenterX - aMajorRadius,
    (aCenterY + (Kappa * aMinorRadius)),
    (aCenterX - (Kappa * aMajorRadius)),
    (aCenterY + aMinorRadius),
    aCenterX,
    (aCenterY + aMinorRadius));
  SetPenWidth(aPenWidth);
  SetOpacity(aOpacityStroke, aOpacityFill);
  SetPenColor(
    GetRValue(aPenColor),
    GetGValue(aPenColor),
    GetBValue(aPenColor));
  SetBrushColor(
    GetRValue(aBrushColor),
    GetGValue(aBrushColor),
    GetBValue(aBrushColor));
  SetEvenOddFillMode(True);
  if ((aPenColor <> Graphics.clNone) and (aBrushColor <> Graphics.clNone)) then
    FillAndStrokePath
  else if ((aPenColor <> Graphics.clNone) and (aBrushColor = Graphics.clNone)) then
    StrokePath
  else if ((aPenColor = Graphics.clNone) and (aBrushColor <> Graphics.clNone)) then
    FillPath
  else
    StrokePath;
end;

// Draw Arc
procedure TgtPDPage.DrawArc(X1, Y1, X2, y2, X3, Y3, X4, Y4: Double; aPen: TPen);
var
	XCenter, YCenter, RadiusX, RadiusY, StartX, StartY: Double;
	Alpha, Beta, TempAngle: Double;
  cpFactor: Double;
	AlphaRad, BetaRad, cosAlpha, cosBeta, sinAlpha, sinBeta: Double;
begin
  if not Assigned(FContents) then
    SetRenderMode(rmOverLay);
  if Assigned(aPen) then
  begin
    SetPenWidth(aPen.Width);
    SetPenColor(GetRValue(aPen.Color),
      GetGValue(aPen.Color),
      GetBValue(aPen.Color));
    SetDashPattern(APen.Style, pjsNone, pcsNone);
  end;
  Y1:= GetNativeYPos(Y1);
  Y2:= GetNativeYPos(Y2);
  Y3:= GetNativeYPos(Y3);
  Y4:= GetNativeYPos(Y4);
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
	StartX := XCenter - RadiusX * cos(DegreesToRadians(Alpha));
	StartY := YCenter - RadiusY * sin(DegreesToRadians(Alpha));

  //Move to Start Point
  MoveTo(StartX,StartY, True);

  while (Beta - Alpha > 90) do
	begin
		TempAngle := Alpha + 90;

    // Convert from degrees to radians.
    AlphaRad := DegreesToRadians(Alpha);
    BetaRad  := DegreesToRadians(TempAngle);
    // This factor is used to calculate control points.
    cpFactor := (4.0/3 * (1 - cos((BetaRad - AlphaRad)/2)) /
      sin((BetaRad - AlphaRad) / 2));

    sinAlpha := sin(AlphaRad);
    sinBeta := sin(BetaRad);
    cosAlpha := cos(AlphaRad);
    cosBeta := cos(BetaRad);

    CurveTo(
      XCenter - RadiusX * (cosAlpha - cpFactor * sinAlpha),
      YCenter - RadiusY * (sinAlpha + cpFactor * cosAlpha),
      XCenter - RadiusX * (cosBeta + cpFactor * sinBeta),
      YCenter - RadiusY * (sinBeta - cpFactor * cosBeta),
      XCenter - RadiusX * cosBeta,
      YCenter - RadiusY * sinBeta,
      True);

      Alpha := TempAngle;
	end;
	if (Alpha <> Beta) then
  begin
		// Convert from degrees to radians.
	AlphaRad := DegreesToRadians(Alpha);
	BetaRad  := DegreesToRadians(Beta);
	// This factor is used to calculate control points.
	cpFactor := (4.0/3 * (1 - cos((BetaRad - AlphaRad)/2)) /
		sin((BetaRad - AlphaRad) / 2));

 	sinAlpha := sin(AlphaRad);
	sinBeta := sin(BetaRad);
	cosAlpha := cos(AlphaRad);
	cosBeta := cos(BetaRad);

	CurveTo(
		XCenter - RadiusX * (cosAlpha - cpFactor * sinAlpha),
		YCenter - RadiusY * (sinAlpha + cpFactor * cosAlpha),
		XCenter - RadiusX * (cosBeta + cpFactor * sinBeta),
		YCenter - RadiusY * (sinBeta - cpFactor * cosBeta),
		XCenter - RadiusX * cosBeta,
		YCenter - RadiusY * sinBeta,
    True);

  end;

 StrokePath;
end;

procedure TgtPDPage.DrawChord(X1, Y1, X2, y2, X3, Y3, X4, Y4: Double;
  aPen: TPen; aBrush: TBrush; aOpacityStroke, aOpacityFill: Integer);
var
	XCenter, YCenter, RadiusX, RadiusY, StartX, StartY: Double;
	Alpha, Beta, TempAngle: Double;
  cpFactor: Double;
	AlphaRad, BetaRad, cosAlpha, cosBeta, sinAlpha, sinBeta: Double;
begin
   if not Assigned(FContents) then
    SetRenderMode(rmOverLay);
  if Assigned(aPen) then
  begin
    SetPenWidth(aPen.Width);
    SetPenColor(GetRValue(aPen.Color),
      GetGValue(aPen.Color),
      GetBValue(aPen.Color));
    SetDashPattern(APen.Style, pjsNone, pcsNone);
  end;
  if Assigned(aBrush) then
  begin
    SetBrushColor(GetRValue(aBrush.Color),
      GetGValue(aBrush.Color),
      GetBValue(aBrush.Color));
  end;
  SetOpacity(aOpacityStroke, aOpacityFill);
  SetEvenOddFillMode(True);


  Y1:= GetNativeYPos(Y1);
  Y2:= GetNativeYPos(Y2);
  Y3:= GetNativeYPos(Y3);
  Y4:= GetNativeYPos(Y4);
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
	StartX := XCenter - RadiusX * cos(DegreesToRadians(Alpha));
	StartY := YCenter - RadiusY * sin(DegreesToRadians(Alpha));

  //Move to Start Point
  MoveTo(StartX,StartY, True);
  while (Beta - Alpha > 90) do
	begin
		TempAngle := Alpha + 90;

    // Convert from degrees to radians.
    AlphaRad := DegreesToRadians(Alpha);
    BetaRad  := DegreesToRadians(TempAngle);
    // This factor is used to calculate control points.
    cpFactor := (4.0/3 * (1 - cos((BetaRad - AlphaRad)/2)) /
      sin((BetaRad - AlphaRad) / 2));

    sinAlpha := sin(AlphaRad);
    sinBeta := sin(BetaRad);
    cosAlpha := cos(AlphaRad);
    cosBeta := cos(BetaRad);

    CurveTo(
      XCenter - RadiusX * (cosAlpha - cpFactor * sinAlpha),
      YCenter - RadiusY * (sinAlpha + cpFactor * cosAlpha),
      XCenter - RadiusX * (cosBeta + cpFactor * sinBeta),
      YCenter - RadiusY * (sinBeta - cpFactor * cosBeta),
      XCenter - RadiusX * cosBeta,
      YCenter - RadiusY * sinBeta,
      True);

      Alpha := TempAngle;
	end;
	if (Alpha <> Beta) then
  begin
		// Convert from degrees to radians.
	AlphaRad := DegreesToRadians(Alpha);
	BetaRad  := DegreesToRadians(Beta);
	// This factor is used to calculate control points.
	cpFactor := (4.0/3 * (1 - cos((BetaRad - AlphaRad)/2)) /
		sin((BetaRad - AlphaRad) / 2));

 	sinAlpha := sin(AlphaRad);
	sinBeta := sin(BetaRad);
	cosAlpha := cos(AlphaRad);
	cosBeta := cos(BetaRad);

	CurveTo(
		XCenter - RadiusX * (cosAlpha - cpFactor * sinAlpha),
		YCenter - RadiusY * (sinAlpha + cpFactor * cosAlpha),
		XCenter - RadiusX * (cosBeta + cpFactor * sinBeta),
		YCenter - RadiusY * (sinBeta - cpFactor * cosBeta),
		XCenter - RadiusX * cosBeta,
		YCenter - RadiusY * sinBeta,
    True);

  end;

  LineTo(StartX,StartY,True);

  if Assigned(aPen) and Assigned(aBrush) and (aPen.Style <> psClear) and (aBrush.Style <> bsClear) then
    FillAndStrokePath
  else if Assigned(aPen) and (aPen.Style <> psClear) then
    StrokePath
  else if Assigned(aBrush) and (aBrush.Style <> bsClear) then
    FillPath
  else
    StrokePath;
end;

procedure TgtPDPage.DrawEllipse(aCenterX, aCenterY, aMajorRadius,
  aMinorRadius: Double; aPen: TPen; ABrush: TBrush; aOpacityStroke,
  aOpacityFill: Integer);
const
  Kappa = 0.5522847498;
begin
  if not Assigned(FContents) then
    SetRenderMode(rmOverLay);
  MoveTo(aCenterX, aCenterY + aMinorRadius);
  CurveTo(aCenterX + (Kappa * aMajorRadius),
    (aCenterY + aMinorRadius),
    (aCenterX + aMajorRadius),
    (aCenterY + (Kappa * aMinorRadius)),
    (aCenterX + aMajorRadius),
    aCenterY);
  CurveTo(aCenterX + aMajorRadius,
    (aCenterY - (Kappa * aMinorRadius)),
    (aCenterX + (Kappa * aMajorRadius)),
    (aCenterY - aMinorRadius),
    aCenterX,
    (aCenterY - aMinorRadius));
  CurveTo(aCenterX - (Kappa * aMajorRadius),
    (aCenterY - aMinorRadius),
    (aCenterX - aMajorRadius),
    (aCenterY - (Kappa * aMinorRadius)),
    (aCenterX - aMajorRadius),
    aCenterY);
  CurveTo(aCenterX - aMajorRadius,
    (aCenterY + (Kappa * aMinorRadius)),
    (aCenterX - (Kappa * aMajorRadius)),
    (aCenterY + aMinorRadius),
    aCenterX,
    (aCenterY + aMinorRadius));
  SetOpacity(aOpacityStroke, aOpacityFill);
  if Assigned(APen) then
  begin
    SetPenWidth(aPen.Width);
    SetPenColor(GetRValue(aPen.Color),
      GetGValue(aPen.Color),
      GetBValue(aPen.Color));
    SetDashPattern(APen.Style, pjsNone, pcsNone);
  end;
  if Assigned(ABrush) then
  begin
    SetBrushColor(GetRValue(ABrush.Color),
      GetGValue(ABrush.Color),
      GetBValue(ABrush.Color));
  end;
  SetEvenOddFillMode(True);
  if Assigned(aPen) and Assigned(aBrush) and (aPen.Style <> psClear) and (aBrush.Style <> bsClear) then
    FillAndStrokePath
  else if Assigned(aPen) and (aPen.Style <> psClear) then
    StrokePath
  else if Assigned(aBrush) and (aBrush.Style <> bsClear) then
    FillPath;
end;

procedure TgtPDPage.DrawLine(aX1, aY1, aX2, aY2: Double; APen: TPen;
  aOpacityStroke, aOpacityFill: Integer);
begin
  if not Assigned(FContents) then
    SetRenderMode(rmOverLay);
  if Assigned(APen) then
  begin
    SetPenColor(GetRValue(APen.Color),
      GetGValue(APen.Color),
      GetBValue(APen.Color));
    SetPenWidth(APen.Width);
    SetDashPattern(APen.Style, pjsNone, pcsNone);
  end;
  SetOpacity(aOpacityStroke, aOpacityFill);
  MoveTo(aX1, aY1);
  LineTo(aX2, aY2);
  if Assigned(APen) and (APen.Style <> psClear) then
    StrokePath;
end;

procedure TgtPDPage.DrawLine(aX1, aY1, aX2, aY2: Double; aPenWidth: Integer;
  aPenColor: TColor; aOpacityStroke, aOpacityFill: Integer);
begin
  if not Assigned(FContents) then
    SetRenderMode(rmOverLay);
  SetPenColor(GetRValue(aPenColor),
    GetGValue(aPenColor),
    GetBValue(aPenColor));
  SetOpacity(aOpacityStroke, aOpacityFill);
  SetPenWidth(aPenWidth);
  MoveTo(aX1, aY1);
  LineTo(aX2, aY2);
  StrokePath;
end;

procedure TgtPDPage.DrawPolygon(aCenterX, aCenterY, aSideLength: Double;
  aNumOfSides, aPenWidth: Integer; aPenColor, aFillColor: TColor;
  aOpacityStroke, aOpacityFill: Integer);
var
  LRadius: Double;
  LJ: Integer;
begin
  if not Assigned(FContents) then
    SetRenderMode(rmOverLay);
    {$IFDEF VCL6ORABOVE}
      LRadius := aSideLength / 2 * Cosecant(Pi / aNumOfSides);
    {$ENDIF}
    {$IFDEF DELPHI5}
      LRadius := aSideLength / 2 * Cosec(Pi / aNumOfSides);
    {$ENDIF}
  for LJ := 0 to aNumOfSides - 1 do
  begin
    if (LJ = 0) then
      MoveTo(aCenterX + LRadius * cos(PI / 2), aCenterY - LRadius * sin(PI / 2))
    else
    begin
      LineTo(aCenterX + LRadius * cos(PI / 2 + LJ * (2 * PI / aNumOfSides)),
        aCenterY - LRadius * sin(PI / 2 + LJ * (2 * PI / aNumOfSides)));
    end;
  end;
  LineTo(aCenterX + LRadius * Cos(PI / 2),
      aCenterY - LRadius * sin(PI / 2));
  SetPenWidth(aPenWidth);
  SetOpacity(aOpacityStroke, aOpacityFill);
  SetPenColor(
    GetRValue(aPenColor),
    GetGValue(aPenColor),
    GetBValue(aPenColor));
  SetBrushColor(
    GetRValue(aFillColor),
    GetGValue(aFillcolor),
    GetBValue(aFillcolor));
  SetEvenOddFillMode(True);
  if ((aPenColor <> Graphics.clNone) and (aFillColor <> Graphics.clNone)) then
      FillAndStrokePath
  else if ((aPenColor <> Graphics.clNone) and (aFillColor = Graphics.clNone)) then
      StrokePath
  else if ((aPenColor = Graphics.clNone) and (aFillColor <> Graphics.clNone)) then
      FillPath
  else
      StrokePath;
end;

procedure TgtPDPage.DrawPolygon(aCoordinates: array of TPDPoint;
  aNumOfSides, aPenWidth: Integer; aPenColor, aFillColor: TColor;
  aOpacityStroke, aOpacityFill: Integer);
var
  LRadius: Double;
  LJ: Integer;
begin
  if not Assigned(FContents) then
    SetRenderMode(rmOverLay);

  for LJ := 0 to aNumOfSides - 1 do
  begin
    if (LJ = 0) then
      MoveTo(aCoordinates[LJ].X, aCoordinates[LJ].Y)
    else
    begin
      LineTo(aCoordinates[LJ].X, aCoordinates[LJ].Y);
    end;
  end;
  LineTo(aCoordinates[0].X, aCoordinates[0].Y);
  SetPenWidth(aPenWidth);
  SetOpacity(aOpacityStroke, aOpacityFill);
  SetPenColor(
    GetRValue(aPenColor),
    GetGValue(aPenColor),
    GetBValue(aPenColor));
  SetBrushColor(
    GetRValue(aFillColor),
    GetGValue(aFillcolor),
    GetBValue(aFillcolor));
  SetEvenOddFillMode(True);
  if ((aPenColor <> Graphics.clNone) and (aFillColor <> Graphics.clNone)) then
      FillAndStrokePath
  else if ((aPenColor <> Graphics.clNone) and (aFillColor = Graphics.clNone)) then
      StrokePath
  else if ((aPenColor = Graphics.clNone) and (aFillColor <> Graphics.clNone)) then
      FillPath
  else
      StrokePath;
end;

procedure TgtPDPage.DrawRectangle(aX1, aY1, aX2, aY2: Double; aPen: TPen;
  aBrush: TBrush; aOpacityStroke, aOpacityFill: Integer);
begin
  if not Assigned(FContents) then
    SetRenderMode(rmOverLay);
  if Assigned(aPen) then
  begin
    SetPenColor(GetRValue(aPen.Color),
      GetGValue(aPen.Color),
      GetBValue(aPen.Color));
    SetPenWidth(aPen.Width);
    SetDashPattern(APen.Style, pjsNone, pcsNone);
  end;
  if Assigned(aBrush) then
  begin
    SetBrushColor(GetRValue(aBrush.Color),
      GetGValue(aBrush.Color),
      GetBValue(aBrush.Color));
    SetBrushStyle(aBrush);
  end;
  SetOpacity(aOpacityStroke, aOpacityFill);
  Rectangle(aX1, aY1, aX2, aY2);
  if Assigned(aPen) and Assigned(aBrush) and (aPen.Style <> psClear) and (aBrush.Style <> bsClear) then
    FillAndStrokePath
  else if Assigned(aPen) and (aPen.Style <> psClear) then
    StrokePath
  else if Assigned(aBrush) and (aBrush.Style <> bsClear) then
    FillPath;
end;


procedure TgtPDPage.DrawRoundRect(X1, Y1, X2, y2, X3, Y3: Double;
  aPen: TPen; aBrush: TBrush; aOpacityStroke, aOpacityFill: Integer);
var
  RoundRectLineWidth, RoundRectLineHeight: Extended;
	LPosX1, LPosY1, LPosX3, LPosY3: Extended;
  EllipseCtrlPts: TgtEllipseCtrlPoints;
begin
  if not Assigned(FContents) then
    SetRenderMode(rmOverLay);
  if Assigned(aPen) then
  begin
    SetPenColor(GetRValue(aPen.Color),
      GetGValue(aPen.Color),
      GetBValue(aPen.Color));
    SetPenWidth(aPen.Width);
    SetDashPattern(APen.Style, pjsNone, pcsNone);
  end;
  if Assigned(aBrush) then
  begin
    SetBrushColor(GetRValue(aBrush.Color),
      GetGValue(aBrush.Color),
      GetBValue(aBrush.Color));
    SetBrushStyle(aBrush);
  end;
  SetOpacity(aOpacityStroke, aOpacityFill);
  SetEvenOddFillMode(True);
  if (Abs(Y2 - Y1) < Y3) then
    Y3 := Abs(Y2 - Y1) + 1;
  if (Abs(X2 - X1) < X3) then
    X3 := Abs(X2 - X1) + 1;

  LPosX1 := X1;
  LPosY1 := GetNativeYPos(Y1);
  LPosX3 := X1 + X3;
  LPosY3 := GetNativeYPos(Y1+Y3);

  EllipseCtrlPts := GetEllipseCtrlPts(LPosX1, LPosY1, LPosX3, LPosY3);
  RoundRectLineWidth := X2 - X1 - X3;
  RoundRectLineHeight := Y2 - Y1 - Y3;

  with EllipseCtrlPts do
  begin
    MoveTo(X33,Y11,True);
    LineTo(X33+RoundRectLineWidth,Y11,True);
    CurveTo(X44+RoundRectLineWidth,Y11,
            X55+RoundRectLineWidth,Y22,
            X55+RoundRectLineWidth,Y33,True);
    LineTo(X55+RoundRectLineWidth,Y33-RoundRectLineHeight,True);
    CurveTo(X55+RoundRectLineWidth,Y44-RoundRectLineHeight,
            X44+RoundRectLineWidth,Y55-RoundRectLineHeight,
            X33+RoundRectLineWidth,Y55-RoundRectLineHeight,True);
    LineTo(X33,Y55-RoundRectLineHeight,True);
    CurveTo(X22,Y55-RoundRectLineHeight,
            X11,Y44-RoundRectLineHeight,
            X11,Y33-RoundRectLineHeight,True);
    LineTo(X11,Y33,True);
    CurveTo(X11,Y22,
            X22,Y11,
            X33,Y11,True);
  end;

  if Assigned(aPen) and Assigned(aBrush) and (aPen.Style <> psClear) and (aBrush.Style <> bsClear) then
    FillAndStrokePath
  else if Assigned(aPen) and (aPen.Style <> psClear) then
    StrokePath
  else if Assigned(aBrush) and (aBrush.Style <> bsClear) then
    FillPath
  else
    StrokePath;
end;

procedure TgtPDPage.DrawRectangle(aX1, aY1, aX2, aY2: Double;
  aPenWidth: Integer; aPenColor, aBrushColor: TColor; aOpacityStroke,
  aOpacityFill: Integer);
begin
  if not Assigned(FContents) then
    SetRenderMode(rmOverLay);
  SetPenColor(GetRValue(aPenColor),
      GetGValue(aPenColor),
      GetBValue(aPenColor));
  SetBrushColor(GetRValue(aBrushColor),
      GetGValue(aBrushColor),
      GetBValue(aBrushColor));
  SetOpacity(aOpacityStroke, aOpacityFill);
  SetPenWidth(aPenWidth);
  Rectangle(aX1, aY1, aX2, aY2);
  FillAndStrokePath;
end;

function TgtPDPage.DuplicateObject(Source: TgtPDBaseObject): TgtPDBaseObject;
var
  I, cvnt: Integer;
  LObj, LObj2: TgtPDBaseObject;
  LKey, LKey2: AnsiString;
  LResult: TgtPDBaseObject;
begin
  cvnt := 0;
  Result := nil;
  LObj2 := nil;
  LKey2 := '';
  case Source.GetType of
    otNull:
      begin
        if Source.ObjNumber <> MAXOBJNUM then
        begin
          TgtPDDocument(ParentDoc).BaseDoc.Reader.XRef.LastObjectNumber :=
            TgtPDDocument(ParentDoc).BaseDoc.Reader.XRef.LastObjectNumber + 1;

          Result := TgtPDNull.Create(TgtPDDocument(ParentDoc).LastObjectNumber, 0);

          TgtPDDocument(FParentDoc).BaseDoc.AddToCollection(Result);
        end
        else
          Result := TgtPDNull.Create(MAXOBJNUM, MAXGENNUM);
      end;
    otBoolean:
      begin
        if Source.ObjNumber <> MAXOBJNUM then
        begin
          TgtPDDocument(ParentDoc).BaseDoc.Reader.XRef.LastObjectNumber :=
            TgtPDDocument(ParentDoc).BaseDoc.Reader.XRef.LastObjectNumber + 1;

          Result := TgtPDBoolean.Create(TgtPDBoolean(Source).Value,
            TgtPDDocument(ParentDoc).LastObjectNumber, 0);

          TgtPDDocument(FParentDoc).BaseDoc.AddToCollection(Result);
        end
        else
          Result := TgtPDBoolean.Create(TgtPDBoolean(Source).Value, MAXOBJNUM,
            MAXGENNUM);
      end;
    otInteger:
      begin
        if Source.ObjNumber <> MAXOBJNUM then
        begin
          TgtPDDocument(ParentDoc).BaseDoc.Reader.XRef.LastObjectNumber :=
            TgtPDDocument(ParentDoc).BaseDoc.Reader.XRef.LastObjectNumber + 1;

          Result := TgtPDInteger.Create(TgtPDInteger(Source).Value,
            TgtPDDocument(ParentDoc).LastObjectNumber, 0);

          TgtPDDocument(FParentDoc).BaseDoc.AddToCollection(Result);
        end
        else
          Result := TgtPDInteger.Create(TgtPDInteger(Source).Value, MAXOBJNUM,
            MAXGENNUM);
      end;
    otReal:
      begin
        if Source.ObjNumber <> MAXOBJNUM then
        begin
          TgtPDDocument(ParentDoc).BaseDoc.Reader.XRef.LastObjectNumber :=
            TgtPDDocument(ParentDoc).BaseDoc.Reader.XRef.LastObjectNumber + 1;

          Result := TgtPDReal.Create(TgtPDReal(Source).Value,
            TgtPDDocument(ParentDoc).LastObjectNumber, 0);

          TgtPDDocument(FParentDoc).BaseDoc.AddToCollection(Result);
        end
        else
          Result := TgtPDReal.Create(TgtPDReal(Source).Value, MAXOBJNUM, MAXGENNUM);
      end;
    otString:
      begin
        if Source.ObjNumber <> MAXOBJNUM then
        begin
          TgtPDDocument(ParentDoc).BaseDoc.Reader.XRef.LastObjectNumber :=
            TgtPDDocument(ParentDoc).BaseDoc.Reader.XRef.LastObjectNumber + 1;

          Result := TgtPDString.Create(TgtPDString(Source).Value,
            TgtPDDocument(ParentDoc).LastObjectNumber, 0, TgtPDString(Source).IsHexString);

          TgtPDDocument(FParentDoc).BaseDoc.AddToCollection(Result);
        end
        else
          Result := TgtPDString.Create(TgtPDString(Source).Value, MAXOBJNUM,
            MAXGENNUM, TgtPDString(Source).IsHexString);
      end;
    otName:
      begin
        if Source.ObjNumber <> MAXOBJNUM then
        begin
          TgtPDDocument(ParentDoc).BaseDoc.Reader.XRef.LastObjectNumber :=
            TgtPDDocument(ParentDoc).BaseDoc.Reader.XRef.LastObjectNumber + 1;

          Result := TgtPDName.Create(TgtPDName(Source).Value,
            TgtPDDocument(ParentDoc).LastObjectNumber, 0);

          TgtPDDocument(FParentDoc).BaseDoc.AddToCollection(Result);
        end
        else
          Result := TgtPDName.Create(TgtPDName(Source).Value, MAXOBJNUM, MAXGENNUM);
      end;
    otArray:
      begin
        if TgtPDArray(Source).GetLength < 1 then
          Exit;

        if Source.ObjNumber <> MAXOBJNUM then
        begin
          TgtPDDocument(ParentDoc).BaseDoc.Reader.XRef.LastObjectNumber :=
            TgtPDDocument(ParentDoc).BaseDoc.Reader.XRef.LastObjectNumber + 1;

          LResult := TgtPDArray.Create(TgtPDDocument(ParentDoc).BaseDoc,
            TgtPDDocument(ParentDoc).BaseDoc.Reader.XRef.LastObjectNumber, 0);

          TgtPDDocument(FParentDoc).BaseDoc.AddToCollection(LResult);
        end
        else
        begin
          LResult := TgtPDArray.Create(TgtPDDocument(ParentDoc).BaseDoc,
            MAXOBJNUM, MAXGENNUM);
        end;

        for I := 0 to TgtPDArray(Source).GetLength - 1 do
        begin
          cvnt := TgtPDArray(Source).GetLength;
          LObj := DuplicateObject(TgtPDArray(Source).Get(I));
          TgtPDArray(LResult).Add(LObj);
        end;

        if Source.ObjNumber <> MAXOBJNUM then
          Result := TgtPDIndirectRef.Create(LResult.ObjNumber, LResult.GenNumber)
        else
          Result := LResult;
      end;
    otDict:
      begin
        if Source.IsDict(PDF_PAGES) then
          Exit;
        if TgtPDDictionary(Source).GetLength < 1 then
          Exit;
        if Source.ObjNumber <> MAXOBJNUM then
        begin
          TgtPDDocument(ParentDoc).BaseDoc.Reader.XRef.LastObjectNumber :=
            TgtPDDocument(ParentDoc).BaseDoc.Reader.XRef.LastObjectNumber + 1;

          LResult := TgtPDDictionary.Create(
            TgtPDDocument(ParentDoc).BaseDoc.Reader.XRef.LastObjectNumber, 0,
            TgtPDDocument(ParentDoc).BaseDoc);

          TgtPDDocument(ParentDoc).BaseDoc.AddToCollection(LResult);
        end
        else
        begin
          LResult := TgtPDDictionary.Create(MAXOBJNUM, MAXGENNUM,
            TgtPDDocument(ParentDoc).BaseDoc);
        end;

        LObj2 := TgtPDDictionary(Source).LookUp(PDF_TYPE);
        if Assigned(LObj2) then
          LKey2 := TgtPDName(LObj2).Value;
        if LKey2 = PDF_PAGE then
          TgtPDDictionary(Source).Remove(PDF_B);

        TgtPDDictionary(Source).Remove(PDF_P);
        TgtPDDictionary(Source).Remove(PDF_PARENT);

        for I := 0 to TgtPDDictionary(Source).GetLength - 1 do
        begin
          LKey := TgtPDDictionary(Source).GetKey(I);
          
          if (LKey <> PDF_DEST) then
          begin
            LObj := DuplicateObject(TgtPDDictionary(Source).GetValue(I));
            if TgtPDDictionary(Source).GetValueRefObj(I).IsIndirectRef then
              TgtPDDictionary(LResult).Add(LKey,
                TgtPDIndirectRef.Create(LObj.ObjNumber, LObj.GenNumber))
            else if Assigned(LObj) then
              TgtPDDictionary(LResult).Add(LKey, LObj);
          end;
        end;
        if Source.ObjNumber <> MAXOBJNUM then
          Result := TgtPDIndirectRef.Create(LResult.ObjNumber, LResult.GenNumber)
        else
          Result := LResult;
      end;
    otStream:
      begin
        LObj := DuplicateObject(TgtPDStream(Source).GetDict);
        TgtPDStream(Source).GetStream.IncRef;
        TgtPDDocument(ParentDoc).BaseDoc.Reader.XRef.LastObjectNumber :=
          TgtPDDocument(ParentDoc).BaseDoc.Reader.XRef.LastObjectNumber + 1;
        LResult := TgtPDStream.Create(TgtPDStream(Source).GetStream, LObj,
          TgtPDDocument(ParentDoc).BaseDoc.Reader.XRef.LastObjectNumber, 0);

        TgtPDDocument(ParentDoc).BaseDoc.AddToCollection(LResult);
        Result := TgtPDIndirectRef.Create(LResult.ObjNumber, LResult.GenNumber);
      end;
    otIndirectRef:
      begin

      end;
  end;
end;

procedure TgtPDPage.EndPath;
begin
  FCurrentCS.EndPath;
  UpdatePDStreamLength;
end;

procedure TgtPDPage.EnumColorSpaceResources(
  ColorSpaceEnumEvent: TgtPDEnumColorSpaceEvent);
begin

end;

procedure TgtPDPage.EnumFontResources(FontEnumEvent: TgtPDEnumFontEvent);
begin

end;

procedure TgtPDPage.EnumProcSetResources(
  ProcSetEnumEvent: TgtPDEnumProcSetEvent);
begin

end;

procedure TgtPDPage.EnumXObjectResources(
  XObjectEnumEvent: TgtPDEnumXObjectEvent);
begin

end;

procedure TgtPDPage.FillAndStrokePath;
begin
  FCurrentCS.FillAndStrokePath;
  UpdatePDStreamLength;
end;

procedure TgtPDPage.FillPath;
begin
  FCurrentCS.FillPath;
  UpdatePDStreamLength;
end;

function TgtPDPage.FindInAcroForms(ObjNumber: Cardinal): AnsiString;
var
  LAcroForms, LAcroFormFields: TgtPDBaseObject;
  LObj1, LObj2, LKids: TgtPDBaseObject;
  I: Integer;
  J: Integer;
begin
  Result := '';
  LAcroForms := TgtPDCatalog(TgtPDDocument(ParentDoc).Catalog).AcroFormField;
  if Assigned(LAcroForms) and LAcroForms.IsDict then
  begin
    LAcroFormFields := TgtPDDictionary(LAcroForms).LookUp(PDF_FIELDS);
    if Assigned(LAcroFormFields) and LAcroFormFields.IsArray then
    begin
      for I := 0 to TgtPDArray(LAcroFormFields).GetLength - 1 do
      begin
        LObj1 := TgtPDArray(LAcroFormFields).Get(I);
        if Assigned(LObj1) and LObj1.IsDict then
        begin
          if LObj1.ObjNumber = ObjNumber then
          begin
            LObj2 := TgtPDDictionary(LObj1).LookUp(PDF_V);
            if Assigned(LObj2) and (LObj2.IsString or LObj2.IsName) then
              if LObj2.IsString then
                Result := TgtPDString(LObj2).Value
              else
                Result := TgtPDName(LObj2).Value;
            Exit;
          end
          else
          begin
           LKids := TgtPDDictionary(LObj1).LookUp(PDF_KIDS);
           if Assigned(LKids) and LKids.IsArray then
           begin
             for J := 0 to TgtPDArray(LKids).GetLength - 1 do
             begin
              LObj2 := TgtPDArray(LKids).Get(J);
              if LObj2.ObjNumber = ObjNumber then
              begin
                LObj2 := TgtPDDictionary(LObj1).LookUp(PDF_V);
                if Assigned(LObj2) and (LObj2.IsString or LObj2.IsName) then
                  if LObj2.IsString then
                    Result := TgtPDString(LObj2).Value
                  else
                    Result := TgtPDName(LObj2).Value;
                Exit;
              end;
             end;
           end;
          end;
        end;
      end;
    end;
  end;

end;

function TgtPDPage.FitTextToHeight(AList: TStringList; AFont: TgtFont;
  AHeight: Integer; ALineSpace: Integer; AUpdatedList: TStringList): Boolean;
var
  LHeight: Double;
  I: Integer;
  LFontProcObj: TgtFontProcessor;
  LErrCode: ErrorCodes;
  LFont: TFont;
begin
  Result := False;
  LHeight := 0;
  LFont := TFont.Create;
  LFont.Name := AFont.Name;
  LFont.Size := AFont.Size;
  LFont.Style := AFont.Style;
  LFont.Color := AFont.Color;
  LFontProcObj := TgtFontProcessor.Create(LFont, LErrCode);
  for I := 0 to AList.Count - 1 do
  begin
    LHeight := LHeight + LFontProcObj.GetTextHeight(AList[I]);
  end;
  LHeight := LHeight + ALineSpace * (AList.Count - 1);
  if LHeight > AHeight then
    AFont.Size := AFont.Size - 2
  else
    Result := True;
end;

function TgtPDPage.FitTextToWidth(AList: TStringList; AFont: TgtFont;
   AWidth: Integer; AUpdatedList: TStringList): Boolean;
var
  LFontProcObj: TgtFontProcessor;
  LErrCode: ErrorCodes;
  LWidth: Double;
  I, J: Integer;
  LList: TStringList;
  LFont: TFont;
  {$IFDEF DELPHI5}
  procedure SplitTextIntoWords(const S: Ansistring; words: TstringList);
  var
    startpos, endpos: Integer;
  begin
    Assert(Assigned(words));
    words.Clear;
    startpos := 1;
    while startpos <= Length(S) do
    begin
      while (startpos <= Length(S)) and not IsCharAlpha(S[startpos]) do
        Inc(startpos);
      if startpos <= Length(S) then
      begin
        endpos := startpos + 1;
        while (endpos <= Length(S)) and IsCharAlpha(S[endpos]) do
          Inc(endpos);
        words.Add(Copy(S, startpos, endpos - startpos));
        startpos := endpos + 1;
      end; { If }
    end; { While }
  end; { SplitTextIntoWords }
  {$ENDIF}
begin
  Result := True;
  LFont := TFont.Create;
  LFont.Name := AFont.Name;
  LFont.Size := AFont.Size;
  LFont.Style := AFont.Style;
  LFont.Color := AFont.Color;
  LFontProcObj := TgtFontProcessor.Create(LFont, LErrCode);
  LList := TStringList.Create;
  {$IFDEF VCL6ORABOVE}
    LList.Delimiter := ' ';
  {$ENDIF}
  for I := 0 to AList.Count - 1 do
  begin
    LWidth := Round(72/96 * LFontProcObj.GetTextWidth(AList[I]));
    if LWidth > AWidth then
    begin
      // Split the line, take the last word to next line
      Result := False;
      AUpdatedList.Add('');
      LList.Clear;
      {$IFDEF VCL6ORABOVE}
        LList.DelimitedText := AList[I];
      {$ENDIF}
      {$IFDEF DELPHI5}
        SplitTextIntoWords(AList[I], LList);
      {$ENDIF}
      for J := 0 to LList.Count - 2 do
      begin
        AUpdatedList[AUpdatedList.Count - 1] :=
          AUpdatedList[AUpdatedList.Count - 1] + ' ' + LList[J];
      end;
      // Move the last word to next line
      AUpdatedList[AUpdatedList.Count - 1] :=
        Trim(AUpdatedList[AUpdatedList.Count - 1]);
      AUpdatedList.Add(LList[LList.Count - 1]);
    end
    else
      AUpdatedList.Add(AList[I]);
  end;
    LList.Free;
  LFont.Free;
  LFontProcObj.Free;
end;

procedure TgtPDPage.FreeAnnotList;
var
  LI: Integer;
begin
  if Assigned(FAnnotList) then
  begin
    for LI := 0 to FAnnotList.Count - 1 do
    begin
      if not (FAnnotList.Items[LI] is TgtPDFormField) then
        TgtPDAnnot(FAnnotList.Items[LI]).Free;
    end;
    FreeObject(FAnnotList);
  end;
end;

procedure TgtPDPage.FreeResources;
var
  LI: Integer;
begin
  //Free the annotations
  FreeAnnotList;
  if Assigned(FAdditionalAction) then FreeObject(FAdditionalAction);
  if Assigned(FContents) then FreeObject(FContents);
  if Assigned(FMediaBox) then FreeObject(FMediaBox);
  if Assigned(FCropBox) then FreeObject(FCropBox);
  if Assigned(FResource) then FreeObject(FResource);
  if Assigned(FInheritedProp) then FreeObject(FInheritedProp);
  if Assigned(FBleedBox) then FreeObject(FBleedBox);
  if Assigned(FTrimBox) then FreeObject(FTrimBox);
  if Assigned(LMemStream) then FreeObject(LMemStream);
end;

function TgtPDPage.GetActions: TgtPDAction;
var
  LActionObj: TgtPDBaseObject;
begin
  if not Assigned(FAdditionalAction) then
  begin
    LActionObj := TgtPDDictionary(FBaseObject).LookUp(PDF_AA);
    if Assigned(LActionObj) then
    begin
      FAdditionalAction := TgtPDAction.MakeAction(FParentDoc, Self, LActionObj);
    end;
  end;

  Result := FAdditionalAction;
end;

function TgtPDPage.GetAnnots: TgtPDAnnotList;
var
  LAnnotsObj, LObj: TgtPDBaseObject;
  LI: Integer;
  LAnnot: TgtPDAnnot;
  LJ: Integer;
  LHasFound: boolean;
begin
  LHasFound := False;
  if not Assigned(FAnnotList) then
  begin
    LAnnotsObj := TgtPDDictionary(FBaseObject).LookUp(PDF_ANNOTS);
    if Assigned(LAnnotsObj) then
    begin
      FAnnotList := TObjectList.Create(False);
      if LAnnotsObj.IsArray then
      begin
        for LI := 0 to TgtPDArray(LAnnotsObj).GetLength - 1 do
        begin
          LObj := TgtPDArray(LAnnotsObj).Get(LI);
          LAnnot := TgtPDAnnot.MakeAnnot(FParentDoc, Self, LObj);
          if Assigned(LAnnot) then
          begin
            for LJ := 0 to FAnnotList.Count - 1 do
            begin
              if (TgtPDAnnot(FAnnotList.Items[LJ]).BaseObject.ObjNumber) = (LAnnot.BaseObject.ObjNumber) then
              begin
                LHasFound := True;
                Break;
              end;
            end;
            if not LHasFound then
              FAnnotList.Add(LAnnot);
            LHasFound := False;
          end;
        end;
      end;
    end;
  end;
  Result := FAnnotList;
end;

function TgtPDPage.GetAttachment(Index: Integer): TgtPDFileAttachmentAnnot;
begin
  Result := nil;
  if (AttachmentCount <> 0) and (Index < AttachmentCount) then
  begin
    Result := FAttachmentList.Items[Index] as TgtPDFileAttachmentAnnot;
  end;  
end;

function TgtPDPage.GetAttachmentCount: Integer;
var
  LAnnotList: TgtPDAnnotList;
  LI: Integer;
begin
  Result := 0;
  LAnnotList := GetAnnots;
  if Assigned(LAnnotList) then
  begin
    if (LAnnotList.Count <> 0) then
    begin
      for LI := 0 to LAnnotList.Count - 1 do
      begin
        if LAnnotList.Items[LI] is TgtPDFileAttachmentAnnot then
        begin
          if not Assigned(FAttachmentList) then
            FAttachmentList := TgtPDAnnotList.Create(False);
          FAttachmentList.Add(LAnnotList.Items[LI]);
          Inc(Result);
        end;
      end;
    end;
  end;
end;

(**
   *
   * Gets BleedBox from the baseobject
   *
   * @return BleedBox of type TgtPDRect
   *
   * @exception EBadPage if any error while parsing the page
   *
   * Algorithm
   *  1. If FBleedBox is not assigned then
   *      a. Look up for ‘BleedBox’ in FBaseObject by typecasting FBaseObject
   *         to TgtPDDictionary and call lookup function with ‘BleedBox’ as parameter.
   *      b. If obtained object is nill then
   *          o	Create a TgtPDRect object and assign to FBleedBox
   *        Else
   *          o	If obtained object is Array object then
   *             . Create a TgtPDRect object with obtained Array object and
   *                assign to FBleedBox
   *  2. Return FBleedBox
   *)

function TgtPDPage.GetBleedBox: TgtPDRect;
var
  LObj: TgtPDBaseObject;
begin
  if not Assigned(FBleedBox) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_BLEEDBOX);
    if Assigned(LObj) then
    begin
      if LObj.IsArray then
        FBleedBox := TgtPDRect.Create(TgtPDArray(LObj))
      else
      begin
        raise EXBadPage.Create(ErrPage);
{$IFDEF DEBUG}
        Logger.LogError('Page: Array object Expected');
{$ENDIF}
      end;
    end
    else
      FBleedBox := TgtPDRect.Create;
  end;
  Result := FBleedBox;
end;

(**
   *
   * Gets Contents from the baseobject
   *
   * @return Contents of type TgtPDContents
   *
   * Algorithm
   *  1. Start
   *  2. If FContents is not assigned then
   *      a. Look up for ‘Contents’ in FBaseObject by typecasting FBaseObject
   *         to TgtPDDictionary and call lookup function with ‘Comntents’ as parameter.
   *      b. If obtained object is not nill then
   *          o	Create a TgtPDContents object and assign to FContents
   *  3. Return FContents
   *  4. End
   *)

function TgtPDPage.GetCheckBoxFormStream(AWidth, AHeight: Double;
  AFontTag: AnsiString; AI: Integer;
  AFormField: TgtPDFormCheckBox): TMemoryStream;
var
  LCh: AnsiChar;
  LStr: AnsiString;
begin
//  Result := nil;
  LCh := '4';
//  case AFormField.FSymbol of
//    pfcsCheck: LCh := '4';
//    pfcsCircle: LCh := 'l';
//    pfcsCross: LCh := '8';
//    pfcsDiamond: LCh := 'u';
//    pfcsSquare: LCh := 'n';
//    pfcsStar: LCh := 'H';
//    else LCh := '4'
//  end;
  if (AI = 0) then
  begin
    LStr := FloatToStringLocale(AFormField.BackgroundColor.Value[0]) + ' ' +
      FloatToStringLocale(AFormField.BackgroundColor.Value[1]) + ' ' +
      FloatToStringLocale(AFormField.BackgroundColor.Value[2]) +
      ' rg 0 w 0.6 0.6 ' + FloatToStringLocale(AWidth - 2) + ' ' +
      FloatToStringLocale(AHeight - 2) + ' re f ' +
      FloatToStringLocale(AFormField.BorderColor.Value[0]) + ' ' +
      FloatToStringLocale(AFormField.BorderColor.Value[1]) + ' ' +
      FloatToStringLocale(AFormField.BorderColor.Value[2]) +
      ' RG 1 w 0.5 0.5 ' + FloatToStringLocale(AWidth - 1) + ' ' +
      FloatToStringLocale(AHeight - 1) + ' re s q 1 1 ' + FloatToStringLocale(AWidth - 2) + ' '
      + FloatToStringLocale(AHeight - 2) + ' re W n BT /' + AFontTag + ' ' +
      IntToStr(AFormField.Font.Size) + ' Tf ' +
      ColorToPDFColor(GetRValue(ColorToRGB(AFormField.Font.Color)),
      GetGValue(ColorToRGB(AFormField.Font.Color)),
      GetBValue(ColorToRGB(AFormField.Font.Color))) +
      ' rg ' + ' 1 0 0 1 0.77 1.405 Tm (' + LCh + ') Tj ET Q';
  end
  else if (AI = 1) then
  begin
    LStr := FloatToStringLocale(AFormField.BackgroundColor.Value[0]) + ' ' +
      FloatToStringLocale(AFormField.BackgroundColor.Value[1]) + ' ' +
      FloatToStringLocale(AFormField.BackgroundColor.Value[2]) +
      ' rg 0 w 0.6 0.6 ' + FloatToStringLocale(AWidth - 2) + ' ' +
      FloatToStringLocale(AHeight - 2) + ' re f ' +
      FloatToStringLocale(AFormField.BorderColor.Value[0]) + ' ' +
      FloatToStringLocale(AFormField.BorderColor.Value[1]) + ' ' +
      FloatToStringLocale(AFormField.BorderColor.Value[2]) +
      ' RG 1 w 0.5 0.5 ' + FloatToStringLocale(AWidth - 1) + ' ' +
      FloatToStringLocale(AHeight - 1) + ' re s';
  end;
  Result := TMemoryStream.Create;
  Result.Write(Pointer(LStr)^, Length(LStr));
end;

function TgtPDPage.GetComboBoxFormStream(AWidth, AHeight: Double;
  AFontTag: AnsiString; AFormField: TgtPDFormComboBox): TMemoryStream;
var
  LStr: AnsiString;
begin
  LStr := FloatToStringLocale(AFormField.BackgroundColor.Value[0]) + ' ' +
    FloatToStringLocale(AFormField.BackgroundColor.Value[1]) + ' ' +
    FloatToStringLocale(AFormField.BackgroundColor.Value[2]) +
    ' rg 0 0 ' + FloatToStringLocale(AWidth) + ' ' + FloatToStringLocale(AHeight) + ' re f ' +
    FloatToStringLocale(AFormField.BorderColor.Value[0]) + ' ' +
    FloatToStringLocale(AFormField.BorderColor.Value[1]) + ' ' +
    FloatToStringLocale(AFormField.BorderColor.Value[2]) +
    ' RG 1 w 0.5 0.5 ' + FloatToStringLocale(AWidth - 1) + ' ' +
    FloatToStringLocale(AHeight - 1) + ' re s 0.502 g 1 1 m 1 ' +
    FloatToStringLocale(AHeight - 1) + ' l ' + FloatToStringLocale(AWidth - 1) + ' ' +
    FloatToStringLocale(AHeight - 1) + ' l ' + FloatToStringLocale(AWidth - 2) + ' ' +
    FloatToStringLocale(AHeight - 2) + ' l 2 ' + FloatToStringLocale(AHeight - 2) +
    ' l 2 2 l f 0.7529 g ' + FloatToStringLocale(AWidth - 1) + ' ' +
    FloatToStringLocale(AHeight - 1) + ' m ' + FloatToStringLocale(AWidth - 1) +
    ' 1 l 1 1 l 2 2 l ' + FloatToStringLocale(AWidth - 2) + ' 2 l ' +
    FloatToStringLocale(AWidth - 2) + ' ' + FloatToStringLocale(AHeight - 2) +
    ' l f /Tx BMC q 2 2 ' + FloatToStringLocale(AWidth - 4) + ' ' +
    FloatToStringLocale(AHeight - 4) + ' re W n BT /' + AFontTag + ' ' +
    IntToStr(Round((72 / 96) * (AFormField.Font.Size))) + ' Tf ' +
    ColorToPDFColor(GetRValue(ColorToRGB(AFormField.Font.Color)),
    GetGValue(ColorToRGB(AFormField.Font.Color)),
    GetBValue(ColorToRGB(AFormField.Font.Color))) + ' rg ' +
    ' 1 0 0 1 4 4.59 Tm (' + AFormField.Value + ') Tj ET Q EMC';
  Result := TMemoryStream.Create;
  Result.Write(Pointer(LStr)^, Length(LStr));
end;

function TgtPDPage.GetContents: TgtPDContents;
var
  LContentsObj: TgtPDBaseObject;
begin
  if not Assigned(FContents) then
  begin
    LContentsObj := TgtPDDictionary(FBaseObject).LookUp(PDF_CONTENTS);
    if Assigned(LContentsObj) then
    begin
      FContents := TgtPDContents.Create(FParentDoc, Self, LContentsObj);
    end;
  end;
  Result := FContents;
end;

  (**
   *
   * Gets CropBox from the baseobject
   *
   * @return CropBox of type TgtPDRect
   *
   * @exception EBadPage if any error while parsing the page
   *
   * Algorithm
   *  1. If FCropBox is not assigned then
   *      a. Look up for ‘CropBox’ in FBaseObject by typecasting FBaseObject
   *         to TgtPDDictionary and call lookup function with ‘CropBox’ as parameter.
   *      b. If obtained object is nill then
   *          o	Create a TgtPDRect object and assign to FCropBox
   *        Else
   *          o	If obtained object is Array object then
   *             . Create a TgtPDRect object with obtained Array object and
   *                assign to FCropBox
   *  2. Return FCropBox
   *)

function TgtPDPage.GetCropBox: TgtPDRect;
var
  LObj: TgtPDBaseObject;
begin
  Result := nil;
  if not Assigned(FCropBox) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_CROPBOX);
    if Assigned(LObj) then
    begin
      if LObj.IsArray then
        FCropBox := TgtPDRect.Create(TgtPDArray(LObj))
      else
      begin
        raise EXBadPage.Create(ErrPage);
{$IFDEF DEBUG}
        Logger.LogError('Page: Array object Expected');
{$ENDIF}
      end;
    end
    else
    begin
      if Assigned(FInheritedProp) then
      begin
        Result := FInheritedProp.GetCropBox;
        FIsInheritedCropBox := True;
      end;
      Exit;
    end;
  end;
  Result := FCropBox;
end;

procedure TgtPDPage.GetDefaultCTM(Matix: TgtPDMatrix; hDPI, vDPI: Double;
  Rotate: Integer; uSeMediaBox, UpsideDown: Boolean);
begin

end;

 (**
   *
   * Gets Duration from the baseobject
   *
   * @return value of Duration of type Integer
   *
   * @exception EBadPage if any error while parsing the page
   *
   * Algorithm
   *   1. If FDuration (of type TgtPDInteger) is not assigned then
   *      o. Look up for ‘Duration’ in FBaseObject  by typecasting FBaseObject
   *        to TgtPDDictionary and call lookup function with ‘Duration’ as parameter.
   *      o. If obtained object is nill then
   *         .	Create a TgtPDInteger object and assign to FDuration
   *      o. Else if it is Integer object then assign to FDuration
   *   2. Return the value of FDuration
   *)

function TgtPDPage.GetDuration: Integer;
var
  LObj: TgtPDBaseObject;
begin
  if not Assigned(FDuration) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_DUR);
    if Assigned(LObj) then
    begin
      if LObj.IsInteger then
        FDuration := TgtPDInteger(LObj)
      else
      begin
        raise EXBadPage.Create(ErrPage);
{$IFDEF DEBUG}
        Logger.LogError('Page: Integer object Expected');
{$ENDIF}
      end;
    end
    else
      FDuration := nil;
  end;
  if Assigned(FDuration) then
    Result := TgtPDInteger(FDuration).Value
  else
    Result := 0;
end;

function TgtPDPage.GetEllipseCtrlPts(PosX1, PosY1, PosX2,
  PosY2: Double): TgtEllipseCtrlPoints;
var
	cpFactor: Double;
begin
  	// cpFactor := 4/3 * (1-cos 45°)/sin 45° := 4/3 * sqrt(2) - 1
	cpFactor := (4.0 / 3.0) * (Sqrt(2) - 1.0);

	with Result do
	begin
		if PosX1 < PosX2 then
			X11 := PosX1
		else
			X11 := PosX2;
		if PosX1 > PosX2 then
			X55 := PosX1
		else
			X55 := PosX2;
		X33 := (PosX1 + PosX2) / 2.0;
		X22 := X33 - cpFactor * (X33 - X11);
		X44 := X33 + cpFactor * (X33 - X11);

		if PosY1 < PosY2 then
			Y55 := PosY1
		else
			Y55 := PosY2;
		if PosY1 > PosY2 then
			Y11 := PosY1
		else
			Y11 := PosY2;
		Y33 := (PosY1 + PosY2) / 2.0;
		Y22 := Y33 - cpFactor * (Y33 - Y11);
		Y44 := Y33 + cpFactor * (Y33 - Y11);
	end;
end;

function TgtPDPage.GetFontObject(AParentDoc: TgtObject;
  AParentElt: TgtPDElement; AgtFont: TgtFont): TgtPDFont;
var
//  LI: Integer;
  LFontObj: TgtPD8bitFont;
//  LgtPDFont: TgtPDFont;
begin
  Result := nil;
  //create a new TgtPDFont obj
  LFontObj := TgtPD8bitFont.Create(AParentDoc, AParentElt, AgtFont);

  //searching for existing font dict
//  for LI := 1 to TgtPDDocument(FParentDoc).PageCount do
//  begin
//    if Assigned(TgtPDDocument(FParentDoc).Pages[LI].Resource) then
//    begin
//      //get gtPDFont by its PSName
//      LgtPDFont := TgtPDDocument(FParentDoc).Pages[LI].Resource.
//        GetFontByName(LFontObj.Name);
//      //if found, return TgtPDFont obj and free the LFontObj
//      if Assigned(LgtPDFont) then
//      begin
//        Result := LgtPDFont;
//        FreeAndNil(LFontObj);
//        Exit;
//      end;
//    end;
//  end;

  //if not found, get a res tag for new LFontObj
  if ((LFontObj.Tag = '') and Assigned(Resource)) then
  begin
    LFontObj.Tag := Resource.GetResourceName(resFont);
    Resource.AddFont(LFontObj);
    LFontObj.CreateFontDict;
    AddResource(resFont, LFontObj.Tag, LFontObj.BaseObject);
    Result := LFontObj;
  end;
end;

function TgtPDPage.GetFormField(AFieldName: AnsiString): TgtPDFormField;
var
  LFormField: TgtPDFormField;
  LI, LFormFieldCount: Integer;
begin
  Result := nil;
  LFormFieldCount := GetFormFieldCount;
  for LI := 1 to LFormFieldCount do
  begin
    LFormField := GetFormField(LI);
    if LFormField.FieldName = AFieldName then
    begin
      Result := LFormField;
      Exit;
    end;
  end;
end;

function TgtPDPage.GetFormFieldCount: Integer;
var
  LI: Integer;
begin
//  FFormFieldCount := 0;
  GetAnnots;
  if (FFormFieldCount = 0) then
  begin
    if Assigned(FAnnotList) then
    begin
      for LI := 0 to FAnnotList.Count - 1 do
      begin
        if FAnnotList.Items[LI] is TgtPDFormField then
        begin
          Inc(FFormFieldCount);
        end;
      end;
    end;
  end;
  Result := FFormFieldCount;
end;

function TgtPDPage.GetListBoxFormStream(AWidth, AHeight: Double;
  AFontTag: AnsiString; AFormField: TgtPDFormListBox): TMemoryStream;
var
  LStr: AnsiString;
begin
  LStr := FloatToStringLocale(AFormField.BackgroundColor.Value[0]) + ' ' +
    FloatToStringLocale(AFormField.BackgroundColor.Value[1]) + ' ' +
    FloatToStringLocale(AFormField.BackgroundColor.Value[2]) +
    ' rg 0 0 ' + FloatToStringLocale(AWidth) + ' ' + FloatToStringLocale(AHeight) + ' re f ' +
    FloatToStringLocale(AFormField.BorderColor.Value[0]) + ' ' +
    FloatToStringLocale(AFormField.BorderColor.Value[1]) + ' ' +
    FloatToStringLocale(AFormField.BorderColor.Value[2]) +
    ' RG 1 w 0.5 0.5 ' + FloatToStringLocale(AWidth - 1) + ' ' +
    FloatToStringLocale(AHeight - 1) + ' re s 0.502 g 1 1 m 1 ' +
    FloatToStringLocale(AHeight - 1) + ' l ' + FloatToStringLocale(AWidth - 1) + ' ' +
    FloatToStringLocale(AHeight - 1) + ' l ' + FloatToStringLocale(AWidth - 2) + ' ' +
    FloatToStringLocale(AHeight - 2) + ' l 2 ' + FloatToStringLocale(AHeight - 2) +
    ' l 2 2 l f 0.7529 g ' + FloatToStringLocale(AWidth - 1) + ' ' +
    FloatToStringLocale(AHeight - 1) + ' m ' + FloatToStringLocale(AWidth - 1) +
    ' 1 l 1 1 l 2 2 l ' + FloatToStringLocale(AWidth - 2) + ' 2 l ' +
    FloatToStringLocale(AWidth - 2) + ' ' + FloatToStringLocale(AHeight - 2) +
    ' l f /Tx BMC q 2 2 ' + FloatToStringLocale(AWidth - 4) + ' ' +
    FloatToStringLocale(AHeight - 4) + ' re W n BT /' + AFontTag + ' ' +
    IntToStr(Round((72 / 96) * (AFormField.Font.Size))) + ' Tf ' +
    ColorToPDFColor(GetRValue(ColorToRGB(AFormField.Font.Color)),
    GetGValue(ColorToRGB(AFormField.Font.Color)),
    GetBValue(ColorToRGB(AFormField.Font.Color))) +
    ' rg ' + ' 1 0 0 1 4 4.59 Tm (' + AFormField.Value + ') Tj ET Q EMC';
  Result := TMemoryStream.Create;
  Result.Write(Pointer(LStr)^, Length(LStr));
end;

function TgtPDPage.GetFormField(Index: Integer): TgtPDFormField;
var
  LI: Integer;
  LIndex: Integer;
//  LListIndex: Integer;
begin
  LIndex := 1;
//  LListIndex := 0;
  GetAnnots;
  if Assigned(FAnnotList) then
  begin
    for LI := 0 to FAnnotList.Count - 1 do
    begin
      if (FAnnotList.Items[LI] is TgtPDFormField) then
      begin
        if LIndex = Index then
        begin
          Result := TgtPDFormField(FAnnotList.Items[LI]);
          Exit;
        end;
        Inc(LIndex);
      end;
    end;
  end;
  Result := nil;
end;

function TgtPDPage.GetRadioItemFormStream(AWidth, AHeight: Double;
  AFontTag: AnsiString; AI: Integer; AFormField: TgtPDFormRadioButton;
  AFormItem: TgtPDRadioItem; ADef: Boolean): TMemoryStream;
var
  LCh: AnsiChar;
  LStr: AnsiString;
begin
  case AFormField.Symbol of
    csCheck: LCh := '4';
    csCircle: LCh := 'l';
    csCross: LCh := '8';
    csDiamond: LCh := 'u';
    csSquare: LCh := 'n';
    csStar: LCh := 'H';
  else LCh := 'l';
  end;

  if ((AI = 0) and (ADef = False)) then
  begin
    LStr := FloatToStringLocale(AFormItem.BackgroundColor.Value[0]) + ' ' +
      FloatToStringLocale(AFormItem.BackgroundColor.Value[1]) + ' ' +
      FloatToStringLocale(AFormItem.BackgroundColor.Value[2]) +
      ' rg 0 w 0.6 0.6 ' + FloatToStringLocale(AWidth - 2) + ' ' +
      FloatToStringLocale(AHeight - 2) + ' re f ' +
      FloatToStringLocale(AFormItem.BorderColor.Value[0]) + ' ' +
      FloatToStringLocale(AFormItem.BorderColor.Value[1]) + ' ' +
      FloatToStringLocale(AFormItem.BorderColor.Value[2]) +
      ' RG 1 w 0.5 0.5 ' + FloatToStringLocale(AWidth - 1) +
      ' ' + FloatToStringLocale(AHeight - 1) + ' re s q 1 1 ' + FloatToStringLocale(AWidth - 2) +
      ' ' + FloatToStringLocale(AHeight - 2) + ' re W n BT /' + AFontTag + ' ' +
      IntToStr(AFormField.Font.Size) + ' Tf ' +
      ColorToPDFColor(GetRValue(ColorToRGB(AFormField.Font.Color)),
      GetGValue(ColorToRGB(AFormField.Font.Color)),
      GetBValue(ColorToRGB(AFormField.Font.Color))) +
      ' rg ' + ' 1 0 0 1 0.77 1.405 Tm (' + LCh + ') Tj ET Q';
  end
  else if ((AI = 1) and (ADef = False)) then
  begin
    LStr := FloatToStringLocale(AFormItem.BackgroundColor.Value[0]) + ' ' +
      FloatToStringLocale(AFormItem.BackgroundColor.Value[1]) + ' ' +
      FloatToStringLocale(AFormItem.BackgroundColor.Value[2]) +
      ' rg 0 w 0.6 0.6 ' + FloatToStringLocale(AWidth - 2) + ' ' +
      FloatToStringLocale(AHeight - 2) + ' re f ' +
      FloatToStringLocale(AFormItem.BorderColor.Value[0]) + ' ' +
      FloatToStringLocale(AFormItem.BorderColor.Value[1]) + ' ' +
      FloatToStringLocale(AFormItem.BorderColor.Value[2]) +
      ' RG 1 w 0.5 0.5 ' + FloatToStringLocale(AWidth - 1) + ' ' +
      FloatToStringLocale(AHeight - 1) + ' re s';
  end
  else if ((AI = 0) and (ADef = True)) then
  begin
    LStr := FloatToStringLocale(AFormItem.BackgroundColor.Value[0]) + ' ' +
      FloatToStringLocale(AFormItem.BackgroundColor.Value[1]) + ' ' +
      FloatToStringLocale(AFormItem.BackgroundColor.Value[2]) + ' rg 0 w 0.6 0.6 ' +
      FloatToStringLocale(AWidth - 2) + ' ' + FloatToStringLocale(AHeight - 2) + ' re f ' +
      FloatToStringLocale(AFormItem.BorderColor.Value[0]) + ' ' +
      FloatToStringLocale(AFormItem.BorderColor.Value[1]) + ' ' +
      FloatToStringLocale(AFormItem.BorderColor.Value[2]) +
      ' RG 0 0 ' + FloatToStringLocale(AWidth)
      + ' ' + FloatToStringLocale(AHeight) + ' re f 0 G 1 w 0.5 0.5 ' + FloatToStringLocale(AWidth - 1)
      + ' ' + FloatToStringLocale(AHeight - 1) + ' ' + 're s q 1 1 ' + FloatToStringLocale(AWidth - 2)
      + ' ' + FloatToStringLocale(AHeight - 2) + 're W n BT /' + AFontTag + ' ' +
      IntToStr(AFormField.Font.Size) + ' Tf ' +
      ColorToPDFColor(GetRValue(ColorToRGB(AFormField.Font.Color)),
      GetGValue(ColorToRGB(AFormField.Font.Color)),
      GetBValue(ColorToRGB(AFormField.Font.Color))) + ' rg ' +
      ' 1 0 0 1 0.77 1.405 Tm (' + LCh + ') Tj ET Q';
  end
  else if ((AI = 1) and (ADef = True)) then
  begin
    LStr := FloatToStringLocale(AFormItem.BackgroundColor.Value[0]) + ' ' +
      FloatToStringLocale(AFormItem.BackgroundColor.Value[1]) + ' ' +
      FloatToStringLocale(AFormItem.BackgroundColor.Value[2]) + ' rg 0 w 0.6 0.6 ' +
      FloatToStringLocale(AWidth - 2) + ' ' + FloatToStringLocale(AHeight - 2) + ' re f ' +
      FloatToStringLocale(AFormItem.BorderColor.Value[0]) + ' ' +
      FloatToStringLocale(AFormItem.BorderColor.Value[1]) + ' ' +
      FloatToStringLocale(AFormItem.BorderColor.Value[2]) +
      ' RG 0 0 ' + FloatToStringLocale(AWidth) + ' ' + FloatToStringLocale(AHeight) +
      ' re f 0 G 1 w 0.5 0.5 ' + FloatToStringLocale(AWidth - 1) + ' ' +
      FloatToStringLocale(AHeight - 1) + ' re s';
  end;
  Result := TMemoryStream.Create;
  Result.Write(Pointer(LStr)^, Length(LStr));
end;

(*
 *  Gets the Resource from the Page dictionary
 *  @returns Resource of the type TgtPDResource
 *  @algorithm
 *      1.  Satrt
 *      2.  IF FResource is not Assigned THEN
 *      3.  Begin
 *        a.  LResourceObj := LookUp for Resource in FBaseObject
 *        b.  IF Assigned LResourceObj THEN
 *          i.  FResource := Create TgtPDResource(FParentDoc, Self, LResourceObj)
 *      4.  Result := FResource
 *      5.  End
 *)

function TgtPDPage.GetResource: TgtPDResource;
var
  LResourceObj: TgtPDBaseObject;
begin
  Result := nil;
  if not Assigned(FResource) then
  begin
    LResourceObj := TgtPDDictionary(FBaseObject).LookUp(PDF_RESOURCES);
    if Assigned(LResourceObj) then
    begin
      FResource := TgtPDResource.Create(FParentDoc, Self, LResourceObj);
    end
    else
    begin
      if Assigned(FInheritedProp) then
        Result := FInheritedProp.GetResource;
      Exit;
    end;
  end;
  Result := FResource;
end;

 (**
   *
   * Gets Rotate from the baseobject
   *
   * @return value of Rotate of type Integer
   *
   * @exception EBadPage if any error while parsing the page
   *
   * Algorithm
   *   1. If FRotate (of type TgtPDInteger) is not assigned then
   *      o. Look up for ‘Rotate’ in FBaseObject  by typecasting FBaseObject
   *        to TgtPDDictionary and call lookup function with ‘Rotate’ as parameter.
   *      o. If obtained object is nill then
   *         .	Create a TgtPDInteger object and assign to FRotate
   *      o. Else if it is Integer object then assign to FRotate
   *   2. Return the value of FRotate
   *)

function TgtPDPage.GetRotate: Integer;
var
  LObj: TgtPDBaseObject;
begin
  if not Assigned(FRotate) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_ROTATE);
    if Assigned(LObj) then
    begin
      if LObj.IsInteger then
        FRotate := TgtPDInteger(LObj)
      else
      begin
        raise EXBadPage.Create(ErrPage);
{$IFDEF DEBUG}
        Logger.LogError('Page: Integer object Expected');
{$ENDIF}
      end;
    end
    else
      FRotate := nil;
  end;
  if Assigned(FRotate) then
    Result := TgtPDInteger(FRotate).Value
  else
    Result := 0;
end;

function TgtPDPage.GetSigAppearance(AImgStream: TStream;
  AImageFormat: TgtOutFormat; ASigField: TgtPDSignatureField): TgtPDStream;
var
  LImageObj, LObj1: TgtPDBaseObject;
  LDict: TgtPDDictionary;
  LgtMemStream: TgtMemoryStream;
  LMemStream: TMemoryStream;
  LBuffer: Bytes;
  LImageTag, LStr: AnsiString;
  LImage: Graphics.TBitmap;
  LAngleInRadian, LPageAngle, LPageAngleInRadian: Extended;
  LDisplayRect: TgtPDRect;
  ImageLeft, ImageBottom, ImageAlpha, ImageLeftDx, ImageBottomDy,
    ImageDglDst: Double;
  LIsPageRotate: Boolean;
  LRect, LPageRect: TgtPDRect;
begin
  LStr := '';
  LImage := Graphics.TBitmap.Create;
  //check the image format...
  case AImageFormat of
    ofBMP:
      begin
        AImgStream.Position := 0;
        LImage.LoadFromStream(AImgStream);
        LMemStream := TMemoryStream(GetPDFBitmapStream(LImage));
      end;
    ofPPM:
      begin
        LMemStream := TMemoryStream.Create;
        LImage.LoadFromStream(AImgStream);
        LMemStream.LoadFromStream(AImgStream);
      end;
    ofPBM:
      begin
        LMemStream := TMemoryStream.Create;
        LImage.LoadFromStream(AImgStream);
        LMemStream.LoadFromStream(AImgStream);
      end;
    ofJPEG:
      begin
        LMemStream := TMemoryStream.Create;
        if Assigned(LImage) then FreeAndNil(LImage);
        TJPEGImage(LImage) := TJPEGImage.Create;
        AImgStream.Position := 0;
        LImage.LoadFromStream(AImgStream);
        LImage.SaveToStream(LMemStream);
      end;
  end;

  LRect := ASigField.Rect;
  LPageRect := TgtPDPage(FParentElement).Cropbox;
  if not Assigned(LPageRect) then
    LPageRect := TgtPDPage(FParentElement).Mediabox;
  LRect.Left := LRect.Left + LRect.Left;
  LRect.Top := LRect.Top + LRect.Top;

//  LAngleInRadian := AAngle * (PI / 180);
  LDisplayRect := TgtPDRect.Create(LRect.Left, LRect.Top,
    LRect.Right, LRect.Bottom);

//  LPageAngle := TgtPDPage(FParentElement).Rotate;
//  LPageAngleInRadian := LPageAngle * (PI / 180);

  if ((LPageAngle <> 0) and (LPageAngle <> 360))  then
  begin
    LIsPageRotate := True;

    ImageLeft := LRect.Left;
    ImageBottom := ((TgtPDPage(FParentElement).GetPageHeight - LRect.Top) +
      (LDisplayRect.Bottom - LDisplayRect.Top));

    // Translate
    LStr := LStr + '1 0 0 1' + SP +
      FloatToStringF(ImageBottom) + SP + FloatToStringF(ImageLeft) + SP +
      'cm' + CRLF;
    // Rotate
    LStr := LStr + FloatToStrFLocale(Cos(LPageAngleInRadian), ffFixed, 10, 3) + SP +
      FloatToStrFLocale(Sin(LPageAngleInRadian), ffFixed, 10, 3) + SP +
      FloatToStrFLocale(-Sin(LPageAngleInRadian), ffFixed, 10, 3) + SP +
      FloatToStrFLocale(Cos(LPageAngleInRadian), ffFixed, 10, 3) + SP +
      '0 0' + SP + 'cm' + CRLF;
  end;

  if LIsPageRotate then
  begin
    LRect.Left := 0;
    LRect.Top := 0;
  end
  else
    LRect.Top := Abs(LRect.Top - Abs(LRect.Bottom - LRect.Top));

  LStr := LStr + 'q' + CRLF +
    '0 g 0 G' + CRLF +
    FloatToStrFLocale(Abs(LRect.Right - LRect.Left), ffFixed, 10, 3) + SP +
    FloatToStrFLocale(0, ffFixed, 10, 3) + SP +
    FloatToStrFLocale(0, ffFixed, 10, 3) + SP +
    FloatToStrFLocale(Abs(LRect.Bottom - LRect.Top), ffFixed, 10, 3) + SP +
    FloatToStrFLocale(LRect.Left, ffFixed, 10, 3) + SP;
  LStr := LStr + FloatToStrFLocale(LRect.Top, ffFixed, 10, 3) + SP +
    'cm' + CRLF;

  LMemStream.Position := 0;
  LgtMemStream := TgtMemoryStream.Create(LMemStream, 0, 0, False);
  LgtMemStream.Reset;


  LImageTag := TgtPDPage(FParentElement).Resource.GetResourceName(resXObject);

  TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber :=
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber + 1;

  LDict := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);
  LDict.Add(PDF_TYPE, TgtPDName.Create(PDF_XOBJECT));
  LDict.Add(PDF_SUBTYPE, TgtPDName.Create(PDF_IMAGE));
  LDict.Add(PDF_NAME, TgtPDName.Create(LImageTag));
  LDict.Add(PDF_WIDTH, TgtPDInteger.Create(LImage.Width));
  LDict.Add(PDF_HEIGHT, TgtPDInteger.Create(LImage.Height));
  LDict.Add(PDF_BITSPERCOMP, TgtPDInteger.Create(8));
  LDict.Add(PDF_COLORSPACE, TgtPDName.Create(PDF_DEVICERGB));
  LDict.Add(PDF_LENGTH, TgtPDInteger.Create(LgtMemStream.GetSize));

  if AImageFormat = ofJPEG then
    LDict.Add(PDF_Filter, TgtPDName.Create(PDF_DCTDecode));

  LImageObj := TgtPDStream.Create(LgtMemStream, LDict,
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber, 0);

  TgtPDDocument(FParentDoc).BaseDoc.AddToCollection(LImageObj);
  Result := TgtPDStream(LImageObj);
//  TgtPDPage(FParentElement).AddResource(resXObject, LImageTag, LImageObj);

  LStr := LStr + '/' + LImageTag + ' ' + 'Do' + CRLF +
    'Q' + CRLF;
//  TgtPDStream(FBaseObject).Write(LStr);
  if Assigned(LImage) then FreeAndNil(LImage);
  FreeAndNil(LMemStream);
  if Assigned(LDisplayRect) then FreeAndNil(LDisplayRect);
end;

function TgtPDPage.GetSigFormStream(AWidth, AHeight: Double;
  AFontTag: AnsiString; AI: Integer;
  AFormField: TgtPDSignatureField): TMemoryStream;
var
  LStr, LStr1: AnsiString;
  LDate: TgtDate;
  LSig: TgtPDSignature;
  LDateStr: AnsiString;
  LSigText, LModSigText: TStringList;
  LWidth, LHeight, I: Integer;
  LIsFitToRect: Boolean;
  
  function WriteTextAsPDFString(AX, AY: Double; AFontSize: Integer;
    AFontTag, AText: WideString): AnsiString;
  begin
    Result := 'BT' + CRLF +
      FloatToStrFLocale(2, ffFixed, 18, 8) + SP + 'Tc' + CRLF +
      '0 Tw 100 Tz' + SP + IntToStr(AFontSize) + SP + 'TL' + CRLF +
      '/' + AFontTag + ' ' + IntToStr(AFontSize) + ' ' + 'Tf' +
      CRLF + FloatToStringLocale(AX) + ' ' + FloatToStringLocale(AY) + ' ' + 'Td' +
      CRLF + '(' + AText + ')' + ' ' + 'Tj' +
      CRLF + 'ET' + CRLF;
  end;
begin
//  Result := nil;
  if (AI = 0) then
  begin
    LSig := AFormField.Signature;
    if LSig.DateTime <> 0 then
    begin
      {$IFDEF VCL6ORABOVE}
      DecodeDateTime(LSig.DateTime, LDate.Year, LDate.Month, LDate.Day, LDate.Hour,
        LDate.Minutes, LDate.Seconds, LDate.MilliSeconds);
      {$ENDIF}
      {$IFDEF DELPHI5}
        DecodeDate(LSig.DateTime, LDate.Year, LDate.Month, LDate.Day);
        DecodeTime(LSig.DateTime, LDate.Hour, LDate.Minutes, LDate.Seconds, LDate.MilliSeconds);
      {$ENDIF}
      LDateStr := DateToPDFString(LDate);
    end;

    LStr := FloatToStringLocale(AFormField.BackgroundColor.Value[0]) + ' ' +
      FloatToStringLocale(AFormField.BackgroundColor.Value[1]) + ' ' +
      FloatToStringLocale(AFormField.BackgroundColor.Value[2]) +
      ' rg 0 0 ' + FloatToStringLocale(AWidth) +
      ' ' + FloatToStringLocale(AHeight) + ' re f ' +
      FloatToStringLocale(AFormField.BorderColor.Value[0]) + ' ' +
      FloatToStringLocale(AFormField.BorderColor.Value[1]) + ' ' +
      FloatToStringLocale(AFormField.BorderColor.Value[2]) +
      ' RG' + #13#10; //+ 0 w 1 1 ' + FloatToStringLocale(AWidth) + ' ' +
//      FloatToStringLocale(AHeight - 2) + ' re s 1 g 2 2 m 2 ' +
//      FloatToStringLocale(AHeight - 2) + ' l ' + FloatToStringLocale(AWidth - 2) + ' ' +
//      FloatToStringLocale(AHeight - 2) + ' l ' + FloatToStringLocale(AWidth - 4) + ' ' +
//      FloatToStringLocale(AHeight - 4) + ' l 4 ' + FloatToStringLocale(AHeight - 4) +
//      ' l 4 4 l f 0.502 g ' + FloatToStringLocale(AWidth - 2) + ' ' +
//      FloatToStringLocale(AHeight - 2) + ' m ' + FloatToStringLocale(AWidth - 2) +
//      ' 2 l 2 2 l 4 4 l ' + FloatToStringLocale(AWidth - 4) + ' 4 l ' +
//      FloatToStringLocale(AWidth - 4) + ' ' + FloatToStringLocale(AHeight - 4) + ' l f q 4 4 ' +
//      FloatToStringLocale(AWidth - 8) + ' ' + FloatToStringLocale(AHeight - 8) +
//      {"' re W n }'
      (*
       BT /' + AFontTag + ' ' +
      IntToStr(Round((72 / 96) * (AFormField.Font.Size))) + ' Tf ' +
      ColorToPDFColor(GetRValue(ColorToRGB(AFormField.Font.Color)),
      GetGValue(ColorToRGB(AFormField.Font.Color)),
      GetBValue(ColorToRGB(AFormField.Font.Color))) +
      ' rg ' + ' 1 0 0 1 ' + FloatToStringLocale(AWidth/10) + ' ' + FloatToStringLocale(AWidth/2) + ' Tm (' +
      AFormField.NormalCaption + ') Tj' + #13#10 + '0 -1.2 TD'+ #13#10 +  'T*' + #13#10+ '(Location:' +
      LSig.Location + ') Tj' + #13#10 + 'T*' + #13#10+
      '(Reason: ' + LSig.Reason + ') Tj' + #13#10 + 'T*' + #13#10+ '(Date: '
      + LDateStr + ') Tj ' + 'ET Q';
      *)
  LWidth := Abs(Round(AFormField.Rect.Right - AFormField.Rect.Left));
  LHeight := Abs(Round(AFormField.Rect.Bottom - AFormField.Rect.Top));
  LSigText := GetSigText(LSig);
  LModSigText := TStringList.Create;
  repeat
    LModSigText.Clear;
    LIsFitToRect := FitTextToWidth(LSigText, AFormField.Font, LWidth - 4, LModSigText);
    if not LIsFitToRect then
    LIsFitToRect := FitTextToHeight(LSigText, AFormField.Font, LHeight - 4,
      AFormField.Font.Size, LModSigText);
  until
    (LIsFitToRect = True) or (AFormField.Font.Size < 4);
  end;


  LStr := LStr + ' BT /' + AFontTag + ' ' +
      IntToStr(Round((72 / 96) * (AFormField.Font.Size))) + ' Tf ' +
      ColorToPDFColor(GetRValue(ColorToRGB(AFormField.Font.Color)),
      GetGValue(ColorToRGB(AFormField.Font.Color)),
      GetBValue(ColorToRGB(AFormField.Font.Color))) +
      ' rg ' + ' 1 0 0 1 ' + FloatToStringLocale(0) + ' ' +
      FloatToStringLocale(LWidth - 2) + ' Tm ' + '0 '
      + '-'+ IntToStr(Round((72 / 96) * (AFormField.Font.Size))) +  ' TD';

  LStr1 := '';
  for I := 0 to LModSigText.Count - 1 do
  begin
    if LModSigText[I] <> '' then
    begin
      LStr1 := LStr1 + '(' + LModSigText[I] + ') Tj' + CRLF;
      if I < LModSigText.Count - 1 then
        LStr1 := LStr1 + 'T*' + CRLF;
    end;
  end;
  LStr1 := LStr1 + 'ET Q';

  LStr := LStr + LStr1;

  Result := TMemoryStream.Create;
  Result.Write(Pointer(LStr)^, Length(LStr));
//  for I := 0 to LModSigText.Count - 1 do
//  begin
//    LStr := '';
//    LStr := WriteTextAsPDFString(AFormField.Rect.Left, AFormField.Rect.Top,
//      AFormField.Font.Size, AFontTag, LModSigText[I]);
//    Result.Write(Pointer(LStr)^, Length(LStr));
//  end;
  LModSigText.Free;
  LSigText.Free;
end;

function TgtPDPage.GetSigText(ASig: TgtPDSignature): TStringList;
var
  LSigOptions: TgtSigDisplayOptions;
  LStr, LDateStr: AnsiString;
  LDate: TgtDate;
  LEnvelope: TgtPKCS7;
  LCertContext: PCertContext;
begin
  Result := TStringList.Create;
  LSigOptions := ASig.SigDispOptions;
  LStr := '';

  if sdoName in LSigOptions then
  begin
    LEnvelope := TgtPKCS7.Create;
    LCertContext := LEnvelope.GetPFXCertWithPvtKey(ASig.PFXFileName,
      ASig.PFXPassword);
    if sdoLabels in LSigOptions then
      LStr := SName;
    LStr := LStr + LEnvelope.GetCertificateName(LCertContext);
    Result.Add(LStr);
    LStr := '';
    LEnvelope.Free;
  end;

  if sdoReason in LSigOptions then
  begin
    if sdoLabels in LSigOptions then
      LStr := SReason;
    LStr := LStr + ASig.Reason;
    Result.Add(LStr);
    LStr := '';
  end;

  if sdoLocation in LSigOptions then
  begin
    if sdoLabels in LSigOptions then
      LStr := SLocation;
    LStr := LStr + ASig.Location;
    Result.Add(LStr);
    LStr := '';
  end;

  if sdoDate in LSigOptions then
  begin
    if ASig.DateTime <> 0 then
    begin
      {$IFDEF VCL6ORABOVE}
      DecodeDateTime(ASig.DateTime, LDate.Year, LDate.Month, LDate.Day, LDate.Hour,
        LDate.Minutes, LDate.Seconds, LDate.MilliSeconds);
      {$ENDIF}
      {$IFDEF DELPHI5}
        DecodeDate(ASig.DateTime, LDate.Year, LDate.Month, LDate.Day);
        DecodeTime(ASig.DateTime, LDate.Hour, LDate.Minutes, LDate.Seconds, LDate.MilliSeconds);
      {$ENDIF}
      LDateStr := DateToPDFString(LDate);
      LDateStr := StringReplace(LDateStr, 'D:', '', []);
    end;

    if sdoLabels in LSigOptions then
      LStr := SDate;
    LStr := LStr + LDateStr;
    Result.Add(LStr)
  end;
end;

(**
   *
   * Gets MediaBox from the baseobject
   *
   * @return MediaBox of type TgtPDRect
   *
   * @exception EBadPage if any error while parsing the page
   *
   * Algorithm
   *  1. If FMediaBox is not assigned then
   *      a. Look up for ‘MediaBox’ in FBaseObject by typecasting FBaseObject
   *         to TgtPDDictionary and call lookup function with ‘MediaBox’ as parameter.
   *      b. If obtained object is nill then
   *          o	Create a TgtPDRect object and assign to FMediaBox
   *        Else
   *          o	If obtained object is Array object then
   *             . Create a TgtPDRect object with obtained Array object and
   *                assign to FMediaBox
   *  2. Return FMediaBox
   *)

function TgtPDPage.GetMediaBox: TgtPDRect;
var
  LObj: TgtPDBaseObject;
begin
  Result := nil;
  if not Assigned(FMediaBox) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_MEDIABOX);
    if Assigned(LObj) then
    begin
      if LObj.IsArray then
        FMediaBox := TgtPDRect.Create(TgtPDArray(LObj))
      else
      begin
        raise EXBadPage.Create(ErrPage);
{$IFDEF DEBUG}
        Logger.LogError('Page: Array object Expected');
{$ENDIF}
      end;
    end
    else
    begin
      if Assigned(FInheritedProp) then
      begin
        Result := FInheritedProp.GetMediaBox;
        FIsInheritedMediaBox := True;
      end;
      Exit;
    end;
  end;
  Result := FMediaBox;
end;

function TgtPDPage.GetNativeYPos(AY: Double): Double;
var
  LPageSize: TgtPageSize;
  LHeight, LWidth: Double;
begin
  Result := 0;
  LPageSize := GetPageSize;

  if ((Rotate = 90) or (Rotate = 270)) then
  begin
    LHeight := LPageSize.Width;
    LWidth := LPageSize.Height;
  end
  else
  begin
    LHeight := LPageSize.Height;
    LWidth := LPageSize.Width;
  end;

  if (LHeight <> 0) then
    Result := Abs(LHeight - AY);
end;

function TgtPDPage.GetPageHeight: Double;
var
  LPageSize: TgtPageSize;
begin
  LPageSize := GetPageSize;
  Result := LPageSize.Height;
end;

function TgtPDPage.GetPageSize: TgtPageSize;
var
  LRect: TgtPDRect;
begin
  LRect := GetCropBox;
  if Assigned(LRect) then
  begin
    Result.Width := LRect.Right - LRect.Left;
    Result.Height := LRect.Bottom - LRect.Top;
  end
  else
  begin
    LRect := GetMediaBox;
    Result.Width := Abs(LRect.Right - LRect.Left);
    Result.Height := Abs(LRect.Bottom - LRect.Top);
  end;
end;

function TgtPDPage.GetPageWidth: Double;
var
  LPageSize: TgtPageSize;
begin
  LPageSize := GetPageSize;
  Result := LPageSize.Width;
end;

function TgtPDPage.GetPDFBitmapStream(ABitmap: Graphics.TBitmap): TStream;
var
  LX, LY: Integer;
  ScanLine: PByteArray;
  LByte: Byte;
  LBitmap: Graphics.TBitmap;
begin
  Result := TMemoryStream.Create;
  LBitmap := Graphics.TBitmap.Create;
  try
    LBitmap.Assign(ABitmap);
    LBitmap.PixelFormat := pf24Bit;

    Result.Size := LBitmap.Width * LBitmap.Height * 3;
    for LY := 0 to (LBitmap.Height - 1) do
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

function TgtPDPage.GetPushButtonFormStream(AX, AY, AWidth, AHeight: Double;
  AFontTag: AnsiString; AI: Integer; AFormField: TgtPDFormPushButton): TMemoryStream;
var
  LStr: AnsiString;
begin
//  Result := nil;
  if (AI = 0) then
  begin
    LStr := FloatToStringLocale(AFormField.BackgroundColor.Value[0]) + ' ' +
      FloatToStringLocale(AFormField.BackgroundColor.Value[1]) + ' ' +
      FloatToStringLocale(AFormField.BackgroundColor.Value[2]) +
      ' rg 0 0 ' + FloatToStringLocale(AWidth) +
      ' ' + FloatToStringLocale(AHeight) + ' re f ' +
      FloatToStringLocale(AFormField.BorderColor.Value[0]) + ' ' +
      FloatToStringLocale(AFormField.BorderColor.Value[1]) + ' ' +
      FloatToStringLocale(AFormField.BorderColor.Value[2]) +
      ' RG 0 w 1 1 ' + FloatToStringLocale(AWidth) + ' ' +
      FloatToStringLocale(AHeight - 2) + ' re s 1 g 2 2 m 2 ' +
      FloatToStringLocale(AHeight - 2) + ' l ' + FloatToStringLocale(AWidth - 2) + ' ' +
      FloatToStringLocale(AHeight - 2) + ' l ' + FloatToStringLocale(AWidth - 4) + ' ' +
      FloatToStringLocale(AHeight - 4) + ' l 4 ' + FloatToStringLocale(AHeight - 4) +
      ' l 4 4 l f 0.502 g ' + FloatToStringLocale(AWidth - 2) + ' ' +
      FloatToStringLocale(AHeight - 2) + ' m ' + FloatToStringLocale(AWidth - 2) +
      ' 2 l 2 2 l 4 4 l ' + FloatToStringLocale(AWidth - 4) + ' 4 l ' +
      FloatToStringLocale(AWidth - 4) + ' ' + FloatToStringLocale(AHeight - 4) + ' l f q 4 4 ' +
      FloatToStringLocale(AWidth - 8) + ' ' + FloatToStringLocale(AHeight - 8) +
      ' re W n BT /' + AFontTag + ' ' +
      IntToStr(Round((72 / 96) * (AFormField.Font.Size))) + ' Tf ' +
      ColorToPDFColor(GetRValue(ColorToRGB(AFormField.Font.Color)),
      GetGValue(ColorToRGB(AFormField.Font.Color)),
      GetBValue(ColorToRGB(AFormField.Font.Color))) +
      ' rg ' + ' 1 0 0 1 ' + FloatToStringLocale(AX) + ' ' + FloatToStringLocale(AY) + ' Tm (' +
      AFormField.NormalCaption + ') Tj ET Q';
  end
  else if (AI = 2) then
  begin
    LStr := FloatToStringLocale(AFormField.BackgroundColor.Value[0]) + ' ' +
      FloatToStringLocale(AFormField.BackgroundColor.Value[1]) + ' ' +
      FloatToStringLocale(AFormField.BackgroundColor.Value[2]) +
      ' rg 0 0 ' + FloatToStringLocale(AWidth) +
      ' ' + FloatToStringLocale(AHeight) + ' re f ' +
      FloatToStringLocale(AFormField.BorderColor.Value[0]) + ' ' +
      FloatToStringLocale(AFormField.BorderColor.Value[1]) + ' ' +
      FloatToStringLocale(AFormField.BorderColor.Value[2]) +
      ' RG 0 w 1 1 ' + FloatToStringLocale(AWidth - 2) + ' ' +
      FloatToStringLocale(AHeight - 2) + ' re s 1 g 2 2 m 2 ' +
      FloatToStringLocale(AHeight - 2) + ' l ' + FloatToStringLocale(AWidth - 2) + ' ' +
      FloatToStringLocale(AHeight - 2) + ' l ' + FloatToStringLocale(AWidth - 4) + ' ' +
      FloatToStringLocale(AHeight - 4) + ' l 4 ' + FloatToStringLocale(AHeight - 4) +
      ' l 4 4 l f 0.502 g ' + FloatToStringLocale(AWidth - 2) + ' ' +
      FloatToStringLocale(AHeight - 2) + ' m ' + FloatToStringLocale(AWidth - 2) +
      ' 2 l 2 2 l 4 4 l ' + FloatToStringLocale(AWidth - 4) + ' 4 l ' +
      FloatToStringLocale(AWidth - 4) + ' ' + FloatToStringLocale(AHeight - 4) + ' l f q 4 4 ' +
      FloatToStringLocale(AWidth - 8) + ' ' + FloatToStringLocale(AHeight - 8) +
      ' re W n BT /' + AFontTag + ' ' +
      IntToStr(round((72 / 96) * (AFormField.Font.Size))) + ' Tf ' +
      ColorToPDFColor(GetRValue(ColorToRGB(AFormField.Font.Color)),
      GetGValue(ColorToRGB(AFormField.Font.Color)),
      GetBValue(ColorToRGB(AFormField.Font.Color))) +
      ' rg ' + ' 1 0 0 1 ' + FloatToStringLocale(AX) + ' ' + FloatToStringLocale(AY) + ' Tm (' +
      AFormField.DownCaption + ') Tj ET Q';
  end
  else if (AI = 1) then
  begin
    LStr := FloatToStringLocale(AFormField.BackgroundColor.Value[0]) + ' ' +
      FloatToStringLocale(AFormField.BackgroundColor.Value[1]) + ' ' +
      FloatToStringLocale(AFormField.BackgroundColor.Value[2]) +
      ' rg 0 0 ' + FloatToStringLocale(AWidth) +
      ' ' + FloatToStringLocale(AHeight) + ' re f ' +
      FloatToStringLocale(AFormField.BorderColor.Value[0]) + ' ' +
      FloatToStringLocale(AFormField.BorderColor.Value[1]) + ' ' +
      FloatToStringLocale(AFormField.BorderColor.Value[2]) +
      ' RG 0 w 1 1 ' + FloatToStringLocale(AWidth - 2) + ' ' +
      FloatToStringLocale(AHeight - 2) + ' re s 1 g 2 2 m 2 ' +
      FloatToStringLocale(AHeight - 2) + ' l ' + FloatToStringLocale(AWidth - 2) + ' ' +
      FloatToStringLocale(AHeight - 2) + ' l ' + FloatToStringLocale(AWidth - 4) + ' ' +
      FloatToStringLocale(AHeight - 4) + ' l 4 ' + FloatToStringLocale(AHeight - 4) +
      ' l 4 4 l f 0.502 g ' + FloatToStringLocale(AWidth - 2) + ' ' +
      FloatToStringLocale(AHeight - 2) + ' m ' + FloatToStringLocale(AWidth - 2) +
      ' 2 l 2 2 l 4 4 l ' + FloatToStringLocale(AWidth - 4) + ' 4 l ' +
      FloatToStringLocale(AWidth - 4) + ' ' + FloatToStringLocale(AHeight - 4) + ' l f q 4 4 ' +
      FloatToStringLocale(AWidth - 8) + ' ' + FloatToStringLocale(AHeight - 8) +
      ' re W n BT /' + AFontTag + ' ' +
      IntToStr(round((72 / 96) * (AFormField.Font.Size))) + ' Tf ' +
      ColorToPDFColor(GetRValue(ColorToRGB(AFormField.Font.Color)),
      GetGValue(ColorToRGB(AFormField.Font.Color)),
      GetBValue(ColorToRGB(AFormField.Font.Color))) +
      ' rg ' + ' 1 0 0 1 ' + FloatToStringLocale(AX) + ' ' + FloatToStringLocale(AY) + ' Tm ('
      + AFormField.RolloverCaption + ') Tj ET Q';
  end;
  Result := TMemoryStream.Create;
  Result.Write(Pointer(LStr)^, Length(LStr));
end;

(**
   *
   * Gets TrimBox from the baseobject
   *
   * @return TrimBox of type TgtPDRect
   *
   * @exception EBadPage if any error while parsing the page
   *
   * Algorithm
   *  1. If FTrimBox is not assigned then
   *      a. Look up for ‘TrimBox’ in FBaseObject by typecasting FBaseObject
   *         to TgtPDDictionary and call lookup function with ‘TrimBox’ as parameter.
   *      b. If obtained object is nill then
   *          o	Create a TgtPDRect object and assign to FTrimBox
   *        Else
   *          o	If obtained object is Array object then
   *             . Create a TgtPDRect object with obtained Array object and
   *                assign to FTrimBox
   *  2. Return FTrimBox
   *)

function TgtPDPage.GetTrimBox: TgtPDRect;
var
  LObj: TgtPDBaseObject;
begin
  if not Assigned(FTrimBox) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_TRIMBOX);
    if Assigned(LObj) then
    begin
      if LObj.IsArray then
        FTrimBox := TgtPDRect.Create(TgtPDArray(LObj))
      else
      begin
        raise EXBadPage.Create(ErrPage);
{$IFDEF DEBUG}
        Logger.LogError('Page: Array object Expected');
{$ENDIF}
      end;
    end
    else
      FTrimBox := TgtPDRect.Create;
  end;
  Result := FTrimBox;
end;

procedure TgtPDPage.InsertAnnotation(Annot: TgtPDAnnot);
begin
  //Inserting a file attachment
  if Annot is TgtPDFileAttachmentAnnot then
  begin
    InsertFileAttachment(TgtPDFileAttachmentAnnot(Annot));
  end
  else if Annot is TgtPDLineAnnot then
  begin
    InsertLineAnnot(TgtPDLineAnnot(Annot));
  end
  else if Annot is TgtPDCircleAnnot then
    InsertCircleAnnot(TgtPDCircleAnnot(Annot))
  else if Annot is TgtPDSquareAnnot then
    InsertSqaureAnnot(TgtPDSquareAnnot(Annot))
  else if Annot is TgtPDCaretAnnot then
    InsertCaretAnnot(TgtPDCaretAnnot(Annot))
  else if Annot is TgtPDPolyLineAnnot then
    InsertPolyLineAnnot(TgtPDPolyLineAnnot(Annot))
  else if Annot is TgtPDPolygonAnnot then
    InsertPolygonAnnot(TgtPDPolygonAnnot(Annot))
  else if Annot is TgtPDLinkAnnot then
    InsertLinkAnnot(TgtPDLinkAnnot(Annot))
  else if Annot is TgtPDRubberStampAnnot then
    InsertStampAnnot(TgtPDRubberStampAnnot(Annot))
  else if Annot is TgtPDInkAnnot then
    InsertInkAnnot(TgtPDInkAnnot(Annot))
  else if Annot is TgtPDTextAnnot then
    InsertTextAnnot(TgtPDTextAnnot(Annot))
  else if Annot is TgtPDFreeTextAnnot then
    InsertFreeTextAnnot(TgtPDFreeTextAnnot(Annot))
  else if Annot is TgtPDMarkUpAnnot then
    InsertMarkUpAnnot(TgtPDMarkUpAnnot(Annot));
end;

procedure TgtPDPage.InsertCaretAnnot(ACaretAnnot: TgtPDCaretAnnot);
var
  LAnnotDict: TgtPDDictionary;
  LArray: TgtPDArray;
  LIndRef, LObj: TgtPDBaseObject;
  LAnnot: TgtPDAnnot;
begin
  TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber :=
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber + 1;
  //Create Annotation Dictionay (LineAttachment for this case)
  LAnnotDict := TgtPDDictionary.Create(
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber, 0,
    TgtPDDocument(FParentDoc).BaseDoc);
  //Addto collection to get it from other places (important)
  TgtPDDocument(FParentDoc).BaseDoc.AddToCollection(LAnnotDict);

  LAnnotDict.Add(PDF_SUBTYPE, TgtPDName.Create(PDF_CARET));
    // Add common entries like Rect, Title, Color etc..
  AddCommonAnnotEntries(ACaretAnnot, LAnnotDict);

  if ACaretAnnot.CaretSymbol = csParagraph then
    LAnnotDict.Add(PDF_Sy, TgtPDName.Create(PDF_P))
  else
    LAnnotDict.Add(PDF_Sy, TgtPDName.Create(PDF_NONE));

    //Update the Page's Annot entry
  LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_ANNOTS);
  if Assigned(LObj) then
  begin
    if not LObj.IsArray then //Annots entry is not an array
    begin
      //Create an array object
      LArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
      //Create and Add Indirect Ref of current object to the array
      LIndRef := TgtPDIndirectRef.Create(LObj.ObjNumber, LObj.GenNumber);
      LArray.Add(LIndRef);
      //Create and add Indirect Ref of Line annot object
      LIndRef := TgtPDIndirectRef.Create(LAnnotDict.ObjNumber, LAnnotDict.GenNumber);
      LArray.Add(LIndRef);
      TgtPDDictionary(FBaseObject).SetKeyValue(PDF_ANNOTS, LArray);
    end
    else //Already an Array object, add the attachment object to array
    begin
      LIndRef := TgtPDIndirectRef.Create(LAnnotDict.ObjNumber, LAnnotDict.GenNumber);
      TgtPDArray(LObj).Add(LIndRef);
    end;
  end
  else //Don't have a Annot entry, create and add one
  begin
    LIndRef := TgtPDIndirectRef.Create(LAnnotDict.ObjNumber, LAnnotDict.GenNumber);
    LArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
    LArray.Add(LIndRef);
    TgtPDDictionary(FBaseObject).Add(PDF_ANNOTS, LArray);
  end;

  //Create Attachment object to update the Page's Annot list
  LAnnot := TgtPDAnnot.MakeAnnot(FParentDoc, Self, LAnnotDict);
  GetAnnots.Add(LAnnot);
end;

procedure TgtPDPage.InsertCircleAnnot(ACircleAnnot: TgtPDCircleAnnot);
var
  LAnnotDict, LBorderEffectDict: TgtPDDictionary;
  LArray: TgtPDArray;
  LBorderStyle: AnsiString;
  LIndRef, LObj: TgtPDBaseObject;
  LAnnot: TgtPDAnnot;
begin
  TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber :=
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber + 1;
  //Create Annotation Dictionay (LineAttachment for this case)
  LAnnotDict := TgtPDDictionary.Create(
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber, 0,
    TgtPDDocument(FParentDoc).BaseDoc);
  //Addto collection to get it from other places (important)
  TgtPDDocument(FParentDoc).BaseDoc.AddToCollection(LAnnotDict);
  LAnnotDict.Add(PDF_SUBTYPE, TgtPDName.Create(PDF_CIRCLE));
  with ACircleAnnot do
  begin
    // Add common entries like Rect, Title, Color etc..
    AddCommonAnnotEntries(ACircleAnnot, LAnnotDict);

    // set Interior Color
    LArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
    LArray.Add(TgtPDReal.Create(InteriorColor.Value[0]));
    LArray.Add(TgtPDReal.Create(InteriorColor.Value[1]));
    LArray.Add(TgtPDReal.Create(InteriorColor.Value[2]));
    LAnnotDict.Add(PDF_IC, LArray);

    // Set Border Effect Dict
    LBorderEffectDict := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);
    if IsCloudy then
      LBorderEffectDict.Add(PDF_S, TgtPDName.Create(PDF_C))
    else
      LBorderEffectDict.Add(PDF_S, TgtPDName.Create(PDF_S));
    LBorderEffectDict.Add(PDF_I, TgtPDReal.Create(Intensity));
    LAnnotDict.Add(PDF_BE, LBorderEffectDict);

    //Update the Page's Annot entry
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_ANNOTS);
    if Assigned(LObj) then
    begin
      if not LObj.IsArray then //Annots entry is not an array
      begin
        //Create an array object
        LArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
        //Create and Add Indirect Ref of current object to the array
        LIndRef := TgtPDIndirectRef.Create(LObj.ObjNumber, LObj.GenNumber);
        LArray.Add(LIndRef);
        //Create and add Indirect Ref of Line annot object
        LIndRef := TgtPDIndirectRef.Create(LAnnotDict.ObjNumber, LAnnotDict.GenNumber);
        LArray.Add(LIndRef);
        TgtPDDictionary(FBaseObject).SetKeyValue(PDF_ANNOTS, LArray);
      end
      else //Already an Array object, add the attachment object to array
      begin
        LIndRef := TgtPDIndirectRef.Create(LAnnotDict.ObjNumber, LAnnotDict.GenNumber);
        TgtPDArray(LObj).Add(LIndRef);
      end;
    end
    else //Don't have a Annot entry, create and add one
    begin
      LIndRef := TgtPDIndirectRef.Create(LAnnotDict.ObjNumber, LAnnotDict.GenNumber);
      LArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
      LArray.Add(LIndRef);
      TgtPDDictionary(FBaseObject).Add(PDF_ANNOTS, LArray);
    end;

    //Create Attachment object to update the Page's Annot list
    LAnnot := TgtPDAnnot.MakeAnnot(FParentDoc, Self, LAnnotDict);
    GetAnnots.Add(LAnnot);
  end;

end;

procedure TgtPDPage.InsertDADictEntries(AFormField: TgtPDFormField;
  ADict: TgtPDDictionary; AFontTag: AnsiString);
//var
//  LgtPDFont: TgtPDFont;
begin
//  LgtPDFont := GetFontObject(FParentDoc, Resource,
//    TgtHackPDFormField(AFormField).Font);
  ADict.Add(PDF_DA, TgtPDString.Create('/' + AFontTag + ' ' +
    IntToStr(round((72 / 96) * (TgtHackPDFormField(AFormField).Font.Size)))
    + ' Tf ' + ColorToPDFColor(
    GetRValue(ColorToRGB(TgtHackPDFormField(AFormField).Font.Color)),
    GetGValue(ColorToRGB(TgtHackPDFormField(AFormField).Font.Color)),
    GetBValue(ColorToRGB(TgtHackPDFormField(AFormField).Font.Color))) +
    ' rg', False));
end;

procedure TgtPDPage.InsertFileAttachment(
  FileAttachment: TgtPDFileAttachmentAnnot);
var
  LAnnotDict: TgtPDDictionary;
  LArray: TgtPDArray;
  LIndRef, LObj: TgtPDBaseObject;
  LAnnotType: AnsiString;
  LDate: TgtDate;
  LAnnot: TgtPDAnnot;
begin
  //Update Last object number to use for new object
  TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber :=
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber + 1;
  //Create Annotation Dictionay (FileAttachment for this case)
  LAnnotDict := TgtPDDictionary.Create(
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber, 0,
    TgtPDDocument(FParentDoc).BaseDoc);
  //Addto collection to get it from other places (importend)
  TgtPDDocument(FParentDoc).BaseDoc.AddToCollection(LAnnotDict);

  LAnnotDict.Add(PDF_TYPE, TgtPDName.Create(PDF_ANNOT));
  LAnnotDict.Add(PDF_SUBTYPE, TgtPDName.Create(PDF_FILEATTACHMENT));
  with FileAttachment do
  begin
    case AttachmentIcon of
      faGraph: LAnnotType := PDF_GRAPH;
      faPaperclip: LAnnotType := PDF_PAPERCLIP;
      faPushPin: LAnnotType := PDF_PUSHPIN;
      faTag: LAnnotType := PDF_TAG;
    end;
    // Icon color is /C key
    FileAttachment.Color := FileAttachment.IconColor;

    //Type of the attachment Icon used
    LAnnotDict.Add(PDF_NAME, TgtPDName.Create(LAnnotType));

    AddCommonAnnotEntries(FileAttachment, LAnnotDict);

    //Set Subject
    LAnnotDict.Add(PDF_SUBJ, TgtPDString.Create(Subject));

    //Set Author
    LAnnotDict.Add(PDF_T, TgtPDString.Create(Author));

    //Set FS entry (FileSpec)
    LAnnotDict.Add(PDF_FS, CreateFileSpec(FileAttachment));

    //Set Flag
    LAnnotDict.Add(PDF_F, TgtPDInteger.Create(0));

    //Update the Page's Annot entry
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_ANNOTS);
    if Assigned(LObj) then
    begin
      if not LObj.IsArray then //Annots entry is not an array
      begin
        //Create an array object
        LArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
        //Create and Add Indirect Ref of current object to the array
        LIndRef := TgtPDIndirectRef.Create(LObj.ObjNumber, LObj.GenNumber);
        LArray.Add(LIndRef);
        //Create and add Indirect Ref of Attachment object
        LIndRef := TgtPDIndirectRef.Create(LAnnotDict.ObjNumber, LAnnotDict.GenNumber);
        LArray.Add(LIndRef);
        TgtPDDictionary(FBaseObject).SetKeyValue(PDF_ANNOTS, LArray);
      end
      else //Already an Array object, add the attachment object to array
      begin
        LIndRef := TgtPDIndirectRef.Create(LAnnotDict.ObjNumber, LAnnotDict.GenNumber);
        TgtPDArray(LObj).Add(LIndRef);
      end;
    end
    else //Don't have a Annot entry, create and add one
    begin
      LIndRef := TgtPDIndirectRef.Create(LAnnotDict.ObjNumber, LAnnotDict.GenNumber);
      LArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
      LArray.Add(LIndRef);
      TgtPDDictionary(FBaseObject).Add(PDF_ANNOTS, LArray);
    end;

    //Create Attachment object to update the Page's Annot list
    LAnnot := TgtPDAnnot.MakeAnnot(FParentDoc, Self, LAnnotDict);
    GetAnnots.Add(LAnnot);
  end;
end;

procedure TgtPDPage.InsertFreeTextAnnot(AFreeTextAnnot: TgtPDFreeTextAnnot);
var
  LObj, LIndRef: TgtPDBaseObject;
  LArray: TgtPDArray;
  LAnnot: TgtPDAnnot;
  LAnnotDict: TgtPDDictionary;
  LTextAllign: AnsiString;
  LAppearence, LColor, LFont: AnsiString;
  LFontColor: TColor;

  procedure CheckSysColor(var Color: TColor);
  const
    CgtSysColor = $FF000000;
  begin
    if (Color and CgtSysColor) = CgtSysColor then
    begin
      Color := Color and (not CgtSysColor);
      Color := GetSysColor(Color);
    end;
  end;
begin
  TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber :=
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber + 1;
  //Create Annotation Dictionay
  LAnnotDict := TgtPDDictionary.Create(
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber, 0,
    TgtPDDocument(FParentDoc).BaseDoc);
  //Addto collection to get it from other places
  TgtPDDocument(FParentDoc).BaseDoc.AddToCollection(LAnnotDict);

  LAnnotDict.Add(PDF_SUBTYPE, TgtPDName.Create(PDF_FREETEXT));
  // Add common entries like Rect, Title, Color etc..
  AddCommonAnnotEntries(AFreeTextAnnot, LAnnotDict);

  with AFreeTextAnnot do
  begin
    case TextAllign of
      ftLeftJustified: LTextAllign := PDF_LEFT;
      ftCentered: LTextAllign := PDF_CENTER;
      ftRightJustified: LTextAllign := PDF_RIGHT;
    end;
    // font:<font-style> <font-weight> <font-size> <font-family>
    LFont := 'font:';
    if fsItalic in Font.Style then
      LFont := LFont + 'italic '
    else
      LFont := LFont + 'normal ';
    if fsBold in font.Style then
      LFont := LFont + 'bold '
    else
      LFont := LFont + 'normal ';
    LFont := LFont + IntToStr(Font.Size) + 'pt ';
    LFont := LFont + Font.Name + ';';

    LAnnotDict.Add(PDF_Q, TgtPDInteger.Create(Ord(TextAllign)));
    LFontColor := Font.Color;
    CheckSysColor(LFontColor);
    LColor := IntToHex(GetRValue(LFontColor), 2) +
      IntToHex(GetGValue(LFontColor), 2) +
      IntToHex(GetBValue(LFontColor), 2);
    LAppearence := LFont + 'text-align:' + LTextAllign + ';color:#' + LColor;
    LAnnotDict.Add(PDF_DS, TgtPDString.Create(LAppearence, False));
  end;
  //Update the Page's Annot entry
  LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_ANNOTS);
  if Assigned(LObj) then
  begin
    if not LObj.IsArray then //Annots entry is not an array
    begin
      //Create an array object
      LArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
      //Create and Add Indirect Ref of current object to the array
      LIndRef := TgtPDIndirectRef.Create(LObj.ObjNumber, LObj.GenNumber);
      LArray.Add(LIndRef);
      //Create and add Indirect Ref of Line annot object
      LIndRef := TgtPDIndirectRef.Create(LAnnotDict.ObjNumber, LAnnotDict.GenNumber);
      LArray.Add(LIndRef);
      TgtPDDictionary(FBaseObject).SetKeyValue(PDF_ANNOTS, LArray);
    end
    else //Already an Array object, add the attachment object to array
    begin
      LIndRef := TgtPDIndirectRef.Create(LAnnotDict.ObjNumber, LAnnotDict.GenNumber);
      TgtPDArray(LObj).Add(LIndRef);
    end;
  end
  else //Don't have a Annot entry, create and add one
  begin
    LIndRef := TgtPDIndirectRef.Create(LAnnotDict.ObjNumber, LAnnotDict.GenNumber);
    LArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
    LArray.Add(LIndRef);
    TgtPDDictionary(FBaseObject).Add(PDF_ANNOTS, LArray);
  end;

  //Create Attachment object to update the Page's Annot list
  LAnnot := TgtPDAnnot.MakeAnnot(FParentDoc, Self, LAnnotDict);
  GetAnnots.Add(LAnnot);
end;

procedure TgtPDPage.InsertImage(AX, AY: Double; AStream: TStream;
  AImageFormat: TgtOutFormat; AInLine: Boolean;
  AWidth, AHeight: Double; AAngle: Integer);
begin
  FCurrentCS.InsertImage(AX, GetNativeYPos(AY), AStream, AImageFormat, AInLine,
    AWidth, AHeight, AAngle);
  UpdatePDStreamLength;
end;

procedure TgtPDPage.InsertInkAnnot(AinkAnnot: TgtPDInkAnnot);
var
  LObj, LIndRef: TgtPDBaseObject;
  LInkArray, LArray: TgtPDArray;
  LAnnotDict, LBorderStyleDict: TgtPDDictionary;
  LBorderStyle: AnsiString;
  LAnnot: TgtPDAnnot;
  I: Integer;
  LStringList: TStringList;
  LPageHt: Double;
begin
  TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber :=
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber + 1;
  //Create Annotation Dictionay
  LAnnotDict := TgtPDDictionary.Create(
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber, 0,
    TgtPDDocument(FParentDoc).BaseDoc);
  //Addto collection to get it from other places
  TgtPDDocument(FParentDoc).BaseDoc.AddToCollection(LAnnotDict);
  LAnnotDict.Add(PDF_SUBTYPE, TgtPDName.Create(PDF_INK));
  with AinkAnnot do
  begin
    // Add common entries like Rect, Title, Color etc..
    AddCommonAnnotEntries(AinkAnnot, LAnnotDict);

    // Add InkList
    LInkArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
    LStringList := TStringList.Create;
    LStringList.CommaText := InkList;
    LArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);

    LPageHt := GetPageHeight;
    for I := 0 to LStringList.Count - 1 do
    begin
      if (I mod 2) = 0 then
        LArray.Add(TgtPDReal.Create(StringToFloatLocale(LStringList[I])))
      else
        LArray.Add(TgtPDReal.Create(LPageHt - StringToFloatLocale(LStringList[I])));
    end;
    FreeAndNil(LStringList);
    LInkArray.Add(LArray);
    LAnnotDict.Add(PDF_INKLIST, LInkArray);

    //Update the Page's Annot entry
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_ANNOTS);
    if Assigned(LObj) then
    begin
      if not LObj.IsArray then //Annots entry is not an array
      begin
        //Create an array object
        LArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
        //Create and Add Indirect Ref of current object to the array
        LIndRef := TgtPDIndirectRef.Create(LObj.ObjNumber, LObj.GenNumber);
        LArray.Add(LIndRef);
        //Create and add Indirect Ref of Line annot object
        LIndRef := TgtPDIndirectRef.Create(LAnnotDict.ObjNumber, LAnnotDict.GenNumber);
        LArray.Add(LIndRef);
        TgtPDDictionary(FBaseObject).SetKeyValue(PDF_ANNOTS, LArray);
      end
      else //Already an Array object, add the attachment object to array
      begin
        LIndRef := TgtPDIndirectRef.Create(LAnnotDict.ObjNumber, LAnnotDict.GenNumber);
        TgtPDArray(LObj).Add(LIndRef);
      end;
    end
    else //Don't have a Annot entry, create and add one
    begin
      LIndRef := TgtPDIndirectRef.Create(LAnnotDict.ObjNumber, LAnnotDict.GenNumber);
      LArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
      LArray.Add(LIndRef);
      TgtPDDictionary(FBaseObject).Add(PDF_ANNOTS, LArray);
    end;

    //Create Attachment object to update the Page's Annot list
    LAnnot := TgtPDAnnot.MakeAnnot(FParentDoc, Self, LAnnotDict);
    GetAnnots.Add(LAnnot);
  end;
end;

procedure TgtPDPage.InsertLineAnnot(ALineAnnot: TgtPDLineAnnot);
var
  LAnnotDict, LBorderStyleDict: TgtPDDictionary;
  LArray: TgtPDArray;
//  LDate: TgtDate;
  LIndRef, LObj: TgtPDBaseObject;
  LLineEndingStyle, LLineBeginningStyle, LBorderStyle: AnsiString;
  LAnnot: TgtPDAnnot;
begin
  TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber :=
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber + 1;
  //Create Annotation Dictionay (LineAttachment for this case)
  LAnnotDict := TgtPDDictionary.Create(
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber, 0,
    TgtPDDocument(FParentDoc).BaseDoc);
  //Addto collection to get it from other places (importend)
  TgtPDDocument(FParentDoc).BaseDoc.AddToCollection(LAnnotDict);
  LAnnotDict.Add(PDF_SUBTYPE, TgtPDName.Create(PDF_LINEANNOT));
  with ALineAnnot do
  begin
    case LineEndingStyle of
      laSquare: LLineEndingStyle := PDF_Square;
      laCircle: LLineEndingStyle := PDF_CIRCLE;
      laDiamond: LLineEndingStyle := PDF_DIAMOND;
      laOpenArrow: LLineEndingStyle := PDF_OPENARROW;
      laClosedArrow: LLineEndingStyle := PDF_CLOSEDARROW;
      laNone: LLineEndingStyle := PDF_NONE;
      laButt: LLineEndingStyle := PDF_BUTT;
      laROpenArrow: LLineEndingStyle := PDF_ROPENARROW;
      laRClosedArrow: LLineEndingStyle := PDF_RCLOSEDARROW;
      laSlash: LLineEndingStyle := PDF_SLASH;
    end;
    case LineBeginningStyle of
      laSquare: LLineBeginningStyle := PDF_Square;
      laCircle: LLineBeginningStyle := PDF_CIRCLE;
      laDiamond: LLineBeginningStyle := PDF_DIAMOND;
      laOpenArrow: LLineBeginningStyle := PDF_OPENARROW;
      laClosedArrow: LLineBeginningStyle := PDF_CLOSEDARROW;
      laNone: LLineBeginningStyle := PDF_NONE;
      laButt: LLineBeginningStyle := PDF_BUTT;
      laROpenArrow: LLineBeginningStyle := PDF_ROPENARROW;
      laRClosedArrow: LLineBeginningStyle := PDF_RCLOSEDARROW;
      laSlash: LLineBeginningStyle := PDF_SLASH;
    end;

    // Add common entries like Rect, Title, Color etc..
    AddCommonAnnotEntries(ALineAnnot, LAnnotDict);
    // set Interior Color
    LArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
    LArray.Add(TgtPDReal.Create(InteriorColor.Value[0]));
    LArray.Add(TgtPDReal.Create(InteriorColor.Value[1]));
    LArray.Add(TgtPDReal.Create(InteriorColor.Value[2]));
    LAnnotDict.Add(PDF_IC, LArray);

    // set Line Coordinates

    LArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
    LArray.Add(TgtPDReal.Create(X1));
    LArray.Add(TgtPDReal.Create(GetPageHeight - Y1));
    LArray.Add(TgtPDReal.Create(X2));
    LArray.Add(TgtPDReal.Create(GetPageHeight - Y2));
    LAnnotDict.Add(PDF_L, LArray);

    // Set Line ending style
    LArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
    LArray.Add(TgtPDName.Create(LLineBeginningStyle));
    LArray.Add(TgtPDName.Create(LLineEndingStyle));
    LAnnotDict.Add(PDF_LE, LArray);

    //Update the Page's Annot entry
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_ANNOTS);
    if Assigned(LObj) then
    begin
      if not LObj.IsArray then //Annots entry is not an array
      begin
        //Create an array object
        LArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
        //Create and Add Indirect Ref of current object to the array
        LIndRef := TgtPDIndirectRef.Create(LObj.ObjNumber, LObj.GenNumber);
        LArray.Add(LIndRef);
        //Create and add Indirect Ref of Line annot object
        LIndRef := TgtPDIndirectRef.Create(LAnnotDict.ObjNumber, LAnnotDict.GenNumber);
        LArray.Add(LIndRef);
        TgtPDDictionary(FBaseObject).SetKeyValue(PDF_ANNOTS, LArray);
      end
      else //Already an Array object, add the attachment object to array
      begin
        LIndRef := TgtPDIndirectRef.Create(LAnnotDict.ObjNumber, LAnnotDict.GenNumber);
        TgtPDArray(LObj).Add(LIndRef);
      end;
    end
    else //Don't have a Annot entry, create and add one
    begin
      LIndRef := TgtPDIndirectRef.Create(LAnnotDict.ObjNumber, LAnnotDict.GenNumber);
      LArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
      LArray.Add(LIndRef);
      TgtPDDictionary(FBaseObject).Add(PDF_ANNOTS, LArray);
    end;

    //Create Attachment object to update the Page's Annot list
    LAnnot := TgtPDAnnot.MakeAnnot(FParentDoc, Self, LAnnotDict);
    GetAnnots.Add(LAnnot);

  end;
end;

procedure TgtPDPage.InsertLinkAnnot(ALinkAnnot: TgtPdLinkAnnot);
var
  LAnnotDict, LActionDict: TgtPDDictionary;
  LHLType: AnsiString;
  LArray: TgtPDArray;
  LIndRef, LObj: TgtPDBaseObject;
  LAnnot: TgtPDAnnot;
begin
  TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber :=
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber + 1;
  //Create Annotation Dictionay (LineAttachment for this case)
  LAnnotDict := TgtPDDictionary.Create(
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber, 0,
    TgtPDDocument(FParentDoc).BaseDoc);
  //Addto collection to get it from other places (important)
  TgtPDDocument(FParentDoc).BaseDoc.AddToCollection(LAnnotDict);
  LAnnotDict.Add(PDF_SUBTYPE, TgtPDName.Create(PDF_LINK));

  // Add common entries like Rect, Title, Color etc..
  AddCommonAnnotEntries(ALinkAnnot, LAnnotDict);

  case ALinkAnnot.HighLightType of
    lhInvert: LHLType := PDF_I;
    lhOutline: LHLType := PDF_O;
    lhPush: LHLType := PDF_P;
    lhNone: LHLType := PDF_N;
  end;
  // HighLight Type
  LAnnotDict.Add(PDF_H, TgtPDName.Create(LHLType));

  // Add Action
  LActionDict := TgtPDDictionary(CreateActionDict(ALinkAnnot.Action));
  LAnnotDict.Add(PDF_A, LActionDict);

    //Update the Page's Annot entry
  LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_ANNOTS);
  if Assigned(LObj) then
  begin
    if not LObj.IsArray then //Annots entry is not an array
    begin
        //Create an array object
      LArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
        //Create and Add Indirect Ref of current object to the array
      LIndRef := TgtPDIndirectRef.Create(LObj.ObjNumber, LObj.GenNumber);
      LArray.Add(LIndRef);
        //Create and add Indirect Ref of Line annot object
      LIndRef := TgtPDIndirectRef.Create(LAnnotDict.ObjNumber, LAnnotDict.GenNumber);
      LArray.Add(LIndRef);
      TgtPDDictionary(FBaseObject).SetKeyValue(PDF_ANNOTS, LArray);
    end
    else //Already an Array object, add the attachment object to array
    begin
      LIndRef := TgtPDIndirectRef.Create(LAnnotDict.ObjNumber, LAnnotDict.GenNumber);
      TgtPDArray(LObj).Add(LIndRef);
    end;
  end
  else //Don't have a Annot entry, create and add one
  begin
    LIndRef := TgtPDIndirectRef.Create(LAnnotDict.ObjNumber, LAnnotDict.GenNumber);
    LArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
    LArray.Add(LIndRef);
    TgtPDDictionary(FBaseObject).Add(PDF_ANNOTS, LArray);
  end;

    //Create Attachment object to update the Page's Annot list
  LAnnot := TgtPDAnnot.MakeAnnot(FParentDoc, Self, LAnnotDict);
  GetAnnots.Add(LAnnot);
end;

procedure TgtPDPage.InsertMarkUpAnnot(AMarkUpAnnot: TgtPDMarkUpAnnot);
var
  LAnnotDict: TgtPDDictionary;
  LObj, LIndRef: TgtPDBaseObject;
  LArray: TgtPDArray;
  LPageHt: Double;
  I: Integer;
  LStringList: TStringList;
begin
  TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber :=
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber + 1;
  //Create Annotation Dictionay (LineAttachment for this case)
  LAnnotDict := TgtPDDictionary.Create(
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber, 0,
    TgtPDDocument(FParentDoc).BaseDoc);
  //Addto collection to get it from other places (important)
  TgtPDDocument(FParentDoc).BaseDoc.AddToCollection(LAnnotDict);

  case AMarkUpAnnot.AnnotType of
    annotHighlight: LAnnotDict.Add(PDF_SUBTYPE, TgtPDName.Create(PDF_HIGHLIGHT));
    annotUnderline: LAnnotDict.Add(PDF_SUBTYPE, TgtPDName.Create(PDF_UNDERLINE));
    annotSquiggly: LAnnotDict.Add(PDF_SUBTYPE, TgtPDName.Create(PDF_SQUIGGLY));
    annotStrikeOut: LAnnotDict.Add(PDF_SUBTYPE, TgtPDName.Create(PDF_STRIKEOUT));
  end;

    // Add common entries like Rect, Title, Color etc..
  AddCommonAnnotEntries(AMarkUpAnnot, LAnnotDict);

  // set vertices
  LPageHt := GetPageHeight;
  LArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
  LStringList := TStringList.Create;
  LStringList.CommaText := AMarkUpAnnot.GetQuadPoints;
  for I := 0 to LStringList.Count - 1 do
  begin
    if (I mod 2) = 0 then   // X-Cord
      LArray.Add(TgtPDReal.Create(StringToFloatLocale(LStringList[I])))
    else // Y Cord
      LArray.Add(TgtPDReal.Create(LPageHt - StringToFloatLocale(LStringList[I])));
  end;
  FreeAndNil(LStringList);
  LAnnotDict.Add(PDF_QUADPOINTS, LArray);
  //Update the Page's Annot entry
  LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_ANNOTS);
  if Assigned(LObj) then
  begin
    if not LObj.IsArray then //Annots entry is not an array
    begin
      //Create an array object
      LArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
      //Create and Add Indirect Ref of current object to the array
      LIndRef := TgtPDIndirectRef.Create(LObj.ObjNumber, LObj.GenNumber);
      LArray.Add(LIndRef);
      //Create and add Indirect Ref of Line annot object
      LIndRef := TgtPDIndirectRef.Create(LAnnotDict.ObjNumber, LAnnotDict.GenNumber);
      LArray.Add(LIndRef);
      TgtPDDictionary(FBaseObject).SetKeyValue(PDF_ANNOTS, LArray);
    end
    else //Already an Array object, add the attachment object to array
    begin
      LIndRef := TgtPDIndirectRef.Create(LAnnotDict.ObjNumber, LAnnotDict.GenNumber);
      TgtPDArray(LObj).Add(LIndRef);
    end;
  end
  else //Don't have a Annot entry, create and add one
  begin
    LIndRef := TgtPDIndirectRef.Create(LAnnotDict.ObjNumber, LAnnotDict.GenNumber);
    LArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
    LArray.Add(LIndRef);
    TgtPDDictionary(FBaseObject).Add(PDF_ANNOTS, LArray);
  end;

  //Create Attachment object to update the Page's Annot list
  GetAnnots.Add(TgtPDAnnot.MakeAnnot(FParentDoc, Self, LAnnotDict));
end;

procedure TgtPDPage.InsertMKDictEntries(AFormField: TgtPDFormField;
  ADict: TgtPDDictionary);
var
  LArray: TgtPDArray;
  LObj: TgtPDBaseObject;
  LCh: AnsiChar;
  LValue: Integer;
begin
  //Background color
  LArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
  if not TgtHackPDFormField(AFormField).Transparent then
  begin
    LArray.Add(TgtPDReal.Create(TgtHackPDFormField(AFormField).BackgroundColor.Value[0]));
    LArray.Add(TgtPDReal.Create(TgtHackPDFormField(AFormField).BackgroundColor.Value[1]));
    LArray.Add(TgtPDReal.Create(TgtHackPDFormField(AFormField).BackgroundColor.Value[2]));
    ADict.Add(PDF_BG, LArray)
  end
  else
  begin
    ADict.Add(PDF_BG, LArray);
    LObj := TgtPDDictionary(TgtPDDocument(FParentDoc).BaseDoc.GetDocRoot).
      LookUp(PDF_ACROFORM);
    if Assigned(TgtPDDictionary(LObj).LookUp(PDF_NEEDAPPEARANCES)) then
      TgtPDDictionary(LObj).SetKeyValue(PDF_NEEDAPPEARANCES, TgtPDBoolean.Create(True))
    else
      TgtPDDictionary(LObj).Add(PDF_NeedAppearances, TgtPDBoolean.Create(True));
  end;
  //Border Color
  LArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
  LArray.Add(TgtPDReal.Create(TgtHackPDFormField(AFormField).BorderColor.Value[0]));
  LArray.Add(TgtPDReal.Create(TgtHackPDFormField(AFormField).BorderColor.Value[1]));
  LArray.Add(TgtPDReal.Create(TgtHackPDFormField(AFormField).BorderColor.Value[2]));
  ADict.Add(PDF_BC, LArray);

  //Orientation entry "R" in MK dict
  LValue := 0;
  case AFormField.Orientation of
    ffo0: LValue := 0;
    ffo90: LValue := 90;
    ffo180: LValue := 180;
    ffo270: LValue := 270;
  end;
  ADict.Add(PDF_R, TgtPDInteger.Create(LValue));

  //Btn caption
  if AFormField is TgtPDFormPushButton then
  begin
    ADict.Add(PDF_AC,
      TgtPDString.Create(TgtPDFormPushButton(AFormField).DownCaption, False));
    ADict.Add(PDF_RC,
      TgtPDString.Create(TgtPDFormPushButton(AFormField).RolloverCaption, False));
    ADict.Add(PDF_CA,
      TgtPDString.Create(TgtPDFormPushButton(AFormField).NormalCaption, False));
  end
  else if AFormField is TgtPDFormCheckBox then
  begin
    case TgtPDFormCheckBox(AFormField).Symbol of
      csCheck: LCh := '4';
      csCircle: LCh := 'l';
      csCross: LCh := '8';
      csDiamond: LCh := 'u';
      csSquare: LCh := 'n';
      csStar: LCh := 'H';
    else
      LCh := '4';
    end;
    ADict.Add(PDF_CA, TgtPDString.Create(LCh, False));
  end
end;

procedure TgtPDPage.InsertPolygonAnnot(APolygonAnnot: TgtPDPolygonAnnot);
var
  LAnnotDict, LBorderEffectDict: TgtPDDictionary;
  LArray: TgtPDArray;
  LBorderStyle: AnsiString;
  LIndRef, LObj: TgtPDBaseObject;
  LAnnot: TgtPDAnnot;
  LStringList: TStringList;
  I: Integer;
  LPageHt: Double;
begin
  TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber :=
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber + 1;
  //Create Annotation Dictionay (LineAttachment for this case)
  LAnnotDict := TgtPDDictionary.Create(
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber, 0,
    TgtPDDocument(FParentDoc).BaseDoc);
  //Addto collection to get it from other places (important)
  TgtPDDocument(FParentDoc).BaseDoc.AddToCollection(LAnnotDict);
  LAnnotDict.Add(PDF_SUBTYPE, TgtPDName.Create(PDF_POLYGON));
  with APolygonAnnot do
  begin
    // Add common entries like Rect, Title, Color etc..
    AddCommonAnnotEntries(APolygonAnnot, LAnnotDict);

    // set Interior Color
    LArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
    LArray.Add(TgtPDReal.Create(InteriorColor.Value[0]));
    LArray.Add(TgtPDReal.Create(InteriorColor.Value[1]));
    LArray.Add(TgtPDReal.Create(InteriorColor.Value[2]));
    LAnnotDict.Add(PDF_IC, LArray);

    // Set Border Effect Dict
    LBorderEffectDict := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);
    if IsCloudy then
      LBorderEffectDict.Add(PDF_S, TgtPDName.Create(PDF_C))
    else
      LBorderEffectDict.Add(PDF_S, TgtPDName.Create(PDF_S));
    LBorderEffectDict.Add(PDF_I, TgtPDReal.Create(Intensity));
    LAnnotDict.Add(PDF_BE, LBorderEffectDict);

    // set vertices
    LPageHt := GetPageHeight;
    LArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
    LStringList := TStringList.Create;
    LStringList.CommaText := GetVertices;
    for I := 0 to LStringList.Count - 1 do
    begin
      if (I mod 2) = 0 then   // X-Cord
        LArray.Add(TgtPDReal.Create(StringToFloatLocale(LStringList[I])))
      else // Y Cord
        LArray.Add(TgtPDReal.Create(LPageHt - StringToFloatLocale(LStringList[I])));
    end;
    FreeAndNil(LStringList);
    LAnnotDict.Add(PDF_VERTICES, LArray);

    //Update the Page's Annot entry
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_ANNOTS);
    if Assigned(LObj) then
    begin
      if not LObj.IsArray then //Annots entry is not an array
      begin
        //Create an array object
        LArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
        //Create and Add Indirect Ref of current object to the array
        LIndRef := TgtPDIndirectRef.Create(LObj.ObjNumber, LObj.GenNumber);
        LArray.Add(LIndRef);
        //Create and add Indirect Ref of Line annot object
        LIndRef := TgtPDIndirectRef.Create(LAnnotDict.ObjNumber, LAnnotDict.GenNumber);
        LArray.Add(LIndRef);
        TgtPDDictionary(FBaseObject).SetKeyValue(PDF_ANNOTS, LArray);
      end
      else //Already an Array object, add the attachment object to array
      begin
        LIndRef := TgtPDIndirectRef.Create(LAnnotDict.ObjNumber, LAnnotDict.GenNumber);
        TgtPDArray(LObj).Add(LIndRef);
      end;
    end
    else //Don't have a Annot entry, create and add one
    begin
      LIndRef := TgtPDIndirectRef.Create(LAnnotDict.ObjNumber, LAnnotDict.GenNumber);
      LArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
      LArray.Add(LIndRef);
      TgtPDDictionary(FBaseObject).Add(PDF_ANNOTS, LArray);
    end;

    //Create Attachment object to update the Page's Annot list
    LAnnot := TgtPDAnnot.MakeAnnot(FParentDoc, Self, LAnnotDict);
    GetAnnots.Add(LAnnot);
  end;
end;

procedure TgtPDPage.InsertPolyLineAnnot(APolylineAnnot: TgtPDPolyLineAnnot);
var
  LAnnotDict, LBorderStyleDict: TgtPDDictionary;
  LArray: TgtPDArray;
  LBorderStyle: AnsiString;
  LIndRef, LObj: TgtPDBaseObject;
  LAnnot: TgtPDAnnot;
  LStringList: TStringList;
  I: Integer;
  LPageHt: Double;
  LLineEndingStyle, LLineBeginningStyle: Ansistring;
begin
  TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber :=
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber + 1;
  //Create Annotation Dictionay
  LAnnotDict := TgtPDDictionary.Create(
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber, 0,
    TgtPDDocument(FParentDoc).BaseDoc);
  //Addto collection to get it from other places (important)
  TgtPDDocument(FParentDoc).BaseDoc.AddToCollection(LAnnotDict);
  LAnnotDict.Add(PDF_SUBTYPE, TgtPDName.Create(PDF_POLYLINE));
  with APolylineAnnot do
  begin
    case LineEndingStyle of
      laSquare: LLineEndingStyle := PDF_Square;
      laCircle: LLineEndingStyle := PDF_CIRCLE;
      laDiamond: LLineEndingStyle := PDF_DIAMOND;
      laOpenArrow: LLineEndingStyle := PDF_OPENARROW;
      laClosedArrow: LLineEndingStyle := PDF_CLOSEDARROW;
      laNone: LLineEndingStyle := PDF_NONE;
      laButt: LLineEndingStyle := PDF_BUTT;
      laROpenArrow: LLineEndingStyle := PDF_ROPENARROW;
      laRClosedArrow: LLineEndingStyle := PDF_RCLOSEDARROW;
      laSlash: LLineEndingStyle := PDF_SLASH;
    end;
    case LineBeginningStyle of
      laSquare: LLineBeginningStyle := PDF_Square;
      laCircle: LLineBeginningStyle := PDF_CIRCLE;
      laDiamond: LLineBeginningStyle := PDF_DIAMOND;
      laOpenArrow: LLineBeginningStyle := PDF_OPENARROW;
      laClosedArrow: LLineBeginningStyle := PDF_CLOSEDARROW;
      laNone: LLineBeginningStyle := PDF_NONE;
      laButt: LLineBeginningStyle := PDF_BUTT;
      laROpenArrow: LLineBeginningStyle := PDF_ROPENARROW;
      laRClosedArrow: LLineBeginningStyle := PDF_RCLOSEDARROW;
      laSlash: LLineBeginningStyle := PDF_SLASH;
    end;
    // Add common entries like Rect, Title, Color etc..
    AddCommonAnnotEntries(APolylineAnnot, LAnnotDict);
   // set Interior Color
    LArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
    LArray.Add(TgtPDReal.Create(InteriorColor.Value[0]));
    LArray.Add(TgtPDReal.Create(InteriorColor.Value[1]));
    LArray.Add(TgtPDReal.Create(InteriorColor.Value[2]));
    LAnnotDict.Add(PDF_IC, LArray);
    
    // Set Line ending style
    LArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
    LArray.Add(TgtPDName.Create(LLineBeginningStyle));
    LArray.Add(TgtPDName.Create(LLineEndingStyle));
    LAnnotDict.Add(PDF_LE, LArray);
    
    // set vertices
    LPageHt := GetPageHeight;
    LArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
    LStringList := TStringList.Create;
    LStringList.CommaText := GetVertices;
    for I := 0 to LStringList.Count - 1 do
    begin
      if (I Mod 2) = 0 then
        LArray.Add(TgtPDReal.Create(StringToFloatLocale(LStringList[I])))
      else
        LArray.Add(TgtPDReal.Create(LPageHt - StringToFloatLocale(LStringList[I])));
    end;
    FreeAndNil(LStringList);
    LAnnotDict.Add(PDF_VERTICES, LArray);


    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_ANNOTS);
    if Assigned(LObj) then
    begin
      if not LObj.IsArray then //Annots entry is not an array
      begin
        //Create an array object
        LArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
        //Create and Add Indirect Ref of current object to the array
        LIndRef := TgtPDIndirectRef.Create(LObj.ObjNumber, LObj.GenNumber);
        LArray.Add(LIndRef);
        //Create and add Indirect Ref of Line annot object
        LIndRef := TgtPDIndirectRef.Create(LAnnotDict.ObjNumber, LAnnotDict.GenNumber);
        LArray.Add(LIndRef);
        TgtPDDictionary(FBaseObject).SetKeyValue(PDF_ANNOTS, LArray);
      end
      else //Already an Array object, add the attachment object to array
      begin
        LIndRef := TgtPDIndirectRef.Create(LAnnotDict.ObjNumber, LAnnotDict.GenNumber);
        TgtPDArray(LObj).Add(LIndRef);
      end;
    end
    else //Don't have a Annot entry, create and add one
    begin
      LIndRef := TgtPDIndirectRef.Create(LAnnotDict.ObjNumber, LAnnotDict.GenNumber);
      LArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
      LArray.Add(LIndRef);
      TgtPDDictionary(FBaseObject).Add(PDF_ANNOTS, LArray);
    end;

    //Create Attachment object to update the Page's Annot list
    LAnnot := TgtPDAnnot.MakeAnnot(FParentDoc, Self, LAnnotDict);
    GetAnnots.Add(LAnnot);
  end;
end;

procedure TgtPDPage.InsertSqaureAnnot(ASquareAnnot: TgtPDSquareAnnot);
var
  LAnnotDict, LBorderStyleDict, LBorderEffectDict: TgtPDDictionary;
  LArray: TgtPDArray;
  LBorderStyle: AnsiString;
  LIndRef, LObj: TgtPDBaseObject;
  LAnnot: TgtPDAnnot;
begin
  TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber :=
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber + 1;
  //Create Annotation Dictionay (LineAttachment for this case)
  LAnnotDict := TgtPDDictionary.Create(
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber, 0,
    TgtPDDocument(FParentDoc).BaseDoc);
  //Addto collection to get it from other places (important)
  TgtPDDocument(FParentDoc).BaseDoc.AddToCollection(LAnnotDict);
  LAnnotDict.Add(PDF_SUBTYPE, TgtPDName.Create(PDF_SQUARE));
  with ASquareAnnot do
  begin
    case BorderStyle of
      absSolid: LBorderStyle := PDF_S;
      absDashed: LBorderStyle := PDF_D;
      absBeveled: LBorderStyle := PDF_B;
      absInset: LBorderStyle := PDF_I;
      absUnderline: LBorderStyle := PDF_U;
    end;
    // Add common entries like Rect, Title, Color etc..
    AddCommonAnnotEntries(ASquareAnnot, LAnnotDict);
    // set Interior Color
    LArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
    LArray.Add(TgtPDReal.Create(InteriorColor.Value[0]));
    LArray.Add(TgtPDReal.Create(InteriorColor.Value[1]));
    LArray.Add(TgtPDReal.Create(InteriorColor.Value[2]));
    LAnnotDict.Add(PDF_IC, LArray);

    // Set Border Effect Dict
    LBorderEffectDict := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);
    if IsCloudy then
      LBorderEffectDict.Add(PDF_S, TgtPDName.Create(PDF_C))
    else
      LBorderEffectDict.Add(PDF_S, TgtPDName.Create(PDF_S));
    LBorderEffectDict.Add(PDF_I, TgtPDReal.Create(Intensity));
    LAnnotDict.Add(PDF_BE, LBorderEffectDict);

    //Update the Page's Annot entry
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_ANNOTS);
    if Assigned(LObj) then
    begin
      if not LObj.IsArray then //Annots entry is not an array
      begin
        //Create an array object
        LArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
        //Create and Add Indirect Ref of current object to the array
        LIndRef := TgtPDIndirectRef.Create(LObj.ObjNumber, LObj.GenNumber);
        LArray.Add(LIndRef);
        //Create and add Indirect Ref of Line annot object
        LIndRef := TgtPDIndirectRef.Create(LAnnotDict.ObjNumber, LAnnotDict.GenNumber);
        LArray.Add(LIndRef);
        TgtPDDictionary(FBaseObject).SetKeyValue(PDF_ANNOTS, LArray);
      end
      else //Already an Array object, add the attachment object to array
      begin
        LIndRef := TgtPDIndirectRef.Create(LAnnotDict.ObjNumber, LAnnotDict.GenNumber);
        TgtPDArray(LObj).Add(LIndRef);
      end;
    end
    else //Don't have a Annot entry, create and add one
    begin
      LIndRef := TgtPDIndirectRef.Create(LAnnotDict.ObjNumber, LAnnotDict.GenNumber);
      LArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
      LArray.Add(LIndRef);
      TgtPDDictionary(FBaseObject).Add(PDF_ANNOTS, LArray);
    end;

    //Create Attachment object to update the Page's Annot list
    LAnnot := TgtPDAnnot.MakeAnnot(FParentDoc, Self, LAnnotDict);
    GetAnnots.Add(LAnnot);
  end;
end;

procedure TgtPDPage.InsertStampAnnot(AStampAnnot: TgtPDRubberStampAnnot);
var
  LAnnotDict, LBorderStyleDict: TgtPDDictionary;
  LIndRef, LObj: TgtPDBaseObject;
  LAnnot: TgtPDAnnot;
  LArray: TgtPDArray;
  LBorderStyle: AnsiString;
begin
  TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber :=
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber + 1;
  //Create Annotation Dictionay (LineAttachment for this case)
  LAnnotDict := TgtPDDictionary.Create(
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber, 0,
    TgtPDDocument(FParentDoc).BaseDoc);
  //Addto collection to get it from other places (important)
  TgtPDDocument(FParentDoc).BaseDoc.AddToCollection(LAnnotDict);
  LAnnotDict.Add(PDF_SUBTYPE, TgtPDName.Create(PDF_STAMP));
//  LAnnotDict.Add(PDF_NAME, TgtPDName.Create('Draft'));

  // Add common entries like Rect, Title, Color etc..

  AddCommonAnnotEntries(AStampAnnot, LAnnotDict);
  
  //Update the Page's Annot entry
  LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_ANNOTS);
  if Assigned(LObj) then
  begin
    if not LObj.IsArray then //Annots entry is not an array
    begin
      //Create an array object
      LArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
      //Create and Add Indirect Ref of current object to the array
      LIndRef := TgtPDIndirectRef.Create(LObj.ObjNumber, LObj.GenNumber);
      LArray.Add(LIndRef);
      //Create and add Indirect Ref of Line annot object
      LIndRef := TgtPDIndirectRef.Create(LAnnotDict.ObjNumber, LAnnotDict.GenNumber);
      LArray.Add(LIndRef);
      TgtPDDictionary(FBaseObject).SetKeyValue(PDF_ANNOTS, LArray);
    end
    else //Already an Array object, add the attachment object to array
    begin
      LIndRef := TgtPDIndirectRef.Create(LAnnotDict.ObjNumber, LAnnotDict.GenNumber);
      TgtPDArray(LObj).Add(LIndRef);
    end;
  end
  else //Don't have a Annot entry, create and add one
  begin
    LIndRef := TgtPDIndirectRef.Create(LAnnotDict.ObjNumber, LAnnotDict.GenNumber);
    LArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
    LArray.Add(LIndRef);
    TgtPDDictionary(FBaseObject).Add(PDF_ANNOTS, LArray);
  end;

  //Create Attachment object to update the Page's Annot list
  LAnnot := TgtPDAnnot.MakeAnnot(FParentDoc, Self, LAnnotDict);
  GetAnnots.Add(LAnnot);
end;

procedure TgtPDPage.InsertTextAnnot(ATextAnnot: TgtPDTextAnnot);
var
  LObj, LIndRef: TgtPDBaseObject;
  LAnnotDict, LBorderStyleDict: TgtPDDictionary;
  LAnnot: TgtPDAnnot;
  LArray: TgtPDArray;
  LBorderStyle: AnsiString;
begin
  TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber :=
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber + 1;
  //Create Annotation Dictionay (LineAttachment for this case)
  LAnnotDict := TgtPDDictionary.Create(
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber, 0,
    TgtPDDocument(FParentDoc).BaseDoc);
  //Addto collection to get it from other places (important)
  TgtPDDocument(FParentDoc).BaseDoc.AddToCollection(LAnnotDict);
  LAnnotDict.Add(PDF_SUBTYPE, TgtPDName.Create(PDF_TEXTANNOT));

  // Add common entries like Rect, Title, Color etc..

  AddCommonAnnotEntries(ATextAnnot, LAnnotDict);
  with ATextAnnot do
  begin
    LAnnotDict.Add(PDF_OPEN, TgtPDBoolean.Create(Open));
    // Annotation flag, add in common entries

//
  end;

  //Update the Page's Annot entry
  LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_ANNOTS);
  if Assigned(LObj) then
  begin
    if not LObj.IsArray then //Annots entry is not an array
    begin
      //Create an array object
      LArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
      //Create and Add Indirect Ref of current object to the array
      LIndRef := TgtPDIndirectRef.Create(LObj.ObjNumber, LObj.GenNumber);
      LArray.Add(LIndRef);
      //Create and add Indirect Ref of Line annot object
      LIndRef := TgtPDIndirectRef.Create(LAnnotDict.ObjNumber, LAnnotDict.GenNumber);
      LArray.Add(LIndRef);
      TgtPDDictionary(FBaseObject).SetKeyValue(PDF_ANNOTS, LArray);
    end
    else //Already an Array object, add the attachment object to array
    begin
      LIndRef := TgtPDIndirectRef.Create(LAnnotDict.ObjNumber, LAnnotDict.GenNumber);
      TgtPDArray(LObj).Add(LIndRef);
    end;
  end
  else //Don't have a Annot entry, create and add one
  begin
    LIndRef := TgtPDIndirectRef.Create(LAnnotDict.ObjNumber, LAnnotDict.GenNumber);
    LArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
    LArray.Add(LIndRef);
    TgtPDDictionary(FBaseObject).Add(PDF_ANNOTS, LArray);
  end;

  //Create Attachment object to update the Page's Annot list
  LAnnot := TgtPDAnnot.MakeAnnot(FParentDoc, Self, LAnnotDict);
  GetAnnots.Add(LAnnot);

end;

procedure TgtPDPage.LineTo(AX, AY: Double; isNative: Boolean);
begin
  if isNative then
  begin
    FCurrentCS.LineTo(AX,AY);
    UpdatePDStreamLength;
  end
  else
  begin
    LineTo(AX,AY);
  end;
end;

procedure TgtPDPage.LineTo(AX, AY: Double);
begin
  FCurrentCS.LineTo(AX, GetNativeYPos(AY));
  UpdatePDStreamLength;
end;


procedure TgtPDPage.MakeBox(hDPI, vDPI: Double; Rotate: Integer; UseMediaBox,
  UpsideDown: Boolean; SliceX, SliceY, SliceW, SliceH: Integer;
  Box: TgtPDRect; var Crop: Boolean);
var
  LBaseBox: TgtPDRect;
  xDPI, yDPI: Double;
begin
  if (SliceW >= 0) and (SliceH >= 0) then
  begin
    if UseMediaBox then
      LBaseBox := Mediabox
    else
      LBaseBox := Cropbox;

    xDPI := 72.0 / hDPI;
    yDPI := 72.0 / vDPI;

    if Rotate = 90 then
    begin
      if UpsideDown then
      begin
        Box.Left := LBaseBox.Left + yDPI * SliceY;
        Box.Right := LBaseBox.Left + yDPI * (SliceY + SliceH);
      end
      else
      begin
        Box.Left := LBaseBox.Right - yDPI * (SliceY + SliceH);
        Box.Right := LBaseBox.Right - yDPI * SliceY;
      end;
      Box.Top := LBaseBox.Top + xDPI * SliceX;
      Box.Bottom := LBaseBox.Top + xDPI * (SliceX + SliceW);
    end
    else if Rotate = 180 then
    begin
      Box.Left := LBaseBox.Right - xDPI * (SliceX + SliceW);
      Box.Right := LBaseBox.Right - xDPI * SliceX;
      if upsideDown then
      begin
        Box.Top := LBaseBox.Top + yDPI * SliceY;
        Box.Bottom := LBaseBox.Top + yDPI * (SliceY + SliceH);
      end
      else
      begin
        Box.Top := LBaseBox.Bottom - yDPI * (SliceY + SliceH);
        Box.Bottom := LBaseBox.Bottom - yDPI * SliceY;
      end;
    end
    else if Rotate = 270 then
    begin
      if (UpsideDown) then
      begin
        Box.Left := LBaseBox.Right - yDPI * (SliceY + SliceH);
        Box.Right := LBaseBox.Right - yDPI * SliceY;
      end
      else
      begin
        Box.Left := LBaseBox.Left + yDPI * SliceY;
        Box.Right := LBaseBox.Left + yDPI * (SliceY + SliceH);
      end;
      Box.Top := LBaseBox.Bottom - xDPI * (SliceX + SliceW);
      Box.Bottom := LBaseBox.Bottom - xDPI * SliceX;
    end
    else
    begin
      Box.Left := LBaseBox.Left + xDPI * SliceX;
      Box.Right := LBaseBox.Left + xDPI * (SliceX + SliceW);
      if (UpsideDown) then
      begin
        Box.Top := LBaseBox.Bottom - yDPI * (SliceY + SliceH);
        Box.Bottom := LBaseBox.Bottom - yDPI * SliceY;
      end
      else
      begin
        Box.Top := LBaseBox.Top + yDPI * SliceY;
        Box.Bottom := LBaseBox.Top + yDPI * (SliceY + SliceH);
      end;
    end;
  end
  else if UseMediaBox then
  begin
    Box.Assign(Mediabox);
  end
  else
  begin
    Box.Assign(Cropbox);
    Crop := True;
  end;
end;

procedure TgtPDPage.MoveTo(AX, AY: Double);
begin
  FCurrentCS.MoveTo(AX, GetNativeYPos(AY));
  UpdatePDStreamLength;
end;

procedure TgtPDPage.MoveTo(AX, AY: Double; isNative: Boolean);
begin
   if isNative then
   begin
    FCurrentCS.MoveTo(AX,AY);
  UpdatePDStreamLength;
   end
   else
   begin
     MoveTo(AX,AY);
   end;
end;


procedure TgtPDPage.PolyDraw(AObject: TgtPolyDrawItem);
var
  LI: Integer;
begin
  if not Assigned(FContents) then
    SetRenderMode(rmOverLay);

  with AObject do
  begin
    LI := 0;
      while LI < FNoPoints  do
      begin
        case FOperations[LI] of
          PT_MOVETO:
            begin
              MoveTo(FPoints[LI].X,FPoints[LI].Y);
              LI := LI + 1;
            end;
          PT_LINETO:
            begin
              LineTo(FPoints[LI].X,FPoints[LI].Y);
              LI := LI + 1;
            end;
          PT_BEZIERTO:
            begin
              curveTo(FPoints[LI].X,FPoints[LI].Y,
                FPoints[LI + 1].X,FPoints[LI+1].Y,
                FPoints[LI + 2].X,FPoints[LI+2].Y);
              LI := LI + 3;
            end;
          PT_LINETO or PT_CLOSEFIGURE:
            begin
              LineTo(FPoints[LI].X,FPoints[LI].Y);
              LI := LI + 1;
            end;
          PT_BEZIERTO or PT_CLOSEFIGURE:
          begin
            LI := LI + 1;
          end;
        end;
      end;
    end;
   StrokePath;
end;

procedure TgtPDPage.ProcessLinks(OutDev: TgtPDExportDevice;
  Catatlog: TgtPDElement);
begin

end;

//function TgtPDPage.GetPageBaseObject(PageNumber: Integer): TgtPDBaseObject;
//begin
//
//end;

(**
  * Completely replaces the contents of the specified page with NewContents.
  *
  * @param  NewContents A stream Base object or an array Base object containing
  *         the new contents (stream Base objects) for page.
  *
  *)

function TgtPDPage.RadiansToDegrees(Radians: Extended): Extended;
begin
  Result := Radians * (180 / PI);
end;

procedure TgtPDPage.Rectangle(X1, Y1, X2, Y2: Double);
begin
  FCurrentCS.Rectangle(X1, GetNativeYPos(Y1), X2, GetNativeYPos(Y2));
  UpdatePDStreamLength;
end;

procedure TgtPDPage.RemoveFormField(Index: Integer);
var
  LAcroForms, LAcroFormDict, LKids, LFieldKids, LAnnots: TgtPDBaseObject;
  LFormField: TgtPDFormField;
  LObjNo: Cardinal;
  LKidCount: Integer;

  procedure DeleteField; overload;
  var
    K: Integer;
  begin
    // check for kids
    LKids := TgtPDDictionary(LFormField.BaseObject).LookUp(PDF_KIDS);
    if Assigned(LKids) and LKids.IsArray then
    begin
      // its a radio button.
      LKidCount := TgtPDArray(LKids).GetLength;
      Dec(LKidCount);
      // delete from Annots array of page
      while (LKidCount >= 0) do
      begin
        for K := 0 to TgtPDArray(LAnnots).GetLength - 1 do
        begin
          if TgtPDDictionary(TgtPDArray(LAnnots).Get(K)).ObjNumber =
            TgtPDArray(LKids).Get(LKidCount).ObjNumber then
          begin
            TgtPDArray(LAnnots).Remove(K);
            Break;
          end;
        end;
        Dec(LKidCount);
      end;
    end;
    // No Kids
    // Delete from Page Annot list
    for K := 0 to FAnnotList.Count - 1 do
    begin
      if LObjNo = TgtPDAnnot(FAnnotList[K]).BaseObject.ObjNumber then
      begin
        //LObj := TgtPDBaseObject(FAnnotList[K]);
        FAnnotList.Delete(K);
        FAnnotList.Capacity := FAnnotList.Count;
        Break;
      end;
    end;

    // delete from Annots array of page
    for K := 0 to TgtPDArray(LAnnots).GetLength - 1 do
    begin
      if TgtPDDictionary(TgtPDArray(LAnnots).Get(K)).ObjNumber = LObjNo then
      begin
        TgtPDArray(LAnnots).Remove(K);
        Break;
      end;
    end;
  end;

  procedure DeleteField(AObj: TgtPDBaseObject); overload;
  var
    LI: Integer;
  begin
    for LI := (TgtPDArray(AObj).GetLength - 1) downto 0 do
    begin
      if (LObjNo = TgtPDArray(AObj).Get(LI).ObjNumber) then
      begin
        DeleteField;
        // delete from catalog dict
        TgtPDArray(AObj).Remove(LI);
        Exit;
      end
      else
      begin
        //if each field dict contains a Kids entry
        LFieldKids := TgtPDDictionary(TgtPDArray(AObj).Get(LI)).LookUp(PDF_KIDS);
        if Assigned(LFieldKids) and LFieldKids.IsArray then
        begin
          DeleteField(LFieldKids);
        end;
      end
    end;
  end;

begin
  LFormField := GetFormField(Index);

  // object num of FormField from page Annots
  LObjNo := LFormField.BaseObject.ObjNumber;

  // Acroformfield from catalog
  LAcroFormDict := TgtPDCatalog(TgtPDPageTree(FParentElement).ParentElement).AcroFormField;

  LAcroForms := TgtPDDictionary(LAcroFormDict).LookUp(PDF_FIELDS);

  // Get Annot list from page
  LAnnots := TgtPDDictionary(BaseObject).LookUp(PDF_Annots);

  if Assigned(LAcroForms) and (LAcroForms.IsArray) then
  begin
    DeleteField(LAcroForms);
  end;

end;

procedure TgtPDPage.RemoveAction(ATriggerType: TgtPageActionTrigger);
var
  LObj: TgtPDBaseObject;
begin
  LObj := TgtPDDictionary(BaseObject).LookUp(PDF_AA);
  if Assigned(LObj) and LObj.IsDict then
  begin
    if ATriggerType = atBeforePageOpen then
      TgtPDDictionary(LObj).Remove(PDF_O)
    else if ATriggerType = atAfterPageClose then
      TgtPDDictionary(LObj).Remove(PDF_C);
  end;
end;

//procedure TgtPDPage.RemoveFormField(AFieldName: AnsiString);
//var
//  LAcroForms, LAcroFormDict, LKids, LAnnots: TgtPDBaseObject;
//  LFormField: TgtPDFormField;
//  LObjNo: Cardinal;
//  I, K, LKidCount: Integer;
//  LXFAObj: TgtPDXFADocument;
//begin
//  LFormField := GetFormField(AFieldName);
//
//  // object num of FormField from page Annots
//  LObjNo := LFormField.BaseObject.ObjNumber;
//
//  // Acroformfield from catalog
//  LAcroFormDict := TgtPDCatalog(TgtPDPageTree(FParentElement).ParentElement).AcroFormField;
//
//  LAcroForms := TgtPDDictionary(LAcroFormDict).LookUp(PDF_FIELDS);
//
//  // Get Annot list from page
//  LAnnots := TgtPDDictionary(BaseObject).LookUp(PDF_Annots);
//
//  if Assigned(LAcroForms) and (LAcroForms.IsArray) then
//  begin
//    for I := (TgtPDArray(LAcroForms).GetLength - 1) downto 0 do
//    begin
//      if LObjNo = TgtPDDictionary(TgtPDArray(LAcroForms).Get(I)).ObjNumber then
//      begin
//        // check for kids
//        LKids := TgtPDDictionary(LFormField.BaseObject).LookUp(PDF_KIDS);
//        if Assigned(LKids) and LKids.IsArray then
//        begin
//          // its a radio button.
//          LKidCount := TgtPDArray(LKids).GetLength;
//          Dec(LKidCount);
//          // delete from Annots array of page
//          while (LKidCount >= 0) do
//          begin
//            for K := 0 to TgtPDArray(LAnnots).GetLength - 1 do
//            begin
//              if TgtPDDictionary(TgtPDArray(LAnnots).Get(K)).ObjNumber =
//                TgtPDArray(LKids).Get(LKidCount).ObjNumber then
//              begin
//                TgtPDArray(LAnnots).Remove(K);
//                Dec(LKidCount);
//                Break;
//              end;
//            end;
//          end;
//        end;
//        // No Kids
//        // Delete from Page Annot list
//        for K := 0 to FAnnotList.Count - 1 do
//        begin
//          if LObjNo = TgtPDAnnot(FAnnotList[K]).BaseObject.ObjNumber then
//          begin
////            LObj := TgtPDBaseObject(FAnnotList[K]);
//            FAnnotList.Delete(K);
//            FAnnotList.Capacity := FAnnotList.Count;
//            Break;
//          end;
//        end;
//
//        // delete from Annots array of page
//        for K := 0 to TgtPDArray(LAnnots).GetLength - 1 do
//        begin
//          if TgtPDDictionary(TgtPDArray(LAnnots).Get(K)).ObjNumber = LObjNo then
//          begin
//            TgtPDArray(LAnnots).Remove(K);
//            Break;
//          end;
//        end;
//
//        // delete from catalog dict
//        TgtPDArray(LAcroForms).Remove(I);
//      end;
//    end;
//  end;
//
//  LXFAObj := TgtHackPDFormField(LFormField).XFA;
//  if Assigned(LXFAObj) then
//  begin
//    LXFAObj.DeleteNodeAt(LXFAObj.TempRootNode, AFieldName);
//  end;
//end;

procedure TgtPDPage.RemoveFormField(AFieldName: AnsiString);
var
  LAcroForms, LAcroFormDict, LKids, LFieldKids, LAnnots: TgtPDBaseObject;
  LFormField: TgtPDFormField;
  LObjNo: Cardinal;
  LKidCount: Integer;
  {$IFNDEF DELPHI5}
  LXFAObj: TgtPDXFADocument;
  {$ENDIF}

  procedure DeleteField; overload;
  var
    K: Integer;
  begin
    // check for kids
    LKids := TgtPDDictionary(LFormField.BaseObject).LookUp(PDF_KIDS);
    if Assigned(LKids) and LKids.IsArray then
    begin
      // its a radio button.
      LKidCount := TgtPDArray(LKids).GetLength;
      Dec(LKidCount);
      // delete from Annots array of page
      while (LKidCount >= 0) do
      begin
        for K := 0 to TgtPDArray(LAnnots).GetLength - 1 do
        begin
          if TgtPDDictionary(TgtPDArray(LAnnots).Get(K)).ObjNumber =
            TgtPDArray(LKids).Get(LKidCount).ObjNumber then
          begin
            TgtPDArray(LAnnots).Remove(K);
            Dec(LKidCount);
            Break;
          end;
        end;
      end;
    end;
    // No Kids
    // Delete from Page Annot list
    for K := 0 to FAnnotList.Count - 1 do
    begin
      if LObjNo = TgtPDAnnot(FAnnotList[K]).BaseObject.ObjNumber then
      begin
        //LObj := TgtPDBaseObject(FAnnotList[K]);
        FAnnotList.Delete(K);
        FAnnotList.Capacity := FAnnotList.Count;
        Break;
      end;
    end;

    // delete from Annots array of page
    for K := 0 to TgtPDArray(LAnnots).GetLength - 1 do
    begin
      if TgtPDDictionary(TgtPDArray(LAnnots).Get(K)).ObjNumber = LObjNo then
      begin
        TgtPDArray(LAnnots).Remove(K);
        Break;
      end;
    end;
  end;

  procedure DeleteField(AObj: TgtPDBaseObject); overload;
  var
    LI: Integer;
  begin
    for LI := (TgtPDArray(AObj).GetLength - 1) downto 0 do
    begin
      if (LObjNo = TgtPDArray(AObj).Get(LI).ObjNumber) then
      begin
        DeleteField;
        // delete from catalog dict
        TgtPDArray(AObj).Remove(LI);
        Dec(FFormFieldCount);
        Exit;
      end
      else
      begin
        //if each field dict contains a Kids entry
        LFieldKids := TgtPDDictionary(TgtPDArray(AObj).Get(LI)).LookUp(PDF_KIDS);
        if Assigned(LFieldKids) and LFieldKids.IsArray then
        begin
          DeleteField(LFieldKids);
        end;
      end
    end;
  end;

begin
  LFormField := GetFormField(AFieldName);

  // object num of FormField from page Annots
  LObjNo := LFormField.BaseObject.ObjNumber;

  // Acroformfield from catalog
  LAcroFormDict := TgtPDCatalog(TgtPDPageTree(FParentElement).ParentElement).AcroFormField;

  LAcroForms := TgtPDDictionary(LAcroFormDict).LookUp(PDF_FIELDS);

  // Get Annot list from page
  LAnnots := TgtPDDictionary(BaseObject).LookUp(PDF_Annots);

  if Assigned(LAcroForms) and (LAcroForms.IsArray) then
  begin
    DeleteField(LAcroForms);
  end;

  {$IFNDEF DELPHI5}
  LXFAObj := TgtHackPDFormField(LFormField).XFA;
  if Assigned(LXFAObj) then
  begin
    AFieldName := TgtHackPDFormField(LFormField).SubStr(AFieldName, '[');
    LXFAObj.DeleteNodeInTemplate(LXFAObj.TempRootNode, AFieldName);
    LXFAObj.DeleteNodeInDataSets(LXFAObj.DataRootNode, AFieldName);
  end;
  {$ENDIF}
end;


procedure TgtPDPage.RenderAnnots(OutDev: TgtPDExportDevice; hDPI, vDPI: Double;
  PageRect: TgtPDRect);
var
  LAnnots: TgtPDBaseObject;
  LObj1, LFormField, LObj2: TgtPDBaseObject;
  I, J: Integer;
  LRendered: Boolean;
  LValue: AnsiString;
begin
  FRenderedFields := TList.Create;
  try
    LAnnots := TgtPDDictionary(FBaseObject).LookUp(PDF_ANNOTS);
    if Assigned(LAnnots) and LAnnots.IsArray then
    begin
      for I := 0 to TgtPDArray(LAnnots).GetLength - 1 do
      begin
        LObj1 := TgtPDArray(LAnnots).Get(I);
        LValue := FindInAcroForms(LObj1.ObjNumber);
        RenderField(LObj1, LValue, OutDev, hDPI, vDPI, PageRect);
      end;
    end;
  finally
    FRenderedFields.Free;
  end;
end;

type
  THackState = class(TgtPDState)
  
  end;

procedure TgtPDPage.RenderField(FormField: TgtPDBaseObject; const Value: AnsiString; 
  OutDev: TgtPDExportDevice; hDPI, vDPI: Double; PageRect: TgtPDRect);
var
  LAP: TgtPDAppearanceStream;
  LState: TgtPDState;
  LObj1, LObj2, LObj3: TgtPDBaseObject;
  I: Integer;
  LValue: AnsiString;
  Y: Double;
  Flag: Integer;
begin
  FRenderedFields.Add(TObject(FormField.ObjNumber));

  LObj1 := TgtPDDictionary(FormField).LookUp(PDF_SUBTYPE);

  if Assigned(LObj1) and LObj1.IsName(PDF_WIDGET) then
  begin
    LObj3 := TgtPDDictionary(FormField).LookUp(PDF_F);
    if Assigned(LObj3) and LObj3.IsInteger then
    begin
      Flag := TgtPDInteger(LObj3).Value;
      if ((Flag and 1) = 1) or ((Flag and 2) = 2) then
        Exit;
    end;

    LAP := TgtPDAppearanceStream.Create(FParentDoc, FormField, Value);
    LState := TgtPDState.Create(72, 72, 0, LAP.DestRect);
    THackState(LState).FPageNumber := PageNum;
    try
      OutDev.ResetDevice(LState);
      OutDev.SaveState(LState);

      if LAP.DestRect.Top < LAP.DestRect.Bottom then Y := LAP.DestRect.Top
      else Y := LAP.DestRect.Bottom;

      LState.CTM.Dx := LAP.DestRect.Left;
      LState.CTM.Dy := Y;

      OutDev.UpdateCTM(LState, LState.CTM);
      if Assigned(LAP.FormXObject) and Assigned(TgtPDForm(LAP.FormXObject).Resources) then
      begin
        if (TgtPDResource(TgtPDForm(LAP.FormXObject).Resources).FontCount = 0) then                                    
          TgtPDResource(TgtPDForm(LAP.FormXObject).Resources).SetFontResource(Resource.FontList);
      end;

      OutDev.DrawFormXObject(LState, LAP.FormXObject as TgtPDForm);
      OutDev.RestoreState(LState);
    finally
      LAP.Free;
      LState.Free;
    end;
  end
  else
  begin
    LObj1 := TgtPDDictionary(FormField).LookUp(PDF_KIDS);
    if Assigned(LObj1) and LObj1.IsArray then
    begin
      LObj2 := TgtPDDictionary(FormField).LookUp(PDF_V);
      if Assigned(LObj2) and LObj2.isName then
        LValue := TgtPDName(LObj2).Value;

      for I := 0 to TgtPDArray(LObj1).GetLength - 1 do
      begin
        LObj2 := TgtPDArray(LObj1).Get(I);
        RenderField(LObj2, LValue, OutDev, hDPI, vDPI, PageRect);
      end;
    end;
  end;
end;

procedure TgtPDPage.ReplaceContents(NewContents: TgtPDBaseObject);
begin

end;

  (**
   *
   * Sets the value of Duration
   * @param Value is the new value of type Integer
   * Algorithm Assign the value of parameter to the value of Duration
   *)

procedure TgtPDPage.SetBrushColor(AR, AG, AB: Byte);
begin
  FCurrentCS.SetBrushColor(AR, AG, AB);
  UpdatePDStreamLength;
end;

procedure TgtPDPage.SetBrushStyle(aBrush: TBrush);
begin
  if not Assigned(FContents) then
    SetRenderMode(rmOverLay);
  FCurrentCS.SetBrushStyle(aBrush);
end;

procedure TgtPDPage.SetCropBox(ALeft, ATop, ARight, ABottom: Double);
var
  LArrayObj: TgtPDArray;
begin
  if not Assigned(FCropbox) then
  begin
    LArrayObj := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
    LArrayObj.Add(TgtPDReal.Create(ALeft));
    LArrayObj.Add(TgtPDReal.Create(ATop));
    LArrayObj.Add(TgtPDReal.Create(ARight - ALeft));
    LArrayObj.Add(TgtPDReal.Create(ABottom - ATop));
    TgtPDDictionary(FBaseObject).Add(PDF_CROPBOX, LArrayObj);
    FCropBox := TgtPDRect.Create(LArrayObj);
    FIsInheritedCropBox := False;
  end
  else
  begin
    FCropBox.Left := ALeft;
    FCropBox.Right := ARight;
    FCropBox.Top := ATop;
    FCropBox.Bottom := ABottom;
  end;
end;

procedure TgtPDPage.SetDashPattern(aPenStyle: TPenStyle; aPenJoinStyle: TgtPenJoinStyle;
  aPenCapStyle: TgtPenCapStyle);
begin
  if not Assigned(FContents) then
    SetRenderMode(rmOverLay);
  FCurrentCS.PenStyle := aPenStyle;
  FCurrentCS.PenJoinStyle := aPenJoinStyle;
  FCurrentCS.PenCapStyle := aPenCapStyle;
  FCurrentCS.SetDashPattern;
end;

procedure TgtPDPage.SetDuration(const Value: Integer);
begin
  TgtPDInteger(FDuration).Value := Value;
end;

procedure TgtPDPage.SetEvenOddFillMode(AValue: Boolean);
begin
  FCurrentCS.EvenOddFillMode := AValue;
end;

procedure TgtPDPage.SetMediaBox(ALeft, ATop, ARight, ABottom: Double);
var
  LArrayObj: TgtPDArray;
begin
  if not Assigned(FMediabox) then
  begin
    LArrayObj := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
    LArrayObj.Add(TgtPDReal.Create(ALeft));
    LArrayObj.Add(TgtPDReal.Create(ATop));
    LArrayObj.Add(TgtPDReal.Create(ARight - ALeft));
    LArrayObj.Add(TgtPDReal.Create(ABottom - ATop));
    TgtPDDictionary(FBaseObject).Add(PDF_MEDIABOX, LArrayObj);
    FMediaBox := TgtPDRect.Create(LArrayObj);
    FIsInheritedMediaBox := False;
  end
  else
  begin
    FMediaBox.Left := ALeft;
    FMediaBox.Right := ARight;
    FMediaBox.Top := ATop;
    FMediaBox.Bottom := ABottom;
  end;
end;

procedure TgtPDPage.SetOpacity(AStrokeValue, AFillValue: Integer);
begin
  FCurrentCS.SetOpacity(AStrokeValue, AFillValue);
  UpdatePDStreamLength;
end;

procedure TgtPDPage.SetPenColor(AR, AG, AB: Byte);
begin
  FCurrentCS.SetPenColor(AR, AG, AB);
  UpdatePDStreamLength;
end;

procedure TgtPDPage.SetPenWidth(AValue: Double);
begin
  FCurrentCS.SetPenWidth(AValue);
  UpdatePDStreamLength;
end;

procedure TgtPDPage.SetRenderMode(RenderMode: TRenderMode);
var
  LMemStream: TMemoryStream;
  LgtMemStream: TgtMemoryStream;
  LPDStream, LDict: TgtPDBaseObject;
  LStr: AnsiString;
  LCS1, LCS2: TgtPDContentStream;

  function GetContentStream(AStr: AnsiString): TgtPDContentStream;
  begin
    LMemStream := TMemoryStream.Create;
    LStr := AStr + CRLF;
    LMemStream.Write(LStr[1], Length(LStr));
    LgtMemStream := TgtMemoryStream.Create(LMemStream, 0, 0, False);
    LgtMemStream.Reset;

    LDict := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);

    TgtPDDocument(FParentDoc).LastObjectNumber :=
      TgtPDDocument(FParentDoc).LastObjectNumber + 1;

    LPDStream := TgtPDStream.Create(LgtMemStream, LDict,
      TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber, 0);

    Result := TgtPDContentStream.Create(FParentDoc, Self, LPDStream);

    TgtPDDocument(FParentDoc).BaseDoc.AddToCollection(LPDStream);
    TgtPDDictionary(LDict).SetKeyValue(PDF_LENGTH, TgtPDInteger.Create(LMemStream.Size));
  end;

begin
  FCurrentCS := nil;

  if not Assigned(Contents) then
  begin
    TgtPDDictionary(FBaseObject).Add(PDF_CONTENTS,
      TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc));
  end;

  if RenderMode = rmUnderLay then
  begin
    LCS1 := GetContentStream('q');
    Contents.AddStream(LCS1, True, 0);//Save added at first + then existing CS
  end
  else
  begin
    LCS1 := GetContentStream('q');
    Contents.AddStream(LCS1, True, 0);//save 'q' + then existing CS
    LCS2 := GetContentStream('Q');
    Contents.AddStream(LCS2, False, -1);//Restore 'Q'
    LCS1 := GetContentStream('q');
    Contents.AddStream(LCS1, False, -1);//Save 'q'
  end;

  //adding new content stream
  FCurrentCS := GetContentStream('');

  if RenderMode = rmUnderLay then
    Contents.AddStream(FCurrentCS, True, 0)
  else
    Contents.AddStream(FCurrentCS, False, -1);

  //restoring the state
  if RenderMode = rmUnderLay then
  begin
    LCS2 := GetContentStream('Q');
    Contents.AddStream(LCS2, True, 2);//Restore
    LCS1 := GetContentStream('q');
    Contents.AddStream(LCS1, True, 3);//Save
    LCS2 := GetContentStream('Q');
    Contents.AddStream(LCS2, False, -1);//restore
  end
  else
  begin
    LCS2 := GetContentStream('Q');
    Contents.AddStream(LCS2, False, -1);//restore
  end;
end;

//procedure TgtPDPage.SetResource(Resource: TgtPDResource);
//begin
//  FResource := Resource;
//end;

(**
   *
   * Sets the value of Rotate
   * @param Value is the new value of type Integer
   * Algorithm Assign the value of parameter to the value of Rotate
   *)

procedure TgtPDPage.SetRotate(const Value: Integer);
var
  LObj: TgtPDBaseObject;
begin
  LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_ROTATE);
  if Assigned(LObj) then
    TgtPDInteger(LObj).Value := Value mod 360
  else
  begin
    LObj := TgtPDInteger.Create(Value mod 360);
    TgtPDDictionary(FBaseObject).Add(PDF_ROTATE, LObj);
  end;
end;

procedure TgtPDPage.SetTextRenderMode(AValue: TTextRenderMode);
begin
  FCurrentCS.SetTextRenderMode(AValue);
  UpdatePDStreamLength;
end;

procedure TgtPDPage.SetWidgetFlagBits(AFormField: TgtPDFormField;
  var AFieldFlag, AAnnotFlag: Integer);
begin
  AAnnotFlag := 4;
  AFieldFlag := 0;
  //Field Flag setting
  if afpReadOnly in TgtHackPDFormField(AFormField).Preferences then
    AFieldFlag := AFieldFlag or (1 shl 0);
  if afpRequired in TgtHackPDFormField(AFormField).Preferences then
    AFieldFlag := AFieldFlag or (1 shl 1);
  if afpNoExport in TgtHackPDFormField(AFormField).Preferences then
    AFieldFlag := AFieldFlag or (1 shl 2);

  if AFormField is TgtPDFormPushButton then
    AFieldFlag := AFieldFlag or (1 shl 16) //17-bit specifies it is a pushbtn
  else if AFormField is TgtPDFormTextField then
  begin
    //password Flag
    if TgtPDFormTextField(TgtPDFormTextField(AFormField)).IsPasswordField = True then
      AFieldFlag := AFieldFlag or (1 shl 13)
    else
      AFieldFlag := AFieldFlag and not (1 shl 13);
    //multiline flag
    if TgtPDFormTextField(AFormField).IsMultiline = True then
      AFieldFlag := AFieldFlag or (1 shl 12) //Setting the 13th bit
    else
      AFieldFlag := AFieldFlag and not (1 shl 12);
    //file select flag
    if TgtPDFormTextField(AFormField).IsFileSelect = True then
      AFieldFlag := AFieldFlag or (1 shl 20) //Setting the 21th bit
    else
      AFieldFlag := AFieldFlag and not (1 shl 20);
    //do not spell check flag
    if TgtPDFormTextField(AFormField).IsDoNotSpellCheck = True then
      AFieldFlag := AFieldFlag or (1 shl 22) //Setting the 23th bit
    else
      AFieldFlag := AFieldFlag and not (1 shl 22);
    //do not scroll flag
    if TgtPDFormTextField(AFormField).IsDoNotScroll = True then
      AFieldFlag := AFieldFlag or (1 shl 23) //Setting the 24th bit
    else
      AFieldFlag := AFieldFlag and not (1 shl 23);
    if TgtPDFormTextField(AFormField).IsComb = True then
    begin
      if TgtPDFormTextField(AFormField).MaxLength > 0 then
      begin
        AFieldFlag := AFieldFlag and not (1 shl 12);//Clear Multiline flag
        AFieldFlag := AFieldFlag and not (1 shl 13);//Clear Password flag
        AFieldFlag := AFieldFlag and not (1 shl 20);//Clear FileSelect flag
        AFieldFlag := AFieldFlag or (1 shl 24);//Setting the 25th bit
      end;
    end
    else
      AFieldFlag := AFieldFlag and not (1 shl 24);
  end
  else if AFormField is TgtPDFormComboBox then
  begin
    AFieldFlag := AFieldFlag or (1 shl 17);
    if (TgtPDFormComboBox(AFormField).IsSortedList = True) then
      AFieldFlag := AFieldFlag or (1 shl 19);
    if (TgtPDFormComboBox(AFormField).IsEditable = True) then
      AFieldFlag := AFieldFlag or (1 shl 18);
  end
  else if AFormField is TgtPDFormListBox then
  begin
    AFieldFlag := AFieldFlag and not (1 shl 17);
    if (TgtPDFormListBox(AFormField).IsSortedList = True) then
      AFieldFlag := AFieldFlag or (1 shl 19);
    if (TgtPDFormListBox(AFormField).IsMultiSelect = True) then
      AFieldFlag := AFieldFlag or (1 shl 21);
  end;

  //Annot Flag setting
  if afInvisible in TgtHackPDFormField(AFormField).Flags then
    AAnnotFlag := AAnnotFlag or 1;
  if afHidden in TgtHackPDFormField(AFormField).Flags then
    AAnnotFlag := AAnnotFlag or (1 shl 1);
  if afPrint in TgtHackPDFormField(AFormField).Flags then
    AAnnotFlag := AAnnotFlag or (1 shl 2);
  if afNoZoom in TgtHackPDFormField(AFormField).Flags then
    AAnnotFlag := AAnnotFlag or (1 shl 3);
  if afNoRotate in TgtHackPDFormField(AFormField).Flags then
    AAnnotFlag := AAnnotFlag or (1 shl 4);
  if afNoView in TgtHackPDFormField(AFormField).Flags then
    AAnnotFlag := AAnnotFlag or (1 shl 5);
  if afReadOnly in TgtHackPDFormField(AFormField).Flags then
    AAnnotFlag := AAnnotFlag or (1 shl 6);
  if afLocked in TgtHackPDFormField(AFormField).Flags then
    AAnnotFlag := AAnnotFlag or (1 shl 7);
  if afToggleNoView in TgtHackPDFormField(AFormField).Flags then
    AAnnotFlag := AAnnotFlag or (1 shl 8);
end;

procedure TgtPDPage.StrokePath;
begin
  FCurrentCS.StrokePath;
  UpdatePDStreamLength;
end;

procedure TgtPDPage.TextOut(const Text: WideString;
      aClipRect: TgtPDRect;
      aX, aY: Double;
      aFont: TgtFont;
      aJustify, aJustifyLastLine: Boolean;
      aPointOfRotationX, aPointOfRotationY: Double;
      AWritingMode: TgtWritingMode = wmHorizontal;
      aHAlign: TgtHAlignment = haLeft; aVAlign: TgtVAlignment = vaCenter;
      AAngle: Integer = 0); 
begin
  //Needs to be corrected
  //FCurrentCS is nil for blank doc which doesn't have content stream
  //SetRenderMode(rmOverLay) is used as a workaround
  if not Assigned(FCurrentCS) then
  begin
    SetRenderMode(rmOverLay);
  end;
  //FCurrentCS.TextOut(Text, aClipRect, aX, GetNativeYPos(aY), aFont, aJustify,
  //aJustifyLastLine, aPointOfRotationX, aPointOfRotationY, AWritingMode,
  //  aHAlign, aVAlign, AAngle);
  UpdatePDStreamLength;
end;

procedure TgtPDPage.TextOutU(const Text: WideString; AFont: TgtFont; aX,
  aY: Double; AWritingMode: TgtWritingMode; AAngle: Integer);
begin
  if not Assigned(FCurrentCS) then
    SetRenderMode(rmOverLay);
  SetBrushColor(GetRValue(aFont.Color),
    GetGValue(aFont.Color),
    GetBValue(aFont.Color));
//  FCurrentCS.TextOutU(Text, aFont, aX, GetNativeYPos(aY), AWritingMode, AAngle);
  UpdatePDStreamLength;
end;

procedure TgtPDPage.TranslateXY(var AX, AY: Double);
var
  LRect: TgtPDRect;
begin
  LRect := TgtPDPage(FParentElement).Cropbox;
  if not Assigned(LRect) then
    LRect := TgtPDPage(FParentElement).Mediabox;
  AX := AX + LRect.Left;
  AY := AY + LRect.Top;
end;

procedure TgtPDPage.TextOut(const Text: WideString; aFont: TgtFont; aX,
  aY: Double; aClipRect: TgtPDRect; AWritingMode: TgtWritingMode; AAngle: Integer);
begin
  //Needs to be corrected
  //FCurrentCS is nil for blank doc which doesn't have content stream
  //SetRenderMode(rmOverLay) is used as a workaround
  if not Assigned(FCurrentCS) then
  begin
    SetRenderMode(rmOverLay);
  end;
  aClipRect.Top := GetPageHeight - aClipRect.Bottom;
  FCurrentCS.TextOut(Text, aFont, aX, GetNativeYPos(aY), aClipRect, AWritingMode, AAngle);
  UpdatePDStreamLength;
end;

procedure TgtPDPage.TextOut(const Text: WideString; aFont: TgtFont; aX, aY: Double;
  AWritingMode: TgtWritingMode = wmHorizontal; AAngle: Integer = 0);
begin
  //Needs to be corrected
  //FCurrentCS is nil for blank doc which doesn't have content stream
  //SetRenderMode(rmOverLay) is used as a workaround
  if not Assigned(FCurrentCS) then
  begin
    SetRenderMode(rmOverLay);
  end;
  SetBrushColor(GetRValue(aFont.Color),
    GetGValue(aFont.Color),
    GetBValue(aFont.Color));
  FCurrentCS.TextOut(Text, aFont, aX, GetNativeYPos(aY), AWritingMode, AAngle);
  UpdatePDStreamLength;
end;

procedure TgtPDPage.UniCodeTextOut(const Text: WideString; AFont: TgtFont; aX,
  aY: Double; AWritingMode: TgtWritingMode; AAngle: Integer);
begin
  if not Assigned(FCurrentCS) then
    SetRenderMode(rmOverLay);
  SetBrushColor(GetRValue(aFont.Color),
    GetGValue(aFont.Color),
    GetBValue(aFont.Color));
  FCurrentCS.UniCodeTextOut(Text, aFont, aX, GetNativeYPos(aY), AWritingMode, AAngle);
  UpdatePDStreamLength;
end;

procedure TgtPDPage.Update;
var
  LObj: TgtPDBaseObject;
begin
  BaseObject.IsChanged := True;
  BaseObject.IsWritten := False;
  if Assigned(Resource) then
    Resource.Update;

  TgtPDDictionary(FBaseObject).Remove(PDF_PARENT);
  LObj := TgtPDIndirectRef.Create(FParentElement.BaseObject.ObjNumber,
    FParentElement.BaseObject.GenNumber);
  TgtPDDictionary(FBaseObject).Add(PDF_PARENT, LObj);
end;

procedure TgtPDPage.UpdatePDStreamLength;
begin
  TgtPDDictionary(TgtPDStream(FCurrentCS.BaseObject).GetDict).SetKeyValue(PDF_LENGTH,
    TgtPDInteger.Create(TgtPDStream(FCurrentCS.BaseObject).GetStream.GetSize));
end;

procedure TgtPDPage.SetPageTransitionEffect(Duration: Single;
  TransitionEffect: TgtPDTransitionEffect);
begin
  TgtPDDictionary(FBaseObject).Add(PDF_DUR, TgtPDReal.Create(Duration));
  TgtPDDictionary(FBaseObject).Add(PDF_TRANS, GetTransitionDict(Duration, TransitionEffect));
end;

function TgtPDPage.GetTextFieldFormStream(AY, AWidth, AHeight: Double;
  AFontTag: AnsiString; AI: Integer; AFormField: TgtPDFormTextField): TMemoryStream;
var
  LStr: AnsiString;
begin
  LStr := FloatToStringLocale(AFormField.BackgroundColor.Value[0]) + ' ' +
    FloatToStringLocale(AFormField.BackgroundColor.Value[1]) + ' ' +
    FloatToStringLocale(AFormField.BackgroundColor.Value[2]) +
    ' rg 0 0 ' + FloatToStringLocale(AWidth) + ' ' + FloatToStringLocale(AHeight) + ' re f ' +
    FloatToStringLocale(AFormField.BorderColor.Value[0]) + ' ' +
    FloatToStringLocale(AFormField.BorderColor.Value[1]) + ' ' +
    FloatToStringLocale(AFormField.BorderColor.Value[2]) +
    ' RG 0.5 0.5 ' + FloatToStringLocale(AWidth - 1) + ' ' + FloatToStringLocale(AHeight - 1) +
    ' re S /Tx BMC q 1 1 ' + FloatToStringLocale(AWidth - 2) + ' ' +
    FloatToStringLocale(AHeight - 2) + ' re W n BT /' + AFontTag + ' ' +
    IntToStr(Round((72 / 96) * (AFormField.Font.Size))) + ' Tf ' +
    ColorToPDFColor(GetRValue(ColorToRGB(AFormField.Font.Color)),
    GetGValue(ColorToRGB(AFormField.Font.Color)),
    GetBValue(ColorToRGB(AFormField.Font.Color))) + ' rg ';
  if (AI = 0) then
    LStr := LStr + ' 2 ' + FloatToStringLocale(AHeight - AFormField.Font.Size - 2)
  else
    LStr := LStr + FloatToStringLocale(2) + ' ' + FloatToStringLocale(AY);
  LStr := LStr + ' Td (' + AFormField.Value + ') Tj ET Q EMC';
  Result := TMemoryStream.Create;
  Result.Write(Pointer(LStr)^, Length(LStr));
end;

procedure TgtPDPage.GetTransformedRect(AInputRect: TgtPDRect;
  AAngle: TgtPDFormFieldOrientation; var AOutputRect: TgtPDRect);
var
  LWidth, LHeight, LTemp: Double;
  LRect: TgtPDRect;
begin
  AOutputRect.Left := AInputRect.Left;
  AOutputRect.Top := AInputRect.Top;
  AOutputRect.Right := AInputRect.Right;
  AOutputRect.Bottom := AInputRect.Bottom;

  LWidth := AInputRect.Right - AInputRect.Left;
  LHeight := AInputRect.Bottom - AInputRect.Top;

  case AAngle of
    ffo0:;//do nothing
    ffo90:
    begin
      AOutputRect.Top := AInputRect.Top - LWidth;
      LTemp := LWidth;
      LWidth := LHeight;
      LHeight := LTemp;
      AOutputRect.Right := AInputRect.Left + LWidth;
      AOutputRect.Bottom := AOutputRect.Top + LHeight;
    end;
    ffo180:
    begin
      AOutputRect.Left := AInputRect.Left - LWidth;
      AOutputRect.Top := AInputRect.Top - LHeight;
      AOutputRect.Right := AOutputRect.Left + LWidth;
      AOutputRect.Bottom := AOutputRect.Top + LHeight;
    end;
    ffo270:
    begin
      AOutputRect.Left := AInputRect.Left - LHeight;
      LTemp := LWidth;
      LWidth := LHeight;
      LHeight := LTemp;
      AOutputRect.Right := AOutputRect.Left + LWidth;
      AOutputRect.Bottom := AInputRect.Top + LHeight;
    end;
  end;
end;

function TgtPDPage.GetTransitionDict(ADuration: Single;
  ATransitionEffect: TgtPDTransitionEffect): TgtPDDictionary;
begin
  Result := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);
  with Result do
  begin
    Add(PDF_TYPE, TgtPDName.Create(PDF_TRANS));
    Add(PDF_D, TgtPDReal.Create(ADuration));

    case ATransitionEffect of
      teSplitHorizontalInward:
        begin
          Add(PDF_S, TgtPDName.Create(PDF_SPLIT));
          Add(PDF_Dm, TgtPDName.Create(PDF_H));
          Add(PDF_M, TgtPDName.Create(PDF_I));
        end;
      teSplitHorizontalOutward:
        begin
          Add(PDF_S, TgtPDName.Create(PDF_SPLIT));
          Add(PDF_Dm, TgtPDName.Create(PDF_H));
          Add(PDF_M, TgtPDName.Create(PDF_O));
        end;
      teSplitVerticalInward:
        begin
          Add(PDF_S, TgtPDName.Create(PDF_SPLIT));
          Add(PDF_Dm, TgtPDName.Create(PDF_V));
          Add(PDF_M, TgtPDName.Create(PDF_I));
        end;
      teSplitVerticalOutward:
        begin
          Add(PDF_S, TgtPDName.Create(PDF_SPLIT));
          Add(PDF_Dm, TgtPDName.Create(PDF_V));
          Add(PDF_M, TgtPDName.Create(PDF_O));
        end;
      teBlindsHorizontal:
        begin
          Add(PDF_S, TgtPDName.Create(PDF_BLINDS));
          Add(PDF_Dm, TgtPDName.Create(PDF_H));
        end;
      teBlindsVertical:
        begin
          Add(PDF_S, TgtPDName.Create(PDF_BLINDS));
          Add(PDF_Dm, TgtPDName.Create(PDF_V));
        end;
      teBoxInward:
        begin
          Add(PDF_S, TgtPDName.Create(PDF_BOX));
          Add(PDF_M, TgtPDName.Create(PDF_I));
        end;
      teBoxOutward:
        begin
          Add(PDF_S, TgtPDName.Create(PDF_BOX));
          Add(PDF_M, TgtPDName.Create(PDF_O));
        end;
      teWipeLeftToRight:
        begin
          Add(PDF_S, TgtPDName.Create(PDF_WIPE));
          Add(PDF_Di, TgtPDInteger.Create(0));
        end;
      teWipeRightToLeft:
        begin
          Add(PDF_S, TgtPDName.Create(PDF_WIPE));
          Add(PDF_Di, TgtPDInteger.Create(180));
        end;
      teWipeBottomToTop:
        begin
          Add(PDF_S, TgtPDName.Create(PDF_WIPE));
          Add(PDF_Di, TgtPDInteger.Create(90));
        end;
      teWipeTopToBottom:
        begin
          Add(PDF_S, TgtPDName.Create(PDF_WIPE));
          Add(PDF_Di, TgtPDInteger.Create(270));
        end;
      teDissolve:
        begin
          Add(PDF_S, TgtPDName.Create(PDF_DISSOLVE));
        end;
      teGlitterLeftToRight:
        begin
          Add(PDF_S, TgtPDName.Create(PDF_GLITTER));
          Add(PDF_Di, TgtPDInteger.Create(0));
        end;
      teGlitterTopToBottom:
        begin
          Add(PDF_S, TgtPDName.Create(PDF_GLITTER));
          Add(PDF_Di, TgtPDInteger.Create(270));
        end;
      teGlitterTopLeftToBottomRight:
        begin
          Add(PDF_S, TgtPDName.Create(PDF_GLITTER));
          Add(PDF_Di, TgtPDInteger.Create(315));
        end;
    else
      Add(PDF_S, TgtPDName.Create(PDF_R));
    end; // End Of Case.
  end; // End of With.
end;

procedure TgtPDPage.DrawPie(X1, Y1, X2, y2, X3, Y3, X4, Y4: Double; aPen: TPen;
  aBrush: TBrush; aOpacityStroke, aOpacityFill: Integer);
var
	XCenter, YCenter, RadiusX, RadiusY, StartX, StartY: Double;
	Alpha, Beta, TempAngle: Double;
  cpFactor: Double;
	AlphaRad, BetaRad, cosAlpha, cosBeta, sinAlpha, sinBeta: Double;
begin
   if not Assigned(FContents) then
    SetRenderMode(rmOverLay);
  if Assigned(aPen) then
  begin
    SetPenWidth(aPen.Width);
    SetPenColor(GetRValue(aPen.Color),
      GetGValue(aPen.Color),
      GetBValue(aPen.Color));
    SetDashPattern(APen.Style, pjsNone, pcsNone);
  end;
  if Assigned(aBrush) then
  begin
    SetBrushColor(GetRValue(aBrush.Color),
      GetGValue(aBrush.Color),
      GetBValue(aBrush.Color));
  end;
  SetOpacity(aOpacityStroke, aOpacityFill);
  SetEvenOddFillMode(True);


  Y1:= GetNativeYPos(Y1);
  Y2:= GetNativeYPos(Y2);
  Y3:= GetNativeYPos(Y3);
  Y4:= GetNativeYPos(Y4);
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
	StartX := XCenter - RadiusX * cos(DegreesToRadians(Alpha));
	StartY := YCenter - RadiusY * sin(DegreesToRadians(Alpha));

  //Move to Start Point
  MoveTo(StartX,StartY, True);
  LineTo(XCenter,YCenter,True);
  MoveTo(StartX,StartY, True);
  while (Beta - Alpha > 90) do
	begin
		TempAngle := Alpha + 90;

    // Convert from degrees to radians.
    AlphaRad := DegreesToRadians(Alpha);
    BetaRad  := DegreesToRadians(TempAngle);
    // This factor is used to calculate control points.
    cpFactor := (4.0/3 * (1 - cos((BetaRad - AlphaRad)/2)) /
      sin((BetaRad - AlphaRad) / 2));

    sinAlpha := sin(AlphaRad);
    sinBeta := sin(BetaRad);
    cosAlpha := cos(AlphaRad);
    cosBeta := cos(BetaRad);

    CurveTo(
      XCenter - RadiusX * (cosAlpha - cpFactor * sinAlpha),
      YCenter - RadiusY * (sinAlpha + cpFactor * cosAlpha),
      XCenter - RadiusX * (cosBeta + cpFactor * sinBeta),
      YCenter - RadiusY * (sinBeta - cpFactor * cosBeta),
      XCenter - RadiusX * cosBeta,
      YCenter - RadiusY * sinBeta,
      True);

      Alpha := TempAngle;
	end;
	if (Alpha <> Beta) then
  begin
		// Convert from degrees to radians.
	AlphaRad := DegreesToRadians(Alpha);
	BetaRad  := DegreesToRadians(Beta);
	// This factor is used to calculate control points.
	cpFactor := (4.0/3 * (1 - cos((BetaRad - AlphaRad)/2)) /
		sin((BetaRad - AlphaRad) / 2));

 	sinAlpha := sin(AlphaRad);
	sinBeta := sin(BetaRad);
	cosAlpha := cos(AlphaRad);
	cosBeta := cos(BetaRad);

	CurveTo(
		XCenter - RadiusX * (cosAlpha - cpFactor * sinAlpha),
		YCenter - RadiusY * (sinAlpha + cpFactor * cosAlpha),
		XCenter - RadiusX * (cosBeta + cpFactor * sinBeta),
		YCenter - RadiusY * (sinBeta - cpFactor * cosBeta),
		XCenter - RadiusX * cosBeta,
		YCenter - RadiusY * sinBeta,
    True);

  end;

  LineTo(XCenter,YCenter,True);

  if Assigned(aPen) and Assigned(aBrush) and (aPen.Style <> psClear) and (aBrush.Style <> bsClear) then
    FillAndStrokePath
  else if Assigned(aPen) and (aPen.Style <> psClear) then
    StrokePath
  else if Assigned(aBrush) and (aBrush.Style <> bsClear) then
    FillPath
  else
    StrokePath;
end;

procedure TgtPDPage.DrawPolyBezier(aPoints: array of TPDPoint; aPen: TPen);
var
  LI, LMax: Integer;
begin
  FFirstPoint := True;
  if not Assigned(FContents) then
    SetRenderMode(rmOverLay);
  if Assigned(aPen) then
  begin
    SetPenWidth(aPen.Width);
    SetPenColor(GetRValue(aPen.Color),
      GetGValue(aPen.Color),
      GetBValue(aPen.Color));
    SetDashPattern(APen.Style, pjsNone, pcsNone);
  end;
  LI := 1;
  LMax := ((High(aPoints) div 3) * 3);
   if FFirstPoint then
   begin
     moveTo(aPoints[0].X, aPoints[0].Y);
     FFirstPoint := False;
   end;
   while LI <= LMax do
   begin
    curveTo(aPoints[LI].X, GetNativeYPos(aPoints[LI].Y),
            aPoints[LI+1].X, GetNativeYPos(aPoints[LI+1].Y),
            aPoints[LI+2].X, GetNativeYPos(aPoints[LI+2].Y),
            True);
    LI := LI + 3;
  end;
  StrokePath;
end;

procedure TgtPDPage.DrawPolygon(aCoordinates: array of TPDPoint; aNumOfSides: integer;
  aPen: TPen; aBrush: TBrush; aOpacityStroke, aOpacityFill: Integer);
var
  LRadius: Double;
  LJ: Integer;
begin
  if not Assigned(FContents) then
    SetRenderMode(rmOverLay);

  for LJ := 0 to aNumOfSides - 1 do
  begin
    if (LJ = 0) then
      MoveTo(aCoordinates[LJ].X, aCoordinates[LJ].Y)
    else
    begin
      LineTo(aCoordinates[LJ].X, aCoordinates[LJ].Y);
    end;
  end;
  LineTo(aCoordinates[0].X, aCoordinates[0].Y);
  if Assigned(aPen) then
  begin
    SetPenWidth(aPen.Width);
    SetPenColor(GetRValue(aPen.Color),
      GetGValue(aPen.Color),
      GetBValue(aPen.Color));
    SetDashPattern(APen.Style, pjsNone, pcsNone);
  end;
  if Assigned(aBrush) then
  begin
    SetBrushColor(GetRValue(aBrush.Color),
      GetGValue(aBrush.Color),
      GetBValue(aBrush.Color));
  end;
  SetOpacity(aOpacityStroke, aOpacityFill);
  SetEvenOddFillMode(True);

  if Assigned(aPen) and Assigned(aBrush) and (aPen.Style <> psClear) and (aBrush.Style <> bsClear) then
    FillAndStrokePath
  else if Assigned(aPen) and (aPen.Style <> psClear) then
    StrokePath
  else if Assigned(aBrush) and (aBrush.Style <> bsClear) then
    FillPath;
end;

// To Draw PolyLine
procedure TgtPDPage.DrawPolyline(aPen: TPen; aBrush: TBrush; aPoints: array of TPDPoint; aOpacityStroke,
  aOpacityFill: Integer);
var
  LJ: Integer;
  LNumOfPoints:Integer;
begin
   if not Assigned(FContents) then
    SetRenderMode(rmOverLay);
  for LJ := 0 to Length(aPoints) - 1 do
  begin
    if (LJ = 0) then
      MoveTo(aPoints[LJ].X, aPoints[LJ].Y)
    else
    begin
      LineTo(aPoints[LJ].X, aPoints[LJ].Y);
    end;
  end;

  if Assigned(aPen) then
  begin
    SetPenWidth(aPen.Width);
    SetPenColor(GetRValue(aPen.Color),
      GetGValue(aPen.Color),
      GetBValue(aPen.Color));
    SetDashPattern(aPen.Style, pjsNone, pcsNone);
  end;
  if Assigned(aBrush) then
  begin
    SetBrushColor(GetRValue(aBrush.Color),
      GetGValue(aBrush.Color),
      GetBValue(aBrush.Color));
  end;
  SetOpacity(aOpacityStroke, aOpacityFill);
  SetEvenOddFillMode(True);

  if Assigned(aPen) and Assigned(aBrush) and (aPen.Style <> psClear) and (aBrush.Style <> bsClear) then
    FillAndStrokePath
  else if Assigned(aPen) and (aPen.Style <> psClear) then
    StrokePath
  else if Assigned(aBrush) and (aBrush.Style <> bsClear) then
    FillPath
  else
    StrokePath;
end;

procedure TgtPDPage.DrawPolyPolygon(AObject: TgtPolyPolygonItem);
var
	LJ, LI, LK, LStart, LPoly, LNext, LEnd: Integer;
begin
  if not Assigned(FContents) then
    SetRenderMode(rmOverLay);
  LK := 0;
  LI := 0;
  LStart := 0;
  LNext := 0;
  LJ:= 0;
  LEnd:= 0;
    for LPoly := 0 to Length(AObject.FNoPoints) - 1 do
    begin
      LEnd := (LNext + AObject.FNoPoints[LPoly] - 1);
      for LJ := LNext to LEnd do
      begin
        if (LJ = LNext) then
        begin
          moveTo(AObject.FPoints[LJ].X,AObject.FPoints[LJ].Y);
        end
        else lineTo(AObject.FPoints[LJ].X,AObject.FPoints[LJ].Y);
      end;
      LNext := LJ;
      LStart := LJ - (AObject.FNoPoints[LPoly]);
      lineTo(AObject.FPoints[LStart].X,AObject.FPoints[LStart].Y);
  end;
      with AObject do
  begin
  if Assigned(Pen) then
      begin
        SetPenWidth(Pen.Width);
        SetPenColor(GetRValue(Pen.Color),
          GetGValue(Pen.Color),
          GetBValue(Pen.Color));
        SetDashPattern(Pen.Style, pjsNone, pcsNone);
      end;

      if Assigned(Brush) then
      begin
        SetBrushColor(GetRValue(Brush.Color),
          GetGValue(Brush.Color),
          GetBValue(Brush.Color));
      end;

      if Assigned(Pen) and Assigned(Brush) and (Pen.Style <> psClear) and (Brush.Style <> bsClear) then
      begin
        if AObject.FillAlternate then
          SetEvenOddFillMode(true);
        FillAndStrokePath;
      end
      else if Assigned(Pen) and (Pen.Style <> psClear) then
      begin
        StrokePath
      end
      else if Assigned(Brush) and (Brush.Style <> bsClear) then
      begin
        if AObject.FillAlternate then
          SetEvenOddFillMode(true);
        FillPath;
      end
      else
      begin
        StrokePath;
      end;
  end;

end;

procedure TgtPDPage.DrawPolyPolyline(AObject: TgtPolyShapeItem;
  IsClosed: Boolean);
var
	LJ, LI: Integer;
  LPoints: TPDPoints;
begin
 if not Assigned(FContents) then
    SetRenderMode(rmOverLay);
 if (AObject.Shapes.Count = 0) then Exit;
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

      if Assigned(Pen) then
      begin
        SetPenWidth(Pen.Width);
        SetPenColor(GetRValue(Pen.Color),
          GetGValue(Pen.Color),
          GetBValue(Pen.Color));
        SetDashPattern(Pen.Style, pjsNone, pcsNone);
      end;

      if Assigned(Brush) then
      begin
        SetBrushColor(GetRValue(Brush.Color),
          GetGValue(Brush.Color),
          GetBValue(Brush.Color));
      end;

      SetLength(LPoints, NoPoints);
    	LPoints := GetPoints;
    	for LI := 0 to NoPoints - 1 do
      begin
      	if (LI = 0) then MoveTo(LPoints[LI].X,LPoints[LI].Y)
        else LineTo(LPoints[LI].X,LPoints[LI].Y);
      end;
      if IsClosed then
      begin
      LineTo(LPoints[0].X,LPoints[0].Y);
      end;

      if Assigned(Pen) and Assigned(Brush) and (Pen.Style <> psClear) and (Brush.Style <> bsClear) then
      begin
        FillAndStrokePath;
        if AObject.FillAlternate then
          SetEvenOddFillMode(true);
      end
      else if Assigned(Pen) and (Pen.Style <> psClear) then
      begin
        StrokePath
      end
      else if Assigned(Brush) and (Brush.Style <> bsClear) then
      begin
        FillPath;
        if AObject.FillAlternate then
          SetEvenOddFillMode(true);
      end
      else
      begin
        StrokePath;
      end;

    end;
  end;
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
 //{$IFNDEF gtDelphi2005Up}
//  FreeMem(FPoints);
//  {$ENDIF}
  inherited;
end;

function TgtShapeItem.GetPoints:TPDPoints;
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

procedure TgtShapeItem.SetPoints(Points: array of TPDPoint);
begin
  NoPoints := SizeOf(Points) div SizeOf(TPDPoint);

  SetLength(FPoints, NoPoints);
  CopyMemory(FPoints,@Points,SizeOf(Points)); { check this routine}
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
 // FreeMem(FOperations);
  {$ENDIF}
  Finalize(FPoints);
  {$IFNDEF gtDelphi2005Up}
 // FreeMem(FPoints);
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
  //FreeMem(FNoPoints);
  {$ENDIF}
  Finalize(FPoints);
  {$IFNDEF gtDelphi2005Up}
 // FreeMem(FPoints);
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
  SetLength(FNoPoints,NoPoly);
end;

procedure TgtPolyPolygonItem.SetPoints();
var
LI : Integer;
LCountOfPoints: Integer;
begin
 LCountOfPoints := 0;
  for LI := 0 to Length(FNoPoints) - 1 do
  begin
    LCountOfPoints := LCountOfPoints + FNoPoints[LI];
  end;
  SetLength(FPoints,LCountOfPoints);
end;

function TgtPolyPolygonItem.GetPoints(Position : Integer):TPDPoint;
begin
  if Position < FNoPoly then
  begin
  Result := FPoints[Position];
  end;
end;


end.
