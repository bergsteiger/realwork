unit PDFormComboBox;

interface

uses
  Classes, gtObject, PDElement, PDBaseObject, PDFormChoiceBox, PDFormField;

type
  TgtPDFormComboBox = class(TgtPDFormChoiceBox)
  private
    FSelectedItemIndex: Integer;
    FIsEditable: Boolean;

    function GetIsEditable: Boolean;
    procedure SetIsEditable(Value: Boolean);
    function GetSelectedItemIndex: Integer;
    procedure SetSelectedItemIndex(Value: Integer);
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
    property Options;
    property OptionCount;
    property IsSortedList;
    property IsMultiSelect;
    property IsDoNotSpellCheck;
    property IsEditable: Boolean read GetIsEditable write SetIsEditable;
    property SelectedItemIndex: Integer read GetSelectedItemIndex
      write SetSelectedItemIndex;
  end;

implementation

uses
  PDDictionary, PDInteger, gtConstants;

{ TgtPDFormComboBox }

constructor TgtPDFormComboBox.Create(AParentDoc: TgtObject;
  AParentElement: TgtPDElement; ABaseObject: TgtPDBaseObject);
begin
  inherited;
  FParentDoc := AParentDoc;
  FParentElement := AParentElement;
  FBaseObject := ABaseObject;
end;

function TgtPDFormComboBox.Clone: TgtPDFormField;
begin
  Result := TgtPDFormComboBox.Create;
end;

constructor TgtPDFormComboBox.Create;
begin
  inherited;
  FIsEditable := False;
  FormFieldType := ftComboBox;
end;

destructor TgtPDFormComboBox.Destroy;
begin

  inherited;
end;

function TgtPDFormComboBox.GetIsEditable: Boolean;
var
  LIsCombo: Boolean;
begin
  LIsCombo := (((FFlag shr 17) and 1) = 1);
  if LIsCombo then
    FIsEditable := (((FFlag shr 18) and 1) = 1);

  Result := FIsEditable;
end;

function TgtPDFormComboBox.GetSelectedItemIndex: Integer;
begin
  Result := FSelectedItemIndex;
end;

procedure TgtPDFormComboBox.SetIsEditable(Value: Boolean);
var
  LObj: TgtPDBaseObject;
begin
  FIsEditable := Value;

  if Assigned(FBaseObject) then
  begin
    FFlag := FFlag or (1 shl 18);
    LObj := TgtPDDictionary(FBaseObject).LookUp(pdf_FF);
    if Assigned(LObj) then
      TgtPDInteger(LObj).Value := FFlag
    else
      TgtPDDictionary(FBaseObject).Add(PDF_FF, TgtPDInteger.Create(FFlag));
  end;
end;

procedure TgtPDFormComboBox.SetSelectedItemIndex(Value: Integer);
//var
//  LObj: TgtPDBaseObject;
begin
  FSelectedItemIndex := Value;
end;

end.
