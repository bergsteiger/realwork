{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Base                    }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

unit PDEOF;

interface

uses
  PDBaseObject, Stream;

type
  (**
   * TgtPDEOF
   *    This class represents the EOF Object
   *)
  TgtPDEOF = class(TgtPDBaseObject)
  public
    function IsEOF: Boolean; override;
    function Clone: TgtPDBaseObject; override;
    constructor Create;
    destructor Destroy; override;

    procedure Assign(ASourceObj: TgtPDBaseObject); override;
  end;

implementation

{ TgtPDEOF }

  (**
   * This function will assign a different copy of the Source object to current
   *     object
   *
   * @param ASourceObj is the object from where the copy need to be created
   *)

procedure TgtPDEOF.Assign(ASourceObj: TgtPDBaseObject);
begin
  inherited;

end;

  (**
   * This function will return a clone of the current object
   *
   * @return TgtPDBaseObject is the EOF object with the same properties of
   *          current object
   *)

function TgtPDEOF.Clone: TgtPDBaseObject;
begin
  Result := TgtPDEOF.Create;
end;

constructor TgtPDEOF.Create;
begin

end;

destructor TgtPDEOF.Destroy;
begin

  inherited;
end;

(**
   * True if this object is EOF
   *
   * @return True if this object is EOF
   *)

function TgtPDEOF.IsEOF: Boolean;
begin
  Result := True;
end;

end.
