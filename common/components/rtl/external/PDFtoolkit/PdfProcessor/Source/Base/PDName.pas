{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Base                    }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

unit PDName;

interface

uses
  gtObject, PDBaseObject, Stream;

type

  (**
   * TgtPDName
   *    This class represents the Name Object in the PDF.
   *)

  TgtPDName = class(TgtPDBaseObject)
  private
    FValue: AnsiString;

  public
    constructor Create(AValue: AnsiString; AObjNumber: Cardinal;
      AGenNumber: Cardinal); overload;
    constructor Create(AValue: AnsiString); overload;
    destructor Destroy; override;

    function IsName: Boolean; override;
    function IsName(const AName: AnsiString): Boolean; override;
    function Clone: TgtPDBaseObject; override;
    function SaveToStream(Stream: TgtStream; OnlyChanged: Boolean;
      XRef: TgtObject): Cardinal; override;

    procedure Assign(ASourceObj: TgtPDBaseObject); override;
    procedure SetName(AName: AnsiString);
    function GetValue: AnsiString;

    property Value: AnsiString read GetValue write SetName;
  end;

implementation

uses
  PDXRef, PDXRefEntry, gtConstants, gtMethods
{$IFNDEF DOTNET}, SysUtils{$ENDIF};

{ TgtPDName }

  (**
   * This function will assign a different copy of the Source object to current
   *     object
   *
   * @param ASourceObj is the object from where the copy need to be created
   *)


procedure TgtPDName.Assign(ASourceObj: TgtPDBaseObject);
begin
  inherited;
  FValue := TgtPDName(ASourceObj).FValue;
end;

  (**
   * This function will return a clone of the current object
   *
   * @return TgtPDBaseObject is the Name object with the same properties of
   *         current object
   *)

function TgtPDName.Clone: TgtPDBaseObject;
begin
  Result := TgtPDName.Create(FValue, ObjNumber, GenNumber);
  Result.IsChanged := IsChanged;
end;

  (**
   * Constructor
   *
   * @param AValue is the Name value(AnsiString) with which this object will created
   * @param AObjNumber is the object number with which this object will created
   * @param AGenNumber is the object generation with which this object will created
   *)

constructor TgtPDName.Create(AValue: AnsiString; AObjNumber, AGenNumber: Cardinal);
begin
  FValue := AValue;
  FObjNumber := AObjNumber;
  FGenNumber := AGenNumber;

  FIsChanged := False;
end;

  (**
   * Constructor
   *
   * @param AValue is the Name value(AnsiString) with which this object will created
   *)

constructor TgtPDName.Create(AValue: AnsiString);
begin
  FValue := AValue;
  FObjNumber := $FFFFFFFF;
  FGenNumber := $FFFFFFFF;

  FIsChanged := False;
end;

destructor TgtPDName.Destroy;
begin

  inherited;
end;

function TgtPDName.GetValue: AnsiString;
begin
  Result := FValue;
end;

(**
   * True if the AName parameter is Name object
   *
   * @param AName is object that need to be checked for Name object
   *
   * @return True if the AName parameter is Name object
   *)

function TgtPDName.IsName(const AName: AnsiString): Boolean;
begin
  Result := False;
{$IFDEF DOTNET}
  if (System.AnsiString.Compare(AName, FValue, True) = 0) then
    Result := True
{$ELSE}
  if (CompareStr(AName, FValue) = 0) then
    Result := True
{$ENDIF}
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

function TgtPDName.SaveToStream(Stream: TgtStream; OnlyChanged: Boolean;
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

    Result := Result + Stream.Write('/' + FValue);

    if ObjNumber <> $FFFFFFFF then
      Result := Result + Stream.Write(CRLF + PDF_ENDOBJ + CRLF);
  end;
end;

  (**
   * Sets the Name value for this object
   *
   * @param AName is the Name value that need to be set for this object
   *)

procedure TgtPDName.SetName(AName: AnsiString);
begin
  FValue := AName;
end;

(**
   * True if this object is Name object
   *
   * @return True if this object is Name object
   *)

function TgtPDName.IsName: Boolean;
begin
  Result := True;
end;

end.
