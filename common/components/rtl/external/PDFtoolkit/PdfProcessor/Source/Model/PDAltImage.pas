unit PDAltImage;

interface

uses
  gtObject, PDElement, PDBaseObject;

type
  TgtPDAltImage = class;

  TgtPDAltImageList = class(TgtPDElement)
  private
    function GetAltImage(Index: Integer): TgtPDAltImage;
  public
    constructor Create(AParentDoc: TgtObject; AParentElement: TgtPDElement;
      ABaseObject: TgtPDBaseObject);
    property AltImages[Index: Integer]: TgtPDAltImage read GetAltImage;

  end;

  TgtPDAltImage = class(TgtPDElement)
  private
  public
    constructor Create(AParentDoc: TgtObject; AParentElement: TgtPDElement;
      ABaseObject: TgtPDBaseObject);

    //property Image: TgtPDElement;
    //property ForPrinting: Boolean;
    //property OC
  end;

implementation

{ TgtPDAltImageList }

constructor TgtPDAltImageList.Create(AParentDoc: TgtObject;
  AParentElement: TgtPDElement; ABaseObject: TgtPDBaseObject);
begin

end;

function TgtPDAltImageList.GetAltImage(Index: Integer): TgtPDAltImage;
begin
  Result := nil;
end;

{ TgtPDAltImage }

constructor TgtPDAltImage.Create(AParentDoc: TgtObject;
  AParentElement: TgtPDElement; ABaseObject: TgtPDBaseObject);
begin

end;

end.
