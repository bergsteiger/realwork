{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Base                    }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

unit PDError;

interface

uses
  PDBaseObject, Stream;

type
  (**
   * TgtPDError
   *    This class represents the Error Object
   *)
  TgtPDError = class(TgtPDBaseObject)
  public
    function IsError: Boolean; override;
    function Clone: TgtPDBaseObject; override;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TgtPDError }

  (**
   * This function will return a clone of the current object
   *
   * @return TgtPDBaseObject is the EOF object with the same properties of
   *          current object
   *)

function TgtPDError.Clone: TgtPDBaseObject;
begin
  Result := TgtPDError.Create;
end;

  (**
   * True if this object is Error
   *
   * @return True if this object is Error
   *)

constructor TgtPDError.Create;
begin

end;

destructor TgtPDError.Destroy;
begin

  inherited;
end;

function TgtPDError.IsError: Boolean;
begin
  Result := True;
end;

end.
