unit CoPDExportDevice;

interface

uses
  PDExportDeviceIntf, PDExportDevice, Contnrs, gtObjectIntf, PDStateIntf,
  PDMatrixIntf, CoPDState, gtTypes, CogtObject, PDMatrix, CoPDMatrix,
  gtMethods;

type
  TgtCoPDExportDevice = class(IgtPDExportDevice)
  private
    FPDExportDevice: TgtPDExportDevice;
    FObjectList: TObjectList;
  public
    constructor Create;
    destructor Destroy; override;

    function GetUpsideDown: WordBool; override;
    function UseDrawChar: WordBool; override;
    function UseTillingPatternFill: WordBool; override;
    function UseShadedFill: WordBool; override;
    function UseDrawForm: WordBool; override;
    function InterpretType3Chars: WordBool; override;
    function NeedNonText: WordBool; override;

    function CheckPageSlice(Page: IgtObject; hDPI: Double; vDPI: Double;
      Rotate: Integer; UseMediaBox: WordBool; Crop: WordBool; SliceX: Double;
      SliceY: Double; SliceW: Double; SliceH: Double): WordBool; override;
    procedure StartPage(nPage: Integer; State: IgtPDState); override;
    procedure EndPage; override;
    procedure Dump; override;

    procedure ConvertDevToUser(Dx: Double; Dy: Double; var Ux: Double;
      var Uy: Double); override;
    procedure ConvertUserToDev(Ux: Double; Uy: Double; var Dx: Double;
      var Dy: Double); override;
    function GetDefaultCTM: IgtPDMatrix; override;
    procedure SetDefaultCTM(Matrix: IgtPDMatrix); override;
    function GetDefaultInverseCTM: IgtPDMatrix; override;
    procedure SetDefaultInverseCTM(const Value: IgtPDMatrix); override;

    procedure SaveState(State: IgtPDState); override;
    procedure RestoreState(State: IgtPDState); override;

    procedure UpdateAll(State: IgtPDState); override;
    procedure UpdateCTM(State: IgtPDState; CTM: IgtPDMatrix); override;
    procedure UpdateLineDash(State: IgtPDState); override;
    procedure UpdateFlatness(State: IgtPDState); override;
    procedure UpdateLineJoin(State: IgtPDState); override;
    procedure UpdateLineCap(State: IgtPDState); override;
    procedure UpdateMiterLimit(State: IgtPDState); override;
    procedure UpdateLineWidth(State: IgtPDState); override;
    procedure UpdateStrokeAdjust(State: IgtPDState); override;
    procedure UpdateFillColorSpace(State: IgtPDState); override;
    procedure UpdateStrokeColorSpace(State: IgtPDState); override;
    procedure UpdateFillColor(State: IgtPDState); override;
    procedure UpdateStrokeColor(State: IgtPDState); override;
    procedure UpdateBlendMode(State: IgtPDState); override;
    procedure UpdateFillOpacity(State: IgtPDState); override;
    procedure UpdateStrokeOpacity(State: IgtPDState); override;
    procedure UpdateFillOverPrint(State: IgtPDState); override;
    procedure UpdateStrokeOverPrint(State:  IgtPDState); override;
    procedure UpdateTransfer(State: IgtPDState); override;
    procedure ClearSoftMask(State: IgtPDState); override;

    procedure UpdateFont(State: IgtPDState); override;
    procedure UpdateTextMatrix(State: IgtPDState); override;
    procedure UpdateCharSpace(State: IgtPDState); override;
    procedure UpdateRender(State: IgtPDState); override;
    procedure UpdateRise(State: IgtPDState); override;
    procedure UpdateWordSpace(State: IgtPDState); override;
    procedure UpdateHorizScaling(State: IgtPDState); override;
    procedure UpdateTextPos(State: IgtPDState); override;
    procedure UpdateTextShift(State: IgtPDState; Shift: Double); override;

    procedure Stroke(State: IgtPDState); override;
    procedure Fill(State: IgtPDState); override;
    procedure EvenOddFill(State: IgtPDState); override;

    procedure Clip(State: IgtPDState); override;
    procedure EvenOddClip(State: IgtPDState); override;
    procedure ClipToStrokePath(State: IgtPDState); override;

    procedure BeginStringOp(State: IgtPDState); override;
    procedure EndStringOp(State: IgtPDState); override;
    procedure BeginString(State: IgtPDState; Str: WideString); override;
    procedure EndString(State: IgtPDState); override;
    procedure DrawChar(State: IgtPDState; X: Double; Y: Double;
      Dx: Double; Dy: Double; OrginX: Double; OrginY: Double;
      Code: TCharCode; Unicode: TUnicodes); override;
    procedure DrawString(const Str: WideString; State: IgtPDState);
    function BeginType3Char(State: IgtPDState; X: Double; Y: Double;
      Dx: Double; Dy: Double; Code: TCharCode; Unicode: TUnicodes;
      Len: Integer): WordBool; override;
    procedure EndType3Char(State: IgtPDState); override;
    procedure EndTextObject(State: IgtPDState); override;
    //procedure DrawImage(State: IgtPDState; Image: TgtPDImage); override;
  end;

  TgtHackCoPDState = class(TgtCoPDState)

  end;

  TgtHackCoPDMatrix = class(TgtCoPDMatrix)

  end;

  TgtHackCogtObject = class(TgtCoObject)

  end;

implementation

{ TgtCoPDExportDevice }

procedure TgtCoPDExportDevice.BeginString(State: IgtPDState; Str: WideString);
begin
  FPDExportDevice.BeginString(TgtHackCoPDState(State).State, Str);
end;

procedure TgtCoPDExportDevice.BeginStringOp(State: IgtPDState);
begin
  FPDExportDevice.BeginStringOp(TgtHackCoPDState(State).State);
end;

function TgtCoPDExportDevice.BeginType3Char(State: IgtPDState; X, Y, Dx,
  Dy: Double; Code: TCharCode; Unicode: TUnicodes; Len: Integer): WordBool;
var
  LUnicodes: TgtUnicodes;
  LI: Integer;
begin
  for LI := 0 to (Length(Unicode) - 1) do
  begin
    LUnicodes[LI] := Unicode[LI];
  end;
  FPDExportDevice.BeginType3Char(TgtHackCoPDState(State).State, X, Y, Dx, Dy,
    Code, LUnicodes, Len);
end;

function TgtCoPDExportDevice.CheckPageSlice(Page: IgtObject; hDPI, vDPI: Double;
  Rotate: Integer; UseMediaBox, Crop: WordBool; SliceX, SliceY, SliceW,
  SliceH: Double): WordBool;
begin
  FPDExportDevice.CheckPageSlice(TgtHackCogtObject(Page).gtObject,
    hDPI, vDPI, Rotate, UseMediaBox, Crop, SliceX, SliceY, SliceW, SliceH);
end;

procedure TgtCoPDExportDevice.ClearSoftMask(State: IgtPDState);
begin
  FPDExportDevice.ClearSoftMask(TgtHackCoPDState(State).State);
end;

procedure TgtCoPDExportDevice.Clip(State: IgtPDState);
begin
  FPDExportDevice.Clip(TgtHackCoPDState(State).State);
end;

procedure TgtCoPDExportDevice.ClipToStrokePath(State: IgtPDState);
begin
  FPDExportDevice.ClipToStrokePath(TgtHackCoPDState(State).State);
end;

procedure TgtCoPDExportDevice.ConvertDevToUser(Dx, Dy: Double; var Ux,
  Uy: Double);
begin
  FPDExportDevice.ConvertDevToUser(Dx, Dy, Ux, Uy);
end;

procedure TgtCoPDExportDevice.ConvertUserToDev(Ux, Uy: Double; var Dx,
  Dy: Double);
begin
  FPDExportDevice.ConvertUserToDev(Ux, Uy, Dx, Dy);
end;

constructor TgtCoPDExportDevice.Create;
begin
  if not Assigned(FObjectList) then
    FObjectList := TObjectList.Create;
end;

destructor TgtCoPDExportDevice.Destroy;
begin
  if Assigned (FObjectList) then
    FreeObject(FObjectList);
  inherited;
end;

procedure TgtCoPDExportDevice.DrawChar(State: IgtPDState; X, Y, Dx, Dy, OrginX,
  OrginY: Double; Code: TCharCode; Unicode: TUnicodes);
var
  LUnicodes: TgtUnicodes;
  LI: Integer;
begin
  for LI := 0 to (Length(Unicode) - 1) do
  begin
    LUnicodes[LI] := Unicode[LI];
  end;
  FPDExportDevice.DrawChar(TgtHackCoPDState(State).State, X, Y, Dx, Dy,
    OrginX, OrginY, Code, LUnicodes);
end;

procedure TgtCoPDExportDevice.DrawString(const Str: WideString;
  State: IgtPDState);
begin
  FPDExportDevice.DrawString(Str, TgtHackCoPDState(State).State);
end;

procedure TgtCoPDExportDevice.Dump;
begin
  FPDExportDevice.Dump;
end;

procedure TgtCoPDExportDevice.EndPage;
begin
  FPDExportDevice.EndPage;
end;

procedure TgtCoPDExportDevice.EndString(State: IgtPDState);
begin
  FPDExportDevice.EndString(TgtHackCoPDState(State).State);
end;

procedure TgtCoPDExportDevice.EndStringOp(State: IgtPDState);
begin
  FPDExportDevice.EndStringOp(TgtHackCoPDState(State).State);
end;

procedure TgtCoPDExportDevice.EndTextObject(State: IgtPDState);
begin
  FPDExportDevice.EndTextObject(TgtHackCoPDState(State).State);
end;

procedure TgtCoPDExportDevice.EndType3Char(State: IgtPDState);
begin
  FPDExportDevice.EndType3Char(TgtHackCoPDState(State).State);
end;

procedure TgtCoPDExportDevice.EvenOddClip(State: IgtPDState);
begin
  FPDExportDevice.EvenOddClip(TgtHackCoPDState(State).State);
end;

procedure TgtCoPDExportDevice.EvenOddFill(State: IgtPDState);
begin
  FPDExportDevice.EvenOddFill(TgtHackCoPDState(State).State);
end;

procedure TgtCoPDExportDevice.Fill(State: IgtPDState);
begin
  FPDExportDevice.Fill(TgtHackCoPDState(State).State);
end;

function TgtCoPDExportDevice.GetDefaultCTM: IgtPDMatrix;
var
  LPDMatrix: TgtPDMatrix;
  LCoPDMatrix: TgtCoPDMatrix;
begin
  LPDMatrix := FPDExportDevice.DefaultCTM;
//  LCoPDMatrix := TgtCoPDMatrix.Create(LPDMatrix);
  Result := LCoPDMatrix;
  FObjectList.Add(LCoPDMatrix);
end;

function TgtCoPDExportDevice.GetDefaultInverseCTM: IgtPDMatrix;
var
  LPDMatrix: TgtPDMatrix;
  LCoPDMatrix: TgtCoPDMatrix;
begin
  LPDMatrix := FPDExportDevice.DefaultInverseCTM;
//  LCoPDMatrix := TgtCoPDMatrix.Create(LPDMatrix);
  Result := LCoPDMatrix;
  FObjectList.Add(LCoPDMatrix);
end;

function TgtCoPDExportDevice.GetUpsideDown: WordBool;
begin
  Result := FPDExportDevice.UpsideDown;
end;

function TgtCoPDExportDevice.InterpretType3Chars: WordBool;
begin
  Result := FPDExportDevice.InterpretType3Chars;
end;

function TgtCoPDExportDevice.NeedNonText: WordBool;
begin
  Result := FPDExportDevice.NeedNonText;
end;

procedure TgtCoPDExportDevice.RestoreState(State: IgtPDState);
begin
  FPDExportDevice.RestoreState(TgtHackCoPDState(State).State);
end;

procedure TgtCoPDExportDevice.SaveState(State: IgtPDState);
begin
  FPDExportDevice.SaveState(TgtHackCoPDState(State).State);
end;

procedure TgtCoPDExportDevice.SetDefaultCTM(Matrix: IgtPDMatrix);
begin
//  FPDExportDevice.DefaultCTM := TgtHackCoPDMatrix(Matrix).PDMatrix;
end;

procedure TgtCoPDExportDevice.SetDefaultInverseCTM(const Value: IgtPDMatrix);
begin
//  FPDExportDevice.DefaultInverseCTM := TgtHackCoPDMatrix(Value).PDMatrix;
end;

procedure TgtCoPDExportDevice.StartPage(nPage: Integer; State: IgtPDState);
begin
  FPDExportDevice.StartPage(nPage, TgtHackCoPDState(State).State);
end;

procedure TgtCoPDExportDevice.Stroke(State: IgtPDState);
begin
  FPDExportDevice.Stroke(TgtHackCoPDState(State).State);
end;

procedure TgtCoPDExportDevice.UpdateAll(State: IgtPDState);
begin
  FPDExportDevice.UpdateAll(TgtHackCoPDState(State).State);
end;

procedure TgtCoPDExportDevice.UpdateBlendMode(State: IgtPDState);
begin
  FPDExportDevice.UpdateBlendMode(TgtHackCoPDState(State).State);
end;

procedure TgtCoPDExportDevice.UpdateCharSpace(State: IgtPDState);
begin
  FPDExportDevice.UpdateCharSpace(TgtHackCoPDState(State).State);
end;

procedure TgtCoPDExportDevice.UpdateCTM(State: IgtPDState; CTM: IgtPDMatrix);
begin
//  FPDExportDevice.UpdateCTM(TgtHackCoPDState(State).State,
//    TgtHackCoPDMatrix(CTM).PDMatrix);
end;

procedure TgtCoPDExportDevice.UpdateFillColor(State: IgtPDState);
begin
  FPDExportDevice.UpdateFillColor(TgtHackCoPDState(State).State);
end;

procedure TgtCoPDExportDevice.UpdateFillColorSpace(State: IgtPDState);
begin
  FPDExportDevice.UpdateFillColorSpace(TgtHackCoPDState(State).State);
end;

procedure TgtCoPDExportDevice.UpdateFillOpacity(State: IgtPDState);
begin
  FPDExportDevice.UpdateFillOpacity(TgtHackCoPDState(State).State);
end;

procedure TgtCoPDExportDevice.UpdateFillOverPrint(State: IgtPDState);
begin
  FPDExportDevice.UpdateFillOverPrint(TgtHackCoPDState(State).State);
end;

procedure TgtCoPDExportDevice.UpdateFlatness(State: IgtPDState);
begin
  FPDExportDevice.UpdateFlatness(TgtHackCoPDState(State).State);
end;

procedure TgtCoPDExportDevice.UpdateFont(State: IgtPDState);
begin
  FPDExportDevice.UpdateFont(TgtHackCoPDState(State).State);
end;

procedure TgtCoPDExportDevice.UpdateHorizScaling(State: IgtPDState);
begin
  FPDExportDevice.UpdateHorizScaling(TgtHackCoPDState(State).State);
end;

procedure TgtCoPDExportDevice.UpdateLineCap(State: IgtPDState);
begin
  FPDExportDevice.UpdateLineCap(TgtHackCoPDState(State).State);
end;

procedure TgtCoPDExportDevice.UpdateLineDash(State: IgtPDState);
begin
  FPDExportDevice.UpdateLineDash(TgtHackCoPDState(State).State);
end;

procedure TgtCoPDExportDevice.UpdateLineJoin(State: IgtPDState);
begin
  FPDExportDevice.UpdateLineJoin(TgtHackCoPDState(State).State);
end;

procedure TgtCoPDExportDevice.UpdateLineWidth(State: IgtPDState);
begin
  FPDExportDevice.UpdateLineWidth(TgtHackCoPDState(State).State);
end;

procedure TgtCoPDExportDevice.UpdateMiterLimit(State: IgtPDState);
begin
  FPDExportDevice.UpdateMiterLimit(TgtHackCoPDState(State).State);
end;

procedure TgtCoPDExportDevice.UpdateRender(State: IgtPDState);
begin
  FPDExportDevice.UpdateRender(TgtHackCoPDState(State).State);
end;

procedure TgtCoPDExportDevice.UpdateRise(State: IgtPDState);
begin
  FPDExportDevice.UpdateRise(TgtHackCoPDState(State).State);
end;

procedure TgtCoPDExportDevice.UpdateStrokeAdjust(State: IgtPDState);
begin
  FPDExportDevice.UpdateStrokeAdjust(TgtHackCoPDState(State).State);
end;

procedure TgtCoPDExportDevice.UpdateStrokeColor(State: IgtPDState);
begin
  FPDExportDevice.UpdateStrokeColor(TgtHackCoPDState(State).State);
end;

procedure TgtCoPDExportDevice.UpdateStrokeColorSpace(State: IgtPDState);
begin
  FPDExportDevice.UpdateStrokeColorSpace(TgtHackCoPDState(State).State);
end;

procedure TgtCoPDExportDevice.UpdateStrokeOpacity(State: IgtPDState);
begin
  FPDExportDevice.UpdateStrokeOpacity(TgtHackCoPDState(State).State);
end;

procedure TgtCoPDExportDevice.UpdateStrokeOverPrint(State: IgtPDState);
begin
  FPDExportDevice.UpdateStrokeOverPrint(TgtHackCoPDState(State).State);
end;

procedure TgtCoPDExportDevice.UpdateTextMatrix(State: IgtPDState);
begin
  FPDExportDevice.UpdateTextMatrix(TgtHackCoPDState(State).State);
end;

procedure TgtCoPDExportDevice.UpdateTextPos(State: IgtPDState);
begin
  FPDExportDevice.UpdateTextPos(TgtHackCoPDState(State).State);
end;

procedure TgtCoPDExportDevice.UpdateTextShift(State: IgtPDState; Shift: Double);
begin
  FPDExportDevice.UpdateTextShift(TgtHackCoPDState(State).State, Shift);
end;

procedure TgtCoPDExportDevice.UpdateTransfer(State: IgtPDState);
begin
  FPDExportDevice.UpdateTransfer(TgtHackCoPDState(State).State);
end;

procedure TgtCoPDExportDevice.UpdateWordSpace(State: IgtPDState);
begin
  FPDExportDevice.UpdateWordSpace(TgtHackCoPDState(State).State);
end;

function TgtCoPDExportDevice.UseDrawChar: WordBool;
begin
  Result := FPDExportDevice.UseDrawChar;
end;

function TgtCoPDExportDevice.UseDrawForm: WordBool;
begin
  Result := FPDExportDevice.UseDrawForm;
end;

function TgtCoPDExportDevice.UseShadedFill: WordBool;
begin
  Result := FPDExportDevice.UseShadedFill;
end;

function TgtCoPDExportDevice.UseTillingPatternFill: WordBool;
begin
  Result := FPDExportDevice.UseTillingPatternFill;
end;

end.
