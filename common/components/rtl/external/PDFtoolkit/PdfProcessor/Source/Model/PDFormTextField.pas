unit PDFormTextField;

interface

uses
  gtObject, PDElement, PDBaseObject, PDFormField;

type
  TgtPDFormTextField = class(TgtPDFormField)
  private
    //Value will be true for password fileds
    FisPasswordField: Boolean;

    // Value will be true for MultiLine enabled text fields
    FIsMultiLine: Boolean;

    // Value will be true for Combed fields, only if MaxLen entry is present
    //in the TextField Dictionary
    FIsComb: Boolean;
    FMaxLen: Integer;

    //if true the text entered in the field represents the pathname of a file
    //whose contents are to be submitted as the value of the field.
    FIsFileSelect: Boolean;

    //if true text entered in the field is not spell-checked.
    FIsDoNotSpellCheck: Boolean;

    // if true the field does not scroll (horizontally for single-line fields,
    //vertically for multiple-line fields) to accommodate more text than fits
    //within its annotation rectangle.
    FIsDoNotScroll: Boolean;

    function GetIsMultiLine: Boolean;
    function GetIsPasswordField: Boolean;
    function GetIsComb: Boolean;
    function GetIsFileSelect: Boolean;
    function GetIsDoNotSpellCheck: Boolean;
    function GetIsDoNotScroll: Boolean;
    function GetMaxLength: Integer;

    procedure SetIsMultiLine(Value: Boolean);
    procedure SetIsPasswordField(Value: Boolean);
    procedure SetIsComb(Value: Boolean);
    procedure SetIsFileSelect(Value: Boolean);
    procedure SetIsDoNotSpellCheck(Value: Boolean);
    procedure SetIsDoNotScroll(Value: Boolean);
    procedure SetMaxLength(Value: Integer);
  public
    constructor Create(AParentDoc: TgtObject; AParentElement: TgtPDElement;
      ABaseObject: TgtPDBaseObject); overload;
    constructor Create; overload;
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
    property BorderStyle;
    property Action;
    property Rect;
    property Page;
    property Font;
    property BorderWidth;
    property IsReadOnly;
    property Flag;
    property IsMultiLine: Boolean read GetIsMultiLine write SetIsMultiLine;
    property IsPasswordField: Boolean read GetIsPasswordField write SetIsPasswordField;
    property IsComb: Boolean read GetIsComb write SetIsComb;
    property IsFileSelect: Boolean read GetIsFileSelect write SetIsFileSelect;
    property IsDoNotSpellCheck: Boolean read GetIsDoNotSpellCheck write SetIsDoNotSpellCheck;
    property IsDoNotScroll: Boolean read GetIsDoNotScroll write SetIsDoNotScroll;
    property MaxLength: Integer read GetMaxLength write SetMaxLength;
  end;

implementation

uses
  gtConstants, PDInteger, PDDictionary;

{ TgtPDFormTextField }

constructor TgtPDFormTextField.Create(AParentDoc: TgtObject;
  AParentElement: TgtPDElement; ABaseObject: TgtPDBaseObject);
begin
  inherited;
  FParentDoc := AParentDoc;
  FParentElement := AParentElement;
  FBaseObject := ABaseObject;
  FMaxLen := 0;
  FIsComb := False;
  FIsMultiLine := False;
  FisPasswordField := False;
end;

function TgtPDFormTextField.Clone: TgtPDFormField;
begin
  Result := TgtPDFormTextField.Create;
end;

constructor TgtPDFormTextField.Create;
begin
  inherited;
  FMaxLen := 0;
  FIsComb := False;
  FIsMultiLine := False;
  FisPasswordField := False;
  FormFieldType := ftText;
end;

destructor TgtPDFormTextField.Destroy;
begin

  inherited;
end;

function TgtPDFormTextField.GetIsComb: Boolean;
var
  LComb: Boolean;
  LObj: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    LComb := ((FFlag shr 24) and 1 = 1);
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_MAXLEN);
    if Assigned(LObj) then
    begin
      FMaxLen := TgtPDInteger(LObj).Value;
    end;
    if (LComb and (FMaxLen > 0)) then
    begin
      FIsComb := True;
    end;
  end;
  Result := FIsComb;
end;

function TgtPDFormTextField.GetIsDoNotScroll: Boolean;
begin
  if Assigned(FBaseObject) then
    FIsDoNotScroll := ((FFlag shr 23) and 1 = 1);
  Result := FIsDoNotScroll;
end;

function TgtPDFormTextField.GetIsDoNotSpellCheck: Boolean;
begin
  if Assigned(FBaseObject) then
    FIsDoNotSpellCheck := ((FFlag shr 22) and 1 = 1);
  Result := FIsDoNotSpellCheck;
end;

function TgtPDFormTextField.GetIsFileSelect: Boolean;
begin
  if Assigned(FBaseObject) then
    FIsFileSelect := ((FFlag shr 20) and 1 = 1);
  Result := FIsFileSelect;
end;

function TgtPDFormTextField.GetIsMultiLine: Boolean;
begin
  if Assigned(FBaseObject) then
    FIsMultiLine := ((FFlag shr 12) and 1 = 1);
  Result := FIsMultiLine;
end;

function TgtPDFormTextField.GetIsPasswordField: Boolean;
begin
  if Assigned(FBaseObject) then
    FisPasswordField := ((FFlag shr 13) and 1 = 1);
  Result := FisPasswordField;
end;

function TgtPDFormTextField.GetMaxLength: Integer;
var
  LObj: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_MAXLEN);
    if Assigned(LObj) then
    begin
      FMaxLen := TgtPDInteger(LObj).Value;
    end;
  end;
  Result := FMaxLen;
end;

procedure TgtPDFormTextField.SetIsComb(Value: Boolean);
var
  LObj: TgtPDBaseObject;
begin
  FIsComb := Value;

  if Assigned(FBaseObject) then
  begin
    if FIsComb then
    begin
      FFlag := FFlag or (1 shl 24);
      LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_FF);
      if Assigned(LObj) then
        TgtPDInteger(LObj).Value := FFlag
      else
        TgtPDDictionary(FBaseObject).Add(PDF_FF, TgtPDInteger.Create(FFlag));
    end;
  end;
end;

procedure TgtPDFormTextField.SetIsDoNotScroll(Value: Boolean);
var
  LObj: TgtPDBaseObject;
begin
  FIsDoNotScroll := Value;

  if Assigned(FBaseObject) then
  begin
    if FIsDoNotScroll then
    begin
      FFlag := FFlag or (1 shl 23);
      LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_FF);
      if Assigned(LObj) then
        TgtPDInteger(LObj).Value := FFlag
      else
        TgtPDDictionary(FBaseObject).Add(PDF_FF, TgtPDInteger.Create(FFlag));
    end;
  end;
end;

procedure TgtPDFormTextField.SetIsDoNotSpellCheck(Value: Boolean);
var
  LObj: TgtPDBaseObject;
begin
  FIsDoNotSpellCheck := Value;

  if Assigned(FBaseObject) then
  begin
    if FIsDoNotSpellCheck then
    begin
      FFlag := FFlag or (1 shl 22);
      LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_FF);
      if Assigned(LObj) then
        TgtPDInteger(LObj).Value := FFlag
      else
        TgtPDDictionary(FBaseObject).Add(PDF_FF, TgtPDInteger.Create(FFlag));
    end;
  end;
end;

procedure TgtPDFormTextField.SetIsFileSelect(Value: Boolean);
var
  LObj: TgtPDBaseObject;
begin
  FIsFileSelect := Value;

  if Assigned(FBaseObject) then
  begin
    if FIsFileSelect then
    begin
      FFlag := FFlag or (1 shl 20);
      LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_FF);
      if Assigned(LObj) then
        TgtPDInteger(LObj).Value := FFlag
      else
        TgtPDDictionary(FBaseObject).Add(PDF_FF, TgtPDInteger.Create(FFlag));
    end;
  end;
end;

procedure TgtPDFormTextField.SetIsMultiLine(Value: Boolean);
var
  LObj: TgtPDBaseObject;
begin
  FIsMultiLine := Value;

  if Assigned(FBaseObject) then
  begin
    if FIsMultiLine then
    begin
      FFlag := FFlag or (1 shl 12);
      LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_FF);
      if Assigned(LObj) then
        TgtPDInteger(LObj).Value := FFlag
      else
        TgtPDDictionary(FBaseObject).Add(PDF_FF, TgtPDInteger.Create(FFlag));
    end;
  end;
end;

procedure TgtPDFormTextField.SetIsPasswordField(Value: Boolean);
var
  LObj: TgtPDBaseObject;
begin
  FisPasswordField := Value;

  if Assigned(FBaseObject) then
  begin
    if FisPasswordField then
    begin
      FFlag := FFlag or (1 shl 13);
      LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_FF);
      if Assigned(LObj) then
        TgtPDInteger(LObj).Value := FFlag
      else
        TgtPDDictionary(FBaseObject).Add(PDF_FF, TgtPDInteger.Create(FFlag));
    end;
  end;
end;

procedure TgtPDFormTextField.SetMaxLength(Value: Integer);
var
  LObj: TgtPDBaseObject;
begin
  FMaxLen := Value;

  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_MAXLEN);
    if Assigned(LObj) then
      TgtPDInteger(LObj).Value := FMaxLen
    else
      TgtPDDictionary(FBaseObject).Add(PDF_MAXLEN, TgtPDInteger.Create(FMaxLen));
  end;
end;

end.
