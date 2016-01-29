{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit FMX.Canvas.GDIP;

interface

procedure RegisterCanvasClasses;
procedure UnregisterCanvasClasses;

implementation

uses
  Winapi.Windows, Winapi.Messages, Winapi.ActiveX, Winapi.GDIPOBJ, Winapi.GDIPAPI, Winapi.GDIPUTIL,
  System.Classes, System.SysUtils, System.Math, System.Types, System.UITypes, System.UIConsts, System.Generics.Collections,
  FMX.Types, FMX.Consts, FMX.Printer, FMX.Printer.Win, FMX.TextLayout, FMX.PixelFormats, FMX.Platform, FMX.Platform.Win;

type

{ TGDIPCanvasSaveState }

  TGDIPCanvasSaveState = class(TCanvasSaveState)
  private
    FState: GraphicsState;
  protected
    procedure AssignTo(Dest: TPersistent); override;
  public
    procedure Assign(Source: TPersistent); override;
  end;

{ TCanvasGdiPlus }

  TCanvasGdiPlus = class(TCanvas)
  private class var
    FLockedBitmapData: TDictionary<TBitmap, Winapi.GDIPAPI.TBitmapData>;
    class procedure DestroySharedResources; static;
  private
    FGPGraphics: TGPGraphics;
    FGPPen: TGPPen;
    FGPPenBrush: TGPBrush;
    FGPBrush: TGPBrush;
    FGPFamily: TGPFontFamily;
    FFontCollection: TGPPrivateFontCollection;
    FFontScale: Single;
    FContextHandle: THandle;
    FClipRects: PClipRects;
    function GetGraphics: TGPGraphics; inline;
    function CreateSaveState: TCanvasSaveState; override;
    procedure SetClipRects(const ARects: array of TRectF);
    function CreateGPGradientBrush(ABrush: TBrush; const ARect: TRectF; const AOpacity: Single): TGPBrush;
    function CreateGPBitmapBrush(ABrush: TBrush; const ARect: TRectF; const AOpacity: Single): TGPBrush;
    procedure ApplyFill(const ABrush: TBrush; ARect: TRectF; const AOpacity: Single);
    procedure ApplyStroke(const AStroke: TStrokeBrush; ARect: TRectF; const AOpacity: Single);
  protected
    procedure FontChanged(Sender: TObject); override;
    { begin and }
    function DoBeginScene(const AClipRects: PClipRects = nil; AContextHandle: THandle = 0): Boolean; override;
    procedure DoEndScene; override;
    { creation }
    constructor CreateFromWindow(const AParent: TWindowHandle; const AWidth, AHeight: Integer;
      const AQuality: TCanvasQuality = TCanvasQuality.ccSystemDefault); override;
    constructor CreateFromBitmap(const ABitmap: TBitmap; const AQuality: TCanvasQuality = TCanvasQuality.ccSystemDefault); override;
    constructor CreateFromPrinter(const APrinter: TAbstractPrinter); override;
    { Bitmaps }
    class procedure DoInitializeBitmap(const Bitmap: TBitmap); override;
    class procedure DoFinalizeBitmap(const Bitmap: TBitmap); override;
    class function DoMapBitmap(const Bitmap: TBitmap; const Access: TMapAccess; var Data: TBitmapData): Boolean; override;
    class procedure DoUnmapBitmap(const Bitmap: TBitmap; var Data: TBitmapData); override;
    { drawing }
    procedure DoFillRect(const ARect: TRectF; const AOpacity: Single; const ABrush: TBrush); override;
    procedure DoFillPath(const APath: TPathData; const AOpacity: Single; const ABrush: TBrush); override;
    procedure DoFillEllipse(const ARect: TRectF; const AOpacity: Single; const ABrush: TBrush); override;
    procedure DoDrawBitmap(const ABitmap: TBitmap; const SrcRect, DstRect: TRectF; const AOpacity: Single;
      const HighSpeed: Boolean = False); override;
    procedure DoDrawLine(const APt1, APt2: TPointF; const AOpacity: Single; const ABrush: TStrokeBrush); override;
    procedure DoDrawRect(const ARect: TRectF; const AOpacity: Single; const ABrush: TStrokeBrush); override;
    procedure DoDrawPath(const APath: TPathData; const AOpacity: Single; const ABrush: TStrokeBrush); override;
    procedure DoDrawEllipse(const ARect: TRectF; const AOpacity: Single; const ABrush: TStrokeBrush); override;
  public
    destructor Destroy; override;
    procedure SetSize(const AWidth, AHeight: Integer); override;
    { buffer }
    procedure Clear(const Color: TAlphaColor); override;
    procedure ClearRect(const ARect: TRectF; const AColor: TAlphaColor = 0); override;
    { matrix }
    procedure SetMatrix(const M: TMatrix); override;
    { cliping }
    procedure IntersectClipRect(const ARect: TRectF); override;
    procedure ExcludeClipRect(const ARect: TRectF); override;
    { text }
    function LoadFontFromStream(const AStream: TStream): Boolean; override;
    { mesauring }
    function PtInPath(const APoint: TPointF; const APath: TPathData): Boolean; override;
    property Graphics: TGPGraphics read GetGraphics;
  end;

  TTextLayoutGDIPlus = class(TTextLayout)
  private
    FGraphics: TGPGraphics;
    FFreeGraphics: Boolean;
    FGPFont: TGPFont;
    FGPBrush: TGPBrush;
    FStringFormat: TGPStringFormat;
    FLeft: Single;
    FTop: Single;
    FHeight: Single;
    FWidth: Single;
    function MeasureRange(const APos, ALength: Integer): TRegion;
  protected
    procedure DoRenderLayout; override;
    procedure DoDrawLayout(const ACanvas: TCanvas); override;
    function GetTextHeight: Single; override;
    function GetTextWidth: Single; override;
    function GetTextRect: TRectF; override;
    function DoPositionAtPoint(const APoint: TPointF): Integer; override;
    function DoRegionForRange(const ARange: TTextRange): TRegion; override;
  public
    constructor Create(const ACanvas: TCanvas = nil); override;
    destructor Destroy; override;
    //
    procedure ConvertToPath(const APath: TPathData); override;
  end;

function GPRectFromRect(const R: TRectF): TGPRectF;
begin
  Result.X := R.Left;
  Result.y := R.Top;
  Result.Width := R.Right - R.Left;
  Result.Height := R.Bottom - R.Top;
end;

function GPRectFromRectTruncated(const R: TRectF): TGPRectF;
begin
  Result.X := Trunc(R.Left);
  Result.y := Trunc(R.Top);
  Result.Width := Trunc(R.Right) - Trunc(R.Left);
  Result.Height := Trunc(R.Bottom) - Trunc(R.Top);
end;

{ TCanvasGdiPlus }

const
  imgColorMatrix: TColorMatrix = ((1, 0.0, 0.0, 0.0, 0.0),
    (0.0, 1.0, 0.0, 0.0, 0.0), (0.0, 0.0, 1.0, 0.0, 0.0),
    (0.0, 0.0, 0.0, 0.1, 0.0), (0.0, 0.0, 0.0, 0.0, 1.0));

  TextContrast = 4;
  SmothingDefault = SmoothingMode(5); // 8x8

var
  ColorArray: array [0 .. 100] of TGPColor;
  OffsetArray: array [0 .. 100] of Single;

function vgStyleToGPStyle(S: TFontStyles): Integer;
begin
  Result := 0;
  if TFontStyle.fsBold in S then
    Result := Result or FontStyleBold;
  if TFontStyle.fsItalic in S then
    Result := Result or FontStyleItalic;
  if TFontStyle.fsUnderline in S then
    Result := Result or FontStyleUnderline;
  if TFontStyle.fsStrikeOut in S then
    Result := Result or FontStyleStrikeout;
end;

class procedure TCanvasGdiPlus.DestroySharedResources;
begin
  if Assigned(FLockedBitmapData) then
    FreeAndNil(FLockedBitmapData);
end;

constructor TCanvasGdiPlus.CreateFromWindow(const AParent: TWindowHandle; const AWidth, AHeight: Integer;
  const AQuality: TCanvasQuality = TCanvasQuality.ccSystemDefault);
begin
  inherited CreateFromWindow(AParent, AWidth, AHeight, AQuality);
  WindowHandleToPlatform(Parent).CreateBuffer(Width, Height);
  FGPGraphics := TGPGraphics.Create(WindowHandleToPlatform(Parent).BufferHandle);
  FGPGraphics.SetPixelOffsetMode(PixelOffsetModeHalf);
  case Quality of
    TCanvasQuality.ccHighPerformance: FGPGraphics.SetSmoothingMode(SmoothingModeHighSpeed);
    TCanvasQuality.ccHighQuality: FGPGraphics.SetSmoothingMode(SmoothingModeAntiAlias);
  else
    FGPGraphics.SetSmoothingMode(SmoothingModeAntiAlias);
  end;
  FGPGraphics.SetInterpolationMode(InterpolationModeHighQuality);
  FGPGraphics.SetTextContrast(TextContrast);
  if GlobalUseGDIPlusClearType then
    FGPGraphics.SetTextRenderingHint(TextRenderingHintClearTypeGridFit)
  else
    FGPGraphics.SetTextRenderingHint(TextRenderingHintAntiAlias);
  FGPPen := TGPPen.Create($FF000000);
  FGPPenBrush := TGPSolidBrush.Create($FF000000);
  FGPBrush := TGPSolidBrush.Create($FFFFFFFF);
  FGPFamily := TGPFontFamily.Create('Tahoma');
  FFontScale := 1;
end;

constructor TCanvasGdiPlus.CreateFromBitmap(const ABitmap: TBitmap; const AQuality: TCanvasQuality = TCanvasQuality.ccSystemDefault);
begin
  inherited CreateFromBitmap(ABitmap, AQuality);
  FGPGraphics := TGPGraphics.Create(TGPBitmap(Bitmap.Handle));
  FGPGraphics.SetPixelOffsetMode(PixelOffsetModeHalf);
  case Quality of
    TCanvasQuality.ccHighPerformance: FGPGraphics.SetSmoothingMode(SmoothingModeHighSpeed);
    TCanvasQuality.ccHighQuality: FGPGraphics.SetSmoothingMode(SmoothingModeAntiAlias);
  else
    FGPGraphics.SetSmoothingMode(SmoothingModeAntiAlias);
  end;
  FGPGraphics.SetTextContrast(TextContrast);
  if GlobalUseGDIPlusClearType then
    FGPGraphics.SetTextRenderingHint(TextRenderingHintClearTypeGridFit)
  else
    FGPGraphics.SetTextRenderingHint(TextRenderingHintAntiAlias);
  FGPPen := TGPPen.Create($FF000000);
  FGPPenBrush := TGPSolidBrush.Create($FF000000);
  FGPBrush := TGPSolidBrush.Create($FFFFFFFF);
  FGPFamily := TGPFontFamily.Create('Tahoma');
  if (Width > 0) and (Height > 0) and not SameValue(FGPGraphics.GetDpiX, 0.0, Epsilon) then
    FFontScale := 96 / FGPGraphics.GetDpiX
  else
    FFontScale := 1;
end;

constructor TCanvasGdiPlus.CreateFromPrinter(const APrinter: TAbstractPrinter);
var
  PrinterWin: TPrinterWin;
begin
  inherited CreateFromPrinter(APrinter);
  if APrinter is TPrinterWin then
  begin
    // calling the constructor through the canvas instance makes the canvas
    // update the DC handle if APrinter is the same printer for the canvas
    if Assigned(FPrinter) and (APrinter = FPrinter) then
    begin
      FGPGraphics.Free;
      FGPPen.Free;
      FGPPenBrush.Free;
      FGPBrush.Free;
      FGPFamily.Free;
    end;
    // initialize the canvas size
    PrinterWin := TPrinterWin(APrinter);
    FWidth := PrinterWin.PageWidth;
    FHeight := PrinterWin.PageHeight;

    // create the underlying GDIPlus canvas object
    FGPGraphics := TGPGraphics.Create(PrinterWin.Handle);
    FGPGraphics.SetPageUnit(UnitPixel);
    FGPGraphics.SetSmoothingMode(SmothingDefault);
    FGPGraphics.SetPixelOffsetMode(PixelOffsetModeHalf);
    FGPGraphics.SetInterpolationMode(InterpolationModeHighQuality);
    FGPGraphics.SetTextContrast(TextContrast);
    FGPPen := TGPPen.Create($FF000000);
    FGPPenBrush := TGPSolidBrush.Create($FF000000);
    FGPBrush := TGPSolidBrush.Create($FFFFFFFF);
    FGPFamily := TGPFontFamily.Create('Tahoma');
    FFontScale := 1;
  end
  else
    raise EPrinter.CreateResFmt(@SInvalidPrinterClass, [APrinter.ClassName]);
end;

function TCanvasGdiPlus.CreateGPBitmapBrush(ABrush: TBrush; const ARect: TRectF;
  const AOpacity: Single): TGPBrush;
var
  B: TBitmap;
  CM: TColorMatrix;
  ImageAttributes: TGPImageAttributes;
  GPBrushTmp: TGPTextureBrush;
  SX: Single;
  SY: Single;
begin
  B := ABrush.Bitmap.Bitmap;
  if Assigned(B) and Assigned(B.ResourceBitmap) then
    B := B.ResourceBitmap;
  if Assigned(B) and (B.Width > 0) and (B.Height > 0) then
  begin
    if B.HandleAllocated then
    begin
      CM := imgColorMatrix;
      CM[3][3] := AOpacity;
      if AOpacity <> 1 then
      begin
        ImageAttributes := TGPImageAttributes.Create;
        ImageAttributes.SetColorMatrix(CM, ColorMatrixFlagsDefault, ColorAdjustTypeBitmap);
      end
      else
        ImageAttributes := nil;
      if ABrush.Bitmap.WrapMode <> TWrapMode.wmTileStretch then
      begin
        GPBrushTmp := TGPTextureBrush.Create(TGPBitmap(B.Handle),
          GPRectFromRect(RectF(0, 0, B.Width, B.Height)), ImageAttributes);
        if ABrush.Bitmap.WrapMode = TWrapMode.wmTileOriginal then
          GPBrushTmp.SetWrapMode(Winapi.GDIPAPI.TWrapMode.WrapModeClamp)
        else
          GPBrushTmp.SetWrapMode(Winapi.GDIPAPI.TWrapMode.WrapModeTile);
      end
      else
      begin
        GPBrushTmp := TGPTextureBrush.Create
          (TGPBitmap(B.Handle),
          GPRectFromRect(RectF(0, 0, B.Width, B.Height)),
          ImageAttributes);
        GPBrushTmp.SetWrapMode(WrapModeClamp);
        if Stroke.Kind = TBrushKind.bkNone then
        begin
          SX := ARect.Width / B.Width;
          SY := ARect.Height / B.Height;
        end
        else
        begin
          SX := (ARect.Width + (Stroke.Thickness / 2)) / B.Width;
          SY := (ARect.Height + (Stroke.Thickness / 2)) / B.Height;
        end;
        GPBrushTmp.TranslateTransform(ARect.Left, ARect.Top);
        GPBrushTmp.ScaleTransform(SX, SY);
      end;
      if AOpacity <> 1 then
        ImageAttributes.Free;
      Result := GPBrushTmp;
    end
    else
      Result := TGPSolidBrush.Create($00000000);
  end
  else
    Result := TGPSolidBrush.Create($00000000);
end;

function TCanvasGdiPlus.CreateGPGradientBrush(ABrush: TBrush; const ARect: TRectF; const AOpacity: Single): TGPBrush;
var
  Count: Integer;
  I: Integer;
  P: TGPGraphicsPath;
  MatrixTmp: TMatrix;
  M: TGPMatrix;
begin
  if ABrush.Gradient.Points.Count > 1 then
  begin
    Count := 0;

    if ABrush.Gradient.Points[0].Offset > 0 then
    begin
      ColorArray[Count] := MakeColor(ABrush.Gradient.Points[0].IntColor, AOpacity);
      OffsetArray[Count] := 0;
      Count := Count + 1;
    end;
    for I := 0 to ABrush.Gradient.Points.Count - 1 do
    begin
      ColorArray[I + Count] := MakeColor(ABrush.Gradient.Points[I].IntColor, AOpacity);
      OffsetArray[I + Count] := ABrush.Gradient.Points[I].Offset;
    end;
    if ABrush.Gradient.Points[ABrush.Gradient.Points.Count - 1].Offset < 1 then
    begin
      Count := Count + 1;
      ColorArray[ABrush.Gradient.Points.Count + Count - 1] :=
        MakeColor(ABrush.Gradient.Points[ABrush.Gradient.Points.Count - 1].IntColor, AOpacity);
      OffsetArray[ABrush.Gradient.Points.Count + Count - 1] := 1;
    end;

    if ABrush.Gradient.Style = TGradientStyle.gsLinear then
    begin
      { Linear }
      Result := TGPLinearGradientBrush.Create
        (MakePoint(ARect.Left + ABrush.Gradient.StartPosition.X * ARect.Width,
        ARect.Top + ABrush.Gradient.StartPosition.y * ARect.Height),
        MakePoint(ARect.Left + ABrush.Gradient.StopPosition.X * ARect.Width,
        ARect.Top + ABrush.Gradient.StopPosition.y * ARect.Height),
        ABrush.Color, ABrush.Color);
      TGPLinearGradientBrush(Result).SetWrapMode(WrapModeTileFlipX);
      TGPLinearGradientBrush(Result).SetInterpolationColors
        (PGPColor(@ColorArray), PSingle(@OffsetArray),
        ABrush.Gradient.Points.Count + Count);
    end
    else
    begin
      { Radial }
      P := TGPGraphicsPath.Create;
      try
        P.AddEllipse(GPRectFromRect(ARect));
        Result := TGPPathGradientBrush.Create(P);
      finally
        P.Free;
      end;
      MatrixTmp := ABrush.Gradient.RadialTransform.Matrix;
      M := TGPMatrix.Create(MatrixTmp.m11, MatrixTmp.m12, MatrixTmp.m21,
          MatrixTmp.m22, MatrixTmp.m31, MatrixTmp.m32);
      try
        TGPPathGradientBrush(Result).SetTransform(M);
      finally
        M.Free;
      end;
      TGPPathGradientBrush(Result).SetWrapMode(WrapModeClamp);
      TGPPathGradientBrush(Result).SetInterpolationColors
        (PARGB(@ColorArray), PSingle(@OffsetArray),
        ABrush.Gradient.Points.Count + Count);
    end;
  end
  else
    Result := TGPSolidBrush.Create(MakeColor(ABrush.Color, AOpacity));
end;

function TCanvasGdiPlus.CreateSaveState: TCanvasSaveState;
begin
  Result := TGDIPCanvasSaveState.Create;
end;

destructor TCanvasGdiPlus.Destroy;
begin
  FreeAndNil(FFontCollection);
  FreeAndNil(FGPFamily);
  FreeAndNil(FGPBrush);
  FreeAndNil(FGPPenBrush);
  FreeAndNil(FGPPen);
  FreeAndNil(FGPGraphics);
  inherited Destroy;
end;

function TCanvasGdiPlus.DoBeginScene(const AClipRects: PClipRects = nil; AContextHandle: THandle = 0): Boolean;
begin
  FContextHandle := AContextHandle;
  FClipRects := AClipRects;
  Result := inherited DoBeginScene(AClipRects);
  if Result and (AClipRects <> nil) then
    SetClipRects(AClipRects^);
end;

procedure TCanvasGdiPlus.DoEndScene;
var
  I: Integer;
  R: TRect;
begin
  inherited;
  if Assigned(Parent) and (FContextHandle <> 0) then
  begin
    if Assigned(FClipRects) then
    begin
      for I := 0 to High(FClipRects^) do
      begin
        R := FClipRects^[I].Round;
        Winapi.Windows.BitBlt(FContextHandle, R.Left, R.Top, R.Width, R.Height, WindowHandleToPlatform(Parent).BufferHandle, R.Left, R.Top, SRCCOPY);
      end;
    end else
      Winapi.Windows.BitBlt(FContextHandle, 0, 0, Width, Height, WindowHandleToPlatform(Parent).BufferHandle, 0, 0, SRCCOPY);
  end;
end;

procedure TCanvasGdiPlus.Clear(const Color: TAlphaColor);
begin
  FGPGraphics.Clear(Color)
end;

procedure TCanvasGdiPlus.ClearRect(const ARect: TRectF; const AColor: TAlphaColor);
var
  SaveIndex: Cardinal;
begin
  SaveIndex := FGPGraphics.Save;
  try
    FGPGraphics.IntersectClip(GPRectFromRect(ARect));
    FGPGraphics.Clear(AColor);
  finally
    FGPGraphics.Restore(SaveIndex);
  end;
end;

function TCanvasGdiPlus.GetGraphics: TGPGraphics;
begin
  Result := FGPGraphics;
end;

procedure TCanvasGdiPlus.SetMatrix(const M: TMatrix);
var
  GM: TGPMatrix;
begin
  FMatrix := M;
  GM := TGPMatrix.Create(M.m11, M.m12, M.m21, M.m22, M.m31, M.m32);
  GM.Shear(M.m13, M.m23);
  FGPGraphics.SetTransform(GM);
  GM.Free;
end;

procedure TCanvasGdiPlus.SetSize(const AWidth, AHeight: Integer);
begin
  if Assigned(Parent) and ((AWidth <> Width) or (AHeight <> Height)) then
  begin
    inherited ;
    FreeAndNil(FGPGraphics);
    WindowHandleToPlatform(Parent).ResizeBuffer(Width, Height);
    FGPGraphics := TGPGraphics.Create(WindowHandleToPlatform(Parent).BufferHandle);
    FGPGraphics.SetSmoothingMode(SmothingDefault);
    FGPGraphics.SetPixelOffsetMode(PixelOffsetModeHalf);
    FGPGraphics.SetInterpolationMode(InterpolationModeHighQuality);
    FGPGraphics.SetTextContrast(TextContrast);
    if GlobalUseGDIPlusClearType then
      FGPGraphics.SetTextRenderingHint(TextRenderingHintClearTypeGridFit)
    else
      FGPGraphics.SetTextRenderingHint(TextRenderingHintAntiAlias);
    FGPPen := TGPPen.Create($FF000000);
    FGPPenBrush := TGPSolidBrush.Create($FF000000);
    FGPBrush := TGPSolidBrush.Create($FFFFFFFF);
    FGPFamily := TGPFontFamily.Create('Tahoma');
    FFontScale := 1;
  end
  else
    inherited ;
end;

procedure TCanvasGdiPlus.SetClipRects(const ARects: array of TRectF);
var
  I: Integer;
  R: TGPRegion;
begin
  R := TGPRegion.Create;
  R.MakeEmpty;
  for I := 0 to High(ARects) do
    R.Union(GPRectFromRect(ARects[I]));
  FGPGraphics.SetClip(R);
  R.Free;
end;

procedure TCanvasGdiPlus.IntersectClipRect(const ARect: TRectF);
begin
  FClippingChangeCount := FClippingChangeCount + 1;
  FGPGraphics.IntersectClip(MakeRect(ARect.Left, ARect.Top,
    ARect.Right - ARect.Left, ARect.Bottom - ARect.Top));
end;

procedure TCanvasGdiPlus.ExcludeClipRect(const ARect: TRectF);
begin
  FClippingChangeCount := FClippingChangeCount + 1;
  FGPGraphics.ExcludeClip(GPRectFromRect(ARect));
end;

procedure TCanvasGdiPlus.ApplyFill(const ABrush: TBrush; ARect: TRectF; const AOpacity: Single);
begin
  if Assigned(FGPBrush) then
    FreeAndNil(FGPBrush);
  if (ABrush.Kind = TBrushKind.bkResource) and Assigned(ABrush.Resource) and
    Assigned(ABrush.Resource.Brush) then
    ABrush.Assign(ABrush.Resource.Brush);

  case ABrush.Kind of
    TBrushKind.bkSolid:
        FGPBrush := TGPSolidBrush.Create(MakeColor(ABrush.Color, AOpacity));

    TBrushKind.bkGradient:
        FGPBrush := CreateGPGradientBrush(ABrush, ARect, AOpacity);

    TBrushKind.bkBitmap:
        FGPBrush := CreateGPBitmapBrush(ABrush, ARect, AOpacity);
  else
    FGPBrush := TGPSolidBrush.Create($00000000);
  end;
end;

procedure TCanvasGdiPlus.ApplyStroke(const AStroke: TStrokeBrush; ARect: TRectF; const AOpacity: Single);
begin
  if FGPPen <> nil then
    FreeAndNil(FGPPen);
  if FGPPenBrush <> nil then
    FreeAndNil(FGPPenBrush);
  if (AStroke.Kind = TBrushKind.bkResource) and (AStroke.Resource <> nil) and
    (AStroke.Resource.Brush <> nil) then
    AStroke.Assign(AStroke.Resource.Brush);

  case AStroke.Kind of
    TBrushKind.bkSolid:
        FGPPenBrush := TGPSolidBrush.Create(MakeColor(AStroke.Color, AOpacity));

    TBrushKind.bkGradient:
        FGPPenBrush := CreateGPGradientBrush(AStroke, ARect, AOpacity);

    TBrushKind.bkBitmap:
        FGPPenBrush := CreateGPBitmapBrush(AStroke, ARect, AOpacity);
  else
    FGPPenBrush := TGPSolidBrush.Create($00000000);
  end;

  FGPPen := TGPPen.Create(FGPPenBrush);
  case AStroke.Cap of
    TStrokeCap.scFlat:
      FGPPen.SetLineCap(LineCapFlat, LineCapFlat, DashCapFlat);
    TStrokeCap.scRound:
      FGPPen.SetLineCap(LineCapRound, LineCapRound, DashCapRound);
  end;
  if Length(AStroke.DashArray) > 0 then
  begin
    FGPPen.SetDashOffset(AStroke.DashOffset);
    FGPPen.SetDashPattern(@AStroke.DashArray[0], Length(AStroke.DashArray));
  end
  else
    FGPPen.SetDashStyle(DashStyleSolid);
  case AStroke.Join of
    TStrokeJoin.sjMiter:
      FGPPen.SetLineJoin(LineJoinMiter);
    TStrokeJoin.sjRound:
      FGPPen.SetLineJoin(LineJoinRound);
    TStrokeJoin.sjBevel:
      FGPPen.SetLineJoin(LineJoinBevel);
  end;
  FGPPen.SetWidth(AStroke.Thickness);
end;

procedure TCanvasGdiPlus.FontChanged(Sender: TObject);
begin
  FreeAndNil(FGPFamily);
  FGPFamily := TGPFontFamily.Create(FFont.Family, FFontCollection);
  if not FGPFamily.IsAvailable then
  begin
    FGPFamily.Free;
    FGPFamily := TGPFontFamily.Create(FFont.Family);
    if not FGPFamily.IsAvailable then
    begin
      FGPFamily.Free;
      FGPFamily := TGPFontFamily.GenericSansSerif.Clone;
    end
  end;
end;

procedure TCanvasGdiPlus.DoDrawLine(const APt1, APt2: TPointF; const AOpacity: Single; const ABrush: TStrokeBrush);
begin
  ApplyStroke(ABrush, RectF(APt1.X, APt1.y, APt2.X, APt2.y), AOpacity);
  FGPGraphics.DrawLine(FGPPen, APt1.X, APt1.y, APt2.X, APt2.y);
end;

procedure TCanvasGdiPlus.DoDrawRect(const ARect: TRectF; const AOpacity: Single; const ABrush: TStrokeBrush);
begin
  ApplyStroke(ABrush, ARect, AOpacity);
  FGPGraphics.DrawRectangle(FGPPen, GPRectFromRect(ARect));
end;

procedure TCanvasGdiPlus.DoFillRect(const ARect: TRectF; const AOpacity: Single; const ABrush: TBrush);
begin
  ApplyFill(ABrush, ARect, AOpacity);
  FGPGraphics.FillRectangle(FGPBrush, GPRectFromRect(ARect));
end;

procedure TCanvasGdiPlus.DoDrawEllipse(const ARect: TRectF; const AOpacity: Single; const ABrush: TStrokeBrush);
begin
  ApplyStroke(ABrush, ARect, AOpacity);
  FGPGraphics.DrawEllipse(FGPPen, GPRectFromRect(ARect));
end;

procedure TCanvasGdiPlus.DoFillEllipse(const ARect: TRectF; const AOpacity: Single; const ABrush: TBrush);
begin
  ApplyFill(ABrush, ARect, AOpacity);
  FGPGraphics.FillEllipse(FGPBrush, GPRectFromRect(ARect));
end;

function TCanvasGdiPlus.LoadFontFromStream(const AStream: TStream): Boolean;
var
  Stream: TMemoryStream;
begin
  if FFontCollection = nil then
    FFontCollection := TGPPrivateFontCollection.Create;
  Stream := TMemoryStream.Create;
  try
    Stream.CopyFrom(AStream, AStream.Size);
    Result := Stream.Size > 0;
    if Result then
      FFontCollection.AddMemoryFont(Stream.Memory, Stream.Size);
  finally
    Stream.Free;
  end;
end;

{ Bitmaps }

procedure TCanvasGdiPlus.DoDrawBitmap(const ABitmap: TBitmap; const SrcRect, DstRect: TRectF;
  const AOpacity: Single; const HighSpeed: Boolean = False);
var
  CM: TColorMatrix;
  ImageAttributes: TGPImageAttributes;
  GPBitmap: TGPBitmap;
  M: TBitmapData;
begin
  if HighSpeed then
    FGPGraphics.SetInterpolationMode(InterpolationModeNearestNeighbor)
  else
    FGPGraphics.SetInterpolationMode(InterpolationModeHighQuality);

  if Assigned(FPrinter) and not (TCanvasManager.DefaultCanvas.InheritsFrom(TCanvasGdiPlus)) then
  begin
    // In printer
    if ABitmap.Map(TMapAccess.maRead, M) then
    try
      GPBitmap := TGPBitmap.Create(ABitmap.Width, ABitmap.Height, M.Pitch, PixelFormat32bppPARGB, M.Data);
      if (AOpacity < 1) then
      begin
        if (AOpacity = 0) then
          Exit;
        CM := imgColorMatrix;
        CM[3][3] := AOpacity;
        if not ABitmap.HandleAllocated then
          Exit;
        ImageAttributes := TGPImageAttributes.Create;
        ImageAttributes.SetColorMatrix(CM, ColorMatrixFlagsDefault,
          ColorAdjustTypeBitmap);
        FGPGraphics.DrawImage(GPBitmap,
          MakeRect(DstRect.Left, DstRect.Top, DstRect.Right - DstRect.Left,
          DstRect.Bottom - DstRect.Top), SrcRect.Left, SrcRect.Top,
          SrcRect.Right - SrcRect.Left, SrcRect.Bottom - SrcRect.Top, UnitPixel,
          ImageAttributes);
        ImageAttributes.Free;
      end
      else
      begin
        if not ABitmap.HandleAllocated then
          Exit;
        FGPGraphics.DrawImage(GPBitmap,
          MakeRect(DstRect.Left, DstRect.Top, DstRect.Right - DstRect.Left,
          DstRect.Bottom - DstRect.Top), SrcRect.Left, SrcRect.Top,
          SrcRect.Right - SrcRect.Left, SrcRect.Bottom - SrcRect.Top, UnitPixel);
      end;
      GPBitmap.Free;
    finally
      ABitmap.Unmap(M);
    end;
    Exit;
  end;

  if (AOpacity < 1) then
  begin
    if (AOpacity = 0) then
      Exit;
    CM := imgColorMatrix;
    CM[3][3] := AOpacity;
    if not ABitmap.HandleAllocated then
      Exit;
    ImageAttributes := TGPImageAttributes.Create;
    ImageAttributes.SetColorMatrix(CM, ColorMatrixFlagsDefault,
      ColorAdjustTypeBitmap);
    FGPGraphics.DrawImage(TGPBitmap(ABitmap.Handle),
      MakeRect(DstRect.Left, DstRect.Top, DstRect.Right - DstRect.Left,
      DstRect.Bottom - DstRect.Top), SrcRect.Left, SrcRect.Top,
      SrcRect.Right - SrcRect.Left, SrcRect.Bottom - SrcRect.Top, UnitPixel,
      ImageAttributes);
    ImageAttributes.Free;
  end
  else
  begin
    if not ABitmap.HandleAllocated then
      Exit;
    FGPGraphics.DrawImage(TGPBitmap(ABitmap.Handle),
      MakeRect(DstRect.Left, DstRect.Top, DstRect.Right - DstRect.Left,
      DstRect.Bottom - DstRect.Top), SrcRect.Left, SrcRect.Top,
      SrcRect.Right - SrcRect.Left, SrcRect.Bottom - SrcRect.Top, UnitPixel);
  end;
end;

{ Path }

procedure TCanvasGdiPlus.DoDrawPath(const APath: TPathData; const AOpacity: Single; const ABrush: TStrokeBrush);
var
  I: Integer;
  CP1, CP2, CP, SP: TPointF;
begin
  ApplyStroke(ABrush, APath.GetBounds, AOpacity);
  I := 0;
  while I < APath.Count do
  begin
    case APath[I].Kind of
      TPathPointKind.ppMoveTo:
        begin
          CP := APath[I].Point;
          SP := CP;
        end;
      TPathPointKind.ppLineTo:
        begin
          FGPGraphics.DrawLine(FGPPen, CP.X, CP.y,
            APath[I].Point.X, APath[I].Point.Y);
          CP := APath[I].Point;
        end;
      TPathPointKind.ppCurveTo:
        begin
          CP1 := APath[I].Point;
          Inc(I);
          CP2 := APath[I].Point;
          Inc(I);
          FGPGraphics.DrawBezier(FGPPen, CP.X, CP.y, CP1.X, CP1.y, CP2.X, CP2.y,
            APath[I].Point.X, APath[I].Point.Y);
          CP := APath[I].Point;
        end;
      TPathPointKind.ppClose:
        begin
          FGPGraphics.DrawLine(FGPPen, CP.X, CP.y, SP.X, SP.y);
        end;
    end;
    Inc(I);
  end;
end;

procedure TCanvasGdiPlus.DoFillPath(const APath: TPathData; const AOpacity: Single; const ABrush: TBrush);
var
  I: Integer;
  CP, CP1, CP2: TPointF;
  P: TGPGraphicsPath;
begin
  P := TGPGraphicsPath.Create;
  I := 0;
  while I < APath.Count do
  begin
    case APath[I].Kind of
      TPathPointKind.ppMoveTo:
        begin
          CP := APath[I].Point;
          P.StartFigure;
        end;
      TPathPointKind.ppLineTo:
        begin
          P.AddLine(CP.X, CP.Y, APath[I].Point.X, APath[I].Point.Y);
          CP := APath[I].Point;
        end;
      TPathPointKind.ppCurveTo:
        begin
          CP1 := APath[I].Point;
          Inc(I);
          CP2 := APath[I].Point;
          Inc(I);
          P.AddBezier(CP.X, CP.Y, CP1.X, CP1.Y, CP2.X, CP2.Y, APath[I].Point.X, APath[I].Point.Y);
          CP := APath[I].Point;
        end;
      TPathPointKind.ppClose:
        begin
          P.CloseFigure;
        end;
    end;
    Inc(I);
  end;
  ApplyFill(ABrush, APath.GetBounds, AOpacity);
  FGPGraphics.FillPath(FGPBrush, P);
  P.Free;
end;

function TCanvasGdiPlus.PtInPath(const APoint: TPointF; const APath: TPathData): Boolean;
var
  I: Integer;
  B: TRectF;
  CP, CP1, CP2: TPointF;
  P: TGPGraphicsPath;
begin
  B :=  APath.GetBounds;
  if not B.Contains(APoint) then
    Result := False
  else
  begin
    P := TGPGraphicsPath.Create;
    I := 0;
    while I < APath.Count do
    begin
      case APath[I].Kind of
        TPathPointKind.ppMoveTo:
          begin
            CP := APath[I].Point;
            P.StartFigure;
          end;
        TPathPointKind.ppLineTo:
          begin
            P.AddLine(CP.X, CP.Y, APath[I].Point.X, APath[I].Point.Y);
            CP := APath[I].Point;
          end;
        TPathPointKind.ppCurveTo:
          begin
            CP1 := APath[I].Point;
            Inc(I);
            CP2 := APath[I].Point;
            Inc(I);
            P.AddBezier(CP.X, CP.Y, CP1.X, CP1.Y, CP2.X, CP2.Y, APath[I].Point.X, APath[I].Point.Y);
            CP := APath[I].Point;
          end;
        TPathPointKind.ppClose:
          begin
            P.CloseFigure;
          end;
      end;
      Inc(I);
    end;

    Result := P.IsVisible(APoint.X, APoint.y);

    P.Free;
  end;
end;

class procedure TCanvasGdiPlus.DoInitializeBitmap(const Bitmap: TBitmap);
begin
  (Bitmap as IBitmapAccess).Handle := TBitmapHandle(TGPBitmap.Create(Bitmap.Width, Bitmap.Height, PixelFormat32bppPARGB));
  (Bitmap as IBitmapAccess).PixelFormat := TPixelFormat.pfA8R8G8B8;
end;

class procedure TCanvasGdiPlus.DoFinalizeBitmap(const Bitmap: TBitmap);
begin
  TGPBitmap(Bitmap.Handle).Free;
end;

class function TCanvasGdiPlus.DoMapBitmap(const Bitmap: TBitmap; const Access: TMapAccess; var Data: TBitmapData): Boolean;
var
  Flags: UInt;
  GPBitmapData: Winapi.GDIPAPI.TBitmapData;
begin
  case Access of
    TMapAccess.maRead: Flags := ImageLockModeRead;
    TMapAccess.maWrite: Flags := ImageLockModeWrite;
  else
    Flags := ImageLockModeRead or ImageLockModeWrite;
  end;
  if TGPBitmap(Bitmap.Handle).LockBits(MakeRect(0, 0, Bitmap.Width, Bitmap.Height), Flags, PixelFormat32bppPARGB, GPBitmapData) = Ok then
  begin
    if not Assigned(FLockedBitmapData) then
      FLockedBitmapData := TDictionary<TBitmap, Winapi.GDIPAPI.TBitmapData>.Create;
    FLockedBitmapData.Add(Bitmap, GPBitmapData);
    Data.Data := GPBitmapData.Scan0;
    Data.Pitch := GPBitmapData.Stride;
    Result := True;
  end
  else
    Result := False;
end;

class procedure TCanvasGdiPlus.DoUnmapBitmap(const Bitmap: TBitmap; var Data: TBitmapData);
var
  GPBitmapData: Winapi.GDIPAPI.TBitmapData;
begin
  if FLockedBitmapData.TryGetValue(Bitmap, GPBitmapData) then
  begin
    TGPBitmap(Bitmap.Handle).UnlockBits(GPBitmapData);
    FLockedBitmapData.Remove(Bitmap);
  end;
end;

{ TD2DCanvasSaveState }

procedure TGDIPCanvasSaveState.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TCanvasGdiPlus then
    FState := TCanvasGdiPlus(Source).Graphics.Save;
end;

procedure TGDIPCanvasSaveState.AssignTo(Dest: TPersistent);
begin
  inherited AssignTo(Dest);
  if Dest is TCanvasGdiPlus then
    TCanvasGdiPlus(Dest).Graphics.Restore(FState);
end;

{ TTextLayoutGDIPlus }

procedure TTextLayoutGDIPlus.ConvertToPath(const APath: TPathData);
var
  GPPath: TGPGraphicsPath;
  GPFamily: TGPFontFamily;
  Data: Winapi.GDIPAPI.TPathData;
  SavePoints: PGPPointF;
  i: Integer;
  SP, CP1, CP2: TPointF;
begin
  if Text.IsEmpty then
    Exit;

  GPPath := TGPGraphicsPath.Create;
  // path
  GPFamily := TGPFontFamily.Create(Font.Family);
  if not GPFamily.IsAvailable then
  begin
    FreeAndNil(GPFamily);
    GPFamily := TGPFontFamily.Create(Font.Family);
    if not GPFamily.IsAvailable then
    begin
      FreeAndNil(GPFamily);
      GPFamily := TGPFontFamily.GenericSansSerif.Clone;
    end
  end;
  GPPath.AddString(Text, -1, GPFamily, vgStyleToGPStyle(Font.Style),
    Font.Size, GPRectFromRect(RectF(0, 0,
      MaxSize.X - Padding.Left - Padding.Right,
      MaxSize.Y - Padding.Top - Padding.Bottom)), FStringFormat);
  // expand path
  Data := Winapi.GDIPAPI.TPathData.Create;
  GPPath.GetPathData(Data);
  SavePoints := Data.Points;
  // calc size
  i := 0;
  while i < Data.Count do
  begin
    if PByteArray(Data.Types)[i] = Integer(PathPointTypeStart) then
    begin
      SP := PointF(Data.Points^.X, Data.Points^.y);
      APath.MoveTo(PointF(Data.Points^.X, Data.Points^.y));
    end;
    if PByteArray(Data.Types)[i] and Integer(PathPointTypeBezier) = Integer(PathPointTypeBezier) then
    begin
      CP1 := PointF(Data.Points^.X, Data.Points^.y);
      Inc(i);
      Inc(Data.Points);
      CP2 := PointF(Data.Points^.X, Data.Points^.y);
      Inc(i);
      Inc(Data.Points);
      APath.CurveTo(CP1, CP2, PointF(Data.Points^.X, Data.Points^.Y));
    end;
    if PByteArray(Data.Types)[i] and Integer(PathPointTypeLine) = Integer(PathPointTypeLine) then
    begin
      APath.LineTo(PointF(Data.Points^.X, Data.Points^.Y));
    end;
    if PByteArray(Data.Types)[i] and Integer(PathPointTypeCloseSubpath) = Integer(PathPointTypeCloseSubpath) then
    begin
      APath.ClosePath;
    end;
    Inc(i);
    Inc(Data.Points);
  end;
  //
  Data.Points := SavePoints;
  FreeAndNil(Data);
  FreeAndNil(GPPath);
  FreeAndNil(GPFamily);
end;

constructor TTextLayoutGDIPlus.Create(const ACanvas: TCanvas);
var
  Bitmap: TGPBitmap;
begin
  inherited Create(ACanvas);
  if Assigned(LayoutCanvas) and PrinterAssigned and (LayoutCanvas = Printer.Canvas) then
  begin
    FGraphics := TCanvasGdiPlus(ACanvas).Graphics;
    FFreeGraphics := False;
  end
  else
  begin
    Bitmap := TGPBitmap.Create(1, 1, PixelFormat32bppARGB);
    FGraphics := TGPGraphics.Create(Bitmap);
    FreeAndNil(Bitmap);
    FGraphics.SetSmoothingMode(SmothingDefault);
    FGraphics.SetInterpolationMode(InterpolationModeHighQuality);
    FGraphics.SetPixelOffsetMode(PixelOffsetModeHalf);
    FGraphics.SetTextContrast(TextContrast);
    if GlobalUseGDIPlusClearType then
      FGraphics.SetTextRenderingHint(TextRenderingHintClearTypeGridFit)
    else
      FGraphics.SetTextRenderingHint(TextRenderingHintAntiAlias);
    FFreeGraphics := True;
  end;
  FStringFormat := TGPStringFormat.Create(StringFormatFlagsMeasureTrailingSpaces);
  FLeft := 0;
  FTop := 0;
  FHeight := 0;
  FWidth := 0;
end;

destructor TTextLayoutGDIPlus.Destroy;
begin
  if FFreeGraphics then
    FreeAndNil(FGraphics);
  FreeAndNil(FStringFormat);
  FreeAndNil(FGPFont);
  FreeAndNil(FGPBrush);
  inherited;
end;

procedure TTextLayoutGDIPlus.DoDrawLayout(const ACanvas: TCanvas);
var
  LColor: Cardinal;
  LOpacity: Single;
begin
  if not Assigned(FStringFormat) then
    Exit;

  if Text.IsEmpty then
    Exit;

  if ACanvas is TCanvasGdiPlus then
  begin
    if Opacity = 1 then
      LOpacity := 0.99
    else
      LOpacity := Opacity;
    if not Assigned(FGPBrush) or
       ((TGPSolidBrush(FGPBrush).GetColor(LColor) = TStatus.Ok) and
        (LColor <> MakeColor(Color, LOpacity))) then
    begin
      FreeAndNil(FGPBrush);
      FGPBrush := TGPSolidBrush.Create(MakeColor(Color, LOpacity));
    end;
    TCanvasGdiPlus(ACanvas).FGPGraphics.DrawString(Text, -1, FGPFont,
      MakeRect(TopLeft.X + Padding.Left, TopLeft.Y + Padding.Top,
        MaxSize.X - Padding.Left - Padding.Right,
        MaxSize.Y - Padding.Top - Padding.Bottom),
      FStringFormat, FGPBrush);
  end;
end;

procedure TTextLayoutGDIPlus.DoRenderLayout;
var
  i: Integer;
  LRegion: TRegion;
begin
  if not Assigned(FStringFormat) or not Assigned(FGraphics) then
    Exit;

  FreeAndNil(FGPFont);
  if Assigned(LayoutCanvas) then
  begin
    if not TCanvasGdiPlus(LayoutCanvas).FGPFamily.IsStyleAvailable(vgStyleToGPStyle(Font.Style)) then
    begin
      FGPFont := TGPFont.Create(TCanvasGdiPlus(LayoutCanvas).FGPFamily,
        Font.Size * 0.75 * TCanvasGdiPlus(LayoutCanvas).FFontScale, 0);
      if not Assigned(FGPFont) then
        FGPFont := TGPFont.Create(TCanvasGdiPlus(LayoutCanvas).FGPFamily,
          Font.Size * 0.75 * TCanvasGdiPlus(LayoutCanvas).FFontScale,
          vgStyleToGPStyle(Font.Style));
    end
    else
      FGPFont := TGPFont.Create(TCanvasGdiPlus(LayoutCanvas).FGPFamily,
        Font.Size * 0.75 * TCanvasGdiPlus(LayoutCanvas).FFontScale,
        vgStyleToGPStyle(Font.Style),
        UnitPoint);
  end
  else
    FGPFont := TGPFont.Create(Font.Family, (Font.Size * 0.75), vgStyleToGPStyle(Font.Style), UnitPoint);
  //Word wrap and trimming
  if WordWrap then
    FStringFormat.SetFormatFlags(FStringFormat.GetFormatFlags and not StringFormatFlagsNoWrap)
  else
    FStringFormat.SetFormatFlags(FStringFormat.GetFormatFlags or StringFormatFlagsNoWrap);
  case Trimming of
    TTextTrimming.ttNone:
      FStringFormat.SetTrimming(StringTrimmingNone);
    TTextTrimming.ttCharacter:
      FStringFormat.SetTrimming(StringTrimmingEllipsisCharacter);
    TTextTrimming.ttWord:
      FStringFormat.SetTrimming(StringTrimmingEllipsisWord);
  end;
  if RightToLeft then
    FStringFormat.SetFormatFlags(FStringFormat.GetFormatFlags or
      StringFormatFlagsDirectionRightToLeft);
  case HorizontalAlign of
    TTextAlign.taCenter:
      FStringFormat.SetAlignment(StringAlignmentCenter);
    TTextAlign.taLeading:
      FStringFormat.SetAlignment(StringAlignmentNear);
    TTextAlign.taTrailing:
      FStringFormat.SetAlignment(StringAlignmentFar);
  end;
  case VerticalAlign of
    TTextAlign.taCenter:
      FStringFormat.SetLineAlignment(StringAlignmentCenter);
    TTextAlign.taLeading:
      FStringFormat.SetLineAlignment(StringAlignmentNear);
    TTextAlign.taTrailing:
      FStringFormat.SetLineAlignment(StringAlignmentFar);
  end;
  //Measuring text size
  LRegion := MeasureRange(0, Max(Text.Length, 1));
  if Length(LRegion) > 0 then
  begin
    for i := 1 to High(LRegion) do
      LRegion[0].Union(LRegion[i]);
    FLeft := LRegion[0].Left;
    FTop := LRegion[0].Top;
    FWidth := LRegion[0].Width;
    FHeight := LRegion[0].Height;
  end;
end;

function TTextLayoutGDIPlus.GetTextHeight: Single;
begin
  Result := FHeight;
end;

function TTextLayoutGDIPlus.GetTextRect: TRectF;
begin
  Result := TRectF.Create(FLeft, FTop, FLeft + FWidth, FTop + FHeight);
  Result.Offset(TopLeft);
end;

function TTextLayoutGDIPlus.GetTextWidth: Single;
begin
  Result := FWidth;
end;

function TTextLayoutGDIPlus.MeasureRange(const APos, ALength: Integer): TRegion;
var
  CharRange: TCharacterRange;
  pCharRangeRegions: array of TGPRegion;
  i, Count: Integer;
{$IFDEF CPUX64}
  SavedExceptionMask: TSSEExceptionMask;
{$ENDIF CPUX64}
  M: TGPMatrix;
  RectCount: Integer;
  Rects: array of TGPRectF;
  j: Integer;
  LText: string;
begin
  SetLength(Result, 0);
  CharRange := MakeCharacterRange(APos, ALength);
  FStringFormat.SetMeasurableCharacterRanges(1, @CharRange);
  Count := FStringFormat.GetMeasurableCharacterRangeCount;
  SetLength(pCharRangeRegions, Count);
  if Count > 0 then
    for i := 0 to Count - 1 do
      pCharRangeRegions[i] := TGPRegion.Create;
  // measure
{$IFDEF CPUX64}
  SavedExceptionMask := GetSSEExceptionMask;
  SetSSEExceptionMask(exAllArithmeticExceptions);
  try
{$ENDIF CPUX64}
  LText := Text;
  if LText.IsEmpty then
    LText := '-'
  else
    if LText.Chars[LText.Length - 1] = ' ' then
      LText[LText.Length] := '-';
  FGraphics.MeasureCharacterRanges(LText, -1, FGPFont,
    MakeRect(Padding.Left, Padding.Top,
      MaxSize.X - Padding.Left - Padding.Right,
      MaxSize.Y - Padding.Top - Padding.Bottom),
    FStringFormat, Count, pCharRangeRegions);
{$IFDEF CPUX64}
  finally
    SetSSEExceptionMask(SavedExceptionMask); // restore SSE's exception mask.
  end;
{$ENDIF CPUX64}

  M := TGPMatrix.Create;
  for i := 0 to Count - 1 do
  begin
    RectCount := pCharRangeRegions[i].GetRegionScansCount(M);
    if RectCount > 0 then
    begin
      SetLength(Rects, RectCount);
      pCharRangeRegions[i].GetRegionScans(M, PGPRectF(@Rects[0]), RectCount);
      for j := 0 to RectCount - 1 do
      begin
        SetLength(Result, Length(Result) + 1);
        Result[High(Result)] := RectF(Rects[j].X, Rects[j].y,
          Rects[j].X + Rects[j].Width, Rects[j].y + Rects[j].Height);
        if Text.IsEmpty then
          Result[High(Result)].Width := 0;
      end;
    end;
    FreeAndNil(pCharRangeRegions[i]);
  end;
  FreeAndNil(M);

//  for i := 0 to Count - 1 do
//  begin
//    pCharRangeRegions[i].GetBounds(LRect, FGraphics);
//    FreeAndNil(pCharRangeRegions[i]);
//    SetLength(Result, Length(Result) + 1);
//    Result[High(Result)] := RectF(LRect.X, LRect.Y,
//      LRect.X + LRect.Width, LRect.Y + LRect.Height);
//  end;
  SetLength(pCharRangeRegions, 0);
end;

function TTextLayoutGDIPlus.DoPositionAtPoint(const APoint: TPointF): Integer;

  function RegionContains(const ARegion: TRegion; const APoint: TPointF): Boolean;
  var
    i: Integer;
  begin
    Result := False;
    for i := 0 to High(ARegion) do
      Result := Result or ((APoint.X >= ARegion[i].Left) and
        (APoint.X <= (ARegion[i].Left + MaxSize.X)) and
        (APoint.Y >= ARegion[i].Top) and (APoint.Y <= ARegion[i].Bottom));
  end;

var
  RegionL, RegionR: TRegion;
  LPoint: TPointF;
  L, M, R: Integer;
  LRect: TRectF;
begin
  Result := -1;
  LRect := Self.TextRect;
  if not ((APoint.X >= LRect.Left) and (APoint.X <= LRect.Right) and
     (APoint.Y >= LRect.Top) and (APoint.Y <= LRect.Bottom)) then
    begin
      if ((APoint.X >= LRect.Left) and (APoint.X <= (LRect.Left + MaxSize.X)) and
         (APoint.Y >= LRect.Top) and (APoint.Y <= LRect.Bottom)) then
        Result := Text.Length;
      Exit;
    end;
  if Text.IsEmpty then
    Exit(0);
  LPoint := PointF(APoint.X - TopLeft.X, APoint.Y - TopLeft.Y);
  //Using binary search to find point position
  L := 0;
  R := Text.Length - 1;
  while L <= R do
  begin
    M := (L + R) shr 1;
    RegionL := MeasureRange(L, M - L + 1);
    RegionR := MeasureRange(M + 1, R - M);
    if RegionContains(RegionR, LPoint) then
      L := M + 1
    else
    begin
      if (M - L) = 0 then
      begin
        Result := M;
        if APoint.X > (RegionL[0].Left + RegionL[0].Width * 3 / 5) then
          Inc(Result);
        Exit;
      end;
      R := M;
    end;
  end;
end;

function TTextLayoutGDIPlus.DoRegionForRange(const ARange: TTextRange): TRegion;
var
  i: Integer;
begin
  if ARange.Pos < 0 then
    Exit;

  if (ARange.Pos = Text.Length) and (ARange.Length = 0) then
    if Text.IsEmpty then
    begin
      SetLength(Result, 1);
      Result[0] := Self.TextRect;
      Exit;
    end
    else
    begin
      Result := MeasureRange(Text.Length - 1, 1);
      for i := Low(Result) to High(Result) do
        Result[i].Left := Result[i].Right;
    end
  else
  begin
    Result := MeasureRange(ARange.Pos, ARange.Length);
    if Length(Result) = 0 then
    begin
      SetLength(Result, 1);
      Result[0] := Self.TextRect;
      Result[0].Left := Result[0].Right;
      Exit;
    end;
  end;
  for i := Low(Result) to High(Result) do
    Result[i].Offset(TopLeft);
end;

procedure RegisterCanvasClasses;
begin
  TCanvasManager.RegisterCanvas(TCanvasGdiPlus, False, True);
end;

procedure UnregisterCanvasClasses;
begin
  TCanvasGdiPlus.DestroySharedResources;
end;

initialization
  TTextLayoutManager.RegisterTextLayout(TTextLayoutGDIPlus, TCanvasGdiPlus);
finalization
  FreeAndNil(TCanvasGdiPlus.FLockedBitmapData);
end.

