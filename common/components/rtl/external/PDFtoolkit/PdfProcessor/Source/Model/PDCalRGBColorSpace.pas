{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Model                   }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

{$I ..\Utils\gtCompilerDefines.inc}

unit PDCalRGBColorSpace;

interface

uses
  PDElement, gtObject, PDTypes, PDBaseObject, PDColorSpace;

type
  TgtMatrix = array[0..8] of Double;

  TgtPDCalRGBColorSpace = class(TgtPDColorSpace)
  private
    // white point
    FWhiteX: Double;
    FWhiteY: Double;
    FWhiteZ: Double;

    // black point
    FBlackX: Double;
    FBlackY: Double;
    FBlackZ: Double;

    // gamma value
    FGammaR: Double;
    FGammaG: Double;
    FGammaB: Double;

    // ABC -> XYZ transform matrix
    FMatrix: TgtMatrix;
  public
    constructor Create(ABaseObject: TgtPDBaseObject);
    destructor Destroy; override;

    function GetMode: TgtColorSpaceMode; override;
    function GetNoOfComps: Integer; override;

    procedure GetDefaultColor(var Color: TgtColor); override;
    procedure GetGray(Color: TgtColor; var GrayColor: TgtGray); override;
    procedure GetRGB(Color: TgtColor; var RGBColor: TgtRGB); override;
    procedure GetCMYK(Color: TgtColor; var CMYKColor: TgtCMYK); override;
    function Copy: TgtPDColorSpace; override;

    function GetWhiteX: Double;
    function GetWhiteY: Double;
    function GetWhiteZ: Double;
    function GetBlackX: Double;
    function GetBlackY: Double;
    function GetBlackZ: Double;
    function GetGammaR: Double;
    function GetGammaG: Double;
    function GetGammaB: Double;
    function GetMatrix: TgtMatrix;
    procedure Update; override;
  end;

implementation

uses
{$IFDEF DEBUG}
  gtLogger,
{$ENDIF}
  gtConstants, PDArray, PDDictionary, PDInteger, PDReal;

{ TgtPDCalRGBColorSpace }

function TgtPDCalRGBColorSpace.Copy: TgtPDColorSpace;
var
  LColorSpace: TgtPDCalRGBColorSpace;
  LI: Integer;
begin
  LColorSpace := TgtPDCalRGBColorSpace.Create(FBaseObject);
  LColorSpace.FWhiteX := FWhiteX;
  LColorSpace.FWhiteY := FWhiteY;
  LColorSpace.FWhiteZ := FWhiteZ;
  LColorSpace.FBlackX := FBlackX;
  LColorSpace.FBlackY := FBlackY;
  LColorSpace.FBlackZ := FBlackZ;
  LColorSpace.FGammaR := FGammaR;
  LColorSpace.FGammaG := FGammaG;
  LColorSpace.FGammaB := FGammaB;
  for LI := 0 to 8 do
    LColorSpace.FMatrix[LI] := FMatrix[LI];

  Result := LColorSpace;
end;

constructor TgtPDCalRGBColorSpace.Create(ABaseObject: TgtPDBaseObject);
var
  LObj, LObj2, LObj3: TgtPDBaseObject;
  LI: Integer;
begin
  FBaseObject := ABaseObject;

  LObj := TgtPDArray(FBaseObject).Get(1);
  if (not LObj.IsDict) then
  begin
{$IFDEF DEBUG}
    Logger.LogError('Bad CalRGB color space');
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

  //Get Gamma
  LObj2 := TgtPDDictionary(LObj).LookUp(PDF_GAMMA);
  if Assigned(LObj2) then
  begin
    if LObj2.IsArray and (TgtPDArray(LObj2).GetLength = 3) then
    begin
      LObj3 := TgtPDArray(LObj2).Get(0);
      if LObj3.IsReal then
        FGammaR := TgtPDReal(LObj3).Value
      else
        FGammaR := TgtPDInteger(LObj3).Value;

      LObj3 := TgtPDArray(LObj2).Get(1);
      if LObj3.IsReal then
        FGammaG := TgtPDReal(LObj3).Value
      else
        FGammaG := TgtPDInteger(LObj3).Value;

      LObj3 := TgtPDArray(LObj2).Get(2);
      if LObj3.IsReal then
        FGammaB := TgtPDReal(LObj3).Value
      else
        FGammaB := TgtPDInteger(LObj3).Value;
    end;
  end
  else
  begin
    FGammaR := 1;
    FGammaG := 1;
    FGammaB := 1;
  end;

  //Get the Matrix values
  LObj2 := TgtPDDictionary(LObj).LookUp(PDF_MATRIX);
  if Assigned(LObj2) then
  begin
    if LObj2.IsArray and (TgtPDArray(LObj2).GetLength = 9) then
    begin
      for LI := 0 to 8 do
      begin
        LObj3 := TgtPDArray(LObj2).Get(LI);
        if LObj3.IsReal then
          FMatrix[LI] := TgtPDReal(LObj3).Value
        else
          FMatrix[LI] := TgtPDInteger(LObj3).Value;
      end;
    end;
  end;
end;

destructor TgtPDCalRGBColorSpace.Destroy;
begin

  inherited;
end;

function TgtPDCalRGBColorSpace.GetBlackX: Double;
begin
  Result := FBlackX;
end;

function TgtPDCalRGBColorSpace.GetBlackY: Double;
begin
  Result := FBlackY;
end;

function TgtPDCalRGBColorSpace.GetBlackZ: Double;
begin
  Result := FBlackZ;
end;

procedure TgtPDCalRGBColorSpace.GetCMYK(Color: TgtColor;
  var CMYKColor: TgtCMYK);
var
  LC, LM, LY, LK: TgtColorMapComp;
begin
  LC := Clip01($10000 - Color.Comps[0]);
  LM := Clip01($10000 - Color.Comps[1]);
  LY := Clip01($10000 - Color.Comps[2]);
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

procedure TgtPDCalRGBColorSpace.GetDefaultColor(var Color: TgtColor);
begin
  Color.Comps[0] := 0;
  Color.Comps[1] := 0;
  Color.Comps[2] := 0;
end;

function TgtPDCalRGBColorSpace.GetGammaB: Double;
begin
  Result := FGammaB;
end;

function TgtPDCalRGBColorSpace.GetGammaG: Double;
begin
  Result := FGammaG;
end;

function TgtPDCalRGBColorSpace.GetGammaR: Double;
begin
  Result := FGammaR;
end;

procedure TgtPDCalRGBColorSpace.GetGray(Color: TgtColor;
  var GrayColor: TgtGray);
var
  LColor: TgtColorMapComp;
begin
  LColor := Round((0.299 * Color.Comps[0]) + (0.587 * Color.Comps[1]) + (0.114 * Color.Comps[2]) + 0.5);
  GrayColor := Clip01(LColor);
end;

function TgtPDCalRGBColorSpace.GetMatrix: TgtMatrix;
begin
  Result := FMatrix;
end;

function TgtPDCalRGBColorSpace.GetMode: TgtColorSpaceMode;
begin
  Result := csCalRGB;
end;

function TgtPDCalRGBColorSpace.GetNoOfComps: Integer;
begin
  Result := 3;
end;

procedure TgtPDCalRGBColorSpace.GetRGB(Color: TgtColor;
  var RGBColor: TgtRGB);
begin
  RGBColor.R := Clip01(Color.Comps[0]);
  RGBColor.G := Clip01(Color.Comps[1]);
  RGBColor.B := Clip01(Color.Comps[2]);
end;

function TgtPDCalRGBColorSpace.GetWhiteX: Double;
begin
  Result := FWhiteX;
end;

function TgtPDCalRGBColorSpace.GetWhiteY: Double;
begin
  Result := FWhiteY;
end;

function TgtPDCalRGBColorSpace.GetWhiteZ: Double;
begin
  Result := FWhiteZ;
end;

procedure TgtPDCalRGBColorSpace.Update;
begin
  inherited;

end;

end.
