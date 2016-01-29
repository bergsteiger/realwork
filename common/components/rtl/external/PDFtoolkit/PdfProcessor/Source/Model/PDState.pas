unit PDState;

interface

uses
  gtObject, PDRect, PDMatrix, PDFont, PDPath, PDBaseObject, PDSubpath, PDPattern,
  PDColorSpace, PDTypes;

type
  TgtDashArray = array of Single;

//  TgtBlendMode = (bmBlendNormal, bmBlendMultiply, bmBlendScreen, bmBlendOverlay,
//            bmBlendDarken, bmBlendLighten, BlendColorDodge, bmBlendColorBurn,
//            bmBlendHardLight, bmBlendSoftLight, bmBlendDifference,
//            bmBlendExclusion, bmBlendHue, bmBlendSaturation, bmBlendColor,
//            bmBlendLuminosity);

  TgtPDState = class(TgtObject)
  private
    FPath: TgtPDPath;
    FIsCurrentPath: Boolean;
    FIsCurrentPoint: Boolean;

    FLineJoin: Integer;
    FLineDash: TgtDashArray;
    FLineLength: Integer;
    FLineStart: Double;
    FLineWidth: Double;
    FLineCap: Integer;
    FMiterLimit: Double;
    FFillOpacity: Double;
    FFlatness: Double;

    FvDPI: Double;
    FhDPI: Double;
    FPageWidth: Double;
    FPageHeight: Double;

    FX1: Double;
    FY1: Double;
    FX2: Double;
    FY2: Double;

    FLineX: Double;
    FLineY: Double;

    FCurX: Double;
    FCurY: Double;

    FCTM: TgtPDMatrix;

    FTextMatrix: TgtPDmatrix;
    FFontSize: Double;
    FFont: TgtPDFont;
    FWordSpace: Double;
    FCharSpace: Double;
    FCurCharW: Double;

    FStrokeAdjust: Boolean;
    FHorizScaling: Double;
    FFillOverprint: Boolean;
    FStrokeOverPrint: Boolean;

    FRender: Double;

    FLeading: Double;
    FStrokeOpacity: Double;
    FFillPattern: TgtPDPattern;
//    FColorSpace: TgtPDColorSpace;
    FStrokeColorSpace: TgtPDColorSpace;
    FFillColorSpace: TgtPDColorSpace;
    FFillColor: TgtColor;
    FStrokeColor: TgtColor;
    FStrokePattern: TgtPDPattern;

    FRise: Double;
    FSaved: TgtPDState; // next TgtPDState on stack

    FFillCSOwned, FStrokeCSOwned: Boolean;
    FRotate: Integer;

    procedure SetCharSpace(const Value: Double);
    procedure SetCTM(const Value: TgtPDMatrix);
    procedure SetCurX(const Value: Double);
    procedure SetCurY(const Value: Double);
    procedure SetFillOpacity(const Value: Double);
    procedure SetFillOverprint(const Value: Boolean);
    procedure SetFlatness(const Value: Double);
    procedure SetFont(const Value: TgtPDFont);
    procedure SetFontSize(const Value: Double);
    procedure SethDPI(const Value: Double);
    procedure SetHorizScaling(const Value: Double);
    procedure SetIsCurrentPath(const Value: Boolean);
    procedure SetIsCurrentPoint(const Value: Boolean);
    procedure SetLeading(const Value: Double);
    procedure SetLineCap(const Value: Integer);
    procedure SetLineJoin(const Value: Integer);
    procedure SetLineWidth(const Value: Double);
    procedure SetLineX(const Value: Double);
    procedure SetLineY(const Value: Double);
    procedure SetMiterLimit(const Value: Double);
    procedure SetPageHeight(const Value: Double);
    procedure SetPageWidth(const Value: Double);
    procedure SetPath(const Value: TgtPDPath);
    procedure SetRender(const Value: Double);
    procedure SetStrokeAdjust(const Value: Boolean);
    procedure SetStrokeOpacity(const Value: Double);
    procedure SetStrokeOverPrint(const Value: Boolean);
    procedure SetTextMatrix(const Value: TgtPDmatrix);
    procedure SetvDPI(const Value: Double);
    procedure SetWordSpace(const Value: Double);
    procedure SetX1(const Value: Double);
    procedure SetX2(const Value: Double);
    procedure SetY1(const Value: Double);
    procedure SetY2(const Value: Double);
    procedure SetRise(const Value: Double);
    procedure SetFillPattern(const Value: TgtPDPattern);
    procedure SetFillColorSpace(const Value: TgtPDColorSpace);
    procedure SetStrokeColorSpace(const Value: TgtPDColorSpace);
    procedure SetStrokePattern(const Value: TgtPDPattern);

    function GetIsCurrentPoint: Boolean;
    function GetIsCurrentPath: Boolean;
    function GetPageNumber: Integer;
  protected
    FPageNumber: Integer;
  public
    constructor Create(hDPI: Double; vDPI: Double; aRotate: Integer; PageBox: TgtPDRect); overload;
  // Destructor.
    destructor Destroy; override;

  // Copy.
    function Copy: TgtPDState;

    procedure Transform(X1, Y1: Double; var X2, Y2: Double);
    procedure TextTransformDelta(X1, Y1: Double; var X2, Y2: Double);
    procedure TransformDelta(X1, Y1: Double; var X2, Y2: Double);
    function GetFontTransMatrix: TgtPDMatrix;
    function GetTransformedFontSize: Double;


  // Accessors.
    property hDPI: Double read FhDPI write SethDPI;
    property vDPI: Double read FvDPI write SetvDPI;
    property CTM: TgtPDMatrix read FCTM write SetCTM;
    property X1: Double read FX1 write SetX1;
    property Y1: Double read FY1 write SetY1;
    property X2: Double read FX2 write SetX2;
    property Y2: Double read FY2 write SetY2;
    property PageWidth: Double read FPageWidth write SetPageWidth;
    property PageHeight: Double read FPageHeight write SetPageHeight;
    property PageNumber: Integer read GetPageNumber;
    property StrokePattern: TgtPDPattern read FStrokePattern write SetStrokePattern;
    property StrokeColorSpace: TgtPDColorSpace read FStrokeColorSpace write SetStrokeColorSpace;
    property FillColorSpace: TgtPDColorSpace read FFillColorSpace write SetFillColorSpace;
    property FillPattern: TgtPDPattern read FFillPattern write SetFillPattern;
    property FillOpacity: Double read FFillOpacity write SetFillOpacity;
    property StrokeOpacity: Double read FStrokeOpacity write SetStrokeOpacity;
    property FillOverprint: Boolean read FFillOverprint write SetFillOverprint;
    property StrokeOverPrint: Boolean read FStrokeOverPrint write SetStrokeOverPrint;
    property LineWidth: Double read FLineWidth write SetLineWidth;
    procedure GetLineDash(var Dash: TgtDashArray; var Length: Integer; var Start: Double);
    procedure SetLineDash(Dash: TgtDashArray; Length: Integer; Start: Double);
    property Flatness: Double read FFlatness write SetFlatness;
    property LineJoin: Integer read FLineJoin write SetLineJoin;
    property LineCap: Integer read FLineCap write SetLineCap;
    property MiterLimit: Double read FMiterLimit write SetMiterLimit;
    property StrokeAdjust: Boolean read FStrokeAdjust write SetStrokeAdjust;

    property Font: TgtPDFont read FFont write SetFont;
    property FontSize: Double read FFontSize write SetFontSize;
    property TextMatrix: TgtPDmatrix read FTextMatrix write SetTextMatrix;
    property CharSpace: Double read FCharSpace write SetCharSpace;
    property WordSpace: Double read FWordSpace write SetWordSpace;
    property CurCharW: Double read FCurCharW write FCurCharW;
    property HorizScaling: Double read FHorizScaling write SetHorizScaling;
    property Leading: Double read FLeading write SetLeading;
    property Rise: Double read FRise write SetRise;
    property Render: Double read FRender write SetRender;
    property Path: TgtPDPath read FPath write SetPath;
    property CurX: Double read FCurX write SetCurX;
    property CurY: Double read FCurY write SetCurY;
    property LineX: Double read FLineX write SetLineX;
    property LineY: Double read FLineY write SetLineY;
    property StrokeCSOwned: Boolean read FStrokeCSOwned write FStrokeCSOwned;
    property FillCSOwned: Boolean read FFillCSOwned write FFillCSOwned;

  // Is there a current point/path?
    property IsCurrentPoint: Boolean read GetIsCurrentPoint write SetIsCurrentPoint;
    property IsCurrentPath: Boolean read GetIsCurrentPath write SetIsCurrentPath;

    procedure GetFillColor(var FillColor: TgtColor);
    procedure SetFillColor(const Value: TgtColor);

    procedure GetFillGray(var Gray: TgtGray);
    procedure GetFillRGB(var RGB: TgtRGB);
    procedure GetFillCMYK(var CMYK: TgtCMYK);


    procedure GetStrokeColor(var StrokeColor: TgtColor);
    procedure SetStrokeColor(const Value: TgtColor);

    procedure GetStrokeGray(var Gray: TgtGray);
    procedure GetStrokeRGB(var RGB: TgtRGB);
    procedure GetStrokeCMYK(var CMYK: TgtCMYK);

    procedure ConcatCTM(Matrix: TgtPDMatrix);

  //Path Operations
    procedure MoveTo(X: Double; Y: Double);
    procedure LineTo(X: Double; Y: Double);
    procedure CurveTo(X1, Y1, X2, Y2, X3, Y3: Double);
    procedure ClosePath;
    procedure ClearPath;

  // Text position.
    procedure TextSetPos(Tx, Ty: Double);
    procedure TextMoveTo(Tx, Ty: Double);
    procedure TextShift(Tx, Ty: Double);
    procedure Shift(Dx, Dy: Double);

  // Push/pop GfxState on/off stack.
    function Save: TgtPDState;
    function Restore: TgtPDState;
    function HasSaves: Boolean;
  end;

implementation

{ TgtPDState }
uses
  Math, gtMethods, PDDeviceGrayColorSpace;

procedure TgtPDState.ClearPath;
begin
  if Assigned(FPath) then
    FreeObject(FPath);
  FPath := TgtPDPath.Create;
end;

procedure TgtPDState.ClosePath;
begin
  FPath.Close;
  FCurX := FPath.LastX;
  FCurY := FPath.LastY;
end;

procedure TgtPDState.ConcatCTM(Matrix: TgtPDMatrix);
var
//  I: Integer;
  tempMatrix: TgtPDMatrix;
begin
  tempMatrix := TgtPDMatrix.Create;
  tempMatrix.SetValues(FCTM.M11, FCTM.M12, FCTM.M21, FCTM.M22, FCTM.Dx, FCTM.Dy);

  FCTM.M11 := Matrix.M11 * tempMatrix.M11 + Matrix.M12 * tempMatrix.M21;
  FCTM.M12 := Matrix.M11 * tempMatrix.M12 + Matrix.M12 * tempMatrix.M22;
  FCTM.M21 := Matrix.M21 * tempMatrix.M11 + Matrix.M22 * tempMatrix.M21;
  FCTM.M22 := Matrix.M21 * tempMatrix.M12 + Matrix.M22 * tempMatrix.M22;
  FCTM.Dx := Matrix.Dx * tempMatrix.M11 + Matrix.Dy * tempMatrix.M21 + tempMatrix.Dx;
  FCTM.Dy := Matrix.Dx * tempMatrix.M12 + Matrix.Dy * tempMatrix.M22 + tempMatrix.Dy;

  tempMatrix.Free;

  // avoid FP exceptions on badly messed up PDF files
  with FCTM do
  begin
    if M11 > 1E10 then
      M11 := 1E10
    else if M11 < -1E10 then
      M11 := -1E10;

    if M12 > 1E10 then
      M12 := 1E10
    else if M12 < -1E10 then
      M12 := -1E10;

    if M21 > 1E10 then
      M21 := 1E10
    else if M21 < -1E10 then
      M21 := -1E10;

    if M22 > 1E10 then
      M22 := 1E10
    else if M22 < -1E10 then
      M22 := -1E10;

    if Dx > 1E10 then
      Dx := 1E10
    else if Dx < -1E10 then
      Dx := -1E10;

    if Dy > 1E10 then
      Dy := 1E10
    else if Dy < -1E10 then
      Dy := -1E10;
  end;

end;

function TgtPDState.Copy: TgtPDState;
var
  I: Integer;
begin
  Result := TgtPDState.Create;

  Result.FSaved := Self.FSaved;

  Result.FX1 := Self.FX1;
  Result.FY1 := Self.FY1;
  Result.FX2 := Self.FX2;
  Result.FY2 := Self.FY2;
  Result.FvDPI := Self.FvDPI;
  Result.FhDPI := Self.FhDPI;
  Result.FPageWidth := Self.PageWidth;
  Result.FPageHeight := Self.PageHeight;

  Result.FLineJoin := Self.FLineJoin;
  Result.FPath := Self.FPath.Copy;
  Result.FLineLength := Self.FLineLength;
  Result.FLineStart := Self.FLineStart;
  Result.FLineWidth := Self.FLineWidth;
  Result.FLineCap := Self.FLineCap;
  Result.FFontSize := Self.FFontSize;
  Result.FPageWidth := Self.FPageWidth;
  Result.FStrokeAdjust := Self.FStrokeAdjust;
  Result.FLineX := Self.FLineX;
  Result.FLineY := Self.FLineY;
  Result.FCTM := Self.FCTM.Copy;
  Result.FHorizScaling := Self.FHorizScaling;
  Result.FFillOverprint := Self.FFillOverprint;
  Result.FCurX := Self.FCurX;
  Result.FCurY := Self.FCurY;
  Result.FFont := Self.FFont; //Font is destroyed by FResource
  Result.FTextMatrix := Self.FTextMatrix.Copy;
  Result.FStrokeOverPrint := Self.FStrokeOverPrint;
  Result.FWordSpace := Self.FWordSpace;
  Result.FMiterLimit := Self.FMiterLimit;
  Result.FFillOpacity := Self.FFillOpacity;
  Result.FFlatness := Self.FFlatness;
  Result.FPageHeight := Self.FPageHeight;
  Result.FRender := Self.FRender;
  Result.FIsCurrentPoint := Self.FIsCurrentPoint;
  Result.FLeading := Self.FLeading;
  Result.FCharSpace := Self.FCharSpace;
  Result.FIsCurrentPath := Self.FIsCurrentPath;
  Result.FStrokeOpacity := Self.FStrokeOpacity;
  Result.FPageNumber := Self.FPageNumber;
  Result.FFillColor := Self.FFillColor;
  Result.FStrokeColor := Self.FStrokeColor;
  Result.FFillColorSpace := Self.FFillColorSpace;
  Result.FStrokeColorSpace := Self.FStrokeColorSpace;

  Result.FRise := Self.FRise;
  {
    transfer function
  }
  if FLineLength > 0 then
  begin
    Result.FLineLength := Self.FLineLength;
    SetLength(Result.FLineDash, Result.FLineLength);
    for I := 0 to FLineLength - 1 do
      Result.FLineDash[I] := Self.FLineDash[I];
  end;
  //Color Space and Patterns to be copied

end;

constructor TgtPDState.Create(hDPI, vDPI: Double; aRotate: Integer; PageBox: TgtPDRect);
var
  LKx, LKy: Double;
  LI: Integer;
begin
  FhDPI := hDPI;
  FvDPI := vDPI;

  if Assigned(PageBox) then
  begin
    FX1 := PageBox.Left;
    FY1 := PageBox.Top;
    FX2 := PageBox.Right;
    FY2 := PageBox.Bottom;
  end
  else
  begin
    FX1 := 0;
    FY1 := 0;
    FX2 := 850;
    FY2 := 1191;
  end;

  LKx := hDPI / 72;
  LKy := vDPI / 72;
  FRotate := aRotate;

  FCTM := TgtPDMatrix.Create;

  if FRotate = 90 then
  begin
    FCTM.M11 := 0;
    FCTM.M12 := -LKy;
    FCTM.M21 := LKx;
    FCTM.M22 := 0;
    FCTM.Dx := -LKx * FY1;
    FCTM.Dy := LKy * FX2;
    FPageWidth := LKx * (FY2 - FY1);
    FPageHeight := LKy * (FX2 - FX1);
  end
  else if FRotate = 180 then
  begin
    FCTM.M11 := -LKy;
    FCTM.M12 := 0;
    FCTM.M21 := 0;
    FCTM.M22 := -LKx;
    FCTM.Dx := LKx * FX2;
    FCTM.Dy := LKy * FY2;
    FPageWidth := LKx * (FX2 - FX1);
    FPageHeight := LKy * (FY2 - FY1);
  end
  else if FRotate = 270 then
  begin
    FCTM.M11 := 0;
    FCTM.M12 := LKy;
    FCTM.M21 := -LKx;
    FCTM.M22 := 0;
    FCTM.Dx := LKx * FY2;
    FCTM.Dy := LKy * -FX1;
    FPageWidth := LKy * (FY2 - FY1);
    FPageHeight := LKx * (FX2 - FX1);
  end
  else
  begin
    FCTM.M11 := LKx;
    FCTM.M12 := 0;
    FCTM.M21 := 0;
    FCTM.M22 := LKy;
    FCTM.Dx := -LKx * FX1;
    FCTM.Dy := LKy * -FY1;
    FPageWidth := LKx * (FX2 - FX1);
    FPageHeight := LKy * (FY2 - FY1);
  end;

  //Color space defaults
  FFillColorSpace := TgtPDDeviceGrayColorSpace.Create;
  FStrokeColorSpace := TgtPDDeviceGrayColorSpace.Create;

  FFillCSOwned := True;
  FStrokeCSOwned := True;

  FLineWidth := 1;
  FFlatness := 1;
  FLineJoin := 0;
  FLineDash := nil;
  FLineCap := 0;
  FMiterLimit := 10;
  FStrokeAdjust := False;
  FFillOpacity := 1;
  FStrokeOpacity := 1;

  FFont := nil;
  FFontSize := 0;
  FTextMatrix := TgtPDMatrix.Create;
  FCharSpace := 0;
  FWordSpace := 0;
  FCurCharW := 0;
  FHorizScaling := 1;
  FLeading := 0;
  FRise := 0;
  FRender := 0;

  FPath := TgtPDPath.Create;

  FCurX := 0;
  FCurY := 0;
  FLineX := 0;
  FLineY := 0;

  FSaved := nil;

  for LI := 0 to ColorMapMaxComps - 1 do
  begin
    FFillColor.Comps[LI] := 0;
    FStrokeColor.Comps[LI] := 0;
  end;
  FPageNumber := 0;
end;

procedure TgtPDState.CurveTo(X1, Y1, X2, Y2, X3, Y3: Double);
begin
  FPath.CurveTo(X1, Y1, X2, Y2, X3, Y3);
  FCurX := X3;
  FCurY := Y3;
end;

destructor TgtPDState.Destroy;
begin
  if Assigned(FPath) then FPath.Free;
  if Assigned(FCTM) then FCTM.Free;
  if Assigned(FTextMatrix) then FTextMatrix.Free;
  if FStrokeCSOwned and Assigned(FStrokeColorSpace) then FStrokeColorSpace.Free;
  if FFillCSOwned and Assigned(FFillColorSpace) then FFillColorSpace.Free;
  SetLength(FLineDash, 0);
end;

procedure TgtPDState.GetFillCMYK(var CMYK: TgtCMYK);
begin
  if Assigned(FFillColorSpace) then
    FFillColorSpace.GetCMYK(FFillColor, CMYK)
  else
  begin
    CMYK.C := 0;
    CMYK.M := 0;
    CMYK.Y := 0;
    CMYK.K := 0;
  end;
end;

procedure TgtPDState.GetFillColor(var FillColor: TgtColor);
begin
  FillColor := FFillColor;
end;

procedure TgtPDState.GetFillGray(var Gray: TgtGray);
begin
  if Assigned(FFillColorSpace) then
    FFillColorSpace.GetGray(FFillColor, Gray)
  else
    Gray := 0;
end;

procedure TgtPDState.GetFillRGB(var RGB: TgtRGB);
begin
  if Assigned(FFillColorSpace) then
    FFillColorSpace.GetRGB(FFillColor, RGB)
  else
  begin
    RGB.R := FFillColor.Comps[0];
    RGB.G := FFillColor.Comps[1];
    RGB.B := FFillColor.Comps[2];
  end;
end;

function TgtPDState.GetFontTransMatrix: TgtPDMatrix;
begin
  Result := TgtPDMatrix.Create;
  Result.M11 := (FTextMatrix.M11 * FCTM.M11 + FTextMatrix.M12 * FCTM.M21)
    * FFontSize;
  Result.M12 := (FTextMatrix.M11 * FCTM.M12 + FTextMatrix.M12 * FCTM.M22)
    * FFontSize;
  Result.M21 := (FTextMatrix.M21 * FCTM.M11 + FTextMatrix.M22 * FCTM.M21)
    * FFontSize;
  Result.M22 := (FTextMatrix.M21 * FCTM.M12 + FTextMatrix.M22 * FCTM.M22)
    * FFontSize;
end;

function TgtPDState.GetIsCurrentPath: Boolean;
begin
  Result := FPath.IsPath;
end;

function TgtPDState.GetIsCurrentPoint: Boolean;
begin
  Result := FPath.IsCurrentPoint;
end;

procedure TgtPDState.GetLineDash(var Dash: TgtDashArray; var Length: Integer; var Start: Double);
begin
  Dash := FLineDash;
  Start := FLineStart;
  Length := FLineLength;
end;

function TgtPDState.GetPageNumber: Integer;
begin
  Result := FPageNumber;
end;

procedure TgtPDState.GetStrokeCMYK(var CMYK: TgtCMYK);
begin
  if Assigned(FStrokeColorSpace) then
    FStrokeColorSpace.GetCMYK(FStrokeColor, CMYK)
  else
  begin
    CMYK.C := 0;
    CMYK.M := 0;
    CMYK.Y := 0;
    CMYK.K := 0;
  end;
end;

procedure TgtPDState.GetStrokeColor(var StrokeColor: TgtColor);
begin
  StrokeColor := FStrokeColor;
end;

procedure TgtPDState.GetStrokeGray(var Gray: TgtGray);
begin
  if Assigned(FStrokeColorSpace) then
    FStrokeColorSpace.GetGray(FStrokeColor, Gray)
  else
    Gray := 0;
end;

procedure TgtPDState.GetStrokeRGB(var RGB: TgtRGB);
begin
  if Assigned(FStrokeColorSpace) then
    FStrokeColorSpace.GetRGB(FStrokeColor, RGB)
  else
  begin
    RGB.R := 0;
    RGB.G := 0;
    RGB.B := 0;
  end;
end;

function TgtPDState.GetTransformedFontSize: Double;
var
  X1, X2, Y1, Y2: Double;
begin
  X1 := FTextMatrix.M21 * FFontSize;
  Y1 := FTextMatrix.M22 * FFontSize;
  X2 := FCTM.M11 * X1 + FCTM.M21 * Y1;
  Y2 := FCTM.M12 * X1 + FCTM.M22 * Y1;
  Result := Power((X2 * X2 + Y2 * Y2), 0.5);
end;

function TgtPDState.HasSaves: Boolean;
begin
  if Assigned(FSaved) then Result := True
  else Result := False;
end;

procedure TgtPDState.LineTo(X, Y: Double);
begin
  FPath.LineTo(X, Y);
  FCurX := X;
  FCurY := Y;
end;

procedure TgtPDState.MoveTo(X, Y: Double);
begin
  FPath.MoveTo(X, Y);
  FCurX := X;
  FCurY := Y
end;

function TgtPDState.Restore: TgtPDState;
var
  LOldState: TgtPDState;
begin
  if Assigned(FSaved) then
  begin
    LOldState := FSaved;
    if Assigned(LOldState.Path) then
      LOldState.Path.Free;

    LOldState.Path := FPath;
    LOldState.FCurX := FCurX;
    LOldState.FCurY := FCurY;
    LOldState.FLineX := FLineX;
    LOldState.FLineY := FLineY;


    FPath := nil;
    FSaved := nil;
    Self.Free;
  end
  else
  begin
    LOldState := Self;
  end;

  Result := LOldState;
end;

function TgtPDState.Save: TgtPDState;
begin
  Result := Copy;
  Result.FSaved := Self;
end;

procedure TgtPDState.SetCharSpace(const Value: Double);
begin
  FCharSpace := Value;
end;

procedure TgtPDState.SetCTM(const Value: TgtPDMatrix);
begin
  FCTM := Value;
end;

procedure TgtPDState.SetCurX(const Value: Double);
begin
  FCurX := Value;
end;

procedure TgtPDState.SetCurY(const Value: Double);
begin
  FCurY := Value;
end;

procedure TgtPDState.SetFillColor(const Value: TgtColor);
begin
  FFillColor := Value;
end;

procedure TgtPDState.SetFillColorSpace(const Value: TgtPDColorSpace);
begin
  if FFillCSOwned and Assigned(FFillColorSpace) then
    FreeObject(FFillColorSpace);
  FFillColorSpace := Value;
end;

procedure TgtPDState.SetFillOpacity(const Value: Double);
begin
  FFillOpacity := Value;
end;

procedure TgtPDState.SetFillOverprint(const Value: Boolean);
begin
  FFillOverprint := Value;
end;

procedure TgtPDState.SetFillPattern(const Value: TgtPDPattern);
begin
//  if Assigned(FFillPattern) then
//    FreeObject(FFillPattern);
  FFillPattern := Value;
end;

procedure TgtPDState.SetFlatness(const Value: Double);
begin
  FFlatness := Value;
end;

procedure TgtPDState.SetFont(const Value: TgtPDFont);
begin
  FFont := Value;
end;

procedure TgtPDState.SetFontSize(const Value: Double);
begin
  FFontSize := Value;
end;

procedure TgtPDState.SethDPI(const Value: Double);
begin
  FhDPI := Value;
end;

procedure TgtPDState.SetHorizScaling(const Value: Double);
begin
  FHorizScaling := Value;
end;

procedure TgtPDState.SetIsCurrentPath(const Value: Boolean);
begin
  FIsCurrentPath := Value;
end;

procedure TgtPDState.SetIsCurrentPoint(const Value: Boolean);
begin
  FIsCurrentPoint := Value;
end;

procedure TgtPDState.SetLeading(const Value: Double);
begin
  FLeading := Value;
end;

procedure TgtPDState.SetLineCap(const Value: Integer);
begin
  FLineCap := Value;
end;

procedure TgtPDState.SetLineDash(Dash: TgtDashArray; Length: Integer;
  Start: Double);
var
  LI: Integer;
begin
  SetLength(FLineDash, Length);
  for LI := 0 to Length - 1 do
    FLineDash[LI] := Dash[LI];

  FLineLength := Length;
  FLineStart := Start;
end;

procedure TgtPDState.SetLineJoin(const Value: Integer);
begin
  FLineJoin := Value;
end;

procedure TgtPDState.SetLineWidth(const Value: Double);
begin
  FLineWidth := Value;
end;

procedure TgtPDState.SetLineX(const Value: Double);
begin
  FLineX := Value;
end;

procedure TgtPDState.SetLineY(const Value: Double);
begin
  FLineY := Value;
end;

procedure TgtPDState.SetMiterLimit(const Value: Double);
begin
  FMiterLimit := Value;
end;

procedure TgtPDState.SetPageHeight(const Value: Double);
begin
  FPageHeight := Value;
end;

procedure TgtPDState.SetPageWidth(const Value: Double);
begin
  FPageWidth := Value;
end;

procedure TgtPDState.SetPath(const Value: TgtPDPath);
begin
  FPath := Value;
end;

procedure TgtPDState.SetRender(const Value: Double);
begin
  FRender := Value;
end;

procedure TgtPDState.SetRise(const Value: Double);
begin
  FRise := Value;
end;

procedure TgtPDState.SetStrokeAdjust(const Value: Boolean);
begin
  FStrokeAdjust := Value;
end;

procedure TgtPDState.SetStrokeColor(const Value: TgtColor);
var
  LI: Integer;
begin
  for LI := 0 to 3 do
    FStrokeColor.Comps[LI] := Value.Comps[LI];
end;

procedure TgtPDState.SetStrokeColorSpace(const Value: TgtPDColorSpace);
begin
  if FStrokeCSOwned and Assigned(FStrokeColorSpace) then
    FreeObject(FStrokeColorSpace);
  FStrokeColorSpace := Value;
end;

procedure TgtPDState.SetStrokeOpacity(const Value: Double);
begin
  FStrokeOpacity := Value;
end;

procedure TgtPDState.SetStrokeOverPrint(const Value: Boolean);
begin
  FStrokeOverPrint := Value;
end;

procedure TgtPDState.SetStrokePattern(const Value: TgtPDPattern);
begin
//  if Assigned(FStrokePattern) then
//    FStrokePattern.Free;
  FStrokePattern := Value;
end;

procedure TgtPDState.SetTextMatrix(const Value: TgtPDmatrix);
begin
  FTextMatrix := Value;
end;

procedure TgtPDState.SetvDPI(const Value: Double);
begin
  FvDPI := Value;
end;

procedure TgtPDState.SetWordSpace(const Value: Double);
begin
  FWordSpace := Value;
end;

procedure TgtPDState.SetX1(const Value: Double);
begin
  FX1 := Value;
end;

procedure TgtPDState.SetX2(const Value: Double);
begin
  FX2 := Value;
end;

procedure TgtPDState.SetY1(const Value: Double);
begin
  FY1 := Value;
end;

procedure TgtPDState.SetY2(const Value: Double);
begin
  FY2 := Value;
end;

procedure TgtPDState.Shift(Dx, Dy: Double);
begin
  FCurX := FCurX + Dx;
  FCurY := FCurY + Dy;
end;

procedure TgtPDState.TextMoveTo(Tx, Ty: Double);
begin
  FLineX := Tx;
  FLineY := Ty;
  CurX := LineX;
  CurY := LineY;
end;

procedure TgtPDState.TextSetPos(Tx, Ty: Double);
begin
  LineX := Tx;
  LineY := Ty;
end;

procedure TgtPDState.TextShift(Tx, Ty: Double);
begin
  FCurX := FCurX + Tx;
  FCurY := FCurY + Ty;
end;

procedure TgtPDState.TextTransformDelta(X1, Y1: Double; var X2, Y2: Double);
begin
  X2 := FTextMatrix.M11 * X1 + FTextMatrix.M12 * Y1;
  Y2 := FTextMatrix.M21 * X1 + FTextMatrix.M22 * Y1;
end;

procedure TgtPDState.Transform(X1, Y1: Double; var X2, Y2: Double);
begin
  X2 := FCTM.M11 * X1 + FCTM.M21 * Y1 + FCTM.Dx;
  Y2 := FCTM.M12 * X1 + FCTM.M22 * Y1 + FCTM.Dy;
end;

procedure TgtPDState.TransformDelta(X1, Y1: Double; var X2, Y2: Double);
begin
  X2 := FCTM.M11 * X1 + FCTM.M21 * Y1;
  Y2 := FCTM.M12 * X1 + FCTM.M22 * Y1;
end;

end.
