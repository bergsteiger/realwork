{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Model                   }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

unit PDHideAction;

interface

uses
  gtObject, PDElement, PDBaseObject, PDAction;

type
  TgtPDHideAction = class(TgtPDAction)
  private
  public
    constructor Create(AParentDoc: TgtObject; AParentElement: TgtPDElement;
      ABaseObject: TgtPDBaseObject);
  end;

implementation

{ TgtPDHideAction }

constructor TgtPDHideAction.Create(AParentDoc: TgtObject;
  AParentElement: TgtPDElement; ABaseObject: TgtPDBaseObject);
begin

end;

end.
