unit PDTextExportDev;

interface

uses
  Classes, Windows, gtObject, PDExportDevice, PDState, PDMatrix, gtTypes, Graphics,
  PDRect, Contnrs, Math, PDSearchDev, gtWidestrings, SysUtils;

type

  TgtTextExport = class(TgtPDSearchDev)
  private
    FXFactor,
    FYFactor: Double;
    FPageLineCount,
    FColumnSpacing: Integer;

    FStringList, FTempStrList: TgtWideStringList;
    FNeedFormatting: Boolean;

    procedure EncodeText(AText: TgtLine);
    function RemoveTerminalCRLF(AString: WideString): WideString;
    function TextSize(const Text: AnsiString; AFont: TFont): TSize; overload;

    // Sort Text by X Cord
    procedure SortLineByXCord(AList: TgtWideStringList);
  public
    constructor Create(AStrList: TgtWideStringList; ANeedFormattting: Boolean);
    destructor Destroy; override;
    procedure EndPage; override;
  end;

implementation


{ TgtTextExport }

constructor TgtTextExport.Create(AStrList: TgtWideStringList; ANeedFormattting: Boolean);
var
  LFont: TFont;
  LSize: TSize;
begin
  FNeedFormatting := ANeedFormattting;
  if ANeedFormattting then
  begin
    FStringList := AStrList;
    FTempStrList := TgtWidestringList.Create;
    inherited Create(FTempStrList);
  end
  else
    inherited Create(AStrList);
  LFont := TFont.Create;
  LFont.Name := 'MS Sans Serif';
  LFont.Size := 8;
  LSize := TextSize('W', LFont);
  FXFactor := LSize.cx;
  FYFactor := LSize.cy;
  FPageLineCount := 0;
  FColumnSpacing := 1;
end;

destructor TgtTextExport.Destroy;
begin

  inherited;
end;

procedure TgtTextExport.EncodeText(AText: TgtLine);
var
  LText, LStr: WideString;
  LX, LY, LI: Integer;
begin
  LText := RemoveTerminalCRLF(AText.Text);
  LX := Ceil(AText.Rects[0].Left / FXFactor);
  if (FColumnSpacing >= 0) then LX := LX * (FColumnSpacing + 1);
  LY := (Ceil(AText.Rects[0].Bottom / FYFactor)) + FPageLineCount;

  if LY >= FStringList.Count then
  begin
    LI := FStringList.Count;
    while (LI < LY) do
    begin
      FStringList.Add('');
      Inc(LI);
    end;
    FStringList.Add(StringOfChar(' ', LX) + LText);
  end
  else
  begin
    LStr := RemoveTerminalCRLF(FStringList.Strings[LY]);
    if LX > Length(LStr) then
      LStr := LStr + StringOfChar(' ', LX - Length(LStr))
    else
      System.Delete(LStr, LX, Length(AText.Text));
    System.Insert(LText, LStr, LX);
    FStringList[LY] := LStr;
  end;
end;

procedure TgtTextExport.EndPage;
var
  I: Integer;
begin
  inherited;

  if FNeedFormatting then
  begin
    try
      for I := 0 to FTempStrList.Count - 1 do
      begin
        EncodeText(TgtLine(FTempStrList.Objects[I]));
      end;
    finally
      for I := 0 to FTempStrList.Count - 1 do
        TgtLine(FTempStrList.Objects[I]).Free;
      FreeAndNil(FTempStrList);
    end;
  end;
end;

function TgtTextExport.RemoveTerminalCRLF(AString: WideString): WideString;
var
  LLength: Integer;
begin
	LLength := Length(AString);
  SetLength(Result, LLength);
  Result := AString;
  if (LLength > 1) then begin
    if (AString[LLength - 1] = #13) and (AString[LLength] = #10) then
    begin
      SetLength(Result, (LLength - 2));
//      Result := Copy(AString, 1, LLength - 2);
    end;
  end;
end;

procedure TgtTextExport.SortLineByXCord(AList: TgtWideStringList);
var
  LList: TgtWideStringList;
  LLine: TgtLine;
  I: Integer;
begin
//  for I := 0 to LList.Count - 1 do
//  begin
//    LLine := TgtLine(AList.Objects[I]);
//    try
//      LList := TStringList.Create;
//      LList.DelimitedText := LLine.Text;
//    finally
//      LList.Free;
//    end;
//  end;
end;

function TgtTextExport.TextSize(const Text: AnsiString; AFont: TFont): TSize;
var
  DC: HDC;
  SaveFont: HFont;
  LSize: Tsize;
  LFont: TFont;
begin
  LFont := TFont.Create;
  LFont.Name := AFont.Name;
  LFont.Size := AFont.Size;
  LFont.Style := AFont.Style;
  LFont.Color := AFont.Color;
  try
    DC := GetDC(0);
    SaveFont := SelectObject(DC, LFont.Handle);
    GetTextExtentPoint32A(DC, PAnsiChar(Text), Length(Text), LSize);
    SelectObject(DC, SaveFont);
  finally
    ReleaseDC(0, DC);
    LFont.Free;
  end;
  Result := LSize;
end;

end.
