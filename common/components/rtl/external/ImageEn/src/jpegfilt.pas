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

unit jpegfilt;

{$R-}
{$Q-}


{$I ie.inc}

interface

(*$ifdef IEKYLIX*)
uses SysUtils, Types, Classes, QGraphics,iekdef, ImageEnIO, hyiedefs, hyieutils, ImageEnProc, ieview;
(*$endif*)
(*$ifdef IEDELPHI*)
uses Windows, Graphics, classes, sysutils, ImageEnProc, ImageEnIO, hyiedefs, hyieutils;
(*$endif*)

procedure ReadJPegStream(Stream:TStream; TableStream:TStream; Bitmap:TIEBitmap; var IOParams:TIOParamsVals; var xProgress:TProgressRec; Preview:boolean; Raw:boolean);
procedure WriteJPegStream(Stream:TStream; bitmap:TIEBitmap; var IOParams:TIOParamsVals; var xProgress:TProgressRec);
function JpegTryStream(Stream:TStream):integer;
function IEJpegInjectIPTC(InputStream,OutputStream:TStream; iptc:TIEIPTCInfoList; var xProgress:TProgressRec):boolean;
function IEJpegInjectEXIF(InputStream,OutputStream:TStream; exif:TIOParamsVals; var xProgress:TProgressRec):boolean;
(*$ifdef IEDELPHI*)
procedure IEJpegLosslessTransform(InStream,OutStream:TStream; var xProgress:TProgressRec; Transform:integer; GrayScale:boolean; CopyMarkers:integer; CutRect:TRect);
(*$endif*)

var
  __turboFloat: LongBool = False;

implementation

uses
  l3MinMax
(*$ifdef IEDELPHI*)
  ,
  IEView
(*$endif*)
  ;

{$R-}

{$Z4}

type

	EIEJpegException = class(Exception);

const
   JPEG_LIB_VERSION = 62;        { Version 6b }
   JPEG_RST0     = $D0;  { RST0 marker code }
   JPEG_EOI      = $D9;  { EOI marker code }
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

   // The script for encoding a multiple-scan file is an array of these:
   jpeg_scan_info_ptr = ^jpeg_scan_info;
   jpeg_scan_info = (*packed*) record
      comps_in_scan: Integer;		// number of components encoded in this scan
      component_index: array[0..MAX_COMPS_IN_SCAN-1] of Integer; // their SOF/comp_info[] indexes
      Ss, Se: Integer;			// progressive JPEG spectral selection parms
      Ah, Al: Integer;			// progressive JPEG successive approx. parms
   end;

   // The decompressor can save APPn and COM markers in a list of these:
   jpeg_saved_marker_ptr = ^jpeg_marker_struct;
   jpeg_marker_struct = (*packed*) record
      next: jpeg_saved_marker_ptr ;	// next in list, or NULL
      marker: UINT8 ;			// marker code: JPEG_COM, or JPEG_APP0+n
      original_length: UINT;	// # bytes of data in the file
      data_length: UINT;	// # bytes of data saved at data[]
      data: ^JOCTET;		// the data contained in the marker
      // the marker length word is not counted in data_length or original_length
   end;

   jpeg_error_mgr_ptr = ^jpeg_error_mgr;
   jpeg_progress_mgr_ptr = ^jpeg_progress_mgr;
   j_common_ptr = ^jpeg_common_struct;
   j_compress_ptr = ^jpeg_compress_struct;
   j_decompress_ptr = ^jpeg_decompress_struct;

{ Routine signature for application-supplied marker processing methods.
  Need not pass marker code since it is stored in cinfo^.unread_marker. }
   jpeg_marker_parser_method = function(cinfo : j_decompress_ptr) : LongBool; (*$ifdef IEKYLIX*) cdecl; (*$endif*)

{ Marker reading & parsing }
   jpeg_marker_reader_ptr = ^jpeg_marker_reader;
   jpeg_marker_reader = (*packed*) record
     reset_marker_reader : procedure(cinfo : j_decompress_ptr); (*$ifdef IEKYLIX*) cdecl; (*$endif*)
     { Read markers until SOS or EOI.
       Returns same codes as are defined for jpeg_consume_input:
       JPEG_SUSPENDED, JPEG_REACHED_SOS, or JPEG_REACHED_EOI. }
     read_markers : function (cinfo : j_decompress_ptr) : Integer; (*$ifdef IEKYLIX*) cdecl; (*$endif*)
     { Read a restart marker --- exported for use by entropy decoder only }
     read_restart_marker : jpeg_marker_parser_method;
     { Application-overridable marker processing methods }
     process_COM : jpeg_marker_parser_method;
     process_APPn : Array[0..16-1] of jpeg_marker_parser_method;
     { State of marker reader --- nominally internal, but applications
       supplying COM or APPn handlers might like to know the state. }
     saw_SOI : LongBool;            { found SOI? }
     saw_SOF : LongBool;            { found SOF? }
     next_restart_num : Integer;    { next restart number expected (0-7) }
     discarded_bytes : UINT;        { # of bytes skipped looking for a marker }
  end;

  {int8array = Array[0..8-1] of int;}
  int8array = Array[0..8-1] of Integer;

  jpeg_error_mgr = (*packed*) record
     { Error exit handler: does not return to caller }
     error_exit : procedure  (cinfo : j_common_ptr); (*$ifdef IEKYLIX*) cdecl; (*$endif*)
     { Conditionally emit a trace or warning message }
     emit_message : procedure (cinfo : j_common_ptr; msg_level : Integer); (*$ifdef IEKYLIX*) cdecl; (*$endif*)
     { Routine that actually outputs a trace or error message }
     output_message : procedure (cinfo : j_common_ptr); (*$ifdef IEKYLIX*) cdecl; (*$endif*)
     { Format a message string for the most recent JPEG error or message }
     format_message : procedure  (cinfo : j_common_ptr; buffer: PAnsiChar); (*$ifdef IEKYLIX*) cdecl; (*$endif*)
     { Reset error state variables at start of a new image }
     reset_error_mgr : procedure (cinfo : j_common_ptr); (*$ifdef IEKYLIX*) cdecl; (*$endif*)
     { The message ID code and any parameters are saved here.
       A message can have one string parameter or up to 8 int parameters. }
     msg_code : Integer;
     msg_parm : (*packed*) record
       case byte of
       0:(i : int8array);
       1:(s : string[JMSG_STR_PARM_MAX]);
     end;
     trace_level : Integer;     { max msg_level that will be displayed }
     num_warnings : Integer;    { number of corrupt-data warnings }
     // ImageEn specifics
     aborting:pboolean;
  end;

{ Data destination object for compression }
  jpeg_destination_mgr_ptr = ^jpeg_destination_mgr;
  jpeg_destination_mgr = (*packed*) record
     next_output_byte : JOCTETptr;  { => next byte to write in buffer }
     free_in_buffer : Longint;    { # of byte spaces remaining in buffer }
     init_destination : procedure (cinfo : j_compress_ptr); (*$ifdef IEKYLIX*) cdecl; (*$endif*)
     empty_output_buffer : function (cinfo : j_compress_ptr) : LongBool; (*$ifdef IEKYLIX*) cdecl; (*$endif*)
     term_destination : procedure (cinfo : j_compress_ptr); (*$ifdef IEKYLIX*) cdecl; (*$endif*)
  end;


{ Data source object for decompression }
  jpeg_source_mgr_ptr = ^jpeg_source_mgr;
  jpeg_source_mgr = (*packed*) record
     next_input_byte : JOCTETptr;      { => next byte to read from buffer }
     bytes_in_buffer : Longint;       { # of bytes remaining in buffer }
     init_source : procedure  (cinfo : j_decompress_ptr); (*$ifdef IEKYLIX*) cdecl; (*$endif*)
     fill_input_buffer : function (cinfo : j_decompress_ptr) : LongBool; (*$ifdef IEKYLIX*) cdecl; (*$endif*)
     skip_input_data : procedure (cinfo : j_decompress_ptr; num_bytes : Longint); (*$ifdef IEKYLIX*) cdecl; (*$endif*)
     resync_to_restart : function (cinfo : j_decompress_ptr; desired : Integer) : LongBool; (*$ifdef IEKYLIX*) cdecl; (*$endif*)
     term_source : procedure (cinfo : j_decompress_ptr); (*$ifdef IEKYLIX*) cdecl; (*$endif*)
  end;

{ JPEG library memory manger routines }
  jpeg_memory_mgr_ptr = ^jpeg_memory_mgr;
  jpeg_memory_mgr = (*packed*) record
     { Method pointers }
     alloc_small : function (cinfo : j_common_ptr;
                             pool_id, sizeofobject: Integer): pointer; (*$ifdef IEKYLIX*) cdecl; (*$endif*)
     alloc_large : function (cinfo : j_common_ptr;
                             pool_id, sizeofobject: Integer): pointer; (*$ifdef IEKYLIX*) cdecl; (*$endif*)
     alloc_sarray : function (cinfo : j_common_ptr; pool_id : Integer;
                              samplesperrow : JDIMENSION;
                              numrows : JDIMENSION) : JSAMPARRAY; (*$ifdef IEKYLIX*) cdecl; (*$endif*)
     alloc_barray : pointer;
     request_virt_sarray : pointer;
     request_virt_barray : pointer;
     realize_virt_arrays : pointer;
     access_virt_sarray : pointer;
     access_virt_barray : pointer;
     free_pool : pointer;
     self_destruct : pointer;
     max_memory_to_use : Longint;
  end;

  { Fields shared with jpeg_decompress_struct } // 24
  jpeg_common_struct = (*packed*) record
     err : jpeg_error_mgr_ptr;        { Error handler module }
     mem : jpeg_memory_mgr_ptr;          { Memory manager module }
     progress : jpeg_progress_mgr_ptr;   { Progress monitor, or NIL if none }
     client_data: Pointer;		{ Available for use by application }
     is_decompressor : LongBool;      { so common code can tell which is which }
     global_state : Integer;          { for checking call sequence validity }
  end;

{ Progress monitor object }
  jpeg_progress_mgr = (*packed*) record
     progress_monitor : procedure(const cinfo : jpeg_common_struct); (*$ifdef IEKYLIX*) cdecl; (*$endif*)
     pass_counter : Integer;     { work units completed in this pass }
     pass_limit : Integer;       { total number of work units in this pass }
     completed_passes : Integer;	{ passes completed so far }
     total_passes : Integer;     { total number of passes expected }
     // extra info
  end;

{ Master record for a compression instance }
// attenzione agli allineamenti tra delphi3-4 e Delphi5
   jpeg_compress_struct = packed record
      common: jpeg_common_struct;	// 24
      dest : jpeg_destination_mgr_ptr; { Destination for compressed data } // 4
    { Description of source image --- these fields must be filled in by
      outer application before starting compression.  in_color_space must
      be correct before you can even call jpeg_set_defaults(). }
      image_width : JDIMENSION;         { input image width } // 4
      image_height : JDIMENSION;        { input image height } // 4
      input_components : Integer;       { # of color components in input image } // 4
      in_color_space : J_COLOR_SPACE;   { colorspace of input image } // 4
      input_gamma : double;             { image gamma of input image } // 8
      (*$ifdef IEDELPHI*)
      dummy1:integer;
      (*$endif*)
      // Compression parameters
      data_precision : Integer;             { bits of precision in image data } // 4
      num_components : Integer;             { # of color components in JPEG image } // 4
      jpeg_color_space : J_COLOR_SPACE;     { colorspace of JPEG image } // 4
      comp_info : Pointer; // 4
      quant_tbl_ptrs: Array[0..NUM_QUANT_TBLS-1] of Pointer; // 16
      dc_huff_tbl_ptrs : Array[0..NUM_HUFF_TBLS-1] of Pointer; // 16
      ac_huff_tbl_ptrs : Array[0..NUM_HUFF_TBLS-1] of Pointer; // 16
      arith_dc_L : Array[0..NUM_ARITH_TBLS-1] of UINT8; // 16 { L values for DC arith-coding tables }
      arith_dc_U : Array[0..NUM_ARITH_TBLS-1] of UINT8; // 16 { U values for DC arith-coding tables }
      arith_ac_K : Array[0..NUM_ARITH_TBLS-1] of UINT8; // 16 { Kx values for AC arith-coding tables }
      num_scans : Integer;		 { # of entries in scan_info array } // 4
      scan_info : Pointer;     { script for multi-scan file, or NIL } // 4
      raw_data_in : LongBool;        { TRUE=caller supplies downsampled data } // 4
      arith_code : LongBool;         { TRUE=arithmetic coding, FALSE=Huffman } // 4
      optimize_coding : LongBool;    { TRUE=optimize entropy encoding parms } // 4
      CCIR601_sampling : LongBool;   { TRUE=first samples are cosited } // 4
      smoothing_factor : Integer;       { 1..100, or 0 for no input smoothing } // 4
      dct_method : J_DCT_METHOD;    { DCT algorithm selector } // 4
      restart_interval : UINT;      { MCUs per restart, or 0 for no restart } // 4
      restart_in_rows : Integer;        { if > 0, MCU rows per restart interval } // 4
      { Parameters controlling emission of special markers. }
      write_JFIF_header : LongBool;  { should a JFIF marker be written? } // 4
      JFIF_major_version: UINT8;	// What to write for the JFIF version number // (4)
      JFIF_minor_version: UINT8; // (4)
      { These three values are not used by the JPEG code, merely copied }
      { into the JFIF APP0 marker.  density_unit can be 0 for unknown, }
      { 1 for dots/inch, or 2 for dots/cm.  Note that the pixel aspect }
      { ratio is defined by X_density/Y_density even when density_unit=0. }
      density_unit : UINT8;         { JFIF code for pixel size units } // (4)
      dummy2:UINT8;
      X_density : UINT16;           { Horizontal pixel density } // (4)
      Y_density : UINT16;           { Vertical pixel density } // (4)
      write_Adobe_marker : LongBool; { should an Adobe marker be written? } // 4
      { State variable: index of next scanline to be written to
        jpeg_write_scanlines().  Application may use this to control its
        processing loop, e.g., "while (next_scanline < image_height)". }
      next_scanline : JDIMENSION;   { 0 .. image_height-1  } // 4
      { Remaining fields are known throughout compressor, but generally
        should not be touched by a surrounding application. }
      progressive_mode : LongBool;   { TRUE if scan script uses progressive mode } // 4
      max_h_samp_factor : Integer;      { largest h_samp_factor } // 4
      max_v_samp_factor : Integer;      { largest v_samp_factor } // 4
      total_iMCU_rows : JDIMENSION; { # of iMCU rows to be input to coef ctlr } // 4
      comps_in_scan : Integer;          { # of JPEG components in this scan } // 4
      cur_comp_info : Array[0..MAX_COMPS_IN_SCAN-1] of Pointer;// 16
      MCUs_per_row : JDIMENSION;    { # of MCUs across the image }// 4
      MCU_rows_in_scan : JDIMENSION;{ # of MCU rows in the image }// 4
      blocks_in_MCU : Integer;          { # of DCT blocks per MCU }// 4
      MCU_membership : Array[0..C_MAX_BLOCKS_IN_MCU-1] of Integer;// 40 (4*10)
      Ss, Se, Ah, Al : Integer;         { progressive JPEG parameters for scan } // 16
      { Links to compression subobjects (methods and private variables of modules) }
      master : Pointer; // 4
      main : Pointer; // 4
      prep : Pointer; // 4
      coef : Pointer; // 4
      marker : Pointer; // 4
      cconvert : Pointer; // 4
      downsample : Pointer; // 4
      fdct : Pointer; // 4
      entropy : Pointer; // 4
      script_space: jpeg_scan_info_ptr; // workspace for jpeg_simple_progression // 4
      script_space_size: Integer; // 4
   end;

{ Master record for a decompression instance }
   jpeg_decompress_struct = packed record
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
      JFIF_major_version: UINT8;	// What to write for the JFIF version number
      JFIF_minor_version: UINT8;
      { Data copied from JFIF marker: }
      density_unit : UINT8;       { JFIF code for pixel size units }
      dummy2:UINT8;
      X_density : UINT16;         { Horizontal pixel density }
      Y_density : UINT16;         { Vertical pixel density }
      saw_Adobe_marker : LongBool; { TRUE iff an Adobe APP14 marker was found }
      Adobe_transform : UINT8;    { Color transform code from Adobe marker }
      dummy3:UINT8;
      dummy4:UINT8;
      dummy5:UINT8;
      CCIR601_sampling : LongBool; { TRUE=first samples are cosited }
      (* Aside from the specific data retained from APPn markers known to the
      * library, the uninterpreted contents of any or all APPn and COM markers
      * can be saved in a list for examination by the application.
      *)
      marker_list:jpeg_saved_marker_ptr; // Head of list of saved markers
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

   TJPEGContext = (*packed*) record
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

   TIEJPEGDESTMGR=record
   	pub:JPEG_DESTINATION_MGR;
      fs:TStream;
      aborting:pboolean;
      buffer:JOCTETPTR;
   end;
   PIEJPEGDESTMGR=^TIEJPEGDESTMGR;

   TIEJPEGSOURCEMGR=record
   	pub:JPEG_SOURCE_MGR;
      fs:TStream;
      start_of_file:boolean;
      aborting:pboolean;
      buffer:JOCTETPTR;
	end;
   PIEJPEGSOURCEMGR=^TIEJPEGSOURCEMGR;


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

// Stubs for external C RTL functions referenced by JPEG OBJ files.

(*$ifdef IEDELPHI*)

function _malloc(size: Integer): Pointer; cdecl;
begin
  GetMem(Result, size);
end;

procedure _free(P: Pointer); cdecl;
begin
  FreeMem(P);
end;

procedure _memset(P: Pointer; B: Byte; count: Integer); cdecl;
begin
  FillChar(P^, count, B);
end;

procedure _memcpy(dest, source: Pointer; count: Integer); cdecl;
begin
  Move(source^, dest^, count);
end;

function __ftol: Integer;
var
  f: double;
begin
  asm
    lea    eax, f             //  BC++ passes floats on the FPU stack
    fstp  qword ptr [eax]     //  Delphi passes floats on the CPU stack
  end;
  Result := Trunc(f);
end;

{$L jdapimin.obj}
{$L jmemmgr.obj}
{$L jmemnobs.obj}
{$L jdinput.obj}
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
{$L transupp.obj}
{$L jdtrans.obj}
{$L jctrans.obj}

procedure jpeg_CreateDecompress(var cinfo: jpeg_decompress_struct; version: integer; structsize: integer); external;
procedure jpeg_read_header(var cinfo: jpeg_decompress_struct; RequireImage: LongBool);  external;
procedure jpeg_calc_output_dimensions(var cinfo: jpeg_decompress_struct);  external;
function jpeg_start_decompress(var cinfo: jpeg_decompress_struct): Longbool;  external;
function jpeg_read_scanlines(var cinfo: jpeg_decompress_struct; scanlines: JSAMPARRAY; max_lines: JDIMENSION): JDIMENSION;  external;
function jpeg_finish_decompress(var cinfo: jpeg_decompress_struct): Longbool;  external;
procedure jpeg_destroy_decompress(var cinfo: jpeg_decompress_struct);  external;
function jpeg_has_multiple_scans(var cinfo: jpeg_decompress_struct): Longbool;  external;
function jpeg_consume_input(var cinfo: jpeg_decompress_struct): Integer;  external;
function jpeg_start_output(var cinfo: jpeg_decompress_struct; scan_number: Integer): Longbool;  external;
function jpeg_finish_output(var cinfo: jpeg_decompress_struct): LongBool;  external;
procedure jpeg_destroy(var cinfo: jpeg_common_struct);  external;
procedure jpeg_save_markers(var cinfo: jpeg_decompress_struct; marker_code:integer; length_limit:UINT);  external;
function jpeg_resync_to_restart (cinfo : j_decompress_ptr; desired : Integer) : LongBool;  external;


// transforms

type JXFORM_CODE=integer;
const	JXFORM_NONE=0;		// no transformation
const JXFORM_CUT=1;      // cut out part of the image
const	JXFORM_FLIP_H=2;		// horizontal flip
const	JXFORM_FLIP_V=3;		// vertical flip
const	JXFORM_TRANSPOSE=4;	// transpose across UL-to-LR axis
const	JXFORM_TRANSVERSE=5;	// transpose across UR-to-LL axis
const	JXFORM_ROT_90=6;		// 90-degree clockwise rotation
const	JXFORM_ROT_180=7;		// 180-degree rotation
const	JXFORM_ROT_270=8;		// 270-degree clockwise (or 90 ccw)

type jpeg_transform_info=record
  // Options: set by caller */
  transform:JXFORM_CODE;	// image transform operator
  trim:integer;			// if TRUE, trim partial MCUs as needed
  force_grayscale:integer;	// if TRUE, convert color image to grayscale
  xoffs,yoffs,newwidth,newheight:dword;
  // Internal workspace: caller should not touch these
  num_components:integer;		// # of components in workspace
  workspace_coef_arrays:pointer; // workspace for transformations
end;

type JCOPY_OPTION=integer;
const JCOPYOPT_NONE=0;		// copy no optional markers
const JCOPYOPT_COMMENTS=1;	// copy only comment (COM) markers
const JCOPYOPT_ALL=2;		// copy all optional markers


procedure jtransform_request_workspace(var srcinfo:jpeg_decompress_struct; var info:jpeg_transform_info); external;
function jtransform_adjust_parameters(var srcinfo:jpeg_decompress_struct; var dstinfo:jpeg_compress_struct;
	     src_coef_arrays:pointer;
	     var info:jpeg_transform_info) : pointer; external;
procedure jtransform_execute_transformation(var srcinfo:jpeg_decompress_struct; var dstinfo:jpeg_compress_struct;
	     src_coef_arrays:pointer;
	     var info:jpeg_transform_info); external;
procedure jcopy_markers_setup(var srcinfo:jpeg_decompress_struct; option:JCOPY_OPTION); external;
procedure jcopy_markers_execute(var srcinfo:jpeg_decompress_struct; var dstinfo:jpeg_compress_struct;
	     option:JCOPY_OPTION); external;
function jpeg_read_coefficients(var cinfo: jpeg_decompress_struct):pointer; external;
procedure jpeg_write_coefficients(var dstinfo:jpeg_compress_struct; coef:pointer); external;
procedure jpeg_copy_critical_parameters(var srcinfo: jpeg_decompress_struct; var dstinfo:jpeg_compress_struct); external;

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

procedure jpeg_CreateCompress(var cinfo: jpeg_compress_struct; version: integer; structsize: integer);  external;
procedure jpeg_set_defaults(var cinfo: jpeg_compress_struct);  external;
procedure jpeg_set_quality(var cinfo: jpeg_compress_struct; Quality: Integer; Baseline: Longbool);  external;
procedure jpeg_set_colorspace(var cinfo: jpeg_compress_struct; colorspace: J_COLOR_SPACE);  external;
procedure jpeg_simple_progression(var cinfo: jpeg_compress_struct);  external;
procedure jpeg_start_compress(var cinfo: jpeg_compress_struct; WriteAllTables: LongBool);  external;
function jpeg_write_scanlines(var cinfo: jpeg_compress_struct; scanlines: JSAMPARRAY; max_lines: JDIMENSION): JDIMENSION;  external;
procedure jpeg_finish_compress(var cinfo: jpeg_compress_struct);  external;
procedure jpeg_destroy_compress(var cinfo: jpeg_compress_struct);  external;
procedure jpeg_write_marker(var cinfo: jpeg_compress_struct; marker:integer; dataptr:pbyte; datalen:dword); external;

(*$endif*)


(*$ifdef IEKYLIX*)

const JPEGDLL = 'libjpeg.so.62';

procedure jpeg_CreateDecompress(var cinfo: jpeg_decompress_struct; version: integer; structsize: integer);  cdecl; external JPEGDLL;
procedure jpeg_read_header(var cinfo: jpeg_decompress_struct; RequireImage: LongBool);    cdecl; external JPEGDLL;
procedure jpeg_calc_output_dimensions(var cinfo: jpeg_decompress_struct);    cdecl; external JPEGDLL;
function jpeg_start_decompress(var cinfo: jpeg_decompress_struct): Longbool;    cdecl; external JPEGDLL;
function jpeg_read_scanlines(var cinfo: jpeg_decompress_struct; scanlines: JSAMPARRAY; max_lines: JDIMENSION): JDIMENSION;    cdecl; external JPEGDLL;
function jpeg_finish_decompress(var cinfo: jpeg_decompress_struct): Longbool;    cdecl; external JPEGDLL;
procedure jpeg_destroy_decompress(var cinfo: jpeg_decompress_struct);    cdecl; external JPEGDLL;
function jpeg_has_multiple_scans(var cinfo: jpeg_decompress_struct): Longbool;    cdecl; external JPEGDLL;
function jpeg_consume_input(var cinfo: jpeg_decompress_struct): Integer;    cdecl; external JPEGDLL;
function jpeg_start_output(var cinfo: jpeg_decompress_struct; scan_number: Integer): Longbool;    cdecl; external JPEGDLL;
function jpeg_finish_output(var cinfo: jpeg_decompress_struct): LongBool;    cdecl; external JPEGDLL;
procedure jpeg_destroy(var cinfo: jpeg_common_struct);    cdecl; external JPEGDLL;
procedure jpeg_save_markers(var cinfo: jpeg_decompress_struct; marker_code:integer; length_limit:UINT);   cdecl; external JPEGDLL;
procedure jpeg_CreateCompress(var cinfo: jpeg_compress_struct; version: integer; structsize: integer);    cdecl; external JPEGDLL;
procedure jpeg_set_defaults(var cinfo: jpeg_compress_struct);    cdecl; external JPEGDLL;
procedure jpeg_set_quality(var cinfo: jpeg_compress_struct; Quality: Integer; Baseline: Longbool);    cdecl; external JPEGDLL;
procedure jpeg_set_colorspace(var cinfo: jpeg_compress_struct; colorspace: J_COLOR_SPACE);    cdecl; external JPEGDLL;
procedure jpeg_simple_progression(var cinfo: jpeg_compress_struct);    cdecl; external JPEGDLL;
procedure jpeg_start_compress(var cinfo: jpeg_compress_struct; WriteAllTables: LongBool);    cdecl; external JPEGDLL;
function jpeg_write_scanlines(var cinfo: jpeg_compress_struct; scanlines: JSAMPARRAY; max_lines: JDIMENSION): JDIMENSION;    cdecl; external JPEGDLL;
procedure jpeg_finish_compress(var cinfo: jpeg_compress_struct);    cdecl; external JPEGDLL;
procedure jpeg_destroy_compress(var cinfo: jpeg_compress_struct);    cdecl; external JPEGDLL;
procedure jpeg_write_marker(var cinfo: jpeg_compress_struct; marker:integer; dataptr:pbyte; datalen:dword);   cdecl; external JPEGDLL;
function jpeg_resync_to_restart (cinfo : j_decompress_ptr; desired : Integer) : LongBool; cdecl; external JPEGDLL;

(*$endif*)

procedure JpegError(cinfo: j_common_ptr); (*$ifdef IEKYLIX*) cdecl; (*$endif*)
var
	ss:string;
   c:integer;
begin
	if assigned(cinfo.err^.aborting) then
		cinfo.err^.aborting^:=True;
   c:=cinfo.err^.msg_code+1;
   case c of
      1	:ss:='Bogus message code ?';
      2	:ss:='Sorry, there are legal restrictions on arithmetic coding';
      3	:ss:='ALIGN_TYPE is wrong, please fix';
      4	:ss:='MAX_ALLOC_CHUNK is wrong, please fix';
      5	:ss:='Bogus buffer control mode';
      6	:ss:='Invalid component ID ? in SOS';
      7	:ss:='DCT coefficient out of range';
      8	:ss:='IDCT output block size ? not supported';
      9	:ss:='Bogus Huffman table definition';
      10	:ss:='Bogus input colorspace';
      11	:ss:='Bogus JPEG colorspace';
      12	:ss:='Bogus marker length';
      13	:ss:='Wrong JPEG library version: library is ?, caller expects ?';
      14	:ss:='Sampling factors too large for interleaved scan';
      15	:ss:='Invalid memory pool code ?';
      16	:ss:='Unsupported JPEG data precision ?';
      17	:ss:='Invalid progressive parameters Ss=? Se=? Ah=? Al=?';
      18	:ss:='Invalid progressive parameters at scan script entry ?';
      19	:ss:='Bogus sampling factors';
      20	:ss:='Invalid scan script at entry ?';
      21	:ss:='Improper call to JPEG library in state ?';
      22	:ss:='JPEG parameter struct mismatch: library thinks size is ?, caller expects ?';
      23	:ss:='Bogus virtual array access';
      24	:ss:='Buffer passed to JPEG library is too small';
      25	:ss:='Suspension not allowed here';
      26	:ss:='CCIR601 sampling not implemented yet';
      27	:ss:='Too many color components: ?, max ?';
      28	:ss:='Unsupported color conversion request';
      29	:ss:='Bogus DAC index ?';
      30	:ss:='Bogus DAC value 0x?';
      31	:ss:='Bogus DHT index ?';
      32	:ss:='Bogus DQT index ?';
      33	:ss:='Empty JPEG image (DNL not supported)';
      34	:ss:='Read from EMS failed';
      35	:ss:='Write to EMS failed';
      36	:ss:='Didn''t expect more than one scan';
      37	:ss:='Input file read error';
      38	:ss:='Output file write error --- out of disk space?';
      39	:ss:='Fractional sampling not implemented yet';
      40	:ss:='Huffman code size table overflow';
      41	:ss:='Missing Huffman code table entry';
      42	:ss:='Maximum supported image dimension is ? pixels';
      43	:ss:='Empty input file';
      44	:ss:='Premature end of input file';
      45	:ss:='Cannot transcode due to multiple use of quantization table ?';
      46	:ss:='Scan script does not transmit all data';
      47	:ss:='Invalid color quantization mode change';
      48	:ss:='Not implemented yet';
      49	:ss:='Requested feature was omitted at compile time';
      50	:ss:='Backing store not supported';
      51	:ss:='Huffman table was not defined';
      52	:ss:='JPEG datastream contains no image';
      53	:ss:='Quantization table was not defined';
      54	:ss:='Not a JPEG file: starts with ?';
      55	:ss:='Insufficient memory (case ?)';
      56	:ss:='Cannot quantize more than ? color components';
      57	:ss:='Cannot quantize to fewer than ? colors';
      58	:ss:='Cannot quantize to more than ? colors';
      59	:ss:='Invalid JPEG file structure: two SOF markers';
      60	:ss:='Invalid JPEG file structure: missing SOS marker';
      61	:ss:='Unsupported JPEG process: SOF type ?';
      62	:ss:='Invalid JPEG file structure: two SOI markers';
      63	:ss:='Invalid JPEG file structure: SOS before SOF';
      64	:ss:='Failed to create temporary file ?';
      65	:ss:='Read failed on temporary file';
      66	:ss:='Seek failed on temporary file';
      67	:ss:='Write failed on temporary file --- out of disk space?';
      68	:ss:='Application transferred too few scanlines';
      69	:ss:='Unsupported marker type ?';
      70	:ss:='Virtual array controller messed up';
      71	:ss:='Image too wide for this implementation';
      72	:ss:='Read from XMS failed';
      73	:ss:='Write to XMS failed';
      74	:ss:='';
      75	:ss:='';
      76	:ss:='Caution: quantization tables are too coarse for baseline JPEG';
      77	:ss:='Adobe APP14 marker: version ?, flags ?, transform ?';
      78	:ss:='Unknown APP0 marker (not JFIF), length ?';
      79	:ss:='Unknown APP14 marker (not Adobe), length ?';
      80	:ss:='Define Arithmetic Table ?';
      81	:ss:='Define Huffman Table ?';
      82	:ss:='Define Quantization Table ?  precision ?';
      83	:ss:='Define Restart Interval ?';
      84	:ss:='Freed EMS handle ?';
      85	:ss:='Obtained EMS handle ?';
      86	:ss:='End Of Image';
      87	:ss:='?';
      88	:ss:='JFIF APP0 marker: version ?, density ?';
      89	:ss:='Warning: thumbnail image size does not match data length ?';
      90	:ss:='JFIF extension marker: type ?, length ?';
      91	:ss:='with ? x ? thumbnail image';
      92	:ss:='Miscellaneous marker ?, length ?';
      93	:ss:='Unexpected marker ?';
      94	:ss:='?';
      95	:ss:='Quantizing to ? = ?*?*? colors';
      96	:ss:='Quantizing to ? colors';
      97	:ss:='Selected ? colors for quantization';
      98	:ss:='At marker ?, recovery action ?';
      99	:ss:='RST?';
      100	:ss:='Smoothing not supported with nonstandard sampling ratios';
      101	:ss:='Start Of Frame ?: width=?, height=?, components=?';
      102	:ss:='Component ?: ?hx?v q=?';
      103	:ss:='Start of Image';
      104	:ss:='Start Of Scan: ? components';
      105	:ss:='Component ?: dc=? ac=?';
      106	:ss:='Ss=?, Se=?, Ah=?, Al=?';
      107	:ss:='Closed temporary file ?';
      108	:ss:='Opened temporary file ?';
      109	:ss:='JFIF extension marker: JPEG-compressed thumbnail image, length ?';
      110	:ss:='JFIF extension marker: palette thumbnail image, length ?';
      111	:ss:='JFIF extension marker: RGB thumbnail image, length ?';
      112	:ss:='Unrecognized component IDs ? ? ?, assuming YCbCr';
      113	:ss:='Freed XMS handle ?';
      114	:ss:='Obtained XMS handle ?';
      115	:ss:='Unknown Adobe color transform code ?';
      116	:ss:='Inconsistent progression sequence for component ? coefficient ?';
      117	:ss:='Corrupt JPEG data: ? extraneous bytes before marker ?';
      118	:ss:='Corrupt JPEG data: premature end of data segment';
      119	:ss:='Corrupt JPEG data: bad Huffman code';
      120	:ss:='Warning: unknown JFIF revision number ?';
      121	:ss:='Premature end of JPEG file';
      122	:ss:='Corrupt JPEG data: found marker ? instead of RST?';
      123	:ss:='Invalid SOS parameters for sequential JPEG';
      124	:ss:='Application transferred too many scanlines';
		else
   		ss:='Corrupted';
   end;
   raise EIEJpegException.Create(ss);
end;

procedure EmitMessage(cinfo: j_common_ptr; msg_level: Integer); (*$ifdef IEKYLIX*) cdecl; (*$endif*)
begin
   if msg_level = -1 then
      inc (cinfo^.err^.num_warnings);
end;

procedure OutputMessage(cinfo: j_common_ptr); (*$ifdef IEKYLIX*) cdecl; (*$endif*)
begin
   //
end;

procedure FormatMessage(cinfo: j_common_ptr; buffer: PAnsiChar); (*$ifdef IEKYLIX*) cdecl; (*$endif*)
begin
   //
end;

procedure ResetErrorMgr(cinfo: j_common_ptr); (*$ifdef IEKYLIX*) cdecl; (*$endif*)
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


/////////////////////////////////////////////////////////////////////////////////////
// destination manager

const OUTPUT_BUF_SIZE=65536;

procedure init_destination(cinfo:J_COMPRESS_PTR); (*$ifdef IEKYLIX*) cdecl; (*$endif*)
var
	dest:PIEJPEGDESTMGR;
begin
	dest:=PIEJPEGDESTMGR(cinfo^.dest);
   getmem(dest^.buffer,OUTPUT_BUF_SIZE*sizeof(JOCTET));
	dest^.pub.next_output_byte:=dest^.buffer;
   dest^.pub.free_in_buffer:=OUTPUT_BUF_SIZE;
end;

function empty_output_buffer(cinfo:J_COMPRESS_PTR):boolean; (*$ifdef IEKYLIX*) cdecl; (*$endif*)
var
	dest:PIEJPEGDESTMGR;
begin
	dest:=PIEJPEGDESTMGR(cinfo^.dest);
   if dest^.fs.write(pbyte(dest^.buffer)^,OUTPUT_BUF_SIZE)<>OUTPUT_BUF_SIZE then
   	dest^.aborting^:=true;
	dest^.pub.next_output_byte:=dest^.buffer;
   dest^.pub.free_in_buffer:=OUTPUT_BUF_SIZE;
   result:=true;
end;

procedure term_destination(cinfo:J_COMPRESS_PTR); (*$ifdef IEKYLIX*) cdecl; (*$endif*)
var
	dest:PIEJPEGDESTMGR;
	datacount:integer;
begin
	dest:=PIEJPEGDESTMGR(cinfo^.dest);
   datacount:=OUTPUT_BUF_SIZE - dest^.pub.free_in_buffer;
   if datacount>0 then begin
	   if dest^.fs.write(pbyte(dest^.buffer)^,datacount)<>datacount then
   		dest^.aborting^:=true;
   end;
end;

procedure jpeg_ie_dest(cinfo:J_COMPRESS_PTR; fs:TStream; aborting:pboolean);
var
	dest:PIEJPEGDESTMGR;
begin
	if cinfo^.dest=nil then
   	getmem(cinfo^.dest,sizeof(TIEJPEGDESTMGR));
   dest:=PIEJPEGDESTMGR(cinfo^.dest);
   dest^.pub.init_destination:=@init_destination;
   dest^.pub.empty_output_buffer:=@empty_output_buffer;
   dest^.pub.term_destination:=@term_destination;
   dest^.fs:=fs;
   dest^.aborting:=aborting;
end;

procedure jpeg_ie_dest_free(cinfo:J_COMPRESS_PTR);
var
	dest:PIEJPEGDESTMGR;
begin
	dest:=PIEJPEGDESTMGR(cinfo^.dest);
	freemem(dest^.buffer);
	freemem(cinfo^.dest);
end;

/////////////////////////////////////////////////////////////////////////////////////
// source manager

const INPUT_BUF_SIZE=65536;

procedure init_source(cinfo:J_DECOMPRESS_PTR); (*$ifdef IEKYLIX*) cdecl; (*$endif*)
var
	src:PIEJPEGSOURCEMGR;
begin
	src:=PIEJPEGSOURCEMGR(cinfo^.src);
   src^.start_of_file:=true;
end;

function fill_input_buffer(cinfo:J_DECOMPRESS_PTR):longbool; (*$ifdef IEKYLIX*) cdecl; (*$endif*)
var
	src:PIEJPEGSOURCEMGR;
   nbytes:integer;
begin
	src:=PIEJPEGSOURCEMGR(cinfo^.src);
	nbytes:=src^.fs.Read(pbyte(src^.buffer)^,INPUT_BUF_SIZE);
   if nbytes<=0 then begin
   	if src^.start_of_file then
      	src^.aborting^:=true;
      pbytearray(src^.buffer)^[0]:=$FF;
		pbytearray(src^.buffer)^[1]:=JPEG_EOI;
      nbytes:=2;
   end;
   src^.pub.next_input_byte:=src^.buffer;
   src^.pub.bytes_in_buffer:=nbytes;
   src^.start_of_file:=false;
   result:=true;
end;

procedure skip_input_data(cinfo:J_DECOMPRESS_PTR; num_bytes:integer); (*$ifdef IEKYLIX*) cdecl; (*$endif*)
var
	src:PIEJPEGSOURCEMGR;
begin
	src:=PIEJPEGSOURCEMGR(cinfo^.src);
	if num_bytes>0 then begin
   	while num_bytes>src^.pub.bytes_in_buffer do begin
      	dec(num_bytes, src^.pub.bytes_in_buffer);
         fill_input_buffer(cinfo);
      end;
      inc( src^.pub.next_input_byte , num_bytes);
      dec( src^.pub.bytes_in_buffer , num_bytes);
   end;
end;

procedure term_source(cinfo:J_DECOMPRESS_PTR); (*$ifdef IEKYLIX*) cdecl; (*$endif*)
begin
end;

procedure jpeg_ie_src(cinfo:J_DECOMPRESS_PTR; fs:TStream; aborting:pboolean);
var
	src:PIEJPEGSOURCEMGR;
begin
	if cinfo^.src=nil then begin
   	getmem(cinfo^.src,sizeof(TIEJPEGSOURCEMGR));
		src:=PIEJPEGSOURCEMGR(cinfo^.src);
      getmem(src^.buffer,INPUT_BUF_SIZE*sizeof(JOCTET));
   end;
   src:=PIEJPEGSOURCEMGR(cinfo^.src);
   src^.pub.init_source:=init_source;
   src^.pub.fill_input_buffer:=fill_input_buffer;
   src^.pub.skip_input_data:=skip_input_data;
   src^.pub.resync_to_restart:=jpeg_resync_to_restart;
   src^.pub.term_source:=term_source;
   src^.fs:=fs;
   src^.pub.bytes_in_buffer:=0;
   src^.pub.next_input_byte:=nil;
   src^.aborting:=aborting;
end;

procedure jpeg_ie_src_free(cinfo:J_DECOMPRESS_PTR);
var
	src:PIEJPEGSOURCEMGR;
begin
	src:=PIEJPEGSOURCEMGR(cinfo^.src);
   if src<>nil then begin
		freemem(src^.buffer);
		freemem(cinfo^.src);
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////////
// read stream jpeg
// TableStream contains Q tables. It is nil if all is inside Stream.
// Raw=true doesn't convert to RGB but get the original color format
procedure ReadJPegStream(Stream:TStream; TableStream:TStream; Bitmap:TIEBitmap; var IOParams:TIOParamsVals; var xProgress:TProgressRec; Preview:boolean; Raw:boolean);
var
	cinfo:jpeg_decompress_struct;
   jerr:jpeg_error_mgr;
   DestScanLine:pointer;
   LinesPerCall,LinesRead:integer;
   buff:pbyte;
   xrgb,yrgb:PRGB;
   xx:integer;
   bst,dv:integer;
   markers:jpeg_saved_marker_ptr;
   spos:integer;
   tlr:integer; // total lines read
begin
   IOParams.JPEG_WarningTot := 0 ;
   IOParams.JPEG_WarningCode := 0 ;
   spos:=JpegTryStream(Stream);
   if spos=-1 then begin
   	xProgress.Aborting^:=true;
      exit;
   end;
   Stream.Position:=spos;
	try
   buff:=nil;
	jerr:=jpeg_std_error;
   jerr.aborting:=xProgress.Aborting;
	cinfo.common.err:=@jerr;
   jpeg_CreateDecompress(cinfo, JPEG_LIB_VERSION, sizeof(cinfo));
   if xProgress.Aborting^ then
      exit;
   if (TableStream<>nil) and (TableStream<>Stream) then begin
   	// load tables from TableStream
		jpeg_ie_src(@cinfo,TableStream,xProgress.Aborting);
		jpeg_read_header(cinfo, FALSE);
   end;
   jpeg_ie_src(@cinfo,Stream,xProgress.Aborting);
   if xProgress.Aborting^ then
      exit;
   try
   jpeg_save_markers(cinfo, JPEG_COM, $ffff);
   for xx:=JPEG_APP0 to JPEG_APP15 do
		jpeg_save_markers(cinfo, xx, $ffff);
   jpeg_read_header(cinfo, TRUE);
   except
   	xProgress.Aborting^:=true;
      exit;
   end;
   //
   if xProgress.Aborting^ then
      exit;
	IOParams.BitsPerSample:=8;
   case cinfo.jpeg_color_space of
   	JCS_RGB:
      	begin
         	IOParams.JPEG_ColorSpace:=ioJPEG_RGB;
            cinfo.out_color_space:=JCS_RGB;
            IOParams.SamplesPerPixel:=3;
         end;
      JCS_GRAYSCALE:
      	begin
         	IOParams.JPEG_ColorSpace:=ioJPEG_GRAYLEV;
            cinfo.out_color_space:=JCS_RGB;
            IOParams.SamplesPerPixel:=1;
         end;
		JCS_YCbCr:
      	begin
         	IOParams.JPEG_ColorSpace:=ioJPEG_YCbCr;
            cinfo.out_color_space:=JCS_RGB;
            IOParams.SamplesPerPixel:=3;
         end;
		JCS_CMYK:
      	begin
         	IOParams.JPEG_ColorSpace:=ioJPEG_CMYK;
            cinfo.out_color_space:=JCS_CMYK;
            IOParams.SamplesPerPixel:=4;
         end;
		JCS_YCCK:
      	begin
         	IOParams.JPEG_ColorSpace:=ioJPEG_YCbCrK;
            cinfo.out_color_space:=JCS_CMYK;
            IOParams.SamplesPerPixel:=4;
         end;
   end;
   if Raw then
      cinfo.out_color_space:=JCS_YCbCr;
   case IOParams.JPEG_DCTMethod of
		ioJPEG_ISLOW: cinfo.dct_method:=JDCT_ISLOW;
      ioJPEG_IFAST: cinfo.dct_method:=JDCT_IFAST;
      ioJPEG_FLOAT: cinfo.dct_method:=JDCT_FLOAT;
   end;
   case cinfo.density_unit of
   	0,1:	// unknown or inches
      	begin
         	IOParams.DpiX:=cinfo.X_density;
            IOParams.DpiY:=cinfo.Y_density;
         end;
      2:		// centimeters
      	begin
         	IOParams.DpiX:=trunc(cinfo.X_density/2.54);
            IOParams.DpiY:=trunc(cinfo.Y_density/2.54);
         end;
	end;
   if IOParams.ColorMap<>nil then begin
   	freemem(IOParams.ColorMap);
      IOParams.fColorMap:=nil;
      IOParams.fColorMapCount:=0;
   end;
   IOParams.JPEG_Progressive:=cinfo.progressive_mode;
   IOParams.JPEG_OriginalWidth:=cinfo.image_width;
   IOParams.JPEG_OriginalHeight:=cinfo.image_height;
   cinfo.scale_num:=1;
   case IOParams.JPEG_Scale of
   	ioJPEG_FULLSIZE: cinfo.scale_denom:=1;
      ioJPEG_HALF:	  cinfo.scale_denom:=2;
      ioJPEG_QUARTER:  cinfo.scale_denom:=4;
      ioJPEG_EIGHTH:	  cinfo.scale_denom:=8;
      ioJPEG_AUTOCALC:
         begin
            // Calc from IOParams.Width and IOParmas.Height
            if (IOParams.Width>0) and (IOParams.Height>0) then begin
              bst:=0;
              for xx:=3 downto 0 do begin
                 dv:=1 shl xx;
                 if ((integer(cinfo.image_width) div dv) >= IOParams.Width) and ((integer(cinfo.image_height) div dv) >= IOParams.Height) then begin
                    bst:=xx;
                    break;
                 end;
              end;
              cinfo.scale_denom:=1 shl bst;
            end else
               cinfo.scale_denom:= 1;
         end;
   end;
   IOParams.JPEG_Scale_Used:=cinfo.scale_denom;
   //
	try
   jpeg_start_decompress(cinfo);
   except
   	xProgress.Aborting^:=true;
      exit;
   end;
   if xProgress.Aborting^ then
      exit;
   IOParams.Width:=cinfo.output_width;
   IOParams.Height:=cinfo.output_height;
   if Preview then
      exit;
   if cinfo.out_color_space=JCS_CMYK then
   	// allocate buffer for CMYK->RGB convertion
      getmem(buff,cinfo.output_width*cinfo.output_height*4);
   if cinfo.jpeg_color_space=JCS_RGB then
   	// allocate buffer for RGB->BGR convertion
      getmem(buff,cinfo.output_width*cinfo.output_height*3);
   //
   Bitmap.Allocate(cinfo.output_width,cinfo.output_height,ie24RGB);
   //
   LinesPerCall:=1;
	xProgress.per1:=100/cinfo.output_height;
   xProgress.val:=0;
   try
   tlr:=0;
   while cinfo.output_scanline<cinfo.output_height do begin
      DestScanline:=Bitmap.Scanline[tlr];
   	if cinfo.out_color_space=JCS_CMYK then begin
      	// convert CMYK->RGB
         LinesRead:=jpeg_read_scanlines(cinfo,@buff,LinesPerCall);
         if xProgress.Aborting^ then
            break;
         IEConvertColorFunction(buff,ieCMYK,DestScanline,ieBGR,cinfo.output_width-1);
      end else if cinfo.jpeg_color_space=JCS_RGB then begin
      	// convert BGR->RGB
         LinesRead:=jpeg_read_scanlines(cinfo,@buff,LinesPerCall);
         if xProgress.Aborting^ then
            break;
         yrgb:=PRGB(buff);
         xrgb:=DestScanline;
			for xx:=0 to cinfo.output_width-1 do begin
				xrgb^.b:=yrgb^.r;
            xrgb^.g:=yrgb^.g;
            xrgb^.r:=yrgb^.b;
            inc(xrgb);
            inc(yrgb);
         end;
      end else begin
	   	LinesRead:=jpeg_read_scanlines(cinfo,@DestScanline,LinesPerCall);
         (*$ifdef IEKYLIX*)
         _BGR2RGB(PRGB(DestScanline),Bitmap.Width);
         (*$endif*)
         if xProgress.Aborting^ then
            break;
      end;
      inc(tlr,LinesRead);
      // OnProgress
      with xProgress do begin
 	      inc(val,LinesRead);
	      if assigned(fOnProgress) then
   	   	fOnProgress(Sender,trunc(per1*val));
      end;
		if xProgress.Aborting^ then
      	break;
   end;
   except
   	xProgress.Aborting^:=true;
      exit;
   end;
   if tlr<integer(cinfo.output_height) then begin
   	xProgress.Aborting^:=true;
      exit;
   end;
   finally
   	// save markers to IOParams.JPEG_MarkerList
      IOParams.JPEG_MarkerList.Clear;
		markers:=cinfo.marker_list;
      xx:=0;
      while markers<>nil do begin
      	if (markers.marker<>JPEG_APP0) or (xx>0) then // this remove first APP0 (the header + RGB thumbnail)
				IOParams.JPEG_MarkerList.AddMarker(markers.marker,PAnsiChar(markers.data),markers.data_length);
         markers:=markers^.next;
         inc(xx);
      end;
      //
      if (not xProgress.Aborting^) and not Preview then begin
	      jerr.aborting:=nil; // from this point decoder can't generate aborting
         try
         jpeg_finish_decompress(cinfo);
         except
         end;
      end;
      jpeg_destroy_decompress(cinfo);
      if buff<>nil then
         freemem(buff);
      //
      if cinfo.common.err.num_warnings <> 0 then begin
         IOParams.JPEG_WarningTot := cinfo.common.err.num_warnings;
         IOParams.JPEG_WarningCode := cinfo.common.err.msg_code;
      end;
      jpeg_ie_src_free(@cinfo);
   end;
end;

/////////////////////////////////////////////////////////////////////////////////////////
// write jpeg stream
// nota: se Bitmap è pf1bit viene convertito in pf24bit
procedure WriteJPegStream(Stream:TStream; bitmap:TIEBitmap; var IOParams:TIOParamsVals; var xProgress:TProgressRec);
var
	cinfo:jpeg_compress_struct;
   jerr:jpeg_error_mgr;
   SrcScanLine:pbyte;
   buff,xbuff:PRGB;
   xrgb,yrgb:PRGB;
   xx:integer;
   LinesPerCall,LinesWritten:integer;
   FreeW:boolean;
   WBitmap:TIEBitmap;
   colspc:J_COLOR_SPACE;
  	nullpr:TProgressRec;
   tlr:integer;
begin
   with nullpr do begin
	   Aborting:=xProgress.Aborting;
      fOnProgress:=nil;
      Sender:=nil;
	end;
	// adjust Bitmap
   if Bitmap.pixelformat=ie1g then begin
	   WBitmap:=TIEBitmap.Create;
      WBitmap.Assign(Bitmap);
      WBitmap.PixelFormat:=ie24RGB; // converts to 24bit
      FreeW:=true;
   end else begin
   	WBitmap:=Bitmap;
      FreeW:=false;
   end;
   //
   buff:=nil;
   if (bitmap.Width=0) or (bitmap.Height=0) then begin
   	xProgress.Aborting^:=true;
      exit;
   end;
   jerr.aborting:=xProgress.Aborting;
	jerr:=jpeg_std_error;
   cinfo.common.err:=@jerr;
   jpeg_CreateCompress(cinfo, JPEG_LIB_VERSION, sizeof(cinfo));
   jpeg_ie_dest(@cinfo,Stream,xProgress.Aborting);
   try
	if xProgress.Aborting^ then
		exit;
   cinfo.image_width:=WBitmap.Width;
   cinfo.image_height:=WBitmap.Height;
   cinfo.input_components:=3;
   cinfo.in_color_space:=JCS_RGB;
   colspc:=JCS_RGB;
   case IOParams.JPEG_ColorSpace of
   	ioJPEG_RGB:     colspc:=JCS_RGB;
      ioJPEG_GRAYLEV: colspc:=JCS_GRAYSCALE;
      ioJPEG_YCbCr:   colspc:=JCS_YCbCr;
      ioJPEG_CMYK:
      	begin
            cinfo.in_color_space:=JCS_CMYK;
            cinfo.input_components:=4;
            colspc:=JCS_CMYK;
         end;
      ioJPEG_YCbCrK:
      	begin
            cinfo.in_color_space:=JCS_CMYK;
            cinfo.input_components:=4;
            colspc:=JCS_YCCK;
         end;
   end;
   jpeg_set_defaults(cinfo);
   jpeg_set_colorspace(cinfo,colspc);
   //
   cinfo.density_unit:=1;
   if IOParams.dpix<>0 then
	   cinfo.X_density:=IOParams.dpix
   else
   	cinfo.X_density:=gDefaultDPIX;
   if IOParams.dpiy<>0 then
	   cinfo.Y_density:=IOParams.dpiy
   else
   	cinfo.Y_density:=gDefaultDPIY;
   //
   case IOParams.JPEG_DCTMethod of
		ioJPEG_ISLOW: cinfo.dct_method:=JDCT_ISLOW;
      ioJPEG_IFAST: cinfo.dct_method:=JDCT_IFAST;
      ioJPEG_FLOAT: cinfo.dct_method:=JDCT_FLOAT;
   end;
   cinfo.optimize_coding:=IOParams.JPEG_OptimalHuffman;
   cinfo.smoothing_factor:=IOParams.JPEG_Smooth;
   jpeg_set_quality(cinfo,IOParams.JPEG_Quality,true);
   if IOParams.JPEG_Progressive then
	   jpeg_simple_progression(cinfo);
   jpeg_start_compress(cinfo,true);
   //
   with IOParams.JPEG_MarkerList do
	   for xx:=0 to Count-1 do
      	if MarkerType[xx]<>JPEG_APP14 then	// APP14 specifies the color format (not used by imageen)
				jpeg_write_marker(cinfo,MarkerType[xx],pbyte(MarkerData[xx]),MarkerLength[xx]);
   //
	LinesPerCall:=1;
	xProgress.per1:=100/cinfo.image_height;
   xProgress.val:=0;
   if cinfo.in_color_space=JCS_CMYK then
	   // allocate buffer for RGB->CMYK convertion
		getmem(buff,cinfo.image_width*cinfo.image_height*4);
   if cinfo.jpeg_color_space=JCS_RGB then
   	// allocate buffer for BGR->RGB convertion
      getmem(buff,cinfo.image_width*cinfo.image_height*3);
   xbuff:=nil;
   {$ifdef IEKYLIX}
   if cinfo.jpeg_color_space=JCS_YCbCr then
	   getmem(xbuff,cinfo.image_width*cinfo.image_height*3);
   {$endif}
   tlr:=0;
   while cinfo.next_scanline<cinfo.image_height do begin
      SrcScanline:=WBitmap.Scanline[tlr];
   	if cinfo.in_color_space=JCS_CMYK then begin
      	// converts RGB to CMYK (Params.JPEG_ColorSpace=ioJPEG_CMYK or params.JPEG_ColorSpace=ioJPEG_YCbCrK)
         IEConvertColorFunction(SrcScanline,ieBGR,buff,ieCMYK,cinfo.image_width);
			LinesWritten:=jpeg_write_scanlines(cinfo,@buff,LinesPerCall);
      end else if cinfo.jpeg_color_space=JCS_RGB then begin
      	// converts BGR to RGB (params.JPEG_ColorSpace=ioJPEG_RGB)
         yrgb:=PRGB(buff);
         xrgb:=PRGB(SrcScanline);
			for xx:=0 to cinfo.image_width-1 do begin
         	yrgb^.r:=xrgb^.b;
            yrgb^.g:=xrgb^.g;
            yrgb^.b:=xrgb^.r;
            inc(xrgb);
            inc(yrgb);
         end;
			LinesWritten:=jpeg_write_scanlines(cinfo,@buff,LinesPerCall);
      end else begin
      	// ioJPEG_RGB (Params.JPEG_ColorSpace=ioJPEG_YCbCr or Params.JPEG_ColorSpace=ioJPEG_GRAYLEV)
         {$ifdef IEDELPHI}
	   	LinesWritten:=jpeg_write_scanlines(cinfo,@SrcScanline,LinesPerCall);
         {$endif}
         {$ifdef IEKYLIX}
         _CopyBGR_RGB(PRGB(xbuff),PRGB(SrcScanline),cinfo.image_width);
			LinesWritten:=jpeg_write_scanlines(cinfo,@xbuff,LinesPerCall);
         {$endif}
      end;
      inc(tlr,LinesWritten);
      // OnProgress
      with xProgress do begin
 	      inc(val,LinesWritten);
	      if assigned(fOnProgress) then
   	   	fOnProgress(Sender,trunc(per1*val));
      end;
		if xProgress.Aborting^ then
      	break;
   end;
   if not xProgress.Aborting^ then
	   jpeg_finish_compress(cinfo);
   jpeg_destroy_compress(cinfo);
   if xbuff<>nil then
   	freemem(xbuff);
   if buff<>nil then
   	freemem(buff);
   if FreeW then
   	WBitmap.free;
   finally
   	jpeg_ie_dest_free(@cinfo);
   end;
end;

///////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////

// return >=0 if Stream contains a jpeg block (>0 is the starting position of the JFIF block)
// return -1 if the stream doesn't contains the jpeg in the first 100 bytes
// save stream position
function JpegTryStream(Stream:TStream):integer;
var
 l_Max : Integer;
 l_StSize : Int64;
var
	sp:integer;
 	SOImarker:word;			// D8FF
   bb:byte;
begin
 l_StSize := Stream.Size;
 l_Max := Max(l_StSize, 100);

 sp:=Stream.Position;
 try
   result:=sp;
   repeat
      Stream.Read(SOImarker,2);
      Stream.Read(bb,1);
      if (SOImarker=$D8FF) and (bb=$ff) then
      	break;
      inc(result);
      if (Result >= l_StSize) then
      begin
       Result := -1;
       Exit;
      end//Result >= l_StSize
      else
       Stream.Position:=result;
   until result=sp+l_Max;
   if result=sp+l_Max then result:=-1;
 finally
   Stream.Position:=sp;
 end;//try..finally  
end;

const
  M_SOF0  = $c0;
  M_SOF1  = $c1;
  M_SOF2  = $c2;
  M_SOF3  = $c3;
  M_SOF5  = $c5;
  M_SOF6  = $c6;
  M_SOF7  = $c7;
  M_JPG   = $c8;
  M_SOF9  = $c9;
  M_SOF10 = $ca;
  M_SOF11 = $cb;
  M_SOF13 = $cd;
  M_SOF14 = $ce;
  M_SOF15 = $cf;
  M_DHT   = $c4;
  M_DAC   = $cc;
  M_RST0  = $d0;
  M_RST1  = $d1;
  M_RST2  = $d2;
  M_RST3  = $d3;
  M_RST4  = $d4;
  M_RST5  = $d5;
  M_RST6  = $d6;
  M_RST7  = $d7;
  M_SOI   = $d8;
  M_EOI   = $d9;
  M_SOS   = $da;
  M_DQT   = $db;
  M_DNL   = $dc;
  M_DRI   = $dd;
  M_DHP   = $de;
  M_EXP   = $df;
  M_APP0  = $e0;
  M_APP1  = $e1;
  M_APP2  = $e2;
  M_APP3  = $e3;
  M_APP4  = $e4;
  M_APP5  = $e5;
  M_APP6  = $e6;
  M_APP7  = $e7;
  M_APP8  = $e8;
  M_APP9  = $e9;
  M_APP10 = $ea;
  M_APP11 = $eb;
  M_APP12 = $ec;
  M_APP13 = $ed;
  M_APP14 = $ee;
  M_APP15 = $ef;
  M_JPG0  = $f0;
  M_JPG1  = $f1;
  M_JPG2  = $f2;
  M_JPG3  = $f3;
  M_JPG4  = $f4;
  M_JPG5  = $f5;
  M_JPG6  = $f6;
  M_JPG7  = $f7;
  M_JPG8  = $f8;
  M_JPG9  = $f9;
  M_JPG10  = $fa;
  M_JPG11  = $fb;
  M_JPG12  = $fc;
  M_JPG13 = $fd;
  M_COM   = $fe;
  M_TEM   = $01;
  M_BYPASS= $00;

function IEJpegInjectIPTC(InputStream,OutputStream:TStream; iptc:TIEIPTCInfoList; var xProgress:TProgressRec):boolean;
var
   b1,b2:byte;
   w:word;
   abort:boolean;
   app13done,app1done:boolean;
   l:integer;
   per,lper:integer;
   //
   procedure WriteAPP13;
   var
   	b:byte;
	   buf:pointer;
	   blen:integer;
   begin
   	if not app13done then begin
         iptc.SaveToStandardBuffer(buf,blen,true);
         if blen>0 then begin
            b:=$FF; OutputStream.Write(b,1);
            b:=M_APP13; OutputStream.Write(b,1);
            w:=IESwapWord(blen+2);
            OutputStream.Write(w,2);
            OutputStream.Write(pbyte(buf)^,blen);
         end;
         if buf<>nil then
	         freemem(buf);
         app13done:=true;
      end;
   end;
   procedure WriteTag;
   begin
      OutputStream.Write(b1,1);
      OutputStream.Write(b2,1);
      InputStream.Read(w,2);
      OutputStream.Write(w,2);
      w:=IESwapWord(w);
      OutputStream.CopyFrom(InputStream,w-2);
	end;
   procedure ByPass;
   begin
      InputStream.Read(w,2);
      w:=IESwapWord(w);
      InputStream.position:=InputStream.position+w-2;
   end;
   //
begin
	lper:=-1;
	xProgress.per1:=100/(InputStream.Size-InputStream.Position);
	abort:=false;
   app1done:=false;
   app13done:=false;
   while	(not abort) and (InputStream.Read(b1,1)>0) do begin
      if b1=$FF then begin
         InputStream.Read(b2,1);
         case b2 of
         	M_APP1:
            	begin
						if app1done then
                  	ByPass
                  else
                     WriteTag;
               	//
               	WriteAPP13;
                  app1done:=true;
               end;
            M_APP13:
            	begin
               	// skip APP13
                  ByPass;
						//
                  WriteAPP13;
               end;
            M_SOF0,
            M_SOF1,
            M_SOF2,
            M_SOF3,
            M_SOF5,
            M_SOF6,
            M_SOF7,
            M_SOF9,
            M_SOF10,
            M_SOF11,
            M_SOF13,
            M_SOF14,
            M_SOF15,
            M_JPG,
            M_DHT,
            M_DAC,
            M_SOS,
            M_DQT,
            M_DNL,
            M_DRI,
            M_DHP,
            M_EXP,
            M_APP0,
            M_APP2,
            M_APP3,
            M_APP4,
            M_APP5,
            M_APP6,
            M_APP7,
            M_APP8,
            M_APP9,
            M_APP10,
            M_APP11,
            M_APP12,
            M_APP14,
            M_APP15,
            M_JPG0,M_JPG13,
            M_JPG1,M_JPG2,M_JPG3,M_JPG4,M_JPG5,M_JPG6,M_JPG7,M_JPG8,M_JPG9,M_JPG10,M_JPG11,M_JPG12,
            M_COM:
               begin
                  WriteTag;
               	if b2=M_APP0 then
                  	WriteAPP13;
               end;
            M_RST0,
            M_RST1,
            M_RST2,
            M_RST3,
            M_RST4,
            M_RST5,
            M_RST6,
            M_RST7,
         	M_BYPASS,
            M_SOI,
            M_TEM:
               begin
                  OutputStream.Write(b1,1);
                  OutputStream.Write(b2,1);
               end;
            M_EOI:
               begin
                  OutputStream.Write(b1,1);
                  OutputStream.Write(b2,1);
                  // copy rest of the file unparsed
                  l:=InputStream.Size-InputStream.Position;
                  if l>0 then
	                  OutputStream.CopyFrom(InputStream, l);
               end;
            else begin
            	abort:=true;
            end;
         end;
         // OnProgress (put here, because out of this could be very slow)
         with xProgress do begin
            per:=trunc(per1*InputStream.Position);
            if (per<>lper) and assigned(fOnProgress) then
               fOnProgress(Sender,per);
            lper:=per;
         end;
      end else begin
      	OutputStream.Write(b1,1);
      end;
	end;
   result:=(not abort) and app13done;
end;

function IEJpegInjectEXIF(InputStream,OutputStream:TStream; exif:TIOParamsVals; var xProgress:TProgressRec):boolean;
var
	per,lper:integer;
   b1,b2:byte;
   w:word;
   abort:boolean;
   app1done:boolean;
   l:integer;
   //
   procedure WriteAPP1;
   var
   	b:byte;
	   buf:pointer;
	   blen:integer;
   begin
   	if not app1done then begin
      	SaveEXIFToStandardBuffer(exif,buf,blen);
         if blen>0 then begin
            b:=$FF; OutputStream.Write(b,1);
            b:=M_APP1; OutputStream.Write(b,1);
            w:=IESwapWord(blen+2);
            OutputStream.Write(w,2);
            OutputStream.Write(pbyte(buf)^,blen);
         end;
         if buf<>nil then
	         freemem(buf);
         app1done:=true;
      end;
   end;
   procedure WriteTag;
   begin
      OutputStream.Write(b1,1);
      OutputStream.Write(b2,1);
      InputStream.Read(w,2);
      OutputStream.Write(w,2);
      w:=IESwapWord(w);
      OutputStream.CopyFrom(InputStream,w-2);
	end;
   procedure ByPass;
   begin
      InputStream.Read(w,2);
      w:=IESwapWord(w);
      InputStream.position:=InputStream.position+w-2;
   end;
   //
begin
	lper:=-1;
	xProgress.per1:=100/(InputStream.Size-InputStream.Position);
	abort:=false;
   app1done:=false;
   while	(not abort) and (InputStream.Read(b1,1)>0) do begin
      if b1=$FF then begin
         InputStream.Read(b2,1);
         case b2 of
         	M_APP1:
            	begin
               	ByPass;
               	if not app1done then
	                  WriteAPP1;
               end;
            M_SOF0,
            M_SOF1,
            M_SOF2,
            M_SOF3,
            M_SOF5,
            M_SOF6,
            M_SOF7,
            M_SOF9,
            M_SOF10,
            M_SOF11,
            M_SOF13,
            M_SOF14,
            M_SOF15,
            M_JPG,
            M_DHT,
            M_DAC,
            M_SOS,
            M_DQT,
            M_DNL,
            M_DRI,
            M_DHP,
            M_EXP,
            M_APP0,
            M_APP2,
            M_APP3,
            M_APP4,
            M_APP5,
            M_APP6,
            M_APP7,
            M_APP8,
            M_APP9,
            M_APP10,
            M_APP11,
            M_APP12,
            M_APP13,
            M_APP14,
            M_APP15,
            M_JPG0,M_JPG13,
            M_JPG1,M_JPG2,M_JPG3,M_JPG4,M_JPG5,M_JPG6,M_JPG7,M_JPG8,M_JPG9,M_JPG10,M_JPG11,M_JPG12,
            M_COM:
               begin
                  WriteTag;
               	if (b2=M_APP0) and (not app1done) then
                  	WriteAPP1;
               end;
            M_RST0,
            M_RST1,
            M_RST2,
            M_RST3,
            M_RST4,
            M_RST5,
            M_RST6,
            M_RST7,
         	M_BYPASS,
            M_SOI,
            M_TEM:
               begin
                  OutputStream.Write(b1,1);
                  OutputStream.Write(b2,1);
               end;
            M_EOI:
               begin
                  OutputStream.Write(b1,1);
                  OutputStream.Write(b2,1);
                  // copy rest of the file unparsed
                  l:=InputStream.Size-InputStream.Position;
                  if l>0 then
	                  OutputStream.CopyFrom(InputStream, l);
               end;
            else begin
            	abort:=true;
            end;
         end;
         // OnProgress (put here, because out of this could be very slow)
         with xProgress do begin
            per:=trunc(per1*InputStream.Position);
            if (per<>lper) and assigned(fOnProgress) then
               fOnProgress(Sender,per);
            lper:=per;
         end;
      end else begin
      	OutputStream.Write(b1,1);
      end;
	end;
   result:=(not abort) and app1done;
end;


(*
Transform can be:
	JXFORM_NONE 		// 0=no transformation */
   JXFORM_CUT        // cut out part of the image
	JXFORM_FLIP_H		// 2=horizontal flip */
	JXFORM_FLIP_V		// 3=vertical flip */
	JXFORM_TRANSPOSE	// 4=transpose across UL-to-LR axis */
	JXFORM_TRANSVERSE	// 5=transpose across UR-to-LL axis */
	JXFORM_ROT_90		// 6=90-degree clockwise rotation */
	JXFORM_ROT_180		// 7=180-degree rotation */
	JXFORM_ROT_270		// 8=270-degree clockwise (or 90 ccw) */
CopyMarkers can be:
	JCOPYOPT_NONE		// copy no optional markers */
	JCOPYOPT_COMMENTS	// copy only comment (COM) markers */
	JCOPYOPT_ALL		// copy all optional markers */
*)
(*$ifdef IEDELPHI*)
procedure IEJpegLosslessTransform(InStream,OutStream:TStream; var xProgress:TProgressRec; Transform:integer; GrayScale:boolean; CopyMarkers:integer; CutRect:TRect);
var
	srcinfo:jpeg_decompress_struct;
   dstinfo:jpeg_compress_struct;
   jerr:jpeg_error_mgr;
   spos:integer;
   transformoption:jpeg_transform_info;
   src_coef_arrays,dst_coef_arrays:pointer;
   copyoption:JCOPY_OPTION;
begin
   fillchar(transformoption,sizeof(jpeg_transform_info),0);
	copyoption:=CopyMarkers;
   spos:=JpegTryStream(InStream);
   if spos=-1 then begin
   	xProgress.Aborting^:=true;
      exit;
   end;
   InStream.Position:=spos;
	try
	jerr:=jpeg_std_error;
   jerr.aborting:=xProgress.Aborting;
	srcinfo.common.err:=@jerr;
   dstinfo.common.err:=@jerr;
   jpeg_CreateDecompress(srcinfo, JPEG_LIB_VERSION, sizeof(srcinfo));
   jpeg_ie_src(@srcinfo,InStream,xProgress.Aborting);
   jpeg_CreateCompress(dstinfo, JPEG_LIB_VERSION, sizeof(dstinfo));
   jpeg_ie_dest(@dstinfo,OutStream,xProgress.Aborting);
   if xProgress.Aborting^ then exit;
   try
   //jpeg_simple_progression(dstinfo);
   jcopy_markers_setup(srcinfo,copyoption);
   jpeg_read_header(srcinfo, TRUE);
   transformoption.transform:=Transform;
   transformoption.trim := 1;
   transformoption.force_grayscale := ord(GrayScale);
   transformoption.xoffs:=CutRect.Left;
   transformoption.yoffs:=CutRect.Top;
   transformoption.newwidth:=CutRect.Right-CutRect.Left+1;
   transformoption.newheight:=CutRect.Bottom-CutRect.Top+1;
   jtransform_request_workspace(srcinfo, transformoption);
   src_coef_arrays := jpeg_read_coefficients(srcinfo);
   jpeg_copy_critical_parameters(srcinfo, dstinfo);
   dst_coef_arrays := jtransform_adjust_parameters(srcinfo, dstinfo,src_coef_arrays,transformoption);
   jpeg_write_coefficients(dstinfo, dst_coef_arrays);
   jcopy_markers_execute(srcinfo, dstinfo, copyoption);
   jtransform_execute_transformation(srcinfo, dstinfo,src_coef_arrays,transformoption);
   jpeg_finish_compress(dstinfo);
   jpeg_destroy_compress(dstinfo);
   jpeg_finish_decompress(srcinfo);
	jpeg_destroy_decompress(srcinfo);
   except
   	xProgress.Aborting^:=true;
      exit;
   end;
   if xProgress.Aborting^ then
      exit;
   finally
      jpeg_ie_src_free(@srcinfo);
      jpeg_ie_dest_free(@dstinfo);
   end;
end;
(*$endif*)



end.
