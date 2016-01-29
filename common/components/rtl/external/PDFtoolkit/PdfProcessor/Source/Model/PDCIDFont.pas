{$I ..\Utils\gtCompilerDefines.inc}
unit PDCIDFont;

interface

uses
  Classes, gtObject, PDBaseObject, PDElement, PDFont, gtTypes, PDCMap,
  PDCMapParser, PDPage, gtFont, PDEncoding, FontProcessor, Graphics,
  PDBuiltInFontMap, Windows, gtPDUsp10, gtUniscribe;

type
  TgtCharWidthArray = array[0..255] of Double;

  TCIDToGIDMapTable = TList;

  TCIDWidthExcep = record
    First: TgtCID; // this record applies to
    Last: TgtCID; // CIDs <first>..<last>
    Width: Double; // AnsiChar width
  end;

  TCIDWidthExcepV = record
    First: TgtCID; //this record applies to
    Last: TgtCID; //CIDs <first>..<last>
    Height: Double; //AnsiChar Height
    Vx, Vy: Double; //Orgin Position
  end;

  TCIDWidths = record
    DefWidth: Double; //Default AnsiChar Width
    DefHeight: Double; //Default AnsiChar Height
    DefVY: Double; //Default orgin position
    Exceps: array of TCIDWidthExcep; // exceptions
    nExceps: Integer;
    ExcepsV: array of TCIDWidthExcepV; // exceptions of vertical fonts
    nExcepsV: Integer;
  end;

  TgtPDCIDFont = class(TgtPDFont)
  private
    FCMap: TgtPDCMap; // AnsiChar code ---> CUD
    FWidths: TCIDWidths; // character widths
    FCIDToGID: TCIDToGIDMapTable;// CID ---> GID mapping (for embedded TrueType fonts
    //Following datamembers for writing CID in to PDF
    FEncoding: TgtEncodingArray;
    FHasEncoding: Boolean;
    FHasDifferences: Boolean;
    FUsesMacRomanEnc: Boolean;
    FCWidths: TgtCharWidthArray;
    FCharWidths: TgtCharWidthArray;
    FStemV: Double;
    FUnderscorePosition: Double;
    FUnderscoreSize: Double;
    FFontEncoding: AnsiString;
    FFontProcObj: TgtFontProcessor;
    FFirstCharCode, FLastCharCode: Integer;
    //Lists to maintain used information
    //FCIDGlyphList: TList;
    FIsCIDComplex: Boolean;
    //FUsedGlyphIDList: TList;
    FUsedWidthList: TList;
    FUsedCharCodeList: TList;
    //FAllCIDGlyph: TList;

    function GetFontFlag(AFont: TFont): Integer;
  public
    constructor Create(AParentDoc: TgtObject; AParentElement: TgtPDElement;
      ABaseObject: TgtPDBaseObject; const ATag: AnsiString; AName: AnsiString);overload;
    constructor Create(AParentDoc: TgtObject; AParentElement: TgtPDElement;
      AObject: TgtFont); overload;
    destructor Destroy; override;
    procedure Update; override;
    function IsCIDFont: Boolean; override;
    function GetNextChar(const aStr: WideString; Index: Integer; out Processed: Integer;
      out Code: TgtCharCode; out CharName: AnsiString; out Dx: Double;
      out Dy: Double; out Ox: Double; out Oy: Double): Integer; override;
    function WritingMode: TgtWritingMode; override;
    function GetCollection: AnsiString;
    function GetCIDToGID: TCIDToGIDMapTable;
    function GetCharWidth(ACharCode: TgtCharCode): Double; override;
    
    //Methods to write CID font information on to the font resource dictionary
    procedure CreateFontDict; override;
    function WriteDescendentDict: TgtPDBaseObject;
    function WriteFontDescriptor: TgtPDBaseObject;
    procedure ProcessUniscribe(AText: WideString; AFont: TFont; ACIDGlyphList: TList);overload;
    //procedure ProcessUniscribe(AText: WideString; AFont: TFont); overload;
    procedure UpdateCIDFontDict;
    procedure FreeUnicribeList;
    
    function GetHeight(AText: AnsiString; AFont: TFont): Double;
    function GetWidth(AText: AnsiString; AFont: TFont): Double;
    //property CIDGlyphIDs: TList read FCIDGlyphList;
    property UnderscoreSize: Double read FUnderscoreSize write FUnderscoreSize;
    property UnderscorePosition: Double read FUnderscorePosition write FUnderscorePosition;
  end;

implementation

uses
{$IFDEF DEBUG}
  gtLogger,
{$ENDIF}
  PDRect, PDDictionary, gtConstants, PDArray, PDName, PDString, PDDocument,
  PDStream, PDInteger, PDReal, SysUtils, gtMethods, PDIndirectRef, Math,
  Stream, MemoryStream, forms;

type
  THackDocument = class(TgtPDDocument)

  end;
  
var
   ErrorCode: ErrorCodes;

function ConvertPixelToPoints(Value: Integer): Integer;
begin
  Result := Round(Value / Screen.PixelsPerInch * 72);
end;

function CompareL(aItemP1, aItemP2: Pointer): Integer;
var
  LVal1, LVal2: Integer;
begin
  LVal1 := Integer(aItemP1);
  LVal2 := Integer(aItemP2);
  if LVal1 > LVal2 then
    Result := 1
  else if LVal1 < LVal2 then
    Result := -1
  else
    Result := 0;
end;
{ TgtPDCIDFont }

constructor TgtPDCIDFont.Create(AParentDoc: TgtObject;
  AParentElement: TgtPDElement; ABaseObject: TgtPDBaseObject;
  const ATag: AnsiString; AName: AnsiString);
var
  LObj1, LObj2, LObj3: TgtPDBaseObject;
  LObj4: TgtPDBaseObject;
  DesFontDict: TgtPDBaseObject;
  Collection: AnsiString;
  I, J, K: Integer;
  C1, C2: Integer;
//  uBuf: TgtUnicodes;
  cMapName, LStr1, LStr2: AnsiString;
  ExcepsSize: Integer;
  LStream: TStream;
begin
  FParentDoc := AParentDoc;
  FParentElement := AParentElement;
  FBaseObject := ABaseObject;
  FTag := ATag;
  FName := AName;

  FAscent := 0.95;
  FDescent := -0.35;
  FFontBox := TgtPDRect.Create(0.0, 0.0, 0.0, 0.0);
  FCMap := nil;
  //FCTU := nil;

  FWidths.DefWidth := 1.0;
  FWidths.DefHeight := -1.0;

  // get the descendant font
  LObj1 := TgtPDDictionary(FBaseObject).LookUp(PDF_DESCENDANTFNT);
  if not Assigned(LObj1) or not LObj1.IsArray then
  begin
{$IFDEF DEBUG}
    Logger.LogError('Missing DescendantFonts entry in Type 0 font');
{$ENDIF}
    Exit;
  end;

  DesFontDict := TgtPDArray(LObj1).Get(0);
  if not Assigned(DesFontDict) or not DesFontDict.IsDict then
  begin
{$IFDEF DEBUG}
    Logger.LogError('Bad descendant font in Type 0 font');
{$ENDIF}
    Exit;
  end;

  //font type
  LObj1 := TgtPDDictionary(DesFontDict).LookUp(PDF_SUBTYPE);
  if not Assigned(LObj1) or not LObj1.IsName then
  begin
{$IFDEF DEBUG}
    Logger.LogError('Missing Subtype entry in Type 0 descendant font');
{$ENDIF}
    Exit;
  end;
  if LObj1.IsName(PDF_CIDTYPE0) then
    FFontType := CIDType0
  else if LObj1.IsName(PDF_CIDTYPE2) then
    FFontType := CIDType2
  else
  begin
{$IFDEF DEBUG}
    Logger.LogError('Unknown Type 0 descendant font type %s', [TgtPDName(LObj1).Value]);
{$ENDIF}
    Exit;
  end;

  //get info from font descriptor
  ReadFontDescriptor(DesFontDict);

//  //look for an external font file
//  FindExtFontFile;
//
  //----- encoding info -------

  //AnsiChar collection
  LObj1 := TgtPDDictionary(DesFontDict).LookUp(PDF_CIDSYSTEMINFO);
  if not Assigned(LObj1) and not LObj1.IsDict then
  begin
{$IFDEF DEBUG}
    Logger.LogError('Missing CIDSystemInfo dictionary in Type 0 descendant font');
{$ENDIF}
    Exit;
  end;
  LObj2 := TgtPDDictionary(LObj1).LookUp(PDF_REGISTRY);
  LObj3 := TgtPDDictionary(LObj1).LookUp(PDF_ORDERING);
  LObj4 := TgtPDDictionary(LObj1).LookUp(PDF_SUPPLEMENT);

  if not Assigned(LObj2) or not Assigned(LObj3) or not Assigned(LObj4)
    or not Lobj2.IsString or not LObj3.IsString or not LObj4.IsInteger then
  begin
{$IFDEF DEBUG}
    Logger.LogError('Invalid CIDSystemInfo dictionary in Type 0 descendant font');
{$ENDIF}
    Exit;
  end;
  
  if TgtPDString(LObj2).IsHexString then
    LStr1 := UnicodeHexToString(TgtPDString(LObj2).Value)
  else
    LStr1 := TgtPDString(LObj2).Value;
  if TgtPDString(LObj3).IsHexString then
    LStr2 := UnicodeHexToString(TgtPDString(LObj3).Value)
  else
    LStr2 := TgtPDString(LObj3).Value;

  Collection := LStr1 + '-' + LStr2 + '-UCS2';

  // encoding (i.e., CMap)
  //~ need to handle a CMap stream here
  //~ also need to deal with the UseCMap entry in the stream dict
  LObj1 := TgtPDDictionary(BaseObject).LookUp(PDF_ENCODING);
  if not Assigned(LObj1) or not LObj1.IsName then
  begin
{$IFDEF DEBUG}
    Logger.LogError('Missing or invalid Encoding entry in Type0 font');
{$ENDIF}
    Exit;
  end;
  cMapName := TgtPDString(LObj1).Value;
  FEncodingName := cMapName;

  {$IFDEF DLLPROJECT}
    FCMap := TgtPDCMap.MakeCMap(Collection, cMapName);
  {$ELSE}
    FCMap := TgtPDCMap.MakeCMap(Collection, cMapName, TgtPDDocument(FParentDoc).CMapPath);
  {$ENDIF}
  if not Assigned(FCMap) then
  begin
{$IFDEF DEBUG}
    Logger.LogError('Unknown CMap %s for character collection %s', [cMapName,
      Collection]);
{$ENDIF}
    Exit;
  end;

  //----- character metrics -----

  // default AnsiChar width
  LObj1 := TgtPDDictionary(DesFontDict).LookUp(PDF_DW);
  if Assigned(LObj1) and LObj1.IsInteger then
  begin
    FWidths.DefWidth := TgtPDInteger(LObj1).Value * 0.001;
  end;

  //AnsiChar width exceptions
  LObj1 := TgtPDDictionary(DesFontDict).LookUp(PDF_W);
  if Assigned(LObj1) and LObj1.IsArray then
  begin
    ExcepsSize := 0;
    I := 0;
    while I + 1 < TgtPDArray(LObj1).GetLength do
    begin
      LObj2 := TgtPDArray(LObj1).Get(I);
      LObj3 := TgtPDArray(LObj1).Get(I + 1);
      if Assigned(LObj2) and Assigned(LObj3)
        and LObj2.IsInteger and LObj3.IsInteger
        and ((I + 2) < TgtPDArray(LObj1).GetLength) then
      begin
        LObj4 := TgtPDArray(LObj1).Get(I + 2);
        if Assigned(LObj4) and LObj4.IsNumber then
        begin
          if FWidths.nExceps = ExcepsSize then
          begin
            ExcepsSize := ExcepsSize + 16;
            SetLength(FWidths.Exceps, ExcepsSize);
          end;
          FWidths.Exceps[FWidths.nExceps].First := TgtPDInteger(LObj2).Value;
          FWidths.Exceps[FWidths.nExceps].Last := TgtPDInteger(LObj3).Value;
          if LObj4.IsInteger then
            FWidths.Exceps[FWidths.nExceps].Width := TgtPDInteger(LObj4).Value * 0.001
          else
            FWidths.Exceps[FWidths.nExceps].Width := TgtPDReal(LObj4).Value * 0.001;
          Inc(FWidths.nExceps);
        end
        else
        begin
{$IFDEF DEBUG}
          Logger.LogError('Bad widths array in Type 0 font');
{$ENDIF}
        end;
        I := I + 3;
      end
      else if Assigned(LObj2) and Assigned(LObj3)
        and LObj2.IsInteger and LObj3.IsArray then
      begin
        if FWidths.nExceps + TgtPDArray(LObj3).GetLength > ExcepsSize then
        begin
          ExcepsSize := (FWidths.nExceps + TgtPDArray(LObj3).GetLength + 15)
            and (not 15);
          SetLength(FWidths.Exceps, ExcepsSize);
        end;
        J := TgtPDInteger(LObj2).Value;
        for K := 0 to TgtPDArray(LObj3).GetLength - 1 do
        begin
          LObj4 := TgtPDArray(LObj3).Get(K);
          if Assigned(LObj4) and LObj4.IsNumber then
          begin
            FWidths.Exceps[FWidths.nExceps].First := J;
            FWidths.Exceps[FWidths.nExceps].Last := J;
            if LObj4.IsInteger then
              FWidths.Exceps[FWidths.nExceps].Width := TgtPDInteger(LObj4).Value * 0.001
            else
              FWidths.Exceps[FWidths.nExceps].Width := TgtPDReal(LObj4).Value * 0.001;
            Inc(J);
            Inc(FWidths.nExceps);
          end
          else
          begin
{$IFDEF DEBUG}
            Logger.LogError('Bad widths array in Type 0 font');
{$ENDIF}
          end;
        end;
        I := I + 2;
      end
      else
      begin
{$IFDEF DEBUG}
        Logger.LogError('Bad widths array in Type 0 font');
{$ENDIF}
        Inc(I);
      end;
    end;
  end;
//  for I := 0 to FWidths.nExceps - 2 do
//  begin
//    FWidths.Exceps[I].Last := FWidths.Exceps[I + 1].First - 1;
//  end;
//  for I := 0 to FWidths.nExcepsV - 2 do
//  begin
//    FWidths.ExcepsV[I].Last := FWidths.ExcepsV[I + 1].First - 1;
//  end;

  // CIDToGIDMap (for embedded TrueType fonts)
  if FFontType = CIDType2 then
  begin
    LObj1 := TgtPDDictionary(DesFontDict).LookUp(PDF_CIDTOGIDMAP);
    if Assigned(LObj1) and LObj1.IsStream then
    begin
      TgtPDStream(LObj1).Reset;
      C1 := TgtPDStream(LObj1).GetChar;
      C2 := TgtPDStream(LObj1).GetChar;
      while (C1 <> ENDOFFILE) and (C2 <> ENDOFFILE) do
      begin
        K := (C1 shl 8) + C2;
        if not Assigned(FCIDToGID) then
          FCIDToGID := TCIDToGIDMapTable.Create;
        FCIDToGID.Add(TObject(K));
        C1 := TgtPDStream(LObj1).GetChar;
        C2 := TgtPDStream(LObj1).GetChar;
      end;
    end
    else if Assigned(LObj1) and not LObj1.IsName(PDF_IDENTITY)
      and not LObj1.IsNull then
    begin
      {$IFDEF DEBUG}
        Logger.LogError('Invalid CIDToGIDMap entry in CID font');
      {$ENDIF}
    end;
  end;

//  if not Assigned(EmbeddedFontStream) then
//  begin
  LObj1 := TgtPDDictionary(FBaseObject).LookUp(PDF_TOUNICODE);
  if Assigned(LObj1) and LObj1.IsStream then
  begin
    LStream := TMemoryStream.Create;
    TgtPDStream(LObj1).Reset;
    C1 := TgtPDStream(LObj1).GetChar;
    while C1 <> ENDOFFILE do
    begin
      LStream.Write(C1, 1);
      C1 := TgtPDStream(LObj1).GetChar;
    end;
    LStream.Position := 0;
    FToUnicode := TToUnicodeTable.Create(LStream);
    LStream.Free;
  end;
//  end;
end;

constructor TgtPDCIDFont.Create(AParentDoc: TgtObject;
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

  FCIDToGID := TList.Create;

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

procedure TgtPDCIDFont.CreateFontDict;
var
  LDict: TgtPDDictionary;
  LArray: TgtPDArray;
  LFontType: AnsiString;
  LToUnicodeObj: TgtPDStream;
  LI: Integer;
  LMemStream: TMemoryStream;
  LgtStream: TgtMemoryStream;
begin
  if not Assigned(BaseObject) then
  begin
    //Create CID Font dictionary
    TgtPDDocument(FParentDoc).LastObjectNumber := TgtPDDocument(FParentDoc).LastObjectNumber + 1;
    FBaseObject := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).LastObjectNumber, 0,
      TgtPDDocument(FParentDoc).BaseDoc);
    TgtPDDocument(FParentDoc).BaseDoc.AddToCollection(FBaseObject);
    TgtPDDictionary(FBaseObject).Add(PDF_TYPE, TgtPDName.Create(PDF_FONT));
    TgtPDDictionary(FBaseObject).Add(PDF_SUBTYPE, TgtPDName.Create(PDF_TYPE0));
    TgtPDDictionary(FBaseObject).Add(PDF_NAME, TgtPDName.Create(Tag));
    TgtPDDictionary(FBaseObject).Add(PDF_BASEFONT, TgtPDName.Create(FName));
    TgtPDDictionary(FBaseObject).Add(PDF_ENCODING, TgtPDName.Create('Identity-H'));

    LArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
    LArray.Add(WriteDescendentDict);
    TgtPDDictionary(FBaseObject).Add(PDF_DESCENDANTFNT,LArray);

    LMemStream := TMemoryStream.Create;
    LgtStream := TgtMemoryStream.Create(LMemStream, 0, 0, False);
    LDict := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);
    TgtPDDocument(FParentDoc).LastObjectNumber := TgtPDDocument(FParentDoc).LastObjectNumber + 1;
    LToUnicodeObj := TgtPDStream.Create(LgtStream, LDict,
      TgtPDDocument(FParentDoc).LastObjectNumber, 0);
    TgtPDDocument(FParentDoc).BaseDoc.AddToCollection(LToUnicodeObj);
    TgtPDDictionary(FBaseObject).Add(PDF_TOUNICODE,
      TgtPDIndirectRef.Create(LToUnicodeObj.ObjNumber, LToUnicodeObj.GenNumber));
  end;
end;

destructor TgtPDCIDFont.Destroy;
begin
  FWidths.Exceps := nil;
  FWidths.ExcepsV := nil;
  if Assigned(FCMap) then
    FreeAndNil(FCMap);
  if Assigned(FCIDToGID) then FCIDToGID.Free;
  FreeUnicribeList;
  if Assigned(FFontProcObj) then
    FreeAndNil(FFontProcObj);
  inherited;
end;

procedure TgtPDCIDFont.FreeUnicribeList;
var
  LI: Integer;
begin
//  if Assigned(FAllCIDGlyph) then
//  begin
//    for LI := 0 to (FAllCIDGlyph.Count - 1) do
//    begin
//      if Assigned(FAllCIDGlyph.Items[LI]) then
//        TgtGlyphInfo(FAllCIDGlyph.Items[LI]).Free;
//    end;
//  end;
//  if Assigned(FUsedGlyphIDList) then
//    FreeAndNil(FUsedGlyphIDList);
  if Assigned(FUsedWidthList) then
    FreeAndNil(FUsedWidthList);
  if Assigned(FUsedCharCodeList) then
    FreeAndNil(FUsedCharCodeList);
//  if Assigned(FAllCIDGlyph) then
//    FreeAndNil(FAllCIDGlyph);
//  if Assigned(FCIDGlyphList) then
//    FreeAndNil(FCIDGlyphList);
end;

function TgtPDCIDFont.GetCharWidth(ACharCode: TgtCharCode): Double;
var
  I: Integer;
begin
  Result := 0;
  if Assigned(FCmap) then
  begin
    if FCMap.WMode = wmHorizontal then
    begin
      Result := FWidths.DefWidth;
      for I := 0 to FWidths.nExceps - 1 do
      begin
        if (FWidths.Exceps[I].First <= ACharCode) and
          (FWidths.Exceps[I].Last >= ACharCode) then
        begin
          Result := FWidths.Exceps[I].Width;
          Break;
        end;
      end;
    end;
  end;
end;

function TgtPDCIDFont.GetCIDToGID: TCIDToGIDMapTable;
begin
  Result := FCIDToGID;
end;

function TgtPDCIDFont.GetCollection: AnsiString;
begin

end;

function TgtPDCIDFont.GetFontFlag(AFont: TFont): Integer;
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

function TgtPDCIDFont.GetNextChar(const aStr: WideString; Index: Integer;
  out Processed: Integer; out Code: TgtCharCode; out CharName: AnsiString;
  out Dx, Dy, Ox, Oy: Double): Integer;
var
  Width, Height, Vx, Vy: Double;
  I: Integer;
begin
  Result := 0;
  Width := 0;
  Height := 0;
  Vx := 0;
  Vy := 0;
  if not Assigned(FCMap) then
  begin
    Code := 0;
    Dx := 0;
    Dy := 0;
    Exit;
  end;
  Code := FCMap.GetCID(aStr, Index, Processed, Assigned(EmbeddedFontStream));
  if FCMap.WMode = wmHorizontal then
  begin
    Width := FWidths.DefWidth;
    Height := 0;
    Vx := 0;
    Vy := 0;
    for I := 0 to FWidths.nExceps - 1 do
    begin
      if (FWidths.Exceps[I].First <= Code) and
        (FWidths.Exceps[I].Last >= Code) then
      begin
        Width := FWidths.Exceps[I].Width;
        Break;
      end;
    end;
  end;

  if (FFontType = CIDType2) and Assigned(FCIDToGID) then
    Code := Word(FCIDToGID.Items[Code])
  else if not Assigned(EmbeddedFontStream) and Assigned(FToUnicode) then
    Code := FToUnicode.Code[Code];

  Dx := Width;
  Dy := Height;
  Ox := Vx;
  Oy := Vy;
  Result := 1;
end;

function TgtPDCIDFont.IsCIDFont: Boolean;
begin
  Result := True;
end;

procedure TgtPDCIDFont.ProcessUniscribe(AText: WideString; AFont: TFont; ACIDGlyphList: TList);
var
  LCIDGlyphInfo: TgtGlyphInfo;
  LI, LJ, ExcepsSize: Integer;
  LOldSize: Integer;
begin
  ExcepsSize := 0;
  //FCIDGlyphList := ACIDGlyphList;
  if (ACIDGlyphList = nil) or (ACIDGlyphList.Count = 0) then
    Exit;

//  if not Assigned(FAllCIDGlyph) then
//    FAllCIDGlyph := TList.Create;

//  for LI := 0 to ACIDGlyphList.Count - 1 do
//  begin
//    FAllCIDGlyph.Add(TgtGlyphInfo(ACIDGlyphList.Items[LI]));
//  end;

   //Temporary list which maintains GLYPH IDs, Width and Charcode
//  if not Assigned(FUsedGlyphIDList) then
//  begin
//    FUsedGlyphIDList := TList.Create;
//    FUsedWidthList := TList.Create;
//    FUsedCharCodeList := TList.Create;
//  end;
  if not Assigned(FCIDToGID) then
  begin
    FCIDToGID := TList.Create;
    FUsedWidthList := TList.Create;
    FUsedCharCodeList := TList.Create;
  end;

  //Remove duplicates upon repeated TextOut
  for LI := 0 to ACIDGlyphList.Count - 1 do
  begin
    LCIDGlyphInfo := TgtGlyphInfo(ACIDGlyphList.Items[LI]);
    if (FCIDToGID.IndexOf(TObject(LCIDGlyphInfo.ID)) <> -1) then
      Continue;
//    begin
//      FreeAndNil(LCIDGlyphInfo);
//      ACIDGlyphList.Items[LI] := nil;
//    end
//    else
//      FAllCIDGlyph.Add(TObject(LCIDGlyphInfo));

    if FWidths.nExceps = ExcepsSize then
    begin
      ExcepsSize := ExcepsSize + 16;
      SetLength(FWidths.Exceps, ExcepsSize);
    end;

    //Fill the internal datastructure used for reading
    FCIDToGID.Add(TObject(LCIDGlyphInfo.ID));
    FWidths.Exceps[FWidths.nExceps].Width := ConvertPixelToPoints(LCIDGlyphInfo.AdvWidth);

    //Fill datastructures used for writing
//    FUsedGlyphIDList.Add(TObject(LCIDGlyphInfo.ID));
    FUsedWidthList.Add(TObject(ConvertPixelToPoints(LCIDGlyphInfo.AdvWidth)));
    FUsedCharCodeList.Add(TObject(Ord(AText[LI + 1])));
    AFont.Size := LOldSize;
    Inc(FWidths.nExceps);
  end;
end;

procedure TgtPDCIDFont.Update;
begin
  inherited;
  UpdateCIDFontDict;
end;

procedure TgtPDCIDFont.UpdateCIDFontDict;

  procedure UpdateToUnicodeEntry;
  var
    LI, LJ, LFirst, LLast, LCnt: Integer;
    LIncludeChar, LID: Integer;
    LRange, LCMap1, LCMap2, LCharCode, FPDFCMap: string;
    LMemStream: TMemoryStream;
    LObj, LObj2: TgtPDBaseObject;
    LStrm: TgtStream;
    LWord1, LWord2: Integer;
  begin
    if not Assigned(FCIDToGID) then
    begin
      FPDFCMap := ' ';
      LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_TOUNICODE);
      if Assigned(LObj) and LObj.IsStream then
      begin
        LStrm := TgtPDStream(lobj).GetStream;
        LMemStream := TgtStream(LStrm).GetTStream as TMemoryStream;
      end;
      LMemStream.Write(FPDFCMap[1], Length(FPDFCMap));
      LObj2 := TgtPDStream(LObj).GetDict;
      TgtPDDictionary(LObj2).Add(PDF_LENGTH, TgtPDInteger.Create(LMemStream.Size));
      LStrm.Reset;
      Exit;
    end;

    LCMap1 :=
      '/CIDInit /ProcSet findresource begin' + CRLF +
      '12 dict begin' + CRLF +
      'begincmap' + CRLF +
      '/CIDSystemInfo <<' +
        '/Registry (Adobe)/Ordering (UCS)/Supplement 0>> def' + CRLF +
      '/CMapName /Adobe-Identity-UCS def' + CRLF +
      '/CMapType 2 def';
    LCMap2 := CRLF;
    LLast := 0;
    LFirst := $FFFF;
    LCnt := 0;

    //Sort the GLYPH IDs
    //FCIDToGID.Sort(CompareL);

    for LI := 0 to FCIDToGID.Count - 2 do
    begin
      for LJ := (LI + 1) to FCIDToGID.Count - 1 do
      begin
        LWord1 := Integer(FCIDToGID.Items[LI]);
        LWord2 := Integer(FCIDToGID.Items[LJ]);
        if (LWord1 > LWord2) then
        begin
          FCIDToGID.Exchange(LI, LJ);
          FUsedWidthList.Exchange(LI, LJ);
          FUsedCharCodeList.Exchange(LI, LJ);
        end;
      end;
    end;

//    FUsedGlyphIDList.Sort(CompareL);
//    FUsedWidthList.Sort(CompareL);
//    FUsedCharCodeList.Sort(CompareL);
    //Update the /ToUnicode entry
    //Write the sorted GLYPH Id and Charcode
    for LI := 0 to FCIDToGID.Count - 1 do
    begin
      LID := Integer(TObject(FCIDToGID.Items[LI]));
      LFirst := Min(LFirst, Integer(LID));
      LLast := Max(LLast, Integer(LID));
      LCnt := LCnt + 1;
      LCMap2 := LCMap2 +  AnsiString(
        '<' + IntToHex(LID, 4) +
        '><' + IntToHex(LID, 4) +
        '><' + IntToHex(Integer(FUsedCharCodeList.Items[LI]), 4) + '>' +
        CRLF);
    end;
    LCMap2 := LCMap2 +
      'endbfrange' + CRLF +
      'endcmap' + CRLF +
      'CMapName currentdict /CMap defineresource pop' + CRLF +
      'end end' + CRLF;
    LRange := CRLF +
      '1 begincodespacerange' + CRLF +
      '<' + IntToHex(LFirst, 4) +
      '><' + IntToHex(LLast, 4) + '>' + CRLF +
      'endcodespacerange' + CRLF +
      IntToStr(LCnt) + ' beginbfrange';
    FPDFCMap := LCMap1 + LRange + LCMap2;
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_TOUNICODE);
    if Assigned(LObj) and LObj.IsStream then
    begin
      LStrm := TgtPDStream(lobj).GetStream;
      LMemStream := TgtMemoryStream(LStrm).GetTStream as TMemoryStream;
    end;
    LMemStream.Write(FPDFCMap[1], Length(FPDFCMap));
    LObj2 := TgtPDStream(LObj).GetDict;
    TgtPDDictionary(LObj2).Add(PDF_LENGTH, TgtPDInteger.Create(LMemStream.Size));
    LStrm.Reset;
  end;

  procedure UpdateToWidthEntry;
  var
    LI, LPrev, LNext, LCur: Integer;
    LObj, LObj2, LObj3: TgtPDBaseObject;
    LArray, LArray1: TgtPDArray;

    function CreateSubWidthArray: TgtPDBaseObject;
    begin
      LArray1 := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
      Result := LArray1;
    end;

    function AddToWidthArray(AWidthArray: TgtPDArray; AWidth: Integer): TgtPDArray;
    begin
      if Assigned(AWidthArray) and AWidthArray.IsArray then
      begin
        AWidthArray.Add(TgtPDInteger.Create(AWidth));
      end;
      Result := AWidthArray;
    end;

    function GetWidthFromGlyphList(AGlyphId: Integer): Integer;
    var
      //LCIDGlyphInfo: TgtGlyphInfo;
      LI: Integer;
    begin
      Result := 0;
      LI := FCIDToGID.IndexOf(TObject(AGlyphId));
      if LI = -1 then
        Exit;
      Result := Integer(FUsedWidthList.Items[LI]);

//      for LI := 0 to FAllCIDGlyph.Count - 1 do
//      begin
//        LCIDGlyphInfo := TgtGlyphInfo(FAllCIDGlyph.Items[LI]);
//        if LCIDGlyphInfo.ID = AGlyphId then
//        begin
//          Result := ConvertPixelToPoints(LCIDGlyphInfo.AdvWidth);
//          Exit;
//        end;
//      end;
    end;

  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_DESCENDANTFNT);
    if Assigned(LObj) and LObj.IsArray then
    begin
      LObj2 := TgtPDArray(LObj).Get(0);
      LObj3 := TgtPDDictionary(LObj2).LookUp(PDF_W);
      if Assigned(LObj3) and LObj3.IsArray then
      begin
        for LI := 0 to FCIDToGID.Count - 1 do
        begin
          LCur := Integer(TObject(FCIDToGID.Items[LI]));
          if LI > 0 then
            LPrev := Integer(TObject(FCIDToGID.Items[LI - 1]));

          if LI = 0 then
          begin
            TgtPDArray(LObj3).Add(TgtPDInteger.Create(Integer(TObject(FCIDToGID.Items[LI]))));
            TgtPDArray(LObj3).Add(AddToWidthArray(TgtPDArray(CreateSubWidthArray),
              GetWidthFromGlyphList(Integer(TObject(FCIDToGID.Items[LI])))));
          end
          else if (LPrev + 1) = LCur then
          begin
            AddToWidthArray(LArray1, GetWidthFromGlyphList(Integer(TObject(FCIDToGID.Items[LI]))));
          end
          else
          begin
            TgtPDArray(LObj3).Add(TgtPDInteger.Create(Integer(TObject(FCIDToGID.Items[LI]))));
            TgtPDArray(LObj3).Add(AddToWidthArray(TgtPDArray(CreateSubWidthArray),
              GetWidthFromGlyphList(Integer(TObject(FCIDToGID.Items[LI])))));
          end;
        end;
      end;
    end;
  end;

begin
  if Assigned(FCIDToGID) then
  begin
    UpdateToUnicodeEntry;
    UpdateToWidthEntry;
  end;
end;

function TgtPDCIDFont.WriteDescendentDict: TgtPDBaseObject;
var
  LDecenDict, LCIDSysInfoDict : TgtPDDictionary;
begin
  if  Assigned(BaseObject) then
  begin
    //Create Descendent dictionary
    TgtPDDocument(FParentDoc).LastObjectNumber := TgtPDDocument(FParentDoc).LastObjectNumber + 1;
    LDecenDict := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).LastObjectNumber, 0,
      TgtPDDocument(FParentDoc).BaseDoc);
    TgtPDDocument(FParentDoc).BaseDoc.AddToCollection(LDecenDict);
    LDecenDict.Add(PDF_TYPE, TgtPDName.Create(PDF_FONT));
    LDecenDict.Add(PDF_SUBTYPE, TgtPDName.Create(PDF_CIDTYPE2));
    LDecenDict.Add(PDF_BASEFONT, TgtPDName.Create(FName));
    LDecenDict.Add(PDF_W, TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc));
    LDecenDict.Add(PDF_DW, TgtPDInteger.Create(3240));
    LDecenDict.Add(PDF_CIDTOGIDMAP, TgtPDName.Create(PDF_IDENTITY));

    LCIDSysInfoDict := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);
    LCIDSysInfoDict.Add(PDF_REGISTRY, TgtPDString.Create('Adobe', False));
    LCIDSysInfoDict.Add(PDF_ORDERING, TgtPDString.Create(PDF_IDENTITY, False));
    LCIDSysInfoDict.Add(PDF_SUPPLEMENT, TgtPDInteger.Create(0));
    
    LDecenDict.Add(PDF_CIDSYSTEMINFO, LCIDSysInfoDict);
    LDecenDict.Add(PDF_FONTDESCRIPTOR, WriteFontDescriptor);
    Result := TgtPDIndirectRef.Create(LDecenDict.ObjNumber, LDecenDict.GenNumber);
  end;
end;

function TgtPDCIDFont.WriteFontDescriptor: TgtPDBaseObject;
var
  LFontDescript : TgtPDDictionary;
  LFontBoxArray: TgtPDArray;
begin
  if Assigned(BaseObject) then
  begin
    //Create Fontdescriptor dictionary
    TgtPDDocument(FParentDoc).LastObjectNumber := TgtPDDocument(FParentDoc).LastObjectNumber + 1;
    LFontDescript := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).LastObjectNumber, 0,
      TgtPDDocument(FParentDoc).BaseDoc);
    TgtPDDocument(FParentDoc).BaseDoc.AddToCollection(LFontDescript);
    LFontDescript.Add(PDF_TYPE, TgtPDName.Create(PDF_FONTDESCRIPTOR));
    LFontDescript.Add(PDF_FONTNAME, TgtPDName.Create(FName));
    LFontDescript.Add(PDF_FLAGS, TgtPDInteger.Create(FFlags));
    LFontDescript.Add(PDF_ASCENT, TgtPDReal.Create(FAscent));
    LFontDescript.Add(PDF_DESCENT, TgtPDReal.Create(FDescent));
    LFontDescript.Add(PDF_MISSINGWIDTH, TgtPDInteger.Create(FMissingWidth));
    LFontDescript.Add(PDF_STEMV, TgtPDReal.Create(FStemV));
    LFontDescript.Add(PDF_ITALICANGLE, TgtPDInteger.Create(FItalicAngle));

    LFontBoxArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
    LFontBoxArray.Add(TgtPDReal.Create(FFontBox.Left));
    LFontBoxArray.Add(TgtPDReal.Create(FFontBox.Top));
    LFontBoxArray.Add(TgtPDReal.Create(FFontBox.Right));
    LFontBoxArray.Add(TgtPDReal.Create(FFontBox.Bottom));

    LFontDescript.Add(PDF_FONTBBOX, LFontBoxArray);
    Result := TgtPDIndirectRef.Create(LFontDescript.ObjNumber, LFontDescript.GenNumber);
  end;
end;

function TgtPDCIDFont.WritingMode: TgtWritingMode;
begin
  Result := wmHorizontal;
end;

function TgtPDCIDFont.GetHeight(AText: AnsiString; AFont: TFont): Double;
begin
  if (Assigned(FFontProcObj) and (ErrorCode = Success)) then
  begin
    Result := FFontProcObj.GetTextHeight(AText);
  end
  else
    Result := (TextSize(AText, AFont).cy) * (72/96);
end;

function TgtPDCIDFont.GetWidth(AText: AnsiString; AFont: TFont): Double;
begin
  if (Assigned(FFontProcObj) and (ErrorCode = Success)) then
  begin
    Result := FFontProcObj.GetTextWidth(AText);
  end
  else
    Result := (TextSize(AText, AFont).cx) * (72/96);
end;

{
procedure TgtPDCIDFont.ProcessUniscribe(AText: WideString; AFont: TFont);
var
  LCIDGlyphInfo: TgtGlyphInfo;
  LI, ExcepsSize: Integer;
  LOldSize: Integer;
begin
  ExcepsSize := 0;
  LOldSize := AFont.Size;
  AFont.Size := 1000;
//  FCIDGlyphList := TgtGlyphInfo.StringAnalyze(AText, AFont, FIsCIDComplex);

  if (ACIDGlyphList = nil) or (ACIDGlyphList.Count = 0) then
    Exit;

  if not Assigned(FAllCIDGlyph) then
    FAllCIDGlyph := TList.Create;

  for LI := 0 to ACIDGlyphList.Count - 1 do
  begin
    FAllCIDGlyph.Add(TgtGlyphInfo(FCIDGlyphList.Items[LI]));
  end;

   //Temporary list which maintains GLYPH IDs, Width and Charcode
  if not Assigned(FUsedGlyphIDList) then
  begin
    FUsedGlyphIDList := TList.Create;
    FUsedWidthList := TList.Create;
    FUsedCharCodeList := TList.Create;
  end;
  if not Assigned(FCIDToGID) then
  begin
    FCIDToGID := TList.Create;
  end;

  //Remove duplicates upon repeated TextOut
  for LI := 0 to FCIDGlyphList.Count - 1 do
  begin
    LCIDGlyphInfo := TgtGlyphInfo(FCIDGlyphList.Items[LI]);
    if (FUsedGlyphIDList.IndexOf(TObject(LCIDGlyphInfo.ID)) <> -1) then
      Continue;
    if FWidths.nExceps = ExcepsSize then
    begin
      ExcepsSize := ExcepsSize + 16;
      SetLength(FWidths.Exceps, ExcepsSize);
    end;

    //Fill the internal datastructure used for reading
    FCIDToGID.Add(TObject(LCIDGlyphInfo.ID));
    FWidths.Exceps[FWidths.nExceps].Width := ConvertPixelToPoints(LCIDGlyphInfo.AdvWidth);

    //Fill datastructures used for writing
    FUsedGlyphIDList.Add(TObject(LCIDGlyphInfo.ID));
    FUsedWidthList.Add(TObject(ConvertPixelToPoints(LCIDGlyphInfo.AdvWidth)));
    FUsedCharCodeList.Add(TObject(Ord(AText[LI + 1])));
    AFont.Size := LOldSize;
    Inc(FWidths.nExceps);
  end;
end;
}


end.
