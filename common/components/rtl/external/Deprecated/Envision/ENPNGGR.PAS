{----------------------------------------------------------------------------
|
| Library: Envision
|
| Module: EnPngGr
|
| Description: TDibGraphic descendant for PNG files.
|
| History: Dec 29, 1998. Michel Brazeau, first version
|
|---------------------------------------------------------------------------}
unit EnPngGr;

{$I Envision.Inc}

interface

uses
    Classes,  { for TStream }
    SysUtils, { for Exception }
    EnDiGrph; { for TDibGraphic }

type

TPngCompressionLevel = (pcLow, pcMedium, pcHigh);

TPngGraphic = class(TDibGraphic)
protected
    FImageGamma              : Double;
    FBackground              : TRgb;

    FOverwriteFileBackground : Boolean;

    FCompressionLevel        : TPngCompressionLevel;
    FSaveProgressive        : Boolean;

public
    constructor Create; override;

    procedure SingleLoadFromStream( const Stream      : TStream;
                                    const ImageToLoad : LongInt
                                  ); override;
                                  
    procedure SaveToStream(Stream: TStream); override;

    property ImageGamma : Double read FImageGamma
                                 write FImageGamma;

    { Background used for images with a transparent color, or an
      alpha channel. Default is Black. See OverwriteFileBackground. }
    property Background : TRgb read FBackground
                               write FBackground;

    { if OverwriteFileBackground is True, even if the file specifies
      a background, the value in the Background property will be used
      as the background. Default is False. }
    property OverwriteFileBackground : Boolean
                                read FOverwriteFileBackground
                                write FOverwriteFileBackground;

    { default pcMedium }
    property CompressionLevel : TPngCompressionLevel
                                read FCompressionLevel
                                write FCompressionLevel;

    property SaveProgressive : Boolean read FSaveProgressive
                                        write FSaveProgressive;
end;

EPNGError = class(Exception);

{--------------------------------------------------------------------------}

implementation

uses
    EnCLib,   { for png_XXXX }
    EnMisc,   { for CInchesPerMeter }
    EnMsg,    { for XXXXStr }
    Graphics, { for TPicture }
    Windows;  { for TRect }

{--------------------------------------------------------------------------}

procedure RaisePNGError( const Msg : String );
begin
    raise EPNGError.Create(Msg);
end;

{--------------------------------------------------------------------------}

constructor TPngGraphic.Create;
begin
    inherited Create;

    FImageGamma              := 0.5;

    FBackground              := MakeRgb(0,0,0);

    FOverwriteFileBackground := False;

    FCompressionLevel        := pcMedium;

    FSaveProgressive        := True;
end;

{--------------------------------------------------------------------------}

procedure png_error_proc( png_ptr : png_structp;
                          msg     : png_const_charp ); cdecl;
begin
    RaisePNGError(msg);
end;

{--------------------------------------------------------------------------}

procedure png_warn_proc( png_ptr : png_structp;
                         msg     : png_const_charp ); cdecl;
begin
    Windows.MessageBox( 0, msg, PChar('PNG Error'), MB_OK or MB_ICONWARNING);
end;

{--------------------------------------------------------------------------}

procedure png_read_proc( png_ptr  : png_structp;
                         pbuffer  : png_bytep;
                         size     : png_size_t ); cdecl;
var
    Stream : TStream;
begin
    Stream := TStream(png_get_io_ptr(png_ptr));
    Stream.Read(pBuffer^, Size);
end;

{--------------------------------------------------------------------------}

procedure png_write_proc( png_ptr  : png_structp;
                          pbuffer  : png_bytep;
                          size     : png_size_t ); cdecl;
var
    Stream : TStream;
begin
    Stream := TStream(png_get_io_ptr(png_ptr));
    Stream.Write(pBuffer^, Size);
end;

{--------------------------------------------------------------------------}

procedure png_flush_proc( png_ptr : png_structp); cdecl;
begin
end;

{--------------------------------------------------------------------------}

procedure CopyPngPaletteToLogPalette( const PngPalette : png_palette;
                                      var   Palette    : TMaxLogPalette;
                                      const ColorCount : Integer );
var
    Index : Integer;
begin
    FillChar(Palette, SizeOf(Palette), 0);
    Palette.palVersion    := $0300;
    Palette.palNumEntries := ColorCount;
    for Index := 0 to (ColorCount-1) do
    begin
        Palette.palPalEntry[Index].peRed   := PngPalette[Index].Blue;
        Palette.palPalEntry[Index].peGreen := PngPalette[Index].Green;
        Palette.palPalEntry[Index].peBlue  := PngPalette[Index].Red;
    end;
end;

{--------------------------------------------------------------------------}

procedure CopyLogPaletteToPngPalette( var   PngPalette : png_palette;
                                      const Palette    : TMaxLogPalette );
var
    Index : Integer;
begin
    FillChar(PngPalette, SizeOf(PngPalette), 0);
    for Index := 0 to (Palette.palNumEntries-1) do
    begin
        PngPalette[Index].Blue  := Palette.palPalEntry[Index].peRed;
        PngPalette[Index].Green := Palette.palPalEntry[Index].peGreen;
        PngPalette[Index].Red   := Palette.palPalEntry[Index].peBlue;
    end;
end;

{--------------------------------------------------------------------------}
(* MB Jan 03, 1998. Previous code reading row-by-row had problems with
   the first scan line, so now the image is read with png_read_image. For
   a 2 bit image, the memory requirements are reasonable.
procedure ReadConvert2To4Bit( const png_ptr   : png_structp;
                              const info_ptr  : png_infop;
                              const Dib       : TDibGraphic;
                              const Width     : LongInt;
                              const Height    : LongInt;
                              const PassCount : Integer;
                              const Gray      : Boolean );
var
    PassNo             : Integer;
    pScanLine          : PByteArray;
    X,Y                : LongInt;
begin
    { assert: png_set_packing has been called. }

    GetMem(pScanLine, png_get_rowbytes(png_ptr, info_ptr));
    try
        for PassNo := 1 to PassCount do
        begin
            for Y := 0 to (Height-1) do
            begin
                png_read_row(png_ptr, png_bytep(pScanLine), nil);

                for X := 0 to (Width-1) do
                begin
                    if Gray then
                        Dib.PaletteIndex[X,Y] := pScanLine^[X] * 5
                    else
                        Dib.PaletteIndex[X,Y] := pScanLine^[X];
                end;
            end;
        end;
    finally
        FreeMem(pScanLine);
    end;
end;
*)

{--------------------------------------------------------------------------}

procedure ReadConvert2To4Bit( const png_ptr   : png_structp;
                              const info_ptr  : png_infop;
                              const Dib       : TDibGraphic;
                              const Width     : LongInt;
                              const Height    : LongInt;
                              const PassCount : Integer;
                              const Gray      : Boolean );
type
    TImage = array[0..(MaxLongInt div 4)-3] of PByteArray;
    TpImage = ^TImage;

    function GetPixelBc2( const ScanLine : PByteArray;
                          const X        : LongInt ) : LongInt;
    var
        pByte : ^Byte;
    begin
        pByte   := @ScanLine^[(X div 4)];

        Result := 0; { prevent compiler warning }

        case (X mod 4) of
            0 : Result := (pByte^ shr 6) and $03;
            1 : Result := (pByte^ shr 4) and $03;
            2 : Result := (pByte^ shr 2) and $03;
            3 : Result := pByte^ and $03;
        end;
    end;

    function AllocateImage( const RowWidth : LongInt;
                            const Height   : LongInt ) : TpImage;
    var
        RowNo : LongInt;
    begin
        GetMem(Result, Height * SizeOf(PByteArray));
        for RowNo := 0 to (Height-1) do
            GetMem(Result^[RowNo], RowWidth);
    end;

    procedure FreeImage( const RowWidth : LongInt;
                         const Height   : LongInt;
                         const pImage   : TpImage );
    var
        RowNo : LongInt;
    begin
        for RowNo := 0 to (Height-1) do
            FreeMem(pImage^[RowNo], RowWidth);
        FreeMem(pImage, Height * SizeOf(PByteArray));
    end;

var
    pImage      : TpImage;
    pScanLine   : PByteArray;
    X,Y         : LongInt;

begin
    pImage := AllocateImage(png_get_rowbytes(png_ptr, info_ptr), Height);
    try
        png_read_image(png_ptr, @pImage^[0]);

        for Y := 0 to (Height-1) do
        begin
            pScanLine := pImage^[Y];

            for X := 0 to (Width-1) do
            begin
                if Gray then
                    Dib.PaletteIndex[X,Y] := GetPixelBc2(pScanLine,X) * 5
                else
                    Dib.PaletteIndex[X,Y] := GetPixelBc2(pScanLine,X);
            end;
        end;

    finally
        FreeImage(png_get_rowbytes(png_ptr, info_ptr), Height, pImage);
    end;
end;

{--------------------------------------------------------------------------}

procedure ReadUsingScanLines( const png_ptr   : png_structp;
                              const Dib       : TDibGraphic;
                              const Height    : LongInt;
                              const PassCount : Integer );
var
    PassNo             : Integer;
    pScanLine          : PByteArray;
    Y                  : LongInt;
begin
    for PassNo := 1 to PassCount do
    begin
        for Y := 0 to (Height-1) do
        begin
            pScanLine := Dib.ScanLine[Y];
            png_read_row(png_ptr, png_bytep(pScanLine), nil);
        end;
    end;
end;

{--------------------------------------------------------------------------}

procedure TPngGraphic.SingleLoadFromStream(
                                    const Stream      : TStream;
                                    const ImageToLoad : LongInt
                                  );
var
    png_ptr            : png_structp;
    info_ptr           : png_infop;
    MagicBytes         : array[0..7] of Byte;

    Width              : Integer;
    Height             : Integer;
    BitDepth           : Integer;
    ColorType          : Integer;
    InterlaceType      : Integer;
    CompressionType    : Integer;
    FilterType         : Integer;

    ImageFormat        : TImageFormat;
    Convert2BitTo4Bit  : Boolean;

    res_x              : png_uint_32;
    res_y              : png_uint_32;
    unit_type          : Integer;

    ppngPalette        : png_palettep;
    ColorCount         : Integer;

    Palette            : TMaxLogPalette;
    pPalette           : PMaxLogPalette;

    Intent             : Integer;
    PassCount          : Integer;

    BackgroundColor    : png_color_16;
    pBackgroundColor   : png_color_16p;

begin
    Stream.Read(MagicBytes, SizeOf(MagicBytes));

    if png_sig_cmp(@MagicBytes, 0, SizeOf(MagicBytes)) <> 0 then
        RaisePNGError(msgNotAValidPngFile);

    png_ptr := png_create_read_struct( PChar(PNG_LIBPNG_VER_STRING), nil,
                                       png_error_proc, png_warn_proc );
    if png_ptr = nil then
        RaisePNGError('png_create_read_struct failed');

    info_ptr := png_create_info_struct(png_ptr);
    if png_ptr = nil then
    begin
        png_destroy_read_struct(@png_ptr, nil, nil);
        RaisePNGError('png_create_info_struct failed');
    end;

    try
        png_set_read_fn(png_ptr, Pointer(Stream), png_read_proc);
        png_set_sig_bytes(png_ptr, SizeOf(MagicBytes));

        png_read_info(png_ptr, info_ptr);

        png_get_IHDR( png_ptr, info_ptr,
                      @Width, @Height, @BitDepth, @ColorType,
                      @InterlaceType, @CompressionType, @FilterType );

        Convert2BitTo4Bit := False;

        ImageFormat  := ifTrueColor; { prevent compiler warning }
        pPalette     := nil;

        if BitDepth = 1 then
        begin
            ImageFormat := ifBlackWhite;

            if not (ColorType in [ PNG_COLOR_TYPE_GRAY,
                                   PNG_COLOR_TYPE_PALETTE ]) then
                RaisePNGError(msgInvalidColorTypeForBitDepth);
        end
        else if BitDepth = 2 then
        begin
            case ColorType of
                PNG_COLOR_TYPE_GRAY :
                begin
                    ImageFormat  := ifGray16;
                    Convert2BitTo4Bit := True;
                end;
                PNG_COLOR_TYPE_PALETTE :
                begin
                    ImageFormat  := ifColor16;
                    Convert2BitTo4Bit := True;
                end;
                else
                    RaisePNGError(msgInvalidColorTypeForBitDepth);
            end;
        end
        else if BitDepth = 4 then
        begin
            case ColorType of
                PNG_COLOR_TYPE_GRAY    : ImageFormat  := ifGray16;
                PNG_COLOR_TYPE_PALETTE : ImageFormat  := ifColor16;
                else
                    RaisePNGError(msgInvalidColorTypeForBitDepth);
            end;
        end
        else if BitDepth = 8 then
        begin
            case ColorType of
                PNG_COLOR_TYPE_GRAY,
                PNG_COLOR_TYPE_GRAY_ALPHA  : ImageFormat := ifGray256;
                PNG_COLOR_TYPE_PALETTE     : ImageFormat := ifColor256;
                PNG_COLOR_TYPE_RGB,
                PNG_COLOR_TYPE_RGB_ALPHA   : ImageFormat := ifTrueColor;
                else
                    RaisePNGError(msgInvalidColorTypeForBitDepth);
            end;
        end
        else if BitDepth = 16 then
        begin
            png_set_strip_16(png_ptr);
            png_set_swap(png_ptr);

            case ColorType of
                PNG_COLOR_TYPE_GRAY,
                PNG_COLOR_TYPE_GRAY_ALPHA  : ImageFormat := ifGray256;
                PNG_COLOR_TYPE_PALETTE     : ImageFormat := ifColor256;
                PNG_COLOR_TYPE_RGB,
                PNG_COLOR_TYPE_RGB_ALPHA   : ImageFormat := ifTrueColor;
                else
                    RaisePNGError(msgInvalidColorTypeForBitDepth);
            end;
        end
        else
            RaisePNGError(msgInvalidBitDepth);

        if ImageFormat = ifTrueColor then
            png_set_bgr(png_ptr);

        if png_get_sRGB(png_ptr, info_ptr, @Intent) <> 0 then
            png_set_sRGB(png_ptr, info_ptr, intent)
        else if BitDepth > 2 then
        begin
            { MB. Dec 03, 1998. Only perform gamma adjustments with images
              with a bit count > 2. This has been determined empirically using
              test 2 bit gray scale images. } 
            if (png_get_gAMA(png_ptr, info_ptr, @FImageGamma) <> 0) and
               (FImageGamma <> 0) then
                png_set_gamma( png_ptr, EnDiGrph.ScreenGamma, FImageGamma )
            else
            begin
                FImageGamma := 0.5;
                png_set_gamma( png_ptr, EnDiGrph.ScreenGamma, FImageGamma );
            end;
        end;

        FillChar(BackgroundColor, SizeOf(BackgroundColor), 0);
        BackgroundColor.Red   := FBackground.Red;
        BackgroundColor.Green := FBackground.Green;
        BackgroundColor.Blue  := FBackground.Blue;
                           
        if png_get_bKGD(png_ptr, info_ptr, @pBackgroundColor) <> 0 then
        begin
            { file specifies a background }

            if OverwriteFileBackground then
            begin
                pBackgroundColor := @BackgroundColor;
                png_set_background( png_ptr, pBackgroundColor,
                                    PNG_BACKGROUND_GAMMA_SCREEN, 0, 1.0 );
            end
            else
                png_set_background( png_ptr, pBackgroundColor,
                                    PNG_BACKGROUND_GAMMA_FILE, 1, 1.0 );
        end
        else
        begin
            { file does not specify a backround }
            pBackgroundColor := @BackgroundColor;
            png_set_background( png_ptr, pBackgroundColor,
                                PNG_BACKGROUND_GAMMA_SCREEN, 0, 1.0 );
        end;

        png_get_pHYs( png_ptr, info_ptr,
                      @res_x, @res_y, @unit_type );

        if unit_type = PNG_RESOLUTION_METER then
        begin
            res_x := Round(res_x * CMetersPerInch);
            res_y := Round(res_y * CMetersPerInch);
        end
        else
        begin
            res_x := 0;
            res_y := 0;
        end;

        { png_set_interlace_handling must be called before
          png_read_update_info }

        PassCount := 1; { prevent compiler warning }
        if InterlaceType = PNG_INTERLACE_NONE then
            PassCount := 1
        else if InterlaceType = PNG_INTERLACE_ADAM7 then
            PassCount := png_set_interlace_handling(png_ptr)
        else
            RaisePNGError('Interlace type not valid');

        png_read_update_info(png_ptr, info_ptr);

        if (ColorType and PNG_COLOR_MASK_PALETTE) <> 0 then
        begin
           if (png_get_PLTE( png_ptr, info_ptr, @ppngPalette, @ColorCount) = 0) then
               RaisePNGError('png_get_PLTE failed')
           else
           begin
               CopyPngPaletteToLogPalette(ppngPalette^, Palette, ColorCount);
               pPalette := @Palette;
           end;
        end;

        Self.NewImage( Width, Height, ImageFormat, pPalette, res_x, res_y );

        if Convert2BitTo4Bit then
            ReadConvert2To4Bit(png_ptr, info_ptr, Self, Width, Height, PassCount, (ImageFormat = ifGray16))
        else
            ReadUsingScanLines(png_ptr, Self, Height, PassCount);

    finally
        png_destroy_read_struct(@png_ptr, @info_ptr, nil);
    end;
end;

{--------------------------------------------------------------------------}

procedure TPngGraphic.SaveToStream(Stream: TStream);
var
    png_ptr            : png_structp;
    info_ptr           : png_infop;

    BitDepth           : Integer;
    InterlaceType      : Integer;
    ColorType          : Integer;

    PngPalette         : png_palette;

    Y                  : LongInt;
    PassNo             : Integer;
    PassCount          : Integer;

    function GetColorType( const ImageFormat : TImageFormat ) : Integer;
    begin
        case ImageFormat of
            ifBlackWhite : Result := PNG_COLOR_TYPE_GRAY;
            ifGray16     : Result := PNG_COLOR_TYPE_GRAY;
            ifGray256    : Result := PNG_COLOR_TYPE_GRAY;
            ifColor16    : Result := PNG_COLOR_TYPE_PALETTE;
            ifColor256   : Result := PNG_COLOR_TYPE_PALETTE;
            ifTrueColor  : Result := PNG_COLOR_TYPE_RGB;
            else
                raise EEnvisionError.Create(msgInvalidImageFormat);
        end;
    end;

begin
    png_ptr := png_create_write_struct( PChar(PNG_LIBPNG_VER_STRING), nil,
                                        png_error_proc, png_warn_proc );
    if png_ptr = nil then
        RaisePNGError('png_create_write_struct failed');

    info_ptr := png_create_info_struct(png_ptr);
    if png_ptr = nil then
    begin
        png_destroy_write_struct(@png_ptr, nil);
        RaisePNGError('png_create_info_struct failed');
    end;

    try
        png_set_write_fn(png_ptr, Pointer(Stream), png_write_proc, png_flush_proc);

        BitDepth := GetBitDepth(Self.ImageFormat);
        if BitDepth > 8 then
            BitDepth := 8;

        ColorType := GetColorType(Self.ImageFormat);

        if FSaveProgressive then
            InterlaceType := PNG_INTERLACE_ADAM7
        else
            InterlaceType := PNG_INTERLACE_NONE;

        png_set_IHDR( png_ptr, info_ptr, Self.Width, Self.Height,
                      BitDepth, ColorType,
                      InterlaceType,
                      PNG_COMPRESSION_TYPE_BASE,
                      PNG_FILTER_TYPE_BASE );


        if ColorType = PNG_COLOR_TYPE_PALETTE then
        begin
            CopyLogPaletteToPngPalette( PngPalette,
                                        Self.Palette );

            png_set_PLTE(png_ptr, info_ptr, @PngPalette, Self.Palette.palNumEntries);
        end;

        png_set_pHYs( png_ptr, info_ptr,
                      Round(Self.XDotsPerInch / CMetersPerInch),
                      Round(Self.YDotsPerInch / CMetersPerInch),
                      PNG_RESOLUTION_METER );

        png_set_gAMA(png_ptr, info_ptr, FImageGamma);

        case FCompressionLevel of
            pcLow    : png_set_compression_level(png_ptr, Z_BEST_SPEED);
            pcMedium : png_set_compression_level(png_ptr, Z_MEDIUM);
            pcHigh   : png_set_compression_level(png_ptr, Z_BEST_COMPRESSION);
        end;

        png_write_info(png_ptr, info_ptr);

        if ImageFormat = ifTrueColor then
            png_set_bgr(png_ptr);

        if InterlaceType = PNG_INTERLACE_ADAM7 then
            PassCount := png_set_interlace_handling(png_ptr)
        else
            PassCount := 1;

        for PassNo := 1 to PassCount do
        begin
            for Y := 0 to (Self.Height-1) do
               png_write_row(png_ptr, png_bytep(Self.ScanLine[Y]));
        end;

        png_write_end(png_ptr, info_ptr);

    finally
        png_destroy_write_struct(@png_ptr, @info_ptr);
    end;
end;

{--------------------------------------------------------------------------}

initialization

    {$ifdef __RegisterEnvisionPng}
    RegisterDibGraphic('PNG', 'Portable Network Graphic', TPngGraphic);
    {$endif}

finalization

end.

