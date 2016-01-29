{ *************************************************************************** }
{                                                                             }
{  Gnostice Shared Visual Component Library                                   }
{                                                                             }
{  Copyright © 2002-2010 Gnostice Information Technologies Private Limited    }
{  http://www.gnostice.com                                                    }
{                                                                             }
{ *************************************************************************** }

{------------------------------------}
{          Editor Options            }
{------------------------------------}
{                                    }
{ Tab Stops = 2                      }
{ Use Tab Character = True           }
{                                    }
{------------------------------------}

unit gtPDFFont3;

interface

uses
  Windows, Classes, Graphics, SysUtils, gtClasses3, Math, gtGlyphInfo;

type

{------------------------------------------------------------------------------}
                             {TgtPDFFontInfo}
{------------------------------------------------------------------------------}

	TgtFontType = (ftTrueType, ftType1, ftStdType1);

  TgtFontEncoding = (feWinAnsi, feCID);

(* Holds font metrics while exporting to PDF. *)
	TgtPDFFontInfo = class(TObject)
  public
		FfiFontObjRef: Integer;
    FfiWidths: array[32..255] of Integer; (* Required only for ANSI fonts. *)
		FfiFlags: Integer;
		FfiFontBBox: TRect;
		FfiAscent: Double;
		FfiDescent: Double;
		FfiCapHeight: Double;
		FfiAvgWidth: Integer;
		FfiMaxWidth: Integer;
    FfiStemH: Integer;
		FfiStemV: Integer;
		FfiItalicAngle: Integer;
		FfiStrikeoutSize: Double;
    FfiFontWeight :Integer;
		FfiStrikeoutPosition: Double;
		FfiUnderscoreSize: Double;
		FfiUnderscorePosition: Double;
    FfiType: TgtFontType; (* Indicates whether the font is TT or Type1 *)
    FfiIsFixedPitch: Boolean;
    constructor Create(AFont: TFont);
	end;

  TgtInstalledFont = class
  private
    FFilePath: string;
    FString: string;
    FStyle: TFontStyles;
    procedure SetFilePath(const Value: string);
    procedure SetString(const Value: string);
    procedure SetStyle(const Value: TFontStyles);
  public
    property FaceName: string read FString write SetString;
    property Style: TFontStyles read FStyle write SetStyle;
    property FilePath: string read FFilePath write SetFilePath;
  end;

{------------------------------------------------------------------------------}
                             {TgtPDFFont}
{------------------------------------------------------------------------------}
  (*
    Holds information about fonts that are used in the created PDF file.
    Contains information required for Type1,
      TrueType (Without Font Embedding) fonts.
  *)
  TgtPDFFont = class(TObject)
  private
    FBaseFont: String;

    FPDFCMap: String;
    FSubset: Boolean;
    (*
      Required for Font Subsetting.
      Holds Character codes of included characters ONLY.
    *)
    FRequiredTables: array[0..9] of String;
    FAvailableTables: TStringList;
    FLocaTable: array of Cardinal;
    FIncludedCharCode: TList;
    FOutFont : TgtExtMemStream;
    FGlyfOut : TgtExtMemStream;
    FLocaOut : TgtExtMemStream;
    FTableOutCount: Integer;
    FTableOffset, FTableLength, FTableChecksum : array of Cardinal;
    FLocaOffset, FGlyfOffset: Cardinal;
    FNumGlyphs : Word;
    FLocaIsLong : Boolean;
    FFirstGlyph: Integer;
    FLastGlyph: Integer;
    FInstalledFontList: TList;
    FOffset: Integer;
    FFontEncoding: TgtFontEncoding;
    FUsedGlyphs: TStringList;
    FIsIdentityH: Boolean;

    procedure FillFontMetrics(ASubset: Boolean = False; ACharset: Boolean = True);
    function IsTrueType(ACharset: Boolean = True): Boolean;
    function SetBaseFont: String;

    (* Methods to extract CMap information. *)
    procedure GetFontCMapDetails;

    (* Methods to extract glyph width information. *)
//    procedure ReadGlyphWidths;
    procedure SetSubset(const Value: Boolean);

    (* Required for Font Subsetting. *)
    (*
      This method grabs information about Table Dictionaries in the font.
    *)
    procedure ReadTable(AStream: TgtExtMemStream);
//    function GetCheckSum(AStream : TgtExtMemStream) : Integer;
    (* Function to check whether the current glyph needs to be embedded. *)
    function IsTableNeeded(AString: String): Boolean;
    procedure SubsetInitialize;
    procedure SubsetFinalize;
    function WriteLocaAndGlyf(AStream: TgtExtMemStream): Boolean;
    procedure WriteTable(AStream: TgtExtMemStream);
    procedure SetFontEncoding(const Value: TgtFontEncoding);
    procedure ReadCompositeGlyph(AStream: TgtExtMemStream);
    procedure ReadLocaTable(AStream: TgtExtMemStream);
    function GetWidths: String;
    procedure SetIsIdentityH(const Value: Boolean);

  protected
    FFont: TFont;
    FFontInfo: TgtPDFFontInfo;

  public
    (*
      For Subset, problem occurs if /Widths is not included.
      In Base Font processor, font subsetting is not supported. Hence
        ASubset = False by default.
      For ExtFont, which supports subset, pass ASubset = True if font is being
        subsetted such that /Widths will be calculated.
    *)
    FCID: TList; (* Required only for CID (Non-ANSI) fonts. *)
    FCharCode: TList; (* Required only for CID (Non-ANSI) fonts. *)
    FWidths: TList; (* Required only for CID (Non-ANSI) fonts. *)

    constructor Create(AFont: TFont; AFontObjRef: Integer; AIsCID: Boolean;
      ASubset: Boolean = False; ACharset: Boolean = True);
    destructor Destroy; override;

    procedure AddUsedGlyphs(AText: WideString; AGlyphList: TgtGlyphInfoList);
    procedure AddUsedCharacters(AText: WideString);

    (* Get Subset Font Data. *)
    procedure GetFontFile2Subset(var AStream: TgtExtMemStream);

  //  function GetCIDFontDictionary(AFontDescriptorRef: String): String; overload;

    function GetCIDFontDictionary(
  AFontDescriptorRef: String; Registry, AOrdering: String): String;  overload;
    (* Get CMap Stream (Identity-H). *)

   function GetCIDFontRegistryEntry(): String;

   function GetCIDFontOrderingEntry(): String;

    procedure GetCMap(AMemStream: TMemoryStream);

    function GetFontDescriptor(AFontFile2Obj: String): String;
    function GetType0FontDictionary(AFontNo: Integer; AUnicodeObjRef,
      ADesFontObjRef: String): String;

    property Widths: TList read FWidths;

    (* Get Font Data. *)
    procedure GetFontFile2(var AStream: TMemoryStream);
    (*
      Method to check if the current font exists in the list.
        Condition to be checked -
          ACurrentFont.Name = AFont.Name
                     AND
          ACurrentFont.Style = AFont.Style
    *)
    function IsEqual(AFont: TFont): Boolean; overload;
    function IsEqual(AFont: TFont; AEncoding: TgtFontEncoding;
      AIsIdentityH: Boolean = True): Boolean; overload;
    property FontInfo: TgtPDFFontInfo read FFontInfo;
    property BaseFont: String read FBaseFont;
    property Font: TFont read FFont;
    property Subset: Boolean read FSubset write SetSubset;
    property IsIdentityH: Boolean read FIsIdentityH write
      SetIsIdentityH default True;
    property FontEncoding: TgtFontEncoding read FFontEncoding write
      SetFontEncoding;
  end;

implementation

uses
  Registry, {$IFDEF gtDelphi6Up} StrUtils{$ELSE} gtUtils3{$ENDIF}, gtConsts3;

var
  (*
    Contains the current CodePage default charset.
    Required for checking whether font is TT.
  *)
  ACPCharset: TFontCharset;



function GetACPCharset: TFontCharset;
begin
  Result := 0;
  case GetACP of
    1252:
      Result := ANSI_CHARSET;
    932:
      Result := SHIFTJIS_CHARSET;
    949:
      Result := HANGEUL_CHARSET;
    1361:
      Result := JOHAB_CHARSET;
    936:
      Result := GB2312_CHARSET;
    950:
      Result := CHINESEBIG5_CHARSET;
    1253:
      Result := GREEK_CHARSET;
    1254:
      Result := TURKISH_CHARSET;
    1258:
      Result := VIETNAMESE_CHARSET;
    1255:
      Result := HEBREW_CHARSET;
    1256:
      Result := ARABIC_CHARSET;
    1257:
      Result := BALTIC_CHARSET;
    874:
      Result := THAI_CHARSET;
    1250:
      Result := EASTEUROPE_CHARSET;
    1251:
      Result := RUSSIAN_CHARSET;
  end;
end;

{ TgtPDFFont }

procedure TgtPDFFont.AddUsedCharacters(AText: WideString);
var
  I, LIndex: Integer;
	P: PWideChar;
begin
  //It is required only for subset embedding, to encode the used characters in the
  //subset embedded font stream
  if FSubset then
  begin
    for I := 0 to Length(AText) - 1 do
    begin
      P := @AText[I + 1];
      if FSubset and (P^ <> ' ') and
        (FIncludedCharCode.IndexOf(TObject(Ord(P^))) = -1) then
      begin
        FIncludedCharCode.Add(TObject(Ord(P^)));
        LIndex := FCharCode.IndexOf(TObject(Ord(P^)));
        if LIndex <> -1 then
          if (FUsedGlyphs.IndexOf(IntToStr(Integer(FCID[LIndex]))) = -1) then
            FUsedGlyphs.Add(IntToStr(Integer(FCID[LIndex]))) ;
      end;
    end;
  end;
end;

constructor TgtPDFFont.Create(AFont: TFont; AFontObjRef: Integer;
   AIsCID: Boolean; ASubset: Boolean; ACharset: Boolean);
begin
  FFont := TFont.Create;
  FFont.Assign(AFont);
  FFontInfo := TgtPDFFontInfo.Create(FFont);
  FFontInfo.FfiFontObjRef := AFontObjRef;
  FillFontMetrics(ASubset, ACharset);
  SetBaseFont;
  (*
    If TrueType Font.
      If Charset isnot ANSI_CHARSET and Font Subsetting is false,
      Read CMap & Widths.
  *)
  FSubset := ASubset;

  if AIsCID then
    FFontEncoding := feCID
  else
    FFontEncoding := feWinAnsi;

  // As of v3.0, text processing is not dependent on charset
  // All used TrueType fonts are encoded as CID fonts with text string processed
  // as Unicode string
  if (FFontInfo.FfiType = ftTrueType) {and (not IsAnsiCharset or FSubset)} then
  begin
    FCID := TList.Create;
    FCharCode := TList.Create;
    FWidths := TList.Create;
    if FFontEncoding = feWinAnsi then
    begin
      //Only for subset embedding, in WINANSI encoding, CMAP table is required
      if FSubset then
        GetFontCMapDetails;
//    ReadGlyphWidths;
    end;
  end
  else
  begin
    FCID := nil;
    FCharCode := nil;
    FWidths := nil;

//     FCID := TList.Create;
//    FCharCode := TList.Create;
//    FWidths := TList.Create;
  end;

  if (FFontInfo.FfiType = ftTrueType) and (FSubset) then
    FIncludedCharCode := TList.Create
  else
    FIncludedCharCode := nil;

  FFirstGlyph := MaxInt;
  FLastGlyph := 0;
  (* Subsetting. *)
  FOutFont := nil;
  FGlyfOut := nil;
  FLocaOut := nil;
  FAvailableTables := TStringList.Create;
  FUsedGlyphs := TStringList.Create;
  FIsIdentityH := True;
end;

destructor TgtPDFFont.Destroy;
var
  LI: Integer;
  LInstalledFont: TgtInstalledFont;
begin
  if FCID <> nil then
    FreeAndNil(FCID);

  if FCharCode <> nil then
    FreeAndNil(FCharCode);

  if FIncludedCharCode <> nil then
    FreeAndNil(FIncludedCharCode);

  if FWidths <> nil then
    FreeAndNil(FWidths);

  FreeAndNil(FFont);
  FreeAndNil(FFontInfo);
  if Assigned(FInstalledFontList) then
  begin
    for LI := 0 to FInstalledFontList.Count - 1 do
    begin
      LInstalledFont := TgtInstalledFont(FInstalledFontList[LI]);
      LInstalledFont.Free;
    end;
    FreeAndNil(FInstalledFontList);
  end;

  if (Assigned(FAvailableTables)) then
    FreeAndNil(FAvailableTables);

  if Assigned(FUsedGlyphs) then
    FreeAndNil(FUsedGlyphs);

  SetLength(FLocaTable, 0);

  inherited;
end;

procedure TgtPDFFont.FillFontMetrics(ASubset: Boolean; ACharset: Boolean);
var
  LFont: TFont;
	LDC: HDC;
	LSaveFont: HFont;
	LTM: TTextMetric;
	LOTM: TOutlineTextmetric;
	LSaveMM: Integer;
  LogF: Cardinal;

	procedure FillCharWidths;
	var
		LI: Integer;
		LSize: TSize;
		LC: String;
	begin
		LSize.cx := 0;
		LSize.cy := 0;
 	  with FFontInfo do
    begin
      (*

      *)
      if FfiIsFixedPitch and (not ASubset) then
      begin
        LC := Char(Low(FfiWidths));
        GetTextExtentPoint32(LDC, PChar(LC), 1, LSize);
        FfiMaxWidth := Round(PixelsToPoints(LSize.cx));
      end;
      for LI := Low(FfiWidths) to High(FfiWidths) do
      begin
        LC := Chr(LI);
        GetTextExtentPoint32(LDC, PChar(LC), 1, LSize);
        FfiWidths[LI] := Round(PixelsToPoints(LSize.cx));
      end;
    end;
	end;

  (* Get Pitch & Family of Font *)
	function GetPDFFontFlags: Integer;
	begin
    Result := 0;
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
	end;

begin
	LFont := TFont.Create;
	with FFontInfo do
    try
			with LFont do
			begin
				Charset := FFont.Charset;
				Name :=  FFont.Name;
				Size := 1000;
				Pitch := FFont.Pitch;
				Style := FFont.Style;
			end;
			LDC := GetDC(0);
			LSaveMM := GetMapMode(LDC);
			SetMapMode(LDC, MM_TEXT);
			//LSaveFont := SelectObject(LDC, LFont.Handle);
      if FFont.Name = 'Symbol' then
      begin
        LogF := CreateFont(LFont.Height, TextSize('W', LFont).cx, 0, 0, FW_REGULAR,
          0, 0, 0, SYMBOL_CHARSET, OUT_TT_ONLY_PRECIS, CLIP_DEFAULT_PRECIS,
          DEFAULT_QUALITY, FF_DONTCARE, PChar('Symbol'));
        LSaveFont := SelectObject(LDC, LogF);
      end
      else
        LSaveFont := SelectObject(LDC, LFont.Handle);
			GetTextMetrics(LDC, LTM);
			with LTM do
			begin
        if (tmPitchAndFamily and TMPF_TRUETYPE <> 0) and IsTrueType(ACharset) then
          FfiType := ftTrueType
        else if ((tmPitchAndFamily and TMPF_FIXED_PITCH <> 0) and
          (tmPitchAndFamily and TMPF_VECTOR <> 0) and
          (tmPitchAndFamily and TMPF_DEVICE <> 0)) then
          FfiType := ftType1;

        if ((tmPitchAndFamily and TMPF_FIXED_PITCH) = 0) then
          FfiIsFixedPitch := True;
        (*
          If it is fixed-pitch font, no need to calculate widths for
          each character.
          Just set any one character width to FfiMaxWidth.
        *)
        FillCharWidths;

				FfiFlags := GetPDFFontFlags;
				FfiAscent := (tmAscent / CPixelsPerInch) * CInchesToPoints;
				FfiDescent := -(Abs(tmDescent) / CPixelsPerInch) * CInchesToPoints;
				FfiCapHeight := (tmAscent / CPixelsPerInch) * CInchesToPoints;
				FfiAvgWidth := tmAveCharWidth div CPixelsPerInch * CInchesToPoints;
        FfiFontWeight :=tmWeight ;
        if not FfiIsFixedPitch then
				  FfiMaxWidth := tmMaxCharWidth div CPixelsPerInch * CInchesToPoints;
				FfiFontBBox := Rect(
					FfiFontBBox.Left,
					Round(FfiAscent),
					FfiMaxWidth,
					Round(FfiDescent));
        (*
          Checking
            (tmPitchAndFamily and TMPF_TRUETYPE) <> 0
          does not indicate properly whether the font is TrueType.
          To test try setting the font to Courier (COURE.FON).
        *)
        if FfiType = ftTrueType then
				begin
					GetOutlineTextMetrics(LDC, SizeOf(LOTM),  @LOTM);
					with LOTM do
					begin
						// Required in degrees but function returns in tenths of a degree.
						FfiItalicAngle := otmItalicAngle div 10;
						FfiStemV := 78;
						FfiStrikeoutSize := (((otmsStrikeoutSize / CPixelsPerInch)
							 * CInchesToPoints) * FFont.Size / 1000);
						FfiStrikeoutPosition := (((otmsStrikeoutPosition /
							CPixelsPerInch) * CInchesToPoints) * FFont.Size / 1000);
						FfiUnderscoreSize := (((otmsUnderscoreSize / CPixelsPerInch)
							 * CInchesToPoints) * FFont.Size / 1000);
						FfiUnderscorePosition := (((otmsUnderscorePosition /
							CPixelsPerInch) * CInchesToPoints) * FFont.Size / 1000);
					end;
				end;
				SetMapMode(LDC, LSaveMM);
				SelectObject(LDC, LSaveFont);
				ReleaseDC(0, LDC);
			end;
		finally
			FreeAndNil(LFont);

		end;
end;

function TgtPDFFont.SetBaseFont: String;
const
(* Required for mapping to Adobe Standard 14 fonts. *)
  Std14Fonts : array[0..13] of String = (
    'Times-Roman', 'Times-Bold', 'Times-Italic', 'Times-BoldItalic',
    'Helvetica', 'Helvetica-Bold', 'Helvetica-Oblique', 'Helvetica-BoldOblique',
    'Courier', 'Courier-Bold', 'Courier-Oblique', 'Courier-BoldOblique',
    'Symbol', 'ZapfDingbats');
var
(* Required for mapping to Adobe Standard 14 fonts. *)
  LDC : HDC;
  LTextMetric : TTextMetric;
  LI : Integer;
begin
  FBaseFont := '';
  if (FFontInfo.FfiType = ftTrueType) or (FFontInfo.FfiType = ftType1) then
  begin
	  FBaseFont := ReplaceString(FFont.Name, ' ', '');
    if FFont.Name <> 'Symbol' then
    begin
      if (fsBold in FFont.Style) or (fsItalic in FFont.Style) then
        FBaseFont := FBaseFont + ',';
      if (fsBold in FFont.Style) then
        FBaseFont := FBaseFont + 'Bold';
      if (fsItalic in FFont.Style) then
        FBaseFont := FBaseFont + 'Italic';
    end;
  end
  else
  (* Return Mapped Adobe Standard 14 Type1 Font Name. *)
  begin
    with FFont do
    begin
      for LI := Low(Std14Fonts) to High(Std14Fonts) do
      begin
        if FFont.Name = Std14Fonts[LI] then
        begin
          FBaseFont := Std14Fonts[LI];
          Exit;
        end;
      end;
      if (FFont.Charset = SYMBOL_CHARSET) then
      begin
        FBaseFont := Std14Fonts[13];
        Exit;
      end;
      if (FFont.Charset <> ANSI_CHARSET) and
        ((FFont.Charset <> DEFAULT_CHARSET) and (GetACP <> CANSIWinCode)) then
      begin
        FBaseFont := Std14Fonts[12];
        Exit;
      end;
      LDC := GetDC(0);
      SelectObject(LDC, FFont.Handle);
      GetTextMetrics(LDC, LTextMetric);
      ReleaseDC(0, LDC);
      LI := -1;
      with LTextMetric do
      begin
        (* Courier New. *)
        if ((tmPitchAndFamily and TMPF_FIXED_PITCH = 0) or
          (tmPitchAndFamily and FF_MODERN = FF_MODERN)) then
          LI := 11;

        (* Times. *)
        if (tmPitchAndFamily and FF_ROMAN = FF_ROMAN) then
          LI := 3;

        (* MS Sans Serif. *)
        if (tmPitchAndFamily and FF_SWISS = FF_SWISS) then
          LI := 7;

        if tmItalic = 0  then
          LI := LI - 2;
        if tmWeight < FW_BOLD then
          LI := LI - 1;

        if LI < 0 then
          FBaseFont := FFont.Name
        else
          FBaseFont := Std14Fonts[LI];
      end; (* End with LTextMetric *)
    end; (* End with FFont. *)
  end;
end;

procedure TgtPDFFont.SetFontEncoding(const Value: TgtFontEncoding);
begin
  FFontEncoding := Value;
end;

procedure TgtPDFFont.SetIsIdentityH(const Value: Boolean);
begin
  FIsIdentityH := Value;
end;

procedure TgtPDFFont.GetFontFile2(var AStream: TMemoryStream);
var
  LDC: HDC;
  LFontStream, LogF: Cardinal;
  LI, LNameTblOffset : Integer;
  LStream: TgtExtMemStream;
  LOffsets: array of Integer;
  LFontTable: Integer;
  LFontName : string;
const
  CTTCF = $66637474;

  procedure ReadOffsets(AStream: TgtExtMemStream);
  var
    LNoOfFonts: Integer;
    I : Integer;
  begin
    AStream.Seek(0, {$IFDEF gtDelphi6UP} soBeginning {$ELSE} soFromBeginning {$ENDIF});
    AStream.SkipBytes(8); //skip tag and version
    LNoOfFonts := AStream.ReadLong;
    SetLength(LOffsets, LNoOfFonts);
    for I := 0 to LNoOfFonts-1 do
      Loffsets[I] := AStream.ReadLong() ;

  end;

  function ReadNameTable(AStream: TgtExtMemStream; AOffset: Integer): Integer;
  var
    LTable: String;
    LTableCount: Integer;
    I: Integer;
  begin
    AStream.Position := AOffset;
    AStream.Seek(AOffset, {$IFDEF gtDelphi6UP} soBeginning {$ELSE} soFromBeginning {$ENDIF});
    LTable := '';
    Result := -1;

    (* Skip TT signature *)
    AStream.SkipBytes(4);

    LTableCount := AStream.ReadUShort;

   (*
      Skip - searchRange, entrySelector & rangeShift.
    *)
    AStream.SkipBytes(6);
    for I := 0 to LTableCount - 1 do
    begin
      LTable := string(AStream.ReadString(4));
      if(LTable = 'name') then
      begin
        AStream.ReadULong;
        Result := AStream.ReadULong;
       // Result := LTblOffset;
        Break;
      end
      else
        AStream.SkipBytes(12);
    end;
  end;

  function ReadFontBaseName(AStream: TgtExtMemStream; AOffset: Integer): String;
  var
    LCount, LStringOffset, I: Integer;
    LPlatformID, LNameID, LLength, LOffset: Integer;
  begin
    AStream.Seek(AOffset + 2, {$IFDEF gtDelphi6UP} soBeginning {$ELSE} soFromBeginning {$ENDIF});
    LCount := AStream.ReadShort;
    LStringOffset := AStream.ReadShort;
    for I := 0 to LCount - 1 do
    begin
      LPlatformID := AStream.ReadShort;
      AStream.SkipBytes(4);
      LNameID := AStream.ReadShort;
      LLength := AStream.ReadShort;
      LOffset := AStream.ReadShort;
      if(LNameID = 6) then
      begin
        AStream.Seek(AOffset + LStringOffset + LOffset, {$IFDEF gtDelphi6UP} soBeginning {$ELSE} soFromBeginning {$ENDIF});
        if (LPlatformID = 0) or (LPlatformID = 3)  then
        begin
           Result := Result +  String(AStream.ReadString(LLength));
           Exit;
        end
        else
        begin
          Result := String(AStream.ReadString(LLength));
          Exit;
        end;
      end
    end;
  end;
begin
  if FFontInfo.FfiType <> ftTrueType then
    Exit;

  LDC := GetDC(0);
  if (FFont.Name = 'Symbol') or (FFont.Name = 'Wingdings') or
    (FFont.Name = 'Wingdings 2') or (FFont.Name = 'Wingdings 3') or
    (FFont.Name = 'Webdings') or (FFont.Name = 'Marlett') then
  begin
    LogF := CreateFont(FFont.Height, TextSize('W', FFont).cx, 0, 0, FW_REGULAR,
      0, 0, 0, SYMBOL_CHARSET, OUT_TT_ONLY_PRECIS, CLIP_DEFAULT_PRECIS,
      DEFAULT_QUALITY, FF_DONTCARE, PChar(FFont.Name));
    SelectObject(LDC, LogF);
  end
  else
    SelectObject(LDC, FFont.Handle);

  LFontTable := CTTCF;

  //To know whether font is in TTC or in TTF:
  //If Font is contained in TTC file, then it enters if block.
  //else if it is in ttf file, then LFontStream = GDI_ERROR and enters
  //else block.
  LFontStream := GetFontData(LDC, LFontTable, 0, nil, 0);
  if LFontStream <> GDI_ERROR then
  begin
    LStream := TgtExtMemStream.Create;
    LStream.SetSize(LFontStream);
    GetFontData(LDC, LFontTable, 0, LStream.Memory, LFontStream);

    //To get the FOffset value. FOffset points to the offset value for the
    // selected font in the TTC stream.
    ReadOffsets(LStream);
    for LI := 0 to Length(LOffsets) - 1 do
    begin
      LNameTblOffset := ReadNameTable(LStream, LOffsets[LI]);
      //If font name matches with the name stored in 'name' table, then consider
      //its offset
      LFontName := ReadFontBaseName(LStream, LNameTblOffset);
      LFontName := ReplaceString(LFontName, '-', ' ');
      if(LFontName = FFont.Name) then
      begin
        FOffset := LOffsets[LI];
        Break;
      end;
    end;
    LStream.Seek(0, {$IFDEF gtDelphi6UP} soBeginning {$ELSE} soFromBeginning {$ENDIF});
    AStream.LoadFromStream(LStream);
    LStream.Free;
  end
  else
  begin
    // font will be in TTF file
    FOffset := 0;
    LFontTable := 0;
    LFontStream := GetFontData(LDC, LFontTable, 0, nil, 0);
    if LFontStream <> GDI_ERROR then
    begin
      AStream.SetSize(LFontStream);
      GetFontData(LDC, LFontTable, 0, AStream.Memory, LFontStream);
    end
  end;
  ReleaseDC(0, LDC);
end;

function TgtPDFFont.IsTrueType(ACharset: Boolean): Boolean;
var
  LDC: HDC;
// LI, LJ: Integer;
  LI :LongWord;
  LJ :TFontCharset;
  LList: TList;
  LogF: Cardinal;
begin
  Result := False;
  LDC := GetDC(0);
//  SelectObject(LDC, FFont.Handle);
  if (FFont.Name = 'Symbol') or (FFont.Name = 'Wingdings') or
    (FFont.Name = 'Wingdings 2') or (FFont.Name = 'Wingdings 3') or
    (FFont.Name = 'Webdings') or (FFont.Name = 'Marlett') then
  begin
    LogF := CreateFont(FFont.Height, TextSize('W', FFont).cx, 0, 0, FW_REGULAR,
      0, 0, 0, SYMBOL_CHARSET, OUT_TT_ONLY_PRECIS, CLIP_DEFAULT_PRECIS,
      DEFAULT_QUALITY, FF_DONTCARE, PChar(FFont.Name));
    SelectObject(LDC, LogF);
  end
  else
    SelectObject(LDC, FFont.Handle);
  //ToDo: Consider TTC also...
  LI := GetFontData(LDC, 0, 0, nil, 0);
  if (LI <> GDI_ERROR) then
  //if ((Cardinal(LI) <> GDI_ERROR) and (LI <> -1)) then
  begin
    Result := True;
    if (ACharset) then
    begin
      LJ := FFont.Charset;
      if (LJ = DEFAULT_CHARSET) then
        LJ := ACPCharset;
      LList := TList.Create;
      try
        GetSupportedCharSets(FFont.Name, LList);
        // Charset is Default, Font supports ONE charset only
        if ((FFont.Charset = DEFAULT_CHARSET) and (LList.Count = 1)) then
        begin
          FFont.Charset := Integer(LList.Items[0]);
          Result := True;
        end
        else
          Result := (LList.IndexOf(TObject(LJ)) <> -1);
      finally
        LList.Free;
      end;
    end;
  end;
  ReleaseDC(0, LDC);
end;

function TgtPDFFont.IsEqual(AFont: TFont): Boolean;
begin
  Result := False;
  with FFont do
  begin
    if (Name = AFont.Name) and
      (((fsBold in Style) and (fsBold in AFont.Style)) or
        (not (fsBold in Style) and not (fsBold in AFont.Style))) and
      (((fsItalic in Style) and (fsItalic in AFont.Style)) or
        (not (fsItalic in Style) and not (fsItalic in AFont.Style))) then
      Result := True;
  end;
end;

procedure TgtPDFFont.AddUsedGlyphs(AText: WideString;
  AGlyphList: TgtGlyphInfoList);
var
  I: Integer;
  LCIDGlyphInfo: TgtGlyphInfo;
	P: PWideChar;
begin
  for I := 0 to AGlyphList.Count - 1 do
  begin
    LCIDGlyphInfo := AGlyphList[I];
    if (FCID.IndexOf(TObject(LCIDGlyphInfo.ID)) <> -1) then
      Continue;
    FCID.Add(TObject(LCIDGlyphInfo.ID));
    if (FUsedGlyphs.IndexOf(IntToStr(LCIDGlyphInfo.ID)) = -1) then
      FUsedGlyphs.Add(IntToStr(LCIDGlyphInfo.ID));
    FCharCode.Add(TObject(Ord(AText[I + 1])));
    P := @AText[I + 1];
    if FSubset and (P^ <> ' ') and
      (FIncludedCharCode.IndexOf(TObject(Ord(P^))) = -1) then
      FIncludedCharCode.Add(TObject(Ord(P^)));
    FWidths.Add(TObject(Round(PixelsToPoints(LCIDGlyphInfo.AdvWidth))));
    FFirstGlyph := Min(FFirstGlyph, LCIDGlyphInfo.ID);
    FLastGlyph := Max(FLastGlyph, LCIDGlyphInfo.ID);
  end;
end;

(*
function TgtPDFFont.GetCIDFontDictionary(
  AFontDescriptorRef: String): String;
var
  LI: Integer;
  LWidths: String;
begin
  LWidths := '';

  if not FFontInfo.FfiIsFixedPitch then
  begin
    for LI := 0 to FCID.Count - 1 do
    begin
      LWidths := LWidths + IntToStr(Integer(FCID[LI])) + '[' +
        IntToStr(Integer(FWidths[LI])) + ']';
    end;
  end;
  Result :=
    '/Type/Font' +
    '/Subtype/CIDFontType2';
  if FSubset then
    Result := Result +
      '/BaseFont/WYOIAS+' + BaseFont
  else
    Result := Result +
      '/BaseFont/' + BaseFont;
  Result := Result +
    '/FontDescriptor ' + AFontDescriptorRef +
    '/CIDSystemInfo' + '<<' +
    '/Registry(Adobe)'+
    '/Ordering(Identity)' +
    '/Supplement 0>>';
  if not FFontInfo.FfiIsFixedPitch then
    Result := Result +
      '/W [' + LWidths + ']';

  if FFontInfo.FfiIsFixedPitch then
  begin
    Result := Result +
      '/DW ' + IntToStr(Integer(FWidths[0])) +
      '/CIDToGIDMap/Identity';
  end
  else
  begin
    Result := Result +
      '/DW ' + IntToStr(FFontInfo.FfiMaxWidth) +
      '/CIDToGIDMap/Identity';
  end;
end;

*)
function TgtPDFFont.GetCIDFontDictionary(
  AFontDescriptorRef: String; Registry, AOrdering: String): String;
var
  LWidths: String;
begin
  LWidths := GetWidths;
  Result :=
    '/Type/Font' +
    '/Subtype/CIDFontType2';
  if FSubset then
    Result := Result +
      '/BaseFont/WYOIAS+' + BaseFont
  else
    Result := Result +
      '/BaseFont/' + BaseFont;
  Result := Result +
    '/FontDescriptor ' + AFontDescriptorRef +
    '/CIDSystemInfo' + '<<' +
    '/Registry' + Registry +
    '/Ordering' + AOrdering +
    '/Supplement 0>>';
  if not FFontInfo.FfiIsFixedPitch then
    Result := Result +
      '/W [' + LWidths + ']';

  if (FFontInfo.FfiIsFixedPitch) and (FWidths[0]<>nil) then
// if (FFontInfo.FfiIsFixedPitch)  then
  begin
    Result := Result +
      '/DW ' + IntToStr(Integer(FWidths[0])) +
      '/CIDToGIDMap/Identity';
  end
  else
  begin
    Result := Result +
      '/DW ' + IntToStr(FFontInfo.FfiMaxWidth) +
      '/CIDToGIDMap/Identity';
  end;
end;

function TgtPDFFont.GetCIDFontOrderingEntry: String;
begin
  Result := 'Identity';
end;

function TgtPDFFont.GetCIDFontRegistryEntry: String;
begin
  Result := 'Adobe';
end;

procedure TgtPDFFont.GetCMap(AMemStream: TMemoryStream);
var
  LI: Integer;
  LATemp : AnsiString;
begin
  if FCID.Count = 0 then Exit;
  FPDFCMap :=
    '/CIDInit /ProcSet findresource begin' + CRLF +
    '12 dict begin' + CRLF +
    'begincmap' + CRLF +
    '/CIDSystemInfo'+CRLF+ '<<' +
      '/Registry(Adobe)/Ordering(UCS)/Supplement 0>> def' + CRLF +
    '/CMapName /Adobe-Identity-UCS def' + CRLF +
    '/CMapType 2 def' + CRLF +
    '1 begincodespacerange' + CRLF +
    '<' + IntToHex(FFirstGlyph, 4) +
    '><' + IntToHex(FLastGlyph, 4) + '>' + CRLF +
    'endcodespacerange' + CRLF +
    IntToStr(FCID.Count) + ' beginbfrange' + CRLF;
  for LI := 0 to FCID.Count - 1 do
  begin
    FPDFCMap := FPDFCMap +  '<' + IntToHex(Integer(FCID.Items[LI]), 4) +
      '><' + IntToHex(Integer(FCID.Items[LI]), 4) + '>' +
      '<'+ IntToHex(Integer(FCharCode.Items[LI]), 4) + '>'+ CRLF ;
  end;
  FPDFCMap := FPDFCMap +
    'endbfrange' + CRLF +
    'endcmap' + CRLF +
    'CMapName currentdict /CMap defineresource pop' + CRLF +
    'end end';
  LATemp := AnsiString(FPDFCMap);
  AMemStream.Write(LATemp[1], Length(FPDFCMap));
end;

procedure TgtPDFFont.GetFontCMapDetails;
var
	LStream, LCMapStream: TgtExtMemStream;
	LI, LJ, LCharCode, LNoOfTables, LGlyphIDSize, idROIndex: Integer;
  LOffset, LTableLength: Int64;
  LPlatId, LPlatSpecId, LSegCount, GlyphIndex: Word; // UShort
	EndCount, StartCount, idDelta, idRangeOffset, GlyphID: array of Word;

  LTable: AnsiString;
begin
  LCMapStream := nil;

	LStream := TgtExtMemStream.Create;
	try
    GetFontFile2(TMemoryStream(LStream));
    (* Read CMap. *)
    SetLength(LTable, 4);
    (* Skip Version.*)
    LStream.SkipBytes(4);
    (* Read No. of Tables Directories. *)
    LNoOfTables := LStream.ReadUShort;
    (* Move to start of Table Directory entries. *)
    LStream.Position := 12;
    LI := -1;

    (*
      Loop to get cmap Offset & Length.
      Finally Obtain CMap stream.
    *)
    repeat
      LTable := LStream.ReadString(4);

      if (LTable = 'cmap') then
      begin
        (* Skip Checksum *)
        LStream.SkipBytes(4);
        (* Get CMap table Offset, Length. *)
        LOffset := LStream.ReadULong;
        LTableLength := LStream.ReadULong;
        (* Move to cmap table content. *)
        LStream.Position := LOffset;

        (* Copy CMap Content. *)
        LCMapStream := TgtExtMemStream.Create;
        LCMapStream.CopyFrom(LStream, LTableLength);
        Break;
      end;
      (* Did not find cmap. Skip Checksum, Offset & Length *)
      LStream.SkipBytes(12);
      Inc(LI);
    until (LI = LNoOfTables);
	finally
		FreeAndNil(LStream);
	end;

  (* If CMap table found. *)
  if (LCMapStream <> nil) then
  begin
    try
      (* Skip Table version no. (0) *)
      LCMapStream.Position := 2;
      (* Read No. of encoding tables. *)
      LNoOfTables := LCMapStream.ReadUShort;
      LOffset := -1;
      (* Loop through encoding table to find CMap31. *)
      for LI := 0 to LNoOfTables do
      begin
        LPlatId := LCMapStream.ReadUShort;
        LPlatSpecId := LCMapStream.ReadUShort;
        if (((LPlatId = 3) and (LPlatSpecId = 1))) then
        begin
          (* Get Format 4 Offset. *)
          LOffset := LCMapStream.ReadULong;
          Break;
        end
        else if (((LPlatId = 3) and (LPlatSpecId = 0))) then
        begin
          (* Get Format 4 Offset. *)
          LOffset := LCMapStream.ReadULong;
          Break;
        end
        else
          LCMapStream.SkipBytes(4); //Skip Offset
      end;
      if (LOffset <> -1) then
      begin
        //(* Get Format 4 Offset. *)
        //LOffset := LCMapStream.ReadULong;
          (* Move to Format 4 Subtable. *)
          LCMapStream.Position := LOffset;
          (* Skip Format no. (4) *)
          LCMapStream.SkipBytes(2);

          (* Read Format 4 Subtable Length. *)
          LTableLength := LCMapStream.ReadUShort;
          (* Skip Version. *)
          LCMapStream.SkipBytes(2);

          (* Read Segment Count. *)
          LSegCount := LCMapStream.ReadUShort div 2;
          (* Skip searchRange, entrySelector & rangeShift. *)
          LCMapStream.SkipBytes(6);

          (* Read endCount. *)
          SetLength(EndCount, SizeOf(Word) * LSegCount);
          for LJ := 0 to LSegCount - 1 do
            EndCount[LJ] := LCMapStream.ReadUShort;

          (* Skip reservedPad. *)
          LCMapStream.SkipBytes(2);

          (* Read startCount. *)
          SetLength(StartCount, SizeOf(Word) * LSegCount);
          for LJ := 0 to LSegCount - 1 do
            StartCount[LJ] := LCMapStream.ReadUShort;

          (* Read idDelta. *)
          SetLength(idDelta, SizeOf(Word) * LSegCount);
          for LJ := 0 to LSegCount - 1 do
            idDelta[LJ] := LCMapStream.ReadUShort;

          (* Read idRangeOffset. *)
          SetLength(idRangeOffset, SizeOf(Word) * LSegCount);
          for LJ := 0 to LSegCount - 1 do
            idRangeOffset[LJ] := LCMapStream.ReadUShort;

          (*
            LTableLength div 2 - Table length in Words.
            SegCount * 4 - No. of Words occupied by ||ll arrays
            8 - No. of Words occupied by other entries.

            GlyphIDSize - No. of Word entries in GlyphID array.
          *)
          LGlyphIDSize := LTableLength div 2 - 8 - LSegCount * 4;
          SetLength(GlyphID, LGlyphIDSize);
          for LJ := 0 to LGlyphIDSize - 1 do
            GlyphID[LJ] := LCMapStream.ReadUShort;

          (* Obtain Character Code -> Glyph Index (CMap) list. *)
          (* Loop through the different segments. *)
          for LJ := 0 to LSegCount - 1 do
          begin
            (* Loop through start -> end character codes in current segment. *)
            for LCharCode := StartCount[LJ] to EndCount[LJ] do
            begin
              (* If final Character Code exit. *)
              if LCharCode = $FFFF then
                Break;
              if (idRangeOffset[LJ] = 0) then
                GlyphIndex := (LCharCode + idDelta[LJ]) and $FFFF
              else
			        begin
                idROIndex := LJ + idRangeOffset[LJ] div 2 - LSegCount +
                  LCharCode - StartCount[LJ];
				        GlyphIndex := (GlyphID[idROIndex] + idDelta[LJ]) mod $FFFF;
			        end;
              FCID.Add(TObject(GlyphIndex));
              FCharCode.Add(TObject(LCharCode));
            end;
          end;
        //Break;
      end;
        //else
          //LCMapStream.SkipBytes(4); //Skip Offset
      //end;
    finally
      FreeAndNil(LCMapStream);
    end;
  end;
end;

function TgtPDFFont.GetFontDescriptor(AFontFile2Obj: String): String;
begin
  with FFontInfo do
  begin
    Result :=
      '/Type/FontDescriptor';
    if FSubset then
      Result := Result +
        '/FontName/WYOIAS+' + BaseFont
    else
      Result := Result +
        '/FontName/' + BaseFont;
    Result := Result +
      '/Flags ' + IntToStr(FfiFlags) +
      Format('/FontBBox [%d %d %d %d]', [FfiFontBBox.Left, FfiFontBBox.Bottom,
        FfiFontBBox.Right, FfiFontBBox.Top]) +
      '/Ascent ' + FloatToStrLocale(FfiAscent) +
      '/Descent ' + FloatToStrLocale(FfiDescent) +
      '/CapHeight ' + FloatToStrLocale(FfiCapHeight) +
      '/AvgWidth ' + IntToStr(FfiAvgWidth) +
      '/MaxWidth ' + IntToStr(FfiMaxWidth) +
      '/MissingWidth ' + IntToStr(FfiMaxWidth) +
      '/StemV ' + IntToStr(FfiStemV) +
      '/ItalicAngle ' + IntToStr(FfiItalicAngle)+
      '/FontWeight '+IntToStr(FfiFontWeight);
    if AFontFile2Obj <> '' then
      Result := Result +
      '/FontFile2 ' + AFontFile2Obj;
    Result := Result + CRLF;
  end;
end;

procedure TgtPDFFont.GetFontFile2Subset(var AStream: TgtExtMemStream);
begin
  (* Get Original Font Stream. *)
  GetFontFile2(TMemoryStream(AStream));

  SubsetInitialize;
  ReadTable(AStream);
  ReadLocaTable(AStream);
  ReadCompositeGlyph(AStream);
  if (WriteLocaAndGlyf(AStream))and (FTableOutCount>0) then
    WriteTable(AStream);
  (*
    Subset successful: Copy subset font stream.
    Subset UnSuccessful: Copy whole font stream.
  *)
  if (FOutFont.Size > 0) and (FOutFont.Size < AStream.Size) then
  begin
    AStream.Clear;
    FOutFont.Position := 0;
    AStream.CopyFrom(FOutFont, 0);
  end;
  SubsetFinalize;
end;

function TgtPDFFont.GetType0FontDictionary(AFontNo: Integer;
  AUnicodeObjRef, ADesFontObjRef: String): String;
begin
  Result :=
    '/Type/Font' +
    '/Subtype/Type0' +
    '/Name/F' + IntToStr(AFontNo);
    if FSubset then
      Result := Result +
        '/BaseFont/WYOIAS+' + BaseFont
    else
      Result := Result +
        '/BaseFont/' + BaseFont;
    if FIsIdentityH then
      Result := Result + '/Encoding/Identity-H'
    else
       Result := Result + '/Encoding/Identity-V';

    Result := Result +

    '/ToUnicode ' + AUnicodeObjRef +
    '/DescendantFonts [' + ADesFontObjRef + ']' + CRLF;
end;

function TgtPDFFont.GetWidths: String;
var
  LI : Integer;
begin
  Result := '';

  if not FFontInfo.FfiIsFixedPitch then
  begin
    for LI := 0 to FCID.Count - 1 do
    begin
      Result := Result + IntToStr(Integer(FCID[LI])) + '[' +
        IntToStr(Integer(FWidths[LI])) + ']';
    end;
  end;

end;
function TgtPDFFont.IsEqual(AFont: TFont; AEncoding: TgtFontEncoding;
      AIsIdentityH: Boolean): Boolean;
begin
  Result := False;
  with FFont do
  begin
    if (Name = AFont.Name) and
      (((fsBold in Style) and (fsBold in AFont.Style)) or
        (not (fsBold in Style) and not (fsBold in AFont.Style))) and
      (((fsItalic in Style) and (fsItalic in AFont.Style)) or
        (not (fsItalic in Style) and not (fsItalic in AFont.Style))) and
       (FFontEncoding = AEncoding) and (AIsIdentityH = FIsIdentityH)
       then
      Result := True;
  end;

end;

function TgtPDFFont.IsTableNeeded(AString: String): Boolean;
var
  I : Integer;
begin
  (*
    For Non-ANSI_CHARSET fonts, cmap will be written seperately.
    Hence cmap is not required in subsetted font.
  *)
  for I := 0 to High(FRequiredTables) do begin
    Result := (AString = FRequiredTables[I]);
    if Result then
      Break;
  end;
end;

procedure TgtPDFFont.ReadTable(AStream: TgtExtMemStream);
var
  LInt: Integer;
  LI, LJ: Word;
  LTableCount: Integer;
  LTable: String;
begin
  AStream.Position := FOffset;
  AStream.Seek(FOffset, {$IFDEF gtDelphi6UP} soBeginning {$ELSE} soFromBeginning {$ENDIF});
  LTable := '';

  (* Skip TT signature *)
  AStream.SkipBytes(4);

  LTableCount := AStream.ReadUShort;

  SetLength(FTableOffset, Length(FRequiredTables));
  SetLength(FTableLength, Length(FRequiredTables));
  SetLength(FTableChecksum, Length(FRequiredTables));
  FTableOutCount := 0;

  (*
    Skip - searchRange, entrySelector & rangeShift.
  *)
  AStream.SkipBytes(6);

  LI := 0;
  for LJ := 0 to LTableCount - 1 do begin
    LTable := String(AStream.ReadString(4));
    if IsTableNeeded(LTable) then
    begin
      Inc(FTableOutCount);
      FAvailableTables.Add(LTable);

      FTableChecksum[LI] := AStream.ReadULong;
      FTableOffset[LI] := AStream.ReadULong;
      FTableLength[LI] := AStream.ReadULong;

      LInt := AStream.Position;

      if (LTable = 'glyf') then
        FGlyfOffset := FTableOffset[LI]
      else if (LTable = 'loca') then
        FLocaOffset := FTableOffset[LI]
      else if (LTable = 'head') then begin
        AStream.Position := FTableOffset[LI];

        AStream.SkipBytes(4);

        (* Check if Local table offset is Long/Short. *)
        (* Position to read indexToLocFormat field of head. *)
        AStream.Position := FTableOffset[LI] + FTableLength[LI] - 4;
        (*
          indexToLocFormat =  0 : Short Offset Loca Table.
                              1 : Long Offset Loca Table.
        *)
        FLocaIsLong := (AStream.ReadUShort = 1);
      end
      else if (LTable = 'maxp') then
      begin
        (* Get no. of glyphs in font. *)

        AStream.Position := FTableOffset[LI];
        (* Skip Version. *)
        AStream.SkipBytes(4);
        FNumGlyphs := AStream.ReadUShort;

        AStream.Position := FTableOffset[LI];
      end
      else
        AStream.Position := FTableOffset[LI];

      AStream.Position := LInt;
      Inc(LI);
    end
    else
      AStream.SkipBytes(12);
  end;
end;

procedure TgtPDFFont.SetSubset(const Value: Boolean);
begin
  FSubset := Value;
end;

procedure TgtPDFFont.SubsetFinalize;
begin
  FreeAndNil(FOutFont);
  FreeAndNil(FGlyfOut);
  FreeAndNil(FLocaOut);
end;

procedure TgtPDFFont.SubsetInitialize;
begin
  FOutFont := TgtExtMemStream.Create;
  FGlyfOut := TgtExtMemStream.Create;
  FLocaOut := TgtExtMemStream.Create;
  (*
    Table Directories -
    'DSIG', 'GDEF', 'GSUB', 'JSTF', 'LTSH', 'OS/2', 'PCLT', 'VDMX', 'cmap',
    'cvt ', 'fpgm', 'gasp', 'glyf', 'hdmx', 'head', 'hhea', 'hmtx', 'kern',
    'loca', 'maxp', 'name', 'post', 'prep'
  *)
  (* Table Directories required for PDF. *)

  FRequiredTables[0] := 'cmap';
  FRequiredTables[1] := 'cvt ';
  FRequiredTables[2] := 'fpgm';
  FRequiredTables[3] := 'glyf';
  FRequiredTables[4] := 'head';
  FRequiredTables[5] := 'hhea';
  FRequiredTables[6] := 'hmtx';
  FRequiredTables[7] := 'loca';
  FRequiredTables[8] := 'maxp';
  FRequiredTables[9] := 'prep';

  FTableOutCount := High(FRequiredTables) + 1;
end;



procedure TgtPDFFont.ReadCompositeGlyph(AStream: TgtExtMemStream);
var
  LI, LGlyphIndex: Integer;
  LFlags, LCompositeGlyph, LBytesToSkip: Integer;
  LGlyphPos : Cardinal;
  LNumberOfContours: Integer;

const
		ARG_1_AND_2_ARE_WORDS = 1; //constants for composite glyf checking
		WE_HAVE_A_SCALE = 8;
		MORE_COMPONENTS = 32;
		WE_HAVE_AN_X_AND_Y_SCALE = 64;
		WE_HAVE_A_TWO_BY_TWO = 128;

begin
  if FUsedGlyphs.Count = 0 then
    Exit;

  for LI := 0 to FUsedGlyphs.Count -1 do
  begin
    if LI = FNumGlyphs then
      Break;
    (*
      If required character write it.
    *)
    LGlyphIndex := StrToIntDef(FUsedGlyphs[LI], -1);
    if (LGlyphIndex <> -1) then
    begin
      AStream.Position := FLocaOffset +
        Cardinal(LGlyphIndex * gtUtils3.IfThen(FLocaIsLong, Integer(4), Integer(2)));

      (*
        Read numberOfContours from glyph table.
        numberOfContours >=    0      : Single Glyph.
                              -ve(-1) : Composite Glyph.
        *)
      if FLocaIsLong then
      begin
        LGlyphPos := FGlyfOffset + FLocaTable[LGlyphIndex];
      end
      else
       begin
        LGlyphPos := FGlyfOffset + (FLocaTable[LGlyphIndex] * 2);
      end;
        AStream.Position := LGlyphPos;

      LNumberOfContours := AStream.ReadShort;
      if LNumberOfContours = -1 then //it is a composite glyph
      begin
        AStream.SkipBytes(8);
        while(true) do
        begin
				  LFlags := AStream.ReadUShort();
				  LCompositeGlyph := AStream.ReadUShort();
          if (FUsedGlyphs.IndexOf(IntToStr(LCompositeGlyph)) = -1) then
             FUsedGlyphs.Add(IntToStr(LCompositeGlyph));

				  if ((LFlags and  MORE_COMPONENTS) = 0) then
          begin
            Break;
          end;
          if (LFlags and ARG_1_AND_2_ARE_WORDS) <> 0 then
            LBytesToSkip := 4
          else
            LBytesToSkip := 2;

				  if ((LFlags and WE_HAVE_A_SCALE) <> 0) then
            LBytesToSkip := LBytesToSkip + 2
				  else if ((LFlags and WE_HAVE_AN_X_AND_Y_SCALE) <> 0) then
            LBytesToSkip := LBytesToSkip + 4;
				  if ((LFlags and WE_HAVE_A_TWO_BY_TWO) <> 0) then
            LBytesToSkip := LBytesToSkip + 8;
          AStream.SkipBytes(LBytesToSkip);
        end;
      end
    end; (* End if (required glyph check)*)
  end; (* End for *)
  FUsedGlyphs.Sort;
end;

procedure TgtPDFFont.ReadLocaTable(AStream: TgtExtMemStream);
var
  LI: Word;
begin
  Setlength(FLocaTable, FNumGlyphs + 1);
  for LI := 0 to FNumGlyphs do
  begin
    if LI = FNumGlyphs then
      Break;

    AStream.Position := FLocaOffset +
      (LI * Cardinal(gtUtils3.IfThen(FLocaIsLong,Integer(4),Integer(2))));

    if FLocaIsLong then
      FLocaTable[LI] := AStream.ReadULong
    else
      FLocaTable[LI] := AStream.ReadUShort
  end;
end;

function TgtPDFFont.WriteLocaAndGlyf(AStream: TgtExtMemStream): Boolean;
var
  LI : Word;
  LIndex: Integer;
  LGlyphLen, LGlyphPos : Cardinal;
begin
  Result := True;
  for LI := 0 to FNumGlyphs do
  begin
    if FLocaIsLong then
      FLocaOut.WriteULong(FGlyfOut.Size)
    else
      FLocaOut.WriteUShort(FGlyfOut.Size div 2);

    if LI = FNumGlyphs then
      Break;

    (*
      If required character write it.
    *)
    LIndex := FUsedGlyphs.IndexOf(IntToStr(LI));
    if (LIndex <> -1) then
    begin
      FUsedGlyphs.Delete(LIndex);
      AStream.Position := FLocaOffset +
        (LI * Cardinal(gtUtils3.IfThen(FLocaIsLong,Integer(4),Integer(2))));
      (*
        Get Starting and end position of the required glyph based on
        Long/Short loca table.
      *)
      if FLocaIsLong then begin
        LGlyphLen := FLocaTable[LI + 1] - FLocaTable[LI];
        LGlyphPos := FGlyfOffset + FLocaTable[LI];
      end
      else
      begin
        LGlyphLen := (FLocaTable[LI + 1] - FLocaTable[LI]) * 2;
        LGlyphPos := FGlyfOffset + (FLocaTable[LI] * 2);
      end;
      AStream.Position := LGlyphPos;
      if LGlyphLen > 0 then
        FGlyfOut.CopyFrom(AStream, LGlyphLen);
    end; (* End if (required glyph check)*)
  end; (* End for *)
end;

procedure TgtPDFFont.WriteTable(AStream: TgtExtMemStream);
var
  LI : Word;
  ChecksumAdj, LDataOffset, LHeadOffset, LLen:  Int64 ;
begin
  LHeadOffset := 0;
  LDataOffset := 16 * FTableOutCount + 12;
  FOutFont.WriteULong($00010000);
  FOutFont.WriteUShort(FTableOutCount);
  LI := Trunc(IntPower(2, Trunc(Log2(FTableOutCount))) * 16) and $FFFF;
  FOutFont.WriteUShort(LI); // SearchRange
  LI := Trunc(Log2(IntPower(2, Trunc(Log2(FTableOutCount))))) and $FFFF;
  FOutFont.WriteUShort(LI); // EntrySelector
  LI := (FTableOutCount * 16) -
    (Trunc(IntPower(2, Trunc(Log2(FTableOutCount))) * 16) and $FFFF);
  FOutFont.WriteUShort(LI); // RangeShift
  for LI := 0 to (FAvailableTables).Count -1 do
  begin
    if (FAvailableTables[LI] = 'glyf') then begin
      FGlyfOut.Position := 0;
      FGlyfOut.PadTo4Bytes;
      LLen := FGlyfOut.Size - FGlyfOut.PadSize;
    end
    else if (FAvailableTables[LI] = 'loca') then begin
      FLocaOut.Position := 0;
      FLocaOut.PadTo4Bytes;
      LLen := FLocaOut.Size - FLocaOut.PadSize;
    end
    else begin
      LLen := FTableLength[LI];
    end;
    FOutFont.WriteString(AnsiString(FAvailableTables[LI]));
      FOutFont.WriteULong(FTableChecksum[LI]);
      FOutFont.WriteULong(LDataOffSet);
    LDataOffSet := LDataOffSet + LLen +
      Round(gtUtils3.IfThen((LLen mod 4) = 0, 0,
        (4 - (LLen mod 4))));
    FOutFont.WriteULong(LLen);
    end;
  for LI := 0 to (FAvailableTables).Count-1 do
  begin
    if (FAvailableTables[LI] = 'glyf') then begin
      FGlyfOut.Position := 0;
  FOutFont.CopyFrom(FGlyfOut, 0);
    end
    else if (FAvailableTables[LI] = 'loca') then begin
      FLocaOut.Position := 0;
  FOutFont.CopyFrom(FLocaOut, 0);
    end
    else
    begin
      AStream.Position := FTableOffset[LI];
      FOutFont.CopyFrom(AStream, FTableLength[LI]);
      FOutFont.PadTo4Bytes;
    end;
  end;

  ChecksumAdj := 0;
  FOutFont.Position := 0;
  //check sum adjustment in "head" table
  while (FOutFont.Position < FOutFont.Size) do begin
    ChecksumAdj := (ChecksumAdj + FOutFont.ReadULong) and $FFFFFFFF;
  end;
  //overwrite in "head" table
  FOutFont.Position := LHeadOffset;
  FOutFont.SkipBytes(8);
  FOutFont.WriteULong(ChecksumAdj);
end;

{ TgtPDFFontInfo }

constructor TgtPDFFontInfo.Create(AFont: TFont);
begin
  FfiFlags := 0;
  FfiFontBBox := Rect(-250, -200, 1000, 900);
  FfiAscent := 800;
  FfiDescent := -200;
  FfiCapHeight  := 700;
  FfiAvgWidth := 576;
  FfiMaxWidth := 576;
  FfiStemV := 0;
  FfiItalicAngle := 0;
  FfiFontWeight :=400;
  FfiStrikeoutSize := AFont.Size div 20;
  FfiStrikeoutPosition := Abs(AFont.Height) div 5;
  FfiUnderscoreSize := AFont.Size div 10;
  FfiUnderscorePosition := -1;
  FfiType := ftTrueType;
  FfiIsFixedPitch := False;
  // V3.0 - Not used for CID fonts and all fonts are now encoded as CID fonts, so
  // we won't set it to any value
{  for LI := Low(FfiWidths) to High(FfiWidths) do
    FfiWidths[LI] := 600;}
end;

{ TgtInstalledFont }

procedure TgtInstalledFont.SetFilePath(const Value: string);
begin
  FFilePath := Value;
end;

procedure TgtInstalledFont.SetString(const Value: string);
begin
  FString := Value;
end;

procedure TgtInstalledFont.SetStyle(const Value: TFontStyles);
begin
  FStyle := Value;
end;

initialization
 ACPCharset := GetACPCharset;

end.

