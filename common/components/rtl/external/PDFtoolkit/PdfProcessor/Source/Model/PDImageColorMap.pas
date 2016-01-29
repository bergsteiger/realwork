unit PDImageColorMap;

interface

uses
  gtObject, PDColorSpace, PDTypes, PDBaseObject, gtTypes;

type

  TgtPDImageColorMap = class(TgtObject)
  private
    FBits: Integer; // bits per component
    FColorSpace: TgtPDColorSpace; // the image color space
    FColorSpace2: TgtPDColorSpace; // secondary color space
    FLookUp: array of array of Integer;
                                  // lookup table
    FNComps: Integer; // number of components in a pixel
    FNComps2: Integer; // number of components in colorSpace2
    FDecodeLow: TgtImageDecodeArray; // minimum values for each component
    FDecodeRange: TgtImageDecodeArray; // max - min value for each component
    FOk: Boolean;

//    constructor Create(ColorMap: TgtPDImageColorMap); overload;
  public
    constructor Create(aBits: Integer; aDecodeArray: TgtPDBaseObject;
      aColorSpace: TgtPDColorSpace); overload;
    destructor Destroy; override;

    // Return a copy of this color map.
    function Copy: TgtPDImageColorMap;

    function GetColorSpace: TgtPDColorSpace;
    function GetNumberOfBits: Integer;
    function GetNumberOfPixelComps: Integer;

    // Get decode table.
    function GetDecodeLow(I: Integer): Double;
    function GetDecodeHigh(I: Integer): Double;

    function IsOk: Boolean;

    // Convert an image pixel to a color.
    procedure GetGray(var X: Bytes; CurrentIndex: Integer; var Gray: TgtGray);
    procedure GetRGB(var X: Bytes; CurrentIndex: Integer; var RGB: TgtRGB);
    procedure GetCMYK(var X: Bytes; CurrentIndex: Integer; var CMYK: TgtCMYK);
    procedure GetColor(var X: Bytes; Color: TgtColor);

  end;

implementation

uses
  gtMethods, PDArray, PDReal, PDInteger, PDIndexedColorSpace,
  PDSeparationColorSpace, PDFunction;

{ TgtPDImageColorMap }

function TgtPDImageColorMap.Copy: TgtPDImageColorMap;
begin
  Result := nil;
end;

constructor TgtPDImageColorMap.Create(aBits: Integer;
  aDecodeArray: TgtPDBaseObject; aColorSpace: TgtPDColorSpace);
var
  LMaxPixel, LK, LI, LJ, LIndexHigh, LNoOfComps: Integer;
  LX, LY: TgtImageDecodeArray;
  LObj: TgtPDBaseObject;
  LSeparationCS: TgtPDSeparationColorSpace;
  LLookUp2: AnsiString;
  SepFunc: TgtPDFunction;
  LTempX, LTempY: TgtDoubleArray;
begin
  FOk := True;

  //bits per component and color space
  FBits := aBits;
  FColorSpace := aColorSpace;
  LMaxPixel := (1 shl FBits) - 1;

  //initialize
  SetLength(FLookUp, ColorMapMaxComps, 1);
  for LK := 0 to ColorMapMaxComps - 1 do
    FLookUp[LK] := nil;

  //get decode map
  if not Assigned(aDecodeArray) then
  begin
    if Assigned(FColorSpace) then
    begin
      FNComps := FColorSpace.GetNoOfComps;
      FColorSpace.GetDefaultRanges(FDecodeLow, FDecodeRange, LMaxPixel);
    end
    else
    begin
      FNComps := 1;
      FDecodeLow[0] := 0;
      FDecodeRange[0] := 1;
    end;
  end
  else if aDecodeArray.IsArray then
  begin
    FNComps := TgtPDArray(aDecodeArray).GetLength div 2;
    if Assigned(FColorSpace) then
      LNoOfComps := FColorSpace.GetNoOfComps
    else
      LNoOfComps := 1;
    if (FNComps <> LNoOfComps) then
    begin
      FOk := False;
      Exit;
    end;
    for LI := 0 to FNComps - 1 do
    begin
      LObj := TgtPDArray(aDecodeArray).Get(2 * LI);
      if LObj.IsReal then
        FDecodeLow[LI] := TgtPDReal(LObj).Value
      else
        FDecodeLow[LI] := TgtPDInteger(LObj).Value;

      LObj := TgtPDArray(aDecodeArray).Get(2 * LI + 1);
      if LObj.IsReal then
        FDecodeRange[LI] := TgtPDReal(LObj).Value - FDecodeLow[LI]
      else
        FDecodeRange[LI] := TgtPDInteger(LObj).Value - FDecodeLow[LI];
    end;
  end
  else
    FOk := False;

  // Construct a lookup table -- this stores pre-computed decoded
  // values for each component, i.e., the result of applying the
  // decode mapping to each possible image pixel component value.

  // Optimization: for Indexed and Separation color spaces (which have
  // only one component), we store color values in the lookup table
  // rather than component values.

  FColorSpace2 := nil;
  FNComps2 := 0;
  if Assigned(FColorSpace) and (FColorSpace.GetMode = csIndexed) then
  begin
    // Note that indexHigh may not be the same as maxPixel --
    // Distiller will remove unused palette entries, resulting in
    // indexHigh < maxPixel.
//    LIndexedCS := TgtPDIndexedColorSpace(FColorSpace);
    FColorSpace2 := TgtPDIndexedColorSpace(FColorSpace).GetBase;
    LIndexHigh := TgtPDIndexedColorSpace(FColorSpace).GetIndexHigh;
    if Assigned(FColorSpace2) then
      FNComps2 := FColorSpace2.GetNoOfComps;
    LLookUp2 := TgtPDIndexedColorSpace(FColorSpace).GetLookup;
    FColorSpace2.GetDefaultRanges(LX, LY, LIndexHigh);
    for LK := 0 to FNComps2 - 1 do
    begin
      SetLength(FLookUp[LK], LMaxPixel + 1);

      for LI := 0 to LMaxPixel do
      begin
        LJ := Trunc(FDecodeLow[0] + (LI * FDecodeRange[0]) / LMaxPixel + 0.5);
        if (LJ < 0) then
          LJ := 0
        else if (LJ > LIndexHigh) then
          LJ := LIndexHigh;
        FLookUp[LK][LI] := DblToCol(LX[LK] + (Ord(LLookUp2[LJ * FNComps2 + (LK + 1)]) / 255) * LY[LK]);
      end;
    end;
  end
  else if Assigned(FColorSpace) and (FColorSpace.GetMode = csSeparation) then
  begin
    LSeparationCS := TgtPDSeparationColorSpace(FColorSpace);
    FColorSpace2 := LSeparationCS.GetAlt;
    if Assigned(FColorSpace2) then
      FNComps2 := FColorSpace2.GetNoOfComps;
    SepFunc := LSeparationCS.GetFunction;
    for LI := Low(LY) to High(LY) do
      LY[LI] := 0;
    for LI := 0 to FunctionMaxInputs - 1 do
      LTempY[LI] := LY[LI];
    for LK := 0 to FNComps2 - 1 do
    begin
      SetLength(FLookUp[LK], LMaxPixel + 1);
      for LI := 0 to LMaxPixel do
      begin
        LX[0] := FDecodeLow[0] + (LI * FDecodeRange[0]) / LMaxPixel;
        LTempX[0] := LX[0];
        if Assigned(SepFunc) then
          SepFunc.Transform(LTempX, LTempY);
        FLookUp[LK][LI] := DblToCol(LTempY[LK]);
      end;
    end;
  end
  else
  begin
    for LK := 0 to FNComps - 1 do
    begin
      SetLength(FLookUp[LK], LMaxPixel + 1);
      for LI := 0 to LMaxPixel do
      begin
        FLookUp[LK][LI] := DblToCol(FDecodeLow[LK] + (LI * FDecodeRange[LK]) / LMaxPixel);
      end;
    end;
  end;
end;

destructor TgtPDImageColorMap.Destroy;
var
  LK: Integer;
begin
  for LK := 0 to FNComps - 1 do
    SetLength(FLookUp[LK], 0);
  SetLength(FLookUp, 0);
  inherited;
end;

procedure TgtPDImageColorMap.GetCMYK(var X: Bytes; CurrentIndex: Integer; var CMYK: TgtCMYK);
var
  LColor: TgtColor;
  LI: Integer;
begin
  if Assigned(FColorSpace2) then
  begin
    for LI := 0 to FNComps2 - 1 do
    begin
      LColor.Comps[LI] := FLookUp[LI][Ord(X[CurrentIndex])];
    end;
    FColorSpace2.GetCMYK(LColor, CMYK);
  end
  else
  begin
    for LI := 0 to FNComps - 1 do
    begin
      LColor.Comps[LI] := FLookUp[LI][Ord(X[LI + CurrentIndex])];
    end;
    FColorSpace.GetCMYK(LColor, CMYK);
  end;
end;

procedure TgtPDImageColorMap.GetColor(var X: Bytes; Color: TgtColor);
var
  LMaxPixel: Integer;
  LI: Integer;
begin
  LMaxPixel := (1 shl FBits) - 1;
  for LI := 0 to FNComps - 1 do
  begin
    Color.Comps[LI] := DblToCol(FDecodeLow[LI] + (Ord(X[LI]) * FDecodeRange[LI] / LMaxPixel));
  end;
end;

function TgtPDImageColorMap.GetColorSpace: TgtPDColorSpace;
begin
  Result := FColorSpace;
end;

function TgtPDImageColorMap.GetDecodeHigh(I: Integer): Double;
begin
  Result := FDecodeLow[I] + FDecodeRange[I];
end;

function TgtPDImageColorMap.GetDecodeLow(I: Integer): Double;
begin
  Result := FDecodeLow[I];
end;

procedure TgtPDImageColorMap.GetGray(var X: Bytes; CurrentIndex: Integer; var Gray: TgtGray);
var
  LColor: TgtColor;
  LI: Integer;
begin
  if Assigned(FColorSpace2) then
  begin
    for LI := 0 to FNComps2 - 1 do
    begin
      LColor.Comps[LI] := FLookUp[LI][Ord(X[CurrentIndex])];
    end;
    FColorSpace2.GetGray(LColor, Gray);
  end
  else
  begin
    for LI := 0 to FNComps - 1 do
    begin
      LColor.Comps[LI] := FLookUp[LI][Ord(X[LI + CurrentIndex])];
    end;
    if Assigned(FColorSpace) then FColorSpace.GetGray(LColor, Gray)
    else Gray := LColor.Comps[0];
  end;
end;

function TgtPDImageColorMap.GetNumberOfBits: Integer;
begin
  Result := FBits;
end;

function TgtPDImageColorMap.GetNumberOfPixelComps: Integer;
begin
  Result := FNComps;
end;

procedure TgtPDImageColorMap.GetRGB(var X: Bytes; CurrentIndex: Integer; var RGB: TgtRGB);
var
  LColor: TgtColor;
  LI: Integer;
begin
  if Assigned(FColorSpace2) then
  begin
    for LI := 0 to FNComps2 - 1 do
    begin
      LColor.Comps[LI] := FLookUp[LI][Ord(X[CurrentIndex])];
    end;
    FColorSpace2.GetRGB(LColor, RGB);
  end
  else
  begin
    for LI := 0 to FNComps - 1 do
    begin
      LColor.Comps[LI] := FLookUp[LI][Ord(X[LI + CurrentIndex])];
    end;
    FColorSpace.GetRGB(LColor, RGB);
  end;
end;

function TgtPDImageColorMap.IsOk: Boolean;
begin
  Result := FOk;
end;

end.
