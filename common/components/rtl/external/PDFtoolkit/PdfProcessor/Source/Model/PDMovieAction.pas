{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Model                   }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

unit PDMovieAction;

interface

uses
  gtObject, PDElement, PDBaseObject, PDAction;

type
  TgtPDMovieAction = class(TgtPDAction)
  private
  public
    constructor Create(AParentDoc: TgtObject; AParentElement: TgtPDElement;
      ABaseObject: TgtPDBaseObject);
  end;

implementation

{ TgtPDMovieAction }

constructor TgtPDMovieAction.Create(AParentDoc: TgtObject;
  AParentElement: TgtPDElement; ABaseObject: TgtPDBaseObject);
begin

end;

end.
