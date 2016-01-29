{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Base                    }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

unit PDBoolean;

interface

uses
  Classes, gtObject, PDBaseObject, Stream;

type

  (**
   * TgtPDBoolean
   *    This class represents the Boolean Object in the PDF. A boolean object is
   * f, false, t, true.
   *)
  TgtPDBoolean = class(TgtPDBaseObject)
  private
    FValue: Boolean;
  public
    constructor Create(AValue: Boolean; AObjNumber, AGenNumber:
      Cardinal); overload;
    constructor Create(AValue: Boolean); overload;
    destructor Destroy; override;
    function Clone: TgtPDBaseObject; override;
    function IsBoolean: Boolean; override;
    function SaveToStream(Stream: TgtStream; OnlyChanged: Boolean;
      XRef: TgtObject): Cardinal; override;
    procedure SetBool(ABoolValue: Boolean);
    function GetValue: Boolean;
    procedure Assign(ASourceObj: TgtPDBaseObject); override;

    property Value: Boolean read GetValue write SetBool;
  end;

implementation

uses
  gtConstants, PDXRef, PDXRefEntry, gtMethods, PDBaseExceptions;

{ TgtPDBoolean }

  (**
   * This function will assign a different copy of the Source object to current
   *     object
   *
   * @param ASourceObj is the object from where the copy need to be created
   *)

procedure TgtPDBoolean.Assign(ASourceObj: TgtPDBaseObject);
begin
  FValue := TgtPDBoolean(ASourceObj).FValue;
end;

  (**
   * This function will return a clone of the current object
   *
   * @return TgtPDBaseObject is the boolean object with the same properties of
   *          current object
   *)

function TgtPDBoolean.Clone: TgtPDBaseObject;
begin
  Result := TgtPDBoolean.Create(FValue, FObjNumber, FGenNumber);
end;

  (**
   * Constructor
   *
   * @param AValue The value with which the boolean object to be created
   * @param AObjNumber is object number to be set for this boolean object
   * @param AGenNumber is generation number to be set for this boolean object
   *)

constructor TgtPDBoolean.Create(AValue: Boolean; AObjNumber,
  AGenNumber: Cardinal);
begin
  FObjNumber := AObjNumber;
  FGenNumber := AGenNumber;

  FIsChanged := False;

  FValue := AValue;
end;

  (**
   * Constructor
   *
   * @param AValue The value with which the boolean object to be created
   *)

constructor TgtPDBoolean.Create(AValue: Boolean);
begin
  FValue := AValue;

  FIsChanged := False;

  FObjNumber := $FFFFFFFF;
  FGenNumber := $FFFFFFFF;
end;

destructor TgtPDBoolean.Destroy;
begin

  inherited;
end;

function TgtPDBoolean.GetValue: Boolean;
begin
  Result := FValue;
end;

(**
   * Ture if the object is Boolean
   *
   * @return true if the object is Boolean object
   *)

function TgtPDBoolean.IsBoolean: Boolean;
begin
  Result := True;
end;

  (**
   * This function will writes the Boolean object into the stream provided
   *
   * @param Stream is the stream where the object need to be written into
   * @param OnlyChanged is the flag that determines if the object is changed
   * @param XRef is the Xreference table of this object
   *
   * @return Count bytes written into the Stream
   *)

function TgtPDBoolean.SaveToStream(Stream: TgtStream; OnlyChanged: Boolean;
  XRef: TgtObject): Cardinal;
var
  LXRefEntry: TgtPDXRefEntry;
begin
  if (Stream = nil) then
  begin
    raise ExInvalidStream.Create(ErrInvalidStream);
  end;

  Result := 0;
  if (OnlyChanged and IsChanged) or not OnlyChanged then
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
    if FValue then Result := Result + Stream.Write(PDF_TRUE)
    else Result := Result + Stream.Write(PDF_FALSE);

    if ObjNumber <> $FFFFFFFF then
      Result := Result + Stream.Write(CRLF + PDF_ENDOBJ + CRLF);

  end;
end;

(**
   * Sets the boolean value for this object
   *
   * @param ABoolValue value of this object
   *)

procedure TgtPDBoolean.SetBool(ABoolValue: Boolean);
begin
  FValue := ABoolValue;
end;

end.
