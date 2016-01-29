{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Base                    }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

unit PDCatalog;
{$I ..\Utils\gtCompilerDefines.inc}

interface

uses
  Classes, SysUtils, gtObject, PDElement, PDBaseObject, PDDictionary, PDPageTree, PDBookmark, PDPage,
  PDTypes, PDViewerPreference, Contnrs, PDFormField, PDAction, PDDestination,
  PDXFADocument {$IFDEF VCL6ORABOVE},XMLIntf{$ENDIF}, gtFont;

type
  TgtFormFieldRefs = TObjectList;

 (**
  * This Class represents the catalog dictionary which is the Root of a document’s
  * object hierarchy. The catalog contains references to Catalog Dictionary
  * Entries. It contains information about how the document should be displayed
  * on the screen
  *)

  TgtPDCatalog = class(TgtPDElement)
  private
    FPageTree: TgtPDPageTree;
    FBookmarkRoot: TgtPDBookmark;
    FPageLayout: TgtPDLayoutMode;
    FPageMode: TgtPDPageMode;
    FMetadata: TStream;
    FViewerPref: TgtPDViewerPref;
    FAcroFormFields: TgtPDBaseObject;
    {$IFDEF VCL6ORABOVE}
    FPDXFADoc: TgtPDXFADocument;
    {$ENDIF}
    function GetPageTree: TgtPDPageTree;
    function GetBookmarkRoot: TgtPDBookmark;
    function GetPage(PageNumber: Integer): TgtPDPage;
    function GetPageLayout: TgtPDLayoutMode;
    function GetPageMode: TgtPDPageMode;
    function GetMetadata: TStream;
    procedure SetPageLayout(Value: TgtPDLayoutMode);
    procedure SetPageMode(Value: TgtPDPageMode);
    function GetViewerPref: TgtPDViewerPref;
    function GetAcroFormFieldDict: TgtPDBaseObject;
    function GetDefaultAppearance(ADAString: string;
      AFontDict: TgtPDBaseObject): TgtFont;

    procedure ProcessAcroFormField(AcroFormDict: TgtPDDictionary);
    procedure ProcessField(AFormField: TgtPDFormField; ABaseObject: TgtPDBaseObject;
      var FieldRec: TgtFormFieldVals); overload;
    {$IFDEF VCL6ORABOVE}
    procedure ProcessField(ARootNode: IXMLNode; var AFieldRec: TgtFormFieldVals); overload;
    {$ENDIF}
    function CreateActionDict(AAction: TgtPDAction): TgtPDBaseObject;
    function CreateDestArray(ADestination: TgtPDDestination): TgtPDBaseObject;
    function InsertNewBookmark(const Title: AnsiString; var ADestination: TgtPDDestination;
      var AOutlineFlag: TgtPDOutlineFlag; Action: TgtPDAction): TgtPDBookmark;
    {$IFDEF VCL6ORABOVE}
    function GetPDXFADoc: TgtPDXFADocument;
    {$ENDIF}
  protected
    FFormFieldList: TObjectList;
  public
    constructor Create(AParentDoc: TgtObject; AParentElement: TgtPDElement;
      ABaseObject: TgtPDBaseObject);
    destructor Destroy; override;
    procedure Update; override;
    function GetAcroFormField(AFormFieldObj: TgtPDBaseObject): TgtPDFormField;

    function CreateNewBookmark(const Title: AnsiString; var ADestination: TgtPDDestination;
      var AOutlineFlag: TgtPDOutlineFlag): TgtPDBookmark; overload;
    function CreateNewBookmark(const Title: AnsiString; Action: TgtPDAction;
      var AOutlineFlag: TgtPDOutlineFlag): TgtPDBookmark; overload;

    procedure SetXMPMetadata(const Metadata: AnsiString);
    procedure AddAction(AAction: TgtPDAction; ATriggerType: TgtDocActionTrigger);
    procedure RemoveAction(ATriggerType: TgtDocActionTrigger);

    property PageTree: TgtPDPageTree read GetPageTree;
    property BookmarkRoot: TgtPDBookmark read GetBookmarkRoot;
    property Pages[PageNumber: Integer]: TgtPDPage read GetPage;

    property PageLayout: TgtPDLayoutMode read GetPageLayout write SetPageLayout;
    property PageMode: TgtPDPageMode read GetPageMode write SetPageMode;
    property Metadata: TStream read GetMetadata;
    property AcroFormField: TgtPDBaseObject read GetAcroFormFieldDict;
    {$IFDEF VCL6ORABOVE}
    property PDXFADoc: TgtPDXFADocument read GetPDXFADoc;
    {$ENDIF}

    property ViewerPref: TgtPDViewerPref read GetViewerPref;
  end;

var
  E: Exception;

implementation

uses
  gtMethods, MemoryStream, PDStream, PDString, gtConstants,
  PDBaseDoc, PDName, PDInteger, PDDocument, PDArray, PDIndirectRef,
  PDJavaScriptAction, PDBoolean, PDReal, PDURIAction, PDGoToAction, PDGoToRemoteAction,
  PDLaunchAction, Graphics, PDParser, PDLexer;

{ TgtPDCatalog }

(**
 *  Constructor
 *  @param AParentDoc parent document of this object
 *  @param AParentElement parent element of this object
 *  @param ABaseObject object defining this object
 *  @algorithm
 *         1.	Start
 *         2.	FParentDoc := AParentDoc
 *         3.	FBaseObject := ABaseObject
 *         4.	FParentElement := AParentElement
 *         5.	FPageMode := pmNone
 *         6.	FPageLayout := lmNone
 *         7.	End
 *
 *)
type

 THackgtPDFormField = class(TgtPDFormField)

 end;

procedure TgtPDCatalog.AddAction(AAction: TgtPDAction;
  ATriggerType: TgtDocActionTrigger);
var
  LObj: TgtPDBaseObject;
  LActionDict: TgtPDDictionary;
begin
  if ATriggerType <> atBeforeDocOpen then
  begin
    if AAction.ActionType <> actionJavaScript then
      raise E.Create('Java Script Action required');

    if Assigned(FBaseObject) then
    begin
      LActionDict := TgtPDDictionary.Create(TgtPDDocument(FParentDoc));
      LActionDict.Add(PDF_S, TgtPDName.Create(PDF_JAVASCRIPT));
      LActionDict.Add(PDF_JS,
        TgtPDString.Create(TgtPDJavaScriptAction(AAction).JavaScript, False));
      LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_AA);
      if Assigned(LObj) then
      begin
        case ATriggerType of
          atBeforeDocClose:
            begin
              TgtPDDictionary(LObj).SetKeyValue(PDF_WC, LActionDict);
            end;

          atBeforeDocSave:
            begin
              TgtPDDictionary(LObj).SetKeyValue(PDF_WS, LActionDict);
            end;

          atAfterDocSave:
            begin
              TgtPDDictionary(LObj).SetKeyValue(PDF_DS, LActionDict);
            end;

          atBeforeDocPrint:
            begin
              TgtPDDictionary(LObj).SetKeyValue(PDF_WP, LActionDict);
            end;

          atAfterDocPrint:
            begin
              TgtPDDictionary(LObj).SetKeyValue(PDF_DP, LActionDict);
            end;
        end;
      end
      else // No AA Dict
      begin
        LObj := TgtPDDictionary.Create(TgtPDDocument(FParentDoc));
        case ATriggerType of
          atBeforeDocClose:
            begin
              TgtPDDictionary(LObj).Add(PDF_WC, LActionDict);
            end;

          atBeforeDocSave:
            begin
              TgtPDDictionary(LObj).Add(PDF_WS, LActionDict);
            end;

          atAfterDocSave:
            begin
              TgtPDDictionary(LObj).Add(PDF_DS, LActionDict);
            end;

          atBeforeDocPrint:
            begin
              TgtPDDictionary(LObj).Add(PDF_WP, LActionDict);
            end;

          atAfterDocPrint:
            begin
              TgtPDDictionary(LObj).Add(PDF_DP, LActionDict);
            end;
        end;
        TgtPDDictionary(FBaseObject).Add(PDF_AA, LObj);
      end;
    end;
  end
  else if ATriggerType = atBeforeDocOpen then
  begin
    if Assigned(FBaseObject) then
      TgtPDDictionary(FBaseObject).SetKeyValue(PDF_OPENACTION,
        CreateActionDict(AAction));
  end;

end;

constructor TgtPDCatalog.Create(AParentDoc: TgtObject; AParentElement: TgtPDElement;
  ABaseObject: TgtPDBaseObject);
begin
  FParentDoc := AParentDoc;
  FBaseObject := ABaseObject;
  FParentElement := AParentElement;
  FPageMode := pmNone;
  FPageLayout := lmNone;
end;



function TgtPDCatalog.CreateActionDict(AAction: TgtPDAction): TgtPDBaseObject;
var
  LDict: TgtPDDictionary;
  LArray: TgtPDArray;
  LPage: TgtPDPage;
begin
  Result := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);
  with TgtPDDictionary(Result) do
  begin
    Add(PDF_Type, TgtPDName.Create(PDF_ACTION));
    case AAction.ActionType of
      actionNone: ;
      actionGoTo:
        begin
          Add(PDF_S, TgtPDName.Create(PDF_GOTO));
          LArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
          with TgtPDGoToAction(AAction).Destination do
          begin
            LPage := TgtPDPage(Page);
            Rect.Top := LPage.GetPageHeight - Rect.Top;
            Rect.Bottom := LPage.GetPageHeight - Rect.Top;
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
          with TgtPDGoToRemoteAction(AAction).Destination do
          begin
            LPage := TgtPDPage(Page);
            Rect.Top := LPage.GetPageHeight - Rect.Top;
            Rect.Bottom := LPage.GetPageHeight - Rect.Top;
            case DisplayOptions of
              FitZoom:
                begin
                  LArray.Add(TgtPDInteger.Create(TgtPDGoToRemoteAction(AAction).PageNum));
                  LArray.Add(TgtPDName.Create(PDF_XYZ));
                  LArray.Add(TgtPDReal.Create(Rect.Left));
                  LArray.Add(TgtPDReal.Create(Rect.Top));
                  LArray.Add(TgtPDReal.Create(Rect.Right)); // Zoom is taken as right ??????
                end;
              FitAll:
                begin
                  LArray.Add(TgtPDInteger.Create(TgtPDGoToRemoteAction(AAction).PageNum));
                  LArray.Add(TgtPDName.Create(PDF_FIT));
                end;
              FitHeight:
                begin
                  LArray.Add(TgtPDInteger.Create(TgtPDGoToRemoteAction(AAction).PageNum));
                  LArray.Add(TgtPDName.Create(PDF_FITH));
                  LArray.Add(TgtPDReal.Create(Rect.Top));
                end;
              FitWidth:
                begin
                  LArray.Add(TgtPDInteger.Create(TgtPDGoToRemoteAction(AAction).PageNum));
                  LArray.Add(TgtPDName.Create(PDF_FITV));
                  LArray.Add(TgtPDReal.Create(Rect.Left));
                end;
              FitRect:
                begin
                  LArray.Add(TgtPDInteger.Create(TgtPDGoToRemoteAction(AAction).PageNum));
                  LArray.Add(TgtPDName.Create(PDF_FITR));
                  LArray.Add(TgtPDReal.Create(Rect.Left));
                  LArray.Add(TgtPDReal.Create(Rect.Bottom));
                  LArray.Add(TgtPDReal.Create(Rect.Right));
                  LArray.Add(TgtPDReal.Create(Rect.Top));
                end;
              FitBoundingBox:
                begin
                  LArray.Add(TgtPDInteger.Create(TgtPDGoToRemoteAction(AAction).PageNum));
                  LArray.Add(TgtPDName.Create(PDF_FITB));
                end;
              FitBoundingBoxHeight:
                begin
                  LArray.Add(TgtPDInteger.Create(TgtPDGoToRemoteAction(AAction).PageNum));
                  LArray.Add(TgtPDName.Create(PDF_FITBH));
                  LArray.Add(TgtPDReal.Create(Rect.Top));
                end;
              FitBoundingBoxWidth:
                begin
                  LArray.Add(TgtPDInteger.Create(TgtPDGoToRemoteAction(AAction).PageNum));
                  LArray.Add(TgtPDName.Create(PDF_FITBV));
                  LArray.Add(TgtPDReal.Create(Rect.Left));
                end;
            end;
          end;
          Add(PDF_D, LArray);
          Add(PDF_F, TgtPDString.Create(TgtPDGoToRemoteAction(AAction).FileName, False));
          Add(PDF_NEWWINDOW, TgtPDBoolean.Create(TgtPDGoToRemoteAction(AAction).
            OpenInNewWindow));
        end;
      actionGoToE: ;
      actionLaunch:
        begin
          LDict := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);
          Add(PDF_S, TgtPDName.Create(PDF_LAUNCH));
          if TgtPDLaunchAction(AAction).OpenInNewWindow then
            Add(PDF_NEWWINDOW, TgtPDBoolean.Create(True))
          else
            Add(PDF_NEWWINDOW, TgtPDBoolean.Create(False));
          LDict.Add(PDF_F, TgtPDString.Create(TgtPDLaunchAction(AAction).ApplicationToLaunch,
            False));
          case TgtPDLaunchAction(AAction).LaunchActionType of
            ltOpen: LDict.Add(PDF_O, TgtPDString.Create(PDF_OPEN, False));
            ltPrint: LDict.Add(PDF_O, TgtPDString.Create(PDF_PRINT, False));
          end;
          Add(PDF_WIN, LDict);
        end;
      actionThread: ;
      actionURI:
        begin
          Add(PDF_S, TgtPDName.Create(PDF_URI));
          Add(PDF_URI, TgtPDString.Create(TgtPDURIAction(AAction).URI, False));
          if TgtPDURIAction(AAction).TrackMousePointer then
            Add(PDF_ISMAP, TgtPDBoolean.Create(True))
          else
            Add(PDF_ISMAP, TgtPDBoolean.Create(False));
        end;
      actionSound: ;
      actionMovie: ;
      actionHide: ;
      actionNamed: ;
      actionSubmitForm: ;
      actionResetForm: ;
      actionImportData: ;
      actionJavaScript:
        begin
          Add(PDF_S, TgtPDName.Create(PDF_JAVASCRIPT));
          Add(PDF_JS, TgtPDString.Create(TgtPDJavaScriptAction(AAction).JavaScript, False));
        end;
      actionSetOCGState: ;
      actionRendition: ;
      actionTrans: ;
      actionGoTo3DView: ;
    end;
  end;
end;

function TgtPDCatalog.CreateDestArray(
  ADestination: TgtPDDestination): TgtPDBaseObject;
var
  LObj, LIndRef: TgtPDBaseObject;
begin
  //Add Page reference to Dest Array
  LObj := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
  LIndRef := TgtPDIndirectRef.Create(TgtPDPage(ADestination.Page).BaseObject.ObjNumber,
    TgtPDPage(ADestination.Page).BaseObject.GenNumber);
  TgtPDArray(LObj).Add(LIndRef);

  case ADestination.DisplayOptions of
    FitZoom:
      begin
        TgtPDArray(LObj).Add(TgtPDName.Create(PDF_XYZ));
        TgtPDArray(LObj).Add(TgtPDReal.Create(ADestination.Rect.Left));
        TgtPDArray(LObj).Add(TgtPDReal.Create(ADestination.Rect.Top));
        TgtPDArray(LObj).Add(TgtPDReal.Create(ADestination.Rect.Right));
      end;
    FitAll:
      begin
        TgtPDArray(LObj).Add(TgtPDName.Create(PDF_FIT));
      end;
    FitHeight:
      begin
        TgtPDArray(LObj).Add(TgtPDName.Create(PDF_FITH));
        TgtPDArray(LObj).Add(TgtPDReal.Create(ADestination.Rect.Top));
      end;
    FitWidth:
      begin
        TgtPDArray(LObj).Add(TgtPDName.Create(PDF_FITV));
        TgtPDArray(LObj).Add(TgtPDReal.Create(ADestination.Rect.Left));
      end;
    FitRect:
      begin
        TgtPDArray(LObj).Add(TgtPDName.Create(PDF_FITR));
        TgtPDArray(LObj).Add(TgtPDReal.Create(ADestination.Rect.Left));
        TgtPDArray(LObj).Add(TgtPDReal.Create(ADestination.Rect.Top));
        TgtPDArray(LObj).Add(TgtPDReal.Create(ADestination.Rect.Right));
        TgtPDArray(LObj).Add(TgtPDReal.Create(ADestination.Rect.Bottom));
      end;
    FitBoundingBox:
      begin
        TgtPDArray(LObj).Add(TgtPDName.Create(PDF_FITB));
      end;
    FitBoundingBoxHeight:
      begin
        TgtPDArray(LObj).Add(TgtPDName.Create(PDF_FITBH));
        TgtPDArray(LObj).Add(TgtPDReal.Create(ADestination.Rect.Top));
      end;
    FitBoundingBoxWidth:
      begin
        TgtPDArray(LObj).Add(TgtPDName.Create(PDF_FITBV));
        TgtPDArray(LObj).Add(TgtPDReal.Create(ADestination.Rect.Left));
      end;
  end;
  Result := LObj;
end;

function TgtPDCatalog.CreateNewBookmark(const Title: AnsiString;
  Action: TgtPDAction; var AOutlineFlag: TgtPDOutlineFlag): TgtPDBookmark;
var
  LDest: TgtPDDestination;
begin
  Result := InsertNewBookmark(Title, LDest, AOutlineFlag, Action);
end;

function TgtPDCatalog.CreateNewBookmark(const Title: AnsiString;
  var ADestination: TgtPDDestination;
  var AOutlineFlag: TgtPDOutlineFlag): TgtPDBookmark;
begin
  Result := InsertNewBookmark(Title, ADestination, AOutlineFlag, nil)
end;

destructor TgtPDCatalog.Destroy;
begin
  FreeObject(FPageTree);
  FreeObject(FBookmarkRoot);
  FreeObject(FFormFieldList);
  {$IFDEF VCL6ORABOVE}
  if Assigned(FPDXFADoc) then FreeObject(FPDXFADoc);
  {$ENDIF}
  inherited;
end;

function TgtPDCatalog.GetAcroFormField(AFormFieldObj: TgtPDBaseObject): TgtPDFormField;
var
  LObj: TgtPDBaseObject;
  LI: Integer;
begin
  Result := nil;
  if not Assigned(FAcroFormFields) then
    ProcessAcroFormField(GetAcroFormFieldDict as TgtPDDictionary);
  for LI := 0 to FFormFieldList.Count - 1 do
  begin
    if TgtPDFormField(FFormFieldList.Items[LI]).BaseObject.ObjNumber = AFormFieldObj.ObjNumber then
    begin
      Result := FFormFieldlist.Items[LI] as TgtPDFormField;
      Exit;
    end
    else
    begin
      LObj := TgtPDDictionary(AFormFieldObj).LookUp(PDF_PARENT);
      if Assigned(LObj) then
      begin
        if TgtPDFormField(FFormFieldList.Items[LI]).BaseObject.ObjNumber = LObj.ObjNumber then
        begin
          Result := FFormFieldlist.Items[LI] as TgtPDFormField;
          Exit;
        end;
      end;
    end;
  end;
end;

function TgtPDCatalog.GetAcroFormFieldDict: TgtPDBaseObject;
var
  LObj: TgtPDBaseObject;
begin
  if not Assigned(FAcroFormFields) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_ACROFORM);
    FAcroFormFields := LObj;
  end;

  Result := FAcroFormFields;
end;

function TgtPDCatalog.GetBookmarkRoot: TgtPDBookmark;
var
  LBookmarkDict: TgtPDBaseObject;
begin
  if not Assigned(FBookmarkRoot) then
  begin
    LBookmarkDict := TgtPDDictionary(FBaseObject).LookUp(PDF_OUTLINES);
    if Assigned(LBookmarkDict) then
    begin
      FBookmarkRoot := TgtPDBookmark.Create(FParentDoc, nil, LBookmarkDict);
    end
    else
    begin
      TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber :=
        TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber + 1;
      LBookmarkDict := TgtPDDictionary.Create(
        TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber, 0,
        TgtPDDocument(FParentDoc).BaseDoc);
      //Addto collection to get it from other places
      TgtPDDocument(FParentDoc).BaseDoc.AddToCollection(LBookmarkDict);
      FBookmarkRoot := TgtPDBookmark.Create(FParentDoc, nil, LBookmarkDict);
      TgtPDDictionary(Self.FBaseObject).Add(PDF_OUTLINES,
        TgtPDIndirectRef.Create(LBookmarkDict.ObjNumber, LBookmarkDict.GenNumber));
    end;
  end;

  Result := FBookmarkRoot;
end;

function TgtPDCatalog.GetDefaultAppearance(ADAString: string;
  AFontDict: TgtPDBaseObject): TgtFont;

  procedure GetFont(BaseFont: string; var Font: TgtFont);
  var
    LStr: string;
    LI: Integer;
  begin
    LI := 1;
    while not (BaseFont[LI] in [',', '-']) do
    begin
      LStr := LStr + BaseFont[LI];
      Inc(LI);
      if LI = Length(BaseFont) + 1 then Break;
    end;
    Font.Name := LStr;
    if System.Pos('Bold', BaseFont) <> 0 then
      Font.Style := Font.Style + [fsBold];

    if System.Pos('Italic', BaseFont) <> 0 then
      Font.Style := Font.Style + [fsItalic];
  end;

var
  LStream: TMemoryStream;
  LgtStream: TgtMemoryStream;
  LParser: TgtPDParser;
  LLexer: TgtPDLexer;
  LObj: TgtPDBaseObject;
  LColor: array of Integer;
  LI, LJ: Integer;
  LObjects: TgtPDBaseObjects;
begin
  Result := TgtFont.Create;
  LStream := TMemoryStream.Create;
  LStream.Write(ADAString[1], Length(ADAString));
  LgtStream := TgtMemoryStream.Create(LStream, 0, 0, False);
  LgtStream.Reset;
  LLexer := TgtPDLexer.Create(LgtStream);
  LParser := TgtPDParser.Create(nil, LLexer);

  LI := 0;
  repeat
    SetLength(LObjects, LI + 1);
    LObjects[LI] := LParser.GetObject();
    Inc(LI);
  until (LObjects[LI - 1].IsEOF);

  for LI := 0 to Length(LObjects) - 1 do
  begin
    if LObjects[LI].IsName then
    begin
      LObj := TgtPDDictionary(AFontDict).LookUp(TgtPDName(LObjects[LI]).Value);
      if Assigned(LObj) then
      begin
        LObj := TgtPDDictionary(LObj).LookUp(PDF_BASEFONT);
        if (Assigned(LObj) and (LObj.IsName)) then
          GetFont(TgtPDName(LObj).Value, Result);
      end;
    end
    else if LObjects[LI].IsCommand(PDF_TF) then
    begin
      if LObjects[LI - 1].IsInteger then
        Result.Size := TgtPDInteger(LObjects[LI - 1]).Value
      else if LObjects[LI - 1].IsReal then
        Result.Size := Round(TgtPDReal(LObjects[LI - 1]).Value);
    end
    else if LObjects[LI].IsCommand(PDF_RG) then
    begin
      LJ := 0;
      while ((not LObjects[LI - (LJ + 1)].IsCommand) and
        (not LObjects[LI - (LJ + 1)].IsName) and
        (not LObjects[LI - (LJ + 1)].IsEOF)) do
      begin
        SetLength(LColor, (LJ + 1));
        if LObjects[LI - (LJ + 1)].IsInteger then
          LColor[LJ] := TgtPDInteger(LObjects[LI - (LJ + 1)]).Value * $10000
        else if LObjects[LI - (LJ + 1)].IsReal then
          LColor[LJ] := Round(TgtPDReal(LObjects[LI - (LJ + 1)]).Value) * $10000;
        Inc(LJ);
      end;
      //RGB
      if Length(LColor) = 3 then
      begin
        Result.Color := LColor[0] shl 16 or LColor[1] shl 8 or LColor[2];
      end;
    end;
  end;

  for LI := 0 to Length(LObjects) - 1 do
  begin
    FreeAndNil(LObjects[LI]);
  end;
  SetLength(LObjects, 0);
  FreeAndNil(LParser);
end;

(**
 *  Gets the metadata from the Document
 *  @return TStream the metadata
 *  @algorithm
 *           1. Start
 *           2. IF NOT Assigned FMetadata Then
 *             a. LMetaData:= In FBaseObject LookUp for Metadata
 *             b. IF Assigned LMetaData Then
 *             c. begin
 *               i. Create MemoryStream with FMetadata
 *               ii.	Create TgtMemoryStream with LgtMemStrm(FMetadata, 0,  0, False)
 *               iii. In LmetaData LookUp for Length
 *               iv.	With LgtMemStrm
 *               v. begin
 *                 1. LLength := In GetDict LookUp for LLength
 *                 2. CopyFrom(LMetadata.GetStream, LLenth)
 *               vi.	End
 *               vii. Free LgtMemStrm
 *             d. End
 *           3. End
 *           4. Return FMetadata
 *           5. End
 *
 *)

function TgtPDCatalog.GetMetadata: TStream;
var
  LMetadataObj, LObj: TgtPDBaseObject;
  LgtMemStrm: TgtMemoryStream;
  LLength: Integer;
begin
  if not Assigned(FMetadata) then
  begin
    LMetadataObj := TgtPDDictionary(FBaseObject).LookUp(PDF_METADATA);
    if Assigned(LMetadataObj) then
    begin
      FMetadata := TMemoryStream.Create;
      LgtMemStrm := TgtMemoryStream.Create(TMemoryStream(FMetadata), 0, 0, False, False);
      LObj := TgtPDDictionary(TgtPDStream(LMetadataObj).GetDict).LookUp(PDF_LENGTH);
      LLength := TgtPDInteger(LObj).Value;
      LgtMemStrm.CopyFrom(TgtPDStream(LMetadataObj).GetStream, LLength);
      FreeObject(LgtMemStrm);
    end;
  end;
  Result := FMetadata;
end;

(**
 *  Gets the page object of the pdf
 *  @param PageNumber is the page number the need to be returned
 *  @return The page object
 *  @algorithm
 *           1.	Start
 *           2.	Return PageTree.GetPage(PageNumber)
 *           3.	End
 *
 *)

function TgtPDCatalog.GetPage(PageNumber: Integer): TgtPDPage;
begin
  Result := PageTree.GetPage(PageNumber);
end;

(**
 *  Gets the pagelayout
 *  @return The page layout object
 *  @algorithm
 *           1.	Start
 *           2.	IF FPageLayout  = plNone Then
 *           3.	begin
 *             a.	LObj := In FBaseObject LookUp for PageLayout
 *             b.	IF Assigned LObj Then
 *             c.	begin
 *               i.	IF LObj.Value = SinglePage Then
 *                 1.	FPageLayout := plSinge
 *               ii.	ELSE IF LObj.Value =  OneColumn Then
 *                 1.	FPageLayout := plOneColumn
 *               iii.	ELSE IF LObj.Value = TwoColumnLeft Then
 *                 1.	FPageLayout := plTwoColumnLeft
 *               iv.	ELSE IF LObj.Value = TwoColumnRight Then
 *                 1.	FPageLayout := plTwoColumnRight
 *               v.	ELSE IF LObj.Value = TwoPageLeft Then
 *                 1.	FPageLayout := plTwoPageLeft
 *               vi.	ELSE IF LObj.Value = TwoPageRight Then
 *                 1.	FPageLayout := plTwoPageRight
 *               vii.	ELSE
 *                 1.	FPageLayout := plNone
 *             d.	End
 *           4.	End
 *           5.	Return FPageLayout
 *           6.	End
 *
 *)

function TgtPDCatalog.GetPageLayout: TgtPDLayoutMode;
var
  LObj: TgtPDBaseObject;
  LLayoutName: AnsiString;
begin
  if (FPageLayout = lmNone) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_PAGELAYOUT);
    if Assigned(LObj) then
    begin
      LLayoutName := TgtPDName(LObj).Value;
      if LLayoutName = PDF_SINGLEPAGE then
        FPageLayout := lmSinglePage
      else if LLayoutName = PDF_TWOCOLOMNLEFT then
        FPageLayout := lmTwoColumnLeft
      else if LLayoutName = PDF_TWOCOLOMNRIGHT then
        FPageLayout := lmTwoColumnRight
      else if LLayoutName = PDF_TWOPAGELEFT then
        FPageLayout := lmTwoPageLeft
      else if LLayoutName = PDF_TWOPAGERIGHT then
        FPageLayout := lmTwoPageRight
      else
        FPageLayout := lmNone;
    end;
  end;
  Result := FPageLayout;
end;

(**
 *  Gets the pagemode
 *  @return The page mode object
 *  @algorithm
 *           1.	Start
 *           2.	IF FPageMode  = plNone Then
 *           3.	begin
 *             a.	LObj := In FBaseObject LookUp for PageMode
 *             b.	IF Assigned LObj Then
 *             c.	begin
 *               i.	IF LObj.Value = 'UseNone' Then
 *                 1.	FPageMode := pmUseNone
 *               ii.	ELSE IF LObj.Value =  'UseOutlines' Then
 *                 1.	FPageMode := pmUseBookmarks
 *               iii.	ELSE IF LObj.Value = 'UseThumb' Then
 *                 1.	FPageMode := pmUseThumbs
 *               iv.	ELSE IF LObj.Value = 'FullScreen' Then
 *                 1.	FPageMode := pmFullScreen
 *               v.	ELSE IF LObj.Value = 'UseOC' Then
 *                 1.	FPageMode := pmOCVisible
 *               vi.	ELSE IF LObj.Value = 'UseAttachments' Then
 *                 1.	FPageMode := pmAttachmentsVisible
 *               vii.	ELSE
 *                 1.	FPageMode := pmNone
 *             d.	End
 *           4.	End
 *           5.	Return FPageMode
 *           6.	End
 *
 *)

function TgtPDCatalog.GetPageMode: TgtPDPageMode;
var
  LObj: TgtPDBaseObject;
  LModeName: AnsiString;
begin
  if (FPageMode = pmNone) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_PAGEMODE);
    if Assigned(LObj) then
    begin
      LModeName := TgtPDName(LObj).Value;
      if LModeName = PDF_USENONE then
        FPageMode := pmUseNone
      else if LModeName = PDF_USEOUTLINES then
        FPageMode := pmUseBookmarks
      else if LModeName = PDF_USETHUMB then
        FPageMode := pmUseThumbs
      else if LModeName = PDF_FULLSCREEN then
        FPageMode := pmFullScreen
      else if LModeName = PDF_USEOC then
        FPageMode := pmOCVisible
      else if LModeName = PDF_USEATTACHMENTS then
        FPageMode := pmAttachmentsVisible
      else
        FPageMode := pmNone;
    end;
  end;
  Result := FPageMode;
end;

(**
 *  Gets the page tree object of the pdf file if not assigned
 *  @return The page tree object
 *  @algorithm
 *           1.	Start
 *           2.	IF NOT Assigned FPageTreeThen
 *             a.	LPagesObj := In FBaseObject LookUp for Pages
 *             b.	Create PageTree with FPageTree(FParentDoc, Self, LPagesObj)
 *           3.	End
 *           4.	Return FPageTree
 *           5.	End
 *
 *)

function TgtPDCatalog.GetPageTree: TgtPDPageTree;
var
  LObj: TgtPDBaseObject;
begin
  if not Assigned(FPageTree) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_PAGES);
    FPageTree := TgtPDPageTree.Create(FParentDoc, Self, LObj);
  end;
  Result := FPageTree;
end;

function TgtPDCatalog.GetViewerPref: TgtPDViewerPref;
var
  LObj: TgtPDBaseObject;
begin
  if not Assigned(FViewerPref) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_VIEWERPREFERENCE);
    if Assigned(LObj) then
      FViewerPref := TgtPDViewerPref.Create(FParentDoc, Self, LObj)
    else
    begin
      LObj := TgtPDDictionary.Create(Self);
      TgtPDDictionary(FBaseObject).Add(PDF_VIEWERPREFERENCE, LObj);
      FViewerPref := TgtPDViewerPref.Create(FParentDoc, Self,
        TgtPDDictionary(FBaseObject).LookUp(PDF_VIEWERPREFERENCE));
    end;
  end;
  Result := FViewerPref;
end;

{$IFDEF VCL6ORABOVE}
function TgtPDCatalog.GetPDXFADoc: TgtPDXFADocument;
var
  LArray: TgtPDBaseObject;
  LI, LLength, LPosition: Integer;
  LMemStream1, LMemStream2, LMemStream3, LDataStream, LTempStream: TMemoryStream;
  LgtMemStream1, LgtMemStream2, LgtMemStream3: TgtMemoryStream;
begin
  if not Assigned(FPDXFADoc) then
  begin
    if Assigned(AcroFormField) then
    begin
      LArray := TgtPDDictionary(FAcroFormFields).LookUp(PDF_XFA);

      if (Assigned(LArray) and (LArray.IsArray)) then
      begin
        try
          LDataStream := TMemoryStream.Create;
          LTempStream := TMemoryStream.Create;

          LMemStream1 := TMemoryStream.Create;
          LgtMemStream1 := TgtMemoryStream.Create(LMemStream1, 0, 0, False, True);

          LMemStream2 := TMemoryStream.Create;
          LgtMemStream2 := TgtMemoryStream.Create(LMemStream2, 0, 0, False, True);

          LMemStream3 := TMemoryStream.Create;
          LgtMemStream3 := TgtMemoryStream.Create(LMemStream3, 0, 0, False, True);

          for LI := 0 to TgtPDArray(LArray).GetLength - 1 do
          begin
            if TgtPDArray(LArray).Get(LI) is TgtPDString then
            begin

              if TgtPDString(TgtPDArray(LArray).Get(LI)).Value = 'preamble' then
              begin
                LLength := TgtPDInteger(TgtPDDictionary(TgtPDStream(TgtPDArray(LArray).
                  Get(LI + 1)).GetDict).LookUp(PDF_LENGTH)).Value;
                LgtMemStream1.CopyFrom(TgtPDStream(TgtPDArray(LArray).Get(LI + 1)).GetStream,
                  LLength);
                LMemStream1.Position := 0;

              end
              else if TgtPDString(TgtPDArray(LArray).Get(LI)).Value = 'config' then
              begin

              end
              else if TgtPDString(TgtPDArray(LArray).Get(LI)).Value = 'template' then
              begin
                LLength := TgtPDInteger(TgtPDDictionary(TgtPDStream(TgtPDArray(LArray).
                  Get(LI + 1)).GetDict).LookUp(PDF_LENGTH)).Value;
                LgtMemStream2.CopyFrom(TgtPDStream(TgtPDArray(LArray).Get(LI + 1)).GetStream,
                  LLength);
                LMemStream2.Position := 0;

              end
              else if TgtPDString(TgtPDArray(LArray).Get(LI)).Value = 'datasets' then
              begin
                LLength := TgtPDInteger(TgtPDDictionary(TgtPDStream(TgtPDArray(LArray).
                  Get(LI + 1)).GetDict).LookUp(PDF_LENGTH)).Value;
                LgtMemStream3.CopyFrom(TgtPDStream(TgtPDArray(LArray).Get(LI + 1)).GetStream,
                  LLength);
                LMemStream3.Position := 0;

              end
              else if TgtPDString(TgtPDArray(LArray).Get(LI)).Value = 'postamble' then
              begin

              end;
            end;
          end;

          LPosition := ParseMemStream(LMemStream1);

          LMemStream1.Position := 0;
          LTempStream.CopyFrom(LMemStream1, LPosition);
          LTempStream.CopyFrom(LMemStream2, LMemStream2.Size);
          LTempStream.Position := 0;

          LMemStream1.Position := 0;
          LDataStream.CopyFrom(LMemStream1, LPosition);
          LDataStream.CopyFrom(LMemStream3, LMemStream3.Size);
          LDataStream.Position := 0;

          FPDXFADoc := TgtPDXFADocument.Create(FParentDoc, Self,
            LDataStream, LTempStream);

        finally
          FreeAndNil(LgtMemStream1);
          FreeAndNil(LgtMemStream2);
          FreeAndNil(LgtMemStream3);
        end;
      end
      else if (Assigned(LArray) and (LArray.IsStream)) then
      begin

      end;
    end;
  end;
  Result := FPDXFADoc;
end;
{$ENDIF}

function TgtPDCatalog.InsertNewBookmark(const Title: AnsiString;
  var ADestination: TgtPDDestination; var AOutlineFlag: TgtPDOutlineFlag;
  Action: TgtPDAction): TgtPDBookmark;
var
  LObj: TgtPDBaseObject;
  LBookmarkDict: TgtPDDictionary;
  LFontFlag: Integer;
begin
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_OUTLINES);
    if not Assigned(LObj) then
    begin
      //Get the Last object no: that can be used
      TgtPDDocument(FParentDoc).LastObjectNumber :=
        TgtPDDocument(FParentDoc).LastObjectNumber + 1;
      //Newly created bookmark's Dict
      LBookmarkDict := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).LastObjectNumber,
        0, TgtPDDocument(FParentDoc).BaseDoc);
      //Add newly created Dict to Collection
      TgtPDDocument(FParentDoc).BaseDoc.AddToCollection(LBookmarkDict);

      //Add Title
      LObj := TgtPDString.Create(Title, False);
      LBookmarkDict.Add(PDF_TITLE, LObj);

      //SetFontStyle
      LFontFlag := 0;
      if AOutlineFlag.Bold then
        LFontFlag := 2;
      if AOutlineFlag.Italic then
        LFontFlag := LFontFlag or 1;
      LBookmarkDict.Add(PDF_F, TgtPDInteger.Create(LFontFlag));

      //Check if it is a ADestination, If it is an Action AddAction() Should be called
      if Assigned(ADestination) then
      begin
        if ADestination.DisplayOptions <> None then
        begin
          LBookmarkDict.Add(PDF_DEST, CreateDestArray(ADestination));
        end;
      end
      else if Assigned(Action) then
      begin
        LBookmarkDict.Add(PDF_A, CreateActionDict(Action));
      end;
      
      //Get the Last object no: that can be used
      TgtPDDocument(FParentDoc).LastObjectNumber :=
        TgtPDDocument(FParentDoc).LastObjectNumber + 1;
      LObj := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).LastObjectNumber,
        0, TgtPDDocument(FParentDoc).BaseDoc);
      //Add newly created Dict to Collection
      TgtPDDocument(FParentDoc).BaseDoc.AddToCollection(LObj);
      TgtPDDictionary(LObj).Add(PDF_FIRST, TgtPDIndirectRef.Create(
        LBookmarkDict.ObjNumber, LBookmarkDict.GenNumber));
      TgtPDDictionary(LObj).Add(PDF_LAST, TgtPDIndirectRef.Create(
        LBookmarkDict.ObjNumber, LBookmarkDict.GenNumber));
      TgtPDDictionary(LObj).Add(PDF_COUNT, TgtPDInteger.Create(1));

      TgtPDDictionary(FBaseObject).Add(PDF_OUTLINES, TgtPDIndirectRef.Create(
        LObj.ObjNumber, LObj.GenNumber));
      FBookmarkRoot := TgtPDBookmark.Create(FParentDoc, Self, LBookmarkDict);
    end
    else
      FBookmarkRoot := GetBookmarkRoot;
  end;
  Result := FBookmarkRoot;
end;

procedure TgtPDCatalog.ProcessAcroFormField(AcroFormDict: TgtPDDictionary);
var
//  LFontDict: TgtPDDictionary;
  LFieldArray: TgtPDArray;
  LObj: TgtPDBaseObject;
  LDAString: AnsiString;
  LI: Integer;
  LFieldRec: TgtFormFieldVals;
begin
  // Obtain the Default Resources Dictionary (Fonts)
  LObj := TgtPDDictionary(AcroFormDict).LookUp(PDF_DR);
  if Assigned(LObj) then
  begin
    LFieldRec.FontDict := TgtPDDictionary(LObj).LookUp(PDF_FONT);
  end;

  // Obtain the Default Appearance for Fields.
  LObj := TgtPDDictionary(AcroFormDict).LookUp(PDF_DA);
  if Assigned(LObj) then
  begin
    LDAString := TgtPDString(LObj).Value;
    LFieldRec.DAValue := LDAString;
  end;

//  if Assigned(PDXFADoc) then
//  begin
//    FFormFieldList := TObjectList.Create(True);
//    ProcessField(PDXFADoc.TempRootNode, LFieldRec);
//  end;
//  else

  begin
    LFieldArray := TgtPDDictionary(AcroFormDict).LookUp(PDF_FIELDS) as TgtPDArray;
    if Assigned(LFieldArray) then
    begin
      FFormFieldList := TObjectList.Create(True);
      for LI := 0 to LFieldArray.GetLength - 1 do
      begin
        LObj := LFieldArray.Get(LI);
        ProcessField(nil, LObj, LFieldRec);
        LFieldRec.FieldName := '';
        LFieldRec.DAValue := LDAString;
        LFieldRec.DefaultValue := '';
        LFieldRec.FFlag := 0;
        LFieldRec.FfFlag := 0;
      end;
    end;
  end;
end;
{$IFDEF VCL6ORABOVE}
procedure TgtPDCatalog.ProcessField(ARootNode: IXMLNode;
  var AFieldRec: TgtFormFieldVals);
var
  LI, LChildCount: Integer;
  LFormField: TgtPDFormField;
begin
  LChildCount := ARootNode.ChildNodes.Count;
  for LI := 0 to LChildCount - 1 do
  begin
    if (ARootNode.ChildNodes[LI].NodeName = 'field') then
    begin
      LFormField := TgtPDFormField.MakeFormField(ARootNode.ChildNodes[LI], AFieldRec);
      if Assigned(LFormField) then
      begin
        FFormFieldList.Add(LFormField);
      end;
    end
    else if ARootNode.ChildNodes[LI].HasChildNodes then
    begin
      ProcessField(ARootNode.ChildNodes[LI], AFieldRec);
    end;
  end;
end;
{$ENDIF}
procedure TgtPDCatalog.ProcessField(AFormField: TgtPDFormField; ABaseObject: TgtPDBaseObject;
  var FieldRec: TgtFormFieldVals);
var
  LFieldName: AnsiString;
  LFormField: TgtPDFormField;
  LObj, LObj2, LKidsArray: TgtPDBaseObject;
//  LFValue: Integer;
  LTempFieldName, LParentName: AnsiString;
  LI: Integer;
  LJ: Integer;
begin
  LFormField := nil;
  LObj := TgtPDDictionary(ABaseObject).LookUp(PDF_F);
  if Assigned(LObj) then
  begin
    FieldRec.FFlag := TgtPDInteger(LObj).Value;
  end;

  LObj := TgtPDDictionary(ABaseObject).LookUp(PDF_DV);
  if Assigned(LObj) then
  begin
    FieldRec.DefaultValue := TgtPDString(LObj).Value;
  end;

  LObj := TgtPDDictionary(ABaseObject).LookUp(PDF_DA);
  if Assigned(LObj) then
  begin
    FieldRec.DAValue := TgtPDString(LObj).Value;
  end;

  LObj := TgtPDDictionary(ABaseObject).LookUp(PDF_DR);
  if Assigned(LObj) then
  begin
    LObj2 := TgtPDDictionary(LObj).LookUp(PDF_FONT);
    if Assigned(LObj2) then
      FieldRec.FontDict := LObj2;
  end;

  //Create and asign a font info

  LObj := TgtPDDictionary(ABaseObject).LookUp(PDF_T);
  if Assigned(LObj) then
  begin
    if FieldRec.FieldName = '' then
    begin
      LTempFieldName := Copy(UpperCase(TgtPDString(LObj).Value), 1, 4); // LeftStr(UpperCase(TgtPDString(LObj).Value), 4);
      if LTempFieldName = 'FEFF' then
      begin
        LTempFieldName := '';
        LTempFieldName := FromUnicodeHexToStr(TgtPDString(LObj).Value);
        FieldRec.FieldName := LTempFieldName;
      end
      else
      begin
        if TgtPDString(LObj).IsHexString then
          LFieldName := HexToStr(TgtPDString(LObj).Value)
        else if ((LTempFieldName[1] = #254) and (LTempFieldName[2] = #255))then
          LFieldName := FromUnicodeHexToStr(TgtPDString(LObj).Value)
        else
          LFieldName := TgtPDString(LObj).Value;
        FieldRec.FieldName := LFieldName;
      end;
    end
    else
    begin
      LParentName := FieldRec.FieldName;
      LTempFieldName := Copy(UpperCase(FieldRec.FieldName), 1, 4);
      if LTempFieldName = 'FEFF' then
      begin
        LTempFieldName := '';
        LTempFieldName := FromUnicodeHexToStr(FieldRec.FieldName);
        FieldRec.FieldName := LTempFieldName;
      end
      else
        LFieldName := FromUnicodeHexToStr(TgtPDString(LObj).Value);
      LTempFieldName := '';
      LTempFieldName := Copy(UpperCase(TgtPDString(LObj).Value), 1, 4);
      if LTempFieldName = 'FEFF' then
      begin
        LTempFieldName := '';
        LTempFieldName := FromUnicodeHexToStr(TgtPDString(LObj).Value);
        LFieldName := FieldRec.FieldName;
        FieldRec.FieldName := FieldRec.FieldName + '.' + LTempFieldName; ;
      end
      else
      begin
//        LFieldName := FieldRec.FieldName;
        FieldRec.FieldName := FieldRec.FieldName + '.' + LFieldName;
      end;
    end;
  end;

  LObj := TgtPDDictionary(ABaseObject).LookUp(PDF_FT);
  if Assigned(LObj) then
  begin
    LFormField := TgtPDFormField.MakeFormField(FParentDoc, Self, ABaseObject, FieldRec);
    if Assigned(LFormField) then
    begin
      LFormField.FullQualifiedName := FieldRec.FieldName;
      FieldRec.FieldName := LParentName;
      THackgtPDFormField(LFormField).FFont :=
        GetDefaultAppearance(FieldRec.DAValue, FieldRec.FontDict);
      FFormFieldList.Add(LFormField);
    end;
  end;

  for LI := 0 to TgtPDDictionary(ABaseObject).GetLength - 1 do
  begin
    if TgtPDDictionary(ABaseObject).GetKey(LI) = PDF_KIDS then
    begin
      LKidsArray := TgtPDDictionary(ABaseObject).GetValue(LI);
      for LJ := 0 to TgtPDArray(LKidsArray).GetLength - 1 do
      begin
        ProcessField(LFormField, TgtPDArray(LKidsArray).Get(LJ), FieldRec);
      end;
    end;
  end;

end;

procedure TgtPDCatalog.RemoveAction(ATriggerType: TgtDocActionTrigger);
var
  LObj: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_AA);
    if Assigned(LObj) and LObj.IsDict then
    begin
      case ATriggerType of
        atBeforeDocClose: TgtPDDictionary(LObj).Remove(PDF_WC);

        atBeforeDocSave: TgtPDDictionary(LObj).Remove(PDF_WS);

        atAfterDocSave: TgtPDDictionary(LObj).Remove(PDF_DS);

        atBeforeDocPrint: TgtPDDictionary(LObj).Remove(PDF_WP);

        atAfterDocPrint: TgtPDDictionary(LObj).Remove(PDF_DP);
      end;
    end;
  end;
end;


procedure TgtPDCatalog.SetPageLayout(Value: TgtPDLayoutMode);
var
  LStr: AnsiString;
begin
  if Assigned(FBaseObject) then
  begin
    FPageLayout := Value;
    case FPageLayout of
      lmSinglePage: LStr := PDF_SINGLEPAGE;
      lmOneColumn: LStr := PDF_ONECOLUMN;
      lmTwoColumnLeft: LStr := PDF_TWOCOLOMNLEFT;
      lmTwoColumnRight: LStr := PDF_TWOCOLOMNRIGHT;
      lmTwoPageLeft: LStr := PDF_TWOPAGELEFT;
      lmTwoPageRight: LStr := PDF_TWOPAGERIGHT;
    end;
    TgtPDDictionary(FBaseObject).SetKeyValue(PDF_PAGELAYOUT, TgtPDName.Create(LStr));
  end;
end;

procedure TgtPDCatalog.SetPageMode(Value: TgtPDPageMode);
var
  LStr: AnsiString;
begin
  if Assigned(FBaseObject) then
  begin
    FPageMode := Value;
    case FPageMode of
      pmUseNone: LStr := PDF_USENONE;
      pmUseThumbs: LStr := PDF_USETHUMB;
      pmUseBookmarks: LStr := PDF_USEOUTLINES;
      pmFullScreen: LStr := PDF_FULLSCREEN;
      pmOCVisible: LStr := PDF_USEOC;
      pmAttachmentsVisible: LStr := PDF_USEATTACHMENTS;
    end;
    TgtPDDictionary(FBaseObject).SetKeyValue(PDF_PAGEMODE, TgtPDName.Create(LStr));
  end;
end;

procedure TgtPDCatalog.SetXMPMetadata(const Metadata: AnsiString);
var
//  LI: Integer;
  LMemStrm: TMemoryStream;
  LgtMemStrm: TgtMemoryStream;
  LDict, LMetaDataStream: TgtPDBaseObject;
  LIndRef: TgtPDIndirectRef;
begin
  //if TgtPDDocument(FParentDoc).GetXMPMetadata = '' then
  begin
    {
      If /Metadata entry is not found in the catalog, then add a new one.
      Create a metadata stream object, add the indirect reference as value
      to the /Metadata entry in the catalog dictionary
    }

    //Create a Dictionary object
    LDict := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);

    //Create a memeory stream with metadata given by the user
    LMemStrm := TMemoryStream.Create;
    LgtMemStrm := TgtMemoryStream.Create(LMemStrm, 0, 0, False);
    LgtMemStrm.Write(Metadata);
    LgtMemStrm.Reset;

    //Add the length entry
    TgtPDDictionary(LDict).Add(PDF_TYPE, TgtPDName.Create(PDF_METADATA));
    TgtPDDictionary(LDict).Add(PDF_SUBTYPE, TgtPDName.Create('XML'));
    TgtPDDictionary(LDict).Add(PDF_LENGTH, TgtPDInteger.Create(LMemStrm.Size));

    //Add new object number
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber := TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber + 1;

    //creates s stream object
    LMetaDataStream := TgtPDStream.Create(LgtMemStrm, LDict,
      TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber, 0);

    //Add it to the collection
    TgtPDDocument(FParentDoc).BaseDoc.AddToCollection(LMetaDataStream);

    LIndRef := TgtPDIndirectRef.Create(TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber, 0);
    TgtPDDictionary(FBaseObject).Add(PDF_METADATA, LIndRef);
  end;

end;

(**
 * Updates whatever changes done to original object
 *)

procedure TgtPDCatalog.Update;
begin
  if Assigned(FPageTree) then
    FPageTree.Update;
  if Assigned(FViewerPref) then
    FViewerPref.Update;
  {$IFDEF VCL6ORABOVE}
  if Assigned(FPDXFADoc) then
    FPDXFADoc.Update;
  {$ENDIF}
end;

end.
