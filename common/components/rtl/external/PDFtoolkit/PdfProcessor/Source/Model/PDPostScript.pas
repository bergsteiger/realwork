unit PDPostScript;

interface

uses
  gtObject, PDXObject, PDElement, PDBaseObject;

type
  TgtPDPostScript = class(TgtPDXObject)
  public
    constructor Create(AParentDoc: TgtObject; AResource: TgtPDElement;
      ABaseObject: TgtPDBaseObject);
  end;

implementation

{ TgtPDPostScript }

constructor TgtPDPostScript.Create(AParentDoc: TgtObject;
  AResource: TgtPDElement; ABaseObject: TgtPDBaseObject);
begin

end;

end.
