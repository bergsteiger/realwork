unit PDSquigglyAnnot;

interface

uses
  gtObject, PDTypes, PDElement, PDBaseObject, PDMarkUpAnnot, PDAnnot;

type
  TgtPDSquigglyAnnot = class(TgtPDMarkUpAnnot)
  public
    constructor Create(AParentDoc: TgtObject; AParentElement: TgtPDElement;
      ABaseObject: TgtPDBaseObject);
  end;

implementation

{ TgtPDSquiggly }

constructor TgtPDSquigglyAnnot.Create(AParentDoc: TgtObject;
  AParentElement: TgtPDElement; ABaseObject: TgtPDBaseObject);
begin
  inherited;
  AnnotType := annotSquiggly;
end;

end.
