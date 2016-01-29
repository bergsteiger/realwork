{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{       JPEG Image Compression/Decompression Unit       }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{$HPPEMIT ''}
{$HPPEMIT '#ifdef USEPACKAGES'}
{$HPPEMIT ' #pragma link "vclimg.bpi"'}
{$HPPEMIT '#else'}
{$HPPEMIT ' #ifndef _WIN64'}
{$HPPEMIT '  #pragma link "vclimg.lib"'}
{$HPPEMIT ' #else'}
{$HPPEMIT '  #pragma link "vclimg.a"'}
{$HPPEMIT ' #endif'}
{$HPPEMIT '#endif'}
{$HPPEMIT '#pragma link "Vcl.Imaging.jpeg"'}

unit Vcl.Imaging.jpeg;

interface

{$ALIGN ON}
{$MINENUMSIZE 4}

uses
  Winapi.Windows, System.SysUtils, System.Classes, Vcl.Graphics;

type
  TJPEGData = class(TSharedImage)
  private
    FData: TCustomMemoryStream;
    FHeight: Integer;
    FWidth: Integer;
    FGrayscale: Boolean;
  protected
    procedure FreeHandle; override;
  public
    destructor Destroy; override;
  end;

  TJPEGQualityRange = 1..100;   // 100 = best quality, 25 = pretty awful
  TJPEGPerformance = (jpBestQuality, jpBestSpeed);
  TJPEGScale = (jsFullSize, jsHalf, jsQuarter, jsEighth);
  TJPEGPixelFormat = (jf24Bit, jf8Bit);

  TJPEGImage = class(TGraphic)
  private
    FImage: TJPEGData;
    FBitmap: TBitmap;
    FScaledWidth: Integer;
    FScaledHeight: Integer;
    FTempPal: HPalette;
    FSmoothing: Boolean;
    FGrayScale: Boolean;
    FPixelFormat: TJPEGPixelFormat;
    FQuality: TJPEGQualityRange;
    FProgressiveDisplay: Boolean;
    FProgressiveEncoding: Boolean;
    FPerformance: TJPEGPerformance;
    FScale: TJPEGScale;
    FNeedRecalc: Boolean;
    procedure CalcOutputDimensions;
    function GetBitmap: TBitmap;
    function GetGrayscale: Boolean;
    procedure SetGrayscale(Value: Boolean);
    procedure SetPerformance(Value: TJPEGPerformance);
    procedure SetPixelFormat(Value: TJPEGPixelFormat);
    procedure SetScale(Value: TJPEGScale);
    procedure SetSmoothing(Value: Boolean);
  protected
    procedure AssignTo(Dest: TPersistent); override;
    procedure Changed(Sender: TObject); override;
    procedure Draw(ACanvas: TCanvas; const Rect: TRect); override;
    function Equals(Graphic: TGraphic): Boolean; override;
    procedure FreeBitmap;
    function GetEmpty: Boolean; override;
    function GetHeight: Integer; override;
    function GetPalette: HPALETTE; override;
    function GetWidth: Integer; override;
    procedure NewBitmap;
    procedure NewImage;
    procedure ReadData(Stream: TStream); override;
    procedure ReadStream(Size: Longint; Stream: TStream);
    procedure SetHeight(Value: Integer); override;
    procedure SetPalette(Value: HPalette); override;
    procedure SetWidth(Value: Integer); override;
    procedure WriteData(Stream: TStream); override;
    property Bitmap: TBitmap read GetBitmap;  // volatile
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Compress;
    procedure DIBNeeded;
    procedure JPEGNeeded;
    procedure Assign(Source: TPersistent); override;
    procedure LoadFromStream(Stream: TStream); override;
    procedure SaveToStream(Stream: TStream); override;
    procedure LoadFromClipboardFormat(AFormat: Word; AData: THandle;
      APalette: HPALETTE); override;
    procedure SaveToClipboardFormat(var AFormat: Word; var AData: THandle;
      var APalette: HPALETTE); override;

    // Options affecting / reflecting compression and decompression behavior
    property Grayscale: Boolean read GetGrayscale write SetGrayscale;
    property ProgressiveEncoding: Boolean read FProgressiveEncoding write FProgressiveEncoding;

    // Compression options
    property CompressionQuality: TJPEGQualityRange read FQuality write FQuality;

    // Decompression options
    property PixelFormat: TJPEGPixelFormat read FPixelFormat write SetPixelFormat;
    property ProgressiveDisplay: Boolean read FProgressiveDisplay write FProgressiveDisplay;
    property Performance: TJPEGPerformance read FPerformance write SetPerformance;
    property Scale: TJPEGScale read FScale write SetScale;
    property Smoothing: Boolean read FSmoothing write SetSmoothing;
  end;

  TJPEGDefaults = record
    CompressionQuality: TJPEGQualityRange;
    Grayscale: Boolean;
    Performance: TJPEGPerformance;
    PixelFormat: TJPEGPixelFormat;
    ProgressiveDisplay: Boolean;
    ProgressiveEncoding: Boolean;
    Scale: TJPEGScale;
    Smoothing: Boolean;
  end;

var   // Default settings for all new TJPEGImage instances
  JPEGDefaults: TJPEGDefaults = (
    CompressionQuality: 90;
    Grayscale: False;
    Performance: jpBestQuality;
    PixelFormat: jf24Bit;         // initialized to match video mode
    ProgressiveDisplay: False;
    ProgressiveEncoding: False;
    Scale: jsFullSize;
    Smoothing: True;
  );

implementation

uses
  System.Win.Crtl, {$NOINCLUDE System.Win.Crtl}
  Vcl.Imaging.JConsts;

{ The following types and external function declarations are used to
  call into functions of the Independent JPEG Group's (IJG) implementation
  of the JPEG image compression/decompression public standard.  The IJG
  library's C source code is compiled into OBJ files and linked into
  the Delphi application. Only types and functions needed by this unit
  are declared; all IJG internal structures are stubbed out with
  generic pointers to reduce internal source code congestion.

  IJG source code copyright (C) 1991-1996, Thomas G. Lane. }

const
  JPEG_LIB_VERSION = 62;        { Version 6b }

  JPEG_RST0     = $D0;  { RST0 marker code }
  JPEG_EOI      = $D9;  { EOI marker code }
  JPEG_APP0     = $E0;  { APP0 marker code }
  JPEG_COM      = $FE;  { COM marker code }

  DCTSIZE             = 8;      { The basic DCT block is 8x8 samples }
  DCTSIZE2            = 64;     { DCTSIZE squared; # of elements in a block }
  NUM_QUANT_TBLS      = 4;      { Quantization tables are numbered 0..3 }
  NUM_HUFF_TBLS       = 4;      { Huffman tables are numbered 0..3 }
  NUM_ARITH_TBLS      = 16;     { Arith-coding tables are numbered 0..15 }
  MAX_COMPS_IN_SCAN   = 4;      { JPEG limit on # of components in one scan }
  MAX_SAMP_FACTOR     = 4;      { JPEG limit on sampling factors }
  C_MAX_BLOCKS_IN_MCU = 10;     { compressor's limit on blocks per MCU }
  D_MAX_BLOCKS_IN_MCU = 10;     { decompressor's limit on blocks per MCU }
  MAX_COMPONENTS = 10;          { maximum number of image components (color channels) }

  MAXJSAMPLE = 255;
  CENTERJSAMPLE = 128;

type
  JSAMPLE = byte;
  GETJSAMPLE = integer;
  JCOEF = integer;
  JCOEF_PTR = ^JCOEF;
  UINT8 = byte;
  UINT16 = Word;
  UINT = Cardinal;
  INT16 = SmallInt;
  INT32 = Integer;
  INT32PTR = ^INT32;
  JDIMENSION = Cardinal;

  JOCTET = Byte;
  jTOctet = 0..(MaxInt div SizeOf(JOCTET))-1;
  JOCTET_FIELD = array[jTOctet] of JOCTET;
  JOCTET_FIELD_PTR = ^JOCTET_FIELD;
  JOCTETPTR = ^JOCTET;

  JSAMPLE_PTR = ^JSAMPLE;
  JSAMPROW_PTR = ^JSAMPROW;

  jTSample = 0..(MaxInt div SIZEOF(JSAMPLE))-1;
  JSAMPLE_ARRAY = Array[jTSample] of JSAMPLE;  {far}
  JSAMPROW = ^JSAMPLE_ARRAY;  { ptr to one image row of pixel samples. }

  jTRow = 0..(MaxInt div SIZEOF(JSAMPROW))-1;
  JSAMPROW_ARRAY = Array[jTRow] of JSAMPROW;
  JSAMPARRAY = ^JSAMPROW_ARRAY;  { ptr to some rows (a 2-D sample array) }

  jTArray = 0..(MaxInt div SIZEOF(JSAMPARRAY))-1;
  JSAMP_ARRAY = Array[jTArray] of JSAMPARRAY;
  JSAMPIMAGE = ^JSAMP_ARRAY;  { a 3-D sample array: top index is color }

const
  CSTATE_START        = 100;    { after create_compress }
  CSTATE_SCANNING     = 101;    { start_compress done, write_scanlines OK }
  CSTATE_RAW_OK       = 102;    { start_compress done, write_raw_data OK }
  CSTATE_WRCOEFS      = 103;    { jpeg_write_coefficients done }
  DSTATE_START        = 200;    { after create_decompress }
  DSTATE_INHEADER     = 201;    { reading header markers, no SOS yet }
  DSTATE_READY        = 202;    { found SOS, ready for start_decompress }
  DSTATE_PRELOAD      = 203;    { reading multiscan file in start_decompress}
  DSTATE_PRESCAN      = 204;    { performing dummy pass for 2-pass quant }
  DSTATE_SCANNING     = 205;    { start_decompress done, read_scanlines OK }
  DSTATE_RAW_OK       = 206;    { start_decompress done, read_raw_data OK }
  DSTATE_BUFIMAGE     = 207;    { expecting jpeg_start_output }
  DSTATE_BUFPOST      = 208;    { looking for SOS/EOI in jpeg_finish_output }
  DSTATE_RDCOEFS      = 209;    { reading file in jpeg_read_coefficients }
  DSTATE_STOPPING     = 210;    { looking for EOI in jpeg_finish_decompress }

{ Known color spaces. }

type
  J_COLOR_SPACE = (
	JCS_UNKNOWN,            { error/unspecified }
	JCS_GRAYSCALE,          { monochrome }
	JCS_RGB,                { red/green/blue }
	JCS_YCbCr,              { Y/Cb/Cr (also known as YUV) }
	JCS_CMYK,               { C/M/Y/K }
	JCS_YCCK                { Y/Cb/Cr/K }
                  );

{ DCT/IDCT algorithm options. }

type
  J_DCT_METHOD = (
	JDCT_ISLOW,		{ slow but accurate integer algorithm }
	JDCT_IFAST,		{ faster, less accurate integer method }
	JDCT_FLOAT		{ floating-point: accurate, fast on fast HW (Pentium)}
                 );

{ Dithering options for decompression. }

type
  J_DITHER_MODE = (
    JDITHER_NONE,               { no dithering }
    JDITHER_ORDERED,            { simple ordered dither }
    JDITHER_FS                  { Floyd-Steinberg error diffusion dither }
                  );

{ Error handler }

const
  JMSG_LENGTH_MAX  = 200;  { recommended size of format_message buffer }
  JMSG_STR_PARM_MAX = 80;

  JPOOL_PERMANENT = 0;  // lasts until master record is destroyed
  JPOOL_IMAGE	    = 1;	 // lasts until done with image/datastream

type
  jpeg_error_mgr_ptr = ^jpeg_error_mgr;
  jpeg_progress_mgr_ptr = ^jpeg_progress_mgr;

  j_common_ptr = ^jpeg_common_struct;
  j_compress_ptr = ^jpeg_compress_struct;
  j_decompress_ptr = ^jpeg_decompress_struct;

{ Routine signature for application-supplied marker processing methods.
  Need not pass marker code since it is stored in cinfo^.unread_marker. }

  jpeg_marker_parser_method = function(cinfo : j_decompress_ptr) : LongBool;

  { The decompressor can save APPn and COM markers in a list of these: }

  jpeg_saved_marker_ptr = ^jpeg_marker_struct;

  jpeg_marker_struct = record
    next: jpeg_saved_marker_ptr;	{ next in list, or NULL }
    marker: Byte;			{ marker code: JPEG_COM, or JPEG_APP0+n }
    original_length: LongWord;	{ # bytes of data in the file }
    data_length: LongWord;	{ # bytes of data saved at data[] }
    data: JOCTETPTR;		{ the data contained in the marker }
    { the marker length word is not counted in data_length or original_length }
  end;

{ Marker reading & parsing }
  jpeg_marker_reader_ptr = ^jpeg_marker_reader;
  jpeg_marker_reader = record
    reset_marker_reader : procedure(cinfo : j_decompress_ptr);
    { Read markers until SOS or EOI.
      Returns same codes as are defined for jpeg_consume_input:
      JPEG_SUSPENDED, JPEG_REACHED_SOS, or JPEG_REACHED_EOI. }

    read_markers : function (cinfo : j_decompress_ptr) : Integer;
    { Read a restart marker --- exported for use by entropy decoder only }
    read_restart_marker : jpeg_marker_parser_method;

    { State of marker reader --- nominally internal, but applications
      supplying COM or APPn handlers might like to know the state. }
    saw_SOI : LongBool;            { found SOI? }
    saw_SOF : LongBool;            { found SOF? }
    next_restart_num : Integer;    { next restart number expected (0-7) }
    discarded_bytes : UINT;        { # of bytes skipped looking for a marker }
  end;

  {int8array = Array[0..8-1] of int;}
  int8array = Array[0..8-1] of Integer;

  jpeg_error_mgr = record
    { Error exit handler: does not return to caller }
    error_exit : procedure  (cinfo : j_common_ptr);
    { Conditionally emit a trace or warning message }
    emit_message : procedure (cinfo : j_common_ptr; msg_level : Integer);
    { Routine that actually outputs a trace or error message }
    output_message : procedure (cinfo : j_common_ptr);
    { Format a message string for the most recent JPEG error or message }
    format_message : procedure  (cinfo : j_common_ptr; buffer: PChar);
    { Reset error state variables at start of a new image }
    reset_error_mgr : procedure (cinfo : j_common_ptr);

    { The message ID code and any parameters are saved here.
      A message can have one string parameter or up to 8 int parameters. }

    msg_code : Integer;

    msg_parm : record
      case byte of
      0:(i : int8array);
      1:(s : array[0..JMSG_STR_PARM_MAX - 1] of AnsiChar);
    end;
    trace_level : Integer;     { max msg_level that will be displayed }
    num_warnings : Integer;    { number of corrupt-data warnings }
    jpeg_message_table: ^PAnsiChar; { Library errors }
    last_jpeg_message: Integer; { Table contains strings 0..last_jpeg_message }
    { Second table can be added by application (see cjpeg/djpeg for example).
      It contains strings numbered first_addon_message..last_addon_message.
    }
    addon_message_table: ^PAnsiChar; { Non-library errors }
    first_addon_message: Integer; { code for first string in addon table }
    last_addon_message: Integer;  { code for last string in addon table }
  end;


{ Data destination object for compression }
  jpeg_destination_mgr_ptr = ^jpeg_destination_mgr;
  jpeg_destination_mgr = record
    next_output_byte : JOCTETptr;  { => next byte to write in buffer }
    free_in_buffer : Longint;    { # of byte spaces remaining in buffer }

    init_destination : procedure (cinfo : j_compress_ptr);
    empty_output_buffer : function (cinfo : j_compress_ptr) : LongBool;
    term_destination : procedure (cinfo : j_compress_ptr);
  end;

{ Data source object for decompression }

  jpeg_source_mgr_ptr = ^jpeg_source_mgr;
  jpeg_source_mgr = record
    next_input_byte : JOCTETptr;      { => next byte to read from buffer }
    bytes_in_buffer : Longint;       { # of bytes remaining in buffer }

    init_source : procedure  (cinfo : j_decompress_ptr);
    fill_input_buffer : function (cinfo : j_decompress_ptr) : LongBool;
    skip_input_data : procedure (cinfo : j_decompress_ptr; num_bytes : Longint);
    resync_to_restart : function (cinfo : j_decompress_ptr;
                                  desired : Integer) : LongBool;
    term_source : procedure (cinfo : j_decompress_ptr);
  end;

{ JPEG library memory manger routines }
  jpeg_memory_mgr_ptr = ^jpeg_memory_mgr;
  jpeg_memory_mgr = record
    { Method pointers }
    alloc_small : function (cinfo : j_common_ptr;
                            pool_id, sizeofobject: Integer): pointer;
    alloc_large : function (cinfo : j_common_ptr;
                            pool_id, sizeofobject: Integer): pointer;
    alloc_sarray : function (cinfo : j_common_ptr; pool_id : Integer;
                             samplesperrow : JDIMENSION;
                             numrows : JDIMENSION) : JSAMPARRAY;
    alloc_barray : pointer;
    request_virt_sarray : pointer;
    request_virt_barray : pointer;
    realize_virt_arrays : pointer;
    access_virt_sarray : pointer;
    access_virt_barray : pointer;
    free_pool : pointer;
    self_destruct : pointer;
    max_memory_to_use : Longint;

    { Maximum allocation request accepted by alloc_large. }
    max_alloc_chunk: Longint;
  end;

    { Fields shared with jpeg_decompress_struct }
  jpeg_common_struct = record
    err : jpeg_error_mgr_ptr;        { Error handler module }
    mem : jpeg_memory_mgr_ptr;          { Memory manager module }
    progress : jpeg_progress_mgr_ptr;   { Progress monitor, or NIL if none }
    client_data: Pointer;            { Available for use by application }
    is_decompressor : LongBool;      { so common code can tell which is which }
    global_state : Integer;          { for checking call sequence validity }
  end;

{ Progress monitor object }

  jpeg_progress_mgr = record
    progress_monitor : procedure(const cinfo : jpeg_common_struct);
    pass_counter : Integer;     { work units completed in this pass }
    pass_limit : Integer;       { total number of work units in this pass }
    completed_passes : Integer;	{ passes completed so far }
    total_passes : Integer;     { total number of passes expected }
    // extra Delphi info
    instance: TJPEGImage;       // ptr to current TJPEGImage object
    last_pass: Integer;
    last_pct: Integer;
    last_time: Integer;
    last_scanline: Integer;
  end;

{ Master record for a compression instance }

  jpeg_compress_struct = record
    common: jpeg_common_struct;

    dest : jpeg_destination_mgr_ptr; { Destination for compressed data }

  { Description of source image --- these fields must be filled in by
    outer application before starting compression.  in_color_space must
    be correct before you can even call jpeg_set_defaults(). }

    image_width : JDIMENSION;         { input image width }
    image_height : JDIMENSION;        { input image height }
    input_components : Integer;       { # of color components in input image }
    in_color_space : J_COLOR_SPACE;   { colorspace of input image }
    input_gamma : double;             { image gamma of input image }

    // Compression parameters
    data_precision : Integer;             { bits of precision in image data }
    num_components : Integer;             { # of color components in JPEG image }
    jpeg_color_space : J_COLOR_SPACE;     { colorspace of JPEG image }
    comp_info : Pointer;
    quant_tbl_ptrs: Array[0..NUM_QUANT_TBLS-1] of Pointer;
    dc_huff_tbl_ptrs : Array[0..NUM_HUFF_TBLS-1] of Pointer;
    ac_huff_tbl_ptrs : Array[0..NUM_HUFF_TBLS-1] of Pointer;
    arith_dc_L : Array[0..NUM_ARITH_TBLS-1] of UINT8; { L values for DC arith-coding tables }
    arith_dc_U : Array[0..NUM_ARITH_TBLS-1] of UINT8; { U values for DC arith-coding tables }
    arith_ac_K : Array[0..NUM_ARITH_TBLS-1] of UINT8; { Kx values for AC arith-coding tables }
    num_scans : Integer;		 { # of entries in scan_info array }
    scan_info : Pointer;     { script for multi-scan file, or NIL }
    raw_data_in : LongBool;        { TRUE=caller supplies downsampled data }
    arith_code : LongBool;         { TRUE=arithmetic coding, FALSE=Huffman }
    optimize_coding : LongBool;    { TRUE=optimize entropy encoding parms }
    CCIR601_sampling : LongBool;   { TRUE=first samples are cosited }
    smoothing_factor : Integer;       { 1..100, or 0 for no input smoothing }
    dct_method : J_DCT_METHOD;    { DCT algorithm selector }
    restart_interval : UINT;      { MCUs per restart, or 0 for no restart }
    restart_in_rows : Integer;        { if > 0, MCU rows per restart interval }

    { Parameters controlling emission of special markers. }
    write_JFIF_header : LongBool;  { should a JFIF marker be written? }
    JFIF_major_version: UINT8;      { What to write for a JFIF version number }
    JFIF_minor_version: UINT8;
    { These three values are not used by the JPEG code, merely copied }
    { into the JFIF APP0 marker.  density_unit can be 0 for unknown, }
    { 1 for dots/inch, or 2 for dots/cm.  Note that the pixel aspect }
    { ratio is defined by X_density/Y_density even when density_unit=0. }
    density_unit : UINT8;         { JFIF code for pixel size units }
    X_density : UINT16;           { Horizontal pixel density }
    Y_density : UINT16;           { Vertical pixel density }
    write_Adobe_marker : LongBool; { should an Adobe marker be written? }

    { State variable: index of next scanline to be written to
      jpeg_write_scanlines().  Application may use this to control its
      processing loop, e.g., "while (next_scanline < image_height)". }

    next_scanline : JDIMENSION;   { 0 .. image_height-1  }

    { Remaining fields are known throughout compressor, but generally
      should not be touched by a surrounding application. }
    progressive_mode : LongBool;   { TRUE if scan script uses progressive mode }
    max_h_samp_factor : Integer;      { largest h_samp_factor }
    max_v_samp_factor : Integer;      { largest v_samp_factor }
    total_iMCU_rows : JDIMENSION; { # of iMCU rows to be input to coef ctlr }
    comps_in_scan : Integer;          { # of JPEG components in this scan }
    cur_comp_info : Array[0..MAX_COMPS_IN_SCAN-1] of Pointer;
    MCUs_per_row : JDIMENSION;    { # of MCUs across the image }
    MCU_rows_in_scan : JDIMENSION;{ # of MCU rows in the image }
    blocks_in_MCU : Integer;          { # of DCT blocks per MCU }
    MCU_membership : Array[0..C_MAX_BLOCKS_IN_MCU-1] of Integer;
    Ss, Se, Ah, Al : Integer;         { progressive JPEG parameters for scan }

    { Links to compression subobjects (methods and private variables of modules) }
    master : Pointer;
    main : Pointer;
    prep : Pointer;
    coef : Pointer;
    marker : Pointer;
    cconvert : Pointer;
    downsample : Pointer;
    fdct : Pointer;
    entropy : Pointer;
    script_space: Pointer;  { workspace for jpeg_simple_progression }
    script_space_size: Integer;
  end;


{ Master record for a decompression instance }

  jpeg_decompress_struct = record
    common: jpeg_common_struct;

    { Source of compressed data }
    src : jpeg_source_mgr_ptr;

    { Basic description of image --- filled in by jpeg_read_header(). }
    { Application may inspect these values to decide how to process image. }

    image_width : JDIMENSION;      { nominal image width (from SOF marker) }
    image_height : JDIMENSION;     { nominal image height }
    num_components : Integer;          { # of color components in JPEG image }
    jpeg_color_space : J_COLOR_SPACE; { colorspace of JPEG image }

    { Decompression processing parameters }
    out_color_space : J_COLOR_SPACE; { colorspace for output }
    scale_num, scale_denom : uint ;  { fraction by which to scale image }
    output_gamma : double;           { image gamma wanted in output }
    buffered_image : LongBool;        { TRUE=multiple output passes }
    raw_data_out : LongBool;          { TRUE=downsampled data wanted }
    dct_method : J_DCT_METHOD;       { IDCT algorithm selector }
    do_fancy_upsampling : LongBool;   { TRUE=apply fancy upsampling }
    do_block_smoothing : LongBool;    { TRUE=apply interblock smoothing }
    quantize_colors : LongBool;       { TRUE=colormapped output wanted }
    { the following are ignored if not quantize_colors: }
    dither_mode : J_DITHER_MODE;     { type of color dithering to use }
    two_pass_quantize : LongBool;     { TRUE=use two-pass color quantization }
    desired_number_of_colors : Integer;  { max # colors to use in created colormap }
    { these are significant only in buffered-image mode: }
    enable_1pass_quant : LongBool;    { enable future use of 1-pass quantizer }
    enable_external_quant : LongBool; { enable future use of external colormap }
    enable_2pass_quant : LongBool;    { enable future use of 2-pass quantizer }

    { Description of actual output image that will be returned to application.
      These fields are computed by jpeg_start_decompress().
      You can also use jpeg_calc_output_dimensions() to determine these values
      in advance of calling jpeg_start_decompress(). }

    output_width : JDIMENSION;       { scaled image width }
    output_height: JDIMENSION;       { scaled image height }
    out_color_components : Integer;  { # of color components in out_color_space }
    output_components : Integer;     { # of color components returned }
    { output_components is 1 (a colormap index) when quantizing colors;
      otherwise it equals out_color_components. }

    rec_outbuf_height : Integer;     { min recommended height of scanline buffer }
    { If the buffer passed to jpeg_read_scanlines() is less than this many
      rows high, space and time will be wasted due to unnecessary data
      copying. Usually rec_outbuf_height will be 1 or 2, at most 4. }

    { When quantizing colors, the output colormap is described by these
      fields. The application can supply a colormap by setting colormap
      non-NIL before calling jpeg_start_decompress; otherwise a colormap
      is created during jpeg_start_decompress or jpeg_start_output. The map
      has out_color_components rows and actual_number_of_colors columns. }

    actual_number_of_colors : Integer;      { number of entries in use }
    colormap : JSAMPARRAY;              { The color map as a 2-D pixel array }

    { State variables: these variables indicate the progress of decompression.
      The application may examine these but must not modify them. }

    { Row index of next scanline to be read from jpeg_read_scanlines().
      Application may use this to control its processing loop, e.g.,
      "while (output_scanline < output_height)". }

    output_scanline : JDIMENSION; { 0 .. output_height-1  }

    { Current input scan number and number of iMCU rows completed in scan.
      These indicate the progress of the decompressor input side. }

    input_scan_number : Integer;      { Number of SOS markers seen so far }
    input_iMCU_row : JDIMENSION;  { Number of iMCU rows completed }

    { The "output scan number" is the notional scan being displayed by the
      output side.  The decompressor will not allow output scan/row number
      to get ahead of input scan/row, but it can fall arbitrarily far behind.}

    output_scan_number : Integer;     { Nominal scan number being displayed }
    output_iMCU_row : Integer;        { Number of iMCU rows read }

    coef_bits : Pointer;

    { Internal JPEG parameters --- the application usually need not look at
      these fields.  Note that the decompressor output side may not use
      any parameters that can change between scans. }

    { Quantization and Huffman tables are carried forward across input
      datastreams when processing abbreviated JPEG datastreams. }

    quant_tbl_ptrs : Array[0..NUM_QUANT_TBLS-1] of Pointer;
    dc_huff_tbl_ptrs : Array[0..NUM_HUFF_TBLS-1] of Pointer;
    ac_huff_tbl_ptrs : Array[0..NUM_HUFF_TBLS-1] of Pointer;

    { These parameters are never carried across datastreams, since they
      are given in SOF/SOS markers or defined to be reset by SOI. }
    data_precision : Integer;          { bits of precision in image data }
    comp_info : Pointer;
    progressive_mode : LongBool;    { TRUE if SOFn specifies progressive mode }
    arith_code : LongBool;          { TRUE=arithmetic coding, FALSE=Huffman }
    arith_dc_L : Array[0..NUM_ARITH_TBLS-1] of UINT8; { L values for DC arith-coding tables }
    arith_dc_U : Array[0..NUM_ARITH_TBLS-1] of UINT8; { U values for DC arith-coding tables }
    arith_ac_K : Array[0..NUM_ARITH_TBLS-1] of UINT8; { Kx values for AC arith-coding tables }

    restart_interval : UINT; { MCUs per restart interval, or 0 for no restart }

    { These fields record data obtained from optional markers recognized by
      the JPEG library. }
    saw_JFIF_marker : LongBool;  { TRUE iff a JFIF APP0 marker was found }
    { Data copied from JFIF marker: only valid if saw_JFIF_marker is TRUE: }
    JFIF_major_version: UINT8;    { JFIF version number }
    JFIF_minor_version: UINT8;
    density_unit : UINT8;       { JFIF code for pixel size units }
    X_density : UINT16;         { Horizontal pixel density }
    Y_density : UINT16;         { Vertical pixel density }
    saw_Adobe_marker : LongBool; { TRUE iff an Adobe APP14 marker was found }
    Adobe_transform : UINT8;    { Color transform code from Adobe marker }

    CCIR601_sampling : LongBool; { TRUE=first samples are cosited }

    { Aside from the specific data retained from APPn markers known to the
      library, the uninterpreted contents of any or all APPn and COM markers
      can be saved in a list for examination by the application. }
    marker_list: jpeg_saved_marker_ptr; { Head of list of saved markers }

    { Remaining fields are known throughout decompressor, but generally
      should not be touched by a surrounding application. }
    max_h_samp_factor : Integer;    { largest h_samp_factor }
    max_v_samp_factor : Integer;    { largest v_samp_factor }
    min_DCT_scaled_size : Integer;  { smallest DCT_scaled_size of any component }
    total_iMCU_rows : JDIMENSION; { # of iMCU rows in image }
    sample_range_limit : Pointer;   { table for fast range-limiting }

    { These fields are valid during any one scan.
      They describe the components and MCUs actually appearing in the scan.
      Note that the decompressor output side must not use these fields. }
    comps_in_scan : Integer;           { # of JPEG components in this scan }
    cur_comp_info : Array[0..MAX_COMPS_IN_SCAN-1] of Pointer;
    MCUs_per_row : JDIMENSION;     { # of MCUs across the image }
    MCU_rows_in_scan : JDIMENSION; { # of MCU rows in the image }
    blocks_in_MCU : JDIMENSION;    { # of DCT blocks per MCU }
    MCU_membership : Array[0..D_MAX_BLOCKS_IN_MCU-1] of Integer;
    Ss, Se, Ah, Al : Integer;          { progressive JPEG parameters for scan }

    { This field is shared between entropy decoder and marker parser.
      It is either zero or the code of a JPEG marker that has been
      read from the data source, but has not yet been processed. }
    unread_marker : Integer;

    { Links to decompression subobjects
      (methods, private variables of modules) }
    master : Pointer;
    main : Pointer;
    coef : Pointer;
    post : Pointer;
    inputctl : Pointer;
    marker : Pointer;
    entropy : Pointer;
    idct : Pointer;
    upsample : Pointer;
    cconvert : Pointer;
    cquantize : Pointer;
  end;

  TJPEGContext = record
    err: jpeg_error_mgr;
    progress: jpeg_progress_mgr;
    FinalDCT: J_DCT_METHOD;
    FinalTwoPassQuant: Boolean;
    FinalDitherMode: J_DITHER_MODE;
    case byte of
      0: (common: jpeg_common_struct);
      1: (d: jpeg_decompress_struct);
      2: (c: jpeg_compress_struct);
  end;

{ Decompression startup: read start of JPEG datastream to see what's there
   function jpeg_read_header (cinfo : j_decompress_ptr;
                              require_image : LongBool) : Integer;
  Return value is one of: }
const
  JPEG_SUSPENDED              = 0; { Suspended due to lack of input data }
  JPEG_HEADER_OK              = 1; { Found valid image datastream }
  JPEG_HEADER_TABLES_ONLY     = 2; { Found valid table-specs-only datastream }
{ If you pass require_image = TRUE (normal case), you need not check for
  a TABLES_ONLY return code; an abbreviated file will cause an error exit.
  JPEG_SUSPENDED is only possible if you use a data source module that can
  give a suspension return (the stdio source module doesn't). }


{ function jpeg_consume_input (cinfo : j_decompress_ptr) : Integer;
  Return value is one of: }

  JPEG_REACHED_SOS            = 1; { Reached start of new scan }
  JPEG_REACHED_EOI            = 2; { Reached end of image }
  JPEG_ROW_COMPLETED          = 3; { Completed one iMCU row }
  JPEG_SCAN_COMPLETED         = 4; { Completed last iMCU row of a scan }


procedure jpeg_CreateDecompress (var cinfo : jpeg_decompress_struct;
  version : integer; structsize : integer); external;
procedure jpeg_stdio_src(var cinfo: jpeg_decompress_struct;
  input_file: TStream); external;
procedure jpeg_read_header(var cinfo: jpeg_decompress_struct;
  RequireImage: LongBool); external;
procedure jpeg_calc_output_dimensions(var cinfo: jpeg_decompress_struct); external;
procedure jpeg_save_markers(var cinfo: jpeg_decompress_struct; marker_code: Integer;
  length_limit: UINT); external;
function jpeg_start_decompress(var cinfo: jpeg_decompress_struct): Longbool; external;
function jpeg_read_scanlines(var cinfo: jpeg_decompress_struct;
	scanlines: JSAMPARRAY; max_lines: JDIMENSION): JDIMENSION; external;
function jpeg_finish_decompress(var cinfo: jpeg_decompress_struct): Longbool; external;
procedure jpeg_destroy_decompress (var cinfo : jpeg_decompress_struct); external;
function jpeg_has_multiple_scans(var cinfo: jpeg_decompress_struct): Longbool; external;
function jpeg_consume_input(var cinfo: jpeg_decompress_struct): Integer; external;
function jpeg_start_output(var cinfo: jpeg_decompress_struct; scan_number: Integer): Longbool; external;
function jpeg_finish_output(var cinfo: jpeg_decompress_struct): LongBool; external;
procedure jpeg_destroy(var cinfo: jpeg_common_struct); external;
procedure jpeg_CreateCompress (var cinfo : jpeg_compress_struct;
  version : integer; structsize : integer); external;
procedure jpeg_stdio_dest(var cinfo: jpeg_compress_struct;
  output_file: TStream); external;
procedure jpeg_set_defaults(var cinfo: jpeg_compress_struct); external;
procedure jpeg_set_quality(var cinfo: jpeg_compress_struct; Quality: Integer;
  Baseline: Longbool); external;
procedure jpeg_set_colorspace(var cinfo: jpeg_compress_struct;
  colorspace: J_COLOR_SPACE); external;
procedure jpeg_simple_progression(var cinfo: jpeg_compress_struct); external;
procedure jpeg_start_compress(var cinfo: jpeg_compress_struct;
  WriteAllTables: LongBool); external;
function jpeg_write_scanlines(var cinfo: jpeg_compress_struct;
  scanlines: JSAMPARRAY; max_lines: JDIMENSION): JDIMENSION; external;
procedure jpeg_finish_compress(var cinfo: jpeg_compress_struct); external;

{$L jdapimin.obj}
{$L jmemmgr.obj}
{$L jmemnobs.obj}
{$L jdinput.obj}
{$L jdatasrc.obj}
{$L jdapistd.obj}
{$L jdmaster.obj}
{$L jdphuff.obj}
{$L jdhuff.obj}
{$L jdmerge.obj}
{$L jdcolor.obj}
{$L jquant1.obj}
{$L jquant2.obj}
{$L jdmainct.obj}
{$L jdcoefct.obj}
{$L jdpostct.obj}
{$L jddctmgr.obj}
{$L jdsample.obj}
{$L jidctflt.obj}
{$L jidctfst.obj}
{$L jidctint.obj}
{$L jidctred.obj}
{$L jdmarker.obj}
{$L jutils.obj}
{$L jcomapi.obj}
{$L jdatadst.obj}
{$L jcparam.obj}
{$L jcapistd.obj}
{$L jcapimin.obj}
{$L jcinit.obj}
{$L jcmarker.obj}
{$L jcmaster.obj}
{$L jcmainct.obj}
{$L jcprepct.obj}
{$L jccoefct.obj}
{$L jccolor.obj}
{$L jcsample.obj}
{$L jcdctmgr.obj}
{$L jcphuff.obj}
{$L jfdctint.obj}
{$L jfdctfst.obj}
{$L jfdctflt.obj}
{$L jchuff.obj}

// External functions referenced by JPEG OBJ files.
// These are replacements for fread, fwrite, and fflush.
// These are fastcall on Win32, not cdecl.

function jfread(var buf; recsize, reccount: Integer; S: TStream): Integer;
begin
  Result := S.Read(buf, recsize * reccount);
end;

function jfwrite(const buf; recsize, reccount: Integer; S: TStream): Integer;
begin
  Result := S.Write(buf, recsize * reccount);
end;

function jfflush(S: TStream): Integer;
begin
  Result := 0;
end;

type
  EJPEG = class(EInvalidGraphic);

procedure InvalidOperation(const Msg: string); near;
begin
  raise EInvalidGraphicOperation.Create(Msg);
end;

procedure JpegError(cinfo: j_common_ptr);
begin
  raise EJPEG.CreateFmt(sJPEGError,[cinfo^.err^.msg_code]);
end;

procedure EmitMessage(cinfo: j_common_ptr; msg_level: Integer);
begin
  //!!
end;

procedure OutputMessage(cinfo: j_common_ptr);
begin
  //!!
end;

procedure FormatMessage(cinfo: j_common_ptr; buffer: PChar);
begin
  //!!
end;

procedure ResetErrorMgr(cinfo: j_common_ptr);
begin
  cinfo^.err^.num_warnings := 0;
  cinfo^.err^.msg_code := 0;
end;

const
  jpeg_std_error: jpeg_error_mgr = (
    error_exit: JpegError;
    emit_message: EmitMessage;
    output_message: OutputMessage;
    format_message: FormatMessage;
    reset_error_mgr: ResetErrorMgr);

{ TJPEGData }

destructor TJPEGData.Destroy;
begin
  FData.Free;
  inherited Destroy;
end;

procedure TJPEGData.FreeHandle;
begin
end;

{ TJPEGImage }

constructor TJPEGImage.Create;
begin
  inherited Create;
  NewImage;
  FQuality := JPEGDefaults.CompressionQuality;
  FGrayscale := JPEGDefaults.Grayscale;
  FPerformance := JPEGDefaults.Performance;
  FPixelFormat := JPEGDefaults.PixelFormat;
  FProgressiveDisplay := JPEGDefaults.ProgressiveDisplay;
  FProgressiveEncoding := JPEGDefaults.ProgressiveEncoding;
  FScale := JPEGDefaults.Scale;
  FSmoothing := JPEGDefaults.Smoothing;
end;

destructor TJPEGImage.Destroy;
begin
  if FTempPal <> 0 then DeleteObject(FTempPal);
  FBitmap.Free;
  FImage.Release;
  inherited Destroy;
end;

procedure TJPEGImage.Assign(Source: TPersistent);
begin
  if Source is TJPEGImage then
  begin
    FImage.Release;
    FImage := TJPEGImage(Source).FImage;
    FImage.Reference;
    if TJPEGImage(Source).FBitmap <> nil then
    begin
      NewBitmap;
      FBitmap.Assign(TJPEGImage(Source).FBitmap);
    end;
  end
  else if Source is TBitmap then
  begin
    NewImage;
    NewBitmap;
    FBitmap.Assign(Source);
  end
  else
    inherited Assign(Source);
end;

procedure TJPEGImage.AssignTo(Dest: TPersistent);
begin
  if Dest is TBitmap then
    Dest.Assign(Bitmap)
  else
    inherited AssignTo(Dest);
end;

procedure ProgressCallback(const cinfo: jpeg_common_struct);
var
  Ticks: DWORD;
  R: TRect;
  temp: DWORD;
begin
  if (cinfo.progress = nil) or (cinfo.progress^.instance = nil) then Exit;
  with cinfo.progress^ do
  begin
    Ticks := GetTickCount;
    if (Ticks - DWORD(last_time)) < 500 then Exit;
    temp := DWORD(last_time);
    DWORD(last_time) := Ticks;
    if temp = 0 then Exit;
    if cinfo.is_decompressor then
      with j_decompress_ptr(@cinfo)^ do
      begin
        R := Rect(0, last_scanline, output_width, output_scanline);
        if R.Bottom < last_scanline then
          R.Bottom := output_height;
      end
    else
      R := Rect(0,0,0,0);
    temp := DWORD(Trunc(100.0*(completed_passes + (pass_counter/pass_limit))/total_passes));
    if temp = DWORD(last_pct) then Exit;
    last_pct := temp;
    if cinfo.is_decompressor then
      last_scanline := j_decompress_ptr(@cinfo)^.output_scanline;
    instance.Progress(instance, psRunning, temp, (R.Bottom - R.Top) >= 4, R, '');
  end;
end;

procedure ReleaseContext(var jc: TJPEGContext);
begin
  if jc.common.err = nil then Exit;
  jpeg_destroy(jc.common);
  jc.common.err := nil;
end;

procedure InitDecompressor(Obj: TJPEGImage; var jc: TJPEGContext);
begin
  FillChar(jc, sizeof(jc), 0);
  jc.err := jpeg_std_error;
  jc.common.err := @jc.err;

  jpeg_CreateDecompress(jc.d, JPEG_LIB_VERSION, sizeof(jc.d));
  with Obj do
  try
    jc.progress.progress_monitor := ProgressCallback;
    jc.progress.instance := Obj;
    jc.common.progress := @jc.progress;

    Obj.FImage.FData.Position := 0;
    jpeg_stdio_src(jc.d, FImage.FData);
    jpeg_read_header(jc.d, TRUE);

    jc.d.scale_num := 1;
    jc.d.scale_denom := 1 shl Byte(FScale);
    jc.d.do_block_smoothing := FSmoothing;

    if FGrayscale then jc.d.out_color_space := JCS_GRAYSCALE;
    if (PixelFormat = jf8Bit) or (jc.d.out_color_space = JCS_GRAYSCALE) then
    begin
      jc.d.quantize_colors := True;
      jc.d.desired_number_of_colors := 236;
    end;

    if FPerformance = jpBestSpeed then
    begin
      jc.d.dct_method := JDCT_IFAST;
      jc.d.two_pass_quantize := False;
//      jc.d.do_fancy_upsampling := False;    !! AV inside jpeglib
      jc.d.dither_mode := JDITHER_ORDERED;
    end;

    jc.FinalDCT := jc.d.dct_method;
    jc.FinalTwoPassQuant := jc.d.two_pass_quantize;
    jc.FinalDitherMode := jc.d.dither_mode;
    if FProgressiveDisplay and jpeg_has_multiple_scans(jc.d) then
    begin  // save requested settings, reset for fastest on all but last scan
      jc.d.enable_2pass_quant := jc.d.two_pass_quantize;
      jc.d.dct_method := JDCT_IFAST;
      jc.d.two_pass_quantize := False;
      jc.d.dither_mode := JDITHER_ORDERED;
      jc.d.buffered_image := True;
    end;
  except
    ReleaseContext(jc);
    raise;
  end;
end;

procedure TJPEGImage.CalcOutputDimensions;
var
  jc: TJPEGContext;
begin
  if not FNeedRecalc then Exit;
  InitDecompressor(Self, jc);
  try
    jc.common.progress := nil;
    jpeg_calc_output_dimensions(jc.d);
    // read output dimensions
    FScaledWidth := jc.d.output_width;
    FScaledHeight := jc.d.output_height;
    FProgressiveEncoding := jpeg_has_multiple_scans(jc.d);
  finally
    ReleaseContext(jc);
  end;
end;

procedure TJPEGImage.Changed(Sender: TObject);
begin
  inherited Changed(Sender);
end;

procedure TJPEGImage.Compress;
var
  LinesWritten, LinesPerCall: Integer;
  SrcScanLine: Pointer;
  PtrInc: Integer;
  jc: TJPEGContext;
  Src: TBitmap;
begin
  FillChar(jc, sizeof(jc), 0);
  jc.err := jpeg_std_error;
  jc.common.err := @jc.err;

  jpeg_CreateCompress(jc.c, JPEG_LIB_VERSION, sizeof(jc.c));
  try
    try
      jc.progress.progress_monitor := ProgressCallback;
      jc.progress.instance := Self;
      jc.common.progress := @jc.progress;

      if FImage.FData <> nil then NewImage;
      FImage.FData := TMemoryStream.Create;
      FImage.FData.Position := 0;
      jpeg_stdio_dest(jc.c, FImage.FData);

      if (FBitmap = nil) or (FBitmap.Width = 0) or (FBitmap.Height = 0) then Exit;
      jc.c.image_width := FBitmap.Width;
      FImage.FWidth := FBitmap.Width;
      jc.c.image_height := FBitmap.Height;
      FImage.FHeight := FBitmap.Height;
      jc.c.input_components := 3;           // JPEG requires 24bit RGB input
      jc.c.in_color_space := JCS_RGB;

      Src := TBitmap.Create;
      try
        Src.Assign(FBitmap);
        Src.PixelFormat := pf24bit;

        jpeg_set_defaults(jc.c);
        jpeg_set_quality(jc.c, FQuality, True);

        if FGrayscale then
        begin
          FImage.FGrayscale := True;
          jpeg_set_colorspace(jc.c, JCS_GRAYSCALE);
        end;

        if ProgressiveEncoding then
          jpeg_simple_progression(jc.c);
        SrcScanline := Src.ScanLine[0];
        if jc.c.image_height > 1 then
        begin
          PtrInc := IntPtr(Src.ScanLine[1]) - IntPtr(SrcScanline);

            // if no dword padding required and source bitmap is top-down
          if (PtrInc > 0) and ((PtrInc and 3) = 0) then
            LinesPerCall := jc.c.image_height  // do whole bitmap in one call
          else
            LinesPerCall := 1;      // otherwise spoonfeed one row at a time
        end
        else
        begin
          LinesPerCall := 1;
          PtrInc := 0;
        end;

        Progress(Self, psStarting, 0, False, Rect(0,0,0,0), '');
        try
          jpeg_start_compress(jc.c, True);

          while (jc.c.next_scanline < jc.c.image_height) do
          begin
            LinesWritten := jpeg_write_scanlines(jc.c, @SrcScanline, LinesPerCall);
            SrcScanline := PByte(SrcScanline) + (PtrInc * LinesWritten);
          end;

          jpeg_finish_compress(jc.c);
        finally
          if ExceptObject = nil then
            PtrInc := 100
          else
            PtrInc := 0;
          Progress(Self, psEnding, PtrInc, False, Rect(0,0,0,0), '');
        end;
      finally
        Src.Free;
      end;
    except
      on EAbort do    // OnProgress can raise EAbort to cancel image save
        NewImage;     // Throw away any partial jpg data
    end;
  finally
    ReleaseContext(jc);
  end;
end;

procedure TJPEGImage.DIBNeeded;
begin
  GetBitmap;
end;

procedure TJPEGImage.Draw(ACanvas: TCanvas; const Rect: TRect);
begin
  ACanvas.StretchDraw(Rect, Bitmap);
end;

function TJPEGImage.Equals(Graphic: TGraphic): Boolean;
begin
  Result := False;
  if not (Graphic is TJPEGImage) then Exit;
  // Only call the inherited if both ends have compressed data.
  // We don't want to set off a compression cycle to create the FData stream
  if (FImage.FData <> nil) and (TJPEGImage(Graphic).FImage.FData <> nil) then
    Result := inherited Equals(Graphic)
  else  // FImage is shared if Assign is used to copy between TJPEGImage instances
    Result := (FImage = TJPEGImage(Graphic).FImage);
end;

procedure TJPEGImage.FreeBitmap;
begin
  FBitmap.Free;
  FBitmap := nil;
end;

function BuildPalette(const cinfo: jpeg_decompress_struct): HPalette;
var
  Pal: TMaxLogPalette;
  I: Integer;
  C: Byte;
begin
  Pal.palVersion := $300;
  Pal.palNumEntries := cinfo.actual_number_of_colors;
  if cinfo.out_color_space = JCS_GRAYSCALE then
    for I := 0 to Pal.palNumEntries-1 do
    begin
      C := cinfo.colormap^[0]^[I];
      Pal.palPalEntry[I].peRed := C;
      Pal.palPalEntry[I].peGreen := C;
      Pal.palPalEntry[I].peBlue := C;
      Pal.palPalEntry[I].peFlags := 0;
    end
  else
    for I := 0 to Pal.palNumEntries-1 do
    begin
      Pal.palPalEntry[I].peRed := cinfo.colormap^[2]^[I];
      Pal.palPalEntry[I].peGreen := cinfo.colormap^[1]^[I];
      Pal.palPalEntry[I].peBlue := cinfo.colormap^[0]^[I];
      Pal.palPalEntry[I].peFlags := 0;
    end;
  Result := CreatePalette(PLogPalette(@Pal)^);
end;

procedure BuildColorMap(var cinfo: jpeg_decompress_struct; P: HPalette);
var
  Pal: TMaxLogPalette;
  Count, I: Integer;
begin
  Count := GetPaletteEntries(P, 0, 256, Pal.palPalEntry);
  if Count = 0 then Exit;       // jpeg_destroy will free colormap
  cinfo.colormap := cinfo.common.mem.alloc_sarray(@cinfo.common, JPOOL_IMAGE, Count, 3);
  cinfo.actual_number_of_colors := Count;
  for I := 0 to Count-1 do
  begin
    Byte(cinfo.colormap^[2]^[I]) := Pal.palPalEntry[I].peRed;
    Byte(cinfo.colormap^[1]^[I]) := Pal.palPalEntry[I].peGreen;
    Byte(cinfo.colormap^[0]^[I]) := Pal.palPalEntry[I].peBlue;
  end;
end;

function CMYKToRGB(const Color: TRGBQuad): TRGBQuad;
begin
  Result.rgbRed := ( (Color.rgbBlue) * (Color.rgbReserved) ) div 255;
  Result.rgbGreen := ( (Color.rgbGreen) * (Color.rgbReserved) ) div 255;
  Result.rgbBlue := ( (Color.rgbRed) * (Color.rgbReserved) ) div 255;
  Result.rgbReserved := 255;
end;

function TJPEGImage.GetBitmap: TBitmap;
var
  LinesPerCall, LinesRead: Integer;
  DestScanLine, CurPixel: PByte;
  AWidth: Integer;
{$IFDEF JF24BIT}
  Swap: Byte;
{$ENDIF}
  PtrInc: Integer;
  jc: TJPEGContext;
  GeneratePalette: Boolean;
begin
  Result := FBitmap;
  if Result <> nil then Exit;
  if FImage.FData = nil then Exit;

  if (FBitmap = nil) then FBitmap := TBitmap.Create;
  Result := FBitmap;
  GeneratePalette := True;

  InitDecompressor(Self, jc);
  try
    try
      // Set the bitmap pixel format
      FBitmap.Handle := 0;
      if (PixelFormat = jf8Bit) or (jc.d.out_color_space = JCS_GRAYSCALE) then
        FBitmap.PixelFormat := pf8bit
      else
        case jc.d.out_color_space of
          JCS_CMYK,
          JCS_YCCK: FBitmap.PixelFormat := pf32bit;
        else
          FBitmap.PixelFormat := pf24bit;
        end;

      Progress(Self, psStarting, 0, False, Rect(0,0,0,0), '');
      try
        if (FTempPal <> 0) then
        begin
          if (FPixelFormat = jf8Bit) then
          begin                        // Generate DIB using assigned palette
            BuildColorMap(jc.d, FTempPal);
            FBitmap.Palette := CopyPalette(FTempPal);  // Keep FTempPal around
            GeneratePalette := False;
          end
          else
          begin
            DeleteObject(FTempPal);
            FTempPal := 0;
          end;
        end;

        jpeg_start_decompress(jc.d);

        // Set bitmap width and height
        with FBitmap do
        begin
          Handle := 0;
          Width := jc.d.output_width;
          Height := jc.d.output_height;
          DestScanline := ScanLine[0];
          if jc.d.output_height > 1 then
          begin
            PtrInc := IntPtr(ScanLine[1]) - IntPtr(DestScanline);
            if (PtrInc > 0) and ((PtrInc and 3) = 0) then
               // if no dword padding is required and output bitmap is top-down
              LinesPerCall := jc.d.rec_outbuf_height // read multiple rows per call
            else
              LinesPerCall := 1;            // otherwise read one row at a time
          end
          else
          begin
            LinesPerCall := 1;
            PtrInc := 0;
          end;
        end;

        if jc.d.buffered_image then
        begin  // decode progressive scans at low quality, high speed
          while jpeg_consume_input(jc.d) <> JPEG_REACHED_EOI do
          begin
            jpeg_start_output(jc.d, jc.d.input_scan_number);
            // extract color palette
            if (jc.common.progress^.completed_passes = 0) and (jc.d.colormap <> nil)
              and (FBitmap.PixelFormat = pf8bit) and GeneratePalette then
            begin
              FBitmap.Palette := BuildPalette(jc.d);
              PaletteModified := True;
            end;
            DestScanLine := FBitmap.ScanLine[0];
            while (jc.d.output_scanline < jc.d.output_height) do
            begin
              LinesRead := jpeg_read_scanlines(jc.d, @DestScanline, LinesPerCall);
              if jc.d.out_color_space = JCS_CMYK then
              begin
                CurPixel := DestScanLine;
                AWidth := FBitmap.Width;
                while (CurPixel - DestScanLine) < (AWidth * 4) do
                begin
                   PRGBQuad(CurPixel)^ := CMYKToRGB(PRGBQuad(CurPixel)^);
                  Inc(CurPixel, 4);
                end;
              end;
{$IFDEF JF24BIT}
              if FBitmap.PixelFormat = pf24bit then
              begin
                CurPixel := DestScanLine;
                AWidth := FBitmap.Width;
                while (CurPixel - DestScanLine) < (AWidth * 3) do
                begin
                  Swap := CurPixel[0];
                  CurPixel[0] := CurPixel[2];
                  CurPixel[2] := Swap;
                  Inc(CurPixel, 3);
                end;
              end;
{$ENDIF}
              DestScanline := PByte(DestScanline) + (PtrInc * LinesRead);
            end;
            jpeg_finish_output(jc.d);
          end;
          // reset options for final pass at requested quality
          jc.d.dct_method := jc.FinalDCT;
          jc.d.dither_mode := jc.FinalDitherMode;
          if jc.FinalTwoPassQuant then
          begin
            jc.d.two_pass_quantize := True;
            jc.d.colormap := nil;
          end;
          jpeg_start_output(jc.d, jc.d.input_scan_number);
          DestScanLine := FBitmap.ScanLine[0];
        end;

        // build final color palette
        if (not jc.d.buffered_image or jc.FinalTwoPassQuant) and
          (jc.d.colormap <> nil) and GeneratePalette then
        begin
          FBitmap.Palette := BuildPalette(jc.d);
          PaletteModified := True;
          DestScanLine := FBitmap.ScanLine[0];
        end;
        // final image pass for progressive, first and only pass for baseline
        while (jc.d.output_scanline < jc.d.output_height) do
        begin
          LinesRead := jpeg_read_scanlines(jc.d, @DestScanline, LinesPerCall);
          if FBitmap.PixelFormat = pf32bit then
          begin
            CurPixel := DestScanLine;
            AWidth := FBitmap.Width;
            while (CurPixel - DestScanLine) < (AWidth * 4) do
            begin
               PRGBQuad(CurPixel)^ := CMYKToRGB(PRGBQuad(CurPixel)^);
              Inc(CurPixel, 4);
            end;
          end;
{$IFDEF JF24BIT}
          if PixelFormat = jf24bit then
          begin
            CurPixel := DestScanLine;
            AWidth := FBitmap.Width;
            while (CurPixel - DestScanLine) < (AWidth * 3) do
            begin
              Swap := CurPixel[0];
              CurPixel[0] := CurPixel[2];
              CurPixel[2] := Swap;
              Inc(CurPixel, 3);
            end;
          end;
{$ENDIF}
          DestScanline := PByte(DestScanline) + (PtrInc * LinesRead);
        end;

        if jc.d.buffered_image then jpeg_finish_output(jc.d);
        jpeg_finish_decompress(jc.d);
      finally
        if ExceptObject = nil then
          PtrInc := 100
        else
          PtrInc := 0;
        Progress(Self, psEnding, PtrInc, PaletteModified, Rect(0,0,0,0), '');
        // Make sure new palette gets realized, in case OnProgress event didn't.
        if PaletteModified then
          Changed(Self);
      end;
    except
      on EAbort do ;   // OnProgress can raise EAbort to cancel image load
    end;
  finally
    ReleaseContext(jc);
  end;
end;

function TJPEGImage.GetEmpty: Boolean;
begin
  Result := (FImage.FData = nil) and ((FBitmap = nil) or FBitmap.Empty);
end;

function TJPEGImage.GetGrayscale: Boolean;
begin
  Result := FGrayscale or FImage.FGrayscale;
end;

function TJPEGImage.GetPalette: HPalette;
var
  DC: HDC;
begin
  Result := 0;
  if FBitmap <> nil then
    Result := FBitmap.Palette
  else if FTempPal <> 0 then
    Result := FTempPal
  else if FPixelFormat = jf24Bit then   // check for 8 bit screen
  begin
    DC := GetDC(0);
    if (GetDeviceCaps(DC, BITSPIXEL) * GetDeviceCaps(DC, PLANES)) <= 8 then
    begin
      FTempPal := CreateHalftonePalette(DC);
      Result := FTempPal;
    end;
    ReleaseDC(0, DC);
  end;
end;

function TJPEGImage.GetHeight: Integer;
begin
  if FBitmap <> nil then
    Result := FBitmap.Height
  else if FScale = jsFullSize then
    Result := FImage.FHeight
  else
  begin
    CalcOutputDimensions;
    Result := FScaledHeight;
  end;
end;

function TJPEGImage.GetWidth: Integer;
begin
  if FBitmap <> nil then
    Result := FBitmap.Width
  else if FScale = jsFullSize then
    Result := FImage.FWidth
  else
  begin
    CalcOutputDimensions;
    Result := FScaledWidth;
  end;
end;

procedure TJPEGImage.JPEGNeeded;
begin
  if FImage.FData = nil then
    Compress;
end;

procedure TJPEGImage.LoadFromClipboardFormat(AFormat: Word; AData: THandle;
  APalette: HPALETTE);
begin
  //!! check for jpeg clipboard data, mime type image/jpeg
  FBitmap.LoadFromClipboardFormat(AFormat, AData, APalette);
end;

procedure TJPEGImage.LoadFromStream(Stream: TStream);
begin
  ReadStream(Stream.Size - Stream.Position, Stream);
end;

procedure TJPEGImage.NewBitmap;
begin
  FBitmap.Free;
  FBitmap := TBitmap.Create;
end;

procedure TJPEGImage.NewImage;
begin
  if FImage <> nil then FImage.Release;
  FImage := TJPEGData.Create;
  FImage.Reference;
end;

procedure TJPEGImage.ReadData(Stream: TStream);
var
  Size: Longint;
begin
  Stream.Read(Size, SizeOf(Size));
  ReadStream(Size, Stream);
end;

procedure TJPEGImage.ReadStream(Size: Longint; Stream: TStream);
var
  jerr: jpeg_error_mgr;
  cinfo: jpeg_decompress_struct;
begin
  NewImage;
  FBitmap.Free;
  FBitmap := nil;
  with FImage do
  begin
    FData := TMemoryStream.Create;
    FData.Size := Size;
    Stream.ReadBuffer(FData.Memory^, Size);
    if Size > 0 then
    begin
      jerr := jpeg_std_error;  // use local var for thread isolation
      cinfo.common.err := @jerr;
      jpeg_CreateDecompress(cinfo, JPEG_LIB_VERSION, sizeof(cinfo));
      try
        FData.Position := 0;
        jpeg_stdio_src(cinfo, FData);
        jpeg_read_header(cinfo, TRUE);
        FWidth := cinfo.image_width;
        FHeight := cinfo.image_height;
        FGrayscale := cinfo.jpeg_color_space = JCS_GRAYSCALE;
        FProgressiveEncoding := jpeg_has_multiple_scans(cinfo);
      finally
        jpeg_destroy_decompress(cinfo);
      end;
    end;
  end;
  PaletteModified := True;
  Changed(Self);
end;

procedure TJPEGImage.SaveToClipboardFormat(var AFormat: Word; var AData: THandle;
  var APalette: HPALETTE);
begin
//!!  check for jpeg clipboard format, mime type image/jpeg
  Bitmap.SaveToClipboardFormat(AFormat, AData, APalette);
end;

procedure TJPEGImage.SaveToStream(Stream: TStream);
begin
  JPEGNeeded;
  with FImage.FData do
    Stream.Write(Memory^, Size);
end;

procedure TJPEGImage.SetGrayscale(Value: Boolean);
begin
  if FGrayscale <> Value then
  begin
    FreeBitmap;
    FGrayscale := Value;
    PaletteModified := True;
    Changed(Self);
  end;
end;

procedure TJPEGImage.SetHeight(Value: Integer);
begin
  InvalidOperation(SChangeJPGSize);
end;

procedure TJPEGImage.SetPalette(Value: HPalette);
var
  SignalChange: Boolean;
begin
  if Value <> FTempPal then
  begin
    SignalChange := (FBitmap <> nil) and (Value <> FBitmap.Palette);
    if SignalChange then FreeBitmap;
    if FTempPal <> 0 then DeleteObject(FTempPal);
    FTempPal := Value;
    if SignalChange then
    begin
      PaletteModified := True;
      Changed(Self);
    end;
  end;
end;

procedure TJPEGImage.SetPerformance(Value: TJPEGPerformance);
begin
  if FPerformance <> Value then
  begin
    FreeBitmap;
    FPerformance := Value;
    PaletteModified := True;
    Changed(Self);
  end;
end;

procedure TJPEGImage.SetPixelFormat(Value: TJPEGPixelFormat);
begin
  if FPixelFormat <> Value then
  begin
    FreeBitmap;
    FPixelFormat := Value;
    PaletteModified := True;
    Changed(Self);
  end;
end;

procedure TJPEGImage.SetScale(Value: TJPEGScale);
begin
  if FScale <> Value then
  begin
    FreeBitmap;
    FScale := Value;
    FNeedRecalc := True;
    Changed(Self);
  end;
end;

procedure TJPEGImage.SetSmoothing(Value: Boolean);
begin
  if FSmoothing <> Value then
  begin
    FreeBitmap;
    FSmoothing := Value;
    Changed(Self);
  end;
end;

procedure TJPEGImage.SetWidth(Value: Integer);
begin
  InvalidOperation(SChangeJPGSize);
end;

procedure TJPEGImage.WriteData(Stream: TStream);
var
  Size: Longint;
begin
  Size := 0;
  if Assigned(FImage.FData) then Size := FImage.FData.Size;
  Stream.Write(Size, Sizeof(Size));
  if Size > 0 then Stream.Write(FImage.FData.Memory^, Size);
end;

procedure InitDefaults;
var
  DC: HDC;
begin
  DC := GetDC(0);
  if (GetDeviceCaps(DC, BITSPIXEL) * GetDeviceCaps(DC, PLANES)) <= 8 then
    JPEGDefaults.PixelFormat := jf8Bit
  else
    JPEGDefaults.PixelFormat := jf24Bit;
  ReleaseDC(0, DC);
end;

initialization
  InitDefaults;
  TPicture.RegisterFileFormat('jpeg', sJPEGImageFile, TJPEGImage);
  TPicture.RegisterFileFormat('jpg', sJPEGImageFile, TJPEGImage);
finalization
  TPicture.UnregisterGraphicClass(TJPEGImage);
end.
