unit PDUnderlineAnnot;

interface

uses
  gtObject, PDTypes, PDElement, PDBaseObject, PDMarkUpAnnot, PDAnnot;

type
  TgtPDUnderlineAnnot = class(TgtPDMarkUpAnnot)
  public
    constructor Create(AParentDoc: TgtObject; AParentElement: TgtPDElement;
      ABaseObject: TgtPDBaseObject);
  end;

implementation

{ TgtPDUnderlineAnnot }

constructor TgtPDUnderlineAnnot.Create(AParentDoc: TgtObject;
  AParentElement: TgtPDElement; ABaseObject: TgtPDBaseObject);
begin
  inherited;
  AnnotType := annotUnderline;
end;

end.
