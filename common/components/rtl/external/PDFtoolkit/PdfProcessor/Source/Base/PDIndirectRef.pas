{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Base                    }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

unit PDIndirectRef;

interface

uses
  gtObject, PDBaseObject, Stream;

type

  (**
   * TgtPDIndirectRef
   *    This class represents the Indirect Reference Object in the PDF.
   *)
  TgtPDIndirectRef = class(TgtPDBaseObject)
  public
    constructor Create(AObjNumber: Cardinal; AGenNumber: Cardinal);
    destructor Destroy; override;

    function Clone: TgtPDBaseObject; override;
    function IsIndirectRef: Boolean; override;
    function SaveToStream(Stream: TgtStream; OnlyChanged: Boolean;
      XRef: TgtObject): Cardinal; override;

    procedure Assign(ASourceObj: TgtPDBaseObject); override;
  end;

implementation

uses
  gtMethods, gtConstants, PDXRef, PDXRefEntry;

{ TgtPDIndirectObject }

  (**
   * This function will assign a different copy of the Source object to current
   *     object
   *
   * @param ASourceObj is the object from where the copy need to be created
   *)

procedure TgtPDIndirectRef.Assign(ASourceObj: TgtPDBaseObject);
begin
  inherited;
end;

  (**
   * This function will return a clone of the current object
   *
   * @return TgtPDBaseObject is the Indirect Reference object with the same
   *         properties of current object
   *)

function TgtPDIndirectRef.Clone: TgtPDBaseObject;
begin
  Result := TgtPDIndirectRef.Create(FObjNumber, FGenNumber);
end;


  (**
   * Constructor
   *
   * @param AObjNumber is the object number with which Indirect Reference object
   *        need to be created
   *
   * @param AGenNumber is the generation number with which Indirect Reference
   *        object need to be created
   *)

constructor TgtPDIndirectRef.Create(AObjNumber, AGenNumber: Cardinal);
begin
  FObjNumber := AObjNumber;
  FGenNumber := AGenNumber;
  FIsChanged := False;
end;

destructor TgtPDIndirectRef.Destroy;
begin

  inherited;
end;

(**
   * Ture if the object is Indirect Reference
   *
   * @return true if the object is Indirect Reference object
   *)

function TgtPDIndirectRef.IsIndirectRef: Boolean;
begin
  Result := True;
end;

  (**
   * This function will writes the Indirect Reference object into the stream provided
   *
   * @param Stream is the stream where the object need to be written into
   * @param OnlyChanged is the flag that determines if the object is changed
   * @param XRef is the Xreference table of this object
   *
   * @return Count bytes written into the Stream
   *)

function TgtPDIndirectRef.SaveToStream(Stream: TgtStream; OnlyChanged: Boolean;
  XRef: TgtObject): Cardinal;
//var
//  LXRefEntry: TgtPDXRefEntry;
begin
  Result := 0;
  if IsChanged or not OnlyChanged then
  begin
//    if ObjNumber <> $FFFFFFFF then
//    begin
//      LXRefEntry := TgtPDXRefEntry.Create;
//      try
//        LXRefEntry.Offset := Stream.GetPosition;
//        LXRefEntry.GenNum := GenNumber;
//        LXRefEntry.EntryType := xeUnCompressed;
//        TgtPDXRef(XRef).Entries[ObjNumber] := LXRefEntry;
//      finally
//        LXRefEntry.Free;
//      end;
    GenNumber := 0;
    Result := Result + Stream.Write(IntegerToString(ObjNumber) + ' ' +
      IntegerToString(GenNumber) + ' ' + PDF_R);
//    end;
  end;
end;

end.
