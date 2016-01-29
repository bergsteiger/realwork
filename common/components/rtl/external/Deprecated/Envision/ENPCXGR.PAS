{----------------------------------------------------------------------------
|
| Library: Envision
|
| Module: EnPcxGr
|
| Description: TDibGraphic descendant for PCX files.
|
| History: Feb 27, 1999. Michel Brazeau, first version
|
|---------------------------------------------------------------------------}
unit EnPcxGr;

{$I Envision.Inc}

interface

uses
    Classes,  { for TStream }
    SysUtils, { for Exception }
    EnDiGrph; { for TDibGraphic }

type

TPcxGraphic = class(TDibGraphic)
public
    constructor Create; override;

    procedure SingleLoadFromStream( const Stream      : TStream;
                                    const ImageToLoad : LongInt
                                  ); override;

    procedure SaveToStream(Stream: TStream); override;
end;

{--------------------------------------------------------------------------}

implementation

uses
    EnMisc,   { for TImageFormat, Ceiling }
    EnGbm;    { for LoadGraphicWithGbm, SaveGraphicWithGbm }

const

CXDpiOffset        = 12;
CSamplePcxFileName = 'File.pcx';

{ MB Feb 28, 1999. Pcx header not used, but included as comment for
  reference }
type

TpPcxHeader = ^TPcxHeader;
TPcxHeader = packed record
    Manufacturer   : Byte;
    Version        : Byte;
    Encoding       : Byte;
    BitsPerPixel   : Byte;
    XMin           : Word;
    YMin           : Word;
    XMax           : Word;
    YMax           : Word;
    XDpi           : Word;
    YDpi           : Word;
    Palette        : packed array [0..47] of Byte;
    VMode          : Byte;
    ColourPlanes   : Byte;
    BytesPerLine   : Word;
    PaletteType    : Word;
    ScreenWidth    : Word;
    ScreenHeight   : Word;
    Filler         : array [0..53] of Byte;
end;


{--------------------------------------------------------------------------}

constructor TPcxGraphic.Create;
begin
    inherited Create;

end;

{--------------------------------------------------------------------------}

procedure TPcxGraphic.SingleLoadFromStream( const Stream      : TStream;
                                            const ImageToLoad : LongInt
                                           );
var
    XDpi        : Word; { must be a Word as defined in PCX file header }
    YDpi        : Word;
    Position    : LongInt;
    ImageStream : TStream;
    Header      : TPcxHeader;

begin
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
        ImageStream.Seek(CXDpiOffset, soFromBeginning);
        ImageStream.Read(XDpi, SizeOf(XDpi));
        ImageStream.Read(YDpi, SizeOf(YDpi));

        ImageStream.Seek(0, soFromBeginning);

        { MB Apr 27, 1999. Remove 'trunc' option, which distorted some PCX
          files }
        LoadGraphicWithGbm( ImageStream, Self, CSamplePcxFileName, '' );

        { MB Sep 08, 1999. The PCX scan lines for bitonal images are not
          always a multiple of 4 bytes. An access violation was occuring in
          the TAntiAliasTransform which relied on the ScanLineSize property }
        (* this corrupts the image
        if Self.ImageFormat = ifBlackWhite then
        begin
            FScanLineSize := Ceiling(Self.Width / 8.0);
        end;
        *)

        Self.XDotsPerInch := XDpi;
        Self.YDotsPerInch := YDpi;

        ImageStream.Seek(0, soFromBeginning);

        ImageStream.ReadBuffer(Header, SizeOf(Header));

        //FScanLineSize := Header.BytesPerLine;


    finally
        if Position <> 0 then
            ImageStream.Free;
    end;
end;

{--------------------------------------------------------------------------}

procedure TPcxGraphic.SaveToStream(Stream: TStream);
var
    XDpi        : Word; { must be a Word as defined in PCX file header }
    YDpi        : Word;
    Position    : LongInt;

begin
    Position := Stream.Position;

    SaveGraphicWithGbm( Stream, Self, CSamplePcxFileName );

    { write the image resolution directly to the stream as the GBM library
      does not write it. }
    XDpi := Self.XDotsPerInch;
    YDpi := Self.YDotsPerInch;

    Stream.Seek(Position+CXDpiOffset, soFromBeginning);
    Stream.Write(XDpi, SizeOf(XDpi));
    Stream.Write(YDpi, SizeOf(YDpi));
end;

{--------------------------------------------------------------------------}

initialization

    {$ifdef __RegisterEnvisionPcx}
    RegisterDibGraphic('PCX', 'ZSoft PC Paintbrush', TPcxGraphic);
    RegisterDibGraphic('PCC', 'ZSoft PC Paintbrush', TPcxGraphic);
    {$endif}

finalization

end.

