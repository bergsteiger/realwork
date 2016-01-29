{----------------------------------------------------------------------------
|
| Library: Envision
|
| Module: EnCLib
|
| Description: Interface to 'C' library routines
|
| History: Oct 18, 1998. Michel Brazeau, first version (TIFF API)
|          Dec 30, 1998. MB add PNG API
|
|---------------------------------------------------------------------------}
unit EnCLib;

{$I Envision.Inc}

interface

uses
    EnMisc,   { for DWORD }
    Windows, SysUtils, Classes;

{--------------------------------------------------------------------------}

{ libTif API }

const

TIFFTAG_IMAGEWIDTH	     =	256;
TIFFTAG_IMAGELENGTH	     =	257;
TIFFTAG_BITSPERSAMPLE 	     =	258;
TIFFTAG_COMPRESSION	     =	259;
TIFFTAG_SAMPLESPERPIXEL	     =	277;
TIFFTAG_ROWSPERSTRIP	     =	278;
TIFFTAG_XRESOLUTION	     =	282;
TIFFTAG_YRESOLUTION	     =	283;
TIFFTAG_RESOLUTIONUNIT	     =	296;
TIFFTAG_PHOTOMETRIC	     =	262;
TIFFTAG_COLORMAP	     =	320;
TIFFTAG_PLANARCONFIG	     =	284;
TIFFTAG_GROUP3OPTIONS	     =	292;
TIFFTAG_SOFTWARE	     =	305;
TIFFTAG_DATETIME	     =	306;
TIFFTAG_PREDICTOR	     =	317;

GROUP3OPT_2DENCODING         =  $01;    { bit field }
RESUNIT_NONE		     =  1;
RESUNIT_INCH		     =  2;
RESUNIT_CENTIMETER	     =	3;

COMPRESSION_NONE             =     1;
COMPRESSION_CCITTRLE	     =     2;	{ CCITT modified Huffman RLE }
COMPRESSION_CCITTFAX3	     =     3;	{ CCITT Group 3 fax encoding }
COMPRESSION_CCITTFAX4	     =     4;	{ CCITT Group 4 fax encoding }
COMPRESSION_LZW              =     5;   { Lempel-Ziv  & Welch }
COMPRESSION_CCITTRLEW	     = 32771;	{ #1 w/ word alignment }
COMPRESSION_PACKBITS         = 32773;   { Packbits }
COMPRESSION_DEFLATE	     = 32946;   { ZLib }
COMPRESSION_JPEG             =     7;	{ %JPEG DCT compression }

{--------------------------------------------------------------------------}

type

TWordArray = packed array [0..(MaxLongInt-2) div 2] of Word;
TpWordArray = ^TWordArray;

TTiffHandle = Pointer;

TTiffOpenMode = (omRead, omWrite, omAppend);

function TIFFOpen( const Stream   : TStream;
                   const OpenMode : TTiffOpenMode ) : TTiffHandle;

procedure TIFFClose( TiffHandle : TTiffHandle);

function TIFFGetField(TiffHandle : TTiffHandle; Tag : LongInt; var Field) : Integer;

function TIFFGetField3( TiffHandle : TTiffHandle; Tag : LongInt;
                        var Field1; var Field2; var Field3 ) : Integer;

function TIFFSetIntField( TiffHandle : TTiffHandle; Tag : LongInt;
                          Field : LongInt ) : Integer;

function TIFFSetFloatField( TiffHandle : TTiffHandle; Tag : LongInt;
                            Field : Single ) : Integer;

function TIFFSetPCharField( TiffHandle : TTiffHandle; Tag : LongInt;
                            Field : PChar ) : Integer;

function TIFFSetColorMap( TiffHandle   : TTiffHandle;
                          pRedValues   : TpWordArray;
                          pGreenValues : TpWordArray;
                          pBlueValues  : TpWordArray ) : Integer;

function TIFFScanlineSize(TiffHandle : TTiffHandle) : LongInt;

function TIFFStripSize(TiffHandle : TTiffHandle) : LongInt;

function TIFFReadEncodedStrip( TiffHandle  : TTiffHandle;
                               StripNo     : LongInt;
                               pBuffer     : Pointer;
                               StripSize   : LongInt ) : LongInt;

function TIFFComputeStrip( TiffHandle : TTiffHandle;
                           RowNo      : LongInt;
                           SampleNo   : Word ) : LongInt;

function TIFFReadScanline( TiffHandle   : TTiffHandle;
                           pBuffer      : Pointer;
                           ScanLineSize : LongInt ) : Integer;

function TIFFWriteScanline( TiffHandle   : TTiffHandle;
                            pBuffer      : Pointer;
                            RowNo        : LongInt ) : Integer;

function TIFFIsTiled( TiffHandle : TTiffHandle) : Integer;

function TIFFReadRGBAImage( TiffHandle  : TTiffHandle;
                            ImageWidth  : LongInt;
                            ImageHeight : LongInt;
                            pBuffer     : Pointer;
                            StopOnError : Integer ) : Integer;

function TIFFSetDirectory( TiffHandle : TTiffHandle;
                           Directory  : Word ) : Integer;

function TiffImageCount( const TiffHandle : TTiffHandle ) : LongInt;

{--------------------------------------------------------------------------}

{ LibPng API }

const

Z_BEST_SPEED                = 1;
Z_MEDIUM                    = 5;
Z_BEST_COMPRESSION          = 9;

PNG_LIBPNG_VER_STRING       = '1.0.2';

PNG_RESOLUTION_UNKNOWN      = 0; { pixels/unknown unit (aspect ratio) }
PNG_RESOLUTION_METER        = 1; { pixels/meter }

PNG_INTERLACE_NONE          = 0;
PNG_INTERLACE_ADAM7         = 1;

PNG_FILTER_TYPE_BASE        = 0;

PNG_COMPRESSION_TYPE_BASE   = 0;

PNG_COLOR_MASK_PALETTE      = 1;
PNG_COLOR_MASK_COLOR        = 2;
PNG_COLOR_MASK_ALPHA        = 4;

PNG_BACKGROUND_GAMMA_SCREEN = 1;
PNG_BACKGROUND_GAMMA_FILE   = 2;

PNG_COLOR_TYPE_GRAY         = 0;
PNG_COLOR_TYPE_PALETTE      = (PNG_COLOR_MASK_COLOR or PNG_COLOR_MASK_PALETTE);
PNG_COLOR_TYPE_RGB          = (PNG_COLOR_MASK_COLOR);
PNG_COLOR_TYPE_RGB_ALPHA    = (PNG_COLOR_MASK_COLOR or PNG_COLOR_MASK_ALPHA);
PNG_COLOR_TYPE_GRAY_ALPHA   = (PNG_COLOR_MASK_ALPHA);

type

png_structp        = Pointer;
png_structpp       = ^png_structp;

png_infop          = Pointer;
png_infopp         = ^png_infop;

png_byte           = Byte;
png_bytep          = ^Byte;
png_bytepp         = ^png_bytep;

png_size_t         = LongInt;

png_uint_16        = Word;
png_uint_16p       = ^Word;

png_uint_32        = DWORD;
png_uint_32p       = ^png_uint_32;

png_voidp          = Pointer;
png_const_charp    = PChar;

png_color = packed record
   red    : png_byte;
   green  : png_byte;
   blue   : png_byte;
end;

png_colorp  = ^png_color;
png_colorpp = ^png_colorp;

png_palette   = packed array[0..255] of png_color;
png_palettep  = ^png_palette;
png_palettepp = ^png_palettep;

png_color_16 = packed record
   index    : Byte;
   red      : png_uint_16;   { for use in red green blue files }
   green    : png_uint_16;
   blue     : png_uint_16;
   gray     : png_uint_16;  { for use in grayscale files }
end;

png_color_16p  = ^png_color_16;
png_color_16pp = ^png_color_16p;

png_error_ptr = procedure( png_ptr : png_structp;
                           msg     : png_const_charp ); cdecl;

png_rw_ptr = procedure( png_ptr  : png_structp;
                        pbuffer  : png_bytep;
                        size     : png_size_t ); cdecl;

png_flush_ptr = procedure( png_ptr : png_structp); cdecl;

function png_sig_cmp( sig          : png_bytep;
                      start        : png_size_t;
                      num_to_check : png_size_t ) : Integer;

function png_create_read_struct( user_png_ver : png_const_charp;
                                 error_ptr    : png_voidp;
                                 error_fn     : png_error_ptr;
                                 warn_fn      : png_error_ptr
                               ) : png_structp;

function png_create_write_struct( user_png_ver : png_const_charp;
                                  error_ptr    : png_voidp;
                                  error_fn     : png_error_ptr;
                                  warn_fn      : png_error_ptr
                                ) : png_structp;

function png_create_info_struct(png_ptr : png_structp) : png_infop;

procedure png_destroy_read_struct( png_ptr_ptr      : png_structpp;
                                   info_ptr_ptr     : png_infopp;
                                   end_info_ptr_ptr : png_infopp );

procedure png_destroy_write_struct( png_ptr_ptr      : png_structpp;
                                    info_ptr_ptr     : png_infopp );

function png_get_rowbytes( png_ptr    : png_structp;
                           info_ptr   : png_infop ) : png_uint_32;

procedure png_read_update_info( png_ptr   : png_structp;
                                info_ptr  : png_infop );

procedure png_set_sig_bytes( png_ptr   : png_structp;
                             num_bytes : Integer );

procedure png_set_read_fn( png_ptr      : png_structp;
                           io_ptr       : png_voidp;
                           read_data_fn : png_rw_ptr );

procedure png_set_write_fn( png_ptr         : png_structp;
                            io_ptr          : png_voidp;
                            write_data_fn   : png_rw_ptr;
                            output_flush_fn : png_flush_ptr );

function png_get_io_ptr(png_ptr : png_structp) : png_voidp;

procedure png_read_info( png_ptr    : png_structp;
                         info_ptr   : png_infop );

function  png_get_IHDR( png_ptr          : png_structp;
                        info_ptr         : png_infop;
                        width            : png_uint_32p;
                        height           : png_uint_32p;
                        bit_depth        : PInteger;
                        color_type       : PInteger;
                        interlace_type   : PInteger;
                        compression_type : PInteger;
                        filter_type      : PInteger ) : png_uint_32;

procedure png_set_IHDR( png_ptr          : png_structp;
                        info_ptr         : png_infop;
                        width            : png_uint_32;
                        height           : png_uint_32;
                        bit_depth        : Integer;
                        color_type       : Integer;
                        interlace_type   : Integer;
                        compression_type : Integer;
                        filter_type      : Integer );

function png_get_PLTE( png_ptr         : png_structp;
                       info_ptr        : png_infop;
                       palette_ptr_ptr : png_palettepp;
                       num_palette     : PInteger ) : png_uint_32;

procedure png_set_PLTE( png_ptr     : png_structp;
                        info_ptr    : png_infop;
                        palette_ptr : png_colorp;
                        num_palette : Integer );

function png_get_gAMA( png_ptr    : png_structp;
                       info_ptr   : png_infop;
                       file_gamma : PDouble ) : png_uint_32;

procedure png_set_gAMA( png_ptr    : png_structp;
                        info_ptr   : png_infop;
                        file_gamma : Double );

procedure png_set_gamma( png_ptr            : png_structp;
                         screen_gamma       : double;
                         default_file_gamma : double );

function png_get_pHYs( png_ptr      : png_structp;
                       info_ptr     : png_infop;
                       res_x        : png_uint_32p;
                       res_y        : png_uint_32p;
                       unit_type    : PInteger ) : png_uint_32;

procedure png_set_pHYs( png_ptr   : png_structp;
                        info_ptr  : png_infop;
                        res_x     : png_uint_32;
                        res_y     : png_uint_32;
                        unit_type : Integer );

function png_get_oFFs( png_ptr     : png_structp;
                       info_ptr    : png_infop;
                       offset_x    : png_uint_32p;
                       offset_y    : png_uint_32p;
                       unit_type   : PInteger ) : png_uint_32;

procedure png_set_strip_16( png_ptr : png_structp );

procedure png_set_packing( png_ptr : png_structp );

procedure png_set_bgr( png_ptr : png_structp );

function png_get_bKGD( png_ptr      : png_structp;
                       info_ptr     : png_infop;
                       background   : png_color_16pp ) : png_uint_32;

procedure png_set_bKGD( png_ptr    : png_structp;
                        info_ptr   : png_infop;
                        background : png_color_16p );

procedure png_set_background( png_ptr               : png_structp;
                              background_color      : png_color_16p;
                              background_gamma_code : Integer;
                              need_expand           : Integer;
                              background_gamma      : Double );

procedure png_set_swap( png_ptr : png_structp );

procedure png_set_packswap( png_ptr : png_structp );

function png_set_interlace_handling( png_ptr :png_structp ) : Integer;

procedure png_read_row( png_ptr      : png_structp;
                        row          : png_bytep;
                        display_row  : png_bytep );

procedure png_write_row( png_ptr   : png_structp;
                         row       : png_bytep );

procedure png_write_info( png_ptr  : png_structp;
                          info_ptr : png_infop );

procedure png_write_end( png_ptr  : png_structp;
                         info_ptr : png_infop );

procedure png_read_image( png_ptr     : png_structp;
                          image       : png_bytepp );

procedure png_read_end( png_ptr    : png_structp;
                        info_ptr   : png_infop );

function png_get_sRGB( png_ptr    : png_structp;
                       info_ptr   : png_infop;
                       intent     : PInteger ) : png_uint_32;

procedure png_set_sRGB( png_ptr    : png_structp;
                        info_ptr   : png_infop;
                        intent     : Integer  );

function png_get_valid( png_ptr    : png_structp;
                        info_ptr   : png_infop;
                        flag       : png_uint_32 ) : png_uint_32;

procedure png_set_compression_level( png_ptr : png_structp;
                                     level   : Integer );

{--------------------------------------------------------------------------}

{ LibJpeg API }

const

JCS_UNKNOWN	   = 0;
JCS_GRAYSCALE	   = 1;	{ monochrome }
JCS_RGB	           = 2; { red/green/blue }
JCS_YCbCr	   = 3;	{ Y/Cb/Cr (also known as YUV) }
JCS_CMYK	   = 4;	{ C/M/Y/K }
JCS_YCCK	   = 5;	{ Y/Cb/Cr/K }


JPEG_DOTSPERINCH   = 1;
JPEG_DOTSPERCM     = 2;

type

PCardinal = ^Cardinal;

j_error_mgr_ptr      = Pointer;
j_error_mgr_ptr_ptr  = ^j_error_mgr_ptr;

j_decompress_ptr     = Pointer;
j_decompress_ptr_ptr = ^j_decompress_ptr;

j_compress_ptr     = Pointer;
j_compress_ptr_ptr = ^j_compress_ptr;

procedure jpeg_init_decompress( error_mgr_ptr_ptr   : j_error_mgr_ptr_ptr;
	                        decompress_ptr_ptr : j_decompress_ptr_ptr );

procedure jpeg_decompress_done( error_mgr_ptr   : j_error_mgr_ptr;
	                        decompress_ptr : j_decompress_ptr );

procedure jpeg_init_compress( error_mgr_ptr_ptr : j_error_mgr_ptr_ptr;
	                      compress_ptr_ptr : j_compress_ptr_ptr );

procedure jpeg_compress_done( error_mgr_ptr : j_error_mgr_ptr;
	                      compress_ptr : j_compress_ptr );

procedure jpeg_stdio_src( cinfo    : j_decompress_ptr;
                          infile   : Pointer );

procedure jpeg_stdio_dest( cinfo    : j_compress_ptr;
                           infile   : Pointer );

function jpeg_read_header( cinfo         : j_decompress_ptr;
                           require_image : Integer ) :  Integer;

function jpeg_start_decompress(cinfo : j_decompress_ptr ) : Integer;
function jpeg_finish_decompress(cinfo : j_decompress_ptr ) : Integer;

procedure jpeg_start_compress( cinfo            : j_compress_ptr;
                               write_all_tables : Integer  );
procedure jpeg_finish_compress(cinfo : j_compress_ptr );

procedure jpeg_get_info( cinfo          : j_decompress_ptr;
                         Width          : PCardinal;
                         Height         : PCardinal;
                         Components     : PInteger;
                         ResUnit        : PByte;
                         XRes           : PSmallInt;
                         YRes           : PSmallInt;
                         FileColorSpace : PInteger );

procedure jpeg_set_info( cinfo            : j_compress_ptr;
                         Width            : Cardinal;
                         Height           : Cardinal;
                         Components       : Integer;
                         ResUnit          : Byte;
                         XRes             : SmallInt;
                         YRes             : SmallInt;
                         FileColorSpace   : Integer;
                         Quality          : Integer;
                         Progressive      : Integer;
                         OptimizedHuffman : Integer );

function jpeg_read_scanlines( cinfo     : j_decompress_ptr;
			      scanlines : Pointer;
			      max_lines : Cardinal ) : Cardinal;

function jpeg_write_scanlines( cinfo      : j_compress_ptr;
                               scanlines  : Pointer;
                               num_lines  : Cardinal ) : Cardinal;

procedure jpeg_set_out_colorspace( cinfo      : j_decompress_ptr;
                                   colorspace : Integer );

{--------------------------------------------------------------------------}

{ GBM API }
type

TGbmFt = packed record
    ShortName  : PChar;    { Eg: "Targa"  }
    LongName   : PChar;    { Eg: "Truevision Targa / Vista" }
    Extensions : PChar;    { Eg: "TGA VST" }
    Flags      : Integer;  { What functionality exists }
end;

TpGbmRgb = ^TGbmRgb;
TGbmRgb = packed record
    R  : Byte;
    G  : Byte;
    B  : Byte;
end;

TGbmPalette = array[0..255] of TGbmRgb;

const PRIV_SIZE = 2000;

type

TpGbm = ^TGbm;
TGbm = packed record
    W    : Integer;
    H    : Integer;
    Bpp  : Integer;
    Priv : array[0..(PRIV_SIZE-1)] of Byte;
end;

TGbm_Err = Integer;

const
    GBM_ERR_OK	        = 0;
    GBM_ERR_MEM         = 1;
    GBM_ERR_NOT_SUPP    = 2;
    GBM_ERR_BAD_OPTION  = 3;
    GBM_ERR_NOT_FOUND   = 4;
    GBM_ERR_BAD_MAGIC   = 5;
    GBM_ERR_BAD_SIZE    = 6;
    GBM_ERR_READ        = 7;
    GBM_ERR_WRITE       = 8;
    GBM_ERR_BAD_ARG     = 9;

    GBM_FT_R1		= $0001;
    GBM_FT_R4		= $0002;
    GBM_FT_R8		= $0004;
    GBM_FT_R24		= $0008;
    GBM_FT_W1		= $0010;
    GBM_FT_W4		= $0020;
    GBM_FT_W8		= $0040;
    GBM_FT_W24		= $0080;

function gbm_init   : Integer;
function gbm_deinit : Integer;

{
 int   gbm_io_open  (const char *fn, int mode);
 int   gbm_io_create(const char *fn, int mode);
 void  gbm_io_close (int fd);
 long  gbm_io_lseek (int fd, long pos, int whence);
 int   gbm_io_read  (int fd, void *buf, int len);
 int   gbm_io_write (int fd, const void *buf, int len);

 GBM_ERR  gbm_query_n_filetypes(int *n_ft);
 GBM_ERR  gbm_query_filetype(int ft, GBMFT *gbmft);

 GBM_ERR  gbm_read_header(const char *fn, int fd, int ft, GBM *gbm, const char *opt);
 GBM_ERR  gbm_read_palette(int fd, int ft, GBM *gbm, GBMRGB *gbmrgb);
 GBM_ERR  gbm_read_data(int fd, int ft, GBM *gbm, byte *data);
 GBM_ERR  gbm_write(const char *fn, int fd, int ft, const GBM *gbm, const GBMRGB *gbmrgb, const byte *data, const char *opt);
}
function gbm_guess_filetype( const FileName : PChar;
                                   FileType : PInteger ) : TGbm_Err;

function gbm_read_header( const FileName   : PChar;
                                FileHandle : Integer;
                                FileType   : Integer;
                                GbmPtr     : TpGbm;
                          const Options    : PChar ) : TGbm_Err;

function gbm_read_palette( FileHandle  : Integer;
                           FileType    : Integer;
                           GbmPtr      : TpGbm;
                           PalettePtr  : TpGbmRgb ) : TGbm_Err;

function gbm_read_data( FileHandle  : Integer;
                        FileType    : Integer;
                        GbmPtr      : TpGbm;
                        pData       : Pointer ) : TGbm_Err;

function gbm_write( const FileName   : PChar;
                          FileHandle : Integer;
                          FileType   : Integer;
                    const GbmPtr     : TpGbm;
                    const PalettePtr : TpGbmRgb;
                    const pData      : Pointer;
                    const Options    : PChar ) : TGbm_Err;

(*

{ LibGif API }

const

GIF_ERROR	= 0;
GIF_OK		= 1;

type

GifBooleanType = Integer;
GifPixelType   = Byte;
GifRowType     = PByteArray;
GifByteType    = Byte;

GifColorType = packed record
    Red, Green, Blue : GifByteType;
end;

GifColorArray = array[0..255] of GifColorType;
PGifColorArray = ^GifColorArray;

ColorMapObject = packed record
    ColorCount   : Integer;
    BitsPerPixel : Integer;
    Colors       : ^GifColorArray;
end;
PColorMapObject = ^ColorMapObject;

ExtensionBlock = packed record
    ByteCount  : Integer;
    Bytes      : PByteArray;
    Func       : Integer;
end;

ExtensionBlockArray = array[0..10000] of ExtensionBlock;

GifImageDesc = packed record
    Left, Top,
    Width, Height,
    Interlace       : Integer;
    ColorMap        : ^ColorMapObject;
end;

SavedImage = packed record
    ImageDesc           : GifImageDesc;

    RasterBits          : PByteArray;

    GifFunction         : Integer;
    ExtensionBlockCount : Integer;
    ExtensionBlocks     : ^ExtensionBlockArray;
end;
PSavedImage = ^SavedImage;

SavedImageArray = array[0..10000] of SavedImage;

GifFileType = packed record
    SWidth, SHeight,		  { Screen dimensions. }
    SColorResolution, 		  { How many colors can we generate? }
    SBackGroundColor   : Integer;
    SColorMap          : ^ColorMapObject; { global color map }
    ImageCount         : Integer;
    Image              : GifImageDesc;
    SavedImages        : ^SavedImageArray;
    PrivateData        : Pointer;
end;
PGifFileType = ^GifFileType;

GifRecordType = (
    UNDEFINED_RECORD_TYPE,
    SCREEN_DESC_RECORD_TYPE,
    IMAGE_DESC_RECORD_TYPE,		{ Begin with ',' }
    EXTENSION_RECORD_TYPE,		{ Begin with '!' }
    TERMINATE_RECORD_TYPE		{ Begin with ';' }
    );


function EGifOpenFileHandle( Stream : TStream) : PGifFileType;

function EGifSpew( GifFile : PGifFileType) : Integer;

function DGifOpenFileHandle( Stream : TStream) : PGifFileType;
function DGifSlurp( GifFile : PGifFileType) : Integer;
function DGifCloseFile(GifFile : PGifFileType) : Integer;

function MakeMapObject(ColorCount : Integer; Colors : PGifColorArray) : PColorMapObject;
procedure FreeMapObject(ColorMap : PColorMapObject);

function MakeSavedImage( GifFile  : PGifFileType;
                         CopyFrom : PSavedImage) : PSavedImage;
*)

{--------------------------------------------------------------------------}

implementation

uses
    EnCRtl,   { to satisfy external references }
    EnTifGr;  { for RaiseTiffError }

{--------------------------------------------------------------------------}

type

PointerPtr = ^Pointer;
LongIntPtr = ^LongInt;

{--------------------------------------------------------------------------}

TTiffReadWriteProc = function( Handle : LongInt;
                               pBuffer : Pointer;
                               Size    : LongInt ) : LongInt; cdecl;

{--------------------------------------------------------------------------}

TTiffSeekProc = function( Handle : LongInt;
                          Offset : LongInt;
                          Origin : Integer ) : LongInt; cdecl;

{--------------------------------------------------------------------------}

TTiffCloseProc = function( Handle : LongInt ) : Integer; cdecl;

{--------------------------------------------------------------------------}

TTiffSizeProc = function( Handle : LongInt ) : LongInt; cdecl;

{--------------------------------------------------------------------------}

TTiffMapFileProc = function( Handle : LongInt;
                             pBase  : PointerPtr;
                             pSize  : LongIntPtr ) : Integer; cdecl;

{--------------------------------------------------------------------------}

TTiffUnmapFileProc = procedure( Handle : LongInt;
                                Base   : Pointer;
                                Size   : LongInt ); cdecl;

{--------------------------------------------------------------------------}

{$L Envision.Obj}
{$L Deflate.Obj}
{$L Inflate.Obj}
{$L Trees.Obj}

function _TIFFOpen( const FileName : PChar;
                    const OpenMode : PChar ) : TTiffHandle;
    cdecl; external;

{--------------------------------------------------------------------------}

function _TIFFClientOpen( const Name : PChar;
                          const OpenMode : PChar;
                          Handle : LongInt;
                          ReadProc : TTiffReadWriteProc;
                          WriteProc : TTiffReadWriteProc;
                          SeekProc  : TTiffSeekProc;
                          CloseProc : TTiffCloseProc;
                          SizeProc  : TTiffSizeProc;
                          MapFileProc : TTiffMapFileProc;
                          UnmapFileProc : TTiffUnmapFileProc ) : TTiffHandle;
    cdecl; external;

{--------------------------------------------------------------------------}

procedure _TIFFClose( TiffHandle : TTiffHandle);
    cdecl; external;

{--------------------------------------------------------------------------}

function _TIFFGetField(TiffHandle : TTiffHandle; Tag : LongInt; var Field) : Integer;
    cdecl; external;

{--------------------------------------------------------------------------}

function _TIFFGetField3( TiffHandle : TTiffHandle; Tag : LongInt;
                        var Field1; var Field2; var Field3 ) : Integer;
    cdecl; external;

{--------------------------------------------------------------------------}

function _TIFFSetIntField(TiffHandle : TTiffHandle; Tag : LongInt; Field : LongInt) : Integer;
    cdecl; external;

{--------------------------------------------------------------------------}

function _TIFFSetFloatField( TiffHandle : TTiffHandle; Tag : LongInt;
                            Field : Single ) : Integer;
    cdecl; external;

{--------------------------------------------------------------------------}

function _TIFFSetPCharField(TiffHandle : TTiffHandle; Tag : LongInt; Field : PChar) : Integer;
    cdecl; external;

{--------------------------------------------------------------------------}

function _TIFFSetColorMap( TiffHandle   : TTiffHandle;
                           pRedValues   : Pointer;
                           pGreenValues : Pointer;
                           pBlueValues  : Pointer ) : Integer;
    cdecl; external;

{--------------------------------------------------------------------------}

function _TIFFScanlineSize(TiffHandle : TTiffHandle) : LongInt;
    cdecl; external;

{--------------------------------------------------------------------------}

function _TIFFStripSize(TiffHandle : TTiffHandle) : LongInt;
    cdecl; external;

{--------------------------------------------------------------------------}

function _TIFFReadEncodedStrip( TiffHandle  : TTiffHandle;
                               StripNo     : LongInt;
                               pBuffer     : Pointer;
                               StripSize   : LongInt ) : LongInt;
    cdecl; external;

{--------------------------------------------------------------------------}

function _TIFFComputeStrip( TiffHandle : TTiffHandle;
                           RowNo      : LongInt;
                           SampleNo   : Word ) : LongInt;
    cdecl; external;

{--------------------------------------------------------------------------}

function _TIFFReadScanline( TiffHandle   : TTiffHandle;
                            pBuffer      : Pointer;
                            ScanLineSize : LongInt ) : Integer;
    cdecl; external;

{--------------------------------------------------------------------------}

function _TIFFWriteScanline( TiffHandle   : TTiffHandle;
                             pBuffer      : Pointer;
                             RowNo        : LongInt;
                             Sample       : Word ) : Integer;
    cdecl; external;

{--------------------------------------------------------------------------}

function _TIFFIsTiled( TiffHandle : TTiffHandle) : Integer;
    cdecl; external;

{--------------------------------------------------------------------------}

function _TIFFReadRGBAImage( TiffHandle  : TTiffHandle;
                            ImageWidth  : LongInt;
                            ImageHeight : LongInt;
                            pBuffer     : Pointer;
                            StopOnError : Integer ) : Integer;
    cdecl; external;

{--------------------------------------------------------------------------}

function _TIFFSetDirectory( TiffHandle : TTiffHandle;
                            Directory  : Word ) : Integer;
    cdecl; external;

{--------------------------------------------------------------------------}

function _TIFFReadDirectory( TiffHandle : TTiffHandle ) : Integer;
    cdecl; external;

{--------------------------------------------------------------------------}

{ functions used within OBJ's. Must be defined external to satisfy Delphi
  linker. }
function _deflate : Integer;
    stdcall; external;
function _deflateEnd : Integer;
    stdcall; external;
function _inflate : Integer;
    stdcall; external;
function _inflateEnd : Integer;
    stdcall; external;
function _deflateReset : Integer;
    stdcall; external;
function _deflateParams : Integer;
    stdcall; external;
function _inflateSync : Integer;
    stdcall; external;
function _inflateReset : Integer;
    stdcall; external;
function _deflateInit_ : Integer;
    stdcall; external;
function _inflateInit_ : Integer;
    stdcall; external;
function _adler32 : LongInt;
    stdcall; external;
procedure _z_errmsg;
    stdcall; external;
function _zcalloc : Pointer;
    cdecl; external;
procedure _zcfree;
    cdecl; external;
procedure __TIFFmemcpy;
    cdecl; external;
procedure __TIFFmemset;
    cdecl; external;
function _inflate_blocks_new : pointer;
    cdecl; external;
function _inflate_blocks : integer;
    cdecl; external;
procedure _inflate_blocks_reset;
    cdecl; external;
function _inflate_blocks_free : integer;
    cdecl; external;
procedure _inflate_set_dictionary;
    cdecl; external;
function _inflate_blocks_sync_point : integer;
    cdecl; external;

{--------------------------------------------------------------------------}

function TiffReadProc ( Handle : LongInt;
                        pBuffer : Pointer;
                        Size    : LongInt ) : LongInt; cdecl;
begin
    Result := TStream(Handle).Read( pBuffer^, Size );
end;

{--------------------------------------------------------------------------}

function TiffWriteProc( Handle : LongInt;
                        pBuffer : Pointer;
                        Size    : LongInt ) : LongInt; cdecl;
begin
    Result := TStream(Handle).Write( pBuffer^, Size );
end;

{--------------------------------------------------------------------------}

function TiffSeekProc( Handle : LongInt;
                       Offset : LongInt;
                       Origin : Integer ) : LongInt; cdecl;
begin
    Result := TStream(Handle).Seek(Offset, Origin);
end;

{--------------------------------------------------------------------------}

function TiffCloseProc( Handle : LongInt ) : Integer; cdecl;
begin
    Result := 0;
end;

{--------------------------------------------------------------------------}

function TiffSizeProc( Handle : LongInt ) : LongInt; cdecl;
begin
    Result := TStream(Handle).Size;
end;

{--------------------------------------------------------------------------}

function TiffMapProc( Handle : LongInt;
                      pBase  : PointerPtr;
                      pSize  : LongIntPtr ) : Integer; cdecl;
begin
    Result := 0;
end;

{--------------------------------------------------------------------------}

procedure TiffUnmapProc( Handle : LongInt;
                         Base   : Pointer;
                         Size   : LongInt ); cdecl;
begin
end;

{--------------------------------------------------------------------------}

function TiffImageCount( const TiffHandle : TTiffHandle ) : LongInt;
begin
    Result := 0;
    _TIFFSetDirectory(TiffHandle, 0);
    repeat
        Inc(Result);
    until (_TIFFReadDirectory(TiffHandle) = 0);
end;

{--------------------------------------------------------------------------}

function TIFFOpen( const Stream   : TStream;
                   const OpenMode : TTiffOpenMode ) : TTiffHandle;
var
    Mode : String;
begin
    case OpenMode of
        omRead   : Mode := 'r';
        omWrite  : Mode := 'w';
        omAppend : Mode := 'a';
    end;

    Result := _TIFFClientOpen( PChar(''), PChar(Mode), LongInt(Stream),
                               TiffReadProc, TiffWriteProc,
                               TiffSeekProc, TiffCloseProc, TiffSizeProc,
                               TiffMapProc, TiffUnmapProc );
end;

{--------------------------------------------------------------------------}

procedure TIFFClose( TiffHandle : TTiffHandle);
begin
    _TIFFClose(TiffHandle);
end;

{--------------------------------------------------------------------------}

function TIFFGetField(TiffHandle : TTiffHandle; Tag : LongInt; var Field) : Integer;
begin
    Result := _TIFFGetField(TiffHandle, Tag, Field);
    if Result = 0 then
        RaiseTiffError('TIFFGetField: Tag = ' + IntToStr(Tag));
end;

{--------------------------------------------------------------------------}

function TIFFGetField3( TiffHandle : TTiffHandle; Tag : LongInt;
                        var Field1; var Field2; var Field3 ) : Integer;
begin
    Result := _TIFFGetField3(TiffHandle, Tag, Field1, Field2, Field3);
    if Result = 0 then
        RaiseTiffError('TIFFGetField3: Tag = ' + IntToStr(Tag));
end;

{--------------------------------------------------------------------------}

function TIFFSetIntField(TiffHandle : TTiffHandle; Tag : LongInt; Field : LongInt) : Integer;
begin
    Result := _TIFFSetIntField(TiffHandle, Tag, Field);
    if Result = 0 then
        RaiseTiffError('TIFFSetIntField: Tag = ' + IntToStr(Tag));
end;

{--------------------------------------------------------------------------}

function TIFFSetFloatField(TiffHandle : TTiffHandle; Tag : LongInt; Field : Single) : Integer;
begin
    Result := _TIFFSetFloatField(TiffHandle, Tag, Field);
    if Result = 0 then
        RaiseTiffError('TIFFSetFloatField: Tag = ' + IntToStr(Tag));
end;

{--------------------------------------------------------------------------}

function TIFFSetPCharField(TiffHandle : TTiffHandle; Tag : LongInt; Field : PChar) : Integer;
begin
    Result := _TIFFSetPCharField(TiffHandle, Tag, Field);
    if Result = 0 then
        RaiseTiffError('TIFFSetField: Tag = ' + IntToStr(Tag));
end;

{--------------------------------------------------------------------------}

function TIFFSetColorMap( TiffHandle   : TTiffHandle;
                          pRedValues   : TpWordArray;
                          pGreenValues : TpWordArray;
                          pBlueValues  : TpWordArray ) : Integer;
begin
    Result := _TIFFSetColorMap(TiffHandle, pRedValues, pGreenValues, pBlueValues);
    if Result = 0 then
        RaiseTiffError('TIFFSetColormap');
end;

{--------------------------------------------------------------------------}

function TIFFScanlineSize(TiffHandle : TTiffHandle) : LongInt;
begin
    Result := _TIFFScanLineSize(TiffHandle);
end;

{--------------------------------------------------------------------------}

function TIFFStripSize(TiffHandle : TTiffHandle) : LongInt;
begin
    Result := _TIFFStripSize(TiffHandle);
end;

{--------------------------------------------------------------------------}

function TIFFReadEncodedStrip( TiffHandle  : TTiffHandle;
                               StripNo     : LongInt;
                               pBuffer     : Pointer;
                               StripSize   : LongInt ) : LongInt;
begin
    Result := _TIFFReadEncodedStrip( TiffHandle,
                                     StripNo,
                                     pBuffer,
                                     StripSize );
end;

{--------------------------------------------------------------------------}

function TIFFComputeStrip( TiffHandle : TTiffHandle;
                           RowNo      : LongInt;
                           SampleNo   : Word ) : LongInt;
begin
    Result := _TIFFComputeStrip( TiffHandle, RowNo, SampleNo );
end;

{--------------------------------------------------------------------------}

function TIFFReadScanline( TiffHandle   : TTiffHandle;
                           pBuffer      : Pointer;
                           ScanLineSize : LongInt ) : Integer;
begin
    Result := _TIFFReadScanLine( TiffHandle, pBuffer, ScanLineSize );
end;

{--------------------------------------------------------------------------}

function TIFFWriteScanline( TiffHandle   : TTiffHandle;
                            pBuffer      : Pointer;
                            RowNo        : LongInt ) : Integer;
begin
    Result := _TIFFWriteScanLine( TiffHandle, pBuffer, RowNo, 0 );
end;

{--------------------------------------------------------------------------}

function TIFFIsTiled( TiffHandle : TTiffHandle) : Integer;
begin
    Result := _TIFFIsTiled(TiffHandle);
end;

{--------------------------------------------------------------------------}

function TIFFReadRGBAImage( TiffHandle  : TTiffHandle;
                            ImageWidth  : LongInt;
                            ImageHeight : LongInt;
                            pBuffer     : Pointer;
                            StopOnError : Integer ) : Integer;
begin
    Result := _TIFFReadRGBAImage( TiffHandle,
                                  ImageWidth, ImageHeight,
                                  pBuffer, StopOnError );
end;

{--------------------------------------------------------------------------}

function TIFFSetDirectory( TiffHandle : TTiffHandle;
                           Directory  : Word ) : Integer;
begin
    Result := _TIFFSetDirectory(TiffHandle, Directory);
end;

{--------------------------------------------------------------------------}

function _png_sig_cmp( sig          : png_bytep;
                       start        : png_size_t;
                       num_to_check : png_size_t ) : Integer; cdecl; external;

function png_sig_cmp( sig          : png_bytep;
                      start        : png_size_t;
                      num_to_check : png_size_t ) : Integer;
begin
    Result := _png_sig_cmp(sig, start, num_to_check);
end;

{--------------------------------------------------------------------------}

function _png_create_read_struct( user_png_ver : png_const_charp;
                                  error_ptr    : png_voidp;
                                  error_fn     : png_error_ptr;
                                  warn_fn      : png_error_ptr
                                ) : png_structp; cdecl; external;

function png_create_read_struct( user_png_ver : png_const_charp;
                                 error_ptr    : png_voidp;
                                 error_fn     : png_error_ptr;
                                 warn_fn      : png_error_ptr
                               ) : png_structp;
begin
    Result := _png_create_read_struct( user_png_ver,
                                       error_ptr,
                                       error_fn, warn_fn );
end;

{--------------------------------------------------------------------------}

function _png_create_write_struct( user_png_ver : png_const_charp;
                                   error_ptr    : png_voidp;
                                   error_fn     : png_error_ptr;
                                   warn_fn      : png_error_ptr
                                 ) : png_structp; cdecl; external;

function png_create_write_struct( user_png_ver : png_const_charp;
                                  error_ptr    : png_voidp;
                                  error_fn     : png_error_ptr;
                                  warn_fn      : png_error_ptr
                                ) : png_structp;
begin
    Result := _png_create_write_struct( user_png_ver,
                                        error_ptr,
                                        error_fn, warn_fn );
end;

{--------------------------------------------------------------------------}

function _png_create_info_struct(png_ptr : png_structp) : png_infop; cdecl; external;

function png_create_info_struct(png_ptr : png_structp) : png_infop;
begin
    Result := _png_create_info_struct(png_ptr);
end;

{--------------------------------------------------------------------------}

procedure _png_destroy_read_struct( png_ptr_ptr      : png_structpp;
                                    info_ptr_ptr     : png_infopp;
                                    end_info_ptr_ptr : png_infopp ); cdecl; external;

procedure png_destroy_read_struct( png_ptr_ptr      : png_structpp;
                                   info_ptr_ptr     : png_infopp;
                                   end_info_ptr_ptr : png_infopp );
begin
    _png_destroy_read_struct(png_ptr_ptr, info_ptr_ptr, end_info_ptr_ptr);
end;

{--------------------------------------------------------------------------}

procedure _png_destroy_write_struct( png_ptr_ptr      : png_structpp;
                                     info_ptr_ptr     : png_infopp ); cdecl; external;

procedure png_destroy_write_struct( png_ptr_ptr      : png_structpp;
                                   info_ptr_ptr     : png_infopp );
begin
    _png_destroy_write_struct(png_ptr_ptr, info_ptr_ptr);
end;

{--------------------------------------------------------------------------}

function _png_get_rowbytes( png_ptr    : png_structp;
                            info_ptr   : png_infop ) : png_uint_32; cdecl; external;

function png_get_rowbytes( png_ptr    : png_structp;
                           info_ptr   : png_infop ) : png_uint_32;
begin
    Result := _png_get_rowbytes(png_ptr, info_ptr);
end;

{--------------------------------------------------------------------------}

procedure _png_read_update_info( png_ptr   : png_structp;
                                 info_ptr  : png_infop ); cdecl; external;

procedure png_read_update_info( png_ptr   : png_structp;
                                info_ptr  : png_infop );
begin
    _png_read_update_info(png_ptr, info_ptr);
end;

{--------------------------------------------------------------------------}

procedure _png_set_sig_bytes( png_ptr   : png_structp;
                              num_bytes : Integer ); cdecl; external;

procedure png_set_sig_bytes( png_ptr   : png_structp;
                             num_bytes : Integer );
begin
    _png_set_sig_bytes(png_ptr, num_bytes);
end;

{--------------------------------------------------------------------------}

procedure _png_set_read_fn( png_ptr      : png_structp;
                            io_ptr       : png_voidp;
                            read_data_fn : png_rw_ptr ); cdecl; external;

procedure png_set_read_fn( png_ptr      : png_structp;
                           io_ptr       : png_voidp;
                           read_data_fn : png_rw_ptr );
begin
    _png_set_read_fn(png_ptr, io_ptr, read_data_fn);
end;

{--------------------------------------------------------------------------}

procedure _png_set_write_fn( png_ptr         : png_structp;
                             io_ptr          : png_voidp;
                             write_data_fn   : png_rw_ptr;
                             output_flush_fn : png_flush_ptr ); cdecl; external;

procedure png_set_write_fn( png_ptr         : png_structp;
                            io_ptr          : png_voidp;
                            write_data_fn   : png_rw_ptr;
                            output_flush_fn : png_flush_ptr );
begin
    _png_set_write_fn( png_ptr, io_ptr, write_data_fn, output_flush_fn);
end;

{--------------------------------------------------------------------------}

function _png_get_io_ptr(png_ptr : png_structp) : png_voidp; cdecl; external;

function png_get_io_ptr(png_ptr : png_structp) : png_voidp;
begin
    Result := _png_get_io_ptr(png_ptr);
end;

{--------------------------------------------------------------------------}

procedure _png_read_info( png_ptr    : png_structp;
                          info_ptr   : png_infop ); cdecl; external;

procedure png_read_info( png_ptr    : png_structp;
                         info_ptr   : png_infop );
begin
    _png_read_info(png_ptr, info_ptr);
end;

{--------------------------------------------------------------------------}

function _png_get_IHDR( png_ptr          : png_structp;
                        info_ptr         : png_infop;
                        width            : png_uint_32p;
                        height           : png_uint_32p;
                        bit_depth        : PInteger;
                        color_type       : PInteger;
                        interlace_type   : PInteger;
                        compression_type : PInteger;
                        filter_type      : PInteger ) : png_uint_32; cdecl; external;

function png_get_IHDR( png_ptr          : png_structp;
                       info_ptr         : png_infop;
                       width            : png_uint_32p;
                       height           : png_uint_32p;
                       bit_depth        : PInteger;
                       color_type       : PInteger;
                       interlace_type   : PInteger;
                       compression_type : PInteger;
                       filter_type      : PInteger ) : png_uint_32;
begin
    Result := _png_get_IHDR( png_ptr, info_ptr,
                             width, height,
                             bit_depth, color_type,
                             interlace_type, compression_type,
                             filter_type );
end;

{--------------------------------------------------------------------------}

procedure _png_set_IHDR( png_ptr          : png_structp;
                         info_ptr         : png_infop;
                         width            : png_uint_32;
                         height           : png_uint_32;
                         bit_depth        : Integer;
                         color_type       : Integer;
                         interlace_type   : Integer;
                         compression_type : Integer;
                         filter_type      : Integer ); cdecl; external;

procedure png_set_IHDR( png_ptr          : png_structp;
                        info_ptr         : png_infop;
                        width            : png_uint_32;
                        height           : png_uint_32;
                        bit_depth        : Integer;
                        color_type       : Integer;
                        interlace_type   : Integer;
                        compression_type : Integer;
                        filter_type      : Integer );
begin
    _png_set_IHDR( png_ptr, info_ptr, width, height,
                   bit_depth, color_type, interlace_type,
                   compression_type, filter_type );
end;

{--------------------------------------------------------------------------}

procedure _png_set_gamma( png_ptr            : png_structp;
                          screen_gamma       : double;
                          default_file_gamma : double ); cdecl; external;

procedure png_set_gamma( png_ptr            : png_structp;
                         screen_gamma       : double;
                         default_file_gamma : double );
begin
    _png_set_gamma(png_ptr, screen_gamma, default_file_gamma);
end;

{--------------------------------------------------------------------------}

function _png_get_pHYs( png_ptr      : png_structp;
                        info_ptr     : png_infop;
                        res_x        : png_uint_32p;
                        res_y        : png_uint_32p;
                        unit_type    : PInteger ) : png_uint_32; cdecl; external;

function png_get_pHYs( png_ptr      : png_structp;
                       info_ptr     : png_infop;
                       res_x        : png_uint_32p;
                       res_y        : png_uint_32p;
                       unit_type    : PInteger ) : png_uint_32;
begin
    Result := _png_get_pHYs(png_ptr, info_ptr, res_x, res_y, unit_type);
end;

{--------------------------------------------------------------------------}

procedure _png_set_pHYs( png_ptr   : png_structp;
                         info_ptr  : png_infop;
                         res_x     : png_uint_32;
                         res_y     : png_uint_32;
                         unit_type : Integer ); cdecl; external;

procedure png_set_pHYs( png_ptr   : png_structp;
                        info_ptr  : png_infop;
                        res_x     : png_uint_32;
                        res_y     : png_uint_32;
                        unit_type : Integer );
begin
    _png_set_pHYs(png_ptr, info_ptr, res_x, res_y, unit_type);
end;


{--------------------------------------------------------------------------}

function _png_get_oFFs( png_ptr     : png_structp;
                        info_ptr    : png_infop;
                        offset_x    : png_uint_32p;
                        offset_y    : png_uint_32p;
                        unit_type   : PInteger ) : png_uint_32; cdecl; external;

function png_get_oFFs( png_ptr     : png_structp;
                       info_ptr    : png_infop;
                       offset_x    : png_uint_32p;
                       offset_y    : png_uint_32p;
                       unit_type   : PInteger ) : png_uint_32;
begin
    Result := _png_get_oFFs( png_ptr, info_ptr,
                             offset_x, offset_y, unit_type);
end;

{--------------------------------------------------------------------------}

function _png_get_PLTE( png_ptr         : png_structp;
                        info_ptr        : png_infop;
                        palette_ptr_ptr : png_palettepp;
                        num_palette     : PInteger ) : png_uint_32; cdecl; external;

function png_get_PLTE( png_ptr         : png_structp;
                       info_ptr        : png_infop;
                       palette_ptr_ptr : png_palettepp;
                       num_palette     : PInteger ) : png_uint_32;
begin
    Result := _png_get_PLTE(png_ptr, info_ptr, palette_ptr_ptr, num_palette);
end;

{--------------------------------------------------------------------------}

procedure _png_set_PLTE( png_ptr     : png_structp;
                         info_ptr    : png_infop;
                         palette_ptr : png_colorp;
                         num_palette : Integer ); cdecl; external;

procedure png_set_PLTE( png_ptr     : png_structp;
                        info_ptr    : png_infop;
                        palette_ptr : png_colorp;
                        num_palette : Integer );
begin
    _png_set_PLTE( png_ptr, info_ptr,
                   palette_ptr, num_palette );
end;

{--------------------------------------------------------------------------}

procedure _png_set_strip_16( png_ptr : png_structp ); cdecl; external;

procedure png_set_strip_16( png_ptr : png_structp );
begin
    _png_set_strip_16(png_ptr);
end;

{--------------------------------------------------------------------------}

procedure _png_set_packing( png_ptr : png_structp ); cdecl; external;

procedure png_set_packing( png_ptr : png_structp );
begin
    _png_set_packing(png_ptr);
end;

{--------------------------------------------------------------------------}

procedure _png_set_bgr( png_ptr : png_structp ); cdecl; external;

procedure png_set_bgr( png_ptr : png_structp );
begin
    _png_set_bgr(png_ptr);
end;

{--------------------------------------------------------------------------}

function _png_get_bKGD( png_ptr      : png_structp;
                        info_ptr     : png_infop;
                        background   : png_color_16pp ) : png_uint_32; cdecl; external;

function png_get_bKGD( png_ptr      : png_structp;
                       info_ptr     : png_infop;
                       background   : png_color_16pp ) : png_uint_32;
begin
    Result := _png_get_bKGD(png_ptr, info_ptr, background);
end;

{--------------------------------------------------------------------------}

procedure _png_set_bKGD( png_ptr    : png_structp;
                         info_ptr   : png_infop;
                         background : png_color_16p ); cdecl; external;

procedure png_set_bKGD( png_ptr    : png_structp;
                        info_ptr   : png_infop;
                        background : png_color_16p );
begin
    _png_set_bKGD(png_ptr, info_ptr, background);
end;

{--------------------------------------------------------------------------}

procedure _png_set_background( png_ptr               : png_structp;
                               background_color      : png_color_16p;
                               background_gamma_code : Integer;
                               need_expand           : Integer;
                               background_gamma      : Double ); cdecl; external;

procedure png_set_background( png_ptr               : png_structp;
                              background_color      : png_color_16p;
                              background_gamma_code : Integer;
                              need_expand           : Integer;
                              background_gamma      : Double );
begin
    _png_set_background( png_ptr, background_color,
                         background_gamma_code, need_expand,
                         background_gamma );
end;

{--------------------------------------------------------------------------}

function _png_get_gAMA( png_ptr    : png_structp;
                        info_ptr   : png_infop;
                        file_gamma : PDouble ) : png_uint_32; cdecl; external;

function png_get_gAMA( png_ptr    : png_structp;
                       info_ptr   : png_infop;
                       file_gamma : PDouble ) : png_uint_32;
begin
    Result := _png_get_gAMA(png_ptr, info_ptr, file_gamma);
end;

{--------------------------------------------------------------------------}

procedure _png_set_gAMA( png_ptr    : png_structp;
                         info_ptr   : png_infop;
                         file_gamma : Double ); cdecl; external;

procedure png_set_gAMA( png_ptr    : png_structp;
                        info_ptr   : png_infop;
                        file_gamma : Double );
begin
    _png_set_gAMA(png_ptr, info_ptr, file_gamma);
end;

{--------------------------------------------------------------------------}

procedure _png_set_swap( png_ptr : png_structp ); cdecl; external;

procedure png_set_swap( png_ptr : png_structp );
begin
    _png_set_swap(png_ptr);
end;

{--------------------------------------------------------------------------}

procedure _png_set_packswap( png_ptr : png_structp ); cdecl; external;

procedure png_set_packswap( png_ptr : png_structp );
begin
    _png_set_packswap(png_ptr);
end;

{--------------------------------------------------------------------------}

function _png_set_interlace_handling( png_ptr :png_structp ) : Integer; cdecl; external;

function png_set_interlace_handling( png_ptr :png_structp ) : Integer;
begin
    Result := _png_set_interlace_handling(png_ptr);
end;

{--------------------------------------------------------------------------}

procedure _png_read_row( png_ptr      : png_structp;
                         row          : png_bytep;
                         display_row  : png_bytep ); cdecl; external;

procedure png_read_row( png_ptr      : png_structp;
                        row          : png_bytep;
                        display_row  : png_bytep );
begin
    _png_read_row(png_ptr, row, display_row);
end;

{--------------------------------------------------------------------------}

procedure _png_write_row( png_ptr   : png_structp;
                          row       : png_bytep ); cdecl; external;

procedure png_write_row( png_ptr   : png_structp;
                         row       : png_bytep );
begin
    _png_write_row(png_ptr, row);
end;

{--------------------------------------------------------------------------}

procedure _png_write_info( png_ptr  : png_structp;
                           info_ptr : png_infop ); cdecl; external;

procedure png_write_info( png_ptr  : png_structp;
                          info_ptr : png_infop );
begin
    _png_write_info(png_ptr, info_ptr);
end;

{--------------------------------------------------------------------------}

procedure _png_write_end( png_ptr  : png_structp;
                          info_ptr : png_infop ); cdecl; external;

procedure png_write_end( png_ptr  : png_structp;
                         info_ptr : png_infop );
begin
    _png_write_end(png_ptr, info_ptr);
end;

{--------------------------------------------------------------------------}

procedure _png_read_end( png_ptr    : png_structp;
                         info_ptr   : png_infop ); cdecl; external;

procedure png_read_end( png_ptr    : png_structp;
                        info_ptr   : png_infop );
begin
    _png_read_end(png_ptr, info_ptr);
end;

{--------------------------------------------------------------------------}

procedure _png_read_image( png_ptr     : png_structp;
                           image       : png_bytepp ); cdecl; external;

procedure png_read_image( png_ptr     : png_structp;
                          image       : png_bytepp );
begin
    _png_read_image(png_ptr, image);
end;

{--------------------------------------------------------------------------}

function _png_get_sRGB( png_ptr   : png_structp;
                       info_ptr   : png_infop;
                       intent     : PInteger ) : png_uint_32; cdecl; external;

function png_get_sRGB( png_ptr    : png_structp;
                       info_ptr   : png_infop;
                       intent     : PInteger ) : png_uint_32;
begin
    Result := _png_get_sRGB(png_ptr, info_ptr, intent);
end;

{--------------------------------------------------------------------------}

procedure _png_set_sRGB( png_ptr   : png_structp;
                        info_ptr   : png_infop;
                        intent     : Integer  ); cdecl; external;

procedure png_set_sRGB( png_ptr    : png_structp;
                        info_ptr   : png_infop;
                        intent     : Integer  );
begin
    _png_set_sRGB(png_ptr, info_ptr, intent);
end;

{--------------------------------------------------------------------------}

function _png_get_valid( png_ptr    : png_structp;
                         info_ptr   : png_infop;
                         flag       : png_uint_32 ) : png_uint_32; cdecl; external;

function png_get_valid( png_ptr    : png_structp;
                        info_ptr   : png_infop;
                        flag       : png_uint_32 ) : png_uint_32;
begin
    Result := _png_get_valid(png_ptr, info_ptr, flag);
end;

{--------------------------------------------------------------------------}

procedure _png_set_compression_level( png_ptr : png_structp;
                                     level   : Integer ); cdecl; external;

procedure png_set_compression_level( png_ptr : png_structp;
                                     level   : Integer );
begin
    _png_set_compression_level(png_ptr, level);
end;

{--------------------------------------------------------------------------}

procedure _jpeg_init_decompress( error_mgr_ptr_ptr   : j_error_mgr_ptr_ptr;
	                         decompress_ptr_ptr : j_decompress_ptr_ptr ); cdecl; external;

procedure jpeg_init_decompress( error_mgr_ptr_ptr   : j_error_mgr_ptr_ptr;
	                        decompress_ptr_ptr : j_decompress_ptr_ptr );
begin
    _jpeg_init_decompress(error_mgr_ptr_ptr, decompress_ptr_ptr);
end;

{--------------------------------------------------------------------------}

procedure _jpeg_decompress_done( error_mgr_ptr   : j_error_mgr_ptr;
	                         decompress_ptr : j_decompress_ptr );  cdecl; external;

procedure jpeg_decompress_done( error_mgr_ptr   : j_error_mgr_ptr;
	                        decompress_ptr : j_decompress_ptr );
begin
    _jpeg_decompress_done(error_mgr_ptr, decompress_ptr);
end;

{--------------------------------------------------------------------------}

procedure _jpeg_init_compress( error_mgr_ptr_ptr : j_error_mgr_ptr_ptr;
                               compress_ptr_ptr : j_compress_ptr_ptr );  cdecl; external;

procedure jpeg_init_compress( error_mgr_ptr_ptr : j_error_mgr_ptr_ptr;
	                      compress_ptr_ptr : j_compress_ptr_ptr );
begin
    _jpeg_init_compress(error_mgr_ptr_ptr, compress_ptr_ptr);
end;

{--------------------------------------------------------------------------}

procedure _jpeg_compress_done( error_mgr_ptr : j_error_mgr_ptr;
	                       compress_ptr : j_compress_ptr ); cdecl; external;

procedure jpeg_compress_done( error_mgr_ptr : j_error_mgr_ptr;
	                      compress_ptr : j_compress_ptr );
begin
    _jpeg_compress_done(error_mgr_ptr, compress_ptr);
end;

{--------------------------------------------------------------------------}

procedure _jpeg_stdio_src( cinfo    : j_decompress_ptr;
                           infile   : Pointer ); cdecl; external;

procedure jpeg_stdio_src( cinfo    : j_decompress_ptr;
                          infile   : Pointer );
begin
    _jpeg_stdio_src(cinfo, infile);
end;

{--------------------------------------------------------------------------}

procedure _jpeg_stdio_dest( cinfo    : j_compress_ptr;
                            infile   : Pointer ); cdecl; external;

procedure jpeg_stdio_dest( cinfo    : j_compress_ptr;
                           infile   : Pointer );
begin
    _jpeg_stdio_dest(cinfo, infile);
end;

{--------------------------------------------------------------------------}

function _jpeg_read_header( cinfo         : j_decompress_ptr;
                            require_image : Integer ) :  Integer; cdecl; external;

function jpeg_read_header( cinfo         : j_decompress_ptr;
                           require_image : Integer ) :  Integer;
begin
    Result := _jpeg_read_header(cinfo, require_image);
end;

{--------------------------------------------------------------------------}

function _jpeg_start_decompress(cinfo : j_decompress_ptr ) : Integer; cdecl; external;

function jpeg_start_decompress(cinfo : j_decompress_ptr ) : Integer;
begin
    Result := _jpeg_start_decompress(cinfo);
end;

{--------------------------------------------------------------------------}

function _jpeg_finish_decompress(cinfo : j_decompress_ptr ) : Integer; cdecl; external;

function jpeg_finish_decompress(cinfo : j_decompress_ptr ) : Integer;
begin
    Result := _jpeg_finish_decompress(cinfo);
end;

{--------------------------------------------------------------------------}

procedure _jpeg_start_compress( cinfo            : j_compress_ptr;
                                write_all_tables : Integer  ); cdecl; external;

procedure jpeg_start_compress( cinfo            : j_compress_ptr;
                               write_all_tables : Integer  );
begin
    _jpeg_start_compress(cinfo, write_all_tables);
end;

{--------------------------------------------------------------------------}

procedure _jpeg_finish_compress(cinfo : j_compress_ptr ); cdecl; external;

procedure jpeg_finish_compress(cinfo : j_compress_ptr );
begin
    _jpeg_finish_compress(cinfo);
end;

{--------------------------------------------------------------------------}

procedure _jpeg_get_info( cinfo          : j_decompress_ptr;
                          Width          : PCardinal;
                          Height         : PCardinal;
                          Components     : PInteger;
                          ResUnit        : PByte;
                          XRes           : PSmallInt;
                          YRes           : PSmallInt;
                          FileColorSpace : PInteger ); cdecl; external;

procedure jpeg_get_info( cinfo          : j_decompress_ptr;
                         Width          : PCardinal;
                         Height         : PCardinal;
                         Components     : PInteger;
                         ResUnit        : PByte;
                         XRes           : PSmallInt;
                         YRes           : PSmallInt;
                         FileColorSpace : PInteger );
begin
    _jpeg_get_info( cinfo, Width, Height,
                    Components, ResUnit, XRes, YRes,
                    FileColorSpace );

end;

{--------------------------------------------------------------------------}

procedure _jpeg_set_info( cinfo            : j_compress_ptr;
                          Width            : Cardinal;
                          Height           : Cardinal;
                          Components       : Integer;
                          ResUnit          : Byte;
                          XRes             : SmallInt;
                          YRes             : SmallInt;
                          FileColorSpace   : Integer;
                          Quality          : Integer;
                          Progressive      : Integer;
                          OptimizedHuffman : Integer ); cdecl; external;

procedure jpeg_set_info( cinfo            : j_compress_ptr;
                         Width            : Cardinal;
                         Height           : Cardinal;
                         Components       : Integer;
                         ResUnit          : Byte;
                         XRes             : SmallInt;
                         YRes             : SmallInt;
                         FileColorSpace   : Integer;
                         Quality          : Integer;
                         Progressive      : Integer;
                         OptimizedHuffman : Integer );
begin
    _jpeg_set_info( cinfo, Width, Height, Components,
                    ResUnit, XRes, YRes, FileColorSpace,
                    Quality, Progressive, OptimizedHuffman );
end;

{--------------------------------------------------------------------------}

function _jpeg_read_scanlines( cinfo     : j_decompress_ptr;
	     	               scanlines : Pointer;
	                       max_lines : Cardinal ) : Cardinal; cdecl; external;

function jpeg_read_scanlines( cinfo     : j_decompress_ptr;
			      scanlines : Pointer;
			      max_lines : Cardinal ) : Cardinal;
begin
    Result := _jpeg_read_scanlines(cinfo, scanlines, max_lines);
end;

{--------------------------------------------------------------------------}

function _jpeg_write_scanlines( cinfo      : j_compress_ptr;
                                scanlines  : Pointer;
                                num_lines  : Cardinal ) : Cardinal; cdecl; external;

function jpeg_write_scanlines( cinfo      : j_compress_ptr;
                               scanlines  : Pointer;
                               num_lines  : Cardinal ) : Cardinal;
begin
    Result := _jpeg_write_scanlines(cinfo, scanlines, num_lines);
end;

{--------------------------------------------------------------------------}

procedure _jpeg_set_out_colorspace( cinfo      : j_decompress_ptr;
                                    colorspace : Integer ); cdecl; external;

{--------------------------------------------------------------------------}

procedure jpeg_set_out_colorspace( cinfo      : j_decompress_ptr;
                                   colorspace : Integer );
begin
    _jpeg_set_out_colorspace(cinfo, colorspace);
end;

{--------------------------------------------------------------------------}

function _gbm_init   : Integer; cdecl; external;

function gbm_init   : Integer;
begin
    Result := _gbm_init;
end;

{--------------------------------------------------------------------------}

function _gbm_deinit : Integer; cdecl; external;

function gbm_deinit : Integer;
begin
    Result := _gbm_deinit;
end;

{--------------------------------------------------------------------------}

function _gbm_guess_filetype( const FileName : PChar;
                                    FileType : PInteger ) : TGbm_Err; cdecl; external;

function gbm_guess_filetype( const FileName : PChar;
                                   FileType : PInteger ) : TGbm_Err;
begin
    Result := _gbm_guess_filetype( FileName, FileType );
end;

{--------------------------------------------------------------------------}

function _gbm_read_header( const FileName   : PChar;
                                 FileHandle : Integer;
                                 FileType   : Integer;
                                 GbmPtr     : TpGbm;
                           const Options    : PChar ) : TGbm_Err; cdecl; external;

function gbm_read_header( const FileName   : PChar;
                                FileHandle : Integer;
                                FileType   : Integer;
                                GbmPtr     : TpGbm;
                          const Options    : PChar ) : TGbm_Err;
begin
    Result := _gbm_read_header( FileName, FileHandle, FileType, GbmPtr, Options );
end;

{--------------------------------------------------------------------------}

function _gbm_read_palette( FileHandle  : Integer;
                            FileType    : Integer;
                            GbmPtr      : TpGbm;
                            PalettePtr  : TpGbmRgb ) : TGbm_Err; cdecl; external;

function gbm_read_palette( FileHandle  : Integer;
                           FileType    : Integer;
                           GbmPtr      : TpGbm;
                           PalettePtr  : TpGbmRgb ) : TGbm_Err;
begin
    Result := _gbm_read_palette( FileHandle, FileType, GbmPtr, PalettePtr );
end;

{--------------------------------------------------------------------------}

function _gbm_read_data( FileHandle  : Integer;
                         FileType    : Integer;
                         GbmPtr      : TpGbm;
                         pData       : Pointer ) : TGbm_Err; cdecl; external;

function gbm_read_data( FileHandle  : Integer;
                        FileType    : Integer;
                        GbmPtr      : TpGbm;
                        pData       : Pointer ) : TGbm_Err;
begin
    Result := _gbm_read_data(FileHandle, FileType, GbmPtr, pData);
end;

function _gbm_write( const FileName   : PChar;
                           FileHandle : Integer;
                           FileType   : Integer;
                     const GbmPtr     : TpGbm;
                     const PalettePtr : TpGbmRgb;
                     const pData      : Pointer;
                     const Options    : PChar ) : TGbm_Err; cdecl; external;

function gbm_write( const FileName   : PChar;
                          FileHandle : Integer;
                          FileType   : Integer;
                    const GbmPtr     : TpGbm;
                    const PalettePtr : TpGbmRgb;
                    const pData      : Pointer;
                    const Options    : PChar ) : TGbm_Err;
begin
    Result := _gbm_write( FileName, FileHandle, FileType,
                          GbmPtr, PalettePtr, pData, Options );
end;

(*

function _EGifOpenFileHandle( Handle : Integer) : PGifFileType; cdecl; external;

function EGifOpenFileHandle( Stream : TStream) : PGifFileType;
begin
    Result := _EGifOpenFileHandle(Integer(Stream));
end;

{--------------------------------------------------------------------------}

function _EGifSpew( GifFile : PGifFileType) : Integer; cdecl; external;

function EGifSpew( GifFile : PGifFileType) : Integer;
begin
    Result := _EGifSpew(GifFile);
end;

{--------------------------------------------------------------------------}

function _DGifOpenFileHandle( Handle : Integer ) : PGifFileType; cdecl; external;

function DGifOpenFileHandle( Stream : TStream) : PGifFileType;
begin
    Result := _DGifOpenFileHandle(Integer(Stream));
end;

{--------------------------------------------------------------------------}

function _DGifSlurp( GifFile : PGifFileType) : Integer; cdecl; external;

function DGifSlurp( GifFile : PGifFileType) : Integer;
begin
    Result := _DGifSlurp(GifFile);
end;

{--------------------------------------------------------------------------}

function _DGifCloseFile(GifFile : PGifFileType) : Integer; cdecl; external;

function DGifCloseFile(GifFile : PGifFileType) : Integer;
begin
    Result := _DGifCloseFile(GifFile);
end;

{--------------------------------------------------------------------------}

function _MakeMapObject(ColorCount : Integer; Colors : PGifColorArray) : PColorMapObject; cdecl; external;

function MakeMapObject(ColorCount : Integer; Colors : PGifColorArray) : PColorMapObject;
begin
    Result := _MakeMapObject(ColorCount, Colors);
end;

{--------------------------------------------------------------------------}

procedure _FreeMapObject(ColorMap : PColorMapObject); cdecl; external;

procedure FreeMapObject(ColorMap : PColorMapObject);
begin
    _FreeMapObject(ColorMap);
end;

{--------------------------------------------------------------------------}

function _MakeSavedImage( GifFile  : PGifFileType;
                          CopyFrom : PSavedImage) : PSavedImage; cdecl; external;

function MakeSavedImage( GifFile  : PGifFileType;
                         CopyFrom : PSavedImage) : PSavedImage;
begin
    Result := _MakeSavedImage(GifFile, CopyFrom);
end;
*)


{--------------------------------------------------------------------------}

end.

