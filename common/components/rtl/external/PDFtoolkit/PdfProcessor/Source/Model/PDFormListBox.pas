unit PDFormListBox;

interface

uses
  Classes, gtObject, PDElement, PDBaseObject, PDFormChoiceBox, PDFormField;

type
  TgtPDFormListBox = class(TgtPDFormChoiceBox)
  private

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
    property Flag;
    property Page;
    property BorderWidth;
    property IsReadOnly;
    property Font;
    property Options;
    property OptionCount;
    property IsSortedList;
    property IsMultiSelect;
    property IsDoNotSpellCheck;
  end;

implementation

uses
  gtConstants, PDDictionary;

{ TgtPDFormListBox }

constructor TgtPDFormListBox.Create(AParentDoc: TgtObject;
  AParentElement: TgtPDElement; ABaseObject: TgtPDBaseObject);
begin
  inherited;
  FParentDoc := AParentDoc;
  FParentElement := AParentElement;
  FBaseObject := ABaseObject;
end;

function TgtPDFormListBox.Clone: TgtPDFormField;
begin
  Result := TgtPDFormListBox.Create;
end;

constructor TgtPDFormListBox.Create;
begin
  inherited;
  IsSortedList := False;
  IsMultiSelect := False;
  IsDoNotSpellCheck := False;
  FormFieldType := ftListBox;
end;

destructor TgtPDFormListBox.Destroy;
begin

  inherited;
end;

end.
