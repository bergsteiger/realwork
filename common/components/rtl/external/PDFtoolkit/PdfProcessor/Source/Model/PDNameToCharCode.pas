unit PDNameToCharCode;

interface

uses
  gtObject, gtTypes;

type
  NameToCharCodeEntry = record
    Name: AnsiString;
    C: TgtCharCode;
  end;

  TgtPDNameToCharCode = class
  public
    constructor Create;
    destructor Destroy; override;

    procedure Add(const Name: AnsiString; C: TgtCharCode);
    function LookUp(const Name: AnsiString): TgtCharCode;
  private

    Tab: array of NameToCharCodeEntry;
    Size: Integer;
    Len: Integer;

//    function Hash(const Name: AnsiString): Integer;
  end;

implementation

{ TgtPDNameToCharCode }

procedure TgtPDNameToCharCode.Add(const Name: AnsiString; C: TgtCharCode);
//var
//  OldTab: array of NameToCharCodeEntry;
//  H, I, OldSize: Integer;
begin
  //Expand the table if necessary
//  if (Len >= Size / 2) then
//  begin
//    OldSize := Size;
//    SetLength(OldTab, Size);
//    for I := 0 to Size - 1 do
//      OldTab[I] := Tab[I];
//    Size := 2 * Size + 1;
//    Finalize(Tab);
//    SetLength(Tab, Size);
//    for I := 0 to OldSize - 1 do
//    begin
//      if OldTab[I].Name <> '' then
//      begin
//        H := Hash(OldTab[i].Name);
//        while Tab[H].Name <> '' do
//
//
//      end;
//    end;
//
//  end;

end;

constructor TgtPDNameToCharCode.Create;
//var
//  I: Integer;
begin
  Size := 31;
  Len := 0;
  SetLength(Tab, Size);
end;

destructor TgtPDNameToCharCode.Destroy;
begin
  SetLength(Tab, 0);
  inherited;
end;

(*
function TgtPDNameToCharCode.Hash(const Name: AnsiString): Integer;
var
  Len, I: Integer;
begin
  Result := 0;
  Len := Length(Name);

  for I := 0 to Len - 1 do
  begin
    Result := (Result * 17) + (Ord(Name[I + 1]) and $FF);
  end;
  Result := Result mod Size;
end;
*)

function TgtPDNameToCharCode.LookUp(const Name: AnsiString): TgtCharCode;
begin
  Result := 0;
end;

end.
