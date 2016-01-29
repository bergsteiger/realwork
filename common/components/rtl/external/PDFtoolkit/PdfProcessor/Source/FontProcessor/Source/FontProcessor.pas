unit FontProcessor;

{$I ..\..\Utils\gtCompilerDefines.inc}

interface

uses
  Windows, Graphics, SysUtils, Classes, FreeType,
  FreeTypeImport, ftTypes, ftGlyph, ftImage, uAlphablend,
  ftCache, ftcCache, ftcSBits, ftcImage, ftcCMap, Math;

type
//  {Forward declaraction}
//  TgtFontProcessor = class;

  TgtRect = record
    Left,
      Top,
      Right,
      Bottom: Double;
  end;


  TPDFFontFlags = (pfSerif, pfSans, pfSymbol, pfScript);

  TgtPointsList = array of Double;

  TShortIntArray = array of ShortInt;

{$IFDEF VCL6ORABOVE}
  TGlyphType = (
    gtCharacterCode = 0,
    gtGlyphIndex = 1,
    gtGlyphName = 2
    );
{$ENDIF}

{$IFDEF DELPHI5}
  TGlyphType = Integer;
  const
    gtCharacterCode = 0;
    gtGlyphIndex = 1;
    gtGlyphName = 2;
{$ENDIF}

type
{$IFDEF VCL6ORABOVE}
  ErrorCodes = (Success = 0,
    CannotOpenResource = 1,
    UnknownFileFormat = 2,
    BrokenFile = 3,
    InvalidFreeTypeVersion = 4,
    ModuleVersionIsTooLow = 5,
    InvalidArgument = 6,
    UnimplementedFeature = 7,
    BrokenTable = 8,
    BrokenOffsetWithinTable = 9,
    InvalidGlyphIndex = 16,
    InvalidCharacterCode = 17,
    UnsupportedGlyphImageFormat = 18,
    CannotRenderThisGlyphFormat = 19,
    InvalidOutline = 20,
    InvalidCompositeGlyph = 21,
    TooManyHints = 22,
    InvalidPixelSize = 23,

                //self
    InvalidFontObject = 24,
    NoWindowsCharacterMapFound = 25,
    NotAnOutlineGlyph = 26,
    FaceIndexOutOfBounds = 27,

    InvalidObjectHandle = 32,
    InvalidLibraryHandle = 33,
    InvalidModuleHandle = 34,
    InvalidFaceHandle = 35,
    InvalidSizeHandle = 36,
    InvalidGlyphSlotHandle = 37,
    InvalidCharmapHandle = 38,
    InvalidCacheManagerHandle = 39,
    InvalidStreamHandle = 40,

    TooManyModules = 48,
    TooManyExtensions = 49,

    OutOfMemory = 64,
    UnlistedObject = 65,

    CannotOpenStream = 81,
    InvalidStreamSeek = 82,
    InvalidStreamSkip = 83,
    InvalidStreamRead = 84,
    InvalidStreamOperation = 85,
    InvalidFrameOperation = 86,
    NestedFrameAccess = 87,
    InvalidFrameRead = 88,

    RasterUninitialized = 96,
    RasterCorrupted = 97,
    RasterOverflow = 98,
    NegativeHeightWhileRastering = 99,

    TooManyRegisteredCaches = 112,

    InvalidOpcode = 128,
    TooFewArguments = 129,
    StackOverflow = 130,
    CodeOverflow = 131,
    BadArgument = 132,
    DivisionByZero = 133,
    InvalidReference = 134,
    FoundDebugOpcode = 135,
    FoundENDFOpcodeInExecutionStream = 136,
    NestedDEFS = 137,
    InvalidCodeRange = 138,
    ExecutionContextTooLong = 139,
    TooManyFunctionDefinitions = 140,
    TooManyInstructionDefinitions = 141,
    SFNTFontTableMissing = 142,
    HorizontalHeader_hhea_TableMissing = 143,

    Locations_loca_TableMissing = 144,
    NameTableMissing = 145,
    CharacterMap_cmap_TableMissing = 146,
    HorizontalMetrics_hmtx_TableMissing = 147,
    PostScript_post_TableMissing = 148,
    InvalidHorizontalMetrics = 149,
    InvalidCharacterMap_cmap_Format = 150,
    InvalidppemValue = 151,
    InvalidVerticalMetrics = 152,
    CouldNotFindContext = 153,
    InvalidPostScript_post_TableFormat = 154,
    InvalidPostScript_post_Table = 155,

    OpcodeSyntaxError = 160,
    ArgumentStackUnderflow = 161,
    Ignore = 162,

    STARTFONT_FieldMissing = 176,
    FONT_FieldMissing = 177,
    SIZE_FieldMissing = 178,
    CHARS_FieldMissing = 179,
    STARTCHAR_FieldMissing = 180,
    ENCODING_FieldMissing = 181,
    BBX_FieldMissing = 182);
{$ENDIF}

{$IFDEF DELPHI5}
  ErrorCodes = Integer;
  const
    Success = 0;
    CannotOpenResource = 1;
    UnknownFileFormat = 2;
    BrokenFile = 3;
    InvalidFreeTypeVersion = 4;
    ModuleVersionIsTooLow = 5;
    InvalidArgument = 6;
    UnimplementedFeature = 7;
    BrokenTable = 8;
    BrokenOffsetWithinTable = 9;
    InvalidGlyphIndex = 16;
    InvalidCharacterCode = 17;
    UnsupportedGlyphImageFormat = 18;
    CannotRenderThisGlyphFormat = 19;
    InvalidOutline = 20;
    InvalidCompositeGlyph = 21;
    TooManyHints = 22;
    InvalidPixelSize = 23;

                //self
    InvalidFontObject = 24;
    NoWindowsCharacterMapFound = 25;
    NotAnOutlineGlyph = 26;
    FaceIndexOutOfBounds = 27;

    InvalidObjectHandle = 32;
    InvalidLibraryHandle = 33;
    InvalidModuleHandle = 34;
    InvalidFaceHandle = 35;
    InvalidSizeHandle = 36;
    InvalidGlyphSlotHandle = 37;
    InvalidCharmapHandle = 38;
    InvalidCacheManagerHandle = 39;
    InvalidStreamHandle = 40;

    TooManyModules = 48;
    TooManyExtensions = 49;

    OutOfMemory = 64;
    UnlistedObject = 65;

    CannotOpenStream = 81;
    InvalidStreamSeek = 82;
    InvalidStreamSkip = 83;
    InvalidStreamRead = 84;
    InvalidStreamOperation = 85;
    InvalidFrameOperation = 86;
    NestedFrameAccess = 87;
    InvalidFrameRead = 88;

    RasterUninitialized = 96;
    RasterCorrupted = 97;
    RasterOverflow = 98;
    NegativeHeightWhileRastering = 99;

    TooManyRegisteredCaches = 112;

    InvalidOpcode = 128;
    TooFewArguments = 129;
    StackOverflow = 130;
    CodeOverflow = 131;
    BadArgument = 132;
    DivisionByZero = 133;
    InvalidReference = 134;
    FoundDebugOpcode = 135;
    FoundENDFOpcodeInExecutionStream = 136;
    NestedDEFS = 137;
    InvalidCodeRange = 138;
    ExecutionContextTooLong = 139;
    TooManyFunctionDefinitions = 140;
    TooManyInstructionDefinitions = 141;
    SFNTFontTableMissing = 142;
    HorizontalHeader_hhea_TableMissing = 143;

    Locations_loca_TableMissing = 144;
    NameTableMissing = 145;
    CharacterMap_cmap_TableMissing = 146;
    HorizontalMetrics_hmtx_TableMissing = 147;
    PostScript_post_TableMissing = 148;
    InvalidHorizontalMetrics = 149;
    InvalidCharacterMap_cmap_Format = 150;
    InvalidppemValue = 151;
    InvalidVerticalMetrics = 152;
    CouldNotFindContext = 153;
    InvalidPostScript_post_TableFormat = 154;
    InvalidPostScript_post_Table = 155;

    OpcodeSyntaxError = 160;
    ArgumentStackUnderflow = 161;
    Ignore = 162;

    STARTFONT_FieldMissing = 176;
    FONT_FieldMissing = 177;
    SIZE_FieldMissing = 178;
    CHARS_FieldMissing = 179;
    STARTCHAR_FieldMissing = 180;
    ENCODING_FieldMissing = 181;
    BBX_FieldMissing = 182;
{$ENDIF}

  type
  TFontFileType = (fftNormal, fftBold, fftItalic);

  TFontFileTypes = set of TFontFileType;

  TWidthArray = array of Double;

  TFontProcessorCacheCollectionItem = class(TCollectionItem)
  private
    FFileName: AnsiString;
    FFontByteArray: TShortIntArray;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    property FileName: AnsiString read FFileName write FFileName;
  end;

  TFontProcessorCacheCollection = class(TCollection)
  private
    FFTCacheManager: PFTC_Manager;
    //FFTCSBitCache: PFTC_SBitCache;
    //FFTCImageCache: PFTC_ImageCache;
    FFTLibrary: PFT_Library;
    FMaxFaces: Integer;
    FMaxSizes: Integer;
    FMaxBytes: Integer;
    function FindFile(AFileName: AnsiString): TFontProcessorCacheCollectionItem;
  public
    constructor Create(AFTLibrary: PFT_Library; AMaxFaces: Integer; AMaxSizes: Integer; AMaxBytes: Integer);
    destructor Destroy; override;
    function GetItemFace(AItem: TFontProcessorCacheCollectionItem): PFT_Face;
    function GetItemFaceSize(AItem: TFontProcessorCacheCollectionItem; ASizeX, ASizeY: Integer): PFT_Face;
    function GetFileFace(AFileName: AnsiString): PFT_Face; overload;
    function GetFileFaceSize(AFileName: AnsiString; ASizeX, ASizeY: Integer): PFT_Face; overload;
    function GetFileFace(ByteArray: TShortIntArray): PFT_Face; overload;
    function GetFileFaceSize(ByteArray: TShortIntArray; ASizeX, ASizeY: Integer): PFT_Face; overload;
  end;


  TgtOnDrawChar = procedure(AGlyphPoints: TgtPointsList; AdvanceWidth, AdvanceHeight: Double;
    EvenOddFill: Boolean; ReverseFill: Boolean) of object;

  TPFont = class
  public
    FFilepathname: AnsiString;
    FFace_index: Integer;
    FCmap_index: Integer;
    FNum_indices: Integer;
    FFile_address: Pointer;
    FFile_size: Integer;
  end;

  TGlyphMetrics = record
    Height: Double;
  end;

  TgtFontProcessor = class
  private
    FAscent: Double;
    FCharMapCount: Integer;
    FDescent: Double;
    FFaceCount: Integer;
    FFontFileName: AnsiString;
    FFamilyName: AnsiString;
    FFontStreamArray: TShortIntArray;
    FFontStream: TMemoryStream;
    FBBox: TgtRect;
    FGlyphCount: Integer;
    FLeading: Double;
//  FForceBold: Boolean;
//  FFontDirectory: AnsiString;
    FUseKerning: Boolean;
    FpsName: AnsiString;
    FstyleName: AnsiString;
    FunderscorePosition: Double;
    FunderscoreSize: Double;
    FunitsPerEm: Double;
    FEncodingType: TFT_Encoding;
    FPreviousGlyphIndex: Cardinal;
    FGlyphWidths: TgtPointsList;
    FFirstCharCode, FLastCharCode: Integer;
//  num_glyph_indices: Integer;
    FHorzRes: Cardinal;
    FVertRes: Cardinal;
    FCapHeight: Double;
    FStemV: Double;
    FMaxWidth: Integer;
    FAvgWidth: Double;
    FItalicAngle: TFT_Long;
    FFlag: Integer;
    FFontSize: Cardinal;
    FCBox: TFT_BBox;
    FNextXPos: Double;
    FKerningValue: Double;

    FFacePtr: PFT_Face;
    FPS_FontInfoRecPtr: PPS_FontInfoRec;
    FPS_PrivateRecPtr: PPS_PrivateRec;
    FCurrent_font: TPFont;
    FlibPtr: PFT_Library;
//  FGlyphFormat: TFT_Glyph_Format;
//  FTCacheManager: PFTC_Manager;
//  FTCMapCache: PFTC_CMapCache;
//  FTCSBitCache: PFTC_SBitCache;
//  FTCImageCache: PFTC_ImageCache;
//  FEncoding: TFT_Encoding;
    FFontCache: TFontProcessorCacheCollection;

    procedure SetFlagBit(ABit: Byte);
    procedure ClearFontDetails;
    function get_Ascent: Double;
    function get_CharacterMapCount: Integer;
    function get_Descent: Double;
    function get_FaceCount: Integer;
    function get_FamilyName: AnsiString;
    function get_GlobalBBox: TgtRect;
    function get_Leading: Double;
    function get_PostscriptName: AnsiString;
    function get_StyleName: AnsiString;
    function get_UnderscorePosition: Double;
    function get_UnderscoreSize: Double;
    function get_UnitsPerEm: Double;
    function get_EncodingType: TFT_Encoding;

    procedure set_EncodingType(AEncodingType: TFT_Encoding);
    //function GetFaceCount(fileName: AnsiString): Integer; overload;
    //function GetFaceCount(byteArray: TShortIntArray): Integer; overload;
//    function GetFaceCount(memStream: TMemoryStream): Integer; overload;
    function InitFace(faceIndex: Integer): ErrorCodes;
    function InitLibrary: ErrorCodes;
//    function CopyFrom(SourceArray: TShortIntArray; out DestinationArray: TShortIntArray;
//      Index: Integer): Integer;
    function gtRect(Left, Top, Right, Bottom: Double): TgtRect;
    procedure GetItalicAngle;
    procedure LoadFontDetails(AFacePtr: PFT_Face);
    procedure GetGlyphWidths;
    function GetCharSize(ACharCode: Integer; AFacePtr: PFT_Face): TSize;
    procedure InitializeFace(var AFontCache: TFontProcessorCacheCollection; var AFacePtr: PFT_Face);
    procedure FinializeFace(var AFontCache: TFontProcessorCacheCollection; var AFacePtr: PFT_Face);
    function SetCharmap(ACharCode: Integer; out AGlyphIndex: Cardinal; AFacePtr: PFT_Face): ErrorCodes;
    function GetFontStream: TMemoryStream;
    function DecomposeOutlineGlyph(ACharCode: Cardinal; APointSize: Integer;
      out AGlyphPoints: TgtPointsList; out AdvanceWidth, AdvanceHeight: Double;
      out EvenOddFill: Boolean; out ReverseFill: Boolean; AFacePtr: PFT_Face): ErrorCodes; overload;

  protected
    property UseKerning: Boolean read FUseKerning write FUseKerning default False;
  public
    constructor Create(AFileName: AnsiString; APointSize: Integer;
      AHorzRes, AVertRes: Cardinal; out errorCode: ErrorCodes); overload;
    constructor Create(AStream: TStream; APointSize: Integer;
      AHorzRes, AVertRes: Cardinal; out errorCode: ErrorCodes); overload;
    constructor Create(aFont: TFont; out ErrorCode: ErrorCodes); overload;
    destructor Destroy; override;

    function GetTextWidth(AText: WideString): Double;
    function GetTextHeight(AText: AnsiString): Double;
    function DecomposeOutlineGlyph(AText: WideString; APointSize: Integer;
      AUseKerning: Boolean; ADrawCharCallback: TgtOnDrawChar; AGlyphType: TGlyphType): ErrorCodes; overload;

    function DecomposeOutlineGlyph(AText: WideString; APointSize: Integer;
      var ACurX, ACurY: Double; ADrawCharCallback: TgtOnDrawChar): ErrorCodes; overload;

    function DecomposeOutlineGlyph(AText: WideString; APointSize: Integer;
      var ACurX, ACurY: Double; AUseKerning: Boolean;
      ADrawCharCallback: TgtOnDrawChar; AGlyphType: TGlyphType): ErrorCodes; overload;

    function DecomposeOutlineGlyph(ACharCode, AGlyphIndex :Cardinal; const AGlyphName: AnsiString;
      APointSize: Integer; out AGlyphPoints: TgtPointsList;
      out AdvanceWidth, AdvanceHeight: Double; out EvenOddFill: Boolean;
      out ReverseFill: Boolean; AGlyphType: TGlyphType): ErrorCodes; overload;

//    function DecomposeOutlineGlyph(ACharCode: Cardinal; APointSize: Integer;
//      out AGlyphPoints: TgtPointsList; out AdvanceWidth, AdvanceHeight: Double;
//      out EvenOddFill: Boolean; out ReverseFill: Boolean): ErrorCodes; overload;

    property Flag: Integer read FFlag;
    property GlyphWidths: TgtPointsList read FGlyphWidths;
    property FirstCharCode: Integer read FFirstCharCode;
    property LastCharCode: Integer read FLastCharCode;
    property Ascent: Double read get_Ascent;
    property CharacterMapCount: Integer read get_CharacterMapCount;
    property Descent: Double read get_Descent;
    property FaceCount: Integer read get_FaceCount;
    property FamilyName: AnsiString read get_FamilyName;
    property GlobalBBox: TgtRect read get_GlobalBBox;
    property Leading: Double read get_Leading;
    property PostscriptName: AnsiString read get_PostscriptName;
    property StyleName: AnsiString read get_StyleName;
    property UnderscorePosition: Double read get_UnderscorePosition;
    property UnderscoreSize: Double read get_UnderscoreSize;
    property UnitsPerEm: Double read get_UnitsPerEm;
    property EncodingType: TFT_Encoding read get_EncodingType write set_EncodingType;
    property HorzRes: Cardinal read FHorzRes write FHorzRes;
    property VertRes: Cardinal read FVertRes write FVertRes;
    property CapHeight: Double read FCapHeight;
    property StemV: Double read FStemV;
    property MaxWidth: Integer read FMaxWidth;
    property ItalicAngle: TFT_Long read FItalicAngle;
    property AvgWidth: Double read FAvgWidth;
    property FontStream: TMemoryStream read GetFontStream;
  end;



implementation

const

  PathSeparator = '\';
var
  LPoints: array of Double;
  LCount: Integer;
  LHeight: Integer;


function OnOutlineMoveTo(ATo: PFT_Vector; AUser: Pointer): Integer; cdecl;
var
  LCurLen: Integer;
begin
  LCurLen := Length(LPoints);
  Inc(LCount, 3);
  SetLength(LPoints, LCount);
  LPoints[LCurLen] := 1;
  LPoints[LCurLen + 1] := TFT_Vector(ATo^).X / 64;
  LPoints[LCurLen + 2] := (LHeight - TFT_Vector(ATo^).Y) / 64;
  Result := 0;
end;

function OnOutlineLineTo(ATo: PFT_Vector; AUser: Pointer): Integer; cdecl;
var
  LCurLen: Integer;
begin
  LCurLen := Length(LPoints);
  Inc(LCount, 3);
  SetLength(LPoints, LCount);
  LPoints[LCurLen] := 2;
  LPoints[LCurLen + 1] := TFT_Vector(ATo^).X / 64;
  LPoints[LCurLen + 2] := (LHeight - TFT_Vector(ATo^).Y) / 64;
  Result := 0;
end;

function OnOutlineConicTo(AControl: PFT_Vector; ATo: PFT_Vector; AUser: Pointer): Integer; cdecl;
var
  LCurLen: Integer;
begin
  LCurLen := Length(LPoints);
  Inc(LCount, 5);
  SetLength(LPoints, LCount);
  LPoints[LCurLen] := 3;
  LPoints[LCurLen + 1] := TFT_Vector(AControl^).X / 64;
  LPoints[LCurLen + 2] := (LHeight - TFT_Vector(AControl^).Y) / 64;
  LPoints[LCurLen + 3] := TFT_Vector(ATo^).X / 64;
  LPoints[LCurLen + 4] := (LHeight - TFT_Vector(ATo^).Y) / 64;
  Result := 0;
end;

function OnOutlineCubicTo(AControl1: PFT_Vector; AControl2: PFT_Vector; ATo: PFT_Vector; AUser: Pointer): Integer; cdecl;
var
  LCurLen: Integer;
begin
  LCurLen := Length(LPoints);
  Inc(LCount, 7);
  SetLength(LPoints, LCount);
  LPoints[LCurLen] := 4;
  LPoints[LCurLen + 1] := TFT_Vector(AControl1^).X / 64;
  LPoints[LCurLen + 2] := (LHeight - TFT_Vector(AControl1^).Y) / 64;
  LPoints[LCurLen + 3] := TFT_Vector(AControl2^).X / 64;
  LPoints[LCurLen + 4] := (LHeight - TFT_Vector(AControl2^).Y) / 64;
  LPoints[LCurLen + 5] := TFT_Vector(ATo^).X / 64;
  LPoints[LCurLen + 6] := (LHeight - TFT_Vector(ATo^).Y) / 64;
  Result := 0;
end;

{ TgtFontProcessor }

procedure TgtFontProcessor.ClearFontDetails;
begin
  FpsName := '';
  FstyleName := '';
  FFamilyName := '';
  FUnitsPerEm := 0;
  FAscent := 0;
  FDescent := 0;
  FLeading := 0;
  FUnderscorePosition := 0;
  FUnderscoreSize := 0;
end;

(*
function TgtFontProcessor.CopyFrom(SourceArray: TShortIntArray; out DestinationArray: TShortIntArray;
  Index: Integer): Integer;
var
  LIndex, LI: Integer;
begin
  SetLength(DestinationArray, Length(SourceArray) - Index);
  LIndex := Index;
  for LI := Index to Length(SourceArray) do
  begin
    DestinationArray[LIndex] := SourceArray[LI];
    Inc(LIndex);
  end;
  Result := Length(DestinationArray);
end;
*)

function TgtFontProcessor.DecomposeOutlineGlyph(ACharCode: Cardinal; APointSize: Integer;
  out AGlyphPoints: TgtPointsList;
  out AdvanceWidth, AdvanceHeight: Double;
  out EvenOddFill, ReverseFill: Boolean; AFacePtr: PFT_Face): ErrorCodes;
var
  Lglyph: PFT_Glyph;
  LOutlineFunctions: TFT_Outline_Funcs;
  LOutline_Glyph: TFT_OutlineGlyph;
  LI, LJ: Integer;
  LGlyphIndex: Cardinal;
//  LPCharMap: PPFT_CharMap;
  LReturnValue: TFT_ERROR;
  Delta: TFT_Vector;
begin
  Result := Success;
  EvenOddFill := False;
  ReverseFill := False;
  AdvanceWidth := 0;
  AdvanceHeight := 0;
//  LGlyphIndex := 0;
//  LPCharMap := nil;

  LGlyphIndex := ACharCode;
  if (UseKerning and (FPreviousGlyphIndex <> 0) and (LGlyphIndex <> 0)) then
  begin
    FT_Get_Kerning(AFacePtr, FPreviousGlyphIndex, LGlyphIndex, 0, Delta);
    FKerningValue := FKerningValue + Delta.X / 64;
  end;
  FPreviousGlyphIndex := LGlyphIndex;
  // load glyph
  LReturnValue := FT_Load_Glyph(AFacePtr, LGlyphIndex, FT_LOAD_TARGET_NORMAL);
  if (LReturnValue = 0) then
  begin
    // extract glyph image
    LReturnValue := FT_Get_Glyph(AFacePtr.Glyph, Lglyph);
    if LReturnValue = 0 then
    begin
      if AFacePtr.glyph.format = FT_GLYPH_FORMAT_OUTLINE then
      begin
        LOutlineFunctions.move_to := @OnOutlineMoveTo;
        LOutlineFunctions.line_to := @OnOutlineLineTo;
        LOutlineFunctions.cubic_to := @OnOutlineCubicTo;
        LOutlineFunctions.conic_to := @OnOutlineConicTo;
        LOutlineFunctions.shift := 0;
        LOutlineFunctions.delta := 0;
        LOutline_Glyph := TFT_OutlineGlyph(Lglyph);
        LCount := 0;
        //LHeight := AFacePtr.size.metrics.ascender;
        FT_Glyph_Get_CBox(Lglyph, 3, FCBox);
        LReturnValue := FT_Outline_Decompose(LOutline_Glyph.outline, @LOutlineFunctions, nil);
        SetLength(AGlyphPoints, LCount);
        for LI := 0 to (LCount - 1) do
        begin
          AGlyphPoints[LI] := LPoints[LI];
        end;
        Finalize(LPoints);
        LJ := 0;
        while LJ < Length(AGlyphPoints) do
        begin
          case Round(AGlyphPoints[LJ]) of
            1:
              begin
                AGlyphPoints[LJ + 1] := AGlyphPoints[LJ + 1] + FKerningValue;
                Inc(LJ, 3);
              end;
            2:
              begin
                AGlyphPoints[LJ + 1] := AGlyphPoints[LJ + 1] + FKerningValue;
                Inc(LJ, 3);
              end;
            3:
              begin
                AGlyphPoints[LJ + 1] := AGlyphPoints[LJ + 1] + FKerningValue;
                AGlyphPoints[LJ + 3] := AGlyphPoints[LJ + 3] + FKerningValue;
                Inc(LJ, 5);
              end;
            4:
              begin
                AGlyphPoints[LJ + 1] := AGlyphPoints[LJ + 1] + FKerningValue;
                AGlyphPoints[LJ + 3] := AGlyphPoints[LJ + 3] + FKerningValue;
                AGlyphPoints[LJ + 5] := AGlyphPoints[LJ + 5] + FKerningValue;
                Inc(LJ, 7);
              end;
          end;
        end;
        AdvanceWidth := AFacePtr.glyph.advance.X / 64;
        AdvanceHeight := AFacePtr.glyph.advance.Y / 64;
        EvenOddFill := ((LOutline_Glyph.outline.flags and FT_OUTLINE_EVEN_ODD_FILL) <> 0);
        ReverseFill := ((LOutline_Glyph.outline.flags and FT_OUTLINE_REVERSE_FILL) <> 0);
      end
      else
        Result := NotAnOutlineGlyph;
    end
    else
      Result := ErrorCodes(LReturnValue);
    FT_Done_Glyph(Lglyph);
  end
  else
    Result := ErrorCodes(LReturnValue);
end;

function TgtFontProcessor.DecomposeOutlineGlyph(ACharCode,
  AGlyphIndex: Cardinal; const AGlyphName: AnsiString; APointSize: Integer;
  out AGlyphPoints: TgtPointsList; out AdvanceWidth, AdvanceHeight: Double;
  out EvenOddFill, ReverseFill: Boolean; AGlyphType: TGlyphType): ErrorCodes;
var
  LPCharMap: PPFT_CharMap;
  LI: Integer;
  LReturnValue: TFT_ERROR;
  LFontCache: TFontProcessorCacheCollection;
  LFacePtr: PFT_Face;
begin
  LFacePtr := nil;
  LFontCache := nil;
  FFontSize := APointSize;

  InitializeFace(LFontCache, LFacePtr);    //LFontCache & LFacePtr  memory allocated.

  case AGlyphType of
    gtCharacterCode:
    begin
      if (LFacePtr.num_charmaps = 0) then
        FT_Select_Charmap(LFacePtr, FT_ENCODING_UNICODE);

      if LFacePtr <> nil then
      begin
        LPCharMap := (LFacePtr.charmaps);

        for LI := 0 to (LFacePtr.num_charmaps - 1) do
        begin
          if PFT_CharMap(LPCharMap^).encoding <> FEncodingType then
          begin
            Inc(LPCharMap);
            continue;
          end;

          LReturnValue := FT_Set_Charmap(LFacePtr, PFT_CharMap(LPCharMap^));
          if LReturnValue = 0 then
            AGlyphIndex := FT_Get_Char_Index(LFacePtr, ACharCode)
          else
          begin
            Result := ErrorCodes(LReturnValue); Exit;
          end;
          if AGlyphIndex = 0 then
          begin
            Inc(LPCharMap);
            continue;
          end
          else
            break;
        end;
      end;
    end;
    gtGlyphIndex:
    begin
      //Do nothing
    end;
    gtGlyphName:
    begin
      AGlyphIndex := FT_Get_Name_Index(LFacePtr, @AGlyphName[1]);
    end;
  end;

  if ((AGlyphIndex = 0) and (AGlyphType <> gtGlyphIndex)) then
  begin
    Result := NoWindowsCharacterMapFound;
    Exit;
  end;

  Result := DecomposeOutlineGlyph(AGlyphIndex, APointSize, AGlyphPoints,
    AdvanceWidth, AdvanceHeight, EvenOddFill, ReverseFill, LFacePtr);

  FinializeFace(LFontCache, LFacePtr);
end;

function TgtFontProcessor.DecomposeOutlineGlyph(AText: WideString; APointSize: Integer;
  var ACurX, ACurY: Double; AUseKerning: Boolean;
  ADrawCharCallback: TgtOnDrawChar; AGlyphType: TGlyphType): ErrorCodes;
var
  LJ: Integer;
  LGlyphPoints: TgtPointsList;
  EOFill, RFill: Boolean;
  LNextYPos: Double;
  LAdvanceWidth, LAdvanceHeight: Double;
begin
  Result := Success;
  UseKerning := AUseKerning;
  LAdvanceWidth := 0;
  FKerningValue := 0;
  FNextXPos := ACurX;
  LNextYPos := ACurY;
//  FFontSize := APointSize;
//  for LI := 1 to Length(AText) do
//  begin
    SetLength(LGlyphPoints, 0);
    case AGlyphType of
      gtCharacterCode:
      begin
        Result := DecomposeOutlineGlyph(Ord(AText[1]), 0, '', APointSize, LGlyphPoints,
          LAdvanceWidth, LAdvanceHeight, EOFill, RFill, AGlyphType);
      end;
      gtGlyphIndex:
      begin
        Result := DecomposeOutlineGlyph(0, Ord(AText[1]), '', APointSize, LGlyphPoints,
          LAdvanceWidth, LAdvanceHeight, EOFill, RFill, AGlyphType);
      end;
      gtGlyphName:
      begin
        Result := DecomposeOutlineGlyph(0, 0, AText, APointSize, LGlyphPoints,
          LAdvanceWidth, LAdvanceHeight, EOFill, RFill, AGlyphType);
      end;
    end;

    if Result = Success then
    begin
      LJ := 0;
      while LJ < Length(LGlyphPoints) do
      begin
        case Round(lGlyphPoints[LJ]) of
          1:
            begin
              lGlyphPoints[LJ + 1] := lGlyphPoints[LJ + 1] + FNextXPos;
              lGlyphPoints[LJ + 2] := lGlyphPoints[LJ + 2] + LNextYPos;
              Inc(LJ, 3);
            end;
          2:
            begin
              lGlyphPoints[LJ + 1] := lGlyphPoints[LJ + 1] + FNextXPos;
              lGlyphPoints[LJ + 2] := lGlyphPoints[LJ + 2] + LNextYPos;
              Inc(LJ, 3);
            end;
          3:
            begin
              lGlyphPoints[LJ + 1] := lGlyphPoints[LJ + 1] + FNextXPos;
              lGlyphPoints[LJ + 2] := lGlyphPoints[LJ + 2] + LNextYPos;
              lGlyphPoints[LJ + 3] := lGlyphPoints[LJ + 3] + FNextXPos;
              lGlyphPoints[LJ + 4] := lGlyphPoints[LJ + 4] + LNextYPos;
              Inc(LJ, 5);
            end;
          4:
            begin
              lGlyphPoints[LJ + 1] := lGlyphPoints[LJ + 1] + FNextXPos;
              lGlyphPoints[LJ + 2] := lGlyphPoints[LJ + 2] + LNextYPos;
              lGlyphPoints[LJ + 3] := lGlyphPoints[LJ + 3] + FNextXPos;
              lGlyphPoints[LJ + 4] := lGlyphPoints[LJ + 4] + LNextYPos;
              lGlyphPoints[LJ + 5] := lGlyphPoints[LJ + 5] + FNextXPos;
              lGlyphPoints[LJ + 6] := lGlyphPoints[LJ + 6] + LNextYPos;
              Inc(LJ, 7);
            end;
        end;
      end;
      ADrawCharCallback(LGlyphPoints, LAdvanceWidth, LAdvanceHeight, EOFill, RFill);
      FNextXPos := FNextXPos + LAdvanceWidth;
      ACurX := FNextXPos;
      ACurY := LNextYPos;
    end;
//  end;
end;

function TgtFontProcessor.DecomposeOutlineGlyph(AText: WideString;
  APointSize: Integer; AUseKerning: Boolean; ADrawCharCallback: TgtOnDrawChar; AGlyphType: TGlyphType): ErrorCodes;
var
  LI, LJ: Integer;
  LGlyphPoints: TgtPointsList;
  EOFill, RFill: Boolean;
  LAdvanceWidth, LAdvanceHeight: Double;
begin
  Result := Success;
  UseKerning := AUseKerning;

  for LI := 1 to Length(AText) do
  begin
    SetLength(LGlyphPoints, 0);

    case AGlyphType of
      gtCharacterCode:
      begin
        Result := DecomposeOutlineGlyph(Ord(AText[LI]), 0, '', APointSize, LGlyphPoints,
          LAdvanceWidth, LAdvanceHeight, EOFill, RFill, AGlyphType);
      end;
      gtGlyphIndex:
      begin
        Result := DecomposeOutlineGlyph(0, Ord(AText[LI]), '', APointSize, LGlyphPoints,
          LAdvanceWidth, LAdvanceHeight, EOFill, RFill, AGlyphType);
      end;
      gtGlyphName:
      begin
        Result := DecomposeOutlineGlyph(0, 0, AText[LI], APointSize, LGlyphPoints,
          LAdvanceWidth, LAdvanceHeight, EOFill, RFill, AGlyphType);
      end;
    end;

    if Result = Success then
    begin
      LJ := 0;
      while LJ < Length(LGlyphPoints) do
      begin
        case Round(lGlyphPoints[LJ]) of
          1:
            begin
              lGlyphPoints[LJ + 1] := lGlyphPoints[LJ + 1] + FNextXPos;
              Inc(LJ, 3);
            end;
          2:
            begin
              lGlyphPoints[LJ + 1] := lGlyphPoints[LJ + 1] + FNextXPos;
              Inc(LJ, 3);
            end;
          3:
            begin
              lGlyphPoints[LJ + 1] := lGlyphPoints[LJ + 1] + FNextXPos;
              lGlyphPoints[LJ + 3] := lGlyphPoints[LJ + 3] + FNextXPos;
              Inc(LJ, 5);
            end;
          4:
            begin
              lGlyphPoints[LJ + 1] := lGlyphPoints[LJ + 1] + FNextXPos;
              lGlyphPoints[LJ + 3] := lGlyphPoints[LJ + 3] + FNextXPos;
              lGlyphPoints[LJ + 5] := lGlyphPoints[LJ + 5] + FNextXPos;
              Inc(LJ, 7);
            end;
        end;
      end;
      ADrawCharCallback(LGlyphPoints, LAdvanceWidth, LAdvanceHeight, EOFill, RFill);
      FNextXPos := FNextXPos + LAdvanceWidth;
    end;
  end;
end;

function TgtFontProcessor.DecomposeOutlineGlyph(AText: WideString;
  APointSize: Integer; var ACurX, ACurY: Double; ADrawCharCallback: TgtOnDrawChar): ErrorCodes;
var
  LI, LJ: Integer;
  LGlyphPoints: TgtPointsList;
  EOFill, RFill: Boolean;
  FNextXPos, LNextYPos: Double;
  LAdvanceWidth, LAdvanceHeight: Double;
begin
  Result := Success;
  FNextXPos := ACurX;
  LNextYPos := ACurY;
  for LI := 1 to Length(AText) do
  begin
    SetLength(LGlyphPoints, 0);
    Result := DecomposeOutlineGlyph(Ord(AText[LI]), 0, '', APointSize, LGlyphPoints,
      LAdvanceWidth, LAdvanceHeight, EOFill, RFill, gtCharacterCode);
    if Result = Success then
    begin
      LJ := 0;
      while LJ < Length(LGlyphPoints) do
      begin
        case Round(lGlyphPoints[LJ]) of
          1:
            begin
              lGlyphPoints[LJ + 1] := lGlyphPoints[LJ + 1] + FNextXPos;
              lGlyphPoints[LJ + 2] := lGlyphPoints[LJ + 2] + LNextYPos;
              Inc(LJ, 3);
            end;
          2:
            begin
              lGlyphPoints[LJ + 1] := lGlyphPoints[LJ + 1] + FNextXPos;
              lGlyphPoints[LJ + 2] := lGlyphPoints[LJ + 2] + LNextYPos;
              Inc(LJ, 3);
            end;
          3:
            begin
              lGlyphPoints[LJ + 1] := lGlyphPoints[LJ + 1] + FNextXPos;
              lGlyphPoints[LJ + 2] := lGlyphPoints[LJ + 2] + LNextYPos;
              lGlyphPoints[LJ + 3] := lGlyphPoints[LJ + 3] + FNextXPos;
              lGlyphPoints[LJ + 4] := lGlyphPoints[LJ + 4] + LNextYPos;
              Inc(LJ, 5);
            end;
          4:
            begin
              lGlyphPoints[LJ + 1] := lGlyphPoints[LJ + 1] + FNextXPos;
              lGlyphPoints[LJ + 2] := lGlyphPoints[LJ + 2] + LNextYPos;
              lGlyphPoints[LJ + 3] := lGlyphPoints[LJ + 3] + FNextXPos;
              lGlyphPoints[LJ + 4] := lGlyphPoints[LJ + 4] + LNextYPos;
              lGlyphPoints[LJ + 5] := lGlyphPoints[LJ + 5] + FNextXPos;
              lGlyphPoints[LJ + 6] := lGlyphPoints[LJ + 6] + LNextYPos;
              Inc(LJ, 7);
            end;
        end;
      end;
      ADrawCharCallback(LGlyphPoints, LAdvanceWidth, LAdvanceHeight, EOFill, RFill);
      FNextXPos := FNextXPos + (FFacePtr.glyph.advance.X / 64);
      ACurX := FNextXPos;
      ACurY := LNextYPos;
    end;
  end;
end;

destructor TgtFontProcessor.Destroy;
begin
  SetLength(FFontStreamArray, 0);
  SetLength(FGlyphWidths, 0);
  if (FFacePtr <> nil) then
  begin
    FT_Done_Face(FFacePtr);
    FFacePtr := nil;
  end;
  FT_Done_FreeType(FlibPtr);
  if Assigned(FFontStream) then
    FreeAndNil(FFontStream);
  FCurrent_font.Free;
  if Assigned(FFontCache) then
    FFontCache.Free;
end;

procedure TgtFontProcessor.FinializeFace(var
  AFontCache: TFontProcessorCacheCollection; var AFacePtr: PFT_Face);
begin
  if Assigned(AFontCache) then
    FreeAndNil(AFontCache);
  if Assigned(AFacePtr) then
  begin
    //FT_Done_Face(AFacePtr);
    //AFacePtr := nil;
  end;
end;

procedure GetScreenResolution(var AHorz, AVert: Integer);
var
  ldc: hdc;
begin
  ldc := GetDC(0);
  try
    AHorz := 0;
    AVert := 0;
    AHorz := GetDeviceCaps(ldc, LOGPIXELSX);
    AVert := GetDeviceCaps(ldc, LOGPIXELSY);
  finally
    ReleaseDC(0, lDC);
  end;
end;


//function TgtFontProcessor.GetFaceCount(fileName: AnsiString): Integer;
//var
//  num: Integer;
//  LfilenamePtr: PAnsiChar;
//  tempFace: PFT_Face;
//begin
//  if (FlibPtr = nil) then
//  begin
//    Result := 0;
//    exit;
//  end;
//  num := 0;
//  LfilenamePtr := @filename[1];
//  if (FT_New_Face(FlibPtr, LfilenamePtr, 0, tempFace) = 0) then
//  begin
//    num := tempFace.num_faces;
//    FT_Done_Face(tempFace);
//    tempFace := nil;
//  end;
//  Result := num;
//end;



function TgtFontProcessor.GetCharSize(ACharCode: Integer; AFacePtr: PFT_Face): TSize;
var
  LGlyphIndex: Cardinal;
begin
  //Result := 0;
  if AFacePtr <> nil then
  begin
    //Loads the FacePtr with Encoding Info.
    if SetCharmap(ACharCode, LGlyphIndex, AFacePtr) = Success then
    begin
      if FT_Load_Char(AFacePtr, ACharCode, FT_LOAD_TARGET_NORMAL) = 0 then
      begin
        Result.cx := Round(AFacePtr.glyph.metrics.HorzAdvance / 64 { / (AFacePtr.units_per_EM / 1000)});
        Result.cy := Round(AFacePtr.glyph.metrics.VertAdvance / 64 { / (AFacePtr.units_per_EM / 1000)});
      end;
//      if FT_Load_Char(AFacePtr, ACharCode, FT_LOAD_TARGET_NORMAL) = 0 then
//      begin
//        Result.cx := Round(((( AFacePtr.glyph.advance.X + $8000 ) shr 16) ) / 64 { / (AFacePtr.units_per_EM / 1000)});
//        Result.cy := Round(((( AFacePtr.glyph.advance.Y + $8000 ) shr 16) ) / 64 { / (AFacePtr.units_per_EM / 1000)});
//      end;
    end;
  end;
end;

(*
function TgtFontProcessor.GetFaceCount(memStream: TMemoryStream): Integer;
var
  buffer: TShortIntArray;
begin
  if (FlibPtr = nil) then
  begin
    Result := 0;
    exit;
  end;
  SetLength(buffer, memStream.Size);
  memStream.Position := 0;
  memStream.Read(buffer, memStream.Size);
  begin
    Result := GetFaceCount(buffer);
    exit;
  end;
end;

*)

procedure TgtFontProcessor.GetGlyphWidths;
var
  LCharCode: Integer;
  LGlyphIndex: Cardinal;
  LFontCache: TFontProcessorCacheCollection;
  LFacePtr: PFT_Face;
begin
  //Loads the FacePtr based on given Font info.(size)
  InitializeFace(LFontCache, LFacePtr);

  if LFacePtr <> nil then
  begin
    FLastCharCode := 255;
    SetLength(FGlyphWidths, 32);

    //Fetch the first AnsiChar code in the current charmap.
    FFirstCharCode := 32;//FT_Get_First_Char(LFacePtr, LGlyphIndex);

    //Loads the FacePtr with Encoding Info.
    if SetCharmap(FFirstCharCode, LGlyphIndex, LFacePtr) = Success then
    begin
      for LCharCode := FFirstCharCode to FLastCharCode do
      begin
        //Get the width of the first character based on its charcode.
        if FT_Load_Glyph(LFacePtr, LGlyphIndex, FT_LOAD_NO_SCALE) = 0 then
        begin
          SetLength(FGlyphWidths, LCharCode + 1);
          FGlyphWidths[LCharCode] := Round(LFacePtr.glyph.advance.X / FunitsPerEm) { / 64}; //design space to 1/64th of device pixels.
        end;
        if SetCharmap(LCharCode + 1, LGlyphIndex, LFacePtr) = Success then Continue;
      end;
    end;
  end;

  FinializeFace(LFontCache, LFacePtr);
end;

procedure TgtFontProcessor.GetItalicAngle;
var
  LEC: ErrorCodes;
begin
  if FFacePtr <> nil then
    LEC := ErrorCodes(FT_Get_PS_Font_Info(FFacePtr, FPS_FontInfoRecPtr)) else Exit;
  if LEC = Success then
    FItalicAngle := FPS_FontInfoRecPtr^.Italic_angle
  else
  begin
    FItalicAngle := 0;
  end;
end;

function TgtFontProcessor.GetTextHeight(AText: AnsiString): Double;
var
  LSize: TSize;
  LFontCache: TFontProcessorCacheCollection;
  LFacePtr: PFT_Face;
begin
  //Loads the FacePtr based on given Font info.
  InitializeFace(LFontCache, LFacePtr);

  if (AText <> '') then
    LSize := GetCharSize(Ord(AText[1]), LFacePtr);

  Result := LSize.cy;

  FinializeFace(LFontCache, LFacePtr);
end;

function TgtFontProcessor.GetTextWidth(AText: WideString): Double;
var
  LI: Integer;
  LSize: TSize;
  LFontCache: TFontProcessorCacheCollection;
  LFacePtr: PFT_Face;
begin
  Result := 0;
  //Loads the FacePtr based on given Font info.
  InitializeFace(LFontCache, LFacePtr);

  for LI := 1 to Length(AText) do
  begin
    LSize := GetCharSize(Ord(AText[LI]), LFacePtr);
    Result := Result + LSize.cx;
  end;

  FinializeFace(LFontCache, LFacePtr);
end;

//function TgtFontProcessor.GetFaceCount(byteArray: TShortIntArray): Integer;
//var
//  num: Integer;
//  tempFace: PFT_Face;
//  LByteArrayPtr: Pointer;
//begin
//  if (nil = FlibPtr) then
//  begin
//    Result := 0;
//    exit;
//  end;
//  num := 0;
//  LByteArrayPtr := @byteArray[0];
//  if (FT_New_Memory_Face(FlibPtr, PFT_Byte(LByteArrayPtr^), Length(byteArray), 0, tempFace) = 0) then
//  begin
//    num := TFT_FaceRec(tempFace^).num_faces;
//    FT_Done_Face(tempFace);
//  end;
//  Result := num;
//end;

function TgtFontProcessor.GetFontStream: TMemoryStream;
//var
//  LI: Integer;
begin
//  Result := nil;
  if not Assigned(FFontStream) then
  begin
    if (FFontStreamArray <> nil) then
    begin
      FFontStream := TMemoryStream.Create;
//      for LI := 0 to Length(FFontStreamArray) - 1 do
//        FFontStream.Write(FFontStreamArray[LI], SizeOf(ShortInt));
      FFontStream.Write(FFontStreamArray[0], Length(FFontStreamArray));
    end;
  end;
  Result := FFontStream;
end;

function TgtFontProcessor.get_Ascent: Double;
begin
  Result := FAscent;
end;

function TgtFontProcessor.get_CharacterMapCount: Integer;
begin
  Result := FCharMapCount;
end;

function TgtFontProcessor.get_Descent: Double;
begin
  Result := FDescent;
end;

function TgtFontProcessor.get_EncodingType: TFT_Encoding;
begin
  Result := FEncodingType;
end;

function TgtFontProcessor.get_FaceCount: Integer;
begin
  Result := FFaceCount;
end;

function TgtFontProcessor.get_FamilyName: AnsiString;
begin
  Result := FFamilyName;
end;

function TgtFontProcessor.get_GlobalBBox: TgtRect;
begin
  Result := FBBox;
end;

function TgtFontProcessor.get_Leading: Double;
begin
  Result := FLeading;
end;

function TgtFontProcessor.get_PostscriptName: AnsiString;
begin
  Result := FpsName;
end;

function TgtFontProcessor.get_StyleName: AnsiString;
begin
  Result := FStyleName;
end;

function TgtFontProcessor.get_UnderscorePosition: Double;
begin
  Result := FUnderscorePosition;
end;

function TgtFontProcessor.get_UnderscoreSize: Double;
begin
  Result := FUnderscoreSize;
end;

function TgtFontProcessor.get_UnitsPerEm: Double;
begin
  Result := FUnitsPerEm;
end;

function TgtFontProcessor.gtRect(Left, Top, Right, Bottom: Double): TgtRect;
begin
  Result.Left := Left;
  Result.Top := Top;
  Result.Right := Right;
  Result.Bottom := Bottom;
end;

function TgtFontProcessor.InitFace(faceIndex: Integer): ErrorCodes;
var
  LFontFileNamePtr: PAnsiChar;
  LFontStreamPtr: Pointer;
  LFacePtr: PFT_Face;
begin
  Result := Success;
  LFontFileNamePtr := nil;
  if (faceIndex > FaceCount) then
  begin
    Result := FaceIndexOutOfBounds;
    exit
  end;
  if (FFacePtr <> nil) then
  begin
    FT_Done_Face(FFacePtr);
    FFacePtr := nil;
  end;
  ClearFontDetails;
  if FFontFileName <> '' then
    LFontFileNamePtr := @FFontFileName[1];
  LFontStreamPtr := @FFontStreamArray[0];
  if ((FFontStream = nil) and (LFontFileNamePtr <> nil)) then
  begin
    if (FT_New_Face(FlibPtr, LFontFileNamePtr, faceIndex, LFacePtr) <> 0) then
    begin
      Result := FaceIndexOutOfBounds;
      exit;
    end;
  end
  else
    if (((FFontFileName = '') and (Length(FFontStreamArray) <> 0)) and
      (FT_New_Memory_Face(FlibPtr, PFT_Byte(LFontStreamPtr^), Length(FFontStreamArray), faceIndex, LFacePtr) <> 0)) then
    begin
      Result := FaceIndexOutOfBounds;
      exit;
    end;

  if (LFacePtr <> nil) then
  begin
    LoadFontDetails(LFacePtr);
    FT_Done_Face(LFacePtr);
    LFacePtr := nil;
  end;
end;

procedure TgtFontProcessor.InitializeFace(var AFontCache: TFontProcessorCacheCollection; var AFacePtr: PFT_Face);
begin
  AFontCache := TFontProcessorCacheCollection.Create(FlibPtr, 0, 0, 0);
  //if (FFontCache.Count = 0) then
  begin
    if (FFontStreamArray <> nil) then
      AFacePtr := AFontCache.GetFileFaceSize(FFontStreamArray, FFontSize, FFontSize)
    else
      AFacePtr := AFontCache.GetFileFaceSize(FFontFileName, FFontSize, FFontSize);
  end;
end;

function TgtFontProcessor.InitLibrary: ErrorCodes;
begin
  if ((FlibPtr = nil) and (FT_Init_FreeType(FlibPtr) <> 0)) then
  begin
    Result := InvalidLibraryHandle;
    exit;
  end;
  if (FlibPtr = nil) then
  begin
    Result := InvalidLibraryHandle;
    exit;
  end;
  begin
    Result := Success;
    exit;
  end
end;


procedure TgtFontProcessor.LoadFontDetails(AFacePtr: PFT_Face);
var
  LGlyphPoints: TgtPointsList;
  LW, LH: double;
  LEOF, LRF: Boolean;
  LEC: ErrorCodes;
  LF: TPDFFontFlags;
//  LAccumlate: Double;
//  LI: TFT_Encoding;
begin
//  LAccumlate := 0;
  LF := pfSerif;
  FpsName := FT_Get_Postscript_Name(AFacePtr);
  FstyleName := AnsiString(AFacePtr.style_name);
  FFamilyName := AnsiString(AFacePtr.family_name);
  FFaceCount := TFT_FaceRec(AFacePtr^).num_faces;
  if ((AFacePtr.face_flags and FT_FACE_FLAG_SCALABLE) <> 0) then
  begin
    FunitsPerEm := AFacePtr.units_per_EM / 1000;
    FAscent := Round(AFacePtr.ascender / FunitsPerEm);
    FDescent := Round(AFacePtr.descender / FunitsPerEm);
    FLeading := AFacePtr.height;
    FMaxWidth := Round(AFacePtr.max_advance_width / FunitsPerEm);
    FunderscorePosition := TFT_FaceRec(AFacePtr^).underline_position / 64;
    FunderscoreSize := TFT_FaceRec(AFacePtr^).underline_thickness / 64;
    FBBox := gtRect(Round(TFT_FaceRec(AFacePtr^).bbox.xMin / FunitsPerEm),
      Round(TFT_FaceRec(AFacePtr^).bbox.yMin / FunitsPerEm),
      Round(TFT_FaceRec(AFacePtr^).bbox.xMax / FunitsPerEm),
      Round(TFT_FaceRec(AFacePtr^).bbox.yMax / FunitsPerEm));
    //with (TFT_FaceRec(AFacePtr^).bbox do
    //begin
      //FBBox := gtRect((xMin / FunitsPerEm),
        //(yMin / FunitsPerEm),
        //((xMax - xMin) / FunitsPerEm),
        //((yMax - yMin) / FunitsPerEm));
    //end;
//      Abs(TFT_FaceRec(AFacePtr^).bbox.xMax - TFT_FaceRec(AFacePtr^).bbox.xMin),
//      Abs(TFT_FaceRec(AFacePtr^).bbox.yMax - TFT_FaceRec(AFacePtr^).bbox.yMin))
  end;
  if (AFacePtr.charmap = nil) then
  begin
    AFacePtr.charmap := (AFacePtr.charmaps^);
  end;

  FEncodingType := AFacePtr.charmap.encoding;
  FGlyphCount := TFT_FaceRec(AFacePtr^).num_glyphs;
  //CapHeight: Height of 'H'
  LEC := DecomposeOutlineGlyph(72, 0, '', FFontSize, LGlyphPoints, LW, LH,
    LEOF, LRF, gtCharacterCode);
  if LEC = Success then
    FCapHeight := FCBox.yMax - FCBox.yMin
  else
    FCapHeight := 0;
  //StemV: Width of '.'
  LEC := DecomposeOutlineGlyph(49, 0, '',  FFontSize, LGlyphPoints, LW, LH,
    LEOF, LRF, gtCharacterCode);
  if LEC = Success then
    FStemV := Round((FCBox.xMax / FunitsPerEm) - (FCBox.xMin / FunitsPerEm))
  else
    FStemV := Round(0.15 * TFT_FaceRec(AFacePtr^).bbox.xMax / FunitsPerEm);
//Flags
  FFlag := 0;
  if FT_IS_FIXED_WIDTH(AFacePtr) = True then
    SetFlagBit(1);
  if LF = pfSerif then
    SetFlagBit(2);
  if LF = pfSymbol then
    SetFlagBit(3);
  if LF = pfScript then
    SetFlagBit(4);
  if LF <> pfSymbol then
    SetFlagBit(6);
  GetItalicAngle;
  if (ItalicAngle > 0) then
    SetFlagBit(7);

  if FT_Get_PS_Font_Private(AFacePtr, FPS_PrivateRecPtr) = 0 then
  begin
    if Boolean(FPS_PrivateRecPtr^.Force_bold) then
      SetFlagBit(19);
  end;
  FFlag := Round(FFlag / FunitsPerEm);
  GetGlyphWidths;
//  for LI := 0 to Length(FGlyphWidths) - 1 do
//  begin
//    LAccumlate := LAccumlate + FGlyphWidths[LI];
//  end;
//  FAvgWidth := LAccumlate / Length(FGlyphWidths);
//  FMaxWidth := Max(Round(FGlyphWidths[0]), Round(FGlyphWidths[1]));
end;

function TgtFontProcessor.SetCharmap(ACharCode: Integer; out AGlyphIndex: Cardinal; AFacePtr: PFT_Face): ErrorCodes;
var
  LI, LReturnValue: Integer;
  LPCharMap: PPFT_CharMap;
begin
//  Result := ErrorCodes(FT_Set_Charmap(FFacePtr, FFacePtr.charmap));

  Result := NoWindowsCharacterMapFound;

  if (AFacePtr.num_charmaps = 0) then
    FT_Select_Charmap(AFacePtr, FT_ENCODING_UNICODE);

  if AFacePtr <> nil then
  begin
    LPCharMap := (AFacePtr.charmaps);

    for LI := 0 to (AFacePtr.num_charmaps - 1) do
    begin
      LReturnValue := FT_Set_Charmap(AFacePtr, PFT_CharMap(LPCharMap^));
      if LReturnValue = 0 then
        AGlyphIndex := FT_Get_Char_Index(AFacePtr, ACharCode)
      else
      begin
        Result := ErrorCodes(LReturnValue);
        Exit;
      end;
      if AGlyphIndex = 0 then
      begin
        Inc(LPCharMap);
        continue;
      end
      else
      begin
        Result := ErrorCodes(LReturnValue);
        Break;
      end;
    end;
  end;
end;

procedure TgtFontProcessor.SetFlagBit(ABit: Byte);
begin
  ABit := ABit mod 32;
  FFlag := FFlag or (1 shl ABit);
end;

procedure TgtFontProcessor.set_EncodingType(AEncodingType: TFT_Encoding);
begin
  FEncodingType := AEncodingType;
end;

constructor TgtFontProcessor.Create(AFileName: AnsiString; APointSize: Integer;
  AHorzRes, AVertRes: Cardinal; out errorCode: ErrorCodes);
begin
  FlibPtr := nil;
  errorCode := InitLibrary;
  if (errorCode = Success) then
  begin
    FFontFileName := AFileName;
    FFontSize := APointSize;
    FHorzRes := AHorzRes;
    FVertRes := AVertRes;
    //FFontCache := TFontProcessorCacheCollection.Create(FlibPtr, 0, 0, 0);
    errorCode := InitFace(0);
    FUseKerning := False;
  end;
end;

constructor TgtFontProcessor.Create(AStream: TStream; APointSize: Integer;
  AHorzRes, AVertRes: Cardinal; out errorCode: ErrorCodes);
begin
  FlibPtr := nil;
  errorCode := InitLibrary;
  if (errorCode = Success) then
  begin
    SetLength(FFontStreamArray, (Integer(AStream.Size)));
    AStream.Position := 0;
    AStream.Read(FFontStreamArray[0], Length(FFontStreamArray));
    //FFontCache := TFontProcessorCacheCollection.Create(FlibPtr, 0, 0, 0);
    FUseKerning := False;
    FFontSize := APointSize;
    FHorzRes := AHorzRes;
    FVertRes := AVertRes;
//    InitFace(0);
  end;
end;

function FaceRequest(AFaceID: PFTC_FaceID; ALibrary: PFT_Library; ARequestData: PFT_Pointer; var AFace: PFT_Face): TFT_ERROR; cdecl;
var
  lRequestItem: TFontProcessorCacheCollectionItem;
  LByteArrayPtr: Pointer;
begin
  result := 1;
  if AFaceID <> nil then
  begin
    lRequestItem := TFontProcessorCacheCollectionItem(AFaceID);
    if lRequestItem.FFileName <> '' then
      result := FT_New_Face(ALibrary, PAnsiChar(lRequestItem.FileName), 0, AFace)
    else
    begin
      LByteArrayPtr := @lRequestItem.FFontByteArray[0];
      result := FT_New_Memory_Face(ALibrary, PFT_Byte(LByteArrayPtr^),
        Length(lRequestItem.FFontByteArray), 0, AFace);
    end;
  end;
end;

constructor TgtFontProcessor.Create(aFont: TFont; out ErrorCode: ErrorCodes);
var
  DC: HDC;
  LLength, num2, ptr3: Cardinal;
begin
  errorCode := Success;
  if (aFont <> nil) then
  begin
    DC := GetDC(0);
    ptr3 := SelectObject(DC, aFont.Handle);
    num2 := GetFontData(DC, $66637474, 0, nil, 0);
    if (Integer(num2) > 0) then
    begin
      SetLength(FFontStreamArray, Integer(num2));
      GetFontData(DC, $66637474, 0, FFontStreamArray, num2);
    end
    else
    begin
      LLength := GetFontData(DC, 0, 0, nil, 0);
      if (Integer(LLength) > 0) then
      begin
        SetLength(FFontStreamArray, Integer(LLength));
        GetFontData(DC, 0, 0, FFontStreamArray, LLength);
      end
      else
        errorCode := InvalidFontObject;
    end;
    DeleteObject(ptr3);
    ReleaseDC(0, DC);
    if ((errorCode = Success) and (FFontStreamArray <> nil)) then
    begin
      errorCode := InitLibrary;
      if (errorCode = Success) then
      begin
        FFontFileName := '';
        //FFaceCount := GetFaceCount(FFontStreamArray);
        FFontSize := aFont.Size;
//        FFontCache := TFontProcessorCacheCollection.Create(FlibPtr, 0, 0, 0);
        errorCode := InitFace(0);
      end;
    end;
  end;
end;

{ TFontProcessorCacheCollectionItem }

constructor TFontProcessorCacheCollectionItem.Create(Collection: TCollection);
begin
  inherited;
  FFileName := '';
end;

destructor TFontProcessorCacheCollectionItem.Destroy;
begin
  inherited;
  SetLength(FFontByteArray, 0);
end;

{ TFontProcessorCacheCollection }

constructor TFontProcessorCacheCollection.Create(AFTLibrary: PFT_Library; AMaxFaces, AMaxSizes: Integer; AMaxBytes: Integer);
begin
  inherited Create(TFontProcessorCacheCollectionItem);
  FMaxFaces := AMaxFaces;
  FMaxSizes := AMaxSizes;
  FMaxBytes := AMaxBytes;
  FFTLibrary := AFTLibrary;
  FFTCacheManager := nil;
  if not (FTC_Manager_New(FFTLibrary, FMaxFaces, FMaxSizes, FMaxBytes, @FaceRequest, nil, FFTCacheManager) = 0) then
    FFTCacheManager := nil;
//  if not (FTC_SBitCache_New(FFTCacheManager, FFTCSBitCache) = 0) then
//    FFTCSBitCache := nil;
//  if not (FTC_ImageCache_New(FFTCacheManager, FFTCImageCache) = 0) then
//    FFTCImageCache := nil;
end;

destructor TFontProcessorCacheCollection.Destroy;
begin
  if FFTCacheManager <> nil then
    FTC_Manager_Done(FFTCacheManager);
  inherited;
end;

function TFontProcessorCacheCollection.FindFile(AFileName: AnsiString): TFontProcessorCacheCollectionItem;
var
  I: Integer;
  lCollectionItem: TCollectionItem;
begin
  result := nil;
  for I := 0 to Count - 1 do // Iterate
  begin
    lCollectionItem := Items[I];
    if lCollectionItem is TFontProcessorCacheCollectionItem then
    begin
      if TFontProcessorCacheCollectionItem(lCollectionItem).FileName = AFileName then
      begin
        result := TFontProcessorCacheCollectionItem(lCollectionItem);
        Break;
      end;
    end;
  end; // for
end;

function TFontProcessorCacheCollection.GetFileFace(AFileName: AnsiString): PFT_Face;
var
  lFileItem: TFontProcessorCacheCollectionItem;
begin
  lFileItem := FindFile(AFileName);
  result := nil;
  if not assigned(lFileItem) then
  begin
    lFileItem := TFontProcessorCacheCollectionItem(Add);
    lFileItem.FileName := AFileName;
  end;
  if assigned(lFileItem) then
    result := GetItemFace(lFileItem);
end;

function TFontProcessorCacheCollection.GetFileFaceSize(AFileName: AnsiString; ASizeX,
  ASizeY: Integer): PFT_Face;
var
  lFileItem: TFontProcessorCacheCollectionItem;
begin
  lFileItem := FindFile(AFileName);
  result := nil;
  if not assigned(lFileItem) then
  begin
    lFileItem := TFontProcessorCacheCollectionItem(Add);
    lFileItem.FileName := AFileName;
  end;
  if assigned(lFileItem) then
    result := GetItemFaceSize(lFileItem, ASizeX, ASizeY);
end;

function TFontProcessorCacheCollection.GetFileFaceSize(
  ByteArray: TShortIntArray; ASizeX, ASizeY: Integer): PFT_Face;
var
  lFileItem: TFontProcessorCacheCollectionItem;
begin
  result := nil;
  lFileItem := TFontProcessorCacheCollectionItem(Add);
  lFileItem.FFontByteArray := Copy(ByteArray, 0, Length(ByteArray));

  if assigned(lFileItem) then
    result := GetItemFaceSize(lFileItem, ASizeX, ASizeY);
end;


function TFontProcessorCacheCollection.GetItemFace(AItem: TFontProcessorCacheCollectionItem): PFT_Face;
begin
  result := nil;
  if not (FTC_Manager_LookupFace(FFTCacheManager, AItem, Result) = 0) then
    result := nil;
end;

function TFontProcessorCacheCollection.GetItemFaceSize(AItem: TFontProcessorCacheCollectionItem; ASizeX,
  ASizeY: Integer): PFT_Face;
var
  lPSize: PFT_Size;
  lScaler: TFTC_ScalerRec;
begin
  result := nil;
//  lFont.face_id := AItem;
//  GetScreenResolution(lHorzRes, lVertRes);
//  lFont.pix_width := (ASizeX * lHorzRes) div 72;
//  lFont.pix_height := (ASizeY * lVertRes) div 72;
//  lPSize := @lSize;

  lScaler.face_id := AItem;
  lScaler.width := ASizeX * 64;
  lScaler.height := ASizeX * 64;
  lScaler.pixel := 0;
  lScaler.x_res := 72;
  lScaler.y_res := 72;
  FTC_Manager_LookupSize(FFTCacheManager, @lScaler, lPSize);

  //The returned FT_Face object is always owned by the manager.
  //You should never try to discard it yourself.
  FTC_Manager_LookupFace(FFTCacheManager, AItem, Result);
end;

function TFontProcessorCacheCollection.GetFileFace(
  ByteArray: TShortIntArray): PFT_Face;
var
  lFileItem: TFontProcessorCacheCollectionItem;
begin
//  if not assigned(lFileItem) then
//  begin
  lFileItem := TFontProcessorCacheCollectionItem(Add);
  lFileItem.FFontByteArray := Copy(ByteArray, 0, Length(ByteArray));
//  end;
//  if assigned(lFileItem) then
  result := GetItemFace(lFileItem);
end;

end.
