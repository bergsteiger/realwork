unit PDFormPushButton;

interface

uses
  gtObject, PDElement, PDBaseObject, PDFormField;

type
  TgtPDFormPushButton = class(TgtPDFormField)
  private
    FNormalCaption: AnsiString;
    FRollOverCaption: AnsiString;
    FDownCaption: AnsiString;

    function GetNormalCaption: AnsiString;
    function GetRollOverCaption: AnsiString;
    function GetDownCaption: AnsiString;

    procedure SetNormalCaption(Value: AnsiString);
    procedure SetRollOverCaption(Value: AnsiString);
    procedure SetDownCaption(Value: AnsiString);
  public
    constructor Create; overload;
    constructor Create(AParentDoc: TgtObject; AParentElement: TgtPDElement;
      ABaseObject: TgtPDBaseObject); overload;
    destructor Destroy; override;

    function Clone: TgtPDFormField; override;

    property RotationAngle;
    property BorderColor;
    property BackGroundColor;
    property HighlightMode;
    property DefaultValue;
    property Value;
    property FieldName;
    property Preferences;
    property Justification;
    property AltFieldName;
    property Transparent;
    property FormFieldType;
    property FullQualifiedName;
    property BorderStyle;
    property Action;
    property Rect;
    property Page;
    property Font;
    property BorderWidth;
    property IsReadOnly;
    property NormalCaption: AnsiString read GetNormalCaption write SetNormalCaption;
    property RollOverCaption: AnsiString read GetRollOverCaption
      write SetRollOverCaption;
    property DownCaption: AnsiString read GetDownCaption write SetDownCaption;

  end;

implementation

uses
  gtConstants, PDDictionary, PDString;

{ TgtPDFormPushButton }

function TgtPDFormPushButton.Clone: TgtPDFormField;
begin
  Result := TgtPDFormPushButton.Create;
end;

constructor TgtPDFormPushButton.Create(AParentDoc: TgtObject;
  AParentElement: TgtPDElement; ABaseObject: TgtPDBaseObject);
begin
  inherited;
  FParentDoc := AParentDoc;
  FParentElement := AParentElement;
  FBaseObject := ABaseObject;

  FDownCaption := 'Button';
  FRollOverCaption := 'Button';
  FNormalCaption := 'Button';
end;

destructor TgtPDFormPushButton.Destroy;
begin

  inherited;
end;

constructor TgtPDFormPushButton.Create;
begin
  inherited;
  FDownCaption := 'Button';
  FRollOverCaption := ''; //'Button';
  FNormalCaption := 'Button';
  FormFieldType := ftButton;
end;

function TgtPDFormPushButton.GetDownCaption: AnsiString;
var
  LObj, LObj2: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_MK);
    if Assigned(LObj) then
    begin
      LObj2 := TgtPDDictionary(LObj).LookUp(PDF_AC);
      if Assigned(LObj2) then
      begin
        FDownCaption := TgtPDString(LObj2).Value;
      end;
    end;
  end;
  Result := FDownCaption
end;

function TgtPDFormPushButton.GetNormalCaption: AnsiString;
var
  LObj, LObj2: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_MK);
    if Assigned(LObj) then
    begin
      LObj2 := TgtPDDictionary(LObj).LookUp(PDF_CA);
      if Assigned(LObj2) then
      begin
        FNormalCaption := TgtPDString(LObj2).Value;
      end;
    end;
  end;
  Result := FNormalCaption
end;

function TgtPDFormPushButton.GetRollOverCaption: AnsiString;
var
  LObj, LObj2: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_MK);
    if Assigned(LObj) then
    begin
      LObj2 := TgtPDDictionary(LObj).LookUp(PDF_RC);
      if Assigned(LObj2) then
      begin
        FRollOverCaption := TgtPDString(LObj2).Value;
      end;
    end;
  end;
  Result := FRollOverCaption
end;

procedure TgtPDFormPushButton.SetDownCaption(Value: AnsiString);
var
  LMKObj, LObj: TgtPDBaseObject;
begin
  FDownCaption := Value;

  if Assigned(FBaseObject) then
  begin
    LMKObj := TgtPDDictionary(FBaseObject).LookUp(PDF_MK);
    if Assigned(LMKObj) then
    begin
      LObj := TgtPDDictionary(LMKObj).LookUp(PDF_AC);
      if Assigned(LObj) then
        TgtPDString(LObj).Value := FDownCaption
      else
        TgtPDDictionary(LMKObj).Add(PDF_AC, TgtPDString.Create(FDownCaption, False));
    end
    else //If MK Dict is not present in the Document, Create it
    begin
      LMKObj := TgtPDDictionary.Create(Self);
      TgtPDDictionary(LMKObj).Add(PDF_AC, TgtPDString.Create(FDownCaption, False));
      TgtPDDictionary(FBaseObject).Add(PDF_MK, LMKObj);
    end;
  end;
end;

procedure TgtPDFormPushButton.SetNormalCaption(Value: AnsiString);
var
  LMKObj, LObj: TgtPDBaseObject;
begin
  FNormalCaption := Value;

  if Assigned(FBaseObject) then
  begin
    LMKObj := TgtPDDictionary(FBaseObject).LookUp(PDF_MK);
    if Assigned(LMKObj) then
    begin
      LObj := TgtPDDictionary(LMKObj).LookUp(PDF_CA);
      if Assigned(LObj) then
        TgtPDString(LObj).Value := FNormalCaption
      else
        TgtPDDictionary(LMKObj).Add(PDF_CA, TgtPDString.Create(FNormalCaption, False));
    end
    else //If MK Dict is not present in the Document, Create it
    begin
      LMKObj := TgtPDDictionary.Create(Self);
      TgtPDDictionary(LMKObj).Add(PDF_CA, TgtPDString.Create(FNormalCaption, False));
      TgtPDDictionary(FBaseObject).Add(PDF_MK, LMKObj);
    end;
  end;
end;

procedure TgtPDFormPushButton.SetRollOverCaption(Value: AnsiString);
var
  LMKObj, LObj: TgtPDBaseObject;
begin
  FRollOverCaption := Value;

  if Assigned(FBaseObject) then
  begin
    LMKObj := TgtPDDictionary(FBaseObject).LookUp(PDF_MK);
    if Assigned(LMKObj) then
    begin
      LObj := TgtPDDictionary(LMKObj).LookUp(PDF_RC);
      if Assigned(LObj) then
        TgtPDString(LObj).Value := FRollOverCaption
      else
        TgtPDDictionary(LMKObj).Add(PDF_RC, TgtPDString.Create(FRollOverCaption, False));
    end
    else //If MK Dict is not present in the Document, Create it
    begin
      LMKObj := TgtPDDictionary.Create(Self);
      TgtPDDictionary(LMKObj).Add(PDF_RC, TgtPDString.Create(FRollOverCaption, False));
      TgtPDDictionary(FBaseObject).Add(PDF_MK, LMKObj);
    end;
  end;
end;

end.
