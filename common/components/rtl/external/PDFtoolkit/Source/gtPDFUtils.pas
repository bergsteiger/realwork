{ ********************************************************************* }
{                                                                       }
{                       Gnostice PDFtoolkit v3.0                        }
{                       Copyright (c) 2002-2009                         }
{          Gnostice Information Technologies Private Limited            }
{                       http://www.gnostice.com                         }
{                                                                       }
{ ********************************************************************* }
{$I gtDefines.inc}
unit gtPDFUtils;

interface

uses
  gtPDFConsts, SysUtils, Math, SyncObjs, forms, Windows, Graphics;

var
  LockDecimalSep: TCriticalSection;
type

  TgtPoint= class
  private
    FX, FY: Double;
  public
    property X : Double read FX write FX;
    property Y : Double read FY write FY;
  end;

  TRoundToRange = -37..37;

  TgtRect = record
    Left,
      Top,
      Right,
      Bottom: Double;
  end;

  EPDFException = class(Exception);
  EUnsupportedImage = class(Exception);
  EUnsupportedImageError = class(EPDFException);

//Makes a Rect with the four params
function gtRect(Left, Top, Right, Bottom: Double): TgtRect; overload;
//Multiplies all values of the rect with the value <AFactor>
function gtRect(ARect: TgtRect; AFactor: Double): TgtRect; overload;
//Multilies the X values of the rect with <AXFactor> and Y values with <AYFactor>
function gtRect(ARect: TgtRect; AXFactor, AYFactor: Double): TgtRect; overload;

//String handling Routines
function RightStr(const AText: AnsiString; const ACount: Integer): AnsiString;
function LeftStr(const AText: AnsiString; const ACount: Integer): AnsiString;

//Converts points to pixel
function PointsToPixels(X: Extended): Extended;
function PixelsToPoints(X: Extended): Extended;
//Checks if a string is Hex
function IsHex(AString: string): Boolean;
function UnicodeHexToString(const Value: string): WideString;
function HexToByteValue(AHex: string; out AByte: Byte): Integer;
function HexToByteString(AHex: string): string;
function StrToFloatLocale(AString: string): Double;
function FloatToStrLocale(Value: Double):string;

function ReplaceString(const S, OldPattern, NewPattern: WideString): WideString;
function TextSize(const Text: string; AFont: TFont): TSize;

function DegreesToRadians(Degrees: Extended): Extended;
function RGBToColor(R, G, B: Byte): TColor;
function AnsiContainsText(const AText, ASubText: string): Boolean;
function PosExx(const SubStr, S: string; Offset: Cardinal = 1): Integer;
function Csc(const X: Extended): Extended;
function Cosecant(const X: Extended): Extended;
function TryStrToInt(const S: string; out Value: Integer): Boolean;
function PointsEqual(const P1, P2: TPoint): Boolean;
function InRange(const AValue, AMin, AMax: Integer): Boolean;
function SimpleRoundTo(const AValue: Double; const ADigit: TRoundToRange = -2): Double;
function AnsiLeftStr(const AText: AnsiString; const ACount: Integer): AnsiString;

var
  CPixelsPerInch: Double;
  CPixelToPoints: Double;
  CPixelToInches: Double;
  CPixelToMM: Double;
  CPixelToTwips: Double;
  CPointsToPixels: Double;
  CPointsToInches: Double;
  CPointsToMM: Double;
  CPointsToTwips: Double;
  CInchesToPixels: Double;
  CInchesToPoints: Double;
  CInchesToMM: Double;
  CInchesToTwips: Double;
  CMMToPixels: Double;
  CMMToPoints: Double;
  CMMToInches: Double;
  CMMToTwips: Double;
  CTwipsToPixels: Double;
  CTwipsToPoints: Double;
  CTwipsToInches: Double;
  CTwipsToMM: Double;
implementation

function AnsiLeftStr(const AText: AnsiString; const ACount: Integer): AnsiString;
begin
  Result := Copy(WideString(AText), 1, ACount);
end;

function SimpleRoundTo(const AValue: Double; const ADigit: TRoundToRange = -2): Double;
var
  LFactor: Double;
begin
  LFactor := IntPower(10, ADigit);
  if AValue < 0 then
    Result := Trunc((AValue / LFactor) - 0.5) * LFactor
  else
    Result := Trunc((AValue / LFactor) + 0.5) * LFactor;
end;

function InRange(const AValue, AMin, AMax: Integer): Boolean;
var
  A,B: Boolean;
begin
  A := (AValue >= AMin);
  B := (AValue <= AMax);
  Result := B and A;
end;

function PointsEqual(const P1, P2: TPoint): Boolean;
begin
  Result := (P1.X = P2.X) and (P1.Y = P2.Y);
end;

function Cosecant(const X: Extended): Extended;
{ Cosecant := 1 / Sin(X) }
asm
        FLD   X
        FSIN
        FLD1
        FDIVRP
        FWAIT
end;

function TryStrToInt(const S: string; out Value: Integer): Boolean;
var
  E: Integer;
begin
  Val(S, Value, E);
  Result := E = 0;
end;

function PosExx(const SubStr, S: string; Offset: Cardinal = 1): Integer;
var
  I,X: Integer;
  Len, LenSubStr: Integer;
begin
  if Offset = 1 then
    Result := Pos(SubStr, S)
  else
  begin
    I := Offset;
    LenSubStr := Length(SubStr);
    Len := Length(S) - LenSubStr + 1;
    while I <= Len do
    begin
      if S[I] = SubStr[1] then
      begin
        X := 1;
        while (X < LenSubStr) and (S[I + X] = SubStr[X + 1]) do
          Inc(X);
        if (X = LenSubStr) then
        begin
          Result := I;
          exit;
        end;
      end;
      Inc(I);
    end;
    Result := 0;
  end;
end;

function Csc(const X: Extended): Extended;
begin
  Result := Cosecant(X);
end;

function ReplaceString(const S, OldPattern, NewPattern: WideString): WideString;
var
  I: Integer;
  SearchStr, Str, OldPat: WideString;
begin
  Result := '';
  if S <> '' then
    if IsDBCSLeadByte(Byte(S[1])) then
    begin
      SearchStr := AnsiUpperCase(S);
      OldPat := AnsiUpperCase(OldPattern);
      Str := S;
      Result := '';
      while SearchStr <> '' do
      begin
        I := AnsiPos(OldPat, SearchStr);
        if I = 0 then
        begin
          Result := Result + Str;
          Break;
        end;
        Result := Result + Copy(Str, 1, I - 1) + NewPattern;
        Str := Copy(Str, I + Length(OldPattern), MaxInt);
        SearchStr := Copy(SearchStr, I + Length(OldPat), MaxInt);
      end;
    end
    else
    begin
      SearchStr := AnsiUpperCase(S);
      OldPat := AnsiUpperCase(OldPattern);
      Str := S;
      Result := '';
      while SearchStr <> '' do
      begin
        I := AnsiPos(OldPat, SearchStr);
        if I = 0 then
        begin
          Result := Result + Str;
          Break;
        end;
        Result := Result + Copy(Str, 1, I - 1) + NewPattern;
        Str := Copy(Str, I + Length(OldPattern), MaxInt);
        SearchStr := Copy(SearchStr, I + Length(OldPat), MaxInt);
      end;
    end;
end;

function TextSize(const Text: string; AFont: TFont): TSize;
var
  DC: HDC;
  SaveFont: HFont;
  LSize: Tsize;
begin
  DC := GetDC(0);
  SaveFont := SelectObject(DC, AFont.Handle);
  GetTextExtentPoint32A(DC, PChar(Text), Length(Text), LSize);
  SelectObject(DC, SaveFont);
  ReleaseDC(0, DC);
  Result := LSize;
end;

function gtRect(Left, Top, Right, Bottom: Double): TgtRect;
begin
  Result.Left := Left;
  Result.Top := Top;
  Result.Right := Right;
  Result.Bottom := Bottom;
end;

function gtRect(ARect: TgtRect; AFactor: Double): TgtRect;
begin
  with ARect do
  begin
    Result.Left := Left * AFactor;
    Result.Top := Top * AFactor;
    Result.Right := Right * AFactor;
    Result.Bottom := Bottom * AFactor;
  end;
end;

function gtRect(ARect: TgtRect; AXFactor, AYFactor: Double): TgtRect;
begin
  with ARect do
  begin
    Result.Left := Left * AXFactor;
    Result.Top := Top * AYFactor;
    Result.Right := Right * AXFactor;
    Result.Bottom := Bottom * AYFactor;
  end;
end;

function RightStr(const AText: AnsiString; const ACount: Integer): AnsiString;
begin
  Result := Copy(WideString(AText), Length(WideString(AText)) + 1 - ACount, ACount);
end;

function LeftStr(const AText: AnsiString; const ACount: Integer): AnsiString;
begin
  Result := Copy(WideString(AText), 1, ACount);
end;

function PointsToPixels(X: Extended): Extended;
begin
  Result := X * CPointsToPixels;
end;

function IsHex(AString: string): Boolean;
var
  LI: Integer;
  LString: string;
begin
  Result := False;
  LString := UpperCase(AString);
  for LI := 1 to Length(AString) do
  begin
    if not (LString[LI] in ['0'..'9', 'A'..'F']) then
      Exit;
  end;
  Result := True;
end;

function UnicodeHexToString(const Value: string): WideString;
var
  LSourceStr: string;
  LI, LJ: Integer;
  LByte1, LByte2, LTempByte: string;
  LoByte, HiByte: Byte;
  ByteArr: array of Byte;
begin
  //if LeftStr(Value, 4) = 'FEFF' then
  if LeftStr(UpperCase(Value), 4) = 'FEFF' then
  begin
    LI := 1;
    LJ := 0;
    LSourceStr := Copy(Value, 5, 999);
    SetLength(ByteArr, (Length(LSourceStr) div 2));
    while (LI < Length(LSourceStr)) do
    begin
      if LSourceStr[LI] = '.' then
      begin
        ByteArr[LJ] := 46;
        ByteArr[LJ + 1] := 0;
        Inc(LJ, 2);
        Inc(LI);
      end;
      LTempByte := Copy(LSourceStr, LI, 4);
      if UpperCase(LTempByte) = 'FEFF' then
        Inc(LI, 4);
      LByte1 := Copy(LSourceStr, LI, 2);
      HexToByteValue(LByte1, LoByte);
      Inc(LI, 2);

      LByte2 := Copy(LSourceStr, LI, 2);
      HexToByteValue(LByte2, HiByte);
      Inc(LI, 2);

      ByteArr[LJ] := HiByte;
      ByteArr[LJ + 1] := LoByte;
      Inc(LJ, 2);
    end;
    Result := WideString(ByteArr);
  end
  else Result := HexToByteString(Value);
end;

function HexToByteValue(AHex: string; out AByte: Byte): Integer;
const
  Convert: array['0'..'f'] of SmallInt =
  (0, 1, 2, 3, 4, 5, 6, 7, 8, 9, -1, -1, -1, -1, -1, -1,
    -1, 10, 11, 12, 13, 14, 15, -1, -1, -1, -1, -1, -1, -1, -1, -1,
    -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
    -1, 10, 11, 12, 13, 14, 15);
var
  LI, LJ: Integer;
begin
  Result := -1;
  AByte := 0;
  LJ := 0;

  if not IsHex(AHex) then Exit;

  for LI := Length(AHex) downto 1 do
  begin
    AByte := AByte + Convert[AHex[LI]] * Trunc(Power(16, LJ));
    Inc(LJ);
  end;
  Result := 0;
end;

function HexToByteString(AHex: string): string;
var
  LI: Integer;
  LS: string;
  LByte: Byte;
begin
  SetLength(LS, 2);
  LI := 0;
  while (LI < Length(AHex)) do
  begin
    while not (IsHex(AHex[LI])) do
      Inc(LI);

    LS[1] := AHex[LI];

    Inc(LI);
    while not (IsHex(AHex[LI])) do
      Inc(LI);

    LS[2] := AHex[LI];
    Inc(LI);
    if (HexToByteValue(PChar(LS), LByte) <> 0) then
      Exit
    else
      Result := Result + AnsiChar(LByte);
  end;
end;

function StrToFloatLocale(AString: string): Double;
var
  LDesSep: Char;
begin
  LDesSep := DecimalSeparator;
  LockDecimalSep.Acquire;
  try
    DecimalSeparator := '.';
    Result := StrToFloat(AString);
    DecimalSeparator := LDesSep;
  finally
    LockDecimalSep.Release;
  end;
end;

function FloatToStrLocale(Value: Double):string;
var
  LDesSep: Char;
begin
  LDesSep := DecimalSeparator;
  LockDecimalSep.Acquire;
  try
    DecimalSeparator := '.';
    Result := FloatToStr(Value);
    DecimalSeparator := LDesSep;
  finally
    LockDecimalSep.Release;
  end;
end;

function PixelsToPoints(X: Extended): Extended;
begin
  Result := X / CPixelsPerInch * CInchesToPoints;
end;

function DegreesToRadians(Degrees: Extended): Extended;
begin
  Result := Degrees * (PI / 180);
end;

function RGBToColor(R, G, B: Byte): TColor;
begin
  Result := B shl 16 or
    G shl 8 or
    R;
end;

function AnsiContainsText(const AText, ASubText: string): Boolean;
begin
  Result := AnsiPos(AnsiUppercase(ASubText), AnsiUppercase(AText)) > 0;
end;

initialization
  CPixelsPerInch := Screen.PixelsPerInch;
  CPixelToPoints := 72 / CPixelsPerInch;
  CPixelToInches := 1 / CPixelsPerInch;
  CPixelToMM := 25.4 / CPixelsPerInch;
  CPixelToTwips := 15;
  CPointsToPixels := CPixelsPerInch / 72;
  CPointsToInches := 1 / 72;
  CPointsToMM := 25.4 / 72;
  CPointsToTwips := 20;
  CInchesToPixels := CPixelsPerInch;
  CInchesToPoints := 72;
  CInchesToMM := 25.4;
  CInchesToTwips := 1440;
  CMMToPixels := CPixelsPerInch / 25.4;
  CMMToPoints := 72 / 25.4;
  CMMToInches := 1 / 25.4;
  CMMToTwips := 1440 / 25.4;
  CTwipsToPixels := CPixelsPerInch / 1440;
  CTwipsToPoints := 0.05;
  CTwipsToInches := 1 / 1440;
  CTwipsToMM := 25.4 / 1440;

  LockDecimalSep := TCriticalSection.Create;

finalization
  LockDecimalSep.Free;


end.
