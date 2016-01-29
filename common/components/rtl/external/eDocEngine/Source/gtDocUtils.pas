{ *************************************************************************** }
{ }
{ Gnostice eDocEngine }
{ }
{ Copyright © 2002-2011 Gnostice Information Technologies Private Limited }
{ http://www.gnostice.com }
{ }
{ *************************************************************************** }

{ ------------------------------------ }
{ Editor Options }
{ ------------------------------------ }
{ }
{ Tab Stops = 2 }
{ Use Tab Character = True }
{ }
{ ------------------------------------ }

{$I gtDefines.inc}
{$I gtDocDefines.inc}
unit gtDocUtils;

interface

uses Classes, Windows, SysUtils, Graphics, gtclasses3, gtDocConsts, gtCstDocEng;

type

  EInvalidPageNumber = class(Exception);
  EFileCreateError = class(Exception);
  EUnsupportedGraphics = class(Exception);
  EInvalidEngineState = class(Exception);

  TgtRotatedTextValues = record
    ATextWidth, ATextHeight, ATextWidthGap, ATextHeightGap, ATotalWidth,
      ATotalHeight, AposX, AposY: Integer;
  end;

function CalculateNativeUnitFactor(UnitType: TgtUnitType): Double;

function ReverseString(const AText: String): String;

(* Function to remove CRLF in FLines in text item. *)
function RemoveTerminalCRLF(AString: AnsiString): AnsiString;
function RemoveTerminalCRLFW(AString: String): String;
procedure Swap(var A, B: Double);
function GetFileNameFromPath(AString: String): String;
function GetJustifiedText(AString: String; AFont: TFont;
  AWidth: Double): String;

{ ------------------------------- RTF Engine ----------------------------------- }
function RevHexBytes(S: String): String;

{ ------------------------------- Text Rotation -------------------------------- }
procedure CalculateTextPositions(ACanvas: TCanvas; AAngleDegree: Integer;
  AText: String; var AgtRotatedTextValues: TgtRotatedTextValues);
procedure gtAngleText(AText: String; AAngleDegree: Integer; ABitmap: TBitmap;
  var PosX, PosY: Double);
procedure SetTextAngle(ACanvas: TCanvas; AAngleDegree: Integer);

{ ------------------------------- Image Rotation -------------------------------- }

function GetRotatedBitmap(ABitmap: TBitmap; var AX, AY: Double; Angle: Double;
  ABackgroundColor: TColor = ClWhite): TBitmap;

{ --------- Function to get FilePath from the String for HyperLink -------------- }

function GetFilePathFromText(AString: String; APos: Integer): Integer;

implementation

uses
  gtConsts3, gtUtils3;

{ ------------------------------------------------------------------------------ }

function CalculateNativeUnitFactor(UnitType: TgtUnitType): Double;
begin
  case UnitType of
    muInches:
      Result := CInchesToPoints * CPointsToPixels;
    muMM:
      Result := CMMToPoints * CPointsToPixels;
    muPoints:
      Result := CPointsToPixels;
    muTwips:
      Result := CTwipsToPoints * CPointsToPixels;
  else
    Result := 1;
  end;
end;

{ ------------------------------------------------------------------------------ }

function ReverseString(const AText: String): String;
var
  I: Integer;
  P: PChar;
begin
  SetLength(Result, Length(AText));
  P := PChar(Result);
  for I := Length(AText) downto 1 do
  begin
    P^ := AText[I];
    Inc(P);
  end;
end;

{ ------------------------------------------------------------------------------ }
function GetJustifiedText(AString: String; AFont: TFont;
  AWidth: Double): String;
var
  LStrings: TStringList;
  I, LTextLength, LTemp, LExtraSpace: Integer;
  LFlag: Boolean;
begin
  Result := '';
  if AString = '' then
    Exit;
  LFlag := True;
  LStrings := TStringList.Create;
  LTextLength := Length(AString);

  LTemp := 1;
  I := 1;

  while (I <= LTextLength) and (AString[I] = ' ') do // To remove initial spaces
    Inc(I);

  while I <= LTextLength do // divide into strings and add to String list
  begin
    if LFlag and ((I = LTextLength) or (AString[I] = ' ')) then
    begin
      LStrings.Add(Copy(AString, LTemp, I - LTemp + 1));
      LTemp := I + 1;
    end
    else
      LFlag := True;
    Inc(I);
  end;

  // Calculate extra spaces can fit in current line
  LExtraSpace := Trunc((AWidth - TextSize(AString, AFont).cx) / TextSize(' ',
    AFont).cx);

  // between each word insert spaces dynamically
  if LStrings.Count > 1 then // Justification
  begin
    for I := 0 to LStrings.Count - 1 do
    begin
      Result := Result + LStrings[I];
      if I = (LStrings.Count - 1) then
        Break;
      LTemp := LExtraSpace div (LStrings.Count - I - 1);
      LExtraSpace := LExtraSpace - LTemp;
      while LTemp > 0 do
      begin
        Result := Result + ' ';
        Dec(LTemp);
      end;
    end;
  end
  else // if single word insert spaces between characters
    begin
    for I := 1 to LTextLength do
    begin
      Result := Result + AString[I];
      if I = (LTextLength) then
        Break;
      LTemp := LExtraSpace div (LTextLength - I);
      LExtraSpace := LExtraSpace - LTemp;
      while LTemp > 0 do
      begin
        Result := Result + ' ';
        Dec(LTemp);
      end;
    end;
  end;

  LStrings.Free;
end;

{ ------------------------------------------------------------------------------ }

function GetFileNameFromPath(AString: String): String;
var
  LI, LSize: Integer;
begin
  Result := AString;
  LSize := Length(AString);
  if (Pos('\', AString) > 0) then
    for LI := LSize downto 1 do
      if (AString[LI] = '\') then
      begin
        Result := Copy(AString, (LI + 1), (LSize - LI));
        Break;
      end;
end;

{ ------------------------------------------------------------------------------ }

function RemoveTerminalCRLF(AString: AnsiString): AnsiString;
var
  LLength: Integer;
begin
  LLength := Length(AString);
  SetLength(Result, LLength);
  Result := AString;
  if (LLength > 1) then
  begin
    if (AString[LLength - 1] = CR) and (AString[LLength] = LF) then
    begin
      SetLength(Result, (LLength - 2));
      Result := Copy(AString, 1, LLength - 2);
    end;
  end;
end;

{ ------------------------------------------------------------------------------ }

function RemoveTerminalCRLFW(AString: String): String;
var
  LLength: Integer;
begin
  LLength := Length(AString);
  SetLength(Result, LLength);
  Result := AString;
  if (LLength > 1) then
  begin
    if (AString[LLength - 1] = CR) and (AString[LLength] = LF) then
    begin
      SetLength(Result, (LLength - 2));
      Result := Copy(AString, 1, LLength - 2);
    end;
  end;
end;

{ ------------------------------------------------------------------------------ }

function RevHexBytes(S: String): String;
var
  I: Integer;
begin
  Result := '';
  I := Length(S) - 1;
  while I > 0 do
  begin
    Result := Result + Copy(S, I, 2);
    Dec(I, 2);
  end;
end;

{ ------------------------------------------------------------------------------ }
procedure Swap(var A, B: Double);
var
  LTemp: Double;
begin
  LTemp := A;
  A := B;
  B := LTemp;
end;
{ ------------------------------------------------------------------------------ }

procedure gtAngleText(AText: String; AAngleDegree: Integer; ABitmap: TBitmap;
  var PosX, PosY: Double);
var
  LRotatedTextValues: TgtRotatedTextValues;
begin
  CalculateTextPositions(ABitmap.Canvas, AAngleDegree, AText,
    LRotatedTextValues);

  with ABitmap do
  begin
    Width := LRotatedTextValues.ATextWidth + LRotatedTextValues.ATextWidthGap;
    Height := LRotatedTextValues.ATextHeight +
      LRotatedTextValues.ATextHeightGap;
    Transparent := True;
    Canvas.Brush.Style := bsClear;
    Canvas.TextOut(LRotatedTextValues.AposX, LRotatedTextValues.AposY, AText);
  end;
  PosX := PosX - LRotatedTextValues.AposX;
  PosY := PosY - LRotatedTextValues.AposY;
end;

{ ------------------------------------------------------------------------------ }

procedure CalculateTextPositions(ACanvas: TCanvas; AAngleDegree: Integer;
  AText: String; var AgtRotatedTextValues: TgtRotatedTextValues);
var
  LFontWidth, LFontHeight: Integer;
  LAngleRadians: Real;
begin
  SetTextAngle(ACanvas, AAngleDegree); // Rotate Font

  // Convert from Degrees to Radians
  case AAngleDegree of
    0 .. 89:
      LAngleRadians := DegreesToRadians(90 - AAngleDegree);
    90 .. 179:
      LAngleRadians := DegreesToRadians(AAngleDegree - 90);
    180 .. 269:
      LAngleRadians := DegreesToRadians(270 - AAngleDegree);
  else { 270..359 }
    LAngleRadians := DegreesToRadians(AAngleDegree - 270);
  end;

  LFontWidth := ACanvas.TextWidth(AText);
  LFontHeight := ACanvas.TextHeight(AText);

  with AgtRotatedTextValues do
  begin
    ATextWidth := Round(sin(LAngleRadians) * LFontWidth);
    ATextWidthGap := Round(cos(LAngleRadians) * LFontHeight);
    ATextHeight := Round(cos(LAngleRadians) * LFontWidth);
    ATextHeightGap := Round(sin(LAngleRadians) * LFontHeight);

    ATotalWidth := (ATextWidth + ATextWidthGap);
    ATotalHeight := (ATextHeight + ATextHeightGap);

    // Calculate new position of text
    case AAngleDegree of
      0 .. 89:
        begin
          AposX := 0;
          AposY := ATextHeight;
        end;
      90 .. 179:
        begin
          AposX := ATextWidth;
          AposY := ATotalHeight
        end;
      180 .. 269:
        begin
          AposX := ATotalWidth;
          AposY := ATextHeightGap;
        end;
    else { 270..359 }
      begin
        AposX := ATextWidthGap;
        AposY := 0
      end;
    end;
  end;
end;

{ ------------------------------------------------------------------------------ }

procedure SetTextAngle(ACanvas: TCanvas; AAngleDegree: Integer);
var
  LFontLogRec: TLogFont;
begin
  // Get current Font information for Font rotation
  GetObject(ACanvas.Font.Handle, SizeOf(LFontLogRec), Addr(LFontLogRec));

  // Rotate Font
  LFontLogRec.lfEscapement := (AAngleDegree * 10);
  // Request TrueType precision
  LFontLogRec.lfOutPrecision := OUT_TT_ONLY_PRECIS;

  ACanvas.Font.Handle := CreateFontIndirect(LFontLogRec);
end;
{ ------------------------------------------------------------------------------ }

function GetRotatedBitmap(ABitmap: TBitmap; var AX, AY: Double; Angle: Double;
  ABackgroundColor: TColor = ClWhite): TBitmap;
var
  X1, Y1, X2, Y2, X4, Y4: Integer;
  LRadian, LSin, LCos: Double;
  Points: array of TPoint;
  I, J: Integer;
begin

  { Calculate Rotated Vertices }
  LRadian := Angle * PI / 180;
  LSin := sin(LRadian);
  LCos := cos(LRadian);
  SetLength(Points, 4);

  X4 := 0;
  Y4 := 0;

  Points[0].X := Round(X4 + ABitmap.Height * LSin);
  Points[0].Y := Round(Y4 + ABitmap.Height * LCos);

  Points[1].X := Round(Points[0].X + ABitmap.Width * LCos);
  Points[1].Y := Round(Points[0].Y - ABitmap.Width * LSin);

  Points[2].X := Round(X4 + ABitmap.Width * LCos);
  Points[2].Y := Round(Y4 - ABitmap.Width * LSin);

  Points[3].X := X4;
  Points[3].Y := Y4;

  X1 := 0;
  X2 := 0;
  Y1 := 0;
  Y2 := 0;

  for I := 0 to 3 do
  begin
    if I = 0 then
    begin
      X1 := Points[I].X;
      X2 := Points[I].X;
      Y1 := Points[I].Y;
      Y2 := Points[I].Y;
    end;
    if X1 > Points[I].X then
      X1 := Points[I].X;
    if X2 < Points[I].X then
      X2 := Points[I].X;
    if Y1 > Points[I].Y then
      Y1 := Points[I].Y;
    if Y2 < Points[I].Y then
      Y2 := Points[I].Y;
  end;

  for I := 0 to 3 do
  begin
    Points[I].X := Points[I].X - X1;
    Points[I].Y := Points[I].Y - Y1;
  end;

  { Create Bitmap and Map original bitmap to new bitmap }
  Result := TBitmap.Create;
  Result.Width := Abs(X2 - X1);
  Result.Height := Abs(Y2 - Y1);
  Result.PixelFormat := ABitmap.PixelFormat;
  Result.Canvas.Brush.Color := ABackgroundColor;
  Result.Canvas.FillRect(Rect(0, 0, Result.Width, Result.Height));
  Result.Canvas.CopyMode := cmSrcAnd;

  for I := 0 to Result.Height - 1 do
    for J := 0 to Result.Width - 1 do
    begin
      Y2 := Round((I + Y1) * LCos + (J + X1) * LSin);
      X2 := Round((J + X1) * LCos - (I + Y1) * LSin);
      if (Y2 >= 0) and (Y2 < ABitmap.Height) and (X2 >= 0) and
        (X2 < ABitmap.Width) then
        Result.Canvas.Pixels[J, I] := ABitmap.Canvas.Pixels[X2, Y2];
    end;
  { Recaulculate initial points }

  AY := AY - Points[3].Y;
  AX := AX - Points[3].X;

  Finalize(Points);
{$IFNDEF gtDelphi2005}
  FreeMem(Points);
{$ENDIF}
end;

{ ------------------------------------------------------------------------------ }

function GetFilePathFromText(AString: String; APos: Integer): Integer;
var
  LI, LJ, LK, Len: Integer;
begin
  LK := 0;
  Len := Length(AString);
  for LI := Len downto 1 do
    if (AString[LI] = '\') then
    begin
      for LJ := LI to Len do
        if AString[LJ] = '.' then
        begin
          LK := LJ;
          while LK <= Len do
          begin
{$IFDEF gtDelphi2009Up}
            if SysUtils.CharInSet(AString[LK], [' ', '"', '*', '?', '|']) then
{$ELSE}
            if AString[LK] in [' ', '"', '*', '?', '|'] then
{$ENDIF}
            begin
              Result := LK;
              Exit;
            end;
            Inc(LK);
          end;
        end;
      Break;
    end;
  if LK < Len then
    Result := 0
  else
    Result := Len + 1;
end;
{ ------------------------------------------------------------------------------ }

end.
