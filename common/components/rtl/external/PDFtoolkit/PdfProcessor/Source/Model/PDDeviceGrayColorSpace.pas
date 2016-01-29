unit PDDeviceGrayColorSpace;

interface

uses
  gtObject, PDTypes, PDElement, PDBaseObject, PDColorSpace;

type
  TgtPDDeviceGrayColorSpace = class(TgtPDColorSpace)
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

{ TgtPDDeviceGrayColorSpace }

function TgtPDDeviceGrayColorSpace.Copy: TgtPDColorSpace;
begin
  Result := TgtPDDeviceGrayColorSpace.Create;
end;

constructor TgtPDDeviceGrayColorSpace.Create;
begin

end;

destructor TgtPDDeviceGrayColorSpace.Destroy;
begin

  inherited;
end;

procedure TgtPDDeviceGrayColorSpace.GetCMYK(Color: TgtColor;
  var CMYKColor: TgtCMYK);
begin
  CMYKColor.C := 0;
  CMYKColor.M := 0;
  CMYKColor.Y := 0;
  CMYKColor.K := Clip01($10000 - Color.Comps[0]);
end;

procedure TgtPDDeviceGrayColorSpace.GetDefaultColor(var Color: TgtColor);
begin
  Color.Comps[0] := 0;
end;

procedure TgtPDDeviceGrayColorSpace.GetGray(Color: TgtColor;
  var GrayColor: TgtGray);
begin
  GrayColor := Clip01(Color.Comps[0]);
end;

function TgtPDDeviceGrayColorSpace.GetMode: TgtColorSpaceMode;
begin
  Result := csDeviceGray;
end;

function TgtPDDeviceGrayColorSpace.GetNoOfComps: Integer;
begin
  Result := 1;
end;

procedure TgtPDDeviceGrayColorSpace.GetRGB(Color: TgtColor;
  var RGBColor: TgtRGB);
begin
  RGBColor.R := Clip01(Color.Comps[0]);
  RGBColor.G := Clip01(Color.Comps[0]);
  RGBColor.B := Clip01(Color.Comps[0]);
end;

procedure TgtPDDeviceGrayColorSpace.Update;
begin
  inherited;

end;

end.
