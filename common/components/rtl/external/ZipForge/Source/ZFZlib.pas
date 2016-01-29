
// ZLib 1.2.3 (modified by ComponentAce to add 64-bit stream support)

{*******************************************************}

 {       Borland Delphi Supplemental Components          }
 {       ZLIB Data Compression Interface Unit            }

{       Copyright (c) 1997,99 Inprise Corporation       }

{*******************************************************}

{ Modified for zlib 1.1.4 by Davide Moretti <dave@rimini.com }

 { (09/20/99) Ryan Mills. <rmills@freenet.edmonton.ab.ca>     }
 { Further modified to be more compatible with the D5 version }
 { of the ZLIB component, integrating the speed enhancements  }
 { introduced by Borland.                                     }

unit ZFZlib;

{$I ZFVer.Inc}
{$I CompilerDefines.inc}

interface

uses SysUtils, Classes;

resourcestring
  sTargetBufferTooSmall = 'ZLib error: target buffer may be too small';
  sInvalidStreamOp      = 'Invalid stream operation';


type
  TAlloc = function(AppData: Pointer; Items, Size: integer): Pointer; register;
  TFree = procedure(AppData, Block: Pointer); register;
  {$IFDEF D6H}
  {$ELSE}
  PByte = ^Byte;
  {$ENDIF}


  // Internal structure.  Ignore.
  TZStreamRec = packed record
    next_in:  PByte;       // next input byte
    avail_in: integer;     // number of bytes available at next_in
    total_in: int64;       // total nb of input bytes read so far

    next_out:  PByte;      // next output byte should be put here
    avail_out: integer;    // remaining free space at next_out
    total_out: int64;      // total nb of bytes output so far

    msg:      PChar;           // last error message, NULL if no error
    internal: Pointer;         // not visible by applications

    zalloc:  TAlloc;        // used to allocate the internal state
    zfree:   TFree;         // used to free the internal state
    AppData: Pointer;       // private data object passed to zalloc and zfree

    data_type: integer;       //  best guess about the data type: ascii or binary
    adler:     integer;       // adler32 value of the uncompressed data
    reserved:  integer;       // reserved for future use
  end;


{ CompressBuf compresses data, buffer to buffer, in one call.
   In: InBuf = ptr to compressed data
       InBytes = number of bytes in InBuf
  Out: OutBuf = ptr to newly allocated buffer containing decompressed data
       OutBytes = number of bytes in OutBuf   }
procedure ZLIBCompressBuf(const InBuf: Pointer;
  InBytes: integer; out OutBuf: Pointer;
  out OutBytes: integer; compMode: byte = 1);


{ DecompressBuf decompresses data, buffer to buffer, in one call.
   In: InBuf = ptr to compressed data
       InBytes = number of bytes in InBuf
       OutEstimate = zero, or est. size of the decompressed data
  Out: OutBuf = ptr to newly allocated buffer containing decompressed data
       OutBytes = number of bytes in OutBuf   }
procedure ZLIBDecompressBuf(const InBuf: Pointer; InBytes: integer;
  OutEstimate: integer; out OutBuf: Pointer; out OutBytes: integer);


const
  zlib_version = '1.2.3';

type
  EZlibError = class(Exception);
  ECompressionError = class(EZlibError);
  EDecompressionError = class(EZlibError);

{$IFNDEF BCB4}
function adler32(adler: cardinal; buf: PAnsiChar; len: integer): cardinal;
{$ENDIF}

function CCheck(code: integer): integer;
function DCheck(code: integer): integer;

{** deflate routines ********************************************************}

function deflateInit_(var strm: TZStreamRec; level: integer; version: PAnsiChar;
  recsize: integer): integer;
  external;

function deflateInit2_(var strm: TZStreamRec;
  level, method, windowBits, memLevel, strategy: integer; version: PAnsiChar;
  recsize: integer): integer;
  external;

function deflate(var strm: TZStreamRec; flush: integer): integer;
  external;

function deflateEnd(var strm: TZStreamRec): integer;
  external;

{** inflate routines ********************************************************}

function inflateInit_(var strm: TZStreamRec; version: PAnsiChar; recsize: integer): integer;
  external;

function inflateInit2_(var strm: TZStreamRec; windowBits: integer;
  version: PAnsiChar; recsize: integer): integer;
  external;

function inflate(var strm: TZStreamRec; flush: integer): integer;
  external;

function inflateEnd(var strm: TZStreamRec): integer;
  external;

function inflateReset(var strm: TZStreamRec): integer;
  external;


const
  Z_NO_FLUSH = 0;
  Z_PARTIAL_FLUSH = 1;
  Z_SYNC_FLUSH = 2;
  Z_FULL_FLUSH = 3;
  Z_FINISH = 4;

  Z_OK    = 0;
  Z_STREAM_END = 1;
  Z_NEED_DICT = 2;
  Z_ERRNO = (-1);
  Z_STREAM_ERROR = (-2);
  Z_DATA_ERROR = (-3);
  Z_MEM_ERROR = (-4);
  Z_BUF_ERROR = (-5);
  Z_VERSION_ERROR = (-6);

  Z_NO_COMPRESSION = 0;
  Z_BEST_SPEED     = 1;
  Z_BEST_COMPRESSION = 9;
  Z_DEFAULT_COMPRESSION = (-1);

  Z_FILTERED     = 1;
  Z_HUFFMAN_ONLY = 2;
  Z_DEFAULT_STRATEGY = 0;

  Z_BINARY  = 0;
  Z_ASCII   = 1;
  Z_UNKNOWN = 2;

  Z_DEFLATED = 8;

implementation



const
  Levels: array [0..3] of shortint =
    (Z_NO_COMPRESSION, Z_BEST_SPEED, Z_DEFAULT_COMPRESSION, Z_BEST_COMPRESSION);

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

{** link zlib code **********************************************************}

{$L zlib\deflate.obj}
{$L zlib\inflate.obj}
{$L zlib\inftrees.obj}
{$L zlib\infback.obj}
{$L zlib\inffast.obj}
{$L zlib\trees.obj}
{$L zlib\compress.obj}
{$L zlib\adler32.obj}
{$L zlib\crc32.obj}

procedure _tr_init; external;
procedure _tr_tally; external;
procedure _tr_flush_block; external;
procedure _tr_align; external;
procedure _tr_stored_block; external;
{$IFDEF BD5}
  function adler32; external;
{$ENDIF}
{$IFDEF BCB5}
  function adler32; external;
{$ELSE}
  {$IFDEF BD4}
    procedure adler32; external;
  {$ENDIF}
  {$IFDEF BCB4}
    procedure adler32; external;
  {$ENDIF}
{$ENDIF}

procedure _memset(P: Pointer; B: byte; Count: integer); cdecl;
begin
  FillChar(P^, Count, B);
end;

procedure _memcpy(dest, Source: Pointer; Count: integer); cdecl;
begin
  Move(Source^, dest^, Count);
end;

function zcAlloc(AppData: Pointer; Items, Size: integer): Pointer; register;
begin
  Result := AllocMem(Items * Size);
end;

procedure zcFree(AppData, Block: Pointer); register;
begin
  FreeMem(Block);
end;

function CCheck(code: integer): integer;
begin
  Result := code;
  if code < 0 then
    raise ECompressionError.Create('error'); //!!
end;

function DCheck(code: integer): integer;
begin
  Result := code;
  if code < 0 then
    raise EDecompressionError.Create('error');  //!!
end;

procedure ZLIBCompressBuf(const InBuf: Pointer; InBytes: integer;
  out OutBuf: Pointer; out OutBytes: integer;
  compMode: byte = 1);
var
  strm: TZStreamRec;
  P:    Pointer;
begin
  FillChar(strm, sizeof(strm), 0);
  strm.zalloc := zcAlloc;
  strm.zfree  := zcFree;
  OutBytes    := ((InBytes + (InBytes div 10) + 12) + 255) and not 255;
  //  GetMem(OutBuf, OutBytes);
  OutBuf      := AllocMem(OutBytes);
  try
    strm.next_in   := InBuf;
    strm.avail_in  := InBytes;
    strm.next_out  := OutBuf;
    strm.avail_out := OutBytes;
    CCheck(deflateInit_(strm, compMode, zlib_version, sizeof(strm)));
    try
      while CCheck(deflate(strm, Z_FINISH)) <> Z_STREAM_END do
      begin
        P := OutBuf;
        Inc(OutBytes, 256);
        ReallocMem(OutBuf, OutBytes);
        strm.next_out  := PByte(integer(OutBuf) + (integer(strm.next_out) - integer(P)));
        strm.avail_out := 256;
      end;
    finally
      CCheck(deflateEnd(strm));
    end;
    ReallocMem(OutBuf, strm.total_out);
    OutBytes := strm.total_out;
  except
    FreeMem(OutBuf);
    raise
  end;
end;


procedure ZLIBDecompressBuf(const InBuf: Pointer; InBytes: integer;
  OutEstimate: integer; out OutBuf: Pointer; out OutBytes: integer);
label
  m_exit;
var
  zstream: TZStreamRec;
  delta: integer;
  x: integer;
begin
  FillChar(zstream, SizeOf(TZStreamRec), 0);

  delta := (InBytes + 255) and not 255;

  if outEstimate = 0 then
    outBytes := delta
  else
    outBytes := outEstimate;

  GetMem(outBuf, outBytes);

  //  try
  zstream.next_in   := inBuf;
  zstream.avail_in  := InBytes;
  zstream.next_out  := outBuf;
  zstream.avail_out := outBytes;

  //    DCheck(InflateInit_(zstream,zlib_version,sizeof(zstream)));
  if (InflateInit_(zstream, zlib_version, sizeof(zstream)) < 0) then
    goto m_exit;

  //    try
  while (True) do
  begin
    //      DCheck(inflate(zstream,Z_NO_FLUSH)) <> Z_STREAM_END
    x := inflate(zstream, Z_NO_FLUSH);
    if (x < 0) then
      goto m_exit;

    if (x = Z_STREAM_END) then
      break;

    Inc(outBytes, delta);
    ReallocMem(outBuf, outBytes);

    zstream.next_out  := PByte(integer(outBuf) + zstream.total_out);
    zstream.avail_out := delta;
  end; // while
       //    finally
       //      DCheck(inflateEnd(zstream));
  if (inflateEnd(zstream) < 0) then
    goto m_exit;
  //    end;

  ReallocMem(outBuf, zstream.total_out);
  outBytes := zstream.total_out;
  Exit;

  m_exit:
    inflateEnd(zstream);
  // error
  //  except
  if (outBuf <> nil) then
    FreeMem(outBuf);
  outBuf   := nil;
  outBytes := 0;
  //    raise;
  //  end;
end;


end.
