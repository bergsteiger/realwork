unit ddPDFReader;

{ $Id: ddPDFReader.pas,v 1.2 2013/04/11 16:46:28 lulin Exp $ }

// $Log: ddPDFReader.pas,v $
// Revision 1.2  2013/04/11 16:46:28  lulin
// - отлаживаем под XE3.
//
// Revision 1.1  2010/06/21 15:41:41  fireton
// - читаем PDF
//

interface
uses
 Windows,
 Classes,
 l3FieldSortRecList,
 k2Prim,
 k2Reader,
 FontProcessor,

 gtTypes,
 gtObject,
 gtWideStrings,
 gtPDFDoc,
 gtExProPDFDoc,
 gtExPDFDoc,

 PDExportDevice,
 PDIGDIPlus,
 PDMatrix,
 PDState;

type
 PddPDFChar = ^TddPDFChar;
 TddPDFChar = packed record
  rX: Integer;
  rY: Integer;
  rWidth : Integer;
  rHeight: Integer;
  rChar : WideChar;
 end;

 TddTextExportDevice = class(TgtPDExportDevice)
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

   f_CharList: Tl3FieldSortRecList;
   f_Generator: Ik2TagGenerator;

   //FLines: TgtWideStringList;

   //FPrevCode: TgtCharCode;
   //FPrevCharW: Double;

   procedure DrawCharacter(AGlyphPoints: TgtPointsList; AdvanceWidth, AdvanceHeight: Double;
     EvenOddFill: Boolean; ReverseFill: Boolean);
//    procedure SortXCord(String);
 public
   constructor Create(aGenerator: Ik2TagGenerator);
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
   function BeginType3Char(State: TgtPDState; X: Double; Y: Double;
     Dx: Double; Dy: Double; Code: TgtCharCode; Unicode: TgtUnicodes;
     Len: Integer): Boolean; override;

   property FontList: TStrings read FFontList write FFontList;
 end;

 TddPDFDoc = class(TgtPDFDocument)
 public
  procedure ExtractTextToGen(PageNo: Integer; aGenerator: Ik2TagGenerator); overload;

 end;

 TddPDFReader = class(Tk2CustomFileReader)
 public
  procedure Read; override;
 end;

implementation
uses
 SysUtils,

 gtPDFClasses,
 

 l3Interfaces,
 l3Base,
 l3_String,
 l3String,

 k2TagGen,
 k2Tags,

 evdTypes,

 gtCstPDFDoc,

 Graphics,
 PDSearchDev,
 PDRect,
 PDFont,
 PDCIDFont, l3ProtoPtrRecListPrim; // на врем€...

procedure TddPDFReader.Read;
var
 l_PDF : TddPDFDoc;
 l_Elements: TgtPDFPageElementList;
 l_Elem: TgtPDFTextElement;
 I, J: Integer;
 l_ParaText: Il3CString;
 l_DStr: AnsiString;
 l_Str: Tl3String;
 l_Txt: TgtWideStringList;
begin
 l_PDF := TddPDFDoc.Create(nil);
 try
  l_PDF.LoadFromStream(Filer.Stream);

  StartDefaultChild; // start of document
  try
   for J := 1 to l_PDF.PageCount do
   begin
    l_PDF.ExtractTextToGen(J, Self);
    {
    try
     for I := 0 to l_Txt.Count-1 do
     begin
      StartDefaultChild;
      try
       l_DStr := l_Txt[I];
       AddStringAtom(k2_tiText, l_DStr);
      finally
       Finish;
      end;
     end;
    finally
     FreeAndNil(l_Txt);
    end;}
   end;

   {
   for I := 1 to l_PDF.PageCount do
   begin
    l_Elements := l_PDF.GetPageElements(I, [etText], muPoints);
    try
     for J := 0 to l_Elements.Count - 1 do
     begin
      StartDefaultChild; // start para
      try
       l_Elem := TgtPDFTextElement(l_Elements.GetItem(J));
       l_DStr := Format('%s x:%d y:%d', [l_Elem.Text, l_Elem.Rect.Left, l_Elem.Rect.Top]);
       //l_Str := Tl3String.Make(l3PAnsiCharLen(l_DStr));
       AddStringAtom(k2_tiText, l_DStr);
      finally
       Finish; // end para
      end;
     end;
    finally
     FreeAndNil(l_Elements);
    end;
   end;
   }
  finally
   Finish; // end of document
  end;
 finally
  FreeAndNil(l_PDF);
 end;
end;

constructor TddTextExportDevice.Create(aGenerator: Ik2TagGenerator);
begin
//  FLines := AStringList;
  f_Generator := aGenerator;
  FUseShadedFill := True;
  FNeedNonText := True;
  FInterpretType3Chars := True;
  FUseDrawChar := True;
  FUseDrawForm := True;
  FUseTillingPatternFill := True;
  FUpsideDown := True;
  f_CharList := Tl3FieldSortRecList.Create(SizeOf(TddPDFChar), [SizeOf(Integer), SizeOf(Integer)], [2,1]);
  f_CharList.Sorted := True;
//  FStrList := TStringList.Create;
end;

destructor TddTextExportDevice.Destroy;
begin
  FreeAndNil(f_CharList);
  inherited;
end;

function TddTextExportDevice.BeginType3Char(State: TgtPDState; X, Y, Dx, Dy: Double;
  Code: TgtCharCode; Unicode: TgtUnicodes; Len: Integer): Boolean;
begin
  DrawChar(State, X, Y, Dx, Dy, Code, '');
end;

function TddTextExportDevice.CheckPageSlice(Page: TgtObject; hDPI, vDPI: Double;
  Rotate: Integer; UseMediaBox, Crop: Boolean; SliceX, SliceY, SliceW,
  SliceH: Double): Boolean;
begin
  Result := True;
end;

procedure TddTextExportDevice.DrawChar(State: TgtPDState; X, Y, Dx, Dy: Double;
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
  LStartY: Integer;
  LStartX: Integer;
  l_PArr: array of TGPPointF;
  LUnicodeTable: TToUnicodeTable;
  l_PDFChar: TddPDFChar;
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

  SetLength(l_PArr, 1);
  l_PArr[0] := MakePointF( X, Y );
  LMatrix.TransformPointsF(l_PArr);
  LStartY := Round(l_PArr[0].Y);
  LStartX := Round(l_PArr[0].X);
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

  FGraphics.Restore(LSave);

  //if Code <> 32 then // ≈сли это не пробел...
  begin
   with l_PDFChar do
   begin
    rX := LStartX;
    rY := LStartY;
    rWidth := LRect.Width;
    rHeight:= LRect.Height;
    rChar := WideChar(Code);
   end;

   I := f_CharList.Add(l_PDFChar);
  end;
end;

procedure TddTextExportDevice.DrawCharacter(AGlyphPoints: TgtPointsList;
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

procedure TddTextExportDevice.EndPage;
const
 al_UNdefined = 0;
 al_Left      = 1;
 al_Right     = 2;
 al_Center    = 3;
 al_Justified = 4;
var
 I: Integer;
 LStrList: TgtWideStringList;
 l_MinX: Integer;
 l_MaxX: Integer;
 l_LineLeft : Integer;
 l_LineRight: Integer;
 l_Ch: PddPDFChar;
 l_CurY: Double;
 l_WS : WideString;
 l_ParaText: WideString;
 l_PrevCharRight: Integer;
 l_PrevCharWidth: Integer;
 l_Threshold : Double;
 l_FirstLine : Double;
 l_ParaAlign: Byte;
 l_ParaWithFirstLine: Boolean;
 l_LastLineY : Double;
 l_LastLineH : Integer;
 l_LineH     : Integer;

 procedure FlushPara;
 begin
  if l_ParaText <> '' then
  begin
   f_Generator.StartDefaultChild;
   try
    case l_ParaAlign of
     al_Left  : f_Generator.AddIntegerAtom(k2_tiJustification, Ord(ev_itLeft));
     al_Right : f_Generator.AddIntegerAtom(k2_tiJustification, Ord(ev_itRight));
     al_Center: f_Generator.AddIntegerAtom(k2_tiJustification, Ord(ev_itCenter));
    end;
    if not l_ParaWithFirstLine then
     f_Generator.AddIntegerAtom(k2_tiFirstIndent, 0);
    f_Generator.AddStringAtom(k2_tiText, l_ParaText);
   finally
    f_Generator.Finish;
   end;
  end;
  l_ParaText := '';
  l_ParaWithFirstLine := False;
  l_ParaAlign := al_Undefined;
 end;

 procedure FlushLine(aForceFlushPara: Boolean = False);
 var
  l_LeftGap: Integer;
  l_RightGap: Integer;
  l_Align : Byte;
  l_IsFirstLine : Boolean;
 begin
  // ѕустые строки нам не нужны
  if Trim(l_WS) = '' then
  begin
   FlushPara;
   l_WS := '';
   Exit;
  end;
  
  // Ќе отбито ли пустой строкой?
  if l_LastLineH > 0 then
  begin
   if (l_CurY - l_LastLineY - l_LastLineH) > l_LastLineH div 2 then
   begin
    FlushPara; // выливаем предыдущий параграф 
    {
    f_Generator.StartDefaultChild; // и вставл€ем пустой
    f_Generator.Finish;
    }
   end;
  end;
  l_LastLineY := l_CurY;
  l_LastLineH := l_LineH;
  // сначала разберЄмс€, как выровнена эта строка, что мы собрали...
  l_LeftGap  := l_LineLeft - l_MinX;
  l_RightGap := l_MaxX - l_LineRight;
  l_IsFirstLine := False;
  if (l_LeftGap < l_Threshold) and (l_RightGap < l_Threshold) then
   l_Align := al_Justified
  else
   if Abs(l_LeftGap - l_RightGap) <= l_Threshold then
    l_Align := al_Center
   else
    if l_LeftGap < l_Threshold then
    begin
     if (l_ParaAlign = al_Justified) then
     begin
      l_Align := al_Justified; // это кусочек старого параграфа, а не начало нового
      aForceFlushPara := True;
     end
     else
      l_Align := al_Left;
    end
    else
     if (l_LeftGap < l_FirstLine) then
     begin
      l_IsFirstLine := True;
      if l_RightGap < l_Threshold then
       l_Align := al_Justified
      else
       l_Align := al_Left;
     end
     else
      if l_RightGap < l_Threshold then
       l_Align := al_Right
      else
       l_Align := al_Left;  // пока пусть так. потом надо будет дополн€ть слева пробелами...

  if (l_Align <> al_Justified) or
     ((l_Align = al_Justified) and (l_IsFirstLine or (l_ParaAlign <> al_Justified))) then
  begin
   FlushPara;
   //l_ParaAlign := l_Align;
   l_ParaWithFirstLine := l_IsFirstLine;
  end;

  if l_ParaAlign = al_Undefined then
   l_ParaAlign := l_Align;
  l_ParaText := l_ParaText + l_WS;

  if aForceFlushPara then
   FlushPara;
 end;

begin
  FGraphics := nil;
  ReleaseDC(0, FDC);
  if Assigned(FStateStack) then FreeAndNil(FStateStack);
  FFont := nil;
  FFontFamily := nil;
  FCurrentPath := nil;
  if Assigned(FCTM) then FreeAndNil(FCTM);

  // начинаем формировать текст из той кучи символов, что собрали
  // сначала определим границу области
  l_MinX := MaxInt;
  l_MaxX := 0;
  for I := 0 to f_CharList.Count - 1 do
  begin
   l_Ch := PddPDFChar(f_CharList.ItemSlot(I));
   if l_Ch.rX < l_MinX then
    l_MinX := l_Ch.rX;
   if l_Ch.rX + l_Ch.rWidth > l_MaxX then
    l_MaxX := l_Ch.rX + l_Ch.rWidth;
  end;
  l_Threshold := (l_MaxX - l_MinX) / 25;
  l_FirstLine := (l_MaxX - l_MinX) / 10;
  I := 0;
  l_CurY := -1;
  l_ParaText := '';
  l_ParaWithFirstLine := False;
  l_ParaAlign := al_Undefined;
  l_LineH := 0;
  l_LastLineH := 0;
  while I < f_CharList.Count do
  begin
   l_Ch := PddPDFChar(f_CharList.ItemSlot(I));
   if l_CurY <> l_Ch.rY then
   begin
    if l_CurY > -1 then
     FlushLine;
    l_LineLeft := MaxInt;
    l_LineRight := 0;
    l_CurY := l_Ch.rY;
    l_WS := '';
    l_PrevCharWidth := MaxInt;
    l_PrevCharRight := MaxInt;
    l_LineH := 0;
   end;
   if (l_Ch.rChar <> ' ') and (l_PrevCharWidth < MaxInt) then
   begin
    if (l_Ch.rX - l_PrevCharRight) > l_PrevCharWidth / 2 then
     l_WS := l_WS + ' ';
   end;
   l_WS := l_WS + l_Ch.rChar;

   if l_Ch.rChar = ' ' then
    l_PrevCharWidth := MaxInt
   else
    l_PrevCharWidth := l_Ch.rWidth;
   if l_LineLeft = MaxInt then // всЄ равно символы отсортированы по X => первый символ - самый левый
    l_LineLeft := l_Ch.rX;
   l_PrevCharRight := l_Ch.rX + l_Ch.rWidth;
   if l_LineRight < l_PrevCharRight then
    l_LineRight := l_PrevCharRight;
   if l_LineH < l_Ch.rHeight then
    l_LineH := l_Ch.rHeight;
   Inc(I);
  end;
  if l_WS <> '' then
   FlushLine(True);
end;

procedure TddTextExportDevice.RestoreState(State: TgtPDState);
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

procedure TddTextExportDevice.SaveState(State: TgtPDState);
var
  LState: Cardinal;
begin
  LState := FGraphics.Save;
  FStateStack.Add(Pointer(LState));
end;

procedure TddTextExportDevice.StartPage(nPage: Integer; State: TgtPDState);
begin
  FDC := GetDC(0);
  FGraphics := TGPGraphics.Create(FDC);
  FStateStack := TList.Create;
  f_CharList.Clear;
  UpdateCTM(State, State.CTM);
end;

procedure TddTextExportDevice.UpdateCTM(State: TgtPDState; CTM: TgtPDMatrix);
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

procedure TddTextExportDevice.UpdateFont(State: TgtPDState);
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

procedure TddPDFDoc.ExtractTextToGen(PageNo: Integer; aGenerator: Ik2TagGenerator);
var
  LTextExportDev: TddTextExportDevice;
  I: Integer;
begin
  if Assigned(FPDDoc) then
  begin
    LTextExportDev := TddTextExportDevice.Create(aGenerator);
    try
      if not Assigned(FPDDoc.FontList) then
        FPDDoc.FontList := GetFonts;
      LTextExportDev.FontList := FPDDoc.FontList;
      FPDDoc.DisplayPage(LTextExportDev, PageNo, 72, 72, 0, True, False,
        False, False);
    finally
      FreeAndNil(LTextExportDev);
    end;
  end;
end;


end.