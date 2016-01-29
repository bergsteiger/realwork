{ ********************************************************************* }
{                                                                       }
{                    Gnostice Portable Document Model                   }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

{$I ..\Utils\gtCompilerDefines.inc}
unit PDCalGrayColorSpace;

interface

uses
  gtObject, PDTypes, PDColorSpace, PDElement, PDBaseObject;

type
  TgtPDCalGrayColorSpace = class(TgtPDColorSpace)
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
    FGamma: Double;
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
    function GetGamma: Double;

    procedure Update; override;
  end;

implementation

uses
{$IFDEF DEBUG}
  gtLogger,
{$ENDIF}
  PDArray, PDDictionary, gtConstants, PDReal, PDInteger;

{ TgtPDCalGrayColorSpace }

function TgtPDCalGrayColorSpace.Copy: TgtPDColorSpace;
var
  LColorSpace: TgtPDCalGrayColorSpace;
begin
  LColorSpace := TgtPDCalGrayColorSpace.Create(FBaseObject);
  LColorSpace.FWhiteX := FWhiteX;
  LColorSpace.FWhiteY := FWhiteY;
  LColorSpace.FWhiteZ := FWhiteZ;
  LColorSpace.FBlackX := FBlackX;
  LColorSpace.FBlackY := FBlackY;
  LColorSpace.FBlackZ := FBlackZ;
  LColorSpace.FGamma := FGamma;

  Result := LColorSpace;
end;

constructor TgtPDCalGrayColorSpace.Create(ABaseObject: TgtPDBaseObject);
var
  LObj, LObj2, LObj3: TgtPDBaseObject;
begin
  FBaseObject := ABaseObject;

  LObj := TgtPDArray(FBaseObject).Get(1);
  if (not LObj.IsDict) then
  begin
{$IFDEF DEBUG}
    Logger.LogError('Bad CalGray color space');
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

  LObj2 := TgtPDDictionary(LObj).LookUp(PDF_GAMMA);
  if Assigned(LObj2) then
  begin
    if LObj2.IsNumber then
    begin
      if LObj2.IsReal then
        FGamma := TgtPDReal(LObj2).Value
      else
        FGamma := TgtPDInteger(LObj2).Value;
    end;
  end;
end;

destructor TgtPDCalGrayColorSpace.Destroy;
begin

  inherited;
end;

function TgtPDCalGrayColorSpace.GetBlackX: Double;
begin
  Result := FBlackX;
end;

function TgtPDCalGrayColorSpace.GetBlackY: Double;
begin
  Result := FBlackY;
end;

function TgtPDCalGrayColorSpace.GetBlackZ: Double;
begin
  Result := FBlackZ;
end;

procedure TgtPDCalGrayColorSpace.GetCMYK(Color: TgtColor;
  var CMYKColor: TgtCMYK);
begin
  CMYKColor.C := 0;
  CMYKColor.M := 0;
  CMYKColor.Y := 0;
  CMYKColor.K := Clip01($10000 - Color.Comps[0]);
end;

procedure TgtPDCalGrayColorSpace.GetDefaultColor(var Color: TgtColor);
begin
  Color.Comps[0] := 0;
end;

function TgtPDCalGrayColorSpace.GetGamma: Double;
begin
  Result := FGamma;
end;

procedure TgtPDCalGrayColorSpace.GetGray(Color: TgtColor;
  var GrayColor: TgtGray);
begin
  GrayColor := Clip01(Color.Comps[0]);
end;

function TgtPDCalGrayColorSpace.GetMode: TgtColorSpaceMode;
begin
  Result := csCalGray;
end;

function TgtPDCalGrayColorSpace.GetNoOfComps: Integer;
begin
  Result := 1;
end;

procedure TgtPDCalGrayColorSpace.GetRGB(Color: TgtColor;
  var RGBColor: TgtRGB);
begin
  RGBColor.R := Clip01(Color.Comps[0]);
  RGBColor.G := Clip01(Color.Comps[0]);
  RGBColor.B := Clip01(Color.Comps[0]);
end;

function TgtPDCalGrayColorSpace.GetWhiteX: Double;
begin
  Result := FWhiteX;
end;

function TgtPDCalGrayColorSpace.GetWhiteY: Double;
begin
  Result := FWhiteY
end;

function TgtPDCalGrayColorSpace.GetWhiteZ: Double;
begin
  Result := FWhiteZ;
end;

procedure TgtPDCalGrayColorSpace.Update;
begin
  inherited;

end;

end.
