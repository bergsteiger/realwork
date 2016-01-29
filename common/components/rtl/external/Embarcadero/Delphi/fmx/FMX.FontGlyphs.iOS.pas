{*******************************************************}
{                                                       }
{             Delphi FireMonkey Platform                }
{ Copyright(c) 2012-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit FMX.FontGlyphs.iOS;

interface

uses
  System.Types, System.Classes, System.SysUtils, System.UITypes, System.UIConsts,
  System.Generics.Collections, System.Generics.Defaults,
  Macapi.ObjectiveC, Macapi.CoreFoundation,
  iOSapi.CocoaTypes, iOSapi.CoreGraphics, iOSapi.Foundation, iOSapi.CoreText, iOSapi.UIKit,
  FMX.Types, FMX.Surfaces, FMX.FontGlyphs, FMX.PixelFormats;

{$SCOPEDENUMS ON}

type

  TIOSFontGlyphManager = class(TFontGlyphManager)
  private
    FBits: PAlphaColorRecArray;
    FColorSpace: CGColorSpaceRef;
    FFontRef: CTFontRef;
    FDefaultBaseline: Single;
    FDefaultVerticalAdvance: Single;
    procedure GetDefaultBaseline;
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

{ TIOSFontGlyphManager }

constructor TIOSFontGlyphManager.Create;
begin
  inherited Create;
  GetMem(FBits, BitmapSize * BitmapSize * 4);
  FColorSpace := CGColorSpaceCreateDeviceRGB;
end;

destructor TIOSFontGlyphManager.Destroy;
begin
  CGColorSpaceRelease(FColorSpace);
  FreeMem(FBits);
  inherited;
end;

procedure TIOSFontGlyphManager.LoadResource;
const
  //Rotating matrix to simulate Italic font attribute
  ItalicMatrix: CGAffineTransform = (
    a: 1;
    b: 0;
    c: 0.176326981; //~tan(10 degrees)
    d: 1;
    tx: 0;
    ty: 0
  );
var
  NewFontRef: CTFontRef;
  Matrix: PCGAffineTransform;
begin
  Matrix := nil;
  FFontRef := CTFontCreateWithName(CFSTR(CurrentSettings.Family), CurrentSettings.Size * CurrentSettings.Scale, nil);
  try
    if TFontStyle.fsItalic in CurrentSettings.Style then
    begin
      NewFontRef := CTFontCreateCopyWithSymbolicTraits(FFontRef, 0, nil,
        kCTFontItalicTrait, kCTFontItalicTrait);
      if Assigned(NewFontRef) then
      begin
        CFRelease(FFontRef);
        FFontRef := NewFontRef;
      end
      else
      begin
        Matrix := @ItalicMatrix;
        //Font has no Italic version, applying transform matrix
        NewFontRef := CTFontCreateWithName(CFSTR(CurrentSettings.Family), CurrentSettings.Size * CurrentSettings.Scale, @ItalicMatrix);
        if Assigned(NewFontRef) then
        begin
          CFRelease(FFontRef);
          FFontRef := NewFontRef;
        end;
      end;
    end;
    if TFontStyle.fsBold in CurrentSettings.Style then
    begin
      NewFontRef := CTFontCreateCopyWithSymbolicTraits(FFontRef, 0, Matrix,
        kCTFontBoldTrait, kCTFontBoldTrait);
      if Assigned(NewFontRef) then
      begin
        CFRelease(FFontRef);
        FFontRef := NewFontRef;
      end;
    end;
    //
    GetDefaultBaseline;
  except
    CFRelease(FFontRef);
  end;
end;

procedure TIOSFontGlyphManager.FreeResource;
begin
  if Assigned(FFontRef) then
    CFRelease(FFontRef);
end;

procedure TIOSFontGlyphManager.GetDefaultBaseline;
var
  Chars: string;
  Str: CFStringRef;
  Frame: CTFrameRef;
  Attr: CFMutableAttributedStringRef;
  Underline: CFNumberRef;
  LValue: Cardinal;
  Path: CGMutablePathRef;
  Bounds: CGRect;
  FrameSetter: CTFramesetterRef;
  // Metrics
  Line: CTLineRef;
  Lines: CFArrayRef;
  Runs: CFArrayRef;
  Run: CTRunRef;
  Ascent, Descent, Leading: CGFloat;
  BaseLinePos: CGPoint;
begin
  Path := CGPathCreateMutable();
  Bounds := CGRectMake(0, 0, $FFFF, BitmapSize);
  CGPathAddRect(Path, nil, Bounds);
  Chars := 'a';
  Str := CFStringCreateWithCharacters(kCFAllocatorDefault, PChar(Chars), 1);

  Attr := CFAttributedStringCreateMutable(kCFAllocatorDefault, 0);
  CFAttributedStringReplaceString(Attr, CFRangeMake(0, 0), Str);

  CFAttributedStringBeginEditing(Attr);
  try
    // Font
    if Assigned(FFontRef) then
      CFAttributedStringSetAttribute(Attr, CFRangeMake(0, 1), kCTFontAttributeName, FFontRef);
    //Underline
    if TFontStyle.fsUnderline in CurrentSettings.Style then
    begin
      LValue := kCTUnderlineStyleSingle;
      Underline := CFNumberCreate(nil, kCFNumberSInt32Type, @LValue);
      CFAttributedStringSetAttribute(Attr, CFRangeMake(0, 1),
        kCTUnderlineStyleAttributeName, Underline);
    end;
  finally
    CFAttributedStringEndEditing(Attr);
  end;

  FrameSetter := CTFramesetterCreateWithAttributedString(CFAttributedStringRef(Attr));
  CFRelease(Attr);

  Frame := CTFramesetterCreateFrame(FrameSetter, CFRangeMake(0, 0), Path, nil);
  CFRelease(FrameSetter);
  CFRelease(Str);

  // Metrics
  Lines := CTFrameGetLines(Frame);
  Line := CTLineRef(CFArrayGetValueAtIndex(Lines, 0));
  Runs := CTLineGetGlyphRuns(Line);
  Run := CFArrayGetValueAtIndex(Runs, 0);
  CTRunGetTypographicBounds(Run, CFRangeMake(0, 1), @Ascent,  @Descent, @Leading);

  CTFrameGetLineOrigins(Frame, CFRangeMake(0, 0), @BaseLinePos);
  FDefaultBaseline := BitmapSize - BaseLinePos.y;

  FDefaultVerticalAdvance := FDefaultBaseline + Descent;

  CFRelease(Frame);
  CFRelease(Path);
end;

function TIOSFontGlyphManager.DoGetGlyph(const Char: UCS4Char; const Settings: TFontGlyphSettings): TFontGlyph;
var
  CharsString: string;
  CharsStringLength: Integer;
  Str: CFStringRef;
  Frame: CTFrameRef;
  Attr: CFMutableAttributedStringRef;
  Underline: CFNumberRef;
  LValue: Cardinal;
  Path: CGMutablePathRef;
  Bounds: CGRect;
  Rgba: array [0..3] of Single;
  TextColor: CGColorRef;
  FrameSetter: CTFramesetterRef;
  Context: CGContextRef;
  I, J: Integer;
  Color: TAlphaColorRec;
  C: Byte;
  GlyphRect: TRect;
  // Metrics
  Line: CTLineRef;
  Lines: CFArrayRef;
  NumLines: CFIndex;
  Runs: CFArrayRef;
  Run: CTRunRef;
  Ascent, Descent, Leading: CGFloat;
  Size: CGSize;
  GlyphStyle: TFontGlyphStyles;
  BaseLinePos: CGPoint;
  BaseLineOffset: Single;
begin
  Path := CGPathCreateMutable();
  Bounds := CGRectMake(0, 0, $FFFF, BitmapSize);
  CGPathAddRect(Path, nil, Bounds);
  CharsString := System.Char.ConvertFromUtf32(Char);
  CharsStringLength := CharsString.Length;
  Str := CFStringCreateWithCharacters(kCFAllocatorDefault, PChar(CharsString), CharsStringLength);

  Attr := CFAttributedStringCreateMutable(kCFAllocatorDefault, 0);
  CFAttributedStringReplaceString(Attr, CFRangeMake(0, 0), Str);

  CFAttributedStringBeginEditing(Attr);
  try
    // Font
    if Assigned(FFontRef) then
      CFAttributedStringSetAttribute(Attr, CFRangeMake(0, CharsStringLength), kCTFontAttributeName, FFontRef);
    //Underline
    if TFontStyle.fsUnderline in CurrentSettings.Style then
    begin
      LValue := kCTUnderlineStyleSingle;
      Underline := CFNumberCreate(nil, kCFNumberSInt32Type, @LValue);
      CFAttributedStringSetAttribute(Attr, CFRangeMake(0, CharsStringLength),
        kCTUnderlineStyleAttributeName, Underline);
    end;
    // Color
    Rgba[0] := 1;
    Rgba[1] := 1;
    Rgba[2] := 1;
    Rgba[3] := 1;
    TextColor := CGColorCreate(FColorSpace, @Rgba[0]);
    try
      CFAttributedStringSetAttribute(Attr, CFRangeMake(0, CharsStringLength), kCTForegroundColorAttributeName, TextColor);
    finally
      CFRelease(TextColor);
    end;
  finally
    CFAttributedStringEndEditing(Attr);
  end;

  FrameSetter := CTFramesetterCreateWithAttributedString(CFAttributedStringRef(Attr));
  CFRelease(Attr);

  Frame := CTFramesetterCreateFrame(FrameSetter, CFRangeMake(0, 0), Path, nil);
  CFRelease(FrameSetter);
  CFRelease(Str);

  Context := CGBitmapContextCreate(FBits, BitmapSize, BitmapSize, 8, BitmapSize * 4, FColorSpace,
    kCGImageAlphaPremultipliedLast);
  // Metrics
  Lines := CTFrameGetLines(Frame);

  Line := CTLineRef(CFArrayGetValueAtIndex(Lines, 0));
  Runs := CTLineGetGlyphRuns(Line);

  Run := CFArrayGetValueAtIndex(Runs, 0);

  Bounds := CTRunGetImageBounds(Run, Context, CFRangeMake(0, 1));
  CTRunGetAdvances(Run, CFRangeMake(0, 1), @Size);
  CTRunGetTypographicBounds(Run, CFRangeMake(0, 1), @Ascent,  @Descent, @Leading);

  GlyphRect := Rect(Trunc(Bounds.origin.x),
    Max(Trunc(Ascent - Bounds.origin.y - Bounds.size.height) - 1, 0),
    Ceil(Bounds.origin.x + Bounds.size.width),
    Round(Ascent + Descent + Descent));

  CTFrameGetLineOrigins(Frame, CFRangeMake(0, 0), @BaseLinePos);
  BaseLineOffset := BitmapSize - BaseLinePos.y;

  GlyphStyle := [];
  if ((Bounds.size.width = 0) and (Bounds.size.height = 0)) or not HasGlyph(Char) then
    GlyphStyle := [TFontGlyphStyle.NoGlyph];

  Result := TFontGlyph.Create(Point(GlyphRect.Left, GlyphRect.Top), Round(Size.width),
    Round(FDefaultVerticalAdvance), GlyphStyle);
  if (TFontGlyphSetting.gsBitmap in Settings) and
     (HasGlyph(Char) or ((Bounds.size.width > 0) and (Bounds.size.height > 0))) then
  begin
    FillChar(FBits^, BitmapSize * Round(Ascent + Descent + Descent) * 4, 0);

    if not SameValue(FDefaultBaseline - BaseLineOffset, 0, Epsilon) then
      CGContextTranslateCTM(Context, 0, -Abs(FDefaultBaseline - BaseLineOffset));
    CTFrameDraw(Frame, Context);

    Result.Bitmap.SetSize(GlyphRect.Width, GlyphRect.Height, TPixelFormat.pfA8R8G8B8);

    if TFontGlyphSetting.gsPremultipliedAlpha in Settings then
    begin
      for I := GlyphRect.Top to GlyphRect.Bottom - 1 do
        Move(PAlphaColorArray(FBits)^[I * BitmapSize + Max(GlyphRect.Left, 0)],
          Result.Bitmap.GetPixelAddr(0, I - GlyphRect.Top)^, Result.Bitmap.Pitch);
    end
    else
      for I := GlyphRect.Left to GlyphRect.Right - 1 do
        for J := GlyphRect.Top to GlyphRect.Bottom - 1 do
        begin
          Color := FBits[J * BitmapSize + I];
          if Color.R > 0 then
          begin
            C := (Color.R + Color.G + Color.B) div 3;
            Result.Bitmap.Pixels[I - GlyphRect.Left, J - GlyphRect.Top] := MakeColor($FF, $FF, $FF, C);
          end
        end;
  end;

  CGContextRelease(Context);

  CFRelease(Frame);
  CFRelease(Path);
end;

end.
