{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Model                   }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

unit PDGoToEmbeddedAction;

interface

uses
  gtObject, PDElement, PDBaseObject, PDAction;

type
  TgtTargetType = (ttParent, ttChild);

  TgtPDGoToEmbeddedAction = class(TgtPDAction)
  private
    FOpenInNewWindow: Boolean;
    FTargetType: TgtTargetType;

    function GetFileName: AnsiString;
    function GetOpenInNewWindow: Boolean;
    function GetTargetType: TgtTargetType;

    procedure SetFileName(Value: AnsiString);
    procedure SetOpenInNewWindow(Value: Boolean);
    procedure SetTargetType(Value: TgtTargetType);
  public
    constructor Create(AParentDoc: TgtObject; AParentElement: TgtPDElement;
      ABaseObject: TgtPDBaseObject);

    property Destination;
    property FileName: AnsiString read GetFileName write SetFileName;
    property OpenInNewWindow: Boolean read GetOpenInNewWindow write SetOpenInNewWindow;
    property TargetType: TgtTargetType read GetTargetType write SetTargetType;
  end;

implementation

uses
  PDDictionary, PDString, gtConstants, PDFileSpec, PDBoolean, PDName, PDDocument;

{ TgtPDGoToEmbeddedAction }

constructor TgtPDGoToEmbeddedAction.Create(AParentDoc: TgtObject;
  AParentElement: TgtPDElement; ABaseObject: TgtPDBaseObject);
begin
  FParentDoc := AParentDoc;
  FParentElement := AParentElement;
  FBaseObject := ABaseObject;

  ActionType := actionGoToE;
end;

function TgtPDGoToEmbeddedAction.GetFileName: AnsiString;
var
  LObj: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_F);
    if Assigned(LObj) then
    begin
      if LObj.IsString then
      begin
        FFileSpec := TgtPDFileSpec.Create(nil);
        FFileSpec.FileName := TgtPDString(LObj).Value;
      end
      else if LObj.IsDict then
      begin
        FFileSpec := TgtPDFileSpec.Create(LObj);
      end;
    end;
  end;
  Result := FFileSpec.FileName;
end;

function TgtPDGoToEmbeddedAction.GetOpenInNewWindow: Boolean;
var
  LObj: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_NEWWINDOW);
    if Assigned(LObj) then
      FOpenInNewWindow := TgtPDBoolean(LObj).Value;
  end;
  Result := FOpenInNewWindow;
end;

function TgtPDGoToEmbeddedAction.GetTargetType: TgtTargetType;
var
  LTargetDict, LObj: TgtPDBaseObject;
  LTargetType: AnsiString;
begin
  if Assigned(FBaseObject) then
  begin
    LTargetDict := TgtPDDictionary(FBaseObject).LookUp(PDF_T);
    if Assigned(LTargetDict) then
    begin
      LObj := TgtPDDictionary(LTargetDict).LookUp(PDF_R);
      if Assigned(LObj) then
      begin
        LTargetType := TgtPDName(LObj).Value;
        if LTargetType = 'C' then
          FTargetType := ttChild
        else if LTargetType = 'P' then
          FTargetType := ttParent;
      end;
    end;
  end;
  Result := FTargetType;
end;

procedure TgtPDGoToEmbeddedAction.SetFileName(Value: AnsiString);
var
  LObj: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_F);
    if Assigned(LObj) then
    begin
      if LObj.IsString then
      begin
        if not Assigned(FFileSpec) then
          FFileSpec := TgtPDFileSpec.Create(nil);
        TgtPDString(LObj).Value := Value;
      end
      else if LObj.IsDict then
      begin
        if not Assigned(FFileSpec) then
          FFileSpec := TgtPDFileSpec.Create(LObj);
      end;
    end;
  end;
  FFileSpec.FileName := Value;
end;

procedure TgtPDGoToEmbeddedAction.SetOpenInNewWindow(Value: Boolean);
var
  LObj: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_NEWWINDOW);
    if Assigned(LObj) then
      TgtPDBoolean(LObj).Value := Value
    else
    begin
      LObj := TgtPDBoolean.Create(Value);
      TgtPDDictionary(FBaseObject).Add(PDF_NEWWINDOW, LObj);
    end;
  end;
  FOpenInNewWindow := Value;
end;

procedure TgtPDGoToEmbeddedAction.SetTargetType(Value: TgtTargetType);
var
  LTartgetDict, LObj: TgtPDBaseObject;
  LTargetType: AnsiString;
begin
  case Value of
    ttParent: LTargetType := 'P';
    ttChild: LTargetType := 'C';
  end;

  if Assigned(FBaseObject) then
  begin
    LTartgetDict := TgtPDDictionary(FBaseObject).LookUp(PDF_T);
    if Assigned(LTartgetDict) then
    begin
      LObj := TgtPDDictionary(LTartgetDict).LookUp(PDF_R);
      if Assigned(LObj) then
      begin
        TgtPDName(LObj).Value := LTargetType;
      end
      else
      begin
        LObj := TgtPDName.Create(LTargetType);
        TgtPDDictionary(LTartgetDict).Add(PDF_R, LObj);
      end;
    end
    else
    begin
      LTartgetDict := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);
      TgtPDDictionary(FBaseObject).Add(PDF_T, LTartgetDict);
      LObj := TgtPDName.Create(LTargetType);
      TgtPDDictionary(LTargetType).Add(PDF_R, LObj);
    end;
  end;
  FTargetType := Value;
end;

end.
