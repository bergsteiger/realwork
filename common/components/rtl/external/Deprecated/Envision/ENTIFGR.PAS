{----------------------------------------------------------------------------
|
| Library: Envision
|
| Module: EnTifGr
|
| Description: TDibGraphic descendant for TIFF files.
|              Supports the following compression (read and write):
|                  CCITT group 3 (1d and 2d)
|                  CCITT Group 4
|                  Packbits
|                  LZW (requires Unisys license, SetLZWLicense must be called.)
|                  JPEG
|                  ZLib (not part of the official TIFF spec, maybe it will be
|                        incorporated to bypass the patent on LZW)
|
| History: Nov 11, 1998. Michel Brazeau, first version
|
|---------------------------------------------------------------------------}
unit EnTifGr;

{$I Envision.Inc}

interface

uses
    Windows,  { for TRect, ColorRef, PMaxLogPalette }
    SysUtils, { for Exception, PByteArray }
    Classes,  { for TStream }
    EnMisc,   { for TImageFormat, DateToDateStr, TimeToTimeStr }
    EnDiGrph; { for TDibGraphic }


type

ETiffError = class(Exception);

{ LZW not supported for legal reasons }
TTiffCompression = ( tcNone, tcPackbits,
                     tcGroup3_1d, tcGroup3_2d, tcGroup4,
                     tcZLib, tcJPEG );

TTiffGraphic = class(TDibGraphic)
protected
    FCompression : TTiffCompression;

    procedure SetCompression(const Compression : TTiffCompression);

public
    constructor Create; override;
    destructor Destroy; override;

    procedure NewImage( const Width          : LongInt;
                        const Height         : LongInt;
                        const ImageFormat    : TImageFormat;
                              pPalette       : PMaxLogPalette;
                        const InXDotsPerInch : Word;
                        const InYDotsPerInch : Word ); override;

    property Compression : TTiffCompression
                read FCompression
                write SetCompression;

    function GetImageCount( const Stream : TStream ) : LongInt; override;

    procedure SingleLoadFromStream( const Stream      : TStream;
                                    const ImageToLoad : LongInt
                                  ); override;

    procedure SaveToStream(Stream: TStream); override;

    procedure AppendToStream(Stream : TStream); override;
end;

function TiffCompressionStr( const Compression : TTiffCompression ) : String;

procedure RaiseTiffError( const Msg : String );

{--------------------------------------------------------------------------}

implementation

uses
    EnCLib,   { for TTiffHandle, ... }
    EnMsg,    { for EEnvisionError }
    EnTransf, { for TNegativeTransform }
    Graphics; { for TPicture }

{--------------------------------------------------------------------------}

procedure RaiseTiffError( const Msg : String );
begin
    raise ETiffError.Create( ETiffError.ClassName + ' ' + Msg );
end;

{--------------------------------------------------------------------------}

function CheckColorMap( const Count         : Integer;
                        var   RedColorMap   : TWordArray;
                        var   GreenColorMap : TWordArray;
                        var   BlueColorMap  : TWordArray ) : LongInt;
var
    Index : Integer;
begin
    for Index := 0 to (Count-1) do
    begin
        if (RedColorMap[Index] >= 256) or
           (GreenColorMap[Index] >= 256) or
           (BlueColorMap[Index] >= 256) then
        begin
            Result := 16;
            Exit;
        end;
    end;

    Result := 8; { assume 8 bit color map }
end;

{--------------------------------------------------------------------------}

function Cvt( Value : Word ) : Byte;
begin
    Result := (((Value) * LongInt(255)) div ((1 shl 16)-1));
end;

{--------------------------------------------------------------------------}

function GetTiffPalette( const TiffHandle : TTiffHandle;
                         var   Palette    : TMaxLogPalette ) : Boolean;
var
    BitsPerSample              : Word;
    PhotometricInterpretation  : SmallInt;
    pRedColorMap               : TpWordArray;
    pGreenColorMap             : TpWordArray;
    pBlueColorMap              : TpWordArray;
    Palette16Bits              : Boolean;
    PaletteIndex               : Integer;

begin
    Result := False;
    FillChar(Palette, SizeOf(Palette), 0);

    TIFFGetField(TiffHandle, TIFFTAG_PHOTOMETRIC, PhotometricInterpretation);
    TIFFGetField(TiffHandle, TIFFTAG_BITSPERSAMPLE, BitsPerSample);

    if (PhotometricInterpretation <> 3) then
        Exit;

    Palette.palNumEntries := (1 shl BitsPerSample);
    Palette.palVersion    := $0300;

    TIFFGetField3( TiffHandle, TIFFTAG_COLORMAP,
                   pRedColorMap, pGreenColorMap, pBlueColorMap);

    { Is the palette 16 or 8 bits ? }
    if (CheckColorMap( Palette.palNumEntries,
                       pRedColorMap^, pGreenColorMap^, pBlueColorMap^) = 16) then
        Palette16Bits := True
    else
        Palette16Bits := False;

    { load the palette in the pixel graphic }
    for PaletteIndex := (Palette.palNumEntries-1) downto 0 do
    begin
        { a tiff palette has the red and blue entries reversed compared to
          a windows palette }
        if Palette16Bits then
        begin
            Palette.palPalEntry[PaletteIndex].peRed :=
                                 Cvt(pBlueColorMap^[PaletteIndex]);
            Palette.palPalEntry[PaletteIndex].peGreen :=
                                 Cvt(pGreenColorMap^[PaletteIndex]);
            Palette.palPalEntry[PaletteIndex].peBlue :=
                                 Cvt(pRedColorMap^[PaletteIndex]);
        end
        else
        begin
            Palette.palPalEntry[PaletteIndex].peRed :=
                                 Byte(pBlueColorMap^[PaletteIndex]);
            Palette.palPalEntry[PaletteIndex].peGreen :=
                                 Byte(pGreenColorMap^[PaletteIndex]);
            Palette.palPalEntry[PaletteIndex].peBlue :=
                                 Byte(pRedColorMap^[PaletteIndex]);
        end;
    end;

    Result := True;
end;

{--------------------------------------------------------------------------}

procedure SetTiffPalette( const TiffHandle : TTiffHandle;
                          const Palette    : TMaxLogPalette );
var
    pRedColorMap               : TpWordArray;
    pGreenColorMap             : TpWordArray;
    pBlueColorMap              : TpWordArray;
    PaletteIndex               : Integer;

    PaletteSize                : Word;

begin
    if Palette.palNumEntries <= 16 then
        PaletteSize := 16
    else
        PaletteSize := 256;

    GetMem( pRedColorMap, SizeOf(Word)*PaletteSize);
    GetMem( pGreenColorMap, SizeOf(Word)*PaletteSize);
    GetMem( pBlueColorMap, SizeOf(Word)*PaletteSize);
    try
        FillChar( pRedColorMap^, SizeOf(Word)*PaletteSize, 0);
        FillChar( pGreenColorMap^, SizeOf(Word)*PaletteSize, 0);
        FillChar( pBlueColorMap^, SizeOf(Word)*PaletteSize, 0);

        { load the palette in the pixel graphic }
        for PaletteIndex := (Palette.palNumEntries-1) downto 0 do
        begin
            { a 16 bit palette is more common for TIFF, so multiple each entry
              by 255. }
            pBlueColorMap^[PaletteIndex]  := Palette.palPalEntry[PaletteIndex].peRed*255;
            pGreenColorMap^[PaletteIndex] := Palette.palPalEntry[PaletteIndex].peGreen*255;
            pRedColorMap^[PaletteIndex]   := Palette.palPalEntry[PaletteIndex].peBlue*255;
        end;

        TIFFSetColorMap( TiffHandle,
                         pRedColorMap, pGreenColorMap, pBlueColorMap);
    finally
        FreeMem( pRedColorMap, SizeOf(Word)*PaletteSize);
        FreeMem( pGreenColorMap, SizeOf(Word)*PaletteSize);
        FreeMem( pBlueColorMap, SizeOf(Word)*PaletteSize);
    end;

end;

{--------------------------------------------------------------------------}

(*

MB Dec 01, 1998 Not used anymore. Inverted palettes such as some TIFF
black&white and gray palettes, are handled by reversing the bit values
themselves.
procedure ReversePalette( var   Palette    : TMaxLogPalette );
var
    Index    : Integer;
    NewIndex : Integer;
    TempR,
    TempG,
    TempB : Byte;

begin
    for Index := 0 to ((Palette.palNumEntries div 2)-1) do
    begin
        NewIndex := Palette.palNumEntries-Index-1;

        TempR := Palette.palPalEntry[Index].peRed;
        TempG := Palette.palPalEntry[Index].peGreen;
        TempB := Palette.palPalEntry[Index].peBlue;

        Palette.palPalEntry[Index].peRed :=
                             Palette.palPalEntry[NewIndex].peRed;
        Palette.palPalEntry[Index].peGreen :=
                             Palette.palPalEntry[NewIndex].peGreen;
        Palette.palPalEntry[Index].peBlue :=
                             Palette.palPalEntry[NewIndex].peBlue;

        Palette.palPalEntry[NewIndex].peRed   := TempR;
        Palette.palPalEntry[NewIndex].peGreen := TempG;
        Palette.palPalEntry[NewIndex].peBlue  := TempB;
    end;
end;
*)

{--------------------------------------------------------------------------}

function IsCCITTCompressed( const TiffHandle  : TTiffHandle;
                            const CompressTag : Word ) : Boolean;
begin
    Result := (CompressTag = COMPRESSION_CCITTFAX3) or
	      (CompressTag = COMPRESSION_CCITTFAX4) or
	      (CompressTag = COMPRESSION_CCITTRLE) or
	      (CompressTag = COMPRESSION_CCITTRLEW);
end;

{--------------------------------------------------------------------------}

function TiffCompressionStr( const Compression : TTiffCompression ) : String;
begin
    Result := '';
    case Compression of
        tcNone       : Result := 'None';
        tcPackbits   : Result := 'Packbits';
        tcGroup3_1d  : Result := 'CCITT Group 3, 1D';
        tcGroup3_2d  : Result := 'CCITT Group 3, 2D';
        tcGroup4     : Result := 'CCITT Group 4';
        tcZLib       : Result := 'ZLib';
        tcJPEG       : Result := 'JPEG';
    end;
end;

{--------------------------------------------------------------------------}

procedure RaiseCompressionNotSupported( const ImageFormat : TImageFormat;
                                        const Compression : TTiffCompression );
begin
    raise EEnvisionError.Create(
              Format( msgTiffCompressionNotSupported,
                      [ TiffCompressionStr(Compression),
                        ImageFormatStr(ImageFormat)]));
end;

{--------------------------------------------------------------------------}

procedure ReadUsingScanLines( const TiffHandle     : TTiffHandle;
                              const Dib            : TDibGraphic;
                              const ImageLength    : LongInt;
                              const ScanLineSize   : LongInt );
var
    pScanLine    : PByteArray;
    DibScanLine  : PByteArray;
    Row          : LongInt;

begin
    GetMem(pScanLine, ScanLineSize);
    try
        for Row := 0 to (ImageLength-1) do
        begin
            { MB May 17, 1999. Don't check for return code. Some rare images
              seem to have one or a few corrupted scan lines but the are
              still readable.
            if TIFFReadScanline(TiffHandle, pScanLine, Row) = -1 then
                RaiseTiffError('TIFFReadScanLine');
            }
            TIFFReadScanline(TiffHandle, pScanLine, Row);

            DibScanLine := Dib.ScanLine[Row];

            Move( pScanLine^, DibScanLine^[0], ScanLineSize);
        end;
    finally
        FreeMem(pScanLine, ScanLineSize);
    end;
end;

{--------------------------------------------------------------------------}

procedure ReadUsingRGBAImage( const TiffHandle     : TTiffHandle;
                              const Dib            : TDibGraphic;
                              const ImageWidth     : LongInt;
                              const ImageLength    : LongInt );
var
    Stream       : TMemoryStream;
    X            : LongInt;
    Y            : LongInt;
    RGB          : TRgb;
    TempByte     : Byte;

begin

    Stream := TMemoryStream.Create;
    try
        Stream.SetSize(ImageWidth * ImageLength * 4);

        if TIFFReadRGBAImage( TiffHandle, ImageWidth, ImageLength,
                              Stream.Memory, 1) <> 0 then
        begin
            for Y := (ImageLength-1) downto 0 do
            begin
                for X := 0 to (ImageWidth-1) do
                begin
                    Stream.Read(Rgb, SizeOf(Rgb));

                    TempByte := Rgb.Red;
                    Rgb.Red  := Rgb.Blue;
                    Rgb.Blue := TempByte;

                    Dib.RGB[X, Y] := Rgb;
                end;
            end;
        end;

    finally
        Stream.Free;
    end;
end;

{--------------------------------------------------------------------------}

procedure ReadUsingStrips( const TiffHandle     : TTiffHandle;
                           const Dib            : TDibGraphic;
                           const ImageWidth     : LongInt;
                           const ImageLength    : LongInt;
                           const SamplePerPixel : LongInt;
                           const ScanLineSize   : LongInt );
var
    pStrip                     : PByteArray;
    StripSize                  : LongInt;
    RowsPerStrip               : LongInt;
    RowCount                   : LongInt;
    RowIndex                   : LongInt;
    Y                          : LongInt;
    X                          : LongInt;
    DibScanLine                : PByteArray;
    Rgb                        : TRgb;

begin
    TIFFGetField(TiffHandle, TIFFTAG_ROWSPERSTRIP, RowsPerStrip);
    StripSize := TIFFStripSize(TiffHandle);

    GetMem(pStrip, StripSize);
    try
        { read the tiff lines and save them in the pixel graphic
          with RGB mode, we have to change the order of the 3 samples RGB <=> BGR }
        RowIndex := 0;
        while RowIndex < ImageLength do
        begin
            if (RowIndex + RowsPerStrip) > ImageLength then
                RowCount := ImageLength - RowIndex
            else
                RowCount := RowsPerStrip;

            if TIFFReadEncodedStrip( TiffHandle,
                                     TIFFComputeStrip(TiffHandle, RowIndex, 0),
                                     pStrip, RowCount*ScanLineSize) = -1 then
                RaiseTiffError('TIFFReadEncodedStrip')
            else
            begin
                for Y := 0 to (RowCount-1) do
                begin
                    if (SamplePerPixel = 3) or
                       (SamplePerPixel = 4) then
                    begin
                        { RGB }
                        for X := 0 to (ImageWidth-1) do
                        begin
                            { MB Dec 20, 1998. A range check error for some
                              reason occurs with range checking on. }
                            {$ifopt R+}
                                {$R-}
                            {$endif}
                            Rgb.Red   := pStrip^[Y*ScanLineSize+X*SamplePerPixel+2];
                            Rgb.Green := pStrip^[Y*ScanLineSize+X*SamplePerPixel+1];
                            Rgb.Blue  := pStrip^[Y*ScanLineSize+X*SamplePerPixel+0];
                            Dib.RGB[X, (Y+RowIndex)] := Rgb;
                        end
                    end
                    else
                    begin
                        { palette based }
                        DibScanLine := Dib.ScanLine[Y+RowIndex];
                        Move( pStrip^[Y*ScanLineSize], DibScanLine^[0], ScanLineSize);
                    end;
                end;
            end;

            RowIndex := RowIndex + RowsPerStrip;
        end;
    finally
        FreeMem(pStrip, StripSize);
    end;
end;

{--------------------------------------------------------------------------}

procedure ReadDibFromTiffStream( const Dib         : TTiffGraphic;
                                 const Stream      : TStream;
                                 const ImageToLoad : LongInt );
var
    TiffHandle                 : TTiffHandle;
    ImageLength                : LongInt;
    ImageWidth                 : LongInt;
    BitsPerSample              : Word;
    SamplePerPixel             : LongInt;
    ScanLineSize               : LongInt;
    PhotometricInterpretation  : Word;
    PlanarConfig               : Word;
    CompressTag                : Word;
    CCITTCompressed            : Boolean;
    UseReadRGBAImage           : Boolean;
    Palette                    : TMaxLogPalette;
    BitCount                   : Integer;
    ImageFormat                : TImageFormat;
    Group3Options              : LongInt;
    ResolutionUnit             : Word;
    XResolution                : Single;
    YResolution                : Single;
    Inverted                   : Boolean;
    NegativeTransform          : TNegativeTransform;
    XDpi                       : Word;
    YDpi                       : Word;

begin
    { MB Mar 08, 1999. Do NOT seek to the beginning of the stream,
      as this prevents the image from being loaded at design time
      in a TImage component. }

    TiffHandle := TIFFOpen(Stream, omRead);
    if TiffHandle = nil then
        RaiseTiffError('TIFFOpen');

    try
        TIFFSetDirectory(TiffHandle, ImageToLoad-1);

        TIFFGetField(TiffHandle, TIFFTAG_IMAGEWIDTH, ImageWidth);
        TIFFGetField(TiffHandle, TIFFTAG_IMAGELENGTH, ImageLength);

        { MB May 18, 1999. Some CCITT compressed files do not have
          the photometric interpretation tag, so a default is used if the
          tag is not present. }
        try
            TIFFGetField(TiffHandle, TIFFTAG_PHOTOMETRIC, PhotometricInterpretation);
        except
            PhotometricInterpretation := 0;
        end;

        TIFFGetField(TiffHandle, TIFFTAG_COMPRESSION, CompressTag);

        CCITTCompressed := IsCCITTCompressed(TiffHandle, CompressTag);

        { MB May 18, 1999. Some CCITT compressed files do not have the
          bits per sample tag. }
        try
            TIFFGetField(TiffHandle, TIFFTAG_BITSPERSAMPLE, BitsPerSample);
        except
            if CCITTCompressed then
                BitsPerSample := 1
            else
                raise;
        end;

        TIFFGetField(TiffHandle, TIFFTAG_PLANARCONFIG, PlanarConfig);
        try
            TIFFGetField(TiffHandle, TIFFTAG_RESOLUTIONUNIT, ResolutionUnit);
        except
            { an exception is raised for files that don't specify the
              resolution: the TIFF spec default is used in that case }
            ResolutionUnit := RESUNIT_INCH;
        end;


        XDpi := 0;
        try
            TIFFGetField(TiffHandle, TIFFTAG_XRESOLUTION, XResolution);
            if ResolutionUnit = RESUNIT_INCH then
                XDpi := Round(XResolution)
            else
                XDpi := Round(XResolution * CCentimetersPerInch);
        except
        end;

        YDpi := 0;
        try
            TIFFGetField(TiffHandle, TIFFTAG_YRESOLUTION, YResolution);
            if ResolutionUnit = RESUNIT_INCH then
                YDpi := Round(YResolution)
            else
                YDpi := Round(YResolution * CCentimetersPerInch);
        except
        end;


        if (CompressTag = COMPRESSION_LZW) then
            RaiseLZWCompressionNotSupported;

        UseReadRGBAImage := (CompressTag = COMPRESSION_JPEG) or
                            (TIFFIsTiled(TiffHandle) <> 0) or
                            (PhotometricInterpretation in [5,6]) or
                            (BitsPerSample > 8) or
                            (PlanarConfig > 1);

        ScanLineSize := TIFFScanlineSize(TiffHandle);

        SamplePerPixel := Round((ScanLineSize*1.0)/ImageWidth);
        if SamplePerPixel <= 0 then
            SamplePerPixel := 1;

        BitCount := (BitsPerSample*SamplePerPixel);

        if BitCount > 24 then
            BitCount := 24;

        if not (BitCount in [1, 4, 8, 24]) then
            RaiseTiffError('Unsupported bit count: ' + IntToStr(BitCount));

        ImageFormat := ifTrueColor;

        Inverted    := False;

        if (PhotometricInterpretation = 1) and CCITTCompressed then
            PhotometricInterpretation := 0;

        if (BitsPerSample = 1) and
           (PhotometricInterpretation = 1)then
        begin
            SetBWPalette(Palette);
            ImageFormat := ifBlackWhite;
        end;

        if (BitsPerSample = 1) and
           (PhotometricInterpretation = 0) then
        begin
            SetBWPalette(Palette);
            Inverted := True;
            ImageFormat := ifBlackWhite;
        end;

        if (BitsPerSample = 4) and
           (PhotometricInterpretation = 1) then
        begin
            SetGray16Palette(Palette);
            ImageFormat := ifGray16;
        end;

        if (BitsPerSample = 4) and
           (PhotometricInterpretation = 0) then
        begin
            SetGray16Palette(Palette);
            Inverted := True;
            ImageFormat := ifGray16;
        end;

        if (BitsPerSample = 8) and
           (PhotometricInterpretation = 1) then
        begin
            SetGray256Palette(Palette);
            ImageFormat := ifGray256;
        end;

        if (BitsPerSample = 8) and
           (PhotometricInterpretation = 0) then
        begin
            SetGray256Palette(Palette);
            { MB Dec 03, 1998. I'm not quite sure why, but don't invert
              if the image is read with ReadRGBAImage }
            Inverted    := not UseReadRGBAImage;
            ImageFormat := ifGray256;
        end;

        { PhotometricInterpretation = 0,1 B/W or gray scale palette
          PhotometricInterpretation = 2 image is RGB
          PhotometricInterpretation = 3 image have a color palette }
        if (PhotometricInterpretation = 3) then
        begin
            GetTiffPalette(TiffHandle, Palette);
            if BitsPerSample > 4 then
                ImageFormat := ifColor256
            else
                ImageFormat := ifColor16;
        end;

        if (PhotometricInterpretation = 0) and
           (CompressTag = COMPRESSION_JPEG) then
            Inverted := True;

        Dib.NewImage( ImageWidth, ImageLength,
                      ImageFormat, @Palette,
                      XDpi, YDpi );

        { set the compression after Dib.NewImage to override the defaults }
        case CompressTag of
            COMPRESSION_NONE      : Dib.Compression := tcNone;
            COMPRESSION_CCITTRLEW,
            COMPRESSION_CCITTRLE  : Dib.Compression := tcGroup3_1d;
            COMPRESSION_CCITTFAX3 :
            begin
                TIFFGetField(TiffHandle, TIFFTAG_GROUP3OPTIONS, Group3Options);
                if (Group3Options and GROUP3OPT_2DENCODING) <> 0 then
                    Dib.Compression := tcGroup3_2d
                else
                    Dib.Compression := tcGroup3_1d;

            end;
            COMPRESSION_CCITTFAX4 : Dib.Compression := tcGroup4;
            COMPRESSION_PACKBITS  : Dib.Compression := tcPackbits;
            COMPRESSION_DEFLATE	  : Dib.Compression := tcZLib;
            COMPRESSION_JPEG      : Dib.Compression := tcJPEG;

            else
                raise ETiffError.Create(
                            Format(msgUnsupportedCompressionTag, [CompressTag]));
        end; { case }

        if CCITTCompressed then
            ReadUsingScanLines(TiffHandle, Dib, ImageLength, ScanLineSize)
        else if UseReadRGBAImage then
            { these images are hard to handle, ie, YCbCr, CMYK color models,
              so ReadUsingRGBAImage is used at the expense of using a bit more
              memory. }
            ReadUsingRGBAImage(TiffHandle, Dib, ImageWidth, ImageLength )
        else
            ReadUsingStrips( TiffHandle, Dib,
                             ImageWidth, ImageLength,
                             SamplePerPixel, ScanLineSize );

        if Inverted then
        begin
            NegativeTransform := TNegativeTransform.Create;
            try
                NegativeTransform.Apply(Dib);
            finally
                NegativeTransform.Free;
            end;
        end;

    finally
        TIFFClose(TiffHandle);
    end;
end;

{--------------------------------------------------------------------------}

constructor TTiffGraphic.Create;
begin
    inherited Create;
end;

{--------------------------------------------------------------------------}

destructor TTiffGraphic.Destroy;
begin
    inherited Destroy;
end;

{--------------------------------------------------------------------------}

procedure TTiffGraphic.NewImage( const Width          : LongInt;
                                 const Height         : LongInt;
                                 const ImageFormat    : TImageFormat;
                                       pPalette       : PMaxLogPalette;
                                 const InXDotsPerInch : Word;
                                 const InYDotsPerInch : Word
                                );
begin
    inherited NewImage( Width, Height, ImageFormat, pPalette,
                        InXDotsPerInch, InYDotsPerInch );

    case ImageFormat of
        ifBlackWhite : Self.Compression := tcGroup4;
        ifGray16,
        ifGray256,
        ifColor16,
        ifColor256,
        ifTrueColor  : Self.Compression := tcPackbits;
    end;
end;

{--------------------------------------------------------------------------}

function TTiffGraphic.GetImageCount( const Stream : TStream ) : LongInt;
var
    TiffHandle : TTiffHandle;
begin
    TiffHandle := TIFFOpen(Stream, omRead);
    if TiffHandle = nil then
        RaiseTiffError('TIFFOpen');
    try
        Result := TiffImageCount(TiffHandle);
    finally
        TiffClose(TiffHandle);
    end;
end;

{--------------------------------------------------------------------------}

procedure TTiffGraphic.SetCompression( const Compression : TTiffCompression );
begin
    case ImageFormat of

        ifBlackWhite :
        begin
            if not (Compression in [ tcNone, tcPackbits, tcZLib,
                                     tcGroup3_1d, tcGroup3_2d,
                                     tcGroup4 ]) then
                RaiseCompressionNotSupported(ImageFormat, Compression);
        end;

        ifGray16,
        ifColor16,
        ifColor256 :
        begin
            if not (Compression in [ tcNone, tcPackbits,
                                     tcZlib ]) then
                RaiseCompressionNotSupported(ImageFormat, Compression);
        end;

        ifGray256:
        begin
            if not (Compression in [ tcNone, tcPackbits,
                                     tcZlib, tcJPEG ]) then
                RaiseCompressionNotSupported(ImageFormat, Compression);
        end;

        ifTrueColor :
        begin
            if not (Compression in [ tcNone, tcPackbits,
                                     tcZlib, tcJPEG ]) then
                RaiseCompressionNotSupported(ImageFormat, Compression);
        end;
    end;

    FCompression := Compression;

end;

{--------------------------------------------------------------------------}

procedure TTiffGraphic.SingleLoadFromStream(
                                      const Stream      : TStream;
                                      const ImageToLoad : LongInt
                                    );
var
    Position    : LongInt;
    ImageStream : TStream;
begin
    Position := Stream.Position;

    ImageStream := nil;
    try
        if Position <> 0 then
        begin
            { when loading images from DFM files, the image
              stream is included when a larger stream. The LibTiff
              library does not handle this, so a new stream
              must be created. }
            ImageStream := TMemoryStream.Create;

            TMemoryStream(ImageStream).SetSize(Stream.Size-Stream.Position);
            ImageStream.CopyFrom(Stream, Stream.Size-Stream.Position)
        end
        else
            ImageStream := Stream;

        ImageStream.Seek(0, soFromBeginning);

        ReadDibFromTiffStream(Self, ImageStream, ImageToLoad);

    finally
        if Position <> 0 then
            ImageStream.Free;
    end;

end;

{--------------------------------------------------------------------------}

procedure WriteDibToTiffStream( const Dib         : TTiffGraphic;
                                const Stream      : TStream;
                                const WriteMode   : TTiffOpenMode );
var
    TiffHandle                : TTiffHandle;
    CompressTag               : Word;
    RowsPerStrip              : LongInt;
    PhotometricInterpretation : Word;
    Row                       : LongInt;
    Palette                   : TMaxLogPalette;
    pScanLine                 : PByteArray;
    ModifiedScanLine          : Boolean;
    Index                     : LongInt;

begin

    TiffHandle := TIFFOpen(Stream, WriteMode);
    if TiffHandle = nil then
        RaiseTiffError('TIFFOpen');

    try
        { RowsPerStrip must be > 1 for reasonable compression }
        RowsPerStrip := 16;
        CompressTag := COMPRESSION_NONE;
        case Dib.Compression of
            tcPackbits   : CompressTag := COMPRESSION_PACKBITS;
            tcGroup3_1d,
            tcGroup3_2d:
            begin
                { the compression tag must be set before setting the group 3
                  options }
                CompressTag := COMPRESSION_CCITTFAX3;
                TIFFSetIntField(TiffHandle, TIFFTAG_COMPRESSION, CompressTag);
                if Dib.Compression = tcGroup3_2d then
                    TIFFSetIntField(TiffHandle, TIFFTAG_GROUP3OPTIONS, 1)
                else
                    TIFFSetIntField(TiffHandle, TIFFTAG_GROUP3OPTIONS, 0);

                RowsPerStrip := 256;
            end;
            tcGroup4     :
            begin
                CompressTag  := COMPRESSION_CCITTFAX4;
                RowsPerStrip := 256;
            end;

            tcZLib       : CompressTag := COMPRESSION_DEFLATE;
            tcJPEG       :
            begin
                CompressTag  := COMPRESSION_JPEG;
                RowsPerStrip := 8; { must be 8 for JPEG }
            end;
        end;
        TIFFSetIntField(TiffHandle, TIFFTAG_ROWSPERSTRIP, RowsPerStrip);
        TIFFSetIntField(TiffHandle, TIFFTAG_COMPRESSION, CompressTag);

        TIFFSetIntField(TiffHandle, TIFFTAG_PLANARCONFIG, 1);

        TIFFSetPCharField( TiffHandle, TIFFTAG_SOFTWARE,
                           PChar('Envision Image Library'));


        TIFFSetPCharField( TiffHandle, TIFFTAG_DATETIME,
                           PChar(
                              DateToDateStr( SysUtils.Date,
                              'yyyy:mm:dd' ) + ' ' +
                              TimeToTimeStr( SysUtils.Time,
                                             'hh:nn:ss')));

        TIFFSetIntField(TiffHandle, TIFFTAG_RESOLUTIONUNIT, RESUNIT_INCH);
        TIFFSetFloatField(TiffHandle, TIFFTAG_XRESOLUTION, Dib.XDotsPerInch);
        TIFFSetFloatField(TiffHandle, TIFFTAG_YRESOLUTION, Dib.YDotsPerInch);

        TIFFSetIntField(TiffHandle, TIFFTAG_IMAGEWIDTH, Dib.Width);

        TIFFSetIntField(TiffHandle, TIFFTAG_IMAGELENGTH, Dib.Height);

        case Dib.ImageFormat of
            ifBlackWhite:
            begin
                TIFFSetIntField(TiffHandle, TIFFTAG_BITSPERSAMPLE, 1);
                TIFFSetIntField(TiffHandle, TIFFTAG_SAMPLESPERPIXEL, 1);

                if Dib.Compression in [tcGroup3_1d, tcGroup3_2d, tcGroup4] then
                    PhotometricInterpretation := 0
                else
                    PhotometricInterpretation := 1;

                TIFFSetIntField( TiffHandle, TIFFTAG_PHOTOMETRIC,
                                 PhotometricInterpretation)
            end;

            ifGray16,
            ifGray256:
            begin
                if Dib.ImageFormat = ifGray16 then
                    TIFFSetIntField(TiffHandle, TIFFTAG_BITSPERSAMPLE, 4)
                else
                    TIFFSetIntField(TiffHandle, TIFFTAG_BITSPERSAMPLE, 8);

                TIFFSetIntField(TiffHandle, TIFFTAG_SAMPLESPERPIXEL, 1);
                TIFFSetIntField(TiffHandle, TIFFTAG_PHOTOMETRIC, 1);
            end;

            ifColor16,
            ifColor256:
            begin
                if Dib.ImageFormat = ifColor16 then
                    TIFFSetIntField(TiffHandle, TIFFTAG_BITSPERSAMPLE, 4)
                else
                    TIFFSetIntField(TiffHandle, TIFFTAG_BITSPERSAMPLE, 8);

                TIFFSetIntField(TiffHandle, TIFFTAG_SAMPLESPERPIXEL, 1);
                TIFFSetIntField(TiffHandle, TIFFTAG_PHOTOMETRIC, 3);

                Palette.palNumEntries := GetPaletteEntries(
                                           Dib.PaletteHandle,
                                           0,
                                           256,
                                           Palette.palPalEntry );
                SetTiffPalette( TiffHandle, Palette );
            end;

            ifTrueColor:
            begin
                TIFFSetIntField(TiffHandle, TIFFTAG_BITSPERSAMPLE, 8);
                TIFFSetIntField(TiffHandle, TIFFTAG_SAMPLESPERPIXEL, 3);
                TIFFSetIntField(TiffHandle, TIFFTAG_PHOTOMETRIC, 2);
            end;
        end; { case }

        ModifiedScanLine := (
                             (Dib.ImageFormat = ifBlackWhite) and
                             (Dib.Compression in [tcGroup3_1d, tcGroup3_2d, tcGroup4])
                            )
                            or
                            (Dib.ImageFormat = ifTrueColor);

        pScanLine := nil; { prevent compiler warning }

        if ModifiedScanLine then
            GetMem(pScanLine, Dib.ScanLineSize);

        try

            for Row := 0 to (Dib.Height-1) do
            begin

                if ModifiedScanLine then
                begin
                    { CCITT compress requires Black = 1 }

                    Move(Dib.ScanLine[Row]^, pScanLine^, Dib.ScanLineSize);

                    if Dib.ImageFormat = ifBlackWhite then
                    begin
                        for Index := 0 to (Dib.ScanLineSize-1) do
                            pScanLine^[Index] := not pScanLine^[Index];
                    end;

                    if Dib.ImageFormat = ifTrueColor then
                    begin
                        { R and B values must be swapped after loading the file
                          with many different image viewers. }
                        SwapRBOnScanLine(pScanLine, Dib.ScanLineSize);
                    end;
                end
                else
                    pScanLine := Dib.ScanLine[Row];

                if TIFFWriteScanline(TiffHandle, pScanLine, Row) = -1 then
                    RaiseTiffError('TIFFWriteScanLine');
            end;

        finally
            if ModifiedScanLine then
                FreeMem(pScanLine, Dib.ScanLineSize);
        end;

    finally
        TIFFClose(TiffHandle);
    end;
end;

{--------------------------------------------------------------------------}

procedure TTiffGraphic.SaveToStream(Stream: TStream);
var
    Position    : LongInt;
    ImageStream : TStream;

begin
    Position := Stream.Position;

    ImageStream := nil;
    try
        if Position <> 0 then
        begin
            { when saving images from DFM files, the image
              stream is included within a larger stream. The LibTiff
              library does not handle this, so a new stream
              must be created. }
            ImageStream := TMemoryStream.Create;
        end
        else
            ImageStream := Stream;

        WriteDibToTiffStream(Self, ImageStream, omWrite);

        if Position <> 0 then
        begin
            ImageStream.Seek(0, soFromBeginning);
            Stream.CopyFrom(ImageStream, ImageStream.Size);
        end;

    finally
        if Position <> 0 then
            ImageStream.Free;
    end;
end;

{--------------------------------------------------------------------------}

procedure TTiffGraphic.AppendToStream(Stream : TStream);
begin
    if Stream.Size = 0 then
        { the stream is empty, this is not really an append operation. }
        SaveToStream(Stream)
    else
    begin
        Stream.Seek(0, soFromBeginning);
        WriteDibToTiffStream(Self, Stream, omAppend);
    end;
end;

{--------------------------------------------------------------------------}

initialization

    {$ifdef __RegisterEnvisionTif}
    RegisterDibGraphic('TIF', 'TIFF file', TTiffGraphic);
    RegisterDibGraphic('TIFF', 'TIFF file', TTiffGraphic);
    {$endif}

finalization

end.

