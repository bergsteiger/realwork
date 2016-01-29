{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Model                   }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

{$I ..\Utils\gtCompilerDefines.inc}

unit PDPageTree;

interface

uses
  Contnrs, gtObject, PDBaseObject, PDElement, PDInteger, PDPage, PDRect,
  PDInheritedProperty, PDContents, PDContentStream;
//  {$IFDEF DLLPROJECT}
//  {$IFDEF COPYPROTECT}, EXECryptor {$ENDIF}
//  {$ENDIF};

type
  TgtPageInsertFlages = (InsertBookmarks, InsertThreads, InsertAll);

  TgtPDAuthorizeDocEvent = procedure(Document: TgtObject) of object;
  TgtRequestPagesEvent = procedure(Document: TgtObject; Page: TgtObject;
    var Cancel: Boolean) of object;


  {**
   *This class is responsible for traversing through all the pages in the array
   *and keep all the references in two lists with Page and References respectively
   *for any operation on a page
   *}

  TgtPDPageTree = class(TgtPDElement)
  private
    //Inherited properties from the parent object
    FInheritedProp: TgtPDInheritedProperty;

    //List of Page objects
    FPageList: TObjectList;
    //List of all page's references
    FPageRefs: TObjectList;
    //Page count
    FCount: TgtPDInteger;

    //List of Resources in the Document
    FPageResourceList: TObjectList;
    //List of Resource references
    FPageResourceRefs: TObjectList;

    FPageNumber: Integer;

    FTrialMarkObjNo: Integer;

    FIsChanged: Boolean;
    //Function to traverse through all the pages in the kid's array
    function ReadPageTree(APagesDict: TgtPDBaseObject; var AAlreadyRead:
      array of Boolean; AInherited: TgtPDInheritedProperty): Boolean;

    function GetCount: Integer;
    procedure InsertTrialMark;
    procedure StampGnosticeLogo;
    procedure UpdatePageNumbers(AFromPageNo: Integer);
  public
    constructor Create(AParentDoc: TgtObject; AParentElement: TgtPDElement;
      ABaseObject: TgtPDBaseObject);
    destructor Destroy; override;

    procedure Update; override;

    function GetPage(Index: Integer): TgtPDPage;
    function GetPageByIndRef(APageRef: TgtPDBaseObject): TgtPDPage;
    function CreatePage(AfterPage: Integer; MediaBox: TgtPDRect): TgtPDPage;
    procedure DeletePages(FirstPage: Integer; LastPage: Integer);
    procedure DeletePage(PageNumber: Integer);
    function GetPageBaseObject(PageNumber: Integer): TgtPDBaseObject;
    procedure InsertPages(AfterPage: Integer; SourceDoc: TgtObject;
      SourceStartPage, NumOfPages: Integer; InsertFlags: TgtPageInsertFlages);
    procedure InsertPage(AfterPage: Integer; Page: TgtPDPage;
      InserFlags: TgtPageInsertFlages);
    procedure MovePage(MoveToAfterPage: Integer; PageToMove: Integer);
    procedure ReplacePages(StartPage: Integer; SourceDoc: TgtObject;
      SourceStartPage, NumOfPages: Integer; MergeTextAnnots: Boolean);
    procedure RequestPages(StartPages: Integer; NumOfPages: Integer;
      RequestPagesEvent: TgtRequestPagesEvent);
    procedure StitchPages(AStitchToPage, AStitchFromPage: Integer);
    procedure StitchPagesSideBySide(AStitchToPage, AStitchFromPage: Integer);
    procedure CopyResource(AFromPage: Integer; AToPage: Integer);

    property InheritedProperty: TgtPDInheritedProperty read FInheritedProp;
    property Count: Integer read GetCount;
    property Pages[PageNo: Integer]: TgtPDPage read GetPage;
  end;

implementation

uses
  gtLogger, gtConstants, Classes, MemoryStream, PDStream, gtMethods, PDDictionary,
  PDArray, PDIndirectRef, PDBaseDoc, PDDocument, PDName, PDVector, PDBoolean,
  PDReal, PDString, PDNull, SysUtils, PDResource, PDFont, PDGState, gtTypes,
  PDColorSpace, PDXObject;

type
  THackPage = class(TgtPDPage)

  end;
{ TgtPDPageTree }

 (**
  * Constructor
  *
  * @param AParentDoc The parent document object
  * @param AParentElemen The ParentElement for this dictionary
  * @param ABaseObject The Base obect for this Element
  * @algorithm
  *        1.	Start
  *        2.	FParentDoc := AParentDoc
  *        3.	FParentElement := AParentElement
  *        4.	FBaseObject := ABaseObject
  *        5.	End
  *)

procedure TgtPDPageTree.CopyResource(AFromPage, AToPage: Integer);
var
  LI: Integer;
  LFromPageResources: TgtPDResource;
  LResourceElement: TgtPDElement;
begin
  //Adding Resources from source to destination page resource
  LFromPageResources := Pages[AFromPage].Resource;
  for LI := 0 to LFromPageResources.FontCount - 1 do
  begin
    LResourceElement := LFromPageResources.GetFont(LI);
    Pages[AToPage].AddResource(resFont, TgtPDFont(LResourceElement).Tag,
      LResourceElement.BaseObject);
  end;
  for LI := 0 to LFromPageResources.GStateCount - 1 do
  begin
    LResourceElement := LFromPageResources.GetGState(LI);
    Pages[AToPage].AddResource(resExtGState, TgtPDGState(LResourceElement).Tag,
      LResourceElement.BaseObject);
  end;
  for LI := 0 to LFromPageResources.ColorSpaceCount - 1 do
  begin
    LResourceElement := LFromPageResources.GetColorSpace(LI);
    Pages[AToPage].AddResource(resColorSpace, TgtPDColorSpace(LResourceElement).TagName,
      LResourceElement.BaseObject);
  end;
  for LI := 0 to LFromPageResources.XObjectCount - 1 do
  begin
    LResourceElement := LFromPageResources.GetXObject(LI);
    Pages[AToPage].AddResource(resXObject, TgtPDXObject(LResourceElement).TagName,
      LResourceElement.BaseObject);
  end;
end;

constructor TgtPDPageTree.Create(AParentDoc: TgtObject;
  AParentElement: TgtPDElement; ABaseObject: TgtPDBaseObject);
begin
  FParentDoc := AParentDoc;
  FBaseObject := ABaseObject;
  FParentElement := AParentElement;
  FPageNumber := 0;
end;

 (**
  * Function to create a new page and it adds the created page in the specified
  * position
  *
  * @param AfterPage
  * @param MediaBox
  *)

function TgtPDPageTree.CreatePage(AfterPage: Integer;
  MediaBox: TgtPDRect): TgtPDPage;
var
  LObj, LObj2, LObj3: TgtPDBaseObject;
//  LPages: TgtPDBaseObject;
begin
  Result := nil;
  if (AfterPage >= 0) and (AfterPage <= Count + 1) then
  begin
    GetPage(AfterPage);

    TgtPDDocument(FParentDoc).LastObjectNumber :=
      TgtPDDocument(FParentDoc).LastObjectNumber + 1;

    LObj := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).LastObjectNumber,
      0, TgtPDDocument(FParentDoc).BaseDoc);

    LObj.IsWritten := False;
    LObj.IsChanged := True;

    LObj2 := TgtPDName.Create(PDF_PAGE);
    TgtPDDictionary(LObj).Add(PDF_TYPE, LObj2);

    LObj3 := TgtPDIndirectRef.Create(BaseObject.ObjNumber,
      BaseObject.GenNumber);
    TgtPDDictionary(LObj).Add(PDF_PARENT, LObj3);

    TgtPDDocument(FParentDoc).BaseDoc.AddToCollection(LObj);

    Result := TgtPDPage.Create(FParentDoc, Self, LObj);

    Result.SetMediaBox(MediaBox.Left, MediaBox.Top, MediaBox.Right, MediaBox.Bottom);

    FPageList.Insert(AfterPage - 1, Result);

    LObj3 := TgtPDIndirectRef.Create(LObj.ObjNumber, LObj.GenNumber);
    FPageRefs.Insert(AfterPage - 1, LObj3);

    FCount.Value := FCount.Value + 1;
   // Inc(FCount);
    FIsChanged := True;
  end;
end;

(**
  * Deletes a range of pages in a document.
  *
  * @param PageNumber The page number in document that need to be deleted.
  * @algorithm
  *        1.	Start
  *        2.	IF PageNumber > 0 AND PageNumber <=  Count Then
  *        3.	begin
  *          a.	Call GetPage(PageNumber)
  *          b.	Delete PageNumber – 1 from FPageList
  *          c.	Delete PageNumber – 1 from FPageRefs
  *          d.	Decreament Page Count
  *          e.	Set FIsChanged := True
  *        4.	End
  *        5.	End
  *
  *)

procedure TgtPDPageTree.DeletePage(PageNumber: Integer);
begin
  if (PageNumber > 0) and (PageNumber <= Count) then
  begin
    GetPage(PageNumber);
    FPageList.Delete(PageNumber - 1);
    FPageRefs.Delete(PageNumber - 1);
    FCount.Value := FCount.Value - 1;

    FIsChanged := True;
  end;
end;

(**
  * Deletes a range of pages in a document.
  *
  * @param FirstPage The page number of the first page in document that
  *        need to be deleted. The first page is 1.
  * @param LastPage The page number of the last page in doc whose that
  *        need to be deleted deleted.
  *)

procedure TgtPDPageTree.DeletePages(FirstPage, LastPage: Integer);
var
  LI: Integer;
begin
  if (FirstPage > 0) and (FirstPage <= Count) and
    (LastPage > 0) and (LastPage <= Count) then
  begin
    GetPage(FirstPage);
    for LI := LastPage downto FirstPage do
    begin
      TgtPDDictionary(TgtPDPage(FPageList.Items[LI - 1]).BaseObject).
        Remove(PDF_PARENT);
      FPageList.Delete(LI - 1);
      FPageRefs.Delete(LI - 1);
      FCount.Value := FCount.Value - 1;
     // Dec(FCount);
    end;
    FIsChanged := True;
  end;
end;

 (**
  * Destructor
  *
  *)

destructor TgtPDPageTree.Destroy;
begin
  FreeObject(FPageList);
  FreeObject(FPageRefs);
  if Assigned(FInheritedProp) then
    FreeObject(FInheritedProp);
  inherited;
end;

(**
  * Gets the number of pages in a document.
  *
  * @return The number of pages in the document. Remember to subtract 1 from
  *         this value if you are going to pass it to a PD- level method that takes a
  *         zero-based page number.
  * @algorithm
  *        1.	Start
  *        2.	IF NOT Assigned FCount Then
  *        3.	begin
  *          a.	LObj := In FBaseObject LookUp for Count
  *          b.	IF Assigned LObj Then
  *          c.	Begin
  *            i.	FCount.Value := LObj.Value
  *          d.	End
  *        4.	End
  *        5.	Return FCount.Value
  *        6.	End
  *
  *)

function TgtPDPageTree.GetCount: Integer;
var
  LObject: TgtPDBaseObject;
begin
  if not Assigned(FCount) then
  begin
    LObject := TgtPDDictionary(FBaseObject).LookUp(PDF_COUNT);
    if Assigned(LObject) then
      FCount := TgtPDInteger(LObject);
  end;
  Result := FCount.Value;
end;

  (**
   * Returns the Page with the page number specified
   * @param Index the page number of the document
   * @return Page object is returned if present, nil otherwise
   * @algorithm
   *         1.	Start
   *         2.	IF NOT Assigned FPageList Then
   *         3.	begin
   *           a.	Create ObjectList with FPageList and FPageRefs
   *           b.	SetLength LAlreadyRead array to XRef Size
   *           c.	Loop To Count From 0
   *             i.	LAlreadyRead := Flase
   *           d.	Call ReadPageTree(FBaseObject, LAlreadtRead)
   *           e.	Free LAlreadyRead
   *         4.	End
   *         5.	IF Index >= 0 AND Index < Count Then
   *           a.	Return FPageList.Item[Index] as PDPage
   *         6.	ELSE
   *           a.	Return NIL
   *         7.	End
   *
   *)

function TgtPDPageTree.GetPage(Index: Integer): TgtPDPage;
var
  LAlreadyRead: array of Boolean;
  LI: Integer;
begin
  if not Assigned(FPageList) then
  begin
    FPageList := TObjectList.Create(True);
    FPageRefs := TObjectList.Create(True);
    SetLength(LAlreadyRead, TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.GetSize);

    for LI := 0 to Count - 1 do
      LAlreadyRead[LI] := False;

    //Generate the page tree
    ReadPageTree(FBaseObject, LAlreadyRead, nil);
    SetLength(LAlreadyRead, 0);
  end;

  if (Index >= 0) and (Index <= Count) then
    Result := TgtPDPage(FPageList.Items[Index - 1])
  else
    Result := nil;
end;

(**
  * Returns the page Base object corresponding to the given page number.
  *
  * @return A base object representing the page, or nil if the page does not
  *         exist.
  *)

function TgtPDPageTree.GetPageBaseObject(PageNumber: Integer): TgtPDBaseObject;
begin
  Result := GetPage(PageNumber).BaseObject;
end;

function TgtPDPageTree.GetPageByIndRef(APageRef: TgtPDBaseObject): TgtPDPage;
var
//  LPageRef: TgtPDBaseObject;
  LI: Integer;
begin
  Result := nil;
  if not Assigned(FPageList) then
  begin
    GetPage(1);
  end;
  LI := 0;
  while LI < FPageList.Count do
  begin
    if (TgtPDIndirectRef(APageRef).ObjNumber =
      TgtPDIndirectRef(FPageRefs.Items[LI]).ObjNumber) then
    begin
      Result := TgtPDPage(FPageList.Items[LI]);
      Exit;
    end
    else
      Inc(LI);
  end;
end;

//procedure GetAllObjects(ABaseObject: TgtPDBaseObject; List: TVector);
//var
//  LIndirectRefs: TObjectList;
//  I: Integer;
//  LDoc: TgtPDBaseDoc;
//  LObj: TgtPDBaseObject;
//begin
//  if ABaseObject.IsDict(PDF_PAGE) then
//    TgtPDDictionary(ABaseObject).Remove(PDF_PARENT);
//
//  LIndirectRefs := TObjectList.Create(False);
//  if ABaseObject is TgtPDDictionary then
//    TgtPDDictionary(ABaseObject).GetIndirectRefs(LIndirectRefs)
//  else if ABaseObject is TgtPDArray then
//    TgtPDArray(ABaseObject).GetIndirectRefs(LIndirectRefs)
//  else if ABaseObject is TgtPDStream then
//    TgtPDDictionary(TgtPDStream(ABaseObject).GetDict).GetIndirectRefs(LIndirectRefs);
//
//  for I := 0 to LIndirectRefs.Count - 1 do
//  begin
//    if ABaseObject is TgtPDDictionary then
//      LDoc := TgtPDDictionary(ABaseObject).GetParentDoc as TgtPDBaseDoc
//    else if ABaseObject is TgtPDArray then
//      LDoc := TgtPDArray(ABaseObject).GetParentDoc  as TgtPDBaseDoc
//    else if ABaseObject is TgtPDStream then
//     LDoc := TgtPDDictionary(TgtPDStream(ABaseObject).GetDict).GetParentDoc as TgtPDBaseDoc;
//
//    LObj := LDoc.GetObject(TgtPDIndirectRef(LIndirectRefs.Items[I]).ObjNumber);
//
//    GetAllObjects(LObj, List);
//  end;
//  while (List.Capacity < ABaseObject.ObjNumber) do
//    List.Grow;
//
//  List.Items[ABaseObject.ObjNumber] := ABaseObject;
//  LIndirectRefs.Free;
//end;

//procedure DuplicateList(var BaseObject: TgtPDBaseObject; var List: TVector;
//  const BaseDoc: TgtObject; const ParentElement: TgtObject);
//var
//  I: Integer;
//  LObj: TgtPDBaseObject;
//begin
//  TgtPDBaseDoc(BaseDoc).Reader.XRef.LastObjectNumber :=
//    TgtPDBaseDoc(BaseDoc).Reader.XRef.LastObjectNumber + 1;
//
//  if (BaseObject.ObjNumber <> $FFFFFFFF) then
//  begin
//    BaseObject.ObjNumber := TgtPDBaseDoc(BaseDoc).Reader.XRef.LastObjectNumber;
//    BaseObject.GenNumber := 0;
//  end;
//
//  case BaseObject.GetType of
//    otArray:
//    begin
//      TgtPDArray(BaseObject).SetParentDoc(BaseDoc);
//      for I := 0 to TgtPDArray(BaseObject).GetLength - 1 do
//      begin
//        LObj := TgtPDArray(BaseObject).GetRefObj(I);
//        if LObj.IsIndirectRef then
//        begin
//          if LObj.ObjNumber =
//            TgtPDBaseObject(List.Items[LObj.ObjNumber]).ObjNumber then
//              DuplicateList(TgtPDBaseObject(List.Items[LObj.ObjNumber]), List,
//              BaseDoc, ParentElement);
//          LObj.ObjNumber := TgtPDBaseObject(List.Items[LObj.ObjNumber]).ObjNumber;
//        end;
//      end;
//    end;
//    otDict:
//    begin
//      TgtPDDictionary(BaseObject).SetParentDoc(BaseDoc);
//
//      for I := 0 to TgtPDDictionary(BaseObject).GetLength - 1 do
//      begin
//        LObj := TgtPDDictionary(BaseObject).GetValueRefObj(I);
//        if LObj.IsIndirectRef then
//        begin
//          if LObj.ObjNumber =
//            TgtPDBaseObject(List.Items[LObj.ObjNumber]).ObjNumber then
//              DuplicateList(TgtPDBaseObject(List.Items[LObj.ObjNumber]), List,
//              BaseDoc, ParentElement);
//          LObj.ObjNumber := TgtPDBaseObject(List.Items[LObj.ObjNumber]).ObjNumber;
//        end
//        else if LObj.IsDict then
//        begin
//          DuplicateList(LObj, List, BaseDoc, BaseObject);
//        end
//        else if LObj.IsArray then
//        begin
//          DuplicateList(LObj, List, BaseDoc, BaseObject);
//        end;
//      end;
//    end;
//    otStream:
//    begin
//      TgtPDDictionary(TgtPDStream(BaseObject).GetDict).SetParentDoc(BaseDoc);
//      for I := 0 to TgtPDDictionary(TgtPDStream(BaseObject).GetDict).GetLength - 1 do
//      begin
//        LObj := TgtPDDictionary(TgtPDStream(BaseObject).GetDict).GetValueRefObj(I);
//        if LObj.IsIndirectRef then
//        begin
//          if LObj.ObjNumber =
//            TgtPDBaseObject(List.Items[LObj.ObjNumber]).ObjNumber then
//              DuplicateList(TgtPDBaseObject(List.Items[LObj.ObjNumber]), List,
//              BaseDoc, ParentElement);
//          LObj.ObjNumber := TgtPDBaseObject(List.Items[LObj.ObjNumber]).ObjNumber;
//        end;
//      end;
//    end;
//  end;
//end;

procedure TgtPDPageTree.InsertPage(AfterPage: Integer; Page: TgtPDPage;
  InserFlags: TgtPageInsertFlages);
var
  LPage: TgtPDPage;
begin
  LPage := TgtPDPage.Create(FParentDoc, Self, nil);
  LPage.Assign(Page);
  //Update the Added page with correct page number
  LPage.PageNum := AfterPage + 1;

  //Update page number of other pages after the newly inserted page
  UpdatePageNumbers(LPage.PageNum + 1);

  FPageList.Insert(AfterPage, LPage);
  FPageRefs.Insert(AfterPage, TgtPDIndirectRef.Create(LPage.BaseObject.ObjNumber,
    LPage.BaseObject.GenNumber));
end;

procedure TgtPDPageTree.InsertPages(AfterPage: Integer; SourceDoc: TgtObject;
  SourceStartPage, NumOfPages: Integer; InsertFlags: TgtPageInsertFlages);
var
  I: Integer;
  LAfterPage: Integer;
begin
  GetPage(1);
  if (AfterPage >= 0) and (AfterPage <= Count) and (SourceStartPage > 0) and
    (SourceStartPage <= TgtPDDocument(SourceDoc).PageCount) and
    (SourceStartPage + (NumOfPages - 1) <= TgtPDDocument(SourceDoc).PageCount) then
  begin
    LAfterPage := AfterPage;

    for I := 1 to NumOfPages do
    begin
      InsertPage(LAfterPage, TgtPDDocument(SourceDoc).Pages[SourceStartPage + I - 1],
        InsertFlags);
      FCount.Value := FCount.Value + 1;
      Inc(LAfterPage);
    end;
  end;
end;

procedure TgtPDPageTree.InsertTrialMark;
var
  LMemStream: TMemoryStream;
  LStream: TgtMemoryStream;
  LDict, LContent: TgtPDBaseObject;
const
  LContentStr: AnsiString =
    'q 1 0 0 1 -250 150 cm' + CRLF +
    '0 J' + CRLF +
    '0 j' + CRLF +
    '1.0001 w' + CRLF +
    '[] 0 d' + CRLF +
    '0.67 0.66 0.66 RG' + CRLF +
    '435.1442 127.1018 m' + CRLF +
    '592.8602 127.1018 l' + CRLF +
    'S' + CRLF +
    '0.12 0.10 0.09 rg' + CRLF +
    '490.4348 143.2681 m' + CRLF +
    '487.3513 143.2681 l' + CRLF +
    '487.3513 155.8729 l' + CRLF +
    '486.8631 157.9133 l' + CRLF +
    '486.4552 158.6475 485.8648 159.2249 485.0915 159.6464 c' + CRLF +
    '484.3174 160.0679 483.5106 160.2791 482.6690 160.2791 c' + CRLF +
    '481.8274 160.2791 481.0340 160.0815 480.2871 159.6872 c' + CRLF +
    '479.5404 159.2929 478.9837 158.7220 478.6177 157.9745 c' + CRLF +
    '478.2515 157.2262 478.0276 156.5257 477.9465 155.8729 c' + CRLF +
    '477.9465 143.2681 l' + CRLF +
    '474.7601 143.2681 l' + CRLF +
    '474.7601 161.8923 l' + CRLF +
    '477.7923 161.8923 l' + CRLF +
    '477.7923 158.5511 l' + CRLF +
    '478.4153 159.5597 479.2215 160.3981 480.2108 161.0660 c' + CRLF +
    '481.2001 161.7341 482.2770 162.1227 483.4431 162.2322 c' + CRLF +
    '485.1502 162.2322 486.6880 161.8106 488.0563 160.9673 c' + CRLF +
    '489.4248 160.1240 490.2182 158.9012 490.4348 157.2976 c' + CRLF +
    'f*' + CRLF +
    '0.12 0.10 0.09 rg' + CRLF +
    '512.7111 146.9517 m' + CRLF +
    '512.0317 145.5656 510.9917 144.5202 509.5922 143.8135 c' + CRLF +
    '508.1916 143.1077 506.6634 142.7542 505.0060 142.7542 c' + CRLF +
    '502.4509 142.7542 500.2625 143.4328 498.4424 144.7914 c' + CRLF +
    '497.9251 145.3071 497.4361 145.8643 496.9743 146.4619 c' + CRLF +
    '496.5117 147.0591 496.0837 147.8132 495.6902 148.7237 c' + CRLF +
    '495.2959 149.6336 495.0992 150.8085 495.0992 152.2491 c' + CRLF +
    '495.0992 154.5032 495.7577 156.5405 497.0764 158.3609 c' + CRLF +
    '498.3942 160.1804 499.7327 161.2539 501.0914 161.5799 c' + CRLF +
    '502.4500 161.9062 503.3469 162.0955 503.7823 162.1502 c' + CRLF +
    '504.2177 162.2047 504.6931 162.2322 505.2093 162.2322 c' + CRLF +
    '505.4270 162.2322 505.6444 162.2322 505.8621 162.2322 c' + CRLF +
    '506.1881 162.1774 506.9823 162.0692 508.2463 161.9062 c' + CRLF +
    '509.5103 161.7429 510.8553 160.7312 512.2823 158.8706 c' + CRLF +
    '513.7092 157.0093 514.4230 154.8975 514.4230 152.5343 c' + CRLF +
    '514.4230 151.5288 514.2801 150.5506 513.9952 149.5998 c' + CRLF +
    '513.7092 148.6491 513.2812 147.7658 512.7111 146.9517 c' + CRLF +
    '510.3261 156.6584 m' + CRLF +
    '509.9165 157.8563 509.3376 158.8088 508.5884 159.5171 c' + CRLF +
    '507.8384 160.2252 507.1229 160.6405 506.4418 160.7632 c' + CRLF +
    '505.7609 160.8854 505.2430 160.9472 504.8887 160.9472 c' + CRLF +
    '502.6269 160.9472 501.0120 159.9321 500.0451 157.9039 c' + CRLF +
    '499.0774 155.8755 498.5940 153.5403 498.5940 150.8992 c' + CRLF +
    '498.5940 149.1021 499.1383 147.4753 500.2291 146.0186 c' + CRLF +
    '501.3187 144.5618 502.7085 143.8336 504.3983 143.8336 c' + CRLF +
    '504.5621 143.8336 504.7251 143.8336 504.8887 143.8336 c' + CRLF +
    '505.1066 143.8880 505.6855 143.9629 506.6257 144.0584 c' + CRLF +
    '507.5660 144.1531 508.5266 145.0789 509.5077 146.8352 c' + CRLF +
    '510.4891 148.5913 510.9797 150.5724 510.9797 152.7783 c' + CRLF +
    '510.9797 154.2487 510.7615 155.5421 510.3261 156.6584 c' + CRLF +
    'f*' + CRLF +
    '0.12 0.10 0.09 rg' + CRLF +
    '528.7156 161.0668 m' + CRLF +
    '527.9791 158.7141 l' + CRLF +
    '527.8700 158.6594 527.7070 158.6860 527.4901 158.7943 c' + CRLF +
    '527.0556 159.4383 526.5057 159.9755 525.8409 160.4052 c' + CRLF +
    '525.1757 160.8350 524.4902 161.0501 523.7841 161.0501 c' + CRLF +
    '522.9972 161.0501 522.2778 160.8197 521.6255 160.3593 c' + CRLF +
    '520.8925 159.6543 520.5266 158.8017 520.5266 157.7993 c' + CRLF +
    '520.5266 157.1491 520.6822 156.5595 520.9937 156.0311 c' + CRLF +
    '521.3052 155.5027 521.7735 155.0900 522.3974 154.7921 c' + CRLF +
    '527.6435 152.9637 l' + CRLF +
    '528.4023 152.5575 528.9644 152.0354 529.3307 151.3996 c' + CRLF +
    '529.6969 150.7626 529.8797 150.0650 529.8797 149.3067 c' + CRLF +
    '529.8797 148.4124 529.6487 147.5048 529.1875 146.5838 c' + CRLF +
    '528.7269 145.6628 528.1302 144.8773 527.3977 144.2279 c' + CRLF +
    '525.9869 143.2794 524.3182 142.8058 522.3926 142.8058 c' + CRLF +
    '520.5745 142.8058 519.0953 143.2514 517.9567 144.1412 c' + CRLF +
    '518.8000 146.6087 l' + CRLF +
    '519.4256 145.8507 520.1666 145.2410 521.0243 144.7809 c' + CRLF +
    '521.8821 144.3200 522.7869 144.0904 523.7393 144.0904 c' + CRLF +
    '524.3374 144.0904 524.9092 144.2191 525.4537 144.4768 c' + CRLF +
    '525.9980 144.7345 526.4742 145.1353 526.8821 145.6781 c' + CRLF +
    '527.2356 146.4378 527.4130 147.1428 527.4130 147.7939 c' + CRLF +
    '527.4130 148.3095 527.2838 148.7976 527.0253 149.2594 c' + CRLF +
    '526.7665 149.7203 526.3645 150.1140 525.8197 150.4400 c' + CRLF +
    '524.2949 150.9282 523.0086 151.3483 521.9597 151.7014 c' + CRLF +
    '520.9109 152.0541 520.0469 152.5558 519.3669 153.2072 c' + CRLF +
    '518.8490 153.8583 518.5012 154.5369 518.3246 155.2419 c' + CRLF +
    '518.1477 155.9469 518.0596 156.4761 518.0596 156.8296 c' + CRLF +
    '518.0596 158.4306 518.6988 159.7394 519.9778 160.7570 c' + CRLF +
    '521.2570 161.7744 522.7537 162.2835 524.4690 162.2835 c' + CRLF +
    '525.2312 162.2835 525.9597 162.1814 526.6534 161.9790 c' + CRLF +
    '527.3473 161.7761 528.0347 161.4716 528.7156 161.0668 c' + CRLF +
    'f*' + CRLF +
    '0.12 0.10 0.09 rg' + CRLF +
    '542.7964 144.3348 m' + CRLF +
    '542.7556 143.4226 l' + CRLF +
    '542.1566 143.2633 541.6322 143.1454 541.1832 143.0657 c' + CRLF +
    '540.7333 142.9872 540.2228 142.9469 539.6511 142.9469 c' + CRLF +
    '538.6433 142.9469 537.7782 143.1374 537.0574 143.5164 c' + CRLF +
    '536.3362 143.8954 535.8118 144.5601 535.4850 145.5094 c' + CRLF +
    '535.2401 147.2584 l' + CRLF +
    '535.2401 160.1121 l' + CRLF +
    '532.5676 160.1121 l' + CRLF +
    '532.5676 161.4484 l' + CRLF +
    '535.2401 161.4484 l' + CRLF +
    '535.2401 165.9067 l' + CRLF +
    '538.0152 167.2685 l' + CRLF +
    '538.0152 161.4484 l' + CRLF +
    '542.3485 161.4484 l' + CRLF +
    '542.3485 160.1121 l' + CRLF +
    '538.0152 160.1121 l' + CRLF +
    '538.0152 148.0694 l' + CRLF +
    '538.0152 147.3610 538.0897 146.7493 538.2400 146.2320 c' + CRLF +
    '538.3896 145.7150 538.6963 145.2115 539.1595 144.7217 c' + CRLF +
    '539.7313 144.3949 540.3722 144.2319 541.0803 144.2319 c' + CRLF +
    '541.3252 144.2319 541.6248 144.2446 541.9789 144.2704 c' + CRLF +
    '542.3329 144.2959 542.6053 144.3169 542.7964 144.3348 c' + CRLF +
    'f*' + CRLF +
    '0.12 0.10 0.09 rg' + CRLF +
    '550.4040 168.8142 m' + CRLF +
    '550.4040 168.2731 550.2509 167.8201 549.9442 167.4556 c' + CRLF +
    '549.6372 167.0910 549.2310 166.9088 548.7250 166.9088 c' + CRLF +
    '548.2191 166.9088 547.7729 167.0774 547.3862 167.4156 c' + CRLF +
    '546.9996 167.7526 546.8066 168.1654 546.8066 168.6521 c' + CRLF +
    '546.8066 169.1651 546.9664 169.6107 547.2862 169.9900 c' + CRLF +
    '547.6056 170.3682 548.0192 170.5575 548.5252 170.5575 c' + CRLF +
    '549.0309 170.5575 549.4711 170.3954 549.8444 170.0711 c' + CRLF +
    '550.2169 169.7465 550.4040 169.3276 550.4040 168.8142 c' + CRLF +
    '550.1472 143.2681 m' + CRLF +
    '546.8066 143.2681 l' + CRLF +
    '546.8066 161.6666 l' + CRLF +
    '550.1472 161.6666 l' + CRLF +
    'f*' + CRLF +
    '0.12 0.10 0.09 rg' + CRLF +
    '572.1829 160.8267 m' + CRLF +
    '571.4901 158.3408 l' + CRLF +
    '571.3268 158.3408 571.1641 158.3408 571.0017 158.3408 c' + CRLF +
    '570.5393 159.2640 569.8599 159.9644 568.9636 160.4398 c' + CRLF +
    '568.0675 160.9152 567.1168 161.1527 566.1122 161.1527 c' + CRLF +
    '563.9119 161.1527 562.1734 160.3497 560.8964 158.7438 c' + CRLF +
    '559.7283 157.0550 559.1443 155.0132 559.1443 152.6176 c' + CRLF +
    '559.1443 151.0115 559.4567 149.5477 560.0815 148.2276 c' + CRLF +
    '560.7062 146.9075 561.6363 145.9480 562.8728 145.3487 c' + CRLF +
    '564.1087 144.7498 565.3517 144.4504 566.6012 144.4504 c' + CRLF +
    '568.6379 144.4504 570.4172 145.2212 571.9388 146.7629 c' + CRLF +
    '571.9388 144.9425 l' + CRLF +
    '571.0153 144.2679 570.0180 143.7684 568.9460 143.4450 c' + CRLF +
    '567.8734 143.1221 566.7540 142.9600 565.5869 142.9600 c' + CRLF +
    '563.8221 142.9600 562.2001 143.3398 560.7207 144.1009 c' + CRLF +
    '559.2416 144.8623 558.0539 145.9766 557.1584 147.4447 c' + CRLF +
    '556.2896 149.1293 555.8553 150.8831 555.8553 152.7043 c' + CRLF +
    '555.8553 154.6067 556.3026 156.3259 557.1986 157.8614 c' + CRLF +
    '558.0950 159.3967 559.4111 160.5858 561.1487 161.4291 c' + CRLF +
    '561.8540 161.7279 562.5051 161.9518 563.1026 162.1012 c' + CRLF +
    '563.6999 162.2506 564.3921 162.3798 565.1799 162.4890 c' + CRLF +
    '566.2111 162.4890 567.2083 162.4079 568.1718 162.2458 c' + CRLF +
    '569.1353 162.0836 570.1065 161.8138 571.0836 161.4362 c' + CRLF +
    'f*' + CRLF +
    '0.12 0.10 0.09 rg' + CRLF +
    '592.8140 152.8274 m' + CRLF +
    '578.8763 152.8274 l' + CRLF +
    '578.8488 152.6360 578.8352 152.4515 578.8352 152.2740 c' + CRLF +
    '578.8352 152.0966 578.8352 151.9673 578.8352 151.8854 c' + CRLF +
    '578.8352 150.1098 579.3242 148.4844 580.3030 147.0101 c' + CRLF +
    '581.2809 145.5350 582.2464 144.7296 583.1980 144.5933 c' + CRLF +
    '584.1488 144.4567 584.7270 144.3813 584.9308 144.3677 c' + CRLF +
    '585.1349 144.3538 585.3725 144.3475 585.6446 144.3475 c' + CRLF +
    '586.8677 144.3475 587.9752 144.5530 588.9677 144.9641 c' + CRLF +
    '589.9603 145.3754 590.9318 146.0602 591.8834 147.0200 c' + CRLF +
    '591.6393 144.9329 l' + CRLF +
    '590.7158 144.2239 589.6848 143.6922 588.5444 143.3373 c' + CRLF +
    '587.4041 142.9832 586.2373 142.8058 585.0434 142.8058 c' + CRLF +
    '582.7901 142.8058 580.7880 143.4311 579.0376 144.6823 c' + CRLF +
    '577.2869 145.9335 576.2826 147.3131 576.0247 148.8226 c' + CRLF +
    '575.7670 150.3315 575.6309 151.2694 575.6173 151.6371 c' + CRLF +
    '575.6037 152.0042 575.5975 152.2828 575.5975 152.4739 c' + CRLF +
    '575.5975 154.4043 575.9563 156.1309 576.6758 157.6542 c' + CRLF +
    '577.3944 159.1767 578.3445 160.2510 579.5249 160.8766 c' + CRLF +
    '580.7055 161.5022 581.7566 161.9101 582.6793 162.1003 c' + CRLF +
    '583.6020 162.2908 584.5107 162.3864 585.4062 162.3864 c' + CRLF +
    '587.6042 162.3864 589.3883 161.5592 590.7583 159.9049 c' + CRLF +
    '592.1283 158.2509 592.8140 156.2842 592.8140 154.0069 c' + CRLF +
    '592.8140 153.8164 592.8140 153.6060 592.8140 153.3756 c' + CRLF +
    '592.8140 153.1451 592.8140 152.9620 592.8140 152.8274 c' + CRLF +
    '589.5763 154.2149 m' + CRLF +
    '589.5763 155.9854 589.1876 157.5584 588.4118 158.9349 c' + CRLF +
    '587.6362 160.3106 586.4590 160.9985 584.8801 160.9985 c' + CRLF +
    '584.7437 160.9985 584.5399 160.9985 584.2675 160.9985 c' + CRLF +
    '582.6617 160.9985 581.3887 160.2873 580.4493 158.8660 c' + CRLF +
    '579.5096 157.4436 579.0407 155.8930 579.0407 154.2149 c' + CRLF +
    'f*' + CRLF +
    '0.12 0.10 0.09 rg' + CRLF +
    '435.1949 134.8092 m' + CRLF +
    '435.1949 138.7400 l' + CRLF +
    '435.7457 138.7400 l' + CRLF +
    '435.7457 134.8092 l' + CRLF +
    'f*' + CRLF +
    '0.12 0.10 0.09 rg' + CRLF +
    '439.7715 134.8092 m' + CRLF +
    '439.7715 138.7400 l' + CRLF +
    '440.3330 138.7400 l' + CRLF +
    '442.5114 135.6523 l' + CRLF +
    '442.5114 138.7400 l' + CRLF +
    '443.0364 138.7400 l' + CRLF +
    '443.0364 134.8092 l' + CRLF +
    '442.4746 134.8092 l' + CRLF +
    '440.2964 137.8973 l' + CRLF +
    '440.2964 134.8092 l' + CRLF +
    'f*' + CRLF +
    '0.12 0.10 0.09 rg' + CRLF +
    '447.0392 134.8092 m' + CRLF +
    '447.0392 138.7400 l' + CRLF +
    '449.8432 138.7400 l' + CRLF +
    '449.8432 138.2791 l' + CRLF +
    '447.5897 138.2791 l' + CRLF +
    '447.5897 137.0563 l' + CRLF +
    '449.5425 137.0563 l' + CRLF +
    '449.5425 136.5953 l' + CRLF +
    '447.5897 136.5953 l' + CRLF +
    '447.5897 134.8092 l' + CRLF +
    'f*' + CRLF +
    '0.12 0.10 0.09 rg' + CRLF +
    '453.4517 136.7257 m' + CRLF +
    '453.4517 137.3777 453.6357 137.8882 454.0039 138.2573 c' + CRLF +
    '454.3722 138.6261 454.8472 138.8106 455.4295 138.8106 c' + CRLF +
    '455.8110 138.8106 456.1546 138.7239 456.4607 138.5507 c' + CRLF +
    '456.7669 138.3775 457.0004 138.1357 457.1609 137.8259 c' + CRLF +
    '457.3216 137.5157 457.4018 137.1643 457.4018 136.7711 c' + CRLF +
    '457.4018 136.3728 457.3174 136.0162 457.1484 135.7019 c' + CRLF +
    '456.9792 135.3875 456.7397 135.1494 456.4298 134.9875 c' + CRLF +
    '456.1200 134.8260 455.7855 134.7452 455.4266 134.7452 c' + CRLF +
    '455.0380 134.7452 454.6905 134.8345 454.3843 135.0130 c' + CRLF +
    '454.0782 135.1919 453.8460 135.4357 453.6884 135.7447 c' + CRLF +
    '453.5306 136.0539 453.4517 136.3808 453.4517 136.7257 c' + CRLF +
    '454.0150 136.7155 m' + CRLF +
    '454.0150 136.2419 454.1488 135.8685 454.4167 135.5958 c' + CRLF +
    '454.6843 135.3231 455.0202 135.1868 455.4241 135.1868 c' + CRLF +
    '455.8354 135.1868 456.1739 135.3246 456.4397 135.6001 c' + CRLF +
    '456.7056 135.8753 456.8386 136.2660 456.8386 136.7719 c' + CRLF +
    '456.8386 137.0920 456.7816 137.3715 456.6679 137.6101 c' + CRLF +
    '456.5546 137.8488 456.3882 138.0339 456.1693 138.1652 c' + CRLF +
    '455.9505 138.2967 455.7047 138.3625 455.4323 138.3625 c' + CRLF +
    '455.0454 138.3625 454.7123 138.2360 454.4337 137.9829 c' + CRLF +
    '454.1545 137.7300 454.0150 137.3074 454.0150 136.7155 c' + CRLF +
    'f*' + CRLF +
    '0.12 0.10 0.09 rg' + CRLF +
    '461.1886 134.8092 m' + CRLF +
    '461.1886 138.7400 l' + CRLF +
    '463.0258 138.7400 l' + CRLF +
    '463.3946 138.7400 463.6749 138.7049 463.8665 138.6346 c' + CRLF +
    '464.0584 138.5640 464.2118 138.4396 464.3266 138.2610 c' + CRLF +
    '464.4411 138.0827 464.4986 137.8857 464.4986 137.6697 c' + CRLF +
    '464.4986 137.3913 464.4037 137.1566 464.2138 136.9658 c' + CRLF +
    '464.0236 136.7748 463.7302 136.6534 463.3333 136.6019 c' + CRLF +
    '463.4782 136.5355 463.5882 136.4700 463.6636 136.4054 c' + CRLF +
    '463.8231 136.2657 463.9742 136.0911 464.1165 135.8816 c' + CRLF +
    '464.8326 134.8092 l' + CRLF +
    '464.1489 134.8092 l' + CRLF +
    '463.6015 135.6290 l' + CRLF +
    '463.4416 135.8654 463.3098 136.0463 463.2063 136.1718 c' + CRLF +
    '463.1029 136.2971 463.0105 136.3847 462.9285 136.4343 c' + CRLF +
    '462.8466 136.4842 462.7636 136.5188 462.6788 136.5384 c' + CRLF +
    '462.6167 136.5508 462.5152 136.5571 462.3741 136.5571 c' + CRLF +
    '461.7391 136.5571 l' + CRLF +
    '461.7391 134.8092 l' + CRLF +
    'h' + CRLF +
    '461.7391 137.0052 m' + CRLF +
    '462.9158 137.0052 l' + CRLF +
    '463.1658 137.0052 463.3617 137.0296 463.5028 137.0786 c' + CRLF +
    '463.6443 137.1280 463.7517 137.2065 463.8251 137.3148 c' + CRLF +
    '463.8986 137.4228 463.9354 137.5401 463.9354 137.6671 c' + CRLF +
    '463.9354 137.8528 463.8643 138.0056 463.7220 138.1252 c' + CRLF +
    '463.5799 138.2448 463.3554 138.3049 463.0484 138.3049 c' + CRLF +
    '461.7391 138.3049 l' + CRLF +
    'f*' + CRLF +
    '0.12 0.10 0.09 rg' + CRLF +
    '468.4051 134.8092 m' + CRLF +
    '468.4051 138.7400 l' + CRLF +
    '469.2206 138.7400 l' + CRLF +
    '470.2071 135.9592 l' + CRLF +
    '470.2978 135.7004 470.3641 135.5066 470.4058 135.3779 c' + CRLF +
    '470.4534 135.5207 470.5274 135.7305 470.6280 136.0074 c' + CRLF +
    '471.6269 138.7400 l' + CRLF +
    '472.3554 138.7400 l' + CRLF +
    '472.3554 134.8092 l' + CRLF +
    '471.8305 134.8092 l' + CRLF +
    '471.8305 138.1000 l' + CRLF +
    '470.6232 134.8092 l' + CRLF +
    '470.1297 134.8092 l' + CRLF +
    '468.9300 138.1575 l' + CRLF +
    '468.9300 134.8092 l' + CRLF +
    'f*' + CRLF +
    '0.12 0.10 0.09 rg' + CRLF +
    '475.8531 134.8092 m' + CRLF +
    '477.4365 138.7400 l' + CRLF +
    '478.0380 138.7400 l' + CRLF +
    '479.7295 134.8092 l' + CRLF +
    '479.1059 134.8092 l' + CRLF +
    '478.6254 136.0001 l' + CRLF +
    '476.8860 136.0001 l' + CRLF +
    '476.4362 134.8092 l' + CRLF +
    'h' + CRLF +
    '477.0476 136.4224 m' + CRLF +
    '478.4598 136.4224 l' + CRLF +
    '478.0259 137.5135 l' + CRLF +
    '477.8921 137.8429 477.7920 138.1153 477.7262 138.3304 c' + CRLF +
    '477.6690 138.0753 477.5927 137.8236 477.4972 137.5750 c' + CRLF +
    'f*' + CRLF +
    '0.12 0.10 0.09 rg' + CRLF +
    '483.8513 134.8092 m' + CRLF +
    '483.8513 138.2791 l' + CRLF +
    '482.4876 138.2791 l' + CRLF +
    '482.4876 138.7400 l' + CRLF +
    '485.7656 138.7400 l' + CRLF +
    '485.7656 138.2791 l' + CRLF +
    '484.4021 138.2791 l' + CRLF +
    '484.4021 134.8092 l' + CRLF +
    'f*' + CRLF +
    '0.12 0.10 0.09 rg' + CRLF +
    '489.4894 134.8092 m' + CRLF +
    '489.4894 138.7400 l' + CRLF +
    '490.0399 138.7400 l' + CRLF +
    '490.0399 134.8092 l' + CRLF +
    'f*' + CRLF +
    '0.12 0.10 0.09 rg' + CRLF +
    '493.9055 136.7257 m' + CRLF +
    '493.9055 137.3777 494.0895 137.8882 494.4577 138.2573 c' + CRLF +
    '494.8260 138.6261 495.3010 138.8106 495.8836 138.8106 c' + CRLF +
    '496.2648 138.8106 496.6084 138.7239 496.9148 138.5507 c' + CRLF +
    '497.2209 138.3775 497.4542 138.1357 497.6150 137.8259 c' + CRLF +
    '497.7754 137.5157 497.8559 137.1643 497.8559 136.7711 c' + CRLF +
    '497.8559 136.3728 497.7711 136.0162 497.6022 135.7019 c' + CRLF +
    '497.4330 135.3875 497.1937 135.1494 496.8836 134.9875 c' + CRLF +
    '496.5738 134.8260 496.2393 134.7452 495.8807 134.7452 c' + CRLF +
    '495.4918 134.7452 495.1443 134.8345 494.8381 135.0130 c' + CRLF +
    '494.5320 135.1919 494.3001 135.4357 494.1422 135.7447 c' + CRLF +
    '493.9843 136.0539 493.9055 136.3808 493.9055 136.7257 c' + CRLF +
    '494.4691 136.7155 m' + CRLF +
    '494.4691 136.2419 494.6029 135.8685 494.8705 135.5958 c' + CRLF +
    '495.1380 135.3231 495.4740 135.1868 495.8779 135.1868 c' + CRLF +
    '496.2892 135.1868 496.6279 135.3246 496.8935 135.6001 c' + CRLF +
    '497.1594 135.8753 497.2924 136.2660 497.2924 136.7719 c' + CRLF +
    '497.2924 137.0920 497.2357 137.3715 497.1220 137.6101 c' + CRLF +
    '497.0083 137.8488 496.8420 138.0339 496.6231 138.1652 c' + CRLF +
    '496.4043 138.2967 496.1588 138.3625 495.8861 138.3625 c' + CRLF +
    '495.4992 138.3625 495.1664 138.2360 494.8875 137.9829 c' + CRLF +
    '494.6083 137.7300 494.4691 137.3074 494.4691 136.7155 c' + CRLF +
    'f*' + CRLF +
    '0.12 0.10 0.09 rg' + CRLF +
    '501.6297 134.8092 m' + CRLF +
    '501.6297 138.7400 l' + CRLF +
    '502.1915 138.7400 l' + CRLF +
    '504.3699 135.6523 l' + CRLF +
    '504.3699 138.7400 l' + CRLF +
    '504.8949 138.7400 l' + CRLF +
    '504.8949 134.8092 l' + CRLF +
    '504.3331 134.8092 l' + CRLF +
    '502.1546 137.8973 l' + CRLF +
    '502.1546 134.8092 l' + CRLF +
    'f*' + CRLF +
    '0.12 0.10 0.09 rg' + CRLF +
    '514.4958 134.8092 m' + CRLF +
    '514.4958 138.2791 l' + CRLF +
    '513.1324 138.2791 l' + CRLF +
    '513.1324 138.7400 l' + CRLF +
    '516.4101 138.7400 l' + CRLF +
    '516.4101 138.2791 l' + CRLF +
    '515.0466 138.2791 l' + CRLF +
    '515.0466 134.8092 l' + CRLF +
    'f*' + CRLF +
    '0.12 0.10 0.09 rg' + CRLF +
    '520.0634 134.8092 m' + CRLF +
    '520.0634 138.7400 l' + CRLF +
    '523.0406 138.7400 l' + CRLF +
    '523.0406 138.2791 l' + CRLF +
    '520.6141 138.2791 l' + CRLF +
    '520.6141 137.0693 l' + CRLF +
    '522.8870 137.0693 l' + CRLF +
    '522.8870 136.6081 l' + CRLF +
    '520.6141 136.6081 l' + CRLF +
    '520.6141 135.2701 l' + CRLF +
    '523.1367 135.2701 l' + CRLF +
    '523.1367 134.8092 l' + CRLF +
    'f*' + CRLF +
    '0.12 0.10 0.09 rg' + CRLF +
    '529.9123 136.1894 m' + CRLF +
    '530.4631 136.0576 l' + CRLF +
    '530.3483 135.6310 530.1417 135.3053 529.8437 135.0814 c' + CRLF +
    '529.5455 134.8571 529.1813 134.7452 528.7510 134.7452 c' + CRLF +
    '528.3051 134.7452 527.9426 134.8313 527.6633 135.0040 c' + CRLF +
    '527.3838 135.1763 527.1715 135.4263 527.0258 135.7534 c' + CRLF +
    '526.8801 136.0806 526.8073 136.4318 526.8073 136.8074 c' + CRLF +
    '526.8073 137.2167 526.8895 137.5739 527.0542 137.8786 c' + CRLF +
    '527.2186 138.1836 527.4527 138.4149 527.7566 138.5731 c' + CRLF +
    '528.0602 138.7315 528.3944 138.8106 528.7592 138.8106 c' + CRLF +
    '529.1731 138.8106 529.5206 138.7106 529.8029 138.5107 c' + CRLF +
    '530.0850 138.3109 530.2814 138.0297 530.3925 137.6674 c' + CRLF +
    '529.8548 137.5464 l' + CRLF +
    '529.7587 137.8332 529.6195 138.0419 529.4370 138.1725 c' + CRLF +
    '529.2544 138.3035 529.0248 138.3690 528.7482 138.3690 c' + CRLF +
    '528.4301 138.3690 528.1642 138.2961 527.9508 138.1513 c' + CRLF +
    '527.7370 138.0061 527.5871 137.8111 527.5003 137.5668 c' + CRLF +
    '527.4139 137.3221 527.3708 137.0699 527.3708 136.8102 c' + CRLF +
    '527.3708 136.4751 527.4218 136.1826 527.5242 135.9326 c' + CRLF +
    '527.6265 135.6826 527.7858 135.4958 528.0018 135.3722 c' + CRLF +
    '528.2178 135.2486 528.4517 135.1868 528.7037 135.1868 c' + CRLF +
    '529.0098 135.1868 529.2689 135.2710 529.4812 135.4397 c' + CRLF +
    '529.6935 135.6080 529.8372 135.8578 529.9123 136.1894 c' + CRLF +
    'f*' + CRLF +
    '0.12 0.10 0.09 rg' + CRLF +
    '534.2287 134.8092 m' + CRLF +
    '534.2287 138.7400 l' + CRLF +
    '534.7791 138.7400 l' + CRLF +
    '534.7791 137.1203 l' + CRLF +
    '536.9176 137.1203 l' + CRLF +
    '536.9176 138.7400 l' + CRLF +
    '537.4681 138.7400 l' + CRLF +
    '537.4681 134.8092 l' + CRLF +
    '536.9176 134.8092 l' + CRLF +
    '536.9176 136.6594 l' + CRLF +
    '534.7791 136.6594 l' + CRLF +
    '534.7791 134.8092 l' + CRLF +
    'f*' + CRLF +
    '0.12 0.10 0.09 rg' + CRLF +
    '541.4451 134.8092 m' + CRLF +
    '541.4451 138.7400 l' + CRLF +
    '542.0069 138.7400 l' + CRLF +
    '544.1854 135.6523 l' + CRLF +
    '544.1854 138.7400 l' + CRLF +
    '544.7103 138.7400 l' + CRLF +
    '544.7103 134.8092 l' + CRLF +
    '544.1488 134.8092 l' + CRLF +
    '541.9704 137.8973 l' + CRLF +
    '541.9704 134.8092 l' + CRLF +
    'f*' + CRLF +
    '0.12 0.10 0.09 rg' + CRLF +
    '548.5275 136.7257 m' + CRLF +
    '548.5275 137.3777 548.7114 137.8882 549.0797 138.2573 c' + CRLF +
    '549.4476 138.6261 549.9230 138.8106 550.5052 138.8106 c' + CRLF +
    '550.8867 138.8106 551.2303 138.7239 551.5364 138.5507 c' + CRLF +
    '551.8426 138.3775 552.0762 138.1357 552.2369 137.8259 c' + CRLF +
    '552.3973 137.5157 552.4775 137.1643 552.4775 136.7711 c' + CRLF +
    '552.4775 136.3728 552.3931 136.0162 552.2238 135.7019 c' + CRLF +
    '552.0549 135.3875 551.8154 135.1494 551.5055 134.9875 c' + CRLF +
    '551.1957 134.8260 550.8612 134.7452 550.5026 134.7452 c' + CRLF +
    '550.1137 134.7452 549.7659 134.8345 549.4601 135.0130 c' + CRLF +
    '549.1539 135.1919 548.9218 135.4357 548.7642 135.7447 c' + CRLF +
    '548.6063 136.0539 548.5275 136.3808 548.5275 136.7257 c' + CRLF +
    '549.0907 136.7155 m' + CRLF +
    '549.0907 136.2419 549.2248 135.8685 549.4924 135.5958 c' + CRLF +
    '549.7600 135.3231 550.0959 135.1868 550.4998 135.1868 c' + CRLF +
    '550.9111 135.1868 551.2496 135.3246 551.5155 135.6001 c' + CRLF +
    '551.7811 135.8753 551.9143 136.2660 551.9143 136.7719 c' + CRLF +
    '551.9143 137.0920 551.8573 137.3715 551.7437 137.6101 c' + CRLF +
    '551.6300 137.8488 551.4639 138.0339 551.2450 138.1652 c' + CRLF +
    '551.0262 138.2967 550.7804 138.3625 550.5080 138.3625 c' + CRLF +
    '550.1211 138.3625 549.7880 138.2360 549.5091 137.9829 c' + CRLF +
    '549.2302 137.7300 549.0907 137.3074 549.0907 136.7155 c' + CRLF +
    'f*' + CRLF +
    '0.12 0.10 0.09 rg' + CRLF +
    '556.2323 134.8092 m' + CRLF +
    '556.2323 138.7400 l' + CRLF +
    '556.7828 138.7400 l' + CRLF +
    '556.7828 135.2701 l' + CRLF +
    '558.8186 135.2701 l' + CRLF +
    '558.8186 134.8092 l' + CRLF +
    'f*' + CRLF +
    '0.12 0.10 0.09 rg' + CRLF +
    '562.3736 136.7257 m' + CRLF +
    '562.3736 137.3777 562.5575 137.8882 562.9258 138.2573 c' + CRLF +
    '563.2937 138.6261 563.7688 138.8106 564.3513 138.8106 c' + CRLF +
    '564.7326 138.8106 565.0764 138.7239 565.3826 138.5507 c' + CRLF +
    '565.6887 138.3775 565.9220 138.1357 566.0827 137.8259 c' + CRLF +
    '566.2431 137.5157 566.3237 137.1643 566.3237 136.7711 c' + CRLF +
    '566.3237 136.3728 566.2389 136.0162 566.0700 135.7019 c' + CRLF +
    '565.9010 135.3875 565.6615 135.1494 565.3517 134.9875 c' + CRLF +
    '565.0415 134.8260 564.7073 134.7452 564.3485 134.7452 c' + CRLF +
    '563.9596 134.7452 563.6120 134.8345 563.3059 135.0130 c' + CRLF +
    '562.9997 135.1919 562.7679 135.4357 562.6100 135.7447 c' + CRLF +
    '562.4524 136.0539 562.3736 136.3808 562.3736 136.7257 c' + CRLF +
    '562.9368 136.7155 m' + CRLF +
    '562.9368 136.2419 563.0706 135.8685 563.3385 135.5958 c' + CRLF +
    '563.6061 135.3231 563.9417 135.1868 564.3456 135.1868 c' + CRLF +
    '564.7572 135.1868 565.0957 135.3246 565.3616 135.6001 c' + CRLF +
    '565.6272 135.8753 565.7601 136.2660 565.7601 136.7719 c' + CRLF +
    '565.7601 137.0920 565.7034 137.3715 565.5898 137.6101 c' + CRLF +
    '565.4761 137.8488 565.3100 138.0339 565.0909 138.1652 c' + CRLF +
    '564.8720 138.2967 564.6266 138.3625 564.3541 138.3625 c' + CRLF +
    '563.9672 138.3625 563.6341 138.2360 563.3552 137.9829 c' + CRLF +
    '563.0763 137.7300 562.9368 137.3074 562.9368 136.7155 c' + CRLF +
    'f*' + CRLF +
    '0.12 0.10 0.09 rg' + CRLF +
    '572.0374 136.3521 m' + CRLF +
    '572.0374 136.8130 l' + CRLF +
    '573.7918 136.8130 l' + CRLF +
    '573.7918 135.3577 l' + CRLF +
    '573.5225 135.1545 573.2450 135.0014 572.9590 134.8988 c' + CRLF +
    '572.6727 134.7965 572.3790 134.7452 572.0780 134.7452 c' + CRLF +
    '571.6712 134.7452 571.3019 134.8277 570.9696 134.9932 c' + CRLF +
    '570.6374 135.1585 570.3866 135.3977 570.2173 135.7104 c' + CRLF +
    '570.0478 136.0233 569.9631 136.3728 569.9631 136.7592 c' + CRLF +
    '569.9631 137.1416 570.0475 137.4987 570.2159 137.8304 c' + CRLF +
    '570.3843 138.1620 570.6266 138.4084 570.9427 138.5691 c' + CRLF +
    '571.2591 138.7301 571.6230 138.8106 572.0355 138.8106 c' + CRLF +
    '572.3345 138.8106 572.6052 138.7644 572.8473 138.6726 c' + CRLF +
    '573.0891 138.5804 573.2785 138.4520 573.4159 138.2873 c' + CRLF +
    '573.5534 138.1229 573.6580 137.9083 573.7294 137.6436 c' + CRLF +
    '573.2342 137.5149 l' + CRLF +
    '573.1722 137.7159 573.0948 137.8738 573.0026 137.9889 c' + CRLF +
    '572.9105 138.1037 572.7787 138.1958 572.6072 138.2649 c' + CRLF +
    '572.4360 138.3341 572.2461 138.3690 572.0372 138.3690 c' + CRLF +
    '571.7866 138.3690 571.5700 138.3324 571.3877 138.2598 c' + CRLF +
    '571.2049 138.1873 571.0578 138.0917 570.9458 137.9733 c' + CRLF +
    '570.8336 137.8548 570.7466 137.7247 570.6848 137.5829 c' + CRLF +
    '570.5793 137.3389 570.5266 137.0741 570.5266 136.7889 c' + CRLF +
    '570.5266 136.4372 570.5901 136.1429 570.7171 135.9060 c' + CRLF +
    '570.8441 135.6690 571.0289 135.4932 571.2718 135.3784 c' + CRLF +
    '571.5147 135.2636 571.7727 135.2061 572.0457 135.2061 c' + CRLF +
    '572.2826 135.2061 572.5140 135.2497 572.7399 135.3368 c' + CRLF +
    '572.9658 135.4241 573.1370 135.5170 573.2541 135.6160 c' + CRLF +
    '573.2541 136.3521 l' + CRLF +
    'f*' + CRLF +
    '0.12 0.10 0.09 rg' + CRLF +
    '577.7578 134.8092 m' + CRLF +
    '577.7578 138.7400 l' + CRLF +
    '578.3085 138.7400 l' + CRLF +
    '578.3085 134.8092 l' + CRLF +
    'f*' + CRLF +
    '0.12 0.10 0.09 rg' + CRLF +
    '582.3595 134.8092 m' + CRLF +
    '582.3595 138.7400 l' + CRLF +
    '585.3365 138.7400 l' + CRLF +
    '585.3365 138.2791 l' + CRLF +
    '582.9100 138.2791 l' + CRLF +
    '582.9100 137.0693 l' + CRLF +
    '585.1828 137.0693 l' + CRLF +
    '585.1828 136.6081 l' + CRLF +
    '582.9100 136.6081 l' + CRLF +
    '582.9100 135.2701 l' + CRLF +
    '585.4326 135.2701 l' + CRLF +
    '585.4326 134.8092 l' + CRLF +
    'f*' + CRLF +
    '0.12 0.10 0.09 rg' + CRLF +
    '589.0776 136.0704 m' + CRLF +
    '589.5964 136.1151 l' + CRLF +
    '589.6205 135.9181 589.6769 135.7563 589.7659 135.6296 c' + CRLF +
    '589.8546 135.5031 589.9927 135.4011 590.1795 135.3231 c' + CRLF +
    '590.3663 135.2449 590.5763 135.2061 590.8102 135.2061 c' + CRLF +
    '591.0177 135.2061 591.2008 135.2356 591.3598 135.2948 c' + CRLF +
    '591.5186 135.3540 591.6368 135.4351 591.7144 135.5383 c' + CRLF +
    '591.7918 135.6415 591.8306 135.7537 591.8306 135.8753 c' + CRLF +
    '591.8306 135.9984 591.7929 136.1064 591.7175 136.1982 c' + CRLF +
    '591.6424 136.2903 591.5186 136.3677 591.3459 136.4304 c' + CRLF +
    '591.2354 136.4715 590.9905 136.5352 590.6117 136.6223 c' + CRLF +
    '590.2328 136.7090 589.9674 136.7909 589.8158 136.8680 c' + CRLF +
    '589.6191 136.9664 589.4725 137.0886 589.3761 137.2346 c' + CRLF +
    '589.2795 137.3808 589.2313 137.5441 589.2313 137.7249 c' + CRLF +
    '589.2313 137.9239 589.2905 138.1099 589.4087 138.2825 c' + CRLF +
    '589.5269 138.4554 589.6993 138.5867 589.9263 138.6763 c' + CRLF +
    '590.1534 138.7658 590.4057 138.8106 590.6835 138.8106 c' + CRLF +
    '590.9890 138.8106 591.2589 138.7638 591.4925 138.6700 c' + CRLF +
    '591.7260 138.5765 591.9058 138.4387 592.0313 138.2567 c' + CRLF +
    '592.1569 138.0750 592.2247 137.8689 592.2340 137.6391 c' + CRLF +
    '591.7090 137.6005 l' + CRLF +
    '591.6810 137.8477 591.5857 138.0342 591.4236 138.1603 c' + CRLF +
    '591.2612 138.2865 591.0214 138.3497 590.7044 138.3497 c' + CRLF +
    '590.3745 138.3497 590.1338 138.2919 589.9827 138.1765 c' + CRLF +
    '589.8317 138.0611 589.7563 137.9220 589.7563 137.7590 c' + CRLF +
    '589.7563 137.6175 589.8098 137.5013 589.9167 137.4100 c' + CRLF +
    '590.0219 137.3187 590.2960 137.2252 590.7396 137.1297 c' + CRLF +
    '591.1832 137.0339 591.4877 136.9502 591.6526 136.8791 c' + CRLF +
    '591.8924 136.7736 592.0699 136.6401 592.1841 136.4788 c' + CRLF +
    '592.2984 136.3173 592.3556 136.1310 592.3556 135.9204 c' + CRLF +
    '592.3556 135.7115 592.2930 135.5148 592.1674 135.3300 c' + CRLF +
    '592.0418 135.1454 591.8618 135.0017 591.6268 134.8991 c' + CRLF +
    '591.3918 134.7965 591.1271 134.7452 590.8334 134.7452 c' + CRLF +
    '590.4607 134.7452 590.1483 134.7968 589.8966 134.9002 c' + CRLF +
    '589.6446 135.0034 589.4470 135.1587 589.3038 135.3665 c' + CRLF +
    '589.1604 135.5737 589.0850 135.8084 589.0776 136.0704 c' + CRLF +
    'f*' + CRLF +
    '0.91 0.51 0.12 rg' + CRLF +
    '435.3585 162.6480 m' + CRLF +
    '444.6814 162.6480 l' + CRLF +
    '444.6814 160.4421 l' + CRLF +
    '435.3585 160.4421 l' + CRLF +
    'h' + CRLF +
    '435.3585 158.2362 m' + CRLF +
    '444.6814 158.2362 l' + CRLF +
    '444.6814 156.0302 l' + CRLF +
    '435.3585 156.0302 l' + CRLF +
    'h' + CRLF +
    '435.3585 153.8045 m' + CRLF +
    '444.6814 153.8045 l' + CRLF +
    '444.6814 151.5986 l' + CRLF +
    '435.3585 151.5986 l' + CRLF +
    'h' + CRLF +
    '440.0096 167.0805 m' + CRLF +
    '449.3324 167.0805 l' + CRLF +
    '449.3324 164.8539 l' + CRLF +
    '440.0096 164.8539 l' + CRLF +
    'h' + CRLF +
    '440.0096 149.3926 m' + CRLF +
    '449.3324 149.3926 l' + CRLF +
    '449.3324 147.1870 l' + CRLF +
    '440.0096 147.1870 l' + CRLF +
    'h' + CRLF +
    '444.6814 171.4924 m' + CRLF +
    '467.9793 171.4924 l' + CRLF +
    '467.9793 169.2865 l' + CRLF +
    '444.6814 169.2865 l' + CRLF +
    'h' + CRLF +
    '444.6814 144.9601 m' + CRLF +
    '467.9793 144.9601 l' + CRLF +
    '467.9793 142.7542 l' + CRLF +
    '444.6814 142.7542 l' + CRLF +
    'h' + CRLF +
    '449.3324 156.0302 m' + CRLF +
    '449.3324 158.2362 l' + CRLF +
    '467.9793 158.2362 l' + CRLF +
    '467.9793 156.0302 l' + CRLF +
    'h' + CRLF +
    '458.6564 151.5986 m' + CRLF +
    '458.6564 153.8045 l' + CRLF +
    '467.9793 153.8045 l' + CRLF +
    '467.9793 151.5986 l' + CRLF +
    'h' + CRLF +
    '458.6564 147.1870 m' + CRLF +
    '458.6564 149.3926 l' + CRLF +
    '467.9793 149.3926 l' + CRLF +
    '467.9793 147.1870 l' + CRLF +
    'f*' + CRLF + 'Q';
begin
  LMemStream := TMemoryStream.Create;
  LMemStream.Write(LContentStr[1], Length(LContentStr));
  LMemStream.Position := 0;
  LStream := TgtMemoryStream.Create(LMemStream, 0, 0, False);
  LStream.Reset;
  LDict := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);
  TgtPDDictionary(LDict).Add(PDF_LENGTH, TgtPDInteger.Create(Length(LContentStr),
    $FFFFFFFF, $FFFFFFFF));

  LContent := TgtPDStream.Create(LStream, LDict);
  LContent.IsWritten := False;
  LContent.IsChanged := True;
  LContent.ObjNumber := FTrialMarkObjNo;
  LContent.GenNumber := 0;
  TgtPDDocument(FParentDoc).BaseDoc.AddToCollection(LContent);
end;

(**
  * Moves one page in a document.
  *
  * @param MoveToAfterPage The new location of the page to move. The first page
  *        is 1.
  * @param PageToMove The page number of the page to move.
  * @exception EBadParams Is raised if the Parameters are invalid
  *)

procedure TgtPDPageTree.MovePage(MoveToAfterPage, PageToMove: Integer);
begin
  if (MoveToAfterPage >= 0) and (MoveToAfterPage <= Count) and (PageToMove > 0)
    and (PageToMove <= Count) then
  begin
    GetPage(MoveToAfterPage - 1);
    FPageList.Move(PageToMove - 1, MoveToAfterPage);
    FPageRefs.Move(PageToMove - 1, MoveToAfterPage);
    FIsChanged := True;
  end;
end;

(**
 *  This function is responsible for reading and Creating the page tree
 *  @param APagesDict the dictionary that has the references to all Pages,
 *        (Pages Dictionary)
 *  @param AAlreadyRead an array that tells whether that particular page is
 *         already read or not
 *  @return True if the operation is successful, false otherwise
 *  @algorithm
 *           1.	Start
 *           2.	IF NOT Assigned FPageList Then
 *           3.	begin
 *             a.	Create ObjectList with FPageList and FPageRefs
 *             b.	SetLength LAlreadyRead array to XRef Size
 *             c.	Loop From 0 To Count
 *               i.	LAlreadyRead := Flase
 *             d.	Call ReadPageTree(FBaseObject, LAlreadtRead)
 *             e.	Free LAlreadyRead
 *           4.	End
 *           5.	IF Index >= 0 AND Index < Count Then
 *             a.	Return FPageList.Item[Index] as PDPage
 *           6.	ELSE
 *             a.	Return NIL
 *           7.	End
 *
 *)

function TgtPDPageTree.ReadPageTree(APagesDict: TgtPDBaseObject;
  var AAlreadyRead: array of Boolean; AInherited: TgtPDInheritedProperty): Boolean;
var
  LKids, LKid: TgtPDBaseObject;
  LI, LNum: Integer;
  LKidRef: TgtPDBaseObject;
  LPage: TgtPDPage;
  LInheritedAttr1, LInheritedAttr2: TgtPDInheritedProperty;
begin
  //Creates an object which holds the inherited properties
  LInheritedAttr1 := TgtPDInheritedProperty.Create(FParentDoc, AInherited,
    APagesDict);

  LKids := TgtPDDictionary(APagesDict).LookUp(PDF_KIDS);

  if not LKids.IsArray then
  begin
{$IFDEF DEBUG}
    Logger.LogError('Kids object pages is of wrong type');
{$ENDIF}
    LKids.Free;
    Result := False;
    Exit;
  end;

  //Traverse through the Kids array
  for LI := 0 to TgtPDArray(LKids).GetLength - 1 do
  begin
    LKidRef := TgtPDArray(LKids).GetRefObj(LI);
    LNum := TgtPDIndirectRef(LKidRef).ObjNumber;

    if LKidRef.IsIndirectRef and (LNum > 0) and
      (Cardinal(LNum) < TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.GetSize - 1) then
    begin
      if AAlreadyRead[LNum] then
      begin
{$IFDEF DEBUG}
        Logger.LogInfo('Loop in Pages tree');
{$ENDIF}
        LKidRef.Free;
        Continue;
      end;
      AAlreadyRead[LNum] := True;
    end;

    //Page object found
    LKid := TgtPDArray(LKids).Get(LI);
    if LKid.IsDict(PDF_PAGE) then
    begin
      LInheritedAttr2 := TgtPDInheritedProperty.Create(FParentDoc,
        LInheritedAttr1, LKid);
      FPageRefs.Add(TgtPDIndirectRef.Create(TgtPDIndirectRef(LKidRef).ObjNumber,
        TgtPDIndirectRef(LKidRef).GenNumber));
      LPage := TgtPDPage.Create(FParentDoc, Self, LKid);
      Inc(FPageNumber);
      LPage.PageNum := FPageNumber;
      THackPage(LPage).FInheritedProp := LInheritedAttr2;
      FPageList.Add(LPage);
    end
    else if LKid.IsDict(PDF_PAGES) then // Pages Dictionary found
    begin
      if not ReadPageTree(LKid, AAlreadyRead, LInheritedAttr1) then
      begin
        Result := False;
        Exit;
      end;
    end
    else
    begin
{$IFDEF DEBUG}
      Logger.LogError('Kid object page is wrong type');
{$ENDIF}
    end;
  end;
  Result := True;
end;

procedure TgtPDPageTree.ReplacePages(StartPage: Integer; SourceDoc: TgtObject;
  SourceStartPage, NumOfPages: Integer; MergeTextAnnots: Boolean);
begin
  DeletePages(StartPage, StartPage + NumOfPages - 1);
  InsertPages(StartPage - 1, SourceDoc, SourceStartPage, NumOfPages, InsertAll);
end;

procedure TgtPDPageTree.RequestPages(StartPages, NumOfPages: Integer;
  RequestPagesEvent: TgtRequestPagesEvent);
var
  LI: Integer;
begin
  for LI := 0 to NumOfPages - 1 do
    GetPage(LI + StartPages - 1);
end;

procedure TgtPDPageTree.StampGnosticeLogo;
var
  LI: Integer;
  LContentsRef, LContent, LContentFrmPage, LContentsArray: TgtPDBaseObject;
begin
  TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber :=
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber + 1;
  FTrialMarkObjNo := TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber;
  InsertTrialMark;
  for LI := 0 to FPageList.Count - 1 do
  begin
    LContent := TgtPDIndirectRef.Create(FTrialMarkObjNo, 0);
    LContentFrmPage := TgtPDDictionary(TgtPDPage(FPageList.Items[LI]).BaseObject).Lookup(PDF_CONTENTS);

    if Assigned(LContentFrmPage) and LContentFrmPage.IsArray then
    begin
      TgtPDArray(LContentFrmPage).Add(LContent);
    end
    else
      if Assigned(LContentFrmPage) and LContentFrmPage.IsStream then
      begin
        LContentsRef := TgtPDDictionary(TgtPDPage(FPageList.Items[LI]).BaseObject).Lookup(PDF_CONTENTS);
        TgtPDDictionary(TgtPDPage(FPageList.Items[LI]).BaseObject).Remove(PDF_CONTENTS);

        LContentsArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc,
          $FFFFFFFF, $FFFFFFFF);
        TgtPDArray(LContentsArray).Add(TgtPDIndirectRef.Create(LContentsRef.ObjNumber,
          LContentsRef.GenNumber));

        TgtPDArray(LContentsArray).Add(LContent);

        TgtPDDictionary(TgtPDPage(FPageList.Items[LI]).BaseObject).Add(PDF_CONTENTS, LContentsArray);
      end
      else
        if not Assigned(LContentFrmPage) then
        begin
          TgtPDDictionary(TgtPDPage(FPageList.Items[LI]).BaseObject).Add(PDF_CONTENTS, LContent);
        end;

    // Check for Same resource
//    LResObj := TgtPDDictionary(TgtPDPage(FPageList.Items[LI]).BaseObject).LookUp(PDF_RESOURCES);
//    if Assigned(LResObj) then
//    begin
//      LFontObj := TgtPDDictionary(LResObj).LookUp(PDF_FONT);
//      if not Assigned(FPageResourceList) then
//      begin
//        FPageResourceList := TObjectList.Create(True);
//        FPageResourceRefs := TObjectList.Create(False);
//        if Assigned(LFontObj) then
//        begin
//          for LK := 0 to TgtPDDictionary(LFontObj).GetLength - 1 do
//          begin
//            FPageResourceList.Add(TgtPDName.Create(TgtPDDictionary(LFontObj).GetKey(LK)));
//            FPageResourceRefs.Add(TgtPDDictionary(LFontObj).GetValueRefObj(LK));
//          end;
//        end;
//      end
//      else
//      begin
//        if Assigned(LFontObj) then
//        begin
//          for LK := 0 to TgtPDDictionary(LFontObj).GetLength - 1 do
//          begin
//            Found := False;
//            LKey := TgtPDDictionary(LFontObj).GetKey(LK);
//            for LJ := 0 to (FPageResourceList.Count - 1) do
//            begin
//              if TgtPDName(FPageResourceList.Items[LJ]).Value = LKey then
//              begin
//                LObjRef := TgtPDIndirectRef.Create(
//                  TgtPDBaseObject(FPageResourceRefs.Items[LJ]).ObjNumber,
//                  TgtPDBaseObject(FPageResourceRefs.Items[LJ]).GenNumber);
//                TgtPDDictionary(LFontObj).SetKeyValue(LKey, LObjRef);
//                Found := True;
//                Break;
//              end;
//            end;
//            if not Found then
//            begin
//              FPageResourceList.Add(TgtPDName.Create(LKey));
//              FPageResourceRefs.Add(TgtPDDictionary(LFontObj).GetValueRefObj(LK));
//            end;
//          end;
//        end;
//      end;
//    end;

  end;
end;

procedure TgtPDPageTree.StitchPages(AStitchToPage, AStitchFromPage: Integer);
var
  LI: Integer;
  LFromPageContents: TgtPDContents;
begin
  if (AStitchToPage < 1) or (AStitchToPage > Count) then
    Exit;
  if (AStitchFromPage < 1) or (AStitchFromPage > Count) then
    Exit;

  //Checking for the page rect for source and destination pages
  if (Pages[AStitchFromPage].GetPageWidth > Pages[AStitchToPage].GetPageWidth) then
  begin
    Pages[AStitchToPage].Mediabox.Left := Pages[AStitchFromPage].Mediabox.Left;
    Pages[AStitchToPage].Mediabox.Top := Pages[AStitchFromPage].Mediabox.Top;
    Pages[AStitchToPage].Mediabox.Right := Pages[AStitchFromPage].Mediabox.Right;
    Pages[AStitchToPage].Mediabox.Bottom := Pages[AStitchFromPage].Mediabox.Bottom;
  end;

  //Adda page contents from the source to destination page
  LFromPageContents := Pages[AStitchFromPage].Contents;
  for LI := 0 to LFromPageContents.StreamCount - 1 do
  begin
    Pages[AStitchToPage].Contents.AddStream(TgtPDContentStream(LFromPageContents.Streams[LI]).Clone, False);
  end;

  //Adding Resources from source to destination page resource
  CopyResource(AStitchFromPage, AStitchToPage);
end;

procedure TgtPDPageTree.StitchPagesSideBySide(AStitchToPage,
  AStitchFromPage: Integer);
var
  LI: Integer;
  LNewPageWidth: Double;
  LCMEntry: AnsiString;
  LMemStrm: TMemoryStream;
  LgtMemStrm: TgtMemoryStream;
  LFromPageContents: TgtPDContents;
  LDict, LContentStream: TgtPDBaseObject;
  LNewToPageContentStrm: TgtPDContentStream;
//  LToPageMediaBox, LFromPageMediaBox: TgtPDRect;
begin
  if (AStitchToPage < 1) or (AStitchToPage > Count) then
    Exit;
  if (AStitchFromPage < 1) or (AStitchFromPage > Count + 1) then
    Exit;
  //Expand the ToPage to accomodate FromPage, increase the width of mediabox
  if Assigned(Pages[AStitchToPage].Mediabox) then
  begin
    LNewPageWidth := Pages[AStitchToPage].Mediabox.Right +
      Pages[AStitchFromPage].Mediabox.Right;
    if Pages[AStitchToPage].IsInheritedMediaBox then
       Pages[AStitchToPage].SetMediaBox(Pages[AStitchToPage].Mediabox.Left,
        Pages[AStitchToPage].Mediabox.Top, LNewPageWidth,
        Pages[AStitchToPage].Mediabox.Bottom)
    else
      Pages[AStitchToPage].Mediabox.Right := LNewPageWidth;
    LNewPageWidth := 0;
  end;

  //Similarly Expand the cropbox
  if Assigned(Pages[AStitchToPage].Cropbox) then
  begin
    LNewPageWidth := Pages[AStitchToPage].Cropbox.Right +
      Pages[AStitchFromPage].Mediabox.Right;
    if Pages[AStitchToPage].IsInheritedCropBox then
      Pages[AStitchToPage].SetCropBox(Pages[AStitchToPage].Cropbox.Left,
        Pages[AStitchToPage].Cropbox.Top, LNewPageWidth, Pages[AStitchToPage].Cropbox.Bottom)
    else
      Pages[AStitchToPage].Cropbox.Right := LNewPageWidth;
  end;

  //Adds 'q' Save graphic state entry to the content stream
  LDict := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);
  LMemStrm := TMemoryStream.Create;
  LgtMemStrm := TgtMemoryStream.Create(LMemStrm, 0, 0, False);
  LCMEntry := 'q' + CRLF;
  LgtMemStrm.Write(LCMEntry);
  LgtMemStrm.Reset;

  TgtPDDictionary(LDict).Add(PDF_LENGTH, TgtPDInteger.Create(LMemStrm.Size));

  TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber :=
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber + 1;

  LContentStream := TgtPDStream.Create(LgtMemStrm, LDict,
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber, 0);
  LContentStream.IsChanged := True;

  TgtPDDocument(FParentDoc).BaseDoc.AddToCollection(LContentStream);

  LNewToPageContentStrm := TgtPDContentStream.Create(FParentDoc,
    Pages[AStitchToPage], LContentStream);
  //Add content stream at the begining of the contents array
  Pages[AStitchToPage].Contents.AddStream(LNewToPageContentStrm, True);

  if Assigned(LNewToPageContentStrm) then
    FreeAndNil(LNewToPageContentStrm);

  //Adds cm entry to the content stream
  LDict := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);
  LMemStrm := TMemoryStream.Create;
  LgtMemStrm := TgtMemoryStream.Create(LMemStrm, 0, 0, False);
  LCMEntry := 'Q' + #13#10 + '1 0 0 1 ' + FloatToStringLocale(
    (Pages[AStitchToPage].Mediabox.Right - Pages[AStitchFromPage].Mediabox.Right)
    ) + ' 0 ' + 'cm';
  LgtMemStrm.Write(LCMEntry);
  LgtMemStrm.Reset;

  TgtPDDictionary(LDict).Add(PDF_LENGTH, TgtPDInteger.Create(LMemStrm.Size));

  TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber :=
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber + 1;

  LContentStream := TgtPDStream.Create(LgtMemStrm, LDict,
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber, 0);
  LContentStream.IsChanged := True;

  TgtPDDocument(FParentDoc).BaseDoc.AddToCollection(LContentStream);

  LNewToPageContentStrm := TgtPDContentStream.Create(FParentDoc,
    Pages[AStitchToPage], LContentStream);

  Pages[AStitchToPage].Contents.AddStream(LNewToPageContentStrm, False);

  if Assigned(LNewToPageContentStrm) then
    FreeAndNil(LNewToPageContentStrm);

  LFromPageContents := Pages[AStitchFromPage].Contents;
  for LI := 0 to LFromPageContents.StreamCount - 1 do
  begin
    Pages[AStitchToPage].Contents.AddStream(LFromPageContents.Streams[LI], False);
  end;

  //Adding Resources from source to destination page resource
  CopyResource(AStitchFromPage, AStitchToPage);
end;

{$O-} // Turn off compiler optimization
procedure TgtPDPageTree.Update;
var
  LI: Integer;
  LContentsRef, LContent, LContentFrmPage, LContentsArray: TgtPDBaseObject;
  LObj, LObj2: TgtPDBaseObject;
begin
  if not Assigned(FPageList) then
    Exit;

  for LI := 0 to FPageList.Count - 1 do
    TgtPDPage(FPageList.Items[LI]).Update;

  FIsChanged := True;

  if FIsChanged and FBaseObject.IsDict(PDF_PAGES) then
  begin
    for LI := 0 to FPageList.Count - 1 do
      TgtPDPage(FPageList.Items[LI]).BaseObject.IsChanged := True;
    with FBaseObject as TgtPDDictionary do
    begin
      Remove(PDF_KIDS);
      LObj := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
      for LI := 0 to FPageRefs.Count - 1 do
      begin
        LObj2 := TgtPDIndirectRef.Create(TgtPDIndirectRef(FPageRefs.Items[LI]).ObjNumber,
          TgtPDIndirectRef(FPageRefs.Items[LI]).GenNumber);
        TgtPDArray(LObj).Add(LObj2);
      end;
      Add(PDF_KIDS, LObj);

      Remove(PDF_COUNT);
      LObj := TgtPDInteger.Create(FPageList.Count);
      Add(PDF_COUNT, LObj);
    end;
  end;

  if not IsReg then
    StampGnosticeLogo;
  FreeObject(FPageResourceList);
  FreeObject(FPageResourceRefs);
end;

{$O+} // Turn ON compiler optimization

procedure TgtPDPageTree.UpdatePageNumbers(AFromPageNo: Integer);
var
  LI: Integer;
begin
  for LI := AFromPageNo to Count do
  begin
    Pages[AFromPageNo - 1].PageNum := Pages[AFromPageNo].PageNum + 1;
  end;
end;

end.
