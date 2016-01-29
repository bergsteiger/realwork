{----------------------------------------------------------------------------
|
| Library: Envision
|
| Module: EnBmpGr
|
| Description: TDibGraphic descendant for BMP files.
|
| History: Dec 24, 1998. Michel Brazeau, first version
|
|---------------------------------------------------------------------------}
unit EnBmpGr;

{$I Envision.Inc}

interface

uses
    Classes,  { for TStream }
    EnDiGrph; { for TDibGraphic }


type

TBitmapGraphic = class(TDibGraphic)
public
    procedure SingleLoadFromStream( const Stream      : TStream;
                                    const ImageToLoad : LongInt
                                  ); override;
                                  
    procedure SaveToStream(Stream: TStream); override;
end;

{--------------------------------------------------------------------------}

implementation

uses
    Windows,  { for TBitmapInfoHeader,... }
    Graphics, { for TBitmap }
    EnMisc,   { for TImageFormat, CMetersPerInch }
    EnGbm;    { for LoadGraphicWithGbm }

const

CSampleBmpFileName = 'File.bmp';
CXDpmOffset        = 38;

{ BMP file header, for reference
    bfType: Word;
    bfSize: DWORD;
    bfReserved1: Word;
    bfReserved2: Word;
    bfOffBits: DWORD;

    biSize: DWORD;
    biWidth: Longint;
    biHeight: Longint;
    biPlanes: Word;
    biBitCount: Word;
    biCompression: DWORD;
    biSizeImage: DWORD;
    biXPelsPerMeter: Longint;
    biYPelsPerMeter: Longint;
    biClrUsed: DWORD;
    biClrImportant: DWORD;
}

{--------------------------------------------------------------------------}

procedure TBitmapGraphic.SingleLoadFromStream(
                                    const Stream      : TStream;
                                    const ImageToLoad : LongInt
                                  );
var
    XDpm        : LongInt; { must be a LongInt as defined in BMP file header }
    YDpm        : LongInt;
    Position    : LongInt;
    ImageStream : TStream;

    procedure LoadWithVcl;
    var
        Bitmap : Graphics.TBitmap;
    begin
        Bitmap := Graphics.TBitmap.Create;
        try
            Bitmap.LoadFromStream(ImageStream);
            Self.Assign(Bitmap);
        finally
            Bitmap.Free;
        end;

    end;

begin
    { A bitmap image is read using the GBM library, as it is faster
      than Delphi TBitmap implementation }

    Position := Stream.Position;

    ImageStream := nil;
    try
        if Position <> 0 then
        begin
            { when loading images from DFM files, the image
              stream is included when a larger stream. The GBM
              library does not handle this, so a new stream
              must be created. }
            ImageStream := TMemoryStream.Create;

            TMemoryStream(ImageStream).SetSize(Stream.Size-Stream.Position);
            ImageStream.CopyFrom(Stream, Stream.Size-Stream.Position)
        end
        else
            ImageStream := Stream;

        { read the image resolution directly from the stream as the GBM library
          does not return it. }
        ImageStream.Seek(CXDpmOffset, soFromBeginning);
        ImageStream.Read(XDpm, SizeOf(XDpm));
        ImageStream.Read(YDpm, SizeOf(YDpm));

        ImageStream.Seek(0, soFromBeginning);

        try
            LoadGraphicWithGbm( ImageStream, Self, CSampleBmpFileName, 'inv' );
        except
            { GBM does not load 16 bit bitmaps, so the VCL TBitmap class is
              used to load 16 bit bitmaps }
            ImageStream.Seek(0, soFromBeginning);
            LoadWithVcl;
        end;

        Self.XDotsPerInch := Round(XDpm * CMetersPerInch);
        Self.YDotsPerInch := Round(YDpm * CMetersPerInch);

    finally
        if Position <> 0 then
            ImageStream.Free;
    end;
end;

(* Apr 05, 1999. Previous implementation using TBitmap to load the bits was
   much slower than using GBM, especially on multi-megabyte RGB files.
procedure TBitmapGraphic.SingleLoadFromStream(
                                    const Stream      : TStream;
                                    const ImageToLoad : LongInt
                                  );

var
    Bitmap : Graphics.TBitmap;
begin
    Bitmap := Graphics.TBitmap.Create;
    try
        Bitmap.LoadFromStream(Stream);

        Self.AssignFromBitmapHandle(Bitmap.Handle);
    finally
        Bitmap.Free;
    end;
end;
*)

{--------------------------------------------------------------------------}

procedure TBitmapGraphic.SaveToStream(Stream: TStream);
var
    Header      : TBitmapFileHeader;
    PaletteSize : Word;
begin
    { MB Dec 24, 1998. Setting Width/Height will raise EOutOfResources on
      large bitmap, even if they are monochrome. The Bitmap problably
      assumes 24 bits, requiring a lot of resources when the size is set.

      Bitmap.Assign(Self) which assigns the handles works, but then
      SaveToStream raise a GDI exception "The parameter is incorrect"
      on the following line in TBitmap.WriteStream (VCL Delphi 4)

        Save := GDICheck(SelectObject(FCanvas.FHandle, FDIBHandle));

      The approach used is simply to save the device independent
      bits directly, as a DIB is really a bitmap file without the
      header block.
    }
    FillChar(Header, SizeOf(Header), 0);

    Header.bfType := $4D42; { 'BM' }

    if ImageFormat = ifTrueColor then
        PaletteSize := 0
    else
        PaletteSize := 4*Palette.palNumEntries;

    Header.bfSize := SizeOf(Header) +
                     SizeOf(FBitmapInfo.BmpHeader) +
                     PaletteSize +
                     FBitmapInfo.BmpHeader.biSizeImage;

    Header.bfOffBits := SizeOf(Header) +
                        SizeOf(FBitmapInfo.BmpHeader) +
                        PaletteSize;

    Stream.Write(Header, SizeOf(Header));
    Stream.Write(FBitmapInfo.BmpHeader, SizeOf(FBitmapInfo.BmpHeader));

    if PaletteSize > 0 then
        Stream.Write(FBitmapInfo.Palette, PaletteSize);

    Stream.Write(FBits^, FBitmapInfo.BmpHeader.biSizeImage);
end;

{--------------------------------------------------------------------------}

initialization

    {$ifdef __RegisterEnvisionBmp}
    RegisterDibGraphic('BMP', 'Bitmap file', TBitmapGraphic);
    {$endif}

finalization

end.

