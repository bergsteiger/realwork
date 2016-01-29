unit PDHighlightAnnot;

interface

uses
  gtObject, PDTypes, PDElement, PDBaseObject, PDMarkUpAnnot, PDAnnot;

type
  TgtPDHighlightAnnot = class(TgtPDMarkUpAnnot)
  public
    constructor Create(AParentDoc: TgtObject; AParentElement: TgtPDElement;
      ABaseObject: TgtPDBaseObject);
  end;

implementation

{ TgtPDHighlightAnnot }

constructor TgtPDHighlightAnnot.Create(AParentDoc: TgtObject;
  AParentElement: TgtPDElement; ABaseObject: TgtPDBaseObject);
begin
  inherited;
  AnnotType := annotHighlight;
end;

end.
