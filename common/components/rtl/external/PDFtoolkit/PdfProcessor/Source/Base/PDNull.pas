{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Base                    }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

unit PDNull;

interface

uses
  gtObject, PDBaseObject, Stream;

type
  (**
   * TgtPDNull
   *    This class represents the Null Object in the PDF.
   *)
  TgtPDNull = class(TgtPDBaseObject)
  public
    constructor Create; overload;
    constructor Create(AObjNumber: Cardinal; AGenNumber: Cardinal); overload;
    destructor Destroy; override;
    function IsNull: Boolean; override;
    function Clone: TgtPDBaseObject; override;
    function SaveToStream(Stream: TgtStream; OnlyChanged: Boolean;
      XRef: TgtObject): Cardinal; override;

    procedure Assign(ASourceObj: TgtPDBaseObject); override;
  end;

implementation

uses
  gtConstants, gtMethods, PDXRefEntry, PDXRef;

{ TgtPDNull }

procedure TgtPDNull.Assign(ASourceObj: TgtPDBaseObject);
begin
  inherited;

end;

  (**
   * This function will return a clone of the current object
   *
   * @return TgtPDBaseObject is the Null object with the same properties of
   *         current object
   *)

function TgtPDNull.Clone: TgtPDBaseObject;
begin
  Result := TgtPDNull.Create;
end;

constructor TgtPDNull.Create(AObjNumber, AGenNumber: Cardinal);
begin
  FObjNumber := AObjNumber;
  FGenNumber := AGenNumber;

  FIsChanged := False;
end;

destructor TgtPDNull.Destroy;
begin

  inherited;
end;

constructor TgtPDNull.Create;
begin
  FIsChanged := False;

  FObjNumber := $FFFFFFFF;
  FGenNumber := $FFFFFFFF;
end;

(**
   * Ture if the object is Null
   *
   * @return true if the object is Null object
   *)

function TgtPDNull.IsNull: Boolean;
begin
  Result := True;
end;

  (**
   * This function will writes the Null object into the stream provided
   *
   * @param Stream is the stream where the object need to be written into
   * @param OnlyChanged is the flag that determines if the object is changed
   * @param XRef is the Xreference table of this object
   *
   * @return Count bytes written into the Stream
   *)

function TgtPDNull.SaveToStream(Stream: TgtStream; OnlyChanged: Boolean;
  XRef: TgtObject): Cardinal;
var
  LXRefEntry: TgtPDXRefEntry;
begin
  Result := 0;
  if IsChanged or not OnlyChanged then
  begin
    if ObjNumber <> $FFFFFFFF then
    begin
      TgtPDXRef(XRef).LastObjectNumber := TgtPDXRef(XRef).LastObjectNumber + 1;
      ObjNumber := TgtPDXRef(XRef).LastObjectNumber;
      GenNumber := 0;

      LXRefEntry := TgtPDXRefEntry.Create;
      try
        LXRefEntry.Offset := Stream.GetPosition;
        LXRefEntry.GenNum := GenNumber;
        LXRefEntry.EntryType := xeUnCompressed;
        TgtPDXRef(XRef).Entries[ObjNumber] := LXRefEntry;
      finally
        LXRefEntry.Free;
      end;

      Result := Result + Stream.Write(IntegerToString(ObjNumber) + ' ' +
        IntegerToString(GenNumber) + ' ' + PDF_OBJ + CRLF);
    end;

    IsWritten := True;

    Result := Result + Stream.Write('null');

    if ObjNumber <> $FFFFFFFF then
      Result := Result + Stream.Write(CRLF + PDF_ENDOBJ + CRLF);
  end;
end;

end.
