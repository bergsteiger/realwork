(*
Copyright (c) 1998-2004 by HiComponents. All rights reserved.

This software comes without any warranty either implied or expressed.
In no case shall the author be liable for any damage or unwanted behavior of any
computer hardware and/or software.

HiComponents grants you the right to include the compiled component
in your application, whether COMMERCIAL, SHAREWARE, or FREEWARE,
BUT YOU MAY NOT DISTRIBUTE THIS SOURCE CODE OR ITS COMPILED .DCU IN ANY FORM.

ImageEn may not be included in any commercial, shareware or freeware DELPHI
libraries or components.

email: support@hicomponents.com

http://www.hicomponents.com

*)

unit pngfilt;

{$R-}
{$Q-}

{$I ie.inc}

interface


{$ifdef IEKYLIX}
uses iekdef, Types, QGraphics, Classes, ImageEnProc,ImageEnIO,hyieutils,hyiedefs, SysUtils,ZLib;
{$endif}
{$ifdef IEDELPHI}
uses Windows, Graphics, classes, sysutils, ImageEnProc, ImageEnIO, hyiedefs, hyieutils;
{$endif}

{$ifdef IEINCLUDEPNG}
procedure ReadPNGStream(Stream:TStream; Bitmap:TIEBitmap; var IOParams:TIOParamsVals; var xProgress:TProgressRec; Preview:boolean; var AlphaChannel:TIEMask; IgnoreAlpha:boolean);
function IsPNGStream(Stream:TStream):boolean;
{$endif}

{$Z4}

type
  png_uint_32 = Cardinal;
  png_uint_32p=^png_uint_32;
  png_int_32  = integer;
  png_uint_16 = Word;
  png_int_16  = Smallint;
  png_byte    = Byte;
  png_size_t  = png_uint_32;
  png_charpp  = ^png_charp;
  png_charp   = PAnsiChar;
  float       = single;
  int         = Integer;
  png_bytepp  = ^png_bytep;
  png_bytep   = ^png_byte;
  png_uint_16p = ^png_uint_16;
  png_uint_16pp = ^png_uint_16p;
  png_voidp    = pointer;
  time_t       = Longint;
  png_doublep  = ^png_double;
  png_double   = double;

  user_error_ptr  = Pointer;
  png_error_ptrp = ^png_error_ptr;
  png_error_ptr  = procedure(png_ptr: Pointer; msg: Pointer);{$ifdef IEKYLIX} cdecl; {$endif}
  png_rw_ptrp = ^png_rw_ptr;
  png_rw_ptr = procedure(png_ptr: Pointer; data: Pointer;
                         length: png_size_t);{$ifdef IEKYLIX} cdecl; {$endif}
  png_flush_ptrp = ^png_flush_ptr;
  png_flush_ptr = procedure(png_ptr: Pointer);{$ifdef IEKYLIX} cdecl; {$endif}
  png_progressive_info_ptrp = ^png_progressive_info_ptr;
  png_progressive_info_ptr  = procedure(png_ptr: Pointer;
                                        info_ptr: Pointer);{$ifdef IEKYLIX} cdecl; {$endif}
  png_progressive_end_ptrp  = ^png_progressive_end_ptr;
  png_progressive_end_ptr   = procedure(png_ptr: Pointer;
                                        info_ptr: Pointer);{$ifdef IEKYLIX} cdecl; {$endif}
  png_progressive_row_ptrp  = ^png_progressive_row_ptr;
  png_progressive_row_ptr   = procedure(png_ptr: Pointer;
                                data: Pointer; length: png_uint_32;
                                count: int);{$ifdef IEKYLIX} cdecl; {$endif}
  png_read_status_ptr = procedure(png_ptr: Pointer;
                          row_number: png_uint_32; pass: int);{$ifdef IEKYLIX} cdecl; {$endif}
  png_write_status_ptr = procedure(png_ptr: Pointer;
                           row_number: png_uint_32; pass: int);{$ifdef IEKYLIX} cdecl; {$endif}
  png_user_transform_ptr = procedure(png_ptr: Pointer;
                             row_info: Pointer; data: png_bytep);{$ifdef IEKYLIX} cdecl; {$endif}

  png_colorpp = ^png_colorp;
  png_colorp = ^png_color;
  png_color = packed record
    red, green, blue: png_byte;
    end;

  png_color_16pp = ^png_color_16p;
  png_color_16p = ^png_color_16;
  png_color_16 = packed record
    index: png_byte;                 //used for palette files
    red, green, blue: png_uint_16;   //for use in red green blue files
    gray: png_uint_16;               //for use in grayscale files
    end;

  png_color_8pp = ^png_color_8p;
  png_color_8p = ^png_color_8;
  png_color_8 = packed record
    red, green, blue: png_byte;   //for use in red green blue files
    gray: png_byte;               //for use in grayscale files
    alpha: png_byte;              //for alpha channel files
    end;

  png_textpp = ^png_textp;
  png_textp = ^tpng_text;
  tpng_text = packed record
    compression: int;            //compression value
    key: png_charp;              //keyword, 1-79 character description of "text"
    text: png_charp;             //comment, may be empty ("")
    text_length: png_size_t;     //length of text field
    end;

  png_timepp = ^png_timep;
  png_timep = ^tpng_time;
  tpng_time = packed record
    year: png_uint_16;           //yyyy
    month: png_byte;             //1..12
    day: png_byte;               //1..31
    hour: png_byte;              //0..23
    minute: png_byte;            //0..59
    second: png_byte;            //0..60 (leap seconds)
    end;

  png_infopp = ^png_infop;
  png_infop = Pointer;

  png_row_infopp = ^png_row_infop;
  png_row_infop = ^png_row_info;
  png_row_info = packed record
    width: png_uint_32;          //width of row
    rowbytes: png_size_t;        //number of bytes in row
    color_type: png_byte;        //color type of row
    bit_depth: png_byte;         //bit depth of row
    channels: png_byte;          //number of channels (1, 2, 3, or 4)
    pixel_depth: png_byte;       //bits per pixel (depth * channels)
    end;

  png_structpp = ^png_structp;
  png_structp = Pointer;

  {$ifdef IEDELPHI}

  // portions of ZLib
  TZAlloc = function (opaque: Pointer; items, size: Integer): Pointer;
  TZFree  = procedure (opaque, block: Pointer);
  TZCompressionLevel = (zcNone, zcFastest, zcDefault, zcMax);

  TZStreamRec = packed record
    next_in  : PAnsiChar;     // next input byte
    avail_in : Longint;   // number of bytes available at next_in
    total_in : Longint;   // total nb of input bytes read so far

    next_out : PAnsiChar;     // next output byte should be put here
    avail_out: Longint;   // remaining free space at next_out
    total_out: Longint;   // total nb of bytes output so far

    msg      : PAnsiChar;     // last error message, NULL if no error
    state    : Pointer;   // not visible by applications

    zalloc   : TZAlloc;   // used to allocate the internal state
    zfree    : TZFree;    // used to free the internal state
    opaque   : Pointer;   // private data object passed to zalloc and zfree

    data_type: Integer;   // best guess about the data type: ascii or binary
    adler    : Longint;   // adler32 value of the uncompressed data
    reserved : Longint;   // reserved for future use
  end;

  TCustomZStream = class(TStream)
  private
    FStream    : TStream;
    FStreamPos : Integer;
    FOnProgress: TNotifyEvent;

    FZStream   : TZStreamRec;
    FBuffer    : Array [Word] of AnsiChar;
  protected
    constructor Create(stream: TStream);

    procedure DoProgress; virtual;

    property OnProgress: TNotifyEvent read FOnProgress write FOnProgress;
  end;

  TZCompressionStream = class(TCustomZStream)
  private
    function GetCompressionRate: Single;
  public
    constructor Create(dest: TStream; compressionLevel: TZCompressionLevel);	// compressionLevel: TZCompressionLevel = zcDefault
    destructor  Destroy; override;

    function  Read(var buffer; count: Longint): Longint; override;
    function  Write(const buffer; count: Longint): Longint; override;
    function  Seek(offset: Longint; origin: Word): Longint; override;

    property CompressionRate: Single read GetCompressionRate;
    property OnProgress;
  end;

  TZDecompressionStream = class(TCustomZStream)
  public
    constructor Create(source: TStream);
    destructor  Destroy; override;

    function  Read(var buffer; count: Longint): Longint; override;
    function  Write(const buffer; count: Longint): Longint; override;
    function  Seek(offset: Longint; origin: Word): Longint; override;

    property OnProgress;
  end;


procedure ZCompress(const inBuffer: Pointer; inSize: Integer;
  out outBuffer: Pointer; out outSize: Integer;
  level: TZCompressionLevel);	// level: TZCompressionLevel = zcDefault


procedure ZDecompress(const inBuffer: Pointer; inSize: Integer;
 out outBuffer: Pointer; out outSize: Integer; outEstimate: Integer);	// outEstimate: Integer = 0

function ZCompressStr(const s: String; level: TZCompressionLevel): String;	// level: TZCompressionLevel = zcDefault

function ZDecompressStr(const s: String): String;

procedure ZCompressStream(inStream, outStream: TStream;
  level: TZCompressionLevel);	// level: TZCompressionLevel = zcDefault

procedure ZDecompressStream(inStream, outStream: TStream);

type
  EZLibError = class(Exception);

  EZCompressionError = class(EZLibError);
  EZDecompressionError = class(EZLibError);

const ZLIB_VERSION = '1.1.4';

{$endif}	// IEDELPHI

// Supported compression types for text in PNG files (tEXt, and zTXt).
// The values of the PNG_TEXT_COMPRESSION_ defines should NOT be changed.

const
  PNG_TEXT_COMPRESSION_NONE_WR = -3;
  PNG_TEXT_COMPRESSION_zTXt_WR = -2;
  PNG_TEXT_COMPRESSION_NONE    = -1;
  PNG_TEXT_COMPRESSION_zTXt    = 0;

// These describe the color_type field in png_info.
// color type masks

  PNG_COLOR_MASK_PALETTE   = 1;
  PNG_COLOR_MASK_COLOR     = 2;
  PNG_COLOR_MASK_ALPHA     = 4;

// color types.  Note that not all combinations are legal

  PNG_COLOR_TYPE_GRAY       = 0;
  PNG_COLOR_TYPE_PALETTE    = PNG_COLOR_MASK_COLOR or
                              PNG_COLOR_MASK_PALETTE;
  PNG_COLOR_TYPE_RGB        = PNG_COLOR_MASK_COLOR;
  PNG_COLOR_TYPE_RGB_ALPHA  = PNG_COLOR_MASK_COLOR or
                              PNG_COLOR_MASK_ALPHA;
  PNG_COLOR_TYPE_GRAY_ALPHA = PNG_COLOR_MASK_ALPHA;

// This is for compression type. PNG 1.0 only defines the single type.

  PNG_COMPRESSION_TYPE_BASE    = 0;   // Deflate method 8, 32K window
  PNG_COMPRESSION_TYPE_DEFAULT = PNG_COMPRESSION_TYPE_BASE;

// This is for filter type. PNG 1.0 only defines the single type.

  PNG_FILTER_TYPE_BASE    = 0;       // Single row per-byte filtering
  PNG_FILTER_TYPE_DEFAULT = PNG_FILTER_TYPE_BASE;

// These are for the interlacing type.  These values should NOT be changed.

  PNG_INTERLACE_NONE  = 0;      // Non-interlaced image
  PNG_INTERLACE_ADAM7 = 1;      // Adam7 interlacing

// These are for the oFFs chunk.  These values should NOT be changed.

  PNG_OFFSET_PIXEL      = 0;    // Offset in pixels
  PNG_OFFSET_MICROMETER = 1;    // Offset in micrometers (1/10^6 meter)

// These are for the pCAL chunk.  These values should NOT be changed.

  PNG_EQUATION_LINEAR     = 0;  // Linear transformation
  PNG_EQUATION_BASE_E     = 1;  // Exponential base e transform
  PNG_EQUATION_ARBITRARY  = 2;  // Arbitrary base exponential transform
  PNG_EQUATION_HYPERBOLIC = 3;  // Hyperbolic sine transformation

// These are for the pHYs chunk.  These values should NOT be changed.

  PNG_RESOLUTION_UNKNOWN = 0;   // pixels/unknown unit (aspect ratio)
  PNG_RESOLUTION_METER   = 1;   // pixels/meter

// These are for the sRGB chunk.  These values should NOT be changed.
  PNG_sRGB_INTENT_SATURATION = 0;
  PNG_sRGB_INTENT_PERCEPTUAL = 1;
  PNG_sRGB_INTENT_ABSOLUTE   = 2;
  PNG_sRGB_INTENT_RELATIVE   = 3;

// Handle alpha and tRNS by replacing with a background color.
  PNG_BACKGROUND_GAMMA_UNKNOWN = 0;
  PNG_BACKGROUND_GAMMA_SCREEN  = 1;
  PNG_BACKGROUND_GAMMA_FILE    = 2;
  PNG_BACKGROUND_GAMMA_UNIQUE  = 3;

// Values for png_set_crc_action() to say how to handle CRC errors in
// ancillary and critical chunks, and whether to use the data contained
// therein.  Note that it is impossible to "discard" data in a critical
// chunk.  For versions prior to 0.90, the action was always error/quit,
// whereas in version 0.90 and later, the action for CRC errors in ancillary
// chunks is warn/discard.  These values should NOT be changed.

//      value                   action:critical     action:ancillary

  PNG_CRC_DEFAULT      = 0;  // error/quit          warn/discard data
  PNG_CRC_ERROR_QUIT   = 1;  // error/quit          error/quit
  PNG_CRC_WARN_DISCARD = 2;  // (INVALID)           warn/discard data
  PNG_CRC_WARN_USE     = 3;  // warn/use data       warn/use data
  PNG_CRC_QUIET_USE    = 4;  // quiet/use data      quiet/use data
  PNG_CRC_NO_CHANGE    = 5;  // use current value   use current value

// Flags for png_set_filter() to say which filters to use.  The flags
// are chosen so that they don't conflict with real filter types
// below, in case they are supplied instead of the #defined constants.
// These values should NOT be changed.

  PNG_NO_FILTERS   = $00;
  PNG_FILTER_NONE  = $08;
  PNG_FILTER_SUB   = $10;
  PNG_FILTER_UP    = $20;
  PNG_FILTER_AVG   = $40;
  PNG_FILTER_PAETH = $80;
  PNG_ALL_FILTERS  = PNG_FILTER_NONE or PNG_FILTER_SUB or
                     PNG_FILTER_UP   or PNG_FILTER_AVG or
                     PNG_FILTER_PAETH;

// Filter values (not flags) - used in pngwrite.c, pngwutil.c for now.
// These defines should NOT be changed.

  PNG_FILTER_VALUE_NONE  = 0;
  PNG_FILTER_VALUE_SUB   = 1;
  PNG_FILTER_VALUE_UP    = 2;
  PNG_FILTER_VALUE_AVG   = 3;
  PNG_FILTER_VALUE_PAETH = 4;

// Heuristic used for row filter selection.  These defines should NOT be
// changed.

  PNG_FILTER_HEURISTIC_DEFAULT    = 0;  // Currently "UNWEIGHTED"
  PNG_FILTER_HEURISTIC_UNWEIGHTED = 1;  // Used by libpng < 0.95
  PNG_FILTER_HEURISTIC_WEIGHTED   = 2;  // Experimental feature
  PNG_FILTER_HEURISTIC_LAST       = 3;  // Not a valid value

{$ifdef IEDELPHI}

procedure _abort; cdecl; forward;
function _memcmp(buf1,buf2:pbyte; count:integer):integer; cdecl; forward;
procedure _memset(P: Pointer; B: Byte; count: Integer); cdecl; forward;
procedure _memcpy(dest, source: Pointer; count: Integer); cdecl; forward;
function _malloc(size: Integer): Pointer; cdecl; forward;
procedure _free(P: Pointer); cdecl; forward;
function _fabs(v:double):double; cdecl; forward;
function _pow(Base,Exponent:double):double; cdecl; forward;
function __ftol: Integer; cdecl; forward;
function _strlen(s:PAnsiChar):cardinal; cdecl; forward;
//function _strtod(s:PAnsiChar; vp:pinteger):double; cdecl; forward;
function _strtod(s:PAnsiChar; var vp:PAnsiChar):double; cdecl;

procedure crc32; external;
function deflateInit_(var strm: TZStreamRec; level: Integer; version: PAnsiChar;recsize: Integer): Integer; external;
function deflate(var strm: TZStreamRec; flush: Integer): Integer;external;
function deflateEnd(var strm: TZStreamRec): Integer; external;
function inflateInit_(var strm: TZStreamRec; version: PAnsiChar;  recsize: Integer): Integer; external;
function inflate(var strm: TZStreamRec; flush: Integer): Integer; external;
function inflateEnd(var strm: TZStreamRec): Integer; external;
function inflateReset(var strm: TZStreamRec): Integer; external;
procedure deflateInit2_; external;
procedure deflateReset; external;

{$endif}	// IEDELPHI

{$ifdef IEKYLIX}
//const PNGDLL = 'libpng.so.3';
const PNGDLL = 'libpng12.so.0';
{$endif}

implementation

uses ImageEnView, ieview;

{$R-}

{$ifdef IEDELPHI}

const
  Z_NO_FLUSH      = 0;
  Z_PARTIAL_FLUSH = 1;
  Z_SYNC_FLUSH    = 2;
  Z_FULL_FLUSH    = 3;
  Z_FINISH        = 4;
  Z_OK            = 0;
  Z_STREAM_END    = 1;
  Z_NEED_DICT     = 2;
  Z_ERRNO         = (-1);
  Z_STREAM_ERROR  = (-2);
  Z_DATA_ERROR    = (-3);
  Z_MEM_ERROR     = (-4);
  Z_BUF_ERROR     = (-5);
  Z_VERSION_ERROR = (-6);
  Z_NO_COMPRESSION       =   0;
  Z_BEST_SPEED           =   1;
  Z_BEST_COMPRESSION     =   9;
  Z_DEFAULT_COMPRESSION  = (-1);
  Z_FILTERED            = 1;
  Z_HUFFMAN_ONLY        = 2;
  Z_DEFAULT_STRATEGY    = 0;
  Z_BINARY   = 0;
  Z_ASCII    = 1;
  Z_UNKNOWN  = 2;
  Z_DEFLATED = 8;
  _z_errmsg: array[0..9] of PAnsiChar = (
    'need dictionary',      // Z_NEED_DICT      (2)
    'stream end',           // Z_STREAM_END     (1)
    '',                     // Z_OK             (0)
    'file error',           // Z_ERRNO          (-1)
    'stream error',         // Z_STREAM_ERROR   (-2)
    'data error',           // Z_DATA_ERROR     (-3)
    'insufficient memory',  // Z_MEM_ERROR      (-4)
    'buffer error',         // Z_BUF_ERROR      (-5)
    'incompatible version', // Z_VERSION_ERROR  (-6)
    ''
  );
  ZLevels: array [TZCompressionLevel] of Shortint = (
    Z_NO_COMPRESSION,
    Z_BEST_SPEED,
    Z_DEFAULT_COMPRESSION,
    Z_BEST_COMPRESSION
  );

  SZInvalid = 'Invalid ZStream operation!';


{$L deflate.obj}
{$L inflate.obj}
{$L infblock.obj}
{$L inftrees.obj}
{$L infcodes.obj}
{$L infutil.obj}
{$L inffast.obj}
{$L trees.obj}
{$L adler32.obj}
{$L crc32.obj}


function zcalloc(opaque: Pointer; items, size: Integer): Pointer;
begin
  GetMem(result,items * size);
  if (Result <> nil) then
   FillChar(Result^, items * size, 0);
end;

procedure zcfree(opaque, block: Pointer);
begin
  FreeMem(block);
end;

function DeflateInit(var stream: TZStreamRec; level: Integer): Integer;
begin
  result := DeflateInit_(stream,level,ZLIB_VERSION,SizeOf(TZStreamRec));
end;

function InflateInit(var stream: TZStreamRec): Integer;
begin
  result := InflateInit_(stream,ZLIB_VERSION,SizeOf(TZStreamRec));
end;

procedure _memset(P: Pointer; B: Byte; count: Integer); cdecl;
begin
  FillChar(P^, count, B);
end;

function _memcmp(buf1,buf2:pbyte; count:integer):integer; cdecl;
begin
   if count=0 then
      result:=0
   else begin
      while (count>0) and (buf1^=buf2^) do begin
         inc(buf1);
         inc(buf2);
         dec(count);
      end;
      result:=buf1^-buf2^;
   end;
end;

(*
function _strtod(s:PAnsiChar; vp:pinteger):double; cdecl;
begin
   vp^:=0;
   //result:=strtofloat(s);
   result:=IEStrToFloatDef(s,0);
end;
*)
function _strtod(s:PAnsiChar; var vp:PAnsiChar):double; cdecl;
begin
   vp:=@s[strlen(s)-1];	// !!
   result:=IEStrToFloatDef(s,0);
end;


procedure _abort; cdecl;
begin
end;

procedure _memcpy(dest, source: Pointer; count: Integer); cdecl;
begin
  Move(source^, dest^, count);
end;

function _malloc(size: Integer): Pointer; cdecl;
begin
  GetMem(Result, size);
  if (Result <> nil) then
   FillChar(Result^, size, 0);
end;

procedure _free(P: Pointer); cdecl;
begin
  FreeMem(P);
end;

function _fabs(v:double):double; cdecl;
begin
	result:=abs(v);
end;

function IntPower(Base: Extended; Exponent: Integer): Extended; cdecl;
asm
        mov     ecx, eax
        cdq
        fld1                      { Result := 1 }
        xor     eax, edx
        sub     eax, edx          { eax := Abs(Exponent) }
        jz      @@3
        fld     Base
        jmp     @@2
@@1:    fmul    ST, ST            { X := Base * Base }
@@2:    shr     eax,1
        jnc     @@1
        fmul    ST(1),ST          { Result := Result * X }
        jnz     @@1
        fstp    st                { pop X from FPU stack }
        cmp     ecx, 0
        jge     @@3
        fld1
        fdivrp                    { Result := 1 / Result }
@@3:
        fwait
end;

function _pow(Base,Exponent:double):double; cdecl;
begin
  if Exponent = 0.0 then
    Result := 1.0               { n**0 = 1 }
  else if (Base = 0.0) and (Exponent > 0.0) then
    Result := 0.0               { 0**n = 0, n > 0 }
  else if (Frac(Exponent) = 0.0) and (Abs(Exponent) <= MaxInt) then
    Result := IntPower(Base, Trunc(Exponent))
  else
    Result := Exp(Exponent * Ln(Base))
end;

function __ftol: Integer; cdecl;
var
  f: double;
begin
  asm
    lea    eax, f             //  BC++ passes floats on the FPU stack
    fstp  qword ptr [eax]     //  Delphi passes floats on the CPU stack
  end;
  Result := Trunc(f);
end;

function _strlen(s:PAnsiChar):cardinal; cdecl;
begin
	result:=strlen(s);
end;

var
  __turboFloat: LongBool = False;

{$endif} // IEDELPHI


{$ifdef IEINCLUDEPNG}

{$ifdef IEDELPHI}

{$L pngread.obj}
{$L pngset.obj}
{$L pngtrans.obj}
{$L pngrtran.obj}
{$L pngrio.obj}
{$L pngmem.obj}
{$L pngerror.obj}
{$L pngrutil.obj}
{$L pngget.obj}
{$L png.obj}


function png_create_read_struct(user_png_ver: png_charp;
             error_ptr: user_error_ptr; error_fn: png_error_ptr;
             warn_fn: png_error_ptr): png_structp;
              external;
procedure png_chunk_warning(png_ptr: png_structp;
             const mess: png_charp);
              external;
procedure png_chunk_error(png_ptr: png_structp;
             const mess: png_charp);
              external;
procedure png_set_IHDR(png_ptr: png_structp; info_ptr: png_infop;
             width, height: png_uint_32; bit_depth, color_type,
             interlace_type, compression_type, filter_type: int);
              external;
procedure png_set_PLTE(png_ptr: png_structp; info_ptr: png_infop;
             palette: png_colorp; num_palette: int);
              external;
procedure png_set_gAMA(png_ptr: png_structp; info_ptr: png_infop;
             file_gamma: double);
              external;
procedure png_set_sBIT(png_ptr: png_structp; info_ptr: png_infop;
             sig_bits: png_color_8p);
              external;
procedure png_set_cHRM(png_ptr: png_structp; info_ptr: png_infop;
             white_x, white_y, red_x, red_y, green_x, green_y,
             blue_x, blue_y: double);
              external;
procedure png_set_sRGB_gAMA_and_cHRM(png_ptr: png_structp;
             info_ptr: png_infop; intent: int);
              external;
procedure png_set_tRNS(png_ptr: png_structp; info_ptr: png_infop;
             trans: png_bytep; num_trans: int;
             trans_values: png_color_16p);
              external;
procedure png_set_bKGD(png_ptr: png_structp; info_ptr: png_infop;
             background: png_color_16p);
              external;
procedure png_set_hIST(png_ptr: png_structp; info_ptr: png_infop;
             hist: png_uint_16p);
              external;
procedure png_set_pHYs(png_ptr: png_structp; info_ptr: png_infop;
             res_x, res_y: png_uint_32; unit_type: int);
              external;
procedure png_set_oFFs(png_ptr: png_structp; info_ptr: png_infop;
             offset_x, offset_y: png_uint_32; unit_type: int);
              external;
procedure png_set_pCAL(png_ptr: png_structp; info_ptr: png_infop;
             purpose: png_charp; X0, X1: png_int_32;
             typ, nparams: int; units: png_charp;
             params: png_charpp);
              external;
procedure png_set_tIME(png_ptr: png_structp; info_ptr: png_infop;
             mod_time: png_timep);
              external;
procedure png_set_text(png_ptr: png_structp; info_ptr: png_infop;
             text_ptr: png_textp; num_text: int);
              external;
function png_create_info_struct(png_ptr: png_structp): png_infop;
              external;
procedure png_destroy_read_struct(png_ptr_ptr: png_structpp;
             info_ptr_ptr, end_info_ptr_ptr: png_infopp);
              external;
procedure png_set_read_fn(png_ptr: png_structp;
             io_ptr: png_voidp; read_data_fn: png_rw_ptr);
              external;
procedure png_read_info(png_ptr: png_structp; info_ptr: png_infop);
              external;
function png_get_IHDR(png_ptr: png_structp; info_ptr: png_infop;
             var width, height: png_uint_32; var bit_depth,
             color_type, interlace_type, compression_type,
             filter_type: int): png_uint_32;
              external;
procedure png_set_expand(png_ptr: png_structp);
              external;
procedure png_set_bgr(png_ptr: png_structp);
              external;
procedure png_set_strip_16(png_ptr: png_structp);
              external;
procedure png_set_packing(png_ptr: png_structp);
              external;
procedure png_set_invert_mono(png_ptr: png_structp);
              external;
procedure  png_set_palette_to_rgb(png_ptr: png_structp);
              external;

procedure png_set_swap_alpha(png_ptr: png_structp);
              external;
procedure png_set_invert_alpha(png_ptr: png_structp);
              external;
procedure png_set_gray_to_rgb(png_ptr: png_structp);
              external;
procedure png_read_update_info(png_ptr: png_structp; info_ptr: png_infop);
              external;
function png_set_interlace_handling(png_ptr: png_structp): int;
              external;
procedure png_read_rows(png_ptr: png_structp; row, display_row:
              png_bytepp; num_rows: png_uint_32);
              external;
procedure png_read_end(png_ptr: png_structp; info_ptr: png_infop);
               external;
function png_get_io_ptr(png_ptr:png_structp):png_voidp; external;
function png_get_rowbytes(png_ptr: png_structp; info_ptr: png_infop):
             png_uint_32;
              external;
function png_get_bKGD(png_ptr: png_structp; info_ptr: png_infop;
             var background: png_color_16p): png_uint_32;
              external;
procedure png_set_background(png_ptr: png_structp;
             background_color: png_color_16p;
             background_gamma_code, need_expand: int;
             background_gamma: double);
              external;
function png_get_x_pixels_per_meter(png_ptr: png_structp;
             info_ptr: png_infop): png_uint_32;
              external;
function png_get_y_pixels_per_meter(png_ptr: png_structp;
             info_ptr: png_infop): png_uint_32;
              external;
function png_get_interlace_type(png_ptr: png_structp;
             info_ptr: png_infop): png_byte;
              external;
procedure png_set_gamma(png_ptr: png_structp; screen_gamma,
             default_file_gamma: double);
              external;
function png_get_gAMA(png_ptr: png_structp; info_ptr: png_infop;
             var file_gamma: double): png_uint_32;
              external;
function png_get_PLTE(png_ptr: png_structp; info_ptr: png_infop;
             var palette: png_colorp; var num_palette: int):
             png_uint_32;
              external;
function png_sig_cmp(sig: png_bytep; start, num_to_check: png_size_t):
             int;
              external;
function png_get_channels(png_ptr: png_structp; info_ptr:png_infop):png_byte; external;

procedure PNG_MEMSET_CHECK; external;
procedure PNG_DO_STRIP_FILLER; external;
procedure PNG_DO_INVERT; external;
procedure PNG_DO_BGR; external;
procedure PNG_DO_PACKSWAP; external;
procedure PNG_DO_SWAP; external;
procedure PNG_INIT_READ_TRANSFORMATIONS; external;
procedure PNG_SET_GAMA_FIXED; external;
procedure PNG_SET_CHRM_FIXED; external;
procedure PNG_SET_ICCP; external;
procedure PNG_SET_SPLT; external;
procedure PNG_SET_SCAL; external;
procedure PNG_SET_UNKNOWN_CHUNKS; external;
procedure png_set_text_2; external;

{$endif}	// IEDELPHI

{$ifdef IEKYLIX}

function png_create_read_struct(user_png_ver: png_charp;
             error_ptr: user_error_ptr; error_fn: png_error_ptr;
             warn_fn: png_error_ptr): png_structp; cdecl; external PNGDLL;
procedure png_chunk_warning(png_ptr: png_structp;
             const mess: png_charp); cdecl; external PNGDLL;
procedure png_chunk_error(png_ptr: png_structp;
             const mess: png_charp); cdecl; external PNGDLL;
procedure png_set_IHDR(png_ptr: png_structp; info_ptr: png_infop;
             width, height: png_uint_32; bit_depth, color_type,
             interlace_type, compression_type, filter_type: int); cdecl; external PNGDLL;
procedure png_set_PLTE(png_ptr: png_structp; info_ptr: png_infop;
             palette: png_colorp; num_palette: int); cdecl; external PNGDLL;
procedure png_set_gAMA(png_ptr: png_structp; info_ptr: png_infop;
             file_gamma: double); cdecl; external PNGDLL;
procedure png_set_sBIT(png_ptr: png_structp; info_ptr: png_infop;
             sig_bits: png_color_8p); cdecl; external PNGDLL;
procedure png_set_cHRM(png_ptr: png_structp; info_ptr: png_infop;
             white_x, white_y, red_x, red_y, green_x, green_y,
             blue_x, blue_y: double); cdecl; external PNGDLL;
procedure png_set_sRGB_gAMA_and_cHRM(png_ptr: png_structp;
             info_ptr: png_infop; intent: int); cdecl; external PNGDLL;
procedure png_set_tRNS(png_ptr: png_structp; info_ptr: png_infop;
             trans: png_bytep; num_trans: int;
             trans_values: png_color_16p); cdecl; external PNGDLL;
procedure png_set_bKGD(png_ptr: png_structp; info_ptr: png_infop;
             background: png_color_16p); cdecl; external PNGDLL;
procedure png_set_hIST(png_ptr: png_structp; info_ptr: png_infop;
             hist: png_uint_16p); cdecl; external PNGDLL;
procedure png_set_pHYs(png_ptr: png_structp; info_ptr: png_infop;
             res_x, res_y: png_uint_32; unit_type: int); cdecl; external PNGDLL;
procedure png_set_oFFs(png_ptr: png_structp; info_ptr: png_infop;
             offset_x, offset_y: png_uint_32; unit_type: int); cdecl; external PNGDLL;
procedure png_set_pCAL(png_ptr: png_structp; info_ptr: png_infop;
             purpose: png_charp; X0, X1: png_int_32;
             typ, nparams: int; units: png_charp;
             params: png_charpp); cdecl; external PNGDLL;
procedure png_set_tIME(png_ptr: png_structp; info_ptr: png_infop;
             mod_time: png_timep); cdecl; external PNGDLL;
procedure png_set_text(png_ptr: png_structp; info_ptr: png_infop;
             text_ptr: png_textp; num_text: int); cdecl; external PNGDLL;
function png_create_info_struct(png_ptr: png_structp): png_infop; cdecl; external PNGDLL;
procedure png_destroy_read_struct(png_ptr_ptr: png_structpp;
             info_ptr_ptr, end_info_ptr_ptr: png_infopp); cdecl; external PNGDLL;
procedure png_set_read_fn(png_ptr: png_structp;
             io_ptr: png_voidp; read_data_fn: png_rw_ptr); cdecl; external PNGDLL;
procedure png_read_info(png_ptr: png_structp; info_ptr: png_infop); cdecl; external PNGDLL;
function png_get_IHDR(png_ptr: png_structp; info_ptr: png_infop;
             var width, height: png_uint_32; var bit_depth,
             color_type, interlace_type, compression_type,
             filter_type: int): png_uint_32; cdecl; external PNGDLL;
procedure png_set_expand(png_ptr: png_structp); cdecl; external PNGDLL;
procedure png_set_bgr(png_ptr: png_structp); cdecl; external PNGDLL;
procedure png_set_strip_16(png_ptr: png_structp); cdecl; external PNGDLL;
procedure png_set_packing(png_ptr: png_structp); cdecl; external PNGDLL;
procedure png_set_gray_to_rgb(png_ptr: png_structp); cdecl; external PNGDLL;
procedure png_read_update_info(png_ptr: png_structp; info_ptr: png_infop); cdecl; external PNGDLL;
function png_set_interlace_handling(png_ptr: png_structp): int; cdecl; external PNGDLL;
procedure png_read_rows(png_ptr: png_structp; row, display_row:
              png_bytepp; num_rows: png_uint_32); cdecl; external PNGDLL;
procedure png_read_end(png_ptr: png_structp; info_ptr: png_infop); cdecl; external PNGDLL;
function png_get_io_ptr(png_ptr:png_structp):png_voidp; cdecl; external PNGDLL;
function png_get_rowbytes(png_ptr: png_structp; info_ptr: png_infop):
             png_uint_32; cdecl; external PNGDLL;
function png_get_bKGD(png_ptr: png_structp; info_ptr: png_infop;
             var background: png_color_16p): png_uint_32; cdecl; external PNGDLL;
procedure png_set_background(png_ptr: png_structp;
             background_color: png_color_16p;
             background_gamma_code, need_expand: int;
             background_gamma: double); cdecl; external PNGDLL;
function png_get_x_pixels_per_meter(png_ptr: png_structp;
             info_ptr: png_infop): png_uint_32; cdecl; external PNGDLL;
function png_get_y_pixels_per_meter(png_ptr: png_structp;
             info_ptr: png_infop): png_uint_32; cdecl; external PNGDLL;
function png_get_interlace_type(png_ptr: png_structp;
             info_ptr: png_infop): png_byte; cdecl; external PNGDLL;
procedure png_set_gamma(png_ptr: png_structp; screen_gamma,
             default_file_gamma: double); cdecl; external PNGDLL;
function png_get_gAMA(png_ptr: png_structp; info_ptr: png_infop;
             var file_gamma: double): png_uint_32; cdecl; external PNGDLL;
function png_get_PLTE(png_ptr: png_structp; info_ptr: png_infop;
             var palette: png_colorp; var num_palette: int):
             png_uint_32; cdecl; external PNGDLL;
function png_sig_cmp(sig: png_bytep; start, num_to_check: png_size_t):
             int; cdecl; external PNGDLL;
function png_get_channels(png_ptr: png_structp; info_ptr:png_infop):png_byte; cdecl; external PNGDLL;
{$endif}	// IEKYLIX

{$endif}	// IEINCLUDEPNG


procedure ErrorFunc(png_ptr: Pointer; msg: Pointer); {$ifdef IEKYLIX} cdecl; {$endif}
begin
	pboolean(png_ptr)^:=true;
   Abort;
end;

procedure WarnFunc(png_ptr: Pointer; msg: Pointer); {$ifdef IEKYLIX} cdecl; {$endif}
begin
end;

{$ifdef IEINCLUDEPNG}
procedure ReadFunc(png_ptr: png_structp; data: Pointer; length: png_size_t);{$ifdef IEKYLIX} cdecl; {$endif}
var
	Stream:TStream;
begin
	Stream:=png_get_io_ptr(png_ptr);
	Stream.Read(PAnsiChar(data)^,length);
end;
{$endif}



///////////////////////////////////////////////////////////////////////////////////////
// Qualora non venga fornito dal file PNG, il background viene preso da IOParams.
{$ifdef IEINCLUDEPNG}
procedure ReadPNGStream(Stream:TStream; Bitmap:TIEBitmap; var IOParams:TIOParamsVals; var xProgress:TProgressRec; Preview:boolean; var AlphaChannel:TIEMask; IgnoreAlpha:boolean);
const
 cnCanalsWithAlpha = 4;
var
 width, height:png_uint_32;

 procedure lp_PrepareAlphaChannel;
 begin
  if not assigned(AlphaChannel) then
   AlphaChannel:=TIEMask.Create;
  AlphaChannel.AllocateBits(width,height,8);
  AlphaChannel.Fill(255);
 end;

var
 l_NeedAlpha: Boolean;
 png_ptr:png_structp;
 info_ptr:png_infop;
 compression_type:integer;
 filter_type:integer;
 bit_depth, color_type, interlace_type:integer;
 Error_ptr:pointer;
 i,number_passes,pass,y:integer;
 px:pointer;
 my_background:png_color_16;
 image_background:png_color_16p;
 palette:png_colorp;
 num_palette:integer;
 channels,x:integer;
 arowbuf,apx,apx2:pbyte;
 native:boolean;
begin
 {$WARNINGS OFF}
 try
  try
	  Error_ptr := xProgress.Aborting;
   png_ptr := nil;
   png_ptr := png_create_read_struct('1.2.5', Error_ptr, @ErrorFunc, @WarnFunc);

   if png_ptr = nil then
   begin
   	xProgress.Aborting^ := true;
   	Abort;
   end;

   info_ptr := png_create_info_struct(png_ptr);

   if info_ptr=nil then
   begin
	   png_destroy_read_struct(@png_ptr, nil, nil);
    png_ptr:=nil;
   	xProgress.Aborting^:=true;
   	Abort;
   end;

   png_set_read_fn(png_ptr, Stream, @ReadFunc);
   png_read_info(png_ptr, info_ptr);
   png_get_IHDR(png_ptr, info_ptr, width, height, bit_depth, color_type,
       interlace_type, Compression_type, filter_type);
   //
   zeromemory(@my_background,sizeof(my_background));
   my_background.red := ioparams.PNG_Background.r shl 8;
	  my_background.green := ioparams.PNG_Background.g shl 8;
	  my_background.blue := ioparams.PNG_Background.b shl 8;
   if IgnoreAlpha then
   begin
    if png_get_bKGD(png_ptr, info_ptr, image_background)<>0 then
    begin
     png_set_background(png_ptr, image_background,PNG_BACKGROUND_GAMMA_FILE, 1, 1.0);
     ioparams.png_background := creatergb(image_background^.red shr 8,
                                          image_background^.green shr 8,
                                          image_background^.blue shr 8);
    end
    else
     png_set_background(png_ptr, @my_background,PNG_BACKGROUND_GAMMA_SCREEN, 0, 1.0);
   end;

   if (not IOParams.IsNativePixelFormat) or (bit_depth<>8) or
       ((color_type<>PNG_COLOR_TYPE_PALETTE) and (color_type<>PNG_COLOR_TYPE_GRAY)) then
   begin
    // Is paletted? (from 2 to 8 bit)
    if (color_type = PNG_COLOR_TYPE_PALETTE) and (bit_depth <= 8) and (bit_depth>1) then
     png_set_expand(png_ptr);
    // Is grayscale? (from 2 to 7 bit)
    if (color_type = PNG_COLOR_TYPE_GRAY) and (bit_depth < 8) and (bit_depth>1) then
     png_set_expand(png_ptr);
    // Is grayscale? (only 16 bit)
    if (bit_depth = 16) then
     png_set_strip_16(png_ptr);
    //
    if (bit_depth < 8) and (bit_depth>1) then
     png_set_packing(png_ptr);
    // Is grayscale and not blackwhite?
    if ((color_type = PNG_COLOR_TYPE_GRAY) or (color_type = PNG_COLOR_TYPE_GRAY_ALPHA)) and (bit_depth>1) then
     png_set_gray_to_rgb(png_ptr);

    if (bit_depth>1) then
     png_set_bgr(png_ptr);

    if (bit_depth = 1) and (color_type <> PNG_COLOR_TYPE_GRAY) then
    begin
     png_set_expand(png_ptr);
     bit_depth := 8;
    end;

    native:=false;
   end
   else
   	native:=true;

   number_passes := png_set_interlace_handling(png_ptr);
	  png_read_update_info(png_ptr, info_ptr);
   //
	  ioparams.width:=width;
   ioparams.height:=height;
   ioparams.bitspersample:=bit_depth;
   case color_type of
    PNG_COLOR_TYPE_GRAY       : ioparams.samplesperpixel:=1;
    PNG_COLOR_TYPE_PALETTE    : ioparams.samplesperpixel:=1;
    PNG_COLOR_TYPE_RGB        : ioparams.samplesperpixel:=3;
    PNG_COLOR_TYPE_RGB_ALPHA  : ioparams.samplesperpixel:=4;
    PNG_COLOR_TYPE_GRAY_ALPHA : ioparams.samplesperpixel:=2;
	  end;

   ioparams.dpix:=round(png_get_x_pixels_per_meter(png_ptr,info_ptr)/100*2.54);
   if ioparams.dpix=0 then
   	//ioparams.dpix:=150;
   	ioparams.dpix:=gDefaultDPIX;

   ioparams.dpiy:=round(png_get_y_pixels_per_meter(png_ptr,info_ptr)/100*2.54);

   if ioparams.dpiy=0 then
//   	ioparams.dpiy:=150;
   	ioparams.dpiy:=gDefaultDPIY;

   if IOParams.ColorMap<>nil then
   begin
   	freemem(IOParams.ColorMap);
    IOParams.fColorMap:=nil;
    IOParams.fColorMapCount:=0;
   end;

   if color_type=PNG_COLOR_TYPE_PALETTE then
   begin
   	// copy palette
    png_get_PLTE(png_ptr,info_ptr,palette,num_palette);
    IOParams.fColorMapCount:=num_palette;
    getmem(IOParams.fColorMap,3*num_palette);
    for y:=0 to num_palette-1 do
    begin
    	IOParams.fColorMap^[y].r:=palette^.red;
     IOParams.fColorMap^[y].g:=palette^.green;
     IOParams.fColorMap^[y].b:=palette^.blue;
     inc(palette);
    end;
	  end;

   if png_get_interlace_type(png_ptr,info_ptr)=PNG_INTERLACE_NONE then
	   ioparams.PNG_Interlaced:=false
   else
		  ioparams.PNG_Interlaced:=true;
   //
   if Preview then
   begin
   	png_destroy_read_struct(@png_ptr, @info_ptr, nil);
    exit;
   end;
   //
   if bit_depth=1 then
    Bitmap.Allocate(Width,Height,ie1g)
   else
    if native and (IOParams.SamplesPerPixel=1) then
    begin
		   if (IOParams.BitsPerSample<=8) and (color_type=PNG_COLOR_TYPE_PALETTE) then
     begin
			   Bitmap.Allocate(Width,Height,ie8p);
      Bitmap.PaletteUsed:=1 shl IOParams.BitsPerSample;
     	for i:=0 to IOParams.ColorMapCount-1 do
      	Bitmap.Palette[i]:=IOParams.ColorMap[i]
     end
     else
      if (IOParams.BitsPerSample=8) and (color_type=PNG_COLOR_TYPE_GRAY) then
			    Bitmap.Allocate(Width,Height,ie8g)
      else
       if (IOParams.BitsPerSample=16) and (color_type=PNG_COLOR_TYPE_GRAY) then
			     Bitmap.Allocate(Width,Height,ie16g);
    end
    else
     Bitmap.Allocate(Width,Height,ie24RGB);
	//
	  xProgress.per1:=100/(height*number_passes);
   xProgress.val:=0;

   channels := png_get_channels(png_ptr,info_ptr);
   l_NeedAlpha := not IgnoreAlpha and (channels = cnCanalsWithAlpha);
   if l_NeedAlpha then
    lp_PrepareAlphaChannel
   else
    AlphaChannel := nil;
               
   if channels=4 then
   	getmem(arowbuf,width*4)
   else
   	arowbuf:=nil;
   if l_NeedAlpha then
   	AlphaChannel.Full := false;
   for pass := 0 to number_passes-1 do
   begin
    for y := 0 to height-1 do
    begin
     px:=bitmap.scanline[y];
			  if l_NeedAlpha then
     begin
				  png_read_rows(png_ptr,@arowbuf,nil,1);
				  apx:=arowbuf;
      apx2:=AlphaChannel.ScanLine[y];
				  for x:=0 to width-1 do
      begin
      	PRGB(px)^:=PRGB(apx)^;
       inc(apx,3);
					  apx2^:=apx^;
       inc(apx2);
       inc(apx);
       inc(pbyte(px),3);
      end;
     end
     else
	     png_read_rows(png_ptr, @px, nil, 1);
     // OnProgress
     with xProgress do
     begin
      inc(val);
      if assigned(fOnProgress) then
       fOnProgress(Sender,trunc(per1*val));
     end;
     if xProgress.Aborting^ then
     	break;
    end;
    if xProgress.Aborting^ then
     break;
   end;
   if channels=4 then
   	freemem(arowbuf);
   if not xProgress.Aborting^ then
	   png_read_end(png_ptr, info_ptr);
  finally
  	if png_ptr<>nil then
		  png_destroy_read_struct(@png_ptr, @info_ptr, nil);
  end;
 except
	 on EAbort do ;
 end;
   {$WARNINGS ON}
end;
{$endif}

// return true it is a PNG stream
{$ifdef IEINCLUDEPNG}
function IsPNGStream(Stream:TStream):boolean;
var
	buf:array [0..7] of byte;
begin
	Stream.read(buf,8);
   result:=png_sig_cmp(@(buf[0]),0,4)=0;
   Stream.Seek(-8,soFromCurrent);
end;
{$endif}


{$ifdef IEDELPHI}

function ZCompressCheck(code: Integer): Integer;
begin
  result := code;

  if code < 0 then
  begin
    raise EZCompressionError.Create(_z_errmsg[2 - code]);
  end;
end;

function ZDecompressCheck(code: Integer): Integer;
begin
  Result := code;

  if code < 0 then
  begin
    raise EZDecompressionError.Create(_z_errmsg[2 - code]);
  end;
end;

procedure ZCompress(const inBuffer: Pointer; inSize: Integer;
  out outBuffer: Pointer; out outSize: Integer;
  level: TZCompressionLevel);
const
  delta = 256;
var
  zstream: TZStreamRec;
begin
  FillChar(zstream,SizeOf(TZStreamRec),0);

  outSize := ((inSize + (inSize div 10) + 12) + 255) and not 255;
  GetMem(outBuffer,outSize);

  try
    zstream.next_in := inBuffer;
    zstream.avail_in := inSize;
    zstream.next_out := outBuffer;
    zstream.avail_out := outSize;

    ZCompressCheck(DeflateInit(zstream,ZLevels[level]));

    try
      while ZCompressCheck(deflate(zstream,Z_FINISH)) <> Z_STREAM_END do
      begin
        Inc(outSize,delta);
        ReallocMem(outBuffer,outSize);

        zstream.next_out := PAnsiChar(Integer(outBuffer) + zstream.total_out);
        zstream.avail_out := delta;
      end;
    finally
      ZCompressCheck(deflateEnd(zstream));
    end;

    ReallocMem(outBuffer,zstream.total_out);
    outSize := zstream.total_out;
  except
    FreeMem(outBuffer);
    raise;
  end;
end;

procedure ZDecompress(const inBuffer: Pointer; inSize: Integer;
  out outBuffer: Pointer; out outSize: Integer; outEstimate: Integer);
var
  zstream: TZStreamRec;
  delta  : Integer;
begin
  FillChar(zstream,SizeOf(TZStreamRec),0);

  delta := (inSize + 255) and not 255;

  if outEstimate = 0 then outSize := delta
  else outSize := outEstimate;

  GetMem(outBuffer,outSize);

  try
    zstream.next_in := inBuffer;
    zstream.avail_in := inSize;
    zstream.next_out := outBuffer;
    zstream.avail_out := outSize;

    ZDecompressCheck(InflateInit(zstream));

    try
      while ZDecompressCheck(inflate(zstream,Z_NO_FLUSH)) <> Z_STREAM_END do
      begin
        Inc(outSize,delta);
        ReallocMem(outBuffer,outSize);

        zstream.next_out := PAnsiChar(Integer(outBuffer) + zstream.total_out);
        zstream.avail_out := delta;
      end;
    finally
      ZDecompressCheck(inflateEnd(zstream));
    end;

    ReallocMem(outBuffer,zstream.total_out);
    outSize := zstream.total_out;
  except
    FreeMem(outBuffer);
    raise;
  end;
end;

{** string routines *********************************************************}

function ZCompressStr(const s: String; level: TZCompressionLevel): String;
var
  buffer: Pointer;
  size  : Integer;
begin
  ZCompress(PAnsiChar(s),Length(s),buffer,size,level);

  SetLength(result,size);
  Move(buffer^,result[1],size);

  FreeMem(buffer);
end;

function ZDecompressStr(const s: String): String;
var
  buffer: Pointer;
  size  : Integer;
begin
  ZDecompress(PAnsiChar(s),Length(s),buffer,size,0);

  SetLength(result,size);
  Move(buffer^,result[1],size);

  FreeMem(buffer);
end;

{** stream routines *********************************************************}

procedure ZCompressStream(inStream, outStream: TStream;
  level: TZCompressionLevel);
const
  bufferSize = 32768;
var
  zstream  : TZStreamRec;
  zresult  : Integer;
  inBuffer : Array [0..bufferSize-1] of AnsiChar;
  outBuffer: Array [0..bufferSize-1] of AnsiChar;
  inSize   : Integer;
  outSize  : Integer;
begin
  FillChar(zstream,SizeOf(TZStreamRec),0);

  ZCompressCheck(DeflateInit(zstream,ZLevels[level]));

  inSize := inStream.Read(inBuffer,bufferSize);

  while inSize > 0 do
  begin
    zstream.next_in := inBuffer;
    zstream.avail_in := inSize;

    repeat
      zstream.next_out := outBuffer;
      zstream.avail_out := bufferSize;

      ZCompressCheck(deflate(zstream,Z_NO_FLUSH));

      // outSize := zstream.next_out - outBuffer;
      outSize := bufferSize - zstream.avail_out;

      outStream.Write(outBuffer,outSize);
    until (zstream.avail_in = 0) and (zstream.avail_out > 0);

    inSize := inStream.Read(inBuffer,bufferSize);
  end;

  repeat
    zstream.next_out := outBuffer;
    zstream.avail_out := bufferSize;

    zresult := ZCompressCheck(deflate(zstream,Z_FINISH));

    // outSize := zstream.next_out - outBuffer;
    outSize := bufferSize - zstream.avail_out;

    outStream.Write(outBuffer,outSize);
  until (zresult = Z_STREAM_END) and (zstream.avail_out > 0);

  ZCompressCheck(deflateEnd(zstream));
end;

procedure ZDecompressStream(inStream, outStream: TStream);
const
  bufferSize = 32768;
var
  zstream  : TZStreamRec;
  zresult  : Integer;
  inBuffer : Array [0..bufferSize-1] of AnsiChar;
  outBuffer: Array [0..bufferSize-1] of AnsiChar;
  inSize   : Integer;
  outSize  : Integer;
begin
  FillChar(zstream,SizeOf(TZStreamRec),0);

  ZCompressCheck(InflateInit(zstream));

  inSize := inStream.Read(inBuffer,bufferSize);

  while inSize > 0 do
  begin
    zstream.next_in := inBuffer;
    zstream.avail_in := inSize;

    repeat
      zstream.next_out := outBuffer;
      zstream.avail_out := bufferSize;

      ZCompressCheck(inflate(zstream,Z_NO_FLUSH));

      // outSize := zstream.next_out - outBuffer;
      outSize := bufferSize - zstream.avail_out;

      outStream.Write(outBuffer,outSize);
    until (zstream.avail_in = 0) and (zstream.avail_out > 0);

    inSize := inStream.Read(inBuffer,bufferSize);
  end;

  repeat
    zstream.next_out := outBuffer;
    zstream.avail_out := bufferSize;

    zresult := ZCompressCheck(inflate(zstream,Z_FINISH));

    // outSize := zstream.next_out - outBuffer;
    outSize := bufferSize - zstream.avail_out;

    outStream.Write(outBuffer,outSize);
  until (zresult = Z_STREAM_END) and (zstream.avail_out > 0);

  ZCompressCheck(inflateEnd(zstream));
end;

{** TCustomZStream **********************************************************}

constructor TCustomZStream.Create(stream: TStream);
begin
  inherited Create;

  FStream := stream;
  FStreamPos := stream.Position;
end;

procedure TCustomZStream.DoProgress;
begin
  if Assigned(FOnProgress) then FOnProgress(Self);
end;

{** TZCompressionStream *****************************************************}

constructor TZCompressionStream.Create(dest: TStream;
  compressionLevel: TZCompressionLevel);
begin
  inherited Create(dest);

  FZStream.next_out := FBuffer;
  FZStream.avail_out := SizeOf(FBuffer);

  ZCompressCheck(DeflateInit(FZStream,ZLevels[compressionLevel]));
end;

destructor TZCompressionStream.Destroy;
begin
  FZStream.next_in := Nil;
  FZStream.avail_in := 0;

  try
    if FStream.Position <> FStreamPos then FStream.Position := FStreamPos;

    while ZCompressCheck(deflate(FZStream,Z_FINISH)) <> Z_STREAM_END do
    begin
      FStream.WriteBuffer(FBuffer,SizeOf(FBuffer) - FZStream.avail_out);

      FZStream.next_out := FBuffer;
      FZStream.avail_out := SizeOf(FBuffer);
    end;

    if FZStream.avail_out < SizeOf(FBuffer) then
    begin
      FStream.WriteBuffer(FBuffer,SizeOf(FBuffer) - FZStream.avail_out);
    end;
  finally
    deflateEnd(FZStream);
  end;

  inherited Destroy;
end;

function TZCompressionStream.Read(var buffer; count: Longint): Longint;
begin
  raise EZCompressionError.Create(SZInvalid);
end;

function TZCompressionStream.Write(const buffer; count: Longint): Longint;
begin
  FZStream.next_in := @buffer;
  FZStream.avail_in := count;

  if FStream.Position <> FStreamPos then FStream.Position := FStreamPos;

  while FZStream.avail_in > 0 do
  begin
    ZCompressCheck(deflate(FZStream,Z_NO_FLUSH));

    if FZStream.avail_out = 0 then
    begin
      FStream.WriteBuffer(FBuffer,SizeOf(FBuffer));

      FZStream.next_out := FBuffer;
      FZStream.avail_out := SizeOf(FBuffer);

      FStreamPos := FStream.Position;

      DoProgress;
    end;
  end;

  result := Count;
end;

function TZCompressionStream.Seek(offset: Longint; origin: Word): Longint;
begin
  if (offset = 0) and (origin = soFromCurrent) then
  begin
    result := FZStream.total_in;
  end
  else raise EZCompressionError.Create(SZInvalid);
end;

function TZCompressionStream.GetCompressionRate: Single;
begin
  if FZStream.total_in = 0 then result := 0
  else result := (1.0 - (FZStream.total_out / FZStream.total_in)) * 100.0;
end;

{** TZDecompressionStream ***************************************************}

constructor TZDecompressionStream.Create(source: TStream);
begin
  inherited Create(source);

  FZStream.next_in := FBuffer;
  FZStream.avail_in := 0;

  ZDecompressCheck(InflateInit(FZStream));
end;

destructor TZDecompressionStream.Destroy;
begin
  inflateEnd(FZStream);

  inherited Destroy;
end;

function TZDecompressionStream.Read(var buffer; count: Longint): Longint;
var
  zresult: Integer;
begin
  FZStream.next_out := @buffer;
  FZStream.avail_out := count;

  if FStream.Position <> FStreamPos then FStream.Position := FStreamPos;

  zresult := Z_OK;

  while (FZStream.avail_out > 0) and (zresult <> Z_STREAM_END) do
  begin
    if FZStream.avail_in = 0 then
    begin
      FZStream.avail_in := FStream.Read(FBuffer,SizeOf(FBuffer));

      if FZStream.avail_in = 0 then
      begin
        result := count - FZStream.avail_out;

        Exit;
      end;

      FZStream.next_in := FBuffer;
      FStreamPos := FStream.Position;

      DoProgress;
    end;

    zresult := ZDecompressCheck(inflate(FZStream,Z_NO_FLUSH));
  end;

  if (zresult = Z_STREAM_END) and (FZStream.avail_in > 0) then
  begin
    FStream.Position := FStream.Position - FZStream.avail_in;
    FStreamPos := FStream.Position;

    FZStream.avail_in := 0;
  end;

  result := count - FZStream.avail_out;
end;

function TZDecompressionStream.Write(const Buffer; Count: Longint): Longint;
begin
  raise EZDecompressionError.Create(SZInvalid);
end;

function TZDecompressionStream.Seek(Offset: Longint; Origin: Word): Longint;
var
  buf: Array [0..8191] of Char;
  i  : Integer;
begin
  if (offset = 0) and (origin = soFromBeginning) then
  begin
    ZDecompressCheck(inflateReset(FZStream));

    FZStream.next_in := FBuffer;
    FZStream.avail_in := 0;

    FStream.Position := 0;
    FStreamPos := 0;
  end
  else if ((offset >= 0) and (origin = soFromCurrent)) or
          (((offset - FZStream.total_out) > 0) and (origin = soFromBeginning)) then
  begin
    if origin = soFromBeginning then Dec(offset,FZStream.total_out);

    if offset > 0 then
    begin
      for i := 1 to offset div SizeOf(buf) do ReadBuffer(buf,SizeOf(buf));
      ReadBuffer(buf,offset mod SizeOf(buf));
    end;
  end
  else if (offset = 0) and (origin = soFromEnd) then
  begin
    while Read(buf,SizeOf(buf)) > 0 do ;
  end
  else raise EZDecompressionError.Create(SZInvalid);

  result := FZStream.total_out;
end;


{$endif} // IEDELPHI


end.
