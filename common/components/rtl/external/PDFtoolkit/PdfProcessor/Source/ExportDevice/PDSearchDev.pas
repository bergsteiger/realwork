unit PDSearchDev;

interface

uses
  Classes, Windows, Graphics, Contnrs, SysUtils, gtObject, gtTypes,
  PDExportDevice, PDState, PDMatrix, PDRect, PDFont, FontProcessor,
  PDIGDIPlus, PD8bitFont, gtFont, gtWidestrings;

type
  TgtLine = class
  private
    FText: WideString;
    FRects: TObjectList;
    FFonts: TObjectList;
    FStartY: Integer;

    function GetRect(Index: Integer): TgtPDRect;
    function GetFont(Index: Integer): TFont;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddRect(aRect: TgtPDRect; Index: Integer);
    procedure AddFont(AState: TgtPDState);
    property StartY: Integer read FStartY write FStartY;
    property Rects[Index: Integer]: TgtPDRect read GetRect;
    property Fonts[Index: Integer]: TFont read GetFont;
    property Text: WideString read FText write FText;
    property RectsL: TObjectList read FRects;
    property FontsL: TObjectList read FFonts;
  end;

  TgtPDSearchDev = class(TgtPDExportDevice)
  private
    FDC: HDC;
    FGraphics: IGPGraphics;

    FCTM: TgtPDMatrix;
    FStateStack: TList;

    FFont: IGPFont;
    FFontFamily: IGPFontFamily;
    FFontProcessor: TgtFontProcessor;
    FCurrentPath: IGPGraphicsPath;

    FFontList: TStrings;

    FLines: TgtWideStringList;
    
    FPrevCode: TgtCharCode;
    FPrevCharW: Double;

    FSingleString: Boolean;
    procedure DrawCharacter(AGlyphPoints: TgtPointsList; AdvanceWidth, AdvanceHeight: Double;
      EvenOddFill: Boolean; ReverseFill: Boolean);
    procedure QuickSort(AStrList: TStringList; L, R: Integer; SCompare: TStringListSortCompare);
//    procedure SortXCord(String);
  public
    constructor Create(AStringList: TgtWideStringList);
    destructor Destroy; override;
    // Start a page.
    procedure StartPage(nPage: Integer; State: TgtPDState); override;
    // End a page.
    procedure EndPage; override;

    function CheckPageSlice(Page: TgtObject; hDPI, vDPI: Double;
      Rotate: Integer; UseMediaBox, Crop: Boolean; SliceX, SliceY, SliceW,
      SliceH: Double): Boolean; override;

    //----- save/restore graphics state
    procedure SaveState(State: TgtPDState); override;
    procedure RestoreState(State: TgtPDState); override;

    //----- update graphics state
    procedure UpdateCTM(State: TgtPDState; CTM: TgtPDMatrix); override;
    procedure UpdateFont(State: TgtPDState); override;
    procedure DrawChar(State: TgtPDState; X: Double; Y: Double;
      Dx, Dy: Double; Code: TgtCharCode; const CharName: AnsiString); override;
    procedure DrawString(const Str: AnsiString; State: TgtPDState); override;
    procedure BeginString(State: TgtPDState; Str: AnsiString); override;
    procedure EndString(State: TgtPDState); override;
    function BeginType3Char(State: TgtPDState; X: Double; Y: Double;
      Dx: Double; Dy: Double; Code: TgtCharCode; Unicode: TgtUnicodes;
      Len: Integer): Boolean; override;

    property FontList: TStrings read FFontList write FFontList;
  end;

  TgtLinesHandle = TgtWideStringList;

  function SortByYCord(List: TgtWideStringList; Index1, Index2: Integer): Integer;

  function lineGetCharRect(const aHandle: TgtLinesHandle; const LineIndex: Integer;
    const CharIndex: Integer; var aRect: TRect): ShortInt; export; stdcall;

  function newLines: TgtLinesHandle; export; stdcall;
  function freeLines(var Handle: TgtLinesHandle): Shortint; export; stdcall;
  function linesGetText(const Handle: TgtLinesHandle; Index: Integer):
    WideString; export; stdcall;
  function linesGetCount(const Handle: TgtLinesHandle): Integer; export; stdcall;


//var
//  FStrList: TStringList;

implementation


uses
{$IFDEF DEBUG}
  gtLogger,
{$ENDIF}
  Math, PDCIDFont, PDTypes;


{ TgtPDSearchDev }

procedure TgtPDSearchDev.BeginString(State: TgtPDState; Str: AnsiString);
begin
  FSingleString := False;
end;

function TgtPDSearchDev.BeginType3Char(State: TgtPDState; X, Y, Dx, Dy: Double;
  Code: TgtCharCode; Unicode: TgtUnicodes; Len: Integer): Boolean;
begin
  DrawChar(State, X, Y, Dx, Dy, Code, '');
end;

function TgtPDSearchDev.CheckPageSlice(Page: TgtObject; hDPI, vDPI: Double;
  Rotate: Integer; UseMediaBox, Crop: Boolean; SliceX, SliceY, SliceW,
  SliceH: Double): Boolean;
begin
  Result := True;
end;

constructor TgtPDSearchDev.Create(AStringList: TgtWideStringList);
begin
  FLines := AStringList;

  FUseShadedFill := True;
  FNeedNonText := True;
  FInterpretType3Chars := True;
  FUseDrawChar := True;
  FUseDrawForm := True;
  FUseTillingPatternFill := True;
  FUpsideDown := True;

//  FStrList := TStringList.Create;
end;

destructor TgtPDSearchDev.Destroy;
begin

  inherited;
end;

procedure TgtPDSearchDev.DrawChar(State: TgtPDState; X, Y, Dx, Dy: Double;
  Code: TgtCharCode; const CharName: AnsiString);
var
  LS: WideString;
  LBaseLineOffset: Double;
  LSave: Cardinal;
  LFormatString: IGPStringFormat;
  LX, LY, LDy: Double;
  LFontSize: Integer;
  LMatrix: IGPMatrix;
  LRect: TGPRect;
  I: Integer;
  LFound: Boolean;
  LLine: TgtLine;
  LStartY: Double;
  LPoint: TGPPointF;
  l_PArr: array of TGPPointF;
//  LStr: string;
  LObj: TObject;
  LUnicodeTable: TToUnicodeTable;
begin
  LSave := FGraphics.Save;

  if Assigned(FCTM) then
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
        State.PageHeight - State.TextMatrix.Dy);
      FGraphics.SetTransform(LMatrix);
    finally
      LMatrix := nil;
    end;
  end;

  LMatrix := TGPMatrix.Create;
  LMatrix := FGraphics.GetTransform;

  LPoint.X := X;
  LPoint.Y := Y;
  SetLength(l_PArr, 1);
  l_PArr[0] := MakePointF( X, Y );
  LMatrix.TransformPointsF(l_PArr);
  LStartY := l_PArr[0].Y; //LMatrix.//LMPoint.Y;
  LMatrix := nil;

  if Assigned(FFont) then
  begin
    FGraphics.TranslateTransform(X, -Y);

    LS := WideChar(Code);
    if Assigned(FFontFamily) then
      LBaseLineOffset := FFont.GetSize / FFontFamily.GetEmHeight(FFont.GetStyle)
        * FFontFamily.GetCellAscent(FFont.GetStyle)
    else
      LBaseLineOffset := FFont.GetSize;

    LBaseLineOffset := LBaseLineOffset + State.Rise;
    LFormatString := TGPStringFormat.GenericTypographic;

    FCurrentPath := TGPGraphicsPath.Create;
    FCurrentPath.AddString(LS, FFontFamily, FFont.GetStyle, FFont.GetSize,
      MakePoint(0, -Round(LBaseLineOffset)), LFormatString);

    LMatrix := TGPMatrix.Create(State.HorizScaling, 0, 0, 1, 0, 0);
    FCurrentPath.Transform(LMatrix);
    LMatrix := nil;

    LMatrix := TGPMatrix.Create;
    LMatrix := FGraphics.GetTransform;
    FCurrentPath.Transform(LMatrix);
    LMatrix := nil;

    LRect := FCurrentPath.GetBounds;

    FCurrentPath := nil;
  end
  else if Assigned(FFontProcessor) then
  begin
    LS := WideChar(Code);

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
    begin
      FFontProcessor.DecomposeOutlineGlyph(LS, LFontSize, LX, LY, True,
        DrawCharacter, gtGlyphIndex);
      LUnicodeTable := TgtPDCIDFont(State.Font).GetToUnicode;
      if Assigned(LUnicodeTable) then
        Code := LUnicodeTable.Code[Code];
    end
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

    LMatrix := TGPMatrix.Create(State.HorizScaling, 0, 0, 1, 0, 0);
    FCurrentPath.Transform(LMatrix);
    LMatrix := nil;

    LMatrix := TGPMatrix.Create;
    LMatrix := FGraphics.GetTransform;
    FCurrentPath.Transform(LMatrix);
    LMatrix := nil;

    LRect := FCurrentPath.GetBounds;

    FCurrentPath := nil;
  end;
//  LStr := '';
//  LStr := Char(Code) + '    X: ' + FloatToStr(LRect.X) + ' Y: ' + FloatToStr(LRect.Y)
//    + ' Right: ' + FloatToStr(LRect.Width + LRect.X) + ' FontSize: ' +
//    FloatToStr(State.FontSize * State.HorizScaling) + ' CharSpace: ' +
//    FloatToStr(state.CharSpace) ;
//  FStrList.Add(LStr);
  LObj := State.Font.GetToUnicode;
//  if (State.Font is TgtPD8bitFont) and Assigned(LObj) then
//    Code := State.Font.GetToUnicode.Code[Code];

  FGraphics.Restore(LSave);
  LFound := False;
  for I := 0 to FLines.Count - 1 do
  begin
    if TgtLine(FLines.Objects[I]).StartY = Round(LStartY) then
    begin
      LFound := True;
      with TgtLine(FLines.Objects[I]) do
      begin
        if FSingleString then
        begin
          Text := Text + WideChar(Code);
          AddRect(TgtPDRect.Create(LRect.X, LRect.Y, LRect.X + LRect.Width,
            LRect.Y + LRect.Height), Length(Text) - 1);
          AddFont(State);
        end
        else if (Abs(LRect.X  - (Abs(FPrevCharW) + Rects[Length(Text) - 1].Left)) > Abs(FPrevCharW) / 2)
          and (Code <> 32) then
        begin
          if FPrevCode <> 32 then
          begin
            Text := Text + WideChar(32);
            AddRect(TgtPDRect.Create(0, 0, 0, 0), Length(Text) - 1);
            FFonts.Add(nil);
          end;
          Text := Text + WideChar(Code);
          AddRect(TgtPDRect.Create(LRect.X, LRect.Y, LRect.X + LRect.Width,
            LRect.Y + LRect.Height), Length(Text) - 1);
          AddFont(State);
        end
        else
        begin
          Text := Text + WideChar(Code);
          AddRect(TgtPDRect.Create(LRect.X, LRect.Y, LRect.X + LRect.Width,
            LRect.Y + LRect.Height), Length(Text) - 1);
          AddFont(State);
        end;

//        Text := Text + AnsiChar(Code);
//        AddRect(TgtPDRect.Create(LRect.X, LRect.Y, LRect.X + LRect.Width,
//          LRect.Y + LRect.Height), Length(Text) - 1);
      end;
      State.TextTransformDelta(State.CurCharW, 0, FPrevCharW, LDy);
      FPrevCode := Code;
      Break;
    end;
  end;

  if LFound = False then
  begin
    if FSingleString then
    begin
      with TgtLine(FLines.Objects[FLines.Count - 1]) do
      begin
        Text := Text + WideChar(Code);
        AddRect(TgtPDRect.Create(LRect.X, LRect.Y, LRect.X + LRect.Width,
          LRect.Y + LRect.Height), Length(Text) - 1);
      end;
    end
    else
    begin
      LLine := TgtLine.Create;
      with LLine do
      begin
        StartY := Round(LStartY);
        Text := Text + WideChar(Code);
        AddRect(TgtPDRect.Create(LRect.X, LRect.Y, LRect.X + LRect.Width,
          LRect.Y + LRect.Height), Length(Text) - 1);
        AddFont(State);
      end;
      FLines.AddObject('', LLine);
      FPrevCode := Code;
      State.TextTransformDelta(State.CurCharW, 0, FPrevCharW, LDy);
    end;
  end;

  if not FSingleString then
    FSingleString := True;
end;

procedure TgtPDSearchDev.DrawCharacter(AGlyphPoints: TgtPointsList;
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
    FCurrentPath.SetFillMode(FillModeAlternate);
end;

procedure TgtPDSearchDev.DrawString(const Str: AnsiString; State: TgtPDState);
begin

end;

procedure TgtPDSearchDev.EndPage;
var
  I: Integer;
  LStrList: TgtWideStringList;
begin
  FGraphics := nil;
  ReleaseDC(0, FDC);
  if Assigned(FStateStack) then FreeAndNil(FStateStack);

  FFont := nil;
  FFontFamily := nil;
  FCurrentPath := nil;
  if Assigned(FCTM) then FreeAndNil(FCTM);


  LStrList := TgtWideStringList.Create;

  for I := 0 to FLines.Count - 1 do
  begin
    LStrList.AddObject(IntToStr(TgtLine(FLines.Objects[I]).StartY),
      FLines.Objects[I]);
  end;

  FLines.Clear;

  for I := 0 to LStrList.Count - 1 do
  begin
    if Assigned(LStrList.Objects[I]) then
      FLines.AddObject(TgtLine(LStrList.Objects[I]).Text, LStrList.Objects[I]);
  end;

  // Sort on X-Cord for each charecter

  // Sort on Y-Cord
  FLines.CustomSort(@SortByYCord);

  FreeAndNil(LStrList);
end;

procedure TgtPDSearchDev.EndString(State: TgtPDState);
begin
  FSingleString := False;
end;

procedure TgtPDSearchDev.QuickSort(AStrList: TStringList; L, R: Integer;
  SCompare: TStringListSortCompare);
begin

end;

procedure TgtPDSearchDev.RestoreState(State: TgtPDState);
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
      LMatrix := FGraphics.GetTransform;
      LMarray := LMatrix.GetElements();

      FCTM.SetValues(LMarray.m11, LMarray.m12, LMarray.m21, LMarray.m22,
        LMarray.dx, LMarray.dy);

    finally
      LMatrix := nil;
    end;
  end;
  UpdateAll(State);
end;

procedure TgtPDSearchDev.SaveState(State: TgtPDState);
var
  LState: Cardinal;
begin
  LState := FGraphics.Save;
  FStateStack.Add(Pointer(LState));
end;

procedure TgtPDSearchDev.StartPage(nPage: Integer; State: TgtPDState);
begin
  FDC := GetDC(0);
  FGraphics := TGPGraphics.Create(FDC);
  FStateStack := TList.Create;

  UpdateCTM(State, State.CTM);
end;

procedure TgtPDSearchDev.UpdateCTM(State: TgtPDState; CTM: TgtPDMatrix);
var
  LMatrix: IGPMatrix;
begin
  if not Assigned(FCTM) then
  begin
    FCTM := TgtPDMatrix.Create(CTM.M11, -CTM.M12, -CTM.M21, CTM.M22,
      CTM.Dx, CTM.Dy);
    LMatrix := TGPMatrix.Create;
    try
      LMatrix.SetElements(FCTM.M11, FCTM.M12, FCTM.M21, FCTM.M22, FCTM.Dx,
        State.PageHeight - FCTM.Dy);
      FGraphics.SetTransform(LMatrix);
    finally
      LMatrix:= nil;
    end;
  end
  else
  begin
    LMatrix := TGPMatrix.Create;
    try
      FCTM.SetValues(CTM.M11, -CTM.M12, -CTM.M21, CTM.M22,
        CTM.Dx, CTM.Dy);
      LMatrix.SetElements(FCTM.M11, FCTM.M12,
        FCTM.M21, FCTM.M22, FCTM.Dx,
        -FCTM.Dy);
      FGraphics.MultiplyTransform(LMatrix);
    finally
      LMatrix:= nil;
    end;
  end;
end;

procedure TgtPDSearchDev.UpdateFont(State: TgtPDState);
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
  begin
    FFontFamily := nil;
  end;
  if Assigned(FFont) then
  begin
    FFont := nil;
  end;
  if Assigned(FFontProcessor) then
  begin
    FFontProcessor := nil;
  end;

  LFontStream := State.Font.EmbeddedFontStream;
  if Assigned(LFontStream) then
  begin
    FFontProcessor := TgtFontProcessor.Create(LFontStream, Round(State.FontSize),
      Round(State.hDPI), Round(State.vDPI), ErrorCode);
    if ErrorCode <> Success then
    begin
{$IFDEF LOGERROR}
      Logger.LogError('Error parsing Font stream, Replacing with Arial');
{$ENDIF}
      if Assigned(FFontProcessor) then FreeAndNil(FFontProcessor);

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
    end;
  end
  else
  begin
    if State.Font.EmbeddedFontName <> '' then
      LAltName := State.Font.EmbeddedFontName
    else
      LAltName := State.Font.Name;

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
{$IFDEF LOGERROR}
      Logger.LogError('Font %s not found in system, Replacing with Arial Unicode MS',
        [LAltName]);
{$ENDIF}
      LName := 'Arial Unicode MS';
    end;

    FFontFamily := TGPFontFamily.Create(LName);
    if not FFontFamily.IsAvailable then
    begin
      FFontFamily := nil;
      FFont := TGPFont.Create(LName, State.FontSize,
        LFontStyle, UnitPoint);
    end
    else
      FFont := TGPFont.Create(FFontFamily, State.FontSize, LFontStyle,
        UnitPoint);
  end;
end;

{ TgtLine }

procedure TgtLine.AddFont(AState: TgtPDState);
var
  LFont: TFont;
  LRGB: TgtRGB;
  LPos: Integer;
  LFontName: string;
  LColor: TGPColor;
begin
  LFont := TFont.Create;
  with AState.Font do
  begin
    if (IsItalic) or (Pos('Italic', Name) > 0) then
      LFont.Style := LFont.Style + [fsItalic];
    if (IsBold) or (Pos('Bold', Name) > 0)then
      LFont.Style := LFont.Style + [fsBold];

    LFontName := Name;
    LPos := Pos('+', LFontName);
    if LPos > 0 then
      System.Delete(LFontName, 1, LPos);
    LFontName := StringReplace(LFontName, ',', '', [rfReplaceAll]);
    LFontName := StringReplace(LFontName, '-', '', [rfReplaceAll]);
    LFontName := StringReplace(LFontName, 'PS', '', []);
    LFontName := StringReplace(LFontName, 'MT', '', []);
    LFontName := StringReplace(LFontName, 'Bold', '', []);
    LFontName := StringReplace(LFontName, 'Italic', '', []);

    LFont.Name := LFontName;
    LFont.Size := Round(AState.GetTransformedFontSize);
    AState.GetFillRGB(LRGB);
    LRGB.R := Round(LRGB.R * (255 / 65536));
    LRGB.G := Round(LRGB.G * (255 / 65536));
    LRGB.B := Round(LRGB.B * (255 / 65536));
    LFont.Color := RGB(Byte(LRGB.R), Byte(LRGB.G), Byte(LRGB.B));
  end;
  FFonts.Add(LFont);
end;

procedure TgtLine.AddRect(aRect: TgtPDRect; Index: Integer);
begin
  FRects.Add(aRect);
end;

constructor TgtLine.Create;
begin
  FRects := TObjectList.Create(True);
  FFonts := TObjectList.Create(True);
end;

destructor TgtLine.Destroy;
begin
    if Assigned(FRects) then FRects.Free;
    if Assigned(FFonts) then FFonts.Free;
  inherited;
end;

function TgtLine.GetFont(Index: Integer): TFont;
begin
  Result := nil;
  if Assigned(FFonts) and (FFonts.Count > Index) then
  begin
    Result := TFont(FFonts.Items[Index]);
  end;
end;

function TgtLine.GetRect(Index: Integer): TgtPDRect;
begin
  Result := nil;
  if Assigned(FRects) and (FRects.Count > Index) then
  begin
    Result := TgtPDRect(FRects.Items[Index]);
  end;
end;

function lineGetCharRect(const aHandle: TgtLinesHandle; const LineIndex: Integer;
  const CharIndex: Integer; var aRect: TRect): ShortInt; export; stdcall;
begin
  if not Assigned(aHandle) or (LineIndex < 0) or (LineIndex > aHandle.Count) then
  begin
    Result := 0;
    Exit;
  end;

  if not Assigned(aHandle.Objects[LineIndex]) then
  begin
    Result := 0;
    Exit;
  end;
  if Assigned(TgtLine(aHandle.Objects[LineIndex]).Rects[CharIndex - 1]) then
  begin
    aRect.Left := Floor(TgtLine(aHandle.Objects[LineIndex]).Rects[CharIndex - 1].Left);
    aRect.Top := Floor(TgtLine(aHandle.Objects[LineIndex]).Rects[CharIndex - 1].Top);
    aRect.Right := Ceil(TgtLine(aHandle.Objects[LineIndex]).Rects[CharIndex - 1].Right);
    aRect.Bottom := Ceil(TgtLine(aHandle.Objects[LineIndex]).Rects[CharIndex - 1].Bottom);
    Result := 1;
  end
  else
  begin
    aRect.Left := 0;
    aRect.Top := 0;
    aRect.Right := 0;
    aRect.Bottom := 0;
    Result := 0;
  end;          
end;

function newLines: TgtLinesHandle; export; stdcall;
begin
  Result := TgtWideStringList.Create;
end;

function freeLines(var Handle: TgtLinesHandle): Shortint; export; stdcall;
var
  I: Integer;
begin
  Result := 1;
  try
    for I := 0 to Handle.Count - 1 do
    begin
      if Assigned(TgtLine(Handle.Objects[I])) then TgtLine(Handle.Objects[I]).Free;
    end;
    FreeAndNil(Handle);
  except
    Result := 0;
  end;
end;

function linesGetText(const Handle: TgtLinesHandle; Index: Integer): WideString;
  export; stdcall;
begin
  if not Assigned(Handle) or (Index < 0) or (Index > Handle.Count) then
  begin
    Result := '';
    Exit;
  end;

  Result := Handle.Strings[Index];
end;

function linesGetCount(const Handle: TgtLinesHandle): Integer; export; stdcall;
begin
  Result := 0;
  if Assigned(Handle) then
    Result := Handle.Count;
end;

function SortByYCord(List: TgtWideStringList; Index1, Index2: Integer): Integer;
begin
  Result := TgtLine(List.Objects[Index2]).StartY -
    TgtLine(List.Objects[Index1]).StartY;
end;


end.

