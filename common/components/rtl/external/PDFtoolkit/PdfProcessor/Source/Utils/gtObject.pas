{ ********************************************************************* }
{                                                                       }
{                       Gnostice Utilities                              }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

unit gtObject;

interface


type
  TgtObject = class(TObject)
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TgtObject }

constructor TgtObject.Create;
begin

end;

destructor TgtObject.Destroy;
begin

  inherited;
end;

end.
