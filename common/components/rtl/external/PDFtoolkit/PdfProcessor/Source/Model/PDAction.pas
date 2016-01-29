{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Model                   }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

{$I ..\Utils\gtCompilerDefines.inc}

unit PDAction;

interface

uses
  Contnrs, gtObject, PDElement, PDBaseObject, PDTypes, PDFileSpec, PDRect,
  PDDestination;

type

  //This Enumaration defines all types of Action in PDF
  TgtPDActionType = (actionNone, actionGoTo, actionGoToR, actionGoToE, actionLaunch,
    actionThread, actionURI, actionSound, actionMovie, actionHide,
    actionNamed, actionSubmitForm, actionResetForm, actionImportData,
    actionJavaScript, actionSetOCGState, actionRendition, actionTrans,
    actionGoTo3DView);

  TgtPDActionList = TObjectList;

 (**
  * This is the superclass for all actions in PDF
  *
  *)

  TgtPDAction = class(TgtPDElement)
  private
    FActionType: TgtPDActionType;
    FDestDoc: TgtObject;

    //All related actions of this Action dictionary
    FNextActions: TgtPDActionList;

    //Function that Adds the related Action
    function GetActionFromNext(AObject: TgtPDBaseObject): TgtPDAction;
    function GetDest: TgtPDDestination;
    function GetType: TgtPDActionType;

//    procedure SetDest(Value: TgtPDDestination);
    procedure SetActionType(Value: TgtPDActionType);
  protected
    FViewDestination: TgtPDDestination;
    FFileSpec: TgtPDFileSpec;


    constructor Create(AParentDoc: TgtObject; AParentElement: TgtPDElement;
      ABaseObject: TgtPDBaseObject); overload;
    constructor Create(AParentDoc: TgtObject; AParentElement: TgtPDElement;
      ActionType: TgtPDActionType); overload;
    constructor Create(AParentDoc: TgtObject; AParentElement: TgtPDElement;
      Dest: TgtPDDestination; DestDoc: TgtObject); overload;
    constructor Create(AParentDoc: TgtObject; AParentElement: TgtPDElement;
      ActionType: TgtPDActionType; FileSpec: TgtPDFileSpec); overload;
    function GetFileSpec: TgtPDFileSpec;

    property Destination: TgtPDDestination read GetDest;

    function GetAllActions: TgtPDActionList;
  public
    class function MakeAction(AParentDoc: TgtObject; AParentElement: TgtPDElement;
      ABaseObject: TgtPDBaseObject): TgtPDAction; overload;
    class function MakeAction(AParentDoc: TgtObject; AParentElement: TgtPDElement;
      AActionType: TgtPDActionType): TgtPDAction; overload;
    destructor Destroy; override;

    procedure Update; override;
    property ActionType: TgtPDActionType read GetType write SetActionType;
  end;

implementation

uses
{$IFDEF DEBUG}
  gtLogger,
{$ENDIF}
  gtMethods, gtConstants, PDModelException, PDDictionary, PDName, PDArray,
  PDInteger, PDDocument, PDGoToAction, PDGoToRemoteAction, PDGoToEmbeddedAction,
  PDLaunchAction, PDThreadAction, PDURIAction, PDSoundAction, PDMovieAction,
  PDHideAction, PDNamedAction, PDRenditionAction, PDTransitionAction,
  PDGoTo3DViewAction, PDSubmitFormAction, PDResetFormAction, PDJavaScriptAction,
  PDReal;

{ TgtPDAction }


  (**
   *  Constructor
   *
   *  @param AParentDoc is the parent document for this action
   *  @param AParentElement is the parent element from which this object was called
   *  @param ABaseObject is the Current PDF object
   *
   *)

constructor TgtPDAction.Create(AParentDoc: TgtObject;
  AParentElement: TgtPDElement; ABaseObject: TgtPDBaseObject);
begin
  FParentDoc := AParentDoc;
  FParentElement := AParentElement;
  FBaseObject := ABaseObject;
end;

  (**
   *  Constructor
   *
   *  @param AParentDoc is the parent document for this action
   *  @param AParentElement is the parent element from which this object was called
   *  @param ActionType is the Action object with which this object need to be created
   *
   *)

constructor TgtPDAction.Create(AParentDoc: TgtObject;
  AParentElement: TgtPDElement; ActionType: TgtPDActionType);
begin
  FParentDoc := AParentDoc;
  FParentElement := AParentElement;
  FActionType := ActionType;
end;

  (**
   *  Constructor
   *
   *  @param AParentDoc is the parent document for this action
   *  @param AParentElement is the parent element from which this object was called
   *  @param Dest is the View destination object
   *  @param DestDoc is the destination document for which this object is created
   *
   *)

constructor TgtPDAction.Create(AParentDoc: TgtObject;
  AParentElement: TgtPDElement; Dest: TgtPDDestination; DestDoc: TgtObject);
begin
  FParentDoc := AParentDoc;
  FParentElement := AParentElement;
  FViewDestination := Dest;
  FDestDoc := DestDoc;
end;

  (**
   *  Constructor
   *
   *  @param AParentDoc is the parent document for this action
   *  @param AParentElement is the parent element from which this object was called
   *  @param ActionType is the Action object with which this object need to be created
   *  @param FileSpec is the standard format for representing a simple file
   *                  specification in AnsiString form divides the AnsiString into
   *                  component substrings separated by the slash character (/).
   *
   *)

constructor TgtPDAction.Create(AParentDoc: TgtObject;
  AParentElement: TgtPDElement; ActionType: TgtPDActionType;
  FileSpec: TgtPDFileSpec);
begin
  FParentDoc := AParentDoc;
  FParentElement := AParentElement;
  FActionType := ActionType;
  FFileSpec := FileSpec;
end;

  (**
   *  Destructor
   *)

destructor TgtPDAction.Destroy;
begin
  if Assigned(FNextActions) then
    FreeObject(FNextActions);
  if Assigned(FFileSpec) then FFileSpec.Free;
  if Assigned(FViewDestination) then FViewDestination.Free;
  inherited;
end;

  (**
   *    This function is a recursive function that adds all the action objects to
   *  a list
   *
   *  @param AObject Next object where Action object is expected
   *
   *  @return TgtPDAction is the action object that is found in this dictionatiory
   *)

function TgtPDAction.GetActionFromNext(AObject: TgtPDBaseObject): TgtPDAction;
var
  LObj: TgtPDBaseObject;
  LActionObj: TgtPDAction;
  LI: Integer;
begin
  Result := nil;
  if AObject.IsDict then
  begin
    LActionObj := TgtPDAction.Create(TgtPDDocument(FParentDoc).BaseDoc, Self, AObject);
    Result := LActionObj;
    FNextActions.Add(LActionObj);
    Exit;
  end
  else if AObject.IsArray then
  begin
    for LI := 0 to TgtPDArray(AObject).GetLength - 1 do
    begin
      LObj := TgtPDArray(AObject).Get(LI);
      LActionObj := GetActionFromNext(LObj);
      FNextActions.Add(LActionObj);
    end;
  end;
end;

  (**
   *    This function gets all the actions of an object and store in a List
   *
   *  @return TgtPDActionList is the list of action object that is found in
   *          this dictionatiory
   *)

function TgtPDAction.GetAllActions: TgtPDActionList;
var
  LNextActionObj: TgtPDBaseObject;
begin
  if not Assigned(FNextActions) then
  begin
    LNextActionObj := TgtPDDictionary(FBaseObject).LookUp(PDF_NEXT);
    if Assigned(LNextActionObj) then
    begin
      FNextActions := TgtPDActionList.Create(True);
      GetActionFromNext(LNextActionObj);
    end;
  end;
  Result := FNextActions;
end;

 (**
  * Gets an action's destination details.
  *
  * @return The TgtPDViewDestination of that action.
  *)

function TgtPDAction.GetDest: TgtPDDestination;
var
  LDestObj, LObj: TgtPDBaseObject;
  LI: Integer;
  LViewType: AnsiString;
begin
  if Assigned(FBaseObject) then
  begin
    LI := 0;
    LDestObj := TgtPDDictionary(FBaseObject).LookUp(PDF_D);

    if Assigned(LDestObj) then
    begin
      if LDestObj.IsArray then
      begin
        LObj := TgtPDArray(LDestObj).GetRefObj(LI);
        if not Assigned(FViewDestination) then
          FViewDestination := TgtPDDestination.Create;
        FViewDestination.Page := TgtPDDocument(FParentDoc).GetPageByIndRef(LObj);
        Inc(LI);

        LObj := TgtPDArray(LDestObj).Get(LI);
        LViewType := TgtPDName(LObj).Value;

        if LViewType = 'XYZ' then
        begin
          Inc(LI);
          FViewDestination.DisplayOptions := FitZoom;

          LObj := TgtPDArray(LDestObj).Get(LI); //Left
          if Assigned(LObj) and (not LObj.IsNull) then
          begin
            if LObj.IsInteger then
              FViewDestination.Rect.Left := TgtPDInteger(LObj).Value
            else
              FViewDestination.Rect.Left := TgtPDReal(LObj).Value;
          end
          else
            FViewDestination.Rect.Left := 0;

          Inc(LI);
          LObj := TgtPDArray(LDestObj).Get(LI); //Top
          if Assigned(LObj) and (not LObj.IsNull) then
          begin
            if LObj.IsInteger then
              FViewDestination.Rect.Top := TgtPDInteger(LObj).Value
            else
              FViewDestination.Rect.Top := TgtPDReal(LObj).Value;
          end
          else
            FViewDestination.Rect.Top := 0;

          Inc(LI);
          LObj := TgtPDArray(LDestObj).Get(LI); //Zoom
          if Assigned(LObj) and (not LObj.IsNull) then
          begin
            if LObj.IsInteger then
              FViewDestination.Rect.Right := TgtPDInteger(LObj).Value
            else
              FViewDestination.Rect.Right := TgtPDReal(LObj).Value;
          end
          else
            FViewDestination.Rect.Right := 0;
          FViewDestination.Rect.Bottom := 0; // not needed for /XYZ
        end
        else if LViewType = 'Fit' then
        begin
          FViewDestination.DisplayOptions := FitAll;

          //No diamentions will be mentioned for fit all
          FViewDestination.Rect.Left := 0;
          FViewDestination.Rect.Top := 0;
          FViewDestination.Rect.Right := 0;
          FViewDestination.Rect.Bottom := 0;
        end
        else if LViewType = 'FitH' then
        begin
          Inc(LI);
          FViewDestination.DisplayOptions := FitHeight;

          LObj := TgtPDArray(LDestObj).Get(LI);  //Top
          if Assigned(LObj) and (not LObj.IsNull) then
          begin
            if LObj.IsInteger then
              FViewDestination.Rect.Top := TgtPDInteger(LObj).Value
            else
              FViewDestination.Rect.Top := TgtPDReal(LObj).Value;
          end
          else
            FViewDestination.Rect.Top := 0;

          FViewDestination.Rect.Left := 0;
          FViewDestination.Rect.Right := 0;
          FViewDestination.Rect.Bottom := 0;
        end
        else if LViewType = 'FitV' then
        begin
          Inc(LI);
          FViewDestination.DisplayOptions := FitWidth;

          LObj := TgtPDArray(LDestObj).Get(LI); //Left
          if Assigned(LObj) and (not LObj.IsNull) then
          begin
            if LObj.IsInteger then
              FViewDestination.Rect.Left := TgtPDInteger(LObj).Value
            else
              FViewDestination.Rect.Left := TgtPDReal(LObj).Value;
          end
          else
            FViewDestination.Rect.Left := 0;

          FViewDestination.Rect.Top := 0;
          FViewDestination.Rect.Right := 0;
          FViewDestination.Rect.Bottom := 0;
        end
        else if LViewType = 'FitR' then
        begin
          Inc(LI);
          FViewDestination.DisplayOptions := FitRect;

          LObj := TgtPDArray(LDestObj).Get(LI); //Left
          if Assigned(LObj) and (not LObj.IsNull) then
          begin
            if LObj.IsInteger then
              FViewDestination.Rect.Left := TgtPDInteger(LObj).Value
            else
              FViewDestination.Rect.Left := TgtPDReal(LObj).Value;
          end
          else
            FViewDestination.Rect.Left := 0;

          Inc(LI);
          LObj := TgtPDArray(LDestObj).Get(LI); //bottom
          if Assigned(LObj) and (not LObj.IsNull) then
          begin
            if LObj.IsInteger then
              FViewDestination.Rect.Bottom := TgtPDInteger(LObj).Value
            else
              FViewDestination.Rect.Bottom := TgtPDReal(LObj).Value;
          end
          else
            FViewDestination.Rect.Bottom := 0;

          Inc(LI);
          LObj := TgtPDArray(LDestObj).Get(LI); //Right
          if Assigned(LObj) and (not LObj.IsNull) then
          begin
            if LObj.IsInteger then
              FViewDestination.Rect.Right := TgtPDInteger(LObj).Value
            else
              FViewDestination.Rect.Right := TgtPDReal(LObj).Value;
          end
          else
          begin
            FViewDestination.Rect.Right := 0
          end;

          Inc(LI);
          LObj := TgtPDArray(LDestObj).Get(LI); //Top
          if Assigned(LObj) and (not LObj.IsNull) then
          begin
            if LObj.IsInteger then
              FViewDestination.Rect.Top := TgtPDInteger(LObj).Value
            else
              FViewDestination.Rect.Top := TgtPDReal(LObj).Value;
          end
          else
            FViewDestination.Rect.Top := 0;
        end
        else if LViewType = 'FitB' then
        begin
          FViewDestination.DisplayOptions := FitBoundingBox;

          //No diamentions will be mentioned for fit bounding box
          FViewDestination.Rect.Left := 0;
          FViewDestination.Rect.Top := 0;
          FViewDestination.Rect.Right := 0;
          FViewDestination.Rect.Bottom := 0;
        end
        else if LViewType = 'FitBH' then
        begin
          Inc(LI);
          FViewDestination.DisplayOptions := FitBoundingBoxHeight;

          LObj := TgtPDArray(LDestObj).Get(LI); // Top
          if Assigned(LObj) and (not LObj.IsNull) then
          begin
            if LObj.IsInteger then
              FViewDestination.Rect.Top := TgtPDInteger(LObj).Value
            else
              FViewDestination.Rect.Top := TgtPDReal(LObj).Value;
          end
          else
            FViewDestination.Rect.Top := 0;

          FViewDestination.Rect.Left := 0;
          FViewDestination.Rect.Right := 0;
          FViewDestination.Rect.Bottom := 0;
        end
        else if LViewType = 'FitBV' then
        begin
          Inc(LI);
          FViewDestination.DisplayOptions := FitBoundingBoxWidth;

          LObj := TgtPDArray(LDestObj).Get(LI); //Left
          if Assigned(LObj) and (not LObj.IsNull) then
          begin
            if LObj.IsInteger then
              FViewDestination.Rect.Left := TgtPDInteger(LObj).Value
            else
              FViewDestination.Rect.Left := TgtPDReal(LObj).Value;
          end
          else
            FViewDestination.Rect.Left := 0;

          FViewDestination.Rect.Top := 0;
          FViewDestination.Rect.Right := 0;
          FViewDestination.Rect.Bottom := 0;
        end;
      end
      else if LDestObj.IsName then
      begin
        LViewType := TgtPDName(LDestObj).Value;
        if LViewType = 'XYZ' then
          FViewDestination.DisplayOptions := FitZoom
        else if LViewType = 'Fit' then
          FViewDestination.DisplayOptions := FitAll
        else if LViewType = 'FitH' then
          FViewDestination.DisplayOptions := FitHeight
        else if LViewType = 'FitV' then
          FViewDestination.DisplayOptions := FitWidth
        else if LViewType = 'FitR' then
          FViewDestination.DisplayOptions := FitRect
        else if LViewType = 'FitB' then
          FViewDestination.DisplayOptions := FitBoundingBox
        else if LViewType = 'FitBH' then
          FViewDestination.DisplayOptions := FitBoundingBoxHeight
        else if LViewType = 'FitBV' then
          FViewDestination.DisplayOptions := FitBoundingBoxWidth;

        FViewDestination.Page := nil;
        FViewDestination.Rect.Left := 0;
        FViewDestination.Rect.Top := 0;
        FViewDestination.Rect.Right := 0;
        FViewDestination.Rect.Bottom := 0;
      end;
    end;
  end;
  Result := FViewDestination;
end;

  (**
   *    Gets the File Specification information if this action's target is
   *  another
   *
   *  @return TgtPDFileSpec File Specification information if this action's target
   *)

function TgtPDAction.GetFileSpec: TgtPDFileSpec;
begin
  Result := nil;
end;

 (**
  * Gets an action's type.
  *
  * @return The type of that action.
  *
  * @exception ExBadAction if the annotation does not have a S key or
  * its value is not a name object.
  *)

function TgtPDAction.GetType: TgtPDActionType;
var
  LActionObj: TgtPDBaseObject;
  LActionType: AnsiString;
begin
  if FActionType = actionNone then
  begin
    if Assigned(FBaseObject) then
    begin
      LActionObj := TgtPDDictionary(FBaseObject).LookUp(PDF_S);
      if Assigned(LActionObj) then
      begin
        if LActionObj.IsName then
        begin
          LActionType := TgtPDName(LActionObj).Value;

          if LActionType = PDF_GOTO then
            FActionType := actionGoTo
          else if LActionType = PDF_GOTOR then
            FActionType := actionGoToR
          else if LActionType = PDF_GOTOE then
            FActionType := actionGoToE
          else if LActionType = PDF_LAUNCH then
            FActionType := actionLaunch
          else if LActionType = PDF_THREAD then
            FActionType := actionThread
          else if LActionType = PDF_URI then
            FActionType := actionURI
          else if LActionType = PDF_SOUNDACTION then
            FActionType := actionSound
          else if LActionType = PDF_MOVIEACTION then
            FActionType := actionMovie
          else if LActionType = PDF_HIDE then
            FActionType := actionHide
          else if LActionType = PDF_NAMED then
            FActionType := actionNamed
          else if LActionType = PDF_SUBMITFORM then
            FActionType := actionSubmitForm
          else if LActionType = PDF_RESETFORM then
            FActionType := actionResetForm
          else if LActionType = PDF_IMPORTDATA then
            FActionType := actionImportData
          else if LActionType = PDF_JAVASCRIPT then
            FActionType := actionJavaScript
          else if LActionType = PDF_SETOCGSTATE then
            FActionType := actionSetOCGState
          else if LActionType = PDF_RENDITION then
            FActionType := actionRendition
          else if LActionType = PDF_TRANSACTION then
            FActionType := actionTrans
          else if LActionType = PDF_GOTO3DVIEW then
            FActionType := actionGoTo3DView;

          Result := FActionType;
          Exit;
        end
        else
        begin
          raise ExBadAction.Create(ErrBadAction);
{$IFDEF DEBUG}
          Logger.LogError('Action  or Name Object expected');
{$ENDIF}
        end;
      end;
    end;
  end;
  Result := FActionType;
end;

class function TgtPDAction.MakeAction(AParentDoc: TgtObject;
  AParentElement: TgtPDElement; AActionType: TgtPDActionType): TgtPDAction;
begin
  Result := nil;
end;

class function TgtPDAction.MakeAction(AParentDoc: TgtObject;
  AParentElement: TgtPDElement; ABaseObject: TgtPDBaseObject): TgtPDAction;
var
  LActionObj: TgtPDBaseObject;
  LActionType: AnsiString;
begin
  LActionObj := TgtPDDictionary(ABaseObject).LookUp(PDF_S);
  if Assigned(LActionObj) then
    LActionType := TgtPDName(LActionObj).Value;


  if LActionType = PDF_GOTO then
    Result := TgtPDGoToAction.Create(AParentDoc, AParentElement, ABaseObject)
  else if LActionType = PDF_GOTOR then
    Result := TgtPDGoToRemoteAction.Create(AParentDoc, AParentElement, ABaseObject)
  else if LActionType = PDF_GOTOE then
    Result := TgtPDGoToEmbeddedAction.Create(AParentDoc, AParentElement, ABaseObject)
  else if LActionType = PDF_LAUNCH then
    Result := TgtPDLaunchAction.Create(AParentDoc, AParentElement, ABaseObject)
  else if LActionType = PDF_THREAD then
    Result := TgtPDThreadAction.Create(AParentDoc, AParentElement, ABaseObject)
  else if LActionType = PDF_URI then
    Result := TgtPDURIAction.Create(AParentDoc, AParentElement, ABaseObject)
  else if LActionType = PDF_SOUNDACTION then
    Result := TgtPDSoundAction.Create(AParentDoc, AParentElement, ABaseObject)
  else if LActionType = PDF_MOVIEACTION then
    Result := TgtPDMovieAction.Create(AParentDoc, AParentElement, ABaseObject)
  else if LActionType = PDF_HIDE then
    Result := TgtPDHideAction.Create(AParentDoc, AParentElement, ABaseObject)
  else if LActionType = PDF_NAMED then
    Result := TgtPDNamedAction.Create(AParentDoc, AParentElement, ABaseObject)
  else if LActionType = PDF_SUBMITFORM then
    Result := TgtPDSubmitFormAction.Create(AParentDoc, AParentElement, ABaseObject)
  else if LActionType = PDF_RESETFORM then
    Result := TgtPDResetFormAction.Create(AParentDoc, AParentElement, ABaseObject)
  else if LActionType = PDF_IMPORTDATA then
    Result := nil
  else if LActionType = PDF_JAVASCRIPT then
    Result := TgtPDJavaScriptAction.Create(AParentDoc, AParentElement, ABaseObject)
  else if LActionType = PDF_SETOCGSTATE then
    Result := nil
  else if LActionType = PDF_RENDITION then
    Result := TgtPDRenditionAction.Create(AParentDoc, AParentElement, ABaseObject)
  else if LActionType = PDF_TRANSACTION then
    Result := TgtPDTransitionAction.Create(AParentDoc, AParentElement, ABaseObject)
  else if LActionType = PDF_GOTO3DVIEW then
    Result := TgtPDGoTo3DViewAction.Create(AParentDoc, AParentElement, ABaseObject)
  else
  begin
    Result := nil;
    {$IFDEF DEBUG}
    Logger.LogError('Wrong Action object');
    {$ENDIF}
    Exit;
  end;
end;

procedure TgtPDAction.SetActionType(Value: TgtPDActionType);
begin
  FActionType := Value;
end;

(*
procedure TgtPDAction.SetDest(Value: TgtPDDestination);
begin
  FViewDestination := Value;
end;
*)

(**
   *  procedure that updates the object prior to writing it to stream;
   *)

procedure TgtPDAction.Update;
begin

end;

end.
