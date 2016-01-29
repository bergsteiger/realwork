{ *************************************************************************** }
{ }
{ Gnostice eDocEngine }
{ }
{ Copyright © 2002-2010 Gnostice Information Technologies Private Limited }
{ http://www.gnostice.com }
{ }
{ *************************************************************************** }

{$I ..\gtSharedDefines.inc}
{ ------------------------------------ }
{ Editor Options }
{ ------------------------------------ }
{ }
{ Tab Stops = 2 }
{ Use Tab Character = True }
{ }
{ ------------------------------------ }

unit gtGlyphInfo;

interface

uses
  Graphics, Windows, Classes, gtMLang;

type
  TgtWordArray = array of Word;
  TgtGlyphType = (gdComplex, gdLigature, gdRTL);
  TgtScriptVisAttr = (svClusterStart, { :1 }
    // First glyph of representation of cluster
    svDiacritic, { :1 }  // Diacritic
    svZeroWidth { :1 }  // Blank, ZWJ, ZWNJ etc, with no width
    );
  TgtScriptVisAttrs = set of TgtScriptVisAttr;

  TgtGlyphTypes = set of TgtGlyphType;

  TgtRunInfo = record
    GlyphType: TgtGlyphTypes;
    StartPos: Integer;
    EndPos: Integer;
    IsFontMapped: Boolean;
    VisAttr: array of TgtScriptVisAttrs;
    ScriptProcessingRequired: Boolean;
    MappedFontName: TFontName;
  end;

  TgtGlyphInfoList = class;
  TgtMapFont = class;

  // AText: Complete text
  // ARunIndex: Zero-based index for the script runs
  // AIsComplex: True if the text represents a complex script
  // AGlyphInfoList: List of TgtGlyphInfo objects for this script run
  TgtScriptRunCallback = procedure(AText: WideString;
    ARunIndex, ARunCount: Integer; var AGlyphInfoList: TgtGlyphInfoList;
    AGlyphDetail: TgtRunInfo; ALogClust: TgtWordArray) of object;

  TgtGlyphInfo = class(TPersistent)
  private
    FID: Word;
    FAdvWidth: Integer;
    FABCWidth: ABC;
    FPosition: Integer;
    FFontName: string;
  public
    constructor Create(AID: Word; AAdvWidth: Integer; AABCWidth: ABC;
      APos: Integer; AFont: TFont); overload;
    constructor Create; overload;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property ID: Word read FID;
    property AdvWidth: Integer read FAdvWidth;
    property ABCWidth: ABC read FABCWidth;
    property Position: Integer read FPosition;
    property FontName: string read FFontName;
  end;

  TgtGlyphInfoList = class(TList)
  private
    FOwnsObjects: Boolean;
    function GetItem(Index: Integer): TgtGlyphInfo;
  protected
    procedure Notify(Ptr: Pointer; Action: TListNotification); override;
  public
    constructor Create; overload;
    constructor Create(AOwnsObjects: Boolean); overload;

    property Items[Index: Integer]: TgtGlyphInfo read GetItem; default;
    property OwnsObjects: Boolean read FOwnsObjects write FOwnsObjects;
  end;

  TgtStringAnalyzer = class
  private
    FMapFont: TgtMapFont;
    class function ZeroGlyphs(AGlyphIDs: array of Word;
      ACount: Integer): Boolean;
  public
    procedure StringAnalyze(AText: WideString; ABiDiMode: TBiDiMode;
      AFont: TFont; AScriptRunCallback: TgtScriptRunCallback;
      AMapFont: TgtMapFont);

  end;

  TgtMappedFont = class
  private
    FFontName: TFontName;
    procedure SetFontName(const Value: TFontName);
  public
    constructor Create(AFontName: TFontName);
    destructor Destroy; override;
    property FontName: TFontName read FFontName write SetFontName;
  end;

  TgtFontSizeMapping = class
  private
    FFont: TFont;
    FInputFontSize: Integer;
    procedure SetFont(const Value: TFont);
    procedure SetInputFontSize(const Value: Integer);
  public
    constructor Create(AFont: TFont); // input font
    destructor Destroy; override;
    property Font: TFont read FFont write SetFont;
    property InputFontSize: Integer read FInputFontSize write SetInputFontSize;
  end;

  TgtFontUnicodeSubRangeInfo = class
  private
    FLatinCharRange: Boolean;
    procedure SetLatinCharRange(const Value: Boolean);
  public
    constructor Create(AFontName: TFontName);
    destructor Destroy; override;
    property LatinCharRange: Boolean read FLatinCharRange
      write SetLatinCharRange;
  end;

  TgtMapFont = class
  private
    FLastResult: HRESULT;
    FPrevCodePages: DWORD;
    FHashCodePages: TStringList;
    FMappedFontSizeList: TStringList;
    FSysFontList: TStringList;
    FAllUsedFonts: TStringList;
    FMappedFonts: TStringList;
    FUnicodeRangeMappedFonts: TStringList;
    FUnicodeSubRangeInfo: TStringList;
    function IsTrueType(AFont: TFont): Boolean;
    procedure SetLastResult(const Value: HRESULT);
    function GetDefaultFont: TFont;
    procedure SetPrevCodePages(const Value: DWORD);
    procedure SetAllUsedFonts(const Value: TStringList);
  public
    constructor Create;
    destructor Destroy; override;
    function GetNextInstalledFont(AFont: TFont; var AIndex: Integer): TFont;
    function GetNextFontFromUsedList(AFont: TFont;
      var AUsedFontIndex: Integer): TFont;
    function GetMappedFont(AText: LPCWSTR; AFont: TFont): TFont;
    function GetTrueTypeFont(AText: WideString; AFont: TFont): TFont;
    function GetFontSize(AFont: TFont): Integer;
    function IsLatinUnicodeRangePresent(AFont: TFont): Boolean;
    property LastResult: HRESULT read FLastResult write SetLastResult;
    property PrevCodePages: DWORD read FPrevCodePages write SetPrevCodePages;
    property AllUsedFonts: TStringList read FAllUsedFonts write SetAllUsedFonts;

  end;

implementation

uses
  Forms, {$IFDEF gtDelphi6Up} StrUtils, {$ENDIF} SysUtils,
  gtUtils3, gtConsts3, gtDocUsp10;

var
  FontList: TStringList;
  I, LCount: Integer;
  ArialUni: string;

constructor TgtGlyphInfo.Create(AID: Word; AAdvWidth: Integer; AABCWidth: ABC;
  APos: Integer; AFont: TFont);
begin
  FID := AID;

  // FAdvWidth := AAdvWidth;
  FABCWidth := AABCWidth;

  { The TrueType rasterizer provides ABC character spacing after a specific point
    size has been selected. A spacing is the distance added to the current
    position before placing the glyph. B spacing is the width of
    the black part of the glyph. C spacing is the distance added to the current
    position to provide white space to the right of the glyph.
    The total advanced width is specified by A+B+C. }

  FAdvWidth := ABCWidth.abcA + Integer(ABCWidth.abcB) + ABCWidth.abcC;
  FPosition := APos;
  FFontName := AFont.Name;
end;

procedure TgtGlyphInfo.Assign(Source: TPersistent);
begin
  with TgtGlyphInfo(Source) do
  begin
    Self.FID := FID;
    Self.FAdvWidth := FAdvWidth;
    Self.FABCWidth := FABCWidth;
    Self.FPosition := FPosition;
    Self.FFontName := FFontName;
  end;
end;

constructor TgtGlyphInfo.Create;
begin
  inherited;

end;

destructor TgtGlyphInfo.Destroy;
begin
  inherited;
end;

{ TgtGlyphInfoList }

constructor TgtGlyphInfoList.Create;
begin
  inherited Create;
  FOwnsObjects := True;
end;

constructor TgtGlyphInfoList.Create(AOwnsObjects: Boolean);
begin
  inherited Create;
  FOwnsObjects := AOwnsObjects;
end;

function TgtGlyphInfoList.GetItem(Index: Integer): TgtGlyphInfo;
begin
  Result := TgtGlyphInfo( inherited Items[Index]);
end;

procedure TgtGlyphInfoList.Notify(Ptr: Pointer; Action: TListNotification);
begin
  if OwnsObjects then
    if Action = lnDeleted then
      TgtGlyphInfo(Ptr).Free;
  inherited Notify(Ptr, Action);
end;

{ TgtStringAnalyzer }

class function TgtStringAnalyzer.ZeroGlyphs(AGlyphIDs: array of Word;
  ACount: Integer): Boolean;
var
  LI: Integer;
begin
  Result := False;
  for LI := 0 to (ACount - 1) do
  begin
    Result := (AGlyphIDs[LI] = 0);
    if (Result) then
      Break;
  end;
end;

procedure TgtStringAnalyzer.StringAnalyze(AText: WideString;
  ABiDiMode: TBiDiMode; AFont: TFont; AScriptRunCallback: TgtScriptRunCallback;
  AMapFont: TgtMapFont);
var
  LPInChars: PWideChar;
  LScriptControl: TScriptControl;
  LScriptState: TScriptState;

  LScriptProperties: array of PScriptProperties;
  LScriptItems: array of TScriptItem;
  LScriptItemCount, LMaxScripts: Integer;
  LResult: HRESULT;
  LMaxScriptItems: Integer;

  LBiDiLevels: array of Byte;
  LVisual2Logical: array of Integer;
  LI, LJ, LK: Integer;
  LN, LAllUsedFontIndex: Integer;
  LHdc: HDC;
  LScriptCache: TScriptCache;
  LScriptItemLength: Integer;
  LMaxGlyphIDs: Integer;
  LItemGlyphCnt: Integer;
  LAdvWidths: array of Integer;
  LItemGlyphIDs: array of Word;
  LLogClust: array of Word;
  LVisAttr: array of TScriptVisAttr;

  LScriptVisiAttr: TgtScriptVisAttrs;

  LGlyphOffsets: array of TGOffset;
  LScriptItemABC: ABC;

  LRTL, LRTLSubString: Boolean;

  LGlyphInfo: TgtGlyphInfo;
  LPos: Integer;
  LFontMapped: Boolean;
  LMappedFont: TFont;
  LRunInfoList: TgtGlyphInfoList;
  LIsComplex, LIsFontMapped, LIsStringProcessingReq, LFontSupportsLatin
    : Boolean;
  LStrInANSIRange: Boolean;
  LSubText: WideString;
  LX: Integer;
  LMapFont: TgtMappedFont;
  // LIndex: Integer;
  LRunInfo: TgtRunInfo;
  LUnicodeRange: TgtFontUnicodeSubRangeInfo;

begin
  LRunInfoList := nil;
  FMapFont := AMapFont;
  LFontMapped := False;
  LRTLSubString := False;
  if (AText = '') then
    Exit;
  if (not Assigned(AScriptRunCallback)) then
    Exit;
  LPInChars := PWideChar(AText);

  if (ABiDiMode = bdRightToLeft) or (ABiDiMode = bdRightToLeftNoAlign) or
    (ABiDiMode = bdRightToLeftReadingOnly) then
    LRTL := True
  else
    LRTL := False;

  // Init
  with LScriptControl do
  begin
    uDefaultLanguage := 0;
    fFlags := [];
    fReserved := 0;
  end;
  with LScriptState do
  begin
    fFlags := [];
    if LRTL then
    begin
      fFlags := [uBidiLevel_reserved1];
    end
    else
      fFlags := [];
  end;

  // Applies the regional settings, digit substitution settings, to the specified
  // script control and script state structures.
  ScriptApplyDigitSubstitution(nil, @LScriptControl, @LScriptState);

  // ScriptItemize
  LMaxScriptItems := 2;

  repeat
    SetLength(LScriptItems, LMaxScriptItems);
    LResult := ScriptItemize(LPInChars, Length(AText), LMaxScriptItems,
      @LScriptControl, @LScriptState, @LScriptItems[0], @LScriptItemCount);
    if ((LResult <> S_OK) and (LResult <> E_OUTOFMEMORY)) then
      Break;
    Inc(LMaxScriptItems);
  until (LResult = S_OK);

  // ScriptLayout
  SetLength(LBiDiLevels, LScriptItemCount + 1);
  SetLength(LVisual2Logical, LScriptItemCount + 1);
  for LI := 0 to LScriptItemCount do
  begin
    LBiDiLevels[LI] := LScriptItems[LI].a.s.uBidiLevel;
    if (fRTL in LScriptItems[LI].a.fFlags) then
      LRTLSubString := True;

  end;
  ScriptLayout(LScriptItemCount + 1, @LBiDiLevels[0], @LVisual2Logical[0], nil);

  // ScriptShape
  LHdc := GetDC(0);
  SelectObject(LHdc, AFont.Handle);

  LPos := 0;
  LScriptCache := nil;
  LMappedFont := TFont.Create;
  LMappedFont.Assign(AFont);
  for LI := 0 to (LScriptItemCount - 1) do
  begin
    LRunInfo.IsFontMapped := False;
    LN := 0;
    LAllUsedFontIndex := 0;
    LIsFontMapped := False;
    LK := LVisual2Logical[LI];
    LScriptItemLength := LScriptItems[LK + 1].iCharPos - LScriptItems
      [LK].iCharPos;
    LMaxGlyphIDs := LScriptItemLength;
    SetLength(LLogClust, LScriptItemLength);
    LPInChars := @(AText[LScriptItems[LK].iCharPos + 1]);
    LSubText := '';
    LStrInANSIRange := True;
    for LX := (LScriptItems[LK].iCharPos + 1) to (LScriptItems[LK + 1].iCharPos) do
    begin
      LSubText := LSubText + AText[LX];
      if not((ord(AText[LX]) >= 32) and (ord(AText[LX]) <= 255)) then
        LStrInANSIRange := False;
    end;
    // space, punctuation marks etc. are under SIC_NEUTRAL

    if (AFont.Pitch = fpFixed) then
     LIsComplex := True
    else
     LIsComplex := (ScriptIsComplex(LPInChars, LScriptItemLength,
       SIC_COMPLEX) = S_OK);

    LFontSupportsLatin := AMapFont.IsLatinUnicodeRangePresent(AFont);

    // Checking for only the first char of 'LSubText' is sufficient,
    // bcoz ScriptItemize will break string according to unicode subranges

    // If font doesn't support Latin unicode Subrange, then if the font is already
    // mapped to other font for the same reason, then get the index of it
    // If the font is not already mapped then do script processing once, to get
    // Mapped font name
    // LIndex := -1;
    // if not LFontSupportsLatin and not LIsComplex and LStrInANSIRange then
    // LIndex := AMapFont.FUnicodeRangeMappedFonts.IndexOf(AFont.Name);

    // Below are the three condition for checking whether string requires script
    // processing,
    // In first 2 cases string doesn't require script processing
    // 1. when string is in range 32 to 255 and font supports Latin charset
    // 2. when string is in range 32 to 255 and font doesn't support Latin charset
    // but is already mapped
    // 3. when string is outside 255 or when font doesn't support latin charset
    // then it requires script processing

    if not LRTL and LFontSupportsLatin and not LIsComplex and LStrInANSIRange and (AFont.Pitch <> fpFixed) then
    begin
      // Font doesn't require any mapping.
      LRunInfo.GlyphType := [];
      // if LRTLSubString then
      // LRunInfo.GlyphType := LRunInfo.GlyphType + [gdRTL];

      if LIsComplex then
        LRunInfo.GlyphType := LRunInfo.GlyphType + [];
      LRunInfo.StartPos := LScriptItems[LK].iCharPos;
      LRunInfo.EndPos := LScriptItems[LK + 1].iCharPos;
      LRunInfo.ScriptProcessingRequired := False;
      LRunInfo.MappedFontName := AFont.Name;
      AScriptRunCallback(LSubText, LI, LScriptItemCount, LRunInfoList, LRunInfo,
        @LLogClust[0]);
    end
    (* else if not LRTL and (not LFontSupportsLatin) and not LIsComplex and
      LStrInANSIRange and (LIndex <> -1) then
      begin
      //font doesn't support Latin unicode Subrange,
      //the same font is mapped to other font in the prev iteration- use it

      //  if LRTLSubString then
      //     LRunInfo.GlyphType := LRunInfo.GlyphType + [gdRTL];
      LRunInfo.GlyphType := [];
      if LIsComplex then
      LRunInfo.GlyphType := LRunInfo.GlyphType + [];
      LRunInfo.StartPos := LScriptItems[LK].iCharPos;
      LRunInfo.EndPos := LScriptItems[LK + 1].iCharPos;
      LRunInfo.ScriptProcessingRequired := False;
      LMapFont := TgtMappedFont(AMapFont.FUnicodeRangeMappedFonts.Objects[LIndex]);
      LRunInfo.MappedFontName := LMapFont.FFontName;
      AScriptRunCallback(LSubText, LI, LScriptItemCount, LRunInfoList,
      LRunInfo, @LLogClust[0]);
      end *)
    else
    begin
      // Requires script processing
      if (LFontMapped) then
      begin
        FreeAndNil(LMappedFont);
        LMappedFont := TFont.Create;
        LMappedFont.Assign(AFont);
        SelectObject(LHdc, AFont.Handle);
        LFontMapped := False;
      end;

      repeat
        if LScriptCache <> nil then
          ScriptFreeCache(@LScriptCache);
        SetLength(LItemGlyphIDs, LMaxGlyphIDs);
        SetLength(LVisAttr, LMaxGlyphIDs);
        LResult := ScriptShape(LHdc, @LScriptCache, LPInChars,
          LScriptItemLength, LMaxGlyphIDs, @(LScriptItems[LK].a),
          @LItemGlyphIDs[0], @LLogClust[0], @LVisAttr[0], @LItemGlyphCnt);

        if (LResult = E_OUTOFMEMORY) then
          Inc(LMaxGlyphIDs)
        else if (LResult = E_PENDING) then
        begin
          ReleaseDC(0, LHdc);
          LHdc := GetDC(0);
          SelectObject(LHdc, AFont.Handle);
        end
        else if ((LResult = Integer(USP_E_SCRIPT_NOT_IN_FONT)) or
          (ZeroGlyphs(LItemGlyphIDs, LItemGlyphCnt))) then
        begin
          // If ZeroGlyphs, it means script not in font
          LResult := Integer(USP_E_SCRIPT_NOT_IN_FONT);
          if Assigned(LMappedFont) then
            FreeAndNil(LMappedFont);

          if (LAllUsedFontIndex < FMapFont.AllUsedFonts.Count) then
          begin
            LMappedFont := FMapFont.GetNextFontFromUsedList(AFont,
              LAllUsedFontIndex);
            // If original font is not vertical, but used font is vertical then
            // remove '@' from font name
            if (AFont.Name[1] <> '@') and (LMappedFont.Name[1] = '@') then
              LMappedFont.Name := RightStr(LMappedFont.Name,
                Length(LMappedFont.Name) - 1);
          end
          else if not LIsFontMapped then
          begin
            if Assigned(LMappedFont) then
              FreeAndNil(LMappedFont);

            LMappedFont := FMapFont.GetMappedFont(@LSubText[1], AFont);
            if (FMapFont.PrevCodePages = 0) or
              ((LMappedFont <> nil) and (AnsiCompareText(LMappedFont.Name,
              AFont.Name) = 0)) then
            begin
              if Assigned(LMappedFont) then
                FreeAndNil(LMappedFont);

              LMappedFont := FMapFont.GetNextInstalledFont(AFont, LN);
            end;
            LIsFontMapped := True;
          end
          else
          begin
            if Assigned(LMappedFont) then
              FreeAndNil(LMappedFont);
            LMappedFont := FMapFont.GetNextInstalledFont(AFont, LN);
          end;

          if not Assigned(LMappedFont) or
            (LIsFontMapped and (LN >= FMapFont.FSysFontList.Count)) then
            Break;

          SelectObject(LHdc, LMappedFont.Handle);
          LFontMapped := True;
          LRunInfo.IsFontMapped := True;
        end;
        // event can be invoked here to give opportuniy to specify different font to
        // map to - Sender, OriginalFont, MappedFont, NewFont, var MapToNewFont
      until (LResult = S_OK);

      if not LFontSupportsLatin and LStrInANSIRange and not LIsComplex then
      begin
        LMapFont := TgtMappedFont.Create(LMappedFont.Name);
        AMapFont.FUnicodeRangeMappedFonts.AddObject(AFont.Name, LMapFont);
      end;
      LRunInfo.MappedFontName := LMappedFont.Name;
      LRunInfo.GlyphType := [];
      LRunInfo.ScriptProcessingRequired := True;
      if LIsComplex then
        LRunInfo.GlyphType := LRunInfo.GlyphType + [gdComplex];
      if ((not LIsComplex) and (LItemGlyphCnt < LMaxGlyphIDs)) then
        LRunInfo.GlyphType := LRunInfo.GlyphType + [gdLigature];
      if (fRTL in LScriptItems[LK].a.fFlags) then
        LRunInfo.GlyphType := LRunInfo.GlyphType + [gdRTL];

      if (LResult = Integer(USP_E_SCRIPT_NOT_IN_FONT)) then
        Continue;
      if (FMapFont.AllUsedFonts.IndexOf(LMappedFont.Name) = -1) then
        FMapFont.AllUsedFonts.Add(LMappedFont.Name);
      // ScriptPlace
      SetLength(LAdvWidths, LItemGlyphCnt);
      SetLength(LGlyphOffsets, LItemGlyphCnt);
      ScriptPlace(LHdc, @LScriptCache, @LItemGlyphIDs[0], LItemGlyphCnt,
        @LVisAttr[0], @(LScriptItems[LK].a), @LAdvWidths[0], @LGlyphOffsets[0],
        @LScriptItemABC);

      LRunInfoList := TgtGlyphInfoList.Create(False);

      // ScriptGetGlyphABCWidth
      for LJ := 0 to (LItemGlyphCnt - 1) do
      begin
        ScriptGetGlyphABCWidth(LHdc, @LScriptCache, LItemGlyphIDs[LJ],
          @LScriptItemABC);

        LGlyphInfo := TgtGlyphInfo.Create(LItemGlyphIDs[LJ], LAdvWidths[LJ],
          LScriptItemABC, LPos, LMappedFont);
        Inc(LPos);
        LRunInfoList.Add(LGlyphInfo);
      end;
      LRunInfo.StartPos := LScriptItems[LK].iCharPos;
      LRunInfo.EndPos := LScriptItems[LK + 1].iCharPos;
      SetLength(LRunInfo.VisAttr, Length(LVisAttr));
      for LJ := 0 to Length(LVisAttr) - 1 do
      begin
        LRunInfo.VisAttr[LJ] := [];
        if fClusterStart in LVisAttr[LJ].fFlags then
          LRunInfo.VisAttr[LJ] := LRunInfo.VisAttr[LJ] + [svClusterStart];
        if fDiacritic in LVisAttr[LJ].fFlags then
          LRunInfo.VisAttr[LJ] := LRunInfo.VisAttr[LJ] + [svDiacritic];
        if fZeroWidth in LVisAttr[LJ].fFlags then
          LRunInfo.VisAttr[LJ] := LRunInfo.VisAttr[LJ] + [svZeroWidth];
      end;
      // Call back with info for this text script run
      if (Assigned(AScriptRunCallback)) then
        AScriptRunCallback(LSubText, LI, LScriptItemCount, LRunInfoList,
          LRunInfo, @LLogClust[0]);

      LAdvWidths := nil;
      LLogClust := nil;
      LVisAttr := nil;
      LGlyphOffsets := nil;
      LItemGlyphIDs := nil;
    end;
  end;
  ScriptFreeCache(@LScriptCache);
  ReleaseDC(0, LHdc);
  if Assigned(LMappedFont) then
    FreeAndNil(LMappedFont);
end;

{ TgtMapFont }

constructor TgtMapFont.Create;
var
  ArialUni: string;
  LCount, I: Integer;
begin
  FHashCodePages := TStringList.Create;
  FAllUsedFonts := TStringList.Create;

  FSysFontList := TStringList.Create;

  FSysFontList.AddStrings(Screen.Fonts);

  FMappedFonts := TStringList.Create;

  FUnicodeSubRangeInfo := TStringList.Create;

  FUnicodeRangeMappedFonts := TStringList.Create;

  FMappedFontSizeList := TStringList.Create;
  {
    while (FSysFontList.Count > 0) do
    begin
    if (FSysFontList.Strings[0][1] = '@') then
    FSysFontList.Delete(0)
    else
    Break;
    end;
  }
  // We'll use Arial Unicode MS as a last resort when performing font mapping
  // (when it has not been explicitly selected), as it's a very heavy font and
  // takes longer to process.
  ArialUni := UpperCase('Arial Unicode MS');
  LCount := FSysFontList.Count - 1;
  for I := 0 to LCount do
    if UpperCase(FSysFontList[I]) = ArialUni then
    begin
      ArialUni := FSysFontList[I];
      FSysFontList.Delete(I);
      FSysFontList.Append(ArialUni);
      Break;
    end;


  // initially stores list of known non-true type, mapped to true type fonts
{$IFDEF gtDelphi6UP}
  FMappedFonts.CaseSensitive := False;
{$ENDIF}
  if (FSysFontList.IndexOf('Courier New') <> -1) then
    FMappedFonts.AddObject('Courier', TgtMappedFont.Create('Courier New'));
  if (FSysFontList.IndexOf('Arial') <> -1) then
    FMappedFonts.AddObject('MS Sans Serif', TgtMappedFont.Create('Arial'));
end;

destructor TgtMapFont.Destroy;
var
  LI: Integer;
  LMappedFont: TgtMappedFont;
  LUnicodeSubRange: TgtFontUnicodeSubRangeInfo;
  LMappedFontSize: TgtFontSizeMapping;
begin
  if Assigned(FSysFontList) then
    FreeAndNil(FSysFontList);

  for LI := 0 to FHashCodePages.Count - 1 do
  begin
    LMappedFont := TgtMappedFont(FHashCodePages.Objects[LI]);
    LMappedFont.Free;
  end;
  FHashCodePages.Free;

  for LI := 0 to FMappedFonts.Count - 1 do
  begin
    LMappedFont := TgtMappedFont(FMappedFonts.Objects[LI]);
    LMappedFont.Free;
  end;
  FMappedFonts.Free;

  for LI := 0 to FUnicodeRangeMappedFonts.Count - 1 do
  begin
    LMappedFont := TgtMappedFont(FUnicodeRangeMappedFonts.Objects[LI]);
    LMappedFont.Free;
  end;
  FUnicodeRangeMappedFonts.Free;

  for LI := 0 to FUnicodeSubRangeInfo.Count - 1 do
  begin
    LUnicodeSubRange := TgtFontUnicodeSubRangeInfo
      (FUnicodeSubRangeInfo.Objects[LI]);
    LUnicodeSubRange.Free;
  end;
  FUnicodeSubRangeInfo.Free;

  for LI := 0 to FMappedFontSizeList.Count - 1 do
  begin
    LMappedFontSize := TgtFontSizeMapping(FMappedFontSizeList.Objects[LI]);
    LMappedFontSize.Free;
  end;
  FMappedFontSizeList.Free;

  FAllUsedFonts.Free;

  inherited;
end;

function TgtMapFont.GetDefaultFont: TFont;
begin
  Result := TFont.Create;
end;

function TgtMapFont.GetFontSize(AFont: TFont): Integer;
var
  LFont: TFont;
  // LFOntSize: Integer;
  LDC: HDC;
  LSaveFont: HFont;
  LTM: TTextMetric;
  LSaveMM: Integer;
  LI: Integer;
  LMappedFontSize: TgtFontSizeMapping;
begin
  LFont := TFont.Create;
  try
    LFont.Assign(AFont);
    LI := FMappedFontSizeList.IndexOf(AFont.Name);
    LMappedFontSize := nil;
    if LI >= 0 then
    begin
      LMappedFontSize := TgtFontSizeMapping(FMappedFontSizeList.Objects[LI]);
    end;

    if (LMappedFontSize <> nil) and
      (LMappedFontSize.InputFontSize = AFont.Size) then
    begin
      LFont.Size := LMappedFontSize.FFont.Size;
      // LFOntSize := LFont.Size;
    end
    else
    begin
      LDC := GetDC(0);
      LSaveMM := GetMapMode(LDC);
      SetMapMode(LDC, MM_TEXT);
      LSaveFont := SelectObject(LDC, AFont.Handle);
      GetTextMetrics(LDC, LTM);
      LFont.Size := Round((Abs(AFont.Height) - LTM.tmInternalLeading) *
        CInchesToPoints / CPixelsPerInch);
      LMappedFontSize := TgtFontSizeMapping.Create(AFont);
      LMappedFontSize.FFont.Size := LFont.Size;
      FMappedFontSizeList.AddObject(AFont.Name, LMappedFontSize);
      SelectObject(LDC, LSaveFont);
      SetMapMode(LDC, LSaveMM);
      ReleaseDC(0, LDC);
    end;
  finally
    Result := LFont.Size;
    LFont.Free;
  end;

end;

function TgtMapFont.GetMappedFont(AText: LPCWSTR; AFont: TFont): TFont;
var
  LDC: HDC;
  LLangFontLink2: IMLangFontLink2;
  LLogFont: TLOGFONT;
  LCount, LFontIndex: Integer;
  LActualCodePages, LFontCodePages: DWORD;
  LActualCount: LongInt;
  LHFont: HFont;
  LChar: WChar;
  LText: WideString;
  LMappedFont: TgtMappedFont;
begin
  Result := TFont.Create;
  LDC := GetDC(0);
  LLangFontLink2 := CoMLangFontLink2.Create;
  SelectObject(LDC, AFont.Handle);
  LCount := Length(AText);
  Result.Assign(AFont);
  Result.Name := 'Arial';
  Result.Size := AFont.Size;

  try
    FLastResult := LLangFontLink2.GetFontCodePages(LDC, AFont.Handle,
      @LFontCodePages);

    if (Succeeded(FLastResult)) then
    begin
      SetLength(LText, LCount);
      LText := AText;
      // while(LCount > 0) do
      begin
        FLastResult := LLangFontLink2.GetStrCodePages(@LText[1], LCount,
          LFontCodePages, @LActualCodePages, @LActualCount);
        FPrevCodePages := LActualCodePages;

        if (Succeeded(FLastResult)) then
        begin
          { if((LActualCodePages and LFontCodePages) <> 0) then
            begin
            Result.Name := AFont.Name;
            end
            else }
          begin
            if LActualCodePages = 0 then
            begin
              Result.Free;
              Result := GetDefaultFont;
              Exit;
            end;

            LFontIndex := FHashCodePages.IndexOf(IntToStr(LActualCodePages));

            if LFontIndex > -1 then
            begin
              LMappedFont := TgtMappedFont(FHashCodePages.Objects[LFontIndex]);
              Result.Name := LMappedFont.FontName;
              Exit;
            end;
            LChar := ' ';
            FLastResult := LLangFontLink2.MapFont(LDC, LActualCodePages, LChar,
              (@LHFont));
            if (Succeeded(FLastResult)) then
            begin
              FillChar(LLogFont, SizeOf(LLogFont), 0);
              GetObject(LHFont, SizeOf(LLogFont), addr(LLogFont));
              Result.Name := LLogFont.lfFaceName;

              LMappedFont := TgtMappedFont.Create(Result.Name);
              FHashCodePages.AddObject(IntToStr(LActualCodePages), LMappedFont);
              LLangFontLink2.ReleaseFont(LHFont);
            end;
          end;
          if (Failed(FLastResult)) then
          begin
            Result.Assign(GetDefaultFont);
            Exit;
          end;
          // LCount := LCount - LActualCount;
          // SetLength(LText, LCount);
          // LText := AnsiRightStr(AText, LCount);
        end;
      end;
    end;
  finally
    ReleaseDC(0, LDC);
  end;
end;

function TgtMapFont.GetNextFontFromUsedList(AFont: TFont;
  var AUsedFontIndex: Integer): TFont;
begin
  Result := TFont.Create;
  try

    if (AUsedFontIndex < FAllUsedFonts.Count) then
    begin
      Result.Charset := AFont.Charset;

      Result.Name := FAllUsedFonts.Strings
        [FAllUsedFonts.Count - 1 - AUsedFontIndex];

      if (AnsiCompareStr(Result.Name, AFont.Name) <> 0) then
      begin
        Result.Size := AFont.Size;
        Inc(AUsedFontIndex);
        Exit;
      end;
      // if font name is same then..
      Inc(AUsedFontIndex);
      if (AUsedFontIndex < FAllUsedFonts.Count) then
      begin
        Result.Name := FAllUsedFonts.Strings
          [FAllUsedFonts.Count - 1 - AUsedFontIndex];
        Result.Size := AFont.Size;
        Inc(AUsedFontIndex);
        Exit;
      end;
    end;
  finally

  end;
end;

function TgtMapFont.GetNextInstalledFont(AFont: TFont;
  var AIndex: Integer): TFont;
begin
  Result := TFont.Create;

  if ((AIndex < 0) or (AIndex >= FSysFontList.Count)) then
  begin
    Result.Assign(AFont);
    Exit;
  end;
  try
    // to pick a font which is not available in FAllUsedFonts list
    if (FAllUsedFonts.IndexOf(FSysFontList.Strings[AIndex]) <> -1) then
    begin
      while (FAllUsedFonts.IndexOf(FSysFontList.Strings[AIndex]) <> -1) do
      begin
        Inc(AIndex);
      end;
    end;

    if (AIndex < FSysFontList.Count) then
    begin
      Result.Name := FSysFontList.Strings[AIndex];
      Result.Size := AFont.Size;
      Result.Charset := AFont.Charset;
      Inc(AIndex);
    end;
  except
    FreeAndNil(Result);
  end;
end;

function TgtMapFont.GetTrueTypeFont(AText: WideString; AFont: TFont): TFont;
var
  LIndex, LI: Integer;
  LIsTrueType: Boolean;
  LMappedObj: TgtMappedFont;
  LFont: TFont;
begin
  Result := AFont;

  try
    LIndex := FMappedFonts.IndexOf(AFont.Name);
    if (LIndex <> -1) then
    begin
      LMappedObj := TgtMappedFont(FMappedFonts.Objects[LIndex]);
      Result.Name := LMappedObj.FontName;
    end
    else
    begin
      LI := FSysFontList.IndexOf(AFont.Name);
      if (LI <> -1) then
      begin
        LIsTrueType := IsTrueType(AFont);
        if LIsTrueType then
        begin
          FMappedFonts.AddObject(AFont.Name, TgtMappedFont.Create(AFont.Name));
        end
        else
        begin
          LFont := GetMappedFont(@AText[1], AFont);
          FMappedFonts.AddObject(AFont.Name, TgtMappedFont.Create(LFont.Name));
          Result.Name := LFont.Name;
          LFont.Free;
        end;
      end
      else if (LI = -1) then
      begin
        LFont := GetMappedFont(@AText[1], AFont);
        FMappedFonts.AddObject(AFont.Name, TgtMappedFont.Create(LFont.Name));
        Result.Name := LFont.Name;
        LFont.Free;
      end;
    end;
  finally

  end;
end;

function TgtMapFont.IsLatinUnicodeRangePresent(AFont: TFont): Boolean;
var
  LIndex: Integer;
  LDC: HDC;
  LFontSig: TFontSignature;
  LUnicodeSubRange: TgtFontUnicodeSubRangeInfo;
begin
  try

    LIndex := FUnicodeSubRangeInfo.IndexOf(AFont.Name);
    if (LIndex <> -1) then
    begin
      LUnicodeSubRange := TgtFontUnicodeSubRangeInfo
        (FUnicodeSubRangeInfo.Objects[LIndex]);
      Result := LUnicodeSubRange.FLatinCharRange;
      Exit;
    end;
    LUnicodeSubRange := TgtFontUnicodeSubRangeInfo.Create(AFont.Name);

    LDC := GetDC(0);
    SelectObject(LDC, AFont.Handle);
    GetTextCharsetInfo(LDC, @LFontSig, 0);
    if (LFontSig.fsUsb[0] and 1) > 0 then
      LUnicodeSubRange.FLatinCharRange := True
    else
      LUnicodeSubRange.FLatinCharRange := False;
    Result := LUnicodeSubRange.FLatinCharRange;
    ReleaseDC(0, LDC);
    FUnicodeSubRangeInfo.AddObject(AFont.Name, LUnicodeSubRange);
  finally

  end;
end;

function SetFontTypeFlag(var LogFont: TEnumLogFont; var ptm: TNewTextMetric;
  FontType: Integer; Data: Pointer): Integer; stdcall;

begin
  boolTrueType := (ptm.tmPitchAndFamily and TMPF_TRUETYPE) = TMPF_TRUETYPE;
  Result := 0;
end;

function TgtMapFont.IsTrueType(AFont: TFont): Boolean;
var
  LDC: HDC;
  LogF: Cardinal;
begin
  LDC := GetDC(0);
  try
    if (AFont.Name = 'Symbol') or (AFont.Name = 'Wingdings') or
      (AFont.Name = 'Wingdings 2') or (AFont.Name = 'Wingdings 3') or
      (AFont.Name = 'Webdings') or (AFont.Name = 'Marlett') then
    begin
      LogF := CreateFont(AFont.Height, TextSize('W', AFont).cx, 0, 0,
        FW_REGULAR, 0, 0, 0, SYMBOL_CHARSET, OUT_TT_ONLY_PRECIS,
        CLIP_DEFAULT_PRECIS, DEFAULT_QUALITY, FF_DONTCARE, PChar(AFont.Name));
      SelectObject(LDC, LogF);
    end
    else
      SelectObject(LDC, AFont.Handle);
    EnumFontFamilies(LDC, PChar(AFont.Name), @SetFontTypeFlag, 0);
    Result := boolTrueType;
  finally
    ReleaseDC(0, LDC);
  end;
end;

procedure TgtMapFont.SetAllUsedFonts(const Value: TStringList);
begin
  FAllUsedFonts := Value;
end;

procedure TgtMapFont.SetLastResult(const Value: HRESULT);
begin
  FLastResult := Value;
end;

procedure TgtMapFont.SetPrevCodePages(const Value: DWORD);
begin
  FPrevCodePages := Value;
end;

{ TgtUsedFont }

constructor TgtMappedFont.Create(AFontName: TFontName);
begin
  FontName := AFontName;
end;

destructor TgtMappedFont.Destroy;
begin
  SetLength(FFontName, 0);
  FFontName := '';
end;

procedure TgtMappedFont.SetFontName(const Value: TFontName);
begin
  FFontName := Value;
end;

{ TgtFontUnicodeSubRangeInfo }

constructor TgtFontUnicodeSubRangeInfo.Create(AFontName: TFontName);
begin
  FLatinCharRange := True;
end;

destructor TgtFontUnicodeSubRangeInfo.Destroy;
begin

  inherited;
end;

procedure TgtFontUnicodeSubRangeInfo.SetLatinCharRange(const Value: Boolean);
begin
  FLatinCharRange := Value;
end;

{ TgtMappedFontSize }

constructor TgtFontSizeMapping.Create(AFont: TFont);
begin
  FFont := TFont.Create;
  FFont.Assign(AFont);
  FInputFontSize := AFont.Size;
end;

destructor TgtFontSizeMapping.Destroy;
begin
  if Assigned(FFont) then
    FreeAndNil(FFont);
  inherited;
end;

procedure TgtFontSizeMapping.SetFont(const Value: TFont);
begin
  FFont := Value;
end;

procedure TgtFontSizeMapping.SetInputFontSize(const Value: Integer);
begin
  FInputFontSize := Value;
end;

initialization

FontList := TStringList.Create;
FontList.AddStrings(Screen.Fonts);
{ while (FontList.Count > 0) do
  begin
  if (FontList.Strings[0][1] = '@') then
  FontList.Delete(0)
  else
  Break;
  end;
}
// We'll use Arial Unicode MS as a last resort when performing font mapping
// (when it has not been explicitly selected), as it's a very heavy font and
// takes longer to process.
ArialUni := UpperCase('Arial Unicode MS');
LCount := FontList.Count - 1;
for I := 0 to LCount do
  if UpperCase(FontList[I]) = ArialUni then
  begin
    ArialUni := FontList[I];
    FontList.Delete(I);
    FontList.Append(ArialUni);
    Break;
  end;

finalization

FontList.Free;

end.
