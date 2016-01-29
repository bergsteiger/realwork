unit PDStrikeOutAnnot;

interface

uses
  gtObject, PDTypes, PDElement, PDBaseObject, PDMarkUpAnnot, PDAnnot;

type
  TgtPDStrikeOutAnnot = class(TgtPDMarkUpAnnot)
  public
    constructor Create(AParentDoc: TgtObject; AParentElement: TgtPDElement;
      ABaseObject: TgtPDBaseObject);
  end;

implementation

{ TgtPDStrikeOutAnnot }

constructor TgtPDStrikeOutAnnot.Create(AParentDoc: TgtObject;
  AParentElement: TgtPDElement; ABaseObject: TgtPDBaseObject);
begin
  inherited;
  AnnotType := annotStrikeOut;
end;

end.
