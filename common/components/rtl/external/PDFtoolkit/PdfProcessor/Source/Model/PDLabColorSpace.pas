{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Model                   }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

{$I ..\Utils\gtCompilerDefines.inc}

unit PDLabColorSpace;

interface

uses
  PDColorSpace, PDElement, gtObject, PDTypes, PDBaseObject;

type
  TgtPDLabColorSpace = class(TgtPDColorSpace)
  private
    // white point
    FWhiteX: Double;
    FWhiteY: Double;
    FWhiteZ: Double;

    // black point
    FBlackX: Double;
    FBlackY: Double;
    FBlackZ: Double;

    // range for the a and b components
    FAMin: Double;
    FAMax: Double;
    FBMin: Double;
    FBMax: Double;

    // gamut mapping mulitpliers
    FKR: Double;
    FKG: Double;
    FKB: Double;
  public
    constructor Create(ABaseObject: TgtPDBaseObject);

    function GetMode: TgtColorSpaceMode; override;
    function GetNoOfComps: Integer; override;

    procedure GetDefaultColor(var Color: TgtColor); override;
    procedure GetGray(Color: TgtColor; var GrayColor: TgtGray); override;
    procedure GetRGB(Color: TgtColor; var RGBColor: TgtRGB); override;
    procedure GetCMYK(Color: TgtColor; var CMYKColor: TgtCMYK); override;
    procedure GetDefaultRanges(var DecodeLow, DecodeRange: TgtImageDecodeArray;
      MaxImgPixel: Double); override;
    function Copy: TgtPDColorSpace; override;

    function GetWhiteX: Double;
    function GetWhiteY: Double;
    function GetWhiteZ: Double;
    function GetBlackX: Double;
    function GetBlackY: Double;
    function GetBlackZ: Double;
    function GetAMin: Double;
    function GetAMax: Double;
    function GetBMin: Double;
    function GetBMax: Double;

    procedure Update; override;
  end;

implementation

uses
{$IFDEF DEBUG}
  gtLogger,
{$ENDIF}
  Math, PDArray, PDDictionary, PDReal, PDInteger, gtConstants;

{ TgtPDLabColorSpace }

function TgtPDLabColorSpace.Copy: TgtPDColorSpace;
var
  LColorSpace: TgtPDLabColorSpace;
begin
  LColorSpace := TgtPDLabColorSpace.Create(FBaseObject);
  LColorSpace.FWhiteX := FWhiteX;
  LColorSpace.FWhiteY := FWhiteY;
  LColorSpace.FWhiteZ := FWhiteZ;
  LColorSpace.FBlackX := FBlackX;
  LColorSpace.FBlackY := FBlackY;
  LColorSpace.FBlackZ := FBlackZ;
  LColorSpace.FAMin := FAMin;
  LColorSpace.FAMax := FAMax;
  LColorSpace.FBMin := FBMin;
  LColorSpace.FBMax := FBMax;
  LColorSpace.FKR := FKR;
  LColorSpace.FKG := FKG;
  LColorSpace.FKB := FKB;

  Result := LColorSpace;
end;

constructor TgtPDLabColorSpace.Create(ABaseObject: TgtPDBaseObject);
var
  LObj, LObj2, LObj3: TgtPDBaseObject;
begin
  FBaseObject := ABaseObject;

  LObj := TgtPDArray(FBaseObject).Get(1);
  if (not LObj.IsDict) then
  begin
    {$IFDEF DEBUG}
    Logger.LogError('Bad Lab color space');
    {$ENDIF}
    Exit;
  end;

  //Get the White color components
  LObj2 := TgtPDDictionary(LObj).LookUp(PDF_WHITEPOINT);
  if Assigned(LObj2) then
  begin
    if LObj2.IsArray and (TgtPDArray(LObj2).GetLength = 3) then
    begin
      LObj3 := TgtPDArray(LObj2).Get(0);
      if LObj3.IsReal then
        FWhiteX := TgtPDReal(LObj3).Value
      else
        FWhiteX := TgtPDInteger(LObj3).Value;

      LObj3 := TgtPDArray(LObj2).Get(1);
      if LObj3.IsReal then
        FWhiteY := TgtPDReal(LObj3).Value
      else
        FWhiteY := TgtPDInteger(LObj3).Value;

      LObj3 := TgtPDArray(LObj2).Get(2);
      if LObj3.IsReal then
        FWhiteZ := TgtPDReal(LObj3).Value
      else
        FWhiteZ := TgtPDInteger(LObj3).Value;
    end;
  end
  else
  begin
    FWhiteX := 1;
    FWhiteY := 1;
    FWhiteZ := 1;
  end;

  //Get the Black color components
  LObj2 := TgtPDDictionary(LObj).LookUp(PDF_BLACKPOINT);
  if Assigned(LObj2) then
  begin
    if LObj2.IsArray and (TgtPDArray(LObj2).GetLength = 3) then
    begin
      LObj3 := TgtPDArray(LObj2).Get(0);
      if LObj3.IsReal then
        FBlackX := TgtPDReal(LObj3).Value
      else
        FBlackX := TgtPDInteger(LObj3).Value;

      LObj3 := TgtPDArray(LObj2).Get(1);
      if LObj3.IsReal then
        FBlackY := TgtPDReal(LObj3).Value
      else
        FBlackY := TgtPDInteger(LObj3).Value;

      LObj3 := TgtPDArray(LObj2).Get(2);
      if LObj3.IsReal then
        FBlackZ := TgtPDReal(LObj3).Value
      else
        FBlackZ := TgtPDInteger(LObj3).Value;
    end;
  end
  else
  begin
    FBlackX := 0;
    FBlackY := 0;
    FBlackZ := 0;
  end;

  //Setting the Range
  LObj2 := TgtPDDictionary(LObj).LookUp(PDF_RANGE);
  if Assigned(LObj2) then
  begin
    if LObj2.IsArray and (TgtPDArray(LObj2).GetLength = 4) then
    begin
      LObj3 := TgtPDArray(LObj2).Get(0);
      if LObj3.IsReal then
        FAMin := TgtPDReal(LObj3).Value
      else
        FAMin := TgtPDInteger(LObj3).Value;

      LObj3 := TgtPDArray(LObj2).Get(1);
      if LObj3.IsReal then
        FAMax := TgtPDReal(LObj3).Value
      else
        FAMax := TgtPDInteger(LObj3).Value;

      LObj3 := TgtPDArray(LObj2).Get(2);
      if LObj3.IsReal then
        FBMin := TgtPDReal(LObj3).Value
      else
        FBMin := TgtPDInteger(LObj3).Value;

      LObj3 := TgtPDArray(LObj2).Get(3);
      if LObj3.IsReal then
        FBMax := TgtPDReal(LObj3).Value
      else
        FBMax := TgtPDInteger(LObj3).Value;
    end;
  end
  else
  begin
    FAMin := -100;
    FBMin := -100;
    FAMax := 100;
    FBMax := 100;
  end;

  FKR := 1 / (XYZRGB[0][0] * FWhiteX + XYZRGB[0][1] * FWhiteY +
    XYZRGB[0][2] * FWhiteZ);
  FKG := 1 / (XYZRGB[1][0] * FWhiteX + XYZRGB[1][1] * FWhiteY +
    XYZRGB[1][2] * FWhiteZ);
  FKB := 1 / (XYZRGB[2][0] * FWhiteX + XYZRGB[2][1] * FWhiteY +
    XYZRGB[2][2] * FWhiteZ);
end;

function TgtPDLabColorSpace.GetAMax: Double;
begin
  Result := FAMax;
end;

function TgtPDLabColorSpace.GetAMin: Double;
begin
  Result := FAMin;
end;

function TgtPDLabColorSpace.GetBlackX: Double;
begin
  Result := FBlackX;
end;

function TgtPDLabColorSpace.GetBlackY: Double;
begin
  Result := FBlackY;
end;

function TgtPDLabColorSpace.GetBlackZ: Double;
begin
  Result := FBlackZ;
end;

function TgtPDLabColorSpace.GetBMax: Double;
begin
  Result := FBMax;
end;

function TgtPDLabColorSpace.GetBMin: Double;
begin
  Result := FBMin;
end;

procedure TgtPDLabColorSpace.GetCMYK(Color: TgtColor;
  var CMYKColor: TgtCMYK);
var
  LC, LM, LY, LK: TgtColorMapComp;
  LRGBColor: TgtRGB;
begin
  GetRGB(Color, LRGBColor);
  LC := Clip01($10000 - LRGBColor.R);
  LM := Clip01($10000 - LRGBColor.G);
  LY := Clip01($10000 - LRGBColor.B);
  LK := LC;
  if (LM < LK) then
    LK := LM;
  if (LY < LK) then
    LK := LY;

  CMYKColor.C := LC - LK;
  CMYKColor.M := LM - LK;
  CMYKColor.Y := LY - LK;
  CMYKColor.K := LK;
end;

procedure TgtPDLabColorSpace.GetDefaultColor(var Color: TgtColor);
begin
  Color.Comps[0] := 0;
  if (FAMin > 0) then
    Color.Comps[1] := DblToCol(FAMin)
  else if (FAMax < 0) then
    Color.Comps[1] := DblToCol(FAMax)
  else
    Color.Comps[1] := 0;

  if (FBMin > 0) then
    Color.Comps[2] := DblToCol(FBMin)
  else if (FBMax < 0) then
    Color.Comps[2] := DblToCol(FBMax)
  else
    Color.Comps[2] := 0;
end;

procedure TgtPDLabColorSpace.GetDefaultRanges(var DecodeLow, DecodeRange: TgtImageDecodeArray;
  MaxImgPixel: Double);
begin
  DecodeLow[0] := 0;
  DecodeRange[0] := 100;
  DecodeLow[1] := FAMin;
  DecodeRange[1] := FAMax - FAMin;
  DecodeLow[2] := FBMin;
  DecodeRange[2] := FBMin - FBMin;
end;

procedure TgtPDLabColorSpace.GetGray(Color: TgtColor;
  var GrayColor: TgtGray);
var
  LColor: TgtColorMapComp;
  LRGBColor: TgtRGB;
begin
  GetRGB(Color, LRGBColor);
  LColor := Round((0.299 * LRGBColor.R) + (0.587 * LRGBColor.G) +
    (0.114 * LRGBColor.B) + 0.5);
  GrayColor := Clip01(LColor);
end;

function TgtPDLabColorSpace.GetMode: TgtColorSpaceMode;
begin
  Result := csLab;
end;

function TgtPDLabColorSpace.GetNoOfComps: Integer;
begin
  Result := 3;
end;

procedure TgtPDLabColorSpace.GetRGB(Color: TgtColor;
  var RGBColor: TgtRGB);
var
  LX, LY, LZ, LT1, LT2, LR, LG, LB: Double;
begin
  // convert L*a*LB* to CIE 1931 XYZ color space
  LT1 := (ColToDbl(Color.Comps[0]) + 16) / 116;
  LT2 := LT1 + ColToDbl(Color.Comps[1]) / 500;
  if (LT2 >= (6.0 / 29.0)) then
    LX := LT2 * LT2 * LT2
  else
    LX := (108.0 / 841.0) * (LT2 - (4.0 / 29.0));

  LX := LX * FWhiteX;
  if (LT1 >= (6.0 / 29.0)) then
    LY := LT1 * LT1 * LT1
  else
    LY := (108.0 / 841.0) * (LT1 - (4.0 / 29.0));

  LY := LY * FWhiteY;
  LT2 := LT1 - ColToDbl(Color.Comps[2]) / 200;
  if (LT2 >= (6.0 / 29.0)) then
    LZ := LT2 * LT2 * LT2
  else
    LZ := (108.0 / 841.0) * (LT2 - (4.0 / 29.0));

  LZ := LZ * FWhiteZ;

  // convert XYZ to RGB, including gamut mapping and gamma correction
  LR := xyzrgb[0][0] * LX + xyzrgb[0][1] * LY + xyzrgb[0][2] * LZ;
  LG := xyzrgb[1][0] * LX + xyzrgb[1][1] * LY + xyzrgb[1][2] * LZ;
  LB := xyzrgb[2][0] * LX + xyzrgb[2][1] * LY + xyzrgb[2][2] * LZ;

  RGBColor.R := DblToCol(Power(Clip01(LR * FKR), 0.5));
  RGBColor.G := DblToCol(Power(Clip01(LG * FKG), 0.5));
  RGBColor.B := DblToCol(Power(Clip01(LB * FKB), 0.5));
end;

function TgtPDLabColorSpace.GetWhiteX: Double;
begin
  Result := FWhiteX;
end;

function TgtPDLabColorSpace.GetWhiteY: Double;
begin
  Result := FWhiteY;
end;

function TgtPDLabColorSpace.GetWhiteZ: Double;
begin
  Result := FWhiteZ;
end;

procedure TgtPDLabColorSpace.Update;
begin
  inherited;

end;

end.
