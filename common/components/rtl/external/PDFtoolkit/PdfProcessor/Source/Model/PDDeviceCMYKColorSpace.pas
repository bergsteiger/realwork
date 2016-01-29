unit PDDeviceCMYKColorSpace;

interface

uses
  PDColorSpace, gtObject, PDTypes, PDElement, PDBaseObject;

type
  TgtPDDeviceCMYKColorSpace = class(TgtPDColorSpace)
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

{ TgtPDDeviceCMYKColorSpace }

function TgtPDDeviceCMYKColorSpace.Copy: TgtPDColorSpace;
begin
  Result := TgtPDDeviceCMYKColorSpace.Create;
end;

constructor TgtPDDeviceCMYKColorSpace.Create;
begin

end;

destructor TgtPDDeviceCMYKColorSpace.Destroy;
begin

  inherited;
end;

procedure TgtPDDeviceCMYKColorSpace.GetCMYK(Color: TgtColor;
  var CMYKColor: TgtCMYK);
begin
  CMYKColor.C := clip01(Color.Comps[0]);
  CMYKColor.M := clip01(Color.Comps[1]);
  CMYKColor.Y := clip01(Color.Comps[2]);
  CMYKColor.K := clip01(Color.Comps[3]);
end;

procedure TgtPDDeviceCMYKColorSpace.GetDefaultColor(var Color: TgtColor);
begin
  Color.Comps[0] := 0;
  Color.Comps[1] := 0;
  Color.Comps[2] := 0;
  Color.Comps[3] := $10000;
end;

procedure TgtPDDeviceCMYKColorSpace.GetGray(Color: TgtColor;
  var GrayColor: TgtGray);
var
  LColor: TgtColorMapComp;
begin
  LColor := Round($10000 - Color.Comps[3] - 0.3 * Color.Comps[0] - 0.59 *
    Color.Comps[1] - 0.11 * Color.Comps[2] + 0.5);
  GrayColor := LColor;
end;

function TgtPDDeviceCMYKColorSpace.GetMode: TgtColorSpaceMode;
begin
  Result := csDeviceCMYK;
end;

function TgtPDDeviceCMYKColorSpace.GetNoOfComps: Integer;
begin
  Result := 4;
end;

procedure TgtPDDeviceCMYKColorSpace.GetRGB(Color: TgtColor;
  var RGBColor: TgtRGB);
var
  LC, LM, LY, LK, LC1, LM1, LY1, LK1, LR, LG, LB, LX: Double;
begin
  LC := ColToDbl(Color.Comps[0]);
  LM := ColToDbl(Color.Comps[1]);
  LY := ColToDbl(Color.Comps[2]);
  LK := ColToDbl(Color.Comps[3]);
  LC1 := 1 - LC;
  LM1 := 1 - LM;
  LY1 := 1 - LY;
  LK1 := 1 - LK;
  // this is a matrix multiplication, unrolled for performance
  //                              C M Y K
  LX := LC1 * LM1 * LY1 * LK1; //  0 0 0 0
  LR := LX;
  LG := LX;
  LB := LX;
  LX := LC1 * LM1 * LY1 * LK; // 0 0 0 1
  LR := LR + 0.1373 * LX;
  LG := LG + 0.1216 * LX;
  LB := LB + 0.1255 * LX;
  LX := LC1 * LM1 * LY * LK1; // 0 0 1 0
  LR := LR + LX;
  LG := LG + 0.9490 * LX;
  LX := LC1 * LM1 * LY * LK; // 0 0 1 1
  LR := LR + 0.1098 * LX;
  LG := LG + 0.1020 * LX;
  LX := LC1 * LM * LY1 * LK1; // 0 1 0 0
  LR := LR + 0.9255 * LX;
  LB := LB + 0.5490 * LX;
  LX := LC1 * LM * LY1 * LK; // 0 1 0 1
  LR := LR + 0.1412 * LX;
  LX := LC1 * LM * LY * LK1; // 0 1 1 0
  LR := LR + 0.9294 * LX;
  LG := LG + 0.1098 * LX;
  LB := LB + 0.1412 * LX;
  LX := LC1 * LM * LY * LK; // 0 1 1 1
  LR := LR + 0.1333 * LX;
  LX := LC * LM1 * LY1 * LK1; // 1 0 0 0
  LG := LG + 0.6784 * LX;
  LB := LB + 0.9373 * LX;
  LX := LC * LM1 * LY1 * LK; // 1 0 0 1
  LG := LG + 0.0588 * LX;
  LB := LB + 0.1412 * LX;
  LX := LC * LM1 * LY * LK1; // 1 0 1 0
  LG := LG + 0.6510 * LX;
  LB := LB + 0.3137 * LX;
  LX := LC * LM1 * LY * LK; // 1 0 1 1
  LG := LG + 0.0745 * LX;
  LX := LC * LM * LY1 * LK1; // 1 1 0 0
  LR := LR + 0.1804 * LX;
  LG := LG + 0.1922 * LX;
  LB := LB + 0.5725 * LX;
  LX := LC * LM * LY1 * LK; // 1 1 0 1
  LB := LB + 0.0078 * LX;
  LX := LC * LM * LY * LK1; // 1 1 1 0
  LR := LR + 0.2118 * LX;
  LG := LG + 0.2119 * LX;
  LB := LB + 0.2235 * LX;

  RGBColor.R := Clip01(DblToCol(LR));
  RGBColor.G := Clip01(DblToCol(LG));
  RGBColor.B := Clip01(DblToCol(LB));
end;

procedure TgtPDDeviceCMYKColorSpace.Update;
begin
  inherited;

end;

end.
