{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Base                    }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

unit PDReal;

interface

uses
  gtObject, PDBaseObject, Stream;

type
  (**
   * TgtPDReal
   *    This class represents the Real Object in the PDF.
   *)

  TgtPDReal = class(TgtPDBaseObject)
  private
    FValue: Extended;
  public
    constructor Create(AValue: Extended; AObjNumber, AGenNumber:
      Cardinal); overload;
    constructor Create(AValue: Extended); overload;
    destructor Destroy; override;

    function IsReal: Boolean; override;
    function Clone: TgtPDBaseObject; override;
    function SaveToStream(Stream: TgtStream; OnlyChanged: Boolean;
      XRef: TgtObject): Cardinal; override;

    procedure Assign(ASourceObj: TgtPDBaseObject); override;
    function GetValue: Extended;
    procedure SetValue(const Value: Extended);

    property Value: Extended read GetValue write SetValue;
  end;

implementation

uses
  gtMethods, PDXRef, PDXRefEntry, gtConstants;

{ TgtPDReal }

  (**
   * This function will assign a different copy of the Source object to current
   *     object
   *
   * @param ASourceObj is the object from where the copy need to be created
   *)

procedure TgtPDReal.Assign(ASourceObj: TgtPDBaseObject);
begin
  inherited;
  FValue := TgtPDReal(ASourceObj).FValue;
end;

  (**
   * This function will return a clone of the current object
   *
   * @return TgtPDBaseObject is the Real object with the same properties of
   *         current object
   *)

function TgtPDReal.Clone: TgtPDBaseObject;
begin
  Result := TgtPDReal.Create(FValue, FObjNumber, FGenNumber);
end;

  (**
   * Constructor
   *
   * @param AValue is the real value with which this object will created
   * @param AObjNumber is the object number with which this object will created
   * @param AGenNumber is the object generation with which this object will created
   *)

constructor TgtPDReal.Create(AValue: Extended; AObjNumber,
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
   * @param AValue is the Real value with which this object will created
   *)

constructor TgtPDReal.Create(AValue: Extended);
begin
  FValue := AValue;
  FObjNumber := $FFFFFFFF;
  FGenNumber := $FFFFFFFF;
  FIsChanged := False;
end;

destructor TgtPDReal.Destroy;
begin

  inherited;
end;

function TgtPDReal.GetValue: Extended;
begin
  Result := FValue;
end;

(**
   * Ture if the object is Real
   *
   * @return true if the object is Real object
   *)

function TgtPDReal.IsReal: Boolean;
begin
  Result := True;
end;

  (**
   * This function will writes the Real object into the stream provided
   *
   * @param Stream is the stream where the object need to be written into
   * @param OnlyChanged is the flag that determines if the object is changed
   * @param XRef is the Xreference table of this object
   *
   * @return Count bytes written into the Stream
   *)

function TgtPDReal.SaveToStream(Stream: TgtStream; OnlyChanged: Boolean;
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
    Result := Result + Stream.Write(FloatToStringLocale(FValue));

    if ObjNumber <> $FFFFFFFF then
      Result := Result + Stream.Write(CRLF + PDF_ENDOBJ + CRLF);
  end;
end;

procedure TgtPDReal.SetValue(const Value: Extended);
begin
  FValue := Value;
end;

end.
