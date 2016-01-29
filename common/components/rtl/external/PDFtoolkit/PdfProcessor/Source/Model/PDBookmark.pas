{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Model                   }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

{$I ..\Utils\gtCompilerDefines.inc}

unit PDBookmark;

interface

uses
  gtObject, PDElement, PDBaseObject, PDDictionary, PDAction, PDTypes,
  PDDestination, Contnrs, Classes, SysUtils;

type
  TgtPDOutlineFlag = record
    //If True, display the item in italic.
    Italic: Boolean;
    //If True, display the item in bold.
    Bold: Boolean;
    //If True, Underline the item.
    Underline: Boolean;
    //If True, Strikeout the item.
    StrikeOut: Boolean;
  end;

  TgtOutlineTaversalType = (ottDepthFirst);

  TgtOutlineTraversalDepth = (otdSiblingsOnly, otdChildrenOnly, otdFullSubtree);

  TgtPDBookmark = class;

  TgtBookmarkList = class(TObjectList)
  private
    function Get(Index: Integer): TgtPDBookmark;
  public
    procedure Notify(Ptr: Pointer; Action: TListNotification); override;
    property Items[Index: Integer]: TgtPDBookmark read Get;
  end;

 (**
  * A bookmark corresponds to an outline object in a PDF document. A document
  * outline allows the user to navigate interactively from one part of the
  * document to another. An outline consists of a tree-structured hierarchy of
  * bookmarks, which display the document's structure to the user. Each bookmark
  * has:
  *   A title that appears on screen.
  *   An action that specifies what happens when the user clicks on the bookmark.
  *
  * The typical action for a user-created bookmark is to move to another location
  * in the current document, although any action (see TgtPDAction) can be specified.
  *
  * Each bookmark in the bookmark tree structure has zero or more children that
  * appear indented on screen, and zero or more siblings that appear at the same
  * indentation level. All bookmarks except the bookmark at the top level of the
  * hierarchy have one parent, the bookmark under which it is indented.
  *)
  TgtPDBookmark = class(TgtPDElement)
  private
    FParent: TgtPDBookmark;
    FPrev: TgtPDBookmark;
    FNext: TgtPDBookmark;
    FFirstChild: TgtPDBookmark;
    FLastChild: TgtPDBookmark;
    FAction: TgtPDAction;
    FCount: Integer;
    FOutlineFlags: TgtPDOutlineFlag;
    FColor: TgtPDColorValue;
    FTitle: AnsiString;
    FDestination: TgtPDDestination;

    //For new Bookmark
//    FBookmarkDict: TgtPDDictionary;

    FLevel: Integer;
    FIndex: Integer;

    FBookmarkList: TgtBookmarkList;
    FTitleFound: Boolean;
    //Initialize all First level nodes of the BookMark;
    procedure FillAllBookmarks;
    //Traverse and gets the bookmark matching same title
    function TraverseNGetBookMark(ABookmark: TgtPDBookmark;
      ATitle: AnsiString; ADepth: Integer): TgtPDBookmark;
    function GetLastChild: TgtPDBookmark;
    function GetNext: TgtPDBookmark;
    function GetParent: TgtPDBookmark;
    function GetPrev: TgtPDBookmark;
    function GetTitle: AnsiString;
    function GetAction: TgtPDAction;
    function GetCount: Integer;
    function GetFirstChild: TgtPDBookmark;
    function GetFlags: TgtPDOutlineFlag;
    function GetDestination: TgtPDDestination;

    procedure SetFlags(const AFlags: TgtPDOutlineFlag);
    procedure SetTitle(const Title: AnsiString);
//    procedure SetAction(Action: TgtPDAction);
    function CreateDestArray(ADestination: TgtPDDestination): TgtPDBaseObject;
    function InsertNewChild(const Title: AnsiString; var ADestination: TgtPDDestination;
      var AOutlineFlag: TgtPDOutlineFlag; Action: TgtPDAction): TgtPDBookmark;
    function InsertNewNext(const Title: AnsiString; var ADestination: TgtPDDestination;
      var AOutlineFlag: TgtPDOutlineFlag; Action: TgtPDAction): TgtPDBookmark;
    function InsertNewPrev(const Title: AnsiString; var ADestination: TgtPDDestination;
      var AOutlineFlag: TgtPDOutlineFlag; Action: TgtPDAction): TgtPDBookmark;
    procedure AddAction(Action: TgtPDAction; ABookmarkDict: TgtPDDictionary);
    function TraverseDepthFirst(ABookmark: TgtPDBookmark; const ATitle: Ansistring;
      ADepth: TgtOutlineTraversalDepth): TgtPDBookmark;
  public
    constructor Create(AParentDoc: TgtObject; AParentElement: TgtPDElement;
      ABaseObject: TgtPDBaseObject); overload;

    constructor Create; overload;
    destructor Destroy; override;

    procedure Update; override;

    function AddNewChild(const Title: AnsiString; ADestination: TgtPDDestination;
      var AOutlineFlag: TgtPDOutlineFlag): TgtPDBookmark; overload;
    function AddNewChild(const Title: AnsiString; Action: TgtPDAction;
      var AOutlineFlag: TgtPDOutlineFlag): TgtPDBookmark; overload;
    function AddNewSibling(const InitialText: AnsiString): TgtPDBookmark;
    function AddNewNext(const Title: AnsiString;  ADestination: TgtPDDestination;
      var AOutlineFlag: TgtPDOutlineFlag): TgtPDBookmark; overload;
    function AddNewNext(const Title: AnsiString; Action: TgtPDAction;
      var AOutlineFlag: TgtPDOutlineFlag): TgtPDBookmark; overload;
    function AddNewPrev(const Title: AnsiString; Action: TgtPDAction;
      var AOutlineFlag: TgtPDOutlineFlag): TgtPDBookmark; overload;
    function AddNewPrev(const Title: AnsiString; ADestination: TgtPDDestination;
      var AOutlineFlag: TgtPDOutlineFlag): TgtPDBookmark; overload;

    procedure AddChild(NewChild: TgtPDBookmark);
    procedure AddNext(NewNext: TgtPDBookmark);
    procedure AddPrev(NewPrev: TgtPDBookmark);
    procedure AddSubTree(Source: TgtPDBookmark; const SourceTitle: AnsiString);
    function DeleteChild(AIndex: Integer): Boolean; overload;
    function DeleteNext: Boolean;
    function DeletePrev: Boolean;

    function GetByTitle(const Name: AnsiString; TraversalType: TgtOutlineTaversalType;
      MaxDepth: TgtOutlineTraversalDepth): TgtPDBookmark;
    function GetColor(var Color: TgtPDColorValue): Boolean;
    function GetChild(AIndex: Integer):TgtPDBookmark;
    function GetIndent: Integer;

    function HasChildren: Boolean;
    function IsSame(ABookMark: TgtPDBookmark): Boolean;
    procedure RemoveAction;
    procedure UnLink;

    procedure SetDestination(ADestination: TgtPDDestination);
    procedure SetAction(AAction: TgtPDAction);
    procedure SetColor(const Color: TgtPDColorValue);

    property Level: Integer read FLevel write FLevel;
    property BookmarkIndex: Integer read FIndex write FIndex;
    property Action: TgtPDAction read GetAction;
    property Title: AnsiString read GetTitle write SetTitle;
    property Flags: TgtPDOutlineFlag read GetFlags write SetFlags;
    property Count: Integer read GetCount;
    property FirstChild: TgtPDBookmark read GetFirstChild;
    property LastChild: TgtPDBookmark read GetLastChild;
    property Parent: TgtPDBookmark read GetParent;
    property Next: TgtPDBookmark read GetNext;
    property Prev: TgtPDBookmark read GetPrev;
    property Destination: TgtPDDestination read GetDestination write SetDestination;
  end;

implementation

uses gtConstants, gtMethods, PDInteger, PDString, PDReal, PDArray,
  PDName, PDIndirectRef, PDNull, PDModelException, PDDocument, PDPage,
  PDGoToRemoteAction, PDBoolean, PDURIAction, PDGoToAction, PDLaunchAction,
  PDJavaScriptAction;

{ TgtPDBookmark }

 (**
  * Adds Bookmark as the last child of parent, adjusting the tree containing
  * parent appropriately.
  *
  * @param Bookmark The bookmark that will become the last child. Bookmark must
  *        have been previously unlinked.
  *)

procedure TgtPDBookmark.AddAction(Action: TgtPDAction; ABookmarkDict: TgtPDDictionary);
var
  LDict, LActionDict: TgtPDDictionary;
  LArray: TgtPDArray;
  LPage: TgtPDPage;
  LIndRef: TgtPDIndirectRef;
begin
  TgtPDDocument(FParentDoc).LastObjectNumber :=
    TgtPDDocument(FParentDoc).LastObjectNumber + 1;
  LActionDict := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).LastObjectNumber, 0,
    TgtPDDocument(FParentDoc).BaseDoc);
  TgtPDDocument(FParentDoc).BaseDoc.AddToCollection(LActionDict);
  with LActionDict do
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
          with TgtPDGoToRemoteAction(Action).Destination do
          begin
              // Hw to get the page size of the external pdf file??
//            Rect.Top := TgtPDPage(Page).GetPageHeight - Rect.Top;
//            Rect.Bottom := TgtPDPage(Page).GetPageHeight - Rect.Bottom;
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
      actionSubmitForm: ;
      actionResetForm: ;
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
  LIndRef := TgtPDIndirectRef.Create(LActionDict.ObjNumber, LActionDict.GenNumber);
  ABookmarkDict.Add(PDF_A, LIndRef);
end;

procedure TgtPDBookmark.AddChild(NewChild: TgtPDBookmark);
var
  LLastChild: TgtPDBookmark;
  LObj, LIndRef: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    //Create a Indirect Ref to NewChild
    LIndRef := TgtPDIndirectRef.Create(NewChild.BaseObject.ObjNumber,
      NewChild.BaseObject.GenNumber);
    LLastChild := LastChild;
    if Assigned(LLastChild) then
    begin
      //Create Current Last Child's Indirect Ref
      LObj := TgtPDIndirectRef.Create(LLastChild.BaseObject.ObjNumber,
        LLastChild.BaseObject.GenNumber);
      //Set Next node of Current Last Child to NewChild
      TgtPDDictionary(LLastChild.BaseObject).SetKeyValue(PDF_NEXT, LIndRef);
      //Set NewChild's Prev node to Current Last child
      TgtPDDictionary(NewChild.BaseObject).SetKeyValue(PDF_PREV, LObj);
    end
    else //No Child found, set NewC
      TgtPDDictionary(FBaseObject).SetKeyValue(PDF_FIRST, LIndRef);

    TgtPDDictionary(FBaseObject).SetKeyValue(PDF_LAST, LIndRef);
    LObj := TgtPDIndirectRef.Create(FBaseObject.ObjNumber, FBaseObject.GenNumber);
    TgtPDDictionary(NewChild.BaseObject).SetKeyValue(PDF_PARENT, LObj);
  end;
end;

 (**
  * Adds a new bookmark to the tree ,as the new last child of Self.
  *
  * @param InitialText The new bookmark's title.
  *
  * @return The newly created bookmark.
  *)

function TgtPDBookmark.AddNewChild(const Title: AnsiString; ADestination: TgtPDDestination;
  var AOutlineFlag: TgtPDOutlineFlag): TgtPDBookmark;
begin
  Result := InsertNewChild(Title, ADestination, AOutlineFlag, nil);
end;

function TgtPDBookmark.AddNewChild(const Title: AnsiString; Action: TgtPDAction;
  var AOutlineFlag: TgtPDOutlineFlag): TgtPDBookmark;
var
  LDest: TgtPDDestination;
begin
  LDest := nil;
  Result := InsertNewChild(Title, LDest, AOutlineFlag, Action);
end;

function TgtPDBookmark.AddNewNext(const Title: AnsiString;
  ADestination: TgtPDDestination; var AOutlineFlag: TgtPDOutlineFlag): TgtPDBookmark;
begin
  Result := InsertNewNext(Title, ADestination, AOutlineFlag, nil);
end;

function TgtPDBookmark.AddNewNext(const Title: AnsiString; Action: TgtPDAction;
  var AOutlineFlag: TgtPDOutlineFlag): TgtPDBookmark;
var
  LDest: TgtPDDestination;
begin
  LDest := nil;
  Result := InsertNewNext(Title, LDest, AOutlineFlag, Action);
end;

function TgtPDBookmark.AddNewPrev(const Title: AnsiString; Action: TgtPDAction;
  var AOutlineFlag: TgtPDOutlineFlag): TgtPDBookmark;
var
  LDest: TgtPDDestination;
begin
  LDest := nil;
  Result := InsertNewPrev(Title, LDest, AOutlineFlag, Action);
end;

function TgtPDBookmark.AddNewPrev(const Title: AnsiString;
  ADestination: TgtPDDestination; var AOutlineFlag: TgtPDOutlineFlag): TgtPDBookmark;
begin
  Result := InsertNewPrev(Title, ADestination, AOutlineFlag, nil);
end;

 (**
  * Adds a new bookmark to the tree containing Self, as the new right sibling.
  *
  * @param initialText The new bookmark's title.
  *
  * @return The newly created bookmark.
  *)

function TgtPDBookmark.AddNewSibling(const InitialText: AnsiString): TgtPDBookmark;
begin
  Result := nil;
end;

 (**
  * Adds newNext as the new right sibling
  *
  * @param NewNext The bookmark to become the new right sibling of Self. NewNext
  *        must have been previously unlinked.
  *)

procedure TgtPDBookmark.AddNext(NewNext: TgtPDBookmark);
var
  LObj, LIndRef: TgtPDBaseObject;
  LNext: TgtPDBookmark;
begin
  if Assigned(FBaseObject) then
  begin
    //Create an Indirect Ref to NewNode
    LIndRef := TgtPDIndirectRef.Create(NewNext.BaseObject.ObjNumber,
      NewNext.BaseObject.GenNumber);
    LNext := Next;
    if Assigned(LNext) then
    begin
      //Update Prev node of current Next-Bookmark
      LObj := TgtPDDictionary(LNext.BaseObject).LookUp(PDF_PREV);
      if Assigned(LObj) then
        TgtPDDictionary(LNext.BaseObject).SetKeyValue(PDF_PREV, LIndRef)
      else
        TgtPDDictionary(LNext.BaseObject).Add(PDF_PREV, LIndRef);

      //Update Next node of NewNext-Bookmark
      LObj := TgtPDIndirectRef.Create(LNext.BaseObject.ObjNumber,
        LNext.BaseObject.GenNumber);
      TgtPDDictionary(NewNext.BaseObject).SetKeyValue(PDF_NEXT, LObj);
    end
    else //No next node available, set it to NULL
    begin
      LObj := TgtPDNull.Create;
      TgtPDDictionary(NewNext.BaseObject).SetKeyValue(PDF_NEXT, LObj);
    end;
    //Create an indirect ref to Current Node
    LObj := TgtPDIndirectRef.Create(FBaseObject.ObjNumber, FBaseObject.GenNumber);

    //Set the Next node of Current node to NewNext
    TgtPDDictionary(FBaseObject).SetKeyValue(PDF_NEXT, LIndRef);

    //Set the Prev node of NewNext node to Current node
    TgtPDDictionary(NewNext.BaseObject).SetKeyValue(PDF_PREV, LObj);
  end;
end;

 (**
  * Adds NewPrev as the new left sibling to Self, adjusting the tree appropriately.
  *
  * @param NewPrev The bookmark to become the new left sibling of Self. NewPrev
  *        must have been previously unlinked.
  *
  *)

procedure TgtPDBookmark.AddPrev(NewPrev: TgtPDBookmark);
var
  LObj, LIndRef: TgtPDBaseObject;
  LPrev: TgtPDBookmark;
begin
  if Assigned(FBaseObject) then
  begin
    //Create an Indirect Ref to NewNode
    LIndRef := TgtPDIndirectRef.Create(NewPrev.BaseObject.ObjNumber,
      NewPrev.BaseObject.GenNumber);
    LPrev := Prev;
    if Assigned(LPrev) then
    begin
      //Updating NEXT of current PREV Bookmark
      LObj := TgtPDDictionary(LPrev.BaseObject).LookUp(PDF_NEXT);
      if Assigned(LObj) then
        TgtPDDictionary(LPrev.BaseObject).SetKeyValue(PDF_NEXT, LIndRef)
      else
        TgtPDDictionary(LPrev.BaseObject).Add(PDF_NEXT, LIndRef);

      //Updating PREV nod of NewPrev
      LObj := TgtPDIndirectRef.Create(LPrev.BaseObject.ObjNumber,
        LPrev.BaseObject.GenNumber);
      TgtPDDictionary(NewPrev.BaseObject).SetKeyValue(PDF_PREV, LObj);
    end
    else //No Prev node Available, set it to NULL
    begin
      LObj := TgtPDNull.Create;
      TgtPDDictionary(NewPrev.BaseObject).SetKeyValue(PDF_PREV, LObj);
    end;

    //Create an Indirect Ref for current node
    LObj := TgtPDIndirectRef.Create(FBaseObject.ObjNumber, FBaseObject.GenNumber);

    //Set the Prev node of Current
    TgtPDDictionary(FBaseObject).SetKeyValue(PDF_PREV, LIndRef);
    TgtPDDictionary(LPrev.BaseObject).SetKeyValue(PDF_NEXT, LObj);
  end;
end;

 (**
  * Adds a copy of the bookmark subtree source to the Bookmark, as a new last
  * child of the Bookmark. This new item will have the text value SourceTitle
  * and will have no destination attribute. source must have been previously
  * unlinked.
  *
  * @param Source The bookmark subtree to add.
  * @param SourceTitle The new bookmark's title.
  *)

procedure TgtPDBookmark.AddSubTree(Source: TgtPDBookmark;
  const SourceTitle: AnsiString);
begin

end;

constructor TgtPDBookmark.Create;
begin
  FNext := nil;
  FPrev := nil;
  FLastChild := nil;
  FFirstChild := nil;
  FParent := nil;
  FTitle := '';
end;

function TgtPDBookmark.CreateDestArray(ADestination: TgtPDDestination): TgtPDBaseObject;
var
  LObj, LIndRef: TgtPDBaseObject;
begin
  //Add Page reference to Dest Array
  LObj := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
  LIndRef := TgtPDIndirectRef.Create(TgtPDPage(ADestination.Page).BaseObject.ObjNumber,
    TgtPDPage(ADestination.Page).BaseObject.GenNumber);
  TgtPDArray(LObj).Add(LIndRef);

  ADestination.Rect.Top := TgtPDPage(ADestination.Page).GetPageHeight -
    ADestination.Rect.Top;
  ADestination.Rect.Bottom := TgtPDPage(ADestination.Page).GetPageHeight -
    ADestination.Rect.Bottom;
    
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

constructor TgtPDBookmark.Create(AParentDoc: TgtObject;
  AParentElement: TgtPDElement; ABaseObject: TgtPDBaseObject);
begin
  FParentDoc := AParentDoc;
  FParentElement := AParentElement;
  FBaseObject := ABaseObject;

  if FParentElement is TgtPDBookmark then
    FLevel := TgtPDBookmark(FParentElement).Level + 1
  else
    FLevel := 0;

  FCount := 0;
  FIndex := 0;
  FNext := nil;
  FPrev := nil;
  FFirstChild := nil;
  FLastChild := nil;
  FTitle := '';
end;

function TgtPDBookmark.DeleteChild(AIndex: Integer): Boolean;
var
  LBookmark, LNext, LPrev: TgtPDBookmark;
  I: Integer;
begin
  Result := False;
  LBookmark := GetChild(AIndex);
  if not Assigned(LBookmark) then Exit;
  Result := True;
  LNext := LBookmark.Next;
  if AIndex = 0 then
  begin
    if Assigned(LNext) then
    begin
      TgtPDDictionary(Self.FBaseObject).SetKeyValue(PDF_FIRST,
        TgtPDIndirectRef.Create(LNext.FBaseObject.ObjNumber,
          LNext.FBaseObject.GenNumber));
      if not Assigned(LNext.Next) then
        TgtPDDictionary(Self.FBaseObject).SetKeyValue(PDF_LAST,
          TgtPDIndirectRef.Create(LNext.FBaseObject.ObjNumber,
            LNext.FBaseObject.GenNumber));
      TgtPDDictionary(LNext).Remove(PDF_PREV);
    end
    else //Its the one and only one child
    begin
      TgtPDDictionary(Self.FBaseObject).Remove(PDF_FIRST);
      TgtPDDictionary(Self.FBaseObject).Remove(PDF_LAST);
    end;
  end
  else
  begin
    LPrev := LBookmark.Prev;
    if Assigned(LNext) then
    begin
      TgtPDDictionary(LNext.FBaseObject).SetKeyValue(PDF_PREV,
       TgtPDIndirectRef.Create(LPrev.FBaseObject.ObjNumber,
        LPrev.FBaseObject.GenNumber));

      TgtPDDictionary(LPrev.FBaseObject).SetKeyValue(PDF_NEXT,
       TgtPDIndirectRef.Create(LNext.FBaseObject.ObjNumber,
        LNext.FBaseObject.GenNumber));
    end
    else // its the last child
    begin
      TgtPDDictionary(LPrev.FBaseObject).Remove(PDF_NEXT);
    end;
  end;
  if Result then
  begin
    FBookmarkList.Delete(AIndex);
    for I := AIndex to FBookmarkList.Count - 1 do
      FBookmarkList.Items[I].BookmarkIndex :=
        FBookmarkList.Items[I].BookmarkIndex - 1;
  end;
end;

function TgtPDBookmark.DeleteNext: Boolean;
var
  LNext, LNext1: TgtPDBookmark;
  I: Integer;
  LBookmarkList: TgtBookmarkList;
begin
  Result := False;
  LNext := Self.Next;
  if Assigned(LNext) then
  begin
    Result := True;
    LNext1 := LNext.Next;
    if Assigned(LNext1) then
    begin
      TgtPDDictionary(LNext1.FBaseObject).SetKeyValue(PDF_PREV,
        TgtPDIndirectRef.Create(Self.FBaseObject.ObjNumber,
          Self.FBaseObject.GenNumber));
      TgtPDDictionary(Self.FBaseObject).SetKeyValue(PDF_NEXT,
        TgtPDIndirectRef.Create(LNext1.FBaseObject.ObjNumber,
          LNext1.FBaseObject.GenNumber));
    end
    else
    begin
      TgtPDDictionary(Self.FBaseObject).Remove(PDF_NEXT);
      TgtPDDictionary(Self.Parent.FBaseObject).SetKeyValue(PDF_LAST,
        TgtPDIndirectRef.Create(Self.FBaseObject.ObjNumber,
        Self.FBaseObject.GenNumber));
    end;
    LBookmarkList := Self.Parent.FBookmarkList;
    LBookmarkList.Delete(LNext.BookmarkIndex);
    for I := LNext.BookmarkIndex to LBookmarkList.Count - 1 do
      LBookmarkList.Items[I].BookmarkIndex :=
        LBookmarkList.Items[I].BookmarkIndex - 1;
  end;
end;

function TgtPDBookmark.DeletePrev: Boolean;
var
  LPrev, LPrev1: TgtPDBookmark;
  LBookmarkList: TgtBookmarkList;
  I: Integer;
begin
  LPrev := Self.Prev;
  if Assigned(LPrev) then
  begin
    Result := True;
    LPrev1 := LPrev.Prev;
    if Assigned(LPrev1) then
    begin
      TgtPDDictionary(LPrev1.FBaseObject).SetKeyValue(PDF_Next,
        TgtPDIndirectRef.Create(Self.FBaseObject.ObjNumber,
        Self.FBaseObject.GenNumber));

      TgtPDDictionary(Self.FBaseObject).SetKeyValue(PDF_PREV,
        TgtPDIndirectRef.Create(LPrev1.FBaseObject.ObjNumber,
        LPrev1.FBaseObject.GenNumber));
    end
    else
    begin
      TgtPDDictionary(Self.FBaseObject).Remove(PDF_PREV);
      TgtPDDictionary(Self.Parent.FBaseObject).SetKeyValue(PDF_FIRST,
        TgtPDIndirectRef.Create(Self.FBaseObject.ObjNumber,
        Self.FBaseObject.GenNumber));
    end;
    LBookmarkList := Self.Parent.FBookmarkList;
    LBookmarkList.Delete(LPrev.BookmarkIndex);
    for I := LPrev.BookmarkIndex to LBookmarkList.Count - 1 do
      LBookmarkList.Items[I].BookmarkIndex :=
        LBookmarkList.Items[I].BookmarkIndex - 1;
  end;
end;

destructor TgtPDBookmark.Destroy;
begin
  if Assigned(FBookmarkList) then
    FreeObject(FBookmarkList);
//  if Assigned(FDestination) then
//    FreeObject(FDestination);
//  if Assigned(FFirstChild) then
//    FreeObject(FFirstChild);
//  if Assigned(FNext) then
//    FreeObject(FNext);
//  if Assigned(FPrev) then
//    FreeObject(FPrev);
//  if Assigned(FLastChild) then
//    FreeObject(FLastChild);
//  if Assigned(FAction) then
//    FreeAndNil(FAction);
//  if Assigned(FDestination) then
//    FreeAndNil(FDestination);
end;

procedure TgtPDBookmark.FillAllBookmarks;
var
  LObj: TgtPDBookmark;
begin
  LObj := GetFirstChild;
  if (LObj <> nil) then
  begin
    while LObj <> nil do
    begin
      LObj := LObj.GetNext;
    end;
  end;
end;

(**
  * Gets a bookmark's action
  *
  * @return The bookmark's action.
  *)

function TgtPDBookmark.GetAction: TgtPDAction;
var
  LActionDict: TgtPDBaseObject;
begin
  if not Assigned(FAction) then
  begin
    LActionDict := TgtPDDictionary(FBaseObject).LookUp(PDF_A);
    if Assigned(LActionDict) then
      FAction := TgtPDAction.MakeAction(FParentDoc, Self, LActionDict);
  end;

  Result := FAction;
end;

 (**
  * Gets the first bookmark whose title is Name.
  *
  * @param Name The text value to search for. Character codes in Name are
  *        interpreted using the PDFDocEncoding.
  * @param MaxDepth The number of subtree levels to search, not counting the
  * root level:
  *   Value - Description
  *     0 - Only look at aBookmark , not at any of its children.
  *     1 - Check aBookmark and its children, but not any grandchildren or great
  *         grandchildren, and so on.
  *     -1 - Check the entire subtree.
  *
  *)

function TgtPDBookmark.GetByTitle(const Name: AnsiString;
  TraversalType: TgtOutlineTaversalType; MaxDepth: TgtOutlineTraversalDepth):
    TgtPDBookmark;
begin
  Result := nil;
  FTitleFound := False;
  case TraversalType of
    ottDepthFirst:
    begin
      Result := TraverseDepthFirst(Self, Name, MaxDepth);
    end;
  end;
end;

 (**
  *Retrieves the color of the specified bookmark.
  *
  * @param Color (Filled by the method) The color of the bookmark in
  *        TgtPDColorValue format.
  * @return True if the color was specified, false otherwise (the default color
  *         is returned in Color).
  * @exception EInvalidBookmark if the bookmark is invalid or the existing color
  *            is malformed in the PDF file.
  *)

function TgtPDBookmark.GetChild(AIndex: Integer): TgtPDBookmark;
var
  LBookmark: TgtPDBookmark;
  I: Integer;
begin
  Result := nil;
  if not HasChildren then Exit;
  if Assigned(FBookmarkList) and (FBookmarkList.Count > 0)
    and (FBookmarkList.Count < AIndex) then
  begin
    Result := FBookmarkList.Items[AIndex];
  end
  else // Get the rest of the bookmarks
  begin
    LBookmark := FBookmarkList.Items[FBookmarkList.Count - 1];
    while (LBookmark <> nil) and (FBookmarkList.Count < AIndex) do
      LBookmark := LBookmark.Next;
    if FBookmarkList.Count = AIndex + 1 then
      Result := FBookmarkList.Items[AIndex];
  end;
end;

function TgtPDBookmark.GetColor(var Color: TgtPDColorValue): Boolean;
var
  LColorObj, LObj: TgtPDBaseObject;
  LI: Integer;
begin
  Result := False;
  if Assigned(FBaseObject) then
  begin
    LColorObj := TgtPDDictionary(FBaseObject).LookUp(PDF_C);
    if Assigned(LColorObj) and LColorObj.IsArray then
    begin
      for LI := 0 to TgtPDArray(LColorObj).GetLength - 1 do
      begin
        LObj := TgtPDArray(LColorObj).Get(LI);
        if LObj.IsReal then
          FColor.Value[LI] := TgtPDReal(LObj).Value
        else
          FColor.Value[LI] := TgtPDInteger(LObj).Value;
        FColor.ColorSpace := DeviceRGB;
      end;
      Result := True;
    end;
  end;
  Color := FColor;
end;

 (**
  * Gets the number of open bookmarks in a subtree.
  *
  * @return The number of open bookmarks in the subtree (not including the Bookmark).
  *)

function TgtPDBookmark.GetCount: Integer;
var
  LCountObj: TgtPDBaseObject;
begin
  LCountObj := TgtPDDictionary(FBaseObject).LookUp(PDF_COUNT);
  if Assigned(LCountObj) then
    if LCountObj.IsInteger then
      FCount := TgtPDInteger(LCountObj).Value;

  Result := FCount;
end;

function TgtPDBookmark.GetDestination: TgtPDDestination;
var
  LDestObj: TgtPDBaseObject;
  LViewType: AnsiString;
begin
  if Assigned(FBaseObject) then
  begin
    if not Assigned(FDestination) then
    begin
      LDestObj := TgtPDDictionary(FBaseObject).LookUp(PDF_DEST);
      if Assigned(LDestObj) then
      begin
        if LDestObj.IsArray then
        begin
          FDestination := TgtPDDestination.Create(FParentDoc, Self, LDestObj);
        end
        else if LDestObj.IsName then
        begin
          FDestination := TgtPDDestination.Create;
          LViewType := TgtPDName(LDestObj).Value;
          if LViewType = PDF_XYZ then
            FDestination.DisplayOptions := FitZoom
          else if LViewType = PDF_FIT then
            FDestination.DisplayOptions := FitAll
          else if LViewType = PDF_FITH then
            FDestination.DisplayOptions := FitHeight
          else if LViewType = PDF_FITV then
            FDestination.DisplayOptions := FitWidth
          else if LViewType = PDF_FITR then
            FDestination.DisplayOptions := FitRect
          else if LViewType = PDF_FITB then
            FDestination.DisplayOptions := FitBoundingBox
          else if LViewType = PDF_FITBH then
            FDestination.DisplayOptions := FitBoundingBoxHeight
          else if LViewType = PDF_FITBV then
            FDestination.DisplayOptions := FitBoundingBoxWidth;

          FDestination.Page := nil;
          FDestination.Rect.Left := 0;
          FDestination.Rect.Top := 0;
          FDestination.Rect.Right := 0;
          FDestination.Rect.Bottom := 0;
        end;
      end;
    end;
  end;
  Result := FDestination;
end;

(**
  * Gets a bookmark's first child.
  *
  * @return The first child of aBookmark, or a Nil if Bookmark has no children.
  *)

function TgtPDBookmark.GetFirstChild: TgtPDBookmark;
var
  LFirstDict: TgtPDBaseObject;
  LFirstChild: TgtPDBookmark;
begin
  Result := nil;
  if not Assigned(FBookmarkList) or (FBookmarkList.Count = 0) then
  begin
    FBookmarkList := TgtBookmarkList.Create;
    LFirstDict := TgtPDDictionary(FBaseObject).LookUp(PDF_FIRST);
    if Assigned(LFirstDict) then
    begin
      LFirstChild := TgtPDBookmark.Create(FParentDoc, Self, LFirstDict);
      LFirstChild.BookmarkIndex := 0;
      LFirstChild.Level := Self.Level + 1;
      FBookmarkList.Add(LFirstChild);
      Result := LFirstChild;
    end;
  end
  else
    Result := FBookmarkList.Items[0];
end;

 (**
  * Retrieves the flags of the specified bookmark.
  *
  * @return The bookmark's flags.
  * @exception EInvalidBookmark if the bookmark is invalid or the existing style
  *            is malformed in the PDF file.
  *)

function TgtPDBookmark.GetFlags: TgtPDOutlineFlag;
var
  LFlagObj: TgtPDBaseObject;
  LFlag: Integer;
begin
  LFlagObj := TgtPDDictionary(FBaseObject).LookUp(PDF_F);
  if Assigned(LFlagObj) then
  begin
    if LFlagObj.IsInteger then
    begin
      LFlag := TgtPDInteger(LFlagObj).Value;
      FOutlineFlags.Italic := Boolean(LFlag and $1);
      FOutlineFlags.Bold := Boolean(LFlag and $2);
    end;
  end
  else
  begin
    FOutlineFlags.Italic := False;
    FOutlineFlags.Bold := False;
  end;

  Result := FOutlineFlags;
end;

 (**
  * Returns the indentation level of a bookmark in its containing tree.
  *
  * @return The indentation level of the Bookmark in its containing tree. The
  *         root level has an indentation level of zero.
  *)

function TgtPDBookmark.GetIndent: Integer;
begin
  Result := FLevel;
end;

 (**
  * Gets a bookmark's last child.
  *
  * @return The last child of the Bookmark, or a nil if the Bookmark has no children.
  *)

function TgtPDBookmark.GetLastChild: TgtPDBookmark;
var
  LLastDict: TgtPDBaseObject;
  LBookmark: TgtPDBookmark;
  LIndex: Integer;
begin
  LIndex := -1;
  Result := nil;
  LBookmark := GetFirstChild;
  while LBookmark <> nil do
  begin
    LIndex := LBookmark.BookmarkIndex;
    LBookmark := LBookmark.Next;
  end;
  if LIndex >= 0 then
    Result := FBookmarkList.Items[LIndex];
end;

 (**
  * Gets a bookmark's next (right) sibling.
  *
  * @return The aBookmark object's next (right) sibling. It returns a nil if the
  *         Bookmark has no next sibling (that is, it is its parent's last child).
  *)

function TgtPDBookmark.GetNext: TgtPDBookmark;
var
  LNextDict: TgtPDBaseObject;
  LNext: TgtPDBookmark;
  LList: TgtBookmarkList;
begin
  Result := nil;
  LList := nil;
  if Assigned(Self.Parent) then
    LList := Self.Parent.FBookmarkList;
  if not Assigned(LList) then Exit;

  if LList.Count > Self.BookmarkIndex + 1 then
  begin
    Result := LList.Items[Self.BookmarkIndex + 1]
  end
  else if (FParentElement is TgtPDBookmark) then
  begin
    LNextDict := TgtPDDictionary(FBaseObject).LookUp(PDF_NEXT);
    if Assigned(LNextDict) then
    begin
      LNext := TgtPDBookmark.Create(FParentDoc, FParentElement, LNextDict);
      LNext.BookmarkIndex := Self.BookmarkIndex + 1;
      LNext.Level := Self.Level;
      LList.Add(LNext);
      Result := LNext;
    end;
  end;
end;

 (**
  * Gets a bookmark's parent bookmark.
  *
  * @return The parent bookmark of aBookmark, or a nil if the Bookmark is the
  *         root of its tree.
  *)

function TgtPDBookmark.GetParent: TgtPDBookmark;
begin
  if not Assigned(FParent) then
  begin
    if (Assigned(FParentElement) and (FParentElement is TgtPDBookmark)) then
      FParent := TgtPDBookmark(FParentElement);
  end;
  Result := FParent;
end;

 (**
  * Returns a bookmark's previous (left) sibling.
  *
  * @return Previous (left) sibling of aBookmark, or nil if the Bookmark has no
  *         previous sibling (it is its parent's first child).
  *)

function TgtPDBookmark.GetPrev: TgtPDBookmark;
var
  LPrevDict: TgtPDBaseObject;
  LList: TgtBookmarkList;
  LPrev: TgtPDBookmark;
begin
  Result := nil;
  LList := nil;
  if Assigned(Self.Parent) then
    LList := Self.Parent.FBookmarkList;

  if not Assigned(LList) then Exit;
  
  if (LList.Count > Self.BookmarkIndex) and (Self.BookmarkIndex > 0) then
  begin
    Result := LList.Items[Self.BookmarkIndex - 1];
  end
  else if (FParentElement is TgtPDBookmark) and (Self.BookmarkIndex > 0) then
  begin
    LPrevDict := TgtPDDictionary(FBaseObject).LookUp(PDF_PREV);
    if Assigned(LPrevDict) then
    begin
      LPrev := TgtPDBookmark.Create(FParentDoc, FParentElement, LPrevDict);
      LPrev.BookmarkIndex := Self.BookmarkIndex - 1;
      LPrev.Level := Self.Level;
      LList.Add(LPrev);
      Result := LPrev;
    end;
  end;
end;

 (**
  * Gets a bookmark's title.
  *
  * @return The AnsiString containing the bookmark's title
  *)

function TgtPDBookmark.GetTitle: AnsiString;
var
  LTitleObj: TgtPDBaseObject;
  LTitle: AnsiString;
  LI: Integer;
begin
  if FTitle = '' then
  begin
    LTitleObj := TgtPDDictionary(FBaseObject).LookUp(PDF_TITLE);
    if Assigned(LTitleObj) then
      if LTitleObj.IsString then
        LTitle := TgtPDString(LTitleObj).HexToString;
    for LI := 1 to Length(LTitle) do
    begin
      if not (Ord(LTitle[LI]) in [0, 254, 255]) then
        FTitle := FTitle + LTitle[LI];
    end;
  end;

  Result := FTitle;
end;

 (**
  * Tests whether a bookmark has children.
  *
  * @return True if the Bookmark has any children, false otherwise.
  *)

function TgtPDBookmark.HasChildren: Boolean;
var
  LObj: TgtPDBookmark;
begin
  LObj := GetFirstChild;
  Result :=  Assigned(LObj);
end;

function TgtPDBookmark.InsertNewChild(const Title: AnsiString;
  var ADestination: TgtPDDestination; var AOutlineFlag: TgtPDOutlineFlag;
  Action: TgtPDAction): TgtPDBookmark;
var
  LObj, LIndRef, LArray: TgtPDBaseObject;
  LBookmarkDict: TgtPDDictionary;
  LLastChild: TgtPDBookmark;
  LFontFlag: Integer;
begin
  LFontFlag := 0;
  //Create a BookmarkDict with new object number
  TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber :=
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber + 1;
  LBookmarkDict := TgtPDDictionary.Create(
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber, 0,
    TgtPDDocument(FParentDoc).BaseDoc);
  TgtPDDocument(FParentDoc).BaseDoc.AddToCollection(LBookmarkDict);

  //Update Parent of new Child
  LIndRef := TgtPDIndirectRef.Create(FBaseObject.ObjNumber, FBaseObject.GenNumber);
  LBookmarkDict.Add(PDF_PARENT, LIndRef);

  //Update Title of new Child
  LObj := TgtPDString.Create(Title, False);
  LBookmarkDict.Add(PDF_TITLE, LObj);

  LLastChild := LastChild;
  if Assigned(LLastChild) then
  begin
    //Update Prev and Next entry new Child
    LIndRef := TgtPDIndirectRef.Create(LLastChild.BaseObject.ObjNumber,
      LLastChild.BaseObject.GenNumber);
    LBookmarkDict.Add(PDF_PREV, LIndRef);
//    LBookmarkDict.Add(PDF_NEXT, TgtPDNull.Create);

    //Update Next entry of current Last node
    LIndRef := TgtPDIndirectRef.Create(LBookmarkDict.ObjNumber, LBookmarkDict.GenNumber);
    TgtPDDictionary(LLastChild.BaseObject).SetKeyValue(PDF_NEXT, LIndRef);
  end;
  //Update Last child node with the new Child node
  LIndRef := TgtPDIndirectRef.Create(LBookmarkDict.ObjNumber, LBookmarkDict.GenNumber);
  TgtPDDictionary(FBaseObject).SetKeyValue(PDF_LAST, LIndRef);
  // if no child, first and last entry are same
  if not HasChildren then
    TgtPDDictionary(FBaseObject).SetKeyValue(PDF_FIRST, LIndRef.Clone);

  //SetColor
  LArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
  TgtPDArray(LArray).Add(TgtPDReal.Create(FColor.Value[0]));
  TgtPDArray(LArray).Add(TgtPDReal.Create(FColor.Value[1]));
  TgtPDArray(LArray).Add(TgtPDReal.Create(FColor.Value[2]));
  LBookmarkDict.Add(PDF_C, LArray);

  //SetFontStyle
  if AOutlineFlag.Bold then
    LFontFlag := LFontFlag or (1 shl 1);
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
    AddAction(Action, LBookmarkDict);
  end;

  //Create Bookmark object and add it to Bookmoark List
  Result := TgtPDBookmark.Create(FParentDoc, Self, LBookmarkDict);
  if Assigned(LLastChild) then
    Result.BookmarkIndex := LLastChild.BookmarkIndex + 1
  else
    Result.BookmarkIndex := 0;
  FBookmarkList.Add(Result);
end;
{------------------------------------------------------------------------------}

function TgtPDBookmark.InsertNewNext(const Title: AnsiString;
  var ADestination: TgtPDDestination; var AOutlineFlag: TgtPDOutlineFlag;
  Action: TgtPDAction): TgtPDBookmark;
var
  LBookmarkDict: TgtPDDictionary;
  LIndRef, LObj, LArray: TgtPDBaseObject;
  LNext: TgtPDBookmark;
  LFontFlag, I: Integer;
  LBookMarkList: TgtBookmarkList;
begin
  Result := nil;
  if not Assigned(Self.Parent) then
  begin
    Exit;
  end;
  LFontFlag := 0;
  //Create a BookmarkDict with new object number
  TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber :=
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber + 1;
  LBookmarkDict := TgtPDDictionary.Create(
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber, 0,
    TgtPDDocument(FParentDoc).BaseDoc);
  TgtPDDocument(FParentDoc).BaseDoc.AddToCollection(LBookmarkDict);

  //Update Parent of new Next
  LIndRef := TgtPDIndirectRef.Create(Self.Parent.BaseObject.ObjNumber,
    Self.Parent.BaseObject.GenNumber);
  LBookmarkDict.Add(PDF_PARENT, LIndRef);

  //Update Title of new Next
  LObj := TgtPDString.Create(Title, False);
  LBookmarkDict.Add(PDF_TITLE, LObj);

  LNext := Next;
  if Assigned(LNext) then
  begin
    //set current Next node's Prev to New Prev(New Node)
    LIndRef := TgtPDIndirectRef.Create(LBookmarkDict.ObjNumber, LBookmarkDict.GenNumber);
    TgtPDDictionary(LNext.BaseObject).SetKeyValue(PDF_PREV, LIndRef);

    //Set New Next's Next node to current Next
    LIndRef := TgtPDIndirectRef.Create(LNext.BaseObject.ObjNumber, LNext.BaseObject.GenNumber);
    TgtPDDictionary(LBookmarkDict).SetKeyValue(PDF_NEXT, LIndRef);
  end
  // The current bookmark is the last child of its parent
  else
  begin
    LIndRef := TgtPDIndirectRef.Create(LBookmarkDict.ObjNumber,
      LBookmarkDict.GenNumber);
    TgtPDDictionary(Self.Parent.BaseObject).SetKeyValue(PDF_LAST, LIndRef);
  end;

  //Set New Next's Prev node to Current object
  LIndRef := TgtPDIndirectRef.Create(FBaseObject.ObjNumber, FBaseObject.GenNumber);
  TgtPDDictionary(LBookmarkDict).SetKeyValue(PDF_PREV, LIndRef);

  //Set Current nodes Next to New Next
  LIndRef := TgtPDIndirectRef.Create(LBookmarkDict.ObjNumber, LBookmarkDict.GenNumber);
  TgtPDDictionary(FBaseObject).SetKeyValue(PDF_NEXT, LIndRef);

  //SetColor
  LArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
  TgtPDArray(LArray).Add(TgtPDReal.Create(FColor.Value[0]));
  TgtPDArray(LArray).Add(TgtPDReal.Create(FColor.Value[1]));
  TgtPDArray(LArray).Add(TgtPDReal.Create(FColor.Value[2]));
  LBookmarkDict.Add(PDF_C, LArray);

  //SetFontStyle
  if AOutlineFlag.Bold then
    LFontFlag := LFontFlag or (1 shl 1);
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
    AddAction(Action, LBookmarkDict);
  end;

  Result := TgtPDBookmark.Create(FParentDoc, FParentElement, LBookmarkDict);
  Result.Level := Self.Level;
  Result.BookmarkIndex := Self.BookmarkIndex + 1;
  LBookMarkList := TgtPDBookmark(FParentElement).FBookmarkList;
  LBookMarkList.Insert(Self.BookmarkIndex + 1, Result);

  // Inseting a new node, so updating index of the below nodes
  for I := Self.BookmarkIndex + 2 to LBookMarkList.Count - 1 do
    LBookMarkList.Items[I].BookmarkIndex :=
       LBookMarkList.Items[I].BookmarkIndex + 1;
end;
{------------------------------------------------------------------------------}

function TgtPDBookmark.InsertNewPrev(const Title: AnsiString;
  var ADestination: TgtPDDestination; var AOutlineFlag: TgtPDOutlineFlag;
  Action: TgtPDAction): TgtPDBookmark;
var
  LBookmarkDict: TgtPDDictionary;
  LIndRef, LObj, LArray: TgtPDBaseObject;
  LPrev: TgtPDBookmark;
  LFontFlag, I: Integer;
  LBookmarkList: TgtBookmarkList;
begin
  Result := nil;
  if not Assigned(Self.Parent) then Exit; // Its BookmarkRoot

  LFontFlag := 0;
  //Create a BookmarkDict with new object number
  TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber :=
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber + 1;
  LBookmarkDict := TgtPDDictionary.Create(
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber, 0,
    TgtPDDocument(FParentDoc).BaseDoc);
  TgtPDDocument(FParentDoc).BaseDoc.AddToCollection(LBookmarkDict);

  //Update Parent of new Next
  LIndRef := TgtPDIndirectRef.Create(FBaseObject.ObjNumber, FBaseObject.GenNumber);
  LBookmarkDict.Add(PDF_PARENT, LIndRef);

  //Update Title of new Next
  LObj := TgtPDString.Create(Title, False);
  LBookmarkDict.Add(PDF_TITLE, LObj);

  LPrev := Prev;
  if Assigned(LPrev) then
  begin
    //Set current Prev's Next to New Prev
    LIndRef := TgtPDIndirectRef.Create(LBookmarkDict.ObjNumber, LBookmarkDict.GenNumber);
    TgtPDDictionary(LPrev.BaseObject).SetKeyValue(PDF_NEXT, LIndRef);

    //Set New Prev's Prev entry to Current Prev
    LIndRef := TgtPDIndirectRef.Create(LPrev.BaseObject.ObjNumber, LPrev.BaseObject.GenNumber);
    TgtPDDictionary(LBookmarkDict).SetKeyValue(PDF_PREV, LIndRef);
  end
  else
  begin
    // This will be the first child of its parent
    LIndRef := TgtPDIndirectRef.Create(LBookmarkDict.ObjNumber,
      LBookmarkDict.GenNumber);
    TgtPDDictionary(Self.Parent.BaseObject).SetKeyValue(PDF_FIRST,
      LIndRef);
  end;

  //Set New Prev's Next ebtry to Current node
  LIndRef := TgtPDIndirectRef.Create(FBaseObject.ObjNumber, FBaseObject.GenNumber);
  TgtPDDictionary(LBookmarkDict).SetKeyValue(PDF_NEXT, LIndRef);

  //Set Current node's Prev to New Prev
  LIndRef := TgtPDIndirectRef.Create(LBookmarkDict.ObjNumber, LBookmarkDict.GenNumber);
  TgtPDDictionary(FBaseObject).SetKeyValue(PDF_PREV, LIndRef);

  //SetColor
  LArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
  TgtPDArray(LArray).Add(TgtPDReal.Create(FColor.Value[0]));
  TgtPDArray(LArray).Add(TgtPDReal.Create(FColor.Value[1]));
  TgtPDArray(LArray).Add(TgtPDReal.Create(FColor.Value[2]));
  LBookmarkDict.Add(PDF_C, LArray);

  //SetFontStyle
  if AOutlineFlag.Bold then
    LFontFlag := LFontFlag or (1 shl 1);
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
    AddAction(Action, LBookmarkDict);
  end;

  Result := TgtPDBookmark.Create(FParentDoc, FParent, LBookmarkDict);
  Result.Level := Self.Level;
  if Self.BookmarkIndex = 0 then
    Result.BookmarkIndex := 0
  else
    Result.BookmarkIndex := Self.BookmarkIndex - 1;

  LBookmarkList := Self.Parent.FBookmarkList;

  if Assigned(LBookmarkList) then
  begin
    LBookmarkList.Insert(Self.BookmarkIndex, Result);
    for I := Self.BookmarkIndex + 1 to LBookmarkList.Count - 1 do
      LBookmarkList.Items[I].BookmarkIndex :=
        LBookmarkList.Items[I].BookmarkIndex + 1;
  end;
end;

function TgtPDBookmark.IsSame(ABookMark: TgtPDBookmark): Boolean;
begin
  Result := (Self.BaseObject.ObjNumber = ABookMark.BaseObject.ObjNumber) and
    (Self.BaseObject.GenNumber = ABookMark.BaseObject.GenNumber);  
end;

(**
  * Removes a bookmark's action.
  *
  * @exception EBadAction if the the action associated wi7th the bookmark is not
  *            valid
  *)

procedure TgtPDBookmark.RemoveAction;
var
  LObj: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_A);
    if Assigned(LObj) then
      TgtPDDictionary(FBaseObject).Remove(PDF_A);

    if not LObj.IsDict then
      raise ExBadAction.Create(ErrBadAction);
  end;
end;

 (**
  * Sets a bookmark's action.
  *
  * @param Action The bookmark's action.
  *)

(*
procedure TgtPDBookmark.SetAction(Action: TgtPDAction);
var
  LObj: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_A);
    if Assigned(LObj) then
      TgtPDDictionary(FBaseObject).SetKeyValue(PDF_A, Action.BaseObject)
    else
    begin
      TgtPDDictionary(FBaseObject).Add(PDF_A, Action.BaseObject);
    end;
  end;
  FAction := Action;
end;
*)

 (**
  * Sets the color of the specified bookmark.
  *
  * @param Color The new color.
  * @exception EInvalidColor if color is invalid
  * @exception EInvalidBookmark if the bookmark is invalid or if the existing
  *            bookmark color is malformed.
  *)

procedure TgtPDBookmark.SetAction(AAction: TgtPDAction);
var
  LObj: TgtPDBaseObject;
begin
  if Assigned(FAction) then
    FreeAndNil(FAction);
  FAction := AAction;

  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_A);
    if Assigned(LObj) then
      TgtPDDictionary(FBaseObject).Remove(PDF_A);
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_DEST);
    if Assigned(LObj) then
      TgtPDDictionary(FBaseObject).Remove(PDF_DEST);
    AddAction(AAction, TgtPDDictionary(FBaseObject));
  end;
end;

procedure TgtPDBookmark.SetColor(const Color: TgtPDColorValue);
var
  LColorObj: TgtPDBaseObject;
  LArray: TgtPDArray;
begin
  if Assigned(FBaseObject) then
  begin
    LColorObj := TgtPDDictionary(FBaseObject).LookUp(PDF_C);
    if Assigned(LColorObj) then
    begin
      TgtPDDictionary(FBaseObject).Remove(PDF_C);
    end;
    LArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
    LArray.Add(TgtPDReal.Create(Color.Value[0]));
    LArray.Add(TgtPDReal.Create(Color.Value[1]));
    LArray.Add(TgtPDReal.Create(Color.Value[2]));
    TgtPDDictionary(FBaseObject).Add(PDF_C, LArray);
  end;
  FColor := Color;
end;

procedure TgtPDBookmark.SetDestination(ADestination: TgtPDDestination);
var
  LDestObj, LIndRef, LObj: TgtPDBaseObject;
begin
  if Assigned(FDestination) then
    FreeAndnil(FDestination);
  if Assigned(FBaseObject) then
  begin
    LDestObj := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
    //Create and Add page ref
    LIndRef := TgtPDIndirectRef.Create(TgtPDPage(ADestination.Page).BaseObject.ObjNumber,
      TgtPDPage(ADestination.Page).BaseObject.GenNumber);
    TgtPDArray(LDestObj).Add(LIndRef);
    case ADestination.DisplayOptions of
      FitZoom:
        begin
          //Destination Display type
          TgtPDArray(LDestObj).Add(TgtPDName.Create(PDF_XYZ));
          //Left
          TgtPDArray(LDestObj).Add(TgtPDReal.Create(ADestination.Rect.Left));
          //Top
          TgtPDArray(LDestObj).Add(TgtPDReal.Create(ADestination.Rect.Top));
          //Zoom
          TgtPDArray(LDestObj).Add(TgtPDReal.Create(ADestination.Rect.Right));
        end;
      FitAll:
        begin
          //Destination Display type
          TgtPDArray(LDestObj).Add(TgtPDName.Create(PDF_FIT));
        end;
      FitHeight:
        begin
          //Destination Display type
          TgtPDArray(LDestObj).Add(TgtPDName.Create(PDF_FITH));
          //Top
          TgtPDArray(LDestObj).Add(TgtPDReal.Create(ADestination.Rect.Top));
        end;
      FitWidth:
        begin
          //Destination Display type
          TgtPDArray(LDestObj).Add(TgtPDName.Create(PDF_FITV));
          //Left
          TgtPDArray(LDestObj).Add(TgtPDReal.Create(ADestination.Rect.Left));
        end;
      FitRect:
        begin
          //Destination Display type
          TgtPDArray(LDestObj).Add(TgtPDName.Create(PDF_FITR));
          //Left
          TgtPDArray(LDestObj).Add(TgtPDReal.Create(ADestination.Rect.Left));
          //Top
          TgtPDArray(LDestObj).Add(TgtPDReal.Create(ADestination.Rect.Top));
          //Right
          TgtPDArray(LDestObj).Add(TgtPDReal.Create(ADestination.Rect.Right));
          //Bottom
          TgtPDArray(LDestObj).Add(TgtPDReal.Create(ADestination.Rect.Bottom));
        end;
      FitBoundingBox:
        begin
          //Destination Display type
          TgtPDArray(LDestObj).Add(TgtPDName.Create(PDF_FITB));
        end;
      FitBoundingBoxHeight:
        begin
          //Destination Display type
          TgtPDArray(LDestObj).Add(TgtPDName.Create(PDF_FITBH));
          //Top
          TgtPDArray(LDestObj).Add(TgtPDReal.Create(ADestination.Rect.Top));
        end;
      FitBoundingBoxWidth:
        begin
          //Destination Display type
          TgtPDArray(LDestObj).Add(TgtPDName.Create(PDF_FITBV));
          //Left
          TgtPDArray(LDestObj).Add(TgtPDReal.Create(ADestination.Rect.Left));
        end;
    end;
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_A);
    if Assigned(LObj)then
      TgtPDDictionary(FBaseObject).Remove(PDF_A);
    TgtPDDictionary(FBaseObject).SetKeyValue(PDF_DEST, LDestObj);
  end;
  FDestination := ADestination;
end;

(**
  * Sets the flags of the specified bookmark.
  *
  * @param Flags The new bookmark flags.
  * @exception EInvalidBookmark if the bookmark is invalid or the existing style
  *            is malformed in the PDF file.
  *)

procedure TgtPDBookmark.SetFlags(const AFlags: TgtPDOutlineFlag);
var
  LObj: TgtPDBaseObject;
  LFlag: Integer;
begin
  LFlag := 0;
  if Assigned(FBaseObject) then
  begin
    if AFlags.Italic then
      LFlag := (LFlag or 1);
    if AFlags.Bold then
      LFlag := (LFlag or (1 shl 1));

    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_F);
    if Assigned(LObj) then
      TgtPDInteger(LObj).Value := LFlag
    else
    begin
      LObj := TgtPDInteger.Create(LFlag);
      TgtPDDictionary(FBaseObject).Add(PDF_F, LObj);
    end;
  end;
  FOutlineFlags := AFlags;
end;

 (**
  * Sets a bookmark's title.
  *
  * @param Title A read-only AnsiString containing the bookmark's new title. The
  *        text must be encoded using PDFDocEncoding.
  * @exception EBookmarksError if there is an error setting the title.
  *)

procedure TgtPDBookmark.SetTitle(const Title: AnsiString);
var
  LObj: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_TITLE);
    if Assigned(LObj) then
      TgtPDString(LObj).Value := Title
    else
    begin
      LObj := TgtPDString.Create(Title);
      TgtPDDictionary(FBaseObject).Add(PDF_TITLE, LObj);
    end;
  end;
  FTitle := Title;
end;

function TgtPDBookmark.TraverseDepthFirst(ABookmark: TgtPDBookmark;
  const ATitle: Ansistring; ADepth: TgtOutlineTraversalDepth): TgtPDBookmark;
var
  LBkmrk: TgtPDBookmark;
  LDepth: Integer;
begin
  Result := nil;
  if Assigned(ABookmark) then
  begin
    if AnsiStriComp(PAnsichar(ABookmark.Title), PAnsichar(ATitle)) = 0 then
    begin
      FTitleFound := True;
      Result := ABookmark;
    end
    else
    begin
      LDepth := Self.Level + 1;
      case ADepth of
        otdSiblingsOnly:
        begin
          Result := TraverseDepthFirst(ABookmark.Next, ATitle, ADepth);
        end;
        otdChildrenOnly:
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
        otdFullSubtree:
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

function TgtPDBookmark.TraverseNGetBookMark(ABookmark: TgtPDBookmark;
  ATitle: AnsiString; ADepth: Integer): TgtPDBookmark;
var
  LNextBookmark: TgtPDBookmark;
begin
  if not (ABookmark.Level > ADepth) then
  begin
    if ABookmark.Title = ATitle then
    begin
      Result := ABookmark;
      Exit;
    end
    else
    begin
      LNextBookmark := ABookmark.GetNext;
      Result := TraverseNGetBookMark(LNextBookmark, ATitle, ADepth);
      Exit;
    end;
  end;
  Result := nil;
end;

(**
  * Unlinks a bookmark from the bookmark tree that contains it, and adjusts the
  * tree appropriately.
  *)

procedure TgtPDBookmark.UnLink;
var
  LObj: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    // Unlinking the NEXT node of Current node to NULL
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_NEXT);
    if Assigned(LObj) then
    begin
      LObj := TgtPDNull.Create;
      TgtPDDictionary(FBaseObject).SetKeyValue(PDF_NEXT, LObj);
    end;

    // Unlinking the PREV node of Current node to NULL
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_PREV);
    if Assigned(LObj) then
    begin
      LObj := TgtPDNull.Create;
      TgtPDDictionary(FBaseObject).SetKeyValue(PDF_PREV, LObj);
    end;
  end;
  FNext := nil;
  FPrev := nil;
end;

procedure TgtPDBookmark.Update;
begin
  inherited;

end;

{ TgtBookmarkList }

function TgtBookmarkList.Get(Index: Integer): TgtPDBookmark;
begin
  Result := TgtPDBookmark(inherited Get(Index));
end;

procedure TgtBookmarkList.Notify(Ptr: Pointer; Action: TListNotification);
begin
  if Action in [lnExtracted, lnDeleted] then
    if Assigned(Ptr) then
      TgtPDBookmark(Ptr).Free;
end;

end.
