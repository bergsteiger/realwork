unit PDRadioItem;

interface

uses
  gtObject, PDElement, PDBaseObject, PDFormField;

type
  TgtPDRadioItem = class(TgtPDFormField)
  private
  public
    constructor Create(AParentDoc: TgtObject; AParentElement: TgtPDElement;
      ABaseObject: TgtPDBaseObject); overload;
    constructor Create; overload;

    destructor Destroy; override;

    property Rect;
    property BorderColor;
    property BackGroundColor;
    property Value;
  end;

implementation

{ TgtPDRadioItem }

constructor TgtPDRadioItem.Create(AParentDoc: TgtObject;
  AParentElement: TgtPDElement; ABaseObject: TgtPDBaseObject);
begin
  inherited;
  FParentDoc := AParentDoc;
  FParentElement := AParentElement;
  FBaseObject := ABaseObject;
end;

constructor TgtPDRadioItem.Create;
begin
  inherited;

end;

destructor TgtPDRadioItem.Destroy;
begin

  inherited;
end;

end.
