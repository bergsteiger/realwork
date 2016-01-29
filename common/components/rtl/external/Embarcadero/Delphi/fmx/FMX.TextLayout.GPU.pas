{*******************************************************}
{                                                       }
{             Delphi FireMonkey Platform                }
{ Copyright(c) 2012-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit FMX.TextLayout.GPU;

{$MINENUMSIZE 4}

interface

uses
  System.Types, System.UITypes, System.UIConsts, System.Math,
  System.Classes, System.SysUtils, System.StrUtils,
  System.Generics.Collections, System.Generics.Defaults,
  FMX.Types, FMX.Surfaces, FMX.TextLayout, FMX.FontGlyphs;

{$SCOPEDENUMS ON}

type

  PCharRec = ^TCharRec;
  TCharRec = record
    Glyph: TFontGlyph;
    SrcRect: TRectF;
    Bitmap: TBitmap;
  end;

  TCharDic = class(TDictionary<UCS4Char, PCharRec>)
  private
    procedure CharRecNotifyHandler(Sender: TObject; const Value: PCharRec;
      Action: TCollectionNotification);
  public
    constructor Create(ACapacity: Integer = 0);
  end;

  TFamilyDic = class(TDictionary<Int64, TCharDic>)
  private
    procedure CharDicNotifyHandler(Sender: TObject; const Value: TCharDic;
      Action: TCollectionNotification);
  public
    constructor Create;
  end;

(*
  --------GPUFrame-------------
  |(GPURun)(GPURun)...(GPURun)| <- GPULine (several GPURun's with different font and/or color)
  |(GPURun)                   | <- GPULine (no additional styling, so only a single GPURun)
  |(GPURun)                   | <- GPULine
  |                           | ...
  |                           |
  |                           |
  -----------------------------
*)

  TGPURun = class
  private
    FChars: TList<UCS4Char>;
    FStartIndex: Integer;
    FLength: Integer;
    FImageRect: TRectF;
    FColor: TAlphaColor;
    FFont: TFont;
    FIsDefaultColor: Boolean;
    FTrimmed: Boolean;
    FClipBounds: TList<TRectF>;
    FClipped: Boolean;
  public
    constructor Create;
    destructor Destroy; override;
    procedure SetColor(AColor: TAlphaColor; IsDefault: Boolean);
    procedure Clip;
    procedure SetText(const AText: string; const AStartIndex, ALength: Integer);
    procedure DeleteTextFromStart(ACount: Integer);
    procedure DeleteTextFromEnd(ACount: Integer);
    //
    property Chars: TList<UCS4Char> read FChars;
    property StartIndex: Integer read FStartIndex;
    property Length: Integer read FLength;
    property ImageRect: TRectF read FImageRect write FImageRect;
    property Color: TAlphaColor read FColor;
    property IsDefaultColor: Boolean read FIsDefaultColor;
    property Font: TFont read FFont write FFont;
    property IsTrimmed: Boolean read FTrimmed write FTrimmed;
    property IsClipped: Boolean read FClipped;
    property ClipBounds: TList<TRectF> read FClipBounds;
  end;

  TGPULine = class(TList<TGPURun>)
  private
    FHeight: Single;
    FWidth: Single;
    FTopLeft: TPointF;
    procedure ListNotifyHandler(Sender: TObject; const Item: TGPURun;
      Action: TCollectionNotification);
  public
    constructor Create;
    destructor Destroy; override;
    //
    property Height: Single read FHeight write FHeight;
    property Width: Single read FWidth write FWidth;
    property TopLeft: TPointF read FTopLeft write FTopLeft;
  end;

  TGPUFrame = class(TList<TGPULine>)
  private
    FHeight: Single;
    FWidth: Single;
    FTopLeft: TPointF;
    procedure ListNotifyHandler(Sender: TObject; const Item: TGPULine;
      Action: TCollectionNotification);
  public
    constructor Create;
    //
    property TopLeft: TPointF read FTopLeft write FTopLeft;
    property Height: Single read FHeight write FHeight;
    property Width: Single read FWidth write FWidth;
  end;

  TTextLayoutNG = class(TTextLayout)
  const
    AntiAliasMargin = 1;
  private class var
    FFamilyDic: TFamilyDic;
    FCharMaps: TList<TBitmap>; // Map to font glyphs
    FCharMapPos: TPoint; // Curent position for add
    FMaxCharHeightOnLine: Integer;
    FRendering: Integer;
    FNewGlyphList: TList<PCharRec>;
    FDisableGlyphPopulation: Boolean;
  private
    FOldColor: TAlphaColor;
    F3DLayout: TTextLayout;
    FScale: Single;
    FScaleFactor: Single;
    FFrame: TGPUFrame;
    FEllipsisChar: UCS4Char;
    FFontKey: Int64;
    function MeasureRange(const APos, ALength: Integer): TRegion;
    function GetCharDictionary(const AFont: TFont = nil): TCharDic;
    procedure UpdateCharRec(const ACanvas: TCanvas; NeedBitmap: Boolean; var NewRec: PCharRec; HasItem: Boolean;
      const CharDic: TCharDic; const AFont: TFont; const Ch: UCS4Char);
    function AddOrGetChar(const ACanvas: TCanvas; const Ch: UCS4Char; const CharDic: TCharDic;
      const AFont: TFont): PCharRec;
  protected
    procedure DoRenderLayout; override;
    procedure DoDrawLayout(const ACanvas: TCanvas); override;
    function GetTextHeight: Single; override;
    function GetTextWidth: Single; override;
    function GetTextRect: TRectF; override;
    function DoPositionAtPoint(const APoint: TPointF): Integer; override;
    function DoRegionForRange(const ARange: TTextRange): TRegion; override;
  public
    constructor Create(const ACanvas: TCanvas = nil); override;
    destructor Destroy; override;
    class procedure Uninitialize;
    class procedure BeginRender;
    class procedure EndRender;
    class property CharMaps: TList<TBitmap> read FCharMaps;
    class property DisableGlyphPopulation: Boolean read FDisableGlyphPopulation write FDisableGlyphPopulation;
    //
    procedure ConvertToPath(const APath: TPathData); override;
  end;

implementation

uses
  FMX.Platform, FMX.Canvas.GPU, FMX.Text, System.Character;

const
  BitmapSize = 1024;

function FontStyleToInt(const AStyle: TFontStyles): Cardinal;
begin
  Result := $F00000;
  if TFontStyle.fsBold in AStyle then
    Result := Result + $10000;
  if TFontStyle.fsItalic in AStyle then
    Result := Result + $10000;
  if TFontStyle.fsUnderline in AStyle then
    Result := Result + $10000;
end;

function FontFamilyToInt(const AFamily: string): Int64;
var
  I: Integer;
begin
  Result := AFamily.Length;
  for I := 0 to AFamily.Length - 1 do
    Result := Result + Ord(AFamily.Chars[I]);
end;

function FontFalimyKey(const AFont: TFont; const AScale: Single): Int64;
begin
  if SameValue(AScale, 1.0, Epsilon) then
    Result := $FF000000 + FontFamilyToInt(AFont.Family) + FontStyleToInt(AFont.Style) + (1000 * Trunc(AFont.Size))
  else
    Result := $0F000000 + FontFamilyToInt(AFont.Family) + FontStyleToInt(AFont.Style) + (1000 * Trunc(AFont.Size));
end;

function IsCombiningCharacter(const Ch: Char): Boolean;
begin
  Result := Ch.GetUnicodeCategory in [TUnicodeCategory.ucCombiningMark, TUnicodeCategory.ucEnclosingMark, TUnicodeCategory.ucNonSpacingMark]
end;

{ TCharDic }

procedure TCharDic.CharRecNotifyHandler(Sender: TObject; const Value: PCharRec;
  Action: TCollectionNotification);
begin
  if Action = cnRemoved then
  begin
    FreeAndNil(Value.Glyph);
//    FreeAndNil(Value.Bitmap);
    Dispose(Value);
  end;
end;

constructor TCharDic.Create(ACapacity: Integer);
begin
  inherited Create(ACapacity);
  OnValueNotify := CharRecNotifyHandler;
end;

{ TFamilyDic }

procedure TFamilyDic.CharDicNotifyHandler(Sender: TObject; const Value: TCharDic;
  Action: TCollectionNotification);
begin
  if Action = cnRemoved then
    Value.DisposeOf;
end;

constructor TFamilyDic.Create;
begin
  inherited Create;
  OnValueNotify := CharDicNotifyHandler;
end;

{ TNGRun }

procedure TGPURun.Clip;
var
  I: Integer;
begin
  if not FClipped then
  begin
    FClipped := True;
    FClipBounds := TList<TRectF>.Create;
    for I := 0 to FChars.Count - 1 do
      FClipBounds.Add(TRectF.Empty);
  end;
end;

constructor TGPURun.Create;
begin
  FChars := TList<UCS4Char>.Create;
  FIsDefaultColor := True;
  FClipBounds := nil;
  FClipped := False;
end;

procedure TGPURun.DeleteTextFromEnd(ACount: Integer);
var
  CharsLength: Integer;
begin
  while ACount > 0 do
  begin
    CharsLength := System.Char.ConvertFromUtf32(FChars.Last).Length;
    Dec(FLength, CharsLength);
    FChars.Delete(FChars.Count - 1);
    FClipBounds.Delete(FClipBounds.Count - 1);
    Dec(ACount);
  end;
end;

procedure TGPURun.DeleteTextFromStart(ACount: Integer);
var
  CharsLength: Integer;
begin
  while ACount > 0 do
  begin
    CharsLength := System.Char.ConvertFromUtf32(FChars[0]).Length;
    Inc(FStartIndex, CharsLength);
    Dec(FLength, CharsLength);
    FChars.Delete(0);
    FClipBounds.Delete(0);
    Dec(ACount);
  end;
end;

destructor TGPURun.Destroy;
begin
  FreeAndNil(FChars);
  FreeAndNil(FFont);
  FreeAndNil(FClipBounds);
  inherited;
end;

procedure TGPURun.SetColor(AColor: TAlphaColor; IsDefault: Boolean);
begin
  if IsDefault then
    if IsDefaultColor then
    //Just changing value of default color
      FColor := AColor
    else
  else
  begin
    //Overriding default color with attribute color
    FColor := AColor;
    FIsDefaultColor := False;
  end;
end;


procedure TGPURun.SetText(const AText: string; const AStartIndex, ALength: Integer);
var
  I, CharLength: Integer;
begin
  FStartIndex := AStartIndex;
  FLength := ALength;
  FChars.Clear;
  I := 0;
  while I < FLength do
  begin
    FChars.Add(System.Char.ConvertToUtf32(AText, I + FStartIndex, CharLength));
    Inc(I, CharLength);
  end;
end;

{ TNGLine }

constructor TGPULine.Create;
begin
  FHeight := 0;
  FWidth := 0;
  inherited Create;
  OnNotify := ListNotifyHandler;
end;

destructor TGPULine.Destroy;
begin
  inherited;
end;

procedure TGPULine.ListNotifyHandler(Sender: TObject; const Item: TGPURun;
  Action: TCollectionNotification);
begin
  if Action = cnRemoved then
    Item.DisposeOf;
end;

{ TNGFrame }

constructor TGPUFrame.Create;
begin
  FHeight := 0;
  FWidth := 0;
  FTopLeft := TPointF.Create(0, 0);
  inherited Create;
  OnNotify := ListNotifyHandler;
end;

procedure TGPUFrame.ListNotifyHandler(Sender: TObject; const Item: TGPULine;
  Action: TCollectionNotification);
begin
  if Action = cnRemoved then
    Item.DisposeOf;
end;

{ TTextLayoutNG }

constructor TTextLayoutNG.Create(const ACanvas: TCanvas);
var
  ScreenSrv: IFMXScreenService;
begin
  inherited Create(ACanvas);
  if not Assigned(FFamilyDic) then
  begin
    FFamilyDic := TFamilyDic.Create;
    FCharMaps := TList<TBitmap>.Create;
  end;
  if TPlatformServices.Current.SupportsPlatformService(IFMXScreenService, IInterface(ScreenSrv)) then
    FScale := ScreenSrv.GetScreenScale
  else
    FScale := 1;
  FScaleFactor := 1 / FScale;
  FFrame := TGPUFrame.Create;
  F3DLayout := nil;
  FEllipsisChar := $2026; // '...' character
end;

destructor TTextLayoutNG.Destroy;
begin
  FreeAndNil(FFrame);
  FreeAndNil(F3DLayout);
  inherited;
end;

class procedure TTextLayoutNG.Uninitialize;
begin
  if Assigned(FNewGlyphList) then
    FreeAndNil(FNewGlyphList);
  if Assigned(FCharMaps) then
    FreeAndNil(FCharMaps);
  if Assigned(FFamilyDic) then
    FreeAndNil(FFamilyDic);
  TFontGlyphManager.UnInitialize;
end;

procedure TTextLayoutNG.ConvertToPath(const APath: TPathData);
var
  I: Integer;
  R: TRectF;
begin
  if not Assigned(F3DLayout) then
  begin
    TCanvasManager.EnableSoftwareCanvas(True);
    F3DLayout := TTextLayoutManager.TextLayoutByCanvas(TCanvasManager.DefaultCanvas).Create;
    TCanvasManager.EnableSoftwareCanvas(False);
    F3DLayout.BeginUpdate;
    F3DLayout.Text := Text;
    F3DLayout.Padding := Padding;
    F3DLayout.WordWrap := WordWrap;
    F3DLayout.HorizontalAlign := HorizontalAlign;
    F3DLayout.VerticalAlign := VerticalAlign;
    F3DLayout.Color := Color;
    F3DLayout.Font := Font;
    F3DLayout.Opacity := Opacity;
    F3DLayout.Trimming := Trimming;
    F3DLayout.RightToLeft := RightToLeft;
    F3DLayout.MaxSize := MaxSize;
    F3DLayout.TopLeft := TopLeft;
    for I := 0 to AttributesCount - 1 do
      F3DLayout.AddAttribute(Attributes[I]);
    F3DLayout.EndUpdate;
    TCanvasManager.EnableSoftwareCanvas(False);
  end;
  if Assigned(F3DLayout) then
  begin
    F3DLayout.ConvertToPath(APath);
    R := F3DLayout.TextRect;
    FFrame.TopLeft := R.TopLeft;
    FFrame.Height := R.Height;
    FFrame.Width := R.Width;
  end;
end;

procedure TTextLayoutNG.UpdateCharRec(const ACanvas: TCanvas; NeedBitmap: Boolean; var NewRec: PCharRec;
  HasItem: Boolean; const CharDic: TCharDic; const AFont: TFont; const Ch: UCS4Char);
var
  Map: TBitmapData;
  J: Integer;
  Bitmap: TBitmap;
  LFont: TFont;
  GlyphSettings: TFontGlyphSettings;
begin
  if not HasItem then
    New(NewRec)
  else
  begin
    FreeAndNil(NewRec.Glyph);
    FreeAndNil(NewRec.Bitmap);
  end;
  //
  if not Assigned(AFont) then
    LFont := Self.Font
  else
    LFont := AFont;
  GlyphSettings := [];
  if NeedBitmap then
    GlyphSettings := [TFontGlyphSetting.gsBitmap, TFontGlyphSetting.gsPremultipliedAlpha];

  NewRec.Glyph := TFontGlyphManager.Current.GetGlyph(Ch, LFont, FScale, GlyphSettings);
  if (NewRec.Glyph.Bitmap.Width > 0) and (NewRec.Glyph.Bitmap.Height > 0) then
  begin
    if FRendering > 0 then
    begin
      Bitmap := TBitmap.Create(NewRec.Glyph.Bitmap.Width, NewRec.Glyph.Bitmap.Height);
      IBitmapAccess(Bitmap).BitmapScale := FScale;

      if Bitmap.Map(TMapAccess.maWrite, Map) then
      try
        // fill result
        NewRec.Bitmap := Bitmap;
        NewRec.SrcRect := RectF(0, 0, NewRec.Glyph.Bitmap.Width, NewRec.Glyph.Bitmap.Height);
        // write glyph to map
        for J := 0 to NewRec.Glyph.Bitmap.Height - 1 do
          Move(NewRec.Glyph.Bitmap.Scanline[J]^, Map.GetPixelAddr(0, J)^, NewRec.Glyph.Bitmap.Pitch);
      finally
        Bitmap.Unmap(Map);
      end;
      if not Assigned(FNewGlyphList) then
        FNewGlyphList := TList<PCharRec>.Create;
      FNewGlyphList.Add(NewRec);
    end
    else
    begin
      // Get current bitmap
      if (FCharMaps.Count = 0) or ((BitmapSize - FCharMapPos.X < NewRec.Glyph.Bitmap.Width - AntiAliasMargin) and
        (BitmapSize - FCharMapPos.Y < NewRec.Glyph.Bitmap.Height - AntiAliasMargin)) then
      begin
        Bitmap := TBitmap.Create(BitmapSize, BitmapSize);
        IBitmapAccess(Bitmap).BitmapScale := FScale;
        FCharMaps.Add(Bitmap);
        FMaxCharHeightOnLine := 0;
        FCharMapPos.Y := AntiAliasMargin;
        FCharMapPos.X := AntiAliasMargin;
      end
      else
        Bitmap := FCharMaps[FCharMaps.Count - 1];
      if Bitmap.Map(TMapAccess.maWrite, Map) then
      try
        // check for enough place
        if FCharMapPos.X + NewRec.Glyph.Bitmap.Width > Bitmap.Width then
        begin
          FCharMapPos.Y := FCharMapPos.Y + FMaxCharHeightOnLine + AntiAliasMargin;
          FCharMapPos.X := AntiAliasMargin;
          FMaxCharHeightOnLine := 0;
        end;
        // fill result
        NewRec.Bitmap := Bitmap;
        NewRec.SrcRect := RectF(FCharMapPos.X, FCharMapPos.Y , FCharMapPos.X + NewRec.Glyph.Bitmap.Width,
          FCharMapPos.Y + NewRec.Glyph.Bitmap.Height);
        // write glyph to map
        for J := 0 to NewRec.Glyph.Bitmap.Height - 1 do
          Move(NewRec.Glyph.Bitmap.Scanline[J]^, Map.GetPixelAddr(FCharMapPos.X, FCharMapPos.Y + J)^, NewRec.Glyph.Bitmap.Pitch);
        // change current palce position
        FCharMapPos.X := FCharMapPos.X + NewRec.Glyph.Bitmap.Width + AntiAliasMargin;
        if NewRec.Glyph.Bitmap.Height > FMaxCharHeightOnLine then
          FMaxCharHeightOnLine := NewRec.Glyph.Bitmap.Height;
      finally
        Bitmap.Unmap(Map);
      end;
    end;
  end
  else
  begin
    NewRec.Bitmap := nil;
    NewRec.SrcRect := RectF(0, 0, 0, 0);
  end;
  // add to Dictionary
  if not HasItem then
    CharDic.Add(Ch, NewRec);
end;

class procedure TTextLayoutNG.BeginRender;
begin
  Inc(FRendering);
end;

class procedure TTextLayoutNG.EndRender;
var
  Map: TBitmapData;
  I, J: Integer;
  Bitmap: TBitmap;
  Rec: PCharRec;
begin
  Dec(FRendering);
  if Assigned(FNewGlyphList) and (FNewGlyphList.Count > 0) and (FRendering = 0) and not FDisableGlyphPopulation then
  begin
    for I := 0 to FNewGlyphList.Count - 1 do
    begin
      Rec := FNewGlyphList[I];
      if (Rec.Glyph.Bitmap.Width > 0) and (Rec.Glyph.Bitmap.Height > 0) then
      begin
        // Get current bitmap
        if (FCharMaps.Count = 0) or ((BitmapSize - FCharMapPos.X < Rec.Glyph.Bitmap.Width - AntiAliasMargin) and
          (BitmapSize - FCharMapPos.Y < Rec.Glyph.Bitmap.Height - AntiAliasMargin)) then
        begin
          Bitmap := TBitmap.Create(BitmapSize, BitmapSize);
          if Assigned(Rec.Bitmap) then
            IBitmapAccess(Bitmap).BitmapScale := Rec.Bitmap.BitmapScale;
          FCharMaps.Add(Bitmap);
          FMaxCharHeightOnLine := 0;
          FCharMapPos.Y := AntiAliasMargin;
          FCharMapPos.X := AntiAliasMargin;
        end
        else
          Bitmap := FCharMaps[FCharMaps.Count - 1];

        if Assigned(Rec.Bitmap) then
          FreeAndNil(Rec.Bitmap);

        if Bitmap.Map(TMapAccess.maWrite, Map) then
        try
          // check for enough place
          if FCharMapPos.X + Rec.Glyph.Bitmap.Width > Bitmap.Width then
          begin
            FCharMapPos.Y := FCharMapPos.Y + FMaxCharHeightOnLine + AntiAliasMargin;
            FCharMapPos.X := AntiAliasMargin;
            FMaxCharHeightOnLine := 0;
          end;
          // fill result
          Rec.Bitmap := Bitmap;
          Rec.SrcRect := RectF(FCharMapPos.X, FCharMapPos.Y , FCharMapPos.X + Rec.Glyph.Bitmap.Width,
            FCharMapPos.Y + Rec.Glyph.Bitmap.Height);
          // write glyph to map
          for J := 0 to Rec.Glyph.Bitmap.Height - 1 do
            Move(Rec.Glyph.Bitmap.Scanline[J]^, Map.GetPixelAddr(FCharMapPos.X, FCharMapPos.Y + J)^, Rec.Glyph.Bitmap.Pitch);
          // change current palce position
          FCharMapPos.X := FCharMapPos.X + Rec.Glyph.Bitmap.Width + AntiAliasMargin;
          if Rec.Glyph.Bitmap.Height > FMaxCharHeightOnLine then
            FMaxCharHeightOnLine := Rec.Glyph.Bitmap.Height;
        finally
          Bitmap.Unmap(Map);
        end;
      end;
    end;
    FNewGlyphList.Clear;
  end;
end;

function TTextLayoutNG.AddOrGetChar(const ACanvas: TCanvas; const Ch: UCS4Char; const CharDic: TCharDic;
  const AFont: TFont): PCharRec;
var
  NeedBitmap, HasItem: Boolean;
begin
  NeedBitmap := Assigned(ACanvas);
  // if not exists - place in bitmap and add to dictionaty
  HasItem := CharDic.TryGetValue(Ch, Result);
  if not HasItem or (NeedBitmap and (Result.Bitmap = nil) and not (TFontGlyphStyle.NoGlyph in Result.Glyph.Style)) then
    UpdateCharRec(ACanvas, NeedBitmap, Result, HasItem, CharDic, AFont, Ch);
end;

procedure TTextLayoutNG.DoDrawLayout(const ACanvas: TCanvas);
var
  CharDic: TCharDic;
  Rec: PCharRec;
  Pos: TPointF;
  R, SrcR: TRectF;
  LLine: TGPULine;
  LRun: TGPURun;
  I, J, K: Integer;
begin
  if Text.IsEmpty then
    Exit;

  if FOldColor <> Color then
  begin
    FOldColor := Color;
    for I := 0 to FFrame.Count - 1 do
    begin
      LLine := FFrame[I];
      for J := 0 to LLine.Count - 1 do
      begin
        LRun := LLine[J];
        LRun.SetColor(Color, True);
      end;
    end;
  end;

  if not SameValue(FScale, ACanvas.Scale, Epsilon) then
  begin
    FScale := ACanvas.Scale;
    FScaleFactor := 1 / FScale;
    DoRenderLayout;
  end;

  for I := 0 to FFrame.Count - 1 do
  begin
    LLine := FFrame[I];
    Pos := LLine.TopLeft;
    Pos.X := Round(Pos.X) + TopLeft.X;
    Pos.Y := Round(Pos.Y) + TopLeft.Y;
    for J := 0 to LLine.Count - 1 do
    begin
      LRun := LLine[J];
      CharDic := GetCharDictionary(LRun.Font);
      TCustomCanvasGpu(ACanvas).ModulateColor := LRun.Color;
      for K := 0 to LRun.Chars.Count - 1 do
      begin
        Rec := AddOrGetChar(ACanvas, LRun.Chars[K], CharDic, LRun.Font);
        if Assigned(Rec.Bitmap) then
        begin
          R.Left := Pos.X + Rec.Glyph.Origin.X * FScaleFactor;
          R.Top := Pos.Y + Rec.Glyph.Origin.Y * FScaleFactor;
          R.Right := R.Left + (Rec.SrcRect.Width * FScaleFactor);
          R.Bottom := R.Top + (Rec.SrcRect.Height * FScaleFactor);
          SrcR := Rec.SrcRect;
          if LRun.IsClipped then
          begin
            SrcR.Top := SrcR.Top + LRun.ClipBounds[K].Top * FScale;
            R.Top := R.Top + LRun.ClipBounds[K].Top;
            SrcR.Bottom := SrcR.Bottom - LRun.ClipBounds[K].Bottom * FScale;
            R.Bottom := R.Bottom - LRun.ClipBounds[K].Bottom;
            SrcR.Left := SrcR.Left + LRun.ClipBounds[K].Left * FScale;
            R.Left := R.Left + LRun.ClipBounds[K].Left;
            SrcR.Right := SrcR.Right - LRun.ClipBounds[K].Right * FScale;
            R.Right := R.Right - LRun.ClipBounds[K].Right;
          end;
          // Draw
          ACanvas.DrawBitmap(Rec.Bitmap, SrcR, R, Opacity);
        end;
        // Offset current position
        Pos.X := Pos.X + (Rec.Glyph.Advance * FScaleFactor);
      end;
      if LRun.IsTrimmed then
      begin
        Rec := AddOrGetChar(ACanvas, FEllipsisChar, GetCharDictionary(Self.Font), Self.Font);
        TCustomCanvasGpu(ACanvas).ModulateColor := Self.Color;
        if Assigned(Rec.Bitmap) then
        begin
          R.Left := Pos.X + Rec.Glyph.Origin.X * FScaleFactor;
          R.Top := Pos.Y + Rec.Glyph.Origin.Y * FScaleFactor;
          R.Right := R.Left + (Rec.SrcRect.Width * FScaleFactor);
          R.Bottom := R.Top + (Rec.SrcRect.Height * FScaleFactor);
          // Draw
          ACanvas.DrawBitmap(Rec.Bitmap, Rec.SrcRect, R, Opacity);
        end;
      end;
    end;
  end;
  TCustomCanvasGpu(ACanvas).ModulateColor := $FFFFFFFF;
end;

procedure TTextLayoutNG.DoRenderLayout;

  procedure CreateFrame;
  var
    ST: TStrings;
    LLine: TGPULine;
    LRun: TGPURun;
    I, StartIndex: Integer;
  begin
    if Text.IsEmpty then
    begin
      LLine := TGPULine.Create;
      LRun := TGPURun.Create;
      LRun.Font := nil;
      LRun.SetColor(Self.Color, True);
      LLine.Add(LRun);
      FFrame.Add(LLine);
    end
    else begin
      ST := TStringList.Create;
      try
        ST.Text := Self.Text;
        StartIndex := 0;
        for I := 0 to ST.Count - 1 do
        begin
          LLine := TGPULine.Create;
          LRun := TGPURun.Create;
          LRun.Font := nil;
          LRun.SetColor(Self.Color, True);
          LRun.SetText(Self.Text, StartIndex, ST[I].Length);
          LLine.Add(LRun);
          FFrame.Add(LLine);
          Inc(StartIndex, LRun.Length);
          if I < (ST.Count - 1) then
            Inc(StartIndex, string(sLineBreak).Length);
        end;
      finally
        FreeAndNil(ST);
      end;
    end;
  end;

  procedure ApplyAttribute(Run: TGPURun; Attribute: TTextAttribute);
  begin
    Run.SetColor(Attribute.Color, False);
    if not Assigned(Run.Font) then
      Run.Font := Attribute.Font
    else
      if Assigned(Attribute.Font) then
      begin
        Run.Font.Family := Attribute.Font.Family;
        Run.Font.Size := Attribute.Font.Size;
        Run.Font.Style := Run.Font.Style + Attribute.Font.Style;
      end;
  end;

  procedure ApplyAttributes;
  var
    I, CurrentPos, RemainLength, LineIndex, RunIndex: Integer;
    LAttribute: TTextAttributedRange;
    LLine: TGPULine;
    LRun, NewRun: TGPURun;
  begin
    for I := 0 to AttributesCount - 1 do
    begin
      LAttribute := Attributes[I];
      CurrentPos := LAttribute.Range.Pos;
      RemainLength := LAttribute.Range.Length;
      while RemainLength > 0 do
      begin
        //Looking for Run
        for LineIndex := 0 to FFrame.Count - 1 do
        begin
          RunIndex := 0;
          LLine := FFrame[LineIndex];
          while RunIndex < LLine.Count do
          begin
            LRun := LLine[RunIndex];
            if CurrentPos < (LRun.StartIndex + LRun.Length) then
            begin
              if CurrentPos > LRun.StartIndex then
              begin
                //Attibute start's not from the begin of the run, need to
                //split run
                NewRun := TGPURun.Create;
                NewRun.SetText(Text, LRun.StartIndex, CurrentPos - LRun.StartIndex);
                NewRun.Font := LRun.Font;
                NewRun.SetColor(LRun.Color, LRun.IsDefaultColor);
                LLine.Insert(RunIndex, NewRun);
                Inc(RunIndex);
                LRun.SetText(Text, CurrentPos, LRun.Length - NewRun.Length);
              end;
              //Current position and start of the Run are equal
              NewRun := nil;
              if RemainLength < LRun.Length then
              begin
                //Attribute length is less than current Run, need to create
                //a new Run after current
                NewRun := TGPURun.Create;
                NewRun.SetText(Self.Text, LRun.StartIndex + RemainLength, LRun.Length - RemainLength);
                NewRun.Font := LRun.Font;
                NewRun.SetColor(LRun.Color, LRun.IsDefaultColor);
                LRun.SetText(Text, LRun.StartIndex, LRun.Length - NewRun.Length);
              end;
              //Applying attribute
              ApplyAttribute(LRun, LAttribute.Attribute);
              Dec(RemainLength, LRun.Length);
              Inc(CurrentPos, LRun.Length);
              if Assigned(NewRun) then
              begin
                //Inserting new run after applying attribute
                LLine.Insert(RunIndex + 1, NewRun);
                Inc(RunIndex);
                Inc(CurrentPos, NewRun.Length);
              end;
            end;
            if RemainLength <= 0 then
              Break;
            Inc(RunIndex);
          end;
          if RemainLength <= 0 then
            Break;
        end;
      end;
    end;
  end;

  procedure AlignFrame;
  var
    LTop, LLeft: Single;
    I: Integer;
  begin
    LLeft := Padding.Left;
    case HorizontalAlign of
      TTextAlign.taCenter:
        begin
          LLeft := (MaxSize.X - Padding.Right - Padding.Left - FFrame.Width) / 2;
          for I := 0 to FFrame.Count - 1 do
            FFrame[I].TopLeft := TPointF.Create((MaxSize.X - Padding.Right - Padding.Left - FFrame[I].Width) / 2, 0);
        end;
      TTextAlign.taTrailing:
        begin
          LLeft := MaxSize.X - Padding.Right - FFrame.Width;
          for I := 0 to FFrame.Count - 1 do
            FFrame[I].TopLeft := TPointF.Create(MaxSize.X - Padding.Right - FFrame[I].Width, 0);
        end;
    end;
    LTop := Padding.Top;
    case VerticalAlign of
      TTextAlign.taCenter:
        LTop := (MaxSize.Y - Padding.Top - Padding.Bottom - FFrame.Height) / 2;
      TTextAlign.taTrailing:
        LTop := MaxSize.Y - Padding.Bottom - FFrame.Height;
    end;
    FFrame.TopLeft := TPointF.Create(LLeft, LTop);
    for I := 0 to FFrame.Count - 1 do
    begin
      FFrame[I].TopLeft := TPointF.Create(FFrame[I].TopLeft.X, LTop);
      LTop := LTop + FFrame[I].Height;
    end;
  end;

  procedure CheckClipping;
  var
    I, J, K: Integer;
    X: Single;
    Run: TGPURun;
    Rec: PCharRec;
    ChDic: TCharDic;
    R: TRectF;
  begin
    if (FFrame.Width < MaxSize.X) and (FFrame.Height < MaxSize.Y) then
      Exit;
    //Checking for lines upper than top border
    if VerticalAlign <> TTextAlign.taLeading then
      while FFrame.Count > 0 do
        if FFrame[0].TopLeft.Y < 0 then
          if (FFrame[0].TopLeft.Y + FFrame[0].Height) < 0 then //Remove Invisible line
          begin
            FFrame.TopLeft.Offset(0, FFrame[0].Height);
            FFrame.Height := FFrame.Height - FFrame[0].Height;
            FFrame.Delete(0);
          end
          else
          begin //Adding clip rects
            for J := 0 to FFrame[0].Count - 1 do
            begin
              Run := FFrame[0][J];
              if (Run.ImageRect.Height + FFrame[0].TopLeft.Y) > 0 then
              begin
                Run.Clip;
                ChDic := GetCharDictionary(Run.Font);
                for K := 0 to Run.Chars.Count - 1 do
                begin
                  Rec := AddOrGetChar(nil, Run.Chars[K], ChDic, Run.Font);
                  X := Rec.Glyph.Origin.Y * FScaleFactor + FFrame[0].TopLeft.Y;
                  if X < 0 then
                  begin
                    R := Run.ClipBounds[K];
                    R.Top := Abs(X);
                  end;
                end;
              end;
            end;
            Break;
          end
        else
          Break;
    //Checking for lines lower than bottom border
    if VerticalAlign <> TTextAlign.taTrailing then
      while FFrame.Count > 0 do
        if (FFrame[FFrame.Count - 1].TopLeft.Y + FFrame[FFrame.Count - 1].Height) > MaxSize.Y then
          if FFrame[FFrame.Count - 1].TopLeft.Y > MaxSize.Y then
          begin
            FFrame.Height := FFrame.Height - FFrame[FFrame.Count - 1].Height;
            FFrame.Delete(FFrame.Count - 1);
          end
          else
          begin
            for J := 0 to FFrame.Last.Count - 1 do
            begin
              Run := FFrame.Last[J];
              if (Run.ImageRect.Height + FFrame.Last.TopLeft.Y) > MaxSize.Y then
              begin
                Run.Clip;
                ChDic := GetCharDictionary(Run.Font);
                for K := 0 to Run.Chars.Count - 1 do
                begin
                  Rec := AddOrGetChar(nil, Run.Chars[K], ChDic, Run.Font);
                  X := MaxSize.Y - FFrame.Last.TopLeft.Y - Rec.Glyph.VerticalAdvance * FScaleFactor;
                  if X < 0 then
                  begin
                    R := Run.ClipBounds[K];
                    R.Bottom := Abs(X);
                    Run.ClipBounds[K] := R;
                  end;
                end;
              end;
            end;
            Break;
          end
        else
          Break;
    //
    for I := 0 to FFrame.Count - 1 do
      if FFrame[I].Width > MaxSize.X then
      begin
        //Checking for characters that are lefter than left border
        if HorizontalAlign <> TTextAlign.taLeading then
        begin
          X := FFrame[I].TopLeft.X;
          if X < 0 then
            while FFrame[I].Count > 0 do
              if X < 0 then
              begin
                Run := FFrame[I][0];
                ChDic := GetCharDictionary(Run.Font);
                while X < 0 do
                begin
                  Run.Clip;
                  Rec := AddOrGetChar(nil, Run.Chars[0], ChDic, Run.Font);
                  if (X + Rec.Glyph.Advance * FScaleFactor) < 0 then
                  begin
                    Run.DeleteTextFromStart(1);
                    FFrame[I].TopLeft.Offset(Rec.Glyph.Advance * FScaleFactor, 0);
                    FFrame[I].Width := FFrame[I].Width - Rec.Glyph.Advance * FScaleFactor;
                  end
                  else
                  begin
                    R := Run.ClipBounds[0];
                    R.Left := Abs(X);
                    Run.ClipBounds[0] := R;
                  end;
                  X := X + Rec.Glyph.Advance * FScaleFactor;
                end;
                if Run.Length = 0 then
                  FFrame[I].Delete(0);
              end
              else
                Break;
        end;
        //Checking for characters that are righter than right border
        if HorizontalAlign <> TTextAlign.taTrailing then
        begin
          X := FFrame[I].TopLeft.X;
          J := 0;
          while (X < MaxSize.X) and (J < FFrame[I].Count) do
          begin
            Run := FFrame[I][J];
            ChDic := GetCharDictionary(Run.Font);
            for K := 0 to Run.Chars.Count - 1 do
            begin
              Rec := AddOrGetChar(nil, Run.Chars[K], ChDic, Run.Font);
              X := X + Rec.Glyph.Advance * FScaleFactor;
              if X > MaxSize.X then
              begin
                Run.Clip;
                FFrame[I].Width := X - FFrame[I].TopLeft.X;
                if K < (Run.Chars.Count - 1) then
                  Run.DeleteTextFromEnd(Run.Chars.Count - K - 1);
                R := Run.ClipBounds[K];
                R.Right := X - MaxSize.X;
                Run.ClipBounds[K] := R;
                FFrame[I].DeleteRange(J + 1, FFrame[I].Count - J - 1);
                if Run.Length = 0 then
                  FFrame[I].Delete(J);
                Break;
              end;
            end;
            Inc(J);
          end;
        end;
      end;
  end;

  procedure ReduceFrameSize;
  var
    MaxWidth: Single;
    I: Integer;
  begin
    MaxWidth := 0;
    for I := 0 to FFrame.Count - 1 do
      MaxWidth := Max(MaxWidth, FFrame[I].Width);
    FFrame.Width := MaxWidth;
  end;

var
  CharDic: TCharDic;
  Rec, Rec1: PCharRec;
  R: TRectF;
  LLine, NewLine: TGPULine;
  LRun, NewRun: TGPURun;
  I, LineIndex, RunIndex, CharIndex, RunLength: Integer;
  WidthLimit, LineWidth, LineWidthLimit: Single;
  CurrentPos, RemainLength, RunEndIndex, CharLength: Integer;
begin
  FOldColor := Self.Color;
  FreeAndNil(F3DLayout);
  FFrame.Clear;

  if LayoutCanvas <> nil then
    if not SameValue(FScale, LayoutCanvas.Scale, Epsilon) then
    begin
      FScale := LayoutCanvas.Scale;
      FScaleFactor := 1 / FScale;
    end;

  FFontKey := FontFalimyKey(Font, FScale);

  FFrame.Width := 0;
  FFrame.Height := 0;
  //Splitting text
  CreateFrame;
  //Applying attributes
  ApplyAttributes;

  //Calculation metrics
  WidthLimit := MaxSize.X - Padding.Left - Padding.Right;
  LineIndex := 0;
  while LineIndex < FFrame.Count do
  begin
    LLine := FFrame[LineIndex];
    LLine.Width := 0;
    LLine.Height := 0;
    RunIndex := 0;
    while RunIndex  < LLine.Count do
    begin
      LRun := LLine[RunIndex];
      CharDic := GetCharDictionary(LRun.Font);
      if LRun.Length = 0 then
      begin
        Rec := AddOrGetChar(nil, System.Char.ConvertToUtf32('|', 0), CharDic, LRun.Font);
        //
        LLine.Width := 1;
        LLine.Height := Rec.Glyph.VerticalAdvance * FScaleFactor;
        //
        LRun.ImageRect.Create(0, 0, LLine.Width, LLine.Height);
      end
      else
        LRun.ImageRect.Create(0, 0, 0, 0);
        RemainLength := LRun.StartIndex + LRun.Length;
        CharIndex := LRun.StartIndex;
        while CharIndex < RemainLength do
        begin
          Rec := AddOrGetChar(nil, System.Char.ConvertToUtf32(Text, CharIndex, CharLength), CharDic, LRun.Font);
          //Checking for MaxSize exceeding
          if (LRun.ImageRect.Width > 0) and (WordWrap or (Trimming <> TTextTrimming.ttNone)) and ((LLine.Width + Rec.Glyph.Advance * FScaleFactor) > WidthLimit) then
          begin
            if WordWrap then
            begin
              //Wrapping text to several lines
              if Text.Chars[CharIndex].IsLetterOrDigit then
              begin
                RunEndIndex := GetLexemeEnd(Text, GetPrevLexemeBegin(Text, GetLexemeBegin(Text, CharIndex)));
                if RunEndIndex < LRun.StartIndex then //Word length can be longer than MaxSize, without trimming drawing just a part of the word
                  LRun.SetText(Self.Text, LRun.StartIndex, CharIndex - LRun.StartIndex + 1)
                else
                  if RunEndIndex >= CharIndex then //Next position is behind current - croping word
                    LRun.SetText(Self.Text, LRun.StartIndex, CharIndex - LRun.StartIndex)
                  else
                    LRun.SetText(Self.Text, LRun.StartIndex, RunEndIndex - LRun.StartIndex + 1);
                CurrentPos := GetLexemeBegin(Text, CharIndex);
              end
              else
              begin
                RunEndIndex := GetLexemeEnd(Text, GetPrevLexemeBegin(Text, CharIndex));
                if RunEndIndex < LRun.StartIndex then //Word length can be longer than MaxSize, without trimming drawing just a part of the word
                  LRun.SetText(Self.Text, LRun.StartIndex, CharIndex - LRun.StartIndex + 1)
                else
                  if RunEndIndex >= CharIndex then //Next position is behind current - croping word
                    LRun.SetText(Self.Text, LRun.StartIndex, CharIndex - LRun.StartIndex)
                  else
                    LRun.SetText(Self.Text, LRun.StartIndex, RunEndIndex - LRun.StartIndex + 1);
                CurrentPos := GetNextLexemeBegin(Text, CharIndex);
              end;
            end
            else
            begin
              CurrentPos := CharIndex;
              //Getting back to last visible
              if Trimming <> TTextTrimming.ttNone then
              begin
                Rec := AddOrGetChar(nil, FEllipsisChar, GetCharDictionary(Self.Font), Self.Font);
                LineWidth := LLine.Width;
                LineWidthLimit := WidthLimit - Rec.Glyph.Advance * FScaleFactor;
                while (CurrentPos >= LRun.StartIndex) and (LineWidth > LineWidthLimit) do
                begin
                  Rec := AddOrGetChar(nil, System.Char.ConvertToUtf32(Text, LRun.StartIndex), CharDic, LRun.Font);
                  LineWidth := LineWidth - Rec.Glyph.Advance * FScaleFactor;
                  Dec(CurrentPos);
                end;
              end;
              //Checking for trimming
              RunLength := LRun.Length;
              case Trimming of
                TTextTrimming.ttNone:
                  RunLength := CurrentPos - LRun.StartIndex;
                TTextTrimming.ttCharacter:
                  if CurrentPos > 0 then
                    if Text.Chars[CurrentPos - 1].IsLetterOrDigit then
                    begin
                      RunLength := CurrentPos - LRun.StartIndex - 1;
                      while (RunLength > 0) and not Text.Chars[LRun.StartIndex + RunLength - 1].IsLetterOrDigit do
                        Dec(RunLength);
                    end
                    else
                      RunLength := GetLexemeEnd(Text, GetPrevLexemeBegin(Text, CurrentPos)) + 1 - LRun.StartIndex
                  else
                    RunLength := 0;
                TTextTrimming.ttWord:
                  begin
                    RunLength := GetLexemeBegin(Text, CurrentPos) + 1 - LRun.StartIndex;
                    if (LRun.StartIndex + RunLength) = (CurrentPos + 1) then
                      RunLength := GetLexemeEnd(Text, GetPrevLexemeBegin(Text, CurrentPos)) - LRun.StartIndex + 1;
                  end;
              end;
              LRun.SetText(Self.Text, LRun.StartIndex, RunLength);
              LRun.IsTrimmed := (Trimming <> TTextTrimming.ttNone);
              CurrentPos := RemainLength;
            end;
            if CurrentPos < (LRun.StartIndex + LRun.Length) then
              CurrentPos := LRun.StartIndex + LRun.Length;
            //Decreasing Run's length
            RunEndIndex := LRun.StartIndex + LRun.Length;
            if CharIndex >= RunEndIndex then
            begin
              I := CharIndex - 1;
              R := LRun.ImageRect;
              while (I >= 0) and (I >= RunEndIndex) do
              begin
                Rec1 := AddOrGetChar(nil, System.Char.ConvertToUtf32(Text, I), CharDic, LRun.Font);
                LLine.Width := LLine.Width - (Rec1.Glyph.Advance * FScaleFactor);
                R.Width := R.Width - Rec1.Glyph.Advance * FScaleFactor;
                Dec(I);
              end;
              LRun.ImageRect := R;
            end;
            if LRun.IsTrimmed then
            begin
              Rec1 := AddOrGetChar(nil, FEllipsisChar, GetCharDictionary(Self.Font), Self.Font);
              R := LRun.ImageRect;
              R.Width := R.Width + Rec1.Glyph.Advance * FScaleFactor;
              LRun.ImageRect := R;
              LLine.Width := LLine.Width + Rec1.Glyph.Advance * FScaleFactor;
              LLine.Height := Max(LLine.Height, Rec1.Glyph.VerticalAdvance * FScaleFactor);
            end;
            //Applying wrapping
            if WordWrap and (CurrentPos < RemainLength) then
            begin
              //Forming new line
              NewLine := TGPULine.Create;
              NewRun := TGPURun.Create;
              NewRun.Font := LRun.Font;
              NewRun.SetColor(LRun.Color, LRun.IsDefaultColor);
              NewRun.SetText(Self.Text, CurrentPos, RemainLength - CurrentPos);

              NewLine.Add(NewRun);
              for I := RunIndex + 1 to LLine.Count - 1 do
                NewLine.Add(LLine[I]);
              LLine.DeleteRange(RunIndex + 1, LLine.Count - (RunIndex + 1));
              FFrame.Insert(LineIndex + 1, NewLine);
              RunIndex := LLine.Count;
            end;
            Break;
          end
          else
          begin
            R := LRun.ImageRect;
            R.Width := R.Width + Rec.Glyph.Advance * FScaleFactor;
            R.Height := Max(R.Height, Rec.Glyph.VerticalAdvance * FScaleFactor);
            LRun.ImageRect := R;
            LLine.Width := LLine.Width + (Rec.Glyph.Advance * FScaleFactor);
            LLine.Height := Max(LLine.Height, R.Height);
          end;
          Inc(CharIndex, CharLength);
        end;
      Inc(RunIndex);
    end;
    //
    FFrame.Width := Max(FFrame.Width, LLine.Width);
    FFrame.Height := FFrame.Height + LLine.Height;
    Inc(LineIndex);
  end;
  AlignFrame;
  CheckClipping;
  ReduceFrameSize;
end;

function TTextLayoutNG.GetCharDictionary(const AFont: TFont = nil): TCharDic;
var
  FamilyKey: Int64;
begin
  Result := nil;
  if not Assigned(AFont) then
    FamilyKey := FFontKey
  else
    FamilyKey := FontFalimyKey(AFont, FScale);

  if not FFamilyDic.TryGetValue(FamilyKey, Result) then
  begin
    Result := TCharDic.Create(1024);
    FFamilyDic.Add(FamilyKey, Result);
  end;
end;

function TTextLayoutNG.GetTextHeight: Single;
begin
  if not SameValue(MaxSize.Y, ClosePolygon.Y, Epsilon) then
    Result := Min(FFrame.Height, MaxSize.Y)
  else
    Result := FFrame.Height;
end;

function TTextLayoutNG.GetTextRect: TRectF;
begin
  Result := TRectF.Create(FFrame.TopLeft, TextWidth, TextHeight);
  Result.Offset(TopLeft);
  if FFrame.TopLeft.Y < 0 then
    Result.Offset(0, Abs(FFrame.TopLeft.Y));
end;

function TTextLayoutNG.GetTextWidth: Single;
begin
  Result := FFrame.Width;
end;

function TTextLayoutNG.MeasureRange(const APos, ALength: Integer): TRegion;
var
  I, LengthOffset, Remaing, LLength, CharsLength: Integer;
  CharDic: TCharDic;
  Rec: PCharRec;
  R, R1: TRectF;
  Offset: Single;
  LRun: TGPURun;
  LineIndex, RunIndex: Integer;
begin
  SetLength(Result, 0);

  Remaing := ALength;
  LLength := Text.Length;
  while ((APos + Remaing) < LLength) and IsCombiningCharacter(Text.Chars[APos + Remaing]) do //Skipping combinig characters
    Inc(Remaing);

  for LineIndex := 0 to FFrame.Count - 1 do
  begin
    Offset := 0;
    if (LineIndex > 0) and (Length(Result) > 0) and (FFrame[LineIndex - 1].Count > 0) and (FFrame[LineIndex].Count > 0) then
      Dec(Remaing, FFrame[LineIndex].First.StartIndex - FFrame[LineIndex - 1].Last.StartIndex - FFrame[LineIndex - 1].Last.Length);
    for RunIndex := 0 to FFrame[LineIndex].Count - 1 do
    begin
      LRun := FFrame[LineIndex][RunIndex];
      LengthOffset := LRun.StartIndex;
      R.Create(0, 0, 0, 0);
      if APos < (LRun.StartIndex + LRun.Length) then
      begin
        CharDic := GetCharDictionary(LRun.Font);
        for I := 0 to LRun.Chars.Count - 1 do
        begin
          CharsLength := System.Char.ConvertFromUtf32(LRun.Chars[I]).Length;
          Rec := AddOrGetChar(nil, LRun.Chars[I], CharDic, LRun.Font);
          if LengthOffset < APos then
          begin
            Offset := Offset + Rec.Glyph.Advance * FScaleFactor;
            Inc(LengthOffset, CharsLength);
          end
          else
            if Remaing > 0 then
            begin
              R1.Create(Offset, 0, Offset + Rec.Glyph.Advance * FScaleFactor, FFrame[LineIndex].Height);
              if R.IsEmpty then
                R := R1
              else
                R.Union(R1);
              Offset := Offset + Rec.Glyph.Advance * FScaleFactor;
              Dec(Remaing);
              Inc(LengthOffset, CharsLength);
            end
            else
              Break;
        end;
      end
      else
        if APos = (LRun.StartIndex + LRun.Length) then
        begin
          R := LRun.ImageRect;
          R.Left := R.Right;
          Dec(Remaing);
        end
        else
          if Remaing > 0 then
            Offset := Offset + LRun.ImageRect.Width
          else
            Break;
      if R.Right > 0 then
      begin
        SetLength(Result, Length(Result) + 1);
        R.Offset(FFrame[LineIndex].TopLeft);
        Result[High(Result)] := R;
        R := R.Empty;
      end;
    end;
    if R.Right > 0 then
    begin
      SetLength(Result, Length(Result) + 1);
      R.Offset(FFrame[LineIndex].TopLeft);
      Result[High(Result)] := R;
      R := R.Empty;
    end;
    if Remaing = 0 then
      Exit;
  end;
end;

function TTextLayoutNG.DoPositionAtPoint(const APoint: TPointF): Integer;

  function RegionContains(const ARect: TRectF; const LPoint: TPointF): Boolean;
  begin
    Result := ((LPoint.X > ARect.Left) or SameValue(LPoint.X, ARect.Left, Epsilon)) and
              ((LPoint.X < ARect.Right)or SameValue(LPoint.X, ARect.Right, Epsilon)) and
              ((LPoint.Y > ARect.Top) or SameValue(LPoint.Y, ARect.Top, Epsilon)) and
              ((LPoint.Y < ARect.Bottom) or SameValue(LPoint.Y, ARect.Bottom, Epsilon));
  end;

var
  I, Index, Length, CharsLength: Integer;
  CharDic: TCharDic;
  Rec: PCharRec;
  LPoint: TPointF;
  R: TRectF;
  Offset: Single;
  LRun: TGPURun;
  LineIndex, RunIndex: Integer;
begin
  Result := -1;

  LPoint := PointF(APoint.X - TopLeft.X - Padding.Left, APoint.Y - TopLeft.Y - Padding.Top);

  for LineIndex := 0 to FFrame.Count - 1 do
  begin
    Offset := FFrame[LineIndex].TopLeft.X;
    if LPoint.Y > FFrame[LineIndex].Height then
    begin
      LPoint.Offset(0, -FFrame[LineIndex].Height);
      Continue;
    end;
    if LPoint.X < FFrame[LineIndex].TopLeft.X then
      Exit(FFrame[LineIndex].First.StartIndex);
    if LPoint.X > (FFrame[LineIndex].TopLeft.X + FFrame[LineIndex].Width) then
      Exit(FFrame[LineIndex].Last.StartIndex + FFrame[LineIndex].Last.Length);
    for RunIndex := 0 to FFrame[LineIndex].Count - 1 do
    begin
      LRun := FFrame[LineIndex][RunIndex];
      CharDic := GetCharDictionary(LRun.Font);
      CharsLength := 0;
      for I := 0 to LRun.Chars.Count - 1 do
      begin
        Rec := AddOrGetChar(nil, LRun.Chars[I], CharDic, LRun.Font);
        R.Create(Offset, 0, Offset + Rec.Glyph.Advance * FScaleFactor, FFrame[LineIndex].Height);
        if RegionContains(R, LPoint) then
        begin
          Index := CharsLength + LRun.StartIndex;
          if LPoint.X > (R.Left + R.Width * 3 / 5) then
            Inc(Index);
          Length := Text.Length;
          while ((Index + 1) < Length) and IsCombiningCharacter(Text.Chars[Index + 1]) do //Skipping combinig characters
            Inc(Index);
          Exit(Min(Index, Text.Length));
        end;
        Offset := Offset + Rec.Glyph.Advance * FScaleFactor;
        Inc(CharsLength, System.Char.ConvertFromUtf32(LRun.Chars[I]).Length);
      end;
    end;
  end;
end;

function TTextLayoutNG.DoRegionForRange(const ARange: TTextRange): TRegion;
var
  i: Integer;
begin
  if ARange.Pos < 0 then
    Exit;

  if (ARange.Pos = Text.Length) and (ARange.Length = 0) then
    if Text.IsEmpty then
    begin
      SetLength(Result, 1);
      Result[0] := Self.TextRect;
      Exit;
    end
    else
    begin
      Result := MeasureRange(Text.Length - 1, 1);
      for i := Low(Result) to High(Result) do
        Result[i].Left := Result[i].Right;
    end
  else
  begin
    Result := MeasureRange(ARange.Pos, ARange.Length);
    if Length(Result) = 0 then
    begin
      SetLength(Result, 1);
      Result[0] := Self.TextRect;
      Result[0].Left := Result[0].Right;
      Exit;
    end;
  end;
  for i := Low(Result) to High(Result) do
    Result[i].Offset(TopLeft);
end;

initialization
finalization
  TTextLayoutNG.Uninitialize;
end.
