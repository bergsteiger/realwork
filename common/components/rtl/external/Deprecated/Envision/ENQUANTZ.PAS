{----------------------------------------------------------------------------
|
| Library: Envision
|
| Module: EnQuantz
|
| Description: Color quantization. The algorithm is based on the method
|              decribed in the book "Bitmapped graphics programming" by
|              Marv Luse, which operates on the principal of selecting
|              colors maximally far apart in the RGB cube, combined with the
|              popularity approach. It's relatively slow but generates
|              good results.
|
| History: Dec 20, 1998. Michel Brazeau, first version
|
|---------------------------------------------------------------------------}
unit EnQuantz;

{$I Envision.Inc}

interface

uses
    Windows,  { for TMaxLogPalette }
    EnMisc,   { for TMaxLogPalette }
    EnDiGrph; { for TDibGraphic }

{ create an optimized palette given a DibGraphic }
procedure GetOptimizedPalette( const DibGraphic    : TDibGraphic;
                               var   Palette       : TMaxLogPalette;
                                     PaletteSize   : Word;
                               const ProgressEvent : TEnvisionProgressEvent;
                               var   LastPercent   : ShortInt );

function Rgb24ToRgb15(const Rgb : TRgb) : Word;

function Rgb15ToRgb24(const Rgb15 : Word) : TRgbTriple;

implementation

type

TpColorUsageArray = ^TColorUsageArray;
TColorUsageArray  = array[0..$7FFF] of Word;

TpRgbArray = ^TRgbArray;
TRgbArray  = array[0..$2AAAAAA0] of TRgbTriple;

{--------------------------------------------------------------------------}

function Rgb24ToRgb15(const Rgb : TRgb) : Word;
var
    Red   : Byte;
    Blue  : Byte;
    Green : Byte;
begin
    Red    := Rgb.Red   div 8;
    Green  := Rgb.Green div 8;
    Blue   := Rgb.Blue  div 8;

    Result := Red or
              (Green shl 5) or
              (Blue shl 10);
end;

{--------------------------------------------------------------------------}

function Rgb15ToRgb24(const Rgb15 : Word) : TRgbTriple;
begin
    Result.rgbtRed   := (Rgb15 and $001F) * 8;
    Result.rgbtGreen := ((Rgb15 and $03E0) shr 5) * 8;
    Result.rgbtBlue  := ((Rgb15 and $7C00) shr 10) * 8;
end;

{--------------------------------------------------------------------------}

{ exchange the colors in a TRgbArray }
procedure ExchangeRgb( var   RgbArray   : TRgbArray;
                       const Index1     : LongInt;
                       const Index2     : LongInt );
var
    Temp : TRgbTriple;
begin
    Temp := RgbArray[Index1];
    RgbArray[Index1] := RgbArray[Index2];
    RgbArray[Index2] := Temp;
end;

{--------------------------------------------------------------------------}

{ returns the square the of distance between to RGB values,
  (Red1-Red2)^2 + (Blue1-Blue2)^2 + (Green1-Green2)^2  }
function RgbDistance( const Rgb1  : TRgbTriple;
                      const Rgb2  : TRgbTriple ) : LongInt;
var
    DiffRed      : LongInt;
    DiffGreen    : LongInt;
    DiffBlue     : LongInt;
begin
    DiffRed   := (Rgb1.rgbtRed - Rgb2.rgbtRed);
    DiffGreen := (Rgb1.rgbtGreen - Rgb2.rgbtGreen);
    DiffBlue  := (Rgb1.rgbtBlue - Rgb2.rgbtBlue);

    Result    := DiffRed*DiffRed + DiffGreen*DiffGreen + DiffBlue*DiffBlue;
end;

{--------------------------------------------------------------------------}

{ returns the index of an RGB entry which has its color the closest to
  an RGB value. }
function ClosestRgb( const Rgb      : TRgbTriple;
                     const RgbArray : TRgbArray;
                     const RgbCount : LongInt ) : LongInt;
var
    Min   : LongInt;
    Dist  : LongInt;
    Index : LongInt;
begin
    Min    := RgbDistance(Rgb, RgbArray[0]);

    Result := 0;

    for Index := 1 to (RgbCount-1) do
    begin
        Dist := RgbDistance(Rgb, RgbArray[Index]);

        if Dist < Min then
        begin
            Min    := Dist;
            Result := Index;
        end;
    end;
end;

{--------------------------------------------------------------------------}

{ find index of Rgb between Mid..Max maximal to 0..Mid-1 }
function MaximalRgb( const RgbArray   : TRgbArray;
                     const Mid        : LongInt;
                     const Max        : LongInt ) : LongInt;
var
    N     : LongInt;
    DMin  : LongInt;
    DSum  : LongInt;
    I, J  : LongInt;
    D       : LongInt;
    Maximal : LongInt;
begin
    N       := 1 shl 30;
    DMin    := N;
    Maximal := Mid;

    for I := Mid to (Max-1) do
    begin
        DSum := 0;

        for J := 0 to (Mid-1) do
        begin
            D := RgbDistance(RgbArray[I], RgbArray[J]);

            if D = 0 then
            begin
                DSum := N;
                break;
            end;

            DSum := DSum + (N div D);
        end;

        if DSum < DMin then
        begin
            DMin   := DSum;
            Maximal := I;
        end;
    end;

    Result := Maximal;
end;

{--------------------------------------------------------------------------}

{ reduce the colors in RgbArray to a palette containing PaletteSize
  entries. The palette entries are stored at the beginning of the
  RgbArray }
procedure ReduceColors( var   RgbArray      : TRgbArray;
                        const RgbCount      : LongInt;
                        const PaletteSize   : LongInt;
                        const ProgressEvent : TEnvisionProgressEvent;
                        var   LastPercent   : ShortInt );
var
    I    : LongInt;
    IMin : LongInt;
    Rgb  : TRgbTriple;
begin
    Rgb.rgbtRed   := 255;
    Rgb.rgbtGreen := 255;
    Rgb.rgbtBlue  := 255;

    I := ClosestRgb(Rgb, RgbArray, RgbCount);

    IMin := 0;
    while IMin < PaletteSize do
    begin
        LastPercent := DoProgress(nil, ProgressEvent, IMin, 0, PaletteSize, LastPercent);
        ExchangeRgb(RgbArray, I, IMin);
        Inc(IMin);
        I := MaximalRgb(RgbArray, IMin, RgbCount);
    end;
end;

{--------------------------------------------------------------------------}

procedure GetOptimizedPalette( const DibGraphic    : TDibGraphic;
                               var   Palette       : TMaxLogPalette;
                                     PaletteSize   : Word;
                               const ProgressEvent : TEnvisionProgressEvent;
                               var   LastPercent   : ShortInt );
var
    pColors15     : TpColorUsageArray;
    ColorCount    : LongInt;
    X,Y           : LongInt;
    Rgb15         : Word;

    SourceIndex   : LongInt;
    DestIndex     : LongInt;
    pRgbColors    : TpRgbArray;

    MinUsageCount : Word;

begin
    if PaletteSize > 256 then
        PaletteSize := 256;

    New(pColors15);
    try
        FillChar(pColors15^, SizeOf(pColors15^), 0);
        ColorCount := 0;

        for Y := 0 to (DibGraphic.Height -1) do
        begin
            for X := 0 to (DibGraphic.Width -1) do
            begin
                Rgb15 := Rgb24ToRgb15(DibGraphic.Rgb[X, Y]);

                if pColors15^[Rgb15] < $FFFF then
                    Inc(pColors15^[Rgb15]);

                if pColors15^[Rgb15] = 1 then
                    Inc(ColorCount);
            end;
        end;

        { reduce the number of candidate colors by elimating colors
          not used very often, for faster processing. }
        MinUsageCount := 20;
        if ColorCount < 10000 then
            MinUsageCount := 15;
        if ColorCount < 5000 then
            MinUsageCount := 10;
        if ColorCount < 2500 then
            MinUsageCount := 5;
        if ColorCount < 1250 then
            MinUsageCount := 2;

        GetMem(pRgbColors, ColorCount*3);
        try
            DestIndex := 0;
            for SourceIndex := Low(pColors15^) to High(pColors15^) do
            begin
                if pColors15^[SourceIndex] > MinUsageCount then
                begin
                    pRgbColors^[DestIndex] := Rgb15ToRgb24(SourceIndex);
                    Inc(DestIndex);
                end;
            end;

            { assert: pRgbColors^ contains ColorCount color values from
              the image. }

            if DestIndex > PaletteSize then
                ReduceColors(pRgbColors^, DestIndex, PaletteSize, ProgressEvent, LastPercent);

            FillChar(Palette, SizeOf(Palette), 0);
            Palette.palNumEntries := PaletteSize;
            Palette.palVersion    := $0300;
            for SourceIndex := 0 to (PaletteSize-1) do
            begin
                Palette.palPalEntry[SourceIndex].peRed   := pRgbColors^[SourceIndex].rgbtRed;
                Palette.palPalEntry[SourceIndex].peGreen := pRgbColors^[SourceIndex].rgbtGreen;
                Palette.palPalEntry[SourceIndex].peBlue  := pRgbColors^[SourceIndex].rgbtBlue;
            end;

        finally
            FreeMem(pRgbColors, ColorCount*3);
        end;

    finally
        Dispose(pColors15);
    end;
end;

{--------------------------------------------------------------------------}

end.
