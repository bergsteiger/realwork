{*******************************************************}
{                                                       }
{             Delphi FireMonkey Platform                }
{ Copyright(c) 2012-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit FMX.FontGlyphs.Win;

interface

uses
  System.Types, System.Classes, System.SysUtils, System.UITypes, System.UIConsts,
  System.Generics.Collections, System.Generics.Defaults,
  Winapi.Windows,
  FMX.Types, FMX.Surfaces, FMX.FontGlyphs, FMX.PixelFormats;

{$SCOPEDENUMS ON}

type

  TWinFontGlyphManager = class(TFontGlyphManager)
  private
    FBitmapInfo: TBitmapInfo;
    FDC: HDC;
    FBitmap: HBITMAP;
    FBitmapBits: PAlphaColorRecArray;
    FFont: HFONT;
  protected
    procedure LoadResource; override;
    procedure FreeResource; override;
    function DoGetGlyph(const Char: UCS4Char; const Settings: TFontGlyphSettings): TFontGlyph; override;
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  System.Math, System.Character;

const
  BitmapSize = 256;

{ TWinFontGlyphManager }

constructor TWinFontGlyphManager.Create;
begin
  inherited Create;
  FDC := CreateCompatibleDC(0);
  ZeroMemory(@(FBitmapInfo.bmiHeader), SizeOf(TBitmapInfoHeader));
  FBitmapInfo.bmiHeader.biSize := SizeOf(TBitmapInfoHeader);
  FBitmapInfo.bmiHeader.biWidth := BitmapSize;
  FBitmapInfo.bmiHeader.biHeight := -BitmapSize;
  FBitmapInfo.bmiHeader.biPlanes := 1;
  FBitmapInfo.bmiHeader.biCompression := BI_RGB;
  FBitmapInfo.bmiHeader.biBitCount := 32;
  FBitmap := CreateDIBSection(FDC, FBitmapInfo, DIB_RGB_COLORS, Pointer(FBitmapBits), 0, 0);
  SetMapMode(FDC, MM_TEXT);
  SelectObject(FDC, FBitmap);
end;

destructor TWinFontGlyphManager.Destroy;
begin
  FBitmapBits := nil;
  DeleteObject(FBitmap);
  DeleteDC(FDC);
  inherited;
end;

procedure TWinFontGlyphManager.LoadResource;
var
  Height: Integer;
  dwBold, dwItalic, dwUnderline, dwStrikeOut: Cardinal;
begin
  Height := -Round(CurrentSettings.Size * CurrentSettings.Scale);
  if TFontStyle.fsBold in CurrentSettings.Style then
    dwBold := FW_BOLD
  else
    dwBold := FW_NORMAL;
  if TFontStyle.fsItalic in CurrentSettings.Style then
    dwItalic := 1
  else
    dwItalic := 0;
  if TFontStyle.fsUnderline in CurrentSettings.Style then
    dwUnderline := 1
  else
    dwUnderline := 0;
  if TFontStyle.fsStrikeOut in CurrentSettings.Style then
    dwStrikeOut := 1
  else
    dwStrikeOut := 0;
  FFont := CreateFont(Height, 0, 0, 0, dwBold, dwItalic,
    dwUnderline, dwStrikeOut, DEFAULT_CHARSET, OUT_DEFAULT_PRECIS,
    CLIP_DEFAULT_PRECIS, ANTIALIASED_QUALITY,
    DEFAULT_PITCH or FF_DONTCARE, PChar(CurrentSettings.Family));
  if FFont = 0 then
    Exit;
  SelectObject(FDC, FFont);
end;

procedure TWinFontGlyphManager.FreeResource;
begin
  if FFont <> 0 then
    DeleteObject(FFont);
  FFont := 0;
end;

function TWinFontGlyphManager.DoGetGlyph(const Char: UCS4Char; const Settings: TFontGlyphSettings): TFontGlyph;
var
  CharsString: string;
  TM: TTextMetric;
  Abc: TABCFLOAT;
  CharSize: TSize;
  GlyphRect: TRect;
  I, J: Integer;
  C: Byte;
  Color: TAlphaColorRec;
  GlyphStyle: TFontGlyphStyles;
begin
  GetTextMetrics(FDC, tm);
  CharsString := System.Char.ConvertFromUtf32(Char);
  GetTextExtentPoint32W(FDC, CharsString, 1, CharSize);
  GetCharABCWidthsFloat(FDC, Char, Char, Abc);

  if TFontGlyphSetting.gsBitmap in Settings then
  begin
    FillChar(FBitmapBits^, BitmapSize * BitmapSize * 4, 0);

    SetTextColor(FDC, RGB(255, 255, 255));
    SetBkColor(FDC, 0);
    SetTextAlign(FDC, TA_TOP);
    TextOut(FDC, 0, 0, @Char, 1);

    // search for minimal non transprent rect
    GlyphRect := TRect.Create(MaxInt, MaxInt, 0, 0);
    for I := 0 to CharSize.cx - 1 do
      for J := 0 to CharSize.cy - 1 do
      begin
        C := FBitmapBits[J * BitmapSize + I].R;
        if C > 0 then
        begin
          if J < GlyphRect.Top then
            GlyphRect.Top := J;
          if I < GlyphRect.Left then
            GlyphRect.Left := I;
        end;
      end;
    for I := CharSize.cx - 1 downto GlyphRect.Left do
      for J := CharSize.cy - 1 downto GlyphRect.Top do
      begin
        C := FBitmapBits[J * BitmapSize + I].R;
        if C > 0 then
        begin
          if J > GlyphRect.Bottom then
            GlyphRect.Bottom := J;
          if I > GlyphRect.Right then
            GlyphRect.Right := I;
        end;
      end;
    GlyphRect.Left := Min(CharSize.cx, GlyphRect.Left);
    GlyphRect.Top := Min(CharSize.cx, GlyphRect.Top);
    GlyphRect.Right := Max(CharSize.cx, GlyphRect.Right + 1);
    GlyphRect.Bottom := Max(CharSize.cy, GlyphRect.Bottom + 1);
  end;

  GlyphStyle := [];
  if not HasGlyph(Char) then
    GlyphStyle := [TFontGlyphStyle.NoGlyph];

  Result := TFontGlyph.Create(GlyphRect.TopLeft, Abc.abcfA + Abc.abcfB + Abc.abcfC, CharSize.Height,
    GlyphStyle);

  if TFontGlyphSetting.gsBitmap in Settings then
  begin
    Result.Bitmap.SetSize(GlyphRect.Width, GlyphRect.Height, TPixelFormat.pfA8R8G8B8);

    for I := GlyphRect.Left to GlyphRect.Right - 1 do
      for J := GlyphRect.Top to GlyphRect.Bottom - 1 do
      begin
        Color := FBitmapBits[J * BitmapSize + I];
        if Color.R > 0 then
        begin
          C := (Color.R + Color.G + Color.B) div 3;
          if TFontGlyphSetting.gsPremultipliedAlpha in Settings then
            Result.Bitmap.Pixels[I - GlyphRect.Left, J - GlyphRect.Top] := MakeColor(C, C, C, C)
          else
            Result.Bitmap.Pixels[I - GlyphRect.Left, J - GlyphRect.Top] := MakeColor($FF, $FF, $FF, C);
        end;
      end;
  end;
end;

end.
