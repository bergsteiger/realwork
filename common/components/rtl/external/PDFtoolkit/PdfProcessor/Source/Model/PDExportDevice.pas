unit PDExportDevice;

interface

uses
  gtObject, PDMatrix, PDState, gtTypes, PDElement, PDImage, PDForm;

type
  TgtPDExportDevice = class(TgtObject)
  protected
    FDefaultInverseCTM: TgtPDMatrix;
    FUseShadedFill: Boolean;
    FNeedNonText: Boolean;
    FInterpretType3Chars: Boolean;
    FUseDrawChar: Boolean;
    FUseDrawForm: Boolean;
    FUseTillingPatternFill: Boolean;
    FDefaultCTM: TgtPDMatrix;
    FUpsideDown: Boolean;
    procedure SetDefaultInverseCTM(const Value: TgtPDMatrix);
  public
    //constructor
    constructor Create;
    //destructor
    destructor Destroy; override;
    // Does this device use upside-down coordinates?
    // (Upside-down means (0,0) is the top left corner of the page.)
    property UpsideDown: Boolean read FUpsideDown;
    // Does this device use drawChar() or drawString()?
    property UseDrawChar: Boolean read FUseDrawChar;
    // Does this device use tilingPatternFill()?  If this returns false,
    // tiling pattern fills will be reduced to a series of other drawing
    // operations.
    property UseTillingPatternFill: Boolean read FUseTillingPatternFill;
    // Does this device use functionShadedFill(), axialShadedFill(), and
    // radialShadedFill()?  If this returns false, these shaded fills
    // will be reduced to a series of other drawing operations.
    property UseShadedFill: Boolean read FUseShadedFill;
    // Does this device use drawForm()?  If this returns false,
    // form-type XObjects will be interpreted (i.e., unrolled).
    property UseDrawForm: Boolean read FUseDrawForm;
    // Does this device use beginType3Char/endType3Char?  Otherwise,
    // text in Type 3 fonts will be drawn with drawChar/drawString.
    property InterpretType3Chars: Boolean read FInterpretType3Chars;
    // Does this device need non-text content?
    property NeedNonText: Boolean read FNeedNonText;

    //----- initialization and control

    // Set default transform matrix.
    procedure SetDefaultCTM(Matrix: TgtPDMatrix); virtual;
    // Check to see if a page slice should be displayed.  If this
    // returns false, the page display is aborted.  Typically, an
    // OutputDev will use some alternate means to display the page
    // before returning false.
    function CheckPageSlice(Page: TgtObject; hDPI: Double; vDPI: Double;
      Rotate: Integer; UseMediaBox: Boolean; Crop: Boolean; SliceX: Double;
      SliceY: Double; SliceW: Double; SliceH: Double): Boolean; virtual;
    // Start a page.
    procedure StartPage(nPage: Integer; State: TgtPDState); virtual;
    // End a page.
    procedure EndPage; virtual;
    // Dump page contents to display.
    procedure Dump; virtual;

    //----- coordinate conversion

    // Convert between device and user coordinates.
    procedure ConvertDevToUser(Dx: Double; Dy: Double; var Ux: Double;
      var Uy: Double); virtual;
    procedure ConvertUserToDev(Ux: Double; Uy: Double; var Dx: Double;
      var Dy: Double); virtual;
    property DefaultCTM: TgtPDMatrix read FDefaultCTM write SetDefaultCTM;
    property DefaultInverseCTM: TgtPDMatrix read FDefaultInverseCTM write SetDefaultInverseCTM;


    //----- save/restore graphics state
    procedure SaveState(State: TgtPDState); virtual;
    procedure RestoreState(State: TgtPDState); virtual;

    //----- update graphics state
    procedure UpdateAll(State: TgtPDState); virtual;
    procedure UpdateCTM(State: TgtPDState; CTM: TgtPDMatrix); virtual;
    procedure UpdateLineDash(State: TgtPDState); virtual;
    procedure UpdateFlatness(State: TgtPDState); virtual;
    procedure UpdateLineJoin(State: TgtPDState); virtual;
    procedure UpdateLineCap(State: TgtPDState); virtual;
    procedure UpdateMiterLimit(State: TgtPDState); virtual;
    procedure UpdateLineWidth(State: TgtPDState); virtual;
    procedure UpdateStrokeAdjust(State: TgtPDState); virtual;
    procedure UpdateFillColorSpace(State: TgtPDState); virtual;
    procedure UpdateStrokeColorSpace(State: TgtPDState); virtual;
    procedure UpdateFillColor(State: TgtPDState); virtual;
    procedure UpdateStrokeColor(State: TgtPDState); virtual;
    procedure UpdateBlendMode(State: TgtPDState); virtual;
    procedure UpdateFillOpacity(State: TgtPDState); virtual;
    procedure UpdateStrokeOpacity(State: TgtPDState); virtual;
    procedure UpdateFillOverPrint(State: TgtPDState); virtual;
    procedure UpdateStrokeOverPrint(State: TgtPDState); virtual;
    procedure UpdateTransfer(State: TgtPDState); virtual;
    procedure ClearSoftMask(State: TgtPDState); virtual;

    //----- update text state
    procedure UpdateFont(State: TgtPDState); virtual;
    procedure UpdateTextMatrix(State: TgtPDState); virtual;
    procedure UpdateCharSpace(State: TgtPDState); virtual;
    procedure UpdateRender(State: TgtPDState); virtual;
    procedure UpdateRise(State: TgtPDState); virtual;
    procedure UpdateWordSpace(State: TgtPDState); virtual;
    procedure UpdateHorizScaling(State: TgtPDState); virtual;
    procedure UpdateTextPos(State: TgtPDState); virtual;
    procedure UpdateTextShift(State: TgtPDState; Shift: Double); virtual;

    //----- path painting
    procedure Stroke(State: TgtPDState); virtual;
    procedure Fill(State: TgtPDState); virtual;
    procedure EvenOddFill(State: TgtPDState); virtual;

    //----- path clipping
    procedure Clip(State: TgtPDState); virtual;
    procedure EvenOddClip(State: TgtPDState); virtual;
    procedure ClipToStrokePath(State: TgtPDState); virtual;

    //----- text drawing
    procedure BeginStringOp(State: TgtPDState); virtual;
    procedure EndStringOp(State: TgtPDState); virtual;
    procedure BeginString(State: TgtPDState; Str: AnsiString); virtual;
    procedure EndString(State: TgtPDState); virtual;
    procedure DrawChar(State: TgtPDState; X: Double; Y: Double;
      Dx, Dy: Double; Code: TgtCharCode; const CharName: AnsiString); virtual;
    procedure DrawString(const Str: AnsiString; State: TgtPDState); virtual;
    function BeginType3Char(State: TgtPDState; X: Double; Y: Double;
      Dx: Double; Dy: Double; Code: TgtCharCode; Unicode: TgtUnicodes;
      Len: Integer): Boolean; virtual;
    procedure EndType3Char(State: TgtPDState); virtual;
    procedure EndTextObject(State: TgtPDState); virtual;

    //----- image drawing
    procedure DrawImage(State: TgtPDState; Image: TgtPDImage); virtual;

    procedure DrawFormXObject(State: TgtPDState; Form: TgtPDForm); virtual;
    procedure ResetDevice(State: TgtPDState); virtual;

    // Raw fuctions for GetPageElements

    procedure RawTextOut(State: TgtPDState; X, Y: Double;
      const AText: Ansistring); virtual;
  end;

implementation

uses
  gtMethods;

{ TgtPDExportDevice }

procedure TgtPDExportDevice.BeginString(State: TgtPDState; Str: AnsiString);
begin

end;

procedure TgtPDExportDevice.BeginStringOp(State: TgtPDState);
begin

end;

function TgtPDExportDevice.BeginType3Char(State: TgtPDState; X, Y, Dx,
  Dy: Double; Code: TgtCharCode; Unicode: TgtUnicodes; Len: Integer): Boolean;
begin
  Result := False;
end;

function TgtPDExportDevice.CheckPageSlice(Page: TgtObject; hDPI, vDPI: Double;
  Rotate: Integer; UseMediaBox, Crop: Boolean; SliceX, SliceY, SliceW,
  SliceH: Double): Boolean;
begin
  Result := True;
end;

procedure TgtPDExportDevice.ClearSoftMask(State: TgtPDState);
begin

end;

procedure TgtPDExportDevice.Clip(State: TgtPDState);
begin

end;

procedure TgtPDExportDevice.ClipToStrokePath(State: TgtPDState);
begin

end;

procedure TgtPDExportDevice.ConvertDevToUser(Dx, Dy: Double; var Ux,
  Uy: Double);
begin
  Ux := (FDefaultInverseCTM.M11 * Dx) + (FDefaultInverseCTM.M21 * Dy) + FDefaultInverseCTM.Dx;
  Uy := (FDefaultInverseCTM.M12 * Dx) + (FDefaultInverseCTM.M22 * Dy) + FDefaultInverseCTM.Dy;
end;

procedure TgtPDExportDevice.ConvertUserToDev(Ux, Uy: Double; var Dx,
  Dy: Double);
begin
  Dx := (FDefaultCTM.M11 * Ux) + (FDefaultCTM.M21 * Uy) + FDefaultCTM.Dx + 0.5;
  Dy := (FDefaultCTM.M12 * Ux) + (FDefaultCTM.M22 * Uy) + FDefaultCTM.Dy + 0.5;
end;

constructor TgtPDExportDevice.Create;
begin

end;

destructor TgtPDExportDevice.Destroy;
begin
  if Assigned(FDefaultInverseCTM) then
    FreeObject(FDefaultInverseCTM);

  if Assigned(FDefaultCTM) then
    FreeObject(FDefaultCTM);
  inherited;
end;

procedure TgtPDExportDevice.DrawChar(State: TgtPDState; X, Y, Dx, Dy: Double;
  Code: TgtCharCode; const CharName: AnsiString);
begin

end;

procedure TgtPDExportDevice.DrawFormXObject(State: TgtPDState; Form: TgtPDForm);
begin

end;

procedure TgtPDExportDevice.DrawImage(State: TgtPDState; Image: TgtPDImage);
begin

end;

procedure TgtPDExportDevice.DrawString(const Str: AnsiString; State: TgtPDState);
begin

end;

procedure TgtPDExportDevice.Dump;
begin

end;

procedure TgtPDExportDevice.EndPage;
begin

end;

procedure TgtPDExportDevice.EndString(State: TgtPDState);
begin

end;

procedure TgtPDExportDevice.EndStringOp(State: TgtPDState);
begin

end;

procedure TgtPDExportDevice.EndTextObject(State: TgtPDState);
begin

end;

procedure TgtPDExportDevice.EndType3Char(State: TgtPDState);
begin

end;

procedure TgtPDExportDevice.EvenOddClip(State: TgtPDState);
begin

end;

procedure TgtPDExportDevice.EvenOddFill(State: TgtPDState);
begin

end;

procedure TgtPDExportDevice.Fill(State: TgtPDState);
begin

end;

procedure TgtPDExportDevice.RawTextOut(State: TgtPDState; X, Y: Double;
  const AText: Ansistring);
begin

end;

procedure TgtPDExportDevice.ResetDevice(State: TgtPDState);
begin

end;

procedure TgtPDExportDevice.RestoreState(State: TgtPDState);
begin

end;

procedure TgtPDExportDevice.SaveState(State: TgtPDState);
begin

end;

procedure TgtPDExportDevice.SetDefaultCTM(Matrix: TgtPDMatrix);
var
//  LI: Integer;
  LDet: Double;
begin
  if not Assigned(FDefaultCTM) then
    FDefaultCTM := TgtPDMatrix.Create;
  if not Assigned(FDefaultInverseCTM) then
    FDefaultInverseCTM := TgtPDMatrix.Create;

  FDefaultCTM.SetValues(Matrix.M11, Matrix.M12, Matrix.M21, Matrix.M22,
    Matrix.Dx, Matrix.Dy);

  LDet := 1 / (FDefaultCTM.M11 * FDefaultCTM.M22 - FDefaultCTM.M12 * FDefaultCTM.M21);
  FDefaultInverseCTM.M11 := FDefaultCTM.M22 * LDet;
  FDefaultInverseCTM.M12 := -FDefaultCTM.M12 * LDet;
  FDefaultInverseCTM.M21 := -FDefaultCTM.M21 * LDet;
  FDefaultInverseCTM.M22 := FDefaultCTM.M11 * LDet;
  FDefaultInverseCTM.Dx := (FDefaultCTM.M21 * FDefaultCTM.Dy -
    FDefaultCTM.M22 * FDefaultCTM.Dx) * LDet;
  FDefaultInverseCTM.Dy := (FDefaultCTM.M12 * FDefaultCTM.Dx -
    FDefaultCTM.M11 * FDefaultCTM.Dy) * LDet;
end;

procedure TgtPDExportDevice.SetDefaultInverseCTM(const Value: TgtPDMatrix);
begin

end;

procedure TgtPDExportDevice.StartPage(nPage: Integer; State: TgtPDState);
begin

end;

procedure TgtPDExportDevice.Stroke(State: TgtPDState);
begin

end;

procedure TgtPDExportDevice.UpdateAll(State: TgtPDState);
begin
  UpdateLineDash(State);
  UpdateFlatness(State);
  UpdateLineJoin(State);
  UpdateLineCap(State);
  UpdateMiterLimit(State);
  UpdateLineWidth(State);
  UpdateStrokeAdjust(State);
  UpdateFillColorSpace(State);
  UpdateFillColor(State);
  UpdateStrokeColorSpace(State);
  UpdateStrokeColor(State);
  UpdateBlendMode(State);
  UpdateFillOpacity(State);
  UpdateStrokeOpacity(State);
  UpdateFillOverPrint(State);
  UpdateStrokeOverPrint(State);
  UpdateTransfer(State);
//  UpdateFont(State);
end;

procedure TgtPDExportDevice.UpdateBlendMode(State: TgtPDState);
begin

end;

procedure TgtPDExportDevice.UpdateCharSpace(State: TgtPDState);
begin

end;

procedure TgtPDExportDevice.UpdateCTM(State: TgtPDState; CTM: TgtPDMatrix);
begin

end;

procedure TgtPDExportDevice.UpdateFillColor(State: TgtPDState);
begin

end;

procedure TgtPDExportDevice.UpdateFillColorSpace(State: TgtPDState);
begin

end;

procedure TgtPDExportDevice.UpdateFillOpacity(State: TgtPDState);
begin

end;

procedure TgtPDExportDevice.UpdateFillOverPrint(State: TgtPDState);
begin

end;

procedure TgtPDExportDevice.UpdateFlatness(State: TgtPDState);
begin

end;

procedure TgtPDExportDevice.UpdateFont(State: TgtPDState);
begin

end;

procedure TgtPDExportDevice.UpdateHorizScaling(State: TgtPDState);
begin

end;

procedure TgtPDExportDevice.UpdateLineCap(State: TgtPDState);
begin

end;

procedure TgtPDExportDevice.UpdateLineDash(State: TgtPDState);
begin

end;

procedure TgtPDExportDevice.UpdateLineJoin(State: TgtPDState);
begin

end;

procedure TgtPDExportDevice.UpdateLineWidth(State: TgtPDState);
begin

end;

procedure TgtPDExportDevice.UpdateMiterLimit(State: TgtPDState);
begin

end;

procedure TgtPDExportDevice.UpdateRender(State: TgtPDState);
begin

end;

procedure TgtPDExportDevice.UpdateRise(State: TgtPDState);
begin

end;

procedure TgtPDExportDevice.UpdateStrokeAdjust(State: TgtPDState);
begin

end;

procedure TgtPDExportDevice.UpdateStrokeColor(State: TgtPDState);
begin

end;

procedure TgtPDExportDevice.UpdateStrokeColorSpace(State: TgtPDState);
begin

end;

procedure TgtPDExportDevice.UpdateStrokeOpacity(State: TgtPDState);
begin

end;

procedure TgtPDExportDevice.UpdateStrokeOverPrint(State: TgtPDState);
begin

end;

procedure TgtPDExportDevice.UpdateTextMatrix(State: TgtPDState);
begin

end;

procedure TgtPDExportDevice.UpdateTextPos(State: TgtPDState);
begin

end;

procedure TgtPDExportDevice.UpdateTextShift(State: TgtPDState; Shift: Double);
begin

end;

procedure TgtPDExportDevice.UpdateTransfer(State: TgtPDState);
begin

end;

procedure TgtPDExportDevice.UpdateWordSpace(State: TgtPDState);
begin

end;

end.
