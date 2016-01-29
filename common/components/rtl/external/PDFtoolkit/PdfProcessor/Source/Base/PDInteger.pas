{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Base                    }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

unit PDInteger;

interface

uses
  gtObject, PDBaseObject, Stream;

type
  (**
   * TgtPDInteger
   *    This class represents the Integer Object in the PDF.
   *)
  TgtPDInteger = class(TgtPDBaseObject)
  private
    FValue: Integer;
  public
    constructor Create(AValue: Integer; AObjNumber, AGenNumber:
      Cardinal); overload;
    constructor Create(AValue: Integer); overload;
    destructor Destroy; override;
    function IsInteger: Boolean; override;
    function Clone: TgtPDBaseObject; override;
    function SaveToStream(Stream: TgtStream; OnlyChanged: Boolean;
      XRef: TgtObject): Cardinal; override;
    procedure Assign(ASourceObj: TgtPDBaseObject); override;
    function GetValue: Integer;
    procedure SetValue(const Value: Integer);

    property Value: Integer read GetValue write SetValue;
  end;

implementation

uses
  gtMethods, PDXRef, PDXRefEntry, gtConstants;

{ TgtPDInteger }

  (**
   * This function will assign a different copy of the Source object to current
   *     object
   *
   * @param ASourceObj is the object from where the copy need to be created
   *)

procedure TgtPDInteger.Assign(ASourceObj: TgtPDBaseObject);
begin
  inherited;
  FValue := TgtPDInteger(ASourceObj).FValue;
end;

  (**
   * This function will return a clone of the current object
   *
   * @return TgtPDBaseObject is the Integer object with the same properties of
   *         current object
   *)

function TgtPDInteger.Clone: TgtPDBaseObject;
begin
  Result := TgtPDInteger.Create(FValue, FObjNumber, FGenNumber);
end;

  (**
   * Constructor
   *
   * @param AValue is the integer value with which this object will created
   * @param AObjNumber is the object number with which this object will created
   * @param AGenNumber is the object generation with which this object will created
   *)

constructor TgtPDInteger.Create(AValue: Integer; AObjNumber,
  AGenNumber: Cardinal);
begin
  FValue := AValue;
  FObjNumber := AObjNumber;
  FGenNumber := AGenNumber;

  FIsChanged := False;
end;

  (**
   * Constructor
   *
   * @param AValue is the integer value with which this object will created
   *)

constructor TgtPDInteger.Create(AValue: Integer);
begin
  FValue := AValue;
  FObjNumber := $FFFFFFFF;
  FGenNumber := $FFFFFFFF;

  FIsChanged := False;
end;

destructor TgtPDInteger.Destroy;
begin

  inherited;
end;

function TgtPDInteger.GetValue: Integer;
begin
  Result := FValue;
end;

(**
   * Ture if the object is Integer
   *
   * @return true if the object is Integer object
   *)

function TgtPDInteger.IsInteger: Boolean;
begin
  Result := True;
end;

  (**
   * This function will writes the Integer object into the stream provided
   *
   * @param Stream is the stream where the object need to be written into
   * @param OnlyChanged is the flag that determines if the object is changed
   * @param XRef is the Xreference table of this object
   *
   * @return Count bytes written into the Stream
   *)

function TgtPDInteger.SaveToStream(Stream: TgtStream; OnlyChanged: Boolean;
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

    Result := Result + Stream.Write(IntegerToString(FValue));

    if ObjNumber <> $FFFFFFFF then
      Result := Result + Stream.Write(CRLF + PDF_ENDOBJ + CRLF);
  end;
end;

procedure TgtPDInteger.SetValue(const Value: Integer);
begin
  FValue := Value;
end;

end.
