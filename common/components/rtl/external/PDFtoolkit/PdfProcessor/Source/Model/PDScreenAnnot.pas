unit PDScreenAnnot;

interface

uses
  gtObject, PDElement, PDBaseObject, PDAnnot;

type
  TgtPDScreenAnnot = class(TgtPDAnnot)
  private
  public
    constructor Create(AParentDoc: TgtObject; AParentElement: TgtPDElement;
      ABaseObject: TgtPDBaseObject);
  end;
implementation

{ TgtPDScreenAnnot }

constructor TgtPDScreenAnnot.Create(AParentDoc: TgtObject;
  AParentElement: TgtPDElement; ABaseObject: TgtPDBaseObject);
begin
  FParentDoc := AParentDoc;
  FParentElement := AParentElement;
  FBaseObject := ABaseObject;
  AnnotType := annotScreen;
end;

end.
