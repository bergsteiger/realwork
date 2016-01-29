{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Model                   }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

{$I ..\Utils\gtCompilerDefines.inc}

unit PDAnnot;

interface

uses
  gtObject, PDElement, PDBaseObject, PDTypes, PDAction, PDOCMD, PDOCContext,
  Contnrs, PDRect, PDString, PDDate, PdColorValue, PDInheritedProperty,
  PDAppearanceStream, PDExportDevice;

type
  //This enumeration defines all the Annotation types a PDF supports
  TgtPDAnnotType = (annotText, annotLink, annotFreeText, annotLine,
    annotSquare, annotCircle, annotPolygon, annotPolyLine, annotHighlight,
    annotUnderline, annotSquiggly, annotStrikeOut, annotStamp, annotCaret,
    annotInk, annotPopup, annotFileAttachment, annotSound, annotMovie, annotWidget,
    annotScreen, annotPrinterMark, annotTrapNet, annotWatermark, annot3D);

  TgtPDAnnotFlag = (
    //If True, do not display the annotation if it does not belong to one of the
    //standard annotation types and no annotation handler is available. If False,
    //display such an unknown annotation using an appearance stream specified by
    //its appearance dictionary, if any
    afInvisible,

    //If True, do not display or print the annotation or allow it to interact
    //with the user, regardless of its annotation type or whether an annotation
    //handler is available. In cases where screen space is limited, the ability
    //to hide and show annotations selectively can be used in combination with
    //appearance streams to display auxiliary pop-up information similar in
    //function to online help systems.
    afHidden,

    //If True, print the annotation when the page is printed. If clear, never
    //print the annotation, regardless of whether it is displayed on the screen.
    //This can be useful, for example, for annotations representing interactive
    //pushbuttons, which would serve no meaningful purpose on the printed page.
    afPrint,

    //If True, do not scale the annotation’s appearance to match the magnification
    //of the page. The location of the annotation on the page (defined by the
    //upper-left corner of its annotation rectangle) remains fixed, regardless
    //of the page magnification.
    afNoZoom,

    //If True, do not rotate the annotation’s appearance to match the rotation
    //of the page. The upper-left corner of the annotation rectangle remains in
    //a fixed location on the page, regardless of the page rotation.
    afNoRotate,

    //If True, do not display the annotation on the screen or allow it to
    //interact with the user. The annotation may be printed (depending on the
    //setting of the Print flag) but should be considered hidden for purposes
    //of on-screen display and user interaction.
    afNoView,

    //If True, do not allow the annotation to interact with the user. The
    //annotation may be displayed or printed (depending on the settings of the
    //NoView and Print flags) but should not respond to mouse clicks or change
    //its appearance in response to mouse motions. This flag is ignored for
    //widget annotations; its function is subsumed by the ReadOnly flag of the
    //associated form field
    afReadOnly,

    //If True, do not allow the annotation to be deleted or its properties
    //(including position and size) to be modified by the user. However, this
    //flag does not restrict changes to the annotation’s contents, such as the
    //value of a form field.
    afLocked,

    //If True, invert the interpretation of the NoView flag for certain events.
    //A typical use is to have an annotation that appears only when a mouse
    //cursor is held over it;
    afToggleNoView,

    //If True, do not allow the contents of the annotation to be modified by the
    //user. This flag does not restrict deletion of the annotation or changes to
    //other annotation properties, such as position and size.
    afLockedContents);


    //The border style
    //The annotation dictionary’s AP entry, if present, takes precedence over
    //the Vertices and BS entries
  TgtAnnotBorderStyle = (
    //(Solid) A solid rectangle surrounding the annotation.
    absSolid,

    //(Dashed) A dashed rectangle surrounding the annotation.
    //The dash pattern is specified by the D entry
    absDashed,

    //(Beveled) A simulated embossed rectangle that appears to be raised
    //above the surface of the page.
    absBeveled,

    //(Inset) A simulated engraved rectangle that appears to be recessed below the
    //surface of the page.
    absInset,

    //(Underline) A single line along the bottom of the annotation rectangle.
    absUnderline);


  TgtLineCapStyle = (
    //A square filled with the annotation’s interior color, if any
    lcSquare,

    //A circle filled with the annotation’s interior color, if any
    lcCircle,

    //A diamond shape filled with the annotation’s interior color, if any
    lcDiamond,

    //Two short lines meeting in an acute angle to form an open arrowhead
    lcOpenArrow,

    //Two short lines meeting in an acute angle as in the OpenArrow style
    //(see above) and connected by a third line to form a triangular closed
    //arrowhead filled with the annotation’s interior color, if any
    lcClosedArrow,

    //A short line at the endpoint perpendicular to the line itself (PDF 1.5)
    lcButt,

    //Two short lines in the reverse direction from OpenArrow (PDF 1.5)
    lcROpenArrow,

    //A triangular closed arrowhead in the reverse direction from ClosedArrow (PDF 1.5)
    lcRClosedArrow,

    //A short line at the endpoint approximately 30 degrees clockwise from (PDF 1.6)
    //perpendicular to the line itself
    lcSlash,

    //No line ending
    lcNone);

  TgtPDAnnotFlags = set of TgtPDAnnotFlag;

  TgtLineStyle = (laSquare, laCircle, laDiamond, laOpenArrow, laClosedArrow, laNone,
    laButt, laROpenArrow, laRClosedArrow, laSlash);


 (**
  * This is the superclass for all annotations
  *
  *)
  TgtPDAnnot = class(TgtPDElement)
  private
    FColor: TgtPDColorValue;
    FDate: TgtPDDate;
    FFlags: TgtPDAnnotFlags;
    FRect: TgtPDRect;
    FAnnotType: TgtPDAnnotType;
    FAction: TgtPDAction;
    FAdditionalAction: TgtPDAction;
    FTitle: AnsiString;
    FOCMD: TgtPDOCMD;
    FContents: AnsiString;
    FName: AnsiString;
    FPage: TgtPDElement;
    FBorderWidth: Double;
    FBorderStyle: TgtAnnotBorderStyle;
//    FNormalAP: TgtPDAppearanceStream;
    function GetParentObj(AObject: TgtPDBaseObject): TgtPDBaseObject;
//    function PDFlags(Value: Integer): TgtPDAnnotFlags;

    function GetDate: TgtPDDate;
    function GetOCMD: TgtPDOCMD;
    function GetRect: TgtPDRect;
    function GetType: TgtPDAnnotType;
    function GetTitle: AnsiString;
    function GetAction: TgtPDAction;
    function GetAdditionalAction: TgtPDAction;
    function GetContents: AnsiString;
    function GetName: AnsiString;
    function GetPage: TgtPDElement;
    function GetFlags: TgtPDAnnotFlags;
    function GetColor: TgtPDColorValue;
    function GetBorderStyle: TgtAnnotBorderStyle;
    function GetBorderWidth: Double;

//    procedure SetOCMD(OCMD: TgtPDOCMD);
    procedure SetTitle(const Title: AnsiString);
    procedure SetContents(AContents: AnsiString);
    procedure SetName(AName: AnsiString);
    procedure SetFlags(AFlags: TgtPDAnnotFlags);
    procedure SetColor(const Color: TgtPDColorValue);
    procedure SetType(const Value: TgtPDAnnotType);
    procedure SetBorderStyle(const Value: TgtAnnotBorderStyle);
    procedure SetBorderWidth(const Value: Double);
    procedure SetAction(AValue: TgtPDAction);
    function GetNormalAP: TgtPDAppearanceStream;
  protected
    FInheritedProp: TgtPDInheritedProperty;

    property NormalAP: TgtPDAppearanceStream read GetNormalAP;

    constructor Create(AParentDoc: TgtObject; AParentElement: TgtPDElement;
      ABaseObject: TgtPDBaseObject); overload;
  public

    class function MakeAnnot(AParentDoc: TgtObject; AParentElement: TgtPDElement;
      ABaseObject: TgtPDBaseObject): TgtPDAnnot;
    procedure SetParentElement(ParentElement: TgtPDElement);
    procedure SetBaseObject(ABaseObject: TgtPDBaseObject);
    procedure SetParentDoc(AParentDoc: TgtObject);

    constructor Create; overload;
    destructor Destroy; override;

    procedure Update; override;
    procedure RemoveOCMD;

    function IsCurrentlyVisible(OCContext: TgtPDOCContext): Boolean;
    function IsValid: Boolean;

    procedure Display(OutDev: TgtPDExportDevice; hDPI, vDPI: Double);

    property Rect: TgtPDRect read GetRect;
    property Contents: AnsiString read GetContents write SetContents;
    property Name: AnsiString read GetName write SetName;
    property Date: TgtPDDate read GetDate;
    property Color: TgtPDColorValue read GetColor write SetColor;
    property OCMDL: TgtPDOCMD read GetOCMD;
    property AnnotType: TgtPDAnnotType read GetType write SetType;
    property Title: AnsiString read GetTitle write SetTitle;
    property Action: TgtPDAction read GetAction write SetAction;
    property AdditionalAction: TgtPDAction read GetAdditionalAction;
    property Page: TgtPDElement read GetPage;
    property Flags: TgtPDAnnotFlags read GetFlags write SetFlags;
    property BorderStyle: TgtAnnotBorderStyle read GetBorderStyle
      write SetBorderStyle;
    property BorderWidth: Double read GetBorderWidth write SetBorderWidth;
  end;

  //List where all annotation objects are stored
  TgtPDAnnotList = TObjectList;

 (**
  * A callback Event for ImportNotes(). It determines whether an annotation will
  * be imported.
  *
  * @param Document The document into which annotations may be imported.
  * @param Page The page in which the annotation may be imported.
  * @param Annot The annotation that may be imported.
  * @param Cancel True to stop importing
  *)
  TgtPDAnnotImportFilterEvent = procedure(Document: TgtObject;
    Page: TgtPDElement; Annot: TgtPDAnnot; var Cancel: Boolean) of object;

implementation

uses
{$IFDEF DEBUG}
  gtLogger,
{$ENDIF}
  gtMethods, gtConstants, PDDocument, PDDictionary, PDConsts, PDArray,
  PDReal, PDInteger, PDName, PDIndirectRef, PDModelException, PDPage, PDPageTree,
  PDPolygonAnnot, PDSquareAnnot, PDCircleAnnot, PDMarkUpAnnot, PDPolyLineAnnot,
  PDHighlightAnnot, PDSquigglyAnnot, PDStrikeOutAnnot, PDUnderlineAnnot,
  PDCaretAnnot, PDFileAttachmentAnnot, PDSoundAnnot, PDMovieAnnot, PDScreenAnnot,
  PDPopUpAnnot, PDFormField, PDLineAnnot, PDLinkAnnot, PDTextAnnot,
  PDFreeTextAnnot, PDCatalog, PDState, PDForm, SysUtils;

{ TgtPDAnnot }

  (**
   *  Constructor
   *
   *  @param AParentDoc is the parent document with which this object need to
   *         be created
   *  @param AParentElement is the the parent element from where this object
   *         was called
   *  @param ABaseObject is the Annotation object
   *)

constructor TgtPDAnnot.Create(AParentDoc: TgtObject;
  AParentElement: TgtPDElement; ABaseObject: TgtPDBaseObject);
begin
  FParentDoc := AParentDoc;
  FParentElement := AParentElement;
  FBaseObject := ABaseObject;
  FRect := nil;
end;

  (**
   *  Destructor
   *)

constructor TgtPDAnnot.Create;
begin
  FRect := TgtPDRect.Create;
  FBorderWidth := 1;
end;

destructor TgtPDAnnot.Destroy;
begin
  if Assigned(FAction) then
    FreeObject(FAction);
  if Assigned(FAdditionalAction) then
    FreeObject(FAdditionalAction);
//  try
    if Assigned(FRect) then
      FRect.Free;
//  except
    // do nothing
//  end;
  inherited;
end;

procedure TgtPDAnnot.Display(OutDev: TgtPDExportDevice; hDPI, vDPI: Double);
//var
//  LState: TgtPDState;
begin
//  if Assigned(NormalAP) and Assigned(NormalAP.FormXObject) then
//  begin
//    LState := TgtPDState.Create(hDPI, vDPI, 0, NormalAP.DestRect);
//    try
//      LState.CTM.Dx := NormalAP.DestRect.Left;
//      LState.CTM.Dy := NormalAP.DestRect.Bottom;
//      OutDev.ResetDevice(LState);
//      OutDev.SaveState(LState);
//      OutDev.UpdateCTM(LState, LState.CTM);
//      OutDev.DrawFormXObject(LState, NormalAP.FormXObject as TgtPDForm);
//      OutDev.RestoreState(LState);
//    finally
//      LState.Free;
//    end;
//  end;
end;

(**
   *    This function returns an action object if there is any action specified
   *  for this object
   *
   *  @return TgtPDAction is the action object this dectionary defines
   *)

function TgtPDAnnot.GetAction: TgtPDAction;
var
  LActionObj: TgtPDBaseObject;
begin
  if not Assigned(FAction) then
  begin
    if Assigned(FBaseObject) then
    begin
      LActionObj := TgtPDDictionary(FBaseObject).LookUp(PDF_A);
      if Assigned(LActionObj) then
      begin
        FAction := TgtPDAction.MakeAction(FParentDoc, Self, LActionObj);
      end;
    end;
  end;
  Result := FAction;
end;

  (**
   *    This function returns the Additional Action object if there is any
   *  action specified for this object
   *
   *  @return TgtPDAction is the Additonal Action this dectionary defines
   *)

function TgtPDAnnot.GetAdditionalAction: TgtPDAction;
var
  LAddAction: TgtPDBaseObject;
begin
  if not Assigned(FAdditionalAction) then
  begin
    LAddAction := TgtPDDictionary(FBaseObject).LookUp(PDF_AA);
    if Assigned(LAddAction) then
    begin
      FAdditionalAction := TgtPDAction.MakeAction(FParentDoc, Self, LAddAction);
    end;
  end;

  Result := FAdditionalAction;
end;

function TgtPDAnnot.GetBorderStyle: TgtAnnotBorderStyle;
var
  LObj: TgtPDBaseObject;
  LBorderStyle: TgtPDBaseObject;
  LName: AnsiString;
begin
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_BS);
    if Assigned(LObj) and LObj.IsDict then
    begin
      LBorderStyle := TgtPDDictionary(LObj).LookUp(PDF_S);
      if LBorderStyle.IsName then
      begin
        LName := TgtPDName(LBorderStyle).Value;
        if LName = PDF_S then
          FBorderStyle := absSolid
        else if LName = PDF_D then
          FBorderStyle := absDashed
        else if LName = PDF_B then
          FBorderStyle := absBeveled
        else if LName = PDF_I then
          FBorderStyle := absInset
        else if LName = PDF_U then
          FBorderStyle := absUnderLine
      end;
    end;
  end;
  Result := FBorderStyle;
end;

function TgtPDAnnot.GetBorderWidth: Double;
var
  LObj: TgtPDBaseObject;
  LWidth: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_BS);
    if Assigned(LObj) and LObj.IsDict then
    begin
      LWidth := TgtPDDictionary(LObj).LookUp(PDF_W);
      if LWidth.IsReal then
        FBorderWidth := TgtPDReal(LWidth).Value
      else if LWidth.IsInteger then
        FBorderWidth := TgtPDInteger(LWidth).Value;
    end;
  end;
  Result := FBorderWidth;
end;

(**
  * Gets a note or link annotation's color. If the annotation does not specify
  * an explicit color, a default color is returned. Text annotations return
  * default yellow; all others return black.
  *
  * @param Color (Filled by the method) The annotation's color, which is used
  * as follows:
  *             Annotation - Use
  *             Closed text note - The icon background color.
  *             Open, un-selected text note - The bounding rectangle color.
  *             Open, selected text note - The color of the annotation's title bar.
  *             Link annotation - The link border color.
  * @return True if the annotation specifies an explicit color, False if a
  * default color was used.
  *
  * @exception EBadAnnotation if any error while parsing the annotation
  *)

function TgtPDAnnot.GetColor: TgtPDColorValue;
var
  LObj: TgtPDBaseObject;
  LColor: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_C);
    if Assigned(LObj) and LObj.IsArray then
    begin
      FColor.ColorSpace := DeviceRGB;
      LColor := TgtPDArray(LObj).Get(0);
      if LColor.IsReal then
        FColor.Value[0] := TgtPDReal(LColor).Value
      else if LColor.IsInteger then
        FColor.Value[0] := TgtPDInteger(LColor).Value;

      LColor := TgtPDArray(LObj).Get(1);
      if LColor.IsReal then
        FColor.Value[1] := TgtPDReal(LColor).Value
      else if LColor.IsInteger then
        FColor.Value[1] := TgtPDInteger(LColor).Value;

      LColor := TgtPDArray(LObj).Get(2);
      if LColor.IsReal then
        FColor.Value[2] := TgtPDReal(LColor).Value
      else if LColor.IsInteger then
        FColor.Value[2] := TgtPDInteger(LColor).Value;
    end;
  end;
  Result := FColor;
end;

function TgtPDAnnot.GetContents: AnsiString;
var
  LObj: TgtPDBaseObject;
begin
  if (FContents = '') then
  begin
    if Assigned(FBaseObject) then
    begin
      LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_CONTENTS);
      if Assigned(LObj) and LObj.IsString then
      begin
        if TgtPDString(LObj).IsHeXString then
          FContents := HexToString(TgtPDString(LObj).Value)
        else
          FContents := TgtPDString(LObj).Value;
      end;
    end;
  end;
  Result := FContents;
end;

(**
  * Gets an annotation's date.
  *
  * @param Date (Filled by the method) The annotation's time and date.
  *
  * @return true if the annotation contains a date key and the value of that key
  * can be successfully parsed as a date AnsiString, false otherwise.
  *
  * @exception EBadAnnotation if the annotation is not valid or if the value of
  * the annotation's M (ModDate) key is not a AnsiString.
  *)

function TgtPDAnnot.GetDate: TgtPDDAte;
var
  LObj: TgtPDBaseObject;
begin
  if not Assigned(FDate) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_M);
    if Assigned(LObj) and Lobj.IsString then
    begin
      if TgtPDString(LObj).IsHeXString then
        FDate := TgtPDDate.Create(HexToString(TgtPDString(LObj).Value))
      else
        FDate := TgtPDDate.Create(TgtPDString(LObj).Value);
    end;
  end;
  Result := FDate;
end;

function TgtPDAnnot.GetFlags: TgtPDAnnotFlags;
var
  LObj: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_F);
    if Assigned(LObj) and LObj.IsInteger then
    begin
      FFlags := [];
      if (TgtPdInteger(LObj).Value and $1) <> 0 then
        FFlags := FFlags + [afInvisible];
      if (TgtPdInteger(LObj).Value and $2) <> 0 then
        FFlags := FFlags + [afHidden];
      if (TgtPdInteger(LObj).Value and $4) <> 0 then
        FFlags := FFlags + [afPrint];
      if (TgtPdInteger(LObj).Value and $8) <> 0 then
        FFlags := FFlags + [afNoZoom];
      if (TgtPdInteger(LObj).Value and $10) <> 0 then
        FFlags := FFlags + [afNoRotate];
      if (TgtPdInteger(LObj).Value and $20) <> 0 then
        FFlags := FFlags + [afNoView];
      if (TgtPdInteger(LObj).Value and $40) <> 0 then
        FFlags := FFlags + [afReadOnly];
      if (TgtPdInteger(LObj).Value and $80) <> 0 then
        FFlags := FFlags + [afLocked];
      if (TgtPdInteger(LObj).Value and $100) <> 0 then
        FFlags := FFlags + [afToggleNoView];
      if (TgtPdInteger(LObj).Value and $200) <> 0 then
        FFlags := FFlags + [afLockedContents];
    end;
  end;
  Result := FFlags;
end;

(**
  * Gets an annotation's flags.
  *
  * @param Flags (Filled by the method) The annotation's Flags
  *
  * @return true if the annotation contains a Flag key false otherwise.
  *
  * @exception EBadAnnotation if any error while parsing the annotation
  *)


function TgtPDAnnot.GetName: AnsiString;
var
  LObj: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    if (FName = '') then
    begin
      LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_NM);
      if Assigned(LObj) and LObj.IsString then
      begin
        if TgtPDString(LObj).IsHeXString then
          FName := HexToString(TgtPDString(LObj).Value)
        else
          FName := TgtPDString(LObj).Value;
      end;
    end;
  end;
  Result := FName;
end;

function TgtPDAnnot.GetNormalAP: TgtPDAppearanceStream;
begin
//  if not Assigned(FNormalAP) then
//  begin
//    FNormalAP := TgtPDAppearanceStream.Create(ParentDoc, Self, Self.BaseObject);
//  end;
//  Result := FNormalAP;
end;

(**
  * Gets an optional-content membership dictionary (OCMD) object associated with
  * the annotation.
  *
  * @return The dictionary object, or Nil if the annotation does not contain a
  * dictionary.
  *
  * @exception EBadAnnotation if any error while parsing the annotation
  *)

function TgtPDAnnot.GetOCMD: TgtPDOCMD;
var
  LDictObj: TgtPDBaseObject;
begin
  if not Assigned(FOCMD) then
  begin
    LDictObj := TgtPDDictionary(FBaseObject).LookUp(PDF_OC);
    if Assigned(LDictObj) then
    begin
      if LDictObj.IsDict(PDF_OC) then
        FOCMD := TgtPDOCMD(LDictObj) // Change to TgtPDOCMD.Create(, , LDictObj)
      else
      begin
        raise ExBadAnnotation.Create(ErrBadAnnotation);
{$IFDEF DEBUG}
        Logger.LogError('OCMD is not a dictionary');
{$ENDIF}
      end;
    end;
  end;
  Result := FOCMD;
end;

function TgtPDAnnot.GetPage: TgtPDElement;
var
  LObj: TgtPDBaseObject;
begin
  if not Assigned(FPage) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookupRefObj(PDF_P);
    if Assigned(LObj) then
      FPage := TgtPDDocument(FParentDoc).GetPageByIndRef(LObj)
    else
    begin
      if FParentElement is TgtPDPage then
        FPage := FParentElement
      else
        FPage := nil;
    end;
  end;
  Result := FPage;
end;

function TgtPDAnnot.GetParentObj(AObject: TgtPDBaseObject): TgtPDBaseObject;
var
  LObj: TgtPDBaseObject;
begin
  Result := nil;
  LObj := TgtPDDictionary(AObject).LookUp(PDF_PARENT);
  if Assigned(LObj) then
    Result := GetParentObj(LObj);

end;

function TgtPDAnnot.GetRect: TgtPDRect;
var
  LObj, LKids, LPage: TgtPDBaseObject;
  LPageHt: Double;
  LI: Integer;
  LRect: TgtPDRect;

  procedure GetPageRect(AObject: TgtPDBaseObject);
  begin
    FRect := TgtPDRect.Create(TgtPDArray(AObject));
    LPageHt := 0;

    if Assigned(Page) then
      LPageHt := TgtPDPage(Page).GetPageHeight;

    // Converting to Windows Coordinates
    LRect := TgtPDRect.Create;
    LRect.Top := LPageHt - FRect.Top;
    LRect.Bottom := LPageHt - FRect.Bottom;
    LRect.Left := FRect.Left;
    LRect.Right := FRect.Right;
    FreeAndNil(FRect);
    FRect := LRect;
  end;
begin
  if Assigned(FBaseObject) then
  begin
    if (not Assigned(FRect) or (Assigned(FRect) and
      ((FRect.Left = -1) or (FRect.Top = -1) or(FRect.Right = -1) or (FRect.Bottom = -1))))  then
    begin
      LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_RECT);
      if not Assigned(LObj) then
      begin
        LKids := TgtPDDictionary(FBaseObject).LookUp(PDF_KIDS);
        if (Assigned(LKids) and (LKids.IsArray)) then
        begin
          for LI := (TgtPDArray(LKids).GetLength - 1) downto 0 do
          begin
            LPage := TgtPDDictionary(TgtPDArray(LKids).Get(LI)).LookUp(PDF_P);
            if Assigned(LPage) then
            begin
              if (LPage.ObjNumber = Page.BaseObject.ObjNumber) then
              begin
                LObj := TgtPDDictionary(TgtPDArray(LKids).Get(LI)).LookUp(PDF_RECT);
                if Assigned(LObj) and LObj.IsArray then
                begin
                  GetPageRect(LObj);
                  Break;
                end;
              end;
            end
            else
            begin
              LObj := TgtPDDictionary(TgtPDArray(LKids).Get(LI)).LookUp(PDF_RECT);
              if Assigned(LObj) and LObj.IsArray then
              begin
                GetPageRect(LObj);
                Break;
              end;
            end;
          end;
        end;
      end
      else if Assigned(LObj) and LObj.IsArray then
      begin
        GetPageRect(LObj);
      end;
    end;
  end;
  Result := FRect;
end;

(**
  * Gets the size and location of an annotation on its page.
  *
  * @return The rectangle that specifies the annotation's bounding rectangle,
  * specified in user space coordinates.
  *
  * @exception EBadAnnotation if any error while parsing the annotation
  *)



 (**
  * Gets an annotation's label text.
  *
  * @return The AnsiString that specifies the annotation's label text
  *
  * @exception EBadAnnotation if any error while parsing the annotation
  *)

function TgtPDAnnot.GetTitle: AnsiString;
var
  LTitleObject: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    if (FTitle = '') then
    begin
      LTitleObject := TgtPDDictionary(FBaseObject).LookUp(PDF_TITLE);
      if Assigned(LTitleObject) then
        if (LTitleObject.IsString) then
          FTitle := TgtPDString(LTitleObject).GetString
        else
        begin
          raise ExBadAnnotation.Create(ErrBadAnnotation);
{$IFDEF DEBUG}
          Logger.LogError('AnsiString Object expected');
{$ENDIF}
        end;
    end;
  end;
  Result := FTitle;
end;

 (**
  * Gets an annotation's type.
  *
  * @return The rectangle that specifies the annotation's bounding rectangle,
  * specified in user space coordinates.
  *
  * @exception EBadAnnotation if the annotation does not have a Subtype key or
  * its value is not a name object.
  *)

function TgtPDAnnot.GetType: TgtPDAnnotType;
var
  LObj: TgtPDBaseObject;
  LName: AnsiString;
begin
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_SUBTYPE);
    if Assigned(LObj) and LObj.isName then
    begin
      LName := TgtPDName(LObj).Value;
      if LName = PDF_TEXT then
        FAnnotType := annotText
      else if LName = PDF_LINK then
        FAnnotType := annotLink
      else if LName = PDF_FREETEXT then
        FAnnotType := annotFreeText
      else if LName = PDF_LINE then
        FAnnotType := annotLine
      else if LName = PDF_SQUARE then
        FAnnotType := annotSquare
      else if LName = PDF_CIRCLE then
        FAnnotType := annotCircle
      else if LName = PDF_POLYGON then
        FAnnotType := annotPolygon
      else if LName = PDF_POLYLINE then
        FAnnotType := annotPolyline
      else if LName = PDF_HIGHLIGHT then
        FAnnotType := annotHighLight
      else if LName = PDF_UNDERLINE then
        FAnnotType := annotUnderline
      else if LName = PDF_SQUIGGLY then
        FAnnotType := annotSquiggly
      else if LName = PDF_STRIKEOUT then
        FAnnotType := annotStrikeOut
      else if LName = PDF_STAMP then
        FAnnotType := annotStamp
      else if LName = PDF_CARET then
        FAnnotType := annotCaret
      else if LName = PDF_INK then
        FAnnotType := annotInk
      else if LName = PDF_POPUP then
        FAnnotType := annotPopUp
      else if LName = PDF_FILEATTACHMENT then
        FAnnotType := annotFileAttachment
      else if LName = PDF_SOUND then
        FAnnotType := annotSound
      else if LName = PDF_Movie then
        FAnnotType := annotMovie
      else if LName = PDF_WIDGET then
        FAnnotType := annotWidget
      else if LName = PDF_SCREEN then
        FAnnotType := annotScreen
      else if LName = PDF_PRINTERMARK then
        FAnnotType := annotPrinterMark
      else if LName = PDF_TRAPNET then
        FAnnotType := annotTrapNet
      else if LName = PDF_WATERMARK then
        FAnnotType := annotWaterMark
      else if LName = PDF_3D then
        FAnnotType := annot3D;
    end;
  end;
  Result := FAnnotType;
end;

 (**
  * Tests whether an annotation with an OC entry is visible in a given
  * optional-content context, considering the current ON-OFF states of the
  * optional-content groups in the optional-content dictionary (OCMD) and the
  * dictionary's visibility policy.
  *
  * @param OCContext The optional-content context in which the visibility is
  * tested.
  *
  * @return True if the annotation is visible in the given context or if the
  * annotation has no OC entry, false if it is hidden.
  *)

function TgtPDAnnot.IsCurrentlyVisible(OCContext: TgtPDOCContext): Boolean;
begin
  Result := False;
end;

 (**
  * Tests whether an annotation is valid.
  *
  * @return true if an Annot is a valid annotation object, false otherwise. An
  * annotation is valid if it is a Base dictionary object and has a Rect key.
  *)

function TgtPDAnnot.IsValid: Boolean;
var
  LObject: TgtPDBaseObject;
begin
  Result := False;
  if FBaseObject.IsDict(PDF_ANNOT) then
  begin
    LObject := TgtPDDictionary(FBaseObject).LookUp(PDF_RECT);
    if Assigned(LObject) then
    begin
      if LObject.IsArray then
        Result := True;
    end
    else
    begin
{$IFDEF DEBUG}
      Logger.LogError('Annotion Rect not defined or Array object expected');
{$ENDIF}
      Exit;
    end;
  end
  else
  begin
{$IFDEF DEBUG}
    Logger.LogError('Not an Annotion object');
{$ENDIF}
  end;

end;

class function TgtPDAnnot.MakeAnnot(AParentDoc: TgtObject;
  AParentElement: TgtPDElement; ABaseObject: TgtPDBaseObject): TgtPDAnnot;
var
  LObj: TgtPDBaseObject;
//  LKids: TgtPDBaseObject;
  LAnnotType: AnsiString;
//  LI: Integer;
//  LFormField: TgtPDFormField;
//  LInheritedProp: TgtPDInheritedProperty;
begin
  Result := nil;
  if Assigned(ABaseObject) then
  begin
    LObj := TgtPDDictionary(ABaseObject).LookUp(PDF_SUBTYPE);
//    LKids := TgtPDDictionary(ABaseObject).LookUp(PDF_KIDS);
    if Assigned(LObj) then
      LAnnotType := TgtPDName(LObj).Value
    else
      LAnnotType := PDF_WIDGET;

    if LAnnotType = PDF_POLYGON then
      Result := TgtPDPolygonAnnot.Create(AParentDoc, AParentElement, ABaseObject)
    else if LAnnotType = PDF_POLYlINE then
      Result := TgtPDPolyLineAnnot.Create(AParentDoc, AParentElement, ABaseObject)
    else if LAnnotType = PDF_SQUARE then
      Result := TgtPDSquareAnnot.Create(AParentDoc, AParentElement, ABaseObject)
    else if LAnnotType = PDF_CIRCLE then
      Result := TgtPDCircleAnnot.Create(AParentDoc, AParentElement, ABaseObject)
    else if LAnnotType = PDF_HIGHLIGHT then
      Result := TgtPDHighlightAnnot.Create(AParentDoc, AParentElement, ABaseObject)
    else if LAnnotType = PDF_SQUIGGLY then
      Result := TgtPDSquigglyAnnot.Create(AParentDoc, AParentElement, ABaseObject)
    else if LAnnotType = PDF_STRIKEOUT then
      Result := TgtPDStrikeOutAnnot.Create(AParentDoc, AParentElement, ABaseObject)
    else if LAnnotType = PDF_UNDERLINE then
      Result := TgtPDUnderlineAnnot.Create(AParentDoc, AParentElement, ABaseObject)
    else if LAnnotType = PDF_CARET then
      Result := TgtPDCaretAnnot.Create(AParentDoc, AParentElement, ABaseObject)
    else if LAnnotType = PDF_FILEATTACHMENT then
      Result := TgtPDFileAttachmentAnnot.Create(AParentDoc, AParentElement, ABaseObject)
    else if LAnnotType = PDF_SOUND then
      Result := TgtPDSoundAnnot.Create(AParentDoc, AParentElement, ABaseObject)
    else if LAnnotType = PDF_MOVIE then
      Result := TgtPDMovieAnnot.Create(AParentDoc, AParentElement, ABaseObject)
    else if LAnnotType = PDF_SCREEN then
      Result := TgtPDScreenAnnot.Create(AParentDoc, AParentElement, ABaseObject)
    else if LAnnotType = PDF_POPUP then
      Result := TgtPDPopUpAnnot.Create(AParentDoc, AParentElement, ABaseObject)
    else if LAnnotType = PDF_WIDGET then
    begin
      Result := TgtPDDocument(AParentDoc).GetFormFieldByRef(ABaseObject);
      if Assigned(Result) then
        Result.SetParentElement(AParentElement);
    end
    else if LAnnotType = PDF_LINE then
      Result := TgtPDLineAnnot.Create(AParentDoc, AParentElement, ABaseObject)
    else if LAnnotType = PDF_LINK then
      Result := TgtPDLinkAnnot.Create(AParentDoc, AParentElement, ABaseObject)
    else if LAnnotType = PDF_TEXT then
      Result := TgtPDTextAnnot.Create(AParentDoc, AParentElement, ABaseObject)
    else if LAnnotType = PDF_FREETEXT then
      Result := TgtPDFreeTextAnnot.Create(AParentDoc, AParentElement, ABaseObject);
  end;
end;

(**
   *  Sets the Annotation Flags
   *
   *  @param Value is the Flag(integer) set for that annotation
   *
   *  @return TgtPDAnnotFlags is the record containing Annotation's Flags
   *)
(*
function TgtPDAnnot.PDFlags(Value: Integer): TgtPDAnnotFlags;
begin
  with Result do
  begin
    Invisible := Boolean(Value and $1);
    Hidden := Boolean(Value and $2);
    Print := Boolean(Value and $4);
    NoZoom := Boolean(Value and $8);
    NoRotate := Boolean(Value and $10);
    NoView := Boolean(Value and $20);
    ReadOnly := Boolean(Value and $40);
    Locked := Boolean(Value and $80);
    ToggleNoView := Boolean(Value and $100);
    LockedContents := Boolean(Value and $200);
  end;

end;
*)

(**
  * Dissociates any optional-content membership dictionary (OCMD) object from
  * the annotation.
  *)

procedure TgtPDAnnot.RemoveOCMD;
begin

end;

 (**
  * Sets a note or link annotation's color.
  *
  * @param Color The annotation's color, which is used as follows:
  *   Annotation - Use
  *   Closed text note - The icon background color.
  *   Open, un-selected text note - The bounding rectangle color.
  *   Open, selected text note - The color of the annotation's title bar.
  *   Link annotation - The link border color.
  *
  *)

procedure TgtPDAnnot.SetAction(AValue: TgtPDAction);
begin
  FAction := AValue;
end;

procedure TgtPDAnnot.SetBaseObject(ABaseObject: TgtPDBaseObject);
begin
  FBaseObject := ABaseObject;
end;

procedure TgtPDAnnot.SetBorderStyle(const Value: TgtAnnotBorderStyle);
var
  LObj: TgtPDBaseObject;
  LBorderStyle: TgtPDBaseObject;
  LName: AnsiString;
begin
  case Value of
    absSolid:
      LName := PDF_S;
    absDashed:
      LName := PDF_D;
    absBeveled:
      LName := PDF_B;
    absInset:
      LName := PDF_I;
    absUnderLine:
      LName := PDF_U;
  end;
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_BS);
    if Assigned(LObj) and LObj.IsDict then
    begin
      LBorderStyle := TgtPDDictionary(LObj).LookUp(PDF_S);
      if Assigned(LBorderStyle) then
        TgtPDName(LBorderStyle).Value := LName
      else
      begin
        LBorderStyle := TgtPDName.Create(LName);
        TgtPDDictionary(LObj).Add(PDF_S, LBorderStyle);
      end;
    end
    else
    begin
      LObj := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);
      TgtPDDictionary(FBaseObject).Add(PDF_BS, LObj);
      LBorderStyle := TgtPDName.Create(LName);
      TgtPDDictionary(LObj).Add(PDF_S, LBorderStyle);
    end;
  end;
  FBorderStyle := Value;
end;

procedure TgtPDAnnot.SetBorderWidth(const Value: Double);
var
  LObj: TgtPDBaseObject;
  LBorderWidth: TgtPDBaseObject;
  LRealObj: TgtPDReal;
begin
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_BS);
    if Assigned(LObj) and LObj.IsDict then
    begin
      LBorderWidth := TgtPDDictionary(LObj).LookUp(PDF_W);
      if Assigned(LBorderWidth) then
      begin
        if LBorderWidth.IsReal then
          TgtPDReal(LBorderWidth).Value := Value
        else if LBorderWidth.IsInteger then
        begin
          LRealObj := TgtPDReal.Create(Value);
          TgtPDDictionary(LBorderWidth).SetKeyValue(PDF_W, LRealObj);
        end;
      end
      else
      begin
        LBorderWidth := TgtPDReal.Create(Value);
        TgtPDDictionary(LObj).Add(PDF_W, LBorderWidth);
      end;
    end
    else
    begin
      LObj := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);
      TgtPDDictionary(FBaseObject).Add(PDF_BS, LObj);
      LBorderWidth := TgtPDReal.Create(Value);
      TgtPDDictionary(LObj).Add(PDF_W, LBorderWidth);
    end;
  end;
  FBorderWidth := Value;
end;

procedure TgtPDAnnot.SetColor(const Color: TgtPDColorValue);
var
  LObj: TgtPDBaseObject;
  LColor: TgtPDBaseObject;
  LRealObj: TgtPDReal;
begin
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_C);
    if Assigned(LObj) then
    begin
      LColor := TgtPDArray(LObj).Get(0);
      if LColor.IsReal then
      begin
        TgtPDReal(LColor).Value := Color.Value[0];
      end
      else
      begin
        TgtPDArray(LObj).Remove(0);
        LColor := TgtPDReal.Create(Color.Value[0]);
        TgtPDArray(LObj).Insert(LColor, 0);
      end;
      LColor := TgtPDArray(LObj).Get(1);
      if LColor.IsReal then
      begin
        TgtPDReal(LColor).Value := Color.Value[1];
      end
      else
      begin
        TgtPDArray(LObj).Remove(1);
        LColor := TgtPDReal.Create(Color.Value[1]);
        TgtPDArray(LObj).Insert(LColor, 1);
      end;
      LColor := TgtPDArray(LObj).Get(2);
      if LColor.IsReal then
      begin
        TgtPDReal(LColor).Value := Color.Value[2];
      end
      else
      begin
        TgtPDArray(LObj).Remove(2);
        LColor := TgtPDReal.Create(Color.Value[2]);
        TgtPDArray(LObj).Add(LColor);
      end;
    end
    else
    begin
      LObj := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
      LRealObj := TgtPDReal.Create(Color.Value[0]);
      TgtPDArray(LObj).Add(LRealObj);
      LRealObj := TgtPDReal.Create(Color.Value[1]);
      TgtPDArray(LObj).Add(LRealObj);
      LRealObj := TgtPDReal.Create(Color.Value[2]);
      TgtPDArray(LObj).Add(LRealObj);
      TgtPDDictionary(FBaseObject).Add(PDF_C, LObj);
    end;
  end;
  FColor := Color;
end;

procedure TgtPDAnnot.SetContents(AContents: AnsiString);
var
  LObj: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_CONTENTS);
    if Assigned(LObj) then
    begin
      TgtPDString(LObj).Value := AContents;
    end
    else
    begin
      LObj := TgtPDString.Create(AContents);
      TgtPDDictionary(FBaseObject).Add(PDF_CONTENTS, LObj);
    end;
  end;
  FContents := AContents;
end;


 (**
  * Sets an annotation's flags.
  *
  * @param Flags The annotations Flags
  *
  *)

procedure TgtPDAnnot.SetFlags(AFlags: TgtPDAnnotFlags);
var
  LObj: TgtPDBaseObject;
  LFlag: Integer;
begin
  FFlags := AFlags;
  if Assigned(FBaseObject) then
  begin
    LFlag := 0;
    if afInvisible in AFlags then
      LFlag := LFlag or 1;
    if afHidden in AFlags then
      LFlag := LFlag or (1 shl 1);
    if afPrint in AFlags then
      LFlag := LFlag or (1 shl 2);
    if afNoZoom in AFlags then
      LFlag := LFlag or (1 shl 3);
    if afNoRotate in AFlags then
      LFlag := LFlag or (1 shl 4);
    if afNoView in AFlags then
      LFlag := LFlag or (1 shl 5);
    if afReadOnly in AFlags then
      LFlag := LFlag or (1 shl 6);
    if afLocked in AFlags then
      LFlag := LFlag or (1 shl 7);
    if afToggleNoView in AFlags then
      LFlag := LFlag or (1 shl 8);
    if afLockedContents in AFlags then
      LFlag := LFlag or (1 shl 9);

    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_F);
    if Assigned(LObj) and LObj.IsInteger then
    begin
      TgtPDInteger(LObj).Value := LFlag
    end
    else
    begin
      LObj := TgtPDInteger.Create(LFlag);
      TgtPDDictionary(FBaseObject).Add(PDF_F, LObj)
    end;
  end;
end;

procedure TgtPDAnnot.SetName(AName: AnsiString);
var
  LObj: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_NM);
    if Assigned(LObj) then
    begin
      TgtPDString(LObj).Value := AName;
    end
    else
    begin
      LObj := TgtPDString.Create(AName);
      TgtPDDictionary(FBaseObject).Add(PDF_NM, LObj);
    end;
  end;
  FName := AName;
end;

(**
  * Associates an optional-content membership dictionary (OCMD) object with the
  * annotation, making it optionally visible according to the OCMD's visibility
  * policy. If the annotation already has a dictionary, the method replaces it.
  *
  * @param OCMD The new OCMD dictionary.
  *
  *)

//procedure TgtPDAnnot.SetOCMD(OCMD: TgtPDOCMD);
//begin
//
//end;

procedure TgtPDAnnot.SetParentDoc(AParentDoc: TgtObject);
begin
  FParentDoc := AParentDoc;
end;

procedure TgtPDAnnot.SetParentElement(ParentElement: TgtPDElement);
begin
  FParentElement := ParentElement;
end;

(**
  * Sets the size and location of an annotation on its page.
  *
  * @param Box A rectangle that specifies the annotation's bounding rectangle,
  * specified in user space coordinates.
  *
  *)

//procedure TgtPDAnnot.SetRect(const Box: TgtPDRect);
//var
//  LObj: TgtPDBaseObject;
//  LValue: TgtPDBaseObject;
//  LReal: TgtPDBaseObject;
//begin
//  FRect := Box;
//  if Assigned(FBaseObject) then
//  begin
//    LObj := TGtPDDictionary(FBaseObject).LookUp(PDF_RECT);
//    if Assigned(LObj) then
//    begin
//      LValue := TgtPDArray(LObj).Get(0);
//      if LValue.IsReal then
//        TgtPDReal(LValue).Value := Box.Left
//      else
//      begin
//        LValue := TgtPDReal.Create(Box.Left);
//        TgtPDArray(LObj).Remove(0);
//        TgtPDArray(LObj).Insert(LValue, 0);
//      end;
//      LValue := TgtPDArray(LObj).Get(1);
//      if LValue.IsReal then
//        TgtPDReal(LValue).Value := Box.Right
//      else
//      begin
//        LValue := TgtPDReal.Create(Box.Right);
//        TgtPDArray(LObj).Remove(1);
//        TgtPDArray(LObj).Insert(LValue, 1);
//      end;
//
//      LValue := TgtPDArray(LObj).Get(2);
//      if LValue.IsReal then
//        TgtPDReal(LValue).Value := Box.Top
//      else
//      begin
//        LValue := TgtPDReal.Create(Box.Top);
//        TgtPDArray(LObj).Remove(2);
//        TgtPDArray(LObj).Insert(LValue, 2);
//      end;
//
//      LValue := TgtPDArray(LObj).Get(3);
//      if LValue.IsReal then
//        TgtPDReal(LValue).Value := Box.Bottom
//      else
//      begin
//        LValue := TgtPDReal.Create(Box.Bottom);
//        TgtPDArray(LObj).Remove(3);
//        TgtPDArray(LObj).Add(LValue);
//      end;
//    end;
//  end;
//end;

 (**
  * Sets an annotation's label text.
  *
  * @param Title The AnsiString containing the label to set.
  *
  *)

procedure TgtPDAnnot.SetTitle(const Title: AnsiString);
var
  LObj: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_NM);
    if Assigned(LObj) then
      TgtPDString(LObj).Value := Title
    else
    begin
      LObj := TgtPDString.Create(Title, False);
      TgtPDDictionary(FBaseObject).Add(PDF_NM, LObj);
    end;
  end;
  FTitle := Title;
end;

procedure TgtPDAnnot.SetType(const Value: TgtPDAnnotType);
begin
  FAnnotType := Value;
end;

(**
   *  procedure that updates the object prior to writing it to stream;
   *)

procedure TgtPDAnnot.Update;
var
  LObj: TgtPDBaseObject;
begin
  TgtPDDictionary(FBaseObject).Remove(PDF_PARENT);
  LObj := TgtPDIndirectRef.Create(FParentElement.BaseObject.ObjNumber,
    FParentElement.BaseObject.GenNumber);
  TgtPDDictionary(FBaseObject).Add(PDF_PARENT, LObj);
end;

end.
