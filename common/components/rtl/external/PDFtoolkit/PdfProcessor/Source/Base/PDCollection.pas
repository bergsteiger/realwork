{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Base                    }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

unit PDCollection;

interface

uses
  Classes, gtObject, PDBaseObject, PDVector;

type
  (**
   * TgtPDCollection
   *    This class is responsible for storing all the temperory values for both
   * Reader and writer classes. Whenever if there is a read operation, the
   * object will be searched first in this class's List which if not found will
   * be read from the file directly or will be taken from the list if present.
   *)
  TgtPDCollection = class(TgtObject)
  private
    FVector: TVector;
    FParentDoc: TgtObject;
  public
    constructor Create(ParentDoc: TgtObject);
    destructor Destroy; override;

    function GetObject(ObjectNumber: Integer): TgtPDBaseObject;
    procedure Add(Value: TgtPDBaseObject);
  end;

implementation

uses
  PDBaseDoc, PDBaseExceptions;

{ TgtPDCollection }

  (* Adds a base object to collections
   * @param Value is a Base Object
   * @exception ExInvalidObject if Value is NULL
   *)

procedure TgtPDCollection.Add(Value: TgtPDBaseObject);
begin
  if not Assigned(Value) then
    raise ExInvalidObject.Create(ErrInvalidObject);
  if Value.ObjNumber >= Cardinal(FVector.Capacity) then
  begin
    repeat
      FVector.Grow;
    until (Value.ObjNumber < Cardinal(FVector.Capacity));
  end;
  FVector.Items[Value.ObjNumber] := Value
end;

  (**
   * Constructor
   *
   * @param ParentDoc is the parent document for this object
   *)

constructor TgtPDCollection.Create(ParentDoc: TgtObject);
begin
  FVector := TVector.Create(TgtPDBaseDoc(ParentDoc).Reader.XRef.GetSize, True);
  FParentDoc := ParentDoc;
end;

  (**
   * Destructor
   *)

destructor TgtPDCollection.Destroy;
begin
  if Assigned(FVector) then FVector.Free;
  inherited;
end;

  (**
   * Gets an Object from the List with the Object Number ObjectNumber
   *
   * @param ObjectNumber is the Object number for the object that need to be
   *        retrieved
   *
   * @return TgtPDBaseObject is the object which has the object number
   *         ObjectNumber, nil if not found in the list
   *)

function TgtPDCollection.GetObject(ObjectNumber: Integer): TgtPDBaseObject;
begin
  if Assigned(FVector.Items[ObjectNumber]) then
    Result := TgtPDBaseObject(FVector.Items[ObjectNumber])
  else
    Result := nil;
end;

end.
