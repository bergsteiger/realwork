unit PDPopUpAnnot;

interface

uses
  gtObject, PDElement, PDBaseObject, PDAnnot;

type
  TgtPDPopUpAnnot = class(TgtPDAnnot)
  private
    FIsOpen: Boolean;
    FParent: TgtPDAnnot;

    function GetIsOpen: Boolean;
    function GetParent: TgtPDAnnot;

    procedure SetIsOpen(const Value: Boolean);
    procedure SetParent(const Value: TgtPDAnnot);
  public
    constructor Create(AParentDoc: TgtObject; AParentElement: TgtPDElement;
      ABaseObject: TgtPDBaseObject);

    property IsOpen: Boolean read GetIsOpen write SetIsOpen;
    property Parent: TgtPDAnnot read GetParent write SetParent;
  end;

implementation

{ TgtPDPopUpAnnot }

constructor TgtPDPopUpAnnot.Create(AParentDoc: TgtObject;
  AParentElement: TgtPDElement; ABaseObject: TgtPDBaseObject);
begin
  FParentDoc := AParentDoc;
  FParentElement := AParentElement;
  FBaseObject := ABaseObject;
  AnnotType := annotPopup;
end;

function TgtPDPopUpAnnot.GetIsOpen: Boolean;
begin
  Result := FIsOpen;
end;

function TgtPDPopUpAnnot.GetParent: TgtPDAnnot;
begin
  Result := FParent;
end;

procedure TgtPDPopUpAnnot.SetIsOpen(const Value: Boolean);
begin

end;

procedure TgtPDPopUpAnnot.SetParent(const Value: TgtPDAnnot);
begin

end;

end.
