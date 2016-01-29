{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Model                   }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

unit PDGoToAction;

interface

uses
  gtObject, PDElement, PDBaseObject, PDAction, PDDestination;

type
  TgtPDGoToAction = class(TgtPDAction)
  private
  public
    constructor Create(AParentDoc: TgtObject; AParentElement: TgtPDElement;
      ABaseObject: TgtPDBaseObject); overload;
    constructor Create(ADestination: TgtPDDestination); overload;
    constructor Create; overload;
    destructor Destroy; override;

    property Destination;
    property ActionType;
  end;

implementation

{ TgtPDGoToAction }

constructor TgtPDGoToAction.Create(AParentDoc: TgtObject;
  AParentElement: TgtPDElement; ABaseObject: TgtPDBaseObject);
begin
  FParentDoc := AParentDoc;
  FParentElement := AParentElement;
  FBaseObject := ABaseObject;

  ActionType := actionGoTo;
end;

constructor TgtPDGoToAction.Create(ADestination: TgtPDDestination);
begin
  FViewDestination := ADestination;
  ActionType := actionGoTo;
end;

constructor TgtPDGoToAction.Create;
begin
  ActionType := actionGoTo;
  FViewDestination := TgtPDDestination.Create;
end;

destructor TgtPDGoToAction.Destroy;
begin

  inherited;
end;

end.
