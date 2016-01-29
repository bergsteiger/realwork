{$I ..\Utils\gtCompilerDefines.inc}
unit PDImageDev;

interface

uses
  Classes, PDExportDevice, PDState, PDMatrix, gtObject, PDImage, gtTypes,
  ActiveX, Windows, PDTypes, PDPath, Stream, PDFont, FontProcessor,
  PDStdFontMap, SysUtils, Graphics, PDForm, PDIGDIPlus;

type

  TgtPDImageDevice = class(TgtPDExportDevice)
  private                                                           
    FImage: TStream;
    FTempImage: TStream;
    FAllowAntiAlias: Boolean;
    FUseGDI: Boolean;

    FCurrentMatrix: TgtPDMatrix;

    FPen: IGPPen;
    FBrush: IGPSolidBrush;
    FHasFlatness: Boolean;
    FStateStack: TList;
    FFillOpacity: Double;
    FStrokeOpacity: Double;
    FFont: IGPFont;
    FFontFamily: IGPFontFamily;
    FFontProcessor: TgtFontProcessor;

    FFontList: TStrings;

    FIStream: IStream;
    FGPImage: IGPImage;
    FGraphics: IGPGraphics;
    FCurrentState: TgtPDState;
    FCurrentPath: IGPGraphicsPath;
    FTMProcessed: Boolean;
    FWidth, FHeight: Double;
    FPageHeight: Double;
//    FCurX, FCurY: Double;

//    FMetafile: TMetafile;
//    FMetafileCan: TMetafileCanvas;
//    FHandle: HDC;
//    FXMul: Double;
    FYMul: Double;
    FPenWidth: Double;
    FStrokeColor: Cardinal;
    FFillColor: Cardinal;
    FFontName: AnsiString;
    FFontStyle: TFontStyles;
    FFontSize: Integer;
    FUseDualEMFPLus: Boolean;
//    FSaveState: Cardinal;

    procedure UpdateGPPath(GPPath: IGPGraphicsPath; State: TgtPDState);
    procedure UpdateGPLineDash(State: TgtPDState);
    procedure DrawCharacter(AGlyphPoints: TgtPointsList; AdvanceWidth, AdvanceHeight: Double;
      EvenOddFill: Boolean; ReverseFill: Boolean);
    procedure InsertLogo;

  public
    constructor Create(aImage: TStream; allowAntiAlias: Boolean = True;
      aUseGDI: Boolean = False; aUseDualEMFPlus: Boolean = True);
    destructor Destroy; override;
    function CheckPageSlice(Page: TgtObject; hDPI, vDPI: Double;
      Rotate: Integer; UseMediaBox, Crop: Boolean; SliceX, SliceY, SliceW,
      SliceH: Double): Boolean; override;
    // Start a page.
    procedure StartPage(nPage: Integer; State: TgtPDState); override;
    // End a page.
    procedure EndPage; override;

    //----- save/restore graphics state
    procedure SaveState(State: TgtPDState); override;
    procedure RestoreState(State: TgtPDState); override;

    //----- update graphics state
    procedure UpdateCTM(State: TgtPDState; CTM: TgtPDMatrix); override;
    procedure UpdateFlatness(State: TgtPDState); override;
    procedure UpdateLineJoin(State: TgtPDState); override;
    procedure UpdateLineCap(State: TgtPDState); override;
    procedure UpdateMiterLimit(State: TgtPDState); override;
    procedure UpdateLineWidth(State: TgtPDState); override;
    procedure UpdateFillColor(State: TgtPDState); override;
    procedure UpdateStrokeColor(State: TgtPDState); override;
    procedure UpdateFillOpacity(State: TgtPDState); override;
    procedure UpdateStrokeOpacity(State: TgtPDState); override;

    //----- update text state
    procedure UpdateFont(State: TgtPDState); override;
    procedure UpdateTextMatrix(State: TgtPDState); override;
    procedure UpdateTextPos(State: TgtPDState); override;

    //----- path painting
    procedure Stroke(State: TgtPDState); override;
    procedure Fill(State: TgtPDState); override;
    procedure EvenOddFill(State: TgtPDState); override;

    //----- path clipping
    procedure Clip(State: TgtPDState); override;
    procedure EvenOddClip(State: TgtPDState); override;
    procedure ClipToStrokePath(State: TgtPDState); override;

    //----- text drawing
    procedure DrawChar(State: TgtPDState; X: Double; Y: Double;
      Dx, Dy: Double; Code: TgtCharCode; const CharName: AnsiString); override;

    procedure EndTextObject(State: TgtPDState); override;

    //----- image drawing
    procedure DrawImage(State: TgtPDState; Image: TgtPDImage); override;

    procedure DrawFormXObject(State: TgtPDState; Form: TgtPDForm); override;

    procedure ResetDevice(State: TgtPDState); override;

    property FontList: TStrings read FFontList write FFontList;
  end;

implementation

{$IFNDEF gtRegistered}
{$R gtpdf.res}
{$ENDIF}

uses
{$IFDEF DEBUG}
  gtLogger,
{$ENDIF}
  PDContentStream, PDResource, PDDeviceNColorSpace, Forms, gtStreamAdpt, FreeType,
{$IFDEF VCL7ORABOVE}StrUtils{$ELSE} gtStrUtils{$ENDIF};

type
  tagScaleRotate = record
    Rotationangle,
      XScaling,
      YScaling: Double;
  end;

function AnsiTextStartsWith(const ASubStr, AStr: AnsiString): Boolean;
begin
  Result := AnsiSameText(ASubStr, AnsiLeftStr(AStr, Length(ASubStr)));
end;

function MapType1FontNameToWinFontName(const AFontName: AnsiString): AnsiString;
begin
  Result := AFontName;

  if AnsiSameText(AFontName, 'Times-BoldItalic') or
      AnsiSameText(AFontName, 'Times-Italic') or
      AnsiSameText(AFontName, 'Times-Bold') or
      AnsiSameText(AFontName, 'Times-Roman') or
      AnsiSameText(AFontName, 'Times_Roman') or
      AnsiSameText(AFontName, 'Times_BoldItalic') or
      AnsiSameText(AFontName, 'Times_Italic') or
      AnsiSameText(AFontName, 'Times_Bold') or
      AnsiSameText(AFontName, 'Times New Roman') or
      (AnsiPos(AnsiLowerCase('times'), AnsiLowerCase(AFontName)) > 0) or // Times
      (AnsiPos(AnsiLowerCase('timesb'), AnsiLowerCase(AFontName)) > 0) or // TimesB
      (AnsiPos(AnsiLowerCase('timesbobl'), AnsiLowerCase(AFontName)) > 0) or // TimesBObl
      (AnsiPos(AnsiLowerCase('timesit'), AnsiLowerCase(AFontName)) > 0) then // TimesIt
    Result := 'TimesNewRoman'
  else if (AnsiTextStartsWith('Helvetica', AFontName) or
      AnsiTextStartsWith('Helv', AFontName)) and
      (AnsiPos(AnsiLowerCase('narrow'), AFontName) > 0) then
  begin
    if (AnsiPos(AnsiLowerCase('bold'), AFontName) > 0) and
        (AnsiPos(AnsiLowerCase('italic'), AFontName) > 0) then
      Result := 'ArialNarrowBoldItalic'
    else if AnsiPos(AnsiLowerCase('bold'), AFontName) > 0 then
      Result := 'ArialNarrowBold'
    else if AnsiPos(AnsiLowerCase('italic'), AFontName) > 0 then
      Result := 'ArialNarrowItalic'
    else
      Result := 'ArialNarrow';
  end
  else if AnsiSameText(AFontName, 'Helvetica-Oblique') or
      AnsiSameText(AFontName, 'Helvetica-BoldOblique') or
      AnsiSameText(AFontName, 'Helvetica-Bold') or
      AnsiSameText(AFontName, 'Helvetica_Oblique') or
      AnsiSameText(AFontName, 'Helvetica_BoldOblique') or
      AnsiSameText(AFontName, 'Helvetica_Bold') or
      AnsiSameText(AFontName, 'Helvetica') or
      AnsiSameText(AFontName, 'HelveticaNeue') or
      (AnsiPos(AnsiLowerCase('helveticab'), AnsiLowerCase(AFontName)) > 0) or // HelveticaB
      (AnsiPos(AnsiLowerCase('helveticabobl'), AnsiLowerCase(AFontName)) > 0) or // HelveticaBObl
      (AnsiPos(AnsiLowerCase('helvb'), AnsiLowerCase(AFontName)) > 0) or // HelvB
      (AnsiPos(AnsiLowerCase('helvbobl'), AnsiLowerCase(AFontName)) > 0) then // HelvBObl
    Result := 'Arial'
  else if AnsiSameText(AFontName, 'Courier-BoldOblique') or
      AnsiSameText(AFontName, 'Courier-Oblique') or
      AnsiSameText(AFontName, 'Courier-Bold') or
      AnsiSameText(AFontName, 'Courier_BoldOblique') or
      AnsiSameText(AFontName, 'Courier_Oblique') or
      AnsiSameText(AFontName, 'Courier_Bold') or
      AnsiSameText(AFontName, 'Courier') or
      (AnsiPos(AnsiLowerCase('courierb'), AnsiLowerCase(AFontName)) > 0) or // CourierB
      (AnsiPos(AnsiLowerCase('courierbobl'), AnsiLowerCase(AFontName)) > 0) then // CourierBObl
    Result := 'CourierNew';
end;


function GetRotationandScaling(AA1tm, AB1tm, AC1tm, AD1tm: double): tagScaleRotate;
var
  LB1tm, LC1tm, LD1tm, LA1tm: Double;
  TextRotation, XTextScaling, YTextScaling: Double;
begin
  LA1tm := AA1tm;
  LB1tm := AB1tm;
  LC1tm := AC1tm;
  LD1tm := AD1tm;

  if ((LB1tm = 0) and (LC1tm = 0)) then
  begin
    if (LA1tm < 0) and (LD1tm < 0) then
    begin
      TextRotation := 180;
      if not (abs(LA1tm) = 1) and not (abs(LD1tm) = 1) then
      begin
        XTextScaling := LA1tm / cos(TextRotation * (3.14286 / 180));
        YTextScaling := LD1tm / cos(TextRotation * (3.14286 / 180));
      end
      else
      begin
        XTextScaling := 1;
        YTextScaling := 1;
      end;
    end
    else
    begin
      XTextScaling := LA1tm;
      YTextScaling := LD1tm;
      TextRotation := 0;
    end;
  end
  else if ((LA1tm = 0) and (LD1tm = 0)) then
  begin
    if LC1tm < 0 then
      TextRotation := 90
    else
      TextRotation := 270;
    if not (abs(LB1tm) = 1) and not (abs(LC1tm) = 1) then
    begin
      XTextScaling := LB1tm / Sin((TextRotation) * (3.14286 / 180));
      YTextScaling := LC1tm / -Sin((TextRotation) * (3.14286 / 180));
    end
    else
    begin
      XTextScaling := 1;
      YTextScaling := 1;
    end;
  end else if (LA1tm > 0) and (LB1tm > 0) then
  begin
    TextRotation := Round(ArcTan(LB1tm / LA1tm) * (180 / 3.14286));
    XTextScaling := LA1tm / cos(TextRotation * (3.14286 / 180));
    YTextScaling := LD1tm / cos(TextRotation * (3.14286 / 180));
  end
  else
    if (LA1tm < 0) and (LB1tm > 0) then
    begin
      TextRotation := Round(90 - (ArcTan(LB1tm / LA1tm) * (180 / 3.14286)));
      XTextScaling := LA1tm / cos(TextRotation * (3.14286 / 180));
      YTextScaling := LD1tm / cos(TextRotation * (3.14286 / 180));
    end
    else if (LA1tm < 0) and (LB1tm < 0) then
    begin
      TextRotation := Round(270 - (ArcTan(LB1tm / LA1tm) * (180 / 3.14286)));
      XTextScaling := LA1tm / cos(TextRotation * (3.14286 / 180));
      YTextScaling := LD1tm / cos(TextRotation * (3.14286 / 180));
    end
    else if (LA1tm > 0) and (LB1tm < 0) then
    begin
      TextRotation := Round(360 + (ArcTan(LB1tm / LA1tm) * (180 / 3.14286)));
      XTextScaling := LA1tm / cos(TextRotation * (3.14286 / 180));
      YTextScaling := LD1tm / cos(TextRotation * (3.14286 / 180));
    end
    else
    begin
      TextRotation := 0;
      XTextScaling := LA1tm;
      YTextScaling := LD1tm;
    end;
  Result.Rotationangle := TextRotation;
  Result.XScaling := XTextScaling;
  Result.YScaling := YTextScaling;
end;

{ TgtPDImageDevice }

function TgtPDImageDevice.CheckPageSlice(Page: TgtObject; hDPI, vDPI: Double;
  Rotate: Integer; UseMediaBox, Crop: Boolean; SliceX, SliceY, SliceW,
  SliceH: Double): Boolean;
begin
  Result := True;
end;

procedure TgtPDImageDevice.Clip(State: TgtPDState);
var
  LGPPath: IGPGraphicsPath;
begin
  LGPPath := TGPGraphicsPath.Create(FillModeWinding);
  try
    UpdateGPPath(LGPPath, State);
    FGraphics.SetClip(LGPPath, CombineModeIntersect);
  finally
    LGPPath := nil;
  end;
end;

procedure TgtPDImageDevice.ClipToStrokePath(State: TgtPDState);
var
  LGPPath: IGPGraphicsPath;
begin
  LGPPath := TGPGraphicsPath.Create;
  try
    UpdateGPLineDash(State);
    UpdateGPPath(LGPPath, State);
    FGraphics.DrawPath(FPen, LGPPath);
    FGraphics.SetClip(LGPPath);
  finally
    LGPPath := nil;
  end;
end;

constructor TgtPDImageDevice.Create(aImage: TStream; allowAntiAlias: Boolean;
  aUseGDI: Boolean; aUseDualEMFPlus: Boolean);
begin
  FImage := aImage;
  FTempImage := nil;

  FUseShadedFill := True;
  FNeedNonText := True;
  FInterpretType3Chars := True;
  FUseDrawChar := True;
  FUseDrawForm := True;
  FUseTillingPatternFill := True;
  FUpsideDown := True;

  FAllowAntiAlias := allowAntiAlias;
  FUseDualEMFPLus := aUseDualEMFPlus;
end;

destructor TgtPDImageDevice.Destroy;
begin
  
  inherited;
end;

procedure TgtPDImageDevice.DrawChar(State: TgtPDState; X, Y, Dx, Dy: Double;
  Code: TgtCharCode; const CharName: AnsiString);
var
  LS: WideString;
  LBaseLineOffset: Double;
  LSave: Cardinal;
  LFormatString: IGPStringFormat;
  LX, LY: Double;
  LFontSize: Integer;
  LMatrix: IGPMatrix;
begin
  LFormatString := nil;
  if State.Render <> 3 then
  begin
    LSave := FGraphics.Save;

    if Assigned(FCurrentMatrix) then
    begin
      LMatrix := TGPMatrix.Create;
      try
        LMatrix.SetElements(State.TextMatrix.M11, -State.TextMatrix.M12,
          -State.TextMatrix.M21, State.TextMatrix.M22, State.TextMatrix.Dx,
          -State.TextMatrix.Dy);
        FGraphics.MultiplyTransform(LMatrix);
      finally
        LMatrix := nil;
      end;
    end
    else
    begin
      LMatrix := TGPMatrix.Create;
      try
        LMatrix.SetElements(State.TextMatrix.M11, -State.TextMatrix.M12,
          -State.TextMatrix.M21, State.TextMatrix.M22, State.TextMatrix.Dx,
          FPageHeight - State.TextMatrix.Dy);
        FGraphics.SetTransform(LMatrix);
      finally
        LMatrix := nil;
      end;
    end;

    if Assigned(FFont) then
    begin
      FGraphics.TranslateTransform(X, -Y);

      LS := WideChar(Code);
      if Assigned(FFontFamily) then
        LBaseLineOffset := FFont.GetSize / FFontFamily.GetEmHeight(FFont.GetStyle)
          * FFontFamily.GetCellAscent(FFont.GetStyle)
      else
      begin
        LBaseLineOffset := FFont.GetSize;
        FFontFamily := FFont.Family;
      end;

      LBaseLineOffset := LBaseLineOffset + State.Rise;
      LFormatString := TGPStringFormat.GenericTypographic;
      FCurrentPath := TGPGraphicsPath.Create;

      FCurrentPath.AddString(LS, FFontFamily, FFont.GetStyle, FFont.GetSize,
        MakePoint(0, -Round(LBaseLineOffset)), LFormatString);

      LFormatString := nil;

      LMatrix := TGPMatrix.Create(State.HorizScaling , 0, 0, 1, 0, 0);
      FCurrentPath.Transform(LMatrix);
      LMatrix := nil;
      if State.Render = 0 then
      begin
        FGraphics.FillPath(FBrush, FCurrentPath);
      end
      else if State.Render = 1 then
      begin
        FPen.SetWidth(State.LineWidth / 10);
        FGraphics.DrawPath(FPen, FCurrentPath);
      end
      else if State.Render = 2 then
      begin
        FPen.SetWidth(State.LineWidth / 10);
        FGraphics.DrawPath(FPen, FCurrentPath);
        FGraphics.FillPath(FBrush, FCurrentPath);
      end;
      FCurrentPath := nil;
    end
    else if Assigned(FFontProcessor) then
    begin
      LS := WideChar(Code);
      FCurrentState := State;

      LY := 0;
      LX := 0;

      if State.FontSize < 50 then
        LFontSize := 50
      else
        LFontSize := Round(State.FontSize);

      FCurrentPath := TGPGraphicsPath.Create;

      if (State.Font.FontType = Type1) or (State.Font.FontType = Type1C) or
        (State.Font.FontType = Type1COT) then
      begin
        if CharName <> '' then
          FFontProcessor.DecomposeOutlineGlyph(CharName, LFontSize, LX, LY, True,
            DrawCharacter, gtGlyphName)
        else
          FFontProcessor.DecomposeOutlineGlyph(LS, LFontSize, LX, LY, True,
            DrawCharacter, gtCharacterCode)
      end
      else if State.Font.IsCIDFont then
        FFontProcessor.DecomposeOutlineGlyph(LS, LFontSize, LX, LY, True,
          DrawCharacter, gtGlyphIndex)
      else
      begin
        if (FFontProcessor.DecomposeOutlineGlyph(LS, LFontSize, LX, LY, True,
          DrawCharacter, gtCharacterCode) = NoWindowsCharacterMapFound) then
        begin
          LS := WideChar(Code + $F000);
          FFontProcessor.DecomposeOutlineGlyph(LS, LFontSize, LX, LY, True,
            DrawCharacter, gtCharacterCode);
        end;
      end;

      if State.FontSize < 50 then
      begin
        LMatrix := TGPMatrix.Create(State.FontSize / 50, 0, 0,
          State.FontSize / 50, 0, 0);
        FCurrentPath.Transform(LMatrix);
        LMatrix := nil;
      end;

      FGraphics.TranslateTransform(X, -Y + State.Rise);

      LMatrix := TGPMatrix.Create(State.HorizScaling , 0, 0, 1, 0, 0);
      FCurrentPath.Transform(LMatrix);
      LMatrix := nil;

      if State.Render = 0 then
        FGraphics.FillPath(FBrush, FCurrentPath)
      else if State.Render = 1 then
      begin
        FPen.SetWidth(State.LineWidth / 10);
        FGraphics.DrawPath(FPen, FCurrentPath);
      end
      else if State.Render = 2 then
      begin
        FPen.SetWidth(State.LineWidth / 10);
        FGraphics.DrawPath(FPen, FCurrentPath);
        FGraphics.FillPath(FBrush, FCurrentPath);
      end;
      FCurrentPath := nil;
    end;

    FGraphics.Restore(LSave);
  end;
end;

procedure TgtPDImageDevice.DrawCharacter(AGlyphPoints: TgtPointsList;
  AdvanceWidth, AdvanceHeight: Double; EvenOddFill, ReverseFill: Boolean);
var
  LI: Integer;
  StartX, StartY: Double;
  LP1X, LP1Y, LP2X, LP2Y: Double;
  LMulValue: Double;
  LInFigure: Boolean;
begin
  LI := 0;
  StartX := 0;
  StartY := 0;
  LMulValue := 1;
  LInFigure := False;

  while LI < Length(AGlyphPoints) do
  begin
    case Round(AGlyphPoints[LI]) of
      1:
        begin
          if LInFigure then
            FCurrentPath.CloseFigure;
          FCurrentPath.StartFigure;
          LInFigure := True;
          StartX := AGlyphPoints[LI + 1] * LMulValue;
          StartY := AGlyphPoints[LI + 2] * LMulValue;
          Inc(LI, 3);
        end;
      2:
        begin
          FCurrentPath.AddLineF(StartX, StartY, AGlyphPoints[LI + 1] * LMulValue, AGlyphPoints[LI + 2] * LMulValue);
          StartX := AGlyphPoints[LI + 1] * LMulValue;
          StartY := AGlyphPoints[LI + 2] * LMulValue;
          Inc(LI, 3);
        end;
      3:
        begin
          LP1X := StartX + 2.0 / 3.0 * (AGlyphPoints[LI + 1] * LMulValue - StartX);
          LP1Y := StartY + 2.0 / 3.0 * (AGlyphPoints[LI + 2] * LMulValue - StartY);
          LP2X := LP1X + (AGlyphPoints[LI + 3] * LMulValue - StartX) / 3.0;
          LP2Y := LP1Y + (AGlyphPoints[LI + 4] * LMulValue - StartY) / 3.0;

          FCurrentPath.AddBezierF(StartX, StartY, LP1X, LP1Y,
            LP2X, LP2Y, AGlyphPoints[LI + 3] * LMulValue, AGlyphPoints[LI + 4] * LMulValue);
          StartX := AGlyphPoints[LI + 3] * LMulValue;
          StartY := AGlyphPoints[LI + 4] * LMulValue;
          Inc(LI, 5);
        end;
      4:
        begin
          FCurrentPath.AddBezierF(StartX, StartY, AGlyphPoints[LI + 1] * LMulValue,
            AGlyphPoints[LI + 2] * LMulValue, AGlyphPoints[LI + 3] * LMulValue,
            AGlyphPoints[LI + 4] * LMulValue, AGlyphPoints[LI + 5] * LMulValue,
            AGlyphPoints[LI + 6] * LMulValue);
          StartX := AGlyphPoints[LI + 5] * LMulValue;
          StartY := AGlyphPoints[LI + 6] * LMulValue;
          Inc(LI, 7);
        end;
    end;
  end;
  FCurrentPath.CloseFigure;
  if EvenOddFill then
    FCurrentPath.SetFillMode(FillModeAlternate)
end;

procedure TgtPDImageDevice.DrawFormXObject(State: TgtPDState; Form: TgtPDForm);
var
  LSavedState: Cardinal;
  LClipPath: IGPGraphicsPath;
  LContentStream: TgtPDContentStream;
begin
  if Assigned(Form) then
  begin
    LSavedState := FGraphics.Save;

    if Assigned(Form.Matrix) then
      UpdateCTM(State, Form.Matrix);

    if Assigned(Form.BBox) and (Form.BBox.Left > 0) and (Form.BBox.Top > 0) then
    begin
      LClipPath := TGPGraphicsPath.Create;
      LClipPath.AddRectangleF(MakeRectF(Form.BBox.Left, -Form.BBox.Bottom,
        Form.BBox.Right, -Form.BBox.Top));
      FGraphics.SetClip(LClipPath);
    end;

    LContentStream := TgtPDContentStream.Create(Form.ParentDoc,
      Form.Resources, Form.BaseObject);
    try
      LContentStream.DispalyObject(Self, State.Copy,
        Form.Resources as TgtPDResource);
    finally
      LContentStream.Free;
    end;

    FGraphics.Restore(LSavedState);
  end;
end;

procedure TgtPDImageDevice.DrawImage(State: TgtPDState; Image: TgtPDImage);
var
  LImage: IGPImage;
  LStream: TStream;
  LIStream: IStream;
  LColorMatrix: TGPColorMatrix;
  LOutFormat: TgtOutFormat;
  LI, LJ: Integer;
  LImageAttributes: IGPImageAttributes;
  LSaveState: Cardinal;
  LBitmap: TBitmap;
  LRecBitmap: BITMAP;
begin
  LBitmap := nil;
  if Image.ColorSpace is TgtPDDeviceNColorSpace then
    Exit;
  
  LSaveState := FGraphics.Save;
  Image.SetState(State);
  LStream := TMemoryStream.Create;
  try
    LOutFormat := ofJPEG;
    if Image.ImageType = stDCT then
    begin
      Image.SaveToStream(LStream, True, LOutFormat);
    end
    else
      Image.SaveToStream(LStream, ofBMP);

    LStream.Position := 0;
    if Image.ImageMask or Assigned(Image.SoftMask)then  //For creating transparent image
    begin
      LBitmap := TBitmap.Create;
      LBitmap.LoadFromStream(LStream);
      GetObject(LBitmap.Handle, sizeof(BITMAP), @LRecBitmap);
      LImage := TGPBitmap.Create(LRecBitmap.bmWidth, LRecBitmap.bmHeight,
        LRecBitmap.bmWidth * 4, PixelFormat32bppARGB, LRecBitmap.bmBits);
      LImage.RotateFlip(Rotate180FlipX);
    end
    else
    begin                               //Usual image without transparency
      LIStream := TgtStreamAdapter.Create(LStream, soReference);
      LImage := TGPImage.Create(LIStream);
    end;
    try
      for LI := 0 to 4 do
      begin
        for LJ := 0 to 4 do
        begin
          if LI = LJ then
            LColorMatrix[LI, LJ] := 1.0
          else
            LColorMatrix[LI, LJ] := 0.0;
        end;
      end;
      LColorMatrix[3, 3] := FFillOpacity / 255;

      LImageAttributes := TGPImageAttributes.Create;
      try
        LImageAttributes.SetColorMatrix(LColorMatrix, ColorMatrixFlagsDefault,
          ColorAdjustTypeDefault);
        FGraphics.DrawImage(
          LImage,
          MakeRect(0, -1, 1, 1), // destination rectangle
          0, 0, // upper-left corner of source rectangle
          Image.Width, // width of source rectangle
          Image.Height, // height of source rectangle
          UnitPixel,
          LImageAttributes);
      finally
        LImageAttributes := nil;
      end;
    finally
      LImage := nil;
      if Assigned(LBitmap) then
        FreeAndNil(LBitmap);
    end;
  finally
    FreeAndNil(LStream);
  end;
  FGraphics.Restore(LSaveState);
end;

{$O-}
procedure TgtPDImageDevice.EndPage;
var
  LBuffer: Bytes;
begin
  if not IsReg then
    InsertLogo;

  FPen := nil;
  FBrush := nil;
  FFont := nil;
  FFontFamily := nil;
  if Assigned(FFontProcessor) then FreeAndNil(FFontProcessor);
  if Assigned(FCurrentMatrix) then FreeAndNil(FCurrentMatrix);

  FGPImage := nil;

  if Assigned(FStateStack) then FreeAndNil(FStateStack);

  FGraphics := nil;

  FTempImage.Position := 0;
  SetLength(LBuffer, FTempImage.Size);
  FTempImage.Read(LBuffer[0], FTempImage.Size);
  FImage.Write(LBuffer[0], Length(LBuffer));
  SetLength(LBuffer, 0);
  try
    FreeAndNil(FTempImage);
  except

  end;
end;
{$O+}

procedure TgtPDImageDevice.EndTextObject(State: TgtPDState);
begin

end;

procedure TgtPDImageDevice.EvenOddClip(State: TgtPDState);
var
  LGPPath: IGPGraphicsPath;
begin
  inherited;
  LGPPath := TGPGraphicsPath.Create(FillModeAlternate);
  try
    UpdateGPPath(LGPPath, State);
    FGraphics.SetClip(LGPPath, CombineModeIntersect);
  finally
    LGPPath := nil;
  end;
end;

procedure TgtPDImageDevice.EvenOddFill(State: TgtPDState);
var
  LGPPath: IGPGraphicsPath;
begin
  LGPPath := TGPGraphicsPath.Create;
  try
    UpdateGPPath(LGPPath, State);
    LGPPath.SetFillMode(FillModeAlternate);
    FGraphics.FillPath(FBrush, LGPPath);
  finally
    LGPPath := nil;
  end;
end;

procedure TgtPDImageDevice.Fill(State: TgtPDState);
var
  LGPPath: IGPGraphicsPath;
begin
  LGPPath := TGPGraphicsPath.Create;
  try
    UpdateGPPath(LGPPath, State);
    LGPPath.SetFillMode(FillModeWinding);
    FGraphics.FillPath(FBrush, LGPPath);
  finally
    LGPPath := nil;
  end;
end;

procedure TgtPDImageDevice.InsertLogo;
var
  LLogo: TBitmap;
  LLogoStream: TStream;
  LIStream: IStream;
  LImage: IGPImage;
  LI, LJ: Integer;
  LColorMatrix: TGPColorMatrix;
  LImageAttributes: IGPImageAttributes;
  LLogoWidth, LLogoHeight: Integer;
  LMatrix: IGPMatrix;
begin
  LLogoStream := TMemoryStream.Create;
  try
    LLogo := TBitmap.Create;
    try
      LLogo.PixelFormat := pf16bit;
      LLogo.LoadFromResourceName(HInstance, 'LOGO');
      LLogo.SaveToStream(LLogoStream);
      LLogoStream.Position := 0;
      LLogoWidth := LLogo.Width;
      LLogoHeight := LLogo.Height;
    finally
      LLogo.Free;
    end;
    LIStream := TgtStreamAdapter.Create(LLogoStream, soReference);
    LImage := TGPImage.Create(LIStream);
    try
      for LI := 0 to 4 do
      begin
        for LJ := 0 to 4 do
        begin
          if LI = LJ then
            LColorMatrix[LI, LJ] := 1.0
          else
            LColorMatrix[LI, LJ] := 0.0;
        end;
      end;
      LColorMatrix[3, 3] := 0.4;

      LImageAttributes := TGPImageAttributes.Create;
      try
        LImageAttributes.SetColorMatrix(LColorMatrix, ColorMatrixFlagsDefault,
          ColorAdjustTypeDefault);

        LMatrix := TGPMatrix.Create(1, 0, 0, 1, 0, 0);
        try
          FGraphics.SetTransform(LMatrix);
        finally
         LMatrix := nil;
        end;

        FGraphics.DrawImageF(LImage,
          MakeRectF((FWidth + LLogoWidth)/8, (FHeight + LLogoHeight)/4,
          LLogoWidth, LLogoHeight), // destination Point
          0, 0, // upper-left corner of source rectangle
          LLogoWidth, // width of source rectangle
          LLogoHeight, // height of source rectangle
          UnitPixel,
          LImageAttributes);
      finally
        LImageAttributes := nil;
      end;
    finally
      LImage := nil;
    end;
  finally
    LLogoStream.Free;
  end;
end;

procedure TgtPDImageDevice.ResetDevice(State: TgtPDState);
begin
  inherited;
  while FStateStack.Count > 0 do
    RestoreState(State);
end;

procedure TgtPDImageDevice.RestoreState(State: TgtPDState);
var
  LState: Cardinal;
  LI: Integer;

  LMatrix: IGPMatrix;
  LMarray: TGPMatrixParams;
begin
  if FStateStack.Count >= 1 then
  begin
    LI := FStateStack.Count - 1;
    LState := Cardinal(FStateStack.Items[LI]);
    FGraphics.Restore(LState);
    FStateStack.Delete(LI);

    LMatrix := TGPMatrix.Create;
    try
      LMatrix := IGPMatrix(FGraphics.GetTransform);
      LMarray := LMatrix.GetElements;

      FCurrentMatrix.SetValues(LMarray.m11, LMarray.m12, LMarray.m21, LMarray.m22,
        LMarray.dx, LMarray.dy);

    finally
      LMatrix := nil;
    end;
  end;
  UpdateAll(State);
end;

procedure TgtPDImageDevice.SaveState(State: TgtPDState);
var
  LState: Cardinal;
begin
  LState := FGraphics.Save;
  FStateStack.Add(Pointer(LState));
end;


procedure TgtPDImageDevice.StartPage(nPage: Integer; State: TgtPDState);
var
  LPath: IGPGraphicsPath;
  LDC: HDC;
begin
  inherited;

  FWidth := State.PageWidth;
  FHeight := State.PageHeight;

  FPageHeight := State.PageHeight;

  FTempImage := TMemoryStream.Create;
  FIStream := TgtStreamAdapter.Create(FTempImage);

  LDC := GetDC(0);

  if FUseDualEMFPLus then
  begin
    FGPImage := TGPMetafile.Create(FIStream, LDC, MakeRectF(0, 0,
      State.PageWidth, State.PageHeight), MetafileFrameUnitPixel, EmfTypeEmfPlusDual);
  end
  else
  begin
    FGPImage := TGPMetafile.Create(FIStream, LDC, MakeRectF(0, 0,
      State.PageWidth, State.PageHeight), MetafileFrameUnitPixel, EmfTypeEmfPlusOnly);
  end;

  ReleaseDC(0, LDC);
  FGraphics := TGPGraphics.Create(FGPImage);
  FGraphics.InterpolationMode := InterpolationModeHighQuality;

  FGraphics.SetPageUnit(UnitPixel);
  FGraphics.SetPixelOffsetMode(PixelOffsetModeHighQuality);
  FGraphics.SetTextContrast(4);
  FGraphics.SetPixelOffsetMode(PixelOffsetModeHalf);

  FPen := TGPPen.Create(MakeColor(0, 0, 0));
  FBrush := TGPSolidBrush.Create(MakeColor(255, 255, 255));
  FGraphics.FillRectangleF(FBrush, MakeRectF(0, 0, State.PageWidth,
    State.PageHeight));

  LPath := TGPGraphicsPath.Create;
  try
    LPath.AddRectangleF(MakeRectF(0, 0, State.PageWidth, State.PageHeight));
    FGraphics.SetClip(LPath);
  finally
    LPath := nil;
  end;

  FHasFlatness := False;

  if FAllowAntiAlias then
  begin
    FGraphics.SetSmoothingMode(SmoothingModeAntiAlias);
    FGraphics.SetTextRenderingHint(TextRenderingHintAntiAlias);
  end
  else
  begin
    FGraphics.SetTextRenderingHint(TextRenderingHintSingleBitPerPixel);
    FGraphics.SetSmoothingMode(SmoothingModeHighQuality);
  end;

  FStateStack := TList.Create;

  FFillOpacity := 255.0;
  FStrokeOpacity := 255.0;
  FTMProcessed := False;

  UpdateCTM(State, State.CTM);

end;

procedure TgtPDImageDevice.Stroke(State: TgtPDState);
var
  LGPPath: IGPGraphicsPath;
begin
  LGPPath := TGPGraphicsPath.Create;
  try
    UpdateGPLineDash(State);
    UpdateGPPath(LGPPath, State);
    FGraphics.DrawPath(FPen, LGPPath);
  finally
    LGPPath := nil;
  end;
end;

procedure TgtPDImageDevice.UpdateCTM(State: TgtPDState; CTM: TgtPDMatrix);
var
  LMatrix: IGPMatrix;
begin
  if not Assigned(FCurrentMatrix) then
  begin
    FCurrentMatrix := TgtPDMatrix.Create(CTM.M11, -CTM.M12, -CTM.M21, CTM.M22,
      CTM.Dx, CTM.Dy);
    LMatrix := TGPMatrix.Create;
    try
      LMatrix.SetElements(FCurrentMatrix.M11, FCurrentMatrix.M12,
        FCurrentMatrix.M21, FCurrentMatrix.M22, FCurrentMatrix.Dx,
        FPageHeight - FCurrentMatrix.Dy);
      FGraphics.SetTransform(LMatrix);
    finally
      LMatrix := nil;
    end;
  end
  else
  begin
    LMatrix := TGPMatrix.Create;
    try
      FCurrentMatrix.SetValues(CTM.M11, -CTM.M12, -CTM.M21, CTM.M22,
        CTM.Dx, CTM.Dy);
      LMatrix.SetElements(FCurrentMatrix.M11, FCurrentMatrix.M12,
        FCurrentMatrix.M21, FCurrentMatrix.M22, FCurrentMatrix.Dx,
        -FCurrentMatrix.Dy);
      FGraphics.MultiplyTransform(LMatrix);
    finally
      LMatrix := nil;
    end;
  end;
end;

procedure TgtPDImageDevice.UpdateFillColor(State: TgtPDState);
var
  LRGB: TgtRGB;
begin
  State.GetFillRGB(LRGB);

  LRGB.R := Round(LRGB.R * (255 / 65536));
  LRGB.G := Round(LRGB.G * (255 / 65536));
  LRGB.B := Round(LRGB.B * (255 / 65536));


  if not FUseGDI then
     FBrush := TGPSolidBrush.Create(MakeColor(Round(FFillOpacity),LRGB.R, LRGB.G, LRGB.B))
  else
    FFillColor := RGB(LRGB.R, LRGB.G, LRGB.B);
end;

procedure TgtPDImageDevice.UpdateFillOpacity(State: TgtPDState);
var
  LRGB: TgtRGB;
begin
  FFillOpacity := State.FillOpacity * 255;

  State.GetFillRGB(LRGB);

  LRGB.R := Round(LRGB.R * (255 / 65536));
  LRGB.G := Round(LRGB.G * (255 / 65536));
  LRGB.B := Round(LRGB.B * (255 / 65536));

  if not FUseGDI then
    IGPSolidBrush(FBrush).Color := (MakeColor(Round(FFillOpacity), LRGB.R, LRGB.G, LRGB.B))
  else
    FFillColor := RGB(LRGB.R, LRGB.G, LRGB.B);
end;

procedure TgtPDImageDevice.UpdateFlatness(State: TgtPDState);
begin
  inherited;
  FHasFlatness := True;
end;

procedure TgtPDImageDevice.UpdateFont(State: TgtPDState);
var
  LFontStyle: TFontStyles;
  LFontStream: TStream;
  LName, LAltName: AnsiString;
  ErrorCode: ErrorCodes;
  IsBold, IsItalic: Boolean;
begin
  LFontStyle := [];
  IsItalic := False;
  IsBold := False;

  if Assigned(FFontFamily) then
    FFontFamily := nil;

  if Assigned(FFont) then
    FFont := nil;

  if Assigned(FFontProcessor) then
    FreeAndNil(FFontProcessor);

  LFontStream := State.Font.EmbeddedFontStream;
  if Assigned(LFontStream) then
  begin
    {GP}
    // PDF file to Font processor font encoding mapping
    // Other encodings need to be mapped if required
    {GP}
    FFontProcessor := TgtFontProcessor.Create(LFontStream, Round(State.FontSize),
      Round(State.hDPI), Round(State.vDPI), ErrorCode);
    if State.Font.EncodingName = TgtPDFFontEncoding[2] then // WinAnsi
      FFontProcessor.EncodingType := FT_ENCODING_UNICODE
    else if State.Font.EncodingName = TgtPDFFontEncoding[1] then // MacRoman
      FFontProcessor.EncodingType := FT_ENCODING_APPLE_ROMAN
    else if State.Font.EncodingName = TgtPDFFontEncoding[5] then // Custom
      FFontProcessor.EncodingType := FT_ENCODING_MS_SYMBOL;

{    'StandardEncoding',
    'MacRomanEncoding',
    'WinAnsiEncoding',
    'PDFDocEncoding',
    'MacExpertEncoding',
    'CustomEncoding'}

    if ErrorCode <> Success then
    begin
{$IFDEF DEBUG}
      Logger.LogError('Error parsing Font stream, Replacing with Arial');
{$ENDIF}
      if Assigned(FFontProcessor) then
        FreeAndNil(FFontProcessor);

      if not FUseGDI then
      begin
        FFontFamily := TGPFontFamily.Create('Arial Unicode MS');
        if not FFontFamily.IsAvailable then
        begin
          FFontFamily := nil;
          FFont := TGPFont.Create('Arial Unicode MS', State.FontSize,
            LFontStyle, UnitPoint);
        end
        else
          FFont := TGPFont.Create(FFontFamily, State.FontSize, LFontStyle,
            UnitPoint);
      end
      else
        FFontName := 'Arial Unicode MS';
    end;
  end
  else
  begin
    if State.Font.EmbeddedFontName <> '' then
      LAltName := State.Font.EmbeddedFontName
    else
      LAltName := State.Font.Name;
    LAltName := MapType1FontNameToWinFontName(LAltName);
    LName := FFontList.Values[LAltName];
    if LName = '' then
    begin
      LAltName := StringReplace(LAltName, ',', '', [rfReplaceAll]);
      LAltName := StringReplace(LAltName, '+', '', [rfReplaceAll]);
      LAltName := StringReplace(LAltName, '-', '', [rfReplaceAll]);
      LAltName := StringReplace(LAltName, 'PS', '', []);
      LAltName := StringReplace(LAltName, 'MT', '', []);
      if Pos('Bold', LAltName) > 0 then
      begin
        IsBold := True;
        LAltName := StringReplace(LAltName, 'Bold', '', [rfIgnoreCase]);
      end;

      if Pos('Italic', LAltName) > 0 then
      begin
        IsItalic := True;
        LAltName := StringReplace(LAltName, 'Italic', '', [rfIgnoreCase]);
      end;

      if IsBold or State.Font.IsBold then
      begin
        if IsItalic or State.Font.IsItalic then
          LFontStyle := LFontStyle + [fsBold, fsItalic]
        else
          LFontStyle := LFontStyle + [fsBold];
      end
      else if IsItalic or State.Font.IsItalic then
        LFontStyle := LFontStyle + [fsItalic];
      LName := FFontList.Values[LAltName];
    end;
    if LName = '' then
    begin
{$IFDEF DEBUG}
      Logger.LogError('Font %s not found in system, Replacing with Arial Unicode MS',
        [LAltName]);
{$ENDIF}
      LName := 'Arial Unicode MS';
    end;

    if not FUseGDI then
    begin
      FFontFamily := TGPFontFamily.Create(LName);
      if not FFontFamily.IsAvailable then
      begin
        FFont := TGPFont.Create(LName, State.FontSize,
          LFontStyle, UnitPoint);
        FFontFamily := FFont.Family;
      end
      else
        FFont := TGPFont.Create(FFontFamily, State.FontSize, LFontStyle,
          UnitPoint);
    end
    else
    begin
      FFontName := LName;
      FFontStyle := LFontStyle;
      FFontSize := Round(State.FontSize * FYMul);
    end;
  end;
end;

procedure TgtPDImageDevice.UpdateGPPath(GPPath: IGPGraphicsPath;
  State: TgtPDState);
var
  LI: Integer;
  LJ: Integer;
  LK: Integer;
  LY1, LY2, LY3, LY4: Extended;
  pdfPath: TgtPDPath;
begin
  pdfPath := State.Path;
  for LI := 0 to pdfPath.SubPathCount - 1 do
  begin
    GPPath.StartFigure;
    LJ := 0;
    LK := 0;
    while (LK < (pdfPath.SubPaths[LI].NumPoints)) do
    begin
      if pdfPath.SubPaths[LI].Curve(LJ + 1) then
      begin
        LY1 := -pdfPath.SubPaths[LI].Y(LJ);
        LY2 := -(pdfPath.SubPaths[LI].Y(LJ + 1));
        LY3 := -(pdfPath.SubPaths[LI].Y(LJ + 2));
        LY4 := -(pdfPath.SubPaths[LI].Y(LJ + 3));

        GPPath.AddBezierF(pdfPath.SubPaths[LI].X(LJ), LY1,
          pdfPath.SubPaths[LI].X(LJ + 1), LY2,
          pdfPath.SubPaths[LI].X(LJ + 2), LY3,
          pdfPath.SubPaths[LI].X(LJ + 3), LY4);
        Inc(LJ, 3);
      end
      else
      begin
        LY1 := -(pdfPath.SubPaths[LI].Y(LJ));
        LY2 := -(pdfPath.SubPaths[LI].Y(LJ + 1));

        GPPath.AddLineF(pdfPath.SubPaths[LI].X(LJ), LY1,
          pdfPath.SubPaths[LI].X(LJ + 1), LY2);
        Inc(LJ);
      end;
      Inc(LK);
    end;
  end;
  if (pdfPath.SubPathCount > 0) then
    if pdfPath.SubPaths[pdfPath.SubPathCount - 1].IsClosed then
      GPPath.CloseFigure;
end;

procedure TgtPDImageDevice.UpdateLineCap(State: TgtPDState);
begin
  case State.LineCap of
    0: FPen.SetLineCap(LineCapFlat, LineCapFlat, DashCapFlat);
    1: FPen.SetLineCap(LineCapRound, LineCapRound, DashCapRound);
    2: FPen.SetLineCap(LineCapSquare, LineCapSquare, DashCapRound);
  end;
end;

procedure TgtPDImageDevice.UpdateGPLineDash(State: TgtPDState);
var
  LLineDash: TgtDashArray;
  LLength, LTemp: Integer;
  LStart, LLineWidth: Double;
  LDash: array of Single;
  I: Integer;
begin
  if not FUseGDI then
  begin
    LLineWidth := State.LineWidth;
    State.GetLineDash(LLineDash, LLength, LStart);
    if LLength <> 0 then
    begin
      FPen.SetDashStyle(DashStyleSolid);
      SetLength(LDash, LLength);
      for I := 0 to LLength - 1 do
      begin
        if (LLineWidth > 1) then
        begin
          LDash[I] := LLineDash[I] / LLineWidth;
        end
        else
          LDash[I] := LLineDash[I];

        if LDash[I] = 0 then
          LDash[I] := 0.1;
      end;

      if ((LLength mod 2) <> 0) then
      begin
        LTemp := LLength;
        for I := 0 to LLength - 1 do
        begin
          SetLength(LDash, LTemp + 1);
          LDash[LTemp] := LDash[I];
          Inc(LTemp);
        end;
      end;

      FPen.SetDashStyle(DashStyleCustom);
      FPen.SetDashOffset(LStart / LLength);
      FPen.SetDashPattern(LDash);

      SetLength(LDash, 0);
    end
    else
      FPen.SetDashStyle(DashStyleSolid);
  end;
end;

procedure TgtPDImageDevice.UpdateLineJoin(State: TgtPDState);
begin
  if not FUseGDI then
  begin
    case State.LineJoin of
      0: FPen.SetLineJoin(LineJoinMiter);
      1: FPen.SetLineJoin(LineJoinRound);
      2: FPen.SetLineJoin(LineJoinBevel);
    end;
  end;
end;

procedure TgtPDImageDevice.UpdateLineWidth(State: TgtPDState);
begin
  if not FUseGDI then
    FPen.SetWidth(State.LineWidth)
  else
    FPenWidth := State.LineWidth;
end;

procedure TgtPDImageDevice.UpdateMiterLimit(State: TgtPDState);
begin
  FPen.SetMiterLimit(State.MiterLimit);
end;

procedure TgtPDImageDevice.UpdateStrokeColor(State: TgtPDState);
var
  LRGB: TgtRGB;
begin
  State.GetStrokeRGB(LRGB);

  LRGB.R := Round(LRGB.R * (255 / 65536));
  LRGB.G := Round(LRGB.G * (255 / 65536));
  LRGB.B := Round(LRGB.B * (255 / 65536));

  if not FUseGDI then
    FPen.SetColor(MakeColor(Round(FStrokeOpacity),LRGB.R, LRGB.G, LRGB.B))
  else
    FStrokeColor := RGB(LRGB.R, LRGB.G, LRGB.B);
end;

procedure TgtPDImageDevice.UpdateStrokeOpacity(State: TgtPDState);
var
  LRGB: TgtRGB;
begin
  FStrokeOpacity := State.StrokeOpacity * 255;

  State.GetStrokeRGB(LRGB);

  LRGB.R := Round(LRGB.R * (255 / 65536));
  LRGB.G := Round(LRGB.G * (255 / 65536));
  LRGB.B := Round(LRGB.B * (255 / 65536));

  if not FUseGDI then
    FPen.SetColor(MakeColor(Round(FStrokeOpacity), LRGB.R, LRGB.G, LRGB.B))
  else
    FStrokeColor := RGB(LRGB.R, LRGB.G, LRGB.B);
end;

procedure TgtPDImageDevice.UpdateTextMatrix(State: TgtPDState);
begin
end;

procedure TgtPDImageDevice.UpdateTextPos(State: TgtPDState);
begin
end;

end.
