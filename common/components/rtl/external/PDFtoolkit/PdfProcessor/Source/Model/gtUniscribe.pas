{$I ..\Utils\gtCompilerDefines.inc}
unit gtUniscribe;

interface

uses
  Graphics, Windows, Classes;

type
  TgtWordArray = array of Word;

  // AText: Complete text
  // ARunIndex: Zero-based index for the script runs
  // AIsComplex: True if the text represents a complex script
  // Glyph Info List: List of TgtGlyphInfo objects for this script run
  TgtScriptRunCallback = procedure(AText: WideString; ARunIndex, ARunCount: Integer;
    AIsComplex: Boolean; var AGlyphInfoList: TList) of object;

  TgtGlyphInfo = class
  private
    FID: Word;
    FAdvWidth: Integer;
    FABCWidth: ABC;
    FPosition: Integer;
    FFontName: string;

    class function ZeroGlyphs(AGlyphIDs: array of Word; ACount: Integer): Boolean;
    class function GetNextFont(AFont: TFont; var AIndex: Integer): TFont;
  public
    constructor Create(AID: Word; AAdvWidth: Integer; AABCWidth: ABC;
      APos: Integer; AFont:TFont);
    destructor Destroy; override;

    class procedure StringAnalyze(AText: WideString; AFont: TFont;
      AScriptRunCallback: TgtScriptRunCallback);

    property ID: Word read FID;
    property AdvWidth: Integer read FAdvWidth;
    property ABCWidth: ABC read FABCWidth;
    property Position: Integer read FPosition;
    property FontName: string read FFontName;
  end;

implementation

uses
  gtPDUsp10, Forms, {$IFDEF VCL6ORABOVE} StrUtils{$ELSE} gtStrUtils{$ENDIF}, SysUtils;

var
  FontList: TStringList;

class procedure TgtGlyphInfo.StringAnalyze(AText: WideString; AFont: TFont;
  AScriptRunCallback: TgtScriptRunCallback);
var
  LPInChars: PWideChar;
  LScriptControl: TScriptControl;
  LScriptState: TScriptState;

  LScriptItems: array of TScriptItem;
  LScriptItemCount: Integer;
  LResult: HRESULT;
  LMaxScriptItems: Integer;

  LBiDiLevels: array of Byte;
  LVisual2Logical: array of Integer;
  LI: Integer;

  LJ, LK: Integer;
  LN: Integer;
  LHdc: HDC;
  LScriptCache: TScriptCache;
  LScriptItemLength: Integer;
  LMaxGlyphIDs: Integer;
  LItemGlyphCnt: Integer;
  LAdvWidths: array of Integer;
  LItemGlyphIDs: array of Word;
  LLogClust: array of Word;
  LVisAttr: array of TScriptVisAttr;

  LGlyphOffsets: array of TGOffset;
  LScriptItemABC: ABC;

  LGlyphInfo: TgtGlyphInfo;
  LPos: Integer;
  LFontMapped: Boolean;
  LMappedFont: TFont;
  LRunInfoList: TList;
  LIsComplex: Boolean;
  LSubText: WideString;
  LX: Integer;
begin
  LFontMapped := False;
  if (AText = '') then
    Exit;
  if (not Assigned(AScriptRunCallback)) then
    Exit;
  LPInChars := PWideChar(AText);

  // Is complex?
  //LIsComplex := (ScriptIsComplex(LPInChars, Length(AText),
    //SIC_COMPLEX or SIC_NEUTRAL) = S_OK);

  // Init
  with LScriptControl do
  begin
    uDefaultLanguage := 0;
    fFlags := [];
    fReserved := 0;
  end;
  with LScriptState do
  begin
    uBidiLevel := 0;
    fFlags := [];
  end;

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
    LN := 0;
    LK := LVisual2Logical[LI];
    LScriptItemLength := LScriptItems[LK + 1].iCharPos -
      LScriptItems[LK].iCharPos;
    LMaxGlyphIDs := LScriptItemLength;
    SetLength(LLogClust, LScriptItemLength);
    LPInChars := @(AText[LScriptItems[LK].iCharPos + 1]);
    LSubText := '';
    for LX := (LScriptItems[LK].iCharPos + 1) to (LScriptItems[LK + 1].iCharPos) do
      LSubText := LSubText + AText[LX];
    // space, punctuation marks etc. are under SIC_NEUTRAL
    LIsComplex := (ScriptIsComplex(LPInChars, LScriptItemLength,
      SIC_COMPLEX) = S_OK);

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
      LResult := ScriptShape(LHdc, @LScriptCache, LPInChars, LScriptItemLength,
        LMaxGlyphIDs, @(LScriptItems[LK].a), @LItemGlyphIDs[0],
        @LLogClust[0], @LVisAttr[0], @LItemGlyphCnt);
      if (LResult = E_OUTOFMEMORY) then
        Inc(LMaxGlyphIDs)
      else if ((LResult = Integer(USP_E_SCRIPT_NOT_IN_FONT)) or
        (ZeroGlyphs(LItemGlyphIDs, LItemGlyphCnt))) then
      begin
        // If ZeroGlyphs, it means script not in font
        LResult := Integer(USP_E_SCRIPT_NOT_IN_FONT);
        if Assigned(LMappedFont) then
          FreeAndNil(LMappedFont);
        LMappedFont := GetNextFont(AFont, LN);

        if not Assigned(LMappedFont) then
          Break;
        SelectObject(LHdc, LMappedFont.Handle);
        LFontMapped := True;
      end;
    until (LResult = S_OK);

    if (LResult = Integer(USP_E_SCRIPT_NOT_IN_FONT)) then
      Continue;
    // ScriptPlace
    SetLength(LAdvWidths, LItemGlyphCnt);
    SetLength(LGlyphOffsets, LItemGlyphCnt);
    ScriptPlace(LHdc, @LScriptCache, @LItemGlyphIDs[0],
      LItemGlyphCnt, @LVisAttr[0], @(LScriptItems[LK].a),
      @LAdvWidths[0], @LGlyphOffsets[0], @LScriptItemABC);

    LRunInfoList := TList.Create;

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

    // Call back with info for this text script run
    if (Assigned(AScriptRunCallback)) then
      AScriptRunCallback(LSubText, LI, LScriptItemCount, LIsComplex, LRunInfoList);

    LAdvWidths := nil;
    LLogClust := nil;
    LVisAttr := nil;
    LGlyphOffsets := nil;
    LItemGlyphIDs := nil;
  end;
  ScriptFreeCache(@LScriptCache);
  ReleaseDC(0, LHdc);
  if Assigned(LMappedFont) then
    FreeAndNil(LMappedFont);
end;

constructor TgtGlyphInfo.Create(AID: Word; AAdvWidth: Integer;
  AABCWidth: ABC; APos: Integer; AFont: TFont);
begin
  FID := AID;
  FAdvWidth := AAdvWidth;
  FABCWidth := AABCWidth;
  FPosition := APos;
  FFontName := AFont.Name;
end;

class function TgtGlyphInfo.ZeroGlyphs(AGlyphIDs: array of Word; ACount: Integer): Boolean;
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

class function TgtGlyphInfo.GetNextFont(AFont: TFont; var AIndex: Integer): TFont;
begin
  Result := nil;
  if ((AIndex < 0) or (AIndex >= FontList.Count)) then
    Exit;
  Result := TFont.Create;
  try
    Result.Name := FontList.Strings[AIndex];
    Result.Size := AFont.Size;
  except
    FreeAndNil(Result);
  end;
  Inc(AIndex);
end;

destructor TgtGlyphInfo.Destroy;
begin
  inherited;
end;

initialization
  FontList := TStringList.Create;
  FontList.AddStrings(Screen.Fonts);
  while (FontList.Count > 0) do
  begin
    if (FontList.Strings[0][1] = '@') then
      FontList.Delete(0)
    else
      Break;
  end;

finalization
  FontList.Free;

end.
