unit PDType1;

interface

uses
  Classes, SysUtils, PDFontBase, PDEncoding, gtConstants;

type
  TPDType1 = class(TPDFontBase)
  private
//    FIsParsed: Boolean;
    FEncoding: TgtEncodingArray;
//    FName: AnsiString;
    //function GetEncoding: TgtEncodingArray;
    function GetName: AnsiString;
    //function GetEncoding(Index: Integer): AnsiString;
    // Returns Next Line Position
//    function GetNextLinePos(ACurrLinePos: Int64): Int64; // change to return AnsiString also
//    procedure Parse;
  public
    constructor Create(Stream: TStream; AFreeFileData: Boolean);
    destructor Destroy; override;

    property Name: AnsiString read GetName;
    //property Encoding[Index: Integer]: AnsiString read GetEncoding;
  end;

implementation

{ TPDType1 }

constructor TPDType1.Create(Stream: TStream; AFreeFileData: Boolean);
//var
//  I: Integer;
begin
(*
  FStream := Stream;
  for I := 0 to 256 - 1 do
    FEncoding[I] := Empty;
  FName := '';
  FFreeFileData := AFreeFileData;
  FIsParsed := False;
*)
end;

destructor TPDType1.Destroy;
begin

  inherited;
end;
(*
function TPDType1.GetEncoding: TgtEncodingArray;
begin
  if not FIsParsed then
    Parse;
  Result := FEncoding;
end;


function TPDType1.GetEncoding(Index: Integer): AnsiString;
begin
  if (Index in [0..255]) then
    Result := FEncoding[Index]
  else
    raise Exception.Create('Encoding - Index out of bounds (' + IntToStr(Index) + ')');
end;
*)
function TPDType1.GetName: AnsiString;
begin
(*
  if not FIsParsed then
    Parse;
  Result := FName;
 *)
end;
(*
function TPDType1.GetNextLinePos(ACurrLinePos: Int64): Int64;
//var
//  LBuf: AnsiString;
//  LBufIndex: Byte;
//  LStreamLength: Int64;
//  LPos: Integer;
begin

  LBufIndex := 0;
  LPos := ACurrLinePos;
  LStreamLength := FStream.Size;
  FStream.Seek(ACurrLinePos, soFromBeginning);
  FStream.Read(LBuf, 256);
  while ((LPos < LStreamLength) and (LBuf[LPos] <> LINEFEED) and
    (LBuf[LPos] <> CARRIAGERETURN)) do
  begin
    Inc(LPos);
    Inc(LBufIndex);
    if LBufIndex > 255 then
    begin
      LBuf := '';
      LBufIndex := 0;
      FStream.Read(LBuf, 256);
    end;
  end;
  Inc(LPos);
  if LPos > LStreamLength then
    Result := 0
  else
    Result := LPos;

end;
*)

(*
procedure TPDType1.Parse;
//var
//  I: Integer;
begin

  I := 1;
//  while((I <= 100) and Assigned(FStream)) do  // Inc I, dnt 4get
  begin
    // Get Font Name
//    if ((FName = '') and ) then

  end;

end;
*)

end.
