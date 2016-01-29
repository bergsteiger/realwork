{ ********************************************************************* }
{                                                                       }
{                           Gnostice PDModel                            }
{                       Copyright (c) 2002-2008                         }
{          Gnostice Information Technologies Private Limited            }
{                      http://www.gnostice.com                          }
{                                                                       }
{ ********************************************************************* }

{$I ..\Utils\gtCompilerDefines.inc}
unit PD8bitFont;

interface

uses
  Classes, gtObject, PDBaseObject, PDElement, PDFont, gtTypes,
  PDRect, PDBuiltInFontMap, PDEncoding, PDTrueType, gtFont,
  PDIndirectRef, FontProcessor, PDDictionary, Graphics, Dialogs,
  PDCMapParser, Windows;

type

  TgtCharWidthArray = array[0..255] of Double;

  CodeToGIDMap = array of ShortInt;

  TgtPD8bitFont = class(TgtPDFont)
  private
    FEncoding: TgtEncodingArray;
    FHasEncoding: Boolean;
    FHasDifferences: Boolean;
    FUsesMacRomanEnc: Boolean;
    FWidths: TgtCharWidthArray;
    FCharWidths: TgtCharWidthArray;
    FStemV: Double;
    FUnderscorePosition: Double;
    FUnderscoreSize: Double;
    FFontEncoding: AnsiString;
    FFontProcObj: TgtFontProcessor;
    FFirstCharCode, FLastCharCode: Integer;
//    function TextSize(const Text: AnsiString; AFont: TFont): TSize; overload;
    function GetFontFlag(AFont: TFont): Integer;
    function GetEncoding(Index: Integer): AnsiString;
//    FMaxWidth: Integer;
//    FAvgWidth: Double;
  public
    constructor Create(AParentDoc: TgtObject; AParentElement: TgtPDElement;
      ABaseObject: TgtPDBaseObject; const ATag: AnsiString; AName: AnsiString;
      AFontType: TgtPDFontType); overload;

    constructor Create(AParentDoc: TgtObject; AParentElement: TgtPDElement;
      AObject: TgtFont); overload;
    destructor Destroy; override;
    procedure Update; override;
    procedure CreateFontDict; override;
    procedure EmbedFontFile(AFDDict: TgtPDDictionary; AStream: TStream);
    function GetNextChar(const aStr: WideString; Index: Integer; out Processed: Integer;
      out Code: TgtCharCode; out CharName: AnsiString; out Dx: Double;
      out Dy: Double; out Ox: Double; out Oy: Double): Integer; override;
    function GetCharWidth(ACharCode: TgtCharCode): Double; override;

    function GetCharName(Code: Integer): AnsiString;
    function IsMacRomanEnc: Boolean;
    function Clone: TgtPDFont;

    function GetPDFCharSpacing(AText: AnsiString; AFont: TFont): Extended;
    function GetHeight(AText: AnsiString; AFont: TFont): Double; overload;
    function GetWidth(AText: AnsiString; AFont: TFont): Double; overload;
    function GetWidth(Code: Cardinal): Double; overload;
    function GetCodeToGIDMap(Font: TPDTrueType): Integer;

    //property Encoding: TgtEncodingArray read FEncoding;
    property UnderscorePosition: Double read FUnderscorePosition;
    property UnderscoreSize: Double read FUnderscoreSize;
    property HasEncoding: Boolean read FHasEncoding;
    property HasDifferences: Boolean read FHasDifferences;
    property Encoding[Index: Integer]: AnsiString read GetEncoding;
  end;


implementation

uses
{$IFDEF DEBUG}
  gtLogger,
{$ENDIF}
  SysUtils, PDStdFontMap, gtConstants, PDName, gtMethods, PDDocument,
  PDInteger, PDStream, PDReal, PDArray, PDMatrix, PDType1, PDType1C,
  MemoryStream, PDAdobeGlyphList, PDTypes;

var
  ErrorCode: ErrorCodes;

const
  SubFontCount = 14;

  ActualFontNames: array[0..13] of AnsiString =
  ('Courier', 'Courier-Bold', 'Courier-BoldOblique', 'Courier-Oblique',
    'Helvetica', 'Helvetica-Bold', 'Helvetica-BoldOblique', 'Helvetica-Oblique',
    'Symbol', 'Times-Bold', 'Times-BoldItalic', 'Times-Italic',
    'Times-Roman', 'ZapfDingbats'
    );

  SubstituteFontNames: array[0..13] of AnsiString =
  ('Courier', 'Courier', 'Courier', 'Courier',
    'Arial', 'Arial', 'Arial', 'Arial',
    'Symbol', 'TimeNewRoman', 'TimeNewRoman', 'TimeNewRoman',
    'TimeNewRoman', 'ArialUnicodeMS'
    );

{ TgtPD8bitFont }

constructor TgtPD8bitFont.Create(AParentDoc: TgtObject;
  AParentElement: TgtPDElement; ABaseObject: TgtPDBaseObject;
  const ATag: AnsiString; AName: AnsiString; AFontType: TgtPDFontType);
var
  LTempName: AnsiString;
  I: Integer;
  LFound: Boolean;
  LIndex: Integer;
  LBuiltInFont: TgtBuiltInFont;
  LObj, LObj2, LObj3: TgtPDBaseObject;
  LBaseEnc: TgtEncodingArray;
  LBaseEncAssigned: Boolean;
  LBaseEncFrmFntFile: Boolean;
  LCode: Integer;
  LFirstChar, LLastChar: Integer;
  LMul: Double;
  LWid: Double;
  LStream: TStream;
  C1, C2: Integer;  
begin
  FIsChanged := False;
  FParentDoc := AParentDoc;
  FParentElement := AParentElement;
  FBaseObject := ABaseObject;

  FBaseFont := 'Arial Unicode MS';
  FTag := ATag;
  FName := AName;
  FFontType := AFontType;

  FIsBold := False;
  FIsItalic := False;

 // do font name substitution for various aliases of the Base 14 font
 // names
  if FName <> '' then
  begin
    LTempName := FName;
    LTempName := Trim(LTempName);
  end;

  // invariant: stdFontMap[a].altName <= name2 < stdFontMap[b].altName
  LFound := False;
  LIndex := 0;
  for I := 0 to StdFontCount - 1 do
  begin
    if (TgtStdFontMapTable[I].AlternateName = LTempName) or
      (TgtStdFontMapTable[I].ProperName = LTempName) then
    begin
      LFound := True;
      LIndex := I;
      Break;
    end;
  end;
  if LFound then
  begin
    LTempName := TgtStdFontMapTable[LIndex].ProperName;
    FName := TgtStdFontMapTable[LIndex].AlternateName;
    FBaseFont := TgtStdFontMapTable[LIndex].AlternateName;
  end;

  LBuiltInFont := nil;

  // is it a built-in font???
  if LTempName <> '' then
  begin
    for I := 0 to BUILTFONTCOUNT - 1 do
    begin
      if LTempName = BuiltInFonts[I] then
      begin
        LBuiltInFont := TgtBuiltInFont.MakeBuiltInFont(LTempName);
        Break;
      end;
    end;
  end;

  //default ascent/descent values
  if Assigned(LBuiltInFont) then
  begin
    FAscent := 0.001 * LBuiltInFont.Ascent;
    FDescent := 0.001 * LBuiltInFont.Descent;
    if not Assigned(FFontBox) then
      FFontBox := TgtPDRect.Create;
    FFontBox.SetValues(0.001 * LBuiltInFont.BBox.Left,
      0.001 * LBuiltInFont.BBox.Top,
      0.001 * LBuiltInFont.BBox.Right,
      0.001 * LBuiltInFont.BBox.Bottom);
  end
  else
  begin
    FAscent := 0.95;
    FDescent := -0.35;
    if not Assigned(FFontBox) then
      FFontBox := TgtPDRect.Create(0, 0, 0, 0);
  end;

  //get info frm font descriptor
  ReadFontDescriptor(BaseObject);

  if (FEmbeddedFontName <> '') and not Assigned(FEmbededFontIndRef) and
    (FFontType = TrueType) then
  begin
    LTempName := FEmbeddedFontName;
    LTempName := StringReplace(LTempName, ',', '', [rfReplaceAll]);
    LTempName := StringReplace(LTempName, '+', '', [rfReplaceAll]);
    LTempName := StringReplace(LTempName, '-', '', [rfReplaceAll]);
    LTempName := StringReplace(LTempName, 'PS', '', []);
    LTempName := StringReplace(LTempName, 'MT', '', []);

    if Pos('Bold', LTempName) > 0 then
    begin
      FIsBold := True;
      LTempName := StringReplace(LTempName, 'Bold', '', [rfIgnoreCase]);
    end;

    if Pos('Italic', LTempName) > 0 then
    begin
      FIsItalic := True;
      LTempName := StringReplace(LTempName, 'Italic', '', [rfIgnoreCase]);
    end;

    for I := 0 to SubFontCount - 1 do
    begin
      if LTempName = ActualFontNames[I] then
        FEmbeddedFontName := SubstituteFontNames[I];
    end;
  end;

 // for non-embedded fonts, don't trust the ascent/descent/bbox
 // values from the font descriptor
  if Assigned(LBuiltInFont) and (Assigned(FEmbededFontIndRef)) and
    (FEmbededFontIndRef.ObjNumber <> $FFFFFFFF) then
  begin
    FAscent := 0.001 * LBuiltInFont.Ascent;
    FDescent := 0.001 * LBuiltInFont.Descent;
    FFontBox.SetValues(0.001 * LBuiltInFont.BBox.Left,
      0.001 * LBuiltInFont.BBox.Top,
      0.001 * LBuiltInFont.BBox.Right,
      0.001 * LBuiltInFont.BBox.Bottom);
  end;

  // look for an external font file
  FindExtFontFile;

  // get font matrix
  if not Assigned(LBuiltInFont) then
  begin
    if assigned(FFontMatrix) then FFontMatrix.Free;
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_FONTMATRIX);
    if Assigned(LObj) and LObj.IsArray then
      FFontMatrix := TgtPDMatrix.Create(LObj)
    else
      FFontMatrix := TgtPDMatrix.Create(1, 0, 0, 1, 0, 0);
  end;

 //----- build the font encoding -----

 // Encodings start with a base encoding, which can come from
 // (in order of priority):
 //   1. FontDict.Encoding or FontDict.Encoding.BaseEncoding
 //        - MacRoman / MacExpert / WinAnsi / Standard
 //   2. embedded or external font file
 //   3. default:
 //        - builtin --> builtin encoding
 //        - TrueType --> WinAnsiEncoding
 //        - others --> StandardEncoding
 // and then add a list of differences (if any) from
 // FontDict.Encoding.Differences.

 // check FontDict for base encoding
  if Assigned(LBuiltInFont) then
  begin
    FEncoding := LBuiltInFont.FDefaultBaseEnc;
    FEncodingName := LBuiltInFont.EncodingName;
  end;

//  begin
  FHasEncoding := False;
  FHasDifferences := False;
  FUsesMacRomanEnc := False;
  LBaseEncAssigned := False;
  LBaseEncFrmFntFile := False;
  if (Pos('ZapfDingbats', FName) > 0)then
  begin
    FHasEncoding := True;
    LBaseEnc := ZapfDingbatsEncoding;
    FEncodingName := TgtPDFFontEncoding[2];
    LBaseEncAssigned := True;
  end;


    LObj := TgtPDDictionary(BaseObject).LookUp(PDF_ENCODING);
    if Assigned(LObj) then
    begin
      if LObj.IsDict then
      begin
        LObj2 := TgtPDDictionary(LObj).LookUp(PDF_BASEENCODING);
        if Assigned(LObj2) then
        begin
          if LObj2.IsName(PDF_MACROMANENCODING) then
          begin
            FHasEncoding := True;
            FUsesMacRomanEnc := True;
            LBaseEnc := MacRomanEncoding;
            FEncodingName := TgtPDFFontEncoding[1];
            LBaseEncAssigned := True;
          end
          else if LObj2.IsName(PDF_MACEXPERTENCODING) then
          begin
            FHasEncoding := True;
            LBaseEnc := MacExpertEncoding;
            FEncodingName := TgtPDFFontEncoding[4];
            LBaseEncAssigned := True;
          end
          else if LObj2.IsName(PDF_WINANSIENCODING) then
          begin
            FHasEncoding := True;
            LBaseEnc := WinAnsiEncoding;
            FEncodingName := TgtPDFFontEncoding[2];
            LBaseEncAssigned := True;
          end;
        end;
      end
      else if LObj.IsName(PDF_MACROMANENCODING) then
      begin
        FHasEncoding := True;
        FUsesMacRomanEnc := True;
        LBaseEnc := MacRomanEncoding;
        FEncodingName := TgtPDFFontEncoding[1];
        LBaseEncAssigned := True;
      end
      else if LObj.IsName(PDF_MACEXPERTENCODING) then
      begin
        FHasEncoding := True;
        LBaseEnc := MacExpertEncoding;
        FEncodingName := TgtPDFFontEncoding[4];
        LBaseEncAssigned := True;
      end
      else if LObj.IsName(PDF_WINANSIENCODING) then
      begin
        FHasEncoding := True;
        LBaseEnc := WinAnsiEncoding;
        FEncodingName := TgtPDFFontEncoding[2];
        LBaseEncAssigned := True;
      end;
    end;


    // check embedded or external font file for base encoding
    // (only for Type 1 fonts - trying to get an encoding out of a
    // TrueType font is a losing proposition)
//    LFontType1 := nil;
//    LFontType1C := nil;
//
//    if (FFontType = Type1) and (Assigned(FEmbededFontIndRef)) and
//      (FEmbededFontIndRef.ObjNumber <> $FFFFFFFF) then
//    begin
//      if FExtFontName <> '' then
//        LFontType1 := TPDType1.Create(ExtFontStream, False)
//      else
//          LFontType1 := TPDType1.Create(EmbeddedFontStream, False);
//      if Assigned(LFontType1) then
//      begin
//        if LFontType1.Name <> '' then
//        begin
//          FEmbeddedFontName := LFontType1.Name;
//        end;
//        if LBaseEncAssigned <> True then
//        begin
//          LBaseEnc := LFontType1.Encoding;
//          LBaseEncAssigned := True;
//          LBaseEncFrmFntFile := True;
//        end;
//      end;
//    end
//    else if (FFontType = Type1C) and ((FExtFontName <> '') or
//      ((Assigned(FEmbededFontIndRef)) and (FEmbededFontIndRef.ObjNumber <> $FFFFFFFF))) then
//    begin
//      if FExtFontName <> '' then
//        LFontType1C := TPDType1C.Create(ExtFontStream)
//      else
//        LFontType1C := TPDType1C.Create(EmbeddedFontStream);
//      if Assigned(LFontType1C) then
//      begin
//        FEmbeddedFontName := LFontType1C.Name;
//      end;
//      if LBaseEncAssigned = False then
//      begin
//        LBaseEnc := LFontType1C.Encoding;
//        LBaseEncAssigned := True;
//        LBaseEncFrmFntFile := True;
//      end;
//    end;

    // get default base encoding
  if LBaseEncAssigned = False then
  begin
    if Assigned(LBuiltInFont) and not Assigned(FEmbededFontIndRef) then
    begin
      LBaseEnc := LBuiltInFont.FDefaultBaseEnc;
      FEncodingName := LBuiltInFont.EncodingName;
      FHasEncoding := True;
    end
    else if FFontType = TrueType then
    begin
      LBaseEnc := WinAnsiEncoding;
      FEncodingName := TgtPDFFontEncoding[2];
    end
    else
    begin
      if not IsSymbolic then
      begin
        LBaseEnc := StandardEncoding;
        FEncodingName := TgtPDFFontEncoding[0];
      end;
    end;
  end;

    // copy the base encoding
  FEncoding := LBaseEnc;
//    // some Type 1C font files have empty encodings, which can break the
//    // T1C->T1 conversion (since the 'seac' operator depends on having
//    // the accents in the encoding), so we fill in any gaps from
//    // StandardEncoding
//  if (FFontType = Type1C) and ((FExtFontName <> '') or (Assigned(FEmbededFontIndRef) and
//    (FEmbededFontIndRef.ObjNumber <> $FFFFFFFF))) and LBaseEncFrmFntFile then
//  begin
//    for I := 0 to 256 - 1 do
//    begin
//      if FEncoding[i] = '' then
//        FEncoding[I] := StandardEncoding[I];
//    end;
//  end;

  if Assigned(LObj) and LObj.IsDict then
  begin
    LObj2 := TgtPDDictionary(LObj).LookUp(PDF_DIFFERENCES);
    if Assigned(LObj2) and LObj2.IsArray then
    begin
      FHasEncoding := True;
      FHasDifferences := True;
      FEncodingName := TgtPDFFontEncoding[5];
      LCode := 0;
      for I := 0 to TgtPDArray(LObj2).GetLength - 1 do
      begin
        LObj3 := TgtPDArray(LObj2).Get(I);
        if Assigned(LObj3) and LObj3.IsInteger then
          LCode := TgtPDInteger(LObj3).Value
        else if Assigned(LObj3) and LObj3.IsName then
        begin
          if (LCode >= 0) and (LCode < 256) then
          begin
            FEncoding[LCode] := TgtPDName(LObj3).Value;
          end;
          Inc(LCode);
        end
        else
        begin
{$IFDEF DEBUG}
          Logger.LogError('Wrong type in font encoding resource differences (%s)', [TgtPDName(LObj3).ClassName]);
{$ENDIF}
        end;
      end;
    end;
//    end;

//    if Assigned(LFontType1) then LFontType1.Free;
//    if Assigned(LFontType1C) then LFontType1C.Free;
  end;

  // ------------get the character widths ------
  //initialize all widths
  for LCode := 0 to 256 - 1 do
  begin
    FWidths[LCode] := FMissingWidth * 0.001;
  end;

  //use widths from font dict, if present
  LFirstChar := 0;
  LObj := TgtPDDictionary(BaseObject).LookUp(PDF_FIRSTCHAR);
  if Assigned(LObj) and LObj.IsInteger then
    LFirstChar := TgtPDInteger(LObj).Value;
  if (LFirstChar < 0) or (LFirstChar > 255) then
    LFirstChar := 0;

  LLastChar := 0;
  LObj := TgtPDDictionary(BaseObject).LookUp(PDF_LASTCHAR);
  if Assigned(LObj) and LObj.IsInteger then
    LLastChar := TgtPDInteger(LObj).Value;
  if (LLastChar < 0) or (LLastChar > 255) then
    LLastChar := 255;

  if FFontType = Type3 then
    LMul := FFontMatrix.M11
  else
    LMul := 0.001;

  LObj := TgtPDDictionary(BaseObject).LookUp(PDF_WIDTHS);
  if Assigned(LObj) and LObj.IsArray then
  begin
    FFlags := Flags or 1 shl 0;
    if TgtPDArray(LObj).GetLength < (LLastChar - LFirstChar + 1) then
    begin
      LLastChar := LFirstChar + TgtPDArray(LObj).GetLength - 1;
    end;
    for LCode := LFirstChar to LLastChar do
    begin
      LObj2 := TgtPDArray(LObj).Get(LCode - LFirstChar);
      if Assigned(LObj2) and LObj2.IsNumber then
      begin
        if LObj2.IsInteger then
          FWidths[LCode] := TgtPDInteger(LObj2).Value * LMul
        else
          FWidths[LCode] := TgtPDReal(LObj2).Value * LMul;
        if FWidths[LCode] <> FWidths[LFirstChar] then
          FFlags := Flags and (not (1 shl 0));
      end;
    end;
  end
  // use widths from built in fonts
  else if Assigned(LBuiltInFont) then
  begin
    LWid := LBuiltInFont.GetWidth('space');
    FWidths[32] := 0.001 * LWid;

    for LCode := 0 to 256 - 1 do
    begin
      LWid := LBuiltInFont.GetWidth(FEncoding[LCode]);
      FWidths[LCode] := 0.001 * LWid;
    end;
  end
  // couldn't find widths -- use defaults
  else
  begin
    if IsFixedWidth then
      I := 0
    else if IsSerif then
      I := 8
    else
      I := 4;
    if IsBold then
      I := I + 2;
    if IsItalic then
      I := I + 1;

    if I = 0 then
      LBuiltInFont := TgtBuiltInFont.MakeBuiltInFont(BuiltInFonts[0])
    else if I = 1 then
      LBuiltInFont := TgtBuiltInFont.MakeBuiltInFont(BuiltInFonts[3])
    else if I = 2 then
      LBuiltInFont := TgtBuiltInFont.MakeBuiltInFont(BuiltInFonts[1])
    else if I = 3 then
      LBuiltInFont := TgtBuiltInFont.MakeBuiltInFont(BuiltInFonts[2])
    else if I = 4 then
      LBuiltInFont := TgtBuiltInFont.MakeBuiltInFont(BuiltInFonts[4])
    else if I = 5 then
      LBuiltInFont := TgtBuiltInFont.MakeBuiltInFont(BuiltInFonts[7])
    else if I = 6 then
      LBuiltInFont := TgtBuiltInFont.MakeBuiltInFont(BuiltInFonts[5])
    else if I = 7 then
      LBuiltInFont := TgtBuiltInFont.MakeBuiltInFont(BuiltInFonts[6])
    else if I = 8 then
      LBuiltInFont := TgtBuiltInFont.MakeBuiltInFont(BuiltInFonts[12])
    else if I = 9 then
      LBuiltInFont := TgtBuiltInFont.MakeBuiltInFont(BuiltInFonts[11])
    else if I = 10 then
      LBuiltInFont := TgtBuiltInFont.MakeBuiltInFont(BuiltInFonts[9])
    else if I = 11 then
      LBuiltInFont := TgtBuiltInFont.MakeBuiltInFont(BuiltInFonts[10]);

    for LCode := 0 to 256 - 1 do
    begin
      LWid := LBuiltInFont.GetWidth(FEncoding[LCode]);
      FWidths[LCode] := 0.001 * LWid;
    end;
  end;

  LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_TOUNICODE);
  if Assigned(LObj) and LObj.IsStream then
  begin
    LStream := TMemoryStream.Create;
    TgtPDStream(LObj).Reset;
    C1 := TgtPDStream(LObj).GetChar;
    while C1 <> ENDOFFILE do
    begin
      LStream.Write(C1, 1);
      C1 := TgtPDStream(LObj).GetChar;
    end;
    LStream.Position := 0;
    FToUnicode := TToUnicodeTable.Create(LStream);
    LStream.Free;
  end;


  if Assigned(LBuiltInFont) then
    LBuiltInFont.Free;
end;

function TgtPD8bitFont.Clone: TgtPDFont;
begin
  Result := TgtPD8bitFont.Create(FParentDoc, FParentElement, FBaseObject, Tag,
    Name, FontType);
end;

constructor TgtPD8bitFont.Create(AParentDoc: TgtObject;
  AParentElement: TgtPDElement; AObject: TgtFont);
var
  LI: Integer;
  LWid: Double;
  LFont: TFont;
  LStream: TMemoryStream;
  LBuiltInFont: TgtBuiltInFont;
begin
  LBuiltInFont := nil;
  LFont := TFont.Create;
  LFont.Name := AObject.Name;
  LFont.Size := AObject.Size;
  LFont.Style := AObject.Style;
  LFont.Color := AObject.Color;

  FParentDoc := AParentDoc;
  FParentElement := AParentElement;
  FIsChanged := False;

  FFontType := TrueType;

  if ((AObject.FileName <> '') and (FontType = TrueType)) then
  begin
    LStream := TMemoryStream.Create;
    LStream.LoadFromFile(AObject.FileName);
    EmbeddedFontStream := LStream;
    FreeAndNil(LStream);
  end
  else if (Assigned(AObject.Stream) and (FontType = TrueType)) then
  begin
    EmbeddedFontStream := AObject.Stream;
  end;

  case AObject.Encoding of
    gtFont.feWinAnsiEncoding: FFontEncoding := PDF_WINANSIENCODING;
    gtFont.feMacRomanEncoding: FFontEncoding := PDF_MACROMANENCODING;
    gtFont.feMacExpertEncoding: FFontEncoding := PDF_MACEXPERTENCODING;
    gtFont.feStandardEncoding: FFontEncoding := PDF_STANDARDENCODING;
    gtFont.fePDFDocEncoding: FFontEncoding := PDF_PDFDOCENCODING;
  end;

  // is it a built-in font???
  if LFont.Name <> '' then
  begin
    for LI := 0 to BUILTFONTCOUNT - 1 do
    begin
      if LFont.Name = BuiltInFonts[LI] then
      begin
        LBuiltInFont := TgtBuiltInFont.MakeBuiltInFont(LFont.Name);
        Break;
      end;
    end;
  end;

  if Assigned(LBuiltInFont) then
  begin
    try
      FName := LBuiltInFont.Name;
      FFlags := GetFontFlag(LFont);
      FEncoding := LBuiltInFont.FDefaultBaseEnc;
      if not Assigned(FFontBox) then
        FFontBox := TgtPDRect.Create(0, 0, 0, 0);
      FFontBox.Left := LBuiltInFont.BBox.Left;
      FFontBox.Top := LBuiltInFont.BBox.Top;
      FFontBox.Right := LBuiltInFont.BBox.Right;
      FFontBox.Bottom := LBuiltInFont.BBox.Bottom;
      FAscent := LBuiltInFont.Ascent;
      FDescent := LBuiltInFont.Descent;
      FFirstCharCode := 32;
      FLastCharCode := 255;
      for LI := 0 to 255 do
      begin
        LWid := LBuiltInFont.GetWidth(FEncoding[LI]);
        FCharWidths[LI] := LWid;
      end;
    finally
      FreeAndNil(LBuiltInFont);
      FreeAndNil(LFont);
    end;
  end
  else if (not Assigned(LBuiltInFont)) then
  begin
    //Fetch the required info from TgtFontProcessor for adding Font descriptor dict.
    FFontProcObj := TgtFontProcessor.Create(LFont, ErrorCode);
    try

      if (ErrorCode = Success) then
      begin
        FName := FFontProcObj.PostscriptName;
        FFlags := FFontProcObj.Flag;
        if not Assigned(FFontBox) then
          FFontBox := TgtPDRect.Create(0, 0, 0, 0);
        FFontBox.Left := FFontProcObj.GlobalBBox.Left;
        FFontBox.Top := FFontProcObj.GlobalBBox.Top;
        FFontBox.Right := FFontProcObj.GlobalBBox.Right;
        FFontBox.Bottom := FFontProcObj.GlobalBBox.Bottom;
        FItalicAngle := FFontProcObj.ItalicAngle;
        FAscent := FFontProcObj.Ascent;
        FDescent := FFontProcObj.Descent;
        FStemv := FFontProcObj.StemV;
        FUnderscorePosition := FFontProcObj.UnderscorePosition;
        FUnderscoreSize := FFontProcObj.UnderscoreSize;
        FFirstCharCode := FFontProcObj.FirstCharCode;
        FLastCharCode := FFontProcObj.LastCharCode;
        FMissingWidth := FFontProcObj.MaxWidth;
        for LI := 0 to 255 do
        begin
          FCharWidths[LI] := FFontProcObj.GlyphWidths[LI];
        end;
      end
      else
      begin
        {$IFDEF DEBUG}
        Logger.LogError('Not a Valid Font');
        {$ENDIF}
        Exit;
      end;
    finally
      FreeAndNil(LFont);
    end;
  end;
end;

procedure TgtPD8bitFont.CreateFontDict;
var
  LDict: TgtPDDictionary;
  LArray: TgtPDArray;
  LFontType: AnsiString;
  LI: Integer;
begin
  if not Assigned(BaseObject) then
  begin
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber :=
      TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber + 1;
    //create font descriptor dictionary
    LDict := TgtPDDictionary.Create(
      TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber, 0,
      TgtPDDocument(FParentDoc).BaseDoc);
    TgtPDDocument(FParentDoc).BaseDoc.AddToCollection(LDict);
    LDict.Add(PDF_TYPE, TgtPDName.Create(PDF_FONTDESCRIPTOR));
    LDict.Add(PDF_FONTNAME, TgtPDName.Create(FName));
    LDict.Add(PDF_FLAGS, TgtPDInteger.Create(FFlags));
    //Create an array object for storing BBox values.
    LArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
    LArray.Add(TgtPDReal.Create(FFontBox.Left));
    LArray.Add(TgtPDReal.Create(FFontBox.Top));
    LArray.Add(TgtPDReal.Create(FFontBox.Right));
    LArray.Add(TgtPDReal.Create(FFontBox.Bottom));
    LDict.Add(PDF_FONTBBOX, LArray);
    LDict.Add(PDF_ITALICANGLE, TgtPDInteger.Create(FItalicAngle));
    LDict.Add(PDF_ASCENT, TgtPDReal.Create(FAscent));
    LDict.Add(PDF_DESCENT, TgtPDReal.Create(FDescent));
    LDict.Add(PDF_STEMV, TgtPDReal.Create(FStemV));
//    LDict.Add(PDF_AVGWIDTH, TgtPDReal.Create(FAvgWidth));
//    LDict.Add(PDF_MAXWIDTH, TgtPDInteger.Create(FMaxWidth));
    LDict.Add(PDF_MISSINGWIDTH, TgtPDInteger.Create(FMissingWidth));

    if Assigned(EmbeddedFontStream) then
    begin
      EmbedFontFile(LDict, EmbeddedFontStream);
    end;

    //Create Font dictionary
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber :=
      TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber + 1;
    FBaseObject := TgtPDDictionary.Create(
      TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber, 0,
      TgtPDDocument(FParentDoc).BaseDoc);
    TgtPDDocument(FParentDoc).BaseDoc.AddToCollection(FBaseObject);
    TgtPDDictionary(FBaseObject).Add(PDF_TYPE, TgtPDName.Create(PDF_FONT));
    case FontType of
      //UnknowType: LFontType := ;
      Type1: LFontType := PDF_TYPE1;
      Type1C: LFontType := PDF_TYPE1C;
      Type1COT: LFontType := PDF_TYPE1COT;
      Type3: LFontType := PDF_TYPE3;
      TrueType: LFontType := PDF_TRUETYPE;
      TrueTypeOT: LFontType := PDF_TRUETYPEOT;
      CIDType0: LFontType := PDF_CIDTYPE0;
      CIDType0C: LFontType := PDF_CIDTYPE0C;
      //CIDType0COT: LFontType := PDF_;
      CIDType2: LFontType := PDF_CIDTYPE2;
      //CIDType2OT: ;
    end;
    TgtPDDictionary(FBaseObject).Add(PDF_SUBTYPE, TgtPDName.Create(LFontType));
    TgtPDDictionary(FBaseObject).Add(PDF_NAME, TgtPDName.Create(Tag));
    TgtPDDictionary(FBaseObject).Add(PDF_BASEFONT, TgtPDName.Create(FName));
    TgtPDDictionary(FBaseObject).Add(PDF_ENCODING, TgtPDName.Create(FFontEncoding));
    TgtPDDictionary(FBaseObject).Add(
      PDF_FIRSTCHAR, TgtPDInteger.Create(FFirstCharCode));
    TgtPDDictionary(FBaseObject).Add(
      PDF_LASTCHAR, TgtPDInteger.Create(FLastCharCode));
    //Create an array object
    LArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
    for LI := FFirstCharCode to FLastCharCode do
    begin
      LArray.Add(TgtPDReal.Create((FCharWidths[LI])));
    end;
    TgtPDDictionary(FBaseObject).Add(PDF_WIDTHS, LArray);
    TgtPDDictionary(FBaseObject).Add(PDF_FONTDESCRIPTOR,
      TgtPDIndirectRef.Create(LDict.ObjNumber, LDict.GenNumber));
  end;
end;

destructor TgtPD8bitFont.Destroy;
begin
  if Assigned(FFontProcObj) then
    FreeAndNil(FFontProcObj);
  inherited;
end;

procedure TgtPD8bitFont.EmbedFontFile(AFDDict: TgtPDDictionary; AStream: TStream);
var
  LMemStream: TMemoryStream;
  LgtMemStream: TgtMemoryStream;
  LPDStreamObj: TgtPDStream;
  LFontFileDict: TgtPDDictionary;
begin
  //For creating fontfile dictionary, for full embedding
  AStream.Position := 0;
  LMemStream := TMemoryStream.Create;
  LMemStream.LoadFromStream(AStream);
  //create a tgtmemorystream
  LgtMemStream := TgtMemoryStream.Create(LMemStream, 0, 0, False);
  LgtMemStream.Reset;
  //create a dictionary
  LFontFileDict := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);
  LFontFileDict.Add(PDF_LENGTH1, TgtPDInteger.Create(LgtMemStream.GetSize));
  LFontFileDict.Add(PDF_LENGTH, TgtPDInteger.Create(LgtMemStream.GetSize));
  //increment the last obj no.
  TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber :=
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber + 1;
  //create a pdstream with tgtmemstream and dict
  LPDStreamObj := TgtPDStream.Create(LgtMemStream, LFontFileDict,
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber, 0);
  //add to collection
  TgtPDDocument(FParentDoc).BaseDoc.AddToCollection(LPDStreamObj);
  //add the indirect ref of stream obj to font descriptor dict
  AFDDict.Add(PDF_FONTFILE2, TgtPDIndirectRef.Create(LPDStreamObj.ObjNumber,
    LPDStreamObj.GenNumber));
  EmbeddedFontStream := AStream;
end;

function TgtPD8bitFont.GetCharName(Code: Integer): AnsiString;
begin

end;

function TgtPD8bitFont.GetCharWidth(ACharCode: TgtCharCode): Double;
begin
  Result := FWidths[ACharCode];
end;

function TgtPD8bitFont.GetCodeToGIDMap(Font: TPDTrueType): Integer;
begin
  Result := 0;
end;

function TgtPD8bitFont.GetEncoding(Index: Integer): AnsiString;
begin
  Result := FEncoding[Index];
end;

function TgtPD8bitFont.GetFontFlag(AFont: TFont): Integer;
var
	LDC: HDC;
	LSaveFont: HFont;
	LTM: TTextMetric;
//	LOTM: TOutlineTextmetric;
	LSaveMM: Integer;
  LogF: Cardinal;

begin
  Result := 0;

  LDC := GetDC(0);
  LSaveMM := GetMapMode(LDC);
  SetMapMode(LDC, MM_TEXT);

  if AFont.Name = 'Symbol' then
  begin
    LogF := CreateFont(AFont.Height, TextSize('W', AFont).cx, 0, 0, FW_REGULAR,
      0, 0, 0, SYMBOL_CHARSET, OUT_TT_ONLY_PRECIS, CLIP_DEFAULT_PRECIS,
      DEFAULT_QUALITY, FF_DONTCARE, PChar('Symbol'));
    LSaveFont := SelectObject(LDC, LogF);
  end
  else
    LSaveFont := SelectObject(LDC, AFont.Handle);

	GetTextMetrics(LDC, LTM);

  with LTM do
  begin
    (*
      Check Font Pitch.
      If bit TMPF_FIXED_PITCH is set the font is NOT fixed-pitch,
        the values are reversed. Refer Win API help on TextMetric for details.
    *)
    if ((tmPitchAndFamily and TMPF_FIXED_PITCH) = 0) then
      Result := Result + 1;
    (* Check Font Family. *)
    if ((tmPitchAndFamily and FF_ROMAN) <> 0) then
      Result := Result + 2;
    if (tmCharSet = SYMBOL_CHARSET) then
      Result := Result + 4;
    if ((tmPitchAndFamily and FF_SCRIPT) <> 0) then
      Result := Result + 8;
    if (tmCharSet <> SYMBOL_CHARSET) then
      Result := Result + 32;
    if (tmItalic <> 0) then
      Result := Result + 64;
  end;

  SetMapMode(LDC, LSaveMM);
  SelectObject(LDC, LSaveFont);
  ReleaseDC(0, LDC);
end;

function TgtPD8bitFont.GetHeight(AText: AnsiString; AFont: TFont): Double;
begin
  if (Assigned(FFontProcObj) and (ErrorCode = Success)) then
  begin
    Result := FFontProcObj.GetTextHeight(AText);
  end
  else
  begin
    Result := (TextSize(AText, AFont).cy) * (72/96);
  end;
end;

function TgtPD8bitFont.GetNextChar(const aStr: WideString; Index: Integer;
  out Processed: Integer; out Code: TgtCharCode; out CharName: AnsiString;
  out Dx, Dy, Ox, Oy: Double): Integer;
var
  LStr: AnsiString;
begin
  LStr := AnsiString(aStr);
  Code := 0;
  CharName := '';
  if (FFontType = Type1) or (FFontType = Type1C) or (FFontType = Type1COT) then
  begin
    if IsSymbolic and (FEncoding[Integer(LStr[Index])] = '') then
      Code := Integer(LStr[Index])
    else
      CharName := FEncoding[Integer(LStr[Index])];
    if Code = 0 then
    begin
      if (Pos('Symbol', FName) > 0) and not FHasDifferences then Code := Integer(LStr[Index])
      else Code := GetScalarCode(FEncoding[Integer(LStr[Index])],
        (Pos('ZapfDingbats', FName) > 0));
      if (Pos('Symbol', FName) > 0) and not Assigned(FEmbededFontIndRef) then
      begin
        Code := GetSymbolCode(Code);
      end;
    end;
  end
  {
  else if (FFontType = TrueType) and FHasEncoding and FHasDifferences then
     Code := GetScalarCode(FEncoding[Integer(LStr[Index])],
        (Pos('ZapfDingbats', FName) > 0))
  }
  else if (not FHasEncoding or IsSymbolic) or (Pos('Symbol', FName) > 0) then
    Code := Integer(LStr[Index])
  else if FEmbeddingType <> etNone then
  	Code := Integer(LStr[Index])
  else
  begin
      Code := GetScalarCode(FEncoding[Integer(LStr[Index])],
        (Pos('ZapfDingbats', FName) > 0));
  end ;

  Dx := FWidths[Integer(LStr[Index])];
  Dy := 0;
  Ox := 0;
  Oy := 0;
  Processed := 1;
  Result := 1;
end;

function TgtPD8bitFont.GetPDFCharSpacing(AText: AnsiString; AFont: TFont): Extended;
var
  I: Integer;
begin
  Result := 0;
  if AText = '' then Exit;
  for I := 1 to Length(AText) do
    Result := Result + FCharWidths[Ord(AText[I])];
  Result := Result * AFont.Size / 1000;
  Result := GetWidth(AText, AFont) - Result;
  if (Abs(Result) < 0.0001) then
  begin
    Result := 0.0;
    Exit;
  end;
  if Result = 0 then Exit;
  Result := Result / Length(AText);
end;

function TgtPD8bitFont.GetWidth(Code: Cardinal): Double;
begin
  Result := FWidths[Code];
end;

function TgtPD8bitFont.GetWidth(AText: AnsiString; AFont: TFont): Double;
begin
  if (Assigned(FFontProcObj) and (ErrorCode = Success)) then
  begin
    Result := FFontProcObj.GetTextWidth(AText);
  end
  else
  begin
    Result := (TextSize(AText, AFont).cx) * (72/96);
  end;
end;

function TgtPD8bitFont.IsMacRomanEnc: Boolean;
begin
  Result := FUsesMacRomanEnc;
end;

//function TgtPD8bitFont.TextSize(const Text: AnsiString; AFont: TFont): TSize;
//var
//  DC: HDC;
//  SaveFont: HFont;
//  LSize: TSize;
//  LFont: TFont;
//begin
//  LFont := TFont.Create;
//  LFont.Name := AFont.Name;
//  LFont.Size := AFont.Size;
//  LFont.Style := AFont.Style;
//  LFont.Color := AFont.Color;
//  try
//    DC := GetDC(0);
//    SaveFont := SelectObject(DC, LFont.Handle);
//    GetTextExtentPoint32A(DC, PAnsiChar(Text), Length(Text), LSize);
//    SelectObject(DC, SaveFont);
//  finally
//    ReleaseDC(0, DC);
//    LFont.Free;
//  end;
//  Result := LSize;
//end;

procedure TgtPD8bitFont.Update;
begin
  inherited;
end;

end.
