unit PDDeviceRGBColorSpace;

interface

uses
  PDColorSpace, gtObject, PDTypes, PDElement, PDBaseObject;

type
  TgtPDDeviceRGBColorSpace = class(TgtPDColorSpace)
  private
  public
    constructor Create;
    destructor Destroy; override;
    function GetMode: TgtColorSpaceMode; override;
    function GetNoOfComps: Integer; override;

    procedure GetDefaultColor(var Color: TgtColor); override;
    procedure GetGray(Color: TgtColor; var GrayColor: TgtGray); override;
    procedure GetRGB(Color: TgtColor; var RGBColor: TgtRGB); override;
    procedure GetCMYK(Color: TgtColor; var CMYKColor: TgtCMYK); override;
    function Copy: TgtPDColorSpace; override;

    procedure Update; override;
  end;

implementation

{ TgtPDDeviceRGBColorSpace }

function TgtPDDeviceRGBColorSpace.Copy: TgtPDColorSpace;
begin
  Result := TgtPDDeviceRGBColorSpace.Create;
end;

constructor TgtPDDeviceRGBColorSpace.Create;
begin
  FParentDoc := nil;
  FParentElement := nil;
  FBaseObject := nil;
  FTagName := '';
end;

destructor TgtPDDeviceRGBColorSpace.Destroy;
begin

  inherited;
end;

procedure TgtPDDeviceRGBColorSpace.GetCMYK(Color: TgtColor;
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

procedure TgtPDDeviceRGBColorSpace.GetDefaultColor(var Color: TgtColor);
begin
  Color.Comps[0] := 0;
  Color.Comps[1] := 0;
  Color.Comps[2] := 0;
end;

procedure TgtPDDeviceRGBColorSpace.GetGray(Color: TgtColor;
  var GrayColor: TgtGray);
var
  LColor: TgtColorMapComp;
begin
  LColor := Round((0.3 * Color.Comps[0]) + (0.59 * Color.Comps[1]) + (0.11 * Color.Comps[2]) + 0.5);
  GrayColor := Clip01(LColor);
end;

function TgtPDDeviceRGBColorSpace.GetMode: TgtColorSpaceMode;
begin
  Result := csDeviceRGB;
end;

function TgtPDDeviceRGBColorSpace.GetNoOfComps: Integer;
begin
  Result := 3;
end;

procedure TgtPDDeviceRGBColorSpace.GetRGB(Color: TgtColor;
  var RGBColor: TgtRGB);
begin
  RGBColor.R := Clip01(Color.Comps[0]);
  RGBColor.G := Clip01(Color.Comps[1]);
  RGBColor.B := Clip01(Color.Comps[2]);
end;

procedure TgtPDDeviceRGBColorSpace.Update;
begin
  inherited;

end;

end.
