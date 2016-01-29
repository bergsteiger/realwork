{----------------------------------------------------------------------------
|
| Library: Envision
|
| Module: EnTransf
|
| Description: Image transform classes.
|
| History: Nov 28, 1998. Michel Brazeau, first version
|          Feb 04, 1999. MB add Dither and Quantize properties to
|                        TImageFormatTransform
|          Feb 11, 1999. MB add OnProgress event
|          Apr 19, 1999. MB add TCropTransform
|          Jun 24, 1999. MB add Interpolated and Filter properties to
|                        TResizeTransform
|
|---------------------------------------------------------------------------}
unit EnTransf;

{$I Envision.Inc}

interface

uses
    Windows,  { for TMaxLogPalette ... }
    EnMisc,   { for TEnvisionProgressEvent, MinInteger, DWORD, TpIntegerArray } 
    EnDiGrph; { for TDibGraphic }

type

TImageTransform = class(TObject)
protected
    FOnProgress  : TEnvisionProgressEvent;

    { last percentage of progress in FOnProgress handler }
    FLastPercent : ShortInt;

public
    { by default, Apply creates a new image, invokes ApplyOnDest,
      assigns the result to DibGraphic, and then frees the temporary
      image. This method should be overriden when the processing may
      occur directly on the image, converving resources. }
    procedure Apply( const DibGraphic : TDibGraphic ); virtual;

    procedure ApplyOnDest( const Source : TDibGraphic;
                           const Dest   : TDibGraphic ); virtual;

    property OnProgress : TEnvisionProgressEvent read FOnProgress
                                                 write FOnProgress;
end;

{--------------------------------------------------------------------------}

TAntiAliasTransform = class(TImageTransform)
    procedure Apply( const DibGraphic : TDibGraphic ); override;
    procedure ApplyOnDest( const Source : TDibGraphic;
                           const Dest   : TDibGraphic ); override;
end;

{--------------------------------------------------------------------------}

{ 3x3 convolution transform. By default, the matrix is set to not alter
  the image }
TConvolutionTransform = class(TImageTransform)
public
    A1, A2, A3  : ShortInt;
    B1, B2, B3  : ShortInt;
    C1, C2, C3  : ShortInt;
    Divisor     : ShortInt;

    constructor Create;

    procedure ApplyOnDest( const Source : TDibGraphic;
                           const Dest   : TDibGraphic ); override;
end;

{--------------------------------------------------------------------------}

TSharpenTransform = class(TConvolutionTransform)
protected
    FFactor : Byte;
public
    constructor Create;

    procedure ApplyOnDest( const Source : TDibGraphic;
                           const Dest   : TDibGraphic ); override;

    { sharpening factor, 0 - 100 }
    property Factor : Byte read FFactor
                           write FFactor;
end;

{--------------------------------------------------------------------------}

TSmoothTransform = class(TConvolutionTransform)
protected
    FFactor : Byte;
public
    constructor Create;

    procedure ApplyOnDest( const Source : TDibGraphic;
                           const Dest   : TDibGraphic ); override;

    { Smooth factor, 0 - 100 }
    property Factor : Byte read FFactor
                           write FFactor;
end;

{--------------------------------------------------------------------------}

TEdgeTransform = class(TConvolutionTransform)
public
    constructor Create;
end;

{--------------------------------------------------------------------------}

TEmbossTransform = class(TConvolutionTransform)
public
    constructor Create;
end;

{--------------------------------------------------------------------------}

TFlipHorizontalTransform = class(TImageTransform)
public
    procedure ApplyOnDest( const Source : TDibGraphic;
                           const Dest   : TDibGraphic ); override;
end;

{--------------------------------------------------------------------------}

TFlipVerticalTransform = class(TImageTransform)
public
    procedure ApplyOnDest( const Source : TDibGraphic;
                           const Dest   : TDibGraphic ); override;
end;

{--------------------------------------------------------------------------}

TRotateTransform = class(TImageTransform)
protected
    FAngle  : Double;

    procedure Rotate90( const Source : TDibGraphic;
                        const Dest   : TDibGraphic ); dynamic;

    procedure Rotate180( const Source : TDibGraphic;
                         const Dest   : TDibGraphic ); dynamic;

    procedure Rotate270( const Source : TDibGraphic;
                         const Dest   : TDibGraphic ); dynamic;

    procedure RotateArbitrary( const Source : TDibGraphic;
                               const Dest   : TDibGraphic ); dynamic;

public
    constructor Create;

    procedure ApplyOnDest( const Source : TDibGraphic;
                           const Dest   : TDibGraphic ); override;

    property Angle : Double read FAngle
                            write FAngle;
end;

{--------------------------------------------------------------------------}

TNegativeTransform = class(TImageTransform)
public
    procedure Apply( const DibGraphic : TDibGraphic ); override;

    procedure ApplyOnDest( const Source : TDibGraphic;
                           const Dest   : TDibGraphic ); override;
protected
    procedure ApplyToPaletteDib( const DibGraphic : TDibGraphic );

end;

{--------------------------------------------------------------------------}

TContrastTransform = class(TImageTransform)
protected
    FIncrease : Boolean;
public
    constructor Create;

    procedure ApplyOnDest( const Source : TDibGraphic;
                           const Dest   : TDibGraphic ); override;

    property Increase : Boolean read FIncrease
                                write FIncrease;
end;

{--------------------------------------------------------------------------}

TBrightnessTransform = class(TImageTransform)
protected
    FPercent : Double;

    procedure SetPercent( const InPercent : Double );

public
    constructor Create;

    procedure ApplyOnDest( const Source : TDibGraphic;
                           const Dest   : TDibGraphic ); override;

    property Percent : Double read FPercent
                              write SetPercent;
end;

{--------------------------------------------------------------------------}

TGammaTransform = class(TImageTransform)
protected
    FGamma : Double;

    procedure SetGamma( const InGamma : Double );

public
    constructor Create;

    procedure ApplyOnDest( const Source : TDibGraphic;
                           const Dest   : TDibGraphic ); override;

    property Gamma : Double read FGamma
                            write SetGamma;
end;

{--------------------------------------------------------------------------}

TConvertToGrayTransform = class(TImageTransform)
protected
    FRedFactor   : Double;
    FGreenFactor : Double;
    FBlueFactor  : Double;

    FGrayFormat  : TImageFormat;

    procedure SetRedFactor(const Factor : Double);
    procedure SetGreenFactor(const Factor : Double);
    procedure SetBlueFactor(const Factor : Double);

    procedure SetGrayFormat(const Format : TImageFormat);

public
    constructor Create;

    procedure ApplyOnDest( const Source : TDibGraphic;
                           const Dest   : TDibGraphic ); override;

    property RedFactor : Double read FRedFactor
                                write SetRedFactor;

    property GreenFactor : Double read FGreenFactor
                                  write SetGreenFactor;

    property BlueFactor  : Double read FBlueFactor
                                  write SetBlueFactor;

    property GrayFormat : TImageFormat read FGrayFormat
                                       write SetGrayFormat;
end;

{--------------------------------------------------------------------------}

type

TInterpolationFilter = ( ifTriangle,
                         ifHermite,
                         ifBell,
                         ifBSpline,
                         ifLanczos3,
                         ifMitchell );

TResizeTransform = class(TImageTransform)
protected
    FWidth              : LongInt;
    FHeight             : LongInt;

    FInterpolated       : Boolean;

    FOverrideDestFormat : Boolean;
    FDestFormat         : TImageFormat;

    FFilter       : TInterpolationFilter;

public
    constructor Create;

    procedure ApplyOnDest( const Source : TDibGraphic;
                           const Dest   : TDibGraphic ); override;

    property Width  : LongInt read FWidth
                              write FWidth;

    property Height : LongInt read FHeight
                              write FHeight;

    property Interpolated : Boolean read FInterpolated
                                    write FInterpolated;

    property Filter : TInterpolationFilter read FFilter
                                           write FFilter;

    property OverrideDestFormat : Boolean read FOverrideDestFormat
                                          write FOverrideDestFormat;

    property DestFormat : TImageFormat read FDestFormat
                                       write FDestFormat;
end;

{--------------------------------------------------------------------------}

TImageFormatTransform = class(TImageTransform)
protected
    FImageFormat : TImageFormat;

    FPalette     : TMaxLogPalette;

    FQuantize    : Boolean;
    FDither      : Boolean;

    procedure QuantizeProgress( const Sender          : TObject;
                                const PercentProgress : Byte );
public
    constructor Create;

    procedure Apply( const DibGraphic : TDibGraphic ); override;

    procedure ApplyOnDest( const Source : TDibGraphic;
                           const Dest   : TDibGraphic ); override;

    property ImageFormat : TImageFormat read FImageFormat
                                        write FImageFormat;

    { If Quantize is True and ImageFormat <> ifTrueColor, the resulting
      palette will be obtained by applying a quantization algoritm which
      will create an optimized palette from the source colors. }
    property Quantize : Boolean read FQuantize
                                write FQuantize;

    { If Dither is True and ImageFormat <> ifTrueColor the resulting
      image is dithered using error diffusion. }
    property Dither : Boolean read FDither
                              write FDither;

    { When Quantize is False and ImageFormat <> ifTrueColor, the  palette
      to use may be specifed in the Palette property }
    property Palette : TMaxLogPalette read FPalette
                                      write FPalette;
end;

{--------------------------------------------------------------------------}

TCropTransform = class(TImageTransform)
protected
    FTop    : LongInt;
    FLeft   : LongInt;
    FBottom : LongInt;
    FRight  : LongInt;

public
    constructor Create;

    procedure ApplyOnDest( const Source : TDibGraphic;
                           const Dest   : TDibGraphic ); override;

    property Top    : LongInt read FTop write FTop;
    property Left   : LongInt read FLeft write FLeft;
    property Bottom : LongInt read FBottom write FBottom;
    property Right  : LongInt read FRight write FRight;
end;

{--------------------------------------------------------------------------}

{ (Hue, Saturation, Luminosity) to/from (red, green, blue) conversions.
  Adapted from ImageMagick Gems.C }
procedure HSLToRGB(       Hue        : Double;
                    const Saturation : Double;
                    const Luminosity : Double;
                    var   Rgb        : TRGB );

procedure RGBToHSL( const Rgb        : TRGB;
                    var   Hue        : Double;
                    var   Saturation : Double;
                    var   Luminosity : Double );

{--------------------------------------------------------------------------}

implementation

uses
    Graphics, { for GetDibSizes }
    Dialogs,  { for ShowMessage }
    SysUtils, { for Format }
    EnQuantz, { for GetOptimizedPalette }
    EnMsg;    { for EEnvisionError }

var

AntiAliasLookup  : array[Byte] of Word;

{--------------------------------------------------------------------------}

procedure TImageTransform.Apply( const DibGraphic : TDibGraphic );
var
    Dest : TDibGraphic;
begin
    Dest := TDibGraphic.Create;
    try
        ApplyOnDest(DibGraphic, Dest);
        DibGraphic.Assign(Dest);
    finally
        Dest.Free;
    end;
end;

{--------------------------------------------------------------------------}

procedure TImageTransform.ApplyOnDest( const Source : TDibGraphic;
                                       const Dest   : TDibGraphic );
begin
    raise EEnvisionError.Create(
             Format(msgMethodNotImplemented, ['"ApplyOnDest"', Self.ClassName]));
end;

{--------------------------------------------------------------------------}

procedure TAntiAliasTransform.Apply( const DibGraphic : TDibGraphic );
begin
    if DibGraphic.ImageFormat = ifBlackWhite then
        inherited Apply(DibGraphic);
end;

{--------------------------------------------------------------------------}
procedure TAntiAliasTransform.ApplyOnDest( const Source : TDibGraphic;
                                           const Dest   : TDibGraphic );
var
    X               : Integer;
    Y               : Integer;
    Width           : LongInt;
    Height          : LongInt;
    HeightMinus2    : LongInt;

    pDestByte       : ^Byte;
    pSourceByte1    : ^Byte;
    pSourceByte2    : ^Byte;

    Lookup1         : Word;
    Lookup2         : Word;

    ByteWidth       : LongInt;

begin
    if Source.ImageFormat <> ifBlackWhite then
    begin
        Dest.Assign(Source);
        Exit;
    end;

    Width   := Source.Width;
    Height  := Source.Height;

    Dest.NewImage( Width, Height, ifGray16, nil,
                   Source.XDotsPerInch, Source.YDotsPerInch);

    FLastPercent := -1;
    FLastPercent := DoProgress(Self, FOnProgress, 0, 0, 100, FLastPercent);

    HeightMinus2 := Height-2;

    if (Width mod 8) = 0 then
        ByteWidth := (Width div 8)
    else
        ByteWidth := (Width div 8) + 1;

    for Y := 0 to (HeightMinus2) do
    begin
        pDestByte       := Pointer(Dest.ScanLine[Y]);

        pSourceByte1    := Pointer(Source.ScanLine[Y]);
        pSourceByte2    := Pointer(Source.ScanLine[Y+1]);

        { MB Sep 11, 1999 Use ByteWidth instead of Source.ScanLineSize which an
          access violation on some rare images. See ..\QATest\Test25.pcx }
        for X := 1 to ByteWidth do
        begin

            Lookup1 := AntiAliasLookup[(pSourceByte1^ and $F0) or
                                       ((pSourceByte2^ and $F0) shr 4)];

            Lookup2 := AntiAliasLookup[((pSourceByte1^ and $0F) shl 4) or
                                       (pSourceByte2^ and $0F)];

            pDestByte^ := Lookup1 shr 8;
            Inc(pDestByte);

            pDestByte^ := Lookup1 and $00FF;
            Inc(pDestByte);

            pDestByte^ := Lookup2 shr 8;
            Inc(pDestByte);

            pDestByte^ := Lookup2 and $00FF;
            Inc(pDestByte);

            Inc(pSourceByte1);
            Inc(pSourceByte2);

        end;

        FLastPercent := DoProgress(Self, FOnProgress, Y, 0, Height-1, FLastPercent);
    end;

    { last scan line, use same algorigthm but just simulate an extra
      line with a copy of the last one.  }
    pDestByte       := Pointer(Dest.ScanLine[Height-1]);
    pSourceByte1    := Pointer(Source.ScanLine[Height-1]);

    for X := 1 to ByteWidth do
    begin
        Lookup1 := AntiAliasLookup[(pSourceByte1^ and $F0) or
                                   ((pSourceByte1^ and $F0) shr 4)];

        Lookup2 := AntiAliasLookup[((pSourceByte1^ and $0F) shl 4) or
                                   (pSourceByte1^ and $0F)];

        pDestByte^ := Lookup1 shr 8;
        Inc(pDestByte);

        pDestByte^ := Lookup1 and $00FF;
        Inc(pDestByte);

        pDestByte^ := Lookup2 shr 8;
        Inc(pDestByte);

        pDestByte^ := Lookup2 and $00FF;
        Inc(pDestByte);
    end;

    FLastPercent := DoProgress(Self, FOnProgress, 100, 0, 100, FLastPercent);
end;

(* Old slower implemenation kept as reference
procedure TAntiAliasTransform.ApplyOnDest( const Source : TDibGraphic;
                                           const Dest   : TDibGraphic );
var
   X               : Integer;
   Y               : Integer;
   Value           : Byte;
   Width           : LongInt;
   Height          : LongInt;
   SourceScanLine1 : PByteArray;
   SourceScanLine2 : PByteArray;
   DestScanLine    : PByteArray;
   pByte           : ^Byte;

begin
    if Source.ImageFormat <> ifBlackWhite then
    begin
        Dest.Assign(Source);
        Exit;
    end;

    Width   := Source.Width;
    Height  := Source.Height;

    Dest.NewImage( Width, Height, ifGray16, nil,
                   Source.XDotsPerInch, Source.YDotsPerInch);

    FLastPercent := DoProgress(Self, FOnProgress, 0, 0, 100, FLastPercent);

    for Y := 0 to (Height-2) do
    begin
        DestScanLine := Dest.ScanLine[Y];

        for X := 0 to (Width-2)  do
        begin
            SourceScanLine1 := Source.ScanLine[Y];
            SourceScanLine2 := Source.ScanLine[Y+1];

            { code is inlined for faster performance
            Value := GetPixelBc1(SourceScanLine1, X) +
                     GetPixelBc1(SourceScanLine1, X+1) +
                     GetPixelBc1(SourceScanLine2, X) +
                     GetPixelBc1(SourceScanLine2, X+1);

            SetPixelBc4(DestScanLine, X, (Value * 15) div 4);
            }

            Value := 0;
            if (SourceScanLine1^[(X div 8)] and ($01 shl (8 - ((X mod 8) + 1)))) <> 0 then
                Inc(Value, 4);
            if (SourceScanLine1^[((X+1) div 8)] and ($01 shl (8 - (((X+1) mod 8) + 1)))) <> 0 then
                Inc(Value, 4);
            if (SourceScanLine2^[(X div 8)] and ($01 shl (8 - ((X mod 8) + 1)))) <> 0 then
                Inc(Value, 4);
            if (SourceScanLine2^[((X+1) div 8)] and ($01 shl (8 - (((X+1) mod 8) + 1)))) <> 0 then
                Inc(Value, 4);

            if Value > 15 then
                Value := 15;

            pByte   := @DestScanLine^[(X div 2)];

            if (X and $01) = 0 then
                pByte^ := (pByte^ and $0F) or (Value shl 4)
            else
                pByte^ := (pByte^ and $F0) or (Value);
        end;

        FLastPercent := DoProgress(Self, FOnProgress, Y, 0, Height-1, FLastPercent);
    end;

    FLastPercent := DoProgress(Self, FOnProgress, 100, 0, 100, FLastPercent);
end;
*)

{--------------------------------------------------------------------------}

constructor TConvolutionTransform.Create;
begin
    inherited Create;

    A1 := 0; A2 := 0; A3 := 0;
    B1 := 0; B2 := 1; B3 := 0;
    C1 := 0; C2 := 0; C3 := 0;

    Divisor := 1;
end;

{--------------------------------------------------------------------------}

procedure TConvolutionTransform.ApplyOnDest(
                           const Source : TDibGraphic;
                           const Dest   : TDibGraphic );
var
    Blue        : LongInt;
    Green       : LongInt;
    Red         : LongInt;
    X           : LongInt;
    Y           : LongInt;

    Width           : LongInt;
    Height          : LongInt;

    SourceRGBA1 : TRgb;
    SourceRGBA2 : TRgb;
    SourceRGBA3 : TRgb;
    SourceRGBB1 : TRgb;
    SourceRGBB2 : TRgb;
    SourceRGBB3 : TRgb;
    SourceRGBC1 : TRgb;
    SourceRGBC2 : TRgb;
    SourceRGBC3 : TRgb;

    DestRgb     : TRgb;

    procedure CopyBorder;
    var
        X, Y : LongInt;
    begin
        for Y := 0 to (Height-1) do
        begin
            if (Y = 0) or (Y = (Height-1)) then
            begin
                for X := 1 to (Width-2)  do
                begin
                    { draw horizontal borders }
                    Dest.Rgb[X, 0]        := Source.Rgb[X, 0];
                    Dest.Rgb[X, Height-1] := Source.Rgb[X, Height-1];
                end;
            end
            else
            begin
                { draw vertical borders }
                Dest.Rgb[0, Y]       := Source.Rgb[0, Y];
                Dest.Rgb[Width-1, Y] := Source.Rgb[Width-1, Y];
            end;
        end;
    end;

begin
    Width   := Source.Width;
    Height  := Source.Height;

    if (Width < 3) or (Height < 3) then
    begin
        Dest.Assign(Source);
        Exit;
    end;

    Dest.NewImage( Width, Height, ifTrueColor, nil,
                   Source.XDotsPerInch, Source.YDotsPerInch );

    FLastPercent := -1;
    FLastPercent := DoProgress(Self, FOnProgress, 0, 0, 100, FLastPercent);

    CopyBorder;

    if Divisor = 0 then
        Divisor := 1;

    for Y := 1 to (Height-2) do
    begin
        FLastPercent := DoProgress(Self, FOnProgress, Y, 0, Height-1, FLastPercent);

        for X := 1 to (Width-2)  do
        begin
            SourceRGBA1 := Source.Rgb[X-1,Y-1];
            SourceRGBA2 := Source.Rgb[X,Y-1];
            SourceRGBA3 := Source.Rgb[X+1,Y-1];

            SourceRGBB1 := Source.Rgb[X-1,Y];
            SourceRGBB2 := Source.Rgb[X,Y];
            SourceRGBB3 := Source.Rgb[X+1,Y];

            SourceRGBC1 := Source.Rgb[X-1,Y+1];
            SourceRGBC2 := Source.Rgb[X,Y+1];
            SourceRGBC3 := Source.Rgb[X+1,Y+1];

            Red :=
                 A1*SourceRGBA1.Red +
                 A2*SourceRGBA2.Red +
                 A3*SourceRGBA3.Red +
                 B1*SourceRGBB1.Red +
                 B2*SourceRGBB2.Red +
                 B3*SourceRGBB3.Red +
                 C1*SourceRGBC1.Red +
                 C2*SourceRGBC2.Red +
                 C3*SourceRGBC3.Red;
            if Red < 0 then
                DestRgb.Red := 0
            else
                DestRgb.Red := MinInteger(Red div Divisor, High(Byte));

            Green    :=
                 A1*SourceRGBA1.Green +
                 A2*SourceRGBA2.Green +
                 A3*SourceRGBA3.Green +
                 B1*SourceRGBB1.Green +
                 B2*SourceRGBB2.Green +
                 B3*SourceRGBB3.Green +
                 C1*SourceRGBC1.Green +
                 C2*SourceRGBC2.Green +
                 C3*SourceRGBC3.Green;
            if Green < 0 then
                DestRgb.Green := 0
            else
                DestRgb.Green := MinInteger(Green div Divisor, High(Byte));

            Blue :=
                 A1*SourceRGBA1.Blue +
                 A2*SourceRGBA2.Blue +
                 A3*SourceRGBA3.Blue +
                 B1*SourceRGBB1.Blue +
                 B2*SourceRGBB2.Blue +
                 B3*SourceRGBB3.Blue +
                 C1*SourceRGBC1.Blue +
                 C2*SourceRGBC2.Blue +
                 C3*SourceRGBC3.Blue;
            if Blue < 0 then
                DestRgb.Blue := 0
            else
                DestRgb.Blue := MinInteger(Blue div Divisor, High(Byte));

            if Dest.ImageFormat <> ifTrueColor then
            begin
                { reduce the Color range with palette images to increase
                  processing speed when working with the Rgb property. The
                  internal cache to convert Rgb values to palette entries
                  is more efficient when the Color range is reduced. }
                DestRgb.Red   := (DestRgb.Red   div 7) * 7;
                DestRgb.Green := (DestRgb.Green div 7) * 7;
                DestRgb.Blue  := (DestRgb.Blue div 7) * 7;
            end;

            Dest.Rgb[X, Y] := DestRgb;
        end;
    end;

    FLastPercent := DoProgress(Self, FOnProgress, 100, 0, 100, FLastPercent);

end;

{--------------------------------------------------------------------------}

{ Sharpen transform based on ImageMagick, effects.C

  Convolves the Pixel neighborhood with this sharpening mask:

    -1 -2 -1
    -2  B2 -2
    -1 -2 -1

  B2 and the Divisor are computed from the sharpen Factor
}
constructor TSharpenTransform.Create;
begin
    inherited Create;

    A1 := -1; A2 := -2; A3 := -1;
    B1 := -2;           B3 := -2;
    C1 := -1; C2 := -2; C3 := -1;

    { B2 and the Divisor are computed when the transform is applied }

    FFactor := 10;
end;

{--------------------------------------------------------------------------}

procedure TSharpenTransform.ApplyOnDest( const Source : TDibGraphic;
                                         const Dest   : TDibGraphic );
begin
    B2 := Round((100-Factor)/4.0) + 15;
    Divisor := B2 - 12;

    inherited ApplyOnDest(Source, Dest);
end;

{--------------------------------------------------------------------------}

{ Smooth transform based on ImageMagick, effects.C

  Convolves the Pixel neighborhood with this smoothing mask:

   1  2   1
   2  B2  2
   1  2   1

  B2 and the Divisor are computed from the Smooth Factor
}
constructor TSmoothTransform.Create;
begin
    inherited Create;

    A1 := 1; A2 := 2; A3 := 1;
    B1 := 2;          B3 := 2;
    C1 := 1; C2 := 2; C3 := 1;

    { B2 and the Divisor are computed when the transform is applied }

    FFactor := 20;
end;

{--------------------------------------------------------------------------}

procedure TSmoothTransform.ApplyOnDest( const Source : TDibGraphic;
                                         const Dest   : TDibGraphic );
begin
    B2 := Round((100-Factor)/4.0) + 15;
    Divisor := B2 + 12;

    inherited ApplyOnDest(Source, Dest);
end;

{--------------------------------------------------------------------------}

constructor TEdgeTransform.Create;
begin
    inherited Create;

    A1 :=  1; A2 :=  1; A3 :=  1;
    B1 :=  1; B2 := -8; B3 :=  1;
    C1 :=  1; C2 :=  1; C3 :=  1;

    Divisor := 1;
end;

{--------------------------------------------------------------------------}

constructor TEmbossTransform.Create;
begin
    inherited Create;

    A1 := -1; A2 := -1; A3 := 0;
    B1 := -1; B2 :=  1; B3 := 1;
    C1 :=  0; C2 :=  1; C3 := 1;

    Divisor := 1;
end;

{--------------------------------------------------------------------------}

procedure TNegativeTransform.Apply( const DibGraphic : TDibGraphic );
var
    X,Y        : LongInt;
    pScanLine  : PByteArray;
    Rgb        : TRgb;
    Height     : LongInt;
begin
    FLastPercent := -1;
    FLastPercent := DoProgress(Self, FOnProgress, 0, 0, 100, FLastPercent);

    Height := DibGraphic.Height;

    { for Black&White and gray images, the bit values are inverted, to
      preserve a consistent palette. }
    case DibGraphic.ImageFormat of
        ifBlackWhite:
        begin
            for Y := 0 to (Height-1) do
            begin
                FLastPercent := DoProgress(Self, FOnProgress, Y, 0, Height-1, FLastPercent);

                pScanLine := DibGraphic.ScanLine[Y];
                for X := 0 to (DibGraphic.ScanLineSize-1) do
                    pScanLine^[X] := not pScanLine^[X];
            end;
        end;

        ifGray16:
        begin
            for Y := 0 to (DibGraphic.Height-1) do
            begin
                FLastPercent := DoProgress(Self, FOnProgress, Y, 0, Height-1, FLastPercent);

                pScanLine := DibGraphic.ScanLine[Y];
                for X := 0 to (DibGraphic.ScanLineSize-1) do
                    pScanLine^[X] := (15 - (pScanLine^[X] and $0F)) or
                                     ((15 - ((pScanLine^[X] shr 4)and $0F)) shl 4);
            end;
        end;

        ifGray256:
        begin
            for Y := 0 to (DibGraphic.Height-1) do
            begin
                FLastPercent := DoProgress(Self, FOnProgress, Y, 0, Height-1, FLastPercent);

                pScanLine := DibGraphic.ScanLine[Y];
                for X := 0 to (DibGraphic.ScanLineSize-1) do
                    pScanLine^[X] := 255 - pScanLine^[X];
            end;
        end;

        { for palette Color images, the palette is inverted as inverting the
          bits would require generating a new palette anyway. }
        ifColor16, ifColor256:
        begin
            ApplyToPaletteDib(DibGraphic);
        end;

        ifTrueColor:
        begin
            for Y := 0 to (DibGraphic.Height-1) do
            begin
                FLastPercent := DoProgress(Self, FOnProgress, Y, 0, Height-1, FLastPercent);

                for X := 0 to (DibGraphic.Width-1) do
                begin
                    Rgb := DibGraphic.Rgb[X,Y];

                    Rgb.Red   := 255 - Rgb.Red;
                    Rgb.Green := 255 - Rgb.Green;
                    Rgb.Blue  := 255 - Rgb.Blue;

                    DibGraphic.Rgb[X,Y] := Rgb;
                end;
            end;
        end;
    end; { case }
    
    FLastPercent := DoProgress(Self, FOnProgress, 100, 0, 100, FLastPercent);
end;

{--------------------------------------------------------------------------}

{$ifdef __Delphi3}
    {$define __UseLongInt}
{$endif}

{$ifdef __CBuilder3}
    {$define __UseLongInt}
{$endif}


procedure TNegativeTransform.ApplyToPaletteDib( const DibGraphic : TDibGraphic );
var
    Palette        : TMaxLogPalette;
    pSavedBits     : Pointer;
    {$ifdef __UseLongInt}
    InfoHeaderSize : LongInt;
    ImageSize      : LongInt;
    {$else}
    InfoHeaderSize : Cardinal;
    ImageSize      : Cardinal;
    {$endif}
    Index          : LongInt;

begin
    GetDibSizes(DibGraphic.BitmapHandle, InfoHeaderSize, ImageSize);
    GetMem(pSavedBits, ImageSize);
    try
        Move(DibGraphic.Bits^, pSavedBits^, ImageSize);

        FillChar(Palette, SizeOf(Palette), 0);
        Palette.palNumEntries := DibGraphic.Palette.palNumEntries;

        for Index := 0 to (DibGraphic.Palette.palNumEntries -1) do
        begin
            Palette.palPalEntry[Index].peRed :=
                                 255 - DibGraphic.Palette.palPalEntry[Index].peRed;
            Palette.palPalEntry[Index].peGreen :=
                                 255 - DibGraphic.Palette.palPalEntry[Index].peGreen;
            Palette.palPalEntry[Index].peBlue :=
                                 255 - DibGraphic.Palette.palPalEntry[Index].peBlue;
        end;

        DibGraphic.NewImage( DibGraphic.Width, DibGraphic.Height,
                             DibGraphic.ImageFormat, @Palette,
                             DibGraphic.XDotsPerInch, DibGraphic.YDotsPerInch );

        Move(pSavedBits^, DibGraphic.Bits^, ImageSize);

    finally
        FreeMem(pSavedBits, ImageSize);
    end;
end;

{--------------------------------------------------------------------------}

procedure TNegativeTransform.ApplyOnDest( const Source : TDibGraphic;
                                          const Dest   : TDibGraphic );
begin
    Dest.Assign(Source);

    Apply(Dest);
end;

{--------------------------------------------------------------------------}

procedure TFlipHorizontalTransform.ApplyOnDest(
                           const Source : TDibGraphic;
                           const Dest   : TDibGraphic );
var
    X, Y   : LongInt;
    Width  : LongInt;
    Height : LongInt;

begin
    Width  := Source.Width;
    Height := Source.Height;

    if (Width < 2) then
    begin
        Dest.Assign(Source);
        Exit;
    end;

    FLastPercent := -1;
    FLastPercent := DoProgress(Self, FOnProgress, 0, 0, 100, FLastPercent);

    Dest.NewImage( Width, Height, Source.ImageFormat, Source.PalettePtr,
                   Source.XDotsPerInch, Source.YDotsPerInch );

    for Y := 0 to (Height-1) do
    begin
        FLastPercent := DoProgress(Self, FOnProgress, Y, 0, Height-1, FLastPercent);

        for X := 0 to (Width-1) do
        begin
            if Source.ImageFormat = ifTrueColor then
                Dest.Rgb[(Width-1)-X, Y] := Source.Rgb[X,Y]
            else
                Dest.PaletteIndex[(Width-1)-X, Y] := Source.PaletteIndex[X,Y]
        end;
    end;

    FLastPercent := DoProgress(Self, FOnProgress, 100, 0, 100, FLastPercent);
end;

{--------------------------------------------------------------------------}

procedure TFlipVerticalTransform.ApplyOnDest(
                           const Source : TDibGraphic;
                           const Dest   : TDibGraphic );
var
    X, Y   : LongInt;
    Width  : LongInt;
    Height : LongInt;

begin
    Width  := Source.Width;
    Height := Source.Height;

    if (Height < 2) then
    begin
        Dest.Assign(Source);
        Exit;
    end;

    FLastPercent := -1;
    FLastPercent := DoProgress(Self, FOnProgress, 0, 0, 100, FLastPercent);

    Dest.NewImage( Width, Height, Source.ImageFormat, Source.PalettePtr,
                   Source.XDotsPerInch, Source.YDotsPerInch);

    for X := 0 to (Width-1) do
    begin
        FLastPercent := DoProgress(Self, FOnProgress, X, 0, Width-1, FLastPercent);

        for Y := 0 to (Height-1) do
        begin
            if Source.ImageFormat = ifTrueColor then
                Dest.Rgb[X, (Height-1)-Y] := Source.Rgb[X,Y]
            else
                Dest.PaletteIndex[X, (Height-1)-Y] := Source.PaletteIndex[X,Y]
        end;
    end;
    FLastPercent := DoProgress(Self, FOnProgress, 100, 0, 100, FLastPercent);
end;

{--------------------------------------------------------------------------}

constructor TRotateTransform.Create;
begin
    inherited Create;

    FAngle := 90.0;
end;

{--------------------------------------------------------------------------}

procedure TRotateTransform.ApplyOnDest(
                           const Source : TDibGraphic;
                           const Dest   : TDibGraphic );
var
    IntegralAngle : Integer;
    Whole         : Boolean;
begin
    FLastPercent := -1;
    FLastPercent := DoProgress(Self, FOnProgress, 0, 0, 100, FLastPercent);

    Whole := (Abs(Round(FAngle) - RoundFloat(FAngle,3)) < 0.005);

    if Whole then
    begin
        IntegralAngle := Round(FAngle);

        { convert angle to positive value between 0..359 }
        IntegralAngle := (360 + IntegralAngle) mod 360;

        while IntegralAngle < 0 do
            IntegralAngle := (360 + IntegralAngle) mod 360;
    end
    else
        IntegralAngle := -1;

    case IntegralAngle of
        0    : Dest.Assign(Source);
        90   : Rotate90(Source, Dest);
        180  : Rotate180(Source, Dest);
        270  : Rotate270(Source, Dest);
        else
            RotateArbitrary(Source, Dest);
    end; { case }

    FLastPercent := DoProgress(Self, FOnProgress, 100, 0, 100, FLastPercent);
end;

{--------------------------------------------------------------------------}

procedure TRotateTransform.Rotate90(
                         const Source : TDibGraphic;
                         const Dest   : TDibGraphic );
var
    X, Y         : LongInt;
    SourceWidth  : LongInt;
    SourceHeight : LongInt;

begin
    SourceWidth  := Source.Width;
    SourceHeight := Source.Height;

    Dest.NewImage( SourceHeight, SourceWidth,
                   Source.ImageFormat, Source.PalettePtr,
                   Source.XDotsPerInch, Source.YDotsPerInch );

    for Y := 0 to (SourceHeight-1) do
    begin
        FLastPercent := DoProgress(Self, FOnProgress, Y, 0, SourceHeight-1, FLastPercent);

        for X := 0 to (SourceWidth-1) do
        begin
            if Source.ImageFormat = ifTrueColor then
                Dest.Rgb[(SourceHeight-1)-Y, X] := Source.Rgb[X,Y]
            else
                Dest.PaletteIndex[(SourceHeight-1)-Y, X] := Source.PaletteIndex[X,Y];
        end;
    end;
end;

{--------------------------------------------------------------------------}

procedure TRotateTransform.Rotate180(
                         const Source : TDibGraphic;
                         const Dest   : TDibGraphic );
var
    X, Y         : LongInt;
    SourceWidth  : LongInt;
    SourceHeight : LongInt;

begin
    SourceWidth  := Source.Width;
    SourceHeight := Source.Height;

    Dest.NewImage( SourceWidth, SourceHeight,
                   Source.ImageFormat, Source.PalettePtr,
                   Source.XDotsPerInch, Source.YDotsPerInch );

    for Y := 0 to (SourceHeight-1) do
    begin
        FLastPercent := DoProgress(Self, FOnProgress, Y, 0, SourceHeight-1, FLastPercent);

        for X := 0 to (SourceWidth-1) do
        begin
            if Source.ImageFormat = ifTrueColor then
                Dest.Rgb[(SourceWidth-1)-X, (SourceHeight-1)-Y] := Source.Rgb[X,Y]
            else
                Dest.PaletteIndex[(SourceWidth-1)-X, (SourceHeight-1)-Y] := Source.PaletteIndex[X,Y]
        end;
    end;
end;

{--------------------------------------------------------------------------}

procedure TRotateTransform.Rotate270(
                         const Source : TDibGraphic;
                         const Dest   : TDibGraphic );
var
    X, Y         : LongInt;
    SourceWidth  : LongInt;
    SourceHeight : LongInt;

begin
    SourceWidth  := Source.Width;
    SourceHeight := Source.Height;

    Dest.NewImage( SourceHeight, SourceWidth,
                   Source.ImageFormat, Source.PalettePtr,
                   Source.XDotsPerInch, Source.YDotsPerInch );

    for Y := 0 to (SourceHeight-1) do
    begin
        FLastPercent := DoProgress(Self, FOnProgress, Y, 0, SourceHeight-1, FLastPercent);

        for X := 0 to (SourceWidth-1) do
        begin
            if Source.ImageFormat = ifTrueColor then
                Dest.Rgb[Y, (SourceWidth-1)-X] := Source.Rgb[X,Y]
            else
                Dest.PaletteIndex[Y, (SourceWidth-1)-X] := Source.PaletteIndex[X,Y];
        end;
    end;
end;

{--------------------------------------------------------------------------}

procedure TRotateTransform.RotateArbitrary(
                         const Source : TDibGraphic;
                         const Dest   : TDibGraphic );
var
    AngleRadians : Double;
    SinOfAngle   : Double;
    CosOfAngle   : Double;

    DestHeight   : LongInt;
    DestWidth    : LongInt;
    SourceHeight : LongInt;
    SourceWidth  : LongInt;

    NewX         : LongInt;
    NewY         : LongInt;
    X            : LongInt;
    Y            : LongInt;

    MinX         : LongInt;
    MaxX         : LongInt;
    MinY         : LongInt;
    MaxY         : LongInt;

    XOffset      : LongInt;
    YOffset      : LongInt;

    XCenter      : LongInt;
    YCenter      : LongInt;

    procedure RotatePoint( const X, Y              : LongInt;
                           const XOffset, YOffset  : LongInt;
                           const XCenter, YCenter  : LongInt;
                           var   NewX, NewY        : LongInt); register;
    begin
      NewX := Round((X - XCenter)*CosOfAngle - (Y - YCenter)*SinOfAngle + XCenter + XOffset);
      NewY := Round((X - XCenter)*SinOfAngle + (Y - YCenter)*CosOfAngle + YCenter + YOffset);
    end;

    procedure AdjustBounds;
    begin
        if NewX > MaxX then
            MaxX := NewX;
        if NewX < MinX then
            MinX := NewX;

        if NewY > MaxY then
            MaxY := NewY;
        if NewY < MinY then
            MinY := NewY;
    end;

begin
    AngleRadians := FAngle * Pi / 180;

    SinOfAngle   := sin(AngleRadians);
    CosOfAngle   := cos(AngleRadians);

    SourceWidth  := Source.Width;
    SourceHeight := Source.Height;

    XCenter := (SourceWidth div 2);
    YCenter := (SourceHeight div 2);

    NewX := 0; NewY := 0;
    RotatePoint(0, 0, 0, 0, XCenter, YCenter, NewX, NewY);
    MinX := NewX;
    MaxX := NewX;
    MinY := NewY;
    MaxY := NewY;

    RotatePoint( 0, SourceHeight-1, 0, 0, XCenter, YCenter, NewX, NewY );
    AdjustBounds;

    RotatePoint( SourceWidth-1, SourceHeight-1, 0, 0, XCenter, YCenter, NewX, NewY );
    AdjustBounds;

    RotatePoint( SourceWidth-1, 0, 0, 0, XCenter, YCenter, NewX, NewY );
    AdjustBounds;

    DestWidth  := MaxX - MinX + 1;
    DestHeight := MaxY - MinY + 1;

    XCenter := (DestWidth div 2);
    YCenter := (DestHeight div 2);

    Dest.NewImage( DestWidth, DestHeight,
                   Source.ImageFormat, Source.PalettePtr,
                   Source.XDotsPerInch, Source.YDotsPerInch );

    AngleRadians := -1*AngleRadians;

    SinOfAngle   := sin(AngleRadians);
    CosOfAngle   := cos(AngleRadians);

    XOffset := -((DestWidth div 2) - (SourceWidth div 2));
    YOffset := -((DestHeight div 2) - (SourceHeight div 2));

    for Y := 0 to (DestHeight-1) do
    begin
        FLastPercent := DoProgress(Self, FOnProgress, Y, 0, DestHeight-1, FLastPercent);

        for X := 0 to (DestWidth-1) do
        begin
            { inline the code for better performance
            RotatePoint( X, Y, XOffset, YOffset, XCenter, YCenter, NewX, NewY);
            }
            NewX := Round((X - XCenter)*CosOfAngle - (Y - YCenter)*SinOfAngle + XCenter + XOffset);
            NewY := Round((X - XCenter)*sinOfAngle + (Y - YCenter)*CosOfAngle + YCenter + YOffset);

            { this adjustment corrects rounding errors on boundaries }
            if NewX = SourceWidth then
                NewX := SourceWidth - 1;
            if NewY = SourceHeight then
                NewY := SourceHeight - 1;

            if (NewX >= 0) and
               (NewX <  SourceWidth) and
               (NewY >= 0) and
               (NewY <  SourceHeight) then
            begin
                if Source.ImageFormat = ifTrueColor then
                    Dest.Rgb[X, Y] := Source.Rgb[NewX,NewY]
                else
                    Dest.PaletteIndex[X, Y] := Source.PaletteIndex[NewX,NewY];
            end
            else
                Dest.Rgb[X, Y] := CWhiteRgb;

        end;
    end;

end;

{--------------------------------------------------------------------------}

{ maximum channel value used with HSL conversions }
const

CMaxRGB = 255;

{ (Hue, Saturation, Luminosity) to/from (red, green, blue) conversions.
  Adapted from ImageMagick Gems.C }
procedure HSLToRGB(       Hue        : Double;
                    const Saturation : Double;
                    const Luminosity : Double;
                    var   Rgb        : TRgb );
var
    B,G,R,v,x,y,z : Double;
    Whole         : LongInt;
    Fraction      : Double;
begin
    if Luminosity <= 0.5 then
        v := Luminosity*(1.0+Saturation)
    else
        v := Luminosity+Saturation-Luminosity*Saturation;

    if (Saturation = 0.0) or (Hue = -1.0) then
    begin
        Rgb.Red   := Trunc((Luminosity*CMaxRGB)+0.5);
        Rgb.Green := Trunc((Luminosity*CMaxRGB)+0.5);
        Rgb.Blue  := Trunc((Luminosity*CMaxRGB)+0.5);
        Exit;
    end;

    Hue      := Hue*6.0;
    Whole    := Trunc(Hue);
    Fraction := Hue - Whole;
    y   := 2*Luminosity-v;
    x   := y + (v-y)*Fraction;
    z   := v-(v-y)*Fraction;

    case Whole of
        0:
        begin
            R:=v; G:=x; B:=y;
        end;

        1:
        begin
            R:=z; G:=v; B:=y;
        end;

        2:
        begin
            R:=y; G:=v; B:=x;
        end;

        3:
        begin
            R:=y; G:=z; B:=v;
        end;

        4:
        begin
            R:=x; G:=y; B:=v;
        end;

        5:
        begin
            R:=v; G:=y; B:=z;
        end;

        else
        begin
            R:=v; G:=x; B:=y;
        end;

    end; { case }

    Rgb.Red   := Trunc((R*CMaxRGB)+0.5);
    Rgb.Green := Trunc((G*CMaxRGB)+0.5);
    Rgb.Blue  := Trunc((B*CMaxRGB)+0.5);
end;

{--------------------------------------------------------------------------}

procedure RGBToHSL( const Rgb        : TRgb;
                    var   Hue        : Double;
                    var   Saturation : Double;
                    var   Luminosity : Double );
var
    B, delta, G, max, min, R : Double;
begin
    R   := Rgb.Red/255.0;
    G   := Rgb.Green/255.0;
    B   := Rgb.Blue/255.0;
    max := MaxFloat(R,MaxFloat(G,B));
    min := MinFloat(R,MinFloat(G,B));

    Hue        := -1.0;
    Saturation := 0.0;
    Luminosity := (Min+Max)/2.0;
    Delta      := Max-Min;
    if (Delta = 0.0) then
        Exit;

    Saturation := Delta;
    if Luminosity <= 0.5 then
        Saturation := Saturation / (Min+Max)
    else
        Saturation := Saturation / (2.0-max-min);

    if R = max then
    begin
        if G = min then
            Hue := 5.0+(max-B)/delta
        else
            Hue := (1.0-(max-G)/delta);
    end
    else
    begin
        if (G = max) then
        begin
            if B = min then
                Hue := 1.0+(max-R)/delta
            else
                Hue := 3.0-(max-B)/delta;
        end
        else
        begin
            if R = min then
                Hue := 3.0+(max-G)/delta
            else
                Hue := 5.0-(max-R)/delta;
        end;
    end;

    Hue := Hue / 6.0;
end;

{--------------------------------------------------------------------------}

constructor TContrastTransform.Create;
begin
    inherited Create;

    FIncrease := True;
end;

{--------------------------------------------------------------------------}

procedure TContrastTransform.ApplyOnDest( const Source : TDibGraphic;
                                          const Dest   : TDibGraphic );
var
    X            : LongInt;
    Y            : LongInt;
    SourceWidth  : LongInt;
    SourceHeight : LongInt;
    Rgb          : TRgb;
    Hue          : Double;
    Saturation   : Double;
    Luminosity   : Double;
    Theta        : Double;
    Sign         : Integer;

begin
    FLastPercent := -1;
    FLastPercent := DoProgress(Self, FOnProgress, 0, 0, 100, FLastPercent);

    SourceWidth  := Source.Width;
    SourceHeight := Source.Height;

    Dest.NewImage( SourceWidth, SourceHeight,
                   ifTrueColor, nil,
                   Source.XDotsPerInch, Source.YDotsPerInch );

    if FIncrease then
        Sign := 1
    else
        Sign := -1;

    for Y := 0 to (SourceHeight-1) do
    begin
        FLastPercent := DoProgress(Self, FOnProgress, Y, 0, SourceHeight-1, FLastPercent);

        for X := 0 to (SourceWidth-1) do
        begin
            Rgb := Source.Rgb[X, Y];

            RGBToHSL(Rgb, Hue, Saturation, Luminosity);

            Theta      := (Luminosity-0.5)*System.Pi;

            Luminosity := Luminosity +
                          (((((Sin(Theta)+1.0))*0.5)-Luminosity)*Sign)*0.5;

            if (Luminosity > 1.0) then
                Luminosity := 1.0
            else if (Luminosity < 0) then
                Luminosity := 0.0;

            HSLToRGB( Hue, Saturation, Luminosity, Rgb );

            Dest.Rgb[X, Y] := Rgb;
        end;
    end;
    
    FLastPercent := DoProgress(Self, FOnProgress, 100, 0, 100, FLastPercent);
end;

{--------------------------------------------------------------------------}

constructor TBrightnessTransform.Create;
begin
    inherited Create;

    FPercent := 5.0;
end;

{--------------------------------------------------------------------------}

procedure TBrightnessTransform.SetPercent( const InPercent : Double );
begin
    FPercent := BoundFloat(InPercent, -100, 100);
end;

{--------------------------------------------------------------------------}

procedure TBrightnessTransform.ApplyOnDest( const Source : TDibGraphic;
                                          const Dest   : TDibGraphic );
var
    X            : LongInt;
    Y            : LongInt;
    SourceWidth  : LongInt;
    SourceHeight : LongInt;
    Rgb          : TRgb;
    Hue          : Double;
    Saturation   : Double;
    Luminosity   : Double;

begin
    FLastPercent := -1;
    FLastPercent := DoProgress(Self, FOnProgress, 0, 0, 100, FLastPercent);

    SourceWidth  := Source.Width;
    SourceHeight := Source.Height;

    Dest.NewImage( SourceWidth, SourceHeight,
                   ifTrueColor, nil,
                   Source.XDotsPerInch, Source.YDotsPerInch );

    for Y := 0 to (SourceHeight-1) do
    begin
        FLastPercent := DoProgress(Self, FOnProgress, Y, 0, SourceHeight-1, FLastPercent);

        for X := 0 to (SourceWidth-1) do
        begin
            Rgb := TRgb(Source.Rgb[X, Y]);

            RGBToHSL(Rgb, Hue, Saturation, Luminosity);

            Luminosity := Luminosity + FPercent/100.0;

            if (Luminosity > 1.0) then
                Luminosity := 1.0
            else if (Luminosity < 0) then
                Luminosity := 0.0;

            HSLToRGB( Hue, Saturation, Luminosity, Rgb );

            Dest.Rgb[X, Y] := Rgb;
        end;
    end;

    FLastPercent := DoProgress(Self, FOnProgress, 100, 0, 100, FLastPercent);
end;

{--------------------------------------------------------------------------}

constructor TGammaTransform.Create;
begin
    inherited Create;

    FGamma := 1.0;
end;

{--------------------------------------------------------------------------}

procedure TGammaTransform.SetGamma( const InGamma : Double );
begin
    FGamma := BoundFloat(InGamma, 0.1, 7.0);
end;

{--------------------------------------------------------------------------}

procedure TGammaTransform.ApplyOnDest( const Source : TDibGraphic;
                                       const Dest   : TDibGraphic );
var
    X            : LongInt;
    Y            : LongInt;
    SourceWidth  : LongInt;
    SourceHeight : LongInt;
    Rgb          : TRgb;

    GammaTable   : array[0..255] of Byte;

    procedure FillGammaTable;
    var
        I : Integer;
    begin
        GammaTable[0] := 0;
        for I := 1 to 255 do
        begin
            GammaTable[I] := Round(255 * Power(I/255, 1/FGamma));
        end;
    end;

begin
    FLastPercent := -1;
    FLastPercent := DoProgress(Self, FOnProgress, 0, 0, 100, FLastPercent);

    SourceWidth  := Source.Width;
    SourceHeight := Source.Height;

    Dest.NewImage( SourceWidth, SourceHeight,
                   ifTrueColor, nil,
                   Source.XDotsPerInch, Source.YDotsPerInch );

    FillGammaTable;

    for Y := 0 to (SourceHeight-1) do
    begin
        FLastPercent := DoProgress(Self, FOnProgress, Y, 0, SourceHeight-1, FLastPercent);

        for X := 0 to (SourceWidth-1) do
        begin
            Rgb := Source.Rgb[X, Y];

            Rgb.Red   := GammaTable[Rgb.Red];
            Rgb.Green := GammaTable[Rgb.Green];
            Rgb.Blue  := GammaTable[Rgb.Blue];

            Dest.Rgb[X, Y] := Rgb;
        end;
    end;

    FLastPercent := DoProgress(Self, FOnProgress, 100, 0, 100, FLastPercent);
end;

{--------------------------------------------------------------------------}

constructor TConvertToGrayTransform.Create;
begin
    inherited Create;

    FRedFactor   := 0.299;
    FGreenFactor := 0.587;
    FBlueFactor  := 0.114;

    FGrayFormat  := ifGray256;
end;

{--------------------------------------------------------------------------}

procedure TConvertToGrayTransform.SetRedFactor(const Factor : Double);
begin
    FRedFactor := BoundFloat(Factor, 0, 1);
end;

{--------------------------------------------------------------------------}

procedure TConvertToGrayTransform.SetGreenFactor(const Factor : Double);
begin
    FGreenFactor := BoundFloat(Factor, 0, 1);
end;

{--------------------------------------------------------------------------}

procedure TConvertToGrayTransform.SetBlueFactor(const Factor : Double);
begin
    FBlueFactor := BoundFloat(Factor, 0, 1);
end;

{--------------------------------------------------------------------------}

procedure TConvertToGrayTransform.SetGrayFormat(
                              const Format : TImageFormat);
begin
    if not (Format in [ifGray16, ifGray256]) then
        raise EEnvisionError.Create(msgNotAGraYScaleFormat);

    FGrayFormat := Format;
end;

{--------------------------------------------------------------------------}

procedure TConvertToGrayTransform.ApplyOnDest(
                       const Source : TDibGraphic;
                       const Dest   : TDibGraphic );
var
    X            : LongInt;
    Y            : LongInt;
    SourceWidth  : LongInt;
    SourceHeight : LongInt;
    Rgb          : TRgb;
    ChannelValue : LongInt;

    iRedFactor   : LongInt;
    iGreenFactor : LongInt;
    iBlueFactor  : LongInt;

begin
    FLastPercent := -1;
    FLastPercent := DoProgress(Self, FOnProgress, 0, 0, 100, FLastPercent);

    SourceWidth  := Source.Width;
    SourceHeight := Source.Height;

    Dest.NewImage( SourceWidth, SourceHeight,
                   FGrayFormat, nil,
                   Source.XDotsPerInch, Source.YDotsPerInch );

    { use Integer's to avoid floating point math }
    iRedFactor   := Round(FRedFactor * 1000);
    iGreenFactor := Round(FGreenFactor * 1000);
    iBlueFactor  := Round(FBlueFactor * 1000);

    for Y := 0 to (SourceHeight-1) do
    begin
        FLastPercent := DoProgress(Self, FOnProgress, Y, 0, SourceHeight-1, FLastPercent);

        for X := 0 to (SourceWidth-1) do
        begin
            Rgb := TRgb(Source.Rgb[X, Y]);

            ChannelValue := (Rgb.Red*iRedFactor +
                             Rgb.Green*iGreenFactor +
                             Rgb.Blue*iBlueFactor) div 1000;

            if ChannelValue > 255 then
                ChannelValue := 255;

            Rgb.Red   := ChannelValue;
            Rgb.Green := ChannelValue;
            Rgb.Blue  := ChannelValue;

            Dest.Rgb[X, Y] := Rgb;
        end;
    end;

    FLastPercent := DoProgress(Self, FOnProgress, 100, 0, 100, FLastPercent);
end;

{--------------------------------------------------------------------------}

type

TInterpolationFilterFunc = function( T : Single ) : Single;

{--------------------------------------------------------------------------}

const CTriangleFilterRadius = 1.0;

{ Triangle Filter
  also known as, "Linear" or "Bilinear" Filter }
function TriangleFilter(Value: Single): Single;
begin
    if (Value < 0.0) then
        Value := -Value;

    if (Value < 1.0) then
        Result := 1.0 - Value
    else
        Result := 0.0;
end;

{--------------------------------------------------------------------------}

const CHermiteFilterRadius = 1.0;

function HermiteFilter(Value: Single): Single;
begin
    { f(t) = 2|t|^3 - 3|t|^2 + 1, -1 <= t <= 1 }
    if (Value < 0.0) then
        Value := -Value;

    if (Value < 1.0) then
        Result := (2.0 * Value - 3.0) * Sqr(Value) + 1.0
    else
        Result := 0.0;
end;

{--------------------------------------------------------------------------}

const CBellFilterRadius = 1.5;

function BellFilter(Value: Single): Single;
begin
    if (Value < 0.0) then
        Value := -Value;

    if (Value < 0.5) then
        Result := 0.75 - Sqr(Value)
    else if (Value < 1.5) then
    begin
        Value := Value - 1.5;
        Result := 0.5 * Sqr(Value);
    end
    else
        Result := 0.0;
end;

{--------------------------------------------------------------------------}

const CBSplineFilterRadius = 2.0;

function BSplineFilter(Value: Single): Single;
var
    tt : Single;
begin
    if (Value < 0.0) then
        Value := -Value;

    if (Value < 1.0) then
    begin
        tt := Sqr(Value);
        Result := 0.5*tt*Value - tt + 2.0 / 3.0;
    end
    else if (Value < 2.0) then
    begin
        Value := 2.0 - Value;
        Result := 1.0/6.0 * Sqr(Value) * Value;
    end
    else
        Result := 0.0;
end;

{--------------------------------------------------------------------------}

const CLanczos3FilterRadius = 3.0;

function Lanczos3Filter(Value: Single): Single;

    function SinC(Value: Single): Single;
    begin
        if (Value <> 0.0) then
        begin
            Value := Value * Pi;
            Result := sin(Value) / Value
        end
        else
            Result := 1.0;
    end;

begin
    if (Value < 0.0) then
        Value := -Value;

    if (Value < 3.0) then
        Result := SinC(Value) * SinC(Value / 3.0)
    else
        Result := 0.0;
end;

{--------------------------------------------------------------------------}

const CMitchellFilterRadius = 2.0;

function MitchellFilter(Value: Single): Single;
const
    B		= (1.0 / 3.0);
    C		= (1.0 / 3.0);
var
    tt 	: Single;
begin
    if (Value < 0.0) then
        Value := -Value;

    tt := Sqr(Value);
    if (Value < 1.0) then
    begin
        Value := (((12.0 - 9.0 * B - 6.0 * C) * (Value * tt))
                 + ((-18.0 + 12.0 * B + 6.0 * C) * tt)
                 + (6.0 - 2 * B));
        Result := Value / 6.0;
    end
    else if (Value < 2.0) then
    begin
        Value := (((-1.0 * B - 6.0 * C) * (Value * tt))
                 + ((6.0 * B + 30.0 * C) * tt)
                 + ((-12.0 * B - 48.0 * C) * Value)
                 + (8.0 * B + 24 * C));
        Result := Value / 6.0;
    end
    else
        Result := 0.0;
end;

{--------------------------------------------------------------------------}

const

CFilters : array[TInterpolationFilter] of record
    Filter : TInterpolationFilterFunc;
    Radius : Single;
end = (
        (Filter: TriangleFilter; Radius: CTriangleFilterRadius),
        (Filter: HermiteFilter;	 Radius: CHermiteFilterRadius),
        (Filter: BellFilter;	 Radius: CBellFilterRadius),
        (Filter: BSplineFilter;	 Radius: CBSplineFilterRadius),
        (Filter: Lanczos3Filter; Radius: CLanczos3FilterRadius),
        (Filter: MitchellFilter; Radius: CMitchellFilterRadius)
      );

type

{ Contributor for a Pixel }
TContributor = record
    Pixel  : Integer;		// Source Pixel
    Weight : Single;		// Pixel Weight
end;

TContributorList = array[0..0] of TContributor;
PContributorList = ^TContributorList;

{ List of source Pixels contributing to a destination Pixel }
TCList = record
    N : Integer;
    P : PContributorList;
end;

TCListList = array[0..0] of TCList;
PCListList = ^TCListList;

TFloatRgb = packed record
    R, G, B : Single;
end;

{ Physical bitmap Pixel }
TColorRGB = packed record
    R, G, B	: Byte;
end;
PColorRGB = ^TColorRGB;

{ Physical bitmap scanline (row) }
TRGBList = packed array[0..0] of TColorRGB;
PRGBList = ^TRGBList;

{$IFOPT R+}
  {$DEFINE R_PLUS}
  {$R-}
{$ENDIF}

procedure Interpolate(
                   const Src, Dst   : TDibGraphic;
                   const Filter     : TInterpolationFilterFunc;
                   const FWidth     : Single;
                   const Transform  : TImageTransform );
var
    XScale, YScale        : Single;   { Zoom scale factors }
    I, J, K               : Integer;  { Loop variables }
    Center		  : Single;   { Filter calculation variables }
    Width, FScale, Weight : Single;   { Filter calculation variables }
    Left, Right		  : Integer;  { Filter calculation variables }
    N			  : Integer;  { Pixel number }
    Work		  : TDibGraphic;
    Contrib		  : PCListList;
    Rgb			  : TFloatRgb;
    Color		  : TColorRGB;
    SourceLine,
    DestLine		  : PRGBList;
    SourcePixel,
    DestPixel		  : PColorRGB;
    Delta,
    DestDelta		  : Integer;
    SrcWidth,
    SrcHeight,
    DstWidth,
    DstHeight		  : Integer;

    ProgressMax           : Integer;
    ProgressOffset        : Integer;

    function EnvisionRgbToRgb(Rgb: EnDiGrph.TRgb): TColorRGB; register;
    begin
        Result.R := Rgb.Red;
        Result.G := Rgb.Green;
        Result.B := Rgb.Blue;
    end;

    function RgbToEnvisionRgb(Color: TColorRGB): EnDiGrph.TRgb; register;
    begin
        Result.Red   := Color.R;
        Result.Green := Color.G;
        Result.Blue  := Color.B;
    end;

begin
    DstWidth  := Dst.Width;
    DstHeight := Dst.Height;
    SrcWidth  := Src.Width;
    SrcHeight := Src.Height;

    if (SrcWidth < 1) or (SrcHeight < 1) then
        raise EEnvisionError.Create(msgSourceTooSmall);

    if (DstWidth <= 1) or (DstHeight <= 1) then
        raise EEnvisionError.Create(msgDestTooSmall);

    { Create intermediate image to hold horizontal zoom }
    Work := TDibGraphic.Create;
    try
        Work.NewImage( DstWidth, SrcHeight, ifTrueColor, nil, 0, 0);

        { XScale := DstWidth / SrcWidth;
          YScale := DstHeight / SrcHeight;
          Improvement suggested by David Ullrich: }
        if (SrcWidth = 1) then
            XScale:= DstWidth / SrcWidth
        else
            XScale:= (DstWidth - 1) / (SrcWidth - 1);

        if (SrcHeight = 1) then
            YScale:= DstHeight / SrcHeight
        else
            YScale:= (DstHeight - 1) / (SrcHeight - 1);

        { Pre-calculate Filter contributions for a row }
        GetMem(Contrib, DstWidth* sizeof(TCList));

        { Horizontal sub-sampling
          Scales from bigger to smaller Width }
        if (XScale < 1.0) then
        begin
            Width  := FWidth / XScale;
            FScale := 1.0 / XScale;
            ProgressMax := (DstWidth-1)*5; { 0-20% }
            for I := 0 to DstWidth-1 do
            begin
                Transform.FLastPercent := DoProgress( Transform, Transform.FOnProgress, I, 0,
                                                      ProgressMax, Transform.FLastPercent );

                Contrib^[I].N := 0;
                GetMem(Contrib^[I].p, trunc(Width * 2.0 + 1) * sizeof(TContributor));
                Center := I / XScale;

                { Original code:
                  Left := Ceiling(Center - Width);
                  Right := Floor(Center + Width); }
                Left  := Floor(Center - Width);
                Right := Ceiling(Center + Width);
                for J := Left to Right do
                begin
                    Weight := Filter((Center - J) / FScale) / FScale;
                    if (Weight = 0.0) then
                        continue;
                    if (J < 0) then
                        N := -J
                    else if (J >= SrcWidth) then
                        N := SrcWidth - J + SrcWidth - 1
                    else
                        N := J;
                    K := Contrib^[I].N;
                    Contrib^[I].N := Contrib^[I].N + 1;
                    if (N < 0) or (N >= SrcWidth) then
                        Weight := 0.0; { Flag that cell should not be used }
                    Contrib^[I].p^[K].Pixel := N;
                    Contrib^[I].p^[K].Weight := Weight;
                end;
            end;
        end
        else
        begin
            { Horizontal super-sampling
              Scales from smaller to bigger Width }
            ProgressMax := (DstWidth-1)*5;
            for I := 0 to DstWidth-1 do
            begin
                Transform.FLastPercent := DoProgress( Transform, Transform.FOnProgress, I, 0,
                                                      ProgressMax, Transform.FLastPercent );

                Contrib^[I].N := 0;
                GetMem(Contrib^[I].p, trunc(FWidth * 2.0 + 1) * sizeof(TContributor));
                Center := I / XScale;
                { Original code:
                  Left := Ceiling(Center - FWidth);
                  Right := Floor(Center + FWidth); }
                Left  := Floor(Center - FWidth);
                Right := Ceiling(Center + FWidth);
                for J := Left to Right do
                begin
                    Weight := Filter(Center - J);
                    if (Weight = 0.0) then
                        continue;
                    if (J < 0) then
                        N := -J
                    else if (J >= SrcWidth) then
                        N := SrcWidth - J + SrcWidth - 1
                    else
                        N := J;
                    K := Contrib^[I].N;
                    if (N < 0) or (N >= SrcWidth) then
                        Weight := 0.0; { Flag that cell should not be used }

                    Contrib^[I].N := Contrib^[I].N + 1;
                    Contrib^[I].p^[K].Pixel := N;
                    Contrib^[I].p^[K].Weight := Weight;
                end;
            end;
        end;

        { Apply Filter to sample horizontally from Src to Work }

        ProgressMax := (SrcHeight-1)*5; { 20 - 40% }
        ProgressOffset := SrcHeight;
        for K := 0 to SrcHeight-1 do
        begin
            Transform.FLastPercent := DoProgress( Transform, Transform.FOnProgress,
                                                  K + ProgressOffset, 0, ProgressMax,
                                                  Transform.FLastPercent );

            if Src.ImageFormat = ifTrueColor then
                SourceLine := PRGBList(Src.ScanLine[K])
            else
                SourceLine := nil; { prevent compiler warning }

            DestPixel := PColorRGB(Work.ScanLine[K]);
            for I := 0 to DstWidth-1 do
            begin
                Rgb.R := 0.0;
                Rgb.G := 0.0;
                Rgb.B := 0.0;
                for J := 0 to Contrib^[I].N-1 do
                begin
                    Weight := Contrib^[I].p^[J].Weight;
                    if (Weight = 0.0) then
                        continue;

                    if Src.ImageFormat = ifTrueColor then
                        Color := SourceLine^[Contrib^[I].p^[J].Pixel]
                    else
                        Color := EnvisionRgbToRgb(Src.Rgb[Contrib^[I].p^[J].Pixel, K]);

                    Rgb.R := Rgb.R + Color.R * Weight;
                    Rgb.G := Rgb.G + Color.G * Weight;
                    Rgb.B := Rgb.B + Color.B * Weight;
                end;

                if (Rgb.R > 255.0) then
                    Color.R := 255
                else if (Rgb.R < 0.0) then
                    Color.R := 0
                else
                    Color.R := round(Rgb.R);

                if (Rgb.G > 255.0) then
                    Color.G := 255
                else if (Rgb.G < 0.0) then
                    Color.G := 0
                else
                    Color.G := round(Rgb.G);

                if (Rgb.B > 255.0) then
                    Color.B := 255
                else if (Rgb.B < 0.0) then
                    Color.B := 0
                else
                    Color.B := round(Rgb.B);

                { Set new Pixel value }
                DestPixel^ := Color;
                { Move on to next column }
                Inc(DestPixel);
            end;
        end;

        { Free the memory allocated for horizontal Filter Weights }
        for I := 0 to DstWidth-1 do
            FreeMem(Contrib^[I].p);

        FreeMem(Contrib);

        { Pre-calculate Filter contributions for a column }

        GetMem(Contrib, DstHeight* sizeof(TCList));
        { Vertical sub-sampling
          Scales from bigger to smaller height }
        if (YScale < 1.0) then
        begin
            Width  := FWidth / YScale;
            FScale := 1.0 / YScale;

            ProgressMax := (DstHeight-1)*5; { 40 - 60% }
            ProgressOffset := DstHeight*2;
            for I := 0 to DstHeight-1 do
            begin
                Transform.FLastPercent := DoProgress( Transform, Transform.FOnProgress,
                                                      I + ProgressOffset, 0, ProgressMax,
                                                      Transform.FLastPercent );

                Contrib^[I].N := 0;
                GetMem(Contrib^[I].p, trunc(Width * 2.0 + 1) * sizeof(TContributor));
                Center := I / YScale;
                { Original code:
                  Left := Ceiling(Center - Width);
                  Right := Floor(Center + Width); }
                Left  := Floor(Center - Width);
                Right := Ceiling(Center + Width);
                for J := Left to Right do
                begin
                    Weight := Filter((Center - J) / FScale) / FScale;
                    if (Weight = 0.0) then
                        continue;
                    if (J < 0) then
                        N := -J
                    else if (J >= SrcHeight) then
                        N := SrcHeight - J + SrcHeight - 1
                    else
                        N := J;

                    K := Contrib^[I].N;
                    Contrib^[I].N := Contrib^[I].N + 1;
                    if (N < 0) or (N >= SrcHeight) then
                        Weight := 0.0; { Flag that cell should not be used }
                    Contrib^[I].p^[K].Pixel := N;
                    Contrib^[I].p^[K].Weight := Weight;
                end;
            end
        end
        else
        begin
            { Vertical super-sampling
             Scales from smaller to bigger height }
            ProgressMax    := (DstHeight-1)*5; { 40-60% }
            ProgressOffset := DstHeight*2;
            for I := 0 to DstHeight-1 do
            begin
                Transform.FLastPercent := DoProgress( Transform, Transform.FOnProgress,
                                                      I + ProgressOffset, 0, ProgressMax,
                                                      Transform.FLastPercent );

                Contrib^[I].N := 0;
                GetMem(Contrib^[I].p, trunc(FWidth * 2.0 + 1) * sizeof(TContributor));
                Center := I / YScale;
                { Original code:
                  Left := Ceiling(Center - FWidth);
                  Right := Floor(Center + FWidth); }
                Left  := Floor(Center - FWidth);
                Right := Ceiling(Center + FWidth);
                for J := Left to Right do
                begin
                    Weight := Filter(Center - J);
                    if (Weight = 0.0) then
                        continue;
                    if (J < 0) then
                        N := -J
                    else if (J >= SrcHeight) then
                        N := SrcHeight - J + SrcHeight - 1
                    else
                        N := J;

                    K := Contrib^[I].N;
                    Contrib^[I].N := Contrib^[I].N + 1;
                    if (N < 0) or (N >= SrcHeight) then
                        Weight := 0.0; { Flag that cell should not be used }
                    Contrib^[I].p^[K].Pixel := N;
                    Contrib^[I].p^[K].Weight := Weight;
                end;
            end;
        end;

        { Apply Filter to sample vertically from Work to Dst }
        SourceLine := PRGBList(Work.ScanLine[0]);
        Delta      := Integer(Work.ScanLine[1]) - Integer(SourceLine);

        if Dst.ImageFormat = ifTrueColor then
        begin
            DestLine := PRGBList(Dst.ScanLine[0]);
            DestDelta := Integer(Dst.ScanLine[1]) - Integer(DestLine);
        end;

        ProgressMax := Trunc((DstWidth-1)*2.5); { 60 - 100% }
        ProgressOffset := Trunc(DstWidth*1.5);
        for K := 0 to DstWidth-1 do
        begin
            Transform.FLastPercent := DoProgress( Transform, Transform.FOnProgress,
                                                  K + ProgressOffset, 0, ProgressMax,
                                                  Transform.FLastPercent );

            if Dst.ImageFormat = ifTrueColor then
                DestPixel := pointer(DestLine)
            else
                DestPixel := nil; { prevent compiler warning }

            for I := 0 to DstHeight-1 do
            begin
                Rgb.R := 0;
                Rgb.G := 0;
                Rgb.B := 0;
                for J := 0 to Contrib^[I].N-1 do
                begin
                    Weight := Contrib^[I].p^[J].Weight;
                    if (Weight = 0.0) then
                        continue;

                    Color := PColorRGB(Integer(SourceLine)+Contrib^[I].p^[J].Pixel*Delta)^;

                    Rgb.R := Rgb.R + Color.R * Weight;
                    Rgb.G := Rgb.G + Color.G * Weight;
                    Rgb.B := Rgb.B + Color.B * Weight;
                end;

                if (Rgb.R > 255.0) then
                    Color.R := 255
                else if (Rgb.R < 0.0) then
                    Color.R := 0
                else
                    Color.R := round(Rgb.R);

                if (Rgb.G > 255.0) then
                    Color.G := 255
                else if (Rgb.G < 0.0) then
                    Color.G := 0
                else
                    Color.G := round(Rgb.G);

                if (Rgb.B > 255.0) then
                    Color.B := 255
                else if (Rgb.B < 0.0) then
                    Color.B := 0
                else
                    Color.B := round(Rgb.B);

                if Dst.ImageFormat = ifTrueColor then
                begin
                    DestPixel^ := Color;
                    Inc(Integer(DestPixel), DestDelta);
                end
                else
                    Dst.Rgb[K, I] := RgbToEnvisionRgb(Color);
            end;
            Inc(SourceLine, 1);
            if Dst.ImageFormat = ifTrueColor then
                Inc(DestLine, 1);
        end;

        { Free the memory allocated for vertical Filter Weights }
        for I := 0 to DstHeight-1 do
            FreeMem(Contrib^[I].p);

        FreeMem(Contrib);

    finally
      Work.Free;
    end;
end;

{$IFDEF R_PLUS}
  {$UNDEF R_PLUS}
  {$R+}
{$ENDIF}


constructor TResizeTransform.Create;
begin
    inherited Create;

    FWidth              := 300;
    FHeight             := 200;

    FInterpolated       := False;
    FFilter             := ifTriangle;

    FOverrideDestFormat := False;
    FDestFormat         := ifTrueColor;
end;

{--------------------------------------------------------------------------}

procedure TResizeTransform.ApplyOnDest( const Source : TDibGraphic;
                                        const Dest   : TDibGraphic );
var
    pPoint        : Windows.PPoint;
    Radius        : Single;
    Filter        : TInterpolationFilterFunc;
    NewFormat     : TImageFormat;
    NewPalettePtr : PMaxLogPalette;

begin
    FLastPercent := -1;
    FLastPercent := DoProgress(Self, FOnProgress, 0, 0, 100, FLastPercent);

    if FOverrideDestFormat then
        NewFormat := FDestFormat
    else
        NewFormat := Source.ImageFormat;

    { only re-use the source palette on 16 and 256 colors destinations }
    if NewFormat in [ifColor16, ifColor256] then
        NewPalettePtr := Source.PalettePtr
    else
        NewPalettePtr := nil;

    Dest.NewImage( FWidth, FHeight, NewFormat, NewPalettePtr,
                   Source.XDotsPerInch, Source.YDotsPerInch);

    if FInterpolated then
    begin
        Filter := CFilters[FFilter].Filter;
        Radius := CFilters[FFilter].Radius;

        Interpolate(Source, Dest, Filter, Radius, Self);

        DoProgress(Self, FOnProgress, 100, 0, 100, FLastPercent);
    end
    else
    begin
        FLastPercent := DoProgress(Self, FOnProgress, 50, 0, 100, FLastPercent);

        { using HALFTONE stretch mode, the stretch quality is much better.
          The API help on SetStretchBltMode specifies that SetBrushOrgEx
          must be called afterwords. }
        SetStretchBltMode( Dest.DC, Windows.HALFTONE );
        pPoint := nil;
        { Delphi 2 requires a var parameter }
        SetBrushOrgEx( Dest.DC, 0, 0, pPoint );

        StretchDiBits( Dest.DC, 0, 0, FWidth, FHeight,
                       0, 0, Source.Width, Source.Height,
                       Source.Bits, Windows.PBitmapInfo(@Source.BitmapInfo)^,
                       DIB_RGB_COLORS, SRCCOPY);

        FLastPercent := DoProgress(Self, FOnProgress, 100, 0, 100, FLastPercent);
    end;
end;

{--------------------------------------------------------------------------}

procedure FSDither( const Transform   : TImageTransform;
                    const Source      : TDibGraphic;
                    const Dest        : TDibGraphic;
                    const Quantized   : Boolean );
var
    RErr1 : TpIntegerArray; { red errors }
    RErr2 : TpIntegerArray;
    GErr1 : TpIntegerArray; { green errors  }
    GErr2 : TpIntegerArray;
    BErr1 : TpIntegerArray; { blue errors }
    BErr2 : TpIntegerArray;

    procedure AllocateErrors;
    var
        Size : LongInt;
    begin
        Size := Source.Width*SizeOf(Integer);
        GetMem(RErr1, Size);
        GetMem(RErr2, Size);
        GetMem(GErr1, Size);
        GetMem(GErr2, Size);
        GetMem(BErr1, Size);
        GetMem(BErr2, Size);

        FillChar(RErr1^, Size, 0);
        FillChar(RErr2^, Size, 0);
        FillChar(GErr1^, Size, 0);
        FillChar(GErr2^, Size, 0);
        FillChar(BErr1^, Size, 0);
        FillChar(BErr2^, Size, 0);
    end;

    procedure ReleaseErrors;
    var
        Size : LongInt;
    begin
        Size := Source.Width*SizeOf(Integer);
        FreeMem(RErr1, Size);
        FreeMem(RErr2, Size);
        FreeMem(GErr1, Size);
        FreeMem(GErr2, Size);
        FreeMem(BErr1, Size);
        FreeMem(BErr2, Size);
    end;

    procedure DitherScanLine( const LineNo : LongInt );
    var
        X     : LongInt;
        Rgb   : TRgb;
        RErr  : Integer;
        GErr  : Integer;
        BErr  : Integer;
    begin
        for X := 0 to (Source.Width-1) do
        begin
            Rgb := Source.Rgb[X, LineNo];

            RErr1^[X] := BoundInteger(rerr2^[X] + Rgb.Red, 0, 255);
            rerr2^[X] := 0;
            gerr1^[X] := BoundInteger(gerr2^[X] + Rgb.Green, 0, 255);
            gerr2^[X] := 0;
            berr1^[X] := BoundInteger(berr2^[X] + Rgb.Blue, 0, 255);
            berr2^[X] := 0;
        end;

        Rgb.Red   := RErr1^[0];
        Rgb.Green := GErr1^[0];
        Rgb.Blue  := BErr1^[0];
        Dest.Rgb[0, LineNo] := Rgb;

        for X := 1 to (Source.Width-2) do
        begin
            Rgb.Red   := RErr1^[X];
            Rgb.Green := GErr1^[X];
            Rgb.Blue  := BErr1^[X];

            { Using the Rgb property will perform the Color matching }
            Dest.Rgb[X, LineNo] := Rgb;

            { get the actual Rgb value after Color matching to compute
              the error }
            Rgb := Dest.Rgb[X, LineNo];

            { compute errors }
            RErr := RErr1^[X];
            RErr := RErr - Rgb.Red;

            GErr := GErr1^[X];
            GErr := GErr - Rgb.Green;

            BErr := BErr1^[X];
            BErr := BErr - Rgb.Blue;

            RErr1^[X+1] := BoundInteger((RErr1^[X+1] + ((RErr * 7)) div 16), 0, 255);
            RErr2^[X-1] := BoundInteger((RErr2^[X-1] + ((RErr * 3)) div 16), 0, 255);
            RErr2^[X]   := BoundInteger((RErr2^[X]   + ((RErr * 5)) div 16), 0, 255);
            RErr2^[X+1] := BoundInteger((RErr2^[X+1] + ((RErr * 1)) div 16), 0, 255);

            GErr1^[X+1] := BoundInteger((GErr1^[X+1] + ((GErr * 7)) div 16), 0, 255);
            GErr2^[X-1] := BoundInteger((GErr2^[X-1] + ((GErr * 3)) div 16), 0, 255);
            GErr2^[X]   := BoundInteger((GErr2^[X]   + ((GErr * 5)) div 16), 0, 255);
            GErr2^[X+1] := BoundInteger((GErr2^[X+1] + ((GErr * 1)) div 16), 0, 255);

            BErr1^[X+1] := BoundInteger((BErr1^[X+1] + ((BErr * 7)) div 16), 0, 255);
            BErr2^[X-1] := BoundInteger((BErr2^[X-1] + ((BErr * 3)) div 16), 0, 255);
            BErr2^[X]   := BoundInteger((BErr2^[X]   + ((BErr * 5)) div 16), 0, 255);
            BErr2^[X+1] := BoundInteger((BErr2^[X+1] + ((BErr * 1)) div 16), 0, 255);
        end;

        Rgb.Red   := RErr1^[Source.Width-1];
        Rgb.Green := GErr1^[Source.Width-1];
        Rgb.Blue  := BErr1^[Source.Width-1];
        Dest.Rgb[Source.Width-1, LineNo] := Rgb;

    end;

var
    Y              : LongInt;
    HeightMinusOne : LongInt;
begin
    AllocateErrors;
    try
        HeightMinusOne := Source.Height - 1;
        for Y := 0 to HeightMinusOne do
        begin
            if Quantized then
                Transform.FLastPercent := DoProgress( Transform, Transform.FOnProgress,
                            Y+(HeightMinusOne-Y) div 2, 0, HeightMinusOne, Transform.FLastPercent)
            else
                Transform.FLastPercent := DoProgress( Transform, Transform.FOnProgress,
                            Y, 0, HeightMinusOne, Transform.FLastPercent);

            DitherScanLine(Y);
        end;
    finally
        ReleaseErrors;
    end;
end;

{--------------------------------------------------------------------------}

constructor TImageFormatTransform.Create;
begin
    inherited Create;

    FImageFormat := ifTrueColor;
    FDither      := True;
    FQuantize    := True;

    FillChar(FPalette, Sizeof(FPalette), 0);
end;

{--------------------------------------------------------------------------}

procedure TImageFormatTransform.QuantizeProgress(
                                     const Sender          : TObject;
                                     const PercentProgress : Byte );
begin
    if Dither then
        { a Maximum of 200 is used for the quantize task to be 50% of the
         total task when Dither is specified. }
        FLastPercent := DoProgress(Self, FOnProgress, PercentProgress, 0, 200, FLastPercent)
    else
        FLastPercent := DoProgress(Self, FOnProgress, PercentProgress, 0, 99, FLastPercent)
end;

{--------------------------------------------------------------------------}

procedure TImageFormatTransform.Apply( const DibGraphic : TDibGraphic );
begin
    if DibGraphic.ImageFormat <> FImageFormat then
        inherited Apply(DibGraphic);
end;

{--------------------------------------------------------------------------}

procedure TImageFormatTransform.ApplyOnDest(
                           const Source : TDibGraphic;
                           const Dest   : TDibGraphic );
var
    PalettePtr : PMaxLogPalette;
    pPoint     : Windows.PPoint;

begin
    FLastPercent := -1;
    FLastPercent := DoProgress(Self, FOnProgress, 0, 0, 100, FLastPercent);

    if FImageFormat = ifColor16 then
    begin
        if Quantize then
            GetOptimizedPalette(Source, FPalette, 16, QuantizeProgress, FLastPercent)
        else
        begin
            { if the palette has not been set, use a default }
            if FPalette.palNumEntries = 0 then
                SetColor16Palette(FPalette);
        end;
        PalettePtr := @FPalette;
    end
    else if FImageFormat = ifColor256 then
    begin
        if Quantize then
            GetOptimizedPalette(Source, FPalette, 256, QuantizeProgress, FLastPercent)
        else
        begin
            { if the palette has not been set, use a default }
            if FPalette.palNumEntries = 0 then
                SetColor256Palette(FPalette);
        end;
        PalettePtr := @FPalette;
    end
    else
        PalettePtr := nil;

    Dest.NewImage( Source.Width, Source.Height, FImageFormat, PalettePtr,
                   Source.XDotsPerInch, Source.YDotsPerInch);

    if Dither and (FImageFormat <> ifTrueColor) then
        FSDither(Self, Source, Dest, Quantize)
    else
    begin
        { using HALFTONE stretch mode, the stretch quality is much better.
          The API help on SetStretchBltMode specifies that SetBrushOrgEx
          must be called afterwords. }
        SetStretchBltMode( Dest.DC, Windows.HALFTONE );
        pPoint := nil;
        { Delphi 2 requires a var parameter }
        SetBrushOrgEx( Dest.DC, 0, 0, pPoint );

        StretchDiBits( Dest.DC, 0, 0, Source.Width, Source.Height,
                       0, 0, Source.Width, Source.Height,
                       Source.Bits, Windows.PBitmapInfo(@Source.BitmapInfo)^,
                       DIB_RGB_COLORS, SRCCOPY);
    end;

    FLastPercent := DoProgress(Self, FOnProgress, 100, 0, 100, FLastPercent);

end;

{--------------------------------------------------------------------------}

constructor TCropTransform.Create;
begin
    inherited Create;

    FTop    := 0;
    FLeft   := 0;
    FBottom := 0;
    FRight  := 0;
end;

{--------------------------------------------------------------------------}

procedure TCropTransform.ApplyOnDest(
                           const Source : TDibGraphic;
                           const Dest   : TDibGraphic );
var
    Rect         : TRect;
    X,Y          : LongInt;
    DestWidth    : LongInt;
    DestHeight   : LongInt;
    Palettized   : Boolean;
begin
    if (FLeft = 0) and (FRight=0) and (FTop=0) and (FBottom=0) then
    begin
        Dest.Assign(Source);
        Exit;
    end;

    Rect.Top    := Self.Top;
    Rect.Bottom := Source.Height - Self.Bottom;
    Rect.Left   := Self.Left;
    Rect.Right  := Source.Width - Self.Right;

    if (Rect.Top >= Rect.Bottom) or
       (Rect.Left >= Rect.Right) then
        raise EEnvisionError.Create(msgInvalidCropParameters);

    DestWidth  := Rect.Right - Rect.Left;
    DestHeight := Rect.Bottom - Rect.Top;

    Dest.NewImage( DestWidth, DestHeight,
                   Source.ImageFormat, Source.PalettePtr,
                   Source.XDotsPerInch, Source.YDotsPerInch );

    Palettized := (Dest.ImageFormat <> ifTrueColor);

    FLastPercent := -1;
    FLastPercent := DoProgress(Self, FOnProgress, 0, 0, 100, FLastPercent);

    for Y := 0 to (DestHeight - 1) do
    begin
        FLastPercent := DoProgress(Self, FOnProgress, Y, 0, DestHeight-1, FLastPercent);

        for X := 0 to (DestWidth-1) do
        begin
            if Palettized then
                Dest.PaletteIndex[X, Y] := Source.PaletteIndex[ X+Self.FLeft, Y+Self.FTop]
            else
                Dest.Rgb[X, Y] := Source.Rgb[ X+Self.FLeft, Y+Self.FTop];
        end;
    end;

    FLastPercent := DoProgress(Self, FOnProgress, 100, 0, 100, FLastPercent);
end;

{--------------------------------------------------------------------------}

(* notes for gamma correction

> Also I don't think it's quite correct to call this "gamma
     >correction" - my impression is that gamma correction refers to a very
     >specific Color mapping (and not this one).
     >
     > What I _think_ actual gamma correction does is first divide
     >by 255 to get a number between 0 and 1, then take some power of this
     >number (like, taking the square makes it darker, taking the square root
     >makes it lighter) and then multiply by 255 again. I could be wrong,
     >but that's what I thought "gamma correction" really meant.
     >
     In a few words (nice style, David ;-)), a simple gamma function would look
     like :

     function GammaCorrection(const Value: Integer): Integer;
     begin
        Result := Round(255 * Power(Value/255, 1/Gamma));
     end;

     Assuming gamma is a Double :
     - values more than 1 make the Result lighter
     - values less than 1 make the Result darker

  E-mail me privately for a complete example of gamma correction using
     scanline (thanks Earl... ;-)

             Yannick <yc@imaginet.fr>

from, http://freespace.virgin.net/hugo.elias/graphics/x_gamma.htm
     Pixel = ((I / MaxIntensity) ^ (1/G)) * MaxIntensity
*)

{--------------------------------------------------------------------------}

(* Some notes on convolution filters posted by Lazikas o Pontios on the
   internet

below follow the filters I told you about. There are a lot of different
filters that bellong in different algorithm methods . A few things that
are important to all methods :

Images must be 256 gray levels (I did not test them with Color images).
We assume that image has the function RC (x,y) where x,y are the position
of every Pixel.
0<=X<=image_width-1 and
0<=Y<=Image_height-1 .

Thats all we need to know about.

--------------------------------------------------------------------------
1. CONVOLUTION FILTERS : This is the most used method (also known as
"moving window filters" and maybe you have already used it. for each
Pixel in range (1,1),(Width-1,height-1) we calculate its new value
using the following algo :

for J=1 to height-1
 for I = 1 to Width-1
   newcolor=a1*RC(I ,J-1) + a2*RC(I ,J-1) + a3*RC(I+1,J-1) +
            b1*RC(I-1,J) + b2*RC(I ,J) + b3*RC(I+1,J) +
            c1*RC(I-1,J+1) + c2*RC(I ,J+1) + c3*RC(I+1,J+1) ;
   newcolor=newcolor/kl;
   newcolor=abs( newcolor ); // hate negative values !!!
   if ( newcolor >255 ) newcolor=255; // not greater than 255
   // do whatever you want here eg put new Pixel Color in a buffer
 end I
end J

Unfortunatelly in this method we have strange results in first & last
row & column. Thats why we start from row-column 1 ( which is the second ) and
we stop 1 row & column before end.

Here follow the names of the filters that belong into this method and the
parameters a1..c3, kl that be used :

LOW_PASSn are noise removal filters. Images are getting smoother.
LAPLACE_ORIGINAL is Edge ehnancement Filter.
LAPLACE is a special effect Filter ( looks like you type the image in
                                    abnormal paper)
LAPLACE_EDGE is Edge detection Filter.
FOCUS is a sharpen Filter (looks like you have changed the focus of
                          the camera when snaping the picture)

   case LOW_PASS1: {
     kl=9;
     a1=1; a2=1; a3=1;
     b1=1; b2=1; b3=1;
     c1=1; c2=1; c3=1; break;
   }
   case LOW_PASS2: {
     kl=10;
     a1=1; a2=1; a3=1;
     b1=1; b2=2; b3=1;
     c1=1; c2=1; c3=1; break;
   }
   case LOW_PASS3: {
     kl=16;
     a1=1; a2=2; a3=1;
     b1=2; b2=4; b3=2;
     c1=1; c2=2; c3=1; break;
   }
   case LOW_PASS4: {
     kl=5;
     a1=0; a2=1; a3=0;
     b1=1; b2=1; b3=1;
     c1=0; c2=1; c3=0; break;
   }
   case LAPLACE_ORIGINAL: {
     kl=1;
     a1=-1; a2=-1; a3=-1;
     b1=-1; b2=9; b3=-1;
     c1=-1; c2=-1; c3=-1; break;
   }
   case LAPLACE: {
     kl=1;
     a1=1; a2=-2; a3=1;
     b1=-2; b2=5; b3=-2;
     c1=1; c2=-2; c3=1; break;
   }
   case LAPLACE_EDGE: {
     kl=1;
     a1=-1; a2=-1; a3=-1;
     b1=-1; b2=8; b3=-1;
     c1=-1; c2=-1; c3=-1; break;
   }
   case FOCUS: {
     kl=1;
     a1= 0; a2=-1; a3= 0;
     b1=-1; b2= 5; b3=-1;
     c1= 0; c2=-1; c3= 0; break;
   }

-------------------------------------------------------------------------
2. Relief Filter : Try it, it is good !

for J=0 to height-1
 for I = 0 to Width-1
   newcolor=RC (I,J)+((maxcolor / 2) - RC (I-2,J-2));
   newcolor=abs( newcolor ); // hate negative values !!!
   if ( newcolor >255 ) newcolor=255; // not greater than 255
   // do whatever you want here eg put new Pixel Color in a buffer
 end I
end J

where
maxcolor is the maximum gray scale of the image.

This is a very fancy Filter. All new Pixels have values near the
(maxcolor/2) and for better results in viewing it is good to create a
histogram equalization for the new image.
*)

procedure FillAntiAliasLookup;
var
    Index : Byte;

    function GetA : Integer;
    begin
        if (Index and $80) <> 0 then  Result := 1  else  Result := 0;
    end;

    function GetB : Integer;
    begin
        if (Index and $40) <> 0 then  Result := 1  else  Result := 0;
    end;

    function GetC : Integer;
    begin
        if (Index and $20) <> 0 then  Result := 1  else  Result := 0;
    end;

    function GetD : Integer;
    begin
        if (Index and $10) <> 0 then  Result := 1  else  Result := 0;
    end;

    function GetE : Integer;
    begin
        if (Index and $08) <> 0 then  Result := 1  else  Result := 0;
    end;

    function GetF : Integer;
    begin
        if (Index and $04) <> 0 then  Result := 1  else  Result := 0;
    end;

    function GetG : Integer;
    begin
        if (Index and $02) <> 0 then  Result := 1  else  Result := 0;
    end;

    function GetH : Integer;
    begin
        if (Index and $01) <> 0 then  Result := 1  else  Result := 0;
    end;

begin
    for Index := Low(Byte) to High(Byte) do
    begin
        AntiAliasLookup[Index] := (Round((GetA + GetB + GetE + GetF)*3.75) shl 12) or
                                  (Round((GetB + GetC + GetF + GetG)*3.75) shl 8) or
                                  (Round((GetC + GetD + GetG + GetH)*3.75) shl 4) or
                                  (Round((GetD + GetH)*7.5));
    end;
end;

begin
    FillAntiAliasLookup;
end.


