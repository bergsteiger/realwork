unit PDAdditionalAction;

interface

uses
  gtObject, PDElement, PDBaseObject, PDAction;

type
  TgtPDAdditionalAction = class(TgtPDElement)

  end;

  TgtPDDocAdditionalAction = class(TgtPDAdditionalAction)
  private
    FAfterPrint: TgtPDAction;
    FAfterSave: TgtPDAction;
    FBeforeClose: TgtPDAction;
    FBeforePrint: TgtPDAction;
    FBeforeSave: TgtPDAction;

    function GetAfterPrint: TgtPDAction;
    function GetAfterSave: TgtPDAction;
    function GetBeforeClose: TgtPDAction;
    function GetBeforePrint: TgtPDAction;
    function GetBeforeSave: TgtPDAction;
  public
    constructor Create(AParentDoc: TgtObject; AParentElement: TgtPDElement;
      ABaseObject: TgtPDBaseObject); override;
    destructor Destroy; override;
    procedure Update; override;
    procedure Assign(Source: TgtPDElement); override;

    property BeforeClose: TgtPDAction read GetBeforeClose;
    property BeforeSave: TgtPDAction read GetBeforeSave;
    property AfterSave: TgtPDAction read GetAfterSave;
    property BeforePrint: TgtPDAction read GetBeforePrint;
    property AfterPrint: TgtPDAction read GetAfterPrint;
  end;

implementation

uses
  PDDictionary, gtConstants, gtMethods, gtLogger;

{ TgtPDDocAdditionalAction }

procedure TgtPDDocAdditionalAction.Assign(Source: TgtPDElement);
begin
  inherited;

end;

constructor TgtPDDocAdditionalAction.Create(AParentDoc: TgtObject;
  AParentElement: TgtPDElement; ABaseObject: TgtPDBaseObject);
begin
  inherited;
  FAfterPrint := nil;
  FAfterSave := nil;
  FBeforeClose := nil;
  FBeforePrint := nil;
  FBeforeSave := nil;
end;

destructor TgtPDDocAdditionalAction.Destroy;
begin
  if Assigned(FAfterPrint) then FreeObject(FAfterPrint);
  if Assigned(FAfterSave) then FreeObject(FAfterSave);
  if Assigned(FBeforeClose) then FreeObject(FBeforeClose);
  if Assigned(FBeforePrint) then FreeObject(FBeforePrint);
  if Assigned(FBeforeSave) then FreeObject(FBeforeSave);
  inherited;
end;

function TgtPDDocAdditionalAction.GetAfterPrint: TgtPDAction;
var
  LObj: TgtPDBaseObject;
begin
  if not Assigned(FAfterPrint) then
  begin
    LObj := nil;
    if Assigned(BaseObject) then
    begin
      LObj := TgtPDDictionary(BaseObject).LookUp(PDF_DP);
      if Assigned(LObj) then
      begin
        if LObj.IsDict then
        begin
          FAfterPrint := TgtPDAction.MakeAction(ParentDoc, Self, LObj);
        end
        else
        begin
          Logger.LogError('Action Dict Object Expected in Document Additional Action');
          LObj := nil;
        end;
      end
    end;
    // No DP Entry, Create Action
    if not Assigned(LObj) then
    begin
      FIsChanged := True;
      FAfterPrint := TgtPDAction.MakeAction(ParentDoc, Self, actionJavaScript);
    end;
  end;
  Result := FAfterPrint;
end;

function TgtPDDocAdditionalAction.GetAfterSave: TgtPDAction;
var
  LObj: TgtPDBaseObject;
begin
  if not Assigned(FAfterSave) then
  begin
    LObj := nil;
    if Assigned(BaseObject) then
    begin
      LObj := TgtPDDictionary(BaseObject).LookUp(PDF_DS);
      if Assigned(LObj) then
      begin
        if LObj.IsDict then
        begin
          FAfterSave := TgtPDAction.MakeAction(ParentDoc, Self, LObj);
        end
        else
        begin
          Logger.LogError('Action Dict Object Expected in Document Additional Action');
          LObj := nil;
        end;
      end
    end;
    // No DS Entry, Create Action
    if not Assigned(LObj) then
    begin
      FIsChanged := True;
      FAfterSave := TgtPDAction.MakeAction(ParentDoc, Self, actionJavaScript);
    end;
  end;
  Result := FAfterSave;
end;

function TgtPDDocAdditionalAction.GetBeforeClose: TgtPDAction;
var
  LObj: TgtPDBaseObject;
begin
  if not Assigned(FBeforeClose) then
  begin
    LObj := nil;
    if Assigned(BaseObject) then
    begin
      LObj := TgtPDDictionary(BaseObject).LookUp(PDF_DC);
      if Assigned(LObj) then
      begin
        if LObj.IsDict then
        begin
          FBeforeClose := TgtPDAction.MakeAction(ParentDoc, Self, LObj);
        end
        else
        begin
          Logger.LogError('Action Dict Object Expected in Document Additional Action');
          LObj := nil;
        end;
      end
    end;
    // No DC Entry, Create Action
    if not Assigned(LObj) then
    begin
      FIsChanged := True;
      FBeforeClose := TgtPDAction.MakeAction(ParentDoc, Self, actionJavaScript);
    end;
  end;
  Result := FBeforeClose;
end;

function TgtPDDocAdditionalAction.GetBeforePrint: TgtPDAction;
var
  LObj: TgtPDBaseObject;
begin
  if not Assigned(FBeforePrint) then
  begin
    LObj := nil;
    if Assigned(BaseObject) then
    begin
      LObj := TgtPDDictionary(BaseObject).LookUp(PDF_WP);
      if Assigned(LObj) then
      begin
        if LObj.IsDict then
        begin
          FBeforePrint := TgtPDAction.MakeAction(ParentDoc, Self, LObj);
        end
        else
        begin
          Logger.LogError('Action Dict Object Expected in Document Additional Action');
          LObj := nil;
        end;
      end
    end;
    // No WP Entry, Create Action
    if not Assigned(LObj) then
    begin
      FIsChanged := True;
      FBeforePrint := TgtPDAction.MakeAction(ParentDoc, Self, actionJavaScript);
    end;
  end;
  Result := FBeforePrint;
end;

function TgtPDDocAdditionalAction.GetBeforeSave: TgtPDAction;
var
  LObj: TgtPDBaseObject;
begin
  if not Assigned(FBeforeSave) then
  begin
    LObj := nil;
    if Assigned(BaseObject) then
    begin
      LObj := TgtPDDictionary(BaseObject).LookUp(PDF_WS);
      if Assigned(LObj) then
      begin
        if LObj.IsDict then
        begin
          FBeforeSave := TgtPDAction.MakeAction(ParentDoc, Self, LObj);
        end
        else
        begin
          Logger.LogError('Action Dict Object Expected in Document Additional Action');
          LObj := nil;
        end;
      end
    end;
    // No WS Entry, Create Action
    if not Assigned(LObj) then
    begin
      FIsChanged := True;
      FBeforeSave := TgtPDAction.MakeAction(ParentDoc, Self, actionJavaScript);
    end;
  end;
  Result := FBeforeSave;
end;

procedure TgtPDDocAdditionalAction.Update;
var
  LObj: TgtPDBaseObject;
  LActionDict: TgtPDDictionary;
begin
  inherited;
  if FIsChanged then
  begin
    if not Assigned(FBaseObject) then
    begin
    end;

    if Assigned(FAfterPrint) then
    begin
      // call UpdateBaseObject
    end;

    if Assigned(FAfterSave) then
    begin

    end;
    if Assigned(FBeforePrint) then
    begin

    end;
    if Assigned(FBeforeSave) then
    begin

    end;
  end;
end;

end.
