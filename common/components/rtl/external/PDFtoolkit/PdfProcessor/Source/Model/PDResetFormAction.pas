{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Model                   }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

unit PDResetFormAction;

interface

uses
  gtObject, PDElement, PDBaseObject, PDAction;

type
  TgtPDResetFormAction = class(TgtPDAction)
  private
  public
    constructor Create; overload;
    constructor Create(AParentDoc: TgtObject; AParentElement: TgtPDElement;
      ABaseObject: TgtPDBaseObject); overload;
    destructor Destroy; override;
  end;

implementation

{ TgtPDResetFormAction }

constructor TgtPDResetFormAction.Create(AParentDoc: TgtObject;
  AParentElement: TgtPDElement; ABaseObject: TgtPDBaseObject);
begin
  inherited;
  ActionType := actionResetForm;
end;

destructor TgtPDResetFormAction.Destroy;
begin

  inherited;
end;

constructor TgtPDResetFormAction.Create;
begin

end;

end.
