{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Model                   }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

unit CoPDElement;

interface

uses
  PDElementIntf, PDElement;

type

  TgtPDCoPDElement = class(IgtPDElement)
  private
    FPDElement: TgtPDElement;
  public
    procedure Update; virtual; abstract;
  protected
    property PDElement: TgtPDElement read FPDElement write FPDElement;
  end;

implementation

end.
