unit PDElement;

interface

uses
  gtObject, PDBaseObject;

type
  TgtPDElement = class(TgtObject)
  protected
    FBaseObject: TgtPDBaseObject;
    FParentDoc: TgtObject;
    FParentElement: TgtPDElement;

    FIsChanged: Boolean;
  public
//    constructor Create(AParentDoc: TgtObject; AParentElement: TgtPDElement;
//      ABaseObject: TgtPDBaseObject); virtual;
    destructor Destroy; override;
    procedure Update; virtual; abstract;
//     procedure Assign(Source: TgtPDElement); virtual; abstract;

    property BaseObject: TgtPDBaseObject read FBaseObject;
    property ParentDoc: TgtObject read FParentDoc;
    property ParentElement: TgtPDElement read FParentElement;
    property Changed: Boolean read FIsChanged;
  end;

implementation

{ TgtPDElement }

//constructor TgtPDElement.Create(AParentDoc: TgtObject;
//  AParentElement: TgtPDElement; ABaseObject: TgtPDBaseObject);
//begin
//  FParentDoc := AParentDoc;
//  FParentElement := AParentElement;
//  FBaseObject := ABaseObject;
//  FIsChanged := False;
//end;

destructor TgtPDElement.Destroy;
begin

  inherited;
end;

end.
