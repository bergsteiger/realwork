{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Base                    }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

unit PDString;

interface

uses
  Classes, gtObject, PDBaseObject, Stream, gtTypes, PDDictionary;

type
  (**
   * TgtPDString
   *    This class represents the AnsiString Object in the PDF.
   *)

  TgtPDString = class(TgtPDBaseObject)
  private
    FValue: AnsiString;
    FIsHex: Boolean;
    FDict: TgtPDDictionary;
    FParentDoc: TgtObject;

    function GetHexToString: AnsiString;
    procedure SetHexToString(AString: AnsiString);
  public
    constructor Create(AValue: AnsiString; AObjNumber, AGenNumber: Cardinal; IsHex: Boolean); overload;
    constructor Create(AValue: AnsiString; IsHex: Boolean); overload;
    constructor Create(AStringForHex: AnsiString); overload;
    destructor Destroy; override;
    function IsString: Boolean; override;
    function IsHexString: Boolean;
    function Clone: TgtPDBaseObject; override;

    function SaveToStream(Stream: TgtStream; OnlyChanged: Boolean;
      XRef: TgtObject): Cardinal; override;
    procedure Assign(ASourceObj: TgtPDBaseObject); override;
    procedure SetString(AString: AnsiString);
    function GetString: AnsiString;

    property Value: AnsiString read GetString write SetString;
    property HexToString: AnsiString read GetHexToString write SetHexToString;
  end;

implementation

uses
  gtMethods, PDXRef, PDXRefEntry, gtConstants, Encrypt, PDBaseDoc,
  EncryptionSettings, MemoryStream, PDConsts, CryptStream, PDName;

{ TgtPDString }

  (**
   * This function will assign a different copy of the Source object to current
   *     object
   *
   * @param ASourceObj is the object from where the copy need to be created
   *)

procedure TgtPDString.Assign(ASourceObj: TgtPDBaseObject);
begin
  inherited;
  FValue := TgtPDString(ASourceObj).FValue;
end;

  (**
   * This function will return a clone of the current object
   *
   * @return TgtPDBaseObject is the AnsiString object with the same properties of
   *         current object
   *)

function TgtPDString.Clone: TgtPDBaseObject;
begin
  Result := TgtPDString.Create(FValue, ObjNumber, GenNumber, FIsHex);
  Result.IsChanged := IsChanged;
  Result.IsWritten := IsWritten;
end;

constructor TgtPDString.Create(AStringForHex: AnsiString);
begin
  FValue := StringToHex(AStringForHex);
  FIsHex := True;
  FIsChanged := False;
  FObjNumber := $FFFFFFFF;
  FGenNumber := $FFFFFFFF;
end;

destructor TgtPDString.Destroy;
begin

  inherited;
end;

(**
   * Constructor
   *
   * @param AValue is the AnsiString value with which this object will created
   * @param AObjNumber is the object number with which this object will created
   * @param AGenNumber is the object generation with which this object will created
   * @param IsHex indecates whether AnsiString is a hex AnsiString or not
   *)

constructor TgtPDString.Create(AValue: AnsiString; AObjNumber,
  AGenNumber: Cardinal; IsHex: Boolean);
begin
  FObjNumber := AObjNumber;
  FGenNumber := AGenNumber;
  FIsChanged := False;
  FValue := AValue;
  FIsHex := IsHex;
end;

  (**
   * Constructor
   *
   * @param AValue is the AnsiString value with which this object will created
   * @param IsHex indecates whether AnsiString is a hex AnsiString or not
   *)

constructor TgtPDString.Create(AValue: AnsiString; IsHex: Boolean);
begin
  FValue := AValue;
  FIsChanged := False;
  FObjNumber := $FFFFFFFF;
  FGenNumber := $FFFFFFFF;
  FIsHex := IsHex;
end;

function TgtPDString.GetHexToString: AnsiString;
begin
  if FIsHex then
    Result := gtMethods.HexToString(FValue)
  else
    Result := FValue;
end;

function TgtPDString.GetString: AnsiString;
begin
  Result := FValue;
end;

(**
   * Checks whether the AnsiString ios hex AnsiString or not
   *
   * @return true if the AnsiString is hex AnsiString
   *)

function TgtPDString.IsHexString: Boolean;
begin
  Result := FIsHex;
end;

  (**
   * Checks whether the object is AnsiString object or not
   *
   * @return true if the object is AnsiString object
   *)

function TgtPDString.IsString: Boolean;
begin
  Result := True;
end;

  (**
   * This function will writes the AnsiString object into the stream provided
   *
   * @param Stream is the stream where the object need to be written into
   * @param OnlyChanged is the flag that determines if the object is changed
   * @param XRef is the Xreference table of this object
   *
   * @return Count bytes written into the Stream
   *)

function TgtPDString.SaveToStream(Stream: TgtStream; OnlyChanged: Boolean;
  XRef: TgtObject): Cardinal;
var
  LXRefEntry: TgtPDXRefEntry;
  LI: Integer;
  LValue: AnsiString;

begin
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

    if IsHexString then
    begin
      Result := Result + Stream.Write(AnsiChar(LESSTHANSIGN));
      if FValue <> '' then
      begin
        Result := Result + Stream.Write(FValue);
      end;
      Result := Result + Stream.Write(AnsiChar(GREATERTHANSIGN));
    end
    else
    begin
      Result := Result + Stream.Write(AnsiChar(LEFTPARENTHESIS));
      if FValue <> '' then
      begin
        LI := 1;
        LValue := '';
        while (LI <= Length(FValue)) do
        begin
          case FValue[LI] of
            AnsiChar(#8): LValue := LValue + '\b';
            AnsiChar(#9): LValue := LValue + '\t';
            AnsiChar(#10): LValue := LValue + '\n';
            AnsiChar(#12): LValue := LValue + '\f';
            AnsiChar(#13): LValue := LValue + '\r';
            AnsiChar(#40): LValue := LValue + '\(';
            AnsiChar(#41): LValue := LValue + '\)';
            AnsiChar(#92): LValue := LValue + '\\';
          else
            LValue := LValue + AnsiChar(FValue[LI]);
          end;
          Inc(LI);
        end;
        FValue := LValue;
        Result := Result + Stream.Write(FValue);
      end;
      Result := Result + Stream.Write(AnsiChar(RIGHTPARENTHESIS));
    end;
    IsWritten := True;
    if ObjNumber <> $FFFFFFFF then
      Result := Result + Stream.Write(CRLF + PDF_ENDOBJ + CRLF);
  end;
end;

  (**
   * Sets the AnsiString value for this object
   *
   * @param AString is the AnsiString value that need to be set for this object
   *)

procedure TgtPDString.SetHexToString(AString: AnsiString);
begin
  if FIsHex then
    FValue := StringToHex(AString)
  else
    FValue := AString;
end;

procedure TgtPDString.SetString(AString: AnsiString);
begin
  FValue := AString;
end;

end.
